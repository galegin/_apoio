unit uEmpresa;

interface

uses
  Classes, SysUtils,
  System.Generics.Collections,
  mMapping;

type
  [Tabela('EMPRESA')]
  TEmpresa = class(TmMapping)
  private
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
  published
    [Campo('ID_EMPRESA', tfKey)]
    property Id_Empresa : Integer read fId_Empresa write fId_Empresa;
    [Campo('U_VERSION', tfNul)]
    property U_Version : String read fU_Version write fU_Version;
    [Campo('CD_OPERADOR', tfReq)]
    property Cd_Operador : Integer read fCd_Operador write fCd_Operador;
    [Campo('DT_CADASTRO', tfReq)]
    property Dt_Cadastro : String read fDt_Cadastro write fDt_Cadastro;
    [Campo('ID_PESSOA', tfReq)]
    property Id_Pessoa : String read fId_Pessoa write fId_Pessoa;
  end;

  TEmpresas = class(TList<Empresa>);

implementation

{ TEmpresa }

constructor TEmpresa.Create(AOwner: TComponent);
begin
  inherited;

end;

destructor TEmpresa.Destroy;
begin

  inherited;
end;

end.