unit uAdmIprmemp;

interface

uses
  Classes, SysUtils,
  mMapping;

type
  TAdm_Iprmemp = class(TmMapping)
  private
    fCd_Empresa: String;
    fCd_Parametro: String;
    fU_Version: String;
    fVl_Parametro: String;
    fCd_Operador: String;
    fDt_Cadastro: String;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function GetMapping() : PmMapping; override;
  published
    property Cd_Empresa : String read fCd_Empresa write fCd_Empresa;
    property Cd_Parametro : String read fCd_Parametro write fCd_Parametro;
    property U_Version : String read fU_Version write fU_Version;
    property Vl_Parametro : String read fVl_Parametro write fVl_Parametro;
    property Cd_Operador : String read fCd_Operador write fCd_Operador;
    property Dt_Cadastro : String read fDt_Cadastro write fDt_Cadastro;
  end;

  TAdm_Iprmemps = class(TList)
  public
    function Add: TAdm_Iprmemp; overload;
  end;

implementation

{ TAdm_Iprmemp }

constructor TAdm_Iprmemp.Create(AOwner: TComponent);
begin
  inherited;

end;

destructor TAdm_Iprmemp.Destroy;
begin

  inherited;
end;

//--

function TAdm_Iprmemp.GetMapping: PmMapping;
begin
  Result := New(PmMapping);

  Result.Tabela := New(PmTabela);
  with Result.Tabela^ do begin
    Nome := 'ADM_IPRMEMP';
  end;

  Result.Campos := TmCampos.Create;
  with Result.Campos do begin
    Add('Cd_Empresa', 'CD_EMPRESA', tfKey);
    Add('Cd_Parametro', 'CD_PARAMETRO', tfKey);
    Add('U_Version', 'U_VERSION', tfNul);
    Add('Vl_Parametro', 'VL_PARAMETRO', tfNul);
    Add('Cd_Operador', 'CD_OPERADOR', tfReq);
    Add('Dt_Cadastro', 'DT_CADASTRO', tfReq);
  end;

  Result.Relacoes := TmRelacoes.Create;
  with Result.Relacoes do begin
  end;
end;

//--

{ TAdm_Iprmemps }

function TAdm_Iprmemps.Add: TAdm_Iprmemp;
begin
  Result := TAdm_Iprmemp.Create(nil);
  Self.Add(Result);
end;

end.