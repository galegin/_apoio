unit uFcxMaloteenvio;

interface

uses
  Classes, SysUtils,
  cCollection, cCollectionItem;

type
  TFcx_Maloteenvio = class;
  TFcx_MaloteenvioClass = class of TFcx_Maloteenvio;

  TFcx_MaloteenvioList = class;
  TFcx_MaloteenvioListClass = class of TFcx_MaloteenvioList;

  TFcx_Maloteenvio = class(TcCollectionItem)
  private
    fCd_Grupoempresa: Real;
    fNr_Ctapes: Real;
    fDt_Movimento: TDateTime;
    fTp_Documento: Real;
    fNr_Seqhistrelsub: Real;
    fNr_Seqmalote: Real;
    fU_Version: String;
    fCd_Operador: Real;
    fDt_Cadastro: TDateTime;
    fVl_Saldo: Real;
    fVl_Envio: Real;
  public
    constructor Create; reintroduce;
    destructor Destroy; override;
  published
    property Cd_Grupoempresa : Real read fCd_Grupoempresa write fCd_Grupoempresa;
    property Nr_Ctapes : Real read fNr_Ctapes write fNr_Ctapes;
    property Dt_Movimento : TDateTime read fDt_Movimento write fDt_Movimento;
    property Tp_Documento : Real read fTp_Documento write fTp_Documento;
    property Nr_Seqhistrelsub : Real read fNr_Seqhistrelsub write fNr_Seqhistrelsub;
    property Nr_Seqmalote : Real read fNr_Seqmalote write fNr_Seqmalote;
    property U_Version : String read fU_Version write fU_Version;
    property Cd_Operador : Real read fCd_Operador write fCd_Operador;
    property Dt_Cadastro : TDateTime read fDt_Cadastro write fDt_Cadastro;
    property Vl_Saldo : Real read fVl_Saldo write fVl_Saldo;
    property Vl_Envio : Real read fVl_Envio write fVl_Envio;
  end;

  TFcx_MaloteenvioList = class(TcCollection)
  private
    function GetItem(Index: Integer): TFcx_Maloteenvio;
    procedure SetItem(Index: Integer; Value: TFcx_Maloteenvio);
  public
    constructor Create(AOwner: TPersistent);
    function Add: TFcx_Maloteenvio;
    property Items[Index: Integer]: TFcx_Maloteenvio read GetItem write SetItem; default;
  end;
  
implementation

{ TFcx_Maloteenvio }

constructor TFcx_Maloteenvio.Create;
begin

end;

destructor TFcx_Maloteenvio.Destroy;
begin

  inherited;
end;

{ TFcx_MaloteenvioList }

constructor TFcx_MaloteenvioList.Create(AOwner: TPersistent);
begin
  inherited Create(TFcx_Maloteenvio);
end;

function TFcx_MaloteenvioList.Add: TFcx_Maloteenvio;
begin
  Result := TFcx_Maloteenvio(inherited Add);
  Result.create;
end;

function TFcx_MaloteenvioList.GetItem(Index: Integer): TFcx_Maloteenvio;
begin
  Result := TFcx_Maloteenvio(inherited GetItem(Index));
end;

procedure TFcx_MaloteenvioList.SetItem(Index: Integer; Value: TFcx_Maloteenvio);
begin
  inherited SetItem(Index, Value);
end;

end.