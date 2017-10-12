unit uFisNf;

interface

uses
  Classes, SysUtils,
  mCollection, mCollectionItem;

type
  TFis_Nf = class;
  TFis_NfClass = class of TFis_Nf;

  TFis_NfList = class;
  TFis_NfListClass = class of TFis_NfList;

  TFis_Nf = class(TmCollectionItem)
  private
    fCd_Empresa: String;
    fNr_Fatura: String;
    fDt_Fatura: String;
    fU_Version: String;
    fCd_Pessoa: String;
    fCd_Empfat: String;
    fCd_Grupoempresa: String;
    fCd_Operador: String;
    fDt_Cadastro: String;
    fNr_Nf: String;
    fCd_Serie: String;
    fDt_Emissao: String;
    fTp_Origememissao: String;
    fTp_Moddctofiscal: String;
    fTp_Operacao: String;
    fTp_Situacao: String;
    fCd_Empresaori: String;
    fNr_Transacaoori: String;
    fDt_Transacaoori: String;
    fCd_Operacao: String;
    fCd_Condpgto: String;
    fCd_Modelonf: String;
    fNr_Pre: String;
    fHr_Saida: String;
    fDt_Saidaentrada: String;
    fCd_Compvend: String;
    fIn_Frete: String;
    fCd_Usuimpressao: String;
    fDt_Impressao: String;
    fNr_Impressao: String;
    fPr_Desconto: String;
    fQt_Faturado: String;
    fVl_Totalproduto: String;
    fVl_Despacessor: String;
    fVl_Frete: String;
    fVl_Seguro: String;
    fVl_Ipi: String;
    fVl_Desconto: String;
    fVl_Totalnota: String;
    fVl_Baseicmssubs: String;
    fVl_Icmssubst: String;
    fVl_Baseicms: String;
    fVl_Icms: String;
  public
    constructor Create(ACollection: TCollection); override;
    destructor Destroy; override;
  published
    property Cd_Empresa : String read fCd_Empresa write SetCd_Empresa;
    property Nr_Fatura : String read fNr_Fatura write SetNr_Fatura;
    property Dt_Fatura : String read fDt_Fatura write SetDt_Fatura;
    property U_Version : String read fU_Version write SetU_Version;
    property Cd_Pessoa : String read fCd_Pessoa write SetCd_Pessoa;
    property Cd_Empfat : String read fCd_Empfat write SetCd_Empfat;
    property Cd_Grupoempresa : String read fCd_Grupoempresa write SetCd_Grupoempresa;
    property Cd_Operador : String read fCd_Operador write SetCd_Operador;
    property Dt_Cadastro : String read fDt_Cadastro write SetDt_Cadastro;
    property Nr_Nf : String read fNr_Nf write SetNr_Nf;
    property Cd_Serie : String read fCd_Serie write SetCd_Serie;
    property Dt_Emissao : String read fDt_Emissao write SetDt_Emissao;
    property Tp_Origememissao : String read fTp_Origememissao write SetTp_Origememissao;
    property Tp_Moddctofiscal : String read fTp_Moddctofiscal write SetTp_Moddctofiscal;
    property Tp_Operacao : String read fTp_Operacao write SetTp_Operacao;
    property Tp_Situacao : String read fTp_Situacao write SetTp_Situacao;
    property Cd_Empresaori : String read fCd_Empresaori write SetCd_Empresaori;
    property Nr_Transacaoori : String read fNr_Transacaoori write SetNr_Transacaoori;
    property Dt_Transacaoori : String read fDt_Transacaoori write SetDt_Transacaoori;
    property Cd_Operacao : String read fCd_Operacao write SetCd_Operacao;
    property Cd_Condpgto : String read fCd_Condpgto write SetCd_Condpgto;
    property Cd_Modelonf : String read fCd_Modelonf write SetCd_Modelonf;
    property Nr_Pre : String read fNr_Pre write SetNr_Pre;
    property Hr_Saida : String read fHr_Saida write SetHr_Saida;
    property Dt_Saidaentrada : String read fDt_Saidaentrada write SetDt_Saidaentrada;
    property Cd_Compvend : String read fCd_Compvend write SetCd_Compvend;
    property In_Frete : String read fIn_Frete write SetIn_Frete;
    property Cd_Usuimpressao : String read fCd_Usuimpressao write SetCd_Usuimpressao;
    property Dt_Impressao : String read fDt_Impressao write SetDt_Impressao;
    property Nr_Impressao : String read fNr_Impressao write SetNr_Impressao;
    property Pr_Desconto : String read fPr_Desconto write SetPr_Desconto;
    property Qt_Faturado : String read fQt_Faturado write SetQt_Faturado;
    property Vl_Totalproduto : String read fVl_Totalproduto write SetVl_Totalproduto;
    property Vl_Despacessor : String read fVl_Despacessor write SetVl_Despacessor;
    property Vl_Frete : String read fVl_Frete write SetVl_Frete;
    property Vl_Seguro : String read fVl_Seguro write SetVl_Seguro;
    property Vl_Ipi : String read fVl_Ipi write SetVl_Ipi;
    property Vl_Desconto : String read fVl_Desconto write SetVl_Desconto;
    property Vl_Totalnota : String read fVl_Totalnota write SetVl_Totalnota;
    property Vl_Baseicmssubs : String read fVl_Baseicmssubs write SetVl_Baseicmssubs;
    property Vl_Icmssubst : String read fVl_Icmssubst write SetVl_Icmssubst;
    property Vl_Baseicms : String read fVl_Baseicms write SetVl_Baseicms;
    property Vl_Icms : String read fVl_Icms write SetVl_Icms;
  end;

  TFis_NfList = class(TmCollection)
  private
    function GetItem(Index: Integer): TFis_Nf;
    procedure SetItem(Index: Integer; Value: TFis_Nf);
  public
    constructor Create(AOwner: TPersistentCollection);
    function Add: TFis_Nf;
    property Items[Index: Integer]: TFis_Nf read GetItem write SetItem; default;
  end;

implementation

{ TFis_Nf }

constructor TFis_Nf.Create(ACollection: TCollection);
begin
  inherited;

end;

destructor TFis_Nf.Destroy;
begin

  inherited;
end;

{ TFis_NfList }

constructor TFis_NfList.Create(AOwner: TPersistentCollection);
begin
  inherited Create(TFis_Nf);
end;

function TFis_NfList.Add: TFis_Nf;
begin
  Result := TFis_Nf(inherited Add);
  Result.create;
end;

function TFis_NfList.GetItem(Index: Integer): TFis_Nf;
begin
  Result := TFis_Nf(inherited GetItem(Index));
end;

procedure TFis_NfList.SetItem(Index: Integer; Value: TFis_Nf);
begin
  inherited SetItem(Index, Value);
end;

end.