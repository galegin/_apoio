unit uTraTransacao;

interface

uses
  Classes, SysUtils,
  System.Generics.Collections,
  mMapping;

type
  [Tabela('TRA_TRANSACAO')]
  TTra_Transacao = class(TmMapping)
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
    [Campo('CD_PESSOA', tfReq)]
    property Cd_Pessoa : String read fCd_Pessoa write fCd_Pessoa;
    [Campo('CD_OPERACAO', tfReq)]
    property Cd_Operacao : String read fCd_Operacao write fCd_Operacao;
    [Campo('CD_CONDPGTO', tfReq)]
    property Cd_Condpgto : String read fCd_Condpgto write fCd_Condpgto;
    [Campo('CD_EMPFAT', tfReq)]
    property Cd_Empfat : String read fCd_Empfat write fCd_Empfat;
    [Campo('CD_GRUPOEMPRESA', tfReq)]
    property Cd_Grupoempresa : String read fCd_Grupoempresa write fCd_Grupoempresa;
    [Campo('CD_MODELOTRA', tfNul)]
    property Cd_Modelotra : String read fCd_Modelotra write fCd_Modelotra;
    [Campo('CD_OPERADOR', tfReq)]
    property Cd_Operador : String read fCd_Operador write fCd_Operador;
    [Campo('DT_CADASTRO', tfReq)]
    property Dt_Cadastro : String read fDt_Cadastro write fDt_Cadastro;
    [Campo('TP_SITUACAO', tfReq)]
    property Tp_Situacao : String read fTp_Situacao write fTp_Situacao;
    [Campo('TP_ORIGEMEMISSAO', tfReq)]
    property Tp_Origememissao : String read fTp_Origememissao write fTp_Origememissao;
    [Campo('NR_SEQENDERECO', tfReq)]
    property Nr_Seqendereco : String read fNr_Seqendereco write fNr_Seqendereco;
    [Campo('CD_EMPRESAORI', tfNul)]
    property Cd_Empresaori : String read fCd_Empresaori write fCd_Empresaori;
    [Campo('NR_TRANSACAOORI', tfNul)]
    property Nr_Transacaoori : String read fNr_Transacaoori write fNr_Transacaoori;
    [Campo('DT_TRANSACAOORI', tfNul)]
    property Dt_Transacaoori : String read fDt_Transacaoori write fDt_Transacaoori;
    [Campo('CD_USURELAC', tfNul)]
    property Cd_Usurelac : String read fCd_Usurelac write fCd_Usurelac;
    [Campo('CD_USUCONF', tfNul)]
    property Cd_Usuconf : String read fCd_Usuconf write fCd_Usuconf;
    [Campo('CD_GUIA', tfNul)]
    property Cd_Guia : String read fCd_Guia write fCd_Guia;
    [Campo('CD_REPRESENTANT', tfNul)]
    property Cd_Representant : String read fCd_Representant write fCd_Representant;
    [Campo('CD_COMPVEND', tfNul)]
    property Cd_Compvend : String read fCd_Compvend write fCd_Compvend;
    [Campo('CD_USUIMPRESSAO', tfNul)]
    property Cd_Usuimpressao : String read fCd_Usuimpressao write fCd_Usuimpressao;
    [Campo('DT_IMPRESSAO', tfNul)]
    property Dt_Impressao : String read fDt_Impressao write fDt_Impressao;
    [Campo('NR_IMPRESSAO', tfNul)]
    property Nr_Impressao : String read fNr_Impressao write fNr_Impressao;
    [Campo('TP_OPERACAO', tfNul)]
    property Tp_Operacao : String read fTp_Operacao write fTp_Operacao;
    [Campo('IN_FRETE', tfNul)]
    property In_Frete : String read fIn_Frete write fIn_Frete;
    [Campo('IN_ACEITADEV', tfNul)]
    property In_Aceitadev : String read fIn_Aceitadev write fIn_Aceitadev;
    [Campo('PR_DESCONTO', tfNul)]
    property Pr_Desconto : String read fPr_Desconto write fPr_Desconto;
    [Campo('QT_SOLICITADA', tfNul)]
    property Qt_Solicitada : String read fQt_Solicitada write fQt_Solicitada;
    [Campo('DT_PREVENTREGA', tfNul)]
    property Dt_Preventrega : String read fDt_Preventrega write fDt_Preventrega;
    [Campo('DT_VALIDADE', tfNul)]
    property Dt_Validade : String read fDt_Validade write fDt_Validade;
    [Campo('DT_ULTATEND', tfNul)]
    property Dt_Ultatend : String read fDt_Ultatend write fDt_Ultatend;
    [Campo('VL_TRANSACAO', tfNul)]
    property Vl_Transacao : String read fVl_Transacao write fVl_Transacao;
    [Campo('VL_DESCONTO', tfNul)]
    property Vl_Desconto : String read fVl_Desconto write fVl_Desconto;
    [Campo('VL_DESPACESSOR', tfNul)]
    property Vl_Despacessor : String read fVl_Despacessor write fVl_Despacessor;
    [Campo('VL_FRETE', tfNul)]
    property Vl_Frete : String read fVl_Frete write fVl_Frete;
    [Campo('VL_SEGURO', tfNul)]
    property Vl_Seguro : String read fVl_Seguro write fVl_Seguro;
    [Campo('VL_BASEICMS', tfNul)]
    property Vl_Baseicms : String read fVl_Baseicms write fVl_Baseicms;
    [Campo('VL_ICMS', tfNul)]
    property Vl_Icms : String read fVl_Icms write fVl_Icms;
    [Campo('VL_BASEICMSSUBST', tfNul)]
    property Vl_Baseicmssubst : String read fVl_Baseicmssubst write fVl_Baseicmssubst;
    [Campo('VL_ICMSSUBST', tfNul)]
    property Vl_Icmssubst : String read fVl_Icmssubst write fVl_Icmssubst;
    [Campo('VL_IPI', tfNul)]
    property Vl_Ipi : String read fVl_Ipi write fVl_Ipi;
    [Campo('VL_TOTAL', tfNul)]
    property Vl_Total : String read fVl_Total write fVl_Total;
  end;

  TTra_Transacaos = class(TList<Tra_Transacao>);

implementation

{ TTra_Transacao }

constructor TTra_Transacao.Create(AOwner: TComponent);
begin
  inherited;

end;

destructor TTra_Transacao.Destroy;
begin

  inherited;
end;

end.