unit uFcpDupdespesa;

interface

uses
  Classes, SysUtils,
  cCollection, cCollectionItem;

type
  TFcp_Dupdespesa = class;
  TFcp_DupdespesaClass = class of TFcp_Dupdespesa;

  TFcp_DupdespesaList = class;
  TFcp_DupdespesaListClass = class of TFcp_DupdespesaList;

  TFcp_Dupdespesa = class(TcCollectionItem)
  private
    fCd_Empresa: Real;
    fCd_Fornecedor: Real;
    fNr_Duplicata: Real;
    fNr_Parcela: Real;
    fCd_Despesaitem: Real;
    fCd_Ccusto: Real;
    fU_Version: String;
    fCd_Operador: Real;
    fDt_Cadastro: TDateTime;
    fTp_Custodespesa: String;
    fPr_Rateio: Real;
    fVl_Rateio: Real;
  public
    constructor Create; reintroduce;
    destructor Destroy; override;
  published
    property Cd_Empresa : Real read fCd_Empresa write fCd_Empresa;
    property Cd_Fornecedor : Real read fCd_Fornecedor write fCd_Fornecedor;
    property Nr_Duplicata : Real read fNr_Duplicata write fNr_Duplicata;
    property Nr_Parcela : Real read fNr_Parcela write fNr_Parcela;
    property Cd_Despesaitem : Real read fCd_Despesaitem write fCd_Despesaitem;
    property Cd_Ccusto : Real read fCd_Ccusto write fCd_Ccusto;
    property U_Version : String read fU_Version write fU_Version;
    property Cd_Operador : Real read fCd_Operador write fCd_Operador;
    property Dt_Cadastro : TDateTime read fDt_Cadastro write fDt_Cadastro;
    property Tp_Custodespesa : String read fTp_Custodespesa write fTp_Custodespesa;
    property Pr_Rateio : Real read fPr_Rateio write fPr_Rateio;
    property Vl_Rateio : Real read fVl_Rateio write fVl_Rateio;
  end;

  TFcp_DupdespesaList = class(TcCollection)
  private
    function GetItem(Index: Integer): TFcp_Dupdespesa;
    procedure SetItem(Index: Integer; Value: TFcp_Dupdespesa);
  public
    constructor Create(AOwner: TPersistent);
    function Add: TFcp_Dupdespesa;
    property Items[Index: Integer]: TFcp_Dupdespesa read GetItem write SetItem; default;
  end;
  
implementation

{ TFcp_Dupdespesa }

constructor TFcp_Dupdespesa.Create;
begin

end;

destructor TFcp_Dupdespesa.Destroy;
begin

  inherited;
end;

{ TFcp_DupdespesaList }

constructor TFcp_DupdespesaList.Create(AOwner: TPersistent);
begin
  inherited Create(TFcp_Dupdespesa);
end;

function TFcp_DupdespesaList.Add: TFcp_Dupdespesa;
begin
  Result := TFcp_Dupdespesa(inherited Add);
  Result.create;
end;

function TFcp_DupdespesaList.GetItem(Index: Integer): TFcp_Dupdespesa;
begin
  Result := TFcp_Dupdespesa(inherited GetItem(Index));
end;

procedure TFcp_DupdespesaList.SetItem(Index: Integer; Value: TFcp_Dupdespesa);
begin
  inherited SetItem(Index, Value);
end;

end.