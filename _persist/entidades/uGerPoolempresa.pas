unit uGerPoolempresa;

interface

uses
  Classes, SysUtils,
  cCollection, cCollectionItem;

type
  TGer_Poolempresa = class;
  TGer_PoolempresaClass = class of TGer_Poolempresa;

  TGer_PoolempresaList = class;
  TGer_PoolempresaListClass = class of TGer_PoolempresaList;

  TGer_Poolempresa = class(TcCollectionItem)
  private
    fCd_Poolempresa: Real;
    fU_Version: String;
    fCd_Operador: Real;
    fDt_Cadastro: TDateTime;
    fNm_Poolempresa: String;
    fCd_Grupoempmatriz: Real;
  public
    constructor Create; reintroduce;
    destructor Destroy; override;
  published
    property Cd_Poolempresa : Real read fCd_Poolempresa write fCd_Poolempresa;
    property U_Version : String read fU_Version write fU_Version;
    property Cd_Operador : Real read fCd_Operador write fCd_Operador;
    property Dt_Cadastro : TDateTime read fDt_Cadastro write fDt_Cadastro;
    property Nm_Poolempresa : String read fNm_Poolempresa write fNm_Poolempresa;
    property Cd_Grupoempmatriz : Real read fCd_Grupoempmatriz write fCd_Grupoempmatriz;
  end;

  TGer_PoolempresaList = class(TcCollection)
  private
    function GetItem(Index: Integer): TGer_Poolempresa;
    procedure SetItem(Index: Integer; Value: TGer_Poolempresa);
  public
    constructor Create(AOwner: TPersistent);
    function Add: TGer_Poolempresa;
    property Items[Index: Integer]: TGer_Poolempresa read GetItem write SetItem; default;
  end;
  
implementation

{ TGer_Poolempresa }

constructor TGer_Poolempresa.Create;
begin

end;

destructor TGer_Poolempresa.Destroy;
begin

  inherited;
end;

{ TGer_PoolempresaList }

constructor TGer_PoolempresaList.Create(AOwner: TPersistent);
begin
  inherited Create(TGer_Poolempresa);
end;

function TGer_PoolempresaList.Add: TGer_Poolempresa;
begin
  Result := TGer_Poolempresa(inherited Add);
  Result.create;
end;

function TGer_PoolempresaList.GetItem(Index: Integer): TGer_Poolempresa;
begin
  Result := TGer_Poolempresa(inherited GetItem(Index));
end;

procedure TGer_PoolempresaList.SetItem(Index: Integer; Value: TGer_Poolempresa);
begin
  inherited SetItem(Index, Value);
end;

end.