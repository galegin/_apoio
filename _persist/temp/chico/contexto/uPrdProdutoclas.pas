unit uPrdProdutoclas;

interface

uses
  Classes, SysUtils,
  mMapping;

type
  TPrd_Produtoclas = class(TmMapping)
  private
    fCd_Produto: String;
    fCd_Tipoclas: String;
    fCd_Classificacao: String;
    fCd_Operador: String;
    fDt_Cadastro: String;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function GetMapping() : PmMapping; override;
  published
    property Cd_Produto : String read fCd_Produto write fCd_Produto;
    property Cd_Tipoclas : String read fCd_Tipoclas write fCd_Tipoclas;
    property Cd_Classificacao : String read fCd_Classificacao write fCd_Classificacao;
    property Cd_Operador : String read fCd_Operador write fCd_Operador;
    property Dt_Cadastro : String read fDt_Cadastro write fDt_Cadastro;
  end;

  TPrd_Produtoclass = class(TList)
  public
    function Add: TPrd_Produtoclas; overload;
  end;

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

//--

function TPrd_Produtoclas.GetMapping: PmMapping;
begin
  Result := New(PmMapping);

  Result.Tabela := New(PmTabela);
  with Result.Tabela^ do begin
    Nome := 'PRD_PRODUTOCLAS';
  end;

  Result.Campos := TmCampos.Create;
  with Result.Campos do begin
    Add('Cd_Produto', 'CD_PRODUTO', tfKey);
    Add('Cd_Tipoclas', 'CD_TIPOCLAS', tfKey);
    Add('Cd_Classificacao', 'CD_CLASSIFICACAO', tfKey);
    Add('Cd_Operador', 'CD_OPERADOR', tfKey);
    Add('Dt_Cadastro', 'DT_CADASTRO', tfKey);
  end;

  Result.Relacoes := TmRelacoes.Create;
  with Result.Relacoes do begin
  end;
end;

//--

{ TPrd_Produtoclass }

function TPrd_Produtoclass.Add: TPrd_Produtoclas;
begin
  Result := TPrd_Produtoclas.Create(nil);
  Self.Add(Result);
end;

end.