unit uNcm;

interface

uses
  Classes, SysUtils,
  mMapping;

type
  TNcm = class(TmMapping)
  private
    fCd_Ncm: String;
    fU_Version: String;
    fCd_Operador: Integer;
    fDt_Cadastro: String;
    fDs_Ncm: String;
    procedure SetCd_Ncm(const Value : String);
    procedure SetU_Version(const Value : String);
    procedure SetCd_Operador(const Value : Integer);
    procedure SetDt_Cadastro(const Value : String);
    procedure SetDs_Ncm(const Value : String);
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function GetTabela() : TmTabela; override;
    function GetKeys() : TmKeys; override;
    function GetCampos() : TmCampos; override;
  published
    property Cd_Ncm : String read fCd_Ncm write SetCd_Ncm;
    property U_Version : String read fU_Version write SetU_Version;
    property Cd_Operador : Integer read fCd_Operador write SetCd_Operador;
    property Dt_Cadastro : String read fDt_Cadastro write SetDt_Cadastro;
    property Ds_Ncm : String read fDs_Ncm write SetDs_Ncm;
  end;

  TNcms = class(TList)
  public
    function Add: TNcm; overload;
  end;

implementation

{ TNcm }

constructor TNcm.Create(AOwner: TComponent);
begin
  inherited;

end;

destructor TNcm.Destroy;
begin

  inherited;
end;

//--

function TNcm.GetTabela: TmTabela;
begin
  Result.Nome := 'NCM';
end;

function TNcm.GetKeys: TmKeys;
begin
  AddKeysResult(Result, [
    'Cd_Ncm|CD_NCM']);
end;

function TNcm.GetCampos: TmCampos;
begin
  AddCamposResult(Result, [
    'Cd_Ncm|CD_NCM',
    'U_Version|U_VERSION',
    'Cd_Operador|CD_OPERADOR',
    'Dt_Cadastro|DT_CADASTRO',
    'Ds_Ncm|DS_NCM']);
end;

//--

procedure TNcm.SetCd_Ncm(const Value : String);
begin
  fCd_Ncm := Value;
end;

procedure TNcm.SetU_Version(const Value : String);
begin
  fU_Version := Value;
end;

procedure TNcm.SetCd_Operador(const Value : Integer);
begin
  fCd_Operador := Value;
end;

procedure TNcm.SetDt_Cadastro(const Value : String);
begin
  fDt_Cadastro := Value;
end;

procedure TNcm.SetDs_Ncm(const Value : String);
begin
  fDs_Ncm := Value;
end;

{ TNcms }

function TNcms.Add: TNcm;
begin
  Result := TNcm.Create(nil);
  Self.Add(Result);
end;

end.