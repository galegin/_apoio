unit uPrdImagem;

interface

uses
  Classes, SysUtils,
  System.Generics.Collections,
  mMapping;

type
  [Tabela('PRD_IMAGEM')]
  TPrd_Imagem = class(TmMapping)
  private
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
  published
    [Campo('CD_IMAGEM', tfKey)]
    property Cd_Imagem : String read fCd_Imagem write fCd_Imagem;
    [Campo('U_VERSION', tfNul)]
    property U_Version : String read fU_Version write fU_Version;
    [Campo('CD_OPERADOR', tfReq)]
    property Cd_Operador : String read fCd_Operador write fCd_Operador;
    [Campo('DT_CADASTRO', tfReq)]
    property Dt_Cadastro : String read fDt_Cadastro write fDt_Cadastro;
    [Campo('NM_IMAGEM', tfReq)]
    property Nm_Imagem : String read fNm_Imagem write fNm_Imagem;
    [Campo('DS_IMAGEM', tfNul)]
    property Ds_Imagem : String read fDs_Imagem write fDs_Imagem;
    [Campo('DS_ARQUIVO', tfNul)]
    property Ds_Arquivo : String read fDs_Arquivo write fDs_Arquivo;
  end;

  TPrd_Imagems = class(TList<Prd_Imagem>);

implementation

{ TPrd_Imagem }

constructor TPrd_Imagem.Create(AOwner: TComponent);
begin
  inherited;

end;

destructor TPrd_Imagem.Destroy;
begin

  inherited;
end;

end.