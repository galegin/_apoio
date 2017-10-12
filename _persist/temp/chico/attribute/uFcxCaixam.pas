unit uFcxCaixam;

interface

uses
  Classes, SysUtils,
  System.Generics.Collections,
  mMapping;

type
  [Tabela('FCX_CAIXAM')]
  TFcx_Caixam = class(TmMapping)
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
    [Campo('NR_CTAPES', tfKey)]
    property Nr_Ctapes : String read fNr_Ctapes write fNr_Ctapes;
    [Campo('DT_MOVIM', tfKey)]
    property Dt_Movim : String read fDt_Movim write fDt_Movim;
    [Campo('NR_SEQMOV', tfKey)]
    property Nr_Seqmov : String read fNr_Seqmov write fNr_Seqmov;
    [Campo('U_VERSION', tfNul)]
    property U_Version : String read fU_Version write fU_Version;
    [Campo('CD_OPERADOR', tfReq)]
    property Cd_Operador : String read fCd_Operador write fCd_Operador;
    [Campo('DT_CADASTRO', tfReq)]
    property Dt_Cadastro : String read fDt_Cadastro write fDt_Cadastro;
  end;

  TFcx_Caixams = class(TList<Fcx_Caixam>);

implementation

{ TFcx_Caixam }

constructor TFcx_Caixam.Create(AOwner: TComponent);
begin
  inherited;

end;

destructor TFcx_Caixam.Destroy;
begin

  inherited;
end;

end.