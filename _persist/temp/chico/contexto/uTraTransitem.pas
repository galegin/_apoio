unit uTraTransitem;

interface

uses
  Classes, SysUtils,
  mMapping;

type
  TTra_Transitem = class(TmMapping)
  private
    fCd_Empresa: String;
    fNr_Transacao: String;
    fDt_Transacao: String;
    fNr_Item: String;
    fU_Version: String;
    fCd_Empfat: String;
    fCd_Grupoempresa: String;
    fCd_Operador: String;
    fDt_Cadastro: String;
    fCd_Tipi: String;
    fCd_Cfop: String;
    fCd_Produto: String;
    fCd_Promocao: String;
    fCd_Decreto: String;
    fCd_Compvend: String;
    fCd_Especie: String;
    fCd_Cst: String;
    fIn_Desconto: String;
    fPr_Desconto: String;
    fDs_Produto: String;
    fCd_Barraprd: String;
    fQt_Solicitada: String;
    fQt_Atendida: String;
    fQt_Saldo: String;
    fQt_Anterior: String;
    fVl_Totalbruto: String;
    fVl_Totalliquido: String;
    fVl_Totaldesc: String;
    fVl_Totaldesccab: String;
    fVl_Unitbruto: String;
    fVl_Unitliquido: String;
    fVl_Unitdesccab: String;
    fVl_Unitdesc: String;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function GetMapping() : PmMapping; override;
  published
    property Cd_Empresa : String read fCd_Empresa write fCd_Empresa;
    property Nr_Transacao : String read fNr_Transacao write fNr_Transacao;
    property Dt_Transacao : String read fDt_Transacao write fDt_Transacao;
    property Nr_Item : String read fNr_Item write fNr_Item;
    property U_Version : String read fU_Version write fU_Version;
    property Cd_Empfat : String read fCd_Empfat write fCd_Empfat;
    property Cd_Grupoempresa : String read fCd_Grupoempresa write fCd_Grupoempresa;
    property Cd_Operador : String read fCd_Operador write fCd_Operador;
    property Dt_Cadastro : String read fDt_Cadastro write fDt_Cadastro;
    property Cd_Tipi : String read fCd_Tipi write fCd_Tipi;
    property Cd_Cfop : String read fCd_Cfop write fCd_Cfop;
    property Cd_Produto : String read fCd_Produto write fCd_Produto;
    property Cd_Promocao : String read fCd_Promocao write fCd_Promocao;
    property Cd_Decreto : String read fCd_Decreto write fCd_Decreto;
    property Cd_Compvend : String read fCd_Compvend write fCd_Compvend;
    property Cd_Especie : String read fCd_Especie write fCd_Especie;
    property Cd_Cst : String read fCd_Cst write fCd_Cst;
    property In_Desconto : String read fIn_Desconto write fIn_Desconto;
    property Pr_Desconto : String read fPr_Desconto write fPr_Desconto;
    property Ds_Produto : String read fDs_Produto write fDs_Produto;
    property Cd_Barraprd : String read fCd_Barraprd write fCd_Barraprd;
    property Qt_Solicitada : String read fQt_Solicitada write fQt_Solicitada;
    property Qt_Atendida : String read fQt_Atendida write fQt_Atendida;
    property Qt_Saldo : String read fQt_Saldo write fQt_Saldo;
    property Qt_Anterior : String read fQt_Anterior write fQt_Anterior;
    property Vl_Totalbruto : String read fVl_Totalbruto write fVl_Totalbruto;
    property Vl_Totalliquido : String read fVl_Totalliquido write fVl_Totalliquido;
    property Vl_Totaldesc : String read fVl_Totaldesc write fVl_Totaldesc;
    property Vl_Totaldesccab : String read fVl_Totaldesccab write fVl_Totaldesccab;
    property Vl_Unitbruto : String read fVl_Unitbruto write fVl_Unitbruto;
    property Vl_Unitliquido : String read fVl_Unitliquido write fVl_Unitliquido;
    property Vl_Unitdesccab : String read fVl_Unitdesccab write fVl_Unitdesccab;
    property Vl_Unitdesc : String read fVl_Unitdesc write fVl_Unitdesc;
  end;

  TTra_Transitems = class(TList)
  public
    function Add: TTra_Transitem; overload;
  end;

