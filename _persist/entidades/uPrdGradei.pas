unit uPrdGradei;

interface

uses
  Classes, SysUtils,
  cCollection, cCollectionItem;

type
  TPrd_Gradei = class;
  TPrd_GradeiClass = class of TPrd_Gradei;

  TPrd_GradeiList = class;
  TPrd_GradeiListClass = class of TPrd_GradeiList;

  TPrd_Gradei = class(TcCollectionItem)
  private
    fCd_Grade: Real;
    fCd_Tamanho: Real;
    fU_Version: String;
    fCd_Operador: Real;
    fDt_Cadastro: TDateTime;
    fDs_Tamanho: String;
  public
    constructor Create; reintroduce;
    destructor Destroy; override;
  published
    property Cd_Grade : Real read fCd_Grade write fCd_Grade;
    property Cd_Tamanho : Real read fCd_Tamanho write fCd_Tamanho;
    property U_Version : String read fU_Version write fU_Version;
    property Cd_Operador : Real read fCd_Operador write fCd_Operador;
    property Dt_Cadastro : TDateTime read fDt_Cadastro write fDt_Cadastro;
    property Ds_Tamanho : String read fDs_Tamanho write fDs_Tamanho;
  end;

  TPrd_GradeiList = class(TcCollection)
  private
    function GetItem(Index: Integer): TPrd_Gradei;
    procedure SetItem(Index: Integer; Value: TPrd_Gradei);
  public
    constructor Create(AOwner: TPersistent);
    function Add: TPrd_Gradei;
    property Items[Index: Integer]: TPrd_Gradei read GetItem write SetItem; default;
  end;
  
implementation

{ TPrd_Gradei }

constructor TPrd_Gradei.Create;
begin

end;

destructor TPrd_Gradei.Destroy;
begin

  inherited;
end;

{ TPrd_GradeiList }

constructor TPrd_GradeiList.Create(AOwner: TPersistent);
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