unit uFisImposto;

interface

uses
  Classes, SysUtils,
  System.Generics.Collections,
  mMapping;

type
  [Tabela('FIS_IMPOSTO')]
  TFis_Imposto = class(TmMapping)
  private
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
  published
    [Campo('CD_IMPOSTO', tfKey)]
    property Cd_Imposto : String read fCd_Imposto write fCd_Imposto;
    [Campo('DT_INIVIGENCIA', tfKey)]
    property Dt_Inivigencia : String read fDt_Inivigencia write fDt_Inivigencia;
    [Campo('U_VERSION', tfNul)]
    property U_Version : String read fU_Version write fU_Version;
    [Campo('CD_OPERADOR', tfReq)]
    property Cd_Operador : String read fCd_Operador write fCd_Operador;
    [Campo('DT_CADASTRO', tfReq)]
    property Dt_Cadastro : String read fDt_Cadastro write fDt_Cadastro;
    [Campo('PR_ALIQUOTA', tfNul)]
    property Pr_Aliquota : String read fPr_Aliquota write fPr_Aliquota;
    [Campo('TP_SITUACAO', tfNul)]
    property Tp_Situacao : String read fTp_Situacao write fTp_Situacao;
  end;

  TFis_Impostos = class(TList<Fis_Imposto>);

implementation

{ TFis_Imposto }

constructor TFis_Imposto.Create(AOwner: TComponent);
begin
  inherited;

end;

destructor TFis_Imposto.Destroy;
begin

  inherited;
end;

end.