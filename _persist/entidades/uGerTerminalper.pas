unit uGerTerminalper;

interface

uses
  Classes, SysUtils,
  cCollection, cCollectionItem;

type
  TGer_Terminalper = class;
  TGer_TerminalperClass = class of TGer_Terminalper;

  TGer_TerminalperList = class;
  TGer_TerminalperListClass = class of TGer_TerminalperList;

  TGer_Terminalper = class(TcCollectionItem)
  private
    fCd_Empresa: Real;
    fCd_Terminal: Real;
    fCd_Periferico: Real;
    fU_Version: String;
    fCd_Operador: Real;
    fDt_Cadastro: TDateTime;
    fTp_Periferico: Real;
    fDs_Porta: String;
  public
    constructor Create; reintroduce;
    destructor Destroy; override;
  published
    property Cd_Empresa : Real read fCd_Empresa write fCd_Empresa;
    property Cd_Terminal : Real read fCd_Terminal write fCd_Terminal;
    property Cd_Periferico : Real read fCd_Periferico write fCd_Periferico;
    property U_Version : String read fU_Version write fU_Version;
    property Cd_Operador : Real read fCd_Operador write fCd_Operador;
    property Dt_Cadastro : TDateTime read fDt_Cadastro write fDt_Cadastro;
    property Tp_Periferico : Real read fTp_Periferico write fTp_Periferico;
    property Ds_Porta : String read fDs_Porta write fDs_Porta;
  end;

  TGer_TerminalperList = class(TcCollection)
  private
    function GetItem(Index: Integer): TGer_Terminalper;
    procedure SetItem(Index: Integer; Value: TGer_Terminalper);
  public
    constructor Create(AOwner: TPersistent);
    function Add: TGer_Terminalper;
    property Items[Index: Integer]: TGer_Terminalper read GetItem write SetItem; default;
  end;
  
implementation

{ TGer_Terminalper }

constructor TGer_Terminalper.Create;
begin

end;

destructor TGer_Terminalper.Destroy;
begin

  inherited;
end;

{ TGer_TerminalperList }

constructor TGer_TerminalperList.Create(AOwner: TPersistent);
begin
  inherited Create(TGer_Terminalper);
end;

function TGer_TerminalperList.Add: TGer_Terminalper;
begin
  Result := TGer_Terminalper(inherited Add);
  Result.create;
end;

function TGer_TerminalperList.GetItem(Index: Integer): TGer_Terminalper;
begin
  Result := TGer_Terminalper(inherited GetItem(Index));
end;

procedure TGer_TerminalperList.SetItem(Index: Integer; Value: TGer_Terminalper);
begin
  inherited SetItem(Index, Value);
end;

end.