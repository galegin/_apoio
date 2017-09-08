unit uPais;

interface

uses
  Classes, SysUtils,
  mMapping;

type
  TPais = class(TmMapping)
  private
    fCd_Pais: Integer;
    fU_Version: String;
    fCd_Operador: Integer;
    fDt_Cadastro: TDateTime;
    fDs_Pais: String;
    fDs_Sigla: String;
    procedure SetCd_Pais(const Value : Integer);
    procedure SetU_Version(const Value : String);
    procedure SetCd_Operador(const Value : Integer);
    procedure SetDt_Cadastro(const Value : TDateTime);
    procedure SetDs_Pais(const Value : String);
    procedure SetDs_Sigla(const Value : String);
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function GetMapping() : PmMapping; override;
  published
    property Cd_Pais : Integer read fCd_Pais write SetCd_Pais;
    property U_Version : String read fU_Version write SetU_Version;
    property Cd_Operador : Integer read fCd_Operador write SetCd_Operador;
    property Dt_Cadastro : TDateTime read fDt_Cadastro write SetDt_Cadastro;
    property Ds_Pais : String read fDs_Pais write SetDs_Pais;
    property Ds_Sigla : String read fDs_Sigla write SetDs_Sigla;
  end;

  TPaiss = class(TList)
  public
    function Add: TPais; overload;
  end;

implementation

{ TPais }

constructor TPais.Create(AOwner: TComponent);
begin
  inherited;

end;

destructor TPais.Destroy;
begin

  inherited;
end;

//--

function TPais.GetMapping: PmMapping;
begin
  Result := New(PmMapping);

  Result.Tabela := New(PmTabela);
  with Result.Tabela^ do begin
    Nome := 'PAIS';
  end;

  Result.Chaves := TmChaves.Create;
  with Result.Chaves do begin
    Add('Cd_Pais', 'CD_PAIS');
  end;

  Result.Campos := TmCampos.Create;
  with Result.Campos do begin
    Add('Cd_Pais', 'CD_PAIS');
    Add('U_Version', 'U_VERSION');
    Add('Cd_Operador', 'CD_OPERADOR');
    Add('Dt_Cadastro', 'DT_CADASTRO');
    Add('Ds_Pais', 'DS_PAIS');
    Add('Ds_Sigla', 'DS_SIGLA');
  end;

  Result.Relacoes := TmRelacoes.Create;
  with Result.Relacoes do begin
  end;
end;

//--

procedure TPais.SetCd_Pais(const Value : Integer);
begin
  fCd_Pais := Value;
end;

procedure TPais.SetU_Version(const Value : String);
begin
  fU_Version := Value;
end;

procedure TPais.SetCd_Operador(const Value : Integer);
begin
  fCd_Operador := Value;
end;

procedure TPais.SetDt_Cadastro(const Value : TDateTime);
begin
  fDt_Cadastro := Value;
end;

procedure TPais.SetDs_Pais(const Value : String);
begin
  fDs_Pais := Value;
end;

procedure TPais.SetDs_Sigla(const Value : String);
begin
  fDs_Sigla := Value;
end;

{ TPaiss }

function TPaiss.Add: TPais;
begin
  Result := TPais.Create(nil);
  Self.Add(Result);
end;

end.