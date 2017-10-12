unit uTefTransacao;

interface

uses
  Classes, SysUtils,
  System.Generics.Collections,
  mMapping;

type
  [Tabela('TEF_TRANSACAO')]
  TTef_Transacao = class(TmMapping)
  private
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
  published
    [Campo('CD_EMPRESA', tfKey)]
    property Cd_Empresa : String read fCd_Empresa write fCd_Empresa;
    [Campo('DT_MOVIMENTO', tfKey)]
    property Dt_Movimento : String read fDt_Movimento write fDt_Movimento;
    [Campo('NR_SEQ', tfKey)]
    property Nr_Seq : String read fNr_Seq write fNr_Seq;
    [Campo('U_VERSION', tfNul)]
    property U_Version : String read fU_Version write fU_Version;
    [Campo('CD_OPERADOR', tfReq)]
    property Cd_Operador : String read fCd_Operador write fCd_Operador;
    [Campo('DT_CADASTRO', tfReq)]
    property Dt_Cadastro : String read fDt_Cadastro write fDt_Cadastro;
    [Campo('CD_ARQUIVO', tfReq)]
    property Cd_Arquivo : String read fCd_Arquivo write fCd_Arquivo;
    [Campo('TP_TEF', tfReq)]
    property Tp_Tef : String read fTp_Tef write fTp_Tef;
    [Campo('TP_SITUACAO', tfReq)]
    property Tp_Situacao : String read fTp_Situacao write fTp_Situacao;
    [Campo('TP_TRANSACAO', tfNul)]
    property Tp_Transacao : String read fTp_Transacao write fTp_Transacao;
    [Campo('CD_REDETEF', tfNul)]
    property Cd_Redetef : String read fCd_Redetef write fCd_Redetef;
    [Campo('VL_TRANSACAO', tfNul)]
    property Vl_Transacao : String read fVl_Transacao write fVl_Transacao;
    [Campo('HR_TRANSACAO', tfNul)]
    property Hr_Transacao : String read fHr_Transacao write fHr_Transacao;
    [Campo('DT_TRANSACAO', tfNul)]
    property Dt_Transacao : String read fDt_Transacao write fDt_Transacao;
    [Campo('NR_NSU', tfNul)]
    property Nr_Nsu : String read fNr_Nsu write fNr_Nsu;
    [Campo('CD_TERMINAL', tfNul)]
    property Cd_Terminal : String read fCd_Terminal write fCd_Terminal;
    [Campo('NR_DOCVINC', tfNul)]
    property Nr_Docvinc : String read fNr_Docvinc write fNr_Docvinc;
    [Campo('NR_NSUAUX', tfNul)]
    property Nr_Nsuaux : String read fNr_Nsuaux write fNr_Nsuaux;
    [Campo('CD_AUTORIZACAO', tfNul)]
    property Cd_Autorizacao : String read fCd_Autorizacao write fCd_Autorizacao;
    [Campo('NM_REDETEF', tfNul)]
    property Nm_Redetef : String read fNm_Redetef write fNm_Redetef;
    [Campo('TP_STATUS', tfNul)]
    property Tp_Status : String read fTp_Status write fTp_Status;
    [Campo('DS_FINALIZACAO', tfNul)]
    property Ds_Finalizacao : String read fDs_Finalizacao write fDs_Finalizacao;
    [Campo('DS_MENSAGEM', tfNul)]
    property Ds_Mensagem : String read fDs_Mensagem write fDs_Mensagem;
    [Campo('NR_LINHASCUPOM', tfNul)]
    property Nr_Linhascupom : String read fNr_Linhascupom write fNr_Linhascupom;
    [Campo('DS_CUPOM', tfNul)]
    property Ds_Cupom : String read fDs_Cupom write fDs_Cupom;
  end;

  TTef_Transacaos = class(TList<Tef_Transacao>);

implementation

{ TTef_Transacao }

constructor TTef_Transacao.Create(AOwner: TComponent);
begin
  inherited;

end;

destructor TTef_Transacao.Destroy;
begin

  inherited;
end;

end.