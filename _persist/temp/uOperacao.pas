unit uOperacao;

interface

uses
  Classes, SysUtils,
  mMapping;

type
  TOperacao = class(TmMapping)
  private
    fCd_Operacao: String;
    fU_Version: String;
    fCd_Operador: Integer;
    fDt_Cadastro: String;
    fDs_Operacao: String;
    fTp_Docfiscal: Integer;
    fTp_Modalidade: Integer;
    fTp_Operacao: Integer;
    fCd_Serie: String;
    fCd_Regrafiscal: Integer;
    fCd_Cfop: Integer;
    procedure SetCd_Operacao(const Value : String);
    procedure SetU_Version(const Value : String);
    procedure SetCd_Operador(const Value : Integer);
    procedure SetDt_Cadastro(const Value : String);
    procedure SetDs_Operacao(const Value : String);
    procedure SetTp_Docfiscal(const Value : Integer);
    procedure SetTp_Modalidade(const Value : Integer);
    procedure SetTp_Operacao(const Value : Integer);
    procedure SetCd_Serie(const Value : String);
    procedure SetCd_Regrafiscal(const Value : Integer);
    procedure SetCd_Cfop(const Value : Integer);
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function GetTabela() : TmTabela; override;
    function GetKeys() : TmKeys; override;
    function GetCampos() : TmCampos; override;
  published
    property Cd_Operacao : String read fCd_Operacao write SetCd_Operacao;
    property U_Version : String read fU_Version write SetU_Version;
    property Cd_Operador : Integer read fCd_Operador write SetCd_Operador;
    property Dt_Cadastro : String read fDt_Cadastro write SetDt_Cadastro;
    property Ds_Operacao : String read fDs_Operacao write SetDs_Operacao;
    property Tp_Docfiscal : Integer read fTp_Docfiscal write SetTp_Docfiscal;
    property Tp_Modalidade : Integer read fTp_Modalidade write SetTp_Modalidade;
    property Tp_Operacao : Integer read fTp_Operacao write SetTp_Operacao;
    property Cd_Serie : String read fCd_Serie write SetCd_Serie;
    property Cd_Regrafiscal : Integer read fCd_Regrafiscal write SetCd_Regrafiscal;
    property Cd_Cfop : Integer read fCd_Cfop write SetCd_Cfop;
  end;

  TOperacaos = class(TList)
  public
    function Add: TOperacao; overload;
  end;

implementation

{ TOperacao }

constructor TOperacao.Create(AOwner: TComponent);
begin
  inherited;

end;

destructor TOperacao.Destroy;
begin

  inherited;
end;

//--

function TOperacao.GetTabela: TmTabela;
begin
  Result.Nome := 'OPERACAO';
end;

function TOperacao.GetKeys: TmKeys;
begin
  AddKeysResult(Result, [
    'Cd_Operacao|CD_OPERACAO']);
end;

function TOperacao.GetCampos: TmCampos;
begin
  AddCamposResult(Result, [
    'Cd_Operacao|CD_OPERACAO',
    'U_Version|U_VERSION',
    'Cd_Operador|CD_OPERADOR',
    'Dt_Cadastro|DT_CADASTRO',
    'Ds_Operacao|DS_OPERACAO',
    'Tp_Docfiscal|TP_DOCFISCAL',
    'Tp_Modalidade|TP_MODALIDADE',
    'Tp_Operacao|TP_OPERACAO',
    'Cd_Serie|CD_SERIE',
    'Cd_Regrafiscal|CD_REGRAFISCAL',
    'Cd_Cfop|CD_CFOP']);
end;

//--

procedure TOperacao.SetCd_Operacao(const Value : String);
begin
  fCd_Operacao := Value;
end;

procedure TOperacao.SetU_Version(const Value : String);
begin
  fU_Version := Value;
end;

procedure TOperacao.SetCd_Operador(const Value : Integer);
begin
  fCd_Operador := Value;
end;

procedure TOperacao.SetDt_Cadastro(const Value : String);
begin
  fDt_Cadastro := Value;
end;

procedure TOperacao.SetDs_Operacao(const Value : String);
begin
  fDs_Operacao := Value;
end;

procedure TOperacao.SetTp_Docfiscal(const Value : Integer);
begin
  fTp_Docfiscal := Value;
end;

procedure TOperacao.SetTp_Modalidade(const Value : Integer);
begin
  fTp_Modalidade := Value;
end;

procedure TOperacao.SetTp_Operacao(const Value : Integer);
begin
  fTp_Operacao := Value;
end;

procedure TOperacao.SetCd_Serie(const Value : String);
begin
  fCd_Serie := Value;
end;

procedure TOperacao.SetCd_Regrafiscal(const Value : Integer);
begin
  fCd_Regrafiscal := Value;
end;

procedure TOperacao.SetCd_Cfop(const Value : Integer);
begin
  fCd_Cfop := Value;
end;

{ TOperacaos }

function TOperacaos.Add: TOperacao;
begin
  Result := TOperacao.Create(nil);
  Self.Add(Result);
end;

end.