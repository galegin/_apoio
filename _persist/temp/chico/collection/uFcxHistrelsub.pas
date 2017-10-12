unit uFcxHistrelsub;

interface

uses
  Classes, SysUtils,
  mCollection, mCollectionItem;

type
  TFcx_Histrelsub = class;
  TFcx_HistrelsubClass = class of TFcx_Histrelsub;

  TFcx_HistrelsubList = class;
  TFcx_HistrelsubListClass = class of TFcx_HistrelsubList;

  TFcx_Histrelsub = class(TmCollectionItem)
  private
    fTp_Documento: String;
    fNr_Seqhistrelsub: String;
    fU_Version: String;
    fCd_Operador: String;
    fDt_Cadastro: String;
    fNr_Parcelas: String;
    fCd_Historico: String;
    fCd_Histfec: String;
    fNr_Portador: String;
    fVl_Aux: String;
    fDs_Histrelsub: String;
    fCd_Formulacartao: String;
  public
    constructor Create(ACollection: TCollection); override;
    destructor Destroy; override;
  published
    property Tp_Documento : String read fTp_Documento write SetTp_Documento;
    property Nr_Seqhistrelsub : String read fNr_Seqhistrelsub write SetNr_Seqhistrelsub;
    property U_Version : String read fU_Version write SetU_Version;
    property Cd_Operador : String read fCd_Operador write SetCd_Operador;
    property Dt_Cadastro : String read fDt_Cadastro write SetDt_Cadastro;
    property Nr_Parcelas : String read fNr_Parcelas write SetNr_Parcelas;
    property Cd_Historico : String read fCd_Historico write SetCd_Historico;
    property Cd_Histfec : String read fCd_Histfec write SetCd_Histfec;
    property Nr_Portador : String read fNr_Portador write SetNr_Portador;
    property Vl_Aux : String read fVl_Aux write SetVl_Aux;
    property Ds_Histrelsub : String read fDs_Histrelsub write SetDs_Histrelsub;
    property Cd_Formulacartao : String read fCd_Formulacartao write SetCd_Formulacartao;
  end;

  TFcx_HistrelsubList = class(TmCollection)
  private
    function GetItem(Index: Integer): TFcx_Histrelsub;
    procedure SetItem(Index: Integer; Value: TFcx_Histrelsub);
  public
    constructor Create(AOwner: TPersistentCollection);
    function Add: TFcx_Histrelsub;
    property Items[Index: Integer]: TFcx_Histrelsub read GetItem write SetItem; default;
  end;

implementation

{ TFcx_Histrelsub }

constructor TFcx_Histrelsub.Create(ACollection: TCollection);
begin
  inherited;

end;

destructor TFcx_Histrelsub.Destroy;
begin

  inherited;
end;

{ TFcx_HistrelsubList }

constructor TFcx_HistrelsubList.Create(AOwner: TPersistentCollection);
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