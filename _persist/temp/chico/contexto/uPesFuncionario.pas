unit uPesFuncionario;

interface

uses
  Classes, SysUtils,
  mMapping;

type
  TPes_Funcionario = class(TmMapping)
  private
    fCd_Pessoa: String;
    fU_Version: String;
    fCd_Operador: String;
    fDt_Cadastro: String;
    fCd_Auxiliar: String;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function GetMapping() : PmMapping; override;
  published
    property Cd_Pessoa : String read fCd_Pessoa write fCd_Pessoa;
    property U_Version : String read fU_Version write fU_Version;
    property Cd_Operador : String read fCd_Operador write fCd_Operador;
    property Dt_Cadastro : String read fDt_Cadastro write fDt_Cadastro;
    property Cd_Auxiliar : String read fCd_Auxiliar write fCd_Auxiliar;
  end;

  TPes_Funcionarios = class(TList)
  public
    function Add: TPes_Funcionario; overload;
  end;

implementation

{ TPes_Funcionario }

constructor TPes_Funcionario.Create(AOwner: TComponent);
begin
  inherited;

end;

destructor TPes_Funcionario.Destroy;
begin

  inherited;
end;

//--

function TPes_Funcionario.GetMapping: PmMapping;
begin
  Result := New(PmMapping);

  Result.Tabela := New(PmTabela);
  with Result.Tabela^ do begin
    Nome := 'PES_FUNCIONARIO';
  end;

  Result.Campos := TmCampos.Create;
  with Result.Campos do begin
    Add('Cd_Pessoa', 'CD_PESSOA', tfKey);
    Add('U_Version', 'U_VERSION', tfNul);
    Add('Cd_Operador', 'CD_OPERADOR', tfReq);
    Add('Dt_Cadastro', 'DT_CADASTRO', tfReq);
    Add('Cd_Auxiliar', 'CD_AUXILIAR', tfNul);
  end;

  Result.Relacoes := TmRelacoes.Create;
  with Result.Relacoes do begin
  end;
end;

//--

{ TPes_Funcionarios }

function TPes_Funcionarios.Add: TPes_Funcionario;
begin
  Result := TPes_Funcionario.Create(nil);
  Self.Add(Result);
end;

end.