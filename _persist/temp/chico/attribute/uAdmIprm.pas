unit uAdmIprm;

interface

uses
  Classes, SysUtils,
  System.Generics.Collections,
  mMapping;

type
  [Tabela('ADM_IPRM')]
  TAdm_Iprm = class(TmMapping)
  private
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
  published
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

  TAdm_Iprms = class(TList<Adm_Iprm>);

implementation

{ TAdm_Iprm }

constructor TAdm_Iprm.Create(AOwner: TComponent);
begin
  inherited;

end;

destructor TAdm_Iprm.Destroy;
begin

  inherited;
end;

end.