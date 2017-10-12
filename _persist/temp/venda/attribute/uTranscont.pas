unit uTranscont;

interface

uses
  Classes, SysUtils,
  System.Generics.Collections,
  mMapping;

type
  [Tabela('TRANSCONT')]
  TTranscont = class(TmMapping)
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
    [Campo('TP_SITUACAO', tfReq)]
    property Tp_Situacao : Integer read fTp_Situacao write fTp_Situacao;
    [Campo('CD_TERMINAL', tfReq)]
    property Cd_Terminal : Integer read fCd_Terminal write fCd_Terminal;
  end;

  TTransconts = class(TList<Transcont>);

implementation

{ TTranscont }

constructor TTranscont.Create(AOwner: TComponent);
begin
  inherited;

end;

destructor TTranscont.Destroy;
begin

  inherited;
end;

end.