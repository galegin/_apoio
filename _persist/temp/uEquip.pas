unit uEquip;

interface

uses
  Classes, SysUtils,
  mMapping;

type
  TEquip = class(TmMapping)
  private
    fCd_Dnaequip: String;
    fU_Version: String;
    fCd_Operador: Integer;
    fDt_Cadastro: String;
    fCd_Equip: String;
    fDs_Equip: String;
    fCd_Ambiente: String;
    fCd_Empresa: Integer;
    fCd_Terminal: Integer;
    procedure SetCd_Dnaequip(const Value : String);
    procedure SetU_Version(const Value : String);
    procedure SetCd_Operador(const Value : Integer);
    procedure SetDt_Cadastro(const Value : String);
    procedure SetCd_Equip(const Value : String);
    procedure SetDs_Equip(const Value : String);
    procedure SetCd_Ambiente(const Value : String);
    procedure SetCd_Empresa(const Value : Integer);
    procedure SetCd_Terminal(const Value : Integer);
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function GetTabela() : TmTabela; override;
    function GetKeys() : TmKeys; override;
    function GetCampos() : TmCampos; override;
  published
    property Cd_Dnaequip : String read fCd_Dnaequip write SetCd_Dnaequip;
    property U_Version : String read fU_Version write SetU_Version;
    property Cd_Operador : Integer read fCd_Operador write SetCd_Operador;
    property Dt_Cadastro : String read fDt_Cadastro write SetDt_Cadastro;
    property Cd_Equip : String read fCd_Equip write SetCd_Equip;
    property Ds_Equip : String read fDs_Equip write SetDs_Equip;
    property Cd_Ambiente : String read fCd_Ambiente write SetCd_Ambiente;
    property Cd_Empresa : Integer read fCd_Empresa write SetCd_Empresa;
    property Cd_Terminal : Integer read fCd_Terminal write SetCd_Terminal;
  end;

  TEquips = class(TList)
  public
    function Add: TEquip; overload;
  end;

implementation

{ TEquip }

constructor TEquip.Create(AOwner: TComponent);
begin
  inherited;

end;

destructor TEquip.Destroy;
begin

  inherited;
end;

//--

function TEquip.GetTabela: TmTabela;
begin
  Result.Nome := 'EQUIP';
end;

function TEquip.GetKeys: TmKeys;
begin
  AddKeysResult(Result, [
    'Cd_Dnaequip|CD_DNAEQUIP']);
end;

function TEquip.GetCampos: TmCampos;
begin
  AddCamposResult(Result, [
    'Cd_Dnaequip|CD_DNAEQUIP',
    'U_Version|U_VERSION',
    'Cd_Operador|CD_OPERADOR',
    'Dt_Cadastro|DT_CADASTRO',
    'Cd_Equip|CD_EQUIP',
    'Ds_Equip|DS_EQUIP',
    'Cd_Ambiente|CD_AMBIENTE',
    'Cd_Empresa|CD_EMPRESA',
    'Cd_Terminal|CD_TERMINAL']);
end;

//--

procedure TEquip.SetCd_Dnaequip(const Value : String);
begin
  fCd_Dnaequip := Value;
end;

procedure TEquip.SetU_Version(const Value : String);
begin
  fU_Version := Value;
end;

procedure TEquip.SetCd_Operador(const Value : Integer);
begin
  fCd_Operador := Value;
end;

procedure TEquip.SetDt_Cadastro(const Value : String);
begin
  fDt_Cadastro := Value;
end;

procedure TEquip.SetCd_Equip(const Value : String);
begin
  fCd_Equip := Value;
end;

procedure TEquip.SetDs_Equip(const Value : String);
begin
  fDs_Equip := Value;
end;

procedure TEquip.SetCd_Ambiente(const Value : String);
begin
  fCd_Ambiente := Value;
end;

procedure TEquip.SetCd_Empresa(const Value : Integer);
begin
  fCd_Empresa := Value;
end;

procedure TEquip.SetCd_Terminal(const Value : Integer);
begin
  fCd_Terminal := Value;
end;

{ TEquips }

function TEquips.Add: TEquip;
begin
  Result := TEquip.Create(nil);
  Self.Add(Result);
end;

end.