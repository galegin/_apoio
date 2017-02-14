unit uTefReltransacao;

interface

uses
  Classes, SysUtils,
  cCollection, cCollectionItem;

type
  TTef_Reltransacao = class;
  TTef_ReltransacaoClass = class of TTef_Reltransacao;

  TTef_ReltransacaoList = class;
  TTef_ReltransacaoListClass = class of TTef_ReltransacaoList;

  TTef_Reltransacao = class(TcCollectionItem)
  private
    fCd_Emptef: Real;
    fDt_Movimento: TDateTime;
    fNr_Seq: Real;
    fCd_Emptra: Real;
    fNr_Transacao: Real;
    fDt_Transacao: TDateTime;
    fU_Version: String;
    fCd_Operador: Real;
    fDt_Cadastro: TDateTime;
  public
    constructor Create; reintroduce;
    destructor Destroy; override;
  published
    property Cd_Emptef : Real read fCd_Emptef write fCd_Emptef;
    property Dt_Movimento : TDateTime read fDt_Movimento write fDt_Movimento;
    property Nr_Seq : Real read fNr_Seq write fNr_Seq;
    property Cd_Emptra : Real read fCd_Emptra write fCd_Emptra;
    property Nr_Transacao : Real read fNr_Transacao write fNr_Transacao;
    property Dt_Transacao : TDateTime read fDt_Transacao write fDt_Transacao;
    property U_Version : String read fU_Version write fU_Version;
    property Cd_Operador : Real read fCd_Operador write fCd_Operador;
    property Dt_Cadastro : TDateTime read fDt_Cadastro write fDt_Cadastro;
  end;

  TTef_ReltransacaoList = class(TcCollection)
  private
    function GetItem(Index: Integer): TTef_Reltransacao;
    procedure SetItem(Index: Integer; Value: TTef_Reltransacao);
  public
    constructor Create(AOwner: TPersistent);
    function Add: TTef_Reltransacao;
    property Items[Index: Integer]: TTef_Reltransacao read GetItem write SetItem; default;
  end;
  
implementation

{ TTef_Reltransacao }

constructor TTef_Reltransacao.Create;
begin

end;

destructor TTef_Reltransacao.Destroy;
begin

  inherited;
end;

{ TTef_ReltransacaoList }

constructor TTef_ReltransacaoList.Create(AOwner: TPersistent);
begin
  inherited Create(TTef_Reltransacao);
end;

function TTef_ReltransacaoList.Add: TTef_Reltransacao;
begin
  Result := TTef_Reltransacao(inherited Add);
  Result.create;
end;

function TTef_ReltransacaoList.GetItem(Index: Integer): TTef_Reltransacao;
begin
  Result := TTef_Reltransacao(inherited GetItem(Index));
end;

procedure TTef_ReltransacaoList.SetItem(Index: Integer; Value: TTef_Reltransacao);
begin
  inherited SetItem(Index, Value);
end;

end.