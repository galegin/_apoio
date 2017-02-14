unit uFgrLiqicradic;

interface

uses
  Classes, SysUtils,
  cCollection, cCollectionItem;

type
  TFgr_Liqicradic = class;
  TFgr_LiqicradicClass = class of TFgr_Liqicradic;

  TFgr_LiqicradicList = class;
  TFgr_LiqicradicListClass = class of TFgr_LiqicradicList;

  TFgr_Liqicradic = class(TcCollectionItem)
  private
    fCd_Empliq: Real;
    fDt_Liq: TDateTime;
    fNr_Seqliq: Real;
    fNr_Seqitem: Real;
    fU_Version: String;
    fCd_Operador: Real;
    fDt_Cadastro: TDateTime;
    fCd_Emplocal: Real;
    fTp_Faturamento: Real;
    fTp_Cobranca: Real;
    fTp_Baixa: Real;
    fCd_Moeda: Real;
    fNr_Portador: Real;
    fDt_Emissao: TDateTime;
    fDt_Vencimento: TDateTime;
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
    fVl_Renegociacao: Real;
    fVl_Multa: Real;
    fPr_Descpgprazo: Real;
    fPr_Juromes: Real;
    fPr_Multa: Real;
    fPr_Descantecip1: Real;
    fPr_Descantecip2: Real;
    fDt_Descantecip1: TDateTime;
    fDt_Descantecip2: TDateTime;
    fNr_Carenciaatraso: Real;
    fNr_Carenciamulta: Real;
    fNr_Descpont: Real;
    fCd_Empchqpres: Real;
    fCd_Clichqpres: Real;
    fNr_Chequepres: Real;
    fNr_Ctapespres: Real;
  public
    constructor Create; reintroduce;
    destructor Destroy; override;
  published
    property Cd_Empliq : Real read fCd_Empliq write fCd_Empliq;
    property Dt_Liq : TDateTime read fDt_Liq write fDt_Liq;
    property Nr_Seqliq : Real read fNr_Seqliq write fNr_Seqliq;
    property Nr_Seqitem : Real read fNr_Seqitem write fNr_Seqitem;
    property U_Version : String read fU_Version write fU_Version;
    property Cd_Operador : Real read fCd_Operador write fCd_Operador;
    property Dt_Cadastro : TDateTime read fDt_Cadastro write fDt_Cadastro;
    property Cd_Emplocal : Real read fCd_Emplocal write fCd_Emplocal;
    property Tp_Faturamento : Real read fTp_Faturamento write fTp_Faturamento;
    property Tp_Cobranca : Real read fTp_Cobranca write fTp_Cobranca;
    property Tp_Baixa : Real read fTp_Baixa write fTp_Baixa;
    property Cd_Moeda : Real read fCd_Moeda write fCd_Moeda;
    property Nr_Portador : Real read fNr_Portador write fNr_Portador;
    property Dt_Emissao : TDateTime read fDt_Emissao write fDt_Emissao;
    property Dt_Vencimento : TDateTime read fDt_Vencimento write fDt_Vencimento;
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
    property Vl_Renegociacao : Real read fVl_Renegociacao write fVl_Renegociacao;
    property Vl_Multa : Real read fVl_Multa write fVl_Multa;
    property Pr_Descpgprazo : Real read fPr_Descpgprazo write fPr_Descpgprazo;
    property Pr_Juromes : Real read fPr_Juromes write fPr_Juromes;
    property Pr_Multa : Real read fPr_Multa write fPr_Multa;
    property Pr_Descantecip1 : Real read fPr_Descantecip1 write fPr_Descantecip1;
    property Pr_Descantecip2 : Real read fPr_Descantecip2 write fPr_Descantecip2;
    property Dt_Descantecip1 : TDateTime read fDt_Descantecip1 write fDt_Descantecip1;
    property Dt_Descantecip2 : TDateTime read fDt_Descantecip2 write fDt_Descantecip2;
    property Nr_Carenciaatraso : Real read fNr_Carenciaatraso write fNr_Carenciaatraso;
    property Nr_Carenciamulta : Real read fNr_Carenciamulta write fNr_Carenciamulta;
    property Nr_Descpont : Real read fNr_Descpont write fNr_Descpont;
    property Cd_Empchqpres : Real read fCd_Empchqpres write fCd_Empchqpres;
    property Cd_Clichqpres : Real read fCd_Clichqpres write fCd_Clichqpres;
    property Nr_Chequepres : Real read fNr_Chequepres write fNr_Chequepres;
    property Nr_Ctapespres : Real read fNr_Ctapespres write fNr_Ctapespres;
  end;

  TFgr_LiqicradicList = class(TcCollection)
  private
    function GetItem(Index: Integer): TFgr_Liqicradic;
    procedure SetItem(Index: Integer; Value: TFgr_Liqicradic);
  public
    constructor Create(AOwner: TPersistent);
    function Add: TFgr_Liqicradic;
    property Items[Index: Integer]: TFgr_Liqicradic read GetItem write SetItem; default;
  end;
  
implementation

{ TFgr_Liqicradic }

constructor TFgr_Liqicradic.Create;
begin

end;

destructor TFgr_Liqicradic.Destroy;
begin

  inherited;
end;

{ TFgr_LiqicradicList }

constructor TFgr_LiqicradicList.Create(AOwner: TPersistent);
begin
  inherited Create(TFgr_Liqicradic);
end;

function TFgr_LiqicradicList.Add: TFgr_Liqicradic;
begin
  Result := TFgr_Liqicradic(inherited Add);
  Result.create;
end;

function TFgr_LiqicradicList.GetItem(Index: Integer): TFgr_Liqicradic;
begin
  Result := TFgr_Liqicradic(inherited GetItem(Index));
end;

procedure TFgr_LiqicradicList.SetItem(Index: Integer; Value: TFgr_Liqicradic);
begin
  inherited SetItem(Index, Value);
end;

end.