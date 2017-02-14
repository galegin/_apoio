unit uFgrLiqitemcp;

interface

uses
  Classes, SysUtils,
  cCollection, cCollectionItem;

type
  TFgr_Liqitemcp = class;
  TFgr_LiqitemcpClass = class of TFgr_Liqitemcp;

  TFgr_LiqitemcpList = class;
  TFgr_LiqitemcpListClass = class of TFgr_LiqitemcpList;

  TFgr_Liqitemcp = class(TcCollectionItem)
  private
    fCd_Empliq: Real;
    fDt_Liq: TDateTime;
    fNr_Seqliq: Real;
    fNr_Seqitem: Real;
    fU_Version: String;
    fCd_Operador: Real;
    fDt_Cadastro: TDateTime;
    fTp_Liqitemcp: Real;
    fVl_Pago: Real;
    fNr_Ctapes: Real;
    fCd_Empendosso: Real;
    fNr_Ano: Real;
    fNr_Endosso: Real;
    fNr_Seqfor: Real;
    fDt_Autorizacao: TDateTime;
    fNr_Seqauto: Real;
    fNr_Seqcheque: Real;
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
    property Tp_Liqitemcp : Real read fTp_Liqitemcp write fTp_Liqitemcp;
    property Vl_Pago : Real read fVl_Pago write fVl_Pago;
    property Nr_Ctapes : Real read fNr_Ctapes write fNr_Ctapes;
    property Cd_Empendosso : Real read fCd_Empendosso write fCd_Empendosso;
    property Nr_Ano : Real read fNr_Ano write fNr_Ano;
    property Nr_Endosso : Real read fNr_Endosso write fNr_Endosso;
    property Nr_Seqfor : Real read fNr_Seqfor write fNr_Seqfor;
    property Dt_Autorizacao : TDateTime read fDt_Autorizacao write fDt_Autorizacao;
    property Nr_Seqauto : Real read fNr_Seqauto write fNr_Seqauto;
    property Nr_Seqcheque : Real read fNr_Seqcheque write fNr_Seqcheque;
  end;

  TFgr_LiqitemcpList = class(TcCollection)
  private
    function GetItem(Index: Integer): TFgr_Liqitemcp;
    procedure SetItem(Index: Integer; Value: TFgr_Liqitemcp);
  public
    constructor Create(AOwner: TPersistent);
    function Add: TFgr_Liqitemcp;
    property Items[Index: Integer]: TFgr_Liqitemcp read GetItem write SetItem; default;
  end;
  
implementation

{ TFgr_Liqitemcp }

constructor TFgr_Liqitemcp.Create;
begin

end;

destructor TFgr_Liqitemcp.Destroy;
begin

  inherited;
end;

{ TFgr_LiqitemcpList }

constructor TFgr_LiqitemcpList.Create(AOwner: TPersistent);
begin
  inherited Create(TFgr_Liqitemcp);
end;

function TFgr_LiqitemcpList.Add: TFgr_Liqitemcp;
begin
  Result := TFgr_Liqitemcp(inherited Add);
  Result.create;
end;

function TFgr_LiqitemcpList.GetItem(Index: Integer): TFgr_Liqitemcp;
begin
  Result := TFgr_Liqitemcp(inherited GetItem(Index));
end;

procedure TFgr_LiqitemcpList.SetItem(Index: Integer; Value: TFgr_Liqitemcp);
begin
  inherited SetItem(Index, Value);
end;

end.