unit uFcxCaixai;

interface

uses
  Classes, SysUtils,
  mMapping;

type
  TFcx_Caixai = class(TmMapping)
  private
    fCd_Empresa: String;
    fCd_Terminal: String;
    fDt_Abertura: String;
    fNr_Seq: String;
    fNr_Seqitem: String;
    fU_Version: String;
    fCd_Operador: String;
    fDt_Cadastro: String;
    fTp_Documento: String;
    fNr_Seqhistrelsub: String;
    fNr_Portador: String;
    fVl_Contado: String;
    fVl_Sistema: String;
    fVl_Diferenca: String;
    fVl_Fundo: String;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function GetMapping() : PmMapping; override;
  published
    property Cd_Empresa : String read fCd_Empresa write fCd_Empresa;
    property Cd_Terminal : String read fCd_Terminal write fCd_Terminal;
    property Dt_Abertura : String read fDt_Abertura write fDt_Abertura;
    property Nr_Seq : String read fNr_Seq write fNr_Seq;
    property Nr_Seqitem : String read fNr_Seqitem write fNr_Seqitem;
    property U_Version : String read fU_Version write fU_Version;
    property Cd_Operador : String read fCd_Operador write fCd_Operador;
    property Dt_Cadastro : String read fDt_Cadastro write fDt_Cadastro;
    property Tp_Documento : String read fTp_Documento write fTp_Documento;
    property Nr_Seqhistrelsub : String read fNr_Seqhistrelsub write fNr_Seqhistrelsub;
    property Nr_Portador : String read fNr_Portador write fNr_Portador;
    property Vl_Contado : String read fVl_Contado write fVl_Contado;
    property Vl_Sistema : String read fVl_Sistema write fVl_Sistema;
    property Vl_Diferenca : String read fVl_Diferenca write fVl_Diferenca;
    property Vl_Fundo : String read fVl_Fundo write fVl_Fundo;
  end;

  TFcx_Caixais = class(TList)
  public
    function Add: TFcx_Caixai; overload;
  end;

implementation

{ TFcx_Caixai }

constructor TFcx_Caixai.Create(AOwner: TComponent);
begin
  inherited;

end;

destructor TFcx_Caixai.Destroy;
begin

  inherited;
end;

//--

function TFcx_Caixai.GetMapping: PmMapping;
begin
  Result := New(PmMapping);

  Result.Tabela := New(PmTabela);
  with Result.Tabela^ do begin
    Nome := 'FCX_CAIXAI';
  end;

  Result.Campos := TmCampos.Create;
  with Result.Campos do begin
    Add('Cd_Empresa', 'CD_EMPRESA', tfKey);
    Add('Cd_Terminal', 'CD_TERMINAL', tfKey);
    Add('Dt_Abertura', 'DT_ABERTURA', tfKey);
    Add('Nr_Seq', 'NR_SEQ', tfKey);
    Add('Nr_Seqitem', 'NR_SEQITEM', tfKey);
    Add('U_Version', 'U_VERSION', tfNul);
    Add('Cd_Operador', 'CD_OPERADOR', tfReq);
    Add('Dt_Cadastro', 'DT_CADASTRO', tfReq);
    Add('Tp_Documento', 'TP_DOCUMENTO', tfReq);
    Add('Nr_Seqhistrelsub', 'NR_SEQHISTRELSUB', tfReq);
    Add('Nr_Portador', 'NR_PORTADOR', tfNul);
    Add('Vl_Contado', 'VL_CONTADO', tfNul);
    Add('Vl_Sistema', 'VL_SISTEMA', tfNul);
    Add('Vl_Diferenca', 'VL_DIFERENCA', tfNul);
    Add('Vl_Fundo', 'VL_FUNDO', tfNul);
  end;

  Result.Relacoes := TmRelacoes.Create;
  with Result.Relacoes do begin
  end;
end;

//--

{ TFcx_Caixais }

function TFcx_Caixais.Add: TFcx_Caixai;
begin
  Result := TFcx_Caixai.Create(nil);
  Self.Add(Result);
end;

end.