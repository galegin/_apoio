unit uGerOperinfo;

interface

uses
  Classes, SysUtils,
  mCollection, mCollectionItem;

type
  TGer_Operinfo = class;
  TGer_OperinfoClass = class of TGer_Operinfo;

  TGer_OperinfoList = class;
  TGer_OperinfoListClass = class of TGer_OperinfoList;

  TGer_Operinfo = class(TmCollectionItem)
  private
    fCd_Empresa: String;
    fCd_Operacao: String;
    fU_Version: String;
    fCd_Operador: String;
    fDt_Cadastro: String;
    fIn_Prodacabado: String;
    fIn_Matprima: String;
    fIn_Matconsumo: String;
    fIn_Servico: String;
    fCd_Modelonf: String;
    fCd_Modelotra: String;
    fCd_Condpgto: String;
    fNr_Filaspooltra: String;
    fNr_Filaspoolnf: String;
    fCd_Pessoa: String;
    fNm_Jobtra: String;
    fNm_Jobnf: String;
    fQt_Minima: String;
    fQt_Maxima: String;
    fCd_Vendedor: String;
    fVl_Variacao: String;
    fTp_Variacao: String;
    fTp_Agrupamento: String;
    fTp_Devfin: String;
    fTp_Lote: String;
    fTp_Inspecao: String;
    fIn_Ccusto: String;
    fIn_Produtobloq: String;
    fIn_Devfatconsig: String;
    fIn_Validareserva: String;
    fIn_Estoqterceiro: String;
    fIn_Estoqdeterceiro: String;
    fIn_Validafornec: String;
    fTp_Impressaotra: String;
    fCd_Natcredpis: String;
  public
    constructor Create(ACollection: TCollection); override;
    destructor Destroy; override;
  published
    property Cd_Empresa : String read fCd_Empresa write SetCd_Empresa;
    property Cd_Operacao : String read fCd_Operacao write SetCd_Operacao;
    property U_Version : String read fU_Version write SetU_Version;
    property Cd_Operador : String read fCd_Operador write SetCd_Operador;
    property Dt_Cadastro : String read fDt_Cadastro write SetDt_Cadastro;
    property In_Prodacabado : String read fIn_Prodacabado write SetIn_Prodacabado;
    property In_Matprima : String read fIn_Matprima write SetIn_Matprima;
    property In_Matconsumo : String read fIn_Matconsumo write SetIn_Matconsumo;
    property In_Servico : String read fIn_Servico write SetIn_Servico;
    property Cd_Modelonf : String read fCd_Modelonf write SetCd_Modelonf;
    property Cd_Modelotra : String read fCd_Modelotra write SetCd_Modelotra;
    property Cd_Condpgto : String read fCd_Condpgto write SetCd_Condpgto;
    property Nr_Filaspooltra : String read fNr_Filaspooltra write SetNr_Filaspooltra;
    property Nr_Filaspoolnf : String read fNr_Filaspoolnf write SetNr_Filaspoolnf;
    property Cd_Pessoa : String read fCd_Pessoa write SetCd_Pessoa;
    property Nm_Jobtra : String read fNm_Jobtra write SetNm_Jobtra;
    property Nm_Jobnf : String read fNm_Jobnf write SetNm_Jobnf;
    property Qt_Minima : String read fQt_Minima write SetQt_Minima;
    property Qt_Maxima : String read fQt_Maxima write SetQt_Maxima;
    property Cd_Vendedor : String read fCd_Vendedor write SetCd_Vendedor;
    property Vl_Variacao : String read fVl_Variacao write SetVl_Variacao;
    property Tp_Variacao : String read fTp_Variacao write SetTp_Variacao;
    property Tp_Agrupamento : String read fTp_Agrupamento write SetTp_Agrupamento;
    property Tp_Devfin : String read fTp_Devfin write SetTp_Devfin;
    property Tp_Lote : String read fTp_Lote write SetTp_Lote;
    property Tp_Inspecao : String read fTp_Inspecao write SetTp_Inspecao;
    property In_Ccusto : String read fIn_Ccusto write SetIn_Ccusto;
    property In_Produtobloq : String read fIn_Produtobloq write SetIn_Produtobloq;
    property In_Devfatconsig : String read fIn_Devfatconsig write SetIn_Devfatconsig;
    property In_Validareserva : String read fIn_Validareserva write SetIn_Validareserva;
    property In_Estoqterceiro : String read fIn_Estoqterceiro write SetIn_Estoqterceiro;
    property In_Estoqdeterceiro : String read fIn_Estoqdeterceiro write SetIn_Estoqdeterceiro;
    property In_Validafornec : String read fIn_Validafornec write SetIn_Validafornec;
    property Tp_Impressaotra : String read fTp_Impressaotra write SetTp_Impressaotra;
    property Cd_Natcredpis : String read fCd_Natcredpis write SetCd_Natcredpis;
  end;

  TGer_OperinfoList = class(TmCollection)
  private
    function GetItem(Index: Integer): TGer_Operinfo;
    procedure SetItem(Index: Integer; Value: TGer_Operinfo);
  public
    constructor Create(AOwner: TPersistentCollection);
    function Add: TGer_Operinfo;
    property Items[Index: Integer]: TGer_Operinfo read GetItem write SetItem; default;
  end;

implementation

{ TGer_Operinfo }

constructor TGer_Operinfo.Create(ACollection: TCollection);
begin
  inherited;

end;

destructor TGer_Operinfo.Destroy;
begin

  inherited;
end;

{ TGer_OperinfoList }

constructor TGer_OperinfoList.Create(AOwner: TPersistentCollection);
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