unit uFisCfop;

interface

uses
  Classes, SysUtils,
  System.Generics.Collections,
  mMapping;

type
  [Tabela('FIS_CFOP')]
  TFis_Cfop = class(TmMapping)
  private
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
  published
    [Campo('TP_OPERACAO', tfKey)]
    property Tp_Operacao : String read fTp_Operacao write fTp_Operacao;
    [Campo('TP_CONTRIBUINTE', tfKey)]
    property Tp_Contribuinte : String read fTp_Contribuinte write fTp_Contribuinte;
    [Campo('TP_TRANSACAO', tfKey)]
    property Tp_Transacao : String read fTp_Transacao write fTp_Transacao;
    [Campo('TP_PRODUCAO', tfKey)]
    property Tp_Producao : String read fTp_Producao write fTp_Producao;
    [Campo('TP_COMERCIAL', tfKey)]
    property Tp_Comercial : String read fTp_Comercial write fTp_Comercial;
    [Campo('TP_MODALIDADE', tfKey)]
    property Tp_Modalidade : String read fTp_Modalidade write fTp_Modalidade;
    [Campo('TP_REGIMESUB', tfKey)]
    property Tp_Regimesub : String read fTp_Regimesub write fTp_Regimesub;
    [Campo('TP_FINALCOMPRA', tfKey)]
    property Tp_Finalcompra : String read fTp_Finalcompra write fTp_Finalcompra;
    [Campo('U_VERSION', tfNul)]
    property U_Version : String read fU_Version write fU_Version;
    [Campo('CD_CFOP', tfReq)]
    property Cd_Cfop : String read fCd_Cfop write fCd_Cfop;
    [Campo('CD_OPERADOR', tfReq)]
    property Cd_Operador : String read fCd_Operador write fCd_Operador;
    [Campo('DT_CADASTRO', tfReq)]
    property Dt_Cadastro : String read fDt_Cadastro write fDt_Cadastro;
    [Campo('DS_CFOP', tfReq)]
    property Ds_Cfop : String read fDs_Cfop write fDs_Cfop;
  end;

  TFis_Cfops = class(TList<Fis_Cfop>);

implementation

{ TFis_Cfop }

constructor TFis_Cfop.Create(AOwner: TComponent);
begin
  inherited;

end;

destructor TFis_Cfop.Destroy;
begin

  inherited;
end;

end.