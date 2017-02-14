unit uFisLognf;

interface

uses
  Classes, SysUtils,
  cCollection, cCollectionItem;

type
  TFis_Lognf = class;
  TFis_LognfClass = class of TFis_Lognf;

  TFis_LognfList = class;
  TFis_LognfListClass = class of TFis_LognfList;

  TFis_Lognf = class(TcCollectionItem)
  private
    fCd_Empresa: Real;
    fNr_Fatura: Real;
    fDt_Fatura: TDateTime;
    fNr_Linha: Real;
    fU_Version: String;
    fCd_Operador: Real;
    fDt_Cadastro: TDateTime;
    fCd_Empfat: Real;
    fDs_Log: String;
  public
    constructor Create; reintroduce;
    destructor Destroy; override;
  published
    property Cd_Empresa : Real read fCd_Empresa write fCd_Empresa;
    property Nr_Fatura : Real read fNr_Fatura write fNr_Fatura;
    property Dt_Fatura : TDateTime read fDt_Fatura write fDt_Fatura;
    property Nr_Linha : Real read fNr_Linha write fNr_Linha;
    property U_Version : String read fU_Version write fU_Version;
    property Cd_Operador : Real read fCd_Operador write fCd_Operador;
    property Dt_Cadastro : TDateTime read fDt_Cadastro write fDt_Cadastro;
    property Cd_Empfat : Real read fCd_Empfat write fCd_Empfat;
    property Ds_Log : String read fDs_Log write fDs_Log;
  end;

  TFis_LognfList = class(TcCollection)
  private
    function GetItem(Index: Integer): TFis_Lognf;
    procedure SetItem(Index: Integer; Value: TFis_Lognf);
  public
    constructor Create(AOwner: TPersistent);
    function Add: TFis_Lognf;
    property Items[Index: Integer]: TFis_Lognf read GetItem write SetItem; default;
  end;
  
implementation

{ TFis_Lognf }

constructor TFis_Lognf.Create;
begin

end;

destructor TFis_Lognf.Destroy;
begin

  inherited;
end;

{ TFis_LognfList }

constructor TFis_LognfList.Create(AOwner: TPersistent);
begin
  inherited Create(TFis_Lognf);
end;

function TFis_LognfList.Add: TFis_Lognf;
begin
  Result := TFis_Lognf(inherited Add);
  Result.create;
end;

function TFis_LognfList.GetItem(Index: Integer): TFis_Lognf;
begin
  Result := TFis_Lognf(inherited GetItem(Index));
end;

procedure TFis_LognfList.SetItem(Index: Integer; Value: TFis_Lognf);
begin
  inherited SetItem(Index, Value);
end;

end.