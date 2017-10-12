unit uTraTransacao;

interface

uses
  Classes, SysUtils,
  mCollection, mCollectionItem;

type
  TTra_Transacao = class;
  TTra_TransacaoClass = class of TTra_Transacao;

  TTra_TransacaoList = class;
  TTra_TransacaoListClass = class of TTra_TransacaoList;

  TTra_Transacao = class(TmCollectionItem)
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
    constructor Create(ACollection: TCollection); override;
    destructor Destroy; override;
  published
    property Cd_Empresa : String read fCd_Empresa write SetCd_Empresa;
    property Nr_Transacao : String read fNr_Transacao write SetNr_Transacao;
    property Dt_Transacao : String read fDt_Transacao write SetDt_Transacao;
    property U_Version : String read fU_Version write SetU_Version;
    property Cd_Pessoa : String read fCd_Pessoa write SetCd_Pessoa;
    property Cd_Operacao : String read fCd_Operacao write SetCd_Operacao;
    property Cd_Condpgto : String read fCd_Condpgto write SetCd_Condpgto;
    property Cd_Empfat : String read fCd_Empfat write SetCd_Empfat;
    property Cd_Grupoempresa : String read fCd_Grupoempresa write SetCd_Grupoempresa;
    property Cd_Modelotra : String read fCd_Modelotra write SetCd_Modelotra;
    property Cd_Operador : String read fCd_Operador write SetCd_Operador;
    property Dt_Cadastro : String read fDt_Cadastro write SetDt_Cadastro;
    property Tp_Situacao : String read fTp_Situacao write SetTp_Situacao;
    property Tp_Origememissao : String read fTp_Origememissao write SetTp_Origememissao;
    property Nr_Seqendereco : String read fNr_Seqendereco write SetNr_Seqendereco;
    property Cd_Empresaori : String read fCd_Empresaori write SetCd_Empresaori;
    property Nr_Transacaoori : String read fNr_Transacaoori write SetNr_Transacaoori;
    property Dt_Transacaoori : String read fDt_Transacaoori write SetDt_Transacaoori;
    property Cd_Usurelac : String read fCd_Usurelac write SetCd_Usurelac;
    property Cd_Usuconf : String read fCd_Usuconf write SetCd_Usuconf;
    property Cd_Guia : String read fCd_Guia write SetCd_Guia;
    property Cd_Representant : String read fCd_Representant write SetCd_Representant;
    property Cd_Compvend : String read fCd_Compvend write SetCd_Compvend;
    property Cd_Usuimpressao : String read fCd_Usuimpressao write SetCd_Usuimpressao;
    property Dt_Impressao : String read fDt_Impressao write SetDt_Impressao;
    property Nr_Impressao : String read fNr_Impressao write SetNr_Impressao;
    property Tp_Operacao : String read fTp_Operacao write SetTp_Operacao;
    property In_Frete : String read fIn_Frete write SetIn_Frete;
    property In_Aceitadev : String read fIn_Aceitadev write SetIn_Aceitadev;
    property Pr_Desconto : String read fPr_Desconto write SetPr_Desconto;
    property Qt_Solicitada : String read fQt_Solicitada write SetQt_Solicitada;
    property Dt_Preventrega : String read fDt_Preventrega write SetDt_Preventrega;
    property Dt_Validade : String read fDt_Validade write SetDt_Validade;
    property Dt_Ultatend : String read fDt_Ultatend write SetDt_Ultatend;
    property Vl_Transacao : String read fVl_Transacao write SetVl_Transacao;
    property Vl_Desconto : String read fVl_Desconto write SetVl_Desconto;
    property Vl_Despacessor : String read fVl_Despacessor write SetVl_Despacessor;
    property Vl_Frete : String read fVl_Frete write SetVl_Frete;
    property Vl_Seguro : String read fVl_Seguro write SetVl_Seguro;
    property Vl_Baseicms : String read fVl_Baseicms write SetVl_Baseicms;
    property Vl_Icms : String read fVl_Icms write SetVl_Icms;
    property Vl_Baseicmssubst : String read fVl_Baseicmssubst write SetVl_Baseicmssubst;
    property Vl_Icmssubst : String read fVl_Icmssubst write SetVl_Icmssubst;
    property Vl_Ipi : String read fVl_Ipi write SetVl_Ipi;
    property Vl_Total : String read fVl_Total write SetVl_Total;
  end;

  TTra_TransacaoList = class(TmCollection)
  private
    function GetItem(Index: Integer): TTra_Transacao;
    procedure SetItem(Index: Integer; Value: TTra_Transacao);
  public
    constructor Create(AOwner: TPersistentCollection);
    function Add: TTra_Transacao;
    property Items[Index: Integer]: TTra_Transacao read GetItem write SetItem; default;
  end;

implementation

{ TTra_Transacao }

constructor TTra_Transacao.Create(ACollection: TCollection);
begin
  inherited;

end;

destructor TTra_Transacao.Destroy;
begin

  inherited;
end;

{ TTra_TransacaoList }

constructor TTra_TransacaoList.Create(AOwner: TPersistentCollection);
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