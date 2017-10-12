unit uPrdValor;

interface

uses
  Classes, SysUtils,
  mMapping;

type
  TPrd_Valor = class(TmMapping)
  private
    fCd_Empresa: String;
    fCd_Produto: String;
    fTp_Valor: String;
    fCd_Valor: String;
    fU_Version: String;
    fCd_Grupoempresa: String;
    fCd_Operador: String;
    fDt_Cadastro: String;
    fVl_Produto: String;
    fIn_Basemarkup: String;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function GetMapping() : PmMapping; override;
  published
    property Cd_Empresa : String read fCd_Empresa write fCd_Empresa;
    property Cd_Produto : String read fCd_Produto write fCd_Produto;
    property Tp_Valor : String read fTp_Valor write fTp_Valor;
    property Cd_Valor : String read fCd_Valor write fCd_Valor;
    property U_Version : String read fU_Version write fU_Version;
    property Cd_Grupoempresa : String read fCd_Grupoempresa write fCd_Grupoempresa;
    property Cd_Operador : String read fCd_Operador write fCd_Operador;
    property Dt_Cadastro : String read fDt_Cadastro write fDt_Cadastro;
    property Vl_Produto : String read fVl_Produto write fVl_Produto;
    property In_Basemarkup : String read fIn_Basemarkup write fIn_Basemarkup;
  end;

  TPrd_Valors = class(TList)
  public
    function Add: TPrd_Valor; overload;
  end;

implementation

{ TPrd_Valor }

constructor TPrd_Valor.Create(AOwner: TComponent);
begin
  inherited;

end;

destructor TPrd_Valor.Destroy;
begin

  inherited;
end;

//--

function TPrd_Valor.GetMapping: PmMapping;
begin
  Result := New(PmMapping);

  Result.Tabela := New(PmTabela);
  with Result.Tabela^ do begin
    Nome := 'PRD_VALOR';
  end;

  Result.Campos := TmCampos.Create;
  with Result.Campos do begin
    Add('Cd_Empresa', 'CD_EMPRESA', tfKey);
    Add('Cd_Produto', 'CD_PRODUTO', tfKey);
    Add('Tp_Valor', 'TP_VALOR', tfKey);
    Add('Cd_Valor', 'CD_VALOR', tfKey);
    Add('U_Version', 'U_VERSION', tfNul);
    Add('Cd_Grupoempresa', 'CD_GRUPOEMPRESA', tfReq);
    Add('Cd_Operador', 'CD_OPERADOR', tfReq);
    Add('Dt_Cadastro', 'DT_CADASTRO', tfReq);
    Add('Vl_Produto', 'VL_PRODUTO', tfNul);
    Add('In_Basemarkup', 'IN_BASEMARKUP', tfNul);
  end;

  Result.Relacoes := TmRelacoes.Create;
  with Result.Relacoes do begin
  end;
end;

//--

{ TPrd_Valors }

function TPrd_Valors.Add: TPrd_Valor;
begin
  Result := TPrd_Valor.Create(nil);
  Self.Add(Result);
end;

end.