implementation

{ TTra_Transitem }

constructor TTra_Transitem.Create(AOwner: TComponent);
begin
  inherited;

end;

destructor TTra_Transitem.Destroy;
begin

  inherited;
end;

//--

function TTra_Transitem.GetMapping: PmMapping;
begin
  Result := New(PmMapping);

  Result.Tabela := New(PmTabela);
  with Result.Tabela^ do begin
    Nome := 'TRA_TRANSITEM';
  end;

  Result.Campos := TmCampos.Create;
  with Result.Campos do begin
    Add('Cd_Empresa', 'CD_EMPRESA', tfKey);
    Add('Nr_Transacao', 'NR_TRANSACAO', tfKey);
    Add('Dt_Transacao', 'DT_TRANSACAO', tfKey);
    Add('Nr_Item', 'NR_ITEM', tfKey);
    Add('U_Version', 'U_VERSION', tfNul);
    Add('Cd_Empfat', 'CD_EMPFAT', tfReq);
    Add('Cd_Grupoempresa', 'CD_GRUPOEMPRESA', tfReq);
    Add('Cd_Operador', 'CD_OPERADOR', tfReq);
    Add('Dt_Cadastro', 'DT_CADASTRO', tfReq);
    Add('Cd_Tipi', 'CD_TIPI', tfNul);
    Add('Cd_Cfop', 'CD_CFOP', tfNul);
    Add('Cd_Produto', 'CD_PRODUTO', tfReq);
    Add('Cd_Promocao', 'CD_PROMOCAO', tfNul);
    Add('Cd_Decreto', 'CD_DECRETO', tfNul);
    Add('Cd_Compvend', 'CD_COMPVEND', tfNul);
    Add('Cd_Especie', 'CD_ESPECIE', tfNul);
    Add('Cd_Cst', 'CD_CST', tfNul);
    Add('In_Desconto', 'IN_DESCONTO', tfNul);
    Add('Pr_Desconto', 'PR_DESCONTO', tfNul);
    Add('Ds_Produto', 'DS_PRODUTO', tfNul);
    Add('Cd_Barraprd', 'CD_BARRAPRD', tfNul);
    Add('Qt_Solicitada', 'QT_SOLICITADA', tfNul);
    Add('Qt_Atendida', 'QT_ATENDIDA', tfNul);
    Add('Qt_Saldo', 'QT_SALDO', tfNul);
    Add('Qt_Anterior', 'QT_ANTERIOR', tfNul);
    Add('Vl_Totalbruto', 'VL_TOTALBRUTO', tfNul);
    Add('Vl_Totalliquido', 'VL_TOTALLIQUIDO', tfNul);
    Add('Vl_Totaldesc', 'VL_TOTALDESC', tfNul);
    Add('Vl_Totaldesccab', 'VL_TOTALDESCCAB', tfNul);
    Add('Vl_Unitbruto', 'VL_UNITBRUTO', tfNul);
    Add('Vl_Unitliquido', 'VL_UNITLIQUIDO', tfNul);
    Add('Vl_Unitdesccab', 'VL_UNITDESCCAB', tfNul);
    Add('Vl_Unitdesc', 'VL_UNITDESC', tfNul);
  end;

  Result.Relacoes := TmRelacoes.Create;
  with Result.Relacoes do begin
  end;
end;

//--

{ TTra_Transitems }

function TTra_Transitems.Add: TTra_Transitem;
begin
  Result := TTra_Transitem.Create(nil);
  Self.Add(Result);
end;

end.