unit uFcxHistrelsub;

interface

uses
  Classes, SysUtils,
  mMapping;

type
  TFcx_Histrelsub = class(TmMapping)
  private
    fTp_Documento: String;
    fNr_Seqhistrelsub: String;
    fU_Version: String;
    fCd_Operador: String;
    fDt_Cadastro: String;
    fNr_Parcelas: String;
    fCd_Historico: String;
    fCd_Histfec: String;
    fNr_Portador: String;
    fVl_Aux: String;
    fDs_Histrelsub: String;
    fCd_Formulacartao: String;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function GetMapping() : PmMapping; override;
  published
    property Tp_Documento : String read fTp_Documento write fTp_Documento;
    property Nr_Seqhistrelsub : String read fNr_Seqhistrelsub write fNr_Seqhistrelsub;
    property U_Version : String read fU_Version write fU_Version;
    property Cd_Operador : String read fCd_Operador write fCd_Operador;
    property Dt_Cadastro : String read fDt_Cadastro write fDt_Cadastro;
    property Nr_Parcelas : String read fNr_Parcelas write fNr_Parcelas;
    property Cd_Historico : String read fCd_Historico write fCd_Historico;
    property Cd_Histfec : String read fCd_Histfec write fCd_Histfec;
    property Nr_Portador : String read fNr_Portador write fNr_Portador;
    property Vl_Aux : String read fVl_Aux write fVl_Aux;
    property Ds_Histrelsub : String read fDs_Histrelsub write fDs_Histrelsub;
    property Cd_Formulacartao : String read fCd_Formulacartao write fCd_Formulacartao;
  end;

  TFcx_Histrelsubs = class(TList)
  public
    function Add: TFcx_Histrelsub; overload;
  end;

implementation

{ TFcx_Histrelsub }

constructor TFcx_Histrelsub.Create(AOwner: TComponent);
begin
  inherited;

end;

destructor TFcx_Histrelsub.Destroy;
begin

  inherited;
end;

//--

function TFcx_Histrelsub.GetMapping: PmMapping;
begin
  Result := New(PmMapping);

  Result.Tabela := New(PmTabela);
  with Result.Tabela^ do begin
    Nome := 'FCX_HISTRELSUB';
  end;

  Result.Campos := TmCampos.Create;
  with Result.Campos do begin
    Add('Tp_Documento', 'TP_DOCUMENTO', tfKey);
    Add('Nr_Seqhistrelsub', 'NR_SEQHISTRELSUB', tfKey);
    Add('U_Version', 'U_VERSION', tfNul);
    Add('Cd_Operador', 'CD_OPERADOR', tfReq);
    Add('Dt_Cadastro', 'DT_CADASTRO', tfReq);
    Add('Nr_Parcelas', 'NR_PARCELAS', tfNul);
    Add('Cd_Historico', 'CD_HISTORICO', tfNul);
    Add('Cd_Histfec', 'CD_HISTFEC', tfNul);
    Add('Nr_Portador', 'NR_PORTADOR', tfNul);
    Add('Vl_Aux', 'VL_AUX', tfNul);
    Add('Ds_Histrelsub', 'DS_HISTRELSUB', tfNul);
    Add('Cd_Formulacartao', 'CD_FORMULACARTAO', tfNul);
  end;

  Result.Relacoes := TmRelacoes.Create;
  with Result.Relacoes do begin
  end;
end;

//--

{ TFcx_Histrelsubs }

function TFcx_Histrelsubs.Add: TFcx_Histrelsub;
begin
  Result := TFcx_Histrelsub.Create(nil);
  Self.Add(Result);
end;

end.