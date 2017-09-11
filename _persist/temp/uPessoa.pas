unit uPessoa;

interface

uses
  Classes, SysUtils,
  mMapping;

type
  TPessoa = class(TmMapping)
  private
    fId_Pessoa: String;
    fU_Version: String;
    fCd_Operador: Integer;
    fDt_Cadastro: TDateTime;
    fCd_Pessoa: Integer;
    fNm_Pessoa: String;
    fNr_Cpfncpj: String;
    fNr_Rgie: String;
    fNm_Fantasia: String;
    fCd_Cep: Integer;
    fNm_Logradouro: String;
    fNr_Logradouro: String;
    fDs_Bairro: String;
    fDs_Complemento: String;
    fCd_Municipio: Integer;
    fDs_Municipio: String;
    fCd_Estado: Integer;
    fDs_Estado: String;
    fDs_Siglaestado: String;
    fCd_Pais: Integer;
    fDs_Pais: String;
    fDs_Fone: String;
    fDs_Celular: String;
    fDs_Email: String;
    fIn_Consumidorfinal: String;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function GetMapping() : PmMapping; override;
  published
    property Id_Pessoa : String read fId_Pessoa write fId_Pessoa;
    property U_Version : String read fU_Version write fU_Version;
    property Cd_Operador : Integer read fCd_Operador write fCd_Operador;
    property Dt_Cadastro : TDateTime read fDt_Cadastro write fDt_Cadastro;
    property Cd_Pessoa : Integer read fCd_Pessoa write fCd_Pessoa;
    property Nm_Pessoa : String read fNm_Pessoa write fNm_Pessoa;
    property Nr_Cpfncpj : String read fNr_Cpfncpj write fNr_Cpfncpj;
    property Nr_Rgie : String read fNr_Rgie write fNr_Rgie;
    property Nm_Fantasia : String read fNm_Fantasia write fNm_Fantasia;
    property Cd_Cep : Integer read fCd_Cep write fCd_Cep;
    property Nm_Logradouro : String read fNm_Logradouro write fNm_Logradouro;
    property Nr_Logradouro : String read fNr_Logradouro write fNr_Logradouro;
    property Ds_Bairro : String read fDs_Bairro write fDs_Bairro;
    property Ds_Complemento : String read fDs_Complemento write fDs_Complemento;
    property Cd_Municipio : Integer read fCd_Municipio write fCd_Municipio;
    property Ds_Municipio : String read fDs_Municipio write fDs_Municipio;
    property Cd_Estado : Integer read fCd_Estado write fCd_Estado;
    property Ds_Estado : String read fDs_Estado write fDs_Estado;
    property Ds_Siglaestado : String read fDs_Siglaestado write fDs_Siglaestado;
    property Cd_Pais : Integer read fCd_Pais write fCd_Pais;
    property Ds_Pais : String read fDs_Pais write fDs_Pais;
    property Ds_Fone : String read fDs_Fone write fDs_Fone;
    property Ds_Celular : String read fDs_Celular write fDs_Celular;
    property Ds_Email : String read fDs_Email write fDs_Email;
    property In_Consumidorfinal : String read fIn_Consumidorfinal write fIn_Consumidorfinal;
  end;

  TPessoas = class(TList)
  public
    function Add: TPessoa; overload;
  end;

implementation

{ TPessoa }

constructor TPessoa.Create(AOwner: TComponent);
begin
  inherited;

end;

destructor TPessoa.Destroy;
begin

  inherited;
end;

//--

function TPessoa.GetMapping: PmMapping;
begin
  Result := New(PmMapping);

  Result.Tabela := New(PmTabela);
  with Result.Tabela^ do begin
    Nome := 'PESSOA';
  end;

  Result.Campos := TmCampos.Create;
  with Result.Campos do begin
    Add('Id_Pessoa', 'ID_PESSOA', ftKey);
    Add('U_Version', 'U_VERSION', ftNul);
    Add('Cd_Operador', 'CD_OPERADOR', ftReq);
    Add('Dt_Cadastro', 'DT_CADASTRO', ftReq);
    Add('Cd_Pessoa', 'CD_PESSOA', ftReq);
    Add('Nm_Pessoa', 'NM_PESSOA', ftReq);
    Add('Nr_Cpfncpj', 'NR_CPFNCPJ', ftReq);
    Add('Nr_Rgie', 'NR_RGIE', ftReq);
    Add('Nm_Fantasia', 'NM_FANTASIA', ftNul);
    Add('Cd_Cep', 'CD_CEP', ftReq);
    Add('Nm_Logradouro', 'NM_LOGRADOURO', ftReq);
    Add('Nr_Logradouro', 'NR_LOGRADOURO', ftReq);
    Add('Ds_Bairro', 'DS_BAIRRO', ftReq);
    Add('Ds_Complemento', 'DS_COMPLEMENTO', ftNul);
    Add('Cd_Municipio', 'CD_MUNICIPIO', ftReq);
    Add('Ds_Municipio', 'DS_MUNICIPIO', ftReq);
    Add('Cd_Estado', 'CD_ESTADO', ftReq);
    Add('Ds_Estado', 'DS_ESTADO', ftReq);
    Add('Ds_Siglaestado', 'DS_SIGLAESTADO', ftReq);
    Add('Cd_Pais', 'CD_PAIS', ftReq);
    Add('Ds_Pais', 'DS_PAIS', ftReq);
    Add('Ds_Fone', 'DS_FONE', ftNul);
    Add('Ds_Celular', 'DS_CELULAR', ftNul);
    Add('Ds_Email', 'DS_EMAIL', ftNul);
    Add('In_Consumidorfinal', 'IN_CONSUMIDORFINAL', ftNul);
  end;

  Result.Relacoes := TmRelacoes.Create;
  with Result.Relacoes do begin
  end;
end;

//--

{ TPessoas }

function TPessoas.Add: TPessoa;
begin
  Result := TPessoa.Create(nil);
  Self.Add(Result);
end;

end.