unit uTefReltransacao;

interface

uses
  Classes, SysUtils,
  System.Generics.Collections,
  mMapping;

type
  [Tabela('TEF_RELTRANSACAO')]
  TTef_Reltransacao = class(TmMapping)
  private
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
  published
    [Campo('CD_EMPTEF', tfKey)]
    property Cd_Emptef : String read fCd_Emptef write fCd_Emptef;
    [Campo('DT_MOVIMENTO', tfKey)]
    property Dt_Movimento : String read fDt_Movimento write fDt_Movimento;
    [Campo('NR_SEQ', tfKey)]
    property Nr_Seq : String read fNr_Seq write fNr_Seq;
    [Campo('CD_EMPTRA', tfKey)]
    property Cd_Emptra : String read fCd_Emptra write fCd_Emptra;
    [Campo('NR_TRANSACAO', tfKey)]
    property Nr_Transacao : String read fNr_Transacao write fNr_Transacao;
    [Campo('DT_TRANSACAO', tfKey)]
    property Dt_Transacao : String read fDt_Transacao write fDt_Transacao;
    [Campo('U_VERSION', tfNul)]
    property U_Version : String read fU_Version write fU_Version;
    [Campo('CD_OPERADOR', tfReq)]
    property Cd_Operador : String read fCd_Operador write fCd_Operador;
    [Campo('DT_CADASTRO', tfReq)]
    property Dt_Cadastro : String read fDt_Cadastro write fDt_Cadastro;
  end;

  TTef_Reltransacaos = class(TList<Tef_Reltransacao>);

implementation

{ TTef_Reltransacao }

constructor TTef_Reltransacao.Create(AOwner: TComponent);
begin
  inherited;

end;

destructor TTef_Reltransacao.Destroy;
begin

  inherited;
end;

end.