unit uFisEcf;

interface

uses
  Classes, SysUtils,
  cCollection, cCollectionItem;

type
  TFis_Ecf = class;
  TFis_EcfClass = class of TFis_Ecf;

  TFis_EcfList = class;
  TFis_EcfListClass = class of TFis_EcfList;

  TFis_Ecf = class(TcCollectionItem)
  private
    fCd_Empresa: Real;
    fNr_Ecf: Real;
    fU_Version: String;
    fCd_Operador: Real;
    fDt_Cadastro: TDateTime;
    fCd_Seriefab: String;
    fDs_Ecf: String;
    fNm_Terminal: String;
  public
    constructor Create; reintroduce;
    destructor Destroy; override;
  published
    property Cd_Empresa : Real read fCd_Empresa write fCd_Empresa;
    property Nr_Ecf : Real read fNr_Ecf write fNr_Ecf;
    property U_Version : String read fU_Version write fU_Version;
    property Cd_Operador : Real read fCd_Operador write fCd_Operador;
    property Dt_Cadastro : TDateTime read fDt_Cadastro write fDt_Cadastro;
    property Cd_Seriefab : String read fCd_Seriefab write fCd_Seriefab;
    property Ds_Ecf : String read fDs_Ecf write fDs_Ecf;
    property Nm_Terminal : String read fNm_Terminal write fNm_Terminal;
  end;

  TFis_EcfList = class(TcCollection)
  private
    function GetItem(Index: Integer): TFis_Ecf;
    procedure SetItem(Index: Integer; Value: TFis_Ecf);
  public
    constructor Create(AOwner: TPersistent);
    function Add: TFis_Ecf;
    property Items[Index: Integer]: TFis_Ecf read GetItem write SetItem; default;
  end;
  
implementation

{ TFis_Ecf }

constructor TFis_Ecf.Create;
begin

end;

destructor TFis_Ecf.Destroy;
begin

  inherited;
end;

{ TFis_EcfList }

constructor TFis_EcfList.Create(AOwner: TPersistent);
begin
  inherited Create(TFis_Ecf);
end;

function TFis_EcfList.Add: TFis_Ecf;
begin
  Result := TFis_Ecf(inherited Add);
  Result.create;
end;

function TFis_EcfList.GetItem(Index: Integer): TFis_Ecf;
begin
  Result := TFis_Ecf(inherited GetItem(Index));
end;

procedure TFis_EcfList.SetItem(Index: Integer; Value: TFis_Ecf);
begin
  inherited SetItem(Index, Value);
end;

end.