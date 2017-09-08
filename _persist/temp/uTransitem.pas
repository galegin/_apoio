unit uTransitem;

interface

uses
  Classes, SysUtils,
  mMapping;

type
  TTransitem = class(TmMapping)
  private
    fCd_Dnatrans: String;
    fNr_Item: Integer;
    fU_Version: String;
    fCd_Operador: Integer;
    fDt_Cadastro: String;
    fCd_Barraprd: String;
    fCd_Produto: Integer;
    fDs_Produto: String;
    fCd_Cfop: Integer;
    fQt_Item: String;
    fVl_Custo: String;
    fVl_Unitario: String;
    fVl_Item: String;
    fVl_Variacao: String;
    fVl_Variacaocapa: String;
    fCd_Especie: String;
    fCd_Ncm: String;
    fVl_Frete: String;
    fVl_Seguro: String;
    fVl_Outro: String;
    fVl_Despesa: String;
    procedure SetCd_Dnatrans(const Value : String);
    procedure SetNr_Item(const Value : Integer);
    procedure SetU_Version(const Value : String);
    procedure SetCd_Operador(const Value : Integer);
    procedure SetDt_Cadastro(const Value : String);
    procedure SetCd_Barraprd(const Value : String);
    procedure SetCd_Produto(const Value : Integer);
    procedure SetDs_Produto(const Value : String);
    procedure SetCd_Cfop(const Value : Integer);
    procedure SetQt_Item(const Value : String);
    procedure SetVl_Custo(const Value : String);
    procedure SetVl_Unitario(const Value : String);
    procedure SetVl_Item(const Value : String);
    procedure SetVl_Variacao(const Value : String);
    procedure SetVl_Variacaocapa(const Value : String);
    procedure SetCd_Especie(const Value : String);
    procedure SetCd_Ncm(const Value : String);
    procedure SetVl_Frete(const Value : String);
    procedure SetVl_Seguro(const Value : String);
    procedure SetVl_Outro(const Value : String);
    procedure SetVl_Despesa(const Value : String);
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function GetMapping() : PmMapping; override;
  published
    property Cd_Dnatrans : String read fCd_Dnatrans write SetCd_Dnatrans;
    property Nr_Item : Integer read fNr_Item write SetNr_Item;
    property U_Version : String read fU_Version write SetU_Version;
    property Cd_Operador : Integer read fCd_Operador write SetCd_Operador;
    property Dt_Cadastro : String read fDt_Cadastro write SetDt_Cadastro;
    property Cd_Barraprd : String read fCd_Barraprd write SetCd_Barraprd;
    property Cd_Produto : Integer read fCd_Produto write SetCd_Produto;
    property Ds_Produto : String read fDs_Produto write SetDs_Produto;
    property Cd_Cfop : Integer read fCd_Cfop write SetCd_Cfop;
    property Qt_Item : String read fQt_Item write SetQt_Item;
    property Vl_Custo : String read fVl_Custo write SetVl_Custo;
    property Vl_Unitario : String read fVl_Unitario write SetVl_Unitario;
    property Vl_Item : String read fVl_Item write SetVl_Item;
    property Vl_Variacao : String read fVl_Variacao write SetVl_Variacao;
    property Vl_Variacaocapa : String read fVl_Variacaocapa write SetVl_Variacaocapa;
    property Cd_Especie : String read fCd_Especie write SetCd_Especie;
    property Cd_Ncm : String read fCd_Ncm write SetCd_Ncm;
    property Vl_Frete : String read fVl_Frete write SetVl_Frete;
    property Vl_Seguro : String read fVl_Seguro write SetVl_Seguro;
    property Vl_Outro : String read fVl_Outro write SetVl_Outro;
    property Vl_Despesa : String read fVl_Despesa write SetVl_Despesa;
  end;

  TTransitems = class(TList)
  public
    function Add: TTransitem; overload;
  end;

implementation

{ TTransitem }

constructor TTransitem.Create(AOwner: TComponent);
begin
  inherited;

end;

destructor TTransitem.Destroy;
begin

  inherited;
end;

//--

