unit uFisTipi;

interface

uses
  Classes, SysUtils,
  mCollection, mCollectionItem;

type
  TFis_Tipi = class;
  TFis_TipiClass = class of TFis_Tipi;

  TFis_TipiList = class;
  TFis_TipiListClass = class of TFis_TipiList;

  TFis_Tipi = class(TmCollectionItem)
  private
    fCd_Tipi: String;
    fU_Version: String;
    fPr_Ipi: String;
    fCd_Operador: String;
    fDt_Cadastro: String;
    fDs_Tipi: String;
    fDs_Legenda: String;
  public
    constructor Create(ACollection: TCollection); override;
    destructor Destroy; override;
  published
    property Cd_Tipi : String read fCd_Tipi write SetCd_Tipi;
    property U_Version : String read fU_Version write SetU_Version;
    property Pr_Ipi : String read fPr_Ipi write SetPr_Ipi;
    property Cd_Operador : String read fCd_Operador write SetCd_Operador;
    property Dt_Cadastro : String read fDt_Cadastro write SetDt_Cadastro;
    property Ds_Tipi : String read fDs_Tipi write SetDs_Tipi;
    property Ds_Legenda : String read fDs_Legenda write SetDs_Legenda;
  end;

  TFis_TipiList = class(TmCollection)
  private
    function GetItem(Index: Integer): TFis_Tipi;
    procedure SetItem(Index: Integer; Value: TFis_Tipi);
  public
    constructor Create(AOwner: TPersistentCollection);
    function Add: TFis_Tipi;
    property Items[Index: Integer]: TFis_Tipi read GetItem write SetItem; default;
  end;

implementation

{ TFis_Tipi }

constructor TFis_Tipi.Create(ACollection: TCollection);
begin
  inherited;

end;

destructor TFis_Tipi.Destroy;
begin

  inherited;
end;

{ TFis_TipiList }

constructor TFis_TipiList.Create(AOwner: TPersistentCollection);
begin
  inherited Create(TFis_Tipi);
end;

function TFis_TipiList.Add: TFis_Tipi;
begin
  Result := TFis_Tipi(inherited Add);
  Result.create;
end;

function TFis_TipiList.GetItem(Index: Integer): TFis_Tipi;
begin
  Result := TFis_Tipi(inherited GetItem(Index));
end;

procedure TFis_TipiList.SetItem(Index: Integer; Value: TFis_Tipi);
begin
  inherited SetItem(Index, Value);
end;

end.