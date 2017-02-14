unit uFcrFaturac;

interface

uses
  Classes, SysUtils,
  cCollection, cCollectionItem;

type
  TFcr_Faturac = class;
  TFcr_FaturacClass = class of TFcr_Faturac;

  TFcr_FaturacList = class;
  TFcr_FaturacListClass = class of TFcr_FaturacList;

  TFcr_Faturac = class(TcCollectionItem)
  private
    fCd_Empresa: Real;
    fCd_Cliente: Real;
    fNr_Fat: Real;
    fU_Version: String;
    fCd_Operador: Real;
    fDt_Cadastro: TDateTime;
    fCd_Condpagto: Real;
    fVl_Total: Real;
    fVl_Saldo: Real;
  public
    constructor Create; reintroduce;
    destructor Destroy; override;
  published
    property Cd_Empresa : Real read fCd_Empresa write fCd_Empresa;
    property Cd_Cliente : Real read fCd_Cliente write fCd_Cliente;
    property Nr_Fat : Real read fNr_Fat write fNr_Fat;
    property U_Version : String read fU_Version write fU_Version;
    property Cd_Operador : Real read fCd_Operador write fCd_Operador;
    property Dt_Cadastro : TDateTime read fDt_Cadastro write fDt_Cadastro;
    property Cd_Condpagto : Real read fCd_Condpagto write fCd_Condpagto;
    property Vl_Total : Real read fVl_Total write fVl_Total;
    property Vl_Saldo : Real read fVl_Saldo write fVl_Saldo;
  end;

  TFcr_FaturacList = class(TcCollection)
  private
    function GetItem(Index: Integer): TFcr_Faturac;
    procedure SetItem(Index: Integer; Value: TFcr_Faturac);
  public
    constructor Create(AOwner: TPersistent);
    function Add: TFcr_Faturac;
    property Items[Index: Integer]: TFcr_Faturac read GetItem write SetItem; default;
  end;
  
implementation

{ TFcr_Faturac }

constructor TFcr_Faturac.Create;
begin

end;

destructor TFcr_Faturac.Destroy;
begin

  inherited;
end;

{ TFcr_FaturacList }

constructor TFcr_FaturacList.Create(AOwner: TPersistent);
begin
  inherited Create(TFcr_Faturac);
end;

function TFcr_FaturacList.Add: TFcr_Faturac;
begin
  Result := TFcr_Faturac(inherited Add);
  Result.create;
end;

function TFcr_FaturacList.GetItem(Index: Integer): TFcr_Faturac;
begin
  Result := TFcr_Faturac(inherited GetItem(Index));
end;

procedure TFcr_FaturacList.SetItem(Index: Integer; Value: TFcr_Faturac);
begin
  inherited SetItem(Index, Value);
end;

end.