unit uPrdValor;

interface

uses
  Classes, SysUtils,
  System.Generics.Collections,
  mMapping;

type
  [Tabela('PRD_VALOR')]
  TPrd_Valor = class(TmMapping)
  private
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
  published
    [Campo('CD_EMPRESA', tfKey)]
    property Cd_Empresa : String read fCd_Empresa write fCd_Empresa;
    [Campo('CD_PRODUTO', tfKey)]
    property Cd_Produto : String read fCd_Produto write fCd_Produto;
    [Campo('TP_VALOR', tfKey)]
    property Tp_Valor : String read fTp_Valor write fTp_Valor;
    [Campo('CD_VALOR', tfKey)]
    property Cd_Valor : String read fCd_Valor write fCd_Valor;
    [Campo('U_VERSION', tfNul)]
    property U_Version : String read fU_Version write fU_Version;
    [Campo('CD_GRUPOEMPRESA', tfReq)]
    property Cd_Grupoempresa : String read fCd_Grupoempresa write fCd_Grupoempresa;
    [Campo('CD_OPERADOR', tfReq)]
    property Cd_Operador : String read fCd_Operador write fCd_Operador;
    [Campo('DT_CADASTRO', tfReq)]
    property Dt_Cadastro : String read fDt_Cadastro write fDt_Cadastro;
    [Campo('VL_PRODUTO', tfNul)]
    property Vl_Produto : String read fVl_Produto write fVl_Produto;
    [Campo('IN_BASEMARKUP', tfNul)]
    property In_Basemarkup : String read fIn_Basemarkup write fIn_Basemarkup;
  end;

  TPrd_Valors = class(TList<Prd_Valor>);

implementation

{ TPrd_Valor }

constructor TPrd_Valor.Create(AOwner: TComponent);
begin
  inherited;

end;

destructor TPrd_Valor.Destroy;
begin

  inherited;
end;

end.