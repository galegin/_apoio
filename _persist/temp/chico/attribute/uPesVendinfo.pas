unit uPesVendinfo;

interface

uses
  Classes, SysUtils,
  System.Generics.Collections,
  mMapping;

type
  [Tabela('PES_VENDINFO')]
  TPes_Vendinfo = class(TmMapping)
  private
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
  published
    [Campo('CD_EMPRESA', tfKey)]
    property Cd_Empresa : String read fCd_Empresa write fCd_Empresa;
    [Campo('CD_VENDEDOR', tfKey)]
    property Cd_Vendedor : String read fCd_Vendedor write fCd_Vendedor;
    [Campo('U_VERSION', tfNul)]
    property U_Version : String read fU_Version write fU_Version;
    [Campo('CD_OPERADOR', tfReq)]
    property Cd_Operador : String read fCd_Operador write fCd_Operador;
    [Campo('DT_CADASTRO', tfReq)]
    property Dt_Cadastro : String read fDt_Cadastro write fDt_Cadastro;
    [Campo('CD_AUXILIAR', tfReq)]
    property Cd_Auxiliar : String read fCd_Auxiliar write fCd_Auxiliar;
    [Campo('IN_INATIVO', tfNul)]
    property In_Inativo : String read fIn_Inativo write fIn_Inativo;
  end;

  TPes_Vendinfos = class(TList<Pes_Vendinfo>);

implementation

{ TPes_Vendinfo }

constructor TPes_Vendinfo.Create(AOwner: TComponent);
begin
  inherited;

end;

destructor TPes_Vendinfo.Destroy;
begin

  inherited;
end;

end.