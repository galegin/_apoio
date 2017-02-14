unit uTraTransItem;

interface

uses
  Classes, SysUtils,
  mCollection, mCollectionItem,
  uPrdProduto, uTraItemImposto;

type
  TTra_TransItem = class;
  TTra_TransItemClass = class of TTra_TransItem;

  TTra_TransItemList = class;
  TTra_TransItemListClass = class of TTra_TransItemList;

  TTra_TransItem = class(TmCollectionItem)
  private
    fCd_Empresa: Real;
    fNr_Transacao: Real;
    fDt_Transacao: TDateTime;
    fNr_Item: Real;
    fU_Version: String;
    fCd_Empfat: Real;
    fCd_Grupoempresa: Real;
    fCd_Operador: Real;
    fDt_Cadastro: TDateTime;
    fCd_Tipi: String;
    fCd_Cfop: Real;
    fCd_Produto: Real;
    fCd_Promocao: Real;
    fCd_Decreto: Real;
    fCd_Compvend: Real;
    fCd_Especie: String;
    fCd_Cst: String;
    fIn_Desconto: String;
    fPr_Desconto: Real;
    fDs_Produto: String;
    fCd_Barraprd: String;
    fQt_Solicitada: Real;
    fQt_Atendida: Real;
    fQt_Saldo: Real;
    fQt_Anterior: Real;
    fVl_Totalbruto: Real;
    fVl_Totalliquido: Real;
    fVl_Totaldesc: Real;
    fVl_Totaldesccab: Real;
    fVl_Unitbruto: Real;
    fVl_Unitliquido: Real;
    fVl_Unitdesccab: Real;
    fVl_Unitdesc: Real;

    fObj_Produto: TPrd_Produto;

    fLst_Imposto: TTra_ItemImpostoList;
  public
    constructor Create(Collection: TCollection); override;
    destructor Destroy; override;
  published
    property Cd_Empresa : Real read fCd_Empresa write fCd_Empresa;
    property Nr_Transacao : Real read fNr_Transacao write fNr_Transacao;
    property Dt_Transacao : TDateTime read fDt_Transacao write fDt_Transacao;
    property Nr_Item : Real read fNr_Item write fNr_Item;
    property U_Version : String read fU_Version write fU_Version;
    property Cd_Empfat : Real read fCd_Empfat write fCd_Empfat;
    property Cd_Grupoempresa : Real read fCd_Grupoempresa write fCd_Grupoempresa;
    property Cd_Operador : Real read fCd_Operador write fCd_Operador;
    property Dt_Cadastro : TDateTime read fDt_Cadastro write fDt_Cadastro;
    property Cd_Tipi : String read fCd_Tipi write fCd_Tipi;
    property Cd_Cfop : Real read fCd_Cfop write fCd_Cfop;
    property Cd_Produto : Real read fCd_Produto write fCd_Produto;
    property Cd_Promocao : Real read fCd_Promocao write fCd_Promocao;
    property Cd_Decreto : Real read fCd_Decreto write fCd_Decreto;
    property Cd_Compvend : Real read fCd_Compvend write fCd_Compvend;
    property Cd_Especie : String read fCd_Especie write fCd_Especie;
    property Cd_Cst : String read fCd_Cst write fCd_Cst;
    property In_Desconto : String read fIn_Desconto write fIn_Desconto;
    property Pr_Desconto : Real read fPr_Desconto write fPr_Desconto;
    property Ds_Produto : String read fDs_Produto write fDs_Produto;
    property Cd_Barraprd : String read fCd_Barraprd write fCd_Barraprd;
    property Qt_Solicitada : Real read fQt_Solicitada write fQt_Solicitada;
    property Qt_Atendida : Real read fQt_Atendida write fQt_Atendida;
    property Qt_Saldo : Real read fQt_Saldo write fQt_Saldo;
    property Qt_Anterior : Real read fQt_Anterior write fQt_Anterior;
    property Vl_Totalbruto : Real read fVl_Totalbruto write fVl_Totalbruto;
    property Vl_Totalliquido : Real read fVl_Totalliquido write fVl_Totalliquido;
    property Vl_Totaldesc : Real read fVl_Totaldesc write fVl_Totaldesc;
    property Vl_Totaldesccab : Real read fVl_Totaldesccab write fVl_Totaldesccab;
    property Vl_Unitbruto : Real read fVl_Unitbruto write fVl_Unitbruto;
    property Vl_Unitliquido : Real read fVl_Unitliquido write fVl_Unitliquido;
    property Vl_Unitdesccab : Real read fVl_Unitdesccab write fVl_Unitdesccab;
    property Vl_Unitdesc : Real read fVl_Unitdesc write fVl_Unitdesc;

    property Obj_Produto : TPrd_Produto read fObj_Produto write fObj_Produto;

    property Lst_Imposto : TTra_ItemImpostoList read fLst_Imposto write fLst_Imposto;
  end;

  TTra_TransItemList = class(TmCollection)
  private
    function GetItem(Index: Integer): TTra_TransItem;
    procedure SetItem(Index: Integer; Value: TTra_TransItem);
  public
    constructor Create(AOwner: TPersistent);
    function Add: TTra_TransItem;
    property Items[Index: Integer]: TTra_TransItem read GetItem write SetItem; default;
  end;

implementation

{ TTra_TransItem }

constructor TTra_TransItem.Create(Collection: TCollection);
begin
  inherited;
  Obj_Produto := TPrd_Produto.Create(nil);
  Lst_Imposto := TTra_ItemImpostoList.Create(Self);
end;

destructor TTra_TransItem.Destroy;
begin
  inherited;
end;

{ TTra_TransItemList }

constructor TTra_TransItemList.Create(AOwner: TPersistent);
begin
  inherited Create(TTra_TransItem);
end;

function TTra_TransItemList.Add: TTra_TransItem;
begin
  Result := TTra_TransItem(inherited Add);
  Result.create(Self);
end;

function TTra_TransItemList.GetItem(Index: Integer): TTra_TransItem;
begin
  Result := TTra_TransItem(inherited GetItem(Index));
end;

procedure TTra_TransItemList.SetItem(Index: Integer; Value: TTra_TransItem);
begin
  inherited SetItem(Index, Value);
end;

end.