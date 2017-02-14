unit uFcpTipoclass;

interface

uses
  Classes, SysUtils,
  cCollection, cCollectionItem;

type
  TFcp_Tipoclass = class;
  TFcp_TipoclassClass = class of TFcp_Tipoclass;

  TFcp_TipoclassList = class;
  TFcp_TipoclassListClass = class of TFcp_TipoclassList;

  TFcp_Tipoclass = class(TcCollectionItem)
  private
    fCd_Tipoclass: Real;
    fU_Version: String;
    fCd_Operador: Real;
    fDt_Cadastro: TDateTime;
    fTp_Tipoclass: Real;
    fDs_Tipoclass: String;
  public
    constructor Create; reintroduce;
    destructor Destroy; override;
  published
    property Cd_Tipoclass : Real read fCd_Tipoclass write fCd_Tipoclass;
    property U_Version : String read fU_Version write fU_Version;
    property Cd_Operador : Real read fCd_Operador write fCd_Operador;
    property Dt_Cadastro : TDateTime read fDt_Cadastro write fDt_Cadastro;
    property Tp_Tipoclass : Real read fTp_Tipoclass write fTp_Tipoclass;
    property Ds_Tipoclass : String read fDs_Tipoclass write fDs_Tipoclass;
  end;

  TFcp_TipoclassList = class(TcCollection)
  private
    function GetItem(Index: Integer): TFcp_Tipoclass;
    procedure SetItem(Index: Integer; Value: TFcp_Tipoclass);
  public
    constructor Create(AOwner: TPersistent);
    function Add: TFcp_Tipoclass;
    property Items[Index: Integer]: TFcp_Tipoclass read GetItem write SetItem; default;
  end;
  
implementation

{ TFcp_Tipoclass }

constructor TFcp_Tipoclass.Create;
begin

end;

destructor TFcp_Tipoclass.Destroy;
begin

  inherited;
end;

{ TFcp_TipoclassList }

constructor TFcp_TipoclassList.Create(AOwner: TPersistent);
begin
  inherited Create(TFcp_Tipoclass);
end;

function TFcp_TipoclassList.Add: TFcp_Tipoclass;
begin
  Result := TFcp_Tipoclass(inherited Add);
  Result.create;
end;

function TFcp_TipoclassList.GetItem(Index: Integer): TFcp_Tipoclass;
begin
  Result := TFcp_Tipoclass(inherited GetItem(Index));
end;

procedure TFcp_TipoclassList.SetItem(Index: Integer; Value: TFcp_Tipoclass);
begin
  inherited SetItem(Index, Value);
end;

end.