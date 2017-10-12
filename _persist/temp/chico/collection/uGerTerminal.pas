unit uGerTerminal;

interface

uses
  Classes, SysUtils,
  mCollection, mCollectionItem;

type
  TGer_Terminal = class;
  TGer_TerminalClass = class of TGer_Terminal;

  TGer_TerminalList = class;
  TGer_TerminalListClass = class of TGer_TerminalList;

  TGer_Terminal = class(TmCollectionItem)
  private
    fCd_Empresa: String;
    fCd_Terminal: String;
    fU_Version: String;
    fCd_Operador: String;
    fDt_Cadastro: String;
    fDs_Terminal: String;
    fNr_Ctapes: String;
  public
    constructor Create(ACollection: TCollection); override;
    destructor Destroy; override;
  published
    property Cd_Empresa : String read fCd_Empresa write SetCd_Empresa;
    property Cd_Terminal : String read fCd_Terminal write SetCd_Terminal;
    property U_Version : String read fU_Version write SetU_Version;
    property Cd_Operador : String read fCd_Operador write SetCd_Operador;
    property Dt_Cadastro : String read fDt_Cadastro write SetDt_Cadastro;
    property Ds_Terminal : String read fDs_Terminal write SetDs_Terminal;
    property Nr_Ctapes : String read fNr_Ctapes write SetNr_Ctapes;
  end;

  TGer_TerminalList = class(TmCollection)
  private
    function GetItem(Index: Integer): TGer_Terminal;
    procedure SetItem(Index: Integer; Value: TGer_Terminal);
  public
    constructor Create(AOwner: TPersistentCollection);
    function Add: TGer_Terminal;
    property Items[Index: Integer]: TGer_Terminal read GetItem write SetItem; default;
  end;

implementation

{ TGer_Terminal }

constructor TGer_Terminal.Create(ACollection: TCollection);
begin
  inherited;

end;

destructor TGer_Terminal.Destroy;
begin

  inherited;
end;

{ TGer_TerminalList }

constructor TGer_TerminalList.Create(AOwner: TPersistentCollection);
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