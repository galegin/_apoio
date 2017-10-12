unit uTefReltransacao;

interface

uses
  Classes, SysUtils,
  mCollection, mCollectionItem;

type
  TTef_Reltransacao = class;
  TTef_ReltransacaoClass = class of TTef_Reltransacao;

  TTef_ReltransacaoList = class;
  TTef_ReltransacaoListClass = class of TTef_ReltransacaoList;

  TTef_Reltransacao = class(TmCollectionItem)
  private
    fCd_Emptef: String;
    fDt_Movimento: String;
    fNr_Seq: String;
    fCd_Emptra: String;
    fNr_Transacao: String;
    fDt_Transacao: String;
    fU_Version: String;
    fCd_Operador: String;
    fDt_Cadastro: String;
  public
    constructor Create(ACollection: TCollection); override;
    destructor Destroy; override;
  published
    property Cd_Emptef : String read fCd_Emptef write SetCd_Emptef;
    property Dt_Movimento : String read fDt_Movimento write SetDt_Movimento;
    property Nr_Seq : String read fNr_Seq write SetNr_Seq;
    property Cd_Emptra : String read fCd_Emptra write SetCd_Emptra;
    property Nr_Transacao : String read fNr_Transacao write SetNr_Transacao;
    property Dt_Transacao : String read fDt_Transacao write SetDt_Transacao;
    property U_Version : String read fU_Version write SetU_Version;
    property Cd_Operador : String read fCd_Operador write SetCd_Operador;
    property Dt_Cadastro : String read fDt_Cadastro write SetDt_Cadastro;
  end;

  TTef_ReltransacaoList = class(TmCollection)
  private
    function GetItem(Index: Integer): TTef_Reltransacao;
    procedure SetItem(Index: Integer; Value: TTef_Reltransacao);
  public
    constructor Create(AOwner: TPersistentCollection);
    function Add: TTef_Reltransacao;
    property Items[Index: Integer]: TTef_Reltransacao read GetItem write SetItem; default;
  end;

implementation

{ TTef_Reltransacao }

constructor TTef_Reltransacao.Create(ACollection: TCollection);
begin
  inherited;

end;

destructor TTef_Reltransacao.Destroy;
begin

  inherited;
end;

{ TTef_ReltransacaoList }

constructor TTef_ReltransacaoList.Create(AOwner: TPersistentCollection);
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