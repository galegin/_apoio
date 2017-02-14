unit uPrdTipoclas;

interface

uses
  Classes, SysUtils,
  cCollection, cCollectionItem;

type
  TPrd_Tipoclas = class;
  TPrd_TipoclasClass = class of TPrd_Tipoclas;

  TPrd_TipoclasList = class;
  TPrd_TipoclasListClass = class of TPrd_TipoclasList;

  TPrd_Tipoclas = class(TcCollectionItem)
  private
    fCd_Tipoclas: Real;
    fU_Version: String;
    fCd_Operador: Real;
    fDt_Cadastro: TDateTime;
    fDs_Tipoclas: String;
    fIn_Grupo: String;
  public
    constructor Create; reintroduce;
    destructor Destroy; override;
  published
    property Cd_Tipoclas : Real read fCd_Tipoclas write fCd_Tipoclas;
    property U_Version : String read fU_Version write fU_Version;
    property Cd_Operador : Real read fCd_Operador write fCd_Operador;
    property Dt_Cadastro : TDateTime read fDt_Cadastro write fDt_Cadastro;
    property Ds_Tipoclas : String read fDs_Tipoclas write fDs_Tipoclas;
    property In_Grupo : String read fIn_Grupo write fIn_Grupo;
  end;

  TPrd_TipoclasList = class(TcCollection)
  private
    function GetItem(Index: Integer): TPrd_Tipoclas;
    procedure SetItem(Index: Integer; Value: TPrd_Tipoclas);
  public
    constructor Create(AOwner: TPersistent);
    function Add: TPrd_Tipoclas;
    property Items[Index: Integer]: TPrd_Tipoclas read GetItem write SetItem; default;
  end;
  
implementation

{ TPrd_Tipoclas }

constructor TPrd_Tipoclas.Create;
begin

end;

destructor TPrd_Tipoclas.Destroy;
begin

  inherited;
end;

{ TPrd_TipoclasList }

constructor TPrd_TipoclasList.Create(AOwner: TPersistent);
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