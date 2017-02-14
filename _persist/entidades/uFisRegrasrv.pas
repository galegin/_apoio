unit uFisRegrasrv;

interface

uses
  Classes, SysUtils,
  cCollection, cCollectionItem;

type
  TFis_Regrasrv = class;
  TFis_RegrasrvClass = class of TFis_Regrasrv;

  TFis_RegrasrvList = class;
  TFis_RegrasrvListClass = class of TFis_RegrasrvList;

  TFis_Regrasrv = class(TcCollectionItem)
  private
    fCd_Regrafiscal: Real;
    fU_Version: String;
    fCd_Operador: Real;
    fDt_Cadastro: TDateTime;
    fCd_Cfop: Real;
    fCd_Cst: String;
  public
    constructor Create; reintroduce;
    destructor Destroy; override;
  published
    property Cd_Regrafiscal : Real read fCd_Regrafiscal write fCd_Regrafiscal;
    property U_Version : String read fU_Version write fU_Version;
    property Cd_Operador : Real read fCd_Operador write fCd_Operador;
    property Dt_Cadastro : TDateTime read fDt_Cadastro write fDt_Cadastro;
    property Cd_Cfop : Real read fCd_Cfop write fCd_Cfop;
    property Cd_Cst : String read fCd_Cst write fCd_Cst;
  end;

  TFis_RegrasrvList = class(TcCollection)
  private
    function GetItem(Index: Integer): TFis_Regrasrv;
    procedure SetItem(Index: Integer; Value: TFis_Regrasrv);
  public
    constructor Create(AOwner: TPersistent);
    function Add: TFis_Regrasrv;
    property Items[Index: Integer]: TFis_Regrasrv read GetItem write SetItem; default;
  end;
  
implementation

{ TFis_Regrasrv }

constructor TFis_Regrasrv.Create;
begin

end;

destructor TFis_Regrasrv.Destroy;
begin

  inherited;
end;

{ TFis_RegrasrvList }

constructor TFis_RegrasrvList.Create(AOwner: TPersistent);
begin
  inherited Create(TFis_Regrasrv);
end;

function TFis_RegrasrvList.Add: TFis_Regrasrv;
begin
  Result := TFis_Regrasrv(inherited Add);
  Result.create;
end;

function TFis_RegrasrvList.GetItem(Index: Integer): TFis_Regrasrv;
begin
  Result := TFis_Regrasrv(inherited GetItem(Index));
end;

procedure TFis_RegrasrvList.SetItem(Index: Integer; Value: TFis_Regrasrv);
begin
  inherited SetItem(Index, Value);
end;

end.