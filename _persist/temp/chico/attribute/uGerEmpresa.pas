unit uGerEmpresa;

interface

uses
  Classes, SysUtils,
  System.Generics.Collections,
  mMapping;

type
  [Tabela('GER_EMPRESA')]
  TGer_Empresa = class(TmMapping)
  private
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
  published
    [Campo('CD_EMPRESA', tfKey)]
    property Cd_Empresa : String read fCd_Empresa write fCd_Empresa;
    [Campo('U_VERSION', tfNul)]
    property U_Version : String read fU_Version write fU_Version;
    [Campo('CD_GRUPOEMPRESA', tfReq)]
    property Cd_Grupoempresa : String read fCd_Grupoempresa write fCd_Grupoempresa;
    [Campo('CD_OPERADOR', tfReq)]
    property Cd_Operador : String read fCd_Operador write fCd_Operador;
    [Campo('CD_PESSOA', tfReq)]
    property Cd_Pessoa : String read fCd_Pessoa write fCd_Pessoa;
    [Campo('DT_CADASTRO', tfReq)]
    property Dt_Cadastro : String read fDt_Cadastro write fDt_Cadastro;
    [Campo('CD_CCUSTO', tfNul)]
    property Cd_Ccusto : String read fCd_Ccusto write fCd_Ccusto;
  end;

  TGer_Empresas = class(TList<Ger_Empresa>);

implementation

{ TGer_Empresa }

constructor TGer_Empresa.Create(AOwner: TComponent);
begin
  inherited;

end;

destructor TGer_Empresa.Destroy;
begin

  inherited;
end;

end.