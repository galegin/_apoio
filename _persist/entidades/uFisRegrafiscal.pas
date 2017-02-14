unit uFisRegrafiscal;

interface

uses
  Classes, SysUtils,
  cCollection, cCollectionItem;

type
  TFis_Regrafiscal = class;
  TFis_RegrafiscalClass = class of TFis_Regrafiscal;

  TFis_RegrafiscalList = class;
  TFis_RegrafiscalListClass = class of TFis_RegrafiscalList;

  TFis_Regrafiscal = class(TcCollectionItem)
  private
    fCd_Regrafiscal: Real;
    fU_Version: String;
    fCd_Operador: Real;
    fDt_Cadastro: TDateTime;
    fDs_Regrafiscal: String;
    fCd_Cst: String;
    fCd_Cfoppropria: Real;
    fCd_Cfopterceiro: Real;
    fCd_Decreto: Real;
    fIn_Ipi: String;
    fIn_Iss: String;
    fIn_Cofins: String;
    fIn_Pis: String;
    fIn_Pasep: String;
    fIn_Ir: String;
    fIn_Cpmf: String;
    fIn_Csl: String;
    fPr_Redubase: Real;
    fPr_Aliqicms: Real;
    fPr_Aliqiss: Real;
    fPr_Aliqcofins: Real;
    fPr_Aliqpis: Real;
    fPr_Aliqpasep: Real;
    fPr_Aliqir: Real;
    fPr_Aliqcpmf: Real;
    fPr_Aliqcsl: Real;
    fDs_Adicional: String;
    fTp_Reducao: String;
    fTp_Aliqicms: String;
  public
    constructor Create; reintroduce;
    destructor Destroy; override;
  published
    property Cd_Regrafiscal : Real read fCd_Regrafiscal write fCd_Regrafiscal;
    property U_Version : String read fU_Version write fU_Version;
    property Cd_Operador : Real read fCd_Operador write fCd_Operador;
    property Dt_Cadastro : TDateTime read fDt_Cadastro write fDt_Cadastro;
    property Ds_Regrafiscal : String read fDs_Regrafiscal write fDs_Regrafiscal;
    property Cd_Cst : String read fCd_Cst write fCd_Cst;
    property Cd_Cfoppropria : Real read fCd_Cfoppropria write fCd_Cfoppropria;
    property Cd_Cfopterceiro : Real read fCd_Cfopterceiro write fCd_Cfopterceiro;
    property Cd_Decreto : Real read fCd_Decreto write fCd_Decreto;
    property In_Ipi : String read fIn_Ipi write fIn_Ipi;
    property In_Iss : String read fIn_Iss write fIn_Iss;
    property In_Cofins : String read fIn_Cofins write fIn_Cofins;
    property In_Pis : String read fIn_Pis write fIn_Pis;
    property In_Pasep : String read fIn_Pasep write fIn_Pasep;
    property In_Ir : String read fIn_Ir write fIn_Ir;
    property In_Cpmf : String read fIn_Cpmf write fIn_Cpmf;
    property In_Csl : String read fIn_Csl write fIn_Csl;
    property Pr_Redubase : Real read fPr_Redubase write fPr_Redubase;
    property Pr_Aliqicms : Real read fPr_Aliqicms write fPr_Aliqicms;
    property Pr_Aliqiss : Real read fPr_Aliqiss write fPr_Aliqiss;
    property Pr_Aliqcofins : Real read fPr_Aliqcofins write fPr_Aliqcofins;
    property Pr_Aliqpis : Real read fPr_Aliqpis write fPr_Aliqpis;
    property Pr_Aliqpasep : Real read fPr_Aliqpasep write fPr_Aliqpasep;
    property Pr_Aliqir : Real read fPr_Aliqir write fPr_Aliqir;
    property Pr_Aliqcpmf : Real read fPr_Aliqcpmf write fPr_Aliqcpmf;
    property Pr_Aliqcsl : Real read fPr_Aliqcsl write fPr_Aliqcsl;
    property Ds_Adicional : String read fDs_Adicional write fDs_Adicional;
    property Tp_Reducao : String read fTp_Reducao write fTp_Reducao;
    property Tp_Aliqicms : String read fTp_Aliqicms write fTp_Aliqicms;
  end;

  TFis_RegrafiscalList = class(TcCollection)
  private
    function GetItem(Index: Integer): TFis_Regrafiscal;
    procedure SetItem(Index: Integer; Value: TFis_Regrafiscal);
  public
    constructor Create(AOwner: TPersistent);
    function Add: TFis_Regrafiscal;
    property Items[Index: Integer]: TFis_Regrafiscal read GetItem write SetItem; default;
  end;
  
implementation

{ TFis_Regrafiscal }

constructor TFis_Regrafiscal.Create;
begin

end;

destructor TFis_Regrafiscal.Destroy;
begin

  inherited;
end;

{ TFis_RegrafiscalList }

constructor TFis_RegrafiscalList.Create(AOwner: TPersistent);
begin
  inherited Create(TFis_Regrafiscal);
end;

function TFis_RegrafiscalList.Add: TFis_Regrafiscal;
begin
  Result := TFis_Regrafiscal(inherited Add);
  Result.create;
end;

function TFis_RegrafiscalList.GetItem(Index: Integer): TFis_Regrafiscal;
begin
  Result := TFis_Regrafiscal(inherited GetItem(Index));
end;

procedure TFis_RegrafiscalList.SetItem(Index: Integer; Value: TFis_Regrafiscal);
begin
  inherited SetItem(Index, Value);
end;

end.