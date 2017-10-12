unit uTranspagto;

interface

uses
  Classes, SysUtils,
  mCollection, mCollectionItem;

type
  TTranspagto = class;
  TTranspagtoClass = class of TTranspagto;

  TTranspagtoList = class;
  TTranspagtoListClass = class of TTranspagtoList;

  TTranspagto = class(TmCollectionItem)
  private
    fId_Transacao: String;
    fNr_Seq: Integer;
    fU_Version: String;
    fCd_Operador: Integer;
    fDt_Cadastro: String;
    fId_Caixa: Integer;
    fTp_Documento: Integer;
    fId_Histrel: Integer;
    fNr_Parcela: Integer;
    fNr_Parcelas: Integer;
    fNr_Documento: Integer;
    fVl_Documento: String;
    fDt_Vencimento: String;
    fCd_Autorizacao: String;
    fNr_Nsu: Integer;
    fDs_Redetef: String;
    fNm_Operadora: String;
    fNr_Banco: Integer;
    fNr_Agencia: Integer;
    fDs_Conta: String;
    fNr_Cheque: Integer;
    fDs_Cmc7: String;
    fTp_Baixa: Integer;
    fCd_Operbaixa: Integer;
    fDt_Baixa: String;
  public
    constructor Create(ACollection: TCollection); override;
    destructor Destroy; override;
  published
    property Id_Transacao : String read fId_Transacao write SetId_Transacao;
    property Nr_Seq : Integer read fNr_Seq write SetNr_Seq;
    property U_Version : String read fU_Version write SetU_Version;
    property Cd_Operador : Integer read fCd_Operador write SetCd_Operador;
    property Dt_Cadastro : String read fDt_Cadastro write SetDt_Cadastro;
    property Id_Caixa : Integer read fId_Caixa write SetId_Caixa;
    property Tp_Documento : Integer read fTp_Documento write SetTp_Documento;
    property Id_Histrel : Integer read fId_Histrel write SetId_Histrel;
    property Nr_Parcela : Integer read fNr_Parcela write SetNr_Parcela;
    property Nr_Parcelas : Integer read fNr_Parcelas write SetNr_Parcelas;
    property Nr_Documento : Integer read fNr_Documento write SetNr_Documento;
    property Vl_Documento : String read fVl_Documento write SetVl_Documento;
    property Dt_Vencimento : String read fDt_Vencimento write SetDt_Vencimento;
    property Cd_Autorizacao : String read fCd_Autorizacao write SetCd_Autorizacao;
    property Nr_Nsu : Integer read fNr_Nsu write SetNr_Nsu;
    property Ds_Redetef : String read fDs_Redetef write SetDs_Redetef;
    property Nm_Operadora : String read fNm_Operadora write SetNm_Operadora;
    property Nr_Banco : Integer read fNr_Banco write SetNr_Banco;
    property Nr_Agencia : Integer read fNr_Agencia write SetNr_Agencia;
    property Ds_Conta : String read fDs_Conta write SetDs_Conta;
    property Nr_Cheque : Integer read fNr_Cheque write SetNr_Cheque;
    property Ds_Cmc7 : String read fDs_Cmc7 write SetDs_Cmc7;
    property Tp_Baixa : Integer read fTp_Baixa write SetTp_Baixa;
    property Cd_Operbaixa : Integer read fCd_Operbaixa write SetCd_Operbaixa;
    property Dt_Baixa : String read fDt_Baixa write SetDt_Baixa;
  end;

  TTranspagtoList = class(TmCollection)
  private
    function GetItem(Index: Integer): TTranspagto;
    procedure SetItem(Index: Integer; Value: TTranspagto);
  public
    constructor Create(AOwner: TPersistentCollection);
    function Add: TTranspagto;
    property Items[Index: Integer]: TTranspagto read GetItem write SetItem; default;
  end;

implementation

{ TTranspagto }

constructor TTranspagto.Create(ACollection: TCollection);
begin
  inherited;

end;

destructor TTranspagto.Destroy;
begin

  inherited;
end;

{ TTranspagtoList }

constructor TTranspagtoList.Create(AOwner: TPersistentCollection);
begin
  inherited Create(TTranspagto);
end;

function TTranspagtoList.Add: TTranspagto;
begin
  Result := TTranspagto(inherited Add);
  Result.create;
end;

function TTranspagtoList.GetItem(Index: Integer): TTranspagto;
begin
  Result := TTranspagto(inherited GetItem(Index));
end;

procedure TTranspagtoList.SetItem(Index: Integer; Value: TTranspagto);
begin
  inherited SetItem(Index, Value);
end;

end.