unit uTraItemImposto;

interface

uses
  Classes, SysUtils,
  mCollection, mCollectionItem;

type
  TTra_ItemImposto = class;
  TTra_ItemImpostoClass = class of TTra_ItemImposto;

  TTra_ItemImpostoList = class;
  TTra_ItemImpostoListClass = class of TTra_ItemImpostoList;

  TTra_ItemImposto = class(TmCollectionItem)
  private
    fCd_Empresa: Real;
    fNr_Transacao: Real;
    fDt_Transacao: TDateTime;
    fNr_Item: Real;
    fCd_Imposto: Real;
    fU_Version: String;
    fCd_Empfat: Real;
    fCd_Grupoempresa: Real;
    fCd_Operador: Real;
    fDt_Cadastro: TDateTime;
    fPr_Aliquota: Real;
    fPr_Basecalc: Real;
    fPr_Redubase: Real;
    fVl_Basecalc: Real;
    fVl_Isento: Real;
    fVl_Outro: Real;
    fVl_Imposto: Real;
    fCd_Cst: String;
    fVl_Basecalcc: Real;
    fVl_Isentoc: Real;
    fVl_Outroc: Real;
    fVl_Impostoc: Real;
  public
    constructor Create(Collection: TCollection); override;
    destructor Destroy; override;
  published
    property Cd_Empresa : Real read fCd_Empresa write fCd_Empresa;
    property Nr_Transacao : Real read fNr_Transacao write fNr_Transacao;
    property Dt_Transacao : TDateTime read fDt_Transacao write fDt_Transacao;
    property Nr_Item : Real read fNr_Item write fNr_Item;
    property Cd_Imposto : Real read fCd_Imposto write fCd_Imposto;
    property U_Version : String read fU_Version write fU_Version;
    property Cd_Empfat : Real read fCd_Empfat write fCd_Empfat;
    property Cd_Grupoempresa : Real read fCd_Grupoempresa write fCd_Grupoempresa;
    property Cd_Operador : Real read fCd_Operador write fCd_Operador;
    property Dt_Cadastro : TDateTime read fDt_Cadastro write fDt_Cadastro;
    property Pr_Aliquota : Real read fPr_Aliquota write fPr_Aliquota;
    property Pr_Basecalc : Real read fPr_Basecalc write fPr_Basecalc;
    property Pr_Redubase : Real read fPr_Redubase write fPr_Redubase;
    property Vl_Basecalc : Real read fVl_Basecalc write fVl_Basecalc;
    property Vl_Isento : Real read fVl_Isento write fVl_Isento;
    property Vl_Outro : Real read fVl_Outro write fVl_Outro;
    property Vl_Imposto : Real read fVl_Imposto write fVl_Imposto;
    property Cd_Cst : String read fCd_Cst write fCd_Cst;
    property Vl_Basecalcc : Real read fVl_Basecalcc write fVl_Basecalcc;
    property Vl_Isentoc : Real read fVl_Isentoc write fVl_Isentoc;
    property Vl_Outroc : Real read fVl_Outroc write fVl_Outroc;
    property Vl_Impostoc : Real read fVl_Impostoc write fVl_Impostoc;
  end;

  TTra_ItemImpostoList = class(TmCollection)
  private
    function GetItem(Index: Integer): TTra_ItemImposto;
    procedure SetItem(Index: Integer; Value: TTra_ItemImposto);
  public
    constructor Create(AOwner: TPersistent);
    function Add: TTra_ItemImposto;
    property Items[Index: Integer]: TTra_ItemImposto read GetItem write SetItem; default;
  end;

implementation

{ TTra_ItemImposto }

constructor TTra_ItemImposto.Create(Collection: TCollection);
begin
  inherited;
end;

destructor TTra_ItemImposto.Destroy;
begin
  inherited;
end;

{ TList_Tra_ItemImposto }

constructor TTra_ItemImpostoList.Create(AOwner: TPersistent);
begin
  inherited Create(TTra_ItemImposto);
end;

function TTra_ItemImpostoList.Add: TTra_ItemImposto;
begin
  Result := TTra_ItemImposto(inherited Add);
  Result.create(Self);
end;

function TTra_ItemImpostoList.GetItem(
  Index: Integer): TTra_ItemImposto;
begin
  Result := TTra_ItemImposto(inherited GetItem(Index));
end;

procedure TTra_ItemImpostoList.SetItem(Index: Integer;
  Value: TTra_ItemImposto);
begin
  inherited SetItem(Index, Value);
end;

end.
