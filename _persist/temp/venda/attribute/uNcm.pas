unit uNcm;

interface

uses
  Classes, SysUtils,
  System.Generics.Collections,
  mMapping;

type
  [Tabela('NCM')]
  TNcm = class(TmMapping)
  private
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
  published
    [Campo('CD_NCM', tfKey)]
    property Cd_Ncm : String read fCd_Ncm write fCd_Ncm;
    [Campo('U_VERSION', tfNul)]
    property U_Version : String read fU_Version write fU_Version;
    [Campo('CD_OPERADOR', tfReq)]
    property Cd_Operador : Integer read fCd_Operador write fCd_Operador;
    [Campo('DT_CADASTRO', tfReq)]
    property Dt_Cadastro : String read fDt_Cadastro write fDt_Cadastro;
    [Campo('DS_NCM', tfReq)]
    property Ds_Ncm : String read fDs_Ncm write fDs_Ncm;
  end;

  TNcms = class(TList<Ncm>);

implementation

{ TNcm }

constructor TNcm.Create(AOwner: TComponent);
begin
  inherited;

end;

destructor TNcm.Destroy;
begin

  inherited;
end;

end.