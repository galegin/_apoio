unit uGerEmpresa;

interface

uses
  Classes, SysUtils,
  mMapping;

type
  TGer_Empresa = class(TmMapping)
  private
    fCd_Empresa: String;
    fU_Version: String;
    fCd_Grupoempresa: String;
    fCd_Operador: String;
    fCd_Pessoa: String;
    fDt_Cadastro: String;
    fCd_Ccusto: String;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function GetMapping() : PmMapping; override;
  published
    property Cd_Empresa : String read fCd_Empresa write fCd_Empresa;
    property U_Version : String read fU_Version write fU_Version;
    property Cd_Grupoempresa : String read fCd_Grupoempresa write fCd_Grupoempresa;
    property Cd_Operador : String read fCd_Operador write fCd_Operador;
    property Cd_Pessoa : String read fCd_Pessoa write fCd_Pessoa;
    property Dt_Cadastro : String read fDt_Cadastro write fDt_Cadastro;
    property Cd_Ccusto : String read fCd_Ccusto write fCd_Ccusto;
  end;

  TGer_Empresas = class(TList)
  public
    function Add: TGer_Empresa; overload;
  end;

implementation

{ TGer_Empresa }

constructor TGer_Empresa.Create(AOwner: TComponent);
begin
  inherited;

end;

destructor TGer_Empresa.Destroy;
begin

  inherited;
end;

//--

function TGer_Empresa.GetMapping: PmMapping;
begin
  Result := New(PmMapping);

  Result.Tabela := New(PmTabela);
  with Result.Tabela^ do begin
    Nome := 'GER_EMPRESA';
  end;

  Result.Campos := TmCampos.Create;
  with Result.Campos do begin
    Add('Cd_Empresa', 'CD_EMPRESA', tfKey);
    Add('U_Version', 'U_VERSION', tfNul);
    Add('Cd_Grupoempresa', 'CD_GRUPOEMPRESA', tfReq);
    Add('Cd_Operador', 'CD_OPERADOR', tfReq);
    Add('Cd_Pessoa', 'CD_PESSOA', tfReq);
    Add('Dt_Cadastro', 'DT_CADASTRO', tfReq);
    Add('Cd_Ccusto', 'CD_CCUSTO', tfNul);
  end;

  Result.Relacoes := TmRelacoes.Create;
  with Result.Relacoes do begin
  end;
end;

//--

{ TGer_Empresas }

function TGer_Empresas.Add: TGer_Empresa;
begin
  Result := TGer_Empresa.Create(nil);
  Self.Add(Result);
end;

end.