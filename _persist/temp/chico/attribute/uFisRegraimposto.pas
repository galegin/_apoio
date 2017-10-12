unit uFisRegraimposto;

interface

uses
  Classes, SysUtils,
  System.Generics.Collections,
  mMapping;

type
  [Tabela('FIS_REGRAIMPOSTO')]
  TFis_Regraimposto = class(TmMapping)
  private
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
  published
    [Campo('CD_IMPOSTO', tfKey)]
    property Cd_Imposto : String read fCd_Imposto write fCd_Imposto;
    [Campo('CD_REGRAFISCAL', tfKey)]
    property Cd_Regrafiscal : String read fCd_Regrafiscal write fCd_Regrafiscal;
    [Campo('U_VERSION', tfNul)]
    property U_Version : String read fU_Version write fU_Version;
    [Campo('CD_OPERADOR', tfReq)]
    property Cd_Operador : String read fCd_Operador write fCd_Operador;
    [Campo('DT_CADASTRO', tfReq)]
    property Dt_Cadastro : String read fDt_Cadastro write fDt_Cadastro;
    [Campo('CD_CST', tfNul)]
    property Cd_Cst : String read fCd_Cst write fCd_Cst;
  end;

  TFis_Regraimpostos = class(TList<Fis_Regraimposto>);

implementation

{ TFis_Regraimposto }

constructor TFis_Regraimposto.Create(AOwner: TComponent);
begin
  inherited;

end;

destructor TFis_Regraimposto.Destroy;
begin

  inherited;
end;

end.