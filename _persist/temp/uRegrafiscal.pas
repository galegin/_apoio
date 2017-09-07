unit uRegrafiscal;

interface

uses
  Classes, SysUtils,
  mMapping;

type
  TRegrafiscal = class(TmMapping)
  private
    fCd_Regrafiscal: Integer;
    fU_Version: String;
    fCd_Operador: Integer;
    fDt_Cadastro: String;
    fDs_Regrafiscal: String;
    fIn_Calcimposto: String;
    procedure SetCd_Regrafiscal(const Value : Integer);
    procedure SetU_Version(const Value : String);
    procedure SetCd_Operador(const Value : Integer);
    procedure SetDt_Cadastro(const Value : String);
    procedure SetDs_Regrafiscal(const Value : String);
    procedure SetIn_Calcimposto(const Value : String);
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function GetTabela() : TmTabela; override;
    function GetKeys() : TmKeys; override;
    function GetCampos() : TmCampos; override;
  published
    property Cd_Regrafiscal : Integer read fCd_Regrafiscal write SetCd_Regrafiscal;
    property U_Version : String read fU_Version write SetU_Version;
    property Cd_Operador : Integer read fCd_Operador write SetCd_Operador;
    property Dt_Cadastro : String read fDt_Cadastro write SetDt_Cadastro;
    property Ds_Regrafiscal : String read fDs_Regrafiscal write SetDs_Regrafiscal;
    property In_Calcimposto : String read fIn_Calcimposto write SetIn_Calcimposto;
  end;

  TRegrafiscals = class(TList)
  public
    function Add: TRegrafiscal; overload;
  end;

implementation

{ TRegrafiscal }

constructor TRegrafiscal.Create(AOwner: TComponent);
begin
  inherited;

end;

destructor TRegrafiscal.Destroy;
begin

  inherited;
end;

//--

function TRegrafiscal.GetTabela: TmTabela;
begin
  Result.Nome := 'REGRAFISCAL';
end;

function TRegrafiscal.GetKeys: TmKeys;
begin
  AddKeysResult(Result, [
    'Cd_Regrafiscal|CD_REGRAFISCAL']);
end;

function TRegrafiscal.GetCampos: TmCampos;
begin
  AddCamposResult(Result, [
    'Cd_Regrafiscal|CD_REGRAFISCAL',
    'U_Version|U_VERSION',
    'Cd_Operador|CD_OPERADOR',
    'Dt_Cadastro|DT_CADASTRO',
    'Ds_Regrafiscal|DS_REGRAFISCAL',
    'In_Calcimposto|IN_CALCIMPOSTO']);
end;

//--

procedure TRegrafiscal.SetCd_Regrafiscal(const Value : Integer);
begin
  fCd_Regrafiscal := Value;
end;

procedure TRegrafiscal.SetU_Version(const Value : String);
begin
  fU_Version := Value;
end;

procedure TRegrafiscal.SetCd_Operador(const Value : Integer);
begin
  fCd_Operador := Value;
end;

procedure TRegrafiscal.SetDt_Cadastro(const Value : String);
begin
  fDt_Cadastro := Value;
end;

procedure TRegrafiscal.SetDs_Regrafiscal(const Value : String);
begin
  fDs_Regrafiscal := Value;
end;

procedure TRegrafiscal.SetIn_Calcimposto(const Value : String);
begin
  fIn_Calcimposto := Value;
end;

{ TRegrafiscals }

function TRegrafiscals.Add: TRegrafiscal;
begin
  Result := TRegrafiscal.Create(nil);
  Self.Add(Result);
end;

end.