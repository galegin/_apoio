unit uGerOperinfo;

interface

uses
  Classes, SysUtils,
  mMapping;

type
  TGer_Operinfo = class(TmMapping)
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
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function GetMapping() : PmMapping; override;
  published
    property Cd_Empresa : String read fCd_Empresa write fCd_Empresa;
    property Cd_Operacao : String read fCd_Operacao write fCd_Operacao;
    property U_Version : String read fU_Version write fU_Version;
    property Cd_Operador : String read fCd_Operador write fCd_Operador;
    property Dt_Cadastro : String read fDt_Cadastro write fDt_Cadastro;
    property In_Prodacabado : String read fIn_Prodacabado write fIn_Prodacabado;
    property In_Matprima : String read fIn_Matprima write fIn_Matprima;
    property In_Matconsumo : String read fIn_Matconsumo write fIn_Matconsumo;
    property In_Servico : String read fIn_Servico write fIn_Servico;
    property Cd_Modelonf : String read fCd_Modelonf write fCd_Modelonf;
    property Cd_Modelotra : String read fCd_Modelotra write fCd_Modelotra;
    property Cd_Condpgto : String read fCd_Condpgto write fCd_Condpgto;
    property Nr_Filaspooltra : String read fNr_Filaspooltra write fNr_Filaspooltra;
    property Nr_Filaspoolnf : String read fNr_Filaspoolnf write fNr_Filaspoolnf;
    property Cd_Pessoa : String read fCd_Pessoa write fCd_Pessoa;
    property Nm_Jobtra : String read fNm_Jobtra write fNm_Jobtra;
    property Nm_Jobnf : String read fNm_Jobnf write fNm_Jobnf;
    property Qt_Minima : String read fQt_Minima write fQt_Minima;
    property Qt_Maxima : String read fQt_Maxima write fQt_Maxima;
    property Cd_Vendedor : String read fCd_Vendedor write fCd_Vendedor;
    property Vl_Variacao : String read fVl_Variacao write fVl_Variacao;
    property Tp_Variacao : String read fTp_Variacao write fTp_Variacao;
    property Tp_Agrupamento : String read fTp_Agrupamento write fTp_Agrupamento;
    property Tp_Devfin : String read fTp_Devfin write fTp_Devfin;
    property Tp_Lote : String read fTp_Lote write fTp_Lote;
    property Tp_Inspecao : String read fTp_Inspecao write fTp_Inspecao;
    property In_Ccusto : String read fIn_Ccusto write fIn_Ccusto;
    property In_Produtobloq : String read fIn_Produtobloq write fIn_Produtobloq;
    property In_Devfatconsig : String read fIn_Devfatconsig write fIn_Devfatconsig;
    property In_Validareserva : String read fIn_Validareserva write fIn_Validareserva;
    property In_Estoqterceiro : String read fIn_Estoqterceiro write fIn_Estoqterceiro;
    property In_Estoqdeterceiro : String read fIn_Estoqdeterceiro write fIn_Estoqdeterceiro;
    property In_Validafornec : String read fIn_Validafornec write fIn_Validafornec;
    property Tp_Impressaotra : String read fTp_Impressaotra write fTp_Impressaotra;
    property Cd_Natcredpis : String read fCd_Natcredpis write fCd_Natcredpis;
  end;

  TGer_Operinfos = class(TList)
  public
    function Add: TGer_Operinfo; overload;
  end;

implementation

{ TGer_Operinfo }

constructor TGer_Operinfo.Create(AOwner: TComponent);
begin
  inherited;

end;

destructor TGer_Operinfo.Destroy;
begin

  inherited;
end;

//--

function TGer_Operinfo.GetMapping: PmMapping;
begin
  Result := New(PmMapping);

  Result.Tabela := New(PmTabela);
  with Result.Tabela^ do begin
    Nome := 'GER_OPERINFO';
  end;

  Result.Campos := TmCampos.Create;
  with Result.Campos do begin
    Add('Cd_Empresa', 'CD_EMPRESA', tfKey);
    Add('Cd_Operacao', 'CD_OPERACAO', tfKey);
    Add('U_Version', 'U_VERSION', tfNul);
    Add('Cd_Operador', 'CD_OPERADOR', tfReq);
    Add('Dt_Cadastro', 'DT_CADASTRO', tfReq);
    Add('In_Prodacabado', 'IN_PRODACABADO', tfNul);
    Add('In_Matprima', 'IN_MATPRIMA', tfNul);
    Add('In_Matconsumo', 'IN_MATCONSUMO', tfNul);
    Add('In_Servico', 'IN_SERVICO', tfNul);
    Add('Cd_Modelonf', 'CD_MODELONF', tfNul);
    Add('Cd_Modelotra', 'CD_MODELOTRA', tfNul);
    Add('Cd_Condpgto', 'CD_CONDPGTO', tfNul);
    Add('Nr_Filaspooltra', 'NR_FILASPOOLTRA', tfNul);
    Add('Nr_Filaspoolnf', 'NR_FILASPOOLNF', tfNul);
    Add('Cd_Pessoa', 'CD_PESSOA', tfNul);
    Add('Nm_Jobtra', 'NM_JOBTRA', tfNul);
    Add('Nm_Jobnf', 'NM_JOBNF', tfNul);
    Add('Qt_Minima', 'QT_MINIMA', tfNul);
    Add('Qt_Maxima', 'QT_MAXIMA', tfNul);
    Add('Cd_Vendedor', 'CD_VENDEDOR', tfNul);
    Add('Vl_Variacao', 'VL_VARIACAO', tfNul);
    Add('Tp_Variacao', 'TP_VARIACAO', tfNul);
    Add('Tp_Agrupamento', 'TP_AGRUPAMENTO', tfNul);
    Add('Tp_Devfin', 'TP_DEVFIN', tfNul);
    Add('Tp_Lote', 'TP_LOTE', tfNul);
    Add('Tp_Inspecao', 'TP_INSPECAO', tfNul);
    Add('In_Ccusto', 'IN_CCUSTO', tfNul);
    Add('In_Produtobloq', 'IN_PRODUTOBLOQ', tfNul);
    Add('In_Devfatconsig', 'IN_DEVFATCONSIG', tfNul);
    Add('In_Validareserva', 'IN_VALIDARESERVA', tfNul);
    Add('In_Estoqterceiro', 'IN_ESTOQTERCEIRO', tfNul);
    Add('In_Estoqdeterceiro', 'IN_ESTOQDETERCEIRO', tfNul);
    Add('In_Validafornec', 'IN_VALIDAFORNEC', tfNul);
    Add('Tp_Impressaotra', 'TP_IMPRESSAOTRA', tfNul);
    Add('Cd_Natcredpis', 'CD_NATCREDPIS', tfNul);
  end;

  Result.Relacoes := TmRelacoes.Create;
  with Result.Relacoes do begin
  end;
end;

//--

{ TGer_Operinfos }

function TGer_Operinfos.Add: TGer_Operinfo;
begin
  Result := TGer_Operinfo.Create(nil);
  Self.Add(Result);
end;

end.