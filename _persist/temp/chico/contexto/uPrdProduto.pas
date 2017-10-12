unit uPrdProduto;

interface

uses
  Classes, SysUtils,
  mMapping;

type
  TPrd_Produto = class(TmMapping)
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
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function GetMapping() : PmMapping; override;
  published
    property Cd_Produto : String read fCd_Produto write fCd_Produto;
    property U_Version : String read fU_Version write fU_Version;
    property Cd_Operador : String read fCd_Operador write fCd_Operador;
    property Dt_Cadastro : String read fDt_Cadastro write fDt_Cadastro;
    property Ds_Produto : String read fDs_Produto write fDs_Produto;
    property Cd_Especie : String read fCd_Especie write fCd_Especie;
    property Cd_Tipi : String read fCd_Tipi write fCd_Tipi;
    property Cd_Cst : String read fCd_Cst write fCd_Cst;
    property Qt_Peso : String read fQt_Peso write fQt_Peso;
    property Cd_Nbm : String read fCd_Nbm write fCd_Nbm;
    property Ds_Imagem : String read fDs_Imagem write fDs_Imagem;
  end;

  TPrd_Produtos = class(TList)
  public
    function Add: TPrd_Produto; overload;
  end;

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

//--

function TPrd_Produto.GetMapping: PmMapping;
begin
  Result := New(PmMapping);

  Result.Tabela := New(PmTabela);
  with Result.Tabela^ do begin
    Nome := 'PRD_PRODUTO';
  end;

  Result.Campos := TmCampos.Create;
  with Result.Campos do begin
    Add('Cd_Produto', 'CD_PRODUTO', tfKey);
    Add('U_Version', 'U_VERSION', tfNul);
    Add('Cd_Operador', 'CD_OPERADOR', tfReq);
    Add('Dt_Cadastro', 'DT_CADASTRO', tfReq);
    Add('Ds_Produto', 'DS_PRODUTO', tfReq);
    Add('Cd_Especie', 'CD_ESPECIE', tfNul);
    Add('Cd_Tipi', 'CD_TIPI', tfNul);
    Add('Cd_Cst', 'CD_CST', tfNul);
    Add('Qt_Peso', 'QT_PESO', tfNul);
    Add('Cd_Nbm', 'CD_NBM', tfNul);
    Add('Ds_Imagem', 'DS_IMAGEM', tfNul);
  end;

  Result.Relacoes := TmRelacoes.Create;
  with Result.Relacoes do begin
  end;
end;

//--

{ TPrd_Produtos }

function TPrd_Produtos.Add: TPrd_Produto;
begin
  Result := TPrd_Produto.Create(nil);
  Self.Add(Result);
end;

end.