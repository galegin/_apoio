unit uAdmLncmp;

interface

uses
  Classes, SysUtils,
  cCollection, cCollectionItem;

type
  TAdm_Lncmp = class;
  TAdm_LncmpClass = class of TAdm_Lncmp;

  TAdm_LncmpList = class;
  TAdm_LncmpListClass = class of TAdm_LncmpList;

  TAdm_Lncmp = class(TcCollectionItem)
  private
    fCd_Componente: String;
    fU_Version: String;
    fCd_Operador: Real;
    fDt_Cadastro: TDateTime;
    fIn_Todos: String;
  public
    constructor Create; reintroduce;
    destructor Destroy; override;
  published
    property Cd_Componente : String read fCd_Componente write fCd_Componente;
    property U_Version : String read fU_Version write fU_Version;
    property Cd_Operador : Real read fCd_Operador write fCd_Operador;
    property Dt_Cadastro : TDateTime read fDt_Cadastro write fDt_Cadastro;
    property In_Todos : String read fIn_Todos write fIn_Todos;
  end;

  TAdm_LncmpList = class(TcCollection)
  private
    function GetItem(Index: Integer): TAdm_Lncmp;
    procedure SetItem(Index: Integer; Value: TAdm_Lncmp);
  public
    constructor Create(AOwner: TPersistent);
    function Add: TAdm_Lncmp;
    property Items[Index: Integer]: TAdm_Lncmp read GetItem write SetItem; default;
  end;
  
implementation

{ TAdm_Lncmp }

constructor TAdm_Lncmp.Create;
begin

end;

destructor TAdm_Lncmp.Destroy;
begin

  inherited;
end;

{ TAdm_LncmpList }

constructor TAdm_LncmpList.Create(AOwner: TPersistent);
begin
  inherited Create(TAdm_Lncmp);
end;

function TAdm_LncmpList.Add: TAdm_Lncmp;
begin
  Result := TAdm_Lncmp(inherited Add);
  Result.create;
end;

function TAdm_LncmpList.GetItem(Index: Integer): TAdm_Lncmp;
begin
  Result := TAdm_Lncmp(inherited GetItem(Index));
end;

procedure TAdm_LncmpList.SetItem(Index: Integer; Value: TAdm_Lncmp);
begin
  inherited SetItem(Index, Value);
end;

end.