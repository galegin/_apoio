unit uFisNf;

interface

uses
  Classes, SysUtils,
  mMapping;

type
  TFis_Nf = class(TmMapping)
  private
    fCd_Empresa: String;
    fNr_Fatura: String;
    fDt_Fatura: String;
    fU_Version: String;
    fCd_Pessoa: String;
    fCd_Empfat: String;
    fCd_Grupoempresa: String;
    fCd_Operador: String;
    fDt_Cadastro: String;
    fNr_Nf: String;
    fCd_Serie: String;
    fDt_Emissao: String;
    fTp_Origememissao: String;
    fTp_Moddctofiscal: String;
    fTp_Operacao: String;
    fTp_Situacao: String;
    fCd_Empresaori: String;
    fNr_Transacaoori: String;
    fDt_Transacaoori: String;
    fCd_Operacao: String;
    fCd_Condpgto: String;
    fCd_Modelonf: String;
    fNr_Pre: String;
    fHr_Saida: String;
    fDt_Saidaentrada: String;
    fCd_Compvend: String;
    fIn_Frete: String;
    fCd_Usuimpressao: String;
    fDt_Impressao: String;
    fNr_Impressao: String;
    fPr_Desconto: String;
    fQt_Faturado: String;
    fVl_Totalproduto: String;
    fVl_Despacessor: String;
    fVl_Frete: String;
    fVl_Seguro: String;
    fVl_Ipi: String;
    fVl_Desconto: String;
    fVl_Totalnota: String;
    fVl_Baseicmssubs: String;
    fVl_Icmssubst: String;
    fVl_Baseicms: String;
    fVl_Icms: String;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function GetMapping() : PmMapping; override;
  published
    property Cd_Empresa : String read fCd_Empresa write fCd_Empresa;
    property Nr_Fatura : String read fNr_Fatura write fNr_Fatura;
    property Dt_Fatura : String read fDt_Fatura write fDt_Fatura;
    property U_Version : String read fU_Version write fU_Version;
    property Cd_Pessoa : String read fCd_Pessoa write fCd_Pessoa;
    property Cd_Empfat : String read fCd_Empfat write fCd_Empfat;
    property Cd_Grupoempresa : String read fCd_Grupoempresa write fCd_Grupoempresa;
    property Cd_Operador : String read fCd_Operador write fCd_Operador;
    property Dt_Cadastro : String read fDt_Cadastro write fDt_Cadastro;
    property Nr_Nf : String read fNr_Nf write fNr_Nf;
    property Cd_Serie : String read fCd_Serie write fCd_Serie;
    property Dt_Emissao : String read fDt_Emissao write fDt_Emissao;
    property Tp_Origememissao : String read fTp_Origememissao write fTp_Origememissao;
    property Tp_Moddctofiscal : String read fTp_Moddctofiscal write fTp_Moddctofiscal;
    property Tp_Operacao : String read fTp_Operacao write fTp_Operacao;
    property Tp_Situacao : String read fTp_Situacao write fTp_Situacao;
    property Cd_Empresaori : String read fCd_Empresaori write fCd_Empresaori;
    property Nr_Transacaoori : String read fNr_Transacaoori write fNr_Transacaoori;
    property Dt_Transacaoori : String read fDt_Transacaoori write fDt_Transacaoori;
    property Cd_Operacao : String read fCd_Operacao write fCd_Operacao;
    property Cd_Condpgto : String read fCd_Condpgto write fCd_Condpgto;
    property Cd_Modelonf : String read fCd_Modelonf write fCd_Modelonf;
    property Nr_Pre : String read fNr_Pre write fNr_Pre;
    property Hr_Saida : String read fHr_Saida write fHr_Saida;
    property Dt_Saidaentrada : String read fDt_Saidaentrada write fDt_Saidaentrada;
    property Cd_Compvend : String read fCd_Compvend write fCd_Compvend;
    property In_Frete : String read fIn_Frete write fIn_Frete;
    property Cd_Usuimpressao : String read fCd_Usuimpressao write fCd_Usuimpressao;
    property Dt_Impressao : String read fDt_Impressao write fDt_Impressao;
    property Nr_Impressao : String read fNr_Impressao write fNr_Impressao;
    property Pr_Desconto : String read fPr_Desconto write fPr_Desconto;
    property Qt_Faturado : String read fQt_Faturado write fQt_Faturado;
    property Vl_Totalproduto : String read fVl_Totalproduto write fVl_Totalproduto;
    property Vl_Despacessor : String read fVl_Despacessor write fVl_Despacessor;
    property Vl_Frete : String read fVl_Frete write fVl_Frete;
    property Vl_Seguro : String read fVl_Seguro write fVl_Seguro;
    property Vl_Ipi : String read fVl_Ipi write fVl_Ipi;
    property Vl_Desconto : String read fVl_Desconto write fVl_Desconto;
    property Vl_Totalnota : String read fVl_Totalnota write fVl_Totalnota;
    property Vl_Baseicmssubs : String read fVl_Baseicmssubs write fVl_Baseicmssubs;
    property Vl_Icmssubst : String read fVl_Icmssubst write fVl_Icmssubst;
    property Vl_Baseicms : String read fVl_Baseicms write fVl_Baseicms;
    property Vl_Icms : String read fVl_Icms write fVl_Icms;
  end;

  TFis_Nfs = class(TList)
  public
    function Add: TFis_Nf; overload;
  end;

