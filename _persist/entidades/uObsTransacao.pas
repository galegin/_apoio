unit uObsTransacao;

interface

uses
  Classes, SysUtils,
  cCollection, cCollectionItem;

type
  TObs_Transacao = class;
  TObs_TransacaoClass = class of TObs_Transacao;

  TObs_TransacaoList = class;
  TObs_TransacaoListClass = class of TObs_TransacaoList;

  TObs_Transacao = class(TcCollectionItem)
  private
    fCd_Empresa: Real;
    fNr_Transacao: Real;
    fDt_Transacao: TDateTime;
    fNr_Linha: Real;
    fU_Version: String;
    fCd_Operador: Real;
    fDt_Cadastro: TDateTime;
    fIn_Manutencao: String;
    fCd_Componente: String;
    fDs_Observacao: String;
  public
    constructor Create; reintroduce;
    destructor Destroy; override;
  published
    property Cd_Empresa : Real read fCd_Empresa write fCd_Empresa;
    property Nr_Transacao : Real read fNr_Transacao write fNr_Transacao;
    property Dt_Transacao : TDateTime read fDt_Transacao write fDt_Transacao;
    property Nr_Linha : Real read fNr_Linha write fNr_Linha;
    property U_Version : String read fU_Version write fU_Version;
    property Cd_Operador : Real read fCd_Operador write fCd_Operador;
    property Dt_Cadastro : TDateTime read fDt_Cadastro write fDt_Cadastro;
    property In_Manutencao : String read fIn_Manutencao write fIn_Manutencao;
    property Cd_Componente : String read fCd_Componente write fCd_Componente;
    property Ds_Observacao : String read fDs_Observacao write fDs_Observacao;
  end;

  TObs_TransacaoList = class(TcCollection)
  private
    function GetItem(Index: Integer): TObs_Transacao;
    procedure SetItem(Index: Integer; Value: TObs_Transacao);
  public
    constructor Create(AOwner: TPersistent);
    function Add: TObs_Transacao;
    property Items[Index: Integer]: TObs_Transacao read GetItem write SetItem; default;
  end;
  
implementation

{ TObs_Transacao }

constructor TObs_Transacao.Create;
begin

end;

destructor TObs_Transacao.Destroy;
begin

  inherited;
end;

{ TObs_TransacaoList }

constructor TObs_TransacaoList.Create(AOwner: TPersistent);
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