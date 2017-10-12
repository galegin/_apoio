unit uUsuario;

interface

uses
  Classes, SysUtils,
  System.Generics.Collections,
  mMapping;

type
  [Tabela('USUARIO')]
  TUsuario = class(TmMapping)
  private
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
  published
    [Campo('ID_USUARIO', tfKey)]
    property Id_Usuario : Integer read fId_Usuario write fId_Usuario;
    [Campo('U_VERSION', tfNul)]
    property U_Version : String read fU_Version write fU_Version;
    [Campo('CD_OPERADOR', tfReq)]
    property Cd_Operador : Integer read fCd_Operador write fCd_Operador;
    [Campo('DT_CADASTRO', tfReq)]
    property Dt_Cadastro : String read fDt_Cadastro write fDt_Cadastro;
    [Campo('NM_USUARIO', tfReq)]
    property Nm_Usuario : String read fNm_Usuario write fNm_Usuario;
    [Campo('NM_LOGIN', tfReq)]
    property Nm_Login : String read fNm_Login write fNm_Login;
    [Campo('CD_SENHA', tfReq)]
    property Cd_Senha : String read fCd_Senha write fCd_Senha;
    [Campo('CD_PAPEL', tfNul)]
    property Cd_Papel : String read fCd_Papel write fCd_Papel;
    [Campo('TP_BLOQUEIO', tfReq)]
    property Tp_Bloqueio : Integer read fTp_Bloqueio write fTp_Bloqueio;
    [Campo('DT_BLOQUEIO', tfNul)]
    property Dt_Bloqueio : String read fDt_Bloqueio write fDt_Bloqueio;
  end;

  TUsuarios = class(TList<Usuario>);

implementation

{ TUsuario }

constructor TUsuario.Create(AOwner: TComponent);
begin
  inherited;

end;

destructor TUsuario.Destroy;
begin

  inherited;
end;

end.