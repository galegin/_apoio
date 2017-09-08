unit uUsuario;

interface

uses
  Classes, SysUtils,
  mMapping;

type
  TUsuario = class(TmMapping)
  private
    fCd_Usuario: String;
    fU_Version: String;
    fCd_Operador: Integer;
    fDt_Cadastro: TDateTime;
    fNm_Usuario: String;
    fNm_Login: String;
    fCd_Senha: String;
    fCd_Papel: String;
    fTp_Bloqueio: Integer;
    fDt_Bloqueio: TDateTime;
    procedure SetCd_Usuario(const Value : String);
    procedure SetU_Version(const Value : String);
    procedure SetCd_Operador(const Value : Integer);
    procedure SetDt_Cadastro(const Value : TDateTime);
    procedure SetNm_Usuario(const Value : String);
    procedure SetNm_Login(const Value : String);
    procedure SetCd_Senha(const Value : String);
    procedure SetCd_Papel(const Value : String);
    procedure SetTp_Bloqueio(const Value : Integer);
    procedure SetDt_Bloqueio(const Value : TDateTime);
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function GetMapping() : PmMapping; override;
  published
    property Cd_Usuario : String read fCd_Usuario write SetCd_Usuario;
    property U_Version : String read fU_Version write SetU_Version;
    property Cd_Operador : Integer read fCd_Operador write SetCd_Operador;
    property Dt_Cadastro : TDateTime read fDt_Cadastro write SetDt_Cadastro;
    property Nm_Usuario : String read fNm_Usuario write SetNm_Usuario;
    property Nm_Login : String read fNm_Login write SetNm_Login;
    property Cd_Senha : String read fCd_Senha write SetCd_Senha;
    property Cd_Papel : String read fCd_Papel write SetCd_Papel;
    property Tp_Bloqueio : Integer read fTp_Bloqueio write SetTp_Bloqueio;
    property Dt_Bloqueio : TDateTime read fDt_Bloqueio write SetDt_Bloqueio;
  end;

  TUsuarios = class(TList)
  public
    function Add: TUsuario; overload;
  end;

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

//--

function TUsuario.GetMapping: PmMapping;
begin
  Result := New(PmMapping);

  Result.Tabela := New(PmTabela);
  with Result.Tabela^ do begin
    Nome := 'USUARIO';
  end;

  Result.Chaves := TmChaves.Create;
  with Result.Chaves do begin
    Add('Cd_Usuario', 'CD_USUARIO');
  end;

  Result.Campos := TmCampos.Create;
  with Result.Campos do begin
    Add('Cd_Usuario', 'CD_USUARIO');
    Add('U_Version', 'U_VERSION');
    Add('Cd_Operador', 'CD_OPERADOR');
    Add('Dt_Cadastro', 'DT_CADASTRO');
    Add('Nm_Usuario', 'NM_USUARIO');
    Add('Nm_Login', 'NM_LOGIN');
    Add('Cd_Senha', 'CD_SENHA');
    Add('Cd_Papel', 'CD_PAPEL');
    Add('Tp_Bloqueio', 'TP_BLOQUEIO');
    Add('Dt_Bloqueio', 'DT_BLOQUEIO');
  end;

  Result.Relacoes := TmRelacoes.Create;
  with Result.Relacoes do begin
  end;
end;

//--

procedure TUsuario.SetCd_Usuario(const Value : String);
begin
  fCd_Usuario := Value;
end;

procedure TUsuario.SetU_Version(const Value : String);
begin
  fU_Version := Value;
end;

procedure TUsuario.SetCd_Operador(const Value : Integer);
begin
  fCd_Operador := Value;
end;

procedure TUsuario.SetDt_Cadastro(const Value : TDateTime);
begin
  fDt_Cadastro := Value;
end;

procedure TUsuario.SetNm_Usuario(const Value : String);
begin
  fNm_Usuario := Value;
end;

procedure TUsuario.SetNm_Login(const Value : String);
begin
  fNm_Login := Value;
end;

procedure TUsuario.SetCd_Senha(const Value : String);
begin
  fCd_Senha := Value;
end;

procedure TUsuario.SetCd_Papel(const Value : String);
begin
  fCd_Papel := Value;
end;

procedure TUsuario.SetTp_Bloqueio(const Value : Integer);
begin
  fTp_Bloqueio := Value;
end;

procedure TUsuario.SetDt_Bloqueio(const Value : TDateTime);
begin
  fDt_Bloqueio := Value;
end;

{ TUsuarios }

function TUsuarios.Add: TUsuario;
begin
  Result := TUsuario.Create(nil);
  Self.Add(Result);
end;

end.