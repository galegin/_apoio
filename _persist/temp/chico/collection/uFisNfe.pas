unit uFisNfe;

interface

uses
  Classes, SysUtils,
  mCollection, mCollectionItem;

type
  TFis_Nfe = class;
  TFis_NfeClass = class of TFis_Nfe;

  TFis_NfeList = class;
  TFis_NfeListClass = class of TFis_NfeList;

  TFis_Nfe = class(TmCollectionItem)
  private
    fCd_Empresa: String;
    fNr_Fatura: String;
    fDt_Fatura: String;
    fU_Version: String;
    fCd_Operador: String;
    fDt_Cadastro: String;
    fDs_Chaveacesso: String;
    fTp_Processamento: String;
    fNr_Recibo: String;
    fDt_Recebimento: String;
  public
    constructor Create(ACollection: TCollection); override;
    destructor Destroy; override;
  published
    property Cd_Empresa : String read fCd_Empresa write SetCd_Empresa;
    property Nr_Fatura : String read fNr_Fatura write SetNr_Fatura;
    property Dt_Fatura : String read fDt_Fatura write SetDt_Fatura;
    property U_Version : String read fU_Version write SetU_Version;
    property Cd_Operador : String read fCd_Operador write SetCd_Operador;
    property Dt_Cadastro : String read fDt_Cadastro write SetDt_Cadastro;
    property Ds_Chaveacesso : String read fDs_Chaveacesso write SetDs_Chaveacesso;
    property Tp_Processamento : String read fTp_Processamento write SetTp_Processamento;
    property Nr_Recibo : String read fNr_Recibo write SetNr_Recibo;
    property Dt_Recebimento : String read fDt_Recebimento write SetDt_Recebimento;
  end;

  TFis_NfeList = class(TmCollection)
  private
    function GetItem(Index: Integer): TFis_Nfe;
    procedure SetItem(Index: Integer; Value: TFis_Nfe);
  public
    constructor Create(AOwner: TPersistentCollection);
    function Add: TFis_Nfe;
    property Items[Index: Integer]: TFis_Nfe read GetItem write SetItem; default;
  end;

implementation

{ TFis_Nfe }

constructor TFis_Nfe.Create(ACollection: TCollection);
begin
  inherited;

end;

destructor TFis_Nfe.Destroy;
begin

  inherited;
end;

{ TFis_NfeList }

constructor TFis_NfeList.Create(AOwner: TPersistentCollection);
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