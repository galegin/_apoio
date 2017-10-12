unit uTraTransitem;

interface

uses
  Classes, SysUtils,
  mCollection, mCollectionItem;

type
  TTra_Transitem = class;
  TTra_TransitemClass = class of TTra_Transitem;

  TTra_TransitemList = class;
  TTra_TransitemListClass = class of TTra_TransitemList;

  TTra_Transitem = class(TmCollectionItem)
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
    constructor Create(ACollection: TCollection); override;
    destructor Destroy; override;
  published
    property Cd_Empresa : String read fCd_Empresa write SetCd_Empresa;
    property Nr_Transacao : String read fNr_Transacao write SetNr_Transacao;
    property Dt_Transacao : String read fDt_Transacao write SetDt_Transacao;
    property Nr_Item : String read fNr_Item write SetNr_Item;
    property U_Version : String read fU_Version write SetU_Version;
    property Cd_Empfat : String read fCd_Empfat write SetCd_Empfat;
    property Cd_Grupoempresa : String read fCd_Grupoempresa write SetCd_Grupoempresa;
    property Cd_Operador : String read fCd_Operador write SetCd_Operador;
    property Dt_Cadastro : String read fDt_Cadastro write SetDt_Cadastro;
    property Cd_Tipi : String read fCd_Tipi write SetCd_Tipi;
    property Cd_Cfop : String read fCd_Cfop write SetCd_Cfop;
    property Cd_Produto : String read fCd_Produto write SetCd_Produto;
    property Cd_Promocao : String read fCd_Promocao write SetCd_Promocao;
    property Cd_Decreto : String read fCd_Decreto write SetCd_Decreto;
    property Cd_Compvend : String read fCd_Compvend write SetCd_Compvend;
    property Cd_Especie : String read fCd_Especie write SetCd_Especie;
    property Cd_Cst : String read fCd_Cst write SetCd_Cst;
    property In_Desconto : String read fIn_Desconto write SetIn_Desconto;
    property Pr_Desconto : String read fPr_Desconto write SetPr_Desconto;
    property Ds_Produto : String read fDs_Produto write SetDs_Produto;
    property Cd_Barraprd : String read fCd_Barraprd write SetCd_Barraprd;
    property Qt_Solicitada : String read fQt_Solicitada write SetQt_Solicitada;
    property Qt_Atendida : String read fQt_Atendida write SetQt_Atendida;
    property Qt_Saldo : String read fQt_Saldo write SetQt_Saldo;
    property Qt_Anterior : String read fQt_Anterior write SetQt_Anterior;
    property Vl_Totalbruto : String read fVl_Totalbruto write SetVl_Totalbruto;
    property Vl_Totalliquido : String read fVl_Totalliquido write SetVl_Totalliquido;
    property Vl_Totaldesc : String read fVl_Totaldesc write SetVl_Totaldesc;
    property Vl_Totaldesccab : String read fVl_Totaldesccab write SetVl_Totaldesccab;
    property Vl_Unitbruto : String read fVl_Unitbruto write SetVl_Unitbruto;
    property Vl_Unitliquido : String read fVl_Unitliquido write SetVl_Unitliquido;
    property Vl_Unitdesccab : String read fVl_Unitdesccab write SetVl_Unitdesccab;
    property Vl_Unitdesc : String read fVl_Unitdesc write SetVl_Unitdesc;
  end;

  TTra_TransitemList = class(TmCollection)
  private
    function GetItem(Index: Integer): TTra_Transitem;
    procedure SetItem(Index: Integer; Value: TTra_Transitem);
  public
    constructor Create(AOwner: TPersistentCollection);
    function Add: TTra_Transitem;
    property Items[Index: Integer]: TTra_Transitem read GetItem write SetItem; default;
  end;

implementation

{ TTra_Transitem }

constructor TTra_Transitem.Create(ACollection: TCollection);
begin
  inherited;

end;

destructor TTra_Transitem.Destroy;
begin

  inherited;
end;

{ TTra_TransitemList }

constructor TTra_TransitemList.Create(AOwner: TPersistentCollection);
begin
  inherited Create(TTra_Transitem);
end;

function TTra_TransitemList.Add: TTra_Transitem;
begin
  Result := TTra_Transitem(inherited Add);
  Result.create;
end;

function TTra_TransitemList.GetItem(Index: Integer): TTra_Transitem;
begin
  Result := TTra_Transitem(inherited GetItem(Index));
end;

procedure TTra_TransitemList.SetItem(Index: Integer; Value: TTra_Transitem);
begin
  inherited SetItem(Index, Value);
end;

end.