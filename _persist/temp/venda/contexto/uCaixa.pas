unit uCaixa;

interface

uses
  Classes, SysUtils,
  mMapping;

type
  TCaixa = class(TmMapping)
  private
    fId_Caixa: Integer;
    fU_Version: String;
    fCd_Operador: Integer;
    fDt_Cadastro: String;
    fCd_Terminal: Integer;
    fDt_Abertura: String;
    fVl_Abertura: String;
    fIn_Fechado: String;
    fDt_Fechado: String;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function GetMapping() : PmMapping; override;
  published
    property Id_Caixa : Integer read fId_Caixa write fId_Caixa;
    property U_Version : String read fU_Version write fU_Version;
    property Cd_Operador : Integer read fCd_Operador write fCd_Operador;
    property Dt_Cadastro : String read fDt_Cadastro write fDt_Cadastro;
    property Cd_Terminal : Integer read fCd_Terminal write fCd_Terminal;
    property Dt_Abertura : String read fDt_Abertura write fDt_Abertura;
    property Vl_Abertura : String read fVl_Abertura write fVl_Abertura;
    property In_Fechado : String read fIn_Fechado write fIn_Fechado;
    property Dt_Fechado : String read fDt_Fechado write fDt_Fechado;
  end;

  TCaixas = class(TList)
  public
    function Add: TCaixa; overload;
  end;

implementation

{ TCaixa }

constructor TCaixa.Create(AOwner: TComponent);
begin
  inherited;

end;

destructor TCaixa.Destroy;
begin

  inherited;
end;

//--

function TCaixa.GetMapping: PmMapping;
begin
  Result := New(PmMapping);

  Result.Tabela := New(PmTabela);
  with Result.Tabela^ do begin
    Nome := 'CAIXA';
  end;

  Result.Campos := TmCampos.Create;
  with Result.Campos do begin
    Add('Id_Caixa', 'ID_CAIXA', tfKey);
    Add('U_Version', 'U_VERSION', tfNul);
    Add('Cd_Operador', 'CD_OPERADOR', tfReq);
    Add('Dt_Cadastro', 'DT_CADASTRO', tfReq);
    Add('Cd_Terminal', 'CD_TERMINAL', tfReq);
    Add('Dt_Abertura', 'DT_ABERTURA', tfReq);
    Add('Vl_Abertura', 'VL_ABERTURA', tfReq);
    Add('In_Fechado', 'IN_FECHADO', tfReq);
    Add('Dt_Fechado', 'DT_FECHADO', tfNul);
  end;

  Result.Relacoes := TmRelacoes.Create;
  with Result.Relacoes do begin
  end;
end;

//--

{ TCaixas }

function TCaixas.Add: TCaixa;
begin
  Result := TCaixa.Create(nil);
  Self.Add(Result);
end;

end.