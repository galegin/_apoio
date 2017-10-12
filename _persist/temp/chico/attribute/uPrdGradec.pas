unit uPrdGradec;

interface

uses
  Classes, SysUtils,
  System.Generics.Collections,
  mMapping;

type
  [Tabela('PRD_GRADEC')]
  TPrd_Gradec = class(TmMapping)
  private
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
  published
    [Campo('CD_GRADE', tfKey)]
    property Cd_Grade : String read fCd_Grade write fCd_Grade;
    [Campo('U_VERSION', tfNul)]
    property U_Version : String read fU_Version write fU_Version;
    [Campo('CD_OPERADOR', tfReq)]
    property Cd_Operador : String read fCd_Operador write fCd_Operador;
    [Campo('DT_CADASTRO', tfReq)]
    property Dt_Cadastro : String read fDt_Cadastro write fDt_Cadastro;
    [Campo('DS_GRADE', tfReq)]
    property Ds_Grade : String read fDs_Grade write fDs_Grade;
  end;

  TPrd_Gradecs = class(TList<Prd_Gradec>);

implementation

{ TPrd_Gradec }

constructor TPrd_Gradec.Create(AOwner: TComponent);
begin
  inherited;

end;

destructor TPrd_Gradec.Destroy;
begin

  inherited;
end;

end.