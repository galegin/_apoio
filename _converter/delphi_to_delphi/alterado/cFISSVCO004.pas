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
  piCdEmpresa := pParams.CD_EMPRESA;
  if (piCdEmpresa = 0) then begin
    piCdEmpresa := PARAM_GLB.CD_EMPRESA;
  end;

  xParam := '';
  putitem(xParam, 'CD_EMPVALOR');
  putitem(xParam, 'CD_MOTIVO_ALTVALOR_CMP');
  xParam := cADMSVCO001.Instance.GetParametro(xParam);

  gCdEmpresaValorSis := xParam.CD_EMPVALOR;
  gCdMotivoAltValor := xParam.CD_MOTIVO_ALTVALOR_CMP;

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
  xParamEmp := cADMSVCO001.Instance.GetParamEmpresa(piCdEmpresa, xParamEmp);

  gNrItemQuebraNf := xParamEmp.NR_ITEM_QUEBRA_NF;
  gCdEmpresaValorEmp := xParamEmp.CD_EMPRESA_VALOR;
  gCdSaldoPadrao := xParamEmp.CD_SALDOPADRAO;
  gCdSaldoCalcVlrMedio := xParamEmp.CD_SALDO_CALC_VLR_MEDIO;

  vTpQuebraCFOP := xParamEmp.TP_QUEBRA_NF_CFOP;
  if (vTpQuebraCFOP = 'S') then begin
    gInQuebraCFOP := True;
  end else begin
    gInQuebraCFOP := False;
  end;

  vInOptSimples := xParamEmp.IN_OPT_SIMPLES;
  if (vInOptSimples = 'S') then begin
    gInOptSimples := True;
  end else begin
    gInOptSimples := False;
  end;

  gCdTipoClas := xParamEmp.CD_TIPOCLAS_ITEM_NF;
  gInPDVOtimizado := xParamEmp.IN_PDV_OTIMIZADO;
  gDtEncerramento := itemXmlDU('DT_ENCERRAMENTO_FIS', xParamEmp);
  gCdCustoSemImp := xParamEmp.CD_CUSTO_S_IMPOSTO;
  gCdCustoMedioSemImp := xParamEmp.CD_CUSTO_MEDIO_S_IMPOSTO;
  gCdCusto1Venda := xParamEmp.CD_CUSTO1VENDA_REL_CONFIG;
  gCdCusto2Venda := xParamEmp.CD_CUSTO2VENDA_REL_CONFIG;
  gCdCusto3Venda := xParamEmp.CD_CUSTO3VENDA_REL_CONFIG;
  gCdOperEntEstTrans := xParamEmp.CD_OPER_ENT_EST_TRANS;
  gInSomaFrete := xParamEmp.IN_SOMA_FRETE_TOTALNF;
  gTpModDctoFiscal := xParamEmp.TP_MOD_DCTO_FISCAL;
  gInExibeResumoCstNF := xParamEmp.IN_EXIBE_RESUMO_CST_NF;
  gInBaixaPedPool := xParamEmp.IN_BAIXA_PED_POOL_EMP;
  gDsLstNivelGrupo := xParamEmp.DS_LST_NIVEL_GRUPO_NF;
  gDsLstNivelDescGrupo := xParamEmp.DS_LST_NIVEL_DES_GRUPO_NF;
  gInExibeResumoCfopNF := xParamEmp.IN_EXIBE_RESUMO_CFOP_NF;
  gTpEstoqueTerceiro := xParamEmp.TP_CONTR_EST_EM_TERCEIRO;
  gInLog := xParamEmp.IN_LOG_TEMPO_VENDA;
  gCdOperEntInspecao := xParamEmp.CD_OPER_ENT_INSPECAO;
  gTpAgrupamentoItemNF := xParamEmp.TP_AGRUPAMENTO_ITEM_NF;
  gDsLstOperEstTerceiro  := xParamEmp.DS_LST_OPER_EST_TERCEIRO;
  gDsLstOperEstTerceiro := ReplaceStr(gDsLstOperEstTerceiro, #$17, '|');         // gold + paipe
  gDsCustoSubstTributaria := xParamEmp.DS_CUSTO_SUBST_TRIBUTARIA;
  gDsCustoValorRetido := xParamEmp.DS_CUSTO_VALOR_RETIDO;
  gCdSaldoEstTerceiro := xParamEmp.CD_SALDO_EST_TERCEIRO;
  gCdSaldoEstDeTerc := xParamEmp.CD_SALDO_EST_DE_TERC;
  gDsLstOperEstDeTerc := xParamEmp.DS_LST_OPER_EST_DE_TERC;
  gDsLstOperEstDeTerc := ReplaceStr(gDsLstOperEstDeTerc, #$17, '|');             // gold + paipe
  gInGravaDsDecretoObsNf := xParamEmp.IN_GRAVA_DS_DECRETO_OBSNF;
  gUfOrigem := xParamEmp.UF_ORIGEM;
  gPrAplicMvaSubTrib := xParamEmp.PR_APLIC_MVA_SUB_TRIB;
  gDsEmbLegalSubTrib := xParamEmp.DS_EMB_LEGAL_SUB_TRIB;
  gInExibeQtdProdNF := xParamEmp.IN_EXIBE_QTD_PROD_NF;
  gTpImpressaoCodPrdEcf := xParamEmp.TP_IMPRESSAO_COD_PRD_ECF;
  gTpLancamentoFrete := xParamEmp.TP_LANCAMENTO_FRETE_TRA;
  gInArredondaTruncaICMS := xParamEmp.IN_ARREDONDA_TRUNCA_ICMS;
  gTpImpObsRegraFiscalNf := xParamEmp.TP_IMP_OBS_REGRAFISCAL_NF;
  gInIncluiIpiDevSimp := xParamEmp.IN_INCLUI_IPI_DEV_SIMP;
  gDsObsNf := xParamEmp.DS_OBS_NF;
  gInGravaObsNf := xParamEmp.IN_GRAVA_OBS_NF;
  gDsLstOperObrigNfRef := xParamEmp.DS_LST_OPER_OBRIG_NF_REF;
  gPrTotalTributo := xParamEmp.PR_TOTAL_TRIBUTO;

  gDsLstModDctoFiscal := xParamEmp.DS_LST_MODDCTOFISCAL_AT;
  if (gDsLstModDctoFiscal <> '') then begin
    gDsLstModDctoFiscal := ReplaceStr(gDsLstModDctoFiscal, #$1B, ';');           // gold + ponto e virgula
    repeat
      getitem(vTpDctoFiscal, gDsLstModDctoFiscal, 1);
      if (vTpDctoFiscal > 0) then begin
        fF_TMP_NR08.Append();
        fF_TMP_NR08.NR_08 := vTpDctoFiscal;
        fF_TMP_NR08.Consultar();
      end;
      delitemGld(gDsLstModDctoFiscal, 1);
    until (gDsLstModDctoFiscal = '');
  end;
end;

//---------------------------------------------------------------
function T_FISSVCO004.setEntidade(pParams : String = '') : String;
//---------------------------------------------------------------
begin
  tF_TMP_NR08 := TTMP_NR08.Create(nil);
  tF_TMP_NR09 := TTMP_NR09.Create(nil);
  tTMP_CSTALIQ := TTMP_CSTALIQ.Create(nil);
  tTMP_K02 := TTMP_K02.Create(nil);
  tTMP_NR08 := TTMP_NR08.Create(nil);
  tTMP_NR09 := TTMP_NR09.Create(nil);
  tFIS_DECRETO := TFIS_DECRETO.Create(nil);
  tFIS_ECF := TFIS_ECF.Create(nil);
  tFIS_NF := TFIS_NF.Create(nil);
  tFIS_NFECF := TFIS_NFECF.Create(nil);
  tFIS_NFIMPOSTO := TFIS_NFIMPOSTO.Create(nil);
  //tFIS_NFISELOENT := TFIS_NFISELOENT.Create(nil);
  tFIS_NFITEM := TFIS_NFITEM.Create(nil);
  //tFIS_NFITEMCONT := TFIS_NFITEMCONT.Create(nil);
  //tFIS_NFITEMDESP := TFIS_NFITEMDESP.Create(nil);
  tFIS_NFITEMIMPOST := TFIS_NFITEMIMPOST.Create(nil);
  //tFIS_NFITEMPLOTE := TFIS_NFITEMPLOTE.Create(nil);
 // tFIS_NFITEMPPRDFIN := TFIS_NFITEMPPR.Create(nil);
  tFIS_NFITEMPROD := TFIS_NFITEMPROD.Create(nil);
  //tFIS_NFITEMSERIAL := TFIS_NFITEMSERIAL.Create(nil);
  tFIS_NFITEMUN := TFIS_NFITEMUN.Create(nil);
  tFIS_NFITEMVL := TFIS_NFITEMVL.Create(nil);
  tFIS_NFITEMADIC := TFIS_NFITEMADIC.Create(nil);
  tFIS_NFREF := TFIS_NFREF.Create(nil);
  tFIS_NFREMDES := TFIS_NFREMDES.Create(nil);
  //tFIS_NFSELOENT := TFIS_NFSELOENT.Create(nil);
  tFIS_NFTRANSP := TFIS_NFTRANSP.Create(nil);
  tFIS_NFVENCTO := TFIS_NFVENCTO.Create(nil);
  tFIS_S_NF := TFIS_NF.Create(nil);
  tGER_MODNFC := TGER_MODNFC.Create(nil);
  tGER_OPERACAO := TGER_OPERACAO.Create(nil);
  tGER_S_OPERACAO := TGER_OPERACAO.Create(nil);
  tGER_SERIE := TGER_SERIE.Create(nil);
  tOBS_NF := TOBS_NF.Create(nil);
  tOBS_TRANSACNF := TOBS_TRANSACNF.Create(nil);
  tPRD_CLASSIFICACAO := TPRD_CLASSIFICACAO.Create(nil);
  tPRD_PRODUTOCLAS := TPRD_PRODUTOCLAS.Create(nil);
  tPRD_TIPOCLAS := TPRD_TIPOCLAS.Create(nil);
  tTRA_ITEMIMPOSTO := TTRA_ITEMIMPOSTO.Create(nil);
  //tTRA_ITEMLOTE := TTRA_ITEMLOTE.Create(nil);
  //tTRA_ITEMPRDFIN := TTRA_ITEMPRDFIN.Create(nil);
  //tTRA_ITEMSELOENT := TTRA_ITEMSELOENT.Create(nil);
  //tTRA_ITEMSERIAL := TTRA_ITEMSERIAL.Create(nil);
  tTRA_ITEMUN := TTRA_ITEMUN.Create(nil);
  tTRA_ITEMVL := TTRA_ITEMVL.Create(nil);
  tTRA_REMDES := TTRA_REMDES.Create(nil);
  //tTRA_SELOENT := TTRA_SELOENT.Create(nil);
  tTRA_TRANREF := TTRA_TRANREF.Create(nil);
  tTRA_TRANSACAO := TTRA_TRANSACAO.Create(nil);
  tTRA_TRANSACECF := TTRA_TRANSACECF.Create(nil);
  tTRA_TRANSITEM := TTRA_TRANSITEM.Create(nil);
  tTRA_TRANSPORT := TTRA_TRANSPORT.Create(nil);
  tTRA_VENCIMENTO := TTRA_VENCIMENTO.Create(nil);
  tV_FIS_NFREMDES := TFIS_NFREMDES.Create(nil);

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

  if (fTRA_TRANSACAO.TP_ORIGEMEMISSAO = 2) then begin
    viParams := '';
    viParams.CD_EMPRESA := fTRA_TRANSACAO.CD_EMPRESA;
    viParams.NR_TRANSACAO := fTRA_TRANSACAO.NR_TRANSACAO;
    viParams.DT_TRANSACAO := fTRA_TRANSACAO.DT_TRANSACAO;
    voParams := cSICSVCO005.Instance.buscaSequencia(viParams); 
    if (itemXmlF('status', voParams) < 0) then begin
      raise Exception.Create(itemXml('message', voParams));
      
    end;
    gNrFatura := voParams.NR_FATURA;
  end else begin
    if (fTRA_TRANSACAO.CD_EMPFAT <>  PARAM_GLB.CD_EMPRESA) then begin
      if (gDsLstFatura <> '') then begin
        getitem(gNrFatura, gDsLstFatura, 1);
        delitemGld(gDsLstFatura, 1);
      end;
    end;
    if (gNrFatura = 0) then begin
      viParams := '';
      viParams.NM_ENTIDADE := 'FIS_NF';
      voParams := cGERSVCO031.Instance.getNumSeq(viParams); 
      if (itemXmlF('status', voParams) < 0) then begin
        raise Exception.Create(itemXml('message', voParams));
        
      end;
      gNrFatura := voParams.NR_SEQUENCIA;
    end;
    if (fTRA_TRANSACAO.CD_EMPFAT =  PARAM_GLB.CD_EMPRESA) then begin
      putitem(gDsLstFatura, FloatToStr(gNrFatura));
    end;
  end;
  if (gNrFatura = 0) then begin
    raise Exception.Create('Não foi possível obter nr. de fatura da NF' + ' / ' := cDS_METHOD);
    
  end;
  if (gDtFatura <> 0) then begin
    vDtSistema := gDtFatura;
  end else begin
    vDtSistema := PARAM_GLB.DT_SISTEMA;
  end;

  fFIS_NF.Append();
  fFIS_NF.CD_EMPRESA := fTRA_TRANSACAO.CD_EMPFAT;
  fFIS_NF.NR_FATURA := gNrFatura;
  fFIS_NF.DT_FATURA := vDtSistema;
  fFIS_NF.CD_PESSOA := fTRA_TRANSACAO.CD_PESSOA;

  if (fTRA_TRANSACAO.TP_ORIGEMEMISSAO = 2) then begin
    fFIS_NF.NR_NF := gNrNf;
    fFIS_NF.CD_SERIE := gCdSerie;
    fFIS_NF.DT_EMISSAO := gDtEmissao;
    fFIS_NF.DT_SAIDAENTRADA := gDtSaidaEntrada;

    if (fGER_S_OPERACAO.TP_DOCTO = 0) then begin
      fFIS_NF.TP_SITUACAO := 'N';
    end else begin
      fFIS_NF.TP_SITUACAO := 'E';
    end;

  end else begin
    if (gInReemissao) then begin
      fFIS_NF.DT_FATURA := gDtEmissao;
      fFIS_NF.NR_NF := gNrNf;
      fFIS_NF.CD_SERIE := gCdSerie;
      fFIS_NF.DT_EMISSAO := gDtEmissao;
      fFIS_NF.TP_SITUACAO := 'E';
      fFIS_NF.DT_SAIDAENTRADA := gDtEmissao;
    end else begin
      fFIS_NF.TP_SITUACAO := 'N';
      fFIS_NF.DT_SAIDAENTRADA := gDtSaidaEntrada;
    end;
  end;

  fFIS_NF.TP_ORIGEMEMISSAO := fTRA_TRANSACAO.TP_ORIGEMEMISSAO;
  fFIS_NF.TP_OPERACAO := fTRA_TRANSACAO.TP_OPERACAO;

  if (gTpModDctoFiscalLocal > 0) then begin
    fFIS_NF.TP_MODDCTOFISCAL := gTpModDctoFiscalLocal;
  end else begin
    if (gTpModDctoFiscal = 0) then begin
      fFIS_NF.TP_MODDCTOFISCAL := 02;
    end else begin
      fFIS_NF.TP_MODDCTOFISCAL := gTpModDctoFiscal;
    end;
  end;
  if (fGER_S_OPERACAO.TP_MODALIDADE = 'D') then begin
    fFIS_NF.TP_MODDCTOFISCAL := 85;
  end else if (fGER_S_OPERACAO.TP_MODALIDADE = 'G') then begin
    fFIS_NF.TP_MODDCTOFISCAL := 87;
  end;

  fFIS_NF.CD_EMPFAT := fTRA_TRANSACAO.CD_EMPFAT;
  fFIS_NF.CD_GRUPOEMPRESA := fTRA_TRANSACAO.CD_GRUPOEMPRESA;
  fFIS_NF.CD_OPERADOR := PARAM_GLB.CD_USUARIO;
  fFIS_NF.DT_CADASTRO := Now;
  fFIS_NF.NR_PRE := 0;
  fFIS_NF.CD_CONDPGTO := fTRA_TRANSACAO.CD_CONDPGTO;
  fFIS_NF.CD_OPERACAO := fGER_OPERACAO.CD_OPERFAT;
  fFIS_NF.CD_MODELONF := gCdModeloNF;
  fFIS_NF.CD_EMPRESAORI := fTRA_TRANSACAO.CD_EMPRESA;
  fFIS_NF.NR_TRANSACAOORI := fTRA_TRANSACAO.NR_TRANSACAO;
  fFIS_NF.DT_TRANSACAOORI := fTRA_TRANSACAO.DT_TRANSACAO;

  if (gHrSaida = 0) then begin
    fFIS_NF.HR_SAIDA := TimeToStr(Time);
  end else begin
    fFIS_NF.HR_SAIDA := gHrSaida;
  end;

  fFIS_NF.CD_COMPVEND := fTRA_TRANSACAO.CD_COMPVEND;
  fFIS_NF.IN_FRETE := fTRA_TRANSACAO.IN_FRETE;
  fFIS_NF.PR_DESCONTO := fTRA_TRANSACAO.PR_DESCONTO;
  fFIS_NF.QT_FATURADO := 0;
  fFIS_NF.VL_TOTALPRODUTO := 0;
  fFIS_NF.VL_DESPACESSOR := 0;
  fFIS_NF.VL_FRETE := 0;
  fFIS_NF.VL_SEGURO := 0;
  fFIS_NF.VL_IPI := 0;
  fFIS_NF.VL_DESCONTO := 0;
  fFIS_NF.VL_TOTALNOTA := 0;
  fFIS_NF.VL_BASEICMSSUBS := 0;
  fFIS_NF.VL_ICMSSUBST := 0;
  fFIS_NF.VL_BASEICMS := 0;
  fFIS_NF.VL_ICMS := 0;

  fTMP_CSTALIQ.Limpar();

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
  piDsLstProduto := pParams.DS_LSTPRODUTO;
  piNrItem := pParams.NR_ITEM;

  vCdTIPI := '';
  vDsTIPI := '';

  if (fTRA_TRANSITEM.CD_PRODUTO > 0) and (fTRA_TRANSITEM.CD_ESPECIE <> gCdEspecieServico) then begin
    if (fTRA_TRANSITEM.CD_TIPI = '') then begin
      viParams := '';
      viParams.CD_PRODUTO := fTRA_TRANSITEM.CD_PRODUTO;
      voParams := cGERSVCO046.Instance.buscaDadosProduto(viParams);
      if (itemXmlF('status', voParams) < 0) then begin
        raise Exception.Create(itemXml('message', voParams));
        
      end;
      vCdTIPI := voParams.CD_TIPI;
      vDsTIPI := voParams.DS_TIPI;
    end else begin
      vCdTIPI := fTRA_TRANSITEM.CD_TIPI;
      viParams := '';
      viParams.CD_TIPI := vCdTIPI;
      voParams := cGERSVCO046.Instance.buscaDadosFiscal(viParams);
      if (itemXmlF('status', voParams) < 0) then begin
        raise Exception.Create(itemXml('message', voParams));
        
      end;

      vDsTIPI := voParams.DS_TIPI;
    end;
  end;
  if (fTRA_TRANSITEM.CD_BARRAPRD <> '') and (item_a('CD_ESPECIE', tTRA_TRANSITEM) <> gCdEspecieServico) then begin
    vCdTIPI := fTRA_TRANSITEM.CD_TIPI;
    if (vCdTIPI <> '') then begin
      viParams := '';
      viParams.CD_TIPI := vCdTIPI;
      voParams := cGERSVCO046.Instance.buscaDadosFiscal(viParams);
      if (itemXmlF('status', voParams) < 0) then begin
        raise Exception.Create(itemXml('message', voParams));
        
      end;

      vDsTIPI := voParams.DS_TIPI;
    end;
  end;
  if (fFIS_NFITEM.QT_FATURADO = 0) or (fFIS_NFITEM.QT_FATURADO = 1)
  or (PARAM_GLB.TP_ARREDOND_VL_UNIT_VD = 1) or (PARAM_GLB.TP_ARREDOND_VL_UNIT_VD = 2) then begin
    vInCopiaValor := True;
  end else begin
    vInCopiaValor := False;
  end;

  fFIS_NFITEM.Append();
  fFIS_NFITEM.NR_ITEM := piNrItem;
  fFIS_NFITEM.CD_EMPFAT := fTRA_TRANSACAO.CD_EMPFAT;
  fFIS_NFITEM.CD_GRUPOEMPRESA := fTRA_TRANSACAO.CD_GRUPOEMPRESA;
  fFIS_NFITEM.CD_OPERADOR := PARAM_GLB.CD_USUARIO;
  fFIS_NFITEM.DT_CADASTRO := Now;
  fFIS_NFITEM.IN_DESCONTO := fTRA_TRANSITEM.IN_DESCONTO;
  fFIS_NFITEM.CD_ESPECIE := fTRA_TRANSITEM.CD_ESPECIE;
  fFIS_NFITEM.CD_CST := fTRA_TRANSITEM.CD_CST;
  fFIS_NFITEM.CD_CFOP := fTRA_TRANSITEM.CD_CFOP;
  fFIS_NFITEM.CD_DECRETO := fTRA_TRANSITEM.CD_DECRETO;
  fFIS_NFITEM.CD_TIPI := vCdTIPI;
  fFIS_NFITEM.QT_FATURADO := fTRA_TRANSITEM.QT_SOLICITADA;
  fFIS_NFITEM.VL_TOTALBRUTO := fTRA_TRANSITEM.VL_TOTALBRUTO;
  fFIS_NFITEM.VL_TOTALLIQUIDO := fTRA_TRANSITEM.VL_TOTALLIQUIDO;
  fFIS_NFITEM.VL_TOTALDESC := fTRA_TRANSITEM.VL_TOTALDESC + item_f('VL_TOTALDESCCAB', tTRA_TRANSITEM);

  if (gInCalcTributo) then begin
    vVlValor := (fFIS_NFITEM.VL_TOTALBRUTO * gPrTotalTributo) / 100;
    vVlValor := rounded(vVlValor, 6);
    fFIS_NFITEMADIC.VL_TOTALTRIBUTO := vVlValor;
    fFIS_NFITEMADIC.CD_OPERADOR := PARAM_GLB.CD_USUARIO;
    fFIS_NFITEMADIC.DT_CADASTRO := Now;

    voParams := tFIS_NFITEMADIC.Salvar();
    if (itemXmlF('status', voParams) < 0) then begin
      raise Exception.Create(itemXml('message', voParams));
      
    end;
  end;

  if (vInCopiaValor = True) and (gTpAgrupamentoItemNF <> 1) then begin
    fFIS_NFITEM.VL_UNITBRUTO := fTRA_TRANSITEM.VL_UNITBRUTO;
    fFIS_NFITEM.VL_UNITLIQUIDO := fTRA_TRANSITEM.VL_UNITLIQUIDO;
    fFIS_NFITEM.VL_UNITDESC := fTRA_TRANSITEM.VL_UNITDESC + item_f('VL_UNITDESCCAB', tTRA_TRANSITEM);
  end else begin
    vVlValor := fFIS_NFITEM.VL_TOTALBRUTO / item_f('QT_FATURADO', tFIS_NFITEM);
    fFIS_NFITEM.VL_UNITBRUTO := rounded(vVlValor, 6);
    vVlValor := fFIS_NFITEM.VL_TOTALLIQUIDO / item_f('QT_FATURADO', tFIS_NFITEM);
    fFIS_NFITEM.VL_UNITLIQUIDO := rounded(vVlValor, 6);
    vVlValor := fFIS_NFITEM.VL_TOTALDESC / item_f('QT_FATURADO', tFIS_NFITEM);
    fFIS_NFITEM.VL_UNITDESC := rounded(vVlValor, 6);
  end;
  vVlValor := (fFIS_NFITEM.VL_TOTALDESC / item_f('VL_TOTALBRUTO', tFIS_NFITEM)) * 100;
  fFIS_NFITEM.PR_DESCONTO := rounded(vVlValor, 6);

  if (gInExibeResumoCfopNF) then begin
    fF_TMP_NR09.Append();
    fF_TMP_NR09.NR_GERAL := fFIS_NFITEM.CD_CFOP;
    fF_TMP_NR09.Consultar();
    if (xStatus = -7) then begin
      fF_TMP_NR09.Consultar();
    end;

    fF_TMP_NR09.VL_TOTAL := fF_TMP_NR09.VL_TOTAL + item_f('VL_TOTALLIQUIDO', tFIS_NFITEM);
    fF_TMP_NR09.QT_ITEM := fF_TMP_NR09.QT_ITEM + item_f('QT_FATURADO', tFIS_NFITEM);
  end;
  if (fTRA_TRANSITEM.CD_ESPECIE = gCdEspecieServico) then begin
    if (fTRA_TRANSITEM.CD_PRODUTO = 0) then begin
      fFIS_NFITEM.CD_PRODUTO := fTRA_TRANSITEM.CD_BARRAPRD;
    end else begin
      fFIS_NFITEM.CD_PRODUTO := fTRA_TRANSITEM.CD_PRODUTO;
    end;
    fFIS_NFITEM.DS_PRODUTO := fTRA_TRANSITEM.DS_PRODUTO;
  end else begin
    if (fTRA_TRANSITEM.CD_PRODUTO = 0) and (fTRA_TRANSITEM.CD_BARRAPRD = '') then begin
      fFIS_NFITEM.DS_PRODUTO := fTRA_TRANSITEM.DS_PRODUTO;
      fFIS_NFITEM.IN_DESCONTO := '';
      fFIS_NFITEM.CD_ESPECIE := '';
      fFIS_NFITEM.CD_CST := '';
      fFIS_NFITEM.CD_CFOP := '';
      fFIS_NFITEM.CD_DECRETO := '';
      fFIS_NFITEM.CD_TIPI := '';
      fFIS_NFITEM.QT_FATURADO := '';
      fFIS_NFITEM.VL_TOTALBRUTO := '';
      fFIS_NFITEM.VL_TOTALLIQUIDO := '';
      fFIS_NFITEM.VL_TOTALDESC := '';
      fFIS_NFITEM.VL_UNITBRUTO := '';
      fFIS_NFITEM.VL_UNITLIQUIDO := '';
      fFIS_NFITEM.VL_UNITDESC := '';
      fFIS_NFITEM.PR_DESCONTO := '';
    end else begin
      if (gTpCodigoItem = 1) then begin
        fFIS_NFITEM.CD_PRODUTO := copy(fTRA_TRANSITEM.CD_NIVELGRUPO,1,14);
        fFIS_NFITEM.DS_PRODUTO := copy(fTRA_TRANSITEM.DS_NIVELGRUPO,1,60);
      end else if (gTpCodigoItem = 2) then begin
        vCdItem := '';
        vDsItem := '';
        fPRD_TIPOCLAS.First();
        while not t.EOF do begin
          fPRD_PRODUTOCLAS.Limpar();
          fPRD_PRODUTOCLAS.CD_PRODUTO := fTRA_TRANSITEM.CD_PRODUTO;
          fPRD_PRODUTOCLAS.CD_TIPOCLAS := fPRD_TIPOCLAS.CD_TIPOCLAS;
          fPRD_PRODUTOCLAS.Listar();
          if (xStatus >= 0) then begin
            vCdItem := vCdItem + fPRD_PRODUTOCLAS.CD_CLASSIFICACAO + ' ';
            vDsItem := vDsItem + fPRD_CLASSIFICACAO.DS_CLASSIFICACAO + ' ';
          end;
          fPRD_TIPOCLAS.Next();
        end;
        fFIS_NFITEM.CD_PRODUTO := copy(vCdItem,1,14);
        fFIS_NFITEM.DS_PRODUTO := copy(vDsItem,1,60);
      end else if (gTpCodigoItem = 3) then begin
        fFIS_NFITEM.CD_PRODUTO := vCdTIPI;
        fFIS_NFITEM.DS_PRODUTO := vDSTIPI;
      end else if (gTpCodigoItem = 5) then begin
        if (gTpAgrupamento = 'F') or (gTpAgrupamento = '') then begin
          viParams := '';
          viParams.CD_PRODUTO := fTRA_TRANSITEM.CD_PRODUTO;
          viParams.CD_PESSOA := fTRA_TRANSACAO.CD_PESSOA;
          voParams := cPRDSVCO023.Instance.buscaDadosProduto(viParams);
          if (itemXmlF('status', voParams) < 0) then begin
            raise Exception.Create(itemXml('message', voParams));
            
          end;
          fFIS_NFITEM.CD_PRODUTO := copy(voParams.CD_ORIGEM,1,14);
          fFIS_NFITEM.DS_PRODUTO := copy(voParams.DS_ORIGEM,1,60);
        end else begin
          viParams := '';
          viParams.CD_SEQGRUPO := fTRA_TRANSITEM.CD_SEQGRUPO;
          viParams.CD_PESSOA := fTRA_TRANSACAO.CD_PESSOA;
          voParams := cPRDSVCO023.Instance.buscaDadosGrupo(viParams);
          if (itemXmlF('status', voParams) < 0) then begin
            raise Exception.Create(itemXml('message', voParams));
            
          end;
          fFIS_NFITEM.CD_PRODUTO := copy(voParams.CD_ORIGEM,1,14);
          fFIS_NFITEM.DS_PRODUTO := copy(voParams.DS_ORIGEM,1,60);
        end;
      end else if (gTpCodigoItem = 6) then begin
        fTRA_TRANSITEM.CD_NIVELGRUPO := ReplaceStr(fTRA_TRANSITEM.CD_NIVELGRUPO, ' ', '');
        fFIS_NFITEM.CD_PRODUTO := copy(fTRA_TRANSITEM.CD_NIVELGRUPO,1,14);
        fFIS_NFITEM.DS_PRODUTO := copy(fTRA_TRANSITEM.DS_NIVELGRUPO,1,60);
      end else if (gTpCodigoItem = 7) then begin
        viParams := '';
        viParams.CD_EMPRESA := fTRA_TRANSACAO.CD_EMPRESA;
        viParams.NR_TRANSACAO := fTRA_TRANSACAO.NR_TRANSACAO;
        viParams.DT_TRANSACAO := fTRA_TRANSACAO.DT_TRANSACAO;
        if (gTpAgrupamento = 'F') or (gTpAgrupamento = '') then begin
          viParams.CD_PRODUTO := fTRA_TRANSITEM.CD_PRODUTO;
        end else begin
          viParams.CD_SEQGRUPO := fTRA_TRANSITEM.CD_SEQGRUPO;
        end;
        voParams := cPRDSVCO015.Instance.retornaDadosPedidoG(viParams);
        if (itemXmlF('status', voParams) < 0) then begin
          raise Exception.Create(itemXml('message', voParams));
          
        end;
        fFIS_NFITEM.CD_PRODUTO := copy(voParams.CD_NIVELFAT,1,14);
        fFIS_NFITEM.DS_PRODUTO := copy(voParams.DS_NIVELFAT,1,60);
      end else begin
        if (fTRA_TRANSITEM.CD_PRODUTO = 0) then begin
          fFIS_NFITEM.CD_PRODUTO := fTRA_TRANSITEM.CD_BARRAPRD;
          fFIS_NFITEM.CD_TIPI := fTRA_TRANSITEM.CD_TIPI;
        end else begin
          fFIS_NFITEM.CD_PRODUTO := fTRA_TRANSITEM.CD_PRODUTO;
        end;
        fFIS_NFITEM.DS_PRODUTO := fTRA_TRANSITEM.DS_PRODUTO;
      end;
      if (fFIS_NFITEM.CD_PRODUTO = '') or (item_a('DS_PRODUTO', tFIS_NFITEM) = '') then begin
        if (gTpAgrupamento = 'F') or (gTpAgrupamento = '') then begin
          if (fTRA_TRANSITEM.CD_PRODUTO = 0) then begin
            fFIS_NFITEM.CD_PRODUTO := fTRA_TRANSITEM.CD_BARRAPRD;
          end else begin
            fFIS_NFITEM.CD_PRODUTO := fTRA_TRANSITEM.CD_PRODUTO;
          end;
          fFIS_NFITEM.DS_PRODUTO := fTRA_TRANSITEM.DS_PRODUTO;
        end else begin
          fFIS_NFITEM.CD_PRODUTO := copy(fTRA_TRANSITEM.CD_NIVELGRUPO,1,14);
          fFIS_NFITEM.DS_PRODUTO := copy(fTRA_TRANSITEM.DS_NIVELGRUPO,1,60);
        end;
      end;
    end;
  end;

  fFIS_NFITEM.CD_PRODUTO := limpaString(fFIS_NFITEM.CD_PRODUTO);
  fFIS_NFITEM.DS_PRODUTO := limpaString(fFIS_NFITEM.DS_PRODUTO);

  if (fFIS_NFITEM.CD_PRODUTO <> '') then begin
    if (fFIS_NFITEM.CD_CFOP = 0) then begin
      raise Exception.Create('Falta CFOP no produto ' + fFIS_NFITEM.CD_PRODUTO + '!' + ' / ' := cDS_METHOD);
      
    end;
    if (fFIS_NFITEM.CD_CST = '') then begin
      raise Exception.Create('Falta CST no produto ' + fFIS_NFITEM.CD_PRODUTO + '!' + ' / ' := cDS_METHOD);
      
    end;
  end;

  vInObs := False;

  if (fFIS_NFITEM.CD_DECRETO = 1020) or (fFIS_NFITEM.CD_DECRETO = 10201) or (fFIS_NFITEM.CD_DECRETO = 10202) or (fFIS_NFITEM.CD_DECRETO = 10203) then begin
    if (gPrAplicMvaSubTrib <> '') and (gUfOrigem = 'SC') and (gUfDestino = 'SC') and ((gTpRegimeTrib = 2) or (gTpRegimeTrib = 3)) then begin
      fTMP_NR08.Append();
      fTMP_NR08.NR_08 := 1;
      fTMP_NR08.Consultar();
      if (xStatus = 0) then begin
        if (gDsAdicionalRegra = '') then begin
          gDsAdicionalRegra := gDsEmbLegalSubTrib;
        end else begin
          gDsAdicionalRegra := gDsAdicionalRegra + ' ' + gDsEmbLegalSubTrib;
        end;
      end;
    end;
  end;
  if (piDsLstProduto <> '') and (fFIS_NFITEM.CD_ESPECIE <> gCdEspecieServico) then begin
    repeat
      getitem(vDsRegistro, piDsLstProduto, 1);
      vCdProduto := vDsRegistro.CD_PRODUTO;
      if (vCdProduto <> 0) then begin
        fFIS_NFITEMPROD.Append();
        fFIS_NFITEMPROD.CD_PRODUTO := vCdProduto;
        fFIS_NFITEMPROD.Consultar();
        if (xStatus = -7) then begin
          fFIS_NFITEMPROD.Consultar();
        end;
        fFIS_NFITEMPROD.CD_EMPFAT := fTRA_TRANSACAO.CD_EMPFAT;
        fFIS_NFITEMPROD.CD_GRUPOEMPRESA := fTRA_TRANSACAO.CD_GRUPOEMPRESA;
        fFIS_NFITEMPROD.QT_FATURADO := fFIS_NFITEMPROD.QT_FATURADO := vDsRegistro.QT_FATURADO;
        fFIS_NFITEMPROD.VL_UNITBRUTO := vDsRegistro.VL_UNITBRUTO;
        fFIS_NFITEMPROD.VL_UNITDESC := vDsRegistro.VL_UNITDESC;
        fFIS_NFITEMPROD.VL_UNITLIQUIDO := vDsRegistro.VL_UNITLIQUIDO;
        fFIS_NFITEMPROD.VL_TOTALDESC := fFIS_NFITEMPROD.VL_TOTALDESC := vDsRegistro.VL_TOTALDESC;
        fFIS_NFITEMPROD.VL_TOTALLIQUIDO := fFIS_NFITEMPROD.VL_TOTALLIQUIDO := vDsRegistro.VL_TOTALLIQUIDO;
        fFIS_NFITEMPROD.VL_TOTALBRUTO := fFIS_NFITEMPROD.VL_TOTALBRUTO := vDsRegistro.VL_TOTALBRUTO;
        fFIS_NFITEMPROD.CD_COMPVEND := vDsRegistro.CD_COMPVEND;
        fFIS_NFITEMPROD.CD_PROMOCAO := vDsRegistro.CD_PROMOCAO;
        fFIS_NFITEMPROD.CD_OPERADOR := PARAM_GLB.CD_USUARIO;
        fFIS_NFITEMPROD.DT_CADASTRO := Now;

        if ((gPrAplicMvaSubTrib = '') and (gInPDVOtimizado = True)) or (gTpImpObsRegraFiscalNf = 1) then begin
          vInObs := False;
          viParams := '';
          viParams.CD_PRODUTO := fFIS_NFITEMPROD.CD_PRODUTO;
          viParams.CD_OPERACAO := fGER_OPERACAO.CD_OPERACAO;
          voParams := cFISSVCO033.Instance.buscaRegraFiscalProduto(viParams);
          if (itemXmlF('status', voParams) < 0) then begin
            raise Exception.Create(itemXml('message', voParams));
            
          end;

          vCdRegraFiscalProd := voParams.CD_REGRAFISCAL;

          if (vCdRegraFiscalProd <> 0) then begin
            fTMP_NR08.Append();
            fTMP_NR08.NR_08 := vCdRegraFiscalProd;
            fTMP_NR08.Consultar();
            if (xStatus = 0) then begin
              viParams := '';
              viParams.CD_REGRAFISCAL := vCdRegraFiscalProd;
              voParams := cFISSVCO033.Instance.buscaDadosRegraFiscal(viParams);
              if (itemXmlF('status', voParams) < 0) then begin
                raise Exception.Create(itemXml('message', voParams));
                
              end;

              vTpReducao := voParams.TP_REDUCAO;
              vTpAliqIcms := voParams.TP_ALIQICMS;

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

              if (fGER_S_OPERACAO.CD_REGRAFISCAL > 0) then begin
                vCdRegraFiscal := fGER_S_OPERACAO.CD_REGRAFISCAL;
              end else if (fGER_OPERACAO.CD_REGRAFISCAL > 0) then begin
                vCdRegraFiscal := fGER_OPERACAO.CD_REGRAFISCAL;
              end;
              if (vCdRegraFiscalProd <> vCdRegraFiscal) and (vInObs) then begin
                if (gDsAdicionalRegra = '') then begin
                  gDsAdicionalRegra := voParams.DS_ADICIONAL;
                end else begin
                  gDsAdicionalRegra := gDsAdicionalRegra + ' ' := voParams.DS_ADICIONAL;
                end;
              end;
            end;
          end;
        end;
        if (fGER_OPERACAO.TP_MODALIDADE = 'C') and (item_a('TP_OPERACAO', tGER_OPERACAO) = 'S') and (item_a('TP_MODALIDADE', tGER_S_OPERACAO) = 'C') then begin
          fFIS_NFITEMCONT.Append();
          fFIS_NFITEMCONT.CD_EMPRESA := fFIS_NFITEMPROD.CD_EMPRESA;
          fFIS_NFITEMCONT.NR_FATURA := fFIS_NFITEMPROD.NR_FATURA;
          fFIS_NFITEMCONT.DT_FATURA := fFIS_NFITEMPROD.DT_FATURA;
          fFIS_NFITEMCONT.NR_ITEM := fFIS_NFITEMPROD.NR_ITEM;
          fFIS_NFITEMCONT.CD_PRODUTO := fFIS_NFITEMPROD.CD_PRODUTO;
          fFIS_NFITEMCONT.Consultar();
          if (xStatus = -7) then begin
            fFIS_NFITEMCONT.Consultar();
          end;
          fFIS_NFITEMCONT.CD_EMPFAT := fFIS_NFITEMPROD.CD_EMPFAT;
          fFIS_NFITEMCONT.CD_GRUPOEMPRESA := fFIS_NFITEMPROD.CD_GRUPOEMPRESA;
          fFIS_NFITEMCONT.TP_SITUACAO := 1;
          fFIS_NFITEMCONT.CD_OPERADOR := PARAM_GLB.CD_USUARIO;
          fFIS_NFITEMCONT.DT_CADASTRO := Now;
        end;

        vDsLstItemUn := vDsRegistro.DS_LSTITEMUN;
        if (vDsLstItemUn <> '') then begin
          fFIS_NFITEMUN.Append();

          fFIS_NFITEMUN.Consultar();
          if (xStatus = -7) then begin
            fFIS_NFITEMUN.Consultar();
          end;

          vDsLstItemUn := fFIS_NFITEMUN.GetValues();
          fFIS_NFITEMUN.CD_OPERADOR := PARAM_GLB.CD_USUARIO;
          fFIS_NFITEMUN.DT_CADASTRO := Now;
        end;

        vDsLstValor := vDsRegistro.DS_LSTVALOR;
        vDsLstSerial := vDsRegistro.DS_LSTSERIAL;
        vDsLstDespesa := vDsRegistro.DS_LSTDESPESA;
        vDsLstItemLote := vDsRegistro.DS_LSTITEMLOTE;
        vDsLstItemPrdFin := vDsRegistro.DS_LSTITEMPRDFIN;

        if (vDsLstValor <> '') then begin
          repeat
            getitem(vDsRegistro, vDsLstValor, 1);
            vTpValor := vDsRegistro.TP_VALOR;
            vCdValor := vDsRegistro.CD_VALOR;
            fFIS_NFITEMVL.Append();
            fFIS_NFITEMVL.TP_VALOR := vTpValor;
            fFIS_NFITEMVL.CD_VALOR := vCdValor;
            fFIS_NFITEMVL.Consultar();
            if (xStatus = -7) then begin
              fFIS_NFITEMVL.Consultar();
            end;
            delitem(vDsRegistro, 'TP_VALOR');
            delitem(vDsRegistro, 'CD_VALOR');
            vDsRegistro := fFIS_NFITEMVL.GetValues();
            fFIS_NFITEMVL.CD_EMPFAT := fTRA_TRANSACAO.CD_EMPFAT;
            fFIS_NFITEMVL.CD_GRUPOEMPRESA := fTRA_TRANSACAO.CD_GRUPOEMPRESA;
            fFIS_NFITEMVL.CD_OPERADOR := PARAM_GLB.CD_USUARIO;
            fFIS_NFITEMVL.DT_CADASTRO := Now;
            delitemGld(vDsLstValor, 1);
          until (vDsLstValor = '');
        end;
        if (vDsLstSerial <> '') then begin
          if (fTRA_TRANSACAO.TP_OPERACAO = 'E') then begin
            viParams := '';
            viParams.CD_PRODUTO := fFIS_NFITEMPROD.CD_PRODUTO;
            viParams.DS_LSTSERIAL := vDsLstSerial;
            viParams.TP_SITUACAO := 1;
            voParams := cPRDSVCO021.Instance.incluiSerialProduto(viParams);
            if (itemXmlF('status', voParams) < 0) then begin
              raise Exception.Create(itemXml('message', voParams));
              
            end;
          end;

          repeat
            getitem(vDsRegistro, vDsLstSerial, 1);
            fFIS_NFITEMSERIAL.Append();
            fFIS_NFITEMSERIAL.NR_SEQUENCIA := fFIS_NFITEMSERIAL.RecNo;
            fFIS_NFITEMSERIAL.Consultar();
            if (xStatus = -7) then begin
              fFIS_NFITEMSERIAL.Consultar();
            end;
            fFIS_NFITEMSERIAL.CD_EMPFAT := vDsRegistro.CD_EMPFAT;
            fFIS_NFITEMSERIAL.CD_GRUPOEMPRESA := vDsRegistro.CD_GRUPOEMPRESA;
            fFIS_NFITEMSERIAL.DS_SERIAL := vDsRegistro.DS_SERIAL;
            fFIS_NFITEMSERIAL.CD_OPERADOR := PARAM_GLB.CD_USUARIO;
            fFIS_NFITEMSERIAL.DT_CADASTRO := Now;

            delitemGld(vDsLstSerial, 1);
          until (vDsLstSerial = '');
        end;
        if (vDsLstDespesa <> '') then begin
          repeat
            getitem(vDsRegistro, vDsLstDespesa, 1);
            if (vDsRegistro.CD_DESPESAITEM > 0) and (itemXmlF('CD_CCUSTO', vDsRegistro) > 0) then begin
              fFIS_NFITEMDESP.Append();
              fFIS_NFITEMDESP.CD_DESPESAITEM := vDsRegistro.CD_DESPESAITEM;
              fFIS_NFITEMDESP.CD_CCUSTO := vDsRegistro.CD_CCUSTO;
              fFIS_NFITEMDESP.Consultar();
              if (xStatus = -7) then begin
                fFIS_NFITEMDESP.Consultar();
              end;
              fFIS_NFITEMDESP.PR_RATEIO := vDsRegistro.PR_RATEIO;
              fFIS_NFITEMDESP.CD_OPERADOR := PARAM_GLB.CD_USUARIO;
              fFIS_NFITEMDESP.DT_CADASTRO := Now;
            end;
            delitemGld(vDsLstDespesa, 1);
          until (vDsLstDespesa = '');
        end;
        if (vDsLstItemLote <> '') then begin
          repeat
            getitem(vDsRegistro, vDsLstItemLote, 1);
            if (gInItemLote) then begin
              fFIS_NFITEMPLOTE.Append();
              fFIS_NFITEMPLOTE.NR_SEQUENCIA := fFIS_NFITEMPLOTE.RecNo;
              fFIS_NFITEMPLOTE.Consultar();
              if (xStatus = -7) then begin
                fFIS_NFITEMPLOTE.Consultar();
              end;
              fFIS_NFITEMPLOTE.CD_EMPLOTE := vDsRegistro.CD_EMPLOTE;
              fFIS_NFITEMPLOTE.NR_LOTE := vDsRegistro.NR_LOTE;
              fFIS_NFITEMPLOTE.NR_ITEMLOTE := vDsRegistro.NR_ITEMLOTE;
              fFIS_NFITEMPLOTE.QT_LOTE := vDsRegistro.QT_LOTE;
              fFIS_NFITEMPLOTE.QT_CONE := vDsRegistro.QT_CONE;
              fFIS_NFITEMPLOTE.CD_BARRALOTE := vDsRegistro.CD_BARRALOTE;
              fFIS_NFITEMPLOTE.CD_OPERADOR := PARAM_GLB.CD_USUARIO;
              fFIS_NFITEMPLOTE.DT_CADASTRO := Now;
            end else begin

              if (gTinTinturaria = 1) then begin
                fFIS_NFITEMPLOTE.Append();
                fFIS_NFITEMPLOTE.NR_SEQUENCIA := fFIS_NFITEMPLOTE.RecNo;
                fFIS_NFITEMPLOTE.Consultar();
                if (xStatus = -7) then begin
                  fFIS_NFITEMPLOTE.Consultar();
                end;
                fFIS_NFITEMPLOTE.CD_EMPLOTE := vDsRegistro.CD_EMPLOTE;
                fFIS_NFITEMPLOTE.NR_LOTE := vDsRegistro.NR_LOTE;
                fFIS_NFITEMPLOTE.NR_ITEMLOTE := vDsRegistro.NR_ITEMLOTE;
                fFIS_NFITEMPLOTE.QT_LOTE := vDsRegistro.QT_LOTE;
                fFIS_NFITEMPLOTE.QT_CONE := vDsRegistro.QT_CONE;
                fFIS_NFITEMPLOTE.CD_BARRALOTE := vDsRegistro.CD_BARRALOTE;
                fFIS_NFITEMPLOTE.CD_OPERADOR := PARAM_GLB.CD_USUARIO;
                fFIS_NFITEMPLOTE.DT_CADASTRO := Now;
              end;

              vLstLoteInf := '';
              vLstLoteInf.CD_EMPRESA := vDsRegistro.CD_EMPLOTE;
              vLstLoteInf.NR_LOTE := vDsRegistro.NR_LOTE;
              vLstLoteInf.NR_ITEM := vDsRegistro.NR_ITEMLOTE;
              vLstLoteInf.DT_FATURA := fFIS_NFITEMPROD.DT_FATURA;
              vLstLoteInf.CD_EMPRESANF := fFIS_NFITEMPROD.CD_EMPRESA;
              vLstLoteInf.NR_FATURA := fFIS_NFITEMPROD.NR_FATURA;
              vLstLoteInf.NR_ITEMNF := fFIS_NFITEMPROD.NR_ITEM;
              vLstLoteInf.CD_PRODUTONF := fFIS_NFITEMPROD.CD_PRODUTO;
              putitem(gLstLoteInfGeral, vLstLoteInf);
            end;
            delitemGld(vDsLstItemLote, 1);
          until (vDsLstItemLote = '');
        end;
        if (vDsLstItemPrdFin <> '') then begin
          repeat
            getitem(vDsRegistro, vDsLstItemPrdFin, 1);

            fFIS_NFITEMPPRDFIN.Append();
            fFIS_NFITEMPPRDFIN.CD_EMPPRDFIN := vDsRegistro.CD_EMPPRDFIN;
            fFIS_NFITEMPPRDFIN.NR_PRDFIN := vDsRegistro.NR_PRDFIN;
            fFIS_NFITEMPPRDFIN.Consultar();
            if (xStatus = -7) then begin
              fFIS_NFITEMPPRDFIN.Consultar();
            end;
            fFIS_NFITEMPPRDFIN.CD_OPERADOR := PARAM_GLB.CD_USUARIO;
            fFIS_NFITEMPPRDFIN.DT_CADASTRO := Now;

            delitemGld(vDsLstItemPrdFin, 1);
          until (vDsLstItemPrdFin = '');
        end;
      end;
      delitemGld(piDsLstProduto, 1);
    until (piDsLstProduto = '');
    fFIS_NFITEMPROD.First();
  end;

  if (gTpModDctoFiscalLocal = 85) or (gTpModDctoFiscalLocal = 87) then begin
    fFIS_NFITEM.VL_TOTALLIQUIDO := 0;
    fFIS_NFITEM.VL_TOTALDESC := 0;
    fFIS_NFITEM.QT_FATURADO := 0;
    fFIS_NFITEM.VL_UNITBRUTO := 0;
    fFIS_NFITEM.VL_TOTALBRUTO := 0;
    fFIS_NFITEM.VL_UNITLIQUIDO := 0;
    fFIS_NFITEM.VL_UNITDESC := 0;
    fFIS_NF.VL_TOTALPRODUTO := 0;
    fFIS_NF.VL_DESCONTO := 0;
    fFIS_NF.QT_FATURADO := 0;
    fFIS_NF.VL_TOTALNOTA := 0;
    fFIS_NF.VL_BASEICMS := 0;
  end;

  fFIS_NF.VL_TOTALPRODUTO := fFIS_NF.VL_TOTALPRODUTO + item_f('VL_TOTALLIQUIDO', tFIS_NFITEM);
  fFIS_NF.VL_DESCONTO := fFIS_NF.VL_DESCONTO + item_f('VL_TOTALDESC', tFIS_NFITEM);
  fFIS_NF.QT_FATURADO := fFIS_NF.QT_FATURADO + item_f('QT_FATURADO', tFIS_NFITEM);

  if (fFIS_NFITEM.CD_DECRETO <> '') and (gInGravaDsDecretoObsNf = True) and (vInObs) then begin
    fFIS_DECRETO.Append();
    fFIS_DECRETO.CD_DECRETO := fFIS_NFITEM.CD_DECRETO;
    fFIS_DECRETO.Consultar();
    if (xStatus = -7) then begin
      fFIS_DECRETO.Consultar();
    end;
  end;

  fFIS_NFITEM.DS_LSTIMPOSTO := '';
  if not (fTMP_NR09.IsEmpty()) then begin
    fTMP_NR09.First();
    while not t.EOF do begin
      fTMP_NR09.SetValues(vDsRegistro);
      putitem(vLstImposto, vDsRegistro);
      fTMP_NR09.Next();
    end;
    fFIS_NFITEM.DS_LSTIMPOSTO := vLstImposto;
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
  if (fGER_S_OPERACAO.IN_CALCIMPOSTO <> True) then begin
    return(0); exit;
  end;

  fFIS_NF.VL_IPI := 0;
  fFIS_NF.VL_BASEICMSSUBS := 0;
  fFIS_NF.VL_ICMSSUBST := 0;
  fFIS_NF.VL_BASEICMS := 0;
  fFIS_NF.VL_ICMS := 0;
  vVlICMS2 := 0;
  vVlBaseICMS2 := 0;
  vVlICMSSubst2 := 0;
  vVlBaseICMSSubst2 := 0;
  vVlFatorLiquido := 0;
  vVlFatorBruto := 0;
  vVlFator := 0;

  fTMP_K02.Limpar();

  if not (fFIS_NFITEM.IsEmpty()) then begin
    fFIS_NFITEM.First();
    while not t.EOF do begin
      fFIS_NFITEMPROD.First();

      vVlFatorLiquido := (fFIS_NFITEM.VL_DESPACESSOR + item_f('VL_FRETE', tFIS_NFITEM) + item_f('VL_SEGURO', tFIS_NFITEM) + item_f('VL_TOTALLIQUIDO', tFIS_NFITEM)) / item_f('VL_TOTALLIQUIDO', tFIS_NFITEM);
      vVlFatorBruto := (fFIS_NFITEM.VL_DESPACESSOR + item_f('VL_FRETE', tFIS_NFITEM) + item_f('VL_SEGURO', tFIS_NFITEM) + item_f('VL_TOTALBRUTO', tFIS_NFITEM)) / item_f('VL_TOTALBRUTO', tFIS_NFITEM);

      if (fGER_OPERACAO.IN_CALCIMPOSTO) then begin
        if (fFIS_NFITEM.DS_LSTIMPOSTO <> '') then begin
          vDsLstImposto := fFIS_NFITEM.DS_LSTIMPOSTO;
          repeat
            getitem(vDsRegistro, vDsLstImposto, 1);
            vCdImposto := vDsRegistro.NR_GERAL;
            if (vCdImposto > 0) then begin
              fFIS_NFITEMIMPOST.Append();
              fFIS_NFITEMIMPOST.CD_IMPOSTO := vCdImposto;
              fFIS_NFITEMIMPOST.CD_EMPFAT := fTRA_TRANSACAO.CD_EMPFAT;
              fFIS_NFITEMIMPOST.CD_GRUPOEMPRESA := fTRA_TRANSACAO.CD_GRUPOEMPRESA;
              fFIS_NFITEMIMPOST.PR_ALIQUOTA := vDsRegistro.PR_ALIQUOTA;
              fFIS_NFITEMIMPOST.PR_BASECALC := vDsRegistro.PR_BASECALC;
              fFIS_NFITEMIMPOST.PR_REDUBASE := vDsRegistro.PR_REDUBASE;
              fFIS_NFITEMIMPOST.VL_BASECALC := vDsRegistro.VL_BASECALC;
              fFIS_NFITEMIMPOST.VL_ISENTO := vDsRegistro.VL_ISENTO;
              fFIS_NFITEMIMPOST.VL_OUTRO := vDsRegistro.VL_OUTRO;
              fFIS_NFITEMIMPOST.VL_IMPOSTO := vDsRegistro.VL_IMPOSTO;
              fFIS_NFITEMIMPOST.CD_PRODUTO := '';
              fFIS_NFITEMIMPOST.CD_OPERADOR := PARAM_GLB.CD_USUARIO;
              fFIS_NFITEMIMPOST.DT_CADASTRO := Now;
              fFIS_NFITEMIMPOST.CD_CST := vDsRegistro.CD_CST;

              if (fFIS_NFITEMIMPOST.CD_IMPOSTO <> 4) then begin
                if (fFIS_NFITEMIMPOST.CD_IMPOSTO = 3) then begin
                  vVlFator := 1;

                end else begin
                  vVlFator := vVlFatorLiquido;
                end;
                if (vVlFator > 1) then begin
                  fFIS_NFITEMIMPOST.VL_BASECALC := fFIS_NFITEMIMPOST.VL_BASECALC * vVlFator;
                  fFIS_NFITEMIMPOST.VL_ISENTO := fFIS_NFITEMIMPOST.VL_ISENTO * vVlFator;
                  fFIS_NFITEMIMPOST.VL_OUTRO := fFIS_NFITEMIMPOST.VL_OUTRO * vVlFator;
                  fFIS_NFITEMIMPOST.VL_IMPOSTO := fFIS_NFITEMIMPOST.VL_IMPOSTO * vVlFator;
                end;
              end;
              if (fFIS_NFITEMIMPOST.CD_IMPOSTO = 1) then begin
                fFIS_NF.VL_BASEICMS := fFIS_NF.VL_BASEICMS + item_f('VL_BASECALC', tFIS_NFITEMIMPOST);
                fFIS_NF.VL_ICMS := fFIS_NF.VL_ICMS + item_f('VL_IMPOSTO', tFIS_NFITEMIMPOST);

                if (fFIS_NFITEMIMPOST.VL_BASECALC > 0) then begin
                  fTMP_CSTALIQ.Append();
                  fTMP_CSTALIQ.CD_CST := fFIS_NFITEM.CD_CST;
                  fTMP_CSTALIQ.PR_ALIQUOTA := fFIS_NFITEMIMPOST.PR_ALIQUOTA;
                  fTMP_CSTALIQ.Consultar();
                  if (xStatus = -7) then begin
                    fTMP_CSTALIQ.Consultar();
                  end;
                  fTMP_CSTALIQ.VL_BASECALC := fTMP_CSTALIQ.VL_BASECALC + item_f('VL_BASECALC', tFIS_NFITEMIMPOST);
                  fTMP_CSTALIQ.VL_IMPOSTO := fTMP_CSTALIQ.VL_IMPOSTO + item_f('VL_IMPOSTO', tFIS_NFITEMIMPOST);
                end;
                if (fFIS_NFITEM.CD_DECRETO = 6142) then begin
                  vVlDiferimento := fFIS_NFITEMIMPOST.VL_BASECALC * item_f('PR_ALIQUOTA', tFIS_NFITEMIMPOST) / 100;
                  vVlDiferimento := rounded(vVlDiferimento, 6);
                  gVlICMSDiferido := gVlICMSDiferido + vVlDiferimento;
                end;
                fTMP_K02.Append();
                fTMP_K02.NR_CHAVE01 := fFIS_NFITEMIMPOST.CD_IMPOSTO;
                fTMP_K02.NR_CHAVE02 := fFIS_NFITEM.RecNo;
                fTMP_K02.VL_GERAL := fFIS_NFITEMIMPOST.VL_IMPOSTO;
                fTMP_K02.PR_REDUBASE := fFIS_NFITEMIMPOST.PR_REDUBASE;
              end;
              if (fFIS_NFITEMIMPOST.CD_IMPOSTO = 2) then begin
                fFIS_NF.VL_BASEICMSSUBS := fFIS_NF.VL_BASEICMSSUBS + item_f('VL_BASECALC', tFIS_NFITEMIMPOST);
                fFIS_NF.VL_ICMSSUBST := fFIS_NF.VL_ICMSSUBST + item_f('VL_IMPOSTO', tFIS_NFITEMIMPOST);
                fTMP_K02.Append();
                fTMP_K02.NR_CHAVE01 := fFIS_NFITEMIMPOST.CD_IMPOSTO;
                fTMP_K02.NR_CHAVE02 := fFIS_NFITEM.RecNo;
                fTMP_K02.VL_GERAL := fFIS_NFITEMIMPOST.VL_IMPOSTO;
              end;
              if (fFIS_NFITEMIMPOST.CD_IMPOSTO = 3) then begin
                fFIS_NF.VL_IPI := fFIS_NF.VL_IPI + item_f('VL_IMPOSTO', tFIS_NFITEMIMPOST);
                fTMP_K02.Append();
                fTMP_K02.NR_CHAVE01 := fFIS_NFITEMIMPOST.CD_IMPOSTO;
                fTMP_K02.NR_CHAVE02 := fFIS_NFITEM.RecNo;
                fTMP_K02.VL_GERAL := fFIS_NFITEMIMPOST.VL_IMPOSTO;
              end;

              vCdCST := copy(fFIS_NFITEM.CD_CST,2,2);
              if not ((vCdCST = '10') or (vCdCST = '30') or (vCdCST = '60') or (vCdCST = '70')) and (gInSubstituicao) then begin
                gInSubstituicao := True;
              end;
            end;
            delitemGld(vDsLstImposto, 1);
          until (vDsLstImposto = '');
        end;
      end else begin
        viParams := '';
        viParams.CD_EMPRESA := fTRA_TRANSACAO.CD_EMPFAT;
        viParams.UF_DESTINO := fTRA_REMDES.DS_SIGLAESTADO;
        viParams.TP_ORIGEMEMISSAO := fTRA_TRANSACAO.TP_ORIGEMEMISSAO;
        if (fFIS_NFITEM.CD_ESPECIE = gCdEspecieServico) then begin
          viParams.CD_SERVICO := fFIS_NFITEM.CD_PRODUTO;
        end else if (fGER_S_OPERACAO.TP_MODALIDADE = 'A') then begin
          viParams.CD_MPTER := fFIS_NFITEM.CD_PRODUTO;
        end else begin
          viParams.CD_PRODUTO := fFIS_NFITEMPROD.CD_PRODUTO;
        end;
        viParams.CD_OPERACAO := fGER_S_OPERACAO.CD_OPERACAO;
        viParams.CD_PESSOA := fTRA_REMDES.CD_PESSOA;
        viParams.CD_CST := fFIS_NFITEM.CD_CST;
        viParams.VL_TOTALBRUTO := fFIS_NFITEM.VL_TOTALBRUTO;
        viParams.VL_TOTALLIQUIDO := fFIS_NFITEM.VL_TOTALLIQUIDO;
        viParams.TP_MODDCTOFISCAL := fFIS_NF.TP_MODDCTOFISCAL;
        viParams.NR_CODIGOFISCAL := gNrCodFiscal;
        viParams.DT_INIVIGENCIA := fFIS_NF.DT_EMISSAO;
        voParams := cFISSVCO015.Instance.calculaImpostoItem(viParams);
        if (itemXmlF('status', voParams) < 0) then begin
          raise Exception.Create(itemXml('message', voParams)); exit;
        end;

        vDsLstImposto := voParams.DS_LSTIMPOSTO;
        vCdCST := voParams.CD_CST;
        vCdDecreto := voParams.CD_DECRETO;

        if (vDsLstImposto <> '') then begin
          repeat
            getitem(vDsRegistro, vDsLstImposto, 1);

            fFIS_NFITEMIMPOST.Append();
            vDsRegistro := fFIS_NFITEMIMPOST.GetValues();
            fFIS_NFITEMIMPOST.CD_EMPFAT := fTRA_TRANSACAO.CD_EMPFAT;
            fFIS_NFITEMIMPOST.CD_GRUPOEMPRESA := fTRA_TRANSACAO.CD_GRUPOEMPRESA;
            fFIS_NFITEMIMPOST.CD_OPERADOR := PARAM_GLB.CD_USUARIO;
            fFIS_NFITEMIMPOST.DT_CADASTRO := Now;

            if (fFIS_NFITEMIMPOST.CD_IMPOSTO <> 4) then begin
              if (fFIS_NFITEMIMPOST.CD_IMPOSTO = 3) then begin
                vVlFator := 1;
              end else begin
                vVlFator := vVlFatorLiquido;
              end;
              if (vVlFator > 1) then begin
                fFIS_NFITEMIMPOST.VL_BASECALC := fFIS_NFITEMIMPOST.VL_BASECALC * vVlFator;
                fFIS_NFITEMIMPOST.VL_ISENTO := fFIS_NFITEMIMPOST.VL_ISENTO * vVlFator;
                fFIS_NFITEMIMPOST.VL_OUTRO := fFIS_NFITEMIMPOST.VL_OUTRO * vVlFator;
                fFIS_NFITEMIMPOST.VL_IMPOSTO := fFIS_NFITEMIMPOST.VL_IMPOSTO * vVlFator;
              end;
            end;
            if (fFIS_NFITEMIMPOST.CD_IMPOSTO = 1) then begin
              if (fFIS_NFITEMIMPOST.VL_BASECALC > 0) then begin
                fTMP_CSTALIQ.Append();
                fTMP_CSTALIQ.CD_CST := vCdCST;
                fTMP_CSTALIQ.PR_ALIQUOTA := fFIS_NFITEMIMPOST.PR_ALIQUOTA;
                fTMP_CSTALIQ.Consultar();
                if (xStatus = -7) then begin
                  fTMP_CSTALIQ.Consultar();
                end;
                fTMP_CSTALIQ.VL_BASECALC := fTMP_CSTALIQ.VL_BASECALC + item_f('VL_BASECALC', tFIS_NFITEMIMPOST);
                fTMP_CSTALIQ.VL_IMPOSTO := fTMP_CSTALIQ.VL_IMPOSTO + item_f('VL_IMPOSTO', tFIS_NFITEMIMPOST);
              end;
              fFIS_NF.VL_BASEICMS := fFIS_NF.VL_BASEICMS + item_f('VL_BASECALC', tFIS_NFITEMIMPOST);
              fFIS_NF.VL_ICMS := fFIS_NF.VL_ICMS + item_f('VL_IMPOSTO', tFIS_NFITEMIMPOST);
              if (vCdDecreto = 6142) then begin
                vVlDiferimento := fFIS_NFITEMIMPOST.VL_BASECALC * item_f('PR_ALIQUOTA', tFIS_NFITEMIMPOST) / 100;
                vVlDiferimento := rounded(vVlDiferimento, 6);
                gVlICMSDiferido := gVlICMSDiferido + vVlDiferimento;
              end;
              fTMP_K02.Append();
              fTMP_K02.NR_CHAVE01 := fFIS_NFITEMIMPOST.CD_IMPOSTO;
              fTMP_K02.NR_CHAVE02 := fFIS_NFITEM.RecNo;
              fTMP_K02.VL_GERAL := fFIS_NFITEMIMPOST.VL_IMPOSTO;
              fTMP_K02.PR_REDUBASE := fFIS_NFITEMIMPOST.PR_REDUBASE;
            end;
            if (fFIS_NFITEMIMPOST.CD_IMPOSTO = 2) then begin
              fFIS_NF.VL_BASEICMSSUBS := fFIS_NF.VL_BASEICMSSUBS + item_f('VL_BASECALC', tFIS_NFITEMIMPOST);
              fFIS_NF.VL_ICMSSUBST := fFIS_NF.VL_ICMSSUBST + item_f('VL_IMPOSTO', tFIS_NFITEMIMPOST);
              fTMP_K02.Append();
              fTMP_K02.NR_CHAVE01 := fFIS_NFITEMIMPOST.CD_IMPOSTO;
              fTMP_K02.NR_CHAVE02 := fFIS_NFITEM.RecNo;
              fTMP_K02.VL_GERAL := fFIS_NFITEMIMPOST.VL_IMPOSTO;
            end;
            if (fFIS_NFITEMIMPOST.CD_IMPOSTO = 3) then begin
              fFIS_NF.VL_IPI := fFIS_NF.VL_IPI + item_f('VL_IMPOSTO', tFIS_NFITEMIMPOST);
              fTMP_K02.Append();
              fTMP_K02.NR_CHAVE01 := fFIS_NFITEMIMPOST.CD_IMPOSTO;
              fTMP_K02.NR_CHAVE02 := fFIS_NFITEM.RecNo;
              fTMP_K02.VL_GERAL := fFIS_NFITEMIMPOST.VL_IMPOSTO;
            end;

            delitemGld(vDsLstImposto, 1);
          until (vDsLstImposto = '');
        end;
      end;
      if (fFIS_NFITEMIMPOST.IsEmpty() = False) and (gInNFe) then begin
        fFIS_NFITEMIMPOST.First();
        while not t.EOF do begin
          if (fFIS_NFITEMIMPOST.CD_IMPOSTO = 1) then begin
            if (gInArredondaTruncaIcms) then begin
              fFIS_NFITEMIMPOST.VL_BASECALC := rounded(fFIS_NFITEMIMPOST.VL_BASECALC, 2);
              fFIS_NFITEMIMPOST.VL_IMPOSTO := rounded(fFIS_NFITEMIMPOST.VL_IMPOSTO, 2);
            end else begin
              vVlCalc := fFIS_NFITEMIMPOST.VL_BASECALC * 100;
              vVlCalc := int(vVlCalc);
              fFIS_NFITEMIMPOST.VL_BASECALC := vVlCalc / 100;
              vVlCalc := fFIS_NFITEMIMPOST.VL_IMPOSTO * 100;
              vVlCalc := int(vVlCalc);
              fFIS_NFITEMIMPOST.VL_IMPOSTO := vVlCalc / 100;
            end;
            vVlBaseICMS2 := vVlBaseICMS2 + fFIS_NFITEMIMPOST.VL_BASECALC;
            vVlICMS2 := vVlICMS2 + fFIS_NFITEMIMPOST.VL_IMPOSTO;
          end;
          if (fFIS_NFITEMIMPOST.CD_IMPOSTO = 2) then begin
            if (gInArredondaTruncaIcms) then begin
              fFIS_NFITEMIMPOST.VL_BASECALC := rounded(fFIS_NFITEMIMPOST.VL_BASECALC, 2);
              fFIS_NFITEMIMPOST.VL_IMPOSTO := rounded(fFIS_NFITEMIMPOST.VL_IMPOSTO, 2);
            end else begin
              vVlCalc := fFIS_NFITEMIMPOST.VL_BASECALC * 100;
              vVlCalc := int(vVlCalc);
              fFIS_NFITEMIMPOST.VL_BASECALC := vVlCalc / 100;
              vVlCalc := fFIS_NFITEMIMPOST.VL_IMPOSTO * 100;
              vVlCalc := int(vVlCalc);
              fFIS_NFITEMIMPOST.VL_IMPOSTO := vVlCalc / 100;
            end;
            vVlBaseICMSSubst2 := vVlBaseICMSSubst2 + fFIS_NFITEMIMPOST.VL_BASECALC;
            vVlICMSSubst2 := vVlICMSSubst2 + fFIS_NFITEMIMPOST.VL_IMPOSTO;
          end;
          if (fFIS_NFITEMIMPOST.CD_IMPOSTO = 3) then begin
            if (gInArredondaTruncaIcms) then begin
              fFIS_NFITEMIMPOST.VL_BASECALC := rounded(fFIS_NFITEMIMPOST.VL_BASECALC, 2);
              fFIS_NFITEMIMPOST.VL_IMPOSTO := rounded(fFIS_NFITEMIMPOST.VL_IMPOSTO, 2);
            end else begin
              vVlCalc := fFIS_NFITEMIMPOST.VL_BASECALC * 100;
              vVlCalc := int(vVlCalc);
              fFIS_NFITEMIMPOST.VL_BASECALC := vVlCalc / 100;
              vVlCalc := fFIS_NFITEMIMPOST.VL_IMPOSTO * 100;
              vVlCalc := int(vVlCalc);
              fFIS_NFITEMIMPOST.VL_IMPOSTO := vVlCalc / 100;
            end;
            vVlIPI2 := vVlIPI2 + fFIS_NFITEMIMPOST.VL_IMPOSTO;
          end;

          fFIS_NFITEMIMPOST.Next();
        end;
      end;
      if (gInGravaDsDecretoObsNf = True) and (fFIS_NFITEM.CD_DECRETO > 0) then begin
        fFIS_DECRETO.Append();
        fFIS_DECRETO.CD_DECRETO := fFIS_NFITEM.CD_DECRETO;
        fFIS_DECRETO.Consultar();
        if (xStatus = -7) then begin
          fFIS_DECRETO.Consultar();
        end;
      end;

      voParams := tFIS_NFITEMPROD.Salvar();
      if (itemXmlF('status', voParams) < 0) then begin
        raise Exception.Create(itemXml('message', voParams));
        
      end;

      voParams := tFIS_NFITEMIMPOST.Salvar();
      if (itemXmlF('status', voParams) < 0) then begin
        raise Exception.Create(itemXml('message', voParams));
        
      end;

      fFIS_NFITEM.Next();
    end;
    if (gInNFe) then begin
      sort_e(tTMP_K02, 'NR_CHAVE01:a;PR_REDUBASE:d;VL_GERAL:d');

      vNrOccICMS := 0;
      vNrOccSubst := 0;
      vNrOccIPI := 0;

      fTMP_K02.First();
      while not t.EOF do begin
        if (fTMP_K02.NR_CHAVE01 = 1) and (vNrOccICMS = 0) then begin
          vNrOccICMS := fTMP_K02.RecNo;
        end;
        if (fTMP_K02.NR_CHAVE01 = 2) and (vNrOccSubst = 0) then begin
          vNrOccSubst := fTMP_K02.RecNo;
        end;
        if (fTMP_K02.NR_CHAVE01 = 3) and (vNrOccIPI = 0) then begin
          vNrOccIPI := fTMP_K02.RecNo;
        end;
        fTMP_K02.Next();
      end;

      vVlDif := rounded(fFIS_NF.VL_BASEICMS, 2) - vVlBaseICMS2;

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
        fTMP_K02.Next();
        if (xStatus >= 0) then begin
          fFIS_NFITEM.First();
          fFIS_NFITEMIMPOST.Append();
          fFIS_NFITEMIMPOST.CD_IMPOSTO := 1;
          fFIS_NFITEMIMPOST.Consultar();
          if (xStatus = 4) then begin
            fFIS_NFITEMIMPOST.VL_BASECALC := fFIS_NFITEMIMPOST.VL_BASECALC + vVlAplicado;
          end else begin
            fFIS_NFITEMIMPOST.Remover();
          end;
        end;
        vNrSeq := vNrSeq + 1;
      end;

      vVlDif := rounded(fFIS_NF.VL_ICMS, 2) - vVlICMS2;

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
        fTMP_K02.Next();
        if (xStatus >= 0) then begin
          fFIS_NFITEM.First();
          fFIS_NFITEMIMPOST.Append();
          fFIS_NFITEMIMPOST.CD_IMPOSTO := 1;
          fFIS_NFITEMIMPOST.Consultar();
          if (xStatus = 4) then begin
            fFIS_NFITEMIMPOST.VL_IMPOSTO := fFIS_NFITEMIMPOST.VL_IMPOSTO + vVlAplicado;
          end else begin
            fFIS_NFITEMIMPOST.Remover();
          end;
        end;
        vNrSeq := vNrSeq + 1;
      end;

      vVlDif := rounded(fFIS_NF.VL_BASEICMSSUBS, 2) - vVlBaseICMSSubst2;

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
        fTMP_K02.Next();
        if (xStatus >= 0) then begin
          fFIS_NFITEM.First();
          fFIS_NFITEMIMPOST.Append();
          fFIS_NFITEMIMPOST.CD_IMPOSTO := 2;
          fFIS_NFITEMIMPOST.Consultar();
          if (xStatus = 4) then begin
            fFIS_NFITEMIMPOST.VL_BASECALC := fFIS_NFITEMIMPOST.VL_BASECALC + vVlAplicado;
          end else begin
            fFIS_NFITEMIMPOST.Remover();
          end;
        end;
        vNrSeq := vNrSeq + 1;
      end;

      vVlDif := rounded(fFIS_NF.VL_ICMSSUBST, 2) - vVlICMSSubst2;

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
        fTMP_K02.Next();
        if (xStatus >= 0) then begin
          fFIS_NFITEM.First();
          fFIS_NFITEMIMPOST.Append();
          fFIS_NFITEMIMPOST.CD_IMPOSTO := 2;
          fFIS_NFITEMIMPOST.Consultar();
          if (xStatus = 4) then begin
            fFIS_NFITEMIMPOST.VL_IMPOSTO := fFIS_NFITEMIMPOST.VL_IMPOSTO + vVlAplicado;
          end else begin
            fFIS_NFITEMIMPOST.Remover();
          end;
        end;
        vNrSeq := vNrSeq + 1;
      end;

      vVlDif := rounded(fFIS_NF.VL_IPI, 2) - vVlIPI2;

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
        fTMP_K02.Next();
        if (xStatus >= 0) then begin
          fFIS_NFITEM.First();
          fFIS_NFITEMIMPOST.Append();
          fFIS_NFITEMIMPOST.CD_IMPOSTO := 3;
          fFIS_NFITEMIMPOST.Consultar();
          if (xStatus = 4) then begin
            fFIS_NFITEMIMPOST.VL_IMPOSTO := fFIS_NFITEMIMPOST.VL_IMPOSTO + vVlAplicado;
          end else begin
            fFIS_NFITEMIMPOST.Remover();
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
  fFIS_NF.VL_DESPACESSOR := fTRA_TRANSACAO.VL_DESPACESSOR;
  fFIS_NF.VL_FRETE := fTRA_TRANSACAO.VL_FRETE;
  fFIS_NF.VL_SEGURO := fTRA_TRANSACAO.VL_SEGURO;

  if not (fTRA_TRANSPORT.IsEmpty()) then begin
    if (fTRA_TRANSPORT.CD_TRANSPORT = 0) then begin
      return(0); exit;
    end;
    if (fTRA_TRANSPORT.TP_FRETE = '') then begin
      return(0); exit;
    end;

    fTRA_TRANSPORT.First();
    while not t.EOF do begin
      fFIS_NFTRANSP.Append();
      fFIS_NFTRANSP.CD_TRANSPORT := fTRA_TRANSPORT.CD_TRANSPORT;
      fFIS_NFTRANSP.NM_TRANSPORT := fTRA_TRANSPORT.NM_TRANSPORT;
      fFIS_NFTRANSP.CD_EMPFAT := fTRA_TRANSACAO.CD_EMPFAT;
      fFIS_NFTRANSP.CD_GRUPOEMPRESA := fTRA_TRANSACAO.CD_GRUPOEMPRESA;
      fFIS_NFTRANSP.TP_FRETE := fTRA_TRANSPORT.TP_FRETE;
      fFIS_NFTRANSP.QT_VOLUME := fTRA_TRANSPORT.QT_VOLUME;
      fFIS_NFTRANSP.CD_TRANSREDESPAC := fTRA_TRANSPORT.CD_TRANSREDESPAC;
      fFIS_NFTRANSP.NM_TRANSREDESPAC := fTRA_TRANSPORT.NM_TRANSREDESPAC;
      fFIS_NFTRANSP.NR_PLACA := fTRA_TRANSPORT.NR_PLACA;
      fFIS_NFTRANSP.QT_PESOBRUTO := fTRA_TRANSPORT.QT_PESOBRUTO;
      fFIS_NFTRANSP.QT_PESOLIQUIDO := fTRA_TRANSPORT.QT_PESOLIQUIDO;
      fFIS_NFTRANSP.VL_FRETE := fTRA_TRANSPORT.VL_FRETE;
      fFIS_NFTRANSP.DS_ESPECIE := fTRA_TRANSPORT.DS_ESPECIE;
      fFIS_NFTRANSP.DS_MARCA := fTRA_TRANSPORT.DS_MARCA;
      fFIS_NFTRANSP.NR_PLACA := fTRA_TRANSPORT.NR_PLACA;
      fFIS_NFTRANSP.DS_UFPLACA := fTRA_TRANSPORT.DS_UFPLACA;
      fFIS_NFTRANSP.NM_LOGRADOURO := fTRA_TRANSPORT.NM_LOGRADOURO;
      fFIS_NFTRANSP.DS_TPLOGRADOURO := fTRA_TRANSPORT.DS_TPLOGRADOURO;
      fFIS_NFTRANSP.NR_LOGRADOURO := fTRA_TRANSPORT.NR_LOGRADOURO;
      fFIS_NFTRANSP.NR_CAIXAPOSTAL := fTRA_TRANSPORT.NR_CAIXAPOSTAL;
      fFIS_NFTRANSP.NM_BAIRRO := fTRA_TRANSPORT.NM_BAIRRO;
      fFIS_NFTRANSP.CD_CEP := fTRA_TRANSPORT.CD_CEP;
      fFIS_NFTRANSP.NM_MUNICIPIO := fTRA_TRANSPORT.NM_MUNICIPIO;
      fFIS_NFTRANSP.DS_SIGLAESTADO := fTRA_TRANSPORT.DS_SIGLAESTADO;
      fFIS_NFTRANSP.NR_RGINSCREST := fTRA_TRANSPORT.NR_RGINSCREST;
      fFIS_NFTRANSP.NR_CPFCNPJ := fTRA_TRANSPORT.NR_CPFCNPJ;
      fFIS_NFTRANSP.CD_OPERADOR := PARAM_GLB.CD_USUARIO;
      fFIS_NFTRANSP.DT_CADASTRO := Now;
      fTRA_TRANSPORT.Next();
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

  vVlRestoDespAcessor := fFIS_NF.VL_DESPACESSOR;
  vVlRestoFrete := fFIS_NF.VL_FRETE;
  vVlRestoSeguro := fFIS_NF.VL_SEGURO;

  if not (fFIS_NFITEM.IsEmpty()) then begin
    fFIS_NFITEM.First();
    while not t.EOF do begin
      vVlCalc := (fFIS_NFITEM.VL_TOTALLIQUIDO / item_f('VL_TOTALPRODUTO', tFIS_NF)) * item_f('VL_DESPACESSOR', tFIS_NF);
      fFIS_NFITEM.VL_DESPACESSOR := rounded(vVlCalc, 2);
      vVlCalc := (fFIS_NFITEM.VL_TOTALLIQUIDO / item_f('VL_TOTALPRODUTO', tFIS_NF)) * item_f('VL_FRETE', tFIS_NF);
      fFIS_NFITEM.VL_FRETE := rounded(vVlCalc, 2);
      vVlCalc := (fFIS_NFITEM.VL_TOTALLIQUIDO / item_f('VL_TOTALPRODUTO', tFIS_NF)) * item_f('VL_SEGURO', tFIS_NF);
      fFIS_NFITEM.VL_SEGURO := rounded(vVlCalc, 2);
      vVlRestoDespAcessor := vVlRestoDespAcessor - fFIS_NFITEM.VL_DESPACESSOR;
      vVlRestoFrete := vVlRestoFrete - fFIS_NFITEM.VL_FRETE;
      vVlRestoSeguro := vVlRestoSeguro - fFIS_NFITEM.VL_SEGURO;
      if (fFIS_NFITEM.VL_TOTALLIQUIDO > vVlMaiorItem) then begin
        vVlMaiorItem := fFIS_NFITEM.VL_TOTALLIQUIDO;
        vNrOccItem := fFIS_NFITEM.RecNo;
      end;
      fFIS_NFITEM.Next();
    end;
  end;
  if (vVlRestoDespAcessor <> 0) then begin
    fFIS_NFITEM.First();
    fFIS_NFITEM.VL_DESPACESSOR := fFIS_NFITEM.VL_DESPACESSOR + vVlRestoDespAcessor;
  end;
  if (vVlRestoFrete <> 0) then begin
    fFIS_NFITEM.First();
    fFIS_NFITEM.VL_FRETE := fFIS_NFITEM.VL_FRETE + vVlRestoFrete;
  end;
  if (vVlRestoSeguro <> 0) then begin
    fFIS_NFITEM.First();
    fFIS_NFITEM.VL_SEGURO := fFIS_NFITEM.VL_SEGURO + vVlRestoSeguro;
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
  vDtSistema := PARAM_GLB.DT_SISTEMA;

  if (fGER_S_OPERACAO.IN_FINANCEIRO <> True) and (item_b('IN_FINANCEIRO', tGER_OPERACAO) <> True) then begin
    return(0); exit;
  end;

  viParams := '';
  viParams.CD_EMPRESA := fTRA_TRANSACAO.CD_EMPRESA;
  viParams.NR_TRANSACAO := fTRA_TRANSACAO.NR_TRANSACAO;
  viParams.DT_TRANSACAO := fTRA_TRANSACAO.DT_TRANSACAO;
  voParams := cGERSVCO058.Instance.buscaValorFinanceiroTransacao(viParams); 
  if (itemXmlF('status', voParams) < 0) then begin
    raise Exception.Create(itemXml('message', voParams));
    
  end;

  vVlFinanceiro := voParams.VL_FINANCEIRO;

  if (vVlFinanceiro <> fTRA_TRANSACAO.VL_TOTAL) then begin
    vPrFinanceiro := vVlFinanceiro / fTRA_TRANSACAO.VL_TOTAL * 100;
    vVlNota := fFIS_NF.VL_TOTALNOTA * vPrFinanceiro / 100;
  end else begin
    vVlNota := fFIS_NF.VL_TOTALNOTA;
  end;

  vVlResto := vVlNota;

  if not (fTRA_VENCIMENTO.IsEmpty()) then begin
    fTRA_VENCIMENTO.First();
    while not t.EOF do begin
      vNrParcela := vNrParcela + 1;

      vVlCalc := (fTRA_VENCIMENTO.VL_PARCELA / vVlFinanceiro) * vVlNota;

      vVlParcela := rounded(vVlCalc, 2);
      vVlResto := vVlResto - vVlParcela;

      fFIS_NFVENCTO.Append();
      fFIS_NFVENCTO.NR_PARCELA := vNrParcela;
      fFIS_NFVENCTO.CD_EMPFAT := fTRA_TRANSACAO.CD_EMPFAT;
      fFIS_NFVENCTO.CD_GRUPOEMPRESA := fTRA_TRANSACAO.CD_GRUPOEMPRESA;
      fFIS_NFVENCTO.CD_OPERADOR := PARAM_GLB.CD_USUARIO;
      fFIS_NFVENCTO.DT_CADASTRO := Now;
      fFIS_NFVENCTO.VL_PARCELA := vVlParcela;
      fFIS_NFVENCTO.DT_VENCIMENTO := fTRA_VENCIMENTO.DT_VENCIMENTO;
      if (fFIS_NFVENCTO.DT_VENCIMENTO < vDtSistema) then begin
        fFIS_NFVENCTO.DT_VENCIMENTO := vDtSistema;
      end;
      fFIS_NFVENCTO.TP_FORMAPGTO := fTRA_VENCIMENTO.TP_FORMAPGTO;

      fTRA_VENCIMENTO.Next();
    end;
    if (vVlResto <> 0) then begin
      fFIS_NFVENCTO.First();
      fFIS_NFVENCTO.VL_PARCELA := fFIS_NFVENCTO.VL_PARCELA + vVlResto;
    end;
  end else begin
    //raise Exception.Create('Transação ' + fTRA_TRANSACAO.CD_EMPFAT + ' / ' + item_a('NR_TRANSACAO' + ' / ' := tTRA_TRANSACAO) + ' não possui parcelamento!', cDS_METHOD);
    //
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
  if (fTRA_REMDES.IsEmpty() <> False) then begin
    viParams := '';
    viParams.CD_EMPRESA := fTRA_TRANSACAO.CD_EMPRESA;
    viParams.NR_TRANSACAO := fTRA_TRANSACAO.NR_TRANSACAO;
    viParams.DT_TRANSACAO := fTRA_TRANSACAO.DT_TRANSACAO;
    voParams := cTRASVCO004.Instance.gravaEnderecoTransacao(viParams);
    if (itemXmlF('status', voParams) < 0) then begin
      raise Exception.Create(itemXml('message', voParams));
      
    end;

    fTRA_REMDES.Limpar();
    fTRA_REMDES.Listar();
    if (itemXmlF('status', voParams) < 0) then begin
      raise Exception.Create('Transação ' + fTRA_TRANSACAO.CD_EMPFAT + ' / ' + item_a('NR_TRANSACAO' + ' / ' := tTRA_TRANSACAO) + ' não possui dados do emitende/destinatário!', cDS_METHOD);
      
    end;
  end;

  fFIS_NFREMDES.Append();
  fFIS_NFREMDES.CD_EMPFAT := fTRA_TRANSACAO.CD_EMPFAT;
  fFIS_NFREMDES.CD_GRUPOEMPRESA := fTRA_TRANSACAO.CD_GRUPOEMPRESA;
  fFIS_NFREMDES.CD_OPERADOR := PARAM_GLB.CD_USUARIO;
  fFIS_NFREMDES.DT_CADASTRO := Now;
  fFIS_NFREMDES.NM_NOME := fTRA_REMDES.NM_NOME;
  fFIS_NFREMDES.TP_PESSOA := fTRA_REMDES.TP_PESSOA;
  fFIS_NFREMDES.CD_PESSOA := fTRA_REMDES.CD_PESSOA;
  fFIS_NFREMDES.IN_CONTRIBUINTE := fTRA_REMDES.IN_CONTRIBUINTE;
  fFIS_NFREMDES.CD_CEP := fTRA_REMDES.CD_CEP;
  fFIS_NFREMDES.NR_RGINSCREST := fTRA_REMDES.NR_RGINSCREST;
  fFIS_NFREMDES.NR_CPFCNPJ := fTRA_REMDES.NR_CPFCNPJ;
  fFIS_NFREMDES.DS_TPLOGRADOURO := fTRA_REMDES.DS_TPLOGRADOURO;
  fFIS_NFREMDES.NM_LOGRADOURO := fTRA_REMDES.NM_LOGRADOURO;
  fFIS_NFREMDES.NM_COMPLEMENTO := fTRA_REMDES.NM_COMPLEMENTO;
  fFIS_NFREMDES.NR_LOGRADOURO := fTRA_REMDES.NR_LOGRADOURO;
  fFIS_NFREMDES.NM_BAIRRO := fTRA_REMDES.NM_BAIRRO;
  fFIS_NFREMDES.NM_MUNICIPIO := fTRA_REMDES.NM_MUNICIPIO;
  fFIS_NFREMDES.DS_SIGLAESTADO := fTRA_REMDES.DS_SIGLAESTADO;
  fFIS_NFREMDES.NR_CAIXAPOSTAL := fTRA_REMDES.NR_CAIXAPOSTAL;
  fFIS_NFREMDES.NR_TELEFONE := fTRA_REMDES.NR_TELEFONE;

  return(0); exit;
end;

//-------------------------------------------------------
function T_FISSVCO004.geraECF(pParams : String) : String;
//-------------------------------------------------------
const
  cDS_METHOD = 'ADICIONAL=Operação: T_FISSVCO004.geraECF()';
begin
  if not (fTRA_TRANSACECF.IsEmpty()) then begin
    fFIS_NFECF.Append();
    fFIS_NFECF.CD_EMPECF := fTRA_TRANSACECF.CD_EMPECF;
    fFIS_NFECF.NR_ECF := fTRA_TRANSACECF.NR_ECF;
    fFIS_NFECF.CD_EMPFAT := fTRA_TRANSACAO.CD_EMPFAT;
    fFIS_NFECF.CD_GRUPOEMPRESA := fTRA_TRANSACAO.CD_GRUPOEMPRESA;
    fFIS_NFECF.CD_OPERADOR := PARAM_GLB.CD_USUARIO;
    fFIS_NFECF.DT_CADASTRO := Now;
    fFIS_NFECF.NR_CUPOM := fTRA_TRANSACECF.NR_CUPOM;
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
  pDsLinhaObs := pParams.DS_LINHAOBS;
  vNrLinha := 0;

  if (gInPDVOtimizado <> True) then begin
    if (gVlICMSDiferido > 0) then begin
      gVlICMSDiferido := rounded(gVlICMSDiferido, 2);
      gVlICMSDiferido := gVlICMSDiferido - fFIS_NF.VL_ICMS;
      if (gVlICMSDiferido > 0) then begin
        fOBS_NF.Append();
        vNrLinha := vNrLinha + 1;
        fOBS_NF.NR_LINHA := vNrLinha;
        fOBS_NF.CD_EMPFAT := fTRA_TRANSACAO.CD_EMPFAT;
        fOBS_NF.CD_GRUPOEMPRESA := fTRA_TRANSACAO.CD_GRUPOEMPRESA;
        vDsLinha := 'ICMS DIF.PARC. EM 33, 33% CONF.ART. 96 INCISO I DO RICMS-PR: ' + FloatToStr(gVlICMSDiferido);
        fOBS_NF.CD_OPERADOR := PARAM_GLB.CD_USUARIO;
        fOBS_NF.DT_CADASTRO := Now;
        fOBS_NF.DS_OBSERVACAO := copy(vDsLinha,1,80);
      end;
    end;
    if (fTMP_CSTALIQ.IsEmpty() = False) and (fTRA_TRANSACAO.TP_ORIGEMEMISSAO = 1) then begin
      if (gInExibeResumoCstNF) then begin
        fTMP_CSTALIQ.First();
        while not t.EOF do begin
          fOBS_NF.Append();
          vNrLinha := vNrLinha + 1;
          fOBS_NF.NR_LINHA := vNrLinha;
          fOBS_NF.CD_EMPFAT := fTRA_TRANSACAO.CD_EMPFAT;
          fOBS_NF.CD_GRUPOEMPRESA := fTRA_TRANSACAO.CD_GRUPOEMPRESA;
          vDsLinha := 'CST ' + fTMP_CSTALIQ.CD_CST + ' ICMS ' + item_a('PR_ALIQUOTA', tTMP_CSTALIQ);
          gVlBaseCalc := rounded(fTMP_CSTALIQ.VL_BASECALC, 2);
          gVlImposto := rounded(fTMP_CSTALIQ.VL_IMPOSTO, 2);
          vDsLinha := vDsLinha + ' ' + FloatToStr(gVlBaseCalc) + ' = ' + FloatToStr(gVlImposto);
          fOBS_NF.CD_OPERADOR := PARAM_GLB.CD_USUARIO;
          fOBS_NF.DT_CADASTRO := Now;
          fOBS_NF.DS_OBSERVACAO := copy(vDsLinha,1,80);
          fTMP_CSTALIQ.Next();
        end;
      end;
    end;
    if (gInExibeResumoCfopNF) then begin
      if not (fF_TMP_NR09.IsEmpty()) then begin
        fF_TMP_NR09.First();
        while not t.EOF do begin
          fOBS_NF.Append();
          vNrLinha := vNrLinha + 1;
          fOBS_NF.NR_LINHA := vNrLinha;
          fOBS_NF.CD_EMPFAT := fTRA_TRANSACAO.CD_EMPFAT;
          fOBS_NF.CD_GRUPOEMPRESA := fTRA_TRANSACAO.CD_GRUPOEMPRESA;
          gVlImposto := rounded(fF_TMP_NR09.VL_TOTAL, 2);
          if (gInExibeQtdProdNF) then begin
            vDsLinha := 'CFOP ' + fF_TMP_NR09.NR_GERAL + ' = ' + FloatToStr(gVlImposto) + ' QT: ' + item_a('QT_ITEM', tF_TMP_NR09);
          end else begin
            vDsLinha := 'CFOP ' + fF_TMP_NR09.NR_GERAL + ' = ' + FloatToStr(gVlImposto);
          end;
          fOBS_NF.CD_OPERADOR := PARAM_GLB.CD_USUARIO;
          fOBS_NF.DT_CADASTRO := Now;
          fOBS_NF.DS_OBSERVACAO := copy(vDsLinha,1,80);
          fF_TMP_NR09.Next();
        end;
      end;
    end;
  end;
  if (gDsAdicionalRegra <> '') and (fTRA_TRANSACAO.TP_ORIGEMEMISSAO = 1) then begin
    if (fOBS_TRANSACNF.IsEmpty() = 1) then begin
      vDsAdicional := gDsAdicionalRegra;
      while(vDsAdicional <> '') do begin
        Pos(#13,vDsAdicional);
        if (xResult > 0) then begin
          vDsLinha := copy(vDsAdicional, 1, round(xResult) - 1);
          vDsAdicional := copy(vDsAdicional, round(xResult) + 1, length(vDsAdicional));
        end else begin
          vDsLinha := vDsAdicional;
          vDsAdicional := '';
        end;
        fOBS_NF.Append();
        vNrLinha := vNrLinha + 1;
        fOBS_NF.NR_LINHA := vNrLinha;
        fOBS_NF.CD_EMPFAT := fFIS_NF.CD_EMPFAT;
        fOBS_NF.CD_GRUPOEMPRESA := fFIS_NF.CD_GRUPOEMPRESA;
        fOBS_NF.CD_OPERADOR := PARAM_GLB.CD_USUARIO;
        fOBS_NF.DT_CADASTRO := Now;
        fOBS_NF.DS_OBSERVACAO := copy(vDsLinha,1,80);
      end;
    end;
  end;
  if not (fOBS_TRANSACNF.IsEmpty()) then begin
    fOBS_TRANSACNF.First();
    while not t.EOF do begin
      fOBS_NF.Append();
      vNrLinha := vNrLinha + 1;
      fOBS_NF.NR_LINHA := vNrLinha;
      fOBS_NF.CD_EMPFAT := fTRA_TRANSACAO.CD_EMPFAT;
      fOBS_NF.CD_GRUPOEMPRESA := fTRA_TRANSACAO.CD_GRUPOEMPRESA;
      fOBS_NF.CD_OPERADOR := PARAM_GLB.CD_USUARIO;
      fOBS_NF.DT_CADASTRO := Now;
      fOBS_NF.DS_OBSERVACAO := copy(fOBS_TRANSACNF.DS_OBSERVACAO,1,80);
      fOBS_TRANSACNF.Next();
    end;
  end;

  if not (fFIS_DECRETO.IsEmpty()) and (gInGravaDsDecretoObsNf = True) then begin
    fFIS_DECRETO.Next();
    fFIS_DECRETO.First();
    while not t.EOF do begin
      vDsDecreto := fFIS_DECRETO.DS_DECRETO;

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

        fOBS_NF.Append();
        vNrLinha := vNrLinha + 1;
        fOBS_NF.NR_LINHA := vNrLinha;
        fOBS_NF.CD_EMPFAT := fFIS_NF.CD_EMPFAT;
        fOBS_NF.CD_GRUPOEMPRESA := fFIS_NF.CD_GRUPOEMPRESA;
        fOBS_NF.CD_OPERADOR := PARAM_GLB.CD_USUARIO;
        fOBS_NF.DT_CADASTRO := Now;
        fOBS_NF.DS_OBSERVACAO := copy(vDsDecreto, 1, round(vNrPosDecreto));
        vNrPosDecreto := vNrPosDecreto + 1;
        vDsDecreto := copy(vDsDecreto, round(vNrPosDecreto), length(vDsDecreto));
      end;

      fFIS_DECRETO.Next();
    end;
  end;
  if (gInIncluiIpiDevSimp = True) and (fGER_OPERACAO.TP_MODALIDADE = 3)and(gInOptSimples = True) and (item_f('VL_IPI', tFIS_NF) > 0) then begin
    vDsLinha := 'VALOR DO IPI: Rg ' + fFIS_NF.VL_IPI + '';

    fOBS_NF.Append();
    vNrLinha := vNrLinha + 1;
    fOBS_NF.NR_LINHA := vNrLinha;
    fOBS_NF.CD_EMPFAT := fFIS_NF.CD_EMPFAT;
    fOBS_NF.CD_GRUPOEMPRESA := fFIS_NF.CD_GRUPOEMPRESA;
    fOBS_NF.CD_OPERADOR := PARAM_GLB.CD_USUARIO;
    fOBS_NF.DT_CADASTRO := Now;
    fOBS_NF.DS_OBSERVACAO := copy(vDsLinha,1,80);
  end;
  if (gInGravaObsNf) then begin
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
      fOBS_NF.Append();
      vNrLinha := vNrLinha + 1;
      fOBS_NF.NR_LINHA := vNrLinha;
      fOBS_NF.CD_EMPFAT := fFIS_NF.CD_EMPFAT;
      fOBS_NF.CD_GRUPOEMPRESA := fFIS_NF.CD_GRUPOEMPRESA;
      fOBS_NF.CD_OPERADOR := PARAM_GLB.CD_USUARIO;
      fOBS_NF.DT_CADASTRO := Now;
      fOBS_NF.DS_OBSERVACAO := copy(vDsLinhaAux,1,round(vNrPos));
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
    if (vInValido) then begin
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
      if (fFIS_NF.CD_OPERACAO = vCdOperacao) and (fTRA_TRANREF.IsEmpty()) then begin
        raise Exception.Create('Operação ' + vCdOperacao + ' da NF precisa de NF referencial + ' / ' := parâmetro DS_LST_OPER_OBRIG_NF_REF!', cDS_METHOD);
        
      end;
      delitemGld(vDsLstOperRef, 1);
    until(vDsLstOperRef = '');
  end;

  if not (fTRA_TRANREF.IsEmpty()) then begin
    fTRA_TRANREF.First();
    while not t.EOF do begin

      fFIS_NFREF.Append();
      fFIS_NFREF.CD_EMPRESAREF := fTRA_TRANREF.CD_EMPRESANFREF;
      fFIS_NFREF.NR_FATURAREF := fTRA_TRANREF.NR_FATURANFREF;
      fFIS_NFREF.DT_FATURAREF := fTRA_TRANREF.DT_FATURANFREF;
      fFIS_NFREF.CD_OPERADOR := PARAM_GLB.CD_USUARIO;
      fFIS_NFREF.DT_CADASTRO := Now;
      fFIS_NFREF.TP_REFERENCIAL := fTRA_TRANREF.TP_REFERENCIAL;

      fTRA_TRANREF.Next();
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
  piDsLstSelo := pParams.DS_LSTSELO;

  if (piDsLstSelo <> '') then begin
    repeat
      getitem(vDsRegistro, piDsLstSelo, 1);

      fFIS_NFISELOENT.VL_BASECALC := fFIS_NFISELOENT.VL_BASECALC := vDsRegistro.VL_BASECALC;
      fFIS_NFISELOENT.VL_SUBTRIB := fFIS_NFISELOENT.VL_SUBTRIB := vDsRegistro.VL_SUBTRIB;
      fFIS_NFISELOENT.VL_IPI := fFIS_NFISELOENT.VL_IPI := vDsRegistro.VL_IPI;
      fFIS_NFISELOENT.VL_FRETE := fFIS_NFISELOENT.VL_FRETE := vDsRegistro.VL_FRETE;
      fFIS_NFISELOENT.VL_SEGURO := fFIS_NFISELOENT.VL_SEGURO := vDsRegistro.VL_SEGURO;
      fFIS_NFISELOENT.VL_DESPACESSOR := fFIS_NFISELOENT.VL_DESPACESSOR := vDsRegistro.VL_DESPACESSOR;
      fFIS_NFISELOENT.PR_ALIQUOTA := fFIS_NFISELOENT.PR_ALIQUOTA := vDsRegistro.PR_ALIQUOTA;
      fFIS_NFISELOENT.CD_OPERADOR := PARAM_GLB.CD_USUARIO;
      fFIS_NFISELOENT.DT_CADASTRO := Now;

      delitemGld(piDsLstSelo, 1);
    until (piDsLstSelo = '');
    fFIS_NFISELOENT.First();
  end;

  return(0); exit;

end;

//-----------------------------------------------------------
function T_FISSVCO004.alteraVlIpi(pParams : String) : String;
//-----------------------------------------------------------
const
  cDS_METHOD = 'ADICIONAL=Operação: T_FISSVCO004.alteraVlIpi()';
begin
  if (fFIS_NF.IsEmpty()) then begin
    return(0); exit;
  end;
  if (gInIncluiIpiDevSimp = True) and (fGER_OPERACAO.TP_MODALIDADE = 3)and(gInOptSimples = True) and (item_f('VL_IPI', tFIS_NF) > 0) then begin
    fFIS_NFITEM.First();
    while(xStatus >= 0) do begin

      fFIS_NFITEMIMPOST.First();
      while(xStatus >= 0) do begin
        if (fFIS_NFITEMIMPOST.CD_IMPOSTO = 3) then begin
          fFIS_NFITEMIMPOST.Remover();
          break;
        end;
        fFIS_NFITEMIMPOST.Next();
      end;

      fFIS_NFITEM.Next();
    end;

    fFIS_NF.VL_IPI := 0;
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
  vCdEmpresaTra := fTRA_TRANSACAO.CD_EMPRESA;
  vNrTransacao := fTRA_TRANSACAO.NR_TRANSACAO;
  vDtTransacao := fTRA_TRANSACAO.DT_TRANSACAO;
  vCdEmpresaNf := fFIS_NF.CD_EMPRESA;
  vNrFatura := fFIS_NF.NR_FATURA;
  vDtFatura := fFIS_NF.DT_FATURA;

  if (vCdEmpresaTra = 0) then begin
    raise Exception.Create('Empresa da transação não informada!' + ' / ' := cDS_METHOD);
    
  end;
  if (vNrTransacao = 0) then begin
    raise Exception.Create('Número da transação não informado!' + ' / ' := cDS_METHOD);
    
  end;
  if (vDtTransacao = 0) then begin
    raise Exception.Create('Data da transação não informada!' + ' / ' := cDS_METHOD);
    
  end;
  if (vCdEmpresaNf = 0) then begin
    raise Exception.Create('Empresa da nota fiscal não informada!' + ' / ' := cDS_METHOD);
    
  end;
  if (vNrFatura = 0) then begin
    raise Exception.Create('Número da fatura não informado!' + ' / ' := cDS_METHOD);
    
  end;
  if (vDtFatura = 0) then begin
    raise Exception.Create('Data da fatura não informada!' + ' / ' := cDS_METHOD);
    
  end;

  if not (fTRA_SELOENT.IsEmpty()) then begin
    fFIS_NFSELOENT.Limpar();
    fFIS_NFSELOENT.Append();
    fFIS_NFSELOENT.VL_ANTECIPADO := fTRA_SELOENT.VL_ANTECIPADO;
    fFIS_NFSELOENT.VL_SUBSTITUIDO := fTRA_SELOENT.VL_SUBSTITUIDO;
    fFIS_NFSELOENT.VL_DIFERENCIAL := fTRA_SELOENT.VL_DIFERENCIAL;
    fFIS_NFSELOENT.CD_OPERADOR := PARAM_GLB.CD_USUARIO;
    fFIS_NFSELOENT.DT_CADASTRO := Now;
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
  vCdEmpresa := pParams.CD_EMPRESA;
  vDsLstTransacao := pParams.DS_LSTTRANSACAO;
  gInReemissao := pParams.IN_REEMISSAO;
  gCdModeloNF := pParams.CD_MODELONF;
  gNrNf := pParams.NR_NF;
  gCdSerie := pParams.CD_SERIE;
  gDtEmissao := pParams.DT_EMISSAO;
  gDtSaidaEntrada := pParams.DT_SAIDAENTRADA;
  gDtEntrega := pParams.DT_ENTREGA;
  gDtFatura := pParams.DT_FATURA;
  gHrSaida := pParams.HR_SAIDA;
  gLstLoteInfGeral := '';
  gInItemLote := pParams.IN_ITEMLOTE;
  gTinTinturaria := PARAM_GLB.TIN_TINTURARIA;
  vTpContrInspSaldoLote := PARAM_GLB.TP_CONTR_INSP_SALDO_LOTE;

  if (gDtSaidaEntrada = 0) then begin
    gDtSaidaEntrada := PARAM_GLB.DT_SISTEMA;
  end;

  gTpModDctoFiscalLocal := pParams.TP_MODDCTOFISCAL;
  gCdEspecieServico := PARAM_GLB.CD_ESPECIE_SERVICO_TRA;
  gDsLstFatura := '';

  if (pParams.IN_ITEMLOTE = '') then begin
    if (vTpContrInspSaldoLote = 1) then begin
      gInItemLote := True;
    end else begin
      gInItemLote := False;
    end;
  end;
  if (vDsLstTransacao = '') then begin
    raise Exception.Create('Lista de transação não informada!' + ' / ' := cDS_METHOD);
    
  end;

  if (gDtEncerramento <> 0) and (gDtSaidaEntrada <> 0) then begin
    if (gDtSaidaEntrada <= gDtEncerramento) then begin
      raise Exception.Create('NF/Fatura ' + fFIS_NF.NR_NF + '/' + item_a('NR_FATURA' + ' / ' := tFIS_NF) + ' possui data de movimento anterior ao encerramento do livro fiscal!', cDS_METHOD);
      
    end;
  end;

  vCdTipoClas := gCdTipoClas;

  fPRD_TIPOCLAS.Limpar();
  while (length(vCdTipoClas) > 0) do begin
    fPRD_TIPOCLAS.Append();
    Pos(';',vCdTipoClas);
    if (xResult > 0) then begin
      fPRD_TIPOCLAS.CD_TIPOCLAS := copy(vCdTipoClas, 1, round(xResult) - 1);
      vCdTipoClas := copy(vCdTipoClas, round(xResult) + 1, length(vCdTipoClas));
    end else begin
      fPRD_TIPOCLAS.CD_TIPOCLAS := vCdTipoClas;
      vCdTipoClas := '';
    end;
    fPRD_TIPOCLAS.Consultar();
    if (xStatus = -7) then begin
      fPRD_TIPOCLAS.Consultar();
    end else begin
      fPRD_TIPOCLAS.Remove();
    end;
    length(vCdTipoClas);
  end;

  fFIS_NF.Limpar();

  repeat
    getitem(vDsRegistro, vDsLstTransacao, 1);
    vCdEmpresa := vDsRegistro.CD_EMPRESA;
    vNrTransacao := vDsRegistro.NR_TRANSACAO;
    vDtTransacao := vDsRegistro.DT_TRANSACAO;

    if (vCdEmpresa = 0) then begin
      raise Exception.Create('Empresa não informada!' + ' / ' := cDS_METHOD);
      
    end;
    if (vNrTransacao = 0) then begin
      raise Exception.Create('Número da transação não informado!' + ' / ' := cDS_METHOD);
      
    end;
    if (vDtTransacao = 0) then begin
      raise Exception.Create('Número da transação não informado!' + ' / ' := cDS_METHOD);
      
    end;

    fTRA_TRANSACAO.Limpar();
    fTRA_TRANSACAO.CD_EMPRESA := vCdEmpresa;
    fTRA_TRANSACAO.NR_TRANSACAO := vNrTransacao;
    fTRA_TRANSACAO.DT_TRANSACAO := vDtTransacao;
    fTRA_TRANSACAO.Listar();
    if (itemXmlF('status', voParams) < 0) then begin
      raise Exception.Create('Transação ' + FloatToStr(vNrTransacao) + ' não cadastrada!' + ' / ' := cDS_METHOD);
      
    end;

    viParams := '';
    viParams.CD_PESSOA := fTRA_TRANSACAO.CD_PESSOA;
    voParams := cPESSVCO005.Instance.buscaDadosPessoa(viParams); 
    if (itemXmlF('status', voParams) < 0) then begin
      raise Exception.Create(itemXml('message', voParams));
      
    end;
    gTpRegimeTrib := voParams.TP_REGIMETRIB;


		gInCalcTributo := False;
		if (gPrTotalTributo > 0) and (fTRA_TRANSACAO.TP_ORIGEMEMISSAO = 1) and
       (voParams.IN_CNSRFINAL = True) or (voParams.TP_PESSOA = 'F') then begin
			gInCalcTributo := True;
    end;

    viParams := '';
    viParams.CD_CLIENTE := fTRA_TRANSACAO.CD_PESSOA;
    voParams := cFISSVCO032.Instance.carregaPesCliente(viParams); 
    if (itemXmlF('status', voParams) < 0) then begin
      raise Exception.Create(itemXml('message', voParams));
      
    end;
    gNrCodFiscal := voParams.NR_CODIGOFISCAL;

    vInPrimeira := True;

    fGER_MODNFC.Limpar();
    fFIS_DECRETO.Limpar();
    gInQuebraItem := False;
    gTpAgrupamento := 'F';
    if (gTpImpressaoCodPrdEcf = 0) then begin
      gTpCodigoItem := 4;
    end;
    vInItemDescritivo := False;

    if (fTRA_TRANSACAO.TP_ORIGEMEMISSAO = 1) then begin
      if (gCdModeloNF > 0) then begin
        fGER_MODNFC.CD_MODELONF := gCdModeloNF;
        fGER_MODNFC.Listar();
        if (xStatus >= 0) then begin
          if (fGER_MODNFC.IN_AGRUPA_GRUPO = '') then begin
            raise Exception.Create('Modelo de NF ' + FloatToStr(gCdModeloNF) + ' não possui tipo de agrupamento de item informado. Utilize o GERFM016 para cadastrar!' + ' / ' := cDS_METHOD);
            
          end;
          if (fGER_MODNFC.TP_CODPRODUTO = 0) then begin
            raise Exception.Create('Modelo de NF ' + FloatToStr(gCdModeloNF) + ' não possui tipo de código de item informado. Utilize o GERFM016 para cadastrar!' + ' / ' := cDS_METHOD);
            
          end;

          if (gTpModDctoFiscalLocal = 55) then begin
            gInQuebraItem := False;
          end else begin
            gInQuebraItem := fGER_MODNFC.IN_QUEBRANF;
          end;
          gTpAgrupamento := fGER_MODNFC.IN_AGRUPA_GRUPO;
          gTpCodigoItem := fGER_MODNFC.TP_CODPRODUTO;
        end;
      end;
      if (gInReemissao) then begin
        if (gNrNf = 0) then begin
          raise Exception.Create('Número de NF não informado!' + ' / ' := cDS_METHOD);
          
        end;
      end;
    end else begin
      if (gNrNf = 0) then begin
        raise Exception.Create('Número de NF não informado!' + ' / ' := cDS_METHOD);
        
      end;

      fV_FIS_NFREMDES.Limpar();
      fV_FIS_NFREMDES.CD_EMPFAT := fTRA_TRANSACAO.CD_EMPFAT;
      if (fTRA_REMDES.CD_PESSOA <> '') then begin
        fV_FIS_NFREMDES.CD_PESSOAREMDES := fTRA_REMDES.CD_PESSOA;
      end else begin
        fV_FIS_NFREMDES.CD_PESSOANF := fTRA_TRANSACAO.CD_PESSOA;
      end;
      fV_FIS_NFREMDES.NR_NF := gNrNf;
      fV_FIS_NFREMDES.CD_SERIE := gCdSerie;
      fV_FIS_NFREMDES.TP_SITUACAO := '!=X';
      fV_FIS_NFREMDES.TP_ORIGEMEMISSAO := 2;
      fV_FIS_NFREMDES.TP_MODDCTOFISCAL := gTpModDctoFiscalLocal;
      fV_FIS_NFREMDES.Listar();
      if (xStatus >= 0) then begin
        if ((fV_FIS_NFREMDES.NR_FATURA <> item_f('NR_FATURA', tFIS_NF)) or (fV_FIS_NFREMDES.DT_FATURA <> item_a('DT_FATURA', tFIS_NF)))
        and (fV_FIS_NFREMDES.TP_MODDCTOFISCAL <> 6) and (fV_FIS_NFREMDES.TP_MODDCTOFISCAL <> 21) and (fV_FIS_NFREMDES.TP_MODDCTOFISCAL <> 22) then begin
          raise Exception.Create('NF ' + FloatToStr(gNrNf) + ' ' + FloatToStr(gCdSerie) + ' Modelo Documento ' + FloatToStr(gTpModDctoFiscallocal) + ' já cadastrada para a pessoa ' + fV_FIS_NFREMDES.CD_PESSOAREMDES + '!' + ' / ' := cDS_METHOD);
          
        end;
      end;
      gInQuebraCFOP := False;
    end;

    fGER_OPERACAO.Limpar();
    fGER_OPERACAO.CD_OPERACAO := fTRA_TRANSACAO.CD_OPERACAO;
    fGER_OPERACAO.Listar();
    if (itemXmlF('status', voParams) < 0) then begin
      raise Exception.Create('Operaçao ' + fGER_OPERACAO.CD_OPERACAO + ' não cadastrada!' + ' / ' := cDS_METHOD);
      
    end;
    if (fTRA_TRANSACAO.TP_ORIGEMEMISSAO = 1) then begin
      if (fGER_OPERACAO.TP_DOCTO = 2) or (fGER_OPERACAO.TP_DOCTO = 3) then begin
        gInQuebraItem := False;
        gTpAgrupamento := 'F';
        if (gTpImpressaoCodPrdEcf = 0) then begin
          gTpCodigoItem := 4;
        end;
        gInQuebraCFOP := False;
      end;
    end;

    fGER_S_OPERACAO.First();
    if not (fGER_S_OPERACAO.IsDatabase()) then begin
      raise Exception.Create('Operação ' + fGER_OPERACAO.CD_OPERACAO + ' não possui operação de movimento!' + ' / ' := cDS_METHOD);
      
    end;
    if (fTRA_TRANSACAO.TP_ORIGEMEMISSAO = 1) then begin
      if (fGER_S_OPERACAO.TP_DOCTO = 2) or (fGER_S_OPERACAO.TP_DOCTO = 3) then begin
        gInQuebraItem := False;
        gTpAgrupamento := 'F';
        if (gTpImpressaoCodPrdEcf = 0) then begin
          gTpCodigoItem := 4;
        end;
        gInQuebraCFOP := False;
      end else if (fGER_S_OPERACAO.TP_DOCTO = 1) then begin
        vDsNulo := '';
        fTRA_TRANSITEM.Limpar();
        fTRA_TRANSITEM.CD_EMPRESA := fTRA_TRANSACAO.CD_EMPRESA;
        fTRA_TRANSITEM.NR_TRANSACAO := fTRA_TRANSACAO.NR_TRANSACAO;
        fTRA_TRANSITEM.DT_TRANSACAO := fTRA_TRANSACAO.DT_TRANSACAO;
        fTRA_TRANSITEM.CD_PRODUTO := '=';
        fTRA_TRANSITEM.CD_BARRAPRD := '=';
        fTRA_TRANSITEM.Listar();
        if (xStatus >= 0) then begin
          vInItemDescritivo := True;
        end;
        fTRA_TRANSITEM.Limpar();
        fTRA_TRANSITEM.Listar();
      end;
      if (fGER_S_OPERACAO.TP_MODALIDADE = '6') then begin
        gInQuebraCFOP := False;
      end;
      if (fGER_S_OPERACAO.TP_MODALIDADE = 'A') then begin
        gTpAgrupamento := 'F';
      end;
    end;
    if (fGER_S_OPERACAO.CD_REGRAFISCAL > 0) then begin
      vCdRegraFiscal := fGER_S_OPERACAO.CD_REGRAFISCAL;
    end else if (fGER_OPERACAO.CD_REGRAFISCAL > 0) then begin
      vCdRegraFiscal := fGER_OPERACAO.CD_REGRAFISCAL;
    end;

    viParams := '';
    viParams.CD_REGRAFISCAL := vCdRegraFiscal;
    voParams := cFISSVCO033.Instance.buscaDadosRegraFiscal(viParams);
    if (itemXmlF('status', voParams) < 0) then begin
      raise Exception.Create(itemXml('message', voParams));
      
    end;

    vTpReducao := voParams.TP_REDUCAO;
    vTpAliqIcms := voParams.TP_ALIQICMS;
    vCdDecreto := voParams.CD_DECRETO;
    gUfDestino := fTRA_REMDES.DS_SIGLAESTADO;
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

    if (vInObs) then begin
      gDsAdicionalRegra := voParams.DS_ADICIONAL;
    end;
    if not (fTRA_TRANSITEM.IsEmpty()) then begin
      if (gDtEmissao = 0) then begin
        if (fTRA_TRANSACAO.TP_ORIGEMEMISSAO = 2) then begin
          gDtEmissao := fTRA_TRANSACAO.DT_TRANSACAO;
        end else begin
          gDtEmissao := PARAM_GLB.DT_SISTEMA;
        end;
      end;

      vInLoopCapa := True;
      if (vInItemDescritivo) then begin
        sort_e(tTRA_TRANSITEM, 'NR_ITEM');
      end else begin
        if (gTpAgrupamento = 'T') then begin
          sort_e(tTRA_TRANSITEM, 'CD_CFOP;CD_NIVELGRUPO;CD_SEQGRUPO;VL_UNITLIQUIDO;CD_COMPVEND');
        end else if (gTpAgrupamento = 'C') then begin
          sort_e(tTRA_TRANSITEM, 'CD_CFOP;CD_NIVELGRUPO;CD_SEQGRUPO;CD_COR;VL_UNITLIQUIDO;CD_COMPVEND');
        end else if (gTpAgrupamento = 'A') then begin
          sort_e(tTRA_TRANSITEM, 'CD_CFOP;CD_NIVELGRUPO;CD_SEQGRUPO;CD_TAMANHO;VL_UNITLIQUIDO;CD_COMPVEND');
        end else if (gInQuebraCFOP) then begin
          sort_e(tTRA_TRANSITEM, 'CD_CFOP;NR_ITEM');
        end else begin
          sort_e(tTRA_TRANSITEM, 'NR_ITEM');
        end;
      end;
      fTRA_TRANSITEM.Next();
      fTRA_TRANSITEM.First();

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
        fTMP_NR09.Limpar();
        fTMP_NR08.Limpar();
        fF_TMP_NR09.Limpar();

        if (gInLog) then begin
          gHrInicio := Time;
          putmess('- Inicio gera NF. geraCapaNF FISSVCO004: ' + TimeToStr(gHrInicio));
        end;

        voParams := geraCapaNF(viParams);
        if (itemXmlF('status', voParams) < 0) then begin
          raise Exception.Create(itemXml('message', voParams));
          
        end;

        if (gInLog) then begin
          gHrFim := Time;
          gHrTempo := gHrFim - gHrInicio;
          putmess('- Fim gera NF. geraCapaNF FISSVCO004: ' + TimeToStr(gHrFim) + ' - ' + TimeToStr(gHrTempo));

          gHrInicio := Time;
          putmess('- Inicio gera NF. geraRemDest FISSVCO004: ' + TimeToStr(gHrInicio));
        end;

        gInNFe := False;
        if not (fF_TMP_NR08.IsEmpty()) then begin
          fF_TMP_NR08.Append();
          fF_TMP_NR08.NR_08 := fFIS_NF.TP_MODDCTOFISCAL;
          fF_TMP_NR08.Consultar();
          if (xStatus = 4) then begin
            gInNFe := True;
          end else begin
            fF_TMP_NR08.Remover();
          end;
        end;

        voParams := geraRemDest(viParams);
        if (itemXmlF('status', voParams) < 0) then begin
          raise Exception.Create(itemXml('message', voParams));
          
        end;

        if (gInLog) then begin
          gHrFim := Time;
          gHrTempo := gHrFim - gHrInicio;
          putmess('- Fim gera NF. geraRemDest FISSVCO004: ' + TimeToStr(gHrFim) + ' - ' + TimeToStr(gHrTempo));

          gHrInicio := Time;
          putmess('- Inicio gera NF. geraNFReferencial FISSVCO004: ' + TimeToStr(gHrInicio));
        end;

        voParams := geraNFReferencial(viParams);
        if (itemXmlF('status', voParams) < 0) then begin
          raise Exception.Create(itemXml('message', voParams));
          
        end;

        if (gInLog) then begin
          gHrFim := Time;
          gHrTempo := gHrFim - gHrInicio;
          putmess('- Fim gera NF. geraNFReferencial FISSVCO004: ' + TimeToStr(gHrFim) + ' - ' + TimeToStr(gHrTempo));
        end;

        voParams := geraSeloFiscalEnt(viParams);
        if (itemXmlF('status', voParams) < 0) then begin
          raise Exception.Create(itemXml('message', voParams));
          
        end;

        while (vTpLoopItem = 0) do begin
          vRegistroNext := next(tTRA_TRANSITEM);
          vCdSeqGrupoProx := vRegistroNext.CD_SEQGRUPO;
          vCdCorProx := vRegistroNext.CD_COR;
          vCdTamanhoProx := vRegistroNext.CD_TAMANHO;
          vVlUnitProx := vRegistroNext.VL_UNITLIQUIDO;
          vCdCFOPProx := vRegistroNext.CD_CFOP;
          vCdCompVendProx := vRegistroNext.CD_COMPVEND;

          vDsRegistroItem := '';
          vDsRegistroItem.CD_PRODUTO := fTRA_TRANSITEM.CD_PRODUTO;
          vDsRegistroItem.CD_COMPVEND := fTRA_TRANSITEM.CD_COMPVEND;
          vDsRegistroItem.CD_PROMOCAO := fTRA_TRANSITEM.CD_PROMOCAO;
          vDsRegistroItem.QT_FATURADO := fTRA_TRANSITEM.QT_SOLICITADA;
          vDsRegistroItem.VL_UNITBRUTO := fTRA_TRANSITEM.VL_UNITBRUTO;
          vDsRegistroItem.VL_UNITLIQUIDO := fTRA_TRANSITEM.VL_UNITLIQUIDO;
          vVlCalc := fTRA_TRANSITEM.VL_UNITDESC + item_f('VL_UNITDESCCAB', tTRA_TRANSITEM);
          vDsRegistroItem.VL_TOTALBRUTO := fTRA_TRANSITEM.VL_TOTALBRUTO;
          vDsRegistroItem.VL_TOTALLIQUIDO := fTRA_TRANSITEM.VL_TOTALLIQUIDO;
          vDsRegistroItem.VL_UNITDESC := vVlCalc;
          vVlCalc := fTRA_TRANSITEM.VL_TOTALDESC + item_f('VL_TOTALDESCCAB', tTRA_TRANSITEM);
          vDsRegistroItem.VL_TOTALDESC := vVlCalc;
          if not (fTRA_ITEMIMPOSTO.IsEmpty()) then begin
            fTRA_ITEMIMPOSTO.First();
            while not t.EOF do begin
              fTMP_NR09.Append();
              fTMP_NR09.NR_GERAL := fTRA_ITEMIMPOSTO.CD_IMPOSTO;
              fTMP_NR09.Consultar();
              fTMP_NR09.PR_ALIQUOTA := fTRA_ITEMIMPOSTO.PR_ALIQUOTA;
              fTMP_NR09.PR_BASECALC := fTRA_ITEMIMPOSTO.PR_BASECALC;
              fTMP_NR09.PR_REDUBASE := fTRA_ITEMIMPOSTO.PR_REDUBASE;
              fTMP_NR09.VL_BASECALC := fTMP_NR09.VL_BASECALC + item_f('VL_BASECALC', tTRA_ITEMIMPOSTO);
              fTMP_NR09.VL_ISENTO := fTMP_NR09.VL_ISENTO   + item_f('VL_ISENTO', tTRA_ITEMIMPOSTO);
              fTMP_NR09.VL_OUTRO := fTMP_NR09.VL_OUTRO    + item_f('VL_OUTRO', tTRA_ITEMIMPOSTO);
              fTMP_NR09.VL_IMPOSTO := fTMP_NR09.VL_IMPOSTO  + item_f('VL_IMPOSTO', tTRA_ITEMIMPOSTO);
              fTMP_NR09.CD_CST := fTRA_ITEMIMPOSTO.CD_CST;

              fTRA_ITEMIMPOSTO.Next();
            end;
          end;
          if not (fTRA_ITEMSERIAL.IsEmpty()) then begin
            vDsLstSerial := '';
            fTRA_ITEMSERIAL.First();
            while not t.EOF do begin
              vDsRegistro := '';
              vDsRegistro.NR_SEQUENCIA := fTRA_ITEMSERIAL.NR_SEQUENCIA;
              vDsRegistro.CD_EMPFAT := fTRA_ITEMSERIAL.CD_EMPFAT;
              vDsRegistro.CD_GRUPOEMPRESA := fTRA_ITEMSERIAL.CD_GRUPOEMPRESA;
              vDsRegistro.DS_SERIAL := fTRA_ITEMSERIAL.DS_SERIAL;
              putitem(vDsLstSerial,  vDsRegistro);
              fTRA_ITEMSERIAL.Next();
            end;
            vDsRegistroItem.DS_LSTSERIAL := vDsLstSerial;
          end;
          if not (fTRA_ITEMVL.IsEmpty()) then begin
            vDsLstValor := '';
            fTRA_ITEMVL.First();
            while not t.EOF do begin
              vDsRegistro := '';
              vDsRegistro.TP_VALOR := fTRA_ITEMVL.TP_VALOR;
              vDsRegistro.CD_VALOR := fTRA_ITEMVL.CD_VALOR;
              vDsRegistro.TP_ATUALIZACAO := fTRA_ITEMVL.TP_ATUALIZACAO;
              vDsRegistro.VL_UNITARIOORIG := fTRA_ITEMVL.VL_UNITARIOORIG;
              vDsRegistro.VL_UNITARIO := fTRA_ITEMVL.VL_UNITARIO;
              vDsRegistro.PR_DESCONTO := fTRA_ITEMVL.PR_DESCONTO;
              vDsRegistro.PR_DESCONTOCAB := fTRA_ITEMVL.PR_DESCONTOCAB;
              vDsRegistro.IN_PADRAO := fTRA_ITEMVL.IN_PADRAO;
              putitem(vDsLstValor,  vDsRegistro);
              fTRA_ITEMVL.Next();
            end;
            vDsRegistroItem.DS_LSTVALOR := vDsLstValor;
          end else begin
            if (fTRA_TRANSACAO.TP_OPERACAO = 'E') and ((fGER_OPERACAO.TP_MODALIDADE = 2) or (fGER_OPERACAO.TP_MODALIDADE = 4)) and (item_a('CD_ESPECIE', tTRA_TRANSITEM) <> gCdEspecieServico) then begin
              raise Exception.Create('Produto ' + fTRA_TRANSITEM.CD_PRODUTO + ' da transação ' + item_a('NR_TRANSACAO' + ' / ' := tTRA_TRANSITEM) + ' não possui valores cadastrados', cDS_METHOD);
              
            end;
          end;
          if not (fTRA_ITEMUN.IsEmpty()) then begin
            vDsRegistro := '';
            vDsRegistro.CD_EMPFAT := fTRA_ITEMUN.CD_EMPFAT;
            vDsRegistro.CD_GRUPOEMPRESA := fTRA_ITEMUN.CD_GRUPOEMPRESA;
            vDsRegistro.CD_ESPECIE := fTRA_ITEMUN.CD_ESPECIE;
            vDsRegistro.TP_OPERACAO := fTRA_ITEMUN.TP_OPERACAO;
            vDsRegistro.QT_CONVERSAO := fTRA_ITEMUN.QT_CONVERSAO;
            vDsRegistroItem.DS_LSTITEMUN := vDsRegistro;
          end;

          if not (fTRA_ITEMLOTE.IsEmpty()) then begin
            vDsLstValor := '';
            fTRA_ITEMLOTE.First();
            while not t.EOF do begin
              vDsRegistro := '';
              vDsRegistro.NR_SEQUENCIA := fTRA_ITEMLOTE.NR_SEQUENCIA;
              vDsRegistro.CD_EMPLOTE := fTRA_ITEMLOTE.CD_EMPLOTE;
              vDsRegistro.NR_LOTE := fTRA_ITEMLOTE.NR_LOTE;
              vDsRegistro.NR_ITEMLOTE := fTRA_ITEMLOTE.NR_ITEMLOTE;
              vDsRegistro.QT_LOTE := fTRA_ITEMLOTE.QT_LOTE;
              vDsRegistro.QT_CONE := fTRA_ITEMLOTE.QT_CONE;
              vDsRegistro.CD_BARRALOTE := fTRA_ITEMLOTE.CD_BARRALOTE;
              putitem(vDsLstValor,  vDsRegistro);
              fTRA_ITEMLOTE.Next();
            end;
            vDsRegistroItem.DS_LSTITEMLOTE := vDsLstValor;
          end;

          if not (fTRA_ITEMPRDFIN.IsEmpty()) then begin
            vDsLstValor := '';
            fTRA_ITEMPRDFIN.First();
            while not t.EOF do begin
              vDsRegistro := '';
              vDsRegistro.CD_EMPRESA := fTRA_ITEMPRDFIN.CD_EMPRESA;
              vDsRegistro.NR_TRANSACAO := fTRA_ITEMPRDFIN.NR_TRANSACAO;
              vDsRegistro.DT_TRANSACAO := fTRA_ITEMPRDFIN.DT_TRANSACAO;
              vDsRegistro.NR_ITEM := fTRA_ITEMPRDFIN.NR_ITEM;
              vDsRegistro.CD_EMPPRDFIN := fTRA_ITEMPRDFIN.CD_EMPPRDFIN;
              vDsRegistro.NR_PRDFIN := fTRA_ITEMPRDFIN.NR_PRDFIN;
              putitem(vDsLstValor,  vDsRegistro);
              fTRA_ITEMPRDFIN.Next();
            end;
            vDsRegistroItem.DS_LSTITEMPRDFIN := vDsLstValor;
          end;

          if not (fTRA_ITEMSELOENT.IsEmpty()) then begin
            fTRA_ITEMSELOENT.First();
            while not t.EOF do begin
              vDsRegistro := '';
              fTRA_ITEMSELOENT.SetValues(vDsRegistro);
              putitem(vDsLstSelo,  vDsRegistro);
              fTRA_ITEMSELOENT.Next();
            end;
          end;

          viParams := '';
          viParams.CD_EMPRESA := fTRA_TRANSITEM.CD_EMPRESA;
          viParams.NR_TRANSACAO := fTRA_TRANSITEM.NR_TRANSACAO;
          viParams.DT_TRANSACAO := fTRA_TRANSITEM.DT_TRANSACAO;
          viParams.NR_ITEM := fTRA_TRANSITEM.NR_ITEM;
          voParams := cTRASVCO016.Instance.buscaDespesaItem(viParams); 
          if (itemXmlF('status', voParams) < 0) then begin
            raise Exception.Create(itemXml('message', voParams));
            
          end;
          vDsLstDespesa := voParams.DS_LSTDESPESA;
          if (vDsLstDespesa <> '') then begin
            vDsRegistroItem.DS_LSTDESPESA := vDsLstDespesa;
          end;

          putitem(vDsLstItem, vDsRegistroItem);

          vInAgrupaItem := False;

          if (fTRA_TRANSITEM.RecNo < fTRA_TRANSITEM.RecordCount()) then begin
            if (gTpAgrupamentoItemNF = 01) then begin
              if (gTpAgrupamento = 'T') then begin
                if (fTRA_TRANSITEM.CD_CFOP = vCdCFOPProx) and (item_f('CD_SEQGRUPO', tTRA_TRANSITEM) = vCdSeqGrupoProx) and (item_f('CD_COMPVEND', tTRA_TRANSITEM) = vCdCompVendProx) then begin
                  vInAgrupaItem := True;
                end;
              end else if (gTpAgrupamento = 'C') then begin
                if (fTRA_TRANSITEM.CD_CFOP = vCdCFOPProx) and (item_f('CD_SEQGRUPO', tTRA_TRANSITEM) = vCdSeqGrupoProx) and (item_f('CD_COMPVEND', tTRA_TRANSITEM) = vCdCompVendProx) and (fTRA_TRANSITEM.CD_COR = vCdCorProx) then begin
                  vInAgrupaItem := True;
                end;
              end else if (gTpAgrupamento = 'A') then begin
                if (fTRA_TRANSITEM.CD_CFOP = vCdCFOPProx) and (item_f('CD_SEQGRUPO', tTRA_TRANSITEM) = vCdSeqGrupoProx)   and (item_f('CD_COMPVEND', tTRA_TRANSITEM) = vCdCompVendProx) and (item_f('CD_TAMANHO', tTRA_TRANSITEM) = vCdTamanhoProx) then begin
                  vInAgrupaItem := True;
                end;
              end;
            end else begin
              if (gTpAgrupamento = 'T') then begin
                if (fTRA_TRANSITEM.CD_CFOP = vCdCFOPProx) and (item_f('CD_SEQGRUPO', tTRA_TRANSITEM) = vCdSeqGrupoProx) and (item_f('VL_UNITLIQUIDO', tTRA_TRANSITEM) = vVlUnitProx) and (item_f('CD_COMPVEND', tTRA_TRANSITEM) = vCdCompVendProx) then begin
                  vInAgrupaItem := True;
                end;
              end else if (gTpAgrupamento = 'C') then begin
                if (fTRA_TRANSITEM.CD_CFOP = vCdCFOPProx) and (item_f('CD_SEQGRUPO', tTRA_TRANSITEM) = vCdSeqGrupoProx) and (item_f('VL_UNITLIQUIDO', tTRA_TRANSITEM) = vVlUnitProx) and (item_f('CD_COMPVEND', tTRA_TRANSITEM) = vCdCompVendProx) and (fTRA_TRANSITEM.CD_COR = vCdCorProx) then begin
                  vInAgrupaItem := True;
                end;
              end else if (gTpAgrupamento = 'A') then begin
                if (fTRA_TRANSITEM.CD_CFOP = vCdCFOPProx) and (item_f('CD_SEQGRUPO', tTRA_TRANSITEM) = vCdSeqGrupoProx) and (item_f('VL_UNITLIQUIDO', tTRA_TRANSITEM) = vVlUnitProx) and (item_f('CD_COMPVEND', tTRA_TRANSITEM) = vCdCompVendProx) and (item_f('CD_TAMANHO', tTRA_TRANSITEM) = vCdTamanhoProx) then begin
                  vInAgrupaItem := True;
                end;
              end;
            end;
            if (fTRA_TRANSITEM.CD_PRODUTO = 0) and (fTRA_TRANSITEM.CD_BARRAPRD = '') then begin
              vInAgrupaItem := False;
            end;
          end;
          if (vInAgrupaItem) then begin
            vQtFaturado := vQtFaturado + fTRA_TRANSITEM.QT_SOLICITADA;
            vVlTotalBruto := vVlTotalBruto + fTRA_TRANSITEM.VL_TOTALBRUTO;
            vVlTotalLiquido := vVlTotalLiquido + fTRA_TRANSITEM.VL_TOTALLIQUIDO;
            vVlTotalDesc := vVlTotalDesc + fTRA_TRANSITEM.VL_TOTALDESC;
            vVlTotalDescCab := vVlTotalDescCab + fTRA_TRANSITEM.VL_TOTALDESCCAB;
          end else begin
            vNrItem := vNrItem + 1;
            fTRA_TRANSITEM.QT_SOLICITADA := fTRA_TRANSITEM.QT_SOLICITADA + vQtFaturado;
            fTRA_TRANSITEM.VL_TOTALBRUTO := fTRA_TRANSITEM.VL_TOTALBRUTO + vVlTotalBruto;
            fTRA_TRANSITEM.VL_TOTALLIQUIDO := fTRA_TRANSITEM.VL_TOTALLIQUIDO + vVlTotalLiquido;
            fTRA_TRANSITEM.VL_TOTALDESC := fTRA_TRANSITEM.VL_TOTALDESC + vVlTotalDesc;
            fTRA_TRANSITEM.VL_TOTALDESCCAB := fTRA_TRANSITEM.VL_TOTALDESCCAB + vVlTotalDescCab;

            if (gInLog = True) and (fTRA_TRANSITEM.RecNo = 1) then begin
              gHrInicio := Time;
              putmess('- Inicio gera NF. geraItemNF FISSVCO004: ' + TimeToStr(gHrInicio));
            end;

            viParams := '';
            viParams.DS_LSTPRODUTO := vDsLstItem;
            viParams.NR_ITEM := vNrItem;
            voParams := geraItemNF(viParams);
            if (itemXmlF('status', voParams) < 0) then begin
              raise Exception.Create(itemXml('message', voParams));
              
            end;

            if (gInLog = True) and (fTRA_TRANSITEM.RecNo = 1) then begin
              gHrFim := Time;
              gHrTempo := gHrFim - gHrInicio;
              putmess('- Fim gera NF. geraItemNF FISSVCO004: ' + TimeToStr(gHrFim) + ' - ' + TimeToStr(gHrTempo));
            end;

            viParams := '';
            viParams.DS_LSTSELO := vDsLstSelo;
            voParams := geraItemSeloEnt(viParams);
            if (itemXmlF('status', voParams) < 0) then begin
              raise Exception.Create(itemXml('message', voParams));
              
            end;

            vDsLstItem := '';
            vDsLstSelo := '';
            vQtFaturado := 0;
            vVlTotalBruto := 0;
            vVlTotalLiquido := 0;
            vVlTotalDesc := 0;
            vVlTotalDescCab := 0;
            fTMP_NR09.Limpar();
          end;
          if (gInQuebraItem = True) and (vNrItem = fGER_MODNFC.NR_ITENS) then begin
            vTpLoopItem := 1;
          end;
          if (gInQuebraCFOP = True) and (fTRA_TRANSITEM.CD_CFOP <> vCdCFOPProx) then begin
            vTpLoopItem := 1;
          end;
          if (gNrItemQuebraNf > 0) and (vNrItem = gNrItemQuebraNf) then begin
            vTpLoopItem := 1;
          end;

          fTRA_TRANSITEM.Next();
          if (itemXmlF('status', voParams) < 0) then begin
            vTpLoopItem := 2;
          end;
        end;
        if (vInPrimeira) then begin
          if (gInLog) then begin
            gHrInicio := Time;
            putmess('- Inicio gera NF. geraTransport FISSVCO004: ' + TimeToStr(gHrInicio));
          end;

          voParams := geraTransport(viParams);
          if (itemXmlF('status', voParams) < 0) then begin
            raise Exception.Create(itemXml('message', voParams));
            
          end;

          if (gInLog) then begin
            gHrFim := Time;
            gHrTempo := gHrFim - gHrInicio;
            putmess('- Fim gera NF. geraTransport FISSVCO004: ' + TimeToStr(gHrFim) + ' - ' + TimeToStr(gHrTempo));
          end;

          voParams := rateiaValorCapa(viParams);
          if (itemXmlF('status', voParams) < 0) then begin
            raise Exception.Create(itemXml('message', voParams));
            
          end;

          vInPrimeira := False;
        end;

        voParams := geraImpostoItem(viParams);
        if (itemXmlF('status', voParams) < 0) then begin
          raise Exception.Create(itemXml('message', voParams));
          
        end;

        putitem_e(tFIS_NF, 'VL_TOTALNOTA', fFIS_NF.VL_TOTALPRODUTO + item_f('VL_DESPACESSOR', tFIS_NF) +
                                           fFIS_NF.VL_FRETE + item_f('VL_SEGURO', tFIS_NF) +
                                           fFIS_NF.VL_IPI + item_f('VL_ICMSSUBST', tFIS_NF));

        if (gInLog) then begin
          gHrInicio := Time;
          putmess('- Inicio gera NF. geraParcela FISSVCO004: ' + TimeToStr(gHrInicio));
        end;

        voParams := geraParcela(viParams);
        if (itemXmlF('status', voParams) < 0) then begin
          raise Exception.Create(itemXml('message', voParams));
          
        end;

        if (gInLog) then begin
          gHrFim := Time;
          gHrTempo := gHrFim - gHrInicio;
          putmess('- Fim gera NF. geraParcela FISSVCO004: ' + TimeToStr(gHrFim) + ' - ' + TimeToStr(gHrTempo));

          gHrInicio := Time;
          putmess('- Inicio gera NF. geraECF FISSVCO004: ' + TimeToStr(gHrInicio));
        end;

        voParams := geraECF(viParams);
        if (itemXmlF('status', voParams) < 0) then begin
          raise Exception.Create(itemXml('message', voParams));
          
        end;

        if (gInLog) then begin
          gHrFim := Time;
          gHrTempo := gHrFim - gHrInicio;
          putmess('- Fim gera NF. geraECF FISSVCO004: ' + TimeToStr(gHrFim) + ' - ' + TimeToStr(gHrTempo));
        end;

        viParams := '';
        viParams.DS_LINHAOBS := vDsLinhaObs;
        voParams := geraObservacao(viParams);
        if (itemXmlF('status', voParams) < 0) then begin
          raise Exception.Create(itemXml('message', voParams));
          
        end;

        if (vTpLoopItem = 2) then begin
          vInLoopCapa := False;
        end;
      end;
    end else begin
      if (gInLog) then begin
        gHrInicio := Time;
        putmess('- Inicio gera NF. geraCapaNF FISSVCO004: ' + TimeToStr(gHrInicio));
      end;

      voParams := geraCapaNF(viParams);
      if (itemXmlF('status', voParams) < 0) then begin
        raise Exception.Create(itemXml('message', voParams));
        
      end;

      if (gInLog) then begin
        gHrFim := Time;
        gHrTempo := gHrFim - gHrInicio;
        putmess('- Fim gera NF. geraCapaNF FISSVCO004: ' + TimeToStr(gHrFim) + ' - ' + TimeToStr(gHrTempo));

        gHrInicio := Time;
        putmess('- Inicio gera NF. geraRemDest FISSVCO004: ' + TimeToStr(gHrInicio));
      end;

      voParams := geraRemDest(viParams);
      if (itemXmlF('status', voParams) < 0) then begin
        raise Exception.Create(itemXml('message', voParams));
        
      end;

      if (gInLog) then begin
        gHrFim := Time;
        gHrTempo := gHrFim - gHrInicio;
        putmess('- Fim gera NF. geraRemDest FISSVCO004: ' + TimeToStr(gHrFim) + ' - ' + TimeToStr(gHrTempo));
      end;
    end;

    if (fGER_OPERACAO.TP_MODALIDADE = 'D') then begin
      fFIS_NF.VL_TOTALNOTA := 0;
      fFIS_NF.VL_TOTALPRODUTO := 0;
      fFIS_NF.VL_DESPACESSOR := 0;
      fFIS_NF.VL_SEGURO := 0;
      fFIS_NF.VL_FRETE := 0;
      fFIS_NF.QT_FATURADO := 0;
      fFIS_NF.VL_BASEICMS := 0;
    end;

    if (gInIncluiIpiDevSimp) then begin
      voParams := alteraVlIpi(viParams);
      if (itemXmlF('status', voParams) < 0) then begin
        raise Exception.Create(itemXml('message', voParams));
        
      end;
    end;

    delitemGld(vDsLstTransacao, 1);
  until (vDsLstTransacao = '');

  voParams := tFIS_NF.Salvar();
  if (itemXmlF('status', voParams) < 0) then begin
    raise Exception.Create(itemXml('message', voParams));
    
  end;

  if not (fFIS_NF.IsEmpty()) then begin
    vPos := fFIS_NF.RecNo;
    fFIS_NF.First();
    while not t.EOF do begin
      vLstNF := '';
      vLstNF.CD_EMPRESA := fFIS_NF.CD_EMPRESA;
      vLstNF.DT_FATURA := fFIS_NF.DT_FATURA;
      vLstNF.NR_FATURA := fFIS_NF.NR_FATURA;
      vLstNF.CD_MODELONF := fFIS_NF.CD_MODELONF;
      vLstNF.TP_ORIGEMEMISSAO := fFIS_NF.TP_ORIGEMEMISSAO;
      putitem(vDsLstNotaFiscal, vLstNF);
      fFIS_NF.Next();
    end;
    fFIS_NF.First();
  end;

  if (fGER_OPERACAO.TP_OPERACAO = 'S') and ((fGER_OPERACAO.TP_MODALIDADE = 3) or (fGER_OPERACAO.TP_MODALIDADE = 4)) then begin
    viParams := pParams;
    voParams := cFISSVCO024.Instance.gravaObsNfFisco(viParams);
    if (itemXmlF('status', voParams) < 0) then begin
      raise Exception.Create(itemXml('message', voParams));
      
    end;
  end;

  if (gTpModDctoFiscalLocal = 55) then begin
    repeat
      getitem(vDsRegistro, vDsLstNotaFiscal, 1);
      if (vDsRegistro.TP_ORIGEMEMISSAO = 1) then begin
        viParams.CD_EMPRESA := vDsRegistro.CD_EMPRESA;
        viParams.NR_FATURA := vDsRegistro.NR_FATURA;
        viParams.DT_FATURA := vDsRegistro.DT_FATURA;
        viParams.CD_MODELONF := vDsRegistro.CD_MODELONF;
        voParams := cFISSVCO024.Instance.gravaObsNfe(viParams);
        if (itemXmlF('status', voParams) < 0) then begin
          raise Exception.Create(itemXml('message', voParams));
          
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
      vCdEmpLote := vDsLoteInf.CD_EMPRESA;
      vNrLote := vDsLoteInf.NR_LOTE;
      vNrItemLote := vDsLoteInf.NR_ITEM;
      putitem(vDsLstNF,  vDsLoteInf);
      viParams := '';
      viParams.CD_EMPRESA := vCdEmpLote;
      viParams.NR_LOTE := vNrLote;
      viParams.NR_ITEM := vNrItemLote;
      viParams.IN_INCLUSAO := True;
      viParams.DS_LSTNF := vDsLstNF;
      voParams := cPRDSVCO020.Instance.gravaLoteINF(viParams);
      if (itemXmlF('status', voParams) < 0) then begin
        raise Exception.Create(itemXml('message', voParams));
        
      end;
      delitemGld(vDsLstLoteInfGeral, 1);
    until (vDsLstLoteInfGeral = '');
  end;
  {
  Result := '';
  vDsLstNF := '';
  if not (fFIS_NF.IsEmpty()) then begin
    fFIS_NF.First();
    while not t.EOF do begin
      vDsRegistro := '';
      vDsRegistro.CD_EMPRESA := fFIS_NF.CD_EMPRESA;
      vDsRegistro.NR_FATURA := fFIS_NF.NR_FATURA;
      vDsRegistro.DT_FATURA := fFIS_NF.DT_FATURA;
      putitem(vDsLstNF,  vDsRegistro);

      viParams := vDsRegistro;
      viParams.CD_MODULO := 'FIS';
      voParams := cCTBSVCO016.Instance.geraContabilizaEmi(viParams);
      if (itemXmlF('status', voParams) < 0) then begin
        raise Exception.Create(itemXml('message', voParams));
        
      end;

      fFIS_NF.Next();
    end;
  end;
  Result.DS_LSTNF := vDsLstNF;
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
  vDsLstNF := pParams.DS_LSTNF;
  vCdModeloNF := pParams.CD_MODELONF;
  vInECF := pParams.IN_ECF;
  vDtSistema := PARAM_GLB.DT_SISTEMA;

  fGER_MODNFC.Limpar();

  if (vCdModeloNF = 0) then begin
    if (vInECF <> True) then begin
      raise Exception.Create('Modelo de NF não informado!' + ' / ' := cDS_METHOD);
      
    end;
  end else begin
    fGER_MODNFC.CD_MODELONF := vCdModeloNF;
    fGER_MODNFC.Listar();
    if (itemXmlF('status', voParams) < 0) then begin
      raise Exception.Create('Modelo de NF ' + FloatToStr(vCdModeloNF) + ' não cadastrado!' + ' / ' := cDS_METHOD);
      
    end;
  end;

  viParams := '';
  viParams.DS_LSTNF := vDsLstNF;
  voParams := cSICSVCO005.Instance.reservaNumeroNF(viParams); 
  if (itemXmlF('status', voParams) < 0) then begin
    raise Exception.Create(itemXml('message', voParams));
    
  end;
  vDsLstNF := voParams.DS_LSTNF;
  vDsLstNrNF := voParams.DS_LSTNF;

  if (vDsLstNF = '') then begin
    raise Exception.Create('Lista de NF não informada!' + ' / ' := cDS_METHOD);
    
  end;

  fFIS_NF.Limpar();

  repeat
    getitem(vDsRegistro, vDsLstNF, 1);
    vCdEmpresa := vDsRegistro.CD_EMPRESA;
    vNrFatura := vDsRegistro.NR_FATURA;
    vDtFatura := vDsRegistro.DT_FATURA;

    if (vCdEmpresa = 0) then begin
      raise Exception.Create('Empresa não informada!' + ' / ' := cDS_METHOD);
      
    end;
    if (vNrFatura = 0) then begin
      raise Exception.Create('Fatura não informado!' + ' / ' := cDS_METHOD);
      
    end;
    if (vDtFatura = 0) then begin
      raise Exception.Create('Data NF não informada!' + ' / ' := cDS_METHOD);
      
    end;

    fFIS_NF.Append();
    fFIS_NF.CD_EMPRESA := vCdEmpresa;
    fFIS_NF.NR_FATURA := vNrFatura;
    fFIS_NF.DT_FATURA := vDtFatura;
    fFIS_NF.Consultar();
    if (xStatus = -7) then begin
      fFIS_NF.Consultar();
    end else begin
      raise Exception.Create('NF ' + FloatToStr(vCdEmpresa) + ' / ' + FloatToStr(vNrFatura) + ' não cadastrada!' + ' / ' := cDS_METHOD);
      
    end;
    vModDctoFiscal := fFIS_NF.TP_MODDCTOFISCAL;
    fGER_OPERACAO.Limpar();
    fGER_OPERACAO.CD_OPERACAO := fFIS_NF.CD_OPERACAO;
    fGER_OPERACAO.Listar();
    if (itemXmlF('status', voParams) < 0) then begin
      raise Exception.Create('Operaçao ' + fGER_OPERACAO.CD_OPERACAO + ' não cadastrada!' + ' / ' := cDS_METHOD);
      
    end;
    if (fFIS_NF.TP_SITUACAO = 'N') then begin
      if (fGER_OPERACAO.TP_DOCTO = 0) then begin
        fFIS_NF.Remover();
      end else begin
        if (fGER_OPERACAO.TP_DOCTO = 2) or (fGER_OPERACAO.TP_DOCTO = 3) then begin
          vCdSerie := 'ECF';
        end else begin
          vCdSerie := fGER_SERIE.DS_SIGLA;
          if (vCdSerie = '') then begin
            vCdSerie := 'UN';
          end;
        end;
        if (fFIS_NF.TP_ORIGEMEMISSAO = 2) then begin
          fFIS_NF.NR_NF := fFIS_NF.NR_FATURA;
          fFIS_NF.CD_SERIE := vCdSerie;
          fFIS_NF.DT_EMISSAO := vDtSistema;
          fFIS_NF.TP_SITUACAO := 'E';
        end else begin
          viParams := '';
          viParams.CD_EMPRESA := fFIS_NF.CD_EMPRESA;
          viParams.NR_FATURA := fFIS_NF.NR_FATURA;
          viParams.DT_FATURA := fFIS_NF.DT_FATURA;
          viParams.CD_EMPFAT := fFIS_NF.CD_EMPFAT;
          viParams.CD_SERIE := vCdSerie;

          if (fFIS_NF.TP_MODDCTOFISCAL <> 85) and (fFIS_NF.TP_MODDCTOFISCAL <> 87) then begin
            viParams.TP_MODDCTOFISCALLOCAL := fFIS_NF.TP_MODDCTOFISCAL;
          end else begin
            viParams.TP_MODDCTOFISCALLOCAL := gTpModDctoFiscal;
          end;

          newInstanceComponente('GERSVCO001', 'GERSVCO001', 'TRANSACTION=TRUE');
          voParams := cGERSVCO001.Instance.buscaNrNF(viParams); 
          if (itemXmlF('status', voParams) < 0) then begin
            raise Exception.Create(itemXml('message', voParams));
            
          end;
          if (vCdSerie = 'ECF') then begin
            vNrNF := voParams.NR_NF;
            if (vNrNF = 0) then begin
              raise Exception.Create('Não foi possivel obter numeração para a NF(ECF) ' + FloatToStr(vCdEmpresa) + ' / ' + FloatToStr(vNrFatura) + '!' + ' / ' := cDS_METHOD);
              
            end;
            fFIS_NF.NR_NF := vNrNF;
            fFIS_NF.CD_SERIE := vCdSerie;
          end else begin
            fFIS_NF.Remover();
            fFIS_NF.Append();
            fFIS_NF.CD_EMPRESA := vCdEmpresa;
            fFIS_NF.NR_FATURA := vNrFatura;
            fFIS_NF.DT_FATURA := vDtFatura;
            fFIS_NF.TP_MODDCTOFISCAL := vModDctoFiscal;
            fFIS_NF.Consultar();
            if (xStatus = -7) then begin
              fFIS_NF.Consultar();
            end else begin
              raise Exception.Create('Não possível recarregar a NF ' + FloatToStr(vCdEmpresa) + ' / ' + FloatToStr(vNrFatura) + ' após a rotina de numeração!' + ' / ' := cDS_METHOD);
              
            end;
          end;
          fFIS_NF.DT_EMISSAO := vDtSistema;
          fFIS_NF.TP_SITUACAO := 'E';
          fFIS_NF.CD_MODELONF := fGER_MODNFC.CD_MODELONF;
        end;
      end;
    end else if (fFIS_NF.TP_SITUACAO = 'E') then begin
    end else begin
      fFIS_NF.Remover();
    end;

    delitemGld(vDsLstNF, 1);
  until (vDsLstNF = '');

  fFIS_NF.First();

  if (fFIS_NF.IsEmpty() <> False) then begin
    raise Exception.Create('Nenhuma NF emitida!' + ' / ' := cDS_METHOD);
    
  end;

  vNrNFTransp := 0;

  fFIS_NF.Next();
  if (fFIS_NF.RecordCount() > 1) then begin
    fFIS_NF.First();

    vNrNFTransp := fFIS_NF.NR_NF;
  end;

  vDsLstTransp := '';

  fFIS_NF.First();
  while not t.EOF do begin
    if (fFIS_NF.TP_ORIGEMEMISSAO = 1) then begin
      if (fFIS_NF.NR_NF = 0) then begin
        raise Exception.Create('Não foi possivel obter numeração para a NF ' + FloatToStr(vCdEmpresa) + ' / ' + FloatToStr(vNrFatura) + '!' + ' / ' := cDS_METHOD);
        
      end;
      fFIS_S_NF.Limpar();
      fFIS_S_NF.CD_EMPFAT := fFIS_NF.CD_EMPFAT;
      fFIS_S_NF.NR_NF := fFIS_NF.NR_NF;
      fFIS_S_NF.CD_SERIE := fFIS_NF.CD_SERIE;
      fFIS_S_NF.TP_SITUACAO := '!=X';
      fFIS_S_NF.TP_ORIGEMEMISSAO := 1;
      fFIS_S_NF.TP_MODDCTOFISCAL := fFIS_NF.TP_MODDCTOFISCAL;
      fFIS_S_NF.Listar();
      if (xStatus >= 0) then begin
        if (fFIS_S_NF.NR_FATURA <> item_f('NR_FATURA', tFIS_NF)) or (fFIS_S_NF.DT_FATURA <> item_a('DT_FATURA', tFIS_NF)) then begin
          raise Exception.Create('NF ' + fFIS_NF.NR_NF + ' já cadastrada!' + ' / ' := cDS_METHOD);
          
        end;
      end;
    end;
    if (vNrNFTransp <> 0) then begin
      fGER_OPERACAO.Limpar();
      fGER_OPERACAO.CD_OPERACAO := fFIS_NF.CD_OPERACAO;
      fGER_OPERACAO.Listar();
      if (xStatus >= 0) then begin
        if (fGER_OPERACAO.TP_DOCTO <> 1) then begin
          vNrNFTransp := 0;
        end;
      end;
      if (fFIS_NF.TP_SITUACAO <> 'E') then begin
        vNrNFTransp := 0;
      end;
      if (fFIS_NF.RecNo < fFIS_NF.RecordCount()) then begin
        vRegistroNext := next(tFIS_NF);
        if (fFIS_NF.CD_EMPRESAORI <>  vRegistroNext.CD_EMPRESAORI)
        or (fFIS_NF.NR_TRANSACAOORI <>  vRegistroNext.NR_TRANSACAOORI)
        or (fFIS_NF.DT_TRANSACAOORI <>  vRegistroNext.DT_TRANSACAOORI) then begin
          vNrNFTransp := 0;
        end;
      end;
    end;
    if (vNrNFTransp <> 0) and (fFIS_NF.RecNo > 1) then begin
      vDsRegistro := '';
      vDsRegistro.CD_EMPRESA := fFIS_NF.CD_EMPRESA;
      vDsRegistro.NR_FATURA := fFIS_NF.NR_FATURA;
      vDsRegistro.DT_FATURA := fFIS_NF.DT_FATURA;
      putitem(vDsLstTransp,  vDsRegistro);
    end else if (vNrNFTransp = 0) then begin
      vDsLstTransp := '';
    end;

    fFIS_NF.Next();
  end;
  fFIS_NF.First();

  voParams := tFIS_NF.Salvar();
  if (itemXmlF('status', voParams) < 0) then begin
    raise Exception.Create(itemXml('message', voParams));
    
  end;
  if (vDsLstTransp <> '') then begin
    viParams := '';
    viParams.DS_LSTNF := vDsLstTransp;
    viParams.DS_OBSERVACAO := 'DADOS DA TRANSPORTADORA SE ENCONTRAM NA N.F. ' + FloatToStr(vNrNFTransp);
    newInstanceComponente('FISSVCO004', 'FISSVCO004O', 'TRANSACTION=FALSE');
    voParams := cFISSVCO004O.Instance.gravaObsNF(viParams);
    if (itemXmlF('status', voParams) < 0) then begin
      raise Exception.Create(itemXml('message', voParams));
      
    end;
  end;

  viParams := '';
  viParams.DS_LSTNF := vDsLstNrNF;
  voParams := cSICSVCO005.Instance.liberaNumeroNF(viParams); 
  if (itemXmlF('status', voParams) < 0) then begin
    raise Exception.Create(itemXml('message', voParams));
    
  end;

  vDsLstNrNF := voParams.DS_LSTNF;

  Result := '';
  Result.DS_LSTNF := vDsLstNrNF;
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
  vCdEmpresa := pParams.CD_EMPRESA;
  vNrFatura := pParams.NR_FATURA;
  vDtFatura := pParams.DT_FATURA;
  vCdEmpECF := pParams.CD_EMPECF;
  vNrECF := pParams.NR_ECF;
  vNrCupom := pParams.NR_CUPOM;

  if (vCdEmpresa = 0) then begin
    raise Exception.Create('Empresa não informada!' + ' / ' := cDS_METHOD);
    
  end;
  if (vNrFatura = 0) then begin
    raise Exception.Create('Fatura não informado!' + ' / ' := cDS_METHOD);
    
  end;
  if (vDtFatura = 0) then begin
    raise Exception.Create('Data NF não informada!' + ' / ' := cDS_METHOD);
    
  end;
  if (vCdEmpECF = 0) then begin
    raise Exception.Create('Empresa da ECF não informada!' + ' / ' := cDS_METHOD);
    
  end;
  if (vNrECF = 0) then begin
    raise Exception.Create('Número da ECF não informada!' + ' / ' := cDS_METHOD);
    
  end;
  if (vNrCupom = 0) then begin
    raise Exception.Create('Número do cupom não informado!' + ' / ' := cDS_METHOD);
    
  end;

  fFIS_ECF.Limpar();
  fFIS_ECF.CD_EMPRESA := vCdEmpresa;
  fFIS_ECF.NR_ECF := vNrECF;
  fFIS_ECF.Listar();
  if (itemXmlF('status', voParams) < 0) then begin
    raise Exception.Create('Número da ECF ' + FloatToStr(vNrECF) + ' não cadastrado!' + ' / ' := cDS_METHOD);
    
  end;

  fFIS_NF.Limpar();
  fFIS_NF.CD_EMPRESA := vCdEmpresa;
  fFIS_NF.NR_FATURA := vNrFatura;
  fFIS_NF.DT_FATURA := vDtFatura;
  fFIS_NF.Consultar();
  if (xStatus = -7) then begin
    fFIS_NF.Consultar();
  end else if (xStatus = 0) then begin
    raise Exception.Create('NF ' + FloatToStr(vNrFatura) + ' não cadastrada!' + ' / ' := cDS_METHOD);
    
  end;

  fFIS_NFECF.Limpar();
  fFIS_NFECF.Listar();
  if (xStatus >= 0) then begin
    voParams := tFIS_NFECF.Excluir();
    if (itemXmlF('status', voParams) < 0) then begin
      raise Exception.Create(itemXml('message', voParams));
      
    end;
  end else begin
    fFIS_NFECF.Limpar();
  end;

  fFIS_NFECF.CD_EMPECF := vCdEmpECF;
  fFIS_NFECF.NR_ECF := vNrECF;
  fFIS_NFECF.CD_SERIEFAB := fFIS_ECF.CD_SERIEFAB;
  fFIS_NFECF.CD_EMPFAT := fFIS_NF.CD_EMPFAT;
  fFIS_NFECF.CD_GRUPOEMPRESA := fFIS_NF.CD_GRUPOEMPRESA;
  fFIS_NFECF.TP_SITUACAO := 'N';
  fFIS_NFECF.NR_CUPOM := vNrCupom;
  fFIS_NFECF.CD_OPERADOR := PARAM_GLB.CD_USUARIO;
  fFIS_NFECF.DT_CADASTRO := Now;

  voParams := tFIS_NFECF.Salvar();
  if (itemXmlF('status', voParams) < 0) then begin
    raise Exception.Create(itemXml('message', voParams));
    
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
  vDsLstNF := pParams.DS_LSTNF;
  vTpSituacao := pParams.TP_SITUACAO;

  vInValidaTransacao := pParams.IN_VALIDATRANSACAO;
  if (pParams.IN_VALIDATRANSACAO = '') then begin
    vInValidaTransacao := True;
  end;
  if (vDsLstNF = '') then begin
    raise Exception.Create('Lista de NF não informada!' + ' / ' := cDS_METHOD);
    
  end;
  if (vTpSituacao = '') then begin
    raise Exception.Create('Situação não informada!' + ' / ' := cDS_METHOD);
    
  end;
  if (vTpSituacao <> 'N') and (vTpSituacao <> 'E') and (vTpSituacao <> 'C') and (vTpSituacao <> 'X') and (vTpSituacao <> 'D') then begin
    raise Exception.Create('Situação ' + vTpSituacao + ' inválida!' + ' / ' := cDS_METHOD);
    
  end;

  fFIS_NF.Limpar();
  repeat
    getitem(vDsRegistro, vDsLstNF, 1);
    vCdEmpresa := vDsRegistro.CD_EMPRESA;
    vNrFatura := vDsRegistro.NR_FATURA;
    vDtFatura := vDsRegistro.DT_FATURA;

    if (vCdEmpresa = 0) then begin
      raise Exception.Create('Empresa não informada!' + ' / ' := cDS_METHOD);
      
    end;
    if (vNrFatura = 0) then begin
      raise Exception.Create('Fatura não informado!' + ' / ' := cDS_METHOD);
      
    end;
    if (vDtFatura = 0) then begin
      raise Exception.Create('Data NF não informada!' + ' / ' := cDS_METHOD);
      
    end;

    fFIS_NF.Append();
    fFIS_NF.CD_EMPRESA := vCdEmpresa;
    fFIS_NF.NR_FATURA := vNrFatura;
    fFIS_NF.DT_FATURA := vDtFatura;
    fFIS_NF.Consultar();
    if (xStatus = -7) then begin
      fFIS_NF.Consultar();

      if ((vTpSituacao = 'C') or (vTpSituacao = 'X')) and (vInValidaTransacao) then begin
        fTRA_TRANSACAO.Limpar();
        fTRA_TRANSACAO.CD_EMPRESA := fFIS_NF.CD_EMPRESAORI;
        fTRA_TRANSACAO.NR_TRANSACAO := fFIS_NF.NR_TRANSACAOORI;
        fTRA_TRANSACAO.DT_TRANSACAO := fFIS_NF.DT_TRANSACAOORI;
        fTRA_TRANSACAO.Listar();
        if (xStatus >= 0) then begin
          if (fTRA_TRANSACAO.TP_SITUACAO <> 6) then begin
            raise Exception.Create('Transação ' + fTRA_TRANSACAO.NR_TRANSACAOORI + ' não está cancelada!' + ' / ' := cDS_METHOD);
            
          end;
        end;
      end;

      fGER_OPERACAO.Limpar();
      fGER_OPERACAO.CD_OPERACAO := fFIS_NF.CD_OPERACAO;
      fGER_OPERACAO.Listar();
      if (itemXmlF('status', voParams) < 0) then begin
        raise Exception.Create('Operaçao ' + fFIS_NF.CD_OPERACAO + ' não cadastrada!' + ' / ' := cDS_METHOD);
        
      end;
      if (gDtEncerramento <> 0) and (fGER_OPERACAO.TP_DOCTO <> 0) then begin
        if (fFIS_NF.DT_SAIDAENTRADA <= gDtEncerramento) then begin
          raise Exception.Create('NF/Fatura ' + fFIS_NF.NR_NF + '/' + item_a('NR_FATURA' + ' / ' := tFIS_NF) + ' possuir data de movimento anterior ao encerramento do livro fiscal!', cDS_METHOD);
          
        end;
      end;
    end else if (xStatus = 0) then begin
      raise Exception.Create('NF ' + FloatToStr(vNrFatura) + ' não cadastrada!' + ' / ' := cDS_METHOD);
      
    end;

    fFIS_NF.TP_SITUACAO := vTpSituacao;
    fFIS_NF.CD_OPERADOR := PARAM_GLB.CD_USUARIO;
    fFIS_NF.DT_CADASTRO := Now;

    delitemGld(vDsLstNF, 1);
  until (vDsLstNF = '');

  voParams := tFIS_NF.Salvar();
  if (itemXmlF('status', voParams) < 0) then begin
    raise Exception.Create(itemXml('message', voParams));
    
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
  vDsLstNF := pParams.DS_LSTNF;
  vCdModeloNF := pParams.CD_MODELONF;

  if (vDsLstNF = '') then begin
    raise Exception.Create('Lista de NF não informada!' + ' / ' := cDS_METHOD);
    
  end;
  if (vCdModeloNF = 0) then begin
    raise Exception.Create('Modelo de NF não informado!' + ' / ' := cDS_METHOD);
    
  end;

  fGER_MODNFC.Limpar();
  fGER_MODNFC.CD_MODELONF := vCdModeloNF;
  fGER_MODNFC.Listar();
  if (itemXmlF('status', voParams) < 0) then begin
    raise Exception.Create('Modelo de NF ' + FloatToStr(vCdModeloNF) + ' não cadastrado!' + ' / ' := cDS_METHOD);
    
  end;

  fFIS_NF.Limpar();

  repeat
    getitem(vDsRegistro, vDsLstNF, 1);
    vCdEmpresa := vDsRegistro.CD_EMPRESA;
    vNrFatura := vDsRegistro.NR_FATURA;
    vDtFatura := vDsRegistro.DT_FATURA;

    if (vCdEmpresa = 0) then begin
      raise Exception.Create('Empresa não informada!' + ' / ' := cDS_METHOD);
      
    end;
    if (vNrFatura = 0) then begin
      raise Exception.Create('Fatura não informado!' + ' / ' := cDS_METHOD);
      
    end;
    if (vDtFatura = 0) then begin
      raise Exception.Create('Data NF não informada!' + ' / ' := cDS_METHOD);
      
    end;

    fFIS_NF.Append();
    fFIS_NF.CD_EMPRESA := vCdEmpresa;
    fFIS_NF.NR_FATURA := vNrFatura;
    fFIS_NF.DT_FATURA := vDtFatura;
    fFIS_NF.Consultar();
    if (xStatus = -7) then begin
      fFIS_NF.Consultar();
    end else if (xStatus = 0) then begin
      raise Exception.Create('NF ' + FloatToStr(vNrFatura) + ' não cadastrada!' + ' / ' := cDS_METHOD);
      
    end;
    if (fFIS_NF.TP_ORIGEMEMISSAO = 1) then begin
      fFIS_S_NF.Limpar();
      fFIS_S_NF.CD_EMPFAT := fFIS_NF.CD_EMPFAT;
      fFIS_S_NF.NR_NF := fFIS_NF.NR_NF;
      fFIS_S_NF.CD_SERIE := fFIS_NF.CD_SERIE;
      fFIS_S_NF.TP_SITUACAO := '!=X';
      fFIS_S_NF.TP_ORIGEMEMISSAO := 1;
      fFIS_S_NF.TP_MODDCTOFISCAL := fFIS_NF.TP_MODDCTOFISCAL;
      fFIS_S_NF.Listar();
      if (xStatus >= 0) then begin
        if (fFIS_S_NF.NR_FATURA <> item_f('NR_FATURA', tFIS_NF)) or (fFIS_S_NF.DT_FATURA <> item_a('DT_FATURA', tFIS_NF)) then begin
          raise Exception.Create('NF ' + fFIS_NF.NR_NF + ' já cadastrada!' + ' / ' := cDS_METHOD);
          
        end;
      end;
    end;

    fFIS_NF.CD_MODELONF := vCdModeloNF;
    if (fFIS_NF.NR_IMPRESSAO = 0) then begin
      fFIS_NF.NR_IMPRESSAO := 1;
    end else begin
      fFIS_NF.NR_IMPRESSAO := fFIS_NF.NR_IMPRESSAO + 1;
    end;
    fFIS_NF.CD_USUIMPRESSAO := PARAM_GLB.CD_USUARIO;
    fFIS_NF.DT_IMPRESSAO := Now;
    fFIS_NF.CD_OPERADOR := PARAM_GLB.CD_USUARIO;
    fFIS_NF.DT_CADASTRO := Now;

    delitemGld(vDsLstNF, 1);
  until (vDsLstNF = '');

  voParams := tFIS_NF.Salvar();
  if (itemXmlF('status', voParams) < 0) then begin
    raise Exception.Create(itemXml('message', voParams));
    
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
  vCdEmpresa := pParams.CD_EMPRESA;
  vCdGrupoEmpresa := pParams.CD_GRUPOEMPRESA;
  vNrFatura := pParams.NR_FATURA;
  vDtFatura := pParams.DT_FATURA;
  vInInclusao := pParams.IN_INCLUSAO;
  vTpModDctoFiscal := pParams.TP_MODDCTOFISCAL;

  if (vCdEmpresa = 0) then begin
    raise Exception.Create('Empresa não informada!' + ' / ' := cDS_METHOD);
    
  end;
  if (vInInclusao) then begin
    if (vNrFatura > 0) then begin
      raise Exception.Create('Fatura não pode ser informada p/ inclusão!' + ' / ' := cDS_METHOD);
      
    end;
  end else begin
    if (vNrFatura = 0) then begin
      raise Exception.Create('Fatura não informado!' + ' / ' := cDS_METHOD);
      
    end;
  end;
  if (vDtFatura = 0) then begin
    raise Exception.Create('Data NF não informada!' + ' / ' := cDS_METHOD);
    
  end;

  fTRA_TRANSACAO.Limpar();

  if (vInInclusao) then begin
    viParams := '';
    viParams.NM_ENTIDADE := 'FIS_NF';
    voParams := cGERSVCO031.Instance.getNumSeq(viParams); 
    if (itemXmlF('status', voParams) < 0) then begin
      raise Exception.Create(itemXml('message', voParams));
      
    end;
    vNrFatura := voParams.NR_SEQUENCIA;

    fFIS_NF.Limpar();
    fFIS_NF.Append();
    fFIS_NF.CD_EMPRESA := vCdEmpresa;
    fFIS_NF.NR_FATURA := vNrFatura;
    fFIS_NF.DT_FATURA := vDtFatura;
  end else begin
    fFIS_NF.Limpar();
    fFIS_NF.CD_EMPRESA := vCdEmpresa;
    fFIS_NF.NR_FATURA := vNrFatura;
    fFIS_NF.DT_FATURA := vDtFatura;
    fFIS_NF.Listar();
    if (itemXmlF('status', voParams) < 0) then begin
      raise Exception.Create('NF ' + FloatToStr(vNrFatura) + ' não cadastrada!' + ' / ' := cDS_METHOD);
      
    end;
    if (gDtEncerramento <> 0) then begin
      if (fFIS_NF.DT_SAIDAENTRADA <= gDtEncerramento) then begin
        raise Exception.Create('NF/Fatura ' + fFIS_NF.NR_NF + '/' + item_a('NR_FATURA' + ' / ' := tFIS_NF) + ' possui data de movimento anterior ao encerramento do livro fiscal!', cDS_METHOD);
        
      end;
    end;
    if (fFIS_NF.NR_TRANSACAOORI > 0) then begin
      fTRA_TRANSACAO.Limpar();
      fTRA_TRANSACAO.CD_EMPRESA := fFIS_NF.CD_EMPRESAORI;
      fTRA_TRANSACAO.NR_TRANSACAO := fFIS_NF.NR_TRANSACAOORI;
      fTRA_TRANSACAO.DT_TRANSACAO := fFIS_NF.DT_TRANSACAOORI;
      fTRA_TRANSACAO.Listar();
      if (itemXmlF('status', voParams) < 0) then begin
        raise Exception.Create('Transação ' + fTRA_TRANSACAO.NR_TRANSACAOORI + ' não cadastrada!' + ' / ' := cDS_METHOD);
        
      end;
      vCdGrupoEmpresa := fTRA_TRANSACAO.CD_GRUPOEMPRESA;
    end;
  end;

  delitem(pParams, 'CD_EMPRESA');
  delitem(pParams, 'NR_FATURA');
  delitem(pParams, 'DT_FATURA');

  pParams := fFIS_NF.GetValues();

  if (fFIS_NF.DT_SAIDAENTRADA = '') then begin
    raise Exception.Create('Data saída/entrada não informada!' + ' / ' := cDS_METHOD);
    
  end;
  if (gDtEncerramento <> 0) then begin
    if (fFIS_NF.DT_SAIDAENTRADA <= gDtEncerramento) then begin
      raise Exception.Create('NF/Fatura ' + fFIS_NF.NR_NF + '/' + item_a('NR_FATURA' + ' / ' := tFIS_NF) + ' possui data de movimento anterior ao encerramento do livro fiscal!', cDS_METHOD);
      
    end;
  end;
  if (fFIS_NF.TP_SITUACAO = '') then begin
    raise Exception.Create('Situação não informada!' + ' / ' := cDS_METHOD);
    
  end;
  if (fFIS_NF.TP_SITUACAO = 'E') then begin
    if (fFIS_NF.DT_EMISSAO = '') then begin
      raise Exception.Create('Data emissão não informada!' + ' / ' := cDS_METHOD);
      
    end;
    if (fFIS_NF.NR_NF = 0) then begin
      raise Exception.Create('Número NF não informada!' + ' / ' := cDS_METHOD);
      
    end;
  end;
  if (fFIS_NF.HR_SAIDA = '') then begin
    raise Exception.Create('Hora de saída não informada!' + ' / ' := cDS_METHOD);
    
  end;
  if (fFIS_NF.CD_PESSOA = 0) then begin
    raise Exception.Create('Pessoa não informada!' + ' / ' := cDS_METHOD);
    
  end;
  if (fFIS_NF.CD_COMPVEND = 0) then begin
    raise Exception.Create('Comprador/vendedor não informado!' + ' / ' := cDS_METHOD);
    
  end;
  if (fFIS_NF.CD_CONDPGTO = 0) then begin
    raise Exception.Create('Condição de pagamento não informada!' + ' / ' := cDS_METHOD);
    
  end;
  if (fFIS_NF.CD_OPERACAO = 0) then begin
    raise Exception.Create('Operação não informada!' + ' / ' := cDS_METHOD);
    
  end;
  if (vCdGrupoEmpresa = 0) then begin
    raise Exception.Create('Grupo empresa não informado!' + ' / ' := cDS_METHOD);
    
  end;

  fGER_OPERACAO.Limpar();
  fGER_OPERACAO.CD_OPERACAO := fFIS_NF.CD_OPERACAO;
  fGER_OPERACAO.Listar();
  if (itemXmlF('status', voParams) < 0) then begin
    raise Exception.Create('Operaçao ' + fFIS_NF.CD_OPERACAO + ' não cadastrada!' + ' / ' := cDS_METHOD);
    
  end;
  if (vInInclusao) then begin
    fFIS_NF.CD_EMPFAT := fFIS_NF.CD_EMPRESA;
  end;

  fFIS_NF.VL_TOTALNOTA := fFIS_NF.VL_TOTALPRODUTO + item_f('VL_DESPACESSOR', tFIS_NF) + item_f('VL_FRETE', tFIS_NF) + item_f('VL_SEGURO', tFIS_NF) + item_f('VL_IPI', tFIS_NF) + item_f('VL_ICMSSUBST', tFIS_NF);
  fFIS_NF.TP_OPERACAO := fGER_OPERACAO.TP_OPERACAO;
  fFIS_NF.CD_GRUPOEMPRESA := vCdGrupoEmpresa;
  fFIS_NF.CD_OPERADOR := PARAM_GLB.CD_USUARIO;
  fFIS_NF.DT_CADASTRO := Now;

  if (vTpModDctoFiscal = 85) or (vTpModDctoFiscal = 87) then begin
    fFIS_NF.VL_TOTALNOTA := 0;
    fFIS_NF.VL_TOTALPRODUTO := 0;
    fFIS_NF.VL_DESPACESSOR := 0;
    fFIS_NF.VL_SEGURO := 0;
    fFIS_NF.VL_FRETE := 0;
    fFIS_NF.QT_FATURADO := 0;
    fFIS_NF.VL_BASEICMS := 0;
  end;

  voParams := tFIS_NF.Salvar();
  if (itemXmlF('status', voParams) < 0) then begin
    raise Exception.Create(itemXml('message', voParams));
    
  end;

  Result := '';
  Result.CD_EMPRESA := fFIS_NF.CD_EMPRESA;
  Result.NR_FATURA := fFIS_NF.NR_FATURA;
  Result.DT_FATURA := fFIS_NF.DT_FATURA;

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
  vDsLstNF := pParams.DS_LSTNF;
  if (vDsLstNF = '') then begin
    raise Exception.Create('Lista de nota não informada!' + ' / ' := cDS_METHOD);
    
  end;

  fFIS_NF.Limpar();

  repeat
    getitem(vDsRegistro, vDsLstNF, 1);
    vCdEmpresa := vDsRegistro.CD_EMPRESA;
    vNrFatura := vDsRegistro.NR_FATURA;
    vDtFatura := vDsRegistro.DT_FATURA;
    vDsLinhaObs := pParams.DS_OBSERVACAO;
    if (vDsLinhaObs = '') then begin
      raise Exception.Create('Observação não informada!' + ' / ' := cDS_METHOD);
      
    end;
    if (vDtFatura = 0) then begin
      raise Exception.Create('Data da fatura não informada!' + ' / ' := cDS_METHOD);
      
    end;
    if (vNrFatura = 0) then begin
      raise Exception.Create('Número da fatura não informada!' + ' / ' := cDS_METHOD);
      
    end;
    if (vCdEmpresa = 0) then begin
      raise Exception.Create('Empresa da transação não informada!' + ' / ' := cDS_METHOD);
      
    end;

    fFIS_NF.Append();
    fFIS_NF.CD_EMPRESA := vCdEmpresa;
    fFIS_NF.NR_FATURA := vNrFatura;
    fFIS_NF.DT_FATURA := vDtFatura;
    fFIS_NF.Consultar();
    if (xStatus = -7) then begin
      fFIS_NF.Consultar();
    end else if (xStatus <> 4) then begin
      raise Exception.Create('NF ' + FloatToStr(vNrFatura) + ' não cadastrada!' + ' / ' := cDS_METHOD);
      
    end;

    fOBS_NF.Next();
    NrLinha := fOBS_NF.NR_LINHA + 1;
    fOBS_NF.Append();
    fOBS_NF.CD_EMPFAT := fFIS_NF.CD_EMPFAT;
    fOBS_NF.CD_GRUPOEMPRESA := fFIS_NF.CD_GRUPOEMPRESA;
    fOBS_NF.NR_LINHA := NrLinha;
    fOBS_NF.DS_OBSERVACAO := copy(vDsLinhaObs,1,80);
    fOBS_NF.CD_OPERADOR := PARAM_GLB.CD_USUARIO;
    fOBS_NF.DT_CADASTRO := Now;

    delitemGld(vDsLstNF, 1);
  until (vDsLstNF = '');

  voParams := tOBS_NF.Salvar();
  if (itemXmlF('status', voParams) < 0) then begin
    raise Exception.Create(itemXml('message', voParams));
    
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
  vCdEmpresa := pParams.CD_EMPRESA;
  vNrFatura := pParams.NR_FATURA;
  vDtFatura := pParams.DT_FATURA;
  vCdProduto := pParams.CD_PRODUTO;
  vNrItem := pParams.NR_ITEM;
  if (vCdEmpresa = 0) then begin
    raise Exception.Create('Empresa não informada!' + ' / ' := cDS_METHOD);
    
  end;
  if (vNrFatura = 0) then begin
    raise Exception.Create('Fatura não informado!' + ' / ' := cDS_METHOD);
    
  end;
  if (vDtFatura = 0) then begin
    raise Exception.Create('Data NF não informada!' + ' / ' := cDS_METHOD);
    
  end;
  if (vCdProduto = 0) then begin
    raise Exception.Create('Produto não informado!' + ' / ' := cDS_METHOD);
    
  end;
  if (vNrItem = 0) then begin
    raise Exception.Create('Número do item não informado!' + ' / ' := cDS_METHOD);
    
  end;

  fFIS_NF.Limpar();
  fFIS_NF.CD_EMPRESA := vCdEmpresa;
  fFIS_NF.NR_FATURA := vNrFatura;
  fFIS_NF.DT_FATURA := vDtFatura;
  fFIS_NF.Listar();
  if (itemXmlF('status', voParams) < 0) then begin
    raise Exception.Create('Nota Fiscal não encotrada!' + ' / ' := cDS_METHOD);
    
  end;
  if (gDtEncerramento <> 0) then begin
    if (fFIS_NF.DT_SAIDAENTRADA <= gDtEncerramento) then begin
      raise Exception.Create('NF/Fatura ' + fFIS_NF.NR_NF + '/' + item_a('NR_FATURA' + ' / ' := tFIS_NF) + ' possui data de movimento anterior ao encerramento do livro fiscal!', cDS_METHOD);
      
    end;
  end;

  fFIS_NFITEM.Limpar();
  fFIS_NFITEM.NR_ITEM := vNrItem;
  fFIS_NFITEM.Listar();
  if (itemXmlF('status', voParams) < 0) then begin
    raise Exception.Create('Itens da Nota Fiscal não encotrada!' + ' / ' := cDS_METHOD);
    
  end;

  fFIS_NFITEMPROD.Limpar();
  fFIS_NFITEMPROD.CD_PRODUTO := vCdProduto;
  fFIS_NFITEMPROD.Listar();
  if (itemXmlF('status', voParams) < 0) then begin
    raise Exception.Create('Produto ' + FloatToStr(vCdProduto) + ' não encotrado!' + ' / ' := cDS_METHOD);
    
  end;

  delitem(pParams, 'CD_EMPRESA');
  delitem(pParams, 'NR_FATURA');
  delitem(pParams, 'DT_FATURA');
  delitem(pParams, 'NR_ITEM');
  delitem(pParams, 'CD_PRODUTO');

  pParams := fFIS_NFITEMPROD.GetValues();

  voParams := tFIS_NFITEMPROD.Salvar();
  if (itemXmlF('status', voParams) < 0) then begin
    raise Exception.Create(itemXml('message', voParams));
    
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
  vCdEmpresa := pParams.CD_EMPRESA;
  vNrFatura := pParams.NR_FATURA;
  vDtFatura := pParams.DT_FATURA;
  vCdProduto := pParams.CD_PRODUTO;
  vNrItem := pParams.NR_ITEM;
  vInInclusao := pParams.IN_INCLUSAO;
  vTpModDctoFiscal := pParams.TP_MODDCTOFISCAL;

  if (vCdEmpresa = 0) then begin
    raise Exception.Create('Empresa não informada!' + ' / ' := cDS_METHOD);
    
  end;
  if (vNrFatura = 0) then begin
    raise Exception.Create('Fatura não informado!' + ' / ' := cDS_METHOD);
    
  end;
  if (vDtFatura = 0) then begin
    raise Exception.Create('Data NF não informada!' + ' / ' := cDS_METHOD);
    
  end;
  if (vCdProduto = 0) then begin
    raise Exception.Create('Produto não informado!' + ' / ' := cDS_METHOD);
    
  end;
  if (vNrItem = 0) then begin
    raise Exception.Create('Número do item não informado!' + ' / ' := cDS_METHOD);
    
  end;

  fFIS_NF.Limpar();
  fFIS_NF.CD_EMPRESA := vCdEmpresa;
  fFIS_NF.NR_FATURA := vNrFatura;
  fFIS_NF.DT_FATURA := vDtFatura;
  fFIS_NF.Listar();
  if (itemXmlF('status', voParams) < 0) then begin
    raise Exception.Create('Nota Fiscal não encotrada!' + ' / ' := cDS_METHOD);
    
  end;
  if (gDtEncerramento <> 0) then begin
    if (fFIS_NF.DT_SAIDAENTRADA <= gDtEncerramento) then begin
      raise Exception.Create('NF/Fatura ' + fFIS_NF.NR_NF + '/' + item_a('NR_FATURA' + ' / ' := tFIS_NF) + ' possui data de movimento anterior ao encerramento do livro fiscal!', cDS_METHOD);
      
    end;
  end;
  if (vInInclusao) then begin
  end else begin
    fFIS_NFITEM.Limpar();
    fFIS_NFITEM.NR_ITEM := vNrItem;
    fFIS_NFITEM.Listar();
    if (itemXmlF('status', voParams) < 0) then begin
      raise Exception.Create('Itens da Nota Fiscal não encotrada!' + ' / ' := cDS_METHOD);
      
    end;

    delitem(pParams, 'CD_EMPRESA');
    delitem(pParams, 'NR_FATURA');
    delitem(pParams, 'DT_FATURA');
    delitem(pParams, 'NR_ITEM');
  end;

  pParams := fFIS_NFITEM.GetValues();

  fFIS_NFITEM.CD_EMPFAT := fFIS_NF.CD_EMPFAT;
  fFIS_NFITEM.CD_GRUPOEMPRESA := fFIS_NF.CD_GRUPOEMPRESA;
  fFIS_NFITEM.CD_OPERADOR := PARAM_GLB.CD_USUARIO;
  fFIS_NFITEM.DT_CADASTRO := Now;

  if (vTpModDctoFiscal = 85) or (vTpModDctoFiscal = 87) then begin
    fFIS_NFITEM.VL_TOTALLIQUIDO := 0;
    fFIS_NFITEM.VL_TOTALBRUTO := 0;
    fFIS_NFITEM.VL_UNITLIQUIDO := 0;
    fFIS_NFITEM.VL_UNITBRUTO := 0;
    fFIS_NFITEM.QT_FATURADO := 0;
  end;

  voParams := tFIS_NFITEM.Salvar();
  if (itemXmlF('status', voParams) < 0) then begin
    raise Exception.Create(itemXml('message', voParams));
    
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
  vCdEmpresa := pParams.CD_EMPRESA;
  vNrFatura := pParams.NR_FATURA;
  vDtFatura := pParams.DT_FATURA;
  if (vCdEmpresa = 0) then begin
    raise Exception.Create('Empresa não informada!' + ' / ' := cDS_METHOD);
    
  end;
  if (vNrFatura = 0) then begin
    raise Exception.Create('Fatura não informado!' + ' / ' := cDS_METHOD);
    
  end;
  if (vDtFatura = 0) then begin
    raise Exception.Create('Data NF não informada!' + ' / ' := cDS_METHOD);
    
  end;

  fFIS_NF.Limpar();
  fFIS_NF.CD_EMPRESA := vCdEmpresa;
  fFIS_NF.NR_FATURA := vNrFatura;
  fFIS_NF.DT_FATURA := vDtFatura;
  fFIS_NF.Listar();
  if (itemXmlF('status', voParams) < 0) then begin
    raise Exception.Create('Nota Fiscal não encotrada!' + ' / ' := cDS_METHOD);
    
  end;
  if (gDtEncerramento <> 0) then begin
    if (fFIS_NF.DT_SAIDAENTRADA <= gDtEncerramento) then begin
      raise Exception.Create('NF/Fatura ' + fFIS_NF.NR_NF + '/' + item_a('NR_FATURA' + ' / ' := tFIS_NF) + ' possui data de movimento anterior ao encerramento do livro fiscal!', cDS_METHOD);
      
    end;
  end;

  delitem(pParams, 'CD_EMPRESA');
  delitem(pParams, 'NR_FATURA');
  delitem(pParams, 'DT_FATURA');

  pParams := fFIS_NFREMDES.GetValues();
  fFIS_NFREMDES.CD_EMPFAT := fFIS_NF.CD_EMPFAT;
  fFIS_NFREMDES.CD_GRUPOEMPRESA := fFIS_NF.CD_GRUPOEMPRESA;
  if (fFIS_NFREMDES.NM_NOME = '') then begin
    raise Exception.Create('Nome da pessoa não informado!' + ' / ' := cDS_METHOD);
    
  end;

  voParams := tFIS_NFREMDES.Salvar();
  if (itemXmlF('status', voParams) < 0) then begin
    raise Exception.Create(itemXml('message', voParams));
    
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
  vCdEmpresa := pParams.CD_EMPRESA;
  vNrFatura := pParams.NR_FATURA;
  vDtFatura := pParams.DT_FATURA;

  if (vCdEmpresa = 0) then begin
    raise Exception.Create('Empresa não informada!' + ' / ' := cDS_METHOD);
    
  end;
  if (vNrFatura = 0) then begin
    raise Exception.Create('Fatura não informado!' + ' / ' := cDS_METHOD);
    
  end;
  if (vDtFatura = 0) then begin
    raise Exception.Create('Data NF não informada!' + ' / ' := cDS_METHOD);
    
  end;

  fFIS_NF.Limpar();
  fFIS_NF.CD_EMPRESA := vCdEmpresa;
  fFIS_NF.NR_FATURA := vNrFatura;
  fFIS_NF.DT_FATURA := vDtFatura;
  fFIS_NF.Listar();
  if (itemXmlF('status', voParams) < 0) then begin
    raise Exception.Create('Nota Fiscal não encotrada!' + ' / ' := cDS_METHOD);
    
  end;
  if (gDtEncerramento <> 0) then begin
    if (fFIS_NF.DT_SAIDAENTRADA <= gDtEncerramento) then begin
      raise Exception.Create('NF/Fatura ' + fFIS_NF.NR_NF + '/' + item_a('NR_FATURA' + ' / ' := tFIS_NF) + ' possui data de movimento anterior ao encerramento do livro fiscal!', cDS_METHOD);
      
    end;
  end;

  delitem(pParams, 'CD_EMPRESA');
  delitem(pParams, 'NR_FATURA');
  delitem(pParams, 'DT_FATURA');

  pParams := fFIS_NFTRANSP.GetValues();
  fFIS_NFTRANSP.CD_EMPFAT := fFIS_NF.CD_EMPFAT;
  fFIS_NFTRANSP.CD_GRUPOEMPRESA := fFIS_NF.CD_GRUPOEMPRESA;

  if (fFIS_NFTRANSP.CD_TRANSPORT = 0) then begin
    raise Exception.Create('Transportadora não informada!' + ' / ' := cDS_METHOD);
    
  end;
  if (fFIS_NFTRANSP.TP_FRETE = '') then begin
    raise Exception.Create('Tipo de frete não informado!' + ' / ' := cDS_METHOD);
    
  end;

  voParams := tFIS_NFTRANSP.Salvar();
  if (itemXmlF('status', voParams) < 0) then begin
    raise Exception.Create(itemXml('message', voParams));
    
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
  vDsLstImposto := pParams.DS_LSTIMPOSTO;
  vCdEmpresa := pParams.CD_EMPRESA;
  vNrFatura := pParams.NR_FATURA;
  vDtFatura := pParams.DT_FATURA;
  vCdImposto := pParams.CD_IMPOSTO;
  vNrItem := pParams.NR_ITEM;
  vInNaoExcluir := pParams.IN_NAOEXCLUIR;

  if (vCdEmpresa = 0) then begin
    raise Exception.Create('Empresa não informada!' + ' / ' := cDS_METHOD);
    
  end;
  if (vNrFatura = 0) then begin
    raise Exception.Create('Fatura não informado!' + ' / ' := cDS_METHOD);
    
  end;
  if (vDtFatura = 0) then begin
    raise Exception.Create('Data NF não informada!' + ' / ' := cDS_METHOD);
    
  end;
  if (vNrItem = 0) then begin
    raise Exception.Create('Número do item não informado!' + ' / ' := cDS_METHOD);
    
  end;

  fFIS_NF.Limpar();
  fFIS_NF.CD_EMPRESA := vCdEmpresa;
  fFIS_NF.NR_FATURA := vNrFatura;
  fFIS_NF.DT_FATURA := vDtFatura;
  fFIS_NF.Listar();
  if (itemXmlF('status', voParams) < 0) then begin
    raise Exception.Create('Nota Fiscal não encotrada!' + ' / ' := cDS_METHOD);
    
  end;
  if (gDtEncerramento <> 0) then begin
    if (fFIS_NF.DT_SAIDAENTRADA <= gDtEncerramento) then begin
      raise Exception.Create('NF/Fatura ' + fFIS_NF.NR_NF + '/' + item_a('NR_FATURA' + ' / ' := tFIS_NF) + ' possui data de movimento anterior ao encerramento do livro fiscal!', cDS_METHOD);
      
    end;
  end;

  fFIS_NFITEM.Limpar();
  fFIS_NFITEM.NR_ITEM := vNrItem;
  fFIS_NFITEM.Listar();
  if (itemXmlF('status', voParams) < 0) then begin
    raise Exception.Create('Itens da Nota Fiscal não encotrada!' + ' / ' := cDS_METHOD);
    
  end;
  if not (fFIS_NFITEMIMPOST.IsEmpty()) then begin
    if (vInNaoExcluir) then begin
      vDsImposto := vDsLstImposto;
      if (vDsImposto <> '') then begin
        repeat
          getitem(vDsRegistro, vDsImposto, 1);
          fFIS_NFITEMIMPOST.Limpar();
          fFIS_NFITEMIMPOST.CD_IMPOSTO := vDsRegistro.CD_IMPOSTO;
          fFIS_NFITEMIMPOST.Listar();
          if (xStatus >= 0) then begin
            voParams := tFIS_NFITEMIMPOST.Excluir();
            if (itemXmlF('status', voParams) < 0) then begin
              raise Exception.Create(itemXml('message', voParams));
              
            end;
          end;

          delitemGld(vDsImposto, 1);
        until (vDsImposto = '');
      end;

    end else begin
      voParams := tFIS_NFITEMIMPOST.Excluir();
      if (itemXmlF('status', voParams) < 0) then begin
        raise Exception.Create(itemXml('message', voParams));
        
      end;
    end;
  end;
  if (vDsLstImposto <> '') then begin
    repeat
      getitem(vDsRegistro, vDsLstImposto, 1);
      vCdImposto := vDsRegistro.CD_IMPOSTO;

      if (vCdImposto = 0) then begin
        raise Exception.Create('Imposto não informado!' + ' / ' := cDS_METHOD);
        
      end;

      fFIS_NFITEMIMPOST.Append();

      vDsRegistro := fFIS_NFITEMIMPOST.GetValues();
      fFIS_NFITEMIMPOST.CD_EMPFAT := fFIS_NFITEM.CD_EMPFAT;
      fFIS_NFITEMIMPOST.CD_GRUPOEMPRESA := fFIS_NFITEM.CD_GRUPOEMPRESA;
      fFIS_NFITEMIMPOST.CD_OPERADOR := PARAM_GLB.CD_USUARIO;
      fFIS_NFITEMIMPOST.DT_CADASTRO := Now;

      delitemGld(vDsLstImposto, 1);
    until (vDsLstImposto = '');
  end;

  voParams := tFIS_NFITEMIMPOST.Salvar();
  if (itemXmlF('status', voParams) < 0) then begin
    raise Exception.Create(itemXml('message', voParams));
    
  end;

  voParams := calculaTotalNF();
  if (itemXmlF('status', voParams) < 0) then begin
    raise Exception.Create(itemXml('message', voParams));
    
  end;

  voParams := tFIS_NF.Salvar();
  if (itemXmlF('status', voParams) < 0) then begin
    raise Exception.Create(itemXml('message', voParams));
    
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
  vDsLstImposto := pParams.DS_LSTIMPOSTO;
  vCdEmpresa := pParams.CD_EMPRESA;
  vNrFatura := pParams.NR_FATURA;
  vDtFatura := pParams.DT_FATURA;

  if (vCdEmpresa = 0) then begin
    raise Exception.Create('Empresa não informada!' + ' / ' := cDS_METHOD);
    
  end;
  if (vNrFatura = 0) then begin
    raise Exception.Create('Fatura não informado!' + ' / ' := cDS_METHOD);
    
  end;
  if (vDtFatura = 0) then begin
    raise Exception.Create('Data NF não informada!' + ' / ' := cDS_METHOD);
    
  end;

  fFIS_NF.Limpar();
  fFIS_NF.CD_EMPRESA := vCdEmpresa;
  fFIS_NF.NR_FATURA := vNrFatura;
  fFIS_NF.DT_FATURA := vDtFatura;
  fFIS_NF.Listar();
  if (itemXmlF('status', voParams) < 0) then begin
    raise Exception.Create('Nota Fiscal não encotrada!' + ' / ' := cDS_METHOD);
    
  end;
  if (gDtEncerramento <> 0) then begin
    if (fFIS_NF.DT_SAIDAENTRADA <= gDtEncerramento) then begin
      raise Exception.Create('NF/Fatura ' + fFIS_NF.NR_NF + '/' + item_a('NR_FATURA' + ' / ' := tFIS_NF) + ' possui data de movimento anterior ao encerramento do livro fiscal!', cDS_METHOD);
      
    end;
  end;
  if not (fFIS_NFIMPOSTO.IsEmpty()) then begin
    voParams := tFIS_NFIMPOSTO.Excluir();
    if (itemXmlF('status', voParams) < 0) then begin
      raise Exception.Create(itemXml('message', voParams));
      
    end;
  end;
  if (vDsLstImposto <> '') then begin
    repeat
      getitem(vDsRegistro, vDsLstImposto, 1);
      vCdImposto := vDsRegistro.CD_IMPOSTO;

      if (vCdImposto = 0) then begin
        raise Exception.Create('Imposto não informado!' + ' / ' := cDS_METHOD);
        
      end;

      fFIS_NFIMPOSTO.Append();

      vDsRegistro := fFIS_NFIMPOSTO.GetValues();
      fFIS_NFIMPOSTO.CD_EMPFAT := fFIS_NFITEM.CD_EMPFAT;
      fFIS_NFIMPOSTO.CD_GRUPOEMPRESA := fFIS_NFITEM.CD_GRUPOEMPRESA;
      fFIS_NFIMPOSTO.CD_OPERADOR := PARAM_GLB.CD_USUARIO;
      fFIS_NFIMPOSTO.DT_CADASTRO := Now;

      delitemGld(vDsLstImposto, 1);
    until (vDsLstImposto = '');
  end;

  voParams := tFIS_NFIMPOSTO.Salvar();
  if (itemXmlF('status', voParams) < 0) then begin
    raise Exception.Create(itemXml('message', voParams));
    
  end;

	voParams := calculaTotalNF();
  if (itemXmlF('status', voParams) < 0) then begin
    raise Exception.Create(itemXml('message', voParams));
    
  end;

  voParams := tFIS_NF.Salvar();
  if (itemXmlF('status', voParams) < 0) then begin
    raise Exception.Create(itemXml('message', voParams));
    
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
  vDsLstNF := pParams.DS_LSTNF;
  vCdEmpTransacao := pParams.CD_EMPTRANSACAO;
  vNrTransacao := pParams.NR_TRANSACAO;
  vDtTransacao := pParams.DT_TRANSACAO;

  vCdVendedor := pParams.CD_COMPVEND;

  if (vDsLstNF = '') then begin
    if (vCdEmpTransacao = 0) then begin
      raise Exception.Create('Empresa não informada!' + ' / ' := cDS_METHOD);
      
    end;
    if (vNrTransacao = 0) then begin
      raise Exception.Create('Número da transação não informado!' + ' / ' := cDS_METHOD);
      
    end;
    if (vDtTransacao = 0) then begin
      raise Exception.Create('Data transação não informada!' + ' / ' := cDS_METHOD);
      
    end;
  end;
  if (vCdVendedor = 0) then begin
    raise Exception.Create('Vendedor não informado!' + ' / ' := cDS_METHOD);
    
  end;

  fFIS_NF.Limpar();

  if (vDsLstNF = '') then begin
    fFIS_NF.CD_EMPRESAORI := vCdEmpTransacao;
    fFIS_NF.NR_TRANSACAOORI := vNrTransacao;
    fFIS_NF.DT_TRANSACAOORI := vDtTransacao;
    fFIS_NF.Listar();
    if (itemXmlF('status', voParams) < 0) then begin
      fFIS_NF.Limpar();
      return(0); exit;
    end;
  end else begin
    repeat
      getitem(vDsRegistro, vDsLstNF, 1);
      vCdEmpresa := vDsRegistro.CD_EMPRESA;
      vNrFatura := vDsRegistro.NR_FATURA;
      vDtFatura := vDsRegistro.DT_FATURA;
      if (vCdEmpresa = 0) then begin
        raise Exception.Create('Empresa não informada!' + ' / ' := cDS_METHOD);
        
      end;
      if (vNrFatura = 0) then begin
        raise Exception.Create('Fatura não informado!' + ' / ' := cDS_METHOD);
        
      end;
      if (vDtFatura = 0) then begin
        raise Exception.Create('Data NF não informada!' + ' / ' := cDS_METHOD);
        
      end;
      fFIS_NF.Append();
      fFIS_NF.CD_EMPRESA := vCdEmpresa;
      fFIS_NF.NR_FATURA := vNrFatura;
      fFIS_NF.DT_FATURA := vDtFatura;
      fFIS_NF.Consultar();
      if (xStatus = -7) then begin
        fFIS_NF.Consultar();
      end else if (xStatus = 0) then begin
        raise Exception.Create('NF ' + FloatToStr(vNrFatura) + ' não cadastrada!' + ' / ' := cDS_METHOD);
        
      end;

      delitemGld(vDsLstNF, 1);
    until (vDsLstNF = '');
  end;
  if not (fFIS_NF.IsEmpty()) then begin
    fFIS_NF.First();
    while(xStatus >=0) do begin
      fFIS_NF.CD_COMPVEND := vCdVendedor;
      fFIS_NF.CD_OPERADOR := PARAM_GLB.CD_USUARIO;
      fFIS_NF.DT_CADASTRO := Now;

      if not (fFIS_NFITEM.IsEmpty()) then begin
        fFIS_NFITEM.First();
        while(xStatus >=0) do begin
          if not (fFIS_NFITEMPROD.IsEmpty()) then begin
            fFIS_NFITEMPROD.First();
            while(xStatus >=0) do begin
              fFIS_NFITEMPROD.CD_COMPVEND := vCdVendedor;
              fFIS_NFITEMPROD.CD_OPERADOR := PARAM_GLB.CD_USUARIO;
              fFIS_NFITEMPROD.DT_CADASTRO := Now;
              fFIS_NFITEMPROD.Next();
            end;
          end;
          fFIS_NFITEM.Next();
        end;
      end;

      fFIS_NF.Next();
    end;

    voParams := tFIS_NF.Salvar();
    if (itemXmlF('status', voParams) < 0) then begin
      raise Exception.Create(itemXml('message', voParams));
      
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
  vDsLstItem := pParams.DS_CONSIGNADO;
  vTpConsignado := pParams.TP_CONSIGNADO;

  if (vDsLstItem = '') then begin
    raise Exception.Create('Lista de item consignado não informado!' + ' / ' := cDS_METHOD);
    
  end;
  if (vTpConsignado = '') then begin
    raise Exception.Create('Lista de item consignado não informado!' + ' / ' := cDS_METHOD);
    
  end;

  repeat
    getitem(vDsItem, vDsLstItem, 1);
    vCdEmpresa := vDsItem.CD_EMPRESA;
    vNrFatura := vDsItem.NR_FATURA;
    vDtFatura := vDsItem.DT_FATURA;
    vNrItem := vDsItem.NR_ITEM;
    vCdProduto := vDsItem.CD_PRODUTO;

    fFIS_NF.Limpar();
    fFIS_NF.CD_EMPRESA := vCdEmpresa;
    fFIS_NF.NR_FATURA := vNrFatura;
    fFIS_NF.DT_FATURA := vDtFatura;
    fFIS_NF.Listar();
    if (xStatus >= 0) then begin
      fFIS_NFITEM.Limpar();
      fFIS_NFITEM.NR_ITEM := vNrItem;
      fFIS_NFITEM.Listar();
      if (xStatus >= 0) then begin
        fFIS_NFITEMPROD.Limpar();
        fFIS_NFITEMPROD.CD_PRODUTO := vCdProduto;
        fFIS_NFITEMPROD.Listar();
        if (xStatus >= 0) then begin
          vQtSaldo := fFIS_NFITEMPROD.QT_FATURADO;

          if not (fFIS_NFITEMCONT.IsEmpty()) then begin
            if (vTpConsignado = 'DEVOLVER') then begin
              vQtConsignado := vDsItem.QT_DEVOLVIDA;
              fFIS_NFITEMCONT.QT_DEVOLVIDA := fFIS_NFITEMCONT.QT_DEVOLVIDA + vQtConsignado;
            end;
            if (vTpConsignado = 'FATURAR') then begin
              vQtConsignado := vDsItem.QT_VendIDA;
              fFIS_NFITEMCONT.QT_VENDIDA := fFIS_NFITEMCONT.QT_VENDIDA + vQtConsignado;
            end;

            vQtSaldo := vQtSaldo - fFIS_NFITEMCONT.QT_DEVOLVIDA - item_f('QT_VENDIDA', tFIS_NFITEMCONT);

            if (vQtSaldo <= 0) then begin
              fFIS_NFITEMCONT.TP_SITUACAO := 2;
            end;

            voParams := tFIS_NFITEMCONT.Salvar();
            if (itemXmlF('status', voParams) < 0) then begin
              raise Exception.Create(itemXml('message', voParams));
              
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
  voParams := cFISSVCO024.Instance.gravaLogNF(viParams); 
  if (itemXmlF('status', voParams) < 0) then begin
    raise Exception.Create(itemXml('message', voParams));
    
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
  vDsLstItem := pParams.DS_CONSIGNADO;
  vTpConsignado := pParams.TP_CONSIGNADO;

  if (vDsLstItem = '') then begin
    raise Exception.Create('Lista de item consignado não informado!' + ' / ' := cDS_METHOD);
    
  end;
  if (vTpConsignado = '') then begin
    raise Exception.Create('Lista de item consignado não informado!' + ' / ' := cDS_METHOD);
    
  end;

  repeat
    getitem(vDsItem, vDsLstItem, 1);
    vCdEmpresa := vDsItem.CD_EMPRESA;
    vNrFatura := vDsItem.NR_FATURA;
    vDtFatura := vDsItem.DT_FATURA;
    vNrItem := vDsItem.NR_ITEM;
    vCdProduto := vDsItem.CD_PRODUTO;

    fFIS_NF.Limpar();
    fFIS_NF.CD_EMPRESA := vCdEmpresa;
    fFIS_NF.NR_FATURA := vNrFatura;
    fFIS_NF.DT_FATURA := vDtFatura;
    fFIS_NF.Listar();
    if (xStatus >= 0) then begin
      fFIS_NFITEM.Limpar();
      fFIS_NFITEM.NR_ITEM := vNrItem;
      fFIS_NFITEM.Listar();
      if (xStatus >= 0) then begin
        fFIS_NFITEMPROD.Limpar();
        fFIS_NFITEMPROD.CD_PRODUTO := vCdProduto;
        fFIS_NFITEMPROD.Listar();
        if (xStatus >= 0) then begin
          vQtSaldo := fFIS_NFITEMPROD.QT_FATURADO;

          if not (fFIS_NFITEMCONT.IsEmpty()) then begin
            if (vTpConsignado = 'DEVOLVER') then begin
              vQtConsignado := vDsItem.QT_DEVOLVIDA;
              fFIS_NFITEMCONT.QT_DEVOLVIDA := fFIS_NFITEMCONT.QT_DEVOLVIDA - vQtConsignado;
            end;
            if (vTpConsignado = 'FATURAR') then begin
              vQtConsignado := vDsItem.QT_VendIDA;
              fFIS_NFITEMCONT.QT_VENDIDA := fFIS_NFITEMCONT.QT_VENDIDA - vQtConsignado;
            end;

            vQtSaldo := vQtSaldo - fFIS_NFITEMCONT.QT_DEVOLVIDA - item_f('QT_VENDIDA', tFIS_NFITEMCONT);

            if (vQtSaldo > 0) then begin
              fFIS_NFITEMCONT.TP_SITUACAO := 1;
            end;

            voParams := tFIS_NFITEMCONT.Salvar();
            if (itemXmlF('status', voParams) < 0) then begin
              raise Exception.Create(itemXml('message', voParams));
              
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
  vCdEmpresa := pParams.CD_EMPRESA;
  vNrFatura := pParams.NR_FATURA;
  vDtFatura := pParams.DT_FATURA;

  if (vCdEmpresa = 0) then begin
    raise Exception.Create('Empresa não informada!' + ' / ' := cDS_METHOD);
    
  end;
  if (vNrFatura = 0) then begin
    raise Exception.Create('Número da fatura não informada!' + ' / ' := cDS_METHOD);
    
  end;
  if (vDtFatura = 0) then begin
    raise Exception.Create('Data da fatura não informada!' + ' / ' := cDS_METHOD);
    
  end;

  fFIS_NF.Limpar();
  fFIS_NF.CD_EMPRESA := vCdEmpresa;
  fFIS_NF.NR_FATURA := vNrFatura;
  fFIS_NF.DT_FATURA := vDtFatura;
  fFIS_NF.Listar();
  if (itemXmlF('status', voParams) < 0) then begin
    raise Exception.Create('Registro não cadastrado!' + ' / ' := cDS_METHOD);
    
  end;

  fFIS_NFECF.Limpar();
  fFIS_NFECF.Listar();
  if (xStatus >= 0) then begin
    voParams := tFIS_NFECF.Excluir();
    if (itemXmlF('status', voParams) < 0) then begin
      raise Exception.Create(itemXml('message', voParams));
      
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

  fFIS_NFITEM.Limpar();
  fFIS_NFITEM.Listar();
  if (xStatus >= 0) then begin
    fFIS_NFITEM.First();
    while not t.EOF do begin
      vQtFaturado := vQtFaturado + fFIS_NFITEM.QT_FATURADO;
      vVlTotalProduto := vVlTotalProduto + fFIS_NFITEM.VL_TOTALLIQUIDO;
      vVlTotalBruto := vVlTotalBruto + fFIS_NFITEM.VL_TOTALBRUTO;
      vVlDesconto := vVlDesconto + fFIS_NFITEM.VL_TOTALDESC;
      if not (fFIS_NFITEMIMPOST.IsEmpty()) then begin
        fFIS_NFITEMIMPOST.First();
        while not t.EOF do begin
          if (fFIS_NFITEMIMPOST.CD_IMPOSTO = 1) then begin
            vVlBaseICMS := vVlBaseICMS + fFIS_NFITEMIMPOST.VL_BASECALC;
            vVlICMS := vVlICMS + fFIS_NFITEMIMPOST.VL_IMPOSTO;
          end else if (fFIS_NFITEMIMPOST.CD_IMPOSTO = 2) then begin
            vVlBaseICMSSubst := vVlBaseICMSSubst + fFIS_NFITEMIMPOST.VL_BASECALC;
            vVlICMSSubst := vVlICMSSubst + fFIS_NFITEMIMPOST.VL_IMPOSTO;
          end else if (fFIS_NFITEMIMPOST.CD_IMPOSTO = 3) then begin
            vVlIPI := vVlIPI + fFIS_NFITEMIMPOST.VL_IMPOSTO;
          end;
          fFIS_NFITEMIMPOST.Next();
        end;
      end;
      fFIS_NFITEM.Next();
    end;
  end;

  vVlCalc := (vVlTotalBruto - vVlTotalProduto) / vVlTotalBruto * 100;

  fFIS_NF.PR_DESCONTO := rounded(vVlCalc, 6);
  fFIS_NF.QT_FATURADO := vQtFaturado;
  fFIS_NF.VL_TOTALPRODUTO := vVlTotalProduto;
  fFIS_NF.VL_DESCONTO := vVlDesconto;
  fFIS_NF.VL_BASEICMS := vVlBaseICMS;
  fFIS_NF.VL_ICMS := vVlICMS;
  fFIS_NF.VL_BASEICMSSUBS := vVlBaseICMSSubst;
  fFIS_NF.VL_ICMSSUBST := vVlICMSSubst;
  fFIS_NF.VL_IPI := vVlIPI;
  fFIS_NF.VL_TOTALNOTA := fFIS_NF.VL_TOTALPRODUTO + item_f('VL_DESPACESSOR', tFIS_NF) + item_f('VL_FRETE', tFIS_NF) + item_f('VL_SEGURO', tFIS_NF) + item_f('VL_IPI', tFIS_NF) + item_f('VL_ICMSSUBST', tFIS_NF);

  return(0); exit;
end;

initialization
  RegisterClass(T_FISSVCO004);

end.
