unit uGerPoolgrupoemp;

interface

uses
  Classes, SysUtils,
  cCollection, cCollectionItem;

type
  TGer_Poolgrupoemp = class;
  TGer_PoolgrupoempClass = class of TGer_Poolgrupoemp;

  TGer_PoolgrupoempList = class;
  TGer_PoolgrupoempListClass = class of TGer_PoolgrupoempList;

  TGer_Poolgrupoemp = class(TcCollectionItem)
  private
    fCd_Poolempresa: Real;
    fCd_Grupoempresa: Real;
    fU_Version: String;
    fCd_Operador: Real;
    fDt_Cadastro: TDateTime;
  public
    constructor Create; reintroduce;
    destructor Destroy; override;
  published
    property Cd_Poolempresa : Real read fCd_Poolempresa write fCd_Poolempresa;
    property Cd_Grupoempresa : Real read fCd_Grupoempresa write fCd_Grupoempresa;
    property U_Version : String read fU_Version write fU_Version;
    property Cd_Operador : Real read fCd_Operador write fCd_Operador;
    property Dt_Cadastro : TDateTime read fDt_Cadastro write fDt_Cadastro;
  end;

  TGer_PoolgrupoempList = class(TcCollection)
  private
    function GetItem(Index: Integer): TGer_Poolgrupoemp;
    procedure SetItem(Index: Integer; Value: TGer_Poolgrupoemp);
  public
    constructor Create(AOwner: TPersistent);
    function Add: TGer_Poolgrupoemp;
    property Items[Index: Integer]: TGer_Poolgrupoemp read GetItem write SetItem; default;
  end;
  
implementation

{ TGer_Poolgrupoemp }

constructor TGer_Poolgrupoemp.Create;
begin

end;

destructor TGer_Poolgrupoemp.Destroy;
begin

  inherited;
end;

{ TGer_PoolgrupoempList }

constructor TGer_PoolgrupoempList.Create(AOwner: TPersistent);
begin
  inherited Create(TGer_Poolgrupoemp);
end;

function TGer_PoolgrupoempList.Add: TGer_Poolgrupoemp;
begin
  Result := TGer_Poolgrupoemp(inherited Add);
  Result.create;
end;

function TGer_PoolgrupoempList.GetItem(Index: Integer): TGer_Poolgrupoemp;
begin
  Result := TGer_Poolgrupoemp(inherited GetItem(Index));
end;

procedure TGer_PoolgrupoempList.SetItem(Index: Integer; Value: TGer_Poolgrupoemp);
begin
  inherited SetItem(Index, Value);
end;

end.