unit uFcrFaturai;

interface

uses
  Classes, SysUtils,
  cCollection, cCollectionItem;

type
  TFcr_Faturai = class;
  TFcr_FaturaiClass = class of TFcr_Faturai;

  TFcr_FaturaiList = class;
  TFcr_FaturaiListClass = class of TFcr_FaturaiList;

  TFcr_Faturai = class(TcCollectionItem)
  private
    fCd_Empresa: Real;
    fCd_Cliente: Real;
    fNr_Fat: Real;
    fNr_Parcela: Real;
    fU_Version: String;
    fCd_Operador: Real;
    fDt_Cadastro: TDateTime;
    fTp_Situacao: Real;
    fTp_Documento: Real;
    fTp_Faturamento: Real;
    fTp_Cobranca: Real;
    fTp_Inclusao: Real;
    fTp_Baixa: Real;
    fCd_Motivoprorr: Real;
    fCd_Motivojurdesc: Real;
    fCd_Moeda: Real;
    fNr_Parcelaorigem: Real;
    fNr_Comissaopaga: Real;
    fNr_Portador: Real;
    fCd_Operbaixa: Real;
    fCd_Opercancel: Real;
    fCd_Operalteracao: Real;
    fCd_Operimpfat: Real;
    fDt_Emissao: TDateTime;
    fDt_Alteracao: TDateTime;
    fDt_Cancelamento: TDateTime;
    fDt_Vencimento: TDateTime;
    fDt_Venctoorigem: TDateTime;
    fDt_Impfat: TDateTime;
    fCd_Empliq: Real;
    fDt_Liq: TDateTime;
    fNr_Seqliq: Real;
    fNr_Documento: Real;
    fVl_Fatura: Real;
    fVl_Original: Real;
    fVl_Pago: Real;
    fVl_Juros: Real;
    fVl_Desconto: Real;
    fVl_Outacres: Real;
    fVl_Outdesc: Real;
    fVl_Abatimento: Real;
    fVl_Despfin: Real;
    fVl_Imposto: Real;
    fVl_Liquido: Real;
    fVl_Acrescimo: Real;
    fNr_Nossonumero: Real;
    fDs_Dacnossonr: String;
    fPr_Descpgprazo: Real;
    fPr_Juromes: Real;
    fPr_Multa: Real;
    fPr_Descantecip1: Real;
    fPr_Descantecip2: Real;
    fDt_Descantecip1: TDateTime;
    fDt_Descantecip2: TDateTime;
    fIn_Aceite: String;
    fNr_Carenciaatraso: Real;
    fNr_Carenciamulta: Real;
    fNr_Descpont: Real;
    fCd_Componente: String;
    fCd_Opercad: Real;
    fDt_Opercad: TDateTime;
    fCd_Emplocal: Real;
    fDt_Devchq1: TDateTime;
    fDt_Devchq2: TDateTime;
    fDt_Credito: TDateTime;
    fDt_Baixa: TDateTime;
    fNr_Parcelas: Real;
    fNr_Histrelsub: Real;
    fNr_Resumocartao: Real;
    fDs_Resumocartao: String;
    fHr_Opercad: TDateTime;
    fHr_Liq: TDateTime;
    fVl_Renegociacao: Real;
    fTp_Controle: Real;
    fNr_Controle: Real;
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
    property Tp_Situacao : Real read fTp_Situacao write fTp_Situacao;
    property Tp_Documento : Real read fTp_Documento write fTp_Documento;
    property Tp_Faturamento : Real read fTp_Faturamento write fTp_Faturamento;
    property Tp_Cobranca : Real read fTp_Cobranca write fTp_Cobranca;
    property Tp_Inclusao : Real read fTp_Inclusao write fTp_Inclusao;
    property Tp_Baixa : Real read fTp_Baixa write fTp_Baixa;
    property Cd_Motivoprorr : Real read fCd_Motivoprorr write fCd_Motivoprorr;
    property Cd_Motivojurdesc : Real read fCd_Motivojurdesc write fCd_Motivojurdesc;
    property Cd_Moeda : Real read fCd_Moeda write fCd_Moeda;
    property Nr_Parcelaorigem : Real read fNr_Parcelaorigem write fNr_Parcelaorigem;
    property Nr_Comissaopaga : Real read fNr_Comissaopaga write fNr_Comissaopaga;
    property Nr_Portador : Real read fNr_Portador write fNr_Portador;
    property Cd_Operbaixa : Real read fCd_Operbaixa write fCd_Operbaixa;
    property Cd_Opercancel : Real read fCd_Opercancel write fCd_Opercancel;
    property Cd_Operalteracao : Real read fCd_Operalteracao write fCd_Operalteracao;
    property Cd_Operimpfat : Real read fCd_Operimpfat write fCd_Operimpfat;
    property Dt_Emissao : TDateTime read fDt_Emissao write fDt_Emissao;
    property Dt_Alteracao : TDateTime read fDt_Alteracao write fDt_Alteracao;
    property Dt_Cancelamento : TDateTime read fDt_Cancelamento write fDt_Cancelamento;
    property Dt_Vencimento : TDateTime read fDt_Vencimento write fDt_Vencimento;
    property Dt_Venctoorigem : TDateTime read fDt_Venctoorigem write fDt_Venctoorigem;
    property Dt_Impfat : TDateTime read fDt_Impfat write fDt_Impfat;
    property Cd_Empliq : Real read fCd_Empliq write fCd_Empliq;
    property Dt_Liq : TDateTime read fDt_Liq write fDt_Liq;
    property Nr_Seqliq : Real read fNr_Seqliq write fNr_Seqliq;
    property Nr_Documento : Real read fNr_Documento write fNr_Documento;
    property Vl_Fatura : Real read fVl_Fatura write fVl_Fatura;
    property Vl_Original : Real read fVl_Original write fVl_Original;
    property Vl_Pago : Real read fVl_Pago write fVl_Pago;
    property Vl_Juros : Real read fVl_Juros write fVl_Juros;
    property Vl_Desconto : Real read fVl_Desconto write fVl_Desconto;
    property Vl_Outacres : Real read fVl_Outacres write fVl_Outacres;
    property Vl_Outdesc : Real read fVl_Outdesc write fVl_Outdesc;
    property Vl_Abatimento : Real read fVl_Abatimento write fVl_Abatimento;
    property Vl_Despfin : Real read fVl_Despfin write fVl_Despfin;
    property Vl_Imposto : Real read fVl_Imposto write fVl_Imposto;
    property Vl_Liquido : Real read fVl_Liquido write fVl_Liquido;
    property Vl_Acrescimo : Real read fVl_Acrescimo write fVl_Acrescimo;
    property Nr_Nossonumero : Real read fNr_Nossonumero write fNr_Nossonumero;
    property Ds_Dacnossonr : String read fDs_Dacnossonr write fDs_Dacnossonr;
    property Pr_Descpgprazo : Real read fPr_Descpgprazo write fPr_Descpgprazo;
    property Pr_Juromes : Real read fPr_Juromes write fPr_Juromes;
    property Pr_Multa : Real read fPr_Multa write fPr_Multa;
    property Pr_Descantecip1 : Real read fPr_Descantecip1 write fPr_Descantecip1;
    property Pr_Descantecip2 : Real read fPr_Descantecip2 write fPr_Descantecip2;
    property Dt_Descantecip1 : TDateTime read fDt_Descantecip1 write fDt_Descantecip1;
    property Dt_Descantecip2 : TDateTime read fDt_Descantecip2 write fDt_Descantecip2;
    property In_Aceite : String read fIn_Aceite write fIn_Aceite;
    property Nr_Carenciaatraso : Real read fNr_Carenciaatraso write fNr_Carenciaatraso;
    property Nr_Carenciamulta : Real read fNr_Carenciamulta write fNr_Carenciamulta;
    property Nr_Descpont : Real read fNr_Descpont write fNr_Descpont;
    property Cd_Componente : String read fCd_Componente write fCd_Componente;
    property Cd_Opercad : Real read fCd_Opercad write fCd_Opercad;
    property Dt_Opercad : TDateTime read fDt_Opercad write fDt_Opercad;
    property Cd_Emplocal : Real read fCd_Emplocal write fCd_Emplocal;
    property Dt_Devchq1 : TDateTime read fDt_Devchq1 write fDt_Devchq1;
    property Dt_Devchq2 : TDateTime read fDt_Devchq2 write fDt_Devchq2;
    property Dt_Credito : TDateTime read fDt_Credito write fDt_Credito;
    property Dt_Baixa : TDateTime read fDt_Baixa write fDt_Baixa;
    property Nr_Parcelas : Real read fNr_Parcelas write fNr_Parcelas;
    property Nr_Histrelsub : Real read fNr_Histrelsub write fNr_Histrelsub;
    property Nr_Resumocartao : Real read fNr_Resumocartao write fNr_Resumocartao;
    property Ds_Resumocartao : String read fDs_Resumocartao write fDs_Resumocartao;
    property Hr_Opercad : TDateTime read fHr_Opercad write fHr_Opercad;
    property Hr_Liq : TDateTime read fHr_Liq write fHr_Liq;
    property Vl_Renegociacao : Real read fVl_Renegociacao write fVl_Renegociacao;
    property Tp_Controle : Real read fTp_Controle write fTp_Controle;
    property Nr_Controle : Real read fNr_Controle write fNr_Controle;
  end;

  TFcr_FaturaiList = class(TcCollection)
  private
    function GetItem(Index: Integer): TFcr_Faturai;
    procedure SetItem(Index: Integer; Value: TFcr_Faturai);
  public
    constructor Create(AOwner: TPersistent);
    function Add: TFcr_Faturai;
    property Items[Index: Integer]: TFcr_Faturai read GetItem write SetItem; default;
  end;
  
implementation

{ TFcr_Faturai }

constructor TFcr_Faturai.Create;
begin

end;

destructor TFcr_Faturai.Destroy;
begin

  inherited;
end;

{ TFcr_FaturaiList }

constructor TFcr_FaturaiList.Create(AOwner: TPersistent);
begin
  inherited Create(TFcr_Faturai);
end;

function TFcr_FaturaiList.Add: TFcr_Faturai;
begin
  Result := TFcr_Faturai(inherited Add);
  Result.create;
end;

function TFcr_FaturaiList.GetItem(Index: Integer): TFcr_Faturai;
begin
  Result := TFcr_Faturai(inherited GetItem(Index));
end;

procedure TFcr_FaturaiList.SetItem(Index: Integer; Value: TFcr_Faturai);
begin
  inherited SetItem(Index, Value);
end;

end.