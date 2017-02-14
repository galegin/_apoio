unit uPesEndereco;

interface

uses
  Classes, SysUtils,
  cCollection, cCollectionItem;

type
  TPes_Endereco = class;
  TPes_EnderecoClass = class of TPes_Endereco;

  TPes_EnderecoList = class;
  TPes_EnderecoListClass = class of TPes_EnderecoList;

  TPes_Endereco = class(TcCollectionItem)
  private
    fCd_Pessoa: Real;
    fNr_Sequencia: Real;
    fU_Version: String;
    fCd_Tipoendereco: Real;
    fCd_Operador: Real;
    fCd_Municipio: Real;
    fCd_Cep: String;
    fDt_Cadastro: TDateTime;
    fNm_Logradouro: String;
    fNr_Caixapostal: Real;
    fNr_Logradouro: Real;
    fDs_Referencia: String;
    fDs_Complemento: String;
    fDs_Bairro: String;
    fDs_Siglalograd: String;
  public
    constructor Create; reintroduce;
    destructor Destroy; override;
  published
    property Cd_Pessoa : Real read fCd_Pessoa write fCd_Pessoa;
    property Nr_Sequencia : Real read fNr_Sequencia write fNr_Sequencia;
    property U_Version : String read fU_Version write fU_Version;
    property Cd_Tipoendereco : Real read fCd_Tipoendereco write fCd_Tipoendereco;
    property Cd_Operador : Real read fCd_Operador write fCd_Operador;
    property Cd_Municipio : Real read fCd_Municipio write fCd_Municipio;
    property Cd_Cep : String read fCd_Cep write fCd_Cep;
    property Dt_Cadastro : TDateTime read fDt_Cadastro write fDt_Cadastro;
    property Nm_Logradouro : String read fNm_Logradouro write fNm_Logradouro;
    property Nr_Caixapostal : Real read fNr_Caixapostal write fNr_Caixapostal;
    property Nr_Logradouro : Real read fNr_Logradouro write fNr_Logradouro;
    property Ds_Referencia : String read fDs_Referencia write fDs_Referencia;
    property Ds_Complemento : String read fDs_Complemento write fDs_Complemento;
    property Ds_Bairro : String read fDs_Bairro write fDs_Bairro;
    property Ds_Siglalograd : String read fDs_Siglalograd write fDs_Siglalograd;
  end;

  TPes_EnderecoList = class(TcCollection)
  private
    function GetItem(Index: Integer): TPes_Endereco;
    procedure SetItem(Index: Integer; Value: TPes_Endereco);
  public
    constructor Create(AOwner: TPersistent);
    function Add: TPes_Endereco;
    property Items[Index: Integer]: TPes_Endereco read GetItem write SetItem; default;
  end;
  
implementation

{ TPes_Endereco }

constructor TPes_Endereco.Create;
begin

end;

destructor TPes_Endereco.Destroy;
begin

  inherited;
end;

{ TPes_EnderecoList }

constructor TPes_EnderecoList.Create(AOwner: TPersistent);
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