unit uGerSerie;

interface

uses
  Classes, SysUtils,
  System.Generics.Collections,
  mMapping;

type
  [Tabela('GER_SERIE')]
  TGer_Serie = class(TmMapping)
  private
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
  published
    [Campo('CD_SERIE', tfKey)]
    property Cd_Serie : String read fCd_Serie write fCd_Serie;
    [Campo('U_VERSION', tfNul)]
    property U_Version : String read fU_Version write fU_Version;
    [Campo('CD_OPERADOR', tfReq)]
    property Cd_Operador : String read fCd_Operador write fCd_Operador;
    [Campo('DT_CADASTRO', tfReq)]
    property Dt_Cadastro : String read fDt_Cadastro write fDt_Cadastro;
    [Campo('DS_SERIE', tfReq)]
    property Ds_Serie : String read fDs_Serie write fDs_Serie;
    [Campo('DS_SIGLA', tfNul)]
    property Ds_Sigla : String read fDs_Sigla write fDs_Sigla;
    [Campo('TP_OPERACAO', tfNul)]
    property Tp_Operacao : String read fTp_Operacao write fTp_Operacao;
  end;

  TGer_Series = class(TList<Ger_Serie>);

implementation

{ TGer_Serie }

constructor TGer_Serie.Create(AOwner: TComponent);
begin
  inherited;

end;

destructor TGer_Serie.Destroy;
begin

  inherited;
end;

end.