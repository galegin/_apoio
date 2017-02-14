unit uGlbMunicipio;

interface

uses
  Classes, SysUtils,
  cCollection, cCollectionItem;

type
  TGlb_Municipio = class;
  TGlb_MunicipioClass = class of TGlb_Municipio;

  TGlb_MunicipioList = class;
  TGlb_MunicipioListClass = class of TGlb_MunicipioList;

  TGlb_Municipio = class(TcCollectionItem)
  private
    fCd_Municipio: Real;
    fU_Version: String;
    fCd_Cep: String;
    fCd_Estado: Real;
    fCd_Operador: Real;
    fDt_Cadastro: TDateTime;
    fNm_Municipio: String;
    fDs_Sigla: String;
    fTp_Municipio: String;
  public
    constructor Create; reintroduce;
    destructor Destroy; override;
  published
    property Cd_Municipio : Real read fCd_Municipio write fCd_Municipio;
    property U_Version : String read fU_Version write fU_Version;
    property Cd_Cep : String read fCd_Cep write fCd_Cep;
    property Cd_Estado : Real read fCd_Estado write fCd_Estado;
    property Cd_Operador : Real read fCd_Operador write fCd_Operador;
    property Dt_Cadastro : TDateTime read fDt_Cadastro write fDt_Cadastro;
    property Nm_Municipio : String read fNm_Municipio write fNm_Municipio;
    property Ds_Sigla : String read fDs_Sigla write fDs_Sigla;
    property Tp_Municipio : String read fTp_Municipio write fTp_Municipio;
  end;

  TGlb_MunicipioList = class(TcCollection)
  private
    function GetItem(Index: Integer): TGlb_Municipio;
    procedure SetItem(Index: Integer; Value: TGlb_Municipio);
  public
    constructor Create(AOwner: TPersistent);
    function Add: TGlb_Municipio;
    property Items[Index: Integer]: TGlb_Municipio read GetItem write SetItem; default;
  end;
  
implementation

{ TGlb_Municipio }

constructor TGlb_Municipio.Create;
begin

end;

destructor TGlb_Municipio.Destroy;
begin

  inherited;
end;

{ TGlb_MunicipioList }

constructor TGlb_MunicipioList.Create(AOwner: TPersistent);
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