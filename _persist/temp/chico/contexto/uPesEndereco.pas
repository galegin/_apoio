unit uPesEndereco;

interface

uses
  Classes, SysUtils,
  mMapping;

type
  TPes_Endereco = class(TmMapping)
  private
    fCd_Pessoa: String;
    fNr_Sequencia: String;
    fU_Version: String;
    fCd_Tipoendereco: String;
    fCd_Operador: String;
    fCd_Municipio: String;
    fCd_Cep: String;
    fDt_Cadastro: String;
    fNm_Logradouro: String;
    fNr_Caixapostal: String;
    fNr_Logradouro: String;
    fDs_Referencia: String;
    fDs_Complemento: String;
    fDs_Bairro: String;
    fDs_Siglalograd: String;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function GetMapping() : PmMapping; override;
  published
    property Cd_Pessoa : String read fCd_Pessoa write fCd_Pessoa;
    property Nr_Sequencia : String read fNr_Sequencia write fNr_Sequencia;
    property U_Version : String read fU_Version write fU_Version;
    property Cd_Tipoendereco : String read fCd_Tipoendereco write fCd_Tipoendereco;
    property Cd_Operador : String read fCd_Operador write fCd_Operador;
    property Cd_Municipio : String read fCd_Municipio write fCd_Municipio;
    property Cd_Cep : String read fCd_Cep write fCd_Cep;
    property Dt_Cadastro : String read fDt_Cadastro write fDt_Cadastro;
    property Nm_Logradouro : String read fNm_Logradouro write fNm_Logradouro;
    property Nr_Caixapostal : String read fNr_Caixapostal write fNr_Caixapostal;
    property Nr_Logradouro : String read fNr_Logradouro write fNr_Logradouro;
    property Ds_Referencia : String read fDs_Referencia write fDs_Referencia;
    property Ds_Complemento : String read fDs_Complemento write fDs_Complemento;
    property Ds_Bairro : String read fDs_Bairro write fDs_Bairro;
    property Ds_Siglalograd : String read fDs_Siglalograd write fDs_Siglalograd;
  end;

  TPes_Enderecos = class(TList)
  public
    function Add: TPes_Endereco; overload;
  end;

implementation

{ TPes_Endereco }

constructor TPes_Endereco.Create(AOwner: TComponent);
begin
  inherited;

end;

destructor TPes_Endereco.Destroy;
begin

  inherited;
end;

//--

function TPes_Endereco.GetMapping: PmMapping;
begin
  Result := New(PmMapping);

  Result.Tabela := New(PmTabela);
  with Result.Tabela^ do begin
    Nome := 'PES_ENDERECO';
  end;

  Result.Campos := TmCampos.Create;
  with Result.Campos do begin
    Add('Cd_Pessoa', 'CD_PESSOA', tfKey);
    Add('Nr_Sequencia', 'NR_SEQUENCIA', tfKey);
    Add('U_Version', 'U_VERSION', tfNul);
    Add('Cd_Tipoendereco', 'CD_TIPOENDERECO', tfReq);
    Add('Cd_Operador', 'CD_OPERADOR', tfReq);
    Add('Cd_Municipio', 'CD_MUNICIPIO', tfReq);
    Add('Cd_Cep', 'CD_CEP', tfReq);
    Add('Dt_Cadastro', 'DT_CADASTRO', tfReq);
    Add('Nm_Logradouro', 'NM_LOGRADOURO', tfReq);
    Add('Nr_Caixapostal', 'NR_CAIXAPOSTAL', tfNul);
    Add('Nr_Logradouro', 'NR_LOGRADOURO', tfNul);
    Add('Ds_Referencia', 'DS_REFERENCIA', tfNul);
    Add('Ds_Complemento', 'DS_COMPLEMENTO', tfNul);
    Add('Ds_Bairro', 'DS_BAIRRO', tfNul);
    Add('Ds_Siglalograd', 'DS_SIGLALOGRAD', tfNul);
  end;

  Result.Relacoes := TmRelacoes.Create;
  with Result.Relacoes do begin
  end;
end;

//--

{ TPes_Enderecos }

function TPes_Enderecos.Add: TPes_Endereco;
begin
  Result := TPes_Endereco.Create(nil);
  Self.Add(Result);
end;

end.