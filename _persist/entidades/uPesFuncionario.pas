unit uPesFuncionario;

interface

uses
  Classes, SysUtils,
  cCollection, cCollectionItem;

type
  TPes_Funcionario = class;
  TPes_FuncionarioClass = class of TPes_Funcionario;

  TPes_FuncionarioList = class;
  TPes_FuncionarioListClass = class of TPes_FuncionarioList;

  TPes_Funcionario = class(TcCollectionItem)
  private
    fCd_Pessoa: Real;
    fU_Version: String;
    fCd_Operador: Real;
    fDt_Cadastro: TDateTime;
    fCd_Auxiliar: Real;
  public
    constructor Create; reintroduce;
    destructor Destroy; override;
  published
    property Cd_Pessoa : Real read fCd_Pessoa write fCd_Pessoa;
    property U_Version : String read fU_Version write fU_Version;
    property Cd_Operador : Real read fCd_Operador write fCd_Operador;
    property Dt_Cadastro : TDateTime read fDt_Cadastro write fDt_Cadastro;
    property Cd_Auxiliar : Real read fCd_Auxiliar write fCd_Auxiliar;
  end;

  TPes_FuncionarioList = class(TcCollection)
  private
    function GetItem(Index: Integer): TPes_Funcionario;
    procedure SetItem(Index: Integer; Value: TPes_Funcionario);
  public
    constructor Create(AOwner: TPersistent);
    function Add: TPes_Funcionario;
    property Items[Index: Integer]: TPes_Funcionario read GetItem write SetItem; default;
  end;
  
implementation

{ TPes_Funcionario }

constructor TPes_Funcionario.Create;
begin

end;

destructor TPes_Funcionario.Destroy;
begin

  inherited;
end;

{ TPes_FuncionarioList }

constructor TPes_FuncionarioList.Create(AOwner: TPersistent);
begin
  inherited Create(TPes_Funcionario);
end;

function TPes_FuncionarioList.Add: TPes_Funcionario;
begin
  Result := TPes_Funcionario(inherited Add);
  Result.create;
end;

function TPes_FuncionarioList.GetItem(Index: Integer): TPes_Funcionario;
begin
  Result := TPes_Funcionario(inherited GetItem(Index));
end;

procedure TPes_FuncionarioList.SetItem(Index: Integer; Value: TPes_Funcionario);
begin
  inherited SetItem(Index, Value);
end;

end.