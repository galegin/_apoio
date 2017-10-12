unit uTraRemdes;

interface

uses
  Classes, SysUtils,
  mCollection, mCollectionItem;

type
  TTra_Remdes = class;
  TTra_RemdesClass = class of TTra_Remdes;

  TTra_RemdesList = class;
  TTra_RemdesListClass = class of TTra_RemdesList;

  TTra_Remdes = class(TmCollectionItem)
  private
    fCd_Empresa: String;
    fNr_Transacao: String;
    fDt_Transacao: String;
    fU_Version: String;
    fCd_Empfat: String;
    fCd_Grupoempresa: String;
    fCd_Operador: String;
    fDt_Cadastro: String;
    fNm_Nome: String;
    fCd_Pessoa: String;
    fTp_Pessoa: String;
    fIn_Contribuinte: String;
    fNr_Caixapostal: String;
    fNr_Logradouro: String;
    fCd_Cep: String;
    fDs_Siglaestado: String;
    fDs_Tplogradouro: String;
    fNr_Rginscrest: String;
    fNr_Cpfcnpj: String;
    fNr_Telefone: String;
    fNm_Bairro: String;
    fNm_Logradouro: String;
    fNm_Complemento: String;
    fNm_Municipio: String;
  public
    constructor Create(ACollection: TCollection); override;
    destructor Destroy; override;
  published
    property Cd_Empresa : String read fCd_Empresa write SetCd_Empresa;
    property Nr_Transacao : String read fNr_Transacao write SetNr_Transacao;
    property Dt_Transacao : String read fDt_Transacao write SetDt_Transacao;
    property U_Version : String read fU_Version write SetU_Version;
    property Cd_Empfat : String read fCd_Empfat write SetCd_Empfat;
    property Cd_Grupoempresa : String read fCd_Grupoempresa write SetCd_Grupoempresa;
    property Cd_Operador : String read fCd_Operador write SetCd_Operador;
    property Dt_Cadastro : String read fDt_Cadastro write SetDt_Cadastro;
    property Nm_Nome : String read fNm_Nome write SetNm_Nome;
    property Cd_Pessoa : String read fCd_Pessoa write SetCd_Pessoa;
    property Tp_Pessoa : String read fTp_Pessoa write SetTp_Pessoa;
    property In_Contribuinte : String read fIn_Contribuinte write SetIn_Contribuinte;
    property Nr_Caixapostal : String read fNr_Caixapostal write SetNr_Caixapostal;
    property Nr_Logradouro : String read fNr_Logradouro write SetNr_Logradouro;
    property Cd_Cep : String read fCd_Cep write SetCd_Cep;
    property Ds_Siglaestado : String read fDs_Siglaestado write SetDs_Siglaestado;
    property Ds_Tplogradouro : String read fDs_Tplogradouro write SetDs_Tplogradouro;
    property Nr_Rginscrest : String read fNr_Rginscrest write SetNr_Rginscrest;
    property Nr_Cpfcnpj : String read fNr_Cpfcnpj write SetNr_Cpfcnpj;
    property Nr_Telefone : String read fNr_Telefone write SetNr_Telefone;
    property Nm_Bairro : String read fNm_Bairro write SetNm_Bairro;
    property Nm_Logradouro : String read fNm_Logradouro write SetNm_Logradouro;
    property Nm_Complemento : String read fNm_Complemento write SetNm_Complemento;
    property Nm_Municipio : String read fNm_Municipio write SetNm_Municipio;
  end;

  TTra_RemdesList = class(TmCollection)
  private
    function GetItem(Index: Integer): TTra_Remdes;
    procedure SetItem(Index: Integer; Value: TTra_Remdes);
  public
    constructor Create(AOwner: TPersistentCollection);
    function Add: TTra_Remdes;
    property Items[Index: Integer]: TTra_Remdes read GetItem write SetItem; default;
  end;

implementation

{ TTra_Remdes }

constructor TTra_Remdes.Create(ACollection: TCollection);
begin
  inherited;

end;

destructor TTra_Remdes.Destroy;
begin

  inherited;
end;

{ TTra_RemdesList }

constructor TTra_RemdesList.Create(AOwner: TPersistentCollection);
begin
  inherited Create(TTra_Remdes);
end;

function TTra_RemdesList.Add: TTra_Remdes;
begin
  Result := TTra_Remdes(inherited Add);
  Result.create;
end;

function TTra_RemdesList.GetItem(Index: Integer): TTra_Remdes;
begin
  Result := TTra_Remdes(inherited GetItem(Index));
end;

procedure TTra_RemdesList.SetItem(Index: Integer; Value: TTra_Remdes);
begin
  inherited SetItem(Index, Value);
end;

end.