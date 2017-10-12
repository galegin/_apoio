unit uPrdTipoclas;

interface

uses
  Classes, SysUtils,
  System.Generics.Collections,
  mMapping;

type
  [Tabela('PRD_TIPOCLAS')]
  TPrd_Tipoclas = class(TmMapping)
  private
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
  published
    [Campo('CD_TIPOCLAS', tfKey)]
    property Cd_Tipoclas : String read fCd_Tipoclas write fCd_Tipoclas;
    [Campo('U_VERSION', tfNul)]
    property U_Version : String read fU_Version write fU_Version;
    [Campo('CD_OPERADOR', tfReq)]
    property Cd_Operador : String read fCd_Operador write fCd_Operador;
    [Campo('DT_CADASTRO', tfReq)]
    property Dt_Cadastro : String read fDt_Cadastro write fDt_Cadastro;
    [Campo('DS_TIPOCLAS', tfReq)]
    property Ds_Tipoclas : String read fDs_Tipoclas write fDs_Tipoclas;
    [Campo('IN_GRUPO', tfNul)]
    property In_Grupo : String read fIn_Grupo write fIn_Grupo;
  end;

  TPrd_Tipoclass = class(TList<Prd_Tipoclas>);

implementation

{ TPrd_Tipoclas }

constructor TPrd_Tipoclas.Create(AOwner: TComponent);
begin
  inherited;

end;

destructor TPrd_Tipoclas.Destroy;
begin

  inherited;
end;

end.