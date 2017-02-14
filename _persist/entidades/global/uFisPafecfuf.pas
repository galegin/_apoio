unit uFisPafecfuf;

interface

uses
  Classes, SysUtils,
  cCollection, cCollectionItem;

type
  TFis_Pafecfuf = class;
  TFis_PafecfufClass = class of TFis_Pafecfuf;

  TFis_PafecfufList = class;
  TFis_PafecfufListClass = class of TFis_PafecfufList;

  TFis_Pafecfuf = class(TcCollectionItem)
  private
    fCd_Estado: Real;
    fCd_Laudo: String;
    fU_Version: String;
    fCd_Operador: Real;
    fDt_Cadastro: TDateTime;
  public
    constructor Create; reintroduce;
    destructor Destroy; override;
  published
    property Cd_Estado : Real read fCd_Estado write fCd_Estado;
    property Cd_Laudo : String read fCd_Laudo write fCd_Laudo;
    property U_Version : String read fU_Version write fU_Version;
    property Cd_Operador : Real read fCd_Operador write fCd_Operador;
    property Dt_Cadastro : TDateTime read fDt_Cadastro write fDt_Cadastro;
  end;

  TFis_PafecfufList = class(TcCollection)
  private
    function GetItem(Index: Integer): TFis_Pafecfuf;
    procedure SetItem(Index: Integer; Value: TFis_Pafecfuf);
  public
    constructor Create(AOwner: TPersistent);
    function Add: TFis_Pafecfuf;
    property Items[Index: Integer]: TFis_Pafecfuf read GetItem write SetItem; default;
  end;
  
implementation

{ TFis_Pafecfuf }

constructor TFis_Pafecfuf.Create;
begin

end;

destructor TFis_Pafecfuf.Destroy;
begin

  inherited;
end;

{ TFis_PafecfufList }

constructor TFis_PafecfufList.Create(AOwner: TPersistent);
begin
  inherited Create(TFis_Pafecfuf);
end;

function TFis_PafecfufList.Add: TFis_Pafecfuf;
begin
  Result := TFis_Pafecfuf(inherited Add);
  Result.create;
end;

function TFis_PafecfufList.GetItem(Index: Integer): TFis_Pafecfuf;
begin
  Result := TFis_Pafecfuf(inherited GetItem(Index));
end;

procedure TFis_PafecfufList.SetItem(Index: Integer; Value: TFis_Pafecfuf);
begin
  inherited SetItem(Index, Value);
end;

end.