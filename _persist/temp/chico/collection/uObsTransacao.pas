unit uObsTransacao;

interface

uses
  Classes, SysUtils,
  mCollection, mCollectionItem;

type
  TObs_Transacao = class;
  TObs_TransacaoClass = class of TObs_Transacao;

  TObs_TransacaoList = class;
  TObs_TransacaoListClass = class of TObs_TransacaoList;

  TObs_Transacao = class(TmCollectionItem)
  private
    fCd_Empresa: String;
    fNr_Transacao: String;
    fDt_Transacao: String;
    fNr_Linha: String;
    fU_Version: String;
    fCd_Operador: String;
    fDt_Cadastro: String;
    fIn_Manutencao: String;
    fCd_Componente: String;
    fDs_Observacao: String;
  public
    constructor Create(ACollection: TCollection); override;
    destructor Destroy; override;
  published
    property Cd_Empresa : String read fCd_Empresa write SetCd_Empresa;
    property Nr_Transacao : String read fNr_Transacao write SetNr_Transacao;
    property Dt_Transacao : String read fDt_Transacao write SetDt_Transacao;
    property Nr_Linha : String read fNr_Linha write SetNr_Linha;
    property U_Version : String read fU_Version write SetU_Version;
    property Cd_Operador : String read fCd_Operador write SetCd_Operador;
    property Dt_Cadastro : String read fDt_Cadastro write SetDt_Cadastro;
    property In_Manutencao : String read fIn_Manutencao write SetIn_Manutencao;
    property Cd_Componente : String read fCd_Componente write SetCd_Componente;
    property Ds_Observacao : String read fDs_Observacao write SetDs_Observacao;
  end;

  TObs_TransacaoList = class(TmCollection)
  private
    function GetItem(Index: Integer): TObs_Transacao;
    procedure SetItem(Index: Integer; Value: TObs_Transacao);
  public
    constructor Create(AOwner: TPersistentCollection);
    function Add: TObs_Transacao;
    property Items[Index: Integer]: TObs_Transacao read GetItem write SetItem; default;
  end;

implementation

{ TObs_Transacao }

constructor TObs_Transacao.Create(ACollection: TCollection);
begin
  inherited;

end;

destructor TObs_Transacao.Destroy;
begin

  inherited;
end;

{ TObs_TransacaoList }

constructor TObs_TransacaoList.Create(AOwner: TPersistentCollection);
begin
  inherited Create(TObs_Transacao);
end;

function TObs_TransacaoList.Add: TObs_Transacao;
begin
  Result := TObs_Transacao(inherited Add);
  Result.create;
end;

function TObs_TransacaoList.GetItem(Index: Integer): TObs_Transacao;
begin
  Result := TObs_Transacao(inherited GetItem(Index));
end;

procedure TObs_TransacaoList.SetItem(Index: Integer; Value: TObs_Transacao);
begin
  inherited SetItem(Index, Value);
end;

end.