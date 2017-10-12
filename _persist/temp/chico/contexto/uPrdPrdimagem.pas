unit uPrdPrdimagem;

interface

uses
  Classes, SysUtils,
  mMapping;

type
  TPrd_Prdimagem = class(TmMapping)
  private
    fCd_Produto: String;
    fCd_Imagem: String;
    fU_Version: String;
    fCd_Operador: String;
    fDt_Cadastro: String;
    fIn_Padrao: String;
    fTp_Imagem: String;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function GetMapping() : PmMapping; override;
  published
    property Cd_Produto : String read fCd_Produto write fCd_Produto;
    property Cd_Imagem : String read fCd_Imagem write fCd_Imagem;
    property U_Version : String read fU_Version write fU_Version;
    property Cd_Operador : String read fCd_Operador write fCd_Operador;
    property Dt_Cadastro : String read fDt_Cadastro write fDt_Cadastro;
    property In_Padrao : String read fIn_Padrao write fIn_Padrao;
    property Tp_Imagem : String read fTp_Imagem write fTp_Imagem;
  end;

  TPrd_Prdimagems = class(TList)
  public
    function Add: TPrd_Prdimagem; overload;
  end;

implementation

{ TPrd_Prdimagem }

constructor TPrd_Prdimagem.Create(AOwner: TComponent);
begin
  inherited;

end;

destructor TPrd_Prdimagem.Destroy;
begin

  inherited;
end;

//--

function TPrd_Prdimagem.GetMapping: PmMapping;
begin
  Result := New(PmMapping);

  Result.Tabela := New(PmTabela);
  with Result.Tabela^ do begin
    Nome := 'PRD_PRDIMAGEM';
  end;

  Result.Campos := TmCampos.Create;
  with Result.Campos do begin
    Add('Cd_Produto', 'CD_PRODUTO', tfKey);
    Add('Cd_Imagem', 'CD_IMAGEM', tfKey);
    Add('U_Version', 'U_VERSION', tfNul);
    Add('Cd_Operador', 'CD_OPERADOR', tfReq);
    Add('Dt_Cadastro', 'DT_CADASTRO', tfReq);
    Add('In_Padrao', 'IN_PADRAO', tfNul);
    Add('Tp_Imagem', 'TP_IMAGEM', tfNul);
  end;

  Result.Relacoes := TmRelacoes.Create;
  with Result.Relacoes do begin
  end;
end;

//--

{ TPrd_Prdimagems }

function TPrd_Prdimagems.Add: TPrd_Prdimagem;
begin
  Result := TPrd_Prdimagem.Create(nil);
  Self.Add(Result);
end;

end.