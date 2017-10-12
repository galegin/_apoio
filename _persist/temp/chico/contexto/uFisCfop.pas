unit uFisCfop;

interface

uses
  Classes, SysUtils,
  mMapping;

type
  TFis_Cfop = class(TmMapping)
  private
    fTp_Operacao: String;
    fTp_Contribuinte: String;
    fTp_Transacao: String;
    fTp_Producao: String;
    fTp_Comercial: String;
    fTp_Modalidade: String;
    fTp_Regimesub: String;
    fTp_Finalcompra: String;
    fU_Version: String;
    fCd_Cfop: String;
    fCd_Operador: String;
    fDt_Cadastro: String;
    fDs_Cfop: String;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function GetMapping() : PmMapping; override;
  published
    property Tp_Operacao : String read fTp_Operacao write fTp_Operacao;
    property Tp_Contribuinte : String read fTp_Contribuinte write fTp_Contribuinte;
    property Tp_Transacao : String read fTp_Transacao write fTp_Transacao;
    property Tp_Producao : String read fTp_Producao write fTp_Producao;
    property Tp_Comercial : String read fTp_Comercial write fTp_Comercial;
    property Tp_Modalidade : String read fTp_Modalidade write fTp_Modalidade;
    property Tp_Regimesub : String read fTp_Regimesub write fTp_Regimesub;
    property Tp_Finalcompra : String read fTp_Finalcompra write fTp_Finalcompra;
    property U_Version : String read fU_Version write fU_Version;
    property Cd_Cfop : String read fCd_Cfop write fCd_Cfop;
    property Cd_Operador : String read fCd_Operador write fCd_Operador;
    property Dt_Cadastro : String read fDt_Cadastro write fDt_Cadastro;
    property Ds_Cfop : String read fDs_Cfop write fDs_Cfop;
  end;

  TFis_Cfops = class(TList)
  public
    function Add: TFis_Cfop; overload;
  end;

implementation

{ TFis_Cfop }

constructor TFis_Cfop.Create(AOwner: TComponent);
begin
  inherited;

end;

destructor TFis_Cfop.Destroy;
begin

  inherited;
end;

//--

function TFis_Cfop.GetMapping: PmMapping;
begin
  Result := New(PmMapping);

  Result.Tabela := New(PmTabela);
  with Result.Tabela^ do begin
    Nome := 'FIS_CFOP';
  end;

  Result.Campos := TmCampos.Create;
  with Result.Campos do begin
    Add('Tp_Operacao', 'TP_OPERACAO', tfKey);
    Add('Tp_Contribuinte', 'TP_CONTRIBUINTE', tfKey);
    Add('Tp_Transacao', 'TP_TRANSACAO', tfKey);
    Add('Tp_Producao', 'TP_PRODUCAO', tfKey);
    Add('Tp_Comercial', 'TP_COMERCIAL', tfKey);
    Add('Tp_Modalidade', 'TP_MODALIDADE', tfKey);
    Add('Tp_Regimesub', 'TP_REGIMESUB', tfKey);
    Add('Tp_Finalcompra', 'TP_FINALCOMPRA', tfKey);
    Add('U_Version', 'U_VERSION', tfNul);
    Add('Cd_Cfop', 'CD_CFOP', tfReq);
    Add('Cd_Operador', 'CD_OPERADOR', tfReq);
    Add('Dt_Cadastro', 'DT_CADASTRO', tfReq);
    Add('Ds_Cfop', 'DS_CFOP', tfReq);
  end;

  Result.Relacoes := TmRelacoes.Create;
  with Result.Relacoes do begin
  end;
end;

//--

{ TFis_Cfops }

function TFis_Cfops.Add: TFis_Cfop;
begin
  Result := TFis_Cfop.Create(nil);
  Self.Add(Result);
end;

end.