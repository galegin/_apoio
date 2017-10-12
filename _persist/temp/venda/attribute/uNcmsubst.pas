unit uNcmsubst;

interface

uses
  Classes, SysUtils,
  System.Generics.Collections,
  mMapping;

type
  [Tabela('NCMSUBST')]
  TNcmsubst = class(TmMapping)
  private
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
  published
    [Campo('UF_ORIGEM', tfKey)]
    property Uf_Origem : String read fUf_Origem write fUf_Origem;
    [Campo('UF_DESTINO', tfKey)]
    property Uf_Destino : String read fUf_Destino write fUf_Destino;
    [Campo('CD_NCM', tfKey)]
    property Cd_Ncm : String read fCd_Ncm write fCd_Ncm;
    [Campo('U_VERSION', tfNul)]
    property U_Version : String read fU_Version write fU_Version;
    [Campo('CD_OPERADOR', tfNul)]
    property Cd_Operador : Integer read fCd_Operador write fCd_Operador;
    [Campo('DT_CADASTRO', tfNul)]
    property Dt_Cadastro : String read fDt_Cadastro write fDt_Cadastro;
    [Campo('CD_CEST', tfNul)]
    property Cd_Cest : String read fCd_Cest write fCd_Cest;
  end;

  TNcmsubsts = class(TList<Ncmsubst>);

implementation

{ TNcmsubst }

constructor TNcmsubst.Create(AOwner: TComponent);
begin
  inherited;

end;

destructor TNcmsubst.Destroy;
begin

  inherited;
end;

end.