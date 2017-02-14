unit uFisCst;

interface

uses
  Classes, SysUtils,
  cCollection, cCollectionItem;

type
  TFis_Cst = class;
  TFis_CstClass = class of TFis_Cst;

  TFis_CstList = class;
  TFis_CstListClass = class of TFis_CstList;

  TFis_Cst = class(TcCollectionItem)
  private
    fCd_Cst: String;
    fU_Version: String;
    fTp_Cst: Real;
    fCd_Operador: Real;
    fDt_Cadastro: TDateTime;
    fTp_Regimesub: String;
    fIn_Calcicms: String;
    fDs_Cst: String;
  public
    constructor Create; reintroduce;
    destructor Destroy; override;
  published
    property Cd_Cst : String read fCd_Cst write fCd_Cst;
    property U_Version : String read fU_Version write fU_Version;
    property Tp_Cst : Real read fTp_Cst write fTp_Cst;
    property Cd_Operador : Real read fCd_Operador write fCd_Operador;
    property Dt_Cadastro : TDateTime read fDt_Cadastro write fDt_Cadastro;
    property Tp_Regimesub : String read fTp_Regimesub write fTp_Regimesub;
    property In_Calcicms : String read fIn_Calcicms write fIn_Calcicms;
    property Ds_Cst : String read fDs_Cst write fDs_Cst;
  end;

  TFis_CstList = class(TcCollection)
  private
    function GetItem(Index: Integer): TFis_Cst;
    procedure SetItem(Index: Integer; Value: TFis_Cst);
  public
    constructor Create(AOwner: TPersistent);
    function Add: TFis_Cst;
    property Items[Index: Integer]: TFis_Cst read GetItem write SetItem; default;
  end;
  
implementation

{ TFis_Cst }

constructor TFis_Cst.Create;
begin

end;

destructor TFis_Cst.Destroy;
begin

  inherited;
end;

{ TFis_CstList }

constructor TFis_CstList.Create(AOwner: TPersistent);
begin
  inherited Create(TFis_Cst);
end;

function TFis_CstList.Add: TFis_Cst;
begin
  Result := TFis_Cst(inherited Add);
  Result.create;
end;

function TFis_CstList.GetItem(Index: Integer): TFis_Cst;
begin
  Result := TFis_Cst(inherited GetItem(Index));
end;

procedure TFis_CstList.SetItem(Index: Integer; Value: TFis_Cst);
begin
  inherited SetItem(Index, Value);
end;

end.