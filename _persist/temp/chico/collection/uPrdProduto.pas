unit uPrdProduto;

interface

uses
  Classes, SysUtils,
  mCollection, mCollectionItem;

type
  TPrd_Produto = class;
  TPrd_ProdutoClass = class of TPrd_Produto;

  TPrd_ProdutoList = class;
  TPrd_ProdutoListClass = class of TPrd_ProdutoList;

  TPrd_Produto = class(TmCollectionItem)
  private
    fCd_Produto: String;
    fU_Version: String;
    fCd_Operador: String;
    fDt_Cadastro: String;
    fDs_Produto: String;
    fCd_Especie: String;
    fCd_Tipi: String;
    fCd_Cst: String;
    fQt_Peso: String;
    fCd_Nbm: String;
    fDs_Imagem: String;
  public
    constructor Create(ACollection: TCollection); override;
    destructor Destroy; override;
  published
    property Cd_Produto : String read fCd_Produto write SetCd_Produto;
    property U_Version : String read fU_Version write SetU_Version;
    property Cd_Operador : String read fCd_Operador write SetCd_Operador;
    property Dt_Cadastro : String read fDt_Cadastro write SetDt_Cadastro;
    property Ds_Produto : String read fDs_Produto write SetDs_Produto;
    property Cd_Especie : String read fCd_Especie write SetCd_Especie;
    property Cd_Tipi : String read fCd_Tipi write SetCd_Tipi;
    property Cd_Cst : String read fCd_Cst write SetCd_Cst;
    property Qt_Peso : String read fQt_Peso write SetQt_Peso;
    property Cd_Nbm : String read fCd_Nbm write SetCd_Nbm;
    property Ds_Imagem : String read fDs_Imagem write SetDs_Imagem;
  end;

  TPrd_ProdutoList = class(TmCollection)
  private
    function GetItem(Index: Integer): TPrd_Produto;
    procedure SetItem(Index: Integer; Value: TPrd_Produto);
  public
    constructor Create(AOwner: TPersistentCollection);
    function Add: TPrd_Produto;
    property Items[Index: Integer]: TPrd_Produto read GetItem write SetItem; default;
  end;

implementation

{ TPrd_Produto }

constructor TPrd_Produto.Create(ACollection: TCollection);
begin
  inherited;

end;

destructor TPrd_Produto.Destroy;
begin

  inherited;
end;

{ TPrd_ProdutoList }

constructor TPrd_ProdutoList.Create(AOwner: TPersistentCollection);
begin
  inherited Create(TPrd_Produto);
end;

function TPrd_ProdutoList.Add: TPrd_Produto;
begin
  Result := TPrd_Produto(inherited Add);
  Result.create;
end;

function TPrd_ProdutoList.GetItem(Index: Integer): TPrd_Produto;
begin
  Result := TPrd_Produto(inherited GetItem(Index));
end;

procedure TPrd_ProdutoList.SetItem(Index: Integer; Value: TPrd_Produto);
begin
  inherited SetItem(Index, Value);
end;

end.