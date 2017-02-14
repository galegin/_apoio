unit uFisNf;

interface

uses
  Classes, SysUtils,
  cCollection, cCollectionItem;

type
  TFis_Nf = class;
  TFis_NfClass = class of TFis_Nf;

  TFis_NfList = class;
  TFis_NfListClass = class of TFis_NfList;

  TFis_Nf = class(TcCollectionItem)
  private
    fCd_Empresa: Real;
    fNr_Fatura: Real;
    fDt_Fatura: TDateTime;
    fU_Version: String;
    fCd_Pessoa: Real;
    fCd_Empfat: Real;
    fCd_Grupoempresa: Real;
    fCd_Operador: Real;
    fDt_Cadastro: TDateTime;
    fNr_Nf: Real;
    fCd_Serie: String;
    fDt_Emissao: TDateTime;
    fTp_Origememissao: String;
    fTp_Moddctofiscal: Real;
    fTp_Operacao: String;
    fTp_Situacao: String;
    fCd_Empresaori: Real;
    fNr_Transacaoori: Real;
    fDt_Transacaoori: TDateTime;
    fCd_Operacao: Real;
    fCd_Condpgto: Real;
    fCd_Modelonf: Real;
    fNr_Pre: Real;
    fHr_Saida: TDateTime;
    fDt_Saidaentrada: TDateTime;
    fCd_Compvend: Real;
    fIn_Frete: String;
    fCd_Usuimpressao: Real;
    fDt_Impressao: TDateTime;
    fNr_Impressao: Real;
    fPr_Desconto: Real;
    fQt_Faturado: Real;
    fVl_Totalproduto: Real;
    fVl_Despacessor: Real;
    fVl_Frete: Real;
    fVl_Seguro: Real;
    fVl_Ipi: Real;
    fVl_Desconto: Real;
    fVl_Totalnota: Real;
    fVl_Baseicmssubs: Real;
    fVl_Icmssubst: Real;
    fVl_Baseicms: Real;
    fVl_Icms: Real;
  public
    constructor Create; reintroduce;
    destructor Destroy; override;
  published
    property Cd_Empresa : Real read fCd_Empresa write fCd_Empresa;
    property Nr_Fatura : Real read fNr_Fatura write fNr_Fatura;
    property Dt_Fatura : TDateTime read fDt_Fatura write fDt_Fatura;
    property U_Version : String read fU_Version write fU_Version;
    property Cd_Pessoa : Real read fCd_Pessoa write fCd_Pessoa;
    property Cd_Empfat : Real read fCd_Empfat write fCd_Empfat;
    property Cd_Grupoempresa : Real read fCd_Grupoempresa write fCd_Grupoempresa;
    property Cd_Operador : Real read fCd_Operador write fCd_Operador;
    property Dt_Cadastro : TDateTime read fDt_Cadastro write fDt_Cadastro;
    property Nr_Nf : Real read fNr_Nf write fNr_Nf;
    property Cd_Serie : String read fCd_Serie write fCd_Serie;
    property Dt_Emissao : TDateTime read fDt_Emissao write fDt_Emissao;
    property Tp_Origememissao : String read fTp_Origememissao write fTp_Origememissao;
    property Tp_Moddctofiscal : Real read fTp_Moddctofiscal write fTp_Moddctofiscal;
    property Tp_Operacao : String read fTp_Operacao write fTp_Operacao;
    property Tp_Situacao : String read fTp_Situacao write fTp_Situacao;
    property Cd_Empresaori : Real read fCd_Empresaori write fCd_Empresaori;
    property Nr_Transacaoori : Real read fNr_Transacaoori write fNr_Transacaoori;
    property Dt_Transacaoori : TDateTime read fDt_Transacaoori write fDt_Transacaoori;
    property Cd_Operacao : Real read fCd_Operacao write fCd_Operacao;
    property Cd_Condpgto : Real read fCd_Condpgto write fCd_Condpgto;
    property Cd_Modelonf : Real read fCd_Modelonf write fCd_Modelonf;
    property Nr_Pre : Real read fNr_Pre write fNr_Pre;
    property Hr_Saida : TDateTime read fHr_Saida write fHr_Saida;
    property Dt_Saidaentrada : TDateTime read fDt_Saidaentrada write fDt_Saidaentrada;
    property Cd_Compvend : Real read fCd_Compvend write fCd_Compvend;
    property In_Frete : String read fIn_Frete write fIn_Frete;
    property Cd_Usuimpressao : Real read fCd_Usuimpressao write fCd_Usuimpressao;
    property Dt_Impressao : TDateTime read fDt_Impressao write fDt_Impressao;
    property Nr_Impressao : Real read fNr_Impressao write fNr_Impressao;
    property Pr_Desconto : Real read fPr_Desconto write fPr_Desconto;
    property Qt_Faturado : Real read fQt_Faturado write fQt_Faturado;
    property Vl_Totalproduto : Real read fVl_Totalproduto write fVl_Totalproduto;
    property Vl_Despacessor : Real read fVl_Despacessor write fVl_Despacessor;
    property Vl_Frete : Real read fVl_Frete write fVl_Frete;
    property Vl_Seguro : Real read fVl_Seguro write fVl_Seguro;
    property Vl_Ipi : Real read fVl_Ipi write fVl_Ipi;
    property Vl_Desconto : Real read fVl_Desconto write fVl_Desconto;
    property Vl_Totalnota : Real read fVl_Totalnota write fVl_Totalnota;
    property Vl_Baseicmssubs : Real read fVl_Baseicmssubs write fVl_Baseicmssubs;
    property Vl_Icmssubst : Real read fVl_Icmssubst write fVl_Icmssubst;
    property Vl_Baseicms : Real read fVl_Baseicms write fVl_Baseicms;
    property Vl_Icms : Real read fVl_Icms write fVl_Icms;
  end;

  TFis_NfList = class(TcCollection)
  private
    function GetItem(Index: Integer): TFis_Nf;
    procedure SetItem(Index: Integer; Value: TFis_Nf);
  public
    constructor Create(AOwner: TPersistent);
    function Add: TFis_Nf;
    property Items[Index: Integer]: TFis_Nf read GetItem write SetItem; default;
  end;
  
implementation

{ TFis_Nf }

constructor TFis_Nf.Create;
begin

end;

destructor TFis_Nf.Destroy;
begin

  inherited;
end;

{ TFis_NfList }

constructor TFis_NfList.Create(AOwner: TPersistent);
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