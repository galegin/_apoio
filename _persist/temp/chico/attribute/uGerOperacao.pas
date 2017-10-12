unit uGerOperacao;

interface

uses
  Classes, SysUtils,
  System.Generics.Collections,
  mMapping;

type
  [Tabela('GER_OPERACAO')]
  TGer_Operacao = class(TmMapping)
  private
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
  published
    [Campo('CD_OPERACAO', tfKey)]
    property Cd_Operacao : String read fCd_Operacao write fCd_Operacao;
    [Campo('U_VERSION', tfNul)]
    property U_Version : String read fU_Version write fU_Version;
    [Campo('CD_OPERADOR', tfReq)]
    property Cd_Operador : String read fCd_Operador write fCd_Operador;
    [Campo('DT_CADASTRO', tfReq)]
    property Dt_Cadastro : String read fDt_Cadastro write fDt_Cadastro;
    [Campo('DS_OPERACAO', tfReq)]
    property Ds_Operacao : String read fDs_Operacao write fDs_Operacao;
    [Campo('CD_REGRAFISCAL', tfReq)]
    property Cd_Regrafiscal : String read fCd_Regrafiscal write fCd_Regrafiscal;
    [Campo('IN_FISCAL', tfNul)]
    property In_Fiscal : String read fIn_Fiscal write fIn_Fiscal;
    [Campo('TP_OPERACAO', tfNul)]
    property Tp_Operacao : String read fTp_Operacao write fTp_Operacao;
    [Campo('TP_MODALIDADE', tfNul)]
    property Tp_Modalidade : String read fTp_Modalidade write fTp_Modalidade;
    [Campo('TP_COMERCIAL', tfNul)]
    property Tp_Comercial : String read fTp_Comercial write fTp_Comercial;
    [Campo('TP_REGRAVENDA', tfNul)]
    property Tp_Regravenda : String read fTp_Regravenda write fTp_Regravenda;
    [Campo('TP_REGRACOMPRA', tfNul)]
    property Tp_Regracompra : String read fTp_Regracompra write fTp_Regracompra;
    [Campo('TP_DOCTO', tfNul)]
    property Tp_Docto : String read fTp_Docto write fTp_Docto;
    [Campo('IN_KARDEX', tfNul)]
    property In_Kardex : String read fIn_Kardex write fIn_Kardex;
    [Campo('IN_FINANCEIRO', tfNul)]
    property In_Financeiro : String read fIn_Financeiro write fIn_Financeiro;
    [Campo('IN_CALCIMPOSTO', tfNul)]
    property In_Calcimposto : String read fIn_Calcimposto write fIn_Calcimposto;
    [Campo('CD_OPERFAT', tfNul)]
    property Cd_Operfat : String read fCd_Operfat write fCd_Operfat;
    [Campo('CD_CFOP', tfNul)]
    property Cd_Cfop : String read fCd_Cfop write fCd_Cfop;
    [Campo('CD_CST', tfNul)]
    property Cd_Cst : String read fCd_Cst write fCd_Cst;
    [Campo('CD_HSTCXA', tfNul)]
    property Cd_Hstcxa : String read fCd_Hstcxa write fCd_Hstcxa;
    [Campo('CD_HSTFIN', tfNul)]
    property Cd_Hstfin : String read fCd_Hstfin write fCd_Hstfin;
  end;

  TGer_Operacaos = class(TList<Ger_Operacao>);

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

end.