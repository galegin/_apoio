unit cSICSVCO016;

interface

(* COMPONENTES 
  IMBSVCO001 / IMBSVCO003 / TRASVCO004 / 
*)        

uses
  Classes, SysUtils, DB,
  cServiceUnf, cDataSetUnf;

type
  T_SICSVCO016 = class(TcServiceUnf)
  private
    tGER_EMPRESA,
    tIMB_COMISSAO,
    tIMB_CONTRATO,
    tIMB_CONTRATOI,
    tIMB_CONTRATOIPAR,
    tIMB_CONTRATOT,
    tTRA_S_TRANSAC,
    tTRA_TRANSACAO,
    tTRA_TRANSITEM : TcDatasetUnf;
    function getParam(pParams : String = '') : String;
    function setEntidade(pParams : String = '') : String;
  protected
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;    
  published
    function validaDescontoCapa(pParams : String = '') : String;
    function validaDescontoItem(pParams : String = '') : String;
    function validaValorComissao(pParams : String = '') : String;
    function buscaValorBase(pParams : String = '') : String;
  end;

implementation

uses
  cADMSVCO001,
  cActivate, cStatus, cFuncao, cXml, dModulo;

var


//---------------------------------------------------------------
constructor T_SICSVCO016.Create(AOwner: TComponent);
//---------------------------------------------------------------
begin
  inherited Create(AOwner);
  setEntidade('');
end;

//--------------------------------
destructor T_SICSVCO016.Destroy;
//--------------------------------
begin
  inherited Destroy;
end;

//---------------------------------------------------------------
function T_SICSVCO016.getParam(pParams : String = '') : String;
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
function T_SICSVCO016.setEntidade(pParams : String = '') : String;
//---------------------------------------------------------------
begin
  tGER_EMPRESA := GetEntidade('GER_EMPRESA');
  tIMB_COMISSAO := GetEntidade('IMB_COMISSAO');
  tIMB_CONTRATO := GetEntidade('IMB_CONTRATO');
  tIMB_CONTRATOI := GetEntidade('IMB_CONTRATOI');
  tIMB_CONTRATOIPAR := GetEntidade('IMB_CONTRATOIPAR');
  tIMB_CONTRATOT := GetEntidade('IMB_CONTRATOT');
  tTRA_S_TRANSAC := GetEntidade('TRA_S_TRANSAC');
  tTRA_TRANSACAO := GetEntidade('TRA_TRANSACAO');
  tTRA_TRANSITEM := GetEntidade('TRA_TRANSITEM');
end;

//------------------------------------------------------------------
function T_SICSVCO016.validaDescontoCapa(pParams : String) : String;
//------------------------------------------------------------------
const
  cDS_METHOD = 'ADICIONAL=Operação: T_SICSVCO016.validaDescontoCapa()';
var
  viParams, voParams, viListas, vDsLstTransacao : String;
  vDsRegTransacao, vDsRegistro, vDsRegImbContratoI : String;
  vCdEmpresa, vNrTransacao, vCdEmpContrato, vNrSeqContrato, vNrSeqItem : Real;
  vDtTransacao, vDtPeriodoInicial, vDtPeriodoFinal : TDate;
  vInDesconto : Boolean;
