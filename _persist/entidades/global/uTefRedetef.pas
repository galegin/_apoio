unit uTefRedetef;

interface

uses
  Classes, SysUtils,
  cCollection, cCollectionItem;

type
  TTef_Redetef = class;
  TTef_RedetefClass = class of TTef_Redetef;

  TTef_RedetefList = class;
  TTef_RedetefListClass = class of TTef_RedetefList;

  TTef_Redetef = class(TcCollectionItem)
  private
    fTp_Tef: Real;
    fCd_Redetef: Real;
    fU_Version: String;
    fCd_Operador: Real;
    fDt_Cadastro: TDateTime;
    fNm_Redetef: String;
    fDs_Redetef: String;
  public
    constructor Create; reintroduce;
    destructor Destroy; override;
  published
    property Tp_Tef : Real read fTp_Tef write fTp_Tef;
    property Cd_Redetef : Real read fCd_Redetef write fCd_Redetef;
    property U_Version : String read fU_Version write fU_Version;
    property Cd_Operador : Real read fCd_Operador write fCd_Operador;
    property Dt_Cadastro : TDateTime read fDt_Cadastro write fDt_Cadastro;
    property Nm_Redetef : String read fNm_Redetef write fNm_Redetef;
    property Ds_Redetef : String read fDs_Redetef write fDs_Redetef;
  end;

  TTef_RedetefList = class(TcCollection)
  private
    function GetItem(Index: Integer): TTef_Redetef;
    procedure SetItem(Index: Integer; Value: TTef_Redetef);
  public
    constructor Create(AOwner: TPersistent);
    function Add: TTef_Redetef;
    property Items[Index: Integer]: TTef_Redetef read GetItem write SetItem; default;
  end;
  
implementation

{ TTef_Redetef }

constructor TTef_Redetef.Create;
begin

end;

destructor TTef_Redetef.Destroy;
begin

  inherited;
end;

{ TTef_RedetefList }

constructor TTef_RedetefList.Create(AOwner: TPersistent);
begin
  inherited Create(TTef_Redetef);
end;

function TTef_RedetefList.Add: TTef_Redetef;
begin
  Result := TTef_Redetef(inherited Add);
  Result.create;
end;

function TTef_RedetefList.GetItem(Index: Integer): TTef_Redetef;
begin
  Result := TTef_Redetef(inherited GetItem(Index));
end;

procedure TTef_RedetefList.SetItem(Index: Integer; Value: TTef_Redetef);
begin
  inherited SetItem(Index, Value);
end;

end.