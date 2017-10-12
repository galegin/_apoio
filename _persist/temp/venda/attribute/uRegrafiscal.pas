unit uRegrafiscal;

interface

uses
  Classes, SysUtils,
  System.Generics.Collections,
  mMapping;

type
  [Tabela('REGRAFISCAL')]
  TRegrafiscal = class(TmMapping)
  private
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
  published
    [Campo('ID_REGRAFISCAL', tfKey)]
    property Id_Regrafiscal : Integer read fId_Regrafiscal write fId_Regrafiscal;
    [Campo('U_VERSION', tfNul)]
    property U_Version : String read fU_Version write fU_Version;
    [Campo('CD_OPERADOR', tfReq)]
    property Cd_Operador : Integer read fCd_Operador write fCd_Operador;
    [Campo('DT_CADASTRO', tfReq)]
    property Dt_Cadastro : String read fDt_Cadastro write fDt_Cadastro;
    [Campo('DS_REGRAFISCAL', tfReq)]
    property Ds_Regrafiscal : String read fDs_Regrafiscal write fDs_Regrafiscal;
    [Campo('IN_CALCIMPOSTO', tfReq)]
    property In_Calcimposto : String read fIn_Calcimposto write fIn_Calcimposto;
  end;

  TRegrafiscals = class(TList<Regrafiscal>);

implementation

{ TRegrafiscal }

constructor TRegrafiscal.Create(AOwner: TComponent);
begin
  inherited;

end;

destructor TRegrafiscal.Destroy;
begin

  inherited;
end;

end.