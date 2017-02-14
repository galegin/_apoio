unit uGerOperinfo;

interface

uses
  Classes, SysUtils,
  cCollection, cCollectionItem;

type
  TGer_Operinfo = class;
  TGer_OperinfoClass = class of TGer_Operinfo;

  TGer_OperinfoList = class;
  TGer_OperinfoListClass = class of TGer_OperinfoList;

  TGer_Operinfo = class(TcCollectionItem)
  private
    fCd_Empresa: Real;
    fCd_Operacao: Real;
    fU_Version: String;
    fCd_Operador: Real;
    fDt_Cadastro: TDateTime;
    fIn_Prodacabado: String;
    fIn_Matprima: String;
    fIn_Matconsumo: String;
    fIn_Servico: String;
    fCd_Modelonf: Real;
    fCd_Modelotra: Real;
    fCd_Condpgto: Real;
    fNr_Filaspooltra: Real;
    fNr_Filaspoolnf: Real;
    fCd_Pessoa: Real;
    fNm_Jobtra: String;
    fNm_Jobnf: String;
    fQt_Minima: Real;
    fQt_Maxima: Real;
    fCd_Vendedor: Real;
    fVl_Variacao: Real;
    fTp_Variacao: String;
    fTp_Agrupamento: Real;
    fTp_Devfin: Real;
    fTp_Lote: Real;
    fTp_Inspecao: Real;
    fIn_Ccusto: String;
    fIn_Produtobloq: String;
    fIn_Devfatconsig: String;
    fIn_Validareserva: String;
    fIn_Estoqterceiro: String;
    fIn_Estoqdeterceiro: String;
    fIn_Validafornec: String;
    fTp_Impressaotra: Real;
    fCd_Natcredpis: Real;
  public
    constructor Create; reintroduce;
    destructor Destroy; override;
  published
    property Cd_Empresa : Real read fCd_Empresa write fCd_Empresa;
    property Cd_Operacao : Real read fCd_Operacao write fCd_Operacao;
    property U_Version : String read fU_Version write fU_Version;
    property Cd_Operador : Real read fCd_Operador write fCd_Operador;
    property Dt_Cadastro : TDateTime read fDt_Cadastro write fDt_Cadastro;
    property In_Prodacabado : String read fIn_Prodacabado write fIn_Prodacabado;
    property In_Matprima : String read fIn_Matprima write fIn_Matprima;
    property In_Matconsumo : String read fIn_Matconsumo write fIn_Matconsumo;
    property In_Servico : String read fIn_Servico write fIn_Servico;
    property Cd_Modelonf : Real read fCd_Modelonf write fCd_Modelonf;
    property Cd_Modelotra : Real read fCd_Modelotra write fCd_Modelotra;
    property Cd_Condpgto : Real read fCd_Condpgto write fCd_Condpgto;
    property Nr_Filaspooltra : Real read fNr_Filaspooltra write fNr_Filaspooltra;
    property Nr_Filaspoolnf : Real read fNr_Filaspoolnf write fNr_Filaspoolnf;
    property Cd_Pessoa : Real read fCd_Pessoa write fCd_Pessoa;
    property Nm_Jobtra : String read fNm_Jobtra write fNm_Jobtra;
    property Nm_Jobnf : String read fNm_Jobnf write fNm_Jobnf;
    property Qt_Minima : Real read fQt_Minima write fQt_Minima;
    property Qt_Maxima : Real read fQt_Maxima write fQt_Maxima;
    property Cd_Vendedor : Real read fCd_Vendedor write fCd_Vendedor;
    property Vl_Variacao : Real read fVl_Variacao write fVl_Variacao;
    property Tp_Variacao : String read fTp_Variacao write fTp_Variacao;
    property Tp_Agrupamento : Real read fTp_Agrupamento write fTp_Agrupamento;
    property Tp_Devfin : Real read fTp_Devfin write fTp_Devfin;
    property Tp_Lote : Real read fTp_Lote write fTp_Lote;
    property Tp_Inspecao : Real read fTp_Inspecao write fTp_Inspecao;
    property In_Ccusto : String read fIn_Ccusto write fIn_Ccusto;
    property In_Produtobloq : String read fIn_Produtobloq write fIn_Produtobloq;
    property In_Devfatconsig : String read fIn_Devfatconsig write fIn_Devfatconsig;
    property In_Validareserva : String read fIn_Validareserva write fIn_Validareserva;
    property In_Estoqterceiro : String read fIn_Estoqterceiro write fIn_Estoqterceiro;
    property In_Estoqdeterceiro : String read fIn_Estoqdeterceiro write fIn_Estoqdeterceiro;
    property In_Validafornec : String read fIn_Validafornec write fIn_Validafornec;
    property Tp_Impressaotra : Real read fTp_Impressaotra write fTp_Impressaotra;
    property Cd_Natcredpis : Real read fCd_Natcredpis write fCd_Natcredpis;
  end;

  TGer_OperinfoList = class(TcCollection)
  private
    function GetItem(Index: Integer): TGer_Operinfo;
    procedure SetItem(Index: Integer; Value: TGer_Operinfo);
  public
    constructor Create(AOwner: TPersistent);
    function Add: TGer_Operinfo;
    property Items[Index: Integer]: TGer_Operinfo read GetItem write SetItem; default;
  end;
  
implementation

{ TGer_Operinfo }

constructor TGer_Operinfo.Create;
begin

end;

destructor TGer_Operinfo.Destroy;
begin

  inherited;
end;

{ TGer_OperinfoList }

constructor TGer_OperinfoList.Create(AOwner: TPersistent);
begin
  inherited Create(TGer_Operinfo);
end;

function TGer_OperinfoList.Add: TGer_Operinfo;
begin
  Result := TGer_Operinfo(inherited Add);
  Result.create;
end;

function TGer_OperinfoList.GetItem(Index: Integer): TGer_Operinfo;
begin
  Result := TGer_Operinfo(inherited GetItem(Index));
end;

procedure TGer_OperinfoList.SetItem(Index: Integer; Value: TGer_Operinfo);
begin
  inherited SetItem(Index, Value);
end;

end.