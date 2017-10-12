unit uTransacao;

interface

uses
  Classes, SysUtils,
  System.Generics.Collections,
  mMapping;

type
  [Tabela('TRANSACAO')]
  TTransacao = class(TmMapping)
  private
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
  published
    [Campo('ID_TRANSACAO', tfKey)]
    property Id_Transacao : String read fId_Transacao write fId_Transacao;
    [Campo('U_VERSION', tfNul)]
    property U_Version : String read fU_Version write fU_Version;
    [Campo('CD_OPERADOR', tfReq)]
    property Cd_Operador : Integer read fCd_Operador write fCd_Operador;
    [Campo('DT_CADASTRO', tfReq)]
    property Dt_Cadastro : String read fDt_Cadastro write fDt_Cadastro;
    [Campo('ID_EMPRESA', tfReq)]
    property Id_Empresa : Integer read fId_Empresa write fId_Empresa;
    [Campo('ID_PESSOA', tfReq)]
    property Id_Pessoa : String read fId_Pessoa write fId_Pessoa;
    [Campo('ID_OPERACAO', tfReq)]
    property Id_Operacao : String read fId_Operacao write fId_Operacao;
    [Campo('DT_TRANSACAO', tfReq)]
    property Dt_Transacao : String read fDt_Transacao write fDt_Transacao;
    [Campo('NR_TRANSACAO', tfReq)]
    property Nr_Transacao : Integer read fNr_Transacao write fNr_Transacao;
    [Campo('TP_SITUACAO', tfReq)]
    property Tp_Situacao : Integer read fTp_Situacao write fTp_Situacao;
    [Campo('DT_CANCELAMENTO', tfNul)]
    property Dt_Cancelamento : String read fDt_Cancelamento write fDt_Cancelamento;
  end;

  TTransacaos = class(TList<Transacao>);

implementation

{ TTransacao }

constructor TTransacao.Create(AOwner: TComponent);
begin
  inherited;

end;

destructor TTransacao.Destroy;
begin

  inherited;
end;

end.