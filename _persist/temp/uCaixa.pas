unit uCaixa;

interface

uses
  Classes, SysUtils,
  mMapping;

type
  TCaixa = class(TmMapping)
  private
    fCd_Dnacaixa: String;
    fU_Version: String;
    fCd_Operador: Integer;
    fDt_Cadastro: TDateTime;
    fCd_Equip: String;
    fDt_Caixa: TDateTime;
    fNr_Seq: Integer;
    fVl_Abertura: Real;
    fDt_Fechado: TDateTime;
    procedure SetCd_Dnacaixa(const Value : String);
    procedure SetU_Version(const Value : String);
    procedure SetCd_Operador(const Value : Integer);
    procedure SetDt_Cadastro(const Value : TDateTime);
    procedure SetCd_Equip(const Value : String);
    procedure SetDt_Caixa(const Value : TDateTime);
    procedure SetNr_Seq(const Value : Integer);
    procedure SetVl_Abertura(const Value : Real);
    procedure SetDt_Fechado(const Value : TDateTime);
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function GetMapping() : PmMapping; override;
  published
    property Cd_Dnacaixa : String read fCd_Dnacaixa write SetCd_Dnacaixa;
    property U_Version : String read fU_Version write SetU_Version;
    property Cd_Operador : Integer read fCd_Operador write SetCd_Operador;
    property Dt_Cadastro : TDateTime read fDt_Cadastro write SetDt_Cadastro;
    property Cd_Equip : String read fCd_Equip write SetCd_Equip;
    property Dt_Caixa : TDateTime read fDt_Caixa write SetDt_Caixa;
    property Nr_Seq : Integer read fNr_Seq write SetNr_Seq;
    property Vl_Abertura : Real read fVl_Abertura write SetVl_Abertura;
    property Dt_Fechado : TDateTime read fDt_Fechado write SetDt_Fechado;
  end;

  TCaixas = class(TList)
  public
    function Add: TCaixa; overload;
  end;

implementation

{ TCaixa }

constructor TCaixa.Create(AOwner: TComponent);
begin
  inherited;

end;

destructor TCaixa.Destroy;
begin

  inherited;
end;

//--

function TCaixa.GetMapping: PmMapping;
begin
  Result := New(PmMapping);

  Result.Tabela := New(PmTabela);
  with Result.Tabela^ do begin
    Nome := 'CAIXA';
  end;

  Result.Chaves := TmChaves.Create;
  with Result.Chaves do begin
    Add('Cd_Dnacaixa', 'CD_DNACAIXA');
  end;

  Result.Campos := TmCampos.Create;
  with Result.Campos do begin
    Add('Cd_Dnacaixa', 'CD_DNACAIXA');
    Add('U_Version', 'U_VERSION');
    Add('Cd_Operador', 'CD_OPERADOR');
    Add('Dt_Cadastro', 'DT_CADASTRO');
    Add('Cd_Equip', 'CD_EQUIP');
    Add('Dt_Caixa', 'DT_CAIXA');
    Add('Nr_Seq', 'NR_SEQ');
    Add('Vl_Abertura', 'VL_ABERTURA');
    Add('Dt_Fechado', 'DT_FECHADO');
  end;

  Result.Relacoes := TmRelacoes.Create;
  with Result.Relacoes do begin
  end;
end;

//--

procedure TCaixa.SetCd_Dnacaixa(const Value : String);
begin
  fCd_Dnacaixa := Value;
end;

procedure TCaixa.SetU_Version(const Value : String);
begin
  fU_Version := Value;
end;

procedure TCaixa.SetCd_Operador(const Value : Integer);
begin
  fCd_Operador := Value;
end;

procedure TCaixa.SetDt_Cadastro(const Value : TDateTime);
begin
  fDt_Cadastro := Value;
end;

procedure TCaixa.SetCd_Equip(const Value : String);
begin
  fCd_Equip := Value;
end;

procedure TCaixa.SetDt_Caixa(const Value : TDateTime);
begin
  fDt_Caixa := Value;
end;

procedure TCaixa.SetNr_Seq(const Value : Integer);
begin
  fNr_Seq := Value;
end;

procedure TCaixa.SetVl_Abertura(const Value : Real);
begin
  fVl_Abertura := Value;
end;

procedure TCaixa.SetDt_Fechado(const Value : TDateTime);
begin
  fDt_Fechado := Value;
end;

{ TCaixas }

function TCaixas.Add: TCaixa;
begin
  Result := TCaixa.Create(nil);
  Self.Add(Result);
end;

end.