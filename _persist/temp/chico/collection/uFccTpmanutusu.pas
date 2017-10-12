unit uFccTpmanutusu;

interface

uses
  Classes, SysUtils,
  mCollection, mCollectionItem;

type
  TFcc_Tpmanutusu = class;
  TFcc_TpmanutusuClass = class of TFcc_Tpmanutusu;

  TFcc_TpmanutusuList = class;
  TFcc_TpmanutusuListClass = class of TFcc_TpmanutusuList;

  TFcc_Tpmanutusu = class(TmCollectionItem)
  private
    fCd_Empresa: String;
    fCd_Usuliberado: String;
    fTp_Manutencao: String;
    fU_Version: String;
    fCd_Operador: String;
    fDt_Cadastro: String;
    fIn_Versaldo: String;
    fIn_Ocultarmov: String;
  public
    constructor Create(ACollection: TCollection); override;
    destructor Destroy; override;
  published
    property Cd_Empresa : String read fCd_Empresa write SetCd_Empresa;
    property Cd_Usuliberado : String read fCd_Usuliberado write SetCd_Usuliberado;
    property Tp_Manutencao : String read fTp_Manutencao write SetTp_Manutencao;
    property U_Version : String read fU_Version write SetU_Version;
    property Cd_Operador : String read fCd_Operador write SetCd_Operador;
    property Dt_Cadastro : String read fDt_Cadastro write SetDt_Cadastro;
    property In_Versaldo : String read fIn_Versaldo write SetIn_Versaldo;
    property In_Ocultarmov : String read fIn_Ocultarmov write SetIn_Ocultarmov;
  end;

  TFcc_TpmanutusuList = class(TmCollection)
  private
    function GetItem(Index: Integer): TFcc_Tpmanutusu;
    procedure SetItem(Index: Integer; Value: TFcc_Tpmanutusu);
  public
    constructor Create(AOwner: TPersistentCollection);
    function Add: TFcc_Tpmanutusu;
    property Items[Index: Integer]: TFcc_Tpmanutusu read GetItem write SetItem; default;
  end;

implementation

{ TFcc_Tpmanutusu }

constructor TFcc_Tpmanutusu.Create(ACollection: TCollection);
begin
  inherited;

end;

destructor TFcc_Tpmanutusu.Destroy;
begin

  inherited;
end;

{ TFcc_TpmanutusuList }

constructor TFcc_TpmanutusuList.Create(AOwner: TPersistentCollection);
begin
  inherited Create(TFcc_Tpmanutusu);
end;

function TFcc_TpmanutusuList.Add: TFcc_Tpmanutusu;
begin
  Result := TFcc_Tpmanutusu(inherited Add);
  Result.create;
end;

function TFcc_TpmanutusuList.GetItem(Index: Integer): TFcc_Tpmanutusu;
begin
  Result := TFcc_Tpmanutusu(inherited GetItem(Index));
end;

procedure TFcc_TpmanutusuList.SetItem(Index: Integer; Value: TFcc_Tpmanutusu);
begin
  inherited SetItem(Index, Value);
end;

end.