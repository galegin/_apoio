unit uTraRemdes;

interface

uses
  Classes, SysUtils,
  mMapping;

type
  TTra_Remdes = class(TmMapping)
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
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function GetMapping() : PmMapping; override;
  published
    property Cd_Empresa : String read fCd_Empresa write fCd_Empresa;
    property Nr_Transacao : String read fNr_Transacao write fNr_Transacao;
    property Dt_Transacao : String read fDt_Transacao write fDt_Transacao;
    property U_Version : String read fU_Version write fU_Version;
    property Cd_Empfat : String read fCd_Empfat write fCd_Empfat;
    property Cd_Grupoempresa : String read fCd_Grupoempresa write fCd_Grupoempresa;
    property Cd_Operador : String read fCd_Operador write fCd_Operador;
    property Dt_Cadastro : String read fDt_Cadastro write fDt_Cadastro;
    property Nm_Nome : String read fNm_Nome write fNm_Nome;
    property Cd_Pessoa : String read fCd_Pessoa write fCd_Pessoa;
    property Tp_Pessoa : String read fTp_Pessoa write fTp_Pessoa;
    property In_Contribuinte : String read fIn_Contribuinte write fIn_Contribuinte;
    property Nr_Caixapostal : String read fNr_Caixapostal write fNr_Caixapostal;
    property Nr_Logradouro : String read fNr_Logradouro write fNr_Logradouro;
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

  TTra_Remdess = class(TList)
  public
    function Add: TTra_Remdes; overload;
  end;

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

//--

function TTra_Remdes.GetMapping: PmMapping;
begin
  Result := New(PmMapping);

  Result.Tabela := New(PmTabela);
  with Result.Tabela^ do begin
    Nome := 'TRA_REMDES';
  end;

  Result.Campos := TmCampos.Create;
  with Result.Campos do begin
    Add('Cd_Empresa', 'CD_EMPRESA', tfKey);
    Add('Nr_Transacao', 'NR_TRANSACAO', tfKey);
    Add('Dt_Transacao', 'DT_TRANSACAO', tfKey);
    Add('U_Version', 'U_VERSION', tfNul);
    Add('Cd_Empfat', 'CD_EMPFAT', tfReq);
    Add('Cd_Grupoempresa', 'CD_GRUPOEMPRESA', tfReq);
    Add('Cd_Operador', 'CD_OPERADOR', tfReq);
    Add('Dt_Cadastro', 'DT_CADASTRO', tfReq);
    Add('Nm_Nome', 'NM_NOME', tfReq);
    Add('Cd_Pessoa', 'CD_PESSOA', tfNul);
    Add('Tp_Pessoa', 'TP_PESSOA', tfNul);
    Add('In_Contribuinte', 'IN_CONTRIBUINTE', tfNul);
    Add('Nr_Caixapostal', 'NR_CAIXAPOSTAL', tfNul);
    Add('Nr_Logradouro', 'NR_LOGRADOURO', tfNul);
    Add('Cd_Cep', 'CD_CEP', tfNul);
    Add('Ds_Siglaestado', 'DS_SIGLAESTADO', tfNul);
    Add('Ds_Tplogradouro', 'DS_TPLOGRADOURO', tfNul);
    Add('Nr_Rginscrest', 'NR_RGINSCREST', tfNul);
    Add('Nr_Cpfcnpj', 'NR_CPFCNPJ', tfNul);
    Add('Nr_Telefone', 'NR_TELEFONE', tfNul);
    Add('Nm_Bairro', 'NM_BAIRRO', tfNul);
    Add('Nm_Logradouro', 'NM_LOGRADOURO', tfNul);
    Add('Nm_Complemento', 'NM_COMPLEMENTO', tfNul);
    Add('Nm_Municipio', 'NM_MUNICIPIO', tfNul);
  end;

  Result.Relacoes := TmRelacoes.Create;
  with Result.Relacoes do begin
  end;
end;

//--

{ TTra_Remdess }

function TTra_Remdess.Add: TTra_Remdes;
begin
  Result := TTra_Remdes.Create(nil);
  Self.Add(Result);
end;

end.