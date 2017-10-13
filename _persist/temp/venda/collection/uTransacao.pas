unit uTransacao;

interface

uses
  Classes, SysUtils,
  mCollection, mCollectionItem;

type
  TTransacao = class(TmCollectionItem)
  private
    fId_Transacao: String;
    fU_Version: String;
    fCd_Operador: Integer;
    fDt_Cadastro: TDateTime;
    fId_Empresa: Integer;
    fId_Pessoa: String;
    fId_Operacao: String;
    fDt_Transacao: TDateTime;
    fNr_Transacao: Integer;
    fTp_Situacao: Integer;
    fDt_Cancelamento: TDateTime;
  public
    constructor Create(ACollection: TCollection); override;
    destructor Destroy; override;
  published
    property Id_Transacao : String read fId_Transacao write fId_Transacao;
    property U_Version : String read fU_Version write fU_Version;
    property Cd_Operador : Integer read fCd_Operador write fCd_Operador;
    property Dt_Cadastro : TDateTime read fDt_Cadastro write fDt_Cadastro;
    property Id_Empresa : Integer read fId_Empresa write fId_Empresa;
    property Id_Pessoa : String read fId_Pessoa write fId_Pessoa;
    property Id_Operacao : String read fId_Operacao write fId_Operacao;
    property Dt_Transacao : TDateTime read fDt_Transacao write fDt_Transacao;
    property Nr_Transacao : Integer read fNr_Transacao write fNr_Transacao;
    property Tp_Situacao : Integer read fTp_Situacao write fTp_Situacao;
    property Dt_Cancelamento : TDateTime read fDt_Cancelamento write fDt_Cancelamento;
  end;

  TTransacaos = class(TmCollection)
  private
    function GetItem(Index: Integer): TTransacao;
    procedure SetItem(Index: Integer; Value: TTransacao);
  public
    constructor Create(AItemClass: TCollectionItemClass); override;
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

{ TTransacaos }

constructor TTransacaos.Create(AItemClass: TCollectionItemClass);
begin
  inherited Create(TTransacao);
end;

function TTransacaos.Add: TTransacao;
begin
  Result := TTransacao(inherited Add);
end;

function TTransacaos.GetItem(Index: Integer): TTransacao;
begin
  Result := TTransacao(inherited GetItem(Index));
end;

procedure TTransacaos.SetItem(Index: Integer; Value: TTransacao);
begin
  inherited SetItem(Index, Value);
end;

end.