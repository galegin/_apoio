unit uEstado;

interface

uses
  Classes, SysUtils,
  mMapping;

type
  TEstado = class(TmMapping)
  private
    fCd_Estado: Integer;
    fU_Version: String;
    fCd_Operador: Integer;
    fDt_Cadastro: String;
    fDs_Estado: String;
    fDs_Sigla: String;
    fCd_Pais: Integer;
    procedure SetCd_Estado(const Value : Integer);
    procedure SetU_Version(const Value : String);
    procedure SetCd_Operador(const Value : Integer);
    procedure SetDt_Cadastro(const Value : String);
    procedure SetDs_Estado(const Value : String);
    procedure SetDs_Sigla(const Value : String);
    procedure SetCd_Pais(const Value : Integer);
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function GetTabela() : TmTabela; override;
    function GetKeys() : TmKeys; override;
    function GetCampos() : TmCampos; override;
  published
    property Cd_Estado : Integer read fCd_Estado write SetCd_Estado;
    property U_Version : String read fU_Version write SetU_Version;
    property Cd_Operador : Integer read fCd_Operador write SetCd_Operador;
    property Dt_Cadastro : String read fDt_Cadastro write SetDt_Cadastro;
    property Ds_Estado : String read fDs_Estado write SetDs_Estado;
    property Ds_Sigla : String read fDs_Sigla write SetDs_Sigla;
    property Cd_Pais : Integer read fCd_Pais write SetCd_Pais;
  end;

  TEstados = class(TList)
  public
    function Add: TEstado; overload;
  end;

implementation

{ TEstado }

constructor TEstado.Create(AOwner: TComponent);
begin
  inherited;

end;

destructor TEstado.Destroy;
begin

  inherited;
end;

//--

function TEstado.GetTabela: TmTabela;
begin
  Result.Nome := 'ESTADO';
end;

function TEstado.GetKeys: TmKeys;
begin
  AddKeysResult(Result, [
    'Cd_Estado|CD_ESTADO']);
end;

function TEstado.GetCampos: TmCampos;
begin
  AddCamposResult(Result, [
    'Cd_Estado|CD_ESTADO',
    'U_Version|U_VERSION',
    'Cd_Operador|CD_OPERADOR',
    'Dt_Cadastro|DT_CADASTRO',
    'Ds_Estado|DS_ESTADO',
    'Ds_Sigla|DS_SIGLA',
    'Cd_Pais|CD_PAIS']);
end;

//--

procedure TEstado.SetCd_Estado(const Value : Integer);
begin
  fCd_Estado := Value;
end;

procedure TEstado.SetU_Version(const Value : String);
begin
  fU_Version := Value;
end;

procedure TEstado.SetCd_Operador(const Value : Integer);
begin
  fCd_Operador := Value;
end;

procedure TEstado.SetDt_Cadastro(const Value : String);
begin
  fDt_Cadastro := Value;
end;

procedure TEstado.SetDs_Estado(const Value : String);
begin
  fDs_Estado := Value;
end;

procedure TEstado.SetDs_Sigla(const Value : String);
begin
  fDs_Sigla := Value;
end;

procedure TEstado.SetCd_Pais(const Value : Integer);
begin
  fCd_Pais := Value;
end;

{ TEstados }

function TEstados.Add: TEstado;
begin
  Result := TEstado.Create(nil);
  Self.Add(Result);
end;

end.