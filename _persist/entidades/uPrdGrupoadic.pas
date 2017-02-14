unit uPrdGrupoadic;

interface

uses
  Classes, SysUtils,
  cCollection, cCollectionItem;

type
  TPrd_Grupoadic = class;
  TPrd_GrupoadicClass = class of TPrd_Grupoadic;

  TPrd_GrupoadicList = class;
  TPrd_GrupoadicListClass = class of TPrd_GrupoadicList;

  TPrd_Grupoadic = class(TcCollectionItem)
  private
    fCd_Seqgrupo: Real;
    fU_Version: String;
    fCd_Operador: Real;
    fDt_Cadastro: TDateTime;
    fCd_Componente: String;
    fCd_Cfgnivel: Real;
    fDs_Nivel: String;
    fCd_Nivel: String;
  public
    constructor Create; reintroduce;
    destructor Destroy; override;
  published
    property Cd_Seqgrupo : Real read fCd_Seqgrupo write fCd_Seqgrupo;
    property U_Version : String read fU_Version write fU_Version;
    property Cd_Operador : Real read fCd_Operador write fCd_Operador;
    property Dt_Cadastro : TDateTime read fDt_Cadastro write fDt_Cadastro;
    property Cd_Componente : String read fCd_Componente write fCd_Componente;
    property Cd_Cfgnivel : Real read fCd_Cfgnivel write fCd_Cfgnivel;
    property Ds_Nivel : String read fDs_Nivel write fDs_Nivel;
    property Cd_Nivel : String read fCd_Nivel write fCd_Nivel;
  end;

  TPrd_GrupoadicList = class(TcCollection)
  private
    function GetItem(Index: Integer): TPrd_Grupoadic;
    procedure SetItem(Index: Integer; Value: TPrd_Grupoadic);
  public
    constructor Create(AOwner: TPersistent);
    function Add: TPrd_Grupoadic;
    property Items[Index: Integer]: TPrd_Grupoadic read GetItem write SetItem; default;
  end;
  
implementation

{ TPrd_Grupoadic }

constructor TPrd_Grupoadic.Create;
begin

end;

destructor TPrd_Grupoadic.Destroy;
begin

  inherited;
end;

{ TPrd_GrupoadicList }

constructor TPrd_GrupoadicList.Create(AOwner: TPersistent);
begin
  inherited Create(TPrd_Grupoadic);
end;

function TPrd_GrupoadicList.Add: TPrd_Grupoadic;
begin
  Result := TPrd_Grupoadic(inherited Add);
  Result.create;
end;

function TPrd_GrupoadicList.GetItem(Index: Integer): TPrd_Grupoadic;
begin
  Result := TPrd_Grupoadic(inherited GetItem(Index));
end;

procedure TPrd_GrupoadicList.SetItem(Index: Integer; Value: TPrd_Grupoadic);
begin
  inherited SetItem(Index, Value);
end;

end.