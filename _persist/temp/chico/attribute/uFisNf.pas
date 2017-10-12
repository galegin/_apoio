unit uFisNf;

interface

uses
  Classes, SysUtils,
  System.Generics.Collections,
  mMapping;

type
  [Tabela('FIS_NF')]
  TFis_Nf = class(TmMapping)
  private
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
  published
    [Campo('CD_EMPRESA', tfKey)]
    property Cd_Empresa : String read fCd_Empresa write fCd_Empresa;
    [Campo('NR_FATURA', tfKey)]
    property Nr_Fatura : String read fNr_Fatura write fNr_Fatura;
    [Campo('DT_FATURA', tfKey)]
    property Dt_Fatura : String read fDt_Fatura write fDt_Fatura;
    [Campo('U_VERSION', tfNul)]
    property U_Version : String read fU_Version write fU_Version;
    [Campo('CD_PESSOA', tfReq)]
    property Cd_Pessoa : String read fCd_Pessoa write fCd_Pessoa;
    [Campo('CD_EMPFAT', tfReq)]
    property Cd_Empfat : String read fCd_Empfat write fCd_Empfat;
    [Campo('CD_GRUPOEMPRESA', tfReq)]
    property Cd_Grupoempresa : String read fCd_Grupoempresa write fCd_Grupoempresa;
    [Campo('CD_OPERADOR', tfReq)]
    property Cd_Operador : String read fCd_Operador write fCd_Operador;
    [Campo('DT_CADASTRO', tfReq)]
    property Dt_Cadastro : String read fDt_Cadastro write fDt_Cadastro;
    [Campo('NR_NF', tfNul)]
    property Nr_Nf : String read fNr_Nf write fNr_Nf;
    [Campo('CD_SERIE', tfNul)]
    property Cd_Serie : String read fCd_Serie write fCd_Serie;
    [Campo('DT_EMISSAO', tfNul)]
    property Dt_Emissao : String read fDt_Emissao write fDt_Emissao;
    [Campo('TP_ORIGEMEMISSAO', tfReq)]
    property Tp_Origememissao : String read fTp_Origememissao write fTp_Origememissao;
    [Campo('TP_MODDCTOFISCAL', tfReq)]
    property Tp_Moddctofiscal : String read fTp_Moddctofiscal write fTp_Moddctofiscal;
    [Campo('TP_OPERACAO', tfReq)]
    property Tp_Operacao : String read fTp_Operacao write fTp_Operacao;
    [Campo('TP_SITUACAO', tfReq)]
    property Tp_Situacao : String read fTp_Situacao write fTp_Situacao;
    [Campo('CD_EMPRESAORI', tfReq)]
    property Cd_Empresaori : String read fCd_Empresaori write fCd_Empresaori;
    [Campo('NR_TRANSACAOORI', tfReq)]
    property Nr_Transacaoori : String read fNr_Transacaoori write fNr_Transacaoori;
    [Campo('DT_TRANSACAOORI', tfReq)]
    property Dt_Transacaoori : String read fDt_Transacaoori write fDt_Transacaoori;
    [Campo('CD_OPERACAO', tfNul)]
    property Cd_Operacao : String read fCd_Operacao write fCd_Operacao;
    [Campo('CD_CONDPGTO', tfNul)]
    property Cd_Condpgto : String read fCd_Condpgto write fCd_Condpgto;
    [Campo('CD_MODELONF', tfNul)]
    property Cd_Modelonf : String read fCd_Modelonf write fCd_Modelonf;
    [Campo('NR_PRE', tfNul)]
    property Nr_Pre : String read fNr_Pre write fNr_Pre;
    [Campo('HR_SAIDA', tfNul)]
    property Hr_Saida : String read fHr_Saida write fHr_Saida;
    [Campo('DT_SAIDAENTRADA', tfNul)]
    property Dt_Saidaentrada : String read fDt_Saidaentrada write fDt_Saidaentrada;
    [Campo('CD_COMPVEND', tfNul)]
    property Cd_Compvend : String read fCd_Compvend write fCd_Compvend;
    [Campo('IN_FRETE', tfNul)]
    property In_Frete : String read fIn_Frete write fIn_Frete;
    [Campo('CD_USUIMPRESSAO', tfNul)]
    property Cd_Usuimpressao : String read fCd_Usuimpressao write fCd_Usuimpressao;
    [Campo('DT_IMPRESSAO', tfNul)]
    property Dt_Impressao : String read fDt_Impressao write fDt_Impressao;
    [Campo('NR_IMPRESSAO', tfNul)]
    property Nr_Impressao : String read fNr_Impressao write fNr_Impressao;
    [Campo('PR_DESCONTO', tfNul)]
    property Pr_Desconto : String read fPr_Desconto write fPr_Desconto;
    [Campo('QT_FATURADO', tfNul)]
    property Qt_Faturado : String read fQt_Faturado write fQt_Faturado;
    [Campo('VL_TOTALPRODUTO', tfNul)]
    property Vl_Totalproduto : String read fVl_Totalproduto write fVl_Totalproduto;
    [Campo('VL_DESPACESSOR', tfNul)]
    property Vl_Despacessor : String read fVl_Despacessor write fVl_Despacessor;
    [Campo('VL_FRETE', tfNul)]
    property Vl_Frete : String read fVl_Frete write fVl_Frete;
    [Campo('VL_SEGURO', tfNul)]
    property Vl_Seguro : String read fVl_Seguro write fVl_Seguro;
    [Campo('VL_IPI', tfNul)]
    property Vl_Ipi : String read fVl_Ipi write fVl_Ipi;
    [Campo('VL_DESCONTO', tfNul)]
    property Vl_Desconto : String read fVl_Desconto write fVl_Desconto;
    [Campo('VL_TOTALNOTA', tfNul)]
    property Vl_Totalnota : String read fVl_Totalnota write fVl_Totalnota;
    [Campo('VL_BASEICMSSUBS', tfNul)]
    property Vl_Baseicmssubs : String read fVl_Baseicmssubs write fVl_Baseicmssubs;
    [Campo('VL_ICMSSUBST', tfNul)]
    property Vl_Icmssubst : String read fVl_Icmssubst write fVl_Icmssubst;
    [Campo('VL_BASEICMS', tfNul)]
    property Vl_Baseicms : String read fVl_Baseicms write fVl_Baseicms;
    [Campo('VL_ICMS', tfNul)]
    property Vl_Icms : String read fVl_Icms write fVl_Icms;
  end;

  TFis_Nfs = class(TList<Fis_Nf>);

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

end.