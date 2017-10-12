unit uGlbMunicipio;

interface

uses
  Classes, SysUtils,
  System.Generics.Collections,
  mMapping;

type
  [Tabela('GLB_MUNICIPIO')]
  TGlb_Municipio = class(TmMapping)
  private
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
  published
    [Campo('CD_MUNICIPIO', tfKey)]
    property Cd_Municipio : String read fCd_Municipio write fCd_Municipio;
    [Campo('U_VERSION', tfNul)]
    property U_Version : String read fU_Version write fU_Version;
    [Campo('CD_CEP', tfNul)]
    property Cd_Cep : String read fCd_Cep write fCd_Cep;
    [Campo('CD_ESTADO', tfNul)]
    property Cd_Estado : String read fCd_Estado write fCd_Estado;
    [Campo('CD_OPERADOR', tfNul)]
    property Cd_Operador : String read fCd_Operador write fCd_Operador;
    [Campo('DT_CADASTRO', tfNul)]
    property Dt_Cadastro : String read fDt_Cadastro write fDt_Cadastro;
    [Campo('NM_MUNICIPIO', tfNul)]
    property Nm_Municipio : String read fNm_Municipio write fNm_Municipio;
    [Campo('DS_SIGLA', tfNul)]
    property Ds_Sigla : String read fDs_Sigla write fDs_Sigla;
    [Campo('TP_MUNICIPIO', tfNul)]
    property Tp_Municipio : String read fTp_Municipio write fTp_Municipio;
  end;

  TGlb_Municipios = class(TList<Glb_Municipio>);

implementation

{ TGlb_Municipio }

constructor TGlb_Municipio.Create(AOwner: TComponent);
begin
  inherited;

end;

destructor TGlb_Municipio.Destroy;
begin

  inherited;
end;

end.