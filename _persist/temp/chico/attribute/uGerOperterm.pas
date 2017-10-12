unit uGerOperterm;

interface

uses
  Classes, SysUtils,
  System.Generics.Collections,
  mMapping;

type
  [Tabela('GER_OPERTERM')]
  TGer_Operterm = class(TmMapping)
  private
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
  published
    [Campo('CD_EMPRESA', tfKey)]
    property Cd_Empresa : String read fCd_Empresa write fCd_Empresa;
    [Campo('CD_TERMINAL', tfKey)]
    property Cd_Terminal : String read fCd_Terminal write fCd_Terminal;
    [Campo('CD_OPERACAO', tfKey)]
    property Cd_Operacao : String read fCd_Operacao write fCd_Operacao;
    [Campo('U_VERSION', tfNul)]
    property U_Version : String read fU_Version write fU_Version;
    [Campo('CD_OPERADOR', tfReq)]
    property Cd_Operador : String read fCd_Operador write fCd_Operador;
    [Campo('DT_CADASTRO', tfReq)]
    property Dt_Cadastro : String read fDt_Cadastro write fDt_Cadastro;
    [Campo('CD_SERIE', tfReq)]
    property Cd_Serie : String read fCd_Serie write fCd_Serie;
  end;

  TGer_Operterms = class(TList<Ger_Operterm>);

implementation

{ TGer_Operterm }

constructor TGer_Operterm.Create(AOwner: TComponent);
begin
  inherited;

end;

destructor TGer_Operterm.Destroy;
begin

  inherited;
end;

end.