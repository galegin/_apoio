unit uFcxCaixac;

interface

uses
  Classes, SysUtils,
  System.Generics.Collections,
  mMapping;

type
  [Tabela('FCX_CAIXAC')]
  TFcx_Caixac = class(TmMapping)
  private
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
  published
    [Campo('CD_EMPRESA', tfKey)]
    property Cd_Empresa : String read fCd_Empresa write fCd_Empresa;
    [Campo('CD_TERMINAL', tfKey)]
    property Cd_Terminal : String read fCd_Terminal write fCd_Terminal;
    [Campo('DT_ABERTURA', tfKey)]
    property Dt_Abertura : String read fDt_Abertura write fDt_Abertura;
    [Campo('NR_SEQ', tfKey)]
    property Nr_Seq : String read fNr_Seq write fNr_Seq;
    [Campo('U_VERSION', tfNul)]
    property U_Version : String read fU_Version write fU_Version;
    [Campo('CD_OPERADOR', tfReq)]
    property Cd_Operador : String read fCd_Operador write fCd_Operador;
    [Campo('DT_CADASTRO', tfReq)]
    property Dt_Cadastro : String read fDt_Cadastro write fDt_Cadastro;
    [Campo('CD_OPERCX', tfNul)]
    property Cd_Opercx : String read fCd_Opercx write fCd_Opercx;
    [Campo('CD_OPERCONF', tfNul)]
    property Cd_Operconf : String read fCd_Operconf write fCd_Operconf;
    [Campo('NR_CTAPES', tfReq)]
    property Nr_Ctapes : String read fNr_Ctapes write fNr_Ctapes;
    [Campo('DS_FECHAMENTO', tfNul)]
    property Ds_Fechamento : String read fDs_Fechamento write fDs_Fechamento;
    [Campo('VL_ABERTURA', tfNul)]
    property Vl_Abertura : String read fVl_Abertura write fVl_Abertura;
    [Campo('IN_FECHADO', tfNul)]
    property In_Fechado : String read fIn_Fechado write fIn_Fechado;
    [Campo('DT_FECHADO', tfNul)]
    property Dt_Fechado : String read fDt_Fechado write fDt_Fechado;
    [Campo('IN_DIFERENCA', tfNul)]
    property In_Diferenca : String read fIn_Diferenca write fIn_Diferenca;
  end;

  TFcx_Caixacs = class(TList<Fcx_Caixac>);

implementation

{ TFcx_Caixac }

constructor TFcx_Caixac.Create(AOwner: TComponent);
begin
  inherited;

end;

destructor TFcx_Caixac.Destroy;
begin

  inherited;
end;

end.