unit uGerCondpgtoi;

interface

uses
  Classes, SysUtils,
  System.Generics.Collections,
  mMapping;

type
  [Tabela('GER_CONDPGTOI')]
  TGer_Condpgtoi = class(TmMapping)
  private
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
  published
    [Campo('CD_CONDPGTO', tfKey)]
    property Cd_Condpgto : String read fCd_Condpgto write fCd_Condpgto;
    [Campo('NR_SEQ4', tfKey)]
    property Nr_Seq4 : String read fNr_Seq4 write fNr_Seq4;
    [Campo('U_VERSION', tfNul)]
    property U_Version : String read fU_Version write fU_Version;
    [Campo('CD_OPERADOR', tfReq)]
    property Cd_Operador : String read fCd_Operador write fCd_Operador;
    [Campo('DT_CADASTRO', tfReq)]
    property Dt_Cadastro : String read fDt_Cadastro write fDt_Cadastro;
    [Campo('QT_DIA', tfNul)]
    property Qt_Dia : String read fQt_Dia write fQt_Dia;
  end;

  TGer_Condpgtois = class(TList<Ger_Condpgtoi>);

implementation

{ TGer_Condpgtoi }

constructor TGer_Condpgtoi.Create(AOwner: TComponent);
begin
  inherited;

end;

destructor TGer_Condpgtoi.Destroy;
begin

  inherited;
end;

end.