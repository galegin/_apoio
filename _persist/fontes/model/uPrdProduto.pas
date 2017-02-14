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
    fCd_Produto: Real;
    fU_Version: String;
    fCd_Operador: Real;
    fDt_Cadastro: TDateTime;
    fDs_Produto: String;
    fCd_Especie: String;
    fCd_Tipi: String;
    fCd_Cst: String;
    fQt_Peso: Real;
    fCd_Nbm: String;
    fDs_Imagem: String;
  public
    constructor Create(Collection: TCollection); override;
    destructor Destroy; override;
  published
    property Cd_Produto : Real read fCd_Produto write fCd_Produto;
    property U_Version : String read fU_Version write fU_Version;
    property Cd_Operador : Real read fCd_Operador write fCd_Operador;
    property Dt_Cadastro : TDateTime read fDt_Cadastro write fDt_Cadastro;
    property Ds_Produto : String read fDs_Produto write fDs_Produto;
    property Cd_Especie : String read fCd_Especie write fCd_Especie;
    property Cd_Tipi : String read fCd_Tipi write fCd_Tipi;
    property Cd_Cst : String read fCd_Cst write fCd_Cst;
    property Qt_Peso : Real read fQt_Peso write fQt_Peso;
    property Cd_Nbm : String read fCd_Nbm write fCd_Nbm;
    property Ds_Imagem : String read fDs_Imagem write fDs_Imagem;
  end;

  TPrd_ProdutoList = class(TmCollection)
  private
    function GetItem(Index: Integer): TPrd_Produto;
    procedure SetItem(Index: Integer; Value: TPrd_Produto);
  public
    constructor Create(AOwner: TPersistent);
    function Add: TPrd_Produto;
    property Items[Index: Integer]: TPrd_Produto read GetItem write SetItem; default;
  end;

implementation

{ TPrd_Produto }

constructor TPrd_Produto.Create(Collection: TCollection);
begin
  inherited;
end;

destructor TPrd_Produto.Destroy;
begin
  inherited;
end;

{ TPrd_ProdutoList }

constructor TPrd_ProdutoList.Create(AOwner: TPersistent);
begin
  inherited Create(TPrd_Produto);
end;

function TPrd_ProdutoList.Add: TPrd_Produto;
begin
  Result := TPrd_Produto(inherited Add);
  Result.create(Self);
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