unit uTraLimdesconto;

interface

uses
  Classes, SysUtils,
  System.Generics.Collections,
  mMapping;

type
  [Tabela('TRA_LIMDESCONTO')]
  TTra_Limdesconto = class(TmMapping)
  private
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
  published
    [Campo('CD_OPERACAO', tfKey)]
    property Cd_Operacao : String read fCd_Operacao write fCd_Operacao;
    [Campo('CD_USUARIO', tfKey)]
    property Cd_Usuario : String read fCd_Usuario write fCd_Usuario;
    [Campo('U_VERSION', tfNul)]
    property U_Version : String read fU_Version write fU_Version;
    [Campo('PR_DESCMAX', tfReq)]
    property Pr_Descmax : String read fPr_Descmax write fPr_Descmax;
    [Campo('CD_OPERADOR', tfReq)]
    property Cd_Operador : String read fCd_Operador write fCd_Operador;
    [Campo('DT_CADASTRO', tfReq)]
    property Dt_Cadastro : String read fDt_Cadastro write fDt_Cadastro;
  end;

  TTra_Limdescontos = class(TList<Tra_Limdesconto>);

implementation

{ TTra_Limdesconto }

constructor TTra_Limdesconto.Create(AOwner: TComponent);
begin
  inherited;

end;

destructor TTra_Limdesconto.Destroy;
begin

  inherited;
end;

end.