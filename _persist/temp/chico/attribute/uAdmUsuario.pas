unit uAdmUsuario;

interface

uses
  Classes, SysUtils,
  System.Generics.Collections,
  mMapping;

type
  [Tabela('ADM_USUARIO')]
  TAdm_Usuario = class(TmMapping)
  private
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
  published
    [Campo('CD_USUARIO', tfKey)]
    property Cd_Usuario : String read fCd_Usuario write fCd_Usuario;
    [Campo('U_VERSION', tfNul)]
    property U_Version : String read fU_Version write fU_Version;
    [Campo('CD_SENHA', tfReq)]
    property Cd_Senha : String read fCd_Senha write fCd_Senha;
    [Campo('NM_LOGIN', tfReq)]
    property Nm_Login : String read fNm_Login write fNm_Login;
    [Campo('NM_USUARIO', tfNul)]
    property Nm_Usuario : String read fNm_Usuario write fNm_Usuario;
    [Campo('TP_BLOQUEIO', tfNul)]
    property Tp_Bloqueio : String read fTp_Bloqueio write fTp_Bloqueio;
    [Campo('TP_PRIVILEGIO', tfNul)]
    property Tp_Privilegio : String read fTp_Privilegio write fTp_Privilegio;
    [Campo('CD_OPERADOR', tfReq)]
    property Cd_Operador : String read fCd_Operador write fCd_Operador;
    [Campo('DT_CADASTRO', tfReq)]
    property Dt_Cadastro : String read fDt_Cadastro write fDt_Cadastro;
    [Campo('DT_BLOQUEIO', tfNul)]
    property Dt_Bloqueio : String read fDt_Bloqueio write fDt_Bloqueio;
    [Campo('CD_FUNCIONARIO', tfNul)]
    property Cd_Funcionario : String read fCd_Funcionario write fCd_Funcionario;
  end;

  TAdm_Usuarios = class(TList<Adm_Usuario>);

implementation

{ TAdm_Usuario }

constructor TAdm_Usuario.Create(AOwner: TComponent);
begin
  inherited;

end;

destructor TAdm_Usuario.Destroy;
begin

  inherited;
end;

end.