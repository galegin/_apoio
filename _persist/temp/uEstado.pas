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
    function GetMapping() : PmMapping; override;
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

function TEstado.GetMapping: PmMapping;
begin
  with Result.Tabela do begin
    Nome := 'ESTADO';
  end;

  Result.Chaves := TmChaves.Create;
  with Result.Chaves do begin
    Add('Cd_Estado', 'CD_ESTADO');
  end;

  Result.Campos := TmCampos.Create;
  with Result.Campos do begin
    Add('Cd_Estado', 'CD_ESTADO');
    Add('U_Version', 'U_VERSION');
    Add('Cd_Operador', 'CD_OPERADOR');
    Add('Dt_Cadastro', 'DT_CADASTRO');
    Add('Ds_Estado', 'DS_ESTADO');
    Add('Ds_Sigla', 'DS_SIGLA');
    Add('Cd_Pais', 'CD_PAIS');
  end;
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