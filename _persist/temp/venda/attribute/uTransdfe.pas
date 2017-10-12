unit uTransdfe;

interface

uses
  Classes, SysUtils,
  System.Generics.Collections,
  mMapping;

type
  [Tabela('TRANSDFE')]
  TTransdfe = class(TmMapping)
  private
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
  published
    [Campo('ID_TRANSACAO', tfKey)]
    property Id_Transacao : String read fId_Transacao write fId_Transacao;
    [Campo('NR_SEQUENCIA', tfKey)]
    property Nr_Sequencia : Integer read fNr_Sequencia write fNr_Sequencia;
    [Campo('U_VERSION', tfNul)]
    property U_Version : String read fU_Version write fU_Version;
    [Campo('CD_OPERADOR', tfReq)]
    property Cd_Operador : Integer read fCd_Operador write fCd_Operador;
    [Campo('DT_CADASTRO', tfReq)]
    property Dt_Cadastro : String read fDt_Cadastro write fDt_Cadastro;
    [Campo('TP_EVENTO', tfReq)]
    property Tp_Evento : Integer read fTp_Evento write fTp_Evento;
    [Campo('TP_AMBIENTE', tfReq)]
    property Tp_Ambiente : Integer read fTp_Ambiente write fTp_Ambiente;
    [Campo('TP_EMISSAO', tfReq)]
    property Tp_Emissao : Integer read fTp_Emissao write fTp_Emissao;
    [Campo('DS_ENVIOXML', tfReq)]
    property Ds_Envioxml : String read fDs_Envioxml write fDs_Envioxml;
    [Campo('DS_RETORNOXML', tfNul)]
    property Ds_Retornoxml : String read fDs_Retornoxml write fDs_Retornoxml;
  end;

  TTransdfes = class(TList<Transdfe>);

implementation

{ TTransdfe }

constructor TTransdfe.Create(AOwner: TComponent);
begin
  inherited;

end;

destructor TTransdfe.Destroy;
begin

  inherited;
end;

end.