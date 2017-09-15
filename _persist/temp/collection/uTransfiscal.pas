unit uTransfiscal;

interface

uses
  Classes, SysUtils,
  mCollection, mCollectionItem;

type
  TTransfiscal = class;
  TTransfiscalClass = class of TTransfiscal;

  TTransfiscalList = class;
  TTransfiscalListClass = class of TTransfiscalList;

  TTransfiscal = class(TmCollectionItem)
  private
    fId_Transacao: String;
    fU_Version: String;
    fCd_Operador: Integer;
    fDt_Cadastro: String;
    fTp_Operacao: Integer;
    fTp_Modalidade: Integer;
    fTp_Modelonf: Integer;
    fCd_Serie: String;
    fNr_Nf: Integer;
    fTp_Processamento: String;
    fDs_Chaveacesso: String;
    fDt_Recebimento: String;
    fNr_Recibo: String;
  public
    constructor Create(ACollection: TCollection); override;
    destructor Destroy; override;
  published
    property Id_Transacao : String read fId_Transacao write SetId_Transacao;
    property U_Version : String read fU_Version write SetU_Version;
    property Cd_Operador : Integer read fCd_Operador write SetCd_Operador;
    property Dt_Cadastro : String read fDt_Cadastro write SetDt_Cadastro;
    property Tp_Operacao : Integer read fTp_Operacao write SetTp_Operacao;
    property Tp_Modalidade : Integer read fTp_Modalidade write SetTp_Modalidade;
    property Tp_Modelonf : Integer read fTp_Modelonf write SetTp_Modelonf;
    property Cd_Serie : String read fCd_Serie write SetCd_Serie;
    property Nr_Nf : Integer read fNr_Nf write SetNr_Nf;
    property Tp_Processamento : String read fTp_Processamento write SetTp_Processamento;
    property Ds_Chaveacesso : String read fDs_Chaveacesso write SetDs_Chaveacesso;
    property Dt_Recebimento : String read fDt_Recebimento write SetDt_Recebimento;
    property Nr_Recibo : String read fNr_Recibo write SetNr_Recibo;
  end;

  TTransfiscalList = class(TmCollection)
  private
    function GetItem(Index: Integer): TTransfiscal;
    procedure SetItem(Index: Integer; Value: TTransfiscal);
  public
    constructor Create(AOwner: TPersistentCollection);
    function Add: TTransfiscal;
    property Items[Index: Integer]: TTransfiscal read GetItem write SetItem; default;
  end;

implementation

{ TTransfiscal }

constructor TTransfiscal.Create(ACollection: TCollection);
begin
  inherited;

end;

destructor TTransfiscal.Destroy;
begin

  inherited;
end;

{ TTransfiscalList }

constructor TTransfiscalList.Create(AOwner: TPersistentCollection);
begin
  inherited Create(TTransfiscal);
end;

function TTransfiscalList.Add: TTransfiscal;
begin
  Result := TTransfiscal(inherited Add);
  Result.create;
end;

function TTransfiscalList.GetItem(Index: Integer): TTransfiscal;
begin
  Result := TTransfiscal(inherited GetItem(Index));
end;

procedure TTransfiscalList.SetItem(Index: Integer; Value: TTransfiscal);
begin
  inherited SetItem(Index, Value);
end;

end.