implementation

{ TFis_Nf }

constructor TFis_Nf.Create(AOwner: TComponent);
begin
  inherited;

end;

destructor TFis_Nf.Destroy;
begin

  inherited;
end;

//--

function TFis_Nf.GetMapping: PmMapping;
begin
  Result := New(PmMapping);

  Result.Tabela := New(PmTabela);
  with Result.Tabela^ do begin
    Nome := 'FIS_NF';
  end;

  Result.Campos := TmCampos.Create;
  with Result.Campos do begin
    Add('Cd_Empresa', 'CD_EMPRESA', tfKey);
    Add('Nr_Fatura', 'NR_FATURA', tfKey);
    Add('Dt_Fatura', 'DT_FATURA', tfKey);
    Add('U_Version', 'U_VERSION', tfNul);
    Add('Cd_Pessoa', 'CD_PESSOA', tfReq);
    Add('Cd_Empfat', 'CD_EMPFAT', tfReq);
    Add('Cd_Grupoempresa', 'CD_GRUPOEMPRESA', tfReq);
    Add('Cd_Operador', 'CD_OPERADOR', tfReq);
    Add('Dt_Cadastro', 'DT_CADASTRO', tfReq);
    Add('Nr_Nf', 'NR_NF', tfNul);
    Add('Cd_Serie', 'CD_SERIE', tfNul);
    Add('Dt_Emissao', 'DT_EMISSAO', tfNul);
    Add('Tp_Origememissao', 'TP_ORIGEMEMISSAO', tfReq);
    Add('Tp_Moddctofiscal', 'TP_MODDCTOFISCAL', tfReq);
    Add('Tp_Operacao', 'TP_OPERACAO', tfReq);
    Add('Tp_Situacao', 'TP_SITUACAO', tfReq);
    Add('Cd_Empresaori', 'CD_EMPRESAORI', tfReq);
    Add('Nr_Transacaoori', 'NR_TRANSACAOORI', tfReq);
    Add('Dt_Transacaoori', 'DT_TRANSACAOORI', tfReq);
    Add('Cd_Operacao', 'CD_OPERACAO', tfNul);
    Add('Cd_Condpgto', 'CD_CONDPGTO', tfNul);
    Add('Cd_Modelonf', 'CD_MODELONF', tfNul);
    Add('Nr_Pre', 'NR_PRE', tfNul);
    Add('Hr_Saida', 'HR_SAIDA', tfNul);
    Add('Dt_Saidaentrada', 'DT_SAIDAENTRADA', tfNul);
    Add('Cd_Compvend', 'CD_COMPVEND', tfNul);
    Add('In_Frete', 'IN_FRETE', tfNul);
    Add('Cd_Usuimpressao', 'CD_USUIMPRESSAO', tfNul);
    Add('Dt_Impressao', 'DT_IMPRESSAO', tfNul);
    Add('Nr_Impressao', 'NR_IMPRESSAO', tfNul);
    Add('Pr_Desconto', 'PR_DESCONTO', tfNul);
    Add('Qt_Faturado', 'QT_FATURADO', tfNul);
    Add('Vl_Totalproduto', 'VL_TOTALPRODUTO', tfNul);
    Add('Vl_Despacessor', 'VL_DESPACESSOR', tfNul);
    Add('Vl_Frete', 'VL_FRETE', tfNul);
    Add('Vl_Seguro', 'VL_SEGURO', tfNul);
    Add('Vl_Ipi', 'VL_IPI', tfNul);
    Add('Vl_Desconto', 'VL_DESCONTO', tfNul);
    Add('Vl_Totalnota', 'VL_TOTALNOTA', tfNul);
    Add('Vl_Baseicmssubs', 'VL_BASEICMSSUBS', tfNul);
    Add('Vl_Icmssubst', 'VL_ICMSSUBST', tfNul);
    Add('Vl_Baseicms', 'VL_BASEICMS', tfNul);
    Add('Vl_Icms', 'VL_ICMS', tfNul);
  end;

  Result.Relacoes := TmRelacoes.Create;
  with Result.Relacoes do begin
  end;
end;

//--

{ TFis_Nfs }

function TFis_Nfs.Add: TFis_Nf;
begin
  Result := TFis_Nf.Create(nil);
  Self.Add(Result);
end;

end.