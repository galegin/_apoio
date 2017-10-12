unit uGerOperterm;

interface

uses
  Classes, SysUtils,
  mMapping;

type
  TGer_Operterm = class(TmMapping)
  private
    fCd_Empresa: String;
    fCd_Terminal: String;
    fCd_Operacao: String;
    fU_Version: String;
    fCd_Operador: String;
    fDt_Cadastro: String;
    fCd_Serie: String;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function GetMapping() : PmMapping; override;
  published
    property Cd_Empresa : String read fCd_Empresa write fCd_Empresa;
    property Cd_Terminal : String read fCd_Terminal write fCd_Terminal;
    property Cd_Operacao : String read fCd_Operacao write fCd_Operacao;
    property U_Version : String read fU_Version write fU_Version;
    property Cd_Operador : String read fCd_Operador write fCd_Operador;
    property Dt_Cadastro : String read fDt_Cadastro write fDt_Cadastro;
    property Cd_Serie : String read fCd_Serie write fCd_Serie;
  end;

  TGer_Operterms = class(TList)
  public
    function Add: TGer_Operterm; overload;
  end;

implementation

{ TGer_Operterm }

constructor TGer_Operterm.Create(AOwner: TComponent);
begin
  inherited;

end;

destructor TGer_Operterm.Destroy;
begin

  inherited;
end;

//--

function TGer_Operterm.GetMapping: PmMapping;
begin
  Result := New(PmMapping);

  Result.Tabela := New(PmTabela);
  with Result.Tabela^ do begin
    Nome := 'GER_OPERTERM';
  end;

  Result.Campos := TmCampos.Create;
  with Result.Campos do begin
    Add('Cd_Empresa', 'CD_EMPRESA', tfKey);
    Add('Cd_Terminal', 'CD_TERMINAL', tfKey);
    Add('Cd_Operacao', 'CD_OPERACAO', tfKey);
    Add('U_Version', 'U_VERSION', tfNul);
    Add('Cd_Operador', 'CD_OPERADOR', tfReq);
    Add('Dt_Cadastro', 'DT_CADASTRO', tfReq);
    Add('Cd_Serie', 'CD_SERIE', tfReq);
  end;

  Result.Relacoes := TmRelacoes.Create;
  with Result.Relacoes do begin
  end;
end;

//--

{ TGer_Operterms }

function TGer_Operterms.Add: TGer_Operterm;
begin
  Result := TGer_Operterm.Create(nil);
  Self.Add(Result);
end;

end.