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
    fDt_Cadastro: String;
    fDs_Xml: String;
    fDs_Retornoxml: String;
    procedure SetCd_Dnatrans(const Value : String);
    procedure SetNr_Sequencia(const Value : Integer);
    procedure SetU_Version(const Value : String);
    procedure SetCd_Operador(const Value : Integer);
    procedure SetDt_Cadastro(const Value : String);
    procedure SetDs_Xml(const Value : String);
    procedure SetDs_Retornoxml(const Value : String);
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function GetTabela() : TmTabela; override;
    function GetKeys() : TmKeys; override;
    function GetCampos() : TmCampos; override;
  published
    property Cd_Dnatrans : String read fCd_Dnatrans write SetCd_Dnatrans;
    property Nr_Sequencia : Integer read fNr_Sequencia write SetNr_Sequencia;
    property U_Version : String read fU_Version write SetU_Version;
    property Cd_Operador : Integer read fCd_Operador write SetCd_Operador;
    property Dt_Cadastro : String read fDt_Cadastro write SetDt_Cadastro;
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

function TTransdfe.GetTabela: TmTabela;
begin
  Result.Nome := 'TRANSDFE';
end;

function TTransdfe.GetKeys: TmKeys;
begin
  AddKeysResult(Result, [
    'Cd_Dnatrans|CD_DNATRANS',
    'Nr_Sequencia|NR_SEQUENCIA']);
end;

function TTransdfe.GetCampos: TmCampos;
begin
  AddCamposResult(Result, [
    'Cd_Dnatrans|CD_DNATRANS',
    'Nr_Sequencia|NR_SEQUENCIA',
    'U_Version|U_VERSION',
    'Cd_Operador|CD_OPERADOR',
    'Dt_Cadastro|DT_CADASTRO',
    'Ds_Xml|DS_XML',
    'Ds_Retornoxml|DS_RETORNOXML']);
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

procedure TTransdfe.SetDt_Cadastro(const Value : String);
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