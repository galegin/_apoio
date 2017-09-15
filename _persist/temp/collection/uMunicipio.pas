unit uMunicipio;

interface

uses
  Classes, SysUtils,
  mCollection, mCollectionItem;

type
  TMunicipio = class;
  TMunicipioClass = class of TMunicipio;

  TMunicipioList = class;
  TMunicipioListClass = class of TMunicipioList;

  TMunicipio = class(TmCollectionItem)
  private
    fId_Municipio: Integer;
    fU_Version: String;
    fCd_Operador: Integer;
    fDt_Cadastro: String;
    fCd_Municipio: Integer;
    fDs_Municipio: String;
    fDs_Sigla: String;
    fId_Estado: Integer;
  public
    constructor Create(ACollection: TCollection); override;
    destructor Destroy; override;
  published
    property Id_Municipio : Integer read fId_Municipio write SetId_Municipio;
    property U_Version : String read fU_Version write SetU_Version;
    property Cd_Operador : Integer read fCd_Operador write SetCd_Operador;
    property Dt_Cadastro : String read fDt_Cadastro write SetDt_Cadastro;
    property Cd_Municipio : Integer read fCd_Municipio write SetCd_Municipio;
    property Ds_Municipio : String read fDs_Municipio write SetDs_Municipio;
    property Ds_Sigla : String read fDs_Sigla write SetDs_Sigla;
    property Id_Estado : Integer read fId_Estado write SetId_Estado;
  end;

  TMunicipioList = class(TmCollection)
  private
    function GetItem(Index: Integer): TMunicipio;
    procedure SetItem(Index: Integer; Value: TMunicipio);
  public
    constructor Create(AOwner: TPersistentCollection);
    function Add: TMunicipio;
    property Items[Index: Integer]: TMunicipio read GetItem write SetItem; default;
  end;

implementation

{ TMunicipio }

constructor TMunicipio.Create(ACollection: TCollection);
begin
  inherited;

end;

destructor TMunicipio.Destroy;
begin

  inherited;
end;

{ TMunicipioList }

constructor TMunicipioList.Create(AOwner: TPersistentCollection);
begin
  inherited Create(TMunicipio);
end;

function TMunicipioList.Add: TMunicipio;
begin
  Result := TMunicipio(inherited Add);
  Result.create;
end;

function TMunicipioList.GetItem(Index: Integer): TMunicipio;
begin
  Result := TMunicipio(inherited GetItem(Index));
end;

procedure TMunicipioList.SetItem(Index: Integer; Value: TMunicipio);
begin
  inherited SetItem(Index, Value);
end;

end.