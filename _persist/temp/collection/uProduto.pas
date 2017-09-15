unit uProduto;

interface

uses
  Classes, SysUtils,
  mCollection, mCollectionItem;

type
  TProduto = class;
  TProdutoClass = class of TProduto;

  TProdutoList = class;
  TProdutoListClass = class of TProdutoList;

  TProduto = class(TmCollectionItem)
  private
    fId_Produto: String;
    fU_Version: String;
    fCd_Operador: Integer;
    fDt_Cadastro: String;
    fCd_Produto: Integer;
    fDs_Produto: String;
    fCd_Especie: String;
    fCd_Ncm: String;
    fCd_Cst: String;
    fCd_Csosn: String;
    fPr_Aliquota: String;
    fTp_Producao: Integer;
    fVl_Custo: String;
    fVl_Venda: String;
    fVl_Promocao: String;
  public
    constructor Create(ACollection: TCollection); override;
    destructor Destroy; override;
  published
    property Id_Produto : String read fId_Produto write SetId_Produto;
    property U_Version : String read fU_Version write SetU_Version;
    property Cd_Operador : Integer read fCd_Operador write SetCd_Operador;
    property Dt_Cadastro : String read fDt_Cadastro write SetDt_Cadastro;
    property Cd_Produto : Integer read fCd_Produto write SetCd_Produto;
    property Ds_Produto : String read fDs_Produto write SetDs_Produto;
    property Cd_Especie : String read fCd_Especie write SetCd_Especie;
    property Cd_Ncm : String read fCd_Ncm write SetCd_Ncm;
    property Cd_Cst : String read fCd_Cst write SetCd_Cst;
    property Cd_Csosn : String read fCd_Csosn write SetCd_Csosn;
    property Pr_Aliquota : String read fPr_Aliquota write SetPr_Aliquota;
    property Tp_Producao : Integer read fTp_Producao write SetTp_Producao;
    property Vl_Custo : String read fVl_Custo write SetVl_Custo;
    property Vl_Venda : String read fVl_Venda write SetVl_Venda;
    property Vl_Promocao : String read fVl_Promocao write SetVl_Promocao;
  end;

  TProdutoList = class(TmCollection)
  private
    function GetItem(Index: Integer): TProduto;
    procedure SetItem(Index: Integer; Value: TProduto);
  public
    constructor Create(AOwner: TPersistentCollection);
    function Add: TProduto;
    property Items[Index: Integer]: TProduto read GetItem write SetItem; default;
  end;

implementation

{ TProduto }

constructor TProduto.Create(ACollection: TCollection);
begin
  inherited;

end;

destructor TProduto.Destroy;
begin

  inherited;
end;

{ TProdutoList }

constructor TProdutoList.Create(AOwner: TPersistentCollection);
begin
  inherited Create(TProduto);
end;

function TProdutoList.Add: TProduto;
begin
  Result := TProduto(inherited Add);
  Result.create;
end;

function TProdutoList.GetItem(Index: Integer): TProduto;
begin
  Result := TProduto(inherited GetItem(Index));
end;

procedure TProdutoList.SetItem(Index: Integer; Value: TProduto);
begin
  inherited SetItem(Index, Value);
end;

end.