unit uFisDanfeusu;

interface

uses
  Classes, SysUtils,
  cCollection, cCollectionItem;

type
  TFis_Danfeusu = class;
  TFis_DanfeusuClass = class of TFis_Danfeusu;

  TFis_DanfeusuList = class;
  TFis_DanfeusuListClass = class of TFis_DanfeusuList;

  TFis_Danfeusu = class(TcCollectionItem)
  private
    fCd_Usuario: Real;
    fCd_Definicao: String;
    fU_Version: String;
    fCd_Operador: Integer;
    fDt_Cadastro: TDateTime;
    fVl_Definicao: String;
  public
    constructor Create; reintroduce;
    destructor Destroy; override;
  published
    property Cd_Usuario : Real read fCd_Usuario write fCd_Usuario;
    property Cd_Definicao : String read fCd_Definicao write fCd_Definicao;
    property U_Version : String read fU_Version write fU_Version;
    property Cd_Operador : Integer read fCd_Operador write fCd_Operador;
    property Dt_Cadastro : TDateTime read fDt_Cadastro write fDt_Cadastro;
    property Vl_Definicao : String read fVl_Definicao write fVl_Definicao;
  end;

  TFis_DanfeusuList = class(TcCollection)
  private
    function GetItem(Index: Integer): TFis_Danfeusu;
    procedure SetItem(Index: Integer; Value: TFis_Danfeusu);
  public
    constructor Create(AOwner: TPersistent);
    function Add: TFis_Danfeusu;
    property Items[Index: Integer]: TFis_Danfeusu read GetItem write SetItem; default;
  end;
  
implementation

{ TFis_Danfeusu }

constructor TFis_Danfeusu.Create;
begin

end;

destructor TFis_Danfeusu.Destroy;
begin

  inherited;
end;

{ TFis_DanfeusuList }

constructor TFis_DanfeusuList.Create(AOwner: TPersistent);
begin
  inherited Create(TFis_Danfeusu);
end;

function TFis_DanfeusuList.Add: TFis_Danfeusu;
begin
  Result := TFis_Danfeusu(inherited Add);
  Result.create;
end;

function TFis_DanfeusuList.GetItem(Index: Integer): TFis_Danfeusu;
begin
  Result := TFis_Danfeusu(inherited GetItem(Index));
end;

procedure TFis_DanfeusuList.SetItem(Index: Integer; Value: TFis_Danfeusu);
begin
  inherited SetItem(Index, Value);
end;

end.