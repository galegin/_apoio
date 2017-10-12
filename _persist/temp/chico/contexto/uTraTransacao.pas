unit uTraTransacao;

interface

uses
  Classes, SysUtils,
  mMapping;

type
  TTra_Transacao = class(TmMapping)
  private
    fCd_Empresa: String;
    fNr_Transacao: String;
    fDt_Transacao: String;
    fU_Version: String;
    fCd_Pessoa: String;
    fCd_Operacao: String;
    fCd_Condpgto: String;
    fCd_Empfat: String;
    fCd_Grupoempresa: String;
    fCd_Modelotra: String;
    fCd_Operador: String;
    fDt_Cadastro: String;
    fTp_Situacao: String;
    fTp_Origememissao: String;
    fNr_Seqendereco: String;
    fCd_Empresaori: String;
    fNr_Transacaoori: String;
    fDt_Transacaoori: String;
    fCd_Usurelac: String;
    fCd_Usuconf: String;
    fCd_Guia: String;
    fCd_Representant: String;
    fCd_Compvend: String;
    fCd_Usuimpressao: String;
    fDt_Impressao: String;
    fNr_Impressao: String;
    fTp_Operacao: String;
    fIn_Frete: String;
    fIn_Aceitadev: String;
    fPr_Desconto: String;
    fQt_Solicitada: String;
    fDt_Preventrega: String;
    fDt_Validade: String;
    fDt_Ultatend: String;
    fVl_Transacao: String;
    fVl_Desconto: String;
    fVl_Despacessor: String;
    fVl_Frete: String;
    fVl_Seguro: String;
    fVl_Baseicms: String;
    fVl_Icms: String;
    fVl_Baseicmssubst: String;
    fVl_Icmssubst: String;
    fVl_Ipi: String;
    fVl_Total: String;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function GetMapping() : PmMapping; override;
  published
    property Cd_Empresa : String read fCd_Empresa write fCd_Empresa;
    property Nr_Transacao : String read fNr_Transacao write fNr_Transacao;
    property Dt_Transacao : String read fDt_Transacao write fDt_Transacao;
    property U_Version : String read fU_Version write fU_Version;
    property Cd_Pessoa : String read fCd_Pessoa write fCd_Pessoa;
    property Cd_Operacao : String read fCd_Operacao write fCd_Operacao;
    property Cd_Condpgto : String read fCd_Condpgto write fCd_Condpgto;
    property Cd_Empfat : String read fCd_Empfat write fCd_Empfat;
    property Cd_Grupoempresa : String read fCd_Grupoempresa write fCd_Grupoempresa;
    property Cd_Modelotra : String read fCd_Modelotra write fCd_Modelotra;
    property Cd_Operador : String read fCd_Operador write fCd_Operador;
    property Dt_Cadastro : String read fDt_Cadastro write fDt_Cadastro;
    property Tp_Situacao : String read fTp_Situacao write fTp_Situacao;
    property Tp_Origememissao : String read fTp_Origememissao write fTp_Origememissao;
    property Nr_Seqendereco : String read fNr_Seqendereco write fNr_Seqendereco;
    property Cd_Empresaori : String read fCd_Empresaori write fCd_Empresaori;
    property Nr_Transacaoori : String read fNr_Transacaoori write fNr_Transacaoori;
    property Dt_Transacaoori : String read fDt_Transacaoori write fDt_Transacaoori;
    property Cd_Usurelac : String read fCd_Usurelac write fCd_Usurelac;
    property Cd_Usuconf : String read fCd_Usuconf write fCd_Usuconf;
    property Cd_Guia : String read fCd_Guia write fCd_Guia;
    property Cd_Representant : String read fCd_Representant write fCd_Representant;
    property Cd_Compvend : String read fCd_Compvend write fCd_Compvend;
    property Cd_Usuimpressao : String read fCd_Usuimpressao write fCd_Usuimpressao;
    property Dt_Impressao : String read fDt_Impressao write fDt_Impressao;
    property Nr_Impressao : String read fNr_Impressao write fNr_Impressao;
    property Tp_Operacao : String read fTp_Operacao write fTp_Operacao;
    property In_Frete : String read fIn_Frete write fIn_Frete;
    property In_Aceitadev : String read fIn_Aceitadev write fIn_Aceitadev;
    property Pr_Desconto : String read fPr_Desconto write fPr_Desconto;
    property Qt_Solicitada : String read fQt_Solicitada write fQt_Solicitada;
    property Dt_Preventrega : String read fDt_Preventrega write fDt_Preventrega;
    property Dt_Validade : String read fDt_Validade write fDt_Validade;
    property Dt_Ultatend : String read fDt_Ultatend write fDt_Ultatend;
    property Vl_Transacao : String read fVl_Transacao write fVl_Transacao;
    property Vl_Desconto : String read fVl_Desconto write fVl_Desconto;
    property Vl_Despacessor : String read fVl_Despacessor write fVl_Despacessor;
    property Vl_Frete : String read fVl_Frete write fVl_Frete;
    property Vl_Seguro : String read fVl_Seguro write fVl_Seguro;
    property Vl_Baseicms : String read fVl_Baseicms write fVl_Baseicms;
    property Vl_Icms : String read fVl_Icms write fVl_Icms;
    property Vl_Baseicmssubst : String read fVl_Baseicmssubst write fVl_Baseicmssubst;
    property Vl_Icmssubst : String read fVl_Icmssubst write fVl_Icmssubst;
    property Vl_Ipi : String read fVl_Ipi write fVl_Ipi;
    property Vl_Total : String read fVl_Total write fVl_Total;
  end;

  TTra_Transacaos = class(TList)
  public
    function Add: TTra_Transacao; overload;
  end;

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

