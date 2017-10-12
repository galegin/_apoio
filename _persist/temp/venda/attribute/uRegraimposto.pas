unit uRegraimposto;

interface

uses
  Classes, SysUtils,
  System.Generics.Collections,
  mMapping;

type
  [Tabela('REGRAIMPOSTO')]
  TRegraimposto = class(TmMapping)
  private
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
  published
    [Campo('ID_REGRAFISCAL', tfKey)]
    property Id_Regrafiscal : Integer read fId_Regrafiscal write fId_Regrafiscal;
    [Campo('CD_IMPOSTO', tfKey)]
    property Cd_Imposto : Integer read fCd_Imposto write fCd_Imposto;
    [Campo('U_VERSION', tfNul)]
    property U_Version : String read fU_Version write fU_Version;
    [Campo('CD_OPERADOR', tfReq)]
    property Cd_Operador : Integer read fCd_Operador write fCd_Operador;
    [Campo('DT_CADASTRO', tfReq)]
    property Dt_Cadastro : String read fDt_Cadastro write fDt_Cadastro;
    [Campo('PR_ALIQUOTA', tfReq)]
    property Pr_Aliquota : String read fPr_Aliquota write fPr_Aliquota;
    [Campo('PR_BASECALCULO', tfReq)]
    property Pr_Basecalculo : String read fPr_Basecalculo write fPr_Basecalculo;
    [Campo('CD_CST', tfReq)]
    property Cd_Cst : String read fCd_Cst write fCd_Cst;
    [Campo('CD_CSOSN', tfNul)]
    property Cd_Csosn : String read fCd_Csosn write fCd_Csosn;
    [Campo('IN_ISENTO', tfReq)]
    property In_Isento : String read fIn_Isento write fIn_Isento;
    [Campo('IN_OUTRO', tfReq)]
    property In_Outro : String read fIn_Outro write fIn_Outro;
  end;

  TRegraimpostos = class(TList<Regraimposto>);

implementation

{ TRegraimposto }

constructor TRegraimposto.Create(AOwner: TComponent);
begin
  inherited;

end;

destructor TRegraimposto.Destroy;
begin

  inherited;
end;

end.