unit cTRASVCO004;

interface

(* COMPONENTES 
  ADMSVCO001 / ADMSVCO025 / FCRSVCO015 / FISSVCO004 / FISSVCO015
  GERSVCO008 / GERSVCO011 / GERSVCO012 / GERSVCO031 / GERSVCO046
  GERSVCO054 / GERSVCO058 / GERSVCO103 / PCPSVCO020 / PEDSVCO008
  PESSVCO005 / PRDSVCO004 / PRDSVCO007 / PRDSVCO008 / PRDSVCO015
  PRDSVCO020 / SICSVCO005 / TRASVCO012 / TRASVCO016 / TRASVCO024

*)        

uses
  Classes, SysUtils, DB,
  cServiceUnf, cDataSetUnf;

type
  T_TRASVCO004 = class(TcServiceUnf)
  private
    tBAL_BALANCOTR,
    tF_TRA_ITEMIMP,
    tFIS_REGRAIMPO,
    tGER_EMPRESA,
    tGER_OPERACAO,
    tGER_OPERSALDO,
    tGER_S_OPERACA,
    tOBS_TRANSACAO,
    tPED_PEDIDOTRA,
    tPES_CLIENTE,
    tPES_PESFISICA,
    tPES_PESJURIDI,
    tPES_PESSOA,
    tPES_TELEFONE,
    tPRD_LOTEI,
    tTMP_NR09,
    tTRA_ITEMIMPOS,
    tTRA_ITEMLOTE,
    tTRA_ITEMVL,
    tTRA_REMDES,
    tTRA_TRAIMPOST,
    tTRA_TRANSACAO,
    tTRA_TRANSACSI,
    tTRA_TRANSITEM,
    tTRA_TRANSPORT,
    tV_BAL_BALANCO,
    tV_PES_ENDEREC,
    tV_TRA_TOTATRA,
    tV_TRA_TOTITEM : TcDatasetUnf;
    function getParam(pParams : String = '') : String;
    function setEntidade(pParams : String = '') : String;
  protected
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;    
  published
    function calculaTotalTransacao(pParams : String = '') : String;
    function calculaTotalOtimizado(pParams : String = '') : String;
    function validaGuiaRepreCliente(pParams : String = '') : String;
    function validaProdutoBalanco(pParams : String = '') : String;
    function gravaCapaTransacao(pParams : String = '') : String;
    function validaItemTransacao(pParams : String = '') : String;
    function gravaItemTransacao(pParams : String = '') : String;
    function gravaParcelaTransacao(pParams : String = '') : String;
    function gravaTotalTransacao(pParams : String = '') : String;
    function alteraSituacaoTransacao(pParams : String = '') : String;
    function atualizaEstoqueTransacao(pParams : String = '') : String;
    function gravaImpostoItemTransacao(pParams : String = '') : String;
    function alteraVendedorTransacaoNF(pParams : String = '') : String;
    function alteraAdicional(pParams : String = '') : String;
    function alteraImpressaoTransacao(pParams : String = '') : String;
    function gravaTransportTransacao(pParams : String = '') : String;
    function gravaValorItemTransacao(pParams : String = '') : String;
    function removeItemTransacao(pParams : String = '') : String;
    function gravaenderecoTransacao(pParams : String = '') : String;
    function gravaObservacaoTransacao(pParams : String = '') : String;
  end;

implementation

uses
  cADMSVCO001,
  cActivate, cStatus, cFuncao, cXml, dModulo;

