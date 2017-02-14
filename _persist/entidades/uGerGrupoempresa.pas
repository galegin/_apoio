unit uGerGrupoempresa;

interface

uses
  Classes, SysUtils,
  cCollection, cCollectionItem;

type
  TGer_Grupoempresa = class;
  TGer_GrupoempresaClass = class of TGer_Grupoempresa;

  TGer_GrupoempresaList = class;
  TGer_GrupoempresaListClass = class of TGer_GrupoempresaList;

  TGer_Grupoempresa = class(TcCollectionItem)
  private
    fCd_Grupoempresa: Real;
    fU_Version: String;
    fCd_Operador: Real;
    fDt_Cadastro: TDateTime;
    fNm_Grupoempresa: String;
  public
    constructor Create; reintroduce;
    destructor Destroy; override;
  published
    property Cd_Grupoempresa : Real read fCd_Grupoempresa write fCd_Grupoempresa;
    property U_Version : String read fU_Version write fU_Version;
    property Cd_Operador : Real read fCd_Operador write fCd_Operador;
    property Dt_Cadastro : TDateTime read fDt_Cadastro write fDt_Cadastro;
    property Nm_Grupoempresa : String read fNm_Grupoempresa write fNm_Grupoempresa;
  end;

  TGer_GrupoempresaList = class(TcCollection)
  private
    function GetItem(Index: Integer): TGer_Grupoempresa;
    procedure SetItem(Index: Integer; Value: TGer_Grupoempresa);
  public
    constructor Create(AOwner: TPersistent);
    function Add: TGer_Grupoempresa;
    property Items[Index: Integer]: TGer_Grupoempresa read GetItem write SetItem; default;
  end;
  
implementation

{ TGer_Grupoempresa }

constructor TGer_Grupoempresa.Create;
begin

end;

destructor TGer_Grupoempresa.Destroy;
begin

  inherited;
end;

{ TGer_GrupoempresaList }

constructor TGer_GrupoempresaList.Create(AOwner: TPersistent);
begin
  inherited Create(TGer_Grupoempresa);
end;

function TGer_GrupoempresaList.Add: TGer_Grupoempresa;
begin
  Result := TGer_Grupoempresa(inherited Add);
  Result.create;
end;

function TGer_GrupoempresaList.GetItem(Index: Integer): TGer_Grupoempresa;
begin
  Result := TGer_Grupoempresa(inherited GetItem(Index));
end;

procedure TGer_GrupoempresaList.SetItem(Index: Integer; Value: TGer_Grupoempresa);
begin
  inherited SetItem(Index, Value);
end;

end.