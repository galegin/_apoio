unit uPrdGradec;

interface

uses
  Classes, SysUtils,
  cCollection, cCollectionItem;

type
  TPrd_Gradec = class;
  TPrd_GradecClass = class of TPrd_Gradec;

  TPrd_GradecList = class;
  TPrd_GradecListClass = class of TPrd_GradecList;

  TPrd_Gradec = class(TcCollectionItem)
  private
    fCd_Grade: Real;
    fU_Version: String;
    fCd_Operador: Real;
    fDt_Cadastro: TDateTime;
    fDs_Grade: String;
  public
    constructor Create; reintroduce;
    destructor Destroy; override;
  published
    property Cd_Grade : Real read fCd_Grade write fCd_Grade;
    property U_Version : String read fU_Version write fU_Version;
    property Cd_Operador : Real read fCd_Operador write fCd_Operador;
    property Dt_Cadastro : TDateTime read fDt_Cadastro write fDt_Cadastro;
    property Ds_Grade : String read fDs_Grade write fDs_Grade;
  end;

  TPrd_GradecList = class(TcCollection)
  private
    function GetItem(Index: Integer): TPrd_Gradec;
    procedure SetItem(Index: Integer; Value: TPrd_Gradec);
  public
    constructor Create(AOwner: TPersistent);
    function Add: TPrd_Gradec;
    property Items[Index: Integer]: TPrd_Gradec read GetItem write SetItem; default;
  end;
  
implementation

{ TPrd_Gradec }

constructor TPrd_Gradec.Create;
begin

end;

destructor TPrd_Gradec.Destroy;
begin

  inherited;
end;

{ TPrd_GradecList }

constructor TPrd_GradecList.Create(AOwner: TPersistent);
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