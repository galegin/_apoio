unit uPrdProdutoclas;

interface

uses
  Classes, SysUtils,
  mCollection, mCollectionItem;

type
  TPrd_Produtoclas = class;
  TPrd_ProdutoclasClass = class of TPrd_Produtoclas;

  TPrd_ProdutoclasList = class;
  TPrd_ProdutoclasListClass = class of TPrd_ProdutoclasList;

  TPrd_Produtoclas = class(TmCollectionItem)
  private
    fCd_Produto: String;
    fCd_Tipoclas: String;
    fCd_Classificacao: String;
    fCd_Operador: String;
    fDt_Cadastro: String;
  public
    constructor Create(ACollection: TCollection); override;
    destructor Destroy; override;
  published
    property Cd_Produto : String read fCd_Produto write SetCd_Produto;
    property Cd_Tipoclas : String read fCd_Tipoclas write SetCd_Tipoclas;
    property Cd_Classificacao : String read fCd_Classificacao write SetCd_Classificacao;
    property Cd_Operador : String read fCd_Operador write SetCd_Operador;
    property Dt_Cadastro : String read fDt_Cadastro write SetDt_Cadastro;
  end;

  TPrd_ProdutoclasList = class(TmCollection)
  private
    function GetItem(Index: Integer): TPrd_Produtoclas;
    procedure SetItem(Index: Integer; Value: TPrd_Produtoclas);
  public
    constructor Create(AOwner: TPersistentCollection);
    function Add: TPrd_Produtoclas;
    property Items[Index: Integer]: TPrd_Produtoclas read GetItem write SetItem; default;
  end;

implementation

{ TPrd_Produtoclas }

constructor TPrd_Produtoclas.Create(ACollection: TCollection);
begin
  inherited;

end;

destructor TPrd_Produtoclas.Destroy;
begin

  inherited;
end;

{ TPrd_ProdutoclasList }

constructor TPrd_ProdutoclasList.Create(AOwner: TPersistentCollection);
begin
  inherited Create(TPrd_Produtoclas);
end;

function TPrd_ProdutoclasList.Add: TPrd_Produtoclas;
begin
  Result := TPrd_Produtoclas(inherited Add);
  Result.create;
end;

function TPrd_ProdutoclasList.GetItem(Index: Integer): TPrd_Produtoclas;
begin
  Result := TPrd_Produtoclas(inherited GetItem(Index));
end;

procedure TPrd_ProdutoclasList.SetItem(Index: Integer; Value: TPrd_Produtoclas);
begin
  inherited SetItem(Index, Value);
end;

end.