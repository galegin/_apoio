unit cFISSVCO004;

interface

(* COMPONENTES 
  ADMSVCO001 / CTBSVCO016 / FISSVCO015 / FISSVCO024 / FISSVCO032
  FISSVCO033 / GERSVCO001 / GERSVCO031 / GERSVCO046 / GERSVCO058
  PESSVCO005 / PRDSVCO015 / PRDSVCO020 / PRDSVCO021 / PRDSVCO023
  SICSVCO005 / TRASVCO004 / TRASVCO016 / 
*)        

uses
  Classes, SysUtils, DB,
  cServiceUnf, cDataSetUnf;

type
  T_FISSVCO004 = class(TcServiceUnf)
  private
    tF_TMP_NR08,
    tF_TMP_NR09,
    tFIS_DECRETO,
    tFIS_ECF,
    tFIS_NF,
    tFIS_NFECF,
    tFIS_NFIMPOSTO,
    tFIS_NFISELOEN,
    tFIS_NFITEM,
    tFIS_NFITEMCON,
    tFIS_NFITEMDES,
    tFIS_NFITEMIMP,
    tFIS_NFITEMPLO,
    tFIS_NFITEMPPR,
    tFIS_NFITEMPRO,
    tFIS_NFITEMSER,
    tFIS_NFITEMUN,
    tFIS_NFITEMVL,
    tFIS_NFREF,
    tFIS_NFREMDES,
    tFIS_NFSELOENT,
    tFIS_NFTRANSP,
    tFIS_NFVENCTO,
    tFIS_S_NF,
    tGER_MODNFC,
    tGER_OPERACAO,
    tGER_S_OPERACA,
    tGER_SERIE,
    tOBS_NF,
    tOBS_TRANSACNF,
    tPRD_CLASSIFIC,
    tPRD_PRODUTOCL,
    tPRD_TIPOCLAS,
    tTMP_CSTALIQ,
    tTMP_K02,
    tTMP_NR08,
    tTMP_NR09,
    tTRA_ITEMIMPOS,
    tTRA_ITEMLOTE,
    tTRA_ITEMPRDFI,
    tTRA_ITEMSELOE,
    tTRA_ITEMSERIA,
    tTRA_ITEMUN,
    tTRA_ITEMVL,
    tTRA_REMDES,
    tTRA_SELOENT,
    tTRA_TRANREF,
    tTRA_TRANSACAO,
    tTRA_TRANSACEC,
    tTRA_TRANSITEM,
    tTRA_TRANSPORT,
    tTRA_VENCIMENT,
    tV_FIS_NFREMDE : TcDatasetUnf;
    function getParam(pParams : String = '') : String;
    function setEntidade(pParams : String = '') : String;
  protected
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;    
  published
    function geraCapaNF(pParams : String = '') : String;
    function geraItemNF(pParams : String = '') : String;
    function geraImpostoItem(pParams : String = '') : String;
    function geraTransport(pParams : String = '') : String;
    function rateiaValorCapa(pParams : String = '') : String;
    function geraParcela(pParams : String = '') : String;
    function geraRemDest(pParams : String = '') : String;
    function geraECF(pParams : String = '') : String;
    function geraObservacao(pParams : String = '') : String;
    function limpastring(pParams : String = '') : String;
    function geraNFReferencial(pParams : String = '') : String;
    function geraItemSeloEnt(pParams : String = '') : String;
    function alteraVlIpi(pParams : String = '') : String;
    function geraSeloFiscalEnt(pParams : String = '') : String;
    function geraNF(pParams : String = '') : String;
    function emiteNF(pParams : String = '') : String;
    function gravaECFNF(pParams : String = '') : String;
    function alteraSituacaoNF(pParams : String = '') : String;
    function alteraImpressaoNF(pParams : String = '') : String;
    function gravaCapaNF(pParams : String = '') : String;
    function gravaObsNF(pParams : String = '') : String;
    function gravaItemProdNF(pParams : String = '') : String;
    function gravaItemNF(pParams : String = '') : String;
    function gravaenderecoNF(pParams : String = '') : String;
    function gravaTransportadoraNF(pParams : String = '') : String;
    function gravaItemImpostoNF(pParams : String = '') : String;
    function gravaImpostoNF(pParams : String = '') : String;
    function alteraVendedorNF(pParams : String = '') : String;
    function consignadoDevolverFaturar(pParams : String = '') : String;
    function gravaLogNF(pParams : String = '') : String;
    function consignadoCancelar(pParams : String = '') : String;
    function removeECFNF(pParams : String = '') : String;
  end;

implementation

uses
  cADMSVCO001,
  cActivate, cStatus, cFuncao, cXml, dModulo;

