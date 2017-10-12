unit uTraTransport;

interface

uses
  Classes, SysUtils,
  mCollection, mCollectionItem;

type
  TTra_Transport = class;
  TTra_TransportClass = class of TTra_Transport;

  TTra_TransportList = class;
  TTra_TransportListClass = class of TTra_TransportList;

  TTra_Transport = class(TmCollectionItem)
  private
    fCd_Empresa: String;
    fNr_Transacao: String;
    fDt_Transacao: String;
    fU_Version: String;
    fCd_Transport: String;
    fCd_Empfat: String;
    fCd_Grupoempresa: String;
    fCd_Operador: String;
    fDt_Cadastro: String;
    fCd_Transredespac: String;
    fNm_Transport: String;
    fNm_Transredespac: String;
    fTp_Frete: String;
    fQt_Volume: String;
    fQt_Pesobruto: String;
    fQt_Pesoliquido: String;
    fVl_Frete: String;
    fDs_Ufplaca: String;
    fNr_Placa: String;
    fDs_Especie: String;
    fDs_Marca: String;
    fNm_Logradouro: String;
    fDs_Tplogradouro: String;
    fNr_Logradouro: String;
    fNr_Caixapostal: String;
    fNm_Bairro: String;
    fCd_Cep: String;
    fNm_Municipio: String;
    fDs_Siglaestado: String;
    fNr_Rginscrest: String;
    fNr_Cpfcnpj: String;
    fCd_Transpconhec: String;
    fVl_Conhecimento: String;
  public
    constructor Create(ACollection: TCollection); override;
    destructor Destroy; override;
  published
    property Cd_Empresa : String read fCd_Empresa write SetCd_Empresa;
    property Nr_Transacao : String read fNr_Transacao write SetNr_Transacao;
    property Dt_Transacao : String read fDt_Transacao write SetDt_Transacao;
    property U_Version : String read fU_Version write SetU_Version;
    property Cd_Transport : String read fCd_Transport write SetCd_Transport;
    property Cd_Empfat : String read fCd_Empfat write SetCd_Empfat;
    property Cd_Grupoempresa : String read fCd_Grupoempresa write SetCd_Grupoempresa;
    property Cd_Operador : String read fCd_Operador write SetCd_Operador;
    property Dt_Cadastro : String read fDt_Cadastro write SetDt_Cadastro;
    property Cd_Transredespac : String read fCd_Transredespac write SetCd_Transredespac;
    property Nm_Transport : String read fNm_Transport write SetNm_Transport;
    property Nm_Transredespac : String read fNm_Transredespac write SetNm_Transredespac;
    property Tp_Frete : String read fTp_Frete write SetTp_Frete;
    property Qt_Volume : String read fQt_Volume write SetQt_Volume;
    property Qt_Pesobruto : String read fQt_Pesobruto write SetQt_Pesobruto;
    property Qt_Pesoliquido : String read fQt_Pesoliquido write SetQt_Pesoliquido;
    property Vl_Frete : String read fVl_Frete write SetVl_Frete;
    property Ds_Ufplaca : String read fDs_Ufplaca write SetDs_Ufplaca;
    property Nr_Placa : String read fNr_Placa write SetNr_Placa;
    property Ds_Especie : String read fDs_Especie write SetDs_Especie;
    property Ds_Marca : String read fDs_Marca write SetDs_Marca;
    property Nm_Logradouro : String read fNm_Logradouro write SetNm_Logradouro;
    property Ds_Tplogradouro : String read fDs_Tplogradouro write SetDs_Tplogradouro;
    property Nr_Logradouro : String read fNr_Logradouro write SetNr_Logradouro;
    property Nr_Caixapostal : String read fNr_Caixapostal write SetNr_Caixapostal;
    property Nm_Bairro : String read fNm_Bairro write SetNm_Bairro;
    property Cd_Cep : String read fCd_Cep write SetCd_Cep;
    property Nm_Municipio : String read fNm_Municipio write SetNm_Municipio;
    property Ds_Siglaestado : String read fDs_Siglaestado write SetDs_Siglaestado;
    property Nr_Rginscrest : String read fNr_Rginscrest write SetNr_Rginscrest;
    property Nr_Cpfcnpj : String read fNr_Cpfcnpj write SetNr_Cpfcnpj;
    property Cd_Transpconhec : String read fCd_Transpconhec write SetCd_Transpconhec;
    property Vl_Conhecimento : String read fVl_Conhecimento write SetVl_Conhecimento;
  end;

  TTra_TransportList = class(TmCollection)
  private
    function GetItem(Index: Integer): TTra_Transport;
    procedure SetItem(Index: Integer; Value: TTra_Transport);
  public
    constructor Create(AOwner: TPersistentCollection);
    function Add: TTra_Transport;
    property Items[Index: Integer]: TTra_Transport read GetItem write SetItem; default;
  end;

implementation

{ TTra_Transport }

constructor TTra_Transport.Create(ACollection: TCollection);
begin
  inherited;

end;

destructor TTra_Transport.Destroy;
begin

  inherited;
end;

{ TTra_TransportList }

constructor TTra_TransportList.Create(AOwner: TPersistentCollection);
begin
  inherited Create(TTra_Transport);
end;

function TTra_TransportList.Add: TTra_Transport;
begin
  Result := TTra_Transport(inherited Add);
  Result.create;
end;

function TTra_TransportList.GetItem(Index: Integer): TTra_Transport;
begin
  Result := TTra_Transport(inherited GetItem(Index));
end;

procedure TTra_TransportList.SetItem(Index: Integer; Value: TTra_Transport);
begin
  inherited SetItem(Index, Value);
end;

end.