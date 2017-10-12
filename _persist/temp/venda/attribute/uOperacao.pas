unit uOperacao;

interface

uses
  Classes, SysUtils,
  System.Generics.Collections,
  mMapping;

type
  [Tabela('OPERACAO')]
  TOperacao = class(TmMapping)
  private
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
  published
    [Campo('ID_OPERACAO', tfKey)]
    property Id_Operacao : String read fId_Operacao write fId_Operacao;
    [Campo('U_VERSION', tfNul)]
    property U_Version : String read fU_Version write fU_Version;
    [Campo('CD_OPERADOR', tfReq)]
    property Cd_Operador : Integer read fCd_Operador write fCd_Operador;
    [Campo('DT_CADASTRO', tfReq)]
    property Dt_Cadastro : String read fDt_Cadastro write fDt_Cadastro;
    [Campo('DS_OPERACAO', tfReq)]
    property Ds_Operacao : String read fDs_Operacao write fDs_Operacao;
    [Campo('TP_MODELONF', tfReq)]
    property Tp_Modelonf : Integer read fTp_Modelonf write fTp_Modelonf;
    [Campo('TP_MODALIDADE', tfReq)]
    property Tp_Modalidade : Integer read fTp_Modalidade write fTp_Modalidade;
    [Campo('TP_OPERACAO', tfReq)]
    property Tp_Operacao : Integer read fTp_Operacao write fTp_Operacao;
    [Campo('CD_SERIE', tfReq)]
    property Cd_Serie : String read fCd_Serie write fCd_Serie;
    [Campo('CD_CFOP', tfReq)]
    property Cd_Cfop : Integer read fCd_Cfop write fCd_Cfop;
    [Campo('ID_REGRAFISCAL', tfReq)]
    property Id_Regrafiscal : Integer read fId_Regrafiscal write fId_Regrafiscal;
  end;

  TOperacaos = class(TList<Operacao>);

implementation

{ TOperacao }

constructor TOperacao.Create(AOwner: TComponent);
begin
  inherited;

end;

destructor TOperacao.Destroy;
begin

  inherited;
end;

end.