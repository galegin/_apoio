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
    fDt_Cadastro: String;
    fTp_Pagto: Integer;
    fVl_Pagto: String;
    procedure SetCd_Dnatrans(const Value : String);
    procedure SetNr_Pagto(const Value : Integer);
    procedure SetU_Version(const Value : String);
    procedure SetCd_Operador(const Value : Integer);
    procedure SetDt_Cadastro(const Value : String);
    procedure SetTp_Pagto(const Value : Integer);
    procedure SetVl_Pagto(const Value : String);
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function GetTabela() : TmTabela; override;
    function GetKeys() : TmKeys; override;
    function GetCampos() : TmCampos; override;
  published
    property Cd_Dnatrans : String read fCd_Dnatrans write SetCd_Dnatrans;
    property Nr_Pagto : Integer read fNr_Pagto write SetNr_Pagto;
    property U_Version : String read fU_Version write SetU_Version;
    property Cd_Operador : Integer read fCd_Operador write SetCd_Operador;
    property Dt_Cadastro : String read fDt_Cadastro write SetDt_Cadastro;
    property Tp_Pagto : Integer read fTp_Pagto write SetTp_Pagto;
    property Vl_Pagto : String read fVl_Pagto write SetVl_Pagto;
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

function TTranspagto.GetTabela: TmTabela;
begin
  Result.Nome := 'TRANSPAGTO';
end;

function TTranspagto.GetKeys: TmKeys;
begin
  AddKeysResult(Result, [
    'Cd_Dnatrans|CD_DNATRANS',
    'Nr_Pagto|NR_PAGTO']);
end;

function TTranspagto.GetCampos: TmCampos;
begin
  AddCamposResult(Result, [
    'Cd_Dnatrans|CD_DNATRANS',
    'Nr_Pagto|NR_PAGTO',
    'U_Version|U_VERSION',
    'Cd_Operador|CD_OPERADOR',
    'Dt_Cadastro|DT_CADASTRO',
    'Tp_Pagto|TP_PAGTO',
    'Vl_Pagto|VL_PAGTO']);
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

procedure TTranspagto.SetDt_Cadastro(const Value : String);
begin
  fDt_Cadastro := Value;
end;

procedure TTranspagto.SetTp_Pagto(const Value : Integer);
begin
  fTp_Pagto := Value;
end;

procedure TTranspagto.SetVl_Pagto(const Value : String);
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