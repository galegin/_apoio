unit uFisNfitemimpost;

interface

uses
  Classes, SysUtils,
  cCollection, cCollectionItem;

type
  TFis_Nfitemimpost = class;
  TFis_NfitemimpostClass = class of TFis_Nfitemimpost;

  TFis_NfitemimpostList = class;
  TFis_NfitemimpostListClass = class of TFis_NfitemimpostList;

  TFis_Nfitemimpost = class(TcCollectionItem)
  private
    fCd_Empresa: Real;
    fNr_Fatura: Real;
    fDt_Fatura: TDateTime;
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
    fCd_Produto: Real;
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
    property Nr_Fatura : Real read fNr_Fatura write fNr_Fatura;
    property Dt_Fatura : TDateTime read fDt_Fatura write fDt_Fatura;
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
    property Cd_Produto : Real read fCd_Produto write fCd_Produto;
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

  TFis_NfitemimpostList = class(TcCollection)
  private
    function GetItem(Index: Integer): TFis_Nfitemimpost;
    procedure SetItem(Index: Integer; Value: TFis_Nfitemimpost);
  public
    constructor Create(AOwner: TPersistent);
    function Add: TFis_Nfitemimpost;
    property Items[Index: Integer]: TFis_Nfitemimpost read GetItem write SetItem; default;
  end;
  
implementation

{ TFis_Nfitemimpost }

constructor TFis_Nfitemimpost.Create;
begin

end;

destructor TFis_Nfitemimpost.Destroy;
begin

  inherited;
end;

{ TFis_NfitemimpostList }

constructor TFis_NfitemimpostList.Create(AOwner: TPersistent);
begin
  inherited Create(TFis_Nfitemimpost);
end;

function TFis_NfitemimpostList.Add: TFis_Nfitemimpost;
begin
  Result := TFis_Nfitemimpost(inherited Add);
  Result.create;
end;

function TFis_NfitemimpostList.GetItem(Index: Integer): TFis_Nfitemimpost;
begin
  Result := TFis_Nfitemimpost(inherited GetItem(Index));
end;

procedure TFis_NfitemimpostList.SetItem(Index: Integer; Value: TFis_Nfitemimpost);
begin
  inherited SetItem(Index, Value);
end;

end.