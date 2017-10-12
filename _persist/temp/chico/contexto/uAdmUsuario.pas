unit uAdmUsuario;

interface

uses
  Classes, SysUtils,
  mMapping;

type
  TAdm_Usuario = class(TmMapping)
  private
    fCd_Usuario: String;
    fU_Version: String;
    fCd_Senha: String;
    fNm_Login: String;
    fNm_Usuario: String;
    fTp_Bloqueio: String;
    fTp_Privilegio: String;
    fCd_Operador: String;
    fDt_Cadastro: String;
    fDt_Bloqueio: String;
    fCd_Funcionario: String;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function GetMapping() : PmMapping; override;
  published
    property Cd_Usuario : String read fCd_Usuario write fCd_Usuario;
    property U_Version : String read fU_Version write fU_Version;
    property Cd_Senha : String read fCd_Senha write fCd_Senha;
    property Nm_Login : String read fNm_Login write fNm_Login;
    property Nm_Usuario : String read fNm_Usuario write fNm_Usuario;
    property Tp_Bloqueio : String read fTp_Bloqueio write fTp_Bloqueio;
    property Tp_Privilegio : String read fTp_Privilegio write fTp_Privilegio;
    property Cd_Operador : String read fCd_Operador write fCd_Operador;
    property Dt_Cadastro : String read fDt_Cadastro write fDt_Cadastro;
    property Dt_Bloqueio : String read fDt_Bloqueio write fDt_Bloqueio;
    property Cd_Funcionario : String read fCd_Funcionario write fCd_Funcionario;
  end;

  TAdm_Usuarios = class(TList)
  public
    function Add: TAdm_Usuario; overload;
  end;

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

//--

function TAdm_Usuario.GetMapping: PmMapping;
begin
  Result := New(PmMapping);

  Result.Tabela := New(PmTabela);
  with Result.Tabela^ do begin
    Nome := 'ADM_USUARIO';
  end;

  Result.Campos := TmCampos.Create;
  with Result.Campos do begin
    Add('Cd_Usuario', 'CD_USUARIO', tfKey);
    Add('U_Version', 'U_VERSION', tfNul);
    Add('Cd_Senha', 'CD_SENHA', tfReq);
    Add('Nm_Login', 'NM_LOGIN', tfReq);
    Add('Nm_Usuario', 'NM_USUARIO', tfNul);
    Add('Tp_Bloqueio', 'TP_BLOQUEIO', tfNul);
    Add('Tp_Privilegio', 'TP_PRIVILEGIO', tfNul);
    Add('Cd_Operador', 'CD_OPERADOR', tfReq);
    Add('Dt_Cadastro', 'DT_CADASTRO', tfReq);
    Add('Dt_Bloqueio', 'DT_BLOQUEIO', tfNul);
    Add('Cd_Funcionario', 'CD_FUNCIONARIO', tfNul);
  end;

  Result.Relacoes := TmRelacoes.Create;
  with Result.Relacoes do begin
  end;
end;

//--

{ TAdm_Usuarios }

function TAdm_Usuarios.Add: TAdm_Usuario;
begin
  Result := TAdm_Usuario.Create(nil);
  Self.Add(Result);
end;

end.