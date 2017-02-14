unit uFisTipi;

interface

uses
  Classes, SysUtils,
  cCollection, cCollectionItem;

type
  TFis_Tipi = class;
  TFis_TipiClass = class of TFis_Tipi;

  TFis_TipiList = class;
  TFis_TipiListClass = class of TFis_TipiList;

  TFis_Tipi = class(TcCollectionItem)
  private
    fCd_Tipi: String;
    fU_Version: String;
    fPr_Ipi: Real;
    fCd_Operador: Real;
    fDt_Cadastro: TDateTime;
    fDs_Tipi: String;
    fDs_Legenda: String;
  public
    constructor Create; reintroduce;
    destructor Destroy; override;
  published
    property Cd_Tipi : String read fCd_Tipi write fCd_Tipi;
    property U_Version : String read fU_Version write fU_Version;
    property Pr_Ipi : Real read fPr_Ipi write fPr_Ipi;
    property Cd_Operador : Real read fCd_Operador write fCd_Operador;
    property Dt_Cadastro : TDateTime read fDt_Cadastro write fDt_Cadastro;
    property Ds_Tipi : String read fDs_Tipi write fDs_Tipi;
    property Ds_Legenda : String read fDs_Legenda write fDs_Legenda;
  end;

  TFis_TipiList = class(TcCollection)
  private
    function GetItem(Index: Integer): TFis_Tipi;
    procedure SetItem(Index: Integer; Value: TFis_Tipi);
  public
    constructor Create(AOwner: TPersistent);
    function Add: TFis_Tipi;
    property Items[Index: Integer]: TFis_Tipi read GetItem write SetItem; default;
  end;
  
implementation

{ TFis_Tipi }

constructor TFis_Tipi.Create;
begin

end;

destructor TFis_Tipi.Destroy;
begin

  inherited;
end;

{ TFis_TipiList }

constructor TFis_TipiList.Create(AOwner: TPersistent);
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