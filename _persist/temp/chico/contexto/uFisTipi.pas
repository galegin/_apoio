unit uFisTipi;

interface

uses
  Classes, SysUtils,
  mMapping;

type
  TFis_Tipi = class(TmMapping)
  private
    fCd_Tipi: String;
    fU_Version: String;
    fPr_Ipi: String;
    fCd_Operador: String;
    fDt_Cadastro: String;
    fDs_Tipi: String;
    fDs_Legenda: String;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function GetMapping() : PmMapping; override;
  published
    property Cd_Tipi : String read fCd_Tipi write fCd_Tipi;
    property U_Version : String read fU_Version write fU_Version;
    property Pr_Ipi : String read fPr_Ipi write fPr_Ipi;
    property Cd_Operador : String read fCd_Operador write fCd_Operador;
    property Dt_Cadastro : String read fDt_Cadastro write fDt_Cadastro;
    property Ds_Tipi : String read fDs_Tipi write fDs_Tipi;
    property Ds_Legenda : String read fDs_Legenda write fDs_Legenda;
  end;

  TFis_Tipis = class(TList)
  public
    function Add: TFis_Tipi; overload;
  end;

implementation

{ TFis_Tipi }

constructor TFis_Tipi.Create(AOwner: TComponent);
begin
  inherited;

end;

destructor TFis_Tipi.Destroy;
begin

  inherited;
end;

//--

function TFis_Tipi.GetMapping: PmMapping;
begin
  Result := New(PmMapping);

  Result.Tabela := New(PmTabela);
  with Result.Tabela^ do begin
    Nome := 'FIS_TIPI';
  end;

  Result.Campos := TmCampos.Create;
  with Result.Campos do begin
    Add('Cd_Tipi', 'CD_TIPI', tfKey);
    Add('U_Version', 'U_VERSION', tfNul);
    Add('Pr_Ipi', 'PR_IPI', tfNul);
    Add('Cd_Operador', 'CD_OPERADOR', tfReq);
    Add('Dt_Cadastro', 'DT_CADASTRO', tfReq);
    Add('Ds_Tipi', 'DS_TIPI', tfReq);
    Add('Ds_Legenda', 'DS_LEGENDA', tfNul);
  end;

  Result.Relacoes := TmRelacoes.Create;
  with Result.Relacoes do begin
  end;
end;

//--

{ TFis_Tipis }

function TFis_Tipis.Add: TFis_Tipi;
begin
  Result := TFis_Tipi.Create(nil);
  Self.Add(Result);
end;

end.