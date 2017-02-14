unit uAdmUsuaces;

interface

uses
  Classes, SysUtils,
  cCollection, cCollectionItem;

type
  TAdm_Usuaces = class;
  TAdm_UsuacesClass = class of TAdm_Usuaces;

  TAdm_UsuacesList = class;
  TAdm_UsuacesListClass = class of TAdm_UsuacesList;

  TAdm_Usuaces = class(TcCollectionItem)
  private
    fCd_Usuario: Real;
    fU_Version: String;
    fCd_Operador: Real;
    fDt_Cadastro: TDateTime;
    fQt_Acessos: Real;
    fNm_Login20: String;
  public
    constructor Create; reintroduce;
    destructor Destroy; override;
  published
    property Cd_Usuario : Real read fCd_Usuario write fCd_Usuario;
    property U_Version : String read fU_Version write fU_Version;
    property Cd_Operador : Real read fCd_Operador write fCd_Operador;
    property Dt_Cadastro : TDateTime read fDt_Cadastro write fDt_Cadastro;
    property Qt_Acessos : Real read fQt_Acessos write fQt_Acessos;
    property Nm_Login20 : String read fNm_Login20 write fNm_Login20;
  end;

  TAdm_UsuacesList = class(TcCollection)
  private
    function GetItem(Index: Integer): TAdm_Usuaces;
    procedure SetItem(Index: Integer; Value: TAdm_Usuaces);
  public
    constructor Create(AOwner: TPersistent);
    function Add: TAdm_Usuaces;
    property Items[Index: Integer]: TAdm_Usuaces read GetItem write SetItem; default;
  end;
  
implementation

{ TAdm_Usuaces }

constructor TAdm_Usuaces.Create;
begin

end;

destructor TAdm_Usuaces.Destroy;
begin

  inherited;
end;

{ TAdm_UsuacesList }

constructor TAdm_UsuacesList.Create(AOwner: TPersistent);
begin
  inherited Create(TAdm_Usuaces);
end;

function TAdm_UsuacesList.Add: TAdm_Usuaces;
begin
  Result := TAdm_Usuaces(inherited Add);
  Result.create;
end;

function TAdm_UsuacesList.GetItem(Index: Integer): TAdm_Usuaces;
begin
  Result := TAdm_Usuaces(inherited GetItem(Index));
end;

procedure TAdm_UsuacesList.SetItem(Index: Integer; Value: TAdm_Usuaces);
begin
  inherited SetItem(Index, Value);
end;

end.