unit uTransacao;

interface

uses
  Classes, SysUtils,
  mCollection, mCollectionItem;

type
  TTransacao = class;
  TTransacaoClass = class of TTransacao;

  TTransacaoList = class;
  TTransacaoListClass = class of TTransacaoList;

  TTransacao = class(TmCollectionItem)
  private
    fId_Transacao: String;
    fU_Version: String;
    fCd_Operador: Integer;
    fDt_Cadastro: String;
    fId_Empresa: Integer;
    fId_Pessoa: String;
    fId_Operacao: String;
    fDt_Transacao: String;
    fNr_Transacao: Integer;
    fTp_Situacao: Integer;
    fDt_Cancelamento: String;
  public
    constructor Create(ACollection: TCollection); override;
    destructor Destroy; override;
  published
    property Id_Transacao : String read fId_Transacao write SetId_Transacao;
    property U_Version : String read fU_Version write SetU_Version;
    property Cd_Operador : Integer read fCd_Operador write SetCd_Operador;
    property Dt_Cadastro : String read fDt_Cadastro write SetDt_Cadastro;
    property Id_Empresa : Integer read fId_Empresa write SetId_Empresa;
    property Id_Pessoa : String read fId_Pessoa write SetId_Pessoa;
    property Id_Operacao : String read fId_Operacao write SetId_Operacao;
    property Dt_Transacao : String read fDt_Transacao write SetDt_Transacao;
    property Nr_Transacao : Integer read fNr_Transacao write SetNr_Transacao;
    property Tp_Situacao : Integer read fTp_Situacao write SetTp_Situacao;
    property Dt_Cancelamento : String read fDt_Cancelamento write SetDt_Cancelamento;
  end;

  TTransacaoList = class(TmCollection)
  private
    function GetItem(Index: Integer): TTransacao;
    procedure SetItem(Index: Integer; Value: TTransacao);
  public
    constructor Create(AOwner: TPersistentCollection);
    function Add: TTransacao;
    property Items[Index: Integer]: TTransacao read GetItem write SetItem; default;
  end;

implementation

{ TTransacao }

constructor TTransacao.Create(ACollection: TCollection);
begin
  inherited;

end;

destructor TTransacao.Destroy;
begin

  inherited;
end;

{ TTransacaoList }

constructor TTransacaoList.Create(AOwner: TPersistentCollection);
begin
  inherited Create(TTransacao);
end;

function TTransacaoList.Add: TTransacao;
begin
  Result := TTransacao(inherited Add);
  Result.create;
end;

function TTransacaoList.GetItem(Index: Integer): TTransacao;
begin
  Result := TTransacao(inherited GetItem(Index));
end;

procedure TTransacaoList.SetItem(Index: Integer; Value: TTransacao);
begin
  inherited SetItem(Index, Value);
end;

end.