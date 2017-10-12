unit uFcxHistrel;

interface

uses
  Classes, SysUtils,
  System.Generics.Collections,
  mMapping;

type
  [Tabela('FCX_HISTREL')]
  TFcx_Histrel = class(TmMapping)
  private
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
  published
    [Campo('TP_DOCUMENTO', tfKey)]
    property Tp_Documento : String read fTp_Documento write fTp_Documento;
    [Campo('U_VERSION', tfNul)]
    property U_Version : String read fU_Version write fU_Version;
    [Campo('CD_OPERADOR', tfReq)]
    property Cd_Operador : String read fCd_Operador write fCd_Operador;
    [Campo('DT_CADASTRO', tfReq)]
    property Dt_Cadastro : String read fDt_Cadastro write fDt_Cadastro;
    [Campo('CD_HISTORICO', tfNul)]
    property Cd_Historico : String read fCd_Historico write fCd_Historico;
    [Campo('CD_HISTFEC', tfNul)]
    property Cd_Histfec : String read fCd_Histfec write fCd_Histfec;
    [Campo('IN_TOTALIZADOR', tfNul)]
    property In_Totalizador : String read fIn_Totalizador write fIn_Totalizador;
    [Campo('IN_RECEBIMENTO', tfNul)]
    property In_Recebimento : String read fIn_Recebimento write fIn_Recebimento;
    [Campo('IN_FATURAMENTO', tfNul)]
    property In_Faturamento : String read fIn_Faturamento write fIn_Faturamento;
    [Campo('VL_AUX', tfNul)]
    property Vl_Aux : String read fVl_Aux write fVl_Aux;
    [Campo('NR_PORTADOR', tfNul)]
    property Nr_Portador : String read fNr_Portador write fNr_Portador;
  end;

  TFcx_Histrels = class(TList<Fcx_Histrel>);

implementation

{ TFcx_Histrel }

constructor TFcx_Histrel.Create(AOwner: TComponent);
begin
  inherited;

end;

destructor TFcx_Histrel.Destroy;
begin

  inherited;
end;

end.