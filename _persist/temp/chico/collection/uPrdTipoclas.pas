unit uPrdTipoclas;

interface

uses
  Classes, SysUtils,
  mCollection, mCollectionItem;

type
  TPrd_Tipoclas = class;
  TPrd_TipoclasClass = class of TPrd_Tipoclas;

  TPrd_TipoclasList = class;
  TPrd_TipoclasListClass = class of TPrd_TipoclasList;

  TPrd_Tipoclas = class(TmCollectionItem)
  private
    fCd_Tipoclas: String;
    fU_Version: String;
    fCd_Operador: String;
    fDt_Cadastro: String;
    fDs_Tipoclas: String;
    fIn_Grupo: String;
  public
    constructor Create(ACollection: TCollection); override;
    destructor Destroy; override;
  published
    property Cd_Tipoclas : String read fCd_Tipoclas write SetCd_Tipoclas;
    property U_Version : String read fU_Version write SetU_Version;
    property Cd_Operador : String read fCd_Operador write SetCd_Operador;
    property Dt_Cadastro : String read fDt_Cadastro write SetDt_Cadastro;
    property Ds_Tipoclas : String read fDs_Tipoclas write SetDs_Tipoclas;
    property In_Grupo : String read fIn_Grupo write SetIn_Grupo;
  end;

  TPrd_TipoclasList = class(TmCollection)
  private
    function GetItem(Index: Integer): TPrd_Tipoclas;
    procedure SetItem(Index: Integer; Value: TPrd_Tipoclas);
  public
    constructor Create(AOwner: TPersistentCollection);
    function Add: TPrd_Tipoclas;
    property Items[Index: Integer]: TPrd_Tipoclas read GetItem write SetItem; default;
  end;

implementation

{ TPrd_Tipoclas }

constructor TPrd_Tipoclas.Create(ACollection: TCollection);
begin
  inherited;

end;

destructor TPrd_Tipoclas.Destroy;
begin

  inherited;
end;

{ TPrd_TipoclasList }

constructor TPrd_TipoclasList.Create(AOwner: TPersistentCollection);
begin
  inherited Create(TPrd_Tipoclas);
end;

function TPrd_TipoclasList.Add: TPrd_Tipoclas;
begin
  Result := TPrd_Tipoclas(inherited Add);
  Result.create;
end;

function TPrd_TipoclasList.GetItem(Index: Integer): TPrd_Tipoclas;
begin
  Result := TPrd_Tipoclas(inherited GetItem(Index));
end;

procedure TPrd_TipoclasList.SetItem(Index: Integer; Value: TPrd_Tipoclas);
begin
  inherited SetItem(Index, Value);
end;

end.