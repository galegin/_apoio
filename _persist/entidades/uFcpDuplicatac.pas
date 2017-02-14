unit uFcpDuplicatac;

interface

uses
  Classes, SysUtils,
  cCollection, cCollectionItem;

type
  TFcp_Duplicatac = class;
  TFcp_DuplicatacClass = class of TFcp_Duplicatac;

  TFcp_DuplicatacList = class;
  TFcp_DuplicatacListClass = class of TFcp_DuplicatacList;

  TFcp_Duplicatac = class(TcCollectionItem)
  private
    fCd_Empresa: Real;
    fCd_Fornecedor: Real;
    fNr_Duplicata: Real;
    fU_Version: String;
    fCd_Operador: Real;
    fDt_Cadastro: TDateTime;
    fCd_Condpagto: Real;
    fVl_Total: Real;
    fVl_Saldo: Real;
    fDs_Documento: String;
  public
    constructor Create; reintroduce;
    destructor Destroy; override;
  published
    property Cd_Empresa : Real read fCd_Empresa write fCd_Empresa;
    property Cd_Fornecedor : Real read fCd_Fornecedor write fCd_Fornecedor;
    property Nr_Duplicata : Real read fNr_Duplicata write fNr_Duplicata;
    property U_Version : String read fU_Version write fU_Version;
    property Cd_Operador : Real read fCd_Operador write fCd_Operador;
    property Dt_Cadastro : TDateTime read fDt_Cadastro write fDt_Cadastro;
    property Cd_Condpagto : Real read fCd_Condpagto write fCd_Condpagto;
    property Vl_Total : Real read fVl_Total write fVl_Total;
    property Vl_Saldo : Real read fVl_Saldo write fVl_Saldo;
    property Ds_Documento : String read fDs_Documento write fDs_Documento;
  end;

  TFcp_DuplicatacList = class(TcCollection)
  private
    function GetItem(Index: Integer): TFcp_Duplicatac;
    procedure SetItem(Index: Integer; Value: TFcp_Duplicatac);
  public
    constructor Create(AOwner: TPersistent);
    function Add: TFcp_Duplicatac;
    property Items[Index: Integer]: TFcp_Duplicatac read GetItem write SetItem; default;
  end;
  
implementation

{ TFcp_Duplicatac }

constructor TFcp_Duplicatac.Create;
begin

end;

destructor TFcp_Duplicatac.Destroy;
begin

  inherited;
end;

{ TFcp_DuplicatacList }

constructor TFcp_DuplicatacList.Create(AOwner: TPersistent);
begin
  inherited Create(TFcp_Duplicatac);
end;

function TFcp_DuplicatacList.Add: TFcp_Duplicatac;
begin
  Result := TFcp_Duplicatac(inherited Add);
  Result.create;
end;

function TFcp_DuplicatacList.GetItem(Index: Integer): TFcp_Duplicatac;
begin
  Result := TFcp_Duplicatac(inherited GetItem(Index));
end;

procedure TFcp_DuplicatacList.SetItem(Index: Integer; Value: TFcp_Duplicatac);
begin
  inherited SetItem(Index, Value);
end;

end.