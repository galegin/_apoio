unit uPesPesfisica;

interface

uses
  Classes, SysUtils,
  mMapping;

type
  TPes_Pesfisica = class(TmMapping)
  private
    fCd_Pessoa: String;
    fU_Version: String;
    fCd_Operador: String;
    fDt_Cadastro: String;
    fIn_Inativo: String;
    fTp_Estcivil: String;
    fTp_Sexo: String;
    fCd_Seriectps: String;
    fDs_Orgexpedidor: String;
    fNr_Ctps: String;
    fNr_Cpf: String;
    fNr_Rg: String;
    fVl_Rendamensal: String;
    fDs_Cargo: String;
    fDt_Admissao: String;
    fDt_Nascimento: String;
    fDs_Localtrab: String;
    fDs_Localnasc: String;
    fDs_Nacionalidade: String;
    fNm_Mae: String;
    fNm_Pai: String;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function GetMapping() : PmMapping; override;
  published
    property Cd_Pessoa : String read fCd_Pessoa write fCd_Pessoa;
    property U_Version : String read fU_Version write fU_Version;
    property Cd_Operador : String read fCd_Operador write fCd_Operador;
    property Dt_Cadastro : String read fDt_Cadastro write fDt_Cadastro;
    property In_Inativo : String read fIn_Inativo write fIn_Inativo;
    property Tp_Estcivil : String read fTp_Estcivil write fTp_Estcivil;
    property Tp_Sexo : String read fTp_Sexo write fTp_Sexo;
    property Cd_Seriectps : String read fCd_Seriectps write fCd_Seriectps;
    property Ds_Orgexpedidor : String read fDs_Orgexpedidor write fDs_Orgexpedidor;
    property Nr_Ctps : String read fNr_Ctps write fNr_Ctps;
    property Nr_Cpf : String read fNr_Cpf write fNr_Cpf;
    property Nr_Rg : String read fNr_Rg write fNr_Rg;
    property Vl_Rendamensal : String read fVl_Rendamensal write fVl_Rendamensal;
    property Ds_Cargo : String read fDs_Cargo write fDs_Cargo;
    property Dt_Admissao : String read fDt_Admissao write fDt_Admissao;
    property Dt_Nascimento : String read fDt_Nascimento write fDt_Nascimento;
    property Ds_Localtrab : String read fDs_Localtrab write fDs_Localtrab;
    property Ds_Localnasc : String read fDs_Localnasc write fDs_Localnasc;
    property Ds_Nacionalidade : String read fDs_Nacionalidade write fDs_Nacionalidade;
    property Nm_Mae : String read fNm_Mae write fNm_Mae;
    property Nm_Pai : String read fNm_Pai write fNm_Pai;
  end;

  TPes_Pesfisicas = class(TList)
  public
    function Add: TPes_Pesfisica; overload;
  end;

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

//--

function TPes_Pesfisica.GetMapping: PmMapping;
begin
  Result := New(PmMapping);

  Result.Tabela := New(PmTabela);
  with Result.Tabela^ do begin
    Nome := 'PES_PESFISICA';
  end;

  Result.Campos := TmCampos.Create;
  with Result.Campos do begin
    Add('Cd_Pessoa', 'CD_PESSOA', tfKey);
    Add('U_Version', 'U_VERSION', tfNul);
    Add('Cd_Operador', 'CD_OPERADOR', tfReq);
    Add('Dt_Cadastro', 'DT_CADASTRO', tfReq);
    Add('In_Inativo', 'IN_INATIVO', tfNul);
    Add('Tp_Estcivil', 'TP_ESTCIVIL', tfNul);
    Add('Tp_Sexo', 'TP_SEXO', tfNul);
    Add('Cd_Seriectps', 'CD_SERIECTPS', tfNul);
    Add('Ds_Orgexpedidor', 'DS_ORGEXPEDIDOR', tfNul);
    Add('Nr_Ctps', 'NR_CTPS', tfNul);
    Add('Nr_Cpf', 'NR_CPF', tfNul);
    Add('Nr_Rg', 'NR_RG', tfNul);
    Add('Vl_Rendamensal', 'VL_RENDAMENSAL', tfNul);
    Add('Ds_Cargo', 'DS_CARGO', tfNul);
    Add('Dt_Admissao', 'DT_ADMISSAO', tfNul);
    Add('Dt_Nascimento', 'DT_NASCIMENTO', tfNul);
    Add('Ds_Localtrab', 'DS_LOCALTRAB', tfNul);
    Add('Ds_Localnasc', 'DS_LOCALNASC', tfNul);
    Add('Ds_Nacionalidade', 'DS_NACIONALIDADE', tfNul);
    Add('Nm_Mae', 'NM_MAE', tfNul);
    Add('Nm_Pai', 'NM_PAI', tfNul);
  end;

  Result.Relacoes := TmRelacoes.Create;
  with Result.Relacoes do begin
  end;
end;

//--

{ TPes_Pesfisicas }

function TPes_Pesfisicas.Add: TPes_Pesfisica;
begin
  Result := TPes_Pesfisica.Create(nil);
  Self.Add(Result);
end;

end.