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
    fDt_Cadastro: TDateTime;
    fPr_Aliquota: Real;
    fVl_Basecalculo: Real;
    fPr_Basecalculo: Real;
    fPr_Redbasecalculo: Real;
    fVl_Imposto: Real;
    fVl_Outro: Real;
    fVl_Isento: Real;
    fCd_Cst: String;
    fCd_Csosn: String;
    procedure SetCd_Dnatrans(const Value : String);
    procedure SetNr_Item(const Value : Integer);
    procedure SetCd_Imposto(const Value : Integer);
    procedure SetU_Version(const Value : String);
    procedure SetCd_Operador(const Value : Integer);
    procedure SetDt_Cadastro(const Value : TDateTime);
    procedure SetPr_Aliquota(const Value : Real);
    procedure SetVl_Basecalculo(const Value : Real);
    procedure SetPr_Basecalculo(const Value : Real);
    procedure SetPr_Redbasecalculo(const Value : Real);
    procedure SetVl_Imposto(const Value : Real);
    procedure SetVl_Outro(const Value : Real);
    procedure SetVl_Isento(const Value : Real);
    procedure SetCd_Cst(const Value : String);
    procedure SetCd_Csosn(const Value : String);
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function GetMapping() : PmMapping; override;
  published
    property Cd_Dnatrans : String read fCd_Dnatrans write SetCd_Dnatrans;
    property Nr_Item : Integer read fNr_Item write SetNr_Item;
    property Cd_Imposto : Integer read fCd_Imposto write SetCd_Imposto;
    property U_Version : String read fU_Version write SetU_Version;
    property Cd_Operador : Integer read fCd_Operador write SetCd_Operador;
    property Dt_Cadastro : TDateTime read fDt_Cadastro write SetDt_Cadastro;
    property Pr_Aliquota : Real read fPr_Aliquota write SetPr_Aliquota;
    property Vl_Basecalculo : Real read fVl_Basecalculo write SetVl_Basecalculo;
    property Pr_Basecalculo : Real read fPr_Basecalculo write SetPr_Basecalculo;
    property Pr_Redbasecalculo : Real read fPr_Redbasecalculo write SetPr_Redbasecalculo;
    property Vl_Imposto : Real read fVl_Imposto write SetVl_Imposto;
    property Vl_Outro : Real read fVl_Outro write SetVl_Outro;
    property Vl_Isento : Real read fVl_Isento write SetVl_Isento;
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

function TTransimposto.GetMapping: PmMapping;
begin
  Result := New(PmMapping);

  Result.Tabela := New(PmTabela);
  with Result.Tabela^ do begin
    Nome := 'TRANSIMPOSTO';
  end;

  Result.Chaves := TmChaves.Create;
  with Result.Chaves do begin
    Add('Cd_Dnatrans', 'CD_DNATRANS');
    Add('Nr_Item', 'NR_ITEM');
    Add('Cd_Imposto', 'CD_IMPOSTO');
  end;

  Result.Campos := TmCampos.Create;
  with Result.Campos do begin
    Add('Cd_Dnatrans', 'CD_DNATRANS');
    Add('Nr_Item', 'NR_ITEM');
    Add('Cd_Imposto', 'CD_IMPOSTO');
    Add('U_Version', 'U_VERSION');
    Add('Cd_Operador', 'CD_OPERADOR');
    Add('Dt_Cadastro', 'DT_CADASTRO');
    Add('Pr_Aliquota', 'PR_ALIQUOTA');
    Add('Vl_Basecalculo', 'VL_BASECALCULO');
    Add('Pr_Basecalculo', 'PR_BASECALCULO');
    Add('Pr_Redbasecalculo', 'PR_REDBASECALCULO');
    Add('Vl_Imposto', 'VL_IMPOSTO');
    Add('Vl_Outro', 'VL_OUTRO');
    Add('Vl_Isento', 'VL_ISENTO');
    Add('Cd_Cst', 'CD_CST');
    Add('Cd_Csosn', 'CD_CSOSN');
  end;

  Result.Relacoes := TmRelacoes.Create;
  with Result.Relacoes do begin
  end;
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

procedure TTransimposto.SetDt_Cadastro(const Value : TDateTime);
begin
  fDt_Cadastro := Value;
end;

procedure TTransimposto.SetPr_Aliquota(const Value : Real);
begin
  fPr_Aliquota := Value;
end;

procedure TTransimposto.SetVl_Basecalculo(const Value : Real);
begin
  fVl_Basecalculo := Value;
end;

procedure TTransimposto.SetPr_Basecalculo(const Value : Real);
begin
  fPr_Basecalculo := Value;
end;

procedure TTransimposto.SetPr_Redbasecalculo(const Value : Real);
begin
  fPr_Redbasecalculo := Value;
end;

procedure TTransimposto.SetVl_Imposto(const Value : Real);
begin
  fVl_Imposto := Value;
end;

procedure TTransimposto.SetVl_Outro(const Value : Real);
begin
  fVl_Outro := Value;
end;

procedure TTransimposto.SetVl_Isento(const Value : Real);
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