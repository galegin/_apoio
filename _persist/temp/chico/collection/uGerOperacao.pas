unit uGerOperacao;

interface

uses
  Classes, SysUtils,
  mCollection, mCollectionItem;

type
  TGer_Operacao = class;
  TGer_OperacaoClass = class of TGer_Operacao;

  TGer_OperacaoList = class;
  TGer_OperacaoListClass = class of TGer_OperacaoList;

  TGer_Operacao = class(TmCollectionItem)
  private
    fCd_Operacao: String;
    fU_Version: String;
    fCd_Operador: String;
    fDt_Cadastro: String;
    fDs_Operacao: String;
    fCd_Regrafiscal: String;
    fIn_Fiscal: String;
    fTp_Operacao: String;
    fTp_Modalidade: String;
    fTp_Comercial: String;
    fTp_Regravenda: String;
    fTp_Regracompra: String;
    fTp_Docto: String;
    fIn_Kardex: String;
    fIn_Financeiro: String;
    fIn_Calcimposto: String;
    fCd_Operfat: String;
    fCd_Cfop: String;
    fCd_Cst: String;
    fCd_Hstcxa: String;
    fCd_Hstfin: String;
  public
    constructor Create(ACollection: TCollection); override;
    destructor Destroy; override;
  published
    property Cd_Operacao : String read fCd_Operacao write SetCd_Operacao;
    property U_Version : String read fU_Version write SetU_Version;
    property Cd_Operador : String read fCd_Operador write SetCd_Operador;
    property Dt_Cadastro : String read fDt_Cadastro write SetDt_Cadastro;
    property Ds_Operacao : String read fDs_Operacao write SetDs_Operacao;
    property Cd_Regrafiscal : String read fCd_Regrafiscal write SetCd_Regrafiscal;
    property In_Fiscal : String read fIn_Fiscal write SetIn_Fiscal;
    property Tp_Operacao : String read fTp_Operacao write SetTp_Operacao;
    property Tp_Modalidade : String read fTp_Modalidade write SetTp_Modalidade;
    property Tp_Comercial : String read fTp_Comercial write SetTp_Comercial;
    property Tp_Regravenda : String read fTp_Regravenda write SetTp_Regravenda;
    property Tp_Regracompra : String read fTp_Regracompra write SetTp_Regracompra;
    property Tp_Docto : String read fTp_Docto write SetTp_Docto;
    property In_Kardex : String read fIn_Kardex write SetIn_Kardex;
    property In_Financeiro : String read fIn_Financeiro write SetIn_Financeiro;
    property In_Calcimposto : String read fIn_Calcimposto write SetIn_Calcimposto;
    property Cd_Operfat : String read fCd_Operfat write SetCd_Operfat;
    property Cd_Cfop : String read fCd_Cfop write SetCd_Cfop;
    property Cd_Cst : String read fCd_Cst write SetCd_Cst;
    property Cd_Hstcxa : String read fCd_Hstcxa write SetCd_Hstcxa;
    property Cd_Hstfin : String read fCd_Hstfin write SetCd_Hstfin;
  end;

  TGer_OperacaoList = class(TmCollection)
  private
    function GetItem(Index: Integer): TGer_Operacao;
    procedure SetItem(Index: Integer; Value: TGer_Operacao);
  public
    constructor Create(AOwner: TPersistentCollection);
    function Add: TGer_Operacao;
    property Items[Index: Integer]: TGer_Operacao read GetItem write SetItem; default;
  end;

implementation

{ TGer_Operacao }

constructor TGer_Operacao.Create(ACollection: TCollection);
begin
  inherited;

end;

destructor TGer_Operacao.Destroy;
begin

  inherited;
end;

{ TGer_OperacaoList }

constructor TGer_OperacaoList.Create(AOwner: TPersistentCollection);
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