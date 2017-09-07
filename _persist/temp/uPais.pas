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
    fDt_Cadastro: String;
    fDs_Pais: String;
    fDs_Sigla: String;
    procedure SetCd_Pais(const Value : Integer);
    procedure SetU_Version(const Value : String);
    procedure SetCd_Operador(const Value : Integer);
    procedure SetDt_Cadastro(const Value : String);
    procedure SetDs_Pais(const Value : String);
    procedure SetDs_Sigla(const Value : String);
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function GetTabela() : TmTabela; override;
    function GetKeys() : TmKeys; override;
    function GetCampos() : TmCampos; override;
  published
    property Cd_Pais : Integer read fCd_Pais write SetCd_Pais;
    property U_Version : String read fU_Version write SetU_Version;
    property Cd_Operador : Integer read fCd_Operador write SetCd_Operador;
    property Dt_Cadastro : String read fDt_Cadastro write SetDt_Cadastro;
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

function TPais.GetTabela: TmTabela;
begin
  Result.Nome := 'PAIS';
end;

function TPais.GetKeys: TmKeys;
begin
  AddKeysResult(Result, [
    'Cd_Pais|CD_PAIS']);
end;

function TPais.GetCampos: TmCampos;
begin
  AddCamposResult(Result, [
    'Cd_Pais|CD_PAIS',
    'U_Version|U_VERSION',
    'Cd_Operador|CD_OPERADOR',
    'Dt_Cadastro|DT_CADASTRO',
    'Ds_Pais|DS_PAIS',
    'Ds_Sigla|DS_SIGLA']);
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

procedure TPais.SetDt_Cadastro(const Value : String);
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