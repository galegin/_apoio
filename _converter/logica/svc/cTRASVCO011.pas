unit cTRASVCO011;

interface

(* COMPONENTES 
  CTCSVCO005 / FCRSVCO068 / FCRSVCO112 / GERSVCO031 / GERSVCO058

*)        

uses
  Classes, SysUtils, Math, DB,
  cDataSetUnf;

type
  T_TRASVCO011 = class(TComponent)
  private
    tF_FGR_LIQ,
    tF_FGR_LIQITEM,
    tFCC_MOV,
    tFCP_DUPIMPOST,
    tFCP_DUPLICATI,
    tFCR_FATURAI,
    tFGR_LIQ,
    tFGR_LIQITEMCC,
    tFGR_LIQITEMCR,
    tGER_OPERACAO,
    tTRA_TRANSACAO : TcDatasetUnf;
    function getParam(pParams : String = '') : String;
    function setEntidade(pParams : String = '') : String;
  protected
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;    
  published
    function gravaLiqTransacao(pParams : String = '') : String;
    function cancelaLiqTransacao(pParams : String = '') : String;
  end;

implementation

uses
  cADMSVCO001,
  cActivate, cStatus, cFuncao, cXml, dModulo;

var
  gVlReceber,
  gVlRecebido : String;

//---------------------------------------------------------------
constructor T_TRASVCO011.Create(AOwner: TComponent);
//---------------------------------------------------------------
begin
  inherited Create(AOwner);
  setEntidade('');
end;

//--------------------------------
destructor T_TRASVCO011.Destroy;
//--------------------------------
begin
  inherited Destroy;
end;

//---------------------------------------------------------------
function T_TRASVCO011.getParam(pParams : String = '') : String;
//---------------------------------------------------------------
var
  piCdEmpresa : Real;
begin
  piCdEmpresa := itemXmlF('CD_EMPRESA', pParams);
  if (piCdEmpresa = 0) then begin
    piCdEmpresa := itemXmlF('CD_EMPRESA', PARAM_GLB);
  end;

  (*
  xParam := '';
  putitem(xParam, 'IN_USA_COND_PGTO_ESPECIAL');
  xParam := T_ADMSVCO001.GetParametro(xParam);

  gUsaCondPgtoEspecial := itemXmlB('IN_USA_COND_PGTO_ESPECIAL', xParam);

  xParamEmp := '';
  putitem(xParamEmp, 'VL_MINIMO_PARCELA');
  xParamEmp := T_ADMSVCO001.GetParamEmpresa(piCdEmpresa, xParamEmp);

  gVlMinimoParcela := itemXmlF('VL_MINIMO_PARCELA', xParamEmp);  
  *)

  xParam := '';

  xParam := T_ADMSVCO001.GetParametro(xParam);


  xParamEmp := '';

  xParamEmp := T_ADMSVCO001.GetParamEmpresa(piCdEmpresa, xParamEmp);


end;

//---------------------------------------------------------------
function T_TRASVCO011.setEntidade(pParams : String = '') : String;
//---------------------------------------------------------------
begin
  tF_FGR_LIQ := TcDatasetUnf.getEntidade('F_FGR_LIQ');
  tF_FGR_LIQITEM := TcDatasetUnf.getEntidade('F_FGR_LIQITEM');
  tFCC_MOV := TcDatasetUnf.getEntidade('FCC_MOV');
  tFCP_DUPIMPOST := TcDatasetUnf.getEntidade('FCP_DUPIMPOST');
  tFCP_DUPLICATI := TcDatasetUnf.getEntidade('FCP_DUPLICATI');
  tFCR_FATURAI := TcDatasetUnf.getEntidade('FCR_FATURAI');
  tFGR_LIQ := TcDatasetUnf.getEntidade('FGR_LIQ');
  tFGR_LIQITEMCC := TcDatasetUnf.getEntidade('FGR_LIQITEMCC');
  tFGR_LIQITEMCR := TcDatasetUnf.getEntidade('FGR_LIQITEMCR');
  tGER_OPERACAO := TcDatasetUnf.getEntidade('GER_OPERACAO');
  tTRA_TRANSACAO := TcDatasetUnf.getEntidade('TRA_TRANSACAO');
end;

//-----------------------------------------------------------------
function T_TRASVCO011.gravaLiqTransacao(pParams : String) : String;
//-----------------------------------------------------------------
const
  cDS_METHOD = 'ADICONAL=Operação: T_TRASVCO011.gravaLiqTransacao()';
var
  vDsRegistro, vDsLstTransacao, vDsLstFatura, vDsLstMovCC, vDsLstDuplicata : String;
  viParams, voParams : String;
  vCdEmpresa, vNrTransacao, vNrSeqLiq, vNrCtaPesCx, vNrSeqHistRelSub : Real;
  vCdCliente, vNrFat, vNrParcela, vNrSeq, vNrCtaPesMov, vNrSeqMov : Real;
  vCdFornecedor, vNrDuplicata, vCdPessoa, vTpChequePresente : Real;
  vNrCtaPes, vCdEmpresaChe, vCdClienteChe, vNrCheque, vVlCheque : Real;
  vDtTransacao, vDtSistema, vDtMovim : TDate;
  vInCompra : Boolean;
