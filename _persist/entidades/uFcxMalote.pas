unit uFcxMalote;

interface

uses
  Classes, SysUtils,
  cCollection, cCollectionItem;

type
  TFcx_Malote = class;
  TFcx_MaloteClass = class of TFcx_Malote;

  TFcx_MaloteList = class;
  TFcx_MaloteListClass = class of TFcx_MaloteList;

  TFcx_Malote = class(TcCollectionItem)
  private
    fCd_Grupoempresa: Real;
    fDt_Malote: TDateTime;
    fNr_Seqmalote: Real;
    fU_Version: String;
    fCd_Operador: Real;
    fDt_Cadastro: TDateTime;
    fCd_Opermalote: Real;
    fIn_Aberto: String;
    fDt_Conferencia: TDateTime;
    fCd_Operconf: Real;
    fDs_Malote: String;
  public
    constructor Create; reintroduce;
    destructor Destroy; override;
  published
    property Cd_Grupoempresa : Real read fCd_Grupoempresa write fCd_Grupoempresa;
    property Dt_Malote : TDateTime read fDt_Malote write fDt_Malote;
    property Nr_Seqmalote : Real read fNr_Seqmalote write fNr_Seqmalote;
    property U_Version : String read fU_Version write fU_Version;
    property Cd_Operador : Real read fCd_Operador write fCd_Operador;
    property Dt_Cadastro : TDateTime read fDt_Cadastro write fDt_Cadastro;
    property Cd_Opermalote : Real read fCd_Opermalote write fCd_Opermalote;
    property In_Aberto : String read fIn_Aberto write fIn_Aberto;
    property Dt_Conferencia : TDateTime read fDt_Conferencia write fDt_Conferencia;
    property Cd_Operconf : Real read fCd_Operconf write fCd_Operconf;
    property Ds_Malote : String read fDs_Malote write fDs_Malote;
  end;

  TFcx_MaloteList = class(TcCollection)
  private
    function GetItem(Index: Integer): TFcx_Malote;
    procedure SetItem(Index: Integer; Value: TFcx_Malote);
  public
    constructor Create(AOwner: TPersistent);
    function Add: TFcx_Malote;
    property Items[Index: Integer]: TFcx_Malote read GetItem write SetItem; default;
  end;
  
implementation

{ TFcx_Malote }

constructor TFcx_Malote.Create;
begin

end;

destructor TFcx_Malote.Destroy;
begin

  inherited;
end;

{ TFcx_MaloteList }

constructor TFcx_MaloteList.Create(AOwner: TPersistent);
begin
  inherited Create(TFcx_Malote);
end;

function TFcx_MaloteList.Add: TFcx_Malote;
begin
  Result := TFcx_Malote(inherited Add);
  Result.create;
end;

function TFcx_MaloteList.GetItem(Index: Integer): TFcx_Malote;
begin
  Result := TFcx_Malote(inherited GetItem(Index));
end;

procedure TFcx_MaloteList.SetItem(Index: Integer; Value: TFcx_Malote);
begin
  inherited SetItem(Index, Value);
end;

end.