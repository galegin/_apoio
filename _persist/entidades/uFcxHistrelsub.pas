unit uFcxHistrelsub;

interface

uses
  Classes, SysUtils,
  cCollection, cCollectionItem;

type
  TFcx_Histrelsub = class;
  TFcx_HistrelsubClass = class of TFcx_Histrelsub;

  TFcx_HistrelsubList = class;
  TFcx_HistrelsubListClass = class of TFcx_HistrelsubList;

  TFcx_Histrelsub = class(TcCollectionItem)
  private
    fTp_Documento: Real;
    fNr_Seqhistrelsub: Real;
    fU_Version: String;
    fCd_Operador: Real;
    fDt_Cadastro: TDateTime;
    fNr_Parcelas: Real;
    fCd_Historico: Real;
    fCd_Histfec: Real;
    fNr_Portador: Real;
    fVl_Aux: Real;
    fDs_Histrelsub: String;
    fCd_Formulacartao: Real;
  public
    constructor Create; reintroduce;
    destructor Destroy; override;
  published
    property Tp_Documento : Real read fTp_Documento write fTp_Documento;
    property Nr_Seqhistrelsub : Real read fNr_Seqhistrelsub write fNr_Seqhistrelsub;
    property U_Version : String read fU_Version write fU_Version;
    property Cd_Operador : Real read fCd_Operador write fCd_Operador;
    property Dt_Cadastro : TDateTime read fDt_Cadastro write fDt_Cadastro;
    property Nr_Parcelas : Real read fNr_Parcelas write fNr_Parcelas;
    property Cd_Historico : Real read fCd_Historico write fCd_Historico;
    property Cd_Histfec : Real read fCd_Histfec write fCd_Histfec;
    property Nr_Portador : Real read fNr_Portador write fNr_Portador;
    property Vl_Aux : Real read fVl_Aux write fVl_Aux;
    property Ds_Histrelsub : String read fDs_Histrelsub write fDs_Histrelsub;
    property Cd_Formulacartao : Real read fCd_Formulacartao write fCd_Formulacartao;
  end;

  TFcx_HistrelsubList = class(TcCollection)
  private
    function GetItem(Index: Integer): TFcx_Histrelsub;
    procedure SetItem(Index: Integer; Value: TFcx_Histrelsub);
  public
    constructor Create(AOwner: TPersistent);
    function Add: TFcx_Histrelsub;
    property Items[Index: Integer]: TFcx_Histrelsub read GetItem write SetItem; default;
  end;
  
implementation

{ TFcx_Histrelsub }

constructor TFcx_Histrelsub.Create;
begin

end;

destructor TFcx_Histrelsub.Destroy;
begin

  inherited;
end;

{ TFcx_HistrelsubList }

constructor TFcx_HistrelsubList.Create(AOwner: TPersistent);
begin
  inherited Create(TFcx_Histrelsub);
end;

function TFcx_HistrelsubList.Add: TFcx_Histrelsub;
begin
  Result := TFcx_Histrelsub(inherited Add);
  Result.create;
end;

function TFcx_HistrelsubList.GetItem(Index: Integer): TFcx_Histrelsub;
begin
  Result := TFcx_Histrelsub(inherited GetItem(Index));
end;

procedure TFcx_HistrelsubList.SetItem(Index: Integer; Value: TFcx_Histrelsub);
begin
  inherited SetItem(Index, Value);
end;

end.