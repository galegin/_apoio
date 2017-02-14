unit uLogBiometria;

interface

uses
  Classes, SysUtils,
  cCollection, cCollectionItem;

type
  TLog_Biometria = class;
  TLog_BiometriaClass = class of TLog_Biometria;

  TLog_BiometriaList = class;
  TLog_BiometriaListClass = class of TLog_BiometriaList;

  TLog_Biometria = class(TcCollectionItem)
  private
    fCd_Biometria: Real;
    fU_Version: String;
    fCd_Operador: Real;
    fDt_Cadastro: TDateTime;
    fDs_Biometria: String;
    fCd_Usuario: Real;
    fCd_Pessoa: Real;
    fCd_Empresa: Real;
  public
    constructor Create; reintroduce;
    destructor Destroy; override;
  published
    property Cd_Biometria : Real read fCd_Biometria write fCd_Biometria;
    property U_Version : String read fU_Version write fU_Version;
    property Cd_Operador : Real read fCd_Operador write fCd_Operador;
    property Dt_Cadastro : TDateTime read fDt_Cadastro write fDt_Cadastro;
    property Ds_Biometria : String read fDs_Biometria write fDs_Biometria;
    property Cd_Usuario : Real read fCd_Usuario write fCd_Usuario;
    property Cd_Pessoa : Real read fCd_Pessoa write fCd_Pessoa;
    property Cd_Empresa : Real read fCd_Empresa write fCd_Empresa;
  end;

  TLog_BiometriaList = class(TcCollection)
  private
    function GetItem(Index: Integer): TLog_Biometria;
    procedure SetItem(Index: Integer; Value: TLog_Biometria);
  public
    constructor Create(AOwner: TPersistent);
    function Add: TLog_Biometria;
    property Items[Index: Integer]: TLog_Biometria read GetItem write SetItem; default;
  end;
  
implementation

{ TLog_Biometria }

constructor TLog_Biometria.Create;
begin

end;

destructor TLog_Biometria.Destroy;
begin

  inherited;
end;

{ TLog_BiometriaList }

constructor TLog_BiometriaList.Create(AOwner: TPersistent);
begin
  inherited Create(TLog_Biometria);
end;

function TLog_BiometriaList.Add: TLog_Biometria;
begin
  Result := TLog_Biometria(inherited Add);
  Result.create;
end;

function TLog_BiometriaList.GetItem(Index: Integer): TLog_Biometria;
begin
  Result := TLog_Biometria(inherited GetItem(Index));
end;

procedure TLog_BiometriaList.SetItem(Index: Integer; Value: TLog_Biometria);
begin
  inherited SetItem(Index, Value);
end;

end.