unit uPrdClassificacao;

interface

uses
  Classes, SysUtils,
  cCollection, cCollectionItem;

type
  TPrd_Classificacao = class;
  TPrd_ClassificacaoClass = class of TPrd_Classificacao;

  TPrd_ClassificacaoList = class;
  TPrd_ClassificacaoListClass = class of TPrd_ClassificacaoList;

  TPrd_Classificacao = class(TcCollectionItem)
  private
    fCd_Tipoclas: Real;
    fCd_Classificacao: String;
    fU_Version: String;
    fCd_Operador: Real;
    fDt_Cadastro: TDateTime;
    fDs_Classificacao: String;
  public
    constructor Create; reintroduce;
    destructor Destroy; override;
  published
    property Cd_Tipoclas : Real read fCd_Tipoclas write fCd_Tipoclas;
    property Cd_Classificacao : String read fCd_Classificacao write fCd_Classificacao;
    property U_Version : String read fU_Version write fU_Version;
    property Cd_Operador : Real read fCd_Operador write fCd_Operador;
    property Dt_Cadastro : TDateTime read fDt_Cadastro write fDt_Cadastro;
    property Ds_Classificacao : String read fDs_Classificacao write fDs_Classificacao;
  end;

  TPrd_ClassificacaoList = class(TcCollection)
  private
    function GetItem(Index: Integer): TPrd_Classificacao;
    procedure SetItem(Index: Integer; Value: TPrd_Classificacao);
  public
    constructor Create(AOwner: TPersistent);
    function Add: TPrd_Classificacao;
    property Items[Index: Integer]: TPrd_Classificacao read GetItem write SetItem; default;
  end;
  
implementation

{ TPrd_Classificacao }

constructor TPrd_Classificacao.Create;
begin

end;

destructor TPrd_Classificacao.Destroy;
begin

  inherited;
end;

{ TPrd_ClassificacaoList }

constructor TPrd_ClassificacaoList.Create(AOwner: TPersistent);
begin
  inherited Create(TPrd_Classificacao);
end;

function TPrd_ClassificacaoList.Add: TPrd_Classificacao;
begin
  Result := TPrd_Classificacao(inherited Add);
  Result.create;
end;

function TPrd_ClassificacaoList.GetItem(Index: Integer): TPrd_Classificacao;
begin
  Result := TPrd_Classificacao(inherited GetItem(Index));
end;

procedure TPrd_ClassificacaoList.SetItem(Index: Integer; Value: TPrd_Classificacao);
begin
  inherited SetItem(Index, Value);
end;

end.