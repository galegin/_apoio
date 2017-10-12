unit uPrdPrdgrade;

interface

uses
  Classes, SysUtils,
  System.Generics.Collections,
  mMapping;

type
  [Tabela('PRD_PRDGRADE')]
  TPrd_Prdgrade = class(TmMapping)
  private
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
  published
    [Campo('CD_SEQGRUPO', tfKey)]
    property Cd_Seqgrupo : String read fCd_Seqgrupo write fCd_Seqgrupo;
    [Campo('CD_COR', tfKey)]
    property Cd_Cor : String read fCd_Cor write fCd_Cor;
    [Campo('CD_TAMANHO', tfKey)]
    property Cd_Tamanho : String read fCd_Tamanho write fCd_Tamanho;
    [Campo('U_VERSION', tfNul)]
    property U_Version : String read fU_Version write fU_Version;
    [Campo('CD_PRODUTO', tfReq)]
    property Cd_Produto : String read fCd_Produto write fCd_Produto;
    [Campo('CD_OPERADOR', tfReq)]
    property Cd_Operador : String read fCd_Operador write fCd_Operador;
    [Campo('DT_CADASTRO', tfReq)]
    property Dt_Cadastro : String read fDt_Cadastro write fDt_Cadastro;
  end;

  TPrd_Prdgrades = class(TList<Prd_Prdgrade>);

implementation

{ TPrd_Prdgrade }

constructor TPrd_Prdgrade.Create(AOwner: TComponent);
begin
  inherited;

end;

destructor TPrd_Prdgrade.Destroy;
begin

  inherited;
end;

end.