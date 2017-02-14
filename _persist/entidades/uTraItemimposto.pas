unit uTraItemimposto;

interface

uses
  Classes, SysUtils,
  cCollection, cCollectionItem;

type
  TTra_Itemimposto = class;
  TTra_ItemimpostoClass = class of TTra_Itemimposto;

  TTra_ItemimpostoList = class;
  TTra_ItemimpostoListClass = class of TTra_ItemimpostoList;

  TTra_Itemimposto = class(TcCollectionItem)
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
    constructor Create; reintroduce;
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

  TTra_ItemimpostoList = class(TcCollection)
  private
    function GetItem(Index: Integer): TTra_Itemimposto;
    procedure SetItem(Index: Integer; Value: TTra_Itemimposto);
  public
    constructor Create(AOwner: TPersistent);
    function Add: TTra_Itemimposto;
    property Items[Index: Integer]: TTra_Itemimposto read GetItem write SetItem; default;
  end;
  
implementation

{ TTra_Itemimposto }

constructor TTra_Itemimposto.Create;
begin

end;

destructor TTra_Itemimposto.Destroy;
begin

  inherited;
end;

{ TTra_ItemimpostoList }

constructor TTra_ItemimpostoList.Create(AOwner: TPersistent);
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