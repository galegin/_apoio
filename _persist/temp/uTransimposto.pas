unit uTransimposto;

interface

uses
  Classes, SysUtils,
  mMapping;

type
  TTransimposto = class(TmMapping)
  private
    fCd_Dnatrans: String;
    fNr_Item: Integer;
    fCd_Imposto: Integer;
    fU_Version: String;
    fCd_Operador: Integer;
    fDt_Cadastro: String;
    fPr_Aliquota: String;
    fVl_Basecalculo: String;
    fPr_Basecalculo: String;
    fPr_Redbasecalculo: String;
    fVl_Imposto: String;
    fVl_Outro: String;
    fVl_Isento: String;
    fCd_Cst: String;
    fCd_Csosn: String;
    procedure SetCd_Dnatrans(const Value : String);
    procedure SetNr_Item(const Value : Integer);
    procedure SetCd_Imposto(const Value : Integer);
    procedure SetU_Version(const Value : String);
    procedure SetCd_Operador(const Value : Integer);
    procedure SetDt_Cadastro(const Value : String);
    procedure SetPr_Aliquota(const Value : String);
    procedure SetVl_Basecalculo(const Value : String);
    procedure SetPr_Basecalculo(const Value : String);
    procedure SetPr_Redbasecalculo(const Value : String);
    procedure SetVl_Imposto(const Value : String);
    procedure SetVl_Outro(const Value : String);
    procedure SetVl_Isento(const Value : String);
    procedure SetCd_Cst(const Value : String);
    procedure SetCd_Csosn(const Value : String);
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function GetTabela() : TmTabela; override;
    function GetKeys() : TmKeys; override;
    function GetCampos() : TmCampos; override;
  published
    property Cd_Dnatrans : String read fCd_Dnatrans write SetCd_Dnatrans;
    property Nr_Item : Integer read fNr_Item write SetNr_Item;
    property Cd_Imposto : Integer read fCd_Imposto write SetCd_Imposto;
    property U_Version : String read fU_Version write SetU_Version;
    property Cd_Operador : Integer read fCd_Operador write SetCd_Operador;
    property Dt_Cadastro : String read fDt_Cadastro write SetDt_Cadastro;
    property Pr_Aliquota : String read fPr_Aliquota write SetPr_Aliquota;
    property Vl_Basecalculo : String read fVl_Basecalculo write SetVl_Basecalculo;
    property Pr_Basecalculo : String read fPr_Basecalculo write SetPr_Basecalculo;
    property Pr_Redbasecalculo : String read fPr_Redbasecalculo write SetPr_Redbasecalculo;
    property Vl_Imposto : String read fVl_Imposto write SetVl_Imposto;
    property Vl_Outro : String read fVl_Outro write SetVl_Outro;
    property Vl_Isento : String read fVl_Isento write SetVl_Isento;
    property Cd_Cst : String read fCd_Cst write SetCd_Cst;
    property Cd_Csosn : String read fCd_Csosn write SetCd_Csosn;
  end;

  TTransimpostos = class(TList)
  public
    function Add: TTransimposto; overload;
  end;

implementation

{ TTransimposto }

constructor TTransimposto.Create(AOwner: TComponent);
begin
  inherited;

end;

destructor TTransimposto.Destroy;
begin

  inherited;
end;

//--

function TTransimposto.GetTabela: TmTabela;
begin
  Result.Nome := 'TRANSIMPOSTO';
end;

function TTransimposto.GetKeys: TmKeys;
begin
  AddKeysResult(Result, [
    'Cd_Dnatrans|CD_DNATRANS',
    'Nr_Item|NR_ITEM',
    'Cd_Imposto|CD_IMPOSTO']);
end;

function TTransimposto.GetCampos: TmCampos;
begin
  AddCamposResult(Result, [
    'Cd_Dnatrans|CD_DNATRANS',
    'Nr_Item|NR_ITEM',
    'Cd_Imposto|CD_IMPOSTO',
    'U_Version|U_VERSION',
    'Cd_Operador|CD_OPERADOR',
    'Dt_Cadastro|DT_CADASTRO',
    'Pr_Aliquota|PR_ALIQUOTA',
    'Vl_Basecalculo|VL_BASECALCULO',
    'Pr_Basecalculo|PR_BASECALCULO',
    'Pr_Redbasecalculo|PR_REDBASECALCULO',
    'Vl_Imposto|VL_IMPOSTO',
    'Vl_Outro|VL_OUTRO',
    'Vl_Isento|VL_ISENTO',
    'Cd_Cst|CD_CST',
    'Cd_Csosn|CD_CSOSN']);
end;

//--

procedure TTransimposto.SetCd_Dnatrans(const Value : String);
begin
  fCd_Dnatrans := Value;
end;

procedure TTransimposto.SetNr_Item(const Value : Integer);
begin
  fNr_Item := Value;
end;

procedure TTransimposto.SetCd_Imposto(const Value : Integer);
begin
  fCd_Imposto := Value;
end;

procedure TTransimposto.SetU_Version(const Value : String);
begin
  fU_Version := Value;
end;

procedure TTransimposto.SetCd_Operador(const Value : Integer);
begin
  fCd_Operador := Value;
end;

procedure TTransimposto.SetDt_Cadastro(const Value : String);
begin
  fDt_Cadastro := Value;
end;

procedure TTransimposto.SetPr_Aliquota(const Value : String);
begin
  fPr_Aliquota := Value;
end;

procedure TTransimposto.SetVl_Basecalculo(const Value : String);
begin
  fVl_Basecalculo := Value;
end;

procedure TTransimposto.SetPr_Basecalculo(const Value : String);
begin
  fPr_Basecalculo := Value;
end;

procedure TTransimposto.SetPr_Redbasecalculo(const Value : String);
begin
  fPr_Redbasecalculo := Value;
end;

procedure TTransimposto.SetVl_Imposto(const Value : String);
begin
  fVl_Imposto := Value;
end;

procedure TTransimposto.SetVl_Outro(const Value : String);
begin
  fVl_Outro := Value;
end;

procedure TTransimposto.SetVl_Isento(const Value : String);
begin
  fVl_Isento := Value;
end;

procedure TTransimposto.SetCd_Cst(const Value : String);
begin
  fCd_Cst := Value;
end;

procedure TTransimposto.SetCd_Csosn(const Value : String);
begin
  fCd_Csosn := Value;
end;

{ TTransimpostos }

function TTransimpostos.Add: TTransimposto;
begin
  Result := TTransimposto.Create(nil);
  Self.Add(Result);
end;

end.