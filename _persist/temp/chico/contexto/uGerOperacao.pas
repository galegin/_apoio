unit uGerOperacao;

interface

uses
  Classes, SysUtils,
  mMapping;

type
  TGer_Operacao = class(TmMapping)
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
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function GetMapping() : PmMapping; override;
  published
    property Cd_Operacao : String read fCd_Operacao write fCd_Operacao;
    property U_Version : String read fU_Version write fU_Version;
    property Cd_Operador : String read fCd_Operador write fCd_Operador;
    property Dt_Cadastro : String read fDt_Cadastro write fDt_Cadastro;
    property Ds_Operacao : String read fDs_Operacao write fDs_Operacao;
    property Cd_Regrafiscal : String read fCd_Regrafiscal write fCd_Regrafiscal;
    property In_Fiscal : String read fIn_Fiscal write fIn_Fiscal;
    property Tp_Operacao : String read fTp_Operacao write fTp_Operacao;
    property Tp_Modalidade : String read fTp_Modalidade write fTp_Modalidade;
    property Tp_Comercial : String read fTp_Comercial write fTp_Comercial;
    property Tp_Regravenda : String read fTp_Regravenda write fTp_Regravenda;
    property Tp_Regracompra : String read fTp_Regracompra write fTp_Regracompra;
    property Tp_Docto : String read fTp_Docto write fTp_Docto;
    property In_Kardex : String read fIn_Kardex write fIn_Kardex;
    property In_Financeiro : String read fIn_Financeiro write fIn_Financeiro;
    property In_Calcimposto : String read fIn_Calcimposto write fIn_Calcimposto;
    property Cd_Operfat : String read fCd_Operfat write fCd_Operfat;
    property Cd_Cfop : String read fCd_Cfop write fCd_Cfop;
    property Cd_Cst : String read fCd_Cst write fCd_Cst;
    property Cd_Hstcxa : String read fCd_Hstcxa write fCd_Hstcxa;
    property Cd_Hstfin : String read fCd_Hstfin write fCd_Hstfin;
  end;

  TGer_Operacaos = class(TList)
  public
    function Add: TGer_Operacao; overload;
  end;

implementation

{ TGer_Operacao }

constructor TGer_Operacao.Create(AOwner: TComponent);
begin
  inherited;

end;

destructor TGer_Operacao.Destroy;
begin

  inherited;
end;

//--

function TGer_Operacao.GetMapping: PmMapping;
begin
  Result := New(PmMapping);

  Result.Tabela := New(PmTabela);
  with Result.Tabela^ do begin
    Nome := 'GER_OPERACAO';
  end;

  Result.Campos := TmCampos.Create;
  with Result.Campos do begin
    Add('Cd_Operacao', 'CD_OPERACAO', tfKey);
    Add('U_Version', 'U_VERSION', tfNul);
    Add('Cd_Operador', 'CD_OPERADOR', tfReq);
    Add('Dt_Cadastro', 'DT_CADASTRO', tfReq);
    Add('Ds_Operacao', 'DS_OPERACAO', tfReq);
    Add('Cd_Regrafiscal', 'CD_REGRAFISCAL', tfReq);
    Add('In_Fiscal', 'IN_FISCAL', tfNul);
    Add('Tp_Operacao', 'TP_OPERACAO', tfNul);
    Add('Tp_Modalidade', 'TP_MODALIDADE', tfNul);
    Add('Tp_Comercial', 'TP_COMERCIAL', tfNul);
    Add('Tp_Regravenda', 'TP_REGRAVENDA', tfNul);
    Add('Tp_Regracompra', 'TP_REGRACOMPRA', tfNul);
    Add('Tp_Docto', 'TP_DOCTO', tfNul);
    Add('In_Kardex', 'IN_KARDEX', tfNul);
    Add('In_Financeiro', 'IN_FINANCEIRO', tfNul);
    Add('In_Calcimposto', 'IN_CALCIMPOSTO', tfNul);
    Add('Cd_Operfat', 'CD_OPERFAT', tfNul);
    Add('Cd_Cfop', 'CD_CFOP', tfNul);
    Add('Cd_Cst', 'CD_CST', tfNul);
    Add('Cd_Hstcxa', 'CD_HSTCXA', tfNul);
    Add('Cd_Hstfin', 'CD_HSTFIN', tfNul);
  end;

  Result.Relacoes := TmRelacoes.Create;
  with Result.Relacoes do begin
  end;
end;

//--

{ TGer_Operacaos }

function TGer_Operacaos.Add: TGer_Operacao;
begin
  Result := TGer_Operacao.Create(nil);
  Self.Add(Result);
end;

end.