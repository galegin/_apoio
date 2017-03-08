unit cLOGSVCO004;

interface

        

uses
  Classes, SysUtils, DB,
  cServiceUnf, cDataSetUnf;

type
  T_LOGSVCO004 = class(TcServiceUnf)
  private
    tSIS_SESSAO : TcDatasetUnf;
    function getParam(pParams : String = '') : String;
    function setEntidade(pParams : String = '') : String;
  protected
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;    
  published
    function gravaUltComponente(pParams : String = '') : String;
  end;

implementation

uses
  cADMSVCO001,
  cActivate, cStatus, cFuncao, cXml, dModulo;

var


//---------------------------------------------------------------
constructor T_LOGSVCO004.Create(AOwner: TComponent);
//---------------------------------------------------------------
begin
  inherited Create(AOwner);
  setEntidade('');
end;

//--------------------------------
destructor T_LOGSVCO004.Destroy;
//--------------------------------
begin
  inherited Destroy;
end;

//---------------------------------------------------------------
function T_LOGSVCO004.getParam(pParams : String = '') : String;
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
function T_LOGSVCO004.setEntidade(pParams : String = '') : String;
//---------------------------------------------------------------
begin
  tSIS_SESSAO := GetEntidade('SIS_SESSAO');
end;

//------------------------------------------------------------------
function T_LOGSVCO004.gravaUltComponente(pParams : String) : String;
//------------------------------------------------------------------
const
  cDS_METHOD = 'ADICIONAL=Operação: T_LOGSVCO004.gravaUltComponente()';
var
  vCdComponente : String;
  vCdUsuario, vNrSessao : Real;
begin
  vCdUsuario := itemXmlF('CD_USUARIO', pParams);
  vCdComponente := itemXmlF('CD_COMPONENTE', pParams);
  vNrSessao := itemXmlF('NR_SESSAO', gModulo.gParamUsr);

  if (vCdUsuario  = 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Usuário não informado!', cDS_METHOD);
    return(-1); exit;
  end;
  if (vCdComponente  = 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Componente não informado!', cDS_METHOD);
    return(-1); exit;
  end;
  if (vNrSessao = 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Sessão não informada!', cDS_METHOD);
    return(-1); exit;
  end;

  clear_e(tSIS_SESSAO);
  creocc(tSIS_SESSAO, -1);
  putitem_e(tSIS_SESSAO, 'NR_SESSAO', vNrSessao);
  putitem_e(tSIS_SESSAO, 'CD_OPERADOR', vCdUsuario);
  putitem_e(tSIS_SESSAO, 'DT_CADASTRO', Date);
  retrieve_o(tSIS_SESSAO);
  if (xStatus = -7) then begin
    retrieve_x(tSIS_SESSAO);
  end;
  putitem_e(tSIS_SESSAO, 'CD_ULTIMOCOMPONENTE', vCdComponente);

  voParams := tSIS_SESSAO.Salvar();

  commit;
  if (xStatus < 0) then begin
    rollback;
    return(-1); exit;
  end else begin
    voParams := SetHint(viParams); (* 'ID=APLINFO002' *)
  end;

  return(0); exit;
end;

end.
