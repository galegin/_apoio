unit cFISSVCO028;

interface

(* COMPONENTES 
  ADMSVCO001 / FISSVCO024 / TRASVCO004 / TRASVCO016 / TRASVCO024

*)        

uses
  Classes, SysUtils, DB,
  cServiceUnf, cDataSetUnf;

type
  T_FISSVCO028 = class(TcServiceUnf)
  private
    tFIS_NF,
    tFIS_NFIDEVT,
    tGER_OPERACAO,
    tPES_PESSOA,
    tTMP_NR09,
    tTRA_TRANSACAO : TcDatasetUnf;
    function getParam(pParams : String = '') : String;
    function setEntidade(pParams : String = '') : String;
  protected
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;    
  published
    function geraDevolucao(pParams : String = '') : String;
    function cancelaDevolucaoTransacao(pParams : String = '') : String;
  end;

implementation

uses
  cADMSVCO001,
  cActivate, cStatus, cFuncao, cXml, dModulo;

var
  gCdCondPgtoPDV,
  gCdVendedorPDV,
  gDsLstValor : String;

//---------------------------------------------------------------
constructor T_FISSVCO028.Create(AOwner: TComponent);
//---------------------------------------------------------------
begin
  inherited Create(AOwner);
  setEntidade('');
end;

//--------------------------------
destructor T_FISSVCO028.Destroy;
//--------------------------------
begin
  inherited Destroy;
end;

//---------------------------------------------------------------
function T_FISSVCO028.getParam(pParams : String = '') : String;
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
  putitem(xParam, 'CONDPGTO_PDV');
  putitem(xParam, 'VendEDOR_PDV');

  xParam := T_ADMSVCO001.GetParametro(xParam);

  gCdCondPgtoPDV := itemXml('CONDPGTO_PDV', xParam);
  gCdVendedorPDV := itemXml('VendEDOR_PDV', xParam);
  gDsLstValor := itemXml('DS_LST_VLR_PED_COMPRA', xParam);

  xParamEmp := '';
  putitem(xParamEmp, 'CONDPGTO_PDV');
  putitem(xParamEmp, 'DS_LST_VLR_PED_COMPRA');
  putitem(xParamEmp, 'VendEDOR_PDV');

  xParamEmp := T_ADMSVCO001.GetParamEmpresa(piCdEmpresa, xParamEmp);

  gDsLstValor := itemXml('DS_LST_VLR_PED_COMPRA', xParamEmp);

end;

//---------------------------------------------------------------
function T_FISSVCO028.setEntidade(pParams : String = '') : String;
//---------------------------------------------------------------
begin
  tFIS_NF := GetEntidade('FIS_NF');
  tFIS_NFIDEVT := GetEntidade('FIS_NFIDEVT');
  tGER_OPERACAO := GetEntidade('GER_OPERACAO');
  tPES_PESSOA := GetEntidade('PES_PESSOA');
  tTMP_NR09 := GetEntidade('TMP_NR09');
  tTRA_TRANSACAO := GetEntidade('TRA_TRANSACAO');
end;

//-------------------------------------------------------------
function T_FISSVCO028.geraDevolucao(pParams : String) : String;
//-------------------------------------------------------------
const
  cDS_METHOD = 'ADICIONAL=Operação: T_FISSVCO028.geraDevolucao()';
var
  vCdPessoa, vCdOperacao, vCdProduto, vNrTransacao, vQtItem, vVlUnitLiquido, vQtNF : Real;
  vNrItem, vNrFatura, vCdEmpresa, vCdEmpTransacao, vTpDevolucao, vNrSequencia : Real;
  vDsLstItensNF, vDsListaItens, vDsItem, viParams, voParams, vDsLstDev, vDsItemDev : String;
  vDsLinha, vDsRegistro, vDsLstTransacao, vCdCSTAux, vCdCFOPAux, vDsLstItemLote, vDsListaRef, vDsItemRef : String;
  vDtFatura, vDtTransacao : TDate;
  vInRefNF, vInSemMovimento : Boolean;