var
  gCdClientePdv,
  gCdCustoMedio,
  gCdEmpParam,
  gCdEspecieServico,
  gCdOperacaoOI,
  gCdOperKardex,
  gCdPessoaendPadrao,
  gDsCustoSubstTributaria,
  gDsCustoValorRetido,
  gDsLstValorVenda,
  gDsSepBarraPrd,
  gDtData,
  gHrFim,
  gHrInicio,
  gHrTempo,
  gInBloqSaldoNeg,
  gInGravaRepreGuiaTra,
  gInGravaTraBloq,
  gInGuiaReprAuto,
  gInSomaFrete,
  gNrDiaVencto,
  gNrItemQuebraNf,
  greplace(,
  gTpDataVenctoParcela,
  gTpModDctoFiscal,
  gTpNumeracaoTra,
  gTpTabPrecoPed,
  gTpUtilizaDtBasePgto,
  gTpValidaTransacaoPrd,
  gTpValorBrutoPromocao,
  gVlMinimoParcela : String;

//---------------------------------------------------------------
constructor T_TRASVCO004.Create(AOwner: TComponent);
//---------------------------------------------------------------
begin
  inherited Create(AOwner);
  setEntidade('');
end;

//--------------------------------
destructor T_TRASVCO004.Destroy;
//--------------------------------
begin
  inherited Destroy;
end;

//---------------------------------------------------------------
function T_TRASVCO004.getParam(pParams : String) : String;
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
  putitem(xParam, 'CLIENTE_PDV');
  putitem(xParam, 'DS_SEP_NRSEQ_BARRA_PRD');

  xParam := T_ADMSVCO001.GetParametro(xParam);

  gCdClientePdv := itemXml('CLIENTE_PDV', xParam);
  gDsSepBarraPrd := itemXml('DS_SEP_NRSEQ_BARRA_PRD', xParam);

  xParamEmp := '';
  putitem(xParamEmp, 'CD_CLIENTE_PDV_EMP');
  putitem(xParamEmp, 'CD_CUSTO_MEDIO_CMP');
  putitem(xParamEmp, 'CD_CUSTO_VALIDA_VendA');
  putitem(xParamEmp, 'CD_OPER_ESTOQ_PROD_OI');
  putitem(xParamEmp, 'CD_OPER_GRAVA_ZERO_KARDEX');
  putitem(xParamEmp, 'CD_PESSOA_endERECO_PADRAO');
  putitem(xParamEmp, 'CLIENTE_PDV');
  putitem(xParamEmp, 'DS_CUSTO_SUBST_TRIBUTARIA');
  putitem(xParamEmp, 'DS_CUSTO_VALOR_RETIDO');
  putitem(xParamEmp, 'DS_LST_VLR_VendA');
  putitem(xParamEmp, 'DS_SEP_NRSEQ_BARRA_PRD');
  putitem(xParamEmp, 'DT_SISTEMA');
  putitem(xParamEmp, 'IN_BLOQ_SALDO_NEG');
  putitem(xParamEmp, 'IN_FRETE_PRIMEIRA_PARCELA');
  putitem(xParamEmp, 'IN_GRAVA_REPREGUIA_TRA');
  putitem(xParamEmp, 'IN_GRAVA_TRANS_BLOQUEADA');
  putitem(xParamEmp, 'IN_GUIA_REPR_AUTO_TRA_VD');
  putitem(xParamEmp, 'IN_SOMA_FRETE_TOTALNF');
  putitem(xParamEmp, 'NR_DIA_ATRASO_BLOQ_FAT');
  putitem(xParamEmp, 'NR_DIAS_ULTCOMPRA_CLIENTE');
  putitem(xParamEmp, 'NR_ITEM_QUEBRA_NF');
  putitem(xParamEmp, 'TP_DT_VENCIMENTO_PARCELA');
  putitem(xParamEmp, 'TP_NUMERACAO_TRA');
  putitem(xParamEmp, 'TP_TABPRECO_PED');
  putitem(xParamEmp, 'TP_UTIL_DT_BASEPGTO_PED');
  putitem(xParamEmp, 'TP_VALIDA_TRANSACAO_PRD');
  putitem(xParamEmp, 'TP_VALORBRUTO_PROMOCAO');
  putitem(xParamEmp, 'VL_MINIMO_PARCELA');

  xParamEmp := T_ADMSVCO001.GetParamEmpresa(piCdEmpresa, xParamEmp);

  gCdCustoMedio := itemXml('CD_CUSTO_MEDIO_CMP', xParamEmp);
  gCdOperacaoOI := itemXml('CD_OPER_ESTOQ_PROD_OI', xParamEmp);
  gCdOperKardex := itemXml('CD_OPER_GRAVA_ZERO_KARDEX', xParamEmp);
  gCdPessoaendPadrao := itemXml('CD_PESSOA_endERECO_PADRAO', xParamEmp);
  gDsCustoSubstTributaria := itemXml('DS_CUSTO_SUBST_TRIBUTARIA', xParamEmp);
  gDsCustoValorRetido := itemXml('DS_CUSTO_VALOR_RETIDO', xParamEmp);
  gDsLstValorVenda := itemXml('DS_LST_VLR_VendA', xParamEmp);
  gInBloqSaldoNeg := itemXml('IN_BLOQ_SALDO_NEG', xParamEmp);
  gInGravaRepreGuiaTra := itemXml('IN_GRAVA_REPREGUIA_TRA', xParamEmp);
  gInGravaTraBloq := itemXml('IN_GRAVA_TRANS_BLOQUEADA', xParamEmp);
  gInGuiaReprAuto := itemXml('IN_GUIA_REPR_AUTO_TRA_VD', xParamEmp);
  gInSomaFrete := itemXml('IN_SOMA_FRETE_TOTALNF', xParamEmp);
  gNrDiaVencto := itemXml('NR_DIA_ATRASO_BLOQ_FAT', xParamEmp);
  gNrItemQuebraNf := itemXml('NR_ITEM_QUEBRA_NF', xParamEmp);
  gTpDataVenctoParcela := itemXml('TP_DT_VENCIMENTO_PARCELA', xParamEmp);
  gTpNumeracaoTra := itemXml('TP_NUMERACAO_TRA', xParamEmp);
  gTpTabPrecoPed := itemXml('TP_TABPRECO_PED', xParamEmp);
  gTpUtilizaDtBasePgto := itemXml('TP_UTIL_DT_BASEPGTO_PED', xParamEmp);
  gTpValidaTransacaoPrd := itemXml('TP_VALIDA_TRANSACAO_PRD', xParamEmp);
  gTpValorBrutoPromocao := itemXml('TP_VALORBRUTO_PROMOCAO', xParamEmp);
  gVlMinimoParcela := itemXml('VL_MINIMO_PARCELA', xParamEmp);

end;

//---------------------------------------------------------------
function T_TRASVCO004.setEntidade(pParams : String) : String;
//---------------------------------------------------------------
begin
  tBAL_BALANCOTR := GetEntidade('BAL_BALANCOTR');
  tF_TRA_ITEMIMP := GetEntidade('F_TRA_ITEMIMP');
  tFIS_REGRAIMPO := GetEntidade('FIS_REGRAIMPO');
  tGER_EMPRESA := GetEntidade('GER_EMPRESA');
  tGER_OPERACAO := GetEntidade('GER_OPERACAO');
  tGER_OPERSALDO := GetEntidade('GER_OPERSALDO');
  tGER_S_OPERACA := GetEntidade('GER_S_OPERACA');
  tOBS_TRANSACAO := GetEntidade('OBS_TRANSACAO');
  tPED_PEDIDOTRA := GetEntidade('PED_PEDIDOTRA');
  tPES_CLIENTE := GetEntidade('PES_CLIENTE');
  tPES_PESFISICA := GetEntidade('PES_PESFISICA');
  tPES_PESJURIDI := GetEntidade('PES_PESJURIDI');
  tPES_PESSOA := GetEntidade('PES_PESSOA');
  tPES_TELEFONE := GetEntidade('PES_TELEFONE');
  tPRD_LOTEI := GetEntidade('PRD_LOTEI');
  tTMP_NR09 := GetEntidade('TMP_NR09');
  tTRA_ITEMIMPOS := GetEntidade('TRA_ITEMIMPOS');
  tTRA_ITEMLOTE := GetEntidade('TRA_ITEMLOTE');
  tTRA_ITEMVL := GetEntidade('TRA_ITEMVL');
  tTRA_REMDES := GetEntidade('TRA_REMDES');
  tTRA_TRAIMPOST := GetEntidade('TRA_TRAIMPOST');
  tTRA_TRANSACAO := GetEntidade('TRA_TRANSACAO');
  tTRA_TRANSACSI := GetEntidade('TRA_TRANSACSI');
  tTRA_TRANSITEM := GetEntidade('TRA_TRANSITEM');
  tTRA_TRANSPORT := GetEntidade('TRA_TRANSPORT');
  tV_BAL_BALANCO := GetEntidade('V_BAL_BALANCO');
  tV_PES_ENDEREC := GetEntidade('V_PES_ENDEREC');
  tV_TRA_TOTATRA := GetEntidade('V_TRA_TOTATRA');
  tV_TRA_TOTITEM := GetEntidade('V_TRA_TOTITEM');
end;

//---------------------------------------------------------------------
function T_TRASVCO004.calculaTotalTransacao(pParams : String) : String;
//---------------------------------------------------------------------
const
  cDS_METHOD = 'ADICIONAL=Operação: T_TRASVCO004.calculaTotalTransacao()';
var
  vNrOccAnt, vQtSolicitada, vVlTransacao, vVlDesconto, vVlTotalBruto, vVlFrete : Real;
  vVlBaseICMS, vVlICMS, vVlBaseICMSSubst, vVlICMSSubst, vVlIPI, vVlCalc : Real;
begin
  vQtSolicitada := 0;
  vVlTransacao := 0;
  vVlTotalBruto := 0;
  vVlDesconto := 0;
  vVlBaseICMS := 0;
  vVlICMS := 0;
  vVlBaseICMSSubst := 0;
  vVlICMSSubst := 0;
  vVlIPI := 0;

  clear_e(tTRA_TRANSITEM);
  retrieve_e(tTRA_TRANSITEM);
  if (xStatus >= 0) then begin
    setocc(tTRA_TRANSITEM, 1);
    while (xStatus >= 0) do begin
      vQtSolicitada := vQtSolicitada + item_f('QT_SOLICITADA', tTRA_TRANSITEM);

      vVlTransacao := vVlTransacao + item_f('VL_TOTALLIQUIDO', tTRA_TRANSITEM);
      vVlTotalBruto := vVlTotalBruto + item_f('VL_TOTALBRUTO', tTRA_TRANSITEM);
      vVlDesconto := vVlDesconto + (item_f('VL_TOTALDESC', tTRA_TRANSITEM) + item_f('VL_TOTALDESCCAB', tTRA_TRANSITEM));
      if (empty(tTRA_ITEMIMPOS) = False) then begin
        setocc(tTRA_ITEMIMPOS, 1);
        while (xStatus >= 0) do begin
          if (item_f('CD_IMPOSTO', tTRA_ITEMIMPOS) = 1) then begin
            vVlBaseICMS := vVlBaseICMS + item_f('VL_BASECALC', tTRA_ITEMIMPOS);
            vVlICMS := vVlICMS + item_f('VL_IMPOSTO', tTRA_ITEMIMPOS);
          end else if (item_f('CD_IMPOSTO', tTRA_ITEMIMPOS) = 2) then begin
            vVlBaseICMSSubst := vVlBaseICMSSubst + item_f('VL_BASECALC', tTRA_ITEMIMPOS);
            vVlICMSSubst := vVlICMSSubst + item_f('VL_IMPOSTO', tTRA_ITEMIMPOS);
          end else if (item_f('CD_IMPOSTO', tTRA_ITEMIMPOS) = 3) then begin
            vVlIPI := vVlIPI + item_f('VL_IMPOSTO', tTRA_ITEMIMPOS);
          end;
          setocc(tTRA_ITEMIMPOS, curocc(tTRA_ITEMIMPOS) + 1);
        end;
      end;
      setocc(tTRA_TRANSITEM, curocc(tTRA_TRANSITEM) + 1);
    end;
  end;
  if (empty(tTRA_TRAIMPOST) = False) then begin
    vNrOccAnt := curocc(tTRA_TRAIMPOST);
    setocc(tTRA_TRAIMPOST, 1);
    while (xStatus >= 0) do begin
      if (item_f('CD_IMPOSTO', tTRA_TRAIMPOST) = 1) then begin
        vVlBaseICMS := vVlBaseICMS + item_f('VL_BASECALC', tTRA_TRAIMPOST);
        vVlICMS := vVlICMS + item_f('VL_IMPOSTO', tTRA_TRAIMPOST);
      end else if (item_f('CD_IMPOSTO', tTRA_TRAIMPOST) = 2) then begin
        vVlBaseICMSSubst := vVlBaseICMSSubst + item_f('VL_BASECALC', tTRA_TRAIMPOST);
        vVlICMSSubst := vVlICMSSubst + item_f('VL_IMPOSTO', tTRA_TRAIMPOST);
      end else if (item_f('CD_IMPOSTO', tTRA_TRAIMPOST) = 3) then begin
        vVlIPI := vVlIPI + item_f('VL_IMPOSTO', tTRA_TRAIMPOST);
      end;
      setocc(tTRA_TRAIMPOST, curocc(tTRA_TRAIMPOST) + 1);
    end;
    setocc(tTRA_TRAIMPOST, 1);
  end;

  vVlCalc := (vVlTotalBruto - vVlTransacao) / vVlTotalBruto * 100;
  putitem_e(tTRA_TRANSACAO, 'PR_DESCONTO', rounded(vVlCalc, 6));
  putitem_e(tTRA_TRANSACAO, 'QT_SOLICITADA', vQtSolicitada);
  putitem_e(tTRA_TRANSACAO, 'VL_TRANSACAO', vVlTransacao);
  putitem_e(tTRA_TRANSACAO, 'VL_DESCONTO', vVlDesconto);
  putitem_e(tTRA_TRANSACAO, 'VL_BASEICMS', rounded(vVlBaseICMS, 2));
  putitem_e(tTRA_TRANSACAO, 'VL_ICMS', rounded(vVlICMS, 2));
  putitem_e(tTRA_TRANSACAO, 'VL_BASEICMSSUBST', rounded(vVlBaseICMSSubst, 2));
  putitem_e(tTRA_TRANSACAO, 'VL_ICMSSUBST', rounded(vVlICMSSubst, 2));
  putitem_e(tTRA_TRANSACAO, 'VL_IPI', rounded(vVlIPI, 2));

  if (item_f('TP_FRETE', tTRA_TRANSPORT) = 2) then begin
    vVlFrete := item_f('VL_FRETE', tTRA_TRANSACAO);
  end else begin
    if (gInSomaFrete = True) then begin
      vVlFrete := item_f('VL_FRETE', tTRA_TRANSACAO);
    end else begin
      vVlFrete := 0;
    end;
  end;
  putitem_e(tTRA_TRANSACAO, 'VL_TOTAL', item_f('VL_TRANSACAO', tTRA_TRANSACAO) + item_f('VL_IPI', tTRA_TRANSACAO) +
  vVlFrete + item_f('VL_SEGURO', tTRA_TRANSACAO) +
    item_f('VL_DESPACESSOR', tTRA_TRANSACAO) + item_f('VL_ICMSSUBST', tTRA_TRANSACAO);

  return(0); exit;
end;

//---------------------------------------------------------------------
function T_TRASVCO004.calculaTotalOtimizado(pParams : String) : String;
//---------------------------------------------------------------------
const
  cDS_METHOD = 'ADICIONAL=Operação: T_TRASVCO004.calculaTotalOtimizado()';
var
  vVlCalc, vVlFrete : Real;
begin
  clear_e(tV_TRA_TOTITEM);
  putitem_o(tV_TRA_TOTITEM, 'CD_EMPRESA', item_f('CD_EMPRESA', tTRA_TRANSACAO));
  putitem_o(tV_TRA_TOTITEM, 'NR_TRANSACAO', item_f('NR_TRANSACAO', tTRA_TRANSACAO));
  putitem_o(tV_TRA_TOTITEM, 'DT_TRANSACAO', item_a('DT_TRANSACAO', tTRA_TRANSACAO));
  retrieve_e(tV_TRA_TOTITEM);
  if (xStatus >= 0) then begin
    vVlCalc := (item_f('VL_TOTALDESC', tV_TRA_TOTITEM) + item_f('VL_TOTALDESCCAB', tV_TRA_TOTITEM)) / item_f('VL_TOTALBRUTO', tV_TRA_TOTITEM) * 100;
    putitem_e(tTRA_TRANSACAO, 'PR_DESCONTO', rounded(vVlCalc, 6));
    putitem_e(tTRA_TRANSACAO, 'QT_SOLICITADA', item_f('QT_SOLICITADA', tV_TRA_TOTITEM));
    putitem_e(tTRA_TRANSACAO, 'VL_TRANSACAO', item_f('VL_TOTALLIQUIDO', tV_TRA_TOTITEM));
    putitem_e(tTRA_TRANSACAO, 'VL_DESCONTO', item_f('VL_TOTALDESC', tV_TRA_TOTITEM) + item_f('VL_TOTALDESCCAB', tV_TRA_TOTITEM));
    putitem_e(tTRA_TRANSACAO, 'VL_BASEICMS', item_f('VL_BASEICMS', tV_TRA_TOTITEM));
    putitem_e(tTRA_TRANSACAO, 'VL_ICMS', item_f('VL_ICMS', tV_TRA_TOTITEM));
    putitem_e(tTRA_TRANSACAO, 'VL_BASEICMSSUBST', item_f('VL_BASEICMSSUBST', tV_TRA_TOTITEM));
    putitem_e(tTRA_TRANSACAO, 'VL_ICMSSUBST', item_f('VL_ICMSSUBST', tV_TRA_TOTITEM));
    putitem_e(tTRA_TRANSACAO, 'VL_IPI', item_f('VL_IPI', tV_TRA_TOTITEM));
    if (item_f('TP_FRETE', tTRA_TRANSPORT) = 2) then begin
      vVlFrete := item_f('VL_FRETE', tTRA_TRANSACAO);
    end else begin
      if (gInSomaFrete = True) then begin
        vVlFrete := item_f('VL_FRETE', tTRA_TRANSACAO);
      end else begin
        vVlFrete := 0;
      end;
    end;
    putitem_e(tTRA_TRANSACAO, 'VL_TOTAL', item_f('VL_TRANSACAO', tTRA_TRANSACAO) + item_f('VL_IPI', tTRA_TRANSACAO) + vVlFrete + item_f('VL_SEGURO', tTRA_TRANSACAO) + item_f('VL_DESPACESSOR', tTRA_TRANSACAO) + item_f('VL_ICMSSUBST', tTRA_TRANSACAO));
  end;

  return(0); exit;
end;

//----------------------------------------------------------------------
function T_TRASVCO004.validaGuiaRepreCliente(pParams : String) : String;
//----------------------------------------------------------------------
const
  cDS_METHOD = 'ADICIONAL=Operação: T_TRASVCO004.validaGuiaRepreCliente()';
var
  (* numeric piCdPessoa :IN / numeric piCdPessoaAnt :IN / boolean piInNaoGravaGuiaRepre :IN *)
  viParams, voParams : String;
  vInGuiaInativo, vInGuiaBloqueado, vInRepreInativo, vInRepreBloqueado : Boolean;
begin
  if (item_f('TP_MODALIDADE', tGER_OPERACAO) = 3) then begin
    if (gInGuiaReprAuto = True)  and (piCdPessoa <> piCdPessoaAnt)  and (piInNaoGravaGuiaRepre <> True) then begin
      viParams := '';
      putitemXml(viParams, 'CD_PESSOA', piCdPessoa);
      voParams := activateCmp('PESSVCO005', 'buscaDadosPessoa', viParams); (*,,,, *)
      if (xStatus < 0) then begin
        Result := voParams;
        return(-1); exit;
      end;
      if (item_f('CD_GUIA', tTRA_TRANSACAO) = 0)  and (item_f('CD_REPRESENTANT', tTRA_TRANSACAO) = 0 ) or (gInGravaRepreGuiaTra = 01) then begin
        putitem_e(tTRA_TRANSACAO, 'CD_GUIA', itemXmlF('CD_GUIA', voParams));
      end;
      if (item_f('CD_REPRESENTANT', tTRA_TRANSACAO) = 0)  and (item_f('CD_GUIA', tTRA_TRANSACAO) = 0 ) or (gInGravaRepreGuiaTra = 01) then begin
        putitem_e(tTRA_TRANSACAO, 'CD_REPRESENTANT', itemXmlF('CD_REPRESENTANT', voParams));
      end;
    end;
  end else if (item_f('TP_MODALIDADE', tGER_OPERACAO) = 4)  and (item_f('TP_OPERACAO', tGER_OPERACAO) = 'S') then begin
    if (gInGuiaReprAuto = True)  and (piCdPessoa <> piCdPessoaAnt)  and (piInNaoGravaGuiaRepre <> True) then begin
      viParams := '';
      putitemXml(viParams, 'CD_PESSOA', piCdPessoa);
      voParams := activateCmp('PESSVCO005', 'buscaDadosPessoa', viParams); (*,,,, *)
      if (xStatus < 0) then begin
        Result := voParams;
        return(-1); exit;
      end;
      if (item_f('CD_GUIA', tTRA_TRANSACAO) = 0)  and (item_f('CD_REPRESENTANT', tTRA_TRANSACAO) = 0 ) or (gInGravaRepreGuiaTra = 01) then begin
        putitem_e(tTRA_TRANSACAO, 'CD_GUIA', itemXmlF('CD_GUIA', voParams));
      end;
      if (item_f('CD_REPRESENTANT', tTRA_TRANSACAO) = 0)  and (item_f('CD_GUIA', tTRA_TRANSACAO) = 0 ) or (gInGravaRepreGuiaTra = 01) then begin
        putitem_e(tTRA_TRANSACAO, 'CD_REPRESENTANT', itemXmlF('CD_REPRESENTANT', voParams));
      end;
    end;
  end;
  if (item_f('CD_GUIA', tTRA_TRANSACAO) <> 0) then begin
    viParams := '';
    putitemXml(viParams, 'CD_PESSOA', item_f('CD_GUIA', tTRA_TRANSACAO));
    voParams := activateCmp('PESSVCO005', 'buscaDadosPessoa', viParams); (*,,,, *)
    if (xStatus < 0) then begin
      Result := voParams;
      return(-1); exit;
    end;

    vInGuiaInativo := itemXmlB('IN_GUIAINATIVO', voParams);
    if (vInGuiaInativo = True) then begin
      Result := SetStatus(STS_ERROR, 'GEN0001', 'Guia ' + item_a('CD_GUIA', tTRA_TRANSACAO) + ' está inativo!', Operação->TRASVCO004.gravaCapaTransacao);
      return(-1); exit;
    end;

    vInGuiaBloqueado := itemXmlB('IN_GUIABLOQUEADO', voParams);
    if (vInGuiaBloqueado = True) then begin
      Result := SetStatus(STS_ERROR, 'GEN0001', 'Guia ' + item_a('CD_GUIA', tTRA_TRANSACAO) + ' está bloqueado!', Operação->TRASVCO004.gravaCapaTransacao);
      return(-1); exit;
    end;
  end;
  if (item_f('CD_REPRESENTANT', tTRA_TRANSACAO) <> 0) then begin
    viParams := '';
    putitemXml(viParams, 'CD_PESSOA', item_f('CD_REPRESENTANT', tTRA_TRANSACAO));
    voParams := activateCmp('PESSVCO005', 'buscaDadosPessoa', viParams); (*,,,, *)
    if (xStatus < 0) then begin
      Result := voParams;
      return(-1); exit;
    end;

    vInRepreInativo := itemXmlB('IN_REPREINATIVO', voParams);
    if (vInRepreInativo = True) then begin
      Result := SetStatus(STS_ERROR, 'GEN0001', 'Representante ' + item_a('CD_REPRESENTANT', tTRA_TRANSACAO) + ' está inativo!', Operação->TRASVCO004.gravaCapaTransacao);
      return(-1); exit;
    end;

    vInRepreBloqueado := itemXmlB('IN_REPREBLOQUEADO', voParams);
    if (vInRepreBloqueado = True) then begin
      Result := SetStatus(STS_ERROR, 'GEN0001', 'Representante ' + item_a('CD_REPRESENTANT', tTRA_TRANSACAO) + ' está bloqueado!', Operação->TRASVCO004.gravaCapaTransacao);
      return(-1); exit;
    end;
  end;
  if (item_f('CD_REPRESENTANT', tTRA_TRANSACAO) <> 0)  and (item_f('CD_GUIA', tTRA_TRANSACAO) <> 0)  and (gInGravaRepreGuiaTra = 00) then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Não é permitido lançar guia e representante na mesma transação!', Operação->TRASVCO004.gravaCapaTransacao);
    return(-1); exit;
  end;

  return(0); exit;

end;

//--------------------------------------------------------------------
function T_TRASVCO004.validaProdutoBalanco(pParams : String) : String;
//--------------------------------------------------------------------
const
  cDS_METHOD = 'ADICIONAL=Operação: T_TRASVCO004.validaProdutoBalanco()';
var
  vCdProduto, vCdOperacao, vCdSaldoOperacao : Real;
  vInKardex : Boolean;
begin
  vCdProduto := itemXmlF('CD_PRODUTO', pParams);
  vCdOperacao := itemXmlF('CD_OPERACAO', pParams);
  vInkardex := itemXmlB('IN_KARDEX', pParams);

  if (gTpValidaTransacaoPrd = 2) then begin
    return(0); exit;
  end else begin
    if (vCdProduto <> '') then begin
      clear_e(tV_BAL_BALANCO);
      putitem_o(tV_BAL_BALANCO, 'CD_EMPRESA', itemXmlF('CD_EMPRESA', PARAM_GLB));
      putitem_o(tV_BAL_BALANCO, 'CD_PRODUTO', vCdProduto);
      putitem_o(tV_BAL_BALANCO, 'TP_SITUACAOC', '1);
      retrieve_e(tV_BAL_BALANCO);
      if (xStatus >= 0) then begin
        clear_e(tBAL_BALANCOTR);
        putitem_o(tBAL_BALANCOTR, 'CD_EMPBALANCO', itemXmlF('CD_EMPRESA', PARAM_GLB));
        putitem_o(tBAL_BALANCOTR, 'NR_TRANSACAO', item_f('NR_TRANSACAO', tTRA_TRANSACAO));
        retrieve_e(tBAL_BALANCOTR);
        if (xStatus < 0) then begin
          if (gTpValidaTransacaoPrd = 1) then begin
            Result := SetStatus(STS_ERROR, 'GEN0001', 'Produto ' + FloatToStr(vCdProduto) + ' não pode ser gravado, o mesmo se encontra em balanço em andamento!', Operação->TRASVCO004.gravaCapaTransacao);
            return(-1); exit;

          end else if (gTpValidaTransacaoPrd = 3 ) and (vInKardex = True) then begin
            vCdSaldoOperacao := 0;
            if (vCdOperacao > 0) then begin
              clear_e(tGER_OPERSALDO);
              putitem_o(tGER_OPERSALDO, 'CD_OPERACAO', vCdOperacao);
              putitem_o(tGER_OPERSALDO, 'IN_PADRAO', True);
              retrieve_e(tGER_OPERSALDO);
              if (xStatus >= 0) then begin
                vCdSaldoOperacao := item_f('CD_SALDO', tGER_OPERSALDO);
              end else begin
                clear_e(tGER_OPERSALDO);
                putitem_o(tGER_OPERSALDO, 'CD_OPERACAO', vCdOperacao);
                retrieve_e(tGER_OPERSALDO);
                if (xStatus >= 0) then begin
                  vCdSaldoOperacao := item_f('CD_SALDO', tGER_OPERSALDO);
                end else begin
                  clear_e(tGER_OPERSALDO);
                end;
              end;
            end;
            if (vCdSaldoOperacao = item_f('CD_SALDO', tV_BAL_BALANCO)) then begin
              Result := SetStatus(STS_ERROR, 'GEN0001', 'Produto ' + FloatToStr(vCdProduto) + ' não pode ser gravado, o mesmo se encontra em balanço em andamento!', Operação->TRASVCO004.gravaCapaTransacao);
              return(-1); exit;
            end;
          end;
        end;
      end;
    end;
  end;

  return(0); exit;

end;

//------------------------------------------------------------------
function T_TRASVCO004.gravaCapaTransacao(pParams : String) : String;
//------------------------------------------------------------------
const
  cDS_METHOD = 'ADICIONAL=Operação: T_TRASVCO004.gravaCapaTransacao()';
var
  viParams, voParams, vCdCST, vDsRegistro, vNmCheckout, vDsLstTabPreco, vLstGlobal, vDsMensagem : String;
  vCdEmpresa, vNrTransacao, vCdPessoa, vCdOperacao, vCdCondPgto, vCdImposto, vVlFrete : Real;
  vCdCompVend, vTpSituacao, vTpOrigemEmissao, vNrSeqendereco, vCdPessoaAnt, vNrDiaSPC : Real;
  vNrDiaVencto, vCdCCusto, vCdTabPreco,vCdEmpresaOri, vNrTransacaoOri, vNrDiaUltCompra : Real;
  vCdClientePdvEmp : Real;
  vDtTransacao, vDtTransacaoOri, vDtBaseParcela, vDtSistema, vDtSPC : TDate;
  vInNaoVerifCliBloq, vInValidaClienteAtraso, vInNaoVerificaCliBloq, vInNaoGravaGuiaRepre : Boolean;
  vInImpressao, vInInclusao, vInValidaData : Boolean;
begin
  PARAM_GLB := PARAM_GLB;
  vCdEmpresa := itemXmlF('CD_EMPRESA', pParams);
  vNrTransacao := itemXmlF('NR_TRANSACAO', pParams);
  vDtTransacao := itemXml('DT_TRANSACAO', pParams);
  vCdPessoa := itemXmlF('CD_PESSOA', pParams);
  vCdOperacao := itemXmlF('CD_OPERACAO', pParams);
  vCdCondpgto := itemXmlF('CD_CONDPGTO', pParams);
  vCdCompVend := itemXmlF('CD_COMPVend', pParams);
  vTpSituacao := itemXmlF('TP_SITUACAO', pParams);
  vTpOrigemEmissao := itemXmlF('TP_ORIGEMEMISSAO', pParams);
  vInNaoVerifCliBloq := itemXmlB('IN_NAO_VERIFICA_CLI_BLOQ', pParams);
  vInValidaClienteAtraso := itemXmlB('IN_VALIDA_CLIENTE_ATRASO', pParams);
  vInNaoGravaGuiaRepre := itemXmlB('IN_NAOGRAVAGUIAREPRE', pParams);
  vCdEmpresaOri := itemXmlF('CD_EMPRESAORI', pParams);
  vNrTransacaoOri := itemXmlF('NR_TRANSACAOORI', pParams);
  vDtTransacaoOri := itemXml('DT_TRANSACAOORI', pParams);

  if (vInNaoVerifCliBloq = '') then begin
    vInNaoVerifCliBloq := False;
  end;

  vInImpressao := itemXmlB('IN_IMPRESSAO', pParams);
  if (vInImpressao = '') then begin
    vInImpressao := False;
  end;
  if (vTpOrigemEmissao = 0) then begin
    vTpOrigemEmissao := 1;
  end;

  vInValidaData := itemXmlB('IN_VALIDADATA', pParams);
  if (vInValidaData = '') then begin
    vInValidaData := True;
  end;
  if (vCdEmpresa = 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Empresa não informada!', Operação->TRASVCO004.gravaCapaTransacao);
    return(-1); exit;
  end;
  if (vDtTransacao = '') then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Data transação não informada!', Operação->TRASVCO004.gravaCapaTransacao);
    return(-1); exit;
  end;
  if (vCdPessoa = 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Pessoa não informada!', Operação->TRASVCO004.gravaCapaTransacao);
    return(-1); exit;
  end;
  if (vCdOperacao = 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Operação não informada!', Operação->TRASVCO004.gravaCapaTransacao);
    return(-1); exit;
  end;
  if (vCdCondPgto = 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Condição de pagamento não informada!', Operação->TRASVCO004.gravaCapaTransacao);
    return(-1); exit;
  end;
  if (vCdCompVend = 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Comprador/Vendedor não informado!', Operação->TRASVCO004.gravaCapaTransacao);
    return(-1); exit;
  end;

  voParams := getParam(viParams); (* pParams *) (viParams); (* * vCdEmpresa *)
  if (xStatus < 0) then begin
    return(-1); exit;
  end;

  vDtSistema := itemXml('DT_SISTEMA', xParamEmp);

  viParams := '';
  putitemXml(viParams, 'CD_PESSOA', vCdPessoa);
  voParams := activateCmp('TRASVCO016', 'validaCapaTransacao', viParams); (*,,,, *)
  if (xStatus < 0) then begin
    Result := voParams;
    return(-1); exit;
  end;

  viParams := '';
  clear_e(tGER_OPERACAO);
  putitem_o(tGER_OPERACAO, 'CD_OPERACAO', vCdOperacao);
  retrieve_e(tGER_OPERACAO);
  if (xStatus >= 0) then begin
    if (item_f('TP_DOCTO', tGER_OPERACAO) = 2 ) or (item_f('TP_DOCTO', tGER_OPERACAO) = 3)  and (item_f('TP_MODALIDADE', tGER_OPERACAO) = 4 ) or (item_f('TP_MODALIDADE', tGER_OPERACAO) = 8 ) or (item_f('TP_MODALIDADE', tGER_OPERACAO) = 3) then begin
      putitemXml(viParams, 'IN_VendA_ECF', True);
    end;
  end;

  putitemXml(viParams, 'CD_PESSOA', vCdPessoa);
  voParams := activateCmp('PESSVCO005', 'buscaenderecoFaturamento', viParams); (*,,,, *)
  if (xStatus < 0) then begin
    Result := voParams;
    return(-1); exit;
  end;

  vNrSeqendereco := itemXmlF('NR_SEQendERECO', voParams);

  viParams := '';
  putitemXml(viParams, 'CD_OPERACAO', vCdOperacao);
  putitemXml(viParams, 'CD_CONDPGTO', vCdCondPgto);
  voParams := activateCmp('GERSVCO103', 'validaCondPgtoOperacao', viParams); (*,,,, *)
  if (xStatus < 0) then begin
    Result := voParams;
    return(-1); exit;
  end;
  if (vInValidaClienteAtraso = True) then begin
    viParams := '';
    putitemXml(viParams, 'CD_CLIENTE', vCdPessoa);
    putitemXml(viParams, 'IN_TOTAL', True);
    voParams := activateCmp('FCRSVCO015', 'buscaLimiteCliente', viParams); (*,,,, *)
    if (xStatus < 0) then begin
      Result := voParams;
      return(-1); exit;
    end;
    vNrDiaVencto := itemXmlF('NR_DIAVENCTO', voParams);
    if (gNrDiaVencto > 0) then begin
      if (vNrDiaVencto > gNrDiaVencto) then begin
        Result := SetStatus(STS_ERROR, 'GEN0001', 'O cliente ' + FloatToStr(vCdPessoa) + ' possui fatura com ' + FloatToStr(vNrDiaVencto) + ' dia(s) vencida, o que ultrapassa o limite de ' + FloatToStr(gNrDiaVencto) + ' dia(s).', Operação->TRASVCO004.gravaCapaTransacao);
        return(-2);
      end;
    end;
  end;

  vCdPessoaAnt := '';
  clear_e(tTRA_TRANSACAO);

  vInInclusao := True;

  if (vNrTransacao > 0) then begin
    creocc(tTRA_TRANSACAO, -1);
    putitem_o(tTRA_TRANSACAO, 'CD_EMPRESA', vCdEmpresa);
    putitem_o(tTRA_TRANSACAO, 'NR_TRANSACAO', vNrTransacao);
    putitem_o(tTRA_TRANSACAO, 'DT_TRANSACAO', vDtTransacao);
    retrieve_o(tTRA_TRANSACAO);
    if (xStatus = -7) then begin
      retrieve_x(tTRA_TRANSACAO);
      if (item_f('TP_SITUACAO', tTRA_TRANSACAO) <> 1)  and (item_f('TP_SITUACAO', tTRA_TRANSACAO) <> 2)  and (item_f('TP_SITUACAO', tTRA_TRANSACAO) <> 8) then begin
        Result := SetStatus(STS_ERROR, 'GEN0001', 'Transação não pode ser alterada pois não está em andamento!', Operação->TRASVCO004.gravaCapaTransacao);
        return(-1); exit;
      end;
      vCdPessoaAnt := item_f('CD_PESSOA', tTRA_TRANSACAO);
    end;
    delitem(pParams, 'CD_EMPRESA');
    delitem(pParams, 'NR_TRANSACAO');
    delitem(pParams, 'DT_TRANSACAO');

    if (vCdPessoaAnt <> vCdPessoa)  and (vCdPessoaAnt > 0) then begin
      if (empty(tTRA_REMDES) = False) then begin
        voParams := tTRA_REMDES.Excluir();
        if (xStatus < 0) then begin
          Result := voParams;
          return(-1); exit;
        end;
      end;
    end;

    vInInclusao := False;

  end;

  getlistitensocc_e(pParams, tTRA_TRANSACAO);
  putitem_e(tTRA_TRANSACAO, 'NR_SEQENDERECO', vNrSeqendereco);
  if (item_f('CD_EMPFAT', tTRA_TRANSACAO) = 0) then begin
    putitem_e(tTRA_TRANSACAO, 'CD_EMPFAT', item_f('CD_EMPRESA', tTRA_TRANSACAO));
  end;

  clear_e(tGER_EMPRESA);
  putitem_o(tGER_EMPRESA, 'CD_EMPRESA', vCdEmpresa);
  retrieve_e(tGER_EMPRESA);
  if (xStatus >= 0) then begin
    putitem_e(tTRA_TRANSACAO, 'CD_GRUPOEMPRESA', item_f('CD_GRUPOEMPRESA', tGER_EMPRESA));
  end else begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Empresa ' + FloatToStr(vCdEmpresa) + ' não cadastrada!', Operação->TRASVCO004.gravaCapaTransacao);
    return(-1); exit;
  end;

  clear_e(tGER_OPERACAO);
  putitem_o(tGER_OPERACAO, 'CD_OPERACAO', vCdOperacao);
  retrieve_e(tGER_OPERACAO);
  if (xStatus >= 0) then begin
    putitem_e(tTRA_TRANSACAO, 'TP_OPERACAO', item_f('TP_OPERACAO', tGER_OPERACAO));
  end else begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Operação ' + item_a('CD_OPERACAO', tGER_OPERACAO) + ' não cadastrada!', Operação->TRASVCO004.gravaCapaTransacao);
    return(-1); exit;
  end;
  if (item_f('CD_OPERFAT', tGER_OPERACAO) = 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Operação ' + item_a('CD_OPERACAO', tGER_OPERACAO) + ' não possui operação de movimento!', Operação->TRASVCO004.gravaCapaTransacao);
    return(-1); exit;
  end;

  clear_e(tPES_PESSOA);
  putitem_o(tPES_PESSOA, 'CD_PESSOA', vCdPessoa);
  retrieve_e(tPES_PESSOA);
  if (xStatus < 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Pessoa ' + FloatToStr(vCdPessoa) + ' não cadastrada!', Operação->TRASVCO004.gravaCapaTransacao);
    return(-1); exit;
  end;
  if (item_f('TP_MODALIDADE', tGER_OPERACAO) = 4 ) and (item_f('TP_OPERACAO', tGER_OPERACAO) = 'S') then begin
    if (item_f('CD_PESSOA', tTRA_TRANSACAO) = gCdClientePdv) then begin
      viParams := '';
      putitemXml(viParams, 'CD_PESSOA', item_f('CD_PESSOA', tTRA_TRANSACAO));
      voParams := activateCmp('ADMSVCO025', 'CD_CLIENTE_PDV_EMP', viParams); (*,,,, *)
      if (xStatus < 0) then begin
        Result := voParams;
        return(-1); exit;
      end;
    end;
  end;

  vNrDiaUltCompra := itemXmlF('NR_DIAS_ULTCOMPRA_CLIENTE', xParamEmp);
  vCdClientePdvEmp := itemXmlF('CD_CLIENTE_PDV_EMP', xParamEmp);

  if (vNrDiaUltCompra > 0)  and (item_f('TP_MODALIDADE', tGER_OPERACAO) = 4 ) or (item_f('TP_MODALIDADE', tGER_OPERACAO) = 7 ) or (item_f('TP_MODALIDADE', tGER_OPERACAO) = 'C')  and (item_f('TP_OPERACAO', tGER_OPERACAO) = 'S') then begin
    if (vCdPessoa <> gCdClientePdv ) and (vCdPessoa <> vCdClientePdvEmp)  and (item_f('TP_PESSOA', tPES_PESSOA) = 'F') then begin
      viParams := '';
      putitemXml(viParams, 'CD_PESSOA', vCdPessoa);
      voParams := activateCmp('PESSVCO005', 'buscaDadosPessoaFisica', viParams); (*,,,, *)
      if (xStatus < 0) then begin
        Result := voParams;
        return(-1); exit;
      end;

      vDtSPC := itemXml('DT_ATUALIZSPC', voParams);
      if (vDtSPC <> '') then begin
        vNrDiaSPC := vDtSistema - vDtSPC;

        if (vNrDiaSPC > vNrDiaUltCompra) then begin
          Result := SetStatus(STS_ERROR, 'GEN0001', 'O cliente ' + FloatToStr(vCdPessoa) + ' está a ' + FloatToStr(vNrDiaSPC) + ' dia(s) sem efetuar consulta SPC. Verificar o cadastro!', Operação->TRASVCO004.gravaCapaTransacao);
          return(-1); exit;
        end;
      end else begin
        Result := SetStatus(STS_ERROR, 'GEN0001', 'O cliente ' + FloatToStr(vCdPessoa) + ' não possui consulta SPC. Verificar o cadastro!', Operação->TRASVCO004.gravaCapaTransacao);
        return(-1); exit;
      end;
    end;
  end;
  if (item_f('TP_OPERACAO', tGER_OPERACAO) = 'S')  and (item_f('TP_MODALIDADE', tGER_OPERACAO) = 4 ) or (item_f('TP_MODALIDADE', tGER_OPERACAO) = 7 ) or (item_f('TP_MODALIDADE', tGER_OPERACAO) = 8 ) or (item_f('TP_MODALIDADE', tGER_OPERACAO) = 'C') then begin
    setocc(tPES_CLIENTE, 1);
    if (!dbocc(t'PES_CLIENTE')) then begin
      Result := SetStatus(STS_ERROR, 'GEN0001', 'Cliente ' + FloatToStr(vCdPessoa) + ' não cadastrado!', Operação->TRASVCO004.gravaCapaTransacao);
      return(-1); exit;
    end;
      if (item_b('IN_BLOQUEADO', tPES_CLIENTE) = True) then begin
        if (vInNaoVerifCliBloq = False)  and (vCdPessoaAnt <> item_f('CD_CLIENTE', tPES_CLIENTE)) then begin
          Result := SetStatus(STS_ERROR, 'GEN0001', 'Cliente ' + FloatToStr(vCdPessoa) + ' bloqueado!', Operação->TRASVCO004.gravaCapaTransacao);
          return(-3);

        end;
      end;
    if (item_b('IN_INATIVO', tPES_CLIENTE) = True) then begin
      if (vInImpressao = True) then begin
      end else begin
        Result := SetStatus(STS_ERROR, 'GEN0001', 'Cliente ' + FloatToStr(vCdPessoa) + ' inativo!', Operação->TRASVCO004.gravaCapaTransacao);
        return(-1); exit;
      end;
    end;
  end;

  voParams := validaGuiaRepreCliente(viParams); (* item_f('CD_CLIENTE', tPES_CLIENTE), vCdPessoaAnt, vInNaoGravaGuiaRepre *)
  if (xStatus < 0) then begin
    Result := voParams;
    return(-1); exit;
  end;
  if (item_f('TP_MODALIDADE', tGER_OPERACAO) = 2) then begin
    vCdCCusto := item_f('CD_CCUSTO', tGER_EMPRESA);
    clear_e(tGER_EMPRESA);
    putitem_o(tGER_EMPRESA, 'CD_PESSOA', vCdPessoa);
    retrieve_e(tGER_EMPRESA);
    if (xStatus < 0) then begin
      Result := SetStatus(STS_ERROR, 'GEN0001', 'Pessoa ' + FloatToStr(vCdPessoa) + ' não está relacionada a nenhuma empresa para tranferência.', Operação->TRASVCO004.gravaCapaTransacao);
      return(-1); exit;
    end;
    if (item_f('CD_CCUSTO', tGER_EMPRESA) > 0 ) and (vCdCCusto = 0)  or (item_f('CD_CCUSTO', tGER_EMPRESA) = 0 ) and (vCdCCusto > 0) then begin
      Result := SetStatus(STS_ERROR, 'GEN0001', 'Empresa ' + item_a('CD_EMPRESA', tGER_EMPRESA) + ' incompatível para transferência com ' + FloatToStr(vCdEmpresa) + '!', Operação->TRASVCO004.gravaCapaTransacao);
      return(-1); exit;
    end;
    clear_e(tGER_EMPRESA);
    putitem_o(tGER_EMPRESA, 'CD_EMPRESA', vCdEmpresa);
    retrieve_e(tGER_EMPRESA);
    if (xStatus < 0) then begin
      Result := SetStatus(STS_ERROR, 'GEN0001', 'Empresa ' + FloatToStr(vCdEmpresa) + ' não cadastrada!', Operação->TRASVCO004.gravaCapaTransacao);
      return(-1); exit;
    end;
    if (vCdPessoa = item_f('CD_PESSOA', tGER_EMPRESA))  and (item_f('TP_DOCTO', tGER_OPERACAO) = 1) then begin
      Result := SetStatus(STS_ERROR, 'GEN0001', 'Não é permitido fazer transferência para a mesma empresa!', Operação->TRASVCO004.gravaCapaTransacao);
      return(-1); exit;
    end;
  end;
  if (vNrTransacao = 0) then begin
    vLstGlobal := '';
    putitemXml(vLstGlobal, 'CD_GRUPOEMPRESA', item_f('CD_GRUPOEMPRESA', tTRA_TRANSACAO));
    putitemXml(vLstGlobal, 'CD_USUARIO', itemXmlF('CD_USUARIO', PARAM_GLB));

    if (gTpNumeracaoTra = 01) then begin
            newinstance 'GERSVCO011', 'GERSVCO011', 'TRANSACTION=TRUE';
      voParams := activateCmp('GERSVCO011', 'GetNumSeq', viParams); (*vLstGlobal,'TRA_TRANSACAO','NR_TRANSACAO',vDtTransacao,999999999,vNrTransacao,, *)
      if (xStatus < 0) then begin
        Result := voParams;
        return(-1); exit;
      end;
    end else if (gTpNumeracaoTra = 02) then begin
            newinstance 'GERSVCO011', 'GERSVCO011', 'TRANSACTION=TRUE';
      voParams := activateCmp('GERSVCO011', 'GetNumSeq', viParams); (*vLstGlobal,'TRA_TRANSACAO','NR_TRANSACAO','01/01/2001',999999999,vNrTransacao,, *)
      if (xStatus < 0) then begin
        Result := voParams;
        return(-1); exit;
      end;
    end else begin
      viParams := '';
      putitemXml(viParams, 'NM_ENTIDADE', 'TRA_TRANSACAO');
      putitemXml(viParams, 'NM_ATRIBUTO', 'NR_TRANSACAO');
      voParams := activateCmp('GERSVCO031', 'getNumSeq', viParams); (*,,,, *)
      if (xStatus < 0) then begin
        Result := voParams;
        return(-1); exit;
      end;
      vNrTransacao := itemXmlF('NR_SEQUENCIA', voParams);
    end;
    putitem_e(tTRA_TRANSACAO, 'NR_TRANSACAO', vNrTransacao);
  end;
  if (item_a('DT_TRANSACAO', tTRA_TRANSACAO) <> vDtSistema)  and (vInInclusao = True)  and (vInValidaData = True) then begin
    gDtData := vDtTransacao;
    vDsMensagem := 'DESCRICAO=A transação ' + FloatToStr(vCdEmpresa) + ' / ' + FloatToStr(vNrTransacao) + ' / ' + gDtData + ' difere da data do sistema';
    gDtData := vDtSistema;
    vDsMensagem := '' + vDsMensagem + ' ' + gDtData + '!';
    Result := SetStatus(STS_ERROR, 'GEN0001', 'vDsMensagem', Operação->TRASVCO004.gravaCapaTransacao);
    return(-1); exit;
  end;
  if (item_b('IN_ACEITADEV', tTRA_TRANSACAO) = '') then begin
    putitem_e(tTRA_TRANSACAO, 'IN_ACEITADEV', True);
  end;
  if (item_f('TP_SITUACAO', tTRA_TRANSACAO) = '') then begin
    putitem_e(tTRA_TRANSACAO, 'TP_SITUACAO', 1);
    if (gInGravaTraBloq = True) then begin
      putitem_e(tTRA_TRANSACAO, 'TP_SITUACAO', 8);
    end;
  end;

  putitem_e(tTRA_TRANSACAO, 'TP_ORIGEMEMISSAO', vTpOrigemEmissao);

  voParams := calculaTotalTransacao(viParams); (* *)
  if (xStatus < 0) then begin
    Result := voParams;
    return(-1); exit;
  end;

  putitem_e(tTRA_TRANSACAO, 'CD_OPERADOR', itemXmlF('CD_USUARIO', PARAM_GLB));
  if (item_f('CD_USURELAC', tTRA_TRANSACAO) = '') then begin
    putitem_e(tTRA_TRANSACAO, 'CD_USURELAC', itemXmlF('CD_USUARIO', PARAM_GLB));
  end;
  putitem_e(tTRA_TRANSACAO, 'DT_CADASTRO', Now);

  if (vCdEmpresaOri > 0 ) and (vNrTransacaoOri > 0 ) and (vDtTransacaoOri <> '') then begin
    putitem_e(tTRA_TRANSACAO, 'CD_EMPRESAORI', vCdEmpresaOri);
    putitem_e(tTRA_TRANSACAO, 'NR_TRANSACAOORI', vNrTransacaoOri);
    putitem_e(tTRA_TRANSACAO, 'DT_TRANSACAOORI', vDtTransacaoOri);
  end;

  voParams := tTRA_TRANSACAO.Salvar();
  if (xStatus < 0) then begin
    Result := voParams;
    return(-1); exit;
  end;

  vNmCheckout := itemXml('NM_CHECKOUT', PARAM_GLB);
  if (vNmCheckout <> '') then begin
    viParams := '';
    putitemXml(viParams, 'CD_EMPRESA', vCdEmpresa);
    putitemXml(viParams, 'NR_TRANSACAO', vNrTransacao);
    putitemXml(viParams, 'DT_TRANSACAO', vDtTransacao);
    putitemXml(viParams, 'NM_CHECKOUT', vNmCheckout);
    putitemXml(viParams, 'IN_CHECKOUT', True);
    voParams := activateCmp('TRASVCO016', 'gravaDadosAdicionais', viParams); (*,,,, *)
    if (xStatus < 0) then begin
      Result := voParams;
      return(-1); exit;
    end;
  end;

  vDtBaseParcela := itemXml('DT_BASE_VENCTO_FAT', PARAM_GLB);
  if (vDtBaseParcela <> '') then begin
    viParams := '';
    putitemXml(viParams, 'CD_EMPRESA', vCdEmpresa);
    putitemXml(viParams, 'NR_TRANSACAO', vNrTransacao);
    putitemXml(viParams, 'DT_TRANSACAO', vDtTransacao);
    putitemXml(viParams, 'DT_BASEPARCELA', vDtBaseParcela);
    putitemXml(viParams, 'IN_BASEPARCELA', True);
    voParams := activateCmp('TRASVCO016', 'gravaDadosAdicionais', viParams); (*,,,, *)
    if (xStatus < 0) then begin
      Result := voParams;
      return(-1); exit;
    end;
  end;
  if (item_f('TP_MODALIDADE', tGER_OPERACAO) = 4 ) or (item_f('TP_MODALIDADE', tGER_OPERACAO) = 3)  and (gInGuiaReprAuto = True)  and (gTpTabPrecoPed = 2)  and (item_f('CD_REPRESENTANT', tTRA_TRANSACAO) <> 0) then begin
    viParams := '';
    putitemXml(viParams, 'CD_CLIENTE', item_f('CD_PESSOA', tTRA_TRANSACAO));
    putitemXml(viParams, 'CD_REPRESENTANT', item_f('CD_REPRESENTANT', tTRA_TRANSACAO));
    voParams := activateCmp('PEDSVCO008', 'buscaTabelaPreco', viParams); (*,,,, *)
    if (xStatus < 0) then begin
      Result := voParams;
      return(-1); exit;
    end;

    vDsLstTabPreco := itemXmlF('CD_TABPRECO', voParams);

    getitem(vCdTabPreco, vDsLstTabPreco, 1);

    viParams := '';
    putitemXml(viParams, 'CD_EMPRESA', vCdEmpresa);
    putitemXml(viParams, 'NR_TRANSACAO', vNrTransacao);
    putitemXml(viParams, 'DT_TRANSACAO', vDtTransacao);
    putitemXml(viParams, 'CD_TABPRECO', vCdTabPreco);
    putitemXml(viParams, 'IN_TABPRECO', True);
    putitemXml(viParams, 'IN_TABPRECOZERO', True);
    voParams := activateCmp('TRASVCO016', 'gravaDadosAdicionais', viParams); (*,,,, *)
    if (xStatus < 0) then begin
      Result := voParams;
      return(-1); exit;
    end;
  end;

  Result := '';
  putitemXml(Result, 'CD_EMPRESA', item_f('CD_EMPRESA', tTRA_TRANSACAO));
  putitemXml(Result, 'NR_TRANSACAO', item_f('NR_TRANSACAO', tTRA_TRANSACAO));
  putitemXml(Result, 'DT_TRANSACAO', item_a('DT_TRANSACAO', tTRA_TRANSACAO));

  return(0); exit;
end;

//-------------------------------------------------------------------
function T_TRASVCO004.validaItemTransacao(pParams : String) : String;
//-------------------------------------------------------------------
const
  cDS_METHOD = 'ADICIONAL=Operação: T_TRASVCO004.validaItemTransacao()';
var
  viParams, voParams, vCdCST, vCdBarraPrd, vDsUFOrigem, vDsUFDestino, vDsErro, vCdMPTer, vCdTipi : String;
  vTpItem, vDsServico, vDsMP, vCdEspecieMP, vDsRegProduto, vDsProduto : String;
  vCdEmpresa, vCdCFOP, vNrTransacao, vCdProduto, vCdPromocao, vCdCompVend, vQtProduto : Real;
  vVlUnitBruto, vVlTotalBruto, vVlUnitLiquido, vVlTotalLiquido, vTpAreaComercio, vCdServico : Real;
  vVlUnitDesc, vVlTotalDesc, vPrDesconto, vQtEmbalagem, vVlCalc, vPesTerc, vCdTabPreco : Real;
  vTpLote, vTpInspecao, vVlOriginal, vVlBase : Real;
  vDtTransacao, vDtValor : TDate;
  vInCodigo, vTpValidaVlZerado, vInValidaVlZerado, vInProdutoBloq : Boolean;
  vInDadosOperacao, vInServico, vInMatPrima, vInProdAcabado, vInValorPadraoTransf : Boolean;
begin
  PARAM_GLB := PARAM_GLB;
  vCdEmpresa := itemXmlF('CD_EMPRESA', pParams);
  vNrTransacao := itemXmlF('NR_TRANSACAO', pParams);
  vDtTransacao := itemXml('DT_TRANSACAO', pParams);
  vCdBarraPrd := itemXmlF('CD_BARRAPRD', pParams);
  vCdMPTer := itemXmlF('CD_MPTER', pParams);
  vCdServico := itemXmlF('CD_SERVICO', pParams);
  vInCodigo := itemXmlB('IN_CODIGO', pParams);
  vInValidaVlZerado := itemXmlB('IN_VALIDAVLZERADO', pParams);

  vQtEmbalagem := itemXmlF('QT_SOLICITADA', pParams);
  vVlUnitBruto := itemXmlF('VL_BRUTO', pParams);
  vVlUnitLiquido := itemXmlF('VL_LIQUIDO', pParams);
  vVlUnitDesc := itemXmlF('VL_DESCONTO', pParams);
  vCdCompVend := itemXmlF('CD_COMPVend', pParams);
  vCdCFOP := itemXmlF('CD_CFOP', pParams);
  vCdCST := itemXmlF('CD_CST', pParams);
  vDtValor := itemXml('DT_VALOR', pParams);
  vTpAreaComercio := itemXmlF('TP_AREACOMERCIO', pParams);
  vPesTerc := itemXmlF('CD_PESSOATERC', pParams);
  vTpItem := itemXmlF('TP_ITEM', pParams);
  vCdTabPreco := itemXmlF('CD_TABPRECO', pParams);
  gCdEspecieServico := itemXmlF('CD_ESPECIE_SERVICO_TRA', PARAM_GLB);
  vDsProduto := itemXml('DS_PRODUTO', pParams);
  vInValorPadraoTransf := itemXmlB('IN_VALOR_PADRAO_TRANSF', pParams);

  vVlTotalBruto := 0;
  vVlTotalLiquido := 0;
  vVlTotalDesc := 0;

  if (vCdEmpresa = 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Empresa não informada!', Operação->TRASVCO004.validaItemTransacao);
    return(-1); exit;
  end;
  if (vNrTransacao = 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Número transação não informado!', Operação->TRASVCO004.validaItemTransacao);
    return(-1); exit;
  end;
  if (vDtTransacao = '') then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Data transação não informada!', Operação->TRASVCO004.validaItemTransacao);
    return(-1); exit;
  end;

  clear_e(tTRA_TRANSACAO);
  putitem_o(tTRA_TRANSACAO, 'CD_EMPRESA', vCdEmpresa);
  putitem_o(tTRA_TRANSACAO, 'NR_TRANSACAO', vNrTransacao);
  putitem_o(tTRA_TRANSACAO, 'DT_TRANSACAO', vDtTransacao);
  retrieve_e(tTRA_TRANSACAO);
  if (xStatus < 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Transação ' + FloatToStr(vNrTransacao) + ' não cadastrada!', Operação->TRASVCO004.validaItemTransacao);
    return(-1); exit;
  end;
  if (item_f('TP_SITUACAO', tTRA_TRANSACAO) <> 1)  and (item_f('TP_SITUACAO', tTRA_TRANSACAO) <> 8) then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Não é possível inserir itens na transação ' + item_a('CD_EMPFAT', tTRA_TRANSACAO) + ' / ' + item_a('NR_TRANSACAO', tTRA_TRANSACAO) + ' pois não está em andamento/bloqueada!', Operação->TRASVCO004.validaItemTransacao);
    return(-1); exit;
  end;

  vDsMP := '';
  vCdEspecieMP := '';
  vDsServico := '';
  vDsRegProduto := '';

  if (vTpItem   = 'S') then begin
    if (vCdServico = '') then begin
      Result := SetStatus(STS_ERROR, 'GEN0001', 'Serviço não informado!', Operação->TRASVCO004.validaItemTransacao);
      return(-1); exit;
    end;
    if (vInDadosOperacao = True ) and (vInServico <> True) then begin
      Result := SetStatus(STS_ERROR, 'GEN0001', 'A operação ' + item_a('CD_OPERACAO', tTRA_TRANSACAO) + ' da transação não é uma operação de serviço!', Operação->TRASVCO004.validaItemTransacao);
      return(-1); exit;
    end;

    viParams := '';
    putitemXml(viParams, 'CD_SERVICO', vCdServico);
    voParams := activateCmp('PCPSVCO020', 'buscaDadosServico', viParams); (*,,,, *)
    if (xStatus < 0) then begin
      Result := voParams;
      return(-1); exit;
    end;
    vDsServico := itemXml('DS_SERVICO', voParams);
  end else begin
    if (vCdBarraPrd = '')  and (vCdMPTer = '') then begin
      Result := SetStatus(STS_ERROR, 'GEN0001', 'Produto não informado!', Operação->TRASVCO004.validaItemTransacao);
      return(-1); exit;
    end;
    if (vCdMPTer <> '') then begin
      viParams := '';
      if (vPesTerc <> '') then begin
        putitemXml(viParams, 'CD_PESSOA', vPesTerc);
      end else begin
        putitemXml(viParams, 'CD_PESSOA', item_f('CD_PESSOA', tTRA_TRANSACAO));
      end;
      putitemXml(viParams, 'CD_MPTER', vCdMPTer);
      voParams := activateCmp('GERSVCO046', 'buscaDadosMPTerceito', viParams); (*,,,, *)
      if (xStatus < 0) then begin
        Result := voParams;
        return(-1); exit;
      end;
      vDsMP := itemXml('DS_MP', voParams);
      vCdEspecieMP := itemXmlF('CD_ESPECIE', voParams);
      vCdTipi := itemXmlF('CD_TIPI', voParams);
    end else begin
      if (vInDadosOperacao = True ) and (vInProdAcabado <> True ) and (vInMatPrima <> True) then begin
        Result := SetStatus(STS_ERROR, 'GEN0001', 'A operação ' + item_a('CD_OPERACAO', tTRA_TRANSACAO) + ' da transação não é uma operação de produto acabado ou matéria-prima!', Operação->TRASVCO004.validaItemTransacao);
        return(-1); exit;
      end;

      viParams := '';
      putitemXml(viParams, 'CD_EMPRESA', vCdEmpresa);
      putitemXml(viParams, 'CD_OPERACAO', item_f('CD_OPERACAO', tTRA_TRANSACAO));
      voParams := activateCmp('GERSVCO054', 'dadosAdicionaisOperacao', viParams); (*,,,, *)
      if (xStatus < 0) then begin
        Result := voParams;
        return(-1); exit;
      end;
      vInProdAcabado := itemXmlB('IN_PRODACABADO', voParams);
      vInMatPrima := itemXmlB('IN_MATPRIMA', voParams);

      vTpLote := itemXmlF('TP_LOTE', voParams);
      vTpInspecao := itemXmlF('TP_INSPECAO', voParams);

      vInProdutoBloq := itemXmlB('IN_PRODUTOBLOQ', voParams);

      viParams := '';
      putitemXml(viParams, 'CD_BARRAPRD', vCdBarraPrd);
      putitemXml(viParams, 'IN_CODIGO', vInCodigo);
      putitemXml(viParams, 'CD_EMPRESA', vCdEmpresa);
      putitemXml(viParams, 'IN_PRODACABADO', vInProdAcabado);
      putitemXml(viParams, 'IN_MATPRIMA', vInMatPrima);
      putitemXml(viParams, 'TP_LOTE', vTpLote);
      putitemXml(viParams, 'TP_INSPECAO', vTpInspecao);
      putitemXml(viParams, 'IN_PRODUTOBLOQ', vInProdutoBloq);
      voParams := activateCmp('PRDSVCO004', 'verificaProduto', viParams); (*,,,, *)
      if (xStatus < 0) then begin
        Result := voParams;
        return(-1); exit;
      end;
        if (vQtEmbalagem = 0) then begin
          vQtEmbalagem := itemXmlF('QT_EMBALAGEM', voParams);
          if (vQtEmbalagem = 0) then begin
            vQtEmbalagem := 1;
          end;
        end else begin
          vQtProduto := itemXmlF('QT_EMBALAGEM', voParams);
          if (vQtProduto > 0) then begin
            vQtEmbalagem := vQtEmbalagem * vQtProduto;
          end;
        end;
      end;
      if (vQtEmbalagem > 99999999) then begin
        Result := SetStatus(STS_ERROR, 'GEN0001', 'A quantidade não pode ser superior a 99.999.999!', Operação->TRASVCO004.validaItemTransacao);
        return(-1); exit;
      end;

      viParams := '';
      putitemXml(viParams, 'CD_PRODUTO', vCdProduto);
      putitemXml(viParams, 'QT_QUANTIDADE', vQtEmbalagem);
      voParams := activateCmp('PRDSVCO008', 'validaQtdFracionada', viParams); (*,,,, *)
      if (xStatus < 0) then begin
        Result := voParams;
        return(-1); exit;
      end;
      if (gCdEmpParam = 0)  or (gCdEmpParam <> vCdEmpresa) then begin
        voParams := getParam(viParams); (* pParams *) (viParams); (* * vCdEmpresa *)
        if (xStatus < 0) then begin
          return(-1); exit;
        end;
        gCdEmpParam := vCdEmpresa;
      end;
      viParams := '';
      putitemXml(viParams, 'CD_PRODUTO', vCdProduto);
      voParams := activateCmp('GERSVCO046', 'buscaDadosProduto', viParams); (*,,,, *)
      if (xStatus < 0) then begin
        Result := voParams;
        return(-1); exit;
      end;

      vDsRegProduto := voParams;

      if (itemXml('CD_CST', vDsRegProduto) = '') then begin
        Result := SetStatus(STS_ERROR, 'GEN0001', 'Produto ' + FloatToStr(vCdProduto) + ' sem CST cadastrado!', Operação->TRASVCO004.validaItemTransacao);
        return(-1); exit;
      end;
      if (itemXml('CD_ESPECIE', vDsRegProduto) = '') then begin
        Result := SetStatus(STS_ERROR, 'GEN0001', 'Produto ' + FloatToStr(vCdProduto) + ' sem espécie cadastrada!', Operação->TRASVCO004.validaItemTransacao);
        return(-1); exit;
      end;
      if (vInCodigo <> True)  and (gDsSepBarraPrd <> '') then begin
        scan vCdBarraPrd, gDsSepBarraPrd;
        if (gresult > 0) then begin
          clear_e(tTRA_TRANSITEM);
          putitem_o(tTRA_TRANSITEM, 'CD_BARRAPRD', vCdBarraPrd);
          retrieve_e(tTRA_TRANSITEM);
          if (xStatus >= 0) then begin
            Result := SetStatus(STS_ERROR, 'GEN0001', 'Código de barras ' + FloatToStr(vCdBarraPrd) + ' já cadastrado na transação ' + item_a('CD_EMPFAT', tTRA_TRANSACAO) + ' / ' + item_a('NR_TRANSACAO', tTRA_TRANSACAO) + '!', Operação->TRASVCO004.validaItemTransacao);
            return(-1); exit;
          end;
        end;
      end;
    end;
  end;

  clear_e(tV_PES_ENDEREC);
  putitem_o(tV_PES_ENDEREC, 'CD_PESSOA', item_f('CD_PESSOA', tPES_PESSOA));
  putitem_o(tV_PES_ENDEREC, 'NR_SEQUENCIA', item_f('NR_SEQENDERECO', tTRA_TRANSACAO));
  retrieve_e(tV_PES_ENDEREC);
  if (xStatus < 0) then begin
    if (item_f('TP_DOCTO', tGER_OPERACAO) = 2 ) or (item_f('TP_DOCTO', tGER_OPERACAO) = 3)  and (item_f('TP_MODALIDADE', tGER_OPERACAO) = 4 ) or (item_f('TP_MODALIDADE', tGER_OPERACAO) = 8 ) or (item_f('TP_MODALIDADE', tGER_OPERACAO) = 3) then begin
      if (gCdPessoaendPadrao <> '') then begin
        clear_e(tV_PES_ENDEREC);
        putitem_o(tV_PES_ENDEREC, 'CD_PESSOA', gCdPessoaendPadrao);
        putitem_o(tV_PES_ENDEREC, 'NR_SEQUENCIA', item_f('NR_SEQENDERECO', tTRA_TRANSACAO));
        retrieve_e(tV_PES_ENDEREC);
        if (xStatus < 0) then begin
          Result := SetStatus(STS_ERROR, 'GEN0001', 'endereço ' + item_a('NR_SEQendERECO', tTRA_TRANSACAO) + ' não cadastrado para a pessoa ' + FloatToStr(gCdPessoaendPadrao) + '!', Operação->TRASVCO004.validaItemTransacao);
          return(-1); exit;
        end;
      end else begin
        Result := SetStatus(STS_ERROR, 'GEN0001', 'endereço ' + item_a('NR_SEQendERECO', tTRA_TRANSACAO) + ' não cadastrado para a pessoa ' + item_a('CD_PESSOA', tPES_PESSOA) + '!', Operação->TRASVCO004.validaItemTransacao);
        return(-1); exit;
      end;
    end else begin
      Result := SetStatus(STS_ERROR, 'GEN0001', 'endereço ' + item_a('NR_SEQendERECO', tTRA_TRANSACAO) + ' não cadastrado para a pessoa ' + item_a('CD_PESSOA', tPES_PESSOA) + '!', Operação->TRASVCO004.validaItemTransacao);
      return(-1); exit;
    end;
  end;
  if (vCdCFOP = 0) then begin
    viParams := '';
    if (vTpItem   = 'S') then begin
      putitemXml(viParams, 'CD_SERVICO', vCdServico);
    end else begin
      if (vCdMPTer <> '') then begin
        putitemXml(viParams, 'CD_MPTER', vCdMPTer);
      end else begin
        putitemXml(viParams, 'CD_PRODUTO', vCdProduto);
      end;
    end;

    clear_e(tTRA_REMDES);
    retrieve_e(tTRA_REMDES);
    if (xStatus >= 0) then begin
      if (item_f('CD_PESSOA', tTRA_REMDES) <> '') then begin
        putitemXml(viParams, 'CD_PESSOA', item_f('CD_PESSOA', tTRA_REMDES));
      end else begin
        putitemXml(viParams, 'CD_PESSOA', item_f('CD_PESSOA', tTRA_TRANSACAO));
      end;
      if (item_a('DS_SIGLAESTADO', tTRA_REMDES) <> '') then begin
        putitemXml(viParams, 'UF_DESTINO', item_a('DS_SIGLAESTADO', tTRA_REMDES));
      end else begin
        putitemXml(viParams, 'UF_DESTINO', item_a('DS_SIGLAESTADO', tV_PES_ENDEREC));
      end;
    end else begin
      putitemXml(viParams, 'CD_PESSOA', item_f('CD_PESSOA', tTRA_TRANSACAO));
      putitemXml(viParams, 'UF_DESTINO', item_a('DS_SIGLAESTADO', tV_PES_ENDEREC));
    end;

    putitemXml(viParams, 'CD_OPERACAO', item_f('CD_OPERACAO', tGER_OPERACAO));
    putitemXml(viParams, 'TP_AREACOMERCIO', vTpAreaComercio);
    putitemXml(viParams, 'TP_ORIGEMEMISSAO', item_f('TP_ORIGEMEMISSAO', tTRA_TRANSACAO));
    voParams := activateCmp('FISSVCO015', 'buscaCFOP', viParams); (*,,,, *)
    if (xStatus < 0) then begin
      Result := voParams;
      return(-1); exit;
    end;

    vCdCFOP := itemXmlF('CD_CFOP', voParams);
  end;
  if (vCdCFOP = 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Nenhum CFOP encontrado para o produto ' + FloatToStr(vCdProduto) + ' da transação ' + FloatToStr(vNrTransacao) + '!', Operação->TRASVCO004.validaItemTransacao);
    return(-1); exit;
  end;
  if (vCdCST = '') then begin
    viParams := '';
    if (vTpItem   = 'S') then begin
      putitemXml(viParams, 'CD_SERVICO', vCdServico);
    end else begin
      if (vCdMPTer <> '') then begin
        putitemXml(viParams, 'CD_MPTER', vCdMPTer);
      end else begin
        putitemXml(viParams, 'CD_PRODUTO', vCdProduto);
      end;
    end;
    putitemXml(viParams, 'CD_OPERACAO', item_f('CD_OPERACAO', tGER_OPERACAO));
    putitemXml(viParams, 'UF_DESTINO', item_a('DS_SIGLAESTADO', tV_PES_ENDEREC));
    putitemXml(viParams, 'CD_PESSOA', item_f('CD_PESSOA', tTRA_TRANSACAO));
    putitemXml(viParams, 'TP_AREACOMERCIO', vTpAreaComercio);
    putitemXml(viParams, 'TP_ORIGEMEMISSAO', item_f('TP_ORIGEMEMISSAO', tTRA_TRANSACAO));
    putitemXml(viParams, 'CD_CFOP', vCdCFOP);
    voParams := activateCmp('FISSVCO015', 'buscaCST', viParams); (*,,,, *)
    if (xStatus < 0) then begin
      Result := voParams;
      return(-1); exit;
    end;

    vCdCST := itemXmlF('CD_CST', voParams);
  end;
  if (vCdCST = '') then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Produto ' + FloatToStr(vCdProduto) + ' sem CST cadastrado!', Operação->TRASVCO004.validaItemTransacao);
    return(-1); exit;
  end;
  if (vCdCompVend = 0) then begin
    vCdCompVend := item_f('CD_COMPVEND', tTRA_TRANSACAO);
  end;
  if (vTpItem   = 'S') then begin
  end else begin
    if (vCdMPTer <> '') then begin
    end else begin
      if (vVlUnitBruto = 0)  or (vVlUnitLiquido = 0) then begin
        if (item_f('TP_OPERACAO', tGER_OPERACAO) = 'E')  and (item_f('TP_MODALIDADE', tGER_OPERACAO) = 4) then begin
        end else begin

          if (vCdTabPreco <> 0) then begin
            viParams := '';
            putitemXml(viParams, 'CD_EMPRESA', vCdEmpresa);
            putitemXml(viParams, 'CD_PRODUTO', vCdProduto);
            putitemXml(viParams, 'CD_TABPRECO', vCdTabPreco);
            putitemXml(viParams, 'CD_CONDPGTO', item_f('CD_CONDPGTO', tTRA_TRANSACAO));
            putitemXml(viParams, 'CD_OPERACAO', item_f('CD_OPERACAO', tTRA_TRANSACAO));
            voParams := activateCmp('PEDSVCO008', 'buscaValorProduto', viParams); (*,,,, *)
            if (xStatus < 0) then begin
              Result := voParams;
              return(-1); exit;
            end;
            vVlUnitLiquido := itemXmlF('VL_UNITARIO', voParams);
            vVlUnitBruto := itemXmlF('VL_UNITARIO', voParams);
          end else begin
            viParams := '';
            putitemXml(viParams, 'CD_EMPRESA', vCdEmpresa);
            putitemXml(viParams, 'CD_PRODUTO', vCdProduto);
            putitemXml(viParams, 'CD_CONDPGTO', item_f('CD_CONDPGTO', tTRA_TRANSACAO));
            putitemXml(viParams, 'CD_OPERACAO', item_f('CD_OPERACAO', tTRA_TRANSACAO));
            putitemXml(viParams, 'DT_VALOR', vDtValor);
            putitemXml(viParams, 'IN_VALOR_PADRAO_TRANSF', vInValorPadraoTransf);
            voParams := activateCmp('GERSVCO012', 'buscaValorOperacao', viParams); (*,,,, *)
            if (xStatus < 0) then begin
              Result := voParams;
              return(-1); exit;
            end;
            vVlBase := itemXmlF('VL_BASE', voParams);
            vVlOriginal := itemXmlF('VL_ORIGINAL', voParams);
            vVlUnitBruto := itemXmlF('VL_BRUTO', voParams);
            vVlUnitLiquido := itemXmlF('VL_LIQUIDO', voParams);
            vVlUnitDesc := itemXmlF('VL_DESCONTO', voParams);
            vCdPromocao := itemXmlF('CD_PROMOCAO', voParams);
          end;
          if (vCdPromocao > 0)  and (gTpValorBrutoPromocao = 1) then begin
            vVlUnitBruto := itemXmlF('VL_ORIGINAL', voParams);
            vVlUnitDesc := vVlUnitBruto - vVlUnitLiquido;
          end;
        end;
      end;
      if (vVlUnitLiquido = 0 ) or (vVlUnitBruto = 0) then begin
        if ((item_f('TP_OPERACAO', tGER_OPERACAO) = 'S')  and (item_f('TP_MODALIDADE', tGER_OPERACAO) = 4 ) or (item_f('TP_MODALIDADE', tGER_OPERACAO) = 2))  or (item_f('TP_MODALIDADE', tGER_OPERACAO) = 3)  or (item_f('TP_MODALIDADE', tGER_OPERACAO) = 7) then begin
          Result := SetStatus(STS_ERROR, 'GEN0001', 'Produto ' + FloatToStr(vCdProduto) + ' com preço zerado!', Operação->TRASVCO004.validaItemTransacao);
          return(-1); exit;
        end;
        if (vInValidaVlZerado = True) then begin
          Result := SetStatus(STS_ERROR, 'GEN0001', 'Produto ' + FloatToStr(vCdProduto) + ' com valor zerado!', Operação->TRASVCO004.validaItemTransacao);
          return(-1); exit;
        end;
      end;
    end;
  end;

  vVlCalc := vVlUnitDesc / vVlUnitBruto * 100;
  vPrDesconto := rounded(vVlCalc, 6);
  vVlCalc := vQtEmbalagem * vVlUnitBruto;
  vVlTotalBruto := rounded(vVlCalc, 2);
  vVlCalc := vQtEmbalagem * vVlUnitLiquido;
  vVlTotalLiquido := rounded(vVlCalc, 2);
  vVlTotalDesc := vVlTotalBruto - vVlTotalLiquido;
  vVlCalc := vVlTotalDesc / vQtEmbalagem;
  vVlUnitDesc := rounded(vVlCalc, 6);

  Result := '';
  if (vTpItem   = 'S') then begin
    putitemXml(Result, 'CD_BARRAPRD', vCdServico);
    putitemXml(Result, 'CD_SERVICO', vCdServico);
    putitemXml(Result, 'CD_PRODUTO', vCdServico);
    putitemXml(Result, 'DS_PRODUTO', vDsServico);
    putitemXml(Result, 'CD_ESPECIE', gCdEspecieServico);
  end else begin
    if (vCdMPTer <> '') then begin
      putitemXml(Result, 'CD_BARRAPRD', vCdMPTer);
      putitemXml(Result, 'CD_MPTER', vCdMPTer);
      putitemXml(Result, 'DS_PRODUTO', vDsMP);
      putitemXml(Result, 'CD_ESPECIE', vCdEspecieMP);
      putitemXml(Result, 'CD_TIPI', vCdTipi);
    end else begin
      putitemXml(Result, 'CD_PRODUTO', itemXmlF('CD_PRODUTO', vDsRegProduto));
      putitemXml(Result, 'CD_BARRAPRD', vCdBarraPrd);
      putitemXml(Result, 'DS_PRODUTO', itemXml('DS_PRODUTO', vDsRegProduto));
      putitemXml(Result, 'CD_ESPECIE', itemXmlF('CD_ESPECIE', vDsRegProduto));
      putitemXml(Result, 'CD_TIPI', itemXmlF('CD_TIPI', vDsRegProduto));
    end;
  end;
  putitemXml(Result, 'CD_CST', vCdCst);
  putitemXml(Result, 'CD_CFOP', vCdCFOP);
  putitemXml(Result, 'CD_COMPVend', vCdCompVend);
  putitemXml(Result, 'CD_PROMOCAO', vCdPromocao);
  putitemXml(Result, 'QT_SOLICITADA', vQtEmbalagem);
  putitemXml(Result, 'QT_ATendIDA', 0);
  putitemXml(Result, 'QT_SALDO', vQtEmbalagem);
  putitemXml(Result, 'VL_UNITBRUTO', vVlUnitBruto);
  putitemXml(Result, 'VL_TOTALBRUTO', vVlTotalBruto);
  putitemXml(Result, 'VL_UNITLIQUIDO', vVlUnitLiquido);
  putitemXml(Result, 'VL_TOTALLIQUIDO', vVlTotalLiquido);
  putitemXml(Result, 'VL_UNITDESC', vVlUnitDesc);
  putitemXml(Result, 'VL_TOTALDESC', vVlTotalDesc);
  putitemXml(Result, 'VL_UNITDESCCAB', 0);
  putitemXml(Result, 'VL_TOTALDESCCAB', 0);
  putitemXml(Result, 'PR_DESCONTO', vPrDesconto);
  putitemXml(Result, 'VL_ORIGINAL', vVlOriginal);
  putitemXml(Result, 'VL_BASE', vVlBase);

  if (vPrDesconto <> 0) then begin
    putitemXml(Result, 'IN_DESCONTO', True);
  end else begin
    putitemXml(Result, 'IN_DESCONTO', False);
  end;
  if (vDsProduto <> '') then begin
    putitemXml(Result, 'DS_PRODUTO', vDsProduto);
  end;

  return(0); exit;
end;

//------------------------------------------------------------------
function T_TRASVCO004.gravaItemTransacao(pParams : String) : String;
//------------------------------------------------------------------
const
  cDS_METHOD = 'ADICIONAL=Operação: T_TRASVCO004.gravaItemTransacao()';
var
  viParams, voParams, vCdCST, vDsRegistro, vDsLstImposto, vQtArredondada, vDsMensagem : String;
  vCdMPTer, vCdProdutoMsg, vDsProduto, vDsLstItemLote, vCdEspecie, viListas : String;
  vCdEmpresa, vNrTransacao, vNrItem, vCdCFOP, vCdProduto, vQtEstoque, vQtSolicitadaAnt, vTpLote, vVlBase, vVlOriginal : Real;
  vCdCompVend, vCdDecreto, vVlCalc, vCdImposto, vVlDif, vQtDisponivel, vQtEntrada, vQtSaida, vCdServico, vCdOper : Real;
  vVlDifUnitario, vVlCalcUnitario, vVlInteiro, vVlFracionado, vNrDescItem, vNr, vCdCustoVenda, vVlUnitCustoVenda : Real;
  vDtTransacao : TDate;
  vInTotal, vInSoDescricao, vInProdAcabado, vInMatPrima, vInSemMovimento, vInNaoValidaLote, vInGravaImposto : Boolean;
  vInImpressao, vInVenda, vInBloqSaldoNeg, vInTransacao : Boolean;
  vDsLstValorVenda : String;
begin
  gHrInicio := gclock;
  PARAM_GLB := PARAM_GLB;
  vCdEmpresa := itemXmlF('CD_EMPRESA', pParams);
  vNrTransacao := itemXmlF('NR_TRANSACAO', pParams);
  vDtTransacao := itemXml('DT_TRANSACAO', pParams);
  vNrItem := itemXmlF('NR_ITEM', pParams);
  vCdCST := itemXmlF('CD_CST', pParams);
  vCdCFOP := itemXmlF('CD_CFOP', pParams);
  vCdEspecie := itemXmlF('CD_ESPECIE', pParams);
  vCdProduto := itemXmlF('CD_PRODUTO', pParams);
  vDsProduto := itemXml('DS_PRODUTO', pParams);
  vCdMPTer := itemXmlF('CD_MPTER', pParams);
  vCdServico := itemXmlF('CD_SERVICO', pParams);
  vCdCompVend := itemXmlF('CD_COMPVend', pParams);
  vInTotal := itemXmlB('IN_TOTAL', pParams);
  vDsLstImposto := itemXml('DS_LSTIMPOSTO', pParams);
  vDsLstItemLote := itemXml('DS_LSTITEMLOTE', pParams);
  vInSemMovimento := itemXmlB('IN_SEMMOVIMENTO', pParams);
  vVlBase := itemXmlF('VL_BASE', pParams);
  vVlOriginal := itemXmlF('VL_ORIGINAL', pParams);
  gCdEspecieServico := itemXmlF('CD_ESPECIE_SERVICO_TRA', PARAM_GLB);

  vInImpressao := itemXmlB('IN_IMPRESSAO', pParams);
  if (vInImpressao = '') then begin
    vInImpressao := False;
  end;

  vInTransacao := itemXmlB('IN_TRANSACAO', pParams);
  if (vInTransacao = '') then begin
    vInTransacao := True;
  end;
  if (vCdEspecie = gCdEspecieServico) then begin
    vCdServico := vCdProduto;
  end;

  vInNaoValidaLote := itemXmlB('IN_NAOVALIDALOTE', pParams);
  if (vInNaoValidaLote = '') then begin
    vInNaoValidaLote := False;
  end;
  if (vCdServico > 0) then begin
    vCdProdutoMsg := vCdServico;
  end else if (vCdMPTer <> '') then begin
    vCdProdutoMsg := vCdMPTer;
  end else begin
    vCdProdutoMsg := vCdProduto;
  end;
  if (vCdEmpresa = 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Empresa não informada!', Operação->TRASVCO004.gravaItemTransacao);
    return(-1); exit;
  end;
  if (vNrTransacao = 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Número transação não informado!', Operação->TRASVCO004.gravaItemTransacao);
    return(-1); exit;
  end;
  if (vDtTransacao = '') then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Data transação não informada!', Operação->TRASVCO004.gravaItemTransacao);
    return(-1); exit;
  end;
  if (vInTotal = '') then begin
    vInTotal := True;
  end;

  clear_e(tGER_EMPRESA);
  putitem_o(tGER_EMPRESA, 'CD_EMPRESA', vCdEmpresa);
  retrieve_e(tGER_EMPRESA);
  if (xStatus < 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Empresao ' + FloatToStr(vCdEmpresa) + ' não cadastrada!', Operação->TRASVCO004.gravaItemTransacao);
    return(-1); exit;
  end;

  clear_e(tTRA_TRANSACAO);
  putitem_o(tTRA_TRANSACAO, 'CD_EMPRESA', vCdEmpresa);
  putitem_o(tTRA_TRANSACAO, 'NR_TRANSACAO', vNrTransacao);
  putitem_o(tTRA_TRANSACAO, 'DT_TRANSACAO', vDtTransacao);
  retrieve_e(tTRA_TRANSACAO);
  if (xStatus < 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Transação ' + FloatToStr(vNrTransacao) + ' não cadastrada!', Operação->TRASVCO004.gravaItemTransacao);
    return(-1); exit;
  end;
  if (vCdEspecie <> 'SVC') then begin
    putitemXml(viParams, 'CD_PRODUTO', vCdProduto);
    putitemXml(viParams, 'CD_OPERACAO', item_f('CD_OPERACAO', tGER_OPERACAO));
    putitemXml(viParams, 'IN_KARDEX', item_b('IN_KARDEX', tGER_OPERACAO));
    voParams := validaProdutoBalanco(viParams); (* viParams *)
    if (xStatus < 0) then begin
      return(-1); exit;
    end;
  end;
  if (gCdEmpParam = 0)  or (gCdEmpParam <> item_f('CD_EMPFAT', tTRA_TRANSACAO))  or (gInBloqSaldoNeg ) and (gCdOperKardex = '') then begin
    voParams := getParam(viParams); (* pParams *) (viParams); (* * item_f('CD_EMPFAT', tTRA_TRANSACAO) *)
    if (xStatus < 0) then begin
      return(-1); exit;
    end;
    gCdEmpParam := item_f('CD_EMPFAT', tTRA_TRANSACAO);
  end;
  if (gCdOperKardex <> '') then begin
    repeat
      getitem(vCdOper, gCdOperKardex, 1);

      creocc(tTMP_NR09, -1);
      putitem_e(tTMP_NR09, 'NR_GERAL', vCdOper);
      retrieve_o(tTMP_NR09);
      if (xStatus = -7) then begin
        retrieve_x(tTMP_NR09);
      end;

      delitem(gCdOperKardex, 1);
    until (gCdOperKardex = '');
  end;

  clear_e(tV_PES_ENDEREC);
  putitem_o(tV_PES_ENDEREC, 'CD_PESSOA', item_f('CD_PESSOA', tPES_PESSOA));
  putitem_o(tV_PES_ENDEREC, 'NR_SEQUENCIA', item_f('NR_SEQENDERECO', tTRA_TRANSACAO));
  retrieve_e(tV_PES_ENDEREC);
  if (xStatus < 0) then begin
    if (item_f('TP_DOCTO', tGER_OPERACAO) = 2 ) or (item_f('TP_DOCTO', tGER_OPERACAO) = 3)  and (item_f('TP_MODALIDADE', tGER_OPERACAO) = 4 ) or (item_f('TP_MODALIDADE', tGER_OPERACAO) = 8 ) or (item_f('TP_MODALIDADE', tGER_OPERACAO) = 3) then begin
      if (gCdPessoaendPadrao <> '') then begin
        clear_e(tV_PES_ENDEREC);
        putitem_o(tV_PES_ENDEREC, 'CD_PESSOA', gCdPessoaendPadrao);
        putitem_o(tV_PES_ENDEREC, 'NR_SEQUENCIA', item_f('NR_SEQENDERECO', tTRA_TRANSACAO));
        retrieve_e(tV_PES_ENDEREC);
        if (xStatus < 0) then begin
          Result := SetStatus(STS_ERROR, 'GEN0001', 'endereço ' + item_a('NR_SEQendERECO', tTRA_TRANSACAO) + ' não cadastrado para a pessoa ' + FloatToStr(gCdPessoaendPadrao) + '!', Operação->TRASVCO004.gravaItemTransacao);
          return(-1); exit;
        end;
      end else begin
        Result := SetStatus(STS_ERROR, 'GEN0001', 'endereço ' + item_a('NR_SEQendERECO', tTRA_TRANSACAO) + ' não cadastrado para a pessoa ' + item_a('CD_PESSOA', tPES_PESSOA) + '!', Operação->TRASVCO004.gravaItemTransacao);
        return(-1); exit;
      end;
    end else begin
      Result := SetStatus(STS_ERROR, 'GEN0001', 'endereço ' + item_a('NR_SEQendERECO', tTRA_TRANSACAO) + ' não cadastrado para a pessoa ' + item_a('CD_PESSOA', tPES_PESSOA) + '!', Operação->TRASVCO004.gravaItemTransacao);
      return(-1); exit;
    end;
  end;

  vInSoDescricao := False;

  if (vCdProduto = 0)  and (vCdMPTer = '')  and (vCdServico = 0) then begin
      vInSoDescricao := True;

  end else begin
    if (vCdCST = '') then begin
      Result := SetStatus(STS_ERROR, 'GEN0001', 'Item ' + FloatToStr(vNrItem) + ' / Produto ' + FloatToStr(vCdProdutoMsg) + ' da transação ' + FloatToStr(vNrTransacao) + ' sem CST informado!', Operação->TRASVCO004.gravaItemTransacao);
      return(-1); exit;
    end;
    if (vCdCFOP = 0) then begin
      Result := SetStatus(STS_ERROR, 'GEN0001', 'Item ' + FloatToStr(vNrItem) + ' / Produto ' + FloatToStr(vCdProdutoMsg) + ' da transação ' + FloatToStr(vNrTransacao) + ' sem CFOP informado!', Operação->TRASVCO004.gravaItemTransacao);
      return(-1); exit;
    end;
    if (vCdCompVend = 0) then begin
      Result := SetStatus(STS_ERROR, 'GEN0001', 'Item ' + FloatToStr(vNrItem) + ' / Produto ' + FloatToStr(vCdProdutoMsg) + ' da transação ' + FloatToStr(vNrTransacao) + ' sem Comprador/Vendedor informado!', Operação->TRASVCO004.gravaItemTransacao);
      return(-1); exit;
    end;
    if (item_f('TP_OPERACAO', tGER_OPERACAO) = 'E') then begin
      if (vCdCFOP >= 4000) then begin
        Result := SetStatus(STS_ERROR, 'GEN0001', 'CFOP ' + FloatToStr(vCdCFOP) + ' do produto ' + FloatToStr(vCdProdutoMsg) + ' da transação ' + FloatToStr(vNrTransacao) + ' incompatível com a operação de entrada!', Operação->TRASVCO004.gravaItemTransacao);
        return(-1); exit;
      end;
    end else if (item_f('TP_OPERACAO', tGER_OPERACAO) = 'S') then begin
      if (vCdCFOP < 5000) then begin
        Result := SetStatus(STS_ERROR, 'GEN0001', 'CFOP ' + FloatToStr(vCdCFOP) + ' do produto ' + FloatToStr(vCdProdutoMsg) + ' da transação ' + FloatToStr(vNrTransacao) + ' incompatível com a operação de saída!', Operação->TRASVCO004.gravaItemTransacao);
        return(-1); exit;
      end;
    end;
    if ((item_f('TP_OPERACAO', tGER_OPERACAO) = 'E' ) and (item_f('TP_MODALIDADE', tGER_OPERACAO) = 4)  or (item_f('TP_OPERACAO', tGER_OPERACAO) = 'S' ) and (item_f('TP_MODALIDADE', tGER_OPERACAO) = 3))  and (vCdServico = 0) then begin
      viParams := '';
      putitemXml(viParams, 'CD_FORNECEDOR', item_f('CD_PESSOA', tTRA_TRANSACAO));
      putitemXml(viParams, 'CD_PRODUTO', vCdProduto);
      voParams := activateCmp('PRDSVCO008', 'validaProdutoFornecedor', viParams); (*,,,, *)
      if (xStatus < 0) then begin
        Result := voParams;
        return(-1); exit;
      end;
    end;
  end;

  clear_e(tTRA_TRANSITEM);
  creocc(tTRA_TRANSITEM, -1);

  vQtSolicitadaAnt := 0;

  if (vNrItem = 0) then begin
    select max(NR_ITEM) 
    from 'TRA_TRANSITEMSVC' 
    where (putitem_e(tTRA_TRANSITEM, 'CD_EMPRESA', vCdEmpresa ) and (
    putitem_e(tTRA_TRANSITEM, 'NR_TRANSACAO', vNrTransacao ) and (
    putitem_e(tTRA_TRANSITEM, 'DT_TRANSACAO', vDtTransacao)
    to vNrItem;
    if (xStatus < 0) then begin
      Result := SetStatus(STS_ERROR, xProcerror, 'xProcerrorcontext', cDS_METHOD);
      return(-1); exit;
    end;
    if (vNrItem = 0) then begin
      vNrItem := 1;
    end else begin
      vNrItem := vNrItem + 1;
    end;
    putitem_e(tTRA_TRANSITEM, 'NR_ITEM', vNrItem);
  end else begin
    putitem_e(tTRA_TRANSITEM, 'NR_ITEM', vNrItem);
    retrieve_o(tTRA_TRANSITEM);
    if (xStatus = -7) then begin
      retrieve_x(tTRA_TRANSITEM);
      vQtSolicitadaAnt := item_f('QT_SOLICITADA', tTRA_TRANSITEM);
      if (empty(tTRA_ITEMIMPOS) = False) then begin
        voParams := tTRA_ITEMIMPOS.Excluir();
        if (xStatus < 0) then begin
          Result := voParams;
          return(-1); exit;
        end;
      end;
      if (item_f('QT_SOLICITADA', tTRA_TRANSITEM) = 0) then begin
        viParams := '';
        putitemXml(viParams, 'CD_EMPRESA', item_f('CD_EMPRESA', tTRA_TRANSITEM));
        putitemXml(viParams, 'NR_TRANSACAO', item_f('NR_TRANSACAO', tTRA_TRANSITEM));
        putitemXml(viParams, 'DT_TRANSACAO', item_a('DT_TRANSACAO', tTRA_TRANSITEM));
        putitemXml(viParams, 'NR_ITEM', item_f('NR_ITEM', tTRA_TRANSITEM));
        voParams := activateCmp('SICSVCO005', 'arredondaQtFracionada', viParams); (*,,,, *)
        if (xStatus < 0) then begin
          Result := voParams;
          return(-1); exit;
        end;
        vQtArredondada := itemXmlF('QT_SOLICITADA', voParams);
      end else begin
        vQtArredondada := item_f('QT_SOLICITADA', tTRA_TRANSITEM);
      end;
    end;
  end;
  if (item_f('TP_DOCTO', tGER_OPERACAO) = 2 ) or (item_f('TP_DOCTO', tGER_OPERACAO) = 3) then begin
    if (item_f('NR_ITEM', tTRA_TRANSITEM) > 990) then begin
      Result := SetStatus(STS_ERROR, 'GEN0001', 'Quantidade de itens da transação não pode ser maior que 990!Convênio 57/95 do SINTEGRA.', Operação->TRASVCO004.gravaItemTransacao);
      return(-1); exit;
    end;
  end else if (gNrItemQuebraNf = 0) then begin
    if (item_f('NR_ITEM', tTRA_TRANSITEM) > 990) then begin
      Result := SetStatus(STS_ERROR, 'GEN0001', 'Quantidade de itens da transação não pode ser maior que 990!Convênio 57/95 do SINTEGRA.', Operação->TRASVCO004.gravaItemTransacao);
      return(-1); exit;
    end;
  end;
  if (vInSoDescricao = True) then begin
    putitem_e(tTRA_TRANSITEM, 'DS_PRODUTO', vDsProduto);
  end else begin
    delitem(pParams, 'CD_EMPRESA');
    delitem(pParams, 'NR_TRANSACAO');
    delitem(pParams, 'DT_TRANSACAO');
    delitem(pParams, 'NR_ITEM');

    getlistitensocc_e(pParams, tTRA_TRANSITEM);
    if (item_f('TP_SITUACAO', tTRA_TRANSACAO) = 4)  or (item_f('TP_SITUACAO', tTRA_TRANSACAO) = 5) then begin
      putitem_e(tTRA_TRANSITEM, 'QT_ATENDIDA', item_f('QT_SOLICITADA', tTRA_TRANSITEM));
      putitem_e(tTRA_TRANSITEM, 'QT_SALDO', 0);
    end else begin
      putitem_e(tTRA_TRANSITEM, 'QT_SALDO', item_f('QT_SOLICITADA', tTRA_TRANSITEM));
      putitem_e(tTRA_TRANSITEM, 'QT_ATENDIDA', 0);
    end;
    if (vCdMPTer = '')  and (vCdServico = 0) then begin
      viParams := '';
      putitemXml(viParams, 'CD_EMPRESA', item_f('CD_EMPRESA', tGER_EMPRESA));
      putitemXml(viParams, 'CD_PRODUTO', vCdProduto);
      voParams := activateCmp('PRDSVCO008', 'buscaDadosFilial', viParams); (*,,,, *)
      if (xStatus < 0) then begin
        Result := voParams;
        return(-1); exit;
      end;
      vInMatPrima := itemXmlB('IN_MATPRIMA', voParams);
      vInProdAcabado := itemXmlB('IN_PRODACABADO', voParams);
      vTpLote := itemXmlF('TP_LOTE', voParams);
    end;
    if (vTpLote > 0)  and (item_f('TP_OPERACAO', tTRA_TRANSACAO) = 'S')  and (!vInNaoValidaLote)  and (item_b('IN_KARDEX', tGER_OPERACAO)) then begin
      if (vDsLstItemLote = '') then begin
        Result := SetStatus(STS_ERROR, 'GEN0001', 'Lista de itens de lote não informada para o produto ' + FloatToStr(vCdProduto) + ' da transação ' + FloatToStr(vNrTransacao',) + ' Operação->TRASVCO004.gravaItemTransacao);
        return(-1); exit;
      end;
    end;

    vInBloqSaldoNeg := True;
    if (empty(tTMP_NR09) = False) then begin
      creocc(tTMP_NR09, -1);
      putitem_e(tTMP_NR09, 'NR_GERAL', item_f('CD_OPERACAO', tTRA_TRANSACAO));
      retrieve_o(tTMP_NR09);
      if (xStatus = 4) then begin
        vInBloqSaldoNeg := False;
      end else begin
        discard(tTMP_NR09);
      end;
    end;
    if (vInBloqSaldoNeg)  and (((gInBloqSaldoNeg = 1)  or %\ then begin
      (gInBloqSaldoNeg := 2 ) and (vInProdAcabado := True)  or 
      (gInBloqSaldoNeg := 3 ) and (vInMatPrima := True)  or 
      (gInBloqSaldoNeg := 4)  or 
      (gInBloqSaldoNeg := 5 ) and (vInProdAcabado := True)  or 
      (gInBloqSaldoNeg := 6 ) and (vInMatPrima := True))  and 
      (putitem_e(tTRA_TRANSACAO, 'TP_OPERACAO', 'S')  and
      (putitem_e(tGER_OPERACAO, 'IN_KARDEX', True ) or (item_b('IN_KARDEX', tGER_S_OPERACA), True)  and (vCdMPTer, '')  and (vCdServico, 0)));

      if (vInImpressao = True) then begin
      end else begin

        viParams := '';
        putitemXml(viParams, 'CD_GRUPOEMPRESA', item_f('CD_GRUPOEMPRESA', tGER_EMPRESA));
        putitemXml(viParams, 'CD_PRODUTO', vCdProduto);
        putitemXml(viParams, 'CD_OPERACAO', item_f('CD_OPERACAO', tTRA_TRANSACAO));
        putitemXml(viParams, 'IN_VALIDALOCAL', False);
        putitemXml(viParams, 'IN_TRANSACAO', vInTransacao);
        voParams := activateCmp('PRDSVCO015', 'verificaSaldoProduto', viParams); (*,,,, *)
        if (xStatus < 0) then begin
          Result := voParams;
          return(-1); exit;
        end;

        vQtDisponivel := itemXmlF('QT_DISPONIVEL', voParams);
        vQtEntrada := itemXmlF('QT_ENTRADA', voParams);
        vQtSaida := itemXmlF('QT_SAIDA', voParams);
        vQtEstoque := itemXmlF('QT_ESTOQUE', voParams);

        if ((item_f('QT_SOLICITADA', tTRA_TRANSITEM) - vQtSolicitadaAnt) > vQtDisponivel) then begin
          if (gInBloqSaldoNeg = 1)  or (gInBloqSaldoNeg = 2)  or (gInBloqSaldoNeg = 3) then begin
            Result := SetStatus(STS_ERROR, 'GEN0001', 'Quantidade ' + item_a('QT_SOLICITADA', tTRA_TRANSITEM) + ' do produto ' + FloatToStr(vCdProduto) + ' da transação ' + FloatToStr(vNrTransacao) + ' maior que disponível ' + vQtDisponivel + '!' + vQtEstoque + ' em estoque / ' + vQtEntrada + ' em entrada / ' + vQtSaida + ' em saída.', Operação->TRASVCO004.gravaItemTransacao);
            return(-1); exit;

          end else if (gInBloqSaldoNeg = 4)  or (gInBloqSaldoNeg = 5)  or (gInBloqSaldoNeg = 6) then begin
            vDsMensagem := 'Quantidade ' + item_a('QT_SOLICITADA', tTRA_TRANSITEM) + ' do produto ' + FloatToStr(vCdProduto) + ' da transação ' + FloatToStr(vNrTransacao) + ' maior que disponível ' + vQtDisponivel + '!' + vQtEstoque + ' em estoque / ' + vQtEntrada + ' em entrada / ' + vQtSaida + ' em saída.';

          end;
        end;
      end;
    end;
    if (item_f('VL_TOTALDESC', tTRA_TRANSITEM) > 0)  or (item_f('VL_TOTALDESCCAB', tTRA_TRANSITEM) > 0) then begin
      vVlDif := item_f('VL_TOTALBRUTO', tTRA_TRANSITEM) - (item_f('VL_TOTALLIQUIDO', tTRA_TRANSITEM) + item_f('VL_TOTALDESC', tTRA_TRANSITEM) + item_f('VL_TOTALDESCCAB', tTRA_TRANSITEM));

      if (vVlDif <> 0) then begin
        if (vQtArredondada = 0) then begin
          if (item_f('QT_SOLICITADA', tTRA_TRANSITEM) > 0) then begin
            vQtArredondada := item_f('QT_SOLICITADA', tTRA_TRANSITEM);
          end;
        end;
        if (item_f('VL_TOTALDESC', tTRA_TRANSITEM) > item_f('VL_TOTALDESCCAB', tTRA_TRANSITEM)) then begin
          putitem_e(tTRA_TRANSITEM, 'VL_TOTALDESC', item_f('VL_TOTALDESC', tTRA_TRANSITEM) + vVlDif);
          vVlCalc := item_f('VL_TOTALDESC', tTRA_TRANSITEM) / vQtArredondada;
          putitem_e(tTRA_TRANSITEM, 'VL_UNITDESC', rounded(vVlCalc, 6));
        end else begin
          putitem_e(tTRA_TRANSITEM, 'VL_TOTALDESCCAB', item_f('VL_TOTALDESCCAB', tTRA_TRANSITEM) + vVlDif);
          vVlCalc := item_f('VL_TOTALDESCCAB', tTRA_TRANSITEM) / vQtArredondada;
          putitem_e(tTRA_TRANSITEM, 'VL_UNITDESCCAB', rounded(vVlCalc, 6));
        end;
      end;
    end;
    if (item_f('TP_OPERACAO', tGER_OPERACAO) = 'S')  and (item_f('TP_MODALIDADE', tGER_OPERACAO) = 4) then begin
      vInVenda := True;
    end else begin
      vInVenda := False;
    end;
    if (itemXml('TP_ARREDOND_VL_UNIT_VD', PARAM_GLB) = 1)  or (itemXml('TP_ARREDOND_VL_UNIT_VD', PARAM_GLB) = 2)  and (vInVenda = True) then begin
      if (item_f('QT_SOLICITADA', tTRA_TRANSITEM) > 0) then begin
        if (item_f('VL_UNITDESC', tTRA_TRANSITEM) > 0)  or (item_f('VL_UNITDESCCAB', tTRA_TRANSITEM) > 0) then begin
          vVlDifUnitario := item_f('VL_UNITBRUTO', tTRA_TRANSITEM) - (item_f('VL_UNITLIQUIDO', tTRA_TRANSITEM) + item_f('VL_UNITDESC', tTRA_TRANSITEM) + item_f('VL_UNITDESCCAB', tTRA_TRANSITEM));
          if (vVlDifUnitario <> 0) then begin
            if (item_f('VL_UNITDESC', tTRA_TRANSITEM) > item_f('VL_UNITDESCCAB', tTRA_TRANSITEM)) then begin
              putitem_e(tTRA_TRANSITEM, 'VL_UNITDESC', item_f('VL_UNITDESC', tTRA_TRANSITEM) + vVlDifUnitario);
            end else begin
              putitem_e(tTRA_TRANSITEM, 'VL_UNITDESCCAB', item_f('VL_UNITDESCCAB', tTRA_TRANSITEM) + vVlDifUnitario);
            end;
          end;
        end;
        if (itemXml('TP_ARREDOND_VL_UNIT_VD', PARAM_GLB) = 1) then begin
          vVlCalc := rounded(item_f('VL_UNITBRUTO', tTRA_TRANSITEM), 2);
          putitem_e(tTRA_TRANSITEM, 'VL_UNITBRUTO', vVlCalc);

          vVlCalc := item_f('VL_UNITBRUTO', tTRA_TRANSITEM) * item_f('QT_SOLICITADA', tTRA_TRANSITEM);
          putitem_e(tTRA_TRANSITEM, 'VL_TOTALBRUTO', rounded(vVlCalc, 2));
          putitem_e(tTRA_TRANSITEM, 'VL_TOTALLIQUIDO', item_f('VL_TOTALBRUTO', tTRA_TRANSITEM) - (item_f('VL_TOTALDESCCAB', tTRA_TRANSITEM) + item_f('VL_TOTALDESC', tTRA_TRANSITEM)));

          vVlCalc := item_f('VL_TOTALLIQUIDO', tTRA_TRANSITEM) /  item_f('QT_SOLICITADA', tTRA_TRANSITEM);
          putitem_e(tTRA_TRANSITEM, 'VL_UNITLIQUIDO', rounded(vVlCalc, 6));

        end else if (itemXml('TP_ARREDOND_VL_UNIT_VD', PARAM_GLB) = 2) then begin
          vVlCalc := rounded(item_f('VL_UNITBRUTO', tTRA_TRANSITEM), 2);
          putitem_e(tTRA_TRANSITEM, 'VL_UNITBRUTO', vVlCalc);

          vVlCalc := item_f('VL_UNITBRUTO', tTRA_TRANSITEM) * item_f('QT_SOLICITADA', tTRA_TRANSITEM);
          vVlInteiro := int(vVlCalc);
          vVlFracionado := vVlCalc[fraction];
          vVlFracionado := vVlFracionado[1:4];
          vVlCalc := vVlInteiro + vVlFracionado;
          putitem_e(tTRA_TRANSITEM, 'VL_TOTALBRUTO', vVlCalc);
          putitem_e(tTRA_TRANSITEM, 'VL_TOTALLIQUIDO', item_f('VL_TOTALBRUTO', tTRA_TRANSITEM) - (item_f('VL_TOTALDESCCAB', tTRA_TRANSITEM) + item_f('VL_TOTALDESC', tTRA_TRANSITEM)));

          vVlCalc := item_f('VL_TOTALLIQUIDO', tTRA_TRANSITEM) /  item_f('QT_SOLICITADA', tTRA_TRANSITEM);
          putitem_e(tTRA_TRANSITEM, 'VL_UNITLIQUIDO', rounded(vVlCalc, 6));
        end;
      end;
    end;

    vCdCustoVenda := itemXmlF('CD_CUSTO_VALIDA_VendA', xParamEmp);
      if (item_f('TP_OPERACAO', tGER_OPERACAO) = 'S')  and (item_f('TP_MODALIDADE', tGER_OPERACAO) = 4)  and (vCdCustoVenda <> 0) then begin
      viListas := '';
      viParams := '';
      putitemXml(viParams, 'CD_EMPRESA', item_f('CD_EMPRESA', tTRA_TRANSACAO));
      putitemXml(viParams, 'CD_PRODUTO', vCdProduto);
      putitemXml(viParams, 'TP_VALOR', 'C');
      putitemXml(viParams, 'CD_VALOR', vCdCustoVenda);
      voParams := activateCmp('PRDSVCO007', 'buscaValorData', viParams); (*,,viListas,,, *)
      if (xStatus < 0) then begin
        Result := voParams;
        return(-1); exit;
      end;

      vVlUnitCustoVenda := itemXmlF('VL_VALOR', voParams);

      if (vVlUnitCustoVenda > item_f('VL_UNITLIQUIDO', tTRA_TRANSITEM)) then begin
        Result := SetStatus(STS_ERROR, 'GEN0001', 'Valor de venda menor que o valor de custo. Parâmetro CD_CUSTO_VALIDA_VendA!', Operação->TRASVCO004.gravaItemTransacao);
        return(-1); exit;
      end;
    end;
    if (item_f('VL_UNITBRUTO', tTRA_TRANSITEM) < 0) then begin
      Result := SetStatus(STS_ERROR, 'GEN0001', 'VL_UNITBRUTO do item ' + item_a('NR_ITEM', tTRA_TRANSITEM) + ' não pode ser negativo!', Operação->TRASVCO004.gravaItemTransacao);
      return(-1); exit;
    end else if (item_f('VL_UNITDESC', tTRA_TRANSITEM) < 0) then begin
      Result := SetStatus(STS_ERROR, 'GEN0001', 'VL_UNITDESC do item ' + item_a('NR_ITEM', tTRA_TRANSITEM) + ' não pode ser negativo!', Operação->TRASVCO004.gravaItemTransacao);
      return(-1); exit;
    end else if (item_f('VL_UNITLIQUIDO', tTRA_TRANSITEM) < 0) then begin
      Result := SetStatus(STS_ERROR, 'GEN0001', 'VL_UNITLIQUIDO do item ' + item_a('NR_ITEM', tTRA_TRANSITEM) + ' não pode ser negativo!', Operação->TRASVCO004.gravaItemTransacao);
      return(-1); exit;
    end else if (item_f('VL_TOTALBRUTO', tTRA_TRANSITEM) < 0) then begin
      Result := SetStatus(STS_ERROR, 'GEN0001', 'VL_TOTALBRUTO do item ' + item_a('NR_ITEM', tTRA_TRANSITEM) + ' não pode ser negativo!', Operação->TRASVCO004.gravaItemTransacao);
      return(-1); exit;
    end else if (item_f('VL_TOTALDESC', tTRA_TRANSITEM) < 0) then begin
      Result := SetStatus(STS_ERROR, 'GEN0001', 'VL_TOTALDESC do item ' + item_a('NR_ITEM', tTRA_TRANSITEM) + ' não pode ser negativo!', Operação->TRASVCO004.gravaItemTransacao);
      return(-1); exit;
    end else if (item_f('VL_TOTALLIQUIDO', tTRA_TRANSITEM) < 0) then begin
      Result := SetStatus(STS_ERROR, 'GEN0001', 'VL_TOTALLIQUIDO do item ' + item_a('NR_ITEM', tTRA_TRANSITEM) + ' não pode ser negativo!', Operação->TRASVCO004.gravaItemTransacao);
      return(-1); exit;
    end;
    if (item_f('QT_SOLICITADA', tTRA_TRANSITEM) > 0 ) and (item_f('VL_UNITBRUTO', tTRA_TRANSITEM) > 0 ) and (item_f('VL_UNITLIQUIDO', tTRA_TRANSITEM) > 0) then begin
      if (item_f('VL_TOTALBRUTO', tTRA_TRANSITEM) = 0) then begin
        putitem_e(tTRA_TRANSITEM, 'VL_TOTALBRUTO', 0.01);
      end;
      if (item_f('VL_TOTALLIQUIDO', tTRA_TRANSITEM) = 0) then begin
        putitem_e(tTRA_TRANSITEM, 'VL_TOTALLIQUIDO', 0.01);
      end;
    end;
    if (vDsLstImposto = '') then begin
      viParams := '';
      putitemXml(viParams, 'CD_EMPRESA', item_f('CD_EMPFAT', tTRA_TRANSACAO));
      putitemXml(viParams, 'UF_DESTINO', item_a('DS_SIGLAESTADO', tV_PES_ENDEREC));
      putitemXml(viParams, 'TP_ORIGEMEMISSAO', item_f('TP_ORIGEMEMISSAO', tTRA_TRANSACAO));
      putitemXml(viParams, 'CD_PRODUTO', item_f('CD_PRODUTO', tTRA_TRANSITEM));
      putitemXml(viParams, 'CD_MPTER', vCdMPTer);
      putitemXml(viParams, 'CD_SERVICO', vCdServico);
      putitemXml(viParams, 'CD_OPERACAO', item_f('CD_OPERACAO', tGER_OPERACAO));
      putitemXml(viParams, 'CD_PESSOA', item_f('CD_PESSOA', tTRA_TRANSACAO));
      putitemXml(viParams, 'CD_CST', item_f('CD_CST', tTRA_TRANSITEM));
      putitemXml(viParams, 'VL_TOTALBRUTO', item_f('VL_TOTALBRUTO', tTRA_TRANSITEM));
      putitemXml(viParams, 'VL_TOTALLIQUIDO', item_f('VL_TOTALLIQUIDO', tTRA_TRANSITEM));
      putitemXml(viParams, 'PR_IPI', itemXmlF('PR_IPI', pParams));
      putitemXml(viParams, 'VL_IPI', itemXmlF('VL_IPI', pParams));
      putitemXml(viParams, 'DT_INIVIGENCIA', item_a('DT_TRANSACAO', tTRA_TRANSACAO));
      voParams := activateCmp('FISSVCO015', 'calculaImpostoItem', viParams); (*,,,, *)
      if (xStatus < 0) then begin
        Result := voParams;
        return(-1); exit;
      end;

      vDsLstImposto := itemXml('DS_LSTIMPOSTO', voParams);
      vCdCST := itemXmlF('CD_CST', voParams);
      vCdDecreto := itemXmlF('CD_DECRETO', voParams);
    end;
    if (vDsLstImposto <> '') then begin
      repeat
        getitem(vDsRegistro, vDsLstImposto, 1);

        vCdImposto := itemXmlF('CD_IMPOSTO', vDsRegistro);
        if (vCdImposto > 0) then begin
          delitem(vDsRegistro, 'CD_EMPRESA');
          delitem(vDsRegistro, 'NR_TRANSACAO');
          delitem(vDsRegistro, 'DT_TRANSACAO');
          delitem(vDsRegistro, 'NR_ITEM');
          creocc(tTRA_ITEMIMPOS, -1);
          getlistitensocc_e(vDsRegistro, tTRA_ITEMIMPOS);
          putitem_e(tTRA_ITEMIMPOS, 'CD_EMPFAT', item_f('CD_EMPFAT', tTRA_TRANSACAO));
          putitem_e(tTRA_ITEMIMPOS, 'CD_GRUPOEMPRESA', item_f('CD_GRUPOEMPRESA', tTRA_TRANSACAO));
          putitem_e(tTRA_ITEMIMPOS, 'CD_OPERADOR', itemXmlF('CD_USUARIO', PARAM_GLB));
          putitem_e(tTRA_ITEMIMPOS, 'DT_CADASTRO', Now);

        end;

        delitem(vDsLstImposto, 1);
      until (vDsLstImposto = '');
    end;
    if (vCdCST <> '') then begin
      putitem_e(tTRA_TRANSITEM, 'CD_CST', vCdCST);
    end;
    if (vCdDecreto > 0) then begin
      putitem_e(tTRA_TRANSITEM, 'CD_DECRETO', vCdDecreto);
    end;

    vVlCalc := (item_f('VL_TOTALDESC', tTRA_TRANSITEM) + item_f('VL_TOTALDESCCAB', tTRA_TRANSITEM)) / item_f('VL_TOTALBRUTO', tTRA_TRANSITEM) * 100;
    putitem_e(tTRA_TRANSITEM, 'PR_DESCONTO', rounded(vVlCalc, 6));

    if (item_f('PR_DESCONTO', tTRA_TRANSITEM) <> 0) then begin
      putitem_e(tTRA_TRANSITEM, 'IN_DESCONTO', True);
    end else begin
      putitem_e(tTRA_TRANSITEM, 'IN_DESCONTO', False);
    end;
  end;

  putitem_e(tTRA_TRANSITEM, 'CD_EMPFAT', item_f('CD_EMPFAT', tTRA_TRANSACAO));
  putitem_e(tTRA_TRANSITEM, 'CD_GRUPOEMPRESA', item_f('CD_GRUPOEMPRESA', tTRA_TRANSACAO));
  putitem_e(tTRA_TRANSITEM, 'CD_OPERADOR', itemXmlF('CD_USUARIO', PARAM_GLB));
  putitem_e(tTRA_TRANSITEM, 'DT_CADASTRO', Now);

  voParams := tTRA_TRANSITEM.Salvar();
  if (xStatus < 0) then begin
    Result := voParams;
    return(-1); exit;
  end;
  if (item_f('CD_PRODUTO', tTRA_TRANSITEM) = 0)  and (item_f('TP_DOCTO', tGER_OPERACAO) = 1) then begin
    vNrDescItem := glength(item_a('DS_PRODUTO', tTRA_TRANSITEM));
    clear_e(tTRA_TRANSITEM);
    putitem_o(tTRA_TRANSITEM, 'CD_EMPRESA', vCdEmpresa);
    putitem_o(tTRA_TRANSITEM, 'NR_TRANSACAO', vNrTransacao);
    putitem_o(tTRA_TRANSITEM, 'DT_TRANSACAO', vDtTransacao);
    putitem_o(tTRA_TRANSITEM, 'NR_ITEM', '<' + FloatToStr(vNrItem') + ');
    retrieve_e(tTRA_TRANSITEM);
    if (xStatus >= 0) then begin
      sort_e(tTRA_TRANSITEM, '      sort/e , NR_ITEM:d;');
      setocc(tTRA_TRANSITEM, 1);
      while(xStatus >= 0) do begin
        if (item_f('CD_PRODUTO', tTRA_TRANSITEM) = 0) then begin
          vNr := glength(item_a('DS_PRODUTO', tTRA_TRANSITEM));
          vNrDescItem := vNrDescItem + vNr;
        end else begin
          break;
        end;
        setocc(tTRA_TRANSITEM, curocc(tTRA_TRANSITEM) + 1);
      end;
    end;
    if (vNrDescItem > 500) then begin
      Result := SetStatus(STS_ERROR, 'GEN0001', 'Item ' + item_a('NR_ITEM', tTRA_TRANSITEM) + ' da transação ' + FloatToStr(vNrTransacao) + ' possui itens descritivos com tamanho superior a 500 caracteres!', Operação->TRASVCO004.gravaItemTransacao);
      return(-1); exit;
    end;
  end;
  if (vVlBase > 0)  and (vVlOriginal > 0) then begin
    viParams := '';
    putitemXml(viParams, 'CD_EMPRESA', item_f('CD_EMPRESA', tTRA_TRANSITEM));
    putitemXml(viParams, 'NR_TRANSACAO', item_f('NR_TRANSACAO', tTRA_TRANSITEM));
    putitemXml(viParams, 'DT_TRANSACAO', item_a('DT_TRANSACAO', tTRA_TRANSITEM));
    putitemXml(viParams, 'NR_ITEM', item_f('NR_ITEM', tTRA_TRANSITEM));
    putitemXml(viParams, 'VL_BASE', vVlBase);
    putitemXml(viParams, 'VL_ORIGINAL', vVlOriginal);
    voParams := activateCmp('TRASVCO024', 'gravaTraItemAdic', viParams); (*,,,, *)
    if (xStatus < 0) then begin
      Result := voParams;
      return(-1); exit;
    end;
  end;
  if (vTpLote > 0)  and (vDsLstItemLote <> '')  and (!vInNaoValidaLote) then begin
    viParams := '';
    putitemXml(viParams, 'CD_EMPRESA', item_f('CD_EMPRESA', tTRA_TRANSITEM));
    putitemXml(viParams, 'NR_TRANSACAO', item_f('NR_TRANSACAO', tTRA_TRANSITEM));
    putitemXml(viParams, 'DT_TRANSACAO', item_a('DT_TRANSACAO', tTRA_TRANSITEM));
    putitemXml(viParams, 'NR_ITEM', item_f('NR_ITEM', tTRA_TRANSITEM));
    putitemXml(viParams, 'DS_LSTITEMLOTE', vDsLstItemLote);
    putitemXml(viParams, 'IN_SEMMOVIMENTO', vInSemMovimento);
    voParams := activateCmp('TRASVCO016', 'gravaItemLote', viParams); (*,,,, *)
    if (xStatus < 0) then begin
      Result := voParams;
      return(-1); exit;
    end;
  end;
  if (vInTotal = True) then begin
    voParams := calculaTotalOtimizado(viParams); (* *)
    if (xStatus < 0) then begin
      Result := voParams;
      return(-1); exit;
    end;
    if (gInGravaTraBloq = True) then begin
      putitem_e(tTRA_TRANSACAO, 'TP_SITUACAO', 8);
    end;
    voParams := tTRA_TRANSACAO.Salvar();
    if (xStatus < 0) then begin
      Result := voParams;
      return(-1); exit;
    end;
  end;
  if ((item_f('TP_OPERACAO', tGER_OPERACAO) = 'E')  and (item_f('TP_MODALIDADE', tGER_OPERACAO) = 4 ) or (item_f('TP_MODALIDADE', tGER_OPERACAO) = 2))  or (item_f('CD_OPERACAO', tGER_OPERACAO) = gCdOperacaoOI) then begin
  end else begin
    if (gDsLstValorVenda <> '')  and (item_f('CD_ESPECIE', tTRA_TRANSITEM) <> gCdEspecieServico)  and (item_f('CD_PRODUTO', tTRA_TRANSITEM) > 0) then begin
      viParams := '';
      putitemXml(viParams, 'DS_LSTVALOR', gDsLstValorVenda);
      putitemXml(viParams, 'CD_EMPRESA', item_f('CD_EMPRESA', tTRA_TRANSACAO));
      putitemXml(viParams, 'NR_TRANSACAO', item_f('NR_TRANSACAO', tTRA_TRANSACAO));
      putitemXml(viParams, 'DT_TRANSACAO', item_a('DT_TRANSACAO', tTRA_TRANSACAO));
      putitemXml(viParams, 'NR_ITEM', vNrItem);
      putitemXml(viParams, 'CD_PRODUTO', item_f('CD_PRODUTO', tTRA_TRANSITEM));
      putitemXml(viParams, 'CD_EMPFAT', item_f('CD_EMPFAT', tTRA_TRANSACAO));
      putitemXml(viParams, 'CD_GRUPOEMPRESA', item_f('CD_GRUPOEMPRESA', tTRA_TRANSACAO));
      voParams := activateCmp('TRASVCO016', 'gravaItemValor', viParams); (*,,,, *)
      if (xStatus < 0) then begin
        Result := voParams;
        return(-1); exit;
      end;
      vDsLstValorVenda := itemXml('DS_LSTVALORVendA', voParams);
    end;
  end;

  gHrFim := gclock;
  gHrTempo := gHrFim - gHrInicio;

  Result := '';
  putitemXml(Result, 'CD_EMPRESA', vCdEmpresa);
  putitemXml(Result, 'NR_TRANSACAO', vNrTransacao);
  putitemXml(Result, 'DT_TRANSACAO', vDtTransacao);
  putitemXml(Result, 'NR_ITEM', vNrItem);
  putitemXml(Result, 'DS_LSTVALORVendA', vDsLstValorVenda);
  putitemXml(Result, 'DS_MENSAGEM', vDsMensagem);

  return(0); exit;
end;

//---------------------------------------------------------------------
function T_TRASVCO004.gravaParcelaTransacao(pParams : String) : String;
//---------------------------------------------------------------------
const
  cDS_METHOD = 'ADICIONAL=Operação: T_TRASVCO004.gravaParcelaTransacao()';
var
  viParams, voParams : String;
begin
  viParams := pParams;

  voParams := activateCmp('TRASVCO024', 'gravaParcelaTransacao', viParams); (*,,,, *)
  if (xStatus < 0) then begin
    Result := voParams;
    return(-1); exit;
  end;

  return(0); exit;
end;

//-------------------------------------------------------------------
function T_TRASVCO004.gravaTotalTransacao(pParams : String) : String;
//-------------------------------------------------------------------
const
  cDS_METHOD = 'ADICIONAL=Operação: T_TRASVCO004.gravaTotalTransacao()';
var
  vDsRegistro, vDsLstTransacao : String;
  vCdEmpresa, vNrTransacao : Real;
  vDtTransacao : TDate;
begin
  PARAM_GLB := PARAM_GLB;
  vDsLstTransacao := itemXml('DS_LSTTRANSACAO', pParams);

  if (vDsLstTransacao = '') then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Lista de transação não informada!', Operação->TRASVCO004.gravaTotalTransacao);
    return(-1); exit;
  end;

  clear_e(tTRA_TRANSACAO);

  repeat
    getitem(vDsRegistro, vDsLstTransacao, 1);
    vCdEmpresa := itemXmlF('CD_EMPRESA', vDsRegistro);
    vNrTransacao := itemXmlF('NR_TRANSACAO', vDsRegistro);
    vDtTransacao := itemXml('DT_TRANSACAO', vDsRegistro);

    if (vCdEmpresa = 0) then begin
      Result := SetStatus(STS_ERROR, 'GEN0001', 'Empresa não informada!', Operagão->TRASVCO004.gravaTotalTransacao);
      return(-1); exit;
    end;
    if (vNrTransacao = 0) then begin
      Result := SetStatus(STS_ERROR, 'GEN0001', 'Número da transação não informado!', Operação->TRASVCO004.gravaTotalTransacao);
      return(-1); exit;
    end;
    if (vDtTransacao = '') then begin
      Result := SetStatus(STS_ERROR, 'GEN0001', 'Data transação não informada!', Operaçco->TRASVCO004.gravaTotalTransacao);
      return(-1); exit;
    end;

    creocc(tTRA_TRANSACAO, -1);
    putitem_o(tTRA_TRANSACAO, 'CD_EMPRESA', vCdEmpresa);
    putitem_o(tTRA_TRANSACAO, 'NR_TRANSACAO', vNrTransacao);
    putitem_o(tTRA_TRANSACAO, 'DT_TRANSACAO', vDtTransacao);
    retrieve_o(tTRA_TRANSACAO);
    if (xStatus = -7) then begin
      retrieve_x(tTRA_TRANSACAO);
    end else if (xStatus = 0) then begin
      Result := SetStatus(STS_ERROR, 'GEN0001', 'Transação ' + FloatToStr(vNrTransacao) + ' não cadastrada!', Operação->TRASVCO004.gravaTotalTransacao);
      return(-1); exit;
    end;

    voParams := getParam(viParams); (* pParams *) (viParams); (* * item_f('CD_EMPFAT', tTRA_TRANSACAO) *)
    if (xStatus < 0) then begin
      return(-1); exit;
    end;

    voParams := calculaTotalTransacao(viParams); (* *)
    if (xStatus < 0) then begin
      Result := voParams;
      return(-1); exit;
    end;

    putitem_e(tTRA_TRANSACAO, 'CD_OPERADOR', itemXmlF('CD_USUARIO', PARAM_GLB));
    putitem_e(tTRA_TRANSACAO, 'DT_CADASTRO', Now);

    delitem(vDsLstTransacao, 1);
  until (vDsLstTransacao = '');

  voParams := tTRA_TRANSACAO.Salvar();
  if (xStatus < 0) then begin
    Result := voParams;
    return(-1); exit;
  end;
  if (empty(tTRA_TRANSACAO) = False) then begin
    setocc(tTRA_TRANSACAO, 1);
    while (xStatus >=0) do begin
      clear_e(tV_TRA_TOTATRA);
      putitem_o(tV_TRA_TOTATRA, 'CD_EMPRESA', item_f('CD_EMPRESA', tTRA_TRANSACAO));
      putitem_o(tV_TRA_TOTATRA, 'NR_TRANSACAO', item_f('NR_TRANSACAO', tTRA_TRANSACAO));
      putitem_o(tV_TRA_TOTATRA, 'DT_TRANSACAO', item_a('DT_TRANSACAO', tTRA_TRANSACAO));
      retrieve_e(tV_TRA_TOTATRA);
      if (xStatus < 0) then begin
        clear_e(tV_TRA_TOTATRA);
      end;
      if (item_f('QT_TOTALITEM', tV_TRA_TOTATRA) <> item_f('QT_SOLICITADA', tV_TRA_TOTATRA)) then begin
        Result := SetStatus(STS_ERROR, 'GEN0001', 'Totalização de valor da transação ' + FloatToStr(vNrTransacao) + ' divergente. Capa: ' + item_a('QT_SOLICITADA', tV_TRA_TOTATRA) + ' Items: ' + item_a('QT_TOTALITEM', tV_TRA_TOTATRA) + ' !', Operação->TRASVCO004.gravaTotalTransacao);
        return(-1); exit;
      end;
      if (item_f('VL_TOTALITEM', tV_TRA_TOTATRA) <> item_f('VL_TRANSACAO', tV_TRA_TOTATRA)) then begin
        Result := SetStatus(STS_ERROR, 'GEN0001', 'Totalização de valor da transação ' + FloatToStr(vNrTransacao) + ' divergente. Capa: ' + item_a('VL_TRANSACAO', tV_TRA_TOTATRA) + ' Items: ' + item_a('VL_TOTALITEM', tV_TRA_TOTATRA) + ' !', Operação->TRASVCO004.gravaTotalTransacao);
        return(-1); exit;
      end;
      setocc(tTRA_TRANSACAO, curocc(tTRA_TRANSACAO) + 1);
    end;
  end;

  return(0); exit;
end;

//-----------------------------------------------------------------------
function T_TRASVCO004.alteraSituacaoTransacao(pParams : String) : String;
//-----------------------------------------------------------------------
const
  cDS_METHOD = 'ADICIONAL=Operação: T_TRASVCO004.alteraSituacaoTransacao()';
var
  vDsRegistro, vDsLstTransacao, vCdComponente, vDsMotivoAlt, viParams, voParams : String;
  vCdEmpresa, vNrTransacao, vTpSituacao, vTpSituacaoAnt, vNrSequencia, vCdMotivoBloq, vCdMotivoBloqAnt, vNrDiasAtraso : Real;
  vDtTransacao : TDate;
  vInValidaNF : Boolean;
begin
  PARAM_GLB := PARAM_GLB;
  vDsLstTransacao := itemXml('DS_LSTTRANSACAO', pParams);
  vTpSituacao := itemXmlF('TP_SITUACAO', pParams);
  vDsMotivoAlt := itemXml('DS_MOTIVOALT', pParams);
  vCdComponente := itemXmlF('CD_COMPONENTE', pParams);
  vCdMotivoBloq := itemXmlF('CD_MOTIVOBLOQ', pParams);
  vInValidaNF := itemXmlB('IN_VALIDANF', pParams);
  if (vCdComponente = '') then begin
    vCdComponente := 'TRASVCO004';
  end;
  if (vInValidaNF = '') then begin
    vInValidaNF := True;
  end;
  if (vDsLstTransacao = '') then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Lista de transação não informada!', Operação->TRASVCO004.alteraSituacaoTransacao);
    return(-1); exit;
  end;
  if (vTpSituacao = 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Situação não informada!', Operação->TRASVCO004.alteraSituacaoTransacao);
    return(-1); exit;
  end;
  if (vTpSituacao < 0)  or (vTpSituacao > 10) then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Situação ' + FloatToStr(vTpSituacao) + ' inválida!', Operação->TRASVCO004.alteraSituacaoTransacao);
    return(-1); exit;
  end;

  clear_e(tTRA_TRANSACAO);

  repeat
    getitem(vDsRegistro, vDsLstTransacao, 1);
    vCdEmpresa := itemXmlF('CD_EMPRESA', vDsRegistro);
    vNrTransacao := itemXmlF('NR_TRANSACAO', vDsRegistro);
    vDtTransacao := itemXml('DT_TRANSACAO', vDsRegistro);

    if (vCdEmpresa = 0) then begin
      Result := SetStatus(STS_ERROR, 'GEN0001', 'Empresa não informada!', Operação->TRASVCO004.alteraSituacaoTransacao);
      return(-1); exit;
    end;
    if (vNrTransacao = 0) then begin
      Result := SetStatus(STS_ERROR, 'GEN0001', 'Número da transação não informado!', Operação->TRASVCO004.alteraSituacaoTransacao);
      return(-1); exit;
    end;
    if (vDtTransacao = '') then begin
      Result := SetStatus(STS_ERROR, 'GEN0001', 'Data transação não informada!', Operação->TRASVCO004.alteraSituacaoTransacao);
      return(-1); exit;
    end;

    creocc(tTRA_TRANSACAO, -1);
    putitem_o(tTRA_TRANSACAO, 'CD_EMPRESA', vCdEmpresa);
    putitem_o(tTRA_TRANSACAO, 'NR_TRANSACAO', vNrTransacao);
    putitem_o(tTRA_TRANSACAO, 'DT_TRANSACAO', vDtTransacao);
    retrieve_o(tTRA_TRANSACAO);
    if (xStatus = -7) then begin
      retrieve_x(tTRA_TRANSACAO);
    end else if (xStatus = 0) then begin
      Result := SetStatus(STS_ERROR, 'GEN0001', 'Transação ' + FloatToStr(vNrTransacao) + ' não cadastrada!', Operagão->TRASVCO004.alteraSituacaoTransacao);
      return(-1); exit;
    end;
    if (vTpSituacao = 4)  and (vInValidaNF = True) then begin
      viParams := '';
      putitemXml(viParams, 'CD_EMPRESA', item_f('CD_EMPRESA', tTRA_TRANSACAO));
      putitemXml(viParams, 'NR_TRANSACAO', item_f('NR_TRANSACAO', tTRA_TRANSACAO));
      putitemXml(viParams, 'DT_TRANSACAO', item_a('DT_TRANSACAO', tTRA_TRANSACAO));
      voParams := activateCmp('TRASVCO012', 'validaNFTransacao', viParams); (*,,,, *)
      if (xStatus < 0) then begin
        Result := voParams;
        return(-1); exit;
      end;
    end;

    vTpSituacaoAnt := item_f('TP_SITUACAO', tTRA_TRANSACAO);

    if (empty(tTRA_TRANSACSI) = False) then begin
      setocc(tTRA_TRANSACSI, -1);
      vCdMotivoBloqAnt := item_f('CD_MOTIVOBLOQ', tTRA_TRANSACSI);
    end;

    putitem_e(tTRA_TRANSACAO, 'TP_SITUACAO', vTpSituacao);
    putitem_e(tTRA_TRANSACAO, 'DT_ULTATEND', itemXml('DT_SISTEMA', PARAM_GLB));
    putitem_e(tTRA_TRANSACAO, 'CD_OPERADOR', itemXmlF('CD_USUARIO', PARAM_GLB));
    putitem_e(tTRA_TRANSACAO, 'DT_CADASTRO', Now);

    viParams := '';
    putitemXml(viParams, 'NM_ENTIDADE', 'TRA_TRANSACSIT');
    voParams := activateCmp('GERSVCO031', 'getNumSeq', viParams); (*,,,, *)
    if (xStatus < 0) then begin
      Result := voParams;
      return(-1); exit;
    end;

    vNrSequencia := itemXmlF('NR_SEQUENCIA', voParams);

    creocc(tTRA_TRANSACSI, -1);
    putitem_e(tTRA_TRANSACSI, 'DT_MOVIMENTO', itemXml('DT_SISTEMA', PARAM_GLB));
    putitem_e(tTRA_TRANSACSI, 'NR_SEQUENCIA', vNrSequencia);
    putitem_e(tTRA_TRANSACSI, 'TP_SITUACAOANT', vTpSituacaoAnt);
    putitem_e(tTRA_TRANSACSI, 'TP_SITUACAO', vTpSituacao);
    putitem_e(tTRA_TRANSACSI, 'CD_MOTIVOBLOQ', vCdMotivoBloq);
    putitem_e(tTRA_TRANSACSI, 'DS_MOTIVOALT', vDsMotivoAlt);
    putitem_e(tTRA_TRANSACSI, 'CD_OPERADOR', itemXmlF('CD_USUARIO', PARAM_GLB));
    putitem_e(tTRA_TRANSACSI, 'DT_CADASTRO', Now);
    putitem_e(tTRA_TRANSACSI, 'CD_COMPONENTE', vCdComponente);

    if (vTpSituacaoAnt = 8) then begin
      if (vCdMotivoBloqAnt = 3) then begin
        viParams := '';
        putitemXml(viParams, 'CD_EMPRESA', item_f('CD_EMPRESA', tTRA_TRANSACAO));
        putitemXml(viParams, 'NR_TRANSACAO', item_f('NR_TRANSACAO', tTRA_TRANSACAO));
        putitemXml(viParams, 'DT_TRANSACAO', item_a('DT_TRANSACAO', tTRA_TRANSACAO));
        putitemXml(viParams, 'CD_LIBERADOR', itemXmlF('CD_USUARIO', PARAM_GLB));
        putitemXml(viParams, 'TP_LIBERACAO', 1);
        voParams := activateCmp('TRASVCO016', 'gravaLiberacaoTransacao', viParams); (*,,,, *)
        if (xStatus < 0) then begin
          Result := voParams;
          return(-1); exit;
        end;
      end else if (vCdMotivoBloqAnt = 4) then begin
        viParams := '';
        putitemXml(viParams, 'CD_CLIENTE', item_f('CD_PESSOA', tTRA_TRANSACAO));
        putitemXml(viParams, 'IN_TOTAL', True);
        voParams := activateCmp('FCRSVCO015', 'buscaLimiteCliente', viParams); (*,,,, *)
        if (xStatus < 0) then begin
          Result := voParams;
          return(-1); exit;
        end;

        vNrDiasAtraso := itemXmlF('NR_DIAVENCTO', voParams);

        if (vNrDiasAtraso > 0) then begin
          viParams := '';
          putitemXml(viParams, 'CD_EMPRESA', item_f('CD_EMPRESA', tTRA_TRANSACAO));
          putitemXml(viParams, 'NR_TRANSACAO', item_f('NR_TRANSACAO', tTRA_TRANSACAO));
          putitemXml(viParams, 'DT_TRANSACAO', item_a('DT_TRANSACAO', tTRA_TRANSACAO));
          putitemXml(viParams, 'CD_LIBERADOR', itemXmlF('CD_USUARIO', PARAM_GLB));
          putitemXml(viParams, 'TP_LIBERACAO', 2);
          putitemXml(viParams, 'NR_DIAATRASO', vNrDiasAtraso);
          voParams := activateCmp('TRASVCO016', 'gravaLiberacaoTransacao', viParams); (*,,,, *)
          if (xStatus < 0) then begin
            Result := voParams;
            return(-1); exit;
          end;
        end;
      end;
    end;

    delitem(vDsLstTransacao, 1);
  until (vDsLstTransacao = '');

  voParams := tTRA_TRANSACAO.Salvar();
  if (xStatus < 0) then begin
    Result := voParams;
    return(-1); exit;
  end;

  return(0); exit;
end;

//------------------------------------------------------------------------
function T_TRASVCO004.atualizaEstoqueTransacao(pParams : String) : String;
//------------------------------------------------------------------------
const
  cDS_METHOD = 'ADICIONAL=Operação: T_TRASVCO004.atualizaEstoqueTransacao()';
var
  viParams, voParams, vDsRegistro, vDsLstTransacao : String;
  vCdEmpresa, vNrTransacao : Real;
  vDtTransacao : TDate;
  vInEstorno, vInKardex : Boolean;
begin
  PARAM_GLB := PARAM_GLB;
  vDsLstTransacao := itemXml('DS_LSTTRANSACAO', pParams);
  vInEstorno := itemXmlB('IN_ESTORNO', pParams);

  if (vDsLstTransacao = '') then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Lista de transação não informada!', Operação->TRASVCO004.atualizaEstoqueTransacao);
    return(-1); exit;
  end;

  repeat
    getitem(vDsRegistro, vDsLstTransacao, 1);
    vCdEmpresa := itemXmlF('CD_EMPRESA', vDsRegistro);
    vNrTransacao := itemXmlF('NR_TRANSACAO', vDsRegistro);
    vDtTransacao := itemXml('DT_TRANSACAO', vDsRegistro);

    if (vCdEmpresa = 0) then begin
      Result := SetStatus(STS_ERROR, 'GEN0001', 'Empresa não informada!', Operação->TRASVCO004.atualizaEstoqueTransacao);
      return(-1); exit;
    end;
    if (vNrTransacao = 0) then begin
      Result := SetStatus(STS_ERROR, 'GEN0001', 'Número da transação não informado!', Operaçco->TRASVCO004.atualizaEstoqueTransacao);
      return(-1); exit;
    end;
    if (vDtTransacao = '') then begin
      Result := SetStatus(STS_ERROR, 'GEN0001', 'Data transação não informada!', Operação->TRASVCO004.atualizaEstoqueTransacao);
      return(-1); exit;
    end;

    clear_e(tTRA_TRANSACAO);
    putitem_o(tTRA_TRANSACAO, 'CD_EMPRESA', vCdEmpresa);
    putitem_o(tTRA_TRANSACAO, 'NR_TRANSACAO', vNrTransacao);
    putitem_o(tTRA_TRANSACAO, 'DT_TRANSACAO', vDtTransacao);
    retrieve_e(tTRA_TRANSACAO);
    if (xStatus < 0) then begin
      Result := SetStatus(STS_ERROR, 'GEN0001', 'Transação ' + FloatToStr(vNrTransacao) + ' não cadastrada!', Operação->TRASVCO004.atualizaEstoqueTransacao);
      return(-1); exit;
    end;
    if (empty(tTRA_TRANSITEM) = False) then begin
      setocc(tTRA_TRANSITEM, 1);
      while (xStatus >=0) do begin

        viParams := '';
        putitemXml(viParams, 'CD_EMPRESA', item_f('CD_EMPRESA', tTRA_TRANSITEM));
        putitemXml(viParams, 'NR_TRANSACAO', item_f('NR_TRANSACAO', tTRA_TRANSITEM));
        putitemXml(viParams, 'DT_TRANSACAO', item_a('DT_TRANSACAO', tTRA_TRANSITEM));
        putitemXml(viParams, 'NR_ITEM', item_f('NR_ITEM', tTRA_TRANSITEM));
        voParams := activateCmp('GERSVCO058', 'buscaDadosGerOperCfopTra', viParams); (*,,,, *)
        if (xStatus < 0) then begin
          Result := voParams;
          return(-1); exit;
        end;
        vInKardex := itemXmlB('IN_KARDEX', voParams);

        if (vInKardex = False) then begin
        end else begin
          viParams := '';
          putitemXml(viParams, 'CD_EMPRESA', item_f('CD_EMPFAT', tTRA_TRANSACAO));
          putitemXml(viParams, 'CD_PRODUTO', item_f('CD_PRODUTO', tTRA_TRANSITEM));
          putitemXml(viParams, 'NR_ITEM', item_f('NR_ITEM', tTRA_TRANSITEM));
          putitemXml(viParams, 'CD_OPERACAO', item_f('CD_OPERACAO', tTRA_TRANSACAO));
          putitemXml(viParams, 'IN_ESTORNO', vInEstorno);
          putitemXml(viParams, 'TP_DCTOORIGEM', 1);
          putitemXml(viParams, 'NR_DCTOORIGEM', item_f('NR_TRANSACAO', tTRA_TRANSACAO));
          putitemXml(viParams, 'DT_DCTOORIGEM', item_a('DT_TRANSACAO', tTRA_TRANSACAO));
          putitemXml(viParams, 'QT_MOVIMENTO', item_f('QT_SOLICITADA', tTRA_TRANSITEM));
          putitemXml(viParams, 'VL_UNITLIQUIDO', item_f('VL_UNITLIQUIDO', tTRA_TRANSITEM));
          putitemXml(viParams, 'VL_UNITSEMIMPOSTO', item_f('VL_UNITLIQUIDO', tTRA_TRANSITEM));
          voParams := activateCmp('GERSVCO008', 'atualizaSaldoOperacao', viParams); (*,,,, *)
          if (xStatus < 0) then begin
            Result := voParams;
            return(-1); exit;
          end;
            return(-1); exit;
          end;
        end;

        setocc(tTRA_TRANSITEM, curocc(tTRA_TRANSITEM) + 1);
      end;
    end;

    delitem(vDsLstTransacao, 1);
  until (vDsLstTransacao = '');

  return(0); exit;
end;

//-------------------------------------------------------------------------
function T_TRASVCO004.gravaImpostoItemTransacao(pParams : String) : String;
//-------------------------------------------------------------------------
const
  cDS_METHOD = 'ADICIONAL=Operação: T_TRASVCO004.gravaImpostoItemTransacao()';
var
  viParams, voParams, vDsRegistro, vDsLstImposto, vCdCST, vDsUFOrigem, vDsUFDestino : String;
  vCdEmpresa, vNrTransacao, vNrItem, vCdCFOP, vCdDecreto, vTpAreaComercio : Real;
  vDtTransacao : TDate;
begin
  PARAM_GLB := PARAM_GLB;
  vCdEmpresa := itemXmlF('CD_EMPRESA', pParams);
  vNrTransacao := itemXmlF('NR_TRANSACAO', pParams);
  vDtTransacao := itemXml('DT_TRANSACAO', pParams);
  vNrItem := itemXmlF('NR_ITEM', pParams);
  vTpAreaComercio := itemXmlF('TP_AREACOMERCIO', pParams);
  gCdEspecieServico := itemXmlF('CD_ESPECIE_SERVICO_TRA', PARAM_GLB);
  if (itemXml('IN_TRANSFERE', pParams) = True) then begin
    vDsUFOrigem := itemXml('UF_ORIGEM', pParams);
    vDsUFDestino := itemXml('UF_DESTINO', pParams);
  end;
  gTpModDctoFiscal := itemXmlF('TP_MODDCTOFISCAL', pParams);

  if (vCdEmpresa = 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Empresa não informada!', Operação->TRASVCO004.gravaImpostoItemTransacao);
    return(-1); exit;
  end;
  if (vNrTransacao = 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Número transação não informado!', Operação->TRASVCO004.gravaImpostoItemTransacao);
    return(-1); exit;
  end;
  if (vDtTransacao = '') then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Data transação não informada!', Operação->TRASVCO004.gravaImpostoItemTransacao);
    return(-1); exit;
  end;
  if (vNrItem = 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Item da transação não informado!', Operação->TRASVCO004.gravaImpostoItemTransacao);
    return(-1); exit;
  end;

  clear_e(tTRA_TRANSACAO);
  putitem_o(tTRA_TRANSACAO, 'CD_EMPRESA', vCdEmpresa);
  putitem_o(tTRA_TRANSACAO, 'NR_TRANSACAO', vNrTransacao);
  putitem_o(tTRA_TRANSACAO, 'DT_TRANSACAO', vDtTransacao);
  retrieve_e(tTRA_TRANSACAO);
  if (xStatus < 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Transação ' + FloatToStr(vNrTransacao) + ' não cadastrada!', Operação->TRASVCO004.gravaImpostoTransacao);
    return(-1); exit;
  end;

  clear_e(tTRA_TRANSITEM);
  putitem_o(tTRA_TRANSITEM, 'NR_ITEM', vNrItem);
  retrieve_e(tTRA_TRANSITEM);
  if (xStatus < 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Item ' + FloatToStr(vNrItem) + ' da transação ' + FloatToStr(vNrTransacao) + ' não cadastrada!', Operação->TRASVCO004.gravaImpostoItemTransacao);
    return(-1); exit;
  end;
  if (empty(tTRA_REMDES) <> False) then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Transação ' + FloatToStr(vNrTransacao) + ' não possui endereco cadastrado!', Operação->TRASVCO004.gravaImpostoItemTransacao);
    return(-1); exit;
  end;
  if (item_f('CD_PESSOA', tTRA_REMDES) = 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'endereço da transação ' + FloatToStr(vNrTransacao) + ' não possui pessoa cadastrada!', Operação->TRASVCO004.gravaImpostoItemTransacao);
    return(-1); exit;
  end;

  clear_e(tTRA_ITEMIMPOS);
  retrieve_e(tTRA_ITEMIMPOS);
  if (xStatus >= 0) then begin
    voParams := tTRA_ITEMIMPOS.Excluir();
    if (xStatus < 0) then begin
      Result := voParams;
      return(-1); exit;
    end;
  end;

  viParams := '';
  if (item_f('CD_ESPECIE', tTRA_TRANSITEM) = gCdEspecieServico) then begin
    putitemXml(viParams, 'CD_SERVICO', item_f('CD_PRODUTO', tTRA_TRANSITEM));
  end else if (item_f('TP_MODALIDADE', tGER_OPERACAO) = 'A') then begin
    putitemXml(viParams, 'CD_MPTER', item_f('CD_BARRAPRD', tTRA_TRANSITEM));
  end else begin
    putitemXml(viParams, 'CD_PRODUTO', item_f('CD_PRODUTO', tTRA_TRANSITEM));
  end;
  putitemXml(viParams, 'CD_OPERACAO', item_f('CD_OPERACAO', tGER_OPERACAO));
  if (itemXml('IN_TRANSFERE', pParams) = True) then begin
    putitemXml(viParams, 'UF_DESTINO', vDsUFDestino);
    putitemXml(viParams, 'UF_ORIGEM', vDsUFOrigem);
  end else begin
    putitemXml(viParams, 'UF_DESTINO', item_a('DS_SIGLAESTADO', tTRA_REMDES));
  end;
  putitemXml(viParams, 'CD_PESSOA', item_f('CD_PESSOA', tTRA_REMDES));
  putitemXml(viParams, 'TP_AREACOMERCIO', vTpAreaComercio);
  putitemXml(viParams, 'TP_ORIGEMEMISSAO', item_f('TP_ORIGEMEMISSAO', tTRA_TRANSACAO));
  voParams := activateCmp('FISSVCO015', 'buscaCFOP', viParams); (*,,,, *)
  if (xStatus < 0) then begin
    Result := voParams;
    return(-1); exit;
  end;

  vCdCFOP := itemXmlF('CD_CFOP', voParams);

  if (vCdCFOP > 0) then begin
    putitem_e(tTRA_TRANSITEM, 'CD_CFOP', vCdCFOP);
  end;

  viParams := '';
  if (item_f('CD_ESPECIE', tTRA_TRANSITEM) = gCdEspecieServico) then begin
    putitemXml(viParams, 'CD_SERVICO', item_f('CD_PRODUTO', tTRA_TRANSITEM));
  end else if (item_f('TP_MODALIDADE', tGER_OPERACAO) = 'A') then begin
    putitemXml(viParams, 'CD_MPTER', item_f('CD_BARRAPRD', tTRA_TRANSITEM));
  end else begin
    putitemXml(viParams, 'CD_PRODUTO', item_f('CD_PRODUTO', tTRA_TRANSITEM));
  end;
  putitemXml(viParams, 'CD_OPERACAO', item_f('CD_OPERACAO', tGER_OPERACAO));
  putitemXml(viParams, 'UF_DESTINO', item_a('DS_SIGLAESTADO', tTRA_REMDES));
  putitemXml(viParams, 'CD_PESSOA', item_f('CD_PESSOA', tTRA_REMDES));
  putitemXml(viParams, 'TP_AREACOMERCIO', vTpAreaComercio);
  putitemXml(viParams, 'TP_ORIGEMEMISSAO', item_f('TP_ORIGEMEMISSAO', tTRA_TRANSACAO));
  putitemXml(viParams, 'CD_CFOP', vCdCFOP);
  voParams := activateCmp('FISSVCO015', 'buscaCST', viParams); (*,,,, *)
  if (xStatus < 0) then begin
    Result := voParams;
    return(-1); exit;
  end;

  vCdCST := itemXmlF('CD_CST', voParams);

  if (vCdCST <> '') then begin
    putitem_e(tTRA_TRANSITEM, 'CD_CST', vCdCST);
  end;

  viParams := '';
  putitemXml(viParams, 'CD_EMPRESA', item_f('CD_EMPFAT', tTRA_TRANSACAO));
  putitemXml(viParams, 'UF_DESTINO', item_a('DS_SIGLAESTADO', tTRA_REMDES));
  putitemXml(viParams, 'TP_ORIGEMEMISSAO', item_f('TP_ORIGEMEMISSAO', tTRA_TRANSACAO));
  if (item_f('CD_ESPECIE', tTRA_TRANSITEM) = gCdEspecieServico) then begin
    putitemXml(viParams, 'CD_SERVICO', item_f('CD_PRODUTO', tTRA_TRANSITEM));
  end else if (item_f('TP_MODALIDADE', tGER_OPERACAO) = 'A') then begin
    putitemXml(viParams, 'CD_MPTER', item_f('CD_BARRAPRD', tTRA_TRANSITEM));
  end else begin
    putitemXml(viParams, 'CD_PRODUTO', item_f('CD_PRODUTO', tTRA_TRANSITEM));
  end;
  putitemXml(viParams, 'CD_OPERACAO', item_f('CD_OPERACAO', tGER_OPERACAO));
  putitemXml(viParams, 'CD_PESSOA', item_f('CD_PESSOA', tTRA_REMDES));
  putitemXml(viParams, 'CD_CST', item_f('CD_CST', tTRA_TRANSITEM));
  putitemXml(viParams, 'VL_TOTALBRUTO', item_f('VL_TOTALBRUTO', tTRA_TRANSITEM));
  putitemXml(viParams, 'VL_TOTALLIQUIDO', item_f('VL_TOTALLIQUIDO', tTRA_TRANSITEM));
  putitemXml(viParams, 'PR_IPI', itemXmlF('PR_IPI', pParams));
  putitemXml(viParams, 'VL_IPI', itemXmlF('VL_IPI', pParams));
  putitemXml(viParams, 'TP_AREACOMERCIO', vTpAreaComercio);
  putitemXml(viParams, 'TP_MODDCTOFISCAL', gTpModDctoFiscal);
  putitemXml(viParams, 'DT_INIVIGENCIA', item_a('DT_TRANSACAO', tTRA_TRANSACAO));
  voParams := activateCmp('FISSVCO015', 'calculaImpostoItem', viParams); (*,,,, *)
  if (xStatus < 0) then begin
    Result := voParams;
    return(-1); exit;
  end;

  vDsLstImposto := itemXml('DS_LSTIMPOSTO', voParams);
  vCdCST := itemXmlF('CD_CST', voParams);
  vCdDecreto := itemXmlF('CD_DECRETO', voParams);

  if (vCdCST <> '') then begin
    putitem_e(tTRA_TRANSITEM, 'CD_CST', vCdCST);
  end;
  if (vCdDecreto > 0) then begin
    putitem_e(tTRA_TRANSITEM, 'CD_DECRETO', vCdDecreto);
  end;
  if (vDsLstImposto <> '') then begin
    repeat
      getitem(vDsRegistro, vDsLstImposto, 1);

      delitem(vDsRegistro, 'CD_EMPRESA');
      delitem(vDsRegistro, 'NR_TRANSACAO');
      delitem(vDsRegistro, 'DT_TRANSACAO');
      delitem(vDsRegistro, 'NR_ITEM');

      creocc(tTRA_ITEMIMPOS, -1);
      getlistitensocc_e(vDsRegistro, tTRA_ITEMIMPOS);
      putitem_e(tTRA_ITEMIMPOS, 'CD_EMPFAT', item_f('CD_EMPFAT', tTRA_TRANSACAO));
      putitem_e(tTRA_ITEMIMPOS, 'CD_GRUPOEMPRESA', item_f('CD_GRUPOEMPRESA', tTRA_TRANSACAO));
      putitem_e(tTRA_ITEMIMPOS, 'CD_OPERADOR', itemXmlF('CD_USUARIO', PARAM_GLB));
      putitem_e(tTRA_ITEMIMPOS, 'DT_CADASTRO', Now);

      clear_e(tFIS_REGRAIMPO);
      putitem_o(tFIS_REGRAIMPO, 'CD_IMPOSTO', itemXmlF('CD_IMPOSTO', vDsRegistro));
      putitem_o(tFIS_REGRAIMPO, 'CD_REGRAFISCAL', item_f('CD_REGRAFISCAL', tGER_OPERACAO));
      retrieve_e(tFIS_REGRAIMPO);
      if (xStatus >= 0) then begin
        putitem_o(tTRA_ITEMIMPOS, 'CD_CST', item_f('CD_CST', tFIS_REGRAIMPO));
      end;

      delitem(vDsLstImposto, 1);
    until (vDsLstImposto = '');
  end;

  voParams := tTRA_TRANSITEM.Salvar();
  if (xStatus < 0) then begin
    Result := voParams;
    return(-1); exit;
  end;

  return(0); exit;
end;

//-------------------------------------------------------------------------
function T_TRASVCO004.alteraVendedorTransacaoNF(pParams : String) : String;
//-------------------------------------------------------------------------
const
  cDS_METHOD = 'ADICIONAL=Operação: T_TRASVCO004.alteraVendedorTransacaoNF()';
var
  vDsLstNF, vDsRegistro, viParams, voParams : String;
  vCdEmpresa, vNrTransacao, vCdVendedor : Real;
  vDtTransacao : TDate;
begin
  PARAM_GLB := PARAM_GLB;

  vCdEmpresa := itemXmlF('CD_EMPRESA', pParams);
  vNrTransacao := itemXmlF('NR_TRANSACAO', pParams);
  vDtTransacao := itemXml('DT_TRANSACAO', pParams);
  vCdVendedor := itemXmlF('CD_COMPVend', pParams);

  if (vCdEmpresa = 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Empresa não informada!', Operação->TRASVCO004.alteraVendedor);
    return(-1); exit;
  end;
  if (vNrTransacao = 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Número da transação não informado!', Operação->TRASVCO004.alteraVendedor);
    return(-1); exit;
  end;
  if (vDtTransacao = '') then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Data transação não informada!', Operação->TRASVCO004.alteraVendedor);
    return(-1); exit;
  end;
  if (vCdVendedor = 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Vendedor não informado!', Operação->TRASVCO004.alteraVendedor);
    return(-1); exit;
  end;

  clear_e(tTRA_TRANSACAO);
  putitem_o(tTRA_TRANSACAO, 'CD_EMPRESA', vCdEmpresa);
  putitem_o(tTRA_TRANSACAO, 'NR_TRANSACAO', vNrTransacao);
  putitem_o(tTRA_TRANSACAO, 'DT_TRANSACAO', vDtTransacao);
  retrieve_e(tTRA_TRANSACAO);
  if (xStatus < 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Transação ' + FloatToStr(vNrTransacao) + ' não cadastrada!', Operação->TRASVCO004.alteraVendedor);
    return(-1); exit;
  end;

  putitem_e(tTRA_TRANSACAO, 'CD_COMPVEND', vCdVendedor);
  putitem_e(tTRA_TRANSACAO, 'CD_OPERADOR', itemXmlF('CD_USUARIO', PARAM_GLB));
  putitem_e(tTRA_TRANSACAO, 'DT_CADASTRO', Now);

  setocc(tTRA_TRANSITEM, 1);
  while(xStatus >= 0) do begin
    putitem_e(tTRA_TRANSITEM, 'CD_COMPVEND', vCdVendedor);
    putitem_e(tTRA_TRANSITEM, 'CD_OPERADOR', itemXmlF('CD_USUARIO', PARAM_GLB));
    putitem_e(tTRA_TRANSITEM, 'DT_CADASTRO', Now);
    setocc(tTRA_TRANSITEM, curocc(tTRA_TRANSITEM) + 1);
  end;

  voParams := tTRA_TRANSACAO.Salvar();
  if (xStatus < 0) then begin
    Result := voParams;
    return(-1); exit;
  end;

  viParams := '';
  putitemXml(viParams, 'CD_EMPTRANSACAO', item_f('CD_EMPRESA', tTRA_TRANSACAO));
  putitemXml(viParams, 'NR_TRANSACAO', item_f('NR_TRANSACAO', tTRA_TRANSACAO));
  putitemXml(viParams, 'DT_TRANSACAO', item_a('DT_TRANSACAO', tTRA_TRANSACAO));
  putitemXml(viParams, 'CD_COMPVend', vCdVendedor);
  voParams := activateCmp('FISSVCO004', 'AlteraVendedorNF', viParams); (*,,,, *)
  if (xStatus < 0) then begin
    Result := voParams;
    return(-1); exit;
  end;

  return(0); exit;
end;

//---------------------------------------------------------------
function T_TRASVCO004.alteraAdicional(pParams : String) : String;
//---------------------------------------------------------------
const
  cDS_METHOD = 'ADICIONAL=Operação: T_TRASVCO004.alteraAdicional()';
var
  vCdEmpresa, vNrTransacao, vTpSituacao : Real;
  vCdGuia, vCdRepresentante,vCdVendedor : Real;
  vDtTransacao : TDate;
begin
  PARAM_GLB := PARAM_GLB;
  vCdEmpresa := itemXmlF('CD_EMPRESA', pParams);
  vNrTransacao := itemXmlF('NR_TRANSACAO', pParams);
  vDtTransacao := itemXml('DT_TRANSACAO', pParams);
  vCdGuia := itemXmlF('CD_GUIA', pParams);
  vCdRepresentante := itemXmlF('CD_REPRESENTANT', pParams);
  vCdVendedor := itemXmlF('CD_COMPVend', pParams);
  vTpSituacao := itemXmlF('TP_SITUACAO', pParams);

  if (vCdEmpresa = 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Empresa não informada!', Operação->TRASVCO004.alteraAdicional);
    return(-1); exit;
  end;
  if (vNrTransacao = 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Número da transação não informado!', Operação->TRASVCO004.alteraAdicional);
    return(-1); exit;
  end;
  if (vDtTransacao = '') then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Data transação não informada!', Operação->TRASVCO004.alteraAdicional);
    return(-1); exit;
  end;
  if (vTpSituacao = 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Situação não informada!', Operação->TRASVCO004.alteraAdicional);
    return(-1); exit;
  end;
  if (vTpSituacao < 0)  or (vTpSituacao > 10) then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Situação ' + FloatToStr(vTpSituacao) + ' inválida!', Operação->TRASVCO004.alteraAdicional);
    return(-1); exit;
  end;

  clear_e(tTRA_TRANSACAO);
  putitem_o(tTRA_TRANSACAO, 'CD_EMPRESA', vCdEmpresa);
  putitem_o(tTRA_TRANSACAO, 'NR_TRANSACAO', vNrTransacao);
  putitem_o(tTRA_TRANSACAO, 'DT_TRANSACAO', vDtTransacao);
  retrieve_e(tTRA_TRANSACAO);
  if (xStatus < 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Transação ' + FloatToStr(vNrTransacao) + ' não cadastrada!', Operação->TRASVCO004.alteraAdicional);
    return(-1); exit;
  end;

    putitem_e(tTRA_TRANSACAO, 'CD_GUIA', vCdGuia);
    putitem_e(tTRA_TRANSACAO, 'CD_REPRESENTANT', vCdRepresentante);
  if (vCdVendedor <> '') then begin
    putitem_e(tTRA_TRANSACAO, 'CD_COMPVEND', vCdVendedor);
  end;
  putitem_e(tTRA_TRANSACAO, 'DT_ULTATEND', itemXml('DT_SISTEMA', PARAM_GLB));
  putitem_e(tTRA_TRANSACAO, 'CD_OPERADOR', itemXmlF('CD_USUARIO', PARAM_GLB));
  putitem_e(tTRA_TRANSACAO, 'DT_CADASTRO', Now);

  voParams := tTRA_TRANSACAO.Salvar();
  if (xStatus < 0) then begin
    Result := voParams;
    return(-1); exit;
  end;

  return(0); exit;
end;

//------------------------------------------------------------------------
function T_TRASVCO004.alteraImpressaoTransacao(pParams : String) : String;
//------------------------------------------------------------------------
const
  cDS_METHOD = 'ADICIONAL=Operação: T_TRASVCO004.alteraImpressaoTransacao()';
var
  vDsRegistro, vDsLstTransacao, viParams : String;
  vCdEmpresa, vNrTransacao, vCdModeloTra : Real;
  vDtTransacao : TDate;
  inCommitimptra : Boolean;
begin
  PARAM_GLB := PARAM_GLB;
  viParams := pParams;
  vDsLstTransacao := itemXml('DS_LSTTRANSACAO', pParams);
  vCdModeloTra := itemXmlF('CD_MODELOTRA', pParams);

  if (vDsLstTransacao = '') then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Lista de transação não informada!', Operação->TRASVCO004.alteraImpressaoTransacao);
    return(-1); exit;
  end;
  if (vCdModeloTra = 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Modelo de transação não informado!', Operação->TRASVCO004.alteraImpressaoTransacao);
    return(-1); exit;
  end;

  clear_e(tTRA_TRANSACAO);

  repeat
    getitem(vDsRegistro, vDsLstTransacao, 1);
    vCdEmpresa := itemXmlF('CD_EMPRESA', vDsRegistro);
    vNrTransacao := itemXmlF('NR_TRANSACAO', vDsRegistro);
    vDtTransacao := itemXml('DT_TRANSACAO', vDsRegistro);

    if (vCdEmpresa = 0) then begin
      Result := SetStatus(STS_ERROR, 'GEN0001', 'Empresa não informada!', Operação->TRASVCO004.alteraImpressaoTransacao);
      return(-1); exit;
    end;
    if (vNrTransacao = 0) then begin
      Result := SetStatus(STS_ERROR, 'GEN0001', 'Número da transação não informado!', Operação->TRASVCO004.alteraImpressaoTransacao);
      return(-1); exit;
    end;
    if (vDtTransacao = '') then begin
      Result := SetStatus(STS_ERROR, 'GEN0001', 'Data transação não informada!', Operação->TRASVCO004.alteraImpressaoTransacao);
      return(-1); exit;
    end;

    creocc(tTRA_TRANSACAO, -1);
    putitem_o(tTRA_TRANSACAO, 'CD_EMPRESA', vCdEmpresa);
    putitem_o(tTRA_TRANSACAO, 'NR_TRANSACAO', vNrTransacao);
    putitem_o(tTRA_TRANSACAO, 'DT_TRANSACAO', vDtTransacao);
    retrieve_o(tTRA_TRANSACAO);
    if (xStatus = -7) then begin
      retrieve_x(tTRA_TRANSACAO);
    end else if (xStatus = 0) then begin
      Result := SetStatus(STS_ERROR, 'GEN0001', 'Transação ' + FloatToStr(vNrTransacao) + ' não cadastrada!', Operação->TRASVCO004.alteraImpressaoTransacao);
      return(-1); exit;
    end;

    putitem_e(tTRA_TRANSACAO, 'CD_MODELOTRA', vCdModeloTra);
    if (item_f('NR_IMPRESSAO', tTRA_TRANSACAO) = 0) then begin
      putitem_e(tTRA_TRANSACAO, 'NR_IMPRESSAO', 1);
    end else begin
      putitem_e(tTRA_TRANSACAO, 'NR_IMPRESSAO', item_f('NR_IMPRESSAO', tTRA_TRANSACAO) + 1);
    end;
    putitem_e(tTRA_TRANSACAO, 'CD_USUIMPRESSAO', itemXmlF('CD_USUARIO', PARAM_GLB));
    putitem_e(tTRA_TRANSACAO, 'DT_IMPRESSAO', Now);
    putitem_e(tTRA_TRANSACAO, 'CD_OPERADOR', itemXmlF('CD_USUARIO', PARAM_GLB));
    putitem_e(tTRA_TRANSACAO, 'DT_CADASTRO', Now);

    delitem(vDsLstTransacao, 1);
  until (vDsLstTransacao = '');

  voParams := tTRA_TRANSACAO.Salvar();
  if (xStatus < 0) then begin
    Result := voParams;
    return(-1); exit;
  end;
    inCommitimptra := itemXml ('IN_COMMIT_IMP_TRA', viParams);
    if (inCommitimptra = True) then begin
      commit;
      if (xStatus < 0) then begin
        rollback;
        return(-1); exit;
      end else begin
        voParams := SetHint(viParams); (* 'ID=APLINFO002' *)
      end;
    end;
  end;

  return(0); exit;
end;

//-----------------------------------------------------------------------
function T_TRASVCO004.gravaTransportTransacao(pParams : String) : String;
//-----------------------------------------------------------------------
const
  cDS_METHOD = 'ADICIONAL=Operação: T_TRASVCO004.gravaTransportTransacao()';
var
  viParams, voParams, vTpFrete, vDsRegistro, vDsLstImposto, vDsUFDestino, vCdCST : String;
  vCdEmpresa, vNrTransacao, vCdTransport, vNrSeqendereco, vVlFreteTot, vCdTranspConhec : Real;
  vVlFrete, vVlSeguro, vVlDespAcessor, vCdImposto, vVlBaseCalc, vVlImposto, vPrIPI, vVlConhecimento : Real;
  vDtTransacao : TDate;
  vInDecreto, vInProduto, vInSubstituicao : Boolean;
begin
  PARAM_GLB := PARAM_GLB;
  vCdEmpresa := itemXmlF('CD_EMPRESA', pParams);
  vNrTransacao := itemXmlF('NR_TRANSACAO', pParams);
  vDtTransacao := itemXml('DT_TRANSACAO', pParams);
  vCdTransport := itemXmlF('CD_TRANSPORT', pParams);
  vVlFrete := itemXmlF('VL_FRETE', pParams);
  vVlSeguro := itemXmlF('VL_SEGURO', pParams);
  vVlDespAcessor := itemXmlF('VL_DESPACESSOR', pParams);
  vTpFrete := itemXmlF('TP_FRETE', pParams);
  vDsLstImposto := itemXml('DS_LSTIMPOSTO', pParams);
  vCdTranspConhec := itemXmlF('CD_TRANSPCONHEC', pParams);
  vVlConhecimento := itemXmlF('VL_CONHECIMENTO', pParams);

  if (vCdTranspConhec <> 0)  and (vCdTransport = 0) then begin
    vCdTransport := vCdTranspConhec;
    vTpFrete := 2;
  end;
  if (vCdEmpresa = 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Empresa não informada!', Operação->TRASVCO004.gravaTransportTransacao);
    return(-1); exit;
  end;
  if (vNrTransacao = 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Número transação não informado!', Operação->TRASVCO004.gravaTransportTransacao);
    return(-1); exit;
  end;
  if (vDtTransacao = '') then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Data transação não informada!', Operação->TRASVCO004.gravaTransportTransacao);
    return(-1); exit;
  end;

  clear_e(tTRA_TRANSACAO);
  putitem_o(tTRA_TRANSACAO, 'CD_EMPRESA', vCdEmpresa);
  putitem_o(tTRA_TRANSACAO, 'NR_TRANSACAO', vNrTransacao);
  putitem_o(tTRA_TRANSACAO, 'DT_TRANSACAO', vDtTransacao);
  retrieve_e(tTRA_TRANSACAO);
  if (xStatus < 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Transação ' + FloatToStr(vNrTransacao) + ' não cadastrada!', Operação->TRASVCO004.gravaTransportTransacao);
    return(-1); exit;
  end;
  if (empty(tTRA_REMDES) = False) then begin
    vDsUFDestino := item_a('DS_SIGLAESTADO', tTRA_REMDES);
  end else begin
    clear_e(tV_PES_ENDEREC);
    viParams := '';
    putitemXml(viParams, 'CD_PESSOA', item_f('CD_PESSOA', tTRA_TRANSACAO));
    voParams := activateCmp('PESSVCO005', 'buscaenderecoFaturamento', viParams); (*,,,, *)
    if (xStatus >= 0) then begin
      vNrSeqendereco := itemXmlF('NR_SEQendERECO', voParams);
      putitem_o(tV_PES_ENDEREC, 'CD_PESSOA', item_f('CD_PESSOA', tTRA_TRANSACAO));
      putitem_o(tV_PES_ENDEREC, 'NR_SEQUENCIA', vNrSeqendereco);
      retrieve_e(tV_PES_ENDEREC);
      if (xStatus < 0) then begin
        Result := SetStatus(STS_ERROR, 'GEN0001', 'endereço ' + FloatToStr(vNrSeqendereco) + ' não cadastrado para a transportadora ' + FloatToStr(vCdTransport) + '!', Operação->TRASVCO004.gravaTransportTransacao);
        return(-1); exit;
      end;
    end;
    vDsUFDestino := item_a('DS_SIGLAESTADO', tV_PES_ENDEREC);
    clear_e(tV_PES_ENDEREC);
  end;

  voParams := getParam(viParams); (* pParams *) (viParams); (* * item_f('CD_EMPFAT', tTRA_TRANSACAO) *)
  if (xStatus < 0) then begin
    return(-1); exit;
  end;

  putitem_e(tTRA_TRANSACAO, 'VL_FRETE', vVlFrete);
  putitem_e(tTRA_TRANSACAO, 'VL_SEGURO', vVlSeguro);
  putitem_e(tTRA_TRANSACAO, 'VL_DESPACESSOR', vVlDespAcessor);

  clear_e(tTRA_TRANSPORT);
  retrieve_e(tTRA_TRANSPORT);
  if (xStatus >= 0) then begin
    if (vCdTransport = 0) then begin
      clear_e(tPED_PEDIDOTRA);
      putitem_o(tPED_PEDIDOTRA, 'CD_EMPTRANSACAO', item_f('CD_EMPRESA', tTRA_TRANSACAO));
      putitem_o(tPED_PEDIDOTRA, 'NR_TRANSACAO', item_f('NR_TRANSACAO', tTRA_TRANSACAO));
      putitem_o(tPED_PEDIDOTRA, 'DT_TRANSACAO', item_a('DT_TRANSACAO', tTRA_TRANSACAO));
      retrieve_e(tPED_PEDIDOTRA);
      if (xStatus < 0) then begin
        setocc(tTRA_TRANSPORT, 1);
        vCdTransport := item_f('CD_TRANSPORT', tTRA_TRANSPORT);
        vTpFrete := item_f('TP_FRETE', tTRA_TRANSPORT);
        putlistitensocc_e(pParams, tTRA_TRANSPORT);
      end;
    end;

    voParams := tTRA_TRANSPORT.Excluir();
    if (xStatus < 0) then begin
      Result := voParams;
      return(-1); exit;
    end;
  end else begin
    clear_e(tTRA_TRANSPORT);
  end;

  clear_e(tTRA_TRAIMPOST);
  retrieve_e(tTRA_TRAIMPOST);
  if (xStatus >= 0) then begin
    voParams := tTRA_TRAIMPOST.Excluir();
    if (xStatus < 0) then begin
      Result := voParams;
      return(-1); exit;
    end;
  end else begin
    clear_e(tTRA_TRAIMPOST);
  end;
  if (vCdTransport > 0) then begin
    if (vTpFrete = '') then begin
      Result := SetStatus(STS_ERROR, 'GEN0001', 'Tipo frete não informado!', Operação->TRASVCO004.gravaTransportTransacao);
      return(-1); exit;
    end;

    clear_e(tV_PES_ENDEREC);

    viParams := '';
    putitemXml(viParams, 'CD_PESSOA', vCdTransport);
    voParams := activateCmp('PESSVCO005', 'buscaenderecoFaturamento', viParams); (*,,,, *)
    if (xStatus >= 0) then begin
      vNrSeqendereco := itemXmlF('NR_SEQendERECO', voParams);
      putitem_o(tV_PES_ENDEREC, 'CD_PESSOA', vCdTransport);
      putitem_o(tV_PES_ENDEREC, 'NR_SEQUENCIA', vNrSeqendereco);
      retrieve_e(tV_PES_ENDEREC);
      if (xStatus < 0) then begin
        Result := SetStatus(STS_ERROR, 'GEN0001', 'endereço ' + FloatToStr(vNrSeqendereco) + ' não cadastrado para a transportadora ' + FloatToStr(vCdTransport) + '!', Operação->TRASVCO004.gravaTransportTransacao);
        return(-1); exit;
      end;
    end;

    creocc(tTRA_TRANSPORT, -1);
    delitem(pParams, 'CD_EMPRESA');
    delitem(pParams, 'NR_TRANSACAO');
    delitem(pParams, 'DT_TRANSACAO');
    getlistitensocc_e(pParams, tTRA_TRANSPORT);

    viParams := '';
    putitemXml(viParams, 'CD_PESSOA', vCdTransport);
    voParams := activateCmp('PESSVCO005', 'buscaDadosPessoa', viParams); (*,,,, *)
    if (xStatus < 0) then begin
      Result := voParams;
      return(-1); exit;
    end;
    if (itemXml('TP_PESSOA', voParams) = 'F') then begin
      putitem_e(tTRA_TRANSPORT, 'NR_RGINSCREST', itemXmlF('NR_RG', voParams));
    end else begin
      putitem_e(tTRA_TRANSPORT, 'NR_RGINSCREST', itemXmlF('NR_INSCESTL', voParams));
    end;
    putitem_e(tTRA_TRANSPORT, 'NR_CPFCNPJ', itemXmlF('NR_CPFCNPJ', voParams));
    if (item_a('NM_TRANSPORT', tTRA_TRANSPORT) = '') then begin
      putitem_e(tTRA_TRANSPORT, 'NM_TRANSPORT', itemXml('NM_PESSOA', voParams));
    end;

    setocc(tV_PES_ENDEREC, 1);
    if (dbocc(t'V_PES_ENDEREC')) then begin
      putitem_e(tTRA_TRANSPORT, 'NM_LOGRADOURO', item_a('NM_LOGRADOURO', tV_PES_ENDEREC));
      putitem_e(tTRA_TRANSPORT, 'DS_TPLOGRADOURO', item_a('DS_SIGLALOGRAD', tV_PES_ENDEREC));
      putitem_e(tTRA_TRANSPORT, 'NR_LOGRADOURO', item_f('NR_LOGRADOURO', tV_PES_ENDEREC));
      putitem_e(tTRA_TRANSPORT, 'NR_CAIXAPOSTAL', item_f('NR_CAIXAPOSTAL', tV_PES_ENDEREC));
      putitem_e(tTRA_TRANSPORT, 'NM_BAIRRO', item_a('DS_BAIRRO', tV_PES_ENDEREC));
      putitem_e(tTRA_TRANSPORT, 'CD_CEP', item_f('CD_CEP', tV_PES_ENDEREC));
      putitem_e(tTRA_TRANSPORT, 'NM_MUNICIPIO', item_a('NM_MUNICIPIO', tV_PES_ENDEREC));
      putitem_e(tTRA_TRANSPORT, 'DS_SIGLAESTADO', item_a('DS_SIGLAESTADO', tV_PES_ENDEREC));
    end;
    if (item_f('CD_TRANSREDESPAC', tTRA_TRANSPORT) > 0)  and (item_a('NM_TRANSREDESPAC', tTRA_TRANSPORT) = '') then begin
      viParams := '';
      putitemXml(viParams, 'CD_PESSOA', item_f('CD_TRANSREDESPAC', tTRA_TRANSPORT));
      voParams := activateCmp('PESSVCO005', 'buscaDadosPessoa', viParams); (*,,,, *)
      if (xStatus < 0) then begin
        Result := voParams;
        return(-1); exit;
      end;
      putitem_e(tTRA_TRANSPORT, 'NM_TRANSREDESPAC', itemXml('NM_PESSOA', voParams));
    end;
    putitem_e(tTRA_TRANSPORT, 'CD_EMPFAT', item_f('CD_EMPFAT', tTRA_TRANSACAO));
    putitem_e(tTRA_TRANSPORT, 'CD_GRUPOEMPRESA', item_f('CD_GRUPOEMPRESA', tTRA_TRANSACAO));
    putitem_e(tTRA_TRANSPORT, 'CD_OPERADOR', itemXmlF('CD_USUARIO', PARAM_GLB));
    putitem_e(tTRA_TRANSPORT, 'DT_CADASTRO', Now);
  end else begin

    if (item_f('TP_DOCTO', tGER_OPERACAO) = 1) then begin
      if (vTpFrete <> '') then begin
        Result := SetStatus(STS_ERROR, 'GEN0001', 'Transportadora não informada!', Operação->TRASVCO004.gravaTransportTransacao);
        return(-1); exit;
      end;
      creocc(tTRA_TRANSPORT, -1);
      delitem(pParams, 'CD_EMPRESA');
      delitem(pParams, 'NR_TRANSACAO');
      delitem(pParams, 'DT_TRANSACAO');
      getlistitensocc_e(pParams, tTRA_TRANSPORT);
      putitem_e(tTRA_TRANSPORT, 'CD_EMPFAT', item_f('CD_EMPFAT', tTRA_TRANSACAO));
      putitem_e(tTRA_TRANSPORT, 'CD_GRUPOEMPRESA', item_f('CD_GRUPOEMPRESA', tTRA_TRANSACAO));
      putitem_e(tTRA_TRANSPORT, 'CD_OPERADOR', itemXmlF('CD_USUARIO', PARAM_GLB));
      putitem_e(tTRA_TRANSPORT, 'DT_CADASTRO', Now);
    end;
  end;
  if (vDsLstImposto = '') then begin
    viParams := '';
    putitemXml(viParams, 'CD_EMPRESA', item_f('CD_EMPFAT', tTRA_TRANSACAO));
    putitemXml(viParams, 'UF_DESTINO', vDsUFDestino);
    putitemXml(viParams, 'TP_ORIGEMEMISSAO', item_f('TP_ORIGEMEMISSAO', tTRA_TRANSACAO));
    putitemXml(viParams, 'CD_OPERACAO', item_f('CD_OPERACAO', tGER_OPERACAO));
    putitemXml(viParams, 'CD_PESSOA', item_f('CD_PESSOA', tTRA_TRANSACAO));
    putitemXml(viParams, 'VL_FRETE', item_f('VL_FRETE', tTRA_TRANSACAO));
    putitemXml(viParams, 'VL_SEGURO', item_f('VL_SEGURO', tTRA_TRANSACAO));
    putitemXml(viParams, 'VL_DESPACESSOR', item_f('VL_DESPACESSOR', tTRA_TRANSACAO));

    clear_e(tF_TRA_ITEMIMP);
    putitem_o(tF_TRA_ITEMIMP, 'CD_EMPRESA', item_f('CD_EMPRESA', tTRA_TRANSACAO));
    putitem_o(tF_TRA_ITEMIMP, 'NR_TRANSACAO', item_f('NR_TRANSACAO', tTRA_TRANSACAO));
    putitem_o(tF_TRA_ITEMIMP, 'DT_TRANSACAO', item_a('DT_TRANSACAO', tTRA_TRANSACAO));
    putitem_o(tF_TRA_ITEMIMP, 'CD_IMPOSTO', 3);
    retrieve_e(tF_TRA_ITEMIMP);
    if (xStatus >= 0) then begin
      vVlBaseCalc := '';
      vVlImposto := '';
      setocc(tF_TRA_ITEMIMP, 1);
      while (xStatus >= 0) do begin

        if (item_f('VL_IMPOSTO', tF_TRA_ITEMIMP) > 0) then begin
          vVlBaseCalc := vVlBaseCalc + item_f('VL_BASECALC', tF_TRA_ITEMIMP);
          vVlImposto := vVlImposto + item_f('VL_IMPOSTO', tF_TRA_ITEMIMP);
        end;
        setocc(tF_TRA_ITEMIMP, curocc(tF_TRA_ITEMIMP) + 1);
      end;

      vPrIPI := (vVlImposto / vVlBaseCalc) * 100;
      vPrIPI := rounded(vPrIPI, 2);

      putitemXml(viParams, 'PR_IPI', vPrIPI);
      putitemXml(viParams, 'IN_IPI', True);
    end else begin
      putitemXml(viParams, 'IN_IPI', False);
    end;

    if not (empty(tTRA_TRANSITEM)) then begin
      sort_e(tTRA_TRANSITEM, '      sort/e , CD_DECRETO;');

      vInDecreto := False;
      vInProduto := False;
      vInSubstituicao := False;
      setocc(tTRA_TRANSITEM, 1);
      while (xStatus >= 0) do begin
        if (item_f('CD_DECRETO', tTRA_TRANSITEM) <> 0)  and (vInDecreto = False) then begin
          putitemXml(viParams, 'CD_DECRETO', item_f('CD_DECRETO', tTRA_TRANSITEM));
          putitemXml(viParams, 'CD_CST', item_f('CD_CST', tTRA_TRANSITEM));
          putitemXml(viParams, 'CD_PRODUTO', item_f('CD_PRODUTO', tTRA_TRANSITEM));
          vInDecreto := True;
          break;
        end;

        vCdCST := item_f('CD_CST', tTRA_TRANSITEM)[2 : 2];
        if ((vCdCST = '10')  or (vCdCST = '30')  or (vCdCST = '60')  or (vCdCST = '70'))  and vInSubstituicao = False then begin
          putitemXml(viParams, 'CD_CST', item_f('CD_CST', tTRA_TRANSITEM));
          putitemXml(viParams, 'CD_PRODUTO', item_f('CD_PRODUTO', tTRA_TRANSITEM));
          vInSubstituicao := True;
          break;
        end;
        if (item_f('CD_ESPECIE', tTRA_TRANSITEM) <> gCdEspecieServico)  and (vInProduto = False) then begin
          putitemXml(viParams, 'CD_PRODUTO', item_f('CD_PRODUTO', tTRA_TRANSITEM));
          vInProduto := True;
        end;

        setocc(tTRA_TRANSITEM, curocc(tTRA_TRANSITEM) + 1);
      end;
      if (vInDecreto = False)  and (vInSubstituicao = False) then begin
        setocc(tTRA_TRANSITEM, 1);
        putitemXml(viParams, 'CD_CST', item_f('CD_CST', tTRA_TRANSITEM));
      end;
    end;

    voParams := activateCmp('FISSVCO015', 'calculaImpostoCapa', viParams); (*,,,, *)
    if (xStatus < 0) then begin
      Result := voParams;
      return(-1); exit;
    end;

    vDsLstImposto := itemXml('DS_LSTIMPOSTO', voParams);
  end;
  if (vDsLstImposto <> '') then begin
    repeat
      getitem(vDsRegistro, vDsLstImposto, 1);

      vCdImposto := itemXmlF('CD_IMPOSTO', vDsRegistro);
      if (vCdImposto > 0) then begin
        delitem(vDsRegistro, 'CD_EMPRESA');
        delitem(vDsRegistro, 'NR_TRANSACAO');
        delitem(vDsRegistro, 'DT_TRANSACAO');
        delitem(vDsRegistro, 'NR_ITEM');

        creocc(tTRA_TRAIMPOST, -1);
        getlistitensocc_e(vDsRegistro, tTRA_TRAIMPOST);
        putitem_e(tTRA_TRAIMPOST, 'CD_EMPFAT', item_f('CD_EMPFAT', tTRA_TRANSACAO));
        putitem_e(tTRA_TRAIMPOST, 'CD_GRUPOEMPRESA', item_f('CD_GRUPOEMPRESA', tTRA_TRANSACAO));
        putitem_e(tTRA_TRAIMPOST, 'CD_OPERADOR', itemXmlF('CD_USUARIO', PARAM_GLB));
        putitem_e(tTRA_TRAIMPOST, 'DT_CADASTRO', Now);
      end;

      delitem(vDsLstImposto, 1);
    until (vDsLstImposto = '');
  end;

  voParams := calculaTotalTransacao(viParams); (* *)
  if (xStatus < 0) then begin
    Result := voParams;
    return(-1); exit;
  end;

  putitem_e(tTRA_TRANSACAO, 'CD_OPERADOR', itemXmlF('CD_USUARIO', PARAM_GLB));
  putitem_e(tTRA_TRANSACAO, 'DT_CADASTRO', Now);

  if (vCdTranspConhec <> '') then begin
    putitem_e(tTRA_TRANSPORT, 'CD_TRANSPCONHEC', vCdTranspConhec);
    putitem_e(tTRA_TRANSPORT, 'VL_CONHECIMENTO', vVlConhecimento);
  end;
  if (item_f('CD_EMPFAT', tTRA_TRANSPORT) = '' ) and (item_f('CD_TRANSPORT', tTRA_TRANSPORT) > 0) then begin
    putitem_e(tTRA_TRANSPORT, 'CD_EMPFAT', item_f('CD_EMPFAT', tTRA_TRANSACAO));
    putitem_e(tTRA_TRANSPORT, 'CD_GRUPOEMPRESA', item_f('CD_GRUPOEMPRESA', tTRA_TRANSACAO));
    putitem_e(tTRA_TRANSPORT, 'CD_OPERADOR', itemXmlF('CD_USUARIO', PARAM_GLB));
    putitem_e(tTRA_TRANSPORT, 'DT_CADASTRO', Now);
  end;

  voParams := tTRA_TRANSACAO.Salvar();
  if (xStatus < 0) then begin
    Result := voParams;
    return(-1); exit;
  end;

  return(0); exit;
end;

//-----------------------------------------------------------------------
function T_TRASVCO004.gravaValorItemTransacao(pParams : String) : String;
//-----------------------------------------------------------------------
const
  cDS_METHOD = 'ADICIONAL=Operação: T_TRASVCO004.gravaValorItemTransacao()';
var
  viParams, voParams, viListas, vDsRegistro, vDsLstValor, vDsLstVl, vTpValor : String;
  vCdEmpresa, vNrTransacao, vNrItem, vCdCusto, vPrDescPadrao, vPrDescCabPadrao : Real;
  vVlPadrao, vPrImposto, vVlImposto, vVlOriginal, vVlCalc, vTpAtualizacaoPadrao, vTpAtualizacao : Real;
  vVlCustoValorRetido, vVlSubstTributaria : Real;
  vDtTransacao : TDate;
  vInPadrao, vInNaoExclui : Boolean;
begin
  PARAM_GLB := PARAM_GLB;
  vCdEmpresa := itemXmlF('CD_EMPRESA', pParams);
  vNrTransacao := itemXmlF('NR_TRANSACAO', pParams);
  vDtTransacao := itemXml('DT_TRANSACAO', pParams);
  vNrItem := itemXmlF('NR_ITEM', pParams);
  vDsLstValor := itemXml('DS_LSTVALOR', pParams);
  vInNaoExclui := itemXmlB('IN_NAOEXCLUI', pParams);
  if (vCdEmpresa = 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Empresa não informada!', Operação->TRASVCO004.gravaValorItemTransacao);
    return(-1); exit;
  end;
  if (vNrTransacao = 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Número transação não informado!', Operação->TRASVCO004.gravaValorItemTransacao);
    return(-1); exit;
  end;
  if (vDtTransacao = '') then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Data transação não informada!', Operação->TRASVCO004.gravaValorItemTransacao);
    return(-1); exit;
  end;
  if (vNrItem = 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Item da transação não informado!', Operação->TRASVCO004.gravaValorItemTransacao);
    return(-1); exit;
  end;

  clear_e(tTRA_TRANSACAO);
  putitem_o(tTRA_TRANSACAO, 'CD_EMPRESA', vCdEmpresa);
  putitem_o(tTRA_TRANSACAO, 'NR_TRANSACAO', vNrTransacao);
  putitem_o(tTRA_TRANSACAO, 'DT_TRANSACAO', vDtTransacao);
  retrieve_e(tTRA_TRANSACAO);
  if (xStatus < 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Transação ' + FloatToStr(vNrTransacao) + ' não cadastrada!', Operação->TRASVCO004.gravaValorItemTransacao);
    return(-1); exit;
  end;

  voParams := getParam(viParams); (* pParams *) (viParams); (* * item_f('CD_EMPFAT', tTRA_TRANSACAO) *)
  if (xStatus < 0) then begin
    return(-1); exit;
  end;

  clear_e(tTRA_TRANSITEM);
  putitem_o(tTRA_TRANSITEM, 'NR_ITEM', vNrItem);
  retrieve_e(tTRA_TRANSITEM);
  if (xStatus < 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Item ' + FloatToStr(vNrItem) + ' da transação ' + FloatToStr(vNrTransacao) + ' não cadastrada!', Operação->TRASVCO004.gravaValorItemTransacao);
    return(-1); exit;
  end;

  clear_e(tTRA_ITEMVL);
  retrieve_e(tTRA_ITEMVL);
  if (xStatus >= 0) then begin
    if (vInNaoExclui <> True) then begin
      voParams := tTRA_ITEMVL.Excluir();
      if (xStatus < 0) then begin
        Result := voParams;
        return(-1); exit;
      end;
    end;
  end;
  if (vDsLstValor <> '') then begin
    vVlPadrao := 0;
    vPrDescPadrao := 0;
    vPrDescCabPadrao := 0;
    vTpAtualizacaoPadrao := 1;

    repeat
      getitem(vDsRegistro, vDsLstValor, 1);

      vTpValor := itemXmlF('TP_VALOR', vDsRegistro);
      vCdCusto := itemXmlF('CD_VALOR', vDsRegistro);
      vInPadrao := itemXmlB('IN_PADRAO', vDsRegistro);

      if (vTpValor = 'C')  and (vCdCusto = gCdCustoMedio)  and (item_f('TP_OPERACAO', tGER_OPERACAO) = 'E' ) and (item_f('TP_MODALIDADE', tGER_OPERACAO) = 4) then begin
        if (vInPadrao = True) then begin
          Result := SetStatus(STS_ERROR, 'GEN0001', 'Custo padrão médio (CD_CUSTO_MEDIO_CMP) ' + FloatToStr(vCdCusto) + ' não pode ser o custo padrão!', Operação->TRASVCO004.gravaValorItemTransacao);
          return(-1); exit;
        end;
      end else begin
        creocc(tTRA_ITEMVL, -1);
        getlistitensocc_e(vDsRegistro, tTRA_ITEMVL);
        putitem_e(tTRA_ITEMVL, 'CD_EMPFAT', item_f('CD_EMPFAT', tTRA_TRANSITEM));
        putitem_e(tTRA_ITEMVL, 'CD_GRUPOEMPRESA', item_f('CD_GRUPOEMPRESA', tTRA_TRANSITEM));
        putitem_e(tTRA_ITEMVL, 'CD_OPERADOR', itemXmlF('CD_USUARIO', PARAM_GLB));
        putitem_e(tTRA_ITEMVL, 'DT_CADASTRO', Now);

        if (item_b('IN_PADRAO', tTRA_ITEMVL) = True) then begin
          vVlPadrao := item_f('VL_UNITARIO', tTRA_ITEMVL);
          vPrDescPadrao := item_f('PR_DESCONTO', tTRA_ITEMVL);
          vPrDescCabPadrao := item_f('PR_DESCONTOCAB', tTRA_ITEMVL);
          vTpAtualizacaoPadrao := item_f('TP_ATUALIZACAO', tTRA_ITEMVL);
        end;
      end;

      delitem(vDsLstValor, 1);
    until (vDsLstValor = '');

    if (item_f('TP_OPERACAO', tGER_OPERACAO) = 'E')  and (item_f('TP_MODALIDADE', tGER_OPERACAO) = 4 ) or (item_f('TP_MODALIDADE', tGER_OPERACAO) = 2) then begin
      if (vVlPadrao = 0) then begin
        Result := SetStatus(STS_ERROR, 'GEN0001', 'Nenhum valor padrão encontrado na lista de valores!', Operação->TRASVCO004.gravaValorItemTransacao);
        return(-1); exit;
      end;
    end;
    if (item_f('TP_OPERACAO', tGER_OPERACAO) = 'E')  and (item_f('TP_MODALIDADE', tGER_OPERACAO) = 4) then begin
      if (gCdCustoMedio > 0) then begin
        viParams := '';
        putitemXml(viParams, 'CD_EMPRESA', item_f('CD_EMPFAT', tTRA_TRANSITEM));
        putitemXml(viParams, 'CD_PRODUTO', item_f('CD_PRODUTO', tTRA_TRANSITEM));
        putitemXml(viParams, 'TP_VALOR', 'C');
        putitemXml(viParams, 'CD_VALOR', gCdCustoMedio);
        viListas := '';
        voParams := activateCmp('PRDSVCO007', 'buscaValorData', viParams); (*,,viListas,,, *)
        if (xStatus < 0) then begin
          Result := voParams;
          return(-1); exit;
        end;

        vVlOriginal := itemXmlF('VL_VALOR', voParams);

        creocc(tTRA_ITEMVL, -1);
        putitem_e(tTRA_ITEMVL, 'TP_VALOR', 'C');
        putitem_e(tTRA_ITEMVL, 'CD_VALOR', gCdCustoMedio);
        putitem_e(tTRA_ITEMVL, 'TP_ATUALIZACAO', 02);
        putitem_e(tTRA_ITEMVL, 'VL_UNITARIOORIG', vVlOriginal);
        putitem_e(tTRA_ITEMVL, 'VL_UNITARIO', vVlPadrao);
        putitem_e(tTRA_ITEMVL, 'PR_DESCONTO', vPrDescPadrao);
        putitem_e(tTRA_ITEMVL, 'PR_DESCONTOCAB', vPrDescCabPadrao);
        putitem_e(tTRA_ITEMVL, 'CD_EMPFAT', item_f('CD_EMPFAT', tTRA_TRANSITEM));
        putitem_e(tTRA_ITEMVL, 'CD_GRUPOEMPRESA', item_f('CD_GRUPOEMPRESA', tTRA_TRANSITEM));
        putitem_e(tTRA_ITEMVL, 'CD_OPERADOR', itemXmlF('CD_USUARIO', PARAM_GLB));
        putitem_e(tTRA_ITEMVL, 'DT_CADASTRO', Now);
      end;
      if (gDsCustoSubstTributaria <> '') then begin
        clear_e(tF_TRA_ITEMIMP);
        putitem_o(tF_TRA_ITEMIMP, 'CD_EMPRESA', item_f('CD_EMPRESA', tTRA_TRANSITEM));
        putitem_o(tF_TRA_ITEMIMP, 'NR_TRANSACAO', item_f('NR_TRANSACAO', tTRA_TRANSITEM));
        putitem_o(tF_TRA_ITEMIMP, 'DT_TRANSACAO', item_a('DT_TRANSACAO', tTRA_TRANSITEM));
        putitem_o(tF_TRA_ITEMIMP, 'NR_ITEM', item_f('NR_ITEM', tTRA_TRANSITEM));
        putitem_o(tF_TRA_ITEMIMP, 'CD_IMPOSTO', 2);
        retrieve_e(tF_TRA_ITEMIMP);
        if (xStatus >= 0) then begin
          vVlSubstTributaria := item_f('VL_BASECALC', tF_TRA_ITEMIMP) / item_f('QT_SOLICITADA', tTRA_TRANSITEM);
          vVlSubstTributaria := rounded(vVlSubstTributaria, 2);

          scan(gDsCustoSubstTributaria, ';
          vCdCusto := gDsCustoSubstTributaria[1, gresult - 1];
          vTpAtualizacao := gDsCustoSubstTributaria[gresult + 1];

          viParams := '';
          putitemXml(viParams, 'CD_EMPRESA', item_f('CD_EMPFAT', tTRA_TRANSITEM));
          putitemXml(viParams, 'CD_PRODUTO', item_f('CD_PRODUTO', tTRA_TRANSITEM));
          putitemXml(viParams, 'TP_VALOR', 'C');
          putitemXml(viParams, 'CD_VALOR', vCdCusto);
          viListas := '';
          voParams := activateCmp('PRDSVCO007', 'buscaValorData', viParams); (*,,viListas,,, *)
          if (xStatus < 0) then begin
            Result := voParams;
            return(-1); exit;
          end;
          vVlOriginal := itemXmlF('VL_VALOR', voParams);

          creocc(tTRA_ITEMVL, -1);
          putitem_e(tTRA_ITEMVL, 'TP_VALOR', 'C');
          putitem_e(tTRA_ITEMVL, 'CD_VALOR', vCdCusto);
          retrieve_o(tTRA_ITEMVL);
          if (xStatus = -7) then begin
            retrieve_x(tTRA_ITEMVL);
          end;
          putitem_e(tTRA_ITEMVL, 'TP_ATUALIZACAO', vTpAtualizacao);
          putitem_e(tTRA_ITEMVL, 'VL_UNITARIOORIG', vVlOriginal);
          putitem_e(tTRA_ITEMVL, 'VL_UNITARIO', vVlSubstTributaria);
          putitem_e(tTRA_ITEMVL, 'PR_DESCONTO', vPrDescPadrao);
          putitem_e(tTRA_ITEMVL, 'PR_DESCONTOCAB', vPrDescCabPadrao);
          putitem_e(tTRA_ITEMVL, 'CD_EMPFAT', item_f('CD_EMPFAT', tTRA_TRANSITEM));
          putitem_e(tTRA_ITEMVL, 'CD_GRUPOEMPRESA', item_f('CD_GRUPOEMPRESA', tTRA_TRANSITEM));
          putitem_e(tTRA_ITEMVL, 'CD_OPERADOR', itemXmlF('CD_USUARIO', PARAM_GLB));
          putitem_e(tTRA_ITEMVL, 'DT_CADASTRO', Now);
        end;
      end;
      if (gDsCustoValorRetido <> '') then begin
        clear_e(tF_TRA_ITEMIMP);
        putitem_o(tF_TRA_ITEMIMP, 'CD_EMPRESA', item_f('CD_EMPRESA', tTRA_TRANSITEM));
        putitem_o(tF_TRA_ITEMIMP, 'NR_TRANSACAO', item_f('NR_TRANSACAO', tTRA_TRANSITEM));
        putitem_o(tF_TRA_ITEMIMP, 'DT_TRANSACAO', item_a('DT_TRANSACAO', tTRA_TRANSITEM));
        putitem_o(tF_TRA_ITEMIMP, 'NR_ITEM', item_f('NR_ITEM', tTRA_TRANSITEM));
        putitem_o(tF_TRA_ITEMIMP, 'CD_IMPOSTO', 2);
        retrieve_e(tF_TRA_ITEMIMP);
        if (xStatus >= 0) then begin
          vVlCustoValorRetido := item_f('VL_IMPOSTO', tF_TRA_ITEMIMP) / item_f('QT_SOLICITADA', tTRA_TRANSITEM);
          vVlCustoValorRetido := rounded(vVlCustoValorRetido, 2);

          scan(gDsCustoValorRetido, ';
          vCdCusto := gDsCustoValorRetido[1, gresult - 1];
          vTpAtualizacao := gDsCustoValorRetido[gresult + 1];

          viParams := '';
          putitemXml(viParams, 'CD_EMPRESA', item_f('CD_EMPFAT', tTRA_TRANSITEM));
          putitemXml(viParams, 'CD_PRODUTO', item_f('CD_PRODUTO', tTRA_TRANSITEM));
          putitemXml(viParams, 'TP_VALOR', 'C');
          putitemXml(viParams, 'CD_VALOR', vCdCusto);
          viListas := '';
          voParams := activateCmp('PRDSVCO007', 'buscaValorData', viParams); (*,,viListas,,, *)
          if (xStatus < 0) then begin
            Result := voParams;
            return(-1); exit;
          end;
          vVlOriginal := itemXmlF('VL_VALOR', voParams);

          creocc(tTRA_ITEMVL, -1);
          putitem_e(tTRA_ITEMVL, 'TP_VALOR', 'C');
          putitem_e(tTRA_ITEMVL, 'CD_VALOR', vCdCusto);
          retrieve_o(tTRA_ITEMVL);
          if (xStatus = -7) then begin
            retrieve_x(tTRA_ITEMVL);
          end;

          putitem_e(tTRA_ITEMVL, 'TP_ATUALIZACAO', vTpAtualizacao);
          putitem_e(tTRA_ITEMVL, 'VL_UNITARIOORIG', vVlOriginal);
          putitem_e(tTRA_ITEMVL, 'VL_UNITARIO', vVlCustoValorRetido);
          putitem_e(tTRA_ITEMVL, 'PR_DESCONTO', vPrDescPadrao);
          putitem_e(tTRA_ITEMVL, 'PR_DESCONTOCAB', vPrDescCabPadrao);
          putitem_e(tTRA_ITEMVL, 'CD_EMPFAT', item_f('CD_EMPFAT', tTRA_TRANSITEM));
          putitem_e(tTRA_ITEMVL, 'CD_GRUPOEMPRESA', item_f('CD_GRUPOEMPRESA', tTRA_TRANSITEM));
          putitem_e(tTRA_ITEMVL, 'CD_OPERADOR', itemXmlF('CD_USUARIO', PARAM_GLB));
          putitem_e(tTRA_ITEMVL, 'DT_CADASTRO', Now);
        end;
      end;
    end;

    voParams := tTRA_ITEMVL.Salvar();
    if (xStatus < 0) then begin
      Result := voParams;
      return(-1); exit;
    end;
  end;

  return(0); exit;
end;

//-------------------------------------------------------------------
function T_TRASVCO004.removeItemTransacao(pParams : String) : String;
//-------------------------------------------------------------------
const
  cDS_METHOD = 'ADICIONAL=Operação: T_TRASVCO004.removeItemTransacao()';
var
  viParams, voParams, vCdCST : String;
  vCdEmpresa, vNrTransacao, vNrItem, vTpContrInspSaldoLote, vCdOperSaldo : Real;
  vDtTransacao : TDate;
  vInTotal, vInSemMovimento : Boolean;
begin
  PARAM_GLB := PARAM_GLB;
  vCdEmpresa := itemXmlF('CD_EMPRESA', pParams);
  vNrTransacao := itemXmlF('NR_TRANSACAO', pParams);
  vDtTransacao := itemXml('DT_TRANSACAO', pParams);
  vNrItem := itemXmlF('NR_ITEM', pParams);
  vInTotal := itemXmlB('IN_TOTAL', pParams);
  vInSemMovimento := itemXmlB('IN_SEMMOVIMENTO', pParams);

  vTpContrInspSaldoLote := itemXmlF('TP_CONTR_INSP_SALDO_LOTE', PARAM_GLB);

  if (vCdEmpresa = 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Empresa não informada!', Operação->TRASVCO004.removeItemTransacao);
    return(-1); exit;
  end;
  if (vNrTransacao = 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Número transação não informado!', Operação->TRASVCO004.removeItemTransacao);
    return(-1); exit;
  end;
  if (vDtTransacao = '') then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Data transação não informada!', Operação->TRASVCO004.removeItemTransacao);
    return(-1); exit;
  end;
  if (vInTotal = True) then begin
    vNrItem := '';
  end else begin
    if (vNrItem = 0) then begin
      Result := SetStatus(STS_ERROR, 'GEN0001', 'Item da transação não informado!', Operação->TRASVCO004.removeItemTransacao);
      return(-1); exit;
    end;
  end;

  clear_e(tTRA_TRANSACAO);
  putitem_o(tTRA_TRANSACAO, 'CD_EMPRESA', vCdEmpresa);
  putitem_o(tTRA_TRANSACAO, 'NR_TRANSACAO', vNrTransacao);
  putitem_o(tTRA_TRANSACAO, 'DT_TRANSACAO', vDtTransacao);
  retrieve_e(tTRA_TRANSACAO);
  if (xStatus < 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Transação ' + FloatToStr(vNrTransacao) + ' não cadastrada!', Operação->TRASVCO004.removeItemTransacao);
    return(-1); exit;
  end;
  if (item_f('TP_SITUACAO', tTRA_TRANSACAO) <> 1 ) and (item_f('TP_SITUACAO', tTRA_TRANSACAO) <> 2) then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Transação ' + FloatToStr(vNrTransacao) + ' não esta em andamento!', Operação->TRASVCO004.removeItemTransacao);
    return(-1); exit;
  end;

  voParams := getParam(viParams); (* pParams *) (viParams); (* * item_f('CD_EMPFAT', tTRA_TRANSACAO) *)
  if (xStatus < 0) then begin
    return(-1); exit;
  end;
  if (vNrItem < 0) then begin
    setocc(tTRA_TRANSITEM, -1);
    vNrItem := item_f('NR_ITEM', tTRA_TRANSITEM);
  end;

  clear_e(tGER_OPERSALDO);
  putitem_o(tGER_OPERSALDO, 'CD_OPERACAO', item_f('CD_OPERACAO', tTRA_TRANSACAO));
  putitem_o(tGER_OPERSALDO, 'IN_PADRAO', True);
  retrieve_e(tGER_OPERSALDO);
  if (xStatus >= 0) then begin
    vCdOperSaldo := item_f('CD_SALDO', tGER_OPERSALDO);
  end;

  clear_e(tTRA_TRANSITEM);
  putitem_o(tTRA_TRANSITEM, 'NR_ITEM', vNrItem);
  retrieve_e(tTRA_TRANSITEM);
  if (xStatus >= 0) then begin
    if (vTpContrInspSaldoLote <> 1) then begin
      if not (empty(tTRA_ITEMLOTE))  and (vInSemMovimento <> True)  and (item_b('IN_KARDEX', tGER_OPERACAO))  and (item_f('TP_OPERACAO', tTRA_TRANSACAO) = 'S') then begin
        setocc(tTRA_ITEMLOTE, 1);
        while (xStatus >= 0) do begin

          clear_e(tPRD_LOTEI);
          putitem_o(tPRD_LOTEI, 'CD_EMPRESA', item_f('CD_EMPLOTE', tTRA_ITEMLOTE));
          putitem_o(tPRD_LOTEI, 'NR_LOTE', item_f('NR_LOTE', tTRA_ITEMLOTE));
          putitem_o(tPRD_LOTEI, 'NR_ITEM', item_f('NR_ITEMLOTE', tTRA_ITEMLOTE));
          retrieve_e(tPRD_LOTEI);
          if (xStatus >= 0) then begin
            if (vCdOperSaldo <> 0)  and (vCdOperSaldo <> item_f('CD_SALDO', tPRD_LOTEI)) then begin
              Result := SetStatus(STS_ERROR, 'GEN0001', 'Saldo ' + item_a('CD_SALDO', tPRD_LOTEI) + ' do item de lote ' + item_a('CD_EMPRESA', tPRD_LOTEI) + ' / ' + item_a('NR_LOTE', tPRD_LOTEI) + ' / ' + item_a('NR_ITEM', tPRD_LOTEI) + ' diferente do saldo ' + FloatToStr(vCdOperSaldo) + ' que é padrão da operação ' + item_a('CD_OPERACAO', tTRA_TRANSACAO) + '!', Operação->TRASVCO004.removeItemTransacao);
              return(-1); exit;
            end;
          end;

          viParams := '';
          putitemXml(viParams, 'CD_EMPRESA', item_f('CD_EMPLOTE', tTRA_ITEMLOTE));
          putitemXml(viParams, 'NR_LOTE', item_f('NR_LOTE', tTRA_ITEMLOTE));
          putitemXml(viParams, 'NR_ITEM', item_f('NR_ITEMLOTE', tTRA_ITEMLOTE));
          putitemXml(viParams, 'QT_MOVIMENTO', item_f('QT_LOTE', tTRA_ITEMLOTE));
          putitemXml(viParams, 'TP_MOVIMENTO', 'B');
          putitemXml(viParams, 'IN_ESTORNO', True);
          if (item_f('TP_MODALIDADE', tGER_OPERACAO) = 3) then begin
            putitemXml(viParams, 'IN_VALIDASITUACAO', False);
          end;
          voParams := activateCmp('PRDSVCO020', 'movimentaQtLoteI', viParams); (*,,,, *)
          if (xStatus < 0) then begin
            Result := voParams;
            return(-1); exit;
          end;
          setocc(tTRA_ITEMLOTE, curocc(tTRA_ITEMLOTE) + 1);
        end;
      end;
    end;

    viParams := '';
    putitemXml(viParams, 'CD_EMPRESA', item_f('CD_EMPRESA', tTRA_TRANSITEM));
    putitemXml(viParams, 'DT_TRANSACAO', item_a('DT_TRANSACAO', tTRA_TRANSITEM));
    putitemXml(viParams, 'NR_TRANSACAO', item_f('NR_TRANSACAO', tTRA_TRANSITEM));
    putitemXml(viParams, 'NR_ITEM', item_f('NR_ITEM', tTRA_TRANSITEM));
    voParams := activateCmp('TRASVCO016', 'removeSerialTransacao', viParams); (*,,,, *)
    if (xStatus < 0) then begin
      Result := voParams;
      return(-1); exit;
    end;

    voParams := tTRA_TRANSITEM.Excluir();
    if (xStatus < 0) then begin
      Result := voParams;
      return(-1); exit;
    end;

    voParams := calculaTotalTransacao(viParams); (* *)
    if (xStatus < 0) then begin
      Result := voParams;
      return(-1); exit;
    end;

    putitem_e(tTRA_TRANSACAO, 'CD_OPERADOR', itemXmlF('CD_USUARIO', PARAM_GLB));
    putitem_e(tTRA_TRANSACAO, 'DT_CADASTRO', Now);

    voParams := tTRA_TRANSACAO.Salvar();
    if (xStatus < 0) then begin
      Result := voParams;
      return(-1); exit;
    end;
  end;

  return(0); exit;
end;

//----------------------------------------------------------------------
function T_TRASVCO004.gravaenderecoTransacao(pParams : String) : String;
//----------------------------------------------------------------------
const
  cDS_METHOD = 'ADICIONAL=Operação: T_TRASVCO004.gravaenderecoTransacao()';
var
  vDsNome, vTpPessoa, vUfOrigem : String;
  vCdEmpresa, vNrTransacao : Real;
  vDtTransacao : TDate;
  vInSobrepor, vInPjIsento, vInContribuinte, inCFPesJuridica : Boolean;
begin
  PARAM_GLB := PARAM_GLB;
  vCdEmpresa := itemXmlF('CD_EMPRESA', pParams);
  vNrTransacao := itemXmlF('NR_TRANSACAO', pParams);
  vDtTransacao := itemXml('DT_TRANSACAO', pParams);
  vDsNome := itemXml('NM_NOME', pParams);
  vTpPessoa := itemXmlF('TP_PESSOA', pParams);
  vInSobrepor := itemXmlB('IN_SOBREPOR', pParams);
  inCFPesJuridica := itemXmlB('IN_CF_PESJURIDICA', pParams);

  if (vCdEmpresa = 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Empresa não informada!', Operação->TRASVCO004.gravaenderecoTransacao);
    return(-1); exit;
  end;
  if (vNrTransacao = 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Número transação não informado!', Operação->TRASVCO004.gravaenderecoTransacao);
    return(-1); exit;
  end;
  if (vDtTransacao = '') then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Data transação não informada!', Operação->TRASVCO004.gravaenderecoTransacao);
    return(-1); exit;
  end;

  voParams := getParam(viParams); (* pParams *) (viParams); (* * vCdEmpresa *)
  if (xStatus < 0) then begin
    return(-1); exit;
  end;

  clear_e(tTRA_TRANSACAO);
  putitem_o(tTRA_TRANSACAO, 'CD_EMPRESA', vCdEmpresa);
  putitem_o(tTRA_TRANSACAO, 'NR_TRANSACAO', vNrTransacao);
  putitem_o(tTRA_TRANSACAO, 'DT_TRANSACAO', vDtTransacao);
  retrieve_e(tTRA_TRANSACAO);
  if (xStatus < 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Transação ' + FloatToStr(vNrTransacao) + ' não cadastrada!', Operação->TRASVCO004.gravaenderecoTransacao);
    return(-1); exit;
  end;

  clear_e(tTRA_REMDES);
  retrieve_e(tTRA_REMDES);
  if (xStatus >= 0) then begin
    if (vInSobrepor = True)  or (vDsNome <> '') then begin
      voParams := tTRA_REMDES.Excluir();
      if (xStatus < 0) then begin
        Result := voParams;
        return(-1); exit;
      end;
    end else begin
      return(0); exit;
    end;
  end else begin
    clear_e(tTRA_REMDES);
  end;
  if (item_f('TP_DOCTO', tGER_OPERACAO) = 2 ) or (item_f('TP_DOCTO', tGER_OPERACAO) = 3)  and (inCFPesJuridica = True)  and (item_f('TP_PESSOA', tPES_PESSOA) = 'J') then begin
    if (gCdClientePdv <> 0) then begin
      clear_e(tPES_PESSOA);
      putitem_o(tPES_PESSOA, 'CD_PESSOA', gCdClientePdv);
      retrieve_e(tPES_PESSOA);
    end;
  end;

  creocc(tTRA_REMDES, -1);
  if (vDsNome = '') then begin
    clear_e(tV_PES_ENDEREC);
    putitem_o(tV_PES_ENDEREC, 'CD_PESSOA', item_f('CD_PESSOA', tPES_PESSOA));
    putitem_o(tV_PES_ENDEREC, 'NR_SEQUENCIA', item_f('NR_SEQENDERECO', tTRA_TRANSACAO));
    retrieve_e(tV_PES_ENDEREC);
    if (xStatus < 0) then begin
      if (item_f('TP_DOCTO', tGER_OPERACAO) = 2 ) or (item_f('TP_DOCTO', tGER_OPERACAO) = 3)  and (item_f('TP_MODALIDADE', tGER_OPERACAO) = 4 ) or (item_f('TP_MODALIDADE', tGER_OPERACAO) = 8 ) or (item_f('TP_MODALIDADE', tGER_OPERACAO) = 3) then begin
        if (gCdPessoaendPadrao <> '') then begin
          clear_e(tV_PES_ENDEREC);
          putitem_o(tV_PES_ENDEREC, 'CD_PESSOA', gCdPessoaendPadrao);
          putitem_o(tV_PES_ENDEREC, 'NR_SEQUENCIA', item_f('NR_SEQENDERECO', tTRA_TRANSACAO));
          retrieve_e(tV_PES_ENDEREC);
          if (xStatus < 0) then begin
            Result := SetStatus(STS_ERROR, 'GEN0001', 'endereço ' + item_a('NR_SEQendERECO', tTRA_TRANSACAO) + ' não cadastrado para a pessoa ' + FloatToStr(gCdPessoaendPadrao) + '!', Operação->TRASVCO004.gravaenderecoTransacao);
            return(-1); exit;
          end;
        end else begin
          Result := SetStatus(STS_ERROR, 'GEN0001', 'endereço ' + item_a('NR_SEQendERECO', tTRA_TRANSACAO) + ' não cadastrado para a pessoa ' + item_a('CD_PESSOA', tPES_PESSOA) + '!', Operação->TRASVCO004.gravaenderecoTransacao);
          return(-1); exit;
        end;
      end else begin
        Result := SetStatus(STS_ERROR, 'GEN0001', 'endereço ' + item_a('NR_SEQendERECO', tTRA_TRANSACAO) + ' não cadastrado para a pessoa ' + item_a('CD_PESSOA', tPES_PESSOA) + '!', Operação->TRASVCO004.gravaenderecoTransacao);
        return(-1); exit;
      end;
    end;

    vUfOrigem := itemXml('UF_ORIGEM', PARAM_GLB);

    vInPjIsento := False;
    if (item_f('NR_INSCESTL', tPES_PESJURIDI) = 'ISENTO')   or (item_f('NR_INSCESTL', tPES_PESJURIDI) = 'ISENTA')  or %\ then begin
        (putitem_e(tPES_PESJURIDI, 'NR_INSCESTL', 'ISENTOS')  or (item_f('NR_INSCESTL', tPES_PESJURIDI), 'ISENTAS'));
      vInPjIsento := True;
    end;
    if (item_b('IN_CNSRFINAL', tPES_CLIENTE) = True)  or (item_f('TP_PESSOA', tPES_PESSOA) = 'F')  or (vInPjIsento = True) then begin
      if (item_f('TP_PESSOA', tPES_PESSOA) = 'F')  and (item_f('NR_CODIGOFISCAL', tPES_CLIENTE) <> '')  and (vUfOrigem = 'PR' ) or (vUfOrigem = 'SP') then begin
        vInContribuinte := True;
      end else begin
        vInContribuinte := False;
      end;
    end else begin
      vInContribuinte := True;
    end;
    if (inCFPesJuridica = False) then begin
      if (item_f('TP_DOCTO', tGER_OPERACAO) = 2 ) or (item_f('TP_DOCTO', tGER_OPERACAO) = 3) then begin
        if (vInContribuinte = True ) and (item_b('IN_CNSRFINAL', tPES_CLIENTE) <> True) then begin
          Result := SetStatus(STS_ERROR, 'GEN0001', 'Emissão de cupom fiscal para contribuinte não é permitido. Favor emitir Nota Fiscal!', Operação->TRASVCO004.gravaenderecoTransacao);
          return(-1); exit;
        end;
      end;
    end;

    putitem_e(tTRA_REMDES, 'NM_NOME', item_a('NM_PESSOA', tPES_PESSOA));
    putitem_e(tTRA_REMDES, 'TP_PESSOA', item_f('TP_PESSOA', tPES_PESSOA));
    putitem_e(tTRA_REMDES, 'CD_PESSOA', item_f('CD_PESSOA', tPES_PESSOA));
    putitem_e(tTRA_REMDES, 'IN_CONTRIBUINTE', vInContribuinte);
    putitem_e(tTRA_REMDES, 'NR_LOGRADOURO', item_f('NR_LOGRADOURO', tV_PES_ENDEREC));
    putitem_e(tTRA_REMDES, 'NR_CAIXAPOSTAL', item_f('NR_CAIXAPOSTAL', tV_PES_ENDEREC));
    putitem_e(tTRA_REMDES, 'CD_CEP', item_f('CD_CEP', tV_PES_ENDEREC));
    putitem_e(tTRA_REMDES, 'DS_SIGLAESTADO', item_a('DS_SIGLAESTADO', tV_PES_ENDEREC));
    putitem_e(tTRA_REMDES, 'DS_TPLOGRADOURO', item_a('DS_SIGLALOGRAD', tV_PES_ENDEREC));
    if (item_f('TP_PESSOA', tPES_PESSOA) = 'F') then begin
      if (item_f('NR_CODIGOFISCAL', tPES_CLIENTE) = '') then begin
        putitem_e(tTRA_REMDES, 'NR_RGINSCREST', item_f('NR_RG', tPES_PESFISICA));
      end else begin
        putitem_e(tTRA_REMDES, 'NR_RGINSCREST', item_f('NR_CODIGOFISCAL', tPES_CLIENTE));
      end;
    end else begin
      putitem_e(tTRA_REMDES, 'NR_RGINSCREST', item_f('NR_INSCESTL', tPES_PESJURIDI));
    end;
    putitem_e(tTRA_REMDES, 'NR_CPFCNPJ', item_f('NR_CPFCNPJ', tPES_PESSOA));
    clear_e(tPES_TELEFONE);
    putitem_o(tPES_TELEFONE, 'IN_PADRAO', True);
    retrieve_e(tPES_TELEFONE);
    if (xStatus >= 0) then begin
      putitem_e(tTRA_REMDES, 'NR_TELEFONE', item_f('NR_TELEFONE', tPES_TELEFONE));
    end else begin
      clear_e(tPES_TELEFONE);
      retrieve_e(tPES_TELEFONE);
      if (xStatus >= 0) then begin
        putitem_e(tTRA_REMDES, 'NR_TELEFONE', item_f('NR_TELEFONE', tPES_TELEFONE));
      end;
    end;
    putitem_e(tTRA_REMDES, 'NM_BAIRRO', item_a('DS_BAIRRO', tV_PES_ENDEREC));
    putitem_e(tTRA_REMDES, 'NM_LOGRADOURO', item_a('NM_LOGRADOURO', tV_PES_ENDEREC));
    putitem_e(tTRA_REMDES, 'NM_COMPLEMENTO', item_a('DS_COMPLEMENTO', tV_PES_ENDEREC)[1 : 60]);
    putitem_e(tTRA_REMDES, 'NM_MUNICIPIO', item_a('NM_MUNICIPIO', tV_PES_ENDEREC));
    if (item_f('CD_PESSOA', tTRA_REMDES) = 0) then begin
      putitem_e(tTRA_REMDES, 'CD_PESSOA', item_f('CD_PESSOA', tPES_PESSOA));
    end;
  end else begin
    if (vTpPessoa = '') then begin
      Result := SetStatus(STS_ERROR, 'GEN0001', 'Tipo de pessoa não informado!', Operação->TRASVCO004.gravaenderecoTransacao);
      return(-1); exit;
    end;
    delitem(pParams, 'CD_EMPRESA');
    delitem(pParams, 'NR_TRANSACAO');
    delitem(pParams, 'DT_TRANSACAO');
    getlistitensocc_e(pParams, tTRA_REMDES);
  end;

  putitem_e(tTRA_REMDES, 'CD_EMPFAT', item_f('CD_EMPFAT', tTRA_TRANSACAO));
  putitem_e(tTRA_REMDES, 'CD_GRUPOEMPRESA', item_f('CD_GRUPOEMPRESA', tTRA_TRANSACAO));
  putitem_e(tTRA_REMDES, 'CD_OPERADOR', itemXmlF('CD_USUARIO', PARAM_GLB));
  putitem_e(tTRA_REMDES, 'DT_CADASTRO', Now);

  voParams := tTRA_REMDES.Salvar();
  if (xStatus < 0) then begin
    Result := voParams;
    return(-1); exit;
  end;

  return(0); exit;
end;

//------------------------------------------------------------------------
function T_TRASVCO004.gravaObservacaoTransacao(pParams : String) : String;
//------------------------------------------------------------------------
const
  cDS_METHOD = 'ADICIONAL=Operação: T_TRASVCO004.gravaObservacaoTransacao()';
var
  vDsObservacao, vCdComponente, vInManutencao : String;
  vCdEmpresa, vNrTransacao, vNrLinha : Real;
  vDtTransacao : TDate;
begin
  PARAM_GLB := PARAM_GLB;
  vCdEmpresa := itemXmlF('CD_EMPRESA', pParams);
  vNrTransacao := itemXmlF('NR_TRANSACAO', pParams);
  vDtTransacao := itemXml('DT_TRANSACAO', pParams);
  vInManutencao := itemXmlB('IN_MANUTENCAO', pParams);
  vCdComponente := itemXmlF('CD_COMPONENTE', pParams);
  vDsObservacao := itemXml('DS_OBSERVACAO', pParams);

  if  (vInManutencao = '');
    vInManutencao := True;
  end;
  if (vCdEmpresa = 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Empresa não informada!', Operação->TRASVCO004.gravaObservacaoTransacao);
    return(-1); exit;
  end;
  if (vNrTransacao = 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Número transação não informado!', Operação->TRASVCO004.gravaObservacaoTransacao);
    return(-1); exit;
  end;
  if (vDtTransacao = '') then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Data transação não informada!', Operação->TRASVCO004.gravaObservacaoTransacao);
    return(-1); exit;
  end;
  if (vCdComponente = '') then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Nome do componente não informado!', Operação->TRASVCO004.gravaObservacaoTransacao);
    return(-1); exit;
  end;
  if (vDsObservacao = '') then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Observação não informada!', Operação->TRASVCO004.gravaObservacaoTransacao);
    return(-1); exit;
  end;

  clear_e(tTRA_TRANSACAO);
  putitem_o(tTRA_TRANSACAO, 'CD_EMPRESA', vCdEmpresa);
  putitem_o(tTRA_TRANSACAO, 'NR_TRANSACAO', vNrTransacao);
  putitem_o(tTRA_TRANSACAO, 'DT_TRANSACAO', vDtTransacao);
  retrieve_e(tTRA_TRANSACAO);
  if (xStatus < 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Transação ' + FloatToStr(vNrTransacao) + ' não cadastrada!', Operação->TRASVCO004.gravaenderecoTransacao);
    return(-1); exit;
  end;

  if  (empty(OBS_TRANSACAO));
    sort_e(tOBS_TRANSACAO, '    sort/e , NR_LINHA;');
    setocc(tOBS_TRANSACAO, -1);
    vNrLinha := item_f('NR_LINHA', tOBS_TRANSACAO);
  end;
  vNrLinha := vNrLinha + 1;

  clear_e(tOBS_TRANSACAO);

  putitem_e(tOBS_TRANSACAO, 'NR_LINHA', vNrLinha);
  putitem_e(tOBS_TRANSACAO, 'IN_MANUTENCAO', vInManutencao);
  putitem_e(tOBS_TRANSACAO, 'CD_COMPONENTE', vCdComponente);
  putitem_e(tOBS_TRANSACAO, 'DS_OBSERVACAO', vDsObservacao[1 : 80]);
  putitem_e(tOBS_TRANSACAO, 'CD_OPERADOR', gModulo.GCDUSUARIO);
  putitem_e(tOBS_TRANSACAO, 'DT_CADASTRO', Now);

  voParams := tOBS_TRANSACAO.Salvar();
  if (xStatus < 0) then begin
    Result := voParams;
    return(-1); exit;
  end;

  return(0); exit;
end;

end.
