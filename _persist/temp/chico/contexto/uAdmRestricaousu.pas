unit uAdmRestricaousu;

interface

uses
  Classes, SysUtils,
  mMapping;

type
  TAdm_Restricaousu = class(TmMapping)
  private
    fCd_Componente: String;
    fDs_Campo: String;
    fCd_Empresa: String;
    fCd_Usuario: String;
    fU_Version: String;
    fCd_Operador: String;
    fDt_Cadastro: String;
    fVl_Inicio: String;
    fVl_Fim: String;
    fIn_Semrestricao: String;
    fIn_Pedesenha: String;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function GetMapping() : PmMapping; override;
  published
    property Cd_Componente : String read fCd_Componente write fCd_Componente;
    property Ds_Campo : String read fDs_Campo write fDs_Campo;
    property Cd_Empresa : String read fCd_Empresa write fCd_Empresa;
    property Cd_Usuario : String read fCd_Usuario write fCd_Usuario;
    property U_Version : String read fU_Version write fU_Version;
    property Cd_Operador : String read fCd_Operador write fCd_Operador;
    property Dt_Cadastro : String read fDt_Cadastro write fDt_Cadastro;
    property Vl_Inicio : String read fVl_Inicio write fVl_Inicio;
    property Vl_Fim : String read fVl_Fim write fVl_Fim;
    property In_Semrestricao : String read fIn_Semrestricao write fIn_Semrestricao;
    property In_Pedesenha : String read fIn_Pedesenha write fIn_Pedesenha;
  end;

  TAdm_Restricaousus = class(TList)
  public
    function Add: TAdm_Restricaousu; overload;
  end;

implementation

{ TAdm_Restricaousu }

constructor TAdm_Restricaousu.Create(AOwner: TComponent);
begin
  inherited;

end;

destructor TAdm_Restricaousu.Destroy;
begin

  inherited;
end;

//--

function TAdm_Restricaousu.GetMapping: PmMapping;
begin
  Result := New(PmMapping);

  Result.Tabela := New(PmTabela);
  with Result.Tabela^ do begin
    Nome := 'ADM_RESTRICAOUSU';
  end;

  Result.Campos := TmCampos.Create;
  with Result.Campos do begin
    Add('Cd_Componente', 'CD_COMPONENTE', tfKey);
    Add('Ds_Campo', 'DS_CAMPO', tfKey);
    Add('Cd_Empresa', 'CD_EMPRESA', tfKey);
    Add('Cd_Usuario', 'CD_USUARIO', tfKey);
    Add('U_Version', 'U_VERSION', tfNul);
    Add('Cd_Operador', 'CD_OPERADOR', tfReq);
    Add('Dt_Cadastro', 'DT_CADASTRO', tfReq);
    Add('Vl_Inicio', 'VL_INICIO', tfNul);
    Add('Vl_Fim', 'VL_FIM', tfNul);
    Add('In_Semrestricao', 'IN_SEMRESTRICAO', tfNul);
    Add('In_Pedesenha', 'IN_PEDESENHA', tfNul);
  end;

  Result.Relacoes := TmRelacoes.Create;
  with Result.Relacoes do begin
  end;
end;

//--

{ TAdm_Restricaousus }

function TAdm_Restricaousus.Add: TAdm_Restricaousu;
begin
  Result := TAdm_Restricaousu.Create(nil);
  Self.Add(Result);
end;

end.