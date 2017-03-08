unit cGERSVCO103;

interface

        

uses
  Classes, SysUtils, Math, DB,
  cServiceUnf, cDataSetUnf;

type
  T_GERSVCO103 = class(TcServiceUnf)
  private
    tGER_CONDPGTOC,
    tGER_OPERCPG : TcDatasetUnf;
    function getParam(pParams : String = '') : String;
    function setEntidade(pParams : String = '') : String;
  protected
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;    
  published
    function buscaCondPgtoOperacao(pParams : String = '') : String;
    function validaCondPgtoOperacao(pParams : String = '') : String;
  end;

implementation

uses
  cADMSVCO001,
  cActivate, cStatus, cFuncao, cXml, dModulo;

var


//---------------------------------------------------------------
constructor T_GERSVCO103.Create(AOwner: TComponent);
//---------------------------------------------------------------
begin
  inherited Create(AOwner);
  setEntidade('');
end;

//--------------------------------
destructor T_GERSVCO103.Destroy;
//--------------------------------
begin
  inherited Destroy;
end;

//---------------------------------------------------------------
function T_GERSVCO103.getParam(pParams : String = '') : String;
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
function T_GERSVCO103.setEntidade(pParams : String = '') : String;
//---------------------------------------------------------------
begin
  tGER_CONDPGTOC := GetEntidade('GER_CONDPGTOC');
  tGER_OPERCPG := GetEntidade('GER_OPERCPG');
end;

//---------------------------------------------------------------------
function T_GERSVCO103.buscaCondPgtoOperacao(pParams : String) : String;
//---------------------------------------------------------------------
const
  cDS_METHOD = 'ADICONAL=Operação: T_GERSVCO103.buscaCondPgtoOperacao()';
var
  vCdOperacao : Real;
  vDsLstCondicao : String;
begin
  vCdOperacao := itemXmlF('CD_OPERACAO', pParams);

  if (vCdOperacao = 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Operação não informada!', cDS_METHOD);
    return(-1); exit;
  end;

  vDsLstCondicao := '';

  clear_e(tGER_OPERCPG);
  putitem_e(tGER_OPERCPG, 'CD_OPERACAO', vCdOperacao);
  retrieve_e(tGER_OPERCPG);
  if (xStatus >= 0) then begin
    setocc(tGER_OPERCPG, -1);
    setocc(tGER_OPERCPG, 1);

    putlistitems vDsLstCondicao, item_f('CD_CONDPGTO', tGER_OPERCPG);
  end;

  Result := '';
  putitemXml(Result, 'CD_CONDPGTO', vDsLstCondicao);

  return(0); exit;
end;

//----------------------------------------------------------------------
function T_GERSVCO103.validaCondPgtoOperacao(pParams : String) : String;
//----------------------------------------------------------------------
const
  cDS_METHOD = 'ADICONAL=Operação: T_GERSVCO103.validaCondPgtoOperacao()';
var
  vCdOperacao, vCdCondPgto : Real;
  vDsLstCondicao : String;
begin
  vCdOperacao := itemXmlF('CD_OPERACAO', pParams);
  vCdCondPgto := itemXmlF('CD_CONDPGTO', pParams);

  if (vCdOperacao = 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Operação não informada!', cDS_METHOD);
    return(-1); exit;
  end;
  if (vCdCondPgto = 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Condição de pagamento não informada!', cDS_METHOD);
    return(-1); exit;
  end;

  clear_e(tGER_CONDPGTOC);
  putitem_e(tGER_CONDPGTOC, 'CD_CONDPGTO', vCdCondPgto);
  retrieve_e(tGER_CONDPGTOC);
  if (xStatus < 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Condição de pgto. ' + FloatToStr(vCdCondPgto) + ' não cadastrada!', cDS_METHOD);
    return(-1); exit;
  end;
  if (item_b('IN_BLOQUEIO', tGER_CONDPGTOC) = True) then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Condição de pgto. ' + FloatToStr(vCdCondPgto) + ' está bloqueada!', cDS_METHOD);
    return(-1); exit;
  end;

  clear_e(tGER_OPERCPG);
  putitem_e(tGER_OPERCPG, 'CD_OPERACAO', vCdOperacao);
  retrieve_e(tGER_OPERCPG);
  if (xStatus >= 0) then begin
    clear_e(tGER_OPERCPG);
    putitem_e(tGER_OPERCPG, 'CD_OPERACAO', vCdOperacao);
    putitem_e(tGER_OPERCPG, 'CD_CONDPGTO', vCdCondPgto);
    retrieve_e(tGER_OPERCPG);
    if (xStatus < 0) then begin
      Result := SetStatus(STS_ERROR, 'GEN0001', 'Condição de pagamento: ' + FloatToStr(vCdCondPgto) + ' não vinculada a operação: ' + FloatToStr(vCdCondPgto) + '!', cDS_METHOD);
      return(-1); exit;
    end;
  end;

  return(0); exit;
end;


end.
