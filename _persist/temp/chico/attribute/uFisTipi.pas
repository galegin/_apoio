unit uFisTipi;

interface

uses
  Classes, SysUtils,
  System.Generics.Collections,
  mMapping;

type
  [Tabela('FIS_TIPI')]
  TFis_Tipi = class(TmMapping)
  private
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
  published
    [Campo('CD_TIPI', tfKey)]
    property Cd_Tipi : String read fCd_Tipi write fCd_Tipi;
    [Campo('U_VERSION', tfNul)]
    property U_Version : String read fU_Version write fU_Version;
    [Campo('PR_IPI', tfNul)]
    property Pr_Ipi : String read fPr_Ipi write fPr_Ipi;
    [Campo('CD_OPERADOR', tfReq)]
    property Cd_Operador : String read fCd_Operador write fCd_Operador;
    [Campo('DT_CADASTRO', tfReq)]
    property Dt_Cadastro : String read fDt_Cadastro write fDt_Cadastro;
    [Campo('DS_TIPI', tfReq)]
    property Ds_Tipi : String read fDs_Tipi write fDs_Tipi;
    [Campo('DS_LEGENDA', tfNul)]
    property Ds_Legenda : String read fDs_Legenda write fDs_Legenda;
  end;

  TFis_Tipis = class(TList<Fis_Tipi>);

implementation

{ TFis_Tipi }

constructor TFis_Tipi.Create(AOwner: TComponent);
begin
  inherited;

end;

destructor TFis_Tipi.Destroy;
begin

  inherited;
end;

end.