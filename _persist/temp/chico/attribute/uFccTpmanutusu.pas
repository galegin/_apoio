unit uFccTpmanutusu;

interface

uses
  Classes, SysUtils,
  System.Generics.Collections,
  mMapping;

type
  [Tabela('FCC_TPMANUTUSU')]
  TFcc_Tpmanutusu = class(TmMapping)
  private
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
  published
    [Campo('CD_EMPRESA', tfKey)]
    property Cd_Empresa : String read fCd_Empresa write fCd_Empresa;
    [Campo('CD_USULIBERADO', tfKey)]
    property Cd_Usuliberado : String read fCd_Usuliberado write fCd_Usuliberado;
    [Campo('TP_MANUTENCAO', tfKey)]
    property Tp_Manutencao : String read fTp_Manutencao write fTp_Manutencao;
    [Campo('U_VERSION', tfNul)]
    property U_Version : String read fU_Version write fU_Version;
    [Campo('CD_OPERADOR', tfReq)]
    property Cd_Operador : String read fCd_Operador write fCd_Operador;
    [Campo('DT_CADASTRO', tfReq)]
    property Dt_Cadastro : String read fDt_Cadastro write fDt_Cadastro;
    [Campo('IN_VERSALDO', tfNul)]
    property In_Versaldo : String read fIn_Versaldo write fIn_Versaldo;
    [Campo('IN_OCULTARMOV', tfNul)]
    property In_Ocultarmov : String read fIn_Ocultarmov write fIn_Ocultarmov;
  end;

  TFcc_Tpmanutusus = class(TList<Fcc_Tpmanutusu>);

implementation

{ TFcc_Tpmanutusu }

constructor TFcc_Tpmanutusu.Create(AOwner: TComponent);
begin
  inherited;

end;

destructor TFcc_Tpmanutusu.Destroy;
begin

  inherited;
end;

end.