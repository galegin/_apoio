unit uAliqicms;

interface

uses
  Classes, SysUtils,
  mMapping;

type
  TAliqicms = class(TmMapping)
  private
    fUf_Origem: String;
    fUf_Destino: String;
    fU_Version: String;
    fCd_Operador: Integer;
    fDt_Cadastro: TDateTime;
    fPr_Aliquota: Real;
    procedure SetUf_Origem(const Value : String);
    procedure SetUf_Destino(const Value : String);
    procedure SetU_Version(const Value : String);
    procedure SetCd_Operador(const Value : Integer);
    procedure SetDt_Cadastro(const Value : TDateTime);
    procedure SetPr_Aliquota(const Value : Real);
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function GetMapping() : PmMapping; override;
  published
    property Uf_Origem : String read fUf_Origem write SetUf_Origem;
    property Uf_Destino : String read fUf_Destino write SetUf_Destino;
    property U_Version : String read fU_Version write SetU_Version;
    property Cd_Operador : Integer read fCd_Operador write SetCd_Operador;
    property Dt_Cadastro : TDateTime read fDt_Cadastro write SetDt_Cadastro;
    property Pr_Aliquota : Real read fPr_Aliquota write SetPr_Aliquota;
  end;

  TAliqicmss = class(TList)
  public
    function Add: TAliqicms; overload;
  end;

implementation

{ TAliqicms }

constructor TAliqicms.Create(AOwner: TComponent);
begin
  inherited;

end;

destructor TAliqicms.Destroy;
begin

  inherited;
end;

//--

function TAliqicms.GetMapping: PmMapping;
begin
  Result := New(PmMapping);

  Result.Tabela := New(PmTabela);
  with Result.Tabela^ do begin
    Nome := 'ALIQICMS';
  end;

  Result.Chaves := TmChaves.Create;
  with Result.Chaves do begin
    Add('Uf_Origem', 'UF_ORIGEM');
    Add('Uf_Destino', 'UF_DESTINO');
  end;

  Result.Campos := TmCampos.Create;
  with Result.Campos do begin
    Add('Uf_Origem', 'UF_ORIGEM');
    Add('Uf_Destino', 'UF_DESTINO');
    Add('U_Version', 'U_VERSION');
    Add('Cd_Operador', 'CD_OPERADOR');
    Add('Dt_Cadastro', 'DT_CADASTRO');
    Add('Pr_Aliquota', 'PR_ALIQUOTA');
  end;

  Result.Relacoes := TmRelacoes.Create;
  with Result.Relacoes do begin
  end;
end;

//--

procedure TAliqicms.SetUf_Origem(const Value : String);
begin
  fUf_Origem := Value;
end;

procedure TAliqicms.SetUf_Destino(const Value : String);
begin
  fUf_Destino := Value;
end;

procedure TAliqicms.SetU_Version(const Value : String);
begin
  fU_Version := Value;
end;

procedure TAliqicms.SetCd_Operador(const Value : Integer);
begin
  fCd_Operador := Value;
end;

procedure TAliqicms.SetDt_Cadastro(const Value : TDateTime);
begin
  fDt_Cadastro := Value;
end;

procedure TAliqicms.SetPr_Aliquota(const Value : Real);
begin
  fPr_Aliquota := Value;
end;

{ TAliqicmss }

function TAliqicmss.Add: TAliqicms;
begin
  Result := TAliqicms.Create(nil);
  Self.Add(Result);
end;

end.