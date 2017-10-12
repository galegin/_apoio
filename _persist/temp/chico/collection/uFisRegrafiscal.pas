unit uFisRegrafiscal;

interface

uses
  Classes, SysUtils,
  mCollection, mCollectionItem;

type
  TFis_Regrafiscal = class;
  TFis_RegrafiscalClass = class of TFis_Regrafiscal;

  TFis_RegrafiscalList = class;
  TFis_RegrafiscalListClass = class of TFis_RegrafiscalList;

  TFis_Regrafiscal = class(TmCollectionItem)
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
    constructor Create(ACollection: TCollection); override;
    destructor Destroy; override;
  published
    property Cd_Regrafiscal : String read fCd_Regrafiscal write SetCd_Regrafiscal;
    property U_Version : String read fU_Version write SetU_Version;
    property Cd_Operador : String read fCd_Operador write SetCd_Operador;
    property Dt_Cadastro : String read fDt_Cadastro write SetDt_Cadastro;
    property Ds_Regrafiscal : String read fDs_Regrafiscal write SetDs_Regrafiscal;
    property Cd_Cst : String read fCd_Cst write SetCd_Cst;
    property Cd_Cfoppropria : String read fCd_Cfoppropria write SetCd_Cfoppropria;
    property Cd_Cfopterceiro : String read fCd_Cfopterceiro write SetCd_Cfopterceiro;
    property Cd_Decreto : String read fCd_Decreto write SetCd_Decreto;
    property In_Ipi : String read fIn_Ipi write SetIn_Ipi;
    property In_Iss : String read fIn_Iss write SetIn_Iss;
    property In_Cofins : String read fIn_Cofins write SetIn_Cofins;
    property In_Pis : String read fIn_Pis write SetIn_Pis;
    property In_Pasep : String read fIn_Pasep write SetIn_Pasep;
    property In_Ir : String read fIn_Ir write SetIn_Ir;
    property In_Cpmf : String read fIn_Cpmf write SetIn_Cpmf;
    property In_Csl : String read fIn_Csl write SetIn_Csl;
    property Pr_Redubase : String read fPr_Redubase write SetPr_Redubase;
    property Pr_Aliqicms : String read fPr_Aliqicms write SetPr_Aliqicms;
    property Pr_Aliqiss : String read fPr_Aliqiss write SetPr_Aliqiss;
    property Pr_Aliqcofins : String read fPr_Aliqcofins write SetPr_Aliqcofins;
    property Pr_Aliqpis : String read fPr_Aliqpis write SetPr_Aliqpis;
    property Pr_Aliqpasep : String read fPr_Aliqpasep write SetPr_Aliqpasep;
    property Pr_Aliqir : String read fPr_Aliqir write SetPr_Aliqir;
    property Pr_Aliqcpmf : String read fPr_Aliqcpmf write SetPr_Aliqcpmf;
    property Pr_Aliqcsl : String read fPr_Aliqcsl write SetPr_Aliqcsl;
    property Ds_Adicional : String read fDs_Adicional write SetDs_Adicional;
    property Tp_Reducao : String read fTp_Reducao write SetTp_Reducao;
    property Tp_Aliqicms : String read fTp_Aliqicms write SetTp_Aliqicms;
  end;

  TFis_RegrafiscalList = class(TmCollection)
  private
    function GetItem(Index: Integer): TFis_Regrafiscal;
    procedure SetItem(Index: Integer; Value: TFis_Regrafiscal);
  public
    constructor Create(AOwner: TPersistentCollection);
    function Add: TFis_Regrafiscal;
    property Items[Index: Integer]: TFis_Regrafiscal read GetItem write SetItem; default;
  end;

implementation

{ TFis_Regrafiscal }

constructor TFis_Regrafiscal.Create(ACollection: TCollection);
begin
  inherited;

end;

destructor TFis_Regrafiscal.Destroy;
begin

  inherited;
end;

{ TFis_RegrafiscalList }

constructor TFis_RegrafiscalList.Create(AOwner: TPersistentCollection);
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