unit uTransdfe;

interface

uses
  Classes, SysUtils,
  mMapping;

type
  TTransdfe = class(TmMapping)
  private
    fCd_Dnatrans: String;
    fNr_Sequencia: Integer;
    fU_Version: String;
    fCd_Operador: Integer;
    fDt_Cadastro: TDateTime;
    fDs_Xml: String;
    fDs_Retornoxml: String;
    procedure SetCd_Dnatrans(const Value : String);
    procedure SetNr_Sequencia(const Value : Integer);
    procedure SetU_Version(const Value : String);
    procedure SetCd_Operador(const Value : Integer);
    procedure SetDt_Cadastro(const Value : TDateTime);
    procedure SetDs_Xml(const Value : String);
    procedure SetDs_Retornoxml(const Value : String);
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function GetMapping() : PmMapping; override;
  published
    property Cd_Dnatrans : String read fCd_Dnatrans write SetCd_Dnatrans;
    property Nr_Sequencia : Integer read fNr_Sequencia write SetNr_Sequencia;
    property U_Version : String read fU_Version write SetU_Version;
    property Cd_Operador : Integer read fCd_Operador write SetCd_Operador;
    property Dt_Cadastro : TDateTime read fDt_Cadastro write SetDt_Cadastro;
    property Ds_Xml : String read fDs_Xml write SetDs_Xml;
    property Ds_Retornoxml : String read fDs_Retornoxml write SetDs_Retornoxml;
  end;

  TTransdfes = class(TList)
  public
    function Add: TTransdfe; overload;
  end;

implementation

{ TTransdfe }

constructor TTransdfe.Create(AOwner: TComponent);
begin
  inherited;

end;

destructor TTransdfe.Destroy;
begin

  inherited;
end;

//--

function TTransdfe.GetMapping: PmMapping;
begin
  Result := New(PmMapping);

  Result.Tabela := New(PmTabela);
  with Result.Tabela^ do begin
    Nome := 'TRANSDFE';
  end;

  Result.Chaves := TmChaves.Create;
  with Result.Chaves do begin
    Add('Cd_Dnatrans', 'CD_DNATRANS');
    Add('Nr_Sequencia', 'NR_SEQUENCIA');
  end;

  Result.Campos := TmCampos.Create;
  with Result.Campos do begin
    Add('Cd_Dnatrans', 'CD_DNATRANS');
    Add('Nr_Sequencia', 'NR_SEQUENCIA');
    Add('U_Version', 'U_VERSION');
    Add('Cd_Operador', 'CD_OPERADOR');
    Add('Dt_Cadastro', 'DT_CADASTRO');
    Add('Ds_Xml', 'DS_XML');
    Add('Ds_Retornoxml', 'DS_RETORNOXML');
  end;

  Result.Relacoes := TmRelacoes.Create;
  with Result.Relacoes do begin
  end;
end;

//--

procedure TTransdfe.SetCd_Dnatrans(const Value : String);
begin
  fCd_Dnatrans := Value;
end;

procedure TTransdfe.SetNr_Sequencia(const Value : Integer);
begin
  fNr_Sequencia := Value;
end;

procedure TTransdfe.SetU_Version(const Value : String);
begin
  fU_Version := Value;
end;

procedure TTransdfe.SetCd_Operador(const Value : Integer);
begin
  fCd_Operador := Value;
end;

procedure TTransdfe.SetDt_Cadastro(const Value : TDateTime);
begin
  fDt_Cadastro := Value;
end;

procedure TTransdfe.SetDs_Xml(const Value : String);
begin
  fDs_Xml := Value;
end;

procedure TTransdfe.SetDs_Retornoxml(const Value : String);
begin
  fDs_Retornoxml := Value;
end;

{ TTransdfes }

function TTransdfes.Add: TTransdfe;
begin
  Result := TTransdfe.Create(nil);
  Self.Add(Result);
end;

end.