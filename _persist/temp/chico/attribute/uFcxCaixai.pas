unit uFcxCaixai;

interface

uses
  Classes, SysUtils,
  System.Generics.Collections,
  mMapping;

type
  [Tabela('FCX_CAIXAI')]
  TFcx_Caixai = class(TmMapping)
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
    [Campo('NR_SEQITEM', tfKey)]
    property Nr_Seqitem : String read fNr_Seqitem write fNr_Seqitem;
    [Campo('U_VERSION', tfNul)]
    property U_Version : String read fU_Version write fU_Version;
    [Campo('CD_OPERADOR', tfReq)]
    property Cd_Operador : String read fCd_Operador write fCd_Operador;
    [Campo('DT_CADASTRO', tfReq)]
    property Dt_Cadastro : String read fDt_Cadastro write fDt_Cadastro;
    [Campo('TP_DOCUMENTO', tfReq)]
    property Tp_Documento : String read fTp_Documento write fTp_Documento;
    [Campo('NR_SEQHISTRELSUB', tfReq)]
    property Nr_Seqhistrelsub : String read fNr_Seqhistrelsub write fNr_Seqhistrelsub;
    [Campo('NR_PORTADOR', tfNul)]
    property Nr_Portador : String read fNr_Portador write fNr_Portador;
    [Campo('VL_CONTADO', tfNul)]
    property Vl_Contado : String read fVl_Contado write fVl_Contado;
    [Campo('VL_SISTEMA', tfNul)]
    property Vl_Sistema : String read fVl_Sistema write fVl_Sistema;
    [Campo('VL_DIFERENCA', tfNul)]
    property Vl_Diferenca : String read fVl_Diferenca write fVl_Diferenca;
    [Campo('VL_FUNDO', tfNul)]
    property Vl_Fundo : String read fVl_Fundo write fVl_Fundo;
  end;

  TFcx_Caixais = class(TList<Fcx_Caixai>);

implementation

{ TFcx_Caixai }

constructor TFcx_Caixai.Create(AOwner: TComponent);
begin
  inherited;

end;

destructor TFcx_Caixai.Destroy;
begin

  inherited;
end;

end.