unit uFisNfitemad;

interface

uses
  Classes, SysUtils,
  cCollection, cCollectionItem;

type
  TFis_Nfitemad = class;
  TFis_NfitemadClass = class of TFis_Nfitemad;

  TFis_NfitemadList = class;
  TFis_NfitemadListClass = class of TFis_NfitemadList;

  TFis_Nfitemad = class(TcCollectionItem)
  private
    fCd_Empresa: Real;
    fNr_Fatura: Real;
    fDt_Fatura: TDateTime;
    fNr_Item: Real;
    fU_Version: String;
    fCd_Operador: Real;
    fDt_Cadastro: TDateTime;
    fDs_Dadosadic: String;
  public
    constructor Create; reintroduce;
    destructor Destroy; override;
  published
    property Cd_Empresa : Real read fCd_Empresa write fCd_Empresa;
    property Nr_Fatura : Real read fNr_Fatura write fNr_Fatura;
    property Dt_Fatura : TDateTime read fDt_Fatura write fDt_Fatura;
    property Nr_Item : Real read fNr_Item write fNr_Item;
    property U_Version : String read fU_Version write fU_Version;
    property Cd_Operador : Real read fCd_Operador write fCd_Operador;
    property Dt_Cadastro : TDateTime read fDt_Cadastro write fDt_Cadastro;
    property Ds_Dadosadic : String read fDs_Dadosadic write fDs_Dadosadic;
  end;

  TFis_NfitemadList = class(TcCollection)
  private
    function GetItem(Index: Integer): TFis_Nfitemad;
    procedure SetItem(Index: Integer; Value: TFis_Nfitemad);
  public
    constructor Create(AOwner: TPersistent);
    function Add: TFis_Nfitemad;
    property Items[Index: Integer]: TFis_Nfitemad read GetItem write SetItem; default;
  end;
  
implementation

{ TFis_Nfitemad }

constructor TFis_Nfitemad.Create;
begin

end;

destructor TFis_Nfitemad.Destroy;
begin

  inherited;
end;

{ TFis_NfitemadList }

constructor TFis_NfitemadList.Create(AOwner: TPersistent);
begin
  inherited Create(TFis_Nfitemad);
end;

function TFis_NfitemadList.Add: TFis_Nfitemad;
begin
  Result := TFis_Nfitemad(inherited Add);
  Result.create;
end;

function TFis_NfitemadList.GetItem(Index: Integer): TFis_Nfitemad;
begin
  Result := TFis_Nfitemad(inherited GetItem(Index));
end;

procedure TFis_NfitemadList.SetItem(Index: Integer; Value: TFis_Nfitemad);
begin
  inherited SetItem(Index, Value);
end;

end.