begin
  vInDesconto := False;

  vDsRegTransacao := itemXml('DS_REGTRANSACAO', pParams);
  if (vDsRegTransacao = '') then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Transação não informada!', cDS_METHOD);
    return(-1); exit;
  end;

  vDsRegImbContratoI := itemXml('DS_REGIMBCONTRATOI', pParams);
  if (vDsRegTransacao = '') then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Contrato não informado!', cDS_METHOD);
    return(-1); exit;
  end;

  vCdEmpContrato := itemXmlF('CD_EMPRESA', vDsRegImbContratoI);
  vNrSeqContrato := itemXmlF('NR_SEQ', vDsRegImbContratoI);
  vNrSeqItem := itemXmlF('NR_SEQITEM', vDsRegImbContratoI);

  if (vCdEmpContrato = 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Emp. contrato não informada!', cDS_METHOD);
    return(-1); exit;
  end;
  if (vNrSeqContrato = 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Sequência de contrato não informada!', cDS_METHOD);
    return(-1); exit;
  end;
  if (vNrSeqItem = 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Sequência de item de contrato não informada!', cDS_METHOD);
    return(-1); exit;
  end;

  vCdEmpresa := itemXmlF('CD_EMPRESA', vDsRegTransacao);
  vNrTransacao := itemXmlF('NR_TRANSACAO', vDsRegTransacao);
  vDtTransacao := itemXml('DT_TRANSACAO', vDsRegTransacao);

  clear_e(tGER_EMPRESA);
  putitem_e(tGER_EMPRESA, 'CD_CCUSTO', vCdEmpContrato);
  retrieve_e(tGER_EMPRESA);
  if (xStatus < 0) then begin
    Result := '';
    vDsLstTransacao := '';

    vDsRegistro := '';
    putitemXml(vDsRegistro, 'CD_EMPRESA', vCdEmpresa);
    putitemXml(vDsRegistro, 'NR_TRANSACAO', vNrTransacao);
    putitemXml(vDsRegistro, 'DT_TRANSACAO', vDtTransacao);
    putitem(vDsLstTransacao,  vDsRegistro);
    putitemXml(Result, 'DS_LSTTRANSACAO', vDsLstTransacao);
    return(0); exit;
  end;

  clear_e(tIMB_CONTRATO);
  putitem_e(tIMB_CONTRATO, 'CD_EMPRESA', vCdEmpContrato);
  putitem_e(tIMB_CONTRATO, 'NR_SEQ', vNrSeqContrato);
  retrieve_e(tIMB_CONTRATO);
  if (xStatus < 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Contrato ' + FloatToStr(vNrSeqContrato) + ' na empresa ' + FloatToStr(vCdEmpContrato) + ' não cadastrado!', cDS_METHOD);
    return(-1); exit;
  end;

  clear_e(tIMB_CONTRATOI);
  putitem_e(tIMB_CONTRATOI, 'NR_SEQITEM', vNrSeqItem);
  retrieve_e(tIMB_CONTRATOI);
  if (xStatus < 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Contrato ' + FloatToStr(vNrSeqContrato,) + ' item ' + FloatToStr(vNrSeqItem) + ' não cadastrado na empresa ' + FloatToStr(vCdEmpContrato) + ' !', cDS_METHOD);
    return(-1); exit;
  end;
  if (vCdEmpresa = 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Emp. transação não informada!', cDS_METHOD);
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

  clear_e(tTRA_S_TRANSAC);
  putitem_e(tTRA_S_TRANSAC, 'CD_EMPRESA', vCdEmpresa);
  putitem_e(tTRA_S_TRANSAC, 'NR_TRANSACAO', vNrTransacao);
  putitem_e(tTRA_S_TRANSAC, 'DT_TRANSACAO', vDtTransacao);
  retrieve_e(tTRA_S_TRANSAC);
  if (xStatus < 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Transação ' + CD_EMPRESA + '.TRA_S_TRANSAC/' + NR_TRANSACAO + '.TRA_S_TRANSAC não cadastrada!', cDS_METHOD);
    return(-1); exit;
  end;
  if (item_f('VL_NEGOCIADO', tIMB_CONTRATOI) = 0) then begin
    Result := '';
    vDsLstTransacao := '';

    vDsRegistro := '';
    putitemXml(vDsRegistro, 'CD_EMPRESA', item_f('CD_EMPRESA', tTRA_S_TRANSAC));
    putitemXml(vDsRegistro, 'NR_TRANSACAO', item_f('NR_TRANSACAO', tTRA_S_TRANSAC));
    putitemXml(vDsRegistro, 'DT_TRANSACAO', item_a('DT_TRANSACAO', tTRA_S_TRANSAC));
    putitem(vDsLstTransacao,  vDsRegistro);
    putitemXml(Result, 'DS_LSTTRANSACAO', vDsLstTransacao);
    return(0); exit;
  end;

  viParams := '';

  putitemXml(viParams, 'CD_EMPCONTRATO', item_f('CD_EMPRESA', tIMB_CONTRATOI));
  putitemXml(viParams, 'NR_SEQCONTRATO', item_f('NR_SEQ', tIMB_CONTRATOI));
  putitemXml(viParams, 'NR_SEQITEM', item_f('NR_SEQITEM', tIMB_CONTRATOI));
  putitemXml(viParams, 'VL_VALOR', item_f('VL_NEGOCIADO', tIMB_CONTRATOI));
  putitemXml(viParams, 'DT_ULTFATURAMENTO', item_a('DT_ULTFAT', tIMB_CONTRATOI));
  voParams := activateCmp('IMBSVCO003', 'buscaValorItemContrato', viParams); (*,,,, *)
  if (xStatus < 0) then begin
    Result := voParams;
    return(-1); exit;
  end;
  vDtPeriodoInicial := itemXml('DT_PERIODOINICIAL', voParams);
  vDtPeriodoFinal := itemXml('DT_PERIODOFINAL', voParams);

  clear_e(tIMB_CONTRATOT);
  creocc(tIMB_CONTRATOT, -1);
  putitem_e(tIMB_CONTRATOT, 'CD_EMPTRANSACAO', item_f('CD_EMPRESA', tGER_EMPRESA));
  putitem_e(tIMB_CONTRATOT, 'NR_TRANSACAO', item_f('NR_TRANSACAO', tTRA_S_TRANSAC));
  putitem_e(tIMB_CONTRATOT, 'DT_TRANSACAO', item_a('DT_TRANSACAO', tTRA_S_TRANSAC));
  retrieve_o(tIMB_CONTRATOT);
  if (xStatus = -7) then begin
    retrieve_x(tIMB_CONTRATOT);
  end;
  putitem_e(tIMB_CONTRATOT, 'NR_SEQITEM', item_f('NR_SEQITEM', tIMB_CONTRATOI));
  putitem_e(tIMB_CONTRATOT, 'DT_PERIODOINICIAL', vDtPeriodoInicial);
  putitem_e(tIMB_CONTRATOT, 'DT_PERIODOFINAL', vDtPeriodoFinal);
  putitem_e(tIMB_CONTRATOT, 'CD_OPERADOR', itemXmlF('CD_USUARIO', PARAM_GLB));
  putitem_e(tIMB_CONTRATOT, 'DT_CADASTRO', Now);

  voParams := tIMB_CONTRATOT.Salvar();
  if (xStatus < 0) then begin
    Result := voParams;
    return(-1); exit;
  end;

  Result := '';
  vDsLstTransacao := '';

  vDsRegistro := '';
  putitemXml(vDsRegistro, 'CD_EMPRESA', item_f('CD_EMPRESA', tTRA_S_TRANSAC));
  putitemXml(vDsRegistro, 'NR_TRANSACAO', item_f('NR_TRANSACAO', tTRA_S_TRANSAC));
  putitemXml(vDsRegistro, 'DT_TRANSACAO', item_a('DT_TRANSACAO', tTRA_S_TRANSAC));
  putitem(vDsLstTransacao,  vDsRegistro);

  if (item_f('CD_EMPTRANSACAO', tIMB_CONTRATOT) = itemXmlF('CD_EMPRESA', PARAM_GLB)) then begin
    vDsRegistro := '';
    putitemXml(vDsRegistro, 'CD_EMPRESA', item_f('CD_EMPTRANSACAO', tIMB_CONTRATOT));
    putitemXml(vDsRegistro, 'NR_TRANSACAO', item_f('NR_TRANSACAO', tTRA_S_TRANSAC));
    putitemXml(vDsRegistro, 'DT_TRANSACAO', item_a('DT_TRANSACAO', tTRA_S_TRANSAC));
    putitem(vDsLstTransacao,  vDsRegistro);
  end;

  putitemXml(Result, 'DS_LSTTRANSACAO', vDsLstTransacao);

  return(0); exit;
end;

//------------------------------------------------------------------
function T_SICSVCO016.validaDescontoItem(pParams : String) : String;
//------------------------------------------------------------------
const
  cDS_METHOD = 'ADICIONAL=Operação: T_SICSVCO016.validaDescontoItem()';
var
  viParams, voParams, viListas, vDsLstTransacao, vDsLstVencimento, vDsLstTransacaoAux : String;
  vDsRegTransacao, vDsRegistro, vDsRegTransItem, vDsRegImbContratoI : String;
  vCdEmpresa, vNrTransacao, vCdEmpContrato, vNrSeqContrato, vNrSeqItem, vVlCalc, vlValor : Real;
  vPrPercentual, vVlParcela, vVlResto, vVlDesconto, vVlAcrescimo, vlValorItemContrato : Real;
  vDtTransacao, vDtPeriodoInicial, vDtPeriodoFinal, vDtUltFaturamento : TDate;
  vInDesconto : Boolean;
begin
  vDsRegTransacao := itemXml('DS_REGTRANSACAO', pParams);
  if (vDsRegTransacao = '') then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Transação não informada!', cDS_METHOD);
    return(-1); exit;
  end;

  vDsRegTransItem := itemXml('DS_REGTRANSITEM', pParams);
  if (vDsRegTransItem = '') then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Item de transação não informado!', cDS_METHOD);
    return(-1); exit;
  end;

  vDsRegImbContratoI := itemXml('DS_REGIMBCONTRATOI', pParams);
  if (vDsRegImbContratoI = '') then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Item de contrato não informado!', cDS_METHOD);
    return(-1); exit;
  end;

  vDtUltFaturamento := itemXml('DT_ULTFATURAMENTO', pParams);

  vCdEmpContrato := itemXmlF('CD_EMPRESA', vDsRegImbContratoI);
  vNrSeqContrato := itemXmlF('NR_SEQ', vDsRegImbContratoI);
  vNrSeqItem := itemXmlF('NR_SEQITEM', vDsRegImbContratoI);

  if (vCdEmpContrato = 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Emp. contrato não informada!', cDS_METHOD);
    return(-1); exit;
  end;
  if (vNrSeqContrato = 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Sequência de contrato não informada!', cDS_METHOD);
    return(-1); exit;
  end;
  if (vNrSeqItem = 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Sequência de item de contrato não informada!', cDS_METHOD);
    return(-1); exit;
  end;

  clear_e(tGER_EMPRESA);
  putitem_e(tGER_EMPRESA, 'CD_CCUSTO', vCdEmpContrato);
  retrieve_e(tGER_EMPRESA);
  if (xStatus < 0) then begin
    return(0); exit;
  end;

  clear_e(tIMB_CONTRATO);
  putitem_e(tIMB_CONTRATO, 'CD_EMPRESA', vCdEmpContrato);
  putitem_e(tIMB_CONTRATO, 'NR_SEQ', vNrSeqContrato);
  retrieve_e(tIMB_CONTRATO);
  if (xStatus < 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Contrato ' + FloatToStr(vNrSeqContrato) + ' na empresa ' + FloatToStr(vCdEmpContrato) + ' não cadastrado!', cDS_METHOD);
    return(-1); exit;
  end;

  clear_e(tIMB_CONTRATOI);
  putitem_e(tIMB_CONTRATOI, 'NR_SEQITEM', vNrSeqItem);
  retrieve_e(tIMB_CONTRATOI);
  if (xStatus < 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Contrato ' + FloatToStr(vNrSeqContrato,) + ' item ' + FloatToStr(vNrSeqItem) + ' não cadastrado na empresa ' + FloatToStr(vCdEmpContrato) + ' !', cDS_METHOD);
    return(-1); exit;
  end;

  vCdEmpresa := itemXmlF('CD_EMPRESA', vDsRegTransacao);
  vNrTransacao := itemXmlF('NR_TRANSACAO', vDsRegTransacao);
  vDtTransacao := itemXml('DT_TRANSACAO', vDsRegTransacao);

  if (vCdEmpresa = 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Emp. transação não informada!', cDS_METHOD);
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

  clear_e(tTRA_S_TRANSAC);
  putitem_e(tTRA_S_TRANSAC, 'CD_EMPRESA', vCdEmpresa);
  putitem_e(tTRA_S_TRANSAC, 'NR_TRANSACAO', vNrTransacao);
  putitem_e(tTRA_S_TRANSAC, 'DT_TRANSACAO', vDtTransacao);
  retrieve_e(tTRA_S_TRANSAC);
  if (xStatus < 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Transação ' + CD_EMPRESA + '.TRA_S_TRANSAC/' + NR_TRANSACAO + '.TRA_S_TRANSAC não cadastrada!', cDS_METHOD);
    return(-1); exit;
  end;
  if (item_f('VL_NEGOCIADO', tIMB_CONTRATOI) = 0) then begin
    return(0); exit;
  end;

  clear_e(tTRA_TRANSACAO);
  creocc(tTRA_TRANSACAO, -1);
  putitem_e(tTRA_TRANSACAO, 'CD_EMPRESA', item_f('CD_EMPRESA', tGER_EMPRESA));
  putitem_e(tTRA_TRANSACAO, 'DT_TRANSACAO', item_a('DT_TRANSACAO', tTRA_S_TRANSAC));
  putitem_e(tTRA_TRANSACAO, 'NR_TRANSACAO', item_f('NR_TRANSACAO', tTRA_S_TRANSAC));
  putitem_e(tTRA_TRANSACAO, 'CD_PESSOA', item_f('CD_PESSOA', tTRA_S_TRANSAC));
  putitem_e(tTRA_TRANSACAO, 'CD_OPERACAO', item_f('CD_OPERACAO', tTRA_S_TRANSAC));
  putitem_e(tTRA_TRANSACAO, 'CD_CONDPGTO', item_f('CD_CONDPGTO', tTRA_S_TRANSAC));
  putitem_e(tTRA_TRANSACAO, 'CD_COMPVEND', item_f('CD_COMPVEND', tTRA_S_TRANSAC));
  putitem_e(tTRA_TRANSACAO, 'TP_ORIGEMEMISSAO', item_f('TP_ORIGEMEMISSAO', tTRA_S_TRANSAC));
  viParams := '';
  putlistitensocc_e(viParams, tTRA_TRANSACAO);
  voParams := activateCmp('TRASVCO004', 'gravaCapaTransacao', viParams); (*,,,, *)
  if (xStatus < 0) then begin
    Result := voParams;
    return(-1); exit;
  end;

  viParams := '';

  putitemXml(viParams, 'CD_EMPCONTRATO', item_f('CD_EMPRESA', tIMB_CONTRATOI));
  putitemXml(viParams, 'NR_SEQCONTRATO', item_f('NR_SEQ', tIMB_CONTRATOI));
  putitemXml(viParams, 'NR_SEQITEM', item_f('NR_SEQITEM', tIMB_CONTRATOI));
  putitemXml(viParams, 'VL_VALOR', item_f('VL_NEGOCIADO', tIMB_CONTRATOI));
  putitemXml(viParams, 'DT_ULTFATURAMENTO', vDtUltFaturamento);
  voParams := activateCmp('IMBSVCO003', 'buscaValorItemContrato', viParams); (*,,,, *)
  if (xStatus < 0) then begin
    Result := voParams;
    return(-1); exit;
  end;
  vlValorItemContrato := itemXmlF('VL_VALOR', voParams);
  vDtPeriodoInicial := itemXml('DT_PERIODOINICIAL', voParams);
  vDtPeriodoFinal := itemXml('DT_PERIODOFINAL', voParams);

  vVlDesconto := 0;
  vVlAcrescimo := 0;
  viParams := '';

  putitemXml(viParams, 'CD_EMPRESA', item_f('CD_EMPRESA', tIMB_CONTRATOI));
  putitemXml(viParams, 'NR_SEQ', item_f('NR_SEQ', tIMB_CONTRATOI));
  putitemXml(viParams, 'NR_SEQITEM', item_f('NR_SEQITEM', tIMB_CONTRATOI));
  putitemXml(viParams, 'NR_PARCELA', item_f('NR_PARCELA', tIMB_CONTRATOI));
  putitemXml(viParams, 'VL_VALOR', vlValorItemContrato);
  voParams := activateCmp('IMBSVCO001', 'buscaDescontoAcrescimoItem', viParams); (*,,,, *)
  if (xStatus < 0) then begin
    Result := voParams;
    return(-1); exit;
  end;

  vVlAcrescimo := itemXmlF('VL_ACRESCIMO', voParams)/item_f('QT_SOLICITADA', tIMB_CONTRATOI);
  vVlDesconto := itemXmlF('VL_DESCONTO', voParams)/item_f('QT_SOLICITADA', tIMB_CONTRATOI);

  viParams := '';

  putitemXml(viParams, 'CD_EMPRESA', item_f('CD_EMPRESA', tTRA_TRANSACAO));
  putitemXml(viParams, 'NR_TRANSACAO', item_f('NR_TRANSACAO', tTRA_TRANSACAO));
  putitemXml(viParams, 'DT_TRANSACAO', item_a('DT_TRANSACAO', tTRA_TRANSACAO));
  putitemXml(viParams, 'CD_BARRAPRD', item_f('CD_PRODUTO', tIMB_CONTRATOI));
  putitemXml(viParams, 'IN_CODIGO', True);
  putitemXml(viParams, 'QT_SOLICITADA', item_f('QT_SOLICITADA', tIMB_CONTRATOI));
  vVlCalc := vlValorItemContrato + vVlAcrescimo;
  putitemXml(viParams, 'VL_BRUTO', vVlCalc);
  putitemXml(viParams, 'VL_LIQUIDO', vVlCalc);
  putitemXml(viParams, 'VL_DESCONTO', '');
  voParams := activateCmp('TRASVCO004', 'validaItemTransacao', viParams); (*,,,, *)
  if (xStatus < 0) then begin
    Result := SetStatus(STS_ERROR, {xCdErro} '', '{xCtxErro} ''', '');
    return(-1); exit;
  end;

  clear_e(tTRA_TRANSITEM);
  creocc(tTRA_TRANSITEM, -1);
  getlistitensocc_e(voParams, tTRA_TRANSITEM);
  putitem_e(tTRA_TRANSITEM, 'CD_COMPVEND', item_f('CD_COMPVEND', tTRA_TRANSACAO));
  putitem_e(tTRA_TRANSITEM, 'VL_UNITDESCCAB', vVlDesconto);
  vVlCalc := item_f('VL_UNITDESCCAB', tTRA_TRANSITEM) * item_f('QT_SOLICITADA', tTRA_TRANSITEM);
  putitem_e(tTRA_TRANSITEM, 'VL_TOTALDESCCAB', rounded(vVlCalc, 2));
  putitem_e(tTRA_TRANSITEM, 'VL_TOTALLIQUIDO', item_f('VL_TOTALBRUTO', tTRA_TRANSITEM) - (item_f('VL_TOTALDESC', tTRA_TRANSITEM) + item_f('VL_TOTALDESCCAB', tTRA_TRANSITEM)));
  vVlCalc := item_f('VL_TOTALLIQUIDO', tTRA_TRANSITEM) / item_f('QT_SOLICITADA', tTRA_TRANSITEM);
  putitem_e(tTRA_TRANSITEM, 'VL_UNITLIQUIDO', rounded(vVLCalc, 6));
  viParams := '';
  putlistitensocc_e(viParams, tTRA_TRANSITEM);
  voParams := activateCmp('TRASVCO004', 'gravaItemTransacao', viParams); (*,,,, *)
  if (xStatus < 0) then begin
    Result := voParams;
    return(-1); exit;
  end;

  vDsLstTransacaoAux := '';
  vDsRegistro := '';
  putitemXml(vDsRegistro, 'CD_EMPRESA', item_f('CD_EMPRESA', tTRA_TRANSACAO));
  putitemXml(vDsRegistro, 'NR_TRANSACAO', item_f('NR_TRANSACAO', tTRA_TRANSACAO));
  putitemXml(vDsRegistro, 'DT_TRANSACAO', item_a('DT_TRANSACAO', tTRA_TRANSACAO));
  putitem(vDsLstTransacaoAux,  vDsRegistro);
  viParams := '';

  putitemXml(viParams, 'DS_LSTTRANSACAO', vDsLstTransacaoAux);
  voParams := activateCmp('TRASVCO004', 'gravaTotalTransacao', viParams); (*,,,, *)
  if (xStatus < 0) then begin
    Result := voParams;
    return(-1); exit;
  end;

  clear_e(tIMB_CONTRATOIPAR);

  putitem_e(tIMB_CONTRATOIPAR, 'TP_COBRANCA', '1or3');
  retrieve_e(tIMB_CONTRATOIPAR);
  if (xStatus >= 0) then begin
    viParams := '';

    putitemXml(viParams, 'CD_EMPRESA', item_f('CD_EMPRESA', tIMB_CONTRATOI));
    putitemXml(viParams, 'NR_SEQ', item_f('NR_SEQ', tIMB_CONTRATOI));
    putitemXml(viParams, 'NR_SEQITEM', item_f('NR_SEQITEM', tIMB_CONTRATOI));
    putitemXml(viParams, 'TP_COBRANCA', item_f('TP_COBRANCA', tIMB_CONTRATOIPAR));
    putitemXml(viParams, 'VL_VALOR', vlValorItemContrato);
    putitemXml(viParams, 'DT_BASE', vDtPeriodoInicial);
    putitemXml(viParams, 'IN_VALORBASE', True);
    voParams := activateCmp('IMBSVCO001', 'geraParcelaItemContrato', viParams); (*,,,, *)
    if (xStatus < 0) then begin
      Result := voParams;
      return(-1); exit;
    end;
    vDsLstVencimento := '';
    vDsLstVencimento := itemXml('DS_LSTPARCELA', voParams);
    if (vDsLstVencimento <> '') then begin
      viParams := '';
      putitemXml(viParams, 'CD_EMPRESA', item_f('CD_EMPRESA', tTRA_TRANSACAO));
      putitemXml(viParams, 'NR_TRANSACAO', item_f('NR_TRANSACAO', tTRA_TRANSACAO));
      putitemXml(viParams, 'DT_TRANSACAO', item_a('DT_TRANSACAO', tTRA_TRANSACAO));
      putitemXml(viParams, 'DS_LSTVENCIMENTO', vDsLstVencimento);
      putitemXml(viParams, 'IN_VALIDACAO', False);
      voParams := activateCmp('TRASVCO004', 'gravaParcelaTransacao', viParams); (*,,,, *)
      if (xStatus < 0) then begin
        Result := voParams;
        return(-1); exit;
      end;
    end;
  end else begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Contrato ' + FloatToStr(vNrSeqContrato,) + ' item ' + FloatToStr(vNrSeqItem) + ' sem parcelamento!', cDS_METHOD);
    return(-1); exit;
  end;

  return(0); exit;
end;

//-------------------------------------------------------------------
function T_SICSVCO016.validaValorComissao(pParams : String) : String;
//-------------------------------------------------------------------
const
  cDS_METHOD = 'ADICIONAL=Operação: T_SICSVCO016.validaValorComissao()';
var
  vCdEmpContrato, vNrSeqContrato, vNrSeqItem, vNrSeqComissao : Real;
begin
  vCdEmpContrato := itemXmlF('CD_EMPRESA', pParams);
  vNrSeqContrato := itemXmlF('NR_SEQ', pParams);
  vNrSeqItem := itemXmlF('NR_SEQITEM', pParams);
  vNrSeqComissao := itemXmlF('NR_SEQCOMISSAO', pParams);

  if (vCdEmpContrato = 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Emp. contrato não informada!', cDS_METHOD);
    return(-1); exit;
  end;
  if (vNrSeqContrato = 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Sequência de contrato não informada!', cDS_METHOD);
    return(-1); exit;
  end;
  if (vNrSeqItem = 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Sequência de item de contrato não informada!', cDS_METHOD);
    return(-1); exit;
  end;
  if (vNrSeqComissao = 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Sequência de comissão de item de contrato não informada!', cDS_METHOD);
    return(-1); exit;
  end;

  clear_e(tIMB_CONTRATO);
  putitem_e(tIMB_CONTRATO, 'CD_EMPRESA', vCdEmpContrato);
  putitem_e(tIMB_CONTRATO, 'NR_SEQ', vNrSeqContrato);
  retrieve_e(tIMB_CONTRATO);
  if (xStatus < 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Contrato ' + FloatToStr(vNrSeqContrato) + ' na empresa ' + FloatToStr(vCdEmpContrato) + ' não cadastrado!', cDS_METHOD);
    return(-1); exit;
  end;

  clear_e(tIMB_CONTRATOI);
  putitem_e(tIMB_CONTRATOI, 'NR_SEQITEM', vNrSeqItem);
  retrieve_e(tIMB_CONTRATOI);
  if (xStatus < 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Contrato ' + FloatToStr(vNrSeqContrato,) + ' item ' + FloatToStr(vNrSeqItem) + ' não cadastrado na empresa ' + FloatToStr(vCdEmpContrato) + ' !', cDS_METHOD);
    return(-1); exit;
  end;

  clear_e(tIMB_COMISSAO);
  putitem_e(tIMB_COMISSAO, 'NR_SEQCOMISSAO', vNrSeqComissao);
  retrieve_e(tIMB_COMISSAO);
  if (xStatus < 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Sequência ' + FloatToStr(vNrSeqComissao) + ' não encontrada para o contrato ' + FloatToStr(vNrSeqContrato) + ' na empresa ' + FloatToStr(vCdEmpContrato) + ' !', cDS_METHOD);
    return(-1); exit;
  end;

  clear_e(tGER_EMPRESA);
  putitem_e(tGER_EMPRESA, 'CD_CCUSTO', vCdEmpContrato);
  retrieve_e(tGER_EMPRESA);

  Result := '';
  if (item_f('CD_EMPRESA', tGER_EMPRESA) = itemXmlF('CD_EMPRESA', PARAM_GLB)) then begin
    putitemXml(Result, 'PR_COMISSAOFAT', item_f('PR_FATCONTRATO', tIMB_COMISSAO));
    putitemXml(Result, 'PR_COMISSAOREC', item_f('PR_RECCONTRATO', tIMB_COMISSAO));
  end else begin
    putitemXml(Result, 'PR_COMISSAOFAT', item_f('PR_FATURAMENTO', tIMB_COMISSAO));
    putitemXml(Result, 'PR_COMISSAOREC', item_f('PR_RECEBIMENTO', tIMB_COMISSAO));
  end;

  return(0); exit;
end;

//--------------------------------------------------------------
function T_SICSVCO016.buscaValorBase(pParams : String) : String;
//--------------------------------------------------------------
const
  cDS_METHOD = 'ADICIONAL=Operação: T_SICSVCO016.buscaValorBase()';
var
  vCdEmpContrato, vNrSeqContrato, vNrSeqItem, vNrSeqParcela : Real;
  vInValorBase : Boolean;
begin
  vCdEmpContrato := itemXmlF('CD_EMPRESA', pParams);
  vNrSeqContrato := itemXmlF('NR_SEQ', pParams);
  vNrSeqItem := itemXmlF('NR_SEQITEM', pParams);
  vNrSeqParcela := itemXmlF('NR_SEQPARC', pParams);
  vInValorBase := itemXmlB('IN_VALORBASE', pParams);
  if (vInValorBase = '') then begin
    vInValorBase := False;
  end;
  if (vCdEmpContrato = 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Emp. contrato não informada!', cDS_METHOD);
    return(-1); exit;
  end;
  if (vNrSeqContrato = 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Sequência de contrato não informada!', cDS_METHOD);
    return(-1); exit;
  end;
  if (vNrSeqItem = 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Sequência de item de contrato não informada!', cDS_METHOD);
    return(-1); exit;
  end;

  clear_e(tIMB_CONTRATO);
  putitem_e(tIMB_CONTRATO, 'CD_EMPRESA', vCdEmpContrato);
  putitem_e(tIMB_CONTRATO, 'NR_SEQ', vNrSeqContrato);
  retrieve_e(tIMB_CONTRATO);
  if (xStatus < 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Contrato ' + FloatToStr(vNrSeqContrato) + ' na empresa ' + FloatToStr(vCdEmpContrato) + ' não cadastrado!', cDS_METHOD);
    return(-1); exit;
  end;

  clear_e(tIMB_CONTRATOI);
  putitem_e(tIMB_CONTRATOI, 'NR_SEQITEM', vNrSeqItem);
  retrieve_e(tIMB_CONTRATOI);
  if (xStatus < 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Contrato ' + FloatToStr(vNrSeqContrato,) + ' item ' + FloatToStr(vNrSeqItem) + ' não cadastrado na empresa ' + FloatToStr(vCdEmpContrato) + ' !', cDS_METHOD);
    return(-1); exit;
  end;

  clear_e(tIMB_CONTRATOIPAR);
  putitem_e(tIMB_CONTRATOIPAR, 'NR_SEQPARC', vNrSeqParcela);
  retrieve_e(tIMB_CONTRATOIPAR);
  if (xStatus < 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Contrato ' + FloatToStr(vNrSeqContrato,) + ' item ' + FloatToStr(vNrSeqItem) + ' sem sequencia de parcela ' + FloatToStr(vNrSeqParcela) + ' !', cDS_METHOD);
    return(-1); exit;
  end;

  Result := '';
  if (vInValorBase = False) then begin
    putitemXml(Result, 'VL_PARCELA', item_f('VL_PARCELA', tIMB_CONTRATOIPAR));
  end else begin
    putitemXml(Result, 'VL_PARCELA', item_f('VL_PARCELANEG', tIMB_CONTRATOIPAR));
  end;

  return(0); exit;
end;

end.
