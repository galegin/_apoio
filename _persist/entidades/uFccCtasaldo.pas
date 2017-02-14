unit uFccCtasaldo;

interface

uses
  Classes, SysUtils,
  cCollection, cCollectionItem;

type
  TFcc_Ctasaldo = class;
  TFcc_CtasaldoClass = class of TFcc_Ctasaldo;

  TFcc_CtasaldoList = class;
  TFcc_CtasaldoListClass = class of TFcc_CtasaldoList;

  TFcc_Ctasaldo = class(TcCollectionItem)
  private
    fNr_Ctapes: Real;
    fDt_Movim: TDateTime;
    fU_Version: String;
    fCd_Operador: Real;
    fDt_Cadastro: TDateTime;
    fIn_Inicial: String;
    fVl_Saldo: Real;
    fVl_Saldoconci: Real;
    fVl_Creditos: Real;
    fVl_Debitos: Real;
  public
    constructor Create; reintroduce;
    destructor Destroy; override;
  published
    property Nr_Ctapes : Real read fNr_Ctapes write fNr_Ctapes;
    property Dt_Movim : TDateTime read fDt_Movim write fDt_Movim;
    property U_Version : String read fU_Version write fU_Version;
    property Cd_Operador : Real read fCd_Operador write fCd_Operador;
    property Dt_Cadastro : TDateTime read fDt_Cadastro write fDt_Cadastro;
    property In_Inicial : String read fIn_Inicial write fIn_Inicial;
    property Vl_Saldo : Real read fVl_Saldo write fVl_Saldo;
    property Vl_Saldoconci : Real read fVl_Saldoconci write fVl_Saldoconci;
    property Vl_Creditos : Real read fVl_Creditos write fVl_Creditos;
    property Vl_Debitos : Real read fVl_Debitos write fVl_Debitos;
  end;

  TFcc_CtasaldoList = class(TcCollection)
  private
    function GetItem(Index: Integer): TFcc_Ctasaldo;
    procedure SetItem(Index: Integer; Value: TFcc_Ctasaldo);
  public
    constructor Create(AOwner: TPersistent);
    function Add: TFcc_Ctasaldo;
    property Items[Index: Integer]: TFcc_Ctasaldo read GetItem write SetItem; default;
  end;
  
implementation

{ TFcc_Ctasaldo }

constructor TFcc_Ctasaldo.Create;
begin

end;

destructor TFcc_Ctasaldo.Destroy;
begin

  inherited;
end;

{ TFcc_CtasaldoList }

constructor TFcc_CtasaldoList.Create(AOwner: TPersistent);
begin
  inherited Create(TFcc_Ctasaldo);
end;

function TFcc_CtasaldoList.Add: TFcc_Ctasaldo;
begin
  Result := TFcc_Ctasaldo(inherited Add);
  Result.create;
end;

function TFcc_CtasaldoList.GetItem(Index: Integer): TFcc_Ctasaldo;
begin
  Result := TFcc_Ctasaldo(inherited GetItem(Index));
end;

procedure TFcc_CtasaldoList.SetItem(Index: Integer; Value: TFcc_Ctasaldo);
begin
  inherited SetItem(Index, Value);
end;

end.