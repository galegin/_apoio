unit uPrdPrdimagem;

interface

uses
  Classes, SysUtils,
  System.Generics.Collections,
  mMapping;

type
  [Tabela('PRD_PRDIMAGEM')]
  TPrd_Prdimagem = class(TmMapping)
  private
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
  published
    [Campo('CD_PRODUTO', tfKey)]
    property Cd_Produto : String read fCd_Produto write fCd_Produto;
    [Campo('CD_IMAGEM', tfKey)]
    property Cd_Imagem : String read fCd_Imagem write fCd_Imagem;
    [Campo('U_VERSION', tfNul)]
    property U_Version : String read fU_Version write fU_Version;
    [Campo('CD_OPERADOR', tfReq)]
    property Cd_Operador : String read fCd_Operador write fCd_Operador;
    [Campo('DT_CADASTRO', tfReq)]
    property Dt_Cadastro : String read fDt_Cadastro write fDt_Cadastro;
    [Campo('IN_PADRAO', tfNul)]
    property In_Padrao : String read fIn_Padrao write fIn_Padrao;
    [Campo('TP_IMAGEM', tfNul)]
    property Tp_Imagem : String read fTp_Imagem write fTp_Imagem;
  end;

  TPrd_Prdimagems = class(TList<Prd_Prdimagem>);

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

end.