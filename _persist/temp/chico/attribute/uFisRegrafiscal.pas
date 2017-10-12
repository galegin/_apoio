unit uFisRegrafiscal;

interface

uses
  Classes, SysUtils,
  System.Generics.Collections,
  mMapping;

type
  [Tabela('FIS_REGRAFISCAL')]
  TFis_Regrafiscal = class(TmMapping)
  private
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
  published
    [Campo('CD_REGRAFISCAL', tfKey)]
    property Cd_Regrafiscal : String read fCd_Regrafiscal write fCd_Regrafiscal;
    [Campo('U_VERSION', tfNul)]
    property U_Version : String read fU_Version write fU_Version;
    [Campo('CD_OPERADOR', tfReq)]
    property Cd_Operador : String read fCd_Operador write fCd_Operador;
    [Campo('DT_CADASTRO', tfReq)]
    property Dt_Cadastro : String read fDt_Cadastro write fDt_Cadastro;
    [Campo('DS_REGRAFISCAL', tfNul)]
    property Ds_Regrafiscal : String read fDs_Regrafiscal write fDs_Regrafiscal;
    [Campo('CD_CST', tfNul)]
    property Cd_Cst : String read fCd_Cst write fCd_Cst;
    [Campo('CD_CFOPPROPRIA', tfReq)]
    property Cd_Cfoppropria : String read fCd_Cfoppropria write fCd_Cfoppropria;
    [Campo('CD_CFOPTERCEIRO', tfReq)]
    property Cd_Cfopterceiro : String read fCd_Cfopterceiro write fCd_Cfopterceiro;
    [Campo('CD_DECRETO', tfNul)]
    property Cd_Decreto : String read fCd_Decreto write fCd_Decreto;
    [Campo('IN_IPI', tfNul)]
    property In_Ipi : String read fIn_Ipi write fIn_Ipi;
    [Campo('IN_ISS', tfNul)]
    property In_Iss : String read fIn_Iss write fIn_Iss;
    [Campo('IN_COFINS', tfNul)]
    property In_Cofins : String read fIn_Cofins write fIn_Cofins;
    [Campo('IN_PIS', tfNul)]
    property In_Pis : String read fIn_Pis write fIn_Pis;
    [Campo('IN_PASEP', tfNul)]
    property In_Pasep : String read fIn_Pasep write fIn_Pasep;
    [Campo('IN_IR', tfNul)]
    property In_Ir : String read fIn_Ir write fIn_Ir;
    [Campo('IN_CPMF', tfNul)]
    property In_Cpmf : String read fIn_Cpmf write fIn_Cpmf;
    [Campo('IN_CSL', tfNul)]
    property In_Csl : String read fIn_Csl write fIn_Csl;
    [Campo('PR_REDUBASE', tfNul)]
    property Pr_Redubase : String read fPr_Redubase write fPr_Redubase;
    [Campo('PR_ALIQICMS', tfNul)]
    property Pr_Aliqicms : String read fPr_Aliqicms write fPr_Aliqicms;
    [Campo('PR_ALIQISS', tfNul)]
    property Pr_Aliqiss : String read fPr_Aliqiss write fPr_Aliqiss;
    [Campo('PR_ALIQCOFINS', tfNul)]
    property Pr_Aliqcofins : String read fPr_Aliqcofins write fPr_Aliqcofins;
    [Campo('PR_ALIQPIS', tfNul)]
    property Pr_Aliqpis : String read fPr_Aliqpis write fPr_Aliqpis;
    [Campo('PR_ALIQPASEP', tfNul)]
    property Pr_Aliqpasep : String read fPr_Aliqpasep write fPr_Aliqpasep;
    [Campo('PR_ALIQIR', tfNul)]
    property Pr_Aliqir : String read fPr_Aliqir write fPr_Aliqir;
    [Campo('PR_ALIQCPMF', tfNul)]
    property Pr_Aliqcpmf : String read fPr_Aliqcpmf write fPr_Aliqcpmf;
    [Campo('PR_ALIQCSL', tfNul)]
    property Pr_Aliqcsl : String read fPr_Aliqcsl write fPr_Aliqcsl;
    [Campo('DS_ADICIONAL', tfNul)]
    property Ds_Adicional : String read fDs_Adicional write fDs_Adicional;
    [Campo('TP_REDUCAO', tfNul)]
    property Tp_Reducao : String read fTp_Reducao write fTp_Reducao;
    [Campo('TP_ALIQICMS', tfNul)]
    property Tp_Aliqicms : String read fTp_Aliqicms write fTp_Aliqicms;
  end;

  TFis_Regrafiscals = class(TList<Fis_Regrafiscal>);

implementation

{ TFis_Regrafiscal }

constructor TFis_Regrafiscal.Create(AOwner: TComponent);
begin
  inherited;

end;

destructor TFis_Regrafiscal.Destroy;
begin

  inherited;
end;

end.