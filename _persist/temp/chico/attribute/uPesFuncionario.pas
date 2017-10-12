unit uPesFuncionario;

interface

uses
  Classes, SysUtils,
  System.Generics.Collections,
  mMapping;

type
  [Tabela('PES_FUNCIONARIO')]
  TPes_Funcionario = class(TmMapping)
  private
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
  published
    [Campo('CD_PESSOA', tfKey)]
    property Cd_Pessoa : String read fCd_Pessoa write fCd_Pessoa;
    [Campo('U_VERSION', tfNul)]
    property U_Version : String read fU_Version write fU_Version;
    [Campo('CD_OPERADOR', tfReq)]
    property Cd_Operador : String read fCd_Operador write fCd_Operador;
    [Campo('DT_CADASTRO', tfReq)]
    property Dt_Cadastro : String read fDt_Cadastro write fDt_Cadastro;
    [Campo('CD_AUXILIAR', tfNul)]
    property Cd_Auxiliar : String read fCd_Auxiliar write fCd_Auxiliar;
  end;

  TPes_Funcionarios = class(TList<Pes_Funcionario>);

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

end.