unit fTRAFM080;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, fFormTouch, ExtCtrls, cPanel, cDatasetUnf;

type
  TF_TRAFM080 = class(T_FormTouch)
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
  private
    tADM_USUARIO,
    tADM_USUOPERCMP,
    tF_TEF_TRANSACAO,
    tF_TEF_TRANSACAOVALOR,
    tF_TRA_TRANSACAO,
    tGER_OPERACAO,
    tGER_TERMINAL,
    tPES_PESFISICA,
    tPES_PESSOA,
    tPES_VENDEDOR,
    tPRD_EMBALAGEM,
    tPRD_IMAGEM,
    tPRD_PRDIMAGEM,
    tR_TRA_TRANSACAO,
    tSIS_BOTOES,
    tSIS_BOTOES2,
    tSIS_FILTRO,
    tSIS_IMAGEM,
    tSIS_PRODUTO,
    tTEF_RELTRANSACAO,
    tTEF_TRANSACAO,
    tTEF_TRANSACAOVALOR,
    tTMP_NR09,
    tTMP_NR10,
    tTRA_LIMDESCONTO,
    tTRA_S_TRANSITEM,
    tTRA_TRANSACADIC,
    tTRA_TRANSACAO,
    tTRA_TRANSITEM,
    tV_FIS_NFITEMPROD : TcDatasetUnf;
    function getParam(pParams : String = '') : String;
    function setEntidade(pParams : String = '') : String;
    function preEDIT(pParams : String = '') : String;
    function posEDIT(pParams : String = '') : String;
    function posCLEAR(pParams : String = '') : String;
    function preEDIT(pParams : String = '') : String;
    function preQUIT(pParams : String = '') : String;
    function INIT(pParams : String = '') : String;
    function CLEANUP(pParams : String = '') : String;
    function BT_02(pParams : String = '') : String;
    function BT_03(pParams : String = '') : String;
    function BT_04(pParams : String = '') : String;
    function BT_05(pParams : String = '') : String;
    function BT_06(pParams : String = '') : String;
    function BT_07(pParams : String = '') : String;
    function BT_08(pParams : String = '') : String;
    function BT_09(pParams : String = '') : String;
    function BT_11(pParams : String = '') : String;
    function carregaListas(pParams : String = '') : String;
    function posicionaCursor(pParams : String = '') : String;
    function validaVendedor(pParams : String = '') : String;
    function validaItem(pParams : String = '') : String;
    function validaQuantidade(pParams : String = '') : String;
    function alteraItem(pParams : String = '') : String;
    function agrupaItem(pParams : String = '') : String;
    function relacionaTroca(pParams : String = '') : String;
    function recarregaTransacao(pParams : String = '') : String;
    function carregaDadosIniciais(pParams : String = '') : String;
    function BT_CTRL_A(pParams : String = '') : String;
    function BT_CTRL_D(pParams : String = '') : String;
    function BT_CTRL_G(pParams : String = '') : String;
    function BT_CTRL_S(pParams : String = '') : String;
    function entradaColetor(pParams : String = '') : String;
    function observacao(pParams : String = '') : String;
    function carregaFormaPagamento(pParams : String = '') : String;
    function BT_CTRL_T(pParams : String = '') : String;
    function listaDetalhe(pParams : String = '') : String;
    function buscaLimite(pParams : String = '') : String;
    function aplicaQtPecasDescontoVlMin(pParams : String = '') : String;
    function buscaDadosAdicTransacao(pParams : String = '') : String;
    function carregaBonusCartao(pParams : String = '') : String;
    function imprimirTransacao(pParams : String = '') : String;
    function BT_CTRL_F11(pParams : String = '') : String;
    function buscaAniversario(pParams : String = '') : String;
    function simulacao(pParams : String = '') : String;
    function efetivaTEFPendente(pParams : String = '') : String;
    function efetivaTEFPendenteGeral_NCN(pParams : String = '') : String;
    function efetivaTEFPendenteGeral_CNF(pParams : String = '') : String;
    function efetivaTEFPendenteGeral_CNC(pParams : String = '') : String;
    function efetivaTEFPendente_MSG(pParams : String = '') : String;
    function efetua_NCN(pParams : String = '') : String;
    function efetua_CNF(pParams : String = '') : String;
    function bonusDesconto(pParams : String = '') : String;
    function mostraTotal(pParams : String = '') : String;
    function validaItemCoeficiente(pParams : String = '') : String;
    function excluiSimulacao(pParams : String = '') : String;
    function portal(pParams : String = '') : String;
    function verificaTransacaoAberta(pParams : String = '') : String;
  protected
  public
  published
  end;

implementation

{$R *.dfm}

uses
  cADMSVCO001,
  cActivate, cStatus, cFuncao, cXml, dModulo;

var
  g %%,
  gCdCliente,
  gCdCompVend,
  gCdCondPgto,
  gCdEmpEcf,
  gCdModImpRecebTra,
  gCdModRichTextVD,
  gCdOperacaoTroca,
  gCdOperacaoValeTroca,
  gCdOperacaoVenda,
  gCdTabPreco,
  gCdUsuarioDesc,
  gCdVendedor,
  gDsCaixa,
  gDsConferente,
  gDsNSU,
  gDsTerminal,
  gDtTEF,
  gHrTEF,
  gInBloqDesItemProm,
  gInBloqExcluiItem,
  gInBloqQtde,
  gInConferente,
  gInCupomAberto,
  gInDadosAdicionaisAuto,
  gInFocoVendedor,
  gInHomologacaoAm,
  gInImagem,
  gInMantVendValeTroca,
  gInMostraTotal,
  gInSimuladorCondPgto,
  gInSimuladorProduto,
  gInUtilizaCTC,
  gInValidaPrdValeTroca,
  glimiteCredito,
  gNrCartao,
  gNrCupom,
  gNrDiaAtraso,
  gNrDiasCarenciaAtraso,
  gNrDiaVencto,
  gNrEcf,
  gNrNSU6DIG,
  gqtOperacao,
  gqtPecasDescontoVlMin,
  gTpAgrupamento,
  gTpBuscaVlValeTroca,
  gTpCancelaTraAndamento,
  gTpCoeficientePrdVd,
  gTpConsultaPrdPdv,
  gTpConsultaSaldoCredev,
  gTpImpressaoNFVenda,
  gTpImpressaoTraVenda,
  gTpImpRichTextVD,
  gTpImpTefPAYGO,
  gTpLiberacaoTraVd,
  gTpLimiteDesconto,
  gTpSimuladorFat,
  gTpTEF,
  gTpTransacaoPadrao,
  gTpTrocoMaximo,
  gTpUtilizaBoleta,
  gTpUtilizaEtiqRfidPdv,
  gTpValidacaoSaldoPed,
  gVlBonusUtil,
  gVlDescAcumulado,
  gVlLimite,
  gVlLiqTransacao,
  gVlTEF,
  gVlTransacaoAnt,
  gVlTroco,
  gvNrItem,
  gxCdNivel : String;

procedure TF_TRAFM080.FormCreate(Sender: TObject);
begin
  inherited; //
  setEntidade();
end;

