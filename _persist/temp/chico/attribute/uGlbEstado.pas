unit uGlbEstado;

interface

uses
  Classes, SysUtils,
  System.Generics.Collections,
  mMapping;

type
  [Tabela('GLB_ESTADO')]
  TGlb_Estado = class(TmMapping)
  private
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
  published
    [Campo('CD_ESTADO', tfKey)]
    property Cd_Estado : String read fCd_Estado write fCd_Estado;
    [Campo('U_VERSION', tfNul)]
    property U_Version : String read fU_Version write fU_Version;
    [Campo('CD_PAIS', tfNul)]
    property Cd_Pais : String read fCd_Pais write fCd_Pais;
    [Campo('DS_SIGLA', tfNul)]
    property Ds_Sigla : String read fDs_Sigla write fDs_Sigla;
    [Campo('CD_OPERADOR', tfNul)]
    property Cd_Operador : String read fCd_Operador write fCd_Operador;
    [Campo('DT_CADASTRO', tfNul)]
    property Dt_Cadastro : String read fDt_Cadastro write fDt_Cadastro;
    [Campo('NM_ESTADO', tfNul)]
    property Nm_Estado : String read fNm_Estado write fNm_Estado;
  end;

  TGlb_Estados = class(TList<Glb_Estado>);

implementation

{ TGlb_Estado }

constructor TGlb_Estado.Create(AOwner: TComponent);
begin
  inherited;

end;

destructor TGlb_Estado.Destroy;
begin

  inherited;
end;

end.