unit uFisCst;

interface

uses
  Classes, SysUtils,
  System.Generics.Collections,
  mMapping;

type
  [Tabela('FIS_CST')]
  TFis_Cst = class(TmMapping)
  private
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
  published
    [Campo('CD_CST', tfKey)]
    property Cd_Cst : String read fCd_Cst write fCd_Cst;
    [Campo('U_VERSION', tfNul)]
    property U_Version : String read fU_Version write fU_Version;
    [Campo('TP_CST', tfReq)]
    property Tp_Cst : String read fTp_Cst write fTp_Cst;
    [Campo('CD_OPERADOR', tfReq)]
    property Cd_Operador : String read fCd_Operador write fCd_Operador;
    [Campo('DT_CADASTRO', tfReq)]
    property Dt_Cadastro : String read fDt_Cadastro write fDt_Cadastro;
    [Campo('TP_REGIMESUB', tfNul)]
    property Tp_Regimesub : String read fTp_Regimesub write fTp_Regimesub;
    [Campo('IN_CALCICMS', tfNul)]
    property In_Calcicms : String read fIn_Calcicms write fIn_Calcicms;
    [Campo('DS_CST', tfReq)]
    property Ds_Cst : String read fDs_Cst write fDs_Cst;
  end;

  TFis_Csts = class(TList<Fis_Cst>);

implementation

{ TFis_Cst }

constructor TFis_Cst.Create(AOwner: TComponent);
begin
  inherited;

end;

destructor TFis_Cst.Destroy;
begin

  inherited;
end;

end.