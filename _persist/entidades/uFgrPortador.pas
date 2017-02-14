unit uFgrPortador;

interface

uses
  Classes, SysUtils,
  cCollection, cCollectionItem;

type
  TFgr_Portador = class;
  TFgr_PortadorClass = class of TFgr_Portador;

  TFgr_PortadorList = class;
  TFgr_PortadorListClass = class of TFgr_PortadorList;

  TFgr_Portador = class(TcCollectionItem)
  private
    fNr_Portador: Real;
    fU_Version: String;
    fCd_Operador: Real;
    fDt_Cadastro: TDateTime;
    fDs_Portador: String;
    fIn_Atusaldo: String;
    fIn_Credito: String;
    fIn_Bloqmanut: String;
    fTp_Portador: Real;
    fTp_Vencimento: Real;
    fPr_Aliq: Real;
    fCd_Pessoa: Real;
    fIn_Entrafluxo: String;
  public
    constructor Create; reintroduce;
    destructor Destroy; override;
  published
    property Nr_Portador : Real read fNr_Portador write fNr_Portador;
    property U_Version : String read fU_Version write fU_Version;
    property Cd_Operador : Real read fCd_Operador write fCd_Operador;
    property Dt_Cadastro : TDateTime read fDt_Cadastro write fDt_Cadastro;
    property Ds_Portador : String read fDs_Portador write fDs_Portador;
    property In_Atusaldo : String read fIn_Atusaldo write fIn_Atusaldo;
    property In_Credito : String read fIn_Credito write fIn_Credito;
    property In_Bloqmanut : String read fIn_Bloqmanut write fIn_Bloqmanut;
    property Tp_Portador : Real read fTp_Portador write fTp_Portador;
    property Tp_Vencimento : Real read fTp_Vencimento write fTp_Vencimento;
    property Pr_Aliq : Real read fPr_Aliq write fPr_Aliq;
    property Cd_Pessoa : Real read fCd_Pessoa write fCd_Pessoa;
    property In_Entrafluxo : String read fIn_Entrafluxo write fIn_Entrafluxo;
  end;

  TFgr_PortadorList = class(TcCollection)
  private
    function GetItem(Index: Integer): TFgr_Portador;
    procedure SetItem(Index: Integer; Value: TFgr_Portador);
  public
    constructor Create(AOwner: TPersistent);
    function Add: TFgr_Portador;
    property Items[Index: Integer]: TFgr_Portador read GetItem write SetItem; default;
  end;
  
implementation

{ TFgr_Portador }

constructor TFgr_Portador.Create;
begin

end;

destructor TFgr_Portador.Destroy;
begin

  inherited;
end;

{ TFgr_PortadorList }

constructor TFgr_PortadorList.Create(AOwner: TPersistent);
begin
  inherited Create(TFgr_Portador);
end;

function TFgr_PortadorList.Add: TFgr_Portador;
begin
  Result := TFgr_Portador(inherited Add);
  Result.create;
end;

function TFgr_PortadorList.GetItem(Index: Integer): TFgr_Portador;
begin
  Result := TFgr_Portador(inherited GetItem(Index));
end;

procedure TFgr_PortadorList.SetItem(Index: Integer; Value: TFgr_Portador);
begin
  inherited SetItem(Index, Value);
end;

end.