unit uTraRemdes;

interface

uses
  Classes, SysUtils,
  cCollection, cCollectionItem;

type
  TTra_Remdes = class;
  TTra_RemdesClass = class of TTra_Remdes;

  TTra_RemdesList = class;
  TTra_RemdesListClass = class of TTra_RemdesList;

  TTra_Remdes = class(TcCollectionItem)
  private
    fCd_Empresa: Real;
    fNr_Transacao: Real;
    fDt_Transacao: TDateTime;
    fU_Version: String;
    fCd_Empfat: Real;
    fCd_Grupoempresa: Real;
    fCd_Operador: Real;
    fDt_Cadastro: TDateTime;
    fNm_Nome: String;
    fCd_Pessoa: Real;
    fTp_Pessoa: String;
    fIn_Contribuinte: String;
    fNr_Caixapostal: Real;
    fNr_Logradouro: Real;
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
    constructor Create; reintroduce;
    destructor Destroy; override;
  published
    property Cd_Empresa : Real read fCd_Empresa write fCd_Empresa;
    property Nr_Transacao : Real read fNr_Transacao write fNr_Transacao;
    property Dt_Transacao : TDateTime read fDt_Transacao write fDt_Transacao;
    property U_Version : String read fU_Version write fU_Version;
    property Cd_Empfat : Real read fCd_Empfat write fCd_Empfat;
    property Cd_Grupoempresa : Real read fCd_Grupoempresa write fCd_Grupoempresa;
    property Cd_Operador : Real read fCd_Operador write fCd_Operador;
    property Dt_Cadastro : TDateTime read fDt_Cadastro write fDt_Cadastro;
    property Nm_Nome : String read fNm_Nome write fNm_Nome;
    property Cd_Pessoa : Real read fCd_Pessoa write fCd_Pessoa;
    property Tp_Pessoa : String read fTp_Pessoa write fTp_Pessoa;
    property In_Contribuinte : String read fIn_Contribuinte write fIn_Contribuinte;
    property Nr_Caixapostal : Real read fNr_Caixapostal write fNr_Caixapostal;
    property Nr_Logradouro : Real read fNr_Logradouro write fNr_Logradouro;
    property Cd_Cep : String read fCd_Cep write fCd_Cep;
    property Ds_Siglaestado : String read fDs_Siglaestado write fDs_Siglaestado;
    property Ds_Tplogradouro : String read fDs_Tplogradouro write fDs_Tplogradouro;
    property Nr_Rginscrest : String read fNr_Rginscrest write fNr_Rginscrest;
    property Nr_Cpfcnpj : String read fNr_Cpfcnpj write fNr_Cpfcnpj;
    property Nr_Telefone : String read fNr_Telefone write fNr_Telefone;
    property Nm_Bairro : String read fNm_Bairro write fNm_Bairro;
    property Nm_Logradouro : String read fNm_Logradouro write fNm_Logradouro;
    property Nm_Complemento : String read fNm_Complemento write fNm_Complemento;
    property Nm_Municipio : String read fNm_Municipio write fNm_Municipio;
  end;

  TTra_RemdesList = class(TcCollection)
  private
    function GetItem(Index: Integer): TTra_Remdes;
    procedure SetItem(Index: Integer; Value: TTra_Remdes);
  public
    constructor Create(AOwner: TPersistent);
    function Add: TTra_Remdes;
    property Items[Index: Integer]: TTra_Remdes read GetItem write SetItem; default;
  end;
  
implementation

{ TTra_Remdes }

constructor TTra_Remdes.Create;
begin

end;

destructor TTra_Remdes.Destroy;
begin

  inherited;
end;

{ TTra_RemdesList }

constructor TTra_RemdesList.Create(AOwner: TPersistent);
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