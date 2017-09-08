unit uTransvencto;

interface

uses
  Classes, SysUtils,
  mMapping;

type
  TTransvencto = class(TmMapping)
  private
    fCd_Dnatrans: String;
    fNr_Parcela: Integer;
    fU_Version: String;
    fCd_Operador: Integer;
    fDt_Cadastro: String;
    fDt_Parcela: String;
    fVl_Parcela: String;
    procedure SetCd_Dnatrans(const Value : String);
    procedure SetNr_Parcela(const Value : Integer);
    procedure SetU_Version(const Value : String);
    procedure SetCd_Operador(const Value : Integer);
    procedure SetDt_Cadastro(const Value : String);
    procedure SetDt_Parcela(const Value : String);
    procedure SetVl_Parcela(const Value : String);
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function GetMapping() : PmMapping; override;
  published
    property Cd_Dnatrans : String read fCd_Dnatrans write SetCd_Dnatrans;
    property Nr_Parcela : Integer read fNr_Parcela write SetNr_Parcela;
    property U_Version : String read fU_Version write SetU_Version;
    property Cd_Operador : Integer read fCd_Operador write SetCd_Operador;
    property Dt_Cadastro : String read fDt_Cadastro write SetDt_Cadastro;
    property Dt_Parcela : String read fDt_Parcela write SetDt_Parcela;
    property Vl_Parcela : String read fVl_Parcela write SetVl_Parcela;
  end;

  TTransvenctos = class(TList)
  public
    function Add: TTransvencto; overload;
  end;

implementation

{ TTransvencto }

constructor TTransvencto.Create(AOwner: TComponent);
begin
  inherited;

end;

destructor TTransvencto.Destroy;
begin

  inherited;
end;

//--

function TTransvencto.GetMapping: PmMapping;
begin
  with Result.Tabela do begin
    Nome := 'TRANSVENCTO';
  end;

  Result.Chaves := TmChaves.Create;
  with Result.Chaves do begin
    Add('Cd_Dnatrans', 'CD_DNATRANS');
    Add('Nr_Parcela', 'NR_PARCELA');
  end;

  Result.Campos := TmCampos.Create;
  with Result.Campos do begin
    Add('Cd_Dnatrans', 'CD_DNATRANS');
    Add('Nr_Parcela', 'NR_PARCELA');
    Add('U_Version', 'U_VERSION');
    Add('Cd_Operador', 'CD_OPERADOR');
    Add('Dt_Cadastro', 'DT_CADASTRO');
    Add('Dt_Parcela', 'DT_PARCELA');
    Add('Vl_Parcela', 'VL_PARCELA');
  end;
end;

//--

procedure TTransvencto.SetCd_Dnatrans(const Value : String);
begin
  fCd_Dnatrans := Value;
end;

procedure TTransvencto.SetNr_Parcela(const Value : Integer);
begin
  fNr_Parcela := Value;
end;

procedure TTransvencto.SetU_Version(const Value : String);
begin
  fU_Version := Value;
end;

procedure TTransvencto.SetCd_Operador(const Value : Integer);
begin
  fCd_Operador := Value;
end;

procedure TTransvencto.SetDt_Cadastro(const Value : String);
begin
  fDt_Cadastro := Value;
end;

procedure TTransvencto.SetDt_Parcela(const Value : String);
begin
  fDt_Parcela := Value;
end;

procedure TTransvencto.SetVl_Parcela(const Value : String);
begin
  fVl_Parcela := Value;
end;

{ TTransvenctos }

function TTransvenctos.Add: TTransvencto;
begin
  Result := TTransvencto.Create(nil);
  Self.Add(Result);
end;

end.