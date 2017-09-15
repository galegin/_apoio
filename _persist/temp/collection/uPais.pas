unit uPais;

interface

uses
  Classes, SysUtils,
  mCollection, mCollectionItem;

type
  TPais = class;
  TPaisClass = class of TPais;

  TPaisList = class;
  TPaisListClass = class of TPaisList;

  TPais = class(TmCollectionItem)
  private
    fId_Pais: Integer;
    fU_Version: String;
    fCd_Operador: Integer;
    fDt_Cadastro: String;
    fCd_Pais: Integer;
    fDs_Pais: String;
    fDs_Sigla: String;
  public
    constructor Create(ACollection: TCollection); override;
    destructor Destroy; override;
  published
    property Id_Pais : Integer read fId_Pais write SetId_Pais;
    property U_Version : String read fU_Version write SetU_Version;
    property Cd_Operador : Integer read fCd_Operador write SetCd_Operador;
    property Dt_Cadastro : String read fDt_Cadastro write SetDt_Cadastro;
    property Cd_Pais : Integer read fCd_Pais write SetCd_Pais;
    property Ds_Pais : String read fDs_Pais write SetDs_Pais;
    property Ds_Sigla : String read fDs_Sigla write SetDs_Sigla;
  end;

  TPaisList = class(TmCollection)
  private
    function GetItem(Index: Integer): TPais;
    procedure SetItem(Index: Integer; Value: TPais);
  public
    constructor Create(AOwner: TPersistentCollection);
    function Add: TPais;
    property Items[Index: Integer]: TPais read GetItem write SetItem; default;
  end;

implementation

{ TPais }

constructor TPais.Create(ACollection: TCollection);
begin
  inherited;

end;

destructor TPais.Destroy;
begin

  inherited;
end;

{ TPaisList }

constructor TPaisList.Create(AOwner: TPersistentCollection);
begin
  inherited Create(TPais);
end;

function TPaisList.Add: TPais;
begin
  Result := TPais(inherited Add);
  Result.create;
end;

function TPaisList.GetItem(Index: Integer): TPais;
begin
  Result := TPais(inherited GetItem(Index));
end;

procedure TPaisList.SetItem(Index: Integer; Value: TPais);
begin
  inherited SetItem(Index, Value);
end;

end.