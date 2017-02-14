unit uFgrLiqitemcc;

interface

uses
  Classes, SysUtils,
  cCollection, cCollectionItem;

type
  TFgr_Liqitemcc = class;
  TFgr_LiqitemccClass = class of TFgr_Liqitemcc;

  TFgr_LiqitemccList = class;
  TFgr_LiqitemccListClass = class of TFgr_LiqitemccList;

  TFgr_Liqitemcc = class(TcCollectionItem)
  private
    fCd_Empliq: Real;
    fDt_Liq: TDateTime;
    fNr_Seqliq: Real;
    fNr_Seqitem: Real;
    fU_Version: String;
    fCd_Operador: Real;
    fDt_Cadastro: TDateTime;
    fTp_Subliq: Real;
    fCd_Fornecedor: Real;
    fVl_Pagamento: Real;
    fNr_Ctapes: Real;
    fCd_Empresadup: Real;
    fCd_Fornecdup: Real;
    fNr_Duplicatadup: Real;
    fNr_Parceladup: Real;
    fCd_Emptransacao: Real;
    fNr_Transacao: Real;
    fDt_Transacao: TDateTime;
    fNr_Dofni: Real;
  public
    constructor Create; reintroduce;
    destructor Destroy; override;
  published
    property Cd_Empliq : Real read fCd_Empliq write fCd_Empliq;
    property Dt_Liq : TDateTime read fDt_Liq write fDt_Liq;
    property Nr_Seqliq : Real read fNr_Seqliq write fNr_Seqliq;
    property Nr_Seqitem : Real read fNr_Seqitem write fNr_Seqitem;
    property U_Version : String read fU_Version write fU_Version;
    property Cd_Operador : Real read fCd_Operador write fCd_Operador;
    property Dt_Cadastro : TDateTime read fDt_Cadastro write fDt_Cadastro;
    property Tp_Subliq : Real read fTp_Subliq write fTp_Subliq;
    property Cd_Fornecedor : Real read fCd_Fornecedor write fCd_Fornecedor;
    property Vl_Pagamento : Real read fVl_Pagamento write fVl_Pagamento;
    property Nr_Ctapes : Real read fNr_Ctapes write fNr_Ctapes;
    property Cd_Empresadup : Real read fCd_Empresadup write fCd_Empresadup;
    property Cd_Fornecdup : Real read fCd_Fornecdup write fCd_Fornecdup;
    property Nr_Duplicatadup : Real read fNr_Duplicatadup write fNr_Duplicatadup;
    property Nr_Parceladup : Real read fNr_Parceladup write fNr_Parceladup;
    property Cd_Emptransacao : Real read fCd_Emptransacao write fCd_Emptransacao;
    property Nr_Transacao : Real read fNr_Transacao write fNr_Transacao;
    property Dt_Transacao : TDateTime read fDt_Transacao write fDt_Transacao;
    property Nr_Dofni : Real read fNr_Dofni write fNr_Dofni;
  end;

  TFgr_LiqitemccList = class(TcCollection)
  private
    function GetItem(Index: Integer): TFgr_Liqitemcc;
    procedure SetItem(Index: Integer; Value: TFgr_Liqitemcc);
  public
    constructor Create(AOwner: TPersistent);
    function Add: TFgr_Liqitemcc;
    property Items[Index: Integer]: TFgr_Liqitemcc read GetItem write SetItem; default;
  end;
  
implementation

{ TFgr_Liqitemcc }

constructor TFgr_Liqitemcc.Create;
begin

end;

destructor TFgr_Liqitemcc.Destroy;
begin

  inherited;
end;

{ TFgr_LiqitemccList }

constructor TFgr_LiqitemccList.Create(AOwner: TPersistent);
begin
  inherited Create(TFgr_Liqitemcc);
end;

function TFgr_LiqitemccList.Add: TFgr_Liqitemcc;
begin
  Result := TFgr_Liqitemcc(inherited Add);
  Result.create;
end;

function TFgr_LiqitemccList.GetItem(Index: Integer): TFgr_Liqitemcc;
begin
  Result := TFgr_Liqitemcc(inherited GetItem(Index));
end;

procedure TFgr_LiqitemccList.SetItem(Index: Integer; Value: TFgr_Liqitemcc);
begin
  inherited SetItem(Index, Value);
end;

end.