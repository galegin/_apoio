unit uGerOperinfo;

interface

uses
  Classes, SysUtils,
  System.Generics.Collections,
  mMapping;

type
  [Tabela('GER_OPERINFO')]
  TGer_Operinfo = class(TmMapping)
  private
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
  published
    [Campo('CD_EMPRESA', tfKey)]
    property Cd_Empresa : String read fCd_Empresa write fCd_Empresa;
    [Campo('CD_OPERACAO', tfKey)]
    property Cd_Operacao : String read fCd_Operacao write fCd_Operacao;
    [Campo('U_VERSION', tfNul)]
    property U_Version : String read fU_Version write fU_Version;
    [Campo('CD_OPERADOR', tfReq)]
    property Cd_Operador : String read fCd_Operador write fCd_Operador;
    [Campo('DT_CADASTRO', tfReq)]
    property Dt_Cadastro : String read fDt_Cadastro write fDt_Cadastro;
    [Campo('IN_PRODACABADO', tfNul)]
    property In_Prodacabado : String read fIn_Prodacabado write fIn_Prodacabado;
    [Campo('IN_MATPRIMA', tfNul)]
    property In_Matprima : String read fIn_Matprima write fIn_Matprima;
    [Campo('IN_MATCONSUMO', tfNul)]
    property In_Matconsumo : String read fIn_Matconsumo write fIn_Matconsumo;
    [Campo('IN_SERVICO', tfNul)]
    property In_Servico : String read fIn_Servico write fIn_Servico;
    [Campo('CD_MODELONF', tfNul)]
    property Cd_Modelonf : String read fCd_Modelonf write fCd_Modelonf;
    [Campo('CD_MODELOTRA', tfNul)]
    property Cd_Modelotra : String read fCd_Modelotra write fCd_Modelotra;
    [Campo('CD_CONDPGTO', tfNul)]
    property Cd_Condpgto : String read fCd_Condpgto write fCd_Condpgto;
    [Campo('NR_FILASPOOLTRA', tfNul)]
    property Nr_Filaspooltra : String read fNr_Filaspooltra write fNr_Filaspooltra;
    [Campo('NR_FILASPOOLNF', tfNul)]
    property Nr_Filaspoolnf : String read fNr_Filaspoolnf write fNr_Filaspoolnf;
    [Campo('CD_PESSOA', tfNul)]
    property Cd_Pessoa : String read fCd_Pessoa write fCd_Pessoa;
    [Campo('NM_JOBTRA', tfNul)]
    property Nm_Jobtra : String read fNm_Jobtra write fNm_Jobtra;
    [Campo('NM_JOBNF', tfNul)]
    property Nm_Jobnf : String read fNm_Jobnf write fNm_Jobnf;
    [Campo('QT_MINIMA', tfNul)]
    property Qt_Minima : String read fQt_Minima write fQt_Minima;
    [Campo('QT_MAXIMA', tfNul)]
    property Qt_Maxima : String read fQt_Maxima write fQt_Maxima;
    [Campo('CD_VENDEDOR', tfNul)]
    property Cd_Vendedor : String read fCd_Vendedor write fCd_Vendedor;
    [Campo('VL_VARIACAO', tfNul)]
    property Vl_Variacao : String read fVl_Variacao write fVl_Variacao;
    [Campo('TP_VARIACAO', tfNul)]
    property Tp_Variacao : String read fTp_Variacao write fTp_Variacao;
    [Campo('TP_AGRUPAMENTO', tfNul)]
    property Tp_Agrupamento : String read fTp_Agrupamento write fTp_Agrupamento;
    [Campo('TP_DEVFIN', tfNul)]
    property Tp_Devfin : String read fTp_Devfin write fTp_Devfin;
    [Campo('TP_LOTE', tfNul)]
    property Tp_Lote : String read fTp_Lote write fTp_Lote;
    [Campo('TP_INSPECAO', tfNul)]
    property Tp_Inspecao : String read fTp_Inspecao write fTp_Inspecao;
    [Campo('IN_CCUSTO', tfNul)]
    property In_Ccusto : String read fIn_Ccusto write fIn_Ccusto;
    [Campo('IN_PRODUTOBLOQ', tfNul)]
    property In_Produtobloq : String read fIn_Produtobloq write fIn_Produtobloq;
    [Campo('IN_DEVFATCONSIG', tfNul)]
    property In_Devfatconsig : String read fIn_Devfatconsig write fIn_Devfatconsig;
    [Campo('IN_VALIDARESERVA', tfNul)]
    property In_Validareserva : String read fIn_Validareserva write fIn_Validareserva;
    [Campo('IN_ESTOQTERCEIRO', tfNul)]
    property In_Estoqterceiro : String read fIn_Estoqterceiro write fIn_Estoqterceiro;
    [Campo('IN_ESTOQDETERCEIRO', tfNul)]
    property In_Estoqdeterceiro : String read fIn_Estoqdeterceiro write fIn_Estoqdeterceiro;
    [Campo('IN_VALIDAFORNEC', tfNul)]
    property In_Validafornec : String read fIn_Validafornec write fIn_Validafornec;
    [Campo('TP_IMPRESSAOTRA', tfNul)]
    property Tp_Impressaotra : String read fTp_Impressaotra write fTp_Impressaotra;
    [Campo('CD_NATCREDPIS', tfNul)]
    property Cd_Natcredpis : String read fCd_Natcredpis write fCd_Natcredpis;
  end;

  TGer_Operinfos = class(TList<Ger_Operinfo>);

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

end.