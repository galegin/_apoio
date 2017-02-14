unit uFcpDuplicatai;

interface

uses
  Classes, SysUtils,
  cCollection, cCollectionItem;

type
  TFcp_Duplicatai = class;
  TFcp_DuplicataiClass = class of TFcp_Duplicatai;

  TFcp_DuplicataiList = class;
  TFcp_DuplicataiListClass = class of TFcp_DuplicataiList;

  TFcp_Duplicatai = class(TcCollectionItem)
  private
    fCd_Empresa: Real;
    fCd_Fornecedor: Real;
    fNr_Duplicata: Real;
    fNr_Parcela: Real;
    fU_Version: String;
    fCd_Operador: Real;
    fDt_Cadastro: TDateTime;
    fNr_Portador: Real;
    fNr_Paroriginal: Real;
    fDt_Entrada: TDateTime;
    fDt_Emissao: TDateTime;
    fDt_Vencimento: TDateTime;
    fDt_Venctoorigem: TDateTime;
    fIn_Imposto: String;
    fIn_Aceite: String;
    fIn_Autorizado: String;
    fIn_Substituido: String;
    fIn_Libpagto: String;
    fTp_Situacao: String;
    fTp_Documento: Real;
    fTp_Baixa: Real;
    fTp_Inclusao: Real;
    fTp_Estagio: Real;
    fCd_Operbaixa: Real;
    fCd_Operalteracao: Real;
    fCd_Operinclusao: Real;
    fCd_Operdevol: Real;
    fCd_Opercancel: Real;
    fVl_Duplicata: Real;
    fVl_Original: Real;
    fCd_Moeda: Real;
    fVl_Descpontual: Real;
    fPr_Descpontual: Real;
    fVl_Descantecip1: Real;
    fPr_Descantecip1: Real;
    fVl_Descantecip2: Real;
    fPr_Descantecip2: Real;
    fDt_Descantecip1: TDateTime;
    fDt_Descantecip2: TDateTime;
    fTp_Descantecip1: Real;
    fTp_Descantecip2: Real;
    fTp_Descantecipp: Real;
    fVl_Multa: Real;
    fPr_Multa: Real;
    fDt_Multa: TDateTime;
    fVl_Moradia: Real;
    fPr_Moradia: Real;
    fVl_Despfin: Real;
    fVl_Abatimento: Real;
    fVl_Acrescimo: Real;
    fVl_Outrosdesc: Real;
    fVl_Outroacr: Real;
    fVl_Imposto: Real;
    fVl_Pago: Real;
    fVl_Juros: Real;
    fVl_Desconto: Real;
    fDt_Baixa: TDateTime;
    fDt_Alteracao: TDateTime;
    fDt_Inclusao: TDateTime;
    fDt_Devolucao: TDateTime;
    fDt_Cancelamento: TDateTime;
    fDt_Chegada: TDateTime;
    fDt_Saidaforn: TDateTime;
    fTp_Previsaoreal: Real;
    fCd_Componente: String;
    fCd_Empliq: Real;
    fDt_Liq: TDateTime;
    fNr_Seqliq: Real;
    fVl_Indenizacao: Real;
    fPr_Basecalcimp: Real;
    fIn_Descacum: String;
    fIn_Pgtofornec: String;
    fDt_Mesanoret: TDateTime;
    fVl_Pgtomulta: Real;
  public
    constructor Create; reintroduce;
    destructor Destroy; override;
  published
    property Cd_Empresa : Real read fCd_Empresa write fCd_Empresa;
    property Cd_Fornecedor : Real read fCd_Fornecedor write fCd_Fornecedor;
    property Nr_Duplicata : Real read fNr_Duplicata write fNr_Duplicata;
    property Nr_Parcela : Real read fNr_Parcela write fNr_Parcela;
    property U_Version : String read fU_Version write fU_Version;
    property Cd_Operador : Real read fCd_Operador write fCd_Operador;
    property Dt_Cadastro : TDateTime read fDt_Cadastro write fDt_Cadastro;
    property Nr_Portador : Real read fNr_Portador write fNr_Portador;
    property Nr_Paroriginal : Real read fNr_Paroriginal write fNr_Paroriginal;
    property Dt_Entrada : TDateTime read fDt_Entrada write fDt_Entrada;
    property Dt_Emissao : TDateTime read fDt_Emissao write fDt_Emissao;
    property Dt_Vencimento : TDateTime read fDt_Vencimento write fDt_Vencimento;
    property Dt_Venctoorigem : TDateTime read fDt_Venctoorigem write fDt_Venctoorigem;
    property In_Imposto : String read fIn_Imposto write fIn_Imposto;
    property In_Aceite : String read fIn_Aceite write fIn_Aceite;
    property In_Autorizado : String read fIn_Autorizado write fIn_Autorizado;
    property In_Substituido : String read fIn_Substituido write fIn_Substituido;
    property In_Libpagto : String read fIn_Libpagto write fIn_Libpagto;
    property Tp_Situacao : String read fTp_Situacao write fTp_Situacao;
    property Tp_Documento : Real read fTp_Documento write fTp_Documento;
    property Tp_Baixa : Real read fTp_Baixa write fTp_Baixa;
    property Tp_Inclusao : Real read fTp_Inclusao write fTp_Inclusao;
    property Tp_Estagio : Real read fTp_Estagio write fTp_Estagio;
    property Cd_Operbaixa : Real read fCd_Operbaixa write fCd_Operbaixa;
    property Cd_Operalteracao : Real read fCd_Operalteracao write fCd_Operalteracao;
    property Cd_Operinclusao : Real read fCd_Operinclusao write fCd_Operinclusao;
    property Cd_Operdevol : Real read fCd_Operdevol write fCd_Operdevol;
    property Cd_Opercancel : Real read fCd_Opercancel write fCd_Opercancel;
    property Vl_Duplicata : Real read fVl_Duplicata write fVl_Duplicata;
    property Vl_Original : Real read fVl_Original write fVl_Original;
    property Cd_Moeda : Real read fCd_Moeda write fCd_Moeda;
    property Vl_Descpontual : Real read fVl_Descpontual write fVl_Descpontual;
    property Pr_Descpontual : Real read fPr_Descpontual write fPr_Descpontual;
    property Vl_Descantecip1 : Real read fVl_Descantecip1 write fVl_Descantecip1;
    property Pr_Descantecip1 : Real read fPr_Descantecip1 write fPr_Descantecip1;
    property Vl_Descantecip2 : Real read fVl_Descantecip2 write fVl_Descantecip2;
    property Pr_Descantecip2 : Real read fPr_Descantecip2 write fPr_Descantecip2;
    property Dt_Descantecip1 : TDateTime read fDt_Descantecip1 write fDt_Descantecip1;
    property Dt_Descantecip2 : TDateTime read fDt_Descantecip2 write fDt_Descantecip2;
    property Tp_Descantecip1 : Real read fTp_Descantecip1 write fTp_Descantecip1;
    property Tp_Descantecip2 : Real read fTp_Descantecip2 write fTp_Descantecip2;
    property Tp_Descantecipp : Real read fTp_Descantecipp write fTp_Descantecipp;
    property Vl_Multa : Real read fVl_Multa write fVl_Multa;
    property Pr_Multa : Real read fPr_Multa write fPr_Multa;
    property Dt_Multa : TDateTime read fDt_Multa write fDt_Multa;
    property Vl_Moradia : Real read fVl_Moradia write fVl_Moradia;
    property Pr_Moradia : Real read fPr_Moradia write fPr_Moradia;
    property Vl_Despfin : Real read fVl_Despfin write fVl_Despfin;
    property Vl_Abatimento : Real read fVl_Abatimento write fVl_Abatimento;
    property Vl_Acrescimo : Real read fVl_Acrescimo write fVl_Acrescimo;
    property Vl_Outrosdesc : Real read fVl_Outrosdesc write fVl_Outrosdesc;
    property Vl_Outroacr : Real read fVl_Outroacr write fVl_Outroacr;
    property Vl_Imposto : Real read fVl_Imposto write fVl_Imposto;
    property Vl_Pago : Real read fVl_Pago write fVl_Pago;
    property Vl_Juros : Real read fVl_Juros write fVl_Juros;
    property Vl_Desconto : Real read fVl_Desconto write fVl_Desconto;
    property Dt_Baixa : TDateTime read fDt_Baixa write fDt_Baixa;
    property Dt_Alteracao : TDateTime read fDt_Alteracao write fDt_Alteracao;
    property Dt_Inclusao : TDateTime read fDt_Inclusao write fDt_Inclusao;
    property Dt_Devolucao : TDateTime read fDt_Devolucao write fDt_Devolucao;
    property Dt_Cancelamento : TDateTime read fDt_Cancelamento write fDt_Cancelamento;
    property Dt_Chegada : TDateTime read fDt_Chegada write fDt_Chegada;
    property Dt_Saidaforn : TDateTime read fDt_Saidaforn write fDt_Saidaforn;
    property Tp_Previsaoreal : Real read fTp_Previsaoreal write fTp_Previsaoreal;
    property Cd_Componente : String read fCd_Componente write fCd_Componente;
    property Cd_Empliq : Real read fCd_Empliq write fCd_Empliq;
    property Dt_Liq : TDateTime read fDt_Liq write fDt_Liq;
    property Nr_Seqliq : Real read fNr_Seqliq write fNr_Seqliq;
    property Vl_Indenizacao : Real read fVl_Indenizacao write fVl_Indenizacao;
    property Pr_Basecalcimp : Real read fPr_Basecalcimp write fPr_Basecalcimp;
    property In_Descacum : String read fIn_Descacum write fIn_Descacum;
    property In_Pgtofornec : String read fIn_Pgtofornec write fIn_Pgtofornec;
    property Dt_Mesanoret : TDateTime read fDt_Mesanoret write fDt_Mesanoret;
    property Vl_Pgtomulta : Real read fVl_Pgtomulta write fVl_Pgtomulta;
  end;

  TFcp_DuplicataiList = class(TcCollection)
  private
    function GetItem(Index: Integer): TFcp_Duplicatai;
    procedure SetItem(Index: Integer; Value: TFcp_Duplicatai);
  public
    constructor Create(AOwner: TPersistent);
    function Add: TFcp_Duplicatai;
    property Items[Index: Integer]: TFcp_Duplicatai read GetItem write SetItem; default;
  end;
  
implementation

{ TFcp_Duplicatai }

constructor TFcp_Duplicatai.Create;
begin

end;

destructor TFcp_Duplicatai.Destroy;
begin

  inherited;
end;

{ TFcp_DuplicataiList }

constructor TFcp_DuplicataiList.Create(AOwner: TPersistent);
begin
  inherited Create(TFcp_Duplicatai);
end;

function TFcp_DuplicataiList.Add: TFcp_Duplicatai;
begin
  Result := TFcp_Duplicatai(inherited Add);
  Result.create;
end;

function TFcp_DuplicataiList.GetItem(Index: Integer): TFcp_Duplicatai;
begin
  Result := TFcp_Duplicatai(inherited GetItem(Index));
end;

procedure TFcp_DuplicataiList.SetItem(Index: Integer; Value: TFcp_Duplicatai);
begin
  inherited SetItem(Index, Value);
end;

end.