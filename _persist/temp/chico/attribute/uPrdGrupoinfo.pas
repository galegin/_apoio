unit uPrdGrupoinfo;

interface

uses
  Classes, SysUtils,
  System.Generics.Collections,
  mMapping;

type
  [Tabela('PRD_GRUPOINFO')]
  TPrd_Grupoinfo = class(TmMapping)
  private
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
  published
    [Campo('CD_EMPRESA', tfKey)]
    property Cd_Empresa : String read fCd_Empresa write fCd_Empresa;
    [Campo('CD_SEQGRUPO', tfKey)]
    property Cd_Seqgrupo : String read fCd_Seqgrupo write fCd_Seqgrupo;
    [Campo('U_VERSION', tfNul)]
    property U_Version : String read fU_Version write fU_Version;
    [Campo('CD_OPERADOR', tfReq)]
    property Cd_Operador : String read fCd_Operador write fCd_Operador;
    [Campo('DT_CADASTRO', tfReq)]
    property Dt_Cadastro : String read fDt_Cadastro write fDt_Cadastro;
    [Campo('PR_MARKUP', tfNul)]
    property Pr_Markup : String read fPr_Markup write fPr_Markup;
    [Campo('PR_COMISSAO', tfNul)]
    property Pr_Comissao : String read fPr_Comissao write fPr_Comissao;
    [Campo('IN_PRODPROPRIA', tfNul)]
    property In_Prodpropria : String read fIn_Prodpropria write fIn_Prodpropria;
    [Campo('IN_INATIVO', tfNul)]
    property In_Inativo : String read fIn_Inativo write fIn_Inativo;
    [Campo('IN_PRODACABADO', tfNul)]
    property In_Prodacabado : String read fIn_Prodacabado write fIn_Prodacabado;
    [Campo('IN_MATPRIMA', tfNul)]
    property In_Matprima : String read fIn_Matprima write fIn_Matprima;
    [Campo('IN_MATCONSUMO', tfNul)]
    property In_Matconsumo : String read fIn_Matconsumo write fIn_Matconsumo;
    [Campo('IN_PATRIMONIO', tfNul)]
    property In_Patrimonio : String read fIn_Patrimonio write fIn_Patrimonio;
  end;

  TPrd_Grupoinfos = class(TList<Prd_Grupoinfo>);

implementation

{ TPrd_Grupoinfo }

constructor TPrd_Grupoinfo.Create(AOwner: TComponent);
begin
  inherited;

end;

destructor TPrd_Grupoinfo.Destroy;
begin

  inherited;
end;

end.