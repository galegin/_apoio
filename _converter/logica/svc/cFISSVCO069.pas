unit cFISSVCO069;

interface

        

uses
  Classes, SysUtils, DB,
  cServiceUnf, cDataSetUnf;

type
  T_FISSVCO069 = class(TcServiceUnf)
  private
    tFIS_IMPOSTO : TcDatasetUnf;
    function getParam(pParams : String = '') : String;
    function setEntidade(pParams : String = '') : String;

  protected
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;    
  published
    function retornaImposto(pParams : String = '') : String;
  end;

implementation

uses
  cActivate, cStatus, cFuncao, cXml, dModulo;

var


//---------------------------------------------------------------
constructor T_FISSVCO069.Create(AOwner: TComponent);
//---------------------------------------------------------------
begin
  inherited Create(AOwner);
  setEntidade('');
end;

//--------------------------------
destructor T_FISSVCO069.Destroy;
//--------------------------------
begin
  inherited Destroy;
end;

//---------------------------------------------------------------
function T_FISSVCO069.getParam(pParams : String) : String;
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
  xParam := activateCmp('ADMSVCO001', 'GetParametro', xParam);
  gUsaCondPgtoEspecial := itemXmlB('IN_USA_COND_PGTO_ESPECIAL', xParam);
  
  xParamEmp := '';
  putitem(xParamEmp, 'VL_MINIMO_PARCELA');
  xParamEmp := activateCmp('ADMSVCO001', 'GetParamEmpresa', piCdEmpresa, xParamEmp);
  gVlMinimoParcela := itemXmlF('VL_MINIMO_PARCELA', xParamEmp);  
  *)

  xParam := '';

  xParam := activateCmp('ADMSVCO001', 'GetParametro', xParam);


  xParamEmp := '';

  xParamEmp := activateCmp('ADMSVCO001', 'GetParamEmpresa', piCdEmpresa, xParamEmp);


end;

//---------------------------------------------------------------
function T_FISSVCO069.setEntidade(pParams : String) : String;
//---------------------------------------------------------------
begin
  tFIS_IMPOSTO := GetEntidade('FIS_IMPOSTO');
end;

//--------------------------------------------------------------
function T_FISSVCO069.retornaImposto(pParams : String) : String;
//--------------------------------------------------------------
const
  cDS_METHOD = 'ADICIONAL=Operação: T_FISSVCO069.retornaImposto()';
var
  vCdImposto : Real;
  vDtVigencia : TDateTime;
begin
  vCdImposto := itemXmlF('CD_IMPOSTO', pParams);
  vDtVigencia := itemXml('DT_INIVIGENCIA', pParams);

  if (vDtVigencia = '') then begin
    vDtVigencia := itemXml('DT_SISTEMA', PARAM_GLB);
  end;
  if (vCdImposto = '') then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Imposto não informado!', cDS_METHOD);
    return(-1); exit;
  end;
  if (vDtVigencia = '') then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Data de início da vigência não informada!', cDS_METHOD);
    return(-1); exit;
  end;

  clear_e(tFIS_IMPOSTO);
  putitem_o(tFIS_IMPOSTO, 'CD_IMPOSTO', vCdImposto);
  putitem_o(tFIS_IMPOSTO, 'DT_INIVIGENCIA', '<=' + vDtVigencia' + ');
  putitem_o(tFIS_IMPOSTO, 'TP_SITUACAO', 1);
  retrieve_e(tFIS_IMPOSTO);
  if (xStatus >= 0) then begin
    setocc(tFIS_IMPOSTO, -1);
    sort_e(tFIS_IMPOSTO, '    sort/e , DT_INIVIGENCIA;');
    setocc(tFIS_IMPOSTO, -1);
    putlistitensocc_e(Result, tFIS_IMPOSTO);
  end else begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Nenhum registro ativo encontrado para esta vigência!', cDS_METHOD);
    return(-1); exit;
  end;

  return(0); exit;

End;

end.
