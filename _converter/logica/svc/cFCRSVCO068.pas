unit cFCRSVCO068;

interface

(* COMPONENTES 
  ADMSVCO001 / FCCSVCO002 / FCPSVCO001 / FCPSVCO014 / FCRSVCO001
  FCRSVCO068 / 
*)        

uses
  Classes, SysUtils, Math, DB,
  cServiceUnf, cDataSetUnf;

type
  T_FCRSVCO068 = class(TcServiceUnf)
  private
    tFCC_MOV,
    tFCR_CHEQUEPRES,
    tFCR_FATURAI,
    tFGR_LIQICRADIC,
    tFGR_LIQITEMCC,
    tFGR_LIQITEMCR,
    tGER_EMPRESA : TcDatasetUnf;
    function getParam(pParams : String = '') : String;
    function setEntidade(pParams : String = '') : String;
  protected
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;    
  published
    function gravarChequePresente(pParams : String = '') : String;
    function gravarUtilizacaoChequePresente(pParams : String = '') : String;
    function cancelarChequePresente(pParams : String = '') : String;
    function cancelarUtilizacaoChequePresente(pParams : String = '') : String;
    function buscaParametro(pParams : String = '') : String;
    function zeramentoChequePresente(pParams : String = '') : String;
    function atualizarChequePresente(pParams : String = '') : String;
    function buscaSaldoChequePresente(pParams : String = '') : String;
    function lancaMovimentoDebito(pParams : String = '') : String;
    function gravarMovimentacaoCartaoPresente(pParams : String = '') : String;
    function cancelarUtilizacaoChequePresCC(pParams : String = '') : String;
  end;

implementation

uses
  cADMSVCO001,
  cActivate, cStatus, cFuncao, cXml, dModulo;

var
  gCdCentroCusto,
  gCdDespesaChequePresente,
  gCdMoeda,
  gNrPortadorCarteira,
  gTpChequePresente : Real;

//---------------------------------------------------------------
constructor T_FCRSVCO068.Create(AOwner: TComponent);
//---------------------------------------------------------------
begin
  inherited Create(AOwner);
  setEntidade('');
end;

//--------------------------------
destructor T_FCRSVCO068.Destroy;
//--------------------------------
begin
  inherited Destroy;
end;

//---------------------------------------------------------------
function T_FCRSVCO068.getParam(pParams : String = '') : String;
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

  xParamEmp := '';
  putitem(xParamEmp, 'CD_DESPESA_CHEQUEPRESENTE_CCUSTO');
  putitem(xParamEmp, 'CD_DESPESA_CHEQUEPRESENTE');
  putitem(xParamEmp, 'CD_MOEDA');
  putitem(xParamEmp, 'NR_PORTADOR_CARTEIRA');
  putitem(xParamEmp, 'TP_CHEQUE_PRESENTE');
  xParamEmp := T_ADMSVCO001.GetParamEmpresa(piCdEmpresa, xParamEmp);

  gCdCentroCusto := itemXmlF('CD_DESPESA_CHEQUEPRESENTE_CCUSTO', xParamEmp);
  gCdDespesaChequePresente := itemXmlF('CD_DESPESA_CHEQUEPRESENTE', xParamEmp);
  gCdMoeda := itemXmlF('CD_MOEDA', xParamEmp);
  gNrPortadorCarteira := itemXmlF('NR_PORTADOR_CARTEIRA', xParamEmp);
  gTpChequePresente := itemXmlF('TP_CHEQUE_PRESENTE', xParamEmp);
end;

//---------------------------------------------------------------
function T_FCRSVCO068.setEntidade(pParams : String = '') : String;
//---------------------------------------------------------------
begin
  tFCC_MOV := GetEntidade('FCC_MOV');
  tFCR_CHEQUEPRES := GetEntidade('FCR_CHEQUEPRES');
  tFCR_FATURAI := GetEntidade('FCR_FATURAI');
  tFGR_LIQICRADIC := GetEntidade('FGR_LIQICRADIC');
  tFGR_LIQITEMCC := GetEntidade('FGR_LIQITEMCC');
  tFGR_LIQITEMCR := GetEntidade('FGR_LIQITEMCR');
  tGER_EMPRESA := GetEntidade('GER_EMPRESA');
end;

//--------------------------------------------------------------------
function T_FCRSVCO068.gravarChequePresente(pParams : String) : String;
//--------------------------------------------------------------------
const
  cDS_METHOD = 'ADICONAL=Operação: T_FCRSVCO068.gravarChequePresente()';
var
  vDsRegistro, vDsLstCampo, vDsCampo, vNmCheque, vCdComponente, viParams, voParams, vCdBarra : String;
  vCdEmpresa, vCdCliente, vCdTipoCampo, vNrGeral, vNrCheque, vVlCheque : Real;
  vCdEmpLiq, vNrSeqLiq, vNrCtaPes, vNrTransacao : Real;
  vDtCheque, vDtLiq : String;
