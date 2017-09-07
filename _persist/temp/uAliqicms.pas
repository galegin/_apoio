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
    fDt_Cadastro: String;
    fPr_Aliquota: String;
    procedure SetUf_Origem(const Value : String);
    procedure SetUf_Destino(const Value : String);
    procedure SetU_Version(const Value : String);
    procedure SetCd_Operador(const Value : Integer);
    procedure SetDt_Cadastro(const Value : String);
    procedure SetPr_Aliquota(const Value : String);
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function GetTabela() : TmTabela; override;
    function GetKeys() : TmKeys; override;
    function GetCampos() : TmCampos; override;
  published
    property Uf_Origem : String read fUf_Origem write SetUf_Origem;
    property Uf_Destino : String read fUf_Destino write SetUf_Destino;
    property U_Version : String read fU_Version write SetU_Version;
    property Cd_Operador : Integer read fCd_Operador write SetCd_Operador;
    property Dt_Cadastro : String read fDt_Cadastro write SetDt_Cadastro;
    property Pr_Aliquota : String read fPr_Aliquota write SetPr_Aliquota;
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

function TAliqicms.GetTabela: TmTabela;
begin
  Result.Nome := 'ALIQICMS';
end;

function TAliqicms.GetKeys: TmKeys;
begin
  AddKeysResult(Result, [
    'Uf_Origem|UF_ORIGEM',
    'Uf_Destino|UF_DESTINO']);
end;

function TAliqicms.GetCampos: TmCampos;
begin
  AddCamposResult(Result, [
    'Uf_Origem|UF_ORIGEM',
    'Uf_Destino|UF_DESTINO',
    'U_Version|U_VERSION',
    'Cd_Operador|CD_OPERADOR',
    'Dt_Cadastro|DT_CADASTRO',
    'Pr_Aliquota|PR_ALIQUOTA']);
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

procedure TAliqicms.SetDt_Cadastro(const Value : String);
begin
  fDt_Cadastro := Value;
end;

procedure TAliqicms.SetPr_Aliquota(const Value : String);
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