function TTransitem.GetMapping: PmMapping;
begin
  with Result.Tabela do begin
    Nome := 'TRANSITEM';
  end;

  Result.Chaves := TmChaves.Create;
  with Result.Chaves do begin
    Add('Cd_Dnatrans', 'CD_DNATRANS');
    Add('Nr_Item', 'NR_ITEM');
  end;

  Result.Campos := TmCampos.Create;
  with Result.Campos do begin
    Add('Cd_Dnatrans', 'CD_DNATRANS');
    Add('Nr_Item', 'NR_ITEM');
    Add('U_Version', 'U_VERSION');
    Add('Cd_Operador', 'CD_OPERADOR');
    Add('Dt_Cadastro', 'DT_CADASTRO');
    Add('Cd_Barraprd', 'CD_BARRAPRD');
    Add('Cd_Produto', 'CD_PRODUTO');
    Add('Ds_Produto', 'DS_PRODUTO');
    Add('Cd_Cfop', 'CD_CFOP');
    Add('Qt_Item', 'QT_ITEM');
    Add('Vl_Custo', 'VL_CUSTO');
    Add('Vl_Unitario', 'VL_UNITARIO');
    Add('Vl_Item', 'VL_ITEM');
    Add('Vl_Variacao', 'VL_VARIACAO');
    Add('Vl_Variacaocapa', 'VL_VARIACAOCAPA');
    Add('Cd_Especie', 'CD_ESPECIE');
    Add('Cd_Ncm', 'CD_NCM');
    Add('Vl_Frete', 'VL_FRETE');
    Add('Vl_Seguro', 'VL_SEGURO');
    Add('Vl_Outro', 'VL_OUTRO');
    Add('Vl_Despesa', 'VL_DESPESA');
  end;
end;

//--

procedure TTransitem.SetCd_Dnatrans(const Value : String);
begin
  fCd_Dnatrans := Value;
end;

procedure TTransitem.SetNr_Item(const Value : Integer);
begin
  fNr_Item := Value;
end;

procedure TTransitem.SetU_Version(const Value : String);
begin
  fU_Version := Value;
end;

procedure TTransitem.SetCd_Operador(const Value : Integer);
begin
  fCd_Operador := Value;
end;

procedure TTransitem.SetDt_Cadastro(const Value : String);
begin
  fDt_Cadastro := Value;
end;

procedure TTransitem.SetCd_Barraprd(const Value : String);
begin
  fCd_Barraprd := Value;
end;

procedure TTransitem.SetCd_Produto(const Value : Integer);
begin
  fCd_Produto := Value;
end;

procedure TTransitem.SetDs_Produto(const Value : String);
begin
  fDs_Produto := Value;
end;

procedure TTransitem.SetCd_Cfop(const Value : Integer);
begin
  fCd_Cfop := Value;
end;

procedure TTransitem.SetQt_Item(const Value : String);
begin
  fQt_Item := Value;
end;

procedure TTransitem.SetVl_Custo(const Value : String);
begin
  fVl_Custo := Value;
end;

procedure TTransitem.SetVl_Unitario(const Value : String);
begin
  fVl_Unitario := Value;
end;

procedure TTransitem.SetVl_Item(const Value : String);
begin
  fVl_Item := Value;
end;

procedure TTransitem.SetVl_Variacao(const Value : String);
begin
  fVl_Variacao := Value;
end;

procedure TTransitem.SetVl_Variacaocapa(const Value : String);
begin
  fVl_Variacaocapa := Value;
end;

procedure TTransitem.SetCd_Especie(const Value : String);
begin
  fCd_Especie := Value;
end;

procedure TTransitem.SetCd_Ncm(const Value : String);
begin
  fCd_Ncm := Value;
end;

procedure TTransitem.SetVl_Frete(const Value : String);
begin
  fVl_Frete := Value;
end;

procedure TTransitem.SetVl_Seguro(const Value : String);
begin
  fVl_Seguro := Value;
end;

procedure TTransitem.SetVl_Outro(const Value : String);
begin
  fVl_Outro := Value;
end;

procedure TTransitem.SetVl_Despesa(const Value : String);
begin
  fVl_Despesa := Value;
end;

{ TTransitems }

function TTransitems.Add: TTransitem;
begin
  Result := TTransitem.Create(nil);
  Self.Add(Result);
end;

end.