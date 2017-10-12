unit uGlbEstado;

interface

uses
  Classes, SysUtils,
  mMapping;

type
  TGlb_Estado = class(TmMapping)
  private
    fCd_Estado: String;
    fU_Version: String;
    fCd_Pais: String;
    fDs_Sigla: String;
    fCd_Operador: String;
    fDt_Cadastro: String;
    fNm_Estado: String;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function GetMapping() : PmMapping; override;
  published
    property Cd_Estado : String read fCd_Estado write fCd_Estado;
    property U_Version : String read fU_Version write fU_Version;
    property Cd_Pais : String read fCd_Pais write fCd_Pais;
    property Ds_Sigla : String read fDs_Sigla write fDs_Sigla;
    property Cd_Operador : String read fCd_Operador write fCd_Operador;
    property Dt_Cadastro : String read fDt_Cadastro write fDt_Cadastro;
    property Nm_Estado : String read fNm_Estado write fNm_Estado;
  end;

  TGlb_Estados = class(TList)
  public
    function Add: TGlb_Estado; overload;
  end;

implementation

{ TGlb_Estado }

constructor TGlb_Estado.Create(AOwner: TComponent);
begin
  inherited;

end;

destructor TGlb_Estado.Destroy;
begin

  inherited;
end;

//--

function TGlb_Estado.GetMapping: PmMapping;
begin
  Result := New(PmMapping);

  Result.Tabela := New(PmTabela);
  with Result.Tabela^ do begin
    Nome := 'GLB_ESTADO';
  end;

  Result.Campos := TmCampos.Create;
  with Result.Campos do begin
    Add('Cd_Estado', 'CD_ESTADO', tfKey);
    Add('U_Version', 'U_VERSION', tfNul);
    Add('Cd_Pais', 'CD_PAIS', tfNul);
    Add('Ds_Sigla', 'DS_SIGLA', tfNul);
    Add('Cd_Operador', 'CD_OPERADOR', tfNul);
    Add('Dt_Cadastro', 'DT_CADASTRO', tfNul);
    Add('Nm_Estado', 'NM_ESTADO', tfNul);
  end;

  Result.Relacoes := TmRelacoes.Create;
  with Result.Relacoes do begin
  end;
end;

//--

{ TGlb_Estados }

function TGlb_Estados.Add: TGlb_Estado;
begin
  Result := TGlb_Estado.Create(nil);
  Self.Add(Result);
end;

end.