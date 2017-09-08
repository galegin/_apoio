unit uEmpresa;

interface

uses
  Classes, SysUtils,
  mMapping;

type
  TEmpresa = class(TmMapping)
  private
    fNr_Cpfcnpj: String;
    fU_Version: String;
    fCd_Operador: Integer;
    fDt_Cadastro: String;
    procedure SetNr_Cpfcnpj(const Value : String);
    procedure SetU_Version(const Value : String);
    procedure SetCd_Operador(const Value : Integer);
    procedure SetDt_Cadastro(const Value : String);
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function GetMapping() : PmMapping; override;
  published
    property Nr_Cpfcnpj : String read fNr_Cpfcnpj write SetNr_Cpfcnpj;
    property U_Version : String read fU_Version write SetU_Version;
    property Cd_Operador : Integer read fCd_Operador write SetCd_Operador;
    property Dt_Cadastro : String read fDt_Cadastro write SetDt_Cadastro;
  end;

  TEmpresas = class(TList)
  public
    function Add: TEmpresa; overload;
  end;

implementation

{ TEmpresa }

constructor TEmpresa.Create(AOwner: TComponent);
begin
  inherited;

end;

destructor TEmpresa.Destroy;
begin

  inherited;
end;

//--

function TEmpresa.GetMapping: PmMapping;
begin
  with Result.Tabela do begin
    Nome := 'EMPRESA';
  end;

  Result.Chaves := TmChaves.Create;
  with Result.Chaves do begin
    Add('Nr_Cpfcnpj', 'NR_CPFCNPJ');
  end;

  Result.Campos := TmCampos.Create;
  with Result.Campos do begin
    Add('Nr_Cpfcnpj', 'NR_CPFCNPJ');
    Add('U_Version', 'U_VERSION');
    Add('Cd_Operador', 'CD_OPERADOR');
    Add('Dt_Cadastro', 'DT_CADASTRO');
  end;
end;

//--

procedure TEmpresa.SetNr_Cpfcnpj(const Value : String);
begin
  fNr_Cpfcnpj := Value;
end;

procedure TEmpresa.SetU_Version(const Value : String);
begin
  fU_Version := Value;
end;

procedure TEmpresa.SetCd_Operador(const Value : Integer);
begin
  fCd_Operador := Value;
end;

procedure TEmpresa.SetDt_Cadastro(const Value : String);
begin
  fDt_Cadastro := Value;
end;

{ TEmpresas }

function TEmpresas.Add: TEmpresa;
begin
  Result := TEmpresa.Create(nil);
  Self.Add(Result);
end;

end.