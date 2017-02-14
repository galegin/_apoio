unit uFccCtasaldorel;

interface

uses
  Classes, SysUtils,
  cCollection, cCollectionItem;

type
  TFcc_Ctasaldorel = class;
  TFcc_CtasaldorelClass = class of TFcc_Ctasaldorel;

  TFcc_CtasaldorelList = class;
  TFcc_CtasaldorelListClass = class of TFcc_CtasaldorelList;

  TFcc_Ctasaldorel = class(TcCollectionItem)
  private
    fNr_Ctapes: Real;
    fTp_Documento: Real;
    fNr_Seqhistrelsub: Real;
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
    property Tp_Documento : Real read fTp_Documento write fTp_Documento;
    property Nr_Seqhistrelsub : Real read fNr_Seqhistrelsub write fNr_Seqhistrelsub;
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

  TFcc_CtasaldorelList = class(TcCollection)
  private
    function GetItem(Index: Integer): TFcc_Ctasaldorel;
    procedure SetItem(Index: Integer; Value: TFcc_Ctasaldorel);
  public
    constructor Create(AOwner: TPersistent);
    function Add: TFcc_Ctasaldorel;
    property Items[Index: Integer]: TFcc_Ctasaldorel read GetItem write SetItem; default;
  end;
  
implementation

{ TFcc_Ctasaldorel }

constructor TFcc_Ctasaldorel.Create;
begin

end;

destructor TFcc_Ctasaldorel.Destroy;
begin

  inherited;
end;

{ TFcc_CtasaldorelList }

constructor TFcc_CtasaldorelList.Create(AOwner: TPersistent);
begin
  inherited Create(TFcc_Ctasaldorel);
end;

function TFcc_CtasaldorelList.Add: TFcc_Ctasaldorel;
begin
  Result := TFcc_Ctasaldorel(inherited Add);
  Result.create;
end;

function TFcc_CtasaldorelList.GetItem(Index: Integer): TFcc_Ctasaldorel;
begin
  Result := TFcc_Ctasaldorel(inherited GetItem(Index));
end;

procedure TFcc_CtasaldorelList.SetItem(Index: Integer; Value: TFcc_Ctasaldorel);
begin
  inherited SetItem(Index, Value);
end;

end.