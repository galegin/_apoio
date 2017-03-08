unit cCOMSVCO002;

interface

(* COMPONENTES 
  ADMSVCO001 / COMSVCO001 / FCRSVCO001 / SICSVCO016 / 
*)        

uses
  Classes, SysUtils, Math, DB,
  cDataSetUnf;

type
  T_COMSVCO002 = class(TComponent)
  private
    tCOM_DOCTIPOCO,
    tCOM_ESTRUTURA,
    tF_FCR_COMISSA,
    tFCR_COMISSAO,
    tFCR_FATURAI,
    tFIS_ITEMCONSI,
    tFIS_NF,
    tIMB_COMISSAO,
    tIMB_CONTRATO,
    tIMB_CONTRATOI,
    tIMB_CONTRATOIPAR,
    tIMB_CONTRATOT,
    tPED_PEDIDOC,
    tPED_PEDIDOCCO,
    tPED_PEDIDOI,
    tPED_PEDIDOICO,
    tPED_PEDIDOTRA,
    tPRD_PRODUTOCL,
    tTMP_NR09,
    tTRA_TRANSACAO,
    tTRA_TRANSAGRU,
    tTRA_TRANSITEM : TcDatasetUnf;
    function getParam(pParams : String = '') : String;
    function setEntidade(pParams : String = '') : String;
  protected
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;    
  published
    function calcularTotalComissao(pParams : String = '') : String;
    function buscaItemContrato(pParams : String = '') : String;
    function calculaComissaoGuia(pParams : String = '') : String;
    function calculaComissaoTransf(pParams : String = '') : String;
    function calculaComissaoRepre(pParams : String = '') : String;
    function calculaComissaoContrato(pParams : String = '') : String;
  end;

implementation

uses
  cADMSVCO001,
  cActivate, cStatus, cFuncao, cXml, dModulo;

var
  gCdemppadraocomis,
  gCdTipoClassComis,
  gInComissaoRepreProd,
  gInZeraRepreComis,
  gTpComissaoRepre : String;

//---------------------------------------------------------------
constructor T_COMSVCO002.Create(AOwner: TComponent);
//---------------------------------------------------------------
begin
  inherited Create(AOwner);
  setEntidade('');
end;

//--------------------------------
destructor T_COMSVCO002.Destroy;
//--------------------------------
begin
  inherited Destroy;
end;

//---------------------------------------------------------------
function T_COMSVCO002.getParam(pParams : String = '') : String;
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
  putitem(xParamEmp, 'CD_EMPPADRAO_COMIS');
  putitem(xParamEmp, 'CD_TIPOCLASS_COMIS');
  putitem(xParamEmp, 'IN_COMISSAO_REPRE_PROD');
  putitem(xParamEmp, 'IN_ZERA_REPRE_COMIS');
  putitem(xParamEmp, 'TP_COMISSAO_REPRE');

  xParamEmp := T_ADMSVCO001.GetParamEmpresa(piCdEmpresa, xParamEmp);

  gCdemppadraocomis := itemXml('CD_EMPPADRAO_COMIS', xParamEmp);
  gCdTipoClassComis := itemXml('CD_TIPOCLASS_COMIS', xParamEmp);
  gInComissaoRepreProd := itemXml('IN_COMISSAO_REPRE_PROD', xParamEmp);
  gInZeraRepreComis := itemXml('IN_ZERA_REPRE_COMIS', xParamEmp);
  gTpComissaoRepre := itemXml('TP_COMISSAO_REPRE', xParamEmp);

end;

//---------------------------------------------------------------
function T_COMSVCO002.setEntidade(pParams : String = '') : String;
//---------------------------------------------------------------
begin
  tCOM_DOCTIPOCO := TcDatasetUnf.getEntidade('COM_DOCTIPOCO');
  tCOM_ESTRUTURA := TcDatasetUnf.getEntidade('COM_ESTRUTURA');
  tF_FCR_COMISSA := TcDatasetUnf.getEntidade('F_FCR_COMISSA');
  tFCR_COMISSAO := TcDatasetUnf.getEntidade('FCR_COMISSAO');
  tFCR_FATURAI := TcDatasetUnf.getEntidade('FCR_FATURAI');
  tFIS_ITEMCONSI := TcDatasetUnf.getEntidade('FIS_ITEMCONSI');
  tFIS_NF := TcDatasetUnf.getEntidade('FIS_NF');
  tIMB_COMISSAO := TcDatasetUnf.getEntidade('IMB_COMISSAO');
  tIMB_CONTRATO := TcDatasetUnf.getEntidade('IMB_CONTRATO');
  tIMB_CONTRATOI := TcDatasetUnf.getEntidade('IMB_CONTRATOI');
  tIMB_CONTRATOIPAR := TcDatasetUnf.getEntidade('IMB_CONTRATOIPAR');
  tIMB_CONTRATOT := TcDatasetUnf.getEntidade('IMB_CONTRATOT');
  tPED_PEDIDOC := TcDatasetUnf.getEntidade('PED_PEDIDOC');
  tPED_PEDIDOCCO := TcDatasetUnf.getEntidade('PED_PEDIDOCCO');
  tPED_PEDIDOI := TcDatasetUnf.getEntidade('PED_PEDIDOI');
  tPED_PEDIDOICO := TcDatasetUnf.getEntidade('PED_PEDIDOICO');
  tPED_PEDIDOTRA := TcDatasetUnf.getEntidade('PED_PEDIDOTRA');
  tPRD_PRODUTOCL := TcDatasetUnf.getEntidade('PRD_PRODUTOCL');
  tTMP_NR09 := TcDatasetUnf.getEntidade('TMP_NR09');
  tTRA_TRANSACAO := TcDatasetUnf.getEntidade('TRA_TRANSACAO');
  tTRA_TRANSAGRU := TcDatasetUnf.getEntidade('TRA_TRANSAGRU');
  tTRA_TRANSITEM := TcDatasetUnf.getEntidade('TRA_TRANSITEM');
end;

//---------------------------------------------------------------------
function T_COMSVCO002.calcularTotalComissao(pParams : String) : String;
//---------------------------------------------------------------------
const
  cDS_METHOD = 'ADICONAL=Operação: T_COMSVCO002.calcularTotalComissao()';
var
  (* boolean piInComissaoRepre :IN / string piDsLstComissao :INOUT / string piVlFatura :IN / numeric piPrReducao :IN *)
  vLstComissaoRet, vDsRegistro : String;
  vCdComissionado, vVlCalc : Real;
