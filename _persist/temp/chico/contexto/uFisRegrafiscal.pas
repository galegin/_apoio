unit uFisRegrafiscal;

interface

uses
  Classes, SysUtils,
  mMapping;

type
  TFis_Regrafiscal = class(TmMapping)
  private
    fCd_Regrafiscal: String;
    fU_Version: String;
    fCd_Operador: String;
    fDt_Cadastro: String;
    fDs_Regrafiscal: String;
    fCd_Cst: String;
    fCd_Cfoppropria: String;
    fCd_Cfopterceiro: String;
    fCd_Decreto: String;
    fIn_Ipi: String;
    fIn_Iss: String;
    fIn_Cofins: String;
    fIn_Pis: String;
    fIn_Pasep: String;
    fIn_Ir: String;
    fIn_Cpmf: String;
    fIn_Csl: String;
    fPr_Redubase: String;
    fPr_Aliqicms: String;
    fPr_Aliqiss: String;
    fPr_Aliqcofins: String;
    fPr_Aliqpis: String;
    fPr_Aliqpasep: String;
    fPr_Aliqir: String;
    fPr_Aliqcpmf: String;
    fPr_Aliqcsl: String;
    fDs_Adicional: String;
    fTp_Reducao: String;
    fTp_Aliqicms: String;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function GetMapping() : PmMapping; override;
  published
    property Cd_Regrafiscal : String read fCd_Regrafiscal write fCd_Regrafiscal;
    property U_Version : String read fU_Version write fU_Version;
    property Cd_Operador : String read fCd_Operador write fCd_Operador;
    property Dt_Cadastro : String read fDt_Cadastro write fDt_Cadastro;
    property Ds_Regrafiscal : String read fDs_Regrafiscal write fDs_Regrafiscal;
    property Cd_Cst : String read fCd_Cst write fCd_Cst;
    property Cd_Cfoppropria : String read fCd_Cfoppropria write fCd_Cfoppropria;
    property Cd_Cfopterceiro : String read fCd_Cfopterceiro write fCd_Cfopterceiro;
    property Cd_Decreto : String read fCd_Decreto write fCd_Decreto;
    property In_Ipi : String read fIn_Ipi write fIn_Ipi;
    property In_Iss : String read fIn_Iss write fIn_Iss;
    property In_Cofins : String read fIn_Cofins write fIn_Cofins;
    property In_Pis : String read fIn_Pis write fIn_Pis;
    property In_Pasep : String read fIn_Pasep write fIn_Pasep;
    property In_Ir : String read fIn_Ir write fIn_Ir;
    property In_Cpmf : String read fIn_Cpmf write fIn_Cpmf;
    property In_Csl : String read fIn_Csl write fIn_Csl;
    property Pr_Redubase : String read fPr_Redubase write fPr_Redubase;
    property Pr_Aliqicms : String read fPr_Aliqicms write fPr_Aliqicms;
    property Pr_Aliqiss : String read fPr_Aliqiss write fPr_Aliqiss;
    property Pr_Aliqcofins : String read fPr_Aliqcofins write fPr_Aliqcofins;
    property Pr_Aliqpis : String read fPr_Aliqpis write fPr_Aliqpis;
    property Pr_Aliqpasep : String read fPr_Aliqpasep write fPr_Aliqpasep;
    property Pr_Aliqir : String read fPr_Aliqir write fPr_Aliqir;
    property Pr_Aliqcpmf : String read fPr_Aliqcpmf write fPr_Aliqcpmf;
    property Pr_Aliqcsl : String read fPr_Aliqcsl write fPr_Aliqcsl;
    property Ds_Adicional : String read fDs_Adicional write fDs_Adicional;
    property Tp_Reducao : String read fTp_Reducao write fTp_Reducao;
    property Tp_Aliqicms : String read fTp_Aliqicms write fTp_Aliqicms;
  end;

  TFis_Regrafiscals = class(TList)
  public
    function Add: TFis_Regrafiscal; overload;
  end;

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

//--

function TFis_Regrafiscal.GetMapping: PmMapping;
begin
  Result := New(PmMapping);

  Result.Tabela := New(PmTabela);
  with Result.Tabela^ do begin
    Nome := 'FIS_REGRAFISCAL';
  end;

  Result.Campos := TmCampos.Create;
  with Result.Campos do begin
    Add('Cd_Regrafiscal', 'CD_REGRAFISCAL', tfKey);
    Add('U_Version', 'U_VERSION', tfNul);
    Add('Cd_Operador', 'CD_OPERADOR', tfReq);
    Add('Dt_Cadastro', 'DT_CADASTRO', tfReq);
    Add('Ds_Regrafiscal', 'DS_REGRAFISCAL', tfNul);
    Add('Cd_Cst', 'CD_CST', tfNul);
    Add('Cd_Cfoppropria', 'CD_CFOPPROPRIA', tfReq);
    Add('Cd_Cfopterceiro', 'CD_CFOPTERCEIRO', tfReq);
    Add('Cd_Decreto', 'CD_DECRETO', tfNul);
    Add('In_Ipi', 'IN_IPI', tfNul);
    Add('In_Iss', 'IN_ISS', tfNul);
    Add('In_Cofins', 'IN_COFINS', tfNul);
    Add('In_Pis', 'IN_PIS', tfNul);
    Add('In_Pasep', 'IN_PASEP', tfNul);
    Add('In_Ir', 'IN_IR', tfNul);
    Add('In_Cpmf', 'IN_CPMF', tfNul);
    Add('In_Csl', 'IN_CSL', tfNul);
    Add('Pr_Redubase', 'PR_REDUBASE', tfNul);
    Add('Pr_Aliqicms', 'PR_ALIQICMS', tfNul);
    Add('Pr_Aliqiss', 'PR_ALIQISS', tfNul);
    Add('Pr_Aliqcofins', 'PR_ALIQCOFINS', tfNul);
    Add('Pr_Aliqpis', 'PR_ALIQPIS', tfNul);
    Add('Pr_Aliqpasep', 'PR_ALIQPASEP', tfNul);
    Add('Pr_Aliqir', 'PR_ALIQIR', tfNul);
    Add('Pr_Aliqcpmf', 'PR_ALIQCPMF', tfNul);
    Add('Pr_Aliqcsl', 'PR_ALIQCSL', tfNul);
    Add('Ds_Adicional', 'DS_ADICIONAL', tfNul);
    Add('Tp_Reducao', 'TP_REDUCAO', tfNul);
    Add('Tp_Aliqicms', 'TP_ALIQICMS', tfNul);
  end;

  Result.Relacoes := TmRelacoes.Create;
  with Result.Relacoes do begin
  end;
end;

//--

{ TFis_Regrafiscals }

function TFis_Regrafiscals.Add: TFis_Regrafiscal;
begin
  Result := TFis_Regrafiscal.Create(nil);
  Self.Add(Result);
end;

end.