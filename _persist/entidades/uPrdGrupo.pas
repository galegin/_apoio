unit uPrdGrupo;

interface

uses
  Classes, SysUtils,
  cCollection, cCollectionItem;

type
  TPrd_Grupo = class;
  TPrd_GrupoClass = class of TPrd_Grupo;

  TPrd_GrupoList = class;
  TPrd_GrupoListClass = class of TPrd_GrupoList;

  TPrd_Grupo = class(TcCollectionItem)
  private
    fCd_Seq: Real;
    fU_Version: String;
    fCd_Grupo: String;
    fCd_Seqpai: Real;
    fCd_Produto: Real;
    fCd_Grade: Real;
    fCd_Tipoclas: Real;
    fDt_Cadastro: TDateTime;
    fCd_Operador: Real;
    fDs_Grupo: String;
  public
    constructor Create; reintroduce;
    destructor Destroy; override;
  published
    property Cd_Seq : Real read fCd_Seq write fCd_Seq;
    property U_Version : String read fU_Version write fU_Version;
    property Cd_Grupo : String read fCd_Grupo write fCd_Grupo;
    property Cd_Seqpai : Real read fCd_Seqpai write fCd_Seqpai;
    property Cd_Produto : Real read fCd_Produto write fCd_Produto;
    property Cd_Grade : Real read fCd_Grade write fCd_Grade;
    property Cd_Tipoclas : Real read fCd_Tipoclas write fCd_Tipoclas;
    property Dt_Cadastro : TDateTime read fDt_Cadastro write fDt_Cadastro;
    property Cd_Operador : Real read fCd_Operador write fCd_Operador;
    property Ds_Grupo : String read fDs_Grupo write fDs_Grupo;
  end;

  TPrd_GrupoList = class(TcCollection)
  private
    function GetItem(Index: Integer): TPrd_Grupo;
    procedure SetItem(Index: Integer; Value: TPrd_Grupo);
  public
    constructor Create(AOwner: TPersistent);
    function Add: TPrd_Grupo;
    property Items[Index: Integer]: TPrd_Grupo read GetItem write SetItem; default;
  end;
  
implementation

{ TPrd_Grupo }

constructor TPrd_Grupo.Create;
begin

end;

destructor TPrd_Grupo.Destroy;
begin

  inherited;
end;

{ TPrd_GrupoList }

constructor TPrd_GrupoList.Create(AOwner: TPersistent);
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