unit uTransitem;

interface

uses
  Classes, SysUtils,
  mMapping;

type
  TTransitem = class(TmMapping)
  private
    fId_Transacao: String;
    fNr_Item: Integer;
    fU_Version: String;
    fCd_Operador: Integer;
    fDt_Cadastro: String;
    fId_Produto: String;
    fCd_Produto: Integer;
    fDs_Produto: String;
    fCd_Cfop: Integer;
    fCd_Especie: String;
    fCd_Ncm: String;
    fQt_Item: String;
    fVl_Custo: String;
    fVl_Unitario: String;
    fVl_Item: String;
    fVl_Variacao: String;
    fVl_Variacaocapa: String;
    fVl_Frete: String;
    fVl_Seguro: String;
    fVl_Outro: String;
    fVl_Despesa: String;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function GetMapping() : PmMapping; override;
  published
    property Id_Transacao : String read fId_Transacao write fId_Transacao;
    property Nr_Item : Integer read fNr_Item write fNr_Item;
    property U_Version : String read fU_Version write fU_Version;
    property Cd_Operador : Integer read fCd_Operador write fCd_Operador;
    property Dt_Cadastro : String read fDt_Cadastro write fDt_Cadastro;
    property Id_Produto : String read fId_Produto write fId_Produto;
    property Cd_Produto : Integer read fCd_Produto write fCd_Produto;
    property Ds_Produto : String read fDs_Produto write fDs_Produto;
    property Cd_Cfop : Integer read fCd_Cfop write fCd_Cfop;
    property Cd_Especie : String read fCd_Especie write fCd_Especie;
    property Cd_Ncm : String read fCd_Ncm write fCd_Ncm;
    property Qt_Item : String read fQt_Item write fQt_Item;
    property Vl_Custo : String read fVl_Custo write fVl_Custo;
    property Vl_Unitario : String read fVl_Unitario write fVl_Unitario;
    property Vl_Item : String read fVl_Item write fVl_Item;
    property Vl_Variacao : String read fVl_Variacao write fVl_Variacao;
    property Vl_Variacaocapa : String read fVl_Variacaocapa write fVl_Variacaocapa;
    property Vl_Frete : String read fVl_Frete write fVl_Frete;
    property Vl_Seguro : String read fVl_Seguro write fVl_Seguro;
    property Vl_Outro : String read fVl_Outro write fVl_Outro;
    property Vl_Despesa : String read fVl_Despesa write fVl_Despesa;
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
  Result := New(PmMapping);

  Result.Tabela := New(PmTabela);
  with Result.Tabela^ do begin
    Nome := 'TRANSITEM';
  end;

  Result.Campos := TmCampos.Create;
  with Result.Campos do begin
    Add('Id_Transacao', 'ID_TRANSACAO', tfKey);
    Add('Nr_Item', 'NR_ITEM', tfKey);
    Add('U_Version', 'U_VERSION', tfNul);
    Add('Cd_Operador', 'CD_OPERADOR', tfReq);
    Add('Dt_Cadastro', 'DT_CADASTRO', tfReq);
    Add('Id_Produto', 'ID_PRODUTO', tfReq);
    Add('Cd_Produto', 'CD_PRODUTO', tfReq);
    Add('Ds_Produto', 'DS_PRODUTO', tfReq);
    Add('Cd_Cfop', 'CD_CFOP', tfReq);
    Add('Cd_Especie', 'CD_ESPECIE', tfReq);
    Add('Cd_Ncm', 'CD_NCM', tfReq);
    Add('Qt_Item', 'QT_ITEM', tfReq);
    Add('Vl_Custo', 'VL_CUSTO', tfReq);
    Add('Vl_Unitario', 'VL_UNITARIO', tfReq);
    Add('Vl_Item', 'VL_ITEM', tfReq);
    Add('Vl_Variacao', 'VL_VARIACAO', tfReq);
    Add('Vl_Variacaocapa', 'VL_VARIACAOCAPA', tfReq);
    Add('Vl_Frete', 'VL_FRETE', tfReq);
    Add('Vl_Seguro', 'VL_SEGURO', tfReq);
    Add('Vl_Outro', 'VL_OUTRO', tfReq);
    Add('Vl_Despesa', 'VL_DESPESA', tfReq);
  end;

  Result.Relacoes := TmRelacoes.Create;
  with Result.Relacoes do begin
  end;
end;

//--

{ TTransitems }

function TTransitems.Add: TTransitem;
begin
  Result := TTransitem.Create(nil);
  Self.Add(Result);
end;

end.