begin
  PARAM_GLB := PARAM_GLB;

  getParams(pParams); (* itemXmlF('CD_EMPRESA', PARAM_GLB), 'geraDevolucao' *)
  if (xStatus < 0) then begin
    return(-1); exit;
  end;

  vCdPessoa := itemXmlF('CD_PESSOA', pParams);
  vCdOperacao := itemXmlF('CD_OPERACAO', pParams);
  vDsLstItensNF := itemXml('DS_LSTITENSNF', pParams);
  vCdEmpTransacao := itemXmlF('CD_EMPTRANSACAO', pParams);
  vNrTransacao := itemXmlF('NR_TRANSACAO', pParams);
  vDtTransacao := itemXml('DT_TRANSACAO', pParams);
  vTpDevolucao := itemXmlF('TP_DEVOLUCAO', pParams);
  vInRefNF := itemXmlB('IN_REFNF', pParams);

  vInSemMovimento := itemXmlB('IN_SEMMOVIMENTO', pParams);

  clear_e(tTMP_NR09);

  if (vTpDevolucao = 0) then begin
    vTpDevolucao := 01;
  end;
  if (vInRefNF = '') then begin
    vInRefNF := True;
  end;
  if (vDsLstItensNF = '') then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Itens da N.F. não informado!', cDS_METHOD);
    return(-1); exit;
  end;
  if (vNrTransacao > 0) then begin
    clear_e(tTRA_TRANSACAO);
    putitem_e(tTRA_TRANSACAO, 'CD_EMPRESA', vCdEmpTransacao);
    putitem_e(tTRA_TRANSACAO, 'DT_TRANSACAO', vDtTransacao);
    putitem_e(tTRA_TRANSACAO, 'NR_TRANSACAO', vNrTransacao);
    retrieve_e(tTRA_TRANSACAO);
    if (xStatus < 0) then begin
      Result := SetStatus(STS_ERROR, 'GEN0001', 'Transação ' + FloatToStr(vCdEmpTransacao) + ' / ' + FloatToStr(vNrTransacao) + ' / ' + vDtTransacao + ' não cadastrada!', cDS_METHOD);
      return(-1); exit;
    end;

    clear_e(tPES_PESSOA);
    putitem_e(tPES_PESSOA, 'CD_PESSOA', item_f('CD_PESSOA', tTRA_TRANSACAO));
    retrieve_e(tPES_PESSOA);
    if (xStatus < 0) then begin
      Result := SetStatus(STS_ERROR, 'GEN0001', 'Pessoa ' + FloatToStr(vCdPessoa) + ' não encontrada!', cDS_METHOD);
      return(-1); exit;
    end;

    clear_e(tGER_OPERACAO);
    putitem_e(tGER_OPERACAO, 'CD_OPERACAO', item_f('CD_OPERACAO', tTRA_TRANSACAO));
    retrieve_e(tGER_OPERACAO);
    if (xStatus < 0) then begin
      Result := SetStatus(STS_ERROR, 'GEN0001', 'Operação ' + FloatToStr(vCdOperacao) + ' não cadastrada!', cDS_METHOD);
      return(-1); exit;
    end else if (item_f('TP_OPERACAO', tGER_OPERACAO) <> 'S') then begin
      Result := SetStatus(STS_ERROR, 'GEN0001', 'Operação ' + FloatToStr(vCdOperacao) + ' necessita ser de SAIDA!', cDS_METHOD);
      return(-1); exit;
    end;
  end else begin
    if (vCdPessoa = '') then begin
      Result := SetStatus(STS_ERROR, 'GEN0001', 'Código da pessoa não informado!', cDS_METHOD);
      return(-1); exit;
    end else begin
      clear_e(tPES_PESSOA);
      putitem_e(tPES_PESSOA, 'CD_PESSOA', vCdPessoa);
      retrieve_e(tPES_PESSOA);
      if (xStatus < 0) then begin
        Result := SetStatus(STS_ERROR, 'GEN0001', 'Pessoa ' + FloatToStr(vCdPessoa) + ' não encontrada!', cDS_METHOD);
        return(-1); exit;
      end;
    end;
    if (vCdOperacao = '') then begin
      Result := SetStatus(STS_ERROR, 'GEN0001', 'Operação não informada!', cDS_METHOD);
      return(-1); exit;
    end else begin
      clear_e(tGER_OPERACAO);
      putitem_e(tGER_OPERACAO, 'CD_OPERACAO', vCdOperacao);
      retrieve_e(tGER_OPERACAO);
      if (xStatus < 0) then begin
        Result := SetStatus(STS_ERROR, 'GEN0001', 'Operação ' + FloatToStr(vCdOperacao) + ' não cadastrada!', cDS_METHOD);
        return(-1); exit;
      end else if (item_f('TP_OPERACAO', tGER_OPERACAO) <> 'S') then begin
        Result := SetStatus(STS_ERROR, 'GEN0001', 'Operação ' + FloatToStr(vCdOperacao) + ' necessita ser de SAIDA!', cDS_METHOD);
        return(-1); exit;
      end;
    end;

    clear_e(tTRA_TRANSACAO);
    creocc(tTRA_TRANSACAO, -1);
    putitem_e(tTRA_TRANSACAO, 'CD_EMPRESA', itemXmlF('CD_EMPRESA', PARAM_GLB));
    putitem_e(tTRA_TRANSACAO, 'DT_TRANSACAO', itemXml('DT_SISTEMA', PARAM_GLB));
    putitem_e(tTRA_TRANSACAO, 'NR_TRANSACAO', '');
    putitem_e(tTRA_TRANSACAO, 'CD_PESSOA', vCdPessoa);
    putitem_e(tTRA_TRANSACAO, 'CD_OPERACAO', vCdOperacao);
    putitem_e(tTRA_TRANSACAO, 'CD_CONDPGTO', gCdCondPgtoPDV);
    putitem_e(tTRA_TRANSACAO, 'CD_COMPVEND', gCdVendedorPDV);
    putitem_e(tTRA_TRANSACAO, 'TP_ORIGEMEMISSAO', 1);

    viParams := '';
    putlistitensocc_e(viParams, tTRA_TRANSACAO);
    voParams := activateCmp('TRASVCO004', 'gravaCapaTransacao', viParams); (*,,,, *)
    if (xStatus < 0) then begin
      Result := voParams;
      return(-1); exit;
    end;

    vNrTransacao := itemXmlF('NR_TRANSACAO', voParams);

    clear_e(tTRA_TRANSACAO);
    putitem_e(tTRA_TRANSACAO, 'CD_EMPRESA', itemXmlF('CD_EMPRESA', PARAM_GLB));
    putitem_e(tTRA_TRANSACAO, 'DT_TRANSACAO', itemXml('DT_SISTEMA', PARAM_GLB));
    putitem_e(tTRA_TRANSACAO, 'NR_TRANSACAO', vNrTransacao);
    retrieve_e(tTRA_TRANSACAO);
  end;

  vCdCSTAux := '';
  vCdCFOPAux := '';
  vDsListaRef := '';

  vDsListaItens := vDsLstItensNF;
  while (vDsListaItens <> '') do begin
    getitem(vDsItem, vDsListaItens, 1);

    vCdEmpresa := itemXmlF('CD_EMPRESA', vDsItem);
    vNrFatura := itemXmlF('NR_FATURA', vDsItem);
    vDtFatura := itemXml('DT_FATURA', vDsItem);
    vNrItem := itemXmlF('NR_ITEM', vDsItem);
    vCdProduto := itemXmlF('CD_PRODUTO', vDsItem);
    vQtItem := itemXmlF('QT_DEVOLUCAO', vDsItem);
    vVlUnitLiquido := itemXmlF('VL_UNITLIQUIDO', vDsItem);
    vDsLstItemLote := itemXml('DS_LSTITEMLOTE', vDsItem);

    vDsItem := itemXml('DS_ITEM', vDsItem);

    if (vDsItem = '') then begin
      if (vCdEmpresa = '') then begin
        Result := SetStatus(STS_ERROR, 'GEN0001', 'Empresa não informada para a devolução.', cDS_METHOD);
        return(-1); exit;
      end;
      if (vNrFatura = '') then begin
        Result := SetStatus(STS_ERROR, 'GEN0001', 'Número da fatura não informado para a devolução.', cDS_METHOD);
        return(-1); exit;
      end;
      if (vDtFatura = '') then begin
        Result := SetStatus(STS_ERROR, 'GEN0001', 'Data da fatura número ' + FloatToStr(vNrFatura) + ' empresa ' + FloatToStr(vCdEmpresa) + ' não informada para a devolução.', cDS_METHOD);
        return(-1); exit;
      end;
      if (vNrItem = '') then begin
        Result := SetStatus(STS_ERROR, 'GEN0001', 'Item da fatura nº ' + FloatToStr(vNrFatura,) + ' data %vDtFatura, empresa ' + FloatToStr(vCdEmpresa) + ' não informado para a devolução.', cDS_METHOD);
        return(-1); exit;
      end;
      if (vCdProduto = '') then begin
        Result := SetStatus(STS_ERROR, 'GEN0001', 'Produto do item ' + FloatToStr(vNrItem) + ' da fatura nº ' + FloatToStr(vNrFatura,) + ' data %vDtFatura, empresa ' + FloatToStr(vCdEmpresa) + ' não informado para a devolução.', cDS_METHOD);
        return(-1); exit;
      end;
      if (vQtItem = '') then begin
        Result := SetStatus(STS_ERROR, 'GEN0001', 'Quantidade do produto ' + FloatToStr(vCdProduto) + ' não informado para a devolução.', cDS_METHOD);
        return(-1); exit;
      end;
      if (vVlUnitLiquido = '') then begin
        Result := SetStatus(STS_ERROR, 'GEN0001', 'Valor unitario do produto ' + FloatToStr(vCdProduto) + ' não informado para a devolução.', cDS_METHOD);
        return(-1); exit;
      end;

      viParams := '';
      putitemXml(viParams, 'CD_EMPRESA', itemXmlF('CD_EMPRESA', PARAM_GLB));
      putitemXml(viParams, 'NR_TRANSACAO', vNrTransacao);
      putitemXml(viParams, 'DT_TRANSACAO', itemXml('DT_SISTEMA', PARAM_GLB));
      putitemXml(viParams, 'CD_BARRAPRD', vCdProduto);
      putitemXml(viParams, 'IN_CODIGO', True);
      putitemXml(viParams, 'QT_SOLICITADA', vQtItem);
      putitemXml(viParams, 'VL_BRUTO', vVlUnitLiquido);
      putitemXml(viParams, 'VL_LIQUIDO', vVlUnitLiquido);
      voParams := activateCmp('TRASVCO004', 'validaItemTransacao', viParams); (*,,,, *)
      if (xStatus < 0) then begin
        Result := voParams;
        return(-1); exit;
      end;
      vCdCSTAux := itemXmlF('CD_CST', voParams);
      vCdCFOPAux := itemXmlF('CD_CFOP', voParams);
    end else begin

      putitemXml(voParams, 'CD_SEQGRUPO', 0);
      putitemXml(voParams, 'CD_PRODUTO', 0);
      putitemXml(voParams, 'DS_PRODUTO', vDsItem);
      putitemXml(voParams, 'CD_CST', vCdCSTAux);
      putitemXml(voParams, 'CD_CFOP', vCdCFOPAux);
      putitemXml(voParams, 'IN_TOTAL', False);
      putitemXml(voParams, 'DS_LSTIMPOSTO', '');
    end;

    viParams := voParams;
    putitemXml(viParams, 'CD_EMPRESA', itemXmlF('CD_EMPRESA', PARAM_GLB));
    putitemXml(viParams, 'NR_TRANSACAO', vNrTransacao);
    putitemXml(viParams, 'DT_TRANSACAO', itemXml('DT_SISTEMA', PARAM_GLB));
    putitemXml(viParams, 'DS_LSTITEMLOTE', vDsLstItemLote);
    if (vInSemMovimento) then begin
      putitemXml(viParams, 'IN_SEMMOVIMENTO', True);
    end;

    voParams := activateCmp('TRASVCO004', 'gravaItemTransacao', viParams); (*,,,, *)
    if (xStatus < 0) then begin
      Result := voParams;
      return(-1); exit;
    end;
    if (vDsItem = '') then begin
      clear_e(tFIS_NF);
      putitem_e(tFIS_NF, 'CD_EMPRESA', vCdEmpresa);
      putitem_e(tFIS_NF, 'NR_FATURA', vNrFatura);
      putitem_e(tFIS_NF, 'DT_FATURA', vDtFatura);
      retrieve_e(tFIS_NF);
      if (xStatus >= 0) then begin
        if (item_f('NR_NF', tFIS_NF) > 0) then begin
          creocc(tTMP_NR09, -1);
          putitem_e(tTMP_NR09, 'NR_GERAL', item_f('NR_NF', tFIS_NF));
          retrieve_o(tTMP_NR09);
          if (xStatus = -7) then begin
            retrieve_x(tTMP_NR09);
          end;
          putitem_e(tTMP_NR09, 'DT_EMISSAO', item_a('DT_EMISSAO', tFIS_NF));
        end;
      end;

      vDsLstDev := '';
      clear_e(tFIS_NFIDEVT);
      putitem_e(tFIS_NFIDEVT, 'CD_EMPRESA', vCdEmpresa);
      putitem_e(tFIS_NFIDEVT, 'NR_FATURA', vNrFatura);
      putitem_e(tFIS_NFIDEVT, 'DT_FATURA', vDtFatura);
      putitem_e(tFIS_NFIDEVT, 'NR_ITEM', vNrItem);
      putitem_e(tFIS_NFIDEVT, 'CD_PRODUTO', vCdProduto);
      retrieve_e(tFIS_NFIDEVT);
      if (xStatus >= 0) then begin
        sort_e(tFIS_NFIDEVT, '        sort/e , NR_SEQUENCIA;');
        setocc(tFIS_NFIDEVT, 1);
        while (xStatus >= 0) do begin
          putlistitensocc_e(vDsItemDev, tFIS_NFIDEVT);
          putitem(vDsLstDev,  vDsItemDev);
          setocc(tFIS_NFIDEVT, curocc(tFIS_NFIDEVT) + 1);
        end;
        vNrSequencia := item_f('NR_SEQUENCIA', tFIS_NFIDEVT) + 1;
      end else begin
        vNrSequencia := 1;
      end;

      vDsItemDev := '';
      putitemXml(vDsItem, 'NR_SEQUENCIA', vNrSequencia);
      putitemXml(vDsItem, 'CD_EMPDCTO', itemXmlF('CD_EMPRESA', PARAM_GLB));
      putitemXml(vDsItem, 'NR_DCTO', vNrTransacao);
      putitemXml(vDsItem, 'DT_DCTO', itemXml('DT_SISTEMA', PARAM_GLB));
      putitemXml(vDsItem, 'TP_DCTO', 1);
      putitemXml(vDsItem, 'DT_DEVOLUCAO', itemXml('DT_SISTEMA', PARAM_GLB));
      putitemXml(vDsItem, 'TP_DEVOLUCAO', vTpDevolucao);
      putitemXml(vDsItem, 'QT_DEVOLUCAO', vQtItem);
      putitemXml(vDsItem, 'TP_SITUACAO', 01);
      putitem(vDsLstDev,  vDsItem);

      viParams := '';
      putitemXml(viParams, 'CD_EMPRESA', vCdEmpresa);
      putitemXml(viParams, 'NR_FATURA', vNrFatura);
      putitemXml(viParams, 'DT_FATURA', vDtFatura);
      putitemXml(viParams, 'NR_ITEM', vNrItem);
      putitemXml(viParams, 'CD_PRODUTO', vCdProduto);
      putitemXml(viParams, 'DS_LSTDEVOLUCAO', vDsLstDev);
      voParams := activateCmp('FISSVCO024', 'gravaItemDevTerceiroNF', viParams); (*,,,, *)
      if (xStatus < 0) then begin
        Result := voParams;
        return(-1); exit;
      end;

      vDsItemRef := '';
      putitemXml(vDsItemRef, 'CD_EMPRESA', item_f('CD_EMPRESA', tTRA_TRANSACAO));
      putitemXml(vDsItemRef, 'NR_TRANSACAO', item_f('NR_TRANSACAO', tTRA_TRANSACAO));
      putitemXml(vDsItemRef, 'DT_TRANSACAO', item_a('DT_TRANSACAO', tTRA_TRANSACAO));
      putitemXml(vDsItemRef, 'CD_EMPRESANFREF', vCdEmpresa);
      putitemXml(vDsItemRef, 'NR_FATURANFREF', vNrFatura);
      putitemXml(vDsItemRef, 'DT_FATURANFREF', vDtFatura);
      if (item_f('TP_MODDCTOFISCAL', tFIS_NF) = 71 ) or (item_f('TP_MODDCTOFISCAL', tFIS_NF) = 72) then begin
        putitemXml(vDsItemRef, 'TP_REFERENCIAL', 2);
      end else begin
        putitemXml(vDsItemRef, 'TP_REFERENCIAL', 1);
      end;
      putitem(vDsListaRef,  vDsItemRef);

    end;

    delitem(vDsListaItens, 1);
  end;

  vQtNF := 3;
  vDsLinha := 'DEV.REF.NF:';

  if not (empty(tTMP_NR09))  and (vInRefNF = True) then begin
    setocc(tTMP_NR09, 1);
    while (xStatus >= 0) do begin
      if (vQtNF > 4) then begin
        viParams := '';
        vDsLstTransacao := '';
        vDsRegistro := '';
        putitemXml(vDsRegistro, 'CD_EMPRESA', item_f('CD_EMPRESA', tTRA_TRANSACAO));
        putitemXml(vDsRegistro, 'NR_TRANSACAO', item_f('NR_TRANSACAO', tTRA_TRANSACAO));
        putitemXml(vDsRegistro, 'DT_TRANSACAO', item_a('DT_TRANSACAO', tTRA_TRANSACAO));
        putitem(vDsLstTransacao,  vDsRegistro);
        putitemXml(viParams, 'DS_LSTTRANSACAO', vDsLstTransacao);
        putitemXml(viParams, 'DS_OBSERVACAO', vDsLinha);
        putitemXml(viParams, 'IN_OBSNF', True);
        voParams := activateCmp('TRASVCO016', 'gravaObsTransacao', viParams); (*,,,, *)
        if (xStatus < 0) then begin
          Result := voParams;
          return(-1); exit;
        end;
        vDsLinha := '' + NR_GERAL + '.TMP_NR09-' + DT_EMISSAO + '.TMP_NR09';
        vQtNF := 1;
      end else begin
        vDsLinha := '' + vDsLinha + ' ' + NR_GERAL + '.TMP_NR09-' + DT_EMISSAO + '.TMP_NR09';
        vQtNF := vQtNF + 1;
      end;
      setocc(tTMP_NR09, curocc(tTMP_NR09) + 1);
    end;
    if (vDsLinha <> '') then begin
      viParams := '';
      vDsLstTransacao := '';
      vDsRegistro := '';
      putitemXml(vDsRegistro, 'CD_EMPRESA', item_f('CD_EMPRESA', tTRA_TRANSACAO));
      putitemXml(vDsRegistro, 'NR_TRANSACAO', item_f('NR_TRANSACAO', tTRA_TRANSACAO));
      putitemXml(vDsRegistro, 'DT_TRANSACAO', item_a('DT_TRANSACAO', tTRA_TRANSACAO));
      putitem(vDsLstTransacao,  vDsRegistro);
      putitemXml(viParams, 'DS_LSTTRANSACAO', vDsLstTransacao);
      putitemXml(viParams, 'DS_OBSERVACAO', vDsLinha);
      putitemXml(viParams, 'IN_OBSNF', True);
      voParams := activateCmp('TRASVCO016', 'gravaObsTransacao', viParams); (*,,,, *)
      if (xStatus < 0) then begin
        Result := voParams;
        return(-1); exit;
      end;
    end;
  end;

  viParams := '';
  putitemXml(viParams, 'CD_EMPRESA', item_f('CD_EMPRESA', tTRA_TRANSACAO));
  putitemXml(viParams, 'NR_TRANSACAO', item_f('NR_TRANSACAO', tTRA_TRANSACAO));
  putitemXml(viParams, 'DT_TRANSACAO', item_a('DT_TRANSACAO', tTRA_TRANSACAO));
  putitemXml(viParams, 'DS_LSTTRANSREF', vDsListaRef);
  voParams := activateCmp('TRASVCO024', 'gravaTransacaoRef', viParams); (*,,,, *)
  if (xStatus < 0) then begin
    Result := voParams;
    return(-1); exit;
  end;

  Result := '';
  putitemXml(Result, 'CD_EMPRESA', item_f('CD_EMPRESA', tTRA_TRANSACAO));
  putitemXml(Result, 'NR_TRANSACAO', item_f('NR_TRANSACAO', tTRA_TRANSACAO));
  putitemXml(Result, 'DT_TRANSACAO', item_a('DT_TRANSACAO', tTRA_TRANSACAO));

  return(0); exit;
