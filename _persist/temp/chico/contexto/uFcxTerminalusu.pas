unit uFcxTerminalusu;

interface

uses
  Classes, SysUtils,
  mMapping;

type
  TFcx_Terminalusu = class(TmMapping)
  private
    fCd_Empresa: String;
    fCd_Terminal: String;
    fU_Version: String;
    fCd_Operador: String;
    fDt_Cadastro: String;
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
  end;

  TFcx_Terminalusus = class(TList)
  public
    function Add: TFcx_Terminalusu; overload;
  end;

implementation

{ TFcx_Terminalusu }

constructor TFcx_Terminalusu.Create(AOwner: TComponent);
begin
  inherited;

end;

destructor TFcx_Terminalusu.Destroy;
begin

  inherited;
end;

//--

function TFcx_Terminalusu.GetMapping: PmMapping;
begin
  Result := New(PmMapping);

  Result.Tabela := New(PmTabela);
  with Result.Tabela^ do begin
    Nome := 'FCX_TERMINALUSU';
  end;

  Result.Campos := TmCampos.Create;
  with Result.Campos do begin
    Add('Cd_Empresa', 'CD_EMPRESA', tfKey);
    Add('Cd_Terminal', 'CD_TERMINAL', tfKey);
    Add('U_Version', 'U_VERSION', tfNul);
    Add('Cd_Operador', 'CD_OPERADOR', tfReq);
    Add('Dt_Cadastro', 'DT_CADASTRO', tfReq);
  end;

  Result.Relacoes := TmRelacoes.Create;
  with Result.Relacoes do begin
  end;
end;

//--

{ TFcx_Terminalusus }

function TFcx_Terminalusus.Add: TFcx_Terminalusu;
begin
  Result := TFcx_Terminalusu.Create(nil);
  Self.Add(Result);
end;

end.