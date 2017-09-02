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
    tFIS_NFISELOENT,
    tFIS_NFITEM,
    tFIS_NFITEMCONT,
    tFIS_NFITEMDESP,
    tFIS_NFITEMIMPOST,
    tFIS_NFITEMPLOTE,
    tFIS_NFITEMPPRDFIN,
    tFIS_NFITEMPROD,
    tFIS_NFITEMSERIAL,
    tFIS_NFITEMUN,
    tFIS_NFITEMVL,
    tFIS_NFITEMADIC,
    tFIS_NFREF,
    tFIS_NFREMDES,
    tFIS_NFSELOENT,
    tFIS_NFTRANSP,
    tFIS_NFVENCTO,
    tFIS_S_NF,
    tGER_MODNFC,
    tGER_OPERACAO,
    tGER_S_OPERACAO,
    tGER_SERIE,
    tOBS_NF,
    tOBS_TRANSACNF,
    tPRD_CLASSIFICACAO,
    tPRD_PRODUTOCLAS,
    tPRD_TIPOCLAS,
    tTMP_CSTALIQ,
    tTMP_K02,
    tTMP_NR08,
    tTMP_NR09,
    tTRA_ITEMIMPOSTO,
    tTRA_ITEMLOTE,
    tTRA_ITEMPRDFIN,
    tTRA_ITEMSELOENT,
    tTRA_ITEMSERIAL,
    tTRA_ITEMUN,
    tTRA_ITEMVL,
    tTRA_REMDES,
    tTRA_SELOENT,
    tTRA_TRANREF,
    tTRA_TRANSACAO,
    tTRA_TRANSACECF,
    tTRA_TRANSITEM,
    tTRA_TRANSPORT,
    tTRA_VENCIMENTO,
    tV_FIS_NFREMDES : TcDatasetUnf;
    function getParam(pParams : String = '') : String; override;
    function setEntidade(pParams : String = '') : String; override;
  protected
  public
  published
    function alteraImpressaoNF(pParams : String = '') : String;
    function alteraSituacaoNF(pParams : String = '') : String;
    function alteraVendedorNF(pParams : String = '') : String;
    function alteraVlIpi(pParams : String = '') : String;
    function calculaTotalNF(pParams : String = '') : String;
    function consignadoCancelar(pParams : String = '') : String;
    function consignadoDevolverFaturar(pParams : String = '') : String;
    function emiteNF(pParams : String = '') : String;
    function geraCapaNF(pParams : String = '') : String;
    function geraECF(pParams : String = '') : String;
    function geraImpostoItem(pParams : String = '') : String;
    function geraItemNF(pParams : String = '') : String;
    function geraItemSeloEnt(pParams : String = '') : String;
    function geraNF(pParams : String = '') : String;
    function geraNFReferencial(pParams : String = '') : String;
    function geraObservacao(pParams : String = '') : String;
    function geraParcela(pParams : String = '') : String;
    function geraRemDest(pParams : String = '') : String;
    function geraSeloFiscalEnt(pParams : String = '') : String;
    function geraTransport(pParams : String = '') : String;
    function gravaCapaNF(pParams : String = '') : String;
    function gravaECFNF(pParams : String = '') : String;
    function gravaImpostoNF(pParams : String = '') : String;
    function gravaItemImpostoNF(pParams : String = '') : String;
    function gravaItemNF(pParams : String = '') : String;
    function gravaItemProdNF(pParams : String = '') : String;
    function gravaLogNF(pParams : String = '') : String;
    function gravaObsNF(pParams : String = '') : String;
    function gravaTransportadoraNF(pParams : String = '') : String;
    function gravaenderecoNF(pParams : String = '') : String;
    function limpaString(pParams : String = '') : String;
    function rateiaValorCapa(pParams : String = '') : String;
    function removeECFNF(pParams : String = '') : String;
  end;

implementation

uses
  cActivate, cStatus, cFuncao, cXml, dModulo;

var
  gCdCusto1Venda,
  gCdCusto2Venda,
  gCdCusto3Venda,
  gCdCustoMedioSemImp,
  gCdCustoSemImp,
  gCdEmpresaValorEmp,
  gCdEmpresaValorSis,
  gCdModeloNF,
  gCdMotivoAltValor,
  gCdOperEntEstTrans,
  gCdOperEntInspecao,
  gCdSaldoCalcVlrMedio,
  gCdSaldoEstDeTerc,
  gCdSaldoEstTerceiro,
  gCdSaldoPadrao,
  gCdSerie : Real;

  gCdEspecieServico,
  gCdTipoClas,
  gUfDestino,
  gUfOrigem,
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
  gLstLoteInfGeral,
  gPrAplicMvaSubTrib,
  gTpAgrupamento : String;

  gHrFim,
  gHrInicio,
  gHrSaida,
  gHrTempo,
  gDtEmissao,
  gDtEncerramento,
  gDtEntrega,
  gDtFatura,
  gDtSaidaEntrada : TDateTime;

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
  gInCalcTributo : Boolean;

  gNrCodFiscal,
  gNrFatura,
  gNrItemQuebraNf,
  gNrNf,
  gTinTinturaria,
  gTpAgrupamentoItemNF,
  gTpCodigoItem,
  gTpEstoqueTerceiro,
  gTpImpObsRegraFiscalNf,
  gTpImpressaoCodPrdEcf,
  gTpLancamentoFrete,
  gTpModDctoFiscal,
  gTpModDctoFiscallocal,
  gTpRegimeTrib,
  gVlBaseCalc,
  gVlICMSDiferido,
  gVlImposto,
  gPrTotalTributo : Real;

//---------------------------------------------------------------
function T_FISSVCO004.getParam(pParams : String = '') : String;
//---------------------------------------------------------------
var
  vTpQuebraCFOP, vInOptSimples : String;
  piCdEmpresa, vTpDctoFiscal : Real;
