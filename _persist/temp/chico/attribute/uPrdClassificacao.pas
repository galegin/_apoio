unit uPrdClassificacao;

interface

uses
  Classes, SysUtils,
  System.Generics.Collections,
  mMapping;

type
  [Tabela('PRD_CLASSIFICACAO')]
  TPrd_Classificacao = class(TmMapping)
  private
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
  published
    [Campo('CD_TIPOCLAS', tfKey)]
    property Cd_Tipoclas : String read fCd_Tipoclas write fCd_Tipoclas;
    [Campo('CD_CLASSIFICACAO', tfKey)]
    property Cd_Classificacao : String read fCd_Classificacao write fCd_Classificacao;
    [Campo('U_VERSION', tfNul)]
    property U_Version : String read fU_Version write fU_Version;
    [Campo('CD_OPERADOR', tfReq)]
    property Cd_Operador : String read fCd_Operador write fCd_Operador;
    [Campo('DT_CADASTRO', tfReq)]
    property Dt_Cadastro : String read fDt_Cadastro write fDt_Cadastro;
    [Campo('DS_CLASSIFICACAO', tfReq)]
    property Ds_Classificacao : String read fDs_Classificacao write fDs_Classificacao;
  end;

  TPrd_Classificacaos = class(TList<Prd_Classificacao>);

implementation

{ TPrd_Classificacao }

constructor TPrd_Classificacao.Create(AOwner: TComponent);
begin
  inherited;

end;

destructor TPrd_Classificacao.Destroy;
begin

  inherited;
end;

end.