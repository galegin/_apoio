unit uPrdFibra;

interface

uses
  Classes, SysUtils,
  cCollection, cCollectionItem;

type
  TPrd_Fibra = class;
  TPrd_FibraClass = class of TPrd_Fibra;

  TPrd_FibraList = class;
  TPrd_FibraListClass = class of TPrd_FibraList;

  TPrd_Fibra = class(TcCollectionItem)
  private
    fCd_Fibra: Real;
    fU_Version: String;
    fCd_Operador: Real;
    fDt_Cadastro: TDateTime;
    fDs_Fibra: String;
  public
    constructor Create; reintroduce;
    destructor Destroy; override;
  published
    property Cd_Fibra : Real read fCd_Fibra write fCd_Fibra;
    property U_Version : String read fU_Version write fU_Version;
    property Cd_Operador : Real read fCd_Operador write fCd_Operador;
    property Dt_Cadastro : TDateTime read fDt_Cadastro write fDt_Cadastro;
    property Ds_Fibra : String read fDs_Fibra write fDs_Fibra;
  end;

  TPrd_FibraList = class(TcCollection)
  private
    function GetItem(Index: Integer): TPrd_Fibra;
    procedure SetItem(Index: Integer; Value: TPrd_Fibra);
  public
    constructor Create(AOwner: TPersistent);
    function Add: TPrd_Fibra;
    property Items[Index: Integer]: TPrd_Fibra read GetItem write SetItem; default;
  end;
  
implementation

{ TPrd_Fibra }

constructor TPrd_Fibra.Create;
begin

end;

destructor TPrd_Fibra.Destroy;
begin

  inherited;
end;

{ TPrd_FibraList }

constructor TPrd_FibraList.Create(AOwner: TPersistent);
begin
  inherited Create(TPrd_Fibra);
end;

function TPrd_FibraList.Add: TPrd_Fibra;
begin
  Result := TPrd_Fibra(inherited Add);
  Result.create;
end;

function TPrd_FibraList.GetItem(Index: Integer): TPrd_Fibra;
begin
  Result := TPrd_Fibra(inherited GetItem(Index));
end;

procedure TPrd_FibraList.SetItem(Index: Integer; Value: TPrd_Fibra);
begin
  inherited SetItem(Index, Value);
end;

end.