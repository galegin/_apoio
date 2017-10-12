unit uFcxHistrel;

interface

uses
  Classes, SysUtils,
  mCollection, mCollectionItem;

type
  TFcx_Histrel = class;
  TFcx_HistrelClass = class of TFcx_Histrel;

  TFcx_HistrelList = class;
  TFcx_HistrelListClass = class of TFcx_HistrelList;

  TFcx_Histrel = class(TmCollectionItem)
  private
    fTp_Documento: String;
    fU_Version: String;
    fCd_Operador: String;
    fDt_Cadastro: String;
    fCd_Historico: String;
    fCd_Histfec: String;
    fIn_Totalizador: String;
    fIn_Recebimento: String;
    fIn_Faturamento: String;
    fVl_Aux: String;
    fNr_Portador: String;
  public
    constructor Create(ACollection: TCollection); override;
    destructor Destroy; override;
  published
    property Tp_Documento : String read fTp_Documento write SetTp_Documento;
    property U_Version : String read fU_Version write SetU_Version;
    property Cd_Operador : String read fCd_Operador write SetCd_Operador;
    property Dt_Cadastro : String read fDt_Cadastro write SetDt_Cadastro;
    property Cd_Historico : String read fCd_Historico write SetCd_Historico;
    property Cd_Histfec : String read fCd_Histfec write SetCd_Histfec;
    property In_Totalizador : String read fIn_Totalizador write SetIn_Totalizador;
    property In_Recebimento : String read fIn_Recebimento write SetIn_Recebimento;
    property In_Faturamento : String read fIn_Faturamento write SetIn_Faturamento;
    property Vl_Aux : String read fVl_Aux write SetVl_Aux;
    property Nr_Portador : String read fNr_Portador write SetNr_Portador;
  end;

  TFcx_HistrelList = class(TmCollection)
  private
    function GetItem(Index: Integer): TFcx_Histrel;
    procedure SetItem(Index: Integer; Value: TFcx_Histrel);
  public
    constructor Create(AOwner: TPersistentCollection);
    function Add: TFcx_Histrel;
    property Items[Index: Integer]: TFcx_Histrel read GetItem write SetItem; default;
  end;

implementation

{ TFcx_Histrel }

constructor TFcx_Histrel.Create(ACollection: TCollection);
begin
  inherited;

end;

destructor TFcx_Histrel.Destroy;
begin

  inherited;
end;

{ TFcx_HistrelList }

constructor TFcx_HistrelList.Create(AOwner: TPersistentCollection);
begin
  inherited Create(TFcx_Histrel);
end;

function TFcx_HistrelList.Add: TFcx_Histrel;
begin
  Result := TFcx_Histrel(inherited Add);
  Result.create;
end;

function TFcx_HistrelList.GetItem(Index: Integer): TFcx_Histrel;
begin
  Result := TFcx_Histrel(inherited GetItem(Index));
end;

procedure TFcx_HistrelList.SetItem(Index: Integer; Value: TFcx_Histrel);
begin
  inherited SetItem(Index, Value);
end;

end.