//--

function TTra_Transacao.GetMapping: PmMapping;
begin
  Result := New(PmMapping);

  Result.Tabela := New(PmTabela);
  with Result.Tabela^ do begin
    Nome := 'TRA_TRANSACAO';
  end;

  Result.Campos := TmCampos.Create;
  with Result.Campos do begin
    Add('Cd_Empresa', 'CD_EMPRESA', tfKey);
    Add('Nr_Transacao', 'NR_TRANSACAO', tfKey);
    Add('Dt_Transacao', 'DT_TRANSACAO', tfKey);
    Add('U_Version', 'U_VERSION', tfNul);
    Add('Cd_Pessoa', 'CD_PESSOA', tfReq);
    Add('Cd_Operacao', 'CD_OPERACAO', tfReq);
    Add('Cd_Condpgto', 'CD_CONDPGTO', tfReq);
    Add('Cd_Empfat', 'CD_EMPFAT', tfReq);
    Add('Cd_Grupoempresa', 'CD_GRUPOEMPRESA', tfReq);
    Add('Cd_Modelotra', 'CD_MODELOTRA', tfNul);
    Add('Cd_Operador', 'CD_OPERADOR', tfReq);
    Add('Dt_Cadastro', 'DT_CADASTRO', tfReq);
    Add('Tp_Situacao', 'TP_SITUACAO', tfReq);
    Add('Tp_Origememissao', 'TP_ORIGEMEMISSAO', tfReq);
    Add('Nr_Seqendereco', 'NR_SEQENDERECO', tfReq);
    Add('Cd_Empresaori', 'CD_EMPRESAORI', tfNul);
    Add('Nr_Transacaoori', 'NR_TRANSACAOORI', tfNul);
    Add('Dt_Transacaoori', 'DT_TRANSACAOORI', tfNul);
    Add('Cd_Usurelac', 'CD_USURELAC', tfNul);
    Add('Cd_Usuconf', 'CD_USUCONF', tfNul);
    Add('Cd_Guia', 'CD_GUIA', tfNul);
    Add('Cd_Representant', 'CD_REPRESENTANT', tfNul);
    Add('Cd_Compvend', 'CD_COMPVEND', tfNul);
    Add('Cd_Usuimpressao', 'CD_USUIMPRESSAO', tfNul);
    Add('Dt_Impressao', 'DT_IMPRESSAO', tfNul);
    Add('Nr_Impressao', 'NR_IMPRESSAO', tfNul);
    Add('Tp_Operacao', 'TP_OPERACAO', tfNul);
    Add('In_Frete', 'IN_FRETE', tfNul);
    Add('In_Aceitadev', 'IN_ACEITADEV', tfNul);
    Add('Pr_Desconto', 'PR_DESCONTO', tfNul);
    Add('Qt_Solicitada', 'QT_SOLICITADA', tfNul);
    Add('Dt_Preventrega', 'DT_PREVENTREGA', tfNul);
    Add('Dt_Validade', 'DT_VALIDADE', tfNul);
    Add('Dt_Ultatend', 'DT_ULTATEND', tfNul);
    Add('Vl_Transacao', 'VL_TRANSACAO', tfNul);
    Add('Vl_Desconto', 'VL_DESCONTO', tfNul);
    Add('Vl_Despacessor', 'VL_DESPACESSOR', tfNul);
    Add('Vl_Frete', 'VL_FRETE', tfNul);
    Add('Vl_Seguro', 'VL_SEGURO', tfNul);
    Add('Vl_Baseicms', 'VL_BASEICMS', tfNul);
    Add('Vl_Icms', 'VL_ICMS', tfNul);
    Add('Vl_Baseicmssubst', 'VL_BASEICMSSUBST', tfNul);
    Add('Vl_Icmssubst', 'VL_ICMSSUBST', tfNul);
    Add('Vl_Ipi', 'VL_IPI', tfNul);
    Add('Vl_Total', 'VL_TOTAL', tfNul);
  end;

  Result.Relacoes := TmRelacoes.Create;
  with Result.Relacoes do begin
  end;
end;

//--

{ TTra_Transacaos }

function TTra_Transacaos.Add: TTra_Transacao;
begin
  Result := TTra_Transacao.Create(nil);
  Self.Add(Result);
end;

end.