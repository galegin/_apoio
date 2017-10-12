unit uGlbLogradouro;

interface

uses
  Classes, SysUtils,
  System.Generics.Collections,
  mMapping;

type
  [Tabela('GLB_LOGRADOURO')]
  TGlb_Logradouro = class(TmMapping)
  private
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
  published
    [Campo('CD_CEP', tfKey)]
    property Cd_Cep : String read fCd_Cep write fCd_Cep;
    [Campo('U_VERSION', tfNul)]
    property U_Version : String read fU_Version write fU_Version;
    [Campo('CD_MUNICIPIO', tfReq)]
    property Cd_Municipio : String read fCd_Municipio write fCd_Municipio;
    [Campo('CD_TPLOGRADOURO', tfNul)]
    property Cd_Tplogradouro : String read fCd_Tplogradouro write fCd_Tplogradouro;
    [Campo('CD_BAIRRO', tfNul)]
    property Cd_Bairro : String read fCd_Bairro write fCd_Bairro;
    [Campo('CD_OPERADOR', tfNul)]
    property Cd_Operador : String read fCd_Operador write fCd_Operador;
    [Campo('DT_CADASTRO', tfNul)]
    property Dt_Cadastro : String read fDt_Cadastro write fDt_Cadastro;
    [Campo('NM_LOGRADOURO', tfNul)]
    property Nm_Logradouro : String read fNm_Logradouro write fNm_Logradouro;
    [Campo('NM_COMPLEMENTO', tfNul)]
    property Nm_Complemento : String read fNm_Complemento write fNm_Complemento;
  end;

  TGlb_Logradouros = class(TList<Glb_Logradouro>);

implementation

{ TGlb_Logradouro }

constructor TGlb_Logradouro.Create(AOwner: TComponent);
begin
  inherited;

end;

destructor TGlb_Logradouro.Destroy;
begin

  inherited;
end;

end.