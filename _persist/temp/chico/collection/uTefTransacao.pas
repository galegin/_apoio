unit uTefTransacao;

interface

uses
  Classes, SysUtils,
  mCollection, mCollectionItem;

type
  TTef_Transacao = class;
  TTef_TransacaoClass = class of TTef_Transacao;

  TTef_TransacaoList = class;
  TTef_TransacaoListClass = class of TTef_TransacaoList;

  TTef_Transacao = class(TmCollectionItem)
  private
    fCd_Empresa: String;
    fDt_Movimento: String;
    fNr_Seq: String;
    fU_Version: String;
    fCd_Operador: String;
    fDt_Cadastro: String;
    fCd_Arquivo: String;
    fTp_Tef: String;
    fTp_Situacao: String;
    fTp_Transacao: String;
    fCd_Redetef: String;
    fVl_Transacao: String;
    fHr_Transacao: String;
    fDt_Transacao: String;
    fNr_Nsu: String;
    fCd_Terminal: String;
    fNr_Docvinc: String;
    fNr_Nsuaux: String;
    fCd_Autorizacao: String;
    fNm_Redetef: String;
    fTp_Status: String;
    fDs_Finalizacao: String;
    fDs_Mensagem: String;
    fNr_Linhascupom: String;
    fDs_Cupom: String;
  public
    constructor Create(ACollection: TCollection); override;
    destructor Destroy; override;
  published
    property Cd_Empresa : String read fCd_Empresa write SetCd_Empresa;
    property Dt_Movimento : String read fDt_Movimento write SetDt_Movimento;
    property Nr_Seq : String read fNr_Seq write SetNr_Seq;
    property U_Version : String read fU_Version write SetU_Version;
    property Cd_Operador : String read fCd_Operador write SetCd_Operador;
    property Dt_Cadastro : String read fDt_Cadastro write SetDt_Cadastro;
    property Cd_Arquivo : String read fCd_Arquivo write SetCd_Arquivo;
    property Tp_Tef : String read fTp_Tef write SetTp_Tef;
    property Tp_Situacao : String read fTp_Situacao write SetTp_Situacao;
    property Tp_Transacao : String read fTp_Transacao write SetTp_Transacao;
    property Cd_Redetef : String read fCd_Redetef write SetCd_Redetef;
    property Vl_Transacao : String read fVl_Transacao write SetVl_Transacao;
    property Hr_Transacao : String read fHr_Transacao write SetHr_Transacao;
    property Dt_Transacao : String read fDt_Transacao write SetDt_Transacao;
    property Nr_Nsu : String read fNr_Nsu write SetNr_Nsu;
    property Cd_Terminal : String read fCd_Terminal write SetCd_Terminal;
    property Nr_Docvinc : String read fNr_Docvinc write SetNr_Docvinc;
    property Nr_Nsuaux : String read fNr_Nsuaux write SetNr_Nsuaux;
    property Cd_Autorizacao : String read fCd_Autorizacao write SetCd_Autorizacao;
    property Nm_Redetef : String read fNm_Redetef write SetNm_Redetef;
    property Tp_Status : String read fTp_Status write SetTp_Status;
    property Ds_Finalizacao : String read fDs_Finalizacao write SetDs_Finalizacao;
    property Ds_Mensagem : String read fDs_Mensagem write SetDs_Mensagem;
    property Nr_Linhascupom : String read fNr_Linhascupom write SetNr_Linhascupom;
    property Ds_Cupom : String read fDs_Cupom write SetDs_Cupom;
  end;

  TTef_TransacaoList = class(TmCollection)
  private
    function GetItem(Index: Integer): TTef_Transacao;
    procedure SetItem(Index: Integer; Value: TTef_Transacao);
  public
    constructor Create(AOwner: TPersistentCollection);
    function Add: TTef_Transacao;
    property Items[Index: Integer]: TTef_Transacao read GetItem write SetItem; default;
  end;

implementation

{ TTef_Transacao }

constructor TTef_Transacao.Create(ACollection: TCollection);
begin
  inherited;

end;

destructor TTef_Transacao.Destroy;
begin

  inherited;
end;

{ TTef_TransacaoList }

constructor TTef_TransacaoList.Create(AOwner: TPersistentCollection);
begin
  inherited Create(TTef_Transacao);
end;

function TTef_TransacaoList.Add: TTef_Transacao;
begin
  Result := TTef_Transacao(inherited Add);
  Result.create;
end;

function TTef_TransacaoList.GetItem(Index: Integer): TTef_Transacao;
begin
  Result := TTef_Transacao(inherited GetItem(Index));
end;

procedure TTef_TransacaoList.SetItem(Index: Integer; Value: TTef_Transacao);
begin
  inherited SetItem(Index, Value);
end;

end.