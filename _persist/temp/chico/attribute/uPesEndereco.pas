unit uPesEndereco;

interface

uses
  Classes, SysUtils,
  System.Generics.Collections,
  mMapping;

type
  [Tabela('PES_ENDERECO')]
  TPes_Endereco = class(TmMapping)
  private
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
  published
    [Campo('CD_PESSOA', tfKey)]
    property Cd_Pessoa : String read fCd_Pessoa write fCd_Pessoa;
    [Campo('NR_SEQUENCIA', tfKey)]
    property Nr_Sequencia : String read fNr_Sequencia write fNr_Sequencia;
    [Campo('U_VERSION', tfNul)]
    property U_Version : String read fU_Version write fU_Version;
    [Campo('CD_TIPOENDERECO', tfReq)]
    property Cd_Tipoendereco : String read fCd_Tipoendereco write fCd_Tipoendereco;
    [Campo('CD_OPERADOR', tfReq)]
    property Cd_Operador : String read fCd_Operador write fCd_Operador;
    [Campo('CD_MUNICIPIO', tfReq)]
    property Cd_Municipio : String read fCd_Municipio write fCd_Municipio;
    [Campo('CD_CEP', tfReq)]
    property Cd_Cep : String read fCd_Cep write fCd_Cep;
    [Campo('DT_CADASTRO', tfReq)]
    property Dt_Cadastro : String read fDt_Cadastro write fDt_Cadastro;
    [Campo('NM_LOGRADOURO', tfReq)]
    property Nm_Logradouro : String read fNm_Logradouro write fNm_Logradouro;
    [Campo('NR_CAIXAPOSTAL', tfNul)]
    property Nr_Caixapostal : String read fNr_Caixapostal write fNr_Caixapostal;
    [Campo('NR_LOGRADOURO', tfNul)]
    property Nr_Logradouro : String read fNr_Logradouro write fNr_Logradouro;
    [Campo('DS_REFERENCIA', tfNul)]
    property Ds_Referencia : String read fDs_Referencia write fDs_Referencia;
    [Campo('DS_COMPLEMENTO', tfNul)]
    property Ds_Complemento : String read fDs_Complemento write fDs_Complemento;
    [Campo('DS_BAIRRO', tfNul)]
    property Ds_Bairro : String read fDs_Bairro write fDs_Bairro;
    [Campo('DS_SIGLALOGRAD', tfNul)]
    property Ds_Siglalograd : String read fDs_Siglalograd write fDs_Siglalograd;
  end;

  TPes_Enderecos = class(TList<Pes_Endereco>);

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

end.