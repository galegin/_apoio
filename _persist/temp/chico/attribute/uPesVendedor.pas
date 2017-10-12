unit uPesVendedor;

interface

uses
  Classes, SysUtils,
  System.Generics.Collections,
  mMapping;

type
  [Tabela('PES_VENDEDOR')]
  TPes_Vendedor = class(TmMapping)
  private
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
  published
    [Campo('CD_VENDEDOR', tfKey)]
    property Cd_Vendedor : String read fCd_Vendedor write fCd_Vendedor;
    [Campo('U_VERSION', tfNul)]
    property U_Version : String read fU_Version write fU_Version;
    [Campo('CD_PESSOA', tfNul)]
    property Cd_Pessoa : String read fCd_Pessoa write fCd_Pessoa;
    [Campo('NM_VENDEDOR', tfReq)]
    property Nm_Vendedor : String read fNm_Vendedor write fNm_Vendedor;
    [Campo('CD_OPERADOR', tfReq)]
    property Cd_Operador : String read fCd_Operador write fCd_Operador;
    [Campo('DT_CADASTRO', tfReq)]
    property Dt_Cadastro : String read fDt_Cadastro write fDt_Cadastro;
  end;

  TPes_Vendedors = class(TList<Pes_Vendedor>);

implementation

{ TPes_Vendedor }

constructor TPes_Vendedor.Create(AOwner: TComponent);
begin
  inherited;

end;

destructor TPes_Vendedor.Destroy;
begin

  inherited;
end;

end.