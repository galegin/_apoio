unit uTefTransacao;

interface

uses
  Classes, SysUtils,
  mMapping;

type
  TTef_Transacao = class(TmMapping)
  private
    fCd_Empresa: String;
    fDt_Movimento: String;
    fNr_Seq: String;
    fU_Version: String;
    fCd_Operador: String;
    fDt_Cadastro: String;
    fCd_Arquivo: String;
    fTp_Tef: String;
    fTp_Situacao: String;
    fTp_Transacao: String;
    fCd_Redetef: String;
    fVl_Transacao: String;
    fHr_Transacao: String;
    fDt_Transacao: String;
    fNr_Nsu: String;
    fCd_Terminal: String;
    fNr_Docvinc: String;
    fNr_Nsuaux: String;
    fCd_Autorizacao: String;
    fNm_Redetef: String;
    fTp_Status: String;
    fDs_Finalizacao: String;
    fDs_Mensagem: String;
    fNr_Linhascupom: String;
    fDs_Cupom: String;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function GetMapping() : PmMapping; override;
  published
    property Cd_Empresa : String read fCd_Empresa write fCd_Empresa;
    property Dt_Movimento : String read fDt_Movimento write fDt_Movimento;
    property Nr_Seq : String read fNr_Seq write fNr_Seq;
    property U_Version : String read fU_Version write fU_Version;
    property Cd_Operador : String read fCd_Operador write fCd_Operador;
    property Dt_Cadastro : String read fDt_Cadastro write fDt_Cadastro;
    property Cd_Arquivo : String read fCd_Arquivo write fCd_Arquivo;
    property Tp_Tef : String read fTp_Tef write fTp_Tef;
    property Tp_Situacao : String read fTp_Situacao write fTp_Situacao;
    property Tp_Transacao : String read fTp_Transacao write fTp_Transacao;
    property Cd_Redetef : String read fCd_Redetef write fCd_Redetef;
    property Vl_Transacao : String read fVl_Transacao write fVl_Transacao;
    property Hr_Transacao : String read fHr_Transacao write fHr_Transacao;
    property Dt_Transacao : String read fDt_Transacao write fDt_Transacao;
    property Nr_Nsu : String read fNr_Nsu write fNr_Nsu;
    property Cd_Terminal : String read fCd_Terminal write fCd_Terminal;
    property Nr_Docvinc : String read fNr_Docvinc write fNr_Docvinc;
    property Nr_Nsuaux : String read fNr_Nsuaux write fNr_Nsuaux;
    property Cd_Autorizacao : String read fCd_Autorizacao write fCd_Autorizacao;
    property Nm_Redetef : String read fNm_Redetef write fNm_Redetef;
    property Tp_Status : String read fTp_Status write fTp_Status;
    property Ds_Finalizacao : String read fDs_Finalizacao write fDs_Finalizacao;
    property Ds_Mensagem : String read fDs_Mensagem write fDs_Mensagem;
    property Nr_Linhascupom : String read fNr_Linhascupom write fNr_Linhascupom;
    property Ds_Cupom : String read fDs_Cupom write fDs_Cupom;
  end;

  TTef_Transacaos = class(TList)
  public
    function Add: TTef_Transacao; overload;
  end;

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

//--

function TTef_Transacao.GetMapping: PmMapping;
begin
  Result := New(PmMapping);

  Result.Tabela := New(PmTabela);
  with Result.Tabela^ do begin
    Nome := 'TEF_TRANSACAO';
  end;

  Result.Campos := TmCampos.Create;
  with Result.Campos do begin
    Add('Cd_Empresa', 'CD_EMPRESA', tfKey);
    Add('Dt_Movimento', 'DT_MOVIMENTO', tfKey);
    Add('Nr_Seq', 'NR_SEQ', tfKey);
    Add('U_Version', 'U_VERSION', tfNul);
    Add('Cd_Operador', 'CD_OPERADOR', tfReq);
    Add('Dt_Cadastro', 'DT_CADASTRO', tfReq);
    Add('Cd_Arquivo', 'CD_ARQUIVO', tfReq);
    Add('Tp_Tef', 'TP_TEF', tfReq);
    Add('Tp_Situacao', 'TP_SITUACAO', tfReq);
    Add('Tp_Transacao', 'TP_TRANSACAO', tfNul);
    Add('Cd_Redetef', 'CD_REDETEF', tfNul);
    Add('Vl_Transacao', 'VL_TRANSACAO', tfNul);
    Add('Hr_Transacao', 'HR_TRANSACAO', tfNul);
    Add('Dt_Transacao', 'DT_TRANSACAO', tfNul);
    Add('Nr_Nsu', 'NR_NSU', tfNul);
    Add('Cd_Terminal', 'CD_TERMINAL', tfNul);
    Add('Nr_Docvinc', 'NR_DOCVINC', tfNul);
    Add('Nr_Nsuaux', 'NR_NSUAUX', tfNul);
    Add('Cd_Autorizacao', 'CD_AUTORIZACAO', tfNul);
    Add('Nm_Redetef', 'NM_REDETEF', tfNul);
    Add('Tp_Status', 'TP_STATUS', tfNul);
    Add('Ds_Finalizacao', 'DS_FINALIZACAO', tfNul);
    Add('Ds_Mensagem', 'DS_MENSAGEM', tfNul);
    Add('Nr_Linhascupom', 'NR_LINHASCUPOM', tfNul);
    Add('Ds_Cupom', 'DS_CUPOM', tfNul);
  end;

  Result.Relacoes := TmRelacoes.Create;
  with Result.Relacoes do begin
  end;
end;

//--

{ TTef_Transacaos }

function TTef_Transacaos.Add: TTef_Transacao;
begin
  Result := TTef_Transacao.Create(nil);
  Self.Add(Result);
end;

end.