begin
  vCdPessoa := itemXmlF('CD_PESSOA', pParams);
  vDsLstTransacao := itemXml('DS_LSTTRANSACAO', pParams);
  vDsLstFatura := itemXml('DS_LSTFATURA', pParams);
  vDsLstDuplicata := itemXml('DS_LSTDUPLICATA', pParams);
  vDsLstMovCC := itemXml('DS_LSTMOVCC', pParams);
  vDtSistema := itemXml('DT_SISTEMA', PARAM_GLB);

  gVlReceber := itemXmlF('VL_RECEBER', pParams);

  vTpChequePresente := itemXmlF('TP_CHEQUEPRESENTE', pParams);
  gVlRecebido := 0;

  if (vDsLstTransacao = '') then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Lista de transação não informada!', cDS_METHOD);
    return(-1); exit;
  end;
  if (vCdPessoa = 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Pessoa não informada!', cDS_METHOD);
    return(-1); exit;
  end;

  clear_e(tTRA_TRANSACAO);
  clear_e(tFCR_FATURAI);
  clear_e(tFCC_MOV);

  vInCompra := False;

  repeat
    getitem(vDsRegistro, vDsLstTransacao, 1);
    vCdEmpresa := itemXmlF('CD_EMPRESA', vDsRegistro);
    vNrTransacao := itemXmlF('NR_TRANSACAO', vDsRegistro);
    vDtTransacao := itemXml('DT_TRANSACAO', vDsRegistro);

    if (vCdEmpresa = 0) then begin
      Result := SetStatus(STS_ERROR, 'GEN0001', 'Empresa da transação não informada!', cDS_METHOD);
      return(-1); exit;
    end;
    if (vNrTransacao = 0) then begin
      Result := SetStatus(STS_ERROR, 'GEN0001', 'Número da transação não informado!', cDS_METHOD);
      return(-1); exit;
    end;
    if (vDtTransacao = '') then begin
      Result := SetStatus(STS_ERROR, 'GEN0001', 'Data da transação não informada!', cDS_METHOD);
      return(-1); exit;
    end;

    creocc(tTRA_TRANSACAO, -1);
    putitem_e(tTRA_TRANSACAO, 'CD_EMPRESA', vCdEmpresa);
    putitem_e(tTRA_TRANSACAO, 'NR_TRANSACAO', vNrTransacao);
    putitem_e(tTRA_TRANSACAO, 'DT_TRANSACAO', vDtTransacao);
    retrieve_o(tTRA_TRANSACAO);
    if (xStatus = -7) then begin
      retrieve_x(tTRA_TRANSACAO);
      if (item_f('TP_OPERACAO', tTRA_TRANSACAO) = 'E')  and (item_f('TP_MODALIDADE', tGER_OPERACAO) = 1 ) or (item_f('TP_MODALIDADE', tGER_OPERACAO) = 2 ) or (item_f('TP_MODALIDADE', tGER_OPERACAO) = 4 ) or (item_f('TP_MODALIDADE', tGER_OPERACAO) = 5 ) or (item_f('TP_MODALIDADE', tGER_OPERACAO) = 'E') then begin
        vInCompra := True;
      end;
    end else if (xStatus = 0) then begin
      Result := SetStatus(STS_ERROR, 'GEN0001', 'Transação ' + FloatToStr(vNrTransacao) + ' não cadastrada!', cDS_METHOD);
      return(-1); exit;
    end;

    delitem(vDsLstTransacao, 1);
  until (vDsLstTransacao = '');

  if (vInCompra = True)  and (totocc(tTRA_TRANSACAO) > 1) then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', , cDS_METHOD);
    return(-1); exit;
  end;

  setocc(tTRA_TRANSACAO, 1);

  if (item_f('TP_MODALIDADE', tGER_OPERACAO) = 3) then begin
    if (vDsLstMovCC = '') then begin
      Result := SetStatus(STS_ERROR, 'GEN0001', 'Lista de movimentação não informada!', cDS_METHOD);
      return(-1); exit;
    end;
  end else if (vInCompra = True) then begin
    if (vDsLstDuplicata = '') then begin
      Result := SetStatus(STS_ERROR, 'GEN0001', 'Lista de duplicata não informada!', cDS_METHOD);
      return(-1); exit;
    end;
  end else begin
    if (vDsLstFatura = '') then begin
      Result := SetStatus(STS_ERROR, 'GEN0001', 'Lista de fatura não informada!', cDS_METHOD);
      return(-1); exit;
    end;
  end;
  if (vDsLstFatura <> '') then begin
    repeat
      getitem(vDsRegistro, vDsLstFatura, 1);
      vCdEmpresa := itemXmlF('CD_EMPRESA', vDsRegistro);
      vCdCliente := itemXmlF('CD_CLIENTE', vDsRegistro);
      vNrFat := itemXmlF('NR_FAT', vDsRegistro);
      vNrParcela := itemXmlF('NR_PARCELA', vDsRegistro);
      vNrCtaPesCx := itemXmlF('NR_CTAPESCX', vDsRegistro);
      vNrSeqHistRelSub := itemXmlF('NR_SEQHISTRELSUB', vDsRegistro);

      vNrCtaPes := itemXmlF('NR_CTAPES', vDsRegistro);
      vCdEmpresaChe := itemXmlF('CD_EMPRESACHE', vDsRegistro);
      vCdClienteChe := itemXmlF('CD_CLIENTECHE', vDsRegistro);
      vNrCheque := itemXmlF('NR_CHEQUE', vDsRegistro);
      vVlCheque := itemXmlF('VL_CHEQUE', vDsRegistro);

      if (vCdEmpresa = 0) then begin
        Result := SetStatus(STS_ERROR, 'GEN0001', 'Empresa da fatura não informada!', cDS_METHOD);
        return(-1); exit;
      end;
      if (vCdCliente = 0) then begin
        Result := SetStatus(STS_ERROR, 'GEN0001', 'Cliente da faturada não informado!', cDS_METHOD);
        return(-1); exit;
      end;
      if (vNrFat = 0) then begin
        Result := SetStatus(STS_ERROR, 'GEN0001', 'Número da fatura não informado!', cDS_METHOD);
        return(-1); exit;
      end;
      if (vNrParcela = 0) then begin
        Result := SetStatus(STS_ERROR, 'GEN0001', 'Parcela da fatura não informado!', cDS_METHOD);
        return(-1); exit;
      end;
      if (vNrCtaPesCx = 0) then begin
        Result := SetStatus(STS_ERROR, 'GEN0001', 'Conta corrente do usuário não informada!', cDS_METHOD);
        return(-1); exit;
      end;

      creocc(tFCR_FATURAI, -1);
      putitem_e(tFCR_FATURAI, 'CD_EMPRESA', vCdEmpresa);
      putitem_e(tFCR_FATURAI, 'CD_CLIENTE', vCdCliente);
      putitem_e(tFCR_FATURAI, 'NR_FAT', vNrFat);
      putitem_e(tFCR_FATURAI, 'NR_PARCELA', vNrParcela);
      retrieve_o(tFCR_FATURAI);
      if (xStatus = -7) then begin
        retrieve_x(tFCR_FATURAI);
        if (item_f('TP_DOCUMENTO', tFCR_FATURAI) = 4 ) or (item_f('TP_DOCUMENTO', tFCR_FATURAI) = 5) then begin
          if (vNrSeqHistRelSub = 0) then begin
            Result := SetStatus(STS_ERROR, 'GEN0001', 'Histórico auxiliar de parcelamento não informado!', cDS_METHOD);
            return(-1); exit;
          end;
        end;
        putitem_e(tFCR_FATURAI, 'NR_CTAPESCX', vNrCtaPesCx);
        putitem_e(tFCR_FATURAI, 'NR_SEQHISTRELSUB', vNrSeqHistRelSub);
        putitem_e(tFCR_FATURAI, 'NR_CTAPES', vNrCtaPes);
        putitem_e(tFCR_FATURAI, 'CD_EMPRESACHE', vCdEmpresaChe);
        putitem_e(tFCR_FATURAI, 'CD_CLIENTECHE', vCdClienteChe);
        putitem_e(tFCR_FATURAI, 'NR_CHEQUE', vNrCheque);
        putitem_e(tFCR_FATURAI, 'VL_CHEQUE', vVlCheque);

      end else if (xStatus = 0) then begin
        Result := SetStatus(STS_ERROR, 'GEN0001', 'Fatura ' + FloatToStr(vNrFat) + ' não cadastrada!', cDS_METHOD);
        return(-1); exit;
      end;

      delitem(vDsLstFatura, 1);
    until (vDsLstFatura = '');

    setocc(tFCR_FATURAI, 1);
  end;
  if (vDsLstMovCC <> '') then begin
    repeat
      getitem(vDsRegistro, vDsLstMovCC, 1);
      vNrCtaPesMov := itemXmlF('NR_CTAPES', vDsRegistro);
      vDtMovim := itemXml('DT_MOVIM', vDsRegistro);
      vNrSeqMov := itemXmlF('NR_SEQMOV', vDsRegistro);

      if (vNrCtaPesMov = 0) then begin
        Result := SetStatus(STS_ERROR, 'GEN0001', 'Conta da movimentação não informada!', cDS_METHOD);
        return(-1); exit;
      end;
      if (vDtMovim = '') then begin
        Result := SetStatus(STS_ERROR, 'GEN0001', 'Data da movimentação não informada!', cDS_METHOD);
        return(-1); exit;
      end;
      if (vNrSeqMov = 0) then begin
        Result := SetStatus(STS_ERROR, 'GEN0001', 'Sequência da movimentação não informada!', cDS_METHOD);
        return(-1); exit;
      end;

      creocc(tFCC_MOV, -1);
      putitem_e(tFCC_MOV, 'NR_CTAPES', vNrCtaPesMov);
      putitem_e(tFCC_MOV, 'DT_MOVIM', vDtMovim);
      putitem_e(tFCC_MOV, 'NR_SEQMOV', vNrSeqMov);
      retrieve_o(tFCC_MOV);
      if (xStatus = -7) then begin
        retrieve_x(tFCC_MOV);
      end else if (xStatus = 0) then begin
        Result := SetStatus(STS_ERROR, 'GEN0001', 'Movimentação ' + item_a('NR_CTAPES', tFCC_MOV) + ' / ' + item_a('DT_MOVIM', tFCC_MOV) + ' / ' + item_a('NR_SEQMOV', tFCC_MOV) + ' não cadastrada!', cDS_METHOD);
        return(-1); exit;
      end;

      delitem(vDsLstMovCC, 1);
    until (vDsLstMovCC = '');

    setocc(tFCC_MOV, 1);
  end;
  if (vDsLstDuplicata <> '') then begin
    repeat
      getitem(vDsRegistro, vDsLstDuplicata, 1);
      vCdEmpresa := itemXmlF('CD_EMPRESA', vDsRegistro);
      vCdFornecedor := itemXmlF('CD_FORNECEDOR', vDsRegistro);
      vNrDuplicata := itemXmlF('NR_DUPLICATA', vDsRegistro);
      vNrParcela := itemXmlF('NR_PARCELA', vDsRegistro);

      if (vCdEmpresa = 0) then begin
        Result := SetStatus(STS_ERROR, 'GEN0001', 'Empresa da duplicata não informada!', cDS_METHOD);
        return(-1); exit;
      end;
      if (vCdFornecedor = 0) then begin
        Result := SetStatus(STS_ERROR, 'GEN0001', 'Fornecedor da duplicata não informado!', cDS_METHOD);
        return(-1); exit;
      end;
      if (vNrDuplicata = 0) then begin
        Result := SetStatus(STS_ERROR, 'GEN0001', 'Número da duplicata não informado!', cDS_METHOD);
        return(-1); exit;
      end;
      if (vNrParcela = 0) then begin
        Result := SetStatus(STS_ERROR, 'GEN0001', 'Parcela da duplicata não informado!', cDS_METHOD);
        return(-1); exit;
      end;

      creocc(tFCP_DUPLICATI, -1);
      putitem_e(tFCP_DUPLICATI, 'CD_EMPRESA', vCdEmpresa);
      putitem_e(tFCP_DUPLICATI, 'CD_FORNECEDOR', vCdFornecedor);
      putitem_e(tFCP_DUPLICATI, 'NR_DUPLICATA', vNrDuplicata);
      putitem_e(tFCP_DUPLICATI, 'NR_PARCELA', vNrParcela);
      retrieve_o(tFCP_DUPLICATI);
      if (xStatus = -7) then begin
        retrieve_x(tFCP_DUPLICATI);
      end else if (xStatus = 0) then begin
        Result := SetStatus(STS_ERROR, 'GEN0001', 'Duplicata ' + FloatToStr(vNrDuplicata) + ' não cadastrada!', cDS_METHOD);
        return(-1); exit;
      end;

      delitem(vDsLstDuplicata, 1);
    until (vDsLstDuplicata = '');
  end;

  viParams := '';
  putitemXml(viParams, 'NM_ENTIDADE', 'FGR_LIQ');
  voParams := activateCmp('GERSVCO031', 'getNumSeq', viParams);
  if (xStatus < 0) then begin
    Result := voParams;
    return(-1); exit;
  end;

  vNrSeqLiq := itemXmlF('NR_SEQUENCIA', voParams);

  clear_e(tFGR_LIQ);
  creocc(tFGR_LIQ, -1);
  putitem_e(tFGR_LIQ, 'CD_EMPLIQ', item_f('CD_EMPFAT', tTRA_TRANSACAO));
  putitem_e(tFGR_LIQ, 'CD_GRUPOEMPRESA', item_f('CD_GRUPOEMPRESA', tTRA_TRANSACAO));
  putitem_e(tFGR_LIQ, 'CD_PESSOA', vCdPessoa);
  putitem_e(tFGR_LIQ, 'DT_LIQ', vDtSistema);
  putitem_e(tFGR_LIQ, 'NR_SEQLIQ', vNrSeqLiq);
  if (vInCompra = True) then begin
    putitem_e(tFGR_LIQ, 'TP_LIQUIDACAO', 19);
  end else begin
    if (item_f('TP_MODALIDADE', tGER_OPERACAO) = 3) then begin
      putitem_e(tFGR_LIQ, 'TP_LIQUIDACAO', 17);
    end else begin
      putitem_e(tFGR_LIQ, 'TP_LIQUIDACAO', 5);
    end;
  end;

  vNrSeq := 0;

  if (vInCompra = True) then begin
    if (gVlReceber = 0) then begin
      gVlReceber := item_f('VL_TOTAL', tTRA_TRANSACAO);
    end;
    if (empty(tFCP_DUPLICATI) = False) then begin
      setocc(tFCP_DUPLICATI, 1);
      while (xStatus >= 0) do begin
        vNrSeq := vNrSeq + 1;
        creocc(tFGR_LIQITEMCC, -1);
        putitem_e(tFGR_LIQITEMCC, 'NR_SEQITEM', vNrSeq);
        putitem_e(tFGR_LIQITEMCC, 'CD_EMPRESADUP', item_f('CD_EMPRESA', tFCP_DUPLICATI));
        putitem_e(tFGR_LIQITEMCC, 'CD_FORNECDUP', item_f('CD_FORNECEDOR', tFCP_DUPLICATI));
        putitem_e(tFGR_LIQITEMCC, 'NR_DUPLICATADUP', item_f('NR_DUPLICATA', tFCP_DUPLICATI));
        putitem_e(tFGR_LIQITEMCC, 'NR_PARCELADUP', item_f('NR_PARCELA', tFCP_DUPLICATI));
        gVlRecebido := gVlRecebido + item_f('VL_DUPLICATA', tFCP_DUPLICATI);
        putitem_e(tFGR_LIQITEMCC, 'CD_EMPTRANSACAO', item_f('CD_EMPRESA', tTRA_TRANSACAO));
        putitem_e(tFGR_LIQITEMCC, 'NR_TRANSACAO', item_f('NR_TRANSACAO', tTRA_TRANSACAO));
        putitem_e(tFGR_LIQITEMCC, 'DT_TRANSACAO', item_a('DT_TRANSACAO', tTRA_TRANSACAO));
        putitem_e(tFGR_LIQITEMCC, 'CD_OPERADOR', itemXmlF('CD_USUARIO', PARAM_GLB));
        putitem_e(tFGR_LIQITEMCC, 'DT_CADASTRO', Now);
        setocc(tFCP_DUPLICATI, curocc(tFCP_DUPLICATI) + 1);
      end;
    end;
  end else begin
    setocc(tTRA_TRANSACAO, 1);
    while (xStatus >= 0) do begin

      clear_e(tF_FGR_LIQITEM);
      putitem_e(tF_FGR_LIQITEM, 'TP_TIPOREG', 1);
      putitem_e(tF_FGR_LIQITEM, 'CD_EMPTRANSACAO', item_f('CD_EMPRESA', tTRA_TRANSACAO));
      putitem_e(tF_FGR_LIQITEM, 'NR_TRANSACAO', item_f('NR_TRANSACAO', tTRA_TRANSACAO));
      putitem_e(tF_FGR_LIQITEM, 'DT_TRANSACAO', item_a('DT_TRANSACAO', tTRA_TRANSACAO));
      retrieve_e(tF_FGR_LIQITEM);
      if (xStatus >=0) then begin
        clear_e(tF_FGR_LIQ);
        putitem_e(tF_FGR_LIQ, 'CD_EMPLIQ', item_f('CD_EMPLIQ', tF_FGR_LIQITEM));
        putitem_e(tF_FGR_LIQ, 'DT_LIQ', item_a('DT_LIQ', tF_FGR_LIQITEM));
        putitem_e(tF_FGR_LIQ, 'NR_SEQLIQ', item_f('NR_SEQLIQ', tF_FGR_LIQITEM));
        retrieve_e(tF_FGR_LIQ);
        if (xStatus >=0)  and (item_a('DT_CANCELAMENTO', tF_FGR_LIQ) = '') then begin
          Result := SetStatus(STS_ERROR, 'GEN0001', 'Já existe uma liquidação gravada para esta transação: ' + item_a('NR_TRANSACAO', tTRA_TRANSACAO) + ' !', cDS_METHOD);
          return(-1); exit;
        end;
      end;

      vNrSeq := vNrSeq + 1;
      creocc(tFGR_LIQITEMCR, -1);
      putitem_e(tFGR_LIQITEMCR, 'NR_SEQITEM', vNrSeq);
      putitem_e(tFGR_LIQITEMCR, 'TP_TIPOREG', 1);
      putitem_e(tFGR_LIQITEMCR, 'CD_EMPTRANSACAO', item_f('CD_EMPRESA', tTRA_TRANSACAO));
      putitem_e(tFGR_LIQITEMCR, 'NR_TRANSACAO', item_f('NR_TRANSACAO', tTRA_TRANSACAO));
      putitem_e(tFGR_LIQITEMCR, 'DT_TRANSACAO', item_a('DT_TRANSACAO', tTRA_TRANSACAO));
      putitem_e(tFGR_LIQITEMCR, 'CD_OPERADOR', itemXmlF('CD_USUARIO', PARAM_GLB));
      putitem_e(tFGR_LIQITEMCR, 'DT_CADASTRO', Now);
      putitem_e(tFGR_LIQ, 'VL_TOTAL', item_f('VL_TOTAL', tFGR_LIQ) + item_f('VL_TOTAL', tTRA_TRANSACAO));

      viParams := '';
      putitemXml(viParams, 'CD_EMPRESA', item_f('CD_EMPRESA', tTRA_TRANSACAO));
      putitemXml(viParams, 'NR_TRANSACAO', item_f('NR_TRANSACAO', tTRA_TRANSACAO));
      putitemXml(viParams, 'DT_TRANSACAO', item_a('DT_TRANSACAO', tTRA_TRANSACAO));
      voParams := activateCmp('GERSVCO058', 'buscaValorFinanceiroTransacao', viParams);
      if (xStatus < 0) then begin
        Result := voParams;
        return(-1); exit;
      end;

      putitem_e(tTRA_TRANSACAO, 'VL_TOTAL', itemXmlF('VL_FINANCEIRO', voParams));
      gVlReceber := gVlReceber + item_f('VL_TOTAL', tTRA_TRANSACAO);

      setocc(tTRA_TRANSACAO, curocc(tTRA_TRANSACAO) + 1);
    end;
    if (empty(tFCC_MOV) = False) then begin
      setocc(tFCC_MOV, 1);
      while (xStatus >= 0) do begin
        vNrSeq := vNrSeq + 1;
        creocc(tFGR_LIQITEMCR, -1);
        putitem_e(tFGR_LIQITEMCR, 'NR_SEQITEM', vNrSeq);
        if (item_f('TP_MODALIDADE', tGER_OPERACAO) = 3) then begin
          putitem_e(tFGR_LIQITEMCR, 'TP_TIPOREG', 2);
          gVlRecebido := gVlRecebido + item_f('VL_LANCTO', tFCC_MOV);
        end else begin
          putitem_e(tFGR_LIQITEMCR, 'TP_TIPOREG', 1);
          putitem_e(tFGR_LIQ, 'VL_TOTAL', item_f('VL_TOTAL', tFGR_LIQ) + item_f('VL_LANCTO', tFCC_MOV));
          gVlReceber := gVlReceber + item_f('VL_LANCTO', tFCC_MOV);
        end;
        putitem_e(tFGR_LIQITEMCR, 'NR_CTAPESFCC', item_f('NR_CTAPES', tFCC_MOV));
        putitem_e(tFGR_LIQITEMCR, 'DT_MOVIMFCC', item_a('DT_MOVIM', tFCC_MOV));
        putitem_e(tFGR_LIQITEMCR, 'NR_SEQMOVFCC', item_f('NR_SEQMOV', tFCC_MOV));
        putitem_e(tFGR_LIQITEMCR, 'CD_OPERADOR', itemXmlF('CD_USUARIO', PARAM_GLB));
        putitem_e(tFGR_LIQITEMCR, 'DT_CADASTRO', Now);

        setocc(tFCC_MOV, curocc(tFCC_MOV) + 1);
      end;
    end;
    if (empty(tFCR_FATURAI) = False) then begin
      setocc(tFCR_FATURAI, 1);
      while (xStatus >= 0) do begin
        vNrSeq := vNrSeq + 1;

        creocc(tFGR_LIQITEMCR, -1);
        putitem_e(tFGR_LIQITEMCR, 'NR_SEQITEM', vNrSeq);
        putitem_e(tFGR_LIQITEMCR, 'TP_TIPOREG', 2);
        putitem_e(tFGR_LIQITEMCR, 'CD_EMPFAT', item_f('CD_EMPRESA', tFCR_FATURAI));
        putitem_e(tFGR_LIQITEMCR, 'CD_CLIENTE', item_f('CD_CLIENTE', tFCR_FATURAI));
        putitem_e(tFGR_LIQITEMCR, 'NR_FAT', item_f('NR_FAT', tFCR_FATURAI));
        putitem_e(tFGR_LIQITEMCR, 'NR_PARCELA', item_f('NR_PARCELA', tFCR_FATURAI));
        putitem_e(tFGR_LIQITEMCR, 'NR_CTAPESCX', item_f('NR_CTAPESCX', tFCR_FATURAI));
        putitem_e(tFGR_LIQITEMCR, 'TP_DOCUMENTO', item_f('TP_DOCUMENTO', tFCR_FATURAI));
        putitem_e(tFGR_LIQITEMCR, 'NR_SEQHISTRELSUB', item_f('NR_SEQHISTRELSUB', tFCR_FATURAI));
        if (item_f('TP_DOCUMENTO', tFCR_FATURAI) = 9) then begin
          gVlRecebido := gVlRecebido - item_f('VL_FATURA', tFCR_FATURAI);
        end else begin
          gVlRecebido := gVlRecebido + item_f('VL_FATURA', tFCR_FATURAI);
        end;
        putitem_e(tFGR_LIQITEMCR, 'CD_OPERADOR', itemXmlF('CD_USUARIO', PARAM_GLB));
        putitem_e(tFGR_LIQITEMCR, 'DT_CADASTRO', Now);

        viParams := '';
        putitemXml(viParams, 'CD_EMPLIQ', item_f('CD_EMPLIQ', tFGR_LIQ));
        putitemXml(viParams, 'DT_LIQ', item_a('DT_LIQ', tFGR_LIQ));
        putitemXml(viParams, 'NR_SEQLIQ', item_f('NR_SEQLIQ', tFGR_LIQ));
        putitemXml(viParams, 'CD_EMPRESA', item_f('CD_EMPRESA', tFCR_FATURAI));
        putitemXml(viParams, 'CD_CLIENTE', item_f('CD_CLIENTE', tFCR_FATURAI));
        putitemXml(viParams, 'NR_FAT', item_f('NR_FAT', tFCR_FATURAI));
        putitemXml(viParams, 'NR_PARCELA', item_f('NR_PARCELA', tFCR_FATURAI));
        voParams := activateCmp('FCRSVCO112', 'gravarLiqFaturaVenda', viParams);
        if (xStatus < 0) then begin
          Result := voParams;
          return(-1); exit;
        end;

        setocc(tFCR_FATURAI, curocc(tFCR_FATURAI) + 1);
      end;
    end;
  end;
  if (gVlRecebido <> gVlReceber) then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Valor recebido ' + FloatToStr(gVlRecebido) + ' da liquidação diferente do valor a receber ' + FloatToStr(gVlReceber!',) + ' cDS_METHOD);
    return(-1); exit;
  end;

  putitem_e(tFGR_LIQ, 'CD_OPERADOR', itemXmlF('CD_USUARIO', PARAM_GLB));
  putitem_e(tFGR_LIQ, 'DT_CADASTRO', Now);

  voParams := tFGR_LIQ.Salvar();
  if (xStatus < 0) then begin
    Result := voParams;
    return(-1); exit;
  end;

  setocc(tFCR_FATURAI, 1);
  if (item_f('CD_EMPRESA', tFCR_FATURAI) <> '')  and (item_f('CD_CLIENTE', tFCR_FATURAI) <> '')  and (item_f('NR_FAT', tFCR_FATURAI) <> '')  and (item_f('NR_PARCELA', tFCR_FATURAI) <> '') then begin
    while (xStatus >= 0) do begin
      clear_e(tFGR_LIQITEMCR);
      putitem_e(tFGR_LIQITEMCR, 'CD_EMPFAT', item_f('CD_EMPRESA', tFCR_FATURAI));
      putitem_e(tFGR_LIQITEMCR, 'CD_CLIENTE', item_f('CD_CLIENTE', tFCR_FATURAI));
      putitem_e(tFGR_LIQITEMCR, 'NR_FAT', item_f('NR_FAT', tFCR_FATURAI));
      putitem_e(tFGR_LIQITEMCR, 'NR_PARCELA', item_f('NR_PARCELA', tFCR_FATURAI));
      retrieve_e(tFGR_LIQITEMCR);
      if (xStatus >= 0) then begin
        if (vTpChequePresente = 1) then begin
          if (item_f('TP_DOCUMENTO', tFGR_LIQITEMCR) = 18) then begin
            vNrSeq := vNrSeq + 1;
            viParams := '';
            putitemXml(viParams, 'CD_EMPRESA', item_f('CD_EMPRESACHE', tFCR_FATURAI));
            putitemXml(viParams, 'CD_CLIENTE', item_f('CD_CLIENTECHE', tFCR_FATURAI));
            putitemXml(viParams, 'NR_CHEQUE', item_f('NR_CHEQUE', tFCR_FATURAI));
            putitemXml(viParams, 'VL_CHEQUE', item_f('VL_CHEQUE', tFCR_FATURAI));
            putitemXml(viParams, 'CD_EMPLIQ', item_f('CD_EMPLIQ', tFGR_LIQ));
            putitemXml(viParams, 'DT_LIQ', item_a('DT_LIQ', tFGR_LIQ));
            putitemXml(viParams, 'NR_SEQLIQ', item_f('NR_SEQLIQ', tFGR_LIQ));
            putitemXml(viParams, 'NR_SEQITEM', item_f('NR_SEQITEM', tFGR_LIQITEMCR));
            putitemXml(viParams, 'NR_SEQATUAL', vNrSeq);
            putitemXml(viParams, 'TP_LIQ', 3);
            putitemXml(viParams, 'NR_CTAPES', item_f('NR_CTAPES', tFCR_FATURAI));
            voParams := activateCmp('FCRSVCO068', 'gravarMovimentacaoCartaoPresente', viParams);
            if (xStatus < 0) then begin
              Result := voParams;
              return(-1); exit;
            end;
            voParams := tFGR_LIQ.Salvar();
            if (xStatus < 0) then begin
              Result := voParams;
              return(-1); exit;
            end;
          end;
        end;

        viParams := '';
        if (vTpChequePresente <> 1)  or (item_f('TP_DOCUMENTO', tFGR_LIQITEMCR) <> 18) then begin
          putitemXml(viParams, 'CD_EMPLIQ', item_f('CD_EMPLIQ', tFGR_LIQITEMCR));
          putitemXml(viParams, 'DT_LIQ', item_a('DT_LIQ', tFGR_LIQITEMCR));
          putitemXml(viParams, 'NR_SEQLIQ', item_f('NR_SEQLIQ', tFGR_LIQITEMCR));
          putitemXml(viParams, 'NR_SEQITEM', item_f('NR_SEQITEM', tFGR_LIQITEMCR));
          putitemXml(viParams, 'CD_EMPFAT', item_f('CD_EMPFAT', tFGR_LIQITEMCR));
          putitemXml(viParams, 'CD_CLIENTE', item_f('CD_CLIENTE', tFGR_LIQITEMCR));
          putitemXml(viParams, 'NR_FAT', item_f('NR_FAT', tFGR_LIQITEMCR));
          putitemXml(viParams, 'NR_PARCELA', item_f('NR_PARCELA', tFGR_LIQITEMCR));
          if (xStatus < 0) then begin
            Result := voParams;
            return(-1); exit;
          end;
        end;
      end;

      setocc(tFCR_FATURAI, curocc(tFCR_FATURAI) + 1);
    end;
  end;

  vDsLstDuplicata := itemXml('DS_LSTDUPLICATA', pParams);
  if (vDsLstDuplicata <> '') then begin
    repeat
      vDsRegistro := '';
      getitem(vDsRegistro, vDsLstDuplicata, 1);
      vCdEmpresa := itemXmlF('CD_EMPRESA', vDsRegistro);
      vCdFornecedor := itemXmlF('CD_FORNECEDOR', vDsRegistro);
      vNrDuplicata := itemXmlF('NR_DUPLICATA', vDsRegistro);
      vNrParcela := itemXmlF('NR_PARCELA', vDsRegistro);

      if (vCdEmpresa = 0) then begin
        Result := SetStatus(STS_ERROR, 'GEN001', 'Empresa da duplicata não informada!', cDS_METHOD);
        return(-1); exit;
      end;
      if (vCdFornecedor = 0) then begin
        Result := SetStatus(STS_ERROR, 'GEN001', 'Fornecedor da duplicata não informado!', cDS_METHOD);
        return(-1); exit;
      end;
      if (vNrDuplicata = 0) then begin
        Result := SetStatus(STS_ERROR, 'GEN001', 'Número da duplicata não informado!', cDS_METHOD);
        return(-1); exit;
      end;
      if (vNrParcela = 0) then begin
        Result := SetStatus(STS_ERROR, 'GEN001', 'Parcela da duplicata não informada!', cDS_METHOD);
        return(-1); exit;
      end;

      clear_e(tFCP_DUPIMPOST);
      putitem_e(tFCP_DUPIMPOST, 'CD_EMPRESA', vCdEmpresa);
      putitem_e(tFCP_DUPIMPOST, 'CD_FORNECEDOR', vCdFornecedor);
      putitem_e(tFCP_DUPIMPOST, 'NR_DUPLICATA', vNrDuplicata);
      putitem_e(tFCP_DUPIMPOST, 'NR_PARCELA', vNrParcela);
      putitem_e(tFCP_DUPIMPOST, 'TP_SITUACAO', 1);
      retrieve_e(tFCP_DUPIMPOST);
      if (xStatus >= 0) then begin
        setocc(tFCP_DUPIMPOST, 1);
        while (xStatus >= 0) do begin
          putitem_e(tFCP_DUPIMPOST, 'CD_EMPLIQ', item_f('CD_EMPLIQ', tFGR_LIQ));
          putitem_e(tFCP_DUPIMPOST, 'DT_LIQ', item_a('DT_LIQ', tFGR_LIQ));
          putitem_e(tFCP_DUPIMPOST, 'NR_SEQLIQ', item_f('NR_SEQLIQ', tFGR_LIQ));

          setocc(tFCP_DUPIMPOST, curocc(tFCP_DUPIMPOST) + 1);
        end;
      end;

      voParams := tFCP_DUPIMPOST.Salvar();
      if (xStatus < 0) then begin
        Result := voParams;
        return(-1); exit;
      end;

      delitem(vDsLstDuplicata, 1);
    until (vDsLstDuplicata = '');
  end;

  viParams := '';
  putitemXml(viParams, 'CD_EMPLIQ', item_f('CD_EMPLIQ', tFGR_LIQ));
  putitemXml(viParams, 'DT_LIQ', item_a('DT_LIQ', tFGR_LIQ));
  putitemXml(viParams, 'NR_SEQLIQ', item_f('NR_SEQLIQ', tFGR_LIQ));
  voParams := activateCmp('CTCSVCO005', 'gravarBonusLiqFat', viParams);
  if (xStatus < 0) then begin
    Result := SetStatus(STS_ERROR, xProcerror, xProcerrorcontext, '');
    return(-1); exit;
  end;

  Result := '';
  putitemXml(Result, 'CD_EMPLIQ', item_f('CD_EMPLIQ', tFGR_LIQ));
  putitemXml(Result, 'DT_LIQ', item_a('DT_LIQ', tFGR_LIQ));
  putitemXml(Result, 'NR_SEQLIQ', item_f('NR_SEQLIQ', tFGR_LIQ));

  return(0); exit;
