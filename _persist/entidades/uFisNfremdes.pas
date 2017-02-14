unit uFisNfremdes;

interface

uses
  Classes, SysUtils,
  cCollection, cCollectionItem;

type
  TFis_Nfremdes = class;
  TFis_NfremdesClass = class of TFis_Nfremdes;

  TFis_NfremdesList = class;
  TFis_NfremdesListClass = class of TFis_NfremdesList;

  TFis_Nfremdes = class(TcCollectionItem)
  private
    fCd_Empresa: Real;
    fNr_Fatura: Real;
    fDt_Fatura: TDateTime;
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
    fNm_Logradouro: String;
    fDs_Tplogradouro: String;
    fNm_Complemento: String;
    fNm_Bairro: String;
    fNm_Municipio: String;
    fDs_Siglaestado: String;
    fNr_Telefone: String;
    fNr_Rginscrest: String;
    fNr_Cpfcnpj: String;
  public
    constructor Create; reintroduce;
    destructor Destroy; override;
  published
    property Cd_Empresa : Real read fCd_Empresa write fCd_Empresa;
    property Nr_Fatura : Real read fNr_Fatura write fNr_Fatura;
    property Dt_Fatura : TDateTime read fDt_Fatura write fDt_Fatura;
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
    property Nm_Logradouro : String read fNm_Logradouro write fNm_Logradouro;
    property Ds_Tplogradouro : String read fDs_Tplogradouro write fDs_Tplogradouro;
    property Nm_Complemento : String read fNm_Complemento write fNm_Complemento;
    property Nm_Bairro : String read fNm_Bairro write fNm_Bairro;
    property Nm_Municipio : String read fNm_Municipio write fNm_Municipio;
    property Ds_Siglaestado : String read fDs_Siglaestado write fDs_Siglaestado;
    property Nr_Telefone : String read fNr_Telefone write fNr_Telefone;
    property Nr_Rginscrest : String read fNr_Rginscrest write fNr_Rginscrest;
    property Nr_Cpfcnpj : String read fNr_Cpfcnpj write fNr_Cpfcnpj;
  end;

  TFis_NfremdesList = class(TcCollection)
  private
    function GetItem(Index: Integer): TFis_Nfremdes;
    procedure SetItem(Index: Integer; Value: TFis_Nfremdes);
  public
    constructor Create(AOwner: TPersistent);
    function Add: TFis_Nfremdes;
    property Items[Index: Integer]: TFis_Nfremdes read GetItem write SetItem; default;
  end;
  
implementation

{ TFis_Nfremdes }

constructor TFis_Nfremdes.Create;
begin

end;

destructor TFis_Nfremdes.Destroy;
begin

  inherited;
end;

{ TFis_NfremdesList }

constructor TFis_NfremdesList.Create(AOwner: TPersistent);
begin
  inherited Create(TFis_Nfremdes);
end;

function TFis_NfremdesList.Add: TFis_Nfremdes;
begin
  Result := TFis_Nfremdes(inherited Add);
  Result.create;
end;

function TFis_NfremdesList.GetItem(Index: Integer): TFis_Nfremdes;
begin
  Result := TFis_Nfremdes(inherited GetItem(Index));
end;

procedure TFis_NfremdesList.SetItem(Index: Integer; Value: TFis_Nfremdes);
begin
  inherited SetItem(Index, Value);
end;

end.