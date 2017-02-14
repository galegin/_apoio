unit uFisDanfeitem;

interface

uses
  Classes, SysUtils,
  cCollection, cCollectionItem;

type
  TFis_Danfeitem = class;
  TFis_DanfeitemClass = class of TFis_Danfeitem;

  TFis_DanfeitemList = class;
  TFis_DanfeitemListClass = class of TFis_DanfeitemList;

  TFis_Danfeitem = class(TcCollectionItem)
  private
    fCd_Empresa: Real;
    fNr_Seqcampo: Real;
    fU_Version: String;
    fCd_Operador: Integer;
    fDt_Cadastro: TDateTime;
    fCd_Campo: String;
    fDs_Campo: String;
    fTp_Campo: String;
    fNr_Tam: Real;
    fNr_Dec: Real;
    fTp_Alin: String;
  public
    constructor Create; reintroduce;
    destructor Destroy; override;
  published
    property Cd_Empresa : Real read fCd_Empresa write fCd_Empresa;
    property Nr_Seqcampo : Real read fNr_Seqcampo write fNr_Seqcampo;
    property U_Version : String read fU_Version write fU_Version;
    property Cd_Operador : Integer read fCd_Operador write fCd_Operador;
    property Dt_Cadastro : TDateTime read fDt_Cadastro write fDt_Cadastro;
    property Cd_Campo : String read fCd_Campo write fCd_Campo;
    property Ds_Campo : String read fDs_Campo write fDs_Campo;
    property Tp_Campo : String read fTp_Campo write fTp_Campo;
    property Nr_Tam : Real read fNr_Tam write fNr_Tam;
    property Nr_Dec : Real read fNr_Dec write fNr_Dec;
    property Tp_Alin : String read fTp_Alin write fTp_Alin;
  end;

  TFis_DanfeitemList = class(TcCollection)
  private
    function GetItem(Index: Integer): TFis_Danfeitem;
    procedure SetItem(Index: Integer; Value: TFis_Danfeitem);
  public
    constructor Create(AOwner: TPersistent);
    function Add: TFis_Danfeitem;
    property Items[Index: Integer]: TFis_Danfeitem read GetItem write SetItem; default;
  end;
  
implementation

{ TFis_Danfeitem }

constructor TFis_Danfeitem.Create;
begin

end;

destructor TFis_Danfeitem.Destroy;
begin

  inherited;
end;

{ TFis_DanfeitemList }

constructor TFis_DanfeitemList.Create(AOwner: TPersistent);
begin
  inherited Create(TFis_Danfeitem);
end;

function TFis_DanfeitemList.Add: TFis_Danfeitem;
begin
  Result := TFis_Danfeitem(inherited Add);
  Result.create;
end;

function TFis_DanfeitemList.GetItem(Index: Integer): TFis_Danfeitem;
begin
  Result := TFis_Danfeitem(inherited GetItem(Index));
end;

procedure TFis_DanfeitemList.SetItem(Index: Integer; Value: TFis_Danfeitem);
begin
  inherited SetItem(Index, Value);
end;

end.