unit cTRAFM066;

interface

(* COMPONENTES 
  ADMFM020 / ADMSVCO001 / ADMSVCO009 / ADMSVCO027 / COMSVCO002
  CTCSVCO001 / CTCSVCO004 / ECFSVCO001 / ECFSVCO010 / FCCSVCO002
  FCRFC075 / FCRFL011 / FCRFP001 / FCRFP085 / FCRFP098
  FCRSVCO001 / FCRSVCO005 / FCRSVCO007 / FCRSVCO012 / FCRSVCO015
  FCRSVCO019 / FCRSVCO057 / FCRSVCO068 / FCRSVCO090 / FCRSVCO119
  FCXSVCO001 / FCXSVCO005 / FGRFM001 / FGRFM002 / FGRFM003
  FGRFM007 / FGRSVCO024 / FISFP008 / FISSVCO004 / FISSVCO038
  GERFL069 / GERFP008 / GERSVCO013 / GERSVCO031 / GERSVCO034
  GERSVCO054 / GERSVCO058 / IMBSVCO003 / PESSVCO005 / PESSVCO011
  PESSVCO035 / ROYSVCO001 / SICSVCO001 / SICSVCO005 / SISFP002
  TEFFP002 / TEFSVCO010 / TEFSVCO011 / TRAFM067 / TRAFP004
  TRAFP012 / TRAFP039 / TRASVCO004 / TRASVCO011 / TRASVCO016
  TRASVCO017 / TRASVCO019 / TRASVCO022 / TRASVCO032 / 
*)        

uses
  Classes, SysUtils, Math, DB,
  cServiceUnf, cDataSetUnf;

type
  T_TRAFM066 = class(TcServiceUnf)
  private
    tCTC_TRACARTAO,
    tF_FCR_FATURAI,
    tF_TEF_TRANSACAO,
    tF_TMP_K02NR10,
    tFCR_CHEQUE,
    tFCR_DOFNI,
    tFCR_FATURAI,
    tFCX_HISTREL,
    tFCX_HISTRELSUB,
    tFGR_PORTADOR,
    tFIS_NF,
    tFIS_NFVENCTO,
    tGER_EMPRESA,
    tGER_OPERACAO,
    tNR_PARCELA,
    tNR_POSOCC,
    tPED_PEDIDOC,
    tPED_PEDIDOTRA,
    tPED_PEDTIPODESC,
    tR_TRA_TRANSACAO,
    tSIS_ADIANTAMENTO,
    tSIS_BOTOES2,
    tSIS_DUMMY3,
    tSIS_PESSOA,
    tSIS_TOTAL,
    tSIS_VALOR,
    tTEF_RELTRANSACAO,
    tTEF_TIPOTRANS,
    tTEF_TRANSACAO,
    tTMP_K02NR10,
    tTMP_K04NRDS,
    tTMP_NR10,
    tTRA_LIMDESCONTO,
    tTRA_S_TRANSACAO,
    tTRA_TRANSACADIC,
    tTRA_TRANSACAO,
    tTRA_TROCA : TcDatasetUnf;
    function getParam(pParams : String = '') : String;
    function setEntidade(pParams : String = '') : String;
  protected
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;    
  published
    function preCLEAR(pParams : String = '') : String;
    function preEDIT(pParams : String = '') : String;
    function posEDIT(pParams : String = '') : String;
    function preQUIT(pParams : String = '') : String;
    function INIT(pParams : String = '') : String;
    function CLEANUP(pParams : String = '') : String;
    function carregaCtaCliente(pParams : String = '') : String;
    function carregaCaixa(pParams : String = '') : String;
    function carregaAdiantamento(pParams : String = '') : String;
    function carregaVlMaxTroco(pParams : String = '') : String;
    function carregaVlBrutoLiquido(pParams : String = '') : String;
    function carregaTipoDocumento(pParams : String = '') : String;
    function carregaTransacao(pParams : String = '') : String;
    function validaTransacao(pParams : String = '') : String;
    function criaValor(pParams : String = '') : String;
    function calculaPrazoMedio(pParams : String = '') : String;
    function calculaTotal(pParams : String = '') : String;
    function validaRecebimento(pParams : String = '') : String;
    function descontoPromocional(pParams : String = '') : String;
    function descontoPromocionalCCusto(pParams : String = '') : String;
    function incluiChequeBanda(pParams : String = '') : String;
    function lancaTEF(pParams : String = '') : String;
    function imprimeCupomTEF(pParams : String = '') : String;
    function efetivaTEFPendente(pParams : String = '') : String;
    function efetivaTEFPendente_MSG(pParams : String = '') : String;
    function efetivaTEFPendente_NCN(pParams : String = '') : String;
    function efetivaTEFPendente_CNF(pParams : String = '') : String;
    function efetivaTEFPendente_CNC(pParams : String = '') : String;
    function efetivaTEFPendenteGeral_NCN(pParams : String = '') : String;
    function efetivaTEFPendenteGeral_CNF(pParams : String = '') : String;
    function efetivaTEFPendenteGeral_CNC(pParams : String = '') : String;
    function gravaRecebimento(pParams : String = '') : String;
    function BT_04(pParams : String = '') : String;
    function BT_05(pParams : String = '') : String;
    function BT_06(pParams : String = '') : String;
    function BT_07(pParams : String = '') : String;
    function BT_08(pParams : String = '') : String;
    function BT_09(pParams : String = '') : String;
    function BT_03(pParams : String = '') : String;
    function CTRL_09(pParams : String = '') : String;
    function BT_11(pParams : String = '') : String;
    function BT_12(pParams : String = '') : String;
    function carregaSimulacao(pParams : String = '') : String;
    function validaLimite(pParams : String = '') : String;
    function verificaRestricao(pParams : String = '') : String;
    function efetua_NCN(pParams : String = '') : String;
    function efetua_CNF(pParams : String = '') : String;
    function geraNFe(pParams : String = '') : String;
    function imprimirCupomPresente(pParams : String = '') : String;
    function getNrDocumento(pParams : String = '') : String;
  end;

implementation

uses
  cADMSVCO001,
  cActivate, cStatus, cFuncao, cXml, dModulo;

var
  g%%,
  gCdCartao,
  gCdClientePDV,
  gCdEmpContrato,
  gCdEmpECF,
  gCdEmpLiq,
  gCdEmpresa,
  gCdModeloNFPromissoria,
  gCdPessoa,
  gCdReciboTra,
  gCdTerminal,
  gCdUsuLib,
  gData,
  gDsContrato,
  gDsLimiteCredito,
  gDsLstTpDocumento,
  gDsLstTransacao,
  gDsNSU,
  gDsUltimaConta,
  gDtAbertura,
  gDtLiq,
  gDtTEF,
  gHrFim,
  gHrInicio,
  gHrTEF,
  gHrTempo,
  gHrTotal,
  gInAgrupaCartaoTEF,
  gInCupomAberto,
  gInDesctoAntecFatSimu,
  gIndesF7,
  gInDinheiro,
  gInECF,
  gInEcfCupomPresente,
  gInErroRecebimento,
  gInF6,
  gInF7,
  gInFatura,
  gInFCRFP001,
  gInFinanceiro,
  gInGeraNfeAutomatic,
  gInGeraRegC140Fin,
  gInImpContratoAuto,
  gInLiberaTpDocumento,
  gInParCartaoProprio,
  gInParcelaCheque,
  gInParcelaFatura,
  gInParcelaNotaP,
  gInPDVOtimizado,
  gInPerguntaCpfCnpj,
  gInRecAutomatico,
  gInSimuladorCondPgto,
  gInSimuladorProduto,
  gInTEF,
  gInTroca,
  gInTrocaDocumento,
  gInTrocoMaximo,
  gInUltimaPgtoCartaoTEF,
  gInValidaMsgTroco,
  gInVendaChqClienteBloq,
  gNrCtaCliente,
  gNrCtaUsuario,
  gNrCupom,
  gNrECF,
  gNrExtensao,
  gNrFaturaPadrao,
  gNrFilaSpool,
  gNrNSU6DIG,
  gNrParcelas,
  gNrPrazoMedio,
  gNrPrazoMedMax,
  gNrSeq,
  gNrSeqCartao,
  gNrSeqContrato,
  gNrSeqItemContrato,
  gNrSeqLiq,
  gNrUltimaAgencia,
  gNrUltimoBanco,
  gNrUltimoCheque,
  gprDescBonificPed,
  gprDescMaximo,
  gprDescPontualPed,
  gprDescTransacao,
  gTpBloqAltFat,
  gTpChequePresente,
  gTpDocumento,
  gTpFechamentoRoyalty,
  gTpImpressaoFatVenda,
  gTpImpressaoTEF,
  gTpImpressaoTraVenda,
  gTpImpRichTextVD,
  gTpImpTefPAYGO,
  gTpImpViaCupomTEF,
  gTpImpViaTEF,
  gTpMultiploCartao,
  gTpSimuladorFat,
  gTpTEF,
  gvDsCaminho,
  gvInDescPromocionalCartao,
  gvInTefCartao,
  gVlAdiantamento,
  gVlAnterior,
  gVlCREDEV,
  gVlDisponivel,
  gVlPrazo,
  gVlTotalBruto,
  gVlTotalLiquido,
  gVlTotBonus,
  gVlTrocoMaximo,
  gVlVista,
  gvNrTransacao,
  gxCdNivel : String;

//---------------------------------------------------------------
constructor T_TRAFM066.Create(AOwner: TComponent);
//---------------------------------------------------------------
begin
  inherited Create(AOwner);
  setEntidade('');
end;

//--------------------------------
destructor T_TRAFM066.Destroy;
//--------------------------------
begin
  inherited Destroy;
end;

//---------------------------------------------------------------
function T_TRAFM066.getParam(pParams : String = '') : String;
//---------------------------------------------------------------
var
  piCdEmpresa : Real;
begin
  piCdEmpresa := itemXmlF('CD_EMPRESA', pParams);
  if (piCdEmpresa = 0) then begin
    piCdEmpresa := itemXmlF('CD_EMPRESA', PARAM_GLB);
  end;

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

  xParam := '';
  putitem(xParam, 'CD_EMPLIQ');
  putitem(xParam, 'CLIENTE_PDV');
  putitem(xParam, 'DT_LIQ');
  putitem(xParam, 'IN_FATURA');
  putitem(xParam, 'NR_SEQLIQ');
  putitem(xParam, 'VL_TROCO');

  xParam := T_ADMSVCO001.GetParametro(xParam);


  xParamEmp := '';
  putitem(xParamEmp, 'CD_MOD_IMP_RECEBTRA');
  putitem(xParamEmp, 'CD_MODELO_NF_PROMISSORIA');
  putitem(xParamEmp, 'CD_MOTIVO_ABATI_PED');
  putitem(xParamEmp, 'CD_TIPO_ABATIMENTO_PED');
  putitem(xParamEmp, 'CD_TIPODES_ABATIMENTO_PED');
  putitem(xParamEmp, 'CD_TIPODESC_BONIFIC_PED');
  putitem(xParamEmp, 'CD_TIPODESC_PONTUAL_PED');
  putitem(xParamEmp, 'IN_BLOQ_DT_VENC_VD');
  putitem(xParamEmp, 'IN_DES_FUNCAO7');
  putitem(xParamEmp, 'IN_DESCPROMOCIONAL_CARTAO');
  putitem(xParamEmp, 'IN_DESCTO_ANTEC_FAT_SIMU');
  putitem(xParamEmp, 'IN_ECF_CUPOM_PRESENTE');
  putitem(xParamEmp, 'IN_GERA_NFE_AUTOMATIC');
  putitem(xParamEmp, 'IN_GERA_REGC140_FIN');
  putitem(xParamEmp, 'IN_IMP_CONTRATO_AUTO');
  putitem(xParamEmp, 'IN_IMPRIMI_ECF_NFP');
  putitem(xParamEmp, 'IN_LIMITE_FAMILIAR_VD');
  putitem(xParamEmp, 'IN_MOSTRA_TROCO_RECEB');
  putitem(xParamEmp, 'IN_PDV_OTIMIZADO');
  putitem(xParamEmp, 'IN_PERGUNTA_CPFCNPJ_ECF');
  putitem(xParamEmp, 'IN_SIMULADOR_COND_PGTO');
  putitem(xParamEmp, 'IN_SIMULADOR_FAT_PRODUTO');
  putitem(xParamEmp, 'IN_VALIDA_TROCO');
  putitem(xParamEmp, 'IN_VendA_CHQ_CLIENTE_BLOQ');
  putitem(xParamEmp, 'LIMITE_CREDITO');
  putitem(xParamEmp, 'NR_DIAS_PRAZOMED_LIB_FAT');
  putitem(xParamEmp, 'NR_FILA_SPOOL_NF_PROMIS');
  putitem(xParamEmp, 'NR_PRAZOMEDIO_MAX_FAT');
  putitem(xParamEmp, 'TEF_ESCOLHE_IMP_VIA_CUPOM');
  putitem(xParamEmp, 'TEF_IN_AGRUPA_CARTAO');
  putitem(xParamEmp, 'TEF_TIPO');
  putitem(xParamEmp, 'TEF_ULTIMAPGTO_CARTAO');
  putitem(xParamEmp, 'TP_BLOQ_ALT_FAT_PED');
  putitem(xParamEmp, 'TP_BONUS_DESCONTO');
  putitem(xParamEmp, 'TP_CHEQUE_PRESENTE');
  putitem(xParamEmp, 'TP_COBRANCA_VD');
  putitem(xParamEmp, 'TP_FECHAMENTO_ROYALTY');
  putitem(xParamEmp, 'TP_FORMAPGTO');
  putitem(xParamEmp, 'TP_IMP_RICHTEXT_VD');
  putitem(xParamEmp, 'TP_IMPRESSAO_FAT_VD');
  putitem(xParamEmp, 'TP_IMPRESSAO_TEF');
  putitem(xParamEmp, 'TP_IMPRESSAO_TRA_VD');
  putitem(xParamEmp, 'TP_MULTIPLOS_CARTOES_SIMU');
  putitem(xParamEmp, 'TP_NR_FATURA_CONTRATO');
  putitem(xParamEmp, 'TP_SIMULADOR_FAT');
  putitem(xParamEmp, 'VL_CREDITO_BONUS_DESCONTO');
  putitem(xParamEmp, 'VL_VD_CREDITO_BONUS_DESC');

  xParamEmp := T_ADMSVCO001.GetParamEmpresa(piCdEmpresa, xParamEmp);

  gCdModeloNFPromissoria := itemXml('CD_MODELO_NF_PROMISSORIA', xParamEmp);
  gCdReciboTra := itemXml('CD_MOD_IMP_RECEBTRA', xParamEmp);
  gDsLimiteCredito := itemXml('LIMITE_CREDITO', xParamEmp);
  gInAgrupaCartaoTEF := itemXml('TEF_IN_AGRUPA_CARTAO', xParamEmp);
  gInDesctoAntecFatSimu := itemXml('IN_DESCTO_ANTEC_FAT_SIMU', xParamEmp);
  gInDesF7 := itemXml('IN_DES_FUNCAO7', xParamEmp);
  gInEcfCupomPresente := itemXml('IN_ECF_CUPOM_PRESENTE', xParamEmp);
  gInGeraNfeAutomatic := itemXml('IN_GERA_NFE_AUTOMATIC', xParamEmp);
  gInGeraRegC140Fin := itemXml('IN_GERA_REGC140_FIN', xParamEmp);
  gInImpContratoAuto := itemXml('IN_IMP_CONTRATO_AUTO', xParamEmp);
  gInPDVOtimizado := itemXml('IN_PDV_OTIMIZADO', xParamEmp);
  gInPerguntaCpfCnpj := itemXml('IN_PERGUNTA_CPFCNPJ_ECF', xParamEmp);
  gInSimuladorCondPgto := itemXml('IN_SIMULADOR_COND_PGTO', xParamEmp);
  gInSimuladorProduto := itemXml('IN_SIMULADOR_FAT_PRODUTO', xParamEmp);
  gInUltimaPgtoCartaoTEF := itemXml('TEF_ULTIMAPGTO_CARTAO', xParamEmp);
  gInValidaMsgTroco := itemXml('IN_VALIDA_TROCO', xParamEmp);
  gInVendaChqClienteBloq := itemXml('IN_VendA_CHQ_CLIENTE_BLOQ', xParamEmp);
  gNrFilaSpool := itemXml('NR_FILA_SPOOL_NF_PROMIS', xParamEmp);
  gNrPrazoMedMax := itemXml('NR_PRAZOMEDIO_MAX_FAT', xParamEmp);
  gprDescBonificPed := itemXml('CD_TIPODESC_BONIFIC_PED', xParamEmp);
  gprDescPontualPed := itemXml('CD_TIPODESC_PONTUAL_PED', xParamEmp);
  gTpBloqAltFat := itemXml('TP_BLOQ_ALT_FAT_PED', xParamEmp);
  gTpChequePresente := itemXml('TP_CHEQUE_PRESENTE', xParamEmp);
  gTpDocumento := itemXml('TP_FORMAPGTO', xParamEmp);
  gTpFechamentoRoyalty := itemXml('TP_FECHAMENTO_ROYALTY', xParamEmp);
  gTpImpressaoFatVenda := itemXml('TP_IMPRESSAO_FAT_VD', xParamEmp);
  gTpImpressaoTEF := itemXml('TP_IMPRESSAO_TEF', xParamEmp);
  gTpImpressaoTraVenda := itemXml('TP_IMPRESSAO_TRA_VD', xParamEmp);
  gTpImpRichTextVD := itemXml('TP_IMP_RICHTEXT_VD', xParamEmp);
  gTpImpViaCupomTEF := itemXml('TEF_ESCOLHE_IMP_VIA_CUPOM', xParamEmp);
  gTpMultiploCartao := itemXml('TP_MULTIPLOS_CARTOES_SIMU', xParamEmp);
  gTpSimuladorFat := itemXml('TP_SIMULADOR_FAT', xParamEmp);
  gTpTEF := itemXml('TEF_TIPO', xParamEmp);
  gvInDescPromocionalCartao := itemXml('IN_DESCPROMOCIONAL_CARTAO', xParamEmp);

end;

//---------------------------------------------------------------
function T_TRAFM066.setEntidade(pParams : String = '') : String;
//---------------------------------------------------------------
begin
  tCTC_TRACARTAO := GetEntidade('CTC_TRACARTAO');
  tF_FCR_FATURAI := GetEntidade('F_FCR_FATURAI');
  tF_TEF_TRANSACAO := GetEntidade('F_TEF_TRANSACAO');
  tF_TMP_K02NR10 := GetEntidade('F_TMP_K02NR10');
  tFCR_CHEQUE := GetEntidade('FCR_CHEQUE');
  tFCR_DOFNI := GetEntidade('FCR_DOFNI');
  tFCR_FATURAI := GetEntidade('FCR_FATURAI');
  tFCX_HISTREL := GetEntidade('FCX_HISTREL');
  tFCX_HISTRELSUB := GetEntidade('FCX_HISTRELSUB');
  tFGR_PORTADOR := GetEntidade('FGR_PORTADOR');
  tFIS_NF := GetEntidade('FIS_NF');
  tFIS_NFVENCTO := GetEntidade('FIS_NFVENCTO');
  tGER_EMPRESA := GetEntidade('GER_EMPRESA');
  tGER_OPERACAO := GetEntidade('GER_OPERACAO');
  tNR_PARCELA := GetEntidade('NR_PARCELA');
  tNR_POSOCC := GetEntidade('NR_POSOCC');
  tPED_PEDIDOC := GetEntidade('PED_PEDIDOC');
  tPED_PEDIDOTRA := GetEntidade('PED_PEDIDOTRA');
  tPED_PEDTIPODESC := GetEntidade('PED_PEDTIPODESC');
  tR_TRA_TRANSACAO := GetEntidade('R_TRA_TRANSACAO');
  tSIS_ADIANTAMENTO := GetEntidade('SIS_ADIANTAMENTO');
  tSIS_BOTOES2 := GetEntidade('SIS_BOTOES2');
  tSIS_DUMMY3 := GetEntidade('SIS_DUMMY3');
  tSIS_PESSOA := GetEntidade('SIS_PESSOA');
  tSIS_TOTAL := GetEntidade('SIS_TOTAL');
  tSIS_VALOR := GetEntidade('SIS_VALOR');
  tTEF_RELTRANSACAO := GetEntidade('TEF_RELTRANSACAO');
  tTEF_TIPOTRANS := GetEntidade('TEF_TIPOTRANS');
  tTEF_TRANSACAO := GetEntidade('TEF_TRANSACAO');
  tTMP_K02NR10 := GetEntidade('TMP_K02NR10');
  tTMP_K04NRDS := GetEntidade('TMP_K04NRDS');
  tTMP_NR10 := GetEntidade('TMP_NR10');
  tTRA_LIMDESCONTO := GetEntidade('TRA_LIMDESCONTO');
  tTRA_S_TRANSACAO := GetEntidade('TRA_S_TRANSACAO');
  tTRA_TRANSACADIC := GetEntidade('TRA_TRANSACADIC');
  tTRA_TRANSACAO := GetEntidade('TRA_TRANSACAO');
  tTRA_TROCA := GetEntidade('TRA_TROCA');
end;

//------------------------------------------------------
function T_TRAFM066.preCLEAR(pParams : String) : String;
//------------------------------------------------------
begin
  clear;
  if (xStatus >= 0) then begin
    Result := SetStatus(<STS_DICA>, 'APL0006', '', '');
  end;

  voParams := carregaVlMaxTroco(viParams); (* *)
  if (xStatus < 0) then begin
    return(-1); exit;
  end;

  voParams := carregaTransacao(viParams); (* *)
  if (xStatus < 0) then begin
    return(-1); exit;
  end;

  voParams := carregaAdiantamento(viParams); (* *)
  if (xStatus < 0) then begin
    Result := voParams;
    return(-1); exit;
  end;

  voParams := criaValor(viParams); (* *)
  if (xStatus < 0) then begin
    Result := voParams;
    return(-1); exit;
  end;

  gInLiberaTpDocumento := False;

  if (gInTrocoMaximo = True) then begin
    fieldsyntax item_b('IN_ADIANTATROCO', tSIS_DUMMY3), 'DIM';
  end else begin
    fieldsyntax item_b('IN_ADIANTATROCO', tSIS_DUMMY3), '';
  end;

  gprompt := item_f('VL_DOCUMENTO', tSIS_VALOR);

  return(-1); exit;
end;

//-----------------------------------------------------
function T_TRAFM066.preEDIT(pParams : String) : String;
//-----------------------------------------------------

var
  viParams, voParams : String;
begin
  gCdEmpECF := 0;
  gNrECF := 0;
  gNrCupom := 0;
  gNrParcelas := 0;
  gInErroRecebimento := False;
  gDsLstTransacao := itemXml('DS_LSTTRANSACAO', viParams);
  gCdPessoa := itemXmlF('CD_PESSOA', viParams);
  gInTrocoMaximo := itemXmlB('IN_TROCOMAXIMO', viParams);
  gVlTrocoMaximo := itemXmlF('VL_TROCOMAXIMO', viParams);
  gCdEmpECF := itemXmlF('CD_EMPECF', viParams);
  gNrECF := itemXmlF('NR_ECF', viParams);
  gNrCupom := itemXmlF('NR_CUPOM', viParams);
  gNrUltimoBanco := '';
  gNrUltimaAgencia := '';
  gDsUltimaConta := '';
  gNrUltimoCheque := '';

  gInTrocaDocumento := itemXmlB('IN_TROCADOCUMENTO', viParams);
  gInRecAutomatico := itemXmlB('IN_RECAUTOMATICO', viParams);
  gInFCRFP001 := itemXmlB('IN_FCRFP001', viParams);

  if (itemXml('IN_DESCPROMOCAO', viParams) = True ) and (itemXmlB('IN_IMPRIMI_ECF_NFP', xParamEmp) = 1) then begin
    gIndesF7 := True;
  end;

  clear_e(tTMP_NR10);
  clear_e(tTEF_TRANSACAO);

  if (gDsLstTransacao = '') then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', , cDS_METHOD);
    return(-1); exit;
  end;
  if (gInTrocoMaximo = '') then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', , cDS_METHOD);
    return(-1); exit;
  end;
  if (gInTrocoMaximo = True) then begin
    fieldsyntax item_b('IN_ADIANTATROCO', tSIS_DUMMY3), 'DIM';
  end else begin
    fieldsyntax item_b('IN_ADIANTATROCO', tSIS_DUMMY3), '';
  end;

  voParams := carregaVlMaxTroco(viParams); (* *)
  if (xStatus < 0) then begin
    return(-1); exit;
  end;

  voParams := carregaTransacao(viParams); (* *)
  if (xStatus < 0) then begin
    return(-1); exit;
  end;

  voParams := carregaVlBrutoLiquido(viParams); (* *)
  if (xStatus < 0) then begin
    return(-1); exit;
  end;
  if (item_b('IN_FINANCEIRO', tGER_OPERACAO) = False) then begin
    viParams := '';
    putitemXml(viParams, 'DS_LSTTRANSACAO', gDsLstTransacao);
    putitemXml(viParams, 'TP_SITUACAO', 4);
    voParams := activateCmp('TRASVCO004', 'alteraSituacaoTransacao', viParams); (*,viParams,voParams,, *)
    if (xStatus < 0) then begin
      Result := voParams;
      return(-1); exit;
    end;

    voParams := geraNFe(viParams); (* *)
    if (xStatus < 0) then begin
      return(-1); exit;
    end;

    return(0); exit;
  end;
  if (gxCdNivel = 2) then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', , cDS_METHOD);
    return(-1); exit;
  end;

  voParams := carregaCtaCliente(viParams); (* *)

  if (xStatus < 0) then begin
    return(-1); exit;
  end;

  voParams := carregaCaixa(viParams); (* *)

  if (xStatus < 0) then begin
    return(-1); exit;
  end;

  voParams := carregaAdiantamento(viParams); (* *)

  if (xStatus < 0) then begin
    return(-1); exit;
  end;

  gInLiberaTpDocumento := False;
  gDsLstTpDocumento := '';

  voParams := carregaTipoDocumento(viParams); (* *)

  if (xStatus < 0) then begin
    return(-1); exit;
  end;

  voParams := criaValor(viParams); (* *)

  if (gTpTEF = 1)  or (gTpTEF = 2) then begin
    voParams := efetivaTEFPendente(viParams); (* False, True *)
    if (xStatus < 0) then begin
      return(-1); exit;
    end;
  end;
  if (gInECF = True) then begin
    gInF7 := True;
    putitem_e(tSIS_BOTOES2, 'BT_F11', 'F11 Encerrar');
  end else begin
    gInF7 := False;
    putitem_e(tSIS_BOTOES2, 'BT_F11', 'F11 Encerrar');
  end;

  gCdEmpContrato := 0;
  gNrSeqContrato := 0;
  gNrSeqItemContrato := 0;
  gDsContrato := '';
  viParams := '';

  putitemXml(viParams, 'CD_EMPRESA', item_f('CD_EMPRESA', tTRA_TRANSACAO));
  putitemXml(viParams, 'NR_TRANSACAO', item_f('NR_TRANSACAO', tTRA_TRANSACAO));
  putitemXml(viParams, 'DT_TRANSACAO', item_a('DT_TRANSACAO', tTRA_TRANSACAO));
  voParams := activateCmp('IMBSVCO003', 'buscaContratoTransacao', viParams); (*,viParams,voParams,, *)
  if (xStatus < 0) then begin
    Result := voParams;
    return(-1); exit;
  end;
  if (voParams <> '') then begin
    gCdEmpContrato := itemXmlF('CD_EMPCONTRATO', voParams);
    gNrSeqContrato := itemXmlF('NR_SEQCONTRATO', voParams);
    gNrSeqItemContrato := itemXmlF('NR_SEQITEM', voParams);
    gDsContrato := voParams;
  end;

  clear_e(tPED_PEDIDOTRA);
  putitem_e(tPED_PEDIDOTRA, 'CD_EMPTRANSACAO', item_f('CD_EMPRESA', tTRA_TRANSACAO));
  putitem_e(tPED_PEDIDOTRA, 'NR_TRANSACAO', item_f('NR_TRANSACAO', tTRA_TRANSACAO));
  putitem_e(tPED_PEDIDOTRA, 'DT_TRANSACAO', item_a('DT_TRANSACAO', tTRA_TRANSACAO));
  retrieve_e(tPED_PEDIDOTRA);
  if (xStatus >= 0) then begin
    if (gTpBloqAltFat = 02 ) or (gTpBloqAltFat = 03)  and (gInTrocoMaximo <> True) then begin
      voParams := BT_06(viParams); (* *)
      if (xStatus < 0) then begin
        return(-1); exit;
      end;
      voParams := BT_11(viParams); (* *)
      if (xStatus < 0) then begin
        return(-1); exit;
      end;
    end;
  end else begin

    if (gInRecAutomatico = True) then begin
      voParams := BT_06(viParams); (* *)
      if (xStatus < 0) then begin
        return(-1); exit;
      end;
      voParams := BT_11(viParams); (* *)
      if (xStatus < 0) then begin
        return(-1); exit;
      end;
    end;
  end;

  gprompt := item_f('VL_DOCUMENTO', tSIS_VALOR);

  return(0); exit;
end;

//-----------------------------------------------------
function T_TRAFM066.posEDIT(pParams : String) : String;
//-----------------------------------------------------

var
  vInMostraTroco : Boolean;
begin
  putitemXml(voParams, 'IN_FATURA', gInFatura);

  vInMostraTroco := itemXmlB('IN_MOSTRA_TROCO_RECEB', xParamEmp);

  if (vInMostraTroco = True)  and (item_b('IN_ADIANTATROCO', tSIS_DUMMY3)<> True) then begin
    putitemXml(voParams, 'VL_TROCO', item_f('VL_TROCO', tSIS_DUMMY3));
  end;
  if (gCdReciboTra > 0) then begin
    putitemXml(voParams, 'CD_EMPLIQ', gCdEmpLiq);
    putitemXml(voParams, 'DT_LIQ', gDtLiq);
    putitemXml(voParams, 'NR_SEQLIQ', gNrSeqLiq);
  end;

  return(0); exit;
end;

//-----------------------------------------------------
function T_TRAFM066.preQUIT(pParams : String) : String;
//-----------------------------------------------------
begin
  if (gInPDVOtimizado = True) then begin
    if (gInErroRecebimento <> True) then begin
      return(-1); exit;
    end;
  end;
  if (gTpTEF = 1)  or (gTpTEF = 2) then begin
    voParams := efetivaTEFPendente(viParams); (* True, False *)
    if (xStatus < 0) then begin
      Result := voParams;
      return(-1); exit;
    end;
  end;

  return(-1); exit;
end;

//--------------------------------------------------
function T_TRAFM066.INIT(pParams : String) : String;
//--------------------------------------------------
begin
  //keyboard := 'KB_PDV';
  _Caption := '' + TRAFM + '066 - Recebimento de Transação de Venda-';

  xParam := '';
  putitem(xParam,  'CLIENTE_PDV');
  xParam := T_ADMSVCO001.GetParametro(xParam); (*xParam,xParam,, *)

  gCdClientePDV := itemXml('CLIENTE_PDV', xParam);

  xParamEmp := '';
  putitem(xParamEmp,  'TP_FORMAPGTO');
  putitem(xParamEmp,  'TEF_TIPO');
  putitem(xParamEmp,  'LIMITE_CREDITO');
  putitem(xParamEmp,  'TP_IMPRESSAO_FAT_VD');
  putitem(xParamEmp,  'TP_IMPRESSAO_TRA_VD');
  putitem(xParamEmp,  'CD_MODELO_NF_PROMISSORIA');
  putitem(xParamEmp,  'NR_FILA_SPOOL_NF_PROMIS');
  putitem(xParamEmp,  'TP_BLOQ_ALT_FAT_PED');
  putitem(xParamEmp,  'IN_PDV_OTIMIZADO');
  putitem(xParamEmp,  'IN_DES_FUNCAO7');
  putitem(xParamEmp,  'TP_IMPRESSAO_TEF');
  putitem(xParamEmp,  'TEF_IN_AGRUPA_CARTAO');
  putitem(xParamEmp,  'TEF_ULTIMAPGTO_CARTAO');
  putitem(xParamEmp,  'IN_VALIDA_TROCO');
  putitem(xParamEmp,  'TP_SIMULADOR_FAT');
  putitem(xParamEmp,  'IN_SIMULADOR_FAT_PRODUTO');
  putitem(xParamEmp,  'CD_TIPODESC_PONTUAL_PED');
  putitem(xParamEmp,  'CD_TIPODESC_BONIFIC_PED');
  putitem(xParamEmp,  'CD_MOD_IMP_RECEBTRA');
  putitem(xParamEmp,  'NR_PRAZOMEDIO_MAX_FAT');
  putitem(xParamEmp,  'IN_IMP_CONTRATO_AUTO');
  putitem(xParamEmp,  'TEF_ESCOLHE_IMP_VIA_CUPOM');
  putitem(xParamEmp,  'IN_PERGUNTA_CPFCNPJ_ECF');
  putitem(xParamEmp,  'IN_BLOQ_DT_VENC_VD');
  putitem(xParamEmp,  'NR_DIAS_PRAZOMED_LIB_FAT');
  putitem(xParamEmp,  'TP_COBRANCA_VD');
  putitem(xParamEmp,  'IN_IMPRIMI_ECF_NFP');
  putitem(xParamEmp,  'TP_MULTIPLOS_CARTOES_SIMU');
  putitem(xParamEmp,  'TP_BONUS_DESCONTO');
  putitem(xParamEmp,  'VL_VD_CREDITO_BONUS_DESC');
  putitem(xParamEmp,  'VL_CREDITO_BONUS_DESCONTO');
  putitem(xParamEmp,  'IN_LIMITE_FAMILIAR_VD');
  putitem(xParamEmp,  'IN_DESCPROMOCIONAL_CARTAO');
  putitem(xParamEmp,  'IN_VendA_CHQ_CLIENTE_BLOQ');
  putitem(xParamEmp,  'IN_SIMULADOR_COND_PGTO');
  putitem(xParamEmp,  'TP_IMP_RICHTEXT_VD');
  putitem(xParamEmp,  'IN_GERA_NFE_AUTOMATIC');
  putitem(xParamEmp,  'IN_GERA_REGC140_FIN');
  putitem(xParamEmp,  'IN_MOSTRA_TROCO_RECEB');
  putitem(xParamEmp,  'TP_NR_FATURA_CONTRATO');
  putitem(xParamEmp,  'IN_ECF_CUPOM_PRESENTE');
  putitem(xParamEmp,  'CD_TIPODES_ABATIMENTO_PED');
  putitem(xParamEmp,  'CD_TIPO_ABATIMENTO_PED');
  putitem(xParamEmp,  'CD_MOTIVO_ABATI_PED');
  putitem(xParamEmp,  'TP_CHEQUE_PRESENTE');
  putitem(xParamEmp,  'IN_DESCTO_ANTEC_FAT_SIMU');
  putitem(xParamEmp,  'TP_FECHAMENTO_ROYALTY');
  xParamEmp := T_ADMSVCO001.GetParamEmpresa(piCdEmpresa, xParamEmp); (*itemXml('CD_EMPRESA', *)

  gTpDocumento := itemXmlF('TP_FORMAPGTO', xParamEmp);
  gTpTEF := itemXml('TEF_TIPO', xParamEmp);
  gDsLimiteCredito := itemXml('LIMITE_CREDITO', xParamEmp);
  gTpImpressaoFatVenda := itemXmlF('TP_IMPRESSAO_FAT_VD', xParamEmp);
  gTpImpressaoTraVenda := itemXmlF('TP_IMPRESSAO_TRA_VD', xParamEmp);
  gCdModeloNFPromissoria := itemXmlF('CD_MODELO_NF_PROMISSORIA', xParamEmp);
  gNrFilaSpool := itemXmlF('NR_FILA_SPOOL_NF_PROMIS', xParamEmp);
  gTpBloqAltFat := itemXmlF('TP_BLOQ_ALT_FAT_PED', xParamEmp);
  gInPDVOtimizado := itemXmlB('IN_PDV_OTIMIZADO', xParamEmp);
  gInDesF7 := itemXmlB('IN_DES_FUNCAO7', xParamEmp);
  gTpImpressaoTEF := itemXmlF('TP_IMPRESSAO_TEF', xParamEmp);
  gInAgrupaCartaoTEF := itemXml('TEF_IN_AGRUPA_CARTAO', xParamEmp);
  gInUltimaPgtoCartaoTEF := itemXml('TEF_ULTIMAPGTO_CARTAO', xParamEmp);
  gInValidaMsgTroco := itemXmlB('IN_VALIDA_TROCO', xParamEmp);
  gTpSimuladorFat := itemXmlF('TP_SIMULADOR_FAT', xParamEmp);
  gInSimuladorProduto := itemXmlB('IN_SIMULADOR_FAT_PRODUTO', xParamEmp);
  gprDescPontualPed := itemXmlF('CD_TIPODESC_PONTUAL_PED', xParamEmp);
  gprDescBonificPed := itemXmlF('CD_TIPODESC_BONIFIC_PED', xParamEmp);
  gCdReciboTra := itemXmlF('CD_MOD_IMP_RECEBTRA', xParamEmp);
  gNrPrazoMedMax := itemXmlF('NR_PRAZOMEDIO_MAX_FAT', xParamEmp);
  gInImpContratoAuto := itemXmlB('IN_IMP_CONTRATO_AUTO', xParamEmp);
  gTpImpViaCupomTEF := itemXml('TEF_ESCOLHE_IMP_VIA_CUPOM', xParamEmp);
  gInPerguntaCpfCnpj := itemXmlB('IN_PERGUNTA_CPFCNPJ_ECF', xParamEmp);
  gTpMultiploCartao := itemXmlF('TP_MULTIPLOS_CARTOES_SIMU', xParamEmp);
  gvInDescPromocionalCartao := itemXmlB('IN_DESCPROMOCIONAL_CARTAO', xParamEmp);
  gInVendaChqClienteBloq := itemXmlB('IN_VendA_CHQ_CLIENTE_BLOQ', xParamEmp);
  gInSimuladorCondPgto := itemXmlB('IN_SIMULADOR_COND_PGTO', xParamEmp);
  gTpImpRichTextVD := itemXmlF('TP_IMP_RICHTEXT_VD', xParamEmp);

  gInGeraNfeAutomatic := itemXmlB('IN_GERA_NFE_AUTOMATIC', xParamEmp);
  gInGeraRegC140Fin := itemXmlB('IN_GERA_REGC140_FIN', xParamEmp);

  gInEcfCupomPresente := itemXmlB('IN_ECF_CUPOM_PRESENTE', xParamEmp);
  gTpChequePresente := itemXmlF('TP_CHEQUE_PRESENTE', xParamEmp);

  gInDesctoAntecFatSimu := itemXmlB('IN_DESCTO_ANTEC_FAT_SIMU', xParamEmp);
  gTpFechamentoRoyalty := itemXmlF('TP_FECHAMENTO_ROYALTY', xParamEmp);
  return(0); exit;
end;

//-----------------------------------------------------
function T_TRAFM066.CLEANUP(pParams : String) : String;
//-----------------------------------------------------
begin
  //keyboard := 'KB_GLOBAL';

  return(0); exit;
end;

//---------------------------------------------------------------
function T_TRAFM066.carregaCtaCliente(pParams : String) : String;
//---------------------------------------------------------------

var
  viParams, voParams : String;
  vCdPessoa, vCdEmpresa : Real;
begin
  if (gInTroca = True) then begin
    vCdEmpresa := item_f('CD_EMPFAT', tR_TRA_TRANSACAO);
    vCdPessoa := item_f('CD_PESSOA', tR_TRA_TRANSACAO);
  end else begin
    vCdEmpresa := item_f('CD_EMPFAT', tTRA_TRANSACAO);
    vCdPessoa := gCdPessoa;
  end;

  viParams := '';
  putitemXml(viParams, 'CD_EMPRESA', vCdEmpresa);
  putitemXml(viParams, 'CD_PESSOA', vCdPessoa);
  if (item_f('TP_OPERACAO', tTRA_TRANSACAO) = 'S') then begin
    putitemXml(viParams, 'TP_CONTA', 'C');
  end else begin
    putitemXml(viParams, 'TP_CONTA', 'F');
  end;
  putitemXml(viParams, 'IN_OBRIGATORIO', False);
  voParams := activateCmp('FCCSVCO002', 'buscaContaPessoa', viParams); (*,viParams,voParams,, *)
  if (xStatus < 0) then begin
    Result := voParams;
    return(-1); exit;
  end;

  gNrCtaCliente := itemXmlF('NR_CTAPES', voParams);

  return(0); exit;
end;

//----------------------------------------------------------
function T_TRAFM066.carregaCaixa(pParams : String) : String;
//----------------------------------------------------------

var
  viParams, voParams : String;
  vCdTerminal : Real;
begin
  vCdTerminal := itemXmlF('CD_TERMINAL', viParams);

  if (vCdTerminal > 0) then begin
    gCdEmpresa := itemXmlF('CD_EMPTERMINAL', viParams);
    gCdTerminal := vCdTerminal;
    gDtAbertura := itemXml('DT_ABERTURA', viParams);
    gNrSeq := itemXmlF('NR_SEQ', viParams);
    gNrCtaUsuario := itemXmlF('NR_CTAPES', viParams);
  end else begin
    viParams := '';
    putitemXml(viParams, 'CD_EMPRESA', item_f('CD_EMPFAT', tTRA_TRANSACAO));
    voParams := activateCmp('FCXSVCO001', 'buscaCaixa', viParams); (*,viParams,voParams,, *)
    if (xStatus < 0) then begin
      Result := voParams;
      return(-1); exit;
    end;

    gCdEmpresa := itemXmlF('CD_EMPRESA', voParams);
    gCdTerminal := itemXmlF('CD_TERMINAL', voParams);
    gDtAbertura := itemXml('DT_ABERTURA', voParams);
    gNrSeq := itemXmlF('NR_SEQ', voParams);
    gNrCtaUsuario := itemXmlF('NR_CTAPES', voParams);
  end;

  return(0); exit;
end;

//-----------------------------------------------------------------
function T_TRAFM066.carregaAdiantamento(pParams : String) : String;
//-----------------------------------------------------------------

var
  viParams, voParams : String;
  vVlCREDEV : Real;
  vDtSaldo : TDate;
begin
  putitem_e(tSIS_ADIANTAMENTO, 'VL_ADIANTAMENTO', '');
  putitem_e(tSIS_ADIANTAMENTO, 'VL_CREDDEV', '');
  fieldsyntax item_f('VL_ADIANTAMENTO', tSIS_ADIANTAMENTO), 'HID';
  fieldsyntax item_f('VL_CREDDEV', tSIS_ADIANTAMENTO), 'HID';

  if (gNrCtaCliente = 0) then begin
    if (gInTroca = True) then begin
      Result := SetStatus(STS_ERROR, 'GEN0001', , cDS_METHOD);
      return(-1); exit;
    end;
    return(0); exit;
  end;

  vDtSaldo := itemXml('DT_SISTEMA', PARAM_GLB);
  vVlCREDEV := '';

  if (item_f('CD_PESSOA', tTRA_TRANSACAO) = gCdClientePDV) then begin
    vVlCREDEV := item_f('VL_TOTAL', tR_TRA_TRANSACAO);
  end else begin
    viParams := '';
    putitemXml(viParams, 'NR_CTAPES', gNrCtaCliente);
    putitemXml(viParams, 'TP_DOCUMENTO', 10);
    putitemXml(viParams, 'NR_SEQHISTRELSUB', 1);
    putitemXml(viParams, 'DT_SALDO', vDtSaldo);
    voParams := activateCmp('FCCSVCO002', 'buscaSaldoCtaTp', viParams); (*,viParams,voParams,, *)
    if (xStatus < 0) then begin
      Result := voParams;
      return(-1); exit;
    end;

    putitem_e(tSIS_ADIANTAMENTO, 'VL_ADIANTAMENTO', itemXmlF('VL_SALDO', voParams));

    viParams := '';
    putitemXml(viParams, 'NR_CTAPES', gNrCtaCliente);
    putitemXml(viParams, 'TP_DOCUMENTO', 20);
    putitemXml(viParams, 'NR_SEQHISTRELSUB', 1);
    putitemXml(viParams, 'DT_SALDO', vDtSaldo);
    voParams := activateCmp('FCCSVCO002', 'buscaSaldoCtaTp', viParams); (*,viParams,voParams,, *)
    if (xStatus < 0) then begin
      Result := voParams;
      return(-1); exit;
    end;

    vVlCREDEV := itemXmlF('VL_SALDO', voParams);
  end;
  if (gInTroca = True) then begin
    if (item_f('VL_TOTAL', tR_TRA_TRANSACAO) > vVlCREDEV) then begin
      if (gInPdvOtimizado <> True) then begin
        Result := SetStatus(STS_ERROR, 'GEN0001', , cDS_METHOD);
        return(-1); exit;
      end;
    end;
    putitem_e(tSIS_ADIANTAMENTO, 'VL_CREDDEV', item_f('VL_TOTAL', tR_TRA_TRANSACAO));
  end else begin
    putitem_e(tSIS_ADIANTAMENTO, 'VL_CREDDEV', vVlCREDEV);
  end;
  if (item_f('VL_ADIANTAMENTO', tSIS_ADIANTAMENTO) > 0) then begin
    fieldsyntax item_f('VL_ADIANTAMENTO', tSIS_ADIANTAMENTO), 'NED';
  end;
  if (item_f('VL_CREDDEV', tSIS_ADIANTAMENTO) > 0) then begin
    fieldsyntax item_f('VL_CREDDEV', tSIS_ADIANTAMENTO), 'NED';
  end;

  return(0); exit;
end;

//---------------------------------------------------------------
function T_TRAFM066.carregaVlMaxTroco(pParams : String) : String;
//---------------------------------------------------------------

var
  viParams, voParams : String;
begin
  gInDinheiro := False;

  fieldsyntax item_f('VL_MAXTROCO', tSIS_ADIANTAMENTO), 'HID';
  fieldsyntax item_f('VL_DIF', tSIS_ADIANTAMENTO), 'HID';

  if (gInTrocoMaximo = True) then begin
    putitem_e(tSIS_ADIANTAMENTO, 'VL_MAXTROCO', gVlTrocoMaximo);
    if (gVlTrocoMaximo = 0) then begin
      gInDinheiro := True;
    end;
    fieldsyntax item_f('VL_MAXTROCO', tSIS_ADIANTAMENTO), 'NED';
    fieldsyntax item_f('VL_DIF', tSIS_ADIANTAMENTO), 'NED';
  end else begin
    putitem_e(tSIS_ADIANTAMENTO, 'VL_MAXTROCO', '');
  end;

  return(0); exit;
end;

//-------------------------------------------------------------------
function T_TRAFM066.carregaVlBrutoLiquido(pParams : String) : String;
//-------------------------------------------------------------------

var
  viParams, voParams : String;
begin
  gVlTotalBruto := 0;
  gVlTotalLiquido := 0;

  viParams := viParams;
  voParams := activateCmp('SICSVCO005', 'buscaVlBrutoLiquido', viParams); (*,viParams,voParams,, *)
  if (xStatus < 0) then begin
    Result := voParams;
    return(-1); exit;
  end;

  gVlTotalBruto := itemXmlF('VL_TOTALBRUTO', voParams);
  gVlTotalLiquido := itemXmlF('VL_TOTALLIQUIDO', voParams);

  return(0); exit;
end;

//------------------------------------------------------------------
function T_TRAFM066.carregaTipoDocumento(pParams : String) : String;
//------------------------------------------------------------------

var
  viParams, voParams, vDsLstTotal, vDsGeral, vDsNulo : String;
  vDsTpDocumento, vDsLstTpDocumento : String;
  vTpDocumento : Real;
  vInTroco, vInAdiantamento, vInCREDEV, vInUtilizar, vInOrgaopublico : Boolean;
begin
  gInParcelaFatura := False;
  gInParcelaCheque := False;
  gInParcelaNotaP := False;

  vDsNulo := '';
  vInTroco := False;
  vInAdiantamento := False;
  vInCREDEV := False;
  vDsLstTotal := valrep(item_f('TP_DOCUMENTO', tFCX_HISTREL));
  vDsLstTpDocumento := '';

  viParams := '';
  putitemXml(viParams, 'CD_PESSOA', gCdPessoa);
  voParams := activateCmp('FCRSVCO057', 'validaPessoaOrgaopublico', viParams); (*,viParams,voParams,, *)
  if (xStatus < 0) then begin
    Result := voParams;
    return(-1); exit;
  end;

  vInOrgaopublico := itemXmlB('IN_ORGAOpublicO', voParams);

  if (vInOrgaopublico = True) then begin
    vDsGeral := itemXml('1', vDsLstTotal);
    vDsTpDocumento := '';
    putitemXml(vDsTpDocumento, '1', vDsGeral);
    putitem(vDsLstTpDocumento,  vDsTpDocumento);
    valrep(putitem_e(tSIS_VALOR, 'TP_DOCUMENTO'), vDsLstTpDocumento);

    return(0); exit;
  end;

  clear_e(tFCX_HISTREL);
  if (gInLiberaTpDocumento = False) then begin
    putitem_e(tFCX_HISTREL, 'IN_FATURAMENTO', True);
  end else begin
    putitem_e(tFCX_HISTREL, 'TP_DOCUMENTO', gDsLstTpDocumento);
  end;
  retrieve_e(tFCX_HISTREL);
  if (xStatus >= 0) then begin
    sort/e(t   FCX_HISTREL, 'VL_AUX';);
    setocc(tFCX_HISTREL, 1);
    while (xStatus >= 0) do begin
      if (item_f('TP_DOCUMENTO', tFCX_HISTREL) = 9) then begin
        vInTroco := True;
      end else begin
        vInUtilizar := True;
        if (gInLiberaTpDocumento = False) then begin
          if (gCdCartao <> 0) then begin
            viParams := '';
            putitemXml(viParams, 'CD_CARTAO', gCdCartao);
            putitemXml(viParams, 'TP_DOCUMENTO', item_f('TP_DOCUMENTO', tFCX_HISTREL));
            voParams := activateCmp('CTCSVCO004', 'verificaTpDocumentoCartao', viParams); (*,viParams,voParams,, *)
            if (xStatus < 0) then begin
              Result := voParams;
              return(-1); exit;
            end;
            if (voParams <> '') then begin
              vInUtilizar := itemXmlB('IN_VALIDO', voParams);
            end;
          end else begin
            viParams := '';
            putitemXml(viParams, 'CD_PESSOA', gCdPessoa);
            putitemXml(viParams, 'CD_EMPRESA', item_f('CD_EMPFAT', tTRA_TRANSACAO));
            putitemXml(viParams, 'TP_DOCUMENTO', item_f('TP_DOCUMENTO', tFCX_HISTREL));
            putitemXml(viParams, 'IN_FATURAMENTO', True);
            voParams := activateCmp('FCXSVCO005', 'validaHistRel', viParams); (*,viParams,voParams,, *)
            if (xStatus < 0) then begin
              Result := voParams;
              return(-1); exit;
            end;
            if (voParams <> '') then begin
              vInUtilizar := itemXmlB('IN_VALIDO', voParams);
            end;
          end;
        end;
        if (vInUtilizar = True) then begin
          if (item_f('TP_DOCUMENTO', tFCX_HISTREL) = 10) then begin
            if (item_f('VL_ADIANTAMENTO', tSIS_ADIANTAMENTO) > 0) then begin
              vInAdiantamento := True;
              vDsGeral := 'Adiantamento';
              vDsTpDocumento := '';
              putitemXml(vDsTpDocumento, item_f('TP_DOCUMENTO', tFCX_HISTREL), vDsGeral);
              putitem(vDsLstTpDocumento,  vDsTpDocumento);
            end;
          end else if (item_f('TP_DOCUMENTO', tFCX_HISTREL) = 20) then begin
            if (item_f('VL_CREDDEV', tSIS_ADIANTAMENTO) > 0) then begin
              vInCREDEV := True;
              vDsGeral := itemXml(item_f('TP_DOCUMENTO', tFCX_HISTREL), vDsLstTotal);
              vDsTpDocumento := '';
              putitemXml(vDsTpDocumento, item_f('TP_DOCUMENTO', tFCX_HISTREL), vDsGeral);
              putitem(vDsLstTpDocumento,  vDsTpDocumento);
            end;
          end else begin
            if (item_f('TP_DOCUMENTO', tFCX_HISTREL) = 1) then begin
              gInParcelaFatura := True;
            end else if (item_f('TP_DOCUMENTO', tFCX_HISTREL) = 2) then begin
              gInParcelaCheque := True;
            end else if (item_f('TP_DOCUMENTO', tFCX_HISTREL) = 14) then begin
              gInParcelaNotaP := True;
            end;
            vDsGeral := itemXml(item_f('TP_DOCUMENTO', tFCX_HISTREL), vDsLstTotal);
            vDsTpDocumento := '';
            putitemXml(vDsTpDocumento, item_f('TP_DOCUMENTO', tFCX_HISTREL), vDsGeral);
            putitem(vDsLstTpDocumento,  vDsTpDocumento);
            if (item_f('TP_DOCUMENTO', tFCX_HISTREL) = 4 ) or (item_f('TP_DOCUMENTO', tFCX_HISTREL) = 5)  and (gInPDVOtimizado = True) then begin
              clear_e(tFCX_HISTRELSUB);
              putitem_e(tFCX_HISTRELSUB, 'TP_DOCUMENTO', item_f('TP_DOCUMENTO', tFCX_HISTREL));
              putitem_e(tFCX_HISTRELSUB, 'DS_HISTRELSUB', '!=' + vDsNulo' + ');
              retrieve_e(tFCX_HISTRELSUB);
              if (xStatus >= 0) then begin
                sort/e(t   FCX_HISTRELSUB, 'VL_AUX';);
                setocc(tFCX_HISTRELSUB, 1);
                while (xStatus >= 0) do begin
                  vTpDocumento := (item_f('TP_DOCUMENTO', tFCX_HISTREL) * 10000) + item_f('NR_SEQHISTRELSUB', tFCX_HISTRELSUB);
                  vDsTpDocumento := '';
                  putitemXml(vDsTpDocumento, vTpDocumento, item_a('DS_HISTRELSUB', tFCX_HISTRELSUB)[1 : 15]);
                  putitem(vDsLstTpDocumento,  vDsTpDocumento);
                  setocc(tFCX_HISTRELSUB, curocc(tFCX_HISTRELSUB) + 1);
                end;
              end;
            end;
          end;
          putitem(gDsLstTpDocumento,  item_f('TP_DOCUMENTO', tFCX_HISTREL));
        end;
      end;
      setocc(tFCX_HISTREL, curocc(tFCX_HISTREL) + 1);
    end;
  end;
  if (vInTroco = False)  and (gInLiberaTpDocumento = False) then begin
    Result := SetStatus(STS_ERROR, 'GEN001', , cDS_METHOD);
    return(-1); exit;
  end;
  if (item_f('VL_ADIANTAMENTO', tSIS_ADIANTAMENTO) > 0)  and (vInAdiantamento = False) then begin
    Result := SetStatus(STS_ERROR, 'GEN001', , cDS_METHOD);
    return(-1); exit;
  end;
  if (item_f('VL_CREDDEV', tSIS_ADIANTAMENTO) > 0)  and (vInCREDEV = False) then begin
    Result := SetStatus(STS_ERROR, 'GEN001', , cDS_METHOD);
    return(-1); exit;
  end;

  valrep(putitem_e(tSIS_VALOR, 'TP_DOCUMENTO'), vDsLstTpDocumento);

  return(0); exit;
end;

//--------------------------------------------------------------
function T_TRAFM066.carregaTransacao(pParams : String) : String;
//--------------------------------------------------------------

var
  vDsRegistro, vDsLstTransacao, vDsSituacao, viParams, voParams : String;
  vCdEmpresa, vNrTransacao, vVlFinanceiro : Real;
  vDtTransacao : TDate;
begin
  gInECF := False;
  gInCupomAberto := False;
  gCdCartao := 0;
  gNrSeqCartao := 0;
  gVlTotBonus := 0;
  gInFinanceiro := False;

  clear_e(tTRA_TRANSACAO);
  putitem_e(tSIS_DUMMY3, 'VL_TOTAL', '');
  putitem_e(tSIS_DUMMY3, 'VL_RESTANTE', '');

  vDsLstTransacao := gDsLstTransacao;
  repeat
    getitem(vDsRegistro, vDsLstTransacao, 1);

    vCdEmpresa := itemXmlF('CD_EMPRESA', vDsRegistro);
    vNrTransacao := itemXmlF('NR_TRANSACAO', vDsRegistro);
    vDtTransacao := itemXml('DT_TRANSACAO', vDsRegistro);

    if (vCdEmpresa = 0) then begin
      Result := SetStatus(STS_ERROR, 'GEN001', , cDS_METHOD);
      return(-1); exit;
    end;
    if (vNrTransacao = 0) then begin
      Result := SetStatus(STS_ERROR, 'GEN001', , cDS_METHOD);
      return(-1); exit;
    end;
    if (vDtTransacao = '') then begin
      Result := SetStatus(STS_ERROR, 'GEN001', , cDS_METHOD);
      return(-1); exit;
    end;

    creocc(tTRA_TRANSACAO, -1);
    putitem_e(tTRA_TRANSACAO, 'CD_EMPRESA', vCdEmpresa);
    putitem_e(tTRA_TRANSACAO, 'NR_TRANSACAO', vNrTransacao);
    putitem_e(tTRA_TRANSACAO, 'DT_TRANSACAO', vDtTransacao);
    retrieve_o(tTRA_TRANSACAO);
    if (xStatus = -7) then begin
      retrieve_x(tTRA_TRANSACAO);
      if (item_f('TP_DOCTO', tGER_OPERACAO) = 2)  or (item_f('TP_DOCTO', tGER_OPERACAO) = 3) then begin
        if (gInTrocaDocumento <> True) then begin
          gInECF := True;
        end else begin
          gInECF := False;
        end;
      end;
      if (item_f('TP_MODALIDADE', tGER_OPERACAO) = 8) then begin
        gInTroca := True;
      end;

      if not (empty(tCTC_TRACARTAO)) then begin
        if (gCdCartao <> 0)  and (item_f('CD_CARTAO', tCTC_TRACARTAO) <> gCdCartao) then begin
          Result := SetStatus(STS_ERROR, 'GEN0001', , cDS_METHOD);
          return(-1); exit;
        end;
        gCdCartao := item_f('CD_CARTAO', tCTC_TRACARTAO);
        gNrSeqCartao := item_f('NR_SEQCARTAO', tCTC_TRACARTAO);
        gVlTotBonus := gVlTotBonus + item_f('VL_BONUSUTIL', tCTC_TRACARTAO);
      end;

      viParams := '';
      putitemXml(viParams, 'CD_EMPRESA', item_f('CD_EMPRESA', tTRA_TRANSACAO));
      putitemXml(viParams, 'NR_TRANSACAO', item_f('NR_TRANSACAO', tTRA_TRANSACAO));
      putitemXml(viParams, 'DT_TRANSACAO', item_a('DT_TRANSACAO', tTRA_TRANSACAO));
      voParams := activateCmp('GERSVCO058', 'buscaValorFinanceiroTransacao', viParams); (*,viParams,voParams,, *)
      if (xStatus < 0) then begin
        Result := voParams;
        return(-1); exit;
      end;
      vVlFinanceiro := itemXmlF('VL_FINANCEIRO', voParams);

      if (vVlFinanceiro <> item_f('VL_TOTAL', tTRA_TRANSACAO)) then begin
        gInFinanceiro := True;
        fieldsyntax item_a('BT_F6', tSIS_BOTOES2), 'DIM';
        gInF6 := False;
      end;

      putitem_e(tTRA_TRANSACAO, 'VL_TOTAL', vVlFinanceiro);
    end else if (xStatus = 0) then begin
      Result := SetStatus(STS_ERROR, 'GEN001', , cDS_METHOD);
      return(-1); exit;
    end;
    if (gCdPessoa = 0) then begin
      gCdPessoa := item_f('CD_PESSOA', tTRA_TRANSACAO);
    end;

    putitem_e(tSIS_DUMMY3, 'VL_TOTAL', item_f('VL_TOTAL', tSIS_DUMMY3) + item_f('VL_TOTAL', tTRA_TRANSACAO));
    putitem_e(tSIS_DUMMY3, 'VL_RESTANTE', item_f('VL_RESTANTE', tSIS_DUMMY3) + item_f('VL_TOTAL', tTRA_TRANSACAO));

    delitem(vDsLstTransacao, 1);
  until (vDsLstTransacao = '');

  if (gInECF = True)  and (totocc(tTRA_TRANSACAO) > 1) then begin
    Result := SetStatus(STS_ERROR, 'GEN001', , cDS_METHOD);
    return(-1); exit;
  end;
  if (gInTroca = True) then begin
    if (totocc(tTRA_TRANSACAO) > 1) then begin
      Result := SetStatus(STS_ERROR, 'GEN001', , cDS_METHOD);
      return(-1); exit;
    end;
    clear_e(tTRA_TROCA);
    putitem_e(tTRA_TROCA, 'CD_EMPVEN', item_f('CD_EMPRESA', tTRA_TRANSACAO));
    putitem_e(tTRA_TROCA, 'NR_TRAVEN', item_f('NR_TRANSACAO', tTRA_TRANSACAO));
    putitem_e(tTRA_TROCA, 'DT_TRAVEN', item_a('DT_TRANSACAO', tTRA_TRANSACAO));
    retrieve_e(tTRA_TROCA);
    if (xStatus < 0) then begin
      Result := SetStatus(STS_ERROR, 'GEN001', , cDS_METHOD);
      return(-1); exit;
    end;
  end;
  if (gCdPessoa = 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN001', , cDS_METHOD);
    return(-1); exit;
  end;

  setocc(tTRA_TRANSACAO, 1);

  gNrFaturaPadrao := '';

  if (item_f('TP_DOCTO', tGER_OPERACAO) = 2)  or (item_f('TP_DOCTO', tGER_OPERACAO) = 3) then begin
    gNrFaturaPadrao := vNrTransacao;
  end else begin

    clear_e(tFIS_NF);
    retrieve_e(tFIS_NF);
    if (xStatus >= 0) then begin
      setocc(tFIS_NF, 1);

      if (item_f('NR_NF', tFIS_NF) > 0) then begin
        gNrFaturaPadrao := item_f('NR_NF', tFIS_NF);
      end;
    end;
  end;
  if (gInPDVOtimizado = True) then begin
    fieldsyntax item_f('VL_DOCUMENTO', tSIS_TOTAL), 'HID';
    fieldsyntax item_b('IN_ADIANTATROCO', tSIS_DUMMY3), 'HID';
  end;

  viParams := '';
  putitemXml(viParams, 'CD_OPERACAO', item_f('CD_OPERACAO', tGER_OPERACAO));
  voParams := activateCmp('GERSVCO054', 'dadosAdicionaisOperacao', viParams); (*,viParams,voParams,, *)
  if (xStatus < 0) then begin
    Result := voParams;
    return(-1); exit;
  end;
  if (itemXml('TP_IMPRESSAOTRA', voParams) = 1) then begin
    gTpImpressaoTraVenda := 0;
  end;

  return(0); exit;
end;

//-------------------------------------------------------------
function T_TRAFM066.validaTransacao(pParams : String) : String;
//-------------------------------------------------------------

var
  vDsRegistro, vDsLstTransacao, vDsSituacao : String;
  vCdEmpresa, vNrTransacao : Real;
  vDtTransacao : TDate;
begin
  if (gInPerguntaCpfCnpj = True) then begin
    if (item_f('CD_PESSOA', tTRA_TRANSACAO) = gCdClientePDV ) and (gInPdvOtimizado = True) then begin
      askmess 'O CPF/CNPJ não foi informado! Deseja continuar?', 'Não, Sim';
      if (xStatus = 1) then begin
        return(-1); exit;
      end;
    end;
  end;

  clear_e(tTRA_S_TRANSACAO);

  vDsLstTransacao := gDsLstTransacao;
  repeat
    getitem(vDsRegistro, vDsLstTransacao, 1);

    vCdEmpresa := itemXmlF('CD_EMPRESA', vDsRegistro);
    vNrTransacao := itemXmlF('NR_TRANSACAO', vDsRegistro);
    vDtTransacao := itemXml('DT_TRANSACAO', vDsRegistro);

    if (vCdEmpresa = 0) then begin
      Result := SetStatus(STS_ERROR, 'GEN001', , cDS_METHOD);
      return(-1); exit;
    end;
    if (vNrTransacao = 0) then begin
      Result := SetStatus(STS_ERROR, 'GEN001', , cDS_METHOD);
      return(-1); exit;
    end;
    if (vDtTransacao = '') then begin
      Result := SetStatus(STS_ERROR, 'GEN001', , cDS_METHOD);
      return(-1); exit;
    end;

    creocc(tTRA_S_TRANSACAO, -1);
    putitem_e(tTRA_S_TRANSACAO, 'CD_EMPRESA', vCdEmpresa);
    putitem_e(tTRA_S_TRANSACAO, 'NR_TRANSACAO', vNrTransacao);
    putitem_e(tTRA_S_TRANSACAO, 'DT_TRANSACAO', vDtTransacao);
    retrieve_o(tTRA_S_TRANSACAO);
    if (xStatus = -7) then begin
      retrieve_x(tTRA_S_TRANSACAO);
      if (item_f('TP_SITUACAO', tTRA_S_TRANSACAO) <> 5) then begin
        Result := SetStatus(STS_ERROR, 'GEN001', , cDS_METHOD);
        return(-1); exit;
      end;
    end else if (xStatus = 0) then begin
      Result := SetStatus(STS_ERROR, 'GEN001', , cDS_METHOD);
      return(-1); exit;
    end;

    delitem(vDsLstTransacao, 1);
  until (vDsLstTransacao = '');

  return(0); exit;
end;

//-------------------------------------------------------
function T_TRAFM066.criaValor(pParams : String) : String;
//-------------------------------------------------------

var
  viParams, voParams : String;
  vNrFat : Real;
begin
  setocc(tSIS_VALOR, 1);

  if (gTpSimuladorFat > 0 ) or (gInSimuladorProduto = True ) or (gInSimuladorCondPgto = True)  and (gInDinheiro <> True)  and (item_f('VL_TRANSACAO', tTRA_TRANSACAO) > item_f('VL_TOTAL', tR_TRA_TRANSACAO)) then begin
    voParams := carregaSimulacao(viParams); (* *)
    if (xStatus < 0) then begin
      Result := voParams;
      return(-1); exit;
    end;

    voParams := calculaPrazoMedio(viParams); (* *)
    if (xStatus < 0) then begin
      Result := voParams;
      return(-1); exit;
    end;

    voParams := calculaTotal(viParams); (* *)
    if (xStatus < 0) then begin
      Result := voParams;
      return(-1); exit;
    end;

    setocc(tSIS_VALOR, 1);
  end else begin
    if (gInDinheiro = True)  or (gInTroca = True) then begin
      viParams := '';
      putitemXml(viParams, 'NM_ENTIDADE', 'FCR_FATURAI');
      voParams := activateCmp('GERSVCO031', 'getNumSeq', viParams); (*,viParams,voParams,, *)
      if (xStatus < 0) then begin
        Result := voParams;
        return(-1); exit;
      end;

      vNrFat := itemXmlF('NR_SEQUENCIA', voParams);

      if (gInDinheiro= True) then begin
        putitem_e(tSIS_VALOR, 'VL_DOCUMENTO', item_f('VL_TOTAL', tSIS_DUMMY3));
        putitem_e(tSIS_VALOR, 'TP_DOCUMENTO', 3);
        putitem_e(tSIS_VALOR, 'NR_DOCUMENTO', vNrFat);
        putitem_e(tSIS_VALOR, 'DT_VENCIMENTO', itemXml('DT_SISTEMA', PARAM_GLB));
        putitem_e(tSIS_TOTAL, 'VL_DOCUMENTO', item_f('VL_DOCUMENTO', tSIS_VALOR));
      end else if (gInTroca = True) then begin
        putitem_e(tSIS_VALOR, 'VL_DOCUMENTO', item_f('VL_CREDDEV', tSIS_ADIANTAMENTO));
        putitem_e(tSIS_VALOR, 'TP_DOCUMENTO', 20);
        putitem_e(tSIS_VALOR, 'NR_DOCUMENTO', vNrFat);
        putitem_e(tSIS_VALOR, 'DT_VENCIMENTO', itemXml('DT_SISTEMA', PARAM_GLB));
        putitem_e(tSIS_TOTAL, 'VL_DOCUMENTO', item_f('VL_DOCUMENTO', tSIS_VALOR));
      end;

      voParams := calculaTotal(viParams); (* *)
      if (xStatus < 0) then begin
        Result := voParams;
        return(-1); exit;
      end;

      creocc(tSIS_VALOR, -1);
    end;
    if (gTpDocumento > 0) then begin
      if (item_f('VL_RESTANTE', tSIS_DUMMY3) > 0) then begin
        if (gTpDocumento = 3) then begin
          viParams := '';
          putitemXml(viParams, 'NM_ENTIDADE', 'FCR_FATURAI');
          voParams := activateCmp('GERSVCO031', 'getNumSeq', viParams); (*,viParams,voParams,, *)
          if (xStatus < 0) then begin
            Result := voParams;
            return(-1); exit;
          end;
          vNrFat := itemXmlF('NR_SEQUENCIA', voParams);
          putitem_e(tSIS_VALOR, 'NR_DOCUMENTO', vNrFat);
          putitem_e(tSIS_VALOR, 'DT_VENCIMENTO', itemXml('DT_SISTEMA', PARAM_GLB));
        end;
        putitem_e(tSIS_VALOR, 'VL_DOCUMENTO', item_f('VL_RESTANTE', tSIS_DUMMY3));
        putitem_e(tSIS_VALOR, 'TP_DOCUMENTO', gTpDocumento);
        putitem_e(tSIS_TOTAL, 'VL_DOCUMENTO', item_f('VL_DOCUMENTO', tSIS_TOTAL) + item_f('VL_DOCUMENTO', tSIS_VALOR));
      end;

      voParams := calculaTotal(viParams); (* *)
      if (xStatus < 0) then begin
        Result := voParams;
        return(-1); exit;
      end;
    end;
  end;

  return(0); exit;
end;

//---------------------------------------------------------------
function T_TRAFM066.calculaPrazoMedio(pParams : String) : String;
//---------------------------------------------------------------

var
  vNrOcc, vVlCalc, vVlTotal : Real;
  vDtSistema : TDate;
begin
  vDtSistema := itemXml('DT_SISTEMA', PARAM_GLB);

  vVlTotal := 0;
  putitem_e(tSIS_TOTAL, 'VL_DOCUMENTO', 0);
  vNrOcc := curocc(tSIS_VALOR);
  setocc(tSIS_VALOR, 1);
  while (xStatus >= 0) do begin
    if (item_f('TP_DOCUMENTO', tSIS_VALOR) <> 18) then begin
      vVlTotal := vVlTotal + (item_f('VL_DOCUMENTO', tSIS_VALOR) * (item_a('DT_VENCIMENTO', tSIS_VALOR) - vDtSistema));
      putitem_e(tSIS_TOTAL, 'VL_DOCUMENTO', item_f('VL_DOCUMENTO', tSIS_TOTAL) + item_f('VL_DOCUMENTO', tSIS_VALOR));
    end;
    setocc(tSIS_VALOR, curocc(tSIS_VALOR) + 1);
  end;

  vVlCalc := vVlTotal / item_f('VL_DOCUMENTO', tSIS_TOTAL);
  putitem_e(tSIS_TOTAL, 'QT_PRAZOMEDIO', roundto(vVlCalc, 1));

  setocc(tSIS_VALOR, 1);

  return(0); exit;
end;

//----------------------------------------------------------
function T_TRAFM066.calculaTotal(pParams : String) : String;
//----------------------------------------------------------

var
  vNrOcc : Real;
begin
    putitem_e(tSIS_TOTAL, 'VL_DOCUMENTO', '');

  vNrOcc := curocc(tSIS_VALOR);
  setocc(tSIS_VALOR, 1);
  while (xStatus >= 0) do begin
    putitem_e(tSIS_TOTAL, 'VL_DOCUMENTO', item_f('VL_DOCUMENTO', tSIS_TOTAL) + item_f('VL_DOCUMENTO', tSIS_VALOR));
    setocc(tSIS_VALOR, curocc(tSIS_VALOR) + 1);
  end;

  setocc(tSIS_VALOR, 1);

  putitem_e(tSIS_DUMMY3, 'VL_RESTANTE', item_f('VL_TOTAL', tSIS_DUMMY3) - item_f('VL_DOCUMENTO', tSIS_TOTAL));
  if (item_f('VL_RESTANTE', tSIS_DUMMY3) < 0) then begin
    putitem_e(tSIS_DUMMY3, 'VL_TROCO', gabs(item_f('VL_RESTANTE', tSIS_DUMMY3)));
    putitem_e(tSIS_DUMMY3, 'VL_RESTANTE', '');
  end else begin
    putitem_e(tSIS_DUMMY3, 'VL_TROCO', '');
  end;
  if (item_f('VL_MAXTROCO', tSIS_ADIANTAMENTO) > 0) then begin
    putitem_e(tSIS_ADIANTAMENTO, 'VL_DIF', item_f('VL_MAXTROCO', tSIS_ADIANTAMENTO) - item_f('VL_DOCUMENTO', tSIS_TOTAL));
  end;

  return(0); exit;
end;

//---------------------------------------------------------------
function T_TRAFM066.validaRecebimento(pParams : String) : String;
//---------------------------------------------------------------

var
  viParams, voParams, vDsLstParcelamento, vDsRegistro, vDsConta, vDsBanda, vDsAdicional : String;
  vVlCalc, vVlDinheiro, vVlCheque, vVlChequeVista, vVlDesconto, vNrDias, vNrDiasTotal, vNrCheque, vNrAgencia, vNrBanco : Real;
  vVlDOFNI, vPrTroco, vNrSeqTotTEF, vVlVista, vVlPrazo, vNrPrzMedioMax, vNrPrazoMedioPgto : Real;
  vDtSistema : TDate;
  vInCheque, vInCartaoProprio : Boolean;
  vDsLstUsuario, vDsRestricao : String;
begin
  vDtSistema := itemXml('DT_SISTEMA', PARAM_GLB);
  vNrDias := itemXmlF('NR_DIAS_PRAZOMED_LIB_FAT', xParamEmp);

  vVlDinheiro := 0;
  vVlCheque := 0;
  vVlDesconto := 0;
  gVlVista := 0;
  gVlPrazo := 0;
  gVlAdiantamento := 0;
  gVlCREDEV := 0;
  vDsLstParcelamento := '';

  if (gTpSimuladorFat = 2) then begin
    if (vNrDias <> '') then begin
      vNrDiasTotal := vNrDias + gNrPrazoMedio;

      if (item_f('QT_PRAZOMEDIO', tSIS_TOTAL) > vNrDiasTotal) then begin
        if (vNrDias = 0) then begin
          Result := SetStatus(STS_ERROR, 'GEN001', , cDS_METHOD);
        end else begin
          Result := SetStatus(STS_ERROR, 'GEN001', , cDS_METHOD);
        end;

        voParams := verificaRestricao(viParams); (* TRAFM066, 'IN_LIBERA_PRAZOMEDIO', 0 *)
        if (xStatus < 0) then begin
          Result := voParams;
          return(-1); exit;
        end;
      end;
    end;
  end else begin
    viParams := '';
    putitemXml(viParams, 'CD_CONDPGTO', item_f('CD_CONDPGTO', tTRA_TRANSACAO));
    voParams := activateCmp('GERSVCO013', 'calcPrzMedio', viParams); (*viParams,voParams,, *)
    if (xStatus < 0) then begin
      Result := voParams;
      return(-1); exit;
    end;

    vNrPrazoMedioPgto := itemXmlF('NR_PRAZOMEDIO', voParams);

    if (vNrDias <> '') then begin
      vNrDiasTotal := vNrDias + vNrPrazoMedioPgto;
      if (item_f('QT_PRAZOMEDIO', tSIS_TOTAL) > vNrDiasTotal) then begin
        if (vNrDias = 0) then begin
          Result := SetStatus(STS_ERROR, 'GEN0001', , cDS_METHOD);
        end else begin
          Result := SetStatus(STS_ERROR, 'GEN0001', , cDS_METHOD);
        end;

        voParams := verificaRestricao(viParams); (* TRAFM066, 'IN_LIBERA_PRAZOMEDIO', 0 *)
        if (xStatus < 0) then begin
          Result := voParams;
          return(-1); exit;
        end;
      end;
    end;
  end;

  vNrSeqTotTEF := 0;
  gvInTefCartao := False;
  setocc(tSIS_VALOR, 1);
  while (xStatus >= 0) do begin

    if (item_f('TP_DOCUMENTO', tSIS_VALOR) = 7)  or (gTpTEF = 2 ) and (item_f('TP_DOCUMENTO', tSIS_VALOR) = 8)  or (item_f('TP_DOCUMENTO', tSIS_VALOR) = 19)  or (item_f('TP_DOCUMENTO', tSIS_VALOR) = 22) then begin
      gInTEF := True;
      vNrSeqTotTEF := vNrSeqTotTEF + 1;
    end;

    if  (putitem_e(tSIS_VALOR, 'TP_DOCUMENTO', 4)  or (item_f('TP_DOCUMENTO', tSIS_VALOR), 5)  or (item_f('TP_DOCUMENTO', tSIS_VALOR), 7)  or (item_f('TP_DOCUMENTO', tSIS_VALOR), 8)  or (item_f('TP_DOCUMENTO', tSIS_VALOR), 19)  or (item_f('TP_DOCUMENTO', tSIS_VALOR), 22));
      gvInTefCartao := True;
    end;
    setocc(tSIS_VALOR, curocc(tSIS_VALOR) + 1);
  end;
  if (vNrSeqTotTEF > 5) then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', , cDS_METHOD);
    return(-1); exit;
  end;

  clear_e(tTMP_NR10);

  if (empty(tSIS_VALOR) <> False) then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', , cDS_METHOD);
    return(-1); exit;
  end;
  if (item_f('VL_RESTANTE', tSIS_DUMMY3) > 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', , cDS_METHOD);
    return(-1); exit;
  end;
  if (item_b('IN_ADIANTATROCO', tSIS_DUMMY3) = True)  and (item_f('VL_TROCO', tSIS_DUMMY3) > 0) then begin
    askmess 'Deseja lançar troco como adiantamento?', 'Confirmar, Cancelar';
    if (xStatus = 2) then begin
      return(-1); exit;
    end;
  end;

  clear_e(tTMP_NR10);

  setocc(tSIS_VALOR, 1);
  while (xStatus >= 0) do begin
    if (item_f('TP_DOCUMENTO', tSIS_VALOR) = 0) then begin
      if (item_f('VL_DOCUMENTO', tSIS_VALOR) > 0) then begin
        Result := SetStatus(STS_ERROR, 'GEN0001', , cDS_METHOD);
        return(-1); exit;
      end else begin
        discard 'SIS_VALOR';
        if (xStatus <= 0) then begin
          xStatus := -1;
        end;
      end;
    end else begin
      if (item_f('VL_DOCUMENTO', tSIS_VALOR) = 0) then begin
        Result := SetStatus(STS_ERROR, 'GEN0001', , cDS_METHOD);
        return(-1); exit;
      end;
      if (item_f('NR_DOCUMENTO', tSIS_VALOR) = 0) then begin
        if (item_f('TP_DOCUMENTO', tSIS_VALOR) = 2) then begin
        end else begin
          Result := SetStatus(STS_ERROR, 'GEN0001', , cDS_METHOD);
          return(-1); exit;
        end;
      end;
      if (item_f('TP_DOCUMENTO', tSIS_VALOR) = 3) then begin
        vVlDinheiro := vVlDinheiro + item_f('VL_DOCUMENTO', tSIS_VALOR);
      end else if (item_f('TP_DOCUMENTO', tSIS_VALOR) = 2) then begin
        if (item_f('NR_DOCUMENTO', tSIS_VALOR) > 0) then begin
          creocc(tTMP_NR10, -1);
          putitem_e(tTMP_NR10, 'NR_GERAL', item_f('NR_DOCUMENTO', tSIS_VALOR));
          retrieve_o(tTMP_NR10);
          if (xStatus = 4) then begin
            askmess 'Existe mais de um cheque com o número ' + NR_DOCUMENTO + '.SIS_VALOR! Continuar?', 'Não, Sim';
            if (xStatus = 1) then begin
              return(-1); exit;
            end;
          end;
        end;
        vVlCheque := vVlCheque + item_f('VL_DOCUMENTO', tSIS_VALOR);
        if (item_a('DT_VENCIMENTO', tSIS_VALOR) = vDtSistema) then begin
          vVlChequeVista := vVlChequeVista + item_f('VL_DOCUMENTO', tSIS_VALOR);
        end;
      end else if (item_f('TP_DOCUMENTO', tSIS_VALOR) = 18) then begin
        if (item_f('NR_DOCUMENTO', tSIS_VALOR) > 0) then begin
          creocc(tTMP_NR10, -1);
          putitem_e(tTMP_NR10, 'NR_GERAL', item_f('NR_DOCUMENTO', tSIS_VALOR));
          retrieve_o(tTMP_NR10);
          if (xStatus = 4) then begin
            Result := SetStatus(STS_AVISO, 'GEN001', , cDS_METHOD);
            return(-1); exit;
          end;
        end;
      end else if (item_f('TP_DOCUMENTO', tSIS_VALOR) = 10) then begin
        gVlAdiantamento := gVlAdiantamento + item_f('VL_DOCUMENTO', tSIS_VALOR);
      end else if (item_f('TP_DOCUMENTO', tSIS_VALOR) = 11) then begin
        vVlDesconto := vVlDesconto + item_f('VL_DOCUMENTO', tSIS_VALOR);
      end else if (item_f('TP_DOCUMENTO', tSIS_VALOR) = 12) then begin
        vVlDOFNI := vVlDOFNI + item_f('VL_DOCUMENTO', tSIS_VALOR);
      end else if (item_f('TP_DOCUMENTO', tSIS_VALOR) = 15) then begin
        if (item_f('NR_DOCUMENTO', tSIS_VALOR) > 0) then begin
          creocc(tTMP_NR10, -1);
          putitem_e(tTMP_NR10, 'NR_GERAL', item_f('NR_DOCUMENTO', tSIS_VALOR));
          retrieve_o(tTMP_NR10);
          if (xStatus = 4) then begin
            askmess 'Existe mais de um cheque com o número ' + NR_DOCUMENTO + '.SIS_VALOR! Continuar?', 'Não, Sim';
            if (xStatus = 1) then begin
              return(-1); exit;
            end;
          end;
        end;
        viParams := '';
        putitemXml(viParams, 'CD_GUIA', item_f('CD_GUIA', tTRA_TRANSACAO));
        putitemXml(viParams, 'NR_CHEQUE', itemXmlF('NR_CHEQUE', item_a('DS_ADICIONAL', tSIS_VALOR)));
        putitemXml(viParams, 'DT_EMISSAO', itemXml('DT_SISTEMA', PARAM_GLB));
        putitemXml(viParams, 'VL_CHEQUE', item_f('VL_DOCUMENTO', tSIS_VALOR));
        putitemXml(viParams, 'DT_VENCIMENTO', item_a('DT_VENCIMENTO', tSIS_VALOR));
        voParams := activateCmp('FGRSVCO024', 'validarCheque', viParams); (*,viParams,voParams,, *)
        if (xStatus < 0) then begin
          Result := voParams;
          return(-1); exit;
        end;

        vVlCheque := vVlCheque + item_f('VL_DOCUMENTO', tSIS_VALOR);
        if (item_a('DT_VENCIMENTO', tSIS_VALOR) = vDtSistema) then begin
          vVlChequeVista := vVlChequeVista + item_f('VL_DOCUMENTO', tSIS_VALOR);
        end;
      end else if (item_f('TP_DOCUMENTO', tSIS_VALOR) = 20) then begin
        gVlCREDEV := gVlCREDEV + item_f('VL_DOCUMENTO', tSIS_VALOR);
      end;
      if (item_f('TP_DOCUMENTO', tSIS_VALOR) = 1)  or (item_f('TP_DOCUMENTO', tSIS_VALOR) = 14) then begin
        gVlPrazo := gVlPrazo + item_f('VL_DOCUMENTO', tSIS_VALOR);

      end else if (item_f('TP_DOCUMENTO', tSIS_VALOR) = 4) then begin
        if (gCdCartao <> 0) then begin
          viParams := '';
          putitemXml(viParams, 'CD_CARTAO', gCdCartao);
          putitemXml(viParams, 'TP_DOCUMENTO', item_f('TP_DOCUMENTO', tSIS_VALOR));
          putitemXml(viParams, 'NR_SEQHISTRELSUB', itemXmlF('NR_SEQHISTRELSUB', item_a('DS_ADICIONAL', tSIS_VALOR)));
          voParams := activateCmp('CTCSVCO004', 'verificaTipoCartao', viParams); (*,viParams,voParams,, *)
          if (xStatus < 0) then begin
            Result := voParams;
            return(-1); exit;
          end;
          vInCartaoProprio := itemXmlB('IN_CARTAOPROPRIO', voParams);

          if (vInCartaoProprio = True) then begin
            gVlPrazo := gVlPrazo + item_f('VL_DOCUMENTO', tSIS_VALOR);
          end else begin
            gVlVista := gVlVista + item_f('VL_DOCUMENTO', tSIS_VALOR);
          end;
        end else begin
          gVlVista := gVlVista + item_f('VL_DOCUMENTO', tSIS_VALOR);
        end;

      end else begin
        if (item_a('DT_VENCIMENTO', tSIS_VALOR) = vDtSistema) then begin
          gVlVista := gVlVista + item_f('VL_DOCUMENTO', tSIS_VALOR);
        end else begin
          gVlPrazo := gVlPrazo + item_f('VL_DOCUMENTO', tSIS_VALOR);
        end;
      end;

      vDsRegistro := '';
      putitemXml(vDsRegistro, 'TP_DOCUMENTO', item_f('TP_DOCUMENTO', tSIS_VALOR));
      putitemXml(vDsRegistro, 'NR_SEQHISTRELSUB', itemXmlF('NR_SEQHISTRELSUB', item_a('DS_ADICIONAL', tSIS_VALOR)));
      putitem(vDsLstParcelamento,  vDsRegistro);

      setocc(tSIS_VALOR, curocc(tSIS_VALOR) + 1);
    end;
  end;

  clear_e(tTMP_K04NRDS);
  setocc(tSIS_VALOR, 1);
  while (xStatus >= 0) do begin
    if (item_f('TP_DOCUMENTO', tSIS_VALOR) = 2)  or (item_f('TP_DOCUMENTO', tSIS_VALOR) = 15) then begin
      vDsAdicional := item_a('DS_ADICIONAL', tSIS_VALOR);

      if (vDsAdicional <> '') then begin
        vNrBanco := itemXmlF('NR_BANCO', vDsAdicional);
        vNrAgencia := itemXmlF('NR_AGENCIA', vDsAdicional);
        vNrCheque := itemXmlF('NR_CHEQUE', vDsAdicional);
        vDsConta := itemXmlF('NR_CONTA', vDsAdicional);
        vDsBanda := itemXmlF('NR_BANDA', vDsAdicional);
        if (vDsBanda <> '') then begin
          clear_e(tFCR_CHEQUE);
          putitem_e(tFCR_CHEQUE, 'DS_BANDA', vDsBanda);
          retrieve_e(tFCR_CHEQUE);
          if (xStatus >=0) then begin
            setocc(tFCR_CHEQUE, 1);
            while (xStatus >= 0) do begin
              clear_e(tF_FCR_FATURAI);
              putitem_e(tF_FCR_FATURAI, 'CD_EMPRESA', item_f('CD_EMPRESA', tFCR_CHEQUE));
              putitem_e(tF_FCR_FATURAI, 'CD_CLIENTE', item_f('CD_CLIENTE', tFCR_CHEQUE));
              putitem_e(tF_FCR_FATURAI, 'NR_FAT', item_f('NR_FAT', tFCR_CHEQUE));
              putitem_e(tF_FCR_FATURAI, 'NR_PARCELA', item_f('NR_PARCELA', tFCR_CHEQUE));
              retrieve_e(tF_FCR_FATURAI);
              if (xStatus >= 0)  and (item_f('TP_SITUACAO', tF_FCR_FATURAI) = 1) then begin
                Result := SetStatus(STS_ERROR, 'GEN0001', , cDS_METHOD);
                return(-1); exit;
              end;

              setocc(tFCR_CHEQUE, curocc(tFCR_CHEQUE) + 1);
            end;
          end;
        end else if (vNrBanco > 0)  and (vNrAgencia > 0)  and (vNrCheque > 0)  and (vDsConta <> '') then begin
          clear_e(tFCR_CHEQUE);
          putitem_e(tFCR_CHEQUE, 'NR_BANCO', vNrBanco);
          putitem_e(tFCR_CHEQUE, 'NR_AGENCIA', vNragencia);
          putitem_e(tFCR_CHEQUE, 'DS_CONTA', vDsConta);
          putitem_e(tFCR_CHEQUE, 'NR_CHEQUE', vNrCheque);
          retrieve_e(tFCR_CHEQUE);
          if (xStatus >= 0) then begin
            setocc(tFCR_CHEQUE, 1);
            while (xStatus >= 0) do begin
              clear_e(tF_FCR_FATURAI);
              putitem_e(tF_FCR_FATURAI, 'CD_EMPRESA', item_f('CD_EMPRESA', tFCR_CHEQUE));
              putitem_e(tF_FCR_FATURAI, 'CD_CLIENTE', item_f('CD_CLIENTE', tFCR_CHEQUE));
              putitem_e(tF_FCR_FATURAI, 'NR_FAT', item_f('NR_FAT', tFCR_CHEQUE));
              putitem_e(tF_FCR_FATURAI, 'NR_PARCELA', item_f('NR_PARCELA', tFCR_CHEQUE));
              retrieve_e(tF_FCR_FATURAI);
              if (xStatus >= 0)  and (item_f('TP_SITUACAO', tF_FCR_FATURAI) = 1) then begin
                Result := SetStatus(STS_ERROR, 'GEN0001', , cDS_METHOD);
                return(-1); exit;
              end;

              setocc(tFCR_CHEQUE, curocc(tFCR_CHEQUE) + 1);
            end;
          end;
        end;
        creocc(tTMP_K04NRDS, -1);
        putitem_e(tTMP_K04NRDS, 'NR_CHAVE01', vNrBanco);
        putitem_e(tTMP_K04NRDS, 'NR_CHAVE02', vNrAgencia);
        putitem_e(tTMP_K04NRDS, 'NR_CHAVE03', vNrCheque);
        putitem_e(tTMP_K04NRDS, 'DS_CHAVE04', vDsConta);
        retrieve_o(tTMP_K04NRDS);
        if (xStatus = 4) then begin
          Result := SetStatus(STS_ERROR, 'GEN0001', , cDS_METHOD);
          return(-1); exit;
        end;
        putitem_e(tTMP_K04NRDS, 'DS_BANDA', vDsBanda);

      end;
    end;

    setocc(tSIS_VALOR, curocc(tSIS_VALOR) + 1);
  end;
  if (gCdCartao <> 0) then begin
    viParams := '';
    putitemXml(viParams, 'CD_CARTAO', gCdCartao);
    putitemXml(viParams, 'DS_LSTPARCELAMENTO', vDsLstParcelamento);
    voParams := activateCmp('CTCSVCO004', 'verificaParcelamentoCartao', viParams); (*,viParams,voParams,, *)
    if (xStatus < 0) then begin
      Result := voParams;
      return(-1); exit;
    end;
    gInParCartaoProprio := itemXmlB('IN_PARCARTAOPROPRIO', voParams);
  end;

  voParams := validaLimite(viParams); (* *)

  if (xStatus < 0) then begin
    return(-1); exit;
  end;
  if (gInTrocoMaximo = True) then begin
    viParams := '';
    putitemXml(viParams, 'VL_MAXTROCO', item_f('VL_MAXTROCO', tSIS_ADIANTAMENTO));
    putitemXml(viParams, 'VL_RECEBER', item_f('VL_TOTAL', tSIS_DUMMY3));
    putitemXml(viParams, 'VL_RECEBIDO', item_f('VL_DOCUMENTO', tSIS_TOTAL));
    putitemXml(viParams, 'VL_CHEQUEVISTA', vVlCheque);
    putitemXml(viParams, 'VL_DINHEIRO', vVlDinheiro);
    voParams := activateCmp('SICSVCO005', 'validaVlMaxTroco', viParams); (*,viParams,voParams,, *)
    if (xStatus < 0) then begin
      Result := voParams;
      return(-1); exit;
    end;
  end else begin
    if (item_f('VL_TROCO', tSIS_DUMMY3) > 0) then begin
      if (vVlDinheiro > 0) then begin
        if (item_f('VL_TROCO', tSIS_DUMMY3) >= vVlDinheiro) then begin
          Result := SetStatus(STS_ERROR, 'GEN001', , cDS_METHOD);
          return(-1); exit;
        end;
      end else if (vVlCheque > 0) then begin
        if (item_f('VL_TROCO', tSIS_DUMMY3) >= vVlCheque) then begin
          Result := SetStatus(STS_ERROR, 'GEN001', , cDS_METHOD);
          return(-1); exit;
        end;
      end else if (vVlDOFNI > 0) then begin
        if (item_f('VL_TROCO', tSIS_DUMMY3) >= vVlDOFNI) then begin
          Result := SetStatus(STS_ERROR, 'GEN001', , cDS_METHOD);
          return(-1); exit;
        end;
      end else if (gVlCREDEV > 0)  and (gInTroca = True) then begin
        if (item_f('VL_TROCO', tSIS_DUMMY3) > gVlCREDEV) then begin
          Result := SetStatus(STS_ERROR, 'GEN001', , cDS_METHOD);
          return(-1); exit;
        end;
      end else begin
        Result := SetStatus(STS_ERROR, 'GEN001', , cDS_METHOD);
        return(-1); exit;
      end;
      if (gInPDVOtimizado <> True) then begin
        vPrTroco := (item_f('VL_TROCO', tSIS_DUMMY3) / item_f('VL_TOTAL', tSIS_DUMMY3)) * 100;
        if (vPrTroco > 10)  and (gInValidaMsgTroco = True) then begin
          askmess 'Troco maior que 10% do valor recebido! Deseja realmente continuar?', 'Não, Sim';
          if (xStatus = 1) then begin
            return(-1); exit;
          end;
        end;
      end;
    end;
  end;
  if (vVlDesconto > 0) then begin
    clear_e(tTRA_LIMDESCONTO);
    putitem_e(tTRA_LIMDESCONTO, 'CD_OPERACAO', item_f('CD_OPERACAO', tTRA_TRANSACAO));
    putitem_e(tTRA_LIMDESCONTO, 'CD_USUARIO', itemXmlF('CD_USUARIO', PARAM_GLB));
    retrieve_e(tTRA_LIMDESCONTO);
    if (xStatus >= 0) then begin
      gprDescMaximo := item_f('PR_DESCMAX', tTRA_LIMDESCONTO);
    end else begin
      clear_e(tTRA_LIMDESCONTO);
      gprDescMaximo := 0;
    end;

    vDsRestricao := 'VL_DESC_MAX_FINANC';
    viParams := '';
    putitemXml(viParams, 'CD_COMPONENTE', TRAFM066);
    putitemXml(viParams, 'DS_CAMPO', vDsRestricao);
    voParams := activateCmp('ADMSVCO009', 'verificaUsuarioRestricao', viParams); (*,viParams,voParams,, *)
    if (xStatus < 0) then begin
      Result := voParams;
      return(-1); exit;
    end;
    vDsLstUsuario := itemXml('DS_LSTUSUARIO', voParams);

    if (vDsLstUsuario <> '') then begin
      voParams := verificaRestricao(viParams); (* TRAFM066, vDsRestricao, vVlDesconto *)
      if (xStatus < 0) then begin
        Result := voParams;
        return(-1); exit;
      end;
    end;

    vVlCalc := ((gVlTotalBruto - gVlTotalLiquido) + vVlDesconto) / gVlTotalBruto * 100;
    gprDescTransacao := roundto(vVlCalc, 6);
    if (gprDescTransacao > gprDescMaximo) then begin
      Result := SetStatus(STS_ERROR, 'GEN0001', , cDS_METHOD);
      return(-1); exit;
    end;
  end;
  if (gVlAdiantamento > 0) then begin
    if (gVlAdiantamento > item_f('VL_ADIANTAMENTO', tSIS_ADIANTAMENTO)) then begin
      Result := SetStatus(STS_ERROR, 'GEN0001', , cDS_METHOD);
      return(-1); exit;
    end;
  end;
  if (gVlCREDEV > 0) then begin
    if (gVlCREDEV > item_f('VL_CREDDEV', tSIS_ADIANTAMENTO)) then begin
      Result := SetStatus(STS_ERROR, 'GEN0001', , cDS_METHOD);
      return(-1); exit;
    end;
  end;
  if (vVlCheque > 0) then begin
    vInCheque := False;
    setocc(tSIS_VALOR, 1);
    while (xStatus >= 0) do begin
      if (item_f('TP_DOCUMENTO', tSIS_VALOR) = 2)  and (item_a('DS_OBSERVACAO', tSIS_VALOR) = '') then begin
        voParams := BT_12(viParams); (* *)
        if (xStatus < 0) then begin
          return(-1); exit;
        end;
        vInCheque := True;
      end;
      setocc(tSIS_VALOR, curocc(tSIS_VALOR) + 1);
    end;
    if (vInCheque = True) then begin
      return(-1); exit;
    end;
  end;
  if (gNrPrazoMedMax > 0) then begin
    if (item_f('QT_PRAZOMEDIO', tSIS_TOTAL) > gNrPrazoMedMax) then begin
      Result := SetStatus(STS_ERROR, 'GEN001', , cDS_METHOD);
      voParams := verificaRestricao(viParams); (* TRAFM066, 'IN_LIBERA_PRAZOMEDIO', 0 *)
      if (xStatus < 0) then begin
        Result := voParams;
        return(-1); exit;
      end;
    end;
  end;

  viParams := '';
  putitemXml(viParams, 'CD_PESSOA', item_f('CD_PESSOA', tTRA_TRANSACAO));

  voParams := activateCmp('PESSVCO005', 'buscaDadosPessoa', viParams); (*,viParams,voParams,, *)
  if (xStatus < 0) then begin
    Result := voParams;
    return(-1); exit;
  end;

  vNrPrzMedioMax := itemXmlF('NR_PRZMEDIOMAX', voParams);

  if (vNrPrzMedioMax > 0)  and (item_f('QT_PRAZOMEDIO', tSIS_TOTAL) > vNrPrzMedioMax) then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', , cDS_METHOD);
    return(-1); exit;
  end;

  return(0); exit;
end;

//-----------------------------------------------------------------
function T_TRAFM066.descontoPromocional(pParams : String) : String;
//-----------------------------------------------------------------

var
  viParams, voParams : String;
begin
  viParams := '';
  putitemXml(viParams, 'CD_EMPRESA', item_f('CD_EMPRESA', tTRA_TRANSACAO));
  putitemXml(viParams, 'NR_TRANSACAO', item_f('NR_TRANSACAO', tTRA_TRANSACAO));
  putitemXml(viParams, 'DT_TRANSACAO', item_a('DT_TRANSACAO', tTRA_TRANSACAO));
  voParams := activateCmp('SICSVCO001', 'descontoPromocional', viParams); (*,viParams,voParams,, *)
  if (xStatus < 0) then begin
    Result := voParams;
    return(-1); exit;
  end;

  viParams := '';
  putitemXml(viParams, 'CD_EMPRESA', item_f('CD_EMPRESA', tTRA_TRANSACAO));
  putitemXml(viParams, 'NR_TRANSACAO', item_f('NR_TRANSACAO', tTRA_TRANSACAO));
  putitemXml(viParams, 'DT_TRANSACAO', item_a('DT_TRANSACAO', tTRA_TRANSACAO));
  voParams := activateCmp('SICSVCO001', 'validaDesconto', viParams); (*,viParams,voParams,, *)
  if (xStatus < 0) then begin
    Result := voParams;
    return(-1); exit;
  end;

  gTpImpressaoTEF := 4;

  return(0); exit;
end;

//-----------------------------------------------------------------------
function T_TRAFM066.descontoPromocionalCCusto(pParams : String) : String;
//-----------------------------------------------------------------------

var
  viParams, voParams : String;
begin
  viParams := '';
  putitemXml(viParams, 'CD_EMPRESA', item_f('CD_EMPRESA', tTRA_TRANSACAO));
  putitemXml(viParams, 'NR_TRANSACAO', item_f('NR_TRANSACAO', tTRA_TRANSACAO));
  putitemXml(viParams, 'DT_TRANSACAO', item_a('DT_TRANSACAO', tTRA_TRANSACAO));
  voParams := activateCmp('SICSVCO001', 'descontoPromocionalCCusto', viParams); (*,viParams,voParams,, *)
  if (xStatus < 0) then begin
    Result := voParams;
    return(-1); exit;
  end;

  return(0); exit;
end;

//---------------------------------------------------------------
function T_TRAFM066.incluiChequeBanda(pParams : String) : String;
//---------------------------------------------------------------

var
  (* string piDsLstCheque : IN *)
  vDsRegistro, vDsLstCheque, vDsBanda, vDsAdicional : String;
  vNrBanco, vNrAgencia, vNrConta, vNrCheque, vVlCheque, vNrSeq : Real;
  vDtVencimento : TDate;
begin
  if (piDsLstCheque = '') then begin
    return(0); exit;
  end;

  vNrSeq := 0;
  vDsLstCheque := piDsLstCheque;

  repeat
    vNrSeq := vNrSeq + 1;
    if (vNrSeq > 1) then begin
      creocc(tSIS_VALOR, -1);
    end;

    getitem(vDsRegistro, vDsLstCheque, 1);
    vNrBanco := itemXmlF('NR_BANCO', vDsRegistro);
    vNrAgencia := itemXmlF('NR_AGENCIA', vDsRegistro);
    vNrConta := itemXmlF('NR_CONTA', vDsRegistro);
    vNrCheque := itemXmlF('NR_CHEQUE', vDsRegistro);
    vDsBanda := itemXml('DS_BANDA', vDsRegistro);
    vVlCheque := itemXmlF('VL_CHEQUE', vDsRegistro);
    vDtVencimento := itemXml('DT_VENCIMENTO', vDsRegistro);

    vDsAdicional := '';
    putitemXml(vDsAdicional, 'NR_BANCO', vNrBanco);
    putitemXml(vDsAdicional, 'NR_AGENCIA', vNrAgencia);
    putitemXml(vDsAdicional, 'NR_CONTA', vNrConta);
    putitemXml(vDsAdicional, 'NR_CHEQUE', vNrCheque);
    putitemXml(vDsAdicional, 'NR_BANDA', vDsBanda);
    putitem_e(tSIS_VALOR, 'DS_ADICIONAL', vDsAdicional);

    vDsAdicional := 'Banco: ' + FloatToStr(vNrBanco) + ' / Agência: ' + FloatToStr(vNrAgencia) + ' / Conta: ' + FloatToStr(vNrConta) + ' Nr. cheque: ' + FloatToStr(vNrCheque') + ';
    putitem_e(tSIS_VALOR, 'DS_OBSERVACAO', vDsAdicional);
    putitem_e(tSIS_VALOR, 'VL_DOCUMENTO', vVlCheque);
    putitem_e(tSIS_VALOR, 'TP_DOCUMENTO', 2);
    putitem_e(tSIS_VALOR, 'NR_DOCUMENTO', vNrCheque);
    putitem_e(tSIS_VALOR, 'DT_VENCIMENTO', vDtVencimento);
    putitem_e(tSIS_TOTAL, 'VL_DOCUMENTO', item_f('VL_DOCUMENTO', tSIS_TOTAL) + (item_f('VL_DOCUMENTO', tSIS_VALOR)));

    voParams := calculaTotal(viParams); (* *)
    if (xStatus < 0) then begin
      Result := voParams;
      return(-1); exit;
    end;

    delitem(vDsLstCheque, 1);
  until (vDsLstCheque = '');

  creocc(tSIS_VALOR, -1);

  return(0); exit;
end;

//------------------------------------------------------
function T_TRAFM066.lancaTEF(pParams : String) : String;
//------------------------------------------------------

var
  (* numeric piNrSequencia : IN *)
  viParams, voParams, vDsAprovado, vDsMensagem, vDsAdicional, vDsConteudo : String;
  vNrLinhaCupom, vTpDocumento, vNrSeqHistRelSub, vVlParcela, vVlResto : Real;
  vVlCalc, vNrOccAtual, vNrPrimeiraOcc, vNrDocumento, vNrParcela : Real;
  vCdEmpresa, vNrSeq, vNrNsu, vCdAutorizacao : Real;
  vDtMovimento : TDate;
begin
  gNrExtensao := piNrSequencia;

  if (gTpTEF = 1)  and (gTpImpViaTEF = 0) then begin
    if (gTpImpViaCupomTEF = 4) then begin
      askmess 'Imprimir via(s) do TEF:', 'Ambas, Via do cliente, Via do estab.';
      gTpImpViaTEF := xStatus;
    end else begin
      gTpImpViaTEF := gTpImpViaCupomTEF;
    end;
  end;

  viParams := '';
  if (item_f('TP_DOCUMENTO', tSIS_VALOR) = 7)  or (item_f('TP_DOCUMENTO', tSIS_VALOR) = 19)  or (item_f('TP_DOCUMENTO', tSIS_VALOR) = 22) then begin
    if (gTpTEF = 2) then begin
      selectcase item_f('TP_DOCUMENTO', tSIS_VALOR);
      case 07;
        gvDsCaminho := ':\TEF_DIAL\';
      case 19;
        gvDsCaminho := ':\TEF_DISC\';
      case 22;
        gvDsCaminho := ':\HiperTEF\';
      end else begincase
        gvDsCaminho := '';
      endselectcase;
    end;
    putitemXml(viParams, '000-000', 'CRT');
    putitemXml(viParams, '001-000', item_f('NR_DOCUMENTO', tSIS_VALOR));
    if (gNrCupom > 0) then begin
      putitemXml(viParams, '002-000', gNrCupom);
    end else begin
      putitemXml(viParams, '002-000', item_f('NR_TRANSACAO', tTRA_TRANSACAO));
    end;
    putitemXml(viParams, '003-000', '' + VL_DOCUMENTO + '.SIS_VALOR');
    putitemXml(viParams, '502-001', '1');
    putitemXml(viParams, '999-999', '0');
  end else if (item_f('TP_DOCUMENTO', tSIS_VALOR) = 8) then begin
    putitemXml(viParams, '000-000', 'CHQ');
    putitemXml(viParams, '001-000', item_f('NR_DOCUMENTO', tSIS_VALOR));
    if (gNrCupom > 0) then begin
      putitemXml(viParams, '002-000', gNrCupom);
    end else begin
      putitemXml(viParams, '002-000', item_f('NR_TRANSACAO', tTRA_TRANSACAO));
    end;
    putitemXml(viParams, '003-000', '' + VL_DOCUMENTO + '.SIS_VALOR');
    putitemXml(viParams, '999-999', '0');
  end else if (item_f('TP_DOCUMENTO', tSIS_VALOR) = 17) then begin
    putitemXml(viParams, '000-000', 'PRE');
    putitemXml(viParams, '001-000', item_f('NR_DOCUMENTO', tSIS_VALOR));
    if (gNrCupom > 0) then begin
      putitemXml(viParams, '002-000', gNrCupom);
    end else begin
      putitemXml(viParams, '002-000', item_f('NR_TRANSACAO', tTRA_TRANSACAO));
    end;
    putitemXml(viParams, '003-000', '' + VL_DOCUMENTO + '.SIS_VALOR');
    putitemXml(viParams, '999-999', '0');
  end;
  putitemXml(viParams, 'DS_EXTENSAO', '001');
  putitemXml(viParams, 'IN_P1', True);
  if (gTpTEF = 2) then begin
    putitemXml(viParams, 'DS_CAMINHO', gvDsCaminho);
  end;
  voParams := activateCmp('TEFSVCO010', 'geraArquivoREQ', viParams); (*,viParams,voParams,, *)
  if (xStatus < 0) then begin
    Result := voParams;
    return(-1); exit;
  end;

  vDsConteudo := voParams;

  vDsAprovado := itemXml('009-000', vDsConteudo);
  vNrNsu := itemXml('012-000', vDsConteudo);
  vCdAutorizacao := itemXml('013-000', vDsConteudo);
  vNrLinhaCupom := itemXml('028-000', vDsConteudo);
  vDsMensagem := itemXml('030-000', vDsConteudo);

  if (vDsAprovado <> '0') then begin
    if (gTpTEF = 1) then begin
      Result := SetStatus(STS_ERROR, 'GEN001', , cDS_METHOD);
    end else if (gTpTEF = 2) then begin
      Result := SetStatus(STS_ERROR, 'GEN001', , cDS_METHOD);
    end;

    return(-2);
  end;
  if (item_f('TP_DOCUMENTO', tSIS_VALOR) <> 8)  or (item_f('TP_DOCUMENTO', tSIS_VALOR) = 8 ) and (vNrLinhaCupom > 0) then begin
    viParams := vDsConteudo;
    putitemXml(viParams, 'CD_EMPRESA', item_f('CD_EMPFAT', tTRA_TRANSACAO));
    putitemXml(viParams, 'DS_LSTTRANSACAO', gDsLstTransacao);
    newinstance 'TEFSVCO011', 'TEFSVCO011', 'TRANSACTION=TRUE';
    voParams := activateCmp('TEFSVCO011', 'gravaTransacao', viParams); (*,viParams,voParams,, *)
    if (xStatus < 0) then begin
      Result := voParams;
      return(-1); exit;
    end;

    vCdEmpresa := itemXmlF('CD_EMPRESA', voParams);
    vDtMovimento := itemXml('DT_MOVIMENTO', voParams);
    vNrSeq := itemXmlF('NR_SEQ', voParams);

    creocc(tTEF_TRANSACAO, -1);
    putitem_e(tTEF_TRANSACAO, 'CD_EMPRESA', vCdEmpresa);
    putitem_e(tTEF_TRANSACAO, 'DT_MOVIMENTO', vDtMovimento);
    putitem_e(tTEF_TRANSACAO, 'NR_SEQ', vNrSeq);
    retrieve_o(tTEF_TRANSACAO);
    if (xStatus = -7) then begin
      retrieve_x(tTEF_TRANSACAO);
    end else if (xStatus = 0) then begin
      Result := SetStatus(STS_ERROR, 'GEN001', , cDS_METHOD);
    end;
    if (vNrLinhaCupom = 0) then begin
      Result := SetStatus(STS_ERROR, 'GEN001', , cDS_METHOD);
      clear_e(tTEF_TRANSACAO);
      return(-2);
    end;

    viParams := vDsConteudo;
    voParams := activateCmp('TEFSVCO010', 'buscaDadoCartao', viParams); (*,viParams,voParams,, *)
    if (xStatus < 0) then begin
      Result := voParams;
      return(-1); exit;
    end;

    vTpDocumento := itemXmlF('TP_DOCUMENTO', voParams);
    vNrSeqHistRelSub := itemXmlF('NR_SEQHISTRELSUB', voParams);
  end else begin

    vTpDocumento := 2;
    vNrSeqHistRelSub := 1;
    if (vNrLinhaCupom = 0) then begin
      Result := SetStatus(STS_ERROR, 'GEN001', , cDS_METHOD);
      clear_e(tTEF_TRANSACAO);
    end;
  end;
  if (vTpDocumento = 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN001', , cDS_METHOD);
    return(-1); exit;
  end;
  if (vNrSeqHistRelSub = 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN001', , cDS_METHOD);
    return(-1); exit;
  end;

  clear_e(tFCX_HISTRELSUB);
  putitem_e(tFCX_HISTRELSUB, 'TP_DOCUMENTO', vTpDocumento);
  putitem_e(tFCX_HISTRELSUB, 'NR_SEQHISTRELSUB', vNrSeqHistRelSub);
  retrieve_e(tFCX_HISTRELSUB);
  if (xStatus < 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN001', , cDS_METHOD);
    return(-1); exit;
  end;

  vNrDocumento := item_f('NR_DOCUMENTO', tSIS_VALOR);
  vVlResto := item_f('VL_DOCUMENTO', tSIS_VALOR);
  vVlCalc := item_f('VL_DOCUMENTO', tSIS_VALOR) / item_f('NR_PARCELAS', tFCX_HISTRELSUB);
  vVlParcela := roundto(vVlCalc, 2);

  gNrParcelas := gNrParcelas +  item_f('NR_PARCELAS', tFCX_HISTRELSUB);

  vDsAdicional := item_a('DS_ADICIONAL', tSIS_VALOR);
  discard 'SIS_VALOR';
  vNrOccAtual := curocc(tSIS_VALOR);

  vNrParcela := 1;
  vNrPrimeiraOcc := 0;
  while (vNrParcela <= item_f('NR_PARCELAS', tFCX_HISTRELSUB)) do begin
    creocc(tSIS_VALOR, -1);
    if (vNrPrimeiraOcc = 0) then begin
      vNrPrimeiraOcc := curocc(tSIS_VALOR);
    end;
    putitem_e(tSIS_VALOR, 'VL_DOCUMENTO', vVlParcela);
    putitem_e(tSIS_VALOR, 'TP_DOCUMENTO', item_f('TP_DOCUMENTO', tFCX_HISTRELSUB));
    putitem_e(tSIS_VALOR, 'NR_DOCUMENTO', vNrDocumento);
    putitem_e(tSIS_VALOR, 'DT_VENCIMENTO', itemXml('DT_SISTEMA', PARAM_GLB));
    if (item_f('TP_DOCUMENTO', tSIS_VALOR) = 4)  or (item_f('TP_DOCUMENTO', tSIS_VALOR) = 5) then begin
      vDsAdicional := '';
      putitemXml(vDsAdicional, 'NR_SEQHISTRELSUB', item_f('NR_SEQHISTRELSUB', tFCX_HISTRELSUB));
      putitemXml(vDsAdicional, 'NR_TRANSACAOTEF', item_f('NR_SEQ', tTEF_TRANSACAO));
      putitemXml(vDsAdicional, 'CD_AUTORIZACAO', vCdAutorizacao);
      putitemXml(vDsAdicional, 'NR_NSU', vNrNsu);
      putitem_e(tSIS_VALOR, 'DS_ADICIONAL', vDsAdicional);
      vDsAdicional := 'Operadora: ' + NR_PORTADOR + '.FCX_HISTRELSUB - ' + DS_PORTADOR + '.FGR_PORTADOR / ' + DS_HISTRELSUB + '.FCX_HISTRELSUB';
      putitem_e(tSIS_VALOR, 'DS_OBSERVACAO', vDsAdicional);
    end else if (item_f('TP_DOCUMENTO', tSIS_VALOR) = 2) then begin
      putitem_e(tSIS_VALOR, 'DS_ADICIONAL', vDsAdicional);
    end;

    vVlResto := vVlResto   - vVlParcela;
    vNrParcela := vNrParcela + 1;
  end;
  if (vVlResto <> 0) then begin
    setocc(tSIS_VALOR, 1);
    putitem_e(tSIS_VALOR, 'VL_DOCUMENTO', item_f('VL_DOCUMENTO', tSIS_VALOR) + vVlResto);
  end;

  setocc(tSIS_VALOR, 1);

  return(0); exit;
end;

//-------------------------------------------------------------
function T_TRAFM066.imprimeCupomTEF(pParams : String) : String;
//-------------------------------------------------------------

var
  viParams, voParams, vDsRegistro, vDsLstCartao, vNrSerie, vDsCupom : String;
  vDs1Via, vDs2Via, vDsLinha, vDsConteudo : String;
  vInAchouCorte : Boolean;
  vInLoopImpressao, vInLoopConfirmacao, vInErroGerencial, vInErroVinculado, vInFaltaPapel : Boolean;
  vTpImpressora, vTamNrSerie, vVlValorTEF : Real;
begin
  vInFaltaPapel := False;
  vInErroVinculado := False;
  if (empty(tTEF_TRANSACAO) = False) then begin
    vVlValorTEF := 0;
    setocc(tTEF_TRANSACAO, -1);
    setocc(tTEF_TRANSACAO, 1);
    while (xStatus >= 0) do begin
      vVlValorTEF := vVlValorTEF + item_f('VL_TRANSACAO', tTEF_TRANSACAO);
      setocc(tTEF_TRANSACAO, curocc(tTEF_TRANSACAO) + 1);
    end;

    setocc(tTEF_TRANSACAO, 1);
    while (xStatus >= 0) do begin
      clear_e(tTEF_TIPOTRANS);
      putitem_e(tTEF_TIPOTRANS, 'TP_TEF', item_f('TP_TEF', tTEF_TRANSACAO));
      putitem_e(tTEF_TIPOTRANS, 'TP_TRANSACAO', item_f('TP_TRANSACAO', tTEF_TRANSACAO));
      retrieve_e(tTEF_TIPOTRANS);
      if (xStatus >= 0) then begin
        if (gTpTEF = 1) then begin
          viParams := '';

          putitemXml(viParams, 'TP_VIA', gTpImpViaTEF);
          putitemXml(viParams, 'DS_CUPOM', item_a('DS_CUPOM', tTEF_TRANSACAO));
          voParams := activateCmp('TEFSVCO010', 'buscaViaCartao', viParams); (*,viParams,voParams,, *)
          if (xStatus < 0) then begin
            Result := voParams;
            return(-1); exit;
          end;
          vDsCupom := itemXml('DS_CUPOM', voParams);
        end else begin
          vDsCupom := item_a('DS_CUPOM', tTEF_TRANSACAO);
        end;
        vDsRegistro := '';
        putitemXml(vDsRegistro, 'DS_MENSAGEM', item_a('DS_MENSAGEM', tTEF_TRANSACAO));
        putitemXml(vDsRegistro, 'DS_CUPOM', vDsCupom);
        vDsLstCartao := '';
        putitem(vDsLstCartao,  vDsRegistro);

        viParams := '';
        putitemXml(viParams, 'DS_LSTCUPOM', vDsLstCartao);
        if (item_f('TP_OPERCREDITO', tTEF_TIPOTRANS) = 1) then begin
          if (gInAgrupaCartaoTEF = True) then begin
            putitemXml(viParams, 'DS_FORMAPGTO', 'Cartao');
          end else begin
            putitemXml(viParams, 'DS_FORMAPGTO', 'Cartao credito');
          end;
        end else if (item_f('TP_OPERCREDITO', tTEF_TIPOTRANS) = 2 ) or (item_f('TP_OPERCREDITO', tTEF_TIPOTRANS) = 4) then begin
          if (gInAgrupaCartaoTEF = True) then begin
            putitemXml(viParams, 'DS_FORMAPGTO', 'Cartao');
          end else begin
            putitemXml(viParams, 'DS_FORMAPGTO', 'Cartao debito');
          end;
        end else if (item_f('TP_OPERCREDITO', tTEF_TIPOTRANS) = 3) then begin
          putitemXml(viParams, 'DS_FORMAPGTO', 'Cheque');
        end;
        putitemXml(viParams, 'TP_IMPRESSAO', 1);
        putitemXml(viParams, 'NR_CUPOM', gNrCupom);
        putitemXml(viParams, 'VL_VALOR', item_f('VL_TRANSACAO', tTEF_TRANSACAO));
        putitemXml(viParams, 'VL_VALORTEF', vVlValorTEF);

        if (gInAgrupaCartaoTEF = True) then begin
          if (curocc(tTEF_TRANSACAO) = 1) then begin
            putitemXml(viParams, 'IN_ABREVINCULADO', True);
          end else begin
            putitemXml(viParams, 'IN_ABREVINCULADO', False);
          end;
          if (gnext('item_f('CD_EMPRESA', tTEF_TRANSACAO)') = 0) then begin
            putitemXml(viParams, 'IN_FECHAVINCULADO', True);
          end else begin
            putitemXml(viParams, 'IN_FECHAVINCULADO', False);
          end;
        end else begin

          putitemXml(viParams, 'IN_ABREVINCULADO', True);
          putitemXml(viParams, 'IN_FECHAVINCULADO', True);
        end;

        putitemXml(viParams, 'TP_IMPRESSAOTEF', gTpImpressaoTEF);
        putitemXml(viParams, 'TP_IMPVIATEF', gTpImpViaTEF);
        putitemXml(viParams, 'NR_PARCELAS', gNrParcelas);
        putitemXml(viParams, 'CD_REDETEF', item_f('CD_REDETEF', tTEF_TRANSACAO));
        putitemXml(viParams, 'TP_TRANSACAO', item_f('TP_TRANSACAO', tTEF_TRANSACAO));
        putitemXml(viParams, 'IN_AGRUPA_CARTAO_TEF', gInAgrupaCartaoTEF);
        putitemXml(viParams, 'TP_IMPTEFPAYGO', gTpImpTefPAYGO);
        voParams := activateCmp('TEFFP002', 'EXEC', viParams); (*viParams,voParams,, *)
        if (xStatus < 0) then begin
          Result := voParams;
          return(-1); exit;
        end;
          if (gTpImpressaoTEF = 1)  or (gTpImpressaoTEF = 2)  or (gTpImpressaoTEF = 4) then begin
          end else begin
            if (xStatus = -2) then begin
              return(-1); exit;
            end else if (xStatus = -11) then begin
              vInFaltaPapel := True;
            end;
            vInErroVinculado := True;
            break;
          end;
        end;
        gHrInicio := gclock;
        putmess '- Inicio fechamento TRAFM066 : ' + gHrInicio' + ';
      end;
      setocc(tTEF_TRANSACAO, curocc(tTEF_TRANSACAO) + 1);
    end;
  end else begin

    return(0); exit;
  end;
  if (vInErroVinculado = True) then begin
    vDsLstCartao := '';
    if (empty(tTEF_TRANSACAO) = False) then begin
      setocc(tTEF_TRANSACAO, -1);
      setocc(tTEF_TRANSACAO, 1);
      while (xStatus >= 0) do begin
        clear_e(tTEF_TIPOTRANS);
        putitem_e(tTEF_TIPOTRANS, 'TP_TEF', item_f('TP_TEF', tTEF_TRANSACAO));
        putitem_e(tTEF_TIPOTRANS, 'TP_TRANSACAO', item_f('TP_TRANSACAO', tTEF_TRANSACAO));
        retrieve_e(tTEF_TIPOTRANS);
        if (xStatus >= 0) then begin
          if (gTpTEF = 1) then begin
            viParams := '';

            putitemXml(viParams, 'TP_VIA', gTpImpViaTEF);
            putitemXml(viParams, 'DS_CUPOM', item_a('DS_CUPOM', tTEF_TRANSACAO));
            voParams := activateCmp('TEFSVCO010', 'buscaViaCartao', viParams); (*,viParams,voParams,, *)
            if (xStatus < 0) then begin
              Result := voParams;
              return(-1); exit;
            end;
            vDsCupom := itemXml('DS_CUPOM', voParams);
          end else begin
            vDsCupom := item_a('DS_CUPOM', tTEF_TRANSACAO);
          end;
          vDsRegistro := '';
          putitemXml(vDsRegistro, 'DS_MENSAGEM', item_a('DS_MENSAGEM', tTEF_TRANSACAO));
          putitemXml(vDsRegistro, 'DS_CUPOM', vDsCupom);
          putitem(vDsLstCartao,  vDsRegistro);
        end;
        setocc(tTEF_TRANSACAO, curocc(tTEF_TRANSACAO) + 1);
      end;
    end;
    vInLoopImpressao := True;
    repeat
      if (vInFaltaPapel = True) then begin
        askmess 'Falta de papel! Tentar imprimir novamente?', 'Sim, Não';
      end else begin
        askmess 'Impressora não responde! Tentar imprimir novamente?', 'Sim, Não';
      end;
      if (xStatus = 2) then begin
        return(-1); exit;
      end;
      viParams := '';
      putitemXml(viParams, 'DS_LSTCUPOM', vDsLstCartao);
      putitemXml(viParams, 'TP_IMPRESSAO', 2);
      putitemXml(viParams, 'TP_IMPRESSAOTEF', gTpImpressaoTEF);
      putitemXml(viParams, 'NR_PARCELAS', gNrParcelas);
      putitemXml(viParams, 'CD_REDETEF', item_f('CD_REDETEF', tTEF_TRANSACAO));
      voParams := activateCmp('TEFFP002', 'EXEC', viParams); (*viParams,voParams,, *)
      if (xStatus < 0) then begin
        Result := voParams;
        return(-1); exit;
      end;
      if (xStatus >= 0) then begin
        vInLoopImpressao := False;
      end;
    until (vInLoopImpressao := False);
  end;

  setocc(tTEF_TRANSACAO, 1);
  while (xStatus >= 0) do begin
    if (item_f('TP_SITUACAO', tTEF_TRANSACAO) = 1) then begin
      putmess 'Efetivando TEF(status := 2) para ' + NR_SEQ + '.TEF_TRANSACAO';
      if (gTpTEF = 1) then begin
        viParams := '';
        putitemXml(viParams, 'CD_EMPRESA', item_f('CD_EMPRESA', tTEF_TRANSACAO));
        putitemXml(viParams, 'DT_MOVIMENTO', item_a('DT_MOVIMENTO', tTEF_TRANSACAO));
        putitemXml(viParams, 'NR_SEQ', item_f('NR_SEQ', tTEF_TRANSACAO));
        putitemXml(viParams, 'TP_SITUACAO', 2);
        newinstance 'TEFSVCO011', 'TEFSVCO011', 'TRANSACTION=TRUE';
        voParams := activateCmp('TEFSVCO011', 'alteraSituacao', viParams); (*,viParams,voParams,, *)
        if (xStatus < 0) then begin
          Result := voParams;
          return(-1); exit;
        end;
        putitem_e(tTEF_TRANSACAO, 'TP_SITUACAO', 2);
      end;
    end else if (item_f('TP_SITUACAO', tTEF_TRANSACAO) = 4) then begin
      viParams := '';
      putitemXml(viParams, 'CD_EMPRESA', item_f('CD_EMPRESA', tTEF_TRANSACAO));
      putitemXml(viParams, 'DT_MOVIMENTO', item_a('DT_MOVIMENTO', tTEF_TRANSACAO));
      putitemXml(viParams, 'NR_SEQ', item_f('NR_SEQ', tTEF_TRANSACAO));
      putitemXml(viParams, 'TP_SITUACAO', 3);
      newinstance 'TEFSVCO011', 'TEFSVCO011', 'TRANSACTION=TRUE';
      voParams := activateCmp('TEFSVCO011', 'alteraSituacao', viParams); (*,viParams,voParams,, *)
      if (xStatus < 0) then begin
        Result := voParams;
        return(-1); exit;
      end;
      putitem_e(tTEF_TRANSACAO, 'TP_SITUACAO', 3);
    end;
    setocc(tTEF_TRANSACAO, curocc(tTEF_TRANSACAO) + 1);
  end;

  setocc(tTEF_TRANSACAO, 1);
  while (xStatus >= 0) do begin
    if (item_f('TP_SITUACAO', tTEF_TRANSACAO) = 2)  or (item_f('TP_SITUACAO', tTEF_TRANSACAO) = 1 ) and (gTpTEF = 2) then begin
      putmess 'Efetivando TEF(status := 3) para ' + NR_SEQ + '.TEF_TRANSACAO';
      viParams := '';
      putitemXml(viParams, '000-000', 'CNF');
      putitemXml(viParams, '001-000', item_f('NR_DOCUMENTO', tSIS_VALOR));
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
        putitemXml(viParams, 'DS_CAMINHO', gvDsCaminho);
      end;
      voParams := activateCmp('TEFSVCO010', 'geraArquivoREQ', viParams); (*,viParams,voParams,, *)
      if (xStatus < 0) then begin
        Result := voParams;
        return(-1); exit;
      end;
        if (xStatus < 0) then begin
          Result := voParams;
          return(-1); exit;
        end;
        putitem_e(tTEF_TRANSACAO, 'TP_SITUACAO', 3);
      end else if (gTpTEF = 2) then begin
        vInLoopConfirmacao := False;
        repeat
          Result := voParams;
          voParams := setDisplay(viParams); (* 'Aguardando comunicação...', '', '' *)
          if (xStatus < 0) then begin
            Result := voParams;
            return(-1); exit;
          end;
          if (gTpTEF = 2) then begin
            putitemXml(viParams, 'DS_CAMINHO', gvDsCaminho);
          end;
          voParams := activateCmp('TEFSVCO010', 'geraArquivoREQ', viParams); (*,viParams,voParams,, *)
          if (xStatus < 0) then begin
            Result := voParams;
            return(-1); exit;
          end;
            if (xStatus < 0) then begin
              Result := voParams;
              return(-1); exit;
            end;
            putitem_e(tTEF_TRANSACAO, 'TP_SITUACAO', 3);
          end;
          voParams := setDisplay(viParams); (* ' ', '', '' *)
          if (xStatus < 0) then begin
            Result := voParams;
            return(-1); exit;
          end;
        until (vInLoopConfirmacao := True);
      end;
    end;

    setocc(tTEF_TRANSACAO, curocc(tTEF_TRANSACAO) + 1);
  end;

  return(0); exit;
end;

//----------------------------------------------------------------
function T_TRAFM066.efetivaTEFPendente(pParams : String) : String;
//----------------------------------------------------------------

var
  (* boolean piInCorrente : IN / boolean piInGeral : IN *)
  viParams, voParams, vDsLstEmpresa : String;
  vDsLstCupom, vDsRegistro, vDsConteudo, vDsMensagem, vDsAprovado : String;
  vInLoopConfirmacao, vInLoopImpressao : Boolean;
  vNrLinhaCupom, vNrSequencia : Real;
begin
  gHrInicio := gclock;
  putmess '- Inicio efetiva pendente : ' + gHrInicio' + ';

  if (empty(tTEF_TRANSACAO) = False)  and (piInCorrente = True)  and (item_f('CD_EMPRESA', tTEF_TRANSACAO) = item_f('CD_EMPFAT', tTRA_TRANSACAO)) then begin
    if (gTpTEF = 2) then begin
      sort/e(t TEF_TRANSACAO, 'TP_SITUACAO';);
    end;
    message/hint 'Aguarde. Aplicaçao TEF sendo executada.';
    setocc(tTEF_TRANSACAO, 1);
    while (xStatus >= 0) do begin
      if (item_f('TP_SITUACAO', tTEF_TRANSACAO) = 1) then begin
        voParams := efetivaTEFPendente_NCN(viParams); (* *)
        if (xStatus < 0) then begin
          Result := voParams;
          return(-1); exit;
        end;
      end else if (item_f('TP_SITUACAO', tTEF_TRANSACAO) = 2) then begin
        voParams := efetivaTEFPendente_CNF(viParams); (* *)
        if (xStatus < 0) then begin
          Result := voParams;
          return(-1); exit;
        end;
      end else if (item_f('TP_SITUACAO', tTEF_TRANSACAO) = 4)  and (gTpTEF = 2) then begin
        message/hint 'Aguarde. Aplicaçao TEF sendo executada.';
        viParams := '';
        putitemXml(viParams, '000-000', 'CNC');
        putitemXml(viParams, '001-000', item_f('NR_SEQ', tTEF_TRANSACAO));
        putitemXml(viParams, '003-000', '' + VL_TRANSACAO + '.TEF_TRANSACAO');
        putitemXml(viParams, '010-000', item_a('NM_REDETEF', tTEF_TRANSACAO));

        gNrNSU6DIG := item_f('NR_NSU', tTEF_TRANSACAO);
        gDsNSU := '' + NR_NSU + '.TEF_TRANSACAO';
        putitemXml(viParams, '012-000', item_f('NR_NSU', tTEF_TRANSACAO));

        if (item_a('NM_REDETEF', tTEF_TRANSACAO) = 'TECBAN') then begin
          putitemXml(viParams, '012-000', '' + gDsNSU[ + '1:6]');
        end;
        gDtTEF := item_a('DT_TRANSACAO', tTEF_TRANSACAO);
        putitemXml(viParams, '022-000', '' + gDtTEF') + ';
        gHrTEF := item_a('HR_TRANSACAO', tTEF_TRANSACAO);
        putitemXml(viParams, '023-000', '' + gHrTEF') + ';
        putitemXml(viParams, '999-999', '0');
        putitemXml(viParams, 'DS_EXTENSAO', '001');
        putitemXml(viParams, 'IN_P1', True);
        if (gTpTEF = 2) then begin
          putitemXml(viParams, 'DS_CAMINHO', gvDsCaminho);
        end;
        voParams := activateCmp('TEFSVCO010', 'geraArquivoREQ', viParams); (*,viParams,voParams,, *)
        if (xStatus < 0) then begin
          Result := voParams;
          return(-1); exit;
        end;
        end else if (gTpTEF = 2) then begin
          vInLoopConfirmacao := False;
          repeat
            Result := voParams;
            message/hint 'Aguardando comunicação...';
            if (gTpTEF = 2) then begin
              putitemXml(viParams, 'DS_CAMINHO', gvDsCaminho);
            end;
            voParams := activateCmp('TEFSVCO010', 'geraArquivoREQ', viParams); (*,viParams,voParams,, *)
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
          voParams := activateCmp('GERSVCO031', 'getNumSeq', viParams); (*,viParams,voParams,, *)
          if (xStatus < 0) then begin
            Result := voParams;
            return(-1); exit;
          end;
          vNrSequencia := itemXmlF('NR_SEQUENCIA', voParams);

          viParams := vDsConteudo;
          putitemXml(viParams, 'CD_EMPRESA', item_f('CD_EMPRESA', tTEF_TRANSACAO));
          putitemXml(viParams, '000-000', 'CNC');
          putitemXml(viParams, '001-000', vNrSequencia);
          putitemXml(viParams, '003-000', '' + VL_TRANSACAO + '.TEF_TRANSACAO');
          putitemXml(viParams, '010-000', item_a('NM_REDETEF', tTEF_TRANSACAO));
          putitemXml(viParams, '011-000', item_f('TP_TRANSACAO', tTEF_TRANSACAO));
          putitemXml(viParams, '012-000', itemXml('012-000', vDsConteudo));
          putitemXml(viParams, '022-000', itemXml('022-000', vDsConteudo));
          putitemXml(viParams, '023-000', itemXml('023-000', vDsConteudo));
          putitemXml(viParams, '027-000', itemXml('027-000', vDsConteudo));
          putitemXml(viParams, 'NR_NSUAUX', item_f('NR_NSU', tTEF_TRANSACAO));
          putitemXml(viParams, 'TP_SITUACAO', 1);
          newinstance 'TEFSVCO011', 'TEFSVCO011', 'TRANSACTION=TRUE';
          voParams := activateCmp('TEFSVCO011', 'gravaTransacao', viParams); (*,viParams,voParams,, *)
          if (xStatus < 0) then begin
            Result := voParams;
            return(-1); exit;
          end;
          vDsConteudo := itemXml('DS_CUPOM', voParams);
        end;
        if (vNrLinhaCupom > 0) then begin
          voParams := efetivaTEFPendente_CNC(viParams); (* vDsMensagem, vDsConteudo, vNrSequencia *)
          if (xStatus < 0) then begin
            Result := voParams;
            return(-1); exit;
          end;
        end;
      end;

      setocc(tTEF_TRANSACAO, curocc(tTEF_TRANSACAO) + 1);
    end;
  end;
  if (piInGeral = True) then begin
    clear_e(tGER_EMPRESA);
    putitem_e(tGER_EMPRESA, 'CD_GRUPOEMPRESA', item_f('CD_GRUPOEMPRESA', tTRA_TRANSACAO));
    retrieve_e(tGER_EMPRESA);
    if (xStatus >= 0) then begin
      setocc(tGER_EMPRESA, -1);
      setocc(tGER_EMPRESA, 1);
      putlistitems vDsLstEmpresa, item_f('CD_EMPRESA', tGER_EMPRESA);
    end;

    clear_e(tF_TEF_TRANSACAO);
    putitem_e(tF_TEF_TRANSACAO, 'CD_EMPRESA', vDsLstEmpresa);
    putitem_e(tF_TEF_TRANSACAO, 'CD_TERMINAL', itemXmlF('CD_TERMINAL', PARAM_GLB));
    putitem_e(tF_TEF_TRANSACAO, 'TP_SITUACAO', '1);
    retrieve_e(tF_TEF_TRANSACAO);
    if (xStatus >= 0) then begin
      if (gTpTEF = 2) then begin
        sort/e(t F_TEF_TRANSACAO, 'TP_SITUACAO';);
      end;
      setocc(tF_TEF_TRANSACAO, 1);
      while (xStatus >= 0) do begin
        creocc(tTEF_TRANSACAO, -1);
        putitem_e(tTEF_TRANSACAO, 'CD_EMPRESA', item_f('CD_EMPRESA', tF_TEF_TRANSACAO));
        putitem_e(tTEF_TRANSACAO, 'DT_MOVIMENTO', item_a('DT_MOVIMENTO', tF_TEF_TRANSACAO));
        putitem_e(tTEF_TRANSACAO, 'NR_SEQ', item_f('NR_SEQ', tF_TEF_TRANSACAO));
        retrieve_o(tTEF_TRANSACAO);
        if (xStatus = 4) then begin
        end else begin
          message/hint 'Aguarde. Aplicaçao TEF sendo executada.';
          discard 'TEF_TRANSACAO';
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
          end else if (item_f('TP_SITUACAO', tF_TEF_TRANSACAO) = 4)   and (gTpTEF = 2) then begin
            viParams := '';
            putitemXml(viParams, '000-000', 'CNC');
            putitemXml(viParams, '001-000', item_f('NR_SEQ', tF_TEF_TRANSACAO));
            putitemXml(viParams, '003-000', '' + VL_TRANSACAO + '.F_TEF_TRANSACAO');
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
            if (gTpTEF = 2) then begin
              putitemXml(viParams, 'DS_CAMINHO', gvDsCaminho);
            end;
            voParams := activateCmp('TEFSVCO010', 'geraArquivoREQ', viParams); (*,viParams,voParams,, *)
            if (xStatus < 0) then begin
              Result := voParams;
              return(-1); exit;
            end;
            end else if (gTpTEF = 2) then begin
              vInLoopConfirmacao := False;
              repeat
                Result := voParams;
                message/hint 'Aguardando comunicação...';
                if (gTpTEF = 2) then begin
                  putitemXml(viParams, 'DS_CAMINHO', gvDsCaminho);
                end;
                voParams := activateCmp('TEFSVCO010', 'geraArquivoREQ', viParams); (*,viParams,voParams,, *)
                if (xStatus < 0) then begin
                  Result := voParams;
                  return(-1); exit;
                end;
                  viParams := '';
                  viParams := vDsConteudo;
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
              voParams := activateCmp('GERSVCO031', 'getNumSeq', viParams); (*,viParams,voParams,, *)
              if (xStatus < 0) then begin
                Result := voParams;
                return(-1); exit;
              end;
              vNrSequencia := itemXmlF('NR_SEQUENCIA', voParams);

              viParams := vDsConteudo;
              putitemXml(viParams, 'CD_EMPRESA', item_f('CD_EMPRESA', tF_TEF_TRANSACAO));
              putitemXml(viParams, '000-000', 'CNC');
              putitemXml(viParams, '001-000', vNrSequencia);
              putitemXml(viParams, '003-000', '' + VL_TRANSACAO + '.F_TEF_TRANSACAO');
              putitemXml(viParams, '010-000', item_a('NM_REDETEF', tF_TEF_TRANSACAO));
              putitemXml(viParams, '011-000', itemXml('011-000', vDsConteudo));
              putitemXml(viParams, '012-000', itemXml('012-000', vDsConteudo));
              putitemXml(viParams, '022-000', itemXml('022-000', vDsConteudo));
              putitemXml(viParams, '023-000', itemXml('023-000', vDsConteudo));
              putitemXml(viParams, '027-000', itemXml('027-000', vDsConteudo));
              putitemXml(viParams, 'NR_NSUAUX', item_f('NR_NSU', tF_TEF_TRANSACAO));
              putitemXml(viParams, 'TP_SITUACAO', 1);
              newinstance 'TEFSVCO011', 'TEFSVCO011', 'TRANSACTION=TRUE';
              voParams := activateCmp('TEFSVCO011', 'gravaTransacao', viParams); (*,viParams,voParams,, *)
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
        end;
        setocc(tF_TEF_TRANSACAO, curocc(tF_TEF_TRANSACAO) + 1);
      end;
    end;
  end;
  if (piInCorrente = False ) and (piInGeral = False) then begin
    if (gTpTEF = 2) then begin
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
      if (gTpTEF = 2) then begin
        putitemXml(viParams, 'DS_CAMINHO', gvDsCaminho);
      end;
      voParams := activateCmp('TEFSVCO010', 'geraArquivoREQ', viParams); (*,viParams,voParams,, *)
      if (xStatus < 0) then begin
        Result := voParams;
        return(-1); exit;
      end;
        if (xStatus < 0) then begin
          Result := voParams;
          return(-1); exit;
        end;
        putitem_e(tTEF_TRANSACAO, 'TP_SITUACAO', 4);
      end else begin
        vInLoopConfirmacao := False;
        repeat
          Result := voParams;
          message/hint 'Aguardando comunicação...';
          if (gTpTEF = 2) then begin
            putitemXml(viParams, 'DS_CAMINHO', gvDsCaminho);
          end;
          voParams := activateCmp('TEFSVCO010', 'geraArquivoREQ', viParams); (*,viParams,voParams,, *)
          if (xStatus < 0) then begin
            Result := voParams;
            return(-1); exit;
          end;
            if (xStatus < 0) then begin
              Result := voParams;
              return(-1); exit;
            end;
            putitem_e(tTEF_TRANSACAO, 'TP_SITUACAO', 4);
          end;
          message/hint ' ';
        until (vInLoopConfirmacao := True);
      end;
    end;
  end;

  gHrFim := gclock;
  gHrTempo := gHrFim - gHrInicio;
  putmess '- Fim : efetiva pendente ' + gHrFim + ' - ' + gHrTempo' + ';

  message/hint '';

  return(0); exit;
end;

//--------------------------------------------------------------------
function T_TRAFM066.efetivaTEFPendente_MSG(pParams : String) : String;
//--------------------------------------------------------------------

var
  (* numeric vCdEmpresa : IN / numeric vNrSeq : IN / date vDtMovimento : IN / numeric vlValor : IN / string vDsRedeTef : IN / numeric vCdOperador : IN *)
  viParams, voParams, vNmLogin : String;
  vInCancelou : Boolean;
begin
  clear_e(tTEF_RELTRANSACAO);
  putitem_e(tTEF_RELTRANSACAO, 'CD_EMPTEF', vCdEmpresa);
  putitem_e(tTEF_RELTRANSACAO, 'NR_SEQ', vNrSeq);
  putitem_e(tTEF_RELTRANSACAO, 'DT_MOVIMENTO', vDtMovimento);
  retrieve_e(tTEF_RELTRANSACAO);

  if (vCdOperador > 0) then begin
    viParams := '';

    putitemXml(viParams, 'CD_USUARIO', vCdOperador);
    voParams := activateCmp('ADMSVCO027', 'validaUsuarioEspecial', viParams); (*,viParams,voParams,, *)
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

  repeat
    vInCancelou := False;
    if (item_f('NR_TRANSACAO', tTRA_TRANSACAO) <> item_f('NR_TRANSACAO', tTEF_RELTRANSACAO))  or (item_f('CD_EMPRESA', tTRA_TRANSACAO) <> item_f('CD_EMPTRA', tTEF_RELTRANSACAO)) then begin
      message/info 'Transacao ' + NR_TRANSACAO + '.TEF_RELTRANSACAO da Empresa ' + CD_EMPTRA + '.TEF_RELTRANSACAO no Valor de ' + vlValor + ' da rede ' + vDsRedeTef + ' efetuada pelo usuario ' + vNmLogin + ' esta pendente na operadora.';

    end else begin

      askmess 'Transacao ' + NR_TRANSACAO + '.TEF_RELTRANSACAO da Empresa ' + CD_EMPTRA + '.TEF_RELTRANSACAO no Valor de ' + vlValor + ' da rede ' + vDsRedeTef + ' efetuada pelo usuario ' + vNmLogin + ' esta pendente na operadora.  Deseja cancelar a transação?', 'Sim, Não';
      if (xStatus = 1) then begin
        vInCancelou := True;
      end;
    end;
    viParams := '';
    putitemXml(viParams, 'IN_USULOGADO', True);
    putitemXml(viParams, 'DS_COMPONENTE', 'TRAFM060EX');
    voParams := activateCmp('ADMFM020', 'exec', viParams); (*viParams,voParams,, *)
    if (xStatus < 0) then begin
      Result := voParams;
      return(-1); exit;
    end;
  until (xStatus >= 0);

  if (vInCancelou = False) then begin
    return(-1); exit;
  end;

  return(0); exit;
end;

//--------------------------------------------------------------------
function T_TRAFM066.efetivaTEFPendente_NCN(pParams : String) : String;
//--------------------------------------------------------------------

var
  viParams, voParams : String;
  vInLoopConfirmacao : Boolean;
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
    putitemXml(viParams, 'DS_CAMINHO', gvDsCaminho);
  end;
  voParams := activateCmp('TEFSVCO010', 'geraArquivoREQ', viParams); (*,viParams,voParams,, *)
  if (xStatus < 0) then begin
    Result := voParams;
    return(-1); exit;
  end;
      Result := SetStatus(STS_ERROR, 'GEN0001', , cDS_METHOD);
    end;
    viParams := '';
    putitemXml(viParams, 'CD_EMPRESA', item_f('CD_EMPRESA', tTEF_TRANSACAO));
    putitemXml(viParams, 'DT_MOVIMENTO', item_a('DT_MOVIMENTO', tTEF_TRANSACAO));
    putitemXml(viParams, 'NR_SEQ', item_f('NR_SEQ', tTEF_TRANSACAO));
    putitemXml(viParams, 'TP_SITUACAO', -1);
    newinstance 'TEFSVCO011', 'TEFSVCO011', 'TRANSACTION=TRUE';
    voParams := activateCmp('TEFSVCO011', 'alteraSituacao', viParams); (*,viParams,voParams,, *)
    if (xStatus < 0) then begin
      Result := voParams;
      return(-1); exit;
    end;
    if (gTpTEF = 2) then begin
      if (item_f('VL_TRANSACAO', tTEF_TRANSACAO) = 0 ) and (item_f('NR_NSU', tTEF_TRANSACAO) = 0) then begin
        Result := SetStatus(STS_ERROR, 'GEN0001', , cDS_METHOD);
      end else if (item_f('VL_TRANSACAO', tTEF_TRANSACAO) = 0 ) and (item_f('NR_NSU', tTEF_TRANSACAO) > 0) then begin
          Result := SetStatus(STS_ERROR, 'GEN0001', , cDS_METHOD);
      end else begin

          Result := SetStatus(STS_ERROR, 'GEN0001', , cDS_METHOD);
      end;
    end;
  end else if (gTpTEF = 2) then begin
    vInLoopConfirmacao := False;
    repeat
      Result := voParams;
      voParams := setDisplay(viParams); (* 'Aguardando comunicação...', '', '' *)
      if (xStatus < 0) then begin
        Result := voParams;
        return(-1); exit;
      end;
      if (gTpTEF = 2) then begin
        putitemXml(viParams, 'DS_CAMINHO', gvDsCaminho);
      end;
      voParams := activateCmp('TEFSVCO010', 'geraArquivoREQ', viParams); (*,viParams,voParams,, *)
      if (xStatus < 0) then begin
        Result := voParams;
        return(-1); exit;
      end;
        if (xStatus < 0) then begin
          Result := voParams;
          return(-1); exit;
        end;
        if (item_f('VL_TRANSACAO', tTEF_TRANSACAO) = 0 ) and (item_f('NR_NSU', tTEF_TRANSACAO) = 0) then begin
          Result := SetStatus(STS_ERROR, 'GEN0001', , cDS_METHOD);
        end else if (item_f('VL_TRANSACAO', tTEF_TRANSACAO) = 0 ) and (item_f('NR_NSU', tTEF_TRANSACAO) > 0) then begin
        end else begin

            Result := SetStatus(STS_ERROR, 'GEN0001', , cDS_METHOD);
        end;
        vInLoopConfirmacao := True;
      end;
      voParams := setDisplay(viParams); (* ' ', '', '' *)
      if (xStatus < 0) then begin
        Result := voParams;
        return(-1); exit;
      end;
    until (vInLoopConfirmacao := True);
  end;

  return(0); exit;
end;

//--------------------------------------------------------------------
function T_TRAFM066.efetivaTEFPendente_CNF(pParams : String) : String;
//--------------------------------------------------------------------

var
  viParams, voParams : String;
  vInLoopConfirmacao : Boolean;
begin
  viParams := '';
  putitemXml(viParams, '000-000', 'CNF');
  putitemXml(viParams, '001-000', item_f('NR_DOCUMENTO', tSIS_VALOR));
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
    putitemXml(viParams, 'DS_CAMINHO', gvDsCaminho);
  end;
  voParams := activateCmp('TEFSVCO010', 'geraArquivoREQ', viParams); (*,viParams,voParams,, *)
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
      Result := voParams;
      voParams := setDisplay(viParams); (* 'Aguardando comunicação...', '', '' *)
      if (xStatus < 0) then begin
        Result := voParams;
        return(-1); exit;
      end;
      if (gTpTEF = 2) then begin
        putitemXml(viParams, 'DS_CAMINHO', gvDsCaminho);
      end;
      voParams := activateCmp('TEFSVCO010', 'geraArquivoREQ', viParams); (*,viParams,voParams,, *)
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
      voParams := setDisplay(viParams); (* ' ', '', '' *)
      if (xStatus < 0) then begin
        Result := voParams;
        return(-1); exit;
      end;
    until (vInLoopConfirmacao := True);
  end;

  return(0); exit;
end;

//--------------------------------------------------------------------
function T_TRAFM066.efetivaTEFPendente_CNC(pParams : String) : String;
//--------------------------------------------------------------------

var
  (* string vDsMensagem : IN / string vDsConteudo : IN / numeric vNrSequencia : IN *)
  viParams, voParams, vDsLstEmpresa : String;
  vDsLstCupom, vDsRegistro, vDsAprovado : String;
  vInLoopConfirmacao, vInLoopImpressao : Boolean;
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
  putitemXml(viParams, 'TP_IMPRESSAOTEF', gTpImpressaoTEF);
  voParams := activateCmp('TEFFP002', 'EXEC', viParams); (*viParams,voParams,, *)
  if (xStatus < 0) then begin
    Result := voParams;
    return(-1); exit;
  end;
        clear_e(tF_TEF_TRANSACAO);
        putitem_e(tF_TEF_TRANSACAO, 'CD_EMPRESA', item_f('CD_EMPRESA', tTEF_TRANSACAO));
        putitem_e(tF_TEF_TRANSACAO, 'DT_MOVIMENTO', item_a('DT_MOVIMENTO', tTEF_TRANSACAO));
        putitem_e(tF_TEF_TRANSACAO, 'CD_ARQUIVO', 'CNC');
        putitem_e(tF_TEF_TRANSACAO, 'TP_TRANSACAO', item_f('TP_TRANSACAO', tTEF_TRANSACAO));
        putitem_e(tF_TEF_TRANSACAO, 'NR_NSUAUX', item_f('NR_NSU', tTEF_TRANSACAO));
        retrieve_e(tF_TEF_TRANSACAO);
        if (xStatus >= 0) then begin
          putitemXml(viParams, '000-000', 'NCN');
          putitemXml(viParams, '001-000', item_f('NR_SEQ', tF_TEF_TRANSACAO));
          putitemXml(viParams, '010-000', item_a('NM_REDETEF', tF_TEF_TRANSACAO));
          putitemXml(viParams, '012-000', item_f('NR_NSU', tF_TEF_TRANSACAO));
          putitemXml(viParams, '027-000', item_a('DS_FINALIZACAO', tF_TEF_TRANSACAO));
        end else begin
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
        end;
        putitemXml(viParams, '999-999', '0');
        putitemXml(viParams, 'DS_EXTENSAO', '001');
        putitemXml(viParams, 'IN_P1', False);
        if (gTpTEF = 2) then begin
          putitemXml(viParams, 'DS_CAMINHO', gvDsCaminho);
        end;
        voParams := activateCmp('TEFSVCO010', 'geraArquivoREQ', viParams); (*,viParams,voParams,, *)
        if (xStatus < 0) then begin
          Result := voParams;
          return(-1); exit;
        end;
                  Result := SetStatus(STS_ERROR, 'GEN0001', , cDS_METHOD);
              end else begin

            Result := SetStatus(STS_ERROR, 'GEN0001', , cDS_METHOD);
          end;

          clear_e(tF_TEF_TRANSACAO);
          putitem_e(tF_TEF_TRANSACAO, 'CD_EMPRESA', item_f('CD_EMPRESA', tTEF_TRANSACAO));
          putitem_e(tF_TEF_TRANSACAO, 'DT_MOVIMENTO', item_a('DT_MOVIMENTO', tTEF_TRANSACAO));
          putitem_e(tF_TEF_TRANSACAO, 'CD_ARQUIVO', 'CNC');
          putitem_e(tF_TEF_TRANSACAO, 'TP_TRANSACAO', item_f('TP_TRANSACAO', tTEF_TRANSACAO));
          putitem_e(tF_TEF_TRANSACAO, 'NR_NSUAUX', item_f('NR_NSU', tTEF_TRANSACAO));
          retrieve_e(tF_TEF_TRANSACAO);
          if (xStatus >= 0) then begin
            viParams := '';
            putitemXml(viParams, 'CD_EMPRESA', item_f('CD_EMPRESA', tF_TEF_TRANSACAO));
            putitemXml(viParams, 'DT_MOVIMENTO', item_a('DT_MOVIMENTO', tF_TEF_TRANSACAO));
            putitemXml(viParams, 'NR_SEQ', item_f('NR_SEQ', tF_TEF_TRANSACAO));
            putitemXml(viParams, 'TP_SITUACAO', -1);
            newinstance 'TEFSVCO011', 'TEFSVCO011', 'TRANSACTION=TRUE';
            voParams := activateCmp('TEFSVCO011', 'alteraSituacao', viParams); (*,viParams,voParams,, *)
            if (xStatus < 0) then begin
              Result := voParams;
              return(-1); exit;
            end;
            return(-1); exit;
          end;

          viParams := '';
          putitemXml(viParams, 'CD_EMPRESA', item_f('CD_EMPRESA', tTEF_TRANSACAO));
          putitemXml(viParams, 'DT_MOVIMENTO', item_a('DT_MOVIMENTO', tTEF_TRANSACAO));
          putitemXml(viParams, 'NR_SEQ', item_f('NR_SEQ', tTEF_TRANSACAO));
          putitemXml(viParams, 'TP_SITUACAO', -1);
          newinstance 'TEFSVCO011', 'TEFSVCO011', 'TRANSACTION=TRUE';
          voParams := activateCmp('TEFSVCO011', 'alteraSituacao', viParams); (*,viParams,voParams,, *)
          if (xStatus < 0) then begin
            Result := voParams;
            return(-1); exit;
          end;
          return(-1); exit;
        end else if (gTpTEF = 2) then begin
          vInLoopConfirmacao := False;
          repeat
            Result := voParams;
            voParams := setDisplay(viParams); (* 'Aguardando comunicação...', '', '' *)
            if (xStatus < 0) then begin
              Result := voParams;
              return(-1); exit;
            end;
            if (gTpTEF = 2) then begin
              putitemXml(viParams, 'DS_CAMINHO', gvDsCaminho);
            end;
            voParams := activateCmp('TEFSVCO010', 'geraArquivoREQ', viParams); (*,viParams,voParams,, *)
            if (xStatus < 0) then begin
              Result := voParams;
              return(-1); exit;
            end;
                  Result := SetStatus(STS_ERROR, 'GEN0001', , cDS_METHOD);
              end else begin

                  Result := SetStatus(STS_ERROR, 'GEN0001', , cDS_METHOD);
              end;

              clear_e(tF_TEF_TRANSACAO);
              putitem_e(tF_TEF_TRANSACAO, 'CD_EMPRESA', item_f('CD_EMPRESA', tTEF_TRANSACAO));
              putitem_e(tF_TEF_TRANSACAO, 'DT_MOVIMENTO', item_a('DT_MOVIMENTO', tTEF_TRANSACAO));
              putitem_e(tF_TEF_TRANSACAO, 'CD_ARQUIVO', 'CNC');
              putitem_e(tF_TEF_TRANSACAO, 'TP_TRANSACAO', item_f('TP_TRANSACAO', tTEF_TRANSACAO));
              putitem_e(tF_TEF_TRANSACAO, 'NR_NSU', item_f('NR_NSU', tTEF_TRANSACAO));
              retrieve_e(tF_TEF_TRANSACAO);
              if (xStatus >= 0) then begin
                viParams := '';
                putitemXml(viParams, 'CD_EMPRESA', item_f('CD_EMPRESA', tF_TEF_TRANSACAO));
                putitemXml(viParams, 'DT_MOVIMENTO', item_a('DT_MOVIMENTO', tF_TEF_TRANSACAO));
                putitemXml(viParams, 'NR_SEQ', item_f('NR_SEQ', tF_TEF_TRANSACAO));
                putitemXml(viParams, 'TP_SITUACAO', -1);
                newinstance 'TEFSVCO011', 'TEFSVCO011', 'TRANSACTION=TRUE';
                voParams := activateCmp('TEFSVCO011', 'alteraSituacao', viParams); (*,viParams,voParams,, *)
                if (xStatus < 0) then begin
                  Result := voParams;
                  return(-1); exit;
                end;
                return(-1); exit;
              end;

              viParams := '';
              putitemXml(viParams, 'CD_EMPRESA', item_f('CD_EMPRESA', tTEF_TRANSACAO));
              putitemXml(viParams, 'DT_MOVIMENTO', item_a('DT_MOVIMENTO', tTEF_TRANSACAO));
              putitemXml(viParams, 'NR_SEQ', item_f('NR_SEQ', tTEF_TRANSACAO));
              putitemXml(viParams, 'TP_SITUACAO', -1);
              newinstance 'TEFSVCO011', 'TEFSVCO011', 'TRANSACTION=TRUE';
              voParams := activateCmp('TEFSVCO011', 'alteraSituacao', viParams); (*,viParams,voParams,, *)
              if (xStatus < 0) then begin
                Result := voParams;
                return(-1); exit;
              end;
              return(-1); exit;
            end;
            voParams := setDisplay(viParams); (* ' ', '', '' *)
            if (xStatus < 0) then begin
              Result := voParams;
              return(-1); exit;
            end;
          until (vInLoopConfirmacao := True);
        end;
      end else begin
        viParams := '';
        putitemXml(viParams, 'DS_LSTCUPOM', vDsLstCupom);
        putitemXml(viParams, 'DS_FORMAPGTO', '');
        putitemXml(viParams, 'TP_IMPRESSAO', 2);
        putitemXml(viParams, 'TP_IMPRESSAOTEF', gTpImpressaoTEF);
        voParams := activateCmp('TEFFP002', 'EXEC', viParams); (*viParams,voParams,, *)
        if (xStatus < 0) then begin
          Result := voParams;
          return(-1); exit;
        end;
        if (xStatus >= 0) then begin
          viParams := '';

          clear_e(tF_TEF_TRANSACAO);
          putitem_e(tF_TEF_TRANSACAO, 'CD_EMPRESA', item_f('CD_EMPRESA', tTEF_TRANSACAO));
          putitem_e(tF_TEF_TRANSACAO, 'DT_MOVIMENTO', item_a('DT_MOVIMENTO', tTEF_TRANSACAO));
          putitem_e(tF_TEF_TRANSACAO, 'CD_ARQUIVO', 'CNC');
          putitem_e(tF_TEF_TRANSACAO, 'TP_TRANSACAO', item_f('TP_TRANSACAO', tTEF_TRANSACAO));
          putitem_e(tF_TEF_TRANSACAO, 'NR_NSUAUX', item_f('NR_NSU', tTEF_TRANSACAO));
          retrieve_e(tF_TEF_TRANSACAO);
          if (xStatus >= 0) then begin
            putitemXml(viParams, '000-000', 'CNF');
            putitemXml(viParams, '001-000', vNrSequencia);
            putitemXml(viParams, '010-000', item_a('NM_REDETEF', tF_TEF_TRANSACAO));
            putitemXml(viParams, '012-000', item_f('NR_NSU', tF_TEF_TRANSACAO));
            putitemXml(viParams, '027-000', item_a('DS_FINALIZACAO', tF_TEF_TRANSACAO));
          end else begin

            putitemXml(viParams, '000-000', 'CNF');
            putitemXml(viParams, '001-000', vNrSequencia);
            putitemXml(viParams, '010-000', item_a('NM_REDETEF', tTEF_TRANSACAO));

            gNrNSU6DIG := item_f('NR_NSU', tTEF_TRANSACAO);
            gDsNSU := '' + NR_NSU + '.TEF_TRANSACAO';
            putitemXml(viParams, '012-000', item_f('NR_NSU', tTEF_TRANSACAO));

            if (item_a('NM_REDETEF', tTEF_TRANSACAO) = 'TECBAN') then begin
              putitemXml(viParams, '012-000', '' + gDsNSU[ + '1:6]');
            end;
            putitemXml(viParams, '027-000', item_a('DS_FINALIZACAO', tTEF_TRANSACAO));
          end;

          putitemXml(viParams, '999-999', '0');
          putitemXml(viParams, 'DS_EXTENSAO', '001');
          putitemXml(viParams, 'IN_P1', False);
          if (gTpTEF = 2) then begin
            putitemXml(viParams, 'DS_CAMINHO', gvDsCaminho);
          end;
          voParams := activateCmp('TEFSVCO010', 'geraArquivoREQ', viParams); (*,viParams,voParams,, *)
          if (xStatus < 0) then begin
            Result := voParams;
            return(-1); exit;
          end;
              if (xStatus < 0) then begin
                Result := voParams;
                return(-1); exit;
              end;
              if (gTpTEF = 2) then begin
                putitemXml(viParams, 'DS_CAMINHO', gvDsCaminho);
              end;
              voParams := activateCmp('TEFSVCO010', 'geraArquivoREQ', viParams); (*,viParams,voParams,, *)
              if (xStatus < 0) then begin
                Result := voParams;
                return(-1); exit;
              end;
              voParams := setDisplay(viParams); (* ' ', '', '' *)
              if (xStatus < 0) then begin
                Result := voParams;
                return(-1); exit;
              end;
            until (vInLoopConfirmacao := True);
          end;

          viParams := '';
          putitemXml(viParams, 'CD_EMPRESA', item_f('CD_EMPRESA', tTEF_TRANSACAO));
          putitemXml(viParams, 'DT_MOVIMENTO', item_a('DT_MOVIMENTO', tTEF_TRANSACAO));
          putitemXml(viParams, 'NR_SEQ', vNrSequencia);
          putitemXml(viParams, 'TP_SITUACAO', 3);
          newinstance 'TEFSVCO011', 'TEFSVCO011', 'TRANSACTION=TRUE';
          voParams := activateCmp('TEFSVCO011', 'alteraSituacao', viParams); (*,viParams,voParams,, *)
          if (xStatus < 0) then begin
            Result := voParams;
            return(-1); exit;
          end;

          clear_e(tF_TEF_TRANSACAO);
          putitem_e(tF_TEF_TRANSACAO, 'CD_EMPRESA', item_f('CD_EMPRESA', tTEF_TRANSACAO));
          putitem_e(tF_TEF_TRANSACAO, 'DT_MOVIMENTO', item_a('DT_MOVIMENTO', tTEF_TRANSACAO));
          putitem_e(tF_TEF_TRANSACAO, 'CD_ARQUIVO', 'CRT');
          putitem_e(tF_TEF_TRANSACAO, 'TP_TRANSACAO', item_f('TP_TRANSACAO', tTEF_TRANSACAO));
          putitem_e(tF_TEF_TRANSACAO, 'NR_NSU', item_f('NR_NSU', tTEF_TRANSACAO));
          retrieve_e(tF_TEF_TRANSACAO);

          viParams := '';
          putitemXml(viParams, 'CD_EMPRESA', item_f('CD_EMPRESA', tF_TEF_TRANSACAO));
          putitemXml(viParams, 'DT_MOVIMENTO', item_a('DT_MOVIMENTO', tF_TEF_TRANSACAO));
          putitemXml(viParams, 'NR_SEQ', item_f('NR_SEQ', tF_TEF_TRANSACAO));
          putitemXml(viParams, 'TP_SITUACAO', -1);
          newinstance 'TEFSVCO011', 'TEFSVCO011', 'TRANSACTION=TRUE';
          voParams := activateCmp('TEFSVCO011', 'alteraSituacao', viParams); (*,viParams,voParams,, *)
          if (xStatus < 0) then begin
            Result := voParams;
            return(-1); exit;
          end;
          vInLoopImpressao := False;
        end;
      end;
    until (vInLoopImpressao := False);
  end else begin
    viParams := '';

    clear_e(tF_TEF_TRANSACAO);
    putitem_e(tF_TEF_TRANSACAO, 'CD_EMPRESA', item_f('CD_EMPRESA', tTEF_TRANSACAO));
    putitem_e(tF_TEF_TRANSACAO, 'DT_MOVIMENTO', item_a('DT_MOVIMENTO', tTEF_TRANSACAO));
    putitem_e(tF_TEF_TRANSACAO, 'CD_ARQUIVO', 'CNC');
    putitem_e(tF_TEF_TRANSACAO, 'TP_TRANSACAO', item_f('TP_TRANSACAO', tTEF_TRANSACAO));
    putitem_e(tF_TEF_TRANSACAO, 'NR_NSUAUX', item_f('NR_NSU', tTEF_TRANSACAO));
    retrieve_e(tF_TEF_TRANSACAO);
    if (xStatus >= 0) then begin
      putitemXml(viParams, '000-000', 'CNF');
      putitemXml(viParams, '001-000', vNrSequencia);
      putitemXml(viParams, '010-000', item_a('NM_REDETEF', tF_TEF_TRANSACAO));
      putitemXml(viParams, '012-000', item_f('NR_NSU', tF_TEF_TRANSACAO));
      putitemXml(viParams, '027-000', item_a('DS_FINALIZACAO', tF_TEF_TRANSACAO));
    end else begin

      putitemXml(viParams, '000-000', 'CNF');
      putitemXml(viParams, '001-000', vNrSequencia);
      putitemXml(viParams, '010-000', item_a('NM_REDETEF', tTEF_TRANSACAO));

      gNrNSU6DIG := item_f('NR_NSU', tTEF_TRANSACAO);
      putitemXml(viParams, '012-000', item_f('NR_NSU', tTEF_TRANSACAO));
      putitemXml(viParams, '027-000', item_a('DS_FINALIZACAO', tTEF_TRANSACAO));
    end;
    putitemXml(viParams, '999-999', '0');
    putitemXml(viParams, 'DS_EXTENSAO', '001');
    putitemXml(viParams, 'IN_P1', False);
    if (gTpTEF = 2) then begin
      putitemXml(viParams, 'DS_CAMINHO', gvDsCaminho);
    end;
    voParams := activateCmp('TEFSVCO010', 'geraArquivoREQ', viParams); (*,viParams,voParams,, *)
    if (xStatus < 0) then begin
      Result := voParams;
      return(-1); exit;
    end;
        if (xStatus < 0) then begin
          Result := voParams;
          return(-1); exit;
        end;
        if (gTpTEF = 2) then begin
          putitemXml(viParams, 'DS_CAMINHO', gvDsCaminho);
        end;
        voParams := activateCmp('TEFSVCO010', 'geraArquivoREQ', viParams); (*,viParams,voParams,, *)
        if (xStatus < 0) then begin
          Result := voParams;
          return(-1); exit;
        end;
        voParams := setDisplay(viParams); (* ' ', '', '' *)
        if (xStatus < 0) then begin
          Result := voParams;
          return(-1); exit;
        end;
      until (vInLoopConfirmacao := True);
    end;

    viParams := '';
    putitemXml(viParams, 'CD_EMPRESA', item_f('CD_EMPRESA', tTEF_TRANSACAO));
    putitemXml(viParams, 'DT_MOVIMENTO', item_a('DT_MOVIMENTO', tTEF_TRANSACAO));
    putitemXml(viParams, 'NR_SEQ', vNrSequencia);
    putitemXml(viParams, 'TP_SITUACAO', 3);
    newinstance 'TEFSVCO011', 'TEFSVCO011', 'TRANSACTION=TRUE';
    voParams := activateCmp('TEFSVCO011', 'alteraSituacao', viParams); (*,viParams,voParams,, *)
    if (xStatus < 0) then begin
      Result := voParams;
      return(-1); exit;
    end;

    clear_e(tF_TEF_TRANSACAO);
    putitem_e(tF_TEF_TRANSACAO, 'CD_EMPRESA', item_f('CD_EMPRESA', tTEF_TRANSACAO));
    putitem_e(tF_TEF_TRANSACAO, 'DT_MOVIMENTO', item_a('DT_MOVIMENTO', tTEF_TRANSACAO));
    putitem_e(tF_TEF_TRANSACAO, 'CD_ARQUIVO', 'CRT');
    putitem_e(tF_TEF_TRANSACAO, 'TP_TRANSACAO', item_f('TP_TRANSACAO', tTEF_TRANSACAO));
    putitem_e(tF_TEF_TRANSACAO, 'NR_NSU', item_f('NR_NSU', tTEF_TRANSACAO));
    retrieve_e(tF_TEF_TRANSACAO);

    viParams := '';
    viParams := vDsConteudo;
    putitemXml(viParams, 'CD_EMPRESA', item_f('CD_EMPRESA', tF_TEF_TRANSACAO));
    putitemXml(viParams, 'DT_MOVIMENTO', item_a('DT_MOVIMENTO', tF_TEF_TRANSACAO));
    putitemXml(viParams, 'NR_SEQ', item_f('NR_SEQ', tF_TEF_TRANSACAO));
    putitemXml(viParams, 'TP_SITUACAO', -1);
    newinstance 'TEFSVCO011', 'TEFSVCO011', 'TRANSACTION=TRUE';
    voParams := activateCmp('TEFSVCO011', 'alteraSituacao', viParams); (*,viParams,voParams,, *)
    if (xStatus < 0) then begin
      Result := voParams;
      return(-1); exit;
    end;
  end;

  return(0); exit;
end;

//-------------------------------------------------------------------------
function T_TRAFM066.efetivaTEFPendenteGeral_NCN(pParams : String) : String;
//-------------------------------------------------------------------------

var
  viParams, voParams : String;
  vInLoopConfirmacao, vInLoopImpressao : Boolean;
begin
  viParams := '';
  putitemXml(viParams, 'NM_ENTIDADE', 'TEF_TRANSACAO');
  putitemXml(viParams, 'NM_ATRIBUTO', 'NR_TRANSACAO');
  voParams := activateCmp('GERSVCO031', 'getNumSeq', viParams); (*,viParams,voParams,, *)
  if (xStatus < 0) then begin
    Result := voParams;
    return(-1); exit;
  end;
  gvNrTransacao := itemXmlF('NR_SEQUENCIA', voParams);

  viParams := '';
  putitemXml(viParams, '000-000', 'NCN');
  putitemXml(viParams, '001-000', gvNrTransacao);
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
  if (gTpTEF = 2) then begin
    putitemXml(viParams, 'DS_CAMINHO', gvDsCaminho);
  end;
  voParams := activateCmp('TEFSVCO010', 'geraArquivoREQ', viParams); (*,viParams,voParams,, *)
  if (xStatus < 0) then begin
    Result := voParams;
    return(-1); exit;
  end;
    if (xStatus < 0) then begin
      Result := voParams;
      return(-1); exit;
    end;
    if (item_f('VL_TRANSACAO', tF_TEF_TRANSACAO) = 0 ) and (item_f('NR_NSU', tF_TEF_TRANSACAO) = 0) then begin
      Result := SetStatus(STS_ERROR, 'GEN0001', , cDS_METHOD);
    end else if (item_f('VL_TRANSACAO', tF_TEF_TRANSACAO) = 0 ) and (item_f('NR_NSU', tF_TEF_TRANSACAO) > 0) then begin
      Result := SetStatus(STS_ERROR, 'GEN0001', , cDS_METHOD);
    end else begin
      if (gTpTEF = 1) then begin
        Result := SetStatus(STS_ERROR, 'GEN0001', , cDS_METHOD);
      end else begin
        Result := SetStatus(STS_ERROR, 'GEN0001', , cDS_METHOD);
      end;
    end;
  end else if (gTpTEF = 2) then begin
    vInLoopConfirmacao := False;
    repeat
      Result := voParams;
      message/hint 'Aguardando comunicação...';
      if (gTpTEF = 2) then begin
        putitemXml(viParams, 'DS_CAMINHO', gvDsCaminho);
      end;
      voParams := activateCmp('TEFSVCO010', 'geraArquivoREQ', viParams); (*,viParams,voParams,, *)
      if (xStatus < 0) then begin
        Result := voParams;
        return(-1); exit;
      end;
        if (xStatus < 0) then begin
          Result := voParams;
          return(-1); exit;
        end;
        if (item_f('VL_TRANSACAO', tF_TEF_TRANSACAO) = 0 ) and (item_f('NR_NSU', tF_TEF_TRANSACAO) = 0) then begin
          Result := SetStatus(STS_ERROR, 'GEN0001', , cDS_METHOD);
        end else if (item_f('VL_TRANSACAO', tF_TEF_TRANSACAO) = 0 ) and (item_f('NR_NSU', tF_TEF_TRANSACAO) > 0) then begin
          Result := SetStatus(STS_ERROR, 'GEN0001', , cDS_METHOD);
        end else begin
          Result := SetStatus(STS_ERROR, 'GEN0001', , cDS_METHOD);
        end;
        vInLoopConfirmacao := True;
      end;
      message/hint ' ';
    until (vInLoopConfirmacao := True);
  end else if (xStatus < 0) then begin
    Result := voParams;
  end;

  return(0); exit;

end;

//-------------------------------------------------------------------------
function T_TRAFM066.efetivaTEFPendenteGeral_CNF(pParams : String) : String;
//-------------------------------------------------------------------------

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
  if (gTpTEF = 2) then begin
    putitemXml(viParams, 'DS_CAMINHO', gvDsCaminho);
  end;
  voParams := activateCmp('TEFSVCO010', 'geraArquivoREQ', viParams); (*,viParams,voParams,, *)
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
      Result := voParams;
      message/hint 'Aguardando comunicação...';
      if (gTpTEF = 2) then begin
        putitemXml(viParams, 'DS_CAMINHO', gvDsCaminho);
      end;
      voParams := activateCmp('TEFSVCO010', 'geraArquivoREQ', viParams); (*,viParams,voParams,, *)
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

//-------------------------------------------------------------------------
function T_TRAFM066.efetivaTEFPendenteGeral_CNC(pParams : String) : String;
//-------------------------------------------------------------------------

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
  voParams := activateCmp('TEFFP002', 'EXEC', viParams); (*viParams,voParams,, *)
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
        if (gTpTEF = 2) then begin
          putitemXml(viParams, 'DS_CAMINHO', gvDsCaminho);
        end;
        voParams := activateCmp('TEFSVCO010', 'geraArquivoREQ', viParams); (*,viParams,voParams,, *)
        if (xStatus < 0) then begin
          Result := voParams;
          return(-1); exit;
        end;
      end else if (gTpTEF = 2) then begin
        vInLoopConfirmacao := False;
        repeat
          Result := voParams;
          message/hint 'Aguardando comunicação...';
          if (gTpTEF = 2) then begin
            putitemXml(viParams, 'DS_CAMINHO', gvDsCaminho);
          end;
          voParams := activateCmp('TEFSVCO010', 'geraArquivoREQ', viParams); (*,viParams,voParams,, *)
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
        voParams := activateCmp('TEFFP002', 'EXEC', viParams); (*viParams,voParams,, *)
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
          if (gTpTEF = 2) then begin
            putitemXml(viParams, 'DS_CAMINHO', gvDsCaminho);
          end;
          voParams := activateCmp('TEFSVCO010', 'geraArquivoREQ', viParams); (*,viParams,voParams,, *)
          if (xStatus < 0) then begin
            Result := voParams;
            return(-1); exit;
          end;
              voParams := activateCmp('TEFSVCO010', 'geraArquivoREQ', viParams); (*,viParams,voParams,, *)
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
          voParams := activateCmp('TEFSVCO011', 'alteraSituacao', viParams); (*,viParams,voParams,, *)
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
          voParams := activateCmp('TEFSVCO011', 'alteraSituacao', viParams); (*,viParams,voParams,, *)
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
    if (gTpTEF = 2) then begin
      putitemXml(viParams, 'DS_CAMINHO', gvDsCaminho);
    end;
    voParams := activateCmp('TEFSVCO010', 'geraArquivoREQ', viParams); (*,viParams,voParams,, *)
    if (xStatus < 0) then begin
      Result := voParams;
      return(-1); exit;
    end;
        voParams := activateCmp('TEFSVCO010', 'geraArquivoREQ', viParams); (*,viParams,voParams,, *)
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
    voParams := activateCmp('TEFSVCO011', 'alteraSituacao', viParams); (*,viParams,voParams,, *)
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
    voParams := activateCmp('TEFSVCO011', 'alteraSituacao', viParams); (*,viParams,voParams,, *)
    if (xStatus < 0) then begin
      Result := voParams;
      return(-1); exit;
    end;
    clear_e(tTEF_TRANSACAO);
  end;

  return(0); exit;

end;

//--------------------------------------------------------------
function T_TRAFM066.gravaRecebimento(pParams : String) : String;
//--------------------------------------------------------------

var
  vDtSistema, vDtMovim, vDtTransacao, vDtVencimento : TDate;
  viParams, voParams, vDsLstParamCC, vDsRegFormaPgto, vDsIndice, vDsFiltro : String;
  vDsCheque, vDsRegistro, vDsLstFatura, vDsLstCartao, vDsObs, vDsLstFaturaImp, vDsLstLiqMov : String;
  vDsLstFormaPgto, vDsLstComissao, vDsLstNF, vDsLstMovCC, vDsFormaPgto, vLstTransacao : String;
  vDsClas, vDsLstClas, vDsLstFatura2, vDsLstSeguro, vDsLstNaoSeguro : String;
  vDsLstComisGuia, vDsLstComisRepre, vDsLstTransacao, vDsLstClassificacao, vDsLstCheque, vDsLstMovimento : String;
  vCdEmpresa, vCdCliente, vNrFatura, vCdOperador, vNrFatTroco, vVlDesconto, vPrDescBonific, vNrSequencia : Real;
  vTpFaturamento, vTpCobranca, vNrSeqTotTEF, vNrTransacao, vNrParcela : Real;
  vNrDOFNI, vNrCtaPes, vNrSeqMov, vNrSeqTEF, vNrStatus, vPrDescPontual, vPrDescBonificm, vTpCobrancaVd : Real;
  vVlBonus, vTpBonus, vCdDescAbatiPed, vPrDescAbatiPed, vCdAbatiPed, vCdMotivoAbat, vVlAbatimento : Real;
  vInErro, vInCobLoja, vInFatura, vInImpressaoOK, vInAgRecebimento, vInCheque, vInConcomitante : Boolean;
begin
  if (item_f('TP_DOCTO', tGER_OPERACAO) = 3) then begin
    vInConcomitante := True;
  end else begin
    vInConcomitante := False;
  end;

  vCdDescAbatiPed := itemXmlF('CD_TIPODES_ABATIMENTO_PED', xParamEmp);
  vCdAbatiPed := itemXmlF('CD_TIPO_ABATIMENTO_PED', xParamEmp);
  vCdMotivoAbat := itemXmlF('CD_MOTIVO_ABATI_PED', xParamEmp);

  if not (empty(tTRA_TRANSACAO)) then begin
    setocc(tTRA_TRANSACAO, 1);
    while (xStatus >= 0) do begin
      vDsRegistro := '';
      putitemXml(vDsRegistro, 'CD_EMPTRANSACAO', item_f('CD_EMPRESA', tTRA_TRANSACAO));
      putitemXml(vDsRegistro, 'CD_EMPRESA', item_f('CD_EMPRESA', tTRA_TRANSACAO));
      putitemXml(vDsRegistro, 'DT_TRANSACAO', item_a('DT_TRANSACAO', tTRA_TRANSACAO));
      putitemXml(vDsRegistro, 'NR_TRANSACAO', item_f('NR_TRANSACAO', tTRA_TRANSACAO));
      putitem(vLstTransacao,  vDsRegistro);

      setocc(tTRA_TRANSACAO, curocc(tTRA_TRANSACAO) + 1);
    end;
    setocc(tTRA_TRANSACAO, 1);
  end;

  viParams := '';
  putitemXml(viParams, 'DS_LSTTRANSACAO', vLstTransacao);
  voParams := activateCmp('TRASVCO019', 'lockTransacao', viParams); (*,viParams,voParams,, *)
  if (xStatus < 0) then begin
    Result := voParams;
    return(-1); exit;
  end;

  vDtSistema := itemXml('DT_SISTEMA', PARAM_GLB);
  vCdOperador := itemXmlF('CD_USUARIO', PARAM_GLB);
  vDsLstFatura := '';
  vDsLstFatura2 := '';
  vDsLstFaturaImp := '';
  vDsLstMovCC := '';
  vDsLstClassificacao := '';
  vTpCobrancaVd := itemXmlF('TP_COBRANCA_VD', xParamEmp);
  vNrSequencia := 100;
  vVlAbatimento := 0;

  if (item_f('QT_PRAZOMEDIO', tSIS_TOTAL) > 0) then begin
    vTpFaturamento := 2;
  end else begin
    vTpFaturamento := 1;
  end;
  if (item_f('VL_TROCO', tSIS_DUMMY3) > 0) then begin
    viParams := '';
    putitemXml(viParams, 'NM_ENTIDADE', 'FCR_FATURAI');
    voParams := activateCmp('GERSVCO031', 'getNumSeq', viParams); (*,viParams,voParams,, *)
    if (xStatus < 0) then begin
      Result := voParams;
      return(-1); exit;
    end;

    vNrFatTroco := itemXmlF('NR_SEQUENCIA', voParams);

    creocc(tSIS_VALOR, 1);
    putitem_e(tSIS_VALOR, 'NR_DOCUMENTO', vNrFatTroco);
    putitem_e(tSIS_VALOR, 'VL_DOCUMENTO', item_f('VL_TROCO', tSIS_DUMMY3));
    putitem_e(tSIS_VALOR, 'TP_DOCUMENTO', 9);
    putitem_e(tSIS_VALOR, 'DT_VENCIMENTO', vDtSistema);
  end;
  if (gInECF = True) then begin
    if (gNrCupom = 0) then begin
      if (gInCupomAberto = False) then begin
        viParams := '';
        putitemXml(viParams, 'CD_EMPRESA', item_f('CD_EMPRESA', tTRA_TRANSACAO));
        putitemXml(viParams, 'NR_TRANSACAO', item_f('NR_TRANSACAO', tTRA_TRANSACAO));
        putitemXml(viParams, 'DT_TRANSACAO', item_a('DT_TRANSACAO', tTRA_TRANSACAO));
        voParams := activateCmp('ECFSVCO010', 'iniciaCupom', viParams); (*,viParams,voParams,, *)
        if (xStatus < 0) then begin
          Result := voParams;
          return(-1); exit;
        end;
          putitemXml(viParams, 'TITULO', 'Erro de comunicação com a ECF');
          putitemXml(viParams, 'MENSAGEM', itemXml('DESCRICAO', xCtxErro));
          voParams := activateCmp('GERFP008', 'EXEC', viParams); (*viParams,voParams,, *)
          if (xStatus < 0) then begin
            Result := voParams;
            return(-1); exit;
          end;
          return(-2);
        end else if (xStatus < 0) then begin
          Result := voParams;
          return(-2);
        end;
        gCdEmpECF := itemXmlF('CD_EMPECF', voParams);
        gNrECF := itemXmlF('NR_ECF', voParams);
        gNrCupom := itemXmlF('NR_CUPOM', voParams);

        setocc(tSIS_VALOR, 1);
        while (xStatus >= 0) do begin
          if (item_f('TP_DOCUMENTO', tSIS_VALOR) = 7)  or (gTpTEF = 2 ) and (item_f('TP_DOCUMENTO', tSIS_VALOR) = 8) then begin
            gInTEF := True;
            break;
          end;
          setocc(tSIS_VALOR, curocc(tSIS_VALOR) + 1);
        end;

        viParams := '';
        putitemXml(viParams, 'CD_EMPRESA', item_f('CD_EMPRESA', tTRA_TRANSACAO));
        putitemXml(viParams, 'NR_TRANSACAO', item_f('NR_TRANSACAO', tTRA_TRANSACAO));
        putitemXml(viParams, 'DT_TRANSACAO', item_a('DT_TRANSACAO', tTRA_TRANSACAO));
        putitemXml(viParams, 'IN_TEF', gInTEF);
        voParams := activateCmp('ECFSVCO010', 'lancaItemCupom', viParams); (*,viParams,voParams,, *)
        if (xStatus < 0) then begin
          Result := voParams;
          return(-1); exit;
        end;
          putitemXml(viParams, 'TITULO', 'Erro de comunicação com a ECF');
          putitemXml(viParams, 'MENSAGEM', itemXml('DESCRICAO', xCtxErro));
          voParams := activateCmp('GERFP008', 'EXEC', viParams); (*viParams,voParams,, *)
          if (xStatus < 0) then begin
            Result := voParams;
            return(-1); exit;
          end;
          return(-2);
        end else if (xStatus < 0) then begin
          Result := voParams;
          return(-2);
        end;
        gInCupomAberto := True;
        if (gInTEF = True)  and (gNrCupom = 0) then begin
          gNrCupom := itemXmlF('NR_CUPOM', voParams);
        end;
        if (gCdEmpECF = '')  or (gNrECF = '') then begin
          gCdEmpECF := itemXmlF('CD_EMPECF', voParams);
          gNrECF := itemXmlF('NR_ECF', voParams);
        end;
      end else begin
        viParams := '';
        voParams := activateCmp('ECFSVCO001', 'abreGaveta', viParams); (*viParams,voParams,, *)
        if (xStatus < 0) then begin
          Result := voParams;
          return(-1); exit;
        end;
      end;
    end;
  end;
  if (gInTEF = '') then begin
    gInTEF := False;
  end;
  vNrSeqTEF := 0;
  vNrSeqTotTEF := 0;

  setocc(tSIS_VALOR, 1);
  while (xStatus >= 0) do begin
    if (item_f('TP_DOCUMENTO', tSIS_VALOR) = 7)  or (gTpTEF = 2 ) and (item_f('TP_DOCUMENTO', tSIS_VALOR) = 8)  or (item_f('TP_DOCUMENTO', tSIS_VALOR) = 19)  or (item_f('TP_DOCUMENTO', tSIS_VALOR) = 22) then begin
      vNrSeqTotTEF := vNrSeqTotTEF + 1;
    end;
    setocc(tSIS_VALOR, curocc(tSIS_VALOR) + 1);
  end;

  setocc(tSIS_VALOR, 1);
  while (xStatus >= 0) do begin
    if (item_f('TP_DOCUMENTO', tSIS_VALOR) = 7)  or (item_f('TP_DOCUMENTO', tSIS_VALOR) = 17)  or (item_f('TP_DOCUMENTO', tSIS_VALOR) = 19)  or (item_f('TP_DOCUMENTO', tSIS_VALOR) = 22)  or (gTpTEF = 2 ) and (item_f('TP_DOCUMENTO', tSIS_VALOR) = 8) then begin
      vNrSeqTEF := vNrSeqTEF + 1;
      voParams := lancaTEF(viParams); (* vNrSeqTEF *)
      if (xStatus < 0) then begin
        vNrStatus := xStatus;
        return(vNrStatus);
      end;
      if (vNrSeqTEF = 1 ) and (gTpTEF = 1) then begin
        voParams := efetivaTEFPendente(viParams); (* False, True *)
        if (xStatus < 0) then begin
          Result := voParams;
          return(-1); exit;
        end;
      end else if (gTpTEF = 2) then begin
        if (vNrSeqTotTEF > 1 ) and (vNrSeqTEF < vNrSeqTotTEF) then begin
          voParams := efetivaTEFPendente(viParams); (* False, False *)
          if (xStatus < 0) then begin
            Result := voParams;
            return(-1); exit;
          end;
        end;
      end;
      gInTEF := True;
    end else begin
      setocc(tSIS_VALOR, curocc(tSIS_VALOR) + 1);
    end;
  end;

  vTpCobranca := '';
  vPrDescPontual := 0;
  vPrDescBonific := 0;

  clear_e(tPED_PEDIDOTRA);
  putitem_e(tPED_PEDIDOTRA, 'CD_EMPTRANSACAO', item_f('CD_EMPRESA', tTRA_TRANSACAO));
  putitem_e(tPED_PEDIDOTRA, 'NR_TRANSACAO', item_f('NR_TRANSACAO', tTRA_TRANSACAO));
  putitem_e(tPED_PEDIDOTRA, 'DT_TRANSACAO', item_a('DT_TRANSACAO', tTRA_TRANSACAO));
  retrieve_e(tPED_PEDIDOTRA);
  if (xStatus >= 0) then begin
    if (item_f('CD_EMPFAT', tTRA_TRANSACAO) = itemXmlF('CD_EMPRESA', PARAM_GLB)) then begin
      if (item_f('TP_COBRANCA', tPED_PEDIDOC) <> '') then begin
        vTpCobranca := item_f('TP_COBRANCA', tPED_PEDIDOC);
      end;
    end else begin
      if (item_f('TP_COBRANCAPADRAO', tPED_PEDIDOC) <> '') then begin
        vTpCobranca := item_f('TP_COBRANCAPADRAO', tPED_PEDIDOC);
      end else if (item_f('TP_COBRANCA', tPED_PEDIDOC) <> '') then begin
        vTpCobranca := item_f('TP_COBRANCA', tPED_PEDIDOC);
      end;
    end;
    if (gprDescPontualPed > 0) then begin
      clear_e(tPED_PEDTIPODESC);
      putitem_e(tPED_PEDTIPODESC, 'CD_TIPODESC', gprDescPontualPed);
      retrieve_e(tPED_PEDTIPODESC);
      if (xStatus >= 0) then begin
        vPrDescPontual := item_f('PR_DESCONTO', tPED_PEDTIPODESC);
      end;
    end;
    if (gprDescBonificPed > 0) then begin
      clear_e(tPED_PEDTIPODESC);
      putitem_e(tPED_PEDTIPODESC, 'CD_TIPODESC', gprDescBonificPed);
      retrieve_e(tPED_PEDTIPODESC);
      if (xStatus >= 0) then begin
        vPrDescBonific := item_f('PR_DESCONTO', tPED_PEDTIPODESC);
      end;
    end;
    if (vCdDescAbatiPed > 0) then begin
      clear_e(tPED_PEDTIPODESC);
      putitem_e(tPED_PEDTIPODESC, 'CD_TIPODESC', vCdDescAbatiPed);
      retrieve_e(tPED_PEDTIPODESC);
      if (xStatus >= 0) then begin
        vPrDescAbatiPed := item_f('PR_DESCONTO', tPED_PEDTIPODESC);
      end;
    end;

    viParams := '';
    putitemXml(viParams, 'CD_EMPRESA', item_f('CD_EMPRESA', tPED_PEDIDOC));
    putitemXml(viParams, 'CD_PEDIDO', item_f('CD_PEDIDO', tPED_PEDIDOC));
    voParams := activateCmp('TRASVCO016', 'buscaRelacClasPedidoFatura', viParams); (*,viParams,voParams,, *)
    if (xStatus < 0) then begin
      Result := voParams;
      return(-1); exit;
    end;

    vDsLstClassificacao := itemXml('DS_LSTCLASSIFICACAO', voParams);
  end else begin
    viParams := '';
    putitemXml(viParams, 'CD_CLIENTE', gCdPessoa);
    voParams := activateCmp('PESSVCO011', 'buscaPreferenciaCliente', viParams); (*,viParams,voParams,, *)
    if (xStatus < 0) then begin
      Result := voParams;
      return(-1); exit;
    end;

    vTpCobranca := itemXmlF('TP_COBRANCA', voParams);
  end;
  if (vTpCobranca = '') then begin
    vTpCobranca := vTpCobrancaVd;

    if (vTpCobranca = '') then begin
      vTpCobranca := 0;
    end;
  end;
  if (gCdEmpContrato > 0)  and (gNrSeqContrato > 0)  and (gNrSeqItemContrato > 0) then begin
    viParams := '';
    putitemXml(viParams, 'CD_EMPCONTRATO', gCdEmpContrato);
    putitemXml(viParams, 'NR_SEQCONTRATO', gNrSeqContrato);
    putitemXml(viParams, 'NR_SEQITEM', gNrSeqItemContrato);
    putitemXml(viParams, 'CD_EMPTRANSACAO', item_f('CD_EMPRESA', tTRA_TRANSACAO));
    putitemXml(viParams, 'NR_TRANSACAO', item_f('NR_TRANSACAO', tTRA_TRANSACAO));
    putitemXml(viParams, 'DT_TRANSACAO', item_a('DT_TRANSACAO', tTRA_TRANSACAO));
    voParams := activateCmp('IMBSVCO003', 'buscaClassificaoFatura', viParams); (*,viParams,voParams,, *)
    if (xStatus < 0) then begin
      Result := voParams;
      return(-1); exit;
    end;
    vDsLstClassificacao := itemXml('DS_LSTCLASSIFICACAO', voParams);
  end;

  clear_e(tTMP_K02NR10);
  vDsLstParamCC := '';
  vDsLstLiqMov := '';

  vDsLstSeguro := '';
  vDsLstNaoSeguro := '';

  setocc(tSIS_VALOR, 1);
  while (xStatus >= 0) do begin
    vDsCheque := '';
    viParams := '';

    if (item_f('TP_DOCUMENTO', tSIS_VALOR) <> 0) then begin
      clear_e(tFCR_FATURAI);
      putitem_e(tFCR_FATURAI, 'CD_EMPRESA', item_f('CD_EMPFAT', tTRA_TRANSACAO));
      putitem_e(tFCR_FATURAI, 'CD_CLIENTE', gCdPessoa);
      putitem_e(tFCR_FATURAI, 'NR_FAT', item_f('NR_DOCUMENTO', tSIS_VALOR));
      putitem_e(tFCR_FATURAI, 'TP_SITUACAO', 1);
      putitem_e(tFCR_FATURAI, 'TP_DOCUMENTO', item_f('TP_DOCUMENTO', tSIS_VALOR));
      putitem_e(tFCR_FATURAI, 'TP_FATURAMENTO', vTpFaturamento);
      putitem_e(tFCR_FATURAI, 'TP_COBRANCA', 0);
      putitem_e(tFCR_FATURAI, 'TP_INCLUSAO', 2);
      putitem_e(tFCR_FATURAI, 'TP_BAIXA', 0);
      putitem_e(tFCR_FATURAI, 'CD_MOTIVOPRORR', '');
      putitem_e(tFCR_FATURAI, 'CD_MOTIVOJURDESC', '');
      putitem_e(tFCR_FATURAI, 'NR_PARCELAORIGEM', '');
      putitem_e(tFCR_FATURAI, 'NR_COMISSAOPAGA', '');

      clear_e(tFCX_HISTREL);
      clear_e(tFCX_HISTRELSUB);
      if (item_f('TP_DOCUMENTO', tSIS_VALOR) = 4 ) or (item_f('TP_DOCUMENTO', tSIS_VALOR) = 5) then begin
        putitem_e(tFCX_HISTRELSUB, 'TP_DOCUMENTO', item_f('TP_DOCUMENTO', tSIS_VALOR));
        putitem_e(tFCX_HISTRELSUB, 'NR_SEQHISTRELSUB', itemXmlF('NR_SEQHISTRELSUB', item_a('DS_ADICIONAL', tSIS_VALOR)));
        retrieve_e(tFCX_HISTRELSUB);
        if (xStatus >= 0) then begin
          putitem_e(tFCR_FATURAI, 'NR_PORTADOR', item_f('NR_PORTADOR', tFCX_HISTRELSUB));
        end else begin
          Result := SetStatus(STS_ERROR, 'GEN0001', , cDS_METHOD);
          return(-1); exit;
        end;
        putitem_e(tFCR_FATURAI, 'NR_HISTRELSUB', item_f('NR_SEQHISTRELSUB', tFCX_HISTRELSUB));
      end else begin
        putitem_e(tFCX_HISTREL, 'TP_DOCUMENTO', item_f('TP_DOCUMENTO', tSIS_VALOR));
        retrieve_e(tFCX_HISTREL);
        if (xStatus >= 0) then begin
          putitem_e(tFCR_FATURAI, 'NR_PORTADOR', item_f('NR_PORTADOR', tFCX_HISTREL));
        end else begin
          Result := SetStatus(STS_ERROR, 'GEN0001', , cDS_METHOD);
          return(-1); exit;
        end;
      end;
      putitem_e(tFCR_FATURAI, 'CD_OPERBAIXA', '');
      putitem_e(tFCR_FATURAI, 'CD_OPERCANCEL', '');
      putitem_e(tFCR_FATURAI, 'CD_OPERALTERACAO', '');
      putitem_e(tFCR_FATURAI, 'CD_OPERIMPFAT', '');
      putitem_e(tFCR_FATURAI, 'DT_EMISSAO', vDtSistema);
      putitem_e(tFCR_FATURAI, 'DT_ALTERACAO', '');
      putitem_e(tFCR_FATURAI, 'DT_CANCELAMENTO', '');
      putitem_e(tFCR_FATURAI, 'DT_VENCIMENTO', item_a('DT_VENCIMENTO', tSIS_VALOR));
      putitem_e(tFCR_FATURAI, 'DT_VENCTOORIGEM', '');
      putitem_e(tFCR_FATURAI, 'DT_IMPFAT', '');
      putitem_e(tFCR_FATURAI, 'CD_EMPLIQ', '');
      putitem_e(tFCR_FATURAI, 'DT_LIQ', '');
      putitem_e(tFCR_FATURAI, 'NR_SEQLIQ', '');
      putitem_e(tFCR_FATURAI, 'NR_DOCUMENTO', item_f('NR_DOCUMENTO', tSIS_VALOR));
      putitem_e(tFCR_FATURAI, 'VL_FATURA', item_f('VL_DOCUMENTO', tSIS_VALOR));
      putitem_e(tFCR_FATURAI, 'VL_ORIGINAL', item_f('VL_DOCUMENTO', tSIS_VALOR));
      putitem_e(tFCR_FATURAI, 'VL_PAGO', 0);
      putitem_e(tFCR_FATURAI, 'VL_JUROS', 0);
      putitem_e(tFCR_FATURAI, 'VL_DESCONTO', 0);
      putitem_e(tFCR_FATURAI, 'VL_OUTACRES', 0);
      putitem_e(tFCR_FATURAI, 'VL_OUTDESC', 0);
      putitem_e(tFCR_FATURAI, 'VL_ABATIMENTO', 0);
      putitem_e(tFCR_FATURAI, 'VL_DESPFIN', 0);
      putitem_e(tFCR_FATURAI, 'VL_ACRESCIMO', 0);

      if (item_f('TP_DOCUMENTO', tSIS_VALOR) = 1) then begin
        if (gInDesctoAntecFatSimu = True) then begin
          putitemXml(viParams, 'CD_EMPRESA', item_f('CD_EMPRESA', tTRA_TRANSACAO));
          putitemXml(viParams, 'NR_TRANSACAO', item_f('NR_TRANSACAO', tTRA_TRANSACAO));
          putitemXml(viParams, 'DT_TRANSACAO', item_a('DT_TRANSACAO', tTRA_TRANSACAO));
          voParams := activateCmp('TRASVCO022', 'buscaDadosTransacao', viParams); (*,viParams,voParams,, *)
          if (xStatus < 0) then begin
            Result := voParams;
            return(-1); exit;
          end;
          if (itemXml('PR_SIMULADOR', voParams) <> '')  and (itemXml('PR_SIMULADOR', voParams) > 0) then begin
            putitem_e(tFCR_FATURAI, 'PR_DESCANTECIP1', itemXmlF('PR_SIMULADOR', voParams));
            vDtVencimento := item_a('DT_VENCIMENTO', tSIS_VALOR) - 1d;
            putitem_e(tFCR_FATURAI, 'DT_DESCANTECIP1', vDtVencimento);
          end;
        end;

        putitem_e(tFCR_FATURAI, 'PR_DESCPGPRAZO', vPrDescPontual);
        putitem_e(tFCR_FATURAI, 'TP_COBRANCA', vTpCobranca);
        if (vTpCobranca = 18) then begin
          putitem_e(tFCR_FATURAI, 'IN_ACEITE', True);
        end;

        vInCobLoja := itemXmlB('IN_COBLOJA', item_a('DS_ADICIONAL', tSIS_VALOR));
        if (vInCobLoja = True) then begin
          putitem_e(tFCR_FATURAI, 'TP_COBRANCA', 16);
        end;
        if (gCdEmpContrato > 0)  and (gNrSeqContrato > 0) then begin
          vInAgRecebimento := itemXmlB('IN_AGRECEBIMENTO', item_a('DS_ADICIONAL', tSIS_VALOR));
          if (vInAgRecebimento = True) then begin
            putitem_e(tFCR_FATURAI, 'TP_COBRANCA', 17);
          end;
          if (itemXml('CD_INDICE', item_a('DS_ADICIONAL', tSIS_VALOR)) <> '') then begin
            vDsIndice := '';
            putitemXml(vDsIndice, 'CD_INDICE', itemXmlF('CD_INDICE', item_a('DS_ADICIONAL', tSIS_VALOR)));
            putitemXml(vDsIndice, 'DT_CORRECAO', itemXml('DT_CORRECAO', item_a('DS_ADICIONAL', tSIS_VALOR)));
          end;
        end;

        putitem_e(tFCR_FATURAI, 'VL_OUTDESC', vPrDescBonific * item_f('VL_FATURA', tFCR_FATURAI) / 100);
        putitem_e(tFCR_FATURAI, 'VL_OUTDESC', roundto(item_f('VL_OUTDESC', tFCR_FATURAI), 2));

        vVlAbatimento := vPrDescAbatiPed * item_f('VL_FATURA', tFCR_FATURAI) / 100;
        vVlAbatimento := roundto(vVlAbatimento, 2);

        if (gCdCartao > 0) then begin
          putitem_e(tFCR_FATURAI, 'NR_RESUMOCARTAO', gCdCartao);
          putitem_e(tFCR_FATURAI, 'DS_RESUMOCARTAO', 'PROPRIO');
        end;
      end else if (item_f('TP_DOCUMENTO', tSIS_VALOR) = 2)  or (item_f('TP_DOCUMENTO', tSIS_VALOR) = 15) then begin
        putitem_e(tFCR_FATURAI, 'TP_DOCUMENTO', item_f('TP_DOCUMENTO', tSIS_VALOR));

        if (itemXml('CD_CLIENTE', item_a('DS_ADICIONAL', tSIS_VALOR)) <> 0) then begin
          putitem_e(tFCR_FATURAI, 'CD_CLIENTE', itemXmlF('CD_CLIENTE', item_a('DS_ADICIONAL', tSIS_VALOR)));
        end;
        if (gCdCartao > 0)  and (item_f('TP_DOCUMENTO', tSIS_VALOR) = 2) then begin
          putitem_e(tFCR_FATURAI, 'NR_RESUMOCARTAO', gCdCartao);
          putitem_e(tFCR_FATURAI, 'DS_RESUMOCARTAO', 'PROPRIO');
        end;

        vDsCheque := '';
        putitemXml(vDsCheque, 'NR_BANCO', itemXmlF('NR_BANCO', item_a('DS_ADICIONAL', tSIS_VALOR)));
        putitemXml(vDsCheque, 'NR_AGENCIA', itemXmlF('NR_AGENCIA', item_a('DS_ADICIONAL', tSIS_VALOR)));
        putitemXml(vDsCheque, 'NR_CONTA'     itemXmlF('NR_CONTA', item_a('DS_ADICIONAL', tSIS_VALOR)));
        putitemXml(vDsCheque, 'NR_CHEQUE'    itemXmlF('NR_CHEQUE', item_a('DS_ADICIONAL', tSIS_VALOR)));
        putitemXml(vDsCheque, 'DS_BANDA'     itemXmlF('NR_BANDA', item_a('DS_ADICIONAL', tSIS_VALOR)));
        putitemXml(vDsCheque, 'DS_TELEFONE'  itemXmlF('NR_TELEFONE', item_a('DS_ADICIONAL', tSIS_VALOR)));
        putitemXml(vDsCheque, 'DS_DOCUMENTO' itemXmlF('NR_CPFCNPJ', item_a('DS_ADICIONAL', tSIS_VALOR)));
        putitemXml(vDsCheque, 'IN_TERCEIRO', itemXmlB('IN_TERCEIRO', item_a('DS_ADICIONAL', tSIS_VALOR)));

      end else if (item_f('TP_DOCUMENTO', tSIS_VALOR) = 3) then begin
        putitem_e(tFCR_FATURAI, 'DT_LIQ', vDtSistema);
        putitem_e(tFCR_FATURAI, 'VL_PAGO', item_f('VL_DOCUMENTO', tSIS_VALOR));
        putitem_e(tFCR_FATURAI, 'TP_BAIXA', 10);
        putitem_e(tFCR_FATURAI, 'DT_BAIXA', vDtSistema);
        putitem_e(tFCR_FATURAI, 'CD_OPERBAIXA', itemXmlF('CD_USUARIO', PARAM_GLB));

      end else if (item_f('TP_DOCUMENTO', tSIS_VALOR) = 4) then begin
        putitem_e(tFCR_FATURAI, 'TP_BAIXA', 10);
      end else if (item_f('TP_DOCUMENTO', tSIS_VALOR) = 5) then begin
        putitem_e(tFCR_FATURAI, 'TP_BAIXA', 10);
      end else if (item_f('TP_DOCUMENTO', tSIS_VALOR) = 7) then begin
      end else if (item_f('TP_DOCUMENTO', tSIS_VALOR) = 9) then begin
        putitem_e(tFCR_FATURAI, 'DT_LIQ', vDtSistema);
        putitem_e(tFCR_FATURAI, 'VL_PAGO', item_f('VL_DOCUMENTO', tSIS_VALOR));
        putitem_e(tFCR_FATURAI, 'TP_BAIXA', 10);
        putitem_e(tFCR_FATURAI, 'DT_BAIXA', vDtSistema);
        putitem_e(tFCR_FATURAI, 'CD_OPERBAIXA', itemXmlF('CD_USUARIO', PARAM_GLB));

      end else if (item_f('TP_DOCUMENTO', tSIS_VALOR) = 10) then begin
        putitem_e(tFCR_FATURAI, 'DT_LIQ', vDtSistema);
        putitem_e(tFCR_FATURAI, 'VL_PAGO', item_f('VL_DOCUMENTO', tSIS_VALOR));
        putitem_e(tFCR_FATURAI, 'TP_BAIXA', 10);
        putitem_e(tFCR_FATURAI, 'DT_BAIXA', vDtSistema);
        putitem_e(tFCR_FATURAI, 'CD_OPERBAIXA', itemXmlF('CD_USUARIO', PARAM_GLB));

      end else if (item_f('TP_DOCUMENTO', tSIS_VALOR) = 11) then begin
        putitem_e(tFCR_FATURAI, 'DT_LIQ', vDtSistema);
        putitem_e(tFCR_FATURAI, 'TP_BAIXA', 10);
        putitem_e(tFCR_FATURAI, 'DT_BAIXA', vDtSistema);
        putitem_e(tFCR_FATURAI, 'CD_OPERBAIXA', itemXmlF('CD_USUARIO', PARAM_GLB));

      end else if (item_f('TP_DOCUMENTO', tSIS_VALOR) = 12) then begin
        vNrDOFNI := itemXmlF('NR_DOFNI', item_a('DS_ADICIONAL', tSIS_VALOR));

        if (vNrDOFNI > 0) then begin
          creocc(tFCR_DOFNI, -1);
          putitem_e(tFCR_DOFNI, 'NR_DOFNI', vNrDOFNI);
          retrieve_o(tFCR_DOFNI);
          if (xStatus = 4) then begin
            putitem_e(tFCR_FATURAI, 'CD_CLIENTE', item_f('CD_PESSOA', tFCR_DOFNI));
          end else begin
            discard 'FCR_DOFNI';
          end;
        end;

        putitem_e(tFCR_FATURAI, 'DT_LIQ', vDtSistema);
        putitem_e(tFCR_FATURAI, 'VL_PAGO', item_f('VL_DOCUMENTO', tSIS_VALOR));
        putitem_e(tFCR_FATURAI, 'TP_BAIXA', 10);
        putitem_e(tFCR_FATURAI, 'DT_BAIXA', vDtSistema);
        putitem_e(tFCR_FATURAI, 'CD_OPERBAIXA', itemXmlF('CD_USUARIO', PARAM_GLB));

      end else if (item_f('TP_DOCUMENTO', tSIS_VALOR) = 18) then begin
        putitem_e(tFCR_FATURAI, 'DT_LIQ', vDtSistema);
        putitem_e(tFCR_FATURAI, 'VL_PAGO', item_f('VL_DOCUMENTO', tSIS_VALOR));
        putitem_e(tFCR_FATURAI, 'TP_BAIXA', 10);
        putitem_e(tFCR_FATURAI, 'DT_BAIXA', vDtSistema);
        putitem_e(tFCR_FATURAI, 'CD_OPERBAIXA', itemXmlF('CD_USUARIO', PARAM_GLB));

      end else if (item_f('TP_DOCUMENTO', tSIS_VALOR) = 13) then begin
        putitem_e(tFCR_FATURAI, 'DT_LIQ', vDtSistema);
        putitem_e(tFCR_FATURAI, 'VL_PAGO', item_f('VL_DOCUMENTO', tSIS_VALOR));
        putitem_e(tFCR_FATURAI, 'TP_BAIXA', 10);
        putitem_e(tFCR_FATURAI, 'DT_BAIXA', vDtSistema);
        putitem_e(tFCR_FATURAI, 'CD_OPERBAIXA', itemXmlF('CD_USUARIO', PARAM_GLB));

      end else if (item_f('TP_DOCUMENTO', tSIS_VALOR) = 14) then begin
        putitem_e(tFCR_FATURAI, 'PR_DESCPGPRAZO', vPrDescPontual);
        vInCobLoja := itemXmlB('IN_COBLOJA', item_a('DS_ADICIONAL', tSIS_VALOR));
        if (vInCobLoja = True) then begin
          putitem_e(tFCR_FATURAI, 'TP_COBRANCA', 16);
        end;

        putitem_e(tFCR_FATURAI, 'VL_OUTDESC', vPrDescBonific * item_f('VL_FATURA', tFCR_FATURAI) / 100);
        putitem_e(tFCR_FATURAI, 'VL_OUTDESC', roundto(item_f('VL_OUTDESC', tFCR_FATURAI), 2));
      end else if (item_f('TP_DOCUMENTO', tSIS_VALOR) = 20) then begin
        putitem_e(tFCR_FATURAI, 'DT_LIQ', vDtSistema);
        putitem_e(tFCR_FATURAI, 'VL_PAGO', item_f('VL_DOCUMENTO', tSIS_VALOR));
        putitem_e(tFCR_FATURAI, 'TP_BAIXA', 10);
        putitem_e(tFCR_FATURAI, 'DT_BAIXA', vDtSistema);
        putitem_e(tFCR_FATURAI, 'CD_OPERBAIXA', itemXmlF('CD_USUARIO', PARAM_GLB));

      end;

      vDsLstComissao := '';

      if (gInPdvOtimizado <> True) then begin
        if (item_f('TP_DOCUMENTO', tSIS_VALOR) <> 11)  and (item_f('TP_DOCUMENTO', tSIS_VALOR) <> 20) then begin
          if (gCdEmpContrato > 0)  and (gNrSeqContrato > 0) then begin
            viParams := '';
            putitemXml(viParams, 'CD_EMPCONTRATO', gCdEmpContrato);
            putitemXml(viParams, 'NR_SEQCONTRATO', gNrSeqContrato);
            putitemXml(viParams, 'NR_SEQITEM', gNrSeqItemContrato);
            putitemXml(viParams, 'VL_FATURA', item_f('VL_FATURA', tFCR_FATURAI));
            putitemXml(viParams, 'CD_EMPTRANSACAO', item_f('CD_EMPRESA', tTRA_TRANSACAO));
            putitemXml(viParams, 'NR_TRANSACAO', item_f('NR_TRANSACAO', tTRA_TRANSACAO));
            putitemXml(viParams, 'DT_TRANSACAO', item_a('DT_TRANSACAO', tTRA_TRANSACAO));

            voParams := activateCmp('COMSVCO002', 'calculaComissaoContrato', viParams); (*,viParams,voParams,, *)
            if (xStatus < 0) then begin
              Result := voParams;
              return(-1); exit;
            end;
            vDsLstComisRepre := itemXml('DS_LSTCOMISSAO', voParams);
            if (vDsLstComisRepre <> '') then begin
              vDsLstComissao := vDsLstComisRepre;
            end;
          end else begin
            viParams := '';
            putitemXml(viParams, 'DS_LSTTRANSACAO', gDsLstTransacao);
            putitemXml(viParams, 'VL_FATURA', item_f('VL_FATURA', tFCR_FATURAI));
            putitemXml(viParams, 'TP_DOCUMENTO', item_f('TP_DOCUMENTO', tFCR_FATURAI));
            voParams := activateCmp('COMSVCO002', 'calculaComissaoGuia', viParams); (*,viParams,voParams,, *)
            if (xStatus < 0) then begin
              Result := voParams;
              return(-1); exit;
            end;

            vDsLstComisGuia := itemXml('DS_LSTCOMISSAO', voParams);

            voParams := activateCmp('COMSVCO002', 'calculaComissaoRepre', viParams); (*,viParams,voParams,, *)
            if (xStatus < 0) then begin
              Result := voParams;
              return(-1); exit;
            end;

            vDsLstComisRepre := itemXml('DS_LSTCOMISSAO', voParams);

            if (vDsLstComisGuia = '') then begin
              vDsLstComissao := vDsLstComisRepre;
            end else begin
              vDsLstComissao := vDsLstComisGuia;
              if (vDsLstComisRepre <> '') then begin
                vDsLstComissao := '' + vDsLstComissao + ';
              end;
            end;
          end;
        end;
      end;
      if (item_f('TP_DOCUMENTO', tSIS_VALOR) = 4 ) or (item_f('TP_DOCUMENTO', tSIS_VALOR) = 5) then begin
        creocc(tTMP_K02NR10, -1);
        putitem_e(tTMP_K02NR10, 'NR_CHAVE01', item_f('NR_PORTADOR', tFCR_FATURAI));
        putitem_e(tTMP_K02NR10, 'NR_CHAVE02', item_f('NR_FAT', tFCR_FATURAI));
        retrieve_o(tTMP_K02NR10);
        if (xStatus = -7) then begin
          retrieve_x(tTMP_K02NR10);
        end;
        putlistitensocc_e(vDsRegistro, tFCR_FATURAI);
        if (vDsLstComissao <> '') then begin
          putitemXml(vDsRegistro, 'DS_FATCOMISSAO', vDsLstComissao);
        end;
        putitem_e(tTMP_K02NR10, 'NR_SEQHISTRELSUB', item_f('NR_SEQHISTRELSUB', tFCX_HISTRELSUB));
        putitem(item_a('DS_LSTFATURA', tTMP_K02NR10),  vDsRegistro);
      end else begin
        if (item_f('TP_DOCUMENTO', tSIS_VALOR) = 9)  and (item_b('IN_ADIANTATROCO', tSIS_DUMMY3) = True) then begin
          putitem_e(tFCR_FATURAI, 'TP_DOCUMENTO', 10);
          viParams := '';
          putlistitensocc_e(vDsRegistro, tFCR_FATURAI);
          putitemXml(viParams, 'DS_FATURAI', vDsRegistro);
          putitemXml(viParams, 'DS_CHEQUE', vDsCheque);
          putitemXml(viParams, 'IN_ALTSOFATURAI', False);
          putitemXml(viParams, 'IN_SEMCOMISSAO', True);
          putitemXml(viParams, 'IN_SEMIMPOSTO', True);
          putitemXml(viParams, 'CD_COMPONENTE', TRAFM066);
          putitemXml(viParams, 'LST_TRANSACAO', vLstTransacao);
          voParams := activateCmp('FCRSVCO001', 'geraFatura', viParams); (*,viParams,voParams,, *)
          if (xStatus < 0) then begin
            Result := voParams;
            return(-1); exit;
          end;
            return(-1); exit;

          end;
          if (voParams = '') then begin
            Result := SetStatus(STS_ERROR, 'GEN0001', , cDS_METHOD);
            return(-1); exit;
          end;
          vNrParcela := itemXmlF('NR_PARCELA', voParams);

          viParams := '';
          putitemXml(viParams, 'CD_EMPRESA', item_f('CD_EMPFAT', tTRA_TRANSACAO));
          putitemXml(viParams, 'CD_PESSOA', gCdPessoa);
          putitemXml(viParams, 'TP_CONTA', 'C');
          putitemXml(viParams, 'IN_NATUREZA', 'C');
          voParams := activateCmp('FCCSVCO002', 'criaContaPessoa', viParams); (*,viParams,voParams,, *)
          if (xStatus < 0) then begin
            Result := voParams;
            return(-1); exit;
          end;
          vNrCtaPes := itemXmlF('NR_CTAPES', voParams);

          viParams := '';
          putitemXml(viParams, 'CD_EMPRESA', item_f('CD_EMPFAT', tTRA_TRANSACAO));
          putitemXml(viParams, 'NR_CTAPES', vNrCtaPes);
          putitemXml(viParams, 'DT_MOVIMENTO', vDtSistema);
          putitemXml(viParams, 'CD_HISTORICO', 933);
          putitemXml(viParams, 'TP_DOCUMENTO', 10);
          putitemXml(viParams, 'NR_SEQHISTRELSUB', 1);
          putitemXml(viParams, 'VL_LANCTO', item_f('VL_DOCUMENTO', tSIS_VALOR));
          putitemXml(viParams, 'IN_ESTORNO', False);
          putitemXml(viParams, 'DS_DOC', item_f('NR_TRANSACAO', tTRA_TRANSACAO));
          putitemXml(viParams, 'DS_AUX', '');
          putitemXml(viParams, 'DT_CONCI', '');
          putitemXml(viParams, 'CD_OPERCONCI', '');
          voParams := activateCmp('FCCSVCO002', 'movimentaConta', viParams); (*,viParams,voParams,, *)
          if (xStatus < 0) then begin
            Result := voParams;
            return(-1); exit;
          end;
          vNrCtaPes := itemXmlF('NR_CTAPES', voParams);
          vDtMovim := itemXml('DT_MOVIM', voParams);
          vNrSeqMov := itemXmlF('NR_SEQMOV', voParams);
          vDsRegistro := '';
          putitemXml(vDsRegistro, 'NR_CTAPES', vNrCtaPes);
          putitemXml(vDsRegistro, 'DT_MOVIM', vDtMovim);
          putitemXml(vDsRegistro, 'NR_SEQMOV', vNrSeqMov);
          putitem(vDsLstMovCC,  vDsRegistro);

          vDsLstMovimento := '';
          putitem(vDsLstMovimento,  vDsRegistro);

          vDsRegistro := '';
          putitemXml(vDsRegistro, 'DS_LSTMOVCC', vDsLstMovimento);
          putitemXml(vDsRegistro, 'TP_LIQUIDACAO', 3);
          putitemXml(vDsRegistro, 'CD_EMPRESA', item_f('CD_EMPRESA', tFCR_FATURAI));
          putitemXml(vDsRegistro, 'NR_FAT', item_f('NR_FAT', tFCR_FATURAI));
          putitemXml(vDsRegistro, 'NR_PARCELA', vNrParcela);
          putitemXml(vDsRegistro, 'TP_DOCUMENTO', item_f('TP_DOCUMENTO', tFCR_FATURAI));
          putitemXml(vDsRegistro, 'VL_PAGO', item_f('VL_DOCUMENTO', tSIS_VALOR));
          putitemXml(vDsRegistro, 'NR_SEQUENCIA', vNrSequencia);
          putitemXml(vDsRegistro, 'CD_CLIENTE', gCdPessoa);
          putitemXml(vDsRegistro, 'CD_PESSOA', gCdPessoa);
          putitem(vDsLstLiqMov,  vDsRegistro);
          vNrSequencia := vNrSequencia + 1;
        end else begin
          viParams := '';
          putlistitensocc_e(vDsRegistro, tFCR_FATURAI);
          if (vDsLstComissao <> '') then begin
            putitemXml(vDsRegistro, 'DS_FATCOMISSAO', vDsLstComissao);

          end else begin
            putitemXml(viParams, 'IN_SEMCOMISSAO', True);
          end;
          putitemXml(viParams, 'DS_FATURAI', vDsRegistro);
          putitemXml(viParams, 'DS_INDICE', vDsIndice);
          putitemXml(viParams, 'DS_CHEQUE', vDsCheque);
          putitemXml(viParams, 'IN_ALTSOFATURAI', False);
          putitemXml(viParams, 'IN_SEMIMPOSTO', True);
          putitemXml(viParams, 'CD_COMPONENTE', TRAFM066);
          putitemXml(viParams, 'LST_TRANSACAO', vLstTransacao);
          voParams := activateCmp('FCRSVCO001', 'geraFatura', viParams); (*,viParams,voParams,, *)
          if (xStatus < 0) then begin
            Result := voParams;
            return(-1); exit;
          end;
            return(-1); exit;

          end;
          if (voParams = '') then begin
            Result := SetStatus(STS_ERROR, 'GEN0001', , cDS_METHOD);
            return(-1); exit;
          end;

          vNrParcela := itemXmlF('NR_PARCELA', voParams);

          vDsRegistro := voParams;
          putitemXml(vDsRegistro, 'NR_CTAPESCX', gNrCtaUsuario);

          if (item_f('TP_DOCUMENTO', tSIS_VALOR) = 18) then begin
            putitemXml(vDsRegistro, 'NR_CTAPES', itemXmlF('NR_CTAPES', item_a('DS_ADICIONAL', tSIS_VALOR)));
            putitemXml(vDsRegistro, 'CD_EMPRESACHE', itemXmlF('CD_EMPRESA', item_a('DS_ADICIONAL', tSIS_VALOR)));
            putitemXml(vDsRegistro, 'CD_CLIENTECHE', itemXmlF('CD_CLIENTE', item_a('DS_ADICIONAL', tSIS_VALOR)));
            putitemXml(vDsRegistro, 'NR_CHEQUE', itemXmlF('NR_CHEQUE', item_a('DS_ADICIONAL', tSIS_VALOR)));
            putitemXml(vDsRegistro, 'VL_CHEQUE', itemXmlF('VL_CHEQUE', item_a('DS_ADICIONAL', tSIS_VALOR)));
          end;

          putitem(vDsLstFatura,  vDsRegistro);
          if (item_f('TP_DOCUMENTO', tSIS_VALOR) = 1)  or (item_f('TP_DOCUMENTO', tSIS_VALOR) = 14) then begin
            putitem(vDsLstFaturaImp,  vDsRegistro);
          end;
          if (item_f('TP_DOCUMENTO', tSIS_VALOR) = 18) then begin
            putitem_e(tSIS_VALOR, 'DS_REGISTRO', vDsRegistro);
          end;
          if (vCdDescAbatiPed <> 0)  and (item_f('TP_DOCUMENTO', tSIS_VALOR) = 1) then begin
            if (vCdAbatiPed = 0) then begin
              Result := SetStatus(STS_ERROR, 'GEN0001', , cDS_METHOD);
              return(-1); exit;
            end;
            if (vVlAbatimento <> 0) then begin
              viParams := '';
              putitemXml(viParams, 'CD_EMPRESA', item_f('CD_EMPRESA', tFCR_FATURAI));
              putitemXml(viParams, 'CD_CLIENTE', item_f('CD_CLIENTE', tFCR_FATURAI));
              putitemXml(viParams, 'NR_FAT', item_f('NR_FAT', tFCR_FATURAI));
              putitemXml(viParams, 'NR_PARCELA', vNrParcela);
              putitemXml(viParams, 'VL_ABATIMENTO', vVlAbatimento);
              putitemXml(viParams, 'IN_PARCIAL', True);
              voParams := activateCmp('FCRSVCO019', 'gerarAbatimentoLiq', viParams); (*,viParams,voParams,, *)
              if (xStatus < 0) then begin
                Result := voParams;
                return(-1); exit;
              end;

              viParams := '';
              putitemXml(viParams, 'CD_EMPRESA', item_f('CD_EMPRESA', tFCR_FATURAI));
              putitemXml(viParams, 'CD_CLIENTE', item_f('CD_CLIENTE', tFCR_FATURAI));
              putitemXml(viParams, 'NR_FAT', item_f('NR_FAT', tFCR_FATURAI));
              putitemXml(viParams, 'NR_PARCELA', vNrParcela);
              putitemXml(viParams, 'CD_TIPOABAT', vCdAbatiPed);
              putitemXml(viParams, 'VL_ABATIMENTO', vVlAbatimento);
              putitemXml(viParams, 'CD_MOTIVO', vCdMotivoAbat);
              putitemXml(viParams, 'CD_EMPLIQ', itemXmlF('CD_EMPLIQ', voParams));
              putitemXml(viParams, 'DT_LIQ', itemXml('DT_LIQ', voParams));
              putitemXml(viParams, 'NR_SEQLIQ', itemXmlF('NR_SEQLIQ', voParams));
              voParams := activateCmp('FCRSVCO019', 'gerarAbatimento', viParams); (*,viParams,voParams,, *)
              if (xStatus < 0) then begin
                Result := voParams;
                return(-1); exit;
              end;
            end;
          end;
        end;
      end;
      if (item_f('TP_DOCUMENTO', tSIS_VALOR) = 9)  and (item_b('IN_ADIANTATROCO', tSIS_DUMMY3) = True) then begin
      end else begin
        viParams := '';
        putitemXml(viParams, 'CD_EMPRESA', item_f('CD_EMPFAT', tTRA_TRANSACAO));
        putitemXml(viParams, 'NR_CTAPES', gNrCtaUsuario);
        putitemXml(viParams, 'DT_MOVIMENTO', vDtSistema);
        if (item_f('TP_DOCUMENTO', tSIS_VALOR) = 9) then begin
          putitemXml(viParams, 'CD_HISTORICO', 935);
        end else begin
          putitemXml(viParams, 'CD_HISTORICO', 930);
        end;
        putitemXml(viParams, 'TP_DOCUMENTO', item_f('TP_DOCUMENTO', tSIS_VALOR));
        if (item_f('TP_DOCUMENTO', tSIS_VALOR) = 4 ) or (item_f('TP_DOCUMENTO', tSIS_VALOR) = 5) then begin
          putitemXml(viParams, 'NR_SEQHISTRELSUB', item_f('NR_SEQHISTRELSUB', tFCX_HISTRELSUB));
        end else begin
          putitemXml(viParams, 'NR_SEQHISTRELSUB', 1);
        end;
        putitemXml(viParams, 'VL_LANCTO', item_f('VL_DOCUMENTO', tSIS_VALOR));
        putitemXml(viParams, 'IN_ESTORNO', False);
        putitemXml(viParams, 'DS_DOC', item_f('NR_DOCUMENTO', tSIS_VALOR));
        putitemXml(viParams, 'DS_AUX', 'CLIENTE: ' + FloatToStr(gCdPessoa')) + ';
        putitemXml(viParams, 'DT_CONCI', '');
        putitemXml(viParams, 'CD_OPERCONCI', '');
        putitem(vDsLstParamCC,  viParams);

      end;
      if (itemXml('CD_TIPOCLASFCR', item_a('DS_REGISTRO', tSIS_VALOR)) > 0)  and (itemXml('CD_CLASFCR', item_a('DS_REGISTRO', tSIS_VALOR)) > 0) then begin
        vDsRegistro := '';
        putitemXml(vDsRegistro, 'CD_EMPRESA', item_f('CD_EMPFAT', tTRA_TRANSACAO));
        putitemXml(vDsRegistro, 'CD_CLIENTE', gCdPessoa);
        putitemXml(vDsRegistro, 'NR_FAT', item_f('NR_DOCUMENTO', tSIS_VALOR));
        putitemXml(vDsRegistro, 'NR_PARCELA', vNrParcela);
        putitem(vDsLstSeguro,  vDsRegistro);

        vDsClas := '';
        vDsLstClas := '';
        putitemXml(vDsClas, 'CD_TIPOCLAS', itemXmlF('CD_TIPOCLASFCR', item_a('DS_REGISTRO', tSIS_VALOR)));
        putitemXml(vDsClas, 'CD_CLASSIFICACAO', itemXmlF('CD_CLASFCR', item_a('DS_REGISTRO', tSIS_VALOR)));
        putitem(vDsLstClas,  vDsClas);
        putitemXml(vDsRegistro, 'DS_LSTCLASSIFICACAO', vDsLstClas);
        putitem(vDsLstFatura2,  vDsRegistro);

        viParams := '';
        putitemXml(viParams, 'DS_LSTFATURA', vDsLstFatura2);
        voParams := activateCmp('FCRSVCO001', 'gravaClassificacao', viParams); (*,viParams,voParams,, *)
        if (xStatus < 0) then begin
          Result := voParams;
          return(-1); exit;
        end;
          return(-1); exit;
        end else if (xStatus < 0) then begin
          Result := voParams;

          return(-1); exit;
        end;

      end else begin
        vDsRegistro := '';
        putitemXml(vDsRegistro, 'CD_EMPRESA', item_f('CD_EMPFAT', tTRA_TRANSACAO));
        putitemXml(vDsRegistro, 'CD_CLIENTE', gCdPessoa);
        putitemXml(vDsRegistro, 'NR_FAT', item_f('NR_DOCUMENTO', tSIS_VALOR));
        putitemXml(vDsRegistro, 'NR_PARCELA', vNrParcela);
        putitem(vDsLstNaoSeguro,  vDsRegistro);

      end;
    end;

    setocc(tSIS_VALOR, curocc(tSIS_VALOR) + 1);
  end;
  if (vDsLstNaoSeguro <> '')  and (vDsLstSeguro <> '') then begin
    viParams := '';
    putitemXml(viParams, 'DS_LSTPRODUTO', vDsLstNaoSeguro);
    putitemXml(viParams, 'DS_LSTSEGURO', vDsLstSeguro);
    voParams := activateCmp('FCRSVCO119', 'gravaRelacFatSeguro', viParams); (*,viParams,voParams,, *)
    if (xStatus < 0) then begin
      Result := voParams;
      return(-1); exit;
    end;
  end;
  if (empty(tTMP_K02NR10) = False) then begin
    setocc(tTMP_K02NR10, 1);
    while (xStatus >= 0) do begin
      viParams := '';
      putitemXml(viParams, 'NR_PORTADOR', item_f('NR_CHAVE01', tTMP_K02NR10));
      putitemXml(viParams, 'DS_LSTFATURA', item_a('DS_LSTFATURA', tTMP_K02NR10));
      putitemXml(viParams, 'CD_COMPONENTE', TRAFM066);
      putitemXml(viParams, 'CD_CARTAO', gCdCartao);
      putitemXml(viParams, 'NR_SEQCARTAO', gNrSeqCartao);
      putitemXml(viParams, 'IN_FATURAMENTO', True);
      putitemXml(viParams, 'CD_AUTORIZACAO', itemXmlF('CD_AUTORIZACAO', item_a('DS_ADICIONAL', tSIS_VALOR)));
      putitemXml(viParams, 'NR_NSU', itemXmlF('NR_NSU', item_a('DS_ADICIONAL', tSIS_VALOR)));

      newinstance 'FCRSVCO005', 'FCRSVCO005', '';
      voParams := activateCmp('FCRSVCO005', 'geraCartao', viParams); (*,viParams,voParams,, *)
      if (xStatus < 0) then begin
        Result := voParams;
        return(-1); exit;
      end;
      deleteinstance 'FCRSVCO005';
      vDsLstCartao := itemXml('DS_LSTFATURA', voParams);
      if (vDsLstCartao = '') then begin
        Result := SetStatus(STS_ERROR, 'GEN0001', , cDS_METHOD);
        return(-1); exit;
      end;
      repeat
        getitem(vDsRegistro, vDsLstCartao, 1);
        putitemXml(vDsRegistro, 'NR_CTAPESCX', gNrCtaUsuario);
        putitemXml(vDsRegistro, 'NR_SEQHISTRELSUB', item_f('NR_SEQHISTRELSUB', tTMP_K02NR10));
        putitem(vDsLstFatura,  vDsRegistro);
        delitem(vDsLstCartao, 1);
      until (vDsLstCartao = '');

      setocc(tTMP_K02NR10, curocc(tTMP_K02NR10) + 1);
    end;
  end;

  viParams := '';
  putitemXml(viParams, 'CD_PESSOA', gCdPessoa);
  putitemXml(viParams, 'DS_LSTTRANSACAO', gDsLstTransacao);
  putitemXml(viParams, 'DS_LSTFATURA', vDsLstFatura);
  putitemXml(viParams, 'DS_LSTMOVCC', vDsLstMovCC);
  putitemXml(viParams, 'TP_CHEQUEPRESENTE', gTpChequePresente);
  voParams := activateCmp('TRASVCO011', 'gravaLiqTransacao', viParams); (*,viParams,voParams,, *)
  if (xStatus < 0) then begin
    Result := voParams;
    return(-1); exit;
  end;
  if (voParams = '') then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', , cDS_METHOD);
    return(-1); exit;
  end else begin
    gCdEmpLiq := itemXmlF('CD_EMPLIQ', voParams);
    gDtLiq := itemXml('DT_LIQ', voParams);
    gNrSeqLiq := itemXmlF('NR_SEQLIQ', voParams);
  end;
  if (gVlTotBonus <> 0) then begin
    viParams := '';
    putitemXml(viParams, 'CD_CARTAO', gCdCartao);
    putitemXml(viParams, 'NR_SEQCARTAO', gNrSeqCartao);
    putitemXml(viParams, 'VL_BONUS', gVlTotBonus);
    putitemXml(viParams, 'TP_OPERACAO', 'D');
    putitemXml(viParams, 'DT_BONUS', gDtLiq);
    putitemXml(viParams, 'DT_VENCIMENTO', gDtLiq);
    putitemXml(viParams, 'CD_EMPLIQ', gCdEmpLiq);
    putitemXml(viParams, 'DT_LIQ', gDtLiq);
    putitemXml(viParams, 'NR_SEQLIQ', gNrSeqLiq);
    voParams := activateCmp('CTCSVCO001', 'gravarBonus', viParams); (*,viParams,voParams,, *)
    if (xStatus < 0) then begin
      Result := voParams;
      return(-1); exit;
    end;
  end;

  repeat

    getitem(viParams, vDsLstParamCC, 1);
    putitemXml(viParams, 'CD_EMPLIQ', gCdEmpLiq);
    putitemXml(viParams, 'DT_LIQ', gDtLiq);
    putitemXml(viParams, 'NR_SEQLIQ', gNrSeqLiq);
    putitemXml(viParams, 'IN_CAIXA', True);
    putitemXml(viParams, 'CD_TERMINAL', gCdTerminal);
    putitemXml(viParams, 'DT_ABERTURA', gDtAbertura);
    putitemXml(viParams, 'NR_SEQCAIXA', gNrSeq);
    voParams := activateCmp('FCCSVCO002', 'movimentaConta', viParams); (*,viParams,voParams,, *)
    if (xStatus < 0) then begin
      Result := voParams;
      return(-1); exit;
    end;
    delitem(vDsLstParamCC, 1);
  until (vDsLstParamCC = '');

  if (vDsLstLiqMov <> '') then begin
    repeat
      viParams := '';
      getitem(viParams, vDsLstLiqMov, 1);
      putitemXml(viParams, 'CD_EMPLIQ', gCdEmpLiq);
      putitemXml(viParams, 'DT_LIQ', gDtLiq);
      putitemXml(viParams, 'NR_SEQLIQ', gNrSeqLiq);
      voParams := activateCmp('FCRSVCO007', 'gravaLiqMov', viParams); (*,viParams,voParams,, *)
      if (xStatus < 0) then begin
        Result := voParams;
        return(-1); exit;
      end;

      delitem(vDsLstLiqMov, 1);
    until (vDsLstLiqMov = '');
  end;
  if (gVlAdiantamento > 0) then begin
    viParams := '';
    putitemXml(viParams, 'CD_EMPRESA', item_f('CD_EMPFAT', tTRA_TRANSACAO));
    putitemXml(viParams, 'NR_CTAPES', gNrCtaCliente);
    putitemXml(viParams, 'DT_MOVIMENTO', vDtSistema);
    putitemXml(viParams, 'CD_HISTORICO', 901);
    putitemXml(viParams, 'TP_DOCUMENTO', 10);
    putitemXml(viParams, 'NR_SEQHISTRELSUB', 1);
    putitemXml(viParams, 'VL_LANCTO', gVlAdiantamento);
    putitemXml(viParams, 'IN_ESTORNO', False);
    putitemXml(viParams, 'DS_DOC', '');
    putitemXml(viParams, 'DS_AUX', '');
    putitemXml(viParams, 'DT_CONCI', '');
    putitemXml(viParams, 'CD_OPERCONCI', '');
    putitemXml(viParams, 'CD_EMPLIQ', gCdEmpLiq);
    putitemXml(viParams, 'DT_LIQ', gDtLiq);
    putitemXml(viParams, 'NR_SEQLIQ', gNrSeqLiq);
    voParams := activateCmp('FCCSVCO002', 'movimentaConta', viParams); (*,viParams,voParams,, *)
    if (xStatus < 0) then begin
      Result := voParams;
      return(-1); exit;
    end;
  end;
  if (gVlCREDEV > 0) then begin
    viParams := '';
    putitemXml(viParams, 'CD_EMPRESA', item_f('CD_EMPFAT', tTRA_TRANSACAO));
    putitemXml(viParams, 'NR_CTAPES', gNrCtaCliente);
    putitemXml(viParams, 'DT_MOVIMENTO', vDtSistema);
    putitemXml(viParams, 'CD_HISTORICO', 901);
    putitemXml(viParams, 'TP_DOCUMENTO', 20);
    putitemXml(viParams, 'NR_SEQHISTRELSUB', 1);
    putitemXml(viParams, 'VL_LANCTO', gVlCREDEV);
    putitemXml(viParams, 'IN_ESTORNO', False);
    putitemXml(viParams, 'DS_DOC', '');
    putitemXml(viParams, 'DS_AUX', '');
    putitemXml(viParams, 'DT_CONCI', '');
    putitemXml(viParams, 'CD_OPERCONCI', '');
    putitemXml(viParams, 'CD_EMPLIQ', gCdEmpLiq);
    putitemXml(viParams, 'DT_LIQ', gDtLiq);
    putitemXml(viParams, 'NR_SEQLIQ', gNrSeqLiq);
    voParams := activateCmp('FCCSVCO002', 'movimentaConta', viParams); (*,viParams,voParams,, *)
    if (xStatus < 0) then begin
      Result := voParams;
      return(-1); exit;
    end;
  end;

  setocc(tSIS_VALOR, 1);
  while (xStatus >= 0) do begin
    if (item_f('TP_DOCUMENTO', tSIS_VALOR) = 12) then begin
      viParams := '';
      putitemXml(viParams, 'NR_DOFNI', item_f('NR_DOCUMENTO', tSIS_VALOR));
      putitemXml(viParams, 'CD_EMPLIQ', gCdEmpLiq);
      putitemXml(viParams, 'DT_LIQ', gDtLiq);
      putitemXml(viParams, 'NR_SEQLIQ', gNrSeqLiq);
      voParams := activateCmp('FCRSVCO012', 'baixaDofni', viParams); (*,viParams,voParams,, *)
      if (xStatus < 0) then begin
        Result := voParams;
        return(-1); exit;
      end;
    end else if (item_f('TP_DOCUMENTO', tSIS_VALOR) = 18) then begin
      if (gTpChequePresente = 1) then begin
      end else begin

        viParams := '';
        putitemXml(viParams, 'CD_EMPRESA', itemXmlF('CD_EMPRESA', item_a('DS_ADICIONAL', tSIS_VALOR)));
        putitemXml(viParams, 'CD_CLIENTE', itemXmlF('CD_CLIENTE', item_a('DS_ADICIONAL', tSIS_VALOR)));
        putitemXml(viParams, 'NR_CHEQUE', itemXmlF('NR_CHEQUE', item_a('DS_ADICIONAL', tSIS_VALOR)));
        putitemXml(viParams, 'CD_EMPFAT', itemXmlF('CD_EMPRESA', item_a('DS_REGISTRO', tSIS_VALOR)));
        putitemXml(viParams, 'CD_CLIFAT', itemXmlF('CD_CLIENTE', item_a('DS_REGISTRO', tSIS_VALOR)));
        putitemXml(viParams, 'NR_FAT', itemXmlF('NR_FAT', item_a('DS_REGISTRO', tSIS_VALOR)));
        putitemXml(viParams, 'NR_PARCELA', itemXmlF('NR_PARCELA', item_a('DS_REGISTRO', tSIS_VALOR)));
        putitemXml(viParams, 'CD_EMPLIQ', gCdEmpLiq);
        putitemXml(viParams, 'DT_LIQ', gDtLiq);
        putitemXml(viParams, 'NR_SEQLIQ', gNrSeqLiq);
        voParams := activateCmp('FCRSVCO068', 'gravarUtilizacaoChequePresente', viParams); (*,viParams,voParams,, *)
        if (xStatus < 0) then begin
          Result := voParams;
          return(-1); exit;
        end;
      end;
    end;
    setocc(tSIS_VALOR, curocc(tSIS_VALOR) + 1);
  end;

  viParams := '';
  putitemXml(viParams, 'DS_LSTTRANSACAO', gDsLstTransacao);
  putitemXml(viParams, 'TP_SITUACAO', 4);
  voParams := activateCmp('TRASVCO004', 'alteraSituacaoTransacao', viParams); (*,viParams,voParams,, *)
  if (xStatus < 0) then begin
    Result := voParams;
    return(-1); exit;
  end;
  if (vDsLstClassificacao <> '') then begin
    viParams := '';
    putitemXml(viParams, 'DS_LSTFATURA', vDsLstFatura);
    putitemXml(viParams, 'DS_LSTCLASSIFICACAO', vDsLstClassificacao);
    voParams := activateCmp('FCRSVCO001', 'gravaClassificacao', viParams); (*,viParams,voParams,, *)
    if (xStatus < 0) then begin
      Result := voParams;
      return(-1); exit;
    end;
  end;

  viParams := '';
  putitemXml(viParams, 'CD_EMPRESA', item_f('CD_EMPRESA', tTRA_TRANSACAO));
  putitemXml(viParams, 'NR_TRANSACAO', item_f('NR_TRANSACAO', tTRA_TRANSACAO));
  putitemXml(viParams, 'DT_TRANSACAO', item_a('DT_TRANSACAO', tTRA_TRANSACAO));
  voParams := activateCmp('TRASVCO016', 'buscaDadosAdicionais', viParams); (*,viParams,voParams,, *)
  if (xStatus < 0) then begin
    Result := voParams;
    return(-1); exit;
  end;
  if (itemXml('CD_PROPRIEDADE', voParams) > 0) then begin
    viParams := '';
    putitemXml(viParams, 'CD_PESSOA', item_f('CD_PESSOA', tTRA_TRANSACAO));
    putitemXml(viParams, 'CD_PROPRIEDADE', itemXmlF('CD_PROPRIEDADE', voParams));
    putitemXml(viParams, 'DS_LSTFATURA', vDsLstFatura);
    voParams := activateCmp('FCRSVCO090', 'gravarClasPropRuralFatura', viParams); (*,viParams,voParams,, *)
    if (xStatus < 0) then begin
      Result := voParams;
      return(-1); exit;
    end;
  end;

  vDsLstTransacao := gDsLstTransacao;
  repeat
    getitem(vDsRegistro, vDsLstTransacao, 1);

    vCdEmpresa := itemXmlF('CD_EMPRESA', vDsRegistro);
    vNrTransacao := itemXmlF('NR_TRANSACAO', vDsRegistro);
    vDtTransacao := itemXml('DT_TRANSACAO', vDsRegistro);

    viParams := '';
    putitemXml(viParams, 'CD_EMPRESA', vCdEmpresa);
    putitemXml(viParams, 'NR_TRANSACAO', vNrTransacao);
    putitemXml(viParams, 'DT_TRANSACAO', vDtTransacao);
    putitemXml(viParams, 'NR_PRAZOMEDIO', item_f('QT_PRAZOMEDIO', tSIS_TOTAL));
    putitemXml(viParams, 'IN_PRAZOMEDIO', True);
    voParams := activateCmp('TRASVCO016', 'gravaDadosAdicionais', viParams); (*,viParams,voParams,, *)
    if (xStatus < 0) then begin
      Result := voParams;
      return(-1); exit;
    end;

    delitem(vDsLstTransacao, 1);
  until (vDsLstTransacao = '');

  if (gInLiberaTpDocumento = True) then begin
    vDsObs := 'Recebimento com tipo documento liberado pelo usuario ' + FloatToStr(gCdUsuLib') + ';
    viParams := '';
    putitemXml(viParams, 'DS_LSTTRANSACAO', gDsLstTransacao);
    putitemXml(viParams, 'CD_COMPONENTE', TRAFM066);
    putitemXml(viParams, 'DS_OBSERVACAO', vDsObs);
    voParams := activateCmp('TRASVCO016', 'gravaObsTransacao', viParams); (*,viParams,voParams,, *)
    if (xStatus < 0) then begin
      Result := voParams;
      return(-1); exit;
    end;
  end;
  if (gTpFechamentoRoyalty = 1) then begin
    viParams := '';
    putitemXml(viParams, 'DS_LSTTRANSACAO', gDsLstTransacao);
    voParams := activateCmp('ROYSVCO001', 'calculaRoyaltyFatura', viParams); (*,viParams,voParams,, *)
    if (xStatus < 0) then begin
      Result := voParams;
      return(-1); exit;
    end;
  end;
  if (gInECF    = True) then begin
    vVlDesconto := 0;
    vInFatura := False;
    clear_e(tF_TMP_K02NR10);
    setocc(tSIS_VALOR, 1);
    while (xStatus >= 0) do begin
      if (item_f('TP_DOCUMENTO', tSIS_VALOR) <> 9) then begin
        creocc(tF_TMP_K02NR10, -1);

        if (item_f('TP_DOCUMENTO', tSIS_VALOR) = 1) then begin
          putitem_e(tF_TMP_K02NR10, 'NR_CHAVE01', item_f('TP_DOCUMENTO', tSIS_VALOR));
          vInFatura := True;
        end else if (item_f('TP_DOCUMENTO', tSIS_VALOR) = 2)  or (item_f('TP_DOCUMENTO', tSIS_VALOR) = 15) then begin
          putitem_e(tF_TMP_K02NR10, 'NR_CHAVE01', item_f('TP_DOCUMENTO', tSIS_VALOR));
          vInCheque := True;
          if (item_f('TP_DOCUMENTO', tSIS_VALOR) = 15) then begin
            putitem_e(tF_TMP_K02NR10, 'NR_CHAVE01', 2);
          end;
        end else if (item_f('TP_DOCUMENTO', tSIS_VALOR) = 3) then begin
          if (gInUltimaPgtoCartaoTEF = True) then begin
            putitem_e(tF_TMP_K02NR10, 'NR_CHAVE01', item_f('TP_DOCUMENTO', tSIS_VALOR));
          end else begin

            putitem_e(tF_TMP_K02NR10, 'NR_CHAVE01', 99);
          end;
        end else if (item_f('TP_DOCUMENTO', tSIS_VALOR) = 4) then begin
          if (gInUltimaPgtoCartaoTEF = True) then begin
            putitem_e(tF_TMP_K02NR10, 'NR_CHAVE01', 97);
          end else begin
            if (gInAgrupaCartaoTEF = True) then begin
              putitem_e(tF_TMP_K02NR10, 'NR_CHAVE01', 97);
            end else begin
              putitem_e(tF_TMP_K02NR10, 'NR_CHAVE01', item_f('TP_DOCUMENTO', tSIS_VALOR));
            end;
          end;
        end else if (item_f('TP_DOCUMENTO', tSIS_VALOR) = 5) then begin
          if (gInUltimaPgtoCartaoTEF = True) then begin
            putitem_e(tF_TMP_K02NR10, 'NR_CHAVE01', 98);
          end else begin
            if (gInAgrupaCartaoTEF = True) then begin
              putitem_e(tF_TMP_K02NR10, 'NR_CHAVE01', 97);
            end else begin
              putitem_e(tF_TMP_K02NR10, 'NR_CHAVE01', item_f('TP_DOCUMENTO', tSIS_VALOR));
            end;
          end;
        end else if (item_f('TP_DOCUMENTO', tSIS_VALOR) = 10) then begin
          putitem_e(tF_TMP_K02NR10, 'NR_CHAVE01', item_f('TP_DOCUMENTO', tSIS_VALOR));
        end else if (item_f('TP_DOCUMENTO', tSIS_VALOR) = 11) then begin
          putitem_e(tF_TMP_K02NR10, 'NR_CHAVE01', item_f('TP_DOCUMENTO', tSIS_VALOR));
          vVlDesconto := vVlDesconto + item_f('VL_DOCUMENTO', tSIS_VALOR);
        end else if (item_f('TP_DOCUMENTO', tSIS_VALOR) = 12) then begin
          putitem_e(tF_TMP_K02NR10, 'NR_CHAVE01', item_f('TP_DOCUMENTO', tSIS_VALOR));
        end else if (item_f('TP_DOCUMENTO', tSIS_VALOR) = 13) then begin
          putitem_e(tF_TMP_K02NR10, 'NR_CHAVE01', item_f('TP_DOCUMENTO', tSIS_VALOR));
        end else if (item_f('TP_DOCUMENTO', tSIS_VALOR) = 14) then begin
          putitem_e(tF_TMP_K02NR10, 'NR_CHAVE01', 1);
          vInFatura := True;
        end else if (item_f('TP_DOCUMENTO', tSIS_VALOR) = 20) then begin
          putitem_e(tF_TMP_K02NR10, 'NR_CHAVE01', item_f('TP_DOCUMENTO', tSIS_VALOR));
        end else begin
          putitem_e(tF_TMP_K02NR10, 'NR_CHAVE01', 3);
        end;
        if (item_f('TP_DOCUMENTO', tSIS_VALOR) = 4 ) or (item_f('TP_DOCUMENTO', tSIS_VALOR) = 5 ) or (item_f('TP_DOCUMENTO', tSIS_VALOR) = 97 ) or (item_f('TP_DOCUMENTO', tSIS_VALOR) = 98)  and (gInTEF = True) then begin
          if (gInAgrupaCartaoTEF = True) then begin
            putitem_e(tF_TMP_K02NR10, 'NR_CHAVE02', 1);
          end else begin
            putitem_e(tF_TMP_K02NR10, 'NR_CHAVE02', itemXmlF('NR_TRANSACAOTEF', item_a('DS_ADICIONAL', tSIS_VALOR)));
          end;
        end else begin
          putitem_e(tF_TMP_K02NR10, 'NR_CHAVE02', 1);
        end;

        retrieve_o(tF_TMP_K02NR10);
        if (xStatus = 4) then begin
          retrieve_x(tF_TMP_K02NR10);
        end;
        putitem_e(tF_TMP_K02NR10, 'VL_DOCUMENTO', item_f('VL_DOCUMENTO', tF_TMP_K02NR10) + item_f('VL_DOCUMENTO', tSIS_VALOR));
      end;

      setocc(tSIS_VALOR, curocc(tSIS_VALOR) + 1);
    end;

    vDsLstFormaPgto := '';
    if (empty(tF_TMP_K02NR10) = False) then begin
      vDsFormaPgto := valrep(item_f('NR_CHAVE01', tF_TMP_K02NR10));
      sort/e(t F_TMP_K02NR10, 'NR_CHAVE01, NR_CHAVE02';);
      setocc(tF_TMP_K02NR10, 1);
      while (xStatus >= 0) do begin
        vDsRegFormaPgto := '';
        putitemXml(vDsRegFormaPgto, 'DS_FORMAPGTO', itemXml(item_f('NR_CHAVE01', tF_TMP_K02NR10), vDsFormaPgto));
        if (item_f('NR_CHAVE01', tF_TMP_K02NR10) = 4 ) or (item_f('NR_CHAVE01', tF_TMP_K02NR10) = 5 ) or (item_f('NR_CHAVE01', tF_TMP_K02NR10) = 97 ) or (item_f('NR_CHAVE01', tF_TMP_K02NR10) = 98)  and (gInAgrupaCartaoTEF = True) then begin
          putitemXml(vDsRegFormaPgto, 'DS_FORMAPGTO', 'Cartao');
        end;
        putitemXml(vDsRegFormaPgto, 'VL_FORMAPGTO', item_f('VL_DOCUMENTO', tF_TMP_K02NR10));
        putitem(vDsLstFormaPgto,  vDsRegFormaPgto);
        setocc(tF_TMP_K02NR10, curocc(tF_TMP_K02NR10) + 1);
      end;
    end;

    vDsLstFatura := '';
    vDsLstCheque := '';

    if (vInFatura = True)  or (vInCheque = True) then begin
      setocc(tSIS_VALOR, 1);
      while (xStatus >= 0) do begin
        if (item_f('TP_DOCUMENTO', tSIS_VALOR) = 1)  or (item_f('TP_DOCUMENTO', tSIS_VALOR) = 14) then begin
          vDsRegistro := '';
          putitemXml(vDsRegistro, 'NR_FATURA', item_f('NR_DOCUMENTO', tSIS_VALOR));
          putitemXml(vDsRegistro, NR_PARCELA, curocc(t'SIS_VALOR'));
          putitemXml(vDsRegistro, 'DT_VENCIMENTO', item_a('DT_VENCIMENTO', tSIS_VALOR));
          putitemXml(vDsRegistro, 'VL_FATURA', item_f('VL_DOCUMENTO', tSIS_VALOR));
          putitem(vDsLstFatura,  vDsRegistro);
        end;
        if (item_f('TP_DOCUMENTO', tSIS_VALOR) = 2)  or (item_f('TP_DOCUMENTO', tSIS_VALOR) = 15) then begin
          vDsRegistro := '';
          putitemXml(vDsRegistro, 'CD_EMPRESA', itemXmlF('CD_EMPRESA', item_a('DS_ADICIONAL', tSIS_VALOR)));
          putitemXml(vDsRegistro, 'CD_CLIENTE', itemXmlF('CD_CLIENTE', item_a('DS_ADICIONAL', tSIS_VALOR)));
          putitemXml(vDsRegistro, 'NR_BANCO', itemXmlF('NR_BANCO', item_a('DS_ADICIONAL', tSIS_VALOR)));
          putitemXml(vDsRegistro, 'NR_AGENCIA', itemXmlF('NR_AGENCIA', item_a('DS_ADICIONAL', tSIS_VALOR)));
          putitemXml(vDsRegistro, 'NR_CONTA', itemXmlF('NR_CONTA', item_a('DS_ADICIONAL', tSIS_VALOR)));
          putitemXml(vDsRegistro, 'NR_CHEQUE', itemXmlF('NR_CHEQUE', item_a('DS_ADICIONAL', tSIS_VALOR)));
          putitemXml(vDsRegistro, 'CD_EMPFAT', itemXmlF('CD_EMPRESA', item_a('DS_REGISTRO', tSIS_VALOR)));
          putitemXml(vDsRegistro, 'CD_CLIFAT', itemXmlF('CD_CLIENTE', item_a('DS_REGISTRO', tSIS_VALOR)));
          putitemXml(vDsRegistro, 'NR_FAT', itemXmlF('NR_FAT', item_a('DS_REGISTRO', tSIS_VALOR)));
          putitemXml(vDsRegistro, 'NR_PARCELA', itemXmlF('NR_PARCELA', item_a('DS_REGISTRO', tSIS_VALOR)));
          putitemXml(vDsRegistro, 'DT_VENCIMENTO', item_a('DT_VENCIMENTO', tSIS_VALOR));
          putitemXml(vDsRegistro, 'VL_FATURA', item_f('VL_DOCUMENTO', tSIS_VALOR));
          putitem(vDsLstCheque,  vDsRegistro);
        end;
        setocc(tSIS_VALOR, curocc(tSIS_VALOR) + 1);
      end;
    end;
    if (gInPDVOtimizado = False) then begin
      vDsLstNF := '';
      if (empty(tFIS_NF) = False) then begin
        setocc(tFIS_NF, 1);
        while (xStatus >= 0) do begin
          vDsRegistro := '';
          putitemXml(vDsRegistro, 'CD_EMPRESA', item_f('CD_EMPRESA', tFIS_NF));
          putitemXml(vDsRegistro, 'NR_FATURA', item_f('NR_FATURA', tFIS_NF));
          putitemXml(vDsRegistro, 'DT_FATURA', item_a('DT_FATURA', tFIS_NF));
          putitem(vDsLstNF,  vDsRegistro);
          setocc(tFIS_NF, curocc(tFIS_NF) + 1);
        end;
        setocc(tFIS_NF, 1);
      end;
      viParams := '';
      putitemXml(viParams, 'DS_LSTNF', vDsLstNF);
      putitemXml(viParams, 'IN_ESTORNO', False);

      voParams := activateCmp('FISSVCO038', 'atualizaEstoqueNF', viParams); (*,viParams,voParams,, *)

      if (xStatus < 0) then begin
        Result := voParams;
        return(-1); exit;
      end;
    end;

    vInImpressaoOK := False;
    repeat
      viParams := '';
      putitemXml(viParams, 'CD_EMPRESA', item_f('CD_EMPRESA', tTRA_TRANSACAO));
      putitemXml(viParams, 'NR_TRANSACAO', item_f('NR_TRANSACAO', tTRA_TRANSACAO));
      putitemXml(viParams, 'DT_TRANSACAO', item_a('DT_TRANSACAO', tTRA_TRANSACAO));
      putitemXml(viParams, 'DS_LSTFORMAPGTO', vDsLstFormaPgto);
      putitemXml(viParams, 'DS_LSTFATURAS', vDsLstFatura);
      putitemXml(viParams, 'VL_DESCONTO', vVlDesconto);
      putitemXml(viParams, 'CD_EMPECF', gCdEmpECF);
      putitemXml(viParams, 'NR_ECF', gNrECF);
      putitemXml(viParams, 'NR_CUPOM', gNrCupom);
      putitemXml(viParams, 'IN_TEF', gInTEF);
      putitemXml(viParams, 'DS_LSTCHEQUE', vDsLstCheque);
      if (gCdCartao > 0 ) and (gInParCartaoProprio = True) then begin
        putitemXml(viParams, 'IN_CARTAOPROPRIO', True);
      end;
      if (gVlTotBonus > 0) then begin
        putitemXml(viParams, 'IN_BONUS', True);
      end;
      putitemXml(viParams, 'IN_CONCOMITANTE', vInConcomitante);
      voParams := activateCmp('ECFSVCO010', 'encerraCupom', viParams); (*,viParams,voParams,, *)
      if (xStatus < 0) then begin
        Result := voParams;
        return(-1); exit;
      end;
        putitemXml(viParams, 'TITULO', 'Erro de comunicação com a ECF');
        putitemXml(viParams, 'MENSAGEM', itemXml('DESCRICAO', xCtxErro));
        voParams := activateCmp('GERFP008', 'EXEC', viParams); (*viParams,voParams,, *)
        if (xStatus < 0) then begin
          Result := voParams;
          return(-1); exit;
        end;
        if (gInTEF = True) then begin
          askmess 'Impressora não responde! Tentar imprimir novamente?', 'Sim, Não';
          if (xStatus = 2) then begin
            return(-1); exit;
          end;
        end else begin
          return(-1); exit;
        end;
      end else if (xStatus < 0) then begin
        Result := voParams;
        if (gInTEF = True) then begin
          askmess 'Impressora não responde! Tentar imprimir novamente?', 'Sim, Não';
          if (xStatus = 2) then begin
            return(-1); exit;
          end;
        end else begin
          return(-1); exit;
        end;
      end else if (xStatus >= 0) then begin
        vInImpressaoOK := True;
        if (gNrCupom = 0) then begin
          gNrCupom := itemXmlF('NR_CUPOM', voParams);
        end;
        gTpImpTefPAYGO := itemXmlF('TP_IMPTEFPAYGO', voParams);
      end;
    until(vInImpressaoOK := True);
    message/hint ' ';
  end;

  vTpBonus := itemXmlF('TP_BONUS_DESCONTO', xParamEmp);
  vVlBonus := itemXmlF('VL_VD_CREDITO_BONUS_DESC', xParamEmp);
  gVlDisponivel := itemXmlF('VL_CREDITO_BONUS_DESCONTO', xParamEmp);

  if (vTpBonus = 1)  and (item_f('VL_TOTAL', tSIS_DUMMY3) >= vVlBonus) then begin
    viParams := '';
    putitemXml(viParams, 'CD_PESSOA', item_f('CD_PESSOA', tTRA_TRANSACAO));
    putitemXml(viParams, 'TP_OPERACAO', 'C');
    putitemXml(viParams, 'CD_COMPONENTE', TRAFM066);
    putitemXml(viParams, 'CD_HISTORICO', 3);
    putitemXml(viParams, 'CD_EMPTRANSACAO', item_f('CD_EMPRESA', tTRA_TRANSACAO));
    putitemXml(viParams, 'DT_TRANSACAO', item_a('DT_TRANSACAO', tTRA_TRANSACAO));
    putitemXml(viParams, 'NR_TRANSACAO', item_f('NR_TRANSACAO', tTRA_TRANSACAO));
    voParams := activateCmp('PESSVCO035', 'lancaBonusDesconto', viParams); (*,viParams,voParams,, *)
    if (xStatus < 0) then begin
      Result := voParams;
      return(-1); exit;
    end;
  end;
  if (gInTEF = True) then begin
    voParams := imprimeCupomTEF(viParams); (* *)
    if (xStatus < 0) then begin
      Result := voParams;
      return(-1); exit;
    end;
        return(-1); exit;

    end else if (xStatus < 0) then begin
        return(-1); exit;

    end;
  end;
  if (gTpImpressaoTraVenda = 05) then begin
    putitemXml(viParams, 'IN_DIRETO', True);
    putitemXml(viParams, 'DS_LSTTRANSACAO', gDsLstTransacao);
    voParams := activateCmp('TRAFP004', 'EXEC', viParams); (*viParams,voParams,, *)
    if (xStatus < 0) then begin
      Result := voParams;
      return(-1); exit;
    end;
  end else if (gTpImpressaoTraVenda = 06) then begin
    putitemXml(viParams, 'IN_DIRETO', False);
    putitemXml(viParams, 'DS_LSTTRANSACAO', gDsLstTransacao);
    voParams := activateCmp('TRAFP004', 'EXEC', viParams); (*viParams,voParams,, *)
    if (xStatus < 0) then begin
      Result := voParams;
      return(-1); exit;
    end;
  end else if (gTpImpressaoTraVenda = 07 ) or (gTpImpressaoTraVenda = 08) then begin
    viParams := '';
    putitemXml(viParams, 'DS_LSTTRANSACAO', gDsLstTransacao);
    voParams := activateCmp('SISFP002', 'exec', viParams); (*'TRAR016',vDsFiltro,viParams,voParams,, *)
    if (xStatus < 0) then begin
      Result := voParams;
      return(-1); exit;
    end;
  end else if (gTpImpressaoTraVenda = 09) then begin
    viParams := '';
    putitemXml(viParams, 'DS_LSTTRANSACAO', gDsLstTransacao);
    voParams := activateCmp('SISFP002', 'exec', viParams); (*'TRAR017',vDsFiltro,viParams,voParams,, *)
    if (xStatus < 0) then begin
      Result := voParams;
      return(-1); exit;
    end;
  end;
  if (vDsLstFaturaImp <> '') then begin
    if (gTpImpressaoFatVenda > 0) then begin
      if (gTpImpressaoFatVenda <> 3)  or (gInFCRFP001 = True) then begin
        viParams := '';
        putitemXml(viParams, 'DS_LISTAFATURA', vDsLstFaturaImp);
        putitemXml(viParams, 'IN_AGRUPAR', True);
        //keyboard := 'KB_GLOBAL';
        voParams := activateCmp('FCRFP001', 'EXEC', viParams); (*viParams,voParams,, *)
        //keyboard := 'KB_PDV';
        if (xStatus < 0) then begin
          Result := voParams;
          return(-1); exit;
        end;
      end else begin
        viParams := '';

        putitemXml(viParams, 'LST_FATURA', vDsLstFaturaImp);

        //keyboard := 'KB_GLOBAL';
        voParams := activateCmp('FCRFP098', 'EXEC', viParams); (*viParams,voParams,, *)
        //keyboard := 'KB_PDV';
        if (xStatus < 0) then begin
          Result := voParams;
          return(-1); exit;
        end;
      end;
    end;
    if (gCdModeloNFPromissoria > 0) then begin
      vDsLstNF := '';
      if (empty(tFIS_NF) = False) then begin
        setocc(tFIS_NF, 1);
        while (xStatus >= 0) do begin
          vDsRegistro := '';
          putitemXml(vDsRegistro, 'CD_EMPRESA', item_f('CD_EMPRESA', tFIS_NF));
          putitemXml(vDsRegistro, 'NR_FATURA', item_f('NR_FATURA', tFIS_NF));
          putitemXml(vDsRegistro, 'DT_FATURA', item_a('DT_FATURA', tFIS_NF));
          putitem(vDsLstNF,  vDsRegistro);
          setocc(tFIS_NF, curocc(tFIS_NF) + 1);
        end;
        setocc(tFIS_NF, 1);
      end;
      viParams := '';
      putitemXml(viParams, 'DS_LSTNF', vDsLstNF);
      putitemXml(viParams, 'CD_MODELONF', gCdModeloNFPromissoria);
      putitemXml(viParams, 'IN_DIRETO', False);
      putitemXml(viParams, 'NR_FILASPOOL', gNrFilaSpool);
      voParams := activateCmp('FISFP008', 'EXEC', viParams); (*viParams,voParams,, *)
      if (xStatus < 0) then begin
        Result := voParams;
        return(-1); exit;
      end;
    end;
  end;
  if (gInECF = True) then begin
    if (gInPDVOtimizado = True) then begin
      vDsLstNF := '';
      if (empty(tFIS_NF) = False) then begin
        setocc(tFIS_NF, 1);
        while (xStatus >= 0) do begin
          vDsRegistro := '';
          putitemXml(vDsRegistro, 'CD_EMPRESA', item_f('CD_EMPRESA', tFIS_NF));
          putitemXml(vDsRegistro, 'NR_FATURA', item_f('NR_FATURA', tFIS_NF));
          putitemXml(vDsRegistro, 'DT_FATURA', item_a('DT_FATURA', tFIS_NF));
          putitem(vDsLstNF,  vDsRegistro);
          setocc(tFIS_NF, curocc(tFIS_NF) + 1);
        end;
        setocc(tFIS_NF, 1);
      end;
      viParams := '';
      putitemXml(viParams, 'DS_LSTNF', vDsLstNF);
      putitemXml(viParams, 'IN_ESTORNO', False);

      voParams := activateCmp('FISSVCO038', 'atualizaEstoqueNF', viParams); (*,viParams,voParams,, *)

      if (xStatus < 0) then begin
        Result := voParams;
        return(-1); exit;
      end;
    end;

    viParams := '';
    putitemXml(viParams, 'DS_LSTNF', vDsLstNF);
    putitemXml(viParams, 'IN_ECF', True);
    voParams := activateCmp('FISSVCO004', 'emiteNF', viParams); (*,viParams,voParams,, *)
    if (xStatus < 0) then begin
      Result := voParams;
      return(-1); exit;
    end;
  end;
  if (gCdEmpContrato > 0)  and (gNrSeqContrato > 0) then begin
    if (gInImpContratoAuto = True) then begin
      viParams := '';
      putitemXml(viParams, 'CD_EMPCONTRATO', gCdEmpContrato);
      putitemXml(viParams, 'NR_SEQCONTRATO', gNrSeqContrato);
      voParams := activateCmp('GERSVCO034', 'previewContrato', viParams); (*,viParams,voParams,, *)
      if (xStatus < 0) then begin
        Result := voParams;
        return(-1); exit;
      end;
    end;
  end;
  if (gTpImpRichTextVD = 1) then begin
    vInFatura := False;
    setocc(tSIS_VALOR, 1);
    while (xStatus >= 0) do begin
      if (item_f('TP_DOCUMENTO', tSIS_VALOR) = 1) then begin
        vInFatura := True;
      end else if (item_f('TP_DOCUMENTO', tSIS_VALOR) = 14) then begin
        vInFatura := True;
      end;
      setocc(tSIS_VALOR, curocc(tSIS_VALOR) + 1);
    end;

    gInFatura := vInFatura;
  end;

  return(0); exit;
end;

//---------------------------------------------------
function T_TRAFM066.BT_04(pParams : String) : String;
//---------------------------------------------------

var
  viParams, voParams, vDsLstParcela, vDsRegistro, vDsAdicional : String;
  vTpDocumento, vNrDocumento, vNrParcela, vNrOcc : Real;
  vInCobLoja : Boolean;
begin
  if (item_f('VL_DOCUMENTO', tSIS_VALOR) > 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', , cDS_METHOD);
    return(-1); exit;
  end;

  viParams := '';
  putitemXml(viParams, 'CD_EMPTRANSACAO', item_f('CD_EMPRESA', tTRA_TRANSACAO));
  putitemXml(viParams, 'NR_TRANSACAO', item_f('NR_TRANSACAO', tTRA_TRANSACAO));
  putitemXml(viParams, 'DT_TRANSACAO', item_a('DT_TRANSACAO', tTRA_TRANSACAO));
  putitemXml(viParams, 'NR_FATURAPADRAO', gNrFaturaPadrao);
  putitemXml(viParams, 'IN_FATURA', gInParcelaFatura);
  putitemXml(viParams, 'IN_CHEQUE', gInParcelaCheque);
  putitemXml(viParams, 'IN_NOTAPROMISSORIA', gInParcelaNotaP);
  //keyboard := 'KB_GLOBAL';
  voParams := activateCmp('TRAFM067', 'EXEC', viParams); (*viParams,voParams,, *)
  //keyboard := 'KB_PDV';

  if (xStatus < 0) then begin
    return(-1); exit;
  end;

  vDsLstParcela := itemXml('DS_LSTPARCELA', voParams);
  vTpDocumento := itemXmlF('TP_DOCUMENTO', voParams);
  vNrDocumento := itemXmlF('NR_DOCUMENTO', voParams);
  vInCobLoja := itemXmlB('IN_COBLOJA', voParams);

  vNrOcc := 0;

  if (vDsLstParcela <> '') then begin
    repeat
      getitem(vDsRegistro, vDsLstParcela, 1);

      vNrParcela := itemXmlF('NR_PARCELA', vDsRegistro);
      if (vNrParcela > 1) then begin
        creocc(tSIS_VALOR, -1);
      end;
      if (vNrOcc = 0) then begin
        vNrOcc := curocc(tSIS_VALOR);
      end;

      putitem_e(tSIS_VALOR, 'VL_DOCUMENTO', itemXmlF('VL_PARCELA', vDsRegistro));
      putitem_e(tSIS_VALOR, 'TP_DOCUMENTO', vTpDocumento);
      putitem_e(tSIS_VALOR, 'NR_DOCUMENTO', vNrDocumento);
      putitem_e(tSIS_VALOR, 'DT_VENCIMENTO', itemXml('DT_VENCIMENTO', vDsRegistro));

      if (vInCobLoja = True) then begin
        validateocc 'SIS_VALOR';
        if (xStatus < 0) then begin
          return(-1); exit;
        end;
      end;
      if (item_f('TP_DOCUMENTO', tSIS_VALOR) = 1)  or (item_f('TP_DOCUMENTO', tSIS_VALOR) = 14) then begin
        vDsAdicional := '';
        putitemXml(vDsAdicional, 'IN_COBLOJA', vInCobLoja);
        putitem_e(tSIS_VALOR, 'DS_ADICIONAL', vDsAdicional);

        if (vInCobLoja = True) then begin
          vDsAdicional := 'Cobrança na loja';
        end else begin
          vDsAdicional := '';
        end;
        putitem_e(tSIS_VALOR, 'DS_OBSERVACAO', vDsAdicional);
      end;
      delitem(vDsLstParcela, 1);
    until (vDsLstParcela = '');
  end;

  voParams := calculaPrazoMedio(viParams); (* *)
  if (xStatus < 0) then begin
    Result := voParams;
    return(-1); exit;
  end;

  voParams := calculaTotal(viParams); (* *)
  if (xStatus < 0) then begin
    Result := voParams;
    return(-1); exit;
  end;
  if (vTpDocumento = 2) then begin
    setocc(tSIS_VALOR, 1);
  end;

  gprompt := item_f('VL_DOCUMENTO', tSIS_VALOR);

  return(0); exit;
end;

//---------------------------------------------------
function T_TRAFM066.BT_05(pParams : String) : String;
//---------------------------------------------------

var
  viParams, voParams, vDsLstTransacao, vDsRegistro : String;
begin
  viParams := '';
  putitemXml(viParams, 'DS_LSTTRANSACAO', gDsLstTransacao);
  if (gTpImpressaoTraVenda = 02) then begin
    putitemXml(viParams, 'IN_DIRETO', False);
  end else begin
    putitemXml(viParams, 'IN_DIRETO', True);
  end;
  voParams := activateCmp('TRAFP004', 'EXEC', viParams); (*viParams,voParams,, *)
  if (xStatus < 0) then begin
    Result := voParams;
    return(-1); exit;
  end;

  return(0); exit;
end;

//---------------------------------------------------
function T_TRAFM066.BT_06(pParams : String) : String;
//---------------------------------------------------

var
  vDsObservacao, vDsIndice, vNrAuxiliar : String;
  vInCobLoja : Boolean;
  vCdIndice, vNrContrato, vTpUtilizacaoContrato, vNrFatura, vTpNrContrato : Real;
begin
  vTpNrContrato := itemXmlF('TP_NR_FATURA_CONTRATO', xParamEmp);

  clear_e(tSIS_VALOR);
  clear_e(tSIS_TOTAL);

  if (empty(tTRA_TRANSACAO) = False) then begin
    setocc(tTRA_TRANSACAO, 1);
    while (xStatus >= 0) do begin

      clear_e(tFIS_NF);
      putitem_e(tFIS_NF, 'TP_SITUACAO', 'N);
      retrieve_e(tFIS_NF);

      if (xStatus >= 0) then begin
        gNrFaturaPadrao := '';

        setocc(tFIS_NF, 1);
        while (xStatus >=0) do begin
          if (empty(tFIS_NFVENCTO) <> False) then begin
            Result := SetStatus(STS_ERROR, 'GEN0001', , cDS_METHOD);
            return(-1); exit;
          end;

          vNrFatura := '';

          if (gCdEmpContrato > 0)  and (gNrSeqContrato > 0) then begin
            vNrContrato := itemXmlF('NR_CONTRATO', gDsContrato);
            vNrFatura := vNrContrato;
          end;
          if (vNrFatura = 0) then begin
            vNrFatura := item_f('NR_NF', tFIS_NF);
          end;
          if (vNrFatura = 0)  and (item_f('TP_DOCTO', tGER_OPERACAO) = 0) then begin
            vNrFatura := item_f('NR_FATURA', tFIS_NF);
          end;
          if (vNrFatura = 0) then begin
            Result := SetStatus(STS_ERROR, 'GEN0001', , cDS_METHOD);
            return(-1); exit;
          end;

          setocc(tFIS_NFVENCTO, 1);
          while (xStatus >=0) do begin

            if (gCdEmpContrato > 0)  and (gNrSeqContrato > 0) then begin
              if (vTpNrContrato = 0) then begin
                vNrAuxiliar := itemXmlF('NR_CONTRATO', gDsContrato);
              end else if (vTpNrContrato = 1) then begin
                vNrAuxiliar := item_f('NR_NF', tFIS_NF);
              end else if (vTpNrContrato = 2) then begin
                vNrAuxiliar := itemXmlF('NR_CONTRATO', gDsContrato);
                vNrAuxiliar := vNrAuxiliar[1:5];
                vNrAuxiliar := '' + FloatToStr(vNrAuxiliar' + DT_VENCIMENTO) + ' + '.FIS_NFVENCTO[5:2]';
                vNrAuxiliar := '' + FloatToStr(vNrAuxiliar' + DT_VENCIMENTO) + ' + '.FIS_NFVENCTO[3:2]';
              end;
            end else begin
              vNrAuxiliar := vNrFatura;
            end;
            if (gNrFaturaPadrao = 0) then begin
              gNrFaturaPadrao := vNrAuxiliar;
            end;

            creocc(tSIS_VALOR, -1);
            putitem_e(tSIS_VALOR, 'VL_DOCUMENTO', item_f('VL_PARCELA', tFIS_NFVENCTO));
            putitem_e(tSIS_VALOR, 'TP_DOCUMENTO', 1);
            putitem_e(tSIS_VALOR, 'NR_DOCUMENTO', vNrAuxiliar);
            putitem_e(tSIS_VALOR, 'DT_VENCIMENTO', item_a('DT_VENCIMENTO', tFIS_NFVENCTO));
            putitem_e(tSIS_TOTAL, 'VL_DOCUMENTO', item_f('VL_DOCUMENTO', tSIS_TOTAL) + item_f('VL_DOCUMENTO', tSIS_VALOR));

            vCdIndice := itemXmlF('CD_INDICE', gDsContrato);
            vDsIndice := itemXmlF('CD_INDICE', gDsContrato);

            if (gCdEmpContrato > 0)  and (gNrSeqContrato > 0)  and (vCdIndice > 0) then begin
              if (item_f('TP_FORMAPGTO', tFIS_NFVENCTO) = 16) then begin
                vInCobLoja := True;
                vDsObservacao := '';
                putitemXml(vDsObservacao, 'IN_COBLOJA', vInCobLoja);
                putitem_e(tSIS_VALOR, 'DS_ADICIONAL', vDsObservacao);
                if (vInCobLoja = True) then begin
                  vDsObservacao := 'Cobrança na loja';
                  addmonths -12, item_a('DT_VENCIMENTO', tFIS_NFVENCTO);
                  gData := gresult;
                  putitemXml(item_a('DS_ADICIONAL', tSIS_VALOR), 'CD_INDICE', vCdIndice);
                  putitemXml(item_a('DS_ADICIONAL', tSIS_VALOR), 'DT_CORRECAO', gData);
                  vDsObservacao := '' + vDsObservacao + ' Dt.base Correcao: ' + gData + ' Índice : ' + FloatToStr(vCdIndice) + ' ' + vDsIndice' + ';
                end else begin
                  vDsObservacao := '';
                end;
                putitem_e(tSIS_VALOR, 'DS_OBSERVACAO', vDsObservacao);
              end else if (item_f('TP_FORMAPGTO', tFIS_NFVENCTO) = 17) then begin
                vInCobLoja := True;
                vDsObservacao := '';
                putitemXml(vDsObservacao, 'IN_COBLOJA', vInCobLoja);
                putitemXml(vDsObservacao, 'IN_AGRECEBIMENTO', True);
                putitem_e(tSIS_VALOR, 'DS_ADICIONAL', vDsObservacao);
                if (vInCobLoja = True) then begin
                  vDsObservacao := 'Cobrança na loja - Aguardando recebimento';
                  addmonths -12, item_a('DT_VENCIMENTO', tFIS_NFVENCTO);
                  gData := gresult;
                  putitemXml(item_a('DS_ADICIONAL', tSIS_VALOR), 'CD_INDICE', vCdIndice);
                  putitemXml(item_a('DS_ADICIONAL', tSIS_VALOR), 'DT_CORRECAO', gData);
                  vDsObservacao := '' + vDsObservacao + ' Dt.base Correcao: ' + gData + ' Índice : ' + FloatToStr(vCdIndice) + ' ' + vDsIndice' + ';
                end else begin
                  vDsObservacao := '';
                end;
                putitem_e(tSIS_VALOR, 'DS_OBSERVACAO', vDsObservacao);
              end else begin
                addmonths -12, item_a('DT_VENCIMENTO', tFIS_NFVENCTO);
                gData := gresult;
                putitemXml(item_a('DS_ADICIONAL', tSIS_VALOR), 'CD_INDICE', vCdIndice);
                putitemXml(item_a('DS_ADICIONAL', tSIS_VALOR), 'DT_CORRECAO', gData);
                vDsObservacao := 'Dt.base Correcao: ' + gData + ' Índice : ' + FloatToStr(vCdIndice) + ' ' + vDsIndice' + ';
                putitem_e(tSIS_VALOR, 'DS_OBSERVACAO', vDsObservacao);
              end;
            end;
            setocc(tFIS_NFVENCTO, curocc(tFIS_NFVENCTO) + 1);
          end;
          setocc(tFIS_NF, curocc(tFIS_NF) + 1);
        end;
      end;
      setocc(tTRA_TRANSACAO, curocc(tTRA_TRANSACAO) + 1);
    end;
  end;

  voParams := calculaPrazoMedio(viParams); (* *)
  if (xStatus < 0) then begin
    Result := voParams;
    return(-1); exit;
  end;

  voParams := calculaTotal(viParams); (* *)
  if (xStatus < 0) then begin
    Result := voParams;
    return(-1); exit;
  end;

  setocc(tTRA_TRANSACAO, 1);

  return(0); exit;
end;

//---------------------------------------------------
function T_TRAFM066.BT_07(pParams : String) : String;
//---------------------------------------------------

var
  vInDescontoPromocional : Boolean;
begin
  voParams := validaTransacao(viParams); (* *)
  if (xStatus < 0) then begin
    setocc(tSIS_VALOR, 1);
    gprompt := item_f('VL_DOCUMENTO', tSIS_VALOR);
    return(-1); exit;
  end;
  voParams := validaRecebimento(viParams); (* *)
  if (xStatus < 0) then begin
    setocc(tSIS_VALOR, 1);
    gprompt := item_f('VL_DOCUMENTO', tSIS_VALOR);
    return(-1); exit;
  end;

  vInDescontoPromocional := True;

  if (item_f('TP_DOCTO', tGER_OPERACAO) = 2) then begin
    if (gInDesF7 = True) then begin
      vInDescontoPromocional := False;

    end else if (gInPDVOtimizado = True)  and (gInTEF = True) then begin
        vInDescontoPromocional := False;
    end else if (gvInTefCartao = True) then begin
      if (gvInDescPromocionalCartao = 01) then begin
        vInDescontoPromocional := True;
      end else begin
        vInDescontoPromocional := False;
      end;
    end;
  end;
  if (vInDescontoPromocional = True) then begin
    voParams := descontoPromocional(viParams); (* *)
    if (xStatus < 0) then begin
      gInErroRecebimento := True;
      macro '^QUIT';
    end;
    voParams := carregaTransacao(viParams); (* *)
    if (xStatus < 0) then begin
      gInErroRecebimento := True;
      macro '^QUIT';
    end;
    voParams := carregaCaixa(viParams); (* *)
    if (xStatus < 0) then begin
      gInErroRecebimento := True;
      macro '^QUIT';
    end;
  end;

  voParams := gravaRecebimento(viParams); (* *)
  if (xStatus < 0) then begin
    Result := voParams;
    return(-1); exit;
  end;
  if (xStatus = -2) then begin
    if (item_f('VL_TROCO', tSIS_DUMMY3) > 0) then begin
      setocc(tSIS_VALOR, 1);
      if (item_f('TP_DOCUMENTO', tSIS_VALOR) = 9) then begin
        discard 'SIS_VALOR';
      end;
    end;
    setocc(tSIS_VALOR, 1);
    gprompt := item_f('VL_DOCUMENTO', tSIS_VALOR);
    return(-1); exit;
  end else if (xStatus = -3) then begin
    macro '^CLEAR';
    return(-1); exit;
  end;
  if (xStatus < 0) then begin
    gInErroRecebimento := True;
    macro '^QUIT';
  end;

  macro '^ACCEPT';

  return(0); exit;
end;

//---------------------------------------------------
function T_TRAFM066.BT_08(pParams : String) : String;
//---------------------------------------------------

var
  vNrSeqTransacaoTef : Real;
begin
  if (gTpSimuladorFat = 1) then begin
    return(-1); exit;
  end;
  if (gInTroca = True) then begin
    if (item_f('TP_DOCUMENTO', tSIS_VALOR) = 20) then begin
      return(-1); exit;
    end;
  end;

  gVlAnterior := item_f('VL_DOCUMENTO', tSIS_VALOR);

  if (item_f('VL_DOCUMENTO', tSIS_VALOR) > 0) then begin
    if (item_f('TP_DOCUMENTO', tSIS_VALOR) = 12) then begin
      creocc(tFCR_DOFNI, -1);
      putitem_e(tFCR_DOFNI, 'NR_DOFNI', item_f('NR_DOCUMENTO', tSIS_VALOR));
      retrieve_o(tFCR_DOFNI);
      if (xStatus = 4) then begin
        discard 'FCR_DOFNI';
      end else begin
        Result := SetStatus(STS_ERROR, 'GEN0001', , cDS_METHOD);
        return(-1); exit;
      end;
    end;
    if (gInTEF = True) then begin
      vNrSeqTransacaoTef := itemXmlF('NR_TRANSACAOTEF', item_a('DS_ADICIONAL', tSIS_VALOR));
      if (vNrSeqTransacaoTef = '') then begin
        vNrSeqTransacaoTef := 0;
      end;
      if (vNrSeqTransacaoTef > 0) then begin
        return(-1); exit;
      end;
    end;

    askmess 'Deseja realmente remover o registro?', 'Remover, Cancelar';
    if (xStatus = 1) then begin
      remocc(tSIS_VALOR);
    end else begin
      return(-1); exit;
    end;
  end else begin
    remocc(tSIS_VALOR);
  end;

  putitem_e(tSIS_TOTAL, 'VL_DOCUMENTO', item_f('VL_DOCUMENTO', tSIS_TOTAL) - gVlAnterior);

  voParams := calculaPrazoMedio(viParams); (* *)
  if (xStatus < 0) then begin
    Result := voParams;
    return(-1); exit;
  end;

  voParams := calculaTotal(viParams); (* *)
  if (xStatus < 0) then begin
    Result := voParams;
    return(-1); exit;
  end;

  return(0); exit;
end;

//---------------------------------------------------
function T_TRAFM066.BT_09(pParams : String) : String;
//---------------------------------------------------

var
  viParams, voParams, vDsLstCheque, vDsRegistro, vDsLstFatura, vDsAdicional : String;
  vInChequeBanda, vInLiberaTpDocumento : Boolean;
  vPosOcc : Real;
begin
  viParams := '';
  putitemXml(viParams, 'CD_EMPRESA', item_f('CD_EMPRESA', tTRA_TRANSACAO));
  putitemXml(viParams, 'NR_TRANSACAO', item_f('NR_TRANSACAO', tTRA_TRANSACAO));
  putitemXml(viParams, 'DT_TRANSACAO', item_a('DT_TRANSACAO', tTRA_TRANSACAO));
  putitemXml(viParams, 'IN_ECF', gInECF);
  if (empty(tSIS_VALOR) = False) then begin
    vDsLstFatura := '';
    vPosOcc := curocc(tSIS_VALOR);
    setocc(tSIS_VALOR, 1);
    while (xStatus >= 0) do begin
      if (item_f('TP_DOCUMENTO', tSIS_VALOR) = 1) then begin
        putitemXml(item_a('DS_ADICIONAL', tSIS_VALOR), NR_POSOCC, curocc(t'SIS_VALOR'));
        vDsRegistro := '';
        putlistitensocc_e(vDsRegistro, tSIS_VALOR);
        putitem(vDsLstFatura,  vDsRegistro);
      end;
      setocc(tSIS_VALOR, curocc(tSIS_VALOR) + 1);
    end;
    setocc(tSIS_VALOR, 1);
    putitemXml(viParams, 'DS_LSTFATURA', vDsLstFatura);
  end;
  if (empty(tSIS_VALOR) <> False) then begin
    putitemXml(viParams, 'DS_LSTTPDOCUMENTO', gDsLstTpDocumento);
  end;
  //keyboard := 'KB_GLOBAL';
  voParams := activateCmp('TRAFP012', 'EXEC', viParams); (*viParams,voParams,, *)
  //keyboard := 'KB_PDV';

  if (xStatus < 0) then begin
    return(-1); exit;
  end;
  if (itemXml('IN_DESCPROMOCAO', voParams) = True ) and (itemXmlB('IN_IMPRIMI_ECF_NFP', xParamEmp) = 1) then begin
    gIndesF7 := True;
  end;

  vInChequeBanda := itemXmlB('IN_CHEQUEBANDA', voParams);
  vInLiberaTpDocumento := itemXmlB('IN_LIBERATPDOCUMENTO', voParams);

  if (vInChequeBanda = True) then begin
    vDsLstCheque := itemXml('DS_LSTCHEQUE', voParams);
    voParams := incluiChequeBanda(viParams); (* vDsLstCheque *)
    if (xStatus < 0) then begin
      Result := voParams;
      return(-1); exit;
    end;
  end else if (vInLiberaTpDocumento = True) then begin
    gInLiberaTpDocumento := True;
    gDsLstTpDocumento := itemXml('DS_LSTTPDOCUMENTO', voParams);
    gCdUsuLib := itemXmlF('CD_USULIB', voParams);
    voParams := carregaTipoDocumento(viParams); (* *)
    if (xStatus < 0) then begin
      Result := voParams;
      return(-1); exit;
    end;
  end;

  vDsLstFatura := '';
  vDsLstFatura := itemXml('DS_LSTFATURA', voParams);
  if (vDsLstFatura <> '') then begin
    vPosOcc := curocc(tSIS_VALOR);
    setocc(tSIS_VALOR, 1);
    while (xStatus >= 0) do begin
      if (item_f('TP_DOCUMENTO', tSIS_VALOR) = 1) then begin
        repeat
          vDsRegistro := '';
          getitem(vDsRegistro, vDsLstFatura, 1);
          vDsAdicional := '';
          vDsAdicional := itemXml('DS_ADICIONAL', vDsRegistro);
          if (itemXml(NR_POSOCC, vDsAdicional) = curocc(t'SIS_VALOR')) then begin
            getlistitensocc_e(vDsRegistro, tSIS_VALOR);
            validateocc 'SIS_VALOR';
            if (xStatus < 0) then begin
              return(-1); exit;
            end;
            putitem_e(tSIS_VALOR, 'DS_ADICIONAL', itemXml('DS_ADICIONAL', vDsRegistro));
            putitem_e(tSIS_VALOR, 'DS_OBSERVACAO', itemXml('DS_OBSERVACAO', vDsRegistro));
            delitem(item_a('DS_ADICIONAL', tSIS_VALOR), 'NR_POSOCC');
          end;

          delitem(vDsLstFatura, 1);
        until (vDsLstFatura = '');
        vDsLstFatura := itemXml('DS_LSTFATURA', voParams);
      end;
      setocc(tSIS_VALOR, curocc(tSIS_VALOR) + 1);
    end;
    setocc(tSIS_VALOR, 1);
  end;

  gprompt := item_f('VL_DOCUMENTO', tSIS_VALOR);

  return(0); exit;
end;

//---------------------------------------------------
function T_TRAFM066.BT_03(pParams : String) : String;
//---------------------------------------------------

var
  viParams, voParams, vDsLstValor, vDsRegistro : String;
  vVlRecebido : Real;
begin
  vDsLstValor := '';

  vDsRegistro := '';
  putitemXml(vDsRegistro, 'DS_VALOR', 'Valor troco');
  putitemXml(vDsRegistro, 'VL_VALOR', item_f('VL_TROCO', tSIS_DUMMY3));
  putitem(vDsLstValor,  vDsRegistro);

  vDsRegistro := '';
  putitemXml(vDsRegistro, 'DS_VALOR', 'Valor restante');
  putitemXml(vDsRegistro, 'VL_VALOR', item_f('VL_RESTANTE', tSIS_DUMMY3));
  putitem(vDsLstValor,  vDsRegistro);

  vDsRegistro := '';
  putitemXml(vDsRegistro, 'DS_VALOR', 'Valor venda');
  putitemXml(vDsRegistro, 'VL_VALOR', item_f('VL_TOTAL', tSIS_DUMMY3));
  putitem(vDsLstValor,  vDsRegistro);

  vVlRecebido := item_f('VL_TOTAL', tSIS_DUMMY3) + item_f('VL_TROCO', tSIS_DUMMY3) - item_f('VL_RESTANTE', tSIS_DUMMY3);

  vDsRegistro := '';
  putitemXml(vDsRegistro, 'DS_VALOR', 'Valor recebido');
  putitemXml(vDsRegistro, 'VL_VALOR', vVlRecebido);
  putitem(vDsLstValor,  vDsRegistro);

  viParams := '';
  putitemXml(viParams, 'DT_COTACAO', itemXml('DT_SISTEMA', PARAM_GLB));
  putitemXml(viParams, 'DS_LSTVALOR', vDsLstValor);
  //keyboard := 'KB_GLOBAL';
  voParams := activateCmp('GERFL069', 'EXEC', viParams); (*viParams,voParams,, *)
  //keyboard := 'KB_PDV';
  if (xStatus < 0) then begin
    return(-1); exit;
  end;

  return(0); exit;
end;

//-----------------------------------------------------
function T_TRAFM066.CTRL_09(pParams : String) : String;
//-----------------------------------------------------

var
  viParams, voParams, vDsLstCheque, vDsRegistro, vDsLstFatura, vDsAdicional, vDsLstTransacao : String;
  vInChequeBanda, vInLiberaTpDocumento : Boolean;
  vPosOcc, vCdEmpresa, vNrTransacao : Real;
  vDtTransacao : TDate;
begin
  viParams := '';
  putitemXml(viParams, 'DS_LSTTRANSACAO', gDsLstTransacao);
  putitemXml(viParams, 'CD_EMPRESA', item_f('CD_EMPRESA', tTRA_TRANSACAO));
  putitemXml(viParams, 'NR_TRANSACAO', item_f('NR_TRANSACAO', tTRA_TRANSACAO));
  putitemXml(viParams, 'DT_TRANSACAO', item_a('DT_TRANSACAO', tTRA_TRANSACAO));
  //keyboard := 'KB_GLOBAL';
  voParams := activateCmp('TRAFP039', 'EXEC', viParams); (*viParams,voParams,, *)
  //keyboard := 'KB_PDV';
  if (xStatus < 0) then begin
    return(-1); exit;
  end;

  gCdPessoa := 0;

  clear_e(tTRA_TRANSACAO);
  vDsLstTransacao := gDsLstTransacao;
  repeat
    getitem(vDsRegistro, vDsLstTransacao, 1);

    vCdEmpresa := itemXmlF('CD_EMPRESA', vDsRegistro);
    vNrTransacao := itemXmlF('NR_TRANSACAO', vDsRegistro);
    vDtTransacao := itemXml('DT_TRANSACAO', vDsRegistro);

    creocc(tTRA_TRANSACAO, -1);
    putitem_e(tTRA_TRANSACAO, 'CD_EMPRESA', vCdEmpresa);
    putitem_e(tTRA_TRANSACAO, 'NR_TRANSACAO', vNrTransacao);
    putitem_e(tTRA_TRANSACAO, 'DT_TRANSACAO', vDtTransacao);
    retrieve_o(tTRA_TRANSACAO);
    if (xStatus = -7) then begin
      retrieve_x(tTRA_TRANSACAO);
    end;
    if (gCdPessoa = 0) then begin
      gCdPessoa := item_f('CD_PESSOA', tTRA_TRANSACAO);
    end;

    delitem(vDsLstTransacao, 1);
  until (vDsLstTransacao = '');

  gprompt := item_f('VL_DOCUMENTO', tSIS_VALOR);

  return(0); exit;
end;

//---------------------------------------------------
function T_TRAFM066.BT_11(pParams : String) : String;
//---------------------------------------------------

var
  vDsLstTransacao, vDsLstNF, vDsRegistro, viParams, voParams : String;
begin
  if (itemXml('IN_LOG_TEMPO_VendA', PARAM_GLB) = 1) then begin
    gHrInicio := gclock;
    gHrTotal := gHrInicio;
    putmess 'TRAFM066: BT_11 - Inicio F11 : ' + gHrInicio' + ';
  end;

  gTpImpressaoTEF := itemXmlF('TP_IMPRESSAO_TEF', xParamEmp);

  voParams := validaTransacao(viParams); (* *)
  if (xStatus < 0) then begin
    setocc(tSIS_VALOR, 1);
    gprompt := item_f('VL_DOCUMENTO', tSIS_VALOR);
    return(-1); exit;
  end;
  if (gInFinanceiro = True)  and (item_f('VL_TOTAL', tSIS_DUMMY3) = 0) then begin
    vDsLstTransacao := '';
    vDsRegistro := '';
    putitemXml(vDsRegistro, 'CD_EMPRESA', item_f('CD_EMPRESA', tTRA_TRANSACAO));
    putitemXml(vDsRegistro, 'NR_TRANSACAO', item_f('NR_TRANSACAO', tTRA_TRANSACAO));
    putitemXml(vDsRegistro, 'DT_TRANSACAO', item_a('DT_TRANSACAO', tTRA_TRANSACAO));
    putitem(vDsLstTransacao,  vDsRegistro);
    viParams := '';
    putitemXml(viParams, 'DS_LSTTRANSACAO', vDsLstTransacao);
    putitemXml(viParams, 'TP_SITUACAO', 4);
    putitemXml(viParams, 'CD_COMPONENTE', TRAFM066);
    voParams := activateCmp('TRASVCO004', 'alteraSituacaoTransacao', viParams); (*,viParams,voParams,, *)
    if (xStatus < 0) then begin
      Result := voParams;
      return(-1); exit;
    end;

    macro '^ACCEPT';
  end;

  voParams := validaRecebimento(viParams); (* *)
  if (xStatus < 0) then begin
    setocc(tSIS_VALOR, 1);
    gprompt := item_f('VL_DOCUMENTO', tSIS_VALOR);
    return(-1); exit;
  end;
  if (itemXml('IN_LOG_TEMPO_VendA', PARAM_GLB) = 1) then begin
    gHrInicio := gclock;
    putmess 'TRAFM066: BT_11 - Inicio grava recebimento : ' + gHrInicio' + ';
  end;
  voParams := gravaRecebimento(viParams); (* *)
  if (xStatus < 0) then begin
    Result := voParams;
    return(-1); exit;
  end;
  if (itemXml('IN_LOG_TEMPO_VendA', PARAM_GLB) = 1) then begin
    gHrFim := gclock;
    putmess 'TRAFM066: BT_11 - Fim grava recebimento : ' + gHrInicio' + ';
  end;
  if (xStatus = -2) then begin
    if (item_f('VL_TROCO', tSIS_DUMMY3) > 0) then begin
      setocc(tSIS_VALOR, 1);
      if (item_f('TP_DOCUMENTO', tSIS_VALOR) = 9) then begin
        discard 'SIS_VALOR';
      end;
    end;
    setocc(tSIS_VALOR, 1);
    gprompt := item_f('VL_DOCUMENTO', tSIS_VALOR);
    return(-1); exit;
  end else if (xStatus = -3) then begin
    macro '^CLEAR';
    return(-1); exit;
  end;
  if (xStatus < 0) then begin
    gInErroRecebimento := True;
    macro '^QUIT';
  end;

  voParams := geraNFe(viParams); (* *)
  if (xStatus < 0) then begin
    Result := voParams;
    return(-1); exit;
  end;

  voParams := imprimirCupomPresente(viParams); (* item_f('CD_EMPRESA', tTRA_TRANSACAO), item_f('NR_TRANSACAO', tTRA_TRANSACAO), item_a('DT_TRANSACAO', tTRA_TRANSACAO), gNrCupom *)
  if (xStatus < 0) then begin
    Result := voParams;
    return(-1); exit;
  end;
  if (itemXml('IN_LOG_TEMPO_VendA', PARAM_GLB) = 1) then begin
    gHrFim := gclock;
    gHrTotal := gHrFim - gHrTotal;
    putmess 'TRAFM066: BT_11 - Fim F11: ' + gHrFim + ' tempo total ' + gHrTotal' + ';
  end;

  macro '^ACCEPT';

  return(0); exit;
end;

//---------------------------------------------------
function T_TRAFM066.BT_12(pParams : String) : String;
//---------------------------------------------------

var
  viParams, voParams, vDsAdicional, vDsBanda, vDsRegistro, vDsLstParcela : String;
  vNrTelefone, vCpfCnpj, vDsLstDOFNI, vDsConta : String;
  vNrBanco, vNrAgencia, vNrCheque, vNrParcela, vCdCliente, vCdEmpresa, vVlSoma, vNrDocumentoChequePresente : Real;
  vNrSeqHistRelSub, vNrDocumento, vNrDOFNI, vTpDocumento, vVlCheque, vCdAutorizacao : Real;
  vDtVencimento, vDtCheque : TDate;
  vInCobLoja, vInTerceiro : Boolean;
begin
  if (item_f('TP_DOCUMENTO', tSIS_VALOR) = 1)  or (item_f('TP_DOCUMENTO', tSIS_VALOR) = 14) then begin
    vInCobLoja := itemXmlB('IN_COBLOJA', item_a('DS_ADICIONAL', tSIS_VALOR));

    viParams := '';
    putitemXml(viParams, 'IN_COBLOJA', vInCobLoja);
    //keyboard := 'KB_GLOBAL';
    voParams := activateCmp('FGRFM007', 'EXEC', viParams); (*viParams,voParams,, *)
    //keyboard := 'KB_PDV';

    if (xStatus < 0) then begin
      return(-1); exit;
    end;

    vInCobLoja := itemXmlB('IN_COBLOJA', voParams);

    vDsAdicional := '';
    putitemXml(vDsAdicional, 'IN_COBLOJA', vInCobLoja);
    putitem_e(tSIS_VALOR, 'DS_ADICIONAL', vDsAdicional);

    if (vInCobLoja = True) then begin
      vDsAdicional := 'Cobrança na loja';
    end else begin
      vDsAdicional := '';
    end;
    putitem_e(tSIS_VALOR, 'DS_OBSERVACAO', vDsAdicional);

  end else if (item_f('TP_DOCUMENTO', tSIS_VALOR) = 2)  or (item_f('TP_DOCUMENTO', tSIS_VALOR) = 15)  or (gTpTEF = 2 ) and (item_f('TP_DOCUMENTO', tSIS_VALOR) = 8) then begin
    vNrBanco := itemXmlF('NR_BANCO', item_a('DS_ADICIONAL', tSIS_VALOR));
    vNrAgencia := itemXmlF('NR_AGENCIA', item_a('DS_ADICIONAL', tSIS_VALOR));
    vDsConta := itemXmlF('NR_CONTA', item_a('DS_ADICIONAL', tSIS_VALOR));
    vNrCheque := itemXmlF('NR_CHEQUE', item_a('DS_ADICIONAL', tSIS_VALOR));
    vDsBanda := itemXmlF('NR_BANDA', item_a('DS_ADICIONAL', tSIS_VALOR));
    vCpfCnpj := itemXmlF('NR_CPFCNPJ', item_a('DS_ADICIONAL', tSIS_VALOR));
    vNrTelefone := itemXmlF('NR_TELEFONE', item_a('DS_ADICIONAL', tSIS_VALOR));

    vInTerceiro := itemXmlB('IN_TERCEIRO', item_a('DS_ADICIONAL', tSIS_VALOR));

    viParams := '';
    putitemXml(viParams, 'CD_CLIENTE', item_f('CD_PESSOA', tTRA_TRANSACAO));
    putitemXml(viParams, 'VL_CHEQUE', item_f('VL_DOCUMENTO', tSIS_VALOR));
    putitemXml(viParams, 'NR_BANCO', vNrBanco);
    putitemXml(viParams, 'NR_AGENCIA', vNrAgencia);
    putitemXml(viParams, 'NR_CONTA', vDsConta);
    putitemXml(viParams, 'NR_CHEQUE', vNrCheque);
    putitemXml(viParams, 'NR_BANDA', vDsBanda);
    putitemXml(viParams, 'DT_VENCIMENTO', item_a('DT_VENCIMENTO', tSIS_VALOR));
    putitemXml(viParams, 'NR_CPFCNPJ', vCpfCnpj);
    putitemXml(viParams, 'NR_TELEFONE', vNrTelefone);
      putitemXml(viParams, 'NR_ULTIMOBANCO', gNrUltimoBanco);
      putitemXml(viParams, 'NR_ULTIMAAGENCIA', gNrUltimaAgencia);
      putitemXml(viParams, 'DS_ULTIMACONTA', gDsUltimaConta);
      putitemXml(viParams, 'NR_ULTIMOCHEQUE', gNrUltimoCheque);
    putitemXml(viParams, 'IN_TERCEIRO', vInTerceiro);
    putitemXml(viParams, 'IN_VALIDACHEQUE', True);

    if (gInVendaChqClienteBloq = True) then begin
      putitemXml(viParams, 'IN_RECEBIMENTO', True);
    end;

    //keyboard := 'KB_GLOBAL';
    voParams := activateCmp('FGRFM001', 'EXEC', viParams); (*viParams,voParams,, *)
    //keyboard := 'KB_PDV';

    if (xStatus < 0) then begin
      return(-1); exit;
    end;

    vCdCliente := itemXmlF('CD_CLIENTE', voParams);
    vNrBanco := itemXmlF('NR_BANCO', voParams);
    vNrAgencia := itemXmlF('NR_AGENCIA', voParams);
    vDsConta := itemXmlF('NR_CONTA', voParams);
    vNrCheque := itemXmlF('NR_CHEQUE', voParams);
    vDsBanda := itemXmlF('NR_BANDA', voParams);
    vDtVencimento := itemXml('DT_VENCIMENTO', voParams);
    vCpfCnpj := itemXmlF('NR_CPFCNPJ', voParams);
    vNrTelefone := itemXmlF('NR_TELEFONE', voParams);

    if (vNrBanco > 0) then begin
      gNrUltimoBanco := vNrBanco;
    end;
    if (vNrAgencia > 0) then begin
      gNrUltimaAgencia := vNrAgencia;
    end;
    if (vDsConta <> '') then begin
      gDsUltimaConta := vDsConta;
    end;
    if (vNrCheque > 0) then begin
      gNrUltimoCheque := vNrCheque;
    end;

    vInTerceiro := itemXmlB('IN_TERCEIRO', voParams);

    vDsAdicional := '';
    putitemXml(vDsAdicional, 'CD_CLIENTE', vCdCliente);
    putitemXml(vDsAdicional, 'NR_BANCO', vNrBanco);
    putitemXml(vDsAdicional, 'NR_AGENCIA', vNrAgencia);
    putitemXml(vDsAdicional, 'NR_CONTA', vDsConta);
    putitemXml(vDsAdicional, 'NR_CHEQUE', vNrCheque);
    putitemXml(vDsAdicional, 'NR_BANDA', vDsBanda);
    putitemXml(vDsAdicional, 'NR_CPFCNPJ', vCpfCnpj);
    putitemXml(vDsAdicional, 'NR_TELEFONE', vNrTelefone);
    putitemXml(vDsAdicional, 'IN_TERCEIRO', vInTerceiro);
    putitem_e(tSIS_VALOR, 'DS_ADICIONAL', vDsAdicional);

    vDsAdicional := 'Cliente: ' + FloatToStr(vCdCliente) + ' / Banco: ' + FloatToStr(vNrBanco) + ' / Agência: ' + FloatToStr(vNrAgencia) + ' / Conta: ' + vDsConta + ' Nr. cheque: ' + FloatToStr(vNrCheque') + ';
    putitem_e(tSIS_VALOR, 'DS_OBSERVACAO', vDsAdicional);
    putitem_e(tSIS_VALOR, 'NR_DOCUMENTO', vNrCheque);
    putitem_e(tSIS_VALOR, 'DT_VENCIMENTO', vDtVencimento);

    voParams := calculaPrazoMedio(viParams); (* *)
    if (xStatus < 0) then begin
      Result := voParams;
      return(-1); exit;
    end;
  end else if (item_f('TP_DOCUMENTO', tSIS_VALOR) = 4) then begin
    viParams := '';
    putitemXml(viParams, 'VL_DOCUMENTO', item_f('VL_DOCUMENTO', tSIS_VALOR));
    putitemXml(viParams, 'TP_ARREDONDAMENTO', 1);
    putitemXml(viParams, 'CD_CARTAO', gCdCartao);
    //keyboard := 'KB_GLOBAL';
    voParams := activateCmp('FGRFM003', 'EXEC', viParams); (*viParams,voParams,, *)
    //keyboard := 'KB_PDV';

    if (xStatus < 0) then begin
      return(-1); exit;
    end;

    vNrSeqHistRelSub := itemXmlF('NR_SEQHISTRELSUB', voParams);
    vNrDocumento := itemXmlF('NR_DOCUMENTO', voParams);
    vDsLstParcela := itemXml('DS_LSTPARCELA', voParams);

    vCdAutorizacao := itemXmlF('CD_AUTORIZACAO', voParams);

    if (vNrSeqHistRelSub = 0) then begin
      Result := SetStatus(STS_ERROR, 'GEN0001', , cDS_METHOD);
      return(-1); exit;
    end;

    clear_e(tFCX_HISTRELSUB);
    putitem_e(tFCX_HISTRELSUB, 'TP_DOCUMENTO', 4);
    putitem_e(tFCX_HISTRELSUB, 'NR_SEQHISTRELSUB', vNrSeqHistRelSub);
    retrieve_e(tFCX_HISTRELSUB);
    if (xStatus < 0) then begin
      Result := SetStatus(STS_ERROR, 'GEN0001', , cDS_METHOD);
      return(-1); exit;
    end;
    if (vDsLstParcela <> '') then begin
      repeat
        getitem(vDsRegistro, vDsLstParcela, 1);
        vNrParcela := itemXmlF('NR_PARCELA', vDsRegistro);
        if (vNrParcela > 1) then begin
          creocc(tSIS_VALOR, -1);
        end;
        putitem_e(tSIS_VALOR, 'VL_DOCUMENTO', itemXmlF('VL_PARCELA', vDsRegistro));
        putitem_e(tSIS_VALOR, 'TP_DOCUMENTO', 4);
        putitem_e(tSIS_VALOR, 'NR_DOCUMENTO', vNrDocumento);
        putitem_e(tSIS_VALOR, 'DT_VENCIMENTO', itemXml('DT_VENCIMENTO', vDsRegistro));
        vDsAdicional := '';
        putitemXml(vDsAdicional, 'NR_SEQHISTRELSUB', vNrSeqHistRelSub);
        putitemXml(vDsAdicional, 'CD_AUTORIZACAO', vCdAutorizacao);
        putitem_e(tSIS_VALOR, 'DS_ADICIONAL', vDsAdicional);
        vDsAdicional := 'Operadora: ' + NR_PORTADOR + '.FCX_HISTRELSUB - ' + DS_PORTADOR + '.FGR_PORTADOR / ' + DS_HISTRELSUB + '.FCX_HISTRELSUB';
        putitem_e(tSIS_VALOR, 'DS_OBSERVACAO', vDsAdicional);
        delitem(vDsLstParcela, 1);
      until (vDsLstParcela = '');
    end;
  end else if (item_f('TP_DOCUMENTO', tSIS_VALOR) >= 40000 ) and (item_f('TP_DOCUMENTO', tSIS_VALOR) < 49999) then begin
    vTpDocumento := item_f('TP_DOCUMENTO', tSIS_VALOR);
    vNrSeqHistRelSub := item_f('TP_DOCUMENTO', tSIS_VALOR) - 40000;

    viParams := '';
    putitemXml(viParams, 'VL_DOCUMENTO', item_f('VL_DOCUMENTO', tSIS_VALOR));
    putitemXml(viParams, 'TP_ARREDONDAMENTO', 1);
    putitemXml(viParams, 'NR_SEQHISTRELSUB', vNrSeqHistRelSub);
    putitemXml(viParams, 'IN_DIRETO', True);
    //keyboard := 'KB_GLOBAL';
    voParams := activateCmp('FGRFM003', 'EXEC', viParams); (*viParams,voParams,, *)
    //keyboard := 'KB_PDV';

    if (xStatus < 0) then begin
      return(-1); exit;
    end;

    vNrDocumento := itemXmlF('NR_DOCUMENTO', voParams);
    vDsLstParcela := itemXml('DS_LSTPARCELA', voParams);

    vCdAutorizacao := itemXmlF('CD_AUTORIZACAO', voParams);

    clear_e(tFCX_HISTRELSUB);
    putitem_e(tFCX_HISTRELSUB, 'TP_DOCUMENTO', 4);
    putitem_e(tFCX_HISTRELSUB, 'NR_SEQHISTRELSUB', vNrSeqHistRelSub);
    retrieve_e(tFCX_HISTRELSUB);
    if (xStatus < 0) then begin
      Result := SetStatus(STS_ERROR, 'GEN0001', , cDS_METHOD);
      return(-1); exit;
    end;
    if (vDsLstParcela <> '') then begin
      repeat
        getitem(vDsRegistro, vDsLstParcela, 1);
        vNrParcela := itemXmlF('NR_PARCELA', vDsRegistro);
        if (vNrParcela > 1) then begin
          creocc(tSIS_VALOR, -1);
        end;
        putitem_e(tSIS_VALOR, 'VL_DOCUMENTO', itemXmlF('VL_PARCELA', vDsRegistro));
        putitem_e(tSIS_VALOR, 'TP_DOCUMENTO', 4);
        putitem_e(tSIS_VALOR, 'NR_DOCUMENTO', vNrDocumento);
        putitem_e(tSIS_VALOR, 'DT_VENCIMENTO', itemXml('DT_VENCIMENTO', vDsRegistro));
        vDsAdicional := '';
        putitemXml(vDsAdicional, 'NR_SEQHISTRELSUB', vNrSeqHistRelSub);
        putitemXml(vDsAdicional, 'CD_AUTORIZACAO', vCdAutorizacao);
        putitem_e(tSIS_VALOR, 'DS_ADICIONAL', vDsAdicional);
        vDsAdicional := 'Operadora: ' + NR_PORTADOR + '.FCX_HISTRELSUB - ' + DS_PORTADOR + '.FGR_PORTADOR / ' + DS_HISTRELSUB + '.FCX_HISTRELSUB';
        putitem_e(tSIS_VALOR, 'DS_OBSERVACAO', vDsAdicional);
        delitem(vDsLstParcela, 1);
      until (vDsLstParcela = '');
    end;
  end else if (item_f('TP_DOCUMENTO', tSIS_VALOR) = 5) then begin
    vNrSeqHistRelSub := itemXmlF('NR_SEQHISTRELSUB', item_a('DS_ADICIONAL', tSIS_VALOR));

    viParams := '';
    putitemXml(viParams, 'NR_SEQHISTRELSUB', vNrSeqHistRelSub);
    putitemXml(viParams, 'NR_DOCUMENTO', item_f('NR_DOCUMENTO', tSIS_VALOR));
    //keyboard := 'KB_GLOBAL';
    voParams := activateCmp('FGRFM002', 'EXEC', viParams); (*viParams,voParams,, *)
    //keyboard := 'KB_PDV';

    if (xStatus < 0) then begin
      return(-1); exit;
    end;

    vNrSeqHistRelSub := itemXmlF('NR_SEQHISTRELSUB', voParams);

    vCdAutorizacao := itemXmlF('CD_AUTORIZACAO', voParams);

    putitem_e(tSIS_VALOR, 'TP_DOCUMENTO', 5);
    putitem_e(tSIS_VALOR, 'NR_DOCUMENTO', itemXmlF('NR_DOCUMENTO', voParams));
    putitem_e(tSIS_VALOR, 'DT_VENCIMENTO', itemXml('DT_VENCIMENTO', voParams));

    if (vNrSeqHistRelSub = 0) then begin
      Result := SetStatus(STS_ERROR, 'GEN0001', , cDS_METHOD);
      return(-1); exit;
    end;

    clear_e(tFCX_HISTRELSUB);
    putitem_e(tFCX_HISTRELSUB, 'TP_DOCUMENTO', 5);
    putitem_e(tFCX_HISTRELSUB, 'NR_SEQHISTRELSUB', vNrSeqHistRelSub);
    retrieve_e(tFCX_HISTRELSUB);
    if (xStatus < 0) then begin
      Result := SetStatus(STS_ERROR, 'GEN0001', , cDS_METHOD);
      return(-1); exit;
    end;

    vDsAdicional := '';
    putitemXml(vDsAdicional, 'NR_SEQHISTRELSUB', vNrSeqHistRelSub);
    putitemXml(vDsAdicional, 'CD_AUTORIZACAO', vCdAutorizacao);
    putitem_e(tSIS_VALOR, 'DS_ADICIONAL', vDsAdicional);
    vDsAdicional := 'Operadora: ' + NR_PORTADOR + '.FCX_HISTRELSUB - ' + DS_PORTADOR + '.FGR_PORTADOR / ' + DS_HISTRELSUB + '.FCX_HISTRELSUB';
    putitem_e(tSIS_VALOR, 'DS_OBSERVACAO', vDsAdicional);

  end else if (item_f('TP_DOCUMENTO', tSIS_VALOR) >= 50000 ) and (item_f('TP_DOCUMENTO', tSIS_VALOR) < 59999) then begin
    vNrSeqHistRelSub := item_f('TP_DOCUMENTO', tSIS_VALOR) - 50000;

    viParams := '';
    putitemXml(viParams, 'NR_SEQHISTRELSUB', vNrSeqHistRelSub);
    putitemXml(viParams, 'NR_DOCUMENTO', item_f('NR_DOCUMENTO', tSIS_VALOR));
    putitemXml(viParams, 'IN_DIRETO', True);
    //keyboard := 'KB_GLOBAL';
    voParams := activateCmp('FGRFM002', 'EXEC', viParams); (*viParams,voParams,, *)
    //keyboard := 'KB_PDV';

    if (xStatus < 0) then begin
      return(-1); exit;
    end;

    vNrSeqHistRelSub := itemXmlF('NR_SEQHISTRELSUB', voParams);
    putitem_e(tSIS_VALOR, 'TP_DOCUMENTO', 5);
    putitem_e(tSIS_VALOR, 'NR_DOCUMENTO', itemXmlF('NR_DOCUMENTO', voParams));
    putitem_e(tSIS_VALOR, 'DT_VENCIMENTO', itemXml('DT_VENCIMENTO', voParams));

    if (vNrSeqHistRelSub = 0) then begin
      Result := SetStatus(STS_ERROR, 'GEN0001', , cDS_METHOD);
      return(-1); exit;
    end;

    clear_e(tFCX_HISTRELSUB);
    putitem_e(tFCX_HISTRELSUB, 'TP_DOCUMENTO', 5);
    putitem_e(tFCX_HISTRELSUB, 'NR_SEQHISTRELSUB', vNrSeqHistRelSub);
    retrieve_e(tFCX_HISTRELSUB);
    if (xStatus < 0) then begin
      Result := SetStatus(STS_ERROR, 'GEN0001', , cDS_METHOD);
      return(-1); exit;
    end;

    vDsAdicional := '';
    putitemXml(vDsAdicional, 'NR_SEQHISTRELSUB', vNrSeqHistRelSub);
    putitem_e(tSIS_VALOR, 'DS_ADICIONAL', vDsAdicional);
    vDsAdicional := 'Operadora: ' + NR_PORTADOR + '.FCX_HISTRELSUB - ' + DS_PORTADOR + '.FGR_PORTADOR / ' + DS_HISTRELSUB + '.FCX_HISTRELSUB';
    putitem_e(tSIS_VALOR, 'DS_OBSERVACAO', vDsAdicional);

  end else if (item_f('TP_DOCUMENTO', tSIS_VALOR) = 12) then begin
    viParams := '';
    putitemXml(viParams, 'IN_RECEBIMENTO', True);
    putitemXml(viParams, 'CD_PESSOA', gCdPessoa);
    setocc(tFCR_DOFNI, 1);
    putlistitems vDsLstDOFNI, item_f('NR_DOFNI', tFCR_DOFNI);
    putitemXml(viParams, 'DS_DOFNI', vDsLstDOFNI);
    //keyboard := 'KB_GLOBAL';
    voParams := activateCmp('FCRFL011', 'EXEC', viParams); (*viParams,voParams,, *)
    //keyboard := 'KB_PDV';

    if (xStatus < 0) then begin
      return(-1); exit;
    end;

    vNrDOFNI := itemXmlF('NR_DOFNI', voParams);

    if (vNrDOFNI = 0) then begin
      Result := SetStatus(STS_ERROR, 'GEN0001', , cDS_METHOD);
      return(-1); exit;
    end;

    creocc(tFCR_DOFNI, -1);
    putitem_e(tFCR_DOFNI, 'NR_DOFNI', vNrDOFNI);
    retrieve_o(tFCR_DOFNI);
    if (xStatus = -7) then begin
      retrieve_x(tFCR_DOFNI);
    end else if (xStatus = 4) then begin
      Result := SetStatus(STS_ERROR, 'GEN0001', , cDS_METHOD);
      return(-1); exit;
    end;

    putitem_e(tSIS_TOTAL, 'VL_DOCUMENTO', item_f('VL_DOCUMENTO', tSIS_TOTAL) - item_f('VL_DOCUMENTO', tSIS_VALOR));
    voParams := calculaTotal(viParams); (* *)
    if (xStatus < 0) then begin
      Result := voParams;
      return(-1); exit;
    end;

    putitem_e(tSIS_VALOR, 'VL_DOCUMENTO', itemXmlF('VL_DOFNI', voParams));
    putitem_e(tSIS_VALOR, 'NR_DOCUMENTO', itemXmlF('NR_DOFNI', voParams));
    putitem_e(tSIS_VALOR, 'DT_VENCIMENTO', itemXml('DT_SISTEMA', PARAM_GLB));

    vDsAdicional := '';
    putitemXml(vDsAdicional, 'NR_DOFNI', item_f('NR_DOCUMENTO', tSIS_VALOR));
    putitem_e(tSIS_VALOR, 'DS_ADICIONAL', vDsAdicional);

    vDsAdicional := 'DOFNI: ' + NR_DOCUMENTO + '.SIS_VALOR';
    putitem_e(tSIS_VALOR, 'DS_OBSERVACAO', vDsAdicional);
    putitem_e(tSIS_VALOR, 'VL_DOCUMENTO', gabs(item_f('VL_DOCUMENTO', tSIS_VALOR)));
    putitem_e(tSIS_TOTAL, 'VL_DOCUMENTO', item_f('VL_DOCUMENTO', tSIS_TOTAL) + item_f('VL_DOCUMENTO', tSIS_VALOR));
    voParams := calculaTotal(viParams); (* *)
    if (xStatus < 0) then begin
      Result := voParams;
      return(-1); exit;
    end;
    if (gInTrocoMaximo = True) then begin
      putitem_e(tSIS_DUMMY3, 'IN_ADIANTATROCO', False);
    end else begin
      putitem_e(tSIS_DUMMY3, 'IN_ADIANTATROCO', True);
    end;
  end else if (item_f('TP_DOCUMENTO', tSIS_VALOR) = 18) then begin
    if (gTpChequePresente = 1) then begin
      viParams := '';
      if (item_f('VL_DOCUMENTO', tSIS_VALOR) > 0) then begin
        vVlSoma := item_f('VL_DOCUMENTO', tSIS_VALOR) + item_f('VL_RESTANTE', tSIS_DUMMY3);
        putitemXml(viParams, 'VL_UTILIZAR', vVlSoma);
      end else begin
        putitemXml(viParams, 'VL_UTILIZAR', item_f('VL_RESTANTE', tSIS_DUMMY3));
      end;
      //keyboard := 'KB_GLOBAL';
      voParams := activateCmp('FCRFC075', 'EXEC', viParams); (*viParams,voParams,, *)
      //keyboard := 'KB_PDV';
      if (xStatus < 0) then begin
        Result := voParams;
        return(-1); exit;
      end;
      putitem_e(tSIS_VALOR, 'VL_DOCUMENTO', itemXmlF('VL_CHEQUE', voParams));
      putitem_e(tSIS_TOTAL, 'VL_DOCUMENTO', item_f('VL_DOCUMENTO', tSIS_TOTAL) - item_f('VL_DOCUMENTO', tSIS_VALOR));
      voParams := calculaTotal(viParams); (* *)
      if (xStatus < 0) then begin
        Result := voParams;
        return(-1); exit;
      end;

      fieldsyntax 'item_f('VL_DOCUMENTO', tSIS_VALOR)', 'DIM';
    end else begin

      putitem_e(tSIS_TOTAL, 'VL_DOCUMENTO', item_f('VL_DOCUMENTO', tSIS_TOTAL) - item_f('VL_DOCUMENTO', tSIS_VALOR));
      voParams := calculaTotal(viParams); (* *)
      if (xStatus < 0) then begin
        Result := voParams;
        return(-1); exit;
      end;
      putitem_e(tSIS_VALOR, 'VL_DOCUMENTO', '');
      fieldsyntax 'item_f('VL_DOCUMENTO', tSIS_VALOR)', '';

      viParams := '';
      putitemXml(viParams, 'VL_DOCUMENTO', item_f('VL_DOCUMENTO', tSIS_VALOR));
      //keyboard := 'KB_GLOBAL';
      voParams := activateCmp('FCRFP085', 'EXEC', viParams); (*viParams,voParams,, *)
      //keyboard := 'KB_PDV';
    end;
    if (xStatus < 0) then begin
      return(-1); exit;
    end;

    vCdEmpresa := itemXmlF('CD_EMPRESA', voParams);
    if (vCdEmpresa = 0) then begin
      Result := SetStatus(STS_ERROR, 'GEN0001', , cDS_METHOD);
      return(-1); exit;
    end;
    vCdCliente := itemXmlF('CD_CLIENTE', voParams);
    if (vCdCliente = 0) then begin
      Result := SetStatus(STS_ERROR, 'GEN0001', , cDS_METHOD);
      return(-1); exit;
    end;
    vNrCheque := itemXmlF('NR_CHEQUE', voParams);
    if (vNrCheque = 0) then begin
      Result := SetStatus(STS_ERROR, 'GEN0001', , cDS_METHOD);
      return(-1); exit;
    end;
    vVlCheque := itemXmlF('VL_CHEQUE', voParams);
    if (vVlCheque = 0) then begin
      Result := SetStatus(STS_ERROR, 'GEN0001', , cDS_METHOD);
      return(-1); exit;
    end;

    vDsAdicional := '';
    putitemXml(vDsAdicional, 'CD_EMPRESA', itemXmlF('CD_EMPRESA', voParams));
    putitemXml(vDsAdicional, 'CD_CLIENTE', itemXmlF('CD_CLIENTE', voParams));
    putitemXml(vDsAdicional, 'NR_CHEQUE', itemXmlF('NR_CHEQUE', voParams));
    putitemXml(vDsAdicional, 'DT_CHEQUE', itemXml('DT_CHEQUE', voParams));
    putitemXml(vDsAdicional, 'VL_CHEQUE', itemXmlF('VL_CHEQUE', voParams));
    putitemXml(vDsAdicional, 'NR_CTAPES', itemXmlF('NR_CTAPES', voParams));
    putitem_e(tSIS_VALOR, 'DS_ADICIONAL', vDsAdicional);
    putitem_e(tSIS_VALOR, 'TP_DOCUMENTO', 18);

    voParams := getNrDocumento(viParams); (* vNrDocumentoChequePresente *)
    if (xStatus < 0) then begin
      Result := voParams;
      return(-1); exit;
    end;
    putitem_e(tSIS_VALOR, 'NR_DOCUMENTO', vNrDocumentoChequePresente);
    putitem_e(tSIS_VALOR, 'DT_VENCIMENTO', itemXml('DT_CHEQUE', voParams));
    putitem_e(tSIS_VALOR, 'VL_DOCUMENTO', itemXmlF('VL_CHEQUE', voParams));
    if (item_f('VL_DOCUMENTO', tSIS_VALOR) > 0) then begin
      fieldsyntax 'item_f('VL_DOCUMENTO', tSIS_VALOR)', 'DIM';
    end;
    vDsAdicional := 'Cheque presente: ' + FloatToStr(vNrCheque) + ' / Cliente ' + FloatToStr(vCdCliente') + ';

    putitem_e(tSIS_VALOR, 'DS_OBSERVACAO', vDsAdicional);
    putitem_e(tSIS_VALOR, 'VL_DOCUMENTO', gabs(item_f('VL_DOCUMENTO', tSIS_VALOR)));
    putitem_e(tSIS_TOTAL, 'VL_DOCUMENTO', item_f('VL_DOCUMENTO', tSIS_TOTAL) + item_f('VL_DOCUMENTO', tSIS_VALOR));
    voParams := calculaTotal(viParams); (* *)
    if (xStatus < 0) then begin
      Result := voParams;
      return(-1); exit;
    end;

    voParams := calculaTotal(viParams); (* *)

  end;

  validateocc 'SIS_VALOR';
  if (xStatus < 0) then begin
    return(-1); exit;
  end;

  return(0); exit;
end;

//--------------------------------------------------------------
function T_TRAFM066.carregaSimulacao(pParams : String) : String;
//--------------------------------------------------------------

var
  viParams, voParams, vDsLstFormaPgto, vDsLinha, vDsObservacao : String;
  vDsLstParcela, vDsAdicional, vDsRegistro, vDsAdic : String;
  vNrSeqHistRelSub, vNrDocumento, vCdAutorizacao, vVlDocumento, vNrParcela : Real;
begin
  viParams := '';
  putitemXml(viParams, 'CD_EMPRESA', item_f('CD_EMPRESA', tTRA_TRANSACAO));
  putitemXml(viParams, 'DT_TRANSACAO', item_a('DT_TRANSACAO', tTRA_TRANSACAO));
  putitemXml(viParams, 'NR_TRANSACAO', item_f('NR_TRANSACAO', tTRA_TRANSACAO));
  putitemXml(viParams, 'TP_MULTIPLOCARTAO', gTpMultiploCartao);
  voParams := activateCmp('TRASVCO017', 'carregaFormaPagamento', viParams); (*,viParams,voParams,, *)
  if (xStatus < 0) then begin
    Result := voParams;
    return(-1); exit;
  end;

  vDsLstFormaPgto := itemXml('DS_FORMAPGTO', voParams);
  gNrPrazoMedio := itemXmlF('NR_PRAZOMEDIO', voParams);

  if (vDsLstFormaPgto <> '') then begin
    repeat
      getitem(vDsLinha, vDsLstFormaPgto, 1);

      creocc(tSIS_VALOR, -1);
      getlistitensocc_e(vDsLinha, tSIS_VALOR);
      vVlDocumento := item_f('VL_DOCUMENTO', tSIS_VALOR);
      vDsAdic := item_a('DS_ADICIONAL', tSIS_VALOR);

      putitemXml(item_a('DS_REGISTRO', tSIS_VALOR), 'CD_TIPOCLASFCR', itemXmlF('CD_TIPOCLASFCR', vDsLinha));
      putitemXml(item_a('DS_REGISTRO', tSIS_VALOR), 'CD_CLASFCR', itemXmlF('CD_CLASFCR', vDsLinha));

      if (gTpMultiploCartao = 1)  and (item_f('TP_DOCUMENTO', tSIS_VALOR) = 4) then begin
        while (vVlDocumento > 0) do begin
          viParams := '';
          putitemXml(viParams, 'VL_DOCUMENTO', item_f('VL_DOCUMENTO', tSIS_VALOR));
          putitemXml(viParams, 'TP_ARREDONDAMENTO', 1);
          putitemXml(viParams, 'NR_PORTADOR', itemXmlF('NR_PORTADOR', item_a('DS_ADICIONAL', tSIS_VALOR)));
          putitemXml(viParams, 'NR_SEQHISTRELSUB', itemXmlF('NR_SEQHISTRELSUB', item_a('DS_ADICIONAL', tSIS_VALOR)));
          putitemXml(viParams, 'IN_SIMULADOR', True);
          //keyboard := 'KB_GLOBAL';
          voParams := activateCmp('FGRFM003', 'EXEC', viParams); (*viParams,voParams,, *)
          //keyboard := 'KB_PDV';
          if (xStatus < 0) then begin
            Result := voParams;
            return(-1); exit;
          end;

          vNrSeqHistRelSub := itemXmlF('NR_SEQHISTRELSUB', voParams);
          vNrDocumento := itemXmlF('NR_DOCUMENTO', voParams);
          vDsLstParcela := itemXml('DS_LSTPARCELA', voParams);
          vCdAutorizacao := itemXmlF('CD_AUTORIZACAO', voParams);

          if (vNrSeqHistRelSub = 0) then begin
            Result := SetStatus(STS_ERROR, 'GEN0001', , cDS_METHOD);
            return(-1); exit;
          end;

          clear_e(tFCX_HISTRELSUB);
          putitem_e(tFCX_HISTRELSUB, 'TP_DOCUMENTO', 4);
          putitem_e(tFCX_HISTRELSUB, 'NR_SEQHISTRELSUB', vNrSeqHistRelSub);
          retrieve_e(tFCX_HISTRELSUB);
          if (xStatus < 0) then begin
            Result := SetStatus(STS_ERROR, 'GEN0001', , cDS_METHOD);
            return(-1); exit;
          end;
          if (vDsLstParcela <> '') then begin
            repeat
              getitem(vDsRegistro, vDsLstParcela, 1);

              vNrParcela := itemXmlF('NR_PARCELA', vDsRegistro);
              if (vNrParcela > 1) then begin
                creocc(tSIS_VALOR, -1);
              end;

              putitem_e(tSIS_VALOR, 'VL_DOCUMENTO', itemXmlF('VL_PARCELA', vDsRegistro));
              putitem_e(tSIS_VALOR, 'TP_DOCUMENTO', 4);
              putitem_e(tSIS_VALOR, 'NR_DOCUMENTO', vNrDocumento);
              putitem_e(tSIS_VALOR, 'DT_VENCIMENTO', itemXml('DT_VENCIMENTO', vDsRegistro));

              vDsAdicional := '';
              putitemXml(vDsAdicional, 'NR_SEQHISTRELSUB', vNrSeqHistRelSub);
              putitemXml(vDsAdicional, 'CD_AUTORIZACAO', vCdAutorizacao);
              putitem_e(tSIS_VALOR, 'DS_ADICIONAL', vDsAdicional);
              vDsAdicional := 'Operadora: ' + NR_PORTADOR + '.FCX_HISTRELSUB - ' + DS_PORTADOR + '.FGR_PORTADOR / ' + DS_HISTRELSUB + '.FCX_HISTRELSUB';
              putitem_e(tSIS_VALOR, 'DS_OBSERVACAO', vDsAdicional);

              vVlDocumento := vVlDocumento - item_f('VL_DOCUMENTO', tSIS_VALOR);
              putitem_e(tSIS_TOTAL, 'VL_DOCUMENTO', item_f('VL_DOCUMENTO', tSIS_TOTAL) + item_f('VL_DOCUMENTO', tSIS_VALOR));

              delitem(vDsLstParcela, 1);
            until (vDsLstParcela = '');
          end;
          if (vVlDocumento > 0) then begin
            creocc(tSIS_VALOR, -1);
            putitem_e(tSIS_VALOR, 'VL_DOCUMENTO', vVlDocumento);
            putitem_e(tSIS_VALOR, 'TP_DOCUMENTO', 4);
            putitem_e(tSIS_VALOR, 'DS_ADICIONAL', vDsAdic);
          end;
        end;
      end else begin
        putitem_e(tSIS_TOTAL, 'VL_DOCUMENTO', item_f('VL_DOCUMENTO', tSIS_TOTAL) + item_f('VL_DOCUMENTO', tSIS_VALOR));

        if (gTpSimuladorFat = 1) then begin
          if (item_f('TP_DOCUMENTO', tSIS_VALOR) <> 3) then begin
            fieldsyntax item_f('VL_DOCUMENTO', tSIS_VALOR), 'NED';
          end;
          fieldsyntax item_f('TP_DOCUMENTO', tSIS_VALOR), 'NED';
          fieldsyntax item_f('NR_DOCUMENTO', tSIS_VALOR), 'NED';
          fieldsyntax item_a('DT_VENCIMENTO', tSIS_VALOR), 'NED';
        end;
      end;

      delitem(vDsLstFormaPgto, 1);
    until (vDsLstFormaPgto = '');
  end;

  return(0); exit;
end;

//----------------------------------------------------------
function T_TRAFM066.validaLimite(pParams : String) : String;
//----------------------------------------------------------

var
  viParams, voParams : String;
  vTpLiberacao : Real;
  vInValidaFamiliar : Boolean;
begin
  if (gDsLimiteCredito <> 'S')  and (gDsLimiteCredito <> 'V') then begin
    return(0); exit;
  end;
  if (gInSimuladorProduto = True) then begin
    return(0); exit;
  end;
  if (gInSimuladorCondPgto = True) then begin
    return(0); exit;
  end;
  if (item_f('TP_OPERACAO', tTRA_TRANSACAO) = 'E') then begin
    return(0); exit;
  end;
  if (item_b('IN_FINANCEIRO', tGER_OPERACAO) = False ) and (item_f('TP_MODALIDADE', tGER_OPERACAO) <> 7) then begin
    return(0); exit;
  end;
  if (item_f('CD_PESSOA', tTRA_TRANSACAO) = gCdClientePDV) then begin
    return(0); exit;
  end;
  if (gVlPrazo = 0) then begin
    return(0); exit;
  end;

  viParams := '';
  putitemXml(viParams, 'CD_GRUPOEMPRESA', item_f('CD_GRUPOEMPRESA', tTRA_TRANSACAO));
  putitemXml(viParams, 'NR_TRANSACAO', item_f('NR_TRANSACAO', tTRA_TRANSACAO));
  putitemXml(viParams, 'DT_TRANSACAO', item_a('DT_TRANSACAO', tTRA_TRANSACAO));
  voParams := activateCmp('TRASVCO016', 'consultaLiberacaoTransacao', viParams); (*,viParams,voParams,, *)
  if (xStatus < 0) then begin
    Result := voParams;
    return(-1); exit;
  end;

  vTpLiberacao := itemXmlF('TP_LIBERACAO', voParams);
  if (vTpLiberacao = 1)  or (vTpLiberacao = 3) then begin
    return(0); exit;
  end;

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
  putitemXml(viParams, 'CD_CLIENTE', item_f('CD_PESSOA', tTRA_TRANSACAO));
  putitemXml(viParams, 'IN_TOTAL', True);

  if (vInValidaFamiliar = True)  and (item_f('CD_FAMILIAR', tTRA_TRANSACADIC) <> 0) then begin
    putitemXml(viParams, 'CD_FAMILIAR', item_f('CD_FAMILIAR', tTRA_TRANSACADIC));
  end else begin
    vInValidaFamiliar := False;
  end;

  voParams := activateCmp('FCRSVCO015', 'buscaLimiteCliente', viParams); (*,viParams,voParams,, *)
  if (xStatus < 0) then begin
    Result := voParams;
    return(-1); exit;
  end;
  if (vInValidaFamiliar = True) then begin
    gVlDisponivel := itemXmlF('VL_SALDOFAMILIAR', voParams);
  end else begin
    gVlDisponivel := itemXmlF('VL_SALDO', voParams);
  end;
  if (gVlPrazo > gVlDisponivel) then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', , cDS_METHOD);
    return(-1); exit;
  end;

  return(0); exit;
end;

//---------------------------------------------------------------
function T_TRAFM066.verificaRestricao(pParams : String) : String;
//---------------------------------------------------------------

var
  (* string vDsComponente : IN / string vDsCampo : IN / string piVlResticao : IN *)
  viParams, voParams : String;
begin
  viParams := '';
  putitemXml(viParams, 'CD_COMPONENTE', vDsComponente);
  putitemXml(viParams, 'DS_CAMPO', vDsCampo);
  putitemXml(viParams, 'CD_EMPRESA', itemXmlF('CD_EMPRESA', PARAM_GLB));
  putitemXml(viParams, 'CD_USUARIO', itemXmlF('CD_USUARIO', PARAM_GLB));

  if (vDsCampo = 'IN_LIBERA_PRAZOMEDIO') then begin
    putitemXml(viParams, 'VL_VALOR', '');
  end else if (vDsCampo = 'VL_DESC_MAX_FINANC') then begin
    putitemXml(viParams, 'VL_VALOR', piVlResticao);
    putitemXml(viParams, 'IN_VALIDASENHA', False);
  end;

  voParams := activateCmp('ADMSVCO009', 'VerificaRestricao', viParams); (*viParams,voParams,, *)
  if (xStatus < 0) then begin
    Result := voParams;
    return(-1); exit;
  end;
  return(0); exit;
end;

//--------------------------------------------------------
function T_TRAFM066.efetua_NCN(pParams : String) : String;
//--------------------------------------------------------

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
    putitemXml(viParams, 'DS_CAMINHO', gvDsCaminho);
    putitemXml(viParams, 'CD_EMPRESA', item_f('CD_EMPRESA', tTEF_TRANSACAO));
    putitemXml(viParams, 'DT_MOVIMENTO', item_a('DT_MOVIMENTO', tTEF_TRANSACAO));
    putitemXml(viParams, 'NR_SEQ', item_f('NR_SEQ', tTEF_TRANSACAO));
  end;
  voParams := activateCmp('TEFSVCO010', 'geraArquivoREQ', viParams); (*,viParams,voParams,, *)
  if (xStatus < 0) then begin
    Result := voParams;
    return(-1); exit;
  end;
    if (xStatus < 0) then begin
      Result := voParams;
      return(-1); exit;
    end;
    if (item_f('VL_TRANSACAO', tTEF_TRANSACAO) = 0 ) and (item_f('NR_NSU', tTEF_TRANSACAO) = 0) then begin
      Result := SetStatus(STS_ERROR, 'GEN0001', , cDS_METHOD);
    end else if (item_f('VL_TRANSACAO', tTEF_TRANSACAO) = 0 ) and (item_f('NR_NSU', tTEF_TRANSACAO) > 0) then begin
      Result := SetStatus(STS_ERROR, 'GEN0001', , cDS_METHOD);
    end else begin
      Result := SetStatus(STS_ERROR, 'GEN0001', , cDS_METHOD);
    end;
  end else if (gTpTEF = 2) then begin
    vInLoopConfirmacao := False;
    repeat
      Result := voParams;
      message/hint 'Aguardando comunicação...';
      if (gTpTEF = 2) then begin
        putitemXml(viParams, 'DS_CAMINHO', gvDsCaminho);
      end;
      voParams := activateCmp('TEFSVCO010', 'geraArquivoREQ', viParams); (*,viParams,voParams,, *)
      if (xStatus < 0) then begin
        Result := voParams;
        return(-1); exit;
      end;
        if (xStatus < 0) then begin
          Result := voParams;
          return(-1); exit;
        end;
        if (item_f('VL_TRANSACAO', tTEF_TRANSACAO) = 0 ) and (item_f('NR_NSU', tTEF_TRANSACAO) = 0) then begin
          Result := SetStatus(STS_ERROR, 'GEN0001', , cDS_METHOD);
        end else if (item_f('VL_TRANSACAO', tTEF_TRANSACAO) = 0 ) and (item_f('NR_NSU', tTEF_TRANSACAO) > 0) then begin
          Result := SetStatus(STS_ERROR, 'GEN0001', , cDS_METHOD);
        end else begin
          Result := SetStatus(STS_ERROR, 'GEN0001', , cDS_METHOD);
        end;
        vInLoopConfirmacao := True;
      end;
      message/hint ' ';
    until (vInLoopConfirmacao := True);
  end;

  return(0); exit;
end;

//--------------------------------------------------------
function T_TRAFM066.efetua_CNF(pParams : String) : String;
//--------------------------------------------------------

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
  if (gTpTEF = 2) then begin
    putitemXml(viParams, 'DS_CAMINHO', gvDsCaminho);
  end;
  voParams := activateCmp('TEFSVCO010', 'geraArquivoREQ', viParams); (*,viParams,voParams,, *)
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
      Result := voParams;
      message/hint 'Aguardando comunicação...';
      if (gTpTEF = 2) then begin
        putitemXml(viParams, 'DS_CAMINHO', gvDsCaminho);
      end;
      voParams := activateCmp('TEFSVCO010', 'geraArquivoREQ', viParams); (*,viParams,voParams,, *)
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

//-----------------------------------------------------
function T_TRAFM066.geraNFe(pParams : String) : String;
//-----------------------------------------------------

var
  viParams, voParams, vDsLstNF, vDsRegistro : String;
begin
  if (gInGeraNfeAutomatic = 1)  and (gInGeraRegC140Fin = 1) then begin
    vDsLstNF := '';
    if (empty(tFIS_NF) = False) then begin
      setocc(tFIS_NF, 1);
      while (xStatus >= 0) do begin
        vDsRegistro := '';
        putitemXml(vDsRegistro, 'CD_EMPRESA', item_f('CD_EMPRESA', tFIS_NF));
        putitemXml(vDsRegistro, 'NR_FATURA', item_f('NR_FATURA', tFIS_NF));
        putitemXml(vDsRegistro, 'DT_FATURA', item_a('DT_FATURA', tFIS_NF));
        putitem(vDsLstNF,  vDsRegistro);
        setocc(tFIS_NF, curocc(tFIS_NF) + 1);
      end;
      setocc(tFIS_NF, 1);
    end;
  end;
  putitemXml(voParams, 'DS_LSTNF', vDsLstNF);

  return(0); exit;

end;

//-------------------------------------------------------------------
function T_TRAFM066.imprimirCupomPresente(pParams : String) : String;
//-------------------------------------------------------------------

var
  (* numeric pCdEmpTransacao : IN / numeric pNrTransacao : IN / date pDtTransacao : IN / numeric pNrCupom : IN *)
  viParams, voParams : String;
  vInRelacListaPrd : Boolean;
begin
  if (gInEcfCupomPresente = False) then begin
    return(0); exit;
  end;

  viParams := '';
  putitemXml(viParams, 'CD_EMPTRANSACAO', pCdEmpTransacao);
  putitemXml(viParams, 'NR_TRANSACAO', pNrTransacao);
  putitemXml(viParams, 'DT_TRANSACAO', pDtTransacao);
  voParams := activateCmp('TRASVCO032', 'validaTransacaoListaPrd', viParams); (*,viParams,voParams,, *)
  if (xStatus < 0) then begin
    Result := voParams;
    return(-1); exit;
  end;
  vInRelacListaPrd := itemXmlB('IN_RELACLISTAPRD', voParams);

  if (vInRelacListaPrd = True) then begin
    askmess 'Deseja imprimir Cupom Presente?', 'Sim, Não';
    if (xStatus = 1) then begin
      viParams := '';
      putitemXml(viParams, 'CD_EMPTRANSACAO', pCdEmpTransacao);
      putitemXml(viParams, 'NR_TRANSACAO', pNrTransacao);
      putitemXml(viParams, 'DT_TRANSACAO', pDtTransacao);
      putitemXml(viParams, 'NR_CUPOM', pNrCupom);
      voParams := activateCmp('TRASVCO032', 'imprimeCupomPresente', viParams); (*,viParams,voParams,, *)
      if (xStatus < 0) then begin
        Result := voParams;
        return(-1); exit;
      end;
    end;
  end;

  return(0); exit;
end;

//------------------------------------------------------------
function T_TRAFM066.getNrDocumento(pParams : String) : String;
//------------------------------------------------------------

var
  (* numeric vNrSequencia : OUT *)
  viParams, voParams : String;
begin
  viParams := '';
  putitemXml(viParams, 'NM_ENTIDADE', 'FCR_FATURAI');
  voParams := activateCmp('GERSVCO031', 'getNumSeq', viParams); (*,viParams,voParams,, *)
  if (xStatus < 0) then begin
    Result := voParams;
    return(-1); exit;
  end;

  vNrSequencia := itemXmlF('NR_SEQUENCIA', voParams);

  return(0); exit;
end;

end.
