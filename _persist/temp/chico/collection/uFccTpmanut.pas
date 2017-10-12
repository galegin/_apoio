unit uFccTpmanut;

interface

uses
  Classes, SysUtils,
  mCollection, mCollectionItem;

type
  TFcc_Tpmanut = class;
  TFcc_TpmanutClass = class of TFcc_Tpmanut;

  TFcc_TpmanutList = class;
  TFcc_TpmanutListClass = class of TFcc_TpmanutList;

  TFcc_Tpmanut = class(TmCollectionItem)
  private
    fTp_Manutencao: String;
    fU_Version: String;
    fCd_Operador: String;
    fDt_Cadastro: String;
    fDs_Manutencao: String;
  public
    constructor Create(ACollection: TCollection); override;
    destructor Destroy; override;
  published
    property Tp_Manutencao : String read fTp_Manutencao write SetTp_Manutencao;
    property U_Version : String read fU_Version write SetU_Version;
    property Cd_Operador : String read fCd_Operador write SetCd_Operador;
    property Dt_Cadastro : String read fDt_Cadastro write SetDt_Cadastro;
    property Ds_Manutencao : String read fDs_Manutencao write SetDs_Manutencao;
  end;

  TFcc_TpmanutList = class(TmCollection)
  private
    function GetItem(Index: Integer): TFcc_Tpmanut;
    procedure SetItem(Index: Integer; Value: TFcc_Tpmanut);
  public
    constructor Create(AOwner: TPersistentCollection);
    function Add: TFcc_Tpmanut;
    property Items[Index: Integer]: TFcc_Tpmanut read GetItem write SetItem; default;
  end;

implementation

{ TFcc_Tpmanut }

constructor TFcc_Tpmanut.Create(ACollection: TCollection);
begin
  inherited;

end;

destructor TFcc_Tpmanut.Destroy;
begin

  inherited;
end;

{ TFcc_TpmanutList }

constructor TFcc_TpmanutList.Create(AOwner: TPersistentCollection);
begin
  inherited Create(TFcc_Tpmanut);
end;

function TFcc_TpmanutList.Add: TFcc_Tpmanut;
begin
  Result := TFcc_Tpmanut(inherited Add);
  Result.create;
end;

function TFcc_TpmanutList.GetItem(Index: Integer): TFcc_Tpmanut;
begin
  Result := TFcc_Tpmanut(inherited GetItem(Index));
end;

procedure TFcc_TpmanutList.SetItem(Index: Integer; Value: TFcc_Tpmanut);
begin
  inherited SetItem(Index, Value);
end;

end.