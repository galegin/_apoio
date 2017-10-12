unit uPrdPromocao;

interface

uses
  Classes, SysUtils,
  System.Generics.Collections,
  mMapping;

type
  [Tabela('PRD_PROMOCAO')]
  TPrd_Promocao = class(TmMapping)
  private
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
  published
    [Campo('CD_EMPRESA', tfKey)]
    property Cd_Empresa : String read fCd_Empresa write fCd_Empresa;
    [Campo('CD_PROMOCAO', tfKey)]
    property Cd_Promocao : String read fCd_Promocao write fCd_Promocao;
    [Campo('U_VERSION', tfNul)]
    property U_Version : String read fU_Version write fU_Version;
    [Campo('DS_PROMOCAO', tfReq)]
    property Ds_Promocao : String read fDs_Promocao write fDs_Promocao;
    [Campo('TP_SITUACAO', tfReq)]
    property Tp_Situacao : String read fTp_Situacao write fTp_Situacao;
    [Campo('TP_VALOR', tfReq)]
    property Tp_Valor : String read fTp_Valor write fTp_Valor;
    [Campo('CD_VALOR', tfReq)]
    property Cd_Valor : String read fCd_Valor write fCd_Valor;
    [Campo('DT_INICIO', tfReq)]
    property Dt_Inicio : String read fDt_Inicio write fDt_Inicio;
    [Campo('DT_FINAL', tfReq)]
    property Dt_Final : String read fDt_Final write fDt_Final;
    [Campo('CD_OPERADOR', tfReq)]
    property Cd_Operador : String read fCd_Operador write fCd_Operador;
    [Campo('DT_CADASTRO', tfReq)]
    property Dt_Cadastro : String read fDt_Cadastro write fDt_Cadastro;
    [Campo('NR_PRAZOMEDIO', tfNul)]
    property Nr_Prazomedio : String read fNr_Prazomedio write fNr_Prazomedio;
  end;

  TPrd_Promocaos = class(TList<Prd_Promocao>);

implementation

{ TPrd_Promocao }

constructor TPrd_Promocao.Create(AOwner: TComponent);
begin
  inherited;

end;

destructor TPrd_Promocao.Destroy;
begin

  inherited;
end;

end.