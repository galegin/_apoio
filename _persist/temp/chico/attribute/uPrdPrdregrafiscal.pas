unit uPrdPrdregrafiscal;

interface

uses
  Classes, SysUtils,
  System.Generics.Collections,
  mMapping;

type
  [Tabela('PRD_PRDREGRAFISCAL')]
  TPrd_Prdregrafiscal = class(TmMapping)
  private
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
  published
    [Campo('CD_PRODUTO', tfKey)]
    property Cd_Produto : String read fCd_Produto write fCd_Produto;
    [Campo('CD_OPERACAO', tfKey)]
    property Cd_Operacao : String read fCd_Operacao write fCd_Operacao;
    [Campo('U_VERSION', tfNul)]
    property U_Version : String read fU_Version write fU_Version;
    [Campo('CD_REGRAFISCAL', tfReq)]
    property Cd_Regrafiscal : String read fCd_Regrafiscal write fCd_Regrafiscal;
    [Campo('CD_OPERADOR', tfReq)]
    property Cd_Operador : String read fCd_Operador write fCd_Operador;
    [Campo('DT_CADASTRO', tfReq)]
    property Dt_Cadastro : String read fDt_Cadastro write fDt_Cadastro;
  end;

  TPrd_Prdregrafiscals = class(TList<Prd_Prdregrafiscal>);

implementation

{ TPrd_Prdregrafiscal }

constructor TPrd_Prdregrafiscal.Create(AOwner: TComponent);
begin
  inherited;

end;

destructor TPrd_Prdregrafiscal.Destroy;
begin

  inherited;
end;

end.