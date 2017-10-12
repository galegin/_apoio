unit uPais;

interface

uses
  Classes, SysUtils,
  System.Generics.Collections,
  mMapping;

type
  [Tabela('PAIS')]
  TPais = class(TmMapping)
  private
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
  published
    [Campo('ID_PAIS', tfKey)]
    property Id_Pais : Integer read fId_Pais write fId_Pais;
    [Campo('U_VERSION', tfNul)]
    property U_Version : String read fU_Version write fU_Version;
    [Campo('CD_OPERADOR', tfReq)]
    property Cd_Operador : Integer read fCd_Operador write fCd_Operador;
    [Campo('DT_CADASTRO', tfReq)]
    property Dt_Cadastro : String read fDt_Cadastro write fDt_Cadastro;
    [Campo('CD_PAIS', tfReq)]
    property Cd_Pais : Integer read fCd_Pais write fCd_Pais;
    [Campo('DS_PAIS', tfReq)]
    property Ds_Pais : String read fDs_Pais write fDs_Pais;
    [Campo('DS_SIGLA', tfReq)]
    property Ds_Sigla : String read fDs_Sigla write fDs_Sigla;
  end;

  TPaiss = class(TList<Pais>);

implementation

{ TPais }

constructor TPais.Create(AOwner: TComponent);
begin
  inherited;

end;

destructor TPais.Destroy;
begin

  inherited;
end;

end.