unit uFisNfitemdesp;

interface

uses
  Classes, SysUtils,
  cCollection, cCollectionItem;

type
  TFis_Nfitemdesp = class;
  TFis_NfitemdespClass = class of TFis_Nfitemdesp;

  TFis_NfitemdespList = class;
  TFis_NfitemdespListClass = class of TFis_NfitemdespList;

  TFis_Nfitemdesp = class(TcCollectionItem)
  private
    fCd_Empresa: Real;
    fNr_Fatura: Real;
    fDt_Fatura: TDateTime;
    fNr_Item: Real;
    fCd_Produto: Real;
    fCd_Despesaitem: Real;
    fCd_Ccusto: Real;
    fU_Version: String;
    fDt_Cadastro: TDateTime;
    fCd_Operador: Real;
    fTp_Custodespesa: String;
    fPr_Rateio: Real;
    fVl_Rateio: Real;
  public
    constructor Create; reintroduce;
    destructor Destroy; override;
  published
    property Cd_Empresa : Real read fCd_Empresa write fCd_Empresa;
    property Nr_Fatura : Real read fNr_Fatura write fNr_Fatura;
    property Dt_Fatura : TDateTime read fDt_Fatura write fDt_Fatura;
    property Nr_Item : Real read fNr_Item write fNr_Item;
    property Cd_Produto : Real read fCd_Produto write fCd_Produto;
    property Cd_Despesaitem : Real read fCd_Despesaitem write fCd_Despesaitem;
    property Cd_Ccusto : Real read fCd_Ccusto write fCd_Ccusto;
    property U_Version : String read fU_Version write fU_Version;
    property Dt_Cadastro : TDateTime read fDt_Cadastro write fDt_Cadastro;
    property Cd_Operador : Real read fCd_Operador write fCd_Operador;
    property Tp_Custodespesa : String read fTp_Custodespesa write fTp_Custodespesa;
    property Pr_Rateio : Real read fPr_Rateio write fPr_Rateio;
    property Vl_Rateio : Real read fVl_Rateio write fVl_Rateio;
  end;

  TFis_NfitemdespList = class(TcCollection)
  private
    function GetItem(Index: Integer): TFis_Nfitemdesp;
    procedure SetItem(Index: Integer; Value: TFis_Nfitemdesp);
  public
    constructor Create(AOwner: TPersistent);
    function Add: TFis_Nfitemdesp;
    property Items[Index: Integer]: TFis_Nfitemdesp read GetItem write SetItem; default;
  end;
  
implementation

{ TFis_Nfitemdesp }

constructor TFis_Nfitemdesp.Create;
begin

end;

destructor TFis_Nfitemdesp.Destroy;
begin

  inherited;
end;

{ TFis_NfitemdespList }

constructor TFis_NfitemdespList.Create(AOwner: TPersistent);
begin
  inherited Create(TFis_Nfitemdesp);
end;

function TFis_NfitemdespList.Add: TFis_Nfitemdesp;
begin
  Result := TFis_Nfitemdesp(inherited Add);
  Result.create;
end;

function TFis_NfitemdespList.GetItem(Index: Integer): TFis_Nfitemdesp;
begin
  Result := TFis_Nfitemdesp(inherited GetItem(Index));
end;

procedure TFis_NfitemdespList.SetItem(Index: Integer; Value: TFis_Nfitemdesp);
begin
  inherited SetItem(Index, Value);
end;

end.