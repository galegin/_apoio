unit uPesEndereco;

interface

uses
  Classes, SysUtils,
  mCollection, mCollectionItem;

type
  TPes_Endereco = class;
  TPes_EnderecoClass = class of TPes_Endereco;

  TPes_EnderecoList = class;
  TPes_EnderecoListClass = class of TPes_EnderecoList;

  TPes_Endereco = class(TmCollectionItem)
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
    constructor Create(ACollection: TCollection); override;
    destructor Destroy; override;
  published
    property Cd_Pessoa : String read fCd_Pessoa write SetCd_Pessoa;
    property Nr_Sequencia : String read fNr_Sequencia write SetNr_Sequencia;
    property U_Version : String read fU_Version write SetU_Version;
    property Cd_Tipoendereco : String read fCd_Tipoendereco write SetCd_Tipoendereco;
    property Cd_Operador : String read fCd_Operador write SetCd_Operador;
    property Cd_Municipio : String read fCd_Municipio write SetCd_Municipio;
    property Cd_Cep : String read fCd_Cep write SetCd_Cep;
    property Dt_Cadastro : String read fDt_Cadastro write SetDt_Cadastro;
    property Nm_Logradouro : String read fNm_Logradouro write SetNm_Logradouro;
    property Nr_Caixapostal : String read fNr_Caixapostal write SetNr_Caixapostal;
    property Nr_Logradouro : String read fNr_Logradouro write SetNr_Logradouro;
    property Ds_Referencia : String read fDs_Referencia write SetDs_Referencia;
    property Ds_Complemento : String read fDs_Complemento write SetDs_Complemento;
    property Ds_Bairro : String read fDs_Bairro write SetDs_Bairro;
    property Ds_Siglalograd : String read fDs_Siglalograd write SetDs_Siglalograd;
  end;

  TPes_EnderecoList = class(TmCollection)
  private
    function GetItem(Index: Integer): TPes_Endereco;
    procedure SetItem(Index: Integer; Value: TPes_Endereco);
  public
    constructor Create(AOwner: TPersistentCollection);
    function Add: TPes_Endereco;
    property Items[Index: Integer]: TPes_Endereco read GetItem write SetItem; default;
  end;

implementation

{ TPes_Endereco }

constructor TPes_Endereco.Create(ACollection: TCollection);
begin
  inherited;

end;

destructor TPes_Endereco.Destroy;
begin

  inherited;
end;

{ TPes_EnderecoList }

constructor TPes_EnderecoList.Create(AOwner: TPersistentCollection);
begin
  inherited Create(TPes_Endereco);
end;

function TPes_EnderecoList.Add: TPes_Endereco;
begin
  Result := TPes_Endereco(inherited Add);
  Result.create;
end;

function TPes_EnderecoList.GetItem(Index: Integer): TPes_Endereco;
begin
  Result := TPes_Endereco(inherited GetItem(Index));
end;

procedure TPes_EnderecoList.SetItem(Index: Integer; Value: TPes_Endereco);
begin
  inherited SetItem(Index, Value);
end;

end.