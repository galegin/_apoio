unit cADMSVCO027;

interface

        

uses
  Classes, SysUtils, DB,
  cServiceUnf, cDataSetUnf;

type
  T_ADMSVCO027 = class(TcServiceUnf)
  private
    tV_ADM_USUARIO : TcDatasetUnf;
    function getParam(pParams : String = '') : String;
    function setEntidade(pParams : String = '') : String;
  protected
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;    
  published
    function validaUsuarioEspecial(pParams : String = '') : String;
  end;

implementation

uses
  cADMSVCO001,
  cActivate, cStatus, cFuncao, cXml, dModulo;

var


//---------------------------------------------------------------
constructor T_ADMSVCO027.Create(AOwner: TComponent);
//---------------------------------------------------------------
begin
  inherited Create(AOwner);
  setEntidade('');
end;

//--------------------------------
destructor T_ADMSVCO027.Destroy;
//--------------------------------
begin
  inherited Destroy;
end;

//---------------------------------------------------------------
function T_ADMSVCO027.getParam(pParams : String = '') : String;
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
function T_ADMSVCO027.setEntidade(pParams : String = '') : String;
//---------------------------------------------------------------
begin
  tV_ADM_USUARIO := GetEntidade('V_ADM_USUARIO');
end;

//---------------------------------------------------------------------
function T_ADMSVCO027.validaUsuarioEspecial(pParams : String) : String;
//---------------------------------------------------------------------
const
  cDS_METHOD = 'ADICIONAL=Operação: T_ADMSVCO027.validaUsuarioEspecial()';
var
  vCdUsuario : Real;
  vNmUsuario, vNmLogin : String;
begin
  vCdUsuario := itemXmlF('CD_USUARIO', pParams);

  if (vCdUsuario = '') then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Usuário não informado!', cDS_METHOD);
    return(-1); exit;
  end;

  clear_e(tV_ADM_USUARIO);
  putitem_e(tV_ADM_USUARIO, 'CD_USUARIO', vCdUsuario);
  retrieve_e(tV_ADM_USUARIO);
  if (xStatus >= 0) then begin
    if (item_f('TP_PRIVILEGIO', tV_ADM_USUARIO) = 'A') then begin
      vNmUsuario := 'ADMIN - ' + NM_USUARIO + '.V_ADM_USUARIO';
      vNmLogin := 'A ' + NM_LOGIN + '.V_ADM_USUARIO';
    end else if (item_f('TP_PRIVILEGIO', tV_ADM_USUARIO) = 'E') then begin
      vNmUsuario := 'ENGEN - ' + NM_USUARIO + '.V_ADM_USUARIO';
      vNmLogin := 'E ' + NM_LOGIN + '.V_ADM_USUARIO';
    end else if (item_f('TP_PRIVILEGIO', tV_ADM_USUARIO) = 'S') then begin
      vNmUsuario := 'SUPEX - ' + NM_USUARIO + '.V_ADM_USUARIO';
      vNmLogin := 'S ' + NM_LOGIN + '.V_ADM_USUARIO';
    end else if (item_f('TP_PRIVILEGIO', tV_ADM_USUARIO) = 'F') then begin
      vNmUsuario := 'FINAN - ' + NM_USUARIO + '.V_ADM_USUARIO';
      vNmLogin := 'F ' + NM_LOGIN + '.V_ADM_USUARIO';
    end else if (item_f('TP_PRIVILEGIO', tV_ADM_USUARIO) = 'D') then begin
      vNmUsuario := 'DESEN - ' + NM_USUARIO + '.V_ADM_USUARIO';
      vNmLogin := 'D ' + NM_LOGIN + '.V_ADM_USUARIO';
    end else if (item_f('TP_PRIVILEGIO', tV_ADM_USUARIO) = 'V') then begin
      vNmUsuario := 'VIRTUAL - ' + NM_USUARIO + '.V_ADM_USUARIO';
      vNmLogin := 'V ' + NM_LOGIN + '.V_ADM_USUARIO';
    end else begin
      vNmUsuario := '' + NM_USUARIO + '.V_ADM_USUARIO';
      vNmLogin := '' + NM_LOGIN + '.V_ADM_USUARIO';
    end;
  end else begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Usuário ' + FloatToStr(vCdUsuario) + ' informado é inválido!', cDS_METHOD);
    return(-1); exit;
  end;
  if (vNmUsuario <> '') then begin
    putitemXml(Result, 'NM_USUARIO', vNmUsuario);
    putitemXml(Result, 'NM_LOGIN', vNmLogin);
    putitemXml(Result, 'CD_FUNCIONARIO', item_f('CD_FUNCIONARIO', tV_ADM_USUARIO));
  end;

  return(0); exit;
end;

end.
