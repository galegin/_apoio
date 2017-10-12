unit uPrdPromocaoitem;

interface

uses
  Classes, SysUtils,
  System.Generics.Collections,
  mMapping;

type
  [Tabela('PRD_PROMOCAOITEM')]
  TPrd_Promocaoitem = class(TmMapping)
  private
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
  published
    [Campo('CD_EMPRESA', tfKey)]
    property Cd_Empresa : String read fCd_Empresa write fCd_Empresa;
    [Campo('CD_PROMOCAO', tfKey)]
    property Cd_Promocao : String read fCd_Promocao write fCd_Promocao;
    [Campo('CD_PRODUTO', tfKey)]
    property Cd_Produto : String read fCd_Produto write fCd_Produto;
    [Campo('U_VERSION', tfNul)]
    property U_Version : String read fU_Version write fU_Version;
    [Campo('VL_ANTERIOR', tfNul)]
    property Vl_Anterior : String read fVl_Anterior write fVl_Anterior;
    [Campo('VL_PROMOCAO', tfNul)]
    property Vl_Promocao : String read fVl_Promocao write fVl_Promocao;
    [Campo('CD_OPERADOR', tfReq)]
    property Cd_Operador : String read fCd_Operador write fCd_Operador;
    [Campo('DT_CADASTRO', tfReq)]
    property Dt_Cadastro : String read fDt_Cadastro write fDt_Cadastro;
    [Campo('QT_PROMOVIDA', tfNul)]
    property Qt_Promovida : String read fQt_Promovida write fQt_Promovida;
    [Campo('QT_VENDIDA', tfNul)]
    property Qt_Vendida : String read fQt_Vendida write fQt_Vendida;
    [Campo('TP_SITUACAO', tfNul)]
    property Tp_Situacao : String read fTp_Situacao write fTp_Situacao;
  end;

  TPrd_Promocaoitems = class(TList<Prd_Promocaoitem>);

implementation

{ TPrd_Promocaoitem }

constructor TPrd_Promocaoitem.Create(AOwner: TComponent);
begin
  inherited;

end;

destructor TPrd_Promocaoitem.Destroy;
begin

  inherited;
end;

end.