end;

//-------------------------------------------------------------------
function T_TRASVCO011.cancelaLiqTransacao(pParams : String) : String;
//-------------------------------------------------------------------
const
  cDS_METHOD = 'ADICONAL=Operação: T_TRASVCO011.cancelaLiqTransacao()';
var
  vDtLiq : TDate;
  vCdEmpLiq, vNrSeqLiq : Real;
begin
  vCdEmpLiq := itemXmlF('CD_EMPLIQ', pParams);
  vDtLiq := itemXml('DT_LIQ', pParams);
  vNrSeqLiq := itemXmlF('NR_SEQLIQ', pParams);

  if (vCdEmpLiq = 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Empresa não informada!', cDS_METHOD);
    return(-1); exit;
  end;
  if (vDtLiq = '') then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Dt. liquidação não informada!', cDS_METHOD);
    return(-1); exit;
  end;
  if (vNrSeqLiq = 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Nr. liquidação não informado!', cDS_METHOD);
    return(-1); exit;
  end;

  clear_e(tFGR_LIQ);
  putitem_e(tFGR_LIQ, 'CD_EMPLIQ', vCdEmpLiq);
  putitem_e(tFGR_LIQ, 'DT_LIQ', vDtLiq);
  putitem_e(tFGR_LIQ, 'NR_SEQLIQ', vNrSeqLiq);
  retrieve_e(tFGR_LIQ);
  if (xStatus < 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Liquidação ' + FloatToStr(vNrSeqLiq) + ' não cadastrada!', cDS_METHOD);
    return(-1); exit;
  end;

  putitem_e(tFGR_LIQ, 'DT_CANCELAMENTO', Date);
  putitem_e(tFGR_LIQ, 'CD_OPERCANCEL', itemXmlF('CD_USUARIO', PARAM_GLB));

  voParams := tFGR_LIQ.Salvar();
  if (xStatus < 0) then begin
    Result := voParams;
    return(-1); exit;
  end;

  return(0); exit;
end;

end.
