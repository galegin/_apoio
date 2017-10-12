unit uPrdGradei;

interface

uses
  Classes, SysUtils,
  mCollection, mCollectionItem;

type
  TPrd_Gradei = class;
  TPrd_GradeiClass = class of TPrd_Gradei;

  TPrd_GradeiList = class;
  TPrd_GradeiListClass = class of TPrd_GradeiList;

  TPrd_Gradei = class(TmCollectionItem)
  private
    fCd_Grade: String;
    fCd_Tamanho: String;
    fU_Version: String;
    fCd_Operador: String;
    fDt_Cadastro: String;
    fDs_Tamanho: String;
  public
    constructor Create(ACollection: TCollection); override;
    destructor Destroy; override;
  published
    property Cd_Grade : String read fCd_Grade write SetCd_Grade;
    property Cd_Tamanho : String read fCd_Tamanho write SetCd_Tamanho;
    property U_Version : String read fU_Version write SetU_Version;
    property Cd_Operador : String read fCd_Operador write SetCd_Operador;
    property Dt_Cadastro : String read fDt_Cadastro write SetDt_Cadastro;
    property Ds_Tamanho : String read fDs_Tamanho write SetDs_Tamanho;
  end;

  TPrd_GradeiList = class(TmCollection)
  private
    function GetItem(Index: Integer): TPrd_Gradei;
    procedure SetItem(Index: Integer; Value: TPrd_Gradei);
  public
    constructor Create(AOwner: TPersistentCollection);
    function Add: TPrd_Gradei;
    property Items[Index: Integer]: TPrd_Gradei read GetItem write SetItem; default;
  end;

implementation

{ TPrd_Gradei }

constructor TPrd_Gradei.Create(ACollection: TCollection);
begin
  inherited;

end;

destructor TPrd_Gradei.Destroy;
begin

  inherited;
end;

{ TPrd_GradeiList }

constructor TPrd_GradeiList.Create(AOwner: TPersistentCollection);
begin
  inherited Create(TPrd_Gradei);
end;

function TPrd_GradeiList.Add: TPrd_Gradei;
begin
  Result := TPrd_Gradei(inherited Add);
  Result.create;
end;

function TPrd_GradeiList.GetItem(Index: Integer): TPrd_Gradei;
begin
  Result := TPrd_Gradei(inherited GetItem(Index));
end;

procedure TPrd_GradeiList.SetItem(Index: Integer; Value: TPrd_Gradei);
begin
  inherited SetItem(Index, Value);
end;

end.