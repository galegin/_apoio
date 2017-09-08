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
    fDt_Cadastro: TDateTime;
    fDs_Regrafiscal: String;
    fIn_Calcimposto: String;
    procedure SetCd_Regrafiscal(const Value : Integer);
    procedure SetU_Version(const Value : String);
    procedure SetCd_Operador(const Value : Integer);
    procedure SetDt_Cadastro(const Value : TDateTime);
    procedure SetDs_Regrafiscal(const Value : String);
    procedure SetIn_Calcimposto(const Value : String);
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function GetMapping() : PmMapping; override;
  published
    property Cd_Regrafiscal : Integer read fCd_Regrafiscal write SetCd_Regrafiscal;
    property U_Version : String read fU_Version write SetU_Version;
    property Cd_Operador : Integer read fCd_Operador write SetCd_Operador;
    property Dt_Cadastro : TDateTime read fDt_Cadastro write SetDt_Cadastro;
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

function TRegrafiscal.GetMapping: PmMapping;
begin
  Result := New(PmMapping);

  Result.Tabela := New(PmTabela);
  with Result.Tabela^ do begin
    Nome := 'REGRAFISCAL';
  end;

  Result.Chaves := TmChaves.Create;
  with Result.Chaves do begin
    Add('Cd_Regrafiscal', 'CD_REGRAFISCAL');
  end;

  Result.Campos := TmCampos.Create;
  with Result.Campos do begin
    Add('Cd_Regrafiscal', 'CD_REGRAFISCAL');
    Add('U_Version', 'U_VERSION');
    Add('Cd_Operador', 'CD_OPERADOR');
    Add('Dt_Cadastro', 'DT_CADASTRO');
    Add('Ds_Regrafiscal', 'DS_REGRAFISCAL');
    Add('In_Calcimposto', 'IN_CALCIMPOSTO');
  end;

  Result.Relacoes := TmRelacoes.Create;
  with Result.Relacoes do begin
  end;
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

procedure TRegrafiscal.SetDt_Cadastro(const Value : TDateTime);
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