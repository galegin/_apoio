unit uFisNfe;

interface

uses
  Classes, SysUtils,
  System.Generics.Collections,
  mMapping;

type
  [Tabela('FIS_NFE')]
  TFis_Nfe = class(TmMapping)
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
    [Campo('DS_CHAVEACESSO', tfReq)]
    property Ds_Chaveacesso : String read fDs_Chaveacesso write fDs_Chaveacesso;
    [Campo('TP_PROCESSAMENTO', tfNul)]
    property Tp_Processamento : String read fTp_Processamento write fTp_Processamento;
    [Campo('NR_RECIBO', tfNul)]
    property Nr_Recibo : String read fNr_Recibo write fNr_Recibo;
    [Campo('DT_RECEBIMENTO', tfNul)]
    property Dt_Recebimento : String read fDt_Recebimento write fDt_Recebimento;
  end;

  TFis_Nfes = class(TList<Fis_Nfe>);

implementation

{ TFis_Nfe }

constructor TFis_Nfe.Create(AOwner: TComponent);
begin
  inherited;

end;

destructor TFis_Nfe.Destroy;
begin

  inherited;
end;

end.