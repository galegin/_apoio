unit uFisAliquotaicmsuf;

interface

uses
  Classes, SysUtils,
  System.Generics.Collections,
  mMapping;

type
  [Tabela('FIS_ALIQUOTAICMSUF')]
  TFis_Aliquotaicmsuf = class(TmMapping)
  private
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
  published
    [Campo('CD_UFORIGEM', tfKey)]
    property Cd_Uforigem : String read fCd_Uforigem write fCd_Uforigem;
    [Campo('CD_UFDESTINO', tfKey)]
    property Cd_Ufdestino : String read fCd_Ufdestino write fCd_Ufdestino;
    [Campo('U_VERSION', tfNul)]
    property U_Version : String read fU_Version write fU_Version;
    [Campo('PR_ALIQICMS', tfReq)]
    property Pr_Aliqicms : String read fPr_Aliqicms write fPr_Aliqicms;
    [Campo('CD_OPERADOR', tfReq)]
    property Cd_Operador : String read fCd_Operador write fCd_Operador;
    [Campo('DT_CADASTRO', tfReq)]
    property Dt_Cadastro : String read fDt_Cadastro write fDt_Cadastro;
  end;

  TFis_Aliquotaicmsufs = class(TList<Fis_Aliquotaicmsuf>);

implementation

{ TFis_Aliquotaicmsuf }

constructor TFis_Aliquotaicmsuf.Create(AOwner: TComponent);
begin
  inherited;

end;

destructor TFis_Aliquotaicmsuf.Destroy;
begin

  inherited;
end;

end.