unit uAdmUsuario;

interface

uses
  Classes, SysUtils,
  mCollection, mCollectionItem;

type
  TAdm_Usuario = class;
  TAdm_UsuarioClass = class of TAdm_Usuario;

  TAdm_UsuarioList = class;
  TAdm_UsuarioListClass = class of TAdm_UsuarioList;

  TAdm_Usuario = class(TmCollectionItem)
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
    constructor Create(ACollection: TCollection); override;
    destructor Destroy; override;
  published
    property Cd_Usuario : String read fCd_Usuario write SetCd_Usuario;
    property U_Version : String read fU_Version write SetU_Version;
    property Cd_Senha : String read fCd_Senha write SetCd_Senha;
    property Nm_Login : String read fNm_Login write SetNm_Login;
    property Nm_Usuario : String read fNm_Usuario write SetNm_Usuario;
    property Tp_Bloqueio : String read fTp_Bloqueio write SetTp_Bloqueio;
    property Tp_Privilegio : String read fTp_Privilegio write SetTp_Privilegio;
    property Cd_Operador : String read fCd_Operador write SetCd_Operador;
    property Dt_Cadastro : String read fDt_Cadastro write SetDt_Cadastro;
    property Dt_Bloqueio : String read fDt_Bloqueio write SetDt_Bloqueio;
    property Cd_Funcionario : String read fCd_Funcionario write SetCd_Funcionario;
  end;

  TAdm_UsuarioList = class(TmCollection)
  private
    function GetItem(Index: Integer): TAdm_Usuario;
    procedure SetItem(Index: Integer; Value: TAdm_Usuario);
  public
    constructor Create(AOwner: TPersistentCollection);
    function Add: TAdm_Usuario;
    property Items[Index: Integer]: TAdm_Usuario read GetItem write SetItem; default;
  end;

implementation

{ TAdm_Usuario }

constructor TAdm_Usuario.Create(ACollection: TCollection);
begin
  inherited;

end;

destructor TAdm_Usuario.Destroy;
begin

  inherited;
end;

{ TAdm_UsuarioList }

constructor TAdm_UsuarioList.Create(AOwner: TPersistentCollection);
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