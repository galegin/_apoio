unit uGlbLogradouro;

interface

uses
  Classes, SysUtils,
  mMapping;

type
  TGlb_Logradouro = class(TmMapping)
  private
    fCd_Cep: String;
    fU_Version: String;
    fCd_Municipio: String;
    fCd_Tplogradouro: String;
    fCd_Bairro: String;
    fCd_Operador: String;
    fDt_Cadastro: String;
    fNm_Logradouro: String;
    fNm_Complemento: String;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function GetMapping() : PmMapping; override;
  published
    property Cd_Cep : String read fCd_Cep write fCd_Cep;
    property U_Version : String read fU_Version write fU_Version;
    property Cd_Municipio : String read fCd_Municipio write fCd_Municipio;
    property Cd_Tplogradouro : String read fCd_Tplogradouro write fCd_Tplogradouro;
    property Cd_Bairro : String read fCd_Bairro write fCd_Bairro;
    property Cd_Operador : String read fCd_Operador write fCd_Operador;
    property Dt_Cadastro : String read fDt_Cadastro write fDt_Cadastro;
    property Nm_Logradouro : String read fNm_Logradouro write fNm_Logradouro;
    property Nm_Complemento : String read fNm_Complemento write fNm_Complemento;
  end;

  TGlb_Logradouros = class(TList)
  public
    function Add: TGlb_Logradouro; overload;
  end;

implementation

{ TGlb_Logradouro }

constructor TGlb_Logradouro.Create(AOwner: TComponent);
begin
  inherited;

end;

destructor TGlb_Logradouro.Destroy;
begin

  inherited;
end;

//--

function TGlb_Logradouro.GetMapping: PmMapping;
begin
  Result := New(PmMapping);

  Result.Tabela := New(PmTabela);
  with Result.Tabela^ do begin
    Nome := 'GLB_LOGRADOURO';
  end;

  Result.Campos := TmCampos.Create;
  with Result.Campos do begin
    Add('Cd_Cep', 'CD_CEP', tfKey);
    Add('U_Version', 'U_VERSION', tfNul);
    Add('Cd_Municipio', 'CD_MUNICIPIO', tfReq);
    Add('Cd_Tplogradouro', 'CD_TPLOGRADOURO', tfNul);
    Add('Cd_Bairro', 'CD_BAIRRO', tfNul);
    Add('Cd_Operador', 'CD_OPERADOR', tfNul);
    Add('Dt_Cadastro', 'DT_CADASTRO', tfNul);
    Add('Nm_Logradouro', 'NM_LOGRADOURO', tfNul);
    Add('Nm_Complemento', 'NM_COMPLEMENTO', tfNul);
  end;

  Result.Relacoes := TmRelacoes.Create;
  with Result.Relacoes do begin
  end;
end;

//--

{ TGlb_Logradouros }

function TGlb_Logradouros.Add: TGlb_Logradouro;
begin
  Result := TGlb_Logradouro.Create(nil);
  Self.Add(Result);
end;

end.