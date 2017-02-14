unit uFisNfitemprod;

interface

uses
  Classes, SysUtils,
  cCollection, cCollectionItem;

type
  TFis_Nfitemprod = class;
  TFis_NfitemprodClass = class of TFis_Nfitemprod;

  TFis_NfitemprodList = class;
  TFis_NfitemprodListClass = class of TFis_NfitemprodList;

  TFis_Nfitemprod = class(TcCollectionItem)
  private
    fCd_Empresa: Real;
    fNr_Fatura: Real;
    fDt_Fatura: TDateTime;
    fNr_Item: Real;
    fCd_Produto: Real;
    fU_Version: String;
    fCd_Empfat: Real;
    fCd_Grupoempresa: Real;
    fCd_Operador: Real;
    fDt_Cadastro: TDateTime;
    fCd_Promocao: Real;
    fCd_Compvend: Real;
    fQt_Faturado: Real;
    fVl_Unitbruto: Real;
    fVl_Unitdesc: Real;
    fVl_Unitliquido: Real;
    fVl_Totalbruto: Real;
    fVl_Totaldesc: Real;
    fVl_Totalliquido: Real;
  public
    constructor Create; reintroduce;
    destructor Destroy; override;
  published
    property Cd_Empresa : Real read fCd_Empresa write fCd_Empresa;
    property Nr_Fatura : Real read fNr_Fatura write fNr_Fatura;
    property Dt_Fatura : TDateTime read fDt_Fatura write fDt_Fatura;
    property Nr_Item : Real read fNr_Item write fNr_Item;
    property Cd_Produto : Real read fCd_Produto write fCd_Produto;
    property U_Version : String read fU_Version write fU_Version;
    property Cd_Empfat : Real read fCd_Empfat write fCd_Empfat;
    property Cd_Grupoempresa : Real read fCd_Grupoempresa write fCd_Grupoempresa;
    property Cd_Operador : Real read fCd_Operador write fCd_Operador;
    property Dt_Cadastro : TDateTime read fDt_Cadastro write fDt_Cadastro;
    property Cd_Promocao : Real read fCd_Promocao write fCd_Promocao;
    property Cd_Compvend : Real read fCd_Compvend write fCd_Compvend;
    property Qt_Faturado : Real read fQt_Faturado write fQt_Faturado;
    property Vl_Unitbruto : Real read fVl_Unitbruto write fVl_Unitbruto;
    property Vl_Unitdesc : Real read fVl_Unitdesc write fVl_Unitdesc;
    property Vl_Unitliquido : Real read fVl_Unitliquido write fVl_Unitliquido;
    property Vl_Totalbruto : Real read fVl_Totalbruto write fVl_Totalbruto;
    property Vl_Totaldesc : Real read fVl_Totaldesc write fVl_Totaldesc;
    property Vl_Totalliquido : Real read fVl_Totalliquido write fVl_Totalliquido;
  end;

  TFis_NfitemprodList = class(TcCollection)
  private
    function GetItem(Index: Integer): TFis_Nfitemprod;
    procedure SetItem(Index: Integer; Value: TFis_Nfitemprod);
  public
    constructor Create(AOwner: TPersistent);
    function Add: TFis_Nfitemprod;
    property Items[Index: Integer]: TFis_Nfitemprod read GetItem write SetItem; default;
  end;
  
implementation

{ TFis_Nfitemprod }

constructor TFis_Nfitemprod.Create;
begin

end;

destructor TFis_Nfitemprod.Destroy;
begin

  inherited;
end;

{ TFis_NfitemprodList }

constructor TFis_NfitemprodList.Create(AOwner: TPersistent);
begin
  inherited Create(TFis_Nfitemprod);
end;

function TFis_NfitemprodList.Add: TFis_Nfitemprod;
begin
  Result := TFis_Nfitemprod(inherited Add);
  Result.create;
end;

function TFis_NfitemprodList.GetItem(Index: Integer): TFis_Nfitemprod;
begin
  Result := TFis_Nfitemprod(inherited GetItem(Index));
end;

procedure TFis_NfitemprodList.SetItem(Index: Integer; Value: TFis_Nfitemprod);
begin
  inherited SetItem(Index, Value);
end;

end.