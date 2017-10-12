unit uGerTerminal;

interface

uses
  Classes, SysUtils,
  mMapping;

type
  TGer_Terminal = class(TmMapping)
  private
    fCd_Empresa: String;
    fCd_Terminal: String;
    fU_Version: String;
    fCd_Operador: String;
    fDt_Cadastro: String;
    fDs_Terminal: String;
    fNr_Ctapes: String;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function GetMapping() : PmMapping; override;
  published
    property Cd_Empresa : String read fCd_Empresa write fCd_Empresa;
    property Cd_Terminal : String read fCd_Terminal write fCd_Terminal;
    property U_Version : String read fU_Version write fU_Version;
    property Cd_Operador : String read fCd_Operador write fCd_Operador;
    property Dt_Cadastro : String read fDt_Cadastro write fDt_Cadastro;
    property Ds_Terminal : String read fDs_Terminal write fDs_Terminal;
    property Nr_Ctapes : String read fNr_Ctapes write fNr_Ctapes;
  end;

  TGer_Terminals = class(TList)
  public
    function Add: TGer_Terminal; overload;
  end;

implementation

{ TGer_Terminal }

constructor TGer_Terminal.Create(AOwner: TComponent);
begin
  inherited;

end;

destructor TGer_Terminal.Destroy;
begin

  inherited;
end;

//--

function TGer_Terminal.GetMapping: PmMapping;
begin
  Result := New(PmMapping);

  Result.Tabela := New(PmTabela);
  with Result.Tabela^ do begin
    Nome := 'GER_TERMINAL';
  end;

  Result.Campos := TmCampos.Create;
  with Result.Campos do begin
    Add('Cd_Empresa', 'CD_EMPRESA', tfKey);
    Add('Cd_Terminal', 'CD_TERMINAL', tfKey);
    Add('U_Version', 'U_VERSION', tfNul);
    Add('Cd_Operador', 'CD_OPERADOR', tfReq);
    Add('Dt_Cadastro', 'DT_CADASTRO', tfReq);
    Add('Ds_Terminal', 'DS_TERMINAL', tfNul);
    Add('Nr_Ctapes', 'NR_CTAPES', tfNul);
  end;

  Result.Relacoes := TmRelacoes.Create;
  with Result.Relacoes do begin
  end;
end;

//--

{ TGer_Terminals }

function TGer_Terminals.Add: TGer_Terminal;
begin
  Result := TGer_Terminal.Create(nil);
  Self.Add(Result);
end;

end.