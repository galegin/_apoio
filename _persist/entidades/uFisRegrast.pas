unit uFisRegrast;

interface

uses
  Classes, SysUtils,
  cCollection, cCollectionItem;

type
  TFis_Regrast = class;
  TFis_RegrastClass = class of TFis_Regrast;

  TFis_RegrastList = class;
  TFis_RegrastListClass = class of TFis_RegrastList;

  TFis_Regrast = class(TcCollectionItem)
  private
    fCd_Regrafiscal: Real;
    fU_Version: String;
    fCd_Operador: Real;
    fDt_Cadastro: TDateTime;
    fCd_Cst: String;
    fCd_Cfoppropria: Real;
    fCd_Cfopterceiro: Real;
    fPr_Redubase: Real;
    fPr_Mva: Real;
    fIn_Ipinabasest: String;
    fDs_Lstufpart: String;
  public
    constructor Create; reintroduce;
    destructor Destroy; override;
  published
    property Cd_Regrafiscal : Real read fCd_Regrafiscal write fCd_Regrafiscal;
    property U_Version : String read fU_Version write fU_Version;
    property Cd_Operador : Real read fCd_Operador write fCd_Operador;
    property Dt_Cadastro : TDateTime read fDt_Cadastro write fDt_Cadastro;
    property Cd_Cst : String read fCd_Cst write fCd_Cst;
    property Cd_Cfoppropria : Real read fCd_Cfoppropria write fCd_Cfoppropria;
    property Cd_Cfopterceiro : Real read fCd_Cfopterceiro write fCd_Cfopterceiro;
    property Pr_Redubase : Real read fPr_Redubase write fPr_Redubase;
    property Pr_Mva : Real read fPr_Mva write fPr_Mva;
    property In_Ipinabasest : String read fIn_Ipinabasest write fIn_Ipinabasest;
    property Ds_Lstufpart : String read fDs_Lstufpart write fDs_Lstufpart;
  end;

  TFis_RegrastList = class(TcCollection)
  private
    function GetItem(Index: Integer): TFis_Regrast;
    procedure SetItem(Index: Integer; Value: TFis_Regrast);
  public
    constructor Create(AOwner: TPersistent);
    function Add: TFis_Regrast;
    property Items[Index: Integer]: TFis_Regrast read GetItem write SetItem; default;
  end;
  
implementation

{ TFis_Regrast }

constructor TFis_Regrast.Create;
begin

end;

destructor TFis_Regrast.Destroy;
begin

  inherited;
end;

{ TFis_RegrastList }

constructor TFis_RegrastList.Create(AOwner: TPersistent);
begin
  inherited Create(TFis_Regrast);
end;

function TFis_RegrastList.Add: TFis_Regrast;
begin
  Result := TFis_Regrast(inherited Add);
  Result.create;
end;

function TFis_RegrastList.GetItem(Index: Integer): TFis_Regrast;
begin
  Result := TFis_Regrast(inherited GetItem(Index));
end;

procedure TFis_RegrastList.SetItem(Index: Integer; Value: TFis_Regrast);
begin
  inherited SetItem(Index, Value);
end;

end.