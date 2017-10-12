unit uObsNffisco;

interface

uses
  Classes, SysUtils,
  System.Generics.Collections,
  mMapping;

type
  [Tabela('OBS_NFFISCO')]
  TObs_Nffisco = class(TmMapping)
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
    [Campo('NR_LINHA', tfKey)]
    property Nr_Linha : String read fNr_Linha write fNr_Linha;
    [Campo('U_VERSION', tfNul)]
    property U_Version : String read fU_Version write fU_Version;
    [Campo('CD_EMPFAT', tfReq)]
    property Cd_Empfat : String read fCd_Empfat write fCd_Empfat;
    [Campo('CD_GRUPOEMPRESA', tfReq)]
    property Cd_Grupoempresa : String read fCd_Grupoempresa write fCd_Grupoempresa;
    [Campo('CD_OPERADOR', tfReq)]
    property Cd_Operador : String read fCd_Operador write fCd_Operador;
    [Campo('DT_CADASTRO', tfReq)]
    property Dt_Cadastro : String read fDt_Cadastro write fDt_Cadastro;
    [Campo('DS_OBSERVACAO', tfNul)]
    property Ds_Observacao : String read fDs_Observacao write fDs_Observacao;
  end;

  TObs_Nffiscos = class(TList<Obs_Nffisco>);

implementation

{ TObs_Nffisco }

constructor TObs_Nffisco.Create(AOwner: TComponent);
begin
  inherited;

end;

destructor TObs_Nffisco.Destroy;
begin

  inherited;
end;

end.