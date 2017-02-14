unit uFcxTerminalusu;

interface

uses
  Classes, SysUtils,
  cCollection, cCollectionItem;

type
  TFcx_Terminalusu = class;
  TFcx_TerminalusuClass = class of TFcx_Terminalusu;

  TFcx_TerminalusuList = class;
  TFcx_TerminalusuListClass = class of TFcx_TerminalusuList;

  TFcx_Terminalusu = class(TcCollectionItem)
  private
    fCd_Empresa: Real;
    fCd_Terminal: Real;
    fCd_Usuario: Real;
    fU_Version: String;
    fCd_Operador: Real;
    fDt_Cadastro: TDateTime;
  public
    constructor Create; reintroduce;
    destructor Destroy; override;
  published
    property Cd_Empresa : Real read fCd_Empresa write fCd_Empresa;
    property Cd_Terminal : Real read fCd_Terminal write fCd_Terminal;
    property Cd_Usuario : Real read fCd_Usuario write fCd_Usuario;
    property U_Version : String read fU_Version write fU_Version;
    property Cd_Operador : Real read fCd_Operador write fCd_Operador;
    property Dt_Cadastro : TDateTime read fDt_Cadastro write fDt_Cadastro;
  end;

  TFcx_TerminalusuList = class(TcCollection)
  private
    function GetItem(Index: Integer): TFcx_Terminalusu;
    procedure SetItem(Index: Integer; Value: TFcx_Terminalusu);
  public
    constructor Create(AOwner: TPersistent);
    function Add: TFcx_Terminalusu;
    property Items[Index: Integer]: TFcx_Terminalusu read GetItem write SetItem; default;
  end;
  
implementation

{ TFcx_Terminalusu }

constructor TFcx_Terminalusu.Create;
begin

end;

destructor TFcx_Terminalusu.Destroy;
begin

  inherited;
end;

{ TFcx_TerminalusuList }

constructor TFcx_TerminalusuList.Create(AOwner: TPersistent);
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