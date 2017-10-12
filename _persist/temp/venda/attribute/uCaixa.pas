unit uCaixa;

interface

uses
  Classes, SysUtils,
  System.Generics.Collections,
  mMapping;

type
  [Tabela('CAIXA')]
  TCaixa = class(TmMapping)
  private
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
  published
    [Campo('ID_CAIXA', tfKey)]
    property Id_Caixa : Integer read fId_Caixa write fId_Caixa;
    [Campo('U_VERSION', tfNul)]
    property U_Version : String read fU_Version write fU_Version;
    [Campo('CD_OPERADOR', tfReq)]
    property Cd_Operador : Integer read fCd_Operador write fCd_Operador;
    [Campo('DT_CADASTRO', tfReq)]
    property Dt_Cadastro : String read fDt_Cadastro write fDt_Cadastro;
    [Campo('CD_TERMINAL', tfReq)]
    property Cd_Terminal : Integer read fCd_Terminal write fCd_Terminal;
    [Campo('DT_ABERTURA', tfReq)]
    property Dt_Abertura : String read fDt_Abertura write fDt_Abertura;
    [Campo('VL_ABERTURA', tfReq)]
    property Vl_Abertura : String read fVl_Abertura write fVl_Abertura;
    [Campo('IN_FECHADO', tfReq)]
    property In_Fechado : String read fIn_Fechado write fIn_Fechado;
    [Campo('DT_FECHADO', tfNul)]
    property Dt_Fechado : String read fDt_Fechado write fDt_Fechado;
  end;

  TCaixas = class(TList<Caixa>);

implementation

{ TCaixa }

constructor TCaixa.Create(AOwner: TComponent);
begin
  inherited;

end;

destructor TCaixa.Destroy;
begin

  inherited;
end;

end.