unit uCfop;

interface

uses
  Classes, SysUtils,
  System.Generics.Collections,
  mMapping;

type
  [Tabela('CFOP')]
  TCfop = class(TmMapping)
  private
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
  published
    [Campo('CD_CFOP', tfKey)]
    property Cd_Cfop : Integer read fCd_Cfop write fCd_Cfop;
    [Campo('U_VERSION', tfNul)]
    property U_Version : String read fU_Version write fU_Version;
    [Campo('CD_OPERADOR', tfReq)]
    property Cd_Operador : Integer read fCd_Operador write fCd_Operador;
    [Campo('DT_CADASTRO', tfReq)]
    property Dt_Cadastro : String read fDt_Cadastro write fDt_Cadastro;
    [Campo('DS_CFOP', tfReq)]
    property Ds_Cfop : String read fDs_Cfop write fDs_Cfop;
  end;

  TCfops = class(TList<Cfop>);

implementation

{ TCfop }

constructor TCfop.Create(AOwner: TComponent);
begin
  inherited;

end;

destructor TCfop.Destroy;
begin

  inherited;
end;

end.