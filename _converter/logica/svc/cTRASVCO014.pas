unit cTRASVCO014;

interface

(* COMPONENTES 
  FISSVCO004 / FISSVCO038 / TRASVCO004 / 
*)        

uses
  Classes, SysUtils, DB,
  cServiceUnf, cDataSetUnf;

type
  T_TRASVCO014 = class(TcServiceUnf)
  private
    tTRA_TRANSACAO : TcDatasetUnf;
    function getParam(pParams : String = '') : String;
    function setEntidade(pParams : String = '') : String;
  protected
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;    
  published
    function INIT(pParams : String = '') : String;
    function CLEANUP(pParams : String = '') : String;
    function geraDoctoFiscalInterno(pParams : String = '') : String;
  end;

implementation

uses
  cADMSVCO001,
  cActivate, cStatus, cFuncao, cXml, dModulo;

var


//---------------------------------------------------------------
constructor T_TRASVCO014.Create(AOwner: TComponent);
//---------------------------------------------------------------
begin
  inherited Create(AOwner);
  setEntidade('');
end;

//--------------------------------
destructor T_TRASVCO014.Destroy;
//--------------------------------
begin
  inherited Destroy;
end;

//---------------------------------------------------------------
function T_TRASVCO014.getParam(pParams : String = '') : String;
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
function T_TRASVCO014.setEntidade(pParams : String = '') : String;
//---------------------------------------------------------------
begin
  tTRA_TRANSACAO := GetEntidade('TRA_TRANSACAO');
end;

//----------------------------------------------------
function T_TRASVCO014.INIT(pParams : String) : String;
//----------------------------------------------------
const
  cDS_METHOD = 'ADICIONAL=Operação: T_TRASVCO014.INIT()';
begin
end;

//-------------------------------------------------------
function T_TRASVCO014.CLEANUP(pParams : String) : String;
//-------------------------------------------------------
const
  cDS_METHOD = 'ADICIONAL=Operação: T_TRASVCO014.CLEANUP()';
begin
end;

//----------------------------------------------------------------------
function T_TRASVCO014.geraDoctoFiscalInterno(pParams : String) : String;
//----------------------------------------------------------------------
const
  cDS_METHOD = 'ADICIONAL=Operação: T_TRASVCO014.geraDoctoFiscalInterno()';
var
  viParams, voParams, vDsLstTransacao, vDsRegistro, vLstNf, vCdSerie : String;
  vCdEmpresa, vNrTransacao, vNrNf : Real;
  vDtTransacao, vDtSaidaEntrada, vDtFatura : TDate;
  vInSemInspecao, vInItemLote : Boolean;
begin
  vDsLstTransacao := itemXml('DS_LSTTRANSACAO', pParams);

  vCdSerie := itemXmlF('CD_SERIE', pParams);
  vNrNf := itemXmlF('NR_NF', pParams);

  vInSemInspecao := itemXmlB('IN_SEMINSPECAO', pParams);
  vInItemLote := itemXmlB('IN_ITEMLOTE', pParams);

  vDtSaidaEntrada := itemXml('DT_SAIDAENTRADA', pParams);
  vDtFatura := itemXml('DT_FATURA', pParams);

  if (vDsLstTransacao = '') then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Lista de transação não informada!', cDS_METHOD);
    return(-1); exit;
  end;

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
      Result := SetStatus(STS_ERROR, 'GEN0001', 'Número da transação não informado!', cDS_METHOD);
      return(-1); exit;
    end;

    clear_e(tTRA_TRANSACAO);
    putitem_e(tTRA_TRANSACAO, 'CD_EMPRESA', vCdEmpresa);
    putitem_e(tTRA_TRANSACAO, 'NR_TRANSACAO', vNrTransacao);
    putitem_e(tTRA_TRANSACAO, 'DT_TRANSACAO', vDtTransacao);
    retrieve_e(tTRA_TRANSACAO);
    if (xStatus < 0) then begin
      Result := SetStatus(STS_ERROR, 'GEN0001', 'Transação ' + FloatToStr(vNrTransacao) + ' não cadastrada!', cDS_METHOD);
      return(-1); exit;
    end;

    viParams := '';
    putitemXml(viParams, 'CD_EMPRESA', item_f('CD_EMPRESA', tTRA_TRANSACAO));
    putitemXml(viParams, 'NR_TRANSACAO', item_f('NR_TRANSACAO', tTRA_TRANSACAO));
    putitemXml(viParams, 'DT_TRANSACAO', item_a('DT_TRANSACAO', tTRA_TRANSACAO));
    voParams := activateCmp('TRASVCO004', 'gravaenderecoTransacao', viParams); (*,,,, *)
    if (xStatus < 0) then begin
      Result := voParams;
      return(-1); exit;
    end;

    viParams := '';
    putitemXml(viParams, 'CD_EMPRESA', item_f('CD_EMPRESA', tTRA_TRANSACAO));
    putitemXml(viParams, 'NR_TRANSACAO', item_f('NR_TRANSACAO', tTRA_TRANSACAO));
    putitemXml(viParams, 'DT_TRANSACAO', item_a('DT_TRANSACAO', tTRA_TRANSACAO));

    voParams := activateCmp('TRASVCO004', 'gravaParcelaTransacao', viParams); (*,,,, *)
    if (xStatus < 0) then begin
      Result := voParams;
      return(-1); exit;
    end;
    delitem(vDsLstTransacao, 1);
  until (vDsLstTransacao = '');

  viParams := '';
  putitemXml(viParams, 'DS_LSTTRANSACAO', itemXml('DS_LSTTRANSACAO', pParams));
  putitemXml(viParams, 'TP_MODDCTOFISCAL', 35);
  putitemXml(viParams, 'CD_SERIE', vCdSerie);
  putitemXml(viParams, 'NR_NF', vNrNf);
  putitemXml(viParams, 'IN_ITEMLOTE', vInItemLote);
  putitemXml(viParams, 'DT_SAIDAENTRADA', vDtSaidaEntrada);
  putitemXml(viParams, 'DT_FATURA', vDtFatura);
  voParams := activateCmp('FISSVCO004', 'geraNF', viParams); (*,,,, *)
  if (xStatus < 0) then begin
    Result := voParams;
    return(-1); exit;
  end;

  vLstNf := itemXml('DS_LSTNF', voParams);

  viParams := voParams;
  putitemXml(viParams, 'IN_ESTORNO', False);
  putitemXml(viParams, 'IN_SEMINSPECAO', vInSemInspecao);
  putitemXml(viParams, 'DT_KARDEX', vDtFatura);
  voParams := activateCmp('FISSVCO038', 'atualizaEstoqueNF', viParams); (*,,,, *)

  if (xStatus < 0) then begin
    Result := voParams;
    return(-1); exit;
  end;
  end else if (xStatus = -5) then begin
    Result := SetStatus(STS_ERROR, {xCdErro} '', '{xCtxErro} ''', '');
    exit(-5);

  end else if (xStatus < 0) then begin
    Result := SetStatus(STS_ERROR, {xCdErro} '', '{xCtxErro} ''', '');
    return(-1); exit;
  end;

  putitemXml(viParams, 'DS_LSTTRANSACAO', itemXml('DS_LSTTRANSACAO', pParams));
  putitemXml(viParams, 'TP_SITUACAO', 4);
  voParams := activateCmp('TRASVCO004', 'alteraSituacaoTransacao', viParams); (*,,,, *)
  if (xStatus < 0) then begin
    Result := voParams;
    return(-1); exit;
  end;
  putitemXml(Result, 'LST_NF', vLstNf);

  return(0); exit;
end;

end.
