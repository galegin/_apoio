unit uTraPagto;

interface

uses
  Classes, SysUtils,
  System.Generics.Collections,
  mMapping;

type
  [Tabela('TRA_PAGTO')]
  TTra_Pagto = class(TmMapping)
  private
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
  published
    [Campo('CD_EMPRESA', tfKey)]
    property Cd_Empresa : String read fCd_Empresa write fCd_Empresa;
    [Campo('NR_TRANSACAO', tfKey)]
    property Nr_Transacao : String read fNr_Transacao write fNr_Transacao;
    [Campo('DT_TRANSACAO', tfKey)]
    property Dt_Transacao : String read fDt_Transacao write fDt_Transacao;
    [Campo('NR_SEQUENCIA', tfKey)]
    property Nr_Sequencia : String read fNr_Sequencia write fNr_Sequencia;
    [Campo('U_VERSION', tfNul)]
    property U_Version : String read fU_Version write fU_Version;
    [Campo('CD_OPERADOR', tfReq)]
    property Cd_Operador : String read fCd_Operador write fCd_Operador;
    [Campo('DT_CADASTRO', tfReq)]
    property Dt_Cadastro : String read fDt_Cadastro write fDt_Cadastro;
    [Campo('TP_DOCUMENTO', tfReq)]
    property Tp_Documento : String read fTp_Documento write fTp_Documento;
    [Campo('NR_HISTRELSUB', tfReq)]
    property Nr_Histrelsub : String read fNr_Histrelsub write fNr_Histrelsub;
    [Campo('NR_DOCUMENTO', tfReq)]
    property Nr_Documento : String read fNr_Documento write fNr_Documento;
    [Campo('VL_DOCUMENTO', tfReq)]
    property Vl_Documento : String read fVl_Documento write fVl_Documento;
    [Campo('DT_VENCIMENTO', tfReq)]
    property Dt_Vencimento : String read fDt_Vencimento write fDt_Vencimento;
    [Campo('CD_AUTORIZACAO', tfNul)]
    property Cd_Autorizacao : String read fCd_Autorizacao write fCd_Autorizacao;
    [Campo('NR_NSU', tfNul)]
    property Nr_Nsu : String read fNr_Nsu write fNr_Nsu;
    [Campo('DS_REDETEF', tfNul)]
    property Ds_Redetef : String read fDs_Redetef write fDs_Redetef;
    [Campo('NR_PARCELA', tfNul)]
    property Nr_Parcela : String read fNr_Parcela write fNr_Parcela;
    [Campo('NR_PARCELAS', tfNul)]
    property Nr_Parcelas : String read fNr_Parcelas write fNr_Parcelas;
    [Campo('NR_BANCO', tfNul)]
    property Nr_Banco : String read fNr_Banco write fNr_Banco;
    [Campo('NR_AGENCIA', tfNul)]
    property Nr_Agencia : String read fNr_Agencia write fNr_Agencia;
    [Campo('DS_CONTA', tfNul)]
    property Ds_Conta : String read fDs_Conta write fDs_Conta;
    [Campo('NR_CHEQUE', tfNul)]
    property Nr_Cheque : String read fNr_Cheque write fNr_Cheque;
  end;

  TTra_Pagtos = class(TList<Tra_Pagto>);

implementation

{ TTra_Pagto }

constructor TTra_Pagto.Create(AOwner: TComponent);
begin
  inherited;

end;

destructor TTra_Pagto.Destroy;
begin

  inherited;
end;

end.