var
  g = 85) or (viParams); (*,
  gCdCusto1Venda,
  gCdCusto2Venda,
  gCdCusto3Venda,
  gCdCustoMedioSemImp,
  gCdCustoSemImp,
  gCdEmpresaValorEmp,
  gCdEmpresaValorSis,
  gCdEspecieServico,
  gCdModeloNF,
  gCdMotivoAltValor,
  gCdOperEntEstTrans,
  gCdOperEntInspecao,
  gCdSaldoCalcVlrMedio,
  gCdSaldoEstDeTerc,
  gCdSaldoEstTerceiro,
  gCdSaldoPadrao,
  gCdSerie,
  gCdTipoClas,
  gDsAdicionalRegra,
  gDsCustoSubstTributaria,
  gDsCustoValorRetido,
  gDsEmbLegalSubTrib,
  gDsLstFatura,
  gDsLstModDctoFiscal,
  gDsLstNivelDescGrupo,
  gDsLstNivelGrupo,
  gDsLstOperEstDeTerc,
  gDsLstOperEstTerceiro,
  gDsLstOperObrigNfRef,
  gDsObsNf,
  gDtEmissao,
  gDtEncerramento,
  gDtEntrega,
  gDtFatura,
  gDtSaidaEntrada,
  gHrFim,
  gHrInicio,
  gHrSaida,
  gHrTempo,
  gInArredondaTruncaICMS,
  gInBaixaPedPool,
  gInExibeQtdProdNF,
  gInExibeResumoCfopNF,
  gInExibeResumoCstNF,
  gInGravaDsDecretoObsNf,
  gInGravaObsNf,
  gInIncluiIpiDevSimp,
  gInItemLote,
  gInLog,
  gInNFe,
  gInOptSimples,
  gInPDVOtimizado,
  gInQuebraCFOP,
  gInQuebraItem,
  gInReemissao,
  gInSomaFrete,
  gInSubstituicao,
  gLstLoteInfGeral,
  gnext(CD_EMPRESAORI.FIS_NFSVC) or NR_TRANSACAOORI.FIS_NFSVC <>,
  gNrCodFiscal,
  gNrFatura,
  gNrItemQuebraNf,
  gNrNf,
  gprAplicMvaSubTrib,
  greplace(,
  gtinTinturaria,
  gTpAgrupamento,
  gTpAgrupamentoItemNF,
  gTpCodigoItem,
  gTpEstoqueTerceiro,
  gTpImpObsRegraFiscalNf,
  gTpImpressaoCodPrdEcf,
  gTpLancamentoFrete,
  gTpModDctoFiscal,
  gTpModDctoFiscallocal,
  gTpRegimeTrib,
  gufDestino,
  gufOrigem,
  gVlBaseCalc,
  gVlICMSDiferido,
  gVlImposto : String;

//---------------------------------------------------------------
constructor T_FISSVCO004.Create(AOwner: TComponent);
//---------------------------------------------------------------
begin
  inherited Create(AOwner);
  setEntidade('');
end;

//--------------------------------
destructor T_FISSVCO004.Destroy;
//--------------------------------
begin
  inherited Destroy;
end;

//---------------------------------------------------------------
function T_FISSVCO004.getParam(pParams : String = '') : String;
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
  putitem(xParam, 'CD_EMPVALOR');
  putitem(xParam, 'CD_MOTIVO_ALTVALOR_CMP');

  xParam := T_ADMSVCO001.GetParametro(xParam);


  xParamEmp := '';
  putitem(xParamEmp, 'CD_CUSTO_MEDIO_S_IMPOSTO');
  putitem(xParamEmp, 'CD_CUSTO_S_IMPOSTO');
  putitem(xParamEmp, 'CD_CUSTO1VendA_REL_CONFIG');
  putitem(xParamEmp, 'CD_CUSTO2VendA_REL_CONFIG');
  putitem(xParamEmp, 'CD_CUSTO3VendA_REL_CONFIG');
  putitem(xParamEmp, 'CD_EMPRESA_VALOR');
  putitem(xParamEmp, 'CD_OPER_ENT_EST_TRANS');
  putitem(xParamEmp, 'CD_OPER_ENT_INSPECAO');
  putitem(xParamEmp, 'CD_SALDO_CALC_VLR_MEDIO');
  putitem(xParamEmp, 'CD_SALDO_EST_DE_TERC');
  putitem(xParamEmp, 'CD_SALDO_EST_TERCEIRO');
  putitem(xParamEmp, 'CD_SALDOPADRAO');
  putitem(xParamEmp, 'CD_TIPOCLAS_ITEM_NF');
  putitem(xParamEmp, 'DS_CUSTO_SUBST_TRIBUTARIA');
  putitem(xParamEmp, 'DS_CUSTO_VALOR_RETIDO');
  putitem(xParamEmp, 'DS_EMB_LEGAL_SUB_TRIB');
  putitem(xParamEmp, 'DS_LST_MODDCTOFISCAL_AT');
  putitem(xParamEmp, 'DS_LST_NIVEL_DES_GRUPO_NF');
  putitem(xParamEmp, 'DS_LST_NIVEL_GRUPO_NF');
  putitem(xParamEmp, 'DS_LST_OPER_EST_DE_TERC');
  putitem(xParamEmp, 'DS_LST_OPER_EST_TERCEIRO');
  putitem(xParamEmp, 'DS_LST_OPER_OBRIG_NF_REF');
  putitem(xParamEmp, 'DS_OBS_NF');
  putitem(xParamEmp, 'DT_ENCERRAMENTO_FIS');
  putitem(xParamEmp, 'IN_ARREDONDA_TRUNCA_ICMS');
  putitem(xParamEmp, 'IN_BAIXA_PED_POOL_EMP');
  putitem(xParamEmp, 'IN_EXIBE_QTD_PROD_NF');
  putitem(xParamEmp, 'IN_EXIBE_RESUMO_CFOP_NF');
  putitem(xParamEmp, 'IN_EXIBE_RESUMO_CST_NF');
  putitem(xParamEmp, 'IN_GRAVA_DS_DECRETO_OBSNF');
  putitem(xParamEmp, 'IN_GRAVA_OBS_NF');
  putitem(xParamEmp, 'IN_INCLUI_IPI_DEV_SIMP');
  putitem(xParamEmp, 'IN_LOG_TEMPO_VendA');
  putitem(xParamEmp, 'IN_OPT_SIMPLES');
  putitem(xParamEmp, 'IN_PDV_OTIMIZADO');
  putitem(xParamEmp, 'IN_SOMA_FRETE_TOTALNF');
  putitem(xParamEmp, 'NR_ITEM_QUEBRA_NF');
  putitem(xParamEmp, 'PR_APLIC_MVA_SUB_TRIB');
  putitem(xParamEmp, 'TP_AGRUPAMENTO_ITEM_NF');
  putitem(xParamEmp, 'TP_CONTR_EST_EM_TERCEIRO');
  putitem(xParamEmp, 'TP_IMP_OBS_REGRAFISCAL_NF');
  putitem(xParamEmp, 'TP_IMPRESSAO_COD_PRD_ECF');
  putitem(xParamEmp, 'TP_LANCAMENTO_FRETE_TRA');
  putitem(xParamEmp, 'TP_MOD_DCTO_FISCAL');
  putitem(xParamEmp, 'TP_QUEBRA_NF_CFOP');
  putitem(xParamEmp, 'UF_ORIGEM');

  xParamEmp := T_ADMSVCO001.GetParamEmpresa(piCdEmpresa, xParamEmp);

  gCdEmpresaValorEmp := itemXml('CD_EMPRESA_VALOR', xParamEmp);
  gCdSaldoCalcVlrMedio := itemXml('CD_SALDO_CALC_VLR_MEDIO', xParamEmp);
  gCdSaldoPadrao := itemXml('CD_SALDOPADRAO', xParamEmp);
  gNrItemQuebraNf := itemXml('NR_ITEM_QUEBRA_NF', xParamEmp);

end;

//---------------------------------------------------------------
function T_FISSVCO004.setEntidade(pParams : String = '') : String;
//---------------------------------------------------------------
begin
  tF_TMP_NR08 := GetEntidade('F_TMP_NR08');
  tF_TMP_NR09 := GetEntidade('F_TMP_NR09');
  tFIS_DECRETO := GetEntidade('FIS_DECRETO');
  tFIS_ECF := GetEntidade('FIS_ECF');
  tFIS_NF := GetEntidade('FIS_NF');
  tFIS_NFECF := GetEntidade('FIS_NFECF');
  tFIS_NFIMPOSTO := GetEntidade('FIS_NFIMPOSTO');
  tFIS_NFISELOEN := GetEntidade('FIS_NFISELOEN');
  tFIS_NFITEM := GetEntidade('FIS_NFITEM');
  tFIS_NFITEMCON := GetEntidade('FIS_NFITEMCON');
  tFIS_NFITEMDES := GetEntidade('FIS_NFITEMDES');
  tFIS_NFITEMIMP := GetEntidade('FIS_NFITEMIMP');
  tFIS_NFITEMPLO := GetEntidade('FIS_NFITEMPLO');
  tFIS_NFITEMPPR := GetEntidade('FIS_NFITEMPPR');
  tFIS_NFITEMPRO := GetEntidade('FIS_NFITEMPRO');
  tFIS_NFITEMSER := GetEntidade('FIS_NFITEMSER');
  tFIS_NFITEMUN := GetEntidade('FIS_NFITEMUN');
  tFIS_NFITEMVL := GetEntidade('FIS_NFITEMVL');
  tFIS_NFREF := GetEntidade('FIS_NFREF');
  tFIS_NFREMDES := GetEntidade('FIS_NFREMDES');
  tFIS_NFSELOENT := GetEntidade('FIS_NFSELOENT');
  tFIS_NFTRANSP := GetEntidade('FIS_NFTRANSP');
  tFIS_NFVENCTO := GetEntidade('FIS_NFVENCTO');
  tFIS_S_NF := GetEntidade('FIS_S_NF');
  tGER_MODNFC := GetEntidade('GER_MODNFC');
  tGER_OPERACAO := GetEntidade('GER_OPERACAO');
  tGER_S_OPERACA := GetEntidade('GER_S_OPERACA');
  tGER_SERIE := GetEntidade('GER_SERIE');
  tOBS_NF := GetEntidade('OBS_NF');
  tOBS_TRANSACNF := GetEntidade('OBS_TRANSACNF');
  tPRD_CLASSIFIC := GetEntidade('PRD_CLASSIFIC');
  tPRD_PRODUTOCL := GetEntidade('PRD_PRODUTOCL');
  tPRD_TIPOCLAS := GetEntidade('PRD_TIPOCLAS');
  tTMP_CSTALIQ := GetEntidade('TMP_CSTALIQ');
  tTMP_K02 := GetEntidade('TMP_K02');
  tTMP_NR08 := GetEntidade('TMP_NR08');
  tTMP_NR09 := GetEntidade('TMP_NR09');
  tTRA_ITEMIMPOS := GetEntidade('TRA_ITEMIMPOS');
  tTRA_ITEMLOTE := GetEntidade('TRA_ITEMLOTE');
  tTRA_ITEMPRDFI := GetEntidade('TRA_ITEMPRDFI');
  tTRA_ITEMSELOE := GetEntidade('TRA_ITEMSELOE');
  tTRA_ITEMSERIA := GetEntidade('TRA_ITEMSERIA');
  tTRA_ITEMUN := GetEntidade('TRA_ITEMUN');
  tTRA_ITEMVL := GetEntidade('TRA_ITEMVL');
  tTRA_REMDES := GetEntidade('TRA_REMDES');
  tTRA_SELOENT := GetEntidade('TRA_SELOENT');
  tTRA_TRANREF := GetEntidade('TRA_TRANREF');
  tTRA_TRANSACAO := GetEntidade('TRA_TRANSACAO');
  tTRA_TRANSACEC := GetEntidade('TRA_TRANSACEC');
  tTRA_TRANSITEM := GetEntidade('TRA_TRANSITEM');
  tTRA_TRANSPORT := GetEntidade('TRA_TRANSPORT');
  tTRA_VENCIMENT := GetEntidade('TRA_VENCIMENT');
  tV_FIS_NFREMDE := GetEntidade('V_FIS_NFREMDE');
end;

//----------------------------------------------------------
function T_FISSVCO004.geraCapaNF(pParams : String) : String;
//----------------------------------------------------------
const
  cDS_METHOD = 'ADICIONAL=Operação: T_FISSVCO004.geraCapaNF()';
var
  vNrNF : Real;
  viParams, voParams, vDsRegistro : String;
  vDtSistema : TDate;
begin
  gNrFatura := 0;

  if (item_f('TP_ORIGEMEMISSAO', tTRA_TRANSACAO) = 2) then begin
    viParams := '';
    putitemXml(viParams, 'CD_EMPRESA', item_f('CD_EMPRESA', tTRA_TRANSACAO));
    putitemXml(viParams, 'NR_TRANSACAO', item_f('NR_TRANSACAO', tTRA_TRANSACAO));
    putitemXml(viParams, 'DT_TRANSACAO', item_a('DT_TRANSACAO', tTRA_TRANSACAO));
    voParams := activateCmp('SICSVCO005', 'buscaSequencia', viParams); (*,,,, *)
    if (xStatus < 0) then begin
      Result := voParams;
      return(-1); exit;
    end;
    gNrFatura := itemXmlF('NR_FATURA', voParams);
  end else begin
    if (item_f('CD_EMPFAT', tTRA_TRANSACAO) <> itemXmlF('CD_EMPRESA', PARAM_GLB)) then begin
      if (gDsLstFatura <> '') then begin
        getitem(gNrFatura, gDsLstFatura, 1);
        delitem(gDsLstFatura, 1);
      end;
    end;
    if (gNrFatura = 0) then begin
      viParams := '';
      putitemXml(viParams, 'NM_ENTIDADE', 'FIS_NF');
      voParams := activateCmp('GERSVCO031', 'getNumSeq', viParams); (*,,,, *)
      if (xStatus < 0) then begin
        Result := voParams;
        return(-1); exit;
      end;
      gNrFatura := itemXmlF('NR_SEQUENCIA', voParams);
    end;
    if (item_f('CD_EMPFAT', tTRA_TRANSACAO) = itemXmlF('CD_EMPRESA', PARAM_GLB)) then begin
      putitem(gDsLstFatura,  gNrFatura);
    end;
  end;
  if (gNrFatura = 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Não foi possível obter nr. de fatura da NF', cDS_METHOD);
    return(-1); exit;
  end;
  if (gDtFatura <> '') then begin
    vDtSistema := gDtFatura;
  end else begin
    vDtSistema := itemXml('DT_SISTEMA', PARAM_GLB);
  end;

  creocc(tFIS_NF, -1);
  putitem_e(tFIS_NF, 'CD_EMPRESA', item_f('CD_EMPFAT', tTRA_TRANSACAO));
  putitem_e(tFIS_NF, 'NR_FATURA', gNrFatura);
  putitem_e(tFIS_NF, 'DT_FATURA', vDtSistema);
  putitem_e(tFIS_NF, 'CD_PESSOA', item_f('CD_PESSOA', tTRA_TRANSACAO));

  if (item_f('TP_ORIGEMEMISSAO', tTRA_TRANSACAO) = 2) then begin
    putitem_e(tFIS_NF, 'NR_NF', gNrNf);
    putitem_e(tFIS_NF, 'CD_SERIE', gCdSerie);
    putitem_e(tFIS_NF, 'DT_EMISSAO', gDtEmissao);
    putitem_e(tFIS_NF, 'DT_SAIDAENTRADA', gDtSaidaEntrada);

    if (item_f('TP_DOCTO', tGER_S_OPERACA) = 0) then begin
      putitem_e(tFIS_NF, 'TP_SITUACAO', 'N');
    end else begin
      putitem_e(tFIS_NF, 'TP_SITUACAO', 'E');
    end;

  end else begin
    if (gInReemissao = True) then begin
      putitem_e(tFIS_NF, 'DT_FATURA', gDtEmissao);
      putitem_e(tFIS_NF, 'NR_NF', gNrNf);
      putitem_e(tFIS_NF, 'CD_SERIE', gCdSerie);
      putitem_e(tFIS_NF, 'DT_EMISSAO', gDtEmissao);
      putitem_e(tFIS_NF, 'TP_SITUACAO', 'E');
      putitem_e(tFIS_NF, 'DT_SAIDAENTRADA', gDtEmissao);
    end else begin
      putitem_e(tFIS_NF, 'TP_SITUACAO', 'N');
      putitem_e(tFIS_NF, 'DT_SAIDAENTRADA', gDtSaidaEntrada);
    end;
  end;

  putitem_e(tFIS_NF, 'TP_ORIGEMEMISSAO', item_f('TP_ORIGEMEMISSAO', tTRA_TRANSACAO));
  putitem_e(tFIS_NF, 'TP_OPERACAO', item_f('TP_OPERACAO', tTRA_TRANSACAO));
  voParams := ocalg > 0) then begin
    voParams := ocalg;
  end else begin
    if (gTpModDctoFiscal = 0) then begin
      putitem_e(tFIS_NF, 'TP_MODDCTOFISCAL', 02);
    end else begin
      putitem_e(tFIS_NF, 'TP_MODDCTOFISCAL', gTpModDctoFiscal);
    end;
  end;
  if (item_f('TP_MODALIDADE', tGER_S_OPERACA) = 'D') then begin
    putitem_e(tFIS_NF, 'TP_MODDCTOFISCAL', 85);

  end else if (item_f('TP_MODALIDADE', tGER_S_OPERACA) = 'G') then begin
    putitem_e(tFIS_NF, 'TP_MODDCTOFISCAL', 87);
  end;

  putitem_e(tFIS_NF, 'CD_EMPFAT', item_f('CD_EMPFAT', tTRA_TRANSACAO));
  putitem_e(tFIS_NF, 'CD_GRUPOEMPRESA', item_f('CD_GRUPOEMPRESA', tTRA_TRANSACAO));
  putitem_e(tFIS_NF, 'CD_OPERADOR', itemXmlF('CD_USUARIO', PARAM_GLB));
  putitem_e(tFIS_NF, 'DT_CADASTRO', Now);
  putitem_e(tFIS_NF, 'NR_PRE', 0);
  putitem_e(tFIS_NF, 'CD_CONDPGTO', item_f('CD_CONDPGTO', tTRA_TRANSACAO));
  putitem_e(tFIS_NF, 'CD_OPERACAO', item_f('CD_OPERFAT', tGER_OPERACAO));
  putitem_e(tFIS_NF, 'CD_MODELONF', gCdModeloNF);
  putitem_e(tFIS_NF, 'CD_EMPRESAORI', item_f('CD_EMPRESA', tTRA_TRANSACAO));
  putitem_e(tFIS_NF, 'NR_TRANSACAOORI', item_f('NR_TRANSACAO', tTRA_TRANSACAO));
  putitem_e(tFIS_NF, 'DT_TRANSACAOORI', item_a('DT_TRANSACAO', tTRA_TRANSACAO));

  if (gHrSaida = '') then begin
    putitem_e(tFIS_NF, 'HR_SAIDA', gclock);
  end else begin
    putitem_e(tFIS_NF, 'HR_SAIDA', gHrSaida);
  end;

  putitem_e(tFIS_NF, 'CD_COMPVEND', item_f('CD_COMPVEND', tTRA_TRANSACAO));
  putitem_e(tFIS_NF, 'IN_FRETE', item_b('IN_FRETE', tTRA_TRANSACAO));
  putitem_e(tFIS_NF, 'PR_DESCONTO', item_f('PR_DESCONTO', tTRA_TRANSACAO));
  putitem_e(tFIS_NF, 'QT_FATURADO', 0);
  putitem_e(tFIS_NF, 'VL_TOTALPRODUTO', 0);
  putitem_e(tFIS_NF, 'VL_DESPACESSOR', 0);
  putitem_e(tFIS_NF, 'VL_FRETE', 0);
  putitem_e(tFIS_NF, 'VL_SEGURO', 0);
  putitem_e(tFIS_NF, 'VL_IPI', 0);
  putitem_e(tFIS_NF, 'VL_DESCONTO', 0);
  putitem_e(tFIS_NF, 'VL_TOTALNOTA', 0);
  putitem_e(tFIS_NF, 'VL_BASEICMSSUBS', 0);
  putitem_e(tFIS_NF, 'VL_ICMSSUBST', 0);
  putitem_e(tFIS_NF, 'VL_BASEICMS', 0);
  putitem_e(tFIS_NF, 'VL_ICMS', 0);

  clear_e(tTMP_CSTALIQ);

  return(0); exit;
end;

//----------------------------------------------------------
function T_FISSVCO004.geraItemNF(pParams : String) : String;
//----------------------------------------------------------
const
  cDS_METHOD = 'ADICIONAL=Operação: T_FISSVCO004.geraItemNF()';
var
  (* string piDsLstProduto : IN / numeric piNrItem : IN *)
  vVlValor, vCdProduto, vCdValor, vTpRegime, vCdRegraFiscal, vCdRegraFiscalProd : Real;
  viParams, voParams, vCdItem, vTpValor, vDsItem, vDsRegistro, vDsLstValor : String;
  vDsLstItemUn, vCdTIPI, vDsTIPI, vDsLstSerial, vDsLstDespesa, vTpReducao, vTpAliqIcms : String;
  vLstLoteInfGeral, vLstLoteInf, vDsLstItemLote, vDsLstNf, vDsLstItemPrdFin : String;
  vInCopiaValor, vInObs : Boolean;
begin
  vCdTIPI := '';
  vDsTIPI := '';

  if (item_f('CD_PRODUTO', tTRA_TRANSITEM) > 0 ) and (item_f('CD_ESPECIE', tTRA_TRANSITEM) <> gCdEspecieServico) then begin
    if (item_f('CD_TIPI', tTRA_TRANSITEM) = '') then begin
      viParams := '';
      putitemXml(viParams, 'CD_PRODUTO', item_f('CD_PRODUTO', tTRA_TRANSITEM));
      voParams := activateCmp('GERSVCO046', 'buscaDadosProduto', viParams); (*,,,, *)
      if (xStatus < 0) then begin
        Result := voParams;
        return(-1); exit;
      end;
      vCdTIPI := itemXmlF('CD_TIPI', voParams);
      vDsTIPI := itemXml('DS_TIPI', voParams);
    end else begin
      vCdTIPI := item_f('CD_TIPI', tTRA_TRANSITEM);
      viParams := '';
      putitemXml(viParams, 'CD_TIPI', vCdTIPI);
      voParams := activateCmp('GERSVCO046', 'buscaDadosFiscal', viParams); (*,,,, *)
      if (xStatus < 0) then begin
        Result := voParams;
        return(-1); exit;
      end;

      vDsTIPI := itemXml('DS_TIPI', voParams);
    end;
  end;
  if (item_f('CD_BARRAPRD', tTRA_TRANSITEM) <> '' ) and (item_f('CD_ESPECIE', tTRA_TRANSITEM) <> gCdEspecieServico) then begin
    vCdTIPI := item_f('CD_TIPI', tTRA_TRANSITEM);
    if (vCdTIPI <> '') then begin
      viParams := '';
      putitemXml(viParams, 'CD_TIPI', vCdTIPI);
      voParams := activateCmp('GERSVCO046', 'buscaDadosFiscal', viParams); (*,,,, *)
      if (xStatus < 0) then begin
        Result := voParams;
        return(-1); exit;
      end;

      vDsTIPI := itemXml('DS_TIPI', voParams);
    end;
  end;
  if (item_f('QT_FATURADO', tFIS_NFITEM) = 0)  or (item_f('QT_FATURADO', tFIS_NFITEM) = 1)  or %\ then begin
  (itemXml('TP_ARREDOND_VL_UNIT_VD', PARAM_GLB) := 1)  or (itemXml('TP_ARREDOND_VL_UNIT_VD', PARAM_GLB) := 2);
    vInCopiaValor := True;
  end else begin
    vInCopiaValor := False;
  end;

  creocc(tFIS_NFITEM, -1);
  putitem_e(tFIS_NFITEM, 'NR_ITEM', piNrItem);
  putitem_e(tFIS_NFITEM, 'CD_EMPFAT', item_f('CD_EMPFAT', tTRA_TRANSACAO));
  putitem_e(tFIS_NFITEM, 'CD_GRUPOEMPRESA', item_f('CD_GRUPOEMPRESA', tTRA_TRANSACAO));
  putitem_e(tFIS_NFITEM, 'CD_OPERADOR', itemXmlF('CD_USUARIO', PARAM_GLB));
  putitem_e(tFIS_NFITEM, 'DT_CADASTRO', Now);
  putitem_e(tFIS_NFITEM, 'IN_DESCONTO', item_b('IN_DESCONTO', tTRA_TRANSITEM));
  putitem_e(tFIS_NFITEM, 'CD_ESPECIE', item_f('CD_ESPECIE', tTRA_TRANSITEM));
  putitem_e(tFIS_NFITEM, 'CD_CST', item_f('CD_CST', tTRA_TRANSITEM));
  putitem_e(tFIS_NFITEM, 'CD_CFOP', item_f('CD_CFOP', tTRA_TRANSITEM));
  putitem_e(tFIS_NFITEM, 'CD_DECRETO', item_f('CD_DECRETO', tTRA_TRANSITEM));
  putitem_e(tFIS_NFITEM, 'CD_TIPI', vCdTIPI);
  putitem_e(tFIS_NFITEM, 'QT_FATURADO', item_f('QT_SOLICITADA', tTRA_TRANSITEM));
  putitem_e(tFIS_NFITEM, 'VL_TOTALBRUTO', item_f('VL_TOTALBRUTO', tTRA_TRANSITEM));
  putitem_e(tFIS_NFITEM, 'VL_TOTALLIQUIDO', item_f('VL_TOTALLIQUIDO', tTRA_TRANSITEM));
  putitem_e(tFIS_NFITEM, 'VL_TOTALDESC', item_f('VL_TOTALDESC', tTRA_TRANSITEM) + item_f('VL_TOTALDESCCAB', tTRA_TRANSITEM));

  if (vInCopiaValor = True)  and (gTpAgrupamentoItemNF <> 1) then begin
    putitem_e(tFIS_NFITEM, 'VL_UNITBRUTO', item_f('VL_UNITBRUTO', tTRA_TRANSITEM));
    putitem_e(tFIS_NFITEM, 'VL_UNITLIQUIDO', item_f('VL_UNITLIQUIDO', tTRA_TRANSITEM));
    putitem_e(tFIS_NFITEM, 'VL_UNITDESC', item_f('VL_UNITDESC', tTRA_TRANSITEM) + item_f('VL_UNITDESCCAB', tTRA_TRANSITEM));
  end else begin
    vVlValor := item_f('VL_TOTALBRUTO', tFIS_NFITEM) / item_f('QT_FATURADO', tFIS_NFITEM);
    putitem_e(tFIS_NFITEM, 'VL_UNITBRUTO', rounded(vVlValor, 6));
    vVlValor := item_f('VL_TOTALLIQUIDO', tFIS_NFITEM) / item_f('QT_FATURADO', tFIS_NFITEM);
    putitem_e(tFIS_NFITEM, 'VL_UNITLIQUIDO', rounded(vVlValor, 6));
    vVlValor := item_f('VL_TOTALDESC', tFIS_NFITEM) / item_f('QT_FATURADO', tFIS_NFITEM);
    putitem_e(tFIS_NFITEM, 'VL_UNITDESC', rounded(vVlValor, 6));
  end;
  vVlValor := (item_f('VL_TOTALDESC', tFIS_NFITEM) / item_f('VL_TOTALBRUTO', tFIS_NFITEM)) * 100;
  putitem_e(tFIS_NFITEM, 'PR_DESCONTO', rounded(vVlValor, 6));

  if (gInExibeResumoCfopNF = True) then begin
    creocc(tF_TMP_NR09, -1);
    putitem_e(tF_TMP_NR09, 'NR_GERAL', item_f('CD_CFOP', tFIS_NFITEM));
    retrieve_o(tF_TMP_NR09);
    if (xStatus = -7) then begin
      retrieve_x(tF_TMP_NR09);
    end;

    putitem_e(tF_TMP_NR09, 'VL_TOTAL', item_f('VL_TOTAL', tF_TMP_NR09) + item_f('VL_TOTALLIQUIDO', tFIS_NFITEM));
    putitem_e(tF_TMP_NR09, 'QT_ITEM', item_f('QT_ITEM', tF_TMP_NR09) + item_f('QT_FATURADO', tFIS_NFITEM));
  end;
  if (item_f('CD_ESPECIE', tTRA_TRANSITEM) = gCdEspecieServico) then begin
    if (item_f('CD_PRODUTO', tTRA_TRANSITEM) = 0) then begin
      putitem_e(tFIS_NFITEM, 'CD_PRODUTO', item_f('CD_BARRAPRD', tTRA_TRANSITEM));
    end else begin
      putitem_e(tFIS_NFITEM, 'CD_PRODUTO', item_f('CD_PRODUTO', tTRA_TRANSITEM));
    end;
    putitem_e(tFIS_NFITEM, 'DS_PRODUTO', item_a('DS_PRODUTO', tTRA_TRANSITEM));
  end else begin
    if (item_f('CD_PRODUTO', tTRA_TRANSITEM) = 0)  and (item_f('CD_BARRAPRD', tTRA_TRANSITEM) = '') then begin
      putitem_e(tFIS_NFITEM, 'DS_PRODUTO', item_a('DS_PRODUTO', tTRA_TRANSITEM));
      putitem_e(tFIS_NFITEM, 'IN_DESCONTO', '');
      putitem_e(tFIS_NFITEM, 'CD_ESPECIE', '');
      putitem_e(tFIS_NFITEM, 'CD_CST', '');
      putitem_e(tFIS_NFITEM, 'CD_CFOP', '');
      putitem_e(tFIS_NFITEM, 'CD_DECRETO', '');
      putitem_e(tFIS_NFITEM, 'CD_TIPI', '');
      putitem_e(tFIS_NFITEM, 'QT_FATURADO', '');
      putitem_e(tFIS_NFITEM, 'VL_TOTALBRUTO', '');
      putitem_e(tFIS_NFITEM, 'VL_TOTALLIQUIDO', '');
      putitem_e(tFIS_NFITEM, 'VL_TOTALDESC', '');
      putitem_e(tFIS_NFITEM, 'VL_UNITBRUTO', '');
      putitem_e(tFIS_NFITEM, 'VL_UNITLIQUIDO', '');
      putitem_e(tFIS_NFITEM, 'VL_UNITDESC', '');
      putitem_e(tFIS_NFITEM, 'PR_DESCONTO', '');
    end else begin

      if (gTpCodigoItem = 1) then begin
        putitem_e(tFIS_NFITEM, 'CD_PRODUTO', item_f('CD_NIVELGRUPO', tTRA_TRANSITEM)[1 : 14]);
        putitem_e(tFIS_NFITEM, 'DS_PRODUTO', item_a('DS_NIVELGRUPO', tTRA_TRANSITEM)[1 : 60]);
      end else if (gTpCodigoItem = 2) then begin
        vCdItem := '';
        vDsItem := '';
        setocc(tPRD_TIPOCLAS, 1);
        while (xStatus >= 0) do begin
          clear_e(tPRD_PRODUTOCL);
          putitem_e(tPRD_PRODUTOCL, 'CD_PRODUTO', item_f('CD_PRODUTO', tTRA_TRANSITEM));
          putitem_e(tPRD_PRODUTOCL, 'CD_TIPOCLAS', item_f('CD_TIPOCLAS', tPRD_TIPOCLAS));
          retrieve_e(tPRD_PRODUTOCL);
          if (xStatus >= 0) then begin
            vCdItem := '' + FloatToStr(vCdItem' + CD_CLASSIFICACAO) + ' + '.PRD_PRODUTOCL';
            vDsItem := '' + vDsItem' + DS_CLASSIFICACAO + ' + '.PRD_CLASSIFIC ';
          end;
            setocc(tPRD_TIPOCLAS, curocc(tPRD_TIPOCLAS) + 1);
        end;
        putitem_e(tFIS_NFITEM, 'CD_PRODUTO', vCdItem[1 : 14]);
        putitem_e(tFIS_NFITEM, 'DS_PRODUTO', vDsItem[1 : 60]);
      end else if (gTpCodigoItem = 3) then begin
        putitem_e(tFIS_NFITEM, 'CD_PRODUTO', vCdTIPI);
        putitem_e(tFIS_NFITEM, 'DS_PRODUTO', vDSTIPI);
      end else if (gTpCodigoItem = 5) then begin
        if (gTpAgrupamento = 'F' ) or (gTpAgrupamento = '') then begin
          viParams := '';
          putitemXml(viParams, 'CD_PRODUTO', item_f('CD_PRODUTO', tTRA_TRANSITEM));
          putitemXml(viParams, 'CD_PESSOA', item_f('CD_PESSOA', tTRA_TRANSACAO));
          voParams := activateCmp('PRDSVCO023', 'buscaDadosProduto', viParams); (*,,,, *)
          if (xStatus < 0) then begin
            Result := voParams;
            return(-1); exit;
          end;
          putitem_e(tFIS_NFITEM, 'CD_PRODUTO', itemXmlF('CD_ORIGEM', voParams)[1 : 14]);
          putitem_e(tFIS_NFITEM, 'DS_PRODUTO', itemXml('DS_ORIGEM', voParams)[1 : 60]);
        end else begin
          viParams := '';
          putitemXml(viParams, 'CD_SEQGRUPO', item_f('CD_SEQGRUPO', tTRA_TRANSITEM));
          putitemXml(viParams, 'CD_PESSOA', item_f('CD_PESSOA', tTRA_TRANSACAO));
          voParams := activateCmp('PRDSVCO023', 'buscaDadosGrupo', viParams); (*,,,, *)
          if (xStatus < 0) then begin
            Result := voParams;
            return(-1); exit;
          end;
          putitem_e(tFIS_NFITEM, 'CD_PRODUTO', itemXmlF('CD_ORIGEM', voParams)[1 : 14]);
          putitem_e(tFIS_NFITEM, 'DS_PRODUTO', itemXml('DS_ORIGEM', voParams)[1 : 60]);
        end;
      end else if (gTpCodigoItem = 6) then begin
        putitem_e(tTRA_TRANSITEM, 'CD_NIVELGRUPO', greplace(item_f('CD_NIVELGRUPO', tTRA_TRANSITEM), 1, ' ', '', -1));
        putitem_e(tFIS_NFITEM, 'CD_PRODUTO', item_f('CD_NIVELGRUPO', tTRA_TRANSITEM)[1 : 14]);
        putitem_e(tFIS_NFITEM, 'DS_PRODUTO', item_a('DS_NIVELGRUPO', tTRA_TRANSITEM)[1 : 60]);
      end else if (gTpCodigoItem = 7) then begin
        viParams := '';
        putitemXml(viParams, 'CD_EMPRESA', item_f('CD_EMPRESA', tTRA_TRANSACAO));
        putitemXml(viParams, 'NR_TRANSACAO', item_f('NR_TRANSACAO', tTRA_TRANSACAO));
        putitemXml(viParams, 'DT_TRANSACAO', item_a('DT_TRANSACAO', tTRA_TRANSACAO));
        if (gTpAgrupamento = 'F' ) or (gTpAgrupamento = '') then begin
          putitemXml(viParams, 'CD_PRODUTO', item_f('CD_PRODUTO', tTRA_TRANSITEM));
        end else begin
          putitemXml(viParams, 'CD_SEQGRUPO', item_f('CD_SEQGRUPO', tTRA_TRANSITEM));
        end;
        voParams := activateCmp('PRDSVCO015', 'retornaDadosPedidoG', viParams); (*,,,, *)
        if (xStatus < 0) then begin
          Result := voParams;
          return(-1); exit;
        end;
        putitem_e(tFIS_NFITEM, 'CD_PRODUTO', itemXmlF('CD_NIVELFAT', voParams)[1 : 14]);
        putitem_e(tFIS_NFITEM, 'DS_PRODUTO', itemXml('DS_NIVELFAT', voParams)[1 : 60]);
      end else begin
        if (item_f('CD_PRODUTO', tTRA_TRANSITEM) = 0) then begin
          putitem_e(tFIS_NFITEM, 'CD_PRODUTO', item_f('CD_BARRAPRD', tTRA_TRANSITEM));
          putitem_e(tFIS_NFITEM, 'CD_TIPI', item_f('CD_TIPI', tTRA_TRANSITEM));
        end else begin
          putitem_e(tFIS_NFITEM, 'CD_PRODUTO', item_f('CD_PRODUTO', tTRA_TRANSITEM));
        end;
        putitem_e(tFIS_NFITEM, 'DS_PRODUTO', item_a('DS_PRODUTO', tTRA_TRANSITEM));
      end;
      if (item_f('CD_PRODUTO', tFIS_NFITEM) = '' ) or (item_a('DS_PRODUTO', tFIS_NFITEM) = '') then begin
        if (gTpAgrupamento = 'F' ) or (gTpAgrupamento = '') then begin
          if (item_f('CD_PRODUTO', tTRA_TRANSITEM) = 0) then begin
            putitem_e(tFIS_NFITEM, 'CD_PRODUTO', item_f('CD_BARRAPRD', tTRA_TRANSITEM));
          end else begin
            putitem_e(tFIS_NFITEM, 'CD_PRODUTO', item_f('CD_PRODUTO', tTRA_TRANSITEM));
          end;
          putitem_e(tFIS_NFITEM, 'DS_PRODUTO', item_a('DS_PRODUTO', tTRA_TRANSITEM));
        end else begin

          putitem_e(tFIS_NFITEM, 'CD_PRODUTO', item_f('CD_NIVELGRUPO', tTRA_TRANSITEM)[1 : 14]);
          putitem_e(tFIS_NFITEM, 'DS_PRODUTO', item_a('DS_NIVELGRUPO', tTRA_TRANSITEM)[1 : 60]);
        end;
      end;
    end;
  end;

  voParams := limpastring(viParams); (* item_f('CD_PRODUTO', tFIS_NFITEM), item_f('CD_PRODUTO', tFIS_NFITEM) *)
  if (xStatus < 0) then begin
    Result := voParams;
    return(-1); exit;
  end;

  voParams := limpastring(viParams); (* item_a('DS_PRODUTO', tFIS_NFITEM), item_a('DS_PRODUTO', tFIS_NFITEM) *)
  if (xStatus < 0) then begin
    Result := voParams;
    return(-1); exit;
  end;
  if (item_f('CD_PRODUTO', tFIS_NFITEM) <> '') then begin
    if (item_f('CD_CFOP', tFIS_NFITEM) = 0) then begin
      Result := SetStatus(STS_ERROR, 'GEN0001', 'Falta CFOP no produto ' + CD_PRODUTO + '.FIS_NFITEM!', cDS_METHOD);
      return(-1); exit;
    end;
    if (item_f('CD_CST', tFIS_NFITEM) = '') then begin
      Result := SetStatus(STS_ERROR, 'GEN0001', 'Falta CST no produto ' + CD_PRODUTO + '.FIS_NFITEM!', cDS_METHOD);
      return(-1); exit;
    end;
  end;

  vInObs := False;

  if (item_f('CD_DECRETO', tFIS_NFITEM) = 1020)  or (item_f('CD_DECRETO', tFIS_NFITEM) = 10201)  or (item_f('CD_DECRETO', tFIS_NFITEM) = 10202)  or (item_f('CD_DECRETO', tFIS_NFITEM) = 10203) then begin
    if (gprAplicMvaSubTrib <> '')  and (gufOrigem = 'SC')  and (gufDestino = 'SC')  and (gTpRegimeTrib = 2 ) or (gTpRegimeTrib = 3) then begin
      creocc(tTMP_NR08, -1);
      putitem_e(tTMP_NR08, 'NR_08', 1);
      retrieve_o(tTMP_NR08);
      if (xStatus = 0) then begin
        if (gDsAdicionalRegra = '') then begin
          gDsAdicionalRegra := gDsEmbLegalSubTrib;
        end else begin
          gDsAdicionalRegra := '' + gDsAdicionalRegra' + gDsEmbLegalSubTrib' + ' + ';
        end;
      end;
    end;
  end;
  if (piDsLstProduto <> '')  and (item_f('CD_ESPECIE', tFIS_NFITEM) <> gCdEspecieServico) then begin
    repeat
      getitem(vDsRegistro, piDsLstProduto, 1);
      vCdProduto := itemXmlF('CD_PRODUTO', vDsRegistro);
      if (vCdProduto <> 0) then begin
        creocc(tFIS_NFITEMPRO, -1);
        putitem_e(tFIS_NFITEMPRO, 'CD_PRODUTO', vCdProduto);
        retrieve_o(tFIS_NFITEMPRO);
        if (xStatus = -7) then begin
          retrieve_x(tFIS_NFITEMPRO);
        end;
        putitem_e(tFIS_NFITEMPRO, 'CD_EMPFAT', item_f('CD_EMPFAT', tTRA_TRANSACAO));
        putitem_e(tFIS_NFITEMPRO, 'CD_GRUPOEMPRESA', item_f('CD_GRUPOEMPRESA', tTRA_TRANSACAO));
        putitem_e(tFIS_NFITEMPRO, 'QT_FATURADO', item_f('QT_FATURADO', tFIS_NFITEMPRO) + itemXmlF('QT_FATURADO', vDsRegistro));
        putitem_e(tFIS_NFITEMPRO, 'VL_UNITBRUTO', itemXmlF('VL_UNITBRUTO', vDsRegistro));
        putitem_e(tFIS_NFITEMPRO, 'VL_UNITDESC', itemXmlF('VL_UNITDESC', vDsRegistro));
        putitem_e(tFIS_NFITEMPRO, 'VL_UNITLIQUIDO', itemXmlF('VL_UNITLIQUIDO', vDsRegistro));
        putitem_e(tFIS_NFITEMPRO, 'VL_TOTALDESC', item_f('VL_TOTALDESC', tFIS_NFITEMPRO) + itemXmlF('VL_TOTALDESC', vDsRegistro));
        putitem_e(tFIS_NFITEMPRO, 'VL_TOTALLIQUIDO', item_f('VL_TOTALLIQUIDO', tFIS_NFITEMPRO) + itemXmlF('VL_TOTALLIQUIDO', vDsRegistro));
        putitem_e(tFIS_NFITEMPRO, 'VL_TOTALBRUTO', item_f('VL_TOTALBRUTO', tFIS_NFITEMPRO) + itemXmlF('VL_TOTALBRUTO', vDsRegistro));
        putitem_e(tFIS_NFITEMPRO, 'CD_COMPVEND', itemXmlF('CD_COMPVend', vDsRegistro));
        putitem_e(tFIS_NFITEMPRO, 'CD_PROMOCAO', itemXmlF('CD_PROMOCAO', vDsRegistro));
        putitem_e(tFIS_NFITEMPRO, 'CD_OPERADOR', itemXmlF('CD_USUARIO', PARAM_GLB));
        putitem_e(tFIS_NFITEMPRO, 'DT_CADASTRO', Now);

        if ((gprAplicMvaSubTrib = '')  and (gInPDVOtimizado = True))  or (gTpImpObsRegraFiscalNf = 1) then begin
          vInObs := False;
          viParams := '';
          putitemXml(viParams, 'CD_PRODUTO', item_f('CD_PRODUTO', tFIS_NFITEMPRO));
          putitemXml(viParams, 'CD_OPERACAO', item_f('CD_OPERACAO', tGER_OPERACAO));
          voParams := activateCmp('FISSVCO033', 'buscaRegraFiscalProduto', viParams); (*,,,, *)
          if (xStatus < 0) then begin
            Result := voParams;
            return(-1); exit;
          end;

          vCdRegraFiscalProd := itemXmlF('CD_REGRAFISCAL', voParams);

          if (vCdRegraFiscalProd <> '') then begin
            creocc(tTMP_NR08, -1);
            putitem_e(tTMP_NR08, 'NR_08', vCdRegraFiscalProd);
            retrieve_o(tTMP_NR08);
            if (xStatus = 0) then begin
              viParams := '';
              putitemXml(viParams, 'CD_REGRAFISCAL', vCdRegraFiscalProd);
              voParams := activateCmp('FISSVCO033', 'buscaDadosRegraFiscal', viParams); (*,,,, *)
              if (xStatus < 0) then begin
                Result := voParams;
                return(-1); exit;
              end;

              vTpReducao := itemXmlF('TP_REDUCAO', voParams);
              vTpAliqIcms := itemXmlF('TP_ALIQICMS', voParams);

              if (vTpReducao = '' ) and (vTpAliqIcms = '') then begin
                vInObs := True;

              end else if (vTpReducao = 'G' ) or (vTpReducao = 'H' ) or (vTpReducao = 'I')  or %\ then begin
                ((vTpReducao := 'A' ) or (vTpReducao := 'B' ) or (vTpReducao := 'C')  and gufOrigem := gufDestino)  or 
                ((vTpReducao := 'D' ) or (vTpReducao := 'E' ) or (vTpReducao := 'F')  and gufOrigem <> gufDestino);
                vInObs := True;

              end else if (vTpAliqIcms = 'C')  or (vTpAliqIcms = 'A' ) and (gufOrigem = gufDestino)  or %\ then begin
                (vTpAliqIcms := 'B' ) and (gufOrigem <> gufDestino);
                vInObs := True;
              end;
              if (item_f('CD_REGRAFISCAL', tGER_S_OPERACA) > 0) then begin
                vCdRegraFiscal := item_f('CD_REGRAFISCAL', tGER_S_OPERACA);
              end else if (item_f('CD_REGRAFISCAL', tGER_OPERACAO) > 0) then begin
                vCdRegraFiscal := item_f('CD_REGRAFISCAL', tGER_OPERACAO);
              end;
              if (vCdRegraFiscalProd <> vCdRegraFiscal)  and (vInObs = True) then begin
                if (gDsAdicionalRegra = '') then begin
                  gDsAdicionalRegra := itemXml('DS_ADICIONAL', voParams);
                end else begin
                  gDsAdicionalRegra := '' + gDsAdicionalRegra' + itemXml('DS_ADICIONAL', + ' + ' voParams)';
                end;
              end;
            end;
          end;
        end;
        if (item_f('TP_MODALIDADE', tGER_OPERACAO) = 'C' ) and (item_f('TP_OPERACAO', tGER_OPERACAO) = 'S' ) and (item_f('TP_MODALIDADE', tGER_S_OPERACA) = 'C') then begin
          creocc(tFIS_NFITEMCON, -1);
          putitem_e(tFIS_NFITEMCON, 'CD_EMPRESA', item_f('CD_EMPRESA', tFIS_NFITEMPRO));
          putitem_e(tFIS_NFITEMCON, 'NR_FATURA', item_f('NR_FATURA', tFIS_NFITEMPRO));
          putitem_e(tFIS_NFITEMCON, 'DT_FATURA', item_a('DT_FATURA', tFIS_NFITEMPRO));
          putitem_e(tFIS_NFITEMCON, 'NR_ITEM', item_f('NR_ITEM', tFIS_NFITEMPRO));
          putitem_e(tFIS_NFITEMCON, 'CD_PRODUTO', item_f('CD_PRODUTO', tFIS_NFITEMPRO));
          retrieve_o(tFIS_NFITEMCON);
          if (xStatus = -7) then begin
            retrieve_x(tFIS_NFITEMCON);
          end;
          putitem_e(tFIS_NFITEMCON, 'CD_EMPFAT', item_f('CD_EMPFAT', tFIS_NFITEMPRO));
          putitem_e(tFIS_NFITEMCON, 'CD_GRUPOEMPRESA', item_f('CD_GRUPOEMPRESA', tFIS_NFITEMPRO));
          putitem_e(tFIS_NFITEMCON, 'TP_SITUACAO', 1);
          putitem_e(tFIS_NFITEMCON, 'CD_OPERADOR', itemXmlF('CD_USUARIO', PARAM_GLB));
          putitem_e(tFIS_NFITEMCON, 'DT_CADASTRO', Now);
        end;

        vDsLstItemUn := itemXml('DS_LSTITEMUN', vDsRegistro);
        if (vDsLstItemUn <> '') then begin
          creocc(tFIS_NFITEMUN, -1);

          retrieve_o(tFIS_NFITEMUN);
          if (xStatus = -7) then begin
            retrieve_x(tFIS_NFITEMUN);
          end;

          getlistitensocc_e(vDsLstItemUn, tFIS_NFITEMUN);
          putitem_e(tFIS_NFITEMUN, 'CD_OPERADOR', itemXmlF('CD_USUARIO', PARAM_GLB));
          putitem_e(tFIS_NFITEMUN, 'DT_CADASTRO', Now);
        end;

        vDsLstValor := itemXml('DS_LSTVALOR', vDsRegistro);
        vDsLstSerial := itemXml('DS_LSTSERIAL', vDsRegistro);
        vDsLstDespesa := itemXml('DS_LSTDESPESA', vDsRegistro);
        vDsLstItemLote := itemXml('DS_LSTITEMLOTE', vDsRegistro);
        vDsLstItemPrdFin := itemXml('DS_LSTITEMPRDFIN', vDsRegistro);

        if (vDsLstValor <> '') then begin
          repeat
            getitem(vDsRegistro, vDsLstValor, 1);
            vTpValor := itemXmlF('TP_VALOR', vDsRegistro);
            vCdValor := itemXmlF('CD_VALOR', vDsRegistro);
            creocc(tFIS_NFITEMVL, -1);
            putitem_e(tFIS_NFITEMVL, 'TP_VALOR', vTpValor);
            putitem_e(tFIS_NFITEMVL, 'CD_VALOR', vCdValor);
            retrieve_o(tFIS_NFITEMVL);
            if (xStatus = -7) then begin
              retrieve_x(tFIS_NFITEMVL);
            end;
            delitem(vDsRegistro, 'TP_VALOR');
            delitem(vDsRegistro, 'CD_VALOR');
            getlistitensocc_e(vDsRegistro, tFIS_NFITEMVL);
            putitem_e(tFIS_NFITEMVL, 'CD_EMPFAT', item_f('CD_EMPFAT', tTRA_TRANSACAO));
            putitem_e(tFIS_NFITEMVL, 'CD_GRUPOEMPRESA', item_f('CD_GRUPOEMPRESA', tTRA_TRANSACAO));
            putitem_e(tFIS_NFITEMVL, 'CD_OPERADOR', itemXmlF('CD_USUARIO', PARAM_GLB));
            putitem_e(tFIS_NFITEMVL, 'DT_CADASTRO', Now);
            delitem(vDsLstValor, 1);
          until (vDsLstValor = '');
        end;
        if (vDsLstSerial <> '') then begin
          if (item_f('TP_OPERACAO', tTRA_TRANSACAO) = 'E') then begin
            viParams := '';
            putitemXml(viParams, 'CD_PRODUTO', item_f('CD_PRODUTO', tFIS_NFITEMPRO));
            putitemXml(viParams, 'DS_LSTSERIAL', vDsLstSerial);
            putitemXml(viParams, 'TP_SITUACAO', 1);
            voParams := activateCmp('PRDSVCO021', 'incluiSerialProduto', viParams); (*,,,, *)
            if (xStatus < 0) then begin
              Result := voParams;
              return(-1); exit;
            end;
          end;

          repeat
            getitem(vDsRegistro, vDsLstSerial, 1);
            creocc(tFIS_NFITEMSER, -1);
            putitem_e(tFIS_NFITEMSER, 'NR_SEQUENCIA', curocc(tFIS_NFITEMSER));
            retrieve_o(tFIS_NFITEMSER);
            if (xStatus = -7) then begin
              retrieve_x(tFIS_NFITEMSER);
            end;
            putitem_e(tFIS_NFITEMSER, 'CD_EMPFAT', itemXmlF('CD_EMPFAT', vDsRegistro));
            putitem_e(tFIS_NFITEMSER, 'CD_GRUPOEMPRESA', itemXmlF('CD_GRUPOEMPRESA', vDsRegistro));
            putitem_e(tFIS_NFITEMSER, 'DS_SERIAL', itemXml('DS_SERIAL', vDsRegistro));
            putitem_e(tFIS_NFITEMSER, 'CD_OPERADOR', itemXmlF('CD_USUARIO', PARAM_GLB));
            putitem_e(tFIS_NFITEMSER, 'DT_CADASTRO', Now);

            delitem(vDsLstSerial, 1);
          until (vDsLstSerial = '');
        end;
        if (vDsLstDespesa <> '') then begin
          repeat
            getitem(vDsRegistro, vDsLstDespesa, 1);
            if (itemXml('CD_DESPESAITEM', vDsRegistro) > 0)  and (itemXml('CD_CCUSTO', vDsRegistro) > 0) then begin
              creocc(tFIS_NFITEMDES, -1);
              putitem_e(tFIS_NFITEMDES, 'CD_DESPESAITEM', itemXmlF('CD_DESPESAITEM', vDsRegistro));
              putitem_e(tFIS_NFITEMDES, 'CD_CCUSTO', itemXmlF('CD_CCUSTO', vDsRegistro));
              retrieve_o(tFIS_NFITEMDES);
              if (xStatus = -7) then begin
                retrieve_x(tFIS_NFITEMDES);
              end;
              putitem_e(tFIS_NFITEMDES, 'PR_RATEIO', itemXmlF('PR_RATEIO', vDsRegistro));
              putitem_e(tFIS_NFITEMDES, 'CD_OPERADOR', itemXmlF('CD_USUARIO', PARAM_GLB));
              putitem_e(tFIS_NFITEMDES, 'DT_CADASTRO', Now);
            end;
            delitem(vDsLstDespesa, 1);
          until (vDsLstDespesa = '');
        end;
        if (vDsLstItemLote <> '') then begin
          repeat
            getitem(vDsRegistro, vDsLstItemLote, 1);
            if (gInItemLote) then begin
              creocc(tFIS_NFITEMPLO, -1);
              item_f('NR_SEQUENCIA', tFIS_NFITEMPLO)= curocc(tFIS_NFITEMPLO);
              retrieve_o(tFIS_NFITEMPLO);
              if (xStatus = -7) then begin
                retrieve_x(tFIS_NFITEMPLO);
              end;
              putitem_e(tFIS_NFITEMPLO, 'CD_EMPLOTE', itemXmlF('CD_EMPLOTE', vDsRegistro));
              putitem_e(tFIS_NFITEMPLO, 'NR_LOTE', itemXmlF('NR_LOTE', vDsRegistro));
              putitem_e(tFIS_NFITEMPLO, 'NR_ITEMLOTE', itemXmlF('NR_ITEMLOTE', vDsRegistro));
              putitem_e(tFIS_NFITEMPLO, 'QT_LOTE', itemXmlF('QT_LOTE', vDsRegistro));
              putitem_e(tFIS_NFITEMPLO, 'QT_CONE', itemXmlF('QT_CONE', vDsRegistro));
              putitem_e(tFIS_NFITEMPLO, 'CD_BARRALOTE', itemXmlF('CD_BARRALOTE', vDsRegistro));
              putitem_e(tFIS_NFITEMPLO, 'CD_OPERADOR', itemXmlF('CD_USUARIO', PARAM_GLB));
              putitem_e(tFIS_NFITEMPLO, 'DT_CADASTRO', Now);
            end else begin

              if (gtinTinturaria = 1) then begin
                creocc(tFIS_NFITEMPLO, -1);
                item_f('NR_SEQUENCIA', tFIS_NFITEMPLO)= curocc(tFIS_NFITEMPLO);
                retrieve_o(tFIS_NFITEMPLO);
                if (xStatus = -7) then begin
                  retrieve_x(tFIS_NFITEMPLO);
                end;
                putitem_e(tFIS_NFITEMPLO, 'CD_EMPLOTE', itemXmlF('CD_EMPLOTE', vDsRegistro));
                putitem_e(tFIS_NFITEMPLO, 'NR_LOTE', itemXmlF('NR_LOTE', vDsRegistro));
                putitem_e(tFIS_NFITEMPLO, 'NR_ITEMLOTE', itemXmlF('NR_ITEMLOTE', vDsRegistro));
                putitem_e(tFIS_NFITEMPLO, 'QT_LOTE', itemXmlF('QT_LOTE', vDsRegistro));
                putitem_e(tFIS_NFITEMPLO, 'QT_CONE', itemXmlF('QT_CONE', vDsRegistro));
                putitem_e(tFIS_NFITEMPLO, 'CD_BARRALOTE', itemXmlF('CD_BARRALOTE', vDsRegistro));
                putitem_e(tFIS_NFITEMPLO, 'CD_OPERADOR', itemXmlF('CD_USUARIO', PARAM_GLB));
                putitem_e(tFIS_NFITEMPLO, 'DT_CADASTRO', Now);
              end;

              vLstLoteInf := '';
              putitemXml(vLstLoteInf, 'CD_EMPRESA', itemXmlF('CD_EMPLOTE', vDsRegistro));
              putitemXml(vLstLoteInf, 'NR_LOTE', itemXmlF('NR_LOTE', vDsRegistro));
              putitemXml(vLstLoteInf, 'NR_ITEM', itemXmlF('NR_ITEMLOTE', vDsRegistro));
              putitemXml(vLstLoteInf, 'DT_FATURA', item_a('DT_FATURA', tFIS_NFITEMPRO));
              putitemXml(vLstLoteInf, 'CD_EMPRESANF', item_f('CD_EMPRESA', tFIS_NFITEMPRO));
              putitemXml(vLstLoteInf, 'NR_FATURA', item_f('NR_FATURA', tFIS_NFITEMPRO));
              putitemXml(vLstLoteInf, 'NR_ITEMNF', item_f('NR_ITEM', tFIS_NFITEMPRO));
              putitemXml(vLstLoteInf, 'CD_PRODUTONF', item_f('CD_PRODUTO', tFIS_NFITEMPRO));
              putitem(gLstLoteInfGeral,  vLstLoteInf);
            end;
            delitem(vDsLstItemLote, 1);
          until (vDsLstItemLote = '');
        end;
        if (vDsLstItemPrdFin <> '') then begin
          repeat
            getitem(vDsRegistro, vDsLstItemPrdFin, 1);

            creocc(tFIS_NFITEMPPR, -1);
            putitem_e(tFIS_NFITEMPPR, 'CD_EMPPRDFIN', itemXmlF('CD_EMPPRDFIN', vDsRegistro));
            putitem_e(tFIS_NFITEMPPR, 'NR_PRDFIN', itemXmlF('NR_PRDFIN', vDsRegistro));
            retrieve_o(tFIS_NFITEMPPR);
            if (xStatus = -7) then begin
              retrieve_x(tFIS_NFITEMPPR);
            end;
            putitem_e(tFIS_NFITEMPPR, 'CD_OPERADOR', itemXmlF('CD_USUARIO', PARAM_GLB));
            putitem_e(tFIS_NFITEMPPR, 'DT_CADASTRO', Now);

            delitem(vDsLstItemPrdFin, 1);
          until (vDsLstItemPrdFin = '');
        end;
      end;
      delitem(piDsLstProduto, 1);
    until (piDsLstProduto = '');
    setocc(tFIS_NFITEMPRO, 1);
  end;

  voParams := ocalg = 85)  or (viParams); (* TpModDctoFiscallocalg = 87) then begin

    putitem_e(tFIS_NFITEM, 'VL_TOTALLIQUIDO', 0);
    putitem_e(tFIS_NFITEM, 'VL_TOTALDESC', 0);
    putitem_e(tFIS_NFITEM, 'QT_FATURADO', 0);
    putitem_e(tFIS_NFITEM, 'VL_UNITBRUTO', 0);
    putitem_e(tFIS_NFITEM, 'VL_TOTALBRUTO', 0);
    putitem_e(tFIS_NFITEM, 'VL_UNITLIQUIDO', 0);
    putitem_e(tFIS_NFITEM, 'VL_UNITDESC', 0);
    putitem_e(tFIS_NF, 'VL_TOTALPRODUTO', 0);
    putitem_e(tFIS_NF, 'VL_DESCONTO', 0);
    putitem_e(tFIS_NF, 'QT_FATURADO', 0);
    putitem_e(tFIS_NF, 'VL_TOTALNOTA', 0);
    putitem_e(tFIS_NF, 'VL_BASEICMS', 0);
  end;

  putitem_e(tFIS_NF, 'VL_TOTALPRODUTO', item_f('VL_TOTALPRODUTO', tFIS_NF) + item_f('VL_TOTALLIQUIDO', tFIS_NFITEM));
  putitem_e(tFIS_NF, 'VL_DESCONTO', item_f('VL_DESCONTO', tFIS_NF) + item_f('VL_TOTALDESC', tFIS_NFITEM));
  putitem_e(tFIS_NF, 'QT_FATURADO', item_f('QT_FATURADO', tFIS_NF) + item_f('QT_FATURADO', tFIS_NFITEM));

  if (item_f('CD_DECRETO', tFIS_NFITEM) <> '')  and (gInGravaDsDecretoObsNf = True)  and (vInObs = True) then begin
    creocc(tFIS_DECRETO, -1);
    putitem_e(tFIS_DECRETO, 'CD_DECRETO', item_f('CD_DECRETO', tFIS_NFITEM));
    retrieve_o(tFIS_DECRETO);
    if (xStatus = -7) then begin
      retrieve_x(tFIS_DECRETO);
    end;
  end;

  putitem_e(tFIS_NFITEM, 'DS_LSTIMPOSTO', '');
  if (empty(tTMP_NR09) = False) then begin
    setocc(tTMP_NR09, 1);
    while (xStatus >= 0) do begin
      putlistitensocc_e(vDsRegistro, tTMP_NR09);
      putitem(item_a('DS_LSTIMPOSTO', tFIS_NFITEM),  vDsRegistro);
      setocc(tTMP_NR09, curocc(tTMP_NR09) + 1);
    end;
  end;

  return(0); exit;
end;

//---------------------------------------------------------------
function T_FISSVCO004.geraImpostoItem(pParams : String) : String;
//---------------------------------------------------------------
const
  cDS_METHOD = 'ADICIONAL=Operação: T_FISSVCO004.geraImpostoItem()';
var
  vCdImposto, vTpProducao, vTpRegime, vCdDecreto, vVlDiferimento : Real;
  vVlICMS2, vVlBaseICMS2, vVlICMSSubst2, vVlBaseICMSSubst2, vVlIPI2, vVlCalc, vVlDif : Real;
  vVlFator, vVlFatorLiquido, vVlFatorBruto : Real;
  vNrOccICMS, vNrOccSubst, vNrOccIPI, vNrSeq, vVlAplicado : Real;
  viParams, voParams, vDsOperacao, vDsRegistro, vDsLstImposto, vCdCST : String;
  vInICMS, vInICMSSubst, vInIPI, vInCOFINS, vInPIS : Boolean;
begin
  if (item_b('IN_CALCIMPOSTO', tGER_S_OPERACA) <> True) then begin
    return(0); exit;
  end;

  putitem_e(tFIS_NF, 'VL_IPI', 0);
  putitem_e(tFIS_NF, 'VL_BASEICMSSUBS', 0);
  putitem_e(tFIS_NF, 'VL_ICMSSUBST', 0);
  putitem_e(tFIS_NF, 'VL_BASEICMS', 0);
  putitem_e(tFIS_NF, 'VL_ICMS', 0);
  vVlICMS2 := 0;
  vVlBaseICMS2 := 0;
  vVlICMSSubst2 := 0;
  vVlBaseICMSSubst2 := 0;
  vVlFatorLiquido := 0;
  vVlFatorBruto := 0;
  vVlFator := 0;

  clear_e(tTMP_K02);

  if (empty(tFIS_NFITEM) = False) then begin
    setocc(tFIS_NFITEM, 1);
    while (xStatus >= 0) do begin
      setocc(tFIS_NFITEMPRO, 1);

      vVlFatorLiquido := (item_f('VL_DESPACESSOR', tFIS_NFITEM) + item_f('VL_FRETE', tFIS_NFITEM) + item_f('VL_SEGURO', tFIS_NFITEM) + item_f('VL_TOTALLIQUIDO', tFIS_NFITEM)) / item_f('VL_TOTALLIQUIDO', tFIS_NFITEM);
      vVlFatorBruto := (item_f('VL_DESPACESSOR', tFIS_NFITEM) + item_f('VL_FRETE', tFIS_NFITEM) + item_f('VL_SEGURO', tFIS_NFITEM) + item_f('VL_TOTALBRUTO', tFIS_NFITEM)) / item_f('VL_TOTALBRUTO', tFIS_NFITEM);

      if (item_b('IN_CALCIMPOSTO', tGER_OPERACAO) = True) then begin
        if (item_a('DS_LSTIMPOSTO', tFIS_NFITEM) <> '') then begin
          vDsLstImposto := item_a('DS_LSTIMPOSTO', tFIS_NFITEM);
          repeat
            getitem(vDsRegistro, vDsLstImposto, 1);
            vCdImposto := itemXmlF('NR_GERAL', vDsRegistro);
            if (vCdImposto > 0) then begin
              creocc(tFIS_NFITEMIMP, -1);
              putitem_e(tFIS_NFITEMIMP, 'CD_IMPOSTO', vCdImposto);
              putitem_e(tFIS_NFITEMIMP, 'CD_EMPFAT', item_f('CD_EMPFAT', tTRA_TRANSACAO));
              putitem_e(tFIS_NFITEMIMP, 'CD_GRUPOEMPRESA', item_f('CD_GRUPOEMPRESA', tTRA_TRANSACAO));
              putitem_e(tFIS_NFITEMIMP, 'PR_ALIQUOTA', itemXmlF('PR_ALIQUOTA', vDsRegistro));
              putitem_e(tFIS_NFITEMIMP, 'PR_BASECALC', itemXmlF('PR_BASECALC', vDsRegistro));
              putitem_e(tFIS_NFITEMIMP, 'PR_REDUBASE', itemXmlF('PR_REDUBASE', vDsRegistro));
              putitem_e(tFIS_NFITEMIMP, 'VL_BASECALC', itemXmlF('VL_BASECALC', vDsRegistro));
              putitem_e(tFIS_NFITEMIMP, 'VL_ISENTO', itemXmlF('VL_ISENTO', vDsRegistro));
              putitem_e(tFIS_NFITEMIMP, 'VL_OUTRO', itemXmlF('VL_OUTRO', vDsRegistro));
              putitem_e(tFIS_NFITEMIMP, 'VL_IMPOSTO', itemXmlF('VL_IMPOSTO', vDsRegistro));
              putitem_e(tFIS_NFITEMIMP, 'CD_PRODUTO', '');
              putitem_e(tFIS_NFITEMIMP, 'CD_OPERADOR', itemXmlF('CD_USUARIO', PARAM_GLB));
              putitem_e(tFIS_NFITEMIMP, 'DT_CADASTRO', Now);
              putitem_e(tFIS_NFITEMIMP, 'CD_CST', itemXmlF('CD_CST', vDsRegistro));

              if (item_f('CD_IMPOSTO', tFIS_NFITEMIMP) <> 4) then begin
                if (item_f('CD_IMPOSTO', tFIS_NFITEMIMP) = 3) then begin
                  vVlFator := 1;

                end else begin
                  vVlFator := vVlFatorLiquido;
                end;
                if (vVlFator > 1) then begin
                  putitem_e(tFIS_NFITEMIMP, 'VL_BASECALC', item_f('VL_BASECALC', tFIS_NFITEMIMP) * vVlFator);
                  putitem_e(tFIS_NFITEMIMP, 'VL_ISENTO', item_f('VL_ISENTO', tFIS_NFITEMIMP) * vVlFator);
                  putitem_e(tFIS_NFITEMIMP, 'VL_OUTRO', item_f('VL_OUTRO', tFIS_NFITEMIMP) * vVlFator);
                  putitem_e(tFIS_NFITEMIMP, 'VL_IMPOSTO', item_f('VL_IMPOSTO', tFIS_NFITEMIMP) * vVlFator);
                end;
              end;
              if (item_f('CD_IMPOSTO', tFIS_NFITEMIMP) = 1) then begin
                putitem_e(tFIS_NF, 'VL_BASEICMS', item_f('VL_BASEICMS', tFIS_NF) + item_f('VL_BASECALC', tFIS_NFITEMIMP));
                putitem_e(tFIS_NF, 'VL_ICMS', item_f('VL_ICMS', tFIS_NF) + item_f('VL_IMPOSTO', tFIS_NFITEMIMP));

                if (item_f('VL_BASECALC', tFIS_NFITEMIMP) > 0) then begin
                  creocc(tTMP_CSTALIQ, -1);
                  putitem_e(tTMP_CSTALIQ, 'CD_CST', item_f('CD_CST', tFIS_NFITEM));
                  putitem_e(tTMP_CSTALIQ, 'PR_ALIQUOTA', item_f('PR_ALIQUOTA', tFIS_NFITEMIMP));
                  retrieve_o(tTMP_CSTALIQ);
                  if (xStatus = -7) then begin
                    retrieve_x(tTMP_CSTALIQ);
                  end;
                  putitem_e(tTMP_CSTALIQ, 'VL_BASECALC', item_f('VL_BASECALC', tTMP_CSTALIQ) + item_f('VL_BASECALC', tFIS_NFITEMIMP));
                  putitem_e(tTMP_CSTALIQ, 'VL_IMPOSTO', item_f('VL_IMPOSTO', tTMP_CSTALIQ) + item_f('VL_IMPOSTO', tFIS_NFITEMIMP));
                end;
                if (item_f('CD_DECRETO', tFIS_NFITEM) = 6142) then begin
                  vVlDiferimento := item_f('VL_BASECALC', tFIS_NFITEMIMP) * item_f('PR_ALIQUOTA', tFIS_NFITEMIMP) / 100;
                  vVlDiferimento := rounded(vVlDiferimento, 6);
                  gVlICMSDiferido := gVlICMSDiferido + vVlDiferimento;
                end;
                creocc(tTMP_K02, -1);
                putitem_e(tTMP_K02, 'NR_CHAVE01', item_f('CD_IMPOSTO', tFIS_NFITEMIMP));
                putitem_e(tTMP_K02, 'NR_CHAVE02', curocc(tFIS_NFITEM));
                putitem_e(tTMP_K02, 'VL_GERAL', item_f('VL_IMPOSTO', tFIS_NFITEMIMP));
                putitem_e(tTMP_K02, 'PR_REDUBASE', item_f('PR_REDUBASE', tFIS_NFITEMIMP));
              end;
              if (item_f('CD_IMPOSTO', tFIS_NFITEMIMP) = 2) then begin
                putitem_e(tFIS_NF, 'VL_BASEICMSSUBS', item_f('VL_BASEICMSSUBS', tFIS_NF) + item_f('VL_BASECALC', tFIS_NFITEMIMP));
                putitem_e(tFIS_NF, 'VL_ICMSSUBST', item_f('VL_ICMSSUBST', tFIS_NF) + item_f('VL_IMPOSTO', tFIS_NFITEMIMP));
                creocc(tTMP_K02, -1);
                putitem_e(tTMP_K02, 'NR_CHAVE01', item_f('CD_IMPOSTO', tFIS_NFITEMIMP));
                putitem_e(tTMP_K02, 'NR_CHAVE02', curocc(tFIS_NFITEM));
                putitem_e(tTMP_K02, 'VL_GERAL', item_f('VL_IMPOSTO', tFIS_NFITEMIMP));
              end;
              if (item_f('CD_IMPOSTO', tFIS_NFITEMIMP) = 3) then begin
                putitem_e(tFIS_NF, 'VL_IPI', item_f('VL_IPI', tFIS_NF) + item_f('VL_IMPOSTO', tFIS_NFITEMIMP));
                creocc(tTMP_K02, -1);
                putitem_e(tTMP_K02, 'NR_CHAVE01', item_f('CD_IMPOSTO', tFIS_NFITEMIMP));
                putitem_e(tTMP_K02, 'NR_CHAVE02', curocc(tFIS_NFITEM));
                putitem_e(tTMP_K02, 'VL_GERAL', item_f('VL_IMPOSTO', tFIS_NFITEMIMP));
              end;

              vCdCST := item_f('CD_CST', tFIS_NFITEM)[2 : 2];
              if ((vCdCST = '10')  or (vCdCST = '30')  or (vCdCST = '60')  or (vCdCST = '70'))  and (gInSubstituicao = False) then begin
                gInSubstituicao := True;
              end;
            end;
            delitem(vDsLstImposto, 1);
          until (vDsLstImposto = '');
        end;
      end else begin
        viParams := '';
        putitemXml(viParams, 'CD_EMPRESA', item_f('CD_EMPFAT', tTRA_TRANSACAO));
        putitemXml(viParams, 'UF_DESTINO', item_a('DS_SIGLAESTADO', tTRA_REMDES));
        putitemXml(viParams, 'TP_ORIGEMEMISSAO', item_f('TP_ORIGEMEMISSAO', tTRA_TRANSACAO));
        if (item_f('CD_ESPECIE', tFIS_NFITEM) = gCdEspecieServico) then begin
          putitemXml(viParams, 'CD_SERVICO', item_f('CD_PRODUTO', tFIS_NFITEM));
        end else if (item_f('TP_MODALIDADE', tGER_S_OPERACA) = 'A') then begin
          putitemXml(viParams, 'CD_MPTER', item_f('CD_PRODUTO', tFIS_NFITEM));
        end else begin
          putitemXml(viParams, 'CD_PRODUTO', item_f('CD_PRODUTO', tFIS_NFITEMPRO));
        end;
        putitemXml(viParams, 'CD_OPERACAO', item_f('CD_OPERACAO', tGER_S_OPERACA));
        putitemXml(viParams, 'CD_PESSOA', item_f('CD_PESSOA', tTRA_REMDES));
        putitemXml(viParams, 'CD_CST', item_f('CD_CST', tFIS_NFITEM));
        putitemXml(viParams, 'VL_TOTALBRUTO', item_f('VL_TOTALBRUTO', tFIS_NFITEM));
        putitemXml(viParams, 'VL_TOTALLIQUIDO', item_f('VL_TOTALLIQUIDO', tFIS_NFITEM));
        putitemXml(viParams, 'TP_MODDCTOFISCAL', item_f('TP_MODDCTOFISCAL', tFIS_NF));
        putitemXml(viParams, 'NR_CODIGOFISCAL', gNrCodFiscal);
        putitemXml(viParams, 'DT_INIVIGENCIA', item_a('DT_EMISSAO', tFIS_NF));
        voParams := activateCmp('FISSVCO015', 'calculaImpostoItem', viParams); (*,,,, *)
        if (xStatus < 0) then begin
          Result := voParams;
          return(-1); exit;
        end;

        vDsLstImposto := itemXml('DS_LSTIMPOSTO', voParams);
        vCdCST := itemXmlF('CD_CST', voParams);
        vCdDecreto := itemXmlF('CD_DECRETO', voParams);

        if (vDsLstImposto <> '') then begin
          repeat
            getitem(vDsRegistro, vDsLstImposto, 1);

            creocc(tFIS_NFITEMIMP, -1);
            getlistitensocc_e(vDsRegistro, tFIS_NFITEMIMP);
            putitem_e(tFIS_NFITEMIMP, 'CD_EMPFAT', item_f('CD_EMPFAT', tTRA_TRANSACAO));
            putitem_e(tFIS_NFITEMIMP, 'CD_GRUPOEMPRESA', item_f('CD_GRUPOEMPRESA', tTRA_TRANSACAO));
            putitem_e(tFIS_NFITEMIMP, 'CD_OPERADOR', itemXmlF('CD_USUARIO', PARAM_GLB));
            putitem_e(tFIS_NFITEMIMP, 'DT_CADASTRO', Now);

            if (item_f('CD_IMPOSTO', tFIS_NFITEMIMP) <> 4) then begin
              if (item_f('CD_IMPOSTO', tFIS_NFITEMIMP) = 3) then begin
                vVlFator := 1;
              end else begin
                vVlFator := vVlFatorLiquido;
              end;
              if (vVlFator > 1) then begin
                putitem_e(tFIS_NFITEMIMP, 'VL_BASECALC', item_f('VL_BASECALC', tFIS_NFITEMIMP) * vVlFator);
                putitem_e(tFIS_NFITEMIMP, 'VL_ISENTO', item_f('VL_ISENTO', tFIS_NFITEMIMP) * vVlFator);
                putitem_e(tFIS_NFITEMIMP, 'VL_OUTRO', item_f('VL_OUTRO', tFIS_NFITEMIMP) * vVlFator);
                putitem_e(tFIS_NFITEMIMP, 'VL_IMPOSTO', item_f('VL_IMPOSTO', tFIS_NFITEMIMP) * vVlFator);
              end;
            end;
            if (item_f('CD_IMPOSTO', tFIS_NFITEMIMP) = 1) then begin
              if (item_f('VL_BASECALC', tFIS_NFITEMIMP) > 0) then begin
                creocc(tTMP_CSTALIQ, -1);
                putitem_e(tTMP_CSTALIQ, 'CD_CST', vCdCST);
                putitem_e(tTMP_CSTALIQ, 'PR_ALIQUOTA', item_f('PR_ALIQUOTA', tFIS_NFITEMIMP));
                retrieve_o(tTMP_CSTALIQ);
                if (xStatus = -7) then begin
                  retrieve_x(tTMP_CSTALIQ);
                end;
                putitem_e(tTMP_CSTALIQ, 'VL_BASECALC', item_f('VL_BASECALC', tTMP_CSTALIQ) + item_f('VL_BASECALC', tFIS_NFITEMIMP));
                putitem_e(tTMP_CSTALIQ, 'VL_IMPOSTO', item_f('VL_IMPOSTO', tTMP_CSTALIQ) + item_f('VL_IMPOSTO', tFIS_NFITEMIMP));
              end;
              putitem_e(tFIS_NF, 'VL_BASEICMS', item_f('VL_BASEICMS', tFIS_NF) + item_f('VL_BASECALC', tFIS_NFITEMIMP));
              putitem_e(tFIS_NF, 'VL_ICMS', item_f('VL_ICMS', tFIS_NF) + item_f('VL_IMPOSTO', tFIS_NFITEMIMP));
              if (vCdDecreto = 6142) then begin
                vVlDiferimento := item_f('VL_BASECALC', tFIS_NFITEMIMP) * item_f('PR_ALIQUOTA', tFIS_NFITEMIMP) / 100;
                vVlDiferimento := rounded(vVlDiferimento, 6);
                gVlICMSDiferido := gVlICMSDiferido + vVlDiferimento;
              end;
              creocc(tTMP_K02, -1);
              putitem_e(tTMP_K02, 'NR_CHAVE01', item_f('CD_IMPOSTO', tFIS_NFITEMIMP));
              putitem_e(tTMP_K02, 'NR_CHAVE02', curocc(tFIS_NFITEM));
              putitem_e(tTMP_K02, 'VL_GERAL', item_f('VL_IMPOSTO', tFIS_NFITEMIMP));
              putitem_e(tTMP_K02, 'PR_REDUBASE', item_f('PR_REDUBASE', tFIS_NFITEMIMP));
            end;
            if (item_f('CD_IMPOSTO', tFIS_NFITEMIMP) = 2) then begin
              putitem_e(tFIS_NF, 'VL_BASEICMSSUBS', item_f('VL_BASEICMSSUBS', tFIS_NF) + item_f('VL_BASECALC', tFIS_NFITEMIMP));
              putitem_e(tFIS_NF, 'VL_ICMSSUBST', item_f('VL_ICMSSUBST', tFIS_NF) + item_f('VL_IMPOSTO', tFIS_NFITEMIMP));
              creocc(tTMP_K02, -1);
              putitem_e(tTMP_K02, 'NR_CHAVE01', item_f('CD_IMPOSTO', tFIS_NFITEMIMP));
              putitem_e(tTMP_K02, 'NR_CHAVE02', curocc(tFIS_NFITEM));
              putitem_e(tTMP_K02, 'VL_GERAL', item_f('VL_IMPOSTO', tFIS_NFITEMIMP));
            end;
            if (item_f('CD_IMPOSTO', tFIS_NFITEMIMP) = 3) then begin
              putitem_e(tFIS_NF, 'VL_IPI', item_f('VL_IPI', tFIS_NF) + item_f('VL_IMPOSTO', tFIS_NFITEMIMP));
              creocc(tTMP_K02, -1);
              putitem_e(tTMP_K02, 'NR_CHAVE01', item_f('CD_IMPOSTO', tFIS_NFITEMIMP));
              putitem_e(tTMP_K02, 'NR_CHAVE02', curocc(tFIS_NFITEM));
              putitem_e(tTMP_K02, 'VL_GERAL', item_f('VL_IMPOSTO', tFIS_NFITEMIMP));
            end;

            delitem(vDsLstImposto, 1);
          until (vDsLstImposto = '');
        end;
      end;
      if (empty(tFIS_NFITEMIMP) = False)  and (gInNFe = True) then begin
        setocc(tFIS_NFITEMIMP, 1);
        while (xStatus >= 0) do begin
          if (item_f('CD_IMPOSTO', tFIS_NFITEMIMP) = 1) then begin
            if (gInArredondaTruncaIcms = True) then begin
              putitem_e(tFIS_NFITEMIMP, 'VL_BASECALC', rounded(item_f('VL_BASECALC', tFIS_NFITEMIMP), 2));
              putitem_e(tFIS_NFITEMIMP, 'VL_IMPOSTO', rounded(item_f('VL_IMPOSTO', tFIS_NFITEMIMP), 2));
            end else begin
              vVlCalc := item_f('VL_BASECALC', tFIS_NFITEMIMP) * 100;
              vVlCalc := int(vVlCalc);
              putitem_e(tFIS_NFITEMIMP, 'VL_BASECALC', vVlCalc / 100);
              vVlCalc := item_f('VL_IMPOSTO', tFIS_NFITEMIMP) * 100;
              vVlCalc := int(vVlCalc);
              putitem_e(tFIS_NFITEMIMP, 'VL_IMPOSTO', vVlCalc / 100);
            end;
            vVlBaseICMS2 := vVlBaseICMS2 + item_f('VL_BASECALC', tFIS_NFITEMIMP);
            vVlICMS2 := vVlICMS2 + item_f('VL_IMPOSTO', tFIS_NFITEMIMP);
          end;
          if (item_f('CD_IMPOSTO', tFIS_NFITEMIMP) = 2) then begin
            if (gInArredondaTruncaIcms = True) then begin
              putitem_e(tFIS_NFITEMIMP, 'VL_BASECALC', rounded(item_f('VL_BASECALC', tFIS_NFITEMIMP), 2));
              putitem_e(tFIS_NFITEMIMP, 'VL_IMPOSTO', rounded(item_f('VL_IMPOSTO', tFIS_NFITEMIMP), 2));
            end else begin
              vVlCalc := item_f('VL_BASECALC', tFIS_NFITEMIMP) * 100;
              vVlCalc := int(vVlCalc);
              putitem_e(tFIS_NFITEMIMP, 'VL_BASECALC', vVlCalc / 100);
              vVlCalc := item_f('VL_IMPOSTO', tFIS_NFITEMIMP) * 100;
              vVlCalc := int(vVlCalc);
              putitem_e(tFIS_NFITEMIMP, 'VL_IMPOSTO', vVlCalc / 100);
            end;
            vVlBaseICMSSubst2 := vVlBaseICMSSubst2 + item_f('VL_BASECALC', tFIS_NFITEMIMP);
            vVlICMSSubst2 := vVlICMSSubst2 + item_f('VL_IMPOSTO', tFIS_NFITEMIMP);
          end;
          if (item_f('CD_IMPOSTO', tFIS_NFITEMIMP) = 3) then begin
            if (gInArredondaTruncaIcms = True) then begin
              putitem_e(tFIS_NFITEMIMP, 'VL_BASECALC', rounded(item_f('VL_BASECALC', tFIS_NFITEMIMP), 2));
              putitem_e(tFIS_NFITEMIMP, 'VL_IMPOSTO', rounded(item_f('VL_IMPOSTO', tFIS_NFITEMIMP), 2));
            end else begin
              vVlCalc := item_f('VL_BASECALC', tFIS_NFITEMIMP) * 100;
              vVlCalc := int(vVlCalc);
              putitem_e(tFIS_NFITEMIMP, 'VL_BASECALC', vVlCalc / 100);
              vVlCalc := item_f('VL_IMPOSTO', tFIS_NFITEMIMP) * 100;
              vVlCalc := int(vVlCalc);
              putitem_e(tFIS_NFITEMIMP, 'VL_IMPOSTO', vVlCalc / 100);
            end;
            vVlIPI2 := vVlIPI2 + item_f('VL_IMPOSTO', tFIS_NFITEMIMP);
          end;

          setocc(tFIS_NFITEMIMP, curocc(tFIS_NFITEMIMP) + 1);
        end;
      end;
      if (gInGravaDsDecretoObsNf = True)  and (item_f('CD_DECRETO', tFIS_NFITEM) > 0) then begin
        creocc(tFIS_DECRETO, -1);
        putitem_e(tFIS_DECRETO, 'CD_DECRETO', item_f('CD_DECRETO', tFIS_NFITEM));
        retrieve_o(tFIS_DECRETO);
        if (xStatus = -7) then begin
          retrieve_x(tFIS_DECRETO);
        end;
      end;

      setocc(tFIS_NFITEM, curocc(tFIS_NFITEM) + 1);
    end;
    if (gInNFe = True) then begin
      sort_e(tTMP_K02, '      sort/e , NR_CHAVE01:a, PR_REDUBASE:d, VL_GERAL:d;');

      vNrOccICMS := 0;
      vNrOccSubst := 0;
      vNrOccIPI := 0;

      setocc(tTMP_K02, 1);
      while (xStatus >= 0) do begin
        if (item_f('NR_CHAVE01', tTMP_K02) = 1)  and (vNrOccICMS = 0) then begin
          vNrOccICMS := curocc(tTMP_K02);
        end;
        if (item_f('NR_CHAVE01', tTMP_K02) = 2)  and (vNrOccSubst = 0) then begin
          vNrOccSubst := curocc(tTMP_K02);
        end;
        if (item_f('NR_CHAVE01', tTMP_K02) = 3)  and (vNrOccIPI = 0) then begin
          vNrOccIPI := curocc(tTMP_K02);
        end;
        setocc(tTMP_K02, curocc(tTMP_K02) + 1);
      end;

      vVlDif := rounded(item_f('VL_BASEICMS', tFIS_NF), 2) - vVlBaseICMS2;

      vNrSeq := 0;
      while (vVlDif <> 0) do begin
        if (vVlDif > 0) then begin
          if (vVlDif > 0.9) then begin
            vVlAplicado := 0.9;
            vVlDif := vVlDif - 0.9;
          end else begin
            vVlAplicado := vVlDif;
            vVlDif := 0;
          end;
        end else begin
          if (vVlDif < -0.9) then begin
            vVlAplicado := -0.9;
            vVlDif := vVlDif + 0.9;
          end else begin
            vVlAplicado := vVlDif;
            vVlDif := 0;
          end;
        end;
        setocc(tTMP_K02, curocc(tTMP_K02) + 1);
        if (xStatus >= 0) then begin
          setocc(tFIS_NFITEM, 1);
          creocc(tFIS_NFITEMIMP, -1);
          putitem_e(tFIS_NFITEMIMP, 'CD_IMPOSTO', 1);
          retrieve_o(tFIS_NFITEMIMP);
          if (xStatus = 4) then begin
            putitem_e(tFIS_NFITEMIMP, 'VL_BASECALC', item_f('VL_BASECALC', tFIS_NFITEMIMP) + vVlAplicado);
          end else begin
            discard(tFIS_NFITEMIMP);
          end;
        end;
        vNrSeq := vNrSeq + 1;
      end;

      vVlDif := rounded(item_f('VL_ICMS', tFIS_NF), 2) - vVlICMS2;

      vNrSeq := 0;
      while (vVlDif <> 0) do begin
        if (vVlDif > 0) then begin
          if (vVlDif > 0.9) then begin
            vVlAplicado := 0.9;
            vVlDif := vVlDif - 0.9;
          end else begin
            vVlAplicado := vVlDif;
            vVlDif := 0;
          end;
        end else begin
          if (vVlDif < -0.9) then begin
            vVlAplicado := -0.9;
            vVlDif := vVlDif + 0.9;
          end else begin
            vVlAplicado := vVlDif;
            vVlDif := 0;
          end;
        end;
        setocc(tTMP_K02, curocc(tTMP_K02) + 1);
        if (xStatus >= 0) then begin
          setocc(tFIS_NFITEM, 1);
          creocc(tFIS_NFITEMIMP, -1);
          putitem_e(tFIS_NFITEMIMP, 'CD_IMPOSTO', 1);
          retrieve_o(tFIS_NFITEMIMP);
          if (xStatus = 4) then begin
            putitem_e(tFIS_NFITEMIMP, 'VL_IMPOSTO', item_f('VL_IMPOSTO', tFIS_NFITEMIMP) + vVlAplicado);
          end else begin
            discard(tFIS_NFITEMIMP);
          end;
        end;
        vNrSeq := vNrSeq + 1;
      end;

      vVlDif := rounded(item_f('VL_BASEICMSSUBS', tFIS_NF), 2) - vVlBaseICMSSubst2;

      vNrSeq := 0;
      while (vVlDif <> 0) do begin
        if (vVlDif > 0) then begin
          if (vVlDif > 0.9) then begin
            vVlAplicado := 0.9;
            vVlDif := vVlDif - 0.9;
          end else begin
            vVlAplicado := vVlDif;
            vVlDif := 0;
          end;
        end else begin
          if (vVlDif < -0.9) then begin
            vVlAplicado := -0.9;
            vVlDif := vVlDif + 0.9;
          end else begin
            vVlAplicado := vVlDif;
            vVlDif := 0;
          end;
        end;
        setocc(tTMP_K02, curocc(tTMP_K02) + 1);
        if (xStatus >= 0) then begin
          setocc(tFIS_NFITEM, 1);
          creocc(tFIS_NFITEMIMP, -1);
          putitem_e(tFIS_NFITEMIMP, 'CD_IMPOSTO', 2);
          retrieve_o(tFIS_NFITEMIMP);
          if (xStatus = 4) then begin
            putitem_e(tFIS_NFITEMIMP, 'VL_BASECALC', item_f('VL_BASECALC', tFIS_NFITEMIMP) + vVlAplicado);
          end else begin
            discard(tFIS_NFITEMIMP);
          end;
        end;
        vNrSeq := vNrSeq + 1;
      end;

      vVlDif := rounded(item_f('VL_ICMSSUBST', tFIS_NF), 2) - vVlICMSSubst2;

      vNrSeq := 0;
      while (vVlDif <> 0) do begin
        if (vVlDif > 0) then begin
          if (vVlDif > 0.9) then begin
            vVlAplicado := 0.9;
            vVlDif := vVlDif - 0.9;
          end else begin
            vVlAplicado := vVlDif;
            vVlDif := 0;
          end;
        end else begin
          if (vVlDif < -0.9) then begin
            vVlAplicado := -0.9;
            vVlDif := vVlDif + 0.9;
          end else begin
            vVlAplicado := vVlDif;
            vVlDif := 0;
          end;
        end;
        setocc(tTMP_K02, curocc(tTMP_K02) + 1);
        if (xStatus >= 0) then begin
          setocc(tFIS_NFITEM, 1);
          creocc(tFIS_NFITEMIMP, -1);
          putitem_e(tFIS_NFITEMIMP, 'CD_IMPOSTO', 2);
          retrieve_o(tFIS_NFITEMIMP);
          if (xStatus = 4) then begin
            putitem_e(tFIS_NFITEMIMP, 'VL_IMPOSTO', item_f('VL_IMPOSTO', tFIS_NFITEMIMP) + vVlAplicado);
          end else begin
            discard(tFIS_NFITEMIMP);
          end;
        end;
        vNrSeq := vNrSeq + 1;
      end;

      vVlDif := rounded(item_f('VL_IPI', tFIS_NF), 2) - vVlIPI2;

      vNrSeq := 0;
      while (vVlDif <> 0) do begin
        if (vVlDif > 0) then begin
          if (vVlDif > 0.9) then begin
            vVlAplicado := 0.9;
            vVlDif := vVlDif - 0.9;
          end else begin
            vVlAplicado := vVlDif;
            vVlDif := 0;
          end;
        end else begin
          if (vVlDif < -0.9) then begin
            vVlAplicado := -0.9;
            vVlDif := vVlDif + 0.9;
          end else begin
            vVlAplicado := vVlDif;
            vVlDif := 0;
          end;
        end;
        setocc(tTMP_K02, curocc(tTMP_K02) + 1);
        if (xStatus >= 0) then begin
          setocc(tFIS_NFITEM, 1);
          creocc(tFIS_NFITEMIMP, -1);
          putitem_e(tFIS_NFITEMIMP, 'CD_IMPOSTO', 3);
          retrieve_o(tFIS_NFITEMIMP);
          if (xStatus = 4) then begin
            putitem_e(tFIS_NFITEMIMP, 'VL_IMPOSTO', item_f('VL_IMPOSTO', tFIS_NFITEMIMP) + vVlAplicado);
          end else begin
            discard(tFIS_NFITEMIMP);
          end;
        end;
        vNrSeq := vNrSeq + 1;
      end;
    end;
  end;

  return(0); exit;
end;

//-------------------------------------------------------------
function T_FISSVCO004.geraTransport(pParams : String) : String;
//-------------------------------------------------------------
const
  cDS_METHOD = 'ADICIONAL=Operação: T_FISSVCO004.geraTransport()';
begin
  putitem_e(tFIS_NF, 'VL_DESPACESSOR', item_f('VL_DESPACESSOR', tTRA_TRANSACAO));
  putitem_e(tFIS_NF, 'VL_FRETE', item_f('VL_FRETE', tTRA_TRANSACAO));
  putitem_e(tFIS_NF, 'VL_SEGURO', item_f('VL_SEGURO', tTRA_TRANSACAO));

  if (empty(tTRA_TRANSPORT) = False) then begin
    if (item_f('CD_TRANSPORT', tTRA_TRANSPORT) = 0) then begin
      return(0); exit;
    end;
    if (item_f('TP_FRETE', tTRA_TRANSPORT) = '') then begin
      return(0); exit;
    end;

    setocc(tTRA_TRANSPORT, 1);
    while (xStatus >= 0) do begin
      creocc(tFIS_NFTRANSP, -1);
      putitem_e(tFIS_NFTRANSP, 'CD_TRANSPORT', item_f('CD_TRANSPORT', tTRA_TRANSPORT));
      putitem_e(tFIS_NFTRANSP, 'NM_TRANSPORT', item_a('NM_TRANSPORT', tTRA_TRANSPORT));
      putitem_e(tFIS_NFTRANSP, 'CD_EMPFAT', item_f('CD_EMPFAT', tTRA_TRANSACAO));
      putitem_e(tFIS_NFTRANSP, 'CD_GRUPOEMPRESA', item_f('CD_GRUPOEMPRESA', tTRA_TRANSACAO));
      putitem_e(tFIS_NFTRANSP, 'TP_FRETE', item_f('TP_FRETE', tTRA_TRANSPORT));
      putitem_e(tFIS_NFTRANSP, 'QT_VOLUME', item_f('QT_VOLUME', tTRA_TRANSPORT));
      putitem_e(tFIS_NFTRANSP, 'CD_TRANSREDESPAC', item_f('CD_TRANSREDESPAC', tTRA_TRANSPORT));
      putitem_e(tFIS_NFTRANSP, 'NM_TRANSREDESPAC', item_a('NM_TRANSREDESPAC', tTRA_TRANSPORT));
      putitem_e(tFIS_NFTRANSP, 'NR_PLACA', item_f('NR_PLACA', tTRA_TRANSPORT));
      putitem_e(tFIS_NFTRANSP, 'QT_PESOBRUTO', item_f('QT_PESOBRUTO', tTRA_TRANSPORT));
      putitem_e(tFIS_NFTRANSP, 'QT_PESOLIQUIDO', item_f('QT_PESOLIQUIDO', tTRA_TRANSPORT));
      putitem_e(tFIS_NFTRANSP, 'VL_FRETE', item_f('VL_FRETE', tTRA_TRANSPORT));
      putitem_e(tFIS_NFTRANSP, 'DS_ESPECIE', item_a('DS_ESPECIE', tTRA_TRANSPORT));
      putitem_e(tFIS_NFTRANSP, 'DS_MARCA', item_a('DS_MARCA', tTRA_TRANSPORT));
      putitem_e(tFIS_NFTRANSP, 'NR_PLACA', item_f('NR_PLACA', tTRA_TRANSPORT));
      putitem_e(tFIS_NFTRANSP, 'DS_UFPLACA', item_a('DS_UFPLACA', tTRA_TRANSPORT));
      putitem_e(tFIS_NFTRANSP, 'NM_LOGRADOURO', item_a('NM_LOGRADOURO', tTRA_TRANSPORT));
      putitem_e(tFIS_NFTRANSP, 'DS_TPLOGRADOURO', item_a('DS_TPLOGRADOURO', tTRA_TRANSPORT));
      putitem_e(tFIS_NFTRANSP, 'NR_LOGRADOURO', item_f('NR_LOGRADOURO', tTRA_TRANSPORT));
      putitem_e(tFIS_NFTRANSP, 'NR_CAIXAPOSTAL', item_f('NR_CAIXAPOSTAL', tTRA_TRANSPORT));
      putitem_e(tFIS_NFTRANSP, 'NM_BAIRRO', item_a('NM_BAIRRO', tTRA_TRANSPORT));
      putitem_e(tFIS_NFTRANSP, 'CD_CEP', item_f('CD_CEP', tTRA_TRANSPORT));
      putitem_e(tFIS_NFTRANSP, 'NM_MUNICIPIO', item_a('NM_MUNICIPIO', tTRA_TRANSPORT));
      putitem_e(tFIS_NFTRANSP, 'DS_SIGLAESTADO', item_a('DS_SIGLAESTADO', tTRA_TRANSPORT));
      putitem_e(tFIS_NFTRANSP, 'NR_RGINSCREST', item_f('NR_RGINSCREST', tTRA_TRANSPORT));
      putitem_e(tFIS_NFTRANSP, 'NR_CPFCNPJ', item_f('NR_CPFCNPJ', tTRA_TRANSPORT));
      putitem_e(tFIS_NFTRANSP, 'CD_OPERADOR', itemXmlF('CD_USUARIO', PARAM_GLB));
      putitem_e(tFIS_NFTRANSP, 'DT_CADASTRO', Now);
      setocc(tTRA_TRANSPORT, curocc(tTRA_TRANSPORT) + 1);
    end;
  end;

  return(0); exit;

end;

//---------------------------------------------------------------
function T_FISSVCO004.rateiaValorCapa(pParams : String) : String;
//---------------------------------------------------------------
const
  cDS_METHOD = 'ADICIONAL=Operação: T_FISSVCO004.rateiaValorCapa()';
var
  vVlCalc, vVlRestoDespAcessor, vVlRestoFrete, vVlRestoSeguro, vNrOccItem, vVlMaiorItem : Real;
begin
  if (gTpLancamentoFrete <> 2) then begin
    return(0); exit;
  end;

  vVlRestoDespAcessor := item_f('VL_DESPACESSOR', tFIS_NF);
  vVlRestoFrete := item_f('VL_FRETE', tFIS_NF);
  vVlRestoSeguro := item_f('VL_SEGURO', tFIS_NF);

  if (empty(tFIS_NFITEM) = False) then begin
    setocc(tFIS_NFITEM, 1);
    while (xStatus >= 0) do begin
      vVlCalc := (item_f('VL_TOTALLIQUIDO', tFIS_NFITEM) / item_f('VL_TOTALPRODUTO', tFIS_NF)) * item_f('VL_DESPACESSOR', tFIS_NF);
      putitem_e(tFIS_NFITEM, 'VL_DESPACESSOR', rounded(vVlCalc, 2));
      vVlCalc := (item_f('VL_TOTALLIQUIDO', tFIS_NFITEM) / item_f('VL_TOTALPRODUTO', tFIS_NF)) * item_f('VL_FRETE', tFIS_NF);
      putitem_e(tFIS_NFITEM, 'VL_FRETE', rounded(vVlCalc, 2));
      vVlCalc := (item_f('VL_TOTALLIQUIDO', tFIS_NFITEM) / item_f('VL_TOTALPRODUTO', tFIS_NF)) * item_f('VL_SEGURO', tFIS_NF);
      putitem_e(tFIS_NFITEM, 'VL_SEGURO', rounded(vVlCalc, 2));
      vVlRestoDespAcessor := vVlRestoDespAcessor - item_f('VL_DESPACESSOR', tFIS_NFITEM);
      vVlRestoFrete := vVlRestoFrete - item_f('VL_FRETE', tFIS_NFITEM);
      vVlRestoSeguro := vVlRestoSeguro - item_f('VL_SEGURO', tFIS_NFITEM);
      if (item_f('VL_TOTALLIQUIDO', tFIS_NFITEM) > vVlMaiorItem) then begin
        vVlMaiorItem := item_f('VL_TOTALLIQUIDO', tFIS_NFITEM);
        vNrOccItem := curocc(tFIS_NFITEM);
      end;
      setocc(tFIS_NFITEM, curocc(tFIS_NFITEM) + 1);
    end;
  end;
  if (vVlRestoDespAcessor <> 0) then begin
    setocc(tFIS_NFITEM, 1);
    putitem_e(tFIS_NFITEM, 'VL_DESPACESSOR', item_f('VL_DESPACESSOR', tFIS_NFITEM) + vVlRestoDespAcessor);
  end;
  if (vVlRestoFrete <> 0) then begin
    setocc(tFIS_NFITEM, 1);
    putitem_e(tFIS_NFITEM, 'VL_FRETE', item_f('VL_FRETE', tFIS_NFITEM) + vVlRestoFrete);
  end;
  if (vVlRestoSeguro <> 0) then begin
    setocc(tFIS_NFITEM, 1);
    putitem_e(tFIS_NFITEM, 'VL_SEGURO', item_f('VL_SEGURO', tFIS_NFITEM) + vVlRestoSeguro);
  end;

  return(0); exit;
end;

//-----------------------------------------------------------
function T_FISSVCO004.geraParcela(pParams : String) : String;
//-----------------------------------------------------------
const
  cDS_METHOD = 'ADICIONAL=Operação: T_FISSVCO004.geraParcela()';
var
  viParams, voParams : String;
  vNrParcela, vVlResto, vVlParcela, vVlCalc, vVlFinanceiro, vPrFinanceiro, vVlNota : Real;
  vDtSistema : TDate;
begin
  vDtSistema := itemXml('DT_SISTEMA', PARAM_GLB);

  if (item_b('IN_FINANCEIRO', tGER_S_OPERACA) <> True)  and (item_b('IN_FINANCEIRO', tGER_OPERACAO) <> True) then begin
    return(0); exit;
  end;

  viParams := '';
  putitemXml(viParams, 'CD_EMPRESA', item_f('CD_EMPRESA', tTRA_TRANSACAO));
  putitemXml(viParams, 'NR_TRANSACAO', item_f('NR_TRANSACAO', tTRA_TRANSACAO));
  putitemXml(viParams, 'DT_TRANSACAO', item_a('DT_TRANSACAO', tTRA_TRANSACAO));
  voParams := activateCmp('GERSVCO058', 'buscaValorFinanceiroTransacao', viParams); (*,,,, *)
  if (xStatus < 0) then begin
    Result := voParams;
    return(-1); exit;
  end;

  vVlFinanceiro := itemXmlF('VL_FINANCEIRO', voParams);

  if (vVlFinanceiro <> item_f('VL_TOTAL', tTRA_TRANSACAO)) then begin
    vPrFinanceiro := vVlFinanceiro / item_f('VL_TOTAL', tTRA_TRANSACAO) * 100;
    vVlNota := item_f('VL_TOTALNOTA', tFIS_NF) * vPrFinanceiro / 100;
  end else begin
    vVlNota := item_f('VL_TOTALNOTA', tFIS_NF);
  end;

  vVlResto := vVlNota;

  if (empty(tTRA_VENCIMENT) = False) then begin
    setocc(tTRA_VENCIMENT, 1);
    while (xStatus >= 0) do begin
      vNrParcela := vNrParcela + 1;

      vVlCalc := (item_f('VL_PARCELA', tTRA_VENCIMENT) / vVlFinanceiro) * vVlNota;

      vVlParcela := rounded(vVlCalc, 2);
      vVlResto := vVlResto - vVlParcela;

      creocc(tFIS_NFVENCTO, -1);
      putitem_e(tFIS_NFVENCTO, 'NR_PARCELA', vNrParcela);
      putitem_e(tFIS_NFVENCTO, 'CD_EMPFAT', item_f('CD_EMPFAT', tTRA_TRANSACAO));
      putitem_e(tFIS_NFVENCTO, 'CD_GRUPOEMPRESA', item_f('CD_GRUPOEMPRESA', tTRA_TRANSACAO));
      putitem_e(tFIS_NFVENCTO, 'CD_OPERADOR', itemXmlF('CD_USUARIO', PARAM_GLB));
      putitem_e(tFIS_NFVENCTO, 'DT_CADASTRO', Now);
      putitem_e(tFIS_NFVENCTO, 'VL_PARCELA', vVlParcela);
      putitem_e(tFIS_NFVENCTO, 'DT_VENCIMENTO', item_a('DT_VENCIMENTO', tTRA_VENCIMENT));
      if (item_a('DT_VENCIMENTO', tFIS_NFVENCTO) < vDtSistema) then begin
        putitem_e(tFIS_NFVENCTO, 'DT_VENCIMENTO', vDtSistema);
      end;
      putitem_e(tFIS_NFVENCTO, 'TP_FORMAPGTO', item_f('TP_FORMAPGTO', tTRA_VENCIMENT));

      setocc(tTRA_VENCIMENT, curocc(tTRA_VENCIMENT) + 1);
    end;
    if (vVlResto <> 0) then begin
      setocc(tFIS_NFVENCTO, 1);
      putitem_e(tFIS_NFVENCTO, 'VL_PARCELA', item_f('VL_PARCELA', tFIS_NFVENCTO) + vVlResto);
    end;
  end else begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Transação ' + CD_EMPFAT + '.TRA_TRANSACAO / ' + NR_TRANSACAO + '.TRA_TRANSACAO não possui parcelamento!', cDS_METHOD);
    return(-1); exit;
  end;

  return(0); exit;
end;

//-----------------------------------------------------------
function T_FISSVCO004.geraRemDest(pParams : String) : String;
//-----------------------------------------------------------
const
  cDS_METHOD = 'ADICIONAL=Operação: T_FISSVCO004.geraRemDest()';
var
  viParams, voParams : String;
begin
  if (empty(tTRA_REMDES) <> False) then begin
    viParams := '';
    putitemXml(viParams, 'CD_EMPRESA', item_f('CD_EMPRESA', tTRA_TRANSACAO));
    putitemXml(viParams, 'NR_TRANSACAO', item_f('NR_TRANSACAO', tTRA_TRANSACAO));
    putitemXml(viParams, 'DT_TRANSACAO', item_a('DT_TRANSACAO', tTRA_TRANSACAO));
    voParams := activateCmp('TRASVCO004', 'gravaenderecoTransacao', viParams); (*,,,, *)

    clear_e(tTRA_REMDES);
    retrieve_e(tTRA_REMDES);
    if (xStatus < 0) then begin
      Result := SetStatus(STS_ERROR, 'GEN0001', 'Transação ' + CD_EMPFAT + '.TRA_TRANSACAO / ' + NR_TRANSACAO + '.TRA_TRANSACAO não possui dados do emitende/destinatário!', cDS_METHOD);
      return(-1); exit;
    end;
  end;

  creocc(tFIS_NFREMDES, -1);
  putitem_e(tFIS_NFREMDES, 'CD_EMPFAT', item_f('CD_EMPFAT', tTRA_TRANSACAO));
  putitem_e(tFIS_NFREMDES, 'CD_GRUPOEMPRESA', item_f('CD_GRUPOEMPRESA', tTRA_TRANSACAO));
  putitem_e(tFIS_NFREMDES, 'CD_OPERADOR', itemXmlF('CD_USUARIO', PARAM_GLB));
  putitem_e(tFIS_NFREMDES, 'DT_CADASTRO', Now);
  putitem_e(tFIS_NFREMDES, 'NM_NOME', item_a('NM_NOME', tTRA_REMDES));
  putitem_e(tFIS_NFREMDES, 'TP_PESSOA', item_f('TP_PESSOA', tTRA_REMDES));
  putitem_e(tFIS_NFREMDES, 'CD_PESSOA', item_f('CD_PESSOA', tTRA_REMDES));
  putitem_e(tFIS_NFREMDES, 'IN_CONTRIBUINTE', item_b('IN_CONTRIBUINTE', tTRA_REMDES));
  putitem_e(tFIS_NFREMDES, 'CD_CEP', item_f('CD_CEP', tTRA_REMDES));
  putitem_e(tFIS_NFREMDES, 'NR_RGINSCREST', item_f('NR_RGINSCREST', tTRA_REMDES));
  putitem_e(tFIS_NFREMDES, 'NR_CPFCNPJ', item_f('NR_CPFCNPJ', tTRA_REMDES));
  putitem_e(tFIS_NFREMDES, 'DS_TPLOGRADOURO', item_a('DS_TPLOGRADOURO', tTRA_REMDES));
  putitem_e(tFIS_NFREMDES, 'NM_LOGRADOURO', item_a('NM_LOGRADOURO', tTRA_REMDES));
  putitem_e(tFIS_NFREMDES, 'NM_COMPLEMENTO', item_a('NM_COMPLEMENTO', tTRA_REMDES));
  putitem_e(tFIS_NFREMDES, 'NR_LOGRADOURO', item_f('NR_LOGRADOURO', tTRA_REMDES));
  putitem_e(tFIS_NFREMDES, 'NM_BAIRRO', item_a('NM_BAIRRO', tTRA_REMDES));
  putitem_e(tFIS_NFREMDES, 'NM_MUNICIPIO', item_a('NM_MUNICIPIO', tTRA_REMDES));
  putitem_e(tFIS_NFREMDES, 'DS_SIGLAESTADO', item_a('DS_SIGLAESTADO', tTRA_REMDES));
  putitem_e(tFIS_NFREMDES, 'NR_CAIXAPOSTAL', item_f('NR_CAIXAPOSTAL', tTRA_REMDES));
  putitem_e(tFIS_NFREMDES, 'NR_TELEFONE', item_f('NR_TELEFONE', tTRA_REMDES));

  return(0); exit;

end;

//-------------------------------------------------------
function T_FISSVCO004.geraECF(pParams : String) : String;
//-------------------------------------------------------
const
  cDS_METHOD = 'ADICIONAL=Operação: T_FISSVCO004.geraECF()';
begin
  if (empty(tTRA_TRANSACEC) = False) then begin
    creocc(tFIS_NFECF, -1);
    putitem_e(tFIS_NFECF, 'CD_EMPECF', item_f('CD_EMPECF', tTRA_TRANSACEC));
    putitem_e(tFIS_NFECF, 'NR_ECF', item_f('NR_ECF', tTRA_TRANSACEC));
    putitem_e(tFIS_NFECF, 'CD_EMPFAT', item_f('CD_EMPFAT', tTRA_TRANSACAO));
    putitem_e(tFIS_NFECF, 'CD_GRUPOEMPRESA', item_f('CD_GRUPOEMPRESA', tTRA_TRANSACAO));
    putitem_e(tFIS_NFECF, 'CD_OPERADOR', itemXmlF('CD_USUARIO', PARAM_GLB));
    putitem_e(tFIS_NFECF, 'DT_CADASTRO', Now);
    putitem_e(tFIS_NFECF, 'NR_CUPOM', item_f('NR_CUPOM', tTRA_TRANSACEC));
  end;

  return(0); exit;

end;

//--------------------------------------------------------------
function T_FISSVCO004.geraObservacao(pParams : String) : String;
//--------------------------------------------------------------
const
  cDS_METHOD = 'ADICIONAL=Operação: T_FISSVCO004.geraObservacao()';
var
  (* string pDsLinhaObs : IN *)
  vDsLinha, vDsAdicional, vDsLinhaObs, vDsDecreto, viParams, voParams, vDsLinhaAux : String;
  vNrLinha, vNrPos, vNrPosDecreto : Real;
begin
  vNrLinha := 0;

  if (gInPDVOtimizado <> True) then begin
    if (gVlICMSDiferido > 0) then begin
      gVlICMSDiferido := rounded(gVlICMSDiferido, 2);
      gVlICMSDiferido := gVlICMSDiferido - item_f('VL_ICMS', tFIS_NF);
      if (gVlICMSDiferido > 0) then begin
        creocc(tOBS_NF, -1);
        vNrLinha := vNrLinha + 1;
        putitem_e(tOBS_NF, 'NR_LINHA', vNrLinha);
        putitem_e(tOBS_NF, 'CD_EMPFAT', item_f('CD_EMPFAT', tTRA_TRANSACAO));
        putitem_e(tOBS_NF, 'CD_GRUPOEMPRESA', item_f('CD_GRUPOEMPRESA', tTRA_TRANSACAO));
        vDsLinha := 'ICMS DIF.PARC. EM 33, 33% CONF.ART. 96 INCISO I DO RICMS-PR: ' + FloatToStr(gVlICMSDiferido') + ';
        putitem_e(tOBS_NF, 'CD_OPERADOR', itemXmlF('CD_USUARIO', PARAM_GLB));
        putitem_e(tOBS_NF, 'DT_CADASTRO', Now);
        putitem_e(tOBS_NF, 'DS_OBSERVACAO', vDsLinha[1 : 80]);
      end;
    end;
    if (empty(tTMP_CSTALIQ) = False)  and (item_f('TP_ORIGEMEMISSAO', tTRA_TRANSACAO) = 1) then begin
      if (gInExibeResumoCstNF = True) then begin
        setocc(tTMP_CSTALIQ, 1);
        while (xStatus >= 0) do begin
          creocc(tOBS_NF, -1);
          vNrLinha := vNrLinha + 1;
          putitem_e(tOBS_NF, 'NR_LINHA', vNrLinha);
          putitem_e(tOBS_NF, 'CD_EMPFAT', item_f('CD_EMPFAT', tTRA_TRANSACAO));
          putitem_e(tOBS_NF, 'CD_GRUPOEMPRESA', item_f('CD_GRUPOEMPRESA', tTRA_TRANSACAO));
          vDsLinha := 'CST ' + CD_CST + '.TMP_CSTALIQ ICMS ' + PR_ALIQUOTA + '.TMP_CSTALIQ';
          gVlBaseCalc := rounded(item_f('VL_BASECALC', tTMP_CSTALIQ), 2);
          gVlImposto := rounded(item_f('VL_IMPOSTO', tTMP_CSTALIQ), 2);
          vDsLinha := '' + vDsLinha + ' ' + FloatToStr(gVlBaseCalc) + ' := ' + FloatToStr(gVlImposto') + ';
          putitem_e(tOBS_NF, 'CD_OPERADOR', itemXmlF('CD_USUARIO', PARAM_GLB));
          putitem_e(tOBS_NF, 'DT_CADASTRO', Now);
          putitem_e(tOBS_NF, 'DS_OBSERVACAO', vDsLinha[1 : 80]);
          setocc(tTMP_CSTALIQ, curocc(tTMP_CSTALIQ) + 1);
        end;
      end;
    end;
    if (gInExibeResumoCfopNF = True) then begin
      if (empty(tF_TMP_NR09) = False) then begin
        setocc(tF_TMP_NR09, 1);
        while (xStatus >= 0) do begin
          creocc(tOBS_NF, -1);
          vNrLinha := vNrLinha + 1;
          putitem_e(tOBS_NF, 'NR_LINHA', vNrLinha);
          putitem_e(tOBS_NF, 'CD_EMPFAT', item_f('CD_EMPFAT', tTRA_TRANSACAO));
          putitem_e(tOBS_NF, 'CD_GRUPOEMPRESA', item_f('CD_GRUPOEMPRESA', tTRA_TRANSACAO));
          gVlImposto := rounded(item_f('VL_TOTAL', tF_TMP_NR09), 2);

          if (gInExibeQtdProdNF = True) then begin
            vDsLinha := 'CFOP ' + NR_GERAL + '.F_TMP_NR09 := ' + FloatToStr(gVlImposto,) + ' QT: ' + QT_ITEM + '.F_TMP_NR09';
          end else begin

            vDsLinha := 'CFOP ' + NR_GERAL + '.F_TMP_NR09 := ' + FloatToStr(gVlImposto') + ';
          end;
          putitem_e(tOBS_NF, 'CD_OPERADOR', itemXmlF('CD_USUARIO', PARAM_GLB));
          putitem_e(tOBS_NF, 'DT_CADASTRO', Now);
          putitem_e(tOBS_NF, 'DS_OBSERVACAO', vDsLinha[1 : 80]);
          setocc(tF_TMP_NR09, curocc(tF_TMP_NR09) + 1);
        end;
      end;
    end;
  end;
  if (gDsAdicionalRegra <> '')  and (item_f('TP_ORIGEMEMISSAO', tTRA_TRANSACAO) = 1) then begin
    if (empty(tOBS_TRANSACNF) = 1) then begin
      vDsAdicional := gDsAdicionalRegra;
      while(vDsAdicional <> '') do begin
        scan vDsAdicional, '';
        if (gresult > 0) then begin
          vDsLinha := vDsAdicional[1, gresult - 1];
          vDsAdicional := vDsAdicional[gresult + 1];
        end else begin
          vDsLinha := vDsAdicional;
          vDsAdicional := '';
        end;
        creocc(tOBS_NF, -1);
        vNrLinha := vNrLinha + 1;
        putitem_e(tOBS_NF, 'NR_LINHA', vNrLinha);
        putitem_e(tOBS_NF, 'CD_EMPFAT', item_f('CD_EMPFAT', tFIS_NF));
        putitem_e(tOBS_NF, 'CD_GRUPOEMPRESA', item_f('CD_GRUPOEMPRESA', tFIS_NF));
        putitem_e(tOBS_NF, 'CD_OPERADOR', itemXmlF('CD_USUARIO', PARAM_GLB));
        putitem_e(tOBS_NF, 'DT_CADASTRO', Now);
        putitem_e(tOBS_NF, 'DS_OBSERVACAO', vDsLinha[1 : 80]);
      end;
    end;
  end;
  if (empty(tOBS_TRANSACNF) = False) then begin
    setocc(tOBS_TRANSACNF, 1);
    while (xStatus >= 0) do begin
      creocc(tOBS_NF, -1);
      vNrLinha := vNrLinha + 1;
      putitem_e(tOBS_NF, 'NR_LINHA', vNrLinha);
      putitem_e(tOBS_NF, 'CD_EMPFAT', item_f('CD_EMPFAT', tTRA_TRANSACAO));
      putitem_e(tOBS_NF, 'CD_GRUPOEMPRESA', item_f('CD_GRUPOEMPRESA', tTRA_TRANSACAO));
      putitem_e(tOBS_NF, 'CD_OPERADOR', itemXmlF('CD_USUARIO', PARAM_GLB));
      putitem_e(tOBS_NF, 'DT_CADASTRO', Now);
      putitem_e(tOBS_NF, 'DS_OBSERVACAO', item_a('DS_OBSERVACAO', tOBS_TRANSACNF)[1 : 80]);
      setocc(tOBS_TRANSACNF, curocc(tOBS_TRANSACNF) + 1);
    end;
  end;

  if not (empty(tFIS_DECRETO))  and (gInGravaDsDecretoObsNf = True) then begin
    setocc(tFIS_DECRETO, -1);
    setocc(tFIS_DECRETO, 1);
    while (xStatus >= 0) do begin
      vDsDecreto := item_a('DS_DECRETO', tFIS_DECRETO);

      while (vDsDecreto <> '') do begin
        vNrPosDecreto := 80;
        if (vDsDecreto[80 : 1] <> '') then begin
          if (vDsDecreto[80 : 1] <> ' ')  and (vDsDecreto[81 : 1] <> ' ') then begin
            while (vDsDecreto[vNrPosDecreto : 1] <> ' ')  and (vNrPosDecreto > 0) do begin
              vNrPosDecreto := vNrPosDecreto - 1;
            end;
            if (vNrPosDecreto = 0) then begin
              vNrPosDecreto := 80;
            end;
          end;
        end;

        creocc(tOBS_NF, -1);
        vNrLinha := vNrLinha + 1;
        putitem_e(tOBS_NF, 'NR_LINHA', vNrLinha);
        putitem_e(tOBS_NF, 'CD_EMPFAT', item_f('CD_EMPFAT', tFIS_NF));
        putitem_e(tOBS_NF, 'CD_GRUPOEMPRESA', item_f('CD_GRUPOEMPRESA', tFIS_NF));
        putitem_e(tOBS_NF, 'CD_OPERADOR', itemXmlF('CD_USUARIO', PARAM_GLB));
        putitem_e(tOBS_NF, 'DT_CADASTRO', Now);
        putitem_e(tOBS_NF, 'DS_OBSERVACAO', vDsDecreto[1 : vNrPosDecreto]);
        vNrPosDecreto := vNrPosDecreto + 1;
        vDsDecreto := vDsDecreto[vNrPosDecreto];

      end;

      setocc(tFIS_DECRETO, curocc(tFIS_DECRETO) + 1);
    end;
  end;
  if (gInIncluiIpiDevSimp = 1)  and (item_f('TP_MODALIDADE', tGER_OPERACAO) = 3)and(gInOptSimples = True)  and (item_f('VL_IPI', tFIS_NF) > 0) then begin
    vDsLinha := 'VALOR DO IPI: Rg ' + VL_IPI + '.FIS_NF';

    creocc(tOBS_NF, -1);
    vNrLinha := vNrLinha + 1;
    putitem_e(tOBS_NF, 'NR_LINHA', vNrLinha);
    putitem_e(tOBS_NF, 'CD_EMPFAT', item_f('CD_EMPFAT', tFIS_NF));
    putitem_e(tOBS_NF, 'CD_GRUPOEMPRESA', item_f('CD_GRUPOEMPRESA', tFIS_NF));
    putitem_e(tOBS_NF, 'CD_OPERADOR', itemXmlF('CD_USUARIO', PARAM_GLB));
    putitem_e(tOBS_NF, 'DT_CADASTRO', Now);
    putitem_e(tOBS_NF, 'DS_OBSERVACAO', vDsLinha[1 : 80]);
  end;
  if (gInGravaObsNf = 1) then begin
    vDsLinhaAux := gDsObsNf;
    while (vDsLinhaAux <> '') do begin
      vNrPos := 80;
      if (vDsLinhaAux[80 : 1] <> '') then begin
        if (vDsLinhaAux[80 : 1] <> ' ')  and (vDsLinhaAux[81 : 1] <> ' ') then begin
          while (vDsLinhaAux[vNrPos : 1] <> ' ')  and (vNrPos > 0) do begin
            vNrPos := vNrPos - 1;
          end;
          if (vNrPos = 0) then begin
            vNrPos := 80;
          end;
        end;
      end;
      creocc(tOBS_NF, -1);
      vNrLinha := vNrLinha + 1;
      putitem_e(tOBS_NF, 'NR_LINHA', vNrLinha);
      putitem_e(tOBS_NF, 'CD_EMPFAT', item_f('CD_EMPFAT', tFIS_NF));
      putitem_e(tOBS_NF, 'CD_GRUPOEMPRESA', item_f('CD_GRUPOEMPRESA', tFIS_NF));
      putitem_e(tOBS_NF, 'CD_OPERADOR', itemXmlF('CD_USUARIO', PARAM_GLB));
      putitem_e(tOBS_NF, 'DT_CADASTRO', Now);
      putitem_e(tOBS_NF, 'DS_OBSERVACAO', vDsLinhaAux[1 : vNrPos]);
      vNrPos := vNrPos + 1;
      vDsLinhaAux := vDsLinhaAux[vNrPos];
    end;
  end;

  return(0); exit;

end;

//-----------------------------------------------------------
function T_FISSVCO004.limpastring(pParams : String) : String;
//-----------------------------------------------------------
const
  cDS_METHOD = 'ADICIONAL=Operação: T_FISSVCO004.limpastring()';
var
  (* string pistring:IN / string postringSaida:OUT *)
  vDs, vDsSaida, vChar : String;
  vTamanho, vPosicao : Real;
  vInValido : Boolean;
begin
  vDsstring := pistring;

  vDsstring := greplace(vDsstring, 1, 'string ', '', -1);

  length vDsstring;
  vTamanho := gresult;
  if (vTamanho < 1) then begin
    return(0); exit;
  end;

  vPosicao := 0;
  vDsstringSaida := '';
  repeat
    vPosicao := vPosicao + 1;
    vInValido := True;
    vChar := vDsstring[vPosicao:1];

    if (vChar = '<' ) or (vChar = '>' ) or (vChar = 'and' ) or (vChar = '' + '' + ' ) or (vChar = ''' ) or (vChar = '%' ) or (vChar = '' ) or (vChar = '>' ) or (vChar = '<' ) or (vChar = 'and') then begin
      vInValido := False;
    end;
    if (vInValido = True) then begin
      vDsstringSaida := '' + vDsstringSaida' + vChar' + ' + ';
    end;
  until (vPosicao >= vTamanho);

  postringSaida := vDsstringSaida;

  return(0); exit;
end;

//-----------------------------------------------------------------
function T_FISSVCO004.geraNFReferencial(pParams : String) : String;
//-----------------------------------------------------------------
const
  cDS_METHOD = 'ADICIONAL=Operação: T_FISSVCO004.geraNFReferencial()';
var
  vDsLstOperRef, vCdOperacao : String;
begin
  vDsLstOperRef := gDsLstOperObrigNfRef;
  vDsLstOperRef := greplace(vDsLstOperRef, 1, ';
  if (vDsLstOperRef <> '') then begin
    repeat
      getitem(vCdOperacao, vDsLstOperRef, 1);
      if (item_f('CD_OPERACAO', tFIS_NF) = vCdOperacao)  and (empty(tTRA_TRANREF)) then begin
        Result := SetStatus(STS_ERROR, 'GEN0001', 'Operação ' + FloatToStr(vCdOperacao) + ' da NF precisa de NF referencial, parâmetro DS_LST_OPER_OBRIG_NF_REF!', cDS_METHOD);
        return(-1); exit;
      end;
      delitem(vDsLstOperRef, 1);
    until(vDsLstOperRef = '');
  end;

  if not (empty(tTRA_TRANREF)) then begin
    setocc(tTRA_TRANREF, 1);
    while (xStatus >= 0) do begin

      creocc(tFIS_NFREF, -1);
      putitem_e(tFIS_NFREF, 'CD_EMPRESAREF', item_f('CD_EMPRESANFREF', tTRA_TRANREF));
      putitem_e(tFIS_NFREF, 'NR_FATURAREF', item_f('NR_FATURANFREF', tTRA_TRANREF));
      putitem_e(tFIS_NFREF, 'DT_FATURAREF', item_a('DT_FATURANFREF', tTRA_TRANREF));
      putitem_e(tFIS_NFREF, 'CD_OPERADOR', itemXmlF('CD_USUARIO', PARAM_GLB));
      putitem_e(tFIS_NFREF, 'DT_CADASTRO', Now);
      putitem_e(tFIS_NFREF, 'TP_REFERENCIAL', item_f('TP_REFERENCIAL', tTRA_TRANREF));

      setocc(tTRA_TRANREF, curocc(tTRA_TRANREF) + 1);
    end;
  end;

  return(0); exit;

end;

//---------------------------------------------------------------
function T_FISSVCO004.geraItemSeloEnt(pParams : String) : String;
//---------------------------------------------------------------
const
  cDS_METHOD = 'ADICIONAL=Operação: T_FISSVCO004.geraItemSeloEnt()';
var
  (* string piDsLstSelo : IN *)
  vDsRegistro : String;
begin
  if (piDsLstSelo <> '') then begin
    repeat
      getitem(vDsRegistro, piDsLstSelo, 1);

      putitem_e(tFIS_NFISELOEN, 'VL_BASECALC', item_f('VL_BASECALC', tFIS_NFISELOEN) + itemXmlF('VL_BASECALC', vDsRegistro));
      putitem_e(tFIS_NFISELOEN, 'VL_SUBTRIB', item_f('VL_SUBTRIB', tFIS_NFISELOEN) + itemXmlF('VL_SUBTRIB', vDsRegistro));
      putitem_e(tFIS_NFISELOEN, 'VL_IPI', item_f('VL_IPI', tFIS_NFISELOEN) + itemXmlF('VL_IPI', vDsRegistro));
      putitem_e(tFIS_NFISELOEN, 'VL_FRETE', item_f('VL_FRETE', tFIS_NFISELOEN) + itemXmlF('VL_FRETE', vDsRegistro));
      putitem_e(tFIS_NFISELOEN, 'VL_SEGURO', item_f('VL_SEGURO', tFIS_NFISELOEN) + itemXmlF('VL_SEGURO', vDsRegistro));
      putitem_e(tFIS_NFISELOEN, 'VL_DESPACESSOR', item_f('VL_DESPACESSOR', tFIS_NFISELOEN) + itemXmlF('VL_DESPACESSOR', vDsRegistro));
      putitem_e(tFIS_NFISELOEN, 'PR_ALIQUOTA', item_f('PR_ALIQUOTA', tFIS_NFISELOEN) + itemXmlF('PR_ALIQUOTA', vDsRegistro));
      putitem_e(tFIS_NFISELOEN, 'CD_OPERADOR', itemXmlF('CD_USUARIO', PARAM_GLB));
      putitem_e(tFIS_NFISELOEN, 'DT_CADASTRO', Now);

      delitem(piDsLstSelo, 1);
    until (piDsLstSelo = '');
    setocc(tFIS_NFISELOEN, 1);
  end;

  return(0); exit;

end;

//-----------------------------------------------------------
function T_FISSVCO004.alteraVlIpi(pParams : String) : String;
//-----------------------------------------------------------
const
  cDS_METHOD = 'ADICIONAL=Operação: T_FISSVCO004.alteraVlIpi()';
begin
  if (empty(tFIS_NF)) then begin
    return(0); exit;
  end;
  if (gInIncluiIpiDevSimp = 1)  and (item_f('TP_MODALIDADE', tGER_OPERACAO) = 3)and(gInOptSimples = True)  and (item_f('VL_IPI', tFIS_NF) > 0) then begin
    setocc(tFIS_NFITEM, 1);
    while(xStatus >= 0) do begin

      setocc(tFIS_NFITEMIMP, 1);
      while(xStatus >= 0) do begin
        if (item_f('CD_IMPOSTO', tFIS_NFITEMIMP) = 3) then begin
          discard(tFIS_NFITEMIMP);
          break;
        end;
        setocc(tFIS_NFITEMIMP, curocc(tFIS_NFITEMIMP) + 1);
      end;

      setocc(tFIS_NFITEM, curocc(tFIS_NFITEM) + 1);
    end;

    putitem_e(tFIS_NF, 'VL_IPI', 0);
  end;

  return(0); exit;

end;

//-----------------------------------------------------------------
function T_FISSVCO004.geraSeloFiscalEnt(pParams : String) : String;
//-----------------------------------------------------------------
const
  cDS_METHOD = 'ADICIONAL=Operação: T_FISSVCO004.geraSeloFiscalEnt()';
var
  vCdEmpresaTra, vNrTransacao, vCdEmpresaNf, vNrFatura : Real;
  vDtTransacao, vDtFatura : TDate;
begin
  vCdEmpresaTra := item_f('CD_EMPRESA', tTRA_TRANSACAO);
  vNrTransacao := item_f('NR_TRANSACAO', tTRA_TRANSACAO);
  vDtTransacao := item_a('DT_TRANSACAO', tTRA_TRANSACAO);
  vCdEmpresaNf := item_f('CD_EMPRESA', tFIS_NF);
  vNrFatura := item_f('NR_FATURA', tFIS_NF);
  vDtFatura := item_a('DT_FATURA', tFIS_NF);

  if (vCdEmpresaTra = '') then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Empresa da transação não informada!', cDS_METHOD);
    return(-1); exit;
  end;
  if (vNrTransacao = '') then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Número da transação não informado!', cDS_METHOD);
    return(-1); exit;
  end;
  if (vDtTransacao = '') then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Data da transação não informada!', cDS_METHOD);
    return(-1); exit;
  end;
  if (vCdEmpresaNf = '') then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Empresa da nota fiscal não informada!', cDS_METHOD);
    return(-1); exit;
  end;
  if (vNrFatura = '') then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Número da fatura não informado!', cDS_METHOD);
    return(-1); exit;
  end;
  if (vDtFatura = '') then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Data da fatura não informada!', cDS_METHOD);
    return(-1); exit;
  end;

  if not (empty(tTRA_SELOENT)) then begin

    clear_e(tFIS_NFSELOENT);
    creocc(tFIS_NFSELOENT, -1);
    putitem_e(tFIS_NFSELOENT, 'VL_ANTECIPADO', item_f('VL_ANTECIPADO', tTRA_SELOENT));
    putitem_e(tFIS_NFSELOENT, 'VL_SUBSTITUIDO', item_f('VL_SUBSTITUIDO', tTRA_SELOENT));
    putitem_e(tFIS_NFSELOENT, 'VL_DIFERENCIAL', item_f('VL_DIFERENCIAL', tTRA_SELOENT));
    putitem_e(tFIS_NFSELOENT, 'CD_OPERADOR', itemXmlF('CD_USUARIO', PARAM_GLB));
    putitem_e(tFIS_NFSELOENT, 'DT_CADASTRO', Now);
  end;

  return(0); exit;

end;

//------------------------------------------------------
function T_FISSVCO004.geraNF(pParams : String) : String;
//------------------------------------------------------
const
  cDS_METHOD = 'ADICIONAL=Operação: T_FISSVCO004.geraNF()';
var
  vCdEmpresa, vNrTransacao, vVlCalc, vTpLoopItem, vNrItem, vCdRegraFiscal, vPos : Real;
  vQtFaturado, vVlTotalBruto, vVlTotalLiquido, vVlTotalDesc, vVlTotalDescCab, vCdDecreto : Real;
  vCdSeqGrupoProx, vVlUnitProx, vCdCFOPProx, vCdCompVendProx, vCdTamanhoProx, vTpContrInspSaldoLote : Real;
  vDsRegistro, vDsLstTransacao, vDsLstNF, vDsRegistroItem, vDsLstItem, vDsLstValor, vTpAliqIcms : String;
  viParams, voParams, vCdTipoClas, vCdCorProx, vDsLstSerial, vDsNulo, vDsLstDespesa, vTpReducao : String;
  vInLoopCapa, vInPrimeira, vInReemissao, vInAgrupaItem, vInItemDescritivo, vInObs : Boolean;
  vDtTransacao : TDate;
  vDsLoteInf, vDsLstLoteInfGeral : String;
  vCdEmpLote, vNrLote, vNrItemLote, vNfInicial, vVlSubMaior, vNrItemSubMaior, VTPMODDOCTOFIS, vVlBaseIcmsSub : Real;
  vVlIcmsSub, vVlBaseIcms, vVlIcms, vVlIcmsMaior, vNrItemMaior, vVlCalcula, vVlBaseCalc, vConsulta : Real;
  vDsLstNotaFiscal, vLstNF, vDsLinhaObs, vDsLstSelo : String;
begin
  PARAM_GLB := PARAM_GLB;
  vDsLstNotaFiscal := '';
  vCdEmpresa := itemXmlF('CD_EMPRESA', pParams);
  vDsLstTransacao := itemXml('DS_LSTTRANSACAO', pParams);
  gInReemissao := itemXmlB('IN_REEMISSAO', pParams);
  gCdModeloNF := itemXmlF('CD_MODELONF', pParams);
  gNrNf := itemXmlF('NR_NF', pParams);
  gCdSerie := itemXmlF('CD_SERIE', pParams);
  gDtEmissao := itemXml('DT_EMISSAO', pParams);
  gDtSaidaEntrada := itemXml('DT_SAIDAENTRADA', pParams);
  gDtEntrega := itemXml('DT_ENTREGA', pParams);
  gDtFatura := itemXml('DT_FATURA', pParams);
  gHrSaida := itemXml('HR_SAIDA', pParams);
  gLstLoteInfGeral := '';
  gInItemLote := itemXmlB('IN_ITEMLOTE', pParams);
  gtinTinturaria := itemXml('TIN_TINTURARIA', PARAM_GLB);
  vTpContrInspSaldoLote := itemXmlF('TP_CONTR_INSP_SALDO_LOTE', PARAM_GLB);

  if (gDtSaidaEntrada = '') then begin
    gDtSaidaEntrada := itemXml('DT_SISTEMA', PARAM_GLB);
  end;

  voParams := ocalg := itemXml(viParams); (* 'TP_MODDCTOFISCAL', pParams *)
  gCdEspecieServico := itemXmlF('CD_ESPECIE_SERVICO_TRA', PARAM_GLB);
  gDsLstFatura := '';

  if (gInItemLote = '') then begin
    if (vTpContrInspSaldoLote = 1) then begin
      gInItemLote := True;

    end else begin
      gInItemLote := False;
    end;
  end;
  if (vDsLstTransacao = '') then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Lista de transação não informada!', cDS_METHOD);
    return(-1); exit;
  end;

  getParams(pParams); (* vCdEmpresa *)
  if (xStatus < 0) then begin
    return(-1); exit;
  end;
  if (gDtEncerramento <> '')  and (gDtSaidaEntrada <> '') then begin
    if (gDtSaidaEntrada <= gDtEncerramento) then begin
      Result := SetStatus(STS_ERROR, 'GEN0001', 'NF/Fatura ' + NR_NF + '.FIS_NF/' + NR_FATURA + '.FIS_NF possui data de movimento anterior ao encerramento do livro fiscal!', cDS_METHOD);
      return(-1); exit;
    end;
  end;

  vCdTipoClas := gCdTipoClas;
  clear_e(tPRD_TIPOCLAS);
  length(vCdTipoClas);
  while (gresult > 0) do begin
    creocc(tPRD_TIPOCLAS, -1);
    scan vCdTipoClas, ';
    if (gresult > 0) then begin
      putitem_e(tPRD_TIPOCLAS, 'CD_TIPOCLAS', vCdTipoClas[1 : gresult - 1]);
      vCdTipoClas := vCdTipoClas[gresult + 1];
    end else begin
      putitem_e(tPRD_TIPOCLAS, 'CD_TIPOCLAS', vCdTipoClas);
      vCdTipoClas := '';
    end;
    retrieve_o(tPRD_TIPOCLAS);
    if (xStatus = -7) then begin
      retrieve_x(tPRD_TIPOCLAS);
    end else begin
      remocc PRD_TIPOCLAS, curocc(tPRD_TIPOCLAS);
    end;
    length(vCdTipoClas);
  end;

  clear_e(tFIS_NF);

  repeat
    getitem(vDsRegistro, vDsLstTransacao, 1);
    vCdEmpresa := itemXmlF('CD_EMPRESA', vDsRegistro);
    vNrTransacao := itemXmlF('NR_TRANSACAO', vDsRegistro);
    vDtTransacao := itemXml('DT_TRANSACAO', vDsRegistro);

    if (vCdEmpresa = 0) then begin
      Result := SetStatus(STS_ERROR, 'GEN0001', 'Empresa não informada!', cDS_METHOD);
      return(-1); exit;
    end;
    if (vNrTransacao = 0) then begin
      Result := SetStatus(STS_ERROR, 'GEN0001', 'Número da transação não informado!', cDS_METHOD);
      return(-1); exit;
    end;
    if (vDtTransacao = '') then begin
      Result := SetStatus(STS_ERROR, 'GEN0001', 'Número da transação não informado!', cDS_METHOD);
      return(-1); exit;
    end;

    clear_e(tTRA_TRANSACAO);
    putitem_e(tTRA_TRANSACAO, 'CD_EMPRESA', vCdEmpresa);
    putitem_e(tTRA_TRANSACAO, 'NR_TRANSACAO', vNrTransacao);
    putitem_e(tTRA_TRANSACAO, 'DT_TRANSACAO', vDtTransacao);
    retrieve_e(tTRA_TRANSACAO);
    if (xStatus < 0) then begin
      Result := SetStatus(STS_ERROR, 'GEN0001', 'Transação ' + FloatToStr(vNrTransacao) + ' não cadastrada!', cDS_METHOD);
      return(-1); exit;
    end;

    viParams := '';
    putitemXml(viParams, 'CD_PESSOA', item_f('CD_PESSOA', tTRA_TRANSACAO));
    voParams := activateCmp('PESSVCO005', 'buscaDadosPessoa', viParams); (*,,,, *)
    if (xStatus < 0) then begin
      Result := voParams;
      return(-1); exit;
    end;
    gTpRegimeTrib := itemXmlF('TP_REGIMETRIB', voParams);

    viParams := '';
    putitemXml(viParams, 'CD_CLIENTE', item_f('CD_PESSOA', tTRA_TRANSACAO));
    voParams := activateCmp('FISSVCO032', 'carregaPesCliente', viParams); (*,,,, *)
    if (xStatus < 0) then begin
      Result := voParams;
      return(-1); exit;
    end;
    gNrCodFiscal := itemXmlF('NR_CODIGOFISCAL', voParams);

    vInPrimeira := True;

    clear_e(tGER_MODNFC);
    clear_e(tFIS_DECRETO);
    gInQuebraItem := False;
    gTpAgrupamento := 'F';
    if (gTpImpressaoCodPrdEcf = 0) then begin
      gTpCodigoItem := 4;
    end;
    vInItemDescritivo := False;

    if (item_f('TP_ORIGEMEMISSAO', tTRA_TRANSACAO) = 1) then begin
      if (gCdModeloNF > 0) then begin
        putitem_e(tGER_MODNFC, 'CD_MODELONF', gCdModeloNF);
        retrieve_e(tGER_MODNFC);
        if (xStatus >= 0) then begin
          if (item_b('IN_AGRUPA_GRUPO', tGER_MODNFC) = '') then begin
            Result := SetStatus(STS_ERROR, 'GEN0001', 'Modelo de NF ' + FloatToStr(gCdModeloNF) + ' não possui tipo de agrupamento de item informado. Utilize o GERFM016 para cadastrar!', cDS_METHOD);
            return(-1); exit;
          end;
          if (item_f('TP_CODPRODUTO', tGER_MODNFC) = 0) then begin
            Result := SetStatus(STS_ERROR, 'GEN0001', 'Modelo de NF ' + FloatToStr(gCdModeloNF) + ' não possui tipo de código de item informado. Utilize o GERFM016 para cadastrar!', cDS_METHOD);
            return(-1); exit;
          end;

          voParams := ocalg = 55) then begin
            gInQuebraItem := False;
          end else begin

            gInQuebraItem := item_b('IN_QUEBRANF', tGER_MODNFC);
          end;
          gTpAgrupamento := item_b('IN_AGRUPA_GRUPO', tGER_MODNFC);
          gTpCodigoItem := item_f('TP_CODPRODUTO', tGER_MODNFC);

        end;
      end;
      if (gInReemissao = True) then begin
        if (gNrNf = 0) then begin
          Result := SetStatus(STS_ERROR, 'GEN0001', 'Número de NF não informado!', cDS_METHOD);
          return(-1); exit;
        end;
      end;
    end else begin
      if (gNrNf = 0) then begin
        Result := SetStatus(STS_ERROR, 'GEN0001', 'Número de NF não informado!', cDS_METHOD);
        return(-1); exit;
      end;

      clear_e(tV_FIS_NFREMDE);
      putitem_e(tV_FIS_NFREMDE, 'CD_EMPFAT', item_f('CD_EMPFAT', tTRA_TRANSACAO));
      if (item_f('CD_PESSOA', tTRA_REMDES) <> '') then begin
        putitem_e(tV_FIS_NFREMDE, 'CD_PESSOAREMDES', item_f('CD_PESSOA', tTRA_REMDES));
      end else begin
        putitem_e(tV_FIS_NFREMDE, 'CD_PESSOANF', item_f('CD_PESSOA', tTRA_TRANSACAO));
      end;
      putitem_e(tV_FIS_NFREMDE, 'NR_NF', gNrNf);
      putitem_e(tV_FIS_NFREMDE, 'CD_SERIE', gCdSerie);
      putitem_e(tV_FIS_NFREMDE, 'TP_SITUACAO', '!=X');
      putitem_e(tV_FIS_NFREMDE, 'TP_ORIGEMEMISSAO', 2);
      voParams := ocalg;
      retrieve_e(tV_FIS_NFREMDE);
      if (xStatus >= 0) then begin
        if (item_f('NR_FATURA', tV_FIS_NFREMDE) <> item_f('NR_FATURA', tFIS_NF) ) or (item_a('DT_FATURA', tV_FIS_NFREMDE) <> item_a('DT_FATURA', tFIS_NF))  and %\ then begin
          (item_f('TP_MODDCTOFISCAL', tV_FIS_NFREMDE) <> 6)  and (item_f('TP_MODDCTOFISCAL', tV_FIS_NFREMDE) <> 21)  and (item_f('TP_MODDCTOFISCAL', tV_FIS_NFREMDE) <> 22);

          Result := SetStatus(STS_ERROR, 'GEN0001', 'NF ' + FloatToStr(gNrNf) + ' ' + FloatToStr(gCdSerie) + ' Modelo Documento ' + FloatToStr(gTpModDctoFiscallocal) + ' já cadastrada para a pessoa ' + CD_PESSOAREMDES + '.V_FIS_NFREMDE!', cDS_METHOD);
          return(-1); exit;
        end;
      end;
      gInQuebraCFOP := False;
    end;

    clear_e(tGER_OPERACAO);
    putitem_e(tGER_OPERACAO, 'CD_OPERACAO', item_f('CD_OPERACAO', tTRA_TRANSACAO));
    retrieve_e(tGER_OPERACAO);
    if (xStatus < 0) then begin
      Result := SetStatus(STS_ERROR, 'GEN0001', 'Operaçao ' + CD_OPERACAO + '.GER_OPERACAO não cadastrada!', cDS_METHOD);
      return(-1); exit;
    end;
    if (item_f('TP_ORIGEMEMISSAO', tTRA_TRANSACAO) = 1) then begin
      if (item_f('TP_DOCTO', tGER_OPERACAO) = 2)  or (item_f('TP_DOCTO', tGER_OPERACAO) = 3) then begin
        gInQuebraItem := False;
        gTpAgrupamento := 'F';
        if (gTpImpressaoCodPrdEcf = 0) then begin
          gTpCodigoItem := 4;
        end;
        gInQuebraCFOP := False;
      end;
    end;

    setocc(tGER_S_OPERACA, 1);
    if (!dbocc(t'GER_S_OPERACA')) then begin
      Result := SetStatus(STS_ERROR, 'GEN0001', 'Operação ' + CD_OPERACAO + '.GER_OPERACAO não possui operação de movimento!', cDS_METHOD);
      return(-1); exit;
    end;
    if (item_f('TP_ORIGEMEMISSAO', tTRA_TRANSACAO) = 1) then begin
      if (item_f('TP_DOCTO', tGER_S_OPERACA) = 2)  or (item_f('TP_DOCTO', tGER_S_OPERACA) = 3) then begin
        gInQuebraItem := False;
        gTpAgrupamento := 'F';
        if (gTpImpressaoCodPrdEcf = 0) then begin
          gTpCodigoItem := 4;
        end;
        gInQuebraCFOP := False;
      end else if (item_f('TP_DOCTO', tGER_S_OPERACA) = 1) then begin
        vDsNulo := '';
        clear_e(tTRA_TRANSITEM);
        putitem_e(tTRA_TRANSITEM, 'CD_PRODUTO', '=' + vDsNulo' + ');
        putitem_e(tTRA_TRANSITEM, 'CD_BARRAPRD', '=' + vDsNulo' + ');
        retrieve_e(tTRA_TRANSITEM);
        if (xStatus >= 0) then begin
          vInItemDescritivo := True;
        end;
        clear_e(tTRA_TRANSITEM);
        retrieve_e(tTRA_TRANSITEM);
      end;
      if (item_f('TP_MODALIDADE', tGER_S_OPERACA) = '6') then begin
        gInQuebraCFOP := False;
      end;
      if (item_f('TP_MODALIDADE', tGER_S_OPERACA) = 'A') then begin
        gTpAgrupamento := 'F';
      end;
    end;
    if (item_f('CD_REGRAFISCAL', tGER_S_OPERACA) > 0) then begin
      vCdRegraFiscal := item_f('CD_REGRAFISCAL', tGER_S_OPERACA);
    end else if (item_f('CD_REGRAFISCAL', tGER_OPERACAO) > 0) then begin
      vCdRegraFiscal := item_f('CD_REGRAFISCAL', tGER_OPERACAO);
    end;

    viParams := '';
    putitemXml(viParams, 'CD_REGRAFISCAL', vCdRegraFiscal);
    voParams := activateCmp('FISSVCO033', 'buscaDadosRegraFiscal', viParams); (*,,,, *)
    if (xStatus < 0) then begin
      Result := voParams;
      return(-1); exit;
    end;

    vTpReducao := itemXmlF('TP_REDUCAO', voParams);
    vTpAliqIcms := itemXmlF('TP_ALIQICMS', voParams);
    vCdDecreto := itemXmlF('CD_DECRETO', voParams);
    gufDestino := item_a('DS_SIGLAESTADO', tTRA_REMDES);
    vInObs := False;

    if (vTpReducao = '' ) and (vTpAliqIcms = '') then begin
      vInObs := True;

    end else if (vTpReducao  = 'G' ) or (vTpReducao = 'H' ) or (vTpReducao = 'I')  or %\ then begin
      ((vTpReducao := 'A' ) or (vTpReducao := 'B' ) or (vTpReducao := 'C')  and gufOrigem := gufDestino)  or 
      ((vTpReducao := 'D' ) or (vTpReducao := 'E' ) or (vTpReducao := 'F')  and gufOrigem <> gufDestino);
      vInObs := True;

    end else if (vTpAliqIcms = 'C')  or (vTpAliqIcms = 'A' ) and (gufOrigem = gufDestino)  or %\ then begin
      (vTpAliqIcms := 'B' ) and (gufOrigem <> gufDestino);
      vInObs := True;
    end;
    if (vInObs = True) then begin
      gDsAdicionalRegra := itemXml('DS_ADICIONAL', voParams);
    end;
    if (empty(tTRA_TRANSITEM) = False) then begin
      if (gDtEmissao = '') then begin
        if (item_f('TP_ORIGEMEMISSAO', tTRA_TRANSACAO) = 2) then begin
          gDtEmissao := item_a('DT_TRANSACAO', tTRA_TRANSACAO);
        end else begin
          gDtEmissao := itemXml('DT_SISTEMA', PARAM_GLB);
        end;
      end;

      vInLoopCapa := True;
      if (vInItemDescritivo = True) then begin
        sort_e(tTRA_TRANSITEM, '        sort/e , NR_ITEM;');
      end else begin
        if (gTpAgrupamento = 'T') then begin
          sort_e(tTRA_TRANSITEM, '          sort/e , CD_CFOP, CD_NIVELGRUPO, CD_SEQGRUPO, VL_UNITLIQUIDO, CD_COMPVend;');
        end else if (gTpAgrupamento = 'C') then begin
          sort_e(tTRA_TRANSITEM, '          sort/e , CD_CFOP, CD_NIVELGRUPO, CD_SEQGRUPO, CD_COR, VL_UNITLIQUIDO, CD_COMPVend;');
        end else if (gTpAgrupamento = 'A') then begin
          sort_e(tTRA_TRANSITEM, '          sort/e , CD_CFOP, CD_NIVELGRUPO, CD_SEQGRUPO, CD_TAMANHO, VL_UNITLIQUIDO, CD_COMPVend;');
        end else if (gInQuebraCFOP = True) then begin
          sort_e(tTRA_TRANSITEM, '          sort/e , CD_CFOP, NR_ITEM;');
        end else begin
          sort_e(tTRA_TRANSITEM, '          sort/e , NR_ITEM;');
        end;
      end;
      setocc(tTRA_TRANSITEM, -1);
      setocc(tTRA_TRANSITEM, 1);

      while (vInLoopCapa := True) do begin
        vTpLoopItem := 0;
        vQtFaturado := 0;
        vVlTotalBruto := 0;
        vVlTotalLiquido := 0;
        vVlTotalDesc := 0;
        vVlTotalDescCab := 0;
        gVlICMSDiferido := 0;
        vNrItem := 0;
        vCdSeqGrupoProx := 0;
        vCdCorProx := '';
        vCdTamanhoProx := 0;
        vVlUnitProx := 0;
        vCdCompVendProx := 0;
        vCdCFOPProx := 0;
        gInSubstituicao := False;
        clear_e(tTMP_NR09);
        clear_e(tTMP_NR08);
        clear_e(tF_TMP_NR09);

        if (gInLog = True) then begin
          gHrInicio := gclock;
          putmess '- Inicio gera NF. geraCapaNF FISSVCO004: ' + gHrInicio' + ';
        end;

        voParams := geraCapaNF(viParams); (* *)
        if (xStatus < 0) then begin
          return(-1); exit;
        end;
        if (gInLog = True) then begin
          gHrFim := gclock;
          gHrTempo := gHrFim - gHrInicio;
          putmess '- Fim gera NF. geraCapaNF FISSVCO004: ' + gHrFim + ' - ' + gHrTempo' + ';

          gHrInicio := gclock;
          putmess '- Inicio gera NF. geraRemDest FISSVCO004: ' + gHrInicio' + ';
        end;

        gInNFe := False;
        if not (empty(tF_TMP_NR08)) then begin
          creocc(tF_TMP_NR08, -1);
          putitem_e(tF_TMP_NR08, 'NR_08', item_f('TP_MODDCTOFISCAL', tFIS_NF));
          retrieve_o(tF_TMP_NR08);
          if (xStatus = 4) then begin
            gInNFe := True;
          end else begin
            discard(tF_TMP_NR08);
          end;
        end;

        voParams := geraRemDest(viParams); (* *)
        if (xStatus < 0) then begin
          return(-1); exit;
        end;
        if (gInLog = True) then begin
          gHrFim := gclock;
          gHrTempo := gHrFim - gHrInicio;
          putmess '- Fim gera NF. geraRemDest FISSVCO004: ' + gHrFim + ' - ' + gHrTempo' + ';

          gHrInicio := gclock;
          putmess '- Inicio gera NF. geraNFReferencial FISSVCO004: ' + gHrInicio' + ';
        end;

        voParams := geraNFReferencial(viParams); (* *)
        if (xStatus < 0) then begin
          return(-1); exit;
        end;
        if (gInLog = True) then begin
          gHrFim := gclock;
          gHrTempo := gHrFim - gHrInicio;
          putmess '- Fim gera NF. geraNFReferencial FISSVCO004: ' + gHrFim + ' - ' + gHrTempo' + ';
        end;

        voParams := geraSeloFiscalEnt(viParams); (* *)
        if (xStatus < 0) then begin
          return(-1); exit;
        end;

        while (vTpLoopItem := 0) do begin
          vCdSeqGrupoProx := gnext(item_f('CD_SEQGRUPO', tTRA_TRANSITEM));
          vCdCorProx := gnext(item_f('CD_COR', tTRA_TRANSITEM));
          vCdTamanhoProx := gnext(item_f('CD_TAMANHO', tTRA_TRANSITEM));
          vVlUnitProx := gnext(item_f('VL_UNITLIQUIDO', tTRA_TRANSITEM));
          vCdCFOPProx := gnext(item_f('CD_CFOP', tTRA_TRANSITEM));
          vCdCompVendProx := gnext(item_f('CD_COMPVEND', tTRA_TRANSITEM));

          vDsRegistroItem := '';
          putitemXml(vDsRegistroItem, 'CD_PRODUTO', item_f('CD_PRODUTO', tTRA_TRANSITEM));
          putitemXml(vDsRegistroItem, 'CD_COMPVend', item_f('CD_COMPVEND', tTRA_TRANSITEM));
          putitemXml(vDsRegistroItem, 'CD_PROMOCAO', item_f('CD_PROMOCAO', tTRA_TRANSITEM));
          putitemXml(vDsRegistroItem, 'QT_FATURADO', item_f('QT_SOLICITADA', tTRA_TRANSITEM));
          putitemXml(vDsRegistroItem, 'VL_UNITBRUTO', item_f('VL_UNITBRUTO', tTRA_TRANSITEM));
          putitemXml(vDsRegistroItem, 'VL_UNITLIQUIDO', item_f('VL_UNITLIQUIDO', tTRA_TRANSITEM));
          vVlCalc := item_f('VL_UNITDESC', tTRA_TRANSITEM) + item_f('VL_UNITDESCCAB', tTRA_TRANSITEM);
          putitemXml(vDsRegistroItem, 'VL_TOTALBRUTO', item_f('VL_TOTALBRUTO', tTRA_TRANSITEM));
          putitemXml(vDsRegistroItem, 'VL_TOTALLIQUIDO', item_f('VL_TOTALLIQUIDO', tTRA_TRANSITEM));
          putitemXml(vDsRegistroItem, 'VL_UNITDESC', vVlCalc);
          vVlCalc := item_f('VL_TOTALDESC', tTRA_TRANSITEM) + item_f('VL_TOTALDESCCAB', tTRA_TRANSITEM);
          putitemXml(vDsRegistroItem, 'VL_TOTALDESC', vVlCalc);
          if (empty(tTRA_ITEMIMPOS) = False) then begin
            setocc(tTRA_ITEMIMPOS, 1);
            while (xStatus >= 0) do begin
              creocc(tTMP_NR09, -1);
              putitem_e(tTMP_NR09, 'NR_GERAL', item_f('CD_IMPOSTO', tTRA_ITEMIMPOS));
              retrieve_o(tTMP_NR09);
              putitem_e(tTMP_NR09, 'PR_ALIQUOTA', item_f('PR_ALIQUOTA', tTRA_ITEMIMPOS));
              putitem_e(tTMP_NR09, 'PR_BASECALC', item_f('PR_BASECALC', tTRA_ITEMIMPOS));
              putitem_e(tTMP_NR09, 'PR_REDUBASE', item_f('PR_REDUBASE', tTRA_ITEMIMPOS));
              putitem_e(tTMP_NR09, 'VL_BASECALC', item_f('VL_BASECALC', tTMP_NR09) + item_f('VL_BASECALC', tTRA_ITEMIMPOS));
              putitem_e(tTMP_NR09, 'VL_ISENTO', item_f('VL_ISENTO', tTMP_NR09)   + item_f('VL_ISENTO', tTRA_ITEMIMPOS));
              putitem_e(tTMP_NR09, 'VL_OUTRO', item_f('VL_OUTRO', tTMP_NR09)    + item_f('VL_OUTRO', tTRA_ITEMIMPOS));
              putitem_e(tTMP_NR09, 'VL_IMPOSTO', item_f('VL_IMPOSTO', tTMP_NR09)  + item_f('VL_IMPOSTO', tTRA_ITEMIMPOS));
              putitem_e(tTMP_NR09, 'CD_CST', item_f('CD_CST', tTRA_ITEMIMPOS));

              setocc(tTRA_ITEMIMPOS, curocc(tTRA_ITEMIMPOS) + 1);
            end;
          end;
          if (empty(tTRA_ITEMSERIA) = False) then begin
            vDsLstSerial := '';
            setocc(tTRA_ITEMSERIA, 1);
            while (xStatus >= 0) do begin
              vDsRegistro := '';
              putitemXml(vDsRegistro, 'NR_SEQUENCIA', item_f('NR_SEQUENCIA', tTRA_ITEMSERIA));
              putitemXml(vDsRegistro, 'CD_EMPFAT', item_f('CD_EMPFAT', tTRA_ITEMSERIA));
              putitemXml(vDsRegistro, 'CD_GRUPOEMPRESA', item_f('CD_GRUPOEMPRESA', tTRA_ITEMSERIA));
              putitemXml(vDsRegistro, 'DS_SERIAL', item_a('DS_SERIAL', tTRA_ITEMSERIA));
              putitem(vDsLstSerial,  vDsRegistro);
              setocc(tTRA_ITEMSERIA, curocc(tTRA_ITEMSERIA) + 1);
            end;
            putitemXml(vDsRegistroItem, 'DS_LSTSERIAL', vDsLstSerial);
          end;
          if (empty(tTRA_ITEMVL) = False) then begin
            vDsLstValor := '';
            setocc(tTRA_ITEMVL, 1);
            while (xStatus >= 0) do begin
              vDsRegistro := '';
              putitemXml(vDsRegistro, 'TP_VALOR', item_f('TP_VALOR', tTRA_ITEMVL));
              putitemXml(vDsRegistro, 'CD_VALOR', item_f('CD_VALOR', tTRA_ITEMVL));
              putitemXml(vDsRegistro, 'TP_ATUALIZACAO', item_f('TP_ATUALIZACAO', tTRA_ITEMVL));
              putitemXml(vDsRegistro, 'VL_UNITARIOORIG', item_f('VL_UNITARIOORIG', tTRA_ITEMVL));
              putitemXml(vDsRegistro, 'VL_UNITARIO', item_f('VL_UNITARIO', tTRA_ITEMVL));
              putitemXml(vDsRegistro, 'PR_DESCONTO', item_f('PR_DESCONTO', tTRA_ITEMVL));
              putitemXml(vDsRegistro, 'PR_DESCONTOCAB', item_f('PR_DESCONTOCAB', tTRA_ITEMVL));
              putitemXml(vDsRegistro, 'IN_PADRAO', item_b('IN_PADRAO', tTRA_ITEMVL));
              putitem(vDsLstValor,  vDsRegistro);
              setocc(tTRA_ITEMVL, curocc(tTRA_ITEMVL) + 1);
            end;
            putitemXml(vDsRegistroItem, 'DS_LSTVALOR', vDsLstValor);
          end else begin

            if (item_f('TP_OPERACAO', tTRA_TRANSACAO) = 'E')  and (item_f('TP_MODALIDADE', tGER_OPERACAO) = 2 ) or (item_f('TP_MODALIDADE', tGER_OPERACAO) = 4)  and (item_f('CD_ESPECIE', tTRA_TRANSITEM) <> gCdEspecieServico) then begin
              Result := SetStatus(STS_ERROR, 'GEN0001', 'Produto ' + CD_PRODUTO + '.TRA_TRANSITEM da transação ' + NR_TRANSACAO + '.TRA_TRANSITEM não possui valores cadastrados', cDS_METHOD);
              return(-1); exit;
            end;
          end;
          if (empty(tTRA_ITEMUN) = False) then begin
            vDsRegistro := '';
            putitemXml(vDsRegistro, 'CD_EMPFAT', item_f('CD_EMPFAT', tTRA_ITEMUN));
            putitemXml(vDsRegistro, 'CD_GRUPOEMPRESA', item_f('CD_GRUPOEMPRESA', tTRA_ITEMUN));
            putitemXml(vDsRegistro, 'CD_ESPECIE', item_f('CD_ESPECIE', tTRA_ITEMUN));
            putitemXml(vDsRegistro, 'TP_OPERACAO', item_f('TP_OPERACAO', tTRA_ITEMUN));
            putitemXml(vDsRegistro, 'QT_CONVERSAO', item_f('QT_CONVERSAO', tTRA_ITEMUN));
            putitemXml(vDsRegistroItem, 'DS_LSTITEMUN', vDsRegistro);
          end;

          if not (empty(tTRA_ITEMLOTE)) then begin
            vDsLstValor := '';
            setocc(tTRA_ITEMLOTE, 1);
            while (xStatus >= 0) do begin
              vDsRegistro := '';
              putitemXml(vDsRegistro, 'NR_SEQUENCIA', item_f('NR_SEQUENCIA', tTRA_ITEMLOTE));
              putitemXml(vDsRegistro, 'CD_EMPLOTE', item_f('CD_EMPLOTE', tTRA_ITEMLOTE));
              putitemXml(vDsRegistro, 'NR_LOTE', item_f('NR_LOTE', tTRA_ITEMLOTE));
              putitemXml(vDsRegistro, 'NR_ITEMLOTE', item_f('NR_ITEMLOTE', tTRA_ITEMLOTE));
              putitemXml(vDsRegistro, 'QT_LOTE', item_f('QT_LOTE', tTRA_ITEMLOTE));
              putitemXml(vDsRegistro, 'QT_CONE', item_f('QT_CONE', tTRA_ITEMLOTE));
              putitemXml(vDsRegistro, 'CD_BARRALOTE', item_f('CD_BARRALOTE', tTRA_ITEMLOTE));
              putitem(vDsLstValor,  vDsRegistro);
              setocc(tTRA_ITEMLOTE, curocc(tTRA_ITEMLOTE) + 1);
            end;
            putitemXml(vDsRegistroItem, 'DS_LSTITEMLOTE', vDsLstValor);
          end;

          if not (empty(tTRA_ITEMPRDFI)) then begin
            vDsLstValor := '';
            setocc(tTRA_ITEMPRDFI, 1);
            while (xStatus >= 0) do begin
              vDsRegistro := '';
              putitemXml(vDsRegistro, 'CD_EMPRESA', item_f('CD_EMPRESA', tTRA_ITEMPRDFI));
                putitemXml(vDsRegistro, 'NR_TRANSACAO', item_f('NR_TRANSACAO', tTRA_ITEMPRDFI));
              putitemXml(vDsRegistro, 'DT_TRANSACAO', item_a('DT_TRANSACAO', tTRA_ITEMPRDFI));
              putitemXml(vDsRegistro, 'NR_ITEM', item_f('NR_ITEM', tTRA_ITEMPRDFI));
              putitemXml(vDsRegistro, 'CD_EMPPRDFIN', item_f('CD_EMPPRDFIN', tTRA_ITEMPRDFI));
              putitemXml(vDsRegistro, 'NR_PRDFIN', item_f('NR_PRDFIN', tTRA_ITEMPRDFI));
              putitem(vDsLstValor,  vDsRegistro);
              setocc(tTRA_ITEMPRDFI, curocc(tTRA_ITEMPRDFI) + 1);
            end;
            putitemXml(vDsRegistroItem, 'DS_LSTITEMPRDFIN', vDsLstValor);
          end;

          if not (empty(tTRA_ITEMSELOE)) then begin
            setocc(tTRA_ITEMSELOE, 1);
            while (xStatus >= 0) do begin
              vDsRegistro := '';
              putlistitensocc_e(vDsRegistro, tTRA_ITEMSELOE);
              putitem(vDsLstSelo,  vDsRegistro);
              setocc(tTRA_ITEMSELOE, curocc(tTRA_ITEMSELOE) + 1);
            end;
          end;

          viParams := '';
          putitemXml(viParams, 'CD_EMPRESA', item_f('CD_EMPRESA', tTRA_TRANSITEM));
          putitemXml(viParams, 'NR_TRANSACAO', item_f('NR_TRANSACAO', tTRA_TRANSITEM));
          putitemXml(viParams, 'DT_TRANSACAO', item_a('DT_TRANSACAO', tTRA_TRANSITEM));
          putitemXml(viParams, 'NR_ITEM', item_f('NR_ITEM', tTRA_TRANSITEM));
          voParams := activateCmp('TRASVCO016', 'buscaDespesaItem', viParams); (*,,,, *)
          if (xStatus < 0) then begin
            Result := voParams;
            return(-1); exit;
          end;
          vDsLstDespesa := itemXml('DS_LSTDESPESA', voParams);
          if (vDsLstDespesa <> '') then begin
            putitemXml(vDsRegistroItem, 'DS_LSTDESPESA', vDsLstDespesa);
          end;

          putitem(vDsLstItem,  vDsRegistroItem);

          vInAgrupaItem := False;

          if (curocc(tTRA_TRANSITEM) < totocc(TRA_TRANSITEM)) then begin
            if (gTpAgrupamentoItemNF = 01) then begin
              if (gTpAgrupamento = 'T') then begin
                if (item_f('CD_CFOP', tTRA_TRANSITEM) = vCdCFOPProx)  and (item_f('CD_SEQGRUPO', tTRA_TRANSITEM) = vCdSeqGrupoProx)  and (item_f('CD_COMPVEND', tTRA_TRANSITEM) = vCdCompVendProx) then begin
                  vInAgrupaItem := True;
                end;
              end else if (gTpAgrupamento = 'C') then begin
                if (item_f('CD_CFOP', tTRA_TRANSITEM) = vCdCFOPProx)  and (item_f('CD_SEQGRUPO', tTRA_TRANSITEM) = vCdSeqGrupoProx)  and (item_f('CD_COMPVEND', tTRA_TRANSITEM) = vCdCompVendProx)  and (item_f('CD_COR', tTRA_TRANSITEM) = vCdCorProx) then begin
                  vInAgrupaItem := True;
                end;
              end else if (gTpAgrupamento = 'A') then begin
                if (item_f('CD_CFOP', tTRA_TRANSITEM) = vCdCFOPProx)  and (item_f('CD_SEQGRUPO', tTRA_TRANSITEM) = vCdSeqGrupoProx)   and (item_f('CD_COMPVEND', tTRA_TRANSITEM) = vCdCompVendProx)  and (item_f('CD_TAMANHO', tTRA_TRANSITEM) = vCdTamanhoProx) then begin
                  vInAgrupaItem := True;
                end;
              end;
            end else begin
              if (gTpAgrupamento = 'T') then begin
                if (item_f('CD_CFOP', tTRA_TRANSITEM) = vCdCFOPProx)  and (item_f('CD_SEQGRUPO', tTRA_TRANSITEM) = vCdSeqGrupoProx)  and (item_f('VL_UNITLIQUIDO', tTRA_TRANSITEM) = vVlUnitProx)  and (item_f('CD_COMPVEND', tTRA_TRANSITEM) = vCdCompVendProx) then begin
                  vInAgrupaItem := True;
                end;
              end else if (gTpAgrupamento = 'C') then begin
                if (item_f('CD_CFOP', tTRA_TRANSITEM) = vCdCFOPProx)  and (item_f('CD_SEQGRUPO', tTRA_TRANSITEM) = vCdSeqGrupoProx)  and (item_f('VL_UNITLIQUIDO', tTRA_TRANSITEM) = vVlUnitProx)  and (item_f('CD_COMPVEND', tTRA_TRANSITEM) = vCdCompVendProx)  and (item_f('CD_COR', tTRA_TRANSITEM) = vCdCorProx) then begin
                  vInAgrupaItem := True;
                end;
              end else if (gTpAgrupamento = 'A') then begin
                if (item_f('CD_CFOP', tTRA_TRANSITEM) = vCdCFOPProx)  and (item_f('CD_SEQGRUPO', tTRA_TRANSITEM) = vCdSeqGrupoProx)  and (item_f('VL_UNITLIQUIDO', tTRA_TRANSITEM) = vVlUnitProx)  and (item_f('CD_COMPVEND', tTRA_TRANSITEM) = vCdCompVendProx)  and (item_f('CD_TAMANHO', tTRA_TRANSITEM) = vCdTamanhoProx) then begin
                  vInAgrupaItem := True;
                end;
              end;
            end;
            if (item_f('CD_PRODUTO', tTRA_TRANSITEM) = 0)  and (item_f('CD_BARRAPRD', tTRA_TRANSITEM) = '') then begin
              vInAgrupaItem := False;
            end;
          end;
          if (vInAgrupaItem = True) then begin
            vQtFaturado := vQtFaturado     + item_f('QT_SOLICITADA', tTRA_TRANSITEM);
            vVlTotalBruto := vVlTotalBruto   + item_f('VL_TOTALBRUTO', tTRA_TRANSITEM);
            vVlTotalLiquido := vVlTotalLiquido + item_f('VL_TOTALLIQUIDO', tTRA_TRANSITEM);
            vVlTotalDesc := vVlTotalDesc    + item_f('VL_TOTALDESC', tTRA_TRANSITEM);
            vVlTotalDescCab := vVlTotalDescCab + item_f('VL_TOTALDESCCAB', tTRA_TRANSITEM);
          end else begin
            vNrItem := vNrItem + 1;
            putitem_e(tTRA_TRANSITEM, 'QT_SOLICITADA', item_f('QT_SOLICITADA', tTRA_TRANSITEM)   + vQtFaturado);
            putitem_e(tTRA_TRANSITEM, 'VL_TOTALBRUTO', item_f('VL_TOTALBRUTO', tTRA_TRANSITEM)   + vVlTotalBruto);
            putitem_e(tTRA_TRANSITEM, 'VL_TOTALLIQUIDO', item_f('VL_TOTALLIQUIDO', tTRA_TRANSITEM) + vVlTotalLiquido);
            putitem_e(tTRA_TRANSITEM, 'VL_TOTALDESC', item_f('VL_TOTALDESC', tTRA_TRANSITEM)    + vVlTotalDesc);
            putitem_e(tTRA_TRANSITEM, 'VL_TOTALDESCCAB', item_f('VL_TOTALDESCCAB', tTRA_TRANSITEM) + vVlTotalDescCab);

            if (gInLog = True)  and (curocc(tTRA_TRANSITEM) = 1) then begin
              gHrInicio := gclock;
              putmess '- Inicio gera NF. geraItemNF FISSVCO004: ' + gHrInicio' + ';
            end;

            voParams := geraItemNF(viParams); (* vDsLstItem, vNrItem *)
            if (xStatus < 0) then begin
              return(-1); exit;
            end;
            if (gInLog = True)  and (curocc(tTRA_TRANSITEM) = 1) then begin
              gHrFim := gclock;
              gHrTempo := gHrFim - gHrInicio;
              putmess '- Fim gera NF. geraItemNF FISSVCO004: ' + gHrFim + ' - ' + gHrTempo' + ';
            end;

            voParams := geraItemSeloEnt(viParams); (* vDsLstSelo *)
            if (xStatus < 0) then begin
              return(-1); exit;
            end;

            vDsLstItem := '';
            vDsLstSelo := '';
            vQtFaturado := 0;
            vVlTotalBruto := 0;
            vVlTotalLiquido := 0;
            vVlTotalDesc := 0;
            vVlTotalDescCab := 0;
            clear_e(tTMP_NR09);
          end;
          if (gInQuebraItem = True)  and (vNrItem = item_f('NR_ITENS', tGER_MODNFC)) then begin
            vTpLoopItem := 1;
          end;
          if (gInQuebraCFOP = True)  and (item_f('CD_CFOP', tTRA_TRANSITEM) <> vCdCFOPProx) then begin
            vTpLoopItem := 1;
          end;
          if (gNrItemQuebraNf > 0)  and (vNrItem = gNrItemQuebraNf) then begin
            vTpLoopItem := 1;
          end;

          setocc(tTRA_TRANSITEM, curocc(tTRA_TRANSITEM) + 1);
          if (xStatus < 0) then begin
            vTpLoopItem := 2;
          end;
        end;
        if (vInPrimeira = True) then begin
          if (gInLog = True) then begin
            gHrInicio := gclock;
            putmess '- Inicio gera NF. geraTransport FISSVCO004: ' + gHrInicio' + ';
          end;

          voParams := geraTransport(viParams); (* *)
          if (xStatus < 0) then begin
            return(-1); exit;
          end;
          if (gInLog = True) then begin
            gHrFim := gclock;
            gHrTempo := gHrFim - gHrInicio;
            putmess '- Fim gera NF. geraTransport FISSVCO004: ' + gHrFim + ' - ' + gHrTempo' + ';
          end;

          voParams := rateiaValorCapa(viParams); (* *)
          if (xStatus < 0) then begin
            return(-1); exit;
          end;

          vInPrimeira := False;
        end;

        voParams := geraImpostoItem(viParams); (* *)
        if (xStatus < 0) then begin
          return(-1); exit;
        end;

        putitem_e(tFIS_NF, 'VL_TOTALNOTA', item_f('VL_TOTALPRODUTO', tFIS_NF) + item_f('VL_DESPACESSOR', tFIS_NF) +
                    item_f('VL_FRETE', tFIS_NF) + item_f('VL_SEGURO', tFIS_NF) +
                    item_f('VL_IPI', tFIS_NF) + item_f('VL_ICMSSUBST', tFIS_NF);

        if (gInLog = True) then begin
          gHrInicio := gclock;
          putmess '- Inicio gera NF. geraParcela FISSVCO004: ' + gHrInicio' + ';
        end;

        voParams := geraParcela(viParams); (* *)
        if (xStatus < 0) then begin
          return(-1); exit;
        end;
        if (gInLog = True) then begin
          gHrFim := gclock;
          gHrTempo := gHrFim - gHrInicio;
          putmess '- Fim gera NF. geraParcela FISSVCO004: ' + gHrFim + ' - ' + gHrTempo' + ';

          gHrInicio := gclock;
          putmess '- Inicio gera NF. geraECF FISSVCO004: ' + gHrInicio' + ';
        end;

        voParams := geraECF(viParams); (* *)
        if (xStatus < 0) then begin
          return(-1); exit;
        end;
        if (gInLog = True) then begin
          gHrFim := gclock;
          gHrTempo := gHrFim - gHrInicio;
          putmess '- Fim gera NF. geraECF FISSVCO004: ' + gHrFim + ' - ' + gHrTempo' + ';
        end;

        voParams := geraObservacao(viParams); (* vDsLinhaObs *)
        if (xStatus < 0) then begin
          return(-1); exit;
        end;
        if (vTpLoopItem = 2) then begin
          vInLoopCapa := False;
        end;
      end;
    end else begin
      if (gInLog = True) then begin
        gHrInicio := gclock;
        putmess '- Inicio gera NF. geraCapaNF FISSVCO004: ' + gHrInicio' + ';
      end;

      voParams := geraCapaNF(viParams); (* *)
      if (xStatus < 0) then begin
        return(-1); exit;
      end;
      if (gInLog = True) then begin
        gHrFim := gclock;
        gHrTempo := gHrFim - gHrInicio;
        putmess '- Fim gera NF. geraCapaNF FISSVCO004: ' + gHrFim + ' - ' + gHrTempo' + ';

        gHrInicio := gclock;
        putmess '- Inicio gera NF. geraRemDest FISSVCO004: ' + gHrInicio' + ';
      end;

      voParams := geraRemDest(viParams); (* *)
      if (xStatus < 0) then begin
        return(-1); exit;
      end;
      if (gInLog = True) then begin
        gHrFim := gclock;
        gHrTempo := gHrFim - gHrInicio;
        putmess '- Fim gera NF. geraRemDest FISSVCO004: ' + gHrFim + ' - ' + gHrTempo' + ';
      end;
    end;
    if (item_f('TP_MODALIDADE', tGER_OPERACAO) = 'D') then begin
      putitem_e(tFIS_NF, 'VL_TOTALNOTA', 0);
      putitem_e(tFIS_NF, 'VL_TOTALPRODUTO', 0);
      putitem_e(tFIS_NF, 'VL_DESPACESSOR', 0);
      putitem_e(tFIS_NF, 'VL_SEGURO', 0);
      putitem_e(tFIS_NF, 'VL_FRETE', 0);
      putitem_e(tFIS_NF, 'QT_FATURADO', 0);
      putitem_e(tFIS_NF, 'VL_BASEICMS', 0);
    end;
    if (gInIncluiIpiDevSimp = 1) then begin
      voParams := alteraVlIpi(viParams); (* *)
      if (xStatus < 0) then begin
        return(-1); exit;
      end;
    end;

    delitem(vDsLstTransacao, 1);
  until (vDsLstTransacao = '');

  if (empty(tFIS_NF) = False) then begin
    vPos := curocc(tFIS_NF);
    setocc(tFIS_NF, 1);
    while (xStatus >= 0) do begin
      vLstNF := '';
      putitemXml(vLstNF, 'CD_EMPRESA', item_f('CD_EMPRESA', tFIS_NF));
      putitemXml(vLstNF, 'DT_FATURA', item_a('DT_FATURA', tFIS_NF));
      putitemXml(vLstNF, 'NR_FATURA', item_f('NR_FATURA', tFIS_NF));
      putitemXml(vLstNF, 'CD_MODELONF', item_f('CD_MODELONF', tFIS_NF));
      putitemXml(vLstNF, 'TP_ORIGEMEMISSAO', item_f('TP_ORIGEMEMISSAO', tFIS_NF));
      putitem(vDsLstNotaFiscal,  vLstNF);
      setocc(tFIS_NF, curocc(tFIS_NF) + 1);
    end;
    setocc(tFIS_NF, 1);
  end;

  voParams := tFIS_NF.Salvar();
  if (xStatus < 0) then begin
    Result := voParams;
    return(-1); exit;
  end;
  if (item_f('TP_OPERACAO', tGER_OPERACAO) = 'S')  and (item_f('TP_MODALIDADE', tGER_OPERACAO) = 3 ) or (item_f('TP_MODALIDADE', tGER_OPERACAO) = 4) then begin
    viParams := pParams;
    voParams := activateCmp('FISSVCO024', 'gravaObsNfFisco', viParams); (*,,,, *)
    if (xStatus < 0) then begin
      Result := voParams;
      return(-1); exit;
    end;
  end;

  voParams := ocalg = 55) then begin
    repeat
      getitem(vDsRegistro, vDsLstNotaFiscal, 1);
      if (itemXml('TP_ORIGEMEMISSAO', vDsRegistro) = 1) then begin
        putitemXml(viParams, 'CD_EMPRESA', itemXmlF('CD_EMPRESA', vDsRegistro));
        putitemXml(viParams, 'NR_FATURA', itemXmlF('NR_FATURA', vDsRegistro));
        putitemXml(viParams, 'DT_FATURA', itemXml('DT_FATURA', vDsRegistro));
        putitemXml(viParams, 'CD_MODELONF', itemXmlF('CD_MODELONF', vDsRegistro));
        voParams := activateCmp('FISSVCO024', 'gravaObsNfe', viParams); (*,,,, *)
        if (xStatus < 0) then begin
          Result := voParams;
          return(-1); exit;
        end;
      end;
      delitem(vDsLstNotaFiscal, 1);
    until (vDsLstNotaFiscal = '');

  end;
  if (gLstLoteInfGeral <> '')  and (!gInItemLote) then begin
    vDsLstLoteInfGeral := gLstLoteInfGeral;
    repeat
      getitem(vDsLoteInf, vDsLstLoteInfGeral, 1);
      vDsLstNF := '';
      vCdEmpLote := itemXmlF('CD_EMPRESA', vDsLoteInf);
      vNrLote := itemXmlF('NR_LOTE', vDsLoteInf);
      vNrItemLote := itemXmlF('NR_ITEM', vDsLoteInf);
      putitem(vDsLstNF,  vDsLoteInf);
      viParams := '';
      putitemXml(viParams, 'CD_EMPRESA', vCdEmpLote);
      putitemXml(viParams, 'NR_LOTE', vNrLote);
      putitemXml(viParams, 'NR_ITEM', vNrItemLote);
      putitemXml(viParams, 'IN_INCLUSAO', True);
      putitemXml(viParams, 'DS_LSTNF', vDsLstNF);
      voParams := activateCmp('PRDSVCO020', 'gravaLoteINF', viParams); (*,,,, *)
      if (xStatus < 0) then begin
        Result := voParams;
        return(-1); exit;
      end;
      delitem(vDsLstLoteInfGeral, 1);
    until (vDsLstLoteInfGeral = '');
  end;

  Result := '';
  vDsLstNF := '';
  if (empty(tFIS_NF) = False) then begin
    setocc(tFIS_NF, 1);
    while (xStatus >= 0) do begin
      vDsRegistro := '';
      putitemXml(vDsRegistro, 'CD_EMPRESA', item_f('CD_EMPRESA', tFIS_NF));
      putitemXml(vDsRegistro, 'NR_FATURA', item_f('NR_FATURA', tFIS_NF));
      putitemXml(vDsRegistro, 'DT_FATURA', item_a('DT_FATURA', tFIS_NF));
      putitem(vDsLstNF,  vDsRegistro);

      viParams := vDsRegistro;
      putitemXml(viParams, 'CD_MODULO', 'FIS');
      voParams := activateCmp('CTBSVCO016', 'geraContabilizaEmi', viParams); (*,,,, *)
      if (xStatus < 0) then begin
        Result := voParams;
        return(-1); exit;
      end;

      setocc(tFIS_NF, curocc(tFIS_NF) + 1);
    end;
  end;
  putitemXml(Result, 'DS_LSTNF', vDsLstNF);

  return(0); exit;
end;

//-------------------------------------------------------
function T_FISSVCO004.emiteNF(pParams : String) : String;
//-------------------------------------------------------
const
  cDS_METHOD = 'ADICIONAL=Operação: T_FISSVCO004.emiteNF()';
var
  viParams, voParams, vDsRegistro, vDsLstNF, vdsLstNrNF, vCdSerie, vDsLstTransp : String;
  vCdEmpresa, vNrFatura, vNrNF, vCdModeloNF, vNrLinha, vModDctoFiscal, vNrNFTransp : Real;
  vDtFatura, vDtSistema : TDate;
  vInECF : Boolean;
begin
  PARAM_GLB := PARAM_GLB;

  vDsLstNF := itemXml('DS_LSTNF', pParams);
  vCdModeloNF := itemXmlF('CD_MODELONF', pParams);
  vInECF := itemXmlB('IN_ECF', pParams);
  vDtSistema := itemXml('DT_SISTEMA', PARAM_GLB);

  clear_e(tGER_MODNFC);

  if (vCdModeloNF = 0) then begin
    if (vInECF <> True) then begin
      Result := SetStatus(STS_ERROR, 'GEN0001', 'Modelo de NF não informado!', cDS_METHOD);
      return(-1); exit;
    end;
  end else begin
    putitem_e(tGER_MODNFC, 'CD_MODELONF', vCdModeloNF);
    retrieve_e(tGER_MODNFC);
    if (xStatus < 0) then begin
      Result := SetStatus(STS_ERROR, 'GEN0001', 'Modelo de NF ' + FloatToStr(vCdModeloNF) + ' não cadastrado!', cDS_METHOD);
      return(-1); exit;
    end;
  end;

  getParams(pParams); (* vCdEmpresa *)
  if (xStatus < 0) then begin
    return(-1); exit;
  end;

  viParams := '';
  putitemXml(viParams, 'DS_LSTNF', vDsLstNF);
  voParams := activateCmp('SICSVCO005', 'reservaNumeroNF', viParams); (*,,,, *)
  if (xStatus < 0) then begin
    Result := voParams;
    return(-1); exit;
  end;
  vDsLstNF := itemXml('DS_LSTNF', voParams);
  vDsLstNrNF := itemXml('DS_LSTNF', voParams);

  if (vDsLstNF = '') then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Lista de NF não informada!', cDS_METHOD);
    return(-1); exit;
  end;

  clear_e(tFIS_NF);

  repeat
    getitem(vDsRegistro, vDsLstNF, 1);
    vCdEmpresa := itemXmlF('CD_EMPRESA', vDsRegistro);
    vNrFatura := itemXmlF('NR_FATURA', vDsRegistro);
    vDtFatura := itemXml('DT_FATURA', vDsRegistro);

    if (vCdEmpresa = 0) then begin
      Result := SetStatus(STS_ERROR, 'GEN0001', 'Empresa não informada!', cDS_METHOD);
      return(-1); exit;
    end;
    if (vNrFatura = 0) then begin
      Result := SetStatus(STS_ERROR, 'GEN0001', 'Fatura não informado!', cDS_METHOD);
      return(-1); exit;
    end;
    if (vDtFatura = '') then begin
      Result := SetStatus(STS_ERROR, 'GEN0001', 'Data NF não informada!', cDS_METHOD);
      return(-1); exit;
    end;

    creocc(tFIS_NF, -1);
    putitem_e(tFIS_NF, 'CD_EMPRESA', vCdEmpresa);
    putitem_e(tFIS_NF, 'NR_FATURA', vNrFatura);
    putitem_e(tFIS_NF, 'DT_FATURA', vDtFatura);
    retrieve_o(tFIS_NF);
    if (xStatus = -7) then begin
      retrieve_x(tFIS_NF);
    end else begin
      Result := SetStatus(STS_ERROR, 'GEN0001', 'NF ' + FloatToStr(vCdEmpresa) + ' / ' + FloatToStr(vNrFatura) + ' não cadastrada!', cDS_METHOD);
      return(-1); exit;
    end;
    vModDctoFiscal := item_f('TP_MODDCTOFISCAL', tFIS_NF);
    clear_e(tGER_OPERACAO);
    putitem_e(tGER_OPERACAO, 'CD_OPERACAO', item_f('CD_OPERACAO', tFIS_NF));
    retrieve_e(tGER_OPERACAO);
    if (xStatus < 0) then begin
      Result := SetStatus(STS_ERROR, 'GEN0001', 'Operaçao ' + CD_OPERACAO + '.GER_OPERACAO não cadastrada!', cDS_METHOD);
      return(-1); exit;
    end;
    if (item_f('TP_SITUACAO', tFIS_NF) = 'N') then begin
      if (item_f('TP_DOCTO', tGER_OPERACAO) = 0) then begin
        discard(tFIS_NF);
      end else begin
        if (item_f('TP_DOCTO', tGER_OPERACAO) = 2)  or (item_f('TP_DOCTO', tGER_OPERACAO) = 3) then begin
          vCdSerie := 'ECF';
        end else begin
          vCdSerie := item_a('DS_SIGLA', tGER_SERIE);
          if (vCdSerie = '') then begin
            vCdSerie := 'UN';
          end;
        end;
        if (item_f('TP_ORIGEMEMISSAO', tFIS_NF) = 2) then begin
          putitem_e(tFIS_NF, 'NR_NF', item_f('NR_FATURA', tFIS_NF));
          putitem_e(tFIS_NF, 'CD_SERIE', vCdSerie);
          putitem_e(tFIS_NF, 'DT_EMISSAO', vDtSistema);
          putitem_e(tFIS_NF, 'TP_SITUACAO', 'E');
        end else begin
          viParams := '';
          putitemXml(viParams, 'CD_EMPRESA', item_f('CD_EMPRESA', tFIS_NF));
          putitemXml(viParams, 'NR_FATURA', item_f('NR_FATURA', tFIS_NF));
          putitemXml(viParams, 'DT_FATURA', item_a('DT_FATURA', tFIS_NF));
          putitemXml(viParams, 'CD_EMPFAT', item_f('CD_EMPFAT', tFIS_NF));
          putitemXml(viParams, 'CD_SERIE', vCdSerie);

          if (item_f('TP_MODDCTOFISCAL', tFIS_NF) <> 85)  and (item_f('TP_MODDCTOFISCAL', tFIS_NF) <> 87) then begin
            voParams := OCAL', item_f('TP_MODDCTOFISCAL', tFIS_NF) *)
          end else begin
            voParams := OCAL', gTpModDctoFiscal *)
          end;

          newinstance 'GERSVCO001', 'GERSVCO001', 'TRANSACTION=TRUE';
          voParams := activateCmp('GERSVCO001', 'buscaNrNF', viParams); (*,,,, *)
          if (xStatus < 0) then begin
            Result := voParams;
            return(-1); exit;
          end;
          if (vCdSerie = 'ECF') then begin
            vNrNF := itemXmlF('NR_NF', voParams);
            if (vNrNF = 0) then begin
              Result := SetStatus(STS_ERROR, 'GEN0001', 'Não foi possivel obter numeração para a NF(ECF) ' + FloatToStr(vCdEmpresa) + ' / ' + FloatToStr(vNrFatura) + '!', cDS_METHOD);
              return(-1); exit;
            end;
            putitem_e(tFIS_NF, 'NR_NF', vNrNF);
            putitem_e(tFIS_NF, 'CD_SERIE', vCdSerie);
          end else begin
            discard(tFIS_NF);
            creocc(tFIS_NF, -1);
            putitem_e(tFIS_NF, 'CD_EMPRESA', vCdEmpresa);
            putitem_e(tFIS_NF, 'NR_FATURA', vNrFatura);
            putitem_e(tFIS_NF, 'DT_FATURA', vDtFatura);
            putitem_e(tFIS_NF, 'TP_MODDCTOFISCAL', vModDctoFiscal);
            retrieve_o(tFIS_NF);
            if (xStatus = -7) then begin
              retrieve_x(tFIS_NF);
            end else begin
              Result := SetStatus(STS_ERROR, 'GEN0001', 'Não possível recarregar a NF ' + FloatToStr(vCdEmpresa) + ' / ' + FloatToStr(vNrFatura) + ' após a rotina de numeração!', cDS_METHOD);
              return(-1); exit;
            end;
          end;
          putitem_e(tFIS_NF, 'DT_EMISSAO', vDtSistema);
          putitem_e(tFIS_NF, 'TP_SITUACAO', 'E');
          putitem_e(tFIS_NF, 'CD_MODELONF', item_f('CD_MODELONF', tGER_MODNFC));
        end;
      end;
    end else if (item_f('TP_SITUACAO', tFIS_NF) = 'E') then begin
    end else begin
      discard(tFIS_NF);
    end;

    delitem(vDsLstNF, 1);
  until (vDsLstNF = '');

  setocc(tFIS_NF, 1);

  if (empty(tFIS_NF) <> False) then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Nenhuma NF emitida!', cDS_METHOD);
    return(-1); exit;
  end;

  vNrNFTransp := 0;

  setocc(tFIS_NF, -1);
  if (totocc(tFIS_NF) > 1) then begin
    setocc(tFIS_NF, 1);

    vNrNFTransp := item_f('NR_NF', tFIS_NF);
  end;

  vDsLstTransp := '';

  setocc(tFIS_NF, 1);
  while (xStatus >= 0) do begin
    if (item_f('TP_ORIGEMEMISSAO', tFIS_NF) = 1) then begin
      if (item_f('NR_NF', tFIS_NF) = 0) then begin
        Result := SetStatus(STS_ERROR, 'GEN0001', 'Não foi possivel obter numeração para a NF ' + FloatToStr(vCdEmpresa) + ' / ' + FloatToStr(vNrFatura) + '!', cDS_METHOD);
        return(-1); exit;
      end;
      clear_e(tFIS_S_NF);
      putitem_e(tFIS_S_NF, 'CD_EMPFAT', item_f('CD_EMPFAT', tFIS_NF));
      putitem_e(tFIS_S_NF, 'NR_NF', item_f('NR_NF', tFIS_NF));
      putitem_e(tFIS_S_NF, 'CD_SERIE', item_f('CD_SERIE', tFIS_NF));
      putitem_e(tFIS_S_NF, 'TP_SITUACAO', '!=X');
      putitem_e(tFIS_S_NF, 'TP_ORIGEMEMISSAO', 1);
      putitem_e(tFIS_S_NF, 'TP_MODDCTOFISCAL', item_f('TP_MODDCTOFISCAL', tFIS_NF));
      retrieve_e(tFIS_S_NF);
      if (xStatus >= 0) then begin
        if (item_f('NR_FATURA', tFIS_S_NF) <> item_f('NR_FATURA', tFIS_NF))  or (item_a('DT_FATURA', tFIS_S_NF) <> item_a('DT_FATURA', tFIS_NF)) then begin
          Result := SetStatus(STS_ERROR, 'GEN0001', 'NF ' + NR_NF + '.FIS_NF já cadastrada!', cDS_METHOD);
          return(-1); exit;
        end;
      end;
    end;
    if (vNrNFTransp <> 0) then begin
      clear_e(tGER_OPERACAO);
      putitem_e(tGER_OPERACAO, 'CD_OPERACAO', item_f('CD_OPERACAO', tFIS_NF));
      retrieve_e(tGER_OPERACAO);
      if (xStatus >= 0) then begin
        if (item_f('TP_DOCTO', tGER_OPERACAO) <> 1) then begin
          vNrNFTransp := 0;
        end;
      end;
      if (item_f('TP_SITUACAO', tFIS_NF) <> 'E') then begin
        vNrNFTransp := 0;
      end;
      if (curocc(tFIS_NF) < totocc(FIS_NF)) then begin
        if (item_f('CD_EMPRESAORI', tFIS_NF) <> gnext(item_f('CD_EMPRESAORI', tFIS_NF))  or item_f('NR_TRANSACAOORI', tFIS_NF) <> next(item_f('NR_TRANSACAOORI', tFIS_NF))  or item_a('DT_TRANSACAOORI', tFIS_NF) <> gnext(item_a('DT_TRANSACAOORI', tFIS_NF))) then begin
          vNrNFTransp := 0;
        end;
      end;
    end;
    if (vNrNFTransp <> 0)  and (curocc(tFIS_NF) > 1) then begin
      vDsRegistro := '';
      putitemXml(vDsRegistro, 'CD_EMPRESA', item_f('CD_EMPRESA', tFIS_NF));
      putitemXml(vDsRegistro, 'NR_FATURA', item_f('NR_FATURA', tFIS_NF));
      putitemXml(vDsRegistro, 'DT_FATURA', item_a('DT_FATURA', tFIS_NF));
      putitem(vDsLstTransp,  vDsRegistro);
    end else if (vNrNFTransp = 0) then begin
      vDsLstTransp := '';
    end;

    setocc(tFIS_NF, curocc(tFIS_NF) + 1);
  end;
  setocc(tFIS_NF, 1);

  voParams := tFIS_NF.Salvar();
  if (xStatus < 0) then begin
    Result := voParams;
    return(-1); exit;
  end;
  if (vDsLstTransp <> '') then begin
    viParams := '';
    putitemXml(viParams, 'DS_LSTNF', vDsLstTransp);
    putitemXml(viParams, 'DS_OBSERVACAO', 'DADOS DA TRANSPORTADORA SE ENCONTRAM NA N.F. ' + FloatToStr(vNrNFTransp')) + ';
    newinstance 'FISSVCO004', 'FISSVCO004O', 'TRANSACTION=FALSE';
    voParams := activateCmp('FISSVCO004O', 'gravaObsNF', viParams); (*,,,, *)
    if (xStatus < 0) then begin
      Result := voParams;
      return(-1); exit;
    end;
  end;

  viParams := '';
  putitemXml(viParams, 'DS_LSTNF', vDsLstNrNF);
  voParams := activateCmp('SICSVCO005', 'liberaNumeroNF', viParams); (*,,,, *)
  if (xStatus < 0) then begin
    Result := voParams;
    return(-1); exit;
  end;

  vDsLstNrNF := itemXml('DS_LSTNF', voParams);

  Result := '';
  putitemXml(Result, 'DS_LSTNF', vDsLstNrNF);

  return(0); exit;
end;

//----------------------------------------------------------
function T_FISSVCO004.gravaECFNF(pParams : String) : String;
//----------------------------------------------------------
const
  cDS_METHOD = 'ADICIONAL=Operação: T_FISSVCO004.gravaECFNF()';
var
  viParams, voParams : String;
  vCdEmpresa, vNrFatura, vCdEmpECF, vNrECF, vNrCupom : Real;
  vDtFatura : TDate;
begin
  PARAM_GLB := PARAM_GLB;

  vCdEmpresa := itemXmlF('CD_EMPRESA', pParams);
  vNrFatura := itemXmlF('NR_FATURA', pParams);
  vDtFatura := itemXml('DT_FATURA', pParams);
  vCdEmpECF := itemXmlF('CD_EMPECF', pParams);
  vNrECF := itemXmlF('NR_ECF', pParams);
  vNrCupom := itemXmlF('NR_CUPOM', pParams);

  if (vCdEmpresa = 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Empresa não informada!', cDS_METHOD);
    return(-1); exit;
  end;
  if (vNrFatura = 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Fatura não informado!', cDS_METHOD);
    return(-1); exit;
  end;
  if (vDtFatura = '') then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Data NF não informada!', cDS_METHOD);
    return(-1); exit;
  end;
  if (vCdEmpECF = 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Empresa da ECF não informada!', cDS_METHOD);
    return(-1); exit;
  end;
  if (vNrECF = 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Número da ECF não informada!', cDS_METHOD);
    return(-1); exit;
  end;
  if (vNrCupom = 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Número do cupom não informado!', cDS_METHOD);
    return(-1); exit;
  end;

  clear_e(tFIS_ECF);
  putitem_e(tFIS_ECF, 'CD_EMPRESA', vCdEmpresa);
  putitem_e(tFIS_ECF, 'NR_ECF', vNrECF);
  retrieve_e(tFIS_ECF);
  if (xStatus < 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Número da ECF ' + FloatToStr(vNrECF) + ' não cadastrado!', cDS_METHOD);
    return(-1); exit;
  end;

  clear_e(tFIS_NF);
  putitem_e(tFIS_NF, 'CD_EMPRESA', vCdEmpresa);
  putitem_e(tFIS_NF, 'NR_FATURA', vNrFatura);
  putitem_e(tFIS_NF, 'DT_FATURA', vDtFatura);
  retrieve_o(tFIS_NF);
  if (xStatus = -7) then begin
    retrieve_x(tFIS_NF);
  end else if (xStatus = 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'NF ' + FloatToStr(vNrFatura) + ' não cadastrada!', cDS_METHOD);
    return(-1); exit;
  end;

  clear_e(tFIS_NFECF);
  retrieve_e(tFIS_NFECF);
  if (xStatus >= 0) then begin
    voParams := tFIS_NFECF.Excluir();
    if (xStatus < 0) then begin
      Result := voParams;
      return(-1); exit;
    end;
  end else begin
    clear_e(tFIS_NFECF);
  end;

  putitem_e(tFIS_NFECF, 'CD_EMPECF', vCdEmpECF);
  putitem_e(tFIS_NFECF, 'NR_ECF', vNrECF);
  putitem_e(tFIS_NFECF, 'CD_SERIEFAB', item_f('CD_SERIEFAB', tFIS_ECF));
  putitem_e(tFIS_NFECF, 'CD_EMPFAT', item_f('CD_EMPFAT', tFIS_NF));
  putitem_e(tFIS_NFECF, 'CD_GRUPOEMPRESA', item_f('CD_GRUPOEMPRESA', tFIS_NF));
  putitem_e(tFIS_NFECF, 'TP_SITUACAO', 'N');
  putitem_e(tFIS_NFECF, 'NR_CUPOM', vNrCupom);
  putitem_e(tFIS_NFECF, 'CD_OPERADOR', itemXmlF('CD_USUARIO', PARAM_GLB));
  putitem_e(tFIS_NFECF, 'DT_CADASTRO', Now);

  voParams := tFIS_NFECF.Salvar();
  if (xStatus < 0) then begin
    Result := voParams;
    return(-1); exit;
  end;

  return(0); exit;
end;

//----------------------------------------------------------------
function T_FISSVCO004.alteraSituacaoNF(pParams : String) : String;
//----------------------------------------------------------------
const
  cDS_METHOD = 'ADICIONAL=Operação: T_FISSVCO004.alteraSituacaoNF()';
var
  viParams, voParams, vDsRegistro, vDsLstNF, vTpSituacao : String;
  vCdEmpresa, vNrFatura : Real;
  vDtFatura : TDate;
  vInValidaTransacao : Boolean;
begin
  PARAM_GLB := PARAM_GLB;

  vDsLstNF := itemXml('DS_LSTNF', pParams);
  vTpSituacao := itemXmlF('TP_SITUACAO', pParams);

  vInValidaTransacao := itemXmlB('IN_VALIDATRANSACAO', pParams);
  if (vInValidaTransacao = '') then begin
    vInValidaTransacao := True;
  end;
  if (vDsLstNF = '') then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Lista de NF não informada!', cDS_METHOD);
    return(-1); exit;
  end;
  if (vTpSituacao = '') then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Situação não informada!', cDS_METHOD);
    return(-1); exit;
  end;
  if (vTpSituacao <> 'N')  and (vTpSituacao <> 'E')  and (vTpSituacao <> 'C')  and (vTpSituacao <> 'X')  and (vTpSituacao <> 'D') then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Situação ' + FloatToStr(vTpSituacao) + ' inválida!', cDS_METHOD);
    return(-1); exit;
  end;

  getParams(pParams); (* 0 *)
  if (xStatus < 0) then begin
    return(-1); exit;
  end;

  clear_e(tFIS_NF);
  repeat
    getitem(vDsRegistro, vDsLstNF, 1);
    vCdEmpresa := itemXmlF('CD_EMPRESA', vDsRegistro);
    vNrFatura := itemXmlF('NR_FATURA', vDsRegistro);
    vDtFatura := itemXml('DT_FATURA', vDsRegistro);

    if (vCdEmpresa = 0) then begin
      Result := SetStatus(STS_ERROR, 'GEN0001', 'Empresa não informada!', cDS_METHOD);
      return(-1); exit;
    end;
    if (vNrFatura = 0) then begin
      Result := SetStatus(STS_ERROR, 'GEN0001', 'Fatura não informado!', cDS_METHOD);
      return(-1); exit;
    end;
    if (vDtFatura = '') then begin
      Result := SetStatus(STS_ERROR, 'GEN0001', 'Data NF não informada!', cDS_METHOD);
      return(-1); exit;
    end;

    creocc(tFIS_NF, -1);
    putitem_e(tFIS_NF, 'CD_EMPRESA', vCdEmpresa);
    putitem_e(tFIS_NF, 'NR_FATURA', vNrFatura);
    putitem_e(tFIS_NF, 'DT_FATURA', vDtFatura);
    retrieve_o(tFIS_NF);
    if (xStatus = -7) then begin
      retrieve_x(tFIS_NF);

      if (vTpSituacao = 'C' ) or (vTpSituacao = 'X')  and (vInValidaTransacao = True) then begin
        clear_e(tTRA_TRANSACAO);
        putitem_e(tTRA_TRANSACAO, 'CD_EMPRESA', item_f('CD_EMPRESAORI', tFIS_NF));
        putitem_e(tTRA_TRANSACAO, 'NR_TRANSACAO', item_f('NR_TRANSACAOORI', tFIS_NF));
        putitem_e(tTRA_TRANSACAO, 'DT_TRANSACAO', item_a('DT_TRANSACAOORI', tFIS_NF));
        retrieve_e(tTRA_TRANSACAO);
        if (xStatus >= 0) then begin
          if (item_f('TP_SITUACAO', tTRA_TRANSACAO) <> 6) then begin
            Result := SetStatus(STS_ERROR, 'GEN0001', 'Transação ' + NR_TRANSACAOORI + '.TRA_TRANSACAO não está cancelada!', cDS_METHOD);
            return(-1); exit;
          end;
        end;
      end;

      clear_e(tGER_OPERACAO);
      putitem_e(tGER_OPERACAO, 'CD_OPERACAO', item_f('CD_OPERACAO', tFIS_NF));
      retrieve_e(tGER_OPERACAO);
      if (xStatus < 0) then begin
        Result := SetStatus(STS_ERROR, 'GEN0001', 'Operaçao ' + CD_OPERACAO + '.FIS_NF não cadastrada!', cDS_METHOD);
        return(-1); exit;
      end;
      if (gDtEncerramento <> '')  and (item_f('TP_DOCTO', tGER_OPERACAO) <> 0) then begin
        if (item_a('DT_SAIDAENTRADA', tFIS_NF) <= gDtEncerramento) then begin
          Result := SetStatus(STS_ERROR, 'GEN0001', 'NF/Fatura ' + NR_NF + '.FIS_NF/' + NR_FATURA + '.FIS_NF possuir data de movimento anterior ao encerramento do livro fiscal!', cDS_METHOD);
          return(-1); exit;
        end;
      end;
    end else if (xStatus = 0) then begin
      Result := SetStatus(STS_ERROR, 'GEN0001', 'NF ' + FloatToStr(vNrFatura) + ' não cadastrada!', cDS_METHOD);
      return(-1); exit;
    end;

    putitem_e(tFIS_NF, 'TP_SITUACAO', vTpSituacao);
    putitem_e(tFIS_NF, 'CD_OPERADOR', itemXmlF('CD_USUARIO', PARAM_GLB));
    putitem_e(tFIS_NF, 'DT_CADASTRO', Now);

    delitem(vDsLstNF, 1);
  until (vDsLstNF = '');

  voParams := tFIS_NF.Salvar();
  if (xStatus < 0) then begin
    Result := voParams;
    return(-1); exit;
  end;

  return(0); exit;
end;

//-----------------------------------------------------------------
function T_FISSVCO004.alteraImpressaoNF(pParams : String) : String;
//-----------------------------------------------------------------
const
  cDS_METHOD = 'ADICIONAL=Operação: T_FISSVCO004.alteraImpressaoNF()';
var
  viParams, voParams, vDsRegistro, vDsLstNF : String;
  vCdEmpresa, vNrFatura, vCdModeloNF : Real;
  vDtFatura : TDate;
begin
  PARAM_GLB := PARAM_GLB;

  vDsLstNF := itemXml('DS_LSTNF', pParams);
  vCdModeloNF := itemXmlF('CD_MODELONF', pParams);

  if (vDsLstNF = '') then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Lista de NF não informada!', cDS_METHOD);
    return(-1); exit;
  end;
  if (vCdModeloNF = 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Modelo de NF não informado!', cDS_METHOD);
    return(-1); exit;
  end;

  clear_e(tGER_MODNFC);
  putitem_e(tGER_MODNFC, 'CD_MODELONF', vCdModeloNF);
  retrieve_e(tGER_MODNFC);
  if (xStatus < 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Modelo de NF ' + FloatToStr(vCdModeloNF) + ' não cadastrado!', cDS_METHOD);
    return(-1); exit;
  end;

  clear_e(tFIS_NF);

  repeat
    getitem(vDsRegistro, vDsLstNF, 1);
    vCdEmpresa := itemXmlF('CD_EMPRESA', vDsRegistro);
    vNrFatura := itemXmlF('NR_FATURA', vDsRegistro);
    vDtFatura := itemXml('DT_FATURA', vDsRegistro);

    if (vCdEmpresa = 0) then begin
      Result := SetStatus(STS_ERROR, 'GEN0001', 'Empresa não informada!', cDS_METHOD);
      return(-1); exit;
    end;
    if (vNrFatura = 0) then begin
      Result := SetStatus(STS_ERROR, 'GEN0001', 'Fatura não informado!', cDS_METHOD);
      return(-1); exit;
    end;
    if (vDtFatura = '') then begin
      Result := SetStatus(STS_ERROR, 'GEN0001', 'Data NF não informada!', cDS_METHOD);
      return(-1); exit;
    end;

    creocc(tFIS_NF, -1);
    putitem_e(tFIS_NF, 'CD_EMPRESA', vCdEmpresa);
    putitem_e(tFIS_NF, 'NR_FATURA', vNrFatura);
    putitem_e(tFIS_NF, 'DT_FATURA', vDtFatura);
    retrieve_o(tFIS_NF);
    if (xStatus = -7) then begin
      retrieve_x(tFIS_NF);
    end else if (xStatus = 0) then begin
      Result := SetStatus(STS_ERROR, 'GEN0001', 'NF ' + FloatToStr(vNrFatura) + ' não cadastrada!', cDS_METHOD);
      return(-1); exit;
    end;
    if (item_f('TP_ORIGEMEMISSAO', tFIS_NF) = 1) then begin
      clear_e(tFIS_S_NF);
      putitem_e(tFIS_S_NF, 'CD_EMPFAT', item_f('CD_EMPFAT', tFIS_NF));
      putitem_e(tFIS_S_NF, 'NR_NF', item_f('NR_NF', tFIS_NF));
      putitem_e(tFIS_S_NF, 'CD_SERIE', item_f('CD_SERIE', tFIS_NF));
      putitem_e(tFIS_S_NF, 'TP_SITUACAO', '!=X');
      putitem_e(tFIS_S_NF, 'TP_ORIGEMEMISSAO', 1);
      putitem_e(tFIS_S_NF, 'TP_MODDCTOFISCAL', item_f('TP_MODDCTOFISCAL', tFIS_NF));
      retrieve_e(tFIS_S_NF);
      if (xStatus >= 0) then begin
        if (item_f('NR_FATURA', tFIS_S_NF) <> item_f('NR_FATURA', tFIS_NF))  or (item_a('DT_FATURA', tFIS_S_NF) <> item_a('DT_FATURA', tFIS_NF)) then begin
          Result := SetStatus(STS_ERROR, 'GEN0001', 'NF ' + NR_NF + '.FIS_NF já cadastrada!', cDS_METHOD);
          return(-1); exit;
        end;
      end;
    end;

    putitem_e(tFIS_NF, 'CD_MODELONF', vCdModeloNF);
    if (item_f('NR_IMPRESSAO', tFIS_NF) = 0) then begin
      putitem_e(tFIS_NF, 'NR_IMPRESSAO', 1);
    end else begin
      putitem_e(tFIS_NF, 'NR_IMPRESSAO', item_f('NR_IMPRESSAO', tFIS_NF) + 1);
    end;
    putitem_e(tFIS_NF, 'CD_USUIMPRESSAO', itemXmlF('CD_USUARIO', PARAM_GLB));
    putitem_e(tFIS_NF, 'DT_IMPRESSAO', Now);
    putitem_e(tFIS_NF, 'CD_OPERADOR', itemXmlF('CD_USUARIO', PARAM_GLB));
    putitem_e(tFIS_NF, 'DT_CADASTRO', Now);

    delitem(vDsLstNF, 1);
  until (vDsLstNF = '');

  voParams := tFIS_NF.Salvar();
  if (xStatus < 0) then begin
    Result := voParams;
    return(-1); exit;
  end;

  return(0); exit;
end;

//-----------------------------------------------------------
function T_FISSVCO004.gravaCapaNF(pParams : String) : String;
//-----------------------------------------------------------
const
  cDS_METHOD = 'ADICIONAL=Operação: T_FISSVCO004.gravaCapaNF()';
var
  viParams, voParams : String;
  vCdEmpresa, vNrFatura, vTpModDctoFiscal, vCdGrupoEmpresa : Real;
  vDtFatura : TDate;
  vInInclusao : Boolean;
begin
  PARAM_GLB := PARAM_GLB;

  vCdEmpresa := itemXmlF('CD_EMPRESA', pParams);
  vCdGrupoEmpresa := itemXmlF('CD_GRUPOEMPRESA', pParams);
  vNrFatura := itemXmlF('NR_FATURA', pParams);
  vDtFatura := itemXml('DT_FATURA', pParams);
  vInInclusao := itemXmlB('IN_INCLUSAO', pParams);
  vTpModDctoFiscal := itemXmlF('TP_MODDCTOFISCAL', pParams);

  if (vCdEmpresa = 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Empresa não informada!', cDS_METHOD);
    return(-1); exit;
  end;
  if (vInInclusao = True) then begin
    if (vNrFatura > 0) then begin
      Result := SetStatus(STS_ERROR, 'GEN0001', 'Fatura não pode ser informada p/ inclusão!', cDS_METHOD);
      return(-1); exit;
    end;
  end else begin
    if (vNrFatura = 0) then begin
      Result := SetStatus(STS_ERROR, 'GEN0001', 'Fatura não informado!', cDS_METHOD);
      return(-1); exit;
    end;
  end;
  if (vDtFatura = '') then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Data NF não informada!', cDS_METHOD);
    return(-1); exit;
  end;

  getParams(pParams); (* vCdEmpresa *)
  if (xStatus < 0) then begin
    return(-1); exit;
  end;

  clear_e(tTRA_TRANSACAO);

  if (vInInclusao = True) then begin
    viParams := '';
    putitemXml(viParams, 'NM_ENTIDADE', 'FIS_NF');
    voParams := activateCmp('GERSVCO031', 'getNumSeq', viParams); (*,,,, *)
    if (xStatus < 0) then begin
      Result := voParams;
      return(-1); exit;
    end;
    vNrFatura := itemXmlF('NR_SEQUENCIA', voParams);

    clear_e(tFIS_NF);
    creocc(tFIS_NF, -1);
    putitem_e(tFIS_NF, 'CD_EMPRESA', vCdEmpresa);
    putitem_e(tFIS_NF, 'NR_FATURA', vNrFatura);
    putitem_e(tFIS_NF, 'DT_FATURA', vDtFatura);
  end else begin
    clear_e(tFIS_NF);
    putitem_e(tFIS_NF, 'CD_EMPRESA', vCdEmpresa);
    putitem_e(tFIS_NF, 'NR_FATURA', vNrFatura);
    putitem_e(tFIS_NF, 'DT_FATURA', vDtFatura);
    retrieve_e(tFIS_NF);
    if (xStatus < 0) then begin
      Result := SetStatus(STS_ERROR, 'GEN0001', 'NF ' + FloatToStr(vNrFatura) + ' não cadastrada!', cDS_METHOD);
      return(-1); exit;
    end;
    if (gDtEncerramento <> '') then begin
      if (item_a('DT_SAIDAENTRADA', tFIS_NF) <= gDtEncerramento) then begin
        Result := SetStatus(STS_ERROR, 'GEN0001', 'NF/Fatura ' + NR_NF + '.FIS_NF/' + NR_FATURA + '.FIS_NF possui data de movimento anterior ao encerramento do livro fiscal!', cDS_METHOD);
        return(-1); exit;
      end;
    end;
    if (item_f('NR_TRANSACAOORI', tFIS_NF) > 0) then begin
      clear_e(tTRA_TRANSACAO);
      putitem_e(tTRA_TRANSACAO, 'CD_EMPRESA', item_f('CD_EMPRESAORI', tFIS_NF));
      putitem_e(tTRA_TRANSACAO, 'NR_TRANSACAO', item_f('NR_TRANSACAOORI', tFIS_NF));
      putitem_e(tTRA_TRANSACAO, 'DT_TRANSACAO', item_a('DT_TRANSACAOORI', tFIS_NF));
      retrieve_e(tTRA_TRANSACAO);
      if (xStatus < 0) then begin
        Result := SetStatus(STS_ERROR, 'GEN0001', 'Transação ' + NR_TRANSACAOORI + '.TRA_TRANSACAO não cadastrada!', cDS_METHOD);
        return(-1); exit;
      end;
      vCdGrupoEmpresa := item_f('CD_GRUPOEMPRESA', tTRA_TRANSACAO);
    end;
  end;

  delitem(pParams, 'CD_EMPRESA');
  delitem(pParams, 'NR_FATURA');
  delitem(pParams, 'DT_FATURA');

  getlistitensocc_e(pParams, tFIS_NF);

  if (item_a('DT_SAIDAENTRADA', tFIS_NF) = '') then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Data saída/entrada não informada!', cDS_METHOD);
    return(-1); exit;
  end;
  if (gDtEncerramento <> '') then begin
    if (item_a('DT_SAIDAENTRADA', tFIS_NF) <= gDtEncerramento) then begin
      Result := SetStatus(STS_ERROR, 'GEN0001', 'NF/Fatura ' + NR_NF + '.FIS_NF/' + NR_FATURA + '.FIS_NF possui data de movimento anterior ao encerramento do livro fiscal!', cDS_METHOD);
      return(-1); exit;
    end;
  end;
  if (item_f('TP_SITUACAO', tFIS_NF) = '') then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Situação não informada!', cDS_METHOD);
    return(-1); exit;
  end;
  if (item_f('TP_SITUACAO', tFIS_NF) = 'E') then begin
    if (item_a('DT_EMISSAO', tFIS_NF) = '') then begin
      Result := SetStatus(STS_ERROR, 'GEN0001', 'Data emissão não informada!', cDS_METHOD);
      return(-1); exit;
    end;
    if (item_f('NR_NF', tFIS_NF) = 0) then begin
      Result := SetStatus(STS_ERROR, 'GEN0001', 'Número NF não informada!', cDS_METHOD);
      return(-1); exit;
    end;
  end;
  if (item_a('HR_SAIDA', tFIS_NF) = '') then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Hora de saída não informada!', cDS_METHOD);
    return(-1); exit;
  end;
  if (item_f('CD_PESSOA', tFIS_NF) = 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Pessoa não informada!', cDS_METHOD);
    return(-1); exit;
  end;
  if (item_f('CD_COMPVEND', tFIS_NF) = 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Comprador/vendedor não informado!', cDS_METHOD);
    return(-1); exit;
  end;
  if (item_f('CD_CONDPGTO', tFIS_NF) = 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Condição de pagamento não informada!', cDS_METHOD);
    return(-1); exit;
  end;
  if (item_f('CD_OPERACAO', tFIS_NF) = 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Operação não informada!', cDS_METHOD);
    return(-1); exit;
  end;
  if (vCdGrupoEmpresa = 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Grupo empresa não informado!', cDS_METHOD);
    return(-1); exit;
  end;

  clear_e(tGER_OPERACAO);
  putitem_e(tGER_OPERACAO, 'CD_OPERACAO', item_f('CD_OPERACAO', tFIS_NF));
  retrieve_e(tGER_OPERACAO);
  if (xStatus < 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Operaçao ' + CD_OPERACAO + '.FIS_NF não cadastrada!', cDS_METHOD);
    return(-1); exit;
  end;
  if (vInInclusao = True) then begin
    putitem_e(tFIS_NF, 'CD_EMPFAT', item_f('CD_EMPRESA', tFIS_NF));
  end;

  putitem_e(tFIS_NF, 'VL_TOTALNOTA', item_f('VL_TOTALPRODUTO', tFIS_NF) + item_f('VL_DESPACESSOR', tFIS_NF) + item_f('VL_FRETE', tFIS_NF) + item_f('VL_SEGURO', tFIS_NF) + item_f('VL_IPI', tFIS_NF) + item_f('VL_ICMSSUBST', tFIS_NF));
  putitem_e(tFIS_NF, 'TP_OPERACAO', item_f('TP_OPERACAO', tGER_OPERACAO));
  putitem_e(tFIS_NF, 'CD_GRUPOEMPRESA', vCdGrupoEmpresa);
  putitem_e(tFIS_NF, 'CD_OPERADOR', itemXmlF('CD_USUARIO', PARAM_GLB));
  putitem_e(tFIS_NF, 'DT_CADASTRO', Now);

  if (vTpModDctoFiscal = 85)  or (vTpModDctoFiscal = 87) then begin
    putitem_e(tFIS_NF, 'VL_TOTALNOTA', 0);
    putitem_e(tFIS_NF, 'VL_TOTALPRODUTO', 0);
    putitem_e(tFIS_NF, 'VL_DESPACESSOR', 0);
    putitem_e(tFIS_NF, 'VL_SEGURO', 0);
    putitem_e(tFIS_NF, 'VL_FRETE', 0);
    putitem_e(tFIS_NF, 'QT_FATURADO', 0);
    putitem_e(tFIS_NF, 'VL_BASEICMS', 0);
  end;

  voParams := tFIS_NF.Salvar();
  if (xStatus < 0) then begin
    Result := voParams;
    return(-1); exit;
  end;

  Result := '';
  putitemXml(Result, 'CD_EMPRESA', item_f('CD_EMPRESA', tFIS_NF));
  putitemXml(Result, 'NR_FATURA', item_f('NR_FATURA', tFIS_NF));
  putitemXml(Result, 'DT_FATURA', item_a('DT_FATURA', tFIS_NF));

  return(0); exit;
end;

//----------------------------------------------------------
function T_FISSVCO004.gravaObsNF(pParams : String) : String;
//----------------------------------------------------------
const
  cDS_METHOD = 'ADICIONAL=Operação: T_FISSVCO004.gravaObsNF()';
var
  dsLinhaObs, vDsLstNF, vDsRegistro : String;
  vCdEmpresa, vNrFatura, NrLinha, viParams, voParams : Real;
  vDtFatura : TDate;
begin
  PARAM_GLB := PARAM_GLB;

  vDsLstNF := itemXml('DS_LSTNF', pParams);
  if (vDsLstNF = '') then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Lista de nota não informada!', cDS_METHOD);
    return(-1); exit;
  end;

  clear_e(tFIS_NF);

  repeat
    getitem(vDsRegistro, vDsLstNF, 1);
    vCdEmpresa := itemXmlF('CD_EMPRESA', vDsRegistro);
    vNrFatura := itemXmlF('NR_FATURA', vDsRegistro);
    vDtFatura := itemXml('DT_FATURA', vDsRegistro);
    dsLinhaObs := itemXml('DS_OBSERVACAO', pParams);
    if (dsLinhaObs = '') then begin
      Result := SetStatus(STS_ERROR, 'GEN0001', 'Observação não informada!', cDS_METHOD);
      return(-1); exit;
    end;
    if (vDtFatura = '') then begin
      Result := SetStatus(STS_ERROR, 'GEN0001', 'Data da fatura não informada!', cDS_METHOD);
      return(-1); exit;
    end;
    if (vNrFatura = 0) then begin
      Result := SetStatus(STS_ERROR, 'GEN0001', 'Número da fatura não informada!', cDS_METHOD);
      return(-1); exit;
    end;
    if (vCdEmpresa = 0) then begin
      Result := SetStatus(STS_ERROR, 'GEN0001', 'Empresa da transação não informada!', cDS_METHOD);
      return(-1); exit;
    end;

    creocc(tFIS_NF, -1);
    putitem_e(tFIS_NF, 'CD_EMPRESA', vCdEmpresa);
    putitem_e(tFIS_NF, 'NR_FATURA', vNrFatura);
    putitem_e(tFIS_NF, 'DT_FATURA', vDtFatura);
    retrieve_o(tFIS_NF);
    if (xStatus = -7) then begin
      retrieve_x(tFIS_NF);
    end else if (xStatus <> 4) then begin
      Result := SetStatus(STS_ERROR, 'GEN0001', 'NF ' + FloatToStr(vNrFatura) + ' não cadastrada!', cDS_METHOD);
      return(-1); exit;
    end;

    setocc(tOBS_NF, -1);
    NrLinha := item_f('NR_LINHA', tOBS_NF) + 1;
    creocc(tOBS_NF, -1);
    putitem_e(tOBS_NF, 'CD_EMPFAT', item_f('CD_EMPFAT', tFIS_NF));
    putitem_e(tOBS_NF, 'CD_GRUPOEMPRESA', item_f('CD_GRUPOEMPRESA', tFIS_NF));
    putitem_e(tOBS_NF, 'NR_LINHA', NrLinha);
    putitem_e(tOBS_NF, 'DS_OBSERVACAO', DsLinhaObs[1 : 80]);
    putitem_e(tOBS_NF, 'CD_OPERADOR', itemXmlF('CD_USUARIO', PARAM_GLB));
    putitem_e(tOBS_NF, 'DT_CADASTRO', Now);

    delitem(vDsLstNF, 1);
  until (vDsLstNF = '');

  voParams := tOBS_NF.Salvar();
  if (xStatus < 0) then begin
    Result := voParams;
    return(-1); exit;
  end;

  return(0); exit;
end;

//---------------------------------------------------------------
function T_FISSVCO004.gravaItemProdNF(pParams : String) : String;
//---------------------------------------------------------------
const
  cDS_METHOD = 'ADICIONAL=Operação: T_FISSVCO004.gravaItemProdNF()';
var
  vCdEmpresa, vNrFatura, vCdProduto,vNritem : Real;
  vDtFatura : TDate;
begin
  PARAM_GLB := PARAM_GLB;

  vCdEmpresa := itemXmlF('CD_EMPRESA', pParams);
  vNrFatura := itemXmlF('NR_FATURA', pParams);
  vDtFatura := itemXml('DT_FATURA', pParams);
  vCdProduto := itemXmlF('CD_PRODUTO', pParams);
  vNrItem := itemXmlF('NR_ITEM', pParams);
  if (vCdEmpresa = 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Empresa não informada!', cDS_METHOD);
    return(-1); exit;
  end;
  if (vNrFatura = 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Fatura não informado!', cDS_METHOD);
    return(-1); exit;
  end;
  if (vDtFatura = '') then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Data NF não informada!', cDS_METHOD);
    return(-1); exit;
  end;
  if (vCdProduto = '') then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Produto não informado!', cDS_METHOD);
    return(-1); exit;
  end;
  if (vNrItem = '') then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Número do item não informado!', cDS_METHOD);
    return(-1); exit;
  end;

  getParams(pParams); (* vCdEmpresa *)
  if (xStatus < 0) then begin
    return(-1); exit;
  end;

  clear_e(tFIS_NF);
  putitem_e(tFIS_NF, 'CD_EMPRESA', vCdEmpresa);
  putitem_e(tFIS_NF, 'NR_FATURA', vNrFatura);
  putitem_e(tFIS_NF, 'DT_FATURA', vDtFatura);
  retrieve_e(tFIS_NF);
  if (xStatus < 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Nota Fiscal não encotrada!', cDS_METHOD);
    return(-1); exit;
  end;
  if (gDtEncerramento <> '') then begin
    if (item_a('DT_SAIDAENTRADA', tFIS_NF) <= gDtEncerramento) then begin
      Result := SetStatus(STS_ERROR, 'GEN0001', 'NF/Fatura ' + NR_NF + '.FIS_NF/' + NR_FATURA + '.FIS_NF possui data de movimento anterior ao encerramento do livro fiscal!', cDS_METHOD);
      return(-1); exit;
    end;
  end;

  clear_e(tFIS_NFITEM);
  putitem_e(tFIS_NFITEM, 'NR_ITEM', vNrItem);
  retrieve_e(tFIS_NFITEM);
  if (xStatus < 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Itens da Nota Fiscal não encotrada!', cDS_METHOD);
    return(-1); exit;
  end;

  clear_e(tFIS_NFITEMPRO);
  putitem_e(tFIS_NFITEMPRO, 'CD_PRODUTO', vCdProduto);
  retrieve_e(tFIS_NFITEMPRO);
  if (xStatus < 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Produto ' + FloatToStr(vCdProduto) + ' não encotrado!', cDS_METHOD);
    return(-1); exit;
  end;

  delitem(pParams, 'CD_EMPRESA');
  delitem(pParams, 'NR_FATURA');
  delitem(pParams, 'DT_FATURA');
  delitem(pParams, 'NR_ITEM');
  delitem(pParams, 'CD_PRODUTO');

  getlistitensocc_e(pParams, tFIS_NFITEMPRO);

  voParams := tFIS_NFITEMPRO.Salvar();
  if (xStatus < 0) then begin
    Result := voParams;
    return(-1); exit;
  end;

  return(0); exit;
end;

//-----------------------------------------------------------
function T_FISSVCO004.gravaItemNF(pParams : String) : String;
//-----------------------------------------------------------
const
  cDS_METHOD = 'ADICIONAL=Operação: T_FISSVCO004.gravaItemNF()';
var
  vCdEmpresa, vNrFatura, vCdProduto, vNritem, vTpModDctoFiscal : Real;
  vDtFatura : TDate;
  vInInclusao : Boolean;
begin
  PARAM_GLB := PARAM_GLB;

  vCdEmpresa := itemXmlF('CD_EMPRESA', pParams);
  vNrFatura := itemXmlF('NR_FATURA', pParams);
  vDtFatura := itemXml('DT_FATURA', pParams);
  vCdProduto := itemXmlF('CD_PRODUTO', pParams);
  vNrItem := itemXmlF('NR_ITEM', pParams);
  vInInclusao := itemXmlB('IN_INCLUSAO', pParams);
  vTpModDctoFiscal := itemXmlF('TP_MODDCTOFISCAL', pParams);

  if (vCdEmpresa = 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Empresa não informada!', cDS_METHOD);
    return(-1); exit;
  end;
  if (vNrFatura = 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Fatura não informado!', cDS_METHOD);
    return(-1); exit;
  end;
  if (vDtFatura = '') then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Data NF não informada!', cDS_METHOD);
    return(-1); exit;
  end;
  if (vCdProduto = '') then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Produto não informado!', cDS_METHOD);
    return(-1); exit;
  end;
  if (vNrItem = '') then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Número do item não informado!', cDS_METHOD);
    return(-1); exit;
  end;

  getParams(pParams); (* vCdEmpresa *)
  if (xStatus < 0) then begin
    return(-1); exit;
  end;

  clear_e(tFIS_NF);
  putitem_e(tFIS_NF, 'CD_EMPRESA', vCdEmpresa);
  putitem_e(tFIS_NF, 'NR_FATURA', vNrFatura);
  putitem_e(tFIS_NF, 'DT_FATURA', vDtFatura);
  retrieve_e(tFIS_NF);
  if (xStatus < 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Nota Fiscal não encotrada!', cDS_METHOD);
    return(-1); exit;
  end;
  if (gDtEncerramento <> '') then begin
    if (item_a('DT_SAIDAENTRADA', tFIS_NF) <= gDtEncerramento) then begin
      Result := SetStatus(STS_ERROR, 'GEN0001', 'NF/Fatura ' + NR_NF + '.FIS_NF/' + NR_FATURA + '.FIS_NF possui data de movimento anterior ao encerramento do livro fiscal!', cDS_METHOD);
      return(-1); exit;
    end;
  end;
  if (vInInclusao = True) then begin
  end else begin
    clear_e(tFIS_NFITEM);
    putitem_e(tFIS_NFITEM, 'NR_ITEM', vNrItem);
    retrieve_e(tFIS_NFITEM);
    if (xStatus < 0) then begin
      Result := SetStatus(STS_ERROR, 'GEN0001', 'Itens da Nota Fiscal não encotrada!', cDS_METHOD);
      return(-1); exit;
    end;

    delitem(pParams, 'CD_EMPRESA');
    delitem(pParams, 'NR_FATURA');
    delitem(pParams, 'DT_FATURA');
    delitem(pParams, 'NR_ITEM');
  end;

  getlistitensocc_e(pParams, tFIS_NFITEM);

  putitem_e(tFIS_NFITEM, 'CD_EMPFAT', item_f('CD_EMPFAT', tFIS_NF));
  putitem_e(tFIS_NFITEM, 'CD_GRUPOEMPRESA', item_f('CD_GRUPOEMPRESA', tFIS_NF));
  putitem_e(tFIS_NFITEM, 'CD_OPERADOR', itemXmlF('CD_USUARIO', PARAM_GLB));
  putitem_e(tFIS_NFITEM, 'DT_CADASTRO', Now);

  if (vTpModDctoFiscal = 85)  or (vTpModDctoFiscal = 87) then begin
    putitem_e(tFIS_NFITEM, 'VL_TOTALLIQUIDO', 0);
    putitem_e(tFIS_NFITEM, 'VL_TOTALBRUTO', 0);
    putitem_e(tFIS_NFITEM, 'VL_UNITLIQUIDO', 0);
    putitem_e(tFIS_NFITEM, 'VL_UNITBRUTO', 0);
    putitem_e(tFIS_NFITEM, 'QT_FATURADO', 0);
  end;

  voParams := tFIS_NFITEM.Salvar();
  if (xStatus < 0) then begin
    Result := voParams;
    return(-1); exit;
  end;

  return(0); exit;
end;

//---------------------------------------------------------------
function T_FISSVCO004.gravaenderecoNF(pParams : String) : String;
//---------------------------------------------------------------
const
  cDS_METHOD = 'ADICIONAL=Operação: T_FISSVCO004.gravaenderecoNF()';
var
  vCdEmpresa, vNrFatura, vCdProduto,vNritem : Real;
  vDtFatura : TDate;
begin
  PARAM_GLB := PARAM_GLB;

  vCdEmpresa := itemXmlF('CD_EMPRESA', pParams);
  vNrFatura := itemXmlF('NR_FATURA', pParams);
  vDtFatura := itemXml('DT_FATURA', pParams);
  if (vCdEmpresa = 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Empresa não informada!', cDS_METHOD);
    return(-1); exit;
  end;
  if (vNrFatura = 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Fatura não informado!', cDS_METHOD);
    return(-1); exit;
  end;
  if (vDtFatura = '') then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Data NF não informada!', cDS_METHOD);
    return(-1); exit;
  end;

  getParams(pParams); (* vCdEmpresa *)
  if (xStatus < 0) then begin
    return(-1); exit;
  end;

  clear_e(tFIS_NF);
  putitem_e(tFIS_NF, 'CD_EMPRESA', vCdEmpresa);
  putitem_e(tFIS_NF, 'NR_FATURA', vNrFatura);
  putitem_e(tFIS_NF, 'DT_FATURA', vDtFatura);
  retrieve_e(tFIS_NF);
  if (xStatus < 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Nota Fiscal não encotrada!', cDS_METHOD);
    return(-1); exit;
  end;
  if (gDtEncerramento <> '') then begin
    if (item_a('DT_SAIDAENTRADA', tFIS_NF) <= gDtEncerramento) then begin
      Result := SetStatus(STS_ERROR, 'GEN0001', 'NF/Fatura ' + NR_NF + '.FIS_NF/' + NR_FATURA + '.FIS_NF possui data de movimento anterior ao encerramento do livro fiscal!', cDS_METHOD);
      return(-1); exit;
    end;
  end;

  delitem(pParams, 'CD_EMPRESA');
  delitem(pParams, 'NR_FATURA');
  delitem(pParams, 'DT_FATURA');

  getlistitensocc_e(pParams, tFIS_NFREMDES);
  putitem_e(tFIS_NFREMDES, 'CD_EMPFAT', item_f('CD_EMPFAT', tFIS_NF));
  putitem_e(tFIS_NFREMDES, 'CD_GRUPOEMPRESA', item_f('CD_GRUPOEMPRESA', tFIS_NF));
  if (item_a('NM_NOME', tFIS_NFREMDES) = '') then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Nome da pessoa não informado!', cDS_METHOD);
    return(-1); exit;
  end;

  voParams := tFIS_NFREMDES.Salvar();
  if (xStatus < 0) then begin
    Result := voParams;
    return(-1); exit;
  end;

  return(0); exit;
end;

//---------------------------------------------------------------------
function T_FISSVCO004.gravaTransportadoraNF(pParams : String) : String;
//---------------------------------------------------------------------
const
  cDS_METHOD = 'ADICIONAL=Operação: T_FISSVCO004.gravaTransportadoraNF()';
var
  vCdEmpresa, vNrFatura, vCdProduto,vNritem : Real;
  vDtFatura : TDate;
begin
  PARAM_GLB := PARAM_GLB;

  vCdEmpresa := itemXmlF('CD_EMPRESA', pParams);
  vNrFatura := itemXmlF('NR_FATURA', pParams);
  vDtFatura := itemXml('DT_FATURA', pParams);

  if (vCdEmpresa = 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Empresa não informada!', cDS_METHOD);
    return(-1); exit;
  end;
  if (vNrFatura = 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Fatura não informado!', cDS_METHOD);
    return(-1); exit;
  end;
  if (vDtFatura = '') then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Data NF não informada!', cDS_METHOD);
    return(-1); exit;
  end;

  getParams(pParams); (* vCdEmpresa *)
  if (xStatus < 0) then begin
    return(-1); exit;
  end;

  clear_e(tFIS_NF);
  putitem_e(tFIS_NF, 'CD_EMPRESA', vCdEmpresa);
  putitem_e(tFIS_NF, 'NR_FATURA', vNrFatura);
  putitem_e(tFIS_NF, 'DT_FATURA', vDtFatura);
  retrieve_e(tFIS_NF);
  if (xStatus < 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Nota Fiscal não encotrada!', cDS_METHOD);
    return(-1); exit;
  end;
  if (gDtEncerramento <> '') then begin
    if (item_a('DT_SAIDAENTRADA', tFIS_NF) <= gDtEncerramento) then begin
      Result := SetStatus(STS_ERROR, 'GEN0001', 'NF/Fatura ' + NR_NF + '.FIS_NF/' + NR_FATURA + '.FIS_NF possui data de movimento anterior ao encerramento do livro fiscal!', cDS_METHOD);
      return(-1); exit;
    end;
  end;

  delitem(pParams, 'CD_EMPRESA');
  delitem(pParams, 'NR_FATURA');
  delitem(pParams, 'DT_FATURA');

  getlistitensocc_e(pParams, tFIS_NFTRANSP);
  putitem_e(tFIS_NFTRANSP, 'CD_EMPFAT', item_f('CD_EMPFAT', tFIS_NF));
  putitem_e(tFIS_NFTRANSP, 'CD_GRUPOEMPRESA', item_f('CD_GRUPOEMPRESA', tFIS_NF));

  if (item_f('CD_TRANSPORT', tFIS_NFTRANSP) = 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Transportadora não informada!', cDS_METHOD);
    return(-1); exit;
  end;
  if (item_f('TP_FRETE', tFIS_NFTRANSP) = '') then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Tipo de frete não informado!', cDS_METHOD);
    return(-1); exit;
  end;

  voParams := tFIS_NFTRANSP.Salvar();
  if (xStatus < 0) then begin
    Result := voParams;
    return(-1); exit;
  end;

  return(0); exit;
end;

//------------------------------------------------------------------
function T_FISSVCO004.gravaItemImpostoNF(pParams : String) : String;
//------------------------------------------------------------------
const
  cDS_METHOD = 'ADICIONAL=Operação: T_FISSVCO004.gravaItemImpostoNF()';
var
  vDsLstImposto, vDsRegistro, vDsImposto : String;
  vCdEmpresa, vNrFatura, vCdImposto,vNritem : Real;
  vDtFatura : TDate;
  vInNaoExcluir : Boolean;
begin
  PARAM_GLB := PARAM_GLB;

  vDsLstImposto := itemXml('DS_LSTIMPOSTO', pParams);
  vCdEmpresa := itemXmlF('CD_EMPRESA', pParams);
  vNrFatura := itemXmlF('NR_FATURA', pParams);
  vDtFatura := itemXml('DT_FATURA', pParams);
  vCdImposto := itemXmlF('CD_IMPOSTO', pParams);
  vNrItem := itemXmlF('NR_ITEM', pParams);
  vInNaoExcluir := itemXmlB('IN_NAOEXCLUIR', pParams);

  if (vCdEmpresa = 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Empresa não informada!', cDS_METHOD);
    return(-1); exit;
  end;
  if (vNrFatura = 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Fatura não informado!', cDS_METHOD);
    return(-1); exit;
  end;
  if (vDtFatura = '') then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Data NF não informada!', cDS_METHOD);
    return(-1); exit;
  end;
  if (vNrItem = 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Número do item não informado!', cDS_METHOD);
    return(-1); exit;
  end;

  getParams(pParams); (* vCdEmpresa *)
  if (xStatus < 0) then begin
    return(-1); exit;
  end;

  clear_e(tFIS_NF);
  putitem_e(tFIS_NF, 'CD_EMPRESA', vCdEmpresa);
  putitem_e(tFIS_NF, 'NR_FATURA', vNrFatura);
  putitem_e(tFIS_NF, 'DT_FATURA', vDtFatura);
  retrieve_e(tFIS_NF);
  if (xStatus < 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Nota Fiscal não encotrada!', cDS_METHOD);
    return(-1); exit;
  end;
  if (gDtEncerramento <> '') then begin
    if (item_a('DT_SAIDAENTRADA', tFIS_NF) <= gDtEncerramento) then begin
      Result := SetStatus(STS_ERROR, 'GEN0001', 'NF/Fatura ' + NR_NF + '.FIS_NF/' + NR_FATURA + '.FIS_NF possui data de movimento anterior ao encerramento do livro fiscal!', cDS_METHOD);
      return(-1); exit;
    end;
  end;

  clear_e(tFIS_NFITEM);
  putitem_e(tFIS_NFITEM, 'NR_ITEM', vNrItem);
  retrieve_e(tFIS_NFITEM);
  if (xStatus < 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Itens da Nota Fiscal não encotrada!', cDS_METHOD);
    return(-1); exit;
  end;
  if (empty(tFIS_NFITEMIMP) = False) then begin
    if (vInNaoExcluir = True) then begin
      vDsImposto := vDsLstImposto;
      if (vDsImposto <> '') then begin
        repeat
          getitem(vDsRegistro, vDsImposto, 1);
          clear_e(tFIS_NFITEMIMP);
          putitem_e(tFIS_NFITEMIMP, 'CD_IMPOSTO', itemXmlF('CD_IMPOSTO', vDsRegistro));
          retrieve_e(tFIS_NFITEMIMP);
          if (xStatus >= 0) then begin
            voParams := tFIS_NFITEMIMP.Excluir();
            if (xStatus < 0) then begin
              Result := voParams;
              return(-1); exit;
            end;
          end;

          delitem(vDsImposto, 1);
        until (vDsImposto = '');
      end;

    end else begin
      voParams := tFIS_NFITEMIMP.Excluir();
      if (xStatus < 0) then begin
        Result := voParams;
        return(-1); exit;
      end;
    end;
  end;
  if (vDsLstImposto <> '') then begin
    repeat
      getitem(vDsRegistro, vDsLstImposto, 1);
      vCdImposto := itemXmlF('CD_IMPOSTO', vDsRegistro);

      if (vCdImposto = '') then begin
        Result := SetStatus(STS_ERROR, 'GEN0001', 'Imposto não informado!', cDS_METHOD);
        return(-1); exit;
      end;

      creocc(tFIS_NFITEMIMP, -1);

      getlistitensocc_e(vDsRegistro, tFIS_NFITEMIMP);
      putitem_e(tFIS_NFITEMIMP, 'CD_EMPFAT', item_f('CD_EMPFAT', tFIS_NFITEM));
      putitem_e(tFIS_NFITEMIMP, 'CD_GRUPOEMPRESA', item_f('CD_GRUPOEMPRESA', tFIS_NFITEM));
      putitem_e(tFIS_NFITEMIMP, 'CD_OPERADOR', itemXmlF('CD_USUARIO', PARAM_GLB));
      putitem_e(tFIS_NFITEMIMP, 'DT_CADASTRO', Now);

      delitem(vDsLstImposto, 1);
    until (vDsLstImposto = '');
  end;

  voParams := tFIS_NFITEMIMP.Salvar();
  if (xStatus < 0) then begin
    Result := voParams;
    return(-1); exit;
  end;
  if (xStatus < 0) then begin
    Result := voParams;
    return(-1); exit;
  end;

  voParams := tFIS_NF.Salvar();
  if (xStatus < 0) then begin
    Result := voParams;
    return(-1); exit;
  end;

  return(0); exit;
end;

//--------------------------------------------------------------
function T_FISSVCO004.gravaImpostoNF(pParams : String) : String;
//--------------------------------------------------------------
const
  cDS_METHOD = 'ADICIONAL=Operação: T_FISSVCO004.gravaImpostoNF()';
var
  vDsLstImposto,vDsRegistro : String;
  vCdEmpresa, vNrFatura, vCdImposto,vNritem : Real;
  vDtFatura : TDate;
begin
  PARAM_GLB := PARAM_GLB;

  vDsLstImposto := itemXml('DS_LSTIMPOSTO', pParams);
  vCdEmpresa := itemXmlF('CD_EMPRESA', pParams);
  vNrFatura := itemXmlF('NR_FATURA', pParams);
  vDtFatura := itemXml('DT_FATURA', pParams);

  if (vCdEmpresa = 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Empresa não informada!', cDS_METHOD);
    return(-1); exit;
  end;
  if (vNrFatura = 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Fatura não informado!', cDS_METHOD);
    return(-1); exit;
  end;
  if (vDtFatura = '') then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Data NF não informada!', cDS_METHOD);
    return(-1); exit;
  end;

  getParams(pParams); (* vCdEmpresa *)
  if (xStatus < 0) then begin
    return(-1); exit;
  end;

  clear_e(tFIS_NF);
  putitem_e(tFIS_NF, 'CD_EMPRESA', vCdEmpresa);
  putitem_e(tFIS_NF, 'NR_FATURA', vNrFatura);
  putitem_e(tFIS_NF, 'DT_FATURA', vDtFatura);
  retrieve_e(tFIS_NF);
  if (xStatus < 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Nota Fiscal não encotrada!', cDS_METHOD);
    return(-1); exit;
  end;
  if (gDtEncerramento <> '') then begin
    if (item_a('DT_SAIDAENTRADA', tFIS_NF) <= gDtEncerramento) then begin
      Result := SetStatus(STS_ERROR, 'GEN0001', 'NF/Fatura ' + NR_NF + '.FIS_NF/' + NR_FATURA + '.FIS_NF possui data de movimento anterior ao encerramento do livro fiscal!', cDS_METHOD);
      return(-1); exit;
    end;
  end;
  if (empty(tFIS_NFIMPOSTO) = False) then begin
    voParams := tFIS_NFIMPOSTO.Excluir();
    if (xStatus < 0) then begin
      Result := voParams;
      return(-1); exit;
    end;
  end;
  if (vDsLstImposto <> '') then begin
    repeat
      getitem(vDsRegistro, vDsLstImposto, 1);
      vCdImposto := itemXmlF('CD_IMPOSTO', vDsRegistro);

      if (vCdImposto = '') then begin
        Result := SetStatus(STS_ERROR, 'GEN0001', 'Imposto não informado!', cDS_METHOD);
        return(-1); exit;
      end;

      creocc(tFIS_NFIMPOSTO, -1);

      getlistitensocc_e(vDsRegistro, tFIS_NFIMPOSTO);
      putitem_e(tFIS_NFIMPOSTO, 'CD_EMPFAT', item_f('CD_EMPFAT', tFIS_NFITEM));
      putitem_e(tFIS_NFIMPOSTO, 'CD_GRUPOEMPRESA', item_f('CD_GRUPOEMPRESA', tFIS_NFITEM));
      putitem_e(tFIS_NFIMPOSTO, 'CD_OPERADOR', itemXmlF('CD_USUARIO', PARAM_GLB));
      putitem_e(tFIS_NFIMPOSTO, 'DT_CADASTRO', Now);

      delitem(vDsLstImposto, 1);
    until (vDsLstImposto = '');
  end;

  voParams := tFIS_NFIMPOSTO.Salvar();
  if (xStatus < 0) then begin
    Result := voParams;
    return(-1); exit;
  end;
  if (xStatus < 0) then begin
    Result := voParams;
    return(-1); exit;
  end;

  voParams := tFIS_NF.Salvar();
  if (xStatus < 0) then begin
    Result := voParams;
    return(-1); exit;
  end;

  return(0); exit;
end;

//----------------------------------------------------------------
function T_FISSVCO004.alteraVendedorNF(pParams : String) : String;
//----------------------------------------------------------------
const
  cDS_METHOD = 'ADICIONAL=Operação: T_FISSVCO004.alteraVendedorNF()';
var
  viParams, voParams, vDsRegistro, vDsLstNF : String;
  vCdEmpresa, vNrFatura, vCdVendedor, vCdEmpTransacao, vNrTransacao : Real;
  vDtFatura, vDtTransacao : TDate;
begin
  PARAM_GLB := PARAM_GLB;

  vDsLstNF := itemXml('DS_LSTNF', pParams);
  vCdEmpTransacao := itemXmlF('CD_EMPTRANSACAO', pParams);
  vNrTransacao := itemXmlF('NR_TRANSACAO', pParams);
  vDtTransacao := itemXml('DT_TRANSACAO', pParams);

  vCdVendedor := itemXmlF('CD_COMPVend', pParams);

  if (vDsLstNF = '') then begin
    if (vCdEmpTransacao = 0) then begin
      Result := SetStatus(STS_ERROR, 'GEN0001', 'Empresa não informada!', cDS_METHOD);
      return(-1); exit;
    end;
    if (vNrTransacao = 0) then begin
      Result := SetStatus(STS_ERROR, 'GEN0001', 'Número da transação não informado!', cDS_METHOD);
      return(-1); exit;
    end;
    if (vDtTransacao = '') then begin
      Result := SetStatus(STS_ERROR, 'GEN0001', 'Data transação não informada!', cDS_METHOD);
      return(-1); exit;
    end;
  end;
  if (vCdVendedor = '') then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Vendedor não informado!', cDS_METHOD);
    return(-1); exit;
  end;

  clear_e(tFIS_NF);

  if (vDsLstNF = '') then begin
    putitem_e(tFIS_NF, 'CD_EMPRESAORI', vCdEmpTransacao);
    putitem_e(tFIS_NF, 'NR_TRANSACAOORI', vNrTransacao);
    putitem_e(tFIS_NF, 'DT_TRANSACAOORI', vDtTransacao);
    retrieve_e(tFIS_NF);
    if (xStatus < 0) then begin
      clear_e(tFIS_NF);
      return(0); exit;
    end;
  end else begin
    repeat
      getitem(vDsRegistro, vDsLstNF, 1);
      vCdEmpresa := itemXmlF('CD_EMPRESA', vDsRegistro);
      vNrFatura := itemXmlF('NR_FATURA', vDsRegistro);
      vDtFatura := itemXml('DT_FATURA', vDsRegistro);
      if (vCdEmpresa = 0) then begin
        Result := SetStatus(STS_ERROR, 'GEN0001', 'Empresa não informada!', cDS_METHOD);
        return(-1); exit;
      end;
      if (vNrFatura = 0) then begin
        Result := SetStatus(STS_ERROR, 'GEN0001', 'Fatura não informado!', cDS_METHOD);
        return(-1); exit;
      end;
      if (vDtFatura = '') then begin
        Result := SetStatus(STS_ERROR, 'GEN0001', 'Data NF não informada!', cDS_METHOD);
        return(-1); exit;
      end;
      creocc(tFIS_NF, -1);
      putitem_e(tFIS_NF, 'CD_EMPRESA', vCdEmpresa);
      putitem_e(tFIS_NF, 'NR_FATURA', vNrFatura);
      putitem_e(tFIS_NF, 'DT_FATURA', vDtFatura);
      retrieve_o(tFIS_NF);
      if (xStatus = -7) then begin
        retrieve_x(tFIS_NF);
      end else if (xStatus = 0) then begin
        Result := SetStatus(STS_ERROR, 'GEN0001', 'NF ' + FloatToStr(vNrFatura) + ' não cadastrada!', cDS_METHOD);
        return(-1); exit;
      end;

      delitem(vDsLstNF, 1);
    until (vDsLstNF = '');
  end;
  if (empty(tFIS_NF) = False) then begin
    setocc(tFIS_NF, 1);
    while(xStatus >=0) do begin
      putitem_e(tFIS_NF, 'CD_COMPVEND', vCdVendedor);
      putitem_e(tFIS_NF, 'CD_OPERADOR', itemXmlF('CD_USUARIO', PARAM_GLB));
      putitem_e(tFIS_NF, 'DT_CADASTRO', Now);

      if (empty(tFIS_NFITEM) = False) then begin
        setocc(tFIS_NFITEM, 1);
        while(xStatus >=0) do begin
          if (empty(tFIS_NFITEMPRO) = False) then begin
            setocc(tFIS_NFITEMPRO, 1);
            while(xStatus >=0) do begin
              putitem_e(tFIS_NFITEMPRO, 'CD_COMPVEND', vCdVendedor);
              putitem_e(tFIS_NFITEMPRO, 'CD_OPERADOR', itemXmlF('CD_USUARIO', PARAM_GLB));
              putitem_e(tFIS_NFITEMPRO, 'DT_CADASTRO', Now);
              setocc(tFIS_NFITEMPRO, curocc(tFIS_NFITEMPRO) + 1);
            end;
          end;
          setocc(tFIS_NFITEM, curocc(tFIS_NFITEM) + 1);
        end;
      end;

      setocc(tFIS_NF, curocc(tFIS_NF) + 1);
    end;

    voParams := tFIS_NF.Salvar();
    if (xStatus < 0) then begin
      Result := voParams;
      return(-1); exit;
    end;
  end;

  return(0); exit;
end;

//-------------------------------------------------------------------------
function T_FISSVCO004.consignadoDevolverFaturar(pParams : String) : String;
//-------------------------------------------------------------------------
const
  cDS_METHOD = 'ADICIONAL=Operação: T_FISSVCO004.consignadoDevolverFaturar()';
var
  vDsLstItem, vTpConsignado, vDsItem : String;
  vQtConsignado, vQtSaldo : Real;
  vCdEmpresa, vNrFatura, vNrItem, vCdProduto : Real;
  vDtFatura : TDate;
begin
  PARAM_GLB := PARAM_GLB;

  vDsLstItem := itemXml('DS_CONSIGNADO', pParams);
  vTpConsignado := itemXmlF('TP_CONSIGNADO', pParams);

  if (vDsLstItem = '') then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Lista de item consignado não informado!', cDS_METHOD);
    return(-1); exit;
  end;
  if (vTpConsignado = '') then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Lista de item consignado não informado!', cDS_METHOD);
    return(-1); exit;
  end;

  repeat
    getitem(vDsItem, vDsLstItem, 1);
    vCdEmpresa := itemXmlF('CD_EMPRESA', vDsItem);
    vNrFatura := itemXmlF('NR_FATURA', vDsItem);
    vDtFatura := itemXml('DT_FATURA', vDsItem);
    vNrItem := itemXmlF('NR_ITEM', vDsItem);
    vCdProduto := itemXmlF('CD_PRODUTO', vDsItem);

    clear_e(tFIS_NF);
    putitem_e(tFIS_NF, 'CD_EMPRESA', vCdEmpresa);
    putitem_e(tFIS_NF, 'NR_FATURA', vNrFatura);
    putitem_e(tFIS_NF, 'DT_FATURA', vDtFatura);
    retrieve_e(tFIS_NF);
    if (xStatus >= 0) then begin
      clear_e(tFIS_NFITEM);
      putitem_e(tFIS_NFITEM, 'NR_ITEM', vNrItem);
      retrieve_e(tFIS_NFITEM);
      if (xStatus >= 0) then begin
        clear_e(tFIS_NFITEMPRO);
        putitem_e(tFIS_NFITEMPRO, 'CD_PRODUTO', vCdProduto);
        retrieve_e(tFIS_NFITEMPRO);
        if (xStatus >= 0) then begin
          vQtSaldo := item_f('QT_FATURADO', tFIS_NFITEMPRO);

          if (empty(tFIS_NFITEMCON) = False) then begin
            if (vTpConsignado = 'DEVOLVER') then begin
              vQtConsignado := itemXmlF('QT_DEVOLVIDA', vDsItem);
              putitem_e(tFIS_NFITEMCON, 'QT_DEVOLVIDA', item_f('QT_DEVOLVIDA', tFIS_NFITEMCON) + vQtConsignado);
            end;
            if (vTpConsignado = 'FATURAR') then begin
              vQtConsignado := itemXmlF('QT_VendIDA', vDsItem);
              putitem_e(tFIS_NFITEMCON, 'QT_VENDIDA', item_f('QT_VENDIDA', tFIS_NFITEMCON) + vQtConsignado);
            end;

            vQtSaldo := vQtSaldo - item_f('QT_DEVOLVIDA', tFIS_NFITEMCON) - item_f('QT_VENDIDA', tFIS_NFITEMCON);

            if (vQtSaldo <= 0) then begin
              putitem_e(tFIS_NFITEMCON, 'TP_SITUACAO', 2);
            end;

            voParams := tFIS_NFITEMCON.Salvar();
            if (xStatus < 0) then begin
              Result := voParams;
              return(-1); exit;
            end;
          end;
        end;
      end;
    end;

    delitem(vDsLstItem, 1);
  until (vDsLstItem = '');

  return(0); exit;
end;

//----------------------------------------------------------
function T_FISSVCO004.gravaLogNF(pParams : String) : String;
//----------------------------------------------------------
const
  cDS_METHOD = 'ADICIONAL=Operação: T_FISSVCO004.gravaLogNF()';
var
  viParams, voParams : String;
begin
  PARAM_GLB := PARAM_GLB;

  viParams := pParams;
  voParams := activateCmp('FISSVCO024', 'gravaLogNF', viParams); (*,,,, *)
  if (xStatus < 0) then begin
    Result := voParams;
    return(-1); exit;
  end;

  return(0); exit;
end;

//------------------------------------------------------------------
function T_FISSVCO004.consignadoCancelar(pParams : String) : String;
//------------------------------------------------------------------
const
  cDS_METHOD = 'ADICIONAL=Operação: T_FISSVCO004.consignadoCancelar()';
var
  vDsLstItem, vTpConsignado, vDsItem : String;
  vQtConsignado, vQtSaldo : Real;
  vCdEmpresa, vNrFatura, vNrItem, vCdProduto : Real;
  vDtFatura : TDate;
begin
  PARAM_GLB := PARAM_GLB;

  vDsLstItem := itemXml('DS_CONSIGNADO', pParams);
  vTpConsignado := itemXmlF('TP_CONSIGNADO', pParams);

  if (vDsLstItem = '') then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Lista de item consignado não informado!', cDS_METHOD);
    return(-1); exit;
  end;
  if (vTpConsignado = '') then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Lista de item consignado não informado!', cDS_METHOD);
    return(-1); exit;
  end;

  repeat
    getitem(vDsItem, vDsLstItem, 1);
    vCdEmpresa := itemXmlF('CD_EMPRESA', vDsItem);
    vNrFatura := itemXmlF('NR_FATURA', vDsItem);
    vDtFatura := itemXml('DT_FATURA', vDsItem);
    vNrItem := itemXmlF('NR_ITEM', vDsItem);
    vCdProduto := itemXmlF('CD_PRODUTO', vDsItem);

    clear_e(tFIS_NF);
    putitem_e(tFIS_NF, 'CD_EMPRESA', vCdEmpresa);
    putitem_e(tFIS_NF, 'NR_FATURA', vNrFatura);
    putitem_e(tFIS_NF, 'DT_FATURA', vDtFatura);
    retrieve_e(tFIS_NF);
    if (xStatus >= 0) then begin
      clear_e(tFIS_NFITEM);
      putitem_e(tFIS_NFITEM, 'NR_ITEM', vNrItem);
      retrieve_e(tFIS_NFITEM);
      if (xStatus >= 0) then begin
        clear_e(tFIS_NFITEMPRO);
        putitem_e(tFIS_NFITEMPRO, 'CD_PRODUTO', vCdProduto);
        retrieve_e(tFIS_NFITEMPRO);
        if (xStatus >= 0) then begin
          vQtSaldo := item_f('QT_FATURADO', tFIS_NFITEMPRO);

          if (empty(tFIS_NFITEMCON) = False) then begin
            if (vTpConsignado = 'DEVOLVER') then begin
              vQtConsignado := itemXmlF('QT_DEVOLVIDA', vDsItem);
              putitem_e(tFIS_NFITEMCON, 'QT_DEVOLVIDA', item_f('QT_DEVOLVIDA', tFIS_NFITEMCON) - vQtConsignado);
            end;
            if (vTpConsignado = 'FATURAR') then begin
              vQtConsignado := itemXmlF('QT_VendIDA', vDsItem);
              putitem_e(tFIS_NFITEMCON, 'QT_VENDIDA', item_f('QT_VENDIDA', tFIS_NFITEMCON) - vQtConsignado);
            end;

            vQtSaldo := vQtSaldo - item_f('QT_DEVOLVIDA', tFIS_NFITEMCON) - item_f('QT_VENDIDA', tFIS_NFITEMCON);

            if (vQtSaldo > 0) then begin
              putitem_e(tFIS_NFITEMCON, 'TP_SITUACAO', 1);
            end;

            voParams := tFIS_NFITEMCON.Salvar();
            if (xStatus < 0) then begin
              Result := voParams;
              return(-1); exit;
            end;
          end;
        end;
      end;
    end;

    delitem(vDsLstItem, 1);
  until (vDsLstItem = '');

  return(0); exit;
end;

//-----------------------------------------------------------
function T_FISSVCO004.removeECFNF(pParams : String) : String;
//-----------------------------------------------------------
const
  cDS_METHOD = 'ADICIONAL=Operação: T_FISSVCO004.removeECFNF()';
var
  vCdEmpresa, vNrFatura : Real;
  vDtFatura : TDate;
begin
  vCdEmpresa := itemXmlF('CD_EMPRESA', pParams);
  vNrFatura := itemXmlF('NR_FATURA', pParams);
  vDtFatura := itemXml('DT_FATURA', pParams);

  if (vCdEmpresa = '') then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Empresa não informada!', cDS_METHOD);
    return(-1); exit;
  end;
  if (vNrFatura = '') then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Número da fatura não informada!', cDS_METHOD);
    return(-1); exit;
  end;
  if (vDtFatura = '') then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Data da fatura não informada!', cDS_METHOD);
    return(-1); exit;
  end;

  clear_e(tFIS_NF);
  putitem_e(tFIS_NF, 'CD_EMPRESA', vCdEmpresa);
  putitem_e(tFIS_NF, 'NR_FATURA', vNrFatura);
  putitem_e(tFIS_NF, 'DT_FATURA', vDtFatura);
  retrieve_e(tFIS_NF);
  if (xStatus < 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Registro não cadastrado!', cDS_METHOD);
    return(-1); exit;
  end;

  clear_e(tFIS_NFECF);
  retrieve_e(tFIS_NFECF);
  if (xStatus >= 0) then begin
    voParams := tFIS_NFECF.Excluir();
    if (xStatus < 0) then begin
      Result := voParams;
      return(-1); exit;
    end;
  end;

  return(0); exit;
end;

end.
