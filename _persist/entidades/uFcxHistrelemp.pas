unit uFcxHistrelemp;

interface

uses
  Classes, SysUtils,
  cCollection, cCollectionItem;

type
  TFcx_Histrelemp = class;
  TFcx_HistrelempClass = class of TFcx_Histrelemp;

  TFcx_HistrelempList = class;
  TFcx_HistrelempListClass = class of TFcx_HistrelempList;

  TFcx_Histrelemp = class(TcCollectionItem)
  private
    fCd_Empresa: Real;
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
    property Cd_Empresa : Real read fCd_Empresa write fCd_Empresa;
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

  TFcx_HistrelempList = class(TcCollection)
  private
    function GetItem(Index: Integer): TFcx_Histrelemp;
    procedure SetItem(Index: Integer; Value: TFcx_Histrelemp);
  public
    constructor Create(AOwner: TPersistent);
    function Add: TFcx_Histrelemp;
    property Items[Index: Integer]: TFcx_Histrelemp read GetItem write SetItem; default;
  end;
  
implementation

{ TFcx_Histrelemp }

constructor TFcx_Histrelemp.Create;
begin

end;

destructor TFcx_Histrelemp.Destroy;
begin

  inherited;
end;

{ TFcx_HistrelempList }

constructor TFcx_HistrelempList.Create(AOwner: TPersistent);
begin
  inherited Create(TFcx_Histrelemp);
end;

function TFcx_HistrelempList.Add: TFcx_Histrelemp;
begin
  Result := TFcx_Histrelemp(inherited Add);
  Result.create;
end;

function TFcx_HistrelempList.GetItem(Index: Integer): TFcx_Histrelemp;
begin
  Result := TFcx_Histrelemp(inherited GetItem(Index));
end;

procedure TFcx_HistrelempList.SetItem(Index: Integer; Value: TFcx_Histrelemp);
begin
  inherited SetItem(Index, Value);
end;

end.