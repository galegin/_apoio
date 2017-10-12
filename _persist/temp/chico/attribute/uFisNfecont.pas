unit uFisNfecont;

interface

uses
  Classes, SysUtils,
  System.Generics.Collections,
  mMapping;

type
  [Tabela('FIS_NFECONT')]
  TFis_Nfecont = class(TmMapping)
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
    [Campo('TP_SITUACAO', tfReq)]
    property Tp_Situacao : String read fTp_Situacao write fTp_Situacao;
    [Campo('CD_TERMINAL', tfReq)]
    property Cd_Terminal : String read fCd_Terminal write fCd_Terminal;
  end;

  TFis_Nfeconts = class(TList<Fis_Nfecont>);

implementation

{ TFis_Nfecont }

constructor TFis_Nfecont.Create(AOwner: TComponent);
begin
  inherited;

end;

destructor TFis_Nfecont.Destroy;
begin

  inherited;
end;

end.