begin
  piCdEmpresa := itemXmlF('CD_EMPRESA', pParams);
  if (piCdEmpresa = 0) then begin
    piCdEmpresa := itemXmlF('CD_EMPRESA', PARAM_GLB);
  end;

  xParam := '';
  putitem(xParam, 'CD_EMPVALOR');
  putitem(xParam, 'CD_MOTIVO_ALTVALOR_CMP');
  xParam := activateCmp('ADMSVCO001', 'GetParametro', xParam);

  gCdEmpresaValorSis := itemXmlF('CD_EMPVALOR', xParam);
  gCdMotivoAltValor := itemXmlF('CD_MOTIVO_ALTVALOR_CMP', xParam);

  xParamEmp := '';
  putitem(xParamEmp, 'CD_EMPRESA_VALOR');
  putitem(xParamEmp, 'CD_SALDOPADRAO');
  putitem(xParamEmp, 'CD_SALDO_CALC_VLR_MEDIO');
  putitem(xParamEmp, 'TP_QUEBRA_NF_CFOP');
  putitem(xParamEmp, 'CD_TIPOCLAS_ITEM_NF');
  putitem(xParamEmp, 'IN_OPT_SIMPLES');
  putitem(xParamEmp, 'IN_PDV_OTIMIZADO');
  putitem(xParamEmp, 'CD_CUSTO_S_IMPOSTO');
  putitem(xParamEmp, 'CD_CUSTO_MEDIO_S_IMPOSTO');
  putitem(xParamEmp, 'DT_ENCERRAMENTO_FIS');
  putitem(xParamEmp, 'CD_CUSTO1VENDA_REL_CONFIG');
  putitem(xParamEmp, 'CD_CUSTO2VENDA_REL_CONFIG');
  putitem(xParamEmp, 'CD_CUSTO3VENDA_REL_CONFIG');
  putitem(xParamEmp, 'CD_OPER_ENT_EST_TRANS');
  putitem(xParamEmp, 'IN_SOMA_FRETE_TOTALNF');
  putitem(xParamEmp, 'TP_MOD_DCTO_FISCAL');
  putitem(xParamEmp, 'IN_EXIBE_RESUMO_CST_NF');
  putitem(xParamEmp, 'IN_BAIXA_PED_POOL_EMP');
  putitem(xParamEmp, 'DS_LST_NIVEL_GRUPO_NF');
  putitem(xParamEmp, 'DS_LST_NIVEL_DES_GRUPO_NF');
  putitem(xParamEmp, 'IN_EXIBE_RESUMO_CFOP_NF');
  putitem(xParamEmp, 'TP_CONTR_EST_EM_TERCEIRO');
  putitem(xParamEmp, 'IN_LOG_TEMPO_VENDA');
  putitem(xParamEmp, 'CD_OPER_ENT_INSPECAO');
  putitem(xParamEmp, 'DS_LST_OPER_EST_TERCEIRO');
  putitem(xParamEmp, 'DS_CUSTO_SUBST_TRIBUTARIA');
  putitem(xParamEmp, 'DS_CUSTO_VALOR_RETIDO');
  putitem(xParamEmp, 'TP_AGRUPAMENTO_ITEM_NF');
  putitem(xParamEmp, 'CD_SALDO_EST_TERCEIRO');
  putitem(xParamEmp, 'CD_SALDO_EST_DE_TERC');
  putitem(xParamEmp, 'DS_LST_OPER_EST_DE_TERC');
  putitem(xParamEmp, 'IN_GRAVA_DS_DECRETO_OBSNF');
  putitem(xParamEmp, 'UF_ORIGEM');
  putitem(xParamEmp, 'PR_APLIC_MVA_SUB_TRIB');
  putitem(xParamEmp, 'DS_EMB_LEGAL_SUB_TRIB');
  putitem(xParamEmp, 'IN_EXIBE_QTD_PROD_NF');
  putitem(xParamEmp, 'TP_IMPRESSAO_COD_PRD_ECF');
  putitem(xParamEmp, 'NR_ITEM_QUEBRA_NF');
  putitem(xParamEmp, 'TP_LANCAMENTO_FRETE_TRA');
  putitem(xParamEmp, 'DS_LST_MODDCTOFISCAL_AT');
  putitem(xParamEmp, 'IN_ARREDONDA_TRUNCA_ICMS');
  putitem(xParamEmp, 'TP_IMP_OBS_REGRAFISCAL_NF');
  putitem(xParamEmp, 'IN_INCLUI_IPI_DEV_SIMP');
  putitem(xParamEmp, 'DS_OBS_NF');
  putitem(xParamEmp, 'IN_GRAVA_OBS_NF');
  putitem(xParamEmp, 'DS_LST_OPER_OBRIG_NF_REF');
  putitem(xParamEmp, 'PR_TOTAL_TRIBUTO');
  xParamEmp := activateCmp('ADMSVCO001', 'GetParamEmpresa', piCdEmpresa, xParamEmp);

  gNrItemQuebraNf := itemXmlF('NR_ITEM_QUEBRA_NF', xParamEmp);
  gCdEmpresaValorEmp := itemXmlF('CD_EMPRESA_VALOR', xParamEmp);
  gCdSaldoPadrao := itemXmlF('CD_SALDOPADRAO', xParamEmp);
  gCdSaldoCalcVlrMedio := itemXmlF('CD_SALDO_CALC_VLR_MEDIO', xParamEmp);

  vTpQuebraCFOP := itemXml('TP_QUEBRA_NF_CFOP', xParamEmp);
  if (vTpQuebraCFOP = 'S') then begin
    gInQuebraCFOP := True;
  end else begin
    gInQuebraCFOP := False;
  end;

  vInOptSimples := itemXml('IN_OPT_SIMPLES', xParamEmp);
  if (vInOptSimples = 'S') then begin
    gInOptSimples := True;
  end else begin
    gInOptSimples := False;
  end;

  gCdTipoClas := itemXml('CD_TIPOCLAS_ITEM_NF', xParamEmp);
  gInPDVOtimizado := itemXmlB('IN_PDV_OTIMIZADO', xParamEmp);
  gDtEncerramento := itemXmlDU('DT_ENCERRAMENTO_FIS', xParamEmp);
  gCdCustoSemImp := itemXmlF('CD_CUSTO_S_IMPOSTO', xParamEmp);
  gCdCustoMedioSemImp := itemXmlF('CD_CUSTO_MEDIO_S_IMPOSTO', xParamEmp);
  gCdCusto1Venda := itemXmlF('CD_CUSTO1VENDA_REL_CONFIG', xParamEmp);
  gCdCusto2Venda := itemXmlF('CD_CUSTO2VENDA_REL_CONFIG', xParamEmp);
  gCdCusto3Venda := itemXmlF('CD_CUSTO3VENDA_REL_CONFIG', xParamEmp);
  gCdOperEntEstTrans := itemXmlF('CD_OPER_ENT_EST_TRANS', xParamEmp);
  gInSomaFrete := itemXmlB('IN_SOMA_FRETE_TOTALNF', xParamEmp);
  gTpModDctoFiscal := itemXmlF('TP_MOD_DCTO_FISCAL', xParamEmp);
  gInExibeResumoCstNF := itemXmlB('IN_EXIBE_RESUMO_CST_NF', xParamEmp);
  gInBaixaPedPool := itemXmlB('IN_BAIXA_PED_POOL_EMP', xParamEmp);
  gDsLstNivelGrupo := itemXml('DS_LST_NIVEL_GRUPO_NF', xParamEmp);
  gDsLstNivelDescGrupo := itemXml('DS_LST_NIVEL_DES_GRUPO_NF', xParamEmp);
  gInExibeResumoCfopNF := itemXmlB('IN_EXIBE_RESUMO_CFOP_NF', xParamEmp);
  gTpEstoqueTerceiro := itemXmlF('TP_CONTR_EST_EM_TERCEIRO', xParamEmp);
  gInLog := itemXmlB('IN_LOG_TEMPO_VENDA', xParamEmp);
  gCdOperEntInspecao := itemXmlF('CD_OPER_ENT_INSPECAO', xParamEmp);
  gTpAgrupamentoItemNF := itemXmlF('TP_AGRUPAMENTO_ITEM_NF', xParamEmp);
  gDsLstOperEstTerceiro  := itemXml('DS_LST_OPER_EST_TERCEIRO', xParamEmp);
  gDsLstOperEstTerceiro := ReplaceStr(gDsLstOperEstTerceiro, #$17, '|');         // gold + paipe
  gDsCustoSubstTributaria := itemXml('DS_CUSTO_SUBST_TRIBUTARIA', xParamEmp);
  gDsCustoValorRetido := itemXml('DS_CUSTO_VALOR_RETIDO', xParamEmp);
  gCdSaldoEstTerceiro := itemXmlF('CD_SALDO_EST_TERCEIRO', xParamEmp);
  gCdSaldoEstDeTerc := itemXmlF('CD_SALDO_EST_DE_TERC', xParamEmp);
  gDsLstOperEstDeTerc := itemXml('DS_LST_OPER_EST_DE_TERC', xParamEmp);
  gDsLstOperEstDeTerc := ReplaceStr(gDsLstOperEstDeTerc, #$17, '|');             // gold + paipe
  gInGravaDsDecretoObsNf := itemXmlB('IN_GRAVA_DS_DECRETO_OBSNF', xParamEmp);
  gUfOrigem := itemXml('UF_ORIGEM', xParamEmp);
  gPrAplicMvaSubTrib := itemXml('PR_APLIC_MVA_SUB_TRIB', xParamEmp);
  gDsEmbLegalSubTrib := itemXml('DS_EMB_LEGAL_SUB_TRIB', xParamEmp);
  gInExibeQtdProdNF := itemXmlB('IN_EXIBE_QTD_PROD_NF', xParamEmp);
  gTpImpressaoCodPrdEcf := itemXmlF('TP_IMPRESSAO_COD_PRD_ECF', xParamEmp);
  gTpLancamentoFrete := itemXmlF('TP_LANCAMENTO_FRETE_TRA', xParamEmp);
  gInArredondaTruncaICMS := itemXmlB('IN_ARREDONDA_TRUNCA_ICMS', xParamEmp);
  gTpImpObsRegraFiscalNf := itemXmlF('TP_IMP_OBS_REGRAFISCAL_NF', xParamEmp);
  gInIncluiIpiDevSimp := itemXmlB('IN_INCLUI_IPI_DEV_SIMP', xParamEmp);
  gDsObsNf := itemXml('DS_OBS_NF', xParamEmp);
  gInGravaObsNf := itemXmlB('IN_GRAVA_OBS_NF', xParamEmp);
  gDsLstOperObrigNfRef := itemXml('DS_LST_OPER_OBRIG_NF_REF', xParamEmp);
  gPrTotalTributo := itemXmlF('PR_TOTAL_TRIBUTO', xParamEmp);

  gDsLstModDctoFiscal := itemXml('DS_LST_MODDCTOFISCAL_AT', xParamEmp);
  if (gDsLstModDctoFiscal <> '') then begin
    gDsLstModDctoFiscal := ReplaceStr(gDsLstModDctoFiscal, #$1B, ';');           // gold + ponto e virgula
    repeat
      getitem(vTpDctoFiscal, gDsLstModDctoFiscal, 1);
      if (vTpDctoFiscal > 0) then begin
        creocc(tF_TMP_NR08, -1);
        putitem_o(tF_TMP_NR08, 'NR_08', vTpDctoFiscal);
        retrieve_o(tF_TMP_NR08);
      end;
      delitemGld(gDsLstModDctoFiscal, 1);
    until (gDsLstModDctoFiscal = '');
  end;
end;

//---------------------------------------------------------------
function T_FISSVCO004.setEntidade(pParams : String = '') : String;
//---------------------------------------------------------------
begin
  tF_TMP_NR08 := GetEntidade('TMP_NR08', 'F_TMP_NR08');
  tF_TMP_NR09 := GetEntidade('TMP_NR09', 'F_TMP_NR09');
  tTMP_CSTALIQ := GetEntidade('TMP_CSTALIQ');
  tTMP_K02 := GetEntidade('TMP_K02');
  tTMP_NR08 := GetEntidade('TMP_NR08');
  tTMP_NR09 := GetEntidade('TMP_NR09');
  tFIS_DECRETO := GetEntidade('FIS_DECRETO');
  tFIS_ECF := GetEntidade('FIS_ECF');
  tFIS_NF := GetEntidade('FIS_NF');
  tFIS_NFECF := GetEntidade('FIS_NFECF');
  tFIS_NFIMPOSTO := GetEntidade('FIS_NFIMPOSTO');
  //tFIS_NFISELOENT := GetEntidade('FIS_NFISELOENT');
  tFIS_NFITEM := GetEntidade('FIS_NFITEM');
  //tFIS_NFITEMCONT := GetEntidade('FIS_NFITEMCONT');
  //tFIS_NFITEMDESP := GetEntidade('FIS_NFITEMDESP');
  tFIS_NFITEMIMPOST := GetEntidade('FIS_NFITEMIMPOST');
  //tFIS_NFITEMPLOTE := GetEntidade('FIS_NFITEMPLOTE');
 // tFIS_NFITEMPPRDFIN := GetEntidade('FIS_NFITEMPPR');
  tFIS_NFITEMPROD := GetEntidade('FIS_NFITEMPROD');
  //tFIS_NFITEMSERIAL := GetEntidade('FIS_NFITEMSERIAL');
  tFIS_NFITEMUN := GetEntidade('FIS_NFITEMUN');
  tFIS_NFITEMVL := GetEntidade('FIS_NFITEMVL');
  tFIS_NFITEMADIC := GetEntidade('FIS_NFITEMADIC');
  tFIS_NFREF := GetEntidade('FIS_NFREF');
  tFIS_NFREMDES := GetEntidade('FIS_NFREMDES');
  //tFIS_NFSELOENT := GetEntidade('FIS_NFSELOENT');
  tFIS_NFTRANSP := GetEntidade('FIS_NFTRANSP');
  tFIS_NFVENCTO := GetEntidade('FIS_NFVENCTO');
  tFIS_S_NF := GetEntidade('FIS_NF', 'FIS_S_NF');
  tGER_MODNFC := GetEntidade('GER_MODNFC');
  tGER_OPERACAO := GetEntidade('GER_OPERACAO');
  tGER_S_OPERACAO := GetEntidade('GER_OPERACAO', 'GER_S_OPERACAO');
  tGER_SERIE := GetEntidade('GER_SERIE');
  tOBS_NF := GetEntidade('OBS_NF');
  tOBS_TRANSACNF := GetEntidade('OBS_TRANSACNF');
  tPRD_CLASSIFICACAO := GetEntidade('PRD_CLASSIFICACAO');
  tPRD_PRODUTOCLAS := GetEntidade('PRD_PRODUTOCLAS');
  tPRD_TIPOCLAS := GetEntidade('PRD_TIPOCLAS');
  tTRA_ITEMIMPOSTO := GetEntidade('TRA_ITEMIMPOSTO');
  //tTRA_ITEMLOTE := GetEntidade('TRA_ITEMLOTE');
  //tTRA_ITEMPRDFIN := GetEntidade('TRA_ITEMPRDFIN');
  //tTRA_ITEMSELOENT := GetEntidade('TRA_ITEMSELOENT');
  //tTRA_ITEMSERIAL := GetEntidade('TRA_ITEMSERIAL');
  tTRA_ITEMUN := GetEntidade('TRA_ITEMUN');
  tTRA_ITEMVL := GetEntidade('TRA_ITEMVL');
  tTRA_REMDES := GetEntidade('TRA_REMDES');
  //tTRA_SELOENT := GetEntidade('TRA_SELOENT');
  tTRA_TRANREF := GetEntidade('TRA_TRANREF');
  tTRA_TRANSACAO := GetEntidade('TRA_TRANSACAO');
  tTRA_TRANSACECF := GetEntidade('TRA_TRANSACECF');
  tTRA_TRANSITEM := GetEntidade('TRA_TRANSITEM');
  tTRA_TRANSPORT := GetEntidade('TRA_TRANSPORT');
  tTRA_VENCIMENTO := GetEntidade('TRA_VENCIMENTO');
  tV_FIS_NFREMDES := GetEntidade('FIS_NFREMDES', 'V_FIS_NFREMDES');

  // filhas ???
  tGER_MODNFC._LstFilha := 'GER_SERIE|';
  tGER_OPERACAO._LstFilha := 'GER_S_OPERACAO|';
  tPRD_PRODUTOCLAS._LstFilha := 'PRD_CLASSIFICACAO|';
  tFIS_NF._LstFilha := 'FIS_NFIMPOSTO:u|FIS_NFECF:u|FIS_NFTRANSP:u|FIS_NFREMDES:u|FIS_NFREF:u|OBS_NF:u|FIS_NFVENCTO:u|FIS_NFSELOENT:u|FIS_NFITEM:u|';
  tFIS_NFITEM._LstFilha := 'FIS_NFISELOENT:u|FIS_NFITEMDESP:u|FIS_NFITEMIMPOST:u|FIS_ITEMIMPRET:u|FIS_NFITEMPROD:u|FIS_NFITEMADIC:u|';
  tFIS_NFITEMPROD._LstFilha := 'FIS_NFITEMPPRODFIN:u|FIS_NFITEMDESP:u|FIS_NFITEMSERV:u|FIS_NFITEMUN:u|FIS_NFITEMCONT:u|FIS_NFITEMVL:u|FIS_NFITEMPLOTE:u|';
  tTRA_TRANSACAO._LstFilha := 'TRA_TRAIMPOSTO:u|OBS_TRANSACNF:u|TRA_TRANSACECF:u|TRA_REMDES:u|TRA_TRANREF:u|TRA_TRANSPORT:u|TRA_VENCIMENTO:u|TRA_SELOENT:u|TRA_TRANSITEM:u|';
  tTRA_TRANSITEM._LstFilha := 'TRA_ITEMSELOENT:u|TRA_ITEMPRDFIN:u|TRA_ITEMUN:u|TRA_ITEMVL:u|TRA_ITEMIMPOSTO:u|TRA_ITEMSERIAL:u|TRA_ITEMLOTE:u|';

  // calculado ???
  tF_TMP_NR09._LstCalc := 'VL_TOTAL:N(10,2)|QT_ITEM:N(10,2)|';
  tTMP_CSTALIQ._LstCalc := 'VL_BASECALC:N(10,2)|VL_IMPOSTO:N(10,2)|';
  tTMP_K02._LstCalc := 'VL_GERAL:N(10,2)|PR_REDUBASE:N(10)|';
  tTMP_NR09._LstCalc := 'VL_IMPOSTO:N(10,2)|VL_OUTRO:N(10,2)|VL_ISENTO:N(10,2)|VL_BASECALC:N(10,2)|PR_REDUBASE:N(10,2)|PR_BASECALC:N(10,2)|PR_ALIQUOTA:N(10,2)|CD_CST:S(03)|';
  tFIS_NFITEM._LstCalc := 'DS_LSTIMPOSTO:A(4000)|';
  tTRA_TRANSITEM._LstCalc := 'CD_NIVELGRUPO:A(60)|DS_NIVELGRUPO:A(60)|CD_SEQGRUPO:N(09)|CD_COR:A(10)|CD_TAMANHO:N(03)|';
end;

//----------------------------------------------------------
function T_FISSVCO004.geraCapaNF(pParams : String) : String;
//----------------------------------------------------------
const
  cDS_METHOD = 'ADICIONAL=Operação: T_FISSVCO004.geraCapaNF()';
var
  vNrNF : Real;
  viParams, voParams, vDsRegistro : String;
  vDtSistema : TDateTime;
begin
  gNrFatura := 0;

  if (item_f('TP_ORIGEMEMISSAO', tTRA_TRANSACAO) = 2) then begin
    viParams := '';
    putitemXml(viParams, 'CD_EMPRESA', item_f('CD_EMPRESA', tTRA_TRANSACAO));
    putitemXml(viParams, 'NR_TRANSACAO', item_f('NR_TRANSACAO', tTRA_TRANSACAO));
    putitemXml(viParams, 'DT_TRANSACAO', item_a('DT_TRANSACAO', tTRA_TRANSACAO));
    voParams := activateCmp('SICSVCO005', 'buscaSequencia', viParams); 
    if (xStatus < 0) then begin
      Result := voParams;
      return(-1); exit;
    end;
    gNrFatura := itemXmlF('NR_FATURA', voParams);
  end else begin
    if (item_f('CD_EMPFAT', tTRA_TRANSACAO) <> itemXmlF('CD_EMPRESA', PARAM_GLB)) then begin
      if (gDsLstFatura <> '') then begin
        getitem(gNrFatura, gDsLstFatura, 1);
        delitemGld(gDsLstFatura, 1);
      end;
    end;
    if (gNrFatura = 0) then begin
      viParams := '';
      putitemXml(viParams, 'NM_ENTIDADE', 'FIS_NF');
      voParams := activateCmp('GERSVCO031', 'getNumSeq', viParams); 
      if (xStatus < 0) then begin
        Result := voParams;
        return(-1); exit;
      end;
      gNrFatura := itemXmlF('NR_SEQUENCIA', voParams);
    end;
    if (item_f('CD_EMPFAT', tTRA_TRANSACAO) = itemXmlF('CD_EMPRESA', PARAM_GLB)) then begin
      putitem(gDsLstFatura, FloatToStr(gNrFatura));
    end;
  end;
  if (gNrFatura = 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN001', 'Não foi possível obter nr. de fatura da NF', cDS_METHOD);
    return(-1); exit;
  end;
  if (gDtFatura <> 0) then begin
    vDtSistema := gDtFatura;
  end else begin
    vDtSistema := itemXmlD('DT_SISTEMA', PARAM_GLB);
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

    if (item_f('TP_DOCTO', tGER_S_OPERACAO) = 0) then begin
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
  putitem_e(tFIS_NF, 'TP_OPERACAO', item_a('TP_OPERACAO', tTRA_TRANSACAO));

  if (gTpModDctoFiscalLocal > 0) then begin
    putitem_e(tFIS_NF, 'TP_MODDCTOFISCAL', gTpModDctoFiscalLocal);
  end else begin
    if (gTpModDctoFiscal = 0) then begin
      putitem_e(tFIS_NF, 'TP_MODDCTOFISCAL', 02);
    end else begin
      putitem_e(tFIS_NF, 'TP_MODDCTOFISCAL', gTpModDctoFiscal);
    end;
  end;
  if (item_a('TP_MODALIDADE', tGER_S_OPERACAO) = 'D') then begin
    putitem_e(tFIS_NF, 'TP_MODDCTOFISCAL', 85);
  end else if (item_a('TP_MODALIDADE', tGER_S_OPERACAO) = 'G') then begin
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

  if (gHrSaida = 0) then begin
    putitem_e(tFIS_NF, 'HR_SAIDA', TimeToStr(Time));
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
  piDsLstProduto : String; piNrItem : Real;
  vVlValor, vCdProduto, vCdValor, vTpRegime, vCdRegraFiscal, vCdRegraFiscalProd : Real;
  viParams, voParams, vCdItem, vTpValor, vDsItem, vDsRegistro, vDsLstValor : String;
  vDsLstItemUn, vCdTIPI, vDsTIPI, vDsLstSerial, vDsLstDespesa, vTpReducao, vTpAliqIcms : String;
  vLstLoteInfGeral, vLstLoteInf, vDsLstItemLote, vDsLstNf, vDsLstItemPrdFin : String;
  vInCopiaValor, vInObs : Boolean;
  vLstImposto : String;
begin
  piDsLstProduto := itemXml('DS_LSTPRODUTO', pParams);
  piNrItem := itemXmlF('NR_ITEM', pParams);

  vCdTIPI := '';
  vDsTIPI := '';

  if (item_f('CD_PRODUTO', tTRA_TRANSITEM) > 0) and (item_a('CD_ESPECIE', tTRA_TRANSITEM) <> gCdEspecieServico) then begin
    if (item_a('CD_TIPI', tTRA_TRANSITEM) = '') then begin
      viParams := '';
      putitemXml(viParams, 'CD_PRODUTO', item_f('CD_PRODUTO', tTRA_TRANSITEM));
      voParams := activateCmp('GERSVCO046', 'buscaDadosProduto', viParams);
      if (xStatus < 0) then begin
        Result := voParams;
        return(-1); exit;
      end;
      vCdTIPI := itemXml('CD_TIPI', voParams);
      vDsTIPI := itemXml('DS_TIPI', voParams);
    end else begin
      vCdTIPI := item_a('CD_TIPI', tTRA_TRANSITEM);
      viParams := '';
      putitemXml(viParams, 'CD_TIPI', vCdTIPI);
      voParams := activateCmp('GERSVCO046', 'buscaDadosFiscal', viParams);
      if (xStatus < 0) then begin
        Result := voParams;
        return(-1); exit;
      end;

      vDsTIPI := itemXml('DS_TIPI', voParams);
    end;
  end;
  if (item_a('CD_BARRAPRD', tTRA_TRANSITEM) <> '') and (item_a('CD_ESPECIE', tTRA_TRANSITEM) <> gCdEspecieServico) then begin
    vCdTIPI := item_a('CD_TIPI', tTRA_TRANSITEM);
    if (vCdTIPI <> '') then begin
      viParams := '';
      putitemXml(viParams, 'CD_TIPI', vCdTIPI);
      voParams := activateCmp('GERSVCO046', 'buscaDadosFiscal', viParams);
      if (xStatus < 0) then begin
        Result := voParams;
        return(-1); exit;
      end;

      vDsTIPI := itemXml('DS_TIPI', voParams);
    end;
  end;
  if (item_f('QT_FATURADO', tFIS_NFITEM) = 0) or (item_f('QT_FATURADO', tFIS_NFITEM) = 1)
  or (itemXmlF('TP_ARREDOND_VL_UNIT_VD', PARAM_GLB) = 1) or (itemXmlF('TP_ARREDOND_VL_UNIT_VD', PARAM_GLB) = 2) then begin
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
  putitem_e(tFIS_NFITEM, 'CD_ESPECIE', item_a('CD_ESPECIE', tTRA_TRANSITEM));
  putitem_e(tFIS_NFITEM, 'CD_CST', item_a('CD_CST', tTRA_TRANSITEM));
  putitem_e(tFIS_NFITEM, 'CD_CFOP', item_a('CD_CFOP', tTRA_TRANSITEM));
  putitem_e(tFIS_NFITEM, 'CD_DECRETO', item_a('CD_DECRETO', tTRA_TRANSITEM));
  putitem_e(tFIS_NFITEM, 'CD_TIPI', vCdTIPI);
  putitem_e(tFIS_NFITEM, 'QT_FATURADO', item_f('QT_SOLICITADA', tTRA_TRANSITEM));
  putitem_e(tFIS_NFITEM, 'VL_TOTALBRUTO', item_f('VL_TOTALBRUTO', tTRA_TRANSITEM));
  putitem_e(tFIS_NFITEM, 'VL_TOTALLIQUIDO', item_f('VL_TOTALLIQUIDO', tTRA_TRANSITEM));
  putitem_e(tFIS_NFITEM, 'VL_TOTALDESC', item_f('VL_TOTALDESC', tTRA_TRANSITEM) + item_f('VL_TOTALDESCCAB', tTRA_TRANSITEM));

  if (gInCalcTributo = True) then begin
    vVlValor := (item_f('VL_TOTALBRUTO', tFIS_NFITEM) * gPrTotalTributo) / 100;
    vVlValor := rounded(vVlValor, 6);
    putitem_e(tFIS_NFITEMADIC, 'VL_TOTALTRIBUTO', vVlValor);
    putitem_e(tFIS_NFITEMADIC, 'CD_OPERADOR', itemXmlF('CD_USUARIO', PARAM_GLB));
    putitem_e(tFIS_NFITEMADIC, 'DT_CADASTRO', Now);

    voParams := tFIS_NFITEMADIC.Salvar();
    if (xStatus < 0) then begin
      Result := voParams;
      return(-1); exit;
    end;
  end;

  if (vInCopiaValor = True) and (gTpAgrupamentoItemNF <> 1) then begin
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
    putitem_o(tF_TMP_NR09, 'NR_GERAL', item_f('CD_CFOP', tFIS_NFITEM));
    retrieve_o(tF_TMP_NR09);
    if (xStatus = -7) then begin
      retrieve_x(tF_TMP_NR09);
    end;

    putitem_e(tF_TMP_NR09, 'VL_TOTAL', item_f('VL_TOTAL', tF_TMP_NR09) + item_f('VL_TOTALLIQUIDO', tFIS_NFITEM));
    putitem_e(tF_TMP_NR09, 'QT_ITEM', item_f('QT_ITEM', tF_TMP_NR09) + item_f('QT_FATURADO', tFIS_NFITEM));
  end;
  if (item_a('CD_ESPECIE', tTRA_TRANSITEM) = gCdEspecieServico) then begin
    if (item_f('CD_PRODUTO', tTRA_TRANSITEM) = 0) then begin
      putitem_e(tFIS_NFITEM, 'CD_PRODUTO', item_f('CD_BARRAPRD', tTRA_TRANSITEM));
    end else begin
      putitem_e(tFIS_NFITEM, 'CD_PRODUTO', item_f('CD_PRODUTO', tTRA_TRANSITEM));
    end;
    putitem_e(tFIS_NFITEM, 'DS_PRODUTO', item_a('DS_PRODUTO', tTRA_TRANSITEM));
  end else begin
    if (item_f('CD_PRODUTO', tTRA_TRANSITEM) = 0) and (item_a('CD_BARRAPRD', tTRA_TRANSITEM) = '') then begin
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
        putitem_e(tFIS_NFITEM, 'CD_PRODUTO', copy(item_a('CD_NIVELGRUPO', tTRA_TRANSITEM),1,14));
        putitem_e(tFIS_NFITEM, 'DS_PRODUTO', copy(item_a('DS_NIVELGRUPO', tTRA_TRANSITEM),1,60));
      end else if (gTpCodigoItem = 2) then begin
        vCdItem := '';
        vDsItem := '';
        setocc(tPRD_TIPOCLAS, 1);
        while (xStatus >= 0) do begin
          clear_e(tPRD_PRODUTOCLAS);
          putitem_o(tPRD_PRODUTOCLAS, 'CD_PRODUTO', item_f('CD_PRODUTO', tTRA_TRANSITEM));
          putitem_o(tPRD_PRODUTOCLAS, 'CD_TIPOCLAS', item_f('CD_TIPOCLAS', tPRD_TIPOCLAS));
          retrieve_e(tPRD_PRODUTOCLAS);
          if (xStatus >= 0) then begin
            vCdItem := vCdItem + item_a('CD_CLASSIFICACAO', tPRD_PRODUTOCLAS) + ' ';
            vDsItem := vDsItem + item_a('DS_CLASSIFICACAO', tPRD_CLASSIFICACAO) + ' ';
          end;
          setocc(tPRD_TIPOCLAS, curocc(tPRD_TIPOCLAS) + 1);
        end;
        putitem_e(tFIS_NFITEM, 'CD_PRODUTO', copy(vCdItem,1,14));
        putitem_e(tFIS_NFITEM, 'DS_PRODUTO', copy(vDsItem,1,60));
      end else if (gTpCodigoItem = 3) then begin
        putitem_e(tFIS_NFITEM, 'CD_PRODUTO', vCdTIPI);
        putitem_e(tFIS_NFITEM, 'DS_PRODUTO', vDSTIPI);
      end else if (gTpCodigoItem = 5) then begin
        if (gTpAgrupamento = 'F') or (gTpAgrupamento = '') then begin
          viParams := '';
          putitemXml(viParams, 'CD_PRODUTO', item_f('CD_PRODUTO', tTRA_TRANSITEM));
          putitemXml(viParams, 'CD_PESSOA', item_f('CD_PESSOA', tTRA_TRANSACAO));
          voParams := activateCmp('PRDSVCO023', 'buscaDadosProduto', viParams);
          if (xStatus < 0) then begin
            Result := voParams;
            return(-1); exit;
          end;
          putitem_e(tFIS_NFITEM, 'CD_PRODUTO', copy(itemXml('CD_ORIGEM', voParams),1,14));
          putitem_e(tFIS_NFITEM, 'DS_PRODUTO', copy(itemXml('DS_ORIGEM', voParams),1,60));
        end else begin
          viParams := '';
          putitemXml(viParams, 'CD_SEQGRUPO', item_f('CD_SEQGRUPO', tTRA_TRANSITEM));
          putitemXml(viParams, 'CD_PESSOA', item_f('CD_PESSOA', tTRA_TRANSACAO));
          voParams := activateCmp('PRDSVCO023', 'buscaDadosGrupo', viParams);
          if (xStatus < 0) then begin
            Result := voParams;
            return(-1); exit;
          end;
          putitem_e(tFIS_NFITEM, 'CD_PRODUTO', copy(itemXml('CD_ORIGEM', voParams),1,14));
          putitem_e(tFIS_NFITEM, 'DS_PRODUTO', copy(itemXml('DS_ORIGEM', voParams),1,60));
        end;
      end else if (gTpCodigoItem = 6) then begin
        putitem_e(tTRA_TRANSITEM, 'CD_NIVELGRUPO', ReplaceStr(item_a('CD_NIVELGRUPO', tTRA_TRANSITEM), ' ', ''));
        putitem_e(tFIS_NFITEM, 'CD_PRODUTO', copy(item_a('CD_NIVELGRUPO', tTRA_TRANSITEM),1,14));
        putitem_e(tFIS_NFITEM, 'DS_PRODUTO', copy(item_a('DS_NIVELGRUPO', tTRA_TRANSITEM),1,60));
      end else if (gTpCodigoItem = 7) then begin
        viParams := '';
        putitemXml(viParams, 'CD_EMPRESA', item_f('CD_EMPRESA', tTRA_TRANSACAO));
        putitemXml(viParams, 'NR_TRANSACAO', item_f('NR_TRANSACAO', tTRA_TRANSACAO));
        putitemXml(viParams, 'DT_TRANSACAO', item_a('DT_TRANSACAO', tTRA_TRANSACAO));
        if (gTpAgrupamento = 'F') or (gTpAgrupamento = '') then begin
          putitemXml(viParams, 'CD_PRODUTO', item_f('CD_PRODUTO', tTRA_TRANSITEM));
        end else begin
          putitemXml(viParams, 'CD_SEQGRUPO', item_f('CD_SEQGRUPO', tTRA_TRANSITEM));
        end;
        voParams := activateCmp('PRDSVCO015', 'retornaDadosPedidoG', viParams);
        if (xStatus < 0) then begin
          Result := voParams;
          return(-1); exit;
        end;
        putitem_e(tFIS_NFITEM, 'CD_PRODUTO', copy(itemXml('CD_NIVELFAT', voParams),1,14));
        putitem_e(tFIS_NFITEM, 'DS_PRODUTO', copy(itemXml('DS_NIVELFAT', voParams),1,60));
      end else begin
        if (item_f('CD_PRODUTO', tTRA_TRANSITEM) = 0) then begin
          putitem_e(tFIS_NFITEM, 'CD_PRODUTO', item_f('CD_BARRAPRD', tTRA_TRANSITEM));
          putitem_e(tFIS_NFITEM, 'CD_TIPI', item_f('CD_TIPI', tTRA_TRANSITEM));
        end else begin
          putitem_e(tFIS_NFITEM, 'CD_PRODUTO', item_f('CD_PRODUTO', tTRA_TRANSITEM));
        end;
        putitem_e(tFIS_NFITEM, 'DS_PRODUTO', item_a('DS_PRODUTO', tTRA_TRANSITEM));
      end;
      if (item_a('CD_PRODUTO', tFIS_NFITEM) = '') or (item_a('DS_PRODUTO', tFIS_NFITEM) = '') then begin
        if (gTpAgrupamento = 'F') or (gTpAgrupamento = '') then begin
          if (item_f('CD_PRODUTO', tTRA_TRANSITEM) = 0) then begin
            putitem_e(tFIS_NFITEM, 'CD_PRODUTO', item_f('CD_BARRAPRD', tTRA_TRANSITEM));
          end else begin
            putitem_e(tFIS_NFITEM, 'CD_PRODUTO', item_f('CD_PRODUTO', tTRA_TRANSITEM));
          end;
          putitem_e(tFIS_NFITEM, 'DS_PRODUTO', item_a('DS_PRODUTO', tTRA_TRANSITEM));
        end else begin
          putitem_e(tFIS_NFITEM, 'CD_PRODUTO', copy(item_a('CD_NIVELGRUPO', tTRA_TRANSITEM),1,14));
          putitem_e(tFIS_NFITEM, 'DS_PRODUTO', copy(item_a('DS_NIVELGRUPO', tTRA_TRANSITEM),1,60));
        end;
      end;
    end;
  end;

  putitem_e(tFIS_NFITEM, 'CD_PRODUTO', limpaString(item_a('CD_PRODUTO', tFIS_NFITEM)));
  putitem_e(tFIS_NFITEM, 'DS_PRODUTO', limpaString(item_a('DS_PRODUTO', tFIS_NFITEM)));

  if (item_a('CD_PRODUTO', tFIS_NFITEM) <> '') then begin
    if (item_f('CD_CFOP', tFIS_NFITEM) = 0) then begin
      Result := SetStatus(STS_ERROR, 'GEN001', 'Falta CFOP no produto ' + item_a('CD_PRODUTO', tFIS_NFITEM) + '!', cDS_METHOD);
      return(-1); exit;
    end;
    if (item_a('CD_CST', tFIS_NFITEM) = '') then begin
      Result := SetStatus(STS_ERROR, 'GEN001', 'Falta CST no produto ' + item_a('CD_PRODUTO', tFIS_NFITEM) + '!', cDS_METHOD);
      return(-1); exit;
    end;
  end;

  vInObs := False;

  if (item_f('CD_DECRETO', tFIS_NFITEM) = 1020) or (item_f('CD_DECRETO', tFIS_NFITEM) = 10201) or (item_f('CD_DECRETO', tFIS_NFITEM) = 10202) or (item_f('CD_DECRETO', tFIS_NFITEM) = 10203) then begin
    if (gPrAplicMvaSubTrib <> '') and (gUfOrigem = 'SC') and (gUfDestino = 'SC') and ((gTpRegimeTrib = 2) or (gTpRegimeTrib = 3)) then begin
      creocc(tTMP_NR08, -1);
      putitem_o(tTMP_NR08, 'NR_08', 1);
      retrieve_o(tTMP_NR08);
      if (xStatus = 0) then begin
        if (gDsAdicionalRegra = '') then begin
          gDsAdicionalRegra := gDsEmbLegalSubTrib;
        end else begin
          gDsAdicionalRegra := gDsAdicionalRegra + ' ' + gDsEmbLegalSubTrib;
        end;
      end;
    end;
  end;
  if (piDsLstProduto <> '') and (item_a('CD_ESPECIE', tFIS_NFITEM) <> gCdEspecieServico) then begin
    repeat
      getitem(vDsRegistro, piDsLstProduto, 1);
      vCdProduto := itemXmlF('CD_PRODUTO', vDsRegistro);
      if (vCdProduto <> 0) then begin
        creocc(tFIS_NFITEMPROD, -1);
        putitem_o(tFIS_NFITEMPROD, 'CD_PRODUTO', vCdProduto);
        retrieve_o(tFIS_NFITEMPROD);
        if (xStatus = -7) then begin
          retrieve_x(tFIS_NFITEMPROD);
        end;
        putitem_e(tFIS_NFITEMPROD, 'CD_EMPFAT', item_f('CD_EMPFAT', tTRA_TRANSACAO));
        putitem_e(tFIS_NFITEMPROD, 'CD_GRUPOEMPRESA', item_f('CD_GRUPOEMPRESA', tTRA_TRANSACAO));
        putitem_e(tFIS_NFITEMPROD, 'QT_FATURADO', item_f('QT_FATURADO', tFIS_NFITEMPROD) + itemXmlF('QT_FATURADO', vDsRegistro));
        putitem_e(tFIS_NFITEMPROD, 'VL_UNITBRUTO', itemXmlF('VL_UNITBRUTO', vDsRegistro));
        putitem_e(tFIS_NFITEMPROD, 'VL_UNITDESC', itemXmlF('VL_UNITDESC', vDsRegistro));
        putitem_e(tFIS_NFITEMPROD, 'VL_UNITLIQUIDO', itemXmlF('VL_UNITLIQUIDO', vDsRegistro));
        putitem_e(tFIS_NFITEMPROD, 'VL_TOTALDESC', item_f('VL_TOTALDESC', tFIS_NFITEMPROD) + itemXmlF('VL_TOTALDESC', vDsRegistro));
        putitem_e(tFIS_NFITEMPROD, 'VL_TOTALLIQUIDO', item_f('VL_TOTALLIQUIDO', tFIS_NFITEMPROD) + itemXmlF('VL_TOTALLIQUIDO', vDsRegistro));
        putitem_e(tFIS_NFITEMPROD, 'VL_TOTALBRUTO', item_f('VL_TOTALBRUTO', tFIS_NFITEMPROD) + itemXmlF('VL_TOTALBRUTO', vDsRegistro));
        putitem_e(tFIS_NFITEMPROD, 'CD_COMPVEND', itemXmlF('CD_COMPVEND', vDsRegistro));
        putitem_e(tFIS_NFITEMPROD, 'CD_PROMOCAO', itemXmlF('CD_PROMOCAO', vDsRegistro));
        putitem_e(tFIS_NFITEMPROD, 'CD_OPERADOR', itemXmlF('CD_USUARIO', PARAM_GLB));
        putitem_e(tFIS_NFITEMPROD, 'DT_CADASTRO', Now);

        if ((gPrAplicMvaSubTrib = '') and (gInPDVOtimizado = True)) or (gTpImpObsRegraFiscalNf = 1) then begin
          vInObs := False;
          viParams := '';
          putitemXml(viParams, 'CD_PRODUTO', item_f('CD_PRODUTO', tFIS_NFITEMPROD));
          putitemXml(viParams, 'CD_OPERACAO', item_f('CD_OPERACAO', tGER_OPERACAO));
          voParams := activateCmp('FISSVCO033', 'buscaRegraFiscalProduto', viParams);
          if (xStatus < 0) then begin
            Result := voParams;
            return(-1); exit;
          end;

          vCdRegraFiscalProd := itemXmlF('CD_REGRAFISCAL', voParams);

          if (vCdRegraFiscalProd <> 0) then begin
            creocc(tTMP_NR08, -1);
            putitem_o(tTMP_NR08, 'NR_08', vCdRegraFiscalProd);
            retrieve_o(tTMP_NR08);
            if (xStatus = 0) then begin
              viParams := '';
              putitemXml(viParams, 'CD_REGRAFISCAL', vCdRegraFiscalProd);
              voParams := activateCmp('FISSVCO033', 'buscaDadosRegraFiscal', viParams);
              if (xStatus < 0) then begin
                Result := voParams;
                return(-1); exit;
              end;

              vTpReducao := itemXml('TP_REDUCAO', voParams);
              vTpAliqIcms := itemXml('TP_ALIQICMS', voParams);

              if (vTpReducao = '') and (vTpAliqIcms = '') then begin
                vInObs := True;
              end else if  ((vTpReducao = 'G') or (vTpReducao = 'H') or (vTpReducao = 'I'))
                       or (((vTpReducao = 'A') or (vTpReducao = 'B') or (vTpReducao = 'C')) and (gUfOrigem = gUfDestino))
                       or (((vTpReducao = 'D') or (vTpReducao = 'E') or (vTpReducao = 'F')) and (gUfOrigem <> gUfDestino)) then begin
                vInObs := True;
              end else if (((vTpAliqIcms = 'C') or (vTpAliqIcms = 'A')) and (gUfOrigem = gUfDestino))
                       or ((vTpAliqIcms = 'B') and (gUfOrigem <> gUfDestino)) then begin
                vInObs := True;
              end;

              if (item_f('CD_REGRAFISCAL', tGER_S_OPERACAO) > 0) then begin
                vCdRegraFiscal := item_f('CD_REGRAFISCAL', tGER_S_OPERACAO);
              end else if (item_f('CD_REGRAFISCAL', tGER_OPERACAO) > 0) then begin
                vCdRegraFiscal := item_f('CD_REGRAFISCAL', tGER_OPERACAO);
              end;
              if (vCdRegraFiscalProd <> vCdRegraFiscal) and (vInObs = True) then begin
                if (gDsAdicionalRegra = '') then begin
                  gDsAdicionalRegra := itemXml('DS_ADICIONAL', voParams);
                end else begin
                  gDsAdicionalRegra := gDsAdicionalRegra + ' ' + itemXml('DS_ADICIONAL', voParams);
                end;
              end;
            end;
          end;
        end;
        if (item_a('TP_MODALIDADE', tGER_OPERACAO) = 'C') and (item_a('TP_OPERACAO', tGER_OPERACAO) = 'S') and (item_a('TP_MODALIDADE', tGER_S_OPERACAO) = 'C') then begin
          creocc(tFIS_NFITEMCONT, -1);
          putitem_o(tFIS_NFITEMCONT, 'CD_EMPRESA', item_f('CD_EMPRESA', tFIS_NFITEMPROD));
          putitem_o(tFIS_NFITEMCONT, 'NR_FATURA', item_f('NR_FATURA', tFIS_NFITEMPROD));
          putitem_o(tFIS_NFITEMCONT, 'DT_FATURA', item_a('DT_FATURA', tFIS_NFITEMPROD));
          putitem_o(tFIS_NFITEMCONT, 'NR_ITEM', item_f('NR_ITEM', tFIS_NFITEMPROD));
          putitem_o(tFIS_NFITEMCONT, 'CD_PRODUTO', item_f('CD_PRODUTO', tFIS_NFITEMPROD));
          retrieve_o(tFIS_NFITEMCONT);
          if (xStatus = -7) then begin
            retrieve_x(tFIS_NFITEMCONT);
          end;
          putitem_e(tFIS_NFITEMCONT, 'CD_EMPFAT', item_f('CD_EMPFAT', tFIS_NFITEMPROD));
          putitem_e(tFIS_NFITEMCONT, 'CD_GRUPOEMPRESA', item_f('CD_GRUPOEMPRESA', tFIS_NFITEMPROD));
          putitem_e(tFIS_NFITEMCONT, 'TP_SITUACAO', 1);
          putitem_e(tFIS_NFITEMCONT, 'CD_OPERADOR', itemXmlF('CD_USUARIO', PARAM_GLB));
          putitem_e(tFIS_NFITEMCONT, 'DT_CADASTRO', Now);
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
            vTpValor := itemXml('TP_VALOR', vDsRegistro);
            vCdValor := itemXmlF('CD_VALOR', vDsRegistro);
            creocc(tFIS_NFITEMVL, -1);
            putitem_o(tFIS_NFITEMVL, 'TP_VALOR', vTpValor);
            putitem_o(tFIS_NFITEMVL, 'CD_VALOR', vCdValor);
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
            delitemGld(vDsLstValor, 1);
          until (vDsLstValor = '');
        end;
        if (vDsLstSerial <> '') then begin
          if (item_a('TP_OPERACAO', tTRA_TRANSACAO) = 'E') then begin
            viParams := '';
            putitemXml(viParams, 'CD_PRODUTO', item_f('CD_PRODUTO', tFIS_NFITEMPROD));
            putitemXml(viParams, 'DS_LSTSERIAL', vDsLstSerial);
            putitemXml(viParams, 'TP_SITUACAO', 1);
            voParams := activateCmp('PRDSVCO021', 'incluiSerialProduto', viParams);
            if (xStatus < 0) then begin
              Result := voParams;
              return(-1); exit;
            end;
          end;

          repeat
            getitem(vDsRegistro, vDsLstSerial, 1);
            creocc(tFIS_NFITEMSERIAL, -1);
            putitem_o(tFIS_NFITEMSERIAL, 'NR_SEQUENCIA', curocc(tFIS_NFITEMSERIAL));
            retrieve_o(tFIS_NFITEMSERIAL);
            if (xStatus = -7) then begin
              retrieve_x(tFIS_NFITEMSERIAL);
            end;
            putitem_e(tFIS_NFITEMSERIAL, 'CD_EMPFAT', itemXmlF('CD_EMPFAT', vDsRegistro));
            putitem_e(tFIS_NFITEMSERIAL, 'CD_GRUPOEMPRESA', itemXmlF('CD_GRUPOEMPRESA', vDsRegistro));
            putitem_e(tFIS_NFITEMSERIAL, 'DS_SERIAL', itemXml('DS_SERIAL', vDsRegistro));
            putitem_e(tFIS_NFITEMSERIAL, 'CD_OPERADOR', itemXmlF('CD_USUARIO', PARAM_GLB));
            putitem_e(tFIS_NFITEMSERIAL, 'DT_CADASTRO', Now);

            delitemGld(vDsLstSerial, 1);
          until (vDsLstSerial = '');
        end;
        if (vDsLstDespesa <> '') then begin
          repeat
            getitem(vDsRegistro, vDsLstDespesa, 1);
            if (itemXmlF('CD_DESPESAITEM', vDsRegistro) > 0) and (itemXmlF('CD_CCUSTO', vDsRegistro) > 0) then begin
              creocc(tFIS_NFITEMDESP, -1);
              putitem_o(tFIS_NFITEMDESP, 'CD_DESPESAITEM', itemXmlF('CD_DESPESAITEM', vDsRegistro));
              putitem_o(tFIS_NFITEMDESP, 'CD_CCUSTO', itemXmlF('CD_CCUSTO', vDsRegistro));
              retrieve_o(tFIS_NFITEMDESP);
              if (xStatus = -7) then begin
                retrieve_x(tFIS_NFITEMDESP);
              end;
              putitem_e(tFIS_NFITEMDESP, 'PR_RATEIO', itemXmlF('PR_RATEIO', vDsRegistro));
              putitem_e(tFIS_NFITEMDESP, 'CD_OPERADOR', itemXmlF('CD_USUARIO', PARAM_GLB));
              putitem_e(tFIS_NFITEMDESP, 'DT_CADASTRO', Now);
            end;
            delitemGld(vDsLstDespesa, 1);
          until (vDsLstDespesa = '');
        end;
        if (vDsLstItemLote <> '') then begin
          repeat
            getitem(vDsRegistro, vDsLstItemLote, 1);
            if (gInItemLote) then begin
              creocc(tFIS_NFITEMPLOTE, -1);
              putitem_o(tFIS_NFITEMPLOTE, 'NR_SEQUENCIA', curocc(tFIS_NFITEMPLOTE));
              retrieve_o(tFIS_NFITEMPLOTE);
              if (xStatus = -7) then begin
                retrieve_x(tFIS_NFITEMPLOTE);
              end;
              putitem_e(tFIS_NFITEMPLOTE, 'CD_EMPLOTE', itemXmlF('CD_EMPLOTE', vDsRegistro));
              putitem_e(tFIS_NFITEMPLOTE, 'NR_LOTE', itemXmlF('NR_LOTE', vDsRegistro));
              putitem_e(tFIS_NFITEMPLOTE, 'NR_ITEMLOTE', itemXmlF('NR_ITEMLOTE', vDsRegistro));
              putitem_e(tFIS_NFITEMPLOTE, 'QT_LOTE', itemXmlF('QT_LOTE', vDsRegistro));
              putitem_e(tFIS_NFITEMPLOTE, 'QT_CONE', itemXmlF('QT_CONE', vDsRegistro));
              putitem_e(tFIS_NFITEMPLOTE, 'CD_BARRALOTE', itemXmlF('CD_BARRALOTE', vDsRegistro));
              putitem_e(tFIS_NFITEMPLOTE, 'CD_OPERADOR', itemXmlF('CD_USUARIO', PARAM_GLB));
              putitem_e(tFIS_NFITEMPLOTE, 'DT_CADASTRO', Now);
            end else begin

              if (gTinTinturaria = 1) then begin
                creocc(tFIS_NFITEMPLOTE, -1);
                putitem_o(tFIS_NFITEMPLOTE, 'NR_SEQUENCIA', curocc(tFIS_NFITEMPLOTE));
                retrieve_o(tFIS_NFITEMPLOTE);
                if (xStatus = -7) then begin
                  retrieve_x(tFIS_NFITEMPLOTE);
                end;
                putitem_e(tFIS_NFITEMPLOTE, 'CD_EMPLOTE', itemXmlF('CD_EMPLOTE', vDsRegistro));
                putitem_e(tFIS_NFITEMPLOTE, 'NR_LOTE', itemXmlF('NR_LOTE', vDsRegistro));
                putitem_e(tFIS_NFITEMPLOTE, 'NR_ITEMLOTE', itemXmlF('NR_ITEMLOTE', vDsRegistro));
                putitem_e(tFIS_NFITEMPLOTE, 'QT_LOTE', itemXmlF('QT_LOTE', vDsRegistro));
                putitem_e(tFIS_NFITEMPLOTE, 'QT_CONE', itemXmlF('QT_CONE', vDsRegistro));
                putitem_e(tFIS_NFITEMPLOTE, 'CD_BARRALOTE', itemXmlF('CD_BARRALOTE', vDsRegistro));
                putitem_e(tFIS_NFITEMPLOTE, 'CD_OPERADOR', itemXmlF('CD_USUARIO', PARAM_GLB));
                putitem_e(tFIS_NFITEMPLOTE, 'DT_CADASTRO', Now);
              end;

              vLstLoteInf := '';
              putitemXml(vLstLoteInf, 'CD_EMPRESA', itemXmlF('CD_EMPLOTE', vDsRegistro));
              putitemXml(vLstLoteInf, 'NR_LOTE', itemXmlF('NR_LOTE', vDsRegistro));
              putitemXml(vLstLoteInf, 'NR_ITEM', itemXmlF('NR_ITEMLOTE', vDsRegistro));
              putitemXml(vLstLoteInf, 'DT_FATURA', item_a('DT_FATURA', tFIS_NFITEMPROD));
              putitemXml(vLstLoteInf, 'CD_EMPRESANF', item_f('CD_EMPRESA', tFIS_NFITEMPROD));
              putitemXml(vLstLoteInf, 'NR_FATURA', item_f('NR_FATURA', tFIS_NFITEMPROD));
              putitemXml(vLstLoteInf, 'NR_ITEMNF', item_f('NR_ITEM', tFIS_NFITEMPROD));
              putitemXml(vLstLoteInf, 'CD_PRODUTONF', item_f('CD_PRODUTO', tFIS_NFITEMPROD));
              putitem(gLstLoteInfGeral, vLstLoteInf);
            end;
            delitemGld(vDsLstItemLote, 1);
          until (vDsLstItemLote = '');
        end;
        if (vDsLstItemPrdFin <> '') then begin
          repeat
            getitem(vDsRegistro, vDsLstItemPrdFin, 1);

            creocc(tFIS_NFITEMPPRDFIN, -1);
            putitem_o(tFIS_NFITEMPPRDFIN, 'CD_EMPPRDFIN', itemXmlF('CD_EMPPRDFIN', vDsRegistro));
            putitem_o(tFIS_NFITEMPPRDFIN, 'NR_PRDFIN', itemXmlF('NR_PRDFIN', vDsRegistro));
            retrieve_o(tFIS_NFITEMPPRDFIN);
            if (xStatus = -7) then begin
              retrieve_x(tFIS_NFITEMPPRDFIN);
            end;
            putitem_e(tFIS_NFITEMPPRDFIN, 'CD_OPERADOR', itemXmlF('CD_USUARIO', PARAM_GLB));
            putitem_e(tFIS_NFITEMPPRDFIN, 'DT_CADASTRO', Now);

            delitemGld(vDsLstItemPrdFin, 1);
          until (vDsLstItemPrdFin = '');
        end;
      end;
      delitemGld(piDsLstProduto, 1);
    until (piDsLstProduto = '');
    setocc(tFIS_NFITEMPROD, 1);
  end;

  if (gTpModDctoFiscalLocal = 85) or (gTpModDctoFiscalLocal = 87) then begin
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

  if (item_a('CD_DECRETO', tFIS_NFITEM) <> '') and (gInGravaDsDecretoObsNf = True) and (vInObs = True) then begin
    creocc(tFIS_DECRETO, -1);
    putitem_o(tFIS_DECRETO, 'CD_DECRETO', item_f('CD_DECRETO', tFIS_NFITEM));
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
      putitem(vLstImposto, vDsRegistro);
      setocc(tTMP_NR09, curocc(tTMP_NR09) + 1);
    end;
    putitem_e(tFIS_NFITEM, 'DS_LSTIMPOSTO', vLstImposto);
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
  if (item_b('IN_CALCIMPOSTO', tGER_S_OPERACAO) <> True) then begin
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
      setocc(tFIS_NFITEMPROD, 1);

      vVlFatorLiquido := (item_f('VL_DESPACESSOR', tFIS_NFITEM) + item_f('VL_FRETE', tFIS_NFITEM) + item_f('VL_SEGURO', tFIS_NFITEM) + item_f('VL_TOTALLIQUIDO', tFIS_NFITEM)) / item_f('VL_TOTALLIQUIDO', tFIS_NFITEM);
      vVlFatorBruto := (item_f('VL_DESPACESSOR', tFIS_NFITEM) + item_f('VL_FRETE', tFIS_NFITEM) + item_f('VL_SEGURO', tFIS_NFITEM) + item_f('VL_TOTALBRUTO', tFIS_NFITEM)) / item_f('VL_TOTALBRUTO', tFIS_NFITEM);

      if (item_b('IN_CALCIMPOSTO', tGER_OPERACAO) = True) then begin
        if (item_a('DS_LSTIMPOSTO', tFIS_NFITEM) <> '') then begin
          vDsLstImposto := item_a('DS_LSTIMPOSTO', tFIS_NFITEM);
          repeat
            getitem(vDsRegistro, vDsLstImposto, 1);
            vCdImposto := itemXmlF('NR_GERAL', vDsRegistro);
            if (vCdImposto > 0) then begin
              creocc(tFIS_NFITEMIMPOST, -1);
              putitem_e(tFIS_NFITEMIMPOST, 'CD_IMPOSTO', vCdImposto);
              putitem_e(tFIS_NFITEMIMPOST, 'CD_EMPFAT', item_f('CD_EMPFAT', tTRA_TRANSACAO));
              putitem_e(tFIS_NFITEMIMPOST, 'CD_GRUPOEMPRESA', item_f('CD_GRUPOEMPRESA', tTRA_TRANSACAO));
              putitem_e(tFIS_NFITEMIMPOST, 'PR_ALIQUOTA', itemXmlF('PR_ALIQUOTA', vDsRegistro));
              putitem_e(tFIS_NFITEMIMPOST, 'PR_BASECALC', itemXmlF('PR_BASECALC', vDsRegistro));
              putitem_e(tFIS_NFITEMIMPOST, 'PR_REDUBASE', itemXmlF('PR_REDUBASE', vDsRegistro));
              putitem_e(tFIS_NFITEMIMPOST, 'VL_BASECALC', itemXmlF('VL_BASECALC', vDsRegistro));
              putitem_e(tFIS_NFITEMIMPOST, 'VL_ISENTO', itemXmlF('VL_ISENTO', vDsRegistro));
              putitem_e(tFIS_NFITEMIMPOST, 'VL_OUTRO', itemXmlF('VL_OUTRO', vDsRegistro));
              putitem_e(tFIS_NFITEMIMPOST, 'VL_IMPOSTO', itemXmlF('VL_IMPOSTO', vDsRegistro));
              putitem_e(tFIS_NFITEMIMPOST, 'CD_PRODUTO', '');
              putitem_e(tFIS_NFITEMIMPOST, 'CD_OPERADOR', itemXmlF('CD_USUARIO', PARAM_GLB));
              putitem_e(tFIS_NFITEMIMPOST, 'DT_CADASTRO', Now);
              putitem_e(tFIS_NFITEMIMPOST, 'CD_CST', itemXmlF('CD_CST', vDsRegistro));

              if (item_f('CD_IMPOSTO', tFIS_NFITEMIMPOST) <> 4) then begin
                if (item_f('CD_IMPOSTO', tFIS_NFITEMIMPOST) = 3) then begin
                  vVlFator := 1;

                end else begin
                  vVlFator := vVlFatorLiquido;
                end;
                if (vVlFator > 1) then begin
                  putitem_e(tFIS_NFITEMIMPOST, 'VL_BASECALC', item_f('VL_BASECALC', tFIS_NFITEMIMPOST) * vVlFator);
                  putitem_e(tFIS_NFITEMIMPOST, 'VL_ISENTO', item_f('VL_ISENTO', tFIS_NFITEMIMPOST) * vVlFator);
                  putitem_e(tFIS_NFITEMIMPOST, 'VL_OUTRO', item_f('VL_OUTRO', tFIS_NFITEMIMPOST) * vVlFator);
                  putitem_e(tFIS_NFITEMIMPOST, 'VL_IMPOSTO', item_f('VL_IMPOSTO', tFIS_NFITEMIMPOST) * vVlFator);
                end;
              end;
              if (item_f('CD_IMPOSTO', tFIS_NFITEMIMPOST) = 1) then begin
                putitem_e(tFIS_NF, 'VL_BASEICMS', item_f('VL_BASEICMS', tFIS_NF) + item_f('VL_BASECALC', tFIS_NFITEMIMPOST));
                putitem_e(tFIS_NF, 'VL_ICMS', item_f('VL_ICMS', tFIS_NF) + item_f('VL_IMPOSTO', tFIS_NFITEMIMPOST));

                if (item_f('VL_BASECALC', tFIS_NFITEMIMPOST) > 0) then begin
                  creocc(tTMP_CSTALIQ, -1);
                  putitem_o(tTMP_CSTALIQ, 'CD_CST', item_f('CD_CST', tFIS_NFITEM));
                  putitem_o(tTMP_CSTALIQ, 'PR_ALIQUOTA', item_f('PR_ALIQUOTA', tFIS_NFITEMIMPOST));
                  retrieve_o(tTMP_CSTALIQ);
                  if (xStatus = -7) then begin
                    retrieve_x(tTMP_CSTALIQ);
                  end;
                  putitem_e(tTMP_CSTALIQ, 'VL_BASECALC', item_f('VL_BASECALC', tTMP_CSTALIQ) + item_f('VL_BASECALC', tFIS_NFITEMIMPOST));
                  putitem_e(tTMP_CSTALIQ, 'VL_IMPOSTO', item_f('VL_IMPOSTO', tTMP_CSTALIQ) + item_f('VL_IMPOSTO', tFIS_NFITEMIMPOST));
                end;
                if (item_f('CD_DECRETO', tFIS_NFITEM) = 6142) then begin
                  vVlDiferimento := item_f('VL_BASECALC', tFIS_NFITEMIMPOST) * item_f('PR_ALIQUOTA', tFIS_NFITEMIMPOST) / 100;
                  vVlDiferimento := rounded(vVlDiferimento, 6);
                  gVlICMSDiferido := gVlICMSDiferido + vVlDiferimento;
                end;
                creocc(tTMP_K02, -1);
                putitem_e(tTMP_K02, 'NR_CHAVE01', item_f('CD_IMPOSTO', tFIS_NFITEMIMPOST));
                putitem_e(tTMP_K02, 'NR_CHAVE02', curocc(tFIS_NFITEM));
                putitem_e(tTMP_K02, 'VL_GERAL', item_f('VL_IMPOSTO', tFIS_NFITEMIMPOST));
                putitem_e(tTMP_K02, 'PR_REDUBASE', item_f('PR_REDUBASE', tFIS_NFITEMIMPOST));
              end;
              if (item_f('CD_IMPOSTO', tFIS_NFITEMIMPOST) = 2) then begin
                putitem_e(tFIS_NF, 'VL_BASEICMSSUBS', item_f('VL_BASEICMSSUBS', tFIS_NF) + item_f('VL_BASECALC', tFIS_NFITEMIMPOST));
                putitem_e(tFIS_NF, 'VL_ICMSSUBST', item_f('VL_ICMSSUBST', tFIS_NF) + item_f('VL_IMPOSTO', tFIS_NFITEMIMPOST));
                creocc(tTMP_K02, -1);
                putitem_e(tTMP_K02, 'NR_CHAVE01', item_f('CD_IMPOSTO', tFIS_NFITEMIMPOST));
                putitem_e(tTMP_K02, 'NR_CHAVE02', curocc(tFIS_NFITEM));
                putitem_e(tTMP_K02, 'VL_GERAL', item_f('VL_IMPOSTO', tFIS_NFITEMIMPOST));
              end;
              if (item_f('CD_IMPOSTO', tFIS_NFITEMIMPOST) = 3) then begin
                putitem_e(tFIS_NF, 'VL_IPI', item_f('VL_IPI', tFIS_NF) + item_f('VL_IMPOSTO', tFIS_NFITEMIMPOST));
                creocc(tTMP_K02, -1);
                putitem_e(tTMP_K02, 'NR_CHAVE01', item_f('CD_IMPOSTO', tFIS_NFITEMIMPOST));
                putitem_e(tTMP_K02, 'NR_CHAVE02', curocc(tFIS_NFITEM));
                putitem_e(tTMP_K02, 'VL_GERAL', item_f('VL_IMPOSTO', tFIS_NFITEMIMPOST));
              end;

              vCdCST := copy(item_a('CD_CST', tFIS_NFITEM),2,2);
              if ((vCdCST = '10') or (vCdCST = '30') or (vCdCST = '60') or (vCdCST = '70')) and (gInSubstituicao = False) then begin
                gInSubstituicao := True;
              end;
            end;
            delitemGld(vDsLstImposto, 1);
          until (vDsLstImposto = '');
        end;
      end else begin
        viParams := '';
        putitemXml(viParams, 'CD_EMPRESA', item_f('CD_EMPFAT', tTRA_TRANSACAO));
        putitemXml(viParams, 'UF_DESTINO', item_a('DS_SIGLAESTADO', tTRA_REMDES));
        putitemXml(viParams, 'TP_ORIGEMEMISSAO', item_f('TP_ORIGEMEMISSAO', tTRA_TRANSACAO));
        if (item_a('CD_ESPECIE', tFIS_NFITEM) = gCdEspecieServico) then begin
          putitemXml(viParams, 'CD_SERVICO', item_f('CD_PRODUTO', tFIS_NFITEM));
        end else if (item_a('TP_MODALIDADE', tGER_S_OPERACAO) = 'A') then begin
          putitemXml(viParams, 'CD_MPTER', item_f('CD_PRODUTO', tFIS_NFITEM));
        end else begin
          putitemXml(viParams, 'CD_PRODUTO', item_f('CD_PRODUTO', tFIS_NFITEMPROD));
        end;
        putitemXml(viParams, 'CD_OPERACAO', item_f('CD_OPERACAO', tGER_S_OPERACAO));
        putitemXml(viParams, 'CD_PESSOA', item_f('CD_PESSOA', tTRA_REMDES));
        putitemXml(viParams, 'CD_CST', item_f('CD_CST', tFIS_NFITEM));
        putitemXml(viParams, 'VL_TOTALBRUTO', item_f('VL_TOTALBRUTO', tFIS_NFITEM));
        putitemXml(viParams, 'VL_TOTALLIQUIDO', item_f('VL_TOTALLIQUIDO', tFIS_NFITEM));
        putitemXml(viParams, 'TP_MODDCTOFISCAL', item_f('TP_MODDCTOFISCAL', tFIS_NF));
        putitemXml(viParams, 'NR_CODIGOFISCAL', gNrCodFiscal);
        putitemXml(viParams, 'DT_INIVIGENCIA', item_a('DT_EMISSAO', tFIS_NF));
        voParams := activateCmp('FISSVCO015', 'calculaImpostoItem', viParams);
        if (xStatus < 0) then begin
          Result := voParams; exit;
        end;

        vDsLstImposto := itemXml('DS_LSTIMPOSTO', voParams);
        vCdCST := itemXml('CD_CST', voParams);
        vCdDecreto := itemXmlF('CD_DECRETO', voParams);

        if (vDsLstImposto <> '') then begin
          repeat
            getitem(vDsRegistro, vDsLstImposto, 1);

            creocc(tFIS_NFITEMIMPOST, -1);
            getlistitensocc_e(vDsRegistro, tFIS_NFITEMIMPOST);
            putitem_e(tFIS_NFITEMIMPOST, 'CD_EMPFAT', item_f('CD_EMPFAT', tTRA_TRANSACAO));
            putitem_e(tFIS_NFITEMIMPOST, 'CD_GRUPOEMPRESA', item_f('CD_GRUPOEMPRESA', tTRA_TRANSACAO));
            putitem_e(tFIS_NFITEMIMPOST, 'CD_OPERADOR', itemXmlF('CD_USUARIO', PARAM_GLB));
            putitem_e(tFIS_NFITEMIMPOST, 'DT_CADASTRO', Now);

            if (item_f('CD_IMPOSTO', tFIS_NFITEMIMPOST) <> 4) then begin
              if (item_f('CD_IMPOSTO', tFIS_NFITEMIMPOST) = 3) then begin
                vVlFator := 1;
              end else begin
                vVlFator := vVlFatorLiquido;
              end;
              if (vVlFator > 1) then begin
                putitem_e(tFIS_NFITEMIMPOST, 'VL_BASECALC', item_f('VL_BASECALC', tFIS_NFITEMIMPOST) * vVlFator);
                putitem_e(tFIS_NFITEMIMPOST, 'VL_ISENTO', item_f('VL_ISENTO', tFIS_NFITEMIMPOST) * vVlFator);
                putitem_e(tFIS_NFITEMIMPOST, 'VL_OUTRO', item_f('VL_OUTRO', tFIS_NFITEMIMPOST) * vVlFator);
                putitem_e(tFIS_NFITEMIMPOST, 'VL_IMPOSTO', item_f('VL_IMPOSTO', tFIS_NFITEMIMPOST) * vVlFator);
              end;
            end;
            if (item_f('CD_IMPOSTO', tFIS_NFITEMIMPOST) = 1) then begin
              if (item_f('VL_BASECALC', tFIS_NFITEMIMPOST) > 0) then begin
                creocc(tTMP_CSTALIQ, -1);
                putitem_o(tTMP_CSTALIQ, 'CD_CST', vCdCST);
                putitem_o(tTMP_CSTALIQ, 'PR_ALIQUOTA', item_f('PR_ALIQUOTA', tFIS_NFITEMIMPOST));
                retrieve_o(tTMP_CSTALIQ);
                if (xStatus = -7) then begin
                  retrieve_x(tTMP_CSTALIQ);
                end;
                putitem_e(tTMP_CSTALIQ, 'VL_BASECALC', item_f('VL_BASECALC', tTMP_CSTALIQ) + item_f('VL_BASECALC', tFIS_NFITEMIMPOST));
                putitem_e(tTMP_CSTALIQ, 'VL_IMPOSTO', item_f('VL_IMPOSTO', tTMP_CSTALIQ) + item_f('VL_IMPOSTO', tFIS_NFITEMIMPOST));
              end;
              putitem_e(tFIS_NF, 'VL_BASEICMS', item_f('VL_BASEICMS', tFIS_NF) + item_f('VL_BASECALC', tFIS_NFITEMIMPOST));
              putitem_e(tFIS_NF, 'VL_ICMS', item_f('VL_ICMS', tFIS_NF) + item_f('VL_IMPOSTO', tFIS_NFITEMIMPOST));
              if (vCdDecreto = 6142) then begin
                vVlDiferimento := item_f('VL_BASECALC', tFIS_NFITEMIMPOST) * item_f('PR_ALIQUOTA', tFIS_NFITEMIMPOST) / 100;
                vVlDiferimento := rounded(vVlDiferimento, 6);
                gVlICMSDiferido := gVlICMSDiferido + vVlDiferimento;
              end;
              creocc(tTMP_K02, -1);
              putitem_e(tTMP_K02, 'NR_CHAVE01', item_f('CD_IMPOSTO', tFIS_NFITEMIMPOST));
              putitem_e(tTMP_K02, 'NR_CHAVE02', curocc(tFIS_NFITEM));
              putitem_e(tTMP_K02, 'VL_GERAL', item_f('VL_IMPOSTO', tFIS_NFITEMIMPOST));
              putitem_e(tTMP_K02, 'PR_REDUBASE', item_f('PR_REDUBASE', tFIS_NFITEMIMPOST));
            end;
            if (item_f('CD_IMPOSTO', tFIS_NFITEMIMPOST) = 2) then begin
              putitem_e(tFIS_NF, 'VL_BASEICMSSUBS', item_f('VL_BASEICMSSUBS', tFIS_NF) + item_f('VL_BASECALC', tFIS_NFITEMIMPOST));
              putitem_e(tFIS_NF, 'VL_ICMSSUBST', item_f('VL_ICMSSUBST', tFIS_NF) + item_f('VL_IMPOSTO', tFIS_NFITEMIMPOST));
              creocc(tTMP_K02, -1);
              putitem_e(tTMP_K02, 'NR_CHAVE01', item_f('CD_IMPOSTO', tFIS_NFITEMIMPOST));
              putitem_e(tTMP_K02, 'NR_CHAVE02', curocc(tFIS_NFITEM));
              putitem_e(tTMP_K02, 'VL_GERAL', item_f('VL_IMPOSTO', tFIS_NFITEMIMPOST));
            end;
            if (item_f('CD_IMPOSTO', tFIS_NFITEMIMPOST) = 3) then begin
              putitem_e(tFIS_NF, 'VL_IPI', item_f('VL_IPI', tFIS_NF) + item_f('VL_IMPOSTO', tFIS_NFITEMIMPOST));
              creocc(tTMP_K02, -1);
              putitem_e(tTMP_K02, 'NR_CHAVE01', item_f('CD_IMPOSTO', tFIS_NFITEMIMPOST));
              putitem_e(tTMP_K02, 'NR_CHAVE02', curocc(tFIS_NFITEM));
              putitem_e(tTMP_K02, 'VL_GERAL', item_f('VL_IMPOSTO', tFIS_NFITEMIMPOST));
            end;

            delitemGld(vDsLstImposto, 1);
          until (vDsLstImposto = '');
        end;
      end;
      if (empty(tFIS_NFITEMIMPOST) = False) and (gInNFe = True) then begin
        setocc(tFIS_NFITEMIMPOST, 1);
        while (xStatus >= 0) do begin
          if (item_f('CD_IMPOSTO', tFIS_NFITEMIMPOST) = 1) then begin
            if (gInArredondaTruncaIcms = True) then begin
              putitem_e(tFIS_NFITEMIMPOST, 'VL_BASECALC', rounded(item_f('VL_BASECALC', tFIS_NFITEMIMPOST), 2));
              putitem_e(tFIS_NFITEMIMPOST, 'VL_IMPOSTO', rounded(item_f('VL_IMPOSTO', tFIS_NFITEMIMPOST), 2));
            end else begin
              vVlCalc := item_f('VL_BASECALC', tFIS_NFITEMIMPOST) * 100;
              vVlCalc := int(vVlCalc);
              putitem_e(tFIS_NFITEMIMPOST, 'VL_BASECALC', vVlCalc / 100);
              vVlCalc := item_f('VL_IMPOSTO', tFIS_NFITEMIMPOST) * 100;
              vVlCalc := int(vVlCalc);
              putitem_e(tFIS_NFITEMIMPOST, 'VL_IMPOSTO', vVlCalc / 100);
            end;
            vVlBaseICMS2 := vVlBaseICMS2 + item_f('VL_BASECALC', tFIS_NFITEMIMPOST);
            vVlICMS2 := vVlICMS2 + item_f('VL_IMPOSTO', tFIS_NFITEMIMPOST);
          end;
          if (item_f('CD_IMPOSTO', tFIS_NFITEMIMPOST) = 2) then begin
            if (gInArredondaTruncaIcms = True) then begin
              putitem_e(tFIS_NFITEMIMPOST, 'VL_BASECALC', rounded(item_f('VL_BASECALC', tFIS_NFITEMIMPOST), 2));
              putitem_e(tFIS_NFITEMIMPOST, 'VL_IMPOSTO', rounded(item_f('VL_IMPOSTO', tFIS_NFITEMIMPOST), 2));
            end else begin
              vVlCalc := item_f('VL_BASECALC', tFIS_NFITEMIMPOST) * 100;
              vVlCalc := int(vVlCalc);
              putitem_e(tFIS_NFITEMIMPOST, 'VL_BASECALC', vVlCalc / 100);
              vVlCalc := item_f('VL_IMPOSTO', tFIS_NFITEMIMPOST) * 100;
              vVlCalc := int(vVlCalc);
              putitem_e(tFIS_NFITEMIMPOST, 'VL_IMPOSTO', vVlCalc / 100);
            end;
            vVlBaseICMSSubst2 := vVlBaseICMSSubst2 + item_f('VL_BASECALC', tFIS_NFITEMIMPOST);
            vVlICMSSubst2 := vVlICMSSubst2 + item_f('VL_IMPOSTO', tFIS_NFITEMIMPOST);
          end;
          if (item_f('CD_IMPOSTO', tFIS_NFITEMIMPOST) = 3) then begin
            if (gInArredondaTruncaIcms = True) then begin
              putitem_e(tFIS_NFITEMIMPOST, 'VL_BASECALC', rounded(item_f('VL_BASECALC', tFIS_NFITEMIMPOST), 2));
              putitem_e(tFIS_NFITEMIMPOST, 'VL_IMPOSTO', rounded(item_f('VL_IMPOSTO', tFIS_NFITEMIMPOST), 2));
            end else begin
              vVlCalc := item_f('VL_BASECALC', tFIS_NFITEMIMPOST) * 100;
              vVlCalc := int(vVlCalc);
              putitem_e(tFIS_NFITEMIMPOST, 'VL_BASECALC', vVlCalc / 100);
              vVlCalc := item_f('VL_IMPOSTO', tFIS_NFITEMIMPOST) * 100;
              vVlCalc := int(vVlCalc);
              putitem_e(tFIS_NFITEMIMPOST, 'VL_IMPOSTO', vVlCalc / 100);
            end;
            vVlIPI2 := vVlIPI2 + item_f('VL_IMPOSTO', tFIS_NFITEMIMPOST);
          end;

          setocc(tFIS_NFITEMIMPOST, curocc(tFIS_NFITEMIMPOST) + 1);
        end;
      end;
      if (gInGravaDsDecretoObsNf = True) and (item_f('CD_DECRETO', tFIS_NFITEM) > 0) then begin
        creocc(tFIS_DECRETO, -1);
        putitem_o(tFIS_DECRETO, 'CD_DECRETO', item_f('CD_DECRETO', tFIS_NFITEM));
        retrieve_o(tFIS_DECRETO);
        if (xStatus = -7) then begin
          retrieve_x(tFIS_DECRETO);
        end;
      end;

      voParams := tFIS_NFITEMPROD.Salvar();
      if (xStatus < 0) then begin
        Result := voParams;
        return(-1); exit;
      end;

      voParams := tFIS_NFITEMIMPOST.Salvar();
      if (xStatus < 0) then begin
        Result := voParams;
        return(-1); exit;
      end;

      setocc(tFIS_NFITEM, curocc(tFIS_NFITEM) + 1);
    end;
    if (gInNFe = True) then begin
      sort_e(tTMP_K02, 'NR_CHAVE01:a;PR_REDUBASE:d;VL_GERAL:d');

      vNrOccICMS := 0;
      vNrOccSubst := 0;
      vNrOccIPI := 0;

      setocc(tTMP_K02, 1);
      while (xStatus >= 0) do begin
        if (item_f('NR_CHAVE01', tTMP_K02) = 1) and (vNrOccICMS = 0) then begin
          vNrOccICMS := curocc(tTMP_K02);
        end;
        if (item_f('NR_CHAVE01', tTMP_K02) = 2) and (vNrOccSubst = 0) then begin
          vNrOccSubst := curocc(tTMP_K02);
        end;
        if (item_f('NR_CHAVE01', tTMP_K02) = 3) and (vNrOccIPI = 0) then begin
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
          creocc(tFIS_NFITEMIMPOST, -1);
          putitem_o(tFIS_NFITEMIMPOST, 'CD_IMPOSTO', 1);
          retrieve_o(tFIS_NFITEMIMPOST);
          if (xStatus = 4) then begin
            putitem_e(tFIS_NFITEMIMPOST, 'VL_BASECALC', item_f('VL_BASECALC', tFIS_NFITEMIMPOST) + vVlAplicado);
          end else begin
            discard(tFIS_NFITEMIMPOST);
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
          creocc(tFIS_NFITEMIMPOST, -1);
          putitem_o(tFIS_NFITEMIMPOST, 'CD_IMPOSTO', 1);
          retrieve_o(tFIS_NFITEMIMPOST);
          if (xStatus = 4) then begin
            putitem_e(tFIS_NFITEMIMPOST, 'VL_IMPOSTO', item_f('VL_IMPOSTO', tFIS_NFITEMIMPOST) + vVlAplicado);
          end else begin
            discard(tFIS_NFITEMIMPOST);
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
          creocc(tFIS_NFITEMIMPOST, -1);
          putitem_o(tFIS_NFITEMIMPOST, 'CD_IMPOSTO', 2);
          retrieve_o(tFIS_NFITEMIMPOST);
          if (xStatus = 4) then begin
            putitem_e(tFIS_NFITEMIMPOST, 'VL_BASECALC', item_f('VL_BASECALC', tFIS_NFITEMIMPOST) + vVlAplicado);
          end else begin
            discard(tFIS_NFITEMIMPOST);
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
          creocc(tFIS_NFITEMIMPOST, -1);
          putitem_o(tFIS_NFITEMIMPOST, 'CD_IMPOSTO', 2);
          retrieve_o(tFIS_NFITEMIMPOST);
          if (xStatus = 4) then begin
            putitem_e(tFIS_NFITEMIMPOST, 'VL_IMPOSTO', item_f('VL_IMPOSTO', tFIS_NFITEMIMPOST) + vVlAplicado);
          end else begin
            discard(tFIS_NFITEMIMPOST);
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
          creocc(tFIS_NFITEMIMPOST, -1);
          putitem_o(tFIS_NFITEMIMPOST, 'CD_IMPOSTO', 3);
          retrieve_o(tFIS_NFITEMIMPOST);
          if (xStatus = 4) then begin
            putitem_e(tFIS_NFITEMIMPOST, 'VL_IMPOSTO', item_f('VL_IMPOSTO', tFIS_NFITEMIMPOST) + vVlAplicado);
          end else begin
            discard(tFIS_NFITEMIMPOST);
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
    if (item_a('TP_FRETE', tTRA_TRANSPORT) = '') then begin
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
  vDtSistema : TDateTime;
begin
  vDtSistema := itemXmlD('DT_SISTEMA', PARAM_GLB);

  if (item_b('IN_FINANCEIRO', tGER_S_OPERACAO) <> True) and (item_b('IN_FINANCEIRO', tGER_OPERACAO) <> True) then begin
    return(0); exit;
  end;

  viParams := '';
  putitemXml(viParams, 'CD_EMPRESA', item_f('CD_EMPRESA', tTRA_TRANSACAO));
  putitemXml(viParams, 'NR_TRANSACAO', item_f('NR_TRANSACAO', tTRA_TRANSACAO));
  putitemXml(viParams, 'DT_TRANSACAO', item_a('DT_TRANSACAO', tTRA_TRANSACAO));
  voParams := activateCmp('GERSVCO058', 'buscaValorFinanceiroTransacao', viParams); 
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

  if (empty(tTRA_VENCIMENTO) = False) then begin
    setocc(tTRA_VENCIMENTO, 1);
    while (xStatus >= 0) do begin
      vNrParcela := vNrParcela + 1;

      vVlCalc := (item_f('VL_PARCELA', tTRA_VENCIMENTO) / vVlFinanceiro) * vVlNota;

      vVlParcela := rounded(vVlCalc, 2);
      vVlResto := vVlResto - vVlParcela;

      creocc(tFIS_NFVENCTO, -1);
      putitem_e(tFIS_NFVENCTO, 'NR_PARCELA', vNrParcela);
      putitem_e(tFIS_NFVENCTO, 'CD_EMPFAT', item_f('CD_EMPFAT', tTRA_TRANSACAO));
      putitem_e(tFIS_NFVENCTO, 'CD_GRUPOEMPRESA', item_f('CD_GRUPOEMPRESA', tTRA_TRANSACAO));
      putitem_e(tFIS_NFVENCTO, 'CD_OPERADOR', itemXmlF('CD_USUARIO', PARAM_GLB));
      putitem_e(tFIS_NFVENCTO, 'DT_CADASTRO', Now);
      putitem_e(tFIS_NFVENCTO, 'VL_PARCELA', vVlParcela);
      putitem_e(tFIS_NFVENCTO, 'DT_VENCIMENTO', item_a('DT_VENCIMENTO', tTRA_VENCIMENTO));
      if (item_d('DT_VENCIMENTO', tFIS_NFVENCTO) < vDtSistema) then begin
        putitem_e(tFIS_NFVENCTO, 'DT_VENCIMENTO', vDtSistema);
      end;
      putitem_e(tFIS_NFVENCTO, 'TP_FORMAPGTO', item_f('TP_FORMAPGTO', tTRA_VENCIMENTO));

      setocc(tTRA_VENCIMENTO, curocc(tTRA_VENCIMENTO) + 1);
    end;
    if (vVlResto <> 0) then begin
      setocc(tFIS_NFVENCTO, 1);
      putitem_e(tFIS_NFVENCTO, 'VL_PARCELA', item_f('VL_PARCELA', tFIS_NFVENCTO) + vVlResto);
    end;
  end else begin
    //Result := SetStatus(STS_ERROR, 'GEN001', 'Transação ' + item_a('CD_EMPFAT', tTRA_TRANSACAO) + ' / ' + item_a('NR_TRANSACAO', tTRA_TRANSACAO) + ' não possui parcelamento!', cDS_METHOD);
    //return(-1); exit;
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
    voParams := activateCmp('TRASVCO004', 'gravaEnderecoTransacao', viParams);
    if (xStatus < 0) then begin
      Result := voParams;
      return(-1); exit;
    end;

    clear_e(tTRA_REMDES);
    retrieve_e(tTRA_REMDES);
    if (xStatus < 0) then begin
      Result := SetStatus(STS_ERROR, 'GEN001', 'Transação ' + item_a('CD_EMPFAT', tTRA_TRANSACAO) + ' / ' + item_a('NR_TRANSACAO', tTRA_TRANSACAO) + ' não possui dados do emitende/destinatário!', cDS_METHOD);
      return(-1); exit;
    end;
  end;

  creocc(tFIS_NFREMDES, -1);
  putitem_e(tFIS_NFREMDES, 'CD_EMPFAT', item_f('CD_EMPFAT', tTRA_TRANSACAO));
  putitem_e(tFIS_NFREMDES, 'CD_GRUPOEMPRESA', item_f('CD_GRUPOEMPRESA', tTRA_TRANSACAO));
  putitem_e(tFIS_NFREMDES, 'CD_OPERADOR', itemXmlF('CD_USUARIO', PARAM_GLB));
  putitem_e(tFIS_NFREMDES, 'DT_CADASTRO', Now);
  putitem_e(tFIS_NFREMDES, 'NM_NOME', item_a('NM_NOME', tTRA_REMDES));
  putitem_e(tFIS_NFREMDES, 'TP_PESSOA', item_a('TP_PESSOA', tTRA_REMDES));
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
  if (empty(tTRA_TRANSACECF) = False) then begin
    creocc(tFIS_NFECF, -1);
    putitem_e(tFIS_NFECF, 'CD_EMPECF', item_f('CD_EMPECF', tTRA_TRANSACECF));
    putitem_e(tFIS_NFECF, 'NR_ECF', item_f('NR_ECF', tTRA_TRANSACECF));
    putitem_e(tFIS_NFECF, 'CD_EMPFAT', item_f('CD_EMPFAT', tTRA_TRANSACAO));
    putitem_e(tFIS_NFECF, 'CD_GRUPOEMPRESA', item_f('CD_GRUPOEMPRESA', tTRA_TRANSACAO));
    putitem_e(tFIS_NFECF, 'CD_OPERADOR', itemXmlF('CD_USUARIO', PARAM_GLB));
    putitem_e(tFIS_NFECF, 'DT_CADASTRO', Now);
    putitem_e(tFIS_NFECF, 'NR_CUPOM', item_f('NR_CUPOM', tTRA_TRANSACECF));
  end;

  return(0); exit;
end;

//--------------------------------------------------------------
function T_FISSVCO004.geraObservacao(pParams : String) : String;
//--------------------------------------------------------------
const
  cDS_METHOD = 'ADICIONAL=Operação: T_FISSVCO004.geraObservacao()';
var
  pDsLinhaObs,
  vDsLinha, vDsAdicional, vDsLinhaObs, vDsDecreto, viParams, voParams, vDsLinhaAux : String;
  vNrLinha, vNrPos, vNrPosDecreto : Real;
begin
  pDsLinhaObs := itemXml('DS_LINHAOBS', pParams);
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
        vDsLinha := 'ICMS DIF.PARC. EM 33, 33% CONF.ART. 96 INCISO I DO RICMS-PR: ' + FloatToStr(gVlICMSDiferido);
        putitem_e(tOBS_NF, 'CD_OPERADOR', itemXmlF('CD_USUARIO', PARAM_GLB));
        putitem_e(tOBS_NF, 'DT_CADASTRO', Now);
        putitem_e(tOBS_NF, 'DS_OBSERVACAO', copy(vDsLinha,1,80));
      end;
    end;
    if (empty(tTMP_CSTALIQ) = False) and (item_f('TP_ORIGEMEMISSAO', tTRA_TRANSACAO) = 1) then begin
      if (gInExibeResumoCstNF = True) then begin
        setocc(tTMP_CSTALIQ, 1);
        while (xStatus >= 0) do begin
          creocc(tOBS_NF, -1);
          vNrLinha := vNrLinha + 1;
          putitem_e(tOBS_NF, 'NR_LINHA', vNrLinha);
          putitem_e(tOBS_NF, 'CD_EMPFAT', item_f('CD_EMPFAT', tTRA_TRANSACAO));
          putitem_e(tOBS_NF, 'CD_GRUPOEMPRESA', item_f('CD_GRUPOEMPRESA', tTRA_TRANSACAO));
          vDsLinha := 'CST ' + item_a('CD_CST', tTMP_CSTALIQ) + ' ICMS ' + item_a('PR_ALIQUOTA', tTMP_CSTALIQ);
          gVlBaseCalc := rounded(item_f('VL_BASECALC', tTMP_CSTALIQ), 2);
          gVlImposto := rounded(item_f('VL_IMPOSTO', tTMP_CSTALIQ), 2);
          vDsLinha := vDsLinha + ' ' + FloatToStr(gVlBaseCalc) + ' = ' + FloatToStr(gVlImposto);
          putitem_e(tOBS_NF, 'CD_OPERADOR', itemXmlF('CD_USUARIO', PARAM_GLB));
          putitem_e(tOBS_NF, 'DT_CADASTRO', Now);
          putitem_e(tOBS_NF, 'DS_OBSERVACAO', copy(vDsLinha,1,80));
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
            vDsLinha := 'CFOP ' + item_a('NR_GERAL', tF_TMP_NR09) + ' = ' + FloatToStr(gVlImposto) + ' QT: ' + item_a('QT_ITEM', tF_TMP_NR09);
          end else begin
            vDsLinha := 'CFOP ' + item_a('NR_GERAL', tF_TMP_NR09) + ' = ' + FloatToStr(gVlImposto);
          end;
          putitem_e(tOBS_NF, 'CD_OPERADOR', itemXmlF('CD_USUARIO', PARAM_GLB));
          putitem_e(tOBS_NF, 'DT_CADASTRO', Now);
          putitem_e(tOBS_NF, 'DS_OBSERVACAO', copy(vDsLinha,1,80));
          setocc(tF_TMP_NR09, curocc(tF_TMP_NR09) + 1);
        end;
      end;
    end;
  end;
  if (gDsAdicionalRegra <> '') and (item_f('TP_ORIGEMEMISSAO', tTRA_TRANSACAO) = 1) then begin
    if (empty_e(tOBS_TRANSACNF) = 1) then begin
      vDsAdicional := gDsAdicionalRegra;
      while(vDsAdicional <> '') do begin
        scan(vDsAdicional, #13);
        if (xResult > 0) then begin
          vDsLinha := copy(vDsAdicional, 1, round(xResult) - 1);
          vDsAdicional := copy(vDsAdicional, round(xResult) + 1, length(vDsAdicional));
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
        putitem_e(tOBS_NF, 'DS_OBSERVACAO', copy(vDsLinha,1,80));
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
      putitem_e(tOBS_NF, 'DS_OBSERVACAO', copy(item_a('DS_OBSERVACAO', tOBS_TRANSACNF),1,80));
      setocc(tOBS_TRANSACNF, curocc(tOBS_TRANSACNF) + 1);
    end;
  end;

  if not (empty(tFIS_DECRETO)) and (gInGravaDsDecretoObsNf = True) then begin
    setocc(tFIS_DECRETO, -1);
    setocc(tFIS_DECRETO, 1);
    while (xStatus >= 0) do begin
      vDsDecreto := item_a('DS_DECRETO', tFIS_DECRETO);

      while (vDsDecreto <> '') do begin
        vNrPosDecreto := 80;
        if (copy(vDsDecreto,80,1) <> '') then begin
          if (copy(vDsDecreto,80,1) <> ' ') and (copy(vDsDecreto,81,1) <> ' ') then begin
            while (vDsDecreto[round(vNrPosDecreto)] <> ' ') and (vNrPosDecreto > 0) do begin
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
        putitem_e(tOBS_NF, 'DS_OBSERVACAO', copy(vDsDecreto, 1, round(vNrPosDecreto)));
        vNrPosDecreto := vNrPosDecreto + 1;
        vDsDecreto := copy(vDsDecreto, round(vNrPosDecreto), length(vDsDecreto));
      end;

      setocc(tFIS_DECRETO, curocc(tFIS_DECRETO) + 1);
    end;
  end;
  if (gInIncluiIpiDevSimp = True) and (item_f('TP_MODALIDADE', tGER_OPERACAO) = 3)and(gInOptSimples = True) and (item_f('VL_IPI', tFIS_NF) > 0) then begin
    vDsLinha := 'VALOR DO IPI: Rg ' + item_a('VL_IPI', tFIS_NF) + '';

    creocc(tOBS_NF, -1);
    vNrLinha := vNrLinha + 1;
    putitem_e(tOBS_NF, 'NR_LINHA', vNrLinha);
    putitem_e(tOBS_NF, 'CD_EMPFAT', item_f('CD_EMPFAT', tFIS_NF));
    putitem_e(tOBS_NF, 'CD_GRUPOEMPRESA', item_f('CD_GRUPOEMPRESA', tFIS_NF));
    putitem_e(tOBS_NF, 'CD_OPERADOR', itemXmlF('CD_USUARIO', PARAM_GLB));
    putitem_e(tOBS_NF, 'DT_CADASTRO', Now);
    putitem_e(tOBS_NF, 'DS_OBSERVACAO', copy(vDsLinha,1,80));
  end;
  if (gInGravaObsNf = True) then begin
    vDsLinhaAux := gDsObsNf;
    while (vDsLinhaAux <> '') do begin
      vNrPos := 80;
      if (copy(vDsLinhaAux,80,1) <> '') then begin
        if (copy(vDsLinhaAux,80,1) <> ' ') and (copy(vDsLinhaAux,81,1) <> ' ') then begin
          while (vDsLinhaAux[round(vNrPos)] <> ' ') and (vNrPos > 0) do begin
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
      putitem_e(tOBS_NF, 'DS_OBSERVACAO', copy(vDsLinhaAux,1,round(vNrPos)));
      vNrPos := vNrPos + 1;
      vDsLinhaAux := copy(vDsLinhaAux,round(vNrPos), length(vDsLinhaAux));
    end;
  end;

  return(0); exit;

end;

//-----------------------------------------------------------
function T_FISSVCO004.limpaString(pParams : String) : String;
//-----------------------------------------------------------
const
  cDS_METHOD = 'ADICIONAL=Operação: T_FISSVCO004.limpaString()';
var
  vDsString, vDsStringSaida, vChar : String;
  vTamanho, vPosicao : Real;
  vInValido : Boolean;
begin
  vDsString := pParams;
  vDsString := ReplaceStrS(vDsString, 'STRING ', '');

  vTamanho := length(vDsstring);
  if (vTamanho < 1) then begin
    return(0); exit;
  end;

  vPosicao := 0;
  vDsStringSaida := '';
  repeat
    vPosicao := vPosicao + 1;
    vInValido := True;
    vChar := vDsString[round(vPosicao)];
    if (vChar = '<') or (vChar = '>') or (vChar = '&') or (vChar = '"') or (vChar = '''') or (vChar = '%') or (vChar = '') or (vChar = '>') or (vChar = '<') or (vChar = '&') then begin
      vInValido := False;
    end;
    if (vInValido = True) then begin
      vDsStringSaida := vDsStringSaida + vChar;
    end;
  until (vPosicao >= vTamanho);

  Result := vDsStringSaida;
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
  vDsLstOperRef := ReplaceStr(vDsLstOperRef, ';', '|');
  if (vDsLstOperRef <> '') then begin
    repeat
      getitem(vCdOperacao, vDsLstOperRef, 1);
      if (item_a('CD_OPERACAO', tFIS_NF) = vCdOperacao) and (empty(tTRA_TRANREF)) then begin
        Result := SetStatus(STS_ERROR, 'GEN001', 'Operação ' + vCdOperacao + ' da NF precisa de NF referencial, parâmetro DS_LST_OPER_OBRIG_NF_REF!', cDS_METHOD);
        return(-1); exit;
      end;
      delitemGld(vDsLstOperRef, 1);
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
  piDsLstSelo, vDsRegistro : String;
begin
  piDsLstSelo := itemXml('DS_LSTSELO', pParams);

  if (piDsLstSelo <> '') then begin
    repeat
      getitem(vDsRegistro, piDsLstSelo, 1);

      putitem_e(tFIS_NFISELOENT, 'VL_BASECALC', item_f('VL_BASECALC', tFIS_NFISELOENT) + itemXmlF('VL_BASECALC', vDsRegistro));
      putitem_e(tFIS_NFISELOENT, 'VL_SUBTRIB', item_f('VL_SUBTRIB', tFIS_NFISELOENT) + itemXmlF('VL_SUBTRIB', vDsRegistro));
      putitem_e(tFIS_NFISELOENT, 'VL_IPI', item_f('VL_IPI', tFIS_NFISELOENT) + itemXmlF('VL_IPI', vDsRegistro));
      putitem_e(tFIS_NFISELOENT, 'VL_FRETE', item_f('VL_FRETE', tFIS_NFISELOENT) + itemXmlF('VL_FRETE', vDsRegistro));
      putitem_e(tFIS_NFISELOENT, 'VL_SEGURO', item_f('VL_SEGURO', tFIS_NFISELOENT) + itemXmlF('VL_SEGURO', vDsRegistro));
      putitem_e(tFIS_NFISELOENT, 'VL_DESPACESSOR', item_f('VL_DESPACESSOR', tFIS_NFISELOENT) + itemXmlF('VL_DESPACESSOR', vDsRegistro));
      putitem_e(tFIS_NFISELOENT, 'PR_ALIQUOTA', item_f('PR_ALIQUOTA', tFIS_NFISELOENT) + itemXmlF('PR_ALIQUOTA', vDsRegistro));
      putitem_e(tFIS_NFISELOENT, 'CD_OPERADOR', itemXmlF('CD_USUARIO', PARAM_GLB));
      putitem_e(tFIS_NFISELOENT, 'DT_CADASTRO', Now);

      delitemGld(piDsLstSelo, 1);
    until (piDsLstSelo = '');
    setocc(tFIS_NFISELOENT, 1);
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
  if (gInIncluiIpiDevSimp = True) and (item_f('TP_MODALIDADE', tGER_OPERACAO) = 3)and(gInOptSimples = True) and (item_f('VL_IPI', tFIS_NF) > 0) then begin
    setocc(tFIS_NFITEM, 1);
    while(xStatus >= 0) do begin

      setocc(tFIS_NFITEMIMPOST, 1);
      while(xStatus >= 0) do begin
        if (item_f('CD_IMPOSTO', tFIS_NFITEMIMPOST) = 3) then begin
          discard(tFIS_NFITEMIMPOST);
          break;
        end;
        setocc(tFIS_NFITEMIMPOST, curocc(tFIS_NFITEMIMPOST) + 1);
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
  vDtTransacao, vDtFatura : TDateTime;
begin
  vCdEmpresaTra := item_f('CD_EMPRESA', tTRA_TRANSACAO);
  vNrTransacao := item_f('NR_TRANSACAO', tTRA_TRANSACAO);
  vDtTransacao := item_d('DT_TRANSACAO', tTRA_TRANSACAO);
  vCdEmpresaNf := item_f('CD_EMPRESA', tFIS_NF);
  vNrFatura := item_f('NR_FATURA', tFIS_NF);
  vDtFatura := item_d('DT_FATURA', tFIS_NF);

  if (vCdEmpresaTra = 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN001', 'Empresa da transação não informada!', cDS_METHOD);
    return(-1); exit;
  end;
  if (vNrTransacao = 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN001', 'Número da transação não informado!', cDS_METHOD);
    return(-1); exit;
  end;
  if (vDtTransacao = 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN001', 'Data da transação não informada!', cDS_METHOD);
    return(-1); exit;
  end;
  if (vCdEmpresaNf = 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN001', 'Empresa da nota fiscal não informada!', cDS_METHOD);
    return(-1); exit;
  end;
  if (vNrFatura = 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN001', 'Número da fatura não informado!', cDS_METHOD);
    return(-1); exit;
  end;
  if (vDtFatura = 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN001', 'Data da fatura não informada!', cDS_METHOD);
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
  vDtTransacao : TDateTime;
  vRegistroNext, vDsLoteInf, vDsLstLoteInfGeral : String;
  vCdEmpLote, vNrLote, vNrItemLote, vNfInicial, vVlSubMaior, vNrItemSubMaior, VTPMODDOCTOFIS, vVlBaseIcmsSub : Real;
  vVlIcmsSub, vVlBaseIcms, vVlIcms, vVlIcmsMaior, vNrItemMaior, vVlCalcula, vVlBaseCalc, vConsulta : Real;
  vDsLstNotaFiscal, vLstNF, vDsLinhaObs, vDsLstSelo : String;
begin
  vDsLstNotaFiscal := '';
  vCdEmpresa := itemXmlF('CD_EMPRESA', pParams);
  vDsLstTransacao := itemXml('DS_LSTTRANSACAO', pParams);
  gInReemissao := itemXmlB('IN_REEMISSAO', pParams);
  gCdModeloNF := itemXmlF('CD_MODELONF', pParams);
  gNrNf := itemXmlF('NR_NF', pParams);
  gCdSerie := itemXmlF('CD_SERIE', pParams);
  gDtEmissao := itemXmlD('DT_EMISSAO', pParams);
  gDtSaidaEntrada := itemXmlD('DT_SAIDAENTRADA', pParams);
  gDtEntrega := itemXmlD('DT_ENTREGA', pParams);
  gDtFatura := itemXmlD('DT_FATURA', pParams);
  gHrSaida := itemXmlD('HR_SAIDA', pParams);
  gLstLoteInfGeral := '';
  gInItemLote := itemXmlB('IN_ITEMLOTE', pParams);
  gTinTinturaria := itemXmlF('TIN_TINTURARIA', PARAM_GLB);
  vTpContrInspSaldoLote := itemXmlF('TP_CONTR_INSP_SALDO_LOTE', PARAM_GLB);

  if (gDtSaidaEntrada = 0) then begin
    gDtSaidaEntrada := itemXmlD('DT_SISTEMA', PARAM_GLB);
  end;

  gTpModDctoFiscalLocal := itemXmlF('TP_MODDCTOFISCAL', pParams);
  gCdEspecieServico := itemXml('CD_ESPECIE_SERVICO_TRA', PARAM_GLB);
  gDsLstFatura := '';

  if (itemXml('IN_ITEMLOTE', pParams) = '') then begin
    if (vTpContrInspSaldoLote = 1) then begin
      gInItemLote := True;
    end else begin
      gInItemLote := False;
    end;
  end;
  if (vDsLstTransacao = '') then begin
    Result := SetStatus(STS_ERROR, 'GEN001', 'Lista de transação não informada!', cDS_METHOD);
    return(-1); exit;
  end;

  if (gDtEncerramento <> 0) and (gDtSaidaEntrada <> 0) then begin
    if (gDtSaidaEntrada <= gDtEncerramento) then begin
      Result := SetStatus(STS_ERROR, 'GEN001', 'NF/Fatura ' + item_a('NR_NF', tFIS_NF) + '/' + item_a('NR_FATURA', tFIS_NF) + ' possui data de movimento anterior ao encerramento do livro fiscal!', cDS_METHOD);
      return(-1); exit;
    end;
  end;

  vCdTipoClas := gCdTipoClas;

  clear_e(tPRD_TIPOCLAS);
  while (length(vCdTipoClas) > 0) do begin
    creocc(tPRD_TIPOCLAS, -1);
    scan(vCdTipoClas, ';');
    if (xResult > 0) then begin
      putitem_e(tPRD_TIPOCLAS, 'CD_TIPOCLAS', copy(vCdTipoClas, 1, round(xResult) - 1));
      vCdTipoClas := copy(vCdTipoClas, round(xResult) + 1, length(vCdTipoClas));
    end else begin
      putitem_e(tPRD_TIPOCLAS, 'CD_TIPOCLAS', vCdTipoClas);
      vCdTipoClas := '';
    end;
    retrieve_o(tPRD_TIPOCLAS);
    if (xStatus = -7) then begin
      retrieve_x(tPRD_TIPOCLAS);
    end else begin
      remocc(tPRD_TIPOCLAS);
    end;
    length(vCdTipoClas);
  end;

  clear_e(tFIS_NF);

  repeat
    getitem(vDsRegistro, vDsLstTransacao, 1);
    vCdEmpresa := itemXmlF('CD_EMPRESA', vDsRegistro);
    vNrTransacao := itemXmlF('NR_TRANSACAO', vDsRegistro);
    vDtTransacao := itemXmlD('DT_TRANSACAO', vDsRegistro);

    if (vCdEmpresa = 0) then begin
      Result := SetStatus(STS_ERROR, 'GEN001', 'Empresa não informada!', cDS_METHOD);
      return(-1); exit;
    end;
    if (vNrTransacao = 0) then begin
      Result := SetStatus(STS_ERROR, 'GEN001', 'Número da transação não informado!', cDS_METHOD);
      return(-1); exit;
    end;
    if (vDtTransacao = 0) then begin
      Result := SetStatus(STS_ERROR, 'GEN001', 'Número da transação não informado!', cDS_METHOD);
      return(-1); exit;
    end;

    clear_e(tTRA_TRANSACAO);
    putitem_o(tTRA_TRANSACAO, 'CD_EMPRESA', vCdEmpresa);
    putitem_o(tTRA_TRANSACAO, 'NR_TRANSACAO', vNrTransacao);
    putitem_o(tTRA_TRANSACAO, 'DT_TRANSACAO', vDtTransacao);
    retrieve_e(tTRA_TRANSACAO);
    if (xStatus < 0) then begin
      Result := SetStatus(STS_ERROR, 'GEN001', 'Transação ' + FloatToStr(vNrTransacao) + ' não cadastrada!', cDS_METHOD);
      return(-1); exit;
    end;

    viParams := '';
    putitemXml(viParams, 'CD_PESSOA', item_f('CD_PESSOA', tTRA_TRANSACAO));
    voParams := activateCmp('PESSVCO005', 'buscaDadosPessoa', viParams); 
    if (xStatus < 0) then begin
      Result := voParams;
      return(-1); exit;
    end;
    gTpRegimeTrib := itemXmlF('TP_REGIMETRIB', voParams);


		gInCalcTributo := False;
		if (gPrTotalTributo > 0) and (item_f('TP_ORIGEMEMISSAO' ,tTRA_TRANSACAO) = 1) and
       (itemXmlB('IN_CNSRFINAL', voParams) = True) or (itemXml('TP_PESSOA', voParams) = 'F') then begin
			gInCalcTributo := True;
    end;

    viParams := '';
    putitemXml(viParams, 'CD_CLIENTE', item_f('CD_PESSOA', tTRA_TRANSACAO));
    voParams := activateCmp('FISSVCO032', 'carregaPesCliente', viParams); 
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
        putitem_o(tGER_MODNFC, 'CD_MODELONF', gCdModeloNF);
        retrieve_e(tGER_MODNFC);
        if (xStatus >= 0) then begin
          if (item_a('IN_AGRUPA_GRUPO', tGER_MODNFC) = '') then begin
            Result := SetStatus(STS_ERROR, 'GEN001', 'Modelo de NF ' + FloatToStr(gCdModeloNF) + ' não possui tipo de agrupamento de item informado. Utilize o GERFM016 para cadastrar!', cDS_METHOD);
            return(-1); exit;
          end;
          if (item_f('TP_CODPRODUTO', tGER_MODNFC) = 0) then begin
            Result := SetStatus(STS_ERROR, 'GEN001', 'Modelo de NF ' + FloatToStr(gCdModeloNF) + ' não possui tipo de código de item informado. Utilize o GERFM016 para cadastrar!', cDS_METHOD);
            return(-1); exit;
          end;

          if (gTpModDctoFiscalLocal = 55) then begin
            gInQuebraItem := False;
          end else begin
            gInQuebraItem := item_b('IN_QUEBRANF', tGER_MODNFC);
          end;
          gTpAgrupamento := item_a('IN_AGRUPA_GRUPO', tGER_MODNFC);
          gTpCodigoItem := item_f('TP_CODPRODUTO', tGER_MODNFC);
        end;
      end;
      if (gInReemissao = True) then begin
        if (gNrNf = 0) then begin
          Result := SetStatus(STS_ERROR, 'GEN001', 'Número de NF não informado!', cDS_METHOD);
          return(-1); exit;
        end;
      end;
    end else begin
      if (gNrNf = 0) then begin
        Result := SetStatus(STS_ERROR, 'GEN001', 'Número de NF não informado!', cDS_METHOD);
        return(-1); exit;
      end;

      clear_e(tV_FIS_NFREMDES);
      putitem_o(tV_FIS_NFREMDES, 'CD_EMPFAT', item_f('CD_EMPFAT', tTRA_TRANSACAO));
      if (item_a('CD_PESSOA', tTRA_REMDES) <> '') then begin
        putitem_o(tV_FIS_NFREMDES, 'CD_PESSOAREMDES', item_f('CD_PESSOA', tTRA_REMDES));
      end else begin
        putitem_o(tV_FIS_NFREMDES, 'CD_PESSOANF', item_f('CD_PESSOA', tTRA_TRANSACAO));
      end;
      putitem_o(tV_FIS_NFREMDES, 'NR_NF', gNrNf);
      putitem_o(tV_FIS_NFREMDES, 'CD_SERIE', gCdSerie);
      putitem_o(tV_FIS_NFREMDES, 'TP_SITUACAO', '!=X');
      putitem_o(tV_FIS_NFREMDES, 'TP_ORIGEMEMISSAO', 2);
      putitem_o(tV_FIS_NFREMDES, 'TP_MODDCTOFISCAL', gTpModDctoFiscalLocal);
      retrieve_e(tV_FIS_NFREMDES);
      if (xStatus >= 0) then begin
        if ((item_f('NR_FATURA', tV_FIS_NFREMDES) <> item_f('NR_FATURA', tFIS_NF)) or (item_a('DT_FATURA', tV_FIS_NFREMDES) <> item_a('DT_FATURA', tFIS_NF)))
        and (item_f('TP_MODDCTOFISCAL', tV_FIS_NFREMDES) <> 6) and (item_f('TP_MODDCTOFISCAL', tV_FIS_NFREMDES) <> 21) and (item_f('TP_MODDCTOFISCAL', tV_FIS_NFREMDES) <> 22) then begin
          Result := SetStatus(STS_ERROR, 'GEN001', 'NF ' + FloatToStr(gNrNf) + ' ' + FloatToStr(gCdSerie) + ' Modelo Documento ' + FloatToStr(gTpModDctoFiscallocal) + ' já cadastrada para a pessoa ' + item_a('CD_PESSOAREMDES', tV_FIS_NFREMDES) + '!', cDS_METHOD);
          return(-1); exit;
        end;
      end;
      gInQuebraCFOP := False;
    end;

    clear_e(tGER_OPERACAO);
    putitem_o(tGER_OPERACAO, 'CD_OPERACAO', item_f('CD_OPERACAO', tTRA_TRANSACAO));
    retrieve_e(tGER_OPERACAO);
    if (xStatus < 0) then begin
      Result := SetStatus(STS_ERROR, 'GEN001', 'Operaçao ' + item_a('CD_OPERACAO', tGER_OPERACAO) + ' não cadastrada!', cDS_METHOD);
      return(-1); exit;
    end;
    if (item_f('TP_ORIGEMEMISSAO', tTRA_TRANSACAO) = 1) then begin
      if (item_f('TP_DOCTO', tGER_OPERACAO) = 2) or (item_f('TP_DOCTO', tGER_OPERACAO) = 3) then begin
        gInQuebraItem := False;
        gTpAgrupamento := 'F';
        if (gTpImpressaoCodPrdEcf = 0) then begin
          gTpCodigoItem := 4;
        end;
        gInQuebraCFOP := False;
      end;
    end;

    setocc(tGER_S_OPERACAO, 1);
    if not (dbocc(tGER_S_OPERACAO)) then begin
      Result := SetStatus(STS_ERROR, 'GEN001', 'Operação ' + item_a('CD_OPERACAO', tGER_OPERACAO) + ' não possui operação de movimento!', cDS_METHOD);
      return(-1); exit;
    end;
    if (item_f('TP_ORIGEMEMISSAO', tTRA_TRANSACAO) = 1) then begin
      if (item_f('TP_DOCTO', tGER_S_OPERACAO) = 2) or (item_f('TP_DOCTO', tGER_S_OPERACAO) = 3) then begin
        gInQuebraItem := False;
        gTpAgrupamento := 'F';
        if (gTpImpressaoCodPrdEcf = 0) then begin
          gTpCodigoItem := 4;
        end;
        gInQuebraCFOP := False;
      end else if (item_f('TP_DOCTO', tGER_S_OPERACAO) = 1) then begin
        vDsNulo := '';
        clear_e(tTRA_TRANSITEM);
        putitem_o(tTRA_TRANSITEM, 'CD_EMPRESA', item_a('CD_EMPRESA', tTRA_TRANSACAO));
        putitem_o(tTRA_TRANSITEM, 'NR_TRANSACAO', item_a('NR_TRANSACAO', tTRA_TRANSACAO));
        putitem_o(tTRA_TRANSITEM, 'DT_TRANSACAO', item_a('DT_TRANSACAO', tTRA_TRANSACAO));
        putitem_o(tTRA_TRANSITEM, 'CD_PRODUTO', '=');
        putitem_o(tTRA_TRANSITEM, 'CD_BARRAPRD', '=');
        retrieve_e(tTRA_TRANSITEM);
        if (xStatus >= 0) then begin
          vInItemDescritivo := True;
        end;
        clear_e(tTRA_TRANSITEM);
        retrieve_e(tTRA_TRANSITEM);
      end;
      if (item_a('TP_MODALIDADE', tGER_S_OPERACAO) = '6') then begin
        gInQuebraCFOP := False;
      end;
      if (item_a('TP_MODALIDADE', tGER_S_OPERACAO) = 'A') then begin
        gTpAgrupamento := 'F';
      end;
    end;
    if (item_f('CD_REGRAFISCAL', tGER_S_OPERACAO) > 0) then begin
      vCdRegraFiscal := item_f('CD_REGRAFISCAL', tGER_S_OPERACAO);
    end else if (item_f('CD_REGRAFISCAL', tGER_OPERACAO) > 0) then begin
      vCdRegraFiscal := item_f('CD_REGRAFISCAL', tGER_OPERACAO);
    end;

    viParams := '';
    putitemXml(viParams, 'CD_REGRAFISCAL', vCdRegraFiscal);
    voParams := activateCmp('FISSVCO033', 'buscaDadosRegraFiscal', viParams);
    if (xStatus < 0) then begin
      Result := voParams;
      return(-1); exit;
    end;

    vTpReducao := itemXml('TP_REDUCAO', voParams);
    vTpAliqIcms := itemXml('TP_ALIQICMS', voParams);
    vCdDecreto := itemXmlF('CD_DECRETO', voParams);
    gUfDestino := item_a('DS_SIGLAESTADO', tTRA_REMDES);
    vInObs := False;

    if (vTpReducao = '') and (vTpAliqIcms = '') then begin
      vInObs := True;
    end else if  ((vTpReducao = 'G') or (vTpReducao = 'H') or (vTpReducao = 'I'))
             or (((vTpReducao = 'A') or (vTpReducao = 'B') or (vTpReducao = 'C')) and (gUfOrigem = gUfDestino))
             or (((vTpReducao = 'D') or (vTpReducao = 'E') or (vTpReducao = 'F')) and (gUfOrigem <> gUfDestino)) then begin
      vInObs := True;
    end else if (((vTpAliqIcms = 'C') or (vTpAliqIcms = 'A')) and (gUfOrigem = gUfDestino))
             or ((vTpAliqIcms = 'B') and (gUfOrigem <> gUfDestino)) then begin
      vInObs := True;
    end;

    if (vInObs = True) then begin
      gDsAdicionalRegra := itemXml('DS_ADICIONAL', voParams);
    end;
    if (empty(tTRA_TRANSITEM) = False) then begin
      if (gDtEmissao = 0) then begin
        if (item_f('TP_ORIGEMEMISSAO', tTRA_TRANSACAO) = 2) then begin
          gDtEmissao := item_d('DT_TRANSACAO', tTRA_TRANSACAO);
        end else begin
          gDtEmissao := itemXmlD('DT_SISTEMA', PARAM_GLB);
        end;
      end;

      vInLoopCapa := True;
      if (vInItemDescritivo = True) then begin
        sort_e(tTRA_TRANSITEM, 'NR_ITEM');
      end else begin
        if (gTpAgrupamento = 'T') then begin
          sort_e(tTRA_TRANSITEM, 'CD_CFOP;CD_NIVELGRUPO;CD_SEQGRUPO;VL_UNITLIQUIDO;CD_COMPVEND');
        end else if (gTpAgrupamento = 'C') then begin
          sort_e(tTRA_TRANSITEM, 'CD_CFOP;CD_NIVELGRUPO;CD_SEQGRUPO;CD_COR;VL_UNITLIQUIDO;CD_COMPVEND');
        end else if (gTpAgrupamento = 'A') then begin
          sort_e(tTRA_TRANSITEM, 'CD_CFOP;CD_NIVELGRUPO;CD_SEQGRUPO;CD_TAMANHO;VL_UNITLIQUIDO;CD_COMPVEND');
        end else if (gInQuebraCFOP = True) then begin
          sort_e(tTRA_TRANSITEM, 'CD_CFOP;NR_ITEM');
        end else begin
          sort_e(tTRA_TRANSITEM, 'NR_ITEM');
        end;
      end;
      setocc(tTRA_TRANSITEM, -1);
      setocc(tTRA_TRANSITEM, 1);

      while (vInLoopCapa = True) do begin
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
          gHrInicio := Time;
          putmess('- Inicio gera NF. geraCapaNF FISSVCO004: ' + TimeToStr(gHrInicio));
        end;

        voParams := geraCapaNF(viParams);
        if (xStatus < 0) then begin
          Result := voParams;
          return(-1); exit;
        end;

        if (gInLog = True) then begin
          gHrFim := Time;
          gHrTempo := gHrFim - gHrInicio;
          putmess('- Fim gera NF. geraCapaNF FISSVCO004: ' + TimeToStr(gHrFim) + ' - ' + TimeToStr(gHrTempo));

          gHrInicio := Time;
          putmess('- Inicio gera NF. geraRemDest FISSVCO004: ' + TimeToStr(gHrInicio));
        end;

        gInNFe := False;
        if not (empty(tF_TMP_NR08)) then begin
          creocc(tF_TMP_NR08, -1);
          putitem_o(tF_TMP_NR08, 'NR_08', item_f('TP_MODDCTOFISCAL', tFIS_NF));
          retrieve_o(tF_TMP_NR08);
          if (xStatus = 4) then begin
            gInNFe := True;
          end else begin
            discard(tF_TMP_NR08);
          end;
        end;

        voParams := geraRemDest(viParams);
        if (xStatus < 0) then begin
          Result := voParams;
          return(-1); exit;
        end;

        if (gInLog = True) then begin
          gHrFim := Time;
          gHrTempo := gHrFim - gHrInicio;
          putmess('- Fim gera NF. geraRemDest FISSVCO004: ' + TimeToStr(gHrFim) + ' - ' + TimeToStr(gHrTempo));

          gHrInicio := Time;
          putmess('- Inicio gera NF. geraNFReferencial FISSVCO004: ' + TimeToStr(gHrInicio));
        end;

        voParams := geraNFReferencial(viParams);
        if (xStatus < 0) then begin
          Result := voParams;
          return(-1); exit;
        end;

        if (gInLog = True) then begin
          gHrFim := Time;
          gHrTempo := gHrFim - gHrInicio;
          putmess('- Fim gera NF. geraNFReferencial FISSVCO004: ' + TimeToStr(gHrFim) + ' - ' + TimeToStr(gHrTempo));
        end;

        voParams := geraSeloFiscalEnt(viParams);
        if (xStatus < 0) then begin
          Result := voParams;
          return(-1); exit;
        end;

        while (vTpLoopItem = 0) do begin
          vRegistroNext := next(tTRA_TRANSITEM);
          vCdSeqGrupoProx := itemXmlF('CD_SEQGRUPO', vRegistroNext);
          vCdCorProx := itemXml('CD_COR', vRegistroNext);
          vCdTamanhoProx := itemXmlF('CD_TAMANHO', vRegistroNext);
          vVlUnitProx := itemXmlF('VL_UNITLIQUIDO', vRegistroNext);
          vCdCFOPProx := itemXmlF('CD_CFOP', vRegistroNext);
          vCdCompVendProx := itemXmlF('CD_COMPVEND', vRegistroNext);

          vDsRegistroItem := '';
          putitemXml(vDsRegistroItem, 'CD_PRODUTO', item_f('CD_PRODUTO', tTRA_TRANSITEM));
          putitemXml(vDsRegistroItem, 'CD_COMPVEND', item_f('CD_COMPVEND', tTRA_TRANSITEM));
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
          if (empty(tTRA_ITEMIMPOSTO) = False) then begin
            setocc(tTRA_ITEMIMPOSTO, 1);
            while (xStatus >= 0) do begin
              creocc(tTMP_NR09, -1);
              putitem_o(tTMP_NR09, 'NR_GERAL', item_f('CD_IMPOSTO', tTRA_ITEMIMPOSTO));
              retrieve_o(tTMP_NR09);
              putitem_e(tTMP_NR09, 'PR_ALIQUOTA', item_f('PR_ALIQUOTA', tTRA_ITEMIMPOSTO));
              putitem_e(tTMP_NR09, 'PR_BASECALC', item_f('PR_BASECALC', tTRA_ITEMIMPOSTO));
              putitem_e(tTMP_NR09, 'PR_REDUBASE', item_f('PR_REDUBASE', tTRA_ITEMIMPOSTO));
              putitem_e(tTMP_NR09, 'VL_BASECALC', item_f('VL_BASECALC', tTMP_NR09) + item_f('VL_BASECALC', tTRA_ITEMIMPOSTO));
              putitem_e(tTMP_NR09, 'VL_ISENTO', item_f('VL_ISENTO', tTMP_NR09)   + item_f('VL_ISENTO', tTRA_ITEMIMPOSTO));
              putitem_e(tTMP_NR09, 'VL_OUTRO', item_f('VL_OUTRO', tTMP_NR09)    + item_f('VL_OUTRO', tTRA_ITEMIMPOSTO));
              putitem_e(tTMP_NR09, 'VL_IMPOSTO', item_f('VL_IMPOSTO', tTMP_NR09)  + item_f('VL_IMPOSTO', tTRA_ITEMIMPOSTO));
              putitem_e(tTMP_NR09, 'CD_CST', item_f('CD_CST', tTRA_ITEMIMPOSTO));

              setocc(tTRA_ITEMIMPOSTO, curocc(tTRA_ITEMIMPOSTO) + 1);
            end;
          end;
          if (empty(tTRA_ITEMSERIAL) = False) then begin
            vDsLstSerial := '';
            setocc(tTRA_ITEMSERIAL, 1);
            while (xStatus >= 0) do begin
              vDsRegistro := '';
              putitemXml(vDsRegistro, 'NR_SEQUENCIA', item_f('NR_SEQUENCIA', tTRA_ITEMSERIAL));
              putitemXml(vDsRegistro, 'CD_EMPFAT', item_f('CD_EMPFAT', tTRA_ITEMSERIAL));
              putitemXml(vDsRegistro, 'CD_GRUPOEMPRESA', item_f('CD_GRUPOEMPRESA', tTRA_ITEMSERIAL));
              putitemXml(vDsRegistro, 'DS_SERIAL', item_a('DS_SERIAL', tTRA_ITEMSERIAL));
              putitem(vDsLstSerial,  vDsRegistro);
              setocc(tTRA_ITEMSERIAL, curocc(tTRA_ITEMSERIAL) + 1);
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
            if (item_a('TP_OPERACAO', tTRA_TRANSACAO) = 'E') and ((item_f('TP_MODALIDADE', tGER_OPERACAO) = 2) or (item_f('TP_MODALIDADE', tGER_OPERACAO) = 4)) and (item_a('CD_ESPECIE', tTRA_TRANSITEM) <> gCdEspecieServico) then begin
              Result := SetStatus(STS_ERROR, 'GEN001', 'Produto ' + item_a('CD_PRODUTO', tTRA_TRANSITEM) + ' da transação ' + item_a('NR_TRANSACAO', tTRA_TRANSITEM) + ' não possui valores cadastrados', cDS_METHOD);
              return(-1); exit;
            end;
          end;
          if (empty(tTRA_ITEMUN) = False) then begin
            vDsRegistro := '';
            putitemXml(vDsRegistro, 'CD_EMPFAT', item_f('CD_EMPFAT', tTRA_ITEMUN));
            putitemXml(vDsRegistro, 'CD_GRUPOEMPRESA', item_f('CD_GRUPOEMPRESA', tTRA_ITEMUN));
            putitemXml(vDsRegistro, 'CD_ESPECIE', item_a('CD_ESPECIE', tTRA_ITEMUN));
            putitemXml(vDsRegistro, 'TP_OPERACAO', item_a('TP_OPERACAO', tTRA_ITEMUN));
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

          if not (empty(tTRA_ITEMPRDFIN)) then begin
            vDsLstValor := '';
            setocc(tTRA_ITEMPRDFIN, 1);
            while (xStatus >= 0) do begin
              vDsRegistro := '';
              putitemXml(vDsRegistro, 'CD_EMPRESA', item_f('CD_EMPRESA', tTRA_ITEMPRDFIN));
              putitemXml(vDsRegistro, 'NR_TRANSACAO', item_f('NR_TRANSACAO', tTRA_ITEMPRDFIN));
              putitemXml(vDsRegistro, 'DT_TRANSACAO', item_a('DT_TRANSACAO', tTRA_ITEMPRDFIN));
              putitemXml(vDsRegistro, 'NR_ITEM', item_f('NR_ITEM', tTRA_ITEMPRDFIN));
              putitemXml(vDsRegistro, 'CD_EMPPRDFIN', item_f('CD_EMPPRDFIN', tTRA_ITEMPRDFIN));
              putitemXml(vDsRegistro, 'NR_PRDFIN', item_f('NR_PRDFIN', tTRA_ITEMPRDFIN));
              putitem(vDsLstValor,  vDsRegistro);
              setocc(tTRA_ITEMPRDFIN, curocc(tTRA_ITEMPRDFIN) + 1);
            end;
            putitemXml(vDsRegistroItem, 'DS_LSTITEMPRDFIN', vDsLstValor);
          end;

          if not (empty(tTRA_ITEMSELOENT)) then begin
            setocc(tTRA_ITEMSELOENT, 1);
            while (xStatus >= 0) do begin
              vDsRegistro := '';
              putlistitensocc_e(vDsRegistro, tTRA_ITEMSELOENT);
              putitem(vDsLstSelo,  vDsRegistro);
              setocc(tTRA_ITEMSELOENT, curocc(tTRA_ITEMSELOENT) + 1);
            end;
          end;

          viParams := '';
          putitemXml(viParams, 'CD_EMPRESA', item_f('CD_EMPRESA', tTRA_TRANSITEM));
          putitemXml(viParams, 'NR_TRANSACAO', item_f('NR_TRANSACAO', tTRA_TRANSITEM));
          putitemXml(viParams, 'DT_TRANSACAO', item_a('DT_TRANSACAO', tTRA_TRANSITEM));
          putitemXml(viParams, 'NR_ITEM', item_f('NR_ITEM', tTRA_TRANSITEM));
          voParams := activateCmp('TRASVCO016', 'buscaDespesaItem', viParams); 
          if (xStatus < 0) then begin
            Result := voParams;
            return(-1); exit;
          end;
          vDsLstDespesa := itemXml('DS_LSTDESPESA', voParams);
          if (vDsLstDespesa <> '') then begin
            putitemXml(vDsRegistroItem, 'DS_LSTDESPESA', vDsLstDespesa);
          end;

          putitem(vDsLstItem, vDsRegistroItem);

          vInAgrupaItem := False;

          if (curocc(tTRA_TRANSITEM) < totocc(tTRA_TRANSITEM)) then begin
            if (gTpAgrupamentoItemNF = 01) then begin
              if (gTpAgrupamento = 'T') then begin
                if (item_f('CD_CFOP', tTRA_TRANSITEM) = vCdCFOPProx) and (item_f('CD_SEQGRUPO', tTRA_TRANSITEM) = vCdSeqGrupoProx) and (item_f('CD_COMPVEND', tTRA_TRANSITEM) = vCdCompVendProx) then begin
                  vInAgrupaItem := True;
                end;
              end else if (gTpAgrupamento = 'C') then begin
                if (item_f('CD_CFOP', tTRA_TRANSITEM) = vCdCFOPProx) and (item_f('CD_SEQGRUPO', tTRA_TRANSITEM) = vCdSeqGrupoProx) and (item_f('CD_COMPVEND', tTRA_TRANSITEM) = vCdCompVendProx) and (item_a('CD_COR', tTRA_TRANSITEM) = vCdCorProx) then begin
                  vInAgrupaItem := True;
                end;
              end else if (gTpAgrupamento = 'A') then begin
                if (item_f('CD_CFOP', tTRA_TRANSITEM) = vCdCFOPProx) and (item_f('CD_SEQGRUPO', tTRA_TRANSITEM) = vCdSeqGrupoProx)   and (item_f('CD_COMPVEND', tTRA_TRANSITEM) = vCdCompVendProx) and (item_f('CD_TAMANHO', tTRA_TRANSITEM) = vCdTamanhoProx) then begin
                  vInAgrupaItem := True;
                end;
              end;
            end else begin
              if (gTpAgrupamento = 'T') then begin
                if (item_f('CD_CFOP', tTRA_TRANSITEM) = vCdCFOPProx) and (item_f('CD_SEQGRUPO', tTRA_TRANSITEM) = vCdSeqGrupoProx) and (item_f('VL_UNITLIQUIDO', tTRA_TRANSITEM) = vVlUnitProx) and (item_f('CD_COMPVEND', tTRA_TRANSITEM) = vCdCompVendProx) then begin
                  vInAgrupaItem := True;
                end;
              end else if (gTpAgrupamento = 'C') then begin
                if (item_f('CD_CFOP', tTRA_TRANSITEM) = vCdCFOPProx) and (item_f('CD_SEQGRUPO', tTRA_TRANSITEM) = vCdSeqGrupoProx) and (item_f('VL_UNITLIQUIDO', tTRA_TRANSITEM) = vVlUnitProx) and (item_f('CD_COMPVEND', tTRA_TRANSITEM) = vCdCompVendProx) and (item_a('CD_COR', tTRA_TRANSITEM) = vCdCorProx) then begin
                  vInAgrupaItem := True;
                end;
              end else if (gTpAgrupamento = 'A') then begin
                if (item_f('CD_CFOP', tTRA_TRANSITEM) = vCdCFOPProx) and (item_f('CD_SEQGRUPO', tTRA_TRANSITEM) = vCdSeqGrupoProx) and (item_f('VL_UNITLIQUIDO', tTRA_TRANSITEM) = vVlUnitProx) and (item_f('CD_COMPVEND', tTRA_TRANSITEM) = vCdCompVendProx) and (item_f('CD_TAMANHO', tTRA_TRANSITEM) = vCdTamanhoProx) then begin
                  vInAgrupaItem := True;
                end;
              end;
            end;
            if (item_f('CD_PRODUTO', tTRA_TRANSITEM) = 0) and (item_a('CD_BARRAPRD', tTRA_TRANSITEM) = '') then begin
              vInAgrupaItem := False;
            end;
          end;
          if (vInAgrupaItem = True) then begin
            vQtFaturado := vQtFaturado + item_f('QT_SOLICITADA', tTRA_TRANSITEM);
            vVlTotalBruto := vVlTotalBruto + item_f('VL_TOTALBRUTO', tTRA_TRANSITEM);
            vVlTotalLiquido := vVlTotalLiquido + item_f('VL_TOTALLIQUIDO', tTRA_TRANSITEM);
            vVlTotalDesc := vVlTotalDesc + item_f('VL_TOTALDESC', tTRA_TRANSITEM);
            vVlTotalDescCab := vVlTotalDescCab + item_f('VL_TOTALDESCCAB', tTRA_TRANSITEM);
          end else begin
            vNrItem := vNrItem + 1;
            putitem_e(tTRA_TRANSITEM, 'QT_SOLICITADA', item_f('QT_SOLICITADA', tTRA_TRANSITEM) + vQtFaturado);
            putitem_e(tTRA_TRANSITEM, 'VL_TOTALBRUTO', item_f('VL_TOTALBRUTO', tTRA_TRANSITEM) + vVlTotalBruto);
            putitem_e(tTRA_TRANSITEM, 'VL_TOTALLIQUIDO', item_f('VL_TOTALLIQUIDO', tTRA_TRANSITEM) + vVlTotalLiquido);
            putitem_e(tTRA_TRANSITEM, 'VL_TOTALDESC', item_f('VL_TOTALDESC', tTRA_TRANSITEM) + vVlTotalDesc);
            putitem_e(tTRA_TRANSITEM, 'VL_TOTALDESCCAB', item_f('VL_TOTALDESCCAB', tTRA_TRANSITEM) + vVlTotalDescCab);

            if (gInLog = True) and (curocc(tTRA_TRANSITEM) = 1) then begin
              gHrInicio := Time;
              putmess('- Inicio gera NF. geraItemNF FISSVCO004: ' + TimeToStr(gHrInicio));
            end;

            viParams := '';
            putitemXml(viParams, 'DS_LSTPRODUTO', vDsLstItem);
            putitemXml(viParams, 'NR_ITEM', vNrItem);
            voParams := geraItemNF(viParams);
            if (xStatus < 0) then begin
              Result := voParams;
              return(-1); exit;
            end;

            if (gInLog = True) and (curocc(tTRA_TRANSITEM) = 1) then begin
              gHrFim := Time;
              gHrTempo := gHrFim - gHrInicio;
              putmess('- Fim gera NF. geraItemNF FISSVCO004: ' + TimeToStr(gHrFim) + ' - ' + TimeToStr(gHrTempo));
            end;

            viParams := '';
            putitemXml(viParams, 'DS_LSTSELO', vDsLstSelo);
            voParams := geraItemSeloEnt(viParams);
            if (xStatus < 0) then begin
              Result := voParams;
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
          if (gInQuebraItem = True) and (vNrItem = item_f('NR_ITENS', tGER_MODNFC)) then begin
            vTpLoopItem := 1;
          end;
          if (gInQuebraCFOP = True) and (item_f('CD_CFOP', tTRA_TRANSITEM) <> vCdCFOPProx) then begin
            vTpLoopItem := 1;
          end;
          if (gNrItemQuebraNf > 0) and (vNrItem = gNrItemQuebraNf) then begin
            vTpLoopItem := 1;
          end;

          setocc(tTRA_TRANSITEM, curocc(tTRA_TRANSITEM) + 1);
          if (xStatus < 0) then begin
            vTpLoopItem := 2;
          end;
        end;
        if (vInPrimeira = True) then begin
          if (gInLog = True) then begin
            gHrInicio := Time;
            putmess('- Inicio gera NF. geraTransport FISSVCO004: ' + TimeToStr(gHrInicio));
          end;

          voParams := geraTransport(viParams);
          if (xStatus < 0) then begin
            Result := voParams;
            return(-1); exit;
          end;

          if (gInLog = True) then begin
            gHrFim := Time;
            gHrTempo := gHrFim - gHrInicio;
            putmess('- Fim gera NF. geraTransport FISSVCO004: ' + TimeToStr(gHrFim) + ' - ' + TimeToStr(gHrTempo));
          end;

          voParams := rateiaValorCapa(viParams);
          if (xStatus < 0) then begin
            Result := voParams;
            return(-1); exit;
          end;

          vInPrimeira := False;
        end;

        voParams := geraImpostoItem(viParams);
        if (xStatus < 0) then begin
          Result := voParams;
          return(-1); exit;
        end;

        putitem_e(tFIS_NF, 'VL_TOTALNOTA', item_f('VL_TOTALPRODUTO', tFIS_NF) + item_f('VL_DESPACESSOR', tFIS_NF) +
                                           item_f('VL_FRETE', tFIS_NF) + item_f('VL_SEGURO', tFIS_NF) +
                                           item_f('VL_IPI', tFIS_NF) + item_f('VL_ICMSSUBST', tFIS_NF));

        if (gInLog = True) then begin
          gHrInicio := Time;
          putmess('- Inicio gera NF. geraParcela FISSVCO004: ' + TimeToStr(gHrInicio));
        end;

        voParams := geraParcela(viParams);
        if (xStatus < 0) then begin
          Result := voParams;
          return(-1); exit;
        end;

        if (gInLog = True) then begin
          gHrFim := Time;
          gHrTempo := gHrFim - gHrInicio;
          putmess('- Fim gera NF. geraParcela FISSVCO004: ' + TimeToStr(gHrFim) + ' - ' + TimeToStr(gHrTempo));

          gHrInicio := Time;
          putmess('- Inicio gera NF. geraECF FISSVCO004: ' + TimeToStr(gHrInicio));
        end;

        voParams := geraECF(viParams);
        if (xStatus < 0) then begin
          Result := voParams;
          return(-1); exit;
        end;

        if (gInLog = True) then begin
          gHrFim := Time;
          gHrTempo := gHrFim - gHrInicio;
          putmess('- Fim gera NF. geraECF FISSVCO004: ' + TimeToStr(gHrFim) + ' - ' + TimeToStr(gHrTempo));
        end;

        viParams := '';
        putitemXml(viParams, 'DS_LINHAOBS', vDsLinhaObs);
        voParams := geraObservacao(viParams);
        if (xStatus < 0) then begin
          Result := voParams;
          return(-1); exit;
        end;

        if (vTpLoopItem = 2) then begin
          vInLoopCapa := False;
        end;
      end;
    end else begin
      if (gInLog = True) then begin
        gHrInicio := Time;
        putmess('- Inicio gera NF. geraCapaNF FISSVCO004: ' + TimeToStr(gHrInicio));
      end;

      voParams := geraCapaNF(viParams);
      if (xStatus < 0) then begin
        Result := voParams;
        return(-1); exit;
      end;

      if (gInLog = True) then begin
        gHrFim := Time;
        gHrTempo := gHrFim - gHrInicio;
        putmess('- Fim gera NF. geraCapaNF FISSVCO004: ' + TimeToStr(gHrFim) + ' - ' + TimeToStr(gHrTempo));

        gHrInicio := Time;
        putmess('- Inicio gera NF. geraRemDest FISSVCO004: ' + TimeToStr(gHrInicio));
      end;

      voParams := geraRemDest(viParams);
      if (xStatus < 0) then begin
        Result := voParams;
        return(-1); exit;
      end;

      if (gInLog = True) then begin
        gHrFim := Time;
        gHrTempo := gHrFim - gHrInicio;
        putmess('- Fim gera NF. geraRemDest FISSVCO004: ' + TimeToStr(gHrFim) + ' - ' + TimeToStr(gHrTempo));
      end;
    end;

    if (item_a('TP_MODALIDADE', tGER_OPERACAO) = 'D') then begin
      putitem_e(tFIS_NF, 'VL_TOTALNOTA', 0);
      putitem_e(tFIS_NF, 'VL_TOTALPRODUTO', 0);
      putitem_e(tFIS_NF, 'VL_DESPACESSOR', 0);
      putitem_e(tFIS_NF, 'VL_SEGURO', 0);
      putitem_e(tFIS_NF, 'VL_FRETE', 0);
      putitem_e(tFIS_NF, 'QT_FATURADO', 0);
      putitem_e(tFIS_NF, 'VL_BASEICMS', 0);
    end;

    if (gInIncluiIpiDevSimp = True) then begin
      voParams := alteraVlIpi(viParams);
      if (xStatus < 0) then begin
        Result := voParams;
        return(-1); exit;
      end;
    end;

    delitemGld(vDsLstTransacao, 1);
  until (vDsLstTransacao = '');

  voParams := tFIS_NF.Salvar();
  if (xStatus < 0) then begin
    Result := voParams;
    return(-1); exit;
  end;

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
      putitem(vDsLstNotaFiscal, vLstNF);
      setocc(tFIS_NF, curocc(tFIS_NF) + 1);
    end;
    setocc(tFIS_NF, 1);
  end;

  if (item_a('TP_OPERACAO', tGER_OPERACAO) = 'S') and ((item_f('TP_MODALIDADE', tGER_OPERACAO) = 3) or (item_f('TP_MODALIDADE', tGER_OPERACAO) = 4)) then begin
    viParams := pParams;
    voParams := activateCmp('FISSVCO024', 'gravaObsNfFisco', viParams);
    if (xStatus < 0) then begin
      Result := voParams;
      return(-1); exit;
    end;
  end;

  if (gTpModDctoFiscalLocal = 55) then begin
    repeat
      getitem(vDsRegistro, vDsLstNotaFiscal, 1);
      if (itemXmlF('TP_ORIGEMEMISSAO', vDsRegistro) = 1) then begin
        putitemXml(viParams, 'CD_EMPRESA', itemXmlF('CD_EMPRESA', vDsRegistro));
        putitemXml(viParams, 'NR_FATURA', itemXmlF('NR_FATURA', vDsRegistro));
        putitemXml(viParams, 'DT_FATURA', itemXmlD('DT_FATURA', vDsRegistro));
        putitemXml(viParams, 'CD_MODELONF', itemXmlF('CD_MODELONF', vDsRegistro));
        voParams := activateCmp('FISSVCO024', 'gravaObsNfe', viParams);
        if (xStatus < 0) then begin
          Result := voParams;
          return(-1); exit;
        end;
      end;
      delitemGld(vDsLstNotaFiscal, 1);
    until (vDsLstNotaFiscal = '');
  end;
  
  if (gLstLoteInfGeral <> '') and not (gInItemLote) then begin
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
      voParams := activateCmp('PRDSVCO020', 'gravaLoteINF', viParams);
      if (xStatus < 0) then begin
        Result := voParams;
        return(-1); exit;
      end;
      delitemGld(vDsLstLoteInfGeral, 1);
    until (vDsLstLoteInfGeral = '');
  end;
  {
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
      voParams := activateCmp('CTBSVCO016', 'geraContabilizaEmi', viParams);
      if (xStatus < 0) then begin
        Result := voParams;
        return(-1); exit;
      end;

      setocc(tFIS_NF, curocc(tFIS_NF) + 1);
    end;
  end;
  putitemXml(Result, 'DS_LSTNF', vDsLstNF);
  }
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
  vDtFatura, vDtSistema : TDateTime;
  vRegistroNext : String;
  vInECF : Boolean;
begin
  vDsLstNF := itemXml('DS_LSTNF', pParams);
  vCdModeloNF := itemXmlF('CD_MODELONF', pParams);
  vInECF := itemXmlB('IN_ECF', pParams);
  vDtSistema := itemXmlD('DT_SISTEMA', PARAM_GLB);

  clear_e(tGER_MODNFC);

  if (vCdModeloNF = 0) then begin
    if (vInECF <> True) then begin
      Result := SetStatus(STS_ERROR, 'GEN001', 'Modelo de NF não informado!', cDS_METHOD);
      return(-1); exit;
    end;
  end else begin
    putitem_o(tGER_MODNFC, 'CD_MODELONF', vCdModeloNF);
    retrieve_e(tGER_MODNFC);
    if (xStatus < 0) then begin
      Result := SetStatus(STS_ERROR, 'GEN001', 'Modelo de NF ' + FloatToStr(vCdModeloNF) + ' não cadastrado!', cDS_METHOD);
      return(-1); exit;
    end;
  end;

  viParams := '';
  putitemXml(viParams, 'DS_LSTNF', vDsLstNF);
  voParams := activateCmp('SICSVCO005', 'reservaNumeroNF', viParams); 
  if (xStatus < 0) then begin
    Result := voParams;
    return(-1); exit;
  end;
  vDsLstNF := itemXml('DS_LSTNF', voParams);
  vDsLstNrNF := itemXml('DS_LSTNF', voParams);

  if (vDsLstNF = '') then begin
    Result := SetStatus(STS_ERROR, 'GEN001', 'Lista de NF não informada!', cDS_METHOD);
    return(-1); exit;
  end;

  clear_e(tFIS_NF);

  repeat
    getitem(vDsRegistro, vDsLstNF, 1);
    vCdEmpresa := itemXmlF('CD_EMPRESA', vDsRegistro);
    vNrFatura := itemXmlF('NR_FATURA', vDsRegistro);
    vDtFatura := itemXmlD('DT_FATURA', vDsRegistro);

    if (vCdEmpresa = 0) then begin
      Result := SetStatus(STS_ERROR, 'GEN001', 'Empresa não informada!', cDS_METHOD);
      return(-1); exit;
    end;
    if (vNrFatura = 0) then begin
      Result := SetStatus(STS_ERROR, 'GEN001', 'Fatura não informado!', cDS_METHOD);
      return(-1); exit;
    end;
    if (vDtFatura = 0) then begin
      Result := SetStatus(STS_ERROR, 'GEN001', 'Data NF não informada!', cDS_METHOD);
      return(-1); exit;
    end;

    creocc(tFIS_NF, -1);
    putitem_o(tFIS_NF, 'CD_EMPRESA', vCdEmpresa);
    putitem_o(tFIS_NF, 'NR_FATURA', vNrFatura);
    putitem_o(tFIS_NF, 'DT_FATURA', vDtFatura);
    retrieve_o(tFIS_NF);
    if (xStatus = -7) then begin
      retrieve_x(tFIS_NF);
    end else begin
      Result := SetStatus(STS_ERROR, 'GEN001', 'NF ' + FloatToStr(vCdEmpresa) + ' / ' + FloatToStr(vNrFatura) + ' não cadastrada!', cDS_METHOD);
      return(-1); exit;
    end;
    vModDctoFiscal := item_f('TP_MODDCTOFISCAL', tFIS_NF);
    clear_e(tGER_OPERACAO);
    putitem_o(tGER_OPERACAO, 'CD_OPERACAO', item_f('CD_OPERACAO', tFIS_NF));
    retrieve_e(tGER_OPERACAO);
    if (xStatus < 0) then begin
      Result := SetStatus(STS_ERROR, 'GEN001', 'Operaçao ' + item_a('CD_OPERACAO', tGER_OPERACAO) + ' não cadastrada!', cDS_METHOD);
      return(-1); exit;
    end;
    if (item_a('TP_SITUACAO', tFIS_NF) = 'N') then begin
      if (item_f('TP_DOCTO', tGER_OPERACAO) = 0) then begin
        discard(tFIS_NF);
      end else begin
        if (item_f('TP_DOCTO', tGER_OPERACAO) = 2) or (item_f('TP_DOCTO', tGER_OPERACAO) = 3) then begin
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

          if (item_f('TP_MODDCTOFISCAL', tFIS_NF) <> 85) and (item_f('TP_MODDCTOFISCAL', tFIS_NF) <> 87) then begin
            putitemXml(viParams, 'TP_MODDCTOFISCALLOCAL', item_f('TP_MODDCTOFISCAL', tFIS_NF));
          end else begin
            putitemXml(viParams, 'TP_MODDCTOFISCALLOCAL', gTpModDctoFiscal);
          end;

          newInstanceComponente('GERSVCO001', 'GERSVCO001', 'TRANSACTION=TRUE');
          voParams := activateCmp('GERSVCO001', 'buscaNrNF', viParams); 
          if (xStatus < 0) then begin
            Result := voParams;
            return(-1); exit;
          end;
          if (vCdSerie = 'ECF') then begin
            vNrNF := itemXmlF('NR_NF', voParams);
            if (vNrNF = 0) then begin
              Result := SetStatus(STS_ERROR, 'GEN001', 'Não foi possivel obter numeração para a NF(ECF) ' + FloatToStr(vCdEmpresa) + ' / ' + FloatToStr(vNrFatura) + '!', cDS_METHOD);
              return(-1); exit;
            end;
            putitem_e(tFIS_NF, 'NR_NF', vNrNF);
            putitem_e(tFIS_NF, 'CD_SERIE', vCdSerie);
          end else begin
            discard(tFIS_NF);
            creocc(tFIS_NF, -1);
            putitem_o(tFIS_NF, 'CD_EMPRESA', vCdEmpresa);
            putitem_o(tFIS_NF, 'NR_FATURA', vNrFatura);
            putitem_o(tFIS_NF, 'DT_FATURA', vDtFatura);
            putitem_o(tFIS_NF, 'TP_MODDCTOFISCAL', vModDctoFiscal);
            retrieve_o(tFIS_NF);
            if (xStatus = -7) then begin
              retrieve_x(tFIS_NF);
            end else begin
              Result := SetStatus(STS_ERROR, 'GEN001', 'Não possível recarregar a NF ' + FloatToStr(vCdEmpresa) + ' / ' + FloatToStr(vNrFatura) + ' após a rotina de numeração!', cDS_METHOD);
              return(-1); exit;
            end;
          end;
          putitem_e(tFIS_NF, 'DT_EMISSAO', vDtSistema);
          putitem_e(tFIS_NF, 'TP_SITUACAO', 'E');
          putitem_e(tFIS_NF, 'CD_MODELONF', item_f('CD_MODELONF', tGER_MODNFC));
        end;
      end;
    end else if (item_a('TP_SITUACAO', tFIS_NF) = 'E') then begin
    end else begin
      discard(tFIS_NF);
    end;

    delitemGld(vDsLstNF, 1);
  until (vDsLstNF = '');

  setocc(tFIS_NF, 1);

  if (empty(tFIS_NF) <> False) then begin
    Result := SetStatus(STS_ERROR, 'GEN001', 'Nenhuma NF emitida!', cDS_METHOD);
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
        Result := SetStatus(STS_ERROR, 'GEN001', 'Não foi possivel obter numeração para a NF ' + FloatToStr(vCdEmpresa) + ' / ' + FloatToStr(vNrFatura) + '!', cDS_METHOD);
        return(-1); exit;
      end;
      clear_e(tFIS_S_NF);
      putitem_o(tFIS_S_NF, 'CD_EMPFAT', item_f('CD_EMPFAT', tFIS_NF));
      putitem_o(tFIS_S_NF, 'NR_NF', item_f('NR_NF', tFIS_NF));
      putitem_o(tFIS_S_NF, 'CD_SERIE', item_f('CD_SERIE', tFIS_NF));
      putitem_o(tFIS_S_NF, 'TP_SITUACAO', '!=X');
      putitem_o(tFIS_S_NF, 'TP_ORIGEMEMISSAO', 1);
      putitem_o(tFIS_S_NF, 'TP_MODDCTOFISCAL', item_f('TP_MODDCTOFISCAL', tFIS_NF));
      retrieve_e(tFIS_S_NF);
      if (xStatus >= 0) then begin
        if (item_f('NR_FATURA', tFIS_S_NF) <> item_f('NR_FATURA', tFIS_NF)) or (item_a('DT_FATURA', tFIS_S_NF) <> item_a('DT_FATURA', tFIS_NF)) then begin
          Result := SetStatus(STS_ERROR, 'GEN001', 'NF ' + item_a('NR_NF', tFIS_NF) + ' já cadastrada!', cDS_METHOD);
          return(-1); exit;
        end;
      end;
    end;
    if (vNrNFTransp <> 0) then begin
      clear_e(tGER_OPERACAO);
      putitem_o(tGER_OPERACAO, 'CD_OPERACAO', item_f('CD_OPERACAO', tFIS_NF));
      retrieve_e(tGER_OPERACAO);
      if (xStatus >= 0) then begin
        if (item_f('TP_DOCTO', tGER_OPERACAO) <> 1) then begin
          vNrNFTransp := 0;
        end;
      end;
      if (item_a('TP_SITUACAO', tFIS_NF) <> 'E') then begin
        vNrNFTransp := 0;
      end;
      if (curocc(tFIS_NF) < totocc(tFIS_NF)) then begin
        vRegistroNext := next(tFIS_NF);
        if (item_f('CD_EMPRESAORI', tFIS_NF) <> itemXmlF('CD_EMPRESAORI', vRegistroNext))
        or (item_f('NR_TRANSACAOORI', tFIS_NF) <> itemXmlF('NR_TRANSACAOORI', vRegistroNext))
        or (item_d('DT_TRANSACAOORI', tFIS_NF) <> itemXmlD('DT_TRANSACAOORI', vRegistroNext)) then begin
          vNrNFTransp := 0;
        end;
      end;
    end;
    if (vNrNFTransp <> 0) and (curocc(tFIS_NF) > 1) then begin
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
    putitemXml(viParams, 'DS_OBSERVACAO', 'DADOS DA TRANSPORTADORA SE ENCONTRAM NA N.F. ' + FloatToStr(vNrNFTransp));
    newInstanceComponente('FISSVCO004', 'FISSVCO004O', 'TRANSACTION=FALSE');
    voParams := activateCmp('FISSVCO004O', 'gravaObsNF', viParams);
    if (xStatus < 0) then begin
      Result := voParams;
      return(-1); exit;
    end;
  end;

  viParams := '';
  putitemXml(viParams, 'DS_LSTNF', vDsLstNrNF);
  voParams := activateCmp('SICSVCO005', 'liberaNumeroNF', viParams); 
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
  vDtFatura : TDateTime;
begin
  vCdEmpresa := itemXmlF('CD_EMPRESA', pParams);
  vNrFatura := itemXmlF('NR_FATURA', pParams);
  vDtFatura := itemXmlD('DT_FATURA', pParams);
  vCdEmpECF := itemXmlF('CD_EMPECF', pParams);
  vNrECF := itemXmlF('NR_ECF', pParams);
  vNrCupom := itemXmlF('NR_CUPOM', pParams);

  if (vCdEmpresa = 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN001', 'Empresa não informada!', cDS_METHOD);
    return(-1); exit;
  end;
  if (vNrFatura = 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN001', 'Fatura não informado!', cDS_METHOD);
    return(-1); exit;
  end;
  if (vDtFatura = 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN001', 'Data NF não informada!', cDS_METHOD);
    return(-1); exit;
  end;
  if (vCdEmpECF = 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN001', 'Empresa da ECF não informada!', cDS_METHOD);
    return(-1); exit;
  end;
  if (vNrECF = 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN001', 'Número da ECF não informada!', cDS_METHOD);
    return(-1); exit;
  end;
  if (vNrCupom = 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN001', 'Número do cupom não informado!', cDS_METHOD);
    return(-1); exit;
  end;

  clear_e(tFIS_ECF);
  putitem_o(tFIS_ECF, 'CD_EMPRESA', vCdEmpresa);
  putitem_o(tFIS_ECF, 'NR_ECF', vNrECF);
  retrieve_e(tFIS_ECF);
  if (xStatus < 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN001', 'Número da ECF ' + FloatToStr(vNrECF) + ' não cadastrado!', cDS_METHOD);
    return(-1); exit;
  end;

  clear_e(tFIS_NF);
  putitem_o(tFIS_NF, 'CD_EMPRESA', vCdEmpresa);
  putitem_o(tFIS_NF, 'NR_FATURA', vNrFatura);
  putitem_o(tFIS_NF, 'DT_FATURA', vDtFatura);
  retrieve_o(tFIS_NF);
  if (xStatus = -7) then begin
    retrieve_x(tFIS_NF);
  end else if (xStatus = 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN001', 'NF ' + FloatToStr(vNrFatura) + ' não cadastrada!', cDS_METHOD);
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
  putitem_e(tFIS_NFECF, 'CD_SERIEFAB', item_a('CD_SERIEFAB', tFIS_ECF));
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
  vDtFatura : TDateTime;
  vInValidaTransacao : Boolean;
begin
  vDsLstNF := itemXml('DS_LSTNF', pParams);
  vTpSituacao := itemXml('TP_SITUACAO', pParams);

  vInValidaTransacao := itemXmlB('IN_VALIDATRANSACAO', pParams);
  if (itemXml('IN_VALIDATRANSACAO', pParams) = '') then begin
    vInValidaTransacao := True;
  end;
  if (vDsLstNF = '') then begin
    Result := SetStatus(STS_ERROR, 'GEN001', 'Lista de NF não informada!', cDS_METHOD);
    return(-1); exit;
  end;
  if (vTpSituacao = '') then begin
    Result := SetStatus(STS_ERROR, 'GEN001', 'Situação não informada!', cDS_METHOD);
    return(-1); exit;
  end;
  if (vTpSituacao <> 'N') and (vTpSituacao <> 'E') and (vTpSituacao <> 'C') and (vTpSituacao <> 'X') and (vTpSituacao <> 'D') then begin
    Result := SetStatus(STS_ERROR, 'GEN001', 'Situação ' + vTpSituacao + ' inválida!', cDS_METHOD);
    return(-1); exit;
  end;

  clear_e(tFIS_NF);
  repeat
    getitem(vDsRegistro, vDsLstNF, 1);
    vCdEmpresa := itemXmlF('CD_EMPRESA', vDsRegistro);
    vNrFatura := itemXmlF('NR_FATURA', vDsRegistro);
    vDtFatura := itemXmlD('DT_FATURA', vDsRegistro);

    if (vCdEmpresa = 0) then begin
      Result := SetStatus(STS_ERROR, 'GEN001', 'Empresa não informada!', cDS_METHOD);
      return(-1); exit;
    end;
    if (vNrFatura = 0) then begin
      Result := SetStatus(STS_ERROR, 'GEN001', 'Fatura não informado!', cDS_METHOD);
      return(-1); exit;
    end;
    if (vDtFatura = 0) then begin
      Result := SetStatus(STS_ERROR, 'GEN001', 'Data NF não informada!', cDS_METHOD);
      return(-1); exit;
    end;

    creocc(tFIS_NF, -1);
    putitem_o(tFIS_NF, 'CD_EMPRESA', vCdEmpresa);
    putitem_o(tFIS_NF, 'NR_FATURA', vNrFatura);
    putitem_o(tFIS_NF, 'DT_FATURA', vDtFatura);
    retrieve_o(tFIS_NF);
    if (xStatus = -7) then begin
      retrieve_x(tFIS_NF);

      if ((vTpSituacao = 'C') or (vTpSituacao = 'X')) and (vInValidaTransacao = True) then begin
        clear_e(tTRA_TRANSACAO);
        putitem_o(tTRA_TRANSACAO, 'CD_EMPRESA', item_f('CD_EMPRESAORI', tFIS_NF));
        putitem_o(tTRA_TRANSACAO, 'NR_TRANSACAO', item_f('NR_TRANSACAOORI', tFIS_NF));
        putitem_o(tTRA_TRANSACAO, 'DT_TRANSACAO', item_a('DT_TRANSACAOORI', tFIS_NF));
        retrieve_e(tTRA_TRANSACAO);
        if (xStatus >= 0) then begin
          if (item_f('TP_SITUACAO', tTRA_TRANSACAO) <> 6) then begin
            Result := SetStatus(STS_ERROR, 'GEN001', 'Transação ' + item_a('NR_TRANSACAOORI', tTRA_TRANSACAO) + ' não está cancelada!', cDS_METHOD);
            return(-1); exit;
          end;
        end;
      end;

      clear_e(tGER_OPERACAO);
      putitem_o(tGER_OPERACAO, 'CD_OPERACAO', item_f('CD_OPERACAO', tFIS_NF));
      retrieve_e(tGER_OPERACAO);
      if (xStatus < 0) then begin
        Result := SetStatus(STS_ERROR, 'GEN001', 'Operaçao ' + item_a('CD_OPERACAO', tFIS_NF) + ' não cadastrada!', cDS_METHOD);
        return(-1); exit;
      end;
      if (gDtEncerramento <> 0) and (item_f('TP_DOCTO', tGER_OPERACAO) <> 0) then begin
        if (item_d('DT_SAIDAENTRADA', tFIS_NF) <= gDtEncerramento) then begin
          Result := SetStatus(STS_ERROR, 'GEN001', 'NF/Fatura ' + item_a('NR_NF', tFIS_NF) + '/' + item_a('NR_FATURA', tFIS_NF) + ' possuir data de movimento anterior ao encerramento do livro fiscal!', cDS_METHOD);
          return(-1); exit;
        end;
      end;
    end else if (xStatus = 0) then begin
      Result := SetStatus(STS_ERROR, 'GEN001', 'NF ' + FloatToStr(vNrFatura) + ' não cadastrada!', cDS_METHOD);
      return(-1); exit;
    end;

    putitem_e(tFIS_NF, 'TP_SITUACAO', vTpSituacao);
    putitem_e(tFIS_NF, 'CD_OPERADOR', itemXmlF('CD_USUARIO', PARAM_GLB));
    putitem_e(tFIS_NF, 'DT_CADASTRO', Now);

    delitemGld(vDsLstNF, 1);
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
  vDtFatura : TDateTime;
begin
  vDsLstNF := itemXml('DS_LSTNF', pParams);
  vCdModeloNF := itemXmlF('CD_MODELONF', pParams);

  if (vDsLstNF = '') then begin
    Result := SetStatus(STS_ERROR, 'GEN001', 'Lista de NF não informada!', cDS_METHOD);
    return(-1); exit;
  end;
  if (vCdModeloNF = 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN001', 'Modelo de NF não informado!', cDS_METHOD);
    return(-1); exit;
  end;

  clear_e(tGER_MODNFC);
  putitem_o(tGER_MODNFC, 'CD_MODELONF', vCdModeloNF);
  retrieve_e(tGER_MODNFC);
  if (xStatus < 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN001', 'Modelo de NF ' + FloatToStr(vCdModeloNF) + ' não cadastrado!', cDS_METHOD);
    return(-1); exit;
  end;

  clear_e(tFIS_NF);

  repeat
    getitem(vDsRegistro, vDsLstNF, 1);
    vCdEmpresa := itemXmlF('CD_EMPRESA', vDsRegistro);
    vNrFatura := itemXmlF('NR_FATURA', vDsRegistro);
    vDtFatura := itemXmlD('DT_FATURA', vDsRegistro);

    if (vCdEmpresa = 0) then begin
      Result := SetStatus(STS_ERROR, 'GEN001', 'Empresa não informada!', cDS_METHOD);
      return(-1); exit;
    end;
    if (vNrFatura = 0) then begin
      Result := SetStatus(STS_ERROR, 'GEN001', 'Fatura não informado!', cDS_METHOD);
      return(-1); exit;
    end;
    if (vDtFatura = 0) then begin
      Result := SetStatus(STS_ERROR, 'GEN001', 'Data NF não informada!', cDS_METHOD);
      return(-1); exit;
    end;

    creocc(tFIS_NF, -1);
    putitem_o(tFIS_NF, 'CD_EMPRESA', vCdEmpresa);
    putitem_o(tFIS_NF, 'NR_FATURA', vNrFatura);
    putitem_o(tFIS_NF, 'DT_FATURA', vDtFatura);
    retrieve_o(tFIS_NF);
    if (xStatus = -7) then begin
      retrieve_x(tFIS_NF);
    end else if (xStatus = 0) then begin
      Result := SetStatus(STS_ERROR, 'GEN001', 'NF ' + FloatToStr(vNrFatura) + ' não cadastrada!', cDS_METHOD);
      return(-1); exit;
    end;
    if (item_f('TP_ORIGEMEMISSAO', tFIS_NF) = 1) then begin
      clear_e(tFIS_S_NF);
      putitem_o(tFIS_S_NF, 'CD_EMPFAT', item_f('CD_EMPFAT', tFIS_NF));
      putitem_o(tFIS_S_NF, 'NR_NF', item_f('NR_NF', tFIS_NF));
      putitem_o(tFIS_S_NF, 'CD_SERIE', item_f('CD_SERIE', tFIS_NF));
      putitem_o(tFIS_S_NF, 'TP_SITUACAO', '!=X');
      putitem_o(tFIS_S_NF, 'TP_ORIGEMEMISSAO', 1);
      putitem_o(tFIS_S_NF, 'TP_MODDCTOFISCAL', item_f('TP_MODDCTOFISCAL', tFIS_NF));
      retrieve_e(tFIS_S_NF);
      if (xStatus >= 0) then begin
        if (item_f('NR_FATURA', tFIS_S_NF) <> item_f('NR_FATURA', tFIS_NF)) or (item_a('DT_FATURA', tFIS_S_NF) <> item_a('DT_FATURA', tFIS_NF)) then begin
          Result := SetStatus(STS_ERROR, 'GEN001', 'NF ' + item_a('NR_NF', tFIS_NF) + ' já cadastrada!', cDS_METHOD);
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

    delitemGld(vDsLstNF, 1);
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
  vDtFatura : TDateTime;
  vInInclusao : Boolean;
begin
  vCdEmpresa := itemXmlF('CD_EMPRESA', pParams);
  vCdGrupoEmpresa := itemXmlF('CD_GRUPOEMPRESA', pParams);
  vNrFatura := itemXmlF('NR_FATURA', pParams);
  vDtFatura := itemXmlD('DT_FATURA', pParams);
  vInInclusao := itemXmlB('IN_INCLUSAO', pParams);
  vTpModDctoFiscal := itemXmlF('TP_MODDCTOFISCAL', pParams);

  if (vCdEmpresa = 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN001', 'Empresa não informada!', cDS_METHOD);
    return(-1); exit;
  end;
  if (vInInclusao = True) then begin
    if (vNrFatura > 0) then begin
      Result := SetStatus(STS_ERROR, 'GEN001', 'Fatura não pode ser informada p/ inclusão!', cDS_METHOD);
      return(-1); exit;
    end;
  end else begin
    if (vNrFatura = 0) then begin
      Result := SetStatus(STS_ERROR, 'GEN001', 'Fatura não informado!', cDS_METHOD);
      return(-1); exit;
    end;
  end;
  if (vDtFatura = 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN001', 'Data NF não informada!', cDS_METHOD);
    return(-1); exit;
  end;

  clear_e(tTRA_TRANSACAO);

  if (vInInclusao = True) then begin
    viParams := '';
    putitemXml(viParams, 'NM_ENTIDADE', 'FIS_NF');
    voParams := activateCmp('GERSVCO031', 'getNumSeq', viParams); 
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
    putitem_o(tFIS_NF, 'CD_EMPRESA', vCdEmpresa);
    putitem_o(tFIS_NF, 'NR_FATURA', vNrFatura);
    putitem_o(tFIS_NF, 'DT_FATURA', vDtFatura);
    retrieve_e(tFIS_NF);
    if (xStatus < 0) then begin
      Result := SetStatus(STS_ERROR, 'GEN001', 'NF ' + FloatToStr(vNrFatura) + ' não cadastrada!', cDS_METHOD);
      return(-1); exit;
    end;
    if (gDtEncerramento <> 0) then begin
      if (item_d('DT_SAIDAENTRADA', tFIS_NF) <= gDtEncerramento) then begin
        Result := SetStatus(STS_ERROR, 'GEN001', 'NF/Fatura ' + item_a('NR_NF', tFIS_NF) + '/' + item_a('NR_FATURA', tFIS_NF) + ' possui data de movimento anterior ao encerramento do livro fiscal!', cDS_METHOD);
        return(-1); exit;
      end;
    end;
    if (item_f('NR_TRANSACAOORI', tFIS_NF) > 0) then begin
      clear_e(tTRA_TRANSACAO);
      putitem_o(tTRA_TRANSACAO, 'CD_EMPRESA', item_f('CD_EMPRESAORI', tFIS_NF));
      putitem_o(tTRA_TRANSACAO, 'NR_TRANSACAO', item_f('NR_TRANSACAOORI', tFIS_NF));
      putitem_o(tTRA_TRANSACAO, 'DT_TRANSACAO', item_a('DT_TRANSACAOORI', tFIS_NF));
      retrieve_e(tTRA_TRANSACAO);
      if (xStatus < 0) then begin
        Result := SetStatus(STS_ERROR, 'GEN001', 'Transação ' + item_a('NR_TRANSACAOORI', tTRA_TRANSACAO) + ' não cadastrada!', cDS_METHOD);
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
    Result := SetStatus(STS_ERROR, 'GEN001', 'Data saída/entrada não informada!', cDS_METHOD);
    return(-1); exit;
  end;
  if (gDtEncerramento <> 0) then begin
    if (item_d('DT_SAIDAENTRADA', tFIS_NF) <= gDtEncerramento) then begin
      Result := SetStatus(STS_ERROR, 'GEN001', 'NF/Fatura ' + item_a('NR_NF', tFIS_NF) + '/' + item_a('NR_FATURA', tFIS_NF) + ' possui data de movimento anterior ao encerramento do livro fiscal!', cDS_METHOD);
      return(-1); exit;
    end;
  end;
  if (item_a('TP_SITUACAO', tFIS_NF) = '') then begin
    Result := SetStatus(STS_ERROR, 'GEN001', 'Situação não informada!', cDS_METHOD);
    return(-1); exit;
  end;
  if (item_a('TP_SITUACAO', tFIS_NF) = 'E') then begin
    if (item_a('DT_EMISSAO', tFIS_NF) = '') then begin
      Result := SetStatus(STS_ERROR, 'GEN001', 'Data emissão não informada!', cDS_METHOD);
      return(-1); exit;
    end;
    if (item_f('NR_NF', tFIS_NF) = 0) then begin
      Result := SetStatus(STS_ERROR, 'GEN001', 'Número NF não informada!', cDS_METHOD);
      return(-1); exit;
    end;
  end;
  if (item_a('HR_SAIDA', tFIS_NF) = '') then begin
    Result := SetStatus(STS_ERROR, 'GEN001', 'Hora de saída não informada!', cDS_METHOD);
    return(-1); exit;
  end;
  if (item_f('CD_PESSOA', tFIS_NF) = 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN001', 'Pessoa não informada!', cDS_METHOD);
    return(-1); exit;
  end;
  if (item_f('CD_COMPVEND', tFIS_NF) = 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN001', 'Comprador/vendedor não informado!', cDS_METHOD);
    return(-1); exit;
  end;
  if (item_f('CD_CONDPGTO', tFIS_NF) = 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN001', 'Condição de pagamento não informada!', cDS_METHOD);
    return(-1); exit;
  end;
  if (item_f('CD_OPERACAO', tFIS_NF) = 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN001', 'Operação não informada!', cDS_METHOD);
    return(-1); exit;
  end;
  if (vCdGrupoEmpresa = 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN001', 'Grupo empresa não informado!', cDS_METHOD);
    return(-1); exit;
  end;

  clear_e(tGER_OPERACAO);
  putitem_o(tGER_OPERACAO, 'CD_OPERACAO', item_f('CD_OPERACAO', tFIS_NF));
  retrieve_e(tGER_OPERACAO);
  if (xStatus < 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN001', 'Operaçao ' + item_a('CD_OPERACAO', tFIS_NF) + ' não cadastrada!', cDS_METHOD);
    return(-1); exit;
  end;
  if (vInInclusao = True) then begin
    putitem_e(tFIS_NF, 'CD_EMPFAT', item_f('CD_EMPRESA', tFIS_NF));
  end;

  putitem_e(tFIS_NF, 'VL_TOTALNOTA', item_f('VL_TOTALPRODUTO', tFIS_NF) + item_f('VL_DESPACESSOR', tFIS_NF) + item_f('VL_FRETE', tFIS_NF) + item_f('VL_SEGURO', tFIS_NF) + item_f('VL_IPI', tFIS_NF) + item_f('VL_ICMSSUBST', tFIS_NF));
  putitem_e(tFIS_NF, 'TP_OPERACAO', item_a('TP_OPERACAO', tGER_OPERACAO));
  putitem_e(tFIS_NF, 'CD_GRUPOEMPRESA', vCdGrupoEmpresa);
  putitem_e(tFIS_NF, 'CD_OPERADOR', itemXmlF('CD_USUARIO', PARAM_GLB));
  putitem_e(tFIS_NF, 'DT_CADASTRO', Now);

  if (vTpModDctoFiscal = 85) or (vTpModDctoFiscal = 87) then begin
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
  viParams, voParams,
  vDsLinhaObs, vDsLstNF, vDsRegistro : String;
  vCdEmpresa, vNrFatura, NrLinha : Real;
  vDtFatura : TDateTime;
begin
  vDsLstNF := itemXml('DS_LSTNF', pParams);
  if (vDsLstNF = '') then begin
    Result := SetStatus(STS_ERROR, 'GEN001', 'Lista de nota não informada!', cDS_METHOD);
    return(-1); exit;
  end;

  clear_e(tFIS_NF);

  repeat
    getitem(vDsRegistro, vDsLstNF, 1);
    vCdEmpresa := itemXmlF('CD_EMPRESA', vDsRegistro);
    vNrFatura := itemXmlF('NR_FATURA', vDsRegistro);
    vDtFatura := itemXmlD('DT_FATURA', vDsRegistro);
    vDsLinhaObs := itemXml('DS_OBSERVACAO', pParams);
    if (vDsLinhaObs = '') then begin
      Result := SetStatus(STS_ERROR, 'GEN001', 'Observação não informada!', cDS_METHOD);
      return(-1); exit;
    end;
    if (vDtFatura = 0) then begin
      Result := SetStatus(STS_ERROR, 'GEN001', 'Data da fatura não informada!', cDS_METHOD);
      return(-1); exit;
    end;
    if (vNrFatura = 0) then begin
      Result := SetStatus(STS_ERROR, 'GEN001', 'Número da fatura não informada!', cDS_METHOD);
      return(-1); exit;
    end;
    if (vCdEmpresa = 0) then begin
      Result := SetStatus(STS_ERROR, 'GEN001', 'Empresa da transação não informada!', cDS_METHOD);
      return(-1); exit;
    end;

    creocc(tFIS_NF, -1);
    putitem_o(tFIS_NF, 'CD_EMPRESA', vCdEmpresa);
    putitem_o(tFIS_NF, 'NR_FATURA', vNrFatura);
    putitem_o(tFIS_NF, 'DT_FATURA', vDtFatura);
    retrieve_o(tFIS_NF);
    if (xStatus = -7) then begin
      retrieve_x(tFIS_NF);
    end else if (xStatus <> 4) then begin
      Result := SetStatus(STS_ERROR, 'GEN001', 'NF ' + FloatToStr(vNrFatura) + ' não cadastrada!', cDS_METHOD);
      return(-1); exit;
    end;

    setocc(tOBS_NF, -1);
    NrLinha := item_f('NR_LINHA', tOBS_NF) + 1;
    creocc(tOBS_NF, -1);
    putitem_e(tOBS_NF, 'CD_EMPFAT', item_f('CD_EMPFAT', tFIS_NF));
    putitem_e(tOBS_NF, 'CD_GRUPOEMPRESA', item_f('CD_GRUPOEMPRESA', tFIS_NF));
    putitem_e(tOBS_NF, 'NR_LINHA', NrLinha);
    putitem_e(tOBS_NF, 'DS_OBSERVACAO', copy(vDsLinhaObs,1,80));
    putitem_e(tOBS_NF, 'CD_OPERADOR', itemXmlF('CD_USUARIO', PARAM_GLB));
    putitem_e(tOBS_NF, 'DT_CADASTRO', Now);

    delitemGld(vDsLstNF, 1);
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
  vDtFatura : TDateTime;
  voParams : String;
begin
  vCdEmpresa := itemXmlF('CD_EMPRESA', pParams);
  vNrFatura := itemXmlF('NR_FATURA', pParams);
  vDtFatura := itemXmlD('DT_FATURA', pParams);
  vCdProduto := itemXmlF('CD_PRODUTO', pParams);
  vNrItem := itemXmlF('NR_ITEM', pParams);
  if (vCdEmpresa = 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN001', 'Empresa não informada!', cDS_METHOD);
    return(-1); exit;
  end;
  if (vNrFatura = 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN001', 'Fatura não informado!', cDS_METHOD);
    return(-1); exit;
  end;
  if (vDtFatura = 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN001', 'Data NF não informada!', cDS_METHOD);
    return(-1); exit;
  end;
  if (vCdProduto = 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN001', 'Produto não informado!', cDS_METHOD);
    return(-1); exit;
  end;
  if (vNrItem = 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN001', 'Número do item não informado!', cDS_METHOD);
    return(-1); exit;
  end;

  clear_e(tFIS_NF);
  putitem_o(tFIS_NF, 'CD_EMPRESA', vCdEmpresa);
  putitem_o(tFIS_NF, 'NR_FATURA', vNrFatura);
  putitem_o(tFIS_NF, 'DT_FATURA', vDtFatura);
  retrieve_e(tFIS_NF);
  if (xStatus < 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN001', 'Nota Fiscal não encotrada!', cDS_METHOD);
    return(-1); exit;
  end;
  if (gDtEncerramento <> 0) then begin
    if (item_d('DT_SAIDAENTRADA', tFIS_NF) <= gDtEncerramento) then begin
      Result := SetStatus(STS_ERROR, 'GEN001', 'NF/Fatura ' + item_a('NR_NF', tFIS_NF) + '/' + item_a('NR_FATURA', tFIS_NF) + ' possui data de movimento anterior ao encerramento do livro fiscal!', cDS_METHOD);
      return(-1); exit;
    end;
  end;

  clear_e(tFIS_NFITEM);
  putitem_o(tFIS_NFITEM, 'NR_ITEM', vNrItem);
  retrieve_e(tFIS_NFITEM);
  if (xStatus < 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN001', 'Itens da Nota Fiscal não encotrada!', cDS_METHOD);
    return(-1); exit;
  end;

  clear_e(tFIS_NFITEMPROD);
  putitem_o(tFIS_NFITEMPROD, 'CD_PRODUTO', vCdProduto);
  retrieve_e(tFIS_NFITEMPROD);
  if (xStatus < 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN001', 'Produto ' + FloatToStr(vCdProduto) + ' não encotrado!', cDS_METHOD);
    return(-1); exit;
  end;

  delitem(pParams, 'CD_EMPRESA');
  delitem(pParams, 'NR_FATURA');
  delitem(pParams, 'DT_FATURA');
  delitem(pParams, 'NR_ITEM');
  delitem(pParams, 'CD_PRODUTO');

  getlistitensocc_e(pParams, tFIS_NFITEMPROD);

  voParams := tFIS_NFITEMPROD.Salvar();
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
  vDtFatura : TDateTime;
  voParams : String;
  vInInclusao : Boolean;
begin
  vCdEmpresa := itemXmlF('CD_EMPRESA', pParams);
  vNrFatura := itemXmlF('NR_FATURA', pParams);
  vDtFatura := itemXmlD('DT_FATURA', pParams);
  vCdProduto := itemXmlF('CD_PRODUTO', pParams);
  vNrItem := itemXmlF('NR_ITEM', pParams);
  vInInclusao := itemXmlB('IN_INCLUSAO', pParams);
  vTpModDctoFiscal := itemXmlF('TP_MODDCTOFISCAL', pParams);

  if (vCdEmpresa = 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN001', 'Empresa não informada!', cDS_METHOD);
    return(-1); exit;
  end;
  if (vNrFatura = 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN001', 'Fatura não informado!', cDS_METHOD);
    return(-1); exit;
  end;
  if (vDtFatura = 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN001', 'Data NF não informada!', cDS_METHOD);
    return(-1); exit;
  end;
  if (vCdProduto = 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN001', 'Produto não informado!', cDS_METHOD);
    return(-1); exit;
  end;
  if (vNrItem = 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN001', 'Número do item não informado!', cDS_METHOD);
    return(-1); exit;
  end;

  clear_e(tFIS_NF);
  putitem_o(tFIS_NF, 'CD_EMPRESA', vCdEmpresa);
  putitem_o(tFIS_NF, 'NR_FATURA', vNrFatura);
  putitem_o(tFIS_NF, 'DT_FATURA', vDtFatura);
  retrieve_e(tFIS_NF);
  if (xStatus < 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN001', 'Nota Fiscal não encotrada!', cDS_METHOD);
    return(-1); exit;
  end;
  if (gDtEncerramento <> 0) then begin
    if (item_d('DT_SAIDAENTRADA', tFIS_NF) <= gDtEncerramento) then begin
      Result := SetStatus(STS_ERROR, 'GEN001', 'NF/Fatura ' + item_a('NR_NF', tFIS_NF) + '/' + item_a('NR_FATURA', tFIS_NF) + ' possui data de movimento anterior ao encerramento do livro fiscal!', cDS_METHOD);
      return(-1); exit;
    end;
  end;
  if (vInInclusao = True) then begin
  end else begin
    clear_e(tFIS_NFITEM);
    putitem_o(tFIS_NFITEM, 'NR_ITEM', vNrItem);
    retrieve_e(tFIS_NFITEM);
    if (xStatus < 0) then begin
      Result := SetStatus(STS_ERROR, 'GEN001', 'Itens da Nota Fiscal não encotrada!', cDS_METHOD);
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

  if (vTpModDctoFiscal = 85) or (vTpModDctoFiscal = 87) then begin
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
  voParams : String;
  vDtFatura : TDateTime;
begin
  vCdEmpresa := itemXmlF('CD_EMPRESA', pParams);
  vNrFatura := itemXmlF('NR_FATURA', pParams);
  vDtFatura := itemXmlD('DT_FATURA', pParams);
  if (vCdEmpresa = 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN001', 'Empresa não informada!', cDS_METHOD);
    return(-1); exit;
  end;
  if (vNrFatura = 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN001', 'Fatura não informado!', cDS_METHOD);
    return(-1); exit;
  end;
  if (vDtFatura = 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN001', 'Data NF não informada!', cDS_METHOD);
    return(-1); exit;
  end;

  clear_e(tFIS_NF);
  putitem_o(tFIS_NF, 'CD_EMPRESA', vCdEmpresa);
  putitem_o(tFIS_NF, 'NR_FATURA', vNrFatura);
  putitem_o(tFIS_NF, 'DT_FATURA', vDtFatura);
  retrieve_e(tFIS_NF);
  if (xStatus < 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN001', 'Nota Fiscal não encotrada!', cDS_METHOD);
    return(-1); exit;
  end;
  if (gDtEncerramento <> 0) then begin
    if (item_d('DT_SAIDAENTRADA', tFIS_NF) <= gDtEncerramento) then begin
      Result := SetStatus(STS_ERROR, 'GEN001', 'NF/Fatura ' + item_a('NR_NF', tFIS_NF) + '/' + item_a('NR_FATURA', tFIS_NF) + ' possui data de movimento anterior ao encerramento do livro fiscal!', cDS_METHOD);
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
    Result := SetStatus(STS_ERROR, 'GEN001', 'Nome da pessoa não informado!', cDS_METHOD);
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
  voParams : String;
  vDtFatura : TDateTime;
begin
  vCdEmpresa := itemXmlF('CD_EMPRESA', pParams);
  vNrFatura := itemXmlF('NR_FATURA', pParams);
  vDtFatura := itemXmlD('DT_FATURA', pParams);

  if (vCdEmpresa = 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN001', 'Empresa não informada!', cDS_METHOD);
    return(-1); exit;
  end;
  if (vNrFatura = 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN001', 'Fatura não informado!', cDS_METHOD);
    return(-1); exit;
  end;
  if (vDtFatura = 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN001', 'Data NF não informada!', cDS_METHOD);
    return(-1); exit;
  end;

  clear_e(tFIS_NF);
  putitem_o(tFIS_NF, 'CD_EMPRESA', vCdEmpresa);
  putitem_o(tFIS_NF, 'NR_FATURA', vNrFatura);
  putitem_o(tFIS_NF, 'DT_FATURA', vDtFatura);
  retrieve_e(tFIS_NF);
  if (xStatus < 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN001', 'Nota Fiscal não encotrada!', cDS_METHOD);
    return(-1); exit;
  end;
  if (gDtEncerramento <> 0) then begin
    if (item_d('DT_SAIDAENTRADA', tFIS_NF) <= gDtEncerramento) then begin
      Result := SetStatus(STS_ERROR, 'GEN001', 'NF/Fatura ' + item_a('NR_NF', tFIS_NF) + '/' + item_a('NR_FATURA', tFIS_NF) + ' possui data de movimento anterior ao encerramento do livro fiscal!', cDS_METHOD);
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
    Result := SetStatus(STS_ERROR, 'GEN001', 'Transportadora não informada!', cDS_METHOD);
    return(-1); exit;
  end;
  if (item_a('TP_FRETE', tFIS_NFTRANSP) = '') then begin
    Result := SetStatus(STS_ERROR, 'GEN001', 'Tipo de frete não informado!', cDS_METHOD);
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
  voParams : String;
  vDtFatura : TDateTime;
  vInNaoExcluir : Boolean;
begin
  vDsLstImposto := itemXml('DS_LSTIMPOSTO', pParams);
  vCdEmpresa := itemXmlF('CD_EMPRESA', pParams);
  vNrFatura := itemXmlF('NR_FATURA', pParams);
  vDtFatura := itemXmlD('DT_FATURA', pParams);
  vCdImposto := itemXmlF('CD_IMPOSTO', pParams);
  vNrItem := itemXmlF('NR_ITEM', pParams);
  vInNaoExcluir := itemXmlB('IN_NAOEXCLUIR', pParams);

  if (vCdEmpresa = 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN001', 'Empresa não informada!', cDS_METHOD);
    return(-1); exit;
  end;
  if (vNrFatura = 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN001', 'Fatura não informado!', cDS_METHOD);
    return(-1); exit;
  end;
  if (vDtFatura = 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN001', 'Data NF não informada!', cDS_METHOD);
    return(-1); exit;
  end;
  if (vNrItem = 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN001', 'Número do item não informado!', cDS_METHOD);
    return(-1); exit;
  end;

  clear_e(tFIS_NF);
  putitem_o(tFIS_NF, 'CD_EMPRESA', vCdEmpresa);
  putitem_o(tFIS_NF, 'NR_FATURA', vNrFatura);
  putitem_o(tFIS_NF, 'DT_FATURA', vDtFatura);
  retrieve_e(tFIS_NF);
  if (xStatus < 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN001', 'Nota Fiscal não encotrada!', cDS_METHOD);
    return(-1); exit;
  end;
  if (gDtEncerramento <> 0) then begin
    if (item_d('DT_SAIDAENTRADA', tFIS_NF) <= gDtEncerramento) then begin
      Result := SetStatus(STS_ERROR, 'GEN001', 'NF/Fatura ' + item_a('NR_NF', tFIS_NF) + '/' + item_a('NR_FATURA', tFIS_NF) + ' possui data de movimento anterior ao encerramento do livro fiscal!', cDS_METHOD);
      return(-1); exit;
    end;
  end;

  clear_e(tFIS_NFITEM);
  putitem_o(tFIS_NFITEM, 'NR_ITEM', vNrItem);
  retrieve_e(tFIS_NFITEM);
  if (xStatus < 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN001', 'Itens da Nota Fiscal não encotrada!', cDS_METHOD);
    return(-1); exit;
  end;
  if (empty(tFIS_NFITEMIMPOST) = False) then begin
    if (vInNaoExcluir = True) then begin
      vDsImposto := vDsLstImposto;
      if (vDsImposto <> '') then begin
        repeat
          getitem(vDsRegistro, vDsImposto, 1);
          clear_e(tFIS_NFITEMIMPOST);
          putitem_o(tFIS_NFITEMIMPOST, 'CD_IMPOSTO', itemXmlF('CD_IMPOSTO', vDsRegistro));
          retrieve_e(tFIS_NFITEMIMPOST);
          if (xStatus >= 0) then begin
            voParams := tFIS_NFITEMIMPOST.Excluir();
            if (xStatus < 0) then begin
              Result := voParams;
              return(-1); exit;
            end;
          end;

          delitemGld(vDsImposto, 1);
        until (vDsImposto = '');
      end;

    end else begin
      voParams := tFIS_NFITEMIMPOST.Excluir();
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

      if (vCdImposto = 0) then begin
        Result := SetStatus(STS_ERROR, 'GEN001', 'Imposto não informado!', cDS_METHOD);
        return(-1); exit;
      end;

      creocc(tFIS_NFITEMIMPOST, -1);

      getlistitensocc_e(vDsRegistro, tFIS_NFITEMIMPOST);
      putitem_e(tFIS_NFITEMIMPOST, 'CD_EMPFAT', item_f('CD_EMPFAT', tFIS_NFITEM));
      putitem_e(tFIS_NFITEMIMPOST, 'CD_GRUPOEMPRESA', item_f('CD_GRUPOEMPRESA', tFIS_NFITEM));
      putitem_e(tFIS_NFITEMIMPOST, 'CD_OPERADOR', itemXmlF('CD_USUARIO', PARAM_GLB));
      putitem_e(tFIS_NFITEMIMPOST, 'DT_CADASTRO', Now);

      delitemGld(vDsLstImposto, 1);
    until (vDsLstImposto = '');
  end;

  voParams := tFIS_NFITEMIMPOST.Salvar();
  if (xStatus < 0) then begin
    Result := voParams;
    return(-1); exit;
  end;

  voParams := calculaTotalNF();
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
  voParams : String;
  vDtFatura : TDateTime;
begin
  vDsLstImposto := itemXml('DS_LSTIMPOSTO', pParams);
  vCdEmpresa := itemXmlF('CD_EMPRESA', pParams);
  vNrFatura := itemXmlF('NR_FATURA', pParams);
  vDtFatura := itemXmlD('DT_FATURA', pParams);

  if (vCdEmpresa = 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN001', 'Empresa não informada!', cDS_METHOD);
    return(-1); exit;
  end;
  if (vNrFatura = 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN001', 'Fatura não informado!', cDS_METHOD);
    return(-1); exit;
  end;
  if (vDtFatura = 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN001', 'Data NF não informada!', cDS_METHOD);
    return(-1); exit;
  end;

  clear_e(tFIS_NF);
  putitem_o(tFIS_NF, 'CD_EMPRESA', vCdEmpresa);
  putitem_o(tFIS_NF, 'NR_FATURA', vNrFatura);
  putitem_o(tFIS_NF, 'DT_FATURA', vDtFatura);
  retrieve_e(tFIS_NF);
  if (xStatus < 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN001', 'Nota Fiscal não encotrada!', cDS_METHOD);
    return(-1); exit;
  end;
  if (gDtEncerramento <> 0) then begin
    if (item_d('DT_SAIDAENTRADA', tFIS_NF) <= gDtEncerramento) then begin
      Result := SetStatus(STS_ERROR, 'GEN001', 'NF/Fatura ' + item_a('NR_NF', tFIS_NF) + '/' + item_a('NR_FATURA', tFIS_NF) + ' possui data de movimento anterior ao encerramento do livro fiscal!', cDS_METHOD);
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

      if (vCdImposto = 0) then begin
        Result := SetStatus(STS_ERROR, 'GEN001', 'Imposto não informado!', cDS_METHOD);
        return(-1); exit;
      end;

      creocc(tFIS_NFIMPOSTO, -1);

      getlistitensocc_e(vDsRegistro, tFIS_NFIMPOSTO);
      putitem_e(tFIS_NFIMPOSTO, 'CD_EMPFAT', item_f('CD_EMPFAT', tFIS_NFITEM));
      putitem_e(tFIS_NFIMPOSTO, 'CD_GRUPOEMPRESA', item_f('CD_GRUPOEMPRESA', tFIS_NFITEM));
      putitem_e(tFIS_NFIMPOSTO, 'CD_OPERADOR', itemXmlF('CD_USUARIO', PARAM_GLB));
      putitem_e(tFIS_NFIMPOSTO, 'DT_CADASTRO', Now);

      delitemGld(vDsLstImposto, 1);
    until (vDsLstImposto = '');
  end;

  voParams := tFIS_NFIMPOSTO.Salvar();
  if (xStatus < 0) then begin
    Result := voParams;
    return(-1); exit;
  end;

	voParams := calculaTotalNF();
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
  vDtFatura, vDtTransacao : TDateTime;
begin
  vDsLstNF := itemXml('DS_LSTNF', pParams);
  vCdEmpTransacao := itemXmlF('CD_EMPTRANSACAO', pParams);
  vNrTransacao := itemXmlF('NR_TRANSACAO', pParams);
  vDtTransacao := itemXmlD('DT_TRANSACAO', pParams);

  vCdVendedor := itemXmlF('CD_COMPVEND', pParams);

  if (vDsLstNF = '') then begin
    if (vCdEmpTransacao = 0) then begin
      Result := SetStatus(STS_ERROR, 'GEN001', 'Empresa não informada!', cDS_METHOD);
      return(-1); exit;
    end;
    if (vNrTransacao = 0) then begin
      Result := SetStatus(STS_ERROR, 'GEN001', 'Número da transação não informado!', cDS_METHOD);
      return(-1); exit;
    end;
    if (vDtTransacao = 0) then begin
      Result := SetStatus(STS_ERROR, 'GEN001', 'Data transação não informada!', cDS_METHOD);
      return(-1); exit;
    end;
  end;
  if (vCdVendedor = 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN001', 'Vendedor não informado!', cDS_METHOD);
    return(-1); exit;
  end;

  clear_e(tFIS_NF);

  if (vDsLstNF = '') then begin
    putitem_o(tFIS_NF, 'CD_EMPRESAORI', vCdEmpTransacao);
    putitem_o(tFIS_NF, 'NR_TRANSACAOORI', vNrTransacao);
    putitem_o(tFIS_NF, 'DT_TRANSACAOORI', vDtTransacao);
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
      vDtFatura := itemXmlD('DT_FATURA', vDsRegistro);
      if (vCdEmpresa = 0) then begin
        Result := SetStatus(STS_ERROR, 'GEN001', 'Empresa não informada!', cDS_METHOD);
        return(-1); exit;
      end;
      if (vNrFatura = 0) then begin
        Result := SetStatus(STS_ERROR, 'GEN001', 'Fatura não informado!', cDS_METHOD);
        return(-1); exit;
      end;
      if (vDtFatura = 0) then begin
        Result := SetStatus(STS_ERROR, 'GEN001', 'Data NF não informada!', cDS_METHOD);
        return(-1); exit;
      end;
      creocc(tFIS_NF, -1);
      putitem_o(tFIS_NF, 'CD_EMPRESA', vCdEmpresa);
      putitem_o(tFIS_NF, 'NR_FATURA', vNrFatura);
      putitem_o(tFIS_NF, 'DT_FATURA', vDtFatura);
      retrieve_o(tFIS_NF);
      if (xStatus = -7) then begin
        retrieve_x(tFIS_NF);
      end else if (xStatus = 0) then begin
        Result := SetStatus(STS_ERROR, 'GEN001', 'NF ' + FloatToStr(vNrFatura) + ' não cadastrada!', cDS_METHOD);
        return(-1); exit;
      end;

      delitemGld(vDsLstNF, 1);
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
          if (empty(tFIS_NFITEMPROD) = False) then begin
            setocc(tFIS_NFITEMPROD, 1);
            while(xStatus >=0) do begin
              putitem_e(tFIS_NFITEMPROD, 'CD_COMPVEND', vCdVendedor);
              putitem_e(tFIS_NFITEMPROD, 'CD_OPERADOR', itemXmlF('CD_USUARIO', PARAM_GLB));
              putitem_e(tFIS_NFITEMPROD, 'DT_CADASTRO', Now);
              setocc(tFIS_NFITEMPROD, curocc(tFIS_NFITEMPROD) + 1);
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
  voParams : String; 
  vDtFatura : TDateTime;
begin
  vDsLstItem := itemXml('DS_CONSIGNADO', pParams);
  vTpConsignado := itemXml('TP_CONSIGNADO', pParams);

  if (vDsLstItem = '') then begin
    Result := SetStatus(STS_ERROR, 'GEN001', 'Lista de item consignado não informado!', cDS_METHOD);
    return(-1); exit;
  end;
  if (vTpConsignado = '') then begin
    Result := SetStatus(STS_ERROR, 'GEN001', 'Lista de item consignado não informado!', cDS_METHOD);
    return(-1); exit;
  end;

  repeat
    getitem(vDsItem, vDsLstItem, 1);
    vCdEmpresa := itemXmlF('CD_EMPRESA', vDsItem);
    vNrFatura := itemXmlF('NR_FATURA', vDsItem);
    vDtFatura := itemXmlD('DT_FATURA', vDsItem);
    vNrItem := itemXmlF('NR_ITEM', vDsItem);
    vCdProduto := itemXmlF('CD_PRODUTO', vDsItem);

    clear_e(tFIS_NF);
    putitem_o(tFIS_NF, 'CD_EMPRESA', vCdEmpresa);
    putitem_o(tFIS_NF, 'NR_FATURA', vNrFatura);
    putitem_o(tFIS_NF, 'DT_FATURA', vDtFatura);
    retrieve_e(tFIS_NF);
    if (xStatus >= 0) then begin
      clear_e(tFIS_NFITEM);
      putitem_o(tFIS_NFITEM, 'NR_ITEM', vNrItem);
      retrieve_e(tFIS_NFITEM);
      if (xStatus >= 0) then begin
        clear_e(tFIS_NFITEMPROD);
        putitem_o(tFIS_NFITEMPROD, 'CD_PRODUTO', vCdProduto);
        retrieve_e(tFIS_NFITEMPROD);
        if (xStatus >= 0) then begin
          vQtSaldo := item_f('QT_FATURADO', tFIS_NFITEMPROD);

          if (empty(tFIS_NFITEMCONT) = False) then begin
            if (vTpConsignado = 'DEVOLVER') then begin
              vQtConsignado := itemXmlF('QT_DEVOLVIDA', vDsItem);
              putitem_e(tFIS_NFITEMCONT, 'QT_DEVOLVIDA', item_f('QT_DEVOLVIDA', tFIS_NFITEMCONT) + vQtConsignado);
            end;
            if (vTpConsignado = 'FATURAR') then begin
              vQtConsignado := itemXmlF('QT_VendIDA', vDsItem);
              putitem_e(tFIS_NFITEMCONT, 'QT_VENDIDA', item_f('QT_VENDIDA', tFIS_NFITEMCONT) + vQtConsignado);
            end;

            vQtSaldo := vQtSaldo - item_f('QT_DEVOLVIDA', tFIS_NFITEMCONT) - item_f('QT_VENDIDA', tFIS_NFITEMCONT);

            if (vQtSaldo <= 0) then begin
              putitem_e(tFIS_NFITEMCONT, 'TP_SITUACAO', 2);
            end;

            voParams := tFIS_NFITEMCONT.Salvar();
            if (xStatus < 0) then begin
              Result := voParams;
              return(-1); exit;
            end;
          end;
        end;
      end;
    end;

    delitemGld(vDsLstItem, 1);
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
  viParams := pParams;
  voParams := activateCmp('FISSVCO024', 'gravaLogNF', viParams); 
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
  voParams : String;
  vDtFatura : TDateTime;
begin
  vDsLstItem := itemXml('DS_CONSIGNADO', pParams);
  vTpConsignado := itemXml('TP_CONSIGNADO', pParams);

  if (vDsLstItem = '') then begin
    Result := SetStatus(STS_ERROR, 'GEN001', 'Lista de item consignado não informado!', cDS_METHOD);
    return(-1); exit;
  end;
  if (vTpConsignado = '') then begin
    Result := SetStatus(STS_ERROR, 'GEN001', 'Lista de item consignado não informado!', cDS_METHOD);
    return(-1); exit;
  end;

  repeat
    getitem(vDsItem, vDsLstItem, 1);
    vCdEmpresa := itemXmlF('CD_EMPRESA', vDsItem);
    vNrFatura := itemXmlF('NR_FATURA', vDsItem);
    vDtFatura := itemXmlD('DT_FATURA', vDsItem);
    vNrItem := itemXmlF('NR_ITEM', vDsItem);
    vCdProduto := itemXmlF('CD_PRODUTO', vDsItem);

    clear_e(tFIS_NF);
    putitem_o(tFIS_NF, 'CD_EMPRESA', vCdEmpresa);
    putitem_o(tFIS_NF, 'NR_FATURA', vNrFatura);
    putitem_o(tFIS_NF, 'DT_FATURA', vDtFatura);
    retrieve_e(tFIS_NF);
    if (xStatus >= 0) then begin
      clear_e(tFIS_NFITEM);
      putitem_o(tFIS_NFITEM, 'NR_ITEM', vNrItem);
      retrieve_e(tFIS_NFITEM);
      if (xStatus >= 0) then begin
        clear_e(tFIS_NFITEMPROD);
        putitem_o(tFIS_NFITEMPROD, 'CD_PRODUTO', vCdProduto);
        retrieve_e(tFIS_NFITEMPROD);
        if (xStatus >= 0) then begin
          vQtSaldo := item_f('QT_FATURADO', tFIS_NFITEMPROD);

          if (empty(tFIS_NFITEMCONT) = False) then begin
            if (vTpConsignado = 'DEVOLVER') then begin
              vQtConsignado := itemXmlF('QT_DEVOLVIDA', vDsItem);
              putitem_e(tFIS_NFITEMCONT, 'QT_DEVOLVIDA', item_f('QT_DEVOLVIDA', tFIS_NFITEMCONT) - vQtConsignado);
            end;
            if (vTpConsignado = 'FATURAR') then begin
              vQtConsignado := itemXmlF('QT_VendIDA', vDsItem);
              putitem_e(tFIS_NFITEMCONT, 'QT_VENDIDA', item_f('QT_VENDIDA', tFIS_NFITEMCONT) - vQtConsignado);
            end;

            vQtSaldo := vQtSaldo - item_f('QT_DEVOLVIDA', tFIS_NFITEMCONT) - item_f('QT_VENDIDA', tFIS_NFITEMCONT);

            if (vQtSaldo > 0) then begin
              putitem_e(tFIS_NFITEMCONT, 'TP_SITUACAO', 1);
            end;

            voParams := tFIS_NFITEMCONT.Salvar();
            if (xStatus < 0) then begin
              Result := voParams;
              return(-1); exit;
            end;
          end;
        end;
      end;
    end;

    delitemGld(vDsLstItem, 1);
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
  voParams : String;
  vDtFatura : TDateTime;
begin
  vCdEmpresa := itemXmlF('CD_EMPRESA', pParams);
  vNrFatura := itemXmlF('NR_FATURA', pParams);
  vDtFatura := itemXmlD('DT_FATURA', pParams);

  if (vCdEmpresa = 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN001', 'Empresa não informada!', cDS_METHOD);
    return(-1); exit;
  end;
  if (vNrFatura = 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN001', 'Número da fatura não informada!', cDS_METHOD);
    return(-1); exit;
  end;
  if (vDtFatura = 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN001', 'Data da fatura não informada!', cDS_METHOD);
    return(-1); exit;
  end;

  clear_e(tFIS_NF);
  putitem_o(tFIS_NF, 'CD_EMPRESA', vCdEmpresa);
  putitem_o(tFIS_NF, 'NR_FATURA', vNrFatura);
  putitem_o(tFIS_NF, 'DT_FATURA', vDtFatura);
  retrieve_e(tFIS_NF);
  if (xStatus < 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN001', 'Registro não cadastrado!', cDS_METHOD);
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

//--------------------------------------------------------------
function T_FISSVCO004.calculaTotalNF(pParams : String) : String;
//--------------------------------------------------------------
const
  cDS_METHOD = 'ADICIONAL=Operação: T_TSTSVCO001.calculaTotalNF()';
var
  vNrOccAnt, vQtFaturado, vVlTotalProduto, vVlDesconto, vVlTotalBruto : Real;
  vVlBaseICMS, vVlICMS, vVlBaseICMSSubst, vVlICMSSubst, vVlIPI, vVlCalc : Real;
begin
  vQtFaturado := 0;
  vVlTotalProduto := 0;
  vVlTotalBruto := 0;
  vVlDesconto := 0;
  vVlBaseICMS := 0;
  vVlICMS := 0;
  vVlBaseICMSSubst := 0;
  vVlICMSSubst := 0;
  vVlIPI := 0;

  clear_e(tFIS_NFITEM);
  retrieve_e(tFIS_NFITEM);
  if (xStatus >= 0) then begin
    setocc(tFIS_NFITEM, 1);
    while (xStatus >= 0) do begin
      vQtFaturado := vQtFaturado + item_f('QT_FATURADO', tFIS_NFITEM);
      vVlTotalProduto := vVlTotalProduto + item_f('VL_TOTALLIQUIDO', tFIS_NFITEM);
      vVlTotalBruto := vVlTotalBruto + item_f('VL_TOTALBRUTO', tFIS_NFITEM);
      vVlDesconto := vVlDesconto + item_f('VL_TOTALDESC', tFIS_NFITEM);
      if (empty(tFIS_NFITEMIMPOST) = False) then begin
        setocc(tFIS_NFITEMIMPOST, 1);
        while (xStatus >= 0) do begin
          if (item_f('CD_IMPOSTO', tFIS_NFITEMIMPOST) = 1) then begin
            vVlBaseICMS := vVlBaseICMS + item_f('VL_BASECALC', tFIS_NFITEMIMPOST);
            vVlICMS := vVlICMS + item_f('VL_IMPOSTO', tFIS_NFITEMIMPOST);
          end else if (item_f('CD_IMPOSTO', tFIS_NFITEMIMPOST) = 2) then begin
            vVlBaseICMSSubst := vVlBaseICMSSubst + item_f('VL_BASECALC', tFIS_NFITEMIMPOST);
            vVlICMSSubst := vVlICMSSubst + item_f('VL_IMPOSTO', tFIS_NFITEMIMPOST);
          end else if (item_f('CD_IMPOSTO', tFIS_NFITEMIMPOST) = 3) then begin
            vVlIPI := vVlIPI + item_f('VL_IMPOSTO', tFIS_NFITEMIMPOST);
          end;
          setocc(tFIS_NFITEMIMPOST, curocc(tFIS_NFITEMIMPOST) + 1);
        end;
      end;
      setocc(tFIS_NFITEM, curocc(tFIS_NFITEM) + 1);
    end;
  end;

  vVlCalc := (vVlTotalBruto - vVlTotalProduto) / vVlTotalBruto * 100;

  putitem_e(tFIS_NF, 'PR_DESCONTO', rounded(vVlCalc, 6));
  putitem_e(tFIS_NF, 'QT_FATURADO', vQtFaturado);
  putitem_e(tFIS_NF, 'VL_TOTALPRODUTO', vVlTotalProduto);
  putitem_e(tFIS_NF, 'VL_DESCONTO', vVlDesconto);
  putitem_e(tFIS_NF, 'VL_BASEICMS', vVlBaseICMS);
  putitem_e(tFIS_NF, 'VL_ICMS', vVlICMS);
  putitem_e(tFIS_NF, 'VL_BASEICMSSUBS', vVlBaseICMSSubst);
  putitem_e(tFIS_NF, 'VL_ICMSSUBST', vVlICMSSubst);
  putitem_e(tFIS_NF, 'VL_IPI', vVlIPI);
  putitem_e(tFIS_NF, 'VL_TOTALNOTA', item_f('VL_TOTALPRODUTO', tFIS_NF) + item_f('VL_DESPACESSOR', tFIS_NF) + item_f('VL_FRETE', tFIS_NF) + item_f('VL_SEGURO', tFIS_NF) + item_f('VL_IPI', tFIS_NF) + item_f('VL_ICMSSUBST', tFIS_NF));

  return(0); exit;
end;

initialization
  RegisterClass(T_FISSVCO004);

end.
