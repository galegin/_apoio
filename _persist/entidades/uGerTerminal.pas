unit uGerTerminal;

interface

uses
  Classes, SysUtils,
  cCollection, cCollectionItem;

type
  TGer_Terminal = class;
  TGer_TerminalClass = class of TGer_Terminal;

  TGer_TerminalList = class;
  TGer_TerminalListClass = class of TGer_TerminalList;

  TGer_Terminal = class(TcCollectionItem)
  private
    fCd_Empresa: Real;
    fCd_Terminal: Real;
    fU_Version: String;
    fCd_Operador: Real;
    fDt_Cadastro: TDateTime;
    fDs_Terminal: String;
    fNr_Ctapes: Real;
  public
    constructor Create; reintroduce;
    destructor Destroy; override;
  published
    property Cd_Empresa : Real read fCd_Empresa write fCd_Empresa;
    property Cd_Terminal : Real read fCd_Terminal write fCd_Terminal;
    property U_Version : String read fU_Version write fU_Version;
    property Cd_Operador : Real read fCd_Operador write fCd_Operador;
    property Dt_Cadastro : TDateTime read fDt_Cadastro write fDt_Cadastro;
    property Ds_Terminal : String read fDs_Terminal write fDs_Terminal;
    property Nr_Ctapes : Real read fNr_Ctapes write fNr_Ctapes;
  end;

  TGer_TerminalList = class(TcCollection)
  private
    function GetItem(Index: Integer): TGer_Terminal;
    procedure SetItem(Index: Integer; Value: TGer_Terminal);
  public
    constructor Create(AOwner: TPersistent);
    function Add: TGer_Terminal;
    property Items[Index: Integer]: TGer_Terminal read GetItem write SetItem; default;
  end;
  
implementation

{ TGer_Terminal }

constructor TGer_Terminal.Create;
begin

end;

destructor TGer_Terminal.Destroy;
begin

  inherited;
end;

{ TGer_TerminalList }

constructor TGer_TerminalList.Create(AOwner: TPersistent);
begin
  inherited Create(TGer_Terminal);
end;

function TGer_TerminalList.Add: TGer_Terminal;
begin
  Result := TGer_Terminal(inherited Add);
  Result.create;
end;

function TGer_TerminalList.GetItem(Index: Integer): TGer_Terminal;
begin
  Result := TGer_Terminal(inherited GetItem(Index));
end;

procedure TGer_TerminalList.SetItem(Index: Integer; Value: TGer_Terminal);
begin
  inherited SetItem(Index, Value);
end;

end.