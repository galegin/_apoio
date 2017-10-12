unit uGerCondpgtoc;

interface

uses
  Classes, SysUtils,
  mMapping;

type
  TGer_Condpgtoc = class(TmMapping)
  private
    fCd_Condpgto: String;
    fU_Version: String;
    fNr_Parcelas: String;
    fCd_Operador: String;
    fDt_Cadastro: String;
    fDs_Condpgto: String;
    fIn_Bloqueio: String;
    fPr_Desconto: String;
    fPr_Juro: String;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function GetMapping() : PmMapping; override;
  published
    property Cd_Condpgto : String read fCd_Condpgto write fCd_Condpgto;
    property U_Version : String read fU_Version write fU_Version;
    property Nr_Parcelas : String read fNr_Parcelas write fNr_Parcelas;
    property Cd_Operador : String read fCd_Operador write fCd_Operador;
    property Dt_Cadastro : String read fDt_Cadastro write fDt_Cadastro;
    property Ds_Condpgto : String read fDs_Condpgto write fDs_Condpgto;
    property In_Bloqueio : String read fIn_Bloqueio write fIn_Bloqueio;
    property Pr_Desconto : String read fPr_Desconto write fPr_Desconto;
    property Pr_Juro : String read fPr_Juro write fPr_Juro;
  end;

  TGer_Condpgtocs = class(TList)
  public
    function Add: TGer_Condpgtoc; overload;
  end;

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

//--

function TGer_Condpgtoc.GetMapping: PmMapping;
begin
  Result := New(PmMapping);

  Result.Tabela := New(PmTabela);
  with Result.Tabela^ do begin
    Nome := 'GER_CONDPGTOC';
  end;

  Result.Campos := TmCampos.Create;
  with Result.Campos do begin
    Add('Cd_Condpgto', 'CD_CONDPGTO', tfKey);
    Add('U_Version', 'U_VERSION', tfNul);
    Add('Nr_Parcelas', 'NR_PARCELAS', tfReq);
    Add('Cd_Operador', 'CD_OPERADOR', tfReq);
    Add('Dt_Cadastro', 'DT_CADASTRO', tfReq);
    Add('Ds_Condpgto', 'DS_CONDPGTO', tfReq);
    Add('In_Bloqueio', 'IN_BLOQUEIO', tfNul);
    Add('Pr_Desconto', 'PR_DESCONTO', tfNul);
    Add('Pr_Juro', 'PR_JURO', tfNul);
  end;

  Result.Relacoes := TmRelacoes.Create;
  with Result.Relacoes do begin
  end;
end;

//--

{ TGer_Condpgtocs }

function TGer_Condpgtocs.Add: TGer_Condpgtoc;
begin
  Result := TGer_Condpgtoc.Create(nil);
  Self.Add(Result);
end;

end.