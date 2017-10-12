unit uObsTransacao;

interface

uses
  Classes, SysUtils,
  System.Generics.Collections,
  mMapping;

type
  [Tabela('OBS_TRANSACAO')]
  TObs_Transacao = class(TmMapping)
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
    [Campo('NR_LINHA', tfKey)]
    property Nr_Linha : String read fNr_Linha write fNr_Linha;
    [Campo('U_VERSION', tfNul)]
    property U_Version : String read fU_Version write fU_Version;
    [Campo('CD_OPERADOR', tfReq)]
    property Cd_Operador : String read fCd_Operador write fCd_Operador;
    [Campo('DT_CADASTRO', tfReq)]
    property Dt_Cadastro : String read fDt_Cadastro write fDt_Cadastro;
    [Campo('IN_MANUTENCAO', tfNul)]
    property In_Manutencao : String read fIn_Manutencao write fIn_Manutencao;
    [Campo('CD_COMPONENTE', tfNul)]
    property Cd_Componente : String read fCd_Componente write fCd_Componente;
    [Campo('DS_OBSERVACAO', tfNul)]
    property Ds_Observacao : String read fDs_Observacao write fDs_Observacao;
  end;

  TObs_Transacaos = class(TList<Obs_Transacao>);

implementation

{ TObs_Transacao }

constructor TObs_Transacao.Create(AOwner: TComponent);
begin
  inherited;

end;

destructor TObs_Transacao.Destroy;
begin

  inherited;
end;

end.