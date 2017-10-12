unit uAdmRestricaousu;

interface

uses
  Classes, SysUtils,
  System.Generics.Collections,
  mMapping;

type
  [Tabela('ADM_RESTRICAOUSU')]
  TAdm_Restricaousu = class(TmMapping)
  private
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
  published
    [Campo('CD_COMPONENTE', tfKey)]
    property Cd_Componente : String read fCd_Componente write fCd_Componente;
    [Campo('DS_CAMPO', tfKey)]
    property Ds_Campo : String read fDs_Campo write fDs_Campo;
    [Campo('CD_EMPRESA', tfKey)]
    property Cd_Empresa : String read fCd_Empresa write fCd_Empresa;
    [Campo('CD_USUARIO', tfKey)]
    property Cd_Usuario : String read fCd_Usuario write fCd_Usuario;
    [Campo('U_VERSION', tfNul)]
    property U_Version : String read fU_Version write fU_Version;
    [Campo('CD_OPERADOR', tfReq)]
    property Cd_Operador : String read fCd_Operador write fCd_Operador;
    [Campo('DT_CADASTRO', tfReq)]
    property Dt_Cadastro : String read fDt_Cadastro write fDt_Cadastro;
    [Campo('VL_INICIO', tfNul)]
    property Vl_Inicio : String read fVl_Inicio write fVl_Inicio;
    [Campo('VL_FIM', tfNul)]
    property Vl_Fim : String read fVl_Fim write fVl_Fim;
    [Campo('IN_SEMRESTRICAO', tfNul)]
    property In_Semrestricao : String read fIn_Semrestricao write fIn_Semrestricao;
    [Campo('IN_PEDESENHA', tfNul)]
    property In_Pedesenha : String read fIn_Pedesenha write fIn_Pedesenha;
  end;

  TAdm_Restricaousus = class(TList<Adm_Restricaousu>);

implementation

{ TAdm_Restricaousu }

constructor TAdm_Restricaousu.Create(AOwner: TComponent);
begin
  inherited;

end;

destructor TAdm_Restricaousu.Destroy;
begin

  inherited;
end;

end.