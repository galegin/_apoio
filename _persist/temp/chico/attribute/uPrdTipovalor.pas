unit uPrdTipovalor;

interface

uses
  Classes, SysUtils,
  System.Generics.Collections,
  mMapping;

type
  [Tabela('PRD_TIPOVALOR')]
  TPrd_Tipovalor = class(TmMapping)
  private
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
  published
    [Campo('TP_VALOR', tfKey)]
    property Tp_Valor : String read fTp_Valor write fTp_Valor;
    [Campo('CD_VALOR', tfKey)]
    property Cd_Valor : String read fCd_Valor write fCd_Valor;
    [Campo('U_VERSION', tfNul)]
    property U_Version : String read fU_Version write fU_Version;
    [Campo('CD_MOEDA', tfReq)]
    property Cd_Moeda : String read fCd_Moeda write fCd_Moeda;
    [Campo('CD_OPERADOR', tfReq)]
    property Cd_Operador : String read fCd_Operador write fCd_Operador;
    [Campo('DT_CADASTRO', tfReq)]
    property Dt_Cadastro : String read fDt_Cadastro write fDt_Cadastro;
    [Campo('DS_VALOR', tfReq)]
    property Ds_Valor : String read fDs_Valor write fDs_Valor;
  end;

  TPrd_Tipovalors = class(TList<Prd_Tipovalor>);

implementation

{ TPrd_Tipovalor }

constructor TPrd_Tipovalor.Create(AOwner: TComponent);
begin
  inherited;

end;

destructor TPrd_Tipovalor.Destroy;
begin

  inherited;
end;

end.