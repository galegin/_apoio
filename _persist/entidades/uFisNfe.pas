unit uFisNfe;

interface

uses
  Classes, SysUtils,
  cCollection, cCollectionItem;

type
  TFis_Nfe = class;
  TFis_NfeClass = class of TFis_Nfe;

  TFis_NfeList = class;
  TFis_NfeListClass = class of TFis_NfeList;

  TFis_Nfe = class(TcCollectionItem)
  private
    fCd_Empresa: Real;
    fNr_Fatura: Real;
    fDt_Fatura: TDateTime;
    fU_Version: String;
    fCd_Operador: Real;
    fDt_Cadastro: TDateTime;
    fDs_Chaveacesso: String;
    fTp_Processamento: String;
    fNr_Recibo: Real;
    fDt_Recebimento: TDateTime;
  public
    constructor Create; reintroduce;
    destructor Destroy; override;
  published
    property Cd_Empresa : Real read fCd_Empresa write fCd_Empresa;
    property Nr_Fatura : Real read fNr_Fatura write fNr_Fatura;
    property Dt_Fatura : TDateTime read fDt_Fatura write fDt_Fatura;
    property U_Version : String read fU_Version write fU_Version;
    property Cd_Operador : Real read fCd_Operador write fCd_Operador;
    property Dt_Cadastro : TDateTime read fDt_Cadastro write fDt_Cadastro;
    property Ds_Chaveacesso : String read fDs_Chaveacesso write fDs_Chaveacesso;
    property Tp_Processamento : String read fTp_Processamento write fTp_Processamento;
    property Nr_Recibo : Real read fNr_Recibo write fNr_Recibo;
    property Dt_Recebimento : TDateTime read fDt_Recebimento write fDt_Recebimento;
  end;

  TFis_NfeList = class(TcCollection)
  private
    function GetItem(Index: Integer): TFis_Nfe;
    procedure SetItem(Index: Integer; Value: TFis_Nfe);
  public
    constructor Create(AOwner: TPersistent);
    function Add: TFis_Nfe;
    property Items[Index: Integer]: TFis_Nfe read GetItem write SetItem; default;
  end;
  
implementation

{ TFis_Nfe }

constructor TFis_Nfe.Create;
begin

end;

destructor TFis_Nfe.Destroy;
begin

  inherited;
end;

{ TFis_NfeList }

constructor TFis_NfeList.Create(AOwner: TPersistent);
begin
  inherited Create(TFis_Nfe);
end;

function TFis_NfeList.Add: TFis_Nfe;
begin
  Result := TFis_Nfe(inherited Add);
  Result.create;
end;

function TFis_NfeList.GetItem(Index: Integer): TFis_Nfe;
begin
  Result := TFis_Nfe(inherited GetItem(Index));
end;

procedure TFis_NfeList.SetItem(Index: Integer; Value: TFis_Nfe);
begin
  inherited SetItem(Index, Value);
end;

end.