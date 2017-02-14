unit uFgrLiqitemcr;

interface

uses
  Classes, SysUtils,
  cCollection, cCollectionItem;

type
  TFgr_Liqitemcr = class;
  TFgr_LiqitemcrClass = class of TFgr_Liqitemcr;

  TFgr_LiqitemcrList = class;
  TFgr_LiqitemcrListClass = class of TFgr_LiqitemcrList;

  TFgr_Liqitemcr = class(TcCollectionItem)
  private
    fCd_Empliq: Real;
    fDt_Liq: TDateTime;
    fNr_Seqliq: Real;
    fNr_Seqitem: Real;
    fU_Version: String;
    fCd_Operador: Real;
    fDt_Cadastro: TDateTime;
    fIn_Conferido: String;
    fTp_Tiporeg: Real;
    fNr_Ctapes: Real;
    fNr_Ctapescx: Real;
    fCd_Emptransacao: Real;
    fNr_Transacao: Real;
    fDt_Transacao: TDateTime;
    fCd_Empendosso: Real;
    fNr_Ano: Real;
    fNr_Endosso: Real;
    fCd_Empfat: Real;
    fCd_Cliente: Real;
    fNr_Fat: Real;
    fNr_Parcela: Real;
    fNr_Seqhistrelsub: Real;
    fTp_Documento: Real;
    fNr_Dofni: Real;
    fNr_Ctapesfcc: Real;
    fDt_Movimfcc: TDateTime;
    fNr_Seqmovfcc: Real;
    fVl_Lancamento: Real;
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
    property In_Conferido : String read fIn_Conferido write fIn_Conferido;
    property Tp_Tiporeg : Real read fTp_Tiporeg write fTp_Tiporeg;
    property Nr_Ctapes : Real read fNr_Ctapes write fNr_Ctapes;
    property Nr_Ctapescx : Real read fNr_Ctapescx write fNr_Ctapescx;
    property Cd_Emptransacao : Real read fCd_Emptransacao write fCd_Emptransacao;
    property Nr_Transacao : Real read fNr_Transacao write fNr_Transacao;
    property Dt_Transacao : TDateTime read fDt_Transacao write fDt_Transacao;
    property Cd_Empendosso : Real read fCd_Empendosso write fCd_Empendosso;
    property Nr_Ano : Real read fNr_Ano write fNr_Ano;
    property Nr_Endosso : Real read fNr_Endosso write fNr_Endosso;
    property Cd_Empfat : Real read fCd_Empfat write fCd_Empfat;
    property Cd_Cliente : Real read fCd_Cliente write fCd_Cliente;
    property Nr_Fat : Real read fNr_Fat write fNr_Fat;
    property Nr_Parcela : Real read fNr_Parcela write fNr_Parcela;
    property Nr_Seqhistrelsub : Real read fNr_Seqhistrelsub write fNr_Seqhistrelsub;
    property Tp_Documento : Real read fTp_Documento write fTp_Documento;
    property Nr_Dofni : Real read fNr_Dofni write fNr_Dofni;
    property Nr_Ctapesfcc : Real read fNr_Ctapesfcc write fNr_Ctapesfcc;
    property Dt_Movimfcc : TDateTime read fDt_Movimfcc write fDt_Movimfcc;
    property Nr_Seqmovfcc : Real read fNr_Seqmovfcc write fNr_Seqmovfcc;
    property Vl_Lancamento : Real read fVl_Lancamento write fVl_Lancamento;
  end;

  TFgr_LiqitemcrList = class(TcCollection)
  private
    function GetItem(Index: Integer): TFgr_Liqitemcr;
    procedure SetItem(Index: Integer; Value: TFgr_Liqitemcr);
  public
    constructor Create(AOwner: TPersistent);
    function Add: TFgr_Liqitemcr;
    property Items[Index: Integer]: TFgr_Liqitemcr read GetItem write SetItem; default;
  end;
  
implementation

{ TFgr_Liqitemcr }

constructor TFgr_Liqitemcr.Create;
begin

end;

destructor TFgr_Liqitemcr.Destroy;
begin

  inherited;
end;

{ TFgr_LiqitemcrList }

constructor TFgr_LiqitemcrList.Create(AOwner: TPersistent);
begin
  inherited Create(TFgr_Liqitemcr);
end;

function TFgr_LiqitemcrList.Add: TFgr_Liqitemcr;
begin
  Result := TFgr_Liqitemcr(inherited Add);
  Result.create;
end;

function TFgr_LiqitemcrList.GetItem(Index: Integer): TFgr_Liqitemcr;
begin
  Result := TFgr_Liqitemcr(inherited GetItem(Index));
end;

procedure TFgr_LiqitemcrList.SetItem(Index: Integer; Value: TFgr_Liqitemcr);
begin
  inherited SetItem(Index, Value);
end;

end.