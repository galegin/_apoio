unit uEstado;

interface

uses
  Classes, SysUtils,
  System.Generics.Collections,
  mMapping;

type
  [Tabela('ESTADO')]
  TEstado = class(TmMapping)
  private
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
  published
    [Campo('ID_ESTADO', tfKey)]
    property Id_Estado : Integer read fId_Estado write fId_Estado;
    [Campo('U_VERSION', tfNul)]
    property U_Version : String read fU_Version write fU_Version;
    [Campo('CD_OPERADOR', tfReq)]
    property Cd_Operador : Integer read fCd_Operador write fCd_Operador;
    [Campo('DT_CADASTRO', tfReq)]
    property Dt_Cadastro : String read fDt_Cadastro write fDt_Cadastro;
    [Campo('CD_ESTADO', tfReq)]
    property Cd_Estado : Integer read fCd_Estado write fCd_Estado;
    [Campo('DS_ESTADO', tfReq)]
    property Ds_Estado : String read fDs_Estado write fDs_Estado;
    [Campo('DS_SIGLA', tfReq)]
    property Ds_Sigla : String read fDs_Sigla write fDs_Sigla;
    [Campo('ID_PAIS', tfReq)]
    property Id_Pais : Integer read fId_Pais write fId_Pais;
  end;

  TEstados = class(TList<Estado>);

implementation

{ TEstado }

constructor TEstado.Create(AOwner: TComponent);
begin
  inherited;

end;

destructor TEstado.Destroy;
begin

  inherited;
end;

end.