unit uTraRemdes;

interface

uses
  Classes, SysUtils,
  System.Generics.Collections,
  mMapping;

type
  [Tabela('TRA_REMDES')]
  TTra_Remdes = class(TmMapping)
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
    [Campo('CD_EMPFAT', tfReq)]
    property Cd_Empfat : String read fCd_Empfat write fCd_Empfat;
    [Campo('CD_GRUPOEMPRESA', tfReq)]
    property Cd_Grupoempresa : String read fCd_Grupoempresa write fCd_Grupoempresa;
    [Campo('CD_OPERADOR', tfReq)]
    property Cd_Operador : String read fCd_Operador write fCd_Operador;
    [Campo('DT_CADASTRO', tfReq)]
    property Dt_Cadastro : String read fDt_Cadastro write fDt_Cadastro;
    [Campo('NM_NOME', tfReq)]
    property Nm_Nome : String read fNm_Nome write fNm_Nome;
    [Campo('CD_PESSOA', tfNul)]
    property Cd_Pessoa : String read fCd_Pessoa write fCd_Pessoa;
    [Campo('TP_PESSOA', tfNul)]
    property Tp_Pessoa : String read fTp_Pessoa write fTp_Pessoa;
    [Campo('IN_CONTRIBUINTE', tfNul)]
    property In_Contribuinte : String read fIn_Contribuinte write fIn_Contribuinte;
    [Campo('NR_CAIXAPOSTAL', tfNul)]
    property Nr_Caixapostal : String read fNr_Caixapostal write fNr_Caixapostal;
    [Campo('NR_LOGRADOURO', tfNul)]
    property Nr_Logradouro : String read fNr_Logradouro write fNr_Logradouro;
    [Campo('CD_CEP', tfNul)]
    property Cd_Cep : String read fCd_Cep write fCd_Cep;
    [Campo('DS_SIGLAESTADO', tfNul)]
    property Ds_Siglaestado : String read fDs_Siglaestado write fDs_Siglaestado;
    [Campo('DS_TPLOGRADOURO', tfNul)]
    property Ds_Tplogradouro : String read fDs_Tplogradouro write fDs_Tplogradouro;
    [Campo('NR_RGINSCREST', tfNul)]
    property Nr_Rginscrest : String read fNr_Rginscrest write fNr_Rginscrest;
    [Campo('NR_CPFCNPJ', tfNul)]
    property Nr_Cpfcnpj : String read fNr_Cpfcnpj write fNr_Cpfcnpj;
    [Campo('NR_TELEFONE', tfNul)]
    property Nr_Telefone : String read fNr_Telefone write fNr_Telefone;
    [Campo('NM_BAIRRO', tfNul)]
    property Nm_Bairro : String read fNm_Bairro write fNm_Bairro;
    [Campo('NM_LOGRADOURO', tfNul)]
    property Nm_Logradouro : String read fNm_Logradouro write fNm_Logradouro;
    [Campo('NM_COMPLEMENTO', tfNul)]
    property Nm_Complemento : String read fNm_Complemento write fNm_Complemento;
    [Campo('NM_MUNICIPIO', tfNul)]
    property Nm_Municipio : String read fNm_Municipio write fNm_Municipio;
  end;

  TTra_Remdess = class(TList<Tra_Remdes>);

implementation

{ TTra_Remdes }

constructor TTra_Remdes.Create(AOwner: TComponent);
begin
  inherited;

end;

destructor TTra_Remdes.Destroy;
begin

  inherited;
end;

end.