begin
  voParams := buscaParametro(viParams); (* *)
  if (xStatus < 0) then begin
    Result := voParams;
    return(-1); exit;
  end;

  vVlCheque := itemXmlF('VL_CHEQUE', pParams);
  vDtCheque := itemXml('DT_CHEQUE', pParams);
  vNmCheque := itemXml('NM_CHEQUE', pParams);
  vCdEmpresa := itemXmlF('CD_EMPRESA', pParams);
  vCdCliente := itemXmlF('CD_CLIENTE', pParams);
  vCdEmpLiq := itemXmlF('CD_EMPLIQ', pParams);
  vDtLiq := itemXml('DT_LIQ', pParams);
  vNrSeqLiq := itemXmlF('NR_SEQLIQ', pParams);
  vCdComponente := itemXml('CD_COMPONENTE', pParams);

  vCdBarra := itemXml('CD_BARRA', pParams);
  if (gTpChequePresente = 1)  and (vCdBarra = '') then begin
    Result := SetStatus(STS_ERROR, 'GEN001', 'É obrigatório o código de barras quando parâmetro empresa TP_CHEQUE_PRESENTE for 1.', cDS_METHOD);
    return(-1); exit;
  end;
  if (vVlCheque = 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN001', 'Valor do cheque não informado para gravação do cheque presente.', cDS_METHOD);
    return(-1); exit;
  end;
  if (vDtCheque = '') then begin
    Result := SetStatus(STS_ERROR, 'GEN001', 'Data do cheque não informada para gravação do cheque presente.', cDS_METHOD);
    return(-1); exit;
  end;
  if (vNmCheque = '') then begin
    Result := SetStatus(STS_ERROR, 'GEN001', 'Nominal do cheque não informado para gravação do cheque presente.', cDS_METHOD);
    return(-1); exit;
  end;
  if (vCdEmpresa = 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN001', 'Empresa não informada para gravação do cheque presente.', cDS_METHOD);
    return(-1); exit;
  end;
  if (vCdCliente = 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN001', 'Cliente não informado para gravação do cheque presente.', cDS_METHOD);
    return(-1); exit;
  end;
  if (vCdEmpLiq = 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN001', 'Empresa de liquidação não informada para gravação do cheque presente.', cDS_METHOD);
    return(-1); exit;
  end;
  if (vNrSeqLiq = 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN001', 'Número de sequência de liquidação não informado para gravação do cheque presente.', cDS_METHOD);
    return(-1); exit;
  end;
  if (vDtLiq = '') then begin
    Result := SetStatus(STS_ERROR, 'GEN001', 'Data de liquidação não informada para gravação do cheque presente.', cDS_METHOD);
    return(-1); exit;
  end;
  if (vCdComponente = '') then begin
    Result := SetStatus(STS_ERROR, 'GEN001', 'Código de componente não informado para gravação do cheque presente.', cDS_METHOD);
    return(-1); exit;
  end;

  vNrCheque := SetarValorF(gModulo.ConsultaSql(
    'select max(NR_CHEQUE) as ULTIMA ' +
    'from FCR_CHEQUEPRES ' +
    'where CD_EMPRESA = ' + FloatToStr(vCdEmpresa) + ' ' +
    'and CD_CLIENTE = ' + FloatToStr(vCdCliente) + ' ', 'ULTIMA'), '0') + 1;

  if (vNrCheque = 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN001', 'Número de cheque não informado para gravação do cheque presente.', cDS_METHOD);
    return(-1); exit;
  end;

  clear_e(tFCR_CHEQUEPRES);
  creocc(tFCR_CHEQUEPRES, -1);
  putitem_e(tFCR_CHEQUEPRES, 'CD_EMPRESA', vCdEmpresa);
  putitem_e(tFCR_CHEQUEPRES, 'CD_CLIENTE', vCdCliente);
  putitem_e(tFCR_CHEQUEPRES, 'NR_CHEQUE', vNrCheque);
  retrieve_o(tFCR_CHEQUEPRES);
  if (xStatus = -7) then begin
    retrieve_x(tFCR_CHEQUEPRES);
  end;
  putitem_e(tFCR_CHEQUEPRES, 'CD_OPERADOR', itemXmlF('CD_USUARIO', PARAM_GLB));
  putitem_e(tFCR_CHEQUEPRES, 'DT_CADASTRO', Now);
  putitem_e(tFCR_CHEQUEPRES, 'DT_EMISSAO', Now);
  putitem_e(tFCR_CHEQUEPRES, 'DT_VALIDADE', vDtCheque);
  putitem_e(tFCR_CHEQUEPRES, 'DS_NOMINAL', vNmCheque);
  putitem_e(tFCR_CHEQUEPRES, 'VL_CHEQUE', vVlCheque);
  putitem_e(tFCR_CHEQUEPRES, 'DT_INCLUSAO', Now);
  putitem_e(tFCR_CHEQUEPRES, 'CD_OPERINCL', itemXmlF('CD_USUARIO', PARAM_GLB));
  putitem_e(tFCR_CHEQUEPRES, 'DT_UTILIZACAO', '');
  putitem_e(tFCR_CHEQUEPRES, 'CD_OPERUTIL', '');
  putitem_e(tFCR_CHEQUEPRES, 'DT_CANCELAMENTO', '');
  putitem_e(tFCR_CHEQUEPRES, 'CD_OPERCANCEL', '');
  putitem_e(tFCR_CHEQUEPRES, 'TP_SITUACAO', 1);
  putitem_e(tFCR_CHEQUEPRES, 'CD_EMPLIQ', vCdEmpLiq);
  putitem_e(tFCR_CHEQUEPRES, 'DT_LIQ', vDtLiq);
  putitem_e(tFCR_CHEQUEPRES, 'NR_SEQLIQ', vNrSeqLiq);
  putitem_e(tFCR_CHEQUEPRES, 'CD_BARRA', vCdBarra);
  if (gTpChequePresente = 1) then begin
    putitem_e(tFCR_CHEQUEPRES, 'TP_CHEQUE', 1);

    viParams := '';
    putitemXml(viParams, 'CD_PESSOA', vCdCliente);
    putitemXml(viParams, 'TP_CONTA', 'C');
    voParams := activateCmp('FCCSVCO002', 'buscaContaPessoa', viParams); (*,viParams,voParams,, *)
    if (xStatus < 0) then begin
      Result := voParams;
      return(-1); exit;
    end;
    vNrCtapes := itemXmlF('NR_CTAPES', voParams);
    putitem_e(tFCR_CHEQUEPRES, 'NR_CTAPES', vNrCtaPes);

    voParams := tFCR_CHEQUEPRES.Salvar();
    if (xStatus < 0) then begin
      Result := voParams;
      return(-1); exit;
    end;
    viParams := '';
    putitemXml(viParams, 'CD_EMPRESA', vCdEmpresa);
    putitemXml(viParams, 'NR_CTAPES', vNrCtapes);
    putitemXml(viParams, 'DT_MOVIMENTO', vDtLiq);
    putitemXml(viParams, 'CD_HISTORICO', 1093);
    putitemXml(viParams, 'TP_DOCUMENTO', 18);
    putitemXml(viParams, 'NR_SEQHISTRELSUB', 1);
    putitemXml(viParams, 'CD_EMPLIQ', vCdEmpLiq);
    putitemXml(viParams, 'DT_LIQ', vDtLiq);
    putitemXml(viParams, 'NR_SEQLIQ', vNrSeqLiq);
    putitemXml(viParams, 'VL_LANCTO', vVlCheque);
    putitemXml(viParams, 'IN_ESTORNO', False);
    putitemXml(viParams, 'IN_CAIXA', False);
    putitemXml(viParams, 'DS_DOC', 'Cred. Cheque presente');
    putitemXml(viParams, 'DS_AUX', '');
    putitemXml(viParams, 'CD_EMPCHQPRES', vCdEmpresa);
    putitemXml(viParams, 'CD_CLICHQPRES', vCdCliente);
    putitemXml(viParams, 'NR_CHEQUEPRES', vNrCheque);
    voParams := activateCmp('FCCSVCO002', 'movimentaConta', viParams); (*,viParams,voParams,, *)
    if (xStatus < 0) then begin
      Result := voParams;
      return(-1); exit;
    end;
  end else begin
    voParams := tFCR_CHEQUEPRES.Salvar();
    if (xStatus < 0) then begin
      Result := voParams;
      return(-1); exit;
    end;
  end;

  putitemXml(Result, 'NR_CHEQUE', item_f('NR_CHEQUE', tFCR_CHEQUEPRES));

  return(0); exit;
end;

//------------------------------------------------------------------------------
function T_FCRSVCO068.gravarUtilizacaoChequePresente(pParams : String) : String;
//------------------------------------------------------------------------------
const
  cDS_METHOD = 'ADICONAL=Operação: T_FCRSVCO068.gravarUtilizacaoChequePresente()';
var
  vDsRegistro, vDsLstCampo, vDsCampo, vNmCheque, vCdComponente : String;
  vCdEmpresa, vCdCliente, vCdTipoCampo, vNrGeral, vNrCheque, vVlCheque, vCdEmpFat, vCdClienteFat, vNrFat : Real;
  vNrParcela, vTpCheque : Real;
  vDtCheque : String;
begin
  vNrCheque := itemXmlF('NR_CHEQUE', pParams);
  vCdEmpresa := itemXmlF('CD_EMPRESA', pParams);
  vCdCliente := itemXmlF('CD_CLIENTE', pParams);
  vCdEmpFat := itemXmlF('CD_EMPFAT', pParams);
  vCdClienteFat := itemXmlF('CD_CLIFAT', pParams);
  vNrFat := itemXmlF('NR_FAT', pParams);
  vNrParcela := itemXmlF('NR_PARCELA', pParams);
  vTpCheque := itemXmlF('TP_CHEQUE', pParams);

  if (vNrCheque = '')  or (vNrCheque = 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN001', 'Número de cheque não informado para gravação do cheque presente.', cDS_METHOD);
    return(-1); exit;
  end;
  if (vCdEmpresa = '')  or (vCdEmpresa = 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN001', 'Empresa não informada para gravação do cheque presente.', cDS_METHOD);
    return(-1); exit;
  end;
  if (vCdCliente = '')  or (vCdCliente = 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN001', 'Cliente não informado para gravação do cheque presente.', cDS_METHOD);
    return(-1); exit;
  end;
  if (vTpCheque <> 1) then begin
    if (vCdEmpFat = '')  or (vCdEmpFat = 0) then begin
      Result := SetStatus(STS_ERROR, 'GEN001', 'Código da empresa da fatura não informado para gravação do cheque presente.', cDS_METHOD);
      return(-1); exit;
    end;
    if (vCdClienteFat = '')  or (vCdClienteFat = 0) then begin
      Result := SetStatus(STS_ERROR, 'GEN001', 'Código do cliente da fatura não informado para gravação do cheque presente.', cDS_METHOD);
      return(-1); exit;
    end;
    if (vNrFat = '')  or (vNrFat = 0) then begin
      Result := SetStatus(STS_ERROR, 'GEN001', 'Número da fatura não informado para gravação do cheque presente.', cDS_METHOD);
      return(-1); exit;
    end;
    if (vNrParcela = '')  or (vNrParcela = 0) then begin
      Result := SetStatus(STS_ERROR, 'GEN001', 'Número da parcela da fatura não informado para gravação do cheque presente.', cDS_METHOD);
      return(-1); exit;
    end;
  end;

  creocc(tFCR_CHEQUEPRES, -1);
  putitem_e(tFCR_CHEQUEPRES, 'CD_EMPRESA', vCdEmpresa);
  putitem_e(tFCR_CHEQUEPRES, 'CD_CLIENTE', vCdCliente);
  putitem_e(tFCR_CHEQUEPRES, 'NR_CHEQUE', vNrCheque);
  retrieve_o(tFCR_CHEQUEPRES);
  if (xStatus = -7) then begin
    retrieve_x(tFCR_CHEQUEPRES);
  end;
  putitem_e(tFCR_CHEQUEPRES, 'DT_UTILIZACAO', Now);
  putitem_e(tFCR_CHEQUEPRES, 'CD_OPERUTIL', itemXmlF('CD_USUARIO', PARAM_GLB));
  putitem_e(tFCR_CHEQUEPRES, 'TP_SITUACAO', 2);

  if (vTpCheque <> 1) then begin
    putitem_e(tFCR_CHEQUEPRES, 'CD_EMPFAT', vCdEmpFat);
    putitem_e(tFCR_CHEQUEPRES, 'CD_CLIENTEFAT', vCdClienteFat);
    putitem_e(tFCR_CHEQUEPRES, 'NR_FAT', vNrFat);
    putitem_e(tFCR_CHEQUEPRES, 'NR_PARCELA', vNrParcela);
  end;
  voParams := tFCR_CHEQUEPRES.Salvar();
  if (xStatus < 0) then begin
    Result := voParams;
    return(-1); exit;
  end;

  return(0); exit;
end;

//----------------------------------------------------------------------
function T_FCRSVCO068.cancelarChequePresente(pParams : String) : String;
//----------------------------------------------------------------------
const
  cDS_METHOD = 'ADICONAL=Operação: T_FCRSVCO068.cancelarChequePresente()';
var
  vCdEmpLiq,vNrSeqLiq : Real;
  vDtLiq : String;
begin
  vNrSeqLiq := itemXmlF('NR_SEQLIQ', pParams);
  vCdEmpLiq := itemXmlF('CD_EMPLIQ', pParams);
  vDtLiq := itemXml('DT_LIQ', pParams);

  if (vNrSeqLiq = '')  or (vNrSeqLiq = 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN001', 'Número de sequência de liquidação não informada.', cDS_METHOD);
    return(-1); exit;
  end;
  if (vCdEmpLiq = '')  or (vCdEmpLiq = 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN001', 'Empresa de liquidação não informada.', cDS_METHOD);
    return(-1); exit;
  end;
  if (vDtLiq = '')  or (vDtLiq = 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN001', 'Data de liquidação não informada.', cDS_METHOD);
    return(-1); exit;
  end;
  clear_e(tFCR_CHEQUEPRES);

  voParams := buscaParametro(viParams); (* *)
  if (xStatus < 0) then begin
    Result := voParams;
    return(-1); exit;
  end;
  if (gTpChequePresente = 1) then begin
    clear_e(tFCC_MOV);
    putitem_e(tFCC_MOV, 'CD_EMPLIQ', vCdEmpLiq);
    putitem_e(tFCC_MOV, 'DT_LIQ', vNrSeqLiq);
    putitem_e(tFCC_MOV, 'NR_SEQLIQ', vDtLiq);
    retrieve_e(tFCC_MOV);
    if (xStatus >=0) then begin
      clear_e(tFCR_CHEQUEPRES);
      putitem_e(tFCR_CHEQUEPRES, 'CD_EMPRESA', item_f('CD_EMPCHQPRES', tFCC_MOV));
      putitem_e(tFCR_CHEQUEPRES, 'CD_CLIENTE', item_f('CD_CLICHQPRES', tFCC_MOV));
      putitem_e(tFCR_CHEQUEPRES, 'NR_CHEQUE', item_f('NR_CHEQUEPRES', tFCC_MOV));
    end else begin
      Result := SetStatus(STS_ERROR, 'GEN001', 'Cheque Presente não encontrado na movimentação do conta corrente para cancelamento.', cDS_METHOD);
      return(-1); exit;
    end;
  end else begin

    putitem_e(tFCR_CHEQUEPRES, 'CD_EMPLIQ', vCdEmpLIq);
    putitem_e(tFCR_CHEQUEPRES, 'NR_SEQLIQ', vNrSeqLIq);
    putitem_e(tFCR_CHEQUEPRES, 'DT_LIQ', vDtLIq);
  end;
  retrieve_e(tFCR_CHEQUEPRES);
  if (xStatus < 0) then begin
    return(0); exit;
  end;
  setocc(tFCR_CHEQUEPRES, 1);
  while (xStatus >= 0) do begin

    if (item_f('TP_CHEQUE', tFCR_CHEQUEPRES) = 1) then begin
      Result := SetStatus(STS_ERROR, 'GEN001', 'Permitido cancelamento somente pela transação.', cDS_METHOD);
      return(-1); exit;
    end;
    if (item_a('DT_UTILIZACAO', tFCR_CHEQUEPRES) <> '') then begin
      Result := SetStatus(STS_ERROR, 'GEN001', 'Cheque Presente com situação de Utilizado.', cDS_METHOD);
      return(-1); exit;
    end;

    putitem_e(tFCR_CHEQUEPRES, 'DT_CANCELAMENTO', Now);
    putitem_e(tFCR_CHEQUEPRES, 'CD_OPERCANCEL', itemXmlF('CD_USUARIO', PARAM_GLB));
    putitem_e(tFCR_CHEQUEPRES, 'TP_SITUACAO', 3);

    setocc(tFCR_CHEQUEPRES, curocc(tFCR_CHEQUEPRES) + 1);
  end;

  voParams := tFCR_CHEQUEPRES.Salvar();
  if (xStatus < 0) then begin
    Result := voParams;
    return(-1); exit;
  end;

  return(0); exit;
end;

//--------------------------------------------------------------------------------
function T_FCRSVCO068.cancelarUtilizacaoChequePresente(pParams : String) : String;
//--------------------------------------------------------------------------------
const
  cDS_METHOD = 'ADICONAL=Operação: T_FCRSVCO068.cancelarUtilizacaoChequePresente()';
var
  vCdEmpFat, vCdClienteFat, vNrFat, vNrParcela : Real;
begin
  vCdEmpFat := itemXmlF('CD_EMPFAT', pParams);
  vCdClienteFat := itemXmlF('CD_CLIENTEFAT', pParams);
  vNrFat := itemXmlF('NR_FAT', pParams);
  vNrParcela := itemXmlF('NR_PARCELA', pParams);

  if (vCdEmpFat = '')  or (vCdEmpFat = 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN001', 'Código da empresa da fatura não informado para gravação do cheque presente.', cDS_METHOD);
    return(-1); exit;
  end;
  if (vCdClienteFat = '')  or (vCdClienteFat = 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN001', 'Código do cliente da fatura não informado para gravação do cheque presente.', cDS_METHOD);
    return(-1); exit;
  end;
  if (vNrFat = '')  or (vNrFat = 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN001', 'Número da fatura não informado para gravação do cheque presente.', cDS_METHOD);
    return(-1); exit;
  end;
  if (vNrParcela = '')  or (vNrParcela = 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN001', 'Número da parcela da fatura não informado para gravação do cheque presente.', cDS_METHOD);
    return(-1); exit;
  end;

  clear_e(tFCR_CHEQUEPRES);
  putitem_e(tFCR_CHEQUEPRES, 'CD_EMPFAT', vCdEmpFat);
  putitem_e(tFCR_CHEQUEPRES, 'CD_CLIENTEFAT', vCdClienteFat);
  putitem_e(tFCR_CHEQUEPRES, 'NR_FAT', vNrFat);
  putitem_e(tFCR_CHEQUEPRES, 'NR_PARCELA', vNrParcela);
  retrieve_e(tFCR_CHEQUEPRES);
  if (xStatus < 0) then begin
    return(0); exit;
  end;
  setocc(tFCR_CHEQUEPRES, 1);
  while (xStatus >= 0) do begin
    if (item_f('TP_SITUACAO', tFCR_CHEQUEPRES) <> 2) then begin
      Result := SetStatus(STS_ERROR, 'GEN001', 'Cheque Presente com situação diferente de Utilizado.', cDS_METHOD);
      return(-1); exit;
    end;
    putitem_e(tFCR_CHEQUEPRES, 'DT_UTILIZACAO', '');
    putitem_e(tFCR_CHEQUEPRES, 'CD_OPERUTIL', '');
    putitem_e(tFCR_CHEQUEPRES, 'TP_SITUACAO', 1);
    putitem_e(tFCR_CHEQUEPRES, 'CD_EMPFAT', '');
    putitem_e(tFCR_CHEQUEPRES, 'CD_CLIENTEFAT', '');
    putitem_e(tFCR_CHEQUEPRES, 'NR_FAT', '');
    putitem_e(tFCR_CHEQUEPRES, 'NR_PARCELA', '');

    setocc(tFCR_CHEQUEPRES, curocc(tFCR_CHEQUEPRES) + 1);
  end;

  voParams := tFCR_CHEQUEPRES.Salvar();
  if (xStatus < 0) then begin
    Result := voParams;
    return(-1); exit;
  end;

  return(0); exit;
end;

//--------------------------------------------------------------
function T_FCRSVCO068.buscaParametro(pParams : String) : String;
//--------------------------------------------------------------
const
  cDS_METHOD = 'ADICONAL=Operação: T_FCRSVCO068.buscaParametro()';
var
  viParams, voParams : String;
begin
  viParams := '';
  putitem(viParams,  'TP_CHEQUE_PRESENTE');
  putitem(viParams,  'NR_PORTADOR_CARTEIRA');
  putitem(viParams,  'CD_DESPESA_CHEQUEPRESENTE');
  putitem(viParams,  'CD_DESPESA_CHEQUEPRESENTE_CCUSTO');
  putitem(viParams,  'NR_PORTADOR_CARTEIRA');
  putitem(viParams,  'CD_MOEDA');
  xParamEmp := T_ADMSVCO001.GetParamEmpresa(piCdEmpresa, xParamEmp); (*itemXml('CD_EMPRESA', *)

  gTpChequePresente := itemXmlF('TP_CHEQUE_PRESENTE', voParams);
  gNrPortadorCarteira := itemXmlF('NR_PORTADOR_CARTEIRA', voParams);
  gCdDespesaChequePresente := itemXmlF('CD_DESPESA_CHEQUEPRESENTE', voParams);
  gCdCentroCusto := itemXmlF('CD_DESPESA_CHEQUEPRESENTE_CCUSTO', voParams);
  gCdMoeda := itemXmlF('CD_MOEDA', voParams);

  return(0); exit;
end;

//-----------------------------------------------------------------------
function T_FCRSVCO068.zeramentoChequePresente(pParams : String) : String;
//-----------------------------------------------------------------------
const
  cDS_METHOD = 'ADICONAL=Operação: T_FCRSVCO068.zeramentoChequePresente()';
var
  viParams, voParams : String;
  vCdEmpresa, vCdCliente, vNrCheque, vVlSaldo, vCdEmpLiq, vNrSeqLiq, vNrCtaPes : Real;
  vDtLiq, vDtSistema : String;
begin
  vCdEmpresa := itemXmlF('CD_EMPRESA', pParams);
  vCdCliente := itemXmlF('CD_CLIENTE', pParams);
  vNrCheque := itemXmlF('NR_CHEQUE', pParams);
  vVlSaldo := itemXmlF('VL_SALDO', pParams);
  vCdEmpLiq := itemXmlF('CD_EMPLIQ', pParams);
  vNrSeqLiq := itemXmlF('NR_SEQLIQ', pParams);
  vDtLiq := itemXml('DT_LIQ', pParams);
  vNrCtaPes := itemXmlF('NR_CTAPES', pParams);
  vDtSistema := itemXml('DT_SISTEMA', PARAM_GLB);

  if (vCdEmpresa = 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN001', 'Código da empresa do cheque presente não informado para zeramento.', cDS_METHOD);
    return(-1); exit;
  end;
  if (vCdCliente = 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN001', 'Código do cliente do cheque presente não informado para zeramento.', cDS_METHOD);
    return(-1); exit;
  end;
  if (vNrCheque = 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN001', 'Número do cheque presente não informado para zeramento.', cDS_METHOD);
    return(-1); exit;
  end;
  if (vVlSaldo = 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN001', 'Saldo do cheque presente já está zerado.', cDS_METHOD);
    return(-1); exit;
  end;
  if (vCdEmpLiq = 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN001', 'Código da empresa da liquidação do cheque presente não informado para zeramento.', cDS_METHOD);
    return(-1); exit;
  end;
  if (vNrSeqLiq = 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN001', 'Número da sequência da liquidação do cheque presente não informado para zeramento.', cDS_METHOD);
    return(-1); exit;
  end;
  if (vDtLiq = 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN001', 'Data da liquidação do cheque presente não informada para zeramento.', cDS_METHOD);
    return(-1); exit;
  end;
  if (vNrCtaPes = 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN001', 'Número da conta do cheque presente não informado para zeramento.', cDS_METHOD);
    return(-1); exit;
  end;
  if (vVlSaldo > 0) then begin
    viParams := '';
    putitemXml(viParams, 'CD_EMPRESA', vCdEmpresa);
    putitemXml(viParams, 'NR_CTAPES', vNrCtapes);
    putitemXml(viParams, 'DT_MOVIMENTO', vDtSistema);
    putitemXml(viParams, 'CD_HISTORICO', 1094);
    putitemXml(viParams, 'TP_DOCUMENTO', 18);
    putitemXml(viParams, 'NR_SEQHISTRELSUB', 1);
    putitemXml(viParams, 'CD_EMPLIQ', vCdEmpLiq);
    putitemXml(viParams, 'DT_LIQ', vDtLiq);
    putitemXml(viParams, 'NR_SEQLIQ', vNrSeqLiq);
    putitemXml(viParams, 'VL_LANCTO', vVlSaldo);
    putitemXml(viParams, 'IN_ESTORNO', False);
    putitemXml(viParams, 'IN_CAIXA', False);
    putitemXml(viParams, 'DS_DOC', 'Deb. cheque Presente');
    putitemXml(viParams, 'DS_AUX', '');
    putitemXml(viParams, 'CD_EMPCHQPRES', vCdEmpresa);
    putitemXml(viParams, 'CD_CLICHQPRES', vCdCliente);
    putitemXml(viParams, 'NR_CHEQUEPRES', vNrCheque);
    voParams := activateCmp('FCCSVCO002', 'movimentaConta', viParams); (*,viParams,voParams,, *)
    if (xStatus < 0) then begin
      Result := voParams;
      return(-1); exit;
    end;

    viParams := '';
    putitemXml(viParams, 'NR_CTAPES', vNrCtaPes);
    putitemXml(viParams, 'DT_MOVIM', vDtSistema);
    putitemXml(viParams, 'NR_SEQMOV', itemXmlF('NR_SEQMOV', voParams));
    putitemXml(viParams, 'CD_COMPONENTE', 'FCRSVCO068');
    putitemXml(viParams, 'DS_OBS', 'Zeramento cheque presente');
    voParams := activateCmp('FCCSVCO002', 'gravaObsMov', viParams); (*,viParams,voParams,, *)
    if (xStatus < 0) then begin
      Result := voParams;
      return(-1); exit;
    end;
  end;
  if (vVlSaldo < 0) then begin
    viParams := '';
    putitemXml(viParams, 'CD_EMPRESA', vCdEmpresa);
    putitemXml(viParams, 'NR_CTAPES', vNrCtapes);
    putitemXml(viParams, 'DT_MOVIMENTO', vDtSistema);
    putitemXml(viParams, 'CD_HISTORICO', 1093);
    putitemXml(viParams, 'TP_DOCUMENTO', 18);
    putitemXml(viParams, 'NR_SEQHISTRELSUB', 1);
    putitemXml(viParams, 'CD_EMPLIQ', vCdEmpLiq);
    putitemXml(viParams, 'DT_LIQ', vDtLiq);
    putitemXml(viParams, 'NR_SEQLIQ', vNrSeqLiq);
    putitemXml(viParams, 'VL_LANCTO', vVlSaldo);
    putitemXml(viParams, 'IN_ESTORNO', False);
    putitemXml(viParams, 'IN_CAIXA', False);
    putitemXml(viParams, 'DS_DOC', 'Cred. Cheque Presente');
    putitemXml(viParams, 'DS_AUX', '');
    putitemXml(viParams, 'CD_EMPCHQPRES', vCdEmpresa);
    putitemXml(viParams, 'CD_CLICHQPRES', vCdCliente);
    putitemXml(viParams, 'NR_CHEQUEPRES', vNrCheque);
    voParams := activateCmp('FCCSVCO002', 'movimentaConta', viParams); (*,viParams,voParams,, *)
    if (xStatus < 0) then begin
      Result := voParams;
      return(-1); exit;
    end;

    viParams := '';
    putitemXml(viParams, 'NR_CTAPES', vNrCtaPes);
    putitemXml(viParams, 'DT_MOVIM', vDtSistema);
    putitemXml(viParams, 'NR_SEQMOV', itemXmlF('NR_SEQMOV', voParams));
    putitemXml(viParams, 'CD_COMPONENTE', 'FCRSVCO068');
    putitemXml(viParams, 'DS_OBS', 'Zeramento cheque presente');
    voParams := activateCmp('FCCSVCO002', 'gravaObsMov', viParams); (*,viParams,voParams,, *)
    if (xStatus < 0) then begin
      Result := voParams;
      return(-1); exit;
    end;
  end;

  viParams := '';
  putitemXml(viParams, 'CD_EMPRESA', vCdEmpresa);
  putitemXml(viParams, 'CD_CLIENTE', vCdCliente);
  putitemXml(viParams, 'NR_CHEQUE', vNrCheque);
  putitemXml(viParams, 'TP_CHEQUE', 1);
  voParams := activateCmp('FCRSVCO068', 'gravarUtilizacaoChequePresente', viParams); (*,viParams,voParams,, *)
  if (xStatus < 0) then begin
    Result := voParams;
    return(-1); exit;
  end;

  return(0); exit;
end;

//-----------------------------------------------------------------------
function T_FCRSVCO068.atualizarChequePresente(pParams : String) : String;
//-----------------------------------------------------------------------
const
  cDS_METHOD = 'ADICONAL=Operação: T_FCRSVCO068.atualizarChequePresente()';
var
  vDsRegistro, vDsLstCampo, vDsCampo, vNmCheque, vCdComponente, viParams, voParams, vCdBarra : String;
  vCdEmpresa, vCdCliente, vCdTipoCampo, vNrGeral, vNrCheque, vVlCheque : Real;
  vCdEmpLiq, vNrSeqLiq, vNrCtaPes, vNrTransacao : Real;
  vDtCheque, vDtLiq : String;
begin
  vVlCheque := itemXmlF('VL_CHEQUE', pParams);
  vDtCheque := itemXml('DT_CHEQUE', pParams);
  vCdEmpresa := itemXmlF('CD_EMPRESA', pParams);
  vCdCliente := itemXmlF('CD_CLIENTE', pParams);
  vNrCheque := itemXmlF('NR_CHEQUE', pParams);
  vCdEmpLiq := itemXmlF('CD_EMPLIQ', pParams);
  vDtLiq := itemXml('DT_LIQ', pParams);
  vNrSeqLiq := itemXmlF('NR_SEQLIQ', pParams);
  vCdComponente := itemXml('CD_COMPONENTE', pParams);
  vCdBarra := itemXml('CD_BARRA', pParams);

  if (vNrCheque = '')  or (vNrCheque = 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN001', 'Número de cheque não informado para atualização do cheque presente.', cDS_METHOD);
    return(-1); exit;
  end;
  if (vVlCheque = '')  or (vVlCheque = 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN001', 'Valor do cheque não informado para atualização do cheque presente.', cDS_METHOD);
    return(-1); exit;
  end;
  if (vDtCheque = '')  or (vDtCheque = 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN001', 'Data do cheque não informada para atualização do cheque presente.', cDS_METHOD);
    return(-1); exit;
  end;
  if (vCdEmpresa = '')  or (vCdEmpresa = 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN001', 'Empresa não informada para atualização do cheque presente.', cDS_METHOD);
    return(-1); exit;
  end;
  if (vCdCliente = '')  or (vCdCliente = 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN001', 'Cliente não informado para atualização do cheque presente.', cDS_METHOD);
    return(-1); exit;
  end;
  if (vCdEmpLiq = '')  or (vCdEmpLiq = 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN001', 'Empresa de liquidação não informada para atualização do cheque presente.', cDS_METHOD);
    return(-1); exit;
  end;
  if (vNrSeqLiq = '')  or (vNrSeqLiq = 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN001', 'Número de sequência de liquidação não informado para atualização do cheque presente.', cDS_METHOD);
    return(-1); exit;
  end;
  if (vDtLiq = '')  or (vDtLiq = 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN001', 'Data de liquidação não informada para atualização do cheque presente.', cDS_METHOD);
    return(-1); exit;
  end;
  if (vCdComponente = '') then begin
    Result := SetStatus(STS_ERROR, 'GEN001', 'Código de componente não informado para atualização do cheque presente.', cDS_METHOD);
    return(-1); exit;
  end;

  creocc(tFCR_CHEQUEPRES, -1);
  putitem_e(tFCR_CHEQUEPRES, 'CD_EMPRESA', vCdEmpresa);
  putitem_e(tFCR_CHEQUEPRES, 'CD_CLIENTE', vCdCliente);
  putitem_e(tFCR_CHEQUEPRES, 'NR_CHEQUE', vNrCheque);
  retrieve_o(tFCR_CHEQUEPRES);
  if (xStatus = -7) then begin
    retrieve_x(tFCR_CHEQUEPRES);
  end else begin
    Result := SetStatus(STS_ERROR, 'GEN001', 'Cheque presente não encontrado para atualização do cheque presente. Empresa: ' + CD_EMPRESA + '.FCR_CHEQUEPRES Cliente: ' + CD_CLIENTE + '.FCR_CHEQUEPRES Número: ' + NR_CHEQUE + '.FCR_CHEQUEPRES.', cDS_METHOD);
    return(-1); exit;
  end;
  putitem_e(tFCR_CHEQUEPRES, 'CD_OPERADOR', itemXmlF('CD_USUARIO', PARAM_GLB));
  putitem_e(tFCR_CHEQUEPRES, 'DT_CADASTRO', Now);
  putitem_e(tFCR_CHEQUEPRES, 'DT_EMISSAO', Now);
  putitem_e(tFCR_CHEQUEPRES, 'DT_VALIDADE', vDtCheque);
  putitem_e(tFCR_CHEQUEPRES, 'DS_NOMINAL', vNmCheque);
  putitem_e(tFCR_CHEQUEPRES, 'VL_CHEQUE', item_f('VL_CHEQUE', tFCR_CHEQUEPRES) + vVlCheque);
  putitem_e(tFCR_CHEQUEPRES, 'DT_INCLUSAO', Now);
  putitem_e(tFCR_CHEQUEPRES, 'CD_OPERINCL', itemXmlF('CD_USUARIO', PARAM_GLB));
  putitem_e(tFCR_CHEQUEPRES, 'DT_UTILIZACAO', '');
  putitem_e(tFCR_CHEQUEPRES, 'CD_OPERUTIL', '');
  putitem_e(tFCR_CHEQUEPRES, 'DT_CANCELAMENTO', '');
  putitem_e(tFCR_CHEQUEPRES, 'CD_OPERCANCEL', '');
  putitem_e(tFCR_CHEQUEPRES, 'TP_SITUACAO', 1);
  putitem_e(tFCR_CHEQUEPRES, 'CD_EMPLIQ', vCdEmpLiq);
  putitem_e(tFCR_CHEQUEPRES, 'DT_LIQ', vDtLiq);
  putitem_e(tFCR_CHEQUEPRES, 'NR_SEQLIQ', vNrSeqLiq);
  putitem_e(tFCR_CHEQUEPRES, 'CD_BARRA', vCdBarra);
  putitem_e(tFCR_CHEQUEPRES, 'TP_CHEQUE', 1);

  viParams := '';
  putitemXml(viParams, 'CD_PESSOA', vCdCliente);
  putitemXml(viParams, 'TP_CONTA', 'C');
  voParams := activateCmp('FCCSVCO002', 'buscaContaPessoa', viParams); (*,viParams,voParams,, *)
  if (xStatus < 0) then begin
    Result := voParams;
    return(-1); exit;
  end;
  vNrCtapes := itemXmlF('NR_CTAPES', voParams);
  putitem_e(tFCR_CHEQUEPRES, 'NR_CTAPES', vNrCtaPes);

  viParams := '';
  putitemXml(viParams, 'CD_EMPRESA', vCdEmpresa);
  putitemXml(viParams, 'NR_CTAPES', vNrCtapes);
  putitemXml(viParams, 'DT_MOVIMENTO', vDtLiq);
  putitemXml(viParams, 'CD_HISTORICO', 1093);
  putitemXml(viParams, 'TP_DOCUMENTO', 18);
  putitemXml(viParams, 'NR_SEQHISTRELSUB', 1);
  putitemXml(viParams, 'CD_EMPLIQ', vCdEmpLiq);
  putitemXml(viParams, 'DT_LIQ', vDtLiq);
  putitemXml(viParams, 'NR_SEQLIQ', vNrSeqLiq);
  putitemXml(viParams, 'VL_LANCTO', vVlCheque);
  putitemXml(viParams, 'IN_ESTORNO', False);
  putitemXml(viParams, 'IN_CAIXA', False);
  putitemXml(viParams, 'DS_DOC', 'Cred. Cheque presente');
  putitemXml(viParams, 'DS_AUX', '');
  putitemXml(viParams, 'CD_EMPCHQPRES', vCdEmpresa);
  putitemXml(viParams, 'CD_CLICHQPRES', vCdCliente);
  putitemXml(viParams, 'NR_CHEQUEPRES', vNrCheque);
  voParams := activateCmp('FCCSVCO002', 'movimentaConta', viParams); (*,viParams,voParams,, *)
  if (xStatus < 0) then begin
    Result := voParams;
    return(-1); exit;
  end;

  voParams := tFCR_CHEQUEPRES.Salvar();
  if (xStatus < 0) then begin
    Result := voParams;
    return(-1); exit;
  end;

  return(0); exit;
end;

//------------------------------------------------------------------------
function T_FCRSVCO068.buscaSaldoChequePresente(pParams : String) : String;
//------------------------------------------------------------------------
const
  cDS_METHOD = 'ADICONAL=Operação: T_FCRSVCO068.buscaSaldoChequePresente()';
var
  vNrCtaPes, vVlSaldo, vTpDocumento, vNrSeqHistRelSub, vCdEmpresa, vCdCliente, vNrCheque : Real;
  vDtMovim : String;
begin
  vNrCtaPes := itemXmlF('NR_CTAPES', pParams);
  vTpDocumento := itemXmlF('TP_DOCUMENTO', pParams);
  vNrSeqHistRelSub := itemXmlF('NR_SEQHISTRELSUB', pParams);
  vCdEmpresa := itemXmlF('CD_EMPRESA', pParams);
  vCdCliente := itemXmlF('CD_CLIENTE', pParams);
  vNrCheque := itemXmlF('NR_CHEQUE', pParams);
  if (vNrCtaPes = 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', , cDS_METHOD);
    return(-1); exit;
  end;
  if (vTpDocumento = 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', ' Tipo documento da conta não informado!', cDS_METHOD);
    return(-1); exit;
  end;
  if (vNrSeqHistRelSub = 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', ' Número de sequência da conta não informado!', cDS_METHOD);
    return(-1); exit;
  end;
  if (vCdEmpresa = 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', ' Código da empresa do cheque presente não informado!', cDS_METHOD);
    return(-1); exit;
  end;
  if (vCdCliente = 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', ' Código do cliente do cheque presente não informado!', cDS_METHOD);
    return(-1); exit;
  end;
  if (vNrCheque = 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', ' Número do do cheque presente não informado!', cDS_METHOD);
    return(-1); exit;
  end;

  vVlSaldo := 0;
  clear_e(tFCC_MOV);
  putitem_e(tFCC_MOV, 'NR_CTAPES', vNrCtaPes);
  putitem_e(tFCC_MOV, 'CD_HISTORICO', '1093);
  putitem_e(tFCC_MOV, 'TP_DOCUMENTO', 18);
  putitem_e(tFCC_MOV, 'NR_SEQHISTRELSUB', vNrSeqHistRelSub);
  putitem_e(tFCC_MOV, 'CD_EMPCHQPRES', vCdEmpresa);
  putitem_e(tFCC_MOV, 'CD_CLICHQPRES', vCdCliente);
  putitem_e(tFCC_MOV, 'NR_CHEQUEPRES', vNrCheque);
  retrieve_e(tFCC_MOV);
  if (xStatus >=0) then begin
    setocc(tFCC_MOV, 1);
    while (xStatus >= 0) do begin
      if (item_a('DT_ESTORNO', tFCC_MOV) = '') then begin
        if (item_f('CD_HISTORICO', tFCC_MOV) = 1093) then begin
          vVlSaldo := vVlSaldo + item_f('VL_LANCTO', tFCC_MOV);
        end;
        if (item_f('CD_HISTORICO', tFCC_MOV) = 1094) then begin
          vVlSaldo := vVlSaldo - item_f('VL_LANCTO', tFCC_MOV);
        end;
      end;
      setocc(tFCC_MOV, curocc(tFCC_MOV) + 1);
    end;
  end else begin
    vVlSaldo := 0;
  end;

  Result := '';
  putitemXml(Result, 'VL_SALDO', vVlSaldo);

  return(0); exit;
end;

//--------------------------------------------------------------------
function T_FCRSVCO068.lancaMovimentoDebito(pParams : String) : String;
//--------------------------------------------------------------------
const
  cDS_METHOD = 'ADICONAL=Operação: T_FCRSVCO068.lancaMovimentoDebito()';
var
  viParams, voParams : String;
  vNrCtaPes, vVlSaldo, vTpDocumento, vNrSeqHistRelSub, vCdEmpresa, vCdCliente, vNrCheque : Real;
  vNrSeqLiq, vCdEmpLiq, vCdEmpVenda, vVlVenda, vVlCheque : Real;
  vDtMovim, vDtLiq : String;
begin
  vNrCtaPes := itemXmlF('NR_CTAPES', pParams);
  vCdEmpresa := itemXmlF('CD_EMPRESA', pParams);
  vCdCliente := itemXmlF('CD_CLIENTE', pParams);
  vNrCheque := itemXmlF('NR_CHEQUE', pParams);
  vCdEmpLiq := itemXmlF('CD_EMPLIQ', pParams);
  vDtLiq := itemXml('DT_LIQ', pParams);
  vNrSeqLiq := itemXmlF('NR_SEQLIQ', pParams);
  vVlCheque := itemXmlF('VL_CHEQUE', pParams);

  if (vNrCtaPes = 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Conta não informada!', cDS_METHOD);
    return(-1); exit;
  end;
  if (vCdEmpresa = 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', ' Código da empresa do cheque presente não informado!', cDS_METHOD);
    return(-1); exit;
  end;
  if (vCdCliente = 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', ' Código do cliente do cheque presente não informado!', cDS_METHOD);
    return(-1); exit;
  end;
  if (vNrCheque = 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', ' Número do cheque presente não informado!', cDS_METHOD);
    return(-1); exit;
  end;
  if (vCdEmpLiq = 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', ' Código da empresa da liquidação do cheque presente não informado!', cDS_METHOD);
    return(-1); exit;
  end;
  if (vNrSeqLiq = 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', ' Número da sequência da liquidação do cheque presente não informado!', cDS_METHOD);
    return(-1); exit;
  end;
  if (vDtLiq = 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', ' Data da liquidação do cheque presente não informado!', cDS_METHOD);
    return(-1); exit;
  end;
  if (vVlCheque = 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', ' Valor de venda não informado!', cDS_METHOD);
    return(-1); exit;
  end;

  viParams := '';
  putitemXml(viParams, 'CD_EMPRESA', vCdEmpresa);
  putitemXml(viParams, 'NR_CTAPES', vNrCtapes);
  putitemXml(viParams, 'DT_MOVIMENTO', vDtLiq);
  putitemXml(viParams, 'CD_HISTORICO', 1094);
  putitemXml(viParams, 'TP_DOCUMENTO', 18);
  putitemXml(viParams, 'NR_SEQHISTRELSUB', 1);
  putitemXml(viParams, 'CD_EMPLIQ', vCdEmpLiq);
  putitemXml(viParams, 'DT_LIQ', vDtLiq);
  putitemXml(viParams, 'NR_SEQLIQ', vNrSeqLiq);
  putitemXml(viParams, 'VL_LANCTO', vVlCheque);
  putitemXml(viParams, 'IN_ESTORNO', False);
  putitemXml(viParams, 'IN_CAIXA', False);
  putitemXml(viParams, 'DS_DOC', 'Deb. Cheque presente');
  putitemXml(viParams, 'DS_AUX', '');
  putitemXml(viParams, 'CD_EMPCHQPRES', vCdEmpresa);
  putitemXml(viParams, 'CD_CLICHQPRES', vCdCliente);
  putitemXml(viParams, 'NR_CHEQUEPRES', vNrCheque);
  voParams := activateCmp('FCCSVCO002', 'movimentaConta', viParams); (*,viParams,voParams,, *)
  if (xStatus < 0) then begin
    Result := voParams;
    return(-1); exit;
  end;

  viParams := '';
  putitemXml(viParams, 'NR_CTAPES', vNrCtaPes);
  putitemXml(viParams, 'TP_DOCUMENTO', 18);
  putitemXml(viParams, 'NR_SEQHISTRELSUB', 1);
  putitemXml(viParams, 'CD_EMPRESA', vCdEmpresa);
  putitemXml(viParams, 'CD_CLIENTE', vCdCliente);
  putitemXml(viParams, 'NR_CHEQUE', vNrCheque);
  voParams := activateCmp('FCRSVCO068', 'buscaSaldoChequePresente', viParams); (*,viParams,voParams,, *)
  if (xStatus < 0) then begin
    Result := voParams;
    return(-1); exit;
  end;
  vVlSaldo := itemXmlF('VL_SALDO', voParams);
  if (vVlSaldo = 0) then begin
    viParams := '';
    putitemXml(viParams, 'CD_EMPRESA', vCdEmpresa);
    putitemXml(viParams, 'CD_CLIENTE', vCdCliente);
    putitemXml(viParams, 'NR_CHEQUE', vNrCheque);
    putitemXml(viParams, 'TP_CHEQUE', 1);
    voParams := activateCmp('FCRSVCO068', 'gravarUtilizacaoChequePresente', viParams); (*,viParams,voParams,, *)
    if (xStatus < 0) then begin
      Result := voParams;
      return(-1); exit;
    end;
  end;

  return(0); exit;

end;

//--------------------------------------------------------------------------------
function T_FCRSVCO068.gravarMovimentacaoCartaoPresente(pParams : String) : String;
//--------------------------------------------------------------------------------
const
  cDS_METHOD = 'ADICONAL=Operação: T_FCRSVCO068.gravarMovimentacaoCartaoPresente()';
var
  vDsRegistro, vDsLstCampo, vDsCampo, vNmCheque, vCdComponente, viParams, voParams, vDsRegDup, vDsLstDesp : String;
  vCdEmpresa, vCdCliente, vCdTipoCampo, vNrGeral, vNrCheque, vVlCheque, vCdEmpFat, vCdClienteFat, vNrFat : Real;
  vNrParcela, vTpCheque, vCdEmpLiq, vNrSeqLiq, vNrCtaPes, vCdEmpLogada, vTpLiq : Real;
  vCdClienteEmpresa, vCdFornecedorEmpresa, vNrSeqFat, vNrSeqItem, vNrSeqAtual : Real;
  vDtCheque, vDtLiq : String;
begin
  voParams := buscaParametro(viParams); (* *)
  if (xStatus < 0) then begin
    Result := voParams;
    return(-1); exit;
  end;

  vNrCheque := itemXmlF('NR_CHEQUE', pParams);
  vCdEmpresa := itemXmlF('CD_EMPRESA', pParams);
  vCdCliente := itemXmlF('CD_CLIENTE', pParams);
  vVlCheque := itemXmlF('VL_CHEQUE', pParams);
  vCdEmpLiq := itemXmlF('CD_EMPLIQ', pParams);
  vDtLiq := itemXml('DT_LIQ', pParams);
  vNrSeqLiq := itemXmlF('NR_SEQLIQ', pParams);
  vTpLiq := itemXmlF('TP_LIQ', pParams);
  vNrCtaPes := itemXmlF('NR_CTAPES', pParams);

  vNrSeqItem := itemXmlF('NR_SEQITEM', pParams);

  vNrSeqAtual := itemXmlF('NR_SEQATUAL', pParams);

  if (vNrCheque = '')  or (vNrCheque = 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN001', 'Número de cheque não informado para movimentação do cheque presente.', cDS_METHOD);
    return(-1); exit;
  end;
  if (vCdEmpresa = '')  or (vCdEmpresa = 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN001', 'Empresa não informada para movimentação do cheque presente.', cDS_METHOD);
    return(-1); exit;
  end;
  if (vCdCliente = '')  or (vCdCliente = 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN001', 'Cliente não informado para movimentação do cheque presente.', cDS_METHOD);
    return(-1); exit;
  end;
  if (vVlCheque = '')  or (vVlCheque = 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN001', 'Valor não informado para movimentação do cheque presente.', cDS_METHOD);
    return(-1); exit;
  end;
  if (vCdEmpLiq = '')  or (vCdEmpLiq = 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN001', 'Código da empresa da liquidação não informado para movimentação do cheque presente.', cDS_METHOD);
    return(-1); exit;
  end;
  if (vDtLiq = '')  or (vDtLiq = 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN001', 'Data da liquidação não informado para movimentação do cheque presente.', cDS_METHOD);
    return(-1); exit;
  end;
  if (vNrSeqLiq = '')  or (vNrSeqLiq = 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN001', 'Número da sequência da liquidação não informado para movimentação do cheque presente.', cDS_METHOD);
    return(-1); exit;
  end;
  if (vTpLiq = '')  or (vTpLiq = 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN001', 'Tipo da liquidação não informado para movimentação do cheque presente.', cDS_METHOD);
    return(-1); exit;
  end;
  if (vNrCtaPes = '')  or (vNrCtaPes = 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN001', 'Número da conta não informado para movimentação do cheque presente.', cDS_METHOD);
    return(-1); exit;
  end;
  if (vNrSeqItem = '')  or (vNrSeqItem = 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN001', 'Número de sequência do ítem da liquidação não informado para movimentação do cheque presente.', cDS_METHOD);
    return(-1); exit;
  end;

  vCdEmpLogada := itemXmlF('CD_EMPRESA', PARAM_GLB);

  viParams := '';
  putitemXml(viParams, 'NR_CTAPES', vNrCtaPes);
  putitemXml(viParams, 'CD_EMPRESA', vCdEmpresa);
  putitemXml(viParams, 'CD_CLIENTE', vCdCliente);
  putitemXml(viParams, 'NR_CHEQUE', vNrCheque);
  putitemXml(viParams, 'CD_EMPLIQ', vCdEmpLiq);
  putitemXml(viParams, 'NR_SEQLIQ', vNrSeqLiq);
  putitemXml(viParams, 'DT_LIQ', vDtLiq);
  putitemXml(viParams, 'VL_CHEQUE', vVlCheque);
  voParams := activateCmp('FCRSVCO068', 'lancaMovimentoDebito', viParams); (*,viParams,voParams,, *)
  if (xStatus < 0) then begin
    Result := voParams;
    return(-1); exit;
  end;

  clear_e(tFGR_LIQICRADIC);
  creocc(tFGR_LIQICRADIC, -1);
  putitem_e(tFGR_LIQICRADIC, 'CD_EMPLIQ', vCdEmpLiq);
  putitem_e(tFGR_LIQICRADIC, 'DT_LIQ', vDtLiq);
  putitem_e(tFGR_LIQICRADIC, 'NR_SEQLIQ', vNrSeqLIq);
  putitem_e(tFGR_LIQICRADIC, 'NR_SEQITEM', vNrSeqItem);
  putitem_e(tFGR_LIQICRADIC, 'CD_OPERADOR', itemXmlF('CD_USUARIO', PARAM_GLB));
  putitem_e(tFGR_LIQICRADIC, 'DT_CADASTRO', Now);
  putitem_e(tFGR_LIQICRADIC, 'TP_FATURAMENTO', 1);
  putitem_e(tFGR_LIQICRADIC, 'CD_EMPCHQPRES', vCdEmpresa);
  putitem_e(tFGR_LIQICRADIC, 'NR_CHEQUEPRES', vNrCheque);
  putitem_e(tFGR_LIQICRADIC, 'CD_CLICHQPRES', vCdCliente);
  putitem_e(tFGR_LIQICRADIC, 'NR_CTAPESPRES', vNrCtaPes);
  putitem_e(tFGR_LIQICRADIC, 'CD_MOEDA', gCdMoeda);
  putitem_e(tFGR_LIQICRADIC, 'NR_PORTADOR', gNrPortadorCarteira);

  voParams := tFGR_LIQICRADIC.Salvar();
  if (xStatus < 0) then begin
    Result := voParams;
    return(-1); exit;
  end;

  vCdEmpLogada := itemXmlF('CD_EMPRESA', PARAM_GLB);
  if (vCdEmpresa <> vCdEmpLogada)  and (vCdEmpresa > 0)  and (vCdEmpLogada > 0) then begin
    clear_e(tGER_EMPRESA);
    putitem_e(tGER_EMPRESA, 'CD_EMPRESA', vCdEmpresa);
    retrieve_e(tGER_EMPRESA);
    if (xStatus >=0) then begin
      vCdClienteEmpresa := item_f('CD_PESSOA', tGER_EMPRESA);
    end else begin
      Result := SetStatus(STS_ERROR, 'GEN001', 'Código da pessoa da empresa do cheque na tabela de empresa não existe para movimentação do cheque presente.', cDS_METHOD);
      return(-1); exit;
    end;

    clear_e(tGER_EMPRESA);
    putitem_e(tGER_EMPRESA, 'CD_EMPRESA', vCdEmpLogada);
    retrieve_e(tGER_EMPRESA);
    if (xStatus >=0) then begin
      vCdFornecedorEmpresa := item_f('CD_PESSOA', tGER_EMPRESA);
    end else begin
      Result := SetStatus(STS_ERROR, 'GEN001', 'Código da pessoa da empresa logada na tabela de empresa não existe para movimentação do cheque presente.', cDS_METHOD);
      return(-1); exit;
    end;

    clear_e(tFCR_FATURAI);
    creocc(tFCR_FATURAI, -1);
    putitem_e(tFCR_FATURAI, 'CD_EMPRESA', vCdEmpresa);
    putitem_e(tFCR_FATURAI, 'CD_CLIENTE', vCdFornecedorEmpresa);
    putitem_e(tFCR_FATURAI, 'NR_FAT', vNrCheque);
    putitem_e(tFCR_FATURAI, 'DT_EMISSAO', vDtLiq);
    putitem_e(tFCR_FATURAI, 'DT_VENCIMENTO', vDtLiq);
    putitem_e(tFCR_FATURAI, 'TP_FATURAMENTO', 21);
    putitem_e(tFCR_FATURAI, 'TP_COBRANCA', 1);
    putitem_e(tFCR_FATURAI, 'TP_SITUACAO', 1);
    putitem_e(tFCR_FATURAI, 'TP_INCLUSAO', 2);
    putitem_e(tFCR_FATURAI, 'NR_PORTADOR', gNrPortadorCarteira);
    putitem_e(tFCR_FATURAI, 'TP_DOCUMENTO', 1);
    putitem_e(tFCR_FATURAI, 'VL_FATURA', vVlCheque);

    vDsRegistro := '';
    putlistitensocc_e(vDsRegistro, tFCR_FATURAI);
    viParams := '';
    putitemXml(viParams, 'DS_FATURAI', vDsRegistro);
    putitemXml(viParams, 'IN_ALTSOFATURAI', False);
    putitemXml(viParams, 'IN_SEMCOMISSAO', True);
    putitemXml(viParams, 'IN_SEMIMPOSTO', True);
    putitemXml(viParams, 'CD_COMPONENTE', FCRSVCO068);
    voParams := activateCmp('FCRSVCO001', 'geraFatura', viParams); (*,viParams,voParams,, *)
    if (xStatus < 0) then begin
      Result := voParams;
      return(-1); exit;
    end;
    vNrParcela := itemXmlF('NR_PARCELA', voParams);

    if (vNrSeqAtual > 0) then begin
      vNrSeqFat := vNrSeqAtual;
    end else begin

      vNrSeqFat := 0;
      clear_e(tFGR_LIQITEMCR);
      putitem_e(tFGR_LIQITEMCR, 'CD_EMPLIQ', vCdEmpLiq);
      putitem_e(tFGR_LIQITEMCR, 'DT_LIQ', vDtLiq);
      putitem_e(tFGR_LIQITEMCR, 'NR_SEQLIQ', vNrSeqLiq);
      retrieve_e(tFGR_LIQITEMCR);
      if (xStatus >=0) then begin
        setocc(tFGR_LIQITEMCR, 1);
        while (xStatus >= 0) do begin

          if (item_f('NR_SEQITEM', tFGR_LIQITEMCR) > vNrSeqFat) then begin
            vNrSeqFat := item_f('NR_SEQITEM', tFGR_LIQITEMCR);
          end;

          setocc(tFGR_LIQITEMCR, curocc(tFGR_LIQITEMCR) + 1);
        end;
      end;
    end;

    vNrSeqFat := vNrSeqFat + 1;
    viParams := '';
    putitemXml(viParams, 'CD_EMPLIQ', vCdEmpLiq);
    putitemXml(viParams, 'DT_LIQ', vDtLiq);
    putitemXml(viParams, 'NR_SEQLIQ', vNrSeqLiq);
    putitemXml(viParams, 'NR_SEQFATURA', vNrSeqFat);
    putitemXml(viParams, 'TP_LIQUIDACAO', vTpLiq);
    putitemXml(viParams, 'TP_TIPOREG', 5);
    putitemXml(viParams, 'CD_PESSOA', item_f('CD_CLIENTE', tFCR_FATURAI));
    putitemXml(viParams, 'CD_EMPFAT', item_f('CD_EMPRESA', tFCR_FATURAI));
    putitemXml(viParams, 'CD_CLIENTEFAT', item_f('CD_CLIENTE', tFCR_FATURAI));
    putitemXml(viParams, 'NR_FAT', item_f('NR_FAT', tFCR_FATURAI));
    putitemXml(viParams, 'NR_PARCELA', vNrParcela);
    putitemXml(viParams, 'TP_DOCUMENTO', item_f('TP_DOCUMENTO', tFCR_FATURAI));
    putitemXml(viParams, 'VL_PAGO', vVlCheque);
    putitemXml(viParams, 'IN_ATUALIZA', 'N');
    voParams := activateCmp('FCPSVCO014', 'atualizaLiqCR', viParams); (*,viParams,voParams,, *)
    if (xStatus < 0) then begin
      Result := voParams;
      return(-1); exit;
    end;

    vDsRegDup := '';
    vDsRegistro := '';
    vDsLstDesp := '';
    putitemXml(vDsRegDup, 'CD_EMPRESA', vCdEmpLogada);
    putitemXml(vDsRegDup, 'CD_FORNECEDOR', vCdClienteEmpresa);
    putitemXml(vDsRegDup, 'NR_DUPLICATA', vNrCheque);
    putitemXml(vDsRegDup, 'NR_PORTADOR', gNrPortadorCarteira);
    putitemXml(vDsRegDup, 'DT_EMISSAO', vDtLiq);
    putitemXml(vDsRegDup, 'DT_ENTRADA', vDtLiq);
    putitemXml(vDsRegDup, 'TP_SITUACAO', 'N');
    putitemXml(vDsRegDup, 'TP_DOCUMENTO', 30);
    putitemXml(vDsRegDup, 'TP_INCLUSAO', 2);
    putitemXml(vDsRegDup, 'TP_PREVISAOREAL', 2);
    putitemXml(vDsRegDup, 'DT_VENCIMENTO', vDtLiq);
    putitemXml(vDsRegDup, 'VL_DUPLICATA', vVlCheque);
    putitemXml(vDsRegDup, 'VL_ORIGINAL', vVlCheque);
    putitemXml(vDsRegDup, 'TP_ESTAGIO', 1);
    putitemXml(vDsRegDup, 'TP_BAIXA', 0);
    putitemXml(vDsRegistro, 'CD_DESPESAITEM', gCdDespesaChequePresente);
    putitemXml(vDsRegistro, 'CD_CUSTO', gCdCentroCusto);
    putitemXml(vDsRegistro, 'PR_RATEIO', 100);
    putitemXml(vDsRegistro, 'VL_RATEIO', vVlCheque);
    putitem(   vDsLstDesp,  vDsRegistro);
    putitemXml(vDsRegDup, 'DS_DUPDESPESA', vDsLstDesp);

    viParams := '';
    putitemXml(viParams, 'DS_DUPLICATAI', vDsRegDup);
    putitemXml(viParams, 'DS_COMPONENTE', FCRSVCO068);
    voParams := activateCmp('FCPSVCO001', 'geraDuplicata', viParams); (*,viParams,voParams,, *)
    if (xStatus < 0) then begin
      Result := voParams;
      return(-1); exit;
    end;
    vNrParcela := itemXmlF('NR_PARCELA', voParams);

    viParams := '';
    putitemXml(viParams, 'CD_EMPLIQ', vCdEmpLiq);
    putitemXml(viParams, 'DT_LIQ', vDtLiq);
    putitemXml(viParams, 'NR_SEQLIQ', vNrSeqLiq);
    putitemXml(viParams, 'NR_SEQDUPLICATA', 1);
    putitemXml(viParams, 'TP_LIQUIDACAO', vTpLiq);
    putitemXml(viParams, 'TP_SUBLIQ', 5);
    putitemXml(viParams, 'CD_PESSOA', vCdClienteEmpresa);
    putitemXml(viParams, 'CD_EMPRESADUP', vCdEmpLogada);
    putitemXml(viParams, 'CD_FORNECDUP', vCdClienteEmpresa);
    putitemXml(viParams, 'NR_DUPLICATADUP', vNrCheque);
    putitemXml(viParams, 'NR_PARCELADUP', vNrParcela);
    putitemXml(viParams, 'VL_PAGO', vVlCheque);
    putitemXml(viParams, 'IN_ATUALIZA', 'N');
    voParams := activateCmp('FCPSVCO014', 'atualizaLiqCC', viParams); (*,viParams,voParams,, *)
    if (xStatus < 0) then begin
      Result := voParams;
      return(-1); exit;
    end;
  end;

  return(0); exit;
end;

//------------------------------------------------------------------------------
function T_FCRSVCO068.cancelarUtilizacaoChequePresCC(pParams : String) : String;
//------------------------------------------------------------------------------
const
  cDS_METHOD = 'ADICONAL=Operação: T_FCRSVCO068.cancelarUtilizacaoChequePresCC()';
var
  vDetalheFaturaLog, vDsLinhaDuplicata, viParams, voParams : String;
  vCdEmpLiq, vNrSeqLiq, vCdEmpresa, vVlCheque, vNrCheque, vNrCtaPes, vCdCliente : Real;
  vCdEmpFat, vCdClienteFat, vNrFat, vNrParcela, vNrSeqItem : Real;
  vDtLiq : String;
begin
  vCdEmpLiq := itemXmlF('CD_EMPLIQ', pParams);
  vDtLiq := itemXml('DT_LIQ', pParams);
  vNrSeqLiq := itemXmlF('NR_SEQLIQ', pParams);
  vVlCheque := itemXmlF('VL_CHEQUE', pParams);
  vCdEmpFat := itemXmlF('CD_EMPFAT', pParams);
  vCdClienteFat := itemXmlF('CD_CLIENTEFAT', pParams);
  vNrFat := itemXmlF('NR_FAT', pParams);
  vNrParcela := itemXmlF('NR_PARCELA', pParams);
  vNrSeqItem := itemXmlF('NR_SEQITEM', pParams);

  if (vCdEmpLiq = '')  or (vCdEmpLiq = 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN001', 'Código da empresa de liquidação não informado para cancelamento do cheque presente.', cDS_METHOD);
    return(-1); exit;
  end;
  if (vDtLiq = '')  or (vDtLiq = 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN001', 'Data de liquidação não informado para cancelamento do cheque presente.', cDS_METHOD);
    return(-1); exit;
  end;
  if (vNrSeqLiq = '')  or (vNrSeqLiq = 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN001', 'Número de sequência de liquidação não informado para cancelamento do cheque presente.', cDS_METHOD);
    return(-1); exit;
  end;
  if (vCdEmpLiq = '')  or (vCdEmpLiq = 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN001', 'Código da empresa de liquidação não informado para cancelamento do cheque presente.', cDS_METHOD);
    return(-1); exit;
  end;
  if (vCdEmpFat = '')  or (vCdEmpFat = 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN001', 'Código da empresa da fatura não informado para cancelamento do cheque presente.', cDS_METHOD);
    return(-1); exit;
  end;
  if (vCdClienteFat = '')  or (vCdClienteFat = 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN001', 'Código do cliente da fatura não informado para cancelamento do cheque presente.', cDS_METHOD);
    return(-1); exit;
  end;
  if (vNrFat = '')  or (vNrFat = 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN001', 'Número da fatura não informado para cancelamento do cheque presente.', cDS_METHOD);
    return(-1); exit;
  end;
  if (vNrParcela = '')  or (vNrParcela = 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN001', 'Número da parcela da fatura não informado para cancelamento do cheque presente.', cDS_METHOD);
    return(-1); exit;
  end;

  clear_e(tFCR_FATURAI);
  putitem_e(tFCR_FATURAI, 'CD_EMPRESA', vCdEmpFat);
  putitem_e(tFCR_FATURAI, 'CD_CLIENTE', vCdClienteFat);
  putitem_e(tFCR_FATURAI, 'NR_FAT', vNrFat);
  putitem_e(tFCR_FATURAI, 'NR_PARCELA', vNrParcela);
  retrieve_e(tFCR_FATURAI);
  if (xStatus >=0) then begin
    vVlCheque := item_f('VL_PAGO', tFCR_FATURAI);
  end;
  if (vVlCheque = '')  or (vVlCheque = 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN001', 'Valor do cheque não informado para cancelamento do cheque presente.', cDS_METHOD);
    return(-1); exit;
  end;

  clear_e(tFGR_LIQICRADIC);
  putitem_e(tFGR_LIQICRADIC, 'CD_EMPLIQ', vCdEmpLiq);
  putitem_e(tFGR_LIQICRADIC, 'DT_LIQ', vDtLiq);
  putitem_e(tFGR_LIQICRADIC, 'NR_SEQLIQ', vNrSeqLiq);
  putitem_e(tFGR_LIQICRADIC, 'NR_SEQITEM', vNrSeqItem);

  retrieve_e(tFGR_LIQICRADIC);
  if (xStatus >=0) then begin
    vCdEmpresa := item_f('CD_EMPCHQPRES', tFGR_LIQICRADIC);
    vCdCliente := item_f('CD_CLICHQPRES', tFGR_LIQICRADIC);
    vNrCheque := item_f('NR_CHEQUEPRES', tFGR_LIQICRADIC);
    vNrCtaPes := item_f('NR_CTAPESPRES', tFGR_LIQICRADIC);
  end;
  if (vCdEmpresa = '')  or (vCdEmpresa = 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN001', 'Código da empresa não informado para cancelamento do cheque presente.', cDS_METHOD);
    return(-1); exit;
  end;
  if (vCdCliente = '')  or (vCdCliente = 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN001', 'Código do cliente não informado para cancelamento do cheque presente.', cDS_METHOD);
    return(-1); exit;
  end;
  if (vNrCheque = '')  or (vNrCheque = 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN001', 'Número do cheque não informado para cancelamento do cheque presente.', cDS_METHOD);
    return(-1); exit;
  end;
  if (vNrCtaPes = '')  or (vNrCtaPes = 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN001', 'Número da conta não informado para cancelamento do cheque presente.', cDS_METHOD);
    return(-1); exit;
  end;

  viParams := '';
  putitemXml(viParams, 'CD_EMPRESA', vCdEmpresa);
  putitemXml(viParams, 'NR_CTAPES', vNrCtapes);
  putitemXml(viParams, 'DT_MOVIMENTO', vDtLiq);
  putitemXml(viParams, 'CD_HISTORICO', 1093);
  putitemXml(viParams, 'TP_DOCUMENTO', 18);
  putitemXml(viParams, 'NR_SEQHISTRELSUB', 1);
  putitemXml(viParams, 'CD_EMPLIQ', vCdEmpLiq);
  putitemXml(viParams, 'DT_LIQ', vDtLiq);
  putitemXml(viParams, 'NR_SEQLIQ', vNrSeqLiq);
  putitemXml(viParams, 'VL_LANCTO', vVlCheque);
  putitemXml(viParams, 'IN_ESTORNO', False);
  putitemXml(viParams, 'IN_CAIXA', False);
  putitemXml(viParams, 'DS_DOC', 'Cred. Cheque presente');
  putitemXml(viParams, 'DS_AUX', '');
  putitemXml(viParams, 'CD_EMPCHQPRES', vCdEmpresa);
  putitemXml(viParams, 'CD_CLICHQPRES', vCdCliente);
  putitemXml(viParams, 'NR_CHEQUEPRES', vNrCheque);
  voParams := activateCmp('FCCSVCO002', 'movimentaConta', viParams); (*,viParams,voParams,, *)
  if (xStatus < 0) then begin
    Result := voParams;
    return(-1); exit;
  end;

  clear_e(tFGR_LIQITEMCR);
  putitem_e(tFGR_LIQITEMCR, 'CD_EMPLIQ', vCdEmpLiq);
  putitem_e(tFGR_LIQITEMCR, 'DT_LIQ', vDtLiq);
  putitem_e(tFGR_LIQITEMCR, 'NR_SEQLIQ', vNrSeqLiq);
  putitem_e(tFGR_LIQITEMCR, 'TP_TIPOREG', 5);
  retrieve_e(tFGR_LIQITEMCR);
  if (xStatus >= 0) then begin
    setocc(tFGR_LIQITEMCR, 1);
    while (xStatus >= 0) do begin
      clear_e(tFCR_FATURAI);
      putitem_e(tFCR_FATURAI, 'CD_EMPRESA', item_f('CD_EMPFAT', tFGR_LIQITEMCR));
      putitem_e(tFCR_FATURAI, 'CD_CLIENTE', item_f('CD_CLIENTE', tFGR_LIQITEMCR));
      putitem_e(tFCR_FATURAI, 'NR_FAT', item_f('NR_FAT', tFGR_LIQITEMCR));
      putitem_e(tFCR_FATURAI, 'NR_PARCELA', item_f('NR_PARCELA', tFGR_LIQITEMCR));
      retrieve_e(tFCR_FATURAI);
      if (xStatus >=0) then begin
        putitem_e(tFCR_FATURAI, 'TP_SITUACAO', 3);
        putitem_e(tFCR_FATURAI, 'CD_OPERCANCEL', gModulo.gCdUsuario);
        putitem_e(tFCR_FATURAI, 'DT_CANCELAMENTO', Now);
        voParams := tFCR_FATURAI.Salvar();
        if (xStatus < 0) then begin
          Result := voParams;
          return(-1); exit;
        end;

        viParams := '';
        putitemXml(viParams, 'CD_EMPRESA', item_f('CD_EMPFAT', tFGR_LIQITEMCR));
        putitemXml(viParams, 'CD_CLIENTE', item_f('CD_CLIENTE', tFGR_LIQITEMCR));
        putitemXml(viParams, 'NR_FAT', item_f('NR_FAT', tFGR_LIQITEMCR));
        putitemXml(viParams, 'NR_PARCELA', item_f('NR_PARCELA', tFGR_LIQITEMCR));
        putitemXml(viParams, 'TP_LOGFAT', 9);
        putitemXml(viParams, 'DS_COMPONENTE', 'FCRSVCO068');
        putitemXml(viParams, 'DS_OBS', 'Cancelamento de Liquidacao');
        voParams := activateCmp('FCRSVCO001', 'gravaLogFatura', viParams); (*,viParams,voParams,, *)
        if (xStatus < 0) then begin
          Result := voParams;
          return(-1); exit;
        end;
      end;

      setocc(tFGR_LIQITEMCR, curocc(tFGR_LIQITEMCR) + 1);
    end;
  end;

  clear_e(tFGR_LIQITEMCC);
  putitem_e(tFGR_LIQITEMCC, 'CD_EMPLIQ', vCdEmpLiq);
  putitem_e(tFGR_LIQITEMCC, 'DT_LIQ', vDtLiq);
  putitem_e(tFGR_LIQITEMCC, 'NR_SEQLIQ', vNrSeqLiq);
  putitem_e(tFGR_LIQITEMCC, 'TP_SUBLIQ', 5);
  retrieve_e(tFGR_LIQITEMCC);
  if (xStatus >= 0) then begin
    setocc(tFGR_LIQITEMCC, 1);
    while (xStatus >= 0) do begin
      putitemXml(vDsLinhaDuplicata, 'CD_EMPRESA', item_f('CD_EMPRESADUP', tFGR_LIQITEMCC));
      putitemXml(vDsLinhaDuplicata, 'CD_FORNECEDOR', item_f('CD_FORNECDUP', tFGR_LIQITEMCC));
      putitemXml(vDsLinhaDuplicata, 'NR_DUPLICATA', item_f('NR_DUPLICATADUP', tFGR_LIQITEMCC));
      putitemXml(vDsLinhaDuplicata, 'NR_PARCELA', item_f('NR_PARCELADUP', tFGR_LIQITEMCC));
      putitemXml(vDsLinhaDuplicata, 'CD_COMPONENTE', 'FCRSVCO068');

      viParams := '';
      putitem(viParams,  vDsLinhaDuplicata);
      voParams := activateCmp('FCPSVCO001', 'CancelaDuplicata', viParams); (*,viParams,voParams,, *)
      if (xStatus < 0) then begin
        Result := voParams;
        return(-1); exit;
      end;

      viParams := '';
      putitemXml(viParams, 'CD_EMPRESA', item_f('CD_EMPRESADUP', tFGR_LIQITEMCC));
      putitemXml(viParams, 'CD_FORNECEDOR', item_f('CD_FORNECDUP', tFGR_LIQITEMCC));
      putitemXml(viParams, 'NR_DUPLICATA', item_f('NR_DUPLICATADUP', tFGR_LIQITEMCC));
      putitemXml(viParams, 'NR_PARCELA', item_f('NR_PARCELADUP', tFGR_LIQITEMCC));
      putitemXml(viParams, 'TP_LOGDUP', 6);
      putitemXml(viParams, 'DS_COMPONENTE', FCRSVCO068);
      putitemXml(viParams, 'DS_OBS', 'Cancelamento Cheque presente - Liq: ' + FloatToStr(vNrSeqLiq) + ' Data: ' + vDtLiq + ' Emp: ' + FloatToStr(vCdEmpLiq')) + ';
      voParams := activateCmp('FCPSVCO001', 'gravaLogDuplicata', viParams); (*,viParams,voParams,, *)
      if (xStatus < 0) then begin
        Result := voParams;
        return(-1); exit;
      end;

      setocc(tFGR_LIQITEMCC, curocc(tFGR_LIQITEMCC) + 1);
    end;
  end;

  creocc(tFCR_CHEQUEPRES, -1);
  putitem_e(tFCR_CHEQUEPRES, 'CD_EMPRESA', vCdEmpresa);
  putitem_e(tFCR_CHEQUEPRES, 'CD_CLIENTE', vCdCliente);
  putitem_e(tFCR_CHEQUEPRES, 'NR_CHEQUE', vNrCheque);
  retrieve_o(tFCR_CHEQUEPRES);
  if (xStatus = -7) then begin
    retrieve_x(tFCR_CHEQUEPRES);
  end else begin
    Result := SetStatus(STS_ERROR, 'GEN001', 'Cheque presente não encontrado para atualização do cheque presente. Empresa: ' + CD_EMPRESA + '.FCR_CHEQUEPRES Cliente: ' + CD_CLIENTE + '.FCR_CHEQUEPRES Número: ' + NR_CHEQUE + '.FCR_CHEQUEPRES.', cDS_METHOD);
    return(-1); exit;
  end;
  if (item_f('TP_SITUACAO', tFCR_CHEQUEPRES) = 2) then begin
    putitem_e(tFCR_CHEQUEPRES, 'DT_UTILIZACAO', '');
    putitem_e(tFCR_CHEQUEPRES, 'CD_OPERUTIL', '');
    putitem_e(tFCR_CHEQUEPRES, 'DT_CANCELAMENTO', '');
    putitem_e(tFCR_CHEQUEPRES, 'CD_OPERCANCEL', '');
    putitem_e(tFCR_CHEQUEPRES, 'TP_SITUACAO', 1);
    voParams := tFCR_CHEQUEPRES.Salvar();
    if (xStatus < 0) then begin
      Result := voParams;
      return(-1); exit;
    end;
  end;

  return(0); exit;
end;

end.
