unit uUsuario;

interface

uses
  Classes, SysUtils,
  mCollection, mCollectionItem;

type
  TUsuario = class;
  TUsuarioClass = class of TUsuario;

  TUsuarioList = class;
  TUsuarioListClass = class of TUsuarioList;

  TUsuario = class(TmCollectionItem)
  private
    fId_Usuario: Integer;
    fU_Version: String;
    fCd_Operador: Integer;
    fDt_Cadastro: String;
    fNm_Usuario: String;
    fNm_Login: String;
    fCd_Senha: String;
    fCd_Papel: String;
    fTp_Bloqueio: Integer;
    fDt_Bloqueio: String;
  public
    constructor Create(ACollection: TCollection); override;
    destructor Destroy; override;
  published
    property Id_Usuario : Integer read fId_Usuario write SetId_Usuario;
    property U_Version : String read fU_Version write SetU_Version;
    property Cd_Operador : Integer read fCd_Operador write SetCd_Operador;
    property Dt_Cadastro : String read fDt_Cadastro write SetDt_Cadastro;
    property Nm_Usuario : String read fNm_Usuario write SetNm_Usuario;
    property Nm_Login : String read fNm_Login write SetNm_Login;
    property Cd_Senha : String read fCd_Senha write SetCd_Senha;
    property Cd_Papel : String read fCd_Papel write SetCd_Papel;
    property Tp_Bloqueio : Integer read fTp_Bloqueio write SetTp_Bloqueio;
    property Dt_Bloqueio : String read fDt_Bloqueio write SetDt_Bloqueio;
  end;

  TUsuarioList = class(TmCollection)
  private
    function GetItem(Index: Integer): TUsuario;
    procedure SetItem(Index: Integer; Value: TUsuario);
  public
    constructor Create(AOwner: TPersistentCollection);
    function Add: TUsuario;
    property Items[Index: Integer]: TUsuario read GetItem write SetItem; default;
  end;

implementation

{ TUsuario }

constructor TUsuario.Create(ACollection: TCollection);
begin
  inherited;

end;

destructor TUsuario.Destroy;
begin

  inherited;
end;

{ TUsuarioList }

constructor TUsuarioList.Create(AOwner: TPersistentCollection);
begin
  inherited Create(TUsuario);
end;

function TUsuarioList.Add: TUsuario;
begin
  Result := TUsuario(inherited Add);
  Result.create;
end;

function TUsuarioList.GetItem(Index: Integer): TUsuario;
begin
  Result := TUsuario(inherited GetItem(Index));
end;

procedure TUsuarioList.SetItem(Index: Integer; Value: TUsuario);
begin
  inherited SetItem(Index, Value);
end;

end.