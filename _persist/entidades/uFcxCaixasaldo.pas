unit uFcxCaixasaldo;

interface

uses
  Classes, SysUtils,
  cCollection, cCollectionItem;

type
  TFcx_Caixasaldo = class;
  TFcx_CaixasaldoClass = class of TFcx_Caixasaldo;

  TFcx_CaixasaldoList = class;
  TFcx_CaixasaldoListClass = class of TFcx_CaixasaldoList;

  TFcx_Caixasaldo = class(TcCollectionItem)
  private
    fCd_Empresa: Real;
    fCd_Terminal: Real;
    fDt_Abertura: TDateTime;
    fTp_Documento: Real;
    fNr_Histrelsub: Real;
    fU_Version: String;
    fCd_Operador: Real;
    fDt_Cadastro: TDateTime;
    fVl_Faturamento: Real;
    fVl_Entrada: Real;
    fVl_Retirada: Real;
    fVl_Contado: Real;
    fVl_Dif: Real;
  public
    constructor Create; reintroduce;
    destructor Destroy; override;
  published
    property Cd_Empresa : Real read fCd_Empresa write fCd_Empresa;
    property Cd_Terminal : Real read fCd_Terminal write fCd_Terminal;
    property Dt_Abertura : TDateTime read fDt_Abertura write fDt_Abertura;
    property Tp_Documento : Real read fTp_Documento write fTp_Documento;
    property Nr_Histrelsub : Real read fNr_Histrelsub write fNr_Histrelsub;
    property U_Version : String read fU_Version write fU_Version;
    property Cd_Operador : Real read fCd_Operador write fCd_Operador;
    property Dt_Cadastro : TDateTime read fDt_Cadastro write fDt_Cadastro;
    property Vl_Faturamento : Real read fVl_Faturamento write fVl_Faturamento;
    property Vl_Entrada : Real read fVl_Entrada write fVl_Entrada;
    property Vl_Retirada : Real read fVl_Retirada write fVl_Retirada;
    property Vl_Contado : Real read fVl_Contado write fVl_Contado;
    property Vl_Dif : Real read fVl_Dif write fVl_Dif;
  end;

  TFcx_CaixasaldoList = class(TcCollection)
  private
    function GetItem(Index: Integer): TFcx_Caixasaldo;
    procedure SetItem(Index: Integer; Value: TFcx_Caixasaldo);
  public
    constructor Create(AOwner: TPersistent);
    function Add: TFcx_Caixasaldo;
    property Items[Index: Integer]: TFcx_Caixasaldo read GetItem write SetItem; default;
  end;
  
implementation

{ TFcx_Caixasaldo }

constructor TFcx_Caixasaldo.Create;
begin

end;

destructor TFcx_Caixasaldo.Destroy;
begin

  inherited;
end;

{ TFcx_CaixasaldoList }

constructor TFcx_CaixasaldoList.Create(AOwner: TPersistent);
begin
  inherited Create(TFcx_Caixasaldo);
end;

function TFcx_CaixasaldoList.Add: TFcx_Caixasaldo;
begin
  Result := TFcx_Caixasaldo(inherited Add);
  Result.create;
end;

function TFcx_CaixasaldoList.GetItem(Index: Integer): TFcx_Caixasaldo;
begin
  Result := TFcx_Caixasaldo(inherited GetItem(Index));
end;

procedure TFcx_CaixasaldoList.SetItem(Index: Integer; Value: TFcx_Caixasaldo);
begin
  inherited SetItem(Index, Value);
end;

end.