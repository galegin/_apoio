unit uTraTransport;

interface

uses
  Classes, SysUtils,
  cCollection, cCollectionItem;

type
  TTra_Transport = class;
  TTra_TransportClass = class of TTra_Transport;

  TTra_TransportList = class;
  TTra_TransportListClass = class of TTra_TransportList;

  TTra_Transport = class(TcCollectionItem)
  private
    fCd_Empresa: Real;
    fNr_Transacao: Real;
    fDt_Transacao: TDateTime;
    fU_Version: String;
    fCd_Transport: Real;
    fCd_Empfat: Real;
    fCd_Grupoempresa: Real;
    fCd_Operador: Real;
    fDt_Cadastro: TDateTime;
    fCd_Transredespac: Real;
    fNm_Transport: String;
    fNm_Transredespac: String;
    fTp_Frete: String;
    fQt_Volume: Real;
    fQt_Pesobruto: Real;
    fQt_Pesoliquido: Real;
    fVl_Frete: Real;
    fDs_Ufplaca: String;
    fNr_Placa: String;
    fDs_Especie: String;
    fDs_Marca: String;
    fNm_Logradouro: String;
    fDs_Tplogradouro: String;
    fNr_Logradouro: Real;
    fNr_Caixapostal: Real;
    fNm_Bairro: String;
    fCd_Cep: String;
    fNm_Municipio: String;
    fDs_Siglaestado: String;
    fNr_Rginscrest: String;
    fNr_Cpfcnpj: String;
    fCd_Transpconhec: Real;
    fVl_Conhecimento: Real;
  public
    constructor Create; reintroduce;
    destructor Destroy; override;
  published
    property Cd_Empresa : Real read fCd_Empresa write fCd_Empresa;
    property Nr_Transacao : Real read fNr_Transacao write fNr_Transacao;
    property Dt_Transacao : TDateTime read fDt_Transacao write fDt_Transacao;
    property U_Version : String read fU_Version write fU_Version;
    property Cd_Transport : Real read fCd_Transport write fCd_Transport;
    property Cd_Empfat : Real read fCd_Empfat write fCd_Empfat;
    property Cd_Grupoempresa : Real read fCd_Grupoempresa write fCd_Grupoempresa;
    property Cd_Operador : Real read fCd_Operador write fCd_Operador;
    property Dt_Cadastro : TDateTime read fDt_Cadastro write fDt_Cadastro;
    property Cd_Transredespac : Real read fCd_Transredespac write fCd_Transredespac;
    property Nm_Transport : String read fNm_Transport write fNm_Transport;
    property Nm_Transredespac : String read fNm_Transredespac write fNm_Transredespac;
    property Tp_Frete : String read fTp_Frete write fTp_Frete;
    property Qt_Volume : Real read fQt_Volume write fQt_Volume;
    property Qt_Pesobruto : Real read fQt_Pesobruto write fQt_Pesobruto;
    property Qt_Pesoliquido : Real read fQt_Pesoliquido write fQt_Pesoliquido;
    property Vl_Frete : Real read fVl_Frete write fVl_Frete;
    property Ds_Ufplaca : String read fDs_Ufplaca write fDs_Ufplaca;
    property Nr_Placa : String read fNr_Placa write fNr_Placa;
    property Ds_Especie : String read fDs_Especie write fDs_Especie;
    property Ds_Marca : String read fDs_Marca write fDs_Marca;
    property Nm_Logradouro : String read fNm_Logradouro write fNm_Logradouro;
    property Ds_Tplogradouro : String read fDs_Tplogradouro write fDs_Tplogradouro;
    property Nr_Logradouro : Real read fNr_Logradouro write fNr_Logradouro;
    property Nr_Caixapostal : Real read fNr_Caixapostal write fNr_Caixapostal;
    property Nm_Bairro : String read fNm_Bairro write fNm_Bairro;
    property Cd_Cep : String read fCd_Cep write fCd_Cep;
    property Nm_Municipio : String read fNm_Municipio write fNm_Municipio;
    property Ds_Siglaestado : String read fDs_Siglaestado write fDs_Siglaestado;
    property Nr_Rginscrest : String read fNr_Rginscrest write fNr_Rginscrest;
    property Nr_Cpfcnpj : String read fNr_Cpfcnpj write fNr_Cpfcnpj;
    property Cd_Transpconhec : Real read fCd_Transpconhec write fCd_Transpconhec;
    property Vl_Conhecimento : Real read fVl_Conhecimento write fVl_Conhecimento;
  end;

  TTra_TransportList = class(TcCollection)
  private
    function GetItem(Index: Integer): TTra_Transport;
    procedure SetItem(Index: Integer; Value: TTra_Transport);
  public
    constructor Create(AOwner: TPersistent);
    function Add: TTra_Transport;
    property Items[Index: Integer]: TTra_Transport read GetItem write SetItem; default;
  end;
  
implementation

{ TTra_Transport }

constructor TTra_Transport.Create;
begin

end;

destructor TTra_Transport.Destroy;
begin

  inherited;
end;

{ TTra_TransportList }

constructor TTra_TransportList.Create(AOwner: TPersistent);
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