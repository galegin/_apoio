unit uPrdProdutoclas;

interface

uses
  Classes, SysUtils,
  cCollection, cCollectionItem;

type
  TPrd_Produtoclas = class;
  TPrd_ProdutoclasClass = class of TPrd_Produtoclas;

  TPrd_ProdutoclasList = class;
  TPrd_ProdutoclasListClass = class of TPrd_ProdutoclasList;

  TPrd_Produtoclas = class(TcCollectionItem)
  private
    fCd_Produto: Real;
    fCd_Tipoclas: Real;
    fCd_Classificacao: String;
    fCd_Operador: Real;
    fDt_Cadastro: TDateTime;
  public
    constructor Create; reintroduce;
    destructor Destroy; override;
  published
    property Cd_Produto : Real read fCd_Produto write fCd_Produto;
    property Cd_Tipoclas : Real read fCd_Tipoclas write fCd_Tipoclas;
    property Cd_Classificacao : String read fCd_Classificacao write fCd_Classificacao;
    property Cd_Operador : Real read fCd_Operador write fCd_Operador;
    property Dt_Cadastro : TDateTime read fDt_Cadastro write fDt_Cadastro;
  end;

  TPrd_ProdutoclasList = class(TcCollection)
  private
    function GetItem(Index: Integer): TPrd_Produtoclas;
    procedure SetItem(Index: Integer; Value: TPrd_Produtoclas);
  public
    constructor Create(AOwner: TPersistent);
    function Add: TPrd_Produtoclas;
    property Items[Index: Integer]: TPrd_Produtoclas read GetItem write SetItem; default;
  end;
  
implementation

{ TPrd_Produtoclas }

constructor TPrd_Produtoclas.Create;
begin

end;

destructor TPrd_Produtoclas.Destroy;
begin

  inherited;
end;

{ TPrd_ProdutoclasList }

constructor TPrd_ProdutoclasList.Create(AOwner: TPersistent);
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