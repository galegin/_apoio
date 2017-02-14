unit uGerOperacao;

interface

uses
  Classes, SysUtils,
  cCollection, cCollectionItem;

type
  TGer_Operacao = class;
  TGer_OperacaoClass = class of TGer_Operacao;

  TGer_OperacaoList = class;
  TGer_OperacaoListClass = class of TGer_OperacaoList;

  TGer_Operacao = class(TcCollectionItem)
  private
    fCd_Operacao: Real;
    fU_Version: String;
    fCd_Operador: Real;
    fDt_Cadastro: TDateTime;
    fDs_Operacao: String;
    fCd_Regrafiscal: Real;
    fIn_Fiscal: String;
    fTp_Operacao: String;
    fTp_Modalidade: String;
    fTp_Comercial: String;
    fTp_Regravenda: Real;
    fTp_Regracompra: Real;
    fTp_Docto: Real;
    fIn_Kardex: String;
    fIn_Financeiro: String;
    fIn_Calcimposto: String;
    fCd_Operfat: Real;
    fCd_Cfop: Real;
    fCd_Cst: String;
    fCd_Hstcxa: Real;
    fCd_Hstfin: Real;
  public
    constructor Create; reintroduce;
    destructor Destroy; override;
  published
    property Cd_Operacao : Real read fCd_Operacao write fCd_Operacao;
    property U_Version : String read fU_Version write fU_Version;
    property Cd_Operador : Real read fCd_Operador write fCd_Operador;
    property Dt_Cadastro : TDateTime read fDt_Cadastro write fDt_Cadastro;
    property Ds_Operacao : String read fDs_Operacao write fDs_Operacao;
    property Cd_Regrafiscal : Real read fCd_Regrafiscal write fCd_Regrafiscal;
    property In_Fiscal : String read fIn_Fiscal write fIn_Fiscal;
    property Tp_Operacao : String read fTp_Operacao write fTp_Operacao;
    property Tp_Modalidade : String read fTp_Modalidade write fTp_Modalidade;
    property Tp_Comercial : String read fTp_Comercial write fTp_Comercial;
    property Tp_Regravenda : Real read fTp_Regravenda write fTp_Regravenda;
    property Tp_Regracompra : Real read fTp_Regracompra write fTp_Regracompra;
    property Tp_Docto : Real read fTp_Docto write fTp_Docto;
    property In_Kardex : String read fIn_Kardex write fIn_Kardex;
    property In_Financeiro : String read fIn_Financeiro write fIn_Financeiro;
    property In_Calcimposto : String read fIn_Calcimposto write fIn_Calcimposto;
    property Cd_Operfat : Real read fCd_Operfat write fCd_Operfat;
    property Cd_Cfop : Real read fCd_Cfop write fCd_Cfop;
    property Cd_Cst : String read fCd_Cst write fCd_Cst;
    property Cd_Hstcxa : Real read fCd_Hstcxa write fCd_Hstcxa;
    property Cd_Hstfin : Real read fCd_Hstfin write fCd_Hstfin;
  end;

  TGer_OperacaoList = class(TcCollection)
  private
    function GetItem(Index: Integer): TGer_Operacao;
    procedure SetItem(Index: Integer; Value: TGer_Operacao);
  public
    constructor Create(AOwner: TPersistent);
    function Add: TGer_Operacao;
    property Items[Index: Integer]: TGer_Operacao read GetItem write SetItem; default;
  end;
  
implementation

{ TGer_Operacao }

constructor TGer_Operacao.Create;
begin

end;

destructor TGer_Operacao.Destroy;
begin

  inherited;
end;

{ TGer_OperacaoList }

constructor TGer_OperacaoList.Create(AOwner: TPersistent);
begin
  inherited Create(TGer_Operacao);
end;

function TGer_OperacaoList.Add: TGer_Operacao;
begin
  Result := TGer_Operacao(inherited Add);
  Result.create;
end;

function TGer_OperacaoList.GetItem(Index: Integer): TGer_Operacao;
begin
  Result := TGer_Operacao(inherited GetItem(Index));
end;

procedure TGer_OperacaoList.SetItem(Index: Integer; Value: TGer_Operacao);
begin
  inherited SetItem(Index, Value);
end;

end.