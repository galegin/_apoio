unit uFcxTerminalusu;

interface

uses
  Classes, SysUtils,
  mCollection, mCollectionItem;

type
  TFcx_Terminalusu = class;
  TFcx_TerminalusuClass = class of TFcx_Terminalusu;

  TFcx_TerminalusuList = class;
  TFcx_TerminalusuListClass = class of TFcx_TerminalusuList;

  TFcx_Terminalusu = class(TmCollectionItem)
  private
    fCd_Empresa: String;
    fCd_Terminal: String;
    fU_Version: String;
    fCd_Operador: String;
    fDt_Cadastro: String;
  public
    constructor Create(ACollection: TCollection); override;
    destructor Destroy; override;
  published
    property Cd_Empresa : String read fCd_Empresa write SetCd_Empresa;
    property Cd_Terminal : String read fCd_Terminal write SetCd_Terminal;
    property U_Version : String read fU_Version write SetU_Version;
    property Cd_Operador : String read fCd_Operador write SetCd_Operador;
    property Dt_Cadastro : String read fDt_Cadastro write SetDt_Cadastro;
  end;

  TFcx_TerminalusuList = class(TmCollection)
  private
    function GetItem(Index: Integer): TFcx_Terminalusu;
    procedure SetItem(Index: Integer; Value: TFcx_Terminalusu);
  public
    constructor Create(AOwner: TPersistentCollection);
    function Add: TFcx_Terminalusu;
    property Items[Index: Integer]: TFcx_Terminalusu read GetItem write SetItem; default;
  end;

implementation

{ TFcx_Terminalusu }

constructor TFcx_Terminalusu.Create(ACollection: TCollection);
begin
  inherited;

end;

destructor TFcx_Terminalusu.Destroy;
begin

  inherited;
end;

{ TFcx_TerminalusuList }

constructor TFcx_TerminalusuList.Create(AOwner: TPersistentCollection);
begin
  inherited Create(TFcx_Terminalusu);
end;

function TFcx_TerminalusuList.Add: TFcx_Terminalusu;
begin
  Result := TFcx_Terminalusu(inherited Add);
  Result.create;
end;

function TFcx_TerminalusuList.GetItem(Index: Integer): TFcx_Terminalusu;
begin
  Result := TFcx_Terminalusu(inherited GetItem(Index));
end;

procedure TFcx_TerminalusuList.SetItem(Index: Integer; Value: TFcx_Terminalusu);
begin
  inherited SetItem(Index, Value);
end;

end.