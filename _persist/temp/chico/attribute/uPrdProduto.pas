unit uPrdProduto;

interface

uses
  Classes, SysUtils,
  System.Generics.Collections,
  mMapping;

type
  [Tabela('PRD_PRODUTO')]
  TPrd_Produto = class(TmMapping)
  private
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
  published
    [Campo('CD_PRODUTO', tfKey)]
    property Cd_Produto : String read fCd_Produto write fCd_Produto;
    [Campo('U_VERSION', tfNul)]
    property U_Version : String read fU_Version write fU_Version;
    [Campo('CD_OPERADOR', tfReq)]
    property Cd_Operador : String read fCd_Operador write fCd_Operador;
    [Campo('DT_CADASTRO', tfReq)]
    property Dt_Cadastro : String read fDt_Cadastro write fDt_Cadastro;
    [Campo('DS_PRODUTO', tfReq)]
    property Ds_Produto : String read fDs_Produto write fDs_Produto;
    [Campo('CD_ESPECIE', tfNul)]
    property Cd_Especie : String read fCd_Especie write fCd_Especie;
    [Campo('CD_TIPI', tfNul)]
    property Cd_Tipi : String read fCd_Tipi write fCd_Tipi;
    [Campo('CD_CST', tfNul)]
    property Cd_Cst : String read fCd_Cst write fCd_Cst;
    [Campo('QT_PESO', tfNul)]
    property Qt_Peso : String read fQt_Peso write fQt_Peso;
    [Campo('CD_NBM', tfNul)]
    property Cd_Nbm : String read fCd_Nbm write fCd_Nbm;
    [Campo('DS_IMAGEM', tfNul)]
    property Ds_Imagem : String read fDs_Imagem write fDs_Imagem;
  end;

  TPrd_Produtos = class(TList<Prd_Produto>);

implementation

{ TPrd_Produto }

constructor TPrd_Produto.Create(AOwner: TComponent);
begin
  inherited;

end;

destructor TPrd_Produto.Destroy;
begin

  inherited;
end;

end.