unit uGlbPais;

interface

uses
  Classes, SysUtils,
  mMapping;

type
  TGlb_Pais = class(TmMapping)
  private
    fCd_Pais: String;
    fU_Version: String;
    fCd_Operador: String;
    fDt_Cadastro: String;
    fNm_Pais: String;
    fCd_Paisbcb: String;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function GetMapping() : PmMapping; override;
  published
    property Cd_Pais : String read fCd_Pais write fCd_Pais;
    property U_Version : String read fU_Version write fU_Version;
    property Cd_Operador : String read fCd_Operador write fCd_Operador;
    property Dt_Cadastro : String read fDt_Cadastro write fDt_Cadastro;
    property Nm_Pais : String read fNm_Pais write fNm_Pais;
    property Cd_Paisbcb : String read fCd_Paisbcb write fCd_Paisbcb;
  end;

  TGlb_Paiss = class(TList)
  public
    function Add: TGlb_Pais; overload;
  end;

implementation

{ TGlb_Pais }

constructor TGlb_Pais.Create(AOwner: TComponent);
begin
  inherited;

end;

destructor TGlb_Pais.Destroy;
begin

  inherited;
end;

//--

function TGlb_Pais.GetMapping: PmMapping;
begin
  Result := New(PmMapping);

  Result.Tabela := New(PmTabela);
  with Result.Tabela^ do begin
    Nome := 'GLB_PAIS';
  end;

  Result.Campos := TmCampos.Create;
  with Result.Campos do begin
    Add('Cd_Pais', 'CD_PAIS', tfKey);
    Add('U_Version', 'U_VERSION', tfNul);
    Add('Cd_Operador', 'CD_OPERADOR', tfNul);
    Add('Dt_Cadastro', 'DT_CADASTRO', tfNul);
    Add('Nm_Pais', 'NM_PAIS', tfNul);
    Add('Cd_Paisbcb', 'CD_PAISBCB', tfNul);
  end;

  Result.Relacoes := TmRelacoes.Create;
  with Result.Relacoes do begin
  end;
end;

//--

{ TGlb_Paiss }

function TGlb_Paiss.Add: TGlb_Pais;
begin
  Result := TGlb_Pais.Create(nil);
  Self.Add(Result);
end;

end.