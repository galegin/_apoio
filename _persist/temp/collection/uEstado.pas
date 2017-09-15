unit uEstado;

interface

uses
  Classes, SysUtils,
  mCollection, mCollectionItem;

type
  TEstado = class;
  TEstadoClass = class of TEstado;

  TEstadoList = class;
  TEstadoListClass = class of TEstadoList;

  TEstado = class(TmCollectionItem)
  private
    fId_Estado: Integer;
    fU_Version: String;
    fCd_Operador: Integer;
    fDt_Cadastro: String;
    fCd_Estado: Integer;
    fDs_Estado: String;
    fDs_Sigla: String;
    fId_Pais: Integer;
  public
    constructor Create(ACollection: TCollection); override;
    destructor Destroy; override;
  published
    property Id_Estado : Integer read fId_Estado write SetId_Estado;
    property U_Version : String read fU_Version write SetU_Version;
    property Cd_Operador : Integer read fCd_Operador write SetCd_Operador;
    property Dt_Cadastro : String read fDt_Cadastro write SetDt_Cadastro;
    property Cd_Estado : Integer read fCd_Estado write SetCd_Estado;
    property Ds_Estado : String read fDs_Estado write SetDs_Estado;
    property Ds_Sigla : String read fDs_Sigla write SetDs_Sigla;
    property Id_Pais : Integer read fId_Pais write SetId_Pais;
  end;

  TEstadoList = class(TmCollection)
  private
    function GetItem(Index: Integer): TEstado;
    procedure SetItem(Index: Integer; Value: TEstado);
  public
    constructor Create(AOwner: TPersistentCollection);
    function Add: TEstado;
    property Items[Index: Integer]: TEstado read GetItem write SetItem; default;
  end;

implementation

{ TEstado }

constructor TEstado.Create(ACollection: TCollection);
begin
  inherited;

end;

destructor TEstado.Destroy;
begin

  inherited;
end;

{ TEstadoList }

constructor TEstadoList.Create(AOwner: TPersistentCollection);
begin
  inherited Create(TEstado);
end;

function TEstadoList.Add: TEstado;
begin
  Result := TEstado(inherited Add);
  Result.create;
end;

function TEstadoList.GetItem(Index: Integer): TEstado;
begin
  Result := TEstado(inherited GetItem(Index));
end;

procedure TEstadoList.SetItem(Index: Integer; Value: TEstado);
begin
  inherited SetItem(Index, Value);
end;

end.