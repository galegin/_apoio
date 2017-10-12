unit uFisNfeinut;

interface

uses
  Classes, SysUtils,
  System.Generics.Collections,
  mMapping;

type
  [Tabela('FIS_NFEINUT')]
  TFis_Nfeinut = class(TmMapping)
  private
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
  published
    [Campo('CD_EMPRESA', tfKey)]
    property Cd_Empresa : String read fCd_Empresa write fCd_Empresa;
    [Campo('NR_FATURA', tfKey)]
    property Nr_Fatura : String read fNr_Fatura write fNr_Fatura;
    [Campo('DT_FATURA', tfKey)]
    property Dt_Fatura : String read fDt_Fatura write fDt_Fatura;
    [Campo('U_VERSION', tfNul)]
    property U_Version : String read fU_Version write fU_Version;
    [Campo('CD_OPERADOR', tfReq)]
    property Cd_Operador : String read fCd_Operador write fCd_Operador;
    [Campo('DT_CADASTRO', tfReq)]
    property Dt_Cadastro : String read fDt_Cadastro write fDt_Cadastro;
    [Campo('TP_MODDOCTOFISCAL', tfReq)]
    property Tp_Moddoctofiscal : String read fTp_Moddoctofiscal write fTp_Moddoctofiscal;
    [Campo('CD_SERIE', tfReq)]
    property Cd_Serie : String read fCd_Serie write fCd_Serie;
    [Campo('NR_NF', tfReq)]
    property Nr_Nf : String read fNr_Nf write fNr_Nf;
    [Campo('DT_RECEBIMENTO', tfReq)]
    property Dt_Recebimento : String read fDt_Recebimento write fDt_Recebimento;
    [Campo('NR_RECIBO', tfReq)]
    property Nr_Recibo : String read fNr_Recibo write fNr_Recibo;
  end;

  TFis_Nfeinuts = class(TList<Fis_Nfeinut>);

implementation

{ TFis_Nfeinut }

constructor TFis_Nfeinut.Create(AOwner: TComponent);
begin
  inherited;

end;

destructor TFis_Nfeinut.Destroy;
begin

  inherited;
end;

end.