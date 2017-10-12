unit uGlbMunicipio;

interface

uses
  Classes, SysUtils,
  mCollection, mCollectionItem;

type
  TGlb_Municipio = class;
  TGlb_MunicipioClass = class of TGlb_Municipio;

  TGlb_MunicipioList = class;
  TGlb_MunicipioListClass = class of TGlb_MunicipioList;

  TGlb_Municipio = class(TmCollectionItem)
  private
    fCd_Municipio: String;
    fU_Version: String;
    fCd_Cep: String;
    fCd_Estado: String;
    fCd_Operador: String;
    fDt_Cadastro: String;
    fNm_Municipio: String;
    fDs_Sigla: String;
    fTp_Municipio: String;
  public
    constructor Create(ACollection: TCollection); override;
    destructor Destroy; override;
  published
    property Cd_Municipio : String read fCd_Municipio write SetCd_Municipio;
    property U_Version : String read fU_Version write SetU_Version;
    property Cd_Cep : String read fCd_Cep write SetCd_Cep;
    property Cd_Estado : String read fCd_Estado write SetCd_Estado;
    property Cd_Operador : String read fCd_Operador write SetCd_Operador;
    property Dt_Cadastro : String read fDt_Cadastro write SetDt_Cadastro;
    property Nm_Municipio : String read fNm_Municipio write SetNm_Municipio;
    property Ds_Sigla : String read fDs_Sigla write SetDs_Sigla;
    property Tp_Municipio : String read fTp_Municipio write SetTp_Municipio;
  end;

  TGlb_MunicipioList = class(TmCollection)
  private
    function GetItem(Index: Integer): TGlb_Municipio;
    procedure SetItem(Index: Integer; Value: TGlb_Municipio);
  public
    constructor Create(AOwner: TPersistentCollection);
    function Add: TGlb_Municipio;
    property Items[Index: Integer]: TGlb_Municipio read GetItem write SetItem; default;
  end;

implementation

{ TGlb_Municipio }

constructor TGlb_Municipio.Create(ACollection: TCollection);
begin
  inherited;

end;

destructor TGlb_Municipio.Destroy;
begin

  inherited;
end;

{ TGlb_MunicipioList }

constructor TGlb_MunicipioList.Create(AOwner: TPersistentCollection);
begin
  inherited Create(TGlb_Municipio);
end;

function TGlb_MunicipioList.Add: TGlb_Municipio;
begin
  Result := TGlb_Municipio(inherited Add);
  Result.create;
end;

function TGlb_MunicipioList.GetItem(Index: Integer): TGlb_Municipio;
begin
  Result := TGlb_Municipio(inherited GetItem(Index));
end;

procedure TGlb_MunicipioList.SetItem(Index: Integer; Value: TGlb_Municipio);
begin
  inherited SetItem(Index, Value);
end;

end.