unit uFcxHistrel;

interface

uses
  Classes, SysUtils,
  mMapping;

type
  TFcx_Histrel = class(TmMapping)
  private
    fTp_Documento: String;
    fU_Version: String;
    fCd_Operador: String;
    fDt_Cadastro: String;
    fCd_Historico: String;
    fCd_Histfec: String;
    fIn_Totalizador: String;
    fIn_Recebimento: String;
    fIn_Faturamento: String;
    fVl_Aux: String;
    fNr_Portador: String;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function GetMapping() : PmMapping; override;
  published
    property Tp_Documento : String read fTp_Documento write fTp_Documento;
    property U_Version : String read fU_Version write fU_Version;
    property Cd_Operador : String read fCd_Operador write fCd_Operador;
    property Dt_Cadastro : String read fDt_Cadastro write fDt_Cadastro;
    property Cd_Historico : String read fCd_Historico write fCd_Historico;
    property Cd_Histfec : String read fCd_Histfec write fCd_Histfec;
    property In_Totalizador : String read fIn_Totalizador write fIn_Totalizador;
    property In_Recebimento : String read fIn_Recebimento write fIn_Recebimento;
    property In_Faturamento : String read fIn_Faturamento write fIn_Faturamento;
    property Vl_Aux : String read fVl_Aux write fVl_Aux;
    property Nr_Portador : String read fNr_Portador write fNr_Portador;
  end;

  TFcx_Histrels = class(TList)
  public
    function Add: TFcx_Histrel; overload;
  end;

implementation

{ TFcx_Histrel }

constructor TFcx_Histrel.Create(AOwner: TComponent);
begin
  inherited;

end;

destructor TFcx_Histrel.Destroy;
begin

  inherited;
end;

//--

function TFcx_Histrel.GetMapping: PmMapping;
begin
  Result := New(PmMapping);

  Result.Tabela := New(PmTabela);
  with Result.Tabela^ do begin
    Nome := 'FCX_HISTREL';
  end;

  Result.Campos := TmCampos.Create;
  with Result.Campos do begin
    Add('Tp_Documento', 'TP_DOCUMENTO', tfKey);
    Add('U_Version', 'U_VERSION', tfNul);
    Add('Cd_Operador', 'CD_OPERADOR', tfReq);
    Add('Dt_Cadastro', 'DT_CADASTRO', tfReq);
    Add('Cd_Historico', 'CD_HISTORICO', tfNul);
    Add('Cd_Histfec', 'CD_HISTFEC', tfNul);
    Add('In_Totalizador', 'IN_TOTALIZADOR', tfNul);
    Add('In_Recebimento', 'IN_RECEBIMENTO', tfNul);
    Add('In_Faturamento', 'IN_FATURAMENTO', tfNul);
    Add('Vl_Aux', 'VL_AUX', tfNul);
    Add('Nr_Portador', 'NR_PORTADOR', tfNul);
  end;

  Result.Relacoes := TmRelacoes.Create;
  with Result.Relacoes do begin
  end;
end;

//--

{ TFcx_Histrels }

function TFcx_Histrels.Add: TFcx_Histrel;
begin
  Result := TFcx_Histrel.Create(nil);
  Self.Add(Result);
end;

end.