begin
  vLstComissaoRet := '';
  clear_e(tTMP_NR09);
  if (piDsLstComissao <> '') then begin
    repeat
      getitem(vDsRegistro, piDsLstComissao, 1);

      if (itemXml('CD_PESCOMIS', vDsRegistro) <> '') then begin
        creocc(tTMP_NR09, -1);
        putitem_e(tTMP_NR09, 'NR_GERAL', itemXmlF('CD_PESCOMIS', vDsRegistro));
        retrieve_o(tTMP_NR09);
        if (xStatus = 4) then begin
          retrieve_x(tTMP_NR09);
        end;
        putitem_e(tTMP_NR09, 'CD_TIPOCOMIS', itemXmlF('CD_TIPOCOMIS', vDsRegistro));
        putitem_e(tTMP_NR09, 'PR_COMISSAOFAT', item_f('PR_COMISSAOFAT', tTMP_NR09) + itemXmlF('PR_COMISSAOFAT', vDsRegistro));
        putitem_e(tTMP_NR09, 'PR_COMISSAOREC', item_f('PR_COMISSAOREC', tTMP_NR09) + itemXmlF('PR_COMISSAOREC', vDsRegistro));
        putitem_e(tTMP_NR09, 'VL_COMISSAOFAT', item_f('VL_COMISSAOFAT', tTMP_NR09) + itemXmlF('VL_COMISSAOFAT', vDsRegistro));
        putitem_e(tTMP_NR09, 'VL_COMISSAOREC', item_f('VL_COMISSAOREC', tTMP_NR09) + itemXmlF('VL_COMISSAOREC', vDsRegistro));
        putitem_e(tTMP_NR09, 'CD_TIPOCLASS', itemXmlF('CD_TIPOCLASS', vDsRegistro));
        putitem_e(tTMP_NR09, 'CD_CLASS', itemXmlF('CD_CLASS', vDsRegistro));
      end;

      delitem(piDsLstComissao, 1);
    until(piDsLstComissao = '');
  end;

  if not (empty(tTMP_NR09)) then begin
    setocc(tTMP_NR09, 1);
    while (xStatus >= 0) do begin

      if (piInComissaoRepre = True ) and (piPrReducao <> 0) then begin
        putitem_e(tTMP_NR09, 'PR_COMISSAOFAT', item_f('PR_COMISSAOFAT', tTMP_NR09) * piPrReducao);
        vVlCalc := piVlFatura * item_f('PR_COMISSAOFAT', tTMP_NR09) / 100;
        putitem_e(tTMP_NR09, 'VL_COMISSAOFAT', roundto(vVlCalc, 2));
        putitem_e(tTMP_NR09, 'PR_COMISSAOREC', item_f('PR_COMISSAOREC', tTMP_NR09) * piPrReducao);
        vVlCalc := piVlFatura * item_f('PR_COMISSAOREC', tTMP_NR09) / 100;
        putitem_e(tTMP_NR09, 'VL_COMISSAOREC', roundto(vVlCalc, 2));
      end;

      vDsRegistro := '';
      putitemXml(vDsRegistro, 'CD_PESCOMIS', item_f('NR_GERAL', tTMP_NR09));
      putitemXml(vDsRegistro, 'CD_TIPOCOMIS', item_f('CD_TIPOCOMIS', tTMP_NR09));
      putitemXml(vDsRegistro, 'PR_COMISSAOFAT', item_f('PR_COMISSAOFAT', tTMP_NR09));
      putitemXml(vDsRegistro, 'PR_COMISSAOREC', item_f('PR_COMISSAOREC', tTMP_NR09));
      putitemXml(vDsRegistro, 'VL_COMISSAOFAT', item_f('VL_COMISSAOFAT', tTMP_NR09));
      putitemXml(vDsRegistro, 'VL_COMISSAOREC', item_f('VL_COMISSAOREC', tTMP_NR09));
      putitemXml(vDsRegistro, 'CD_TIPOCLASS', item_f('CD_TIPOCLASS', tTMP_NR09));
      putitemXml(vDsRegistro, 'CD_CLASS', item_f('CD_CLASS', tTMP_NR09));
      putitem(   vLstComissaoRet,  vDsRegistro);

      setocc(tTMP_NR09, curocc(tTMP_NR09) + 1);
    end;
  end;
  piDsLstComissao := vLstComissaoRet;

  return(0); exit;
end;

//-----------------------------------------------------------------
function T_COMSVCO002.buscaItemContrato(pParams : String) : String;
//-----------------------------------------------------------------
const
  cDS_METHOD = 'ADICONAL=Operação: T_COMSVCO002.buscaItemContrato()';
begin
  clear_e(tTRA_TRANSAGRU);
  putitem_e(tTRA_TRANSAGRU, 'CD_EMPRESA', piCdEmpTransacao);
  putitem_e(tTRA_TRANSAGRU, 'NR_TRANSACAO', piNrTransacao);
  putitem_e(tTRA_TRANSAGRU, 'DT_TRANSACAO', piDtTransacao);
  retrieve_e(tTRA_TRANSAGRU);
  if (xStatus >= 0) then begin
    setocc(tTRA_TRANSAGRU, 1);

    clear_e(tIMB_CONTRATOT);
    putitem_e(tIMB_CONTRATOT, 'CD_EMPTRANSACAO', item_f('CD_EMPRESAORI', tTRA_TRANSAGRU));
    putitem_e(tIMB_CONTRATOT, 'NR_TRANSACAO', item_f('NR_TRANSACAOORI', tTRA_TRANSAGRU));
    putitem_e(tIMB_CONTRATOT, 'DT_TRANSACAO', item_a('DT_TRANSACAOORI', tTRA_TRANSAGRU));
    retrieve_e(tIMB_CONTRATOT);
    if (xStatus >= 0) then begin
      poNrItemContrato := item_f('NR_SEQITEM', tIMB_CONTRATOT);
    end;
  end;

  return(0); exit;
end;

//-------------------------------------------------------------------
function T_COMSVCO002.calculaComissaoGuia(pParams : String) : String;
//-------------------------------------------------------------------
const
  cDS_METHOD = 'ADICONAL=Operação: T_COMSVCO002.calculaComissaoGuia()';
var
  viParams, voParams, vDsRegistro, vDsLstTransacao : String;
  vDsLstComissionado, vDsLstComissao : String;
  vCdEmpresa, vNrTransacao, vCdGuia, vVlFatura, vTpDocumento, vCdTipoComis : Real;
  vVlCalc, vPrComissaoFat, vPrComissaoRec, vVlComissaoFat, vVlComissaoRec : Real;
  vDtTransacao : TDate;
  vInFat, vInRec : Boolean;
