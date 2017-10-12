unit uFcxTerminalusu;

interface

uses
  Classes, SysUtils,
  System.Generics.Collections,
  mMapping;

type
  [Tabela('FCX_TERMINALUSU')]
  TFcx_Terminalusu = class(TmMapping)
  private
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
  published
    [Campo('CD_EMPRESA', tfKey)]
    property Cd_Empresa : String read fCd_Empresa write fCd_Empresa;
    [Campo('CD_TERMINAL', tfKey)]
    property Cd_Terminal : String read fCd_Terminal write fCd_Terminal;
    [Campo('U_VERSION', tfNul)]
    property U_Version : String read fU_Version write fU_Version;
    [Campo('CD_OPERADOR', tfReq)]
    property Cd_Operador : String read fCd_Operador write fCd_Operador;
    [Campo('DT_CADASTRO', tfReq)]
    property Dt_Cadastro : String read fDt_Cadastro write fDt_Cadastro;
  end;

  TFcx_Terminalusus = class(TList<Fcx_Terminalusu>);

implementation

{ TFcx_Terminalusu }

constructor TFcx_Terminalusu.Create(AOwner: TComponent);
begin
  inherited;

end;

destructor TFcx_Terminalusu.Destroy;
begin

  inherited;
end;

end.