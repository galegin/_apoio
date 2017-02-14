unit uFccHistorico;

interface

uses
  Classes, SysUtils,
  cCollection, cCollectionItem;

type
  TFcc_Historico = class;
  TFcc_HistoricoClass = class of TFcc_Historico;

  TFcc_HistoricoList = class;
  TFcc_HistoricoListClass = class of TFcc_HistoricoList;

  TFcc_Historico = class(TcCollectionItem)
  private
    fCd_Historico: Real;
    fU_Version: String;
    fTp_Operacao: String;
    fCd_Operador: Real;
    fDt_Cadastro: TDateTime;
    fDs_Historico: String;
    fIn_Pedesenha: String;
    fIn_Autaconci: String;
    fIn_Contracx: String;
    fIn_Geracp: String;
  public
    constructor Create; reintroduce;
    destructor Destroy; override;
  published
    property Cd_Historico : Real read fCd_Historico write fCd_Historico;
    property U_Version : String read fU_Version write fU_Version;
    property Tp_Operacao : String read fTp_Operacao write fTp_Operacao;
    property Cd_Operador : Real read fCd_Operador write fCd_Operador;
    property Dt_Cadastro : TDateTime read fDt_Cadastro write fDt_Cadastro;
    property Ds_Historico : String read fDs_Historico write fDs_Historico;
    property In_Pedesenha : String read fIn_Pedesenha write fIn_Pedesenha;
    property In_Autaconci : String read fIn_Autaconci write fIn_Autaconci;
    property In_Contracx : String read fIn_Contracx write fIn_Contracx;
    property In_Geracp : String read fIn_Geracp write fIn_Geracp;
  end;

  TFcc_HistoricoList = class(TcCollection)
  private
    function GetItem(Index: Integer): TFcc_Historico;
    procedure SetItem(Index: Integer; Value: TFcc_Historico);
  public
    constructor Create(AOwner: TPersistent);
    function Add: TFcc_Historico;
    property Items[Index: Integer]: TFcc_Historico read GetItem write SetItem; default;
  end;
  
implementation

{ TFcc_Historico }

constructor TFcc_Historico.Create;
begin

end;

destructor TFcc_Historico.Destroy;
begin

  inherited;
end;

{ TFcc_HistoricoList }

constructor TFcc_HistoricoList.Create(AOwner: TPersistent);
begin
  inherited Create(TFcc_Historico);
end;

function TFcc_HistoricoList.Add: TFcc_Historico;
begin
  Result := TFcc_Historico(inherited Add);
  Result.create;
end;

function TFcc_HistoricoList.GetItem(Index: Integer): TFcc_Historico;
begin
  Result := TFcc_Historico(inherited GetItem(Index));
end;

procedure TFcc_HistoricoList.SetItem(Index: Integer; Value: TFcc_Historico);
begin
  inherited SetItem(Index, Value);
end;

end.