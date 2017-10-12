unit uPesEmpclidesc;

interface

uses
  Classes, SysUtils,
  System.Generics.Collections,
  mMapping;

type
  [Tabela('PES_EMPCLIDESC')]
  TPes_Empclidesc = class(TmMapping)
  private
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
  published
    [Campo('CD_EMPRESA', tfKey)]
    property Cd_Empresa : String read fCd_Empresa write fCd_Empresa;
    [Campo('CD_CLIENTE', tfKey)]
    property Cd_Cliente : String read fCd_Cliente write fCd_Cliente;
    [Campo('U_VERSION', tfNul)]
    property U_Version : String read fU_Version write fU_Version;
    [Campo('CD_OPERADOR', tfReq)]
    property Cd_Operador : String read fCd_Operador write fCd_Operador;
    [Campo('DT_CADASTRO', tfReq)]
    property Dt_Cadastro : String read fDt_Cadastro write fDt_Cadastro;
    [Campo('PR_DESCMAX', tfNul)]
    property Pr_Descmax : String read fPr_Descmax write fPr_Descmax;
  end;

  TPes_Empclidescs = class(TList<Pes_Empclidesc>);

implementation

{ TPes_Empclidesc }

constructor TPes_Empclidesc.Create(AOwner: TComponent);
begin
  inherited;

end;

destructor TPes_Empclidesc.Destroy;
begin

  inherited;
end;

end.