unit uTranspagto;

interface

uses
  Classes, SysUtils,
  mMapping;

type
  TTranspagto = class(TmMapping)
  private
    fCd_Dnatrans: String;
    fNr_Pagto: Integer;
    fU_Version: String;
    fCd_Operador: Integer;
    fDt_Cadastro: TDateTime;
    fTp_Pagto: Integer;
    fVl_Pagto: Real;
    procedure SetCd_Dnatrans(const Value : String);
    procedure SetNr_Pagto(const Value : Integer);
    procedure SetU_Version(const Value : String);
    procedure SetCd_Operador(const Value : Integer);
    procedure SetDt_Cadastro(const Value : TDateTime);
    procedure SetTp_Pagto(const Value : Integer);
    procedure SetVl_Pagto(const Value : Real);
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function GetMapping() : PmMapping; override;
  published
    property Cd_Dnatrans : String read fCd_Dnatrans write SetCd_Dnatrans;
    property Nr_Pagto : Integer read fNr_Pagto write SetNr_Pagto;
    property U_Version : String read fU_Version write SetU_Version;
    property Cd_Operador : Integer read fCd_Operador write SetCd_Operador;
    property Dt_Cadastro : TDateTime read fDt_Cadastro write SetDt_Cadastro;
    property Tp_Pagto : Integer read fTp_Pagto write SetTp_Pagto;
    property Vl_Pagto : Real read fVl_Pagto write SetVl_Pagto;
  end;

  TTranspagtos = class(TList)
  public
    function Add: TTranspagto; overload;
  end;

implementation

{ TTranspagto }

constructor TTranspagto.Create(AOwner: TComponent);
begin
  inherited;

end;

destructor TTranspagto.Destroy;
begin

  inherited;
end;

//--

function TTranspagto.GetMapping: PmMapping;
begin
  Result := New(PmMapping);

  Result.Tabela := New(PmTabela);
  with Result.Tabela^ do begin
    Nome := 'TRANSPAGTO';
  end;

  Result.Chaves := TmChaves.Create;
  with Result.Chaves do begin
    Add('Cd_Dnatrans', 'CD_DNATRANS');
    Add('Nr_Pagto', 'NR_PAGTO');
  end;

  Result.Campos := TmCampos.Create;
  with Result.Campos do begin
    Add('Cd_Dnatrans', 'CD_DNATRANS');
    Add('Nr_Pagto', 'NR_PAGTO');
    Add('U_Version', 'U_VERSION');
    Add('Cd_Operador', 'CD_OPERADOR');
    Add('Dt_Cadastro', 'DT_CADASTRO');
    Add('Tp_Pagto', 'TP_PAGTO');
    Add('Vl_Pagto', 'VL_PAGTO');
  end;

  Result.Relacoes := TmRelacoes.Create;
  with Result.Relacoes do begin
  end;
end;

//--

procedure TTranspagto.SetCd_Dnatrans(const Value : String);
begin
  fCd_Dnatrans := Value;
end;

procedure TTranspagto.SetNr_Pagto(const Value : Integer);
begin
  fNr_Pagto := Value;
end;

procedure TTranspagto.SetU_Version(const Value : String);
begin
  fU_Version := Value;
end;

procedure TTranspagto.SetCd_Operador(const Value : Integer);
begin
  fCd_Operador := Value;
end;

procedure TTranspagto.SetDt_Cadastro(const Value : TDateTime);
begin
  fDt_Cadastro := Value;
end;

procedure TTranspagto.SetTp_Pagto(const Value : Integer);
begin
  fTp_Pagto := Value;
end;

procedure TTranspagto.SetVl_Pagto(const Value : Real);
begin
  fVl_Pagto := Value;
end;

{ TTranspagtos }

function TTranspagtos.Add: TTranspagto;
begin
  Result := TTranspagto.Create(nil);
  Self.Add(Result);
end;

end.