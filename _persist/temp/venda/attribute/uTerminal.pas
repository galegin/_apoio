unit uTerminal;

interface

uses
  Classes, SysUtils,
  System.Generics.Collections,
  mMapping;

type
  [Tabela('TERMINAL')]
  TTerminal = class(TmMapping)
  private
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
  published
    [Campo('ID_TERMINAL', tfKey)]
    property Id_Terminal : Integer read fId_Terminal write fId_Terminal;
    [Campo('U_VERSION', tfNul)]
    property U_Version : String read fU_Version write fU_Version;
    [Campo('CD_OPERADOR', tfReq)]
    property Cd_Operador : Integer read fCd_Operador write fCd_Operador;
    [Campo('DT_CADASTRO', tfReq)]
    property Dt_Cadastro : String read fDt_Cadastro write fDt_Cadastro;
    [Campo('CD_TERMINAL', tfReq)]
    property Cd_Terminal : Integer read fCd_Terminal write fCd_Terminal;
    [Campo('DS_TERMINAL', tfReq)]
    property Ds_Terminal : String read fDs_Terminal write fDs_Terminal;
  end;

  TTerminals = class(TList<Terminal>);

implementation

{ TTerminal }

constructor TTerminal.Create(AOwner: TComponent);
begin
  inherited;

end;

destructor TTerminal.Destroy;
begin

  inherited;
end;

end.