unit uTransfiscal;

interface

uses
  Classes, SysUtils,
  System.Generics.Collections,
  mMapping;

type
  [Tabela('TRANSFISCAL')]
  TTransfiscal = class(TmMapping)
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
    [Campo('TP_OPERACAO', tfReq)]
    property Tp_Operacao : Integer read fTp_Operacao write fTp_Operacao;
    [Campo('TP_MODALIDADE', tfReq)]
    property Tp_Modalidade : Integer read fTp_Modalidade write fTp_Modalidade;
    [Campo('TP_MODELONF', tfReq)]
    property Tp_Modelonf : Integer read fTp_Modelonf write fTp_Modelonf;
    [Campo('CD_SERIE', tfReq)]
    property Cd_Serie : String read fCd_Serie write fCd_Serie;
    [Campo('NR_NF', tfReq)]
    property Nr_Nf : Integer read fNr_Nf write fNr_Nf;
    [Campo('TP_PROCESSAMENTO', tfReq)]
    property Tp_Processamento : String read fTp_Processamento write fTp_Processamento;
    [Campo('DS_CHAVEACESSO', tfNul)]
    property Ds_Chaveacesso : String read fDs_Chaveacesso write fDs_Chaveacesso;
    [Campo('DT_RECEBIMENTO', tfNul)]
    property Dt_Recebimento : String read fDt_Recebimento write fDt_Recebimento;
    [Campo('NR_RECIBO', tfNul)]
    property Nr_Recibo : String read fNr_Recibo write fNr_Recibo;
  end;

  TTransfiscals = class(TList<Transfiscal>);

implementation

{ TTransfiscal }

constructor TTransfiscal.Create(AOwner: TComponent);
begin
  inherited;

end;

destructor TTransfiscal.Destroy;
begin

  inherited;
end;

end.