unit uPrdGradec;

interface

uses
  Classes, SysUtils,
  mCollection, mCollectionItem;

type
  TPrd_Gradec = class;
  TPrd_GradecClass = class of TPrd_Gradec;

  TPrd_GradecList = class;
  TPrd_GradecListClass = class of TPrd_GradecList;

  TPrd_Gradec = class(TmCollectionItem)
  private
    fCd_Grade: String;
    fU_Version: String;
    fCd_Operador: String;
    fDt_Cadastro: String;
    fDs_Grade: String;
  public
    constructor Create(ACollection: TCollection); override;
    destructor Destroy; override;
  published
    property Cd_Grade : String read fCd_Grade write SetCd_Grade;
    property U_Version : String read fU_Version write SetU_Version;
    property Cd_Operador : String read fCd_Operador write SetCd_Operador;
    property Dt_Cadastro : String read fDt_Cadastro write SetDt_Cadastro;
    property Ds_Grade : String read fDs_Grade write SetDs_Grade;
  end;

  TPrd_GradecList = class(TmCollection)
  private
    function GetItem(Index: Integer): TPrd_Gradec;
    procedure SetItem(Index: Integer; Value: TPrd_Gradec);
  public
    constructor Create(AOwner: TPersistentCollection);
    function Add: TPrd_Gradec;
    property Items[Index: Integer]: TPrd_Gradec read GetItem write SetItem; default;
  end;

implementation

{ TPrd_Gradec }

constructor TPrd_Gradec.Create(ACollection: TCollection);
begin
  inherited;

end;

destructor TPrd_Gradec.Destroy;
begin

  inherited;
end;

{ TPrd_GradecList }

constructor TPrd_GradecList.Create(AOwner: TPersistentCollection);
begin
  inherited Create(TPrd_Gradec);
end;

function TPrd_GradecList.Add: TPrd_Gradec;
begin
  Result := TPrd_Gradec(inherited Add);
  Result.create;
end;

function TPrd_GradecList.GetItem(Index: Integer): TPrd_Gradec;
begin
  Result := TPrd_Gradec(inherited GetItem(Index));
end;

procedure TPrd_GradecList.SetItem(Index: Integer; Value: TPrd_Gradec);
begin
  inherited SetItem(Index, Value);
end;

end.