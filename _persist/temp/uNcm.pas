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
    fDt_Cadastro: TDateTime;
    fDs_Ncm: String;
    procedure SetCd_Ncm(const Value : String);
    procedure SetU_Version(const Value : String);
    procedure SetCd_Operador(const Value : Integer);
    procedure SetDt_Cadastro(const Value : TDateTime);
    procedure SetDs_Ncm(const Value : String);
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function GetMapping() : PmMapping; override;
  published
    property Cd_Ncm : String read fCd_Ncm write SetCd_Ncm;
    property U_Version : String read fU_Version write SetU_Version;
    property Cd_Operador : Integer read fCd_Operador write SetCd_Operador;
    property Dt_Cadastro : TDateTime read fDt_Cadastro write SetDt_Cadastro;
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

function TNcm.GetMapping: PmMapping;
begin
  Result := New(PmMapping);

  Result.Tabela := New(PmTabela);
  with Result.Tabela^ do begin
    Nome := 'NCM';
  end;

  Result.Chaves := TmChaves.Create;
  with Result.Chaves do begin
    Add('Cd_Ncm', 'CD_NCM');
  end;

  Result.Campos := TmCampos.Create;
  with Result.Campos do begin
    Add('Cd_Ncm', 'CD_NCM');
    Add('U_Version', 'U_VERSION');
    Add('Cd_Operador', 'CD_OPERADOR');
    Add('Dt_Cadastro', 'DT_CADASTRO');
    Add('Ds_Ncm', 'DS_NCM');
  end;

  Result.Relacoes := TmRelacoes.Create;
  with Result.Relacoes do begin
  end;
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

procedure TNcm.SetDt_Cadastro(const Value : TDateTime);
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