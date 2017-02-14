unit uFisDifaliqc;

interface

uses
  Classes, SysUtils,
  cCollection, cCollectionItem;

type
  TFis_Difaliqc = class;
  TFis_DifaliqcClass = class of TFis_Difaliqc;

  TFis_DifaliqcList = class;
  TFis_DifaliqcListClass = class of TFis_DifaliqcList;

  TFis_Difaliqc = class(TcCollectionItem)
  private
    fCd_Empresa: Real;
    fNr_Fatura: Real;
    fDt_Fatura: TDateTime;
    fCd_Detalhamento: Real;
    fU_Version: String;
    fCd_Operador: Real;
    fDt_Cadastro: TDateTime;
    fVl_Difaliq: Real;
  public
    constructor Create; reintroduce;
    destructor Destroy; override;
  published
    property Cd_Empresa : Real read fCd_Empresa write fCd_Empresa;
    property Nr_Fatura : Real read fNr_Fatura write fNr_Fatura;
    property Dt_Fatura : TDateTime read fDt_Fatura write fDt_Fatura;
    property Cd_Detalhamento : Real read fCd_Detalhamento write fCd_Detalhamento;
    property U_Version : String read fU_Version write fU_Version;
    property Cd_Operador : Real read fCd_Operador write fCd_Operador;
    property Dt_Cadastro : TDateTime read fDt_Cadastro write fDt_Cadastro;
    property Vl_Difaliq : Real read fVl_Difaliq write fVl_Difaliq;
  end;

  TFis_DifaliqcList = class(TcCollection)
  private
    function GetItem(Index: Integer): TFis_Difaliqc;
    procedure SetItem(Index: Integer; Value: TFis_Difaliqc);
  public
    constructor Create(AOwner: TPersistent);
    function Add: TFis_Difaliqc;
    property Items[Index: Integer]: TFis_Difaliqc read GetItem write SetItem; default;
  end;
  
implementation

{ TFis_Difaliqc }

constructor TFis_Difaliqc.Create;
begin

end;

destructor TFis_Difaliqc.Destroy;
begin

  inherited;
end;

{ TFis_DifaliqcList }

constructor TFis_DifaliqcList.Create(AOwner: TPersistent);
begin
  inherited Create(TFis_Difaliqc);
end;

function TFis_DifaliqcList.Add: TFis_Difaliqc;
begin
  Result := TFis_Difaliqc(inherited Add);
  Result.create;
end;

function TFis_DifaliqcList.GetItem(Index: Integer): TFis_Difaliqc;
begin
  Result := TFis_Difaliqc(inherited GetItem(Index));
end;

procedure TFis_DifaliqcList.SetItem(Index: Integer; Value: TFis_Difaliqc);
begin
  inherited SetItem(Index, Value);
end;

end.