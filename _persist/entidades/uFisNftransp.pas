unit uFisNftransp;

interface

uses
  Classes, SysUtils,
  cCollection, cCollectionItem;

type
  TFis_Nftransp = class;
  TFis_NftranspClass = class of TFis_Nftransp;

  TFis_NftranspList = class;
  TFis_NftranspListClass = class of TFis_NftranspList;

  TFis_Nftransp = class(TcCollectionItem)
  private
    fCd_Empresa: Real;
    fNr_Fatura: Real;
    fDt_Fatura: TDateTime;
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
  public
    constructor Create; reintroduce;
    destructor Destroy; override;
  published
    property Cd_Empresa : Real read fCd_Empresa write fCd_Empresa;
    property Nr_Fatura : Real read fNr_Fatura write fNr_Fatura;
    property Dt_Fatura : TDateTime read fDt_Fatura write fDt_Fatura;
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
  end;

  TFis_NftranspList = class(TcCollection)
  private
    function GetItem(Index: Integer): TFis_Nftransp;
    procedure SetItem(Index: Integer; Value: TFis_Nftransp);
  public
    constructor Create(AOwner: TPersistent);
    function Add: TFis_Nftransp;
    property Items[Index: Integer]: TFis_Nftransp read GetItem write SetItem; default;
  end;
  
implementation

{ TFis_Nftransp }

constructor TFis_Nftransp.Create;
begin

end;

destructor TFis_Nftransp.Destroy;
begin

  inherited;
end;

{ TFis_NftranspList }

constructor TFis_NftranspList.Create(AOwner: TPersistent);
begin
  inherited Create(TFis_Nftransp);
end;

function TFis_NftranspList.Add: TFis_Nftransp;
begin
  Result := TFis_Nftransp(inherited Add);
  Result.create;
end;

function TFis_NftranspList.GetItem(Index: Integer): TFis_Nftransp;
begin
  Result := TFis_Nftransp(inherited GetItem(Index));
end;

procedure TFis_NftranspList.SetItem(Index: Integer; Value: TFis_Nftransp);
begin
  inherited SetItem(Index, Value);
end;

end.