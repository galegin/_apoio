unit uGlbPais;

interface

uses
  Classes, SysUtils,
  System.Generics.Collections,
  mMapping;

type
  [Tabela('GLB_PAIS')]
  TGlb_Pais = class(TmMapping)
  private
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
  published
    [Campo('CD_PAIS', tfKey)]
    property Cd_Pais : String read fCd_Pais write fCd_Pais;
    [Campo('U_VERSION', tfNul)]
    property U_Version : String read fU_Version write fU_Version;
    [Campo('CD_OPERADOR', tfNul)]
    property Cd_Operador : String read fCd_Operador write fCd_Operador;
    [Campo('DT_CADASTRO', tfNul)]
    property Dt_Cadastro : String read fDt_Cadastro write fDt_Cadastro;
    [Campo('NM_PAIS', tfNul)]
    property Nm_Pais : String read fNm_Pais write fNm_Pais;
    [Campo('CD_PAISBCB', tfNul)]
    property Cd_Paisbcb : String read fCd_Paisbcb write fCd_Paisbcb;
  end;

  TGlb_Paiss = class(TList<Glb_Pais>);

implementation

{ TGlb_Pais }

constructor TGlb_Pais.Create(AOwner: TComponent);
begin
  inherited;

end;

destructor TGlb_Pais.Destroy;
begin

  inherited;
end;

end.