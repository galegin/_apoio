unit uFcxHistrelusu;

interface

uses
  Classes, SysUtils,
  cCollection, cCollectionItem;

type
  TFcx_Histrelusu = class;
  TFcx_HistrelusuClass = class of TFcx_Histrelusu;

  TFcx_HistrelusuList = class;
  TFcx_HistrelusuListClass = class of TFcx_HistrelusuList;

  TFcx_Histrelusu = class(TcCollectionItem)
  private
    fCd_Usuario: Real;
    fTp_Documento: Real;
    fU_Version: String;
    fCd_Operador: Real;
    fDt_Cadastro: TDateTime;
    fCd_Historico: Real;
    fCd_Histfec: Real;
    fIn_Totalizador: String;
    fIn_Faturamento: String;
    fIn_Recebimento: String;
    fVl_Aux: Real;
    fNr_Portador: Real;
  public
    constructor Create; reintroduce;
    destructor Destroy; override;
  published
    property Cd_Usuario : Real read fCd_Usuario write fCd_Usuario;
    property Tp_Documento : Real read fTp_Documento write fTp_Documento;
    property U_Version : String read fU_Version write fU_Version;
    property Cd_Operador : Real read fCd_Operador write fCd_Operador;
    property Dt_Cadastro : TDateTime read fDt_Cadastro write fDt_Cadastro;
    property Cd_Historico : Real read fCd_Historico write fCd_Historico;
    property Cd_Histfec : Real read fCd_Histfec write fCd_Histfec;
    property In_Totalizador : String read fIn_Totalizador write fIn_Totalizador;
    property In_Faturamento : String read fIn_Faturamento write fIn_Faturamento;
    property In_Recebimento : String read fIn_Recebimento write fIn_Recebimento;
    property Vl_Aux : Real read fVl_Aux write fVl_Aux;
    property Nr_Portador : Real read fNr_Portador write fNr_Portador;
  end;

  TFcx_HistrelusuList = class(TcCollection)
  private
    function GetItem(Index: Integer): TFcx_Histrelusu;
    procedure SetItem(Index: Integer; Value: TFcx_Histrelusu);
  public
    constructor Create(AOwner: TPersistent);
    function Add: TFcx_Histrelusu;
    property Items[Index: Integer]: TFcx_Histrelusu read GetItem write SetItem; default;
  end;
  
implementation

{ TFcx_Histrelusu }

constructor TFcx_Histrelusu.Create;
begin

end;

destructor TFcx_Histrelusu.Destroy;
begin

  inherited;
end;

{ TFcx_HistrelusuList }

constructor TFcx_HistrelusuList.Create(AOwner: TPersistent);
begin
  inherited Create(TFcx_Histrelusu);
end;

function TFcx_HistrelusuList.Add: TFcx_Histrelusu;
begin
  Result := TFcx_Histrelusu(inherited Add);
  Result.create;
end;

function TFcx_HistrelusuList.GetItem(Index: Integer): TFcx_Histrelusu;
begin
  Result := TFcx_Histrelusu(inherited GetItem(Index));
end;

procedure TFcx_HistrelusuList.SetItem(Index: Integer; Value: TFcx_Histrelusu);
begin
  inherited SetItem(Index, Value);
end;

end.