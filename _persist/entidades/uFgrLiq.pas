unit uFgrLiq;

interface

uses
  Classes, SysUtils,
  cCollection, cCollectionItem;

type
  TFgr_Liq = class;
  TFgr_LiqClass = class of TFgr_Liq;

  TFgr_LiqList = class;
  TFgr_LiqListClass = class of TFgr_LiqList;

  TFgr_Liq = class(TcCollectionItem)
  private
    fCd_Empliq: Real;
    fDt_Liq: TDateTime;
    fNr_Seqliq: Real;
    fU_Version: String;
    fCd_Operador: Real;
    fDt_Cadastro: TDateTime;
    fCd_Grupoempresa: Real;
    fVl_Total: Real;
    fTp_Liquidacao: Real;
    fDt_Cancelamento: TDateTime;
    fCd_Opercancel: Real;
    fCd_Pessoa: Real;
  public
    constructor Create; reintroduce;
    destructor Destroy; override;
  published
    property Cd_Empliq : Real read fCd_Empliq write fCd_Empliq;
    property Dt_Liq : TDateTime read fDt_Liq write fDt_Liq;
    property Nr_Seqliq : Real read fNr_Seqliq write fNr_Seqliq;
    property U_Version : String read fU_Version write fU_Version;
    property Cd_Operador : Real read fCd_Operador write fCd_Operador;
    property Dt_Cadastro : TDateTime read fDt_Cadastro write fDt_Cadastro;
    property Cd_Grupoempresa : Real read fCd_Grupoempresa write fCd_Grupoempresa;
    property Vl_Total : Real read fVl_Total write fVl_Total;
    property Tp_Liquidacao : Real read fTp_Liquidacao write fTp_Liquidacao;
    property Dt_Cancelamento : TDateTime read fDt_Cancelamento write fDt_Cancelamento;
    property Cd_Opercancel : Real read fCd_Opercancel write fCd_Opercancel;
    property Cd_Pessoa : Real read fCd_Pessoa write fCd_Pessoa;
  end;

  TFgr_LiqList = class(TcCollection)
  private
    function GetItem(Index: Integer): TFgr_Liq;
    procedure SetItem(Index: Integer; Value: TFgr_Liq);
  public
    constructor Create(AOwner: TPersistent);
    function Add: TFgr_Liq;
    property Items[Index: Integer]: TFgr_Liq read GetItem write SetItem; default;
  end;
  
implementation

{ TFgr_Liq }

constructor TFgr_Liq.Create;
begin

end;

destructor TFgr_Liq.Destroy;
begin

  inherited;
end;

{ TFgr_LiqList }

constructor TFgr_LiqList.Create(AOwner: TPersistent);
begin
  inherited Create(TFgr_Liq);
end;

function TFgr_LiqList.Add: TFgr_Liq;
begin
  Result := TFgr_Liq(inherited Add);
  Result.create;
end;

function TFgr_LiqList.GetItem(Index: Integer): TFgr_Liq;
begin
  Result := TFgr_Liq(inherited GetItem(Index));
end;

procedure TFgr_LiqList.SetItem(Index: Integer; Value: TFgr_Liq);
begin
  inherited SetItem(Index, Value);
end;

end.