unit uTraTransacao;

interface

uses
  Classes, SysUtils,
  cCollection, cCollectionItem;

type
  TTra_Transacao = class;
  TTra_TransacaoClass = class of TTra_Transacao;

  TTra_TransacaoList = class;
  TTra_TransacaoListClass = class of TTra_TransacaoList;

  TTra_Transacao = class(TcCollectionItem)
  private
    fCd_Empresa: Real;
    fNr_Transacao: Real;
    fDt_Transacao: TDateTime;
    fU_Version: String;
    fCd_Pessoa: Real;
    fCd_Operacao: Real;
    fCd_Condpgto: Real;
    fCd_Empfat: Real;
    fCd_Grupoempresa: Real;
    fCd_Modelotra: Real;
    fCd_Operador: Real;
    fDt_Cadastro: TDateTime;
    fTp_Situacao: Real;
    fTp_Origememissao: String;
    fNr_Seqendereco: Real;
    fCd_Empresaori: Real;
    fNr_Transacaoori: Real;
    fDt_Transacaoori: TDateTime;
    fCd_Usurelac: Real;
    fCd_Usuconf: Real;
    fCd_Guia: Real;
    fCd_Representant: Real;
    fCd_Compvend: Real;
    fCd_Usuimpressao: Real;
    fDt_Impressao: TDateTime;
    fNr_Impressao: Real;
    fTp_Operacao: String;
    fIn_Frete: String;
    fIn_Aceitadev: String;
    fPr_Desconto: Real;
    fQt_Solicitada: Real;
    fDt_Preventrega: TDateTime;
    fDt_Validade: TDateTime;
    fDt_Ultatend: TDateTime;
    fVl_Transacao: Real;
    fVl_Desconto: Real;
    fVl_Despacessor: Real;
    fVl_Frete: Real;
    fVl_Seguro: Real;
    fVl_Baseicms: Real;
    fVl_Icms: Real;
    fVl_Baseicmssubst: Real;
    fVl_Icmssubst: Real;
    fVl_Ipi: Real;
    fVl_Total: Real;
  public
    constructor Create; reintroduce;
    destructor Destroy; override;
  published
    property Cd_Empresa : Real read fCd_Empresa write fCd_Empresa;
    property Nr_Transacao : Real read fNr_Transacao write fNr_Transacao;
    property Dt_Transacao : TDateTime read fDt_Transacao write fDt_Transacao;
    property U_Version : String read fU_Version write fU_Version;
    property Cd_Pessoa : Real read fCd_Pessoa write fCd_Pessoa;
    property Cd_Operacao : Real read fCd_Operacao write fCd_Operacao;
    property Cd_Condpgto : Real read fCd_Condpgto write fCd_Condpgto;
    property Cd_Empfat : Real read fCd_Empfat write fCd_Empfat;
    property Cd_Grupoempresa : Real read fCd_Grupoempresa write fCd_Grupoempresa;
    property Cd_Modelotra : Real read fCd_Modelotra write fCd_Modelotra;
    property Cd_Operador : Real read fCd_Operador write fCd_Operador;
    property Dt_Cadastro : TDateTime read fDt_Cadastro write fDt_Cadastro;
    property Tp_Situacao : Real read fTp_Situacao write fTp_Situacao;
    property Tp_Origememissao : String read fTp_Origememissao write fTp_Origememissao;
    property Nr_Seqendereco : Real read fNr_Seqendereco write fNr_Seqendereco;
    property Cd_Empresaori : Real read fCd_Empresaori write fCd_Empresaori;
    property Nr_Transacaoori : Real read fNr_Transacaoori write fNr_Transacaoori;
    property Dt_Transacaoori : TDateTime read fDt_Transacaoori write fDt_Transacaoori;
    property Cd_Usurelac : Real read fCd_Usurelac write fCd_Usurelac;
    property Cd_Usuconf : Real read fCd_Usuconf write fCd_Usuconf;
    property Cd_Guia : Real read fCd_Guia write fCd_Guia;
    property Cd_Representant : Real read fCd_Representant write fCd_Representant;
    property Cd_Compvend : Real read fCd_Compvend write fCd_Compvend;
    property Cd_Usuimpressao : Real read fCd_Usuimpressao write fCd_Usuimpressao;
    property Dt_Impressao : TDateTime read fDt_Impressao write fDt_Impressao;
    property Nr_Impressao : Real read fNr_Impressao write fNr_Impressao;
    property Tp_Operacao : String read fTp_Operacao write fTp_Operacao;
    property In_Frete : String read fIn_Frete write fIn_Frete;
    property In_Aceitadev : String read fIn_Aceitadev write fIn_Aceitadev;
    property Pr_Desconto : Real read fPr_Desconto write fPr_Desconto;
    property Qt_Solicitada : Real read fQt_Solicitada write fQt_Solicitada;
    property Dt_Preventrega : TDateTime read fDt_Preventrega write fDt_Preventrega;
    property Dt_Validade : TDateTime read fDt_Validade write fDt_Validade;
    property Dt_Ultatend : TDateTime read fDt_Ultatend write fDt_Ultatend;
    property Vl_Transacao : Real read fVl_Transacao write fVl_Transacao;
    property Vl_Desconto : Real read fVl_Desconto write fVl_Desconto;
    property Vl_Despacessor : Real read fVl_Despacessor write fVl_Despacessor;
    property Vl_Frete : Real read fVl_Frete write fVl_Frete;
    property Vl_Seguro : Real read fVl_Seguro write fVl_Seguro;
    property Vl_Baseicms : Real read fVl_Baseicms write fVl_Baseicms;
    property Vl_Icms : Real read fVl_Icms write fVl_Icms;
    property Vl_Baseicmssubst : Real read fVl_Baseicmssubst write fVl_Baseicmssubst;
    property Vl_Icmssubst : Real read fVl_Icmssubst write fVl_Icmssubst;
    property Vl_Ipi : Real read fVl_Ipi write fVl_Ipi;
    property Vl_Total : Real read fVl_Total write fVl_Total;
  end;

  TTra_TransacaoList = class(TcCollection)
  private
    function GetItem(Index: Integer): TTra_Transacao;
    procedure SetItem(Index: Integer; Value: TTra_Transacao);
  public
    constructor Create(AOwner: TPersistent);
    function Add: TTra_Transacao;
    property Items[Index: Integer]: TTra_Transacao read GetItem write SetItem; default;
  end;
  
implementation

{ TTra_Transacao }

constructor TTra_Transacao.Create;
begin

end;

destructor TTra_Transacao.Destroy;
begin

  inherited;
end;

{ TTra_TransacaoList }

constructor TTra_TransacaoList.Create(AOwner: TPersistent);
begin
  inherited Create(TTra_Transacao);
end;

function TTra_TransacaoList.Add: TTra_Transacao;
begin
  Result := TTra_Transacao(inherited Add);
  Result.create;
end;

function TTra_TransacaoList.GetItem(Index: Integer): TTra_Transacao;
begin
  Result := TTra_Transacao(inherited GetItem(Index));
end;

procedure TTra_TransacaoList.SetItem(Index: Integer; Value: TTra_Transacao);
begin
  inherited SetItem(Index, Value);
end;

end.