unit uFcrFatcartao;

interface

uses
  Classes, SysUtils,
  cCollection, cCollectionItem;

type
  TFcr_Fatcartao = class;
  TFcr_FatcartaoClass = class of TFcr_Fatcartao;

  TFcr_FatcartaoList = class;
  TFcr_FatcartaoListClass = class of TFcr_FatcartaoList;

  TFcr_Fatcartao = class(TcCollectionItem)
  private
    fCd_Empresa: Real;
    fCd_Cliente: Real;
    fNr_Fat: Real;
    fNr_Parcela: Real;
    fU_Version: String;
    fCd_Operador: Real;
    fDt_Cadastro: TDateTime;
    fTp_Cartao: Real;
    fCd_Cartao: Real;
    fNr_Seqcartao: Real;
    fCd_Autorizacao: Real;
    fNr_Nsu: Real;
    fDt_Compra: TDateTime;
    fVl_Compra: Real;
    fNr_Parcelas: Real;
    fNr_Nf: Real;
    fCd_Empori: Real;
    fCd_Cliori: Real;
    fNr_Fatori: Real;
    fNr_Parori: Real;
    fPr_Taxaadm: Real;
    fNr_Rv: Real;
    fDt_Rv: TDateTime;
    fNr_Pv: Real;
    fTp_Regooper: Real;
    fDt_Credito: TDateTime;
  public
    constructor Create; reintroduce;
    destructor Destroy; override;
  published
    property Cd_Empresa : Real read fCd_Empresa write fCd_Empresa;
    property Cd_Cliente : Real read fCd_Cliente write fCd_Cliente;
    property Nr_Fat : Real read fNr_Fat write fNr_Fat;
    property Nr_Parcela : Real read fNr_Parcela write fNr_Parcela;
    property U_Version : String read fU_Version write fU_Version;
    property Cd_Operador : Real read fCd_Operador write fCd_Operador;
    property Dt_Cadastro : TDateTime read fDt_Cadastro write fDt_Cadastro;
    property Tp_Cartao : Real read fTp_Cartao write fTp_Cartao;
    property Cd_Cartao : Real read fCd_Cartao write fCd_Cartao;
    property Nr_Seqcartao : Real read fNr_Seqcartao write fNr_Seqcartao;
    property Cd_Autorizacao : Real read fCd_Autorizacao write fCd_Autorizacao;
    property Nr_Nsu : Real read fNr_Nsu write fNr_Nsu;
    property Dt_Compra : TDateTime read fDt_Compra write fDt_Compra;
    property Vl_Compra : Real read fVl_Compra write fVl_Compra;
    property Nr_Parcelas : Real read fNr_Parcelas write fNr_Parcelas;
    property Nr_Nf : Real read fNr_Nf write fNr_Nf;
    property Cd_Empori : Real read fCd_Empori write fCd_Empori;
    property Cd_Cliori : Real read fCd_Cliori write fCd_Cliori;
    property Nr_Fatori : Real read fNr_Fatori write fNr_Fatori;
    property Nr_Parori : Real read fNr_Parori write fNr_Parori;
    property Pr_Taxaadm : Real read fPr_Taxaadm write fPr_Taxaadm;
    property Nr_Rv : Real read fNr_Rv write fNr_Rv;
    property Dt_Rv : TDateTime read fDt_Rv write fDt_Rv;
    property Nr_Pv : Real read fNr_Pv write fNr_Pv;
    property Tp_Regooper : Real read fTp_Regooper write fTp_Regooper;
    property Dt_Credito : TDateTime read fDt_Credito write fDt_Credito;
  end;

  TFcr_FatcartaoList = class(TcCollection)
  private
    function GetItem(Index: Integer): TFcr_Fatcartao;
    procedure SetItem(Index: Integer; Value: TFcr_Fatcartao);
  public
    constructor Create(AOwner: TPersistent);
    function Add: TFcr_Fatcartao;
    property Items[Index: Integer]: TFcr_Fatcartao read GetItem write SetItem; default;
  end;
  
implementation

{ TFcr_Fatcartao }

constructor TFcr_Fatcartao.Create;
begin

end;

destructor TFcr_Fatcartao.Destroy;
begin

  inherited;
end;

{ TFcr_FatcartaoList }

constructor TFcr_FatcartaoList.Create(AOwner: TPersistent);
begin
  inherited Create(TFcr_Fatcartao);
end;

function TFcr_FatcartaoList.Add: TFcr_Fatcartao;
begin
  Result := TFcr_Fatcartao(inherited Add);
  Result.create;
end;

function TFcr_FatcartaoList.GetItem(Index: Integer): TFcr_Fatcartao;
begin
  Result := TFcr_Fatcartao(inherited GetItem(Index));
end;

procedure TFcr_FatcartaoList.SetItem(Index: Integer; Value: TFcr_Fatcartao);
begin
  inherited SetItem(Index, Value);
end;

end.