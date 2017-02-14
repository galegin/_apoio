unit uFisDifaliqi;

interface

uses
  Classes, SysUtils,
  cCollection, cCollectionItem;

type
  TFis_Difaliqi = class;
  TFis_DifaliqiClass = class of TFis_Difaliqi;

  TFis_DifaliqiList = class;
  TFis_DifaliqiListClass = class of TFis_DifaliqiList;

  TFis_Difaliqi = class(TcCollectionItem)
  private
    fCd_Empresa: Real;
    fNr_Fatura: Real;
    fDt_Fatura: TDateTime;
    fCd_Detalhamento: Real;
    fNr_Item: Real;
    fU_Version: String;
    fCd_Operador: Real;
    fDt_Cadastro: TDateTime;
    fVl_Basecalc: Real;
    fVl_Difaliq: Real;
    fPr_Aliquota: Real;
  public
    constructor Create; reintroduce;
    destructor Destroy; override;
  published
    property Cd_Empresa : Real read fCd_Empresa write fCd_Empresa;
    property Nr_Fatura : Real read fNr_Fatura write fNr_Fatura;
    property Dt_Fatura : TDateTime read fDt_Fatura write fDt_Fatura;
    property Cd_Detalhamento : Real read fCd_Detalhamento write fCd_Detalhamento;
    property Nr_Item : Real read fNr_Item write fNr_Item;
    property U_Version : String read fU_Version write fU_Version;
    property Cd_Operador : Real read fCd_Operador write fCd_Operador;
    property Dt_Cadastro : TDateTime read fDt_Cadastro write fDt_Cadastro;
    property Vl_Basecalc : Real read fVl_Basecalc write fVl_Basecalc;
    property Vl_Difaliq : Real read fVl_Difaliq write fVl_Difaliq;
    property Pr_Aliquota : Real read fPr_Aliquota write fPr_Aliquota;
  end;

  TFis_DifaliqiList = class(TcCollection)
  private
    function GetItem(Index: Integer): TFis_Difaliqi;
    procedure SetItem(Index: Integer; Value: TFis_Difaliqi);
  public
    constructor Create(AOwner: TPersistent);
    function Add: TFis_Difaliqi;
    property Items[Index: Integer]: TFis_Difaliqi read GetItem write SetItem; default;
  end;
  
implementation

{ TFis_Difaliqi }

constructor TFis_Difaliqi.Create;
begin

end;

destructor TFis_Difaliqi.Destroy;
begin

  inherited;
end;

{ TFis_DifaliqiList }

constructor TFis_DifaliqiList.Create(AOwner: TPersistent);
begin
  inherited Create(TFis_Difaliqi);
end;

function TFis_DifaliqiList.Add: TFis_Difaliqi;
begin
  Result := TFis_Difaliqi(inherited Add);
  Result.create;
end;

function TFis_DifaliqiList.GetItem(Index: Integer): TFis_Difaliqi;
begin
  Result := TFis_Difaliqi(inherited GetItem(Index));
end;

procedure TFis_DifaliqiList.SetItem(Index: Integer; Value: TFis_Difaliqi);
begin
  inherited SetItem(Index, Value);
end;

end.