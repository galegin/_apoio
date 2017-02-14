unit uFcpDespesaitem;

interface

uses
  Classes, SysUtils,
  cCollection, cCollectionItem;

type
  TFcp_Despesaitem = class;
  TFcp_DespesaitemClass = class of TFcp_Despesaitem;

  TFcp_DespesaitemList = class;
  TFcp_DespesaitemListClass = class of TFcp_DespesaitemList;

  TFcp_Despesaitem = class(TcCollectionItem)
  private
    fCd_Despesaitem: Real;
    fU_Version: String;
    fCd_Operador: Real;
    fDt_Cadastro: TDateTime;
    fDs_Despesaitem: String;
    fDs_Original: String;
    fPr_Rateio: Real;
    fTp_Custodespesa: Real;
    fTp_Fixovariavel: Real;
    fTp_Diretoindireto: Real;
    fCd_Fornecedor: Real;
    fIn_Padrao: String;
    fTp_Ccusto: Real;
    fIn_Bloqueada: String;
  public
    constructor Create; reintroduce;
    destructor Destroy; override;
  published
    property Cd_Despesaitem : Real read fCd_Despesaitem write fCd_Despesaitem;
    property U_Version : String read fU_Version write fU_Version;
    property Cd_Operador : Real read fCd_Operador write fCd_Operador;
    property Dt_Cadastro : TDateTime read fDt_Cadastro write fDt_Cadastro;
    property Ds_Despesaitem : String read fDs_Despesaitem write fDs_Despesaitem;
    property Ds_Original : String read fDs_Original write fDs_Original;
    property Pr_Rateio : Real read fPr_Rateio write fPr_Rateio;
    property Tp_Custodespesa : Real read fTp_Custodespesa write fTp_Custodespesa;
    property Tp_Fixovariavel : Real read fTp_Fixovariavel write fTp_Fixovariavel;
    property Tp_Diretoindireto : Real read fTp_Diretoindireto write fTp_Diretoindireto;
    property Cd_Fornecedor : Real read fCd_Fornecedor write fCd_Fornecedor;
    property In_Padrao : String read fIn_Padrao write fIn_Padrao;
    property Tp_Ccusto : Real read fTp_Ccusto write fTp_Ccusto;
    property In_Bloqueada : String read fIn_Bloqueada write fIn_Bloqueada;
  end;

  TFcp_DespesaitemList = class(TcCollection)
  private
    function GetItem(Index: Integer): TFcp_Despesaitem;
    procedure SetItem(Index: Integer; Value: TFcp_Despesaitem);
  public
    constructor Create(AOwner: TPersistent);
    function Add: TFcp_Despesaitem;
    property Items[Index: Integer]: TFcp_Despesaitem read GetItem write SetItem; default;
  end;
  
implementation

{ TFcp_Despesaitem }

constructor TFcp_Despesaitem.Create;
begin

end;

destructor TFcp_Despesaitem.Destroy;
begin

  inherited;
end;

{ TFcp_DespesaitemList }

constructor TFcp_DespesaitemList.Create(AOwner: TPersistent);
begin
  inherited Create(TFcp_Despesaitem);
end;

function TFcp_DespesaitemList.Add: TFcp_Despesaitem;
begin
  Result := TFcp_Despesaitem(inherited Add);
  Result.create;
end;

function TFcp_DespesaitemList.GetItem(Index: Integer): TFcp_Despesaitem;
begin
  Result := TFcp_Despesaitem(inherited GetItem(Index));
end;

procedure TFcp_DespesaitemList.SetItem(Index: Integer; Value: TFcp_Despesaitem);
begin
  inherited SetItem(Index, Value);
end;

end.