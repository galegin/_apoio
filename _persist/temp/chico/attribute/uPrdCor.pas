unit uPrdCor;

interface

uses
  Classes, SysUtils,
  System.Generics.Collections,
  mMapping;

type
  [Tabela('PRD_COR')]
  TPrd_Cor = class(TmMapping)
  private
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
  published
    [Campo('CD_COR', tfKey)]
    property Cd_Cor : String read fCd_Cor write fCd_Cor;
    [Campo('U_VERSION', tfNul)]
    property U_Version : String read fU_Version write fU_Version;
    [Campo('CD_OPERADOR', tfReq)]
    property Cd_Operador : String read fCd_Operador write fCd_Operador;
    [Campo('DT_CADASTRO', tfReq)]
    property Dt_Cadastro : String read fDt_Cadastro write fDt_Cadastro;
    [Campo('DS_COR', tfReq)]
    property Ds_Cor : String read fDs_Cor write fDs_Cor;
  end;

  TPrd_Cors = class(TList<Prd_Cor>);

implementation

{ TPrd_Cor }

constructor TPrd_Cor.Create(AOwner: TComponent);
begin
  inherited;

end;

destructor TPrd_Cor.Destroy;
begin

  inherited;
end;

end.