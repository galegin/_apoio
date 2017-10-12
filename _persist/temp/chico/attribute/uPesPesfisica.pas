unit uPesPesfisica;

interface

uses
  Classes, SysUtils,
  System.Generics.Collections,
  mMapping;

type
  [Tabela('PES_PESFISICA')]
  TPes_Pesfisica = class(TmMapping)
  private
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
  published
    [Campo('CD_PESSOA', tfKey)]
    property Cd_Pessoa : String read fCd_Pessoa write fCd_Pessoa;
    [Campo('U_VERSION', tfNul)]
    property U_Version : String read fU_Version write fU_Version;
    [Campo('CD_OPERADOR', tfReq)]
    property Cd_Operador : String read fCd_Operador write fCd_Operador;
    [Campo('DT_CADASTRO', tfReq)]
    property Dt_Cadastro : String read fDt_Cadastro write fDt_Cadastro;
    [Campo('IN_INATIVO', tfNul)]
    property In_Inativo : String read fIn_Inativo write fIn_Inativo;
    [Campo('TP_ESTCIVIL', tfNul)]
    property Tp_Estcivil : String read fTp_Estcivil write fTp_Estcivil;
    [Campo('TP_SEXO', tfNul)]
    property Tp_Sexo : String read fTp_Sexo write fTp_Sexo;
    [Campo('CD_SERIECTPS', tfNul)]
    property Cd_Seriectps : String read fCd_Seriectps write fCd_Seriectps;
    [Campo('DS_ORGEXPEDIDOR', tfNul)]
    property Ds_Orgexpedidor : String read fDs_Orgexpedidor write fDs_Orgexpedidor;
    [Campo('NR_CTPS', tfNul)]
    property Nr_Ctps : String read fNr_Ctps write fNr_Ctps;
    [Campo('NR_CPF', tfNul)]
    property Nr_Cpf : String read fNr_Cpf write fNr_Cpf;
    [Campo('NR_RG', tfNul)]
    property Nr_Rg : String read fNr_Rg write fNr_Rg;
    [Campo('VL_RENDAMENSAL', tfNul)]
    property Vl_Rendamensal : String read fVl_Rendamensal write fVl_Rendamensal;
    [Campo('DS_CARGO', tfNul)]
    property Ds_Cargo : String read fDs_Cargo write fDs_Cargo;
    [Campo('DT_ADMISSAO', tfNul)]
    property Dt_Admissao : String read fDt_Admissao write fDt_Admissao;
    [Campo('DT_NASCIMENTO', tfNul)]
    property Dt_Nascimento : String read fDt_Nascimento write fDt_Nascimento;
    [Campo('DS_LOCALTRAB', tfNul)]
    property Ds_Localtrab : String read fDs_Localtrab write fDs_Localtrab;
    [Campo('DS_LOCALNASC', tfNul)]
    property Ds_Localnasc : String read fDs_Localnasc write fDs_Localnasc;
    [Campo('DS_NACIONALIDADE', tfNul)]
    property Ds_Nacionalidade : String read fDs_Nacionalidade write fDs_Nacionalidade;
    [Campo('NM_MAE', tfNul)]
    property Nm_Mae : String read fNm_Mae write fNm_Mae;
    [Campo('NM_PAI', tfNul)]
    property Nm_Pai : String read fNm_Pai write fNm_Pai;
  end;

  TPes_Pesfisicas = class(TList<Pes_Pesfisica>);

implementation

{ TPes_Pesfisica }

constructor TPes_Pesfisica.Create(AOwner: TComponent);
begin
  inherited;

end;

destructor TPes_Pesfisica.Destroy;
begin

  inherited;
end;

end.