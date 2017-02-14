unit uFcxSobracx;

interface

uses
  Classes, SysUtils,
  cCollection, cCollectionItem;

type
  TFcx_Sobracx = class;
  TFcx_SobracxClass = class of TFcx_Sobracx;

  TFcx_SobracxList = class;
  TFcx_SobracxListClass = class of TFcx_SobracxList;

  TFcx_Sobracx = class(TcCollectionItem)
  private
    fCd_Empresa: Real;
    fCd_Terminal: Real;
    fDt_Abertura: TDateTime;
    fNr_Seq: Real;
    fTp_Documento: Real;
    fNr_Seqhistrelsub: Real;
    fU_Version: String;
    fCd_Operador: Real;
    fDt_Cadastro: TDateTime;
    fVl_Sobracx: Real;
    fTp_Sobracx: String;
    fNr_Ctapes: Real;
    fDt_Movim: TDateTime;
    fNr_Seqmov: Real;
    fCd_Grupoempresa: Real;
    fDt_Malote: TDateTime;
    fNr_Seqmalote: Real;
  public
    constructor Create; reintroduce;
    destructor Destroy; override;
  published
    property Cd_Empresa : Real read fCd_Empresa write fCd_Empresa;
    property Cd_Terminal : Real read fCd_Terminal write fCd_Terminal;
    property Dt_Abertura : TDateTime read fDt_Abertura write fDt_Abertura;
    property Nr_Seq : Real read fNr_Seq write fNr_Seq;
    property Tp_Documento : Real read fTp_Documento write fTp_Documento;
    property Nr_Seqhistrelsub : Real read fNr_Seqhistrelsub write fNr_Seqhistrelsub;
    property U_Version : String read fU_Version write fU_Version;
    property Cd_Operador : Real read fCd_Operador write fCd_Operador;
    property Dt_Cadastro : TDateTime read fDt_Cadastro write fDt_Cadastro;
    property Vl_Sobracx : Real read fVl_Sobracx write fVl_Sobracx;
    property Tp_Sobracx : String read fTp_Sobracx write fTp_Sobracx;
    property Nr_Ctapes : Real read fNr_Ctapes write fNr_Ctapes;
    property Dt_Movim : TDateTime read fDt_Movim write fDt_Movim;
    property Nr_Seqmov : Real read fNr_Seqmov write fNr_Seqmov;
    property Cd_Grupoempresa : Real read fCd_Grupoempresa write fCd_Grupoempresa;
    property Dt_Malote : TDateTime read fDt_Malote write fDt_Malote;
    property Nr_Seqmalote : Real read fNr_Seqmalote write fNr_Seqmalote;
  end;

  TFcx_SobracxList = class(TcCollection)
  private
    function GetItem(Index: Integer): TFcx_Sobracx;
    procedure SetItem(Index: Integer; Value: TFcx_Sobracx);
  public
    constructor Create(AOwner: TPersistent);
    function Add: TFcx_Sobracx;
    property Items[Index: Integer]: TFcx_Sobracx read GetItem write SetItem; default;
  end;
  
implementation

{ TFcx_Sobracx }

constructor TFcx_Sobracx.Create;
begin

end;

destructor TFcx_Sobracx.Destroy;
begin

  inherited;
end;

{ TFcx_SobracxList }

constructor TFcx_SobracxList.Create(AOwner: TPersistent);
begin
  inherited Create(TFcx_Sobracx);
end;

function TFcx_SobracxList.Add: TFcx_Sobracx;
begin
  Result := TFcx_Sobracx(inherited Add);
  Result.create;
end;

function TFcx_SobracxList.GetItem(Index: Integer): TFcx_Sobracx;
begin
  Result := TFcx_Sobracx(inherited GetItem(Index));
end;

procedure TFcx_SobracxList.SetItem(Index: Integer; Value: TFcx_Sobracx);
begin
  inherited SetItem(Index, Value);
end;

end.