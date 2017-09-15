unit uTerminal;

interface

uses
  Classes, SysUtils,
  mCollection, mCollectionItem;

type
  TTerminal = class;
  TTerminalClass = class of TTerminal;

  TTerminalList = class;
  TTerminalListClass = class of TTerminalList;

  TTerminal = class(TmCollectionItem)
  private
    fId_Terminal: Integer;
    fU_Version: String;
    fCd_Operador: Integer;
    fDt_Cadastro: String;
    fCd_Terminal: Integer;
    fDs_Terminal: String;
  public
    constructor Create(ACollection: TCollection); override;
    destructor Destroy; override;
  published
    property Id_Terminal : Integer read fId_Terminal write SetId_Terminal;
    property U_Version : String read fU_Version write SetU_Version;
    property Cd_Operador : Integer read fCd_Operador write SetCd_Operador;
    property Dt_Cadastro : String read fDt_Cadastro write SetDt_Cadastro;
    property Cd_Terminal : Integer read fCd_Terminal write SetCd_Terminal;
    property Ds_Terminal : String read fDs_Terminal write SetDs_Terminal;
  end;

  TTerminalList = class(TmCollection)
  private
    function GetItem(Index: Integer): TTerminal;
    procedure SetItem(Index: Integer; Value: TTerminal);
  public
    constructor Create(AOwner: TPersistentCollection);
    function Add: TTerminal;
    property Items[Index: Integer]: TTerminal read GetItem write SetItem; default;
  end;

implementation

{ TTerminal }

constructor TTerminal.Create(ACollection: TCollection);
begin
  inherited;

end;

destructor TTerminal.Destroy;
begin

  inherited;
end;

{ TTerminalList }

constructor TTerminalList.Create(AOwner: TPersistentCollection);
begin
  inherited Create(TTerminal);
end;

function TTerminalList.Add: TTerminal;
begin
  Result := TTerminal(inherited Add);
  Result.create;
end;

function TTerminalList.GetItem(Index: Integer): TTerminal;
begin
  Result := TTerminal(inherited GetItem(Index));
end;

procedure TTerminalList.SetItem(Index: Integer; Value: TTerminal);
begin
  inherited SetItem(Index, Value);
end;

end.