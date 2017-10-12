unit uAliqicms;

interface

uses
  Classes, SysUtils,
  System.Generics.Collections,
  mMapping;

type
  [Tabela('ALIQICMS')]
  TAliqicms = class(TmMapping)
  private
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
  published
    [Campo('UF_ORIGEM', tfKey)]
    property Uf_Origem : String read fUf_Origem write fUf_Origem;
    [Campo('UF_DESTINO', tfKey)]
    property Uf_Destino : String read fUf_Destino write fUf_Destino;
    [Campo('U_VERSION', tfNul)]
    property U_Version : String read fU_Version write fU_Version;
    [Campo('CD_OPERADOR', tfReq)]
    property Cd_Operador : Integer read fCd_Operador write fCd_Operador;
    [Campo('DT_CADASTRO', tfReq)]
    property Dt_Cadastro : String read fDt_Cadastro write fDt_Cadastro;
    [Campo('PR_ALIQUOTA', tfReq)]
    property Pr_Aliquota : String read fPr_Aliquota write fPr_Aliquota;
  end;

  TAliqicmss = class(TList<Aliqicms>);

implementation

{ TAliqicms }

constructor TAliqicms.Create(AOwner: TComponent);
begin
  inherited;

end;

destructor TAliqicms.Destroy;
begin

  inherited;
end;

end.