unit uTraTransport;

interface

uses
  Classes, SysUtils,
  mMapping;

type
  TTra_Transport = class(TmMapping)
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
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function GetMapping() : PmMapping; override;
  published
    property Cd_Empresa : String read fCd_Empresa write fCd_Empresa;
    property Nr_Transacao : String read fNr_Transacao write fNr_Transacao;
    property Dt_Transacao : String read fDt_Transacao write fDt_Transacao;
    property U_Version : String read fU_Version write fU_Version;
    property Cd_Transport : String read fCd_Transport write fCd_Transport;
    property Cd_Empfat : String read fCd_Empfat write fCd_Empfat;
    property Cd_Grupoempresa : String read fCd_Grupoempresa write fCd_Grupoempresa;
    property Cd_Operador : String read fCd_Operador write fCd_Operador;
    property Dt_Cadastro : String read fDt_Cadastro write fDt_Cadastro;
    property Cd_Transredespac : String read fCd_Transredespac write fCd_Transredespac;
    property Nm_Transport : String read fNm_Transport write fNm_Transport;
    property Nm_Transredespac : String read fNm_Transredespac write fNm_Transredespac;
    property Tp_Frete : String read fTp_Frete write fTp_Frete;
    property Qt_Volume : String read fQt_Volume write fQt_Volume;
    property Qt_Pesobruto : String read fQt_Pesobruto write fQt_Pesobruto;
    property Qt_Pesoliquido : String read fQt_Pesoliquido write fQt_Pesoliquido;
    property Vl_Frete : String read fVl_Frete write fVl_Frete;
    property Ds_Ufplaca : String read fDs_Ufplaca write fDs_Ufplaca;
    property Nr_Placa : String read fNr_Placa write fNr_Placa;
    property Ds_Especie : String read fDs_Especie write fDs_Especie;
    property Ds_Marca : String read fDs_Marca write fDs_Marca;
    property Nm_Logradouro : String read fNm_Logradouro write fNm_Logradouro;
    property Ds_Tplogradouro : String read fDs_Tplogradouro write fDs_Tplogradouro;
    property Nr_Logradouro : String read fNr_Logradouro write fNr_Logradouro;
    property Nr_Caixapostal : String read fNr_Caixapostal write fNr_Caixapostal;
    property Nm_Bairro : String read fNm_Bairro write fNm_Bairro;
    property Cd_Cep : String read fCd_Cep write fCd_Cep;
    property Nm_Municipio : String read fNm_Municipio write fNm_Municipio;
    property Ds_Siglaestado : String read fDs_Siglaestado write fDs_Siglaestado;
    property Nr_Rginscrest : String read fNr_Rginscrest write fNr_Rginscrest;
    property Nr_Cpfcnpj : String read fNr_Cpfcnpj write fNr_Cpfcnpj;
    property Cd_Transpconhec : String read fCd_Transpconhec write fCd_Transpconhec;
    property Vl_Conhecimento : String read fVl_Conhecimento write fVl_Conhecimento;
  end;

  TTra_Transports = class(TList)
  public
    function Add: TTra_Transport; overload;
  end;

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

//--

function TTra_Transport.GetMapping: PmMapping;
begin
  Result := New(PmMapping);

  Result.Tabela := New(PmTabela);
  with Result.Tabela^ do begin
    Nome := 'TRA_TRANSPORT';
  end;

  Result.Campos := TmCampos.Create;
  with Result.Campos do begin
    Add('Cd_Empresa', 'CD_EMPRESA', tfKey);
    Add('Nr_Transacao', 'NR_TRANSACAO', tfKey);
    Add('Dt_Transacao', 'DT_TRANSACAO', tfKey);
    Add('U_Version', 'U_VERSION', tfNul);
    Add('Cd_Transport', 'CD_TRANSPORT', tfNul);
    Add('Cd_Empfat', 'CD_EMPFAT', tfReq);
    Add('Cd_Grupoempresa', 'CD_GRUPOEMPRESA', tfReq);
    Add('Cd_Operador', 'CD_OPERADOR', tfReq);
    Add('Dt_Cadastro', 'DT_CADASTRO', tfReq);
    Add('Cd_Transredespac', 'CD_TRANSREDESPAC', tfNul);
    Add('Nm_Transport', 'NM_TRANSPORT', tfNul);
    Add('Nm_Transredespac', 'NM_TRANSREDESPAC', tfNul);
    Add('Tp_Frete', 'TP_FRETE', tfNul);
    Add('Qt_Volume', 'QT_VOLUME', tfNul);
    Add('Qt_Pesobruto', 'QT_PESOBRUTO', tfNul);
    Add('Qt_Pesoliquido', 'QT_PESOLIQUIDO', tfNul);
    Add('Vl_Frete', 'VL_FRETE', tfNul);
    Add('Ds_Ufplaca', 'DS_UFPLACA', tfNul);
    Add('Nr_Placa', 'NR_PLACA', tfNul);
    Add('Ds_Especie', 'DS_ESPECIE', tfNul);
    Add('Ds_Marca', 'DS_MARCA', tfNul);
    Add('Nm_Logradouro', 'NM_LOGRADOURO', tfNul);
    Add('Ds_Tplogradouro', 'DS_TPLOGRADOURO', tfNul);
    Add('Nr_Logradouro', 'NR_LOGRADOURO', tfNul);
    Add('Nr_Caixapostal', 'NR_CAIXAPOSTAL', tfNul);
    Add('Nm_Bairro', 'NM_BAIRRO', tfNul);
    Add('Cd_Cep', 'CD_CEP', tfNul);
    Add('Nm_Municipio', 'NM_MUNICIPIO', tfNul);
    Add('Ds_Siglaestado', 'DS_SIGLAESTADO', tfNul);
    Add('Nr_Rginscrest', 'NR_RGINSCREST', tfNul);
    Add('Nr_Cpfcnpj', 'NR_CPFCNPJ', tfNul);
    Add('Cd_Transpconhec', 'CD_TRANSPCONHEC', tfNul);
    Add('Vl_Conhecimento', 'VL_CONHECIMENTO', tfNul);
  end;

  Result.Relacoes := TmRelacoes.Create;
  with Result.Relacoes do begin
  end;
end;

//--

{ TTra_Transports }

function TTra_Transports.Add: TTra_Transport;
begin
  Result := TTra_Transport.Create(nil);
  Self.Add(Result);
end;

end.