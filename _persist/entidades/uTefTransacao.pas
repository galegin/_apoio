unit uTefTransacao;

interface

uses
  Classes, SysUtils,
  cCollection, cCollectionItem;

type
  TTef_Transacao = class;
  TTef_TransacaoClass = class of TTef_Transacao;

  TTef_TransacaoList = class;
  TTef_TransacaoListClass = class of TTef_TransacaoList;

  TTef_Transacao = class(TcCollectionItem)
  private
    fCd_Empresa: Real;
    fDt_Movimento: TDateTime;
    fNr_Seq: Real;
    fU_Version: String;
    fCd_Operador: Real;
    fDt_Cadastro: TDateTime;
    fCd_Arquivo: String;
    fTp_Tef: Real;
    fTp_Situacao: Real;
    fTp_Transacao: Real;
    fCd_Redetef: Real;
    fVl_Transacao: Real;
    fHr_Transacao: TDateTime;
    fDt_Transacao: TDateTime;
    fNr_Nsu: Real;
    fCd_Terminal: Real;
    fNr_Docvinc: Real;
    fNr_Nsuaux: String;
    fCd_Autorizacao: Real;
    fNm_Redetef: String;
    fTp_Status: String;
    fDs_Finalizacao: String;
    fDs_Mensagem: String;
    fNr_Linhascupom: Real;
    fDs_Cupom: String;
  public
    constructor Create; reintroduce;
    destructor Destroy; override;
  published
    property Cd_Empresa : Real read fCd_Empresa write fCd_Empresa;
    property Dt_Movimento : TDateTime read fDt_Movimento write fDt_Movimento;
    property Nr_Seq : Real read fNr_Seq write fNr_Seq;
    property U_Version : String read fU_Version write fU_Version;
    property Cd_Operador : Real read fCd_Operador write fCd_Operador;
    property Dt_Cadastro : TDateTime read fDt_Cadastro write fDt_Cadastro;
    property Cd_Arquivo : String read fCd_Arquivo write fCd_Arquivo;
    property Tp_Tef : Real read fTp_Tef write fTp_Tef;
    property Tp_Situacao : Real read fTp_Situacao write fTp_Situacao;
    property Tp_Transacao : Real read fTp_Transacao write fTp_Transacao;
    property Cd_Redetef : Real read fCd_Redetef write fCd_Redetef;
    property Vl_Transacao : Real read fVl_Transacao write fVl_Transacao;
    property Hr_Transacao : TDateTime read fHr_Transacao write fHr_Transacao;
    property Dt_Transacao : TDateTime read fDt_Transacao write fDt_Transacao;
    property Nr_Nsu : Real read fNr_Nsu write fNr_Nsu;
    property Cd_Terminal : Real read fCd_Terminal write fCd_Terminal;
    property Nr_Docvinc : Real read fNr_Docvinc write fNr_Docvinc;
    property Nr_Nsuaux : String read fNr_Nsuaux write fNr_Nsuaux;
    property Cd_Autorizacao : Real read fCd_Autorizacao write fCd_Autorizacao;
    property Nm_Redetef : String read fNm_Redetef write fNm_Redetef;
    property Tp_Status : String read fTp_Status write fTp_Status;
    property Ds_Finalizacao : String read fDs_Finalizacao write fDs_Finalizacao;
    property Ds_Mensagem : String read fDs_Mensagem write fDs_Mensagem;
    property Nr_Linhascupom : Real read fNr_Linhascupom write fNr_Linhascupom;
    property Ds_Cupom : String read fDs_Cupom write fDs_Cupom;
  end;

  TTef_TransacaoList = class(TcCollection)
  private
    function GetItem(Index: Integer): TTef_Transacao;
    procedure SetItem(Index: Integer; Value: TTef_Transacao);
  public
    constructor Create(AOwner: TPersistent);
    function Add: TTef_Transacao;
    property Items[Index: Integer]: TTef_Transacao read GetItem write SetItem; default;
  end;
  
implementation

{ TTef_Transacao }

constructor TTef_Transacao.Create;
begin

end;

destructor TTef_Transacao.Destroy;
begin

  inherited;
end;

{ TTef_TransacaoList }

constructor TTef_TransacaoList.Create(AOwner: TPersistent);
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