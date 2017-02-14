unit uPrdGrupocomp;

interface

uses
  Classes, SysUtils,
  cCollection, cCollectionItem;

type
  TPrd_Grupocomp = class;
  TPrd_GrupocompClass = class of TPrd_Grupocomp;

  TPrd_GrupocompList = class;
  TPrd_GrupocompListClass = class of TPrd_GrupocompList;

  TPrd_Grupocomp = class(TcCollectionItem)
  private
    fCd_Seqgrupo: Real;
    fCd_Composicao: Real;
    fU_Version: String;
    fCd_Operador: Real;
    fDt_Cadastro: TDateTime;
  public
    constructor Create; reintroduce;
    destructor Destroy; override;
  published
    property Cd_Seqgrupo : Real read fCd_Seqgrupo write fCd_Seqgrupo;
    property Cd_Composicao : Real read fCd_Composicao write fCd_Composicao;
    property U_Version : String read fU_Version write fU_Version;
    property Cd_Operador : Real read fCd_Operador write fCd_Operador;
    property Dt_Cadastro : TDateTime read fDt_Cadastro write fDt_Cadastro;
  end;

  TPrd_GrupocompList = class(TcCollection)
  private
    function GetItem(Index: Integer): TPrd_Grupocomp;
    procedure SetItem(Index: Integer; Value: TPrd_Grupocomp);
  public
    constructor Create(AOwner: TPersistent);
    function Add: TPrd_Grupocomp;
    property Items[Index: Integer]: TPrd_Grupocomp read GetItem write SetItem; default;
  end;
  
implementation

{ TPrd_Grupocomp }

constructor TPrd_Grupocomp.Create;
begin

end;

destructor TPrd_Grupocomp.Destroy;
begin

  inherited;
end;

{ TPrd_GrupocompList }

constructor TPrd_GrupocompList.Create(AOwner: TPersistent);
begin
  inherited Create(TPrd_Grupocomp);
end;

function TPrd_GrupocompList.Add: TPrd_Grupocomp;
begin
  Result := TPrd_Grupocomp(inherited Add);
  Result.create;
end;

function TPrd_GrupocompList.GetItem(Index: Integer): TPrd_Grupocomp;
begin
  Result := TPrd_Grupocomp(inherited GetItem(Index));
end;

procedure TPrd_GrupocompList.SetItem(Index: Integer; Value: TPrd_Grupocomp);
begin
  inherited SetItem(Index, Value);
end;

end.