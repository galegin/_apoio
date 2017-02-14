unit uGerOperlog;

interface

uses
  Classes, SysUtils,
  cCollection, cCollectionItem;

type
  TGer_Operlog = class;
  TGer_OperlogClass = class of TGer_Operlog;

  TGer_OperlogList = class;
  TGer_OperlogListClass = class of TGer_OperlogList;

  TGer_Operlog = class(TcCollectionItem)
  private
    fDt_Evento: TDateTime;
    fNr_Sequencia: Real;
    fU_Version: String;
    fCd_Operador: Real;
    fDt_Cadastro: TDateTime;
    fCd_Tipolog: String;
    fCd_Operacao: Real;
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
    property Dt_Evento : TDateTime read fDt_Evento write fDt_Evento;
    property Nr_Sequencia : Real read fNr_Sequencia write fNr_Sequencia;
    property U_Version : String read fU_Version write fU_Version;
    property Cd_Operador : Real read fCd_Operador write fCd_Operador;
    property Dt_Cadastro : TDateTime read fDt_Cadastro write fDt_Cadastro;
    property Cd_Tipolog : String read fCd_Tipolog write fCd_Tipolog;
    property Cd_Operacao : Real read fCd_Operacao write fCd_Operacao;
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

  TGer_OperlogList = class(TcCollection)
  private
    function GetItem(Index: Integer): TGer_Operlog;
    procedure SetItem(Index: Integer; Value: TGer_Operlog);
  public
    constructor Create(AOwner: TPersistent);
    function Add: TGer_Operlog;
    property Items[Index: Integer]: TGer_Operlog read GetItem write SetItem; default;
  end;
  
implementation

{ TGer_Operlog }

constructor TGer_Operlog.Create;
begin

end;

destructor TGer_Operlog.Destroy;
begin

  inherited;
end;

{ TGer_OperlogList }

constructor TGer_OperlogList.Create(AOwner: TPersistent);
begin
  inherited Create(TGer_Operlog);
end;

function TGer_OperlogList.Add: TGer_Operlog;
begin
  Result := TGer_Operlog(inherited Add);
  Result.create;
end;

function TGer_OperlogList.GetItem(Index: Integer): TGer_Operlog;
begin
  Result := TGer_Operlog(inherited GetItem(Index));
end;

procedure TGer_OperlogList.SetItem(Index: Integer; Value: TGer_Operlog);
begin
  inherited SetItem(Index, Value);
end;

end.