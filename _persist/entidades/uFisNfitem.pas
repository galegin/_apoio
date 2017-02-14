unit uFisNfitem;

interface

uses
  Classes, SysUtils,
  cCollection, cCollectionItem;

type
  TFis_Nfitem = class;
  TFis_NfitemClass = class of TFis_Nfitem;

  TFis_NfitemList = class;
  TFis_NfitemListClass = class of TFis_NfitemList;

  TFis_Nfitem = class(TcCollectionItem)
  private
    fCd_Empresa: Real;
    fNr_Fatura: Real;
    fDt_Fatura: TDateTime;
    fNr_Item: Real;
    fU_Version: String;
    fCd_Empfat: Real;
    fCd_Grupoempresa: Real;
    fCd_Operador: Real;
    fDt_Cadastro: TDateTime;
    fCd_Tipi: String;
    fCd_Cfop: Real;
    fCd_Produto: String;
    fCd_Decreto: Real;
    fCd_Especie: String;
    fCd_Cst: String;
    fIn_Desconto: String;
    fPr_Desconto: Real;
    fDs_Produto: String;
    fQt_Faturado: Real;
    fVl_Totalbruto: Real;
    fVl_Totaldesc: Real;
    fVl_Totalliquido: Real;
    fVl_Unitbruto: Real;
    fVl_Unitdesc: Real;
    fVl_Unitliquido: Real;
    fVl_Despacessor: Real;
    fVl_Frete: Real;
    fVl_Seguro: Real;
  public
    constructor Create; reintroduce;
    destructor Destroy; override;
  published
    property Cd_Empresa : Real read fCd_Empresa write fCd_Empresa;
    property Nr_Fatura : Real read fNr_Fatura write fNr_Fatura;
    property Dt_Fatura : TDateTime read fDt_Fatura write fDt_Fatura;
    property Nr_Item : Real read fNr_Item write fNr_Item;
    property U_Version : String read fU_Version write fU_Version;
    property Cd_Empfat : Real read fCd_Empfat write fCd_Empfat;
    property Cd_Grupoempresa : Real read fCd_Grupoempresa write fCd_Grupoempresa;
    property Cd_Operador : Real read fCd_Operador write fCd_Operador;
    property Dt_Cadastro : TDateTime read fDt_Cadastro write fDt_Cadastro;
    property Cd_Tipi : String read fCd_Tipi write fCd_Tipi;
    property Cd_Cfop : Real read fCd_Cfop write fCd_Cfop;
    property Cd_Produto : String read fCd_Produto write fCd_Produto;
    property Cd_Decreto : Real read fCd_Decreto write fCd_Decreto;
    property Cd_Especie : String read fCd_Especie write fCd_Especie;
    property Cd_Cst : String read fCd_Cst write fCd_Cst;
    property In_Desconto : String read fIn_Desconto write fIn_Desconto;
    property Pr_Desconto : Real read fPr_Desconto write fPr_Desconto;
    property Ds_Produto : String read fDs_Produto write fDs_Produto;
    property Qt_Faturado : Real read fQt_Faturado write fQt_Faturado;
    property Vl_Totalbruto : Real read fVl_Totalbruto write fVl_Totalbruto;
    property Vl_Totaldesc : Real read fVl_Totaldesc write fVl_Totaldesc;
    property Vl_Totalliquido : Real read fVl_Totalliquido write fVl_Totalliquido;
    property Vl_Unitbruto : Real read fVl_Unitbruto write fVl_Unitbruto;
    property Vl_Unitdesc : Real read fVl_Unitdesc write fVl_Unitdesc;
    property Vl_Unitliquido : Real read fVl_Unitliquido write fVl_Unitliquido;
    property Vl_Despacessor : Real read fVl_Despacessor write fVl_Despacessor;
    property Vl_Frete : Real read fVl_Frete write fVl_Frete;
    property Vl_Seguro : Real read fVl_Seguro write fVl_Seguro;
  end;

  TFis_NfitemList = class(TcCollection)
  private
    function GetItem(Index: Integer): TFis_Nfitem;
    procedure SetItem(Index: Integer; Value: TFis_Nfitem);
  public
    constructor Create(AOwner: TPersistent);
    function Add: TFis_Nfitem;
    property Items[Index: Integer]: TFis_Nfitem read GetItem write SetItem; default;
  end;
  
implementation

{ TFis_Nfitem }

constructor TFis_Nfitem.Create;
begin

end;

destructor TFis_Nfitem.Destroy;
begin

  inherited;
end;

{ TFis_NfitemList }

constructor TFis_NfitemList.Create(AOwner: TPersistent);
begin
  inherited Create(TFis_Nfitem);
end;

function TFis_NfitemList.Add: TFis_Nfitem;
begin
  Result := TFis_Nfitem(inherited Add);
  Result.create;
end;

function TFis_NfitemList.GetItem(Index: Integer): TFis_Nfitem;
begin
  Result := TFis_Nfitem(inherited GetItem(Index));
end;

procedure TFis_NfitemList.SetItem(Index: Integer; Value: TFis_Nfitem);
begin
  inherited SetItem(Index, Value);
end;

end.