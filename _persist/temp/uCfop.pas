unit uCfop;

interface

uses
  Classes, SysUtils,
  mMapping;

type
  TCfop = class(TmMapping)
  private
    fCd_Cfop: Integer;
    fU_Version: String;
    fCd_Operador: Integer;
    fDt_Cadastro: TDateTime;
    fDs_Cfop: String;
    procedure SetCd_Cfop(const Value : Integer);
    procedure SetU_Version(const Value : String);
    procedure SetCd_Operador(const Value : Integer);
    procedure SetDt_Cadastro(const Value : TDateTime);
    procedure SetDs_Cfop(const Value : String);
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function GetMapping() : PmMapping; override;
  published
    property Cd_Cfop : Integer read fCd_Cfop write SetCd_Cfop;
    property U_Version : String read fU_Version write SetU_Version;
    property Cd_Operador : Integer read fCd_Operador write SetCd_Operador;
    property Dt_Cadastro : TDateTime read fDt_Cadastro write SetDt_Cadastro;
    property Ds_Cfop : String read fDs_Cfop write SetDs_Cfop;
  end;

  TCfops = class(TList)
  public
    function Add: TCfop; overload;
  end;

implementation

{ TCfop }

constructor TCfop.Create(AOwner: TComponent);
begin
  inherited;

end;

destructor TCfop.Destroy;
begin

  inherited;
end;

//--

function TCfop.GetMapping: PmMapping;
begin
  Result := New(PmMapping);

  Result.Tabela := New(PmTabela);
  with Result.Tabela^ do begin
    Nome := 'CFOP';
  end;

  Result.Chaves := TmChaves.Create;
  with Result.Chaves do begin
    Add('Cd_Cfop', 'CD_CFOP');
  end;

  Result.Campos := TmCampos.Create;
  with Result.Campos do begin
    Add('Cd_Cfop', 'CD_CFOP');
    Add('U_Version', 'U_VERSION');
    Add('Cd_Operador', 'CD_OPERADOR');
    Add('Dt_Cadastro', 'DT_CADASTRO');
    Add('Ds_Cfop', 'DS_CFOP');
  end;

  Result.Relacoes := TmRelacoes.Create;
  with Result.Relacoes do begin
  end;
end;

//--

procedure TCfop.SetCd_Cfop(const Value : Integer);
begin
  fCd_Cfop := Value;
end;

procedure TCfop.SetU_Version(const Value : String);
begin
  fU_Version := Value;
end;

procedure TCfop.SetCd_Operador(const Value : Integer);
begin
  fCd_Operador := Value;
end;

procedure TCfop.SetDt_Cadastro(const Value : TDateTime);
begin
  fDt_Cadastro := Value;
end;

procedure TCfop.SetDs_Cfop(const Value : String);
begin
  fDs_Cfop := Value;
end;

{ TCfops }

function TCfops.Add: TCfop;
begin
  Result := TCfop.Create(nil);
  Self.Add(Result);
end;

end.