end;

//-------------------------------------------------------------------------
function T_FISSVCO028.cancelaDevolucaoTransacao(pParams : String) : String;
//-------------------------------------------------------------------------
const
  cDS_METHOD = 'ADICIONAL=Operação: T_FISSVCO028.cancelaDevolucaoTransacao()';
var
  viParams, voParams : String;
  vCdEmpresa, vNrTransacao : Real;
  vDtTransacao : TDate;
begin
  vCdEmpresa := itemXmlF('CD_EMPRESA', pParams);
  vNrTransacao := itemXmlF('NR_TRANSACAO', pParams);
  vDtTransacao := itemXml('DT_TRANSACAO', pParams);

  if (vCdEmpresa = 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Empresa não informada!', cDS_METHOD);
    return(-1); exit;
  end;
  if (vNrTransacao = 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Número transação não informado!', cDS_METHOD);
    return(-1); exit;
  end;
  if (vDtTransacao = '') then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Data transação não informada!', cDS_METHOD);
    return(-1); exit;
  end;

  clear_e(tTRA_TRANSACAO);
  putitem_e(tTRA_TRANSACAO, 'CD_EMPRESA', vCdEmpresa);
  putitem_e(tTRA_TRANSACAO, 'NR_TRANSACAO', vNrTransacao);
  putitem_e(tTRA_TRANSACAO, 'DT_TRANSACAO', vDtTransacao);
  retrieve_e(tTRA_TRANSACAO);
  if (xStatus < 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Transação ' + FloatToStr(vCdEmpresa) + ' / ' + FloatToStr(vNrTransacao) + ' / ' + vDtTransacao + ' não cadastrada!', cDS_METHOD);
    return(-1); exit;
  end;

  clear_e(tFIS_NFIDEVT);
  putitem_e(tFIS_NFIDEVT, 'CD_EMPDCTO', item_f('CD_EMPRESA', tTRA_TRANSACAO));
  putitem_e(tFIS_NFIDEVT, 'NR_DCTO', item_f('NR_TRANSACAO', tTRA_TRANSACAO));
  putitem_e(tFIS_NFIDEVT, 'DT_DCTO', item_a('DT_TRANSACAO', tTRA_TRANSACAO));
  putitem_e(tFIS_NFIDEVT, 'TP_DCTO', 01);
  retrieve_e(tFIS_NFIDEVT);
  if (xStatus >= 0) then begin
    setocc(tFIS_NFIDEVT, 1);
    while (xStatus >= 0) do begin
      putitem_e(tFIS_NFIDEVT, 'TP_SITUACAO', 06);
      setocc(tFIS_NFIDEVT, curocc(tFIS_NFIDEVT) + 1);
    end;
    voParams := tFIS_NFIDEVT.Salvar();
    if (xStatus < 0) then begin
      Result := voParams;
      return(-1); exit;
    end;
  end;

  return(0); exit;
end;


end.
