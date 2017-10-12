unit uPrdGradei;

interface

uses
  Classes, SysUtils,
  System.Generics.Collections,
  mMapping;

type
  [Tabela('PRD_GRADEI')]
  TPrd_Gradei = class(TmMapping)
  private
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
  published
    [Campo('CD_GRADE', tfKey)]
    property Cd_Grade : String read fCd_Grade write fCd_Grade;
    [Campo('CD_TAMANHO', tfKey)]
    property Cd_Tamanho : String read fCd_Tamanho write fCd_Tamanho;
    [Campo('U_VERSION', tfNul)]
    property U_Version : String read fU_Version write fU_Version;
    [Campo('CD_OPERADOR', tfReq)]
    property Cd_Operador : String read fCd_Operador write fCd_Operador;
    [Campo('DT_CADASTRO', tfReq)]
    property Dt_Cadastro : String read fDt_Cadastro write fDt_Cadastro;
    [Campo('DS_TAMANHO', tfReq)]
    property Ds_Tamanho : String read fDs_Tamanho write fDs_Tamanho;
  end;

  TPrd_Gradeis = class(TList<Prd_Gradei>);

implementation

{ TPrd_Gradei }

constructor TPrd_Gradei.Create(AOwner: TComponent);
begin
  inherited;

end;

destructor TPrd_Gradei.Destroy;
begin

  inherited;
end;

end.