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
    fDt_Cadastro: TDateTime;
    fId_Produto: String;
    fCd_Produto: Integer;
    fDs_Produto: String;
    fCd_Cfop: Integer;
    fCd_Especie: String;
    fCd_Ncm: String;
    fQt_Item: Real;
    fVl_Custo: Real;
    fVl_Unitario: Real;
    fVl_Item: Real;
    fVl_Variacao: Real;
    fVl_Variacaocapa: Real;
    fVl_Frete: Real;
    fVl_Seguro: Real;
    fVl_Outro: Real;
    fVl_Despesa: Real;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function GetMapping() : PmMapping; override;
  published
    property Id_Transacao : String read fId_Transacao write fId_Transacao;
    property Nr_Item : Integer read fNr_Item write fNr_Item;
    property U_Version : String read fU_Version write fU_Version;
    property Cd_Operador : Integer read fCd_Operador write fCd_Operador;
    property Dt_Cadastro : TDateTime read fDt_Cadastro write fDt_Cadastro;
    property Id_Produto : String read fId_Produto write fId_Produto;
    property Cd_Produto : Integer read fCd_Produto write fCd_Produto;
    property Ds_Produto : String read fDs_Produto write fDs_Produto;
    property Cd_Cfop : Integer read fCd_Cfop write fCd_Cfop;
    property Cd_Especie : String read fCd_Especie write fCd_Especie;
    property Cd_Ncm : String read fCd_Ncm write fCd_Ncm;
    property Qt_Item : Real read fQt_Item write fQt_Item;
    property Vl_Custo : Real read fVl_Custo write fVl_Custo;
    property Vl_Unitario : Real read fVl_Unitario write fVl_Unitario;
    property Vl_Item : Real read fVl_Item write fVl_Item;
    property Vl_Variacao : Real read fVl_Variacao write fVl_Variacao;
    property Vl_Variacaocapa : Real read fVl_Variacaocapa write fVl_Variacaocapa;
    property Vl_Frete : Real read fVl_Frete write fVl_Frete;
    property Vl_Seguro : Real read fVl_Seguro write fVl_Seguro;
    property Vl_Outro : Real read fVl_Outro write fVl_Outro;
    property Vl_Despesa : Real read fVl_Despesa write fVl_Despesa;
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
    Add('Id_Transacao', 'ID_TRANSACAO', ftKey);
    Add('Nr_Item', 'NR_ITEM', ftKey);
    Add('U_Version', 'U_VERSION', ftNul);
    Add('Cd_Operador', 'CD_OPERADOR', ftReq);
    Add('Dt_Cadastro', 'DT_CADASTRO', ftReq);
    Add('Id_Produto', 'ID_PRODUTO', ftReq);
    Add('Cd_Produto', 'CD_PRODUTO', ftReq);
    Add('Ds_Produto', 'DS_PRODUTO', ftReq);
    Add('Cd_Cfop', 'CD_CFOP', ftReq);
    Add('Cd_Especie', 'CD_ESPECIE', ftReq);
    Add('Cd_Ncm', 'CD_NCM', ftReq);
    Add('Qt_Item', 'QT_ITEM', ftReq);
    Add('Vl_Custo', 'VL_CUSTO', ftReq);
    Add('Vl_Unitario', 'VL_UNITARIO', ftReq);
    Add('Vl_Item', 'VL_ITEM', ftReq);
    Add('Vl_Variacao', 'VL_VARIACAO', ftReq);
    Add('Vl_Variacaocapa', 'VL_VARIACAOCAPA', ftReq);
    Add('Vl_Frete', 'VL_FRETE', ftReq);
    Add('Vl_Seguro', 'VL_SEGURO', ftReq);
    Add('Vl_Outro', 'VL_OUTRO', ftReq);
    Add('Vl_Despesa', 'VL_DESPESA', ftReq);
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