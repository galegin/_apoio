unit uFccTpmanut;

interface

uses
  Classes, SysUtils,
  System.Generics.Collections,
  mMapping;

type
  [Tabela('FCC_TPMANUT')]
  TFcc_Tpmanut = class(TmMapping)
  private
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
  published
    [Campo('TP_MANUTENCAO', tfKey)]
    property Tp_Manutencao : String read fTp_Manutencao write fTp_Manutencao;
    [Campo('U_VERSION', tfNul)]
    property U_Version : String read fU_Version write fU_Version;
    [Campo('CD_OPERADOR', tfReq)]
    property Cd_Operador : String read fCd_Operador write fCd_Operador;
    [Campo('DT_CADASTRO', tfReq)]
    property Dt_Cadastro : String read fDt_Cadastro write fDt_Cadastro;
    [Campo('DS_MANUTENCAO', tfReq)]
    property Ds_Manutencao : String read fDs_Manutencao write fDs_Manutencao;
  end;

  TFcc_Tpmanuts = class(TList<Fcc_Tpmanut>);

implementation

{ TFcc_Tpmanut }

constructor TFcc_Tpmanut.Create(AOwner: TComponent);
begin
  inherited;

end;

destructor TFcc_Tpmanut.Destroy;
begin

  inherited;
end;

end.