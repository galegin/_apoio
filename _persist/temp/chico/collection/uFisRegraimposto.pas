unit uFisRegraimposto;

interface

uses
  Classes, SysUtils,
  mCollection, mCollectionItem;

type
  TFis_Regraimposto = class;
  TFis_RegraimpostoClass = class of TFis_Regraimposto;

  TFis_RegraimpostoList = class;
  TFis_RegraimpostoListClass = class of TFis_RegraimpostoList;

  TFis_Regraimposto = class(TmCollectionItem)
  private
    fCd_Imposto: String;
    fCd_Regrafiscal: String;
    fU_Version: String;
    fCd_Operador: String;
    fDt_Cadastro: String;
    fCd_Cst: String;
  public
    constructor Create(ACollection: TCollection); override;
    destructor Destroy; override;
  published
    property Cd_Imposto : String read fCd_Imposto write SetCd_Imposto;
    property Cd_Regrafiscal : String read fCd_Regrafiscal write SetCd_Regrafiscal;
    property U_Version : String read fU_Version write SetU_Version;
    property Cd_Operador : String read fCd_Operador write SetCd_Operador;
    property Dt_Cadastro : String read fDt_Cadastro write SetDt_Cadastro;
    property Cd_Cst : String read fCd_Cst write SetCd_Cst;
  end;

  TFis_RegraimpostoList = class(TmCollection)
  private
    function GetItem(Index: Integer): TFis_Regraimposto;
    procedure SetItem(Index: Integer; Value: TFis_Regraimposto);
  public
    constructor Create(AOwner: TPersistentCollection);
    function Add: TFis_Regraimposto;
    property Items[Index: Integer]: TFis_Regraimposto read GetItem write SetItem; default;
  end;

implementation

{ TFis_Regraimposto }

constructor TFis_Regraimposto.Create(ACollection: TCollection);
begin
  inherited;

end;

destructor TFis_Regraimposto.Destroy;
begin

  inherited;
end;

{ TFis_RegraimpostoList }

constructor TFis_RegraimpostoList.Create(AOwner: TPersistentCollection);
begin
  inherited Create(TFis_Regraimposto);
end;

function TFis_RegraimpostoList.Add: TFis_Regraimposto;
begin
  Result := TFis_Regraimposto(inherited Add);
  Result.create;
end;

function TFis_RegraimpostoList.GetItem(Index: Integer): TFis_Regraimposto;
begin
  Result := TFis_Regraimposto(inherited GetItem(Index));
end;

procedure TFis_RegraimpostoList.SetItem(Index: Integer; Value: TFis_Regraimposto);
begin
  inherited SetItem(Index, Value);
end;

end.