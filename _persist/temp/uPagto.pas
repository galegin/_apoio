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
    fDt_Cadastro: TDateTime;
    fCd_Equip: String;
    fDt_Pagto: TDateTime;
    fNr_Pagto: Integer;
    fVl_Pagto: Real;
    fVl_Entrada: Real;
    fVl_Troco: Real;
    fVl_Variacao: Real;
    fCd_Dnacaixa: String;
    procedure SetCd_Dnapagto(const Value : String);
    procedure SetU_Version(const Value : String);
    procedure SetCd_Operador(const Value : Integer);
    procedure SetDt_Cadastro(const Value : TDateTime);
    procedure SetCd_Equip(const Value : String);
    procedure SetDt_Pagto(const Value : TDateTime);
    procedure SetNr_Pagto(const Value : Integer);
    procedure SetVl_Pagto(const Value : Real);
    procedure SetVl_Entrada(const Value : Real);
    procedure SetVl_Troco(const Value : Real);
    procedure SetVl_Variacao(const Value : Real);
    procedure SetCd_Dnacaixa(const Value : String);
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function GetMapping() : PmMapping; override;
  published
    property Cd_Dnapagto : String read fCd_Dnapagto write SetCd_Dnapagto;
    property U_Version : String read fU_Version write SetU_Version;
    property Cd_Operador : Integer read fCd_Operador write SetCd_Operador;
    property Dt_Cadastro : TDateTime read fDt_Cadastro write SetDt_Cadastro;
    property Cd_Equip : String read fCd_Equip write SetCd_Equip;
    property Dt_Pagto : TDateTime read fDt_Pagto write SetDt_Pagto;
    property Nr_Pagto : Integer read fNr_Pagto write SetNr_Pagto;
    property Vl_Pagto : Real read fVl_Pagto write SetVl_Pagto;
    property Vl_Entrada : Real read fVl_Entrada write SetVl_Entrada;
    property Vl_Troco : Real read fVl_Troco write SetVl_Troco;
    property Vl_Variacao : Real read fVl_Variacao write SetVl_Variacao;
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

function TPagto.GetMapping: PmMapping;
begin
  Result := New(PmMapping);

  Result.Tabela := New(PmTabela);
  with Result.Tabela^ do begin
    Nome := 'PAGTO';
  end;

  Result.Chaves := TmChaves.Create;
  with Result.Chaves do begin
    Add('Cd_Dnapagto', 'CD_DNAPAGTO');
  end;

  Result.Campos := TmCampos.Create;
  with Result.Campos do begin
    Add('Cd_Dnapagto', 'CD_DNAPAGTO');
    Add('U_Version', 'U_VERSION');
    Add('Cd_Operador', 'CD_OPERADOR');
    Add('Dt_Cadastro', 'DT_CADASTRO');
    Add('Cd_Equip', 'CD_EQUIP');
    Add('Dt_Pagto', 'DT_PAGTO');
    Add('Nr_Pagto', 'NR_PAGTO');
    Add('Vl_Pagto', 'VL_PAGTO');
    Add('Vl_Entrada', 'VL_ENTRADA');
    Add('Vl_Troco', 'VL_TROCO');
    Add('Vl_Variacao', 'VL_VARIACAO');
    Add('Cd_Dnacaixa', 'CD_DNACAIXA');
  end;

  Result.Relacoes := TmRelacoes.Create;
  with Result.Relacoes do begin
  end;
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

procedure TPagto.SetDt_Cadastro(const Value : TDateTime);
begin
  fDt_Cadastro := Value;
end;

procedure TPagto.SetCd_Equip(const Value : String);
begin
  fCd_Equip := Value;
end;

procedure TPagto.SetDt_Pagto(const Value : TDateTime);
begin
  fDt_Pagto := Value;
end;

procedure TPagto.SetNr_Pagto(const Value : Integer);
begin
  fNr_Pagto := Value;
end;

procedure TPagto.SetVl_Pagto(const Value : Real);
begin
  fVl_Pagto := Value;
end;

procedure TPagto.SetVl_Entrada(const Value : Real);
begin
  fVl_Entrada := Value;
end;

procedure TPagto.SetVl_Troco(const Value : Real);
begin
  fVl_Troco := Value;
end;

procedure TPagto.SetVl_Variacao(const Value : Real);
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