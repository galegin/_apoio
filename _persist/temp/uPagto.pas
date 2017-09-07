unit uPagto;

interface

uses
  Classes, SysUtils,
  mMapping;

type
  TPagto = class(TmMapping)
  private
    fCd_Dnapagto: String;
    fU_Version: String;
    fCd_Operador: Integer;
    fDt_Cadastro: String;
    fCd_Equip: String;
    fDt_Pagto: String;
    fNr_Pagto: Integer;
    fVl_Pagto: String;
    fVl_Entrada: String;
    fVl_Troco: String;
    fVl_Variacao: String;
    fCd_Dnacaixa: String;
    procedure SetCd_Dnapagto(const Value : String);
    procedure SetU_Version(const Value : String);
    procedure SetCd_Operador(const Value : Integer);
    procedure SetDt_Cadastro(const Value : String);
    procedure SetCd_Equip(const Value : String);
    procedure SetDt_Pagto(const Value : String);
    procedure SetNr_Pagto(const Value : Integer);
    procedure SetVl_Pagto(const Value : String);
    procedure SetVl_Entrada(const Value : String);
    procedure SetVl_Troco(const Value : String);
    procedure SetVl_Variacao(const Value : String);
    procedure SetCd_Dnacaixa(const Value : String);
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function GetTabela() : TmTabela; override;
    function GetKeys() : TmKeys; override;
    function GetCampos() : TmCampos; override;
  published
    property Cd_Dnapagto : String read fCd_Dnapagto write SetCd_Dnapagto;
    property U_Version : String read fU_Version write SetU_Version;
    property Cd_Operador : Integer read fCd_Operador write SetCd_Operador;
    property Dt_Cadastro : String read fDt_Cadastro write SetDt_Cadastro;
    property Cd_Equip : String read fCd_Equip write SetCd_Equip;
    property Dt_Pagto : String read fDt_Pagto write SetDt_Pagto;
    property Nr_Pagto : Integer read fNr_Pagto write SetNr_Pagto;
    property Vl_Pagto : String read fVl_Pagto write SetVl_Pagto;
    property Vl_Entrada : String read fVl_Entrada write SetVl_Entrada;
    property Vl_Troco : String read fVl_Troco write SetVl_Troco;
    property Vl_Variacao : String read fVl_Variacao write SetVl_Variacao;
    property Cd_Dnacaixa : String read fCd_Dnacaixa write SetCd_Dnacaixa;
  end;

  TPagtos = class(TList)
  public
    function Add: TPagto; overload;
  end;

implementation

{ TPagto }

constructor TPagto.Create(AOwner: TComponent);
begin
  inherited;

end;

destructor TPagto.Destroy;
begin

  inherited;
end;

//--

function TPagto.GetTabela: TmTabela;
begin
  Result.Nome := 'PAGTO';
end;

function TPagto.GetKeys: TmKeys;
begin
  AddKeysResult(Result, [
    'Cd_Dnapagto|CD_DNAPAGTO']);
end;

function TPagto.GetCampos: TmCampos;
begin
  AddCamposResult(Result, [
    'Cd_Dnapagto|CD_DNAPAGTO',
    'U_Version|U_VERSION',
    'Cd_Operador|CD_OPERADOR',
    'Dt_Cadastro|DT_CADASTRO',
    'Cd_Equip|CD_EQUIP',
    'Dt_Pagto|DT_PAGTO',
    'Nr_Pagto|NR_PAGTO',
    'Vl_Pagto|VL_PAGTO',
    'Vl_Entrada|VL_ENTRADA',
    'Vl_Troco|VL_TROCO',
    'Vl_Variacao|VL_VARIACAO',
    'Cd_Dnacaixa|CD_DNACAIXA']);
end;

//--

procedure TPagto.SetCd_Dnapagto(const Value : String);
begin
  fCd_Dnapagto := Value;
end;

procedure TPagto.SetU_Version(const Value : String);
begin
  fU_Version := Value;
end;

procedure TPagto.SetCd_Operador(const Value : Integer);
begin
  fCd_Operador := Value;
end;

procedure TPagto.SetDt_Cadastro(const Value : String);
begin
  fDt_Cadastro := Value;
end;

procedure TPagto.SetCd_Equip(const Value : String);
begin
  fCd_Equip := Value;
end;

procedure TPagto.SetDt_Pagto(const Value : String);
begin
  fDt_Pagto := Value;
end;

procedure TPagto.SetNr_Pagto(const Value : Integer);
begin
  fNr_Pagto := Value;
end;

procedure TPagto.SetVl_Pagto(const Value : String);
begin
  fVl_Pagto := Value;
end;

procedure TPagto.SetVl_Entrada(const Value : String);
begin
  fVl_Entrada := Value;
end;

procedure TPagto.SetVl_Troco(const Value : String);
begin
  fVl_Troco := Value;
end;

procedure TPagto.SetVl_Variacao(const Value : String);
begin
  fVl_Variacao := Value;
end;

procedure TPagto.SetCd_Dnacaixa(const Value : String);
begin
  fCd_Dnacaixa := Value;
end;

{ TPagtos }

function TPagtos.Add: TPagto;
begin
  Result := TPagto.Create(nil);
  Self.Add(Result);
end;

end.