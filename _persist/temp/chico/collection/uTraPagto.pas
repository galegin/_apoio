unit uTraPagto;

interface

uses
  Classes, SysUtils,
  mCollection, mCollectionItem;

type
  TTra_Pagto = class;
  TTra_PagtoClass = class of TTra_Pagto;

  TTra_PagtoList = class;
  TTra_PagtoListClass = class of TTra_PagtoList;

  TTra_Pagto = class(TmCollectionItem)
  private
    fCd_Empresa: String;
    fNr_Transacao: String;
    fDt_Transacao: String;
    fNr_Sequencia: String;
    fU_Version: String;
    fCd_Operador: String;
    fDt_Cadastro: String;
    fTp_Documento: String;
    fNr_Histrelsub: String;
    fNr_Documento: String;
    fVl_Documento: String;
    fDt_Vencimento: String;
    fCd_Autorizacao: String;
    fNr_Nsu: String;
    fDs_Redetef: String;
    fNr_Parcela: String;
    fNr_Parcelas: String;
    fNr_Banco: String;
    fNr_Agencia: String;
    fDs_Conta: String;
    fNr_Cheque: String;
  public
    constructor Create(ACollection: TCollection); override;
    destructor Destroy; override;
  published
    property Cd_Empresa : String read fCd_Empresa write SetCd_Empresa;
    property Nr_Transacao : String read fNr_Transacao write SetNr_Transacao;
    property Dt_Transacao : String read fDt_Transacao write SetDt_Transacao;
    property Nr_Sequencia : String read fNr_Sequencia write SetNr_Sequencia;
    property U_Version : String read fU_Version write SetU_Version;
    property Cd_Operador : String read fCd_Operador write SetCd_Operador;
    property Dt_Cadastro : String read fDt_Cadastro write SetDt_Cadastro;
    property Tp_Documento : String read fTp_Documento write SetTp_Documento;
    property Nr_Histrelsub : String read fNr_Histrelsub write SetNr_Histrelsub;
    property Nr_Documento : String read fNr_Documento write SetNr_Documento;
    property Vl_Documento : String read fVl_Documento write SetVl_Documento;
    property Dt_Vencimento : String read fDt_Vencimento write SetDt_Vencimento;
    property Cd_Autorizacao : String read fCd_Autorizacao write SetCd_Autorizacao;
    property Nr_Nsu : String read fNr_Nsu write SetNr_Nsu;
    property Ds_Redetef : String read fDs_Redetef write SetDs_Redetef;
    property Nr_Parcela : String read fNr_Parcela write SetNr_Parcela;
    property Nr_Parcelas : String read fNr_Parcelas write SetNr_Parcelas;
    property Nr_Banco : String read fNr_Banco write SetNr_Banco;
    property Nr_Agencia : String read fNr_Agencia write SetNr_Agencia;
    property Ds_Conta : String read fDs_Conta write SetDs_Conta;
    property Nr_Cheque : String read fNr_Cheque write SetNr_Cheque;
  end;

  TTra_PagtoList = class(TmCollection)
  private
    function GetItem(Index: Integer): TTra_Pagto;
    procedure SetItem(Index: Integer; Value: TTra_Pagto);
  public
    constructor Create(AOwner: TPersistentCollection);
    function Add: TTra_Pagto;
    property Items[Index: Integer]: TTra_Pagto read GetItem write SetItem; default;
  end;

implementation

{ TTra_Pagto }

constructor TTra_Pagto.Create(ACollection: TCollection);
begin
  inherited;

end;

destructor TTra_Pagto.Destroy;
begin

  inherited;
end;

{ TTra_PagtoList }

constructor TTra_PagtoList.Create(AOwner: TPersistentCollection);
begin
  inherited Create(TTra_Pagto);
end;

function TTra_PagtoList.Add: TTra_Pagto;
begin
  Result := TTra_Pagto(inherited Add);
  Result.create;
end;

function TTra_PagtoList.GetItem(Index: Integer): TTra_Pagto;
begin
  Result := TTra_Pagto(inherited GetItem(Index));
end;

procedure TTra_PagtoList.SetItem(Index: Integer; Value: TTra_Pagto);
begin
  inherited SetItem(Index, Value);
end;

end.