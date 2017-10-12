unit uPrdGrupo;

interface

uses
  Classes, SysUtils,
  mCollection, mCollectionItem;

type
  TPrd_Grupo = class;
  TPrd_GrupoClass = class of TPrd_Grupo;

  TPrd_GrupoList = class;
  TPrd_GrupoListClass = class of TPrd_GrupoList;

  TPrd_Grupo = class(TmCollectionItem)
  private
    fCd_Seq: String;
    fU_Version: String;
    fCd_Grupo: String;
    fCd_Seqpai: String;
    fCd_Produto: String;
    fCd_Grade: String;
    fCd_Tipoclas: String;
    fDt_Cadastro: String;
    fCd_Operador: String;
    fDs_Grupo: String;
  public
    constructor Create(ACollection: TCollection); override;
    destructor Destroy; override;
  published
    property Cd_Seq : String read fCd_Seq write SetCd_Seq;
    property U_Version : String read fU_Version write SetU_Version;
    property Cd_Grupo : String read fCd_Grupo write SetCd_Grupo;
    property Cd_Seqpai : String read fCd_Seqpai write SetCd_Seqpai;
    property Cd_Produto : String read fCd_Produto write SetCd_Produto;
    property Cd_Grade : String read fCd_Grade write SetCd_Grade;
    property Cd_Tipoclas : String read fCd_Tipoclas write SetCd_Tipoclas;
    property Dt_Cadastro : String read fDt_Cadastro write SetDt_Cadastro;
    property Cd_Operador : String read fCd_Operador write SetCd_Operador;
    property Ds_Grupo : String read fDs_Grupo write SetDs_Grupo;
  end;

  TPrd_GrupoList = class(TmCollection)
  private
    function GetItem(Index: Integer): TPrd_Grupo;
    procedure SetItem(Index: Integer; Value: TPrd_Grupo);
  public
    constructor Create(AOwner: TPersistentCollection);
    function Add: TPrd_Grupo;
    property Items[Index: Integer]: TPrd_Grupo read GetItem write SetItem; default;
  end;

implementation

{ TPrd_Grupo }

constructor TPrd_Grupo.Create(ACollection: TCollection);
begin
  inherited;

end;

destructor TPrd_Grupo.Destroy;
begin

  inherited;
end;

{ TPrd_GrupoList }

constructor TPrd_GrupoList.Create(AOwner: TPersistentCollection);
begin
  inherited Create(TPrd_Grupo);
end;

function TPrd_GrupoList.Add: TPrd_Grupo;
begin
  Result := TPrd_Grupo(inherited Add);
  Result.create;
end;

function TPrd_GrupoList.GetItem(Index: Integer): TPrd_Grupo;
begin
  Result := TPrd_Grupo(inherited GetItem(Index));
end;

procedure TPrd_GrupoList.SetItem(Index: Integer; Value: TPrd_Grupo);
begin
  inherited SetItem(Index, Value);
end;

end.