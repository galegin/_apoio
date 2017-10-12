unit uFisNfeinut;

interface

uses
  Classes, SysUtils,
  mCollection, mCollectionItem;

type
  TFis_Nfeinut = class;
  TFis_NfeinutClass = class of TFis_Nfeinut;

  TFis_NfeinutList = class;
  TFis_NfeinutListClass = class of TFis_NfeinutList;

  TFis_Nfeinut = class(TmCollectionItem)
  private
    fCd_Empresa: String;
    fNr_Fatura: String;
    fDt_Fatura: String;
    fU_Version: String;
    fCd_Operador: String;
    fDt_Cadastro: String;
    fTp_Moddoctofiscal: String;
    fCd_Serie: String;
    fNr_Nf: String;
    fDt_Recebimento: String;
    fNr_Recibo: String;
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
    property Tp_Moddoctofiscal : String read fTp_Moddoctofiscal write SetTp_Moddoctofiscal;
    property Cd_Serie : String read fCd_Serie write SetCd_Serie;
    property Nr_Nf : String read fNr_Nf write SetNr_Nf;
    property Dt_Recebimento : String read fDt_Recebimento write SetDt_Recebimento;
    property Nr_Recibo : String read fNr_Recibo write SetNr_Recibo;
  end;

  TFis_NfeinutList = class(TmCollection)
  private
    function GetItem(Index: Integer): TFis_Nfeinut;
    procedure SetItem(Index: Integer; Value: TFis_Nfeinut);
  public
    constructor Create(AOwner: TPersistentCollection);
    function Add: TFis_Nfeinut;
    property Items[Index: Integer]: TFis_Nfeinut read GetItem write SetItem; default;
  end;

implementation

{ TFis_Nfeinut }

constructor TFis_Nfeinut.Create(ACollection: TCollection);
begin
  inherited;

end;

destructor TFis_Nfeinut.Destroy;
begin

  inherited;
end;

{ TFis_NfeinutList }

constructor TFis_NfeinutList.Create(AOwner: TPersistentCollection);
begin
  inherited Create(TFis_Nfeinut);
end;

function TFis_NfeinutList.Add: TFis_Nfeinut;
begin
  Result := TFis_Nfeinut(inherited Add);
  Result.create;
end;

function TFis_NfeinutList.GetItem(Index: Integer): TFis_Nfeinut;
begin
  Result := TFis_Nfeinut(inherited GetItem(Index));
end;

procedure TFis_NfeinutList.SetItem(Index: Integer; Value: TFis_Nfeinut);
begin
  inherited SetItem(Index, Value);
end;

end.