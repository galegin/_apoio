unit uFisDanfeimp;

interface

uses
  Classes, SysUtils,
  cCollection, cCollectionItem;

type
  TFis_Danfeimp = class;
  TFis_DanfeimpClass = class of TFis_Danfeimp;

  TFis_DanfeimpList = class;
  TFis_DanfeimpListClass = class of TFis_DanfeimpList;

  TFis_Danfeimp = class(TcCollectionItem)
  private
    fCd_Usuario: Real;
    fDs_Chaveacesso: String;
    fU_Version: String;
    fCd_Operador: Integer;
    fDt_Cadastro: TDateTime;
  public
    constructor Create; reintroduce;
    destructor Destroy; override;
  published
    property Cd_Usuario : Real read fCd_Usuario write fCd_Usuario;
    property Ds_Chaveacesso : String read fDs_Chaveacesso write fDs_Chaveacesso;
    property U_Version : String read fU_Version write fU_Version;
    property Cd_Operador : Integer read fCd_Operador write fCd_Operador;
    property Dt_Cadastro : TDateTime read fDt_Cadastro write fDt_Cadastro;
  end;

  TFis_DanfeimpList = class(TcCollection)
  private
    function GetItem(Index: Integer): TFis_Danfeimp;
    procedure SetItem(Index: Integer; Value: TFis_Danfeimp);
  public
    constructor Create(AOwner: TPersistent);
    function Add: TFis_Danfeimp;
    property Items[Index: Integer]: TFis_Danfeimp read GetItem write SetItem; default;
  end;
  
implementation

{ TFis_Danfeimp }

constructor TFis_Danfeimp.Create;
begin

end;

destructor TFis_Danfeimp.Destroy;
begin

  inherited;
end;

{ TFis_DanfeimpList }

constructor TFis_DanfeimpList.Create(AOwner: TPersistent);
begin
  inherited Create(TFis_Danfeimp);
end;

function TFis_DanfeimpList.Add: TFis_Danfeimp;
begin
  Result := TFis_Danfeimp(inherited Add);
  Result.create;
end;

function TFis_DanfeimpList.GetItem(Index: Integer): TFis_Danfeimp;
begin
  Result := TFis_Danfeimp(inherited GetItem(Index));
end;

procedure TFis_DanfeimpList.SetItem(Index: Integer; Value: TFis_Danfeimp);
begin
  inherited SetItem(Index, Value);
end;

end.