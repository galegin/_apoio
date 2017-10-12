unit uPrdCodigobarra;

interface

uses
  Classes, SysUtils,
  System.Generics.Collections,
  mMapping;

type
  [Tabela('PRD_CODIGOBARRA')]
  TPrd_Codigobarra = class(TmMapping)
  private
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
  published
    [Campo('CD_BARRAPRD', tfKey)]
    property Cd_Barraprd : String read fCd_Barraprd write fCd_Barraprd;
    [Campo('U_VERSION', tfNul)]
    property U_Version : String read fU_Version write fU_Version;
    [Campo('CD_PRODUTO', tfReq)]
    property Cd_Produto : String read fCd_Produto write fCd_Produto;
    [Campo('QT_EMBALAGEM', tfReq)]
    property Qt_Embalagem : String read fQt_Embalagem write fQt_Embalagem;
    [Campo('CD_OPERADOR', tfReq)]
    property Cd_Operador : String read fCd_Operador write fCd_Operador;
    [Campo('DT_CADASTRO', tfReq)]
    property Dt_Cadastro : String read fDt_Cadastro write fDt_Cadastro;
    [Campo('IN_PADRAO', tfNul)]
    property In_Padrao : String read fIn_Padrao write fIn_Padrao;
    [Campo('TP_BARRA', tfNul)]
    property Tp_Barra : String read fTp_Barra write fTp_Barra;
  end;

  TPrd_Codigobarras = class(TList<Prd_Codigobarra>);

implementation

{ TPrd_Codigobarra }

constructor TPrd_Codigobarra.Create(AOwner: TComponent);
begin
  inherited;

end;

destructor TPrd_Codigobarra.Destroy;
begin

  inherited;
end;

end.