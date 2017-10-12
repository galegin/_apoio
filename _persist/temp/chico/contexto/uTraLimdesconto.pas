unit uTraLimdesconto;

interface

uses
  Classes, SysUtils,
  mMapping;

type
  TTra_Limdesconto = class(TmMapping)
  private
    fCd_Operacao: String;
    fCd_Usuario: String;
    fU_Version: String;
    fPr_Descmax: String;
    fCd_Operador: String;
    fDt_Cadastro: String;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function GetMapping() : PmMapping; override;
  published
    property Cd_Operacao : String read fCd_Operacao write fCd_Operacao;
    property Cd_Usuario : String read fCd_Usuario write fCd_Usuario;
    property U_Version : String read fU_Version write fU_Version;
    property Pr_Descmax : String read fPr_Descmax write fPr_Descmax;
    property Cd_Operador : String read fCd_Operador write fCd_Operador;
    property Dt_Cadastro : String read fDt_Cadastro write fDt_Cadastro;
  end;

  TTra_Limdescontos = class(TList)
  public
    function Add: TTra_Limdesconto; overload;
  end;

implementation

{ TTra_Limdesconto }

constructor TTra_Limdesconto.Create(AOwner: TComponent);
begin
  inherited;

end;

destructor TTra_Limdesconto.Destroy;
begin

  inherited;
end;

//--

function TTra_Limdesconto.GetMapping: PmMapping;
begin
  Result := New(PmMapping);

  Result.Tabela := New(PmTabela);
  with Result.Tabela^ do begin
    Nome := 'TRA_LIMDESCONTO';
  end;

  Result.Campos := TmCampos.Create;
  with Result.Campos do begin
    Add('Cd_Operacao', 'CD_OPERACAO', tfKey);
    Add('Cd_Usuario', 'CD_USUARIO', tfKey);
    Add('U_Version', 'U_VERSION', tfNul);
    Add('Pr_Descmax', 'PR_DESCMAX', tfReq);
    Add('Cd_Operador', 'CD_OPERADOR', tfReq);
    Add('Dt_Cadastro', 'DT_CADASTRO', tfReq);
  end;

  Result.Relacoes := TmRelacoes.Create;
  with Result.Relacoes do begin
  end;
end;

//--

{ TTra_Limdescontos }

function TTra_Limdescontos.Add: TTra_Limdesconto;
begin
  Result := TTra_Limdesconto.Create(nil);
  Self.Add(Result);
end;

end.