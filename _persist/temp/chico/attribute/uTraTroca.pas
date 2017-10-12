unit uTraTroca;

interface

uses
  Classes, SysUtils,
  System.Generics.Collections,
  mMapping;

type
  [Tabela('TRA_TROCA')]
  TTra_Troca = class(TmMapping)
  private
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
  published
    [Campo('CD_EMPDEV', tfKey)]
    property Cd_Empdev : String read fCd_Empdev write fCd_Empdev;
    [Campo('NR_TRADEV', tfKey)]
    property Nr_Tradev : String read fNr_Tradev write fNr_Tradev;
    [Campo('DT_TRADEV', tfKey)]
    property Dt_Tradev : String read fDt_Tradev write fDt_Tradev;
    [Campo('CD_EMPVEN', tfKey)]
    property Cd_Empven : String read fCd_Empven write fCd_Empven;
    [Campo('NR_TRAVEN', tfKey)]
    property Nr_Traven : String read fNr_Traven write fNr_Traven;
    [Campo('DT_TRAVEN', tfKey)]
    property Dt_Traven : String read fDt_Traven write fDt_Traven;
    [Campo('U_VERSION', tfNul)]
    property U_Version : String read fU_Version write fU_Version;
    [Campo('CD_EMPFATDEV', tfReq)]
    property Cd_Empfatdev : String read fCd_Empfatdev write fCd_Empfatdev;
    [Campo('CD_GRUPOEMPDEV', tfReq)]
    property Cd_Grupoempdev : String read fCd_Grupoempdev write fCd_Grupoempdev;
    [Campo('CD_EMPFATVEN', tfReq)]
    property Cd_Empfatven : String read fCd_Empfatven write fCd_Empfatven;
    [Campo('CD_GRUPOEMPVEN', tfReq)]
    property Cd_Grupoempven : String read fCd_Grupoempven write fCd_Grupoempven;
    [Campo('CD_OPERADOR', tfReq)]
    property Cd_Operador : String read fCd_Operador write fCd_Operador;
    [Campo('DT_CADASTRO', tfReq)]
    property Dt_Cadastro : String read fDt_Cadastro write fDt_Cadastro;
    [Campo('NR_DIFITEM', tfNul)]
    property Nr_Difitem : String read fNr_Difitem write fNr_Difitem;
    [Campo('QT_DIFPECAS', tfNul)]
    property Qt_Difpecas : String read fQt_Difpecas write fQt_Difpecas;
    [Campo('VL_DIFERENCA', tfNul)]
    property Vl_Diferenca : String read fVl_Diferenca write fVl_Diferenca;
  end;

  TTra_Trocas = class(TList<Tra_Troca>);

implementation

{ TTra_Troca }

constructor TTra_Troca.Create(AOwner: TComponent);
begin
  inherited;

end;

destructor TTra_Troca.Destroy;
begin

  inherited;
end;

end.