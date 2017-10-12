unit uPrdProdutoclas;

interface

uses
  Classes, SysUtils,
  System.Generics.Collections,
  mMapping;

type
  [Tabela('PRD_PRODUTOCLAS')]
  TPrd_Produtoclas = class(TmMapping)
  private
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
  published
    [Campo('CD_PRODUTO', tfKey)]
    property Cd_Produto : String read fCd_Produto write fCd_Produto;
    [Campo('CD_TIPOCLAS', tfKey)]
    property Cd_Tipoclas : String read fCd_Tipoclas write fCd_Tipoclas;
    [Campo('CD_CLASSIFICACAO', tfKey)]
    property Cd_Classificacao : String read fCd_Classificacao write fCd_Classificacao;
    [Campo('CD_OPERADOR', tfKey)]
    property Cd_Operador : String read fCd_Operador write fCd_Operador;
    [Campo('DT_CADASTRO', tfKey)]
    property Dt_Cadastro : String read fDt_Cadastro write fDt_Cadastro;
  end;

  TPrd_Produtoclass = class(TList<Prd_Produtoclas>);

implementation

{ TPrd_Produtoclas }

constructor TPrd_Produtoclas.Create(AOwner: TComponent);
begin
  inherited;

end;

destructor TPrd_Produtoclas.Destroy;
begin

  inherited;
end;

end.