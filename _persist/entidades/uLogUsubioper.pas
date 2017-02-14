unit uLogUsubioper;

interface

uses
  Classes, SysUtils,
  cCollection, cCollectionItem;

type
  TLog_Usubioper = class;
  TLog_UsubioperClass = class of TLog_Usubioper;

  TLog_UsubioperList = class;
  TLog_UsubioperListClass = class of TLog_UsubioperList;

  TLog_Usubioper = class(TcCollectionItem)
  private
    fCd_Usuario: Real;
    fU_Version: String;
    fCd_Operador: Real;
    fDt_Cadastro: TDateTime;
  public
    constructor Create; reintroduce;
    destructor Destroy; override;
  published
    property Cd_Usuario : Real read fCd_Usuario write fCd_Usuario;
    property U_Version : String read fU_Version write fU_Version;
    property Cd_Operador : Real read fCd_Operador write fCd_Operador;
    property Dt_Cadastro : TDateTime read fDt_Cadastro write fDt_Cadastro;
  end;

  TLog_UsubioperList = class(TcCollection)
  private
    function GetItem(Index: Integer): TLog_Usubioper;
    procedure SetItem(Index: Integer; Value: TLog_Usubioper);
  public
    constructor Create(AOwner: TPersistent);
    function Add: TLog_Usubioper;
    property Items[Index: Integer]: TLog_Usubioper read GetItem write SetItem; default;
  end;
  
implementation

{ TLog_Usubioper }

constructor TLog_Usubioper.Create;
begin

end;

destructor TLog_Usubioper.Destroy;
begin

  inherited;
end;

{ TLog_UsubioperList }

constructor TLog_UsubioperList.Create(AOwner: TPersistent);
begin
  inherited Create(TLog_Usubioper);
end;

function TLog_UsubioperList.Add: TLog_Usubioper;
begin
  Result := TLog_Usubioper(inherited Add);
  Result.create;
end;

function TLog_UsubioperList.GetItem(Index: Integer): TLog_Usubioper;
begin
  Result := TLog_Usubioper(inherited GetItem(Index));
end;

procedure TLog_UsubioperList.SetItem(Index: Integer; Value: TLog_Usubioper);
begin
  inherited SetItem(Index, Value);
end;

end.