unit uFcxCaixac;

interface

uses
  Classes, SysUtils,
  mMapping;

type
  TFcx_Caixac = class(TmMapping)
  private
    fCd_Empresa: String;
    fCd_Terminal: String;
    fDt_Abertura: String;
    fNr_Seq: String;
    fU_Version: String;
    fCd_Operador: String;
    fDt_Cadastro: String;
    fCd_Opercx: String;
    fCd_Operconf: String;
    fNr_Ctapes: String;
    fDs_Fechamento: String;
    fVl_Abertura: String;
    fIn_Fechado: String;
    fDt_Fechado: String;
    fIn_Diferenca: String;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function GetMapping() : PmMapping; override;
  published
    property Cd_Empresa : String read fCd_Empresa write fCd_Empresa;
    property Cd_Terminal : String read fCd_Terminal write fCd_Terminal;
    property Dt_Abertura : String read fDt_Abertura write fDt_Abertura;
    property Nr_Seq : String read fNr_Seq write fNr_Seq;
    property U_Version : String read fU_Version write fU_Version;
    property Cd_Operador : String read fCd_Operador write fCd_Operador;
    property Dt_Cadastro : String read fDt_Cadastro write fDt_Cadastro;
    property Cd_Opercx : String read fCd_Opercx write fCd_Opercx;
    property Cd_Operconf : String read fCd_Operconf write fCd_Operconf;
    property Nr_Ctapes : String read fNr_Ctapes write fNr_Ctapes;
    property Ds_Fechamento : String read fDs_Fechamento write fDs_Fechamento;
    property Vl_Abertura : String read fVl_Abertura write fVl_Abertura;
    property In_Fechado : String read fIn_Fechado write fIn_Fechado;
    property Dt_Fechado : String read fDt_Fechado write fDt_Fechado;
    property In_Diferenca : String read fIn_Diferenca write fIn_Diferenca;
  end;

  TFcx_Caixacs = class(TList)
  public
    function Add: TFcx_Caixac; overload;
  end;

implementation

{ TFcx_Caixac }

constructor TFcx_Caixac.Create(AOwner: TComponent);
begin
  inherited;

end;

destructor TFcx_Caixac.Destroy;
begin

  inherited;
end;

//--

function TFcx_Caixac.GetMapping: PmMapping;
begin
  Result := New(PmMapping);

  Result.Tabela := New(PmTabela);
  with Result.Tabela^ do begin
    Nome := 'FCX_CAIXAC';
  end;

  Result.Campos := TmCampos.Create;
  with Result.Campos do begin
    Add('Cd_Empresa', 'CD_EMPRESA', tfKey);
    Add('Cd_Terminal', 'CD_TERMINAL', tfKey);
    Add('Dt_Abertura', 'DT_ABERTURA', tfKey);
    Add('Nr_Seq', 'NR_SEQ', tfKey);
    Add('U_Version', 'U_VERSION', tfNul);
    Add('Cd_Operador', 'CD_OPERADOR', tfReq);
    Add('Dt_Cadastro', 'DT_CADASTRO', tfReq);
    Add('Cd_Opercx', 'CD_OPERCX', tfNul);
    Add('Cd_Operconf', 'CD_OPERCONF', tfNul);
    Add('Nr_Ctapes', 'NR_CTAPES', tfReq);
    Add('Ds_Fechamento', 'DS_FECHAMENTO', tfNul);
    Add('Vl_Abertura', 'VL_ABERTURA', tfNul);
    Add('In_Fechado', 'IN_FECHADO', tfNul);
    Add('Dt_Fechado', 'DT_FECHADO', tfNul);
    Add('In_Diferenca', 'IN_DIFERENCA', tfNul);
  end;

  Result.Relacoes := TmRelacoes.Create;
  with Result.Relacoes do begin
  end;
end;

//--

{ TFcx_Caixacs }

function TFcx_Caixacs.Add: TFcx_Caixac;
begin
  Result := TFcx_Caixac.Create(nil);
  Self.Add(Result);
end;

end.