begin
  vDsLstTransacao := itemXml('DS_LSTTRANSACAO', pParams);
  vVlFatura := itemXmlF('VL_FATURA', pParams);
  vTpDocumento := itemXmlF('TP_DOCUMENTO', pParams);

  if (vDsLstTransacao = '') then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Lista de transação não informada!', cDS_METHOD);
    return(-1); exit;
  end;
  if (vVlFatura = 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Valor da fatura nãp informado!', cDS_METHOD);
    return(-1); exit;
  end;
  if (vTpDocumento = 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Tipo de documento não informado!', cDS_METHOD);
    return(-1); exit;
  end;

  getParams(pParams); (* itemXmlF('CD_EMPRESA', PARAM_GLB), 'calculaComissaoGuia' *)
  if (xStatus < 0) then begin
    Result := voParams;
    return(-1); exit;
  end;

  clear_e(tTRA_TRANSACAO);
  vCdGuia := 0;

  repeat
    getitem(vDsRegistro, vDsLstTransacao, 1);
    vCdEmpresa := itemXmlF('CD_EMPRESA', vDsRegistro);
    vNrTransacao := itemXmlF('NR_TRANSACAO', vDsRegistro);
    vDtTransacao := itemXml('DT_TRANSACAO', vDsRegistro);

    if (vCdEmpresa = 0) then begin
      Result := SetStatus(STS_ERROR, 'GEN0001', 'Empresa não informada!', cDS_METHOD);
      return(-1); exit;
    end;
    if (vNrTransacao = 0) then begin
      Result := SetStatus(STS_ERROR, 'GEN0001', 'Número da transação não informado!', cDS_METHOD);
      return(-1); exit;
    end;
    if (vDtTransacao = '') then begin
      Result := SetStatus(STS_ERROR, 'GEN0001', 'Data transação não informada!', cDS_METHOD);
      return(-1); exit;
    end;

    creocc(tTRA_TRANSACAO, -1);
    putitem_e(tTRA_TRANSACAO, 'CD_EMPRESA', vCdEmpresa);
    putitem_e(tTRA_TRANSACAO, 'NR_TRANSACAO', vNrTransacao);
    putitem_e(tTRA_TRANSACAO, 'DT_TRANSACAO', vDtTransacao);
    retrieve_o(tTRA_TRANSACAO);
    if (xStatus = -7) then begin
      retrieve_x(tTRA_TRANSACAO);
    end else if (xStatus = 0) then begin
      Result := SetStatus(STS_ERROR, 'GEN0001', 'Transação ' + FloatToStr(vNrTransacao) + ' não cadastrada!', cDS_METHOD);
      return(-1); exit;
    end;
    if (curocc(tTRA_TRANSACAO) = 1) then begin
      vCdGuia := item_f('CD_GUIA', tTRA_TRANSACAO);
    end else begin
      if (item_f('CD_GUIA', tTRA_TRANSACAO) <> vCdGuia) then begin
        Result := SetStatus(STS_ERROR, 'GEN0001', 'Existem guias diferentes na lista de transações!', cDS_METHOD);
        return(-1); exit;
      end;
    end;

    delitem(vDsLstTransacao, 1);
  until (vDsLstTransacao = '');

  if (vCdGuia = 0) then begin
    return(0); exit;
  end;

  viParams := '';
  putitemXml(viParams, 'CD_PESSOA', vCdGuia);
  voParams := activateCmp('COMSVCO001', 'buscaComissionado', viParams);
  if (xStatus < 0) then begin
    Result := voParams;
    return(-1); exit;
  end;
  vDsLstComissao := '';
  vDsLstComissionado := itemXml('DS_LSTCOMISSIONADO', voParams);

  if (vDsLstComissionado <> '') then begin
    repeat
      getitem(vDsRegistro, vDsLstComissionado, 1);
      vPrComissaoFat := itemXmlF('PR_COMISSAOFAT', vDsRegistro);
      vPrComissaoRec := itemXmlF('PR_COMISSAOREC', vDsRegistro);
      vCdTipoComis := itemXmlF('CD_TIPOCOMIS', vDsRegistro);
      vInFat := True;
      vInRec := True;
      if (vCdTipoComis > 0) then begin
        clear_e(tCOM_DOCTIPOCO);
        putitem_e(tCOM_DOCTIPOCO, 'CD_TIPOCOMIS', vCdTipoComis);
        putitem_e(tCOM_DOCTIPOCO, 'TP_DOCUMENTO', vTpDocumento);
        retrieve_e(tCOM_DOCTIPOCO);
        if (xStatus >= 0) then begin
          if (item_b('IN_AGRUPAPERC', tCOM_DOCTIPOCO) = True) then begin
            vPrComissaoFat := vPrComissaoFat + vPrComissaoRec;
            vPrComissaoRec := vPrComissaoFat;

            putitemXml(vDsRegistro, 'PR_COMISSAOFAT', vPrComissaoFat);
            putitemXml(vDsRegistro, 'PR_COMISSAOREC', vPrComissaoRec);
          end;
          if (item_b('IN_FATURAMENTO', tCOM_DOCTIPOCO) = False) then begin
            vInFat := False;
            putitemXml(vDsRegistro, 'PR_COMISSAOFAT', 0);
          end;
          if (item_b('IN_RECEBIMENTO', tCOM_DOCTIPOCO) = False) then begin
            vInRec := False;
            putitemXml(vDsRegistro, 'PR_COMISSAOREC', 0);
          end;
        end;
      end;
      if (vInFat = True) then begin
        vVlCalc := vVlFatura * vPrComissaoFat / 100;
        vVlComissaoFat := roundto(vVlCalc, 2);
        putitemXml(vDsRegistro, 'VL_COMISSAOFAT', vVlComissaoFat);
      end;
      if (vInRec = True) then begin
        vVlCalc := vVlFatura * vPrComissaoRec / 100;
        vVlComissaoRec := roundto(vVlCalc, 2);
        putitemXml(vDsRegistro, 'VL_COMISSAOREC', vVlComissaoRec);
      end;
      putitem(vDsLstComissao,  vDsRegistro);
      delitem(vDsLstComissionado, 1);
    until (vDsLstComissionado = '');
  end;

  gInComissaoRepreProd := False;
  voParams := calcularTotalComissao(viParams); (* gInComissaoRepreProd, vDsLstComissao, '', '' *)
  if (xStatus < 0) then begin
    Result := voParams;
    return(-1); exit;
  end;

  Result := '';
  putitemXml(Result, 'DS_LSTCOMISSAO', vDsLstComissao);

  return(0); exit;
end;

//---------------------------------------------------------------------
function T_COMSVCO002.calculaComissaoTransf(pParams : String) : String;
//---------------------------------------------------------------------
const
  cDS_METHOD = 'ADICONAL=Operação: T_COMSVCO002.calculaComissaoTransf()';
var
  vCdEmpresa, vCdCliente, vNrFat, vNrParcela, vVlFatura, vPrComissao : Real;
  vDsLstFatura, vLstFatura, vDsFatura, viParams, voParams : String;
begin
  vCdEmpresa := itemXmlF('CD_EMPRESA', pParams);
  vCdCliente := itemXmlF('CD_CLIENTE', pParams);
  vNrFat := itemXmlF('NR_FAT', pParams);
  vNrParcela := itemXmlF('NR_PARCELA', pParams);
  vDsLstFatura := itemXml('DS_LSTFATURA', pParams);

  if (vCdEmpresa = '') then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Empresa da fatura não informada!', cDS_METHOD);
    return(-1); exit;
  end;
  if (vCdCliente = 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Cliente da fatura não informada!', cDS_METHOD);
    return(-1); exit;
  end;
  if (vNrFat = 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Número da fatura não informada!', cDS_METHOD);
    return(-1); exit;
  end;
  if (vNrParcela = 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Parcela da fatura não informada!', cDS_METHOD);
    return(-1); exit;
  end;
  if (vDsLstFatura = '') then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Lista de fatura não informada!', cDS_METHOD);
    return(-1); exit;
  end;

  getParams(pParams); (* itemXmlF('CD_EMPRESA', PARAM_GLB), 'calculaComissaoTransf' *)
  if (xStatus < 0) then begin
    Result := voParams;
    return(-1); exit;
  end;

  clear_e(tFCR_FATURAI);
  putitem_e(tFCR_FATURAI, 'CD_EMPRESA', vCdEmpresa);
  putitem_e(tFCR_FATURAI, 'CD_CLIENTE', vCdCliente);
  putitem_e(tFCR_FATURAI, 'NR_FAT', vNrFat);
  putitem_e(tFCR_FATURAI, 'NR_PARCELA', vNrParcela);
  retrieve_e(tFCR_FATURAI);
  if (xStatus < 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Fatura não encontrada!', cDS_METHOD);
    return(-1); exit;
  end else begin
    setocc(tFCR_COMISSAO, 1);
    while (xStatus >= 0) do begin
      vPrComissao := item_f('PR_COMISSAOREC', tFCR_COMISSAO);

      vLstFatura := vDsLstFatura;
      repeat
        getitem(vDsFatura, vLstFatura);
        vCdEmpresa := itemXmlF('CD_EMPRESA', vDsFatura);
        vCdCliente := itemXmlF('CD_CLIENTE', vDsFatura);
        vNrFat := itemXmlF('NR_FAT', vDsFatura);
        vNrParcela := itemXmlF('NR_PARCELA', vDsFatura);
        vVlFatura := itemXmlF('VL_FATURA', vDsFatura);

        creocc(tF_FCR_COMISSA, -1);
        putitem_e(tF_FCR_COMISSA, 'CD_EMPRESA', vCdEmpresa);
        putitem_e(tF_FCR_COMISSA, 'CD_CLIENTE', vCdCliente);
        putitem_e(tF_FCR_COMISSA, 'NR_FATURA', vNrFat);
        putitem_e(tF_FCR_COMISSA, 'NR_PARCELA', vNrParcela);
        putitem_e(tF_FCR_COMISSA, 'CD_PESCOMIS', item_f('CD_PESCOMIS', tFCR_COMISSAO));
        retrieve_o(tF_FCR_COMISSA);
        if (xStatus = -7) then begin
          retrieve_x(tF_FCR_COMISSA);
        end;

        putitem_e(tF_FCR_COMISSA, 'PR_COMISSAOREC', vPrComissao);
        putitem_e(tF_FCR_COMISSA, 'VL_COMISSAOREC', vVlFatura * vPrComissao / 100);
        putitem_e(tF_FCR_COMISSA, 'PR_COMISSAOREC', 0);
        putitem_e(tF_FCR_COMISSA, 'VL_COMISSAOREC', 0);
        putitem_e(tF_FCR_COMISSA, 'IN_RECPAGO', False);
        putitem_e(tF_FCR_COMISSA, 'IN_FATPAGO', False);
        putitem_e(tF_FCR_COMISSA, 'CD_TIPOCOMIS', item_f('CD_TIPOCOMIS', tFCR_COMISSAO));
        putitem_e(tF_FCR_COMISSA, 'CD_OPERADOR', itemXmlF('CD_USUARIO', PARAM_GLB));
        putitem_e(tF_FCR_COMISSA, 'DT_CADASTRO', Now);

        viParams := '';
        putlistitensocc_e(viParams, tF_FCR_COMISSA);
        voParams := activateCmp('FCRSVCO001', 'gravaComissaoFatura', viParams);
        if (xStatus < 0) then begin
          Result := voParams;
          return(-1); exit;
        end;

        delitem(vLstFatura, 1);
      until (vLstFatura = '');

      setocc(tFCR_COMISSAO, curocc(tFCR_COMISSAO) + 1);
    end;
  end;

  return(0); exit;
end;

//--------------------------------------------------------------------
function T_COMSVCO002.calculaComissaoRepre(pParams : String) : String;
//--------------------------------------------------------------------
const
  cDS_METHOD = 'ADICONAL=Operação: T_COMSVCO002.calculaComissaoRepre()';
var
  viParams, voParams, vDsRegistro, vDsLstTransacao : String;
  vDsLstComissionado, vDsLstComissao, vCdClass : String;
  vCdEmpresa, vNrTransacao, vCdRepresentante, vVlFatura, vTpDocumento, vCdTipoComis, vCdTipoClass : Real;
  vVlCalc, vPrComissaoFat, vPrComissaoRec, vVlComissaoFat, vVlComissaoRec, vCdPesComis : Real;
  vDtTransacao : TDate;
  vInFat, vInRec, vInTraSemPedido, vInTraSemPed : Boolean;
  vVlComissFatItem, vVlComissRecItem, vVlTotalItem, vVlTotProduto, vVlTotTransacao, vPrReducao : Real;
begin
  vDsLstTransacao := itemXml('DS_LSTTRANSACAO', pParams);
  vVlFatura := itemXmlF('VL_FATURA', pParams);
  vTpDocumento := itemXmlF('TP_DOCUMENTO', pParams);

  if (vDsLstTransacao = '') then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Lista de transação não informada!', cDS_METHOD);
    return(-1); exit;
  end;
  if (vVlFatura = 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Valor da fatura não informado!', cDS_METHOD);
    return(-1); exit;
  end;
  if (vTpDocumento = 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Tipo de documento não informado!', cDS_METHOD);
    return(-1); exit;
  end;

  getParams(pParams); (* itemXmlF('CD_EMPRESA', PARAM_GLB), 'calculaComissaoRepre' *)
  if (xStatus < 0) then begin
    Result := voParams;
    return(-1); exit;
  end;

  clear_e(tTRA_TRANSACAO);
  vCdRepresentante := 0;
  vInTraSemPedido := False;

  repeat
    getitem(vDsRegistro, vDsLstTransacao, 1);
    vCdEmpresa := itemXmlF('CD_EMPRESA', vDsRegistro);
    vNrTransacao := itemXmlF('NR_TRANSACAO', vDsRegistro);
    vDtTransacao := itemXml('DT_TRANSACAO', vDsRegistro);

    if (vCdEmpresa = 0) then begin
      Result := SetStatus(STS_ERROR, 'GEN0001', 'Empresa não informada!', cDS_METHOD);
      return(-1); exit;
    end;
    if (vNrTransacao = 0) then begin
      Result := SetStatus(STS_ERROR, 'GEN0001', 'Número da transação não informado!', cDS_METHOD);
      return(-1); exit;
    end;
    if (vDtTransacao = '') then begin
      Result := SetStatus(STS_ERROR, 'GEN0001', 'Data transação não informada!', cDS_METHOD);
      return(-1); exit;
    end;

    creocc(tTRA_TRANSACAO, -1);
    putitem_e(tTRA_TRANSACAO, 'CD_EMPRESA', vCdEmpresa);
    putitem_e(tTRA_TRANSACAO, 'NR_TRANSACAO', vNrTransacao);
    putitem_e(tTRA_TRANSACAO, 'DT_TRANSACAO', vDtTransacao);
    retrieve_o(tTRA_TRANSACAO);
    if (xStatus = -7) then begin
      retrieve_x(tTRA_TRANSACAO);
    end else if (xStatus = 0) then begin
      Result := SetStatus(STS_ERROR, 'GEN0001', 'Transação ' + FloatToStr(vNrTransacao) + ' não cadastrada!', cDS_METHOD);
      return(-1); exit;
    end;

    clear_e(tPED_PEDIDOTRA);
    putitem_e(tPED_PEDIDOTRA, 'CD_EMPTRANSACAO', vCdEmpresa);
    putitem_e(tPED_PEDIDOTRA, 'NR_TRANSACAO', vNrTransacao);
    putitem_e(tPED_PEDIDOTRA, 'DT_TRANSACAO', vDtTransacao);
    retrieve_e(tPED_PEDIDOTRA);
    if (xStatus >= 0) then begin
      creocc(tPED_PEDIDOC, -1);
      putitem_e(tPED_PEDIDOC, 'CD_EMPRESA', item_f('CD_EMPPEDIDO', tPED_PEDIDOTRA));
      putitem_e(tPED_PEDIDOC, 'CD_PEDIDO', item_f('CD_PEDIDO', tPED_PEDIDOTRA));
      retrieve_o(tPED_PEDIDOC);
      if (xStatus = -7) then begin
        retrieve_x(tPED_PEDIDOC);
      end else if (xStatus = 0) then begin
        Result := SetStatus(STS_ERROR, 'GEN0001', 'Pedido ' + item_a('CD_PEDIDO', tPED_PEDIDOTRA) + ' não cadastrado!', cDS_METHOD);
        return(-1); exit;
      end;
    end else begin
      vInTraSemPed := False;

      clear_e(tTRA_TRANSAGRU);
      putitem_e(tTRA_TRANSAGRU, 'CD_EMPRESA', vCdEmpresa);
      putitem_e(tTRA_TRANSAGRU, 'NR_TRANSACAO', vNrTransacao);
      putitem_e(tTRA_TRANSAGRU, 'DT_TRANSACAO', vDtTransacao);
      retrieve_e(tTRA_TRANSAGRU);
      if (xStatus >= 0) then begin
        clear_e(tPED_PEDIDOTRA);
        putitem_e(tPED_PEDIDOTRA, 'CD_EMPTRANSACAO', item_f('CD_EMPRESAORI', tTRA_TRANSAGRU));
        putitem_e(tPED_PEDIDOTRA, 'NR_TRANSACAO', item_f('NR_TRANSACAOORI', tTRA_TRANSAGRU));
        putitem_e(tPED_PEDIDOTRA, 'DT_TRANSACAO', item_a('DT_TRANSACAOORI', tTRA_TRANSAGRU));
        retrieve_e(tPED_PEDIDOTRA);
        if (xStatus >= 0) then begin
          creocc(tPED_PEDIDOC, -1);
          putitem_e(tPED_PEDIDOC, 'CD_EMPRESA', item_f('CD_EMPPEDIDO', tPED_PEDIDOTRA));
          putitem_e(tPED_PEDIDOC, 'CD_PEDIDO', item_f('CD_PEDIDO', tPED_PEDIDOTRA));
          retrieve_o(tPED_PEDIDOC);
          if (xStatus = -7) then begin
            retrieve_x(tPED_PEDIDOC);
          end else if (xStatus = 0) then begin
            Result := SetStatus(STS_ERROR, 'GEN0001', 'Pedido ' + item_a('CD_PEDIDO', tPED_PEDIDOTRA) + ' agrupado não cadastrado!', cDS_METHOD);
            return(-1); exit;
          end;
        end else begin
          vInTraSemPed := True;
        end;
      end else begin
        vInTraSemPed := True;
      end;
      if (vInTraSemPed = True) then begin
        clear_e(tFIS_ITEMCONSI);
        putitem_e(tFIS_ITEMCONSI, 'CD_EMPTRA', vCdEmpresa);
        putitem_e(tFIS_ITEMCONSI, 'NR_TRANSACAO', vNrTransacao);
        putitem_e(tFIS_ITEMCONSI, 'DT_TRANSACAO', vDtTransacao);
        retrieve_e(tFIS_ITEMCONSI);
        if (xStatus >= 0) then begin
          clear_e(tFIS_NF);
          putitem_e(tFIS_NF, 'CD_EMPRESA', item_f('CD_EMPRESA', tFIS_ITEMCONSI));
          putitem_e(tFIS_NF, 'NR_FATURA', item_f('NR_FATURA', tFIS_ITEMCONSI));
          putitem_e(tFIS_NF, 'DT_FATURA', item_a('DT_FATURA', tFIS_ITEMCONSI));
          retrieve_e(tFIS_NF);
          if (xStatus >= 0) then begin
            clear_e(tPED_PEDIDOTRA);
            putitem_e(tPED_PEDIDOTRA, 'CD_EMPTRANSACAO', item_f('CD_EMPRESAORI', tFIS_NF));
            putitem_e(tPED_PEDIDOTRA, 'NR_TRANSACAO', item_f('NR_TRANSACAOORI', tFIS_NF));
            putitem_e(tPED_PEDIDOTRA, 'DT_TRANSACAO', item_a('DT_TRANSACAOORI', tFIS_NF));
            retrieve_e(tPED_PEDIDOTRA);
            if (xStatus >= 0) then begin
              creocc(tPED_PEDIDOC, -1);
              putitem_e(tPED_PEDIDOC, 'CD_EMPRESA', item_f('CD_EMPPEDIDO', tPED_PEDIDOTRA));
              putitem_e(tPED_PEDIDOC, 'CD_PEDIDO', item_f('CD_PEDIDO', tPED_PEDIDOTRA));
              retrieve_o(tPED_PEDIDOC);
              if (xStatus = -7) then begin
                retrieve_x(tPED_PEDIDOC);
              end else if (xStatus = 0) then begin
                Result := SetStatus(STS_ERROR, 'GEN0001', 'Pedido ' + item_a('CD_PEDIDO', tPED_PEDIDOTRA) + ' agrupado não cadastrado!', cDS_METHOD);
                return(-1); exit;
              end;
            end else begin
              vInTraSemPedido := True;
            end;
          end else begin
            vInTraSemPedido := True;
          end;
        end else begin
          vInTraSemPedido := True;
        end;
      end;
    end;
    if (curocc(tTRA_TRANSACAO) = 1) then begin
      vCdRepresentante := item_f('CD_REPRESENTANT', tTRA_TRANSACAO);
    end else begin
      if (item_f('CD_REPRESENTANT', tTRA_TRANSACAO) <> vCdRepresentante) then begin
        Result := SetStatus(STS_ERROR, 'GEN0001', 'Existem representantes diferentes na lista de transações!', cDS_METHOD);
        return(-1); exit;
      end;
    end;

    vVlTotProduto := vVlTotProduto + item_f('VL_TRANSACAO', tTRA_TRANSACAO);
    vVlTotTransacao := vVlTotTransacao + item_f('VL_TOTAL', tTRA_TRANSACAO);

    delitem(vDsLstTransacao, 1);
  until (vDsLstTransacao = '');

  if (vCdRepresentante = 0) then begin
    return(0); exit;
  end;
  if (gTpComissaoRepre <> 01)  and (totocc('TRA_TRANSACAOSVC') > 1) then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Comissão do representante poderá ser calculado apenas para uma única transação!', cDS_METHOD);
    return(-1); exit;
  end;
  if (totocc('PED_PEDIDOCSVC') > 1) then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Mais de um pedido vinculado a(s) transação(ões)!', cDS_METHOD);
    return(-1); exit;
  end;
  if (empty(tPED_PEDIDOC) = False) then begin
    if (vInTraSemPedido = True) then begin
      Result := SetStatus(STS_ERROR, 'GEN0001', 'Exite(m) transação(ões) com e sem pedido(s)!', cDS_METHOD);
      return(-1); exit;
    end;
  end;

  vDsLstComissao := '';

  if (empty(tPED_PEDIDOCCO) = False) then begin
    setocc(tPED_PEDIDOCCO, 1);
    while (xStatus >= 0) do begin
      clear_e(tCOM_ESTRUTURA);

      putitem_e(tCOM_ESTRUTURA, 'CD_EMPCOMIS', gCdemppadraocomis);
      putitem_e(tCOM_ESTRUTURA, 'CD_PESCOMIS', item_f('CD_PESCOMIS', tPED_PEDIDOCCO));
      retrieve_e(tCOM_ESTRUTURA);
      if (xStatus < 0) then begin
        Result := SetStatus(STS_ERROR, 'GEN0001', 'Pessoa ' + item_a('CD_PESCOMIS', tPED_PEDIDOCCO) + ' não cadastrada na estrutura de comissionado!', cDS_METHOD);
        return(-1); exit;
      end;

      vDsRegistro := '';
      putitemXml(vDsRegistro, 'CD_TIPOCOMIS', item_f('CD_TIPOCOMIS', tCOM_ESTRUTURA));
      vInFat := True;
      vInRec := True;

      vVlTotalItem := 0;
      vVlComissFatItem := 0;
      vVlComissRecItem := 0;

      if (gInZeraRepreComis = 1)  and (item_f('CD_CLIENTE', tPED_PEDIDOC) = item_f('CD_REPRESENTANT', tPED_PEDIDOC)) then begin
        vPrComissaoFat := 0;
        vPrComissaoRec := 0;
      end else begin
        clear_e(tPED_PEDIDOICO);
        putitem_e(tPED_PEDIDOICO, 'CD_EMPRESA', item_f('CD_EMPRESA', tPED_PEDIDOCCO));
        putitem_e(tPED_PEDIDOICO, 'CD_PEDIDO', item_f('CD_PEDIDO', tPED_PEDIDOCCO));
        retrieve_e(tPED_PEDIDOICO);
        if (xStatus >= 0) then begin
          setocc(tTRA_TRANSACAO, 1);
          while (xStatus >= 0) do begin
            if (empty(tTRA_TRANSITEM) = False) then begin
              setocc(tTRA_TRANSITEM, 1);
              while (xStatus >= 0) do begin
                clear_e(tPED_PEDIDOICO);
                putitem_e(tPED_PEDIDOICO, 'CD_EMPRESA', item_f('CD_EMPRESA', tPED_PEDIDOCCO));
                putitem_e(tPED_PEDIDOICO, 'CD_PEDIDO', item_f('CD_PEDIDO', tPED_PEDIDOCCO));
                putitem_e(tPED_PEDIDOICO, 'CD_PRODUTO', item_f('CD_PRODUTO', tTRA_TRANSITEM));
                putitem_e(tPED_PEDIDOICO, 'CD_PESCOMIS', item_f('CD_PESCOMIS', tPED_PEDIDOCCO));
                putitem_e(tPED_PEDIDOICO, 'TP_COMISSIONADO', item_f('TP_COMISSIONADO', tPED_PEDIDOICO));
                retrieve_e(tPED_PEDIDOICO);
                if (xStatus >= 0) then begin
                  vVlComissFatItem := vVlComissFatItem + (item_f('VL_TOTALLIQUIDO', tTRA_TRANSITEM) * item_f('PR_COMISSAOFAT', tPED_PEDIDOICO) / 100);
                  vVlComissRecItem := vVlComissRecItem + (item_f('VL_TOTALLIQUIDO', tTRA_TRANSITEM) * item_f('PR_COMISSAOREC', tPED_PEDIDOICO) / 100);
                end else begin
                  vVlComissFatItem := vVlComissFatItem + (item_f('VL_TOTALLIQUIDO', tTRA_TRANSITEM) * item_f('PR_COMISSAOFAT', tPED_PEDIDOCCO) / 100);
                  vVlComissRecItem := vVlComissRecItem + (item_f('VL_TOTALLIQUIDO', tTRA_TRANSITEM) * item_f('PR_COMISSAOREC', tPED_PEDIDOCCO) / 100);
                end;

                vVlTotalItem := vVlTotalItem + item_f('VL_TOTALLIQUIDO', tTRA_TRANSITEM);

                setocc(tTRA_TRANSITEM, curocc(tTRA_TRANSITEM) + 1);
              end;
            end;

            setocc(tTRA_TRANSACAO, curocc(tTRA_TRANSACAO) + 1);
          end;

          vPrComissaoFat := vVlComissFatItem / vVlTotalItem * 100;
          vPrComissaoRec := vVlComissRecItem / vVlTotalItem * 100;
        end else begin
          vPrComissaoFat := item_f('PR_COMISSAOFAT', tPED_PEDIDOCCO);
          vPrComissaoRec := item_f('PR_COMISSAOREC', tPED_PEDIDOCCO);
        end;
      end;

      putitemXml(vDsRegistro, 'CD_PESCOMIS', item_f('CD_PESCOMIS', tPED_PEDIDOCCO));

      if (item_f('CD_TIPOCOMIS', tCOM_ESTRUTURA) > 0) then begin
        clear_e(tCOM_DOCTIPOCO);
        putitem_e(tCOM_DOCTIPOCO, 'CD_TIPOCOMIS', item_f('CD_TIPOCOMIS', tCOM_ESTRUTURA));
        putitem_e(tCOM_DOCTIPOCO, 'TP_DOCUMENTO', vTpDocumento);
        retrieve_e(tCOM_DOCTIPOCO);
        if (xStatus >= 0) then begin
          if (item_b('IN_AGRUPAPERC', tCOM_DOCTIPOCO) = True) then begin
            vPrComissaoFat := vPrComissaoFat + vPrComissaoRec;
            vPrComissaoRec := vPrComissaoFat;
          end;
          if (item_b('IN_FATURAMENTO', tCOM_DOCTIPOCO) = False) then begin
            vInFat := False;
            putitemXml(vDsRegistro, 'PR_COMISSAOFAT', 0);
          end;
            if (item_b('IN_RECEBIMENTO', tCOM_DOCTIPOCO) = False) then begin
            vInRec := False;
            putitemXml(vDsRegistro, 'PR_COMISSAOREC', 0);
          end;
        end;
      end;
      if (vInFat = True) then begin
        vVlCalc := vVlFatura * vPrComissaoFat / 100;
        vVlComissaoFat := roundto(vVlCalc, 2);
        putitemXml(vDsRegistro, 'PR_COMISSAOFAT', vPrComissaoFat);
        putitemXml(vDsRegistro, 'VL_COMISSAOFAT', vVlComissaoFat);
      end;
      if (vInRec = True) then begin
        vVlCalc := vVlFatura * vPrComissaoRec / 100;
        vVlComissaoRec := roundto(vVlCalc, 2);
        putitemXml(vDsRegistro, 'PR_COMISSAOREC', vPrComissaoRec);
        putitemXml(vDsRegistro, 'VL_COMISSAOREC', vVlComissaoRec);
      end;

      vCdTipoClass := 0;
      vCdClass := 0;

      if (gCdTipoClassComis > 0) then begin
        clear_e(tPED_PEDIDOI);
        putitem_e(tPED_PEDIDOI, 'CD_EMPRESA', item_f('CD_EMPRESA', tPED_PEDIDOC));
        putitem_e(tPED_PEDIDOI, 'CD_PEDIDO', item_f('CD_PEDIDO', tPED_PEDIDOC));
        retrieve_e(tPED_PEDIDOI);
        if (xStatus >= 0) then begin
          setocc(tPED_PEDIDOI, 1);
          clear_e(tPRD_PRODUTOCL);
          putitem_e(tPRD_PRODUTOCL, 'CD_PRODUTO', item_f('CD_PRODUTO', tPED_PEDIDOI));
          putitem_e(tPRD_PRODUTOCL, 'CD_TIPOCLAS', gCdTipoClassComis);
          retrieve_e(tPRD_PRODUTOCL);
          if (xStatus >= 0) then begin
            vCdTipoClass := item_f('CD_TIPOCLAS', tPRD_PRODUTOCL);
            vCdClass := item_f('CD_CLASSIFICACAO', tPRD_PRODUTOCL);
          end;
        end;
      end;
      putitemXml(vDsRegistro 'CD_TIPOCLASS', vCdTipoClass);
      putitemXml(vDsRegistro 'CD_CLASS', vCdClass);
      putitem(vDsLstComissao,  vDsRegistro);

      setocc(tPED_PEDIDOCCO, curocc(tPED_PEDIDOCCO) + 1);
    end;
  end else begin
    viParams := '';
    putitemXml(viParams, 'CD_PESSOA', vCdRepresentante);

    if (item_f('PR_COMISSAOFAT', tPED_PEDIDOC) > 0 ) or (item_f('PR_COMISSAOREC', tPED_PEDIDOC) > 0) then begin
      putitemXml(viParams, 'IN_OBRIGATORIO', True);
    end;

    voParams := activateCmp('COMSVCO001', 'buscaComissionado', viParams);
    if (xStatus < 0) then begin
      Result := voParams;
      return(-1); exit;
    end;

    vDsLstComissionado := itemXml('DS_LSTCOMISSIONADO', voParams);

    if (vDsLstComissionado <> '') then begin
      repeat
        getitem(vDsRegistro, vDsLstComissionado, 1);

        if (gInZeraRepreComis = 1) then begin
          if (item_f('CD_PESSOA', tTRA_TRANSACAO)= item_f('CD_REPRESENTANT', tTRA_TRANSACAO)) then begin
            vPrComissaoFat := 0;
            vPrComissaoRec := 0;
          end else begin
            vPrComissaoFat := itemXmlF('PR_COMISSAOFAT', vDsRegistro);
            vPrComissaoRec := itemXmlF('PR_COMISSAOREC', vDsRegistro);
          end;
        end else begin
          vPrComissaoFat := itemXmlF('PR_COMISSAOFAT', vDsRegistro);
          vPrComissaoRec := itemXmlF('PR_COMISSAOREC', vDsRegistro);
        end;

        vCdTipoComis := itemXmlF('CD_TIPOCOMIS', vDsRegistro);
        vCdPesComis := itemXmlF('CD_PESCOMIS', vDsRegistro);

        if (gTpComissaoRepre = False ) or (gTpComissaoRepre = 2)  and (empty(tPED_PEDIDOC) = False) then begin
          if (vCdRepresentante = vCdPesComis) then begin
            if (gInZeraRepreComis = 1) then begin
              if (item_f('CD_PESSOA', tTRA_TRANSACAO) = item_f('CD_REPRESENTANT', tTRA_TRANSACAO)) then begin
                vPrComissaoFat := 0;
                vPrComissaoRec := 0;
              end else begin
                vPrComissaoFat := item_f('PR_COMISSAOFAT', tPED_PEDIDOC);
                vPrComissaoRec := item_f('PR_COMISSAOREC', tPED_PEDIDOC);
              end;
            end else begin
              vPrComissaoFat := item_f('PR_COMISSAOFAT', tPED_PEDIDOC);
              vPrComissaoRec := item_f('PR_COMISSAOREC', tPED_PEDIDOC);
            end;
          end;
        end;
        vInFat := True;
        vInRec := True;

        if (vCdTipoComis > 0) then begin
          clear_e(tCOM_DOCTIPOCO);
          putitem_e(tCOM_DOCTIPOCO, 'CD_TIPOCOMIS', vCdTipoComis);
          putitem_e(tCOM_DOCTIPOCO, 'TP_DOCUMENTO', vTpDocumento);
          retrieve_e(tCOM_DOCTIPOCO);
          if (xStatus >= 0) then begin
            if (item_b('IN_AGRUPAPERC', tCOM_DOCTIPOCO) = True) then begin
              vPrComissaoFat := vPrComissaoFat + vPrComissaoRec;
              vPrComissaoRec := vPrComissaoFat;
            end;
            if (item_b('IN_FATURAMENTO', tCOM_DOCTIPOCO) = False) then begin
              vInFat := False;
              putitemXml(vDsRegistro, 'PR_COMISSAOFAT', 0);
            end;
            if (item_b('IN_RECEBIMENTO', tCOM_DOCTIPOCO) = False) then begin
              vInRec := False;
              putitemXml(vDsRegistro, 'PR_COMISSAOREC', 0);
            end;
          end;
        end;
        if (vInFat = True) then begin
          vVlCalc := vVlFatura * vPrComissaoFat / 100;
          vVlComissaoFat := roundto(vVlCalc, 2);
          putitemXml(vDsRegistro, 'PR_COMISSAOFAT', vPrComissaoFat);
          putitemXml(vDsRegistro, 'VL_COMISSAOFAT', vVlComissaoFat);
        end;
        if (vInRec = True) then begin
          vVlCalc := vVlFatura * vPrComissaoRec / 100;
          vVlComissaoRec := roundto(vVlCalc, 2);
          putitemXml(vDsRegistro, 'PR_COMISSAOREC', vPrComissaoRec);
          putitemXml(vDsRegistro, 'VL_COMISSAOREC', vVlComissaoRec);
        end;

        vCdTipoClass := '';
        vCdClass := '';
        if (gCdTipoClassComis > 0)  and (item_f('CD_PEDIDO', tPED_PEDIDOC) <> '') then begin
          clear_e(tPED_PEDIDOI);
          putitem_e(tPED_PEDIDOI, 'CD_EMPRESA', item_f('CD_EMPRESA', tPED_PEDIDOC));
          putitem_e(tPED_PEDIDOI, 'CD_PEDIDO', item_f('CD_PEDIDO', tPED_PEDIDOC));
          retrieve_e(tPED_PEDIDOI);
          if (xStatus >= 0) then begin
            setocc(tPED_PEDIDOI, 1);
            clear_e(tPRD_PRODUTOCL);
            putitem_e(tPRD_PRODUTOCL, 'CD_PRODUTO', item_f('CD_PRODUTO', tPED_PEDIDOI));
            putitem_e(tPRD_PRODUTOCL, 'CD_TIPOCLAS', gCdTipoClassComis);
            retrieve_e(tPRD_PRODUTOCL);
            if (xStatus >= 0) then begin
              vCdTipoClass := item_f('CD_TIPOCLAS', tPRD_PRODUTOCL);
              vCdClass := item_f('CD_CLASSIFICACAO', tPRD_PRODUTOCL);
            end;
          end;
        end;
        putitemXml(vDsRegistro 'CD_TIPOCLASS', vCdTipoClass);
        putitemXml(vDsRegistro 'CD_CLASS', vCdClass);
        putitem(vDsLstComissao,  vDsRegistro);

        delitem(vDsLstComissionado, 1);
      until (vDsLstComissionado = '');
    end;
  end;

  vPrReducao := vVlTotProduto / vVlTotTransacao;

  voParams := calcularTotalComissao(viParams); (* gInComissaoRepreProd, vDsLstComissao, vVlFatura, vPrReducao *)
  if (xStatus < 0) then begin
    Result := voParams;
    return(-1); exit;
  end;

  Result := '';
  putitemXml(Result, 'DS_LSTCOMISSAO', vDsLstComissao);

  return(0); exit;
end;

//-----------------------------------------------------------------------
function T_COMSVCO002.calculaComissaoContrato(pParams : String) : String;
//-----------------------------------------------------------------------
const
  cDS_METHOD = 'ADICONAL=Operação: T_COMSVCO002.calculaComissaoContrato()';
var
  vCdEmpContrato, vNrSeqContrato, vNrSeqItem, vVlCalc, vVlFatura, vPrComissaoFat, vPrComissaoRec, vNrParcela : Real;
  vDsLstComissao, vDsRegistro, viParams, voParams : String;
  vCdEmpTransacao, vNrTransacao : Real;
  vDtTransacao : TDate;
begin
  vCdEmpContrato := itemXmlF('CD_EMPCONTRATO', pParams);
  vNrSeqContrato := itemXmlF('NR_SEQCONTRATO', pParams);
  vNrSeqItem := itemXmlF('NR_SEQITEM', pParams);
  vVlFatura := itemXmlF('VL_FATURA', pParams);

  vCdEmpTransacao := itemXmlF('CD_EMPTRANSACAO', pParams);
  vDtTransacao := itemXml('DT_TRANSACAO', pParams);
  vNrTransacao := itemXmlF('NR_TRANSACAO', pParams);
  if (vNrSeqItem = 0) then begin
    voParams := buscaItemContrato(viParams); (* vCdEmpTransacao, vDtTransacao, vNrTransacao, vNrSeqItem *)
    if (xStatus < 0) then begin
      Result := voParams;
      return(-1); exit;
    end;
  end;
  if (vCdEmpContrato = 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Empresa do contrato não informada!', cDS_METHOD);
    return(-1); exit;
  end;
  if (vNrSeqContrato = 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Sequência do contrato não informada!', cDS_METHOD);
    return(-1); exit;
  end;
  if (vNrSeqItem = 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Item de contrato não informado!', cDS_METHOD);
    return(-1); exit;
  end;
  if (vVlFatura = 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Valor da fatura não informado!', cDS_METHOD);
    return(-1); exit;
  end;

  clear_e(tIMB_CONTRATO);
  putitem_e(tIMB_CONTRATO, 'CD_EMPRESA', vCdEmpContrato);
  putitem_e(tIMB_CONTRATO, 'NR_SEQ', vNrSeqContrato);
  retrieve_e(tIMB_CONTRATO);
  if (xStatus < 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Contrato ' + FloatToStr(vNrSeqContrato) + ' não cadastrado na empresa ' + FloatToStr(vCdEmpContrato!',) + ' cDS_METHOD);
    return(-1); exit;
  end;

  clear_e(tIMB_CONTRATOI);
  putitem_e(tIMB_CONTRATOI, 'NR_SEQITEM', vNrSeqItem);
  retrieve_e(tIMB_CONTRATOI);
  if (xStatus < 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Item de contrato ' + FloatToStr(vNrSeqItem) + ' não encontrado para o contrato ' + FloatToStr(vNrSeqContrato!',) + ' cDS_METHOD);
    return(-1); exit;
  end;

  setocc(tIMB_CONTRATOIPAR, -1);
  vNrParcela := totocc('IMB_CONTRATOIPARSVC');
  setocc(tIMB_CONTRATOIPAR, 1);

  if (empty(tIMB_COMISSAO) = False) then begin
    vDsLstComissao := '';
    setocc(tIMB_COMISSAO, 1);
    while (xStatus >= 0) do begin

      if (item_f('NR_PARCELA', tIMB_CONTRATOI) >= item_f('NR_PARCELAINI', tIMB_COMISSAO) ) and (item_f('NR_PARCELA', tIMB_CONTRATOI) <= item_f('NR_PARCELAFIM', tIMB_COMISSAO)) then begin
        viParams := '';

        putitemXml(viParams, 'CD_EMPRESA', item_f('CD_EMPRESA', tIMB_CONTRATOI));
        putitemXml(viParams, 'NR_SEQ', item_f('NR_SEQ', tIMB_CONTRATOI));
        putitemXml(viParams, 'NR_SEQITEM', item_f('NR_SEQITEM', tIMB_CONTRATOI));
        putitemXml(viParams, 'NR_SEQCOMISSAO', item_f('NR_SEQCOMISSAO', tIMB_COMISSAO));
        voParams := activateCmp('SICSVCO016', 'validaValorComissao', viParams);
        if (xStatus < 0) then begin
          Result := voParams;
          return(-1); exit;
        end;
        vPrComissaoFat := itemXmlF('PR_COMISSAOFAT', voParams);
        vPrComissaoRec := itemXmlF('PR_COMISSAOREC', voParams);

        vDsRegistro := '';
        putitemXml(vDsRegistro, 'CD_PESCOMIS', item_f('CD_REPRESENTANTE', tIMB_COMISSAO));
        putitemXml(vDsRegistro, 'CD_TIPOCOMIS', 1);
        putitemXml(vDsRegistro, 'PR_COMISSAOFAT', vPrComissaoFat);
        putitemXml(vDsRegistro, 'PR_COMISSAOREC', vPrComissaoRec);
        if (item_f('VL_FATURAMENTO', tIMB_COMISSAO) = 0) then begin
          vVlCalc := vVlFatura * vPrComissaoFat / 100;
          vVlCalc := roundto(vVlCalc, 2);
          vVlCalc := vVlCalc / vNrParcela;
        end else begin
          vVlCalc := item_f('VL_FATURAMENTO', tIMB_COMISSAO);
          vVlCalc := vVlCalc / vNrParcela;
        end;
        putitemXml(vDsRegistro, 'VL_COMISSAOFAT', vVlCalc);
        if (item_f('VL_RECEBIMENTO', tIMB_COMISSAO) = 0) then begin
          vVlCalc := vVlFatura * vPrComissaoRec / 100;
          vVlCalc := roundto(vVlCalc, 2);
          vVlCalc := vVlCalc / vNrParcela;
        end else begin
          vVlCalc := item_f('VL_RECEBIMENTO', tIMB_COMISSAO);
          vVlCalc := vVlCalc / vNrParcela;
        end;
        putitemXml(vDsRegistro, 'VL_COMISSAOREC', vVlCalc);
        putitemXml(vDsRegistro, 'CD_TIPOCLASS', '');
        putitemXml(vDsRegistro, 'CD_CLASS', '');
        putitem(vDsLstComissao,  vDsRegistro);
      end;

      setocc(tIMB_COMISSAO, curocc(tIMB_COMISSAO) + 1);
    end;
  end;

  Result := '';
  putitemXml(Result, 'DS_LSTCOMISSAO', vDsLstComissao);

  return(0); exit;
end;

end.
