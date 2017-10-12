unit uFccCtapes;

interface

uses
  Classes, SysUtils,
  System.Generics.Collections,
  mMapping;

type
  [Tabela('FCC_CTAPES')]
  TFcc_Ctapes = class(TmMapping)
  private
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
  published
    [Campo('NR_CTAPES', tfKey)]
    property Nr_Ctapes : String read fNr_Ctapes write fNr_Ctapes;
    [Campo('U_VERSION', tfNul)]
    property U_Version : String read fU_Version write fU_Version;
    [Campo('IN_NATUREZA', tfReq)]
    property In_Natureza : String read fIn_Natureza write fIn_Natureza;
    [Campo('NR_SITUACAO', tfNul)]
    property Nr_Situacao : String read fNr_Situacao write fNr_Situacao;
    [Campo('CD_EMPRESA', tfReq)]
    property Cd_Empresa : String read fCd_Empresa write fCd_Empresa;
    [Campo('CD_GRUPOEMPRESA', tfReq)]
    property Cd_Grupoempresa : String read fCd_Grupoempresa write fCd_Grupoempresa;
    [Campo('CD_OPERADOR', tfReq)]
    property Cd_Operador : String read fCd_Operador write fCd_Operador;
    [Campo('DT_CADASTRO', tfReq)]
    property Dt_Cadastro : String read fDt_Cadastro write fDt_Cadastro;
    [Campo('DS_DGCTA', tfNul)]
    property Ds_Dgcta : String read fDs_Dgcta write fDs_Dgcta;
    [Campo('IN_ATIVO', tfNul)]
    property In_Ativo : String read fIn_Ativo write fIn_Ativo;
    [Campo('TP_CONTA', tfNul)]
    property Tp_Conta : String read fTp_Conta write fTp_Conta;
    [Campo('TP_MANUTENCAO', tfReq)]
    property Tp_Manutencao : String read fTp_Manutencao write fTp_Manutencao;
    [Campo('CD_MOEDA', tfNul)]
    property Cd_Moeda : String read fCd_Moeda write fCd_Moeda;
    [Campo('NR_BANCO', tfNul)]
    property Nr_Banco : String read fNr_Banco write fNr_Banco;
    [Campo('NR_AGENCIA', tfNul)]
    property Nr_Agencia : String read fNr_Agencia write fNr_Agencia;
    [Campo('PR_TAXAJUROS', tfNul)]
    property Pr_Taxajuros : String read fPr_Taxajuros write fPr_Taxajuros;
    [Campo('NR_MODFINC', tfNul)]
    property Nr_Modfinc : String read fNr_Modfinc write fNr_Modfinc;
    [Campo('CD_EMPPAGTO', tfNul)]
    property Cd_Emppagto : String read fCd_Emppagto write fCd_Emppagto;
    [Campo('CD_PESSOA', tfNul)]
    property Cd_Pessoa : String read fCd_Pessoa write fCd_Pessoa;
    [Campo('CD_OPERCAIXA', tfNul)]
    property Cd_Opercaixa : String read fCd_Opercaixa write fCd_Opercaixa;
    [Campo('DT_LIMITEVENC', tfNul)]
    property Dt_Limitevenc : String read fDt_Limitevenc write fDt_Limitevenc;
    [Campo('DT_ABERTURA', tfNul)]
    property Dt_Abertura : String read fDt_Abertura write fDt_Abertura;
    [Campo('VL_LIMITE', tfNul)]
    property Vl_Limite : String read fVl_Limite write fVl_Limite;
    [Campo('DS_CONTA', tfNul)]
    property Ds_Conta : String read fDs_Conta write fDs_Conta;
    [Campo('DS_TITULAR', tfNul)]
    property Ds_Titular : String read fDs_Titular write fDs_Titular;
    [Campo('TP_ARQELETRONICO', tfNul)]
    property Tp_Arqeletronico : String read fTp_Arqeletronico write fTp_Arqeletronico;
  end;

  TFcc_Ctapess = class(TList<Fcc_Ctapes>);

implementation

{ TFcc_Ctapes }

constructor TFcc_Ctapes.Create(AOwner: TComponent);
begin
  inherited;

end;

destructor TFcc_Ctapes.Destroy;
begin

  inherited;
end;

end.