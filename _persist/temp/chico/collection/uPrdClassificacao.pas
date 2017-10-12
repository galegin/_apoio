unit uPrdClassificacao;

interface

uses
  Classes, SysUtils,
  mCollection, mCollectionItem;

type
  TPrd_Classificacao = class;
  TPrd_ClassificacaoClass = class of TPrd_Classificacao;

  TPrd_ClassificacaoList = class;
  TPrd_ClassificacaoListClass = class of TPrd_ClassificacaoList;

  TPrd_Classificacao = class(TmCollectionItem)
  private
    fCd_Tipoclas: String;
    fCd_Classificacao: String;
    fU_Version: String;
    fCd_Operador: String;
    fDt_Cadastro: String;
    fDs_Classificacao: String;
  public
    constructor Create(ACollection: TCollection); override;
    destructor Destroy; override;
  published
    property Cd_Tipoclas : String read fCd_Tipoclas write SetCd_Tipoclas;
    property Cd_Classificacao : String read fCd_Classificacao write SetCd_Classificacao;
    property U_Version : String read fU_Version write SetU_Version;
    property Cd_Operador : String read fCd_Operador write SetCd_Operador;
    property Dt_Cadastro : String read fDt_Cadastro write SetDt_Cadastro;
    property Ds_Classificacao : String read fDs_Classificacao write SetDs_Classificacao;
  end;

  TPrd_ClassificacaoList = class(TmCollection)
  private
    function GetItem(Index: Integer): TPrd_Classificacao;
    procedure SetItem(Index: Integer; Value: TPrd_Classificacao);
  public
    constructor Create(AOwner: TPersistentCollection);
    function Add: TPrd_Classificacao;
    property Items[Index: Integer]: TPrd_Classificacao read GetItem write SetItem; default;
  end;

implementation

{ TPrd_Classificacao }

constructor TPrd_Classificacao.Create(ACollection: TCollection);
begin
  inherited;

end;

destructor TPrd_Classificacao.Destroy;
begin

  inherited;
end;

{ TPrd_ClassificacaoList }

constructor TPrd_ClassificacaoList.Create(AOwner: TPersistentCollection);
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