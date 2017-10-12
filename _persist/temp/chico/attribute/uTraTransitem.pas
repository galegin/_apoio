unit uTraTransitem;

interface

uses
  Classes, SysUtils,
  System.Generics.Collections,
  mMapping;

type
  [Tabela('TRA_TRANSITEM')]
  TTra_Transitem = class(TmMapping)
  private
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
  published
    [Campo('CD_EMPRESA', tfKey)]
    property Cd_Empresa : String read fCd_Empresa write fCd_Empresa;
    [Campo('NR_TRANSACAO', tfKey)]
    property Nr_Transacao : String read fNr_Transacao write fNr_Transacao;
    [Campo('DT_TRANSACAO', tfKey)]
    property Dt_Transacao : String read fDt_Transacao write fDt_Transacao;
    [Campo('NR_ITEM', tfKey)]
    property Nr_Item : String read fNr_Item write fNr_Item;
    [Campo('U_VERSION', tfNul)]
    property U_Version : String read fU_Version write fU_Version;
    [Campo('CD_EMPFAT', tfReq)]
    property Cd_Empfat : String read fCd_Empfat write fCd_Empfat;
    [Campo('CD_GRUPOEMPRESA', tfReq)]
    property Cd_Grupoempresa : String read fCd_Grupoempresa write fCd_Grupoempresa;
    [Campo('CD_OPERADOR', tfReq)]
    property Cd_Operador : String read fCd_Operador write fCd_Operador;
    [Campo('DT_CADASTRO', tfReq)]
    property Dt_Cadastro : String read fDt_Cadastro write fDt_Cadastro;
    [Campo('CD_TIPI', tfNul)]
    property Cd_Tipi : String read fCd_Tipi write fCd_Tipi;
    [Campo('CD_CFOP', tfNul)]
    property Cd_Cfop : String read fCd_Cfop write fCd_Cfop;
    [Campo('CD_PRODUTO', tfReq)]
    property Cd_Produto : String read fCd_Produto write fCd_Produto;
    [Campo('CD_PROMOCAO', tfNul)]
    property Cd_Promocao : String read fCd_Promocao write fCd_Promocao;
    [Campo('CD_DECRETO', tfNul)]
    property Cd_Decreto : String read fCd_Decreto write fCd_Decreto;
    [Campo('CD_COMPVEND', tfNul)]
    property Cd_Compvend : String read fCd_Compvend write fCd_Compvend;
    [Campo('CD_ESPECIE', tfNul)]
    property Cd_Especie : String read fCd_Especie write fCd_Especie;
    [Campo('CD_CST', tfNul)]
    property Cd_Cst : String read fCd_Cst write fCd_Cst;
    [Campo('IN_DESCONTO', tfNul)]
    property In_Desconto : String read fIn_Desconto write fIn_Desconto;
    [Campo('PR_DESCONTO', tfNul)]
    property Pr_Desconto : String read fPr_Desconto write fPr_Desconto;
    [Campo('DS_PRODUTO', tfNul)]
    property Ds_Produto : String read fDs_Produto write fDs_Produto;
    [Campo('CD_BARRAPRD', tfNul)]
    property Cd_Barraprd : String read fCd_Barraprd write fCd_Barraprd;
    [Campo('QT_SOLICITADA', tfNul)]
    property Qt_Solicitada : String read fQt_Solicitada write fQt_Solicitada;
    [Campo('QT_ATENDIDA', tfNul)]
    property Qt_Atendida : String read fQt_Atendida write fQt_Atendida;
    [Campo('QT_SALDO', tfNul)]
    property Qt_Saldo : String read fQt_Saldo write fQt_Saldo;
    [Campo('QT_ANTERIOR', tfNul)]
    property Qt_Anterior : String read fQt_Anterior write fQt_Anterior;
    [Campo('VL_TOTALBRUTO', tfNul)]
    property Vl_Totalbruto : String read fVl_Totalbruto write fVl_Totalbruto;
    [Campo('VL_TOTALLIQUIDO', tfNul)]
    property Vl_Totalliquido : String read fVl_Totalliquido write fVl_Totalliquido;
    [Campo('VL_TOTALDESC', tfNul)]
    property Vl_Totaldesc : String read fVl_Totaldesc write fVl_Totaldesc;
    [Campo('VL_TOTALDESCCAB', tfNul)]
    property Vl_Totaldesccab : String read fVl_Totaldesccab write fVl_Totaldesccab;
    [Campo('VL_UNITBRUTO', tfNul)]
    property Vl_Unitbruto : String read fVl_Unitbruto write fVl_Unitbruto;
    [Campo('VL_UNITLIQUIDO', tfNul)]
    property Vl_Unitliquido : String read fVl_Unitliquido write fVl_Unitliquido;
    [Campo('VL_UNITDESCCAB', tfNul)]
    property Vl_Unitdesccab : String read fVl_Unitdesccab write fVl_Unitdesccab;
    [Campo('VL_UNITDESC', tfNul)]
    property Vl_Unitdesc : String read fVl_Unitdesc write fVl_Unitdesc;
  end;

  TTra_Transitems = class(TList<Tra_Transitem>);

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

end.