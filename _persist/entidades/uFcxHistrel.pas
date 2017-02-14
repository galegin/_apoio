unit uFcxHistrel;

interface

uses
  Classes, SysUtils,
  cCollection, cCollectionItem;

type
  TFcx_Histrel = class;
  TFcx_HistrelClass = class of TFcx_Histrel;

  TFcx_HistrelList = class;
  TFcx_HistrelListClass = class of TFcx_HistrelList;

  TFcx_Histrel = class(TcCollectionItem)
  private
    fTp_Documento: Real;
    fU_Version: String;
    fCd_Operador: Real;
    fDt_Cadastro: TDateTime;
    fCd_Historico: Real;
    fCd_Histfec: Real;
    fIn_Totalizador: String;
    fIn_Recebimento: String;
    fIn_Faturamento: String;
    fVl_Aux: Real;
    fNr_Portador: Real;
  public
    constructor Create; reintroduce;
    destructor Destroy; override;
  published
    property Tp_Documento : Real read fTp_Documento write fTp_Documento;
    property U_Version : String read fU_Version write fU_Version;
    property Cd_Operador : Real read fCd_Operador write fCd_Operador;
    property Dt_Cadastro : TDateTime read fDt_Cadastro write fDt_Cadastro;
    property Cd_Historico : Real read fCd_Historico write fCd_Historico;
    property Cd_Histfec : Real read fCd_Histfec write fCd_Histfec;
    property In_Totalizador : String read fIn_Totalizador write fIn_Totalizador;
    property In_Recebimento : String read fIn_Recebimento write fIn_Recebimento;
    property In_Faturamento : String read fIn_Faturamento write fIn_Faturamento;
    property Vl_Aux : Real read fVl_Aux write fVl_Aux;
    property Nr_Portador : Real read fNr_Portador write fNr_Portador;
  end;

  TFcx_HistrelList = class(TcCollection)
  private
    function GetItem(Index: Integer): TFcx_Histrel;
    procedure SetItem(Index: Integer; Value: TFcx_Histrel);
  public
    constructor Create(AOwner: TPersistent);
    function Add: TFcx_Histrel;
    property Items[Index: Integer]: TFcx_Histrel read GetItem write SetItem; default;
  end;
  
implementation

{ TFcx_Histrel }

constructor TFcx_Histrel.Create;
begin

end;

destructor TFcx_Histrel.Destroy;
begin

  inherited;
end;

{ TFcx_HistrelList }

constructor TFcx_HistrelList.Create(AOwner: TPersistent);
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