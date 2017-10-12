unit uGlbMunicipio;

interface

uses
  Classes, SysUtils,
  mMapping;

type
  TGlb_Municipio = class(TmMapping)
  private
    fCd_Municipio: String;
    fU_Version: String;
    fCd_Cep: String;
    fCd_Estado: String;
    fCd_Operador: String;
    fDt_Cadastro: String;
    fNm_Municipio: String;
    fDs_Sigla: String;
    fTp_Municipio: String;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function GetMapping() : PmMapping; override;
  published
    property Cd_Municipio : String read fCd_Municipio write fCd_Municipio;
    property U_Version : String read fU_Version write fU_Version;
    property Cd_Cep : String read fCd_Cep write fCd_Cep;
    property Cd_Estado : String read fCd_Estado write fCd_Estado;
    property Cd_Operador : String read fCd_Operador write fCd_Operador;
    property Dt_Cadastro : String read fDt_Cadastro write fDt_Cadastro;
    property Nm_Municipio : String read fNm_Municipio write fNm_Municipio;
    property Ds_Sigla : String read fDs_Sigla write fDs_Sigla;
    property Tp_Municipio : String read fTp_Municipio write fTp_Municipio;
  end;

  TGlb_Municipios = class(TList)
  public
    function Add: TGlb_Municipio; overload;
  end;

implementation

{ TGlb_Municipio }

constructor TGlb_Municipio.Create(AOwner: TComponent);
begin
  inherited;

end;

destructor TGlb_Municipio.Destroy;
begin

  inherited;
end;

//--

function TGlb_Municipio.GetMapping: PmMapping;
begin
  Result := New(PmMapping);

  Result.Tabela := New(PmTabela);
  with Result.Tabela^ do begin
    Nome := 'GLB_MUNICIPIO';
  end;

  Result.Campos := TmCampos.Create;
  with Result.Campos do begin
    Add('Cd_Municipio', 'CD_MUNICIPIO', tfKey);
    Add('U_Version', 'U_VERSION', tfNul);
    Add('Cd_Cep', 'CD_CEP', tfNul);
    Add('Cd_Estado', 'CD_ESTADO', tfNul);
    Add('Cd_Operador', 'CD_OPERADOR', tfNul);
    Add('Dt_Cadastro', 'DT_CADASTRO', tfNul);
    Add('Nm_Municipio', 'NM_MUNICIPIO', tfNul);
    Add('Ds_Sigla', 'DS_SIGLA', tfNul);
    Add('Tp_Municipio', 'TP_MUNICIPIO', tfNul);
  end;

  Result.Relacoes := TmRelacoes.Create;
  with Result.Relacoes do begin
  end;
end;

//--

{ TGlb_Municipios }

function TGlb_Municipios.Add: TGlb_Municipio;
begin
  Result := TGlb_Municipio.Create(nil);
  Self.Add(Result);
end;

end.