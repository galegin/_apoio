unit uAdmIprmemp;

interface

uses
  Classes, SysUtils,
  System.Generics.Collections,
  mMapping;

type
  [Tabela('ADM_IPRMEMP')]
  TAdm_Iprmemp = class(TmMapping)
  private
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
  published
    [Campo('CD_EMPRESA', tfKey)]
    property Cd_Empresa : String read fCd_Empresa write fCd_Empresa;
    [Campo('CD_PARAMETRO', tfKey)]
    property Cd_Parametro : String read fCd_Parametro write fCd_Parametro;
    [Campo('U_VERSION', tfNul)]
    property U_Version : String read fU_Version write fU_Version;
    [Campo('VL_PARAMETRO', tfNul)]
    property Vl_Parametro : String read fVl_Parametro write fVl_Parametro;
    [Campo('CD_OPERADOR', tfReq)]
    property Cd_Operador : String read fCd_Operador write fCd_Operador;
    [Campo('DT_CADASTRO', tfReq)]
    property Dt_Cadastro : String read fDt_Cadastro write fDt_Cadastro;
  end;

  TAdm_Iprmemps = class(TList<Adm_Iprmemp>);

implementation

{ TAdm_Iprmemp }

constructor TAdm_Iprmemp.Create(AOwner: TComponent);
begin
  inherited;

end;

destructor TAdm_Iprmemp.Destroy;
begin

  inherited;
end;

end.