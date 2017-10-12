unit uMunicipio;

interface

uses
  Classes, SysUtils,
  System.Generics.Collections,
  mMapping;

type
  [Tabela('MUNICIPIO')]
  TMunicipio = class(TmMapping)
  private
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
  published
    [Campo('ID_MUNICIPIO', tfKey)]
    property Id_Municipio : Integer read fId_Municipio write fId_Municipio;
    [Campo('U_VERSION', tfNul)]
    property U_Version : String read fU_Version write fU_Version;
    [Campo('CD_OPERADOR', tfReq)]
    property Cd_Operador : Integer read fCd_Operador write fCd_Operador;
    [Campo('DT_CADASTRO', tfReq)]
    property Dt_Cadastro : String read fDt_Cadastro write fDt_Cadastro;
    [Campo('CD_MUNICIPIO', tfReq)]
    property Cd_Municipio : Integer read fCd_Municipio write fCd_Municipio;
    [Campo('DS_MUNICIPIO', tfReq)]
    property Ds_Municipio : String read fDs_Municipio write fDs_Municipio;
    [Campo('DS_SIGLA', tfReq)]
    property Ds_Sigla : String read fDs_Sigla write fDs_Sigla;
    [Campo('ID_ESTADO', tfReq)]
    property Id_Estado : Integer read fId_Estado write fId_Estado;
  end;

  TMunicipios = class(TList<Municipio>);

implementation

{ TMunicipio }

constructor TMunicipio.Create(AOwner: TComponent);
begin
  inherited;

end;

destructor TMunicipio.Destroy;
begin

  inherited;
end;

end.