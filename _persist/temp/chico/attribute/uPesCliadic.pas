unit uPesCliadic;

interface

uses
  Classes, SysUtils,
  System.Generics.Collections,
  mMapping;

type
  [Tabela('PES_CLIADIC')]
  TPes_Cliadic = class(TmMapping)
  private
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
  published
    [Campo('CD_CLIENTE', tfKey)]
    property Cd_Cliente : String read fCd_Cliente write fCd_Cliente;
    [Campo('U_VERSION', tfNul)]
    property U_Version : String read fU_Version write fU_Version;
    [Campo('CD_OPERADOR', tfReq)]
    property Cd_Operador : String read fCd_Operador write fCd_Operador;
    [Campo('DT_CADASTRO', tfReq)]
    property Dt_Cadastro : String read fDt_Cadastro write fDt_Cadastro;
    [Campo('DT_VECTOLIMITE', tfNul)]
    property Dt_Vectolimite : String read fDt_Vectolimite write fDt_Vectolimite;
    [Campo('IN_RESTRITO', tfNul)]
    property In_Restrito : String read fIn_Restrito write fIn_Restrito;
    [Campo('CD_CONCEITO', tfNul)]
    property Cd_Conceito : String read fCd_Conceito write fCd_Conceito;
    [Campo('CD_TABDESC', tfNul)]
    property Cd_Tabdesc : String read fCd_Tabdesc write fCd_Tabdesc;
    [Campo('NR_DIABASEVENCTO', tfNul)]
    property Nr_Diabasevencto : String read fNr_Diabasevencto write fNr_Diabasevencto;
    [Campo('NR_DIASCARENCIA', tfNul)]
    property Nr_Diascarencia : String read fNr_Diascarencia write fNr_Diascarencia;
  end;

  TPes_Cliadics = class(TList<Pes_Cliadic>);

implementation

{ TPes_Cliadic }

constructor TPes_Cliadic.Create(AOwner: TComponent);
begin
  inherited;

end;

destructor TPes_Cliadic.Destroy;
begin

  inherited;
end;

end.