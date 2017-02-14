unit uFccTpmanut;

interface

uses
  Classes, SysUtils,
  cCollection, cCollectionItem;

type
  TFcc_Tpmanut = class;
  TFcc_TpmanutClass = class of TFcc_Tpmanut;

  TFcc_TpmanutList = class;
  TFcc_TpmanutListClass = class of TFcc_TpmanutList;

  TFcc_Tpmanut = class(TcCollectionItem)
  private
    fTp_Manutencao: Real;
    fU_Version: String;
    fCd_Operador: Real;
    fDt_Cadastro: TDateTime;
    fDs_Manutencao: String;
  public
    constructor Create; reintroduce;
    destructor Destroy; override;
  published
    property Tp_Manutencao : Real read fTp_Manutencao write fTp_Manutencao;
    property U_Version : String read fU_Version write fU_Version;
    property Cd_Operador : Real read fCd_Operador write fCd_Operador;
    property Dt_Cadastro : TDateTime read fDt_Cadastro write fDt_Cadastro;
    property Ds_Manutencao : String read fDs_Manutencao write fDs_Manutencao;
  end;

  TFcc_TpmanutList = class(TcCollection)
  private
    function GetItem(Index: Integer): TFcc_Tpmanut;
    procedure SetItem(Index: Integer; Value: TFcc_Tpmanut);
  public
    constructor Create(AOwner: TPersistent);
    function Add: TFcc_Tpmanut;
    property Items[Index: Integer]: TFcc_Tpmanut read GetItem write SetItem; default;
  end;
  
implementation

{ TFcc_Tpmanut }

constructor TFcc_Tpmanut.Create;
begin

end;

destructor TFcc_Tpmanut.Destroy;
begin

  inherited;
end;

{ TFcc_TpmanutList }

constructor TFcc_TpmanutList.Create(AOwner: TPersistent);
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