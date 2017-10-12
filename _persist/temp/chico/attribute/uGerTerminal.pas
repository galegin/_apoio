unit uGerTerminal;

interface

uses
  Classes, SysUtils,
  System.Generics.Collections,
  mMapping;

type
  [Tabela('GER_TERMINAL')]
  TGer_Terminal = class(TmMapping)
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
    [Campo('DS_TERMINAL', tfNul)]
    property Ds_Terminal : String read fDs_Terminal write fDs_Terminal;
    [Campo('NR_CTAPES', tfNul)]
    property Nr_Ctapes : String read fNr_Ctapes write fNr_Ctapes;
  end;

  TGer_Terminals = class(TList<Ger_Terminal>);

implementation

{ TGer_Terminal }

constructor TGer_Terminal.Create(AOwner: TComponent);
begin
  inherited;

end;

destructor TGer_Terminal.Destroy;
begin

  inherited;
end;

end.