unit uFccCtapes;

interface

uses
  Classes, SysUtils,
  mMapping;

type
  TFcc_Ctapes = class(TmMapping)
  private
    fNr_Ctapes: String;
    fU_Version: String;
    fIn_Natureza: String;
    fNr_Situacao: String;
    fCd_Empresa: String;
    fCd_Grupoempresa: String;
    fCd_Operador: String;
    fDt_Cadastro: String;
    fDs_Dgcta: String;
    fIn_Ativo: String;
    fTp_Conta: String;
    fTp_Manutencao: String;
    fCd_Moeda: String;
    fNr_Banco: String;
    fNr_Agencia: String;
    fPr_Taxajuros: String;
    fNr_Modfinc: String;
    fCd_Emppagto: String;
    fCd_Pessoa: String;
    fCd_Opercaixa: String;
    fDt_Limitevenc: String;
    fDt_Abertura: String;
    fVl_Limite: String;
    fDs_Conta: String;
    fDs_Titular: String;
    fTp_Arqeletronico: String;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function GetMapping() : PmMapping; override;
  published
    property Nr_Ctapes : String read fNr_Ctapes write fNr_Ctapes;
    property U_Version : String read fU_Version write fU_Version;
    property In_Natureza : String read fIn_Natureza write fIn_Natureza;
    property Nr_Situacao : String read fNr_Situacao write fNr_Situacao;
    property Cd_Empresa : String read fCd_Empresa write fCd_Empresa;
    property Cd_Grupoempresa : String read fCd_Grupoempresa write fCd_Grupoempresa;
    property Cd_Operador : String read fCd_Operador write fCd_Operador;
    property Dt_Cadastro : String read fDt_Cadastro write fDt_Cadastro;
    property Ds_Dgcta : String read fDs_Dgcta write fDs_Dgcta;
    property In_Ativo : String read fIn_Ativo write fIn_Ativo;
    property Tp_Conta : String read fTp_Conta write fTp_Conta;
    property Tp_Manutencao : String read fTp_Manutencao write fTp_Manutencao;
    property Cd_Moeda : String read fCd_Moeda write fCd_Moeda;
    property Nr_Banco : String read fNr_Banco write fNr_Banco;
    property Nr_Agencia : String read fNr_Agencia write fNr_Agencia;
    property Pr_Taxajuros : String read fPr_Taxajuros write fPr_Taxajuros;
    property Nr_Modfinc : String read fNr_Modfinc write fNr_Modfinc;
    property Cd_Emppagto : String read fCd_Emppagto write fCd_Emppagto;
    property Cd_Pessoa : String read fCd_Pessoa write fCd_Pessoa;
    property Cd_Opercaixa : String read fCd_Opercaixa write fCd_Opercaixa;
    property Dt_Limitevenc : String read fDt_Limitevenc write fDt_Limitevenc;
    property Dt_Abertura : String read fDt_Abertura write fDt_Abertura;
    property Vl_Limite : String read fVl_Limite write fVl_Limite;
    property Ds_Conta : String read fDs_Conta write fDs_Conta;
    property Ds_Titular : String read fDs_Titular write fDs_Titular;
    property Tp_Arqeletronico : String read fTp_Arqeletronico write fTp_Arqeletronico;
  end;

  TFcc_Ctapess = class(TList)
  public
    function Add: TFcc_Ctapes; overload;
  end;

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

//--

function TFcc_Ctapes.GetMapping: PmMapping;
begin
  Result := New(PmMapping);

  Result.Tabela := New(PmTabela);
  with Result.Tabela^ do begin
    Nome := 'FCC_CTAPES';
  end;

  Result.Campos := TmCampos.Create;
  with Result.Campos do begin
    Add('Nr_Ctapes', 'NR_CTAPES', tfKey);
    Add('U_Version', 'U_VERSION', tfNul);
    Add('In_Natureza', 'IN_NATUREZA', tfReq);
    Add('Nr_Situacao', 'NR_SITUACAO', tfNul);
    Add('Cd_Empresa', 'CD_EMPRESA', tfReq);
    Add('Cd_Grupoempresa', 'CD_GRUPOEMPRESA', tfReq);
    Add('Cd_Operador', 'CD_OPERADOR', tfReq);
    Add('Dt_Cadastro', 'DT_CADASTRO', tfReq);
    Add('Ds_Dgcta', 'DS_DGCTA', tfNul);
    Add('In_Ativo', 'IN_ATIVO', tfNul);
    Add('Tp_Conta', 'TP_CONTA', tfNul);
    Add('Tp_Manutencao', 'TP_MANUTENCAO', tfReq);
    Add('Cd_Moeda', 'CD_MOEDA', tfNul);
    Add('Nr_Banco', 'NR_BANCO', tfNul);
    Add('Nr_Agencia', 'NR_AGENCIA', tfNul);
    Add('Pr_Taxajuros', 'PR_TAXAJUROS', tfNul);
    Add('Nr_Modfinc', 'NR_MODFINC', tfNul);
    Add('Cd_Emppagto', 'CD_EMPPAGTO', tfNul);
    Add('Cd_Pessoa', 'CD_PESSOA', tfNul);
    Add('Cd_Opercaixa', 'CD_OPERCAIXA', tfNul);
    Add('Dt_Limitevenc', 'DT_LIMITEVENC', tfNul);
    Add('Dt_Abertura', 'DT_ABERTURA', tfNul);
    Add('Vl_Limite', 'VL_LIMITE', tfNul);
    Add('Ds_Conta', 'DS_CONTA', tfNul);
    Add('Ds_Titular', 'DS_TITULAR', tfNul);
    Add('Tp_Arqeletronico', 'TP_ARQELETRONICO', tfNul);
  end;

  Result.Relacoes := TmRelacoes.Create;
  with Result.Relacoes do begin
  end;
end;

//--

{ TFcc_Ctapess }

function TFcc_Ctapess.Add: TFcc_Ctapes;
begin
  Result := TFcc_Ctapes.Create(nil);
  Self.Add(Result);
end;

end.