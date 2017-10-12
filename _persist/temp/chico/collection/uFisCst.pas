unit uFisCst;

interface

uses
  Classes, SysUtils,
  mCollection, mCollectionItem;

type
  TFis_Cst = class;
  TFis_CstClass = class of TFis_Cst;

  TFis_CstList = class;
  TFis_CstListClass = class of TFis_CstList;

  TFis_Cst = class(TmCollectionItem)
  private
    fCd_Cst: String;
    fU_Version: String;
    fTp_Cst: String;
    fCd_Operador: String;
    fDt_Cadastro: String;
    fTp_Regimesub: String;
    fIn_Calcicms: String;
    fDs_Cst: String;
  public
    constructor Create(ACollection: TCollection); override;
    destructor Destroy; override;
  published
    property Cd_Cst : String read fCd_Cst write SetCd_Cst;
    property U_Version : String read fU_Version write SetU_Version;
    property Tp_Cst : String read fTp_Cst write SetTp_Cst;
    property Cd_Operador : String read fCd_Operador write SetCd_Operador;
    property Dt_Cadastro : String read fDt_Cadastro write SetDt_Cadastro;
    property Tp_Regimesub : String read fTp_Regimesub write SetTp_Regimesub;
    property In_Calcicms : String read fIn_Calcicms write SetIn_Calcicms;
    property Ds_Cst : String read fDs_Cst write SetDs_Cst;
  end;

  TFis_CstList = class(TmCollection)
  private
    function GetItem(Index: Integer): TFis_Cst;
    procedure SetItem(Index: Integer; Value: TFis_Cst);
  public
    constructor Create(AOwner: TPersistentCollection);
    function Add: TFis_Cst;
    property Items[Index: Integer]: TFis_Cst read GetItem write SetItem; default;
  end;

implementation

{ TFis_Cst }

constructor TFis_Cst.Create(ACollection: TCollection);
begin
  inherited;

end;

destructor TFis_Cst.Destroy;
begin

  inherited;
end;

{ TFis_CstList }

constructor TFis_CstList.Create(AOwner: TPersistentCollection);
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