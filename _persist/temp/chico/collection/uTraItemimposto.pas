unit uTraItemimposto;

interface

uses
  Classes, SysUtils,
  mCollection, mCollectionItem;

type
  TTra_Itemimposto = class;
  TTra_ItemimpostoClass = class of TTra_Itemimposto;

  TTra_ItemimpostoList = class;
  TTra_ItemimpostoListClass = class of TTra_ItemimpostoList;

  TTra_Itemimposto = class(TmCollectionItem)
  private
    fCd_Empresa: String;
    fNr_Transacao: String;
    fDt_Transacao: String;
    fNr_Item: String;
    fCd_Imposto: String;
    fU_Version: String;
    fCd_Empfat: String;
    fCd_Grupoempresa: String;
    fCd_Operador: String;
    fDt_Cadastro: String;
    fPr_Aliquota: String;
    fPr_Basecalc: String;
    fPr_Redubase: String;
    fVl_Basecalc: String;
    fVl_Isento: String;
    fVl_Outro: String;
    fVl_Imposto: String;
    fCd_Cst: String;
    fVl_Basecalcc: String;
    fVl_Isentoc: String;
    fVl_Outroc: String;
    fVl_Impostoc: String;
  public
    constructor Create(ACollection: TCollection); override;
    destructor Destroy; override;
  published
    property Cd_Empresa : String read fCd_Empresa write SetCd_Empresa;
    property Nr_Transacao : String read fNr_Transacao write SetNr_Transacao;
    property Dt_Transacao : String read fDt_Transacao write SetDt_Transacao;
    property Nr_Item : String read fNr_Item write SetNr_Item;
    property Cd_Imposto : String read fCd_Imposto write SetCd_Imposto;
    property U_Version : String read fU_Version write SetU_Version;
    property Cd_Empfat : String read fCd_Empfat write SetCd_Empfat;
    property Cd_Grupoempresa : String read fCd_Grupoempresa write SetCd_Grupoempresa;
    property Cd_Operador : String read fCd_Operador write SetCd_Operador;
    property Dt_Cadastro : String read fDt_Cadastro write SetDt_Cadastro;
    property Pr_Aliquota : String read fPr_Aliquota write SetPr_Aliquota;
    property Pr_Basecalc : String read fPr_Basecalc write SetPr_Basecalc;
    property Pr_Redubase : String read fPr_Redubase write SetPr_Redubase;
    property Vl_Basecalc : String read fVl_Basecalc write SetVl_Basecalc;
    property Vl_Isento : String read fVl_Isento write SetVl_Isento;
    property Vl_Outro : String read fVl_Outro write SetVl_Outro;
    property Vl_Imposto : String read fVl_Imposto write SetVl_Imposto;
    property Cd_Cst : String read fCd_Cst write SetCd_Cst;
    property Vl_Basecalcc : String read fVl_Basecalcc write SetVl_Basecalcc;
    property Vl_Isentoc : String read fVl_Isentoc write SetVl_Isentoc;
    property Vl_Outroc : String read fVl_Outroc write SetVl_Outroc;
    property Vl_Impostoc : String read fVl_Impostoc write SetVl_Impostoc;
  end;

  TTra_ItemimpostoList = class(TmCollection)
  private
    function GetItem(Index: Integer): TTra_Itemimposto;
    procedure SetItem(Index: Integer; Value: TTra_Itemimposto);
  public
    constructor Create(AOwner: TPersistentCollection);
    function Add: TTra_Itemimposto;
    property Items[Index: Integer]: TTra_Itemimposto read GetItem write SetItem; default;
  end;

implementation

{ TTra_Itemimposto }

constructor TTra_Itemimposto.Create(ACollection: TCollection);
begin
  inherited;

end;

destructor TTra_Itemimposto.Destroy;
begin

  inherited;
end;

{ TTra_ItemimpostoList }

constructor TTra_ItemimpostoList.Create(AOwner: TPersistentCollection);
begin
  inherited Create(TTra_Itemimposto);
end;

function TTra_ItemimpostoList.Add: TTra_Itemimposto;
begin
  Result := TTra_Itemimposto(inherited Add);
  Result.create;
end;

function TTra_ItemimpostoList.GetItem(Index: Integer): TTra_Itemimposto;
begin
  Result := TTra_Itemimposto(inherited GetItem(Index));
end;

procedure TTra_ItemimpostoList.SetItem(Index: Integer; Value: TTra_Itemimposto);
begin
  inherited SetItem(Index, Value);
end;

end.