unit uFcxCaixam;

interface

uses
  Classes, SysUtils,
  mMapping;

type
  TFcx_Caixam = class(TmMapping)
  private
    fCd_Empresa: String;
    fCd_Terminal: String;
    fDt_Abertura: String;
    fNr_Seq: String;
    fNr_Ctapes: String;
    fDt_Movim: String;
    fNr_Seqmov: String;
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
    property Dt_Abertura : String read fDt_Abertura write fDt_Abertura;
    property Nr_Seq : String read fNr_Seq write fNr_Seq;
    property Nr_Ctapes : String read fNr_Ctapes write fNr_Ctapes;
    property Dt_Movim : String read fDt_Movim write fDt_Movim;
    property Nr_Seqmov : String read fNr_Seqmov write fNr_Seqmov;
    property U_Version : String read fU_Version write fU_Version;
    property Cd_Operador : String read fCd_Operador write fCd_Operador;
    property Dt_Cadastro : String read fDt_Cadastro write fDt_Cadastro;
  end;

  TFcx_Caixams = class(TList)
  public
    function Add: TFcx_Caixam; overload;
  end;

implementation

{ TFcx_Caixam }

constructor TFcx_Caixam.Create(AOwner: TComponent);
begin
  inherited;

end;

destructor TFcx_Caixam.Destroy;
begin

  inherited;
end;

//--

function TFcx_Caixam.GetMapping: PmMapping;
begin
  Result := New(PmMapping);

  Result.Tabela := New(PmTabela);
  with Result.Tabela^ do begin
    Nome := 'FCX_CAIXAM';
  end;

  Result.Campos := TmCampos.Create;
  with Result.Campos do begin
    Add('Cd_Empresa', 'CD_EMPRESA', tfKey);
    Add('Cd_Terminal', 'CD_TERMINAL', tfKey);
    Add('Dt_Abertura', 'DT_ABERTURA', tfKey);
    Add('Nr_Seq', 'NR_SEQ', tfKey);
    Add('Nr_Ctapes', 'NR_CTAPES', tfKey);
    Add('Dt_Movim', 'DT_MOVIM', tfKey);
    Add('Nr_Seqmov', 'NR_SEQMOV', tfKey);
    Add('U_Version', 'U_VERSION', tfNul);
    Add('Cd_Operador', 'CD_OPERADOR', tfReq);
    Add('Dt_Cadastro', 'DT_CADASTRO', tfReq);
  end;

  Result.Relacoes := TmRelacoes.Create;
  with Result.Relacoes do begin
  end;
end;

//--

{ TFcx_Caixams }

function TFcx_Caixams.Add: TFcx_Caixam;
begin
  Result := TFcx_Caixam.Create(nil);
  Self.Add(Result);
end;

end.