unit uPrdCor;

interface

uses
  Classes, SysUtils,
  mCollection, mCollectionItem;

type
  TPrd_Cor = class;
  TPrd_CorClass = class of TPrd_Cor;

  TPrd_CorList = class;
  TPrd_CorListClass = class of TPrd_CorList;

  TPrd_Cor = class(TmCollectionItem)
  private
    fCd_Cor: String;
    fU_Version: String;
    fCd_Operador: String;
    fDt_Cadastro: String;
    fDs_Cor: String;
  public
    constructor Create(ACollection: TCollection); override;
    destructor Destroy; override;
  published
    property Cd_Cor : String read fCd_Cor write SetCd_Cor;
    property U_Version : String read fU_Version write SetU_Version;
    property Cd_Operador : String read fCd_Operador write SetCd_Operador;
    property Dt_Cadastro : String read fDt_Cadastro write SetDt_Cadastro;
    property Ds_Cor : String read fDs_Cor write SetDs_Cor;
  end;

  TPrd_CorList = class(TmCollection)
  private
    function GetItem(Index: Integer): TPrd_Cor;
    procedure SetItem(Index: Integer; Value: TPrd_Cor);
  public
    constructor Create(AOwner: TPersistentCollection);
    function Add: TPrd_Cor;
    property Items[Index: Integer]: TPrd_Cor read GetItem write SetItem; default;
  end;

implementation

{ TPrd_Cor }

constructor TPrd_Cor.Create(ACollection: TCollection);
begin
  inherited;

end;

destructor TPrd_Cor.Destroy;
begin

  inherited;
end;

{ TPrd_CorList }

constructor TPrd_CorList.Create(AOwner: TPersistentCollection);
begin
  inherited Create(TPrd_Cor);
end;

function TPrd_CorList.Add: TPrd_Cor;
begin
  Result := TPrd_Cor(inherited Add);
  Result.create;
end;

function TPrd_CorList.GetItem(Index: Integer): TPrd_Cor;
begin
  Result := TPrd_Cor(inherited GetItem(Index));
end;

procedure TPrd_CorList.SetItem(Index: Integer; Value: TPrd_Cor);
begin
  inherited SetItem(Index, Value);
end;

end.