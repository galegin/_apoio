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
    fDt_Cadastro: TDateTime;
    fCd_Equip: String;
    fDs_Equip: String;
    fCd_Ambiente: String;
    fCd_Empresa: Integer;
    fCd_Terminal: Integer;
    procedure SetCd_Dnaequip(const Value : String);
    procedure SetU_Version(const Value : String);
    procedure SetCd_Operador(const Value : Integer);
    procedure SetDt_Cadastro(const Value : TDateTime);
    procedure SetCd_Equip(const Value : String);
    procedure SetDs_Equip(const Value : String);
    procedure SetCd_Ambiente(const Value : String);
    procedure SetCd_Empresa(const Value : Integer);
    procedure SetCd_Terminal(const Value : Integer);
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function GetMapping() : PmMapping; override;
  published
    property Cd_Dnaequip : String read fCd_Dnaequip write SetCd_Dnaequip;
    property U_Version : String read fU_Version write SetU_Version;
    property Cd_Operador : Integer read fCd_Operador write SetCd_Operador;
    property Dt_Cadastro : TDateTime read fDt_Cadastro write SetDt_Cadastro;
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

function TEquip.GetMapping: PmMapping;
begin
  Result := New(PmMapping);

  Result.Tabela := New(PmTabela);
  with Result.Tabela^ do begin
    Nome := 'EQUIP';
  end;

  Result.Chaves := TmChaves.Create;
  with Result.Chaves do begin
    Add('Cd_Dnaequip', 'CD_DNAEQUIP');
  end;

  Result.Campos := TmCampos.Create;
  with Result.Campos do begin
    Add('Cd_Dnaequip', 'CD_DNAEQUIP');
    Add('U_Version', 'U_VERSION');
    Add('Cd_Operador', 'CD_OPERADOR');
    Add('Dt_Cadastro', 'DT_CADASTRO');
    Add('Cd_Equip', 'CD_EQUIP');
    Add('Ds_Equip', 'DS_EQUIP');
    Add('Cd_Ambiente', 'CD_AMBIENTE');
    Add('Cd_Empresa', 'CD_EMPRESA');
    Add('Cd_Terminal', 'CD_TERMINAL');
  end;

  Result.Relacoes := TmRelacoes.Create;
  with Result.Relacoes do begin
  end;
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

procedure TEquip.SetDt_Cadastro(const Value : TDateTime);
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