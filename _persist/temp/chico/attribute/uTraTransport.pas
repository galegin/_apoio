unit uTraTransport;

interface

uses
  Classes, SysUtils,
  System.Generics.Collections,
  mMapping;

type
  [Tabela('TRA_TRANSPORT')]
  TTra_Transport = class(TmMapping)
  private
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
  published
    [Campo('CD_EMPRESA', tfKey)]
    property Cd_Empresa : String read fCd_Empresa write fCd_Empresa;
    [Campo('NR_TRANSACAO', tfKey)]
    property Nr_Transacao : String read fNr_Transacao write fNr_Transacao;
    [Campo('DT_TRANSACAO', tfKey)]
    property Dt_Transacao : String read fDt_Transacao write fDt_Transacao;
    [Campo('U_VERSION', tfNul)]
    property U_Version : String read fU_Version write fU_Version;
    [Campo('CD_TRANSPORT', tfNul)]
    property Cd_Transport : String read fCd_Transport write fCd_Transport;
    [Campo('CD_EMPFAT', tfReq)]
    property Cd_Empfat : String read fCd_Empfat write fCd_Empfat;
    [Campo('CD_GRUPOEMPRESA', tfReq)]
    property Cd_Grupoempresa : String read fCd_Grupoempresa write fCd_Grupoempresa;
    [Campo('CD_OPERADOR', tfReq)]
    property Cd_Operador : String read fCd_Operador write fCd_Operador;
    [Campo('DT_CADASTRO', tfReq)]
    property Dt_Cadastro : String read fDt_Cadastro write fDt_Cadastro;
    [Campo('CD_TRANSREDESPAC', tfNul)]
    property Cd_Transredespac : String read fCd_Transredespac write fCd_Transredespac;
    [Campo('NM_TRANSPORT', tfNul)]
    property Nm_Transport : String read fNm_Transport write fNm_Transport;
    [Campo('NM_TRANSREDESPAC', tfNul)]
    property Nm_Transredespac : String read fNm_Transredespac write fNm_Transredespac;
    [Campo('TP_FRETE', tfNul)]
    property Tp_Frete : String read fTp_Frete write fTp_Frete;
    [Campo('QT_VOLUME', tfNul)]
    property Qt_Volume : String read fQt_Volume write fQt_Volume;
    [Campo('QT_PESOBRUTO', tfNul)]
    property Qt_Pesobruto : String read fQt_Pesobruto write fQt_Pesobruto;
    [Campo('QT_PESOLIQUIDO', tfNul)]
    property Qt_Pesoliquido : String read fQt_Pesoliquido write fQt_Pesoliquido;
    [Campo('VL_FRETE', tfNul)]
    property Vl_Frete : String read fVl_Frete write fVl_Frete;
    [Campo('DS_UFPLACA', tfNul)]
    property Ds_Ufplaca : String read fDs_Ufplaca write fDs_Ufplaca;
    [Campo('NR_PLACA', tfNul)]
    property Nr_Placa : String read fNr_Placa write fNr_Placa;
    [Campo('DS_ESPECIE', tfNul)]
    property Ds_Especie : String read fDs_Especie write fDs_Especie;
    [Campo('DS_MARCA', tfNul)]
    property Ds_Marca : String read fDs_Marca write fDs_Marca;
    [Campo('NM_LOGRADOURO', tfNul)]
    property Nm_Logradouro : String read fNm_Logradouro write fNm_Logradouro;
    [Campo('DS_TPLOGRADOURO', tfNul)]
    property Ds_Tplogradouro : String read fDs_Tplogradouro write fDs_Tplogradouro;
    [Campo('NR_LOGRADOURO', tfNul)]
    property Nr_Logradouro : String read fNr_Logradouro write fNr_Logradouro;
    [Campo('NR_CAIXAPOSTAL', tfNul)]
    property Nr_Caixapostal : String read fNr_Caixapostal write fNr_Caixapostal;
    [Campo('NM_BAIRRO', tfNul)]
    property Nm_Bairro : String read fNm_Bairro write fNm_Bairro;
    [Campo('CD_CEP', tfNul)]
    property Cd_Cep : String read fCd_Cep write fCd_Cep;
    [Campo('NM_MUNICIPIO', tfNul)]
    property Nm_Municipio : String read fNm_Municipio write fNm_Municipio;
    [Campo('DS_SIGLAESTADO', tfNul)]
    property Ds_Siglaestado : String read fDs_Siglaestado write fDs_Siglaestado;
    [Campo('NR_RGINSCREST', tfNul)]
    property Nr_Rginscrest : String read fNr_Rginscrest write fNr_Rginscrest;
    [Campo('NR_CPFCNPJ', tfNul)]
    property Nr_Cpfcnpj : String read fNr_Cpfcnpj write fNr_Cpfcnpj;
    [Campo('CD_TRANSPCONHEC', tfNul)]
    property Cd_Transpconhec : String read fCd_Transpconhec write fCd_Transpconhec;
    [Campo('VL_CONHECIMENTO', tfNul)]
    property Vl_Conhecimento : String read fVl_Conhecimento write fVl_Conhecimento;
  end;

  TTra_Transports = class(TList<Tra_Transport>);

implementation

{ TTra_Transport }

constructor TTra_Transport.Create(AOwner: TComponent);
begin
  inherited;

end;

destructor TTra_Transport.Destroy;
begin

  inherited;
end;

end.