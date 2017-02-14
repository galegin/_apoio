unit uFccTpmanutusu;

interface

uses
  Classes, SysUtils,
  cCollection, cCollectionItem;

type
  TFcc_Tpmanutusu = class;
  TFcc_TpmanutusuClass = class of TFcc_Tpmanutusu;

  TFcc_TpmanutusuList = class;
  TFcc_TpmanutusuListClass = class of TFcc_TpmanutusuList;

  TFcc_Tpmanutusu = class(TcCollectionItem)
  private
    fCd_Empresa: Real;
    fCd_Usuliberado: Real;
    fTp_Manutencao: Real;
    fU_Version: String;
    fCd_Operador: Real;
    fDt_Cadastro: TDateTime;
    fIn_Versaldo: String;
    fIn_Ocultarmov: String;
  public
    constructor Create; reintroduce;
    destructor Destroy; override;
  published
    property Cd_Empresa : Real read fCd_Empresa write fCd_Empresa;
    property Cd_Usuliberado : Real read fCd_Usuliberado write fCd_Usuliberado;
    property Tp_Manutencao : Real read fTp_Manutencao write fTp_Manutencao;
    property U_Version : String read fU_Version write fU_Version;
    property Cd_Operador : Real read fCd_Operador write fCd_Operador;
    property Dt_Cadastro : TDateTime read fDt_Cadastro write fDt_Cadastro;
    property In_Versaldo : String read fIn_Versaldo write fIn_Versaldo;
    property In_Ocultarmov : String read fIn_Ocultarmov write fIn_Ocultarmov;
  end;

  TFcc_TpmanutusuList = class(TcCollection)
  private
    function GetItem(Index: Integer): TFcc_Tpmanutusu;
    procedure SetItem(Index: Integer; Value: TFcc_Tpmanutusu);
  public
    constructor Create(AOwner: TPersistent);
    function Add: TFcc_Tpmanutusu;
    property Items[Index: Integer]: TFcc_Tpmanutusu read GetItem write SetItem; default;
  end;
  
implementation

{ TFcc_Tpmanutusu }

constructor TFcc_Tpmanutusu.Create;
begin

end;

destructor TFcc_Tpmanutusu.Destroy;
begin

  inherited;
end;

{ TFcc_TpmanutusuList }

constructor TFcc_TpmanutusuList.Create(AOwner: TPersistent);
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