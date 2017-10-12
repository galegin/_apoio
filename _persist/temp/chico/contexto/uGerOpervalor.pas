unit uGerOpervalor;

interface

uses
  Classes, SysUtils,
  mMapping;

type
  TGer_Opervalor = class(TmMapping)
  private
    fCd_Operacao: String;
    fTp_Unidvalor: String;
    fCd_Unidvalor: String;
    fU_Version: String;
    fCd_Operador: String;
    fDt_Cadastro: String;
    fIn_Precobase: String;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function GetMapping() : PmMapping; override;
  published
    property Cd_Operacao : String read fCd_Operacao write fCd_Operacao;
    property Tp_Unidvalor : String read fTp_Unidvalor write fTp_Unidvalor;
    property Cd_Unidvalor : String read fCd_Unidvalor write fCd_Unidvalor;
    property U_Version : String read fU_Version write fU_Version;
    property Cd_Operador : String read fCd_Operador write fCd_Operador;
    property Dt_Cadastro : String read fDt_Cadastro write fDt_Cadastro;
    property In_Precobase : String read fIn_Precobase write fIn_Precobase;
  end;

  TGer_Opervalors = class(TList)
  public
    function Add: TGer_Opervalor; overload;
  end;

implementation

{ TGer_Opervalor }

constructor TGer_Opervalor.Create(AOwner: TComponent);
begin
  inherited;

end;

destructor TGer_Opervalor.Destroy;
begin

  inherited;
end;

//--

function TGer_Opervalor.GetMapping: PmMapping;
begin
  Result := New(PmMapping);

  Result.Tabela := New(PmTabela);
  with Result.Tabela^ do begin
    Nome := 'GER_OPERVALOR';
  end;

  Result.Campos := TmCampos.Create;
  with Result.Campos do begin
    Add('Cd_Operacao', 'CD_OPERACAO', tfKey);
    Add('Tp_Unidvalor', 'TP_UNIDVALOR', tfKey);
    Add('Cd_Unidvalor', 'CD_UNIDVALOR', tfKey);
    Add('U_Version', 'U_VERSION', tfNul);
    Add('Cd_Operador', 'CD_OPERADOR', tfReq);
    Add('Dt_Cadastro', 'DT_CADASTRO', tfReq);
    Add('In_Precobase', 'IN_PRECOBASE', tfNul);
  end;

  Result.Relacoes := TmRelacoes.Create;
  with Result.Relacoes do begin
  end;
end;

//--

{ TGer_Opervalors }

function TGer_Opervalors.Add: TGer_Opervalor;
begin
  Result := TGer_Opervalor.Create(nil);
  Self.Add(Result);
end;

end.