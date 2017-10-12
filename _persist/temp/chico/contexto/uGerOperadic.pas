unit uGerOperadic;

interface

uses
  Classes, SysUtils,
  mMapping;

type
  TGer_Operadic = class(TmMapping)
  private
    fCd_Operacao: String;
    fU_Version: String;
    fCd_Operador: String;
    fDt_Cadastro: String;
    fTp_Calccustocontabil: String;
    fTp_Validasaldo: String;
    fTp_Contabilizacao: String;
    fIn_Inativo: String;
    fTp_Validasaldoneg: String;
    fTp_Moddctonf: String;
    fIn_Esttransito: String;
    fTp_Finalidadenfe: String;
    fTp_Indpres: String;
    fTp_Impdanfe: String;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function GetMapping() : PmMapping; override;
  published
    property Cd_Operacao : String read fCd_Operacao write fCd_Operacao;
    property U_Version : String read fU_Version write fU_Version;
    property Cd_Operador : String read fCd_Operador write fCd_Operador;
    property Dt_Cadastro : String read fDt_Cadastro write fDt_Cadastro;
    property Tp_Calccustocontabil : String read fTp_Calccustocontabil write fTp_Calccustocontabil;
    property Tp_Validasaldo : String read fTp_Validasaldo write fTp_Validasaldo;
    property Tp_Contabilizacao : String read fTp_Contabilizacao write fTp_Contabilizacao;
    property In_Inativo : String read fIn_Inativo write fIn_Inativo;
    property Tp_Validasaldoneg : String read fTp_Validasaldoneg write fTp_Validasaldoneg;
    property Tp_Moddctonf : String read fTp_Moddctonf write fTp_Moddctonf;
    property In_Esttransito : String read fIn_Esttransito write fIn_Esttransito;
    property Tp_Finalidadenfe : String read fTp_Finalidadenfe write fTp_Finalidadenfe;
    property Tp_Indpres : String read fTp_Indpres write fTp_Indpres;
    property Tp_Impdanfe : String read fTp_Impdanfe write fTp_Impdanfe;
  end;

  TGer_Operadics = class(TList)
  public
    function Add: TGer_Operadic; overload;
  end;

implementation

{ TGer_Operadic }

constructor TGer_Operadic.Create(AOwner: TComponent);
begin
  inherited;

end;

destructor TGer_Operadic.Destroy;
begin

  inherited;
end;

//--

function TGer_Operadic.GetMapping: PmMapping;
begin
  Result := New(PmMapping);

  Result.Tabela := New(PmTabela);
  with Result.Tabela^ do begin
    Nome := 'GER_OPERADIC';
  end;

  Result.Campos := TmCampos.Create;
  with Result.Campos do begin
    Add('Cd_Operacao', 'CD_OPERACAO', tfKey);
    Add('U_Version', 'U_VERSION', tfNul);
    Add('Cd_Operador', 'CD_OPERADOR', tfReq);
    Add('Dt_Cadastro', 'DT_CADASTRO', tfNul);
    Add('Tp_Calccustocontabil', 'TP_CALCCUSTOCONTABIL', tfNul);
    Add('Tp_Validasaldo', 'TP_VALIDASALDO', tfNul);
    Add('Tp_Contabilizacao', 'TP_CONTABILIZACAO', tfNul);
    Add('In_Inativo', 'IN_INATIVO', tfNul);
    Add('Tp_Validasaldoneg', 'TP_VALIDASALDONEG', tfNul);
    Add('Tp_Moddctonf', 'TP_MODDCTONF', tfNul);
    Add('In_Esttransito', 'IN_ESTTRANSITO', tfNul);
    Add('Tp_Finalidadenfe', 'TP_FINALIDADENFE', tfNul);
    Add('Tp_Indpres', 'TP_INDPRES', tfNul);
    Add('Tp_Impdanfe', 'TP_IMPDANFE', tfNul);
  end;

  Result.Relacoes := TmRelacoes.Create;
  with Result.Relacoes do begin
  end;
end;

//--

{ TGer_Operadics }

function TGer_Operadics.Add: TGer_Operadic;
begin
  Result := TGer_Operadic.Create(nil);
  Self.Add(Result);
end;

end.