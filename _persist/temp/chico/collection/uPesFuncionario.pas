unit uPesFuncionario;

interface

uses
  Classes, SysUtils,
  mCollection, mCollectionItem;

type
  TPes_Funcionario = class;
  TPes_FuncionarioClass = class of TPes_Funcionario;

  TPes_FuncionarioList = class;
  TPes_FuncionarioListClass = class of TPes_FuncionarioList;

  TPes_Funcionario = class(TmCollectionItem)
  private
    fCd_Pessoa: String;
    fU_Version: String;
    fCd_Operador: String;
    fDt_Cadastro: String;
    fCd_Auxiliar: String;
  public
    constructor Create(ACollection: TCollection); override;
    destructor Destroy; override;
  published
    property Cd_Pessoa : String read fCd_Pessoa write SetCd_Pessoa;
    property U_Version : String read fU_Version write SetU_Version;
    property Cd_Operador : String read fCd_Operador write SetCd_Operador;
    property Dt_Cadastro : String read fDt_Cadastro write SetDt_Cadastro;
    property Cd_Auxiliar : String read fCd_Auxiliar write SetCd_Auxiliar;
  end;

  TPes_FuncionarioList = class(TmCollection)
  private
    function GetItem(Index: Integer): TPes_Funcionario;
    procedure SetItem(Index: Integer; Value: TPes_Funcionario);
  public
    constructor Create(AOwner: TPersistentCollection);
    function Add: TPes_Funcionario;
    property Items[Index: Integer]: TPes_Funcionario read GetItem write SetItem; default;
  end;

implementation

{ TPes_Funcionario }

constructor TPes_Funcionario.Create(ACollection: TCollection);
begin
  inherited;

end;

destructor TPes_Funcionario.Destroy;
begin

  inherited;
end;

{ TPes_FuncionarioList }

constructor TPes_FuncionarioList.Create(AOwner: TPersistentCollection);
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