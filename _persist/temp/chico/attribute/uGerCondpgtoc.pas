unit uGerCondpgtoc;

interface

uses
  Classes, SysUtils,
  System.Generics.Collections,
  mMapping;

type
  [Tabela('GER_CONDPGTOC')]
  TGer_Condpgtoc = class(TmMapping)
  private
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
  published
    [Campo('CD_CONDPGTO', tfKey)]
    property Cd_Condpgto : String read fCd_Condpgto write fCd_Condpgto;
    [Campo('U_VERSION', tfNul)]
    property U_Version : String read fU_Version write fU_Version;
    [Campo('NR_PARCELAS', tfReq)]
    property Nr_Parcelas : String read fNr_Parcelas write fNr_Parcelas;
    [Campo('CD_OPERADOR', tfReq)]
    property Cd_Operador : String read fCd_Operador write fCd_Operador;
    [Campo('DT_CADASTRO', tfReq)]
    property Dt_Cadastro : String read fDt_Cadastro write fDt_Cadastro;
    [Campo('DS_CONDPGTO', tfReq)]
    property Ds_Condpgto : String read fDs_Condpgto write fDs_Condpgto;
    [Campo('IN_BLOQUEIO', tfNul)]
    property In_Bloqueio : String read fIn_Bloqueio write fIn_Bloqueio;
    [Campo('PR_DESCONTO', tfNul)]
    property Pr_Desconto : String read fPr_Desconto write fPr_Desconto;
    [Campo('PR_JURO', tfNul)]
    property Pr_Juro : String read fPr_Juro write fPr_Juro;
  end;

  TGer_Condpgtocs = class(TList<Ger_Condpgtoc>);

implementation

{ TGer_Condpgtoc }

constructor TGer_Condpgtoc.Create(AOwner: TComponent);
begin
  inherited;

end;

destructor TGer_Condpgtoc.Destroy;
begin

  inherited;
end;

end.