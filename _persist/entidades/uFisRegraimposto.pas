unit uFisRegraimposto;

interface

uses
  Classes, SysUtils,
  cCollection, cCollectionItem;

type
  TFis_Regraimposto = class;
  TFis_RegraimpostoClass = class of TFis_Regraimposto;

  TFis_RegraimpostoList = class;
  TFis_RegraimpostoListClass = class of TFis_RegraimpostoList;

  TFis_Regraimposto = class(TcCollectionItem)
  private
    fCd_Imposto: Real;
    fCd_Regrafiscal: Real;
    fU_Version: String;
    fCd_Operador: Real;
    fDt_Cadastro: TDateTime;
    fCd_Cst: String;
  public
    constructor Create; reintroduce;
    destructor Destroy; override;
  published
    property Cd_Imposto : Real read fCd_Imposto write fCd_Imposto;
    property Cd_Regrafiscal : Real read fCd_Regrafiscal write fCd_Regrafiscal;
    property U_Version : String read fU_Version write fU_Version;
    property Cd_Operador : Real read fCd_Operador write fCd_Operador;
    property Dt_Cadastro : TDateTime read fDt_Cadastro write fDt_Cadastro;
    property Cd_Cst : String read fCd_Cst write fCd_Cst;
  end;

  TFis_RegraimpostoList = class(TcCollection)
  private
    function GetItem(Index: Integer): TFis_Regraimposto;
    procedure SetItem(Index: Integer; Value: TFis_Regraimposto);
  public
    constructor Create(AOwner: TPersistent);
    function Add: TFis_Regraimposto;
    property Items[Index: Integer]: TFis_Regraimposto read GetItem write SetItem; default;
  end;
  
implementation

{ TFis_Regraimposto }

constructor TFis_Regraimposto.Create;
begin

end;

destructor TFis_Regraimposto.Destroy;
begin

  inherited;
end;

{ TFis_RegraimpostoList }

constructor TFis_RegraimpostoList.Create(AOwner: TPersistent);
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