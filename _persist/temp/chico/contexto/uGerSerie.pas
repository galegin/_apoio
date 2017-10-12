unit uGerSerie;

interface

uses
  Classes, SysUtils,
  mMapping;

type
  TGer_Serie = class(TmMapping)
  private
    fCd_Serie: String;
    fU_Version: String;
    fCd_Operador: String;
    fDt_Cadastro: String;
    fDs_Serie: String;
    fDs_Sigla: String;
    fTp_Operacao: String;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function GetMapping() : PmMapping; override;
  published
    property Cd_Serie : String read fCd_Serie write fCd_Serie;
    property U_Version : String read fU_Version write fU_Version;
    property Cd_Operador : String read fCd_Operador write fCd_Operador;
    property Dt_Cadastro : String read fDt_Cadastro write fDt_Cadastro;
    property Ds_Serie : String read fDs_Serie write fDs_Serie;
    property Ds_Sigla : String read fDs_Sigla write fDs_Sigla;
    property Tp_Operacao : String read fTp_Operacao write fTp_Operacao;
  end;

  TGer_Series = class(TList)
  public
    function Add: TGer_Serie; overload;
  end;

implementation

{ TGer_Serie }

constructor TGer_Serie.Create(AOwner: TComponent);
begin
  inherited;

end;

destructor TGer_Serie.Destroy;
begin

  inherited;
end;

//--

function TGer_Serie.GetMapping: PmMapping;
begin
  Result := New(PmMapping);

  Result.Tabela := New(PmTabela);
  with Result.Tabela^ do begin
    Nome := 'GER_SERIE';
  end;

  Result.Campos := TmCampos.Create;
  with Result.Campos do begin
    Add('Cd_Serie', 'CD_SERIE', tfKey);
    Add('U_Version', 'U_VERSION', tfNul);
    Add('Cd_Operador', 'CD_OPERADOR', tfReq);
    Add('Dt_Cadastro', 'DT_CADASTRO', tfReq);
    Add('Ds_Serie', 'DS_SERIE', tfReq);
    Add('Ds_Sigla', 'DS_SIGLA', tfNul);
    Add('Tp_Operacao', 'TP_OPERACAO', tfNul);
  end;

  Result.Relacoes := TmRelacoes.Create;
  with Result.Relacoes do begin
  end;
end;

//--

{ TGer_Series }

function TGer_Series.Add: TGer_Serie;
begin
  Result := TGer_Serie.Create(nil);
  Self.Add(Result);
end;

end.