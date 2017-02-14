unit uAdmUsuario;

interface

uses
  Classes, SysUtils,
  cCollection, cCollectionItem;

type
  TAdm_Usuario = class;
  TAdm_UsuarioClass = class of TAdm_Usuario;

  TAdm_UsuarioList = class;
  TAdm_UsuarioListClass = class of TAdm_UsuarioList;

  TAdm_Usuario = class(TcCollectionItem)
  private
    fCd_Usuario: Real;
    fU_Version: String;
    fCd_Senha: String;
    fNm_Login: String;
    fNm_Usuario: String;
    fTp_Bloqueio: Real;
    fTp_Privilegio: String;
    fCd_Operador: Real;
    fDt_Cadastro: TDateTime;
    fDt_Bloqueio: TDateTime;
    fCd_Funcionario: Real;
  public
    constructor Create; reintroduce;
    destructor Destroy; override;
  published
    property Cd_Usuario : Real read fCd_Usuario write fCd_Usuario;
    property U_Version : String read fU_Version write fU_Version;
    property Cd_Senha : String read fCd_Senha write fCd_Senha;
    property Nm_Login : String read fNm_Login write fNm_Login;
    property Nm_Usuario : String read fNm_Usuario write fNm_Usuario;
    property Tp_Bloqueio : Real read fTp_Bloqueio write fTp_Bloqueio;
    property Tp_Privilegio : String read fTp_Privilegio write fTp_Privilegio;
    property Cd_Operador : Real read fCd_Operador write fCd_Operador;
    property Dt_Cadastro : TDateTime read fDt_Cadastro write fDt_Cadastro;
    property Dt_Bloqueio : TDateTime read fDt_Bloqueio write fDt_Bloqueio;
    property Cd_Funcionario : Real read fCd_Funcionario write fCd_Funcionario;
  end;

  TAdm_UsuarioList = class(TcCollection)
  private
    function GetItem(Index: Integer): TAdm_Usuario;
    procedure SetItem(Index: Integer; Value: TAdm_Usuario);
  public
    constructor Create(AOwner: TPersistent);
    function Add: TAdm_Usuario;
    property Items[Index: Integer]: TAdm_Usuario read GetItem write SetItem; default;
  end;
  
implementation

{ TAdm_Usuario }

constructor TAdm_Usuario.Create;
begin

end;

destructor TAdm_Usuario.Destroy;
begin

  inherited;
end;

{ TAdm_UsuarioList }

constructor TAdm_UsuarioList.Create(AOwner: TPersistent);
begin
  inherited Create(TAdm_Usuario);
end;

function TAdm_UsuarioList.Add: TAdm_Usuario;
begin
  Result := TAdm_Usuario(inherited Add);
  Result.create;
end;

function TAdm_UsuarioList.GetItem(Index: Integer): TAdm_Usuario;
begin
  Result := TAdm_Usuario(inherited GetItem(Index));
end;

procedure TAdm_UsuarioList.SetItem(Index: Integer; Value: TAdm_Usuario);
begin
  inherited SetItem(Index, Value);
end;

end.