procedure TF_TRAFM080.FormShow(Sender: TObject);
var voParams : String;
begin
  inherited; //

  getParam(vpiParams);

  voParams := preEDIT(vpiParams);
  if (xStatus < 0) then begin
    MensagemTouchErro(itemXml('message', voParams) + #13 + itemXml('adic', voParams));
    TimerSair.Enabled := True;
    return(-1); exit;
  end;

  //recalcula();

  return(0); exit;
end;

procedure TF_TRAFM080.FormActivate(Sender: TObject);
begin
  inherited; //
end;

procedure TF_TRAFM080.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  inherited; //
end;

//---------------------------------------------------------------
function TF_TRAFM080.getParam(pParams : String = '') : String;
//---------------------------------------------------------------
var
  piCdEmpresa : Real;
begin
  piCdEmpresa := itemXmlF('CD_EMPRESA', pParams);
  if (piCdEmpresa = 0) then begin
    piCdEmpresa := itemXmlF('CD_EMPRESA', PARAM_GLB);
  end;

  (* colocar o conteudo da operacao INIT aqui *)

  (*
  xParam := '';
  putitem(xParam, 'IN_USA_COND_PGTO_ESPECIAL');
  xParam := T_ADMSVCO001.GetParametro(xParam);
  gUsaCondPgtoEspecial := itemXmlB('IN_USA_COND_PGTO_ESPECIAL', xParam);
  
  xParamEmp := '';
  putitem(xParamEmp, 'VL_MINIMO_PARCELA');
  xParamEmp := T_ADMSVCO001.GetParamEmpresa(piCdEmpresa, xParamEmp);
  gVlMinimoParcela := itemXmlF('VL_MINIMO_PARCELA', xParamEmp);  
  *)
end;

//---------------------------------------------------------------
function TF_TRAFM080.setEntidade(pParams : String = '') : String;
//---------------------------------------------------------------
begin
  tADM_USUARIO := TcDatasetUnf.GetEntidade(Self, 'ADM_USUARIO');
  tADM_USUOPERCMP := TcDatasetUnf.GetEntidade(Self, 'ADM_USUOPERCMP');
  tF_TEF_TRANSACAO := TcDatasetUnf.GetEntidade(Self, 'F_TEF_TRANSACAO');
  tF_TEF_TRANSACAOVALOR := TcDatasetUnf.GetEntidade(Self, 'F_TEF_TRANSACAOVALOR');
  tF_TRA_TRANSACAO := TcDatasetUnf.GetEntidade(Self, 'F_TRA_TRANSACAO');
  tGER_OPERACAO := TcDatasetUnf.GetEntidade(Self, 'GER_OPERACAO');
  tGER_TERMINAL := TcDatasetUnf.GetEntidade(Self, 'GER_TERMINAL');
  tPES_PESFISICA := TcDatasetUnf.GetEntidade(Self, 'PES_PESFISICA');
  tPES_PESSOA := TcDatasetUnf.GetEntidade(Self, 'PES_PESSOA');
  tPES_VENDEDOR := TcDatasetUnf.GetEntidade(Self, 'PES_VENDEDOR');
  tPRD_EMBALAGEM := TcDatasetUnf.GetEntidade(Self, 'PRD_EMBALAGEM');
  tPRD_IMAGEM := TcDatasetUnf.GetEntidade(Self, 'PRD_IMAGEM');
  tPRD_PRDIMAGEM := TcDatasetUnf.GetEntidade(Self, 'PRD_PRDIMAGEM');
  tR_TRA_TRANSACAO := TcDatasetUnf.GetEntidade(Self, 'R_TRA_TRANSACAO');
  tSIS_BOTOES := TcDatasetUnf.GetEntidade(Self, 'SIS_BOTOES');
  tSIS_BOTOES2 := TcDatasetUnf.GetEntidade(Self, 'SIS_BOTOES2');
  tSIS_FILTRO := TcDatasetUnf.GetEntidade(Self, 'SIS_FILTRO');
  tSIS_IMAGEM := TcDatasetUnf.GetEntidade(Self, 'SIS_IMAGEM');
  tSIS_PRODUTO := TcDatasetUnf.GetEntidade(Self, 'SIS_PRODUTO');
  tTEF_RELTRANSACAO := TcDatasetUnf.GetEntidade(Self, 'TEF_RELTRANSACAO');
  tTEF_TRANSACAO := TcDatasetUnf.GetEntidade(Self, 'TEF_TRANSACAO');
  tTEF_TRANSACAOVALOR := TcDatasetUnf.GetEntidade(Self, 'TEF_TRANSACAOVALOR');
  tTMP_NR09 := TcDatasetUnf.GetEntidade(Self, 'TMP_NR09');
  tTMP_NR10 := TcDatasetUnf.GetEntidade(Self, 'TMP_NR10');
  tTRA_LIMDESCONTO := TcDatasetUnf.GetEntidade(Self, 'TRA_LIMDESCONTO');
  tTRA_S_TRANSITEM := TcDatasetUnf.GetEntidade(Self, 'TRA_S_TRANSITEM');
  tTRA_TRANSACADIC := TcDatasetUnf.GetEntidade(Self, 'TRA_TRANSACADIC');
  tTRA_TRANSACAO := TcDatasetUnf.GetEntidade(Self, 'TRA_TRANSACAO');
  tTRA_TRANSITEM := TcDatasetUnf.GetEntidade(Self, 'TRA_TRANSITEM');
  tV_FIS_NFITEMPROD := TcDatasetUnf.GetEntidade(Self, 'V_FIS_NFITEMPROD');
end;

//---------------------------------------------------------------
function TF_TRAFM080.preEDIT(pParams : String) : String;
//---------------------------------------------------------------
const
  cDS_METHOD = 'ADICIONAL=Operação: TF_TRAFM080.preEDIT()';
begin
  return(0); exit;
end;

//---------------------------------------------------------------
function TF_TRAFM080.posEDIT(pParams : String) : String;
//---------------------------------------------------------------
const
  cDS_METHOD = 'ADICIONAL=Operação: TF_TRAFM080.posEDIT()';
begin
  return(0); exit;
end;

//-------------------------------------------------------
function TF_TRAFM080.posCLEAR(pParams : String) : String;
//-------------------------------------------------------
const
  cDS_METHOD = 'ADICIONAL=Operação: TF_TRAFM080.posCLEAR()';
var
  viParams, voParams : String;
begin
  if (gTpCancelaTraAndamento = 1) then begin
    viParams := '';
    putitemXml(viParams, 'CD_OPERACAO', gCdOperacaoVenda);
    voParams := activateCmp('GERSVCO054', 'dadosAdicionaisOperacao', viParams); (*,,,, *)
    if (xStatus < 0) then begin
      Result := voParams;
      return(-1); exit;
    end;
    if (itemXml('TP_DOCTO', voParams) = 3) then begin
      voParams := verificaTransacaoAberta(viParams); (* *)
      if (xStatus < 0) then begin
        Result := voParams;
        return(-1); exit;
      end;
    end;
  end;

  voParams := carregaDadosIniciais(viParams); (* *)
  if (xStatus < 0) then begin
    Result := voParams;
    return(-1); exit;
  end;

  gInCupomAberto := 'N';

  return(0); exit;
end;

//------------------------------------------------------
function TF_TRAFM080.preEDIT(pParams : String) : String;
//------------------------------------------------------
const
  cDS_METHOD = 'ADICIONAL=Operação: TF_TRAFM080.preEDIT()';
var
  viParams, voParams : String;
begin
  if (gTpCancelaTraAndamento = 1) then begin
    viParams := '';
    putitemXml(viParams, 'CD_OPERACAO', gCdOperacaoVenda);
    voParams := activateCmp('GERSVCO054', 'dadosAdicionaisOperacao', viParams); (*,,,, *)
    if (xStatus < 0) then begin
      Result := voParams;
      return(-1); exit;
    end;
    if (itemXml('TP_DOCTO', voParams) = 3) then begin
      voParams := verificaTransacaoAberta(viParams); (* *)
      if (xStatus < 0) then begin
        Result := voParams;
        return(-1); exit;
      end;
    end;
  end;
  if (gTpValidacaoSaldoPed > 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN001', 'Este componente não pode ser utilizado pois o parametro empresa TP_VALIDACAO_SALDO_PED está cadastrado como ' + FloatToStr(gTpValidacaoSaldoPed) + '!', '');
    return(-1); exit;
  end;

  voParams := carregaDadosIniciais(viParams); (* *)

  voParams := carregaListas(viParams); (* *)

  if (xStatus < 0) then begin
    return(-1); exit;
  end;

  gInMostraTotal := True;

  if (gCdOperacaoVenda = 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Operação de venda não cadastrada!', cDS_METHOD);
    return(-1); exit;
  end;
  if (gCdOperacaoValeTroca = 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Operação de vale troca não cadastrada!', cDS_METHOD);
    return(-1); exit;
  end;
  if (gCdOperacaoTroca = 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Operação de vale troca não cadastrada!', cDS_METHOD);
    return(-1); exit;
  end;

  gInCupomAberto := 'N';

  voParams := efetivaTEFPendente(viParams); (* *)
  if (xStatus < 0) then begin
    Result := voParams;
    return(-1); exit;
  end;
  end;

  return(0); exit;
end;

//------------------------------------------------------
function TF_TRAFM080.preQUIT(pParams : String) : String;
//------------------------------------------------------
const
  cDS_METHOD = 'ADICIONAL=Operação: TF_TRAFM080.preQUIT()';
var
  viParams, voParams : String;
begin
  if (gInBloqExcluiItem = 1)  or (gInBloqExcluiItem = 3) then begin
    viParams := '';
    putitemXml(viParams, 'IN_USULOGADO', True);
    putitemXml(viParams, 'DS_COMPONENTE', 'TRAFM060EX');
    voParams := activateCmp('ADMFM020', 'exec', viParams); (*,,, *)
    if (xStatus < 0) then begin
      Result := SetStatus(STS_ERROR, 'GEN0001', 'Função bloqueada!', cDS_METHOD);
      return(-1); exit;
    end;
  end else begin
    if (empty(tTRA_TRANSACAO) = False) then begin
      askmess 'Deseja realmente sair?', 'Sair, Cancelar';
      if (xStatus = 2) then begin
        return(-1); exit;
      end;
    end;
  end;

  return(0); exit;
end;

//---------------------------------------------------
function TF_TRAFM080.INIT(pParams : String) : String;
//---------------------------------------------------
const
  cDS_METHOD = 'ADICIONAL=Operação: TF_TRAFM080.INIT()';
begin
  putitemXml(PARAM_GLB, 'DS_TECLADO', 'KB_PDV');
  //keyboard := 'KB_PDV';
  _Caption := '' + TRAFM + '080 - Lançamento de Transação Resumido';

  xParam := '';
  putitem(xParam,  'CONDPGTO_PDV');
  putitem(xParam,  'CLIENTE_PDV');
  putitem(xParam,  'VendEDOR_PDV');
  xParam := T_ADMSVCO001.GetParametro(xParam); (*xParam,xParam,, *)

  gCdCondPgto := itemXml('CONDPGTO_PDV', xParam);
  gCdCliente := itemXml('CLIENTE_PDV', xParam);
  gCdVendedor := itemXml('VendEDOR_PDV', xParam);

  xParamEmp := '';
  putitem(xParamEmp,  'CD_OPER_ECF');
  putitem(xParamEmp,  'CD_OPER_VALETROCA');
  putitem(xParamEmp,  'CD_OPER_TROCA');
  putitem(xParamEmp,  'IN_DADOS_ADIC_TRA_AUTO');
  putitem(xParamEmp,  'TP_IMPRESSAO_TRA_VD');
  putitem(xParamEmp,  'TP_IMPRESSAO_NF_VD');
  putitem(xParamEmp,  'TP_AGRUPAMENTO_ITEM_VD');
  putitem(xParamEmp,  'IN_CONFERENTE');
  putitem(xParamEmp,  'IN_PDV_OTIMIZADO');
  putitem(xParamEmp,  'IN_BLOQ_QTD');
  putitem(xParamEmp,  'LIMITE_CREDITO');
  putitem(xParamEmp,  'IN_BLOQ_EXCLUIR_ITEM');
  putitem(xParamEmp,  'TP_VALIDACAO_SALDO_PED');
  putitem(xParamEmp,  'TP_CONSULTA_PRD_PDV');
  putitem(xParamEmp,  'IN_MANTEM_Vend_VALETROCA');
  putitem(xParamEmp,  'TP_SIMULADOR_FAT');
  putitem(xParamEmp,  'IN_SIMULADOR_FAT_PRODUTO');
  putitem(xParamEmp,  'IN_BLOQ_DESC_ITEM_PROM');
  putitem(xParamEmp,  'IN_IMAGEM_PDV');
  putitem(xParamEmp,  'NR_DIA_ATRASO_BLOQ_FAT');
  putitem(xParamEmp,  'IN_HOMOLOGACAO_AM');
  putitem(xParamEmp,  'TP_LIBERACAO_TRA_VD');
  putitem(xParamEmp,  'QT_PECAS_DESCONTO_VL_MIN');
  putitem(xParamEmp,  'IN_VALIDA_PRD_VALETROCA');
  putitem(xParamEmp,  'IN_UTILIZA_CTC');
  putitem(xParamEmp,  'TP_AVISA_ANIVERSARIO');
  putitem(xParamEmp,  'IN_LIMITE_CREDITO_ITEM_VD');
  putitem(xParamEmp,  'TP_LIMITE_DESCONTO');
  putitem(xParamEmp,  'CD_OPER_TROCA_VALOR_VD');
  putitem(xParamEmp,  'VL_TROCA_TPVALOR_VD');
  putitem(xParamEmp,  'TP_VALIDACAO_CONF_TRA');
  putitem(xParamEmp,  'TP_VALIDA_VENEDOR_VD');
  putitem(xParamEmp,  'TP_VARIACAO_DESCONTO_VD');
  putitem(xParamEmp,  'TP_BONUS_DESCONTO');
  putitem(xParamEmp,  'IN_LIMITE_FAMILIAR_VD');
  putitem(xParamEmp,  'NR_DIAS_CARENCIA_ATRASO');
  putitem(xParamEmp,  'IN_SIMULADOR_COND_PGTO');
  putitem(xParamEmp,  'TP_COEFICIENTE_PRD_VD');
  putitem(xParamEmp,  'CD_MOD_RICHTEXT_VD');
  putitem(xParamEmp,  'TP_IMP_RICHTEXT_VD');
  putitem(xParamEmp,  'TP_BUSCA_VL_VALETROCA');
  putitem(xParamEmp,  'IN_RESIMULACAO_FAT');
  putitem(xParamEmp,  'IN_MOSTRA_TROCO_RECEB');
  putitem(xParamEmp,  'TP_UTILIZA_ETIQ_RFID_PDV');
  putitem(xParamEmp,  'TEF_TIPO');
  putitem(xParamEmp,  'TP_CONSULTA_SALDO_CREDEV');
  putitem(xParamEmp,  'CD_MOD_IMP_RECEBTRA');
  putitem(xParamEmp,  'TP_CANCELA_TRA_ANDAMENTO');
  putitem(xParamEmp,  'TP_UTILIZA_BOLETA');
  putitem(xParamEmp,  'TP_IMPRESSAO_TEF_PAYGO');
  xParamEmp := T_ADMSVCO001.GetParamEmpresa(piCdEmpresa, xParamEmp); (*itemXml('CD_EMPRESA', *)

  gCdOperacaoVenda := itemXmlF('CD_OPER_ECF', xParamEmp);
  gCdOperacaoValeTroca := itemXmlF('CD_OPER_VALETROCA', xParamEmp);
  gCdOperacaoTroca := itemXmlF('CD_OPER_TROCA', xParamEmp);
  glimiteCredito := itemXml('LIMITE_CREDITO', xParamEmp);
  gInDadosAdicionaisAuto := itemXmlB('IN_DADOS_ADIC_TRA_AUTO', xParamEmp);
  gTpImpressaoTraVenda := itemXmlF('TP_IMPRESSAO_TRA_VD', xParamEmp);
  gTpImpressaoNFVenda := itemXmlF('TP_IMPRESSAO_NF_VD', xParamEmp);
  gTpAgrupamento := itemXmlF('TP_AGRUPAMENTO_ITEM_VD', xParamEmp);
  gInConferente := itemXmlB('IN_CONFERENTE', xParamEmp);
  gInBloqQtde := itemXmlB('IN_BLOQ_QTD', xParamEmp);
  gInBloqExcluiItem := itemXmlB('IN_BLOQ_EXCLUIR_ITEM', xParamEmp);
  gTpValidacaoSaldoPed := itemXmlF('TP_VALIDACAO_SALDO_PED', xParamEmp);
  gTpConsultaPrdPdv := itemXmlF('TP_CONSULTA_PRD_PDV', xParamEmp);
  gInMantVendValeTroca := itemXmlB('IN_MANTEM_Vend_VALETROCA', xParamEmp);
  gTpSimuladorFat := itemXmlF('TP_SIMULADOR_FAT', xParamEmp);
  gInSimuladorProduto := itemXmlB('IN_SIMULADOR_FAT_PRODUTO', xParamEmp);
  gInBloqDesItemProm := itemXmlB('IN_BLOQ_DESC_ITEM_PROM', xParamEmp);
  gInImagem := itemXmlB('IN_IMAGEM_PDV', xParamEmp);
  gNrDiaVencto := itemXmlF('NR_DIA_ATRASO_BLOQ_FAT', xParamEmp);
  gInHomologacaoAm := itemXmlB('IN_HOMOLOGACAO_AM', xParamEmp);
  gTpLiberacaoTraVd := itemXmlF('TP_LIBERACAO_TRA_VD', xParamEmp);
  gInValidaPrdValeTroca := itemXmlB('IN_VALIDA_PRD_VALETROCA', xParamEmp);
  gqtPecasDescontoVlMin := itemXmlF('QT_PECAS_DESCONTO_VL_MIN', xParamEmp);
  if (gqtPecasDescontoVlMin = 1) then begin
    message/info 'Valor do parâmetro empresa QT_PECAS_DESCONTO_VL_MIN deve ser maior que 1!';
    return(0); exit;
  end;
  gInUtilizaCTC := itemXmlB('IN_UTILIZA_CTC', xParamEmp);
  gTpLimiteDesconto := itemXmlF('TP_LIMITE_DESCONTO', xParamEmp);
  gNrDiasCarenciaAtraso := itemXmlF('NR_DIAS_CARENCIA_ATRASO', xParamEmp);
  gInSimuladorCondPgto := itemXmlB('IN_SIMULADOR_COND_PGTO', xParamEmp);
  gTpCoeficientePrdVd := itemXmlF('TP_COEFICIENTE_PRD_VD', xParamEmp);
  gCdModRichTextVD := itemXmlF('CD_MOD_RICHTEXT_VD', xParamEmp);
  gTpImpRichTextVD := itemXmlF('TP_IMP_RICHTEXT_VD', xParamEmp);
  gTpBuscaVlValeTroca := itemXmlF('TP_BUSCA_VL_VALETROCA', xParamEmp);
  gTpUtilizaEtiqRfidPdv := itemXmlF('TP_UTILIZA_ETIQ_RFID_PDV', xParamEmp);
  gTpTEF := itemXml('TEF_TIPO', xParamEmp);
  gTpConsultaSaldoCredev := itemXmlF('TP_CONSULTA_SALDO_CREDEV', xParamEmp);
  gCdModImpRecebTra := itemXmlF('CD_MOD_IMP_RECEBTRA', xParamEmp);
  gTpCancelaTraAndamento := itemXmlF('TP_CANCELA_TRA_ANDAMENTO', xParamEmp);
  gTpUtilizaBoleta := itemXmlF('TP_UTILIZA_BOLETA', xParamEmp);
  gTpImpTefPAYGO := itemXmlF('TP_IMPRESSAO_TEF_PAYGO', xParamEmp);

  return(0); exit;
end;

//------------------------------------------------------
function TF_TRAFM080.CLEANUP(pParams : String) : String;
//------------------------------------------------------
const
  cDS_METHOD = 'ADICIONAL=Operação: TF_TRAFM080.CLEANUP()';
begin
  putitemXml(PARAM_GLB, 'DS_TECLADO', '');
  //keyboard := 'KB_GLOBAL';
  return(0); exit;
end;

//----------------------------------------------------
function TF_TRAFM080.BT_02(pParams : String) : String;
//----------------------------------------------------
const
  cDS_METHOD = 'ADICIONAL=Operação: TF_TRAFM080.BT_02()';
var
  viParams, voParams : String;
begin
  if (gInBloqExcluiItem = 1)  or (gInBloqExcluiItem = 2)  or (gInBloqExcluiItem = 3) then begin
    viParams := '';
    putitemXml(viParams, 'IN_USULOGADO', True);
    putitemXml(viParams, 'DS_COMPONENTE', 'TRAFM060EX');
    voParams := activateCmp('ADMFM020', 'exec', viParams); (*,,, *)
    if (xStatus < 0) then begin
      Result := SetStatus(STS_ERROR, 'GEN0001', 'Função bloqueada!', cDS_METHOD);
      return(-1); exit;
    end;
  end;

  macro '^CLEAR';

  gprompt := item_f('CD_AUXILIAR', tPES_VENDEDOR);

  return(0); exit;
end;

//----------------------------------------------------
function TF_TRAFM080.BT_03(pParams : String) : String;
//----------------------------------------------------
const
  cDS_METHOD = 'ADICIONAL=Operação: TF_TRAFM080.BT_03()';
var
  viParams, voParams : String;
begin
  if (gInBloqQtde = True) then begin
    viParams := '';
    putitemXml(viParams, 'CD_COMPONENTE', TRAFM080);
    putitemXml(viParams, 'DS_CAMPO', 'IN_LANCAR_QTDE');
    putitemXml(viParams, 'CD_EMPRESA', itemXmlF('CD_EMPRESA', PARAM_GLB));
    putitemXml(viParams, 'CD_USUARIO', itemXmlF('CD_USUARIO', PARAM_GLB));
    putitemXml(viParams, 'VL_VALOR', '');
    voParams := activateCmp('ADMSVCO009', 'VerificaRestricao', viParams); (*,,, *)
    if (xStatus < 0) then begin
      Result := voParams;
      return(-1); exit;
    end;
  end;
  if (item_f('TP_INCLUSAO', tTRA_TRANSACAO) = 'QUANTIDADE') then begin
    putitem_e(tTRA_TRANSACAO, 'TP_INCLUSAO', 'CODIGO');
    putitem_e(tSIS_BOTOES, 'BT_F3', 'F3 Entrada por quantidade');
  end else begin
    putitem_e(tTRA_TRANSACAO, 'TP_INCLUSAO', 'QUANTIDADE');
    putitem_e(tSIS_BOTOES, 'BT_F3', 'F3 Entrada por código');
  end;

  voParams := posicionaCursor(viParams); (* *)
  if (xStatus < 0) then begin
    Result := voParams;
    return(-1); exit;
  end;

  return(0); exit;
end;

//----------------------------------------------------
function TF_TRAFM080.BT_04(pParams : String) : String;
//----------------------------------------------------
const
  cDS_METHOD = 'ADICIONAL=Operação: TF_TRAFM080.BT_04()';
var
  viParams, voParams : String;
  vNrTransacao, vCdPessoa : Real;
  vDtTransacao : TDate;
begin
  if (!dbocc(t'TRA_TRANSACAO')) then begin
    voParams := validaVendedor(viParams); (* *)
    if (xStatus < 0) then begin
      return(-1); exit;
    end;
  end;

  viParams := '';
  putlistitensocc_e(viParams, tTRA_TRANSACAO);
  voParams := activateCmp('TRASVCO004', 'gravaCapaTransacao', viParams); (*,,,, *)

  commit;
  if (xStatus < 0) then begin
    rollback;
    return(-1); exit;
  end else begin
    voParams := SetHint(viParams); (* 'ID=APLINFO002' *)
  end;
  if (item_f('NR_TRANSACAO', tTRA_TRANSACAO) = 0) then begin
    vNrTransacao := itemXmlF('NR_TRANSACAO', voParams);
    putitem_e(tTRA_TRANSACAO, 'NR_TRANSACAO', vNrTransacao);

    vDtTransacao := itemXml('DT_TRANSACAO', voParams);
    putitem_e(tTRA_TRANSACAO, 'DT_TRANSACAO', vDtTransacao);
  end;

  viParams := '';
  putitemXml(viParams, 'CD_EMPRESA', item_f('CD_EMPRESA', tTRA_TRANSACAO));
  putitemXml(viParams, 'NR_TRANSACAO', item_f('NR_TRANSACAO', tTRA_TRANSACAO));
  putitemXml(viParams, 'DT_TRANSACAO', item_a('DT_TRANSACAO', tTRA_TRANSACAO));
  putitemXml(viParams, 'NR_CARTAO', gNrCartao);
  //keyboard := 'KB_GLOBAL';
  voParams := activateCmp('TRAFM081', 'EXEC', viParams); (*,,, *)
  //keyboard := 'KB_PDV';

  gNrCartao := itemXmlF('NR_CARTAO', voParams);

  commit;
  if (xStatus < 0) then begin
    rollback;
    return(-1); exit;
  end else begin
    voParams := SetHint(viParams); (* 'ID=APLINFO002' *)
  end;
  if (gInconferente = 1 ) and (itemXmlF('CD_CONFERENTE', voParams) <> '') then begin
    gDsConferente := itemXml('DS_CONFERENTE', voParams);
    putitemXml(PARAM_GLB, 'CD_USUCONF', itemXmlF('CD_CONFERENTE', voParams));
  end else begin
    clear_e(tADM_USUARIO);
    putitem_e(tADM_USUARIO, 'CD_USUARIO', itemXmlF('CD_USUARIO', PARAM_GLB));
    retrieve_e(tADM_USUARIO);

    if (xStatus >= 0) then begin
      if (item_f('CD_USUARIO', tADM_USUARIO) > 0) then begin
        viParams := '';

        putitemXml(viParams, 'CD_USUARIO', item_f('CD_USUARIO', tADM_USUARIO));
        voParams := activateCmp('ADMSVCO027', 'validaUsuarioEspecial', viParams); (*,,,, *)
        if (xStatus < 0) then begin
          Result := voParams;
          return(-1); exit;
        end;
        if (voParams <> '') then begin
          gDsConferente := itemXml('NM_LOGIN', voParams);
        end;
      end else begin
        gDsConferente := '';
      end;
    end;
  end;

  voParams := recarregaTransacao(viParams); (* *)
  if (xStatus < 0) then begin
    Result := voParams;
    return(-1); exit;
  end;

  gprompt := item_f('TP_TRANSACAO', tTRA_TRANSACAO);

  return(0); exit;
end;

//----------------------------------------------------
function TF_TRAFM080.BT_05(pParams : String) : String;
//----------------------------------------------------
const
  cDS_METHOD = 'ADICIONAL=Operação: TF_TRAFM080.BT_05()';
var
  viParams, voParams, vDsRegTroca, vDsSerie : String;
  vNrTransacao : Real;
  vVlTotalDesc, vPrTotalDesc, vVlTotalLiquido, vVlCalc : Real;
  vVlBrutoTransacao, vVlLiquidoTransacao : Real;
  vDtSistema : TDate;
begin
  if (item_f('TP_INCLUSAO', tTRA_TRANSACAO) = 'QUANTIDADE') then begin
    if (gInBloqQtde = True) then begin
      viParams := '';
      putitemXml(viParams, 'CD_COMPONENTE', TRAFM080);
      putitemXml(viParams, 'DS_CAMPO', 'IN_LANCAR_QTDE');
      putitemXml(viParams, 'CD_EMPRESA', itemXmlF('CD_EMPRESA', PARAM_GLB));
      putitemXml(viParams, 'CD_USUARIO', itemXmlF('CD_USUARIO', PARAM_GLB));
      putitemXml(viParams, 'VL_VALOR', '');
      voParams := activateCmp('ADMSVCO009', 'VerificaRestricao', viParams); (*,,, *)
      if (xStatus < 0) then begin
        Result := voParams;
        return(-1); exit;
      end;
    end;
  end;

  vDtSistema := itemXml('DT_SISTEMA', PARAM_GLB);

  if (item_f('TP_FOCO', tTRA_TRANSACAO) = 'C')  or (item_f('TP_FOCO', tTRA_TRANSACAO) = 'I') then begin
    if (!dbocc(t'TRA_TRANSACAO'))  and (item_a('DT_TRANSACAO', tTRA_TRANSACAO) <> vDtSistema) then begin
      Result := SetStatus(STS_ERROR, 'GEN0001', 'Data da transação diferente da data do sistema!', '');
      gprompt := item_a('DT_TRANSACAO', tTRA_TRANSACAO);
      return(-1); exit;
    end;

    viParams := '';
    putlistitensocc_e(viParams, tTRA_TRANSACAO);
    if (gNrDiaVencto > 0) then begin
      putitemXml(viParams, 'IN_VALIDA_CLIENTE_ATRASO', True);
    end;
    voParams := activateCmp('TRASVCO004', 'gravaCapaTransacao', viParams); (*,,,, *)
    if (xStatus < 0) then begin
      Result := voParams;
      return(-1); exit;
    end;
          if (xStatus < 0) then begin
            Result := voParams;
            return(-1); exit;
          end;
        end else begin
          return(-1); exit;
        end;
      end else begin
        Result := SetStatus(STS_ERROR, {xCdErro} '', '{xCtxErro} ''', '');
        return(-1); exit;
      end;
    end;

    commit;
    if (xStatus < 0) then begin
      rollback;
      return(-1); exit;
    end else begin
      voParams := SetHint(viParams); (* 'ID=APLINFO002' *)
    end;
    if (item_f('NR_TRANSACAO', tTRA_TRANSACAO) = 0) then begin
      vNrTransacao := itemXmlF('NR_TRANSACAO', voParams);
      putitem_e(tTRA_TRANSACAO, 'NR_TRANSACAO', vNrTransacao);
    end;
    if (item_f('TP_FOCO', tTRA_TRANSACAO) = 'C')  and (gInDadosAdicionaisAuto = True) then begin
      voParams := BT_04(viParams); (* *)
      if (xStatus < 0) then begin
        Result := voParams;
        return(-1); exit;
      end;
    end;

    putitem_e(tTRA_TRANSACAO, 'TP_FOCO', 'B');
    putitem_e(tSIS_BOTOES, 'BT_F5', 'F5 Navegar item');
  end else if (item_f('TP_FOCO', tTRA_TRANSACAO) = 'B') then begin
    putitem_e(tTRA_TRANSACAO, 'TP_FOCO', 'I');
    putitem_e(tSIS_BOTOES, 'BT_F5', 'F5 Lançar item');
  end;

  voParams := recarregaTransacao(viParams); (* *)
  if (xStatus < 0) then begin
    Result := voParams;
    return(-1); exit;
  end;

  gprompt := item_f('TP_TRANSACAO', tTRA_TRANSACAO);

  return(0); exit;
end;

//----------------------------------------------------
function TF_TRAFM080.BT_06(pParams : String) : String;
//----------------------------------------------------
const
  cDS_METHOD = 'ADICIONAL=Operação: TF_TRAFM080.BT_06()';
var
  viParams, voParams : String;
  vVlTotalDesc, vPrTotalDesc, vVlTotalLiquido, vVlCalc : Real;
  vVlDesconto, vVlResto, vVlMaior, vNrOcc, vCdUsuario : Real;
  vVlBrutoTransacao, vVlLiquidoTransacao : Real;
begin
  if (item_f('VL_TOTALDESCCAB', tTRA_TRANSITEM) <> 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Não é possível aplicar desconto item após já ter sido aplicado desconto total!', '');
    return(-1); exit;
  end;
  if ((gInBloqDesItemProm = True)  and (item_f('CD_PROMOCAO', tTRA_TRANSITEM) > 0)) then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Não é possível aplicar desconto para item em promoção! IN_BLOQ_DESC_ITEM_PROM', '');
    return(-1); exit;
  end;

  gCdUsuarioDesc := '';
  vCdUsuario := itemXmlF('CD_USUARIO', PARAM_GLB);

  putitemXml(viParams, 'CD_EMPTRA', item_f('CD_EMPRESA', tTRA_TRANSACAO));
  putitemXml(viParams, 'DT_TRANSACAO', item_a('DT_TRANSACAO', tTRA_TRANSACAO));
  putitemXml(viParams, 'NR_TRANSACAO', item_f('NR_TRANSACAO', tTRA_TRANSACAO));
  putitemXml(viParams, 'VL_TOTALBRUTO', item_f('VL_TOTALBRUTO', tTRA_TRANSITEM));
  putitemXml(viParams, 'VL_BASEDESC', item_f('VL_TOTALBRUTO', tTRA_TRANSITEM));
  putitemXml(viParams, 'VL_DESCONTO', item_f('VL_TOTALDESC', tTRA_TRANSITEM));
  putitemXml(viParams, 'IN_ARREDONDAPRECO', False);
  putitemXml(viParams, 'IN_ALTERAVLLIQUIDO', True);
  putitemXml(viParams, 'CD_OPERACAO', item_f('CD_OPERACAO', tTRA_TRANSACAO));
  putitemXml(viParams, 'CD_PESSOA', item_f('CD_PESSOA', tTRA_TRANSACAO));
  //keyboard := 'KB_GLOBAL';
  voParams := activateCmp('TRAFM062', 'EXEC', viParams); (*,,, *)
  //keyboard := 'KB_PDV';

  if (xStatus < 0) then begin
    return(-1); exit;
  end;

  vVlTotalDesc := itemXmlF('VL_TOTALDESC', voParams);
  vPrTotalDesc := itemXmlF('PR_TOTALDESC', voParams);
  vVlTotalLiquido := itemXmlF('VL_TOTALLIQUIDO', voParams);

  if (item_f('VL_TOTALDESC', tTRA_TRANSITEM) = vVlTotalDesc) then begin
    return(0); exit;
  end;
  if (item_f('TP_DOCTO', tGER_OPERACAO) = 3) then begin
    if (item_f('VL_TOTALDESC', tTRA_TRANSITEM) > 0) then begin
      Result := SetStatus(STS_ERROR, 'GEN0001', 'Não é permitido alterar desconto para ECF concomitante!', '');
      return(-1); exit;
    end;
  end;

  putitem_e(tTRA_TRANSITEM, 'VL_TOTALDESC', vVlTotalDesc);
  putitem_e(tTRA_TRANSITEM, 'VL_TOTALLIQUIDO', item_f('VL_TOTALBRUTO', tTRA_TRANSITEM) - (item_f('VL_TOTALDESC', tTRA_TRANSITEM) + item_f('VL_TOTALDESCCAB', tTRA_TRANSITEM)));
  vVlCalc := item_f('VL_TOTALDESC', tTRA_TRANSITEM) / item_f('QT_SOLICITADA', tTRA_TRANSITEM);
  putitem_e(tTRA_TRANSITEM, 'VL_UNITDESC', rounded(vVLCalc, 6));
  vVlCalc := item_f('VL_TOTALLIQUIDO', tTRA_TRANSITEM) / item_f('QT_SOLICITADA', tTRA_TRANSITEM);
  putitem_e(tTRA_TRANSITEM, 'VL_UNITLIQUIDO', rounded(vVLCalc, 6));

  viParams := '';
  putlistitensocc_e(viParams, tTRA_TRANSITEM);
  voParams := activateCmp('TRASVCO004', 'gravaItemTransacao', viParams); (*,,,, *)
  if (xStatus < 0) then begin
    Result := voParams;
    return(-1); exit;
  end;
  if (itemXml('DS_MENSAGEM', voParams) <> '') then begin
    message/info '' + itemXml('DS_MENSAGEM', + ' voParams)';
  end;
  if (item_f('TP_DOCTO', tGER_OPERACAO) = 3) then begin
    if (gInCupomAberto = 'S') then begin
      if (item_f('VL_TOTALDESC', tTRA_TRANSITEM) > 0) then begin
        putitemXml(viParams, 'NR_ITEM', item_f('NR_ITEM', tTRA_TRANSITEM));
        putitemXml(viParams, 'VL_DESCONTO', item_f('VL_TOTALDESC', tTRA_TRANSITEM));
        putitemXml(viParams, 'DS_ACRESDESC', 'D');
        voParams := activateCmp('ECFSVCO001', 'acrescimoDescontoItem', viParams); (*,,, *)
        if (xStatus < 0) then begin
          Result := voParams;
          return(-1); exit;
        end;
          putitemXml(viParams, 'TITULO', 'Erro de comunicação com a ECF');
          putitemXml(viParams, 'MENSAGEM', itemXml('DESCRICAO', xCtxErro));
          voParams := activateCmp('GERFP008', 'EXEC', viParams); (*,,, *)
          if (xStatus < 0) then begin
            Result := voParams;
            return(-1); exit;
          end;
          return(-1); exit;
        end else if (xStatus < 0) then begin
          Result := SetStatus(STS_ERROR, {xCdErro} '', '{xCtxErro} ''', '');
          rollback;
          return(-1); exit;
        end;
      end;
    end;
  end;

  commit;
  if (xStatus < 0) then begin
    rollback;
    return(-1); exit;
  end else begin
    voParams := SetHint(viParams); (* 'ID=APLINFO002' *)
  end;

  voParams := recarregaTransacao(viParams); (* *)
  if (xStatus < 0) then begin
    Result := voParams;
    return(-1); exit;
  end;

  gprompt := item_f('TP_TRANSACAO', tTRA_TRANSACAO);

  return(0); exit;
end;

//----------------------------------------------------
function TF_TRAFM080.BT_07(pParams : String) : String;
//----------------------------------------------------
const
  cDS_METHOD = 'ADICIONAL=Operação: TF_TRAFM080.BT_07()';
var
  viParams, voParams, vDsRegTroca, vDsLstTransacao, vDsRegistro, vDsLinha : String;
  vNrTransacao, vCdUsuario, vPrDescMaximo : Real;
  vVlDesconto, vVlTotalDesc, vPrTotalDesc, vVlResto, vVlCalc, vVlMaior, vNrOcc : Real;
  vVlBrutoTransacao, vVlLiquidoTransacao, vVlLiquido, vCdUsuAntLib : Real;
begin
  if (gInSimuladorProduto = True) then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Não é possível aplicar desconto total o parâmetro por empresa IN_SIMULADOR_FAT_PRODUTO está configurado!', '');
    return(-1); exit;
  end;
  if (gInSimuladorCondPgto = True) then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Não é possível aplicar desconto total o parâmetro por empresa IN_SIMULADOR_COND_PGTO está configurado!', '');
    return(-1); exit;
  end;
  if (gTpSimuladorFat > 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Não é possível aplicar desconto total o parâmetro por empresa TP_SIMULADOR_FAT está configurado!', '');
    return(-1); exit;
  end;

  gCdUsuarioDesc := '';
  vCdUsuario := itemXmlF('CD_USUARIO', PARAM_GLB);

  vVlLiquido := 0;
  vVlDesconto := 0;
  if (empty(tTRA_TRANSITEM) = False) then begin
    setocc(tTRA_TRANSITEM, 1);
    while (xStatus >= 0) do begin

      if ((gInBloqDesItemProm = True)  and (item_f('CD_PROMOCAO', tTRA_TRANSITEM) > 0)) then begin
      end else begin
        vVlLiquido := vVlLiquido +  item_f('VL_TOTALLIQUIDO', tTRA_TRANSITEM);
        vVlDesconto := vVlDesconto + item_f('VL_TOTALDESCCAB', tTRA_TRANSITEM);
      end;
      setocc(tTRA_TRANSITEM, curocc(tTRA_TRANSITEM) + 1);
    end;
  end;

  viParams := '';
  putitemXml(viParams, 'CD_EMPTRA', item_f('CD_EMPRESA', tTRA_TRANSACAO));
  putitemXml(viParams, 'DT_TRANSACAO', item_a('DT_TRANSACAO', tTRA_TRANSACAO));
  putitemXml(viParams, 'NR_TRANSACAO', item_f('NR_TRANSACAO', tTRA_TRANSACAO));
  putitemXml(viParams, 'VL_TOTALBRUTO', item_f('VL_TRANSACAO', tTRA_TRANSACAO));

  vVlCalc := vVlLiquido + vVlDesconto;
  putitemXml(viParams, 'VL_BASEDESC', vVlCalc);
  putitemXml(viParams, 'VL_DESCONTO', vVlDesconto);
  putitemXml(viParams, 'IN_ARREDONDA_PRECO', False);
  putitemXml(viParams, 'CD_OPERACAO', item_f('CD_OPERACAO', tTRA_TRANSACAO));
  putitemXml(viParams, 'CD_PESSOA', item_f('CD_PESSOA', tTRA_TRANSACAO));
  voParams := activateCmp('TRAFM062', 'EXEC', viParams); (*,,, *)

  if (xStatus < 0) then begin
    return(-1); exit;
  end;

  vVlTotalDesc := itemXmlF('VL_TOTALDESC', voParams);
  vPrTotalDesc := itemXmlF('PR_TOTALDESC', voParams);
  gCdUsuarioDesc := itemXmlF('CD_USUARIODESC', voParams);
  vPrDescMaximo := itemXmlF('PR_DESCMAXIMO', voParams);

  if (gCdUsuarioDesc > 0)  and (gCdUsuarioDesc <> vCdUsuario) then begin
    clear_e(tTRA_LIMDESCONTO);
    putitem_e(tTRA_LIMDESCONTO, 'CD_OPERACAO', item_f('CD_OPERACAO', tTRA_TRANSACAO));
    putitem_e(tTRA_LIMDESCONTO, 'CD_USUARIO', gCdUsuarioDesc);
    retrieve_e(tTRA_LIMDESCONTO);
    if (xStatus < 0) then begin
      clear_e(tTRA_LIMDESCONTO);
    end;
  end;

  vVlResto := vVlTotalDesc;

  if (empty(tTRA_TRANSITEM) = False) then begin
    voParams := agrupaItem(viParams); (* False *)
    if (xStatus < 0) then begin
      Result := voParams;
      return(-1); exit;
    end;

    vVlMaior := 0;
    setocc(tTRA_TRANSITEM, 1);
    while (xStatus >= 0) do begin

      if ((gInBloqDesItemProm = True)  and (item_f('CD_PROMOCAO', tTRA_TRANSITEM) > 0)) then begin
      end else begin

        vVlCalc := item_f('VL_TOTALLIQUIDO', tTRA_TRANSITEM) + item_f('VL_TOTALDESCCAB', tTRA_TRANSITEM);
        vVlCalc := vVlCalc * vPrTotalDesc / 100;
        putitem_e(tTRA_TRANSITEM, 'VL_TOTALDESCCAB', rounded(vVlCalc, 2));
        putitem_e(tTRA_TRANSITEM, 'VL_TOTALLIQUIDO', item_f('VL_TOTALBRUTO', tTRA_TRANSITEM) - (item_f('VL_TOTALDESC', tTRA_TRANSITEM) + item_f('VL_TOTALDESCCAB', tTRA_TRANSITEM)));
        vVlCalc := item_f('VL_TOTALDESCCAB', tTRA_TRANSITEM) / item_f('QT_SOLICITADA', tTRA_TRANSITEM);
        putitem_e(tTRA_TRANSITEM, 'VL_UNITDESCCAB', rounded(vVLCalc, 6));
        vVlCalc := item_f('VL_TOTALLIQUIDO', tTRA_TRANSITEM) / item_f('QT_SOLICITADA', tTRA_TRANSITEM);
        putitem_e(tTRA_TRANSITEM, 'VL_UNITLIQUIDO', rounded(vVLCalc, 6));

        if (item_f('VL_TOTALDESCCAB', tTRA_TRANSITEM) > vVlResto) then begin
          putitem_e(tTRA_TRANSITEM, 'VL_TOTALDESCCAB', vVlResto);
            putitem_e(tTRA_TRANSITEM, 'VL_TOTALLIQUIDO', item_f('VL_TOTALBRUTO', tTRA_TRANSITEM) - (item_f('VL_TOTALDESC', tTRA_TRANSITEM) + item_f('VL_TOTALDESCCAB', tTRA_TRANSITEM)));
          vVlCalc := item_f('VL_TOTALDESCCAB', tTRA_TRANSITEM) / item_f('QT_SOLICITADA', tTRA_TRANSITEM);
          putitem_e(tTRA_TRANSITEM, 'VL_UNITDESCCAB', rounded(vVLCalc, 6));
          vVlCalc := item_f('VL_TOTALLIQUIDO', tTRA_TRANSITEM) / item_f('QT_SOLICITADA', tTRA_TRANSITEM);
          putitem_e(tTRA_TRANSITEM, 'VL_UNITLIQUIDO', rounded(vVLCalc, 6));
          vVlResto := 0;
          break;
        end;

        vVlResto := vVlResto - item_f('VL_TOTALDESCCAB', tTRA_TRANSITEM);
        if (item_f('VL_TOTALLIQUIDO', tTRA_TRANSITEM) > vVlMaior) then begin
          vVlMaior := item_f('VL_TOTALLIQUIDO', tTRA_TRANSITEM);
          vNrOcc := curocc(tTRA_TRANSITEM);
        end;
      end;
      setocc(tTRA_TRANSITEM, curocc(tTRA_TRANSITEM) + 1);
    end;
    if (vVlResto <> 0) then begin
      setocc(tTRA_TRANSITEM, 1);
      putitem_e(tTRA_TRANSITEM, 'VL_TOTALDESCCAB', item_f('VL_TOTALDESCCAB', tTRA_TRANSITEM) + vVlResto);
      putitem_e(tTRA_TRANSITEM, 'VL_TOTALLIQUIDO', item_f('VL_TOTALBRUTO', tTRA_TRANSITEM) - (item_f('VL_TOTALDESC', tTRA_TRANSITEM) + item_f('VL_TOTALDESCCAB', tTRA_TRANSITEM)));
      vVlCalc := item_f('VL_TOTALDESCCAB', tTRA_TRANSITEM) / item_f('QT_SOLICITADA', tTRA_TRANSITEM);
      putitem_e(tTRA_TRANSITEM, 'VL_UNITDESCCAB', rounded(vVLCalc, 6));
      vVlCalc := item_f('VL_TOTALLIQUIDO', tTRA_TRANSITEM) / item_f('QT_SOLICITADA', tTRA_TRANSITEM);
      putitem_e(tTRA_TRANSITEM, 'VL_UNITLIQUIDO', rounded(vVLCalc, 6));
    end;

    setocc(tTRA_TRANSITEM, 1);
    while (xStatus >= 0) do begin
      viParams := '';
      putlistitensocc_e(viParams, tTRA_TRANSITEM);
      voParams := activateCmp('TRASVCO004', 'gravaItemTransacao', viParams); (*,,,, *)
      if (xStatus < 0) then begin
        Result := voParams;
        return(-1); exit;
      end;
      setocc(tTRA_TRANSITEM, curocc(tTRA_TRANSITEM) + 1);
    end;
    if (itemXml('DS_MENSAGEM', voParams) <> '') then begin
      message/info '' + itemXml('DS_MENSAGEM', + ' voParams)';
    end;

    viParams := '';
    putitemXml(viParams, 'CD_EMPRESA', item_f('CD_EMPRESA', tTRA_TRANSACAO));
    putitemXml(viParams, 'NR_TRANSACAO', item_f('NR_TRANSACAO', tTRA_TRANSACAO));
    putitemXml(viParams, 'DT_TRANSACAO', item_a('DT_TRANSACAO', tTRA_TRANSACAO));
    putitemXml(viParams, 'PR_DESCMAXIMO', vPrDescMaximo);
    //keyboard := 'KB_GLOBAL';
    voParams := activateCmp('TRAFP059', 'EXEC', viParams); (*,,, *)
    //keyboard := 'KB_PDV';
    if (xStatus < 0) then begin
      Result := voParams;
      return(-1); exit;
    end;

    vCdUsuAntLib := gCdUsuarioDesc;
    gCdUsuarioDesc := itemXmlF('CD_USUARIODESC', voParams);

    if (gCdUsuarioDesc > 0)  and (gCdUsuarioDesc <> vCdUsuario) then begin
      clear_e(tTRA_LIMDESCONTO);
      putitem_e(tTRA_LIMDESCONTO, 'CD_OPERACAO', item_f('CD_OPERACAO', tTRA_TRANSACAO));
      putitem_e(tTRA_LIMDESCONTO, 'CD_USUARIO', gCdUsuarioDesc);
      retrieve_e(tTRA_LIMDESCONTO);
      if (xStatus < 0) then begin
        clear_e(tTRA_LIMDESCONTO);
      end;

      vDsLstTransacao := '';
      vDsRegistro := '';
      putitemXml(vDsRegistro, 'CD_EMPRESA', item_f('CD_EMPRESA', tTRA_TRANSACAO));
      putitemXml(vDsRegistro, 'NR_TRANSACAO', item_f('NR_TRANSACAO', tTRA_TRANSACAO));
      putitemXml(vDsRegistro, 'DT_TRANSACAO', item_a('DT_TRANSACAO', tTRA_TRANSACAO));
      putitem(vDsLstTransacao,  vDsRegistro);

      vDsLinha := 'Desconto liberado pelo usuario ' + FloatToStr(gCdUsuarioDesc,) + ' componente TRAFP059';
      viParams := '';
      putitemXml(viParams, 'DS_LSTTRANSACAO', vDsLstTransacao);
      putitemXml(viParams, 'DS_OBSERVACAO', vDsLinha);
      putitemXml(viParams, 'CD_COMPONENTE', TRAFM080);
      putitemXml(viParams, 'IN_MANUTENCAO', False);
      putitemXml(viParams, 'IN_OBSNF', False);
      voParams := activateCmp('TRASVCO016', 'gravaObsTransacao', viParams); (*,,,, *)
      if (xStatus < 0) then begin
        Result := voParams;
        return(-1); exit;
      end;

      gCdUsuarioDesc := '';
    end else if (gCdUsuarioDesc = '')  and (vCdUsuAntLib <> '') then begin
      gCdUsuarioDesc := vCdUsuAntLib;
    end;

    commit;
    if (xStatus < 0) then begin
      rollback;
      return(-1); exit;
    end else begin
      voParams := SetHint(viParams); (* 'ID=APLINFO002' *)
    end;
  end;

  voParams := recarregaTransacao(viParams); (* *)
  if (xStatus < 0) then begin
    Result := voParams;
    return(-1); exit;
  end;

  gprompt := item_f('TP_TRANSACAO', tTRA_TRANSACAO);

  return(0); exit;
end;

//----------------------------------------------------
function TF_TRAFM080.BT_08(pParams : String) : String;
//----------------------------------------------------
const
  cDS_METHOD = 'ADICIONAL=Operação: TF_TRAFM080.BT_08()';
var
  viParams, voParams : String;
  vNrOcc, vNrItemAnt : Real;
begin
  if (empty(tTRA_TRANSITEM) <> False) then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Transação não possui nenhuma item a ser removido!', '');
    return(-1); exit;
  end;
  if (((gInBloqExcluiItem = 1)  or (gInBloqExcluiItem = 2))  and (item_f('CD_USUIMPRESSAO', tTRA_TRANSACAO) > 0))  or (gInBloqExcluiItem = 3)  or (gInBloqExcluiItem = 4) then begin
    viParams := '';
    putitemXml(viParams, 'IN_USULOGADO', True);
    putitemXml(viParams, 'DS_COMPONENTE', 'TRAFM060EX');
    voParams := activateCmp('ADMFM020', 'exec', viParams); (*,,, *)
    if (xStatus < 0) then begin
      Result := SetStatus(STS_ERROR, 'GEN0001', 'Função bloqueada!', cDS_METHOD);
      return(-1); exit;
    end;
  end;

  askmess 'Deseja realmente remover o registro?', 'Remover, Cancelar';
  if (xStatus = 2) then begin
    return(-1); exit;
  end;

  viParams := '';
  putitemXml(viParams, 'CD_EMPRESA', item_f('CD_EMPRESA', tTRA_TRANSACAO));
  putitemXml(viParams, 'NR_TRANSACAO', item_f('NR_TRANSACAO', tTRA_TRANSACAO));
  putitemXml(viParams, 'DT_TRANSACAO', item_a('DT_TRANSACAO', tTRA_TRANSACAO));
  putitemXml(viParams, 'NR_ITEM', item_f('NR_ITEM', tTRA_TRANSITEM));
  voParams := activateCmp('TRASVCO004', 'removeItemTransacao', viParams); (*,,,, *)
  if (xStatus < 0) then begin
    Result := voParams;
    return(-1); exit;
  end;
  if (item_f('TP_DOCTO', tGER_OPERACAO) = 3) then begin
    viParams := '';
    putitemXml(viParams, 'CD_EMPRESA', item_f('CD_EMPRESA', tTRA_TRANSACAO));
    putitemXml(viParams, 'NR_TRANSACAO', item_f('NR_TRANSACAO', tTRA_TRANSACAO));
    putitemXml(viParams, 'DT_TRANSACAO', item_a('DT_TRANSACAO', tTRA_TRANSACAO));
    putitemXml(viParams, 'NR_ITEM', item_f('NR_ITEM', tTRA_TRANSITEM));
    voParams := activateCmp('ECFSVCO010', 'cancelaItem', viParams); (*,,,, *)
    if (xStatus < 0) then begin
      Result := voParams;
      return(-1); exit;
    end;
      putitemXml(viParams, 'TITULO', 'Erro de comunicação com a ECF');
      putitemXml(viParams, 'MENSAGEM', itemXml('DESCRICAO', xCtxErro));
      voParams := activateCmp('GERFP008', 'EXEC', viParams); (*,,, *)
      if (xStatus < 0) then begin
        Result := voParams;
        return(-1); exit;
      end;
      rollback;
      return(-1); exit;
    end else if (xStatus = -50) then begin
      Result := SetStatus(STS_ERROR, {xCdErro} '', '{xCtxErro} ''', '');
      apexit;
    end else if (xStatus < 0) then begin
      Result := SetStatus(STS_ERROR, {xCdErro} '', '{xCtxErro} ''', '');
      return(-1); exit;
    end;

    vNrItemAnt := item_f('NR_ITEM', tTRA_TRANSITEM);
    if (vNrItemAnt > gvNrItem) then begin
      gvNrItem := vNrItemAnt;
    end;
  end;

  commit;
  if (xStatus < 0) then begin
    rollback;
    return(-1); exit;
  end else begin
    voParams := SetHint(viParams); (* 'ID=APLINFO002' *)
  end;

  voParams := recarregaTransacao(viParams); (* *)
  if (xStatus < 0) then begin
    Result := voParams;
    return(-1); exit;
  end;

  gprompt := item_f('TP_TRANSACAO', tTRA_TRANSACAO);

  return(0); exit;
end;

//----------------------------------------------------
function TF_TRAFM080.BT_09(pParams : String) : String;
//----------------------------------------------------
const
  cDS_METHOD = 'ADICIONAL=Operação: TF_TRAFM080.BT_09()';
var
  viParams, voParams, vDsLstColetor : String;
  vInAgruparItem, vInColetor : Boolean;
  vCdPessoa, vCdPessoaAnt : Real;
begin
  viParams := '';
  putitemXml(viParams, 'CD_EMPRESA', item_f('CD_EMPRESA', tTRA_TRANSACAO));
  putitemXml(viParams, 'NR_TRANSACAO', item_f('NR_TRANSACAO', tTRA_TRANSACAO));
  putitemXml(viParams, 'DT_TRANSACAO', item_a('DT_TRANSACAO', tTRA_TRANSACAO));
  putitemXml(viParams, 'TP_FOCO', item_f('TP_FOCO', tTRA_TRANSACAO));
  if (empty(tTRA_TRANSITEM) = 1) then begin
    putitemXml(viParams, 'IN_ITENS', False);
  end;
  //keyboard := 'KB_GLOBAL';
  voParams := activateCmp('TRAFP011', 'EXEC', viParams); (*,,, *)
  //keyboard := 'KB_PDV';
  if (xStatus < 0) then begin
    Result := voParams;
    return(-1); exit;
  end;
  if (xStatus >= 0) then begin
    vInAgruparItem := itemXmlB('IN_AGRUPARITEM', voParams);
    if (vInAgruparItem = True) then begin
      voParams := agrupaItem(viParams); (* True *)
      if (xStatus < 0) then begin
        Result := voParams;
        return(-1); exit;
      end;
    end;
    if (itemXml('IN_AGRUPATRANSACAO', voParams) = True) then begin
      clear_e(tTRA_TRANSACAO);
      putitem_e(tTRA_TRANSACAO, 'DT_TRANSACAO', itemXml('DT_TRANSACAO', voParams));
      putitem_e(tTRA_TRANSACAO, 'NR_TRANSACAO', itemXmlF('NR_TRANSACAO', voParams));
      retrieve_e(tTRA_TRANSACAO);
    end;
    vInColetor := itemXmlB('IN_ENTRADACOLETOR', voParams);
    if (vInColetor = True) then begin
      vDsLstColetor := itemXml('DS_LSTCOLETOR', voParams);
      if (vDsLstColetor <> '') then begin
        voParams := entradaColetor(viParams); (* vDsLstColetor *)
        if (xStatus < 0) then begin
          Result := voParams;
          return(-1); exit;
        end;
      end;
    end;
  end;

  vCdPessoa := itemXmlF('CD_PESSOA', voParams);
  vCdPessoaAnt := item_f('CD_PESSOA', tTRA_TRANSACAO);

  if (dbocc(t'TRA_TRANSACAO')) then begin
    voParams := recarregaTransacao(viParams); (* *)
    if (xStatus < 0) then begin
      Result := voParams;
      return(-1); exit;
    end;
  end;
  if (item_f('NR_TRANSACAO', tTRA_TRANSACAO) > 0)  and (vCdPessoa > 0)  and (vCdPessoa <> vCdPessoaAnt) then begin
    clear_e(tPES_PESSOA);
    putitem_e(tPES_PESSOA, 'CD_PESSOA', vCdPessoa);
    retrieve_e(tPES_PESSOA);

    viParams := '';
    putlistitensocc_e(viParams, tTRA_TRANSACAO);
    voParams := activateCmp('TRASVCO004', 'gravaCapaTransacao', viParams); (*,,,, *)

    commit;
    if (xStatus < 0) then begin
      rollback;
      return(-1); exit;
    end else begin
      voParams := SetHint(viParams); (* 'ID=APLINFO002' *)
    end;
    if (vCdPessoa <> gCdCliente) then begin
      voParams := buscaAniversario(viParams); (* *)
      if (xStatus < 0) then begin
        Result := voParams;
        return(-1); exit;
      end;
    end;
  end;

  gprompt := item_f('TP_TRANSACAO', tTRA_TRANSACAO);

  return(0); exit;
end;

//----------------------------------------------------
function TF_TRAFM080.BT_11(pParams : String) : String;
//----------------------------------------------------
const
  cDS_METHOD = 'ADICIONAL=Operação: TF_TRAFM080.BT_11()';
var
  viParams, voParams, vDsLstTransacao, vDsLstEncargoFin, vDsLstVariacao : String;
  vDsRegistro, vDsComponente, vDsLinha, vDsLstEmpresa, vDsLstNF, vDsLstLiquidacao : String;
  vVlTrocoMaximoTra, vVlTrocoMaximoEnc, vCdUsuario, vStatus, vTpVariacao, vVlDescVariacao : Real;
  vCdOperTroca, vVlTroca, vCdOperNF, vTpValidacaoConf, vQtTotal, vPrDescVariacao, vQtMinima, vQtMaxima : Real;
  vInImprimir, vInTrocoMaximo, vInSangria, vInFatura, vInMostraTroco, vInConsultaSaldoCredev : Boolean;
  vVlResto, vVlCalc, vVlMaior, vPrTotalDesc, vNrOcc, vVlTotalDesconto, vVlTotalBruto, vTotalDescCab, vPrTotalDescCab : Real;
begin
  vTpValidacaoConf := itemXmlF('TP_VALIDACAO_CONF_TRA', xParamEmp);

  if (empty(tR_TRA_TRANSACAO) = False) then begin
    if (item_f('CD_PESSOA', tTRA_TRANSACAO) <> item_f('CD_PESSOA', tR_TRA_TRANSACAO)) then begin
      Result := SetStatus(STS_ERROR, 'GEN0001', 'Pessoa da transação de vale troca(' + CD_PESSOA + '.R_TRA_TRANSACAO) diferente da transação de troca(' + CD_PESSOA + '.TRA_TRANSACAO)!', '');
      return(-1); exit;
    end;
    if (gInMantVendValeTroca = False) then begin
      viParams := '';
      putitemXml(viParams 'CD_EMPRESA', item_f('CD_EMPRESA', tR_TRA_TRANSACAO));
      putitemXml(viParams 'NR_TRANSACAO', item_f('NR_TRANSACAO', tR_TRA_TRANSACAO));
      putitemXml(viParams 'DT_TRANSACAO', item_a('DT_TRANSACAO', tR_TRA_TRANSACAO));
      putitemXml(viParams 'CD_COMPVend', item_f('CD_COMPVEND', tTRA_TRANSACAO));
      voParams := activateCmp('TRASVCO004', 'alteraVendedorTransacaoNF', viParams); (*,,,, *)
      if (xStatus < 0) then begin
        Result := voParams;
        return(-1); exit;
      end;
    end;
  end;
  if (item_f('CD_COMPVEND', tTRA_TRANSACAO) = 0)  and (gCdCompVend <> 0) then begin
    clear_e(tPES_VENDEDOR);
    putitem_e(tPES_VENDEDOR, 'CD_VENDEDOR', gCdCompVend);
    retrieve_e(tPES_VENDEDOR);
  end;
  if (item_f('TP_MODALIDADE', tGER_OPERACAO) = 4)  and (item_f('TP_OPERACAO', tTRA_TRANSACAO) = 'S') then begin
    viParams := '';
    putitemXml(viParams, 'CD_OPERACAO', item_f('CD_OPERACAO', tTRA_TRANSACAO));
    voParams := activateCmp('GERSVCO054', 'dadosAdicionaisOperacao', viParams); (*,,,, *)
    if (xStatus < 0) then begin
      Result := voParams;
      return(-1); exit;
    end;

    vQtMinima := itemXmlF('QT_MINIMA', voParams);
    vQtMaxima := itemXmlF('QT_MAXIMA', voParams);

    if (vQtMinima > 0)  and (item_f('QT_SOLICITADA', tTRA_TRANSACAO) < vQtMinima) then begin
      Result := SetStatus(STS_ERROR, 'GEN0001', 'Transação ' + NR_TRANSACAO + '.TRA_TRANSACAO não possui quantidade mínima ' + vQtMinima + ' por operação!', '');
      return(-1); exit;
    end else if (vQtMaxima > 0)  and (item_f('QT_SOLICITADA', tTRA_TRANSACAO) > vQtMaxima) then begin
      Result := SetStatus(STS_ERROR, 'GEN0001', 'Transação ' + NR_TRANSACAO + '.TRA_TRANSACAO ultrapassou a quantidade máxima ' + vQtMaxima + ' por operação!', '');
      return(-1); exit;
    end;
  end;

  viParams := '';
  putlistitensocc_e(viParams, tTRA_TRANSACAO);
  voParams := activateCmp('TRASVCO004', 'gravaCapaTransacao', viParams); (*,,,, *)
  if (xStatus < 0) then begin
    Result := voParams;
    return(-1); exit;
  end;
  if (gNrDiaAtraso <= gNrDiasCarenciaAtraso)  and (gNrDiasCarenciaAtraso > 0)  and (gNrDiaAtraso > 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN001', 'Cliente com ' + FloatToStr(gNrDiaAtraso) + ' dias em atraso!', '');
  end;
  if (vTpValidacaoConf = 2)  or (vTpValidacaoConf = 3) then begin
    viParams := '';
    //keyboard := 'KB_GLOBAL';
    putitemXml(viParams, 'QT_TOTAL', item_f('QT_SOLICITADA', tTRA_TRANSACAO));
    voParams := activateCmp('TRAFP058', 'EXEC', viParams); (*,,, *)
    //keyboard := 'KB_PDV';
    if (xStatus < 0) then begin
      Result := voParams;
      return(-1); exit;
    end;
    if (vTpValidacaoConf = 3) then begin
      putitem_e(tTRA_TRANSACAO, 'CD_USUCONF', itemXmlF('CD_USUCONF', voParams));
      viParams := '';
      putlistitensocc_e(viParams, tTRA_TRANSACAO);
      voParams := activateCmp('TRASVCO004', 'gravaCapaTransacao', viParams); (*,,,, *)
      if (xStatus < 0) then begin
        Result := voParams;
        return(-1); exit;
      end;
    end;
  end;
  if (gTpAgrupamento = 0 ) or (gTpAgrupamento = 3) then begin
    voParams := agrupaItem(viParams); (* False *)
    if (xStatus < 0) then begin
      Result := voParams;
      return(-1); exit;
    end;
  end;

  vCdUsuario := itemXmlF('CD_USUARIO', PARAM_GLB);

  if (gCdUsuarioDesc > 0)  and (gCdUsuarioDesc <> vCdUsuario) then begin
    vDsLstTransacao := '';
    vDsRegistro := '';
    putitemXml(vDsRegistro, 'CD_EMPRESA', item_f('CD_EMPRESA', tTRA_TRANSACAO));
    putitemXml(vDsRegistro, 'NR_TRANSACAO', item_f('NR_TRANSACAO', tTRA_TRANSACAO));
    putitemXml(vDsRegistro, 'DT_TRANSACAO', item_a('DT_TRANSACAO', tTRA_TRANSACAO));
    putitem(vDsLstTransacao,  vDsRegistro);

    vDsLinha := 'Desconto liberado pelo usuario ' + FloatToStr(gCdUsuarioDesc') + ';
    viParams := '';
    putitemXml(viParams, 'DS_LSTTRANSACAO', vDsLstTransacao);
    putitemXml(viParams, 'DS_OBSERVACAO', vDsLinha);
    putitemXml(viParams, 'CD_COMPONENTE', TRAFM080);
    putitemXml(viParams, 'IN_OBSNF', False);
    voParams := activateCmp('TRASVCO016', 'gravaObsTransacao', viParams); (*,,,, *)
    if (xStatus < 0) then begin
      Result := voParams;
      return(-1); exit;
    end;
    gCdUsuarioDesc := '';
  end;
  if (gTpUtilizaBoleta = 2) then begin
    viParams := '';
    //keyboard := 'KB_GLOBAL';
    putitemXml(viParams, 'CD_EMPRESA', item_f('CD_EMPRESA', tTRA_TRANSACAO));
    putitemXml(viParams, 'NR_TRANSACAO', item_f('NR_TRANSACAO', tTRA_TRANSACAO));
    putitemXml(viParams, 'DT_TRANSACAO', item_a('DT_TRANSACAO', tTRA_TRANSACAO));
    voParams := activateCmp('TRAFM140', 'EXEC', viParams); (*,,, *)
    //keyboard := 'KB_PDV';
  end;

  commit;
  if (xStatus < 0) then begin
    rollback;
    return(-1); exit;
  end else begin
    voParams := SetHint(viParams); (* 'ID=APLINFO002' *)
  end;

  vCdOperTroca := itemXmlF('CD_OPER_TROCA_VALOR_VD', xParamEmp);
  vVlTroca := itemXmlF('VL_TROCA_TPVALOR_VD', xParamEmp);

  if (vCdOperTroca <> 0)  and (item_f('VL_TRANSACAO', tTRA_TRANSACAO) >= vVlTroca)  and (item_f('TP_MODALIDADE', tGER_OPERACAO) = 4)  and (item_f('TP_OPERACAO', tTRA_TRANSACAO) = 'S') then begin
    gVlTransacaoAnt := item_f('VL_TRANSACAO', tTRA_TRANSACAO);

    viParams := '';
    putitemXml(viParams, 'CD_EMPRESA', item_f('CD_EMPRESA', tTRA_TRANSACAO));
    putitemXml(viParams, 'NR_TRANSACAO', item_f('NR_TRANSACAO', tTRA_TRANSACAO));
    putitemXml(viParams, 'DT_TRANSACAO', item_a('DT_TRANSACAO', tTRA_TRANSACAO));
    putitemXml(viParams, 'CD_OPERACAO', vCdOperTroca);
    putitemXml(viParams, 'CD_OPERACAONF', vCdOperNF);
    voParams := activateCmp('TRASVCO024', 'trocaOperacaoTra', viParams); (*,,,, *)

    commit;
    if (xStatus < 0) then begin
      rollback;
      return(-1); exit;
    end else begin
      voParams := SetHint(viParams); (* 'ID=APLINFO002' *)
    end;

    voParams := recarregaTransacao(viParams); (* *)
    if (xStatus < 0) then begin
      Result := voParams;
      return(-1); exit;
    end;

    message/info 'Valor total antigo: ' + FloatToStr(gVlTransacaoAnt) + '   Valor total novo: ' + VL_TRANSACAO + '.TRA_TRANSACAO.Troca de operação, parâmetros: CD_OPER_TROCA_VALOR_VD e VL_TROCA_TPVALOR_VD';
  end;
  if (item_f('TP_MODALIDADE', tGER_OPERACAO) = 4)  and (item_f('TP_OPERACAO', tTRA_TRANSACAO) = 'S') then begin
    if (gqtPecasDescontoVlMin > 0) then begin
      voParams := aplicaQtPecasDescontoVlMin(viParams); (* *)
      if (xStatus < 0) then begin
        Result := voParams;
        return(-1); exit;
      end;
    end;

    vTpVariacao := itemXmlF('TP_VARIACAO_DESCONTO_VD', xParamEmp);
    if (vTpVariacao = 1) then begin
      viParams := '';
      putitemXml(viParams, 'CD_EMPRESA', item_f('CD_EMPRESA', tTRA_TRANSACAO));
      putitemXml(viParams, 'NR_TRANSACAO', item_f('NR_TRANSACAO', tTRA_TRANSACAO));
      putitemXml(viParams, 'DT_TRANSACAO', item_a('DT_TRANSACAO', tTRA_TRANSACAO));
      voParams := activateCmp('TRASVCO005', 'descontoVariacao', viParams); (*,,,, *)
      if (xStatus < 0) then begin
        Result := voParams;
        return(-1); exit;
      end;

      vDsLstVariacao := itemXml('DS_LSTRETORNO', voParams);
      vVlDescVariacao := itemXmlF('VL_DESCONTO', voParams);
      vPrDescVariacao := itemXmlF('PR_DESCONTO', voParams);

      if (vDsLstVariacao <> '') then begin
        viParams := '';
        putitemXml(viParams, 'TITULO', 'Item com variação de desconto');
        putitemXml(viParams, 'MENSAGEM', vDsLstVariacao);
        voParams := activateCmp('GERFP008', 'EXEC', viParams); (*,,, *)
        if (xStatus < 0) then begin
          Result := voParams;
          return(-1); exit;
        end;

        askmess 'Confirma variação de desconto?', 'Sim, Não';
        if (xStatus = 2) then begin
          rollback;
          return(-1); exit;
        end;
      end;
      if (vPrDescVariacao > 0) then begin
        vPrTotalDescCab := 0;
        vTotalDescCab := 0;
        setocc(tTRA_TRANSITEM, 1);
        while (xStatus >= 0) do begin
          vTotalDescCab := vTotalDescCab + item_f('VL_TOTALDESCCAB', tTRA_TRANSITEM);
          setocc(tTRA_TRANSITEM, curocc(tTRA_TRANSITEM) + 1);
        end;
        vPrTotalDescCab := (vTotalDescCab / (item_f('VL_TRANSACAO', tTRA_TRANSACAO) + vTotalDescCab)) * 100;

        vVlResto := vVlDescVariacao + vTotalDescCab;

        vPrTotalDesc := vPrDescVariacao + vPrTotalDescCab;

        if (empty(tTRA_TRANSITEM) = False) then begin
          vVlMaior := 0;
          setocc(tTRA_TRANSITEM, 1);
          while (xStatus >= 0) do begin
            vVlCalc := item_f('VL_TOTALLIQUIDO', tTRA_TRANSITEM) + item_f('VL_TOTALDESCCAB', tTRA_TRANSITEM);
            vVlCalc := vVlCalc * vPrTotalDesc / 100;
            putitem_e(tTRA_TRANSITEM, 'VL_TOTALDESCCAB', rounded(vVlCalc, 2));
            putitem_e(tTRA_TRANSITEM, 'VL_TOTALLIQUIDO', item_f('VL_TOTALBRUTO', tTRA_TRANSITEM) - (item_f('VL_TOTALDESC', tTRA_TRANSITEM) + item_f('VL_TOTALDESCCAB', tTRA_TRANSITEM)));
            vVlCalc := item_f('VL_TOTALDESCCAB', tTRA_TRANSITEM) / item_f('QT_SOLICITADA', tTRA_TRANSITEM);
            putitem_e(tTRA_TRANSITEM, 'VL_UNITDESCCAB', rounded(vVLCalc, 6));
            vVlCalc := item_f('VL_TOTALLIQUIDO', tTRA_TRANSITEM) / item_f('QT_SOLICITADA', tTRA_TRANSITEM);
            putitem_e(tTRA_TRANSITEM, 'VL_UNITLIQUIDO', rounded(vVLCalc, 6));

            if (item_f('VL_TOTALDESCCAB', tTRA_TRANSITEM) > vVlResto) then begin
              putitem_e(tTRA_TRANSITEM, 'VL_TOTALDESCCAB', vVlResto);
              putitem_e(tTRA_TRANSITEM, 'VL_TOTALLIQUIDO', item_f('VL_TOTALBRUTO', tTRA_TRANSITEM) - (item_f('VL_TOTALDESC', tTRA_TRANSITEM) + item_f('VL_TOTALDESCCAB', tTRA_TRANSITEM)));
              vVlCalc := item_f('VL_TOTALDESCCAB', tTRA_TRANSITEM) / item_f('QT_SOLICITADA', tTRA_TRANSITEM);
              putitem_e(tTRA_TRANSITEM, 'VL_UNITDESCCAB', rounded(vVLCalc, 6));
              vVlCalc := item_f('VL_TOTALLIQUIDO', tTRA_TRANSITEM) / item_f('QT_SOLICITADA', tTRA_TRANSITEM);
              putitem_e(tTRA_TRANSITEM, 'VL_UNITLIQUIDO', rounded(vVLCalc, 6));
              vVlResto := 0;
              break;
            end;

            vVlResto := vVlResto - item_f('VL_TOTALDESCCAB', tTRA_TRANSITEM);

            if (item_f('VL_TOTALLIQUIDO', tTRA_TRANSITEM) > vVlMaior) then begin
              vVlMaior := item_f('VL_TOTALLIQUIDO', tTRA_TRANSITEM);
              vNrOcc := curocc(tTRA_TRANSITEM);
            end;

            setocc(tTRA_TRANSITEM, curocc(tTRA_TRANSITEM) + 1);
          end;
        end;
        if (vVlResto <> 0) then begin
          setocc(tTRA_TRANSITEM, 1);
          putitem_e(tTRA_TRANSITEM, 'VL_TOTALDESCCAB', item_f('VL_TOTALDESCCAB', tTRA_TRANSITEM) + vVlResto);
          putitem_e(tTRA_TRANSITEM, 'VL_TOTALLIQUIDO', item_f('VL_TOTALBRUTO', tTRA_TRANSITEM) - (item_f('VL_TOTALDESC', tTRA_TRANSITEM) + item_f('VL_TOTALDESCCAB', tTRA_TRANSITEM)));
          vVlCalc := item_f('VL_TOTALDESCCAB', tTRA_TRANSITEM) / item_f('QT_SOLICITADA', tTRA_TRANSITEM);
          putitem_e(tTRA_TRANSITEM, 'VL_UNITDESCCAB', rounded(vVLCalc, 6));
          vVlCalc := item_f('VL_TOTALLIQUIDO', tTRA_TRANSITEM) / item_f('QT_SOLICITADA', tTRA_TRANSITEM);
          putitem_e(tTRA_TRANSITEM, 'VL_UNITLIQUIDO', rounded(vVLCalc, 6));
        end;

        setocc(tTRA_TRANSITEM, 1);
        while (xStatus >= 0) do begin
          viParams := '';
          putlistitensocc_e(viParams, tTRA_TRANSITEM);
          putitemXml(viParams, 'IN_TOTAL', False);
          putitemXml(viParams, 'IN_NAOVALIDALOTE', True);
          voParams := activateCmp('TRASVCO004', 'gravaItemTransacao', viParams); (*,,,, *)
          if (xStatus < 0) then begin
            Result := voParams;
            return(-1); exit;
          end;
          setocc(tTRA_TRANSITEM, curocc(tTRA_TRANSITEM) + 1);
        end;
        if (itemXml('DS_MENSAGEM', voParams) <> '') then begin
          message/info '' + itemXml('DS_MENSAGEM', + ' voParams)';
        end;

        vDsLstTransacao := '';
        vDsRegistro := '';
        putitemXml(vDsRegistro, 'CD_EMPRESA', item_f('CD_EMPRESA', tTRA_TRANSACAO));
        putitemXml(vDsRegistro, 'NR_TRANSACAO', item_f('NR_TRANSACAO', tTRA_TRANSACAO));
        putitemXml(vDsRegistro, 'DT_TRANSACAO', item_a('DT_TRANSACAO', tTRA_TRANSACAO));
        putitem(vDsLstTransacao,  vDsRegistro);
        putitemXml(viParams, 'DS_LSTTRANSACAO', vDsLstTransacao);
        voParams := activateCmp('TRASVCO004', 'gravaTotalTransacao', viParams); (*,,,, *)

        commit;
        if (xStatus < 0) then begin
          rollback;
          return(-1); exit;
        end else begin
          voParams := SetHint(viParams); (* 'ID=APLINFO002' *)
        end;

        voParams := recarregaTransacao(viParams); (* *)
        if (xStatus < 0) then begin
          Result := voParams;
          return(-1); exit;
        end;
      end;
    end;
  end;
  if (gInUtilizaCTC = True) then begin
    voParams := carregaBonusCartao(viParams); (* *)
    if (xStatus < 0) then begin
      Result := voParams;
      return(-1); exit;
    end;
  end;

  voParams := bonusDesconto(viParams); (* *)
  if (xStatus < 0) then begin
    Result := voParams;
    return(-1); exit;
  end;

  voParams := carregaFormaPagamento(viParams); (* *)
  if (xStatus < 0) then begin
    Result := voParams;
    return(-1); exit;
  end;

  vInImprimir := True;
  if (gTpImpressaoTraVenda <> 1)  and (gTpImpressaoTraVenda <> 2) then begin
    vInImprimir := False;
  end;
  if (vInImprimir = True) then begin
    viParams := '';
    putitemXml(viParams, 'CD_OPERACAO', item_f('CD_OPERACAO', tGER_OPERACAO));
    voParams := activateCmp('GERSVCO054', 'dadosAdicionaisOperacao', viParams); (*,,,, *)
    if (xStatus < 0) then begin
      Result := voParams;
      return(-1); exit;
    end;
    if (itemXml('TP_IMPRESSAOTRA', voParams) = 1) then begin
      vInImprimir := False;
    end;
  end;
  if (vInImprimir = True) then begin
    viParams := '';
    vDsLstTransacao := '';
    vDsRegistro := '';
    putitemXml(vDsRegistro, 'CD_EMPRESA', item_f('CD_EMPRESA', tTRA_TRANSACAO));
    putitemXml(vDsRegistro, 'NR_TRANSACAO', item_f('NR_TRANSACAO', tTRA_TRANSACAO));
    putitemXml(vDsRegistro, 'DT_TRANSACAO', item_a('DT_TRANSACAO', tTRA_TRANSACAO));
    putitem(vDsLstTransacao,  vDsRegistro);
    putitemXml(viParams, 'DS_LSTTRANSACAO', vDsLstTransacao);
    if (item_f('TP_MODALIDADE', tGER_OPERACAO) = 4 ) or (item_f('TP_MODALIDADE', tGER_OPERACAO) = 3 ) or (item_f('TP_MODALIDADE', tGER_OPERACAO) = 8) then begin
      if (gTpImpressaoTraVenda = 02) then begin
        putitemXml(viParams, 'IN_DIRETO', False);
      end else begin
        putitemXml(viParams, 'IN_DIRETO', True);
      end;
    end else begin
      putitemXml(viParams, 'IN_DIRETO', False);
    end;

    //keyboard := 'KB_GLOBAL';
    voParams := activateCmp('TRAFP004', 'EXEC', viParams); (*,,, *)
    //keyboard := 'KB_PDV';
    if (xStatus >= 0) then begin
      commit;
      if (xStatus < 0) then begin
        rollback;
      end else begin
        voParams := SetHint(viParams); (* 'ID=APLINFO002' *)
      end;
    end else begin
      rollback;
    end;
  end;
  if (gTpLiberacaoTraVd = 01 ) or (gTpLiberacaoTraVd = 02)  and (item_f('TP_MODALIDADE', tGER_OPERACAO) = 4)  and (item_f('TP_OPERACAO', tTRA_TRANSACAO) = 'S') then begin
    vDsLstTransacao := '';
    vDsRegistro := '';
    putitemXml(vDsRegistro, 'CD_EMPRESA', item_f('CD_EMPRESA', tTRA_TRANSACAO));
    putitemXml(vDsRegistro, 'NR_TRANSACAO', item_f('NR_TRANSACAO', tTRA_TRANSACAO));
    putitemXml(vDsRegistro, 'DT_TRANSACAO', item_a('DT_TRANSACAO', tTRA_TRANSACAO));
    putitem(vDsLstTransacao,  vDsRegistro);
    viParams := '';
    putitemXml(viParams, 'DS_LSTTRANSACAO', vDsLstTransacao);
    if (gTpLiberacaoTraVd = 01) then begin
      putitemXml(viParams, 'TP_SITUACAO', 2);
    end else begin
      putitemXml(viParams, 'TP_SITUACAO', 8);
    end;
    putitemXml(viParams, 'CD_COMPONENTE', TRAFM080);
    voParams := activateCmp('TRASVCO004', 'alteraSituacaoTransacao', viParams); (*,,,, *)
    commit;
    if (xStatus < 0) then begin
      rollback;
      return(-1); exit;
    end else begin
      voParams := SetHint(viParams); (* 'ID=APLINFO002' *)
    end;
  end;

  vDsComponente := 'TRAFM061';
  voParams := activateCmp('LOGSVCO003', 'GetNivelComponente', viParams); (*gModulo.gCdUsuario,gModulo.gCdEmpresa,vDsComponente,gxCdNivel,, *)
  if (xStatus < 0) then begin
    Result := voParams;
    return(-1); exit;
  end;
    if (item_f('TP_DOCTO', tGER_OPERACAO) = 2)  or (item_f('TP_DOCTO', tGER_OPERACAO) = 3) then begin
      putitemXml(viParams, 'IN_DIRETO', True);
    end else begin
      putitemXml(viParams, 'IN_DIRETO', False);
    end;
    //keyboard := 'KB_GLOBAL';
    voParams := activateCmp('TRAFM061', 'EXEC', viParams); (*,,, *)
    //keyboard := 'KB_PDV';
    if (xStatus >= 0)  or (xStatus = -3) then begin
      vStatus := xStatus;
      commit;
      if (xStatus < 0) then begin
        rollback;
        return(-1); exit;
      end else begin
        voParams := SetHint(viParams); (* 'ID=APLINFO002' *)
      end;
      if (vStatus = -3) then begin
        voParams := recarregaTransacao(viParams); (* *)
        if (xStatus < 0) then begin
          Result := voParams;
          return(-1); exit;
        end;

        return(-1); exit;
      end;
    end else begin
      rollback;
      return(-1); exit;
    end;
    if (item_f('TP_DOCTO', tGER_OPERACAO) = 1) then begin
      viParams := voParams;
      if (item_f('TP_MODALIDADE', tGER_OPERACAO) = 4) then begin
        if (gTpImpressaoNFVenda = 01) then begin
          putitemXml(viParams, 'IN_DIRETO', False);
        end else begin
          putitemXml(viParams, 'IN_DIRETO', True);
        end;
      end else begin
        putitemXml(viParams, 'IN_DIRETO', False);
      end;
      //keyboard := 'KB_GLOBAL';
      voParams := activateCmp('FISFP008', 'EXEC', viParams); (*,,, *)
      //keyboard := 'KB_PDV';
      if (xStatus >= 0) then begin
        commit;
        if (xStatus < 0) then begin
          rollback;
        end else begin
          voParams := SetHint(viParams); (* 'ID=APLINFO002' *)
        end;
      end else begin
        rollback;
      end;
    end;
    if (item_f('TP_MODALIDADE', tGER_OPERACAO) = 3) then begin
      vDsComponente := 'TRAFM068';
    end else begin
      vDsComponente := 'TRAFM066';
    end;
    voParams := activateCmp('LOGSVCO003', 'GetNivelComponente', viParams); (*gModulo.gCdUsuario,gModulo.gCdEmpresa,vDsComponente,gxCdNivel,, *)
    if (xStatus < 0) then begin
      Result := voParams;
      return(-1); exit;
    end;
      if (xStatus < 0) then begin
        Result := voParams;
        return(-1); exit;
      end;

      vDsLstTransacao := itemXml('DS_LSTTRANSACAO', voParams);
      vDsLstEncargoFin := itemXml('DS_LSTENCARGOFIN', voParams);

      if (vDsLstTransacao = '')  and (vDsLstEncargoFin = '') then begin
        Result := SetStatus(STS_ERROR, 'GEN0001', 'Nenhuma transação validada para recebimento!', '');
        macro '^CLEAR';
        return(-1); exit;
      end;

      viParams := '';
      putitemXml(viParams, 'DS_LSTTRANSACAO', vDsLstTransacao);
      putitemXml(viParams, 'DS_LSTENCARGOFIN', vDsLstEncargoFin);
      voParams := activateCmp('SICSVCO005', 'buscaMaxTroco', viParams); (*,,,, *)
      if (xStatus < 0) then begin
        Result := voParams;
        return(-1); exit;
      end;

      gTpTrocoMaximo := itemXmlF('TP_TROCOMAXIMO', voParams);
      vVlTrocoMaximoTra := itemXmlF('VL_TROCOMAXIMOTRA', voParams);
      vVlTrocoMaximoEnc := itemXmlF('VL_TROCOMAXIMOENC', voParams);

      vInTrocoMaximo := False;

      if (gTpTrocoMaximo = 1) then begin
        vInTrocoMaximo := True;
      end else if (gTpTrocoMaximo = 2) then begin
        askmess 'Utiliza controle de troco máximo?', 'Sim, Não';
        if (xStatus = 1) then begin
          vInTrocoMaximo := True;
        end else begin
          vInTrocoMaximo := False;
        end;
      end;
      if (vDsLstTransacao <> '') then begin
        viParams := '';
        putitemXml(viParams, 'DS_LSTTRANSACAO', vDsLstTransacao);
        putitemXml(viParams, 'IN_TROCOMAXIMO', vInTrocoMaximo);
        putitemXml(viParams, 'VL_TROCOMAXIMO', vVlTrocoMaximoTra);
        putitemXml(viParams, 'CD_EMPECF', gCdEmpEcf);
        putitemXml(viParams, 'NR_ECF', gNrEcf);
        putitemXml(viParams, 'NR_CUPOM', gNrCupom);
        if (item_f('TP_MODALIDADE', tGER_OPERACAO) = 3) then begin
          //keyboard := 'KB_GLOBAL';
          voParams := activateCmp('TRAFM068', 'EXEC', viParams); (*,,, *)
          //keyboard := 'KB_PDV';
          if (xStatus < 0) then begin
            Result := voParams;
            return(-1); exit;
          end;
        end else begin
          //keyboard := 'KB_GLOBAL';
          voParams := activateCmp('TRAFM066', 'EXEC', viParams); (*,,, *)
          //keyboard := 'KB_PDV';
          if (xStatus < 0) then begin
            Result := voParams;
            return(-1); exit;
          end;
          vInFatura := itemXmlB('IN_FATURA', voParams);
          gVlTroco := itemXmlF('VL_TROCO', voParams);
          vDsLstNF := itemXml('DS_LSTNF', voParams);

          if (itemXml('CD_EMPLIQ', voParams)<> '')  and (itemXml('DT_LIQ', voParams)<> '')  and itemXmlF('NR_SEQLIQ', voParams) then begin
            vDsRegistro := '';
            putitemXml(vDsRegistro, 'CD_EMPLIQ', itemXmlF('CD_EMPLIQ', voParams));
            putitemXml(vDsRegistro, 'DT_LIQ', itemXml('DT_LIQ', voParams));
            putitemXml(vDsRegistro, 'NR_SEQLIQ', itemXmlF('NR_SEQLIQ', voParams));
            vDsLstLiquidacao := '';
            putitem(vDsLstLiquidacao,  vDsRegistro);
          end;
        end;
      end else begin
        xStatus := 0;
      end;
      if (xStatus >= 0)  and (vDsLstEncargoFin <> '') then begin
        viParams := '';
        putitemXml(viParams, 'DS_LSTTRANSACAO', vDsLstEncargoFin);
        putitemXml(viParams, 'IN_TROCOMAXIMO', vInTrocoMaximo);
        putitemXml(viParams, 'VL_TROCOMAXIMO', vVlTrocoMaximoEnc);
        putitemXml(viParams, 'CD_EMPECF', gCdEmpEcf);
        putitemXml(viParams, 'NR_ECF', gNrEcf);
        putitemXml(viParams, 'NR_CUPOM', gNrCupom);
        if (item_f('TP_MODALIDADE', tGER_OPERACAO) = 3) then begin
          //keyboard := 'KB_GLOBAL';
          voParams := activateCmp('TRAFM068', 'EXEC', viParams); (*,,, *)
          //keyboard := 'KB_PDV';
          if (xStatus < 0) then begin
            Result := voParams;
            return(-1); exit;
          end;
        end else begin
          //keyboard := 'KB_GLOBAL';
          voParams := activateCmp('TRAFM066', 'EXEC', viParams); (*,,, *)
          //keyboard := 'KB_PDV';
          if (xStatus < 0) then begin
            Result := voParams;
            return(-1); exit;
          end;
          if (itemXml('CD_EMPLIQ', voParams)<> '')  and (itemXml('DT_LIQ', voParams)<> '')  and itemXmlF('NR_SEQLIQ', voParams) then begin
            vDsRegistro := '';
            putitemXml(vDsRegistro, 'CD_EMPLIQ', itemXmlF('CD_EMPLIQ', voParams));
            putitemXml(vDsRegistro, 'DT_LIQ', itemXml('DT_LIQ', voParams));
            putitemXml(vDsRegistro, 'NR_SEQLIQ', itemXmlF('NR_SEQLIQ', voParams));
            putitem(vDsLstLiquidacao,  vDsRegistro);
          end;
        end;
      end;
      if (xStatus >= 0) then begin
        commit;
        if (xStatus < 0) then begin
          rollback;
          macro '^CLEAR';
          return(-1); exit;
        end else begin
          voParams := SetHint(viParams); (* 'ID=APLINFO002' *)
        end;
      end else begin
        rollback;
        clear;
        gprompt := item_f('TP_TRANSACAO', tTRA_TRANSACAO);
        macro '^CLEAR';
        return(-1); exit;
      end;
      if (vDsLstLiquidacao <> '')  and (gCdModImpRecebTra > 0) then begin
        repeat
          getitem(vDsRegistro, vDsLstLiquidacao, 1);

          viParams := '';
          putitemXml(viParams, 'CD_EMPLIQ', itemXmlF('CD_EMPLIQ', vDsRegistro));
          putitemXml(viParams, 'DT_LIQ', itemXml('DT_LIQ', vDsRegistro));
          putitemXml(viParams, 'NR_SEQLIQ', itemXmlF('NR_SEQLIQ', vDsRegistro));
          putitemXml(viParams, 'CD_MODFIN', gCdModImpRecebTra);
          putitemXml(viParams, 'IN_FATURAMENTO', True);
          voParams := activateCmp('FCRFF002', 'EXEC', viParams); (*,,, *)
          if (xStatus < 0) then begin
            Result := voParams;
            return(-1); exit;
          end;

          delitem(vDsLstLiquidacao, 1);
        until (vDsLstLiquidacao = '');
      end;

      vInMostraTroco := itemXmlB('IN_MOSTRA_TROCO_RECEB', xParamEmp);

      if (vInMostraTroco = True)  and (item_f('TP_MODALIDADE', tGER_OPERACAO) <> 3)  and (gVlTroco <> 0) then begin
        message/info 'VALOR TROCO: Rg ' + VlTrocog' + ';
      end;
      if (vDsLstNF <> '') then begin
        viParams := '';
        putitemXml(viParams, 'DS_LSTNF', vDsLstNF);
        putitemXml(viParams, 'IN_GERA_NFE_AUTOMATIC', True);
        voParams := activateCmp('FISFP042', 'EXEC', viParams); (*,,, *)
        if (xStatus < 0) then begin
          Result := voParams;
          return(-1); exit;
        end;
      end;
      if (vDsLstTransacao <> '')  and (gTpImpRichTextVD = 1)  and (gCdModRichTextVD <> '')  and (vInFatura = True) then begin
        viParams := '';
        putitemXml(viParams, 'CD_EMPRESA', item_f('CD_EMPRESA', tTRA_TRANSACAO));
        putitemXml(viParams, 'DT_TRANSACAO', item_a('DT_TRANSACAO', tTRA_TRANSACAO));
        putitemXml(viParams, 'NR_TRANSACAO', item_f('NR_TRANSACAO', tTRA_TRANSACAO));
        putitemXml(viParams, 'CD_MODELO', 'TRA');
        putitemXml(viParams, 'CD_RICHTEXT', gCdModRichTextVD);
        voParams := activateCmp('TRAFP061', 'EXEC', viParams); (*,,, *)
        if (xStatus < 0) then begin
          Result := voParams;
          return(-1); exit;
        end;
      end;
    end;

    vInConsultaSaldoCredev := False;
    selectcase gTpConsultaSaldoCredev;
    case 1;
      askmess 'Deseja consultar Saldo Credev?', 'Sim, Não';
      if (xStatus = 1) then begin
        vInConsultaSaldoCredev := True;
      end;
    case 2;
      vInConsultaSaldoCredev := True;
    endselectcase;
    if (vInConsultaSaldoCredev = True) then begin
      viParams := '';
      putitemXml(viParams, 'CD_EMPRESA', item_f('CD_EMPRESA', tTRA_TRANSACAO));
      putitemXml(viParams, 'CD_PESSOA', item_f('CD_PESSOA', tTRA_TRANSACAO));
      voParams := activateCmp('TRAFC018', 'EXEC', viParams); (*,,, *)
      if (xStatus < 0) then begin
        Result := voParams;
        return(-1); exit;
      end;
    end;

    viParams := '';
    putitemXml(viParams, 'LST_EMPRESA', itemXmlF('CD_EMPRESA', PARAM_GLB));
    voParams := activateCmp('FCXSVCO001', 'buscarSaldoCaixaUsuario', viParams); (*,,,, *)
    if (xStatus < 0) then begin
      Result := voParams;
      return(-1); exit;
    end;

    vInSangria := itemXmlB('IN_SANGRIA', voParams);

    if (vInSangria = True) then begin
      message/info '<<<< ATENÇÃO >>>>Efetuar sangria de caixa!';
    end;
  end;

  clear;
  macro '^CLEAR';

  return(0); exit;
end;

//------------------------------------------------------------
function TF_TRAFM080.carregaListas(pParams : String) : String;
//------------------------------------------------------------
const
  cDS_METHOD = 'ADICIONAL=Operação: TF_TRAFM080.carregaListas()';
var
  viParams, voParams, vDsLstOperacao : String;
  vCdEmpresa, vCdUsuario : Real;
begin
  vCdEmpresa := itemXmlF('CD_EMPRESA', PARAM_GLB);
  vCdUsuario := itemXmlF('CD_USUARIO', PARAM_GLB);

  vDsLstOperacao := '';
  clear_e(tADM_USUOPERCMP);
  putitem_e(tADM_USUOPERCMP, 'CD_EMPRESA', vCdEmpresa);
  putitem_e(tADM_USUOPERCMP, 'CD_USUARIO', vCdUsuario);
  putitem_e(tADM_USUOPERCMP, 'CD_COMPONENTE', TRAFM080);
  retrieve_e(tADM_USUOPERCMP);
  if (xStatus >= 0) then begin
    gTpTransacaoPadrao := 0;
    gqtOperacao := 0;
    setocc(tADM_USUOPERCMP, 1);
    while (xStatus >=0) do begin
      if (item_f('CD_OPERACAO', tADM_USUOPERCMP) = gCdOperacaoVenda) then begin
        putitem(vDsLstOperacao,  '1=Venda');
        gqtOperacao := gqtOperacao + 1;
        if (gTpTransacaoPadrao = 0) then begin
          gTpTransacaoPadrao := 1;
        end;
      end else if (item_f('CD_OPERACAO', tADM_USUOPERCMP) = gCdOperacaoValeTroca) then begin
        putitem(vDsLstOperacao,  '2=Vale troca');
        gqtOperacao := gqtOperacao + 1;
        if (gTpTransacaoPadrao = 0) then begin
          gTpTransacaoPadrao := 2;
        end;
      end else if (item_f('CD_OPERACAO', tADM_USUOPERCMP) = gCdOperacaoTroca) then begin
        putitem(vDsLstOperacao,  '3=Troca');
        gqtOperacao := gqtOperacao + 1;
        if (gTpTransacaoPadrao = 0) then begin
          gTpTransacaoPadrao := 3;
        end;
      end;
      setocc(tADM_USUOPERCMP, curocc(tADM_USUOPERCMP) + 1);
    end;
    if (vDsLstOperacao = '') then begin
      Result := SetStatus(STS_ERROR, 'GEN0001', 'Usuário ' + FloatToStr(vCdUsuario) + ' não possui permissão em nenhuma das operações utilizadas por este componente(' + FloatToStr(gCdOperacaoVenda) + ' / ' + FloatToStr(gCdOperacaoValeTroca) + ' / ' + FloatToStr(gCdOperacaoTroca)) + '!', '');
      return(-1); exit;
    end else begin
      valrep(putitem_e(tTRA_TRANSACAO, 'TP_TRANSACAO'), vDsLstOperacao);
    end;
  end else begin
    gTpTransacaoPadrao := 1;
    gqtOperacao := 3;
  end;

  putitem_e(tTRA_TRANSACAO, 'TP_TRANSACAO', gTpTransacaoPadrao);

  return(0); exit;
end;

//--------------------------------------------------------------
function TF_TRAFM080.posicionaCursor(pParams : String) : String;
//--------------------------------------------------------------
const
  cDS_METHOD = 'ADICIONAL=Operação: TF_TRAFM080.posicionaCursor()';
var
  vInCodigo : Boolean;
begin
  if (empty(tTRA_TRANSITEM) = False) then begin
    setocc(tTRA_TRANSITEM, -1);
    gprompt := item_f('NR_ITEM', tTRA_TRANSITEM);
  end;

  vInCodigo := item_b('IN_CODIGO', tSIS_FILTRO);
  clear_e(tSIS_FILTRO);
  putitem_e(tSIS_FILTRO, 'IN_CODIGO', vInCodigo);

  if (item_f('TP_INCLUSAO', tTRA_TRANSACAO) = 'QUANTIDADE') then begin
    putitem_e(tSIS_FILTRO, 'QT_SOLICITADA', '');
    fieldsyntax item_f('QT_SOLICITADA', tSIS_FILTRO), '';
    gprompt := item_f('QT_SOLICITADA', tSIS_FILTRO);
  end else begin
    putitem_e(tSIS_FILTRO, 'QT_SOLICITADA', 1);
    fieldsyntax item_f('QT_SOLICITADA', tSIS_FILTRO), 'DIM';
    gprompt := item_f('CD_BARRAPRD', tSIS_FILTRO);
  end;

  return(0); exit;
end;

//-------------------------------------------------------------
function TF_TRAFM080.validaVendedor(pParams : String) : String;
//-------------------------------------------------------------
const
  cDS_METHOD = 'ADICIONAL=Operação: TF_TRAFM080.validaVendedor()';
var
  viParams, voParams, vDsErro : String;
begin
  viParams := '';
  putitemXml(viParams, 'CD_EMPRESA', item_f('CD_EMPRESA', tTRA_TRANSACAO));
  putitemXml(viParams, 'CD_AUXILIAR', item_f('CD_AUXILIAR', tPES_VENDEDOR));
  voParams := activateCmp('PESSVCO015', 'validaVendedor', viParams); (*,,,, *)
  if (xStatus < 0) then begin
    Result := voParams;
    return(-1); exit;
  end;

  clear_e(tPES_VENDEDOR);
  putitem_e(tPES_VENDEDOR, 'CD_VENDEDOR', itemXmlF('CD_VendEDOR', voParams));
  retrieve_e(tPES_VENDEDOR);

  return(0); exit;
end;

//---------------------------------------------------------
function TF_TRAFM080.validaItem(pParams : String) : String;
//---------------------------------------------------------
const
  cDS_METHOD = 'ADICIONAL=Operação: TF_TRAFM080.validaItem()';
var
  viParams, voParams, vDsErro, vDsRegistro, vDsLstProduto, vCdEmpresa, vDsTrasvco004 : String;
  vNrItem, vCdProduto, vQtEmbalagem, vCdGrupoEmpresa, vVlTransacao, vTpValidaVendedor, vQtSolicitada, vVlUnitLiquido : Real;
  vInLimiteCredito : Real;
  vInValidaItem : Boolean;
begin
  vInValidaItem := True;
  vInLimiteCredito := itemXmlB('IN_LIMITE_CREDITO_ITEM_VD', xParamEmp);

  if (item_b('IN_CODIGO', tSIS_FILTRO) <> True) then begin
    viParams := '';
    putitemXml(viParams, 'CD_BARRAPRD', item_f('CD_BARRAPRD', tSIS_FILTRO));
    putitemXml(viParams, 'IN_CODIGO', item_b('IN_CODIGO', tSIS_FILTRO));
    putitemXml(viParams, 'CD_EMPRESA', item_f('CD_EMPRESA', tTRA_TRANSACAO));
    voParams := activateCmp('PRDSVCO004', 'verificaProduto', viParams); (*,,,, *)
    if (xStatus < 0) then begin
      Result := voParams;
      return(-1); exit;
    end;
        repeat
          getitem(vDsRegistro, vDsLstProduto, 1);

          vCdProduto := itemXmlF('CD_PRODUTO', vDsRegistro);
          vQtEmbalagem := itemXmlF('QT_PRODUTO', vDsRegistro);
          vQtEmbalagem := vQtEmbalagem * item_f('QT_SOLICITADA', tSIS_FILTRO);

          viParams := '';

          if (gTpBuscaVlValeTroca = 1)  and (item_f('TP_MODALIDADE', tGER_OPERACAO) = 3)  and (item_f('TP_OPERACAO', tTRA_TRANSACAO) = 'E') then begin
            viParams := '';
            putitemXml(viParams, 'CD_EMPRESA', item_f('CD_EMPRESA', tTRA_TRANSACAO));
            putitemXml(viParams, 'NR_TRANSACAO', item_f('NR_TRANSACAO', tTRA_TRANSACAO));
            putitemXml(viParams, 'DT_TRANSACAO', item_a('DT_TRANSACAO', tTRA_TRANSACAO));
            putitemXml(viParams, 'CD_PRODUTO', vCdProduto);
            putitemXml(viParams, 'IN_CODIGO', True);
            //keyboard := 'KB_GLOBAL';
            voParams := activateCmp('TRAFP062', 'EXEC', viParams); (*,,, *)
            //keyboard := 'KB_PDV';
            if (xStatus < 0) then begin
              Result := voParams;
              return(-1); exit;
            end;

            viParams := '';
            putitemXml(viParams, 'VL_BRUTO', itemXmlF('VL_UNITBRUTO', voParams));
            putitemXml(viParams, 'VL_DESCONTO', itemXmlF('VL_UNITDESC', voParams));
            putitemXml(viParams, 'VL_LIQUIDO', itemXmlF('VL_UNITLIQUIDO', voParams));
          end;

          putitemXml(viParams, 'CD_EMPRESA', item_f('CD_EMPRESA', tTRA_TRANSACAO));
          putitemXml(viParams, 'NR_TRANSACAO', item_f('NR_TRANSACAO', tTRA_TRANSACAO));
          putitemXml(viParams, 'DT_TRANSACAO', item_a('DT_TRANSACAO', tTRA_TRANSACAO));
          putitemXml(viParams, 'CD_BARRAPRD', vCdProduto);
          putitemXml(viParams, 'IN_CODIGO', True);
            putitemXml(viParams, 'QT_SOLICITADA', vQtEmbalagem);
          putitemXml(viParams, 'CD_CFOP', item_f('CD_CFOP', tTRA_TRANSACAO));
          putitemXml(viParams, 'CD_CST', item_f('CD_CST', tTRA_TRANSACAO));
          putitemXml(viParams, 'CD_TABPRECO', gCdTabPreco);
          voParams := activateCmp('TRASVCO004', 'validaItemTransacao', viParams); (*,,,, *)
          if (xStatus < 0) then begin
            Result := voParams;
            return(-1); exit;
          end;

          vDsTrasvco004 := voParams;
          if (item_f('TP_TRANSACAO', tTRA_TRANSACAO) = 2)  and (gInValidaPrdValeTroca = True) then begin
            clear_e(tV_FIS_NFITEMPROD);

            putitem_e(tV_FIS_NFITEMPROD, 'CD_PRODUTO', vCdProduto);
            putitem_e(tV_FIS_NFITEMPROD, 'CD_PESSOA', item_f('CD_PESSOA', tTRA_TRANSACAO));
            putitem_e(tV_FIS_NFITEMPROD, 'TP_OPERACAO', 'S');
            putitem_e(tV_FIS_NFITEMPROD, 'TP_MODALIDADE', '4');
              putitem_e(tV_FIS_NFITEMPROD, 'TP_SITUACAO', 'N);
            retrieve_e(tV_FIS_NFITEMPROD);
            if (xStatus < 0) then begin
              Result := SetStatus(STS_ERROR, 'GEN0001', 'Produto ' + FloatToStr(vCdProduto) + ' nunca foi vendido para este cliente!', '');
              viParams := '';
              putitemXml(viParams, 'CD_COMPONENTE', TRAFM080);
              putitemXml(viParams, 'DS_CAMPO', 'IN_LIBERA_VALETROCA');
              putitemXml(viParams, 'CD_EMPRESA', itemXmlF('CD_EMPRESA', PARAM_GLB));
              putitemXml(viParams, 'CD_USUARIO', itemXmlF('CD_USUARIO', PARAM_GLB));
              putitemXml(viParams, 'VL_VALOR', '');
              voParams := activateCmp('ADMSVCO009', 'verificaRestricao', viParams); (*,,, *)
              if (xStatus < 0) then begin
                Result := voParams;
                return(-1); exit;
              end;
            end;

            clear_e(tV_FIS_NFITEMPROD);
          end;
          if (vInLimiteCredito > 0)  and (gVlLimite <> '') then begin
            vVlTransacao := item_f('VL_TRANSACAO', tTRA_TRANSACAO) + itemXmlF('VL_TOTALLIQUIDO', vDsTrasvco004);

            if (vVlTransacao > gVlLimite) then begin
              if (vInLimiteCredito = 1) then begin
                askmess/question 'Limite do cliente ultrapassado. Deseja continuar?', 'Não, Sim';
                if (xStatus = 1) then begin
                  gprompt := item_f('CD_BARRAPRD', tSIS_FILTRO);
                  return(-1); exit;
                end;
              end else if (vInLimiteCredito = 2) then begin
                viParams := '';
                putitemXml(viParams, 'CD_COMPONENTE', TRAFM080);
                putitemXml(viParams, 'DS_CAMPO', 'IN_LIBERA_LIMITE');
                putitemXml(viParams, 'CD_EMPRESA', itemXmlF('CD_EMPRESA', PARAM_GLB));
                putitemXml(viParams, 'CD_USUARIO', itemXmlF('CD_USUARIO', PARAM_GLB));
                putitemXml(viParams, 'VL_VALOR', '');
                voParams := activateCmp('ADMSVCO009', 'VerificaRestricao', viParams); (*,,, *)
                if (xStatus < 0) then begin
                  Result := voParams;
                  return(-1); exit;
                end;
              end;
            end;
          end;

          viParams := vDsTrasvco004;

          putitemXml(viParams, 'CD_EMPRESA', item_f('CD_EMPRESA', tTRA_TRANSACAO));
          putitemXml(viParams, 'NR_TRANSACAO', item_f('NR_TRANSACAO', tTRA_TRANSACAO));
          putitemXml(viParams, 'DT_TRANSACAO', item_a('DT_TRANSACAO', tTRA_TRANSACAO));

          if (item_f('TP_DOCTO', tGER_OPERACAO) = 3) then begin
            gvNrItem := gvNrItem + 1;
            putitemXml(viParams, 'NR_ITEM', gvNrItem);
          end;

          voParams := activateCmp('TRASVCO004', 'gravaItemTransacao', viParams); (*,,,, *)
          if (xStatus < 0) then begin
            Result := voParams;
            return(-1); exit;
          end;
          if (itemXml('DS_MENSAGEM', voParams) <> '') then begin
            message/info '' + itemXml('DS_MENSAGEM', + ' voParams)';
          end;

          vNrItem := itemXmlF('NR_ITEM', voParams);

          if (item_f('TP_DOCTO', tGER_OPERACAO) = 3) then begin
            if (gInCupomAberto = 'S') then begin
              viParams := '';
              putitemXml(viParams, 'CD_EMPRESA', item_f('CD_EMPRESA', tTRA_TRANSACAO));
              putitemXml(viParams, 'NR_TRANSACAO', item_f('NR_TRANSACAO', tTRA_TRANSACAO));
              putitemXml(viParams, 'DT_TRANSACAO', item_a('DT_TRANSACAO', tTRA_TRANSACAO));
              putitemXml(viParams, 'NR_ITEM', vNrItem);
              voParams := activateCmp('ECFSVCO010', 'lancaItemConcomitante', viParams); (*,,,, *)
              if (xStatus < 0) then begin
                Result := voParams;
                return(-1); exit;
              end;
                putitemXml(viParams, 'TITULO', 'Erro de comunicação com a ECF');
                putitemXml(viParams, 'MENSAGEM', itemXml('DESCRICAO', xCtxErro));
                voParams := activateCmp('GERFP008', 'EXEC', viParams); (*,,, *)
                if (xStatus < 0) then begin
                  Result := voParams;
                  return(-1); exit;
                end;
                rollback;
                gprompt := item_f('CD_BARRAPRD', tSIS_FILTRO);
                return(-1); exit;
              end else if (xStatus = -50) then begin
                Result := SetStatus(STS_ERROR, {xCdErro} '', '{xCtxErro} ''', '');
                apexit;
              end else if (xStatus < 0) then begin
                Result := SetStatus(STS_ERROR, {xCdErro} '', '{xCtxErro} ''', '');
                rollback;
                gprompt := item_f('CD_BARRAPRD', tSIS_FILTRO);
                return(-1); exit;
              end;
            end;

            creocc(tTMP_NR09, -1);
            putitem_e(tTMP_NR09, 'NR_GERAL', vNrItem);
          end;

          commit;
          if (xStatus < 0) then begin
            rollback;
            return(-1); exit;
          end else begin
            voParams := SetHint(viParams); (* 'ID=APLINFO002' *)
          end;

          clear_e(tSIS_PRODUTO);

          putitem_e(tSIS_PRODUTO, 'CD_PRODUTO', itemXmlF('CD_PRODUTO', vDsTrasvco004));
          putitem_e(tSIS_PRODUTO, 'DS_PRODUTO', itemXml('DS_PRODUTO', vDsTrasvco004));
          putitem_e(tSIS_PRODUTO, 'QT_SOLICITADA', itemXmlF('QT_SOLICITADA', vDsTrasvco004));
          putitem_e(tSIS_PRODUTO, 'VL_UNITARIO', itemXmlF('VL_UNITLIQUIDO', vDsTrasvco004));
          putitem_e(tSIS_PRODUTO, 'VL_TOTAL', itemXmlF('VL_TOTALLIQUIDO', vDsTrasvco004));

          if (gInImagem = True) then begin
            clear_e(tPRD_PRDIMAGEM);
            putitem_e(tPRD_PRDIMAGEM, 'CD_PRODUTO', item_f('CD_PRODUTO', tSIS_PRODUTO));
            putitem_e(tPRD_PRDIMAGEM, 'IN_PADRAO', True);
            retrieve_e(tPRD_PRDIMAGEM);
            if (xStatus >= 0) then begin
              putitem_e(tSIS_PRODUTO, 'CD_IMAGEM', item_f('CD_IMAGEM', tPRD_PRDIMAGEM));
            end else begin
              clear_e(tPRD_PRDIMAGEM);
              putitem_e(tPRD_PRDIMAGEM, 'CD_PRODUTO', item_f('CD_PRODUTO', tSIS_PRODUTO));
              retrieve_e(tPRD_PRDIMAGEM);
              if (xStatus >= 0) then begin
                putitem_e(tSIS_PRODUTO, 'CD_IMAGEM', item_f('CD_IMAGEM', tPRD_PRDIMAGEM));
              end;
            end;
          end;
          if (item_f('TP_MODALIDADE', tGER_OPERACAO) = 5) then begin
            setocc(tTRA_TRANSITEM, -1);
            voParams := alteraItem(viParams); (* *)
            if (xStatus < 0) then begin
              Result := voParams;
              return(-1); exit;
            end;
          end;

          delitem(vDsLstProduto, 1);
        until (vDsLstProduto = '');

        voParams := recarregaTransacao(viParams); (* *)
        if (xStatus < 0) then begin
          Result := voParams;
          return(-1); exit;
        end;
      end;
    end;
  end;
  if (vInValidaItem = True) then begin
    viParams := '';

    if (gTpBuscaVlValeTroca = 1)  and (item_f('TP_MODALIDADE', tGER_OPERACAO) = 3)  and (item_f('TP_OPERACAO', tTRA_TRANSACAO) = 'E') then begin
      viParams := '';
      putitemXml(viParams, 'CD_EMPRESA', item_f('CD_EMPRESA', tTRA_TRANSACAO));
      putitemXml(viParams, 'NR_TRANSACAO', item_f('NR_TRANSACAO', tTRA_TRANSACAO));
      putitemXml(viParams, 'DT_TRANSACAO', item_a('DT_TRANSACAO', tTRA_TRANSACAO));
      putitemXml(viParams, 'CD_PRODUTO', item_f('CD_BARRAPRD', tSIS_FILTRO));
      putitemXml(viParams, 'IN_CODIGO', item_b('IN_CODIGO', tSIS_FILTRO));
      //keyboard := 'KB_GLOBAL';
      voParams := activateCmp('TRAFP062', 'EXEC', viParams); (*,,, *)
      //keyboard := 'KB_PDV';
      if (xStatus < 0) then begin
        Result := voParams;
        return(-1); exit;
      end;

      viParams := '';
      putitemXml(viParams, 'VL_BRUTO', itemXmlF('VL_UNITBRUTO', voParams));
      putitemXml(viParams, 'VL_DESCONTO', itemXmlF('VL_UNITDESC', voParams));
      putitemXml(viParams, 'VL_LIQUIDO', itemXmlF('VL_UNITLIQUIDO', voParams));
    end;

    putitemXml(viParams, 'CD_EMPRESA', item_f('CD_EMPRESA', tTRA_TRANSACAO));
    putitemXml(viParams, 'NR_TRANSACAO', item_f('NR_TRANSACAO', tTRA_TRANSACAO));
    putitemXml(viParams, 'DT_TRANSACAO', item_a('DT_TRANSACAO', tTRA_TRANSACAO));
    putitemXml(viParams, 'CD_BARRAPRD', item_f('CD_BARRAPRD', tSIS_FILTRO));
    putitemXml(viParams, 'IN_CODIGO', item_b('IN_CODIGO', tSIS_FILTRO));
    if (item_f('TP_INCLUSAO', tTRA_TRANSACAO) = 'QUANTIDADE') then begin
      putitemXml(viParams, 'QT_SOLICITADA', item_f('QT_SOLICITADA', tSIS_FILTRO));
    end;
    putitemXml(viParams, 'CD_CFOP', item_f('CD_CFOP', tTRA_TRANSACAO));
    putitemXml(viParams, 'CD_CST', item_f('CD_CST', tTRA_TRANSACAO));
    putitemXml(viParams, 'CD_TABPRECO', gCdTabPreco);
    voParams := activateCmp('TRASVCO004', 'validaItemTransacao', viParams); (*,,,, *)
    if (xStatus < 0) then begin
      Result := voParams;
      return(-1); exit;
    end;

    vDsTrasvco004 := voParams;
    vCdProduto := itemXmlF('CD_PRODUTO', voParams);
    vVlUnitLiquido := itemXmlF('VL_UNITLIQUIDO', voParams);
    vQtSolicitada := itemXmlF('QT_SOLICITADA', voParams);

    if (item_f('TP_TRANSACAO', tTRA_TRANSACAO) = 2)  and (gInValidaPrdValeTroca = True) then begin
      clear_e(tV_FIS_NFITEMPROD);

      putitem_e(tV_FIS_NFITEMPROD, 'CD_PRODUTO', vCdProduto);
      putitem_e(tV_FIS_NFITEMPROD, 'CD_PESSOA', item_f('CD_PESSOA', tTRA_TRANSACAO));
      putitem_e(tV_FIS_NFITEMPROD, 'TP_OPERACAO', 'S');
      putitem_e(tV_FIS_NFITEMPROD, 'TP_MODALIDADE', '4');
      putitem_e(tV_FIS_NFITEMPROD, 'TP_SITUACAO', 'N);
      retrieve_e(tV_FIS_NFITEMPROD);
      if (xStatus < 0) then begin
        Result := SetStatus(STS_ERROR, 'GEN0001', 'Produto ' + FloatToStr(vCdProduto) + ' nunca foi vendido para este cliente!', '');
        viParams := '';
        putitemXml(viParams, 'CD_COMPONENTE', TRAFM080);
        putitemXml(viParams, 'DS_CAMPO', 'IN_LIBERA_VALETROCA');
        putitemXml(viParams, 'CD_EMPRESA', itemXmlF('CD_EMPRESA', PARAM_GLB));
        putitemXml(viParams, 'CD_USUARIO', itemXmlF('CD_USUARIO', PARAM_GLB));
        putitemXml(viParams, 'VL_VALOR', '');
        voParams := activateCmp('ADMSVCO009', 'verificaRestricao', viParams); (*,,, *)
        if (xStatus < 0) then begin
          Result := voParams;
          return(-1); exit;
        end;
      end;

      clear_e(tV_FIS_NFITEMPROD);
    end;
    if (item_f('TP_OPERACAO', tGER_OPERACAO) = 'S') then begin
      if (gTpCoeficientePrdVd = 01)  and (item_f('TP_MODALIDADE', tGER_OPERACAO) = 4) then begin
        voParams := validaItemCoeficiente(viParams); (* vCdProduto, vVlUnitLiquido, vQtSolicitada *)
        if (xStatus < 0) then begin
          Result := voParams;
          return(-1); exit;
        end;

        viParams := '';
        putitemXml(viParams, 'CD_EMPRESA', item_f('CD_EMPRESA', tTRA_TRANSACAO));
        putitemXml(viParams, 'NR_TRANSACAO', item_f('NR_TRANSACAO', tTRA_TRANSACAO));
        putitemXml(viParams, 'DT_TRANSACAO', item_a('DT_TRANSACAO', tTRA_TRANSACAO));
        putitemXml(viParams, 'CD_BARRAPRD', vCdProduto);
        putitemXml(viParams, 'IN_CODIGO', True);
        putitemXml(viParams, 'QT_SOLICITADA', vQtSolicitada);
        putitemXml(viParams, 'CD_CFOP', item_f('CD_CFOP', tTRA_TRANSACAO));
        putitemXml(viParams, 'CD_CST', item_f('CD_CST', tTRA_TRANSACAO));
        putitemXml(viParams, 'VL_BRUTO', vVlUnitLiquido);
        putitemXml(viParams, 'VL_LIQUIDO', vVlUnitLiquido);
        putitemXml(viParams, 'CD_TABPRECO', gCdTabPreco);
        voParams := activateCmp('TRASVCO004', 'validaItemTransacao', viParams); (*,,,, *)
        if (xStatus < 0) then begin
          Result := voParams;
          return(-1); exit;
        end;

        vDsTrasvco004 := voParams;
      end;
    end;
    if (vInLimiteCredito > 0)  and (gVlLimite <> '') then begin
      vVlTransacao := item_f('VL_TRANSACAO', tTRA_TRANSACAO) + itemXmlF('VL_TOTALLIQUIDO', vDsTrasvco004);

      if (vVlTransacao > gVlLimite) then begin
        if (vInLimiteCredito = 1) then begin
          askmess/question 'Limite do cliente ultrapassado. Deseja continuar?', 'Não, Sim';
          if (xStatus = 1) then begin
            gprompt := item_f('CD_BARRAPRD', tSIS_FILTRO);
            return(-1); exit;
          end;
        end else if (vInLimiteCredito = 2) then begin
          viParams := '';
          putitemXml(viParams, 'CD_COMPONENTE', TRAFM080);
          putitemXml(viParams, 'DS_CAMPO', 'IN_LIBERA_LIMITE');
          putitemXml(viParams, 'CD_EMPRESA', itemXmlF('CD_EMPRESA', PARAM_GLB));
          putitemXml(viParams, 'CD_USUARIO', itemXmlF('CD_USUARIO', PARAM_GLB));
          putitemXml(viParams, 'VL_VALOR', '');
          voParams := activateCmp('ADMSVCO009', 'VerificaRestricao', viParams); (*,,, *)
          if (xStatus < 0) then begin
            Result := voParams;
            return(-1); exit;
          end;
        end;
      end;
    end;

    viParams := vDsTrasvco004;

    putitemXml(viParams, 'CD_EMPRESA', item_f('CD_EMPRESA', tTRA_TRANSACAO));
    putitemXml(viParams, 'NR_TRANSACAO', item_f('NR_TRANSACAO', tTRA_TRANSACAO));
    putitemXml(viParams, 'DT_TRANSACAO', item_a('DT_TRANSACAO', tTRA_TRANSACAO));

    if (item_f('TP_DOCTO', tGER_OPERACAO) = 3) then begin
      gvNrItem := gvNrItem + 1;
      putitemXml(viParams, 'NR_ITEM', gvNrItem);
    end;

    voParams := activateCmp('TRASVCO004', 'gravaItemTransacao', viParams); (*,,,, *)
    if (xStatus < 0) then begin
      Result := voParams;
      return(-1); exit;
    end;
    if (itemXml('DS_MENSAGEM', voParams) <> '') then begin
      message/info '' + itemXml('DS_MENSAGEM', + ' voParams)';
    end;

    vNrItem := itemXmlF('NR_ITEM', voParams);

    if (item_f('TP_DOCTO', tGER_OPERACAO) = 3) then begin
      if (gInCupomAberto = 'S') then begin
        viParams := '';
        putitemXml(viParams, 'CD_EMPRESA', item_f('CD_EMPRESA', tTRA_TRANSACAO));
        putitemXml(viParams, 'NR_TRANSACAO', item_f('NR_TRANSACAO', tTRA_TRANSACAO));
        putitemXml(viParams, 'DT_TRANSACAO', item_a('DT_TRANSACAO', tTRA_TRANSACAO));
        putitemXml(viParams, 'NR_ITEM', vNrItem);
        voParams := activateCmp('ECFSVCO010', 'lancaItemConcomitante', viParams); (*,,,, *)
        if (xStatus < 0) then begin
          Result := voParams;
          return(-1); exit;
        end;
          putitemXml(viParams, 'TITULO', 'Erro de comunicação com a ECF');
          putitemXml(viParams, 'MENSAGEM', itemXml('DESCRICAO', xCtxErro));
          voParams := activateCmp('GERFP008', 'EXEC', viParams); (*,,, *)
          if (xStatus < 0) then begin
            Result := voParams;
            return(-1); exit;
          end;
          rollback;
          gprompt := item_f('CD_BARRAPRD', tSIS_FILTRO);
          return(-1); exit;
        end else if (xStatus = -50) then begin
          Result := SetStatus(STS_ERROR, {xCdErro} '', '{xCtxErro} ''', '');
          apexit;
        end else if (xStatus < 0) then begin
          Result := SetStatus(STS_ERROR, {xCdErro} '', '{xCtxErro} ''', '');
          rollback;
          gprompt := item_f('CD_BARRAPRD', tSIS_FILTRO);
          return(-1); exit;
        end;
      end;

      creocc(tTMP_NR09, -1);
      putitem_e(tTMP_NR09, 'NR_GERAL', vNrItem);
    end;

    commit;
    if (xStatus < 0) then begin
      rollback;
      return(-1); exit;
    end else begin
      voParams := SetHint(viParams); (* 'ID=APLINFO002' *)
    end;

    clear_e(tSIS_PRODUTO);

    putitem_e(tSIS_PRODUTO, 'CD_PRODUTO', itemXmlF('CD_PRODUTO', vDsTrasvco004));
    putitem_e(tSIS_PRODUTO, 'DS_PRODUTO', itemXml('DS_PRODUTO', vDsTrasvco004));
    putitem_e(tSIS_PRODUTO, 'QT_SOLICITADA', itemXmlF('QT_SOLICITADA', vDsTrasvco004));
    putitem_e(tSIS_PRODUTO, 'VL_UNITARIO', itemXmlF('VL_UNITLIQUIDO', vDsTrasvco004));
    putitem_e(tSIS_PRODUTO, 'VL_TOTAL', itemXmlF('VL_TOTALLIQUIDO', vDsTrasvco004));

    if (gInImagem = True) then begin
      clear_e(tPRD_PRDIMAGEM);
      putitem_e(tPRD_PRDIMAGEM, 'CD_PRODUTO', item_f('CD_PRODUTO', tSIS_PRODUTO));
      putitem_e(tPRD_PRDIMAGEM, 'IN_PADRAO', True);
      retrieve_e(tPRD_PRDIMAGEM);
      if (xStatus >= 0) then begin
        putitem_e(tSIS_PRODUTO, 'CD_IMAGEM', item_f('CD_IMAGEM', tPRD_PRDIMAGEM));
      end else begin
        clear_e(tPRD_PRDIMAGEM);
        putitem_e(tPRD_PRDIMAGEM, 'CD_PRODUTO', item_f('CD_PRODUTO', tSIS_PRODUTO));
        retrieve_e(tPRD_PRDIMAGEM);
        if (xStatus >= 0) then begin
          putitem_e(tSIS_PRODUTO, 'CD_IMAGEM', item_f('CD_IMAGEM', tPRD_PRDIMAGEM));
        end;
      end;
    end;
    voParams := recarregaTransacao(viParams); (* *)
    if (xStatus < 0) then begin
      Result := voParams;
      return(-1); exit;
    end;
    if (item_f('TP_MODALIDADE', tGER_OPERACAO) = 5) then begin
      setocc(tTRA_TRANSITEM, -1);
      voParams := alteraItem(viParams); (* *)
      if (xStatus < 0) then begin
        Result := voParams;
        return(-1); exit;
      end;
    end;
  end;

  vTpValidaVendedor := itemXmlF('TP_VALIDA_VENEDOR_VD', xParamEmp);

  if (vTpValidaVendedor = 1) %\ then begin
   and ((putitem_e(tGER_OPERACAO, 'TP_MODALIDADE', 4 ) and (item_f('TP_OPERACAO', tGER_OPERACAO), 'S')
   or (putitem_e(tGER_OPERACAO, 'TP_MODALIDADE', 3 ) and (item_f('TP_OPERACAO', tGER_OPERACAO), 'E')
   or (putitem_e(tGER_OPERACAO, 'TP_MODALIDADE', 8)));
    gCdCompVend := item_f('CD_COMPVEND', tTRA_TRANSACAO);

    voParams := BT_05(viParams); (* *)
    if (xStatus < 0) then begin
      Result := voParams;
      return(-1); exit;
    end;

    gInFocoVendedor := True;
  end;

  gprompt := item_f('TP_TRANSACAO', tTRA_TRANSACAO);

  return(0); exit;
end;

//---------------------------------------------------------------
function TF_TRAFM080.validaQuantidade(pParams : String) : String;
//---------------------------------------------------------------
const
  cDS_METHOD = 'ADICIONAL=Operação: TF_TRAFM080.validaQuantidade()';
var
  vDsMsg : String;
begin
  if (item_f('QT_SOLICITADA', tSIS_FILTRO) > 100) then begin
    vDsMsg := 'Quantidade maior que 100Continuar?';
    repeat
      askmess vDsMsg, 'Não, Sim';
    until (xStatus := 2);
  end;

  return(0); exit;
end;

//---------------------------------------------------------
function TF_TRAFM080.alteraItem(pParams : String) : String;
//---------------------------------------------------------
const
  cDS_METHOD = 'ADICIONAL=Operação: TF_TRAFM080.alteraItem()';
var
  viParams, voParams : String;
  vInLimiteCredito : Real;
begin
  vInLimiteCredito := itemXmlB('IN_LIMITE_CREDITO_ITEM_VD', xParamEmp);

  viParams := '';
  putlistitensocc_e(viParams, tTRA_TRANSITEM);
  putitemXml(viParams, 'TP_ALTERAITEM', item_f('TP_ALTERAITEM', tTRA_TRANSACAO));
  putitemXml(viParams, 'IN_LIMITECREDITO', vInLimiteCredito);
  putitemXml(viParams, 'VL_LIMITE', gVlLimite);
  putitemXml(viParams, 'VL_TRANSACAO', item_f('VL_TRANSACAO', tTRA_TRANSACAO));
  //keyboard := 'KB_GLOBAL';
  voParams := activateCmp('TRAFM071', 'EXEC', viParams); (*,,, *)
  //keyboard := 'KB_PDV';

  if (xStatus < 0) then begin
    return(-1); exit;
  end;

  putitem_e(tTRA_TRANSACAO, 'CD_CFOP', itemXmlF('CD_CFOP', voParams));
  putitem_e(tTRA_TRANSACAO, 'CD_CST', itemXmlF('CD_CST', voParams));

  viParams := voParams;
  voParams := activateCmp('TRASVCO004', 'gravaItemTransacao', viParams); (*,,,, *)
  if (xStatus < 0) then begin
    Result := voParams;
    return(-1); exit;
  end;
  if (itemXml('DS_MENSAGEM', voParams) <> '') then begin
    message/info '' + itemXml('DS_MENSAGEM', + ' voParams)';
  end;

  commit;
  if (xStatus < 0) then begin
    rollback;
    return(-1); exit;
  end else begin
    voParams := SetHint(viParams); (* 'ID=APLINFO002' *)
  end;

  voParams := recarregaTransacao(viParams); (* *)
  if (xStatus < 0) then begin
    Result := voParams;
    return(-1); exit;
  end;

  gprompt := item_f('TP_TRANSACAO', tTRA_TRANSACAO);

  return(0); exit;
end;

//---------------------------------------------------------
function TF_TRAFM080.agrupaItem(pParams : String) : String;
//---------------------------------------------------------
const
  cDS_METHOD = 'ADICIONAL=Operação: TF_TRAFM080.agrupaItem()';
var
  (* boolean vInConfirmacao : IN *)
  viParams, voParams, vDsErro : String;
begin
  if (item_f('TP_DOCTO', tGER_OPERACAO) = 3) then begin
    return(0); exit;
  end;
  if (vInConfirmacao = True) then begin
    askmess 'Deseja agrupar os itens da transação?', 'Sim, Não';
    if (xStatus = 2) then begin
      return(-1); exit;
    end;
  end;

  viParams := '';
  putitemXml(viParams, 'CD_EMPRESA', item_f('CD_EMPRESA', tTRA_TRANSACAO));
  putitemXml(viParams, 'NR_TRANSACAO', item_f('NR_TRANSACAO', tTRA_TRANSACAO));
  putitemXml(viParams, 'DT_TRANSACAO', item_a('DT_TRANSACAO', tTRA_TRANSACAO));
  voParams := activateCmp('TRASVCO010', 'agrupaItemTransacao', viParams); (*,,,, *)

  commit;
  if (xStatus < 0) then begin
    rollback;
    return(-1); exit;
  end else begin
    voParams := SetHint(viParams); (* 'ID=APLINFO002' *)
  end;

  voParams := recarregaTransacao(viParams); (* *)
  if (xStatus < 0) then begin
    Result := voParams;
    return(-1); exit;
  end;

  return(0); exit;
end;

//-------------------------------------------------------------
function TF_TRAFM080.relacionaTroca(pParams : String) : String;
//-------------------------------------------------------------
const
  cDS_METHOD = 'ADICIONAL=Operação: TF_TRAFM080.relacionaTroca()';
var
  viParams, voParams, vDsRegTroca : String;
  vCdEmpresaDev, vNrTransacaoDev : Real;
  vDtTransacaoDev : TDate;
begin
  viParams := '';
  putitemXml(viParams, 'CD_EMPRESA', item_f('CD_EMPRESA', tTRA_TRANSACAO));
  putitemXml(viParams, 'NR_TRANSACAO', item_f('NR_TRANSACAO', tTRA_TRANSACAO));
  putitemXml(viParams, 'DT_TRANSACAO', item_a('DT_TRANSACAO', tTRA_TRANSACAO));
  //keyboard := 'KB_GLOBAL';
  voParams := activateCmp('TRAFM082', 'EXEC', viParams); (*,,, *)
  //keyboard := 'KB_PDV';
  if (xStatus < 0) then begin
    return(-1); exit;
  end;

  vCdEmpresaDev := itemXmlF('CD_EMPRESA', voParams);
  vNrTransacaoDev := itemXmlF('NR_TRANSACAO', voParams);
  vDtTransacaoDev := itemXml('DT_TRANSACAO', voParams);

  if (vNrTransacaoDev = 0) then begin
    return(-1); exit;
  end;

  viParams := '';
  putitemXml(viParams, 'CD_EMPDEV', vCdEmpresaDev);
  putitemXml(viParams, 'NR_TRADEV', vNrTransacaoDev);
  putitemXml(viParams, 'DT_TRADEV', vDtTransacaoDev);
  putitemXml(viParams, 'CD_EMPVEN', item_f('CD_EMPRESA', tTRA_TRANSACAO));
  putitemXml(viParams, 'NR_TRAVEN', item_f('NR_TRANSACAO', tTRA_TRANSACAO));
  putitemXml(viParams, 'DT_TRAVEN', item_a('DT_TRANSACAO', tTRA_TRANSACAO));
  voParams := activateCmp('TRASVCO016', 'gravaTrocaTransacao', viParams); (*,,,, *)

  commit;
  if (xStatus < 0) then begin
    rollback;
    return(-1); exit;
  end else begin
    voParams := SetHint(viParams); (* 'ID=APLINFO002' *)
  end;

  return(0); exit;
end;

//-----------------------------------------------------------------
function TF_TRAFM080.recarregaTransacao(pParams : String) : String;
//-----------------------------------------------------------------
const
  cDS_METHOD = 'ADICIONAL=Operação: TF_TRAFM080.recarregaTransacao()';
var
  vTpFoco, vTpInclusao, vTpAlteraItem, vDsProduto : String;
  vCdEmpresa, vNrTransacao, vNrOcc, vTpTransacao, vCdPessoa : Real;
  vCdProduto, vCdImagem, vQtSolicitada, vVlUnitario, vVlTotal : Real;
  vDtTransacao : TDate;
  vInCodigo : Boolean;
begin
  vCdEmpresa := item_f('CD_EMPRESA', tTRA_TRANSACAO);
  vNrTransacao := item_f('NR_TRANSACAO', tTRA_TRANSACAO);
  vDtTransacao := item_a('DT_TRANSACAO', tTRA_TRANSACAO);
  vCdPessoa := item_f('CD_PESSOA', tTRA_TRANSACAO);
  vTpFoco := item_f('TP_FOCO', tTRA_TRANSACAO);
  vTpInclusao := item_f('TP_INCLUSAO', tTRA_TRANSACAO);
  vTpAlteraItem := item_f('TP_ALTERAITEM', tTRA_TRANSACAO);
  vTpTransacao := item_f('TP_TRANSACAO', tTRA_TRANSACAO);
  vInCodigo := item_b('IN_CODIGO', tSIS_FILTRO);
  vCdProduto := item_f('CD_PRODUTO', tSIS_PRODUTO);
  vDsProduto := item_a('DS_PRODUTO', tSIS_PRODUTO);
  vCdImagem := item_f('CD_IMAGEM', tSIS_PRODUTO);
  vQtSolicitada := item_f('QT_SOLICITADA', tSIS_PRODUTO);
  vVlUnitario := item_f('VL_UNITARIO', tSIS_PRODUTO);
  vVlTotal := item_f('VL_TOTAL', tSIS_PRODUTO);
  vNrOcc := curocc(tTRA_TRANSITEM);

  clear_e(tTRA_TRANSACAO);
  putitem_e(tTRA_TRANSACAO, 'CD_EMPRESA', vCdEmpresa);
  putitem_e(tTRA_TRANSACAO, 'NR_TRANSACAO', vNrTransacao);
  putitem_e(tTRA_TRANSACAO, 'DT_TRANSACAO', vDtTransacao);
  retrieve_e(tTRA_TRANSACAO);
  if (xStatus >= 0) then begin
    putitem_e(tTRA_TRANSACAO, 'TP_FOCO', vTpFoco);
    putitem_e(tTRA_TRANSACAO, 'TP_INCLUSAO', vTpInclusao);
    putitem_e(tTRA_TRANSACAO, 'TP_ALTERAITEM', vTpAlteraItem);
    putitem_e(tTRA_TRANSACAO, 'TP_TRANSACAO', vTpTransacao);
    putitem_e(tSIS_FILTRO, 'IN_CODIGO', vInCodigo);
    putitem_e(tSIS_PRODUTO, 'CD_PRODUTO', vCdProduto);
    putitem_e(tSIS_PRODUTO, 'DS_PRODUTO', vDsProduto);
    putitem_e(tSIS_PRODUTO, 'CD_IMAGEM', vCdImagem);
    putitem_e(tSIS_PRODUTO, 'QT_SOLICITADA', vQtSolicitada);
    putitem_e(tSIS_PRODUTO, 'VL_UNITARIO', vVlUnitario);
    putitem_e(tSIS_PRODUTO, 'VL_TOTAL', vVlTotal);
    if (item_f('CD_IMAGEM', tSIS_PRODUTO) > 0) then begin
      clear_e(tPRD_IMAGEM);
      putitem_e(tPRD_IMAGEM, 'CD_IMAGEM', item_f('CD_IMAGEM', tSIS_PRODUTO));
      retrieve_e(tPRD_IMAGEM);
      if (xStatus >= 0) then begin
        putitem_e(tSIS_IMAGEM, 'DS_IMAGEM', item_a('DS_ARQUIVO', tPRD_IMAGEM));
      end;
    end;
    if (vCdPessoa <> item_f('CD_PESSOA', tTRA_TRANSACAO))  and (item_f('CD_PESSOA', tTRA_TRANSACAO) <> gCdCliente) then begin
      voParams := buscaAniversario(viParams); (* *)
      if (xStatus < 0) then begin
        Result := voParams;
        return(-1); exit;
      end;
    end;

    setocc(tTRA_TRANSITEM, 1);
  end;

  return(0); exit;
end;

//-------------------------------------------------------------------
function TF_TRAFM080.carregaDadosIniciais(pParams : String) : String;
//-------------------------------------------------------------------
const
  cDS_METHOD = 'ADICIONAL=Operação: TF_TRAFM080.carregaDadosIniciais()';
var
  viParams, voParams : String;
begin
  if (gInConferente = 1) then begin
    if (itemXml('CD_USUCONF', PARAM_GLB) < 1) then begin
      //keyboard := 'KB_GLOBAL';
      voParams := activateCmp('GERFM039', 'EXEC', viParams); (*,,, *)
      //keyboard := 'KB_PDV';
      if (xStatus < 0) then begin
        return(-1); exit;
      end;
    end;
    if (itemXml('CD_USUCONF', PARAM_GLB) >= 1) then begin
      clear_e(tADM_USUARIO);
      putitem_e(tADM_USUARIO, 'CD_USUARIO', itemXmlF('CD_USUCONF', PARAM_GLB));
      retrieve_e(tADM_USUARIO);

      if (xStatus >= 0) then begin
        if (item_f('CD_USUARIO', tADM_USUARIO) > 0) then begin
          viParams := '';

          putitemXml(viParams, 'CD_USUARIO', item_f('CD_USUARIO', tADM_USUARIO));
          voParams := activateCmp('ADMSVCO027', 'validaUsuarioEspecial', viParams); (*,,,, *)
          if (xStatus < 0) then begin
            Result := voParams;
            return(-1); exit;
          end;
          if (voParams <> '') then begin
            gDsConferente := itemXml('NM_LOGIN', voParams);
          end;
        end else begin
          gDsConferente := '';
        end;
      end;
    end else begin
      clear_e(tADM_USUARIO);
      putitem_e(tADM_USUARIO, 'CD_USUARIO', itemXmlF('CD_USUARIO', PARAM_GLB));
      retrieve_e(tADM_USUARIO);

      if (xStatus >= 0) then begin
        if (item_f('CD_USUARIO', tADM_USUARIO) > 0) then begin
          viParams := '';

          putitemXml(viParams, 'CD_USUARIO', item_f('CD_USUARIO', tADM_USUARIO));
          voParams := activateCmp('ADMSVCO027', 'validaUsuarioEspecial', viParams); (*,,,, *)
          if (xStatus < 0) then begin
            Result := voParams;
            return(-1); exit;
          end;
          if (voParams <> '') then begin
            gDsConferente := itemXml('NM_LOGIN', voParams);
          end;
        end else begin
          gDsConferente := '';
        end;
      end;
    end;
  end;

  clear_e(tADM_USUARIO);
  putitem_e(tADM_USUARIO, 'CD_USUARIO', itemXmlF('CD_USUARIO', PARAM_GLB));
  retrieve_e(tADM_USUARIO);
  if (xStatus < 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Código do usuário não encontrado!', '');
    return(-1); exit;
  end else begin

    if (item_f('CD_USUARIO', tADM_USUARIO) > 0) then begin
      viParams := '';

      putitemXml(viParams, 'CD_USUARIO', item_f('CD_USUARIO', tADM_USUARIO));
      voParams := activateCmp('ADMSVCO027', 'validaUsuarioEspecial', viParams); (*,,,, *)
      if (xStatus < 0) then begin
        Result := voParams;
        return(-1); exit;
      end;
      if (voParams <> '') then begin
        gDsCaixa := itemXml('NM_LOGIN', voParams);
      end;
    end else begin
      gDsCaixa := '';
    end;
  end;
  if (itemXml('CD_TERMINAL', PARAM_GLB) <> '') then begin
    clear_e(tGER_TERMINAL);
    putitem_e(tGER_TERMINAL, 'CD_EMPRESA', itemXmlF('CD_EMPRESA', PARAM_GLB));
    putitem_e(tGER_TERMINAL, 'CD_TERMINAL', itemXmlF('CD_TERMINAL', PARAM_GLB));
    retrieve_e(tGER_TERMINAL);
    gDsTerminal := item_a('DS_TERMINAL', tGER_TERMINAL);
  end;

  gCdUsuarioDesc := '';
  gNrCartao := '';

  return(0); exit;
end;

//--------------------------------------------------------
function TF_TRAFM080.BT_CTRL_A(pParams : String) : String;
//--------------------------------------------------------
const
  cDS_METHOD = 'ADICIONAL=Operação: TF_TRAFM080.BT_CTRL_A()';
var
  viParams, voParams : String;
  vNrTransacao : Real;
begin
  viParams := '';
  voParams := activateCmp('FCXFM004', 'EXEC', viParams); (*,,, *)
  if (xStatus < 0) then begin
    Result := voParams;
    return(-1); exit;
  end;

  return(0); exit;
end;

//--------------------------------------------------------
function TF_TRAFM080.BT_CTRL_D(pParams : String) : String;
//--------------------------------------------------------
const
  cDS_METHOD = 'ADICIONAL=Operação: TF_TRAFM080.BT_CTRL_D()';
var
  viParams, voParams : String;
  vNrTransacao : Real;
begin
  viParams := '';
  voParams := activateCmp('FCXFM005', 'EXEC', viParams); (*,,, *)
  if (xStatus < 0) then begin
    Result := voParams;
    return(-1); exit;
  end;

  return(0); exit;
end;

//--------------------------------------------------------
function TF_TRAFM080.BT_CTRL_G(pParams : String) : String;
//--------------------------------------------------------
const
  cDS_METHOD = 'ADICIONAL=Operação: TF_TRAFM080.BT_CTRL_G()';
var
  viParams, voParams : String;
  vNrTransacao : Real;
begin
  viParams := '';
  putlistitensocc_e(viParams, tTRA_TRANSACAO);
  voParams := activateCmp('TRASVCO004', 'gravaCapaTransacao', viParams); (*,,,, *)

  commit;
  if (xStatus < 0) then begin
    rollback;
    return(-1); exit;
  end else begin
    voParams := SetHint(viParams); (* 'ID=APLINFO002' *)
  end;
  if (item_f('NR_TRANSACAO', tTRA_TRANSACAO) = 0) then begin
    vNrTransacao := itemXmlF('NR_TRANSACAO', voParams);
    putitem_e(tTRA_TRANSACAO, 'NR_TRANSACAO', vNrTransacao);
  end;

  viParams := '';
  putitemXml(viParams, 'CD_EMPRESA', item_f('CD_EMPRESA', tTRA_TRANSACAO));
  putitemXml(viParams, 'NR_TRANSACAO', item_f('NR_TRANSACAO', tTRA_TRANSACAO));
  putitemXml(viParams, 'DT_TRANSACAO', item_a('DT_TRANSACAO', tTRA_TRANSACAO));
  //keyboard := 'KB_GLOBAL';
  voParams := activateCmp('TRAFM081', 'EXEC', viParams); (*,,, *)
  //keyboard := 'KB_PDV';

  commit;
  if (xStatus < 0) then begin
    rollback;
    return(-1); exit;
  end else begin
    voParams := SetHint(viParams); (* 'ID=APLINFO002' *)
  end;

  voParams := recarregaTransacao(viParams); (* *)
  if (xStatus < 0) then begin
    Result := voParams;
    return(-1); exit;
  end;

  gprompt := item_f('TP_TRANSACAO', tTRA_TRANSACAO);

  return(0); exit;
end;

//--------------------------------------------------------
function TF_TRAFM080.BT_CTRL_S(pParams : String) : String;
//--------------------------------------------------------
const
  cDS_METHOD = 'ADICIONAL=Operação: TF_TRAFM080.BT_CTRL_S()';
var
  viParams, voParams : String;
  vNrTransacao : Real;
begin
  viParams := '';
  voParams := activateCmp('FCXFM006', 'EXEC', viParams); (*,,, *)
  if (xStatus < 0) then begin
    Result := voParams;
    return(-1); exit;
  end;

  return(0); exit;
end;

//-------------------------------------------------------------
function TF_TRAFM080.entradaColetor(pParams : String) : String;
//-------------------------------------------------------------
const
  cDS_METHOD = 'ADICIONAL=Operação: TF_TRAFM080.entradaColetor()';
var
  (* string vDsLstColetor : IN *)
  viParams, voParams, vCdBarra, vDsRegistro : String;
  vCdProduto, vQtSolicitada, vNrSeq : Real;
  vDtTransacao : TDate;
begin
  if (empty(tTRA_TRANSITEM) = False) then begin
    setocc(tTRA_TRANSITEM, -1);
    vNrSeq := item_f('NR_ITEM', tTRA_TRANSITEM) + 1;
  end else begin
    vNrSeq := 1;
  end;

  repeat
    vDsRegistro := '';
    getitem(vDsRegistro, vDsLstColetor, 1);
    vCdProduto := itemXmlF('CD_PRODUTO', vDsRegistro);
    vCdBarra := itemXmlF('CD_BARRAPRD', vDsRegistro);
    vQtSolicitada := itemXmlF('QT_COLETA', vDsRegistro);
    viParams := '';
    putitemXml(viParams, 'CD_EMPRESA', item_f('CD_EMPRESA', tTRA_TRANSACAO));
    putitemXml(viParams, 'NR_TRANSACAO', item_f('NR_TRANSACAO', tTRA_TRANSACAO));
    putitemXml(viParams, 'DT_TRANSACAO', item_a('DT_TRANSACAO', tTRA_TRANSACAO));
    if (gTpUtilizaEtiqRfidPdv > 0) then begin
      putitemXml(viParams, 'CD_BARRAPRD', vCdBarra);
      putitemXml(viParams, 'IN_CODIGO', False);
    end else begin
      putitemXml(viParams, 'CD_BARRAPRD', vCdProduto);
      putitemXml(viParams, 'IN_CODIGO', True);
    end;
    putitemXml(viParams, 'QT_SOLICITADA', vQtSolicitada);
    putitemXml(viParams, 'CD_TABPRECO', gCdTabPreco);
    voParams := activateCmp('TRASVCO004', 'validaItemTransacao', viParams); (*,,,, *)
    if (xStatus < 0) then begin
      Result := SetStatus(STS_ERROR, {xCdErro} '', '{xCtxErro} ''', '');
    end;
    if (xStatus >= 0) then begin
      clear_e(tTRA_TRANSITEM);
      creocc(tTRA_TRANSITEM, -1);
      getlistitensocc_e(voParams, tTRA_TRANSITEM);
      putitem_e(tTRA_TRANSITEM, 'NR_ITEM', vNrSeq);
      putitem_e(tTRA_TRANSITEM, 'CD_EMPFAT', item_f('CD_EMPFAT', tTRA_TRANSACAO));
      putitem_e(tTRA_TRANSITEM, 'CD_GRUPOEMPRESA', item_f('CD_GRUPOEMPRESA', tTRA_TRANSACAO));

      viParams := '';
      putlistitensocc_e(viParams, tTRA_TRANSITEM);
      voParams := activateCmp('TRASVCO004', 'gravaItemTransacao', viParams); (*,,,, *)
      if (xStatus < 0) then begin
        Result := voParams;
        return(-1); exit;
      end;
      if (itemXml('DS_MENSAGEM', voParams) <> '') then begin
        message/info '' + itemXml('DS_MENSAGEM', + ' voParams)';
      end;

      commit;
      if (xStatus < 0) then begin
        rollback;
      end else begin
        voParams := SetHint(viParams); (* 'ID=APLINFO002' *)
      end;
    end;

    vNrSeq := vNrSeq + 1;

    delitem(vDsLstColetor, 1);
  until (vDsLstColetor = '');

  return(0); exit;
end;

//---------------------------------------------------------
function TF_TRAFM080.observacao(pParams : String) : String;
//---------------------------------------------------------
const
  cDS_METHOD = 'ADICIONAL=Operação: TF_TRAFM080.observacao()';
var
  viParams, voParams : String;
begin
  viParams := '';
  putitemXml(viParams, 'CD_EMPRESA', item_f('CD_EMPRESA', tTRA_TRANSACAO));
  putitemXml(viParams, 'NR_TRANSACAO', item_f('NR_TRANSACAO', tTRA_TRANSACAO));
  putitemXml(viParams, 'DT_TRANSACAO', item_a('DT_TRANSACAO', tTRA_TRANSACAO));
  voParams := activateCmp('TRAFM065', 'EXEC', viParams); (*,,, *)

  if (xStatus < 0) then begin
    rollback;
    return(-1); exit;
  end;

  commit;
  if (xStatus < 0) then begin
    rollback;
    return(-1); exit;
  end else begin
    voParams := SetHint(viParams); (* 'ID=APLINFO002' *)
  end;

  return(0); exit;
end;

//--------------------------------------------------------------------
function TF_TRAFM080.carregaFormaPagamento(pParams : String) : String;
//--------------------------------------------------------------------
const
  cDS_METHOD = 'ADICIONAL=Operação: TF_TRAFM080.carregaFormaPagamento()';
var
  viParams, voParams, vDsLstParcela : String;
begin
  if (gTpSimuladorFat = 0)  and (gInSimuladorProduto = False)  and (gInSimuladorCondPgto = False) then begin
    commit;
    if (xStatus < 0) then begin
      rollback;
    end else begin
      voParams := SetHint(viParams); (* 'ID=APLINFO002' *)
    end;

    return(0); exit;
  end;
  if (item_f('TP_OPERACAO', tTRA_TRANSACAO) = 'S')  and (item_f('TP_MODALIDADE', tGER_OPERACAO) = 8)  and (item_f('VL_TRANSACAO', tTRA_TRANSACAO) <= item_f('VL_TOTAL', tR_TRA_TRANSACAO)) then begin
    return(0); exit;
  end;
  if (item_f('TP_MODALIDADE', tGER_OPERACAO) = 4 ) or (item_f('TP_MODALIDADE', tGER_OPERACAO) = 8)  and (item_f('TP_OPERACAO', tTRA_TRANSACAO) = 'S') then begin
  end else begin

    return(0); exit;
  end;
  if (gInSimuladorProduto = True) then begin
    viParams := '';
    putitemXml(viParams, 'CD_EMPRESA', item_f('CD_EMPRESA', tTRA_TRANSACAO));
    putitemXml(viParams, 'NR_TRANSACAO', item_f('NR_TRANSACAO', tTRA_TRANSACAO));
    putitemXml(viParams, 'DT_TRANSACAO', item_a('DT_TRANSACAO', tTRA_TRANSACAO));
    //keyboard := 'KB_GLOBAL';
    voParams := activateCmp('TRAFM113', 'EXEC', viParams); (*,,, *)
    //keyboard := 'KB_PDV';
    if (xStatus < 0) then begin
      Result := voParams;
      return(-1); exit;
    end;
  end else if (gInSimuladorCondPgto = True) then begin
    viParams := '';
    putitemXml(viParams, 'CD_EMPRESA', item_f('CD_EMPRESA', tTRA_TRANSACAO));
    putitemXml(viParams, 'NR_TRANSACAO', item_f('NR_TRANSACAO', tTRA_TRANSACAO));
    putitemXml(viParams, 'DT_TRANSACAO', item_a('DT_TRANSACAO', tTRA_TRANSACAO));
    //keyboard := 'KB_GLOBAL';
    voParams := activateCmp('TRAFM123', 'EXEC', viParams); (*,,, *)
    //keyboard := 'KB_PDV';
    if (xStatus < 0) then begin
      Result := voParams;
      return(-1); exit;
    end;
  end else if (gTpSimuladorFat > 0) then begin
    viParams := '';
    putitemXml(viParams, 'CD_EMPRESA', item_f('CD_EMPRESA', tTRA_TRANSACAO));
    putitemXml(viParams, 'NR_TRANSACAO', item_f('NR_TRANSACAO', tTRA_TRANSACAO));
    putitemXml(viParams, 'DT_TRANSACAO', item_a('DT_TRANSACAO', tTRA_TRANSACAO));
    //keyboard := 'KB_GLOBAL';
    voParams := activateCmp('TRAFM078', 'EXEC', viParams); (*,,, *)
    //keyboard := 'KB_PDV';
    if (xStatus < 0) then begin
      Result := voParams;
      return(-1); exit;
    end;
  end;
  if (voParams <> '') then begin
    gCdUsuarioDesc := itemXmlF('CD_USUARIODESC', voParams);
    vDsLstParcela := itemXml('DS_LSTPARCELA', voParams);

    viParams := voParams;
    voParams := activateCmp('TRASVCO017', 'gravaFormaPagamento', viParams); (*,,,, *)
    if (xStatus < 0) then begin
      Result := voParams;
      return(-1); exit;
    end;
    if (vDsLstParcela <> '') then begin
      viParams := '';
      putitemXml(viParams, 'CD_EMPRESA', item_f('CD_EMPRESA', tTRA_TRANSACAO));
      putitemXml(viParams, 'NR_TRANSACAO', item_f('NR_TRANSACAO', tTRA_TRANSACAO));
      putitemXml(viParams, 'DT_TRANSACAO', item_a('DT_TRANSACAO', tTRA_TRANSACAO));
      putitemXml(viParams, 'IN_SOBREPOR', True);
      putitemXml(viParams, 'DS_LSTPARCELA', vDsLstParcela);
      voParams := activateCmp('TRASVCO004', 'gravaParcelaTransacao', viParams); (*,,,, *)
    end;

    commit;
    if (xStatus < 0) then begin
      rollback;
    end else begin
      voParams := SetHint(viParams); (* 'ID=APLINFO002' *)
    end;
  end;

  voParams := recarregaTransacao(viParams); (* *)
  if (xStatus < 0) then begin
    Result := voParams;
    return(-1); exit;
  end;

  return(0); exit;
end;

//--------------------------------------------------------
function TF_TRAFM080.BT_CTRL_T(pParams : String) : String;
//--------------------------------------------------------
const
  cDS_METHOD = 'ADICIONAL=Operação: TF_TRAFM080.BT_CTRL_T()';
var
  viParams, voParams : String;
  vNrTransacao : Real;
begin
  if (item_f('NR_TRANSACAO', tTRA_TRANSACAO) = 0) then begin
    return(0); exit;
  end;
  if (item_f('TP_MODALIDADE', tGER_OPERACAO) <> '8' ) or (item_f('TP_OPERACAO', tTRA_TRANSACAO) <> 'S') then begin
    return(0); exit;
  end;

  viParams := '';
  putitemXml(viParams, 'CD_EMPRESA', item_f('CD_EMPRESA', tTRA_TRANSACAO));
  putitemXml(viParams, 'NR_TRANSACAO', item_f('NR_TRANSACAO', tTRA_TRANSACAO));
  putitemXml(viParams, 'DT_TRANSACAO', item_a('DT_TRANSACAO', tTRA_TRANSACAO));
  //keyboard := 'KB_GLOBAL';
  voParams := activateCmp('TRAFL054', 'EXEC', viParams); (*,,, *)
  //keyboard := 'KB_PDV';
  if (xStatus < 0) then begin
    Result := voParams;
    return(-1); exit;
  end;

  return(0); exit;
end;

//-----------------------------------------------------------
function TF_TRAFM080.listaDetalhe(pParams : String) : String;
//-----------------------------------------------------------
const
  cDS_METHOD = 'ADICIONAL=Operação: TF_TRAFM080.listaDetalhe()';
begin
  if (dbocc(t'TRA_TRANSITEM')) then begin
    if (item_f('CD_BARRAPRD', tTRA_TRANSITEM) = '') then begin
      CD_BARRAPRD.DETALHE := item_f('CD_PRODUTO', tTRA_TRANSITEM);
    end else begin
      CD_BARRAPRD.DETALHE := item_f('CD_BARRAPRD', tTRA_TRANSITEM);
    end;

    VL_UNITBRUTO.DETALHE := item_f('VL_UNITBRUTO', tTRA_TRANSITEM);
    PR_DESCONTO.DETALHE := item_f('PR_DESCONTO', tTRA_TRANSITEM);
    VL_UNITDESC.DETALHE := item_f('VL_UNITDESC', tTRA_TRANSITEM);
  end;

  return(0); exit;

end;

//----------------------------------------------------------
function TF_TRAFM080.buscaLimite(pParams : String) : String;
//----------------------------------------------------------
const
  cDS_METHOD = 'ADICIONAL=Operação: TF_TRAFM080.buscaLimite()';
var
  viParams, voParams : String;
  vInValidaFamiliar : Boolean;
begin
  gVlLimite := '';

  vInValidaFamiliar := itemXmlB('IN_LIMITE_FAMILIAR_VD', xParamEmp);
  if (vInValidaFamiliar = True) then begin
    vInValidaFamiliar := False;

    clear_e(tTRA_TRANSACADIC);
    putitem_e(tTRA_TRANSACADIC, 'CD_EMPRESA', item_f('CD_EMPRESA', tTRA_TRANSACAO));
    putitem_e(tTRA_TRANSACADIC, 'DT_TRANSACAO', item_a('DT_TRANSACAO', tTRA_TRANSACAO));
    putitem_e(tTRA_TRANSACADIC, 'NR_TRANSACAO', item_f('NR_TRANSACAO', tTRA_TRANSACAO));
    retrieve_e(tTRA_TRANSACADIC);
    if (xStatus >= 0)  and (item_f('CD_FAMILIAR', tTRA_TRANSACADIC) <> 0) then begin
      vInValidaFamiliar := True;
    end;
  end;

  viParams := '';
  putitemXml(viParams, 'CD_CLIENTE', item_f('CD_PESSOA', tPES_PESSOA));
  putitemXml(viParams, 'IN_TOTAL', True);

  if (vInValidaFamiliar = True)  and (item_f('CD_FAMILIAR', tTRA_TRANSACADIC) <> 0) then begin
    putitemXml(viParams, 'CD_FAMILIAR', item_f('CD_FAMILIAR', tTRA_TRANSACADIC));
  end else begin
    vInValidaFamiliar := False;
  end;

  voParams := activateCmp('FCRSVCO015', 'buscaLimiteCliente', viParams); (*,,,, *)
  if (xStatus < 0) then begin
    Result := voParams;
    return(-1); exit;
  end;
  if (vInValidaFamiliar = True) then begin
    gVlLimite := itemXmlF('VL_SALDOFAMILIAR', voParams);
  end else begin
    gVlLimite := itemXmlF('VL_SALDO', voParams);
  end;

  gNrDiaAtraso := itemXmlF('NR_DIAVENCTO', voParams);

  return(0); exit;
end;

//-------------------------------------------------------------------------
function TF_TRAFM080.aplicaQtPecasDescontoVlMin(pParams : String) : String;
//-------------------------------------------------------------------------
const
  cDS_METHOD = 'ADICIONAL=Operação: TF_TRAFM080.aplicaQtPecasDescontoVlMin()';
var
  viParams, voParams, vDsLstTransacao, vDsRegistro, vDsMensagemPRD : String;
  vVlTotalDesc, vPrTotalDesc, vVlResto, vVlCalc, vVlMaior, vNrOcc : Real;
  vVlBrutoTransacao, vQtDesconto, vQtDescontoAplic, vQtDescontoAplicPRD : Real;
begin
  if (gInSimuladorProduto = True) then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Não é possível aplicar desconto total o parâmetro por empresa IN_SIMULADOR_FAT_PRODUTO está configurado!', '');
    return(-1); exit;
  end;
  if (gInSimuladorCondPgto = True) then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Não é possível aplicar desconto total o parâmetro por empresa IN_SIMULADOR_COND_PGTO está configurado!', '');
    return(-1); exit;
  end;
  if (gTpSimuladorFat > 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Não é possível aplicar desconto total o parâmetro por empresa TP_SIMULADOR_FAT está configurado!', '');
    return(-1); exit;
  end;
  if (gqtPecasDescontoVlMin = 0) then begin
    return(0); exit;
  end;

  askmess 'Deseja aplicar desconto?', 'Cancelar, Sim, Não';
  if (xStatus = 1) then begin
    return(-1); exit;
  end else if (xStatus = 3) then begin
    return(0); exit;
  end;

  clear_e(tTMP_NR10);

  vQtDesconto := (item_f('QT_SOLICITADA', tTRA_TRANSACAO) / gqtPecasDescontoVlMin);
  vQtDesconto := int(vQtDesconto);
  gVlDescAcumulado := 0;

  if (vQtDesconto > 0) then begin
    clear_e(tTRA_S_TRANSITEM);
    putitem_e(tTRA_S_TRANSITEM, 'CD_EMPRESA', item_f('CD_EMPRESA', tTRA_TRANSACAO));
    putitem_e(tTRA_S_TRANSITEM, 'NR_TRANSACAO', item_f('NR_TRANSACAO', tTRA_TRANSACAO));
    putitem_e(tTRA_S_TRANSITEM, 'DT_TRANSACAO', item_a('DT_TRANSACAO', tTRA_TRANSACAO));
    retrieve_e(tTRA_S_TRANSITEM);
    if (xStatus >= 0) then begin
      sort_e(tTRA_S_TRANSITEM, '      sort/e , VL_UNITLIQUIDO, CD_PRODUTO;');
      setocc(tTRA_S_TRANSITEM, 1);
      vQtDescontoAplic := 1;
      vQtDescontoAplicPRD := 0;
      repeat
        vQtDescontoAplicPRD := vQtDescontoAplicPRD + 1;
        if (item_f('QT_SOLICITADA', tTRA_S_TRANSITEM) >= vQtDescontoAplicPRD) then begin
          gVlDescAcumulado := gVlDescAcumulado + item_f('VL_UNITLIQUIDO', tTRA_S_TRANSITEM);
        end else begin
          vQtDescontoAplicPRD := 1;
          setocc(tTRA_S_TRANSITEM, curocc(tTRA_S_TRANSITEM) + 1);
          gVlDescAcumulado := gVlDescAcumulado + item_f('VL_UNITLIQUIDO', tTRA_S_TRANSITEM);
        end;

        creocc(tTMP_NR10, -1);
        putitem_e(tTMP_NR10, 'NR_GERAL', item_f('CD_PRODUTO', tTRA_S_TRANSITEM));
        retrieve_o(tTMP_NR10);

        putitem_e(tTMP_NR10, 'DS_PRODUTO', item_a('DS_PRODUTO', tTRA_S_TRANSITEM));
        putitem_e(tTMP_NR10, 'VL_UNITARIO', item_f('VL_UNITLIQUIDO', tTRA_S_TRANSITEM));
        putitem_e(tTMP_NR10, 'QT_DESCONTO', item_f('QT_DESCONTO', tTMP_NR10) + 1);

        vQtDescontoAplic := vQtDescontoAplic + 1;
      until (vQtDescontoAplic > vQtDesconto);
    end;
  end;
  if (gVlDescAcumulado > 0) then begin
    setocc(tTMP_NR10, 1);
    while (xStatus >= 0) do begin
      if (vDsMensagemPRD = '') then begin
        vDsMensagemPRD := 'Produto: ' + NR_GERAL + '.TMP_NR10 - ' + DS_PRODUTO + '.TMP_NR10 - Qt. ' + QT_DESCONTO + '.TMP_NR10 - Vl. unit. ' + VL_UNITARIO + '.TMP_NR10';
      end else begin
        vDsMensagemPRD := '' + vDsMensagemPRD + '  ' + NR_GERAL + '.TMP_NR10 - ' + DS_PRODUTO + '.TMP_NR10 - Qt. ' + QT_DESCONTO + '.TMP_NR10 - Vl. unit. ' + VL_UNITARIO + '.TMP_NR10';
      end;
      setocc(tTMP_NR10, curocc(tTMP_NR10) + 1);
    end;

    vDsMensagemPRD := '' + vDsMensagemPRD + '   Quantidade de produto com desconto: ' + vQtDesconto' + ';
    vDsMensagemPRD := '' + vDsMensagemPRD + '   Valor bruto transação: ' + VL_TOTAL + '.TRA_TRANSACAO';
    vDsMensagemPRD := '' + vDsMensagemPRD + '  Valor total desconto: ' + FloatToStr(gVlDescAcumulado') + ';
    gVlLiqTransacao := item_f('VL_TOTAL', tTRA_TRANSACAO) - gVlDescAcumulado;
    vDsMensagemPRD := '' + vDsMensagemPRD + '  Valor líquido transação: ' + FloatToStr(gVlLiqTransacao') + ';

    viParams := '';

    putitemXml(viParams, 'TITULO', 'Informação de Desconto');
    putitemXml(viParams, 'MENSAGEM', vDsMensagemPRD);
    voParams := activateCmp('GERFP008', 'EXEC', viParams); (*,,, *)
    if (xStatus < 0) then begin
      Result := voParams;
      return(-1); exit;
    end;
    askmess 'Confirmar desconto?', 'Sim, Não';
    if (xStatus = 2) then begin
      return(-1); exit;
    end;

    vVlBrutoTransacao := item_f('VL_TRANSACAO', tTRA_TRANSACAO) + item_f('VL_DESCONTO', tTRA_TRANSACAO);
    vVlTotalDesc := item_f('VL_DESCONTO', tTRA_TRANSACAO) + gVlDescAcumulado;
    vVlCalc := vVlTotalDesc / vVlBrutoTransacao * 100;
    vPrTotalDesc := rounded(vVlCalc, 6);

    vVlResto := vVlTotalDesc;

    if not (empty(tTRA_TRANSITEM)) then begin
      vVlMaior := 0;
      setocc(tTRA_TRANSITEM, 1);
      while (xStatus >= 0) do begin

        if ((gInBloqDesItemProm = True)  and (item_f('CD_PROMOCAO', tTRA_TRANSITEM) > 0)) then begin
        end else begin

          vVlCalc := item_f('VL_TOTALLIQUIDO', tTRA_TRANSITEM) + item_f('VL_TOTALDESCCAB', tTRA_TRANSITEM);
          vVlCalc := vVlCalc * vPrTotalDesc / 100;
          putitem_e(tTRA_TRANSITEM, 'VL_TOTALDESCCAB', rounded(vVlCalc, 2));
          putitem_e(tTRA_TRANSITEM, 'VL_TOTALLIQUIDO', item_f('VL_TOTALBRUTO', tTRA_TRANSITEM) - (item_f('VL_TOTALDESC', tTRA_TRANSITEM) + item_f('VL_TOTALDESCCAB', tTRA_TRANSITEM)));
          vVlCalc := item_f('VL_TOTALDESCCAB', tTRA_TRANSITEM) / item_f('QT_SOLICITADA', tTRA_TRANSITEM);
          putitem_e(tTRA_TRANSITEM, 'VL_UNITDESCCAB', rounded(vVLCalc, 6));
          vVlCalc := item_f('VL_TOTALLIQUIDO', tTRA_TRANSITEM) / item_f('QT_SOLICITADA', tTRA_TRANSITEM);
          putitem_e(tTRA_TRANSITEM, 'VL_UNITLIQUIDO', rounded(vVLCalc, 6));

          if (item_f('VL_TOTALDESCCAB', tTRA_TRANSITEM) > vVlResto) then begin
            putitem_e(tTRA_TRANSITEM, 'VL_TOTALDESCCAB', vVlResto);
              putitem_e(tTRA_TRANSITEM, 'VL_TOTALLIQUIDO', item_f('VL_TOTALBRUTO', tTRA_TRANSITEM) - (item_f('VL_TOTALDESC', tTRA_TRANSITEM) + item_f('VL_TOTALDESCCAB', tTRA_TRANSITEM)));
            vVlCalc := item_f('VL_TOTALDESCCAB', tTRA_TRANSITEM) / item_f('QT_SOLICITADA', tTRA_TRANSITEM);
            putitem_e(tTRA_TRANSITEM, 'VL_UNITDESCCAB', rounded(vVLCalc, 6));
            vVlCalc := item_f('VL_TOTALLIQUIDO', tTRA_TRANSITEM) / item_f('QT_SOLICITADA', tTRA_TRANSITEM);
            putitem_e(tTRA_TRANSITEM, 'VL_UNITLIQUIDO', rounded(vVLCalc, 6));
            vVlResto := 0;
            break;
          end;

          vVlResto := vVlResto - item_f('VL_TOTALDESCCAB', tTRA_TRANSITEM);

          if (item_f('VL_TOTALLIQUIDO', tTRA_TRANSITEM) > vVlMaior) then begin
            vVlMaior := item_f('VL_TOTALLIQUIDO', tTRA_TRANSITEM);
            vNrOcc := curocc(tTRA_TRANSITEM);
          end;
        end;
        setocc(tTRA_TRANSITEM, curocc(tTRA_TRANSITEM) + 1);
      end;
      if (vVlResto <> 0) then begin
        setocc(tTRA_TRANSITEM, 1);
        putitem_e(tTRA_TRANSITEM, 'VL_TOTALDESCCAB', item_f('VL_TOTALDESCCAB', tTRA_TRANSITEM) + vVlResto);
        putitem_e(tTRA_TRANSITEM, 'VL_TOTALLIQUIDO', item_f('VL_TOTALBRUTO', tTRA_TRANSITEM) - (item_f('VL_TOTALDESC', tTRA_TRANSITEM) + item_f('VL_TOTALDESCCAB', tTRA_TRANSITEM)));
        vVlCalc := item_f('VL_TOTALDESCCAB', tTRA_TRANSITEM) / item_f('QT_SOLICITADA', tTRA_TRANSITEM);
        putitem_e(tTRA_TRANSITEM, 'VL_UNITDESCCAB', rounded(vVLCalc, 6));
        vVlCalc := item_f('VL_TOTALLIQUIDO', tTRA_TRANSITEM) / item_f('QT_SOLICITADA', tTRA_TRANSITEM);
        putitem_e(tTRA_TRANSITEM, 'VL_UNITLIQUIDO', rounded(vVLCalc, 6));
      end;

      setocc(tTRA_TRANSITEM, 1);
      while (xStatus >= 0) do begin
        viParams := '';
        putlistitensocc_e(viParams, tTRA_TRANSITEM);
        putitemXml(viParams, 'IN_TOTAL', False);
        voParams := activateCmp('TRASVCO004', 'gravaItemTransacao', viParams); (*,,,, *)
        if (xStatus < 0) then begin
          Result := voParams;
          return(-1); exit;
        end;
        setocc(tTRA_TRANSITEM, curocc(tTRA_TRANSITEM) + 1);
      end;
      if (itemXml('DS_MENSAGEM', voParams) <> '') then begin
        message/info '' + itemXml('DS_MENSAGEM', + ' voParams)';
      end;

      vDsLstTransacao := '';
      vDsRegistro := '';
      putitemXml(vDsRegistro, 'CD_EMPRESA', item_f('CD_EMPRESA', tTRA_TRANSACAO));
      putitemXml(vDsRegistro, 'NR_TRANSACAO', item_f('NR_TRANSACAO', tTRA_TRANSACAO));
      putitemXml(vDsRegistro, 'DT_TRANSACAO', item_a('DT_TRANSACAO', tTRA_TRANSACAO));
      putitem(vDsLstTransacao,  vDsRegistro);
      putitemXml(viParams, 'DS_LSTTRANSACAO', vDsLstTransacao);
      voParams := activateCmp('TRASVCO004', 'gravaTotalTransacao', viParams); (*,,,, *)
      if (xStatus < 0) then begin
        Result := voParams;
        return(-1); exit;
      end;

      viParams := '';
      putitemXml(viParams, 'CD_EMPRESA', item_f('CD_EMPRESA', tTRA_TRANSACAO));
      putitemXml(viParams, 'NR_TRANSACAO', item_f('NR_TRANSACAO', tTRA_TRANSACAO));
      putitemXml(viParams, 'DT_TRANSACAO', item_a('DT_TRANSACAO', tTRA_TRANSACAO));
      putitemXml(viParams, 'IN_SOBREPOR', True);
      voParams := activateCmp('TRASVCO004', 'gravaParcelaTransacao', viParams); (*,,,, *)
      if (xStatus < 0) then begin
        Result := voParams;
        return(-1); exit;
      end;
    end;

    vDsLstTransacao := '';
    vDsRegistro := '';
    putitemXml(vDsRegistro, 'CD_EMPRESA', item_f('CD_EMPRESA', tTRA_TRANSACAO));
    putitemXml(vDsRegistro, 'NR_TRANSACAO', item_f('NR_TRANSACAO', tTRA_TRANSACAO));
    putitemXml(vDsRegistro, 'DT_TRANSACAO', item_a('DT_TRANSACAO', tTRA_TRANSACAO));
    putitem(vDsLstTransacao,  vDsRegistro);

    viParams := '';
    putitemXml(viParams, 'DS_LSTTRANSACAO', vDsLstTransacao);
    putitemXml(viParams, 'DS_OBSERVACAO', 'Vl. total desc.: ' + FloatToStr(gVlDescAcumulado) + ' / Qt. produto com desc.: ' + vQtDesconto') + ';
    putitemXml(viParams, 'CD_COMPONENTE', TRAFM080);
    putitemXml(viParams, 'IN_OBSNF', False);
    voParams := activateCmp('TRASVCO016', 'gravaObsTransacao', viParams); (*,,,, *)
    if (xStatus < 0) then begin
      Result := voParams;
      return(-1); exit;
    end;
  end;

  return(0); exit;

end;

//----------------------------------------------------------------------
function TF_TRAFM080.buscaDadosAdicTransacao(pParams : String) : String;
//----------------------------------------------------------------------
const
  cDS_METHOD = 'ADICIONAL=Operação: TF_TRAFM080.buscaDadosAdicTransacao()';
var
  viParams, voParams : String;
begin
  viParams := '';
  putitemXml(viParams, 'CD_EMPRESA', item_f('CD_EMPRESA', tTRA_TRANSACAO));
  putitemXml(viParams, 'NR_TRANSACAO', item_f('NR_TRANSACAO', tTRA_TRANSACAO));
  putitemXml(viParams, 'DT_TRANSACAO', item_a('DT_TRANSACAO', tTRA_TRANSACAO));
  voParams := activateCmp('TRASVCO016', 'buscaDadosAdicionais', viParams); (*,,,, *)
  if (xStatus < 0) then begin
    Result := voParams;
    return(-1); exit;
  end;

  gCdTabPreco := itemXmlF('CD_TABPRECO', voParams);

  return(0); exit;

end;

//-----------------------------------------------------------------
function TF_TRAFM080.carregaBonusCartao(pParams : String) : String;
//-----------------------------------------------------------------
const
  cDS_METHOD = 'ADICIONAL=Operação: TF_TRAFM080.carregaBonusCartao()';
var
  viParams, voParams, vDsLstTransacao, vDsRegistro, vDsLstCartao : String;
  vCdCartao, vVlBrutoTransacao, vPrTotalBonus, vVlResto, vVlTotalBonusItem , vVlCalc : Real;
  vVlMaior, vNrOcc, vCdCliente : Real;
begin
  vDsLstCartao := '';
  vVlCalc := '';

  viParams := '';
  //keyboard := 'KB_GLOBAL';
  putitemXml(viParams, 'NR_CARTAO', gNrCartao);
  putitemXml(viParams, 'VL_TRANSACAO', item_f('VL_TRANSACAO', tTRA_TRANSACAO));

  voParams := activateCmp('CTCFP003', 'EXEC', viParams); (*,,, *)
  //keyboard := 'KB_PDV';
  if (xStatus < 0) then begin
    Result := voParams;
    return(-1); exit;
  end;

  vCdCartao := itemXmlF('CD_CARTAO', voParams);
  vCdCliente := itemXmlF('CD_CLIENTE', voParams);
  gVlBonusUtil := itemXmlF('VL_BONUSUTIL', voParams);
  vDsLstCartao := voParams;

  if (vCdCartao <> 0) then begin
    putitem_e(tTRA_TRANSACAO, 'CD_PESSOA', vCdCliente);
    viParams := '';
    putlistitensocc_e(viParams, tTRA_TRANSACAO);
    voParams := activateCmp('TRASVCO004', 'gravaCapaTransacao', viParams); (*,,,, *)
    if (xStatus < 0) then begin
      Result := voParams;
      return(-1); exit;
    end;
    if (gVlBonusUtil <> 0) then begin
      viParams := '';
      putitemXml(viParams, 'CD_EMPRESA', item_f('CD_EMPRESA', tTRA_TRANSACAO));
      putitemXml(viParams, 'NR_TRANSACAO', item_f('NR_TRANSACAO', tTRA_TRANSACAO));
      putitemXml(viParams, 'DT_TRANSACAO', item_a('DT_TRANSACAO', tTRA_TRANSACAO));
      putitemXml(viParams, 'VL_BONUS', gVlBonusUtil);
      voParams := activateCmp('TRASVCO024', 'gravaBonusTraItemAdic', viParams); (*,,,, *)
      if (xStatus < 0) then begin
        Result := voParams;
        return(-1); exit;
      end;

      vDsLstTransacao := '';
      vDsRegistro := '';
      putitemXml(vDsRegistro, 'CD_EMPRESA', item_f('CD_EMPRESA', tTRA_TRANSACAO));
      putitemXml(vDsRegistro, 'NR_TRANSACAO', item_f('NR_TRANSACAO', tTRA_TRANSACAO));
      putitemXml(vDsRegistro, 'DT_TRANSACAO', item_a('DT_TRANSACAO', tTRA_TRANSACAO));
      putitem(vDsLstTransacao,  vDsRegistro);

      viParams := '';
      putitemXml(viParams, 'DS_LSTTRANSACAO', vDsLstTransacao);
      putitemXml(viParams, 'DS_OBSERVACAO', 'Utilizado bonus de ' + FloatToStr(gVlBonusUtil')) + ';
      putitemXml(viParams, 'CD_COMPONENTE', TRAFM080);
      putitemXml(viParams, 'IN_OBSNF', False);
      voParams := activateCmp('TRASVCO016', 'gravaObsTransacao', viParams); (*,,,, *)
      if (xStatus < 0) then begin
        Result := voParams;
        return(-1); exit;
      end;
    end;

    viParams := vDsLstCartao;
    putitemXml(viParams, 'CD_EMPTRANSACAO', item_f('CD_EMPRESA', tTRA_TRANSACAO));
    putitemXml(viParams, 'NR_TRANSACAO', item_f('NR_TRANSACAO', tTRA_TRANSACAO));
    putitemXml(viParams, 'DT_TRANSACAO', item_a('DT_TRANSACAO', tTRA_TRANSACAO));
    voParams := activateCmp('CTCSVCO004', 'gravarCartaoTransacao', viParams); (*,,,, *)
    if (xStatus < 0) then begin
      Result := voParams;
      return(-1); exit;
    end;
  end;

  return(0); exit;

end;

//----------------------------------------------------------------
function TF_TRAFM080.imprimirTransacao(pParams : String) : String;
//----------------------------------------------------------------
const
  cDS_METHOD = 'ADICIONAL=Operação: TF_TRAFM080.imprimirTransacao()';
var
  viParams, voParams, vDsLstTransacao, vDsRegistro : String;
  vInImprimir : Boolean;
begin
  vInImprimir := True;
  if (vInImprimir = True) then begin
    viParams := '';
    vDsLstTransacao := '';
    vDsRegistro := '';
    putitemXml(vDsRegistro, 'CD_EMPRESA', item_f('CD_EMPRESA', tTRA_TRANSACAO));
    putitemXml(vDsRegistro, 'NR_TRANSACAO', item_f('NR_TRANSACAO', tTRA_TRANSACAO));
    putitemXml(vDsRegistro, 'DT_TRANSACAO', item_a('DT_TRANSACAO', tTRA_TRANSACAO));
    putitem(vDsLstTransacao,  vDsRegistro);
    putitemXml(viParams, 'DS_LSTTRANSACAO', vDsLstTransacao);
    if (gTpImpressaoTraVenda = 02) then begin
      putitemXml(viParams, 'IN_DIRETO', False);
    end else begin
      putitemXml(viParams, 'IN_DIRETO', True);
    end;

    //keyboard := 'KB_GLOBAL';
    voParams := activateCmp('TRAFP004', 'EXEC', viParams); (*,,, *)
    //keyboard := 'KB_PDV';
    if (xStatus >= 0) then begin
      commit;
      if (xStatus < 0) then begin
        rollback;
      end else begin
        voParams := SetHint(viParams); (* 'ID=APLINFO002' *)
      end;
    end else begin
      rollback;
    end;
  end;

  return(0); exit;
end;

//----------------------------------------------------------
function TF_TRAFM080.BT_CTRL_F11(pParams : String) : String;
//----------------------------------------------------------
const
  cDS_METHOD = 'ADICIONAL=Operação: TF_TRAFM080.BT_CTRL_F11()';
begin
  if (dbocc(t'TRA_TRANSACAO') = 0) then begin
    return(-1); exit;
  end;

  voParams := agrupaItem(viParams); (* False *)
  if (xStatus < 0) then begin
    Result := voParams;
    return(-1); exit;
  end;

  voParams := imprimirTransacao(viParams); (* *)
  if (xStatus < 0) then begin
    Result := voParams;
    return(-1); exit;
  end;

  voParams := recarregaTransacao(viParams); (* *)
  if (xStatus < 0) then begin
    Result := voParams;
    return(-1); exit;
  end;

  return(0); exit;
end;

//---------------------------------------------------------------
function TF_TRAFM080.buscaAniversario(pParams : String) : String;
//---------------------------------------------------------------
const
  cDS_METHOD = 'ADICIONAL=Operação: TF_TRAFM080.buscaAniversario()';
var
  vTpAniversario, vDiaNasc, vMesNasc, vDiaAtual, vMesAtual : Real;
  vDtSistema : TDate;
begin
  vTpAniversario := itemXmlF('TP_AVISA_ANIVERSARIO', xParamEmp);

  if (vTpAniversario = 1 ) or (vTpAniversario = 4) then begin
    if (empty(tPES_PESFISICA) = False)  and (item_a('DT_NASCIMENTO', tPES_PESFISICA) <> '') then begin
      vDtSistema := itemXml('DT_SISTEMA', PARAM_GLB);

      vDiaNasc := item_a('DT_NASCIMENTO', tPES_PESFISICA)[D];
      vMesNasc := item_a('DT_NASCIMENTO', tPES_PESFISICA)[M];
      vDiaAtual := vDtSistema[D];
      vMesAtual := vDtSistema[M];

      if (vDiaNasc = vDiaAtual ) and (vMesNasc = vMesAtual) then begin
        message/info 'Atenção. Aniversariante!';
      end;
    end;
  end;

  return(0); exit;
end;

//--------------------------------------------------------
function TF_TRAFM080.simulacao(pParams : String) : String;
//--------------------------------------------------------
const
  cDS_METHOD = 'ADICIONAL=Operação: TF_TRAFM080.simulacao()';
var
  viParams, voParams : String;
begin
  if (item_f('NR_TRANSACAO', tTRA_TRANSACAO) = 0) then begin
    return(0); exit;
  end;

  viParams := '';
  putitemXml(viParams, 'CD_EMPRESA', item_f('CD_EMPRESA', tTRA_TRANSACAO));
  putitemXml(viParams, 'NR_TRANSACAO', item_f('NR_TRANSACAO', tTRA_TRANSACAO));
  putitemXml(viParams, 'DT_TRANSACAO', item_a('DT_TRANSACAO', tTRA_TRANSACAO));
  putitemXml(viParams, 'IN_PDV', True);
  voParams := activateCmp('TRAFM078', 'EXEC', viParams); (*,,, *)
  if (xStatus < 0) then begin
    Result := voParams;
    return(-1); exit;
  end;

  return(0); exit;
end;

//-----------------------------------------------------------------
function TF_TRAFM080.efetivaTEFPendente(pParams : String) : String;
//-----------------------------------------------------------------
const
  cDS_METHOD = 'ADICIONAL=Operação: TF_TRAFM080.efetivaTEFPendente()';
var
  viParams, voParams, vDsLstCupom, vDsRegistro, vDsConteudo, vDsAprovado, vDsMensagem, vDsLstEmpresa, vDsNsu : String;
  vInLoopConfirmacao, vInLoopImpressao : Boolean;
  vNrLinhaCupom, vNrSequencia, vNrTotOcc, vNrOcc : Real;
begin
  vDsLstEmpresa := '';

  viParams := '';
  putitemXml(viParams, 'IN_VALIDALOCAL', False);
  if (item_f('CD_GRUPOEMPRESA', tTRA_TRANSACAO) <> '') then begin
    putitemXml(viParams, 'CD_GRUPOEMPRESA', item_f('CD_GRUPOEMPRESA', tTRA_TRANSACAO));
  end else begin
    putitemXml(viParams, 'CD_GRUPOEMPRESA', itemXmlF('CD_GRUPOEMPRESA', PARAM_GLB));
  end;
  voParams := activateCmp('GERSVCO032', 'buscaLstGrupoEmpresa', viParams); (*,,,, *)
  if (xStatus < 0) then begin
    Result := voParams;
    return(-1); exit;
  end;
  vDsLstEmpresa := itemXmlF('CD_EMPRESA', voParams);

  vNrTotOcc := 0;
  vDsNsu := '';

  clear_e(tF_TEF_TRANSACAO);
  putitem_e(tF_TEF_TRANSACAO, 'CD_EMPRESA', vDsLstEmpresa);
  putitem_e(tF_TEF_TRANSACAO, 'CD_TERMINAL', itemXmlF('CD_TERMINAL', PARAM_GLB));
  putitem_e(tF_TEF_TRANSACAO, 'TP_SITUACAO', '1);
  retrieve_e(tF_TEF_TRANSACAO);
  if (xStatus >= 0) then begin
    if (gTpImpTefPAYGO = 1) then begin
      vNrTotOcc := totocc(tF_TEF_TRANSACAO);
      clear_e(tTEF_RELTRANSACAO);
      putitem_e(tTEF_RELTRANSACAO, 'CD_EMPTEF', item_f('CD_EMPRESA', tF_TEF_TRANSACAO));
      putitem_e(tTEF_RELTRANSACAO, 'DT_MOVIMENTO', item_a('DT_MOVIMENTO', tF_TEF_TRANSACAO));
      putitem_e(tTEF_RELTRANSACAO, 'NR_SEQ', item_f('NR_SEQ', tF_TEF_TRANSACAO));
      retrieve_e(tTEF_RELTRANSACAO);
      if (xStatus >= 0) then begin
        clear_e(tTRA_TRANSACAO);
        putitem_e(tTRA_TRANSACAO, 'CD_EMPRESA', item_f('CD_EMPTRA', tTEF_RELTRANSACAO));
        putitem_e(tTRA_TRANSACAO, 'NR_TRANSACAO', item_f('NR_TRANSACAO', tTEF_RELTRANSACAO));
        putitem_e(tTRA_TRANSACAO, 'DT_TRANSACAO', item_a('DT_TRANSACAO', tTEF_RELTRANSACAO));
        retrieve_e(tTRA_TRANSACAO);
        if (xStatus >= 0) then begin
          if (item_f('TP_SITUACAO', tTRA_TRANSACAO) = 4) then begin
            setocc(tF_TEF_TRANSACAO, 1);
            while (xStatus >= 0) do begin
              vDsNsu := '' + vDsNsu' + NR_NSU + ' + '.F_TEF_TRANSACAO';

              voParams := efetivaTEFPendenteGeral_CNF(viParams); (* *)
              if (xStatus < 0) then begin
                Result := voParams;
                return(-1); exit;
              end;
              vNrOcc := curocc(tF_TEF_TRANSACAO);
              setocc(tF_TEF_TRANSACAO, curocc(tF_TEF_TRANSACAO) + 1);
            end;
            if (vNrOcc >= vNrTotOcc) then begin
              Result := SetStatus(STS_ERROR, 'GEN0001', 'Transação efetuada. Favor re-imprimir o cupom! ' + vDsNsu', + ' '');
            end;

            clear_e(tTRA_TRANSACAO);
            return(0); exit;
          end;
        end;
      end;
    end;
    if (gTpTEF = 2) then begin
      sort_e(tF_TEF_TRANSACAO, '      sort/e , TP_SITUACAO;');
    end;
    message/hint 'Aguarde. Aplicaçao TEF sendo executada.';
    setocc(tF_TEF_TRANSACAO, 1);
    while (xStatus >= 0) do begin
      if (item_f('TP_SITUACAO', tF_TEF_TRANSACAO) = 1) then begin
        voParams := efetivaTEFPendenteGeral_NCN(viParams); (* *)
        if (xStatus < 0) then begin
          Result := voParams;
          return(-1); exit;
        end;
      end else if (item_f('TP_SITUACAO', tF_TEF_TRANSACAO) = 2) then begin
        voParams := efetivaTEFPendenteGeral_CNF(viParams); (* *)
        if (xStatus < 0) then begin
          Result := voParams;
          return(-1); exit;
        end;
      end else if (item_f('TP_SITUACAO', tF_TEF_TRANSACAO) = 4)  and (gTpTEF = 2) then begin
        viParams := '';
        putitemXml(viParams, '000-000', 'CNC');
        putitemXml(viParams, '001-000', item_f('NR_SEQ', tF_TEF_TRANSACAO));
        gVlTEF := item_f('VL_TRANSACAO', tF_TEF_TRANSACAO);
        putitemXml(viParams, '003-000', '' + FloatToStr(gVlTEF')) + ';
        putitemXml(viParams, '010-000', item_a('NM_REDETEF', tF_TEF_TRANSACAO));

        gNrNSU6DIG := item_f('NR_NSU', tF_TEF_TRANSACAO);
        gDsNSU := '' + NR_NSU + '.F_TEF_TRANSACAO';
        putitemXml(viParams, '012-000', item_f('NR_NSU', tF_TEF_TRANSACAO));

        if (item_a('NM_REDETEF', tF_TEF_TRANSACAO) = 'TECBAN') then begin
          putitemXml(viParams, '012-000', '' + gDsNSU[ + '1:6]');
        end;
        gDtTEF := item_a('DT_TRANSACAO', tF_TEF_TRANSACAO);
        putitemXml(viParams, '022-000', '' + gDtTEF') + ';
        gHrTEF := item_a('HR_TRANSACAO', tF_TEF_TRANSACAO);
        putitemXml(viParams, '023-000', '' + gHrTEF') + ';
        putitemXml(viParams, '999-999', '0');
        putitemXml(viParams, 'DS_EXTENSAO', '001');
        putitemXml(viParams, 'IN_P1', True);
        voParams := activateCmp('TEFSVCO010', 'geraArquivoREQ', viParams); (*,,,, *)
        if (xStatus < 0) then begin
          Result := voParams;
          return(-1); exit;
        end;
        end else if (gTpTEF = 2) then begin
          vInLoopConfirmacao := False;
          repeat
            Result := SetStatus(STS_ERROR, {xCdErro} '', '{xCtxErro} ''', '');
            message/hint 'Aguardando comunicação...';
            voParams := activateCmp('TEFSVCO010', 'geraArquivoREQ', viParams); (*,,,, *)
            if (xStatus < 0) then begin
              Result := voParams;
              return(-1); exit;
            end;
              if (vNrLinhaCupom > 0) then begin
                vInLoopConfirmacao := True;
              end;
            end;
            message/hint ' ';
          until (vInLoopConfirmacao := True);
        end;
        if (vNrLinhaCupom > 0) then begin
          viParams := '';
          putitemXml(viParams, 'NM_ENTIDADE', 'TEF_TRANSACAO');
          voParams := activateCmp('GERSVCO031', 'getNumSeq', viParams); (*,,,, *)
          if (xStatus < 0) then begin
            Result := voParams;
            return(-1); exit;
          end;
          vNrSequencia := itemXmlF('NR_SEQUENCIA', voParams);

          viParams := vDsConteudo;
          putitemXml(viParams, 'CD_EMPRESA', item_f('CD_EMPRESA', tF_TEF_TRANSACAO));
          putitemXml(viParams, '000-000', 'CNC');
          putitemXml(viParams, '001-000', vNrSequencia);
          gVlTEF := item_f('VL_TRANSACAO', tF_TEF_TRANSACAO);
          putitemXml(viParams, '003-000', '' + FloatToStr(gVlTEF')) + ';
          putitemXml(viParams, '010-000', item_a('NM_REDETEF', tF_TEF_TRANSACAO));
          putitemXml(viParams, '011-000', item_f('TP_TRANSACAO', tF_TEF_TRANSACAO));
          putitemXml(viParams, '012-000', itemXml('012-000', vDsConteudo));
          putitemXml(viParams, '022-000', itemXml('022-000', vDsConteudo));
          putitemXml(viParams, '023-000', itemXml('023-000', vDsConteudo));
          putitemXml(viParams, '027-000', itemXml('027-000', vDsConteudo));
          putitemXml(viParams, 'NR_NSUAUX', item_f('NR_NSU', tF_TEF_TRANSACAO));
          putitemXml(viParams, 'TP_SITUACAO', 1);
          newinstance 'TEFSVCO011', 'TEFSVCO011', 'TRANSACTION=TRUE';
          voParams := activateCmp('TEFSVCO011', 'gravaTransacao', viParams); (*,,,, *)
          if (xStatus < 0) then begin
            Result := voParams;
            return(-1); exit;
          end;
          vDsConteudo := itemXml('DS_CUPOM', voParams);
        end;
        if (vNrLinhaCupom > 0) then begin
          voParams := efetivaTEFPendenteGeral_CNC(viParams); (* vDsMensagem, vDsConteudo, vNrSequencia *)
          if (xStatus < 0) then begin
            Result := voParams;
            return(-1); exit;
          end;
        end;
      end;
      setocc(tF_TEF_TRANSACAO, curocc(tF_TEF_TRANSACAO) + 1);
    end;
  end;

  message/hint '';

  return(0); exit;
end;

//--------------------------------------------------------------------------
function TF_TRAFM080.efetivaTEFPendenteGeral_NCN(pParams : String) : String;
//--------------------------------------------------------------------------
const
  cDS_METHOD = 'ADICIONAL=Operação: TF_TRAFM080.efetivaTEFPendenteGeral_NCN()';
var
  viParams, voParams : String;
  vInLoopConfirmacao, vInLoopImpressao : Boolean;
begin
  viParams := '';
  putitemXml(viParams, '000-000', 'NCN');
  putitemXml(viParams, '001-000', item_f('NR_SEQ', tF_TEF_TRANSACAO));
  putitemXml(viParams, '010-000', item_a('NM_REDETEF', tF_TEF_TRANSACAO));

  gNrNSU6DIG := item_f('NR_NSU', tF_TEF_TRANSACAO);
  gDsNSU := '' + NR_NSU + '.F_TEF_TRANSACAO';
  putitemXml(viParams, '012-000', item_f('NR_NSU', tF_TEF_TRANSACAO));

  if (item_a('NM_REDETEF', tF_TEF_TRANSACAO) = 'TECBAN') then begin
    putitemXml(viParams, '012-000', '' + gDsNSU[ + '1:6]');
  end;
  putitemXml(viParams, '027-000', item_a('DS_FINALIZACAO', tF_TEF_TRANSACAO));
  putitemXml(viParams, '999-999', '0');
  putitemXml(viParams, 'DS_EXTENSAO', '001');
  putitemXml(viParams, 'IN_P1', False);
  if (gTpTEF = 2) then begin
    putitemXml(viParams, 'CD_EMPRESA', item_f('CD_EMPRESA', tF_TEF_TRANSACAO));
    putitemXml(viParams, 'DT_MOVIMENTO', item_a('DT_MOVIMENTO', tF_TEF_TRANSACAO));
    putitemXml(viParams, 'NR_SEQ', item_f('NR_SEQ', tF_TEF_TRANSACAO));
  end;
  voParams := activateCmp('TEFSVCO010', 'geraArquivoREQ', viParams); (*,,,, *)
  if (xStatus < 0) then begin
    Result := voParams;
    return(-1); exit;
  end;
    if (xStatus < 0) then begin
      Result := voParams;
      return(-1); exit;
    end;
    if (item_f('VL_TRANSACAO', tF_TEF_TRANSACAO) = 0 ) and (item_f('NR_NSU', tF_TEF_TRANSACAO) = 0) then begin
      Result := SetStatus(STS_ERROR, 'GEN0001', 'Cancelada transação: Rede: ' + NM_REDETEF + '.F_TEF_TRANSACAO', '');
    end else if (item_f('VL_TRANSACAO', tF_TEF_TRANSACAO) = 0 ) and (item_f('NR_NSU', tF_TEF_TRANSACAO) > 0) then begin
      Result := SetStatus(STS_ERROR, 'GEN0001', 'Cancelada transação: Rede: ' + NM_REDETEF + '.F_TEF_TRANSACAO Doc. Nr.: ' + NR_NSU + '.F_TEF_TRANSACAO', '');
    end else begin
      if (gTpTEF = 1) then begin
        Result := SetStatus(STS_ERROR, 'GEN0001', 'Transação não efetuada. Favor reter o cupom!', '');
      end else begin
        Result := SetStatus(STS_ERROR, 'GEN0001', 'Cancelada transação: Rede: ' + NM_REDETEF + '.F_TEF_TRANSACAO Doc. Nr.: ' + NR_NSU + '.F_TEF_TRANSACAOVALOR: ' + VL_TRANSACAO + '.F_TEF_TRANSACAO', '');
      end;
    end;
  end else if (gTpTEF = 2) then begin
    vInLoopConfirmacao := False;
    repeat
      Result := SetStatus(STS_ERROR, {xCdErro} '', '{xCtxErro} ''', '');
      message/hint 'Aguardando comunicação...';
      voParams := activateCmp('TEFSVCO010', 'geraArquivoREQ', viParams); (*,,,, *)
      if (xStatus < 0) then begin
        Result := voParams;
        return(-1); exit;
      end;
        if (xStatus < 0) then begin
          Result := voParams;
          return(-1); exit;
        end;
        if (item_f('VL_TRANSACAO', tF_TEF_TRANSACAO) = 0 ) and (item_f('NR_NSU', tF_TEF_TRANSACAO) = 0) then begin
          Result := SetStatus(STS_ERROR, 'GEN0001', 'Cancelada transação: Rede: ' + NM_REDETEF + '.F_TEF_TRANSACAO', '');
        end else if (item_f('VL_TRANSACAO', tF_TEF_TRANSACAO) = 0 ) and (item_f('NR_NSU', tF_TEF_TRANSACAO) > 0) then begin
          Result := SetStatus(STS_ERROR, 'GEN0001', 'Cancelada transação: Rede: ' + NM_REDETEF + '.F_TEF_TRANSACAO Doc. Nr.: ' + NR_NSU + '.F_TEF_TRANSACAO', '');
        end else begin
          Result := SetStatus(STS_ERROR, 'GEN0001', 'Cancelada transação: Rede: ' + NM_REDETEF + '.F_TEF_TRANSACAO Doc. Nr.: ' + NR_NSU + '.F_TEF_TRANSACAO Valor: ' + VL_TRANSACAO + '.F_TEF_TRANSACAO', '');
        end;
        vInLoopConfirmacao := True;
      end;
      message/hint ' ';
    until (vInLoopConfirmacao := True);
  end else if (xStatus < 0) then begin
    Result := SetStatus(STS_ERROR, {xCdErro} '', '{xCtxErro} ''', '');
  end;

  return(0); exit;

end;

//--------------------------------------------------------------------------
function TF_TRAFM080.efetivaTEFPendenteGeral_CNF(pParams : String) : String;
//--------------------------------------------------------------------------
const
  cDS_METHOD = 'ADICIONAL=Operação: TF_TRAFM080.efetivaTEFPendenteGeral_CNF()';
var
  viParams, voParams : String;
  vInLoopConfirmacao, vInLoopImpressao : Boolean;
begin
  viParams := '';
  putitemXml(viParams, '000-000', 'CNF');
  putitemXml(viParams, '001-000', item_f('NR_SEQ', tF_TEF_TRANSACAO));
  putitemXml(viParams, '010-000', item_a('NM_REDETEF', tF_TEF_TRANSACAO));

  gNrNSU6DIG := item_f('NR_NSU', tF_TEF_TRANSACAO);
  gDsNSU := '' + NR_NSU + '.F_TEF_TRANSACAO';
  putitemXml(viParams, '012-000', item_f('NR_NSU', tF_TEF_TRANSACAO));

  if (item_a('NM_REDETEF', tF_TEF_TRANSACAO) = 'TECBAN') then begin
    putitemXml(viParams, '012-000', '' + gDsNSU[ + '1:6]');
  end;
  putitemXml(viParams, '027-000', item_a('DS_FINALIZACAO', tF_TEF_TRANSACAO));
  putitemXml(viParams, '999-999', '0');
  putitemXml(viParams, 'DS_EXTENSAO', '001');
  putitemXml(viParams, 'IN_P1', False);
  voParams := activateCmp('TEFSVCO010', 'geraArquivoREQ', viParams); (*,,,, *)
  if (xStatus < 0) then begin
    Result := voParams;
    return(-1); exit;
  end;
    if (xStatus < 0) then begin
      Result := voParams;
      return(-1); exit;
    end;
  end else if (gTpTEF = 2) then begin
    vInLoopConfirmacao := False;
    repeat
      Result := SetStatus(STS_ERROR, {xCdErro} '', '{xCtxErro} ''', '');
      message/hint 'Aguardando comunicação...';
      voParams := activateCmp('TEFSVCO010', 'geraArquivoREQ', viParams); (*,,,, *)
      if (xStatus < 0) then begin
        Result := voParams;
        return(-1); exit;
      end;
        if (xStatus < 0) then begin
          Result := voParams;
          return(-1); exit;
        end;
        vInLoopConfirmacao := True;
      end;
      message/hint ' ';
    until (vInLoopConfirmacao := True);
  end;

  return(0); exit;
end;

//--------------------------------------------------------------------------
function TF_TRAFM080.efetivaTEFPendenteGeral_CNC(pParams : String) : String;
//--------------------------------------------------------------------------
const
  cDS_METHOD = 'ADICIONAL=Operação: TF_TRAFM080.efetivaTEFPendenteGeral_CNC()';
var
  (* string vDsMensagem : IN / string vDsConteudo : IN / numeric vNrSequencia : IN *)
  viParams, voParams, vDsLstCupom, vDsRegistro, vDsAprovado, vDsLstEmpresa : String;
  vInLoopConfirmacao, vInLoopImpressao : Boolean;
  vNrLinhaCupom : Real;
begin
  vDsLstCupom := '';
  vDsRegistro := '';
  putitemXml(vDsRegistro, 'DS_MENSAGEM', vDsMensagem);
  putitemXml(vDsRegistro, 'DS_CUPOM', vDsConteudo);
  putitem(vDsLstCupom,  vDsRegistro);
  viParams := '';
  putitemXml(viParams, 'DS_LSTCUPOM', vDsLstCupom);
  putitemXml(viParams, 'DS_FORMAPGTO', '');
  putitemXml(viParams, 'TP_IMPRESSAO', 2);
  voParams := activateCmp('TEFFP002', 'EXEC', viParams); (*,,, *)
  if (xStatus < 0) then begin
    Result := voParams;
    return(-1); exit;
  end;
        clear_e(tTEF_TRANSACAO);
        putitem_e(tTEF_TRANSACAO, 'CD_EMPRESA', item_f('CD_EMPRESA', tF_TEF_TRANSACAO));
        putitem_e(tTEF_TRANSACAO, 'DT_MOVIMENTO', item_a('DT_MOVIMENTO', tF_TEF_TRANSACAO));
        putitem_e(tTEF_TRANSACAO, 'CD_ARQUIVO', 'CNC');
        putitem_e(tTEF_TRANSACAO, 'TP_TRANSACAO', item_f('TP_TRANSACAO', tF_TEF_TRANSACAO));
        putitem_e(tTEF_TRANSACAO, 'NR_NSUAUX', item_f('NR_NSU', tF_TEF_TRANSACAO));
        retrieve_e(tTEF_TRANSACAO);
        if (xStatus >= 0) then begin
          putitemXml(viParams, '000-000', 'NCN');
          putitemXml(viParams, '001-000', item_f('NR_SEQ', tTEF_TRANSACAO));
          putitemXml(viParams, '010-000', item_a('NM_REDETEF', tTEF_TRANSACAO));
          putitemXml(viParams, '012-000', item_f('NR_NSU', tTEF_TRANSACAO));
          putitemXml(viParams, '027-000', item_a('DS_FINALIZACAO', tTEF_TRANSACAO));
        end else begin
          putitemXml(viParams, '000-000', 'NCN');
          putitemXml(viParams, '001-000', item_f('NR_SEQ', tF_TEF_TRANSACAO));
          putitemXml(viParams, '010-000', item_a('NM_REDETEF', tF_TEF_TRANSACAO));

          gNrNSU6DIG := item_f('NR_NSU', tF_TEF_TRANSACAO);
          gDsNSU := '' + NR_NSU + '.F_TEF_TRANSACAO';
          putitemXml(viParams, '012-000', item_f('NR_NSU', tF_TEF_TRANSACAO));

          if (item_a('NM_REDETEF', tF_TEF_TRANSACAO) = 'TECBAN') then begin
            putitemXml(viParams, '012-000', '' + gDsNSU[ + '1:6]');
          end;
          putitemXml(viParams, '027-000', item_a('DS_FINALIZACAO', tF_TEF_TRANSACAO));
        end;

          putitemXml(viParams, '999-999', '0');
          putitemXml(viParams, 'DS_EXTENSAO', '001');
          putitemXml(viParams, 'IN_P1', False);
          voParams := activateCmp('TEFSVCO010', 'geraArquivoREQ', viParams); (*,,,, *)
          if (xStatus < 0) then begin
            Result := voParams;
            return(-1); exit;
          end;
          end else if (gTpTEF = 2) then begin
            vInLoopConfirmacao := False;
            repeat
              Result := SetStatus(STS_ERROR, {xCdErro} '', '{xCtxErro} ''', '');
              message/hint 'Aguardando comunicação...';
              voParams := activateCmp('TEFSVCO010', 'geraArquivoREQ', viParams); (*,,,, *)
              if (xStatus < 0) then begin
                Result := voParams;
                return(-1); exit;
              end;
                        vInLoopConfirmacao := True;
              end;
              message/hint ' ';
          until (vInLoopConfirmacao := True);
        end;
      end else begin
        viParams := '';
          putitemXml(viParams, 'DS_LSTCUPOM', vDsLstCupom);
        putitemXml(viParams, 'DS_FORMAPGTO', '');
        putitemXml(viParams, 'TP_IMPRESSAO', 2);
        voParams := activateCmp('TEFFP002', 'EXEC', viParams); (*,,, *)
        if (xStatus < 0) then begin
          Result := voParams;
          return(-1); exit;
        end;
        if (xStatus >= 0) then begin
          viParams := '';

          clear_e(tTEF_TRANSACAO);
          putitem_e(tTEF_TRANSACAO, 'CD_EMPRESA', item_f('CD_EMPRESA', tF_TEF_TRANSACAO));
          putitem_e(tTEF_TRANSACAO, 'DT_MOVIMENTO', item_a('DT_MOVIMENTO', tF_TEF_TRANSACAO));
          putitem_e(tTEF_TRANSACAO, 'CD_ARQUIVO', 'CNC');
          putitem_e(tTEF_TRANSACAO, 'TP_TRANSACAO', item_f('TP_TRANSACAO', tF_TEF_TRANSACAO));
          putitem_e(tTEF_TRANSACAO, 'NR_NSUAUX', item_f('NR_NSU', tF_TEF_TRANSACAO));
          retrieve_e(tTEF_TRANSACAO);
          if (xStatus >= 0) then begin
            putitemXml(viParams, '000-000', 'CNF');
            putitemXml(viParams, '001-000', vNrSequencia);
            putitemXml(viParams, '010-000', item_a('NM_REDETEF', tTEF_TRANSACAO));
            putitemXml(viParams, '012-000', item_f('NR_NSU', tTEF_TRANSACAO));
            putitemXml(viParams, '027-000', item_a('DS_FINALIZACAO', tTEF_TRANSACAO));
          end else begin

            putitemXml(viParams, '000-000', 'CNF');
            putitemXml(viParams, '001-000', vNrSequencia);
            putitemXml(viParams, '010-000', item_a('NM_REDETEF', tF_TEF_TRANSACAO));

            gNrNSU6DIG := item_f('NR_NSU', tF_TEF_TRANSACAO);
            gDsNSU := '' + NR_NSU + '.F_TEF_TRANSACAO';
            putitemXml(viParams, '012-000', item_f('NR_NSU', tF_TEF_TRANSACAO));

            if (item_a('NM_REDETEF', tF_TEF_TRANSACAO) = 'TECBAN') then begin
              putitemXml(viParams, '012-000', '' + gDsNSU[ + '1:6]');
            end;
            putitemXml(viParams, '027-000', item_a('DS_FINALIZACAO', tF_TEF_TRANSACAO));
          end;
          putitemXml(viParams, '999-999', '0');
          putitemXml(viParams, 'DS_EXTENSAO', '001');
          putitemXml(viParams, 'IN_P1', False);
          voParams := activateCmp('TEFSVCO010', 'geraArquivoREQ', viParams); (*,,,, *)
          if (xStatus < 0) then begin
            Result := voParams;
            return(-1); exit;
          end;
              if (xStatus < 0) then begin
                Result := voParams;
                return(-1); exit;
              end;
              message/hint ' ';
            until (vInLoopConfirmacao := True);
          end;

          viParams := '';
          putitemXml(viParams, 'CD_EMPRESA', item_f('CD_EMPRESA', tF_TEF_TRANSACAO));
          putitemXml(viParams, 'DT_MOVIMENTO', item_a('DT_MOVIMENTO', tF_TEF_TRANSACAO));
          putitemXml(viParams, 'NR_SEQ', vNrSequencia);
          putitemXml(viParams, 'TP_SITUACAO', 3);
          newinstance 'TEFSVCO011', 'TEFSVCO011', 'TRANSACTION=TRUE';
          voParams := activateCmp('TEFSVCO011', 'alteraSituacao', viParams); (*,,,, *)
          if (xStatus < 0) then begin
            Result := voParams;
            return(-1); exit;
          end;

          clear_e(tTEF_TRANSACAO);
          putitem_e(tTEF_TRANSACAO, 'CD_EMPRESA', item_f('CD_EMPRESA', tF_TEF_TRANSACAO));
          putitem_e(tTEF_TRANSACAO, 'DT_MOVIMENTO', item_a('DT_MOVIMENTO', tF_TEF_TRANSACAO));
          putitem_e(tTEF_TRANSACAO, 'CD_ARQUIVO', 'CRT');
          putitem_e(tTEF_TRANSACAO, 'TP_TRANSACAO', item_f('TP_TRANSACAO', tF_TEF_TRANSACAO));
          putitem_e(tTEF_TRANSACAO, 'NR_NSU', item_f('NR_NSU', tF_TEF_TRANSACAO));
          retrieve_e(tTEF_TRANSACAO);

          viParams := '';
          putitemXml(viParams, 'CD_EMPRESA', item_f('CD_EMPRESA', tTEF_TRANSACAO));
          putitemXml(viParams, 'DT_MOVIMENTO', item_a('DT_MOVIMENTO', tTEF_TRANSACAO));
          putitemXml(viParams, 'NR_SEQ', item_f('NR_SEQ', tTEF_TRANSACAO));
          putitemXml(viParams, 'TP_SITUACAO', -1);
          newinstance 'TEFSVCO011', 'TEFSVCO011', 'TRANSACTION=TRUE';
          voParams := activateCmp('TEFSVCO011', 'alteraSituacao', viParams); (*,,,, *)
          if (xStatus < 0) then begin
            Result := voParams;
            return(-1); exit;
          end;
          vInLoopImpressao := False;
        end;
      end;
    until (vInLoopImpressao := False);
  end else begin

    clear_e(tTEF_TRANSACAO);
    putitem_e(tTEF_TRANSACAO, 'CD_EMPRESA', item_f('CD_EMPRESA', tF_TEF_TRANSACAO));
    putitem_e(tTEF_TRANSACAO, 'DT_MOVIMENTO', item_a('DT_MOVIMENTO', tF_TEF_TRANSACAO));
    putitem_e(tTEF_TRANSACAO, 'CD_ARQUIVO', 'CNC');
    putitem_e(tTEF_TRANSACAO, 'TP_TRANSACAO', item_f('TP_TRANSACAO', tF_TEF_TRANSACAO));
    putitem_e(tTEF_TRANSACAO, 'TP_SITUACAO', 1);
    putitem_e(tTEF_TRANSACAO, 'NR_NSUAUX', item_f('NR_NSU', tF_TEF_TRANSACAO));
    retrieve_e(tTEF_TRANSACAO);
    if (xStatus >= 0) then begin
      putitemXml(viParams, '000-000', 'CNF');
      putitemXml(viParams, '001-000', vNrSequencia);
      putitemXml(viParams, '010-000', item_a('NM_REDETEF', tTEF_TRANSACAO));
      putitemXml(viParams, '012-000', item_f('NR_NSU', tTEF_TRANSACAO));
      putitemXml(viParams, '027-000', item_a('DS_FINALIZACAO', tTEF_TRANSACAO));
    end else begin
      putitemXml(viParams, '000-000', 'CNF');
      putitemXml(viParams, '001-000', vNrSequencia);
      putitemXml(viParams, '010-000', item_a('NM_REDETEF', tF_TEF_TRANSACAO));

      gNrNSU6DIG := item_f('NR_NSU', tF_TEF_TRANSACAO);
      gDsNSU := '' + NR_NSU + '.F_TEF_TRANSACAO';
      putitemXml(viParams, '012-000', item_f('NR_NSU', tF_TEF_TRANSACAO));

      if (item_a('NM_REDETEF', tF_TEF_TRANSACAO) = 'TECBAN') then begin
        putitemXml(viParams, '012-000', '' + gDsNSU[ + '1:6]');
      end;
      putitemXml(viParams, '027-000', item_a('DS_FINALIZACAO', tF_TEF_TRANSACAO));
    end;

    putitemXml(viParams, '999-999', '0');
    putitemXml(viParams, 'DS_EXTENSAO', '001');
    putitemXml(viParams, 'IN_P1', False);
    voParams := activateCmp('TEFSVCO010', 'geraArquivoREQ', viParams); (*,,,, *)
    if (xStatus < 0) then begin
      Result := voParams;
      return(-1); exit;
    end;
          if (xStatus < 0) then begin
            Result := voParams;
            return(-1); exit;
          end;
        message/hint ' ';
      until (vInLoopConfirmacao := True);
    end;

    viParams := '';
    putitemXml(viParams, 'CD_EMPRESA', item_f('CD_EMPRESA', tF_TEF_TRANSACAO));
    putitemXml(viParams, 'DT_MOVIMENTO', item_a('DT_MOVIMENTO', tF_TEF_TRANSACAO));
    putitemXml(viParams, 'NR_SEQ', vNrSequencia);
    putitemXml(viParams, 'TP_SITUACAO', 3);
    newinstance 'TEFSVCO011', 'TEFSVCO011', 'TRANSACTION=TRUE';
    voParams := activateCmp('TEFSVCO011', 'alteraSituacao', viParams); (*,,,, *)
    if (xStatus < 0) then begin
      Result := voParams;
      return(-1); exit;
    end;

    viParams := '';
    putitemXml(viParams, 'CD_EMPRESA', item_f('CD_EMPRESA', tF_TEF_TRANSACAO));
    putitemXml(viParams, 'DT_MOVIMENTO', item_a('DT_MOVIMENTO', tF_TEF_TRANSACAO));
    putitemXml(viParams, 'NR_SEQ', item_f('NR_SEQ', tF_TEF_TRANSACAO));
    putitemXml(viParams, 'TP_SITUACAO', -1);
    newinstance 'TEFSVCO011', 'TEFSVCO011', 'TRANSACTION=TRUE';
    voParams := activateCmp('TEFSVCO011', 'alteraSituacao', viParams); (*,,,, *)
    if (xStatus < 0) then begin
      Result := voParams;
      return(-1); exit;
    end;
  end;

  return(0); exit;

end;

//---------------------------------------------------------------------
function TF_TRAFM080.efetivaTEFPendente_MSG(pParams : String) : String;
//---------------------------------------------------------------------
const
  cDS_METHOD = 'ADICIONAL=Operação: TF_TRAFM080.efetivaTEFPendente_MSG()';
var
  (* numeric vCdEmpresa : IN / numeric vNrSeq : IN / date vDtMovimento : IN / numeric vlValor : IN / string vDsRedeTef : IN / numeric vCdOperador : IN *)
  viParams, voParams, vNmLogin : String;
begin
  clear_e(tTEF_RELTRANSACAO);
  putitem_e(tTEF_RELTRANSACAO, 'CD_EMPTEF', vCdEmpresa);
  putitem_e(tTEF_RELTRANSACAO, 'NR_SEQ', vNrSeq);
  putitem_e(tTEF_RELTRANSACAO, 'DT_MOVIMENTO', vDtMovimento);
  retrieve_e(tTEF_RELTRANSACAO);

  clear_e(tADM_USUARIO);
  putitem_e(tADM_USUARIO, 'CD_USUARIO', vCdOperador);
  retrieve_e(tADM_USUARIO);

  if (item_f('CD_USUARIO', tADM_USUARIO) > 0) then begin
    viParams := '';

    putitemXml(viParams, 'CD_USUARIO', item_f('CD_USUARIO', tADM_USUARIO));
    voParams := activateCmp('ADMSVCO027', 'validaUsuarioEspecial', viParams); (*,,,, *)
    if (xStatus < 0) then begin
      Result := voParams;
      return(-1); exit;
    end;
    if (voParams <> '') then begin
      vNmLogin := itemXml('NM_LOGIN', voParams);
    end;
  end else begin
    vNmLogin := '';
  end;

  message/info 'Transacao ' + NR_TRANSACAO + '.TEF_RELTRANSACAO da Empresa ' + CD_EMPTRA + '.TEF_RELTRANSACAO no Valor de ' + vlValor + ' da rede ' + vDsRedeTef + ' efetuada pelo usuario ' + vNmLogin + ' esta pendente na operadora.';

  return(-1); exit;
end;

//---------------------------------------------------------
function TF_TRAFM080.efetua_NCN(pParams : String) : String;
//---------------------------------------------------------
const
  cDS_METHOD = 'ADICIONAL=Operação: TF_TRAFM080.efetua_NCN()';
var
  viParams, voParams : String;
  vInLoopConfirmacao, vInLoopImpressao : Boolean;
begin
  viParams := '';
  putitemXml(viParams, '000-000', 'NCN');
  putitemXml(viParams, '001-000', item_f('NR_SEQ', tTEF_TRANSACAO));
  putitemXml(viParams, '010-000', item_a('NM_REDETEF', tTEF_TRANSACAO));

  gNrNSU6DIG := item_f('NR_NSU', tTEF_TRANSACAO);
  gDsNSU := '' + NR_NSU + '.TEF_TRANSACAO';
  putitemXml(viParams, '012-000', item_f('NR_NSU', tTEF_TRANSACAO));

  if (item_a('NM_REDETEF', tTEF_TRANSACAO) = 'TECBAN') then begin
    putitemXml(viParams, '012-000', '' + gDsNSU[ + '1:6]');
  end;
  putitemXml(viParams, '027-000', item_a('DS_FINALIZACAO', tTEF_TRANSACAO));
  putitemXml(viParams, '999-999', '0');
  putitemXml(viParams, 'DS_EXTENSAO', '001');
  putitemXml(viParams, 'IN_P1', False);
  if (gTpTEF = 2) then begin
    putitemXml(viParams, 'CD_EMPRESA', item_f('CD_EMPRESA', tTEF_TRANSACAO));
    putitemXml(viParams, 'DT_MOVIMENTO', item_a('DT_MOVIMENTO', tTEF_TRANSACAO));
    putitemXml(viParams, 'NR_SEQ', item_f('NR_SEQ', tTEF_TRANSACAO));
  end;
  voParams := activateCmp('TEFSVCO010', 'geraArquivoREQ', viParams); (*,,,, *)
  if (xStatus < 0) then begin
    Result := voParams;
    return(-1); exit;
  end;
    if (xStatus < 0) then begin
      Result := voParams;
      return(-1); exit;
    end;
    if (item_f('VL_TRANSACAO', tTEF_TRANSACAO) = 0 ) and (item_f('NR_NSU', tTEF_TRANSACAO) = 0) then begin
      Result := SetStatus(STS_ERROR, 'GEN0001', 'Cancelada transação: Rede: ' + NM_REDETEF + '.TEF_TRANSACAO', '');
    end else if (item_f('VL_TRANSACAO', tTEF_TRANSACAO) = 0 ) and (item_f('NR_NSU', tTEF_TRANSACAO) > 0) then begin
      Result := SetStatus(STS_ERROR, 'GEN0001', 'Cancelada transação: Rede: ' + NM_REDETEF + '.TEF_TRANSACAO Doc. Nr.: ' + NR_NSU + '.TEF_TRANSACAO', '');
    end else begin
      Result := SetStatus(STS_ERROR, 'GEN0001', 'Cancelada transação: Rede: ' + NM_REDETEF + '.TEF_TRANSACAO Doc. Nr.: ' + NR_NSU + '.TEF_TRANSACAOVALOR: ' + VL_TRANSACAO + '.TEF_TRANSACAO', '');
    end;
  end else if (gTpTEF = 2) then begin
    vInLoopConfirmacao := False;
    repeat
      Result := SetStatus(STS_ERROR, {xCdErro} '', '{xCtxErro} ''', '');
      message/hint 'Aguardando comunicação...';
      voParams := activateCmp('TEFSVCO010', 'geraArquivoREQ', viParams); (*,,,, *)
      if (xStatus < 0) then begin
        Result := voParams;
        return(-1); exit;
      end;
        if (xStatus < 0) then begin
          Result := voParams;
          return(-1); exit;
        end;
        if (item_f('VL_TRANSACAO', tTEF_TRANSACAO) = 0 ) and (item_f('NR_NSU', tTEF_TRANSACAO) = 0) then begin
          Result := SetStatus(STS_ERROR, 'GEN0001', 'Cancelada transação: Rede: ' + NM_REDETEF + '.TEF_TRANSACAO', '');
        end else if (item_f('VL_TRANSACAO', tF_TEF_TRANSACAO) = 0 ) and (item_f('NR_NSU', tF_TEF_TRANSACAO) > 0) then begin
          Result := SetStatus(STS_ERROR, 'GEN0001', 'Cancelada transação: Rede: ' + NM_REDETEF + '.TEF_TRANSACAO Doc. Nr.: ' + NR_NSU + '.TEF_TRANSACAO', '');
        end else begin
          Result := SetStatus(STS_ERROR, 'GEN0001', 'Cancelada transação: Rede: ' + NM_REDETEF + '.TEF_TRANSACAO Doc. Nr.: ' + NR_NSU + '.TEF_TRANSACAOVALOR: ' + VL_TRANSACAO + '.TEF_TRANSACAO', '');
        end;
        vInLoopConfirmacao := True;
      end;
      message/hint ' ';
    until (vInLoopConfirmacao := True);
  end;

  return(0); exit;
end;

//---------------------------------------------------------
function TF_TRAFM080.efetua_CNF(pParams : String) : String;
//---------------------------------------------------------
const
  cDS_METHOD = 'ADICIONAL=Operação: TF_TRAFM080.efetua_CNF()';
var
  viParams, voParams : String;
  vInLoopConfirmacao, vInLoopImpressao : Boolean;
begin
  viParams := '';
  putitemXml(viParams, '000-000', 'CNF');
  putitemXml(viParams, '001-000', item_f('NR_SEQ', tTEF_TRANSACAO));
  putitemXml(viParams, '010-000', item_a('NM_REDETEF', tTEF_TRANSACAO));

  gNrNSU6DIG := item_f('NR_NSU', tTEF_TRANSACAO);
  gDsNSU := '' + NR_NSU + '.TEF_TRANSACAO';
  putitemXml(viParams, '012-000', item_f('NR_NSU', tTEF_TRANSACAO));

  if (item_a('NM_REDETEF', tTEF_TRANSACAO) = 'TECBAN') then begin
    putitemXml(viParams, '012-000', '' + gDsNSU[ + '1:6]');
  end;
  putitemXml(viParams, '027-000', item_a('DS_FINALIZACAO', tTEF_TRANSACAO));
  putitemXml(viParams, '999-999', '0');
  putitemXml(viParams, 'DS_EXTENSAO', '001');
  putitemXml(viParams, 'IN_P1', False);
  voParams := activateCmp('TEFSVCO010', 'geraArquivoREQ', viParams); (*,,,, *)
  if (xStatus < 0) then begin
    Result := voParams;
    return(-1); exit;
  end;
    if (xStatus < 0) then begin
      Result := voParams;
      return(-1); exit;
    end;
  end else if (gTpTEF = 2) then begin
    vInLoopConfirmacao := False;
    repeat
      Result := SetStatus(STS_ERROR, {xCdErro} '', '{xCtxErro} ''', '');
      message/hint 'Aguardando comunicação...';
      voParams := activateCmp('TEFSVCO010', 'geraArquivoREQ', viParams); (*,,,, *)
      if (xStatus < 0) then begin
        Result := voParams;
        return(-1); exit;
      end;
        if (xStatus < 0) then begin
          Result := voParams;
          return(-1); exit;
        end;
        vInLoopConfirmacao := True;
      end;
      message/hint ' ';
    until (vInLoopConfirmacao := True);
  end;

  return(0); exit;
end;

//------------------------------------------------------------
function TF_TRAFM080.bonusDesconto(pParams : String) : String;
//------------------------------------------------------------
const
  cDS_METHOD = 'ADICIONAL=Operação: TF_TRAFM080.bonusDesconto()';
var
  vTpBonus, vVlBonus : Real;
  viParams, voParams : String;
begin
  vTpBonus := itemXmlF('TP_BONUS_DESCONTO', xParamEmp);

  if (vTpBonus <> 1) then begin
    return(0); exit;
  end;

  viParams := '';
  putitemXml(viParams, 'CD_PESSOA', item_f('CD_PESSOA', tTRA_TRANSACAO));
  voParams := activateCmp('PESSVCO035', 'buscaSaldoBonus', viParams); (*,,,, *)
  if (xStatus < 0) then begin
    Result := voParams;
    return(-1); exit;
  end;

  vVlBonus := itemXmlF('VL_BONUS', voParams);

  if (vVlBonus <= 0) then begin
    return(0); exit;
  end;

  viParams := '';
  putitemXml(viParams, 'CD_EMPRESA', item_f('CD_EMPRESA', tTRA_TRANSACAO));
  putitemXml(viParams, 'NR_TRANSACAO', item_f('NR_TRANSACAO', tTRA_TRANSACAO));
  putitemXml(viParams, 'DT_TRANSACAO', item_a('DT_TRANSACAO', tTRA_TRANSACAO));
  //keyboard := 'KB_GLOBAL';
  voParams := activateCmp('TRAFP060', 'EXEC', viParams); (*,,, *)
  //keyboard := 'KB_PDV';
  if (xStatus < 0) then begin
    Result := voParams;
    return(-1); exit;
  end;

  return(0); exit;
end;

//----------------------------------------------------------
function TF_TRAFM080.mostraTotal(pParams : String) : String;
//----------------------------------------------------------
const
  cDS_METHOD = 'ADICIONAL=Operação: TF_TRAFM080.mostraTotal()';
var
  vNrOcc, vTpValidacaoConf : Real;
begin
  vTpValidacaoConf := itemXmlF('TP_VALIDACAO_CONF_TRA', xParamEmp);

  if (empty(tTRA_TRANSITEM) = False) then begin
    vNrOcc := curocc(tTRA_TRANSITEM);
    setocc(tTRA_TRANSITEM, 1);
    while (xStatus >= 0) do begin
      if (gInMostraTotal = True) then begin
        fieldsyntax item_f('NR_ITEM', tTRA_TRANSITEM), 'HID';
      end else begin
        fieldsyntax item_f('NR_ITEM', tTRA_TRANSITEM), '';
      end;
      setocc(tTRA_TRANSITEM, curocc(tTRA_TRANSITEM) + 1);
    end;
    setocc(tTRA_TRANSITEM, 1);
  end;
  if (gInMostraTotal = True) then begin
    gInMostraTotal := False;
    putitem_e(tTRA_TRANSACAO, 'BT_MOSTRATOTAL', 'Mostrar %total');
    fieldsyntax item_a('BT_NRITEM', tSIS_BOTOES2), 'HID';
    fieldsyntax item_f('QT_SOLICITADA', tTRA_TRANSACAO), 'HID';
    fieldsyntax item_f('VL_TRANSACAO', tTRA_TRANSACAO), 'HID';
  end else begin
    gInMostraTotal := True;
    putitem_e(tTRA_TRANSACAO, 'BT_MOSTRATOTAL', 'Omitir %total');
    fieldsyntax item_a('BT_NRITEM', tSIS_BOTOES2), '';
    fieldsyntax item_f('NR_ITEM', tTRA_TRANSITEM), '';
    if (vTpValidacaoConf = 2)  or (vTpValidacaoConf = 3) then begin
      fieldsyntax item_f('QT_SOLICITADA', tTRA_TRANSACAO), 'HID';
    end else begin
      fieldsyntax item_f('QT_SOLICITADA', tTRA_TRANSACAO), '';
    end;
    fieldsyntax item_f('VL_TRANSACAO', tTRA_TRANSACAO), '';
  end;

  gprompt := item_f('CD_PRODUTO', tTRA_TRANSITEM);

  return(0); exit;
end;

//--------------------------------------------------------------------
function TF_TRAFM080.validaItemCoeficiente(pParams : String) : String;
//--------------------------------------------------------------------
const
  cDS_METHOD = 'ADICIONAL=Operação: TF_TRAFM080.validaItemCoeficiente()';
var
  (* numeric piCdProduto : IN / numeric pioVlProduto : INOUT / numeric poQtSolicitada : INOUT *)
  viParams, voParams : String;
  vTpLote : Real;
begin
  if (piCdProduto = 0) then begin
    return(0); exit;
  end;

  clear_e(tPRD_EMBALAGEM);
  putitem_e(tPRD_EMBALAGEM, 'CD_PRODUTO', piCdProduto);
  retrieve_e(tPRD_EMBALAGEM);
  if (xStatus < 0) then begin
    return(0); exit;
  end;

  viParams := '';
  putitemXml(viParams, 'CD_PRODUTO', piCdProduto);
  putitemXml(viParams, 'VL_PRODUTO', pioVlProduto);
  putitemXml(viParams, 'IN_CODIGO', item_b('IN_CODIGO', tSIS_FILTRO));
  putitemXml(viParams, 'CD_BARRAPRD', item_f('CD_BARRAPRD', tSIS_FILTRO));
  //keyboard := 'KB_GLOBAL';
  voParams := activateCmp('PRDFP051', 'EXEC', viParams); (*,,, *)
  //keyboard := 'KB_PDV';
  if (xStatus < 0) then begin
    Result := voParams;
    return(-1); exit;
  end;

  pioVlProduto := itemXmlF('VL_UNITARIO', voParams);
  poQtSolicitada := itemXmlF('QT_EMBALAGEM', voParams);

  return(0); exit;
end;

//--------------------------------------------------------------
function TF_TRAFM080.excluiSimulacao(pParams : String) : String;
//--------------------------------------------------------------
const
  cDS_METHOD = 'ADICIONAL=Operação: TF_TRAFM080.excluiSimulacao()';
var
  viParams, voParams : String;
begin
  viParams := '';
  putitemXml(viParams, 'CD_EMPRESA', item_f('CD_EMPRESA', tTRA_TRANSACAO));
  putitemXml(viParams, 'NR_TRANSACAO', item_f('NR_TRANSACAO', tTRA_TRANSACAO));
  putitemXml(viParams, 'DT_TRANSACAO', item_a('DT_TRANSACAO', tTRA_TRANSACAO));
  voParams := activateCmp('TRASVCO017', 'excluiSimulacao', viParams); (*,,,, *)

  commit;
  if (xStatus < 0) then begin
    rollback;
    return(-1); exit;
  end else begin
    voParams := SetHint(viParams); (* 'ID=APLINFO002' *)
  end;

  voParams := recarregaTransacao(viParams); (* *)
  if (xStatus < 0) then begin
    Result := voParams;
    return(-1); exit;
  end;

  return(0); exit;
end;

//-----------------------------------------------------
function TF_TRAFM080.portal(pParams : String) : String;
//-----------------------------------------------------
const
  cDS_METHOD = 'ADICIONAL=Operação: TF_TRAFM080.portal()';
var
  viParams, voParams, vDsLstProduto : String;
begin
  viParams := '';
  putitemXml(viParams, 'IN_QUANTIDADEFIXO', True);
  putitemXml(viParams, 'IN_SOMENTELEITURA', False);
  //keyboard := 'KB_GLOBAL';
  voParams := activateCmp('GERFP042', 'EXEC', viParams); (*,,, *)
  //keyboard := 'KB_PDV';
  if (xStatus < 0) then begin
    Result := voParams;
    return(-1); exit;
  end;

  vDsLstProduto := itemXml('DS_LSTPRODUTO', voParams);

  if (vDsLstProduto <> '') then begin
    voParams := entradaColetor(viParams); (* vDsLstProduto *)
    if (xStatus < 0) then begin
      Result := voParams;
      return(-1); exit;
    end;
    if (dbocc(t'TRA_TRANSACAO')) then begin
      voParams := recarregaTransacao(viParams); (* *)
      if (xStatus < 0) then begin
        Result := voParams;
        return(-1); exit;
      end;
    end;
  end;

  return(0); exit;
end;

//----------------------------------------------------------------------
function TF_TRAFM080.verificaTransacaoAberta(pParams : String) : String;
//----------------------------------------------------------------------
const
  cDS_METHOD = 'ADICIONAL=Operação: TF_TRAFM080.verificaTransacaoAberta()';
var
  viParams, voParams : String;
begin
  clear_e(tF_TRA_TRANSACAO);
  putitem_e(tF_TRA_TRANSACAO, 'CD_EMPRESA', itemXmlF('CD_EMPRESA', PARAM_GLB));
  putitem_e(tF_TRA_TRANSACAO, 'CD_OPERADOR', itemXmlF('CD_USUARIO', PARAM_GLB));
  putitem_e(tF_TRA_TRANSACAO, 'DT_TRANSACAO', itemXml('DT_SISTEMA', PARAM_GLB));
  putitem_e(tF_TRA_TRANSACAO, 'TP_SITUACAO', 1);
  putitem_e(tF_TRA_TRANSACAO, 'TP_OPERACAO', 'S');
  putitem_e(tF_TRA_TRANSACAO, 'CD_OPERACAO', gCdOperacaoVenda);
  retrieve_e(tF_TRA_TRANSACAO);
  if (xStatus >= 0) then begin
    setocc(tF_TRA_TRANSACAO, 1);
    while (xStatus > 0) do begin

      voParams := setDisplay(viParams); (* 'Aguarde, cancelando transação: ' + NR_TRANSACAO + '.F_TRA_TRANSACAO', '', '' *)
      if (xStatus < 0) then begin
        Result := voParams;
        return(-1); exit;
      end;

      viParams := '';
      putitemXml(viParams, 'CD_EMPRESA', item_f('CD_EMPRESA', tF_TRA_TRANSACAO));
      putitemXml(viParams, 'NR_TRANSACAO', item_f('NR_TRANSACAO', tF_TRA_TRANSACAO));
      putitemXml(viParams, 'DT_TRANSACAO', item_a('DT_TRANSACAO', tF_TRA_TRANSACAO));
      putitemXml(viParams, 'DS_MOTIVO', 'CANCELAMENTO AUTOMATICO DE TRANSACAO DO USUARIO');
      putitemXml(viParams, 'TP_SITUACAONF', 'C');
      putitemXml(viParams, 'IN_PEDIDO', False);
      putitemXml(viParams, 'TP_QUANTIDADEPED', 'S');
      putitemXml(viParams, 'CD_CONFERENTE', itemXmlF('CD_USUARIO', PARAM_GLB));
      putitemXml(viParams, 'CD_COMPONENTE', TRAFM080);
      voParams := activateCmp('TRASVCO013', 'cancelaTransacao', viParams); (*,,,, *)
      if (xStatus < 0) then begin
        Result := voParams;
        return(-1); exit;
      end;

      setocc(tF_TRA_TRANSACAO, curocc(tF_TRA_TRANSACAO) + 1);
    end;

    commit;
    if (xStatus < 0) then begin
      rollback;
    end;
  end;

  return(0); exit;

end;

end.
