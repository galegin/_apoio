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
    tF_TRA_ITEMIMPOSTO,
    tGER_S_OPERACAO,
    tBAL_BALANCOTR,
    tFIS_REGRAIMPOSTO,
    tGER_EMPRESA,
    tGER_OPERACAO,
    tGER_OPERSALDOPRD,
    tOBS_TRANSACAO,
    tPED_PEDIDOTRA,
    tPES_CLIENTE,
    tPES_PESFISICA,
    tPES_PESJURIDICA,
    tPES_PESSOA,
    tPES_TELEFONE,
    //tPRD_LOTEI,
    tTMP_NR09,
    tTRA_ITEMIMPOSTO,
    //tTRA_ITEMLOTE,
    tTRA_ITEMVL,
    tTRA_REMDES,
    tTRA_TRAIMPOSTO,
    tTRA_TRANSACAO,
    tTRA_TRANSACSIT,
    tTRA_TRANSITEM,
    tTRA_TRANSPORT,
    tV_BAL_BALANCO,
    tV_PES_ENDERECO,
    tV_TRA_TOTATRA,
    tV_TRA_TOTITEM,
    tSIS_PARCELAMENTO,
    tPRD_PRDREGRAFISCAL,
    tFIS_REGRAADIC,
    tTRA_ITEMADIC : TcDatasetUnf;
  protected
    function getParam(pParams : String = '') : String; override;
    function setEntidade(pParams : String = '') : String; override;
    procedure tV_PES_ENDERECO_posREAD(DataSet : TDataset);
  public
  published
    function alteraAdicional(pParams : String = '') : String;
    function alteraImpressaoTransacao(pParams : String = '') : String;
    function alteraSituacaoTransacao(pParams : String = '') : String;
    function alteraVendedorTransacaoNF(pParams : String = '') : String;
    function atualizaEstoqueTransacao(pParams : String = '') : String;
    function calculaTotalOtimizado(pParams : String = '') : String;
    function calculaTotalTransacao(pParams : String = '') : String;
    function gravaCapaTransacao(pParams : String = '') : String;
    function gravaEnderecoTransacao(pParams : String = '') : String;
    function gravaImpostoItemTransacao(pParams : String = '') : String;
    function gravaItemTransacao(pParams : String = '') : String;
    function gravaObservacaoTransacao(pParams : String = '') : String;
    function gravaParcelaTransacao(pParams : String = '') : String;
    function gravaTotalTransacao(pParams : String = '') : String;
    function gravaTransportTransacao(pParams : String = '') : String;
    function gravaValorItemTransacao(pParams : String = '') : String;
    function removeItemTransacao(pParams : String = '') : String;
    function validaGuiaRepreCliente(pParams : String = '') : String;
    function validaItemTransacao(pParams : String = '') : String;
    function validaProdutoBalanco(pParams : String = '') : String;
  end;

implementation

uses
  cActivate, cStatus, cFuncao, cXml, dModulo, cDataSet;

const
  debug = false;

var
  gCdClientePdv,
  gCdCustoMedio,
  gCdEmpParam,
  gCdOperacaoOI,
  gInBloqSaldoNeg,
  gCdPessoaEndPadrao : Real;

  gCdOperKardex,
  gCdEspecieServico,
  gDsCustoSubstTributaria,
  gDsCustoValorRetido,
  gDsLstValorVenda,
  gDsSepBarraPrd : String;

  gHrFim,
  gHrInicio,
  gHrTempo : TDateTime;

  gInTransacaoItem,
  gInGravaRepreGuiaTra,
  gInGravaTraBloq,
  gInGuiaReprAuto,
  gInSomaFrete : Boolean;

  gNrDiaVencto,
  gNrItemQuebraNf,
  gTpDataVenctoParcela,
  gTpModDctoFiscal,
  gTpNumeracaoTra,
  gTpTabPrecoPed,
  gTpUtilizaDtBasePgto,
  gTpValidaTransacaoPrd,
  gTpValorBrutoPromocao,
  gVlMinimoParcela : Real;

//---------------------------------------------------------------
function T_TRASVCO004.getParam(pParams : String = '') : String;
//---------------------------------------------------------------
var
  piCdEmpresa : Real;
  vResult : String;
begin
  piCdEmpresa := itemXmlF('CD_EMPRESA', pParams);
  if (piCdEmpresa = 0) then begin
    piCdEmpresa := itemXmlF('CD_EMPRESA', PARAM_GLB);
  end;

  xParam := '';
  //putitem(xParam, 'CLIENTE_PDV');
  putitem(xParam, 'DS_SEP_NRSEQ_BARRA_PRD');
  xParam := activateCmp('ADMSVCO001', 'GetParametro', xParam);

  //gCdClientePdv := itemXmlF('CLIENTE_PDV', xParam);
  gDsSepBarraPrd := itemXml('DS_SEP_NRSEQ_BARRA_PRD', xParam);
  
  vResult := activateCmp('PESSVCL001', 'getClientePdv', '');
  gCdClientePdv := itemXmlF('CLIENTE_PDV', vResult);  

  xParamEmp := '';
  //putitem(xParamEmp, 'CD_CLIENTE_PDV_EMP');
  putitem(xParamEmp, 'CD_CUSTO_MEDIO_CMP');
  putitem(xParamEmp, 'CD_CUSTO_VALIDA_VENDA');
  putitem(xParamEmp, 'CD_OPER_ESTOQ_PROD_OI');
  putitem(xParamEmp, 'CD_OPER_GRAVA_ZERO_KARDEX');
  putitem(xParamEmp, 'CD_PESSOA_ENDERECO_PADRAO');
  //putitem(xParamEmp, 'CLIENTE_PDV');
  putitem(xParamEmp, 'DS_CUSTO_SUBST_TRIBUTARIA');
  putitem(xParamEmp, 'DS_CUSTO_VALOR_RETIDO');
  putitem(xParamEmp, 'DS_LST_VLR_VENDA');
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
  xParamEmp := activateCmp('ADMSVCO001', 'GetParamEmpresa', piCdEmpresa, xParamEmp);

  gCdCustoMedio := itemXmlF('CD_CUSTO_MEDIO_CMP', xParamEmp);
  gCdOperacaoOI := itemXmlF('CD_OPER_ESTOQ_PROD_OI', xParamEmp);
  gCdOperKardex := itemXml('CD_OPER_GRAVA_ZERO_KARDEX', xParamEmp);
  gCdPessoaEndPadrao := itemXmlF('CD_PESSOA_ENDERECO_PADRAO', xParamEmp);
  gDsCustoSubstTributaria := itemXml('DS_CUSTO_SUBST_TRIBUTARIA', xParamEmp);
  gDsCustoValorRetido := itemXml('DS_CUSTO_VALOR_RETIDO', xParamEmp);
  gDsLstValorVenda := itemXml('DS_LST_VLR_VENDA', xParamEmp);
  gInBloqSaldoNeg := itemXmlF('IN_BLOQ_SALDO_NEG', xParamEmp);
  gInGravaRepreGuiaTra := itemXmlB('IN_GRAVA_REPREGUIA_TRA', xParamEmp);
  gInGravaTraBloq := itemXmlB('IN_GRAVA_TRANS_BLOQUEADA', xParamEmp);
  gInGuiaReprAuto := itemXmlB('IN_GUIA_REPR_AUTO_TRA_VD', xParamEmp);
  gInSomaFrete := itemXmlB('IN_SOMA_FRETE_TOTALNF', xParamEmp);
  gNrDiaVencto := itemXmlF('NR_DIA_ATRASO_BLOQ_FAT', xParamEmp);
  gNrItemQuebraNf := itemXmlF('NR_ITEM_QUEBRA_NF', xParamEmp);
  gTpDataVenctoParcela := itemXmlF('TP_DT_VENCIMENTO_PARCELA', xParamEmp);
  gTpNumeracaoTra := itemXmlF('TP_NUMERACAO_TRA', xParamEmp);
  gTpTabPrecoPed := itemXmlF('TP_TABPRECO_PED', xParamEmp);
  gTpUtilizaDtBasePgto := itemXmlF('TP_UTIL_DT_BASEPGTO_PED', xParamEmp);
  gTpValidaTransacaoPrd := itemXmlF('TP_VALIDA_TRANSACAO_PRD', xParamEmp);
  gTpValorBrutoPromocao := itemXmlF('TP_VALORBRUTO_PROMOCAO', xParamEmp);
  gVlMinimoParcela := itemXmlF('VL_MINIMO_PARCELA', xParamEmp);
end;

//---------------------------------------------------------------
function T_TRASVCO004.setEntidade(pParams : String = '') : String;
//---------------------------------------------------------------
begin
  tF_TRA_ITEMIMPOSTO := GetEntidade('TRA_ITEMIMPOSTO', 'F_TRA_ITEMIMPOSTO');
  tGER_S_OPERACAO := GetEntidade('GER_OPERACAO', 'GER_S_OPERACAO');
  //tBAL_BALANCOTR := GetEntidade('BAL_BALANCOTR');
  tFIS_REGRAIMPOSTO := GetEntidade('FIS_REGRAIMPOSTO');
  tGER_EMPRESA := GetEntidade('GER_EMPRESA');
  tGER_OPERACAO := GetEntidade('GER_OPERACAO');
  tGER_OPERSALDOPRD := GetEntidade('GER_OPERSALDOPRD');
  tOBS_TRANSACAO := GetEntidade('OBS_TRANSACAO');
  //tPED_PEDIDOTRA := GetEntidade('PED_PEDIDOTRA');
  tPES_CLIENTE := GetEntidade('PES_CLIENTE');
  tPES_PESFISICA := GetEntidade('PES_PESFISICA');
  tPES_PESJURIDICA := GetEntidade('PES_PESJURIDICA');
  tPES_PESSOA := GetEntidade('PES_PESSOA');
  tPES_TELEFONE := GetEntidade('PES_TELEFONE');
  //tPRD_LOTEI := GetEntidade('PRD_LOTEI');
  tTMP_NR09 := GetEntidade('TMP_NR09');
  tTRA_ITEMIMPOSTO := GetEntidade('TRA_ITEMIMPOSTO');
  //tTRA_ITEMLOTE := GetEntidade('TRA_ITEMLOTE');
  tTRA_ITEMVL := GetEntidade('TRA_ITEMVL');
  tTRA_REMDES := GetEntidade('TRA_REMDES');
  tTRA_TRAIMPOSTO := GetEntidade('TRA_TRAIMPOSTO');
  tTRA_TRANSACAO := GetEntidade('TRA_TRANSACAO');
  tTRA_TRANSACSIT := GetEntidade('TRA_TRANSACSIT');
  tTRA_TRANSITEM := GetEntidade('TRA_TRANSITEM');
  tTRA_TRANSPORT := GetEntidade('TRA_TRANSPORT');
  //tV_BAL_BALANCO := GetEntidade('V_BAL_BALANCO');
  //tV_TRA_TOTATRA := GetEntidade('V_TRA_TOTATRA');
  tV_TRA_TOTITEM := GetEntidade('V_TRA_TOTITEM');
  tPRD_PRDREGRAFISCAL := GetEntidade('PRD_PRDREGRAFISCAL');
  tFIS_REGRAADIC := GetEntidade('FIS_REGRAADIC');
  tTRA_ITEMADIC := GetEntidade('TRA_ITEMADIC');

  // metadata ???
  tSIS_PARCELAMENTO := TcDataSetUnf.Create(Self);
  tSIS_PARCELAMENTO.SetMetadataTmp('VL_PARCELA:N(10)|VL_DOCUMENTO:N(10)|DT_VENCIMENTO:D(10)|TP_DOCUMENTO:N(2)|DS_OBSERVACAO:A(100)|DS_ADICIONAL:A(200)|NR_DOCUMENTO:N(10)|');

  // filhas ???
  tPES_PESSOA._LstFilha := 'PES_CLIENTE|PES_TELEFONE|PES_PESJURIDICA|PES_PESFISICA|';
  tTRA_TRANSACAO._LstFilha := 'GER_EMPRESA|PES_PESSOA|GER_OPERACAO|TRA_REMDES:u|TRA_TRANSPORT:u|TRA_TRANSITEM:u|';
  //tTRA_TRANSITEM._LstFilha := 'TRA_ITEMIMPOSTO:u|';
  tTRA_TRANSITEM._LstFilha := 'TRA_ITEMVL:u|';

  // calculados ???
  tTRA_TRANSITEM._LstCalc := 'PR_IPI|VL_IPI|';

  // endereco ???
  tV_PES_ENDERECO := GetEntidade('PES_ENDERECO');
  tV_PES_ENDERECO._posREAD := tV_PES_ENDERECO_posREAD;
  tV_PES_ENDERECO._LstCalc := 'V_PES_ENDERECO';
end;

//---------------------------------------------------------------------
procedure T_TRASVCO004.tV_PES_ENDERECO_posREAD(DataSet : TDataset);
//---------------------------------------------------------------------
var viParams, voParams : String;
begin
  if (itemF('CD_PESSOA', tV_PES_ENDERECO) <> 0)
  and (itemF('NR_SEQUENCIA', tV_PES_ENDERECO) <> 0) then begin
    viParams := '';
    putitemXml(viParams, 'CD_PESSOA', itemF('CD_PESSOA', tV_PES_ENDERECO));
    putitemXml(viParams, 'NR_SEQUENCIA', itemF('NR_SEQUENCIA', tV_PES_ENDERECO));
    voParams := activateCmp('PESSVCO001', 'buscarEndereco', viParams);
    getlistitensocc_e(voParams, tV_PES_ENDERECO);
  end;
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
  if debug then MensagemLog(cDS_METHOD, 'pParams: ' + pParams);

  //-- MFGALEGO - 22/10/2014 ; otimizar totalizacao da transacao
  if IffNuloB(LeIni('IN_TOTAL_OTIMIZADO', ''), True) then begin
    Result := calculaTotalOtimizado(pParams);
    Exit;
  end;
  //--

  vQtSolicitada := 0;
  vVlTransacao := 0;
  vVlTotalBruto := 0;
  vVlDesconto := 0;
  vVlBaseICMS := 0;
  vVlICMS := 0;
  vVlBaseICMSSubst := 0;
  vVlICMSSubst := 0;
  vVlIPI := 0;

  if debug then MensagemLogTempo('inicio');

  if (itemXmlB('IN_CONSULTAR', pParams) = True) then begin
    if (itemXmlF('CD_EMPRESA', pParams) = 0) then begin
      Result := SetStatus(STS_ERROR, 'GEN001', 'Empresa não informada!', cDS_METHOD);
      return(-1); exit;
    end;
    if (itemXmlF('NR_TRANSACAO', pParams) = 0) then begin
      Result := SetStatus(STS_ERROR, 'GEN001', 'Número da transação não informada!', cDS_METHOD);
      return(-1); exit;
    end;
    if (itemXml('DT_TRANSACAO', pParams) = '') then begin
      Result := SetStatus(STS_ERROR, 'GEN001', 'Data transação não informada!', cDS_METHOD);
      return(-1); exit;
    end;

    clear_e(tTRA_TRANSACAO);
    putitem_o(tTRA_TRANSACAO, 'CD_EMPRESA', itemXmlF('CD_EMPRESA', pParams));
    putitem_o(tTRA_TRANSACAO, 'NR_TRANSACAO', itemXmlF('NR_TRANSACAO', pParams));
    putitem_o(tTRA_TRANSACAO, 'DT_TRANSACAO', itemXml('DT_TRANSACAO', pParams));
    retrieve_e(tTRA_TRANSACAO);
    if (xStatus < 0) then begin
      Result := SetStatus(STS_ERROR, 'GEN001', 'Transação ' + itemXml('NR_TRANSACAO', pParams) + ' não encontrada!', cDS_METHOD);
      return(-1); exit;
    end;
  end else begin
    if (itemF('CD_EMPRESA', tTRA_TRANSACAO) = 0)
    or (itemF('NR_TRANSACAO', tTRA_TRANSACAO) = 0)
    or (item('DT_TRANSACAO', tTRA_TRANSACAO) = '') then begin
      return(-1); exit;
    end;

    clear_e(tTRA_TRANSITEM);
    putitem_o(tTRA_TRANSITEM, 'CD_EMPRESA', itemF('CD_EMPRESA', tTRA_TRANSACAO));
    putitem_o(tTRA_TRANSITEM, 'NR_TRANSACAO', itemF('NR_TRANSACAO', tTRA_TRANSACAO));
    putitem_o(tTRA_TRANSITEM, 'DT_TRANSACAO', item('DT_TRANSACAO', tTRA_TRANSACAO));
    retrieve_e(tTRA_TRANSITEM);
  end;

  if debug then MensagemLogTempo('transacao');

  if (empty(tTRA_TRANSITEM) = False) then begin
    setocc(tTRA_TRANSITEM, 1);
    while (xStatus >= 0) do begin
      vQtSolicitada := vQtSolicitada + itemF('QT_SOLICITADA', tTRA_TRANSITEM);
      vVlTransacao := vVlTransacao + itemF('VL_TOTALLIQUIDO', tTRA_TRANSITEM);
      vVlTotalBruto := vVlTotalBruto + itemF('VL_TOTALBRUTO', tTRA_TRANSITEM);
      vVlDesconto := vVlDesconto + (itemF('VL_TOTALDESC', tTRA_TRANSITEM) + itemF('VL_TOTALDESCCAB', tTRA_TRANSITEM));
      if (empty(tTRA_ITEMIMPOSTO) = False) then begin
        setocc(tTRA_ITEMIMPOSTO, 1);
        while (xStatus >= 0) do begin
          if (itemF('CD_IMPOSTO', tTRA_ITEMIMPOSTO) = 1) then begin
            vVlBaseICMS := vVlBaseICMS + itemF('VL_BASECALC', tTRA_ITEMIMPOSTO);
            vVlICMS := vVlICMS + itemF('VL_IMPOSTO', tTRA_ITEMIMPOSTO);
          end else if (itemF('CD_IMPOSTO', tTRA_ITEMIMPOSTO) = 2) then begin
            vVlBaseICMSSubst := vVlBaseICMSSubst + itemF('VL_BASECALC', tTRA_ITEMIMPOSTO);
            vVlICMSSubst := vVlICMSSubst + itemF('VL_IMPOSTO', tTRA_ITEMIMPOSTO);
          end else if (itemF('CD_IMPOSTO', tTRA_ITEMIMPOSTO) = 3) then begin
            vVlIPI := vVlIPI + itemF('VL_IMPOSTO', tTRA_ITEMIMPOSTO);
          end;
          setocc(tTRA_ITEMIMPOSTO, curocc(tTRA_ITEMIMPOSTO) + 1);
        end;
      end;
      setocc(tTRA_TRANSITEM, curocc(tTRA_TRANSITEM) + 1);
    end;
  end;

  if debug then MensagemLogTempo('totaliza items');

  if (empty(tTRA_TRAIMPOSTO) = False) then begin
    vNrOccAnt := curocc(tTRA_TRAIMPOSTO);
    setocc(tTRA_TRAIMPOSTO, 1);
    while (xStatus >= 0) do begin
      if (itemF('CD_IMPOSTO', tTRA_TRAIMPOSTO) = 1) then begin
        vVlBaseICMS := vVlBaseICMS + itemF('VL_BASECALC', tTRA_TRAIMPOSTO);
        vVlICMS := vVlICMS + itemF('VL_IMPOSTO', tTRA_TRAIMPOSTO);
      end else if (itemF('CD_IMPOSTO', tTRA_TRAIMPOSTO) = 2) then begin
        vVlBaseICMSSubst := vVlBaseICMSSubst + itemF('VL_BASECALC', tTRA_TRAIMPOSTO);
        vVlICMSSubst := vVlICMSSubst + itemF('VL_IMPOSTO', tTRA_TRAIMPOSTO);
      end else if (itemF('CD_IMPOSTO', tTRA_TRAIMPOSTO) = 3) then begin
        vVlIPI := vVlIPI + itemF('VL_IMPOSTO', tTRA_TRAIMPOSTO);
      end;
      setocc(tTRA_TRAIMPOSTO, curocc(tTRA_TRAIMPOSTO) + 1);
    end;
    setocc(tTRA_TRAIMPOSTO, 1);
  end;

  if debug then MensagemLogTempo('totaliza imposto');

  //try vVlCalc := (vVlTotalBruto - vVlTransacao) / vVlTotalBruto * 100;
  //if (vVlCalc < 0) then vVlCalc := 0;
  //except vVlCalc := 0;
  //end;
  vVlCalc := (vVlTotalBruto - vVlTransacao) / DivByZero(vVlTotalBruto) * 100;

  if debug then MensagemLogTempo('valor calc');

  putitem_e(tTRA_TRANSACAO, 'PR_DESCONTO', rounded(vVlCalc, 6));
  putitem_e(tTRA_TRANSACAO, 'QT_SOLICITADA', vQtSolicitada);
  putitem_e(tTRA_TRANSACAO, 'VL_TRANSACAO', vVlTransacao);
  putitem_e(tTRA_TRANSACAO, 'VL_DESCONTO', vVlDesconto);
  putitem_e(tTRA_TRANSACAO, 'VL_BASEICMS', rounded(vVlBaseICMS, 2));
  putitem_e(tTRA_TRANSACAO, 'VL_ICMS', rounded(vVlICMS, 2));
  putitem_e(tTRA_TRANSACAO, 'VL_BASEICMSSUBST', rounded(vVlBaseICMSSubst, 2));
  putitem_e(tTRA_TRANSACAO, 'VL_ICMSSUBST', rounded(vVlICMSSubst, 2));
  putitem_e(tTRA_TRANSACAO, 'VL_IPI', rounded(vVlIPI, 2));

  if debug then MensagemLogTempo('valores');

  if (item('TP_FRETE', tTRA_TRANSPORT) = '2') then begin
    vVlFrete := itemF('VL_FRETE', tTRA_TRANSACAO);
  end else begin
    if (gInSomaFrete = True) then begin
      vVlFrete := itemF('VL_FRETE', tTRA_TRANSACAO);
    end else begin
      vVlFrete := 0;
    end;
  end;

  if debug then MensagemLogTempo('valor frete');

  {
    corrigir gravacao dos totais da transacao
    - VL_TRANSACAO = gravar valor total bruto
    - VL_DESCONTO  = gravar valor total de desconto
    - VL_TOTAL     = (valor dos produtos) + (acrescimos) - (descontos)
  }

  putitem_e(tTRA_TRANSACAO, 'VL_TOTAL', itemF('VL_TRANSACAO', tTRA_TRANSACAO) +
                                        itemF('VL_IPI', tTRA_TRANSACAO) +
                                        vVlFrete +
                                        itemF('VL_SEGURO', tTRA_TRANSACAO) +
                                        itemF('VL_DESPACESSOR', tTRA_TRANSACAO) +
                                        itemF('VL_ICMSSUBST', tTRA_TRANSACAO));

  if (itemXmlB('IN_CONSULTAR', pParams) = True) then begin
    putlistitensocc_e(Result, tTRA_TRANSACAO);
    if debug then MensagemLogTempo('retorna total da transacao');
  end;

  if debug then MensagemLogTempo('frete');

  if debug then MensagemLog(cDS_METHOD, 'Result: ' + Result);

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
  if debug then MensagemLog(cDS_METHOD, 'pParams: ' + pParams);

  if (itemXmlB('IN_CONSULTAR', pParams) = True) then begin
    if (itemXmlF('CD_EMPRESA', pParams) = 0) then begin
      Result := SetStatus(STS_ERROR, 'GEN001', 'Empresa não informada!', cDS_METHOD);
      return(-1); exit;
    end;
    if (itemXmlF('NR_TRANSACAO', pParams) = 0) then begin
      Result := SetStatus(STS_ERROR, 'GEN001', 'Número da transação não informada!', cDS_METHOD);
      return(-1); exit;
    end;
    if (itemXml('DT_TRANSACAO', pParams) = '') then begin
      Result := SetStatus(STS_ERROR, 'GEN001', 'Data transação não informada!', cDS_METHOD);
      return(-1); exit;
    end;

    clear_e(tTRA_TRANSACAO);
    putitem_o(tTRA_TRANSACAO, 'CD_EMPRESA', itemXmlF('CD_EMPRESA', pParams));
    putitem_o(tTRA_TRANSACAO, 'NR_TRANSACAO', itemXmlF('NR_TRANSACAO', pParams));
    putitem_o(tTRA_TRANSACAO, 'DT_TRANSACAO', itemXml('DT_TRANSACAO', pParams));
    retrieve_e(tTRA_TRANSACAO);
    if (xStatus < 0) then begin
      Result := SetStatus(STS_ERROR, 'GEN001', 'Transação ' + itemXml('NR_TRANSACAO', pParams) + ' não encontrada!', cDS_METHOD);
      return(-1); exit;
    end;
  end else begin
    if (itemF('CD_EMPRESA', tTRA_TRANSACAO) = 0)
    or (itemF('NR_TRANSACAO', tTRA_TRANSACAO) = 0)
    or (item('DT_TRANSACAO', tTRA_TRANSACAO) = '') then begin
      return(-1); exit;
    end;
  end;

  clear_e(tV_TRA_TOTITEM);
  putitem_o(tV_TRA_TOTITEM, 'CD_EMPRESA', itemF('CD_EMPRESA', tTRA_TRANSACAO));
  putitem_o(tV_TRA_TOTITEM, 'NR_TRANSACAO', itemF('NR_TRANSACAO', tTRA_TRANSACAO));
  putitem_o(tV_TRA_TOTITEM, 'DT_TRANSACAO', item('DT_TRANSACAO', tTRA_TRANSACAO));
  retrieve_e(tV_TRA_TOTITEM);
  if (xStatus >= 0) then begin
    vVlCalc := (itemF('VL_TOTALDESC', tV_TRA_TOTITEM) + itemF('VL_TOTALDESCCAB', tV_TRA_TOTITEM)) / itemF('VL_TOTALBRUTO', tV_TRA_TOTITEM) * 100;
    putitem_e(tTRA_TRANSACAO, 'PR_DESCONTO', rounded(vVlCalc, 6));
    putitem_e(tTRA_TRANSACAO, 'QT_SOLICITADA', itemF('QT_SOLICITADA', tV_TRA_TOTITEM));
    putitem_e(tTRA_TRANSACAO, 'VL_TRANSACAO', itemF('VL_TOTALLIQUIDO', tV_TRA_TOTITEM));
    putitem_e(tTRA_TRANSACAO, 'VL_DESCONTO', itemF('VL_TOTALDESC', tV_TRA_TOTITEM) + itemF('VL_TOTALDESCCAB', tV_TRA_TOTITEM));
    putitem_e(tTRA_TRANSACAO, 'VL_BASEICMS', itemF('VL_BASEICMS', tV_TRA_TOTITEM));
    putitem_e(tTRA_TRANSACAO, 'VL_ICMS', itemF('VL_ICMS', tV_TRA_TOTITEM));
    putitem_e(tTRA_TRANSACAO, 'VL_BASEICMSSUBST', itemF('VL_BASEICMSSUBST', tV_TRA_TOTITEM));
    putitem_e(tTRA_TRANSACAO, 'VL_ICMSSUBST', itemF('VL_ICMSSUBST', tV_TRA_TOTITEM));
    putitem_e(tTRA_TRANSACAO, 'VL_IPI', itemF('VL_IPI', tV_TRA_TOTITEM));
    if (itemF('TP_FRETE', tTRA_TRANSPORT) = 2) then begin
      vVlFrete := itemF('VL_FRETE', tTRA_TRANSACAO);
    end else begin
      if (gInSomaFrete = True) then begin
        vVlFrete := itemF('VL_FRETE', tTRA_TRANSACAO);
      end else begin
        vVlFrete := 0;
      end;
    end;
    putitem_e(tTRA_TRANSACAO, 'VL_TOTAL', itemF('VL_TRANSACAO', tTRA_TRANSACAO) +
                                          itemF('VL_IPI', tTRA_TRANSACAO) +
                                          vVlFrete +
                                          itemF('VL_SEGURO', tTRA_TRANSACAO) +
                                          itemF('VL_DESPACESSOR', tTRA_TRANSACAO) +
                                          itemF('VL_ICMSSUBST', tTRA_TRANSACAO));
  end;

  if (itemXmlB('IN_CONSULTAR', pParams) = True) then begin
    putlistitensocc_e(Result, tTRA_TRANSACAO);
    if debug then MensagemLogTempo('retorna total da transacao');
  end;  

  if debug then MensagemLog(cDS_METHOD, 'Result: ' + Result);

  return(0); exit;
end;

//----------------------------------------------------------------------
function T_TRASVCO004.validaGuiaRepreCliente(pParams : String) : String;
//----------------------------------------------------------------------
const
  cDS_METHOD = 'ADICIONAL=Operação: T_TRASVCO004.validaGuiaRepreCliente()';
var
  piCdPessoa, piCdPessoaAnt : Real;
  piInNaoGravaGuiaRepre, vInGuiaInativo, vInGuiaBloqueado, vInRepreInativo, vInRepreBloqueado : Boolean;
  viParams, voParams : String;
begin
  piCdPessoa := itemXmlF('CD_PESSOA', pParams);
  piCdPessoaAnt := itemXmlF('CD_PESSOAANT', pParams);
  piInNaoGravaGuiaRepre := itemXmlB('IN_NAOGRAVAREPRE', pParams);

  if (itemF('TP_MODALIDADE', tGER_OPERACAO) = 3) then begin
    if (gInGuiaReprAuto = True) and (piCdPessoa <> piCdPessoaAnt) and (piInNaoGravaGuiaRepre <> True) then begin
      viParams := '';
      putitemXml(viParams, 'CD_PESSOA', piCdPessoa);
      voParams := activateCmp('PESSVCO005', 'buscaDadosPessoa', viParams);
      if (xStatus < 0) then begin
        Result := voParams;
        return(-1); exit;
      end;
      if (itemF('CD_GUIA', tTRA_TRANSACAO) = 0) and ((itemF('CD_REPRESENTANT', tTRA_TRANSACAO) = 0) or (gInGravaRepreGuiaTra)) then begin
        putitem_e(tTRA_TRANSACAO, 'CD_GUIA', itemXmlF('CD_GUIA', voParams));
      end;
      if (itemF('CD_REPRESENTANT', tTRA_TRANSACAO) = 0) and ((itemF('CD_GUIA', tTRA_TRANSACAO) = 0) or (gInGravaRepreGuiaTra)) then begin
        putitem_e(tTRA_TRANSACAO, 'CD_REPRESENTANT', itemXmlF('CD_REPRESENTANT', voParams));
      end;
    end;
  end else if (itemF('TP_MODALIDADE', tGER_OPERACAO) = 4) and (item('TP_OPERACAO', tGER_OPERACAO) = 'S') then begin
    if (gInGuiaReprAuto = True) and (piCdPessoa <> piCdPessoaAnt) and (piInNaoGravaGuiaRepre <> True) then begin
      viParams := '';
      putitemXml(viParams, 'CD_PESSOA', piCdPessoa);
      voParams := activateCmp('PESSVCO005', 'buscaDadosPessoa', viParams);
      if (xStatus < 0) then begin
        Result := voParams;
        return(-1); exit;
      end;
      if (itemF('CD_GUIA', tTRA_TRANSACAO) = 0) and ((itemF('CD_REPRESENTANT', tTRA_TRANSACAO) = 0) or (gInGravaRepreGuiaTra)) then begin
        putitem_e(tTRA_TRANSACAO, 'CD_GUIA', itemXmlF('CD_GUIA', voParams));
      end;
      if (itemF('CD_REPRESENTANT', tTRA_TRANSACAO) = 0) and ((itemF('CD_GUIA', tTRA_TRANSACAO) = 0) or (gInGravaRepreGuiaTra)) then begin
        putitem_e(tTRA_TRANSACAO, 'CD_REPRESENTANT', itemXmlF('CD_REPRESENTANT', voParams));
      end;
    end;
  end;
  if (itemF('CD_GUIA', tTRA_TRANSACAO) <> 0) then begin
    viParams := '';
    putitemXml(viParams, 'CD_PESSOA', itemF('CD_GUIA', tTRA_TRANSACAO));
    voParams := activateCmp('PESSVCO005', 'buscaDadosPessoa', viParams);
    if (xStatus < 0) then begin
      Result := voParams;
      return(-1); exit;
    end;

    vInGuiaInativo := itemXmlB('IN_GUIAINATIVO', voParams);
    if (vInGuiaInativo = True) then begin
      Result := SetStatus(STS_ERROR, 'GEN001', 'Guia ' + item('CD_GUIA', tTRA_TRANSACAO) + ' está inativo!', cDS_METHOD);
      return(-1); exit;
    end;

    vInGuiaBloqueado := itemXmlB('IN_GUIABLOQUEADO', voParams);
    if (vInGuiaBloqueado = True) then begin
      Result := SetStatus(STS_ERROR, 'GEN001', 'Guia ' + item('CD_GUIA', tTRA_TRANSACAO) + ' está bloqueado!', cDS_METHOD);
      return(-1); exit;
    end;
  end;
  if (itemF('CD_REPRESENTANT', tTRA_TRANSACAO) <> 0) then begin
    viParams := '';
    putitemXml(viParams, 'CD_PESSOA', itemF('CD_REPRESENTANT', tTRA_TRANSACAO));
    voParams := activateCmp('PESSVCO005', 'buscaDadosPessoa', viParams);
    if (xStatus < 0) then begin
      Result := voParams;
      return(-1); exit;
    end;

    vInRepreInativo := itemXmlB('IN_REPREINATIVO', voParams);
    if (vInRepreInativo = True) then begin
      Result := SetStatus(STS_ERROR, 'GEN001', 'Representante ' + item('CD_REPRESENTANT', tTRA_TRANSACAO) + ' está inativo!', cDS_METHOD);
      return(-1); exit;
    end;

    vInRepreBloqueado := itemXmlB('IN_REPREBLOQUEADO', voParams);
    if (vInRepreBloqueado = True) then begin
      Result := SetStatus(STS_ERROR, 'GEN001', 'Representante ' + item('CD_REPRESENTANT', tTRA_TRANSACAO) + ' está bloqueado!', cDS_METHOD);
      return(-1); exit;
    end;
  end;
  if (itemF('CD_REPRESENTANT', tTRA_TRANSACAO) <> 0) and (itemF('CD_GUIA', tTRA_TRANSACAO) <> 0) and (gInGravaRepreGuiaTra = False) then begin
    Result := SetStatus(STS_ERROR, 'GEN001', 'Não é permitido lançar guia e representante na mesma transação!', cDS_METHOD);
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
    if (vCdProduto <> 0) then begin
      clear_e(tV_BAL_BALANCO);
      putitem_o(tV_BAL_BALANCO, 'CD_EMPRESA', itemXmlF('CD_EMPRESA', PARAM_GLB));
      putitem_o(tV_BAL_BALANCO, 'CD_PRODUTO', vCdProduto);
      putitem_o(tV_BAL_BALANCO, 'TP_SITUACAOC', 1);
      retrieve_e(tV_BAL_BALANCO);
      if (xStatus >= 0) then begin
        clear_e(tBAL_BALANCOTR);
        putitem_o(tBAL_BALANCOTR, 'CD_EMPBALANCO', itemXmlF('CD_EMPRESA', PARAM_GLB));
        putitem_o(tBAL_BALANCOTR, 'NR_TRANSACAO', itemF('NR_TRANSACAO', tTRA_TRANSACAO));
        retrieve_e(tBAL_BALANCOTR);
        if (xStatus < 0) then begin
          if (gTpValidaTransacaoPrd = 1) then begin
            Result := SetStatus(STS_ERROR, 'GEN001', 'Produto ' + FloatToStr(vCdProduto) + ' não pode ser gravado, o mesmo se encontra em balanço em andamento!', cDS_METHOD);
            return(-1); exit;

          end else if (gTpValidaTransacaoPrd = 3) and (vInKardex = True) then begin
            vCdSaldoOperacao := 0;
            if (vCdOperacao > 0) then begin
              clear_e(tGER_OPERSALDOPRD);
              putitem_o(tGER_OPERSALDOPRD, 'CD_OPERACAO', vCdOperacao);
              putitem_o(tGER_OPERSALDOPRD, 'IN_PADRAO', True);
              retrieve_e(tGER_OPERSALDOPRD);
              if (xStatus >= 0) then begin
                vCdSaldoOperacao := itemF('CD_SALDO', tGER_OPERSALDOPRD);
              end else begin
                clear_e(tGER_OPERSALDOPRD);
                putitem_o(tGER_OPERSALDOPRD, 'CD_OPERACAO', vCdOperacao);
                retrieve_e(tGER_OPERSALDOPRD);
                if (xStatus >= 0) then begin
                  vCdSaldoOperacao := itemF('CD_SALDO', tGER_OPERSALDOPRD);
                end else begin
                  clear_e(tGER_OPERSALDOPRD);
                end;
              end;
            end;
            if (vCdSaldoOperacao = itemF('CD_SALDO', tV_BAL_BALANCO)) then begin
              Result := SetStatus(STS_ERROR, 'GEN001', 'Produto ' + FloatToStr(vCdProduto) + ' não pode ser gravado, o mesmo se encontra em balanço em andamento!', cDS_METHOD);
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
  vInNaoVerifCliBloq, vInValidaClienteAtraso, vInNaoVerificaCliBloq, vInNaoGravaGuiaRepre : Boolean;
  vCdEmpresa, vNrTransacao, vCdPessoa, vCdOperacao, vCdCondPgto, vCdImposto, vVlFrete : Real;
  vCdTabPreco, vCdCompVend, vTpSituacao, vTpOrigemEmissao, vNrSeqendereco, vCdPessoaAnt, vNrDiaSPC : Real;
  vDtTransacao, vDtTransacaoOri, vDtBaseParcela, vDtSistema, vDtSPC, vDtHoraEcf : TDateTime;
  vNrDiaVencto, vCdCCusto, vCdEmpresaOri, vNrTransacaoOri, vNrDiaUltCompra : Real;
  vInImpressao, vInInclusao, vInValidaData, vInHomologacaoPAF, vInVendaEcf : Boolean;
  //vCdClientePdvEmp : Real;
begin
  vCdEmpresa := itemXmlF('CD_EMPRESA', pParams);
  vNrTransacao := itemXmlF('NR_TRANSACAO', pParams);
  vDtTransacao := itemXmlD('DT_TRANSACAO', pParams);
  vCdPessoa := itemXmlF('CD_PESSOA', pParams);
  vCdOperacao := itemXmlF('CD_OPERACAO', pParams);
  vCdCondpgto := itemXmlF('CD_CONDPGTO', pParams);
  vCdCompVend := itemXmlF('CD_COMPVEND', pParams);
  vTpSituacao := itemXmlF('TP_SITUACAO', pParams);
  vTpOrigemEmissao := itemXmlF('TP_ORIGEMEMISSAO', pParams);
  vInNaoVerifCliBloq := itemXmlB('IN_NAO_VERIFICA_CLI_BLOQ', pParams);
  vInValidaClienteAtraso := itemXmlB('IN_VALIDA_CLIENTE_ATRASO', pParams);
  vInNaoGravaGuiaRepre := itemXmlB('IN_NAOGRAVAGUIAREPRE', pParams);
  vCdEmpresaOri := itemXmlF('CD_EMPRESAORI', pParams);
  vNrTransacaoOri := itemXmlF('NR_TRANSACAOORI', pParams);
  vDtTransacaoOri := itemXmlD('DT_TRANSACAOORI', pParams);
  vInImpressao := itemXmlB('IN_IMPRESSAO', pParams);
  vInValidaData := itemXmlB('IN_VALIDADATA', pParams);
  vInHomologacaoPAF := LeIniB('IN_HOMOLOGACAOPAF');

  if (vTpOrigemEmissao = 0) then begin
    vTpOrigemEmissao := 1;
  end;

  if (vCdEmpresa = 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN001', 'Empresa não informada!', cDS_METHOD);
    return(-1); exit;
  end;
  if (vDtTransacao = 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN001', 'Data transação não informada!', cDS_METHOD);
    return(-1); exit;
  end;
  if (vCdPessoa = 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN001', 'Pessoa não informada!', cDS_METHOD);
    return(-1); exit;
  end;
  if (vCdOperacao = 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN001', 'Operação não informada!', cDS_METHOD);
    return(-1); exit;
  end;
  if (vCdCondPgto = 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN001', 'Condição de pagamento não informada!', cDS_METHOD);
    return(-1); exit;
  end;
  if (vCdCompVend = 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN001', 'Comprador/Vendedor não informado!', cDS_METHOD);
    return(-1); exit;
  end;

  vDtSistema := itemXmlD('DT_SISTEMA', xParamEmp);

  viParams := '';
  putitemXml(viParams, 'CD_PESSOA', vCdPessoa);
  voParams := activateCmp('TRASVCO016', 'validaCapaTransacao', viParams);
  if (xStatus < 0) then begin
    Result := voParams;
    return(-1); exit;
  end;

  viParams := '';
  clear_e(tGER_OPERACAO);
  putitem_o(tGER_OPERACAO, 'CD_OPERACAO', vCdOperacao);
  retrieve_e(tGER_OPERACAO);
  if (xStatus >= 0) then begin
    if ((itemF('TP_DOCTO', tGER_OPERACAO) = 2) or (itemF('TP_DOCTO', tGER_OPERACAO) = 3))
    and ((itemF('TP_MODALIDADE', tGER_OPERACAO) = 4) or (itemF('TP_MODALIDADE', tGER_OPERACAO) = 8) or (itemF('TP_MODALIDADE', tGER_OPERACAO) = 3)) then begin
      putitemXml(viParams, 'IN_VENDA_ECF', True);
      vInVendaEcf := True;
    end;
  end;

  if debug then MensagemLogTempo('operacao');

  putitemXml(viParams, 'CD_PESSOA', vCdPessoa);
  voParams := activateCmp('PESSVCO005', 'buscaEnderecoFaturamento', viParams);
  if (xStatus < 0) then begin
    Result := voParams;
    return(-1); exit;
  end;

  if debug then MensagemLogTempo('endereco de faturamento');

  vNrSeqendereco := itemXmlF('NR_SEQENDERECO', voParams);

  viParams := '';
  putitemXml(viParams, 'CD_OPERACAO', vCdOperacao);
  putitemXml(viParams, 'CD_CONDPGTO', vCdCondPgto);
  voParams := activateCmp('GERSVCO103', 'validaCondPgtoOperacao', viParams);
  if (xStatus < 0) then begin
    Result := voParams;
    return(-1); exit;
  end;

  if debug then MensagemLogTempo('condicao pagamento');

  if (vInValidaClienteAtraso = True) then begin
    viParams := '';
    putitemXml(viParams, 'CD_CLIENTE', vCdPessoa);
    putitemXml(viParams, 'IN_TOTAL', True);
    voParams := activateCmp('FCRSVCO015', 'buscaLimiteCliente', viParams);
    if (xStatus < 0) then begin
      Result := voParams;
      return(-1); exit;
    end;
    vNrDiaVencto := itemXmlF('NR_DIAVENCTO', voParams);
    if (gNrDiaVencto > 0) then begin
      if (vNrDiaVencto > gNrDiaVencto) then begin
        Result := SetStatus(STS_ERROR, 'GEN001', 'O cliente ' + FloatToStr(vCdPessoa) + ' possui fatura com ' + FloatToStr(vNrDiaVencto) + ' dia(s) vencida, o que ultrapassa o limite de ' + FloatToStr(gNrDiaVencto) + ' dia(s).', cDS_METHOD);
        return(-2);
      end;
    end;
  end;

  if debug then MensagemLogTempo('limite');

  vCdPessoaAnt := 0;
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
      if (itemF('TP_SITUACAO', tTRA_TRANSACAO) <> 1) and (itemF('TP_SITUACAO', tTRA_TRANSACAO) <> 2) and (itemF('TP_SITUACAO', tTRA_TRANSACAO) <> 8) then begin
        Result := SetStatus(STS_ERROR, 'GEN001', 'Transação não pode ser alterada pois não está em andamento!', cDS_METHOD);
        return(-1); exit;
      end;
      vCdPessoaAnt := itemF('CD_PESSOA', tTRA_TRANSACAO);
    end;
    delitem(pParams, 'CD_EMPRESA');
    delitem(pParams, 'NR_TRANSACAO');
    delitem(pParams, 'DT_TRANSACAO');

    if (vCdPessoaAnt <> vCdPessoa) and (vCdPessoaAnt > 0) then begin
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

  if debug then MensagemLogTempo('endereco');

  getlistitensocc_e(pParams, tTRA_TRANSACAO);
  putitem_e(tTRA_TRANSACAO, 'NR_SEQENDERECO', vNrSeqendereco);
  if (itemF('CD_EMPFAT', tTRA_TRANSACAO) = 0) then begin
    putitem_e(tTRA_TRANSACAO, 'CD_EMPFAT', itemF('CD_EMPRESA', tTRA_TRANSACAO));
  end;

  clear_e(tGER_EMPRESA);
  putitem_o(tGER_EMPRESA, 'CD_EMPRESA', vCdEmpresa);
  retrieve_e(tGER_EMPRESA);
  if (xStatus >= 0) then begin
    putitem_e(tTRA_TRANSACAO, 'CD_GRUPOEMPRESA', itemF('CD_GRUPOEMPRESA', tGER_EMPRESA));
  end else begin
    Result := SetStatus(STS_ERROR, 'GEN001', 'Empresa ' + FloatToStr(vCdEmpresa) + ' não cadastrada!', cDS_METHOD);
    return(-1); exit;
  end;

  if debug then MensagemLogTempo('empresa');

  clear_e(tGER_OPERACAO);
  putitem_o(tGER_OPERACAO, 'CD_OPERACAO', vCdOperacao);
  retrieve_e(tGER_OPERACAO);
  if (xStatus >= 0) then begin
    putitem_e(tTRA_TRANSACAO, 'TP_OPERACAO', item('TP_OPERACAO', tGER_OPERACAO));
  end else begin
    Result := SetStatus(STS_ERROR, 'GEN001', 'Operação ' + FloatToStr(vCdOperacao) + ' não cadastrada!', cDS_METHOD);
    return(-1); exit;
  end;
  if (itemF('CD_OPERFAT', tGER_OPERACAO) = 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN001', 'Operação ' + item('CD_OPERACAO', tGER_OPERACAO) + ' não possui operação de movimento!', cDS_METHOD);
    return(-1); exit;
  end;

  if debug then MensagemLogTempo('operacao faturamento');

  clear_e(tPES_PESSOA);
  putitem_o(tPES_PESSOA, 'CD_PESSOA', vCdPessoa);
  retrieve_e(tPES_PESSOA);
  if (xStatus < 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN001', 'Pessoa ' + FloatToStr(vCdPessoa) + ' não cadastrada!', cDS_METHOD);
    return(-1); exit;
  end;
  if (itemF('TP_MODALIDADE', tGER_OPERACAO) = 4) and (item('TP_OPERACAO', tGER_OPERACAO) = 'S') then begin
    if (itemF('CD_PESSOA', tTRA_TRANSACAO) = gCdClientePdv) then begin
      viParams := '';
      putitemXml(viParams, 'CD_PESSOA', itemF('CD_PESSOA', tTRA_TRANSACAO));
      voParams := activateCmp('ADMSVCO025', 'CD_CLIENTE_PDV_EMP', viParams);
      if (xStatus < 0) then begin
        Result := voParams;
        return(-1); exit;
      end;
    end;
  end;

  if debug then MensagemLogTempo('pessoa');

  vNrDiaUltCompra := itemXmlF('NR_DIAS_ULTCOMPRA_CLIENTE', xParamEmp);
  //vCdClientePdvEmp := itemXmlF('CD_CLIENTE_PDV_EMP', xParamEmp);

  if (vNrDiaUltCompra > 0) and ((itemF('TP_MODALIDADE', tGER_OPERACAO) = 4) or (itemF('TP_MODALIDADE', tGER_OPERACAO) = 7) or (item('TP_MODALIDADE', tGER_OPERACAO) = 'C')) and (item('TP_OPERACAO', tGER_OPERACAO) = 'S') then begin
    if (vCdPessoa <> gCdClientePdv) {and (vCdPessoa <> vCdClientePdvEmp)} and (item('TP_PESSOA', tPES_PESSOA) = 'F') then begin
      viParams := '';
      putitemXml(viParams, 'CD_PESSOA', vCdPessoa);
      voParams := activateCmp('PESSVCO005', 'buscaDadosPessoaFisica', viParams);
      if (xStatus < 0) then begin
        Result := voParams;
        return(-1); exit;
      end;

      vDtSPC := itemXmlD('DT_ATUALIZSPC', voParams);
      if (vDtSPC <> 0) then begin
        vNrDiaSPC := vDtSistema - vDtSPC;
        if (vNrDiaSPC > vNrDiaUltCompra) then begin
          Result := SetStatus(STS_ERROR, 'GEN001', 'O cliente ' + FloatToStr(vCdPessoa) + ' está a ' + FloatToStr(vNrDiaSPC) + ' dia(s) sem efetuar consulta SPC. Verificar o cadastro!', cDS_METHOD);
          return(-1); exit;
        end;
      end else begin
        Result := SetStatus(STS_ERROR, 'GEN001', 'O cliente ' + FloatToStr(vCdPessoa) + ' não possui consulta SPC. Verificar o cadastro!', cDS_METHOD);
        return(-1); exit;
      end;
    end;
  end;

  if debug then MensagemLogTempo('pessoa - fisica');

  if (item('TP_OPERACAO', tGER_OPERACAO) = 'S') and ((itemF('TP_MODALIDADE', tGER_OPERACAO) = 4) or (itemF('TP_MODALIDADE', tGER_OPERACAO) = 7) or (itemF('TP_MODALIDADE', tGER_OPERACAO) = 8) or (item('TP_MODALIDADE', tGER_OPERACAO) = 'C')) then begin
    clear_e(tPES_CLIENTE);
    putitem_o(tPES_CLIENTE, 'CD_CLIENTE', vCdPessoa);
    retrieve_e(tPES_CLIENTE);
    setocc(tPES_CLIENTE, 1);
    if not (dbocc(tPES_CLIENTE)) then begin
      Result := SetStatus(STS_ERROR, 'GEN001', 'Cliente ' + FloatToStr(vCdPessoa) + ' não cadastrado!', cDS_METHOD);
      return(-1); exit;
    end;
    if (item_b('IN_BLOQUEADO', tPES_CLIENTE) = True) then begin
      if (vInNaoVerifCliBloq = False) and (vCdPessoaAnt <> itemF('CD_CLIENTE', tPES_CLIENTE)) then begin
        Result := SetStatus(STS_ERROR, 'GEN001', 'Cliente ' + FloatToStr(vCdPessoa) + ' bloqueado!', cDS_METHOD);
        return(-3);
      end;
    end;
    if (item_b('IN_INATIVO', tPES_CLIENTE) = True) then begin
      if (vInImpressao = True) then begin
      end else begin
        Result := SetStatus(STS_ERROR, 'GEN001', 'Cliente ' + FloatToStr(vCdPessoa) + ' inativo!', cDS_METHOD);
        return(-1); exit;
      end;
    end;
  end;

  if debug then MensagemLogTempo('cliente');

  viParams := '';
  putitemXml(viParams, 'CD_PESSOA', itemF('CD_CLIENTE', tPES_CLIENTE));
  putitemXml(viParams, 'CD_PESSOAANT', vCdPessoaAnt);
  putitemXml(viParams, 'IN_NAOGRAVARGUIAREPRE', vInNaoGravaGuiaRepre);
  voParams := validaGuiaRepreCliente(viParams);
  if (xStatus < 0) then begin
    Result := voParams;
    return(-1); exit;
  end;

  if debug then MensagemLogTempo('guia / representante');

  if (itemF('TP_MODALIDADE', tGER_OPERACAO) = 2) then begin
    vCdCCusto := itemF('CD_CCUSTO', tGER_EMPRESA);
    clear_e(tGER_EMPRESA);
    putitem_o(tGER_EMPRESA, 'CD_PESSOA', vCdPessoa);
    retrieve_e(tGER_EMPRESA);
    if (xStatus < 0) then begin
      Result := SetStatus(STS_ERROR, 'GEN001', 'Pessoa ' + FloatToStr(vCdPessoa) + ' não está relacionada a nenhuma empresa para tranferência.', cDS_METHOD);
      return(-1); exit;
    end;
    if (itemF('CD_CCUSTO', tGER_EMPRESA) > 0) and (vCdCCusto = 0) or (itemF('CD_CCUSTO', tGER_EMPRESA) = 0) and (vCdCCusto > 0) then begin
      Result := SetStatus(STS_ERROR, 'GEN001', 'Empresa ' + item('CD_EMPRESA', tGER_EMPRESA) + ' incompatível para transferência com ' + FloatToStr(vCdEmpresa) + '!', cDS_METHOD);
      return(-1); exit;
    end;
    clear_e(tGER_EMPRESA);
    putitem_o(tGER_EMPRESA, 'CD_EMPRESA', vCdEmpresa);
    retrieve_e(tGER_EMPRESA);
    if (xStatus < 0) then begin
      Result := SetStatus(STS_ERROR, 'GEN001', 'Empresa ' + FloatToStr(vCdEmpresa) + ' não cadastrada!', cDS_METHOD);
      return(-1); exit;
    end;
    if (vCdPessoa = itemF('CD_PESSOA', tGER_EMPRESA)) and (itemF('TP_DOCTO', tGER_OPERACAO) = 1) then begin
      Result := SetStatus(STS_ERROR, 'GEN001', 'Não é permitido fazer transferência para a mesma empresa!', cDS_METHOD);
      return(-1); exit;
    end;
  end;

  if debug then MensagemLogTempo('transferencia');

  if (vNrTransacao = 0) then begin
    vLstGlobal := '';
    putitemXml(vLstGlobal, 'CD_GRUPOEMPRESA', itemF('CD_GRUPOEMPRESA', tTRA_TRANSACAO));
    putitemXml(vLstGlobal, 'CD_USUARIO', itemXmlF('CD_USUARIO', PARAM_GLB));

    if (gTpNumeracaoTra = 01) then begin
      viParams := '';
      putitemXml(viParams, 'NM_ENTIDADE', 'TRA_TRANSACAO');
      putitemXml(viParams, 'NM_ATRIBUTO', 'NR_TRANSACAO');
      putitemXml(viParams, 'DT_SEQUENCIA', vDtTransacao);
      voParams := activateCmp('GERSVCO011', 'getNumSeq', viParams);
      if (xStatus < 0) then begin
        Result := voParams;
        return(-1); exit;
      end;
      vNrTransacao := itemXmlF('NR_SEQUENCIA', voParams);
    end else if (gTpNumeracaoTra = 02) then begin
      viParams := '';
      putitemXml(viParams, 'NM_ENTIDADE', 'TRA_TRANSACAO');
      putitemXml(viParams, 'NM_ATRIBUTO', 'NR_TRANSACAO');
      putitemXml(viParams, 'DT_SEQUENCIA', '01/01/2001');
      voParams := activateCmp('GERSVCO011', 'getNumSeq', viParams);
      if (xStatus < 0) then begin
        Result := voParams;
        return(-1); exit;
      end;
      vNrTransacao := itemXmlF('NR_SEQUENCIA', voParams);
    end else begin
      viParams := '';
      putitemXml(viParams, 'NM_ENTIDADE', 'TRA_TRANSACAO');
      putitemXml(viParams, 'NM_ATRIBUTO', 'NR_TRANSACAO');
      voParams := activateCmp('GERSVCO031', 'getNumSeq', viParams);
      if (xStatus < 0) then begin
        Result := voParams;
        return(-1); exit;
      end;
      vNrTransacao := itemXmlF('NR_SEQUENCIA', voParams);
    end;

    putitem_e(tTRA_TRANSACAO, 'NR_TRANSACAO', vNrTransacao);
  end;

  if debug then MensagemLogTempo('sequencia');

  if (item_d('DT_TRANSACAO', tTRA_TRANSACAO) <> vDtSistema) and (vInInclusao = True) and (vInValidaData = True) then begin
    vDsMensagem := 'DESCRICAO=A transação ' + FloatToStr(vCdEmpresa) + ' / ' + FloatToStr(vNrTransacao) + ' / ' + DateToStr(vDtTransacao) + ' difere da data do sistema';
    vDsMensagem := vDsMensagem + ' ' + DateToStr(vDtSistema) + '!';
    Result := SetStatus(STS_ERROR, 'GEN001', vDsMensagem, cDS_METHOD);
    return(-1); exit;
  end;
  if (item('IN_ACEITADEV', tTRA_TRANSACAO) = '') then begin
    putitem_e(tTRA_TRANSACAO, 'IN_ACEITADEV', True);
  end;
  if (item('TP_SITUACAO', tTRA_TRANSACAO) = '') then begin
    putitem_e(tTRA_TRANSACAO, 'TP_SITUACAO', 1);
    if (gInGravaTraBloq = True) then begin
      putitem_e(tTRA_TRANSACAO, 'TP_SITUACAO', 8);
    end;
  end;

  putitem_e(tTRA_TRANSACAO, 'TP_ORIGEMEMISSAO', vTpOrigemEmissao);

  viParams := '';
  voParams := calculaTotalTransacao(viParams);
  if (xStatus < 0) then begin
    Result := voParams;
    return(-1); exit;
  end;

  if debug then MensagemLogTempo('calcula total');

  putitem_e(tTRA_TRANSACAO, 'CD_OPERADOR', itemXmlF('CD_USUARIO', PARAM_GLB));
  if (item('CD_USURELAC', tTRA_TRANSACAO) = '') then begin
    putitem_e(tTRA_TRANSACAO, 'CD_USURELAC', itemXmlF('CD_USUARIO', PARAM_GLB));
  end;

  if (vInHomologacaoPAF = True) and (vInVendaEcf = True) then begin
    //Data Hora Impressora
    viParams := '';
    voParams := activateCmp('PAFSVCO003', 'getDataHoraImpressora', viParams);
    if (xStatus < 0) then begin
      Result := voParams;
      return(-1); exit;
    end;
    vDtHoraEcf := itemXmlD('DS_DATAHORA', voParams);
    putitem_e(tTRA_TRANSACAO, 'DT_IMPRESSAO', vDtHoraEcf);
  end;

  putitem_e(tTRA_TRANSACAO, 'DT_CADASTRO', Now);

  if (vCdEmpresaOri > 0) and (vNrTransacaoOri > 0) and (vDtTransacaoOri <> 0) then begin
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
    voParams := activateCmp('TRASVCO016', 'gravaDadosAdicionais', viParams);
    if (xStatus < 0) then begin
      Result := voParams;
      return(-1); exit;
    end;
  end;

  vDtBaseParcela := itemXmlD('DT_BASE_VENCTO_FAT', PARAM_GLB);
  if (vDtBaseParcela <> 0) then begin
    viParams := '';
    putitemXml(viParams, 'CD_EMPRESA', vCdEmpresa);
    putitemXml(viParams, 'NR_TRANSACAO', vNrTransacao);
    putitemXml(viParams, 'DT_TRANSACAO', vDtTransacao);
    putitemXml(viParams, 'DT_BASEPARCELA', vDtBaseParcela);
    putitemXml(viParams, 'IN_BASEPARCELA', True);
    voParams := activateCmp('TRASVCO016', 'gravaDadosAdicionais', viParams);
    if (xStatus < 0) then begin
      Result := voParams;
      return(-1); exit;
    end;
  end;

  if ((itemF('TP_MODALIDADE', tGER_OPERACAO) = 4) or (itemF('TP_MODALIDADE', tGER_OPERACAO) = 3)) and (gInGuiaReprAuto = True) and (gTpTabPrecoPed = 2) and (itemF('CD_REPRESENTANT', tTRA_TRANSACAO) <> 0) then begin
    viParams := '';
    putitemXml(viParams, 'CD_CLIENTE', itemF('CD_PESSOA', tTRA_TRANSACAO));
    putitemXml(viParams, 'CD_REPRESENTANT', itemF('CD_REPRESENTANT', tTRA_TRANSACAO));
    voParams := activateCmp('PEDSVCO008', 'buscaTabelaPreco', viParams);
    if (xStatus < 0) then begin
      Result := voParams;
      return(-1); exit;
    end;

    vDsLstTabPreco := itemXml('CD_TABPRECO', voParams);

    getitem(vCdTabPreco, vDsLstTabPreco, 1);

    viParams := '';
    putitemXml(viParams, 'CD_EMPRESA', vCdEmpresa);
    putitemXml(viParams, 'NR_TRANSACAO', vNrTransacao);
    putitemXml(viParams, 'DT_TRANSACAO', vDtTransacao);
    putitemXml(viParams, 'CD_TABPRECO', vCdTabPreco);
    putitemXml(viParams, 'IN_TABPRECO', True);
    putitemXml(viParams, 'IN_TABPRECOZERO', True);
    voParams := activateCmp('TRASVCO016', 'gravaDadosAdicionais', viParams);
    if (xStatus < 0) then begin
      Result := voParams;
      return(-1); exit;
    end;
  end;

  if debug then MensagemLogTempo('adicional transacao');

  gInTransacaoItem := False;

  //if (itemXmlB('IN_GERAREMDES', pParams)) then begin
    viParams := '';
    putitemXml(viParams, 'CD_EMPRESA', itemF('CD_EMPRESA', tTRA_TRANSACAO));
    putitemXml(viParams, 'NR_TRANSACAO', itemF('NR_TRANSACAO', tTRA_TRANSACAO));
    putitemXml(viParams, 'DT_TRANSACAO', item_d('DT_TRANSACAO', tTRA_TRANSACAO));
    voParams := gravaEnderecoTransacao(viParams);
    if (xStatus < 0) then begin
      Result := voParams;
      return(-1); exit;
    end;
  //end;

  Result := '';
  putitemXml(Result, 'CD_EMPRESA', itemF('CD_EMPRESA', tTRA_TRANSACAO));
  putitemXml(Result, 'NR_TRANSACAO', itemF('NR_TRANSACAO', tTRA_TRANSACAO));
  putitemXml(Result, 'DT_TRANSACAO', item('DT_TRANSACAO', tTRA_TRANSACAO));
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
  {vTpLote,} vTpInspecao, vVlOriginal, vVlBase : Real;
  vDtTransacao, vDtValor : TDateTime;
  vInCodigo, vTpValidaVlZerado, vInValidaVlZerado, vInProdutoBloq : Boolean;
  vInDadosOperacao, vInServico, vInMatPrima, vInProdAcabado, vInValorPadraoTransf : Boolean;
begin
  vCdEmpresa := itemXmlF('CD_EMPRESA', pParams);
  vNrTransacao := itemXmlF('NR_TRANSACAO', pParams);
  vDtTransacao := itemXmlD('DT_TRANSACAO', pParams);
  vCdBarraPrd := itemXml('CD_BARRAPRD', pParams);
  vCdMPTer := itemXml('CD_MPTER', pParams);
  vCdServico := itemXmlF('CD_SERVICO', pParams);
  vInCodigo := itemXmlB('IN_CODIGO', pParams);
  vInValidaVlZerado := itemXmlB('IN_VALIDAVLZERADO', pParams);
  vQtEmbalagem := itemXmlF('QT_SOLICITADA', pParams);
  vVlUnitBruto := itemXmlF('VL_BRUTO', pParams);
  vVlUnitLiquido := itemXmlF('VL_LIQUIDO', pParams);
  vVlUnitDesc := itemXmlF('VL_DESCONTO', pParams);
  vCdCompVend := itemXmlF('CD_COMPVEND', pParams);
  vCdCFOP := itemXmlF('CD_CFOP', pParams);
  vCdCST := itemXml('CD_CST', pParams);
  vDtValor := itemXmlD('DT_VALOR', pParams);
  vTpAreaComercio := itemXmlF('TP_AREACOMERCIO', pParams);
  vPesTerc := itemXmlF('CD_PESSOATERC', pParams);
  vTpItem := itemXml('TP_ITEM', pParams);
  vCdTabPreco := itemXmlF('CD_TABPRECO', pParams);
  gCdEspecieServico := itemXml('CD_ESPECIE_SERVICO_TRA', PARAM_GLB);
  vDsProduto := itemXml('DS_PRODUTO', pParams);
  vInValorPadraoTransf := itemXmlB('IN_VALOR_PADRAO_TRANSF', pParams);

  vVlTotalBruto := 0;
  vVlTotalLiquido := 0;
  vVlTotalDesc := 0;

  if (vCdEmpresa = 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN001', 'Empresa não informada!', cDS_METHOD);
    return(-1); exit;
  end;
  if (vNrTransacao = 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN001', 'Número transação não informado!', cDS_METHOD);
    return(-1); exit;
  end;
  if (vDtTransacao = 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN001', 'Data transação não informada!', cDS_METHOD);
    return(-1); exit;
  end;

  if debug then MensagemLogTempo('inicio');

  clear_e(tTRA_TRANSACAO);
  putitem_o(tTRA_TRANSACAO, 'CD_EMPRESA', vCdEmpresa);
  putitem_o(tTRA_TRANSACAO, 'NR_TRANSACAO', vNrTransacao);
  putitem_o(tTRA_TRANSACAO, 'DT_TRANSACAO', vDtTransacao);
  retrieve_e(tTRA_TRANSACAO);
  if (xStatus < 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN001', 'Transação ' + FloatToStr(vNrTransacao) + ' não cadastrada!', cDS_METHOD);
    return(-1); exit;
  end;
  if (itemF('TP_SITUACAO', tTRA_TRANSACAO) <> 1) and (itemF('TP_SITUACAO', tTRA_TRANSACAO) <> 8) then begin
    Result := SetStatus(STS_ERROR, 'GEN001', 'Não é possível inserir itens na transação ' + item('CD_EMPFAT', tTRA_TRANSACAO) + ' / ' + item('NR_TRANSACAO', tTRA_TRANSACAO) + ' pois não está em andamento/bloqueada!', cDS_METHOD);
    return(-1); exit;
  end;

  if debug then MensagemLogTempo('transacao');

  vDsMP := '';
  vCdEspecieMP := '';
  vDsServico := '';
  vDsRegProduto := '';

  if (vTpItem = 'S') then begin
    if (vCdServico = 0) then begin
      Result := SetStatus(STS_ERROR, 'GEN001', 'Serviço não informado!', cDS_METHOD);
      return(-1); exit;
    end;
    if (vInDadosOperacao = True) and (vInServico <> True) then begin
      Result := SetStatus(STS_ERROR, 'GEN001', 'A operação ' + item('CD_OPERACAO', tTRA_TRANSACAO) + ' da transação não é uma operação de serviço!', cDS_METHOD);
      return(-1); exit;
    end;

    viParams := '';
    putitemXml(viParams, 'CD_SERVICO', vCdServico);
    voParams := activateCmp('PCPSVCO020', 'buscaDadosServico', viParams);
    if (xStatus < 0) then begin
      Result := voParams;
      return(-1); exit;
    end;
    vDsServico := itemXml('DS_SERVICO', voParams);
  end else begin
    if (vCdBarraPrd = '') and (vCdMPTer = '') then begin
      Result := SetStatus(STS_ERROR, 'GEN001', 'Produto não informado!', cDS_METHOD);
      return(-1); exit;
    end;
    if (vCdMPTer <> '') then begin
      viParams := '';
      if (vPesTerc <> 0) then begin
        putitemXml(viParams, 'CD_PESSOA', vPesTerc);
      end else begin
        putitemXml(viParams, 'CD_PESSOA', itemF('CD_PESSOA', tTRA_TRANSACAO));
      end;
      putitemXml(viParams, 'CD_MPTER', vCdMPTer);
      voParams := activateCmp('GERSVCO046', 'buscaDadosMPTerceito', viParams);
      if (xStatus < 0) then begin
        Result := voParams;
        return(-1); exit;
      end;
      vDsMP := itemXml('DS_MP', voParams);
      vCdEspecieMP := itemXml('CD_ESPECIE', voParams);
      vCdTipi := itemXml('CD_TIPI', voParams);
    end else begin
      if (vInDadosOperacao = True) and (vInProdAcabado <> True) and (vInMatPrima <> True) then begin
        Result := SetStatus(STS_ERROR, 'GEN001', 'A operação ' + item('CD_OPERACAO', tTRA_TRANSACAO) + ' da transação não é uma operação de produto acabado ou matéria-prima!', cDS_METHOD);
        return(-1); exit;
      end;

      viParams := '';
      putitemXml(viParams, 'CD_EMPRESA', vCdEmpresa);
      putitemXml(viParams, 'CD_OPERACAO', itemF('CD_OPERACAO', tTRA_TRANSACAO));
      //voParams := activateCmp('GERSVCO054', 'dadosAdicionaisOperacao', viParams);
      if (xStatus < 0) then begin
        Result := voParams;
        return(-1); exit;
      end;
      vInProdAcabado := itemXmlB('IN_PRODACABADO', voParams);
      vInMatPrima := itemXmlB('IN_MATPRIMA', voParams);
      //vTpLote := itemXmlF('TP_LOTE', voParams);
      vTpInspecao := itemXmlF('TP_INSPECAO', voParams);
      vInProdutoBloq := itemXmlB('IN_PRODUTOBLOQ', voParams);

      viParams := '';
      putitemXml(viParams, 'CD_BARRAPRD', vCdBarraPrd);
      putitemXml(viParams, 'IN_CODIGO', vInCodigo);
      putitemXml(viParams, 'CD_EMPRESA', vCdEmpresa);
      putitemXml(viParams, 'IN_PRODACABADO', vInProdAcabado);
      putitemXml(viParams, 'IN_MATPRIMA', vInMatPrima);
      //putitemXml(viParams, 'TP_LOTE', vTpLote);
      putitemXml(viParams, 'TP_INSPECAO', vTpInspecao);
      putitemXml(viParams, 'IN_PRODUTOBLOQ', vInProdutoBloq);
      voParams := activateCmp('PRDSVCO004', 'verificaProduto', viParams);
      if (xStatus < 0) then begin
        Result := voParams;
        return(-1); exit;
      end;
      vCdProduto := itemXmlF('CD_PRODUTO', voParams);
      if (vCdProduto = 0) then begin
        Result := SetStatus(STS_ERROR, 'GEN001', 'Produto ' + vCdBarraPrd + ' inválido', cDS_METHOD);
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

      if (vQtEmbalagem > 99999999) then begin
        Result := SetStatus(STS_ERROR, 'GEN001', 'A quantidade não pode ser superior a 99.999.999!', cDS_METHOD);
        return(-1); exit;
      end;

      viParams := '';
      putitemXml(viParams, 'CD_PRODUTO', vCdProduto);
      putitemXml(viParams, 'QT_QUANTIDADE', vQtEmbalagem);
      voParams := activateCmp('PRDSVCO008', 'validaQtdFracionada', viParams);
      if (xStatus < 0) then begin
        Result := voParams;
        return(-1); exit;
      end;

      if (gCdEmpParam = 0) or (gCdEmpParam <> vCdEmpresa) then begin
        getParam(pParams);
        gCdEmpParam := vCdEmpresa;
      end;

      viParams := '';
      putitemXml(viParams, 'CD_PRODUTO', vCdProduto);
      voParams := activateCmp('GERSVCO046', 'buscaDadosProduto', viParams);
      if (xStatus < 0) then begin
        Result := voParams;
        return(-1); exit;
      end;

      vDsRegProduto := voParams;

      if (itemXml('CD_CST', vDsRegProduto) = '') then begin
        Result := SetStatus(STS_ERROR, 'GEN001', 'Produto ' + FloatToStr(vCdProduto) + ' sem CST cadastrado!', cDS_METHOD);
        return(-1); exit;
      end;
      if (itemXml('CD_ESPECIE', vDsRegProduto) = '') then begin
        Result := SetStatus(STS_ERROR, 'GEN001', 'Produto ' + FloatToStr(vCdProduto) + ' sem espécie cadastrada!', cDS_METHOD);
        return(-1); exit;
      end;
      if (vInCodigo <> True) and (gDsSepBarraPrd <> '') then begin
        if (Pos(gDsSepBarraPrd, vCdBarraPrd) > 0) then begin
          clear_e(tTRA_TRANSITEM);
          putitem_o(tTRA_TRANSITEM, 'CD_BARRAPRD', vCdBarraPrd);
          retrieve_e(tTRA_TRANSITEM);
          if (xStatus >= 0) then begin
            Result := SetStatus(STS_ERROR, 'GEN001', 'Código de barras ' + vCdBarraPrd + ' já cadastrado na transação ' + item('CD_EMPFAT', tTRA_TRANSACAO) + ' / ' + item('NR_TRANSACAO', tTRA_TRANSACAO) + '!', cDS_METHOD);
            return(-1); exit;
          end;
        end;
      end;
    end;
  end;

  if debug then MensagemLogTempo('produto');

  if (gInTransacaoItem = False) then begin
    clear_e(tV_PES_ENDERECO);
    putitem_o(tV_PES_ENDERECO, 'CD_PESSOA', itemF('CD_PESSOA', tTRA_TRANSACAO));
    putitem_o(tV_PES_ENDERECO, 'NR_SEQUENCIA', itemF('NR_SEQENDERECO', tTRA_TRANSACAO));
    retrieve_e(tV_PES_ENDERECO);
    if (xStatus < 0) then begin
      if ((itemF('TP_DOCTO', tGER_OPERACAO) = 2) or (itemF('TP_DOCTO', tGER_OPERACAO) = 3)) and ((itemF('TP_MODALIDADE', tGER_OPERACAO) = 4) or (itemF('TP_MODALIDADE', tGER_OPERACAO) = 8) or (itemF('TP_MODALIDADE', tGER_OPERACAO) = 3)) then begin
        if (gCdPessoaEndPadrao <> 0) then begin
          clear_e(tV_PES_ENDERECO);
          putitem_o(tV_PES_ENDERECO, 'CD_PESSOA', gCdPessoaEndPadrao);
          putitem_o(tV_PES_ENDERECO, 'NR_SEQUENCIA', itemF('NR_SEQENDERECO', tTRA_TRANSACAO));
          retrieve_e(tV_PES_ENDERECO);
          if (xStatus < 0) then begin
            Result := SetStatus(STS_ERROR, 'GEN001', 'endereço ' + item('NR_SEQENDERECO', tTRA_TRANSACAO) + ' não cadastrado para a pessoa ' + FloatToStr(gCdPessoaEndPadrao) + '!', cDS_METHOD);
            return(-1); exit;
          end;
        end else begin
          Result := SetStatus(STS_ERROR, 'GEN001', 'endereço ' + item('NR_SEQENDERECO', tTRA_TRANSACAO) + ' não cadastrado para a pessoa ' + item('CD_PESSOA', tPES_PESSOA) + '!', cDS_METHOD);
          return(-1); exit;
        end;
      end else begin
        Result := SetStatus(STS_ERROR, 'GEN001', 'endereço ' + item('NR_SEQENDERECO', tTRA_TRANSACAO) + ' não cadastrado para a pessoa ' + item('CD_PESSOA', tPES_PESSOA) + '!', cDS_METHOD);
        return(-1); exit;
      end;
    end;
  end;

  if debug then MensagemLogTempo('endereco');

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
    putitem_o(tTRA_REMDES, 'CD_EMPRESA', vCdEmpresa);
    putitem_o(tTRA_REMDES, 'NR_TRANSACAO', vNrTransacao);
    putitem_o(tTRA_REMDES, 'DT_TRANSACAO', vDtTransacao);
    retrieve_e(tTRA_REMDES);
    if (xStatus >= 0) then begin
      if (item('CD_PESSOA', tTRA_REMDES) <> '') then begin
        putitemXml(viParams, 'CD_PESSOA', itemF('CD_PESSOA', tTRA_REMDES));
      end else begin
        putitemXml(viParams, 'CD_PESSOA', itemF('CD_PESSOA', tTRA_TRANSACAO));
      end;
      if (item('DS_SIGLAESTADO', tTRA_REMDES) <> '') then begin
        putitemXml(viParams, 'UF_DESTINO', item('DS_SIGLAESTADO', tTRA_REMDES));
      end else begin
        putitemXml(viParams, 'UF_DESTINO', item('DS_SIGLAESTADO', tV_PES_ENDERECO));
      end;
    end else begin
      putitemXml(viParams, 'CD_PESSOA', itemF('CD_PESSOA', tTRA_TRANSACAO));
      putitemXml(viParams, 'UF_DESTINO', item('DS_SIGLAESTADO', tV_PES_ENDERECO));
    end;

    putitemXml(viParams, 'CD_OPERACAO', itemF('CD_OPERACAO', tGER_OPERACAO));
    putitemXml(viParams, 'TP_AREACOMERCIO', vTpAreaComercio);
    putitemXml(viParams, 'TP_ORIGEMEMISSAO', itemF('TP_ORIGEMEMISSAO', tTRA_TRANSACAO));
    voParams := activateCmp('FISSVCO015', 'buscaCFOP', viParams);
    if (xStatus < 0) then begin
      Result := voParams;
      return(-1); exit;
    end;

    vCdCFOP := itemXmlF('CD_CFOP', voParams);
  end;

  if (vCdCFOP = 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN001', 'Nenhum CFOP encontrado para o produto ' + FloatToStr(vCdProduto) + ' da transação ' + FloatToStr(vNrTransacao) + '!', cDS_METHOD);
    return(-1); exit;
  end;

  if debug then MensagemLogTempo('CFPO');

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
    putitemXml(viParams, 'CD_OPERACAO', itemF('CD_OPERACAO', tGER_OPERACAO));
    putitemXml(viParams, 'UF_DESTINO', item('DS_SIGLAESTADO', tV_PES_ENDERECO));
    putitemXml(viParams, 'CD_PESSOA', itemF('CD_PESSOA', tTRA_TRANSACAO));
    putitemXml(viParams, 'TP_AREACOMERCIO', vTpAreaComercio);
    putitemXml(viParams, 'TP_ORIGEMEMISSAO', itemF('TP_ORIGEMEMISSAO', tTRA_TRANSACAO));
    putitemXml(viParams, 'CD_CFOP', vCdCFOP);
    voParams := activateCmp('FISSVCO015', 'buscaCST', viParams);
    if (xStatus < 0) then begin
      Result := voParams;
      return(-1); exit;
    end;

    vCdCST := itemXml('CD_CST', voParams);
  end;

  if (vCdCST = '') then begin
    Result := SetStatus(STS_ERROR, 'GEN001', 'Produto ' + FloatToStr(vCdProduto) + ' sem CST cadastrado!', cDS_METHOD);
    return(-1); exit;
  end;

  if debug then MensagemLogTempo('CST');

  if (vCdCompVend = 0) then begin
    vCdCompVend := itemF('CD_COMPVEND', tTRA_TRANSACAO);
  end;

  if (vTpItem   = 'S') then begin
  end else begin
    if (vCdMPTer <> '') then begin
    end else begin
      if (vVlUnitBruto = 0) or (vVlUnitLiquido = 0) then begin
        if (item('TP_OPERACAO', tGER_OPERACAO) = 'E') and (itemF('TP_MODALIDADE', tGER_OPERACAO) = 4) then begin
        end else begin
          if (vCdTabPreco <> 0) then begin
            viParams := '';
            putitemXml(viParams, 'CD_EMPRESA', vCdEmpresa);
            putitemXml(viParams, 'CD_PRODUTO', vCdProduto);
            putitemXml(viParams, 'CD_TABPRECO', vCdTabPreco);
            putitemXml(viParams, 'CD_CONDPGTO', itemF('CD_CONDPGTO', tTRA_TRANSACAO));
            putitemXml(viParams, 'CD_OPERACAO', itemF('CD_OPERACAO', tTRA_TRANSACAO));
            voParams := activateCmp('PEDSVCO008', 'buscaValorProduto', viParams);
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
            putitemXml(viParams, 'CD_CONDPGTO', itemF('CD_CONDPGTO', tTRA_TRANSACAO));
            putitemXml(viParams, 'CD_OPERACAO', itemF('CD_OPERACAO', tTRA_TRANSACAO));
            putitemXml(viParams, 'DT_VALOR', vDtValor);
            putitemXml(viParams, 'IN_VALOR_PADRAO_TRANSF', vInValorPadraoTransf);
            voParams := activateCmp('GERSVCO012', 'buscaValorOperacao', viParams);
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
          if (vCdPromocao > 0) and (gTpValorBrutoPromocao = 1) then begin
            vVlUnitBruto := itemXmlF('VL_ORIGINAL', voParams);
            vVlUnitDesc := vVlUnitBruto - vVlUnitLiquido;
          end;
        end;
      end;
      if (vVlUnitLiquido = 0) or (vVlUnitBruto = 0) then begin
        if (item('TP_OPERACAO', tGER_OPERACAO) = 'S') and ((itemF('TP_MODALIDADE', tGER_OPERACAO) = 4) or (itemF('TP_MODALIDADE', tGER_OPERACAO) = 2) or (itemF('TP_MODALIDADE', tGER_OPERACAO) = 3) or (itemF('TP_MODALIDADE', tGER_OPERACAO) = 7)) then begin
          Result := SetStatus(STS_ERROR, 'GEN001', 'Produto ' + FloatToStr(vCdProduto) + ' com preço zerado!', cDS_METHOD);
          return(-1); exit;
        end;
        if (vInValidaVlZerado = True) then begin
          Result := SetStatus(STS_ERROR, 'GEN001', 'Produto ' + FloatToStr(vCdProduto) + ' com valor zerado!', cDS_METHOD);
          return(-1); exit;
        end;
      end;
    end;
  end;

  if debug then MensagemLogTempo('busca valor');

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
  if (vTpItem = 'S') then begin
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
      putitemXml(Result, 'CD_PRODUTO', itemXml('CD_PRODUTO', vDsRegProduto));
      putitemXml(Result, 'CD_BARRAPRD', vCdBarraPrd);
      putitemXml(Result, 'DS_PRODUTO', itemXml('DS_PRODUTO', vDsRegProduto));
      putitemXml(Result, 'CD_ESPECIE', itemXml('CD_ESPECIE', vDsRegProduto));
      putitemXml(Result, 'CD_TIPI', itemXml('CD_TIPI', vDsRegProduto));
    end;
  end;
  putitemXml(Result, 'CD_CST', vCdCst);
  putitemXml(Result, 'CD_CFOP', vCdCFOP);
  putitemXml(Result, 'CD_COMPVEND', vCdCompVend);
  putitemXml(Result, 'CD_PROMOCAO', vCdPromocao);
  putitemXml(Result, 'QT_SOLICITADA', vQtEmbalagem);
  putitemXml(Result, 'QT_ATENDIDA', 0);
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
  vCdProdutoMsg, viParams, voParams, vCdCST, vDsRegistro, vDsLstImposto, vDsMensagem : String;
  vCdMPTer, vDsProduto, {vDsLstItemLote,} vCdEspecie : String;
  vQtArredondada, vCdEmpresa, vNrTransacao, vNrItem, vCdCFOP, vCdProduto, vQtEstoque, vQtSolicitadaAnt, {vTpLote,} vVlBase, vVlOriginal : Real;
  vCdCompVend, vCdDecreto, vVlCalc, vCdImposto, vVlDif, vQtDisponivel, vQtEntrada, vQtSaida, vCdServico, vCdOper : Real;
  vVlDifUnitario, vVlCalcUnitario, vVlInteiro, vVlFracionado, vNrDescItem, vNr, vCdCustoVenda, vVlUnitCustoVenda, vVlDesconto : Real;
  vDtTransacao : TDateTime;
  vInTotal, vInSoDescricao, vInProdAcabado, vInMatPrima, vInSemMovimento, {vInNaoValidaLote,} vInGravaImposto : Boolean;
  vInImpressao, vInVenda, vInBloqSaldoNeg, vInTransacao : Boolean;
  vDsLstValorVenda, vTpDescAcresc : String;
  vCdRegraFiscal : Real;
begin
  gHrInicio := Now;
  vCdEmpresa := itemXmlF('CD_EMPRESA', pParams);
  vNrTransacao := itemXmlF('NR_TRANSACAO', pParams);
  vDtTransacao := itemXmlD('DT_TRANSACAO', pParams);
  vNrItem := itemXmlF('NR_ITEM', pParams);
  vCdCST := itemXml('CD_CST', pParams);
  vCdCFOP := itemXmlF('CD_CFOP', pParams);
  vCdEspecie := itemXml('CD_ESPECIE', pParams);
  vCdProduto := itemXmlF('CD_PRODUTO', pParams);
  vDsProduto := itemXml('DS_PRODUTO', pParams);
  vCdMPTer := itemXml('CD_MPTER', pParams);
  vCdServico := itemXmlF('CD_SERVICO', pParams);
  vCdCompVend := itemXmlF('CD_COMPVEND', pParams);
  vInTotal := itemXmlB('IN_TOTAL', pParams);
  vDsLstImposto := itemXml('DS_LSTIMPOSTO', pParams);
  //vDsLstItemLote := itemXml('DS_LSTITEMLOTE', pParams);
  vInSemMovimento := itemXmlB('IN_SEMMOVIMENTO', pParams);
  vVlBase := itemXmlF('VL_BASE', pParams);
  vVlOriginal := itemXmlF('VL_ORIGINAL', pParams);
  gCdEspecieServico := itemXml('CD_ESPECIE_SERVICO_TRA', PARAM_GLB);
  vInImpressao := itemXmlB('IN_IMPRESSAO', pParams);
  vInTransacao := itemXmlB('IN_TRANSACAO', pParams);
  //vInNaoValidaLote := itemXmlB('IN_NAOVALIDALOTE', pParams);

  vTpDescAcresc := itemXml('TP_DESCACRESC', pParams);//Zottis 29/04/2014 Implantação do Acréscimo   

  if (vCdEspecie = gCdEspecieServico) then begin
    vCdServico := vCdProduto;
  end;

  if (vCdServico > 0) then begin
    vCdProdutoMsg := FloatToStr(vCdServico);
  end else if (vCdMPTer <> '') then begin
    vCdProdutoMsg := vCdMPTer;
  end else begin
    vCdProdutoMsg := FloatToStr(vCdProduto);
  end;

  //Zottis 29/04/2014 Implantalção do Acréscimo
  if (vTpDescAcresc = '') then begin
    vTpDescAcresc  := 'A';
  end;//Z-

  if (vCdEmpresa = 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN001', 'Empresa não informada!', cDS_METHOD);
    return(-1); exit;
  end;
  if (vNrTransacao = 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN001', 'Número transação não informado!', cDS_METHOD);
    return(-1); exit;
  end;
  if (vDtTransacao = 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN001', 'Data transação não informada!', cDS_METHOD);
    return(-1); exit;
  end;

  if debug then MensagemLogTempo('inicio');

  clear_e(tGER_EMPRESA);
  putitem_o(tGER_EMPRESA, 'CD_EMPRESA', vCdEmpresa);
  retrieve_e(tGER_EMPRESA);
  if (xStatus < 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN001', 'Empresa ' + FloatToStr(vCdEmpresa) + ' não cadastrada!', cDS_METHOD);
    return(-1); exit;
  end;

  if debug then MensagemLogTempo('empresa');

  clear_e(tTRA_TRANSACAO);
  putitem_o(tTRA_TRANSACAO, 'CD_EMPRESA', vCdEmpresa);
  putitem_o(tTRA_TRANSACAO, 'NR_TRANSACAO', vNrTransacao);
  putitem_o(tTRA_TRANSACAO, 'DT_TRANSACAO', vDtTransacao);
  retrieve_e(tTRA_TRANSACAO);
  if (xStatus < 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN001', 'Transação ' + FloatToStr(vNrTransacao) + ' não cadastrada!', cDS_METHOD);
    return(-1); exit;
  end;

  if debug then MensagemLogTempo('transacao');

  if (vCdEspecie <> 'SVC') then begin
    putitemXml(viParams, 'CD_PRODUTO', vCdProduto);
    putitemXml(viParams, 'CD_OPERACAO', itemF('CD_OPERACAO', tGER_OPERACAO));
    putitemXml(viParams, 'IN_KARDEX', item_b('IN_KARDEX', tGER_OPERACAO));
    voParams := validaProdutoBalanco(viParams);
    if (xStatus < 0) then begin
      Result := voParams;
      return(-1); exit;
    end;
  end;

  if ((gCdEmpParam = 0) or (gCdEmpParam <> itemF('CD_EMPFAT', tTRA_TRANSACAO)) or (gInBloqSaldoNeg = 1)) and (gCdOperKardex = '') then begin
    viParams := '';
    putitemXml(viParams, 'CD_EMPRESA', itemF('CD_EMPFAT', tTRA_TRANSACAO));
    getParam(viParams);
    gCdEmpParam := itemF('CD_EMPFAT', tTRA_TRANSACAO);
  end;

  if (gCdOperKardex <> '') then begin
    repeat
      vCdOper := IffNuloF(getitem(gCdOperKardex, 1),0);

      creocc(tTMP_NR09, -1);
      putitem_e(tTMP_NR09, 'NR_GERAL', vCdOper);
      retrieve_o(tTMP_NR09);
      if (xStatus = -7) then begin
        retrieve_x(tTMP_NR09);
      end;

      delitem(gCdOperKardex, 1);
    until (gCdOperKardex = '');
  end;

  if debug then MensagemLogTempo('produto');

  if (gInTransacaoItem = False) then begin
    clear_e(tV_PES_ENDERECO);
    putitem_o(tV_PES_ENDERECO, 'CD_PESSOA', itemF('CD_PESSOA', tPES_PESSOA));
    putitem_o(tV_PES_ENDERECO, 'NR_SEQUENCIA', itemF('NR_SEQENDERECO', tTRA_TRANSACAO));
    retrieve_e(tV_PES_ENDERECO);
    if (xStatus < 0) then begin
      if ((itemF('TP_DOCTO', tGER_OPERACAO) = 2) or (itemF('TP_DOCTO', tGER_OPERACAO) = 3)) and ((itemF('TP_MODALIDADE', tGER_OPERACAO) = 4) or (itemF('TP_MODALIDADE', tGER_OPERACAO) = 8) or (itemF('TP_MODALIDADE', tGER_OPERACAO) = 3)) then begin
        if (gCdPessoaEndPadrao <> 0) then begin
          clear_e(tV_PES_ENDERECO);
          putitem_o(tV_PES_ENDERECO, 'CD_PESSOA', gCdPessoaEndPadrao);
          putitem_o(tV_PES_ENDERECO, 'NR_SEQUENCIA', itemF('NR_SEQENDERECO', tTRA_TRANSACAO));
          retrieve_e(tV_PES_ENDERECO);
          if (xStatus < 0) then begin
            Result := SetStatus(STS_ERROR, 'GEN001', 'endereço ' + item('NR_SEQENDERECO', tTRA_TRANSACAO) + ' não cadastrado para a pessoa ' + FloatToStr(gCdPessoaEndPadrao) + '!', cDS_METHOD);
            return(-1); exit;
          end;
        end else begin
          Result := SetStatus(STS_ERROR, 'GEN001', 'endereço ' + item('NR_SEQENDERECO', tTRA_TRANSACAO) + ' não cadastrado para a pessoa ' + item('CD_PESSOA', tPES_PESSOA) + '!', cDS_METHOD);
          return(-1); exit;
        end;
      end else begin
        Result := SetStatus(STS_ERROR, 'GEN001', 'endereço ' + item('NR_SEQENDERECO', tTRA_TRANSACAO) + ' não cadastrado para a pessoa ' + item('CD_PESSOA', tPES_PESSOA) + '!', cDS_METHOD);
        return(-1); exit;
      end;
    end;
  end;

  if debug then MensagemLogTempo('endereco');

  vInSoDescricao := False;

  if (vCdProduto = 0) and (vCdMPTer = '') and (vCdServico = 0) then begin
    vInSoDescricao := True;
  end else begin
    if (vCdCST = '') then begin
      Result := SetStatus(STS_ERROR, 'GEN001', 'Item ' + FloatToStr(vNrItem) + ' / Produto ' + vCdProdutoMsg + ' da transação ' + FloatToStr(vNrTransacao) + ' sem CST informado!', cDS_METHOD);
      return(-1); exit;
    end;
    if (vCdCFOP = 0) then begin
      Result := SetStatus(STS_ERROR, 'GEN001', 'Item ' + FloatToStr(vNrItem) + ' / Produto ' + vCdProdutoMsg + ' da transação ' + FloatToStr(vNrTransacao) + ' sem CFOP informado!', cDS_METHOD);
      return(-1); exit;
    end;
    if (vCdCompVend = 0) then begin
      Result := SetStatus(STS_ERROR, 'GEN001', 'Item ' + FloatToStr(vNrItem) + ' / Produto ' + vCdProdutoMsg + ' da transação ' + FloatToStr(vNrTransacao) + ' sem Comprador/Vendedor informado!', cDS_METHOD);
      return(-1); exit;
    end;
    if (item('TP_OPERACAO', tGER_OPERACAO) = 'E') then begin
      if (vCdCFOP >= 4000) then begin
        Result := SetStatus(STS_ERROR, 'GEN001', 'CFOP ' + FloatToStr(vCdCFOP) + ' do produto ' + vCdProdutoMsg + ' da transação ' + FloatToStr(vNrTransacao) + ' incompatível com a operação de entrada!', cDS_METHOD);
        return(-1); exit;
      end;
    end else if (item('TP_OPERACAO', tGER_OPERACAO) = 'S') then begin
      if (vCdCFOP < 5000) then begin
        Result := SetStatus(STS_ERROR, 'GEN001', 'CFOP ' + FloatToStr(vCdCFOP) + ' do produto ' + vCdProdutoMsg + ' da transação ' + FloatToStr(vNrTransacao) + ' incompatível com a operação de saída!', cDS_METHOD);
        return(-1); exit;
      end;
    end;
    if ((item('TP_OPERACAO', tGER_OPERACAO) = 'E') and ((itemF('TP_MODALIDADE', tGER_OPERACAO) = 4) or (item('TP_OPERACAO', tGER_OPERACAO) = 'S')) and (itemF('TP_MODALIDADE', tGER_OPERACAO) = 3)) and (vCdServico = 0) then begin
      viParams := '';
      putitemXml(viParams, 'CD_FORNECEDOR', itemF('CD_PESSOA', tTRA_TRANSACAO));
      putitemXml(viParams, 'CD_PRODUTO', vCdProduto);
      voParams := activateCmp('PRDSVCO008', 'validaProdutoFornecedor', viParams);
      if (xStatus < 0) then begin
        Result := voParams;
        return(-1); exit;
      end;
    end;
  end;

  if debug then MensagemLogTempo('validacao');

  clear_e(tTRA_TRANSITEM);
  creocc(tTRA_TRANSITEM, -1);

  vQtSolicitadaAnt := 0;

  if (vNrItem = 0) then begin
    clear_e(tTRA_TRANSITEM);
    putitem_o(tTRA_TRANSITEM, 'CD_EMPRESA', vCdEmpresa);
    putitem_o(tTRA_TRANSITEM, 'NR_TRANSACAO', vNrTransacao);
    putitem_o(tTRA_TRANSITEM, 'DT_TRANSACAO', vDtTransacao);
    voParams := tTRA_TRANSITEM.selectdb('NR_ITEM=max(NR_ITEM);');
    vNrItem := itemXmlF('NR_ITEM', voParams) + 1;

    putitem_e(tTRA_TRANSITEM, 'NR_ITEM', vNrItem);
  end else begin
    putitem_o(tTRA_TRANSITEM, 'NR_ITEM', vNrItem);
    retrieve_o(tTRA_TRANSITEM);
    if (xStatus = -7) then begin
      retrieve_x(tTRA_TRANSITEM);
      vQtSolicitadaAnt := itemF('QT_SOLICITADA', tTRA_TRANSITEM);
      if (empty(tTRA_ITEMIMPOSTO) = False) then begin
        voParams := tTRA_ITEMIMPOSTO.Excluir();
        if (xStatus < 0) then begin
          Result := voParams;
          return(-1); exit;
        end;
      end;
      if (itemF('QT_SOLICITADA', tTRA_TRANSITEM) = 0) then begin
        viParams := '';
        putitemXml(viParams, 'CD_EMPRESA', itemF('CD_EMPRESA', tTRA_TRANSITEM));
        putitemXml(viParams, 'NR_TRANSACAO', itemF('NR_TRANSACAO', tTRA_TRANSITEM));
        putitemXml(viParams, 'DT_TRANSACAO', item('DT_TRANSACAO', tTRA_TRANSITEM));
        putitemXml(viParams, 'NR_ITEM', itemF('NR_ITEM', tTRA_TRANSITEM));
        voParams := activateCmp('SICSVCO005', 'arredondaQtFracionada', viParams);
        if (xStatus < 0) then begin
          Result := voParams;
          return(-1); exit;
        end;
        vQtArredondada := itemXmlF('QT_SOLICITADA', voParams);
      end else begin
        vQtArredondada := itemF('QT_SOLICITADA', tTRA_TRANSITEM);
      end;
    end;
  end;
  if (itemF('TP_DOCTO', tGER_OPERACAO) = 2) or (itemF('TP_DOCTO', tGER_OPERACAO) = 3) then begin
    if (itemF('NR_ITEM', tTRA_TRANSITEM) > 990) then begin
      Result := SetStatus(STS_ERROR, 'GEN001', 'Quantidade de itens da transação não pode ser maior que 990!Convênio 57/95 do SINTEGRA.', cDS_METHOD);
      return(-1); exit;
    end;
  end else if (gNrItemQuebraNf = 0) then begin
    if (itemF('NR_ITEM', tTRA_TRANSITEM) > 990) then begin
      Result := SetStatus(STS_ERROR, 'GEN001', 'Quantidade de itens da transação não pode ser maior que 990!Convênio 57/95 do SINTEGRA.', cDS_METHOD);
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
    putitem_e(tTRA_TRANSITEM, 'CD_EMPRESA', vCdEmpresa);
    putitem_e(tTRA_TRANSITEM, 'NR_TRANSACAO', vNrTransacao);
    putitem_e(tTRA_TRANSITEM, 'DT_TRANSACAO', vDtTransacao);
    putitem_e(tTRA_TRANSITEM, 'NR_ITEM', vNrItem);
    if (itemF('TP_SITUACAO', tTRA_TRANSACAO) = 4) or (itemF('TP_SITUACAO', tTRA_TRANSACAO) = 5) then begin
      putitem_e(tTRA_TRANSITEM, 'QT_ATENDIDA', itemF('QT_SOLICITADA', tTRA_TRANSITEM));
      putitem_e(tTRA_TRANSITEM, 'QT_SALDO', 0);
    end else begin
      putitem_e(tTRA_TRANSITEM, 'QT_SALDO', itemF('QT_SOLICITADA', tTRA_TRANSITEM));
      putitem_e(tTRA_TRANSITEM, 'QT_ATENDIDA', 0);
    end;
    if (vCdMPTer = '') and (vCdServico = 0) then begin
      viParams := '';
      putitemXml(viParams, 'CD_EMPRESA', itemF('CD_EMPRESA', tGER_EMPRESA));
      putitemXml(viParams, 'CD_PRODUTO', vCdProduto);
      voParams := activateCmp('PRDSVCO008', 'buscaDadosFilial', viParams);
      if (xStatus < 0) then begin
        Result := voParams;
        return(-1); exit;
      end;
      vInMatPrima := itemXmlB('IN_MATPRIMA', voParams);
      vInProdAcabado := itemXmlB('IN_PRODACABADO', voParams);
      //vTpLote := itemXmlF('TP_LOTE', voParams);
    end;
    (* if (vTpLote > 0) and (item('TP_OPERACAO', tTRA_TRANSACAO) = 'S') and not (vInNaoValidaLote) and (item_b('IN_KARDEX', tGER_OPERACAO)) then begin
      if (vDsLstItemLote = '') then begin
        Result := SetStatus(STS_ERROR, 'GEN001', 'Lista de itens de lote não informada para o produto ' + FloatToStr(vCdProduto) + ' da transação ' + FloatToStr(vNrTransacao) + '', cDS_METHOD);
        return(-1); exit;
      end;
    end; *)

    if debug then MensagemLogTempo('dados filial');

    vInBloqSaldoNeg := True;
    if (empty(tTMP_NR09) = False) then begin
      creocc(tTMP_NR09, -1);
      putitem_e(tTMP_NR09, 'NR_GERAL', itemF('CD_OPERACAO', tTRA_TRANSACAO));
      retrieve_o(tTMP_NR09);
      if (xStatus = 4) then begin
        vInBloqSaldoNeg := False;
      end else begin
        discard(tTMP_NR09);
      end;
    end;
    if (vInBloqSaldoNeg)
    and (((gInBloqSaldoNeg = 1)  or
          ((gInBloqSaldoNeg = 2) and (vInProdAcabado = True))  or
          ((gInBloqSaldoNeg = 3) and (vInMatPrima = True))  or
           (gInBloqSaldoNeg = 4)  or
          ((gInBloqSaldoNeg = 5) and (vInProdAcabado = True))  or
          ((gInBloqSaldoNeg = 6) and (vInMatPrima = True)))
    and (item('TP_OPERACAO', tTRA_TRANSACAO) = 'S')
    and ((item_b('IN_KARDEX', tGER_OPERACAO) = True) or (item_b('IN_KARDEX', tGER_S_OPERACAO) = True)) and (vCdMPTer = '') and (vCdServico = 0)) then begin

      if (vInImpressao = True) then begin
      end else begin

        viParams := '';
        putitemXml(viParams, 'CD_GRUPOEMPRESA', itemF('CD_GRUPOEMPRESA', tGER_EMPRESA));
        putitemXml(viParams, 'CD_PRODUTO', vCdProduto);
        putitemXml(viParams, 'CD_OPERACAO', itemF('CD_OPERACAO', tTRA_TRANSACAO));
        putitemXml(viParams, 'IN_VALIDALOCAL', False);
        putitemXml(viParams, 'IN_TRANSACAO', vInTransacao);
        voParams := activateCmp('PRDSVCO015', 'verificaSaldoProduto', viParams);
        if (xStatus < 0) then begin
          Result := voParams;
          return(-1); exit;
        end;

        vQtDisponivel := itemXmlF('QT_DISPONIVEL', voParams);
        vQtEntrada := itemXmlF('QT_ENTRADA', voParams);
        vQtSaida := itemXmlF('QT_SAIDA', voParams);
        vQtEstoque := itemXmlF('QT_ESTOQUE', voParams);

        if ((itemF('QT_SOLICITADA', tTRA_TRANSITEM) - vQtSolicitadaAnt) > vQtDisponivel) then begin
          if (gInBloqSaldoNeg = 1) or (gInBloqSaldoNeg = 2) or (gInBloqSaldoNeg = 3) then begin
            Result := SetStatus(STS_ERROR, 'GEN001', 'Quantidade ' + item('QT_SOLICITADA', tTRA_TRANSITEM) + ' do produto ' + FloatToStr(vCdProduto) + ' da transação ' + FloatToStr(vNrTransacao) + ' maior que disponível ' + FloatToStr(vQtDisponivel) + '! ' + FloatToStr(vQtEstoque) + ' em estoque / ' + FloatToStr(vQtEntrada) + ' em entrada / ' + FloatToStr(vQtSaida) + ' em saída.', cDS_METHOD);
            return(-1); exit;
          end else if (gInBloqSaldoNeg = 4) or (gInBloqSaldoNeg = 5) or (gInBloqSaldoNeg = 6) then begin
            vDsMensagem := 'Quantidade ' + item('QT_SOLICITADA', tTRA_TRANSITEM) + ' do produto ' + FloatToStr(vCdProduto) + ' da transação ' + FloatToStr(vNrTransacao) + ' maior que disponível ' + FloatToStr(vQtDisponivel) + '! ' + FloatToStr(vQtEstoque) + ' em estoque / ' + FloatToStr(vQtEntrada) + ' em entrada / ' + FloatToStr(vQtSaida) + ' em saída.';
          end;
        end;
      end;
    end;

  //aqui

    if (itemF('VL_TOTALDESC', tTRA_TRANSITEM) > 0) or (itemF('VL_TOTALDESCCAB', tTRA_TRANSITEM) > 0) then begin
      vVlDif := itemF('VL_TOTALBRUTO', tTRA_TRANSITEM) - (itemF('VL_TOTALLIQUIDO', tTRA_TRANSITEM) + itemF('VL_TOTALDESC', tTRA_TRANSITEM) + itemF('VL_TOTALDESCCAB', tTRA_TRANSITEM));

      if (vVlDif <> 0) then begin
        if (vQtArredondada = 0) then begin
          if (itemF('QT_SOLICITADA', tTRA_TRANSITEM) > 0) then begin
            vQtArredondada := itemF('QT_SOLICITADA', tTRA_TRANSITEM);
          end;
        end;
        if (itemF('VL_TOTALDESC', tTRA_TRANSITEM) > itemF('VL_TOTALDESCCAB', tTRA_TRANSITEM)) then begin
          putitem_e(tTRA_TRANSITEM, 'VL_TOTALDESC', itemF('VL_TOTALDESC', tTRA_TRANSITEM) + vVlDif);
          vVlCalc := itemF('VL_TOTALDESC', tTRA_TRANSITEM) / vQtArredondada;
          putitem_e(tTRA_TRANSITEM, 'VL_UNITDESC', rounded(vVlCalc, 6));
        end else begin
          putitem_e(tTRA_TRANSITEM, 'VL_TOTALDESCCAB', itemF('VL_TOTALDESCCAB', tTRA_TRANSITEM) + vVlDif);
          vVlCalc := itemF('VL_TOTALDESCCAB', tTRA_TRANSITEM) / vQtArredondada;
          putitem_e(tTRA_TRANSITEM, 'VL_UNITDESCCAB', rounded(vVlCalc, 6));
        end;
      end;
    end;
    if (item('TP_OPERACAO', tGER_OPERACAO) = 'S') and (itemF('TP_MODALIDADE', tGER_OPERACAO) = 4) then begin
      vInVenda := True;
    end else begin
      vInVenda := False;
    end;
    if ((itemXmlF('TP_ARREDOND_VL_UNIT_VD', PARAM_GLB) = 1) or (itemXmlF('TP_ARREDOND_VL_UNIT_VD', PARAM_GLB) = 2)) and (vInVenda = True) then begin
      if (itemF('QT_SOLICITADA', tTRA_TRANSITEM) > 0) then begin
        if (itemF('VL_UNITDESC', tTRA_TRANSITEM) > 0) or (itemF('VL_UNITDESCCAB', tTRA_TRANSITEM) > 0) then begin
          vVlDifUnitario := itemF('VL_UNITBRUTO', tTRA_TRANSITEM) - (itemF('VL_UNITLIQUIDO', tTRA_TRANSITEM) + itemF('VL_UNITDESC', tTRA_TRANSITEM) + itemF('VL_UNITDESCCAB', tTRA_TRANSITEM));
          if (vVlDifUnitario <> 0) then begin
            if (itemF('VL_UNITDESC', tTRA_TRANSITEM) > itemF('VL_UNITDESCCAB', tTRA_TRANSITEM)) then begin
              putitem_e(tTRA_TRANSITEM, 'VL_UNITDESC', itemF('VL_UNITDESC', tTRA_TRANSITEM) + vVlDifUnitario);
            end else begin
              putitem_e(tTRA_TRANSITEM, 'VL_UNITDESCCAB', itemF('VL_UNITDESCCAB', tTRA_TRANSITEM) + vVlDifUnitario);
            end;
          end;
        end;
        if (itemXmlF('TP_ARREDOND_VL_UNIT_VD', PARAM_GLB) = 1) then begin
          vVlCalc := rounded(itemF('VL_UNITBRUTO', tTRA_TRANSITEM), 2);
          putitem_e(tTRA_TRANSITEM, 'VL_UNITBRUTO', vVlCalc);

          vVlCalc := itemF('VL_UNITBRUTO', tTRA_TRANSITEM) * itemF('QT_SOLICITADA', tTRA_TRANSITEM);
          putitem_e(tTRA_TRANSITEM, 'VL_TOTALBRUTO', rounded(vVlCalc, 2));
          putitem_e(tTRA_TRANSITEM, 'VL_TOTALLIQUIDO', itemF('VL_TOTALBRUTO', tTRA_TRANSITEM) - (itemF('VL_TOTALDESCCAB', tTRA_TRANSITEM) + itemF('VL_TOTALDESC', tTRA_TRANSITEM)));

          vVlCalc := itemF('VL_TOTALLIQUIDO', tTRA_TRANSITEM) /  itemF('QT_SOLICITADA', tTRA_TRANSITEM);
          putitem_e(tTRA_TRANSITEM, 'VL_UNITLIQUIDO', rounded(vVlCalc, 6));

        end else if (itemXmlF('TP_ARREDOND_VL_UNIT_VD', PARAM_GLB) = 2) then begin
          vVlCalc := rounded(itemF('VL_UNITBRUTO', tTRA_TRANSITEM), 2);
          putitem_e(tTRA_TRANSITEM, 'VL_UNITBRUTO', vVlCalc);

          vVlCalc := itemF('VL_UNITBRUTO', tTRA_TRANSITEM) * itemF('QT_SOLICITADA', tTRA_TRANSITEM);
          vVlInteiro := int(vVlCalc);
          vVlFracionado := vVlCalc - vVlInteiro;
          vVlFracionado := int(vVlFracionado * 10000) / 10000;
          vVlCalc := vVlInteiro + vVlFracionado;
          putitem_e(tTRA_TRANSITEM, 'VL_TOTALBRUTO', vVlCalc);
          putitem_e(tTRA_TRANSITEM, 'VL_TOTALLIQUIDO', itemF('VL_TOTALBRUTO', tTRA_TRANSITEM) - (itemF('VL_TOTALDESCCAB', tTRA_TRANSITEM) + itemF('VL_TOTALDESC', tTRA_TRANSITEM)));

          vVlCalc := itemF('VL_TOTALLIQUIDO', tTRA_TRANSITEM) /  itemF('QT_SOLICITADA', tTRA_TRANSITEM);
          putitem_e(tTRA_TRANSITEM, 'VL_UNITLIQUIDO', rounded(vVlCalc, 6));
        end;
      end;
    end;

    if debug then MensagemLogTempo('saldo');

    vCdCustoVenda := itemXmlF('CD_CUSTO_VALIDA_VENDA', xParamEmp);
    if (item('TP_OPERACAO', tGER_OPERACAO) = 'S') and (itemF('TP_MODALIDADE', tGER_OPERACAO) = 4) and (vCdCustoVenda <> 0) then begin
      viParams := '';
      putitemXml(viParams, 'CD_EMPRESA', itemF('CD_EMPRESA', tTRA_TRANSACAO));
      putitemXml(viParams, 'CD_PRODUTO', vCdProduto);
      putitemXml(viParams, 'TP_VALOR', 'C');
      putitemXml(viParams, 'CD_VALOR', vCdCustoVenda);
      voParams := activateCmp('PRDSVCO007', 'buscaValorData', viParams);
      if (xStatus < 0) then begin
        Result := voParams;
        return(-1); exit;
      end;

      vVlUnitCustoVenda := itemXmlF('VL_VALOR', voParams);

      if (vVlUnitCustoVenda > itemF('VL_UNITLIQUIDO', tTRA_TRANSITEM)) then begin
        Result := SetStatus(STS_ERROR, 'GEN001', 'Valor de venda menor que o valor de custo. Parâmetro CD_CUSTO_VALIDA_VENDA!', cDS_METHOD);
        return(-1); exit;
      end;
    end;

    if debug then MensagemLogTempo('valor');

    if vTpDescAcresc = 'D' then begin//Zottis 29/04/2014 implantação do acréscimo
      if (itemF('VL_UNITBRUTO', tTRA_TRANSITEM) < 0) then begin
        Result := SetStatus(STS_ERROR, 'GEN001', 'VL_UNITBRUTO do item ' + item('NR_ITEM', tTRA_TRANSITEM) + ' não pode ser negativo!', cDS_METHOD);
        return(-1); exit;
      {end else if (itemF('VL_UNITDESC', tTRA_TRANSITEM) < 0) then begin
        Result := SetStatus(STS_ERROR, 'GEN001', 'VL_UNITDESC do item ' + item('NR_ITEM', tTRA_TRANSITEM) + ' não pode ser negativo!', cDS_METHOD);
        return(-1); exit;}
      end else if (itemF('VL_UNITLIQUIDO', tTRA_TRANSITEM) < 0) then begin
        Result := SetStatus(STS_ERROR, 'GEN001', 'VL_UNITLIQUIDO do item ' + item('NR_ITEM', tTRA_TRANSITEM) + ' não pode ser negativo!', cDS_METHOD);
        return(-1); exit;
      end else if (itemF('VL_TOTALBRUTO', tTRA_TRANSITEM) < 0) then begin
        Result := SetStatus(STS_ERROR, 'GEN001', 'VL_TOTALBRUTO do item ' + item('NR_ITEM', tTRA_TRANSITEM) + ' não pode ser negativo!', cDS_METHOD);
        return(-1); exit;
      {end else if (itemF('VL_TOTALDESC', tTRA_TRANSITEM) < 0) then begin
        Result := SetStatus(STS_ERROR, 'GEN001', 'VL_TOTALDESC do item ' + item('NR_ITEM', tTRA_TRANSITEM) + ' não pode ser negativo!', cDS_METHOD);
        return(-1); exit;}
      end else if (itemF('VL_TOTALLIQUIDO', tTRA_TRANSITEM) < 0) then begin
        Result := SetStatus(STS_ERROR, 'GEN001', 'VL_TOTALLIQUIDO do item ' + item('NR_ITEM', tTRA_TRANSITEM) + ' não pode ser negativo!', cDS_METHOD);
        return(-1); exit;
      end;
    end;

    if (itemF('QT_SOLICITADA', tTRA_TRANSITEM) > 0) and (itemF('VL_UNITBRUTO', tTRA_TRANSITEM) > 0) and (itemF('VL_UNITLIQUIDO', tTRA_TRANSITEM) > 0) then begin
      if (itemF('VL_TOTALBRUTO', tTRA_TRANSITEM) = 0) then begin
        putitem_e(tTRA_TRANSITEM, 'VL_TOTALBRUTO', 0.01);
      end;
      if (itemF('VL_TOTALLIQUIDO', tTRA_TRANSITEM) = 0) then begin
        putitem_e(tTRA_TRANSITEM, 'VL_TOTALLIQUIDO', 0.01);
      end;
    end;
    if (vDsLstImposto = '') then begin

      //-- nova regra fiscal
      if (vCdRegraFiscal = 0) then begin
        if (vCdServico > 0) or (vCdMPTer <> '') then begin
          vCdRegraFiscal := itemF('CD_REGRAFISCAL', tGER_OPERACAO);
        end else begin
          clear_e(tPRD_PRDREGRAFISCAL);
          putitem_o(tPRD_PRDREGRAFISCAL, 'CD_PRODUTO', itemF('CD_PRODUTO', tTRA_TRANSITEM));
          putitem_o(tPRD_PRDREGRAFISCAL, 'CD_OPERACAO', itemF('CD_OPERACAO', tGER_OPERACAO));
          retrieve_e(tPRD_PRDREGRAFISCAL);
          if (xStatus >= 0) then begin
            vCdRegraFiscal := itemF('CD_REGRAFISCAL', tPRD_PRDREGRAFISCAL);
          end else begin
            vCdRegraFiscal := itemF('CD_REGRAFISCAL', tGER_OPERACAO);
          end;
        end;
      end;
      //--

      //-- nova regra fiscal
      if (vCdRegraFiscal > 0) then begin
        clear_e(tFIS_REGRAADIC);
        putitem(tFIS_REGRAADIC, 'CD_REGRAFISCAL', vCdRegraFiscal);
        retrieve_e(tFIS_REGRAADIC);
        if (xStatus < 0) then begin
          clear_e(tFIS_REGRAADIC);
        end;
      end;
      //--

      viParams := '';
      putitemXml(viParams, 'CD_EMPRESA', itemF('CD_EMPFAT', tTRA_TRANSACAO));
      //putitemXml(viParams, 'UF_DESTINO', item('DS_SIGLAESTADO', tV_PES_ENDERECO));
      putitemXml(viParams, 'TP_ORIGEMEMISSAO', itemF('TP_ORIGEMEMISSAO', tTRA_TRANSACAO));
      putitemXml(viParams, 'CD_PRODUTO', itemF('CD_PRODUTO', tTRA_TRANSITEM));
      putitemXml(viParams, 'CD_MPTER', vCdMPTer);
      putitemXml(viParams, 'CD_SERVICO', vCdServico);
      putitemXml(viParams, 'CD_OPERACAO', itemF('CD_OPERACAO', tGER_OPERACAO));
      //putitemXml(viParams, 'CD_PESSOA', itemF('CD_PESSOA', tTRA_TRANSACAO));
      putitemXml(viParams, 'CD_CST', item('CD_CST', tTRA_TRANSITEM));
      putitemXml(viParams, 'VL_TOTALBRUTO', itemF('VL_TOTALBRUTO', tTRA_TRANSITEM));
      putitemXml(viParams, 'VL_TOTALLIQUIDO', itemF('VL_TOTALLIQUIDO', tTRA_TRANSITEM));
      putitemXml(viParams, 'PR_IPI', itemXmlF('PR_IPI', pParams));
      putitemXml(viParams, 'VL_IPI', itemXmlF('VL_IPI', pParams));
      putitemXml(viParams, 'DT_INIVIGENCIA', item('DT_TRANSACAO', tTRA_TRANSACAO));
      putitemXml(viParams, 'CD_REGRAFISCAL', vCdRegraFiscal);
      putitemXml(viParams, 'CD_TIPI', item('CD_TIPI', tTRA_TRANSITEM));

      //-- nova regra fiscal
      if (item('DS_SIGLAESTADO', tTRA_REMDES) = '') then begin
        putitemXml(viParams, 'UF_DESTINO', item('DS_SIGLAESTADO', tV_PES_ENDERECO));
      end else begin
        putitemXml(viParams, 'UF_DESTINO', item('DS_SIGLAESTADO', tTRA_REMDES));
      end;
      //--

      //-- nova regra fiscal
      if (item('CD_PESSOA', tTRA_REMDES) = '') then begin
        putitemXml(viParams, 'CD_PESSOA', itemF('CD_PESSOA', tTRA_TRANSACAO));
      end else begin
        putitemXml(viParams, 'CD_PESSOA', itemF('CD_PESSOA', tTRA_REMDES));
      end;
      //--

      //-- nova regra fiscal
      if (itemB('IN_NOVAREGRA', tFIS_REGRAADIC) = TRUE) then begin
        putitemXml(viParams, 'CD_REGRAFISCAL', vCdRegraFiscal);
        voParams := activateCmp('FISSVCO080', 'buscaRegraRelacionada', viParams);
        if (xStatus < 0) then begin
          Result := voParams; exit;
        end;
        vCdRegraFiscal := itemXmlF('CD_REGRAFISCAL', voParams);

        putitemXml(viParams, 'CD_REGRAFISCAL', vCdRegraFiscal);
        putitemXml(viParams, 'IN_CONTRIBUINTE', itemXmlB('IN_CONTRIBUINTE', voParams));
        voParams := activateCmp('FISSVCO080', 'calculaImpostoItem', viParams);
        if (xStatus < 0) then begin
          Result := voParams; exit;
        end;
        vDsLstImposto := itemXml('DS_LSTIMPOSTO', voParams);
        vCdCST := itemXml('CD_CST', voParams);
        vCdCFOP := itemXmlF('CD_CFOP', voParams);

        putitem(tTRA_ITEMADIC, 'CD_REGRAFISCAL', vCdRegraFiscal);
        putitem(tTRA_ITEMADIC, 'CD_OPERADOR', itemXmlF('CD_USUARIO', PARAM_GLB));
        putitem(tTRA_ITEMADIC, 'DT_CADASTRO', Now);
      end else begin
      //--
        voParams := activateCmp('FISSVCO015', 'calculaImpostoItem', viParams);
        if (xStatus < 0) then begin
          Result := voParams; exit;
        end;
        vDsLstImposto := itemXml('DS_LSTIMPOSTO', voParams);
        vCdCST := itemXml('CD_CST', voParams);
        vCdDecreto := itemXmlF('CD_DECRETO', voParams);
      end;
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
          delitem(vDsRegistro, 'U_VERSION');

          clear_e(tF_TRA_ITEMIMPOSTO);
          //creocc(tF_TRA_ITEMIMPOSTO, -1);
          //putitem_o(tF_TRA_ITEMIMPOSTO, 'CD_IMPOSTO', itemXml('CD_IMPOSTO', vDsRegistro));
          //retrieve_o(tF_TRA_ITEMIMPOSTO);
          getlistitensocc_e(vDsRegistro, tF_TRA_ITEMIMPOSTO);
          putitem_e(tF_TRA_ITEMIMPOSTO, 'CD_EMPRESA', item('CD_EMPRESA', tTRA_TRANSITEM));
          putitem_e(tF_TRA_ITEMIMPOSTO, 'NR_TRANSACAO', item('NR_TRANSACAO', tTRA_TRANSITEM));
          putitem_e(tF_TRA_ITEMIMPOSTO, 'DT_TRANSACAO', item('DT_TRANSACAO', tTRA_TRANSITEM));
          putitem_e(tF_TRA_ITEMIMPOSTO, 'NR_ITEM', item('NR_ITEM', tTRA_TRANSITEM));
          putitem_e(tF_TRA_ITEMIMPOSTO, 'CD_EMPFAT', itemF('CD_EMPFAT', tTRA_TRANSACAO));
          putitem_e(tF_TRA_ITEMIMPOSTO, 'CD_GRUPOEMPRESA', itemF('CD_GRUPOEMPRESA', tTRA_TRANSACAO));
          putitem_e(tF_TRA_ITEMIMPOSTO, 'CD_OPERADOR', itemXmlF('CD_USUARIO', PARAM_GLB));
          putitem_e(tF_TRA_ITEMIMPOSTO, 'DT_CADASTRO', Now);
          voParams := tF_TRA_ITEMIMPOSTO.Salvar();
          if (xStatus < 0) then begin
            Result := voParams;
            return(-1); exit;
          end;
        end;

        delitemGld(vDsLstImposto, 1);
      until (vDsLstImposto = '');
    end;

    if debug then MensagemLogTempo('imposto');

    if (vCdCST <> '') then begin
      putitem_e(tTRA_TRANSITEM, 'CD_CST', vCdCST);
    end;
    if (vCdDecreto > 0) then begin
      putitem_e(tTRA_TRANSITEM, 'CD_DECRETO', vCdDecreto);
    end;

    vVlCalc := (itemF('VL_TOTALDESC', tTRA_TRANSITEM) + itemF('VL_TOTALDESCCAB', tTRA_TRANSITEM)) / itemF('VL_TOTALBRUTO', tTRA_TRANSITEM) * 100;
    putitem_e(tTRA_TRANSITEM, 'PR_DESCONTO', rounded(vVlCalc, 6));

    if (itemF('PR_DESCONTO', tTRA_TRANSITEM) <> 0) then begin
      putitem_e(tTRA_TRANSITEM, 'IN_DESCONTO', True);
    end else begin
      putitem_e(tTRA_TRANSITEM, 'IN_DESCONTO', False);
    end;
  end;

  putitem_e(tTRA_TRANSITEM, 'CD_EMPFAT', itemF('CD_EMPFAT', tTRA_TRANSACAO));
  putitem_e(tTRA_TRANSITEM, 'CD_GRUPOEMPRESA', itemF('CD_GRUPOEMPRESA', tTRA_TRANSACAO));
  putitem_e(tTRA_TRANSITEM, 'CD_OPERADOR', itemXmlF('CD_USUARIO', PARAM_GLB));
  putitem_e(tTRA_TRANSITEM, 'DT_CADASTRO', Now);

  voParams := tTRA_TRANSITEM.Salvar();
  if (xStatus < 0) then begin
    Result := voParams;
    return(-1); exit;
  end;
  if (itemF('CD_PRODUTO', tTRA_TRANSITEM) = 0) and (itemF('TP_DOCTO', tGER_OPERACAO) = 1) then begin
    vNrDescItem := length(item('DS_PRODUTO', tTRA_TRANSITEM));

    clear_e(tTRA_TRANSITEM);
    putitem_o(tTRA_TRANSITEM, 'CD_EMPRESA', vCdEmpresa);
    putitem_o(tTRA_TRANSITEM, 'NR_TRANSACAO', vNrTransacao);
    putitem_o(tTRA_TRANSITEM, 'DT_TRANSACAO', vDtTransacao);
    putitem_o(tTRA_TRANSITEM, 'NR_ITEM', '<' + FloatToStr(vNrItem));
    retrieve_e(tTRA_TRANSITEM);
    if (xStatus >= 0) then begin
      tTRA_TRANSITEM.IndexFieldNames := 'NR_ITEM';
      setocc(tTRA_TRANSITEM, 1);
      while(xStatus >= 0) do begin
        if (itemF('CD_PRODUTO', tTRA_TRANSITEM) = 0) then begin
          vNr := length(item('DS_PRODUTO', tTRA_TRANSITEM));
          vNrDescItem := vNrDescItem + vNr;
        end else begin
          break;
        end;
        setocc(tTRA_TRANSITEM, curocc(tTRA_TRANSITEM) + 1);
      end;
    end;
    if (vNrDescItem > 500) then begin
      Result := SetStatus(STS_ERROR, 'GEN001', 'Item ' + item('NR_ITEM', tTRA_TRANSITEM) + ' da transação ' + FloatToStr(vNrTransacao) + ' possui itens descritivos com tamanho superior a 500 caracteres!', cDS_METHOD);
      return(-1); exit;
    end;
  end;

  if debug then MensagemLogTempo('tamanho descricao');

  if (vVlBase > 0) and (vVlOriginal > 0) then begin
    viParams := '';
    putitemXml(viParams, 'CD_EMPRESA', itemF('CD_EMPRESA', tTRA_TRANSITEM));
    putitemXml(viParams, 'NR_TRANSACAO', itemF('NR_TRANSACAO', tTRA_TRANSITEM));
    putitemXml(viParams, 'DT_TRANSACAO', item('DT_TRANSACAO', tTRA_TRANSITEM));
    putitemXml(viParams, 'NR_ITEM', itemF('NR_ITEM', tTRA_TRANSITEM));
    putitemXml(viParams, 'VL_BASE', vVlBase);
    putitemXml(viParams, 'VL_ORIGINAL', vVlOriginal);
    voParams := activateCmp('TRASVCO024', 'gravaTraItemAdic', viParams);
    if (xStatus < 0) then begin
      Result := voParams;
      return(-1); exit;
    end;
  end;

  if debug then MensagemLogTempo('adicional item');

  (* if (vTpLote > 0) and (vDsLstItemLote <> '')  and not (vInNaoValidaLote) then begin
    viParams := '';
    putitemXml(viParams, 'CD_EMPRESA', itemF('CD_EMPRESA', tTRA_TRANSITEM));
    putitemXml(viParams, 'NR_TRANSACAO', itemF('NR_TRANSACAO', tTRA_TRANSITEM));
    putitemXml(viParams, 'DT_TRANSACAO', item('DT_TRANSACAO', tTRA_TRANSITEM));
    putitemXml(viParams, 'NR_ITEM', itemF('NR_ITEM', tTRA_TRANSITEM));
    putitemXml(viParams, 'DS_LSTITEMLOTE', vDsLstItemLote);
    putitemXml(viParams, 'IN_SEMMOVIMENTO', vInSemMovimento);
    voParams := activateCmp('TRASVCO016', 'gravaItemLote', viParams);
    if (xStatus < 0) then begin
      Result := voParams;
      return(-1); exit;
    end;
  end; *)

  if debug then MensagemLogTempo('item lote');

  if (vInTotal = True) then begin
    viParams := '';
    voParams := calculaTotalTransacao(viParams); (* calculaTotalOtimizado(viParams); *)
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

  if debug then MensagemLogTempo('calcula total');

  if ((item('TP_OPERACAO', tGER_OPERACAO) = 'E') and ((itemF('TP_MODALIDADE', tGER_OPERACAO) = 4) or (itemF('TP_MODALIDADE', tGER_OPERACAO) = 2)) or (itemF('CD_OPERACAO', tGER_OPERACAO) = gCdOperacaoOI)) then begin
  end else begin
    if (gDsLstValorVenda <> '') and (item('CD_ESPECIE', tTRA_TRANSITEM) <> gCdEspecieServico) and (itemF('CD_PRODUTO', tTRA_TRANSITEM) > 0) then begin
      viParams := '';
      putitemXml(viParams, 'DS_LSTVALOR', gDsLstValorVenda);
      putitemXml(viParams, 'CD_EMPRESA', itemF('CD_EMPRESA', tTRA_TRANSACAO));
      putitemXml(viParams, 'NR_TRANSACAO', itemF('NR_TRANSACAO', tTRA_TRANSACAO));
      putitemXml(viParams, 'DT_TRANSACAO', item('DT_TRANSACAO', tTRA_TRANSACAO));
      putitemXml(viParams, 'NR_ITEM', vNrItem);
      putitemXml(viParams, 'CD_PRODUTO', itemF('CD_PRODUTO', tTRA_TRANSITEM));
      putitemXml(viParams, 'CD_EMPFAT', itemF('CD_EMPFAT', tTRA_TRANSACAO));
      putitemXml(viParams, 'CD_GRUPOEMPRESA', itemF('CD_GRUPOEMPRESA', tTRA_TRANSACAO));
      //voParams := activateCmp('TRASVCO016', 'gravaItemValor', viParams);
      //if (xStatus < 0) then begin
      //  Result := voParams;
      //  return(-1); exit;
      //end;
      vDsLstValorVenda := itemXml('DS_LSTVALORVENDA', voParams);
    end;
  end;

  if debug then MensagemLogTempo('custo do produto');

  gHrFim := Now;
  gHrTempo := gHrFim - gHrInicio;

  Result := '';
  putitemXml(Result, 'CD_EMPRESA', vCdEmpresa);
  putitemXml(Result, 'NR_TRANSACAO', vNrTransacao);
  putitemXml(Result, 'DT_TRANSACAO', vDtTransacao);
  putitemXml(Result, 'NR_ITEM', vNrItem);
  putitemXml(Result, 'DS_LSTVALORVENDA', vDsLstValorVenda);
  putitemXml(Result, 'DS_MENSAGEM', vDsMensagem);

  gInTransacaoItem := True;

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
  voParams := activateCmp('TRASVCO024', 'gravaParcelaTransacao', viParams);
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
  viParams, voParams, vDsRegistro, vDsLstTransacao : String;
  vCdEmpresa, vNrTransacao : Real;
  vDtTransacao : TDateTime;
begin
  vDsLstTransacao := itemXml('DS_LSTTRANSACAO', pParams);

  if (vDsLstTransacao = '') then begin
    Result := SetStatus(STS_ERROR, 'GEN001', 'Lista de transação não informada!', cDS_METHOD);
    return(-1); exit;
  end;

  clear_e(tTRA_TRANSACAO);

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
      Result := SetStatus(STS_ERROR, 'GEN001', 'Data transação não informada!', cDS_METHOD);
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
      Result := SetStatus(STS_ERROR, 'GEN001', 'Transação ' + FloatToStr(vNrTransacao) + ' não cadastrada!', cDS_METHOD);
      return(-1); exit;
    end;

    viParams := '';
    putitemXml(viParams, 'CD_EMPFAT', itemF('CD_EMPFAT', tTRA_TRANSACAO));
    voParams := calculaTotalTransacao(viParams);
    if (xStatus < 0) then begin
      Result := voParams;
      return(-1); exit;
    end;

    putitem_e(tTRA_TRANSACAO, 'CD_OPERADOR', itemXmlF('CD_USUARIO', PARAM_GLB));
    putitem_e(tTRA_TRANSACAO, 'DT_CADASTRO', Now);

    delitemGld(vDsLstTransacao, 1);
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
      putitem_o(tV_TRA_TOTATRA, 'CD_EMPRESA', itemF('CD_EMPRESA', tTRA_TRANSACAO));
      putitem_o(tV_TRA_TOTATRA, 'NR_TRANSACAO', itemF('NR_TRANSACAO', tTRA_TRANSACAO));
      putitem_o(tV_TRA_TOTATRA, 'DT_TRANSACAO', item('DT_TRANSACAO', tTRA_TRANSACAO));
      retrieve_e(tV_TRA_TOTATRA);
      if (xStatus < 0) then begin
        clear_e(tV_TRA_TOTATRA);
      end;
      if (itemF('QT_TOTALITEM', tV_TRA_TOTATRA) <> itemF('QT_SOLICITADA', tV_TRA_TOTATRA)) then begin
        Result := SetStatus(STS_ERROR, 'GEN001', 'Totalização de valor da transação ' + FloatToStr(vNrTransacao) + ' divergente. Capa: ' + item('QT_SOLICITADA', tV_TRA_TOTATRA) + ' Items: ' + item('QT_TOTALITEM', tV_TRA_TOTATRA) + ' !', cDS_METHOD);
        return(-1); exit;
      end;
      if (itemF('VL_TOTALITEM', tV_TRA_TOTATRA) <> itemF('VL_TRANSACAO', tV_TRA_TOTATRA)) then begin
        Result := SetStatus(STS_ERROR, 'GEN001', 'Totalização de valor da transação ' + FloatToStr(vNrTransacao) + ' divergente. Capa: ' + item('VL_TRANSACAO', tV_TRA_TOTATRA) + ' Items: ' + item('VL_TOTALITEM', tV_TRA_TOTATRA) + ' !', cDS_METHOD);
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
  vDtTransacao : TDateTime;
  vInValidaNF : Boolean;
begin
  vDsLstTransacao := itemXml('DS_LSTTRANSACAO', pParams);
  vTpSituacao := itemXmlF('TP_SITUACAO', pParams);
  vDsMotivoAlt := itemXml('DS_MOTIVOALT', pParams);
  vCdComponente := itemXml('CD_COMPONENTE', pParams);
  vCdMotivoBloq := itemXmlF('CD_MOTIVOBLOQ', pParams);
  vInValidaNF := itemXmlB('IN_VALIDANF', pParams);

  if (vCdComponente = '') then begin
    vCdComponente := 'TRASVCO004';
  end;

  if (vDsLstTransacao = '') then begin
    Result := SetStatus(STS_ERROR, 'GEN001', 'Lista de transação não informada!', cDS_METHOD);
    return(-1); exit;
  end;
  if (vTpSituacao = 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN001', 'Situação não informada!', cDS_METHOD);
    return(-1); exit;
  end;
  if (vTpSituacao < 0) or (vTpSituacao > 10) then begin
    Result := SetStatus(STS_ERROR, 'GEN001', 'Situação ' + FloatToStr(vTpSituacao) + ' inválida!', cDS_METHOD);
    return(-1); exit;
  end;

  clear_e(tTRA_TRANSACAO);

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
      Result := SetStatus(STS_ERROR, 'GEN001', 'Data transação não informada!', cDS_METHOD);
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
      Result := SetStatus(STS_ERROR, 'GEN001', 'Transação ' + FloatToStr(vNrTransacao) + ' não cadastrada!', cDS_METHOD);
      return(-1); exit;
    end;
    if (vTpSituacao = 4) and (vInValidaNF = True) then begin
      viParams := '';
      putitemXml(viParams, 'CD_EMPRESA', itemF('CD_EMPRESA', tTRA_TRANSACAO));
      putitemXml(viParams, 'NR_TRANSACAO', itemF('NR_TRANSACAO', tTRA_TRANSACAO));
      putitemXml(viParams, 'DT_TRANSACAO', item('DT_TRANSACAO', tTRA_TRANSACAO));
      voParams := activateCmp('TRASVCO012', 'validaNFTransacao', viParams);
      if (xStatus < 0) then begin
        Result := voParams;
        return(-1); exit;
      end;
    end;

    vTpSituacaoAnt := itemF('TP_SITUACAO', tTRA_TRANSACAO);

    if (empty(tTRA_TRANSACSIT) = False) then begin
      setocc(tTRA_TRANSACSIT, -1);
      vCdMotivoBloqAnt := itemF('CD_MOTIVOBLOQ', tTRA_TRANSACSIT);
    end;

    putitem_e(tTRA_TRANSACAO, 'TP_SITUACAO', vTpSituacao);
    putitem_e(tTRA_TRANSACAO, 'DT_ULTATEND', itemXmlD('DT_SISTEMA', PARAM_GLB));
    putitem_e(tTRA_TRANSACAO, 'CD_OPERADOR', itemXmlF('CD_USUARIO', PARAM_GLB));
    putitem_e(tTRA_TRANSACAO, 'DT_CADASTRO', Now);

    viParams := '';
    putitemXml(viParams, 'NM_ENTIDADE', 'TRA_TRANSACSITT');
    voParams := activateCmp('GERSVCO031', 'getNumSeq', viParams);
    if (xStatus < 0) then begin
      Result := voParams;
      return(-1); exit;
    end;

    vNrSequencia := itemXmlF('NR_SEQUENCIA', voParams);

    creocc(tTRA_TRANSACSIT, -1);
    putitem_e(tTRA_TRANSACSIT, 'DT_MOVIMENTO', itemXmlD('DT_SISTEMA', PARAM_GLB));
    putitem_e(tTRA_TRANSACSIT, 'NR_SEQUENCIA', vNrSequencia);
    putitem_e(tTRA_TRANSACSIT, 'TP_SITUACAOANT', vTpSituacaoAnt);
    putitem_e(tTRA_TRANSACSIT, 'TP_SITUACAO', vTpSituacao);
    putitem_e(tTRA_TRANSACSIT, 'CD_MOTIVOBLOQ', vCdMotivoBloq);
    putitem_e(tTRA_TRANSACSIT, 'DS_MOTIVOALT', vDsMotivoAlt);
    putitem_e(tTRA_TRANSACSIT, 'CD_OPERADOR', itemXmlF('CD_USUARIO', PARAM_GLB));
    putitem_e(tTRA_TRANSACSIT, 'DT_CADASTRO', Now);
    putitem_e(tTRA_TRANSACSIT, 'CD_COMPONENTE', vCdComponente);

    if (vTpSituacaoAnt = 8) then begin
      if (vCdMotivoBloqAnt = 3) then begin
        viParams := '';
        putitemXml(viParams, 'CD_EMPRESA', itemF('CD_EMPRESA', tTRA_TRANSACAO));
        putitemXml(viParams, 'NR_TRANSACAO', itemF('NR_TRANSACAO', tTRA_TRANSACAO));
        putitemXml(viParams, 'DT_TRANSACAO', item('DT_TRANSACAO', tTRA_TRANSACAO));
        putitemXml(viParams, 'CD_LIBERADOR', itemXmlF('CD_USUARIO', PARAM_GLB));
        putitemXml(viParams, 'TP_LIBERACAO', 1);
        voParams := activateCmp('TRASVCO016', 'gravaLiberacaoTransacao', viParams);
        if (xStatus < 0) then begin
          Result := voParams;
          return(-1); exit;
        end;
      end else if (vCdMotivoBloqAnt = 4) then begin
        viParams := '';
        putitemXml(viParams, 'CD_CLIENTE', itemF('CD_PESSOA', tTRA_TRANSACAO));
        putitemXml(viParams, 'IN_TOTAL', True);
        voParams := activateCmp('FCRSVCO015', 'buscaLimiteCliente', viParams);
        if (xStatus < 0) then begin
          Result := voParams;
          return(-1); exit;
        end;

        vNrDiasAtraso := itemXmlF('NR_DIAVENCTO', voParams);

        if (vNrDiasAtraso > 0) then begin
          viParams := '';
          putitemXml(viParams, 'CD_EMPRESA', itemF('CD_EMPRESA', tTRA_TRANSACAO));
          putitemXml(viParams, 'NR_TRANSACAO', itemF('NR_TRANSACAO', tTRA_TRANSACAO));
          putitemXml(viParams, 'DT_TRANSACAO', item('DT_TRANSACAO', tTRA_TRANSACAO));
          putitemXml(viParams, 'CD_LIBERADOR', itemXmlF('CD_USUARIO', PARAM_GLB));
          putitemXml(viParams, 'TP_LIBERACAO', 2);
          putitemXml(viParams, 'NR_DIAATRASO', vNrDiasAtraso);
          voParams := activateCmp('TRASVCO016', 'gravaLiberacaoTransacao', viParams);
          if (xStatus < 0) then begin
            Result := voParams;
            return(-1); exit;
          end;
        end;
      end;
    end;

    delitemGld(vDsLstTransacao, 1);
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
  vDtTransacao : TDateTime;
  vInEstorno, vInKardex : Boolean;
begin
  vDsLstTransacao := itemXml('DS_LSTTRANSACAO', pParams);
  vInEstorno := itemXmlB('IN_ESTORNO', pParams);

  if (vDsLstTransacao = '') then begin
    Result := SetStatus(STS_ERROR, 'GEN001', 'Lista de transação não informada!', cDS_METHOD);
    return(-1); exit;
  end;

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
      Result := SetStatus(STS_ERROR, 'GEN001', 'Data transação não informada!', cDS_METHOD);
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
    if (empty(tTRA_TRANSITEM) = False) then begin
      setocc(tTRA_TRANSITEM, 1);
      while (xStatus >= 0) do begin
        viParams := '';
        putitemXml(viParams, 'CD_EMPRESA', itemF('CD_EMPRESA', tTRA_TRANSITEM));
        putitemXml(viParams, 'NR_TRANSACAO', itemF('NR_TRANSACAO', tTRA_TRANSITEM));
        putitemXml(viParams, 'DT_TRANSACAO', item('DT_TRANSACAO', tTRA_TRANSITEM));
        putitemXml(viParams, 'NR_ITEM', itemF('NR_ITEM', tTRA_TRANSITEM));
        voParams := activateCmp('GERSVCO058', 'buscaDadosGerOperCfopTra', viParams);
        if (xStatus < 0) then begin
          Result := voParams;
          return(-1); exit;
        end;
        vInKardex := itemXmlB('IN_KARDEX', voParams);

        if (vInKardex = True) then begin
          //viParams := '';
          //putitemXml(viParams, 'CD_EMPRESA', itemF('CD_EMPFAT', tTRA_TRANSACAO));
          //putitemXml(viParams, 'CD_PRODUTO', itemF('CD_PRODUTO', tTRA_TRANSITEM));
          //putitemXml(viParams, 'NR_ITEM', itemF('NR_ITEM', tTRA_TRANSITEM));
          //putitemXml(viParams, 'CD_OPERACAO', itemF('CD_OPERACAO', tTRA_TRANSACAO));
          //putitemXml(viParams, 'IN_ESTORNO', vInEstorno);
          //putitemXml(viParams, 'TP_DCTOORIGEM', 1);
          //putitemXml(viParams, 'NR_DCTOORIGEM', itemF('NR_TRANSACAO', tTRA_TRANSACAO));
          //putitemXml(viParams, 'DT_DCTOORIGEM', item('DT_TRANSACAO', tTRA_TRANSACAO));
          //putitemXml(viParams, 'QT_MOVIMENTO', itemF('QT_SOLICITADA', tTRA_TRANSITEM));
          //putitemXml(viParams, 'VL_UNITLIQUIDO', itemF('VL_UNITLIQUIDO', tTRA_TRANSITEM));
          //putitemXml(viParams, 'VL_UNITSEMIMPOSTO', itemF('VL_UNITLIQUIDO', tTRA_TRANSITEM));
          //voParams := activateCmp('GERSVCO008', 'atualizaSaldoOperacao', viParams);
          //if (xStatus < 0) then begin
          //  Result := voParams;
          //  return(-1); exit;
          //end;
        end;

        setocc(tTRA_TRANSITEM, curocc(tTRA_TRANSITEM) + 1);
      end;
    end;

    delitemGld(vDsLstTransacao, 1);
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
  vDtTransacao : TDateTime;
  vCdRegraFiscal, vCdServico : Real;
  vCdMPTer : String;
begin
  vCdEmpresa := itemXmlF('CD_EMPRESA', pParams);
  vNrTransacao := itemXmlF('NR_TRANSACAO', pParams);
  vDtTransacao := itemXmlD('DT_TRANSACAO', pParams);
  vNrItem := itemXmlF('NR_ITEM', pParams);
  vTpAreaComercio := itemXmlF('TP_AREACOMERCIO', pParams);
  gCdEspecieServico := itemXml('CD_ESPECIE_SERVICO_TRA', PARAM_GLB);
  gTpModDctoFiscal := itemXmlF('TP_MODDCTOFISCAL', pParams);
  vCdRegraFiscal := itemXmlF('CD_REGRAFISCAL', pParams);

  if (itemXmlB('IN_TRANSFERE', pParams) = True) then begin
    vDsUFOrigem := itemXml('UF_ORIGEM', pParams);
    vDsUFDestino := itemXml('UF_DESTINO', pParams);
  end;

  if (vCdEmpresa = 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN001', 'Empresa não informada!', cDS_METHOD);
    return(-1); exit;
  end;
  if (vNrTransacao = 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN001', 'Número transação não informado!', cDS_METHOD);
    return(-1); exit;
  end;
  if (vDtTransacao = 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN001', 'Data transação não informada!', cDS_METHOD);
    return(-1); exit;
  end;
  if (vNrItem = 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN001', 'Item da transação não informado!', cDS_METHOD);
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

  clear_e(tTRA_TRANSITEM);
  putitem_o(tTRA_TRANSITEM, 'NR_ITEM', vNrItem);
  retrieve_e(tTRA_TRANSITEM);
  if (xStatus < 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN001', 'Item ' + FloatToStr(vNrItem) + ' da transação ' + FloatToStr(vNrTransacao) + ' não cadastrada!', cDS_METHOD);
    return(-1); exit;
  end;
  if (empty(tTRA_REMDES) <> False) then begin
    Result := SetStatus(STS_ERROR, 'GEN001', 'Transação ' + FloatToStr(vNrTransacao) + ' não possui endereco cadastrado!', cDS_METHOD);
    return(-1); exit;
  end;
  if (itemF('CD_PESSOA', tTRA_REMDES) = 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN001', 'endereço da transação ' + FloatToStr(vNrTransacao) + ' não possui pessoa cadastrada!', cDS_METHOD);
    return(-1); exit;
  end;

  clear_e(tTRA_ITEMIMPOSTO);
  putitem_o(tTRA_ITEMIMPOSTO, 'CD_EMPRESA', itemF('CD_EMPRESA', tTRA_TRANSITEM)); //--
  putitem_o(tTRA_ITEMIMPOSTO, 'NR_TRANSACAO', itemF('NR_TRANSACAO', tTRA_TRANSITEM)); //--
  putitem_o(tTRA_ITEMIMPOSTO, 'DT_TRANSACAO', itemD('DT_TRANSACAO', tTRA_TRANSITEM)); //--
  putitem_o(tTRA_ITEMIMPOSTO, 'NR_ITEM', itemF('NR_ITEM', tTRA_TRANSITEM)); //--
  retrieve_e(tTRA_ITEMIMPOSTO);
  if (xStatus >= 0) then begin
    voParams := tTRA_ITEMIMPOSTO.Excluir();
    if (xStatus < 0) then begin
      Result := voParams;
      return(-1); exit;
    end;
  end;

  viParams := '';
  if (item('CD_ESPECIE', tTRA_TRANSITEM) = gCdEspecieServico) then begin
    putitemXml(viParams, 'CD_SERVICO', itemF('CD_PRODUTO', tTRA_TRANSITEM));
  end else if (item('TP_MODALIDADE', tGER_OPERACAO) = 'A') then begin
    putitemXml(viParams, 'CD_MPTER', item('CD_BARRAPRD', tTRA_TRANSITEM));//Zottis 26/06/2014 Problema com Zero na Frente do código de Barras (Trocado itemF po item)
  end else begin
    putitemXml(viParams, 'CD_PRODUTO', itemF('CD_PRODUTO', tTRA_TRANSITEM));
  end;
  putitemXml(viParams, 'CD_OPERACAO', itemF('CD_OPERACAO', tGER_OPERACAO));
  if (itemXmlB('IN_TRANSFERE', pParams) = True) then begin
    putitemXml(viParams, 'UF_DESTINO', vDsUFDestino);
    putitemXml(viParams, 'UF_ORIGEM', vDsUFOrigem);
  end else begin
    putitemXml(viParams, 'UF_DESTINO', item('DS_SIGLAESTADO', tTRA_REMDES));
  end;
  putitemXml(viParams, 'CD_PESSOA', itemF('CD_PESSOA', tTRA_REMDES));
  putitemXml(viParams, 'TP_AREACOMERCIO', vTpAreaComercio);
  putitemXml(viParams, 'TP_ORIGEMEMISSAO', itemF('TP_ORIGEMEMISSAO', tTRA_TRANSACAO));
  putitemXml(viParams, 'CD_REGRAFISCAL', vCdRegraFiscal);
  voParams := activateCmp('FISSVCO015', 'buscaCFOP', viParams);
  if (xStatus < 0) then begin
    Result := voParams;
    return(-1); exit;
  end;

  vCdCFOP := itemXmlF('CD_CFOP', voParams);

  if (vCdCFOP > 0) then begin
    putitem_e(tTRA_TRANSITEM, 'CD_CFOP', vCdCFOP);
  end;

  viParams := '';
  if (item('CD_ESPECIE', tTRA_TRANSITEM) = gCdEspecieServico) then begin
    putitemXml(viParams, 'CD_SERVICO', itemF('CD_PRODUTO', tTRA_TRANSITEM));
  end else if (item('TP_MODALIDADE', tGER_OPERACAO) = 'A') then begin
    putitemXml(viParams, 'CD_MPTER', item('CD_BARRAPRD', tTRA_TRANSITEM));//Zottis 26/06/2014 Problema com Zero na Frente do código de Barras (Trocado itemF po item)
  end else begin
    putitemXml(viParams, 'CD_PRODUTO', itemF('CD_PRODUTO', tTRA_TRANSITEM));
  end;
  putitemXml(viParams, 'CD_OPERACAO', itemF('CD_OPERACAO', tGER_OPERACAO));
  putitemXml(viParams, 'UF_DESTINO', item('DS_SIGLAESTADO', tTRA_REMDES));
  putitemXml(viParams, 'CD_PESSOA', itemF('CD_PESSOA', tTRA_REMDES));
  putitemXml(viParams, 'TP_AREACOMERCIO', vTpAreaComercio);
  putitemXml(viParams, 'TP_ORIGEMEMISSAO', itemF('TP_ORIGEMEMISSAO', tTRA_TRANSACAO));
  putitemXml(viParams, 'CD_CFOP', vCdCFOP);
  putitemXml(viParams, 'CD_REGRAFISCAL', vCdRegraFiscal);
  voParams := activateCmp('FISSVCO015', 'buscaCST', viParams);
  if (xStatus < 0) then begin
    Result := voParams;
    return(-1); exit;
  end;

  vCdCST := itemXml('CD_CST', voParams);

  if (vCdCST <> '') then begin
    putitem_e(tTRA_TRANSITEM, 'CD_CST', vCdCST);
  end;

  //-- nova regra fiscal
  if (vCdRegraFiscal = 0) then begin
    if (vCdServico > 0) or (vCdMPTer <> '') then begin
      vCdRegraFiscal := itemF('CD_REGRAFISCAL', tGER_OPERACAO);
    end else begin
      clear_e(tPRD_PRDREGRAFISCAL);
      putitem_o(tPRD_PRDREGRAFISCAL, 'CD_PRODUTO', itemF('CD_PRODUTO', tTRA_TRANSITEM));
      putitem_o(tPRD_PRDREGRAFISCAL, 'CD_OPERACAO', itemF('CD_OPERACAO', tGER_OPERACAO));
      retrieve_e(tPRD_PRDREGRAFISCAL);
      if (xStatus >= 0) then begin
        vCdRegraFiscal := itemF('CD_REGRAFISCAL', tPRD_PRDREGRAFISCAL);
      end else begin
        vCdRegraFiscal := itemF('CD_REGRAFISCAL', tGER_OPERACAO);
      end;
    end;
  end;
  //--

  //-- nova regra fiscal
  if (vCdRegraFiscal > 0) then begin
    clear_e(tFIS_REGRAADIC);
    putitem(tFIS_REGRAADIC, 'CD_REGRAFISCAL', vCdRegraFiscal);
    retrieve_e(tFIS_REGRAADIC);
    if (xStatus < 0) then begin
      clear_e(tFIS_REGRAADIC);
    end;
  end;
  //--

  viParams := '';
  //--
  //putitemXml(viParams, 'CD_EMPRESA', itemF('CD_EMPFAT', tTRA_TRANSACAO));
  //putitemXml(viParams, 'UF_DESTINO', item('DS_SIGLAESTADO', tTRA_REMDES));
  if (item('DS_SIGLAESTADO', tTRA_REMDES) = '') then begin
    putitemXml(viParams, 'UF_DESTINO', item('DS_SIGLAESTADO', tV_PES_ENDERECO));
  end else begin
    putitemXml(viParams, 'UF_DESTINO', item('DS_SIGLAESTADO', tTRA_REMDES));
  end;
  if (item('CD_PESSOA', tTRA_REMDES) = '') then begin
    putitemXml(viParams, 'CD_PESSOA', itemF('CD_PESSOA', tTRA_TRANSACAO));
  end else begin
    putitemXml(viParams, 'CD_PESSOA', itemF('CD_PESSOA', tTRA_REMDES));
  end;
  //--
  putitemXml(viParams, 'TP_ORIGEMEMISSAO', itemF('TP_ORIGEMEMISSAO', tTRA_TRANSACAO));
  if (item('CD_ESPECIE', tTRA_TRANSITEM) = gCdEspecieServico) then begin
    putitemXml(viParams, 'CD_SERVICO', itemF('CD_PRODUTO', tTRA_TRANSITEM));
  end else if (item('TP_MODALIDADE', tGER_OPERACAO) = 'A') then begin
    putitemXml(viParams, 'CD_MPTER', item('CD_BARRAPRD', tTRA_TRANSITEM));//Zottis 26/06/2014 Problema com Zero na Frente do código de Barras (Trocado itemF po item)
  end else begin
    putitemXml(viParams, 'CD_PRODUTO', itemF('CD_PRODUTO', tTRA_TRANSITEM));
  end;
  putitemXml(viParams, 'CD_OPERACAO', itemF('CD_OPERACAO', tGER_OPERACAO));
  putitemXml(viParams, 'CD_PESSOA', itemF('CD_PESSOA', tTRA_REMDES));
  putitemXml(viParams, 'CD_CST', itemF('CD_CST', tTRA_TRANSITEM));
  putitemXml(viParams, 'VL_TOTALBRUTO', itemF('VL_TOTALBRUTO', tTRA_TRANSITEM));
  putitemXml(viParams, 'VL_TOTALLIQUIDO', itemF('VL_TOTALLIQUIDO', tTRA_TRANSITEM));
  putitemXml(viParams, 'PR_IPI', itemXmlF('PR_IPI', pParams));
  putitemXml(viParams, 'VL_IPI', itemXmlF('VL_IPI', pParams));
  putitemXml(viParams, 'TP_AREACOMERCIO', vTpAreaComercio);
  putitemXml(viParams, 'TP_MODDCTOFISCAL', gTpModDctoFiscal);
  putitemXml(viParams, 'DT_INIVIGENCIA', item('DT_TRANSACAO', tTRA_TRANSACAO));
  putitemXml(viParams, 'CD_REGRAFISCAL', vCdRegraFiscal);
  putitemXml(viParams, 'CD_TIPI', item('CD_TIPI', tTRA_TRANSITEM));

  //-- nova regra fiscal
  if (itemB('IN_NOVAREGRA', tFIS_REGRAADIC) = TRUE) then begin
    putitemXml(viParams, 'CD_REGRAFISCAL', vCdRegraFiscal);
    voParams := activateCmp('FISSVCO080', 'buscaRegraRelacionada', viParams);
    if (xStatus < 0) then begin
      Result := voParams; exit;
    end;
    vCdRegraFiscal := itemXmlF('CD_REGRAFISCAL', voParams);

    putitemXml(viParams, 'CD_REGRAFISCAL', vCdRegraFiscal);
    putitemXml(viParams, 'IN_CONTRIBUINTE', itemXmlB('IN_CONTRIBUINTE', voParams));
    voParams := activateCmp('FISSVCO080', 'calculaImpostoItem', viParams);
    if (xStatus < 0) then begin
      Result := voParams; exit;
    end;
    vDsLstImposto := itemXml('DS_LSTIMPOSTO', voParams);
    vCdCST := itemXml('CD_CST', voParams);
    vCdCFOP := itemXmlF('CD_CFOP', voParams);
  end else begin
  //--
    voParams := activateCmp('FISSVCO015', 'calculaImpostoItem', viParams);
    if (xStatus < 0) then begin
      Result := voParams; exit;
    end;
    vDsLstImposto := itemXml('DS_LSTIMPOSTO', voParams);
    vCdCST := itemXml('CD_CST', voParams);
    vCdDecreto := itemXmlF('CD_DECRETO', voParams);
  end;

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

      putitemXml(vDsRegistro, 'CD_EMPRESA', itemF('CD_EMPRESA', tTRA_TRANSITEM)); //--
      putitemXml(vDsRegistro, 'NR_TRANSACAO', itemF('NR_TRANSACAO', tTRA_TRANSITEM)); //--
      putitemXml(vDsRegistro, 'DT_TRANSACAO', itemD('DT_TRANSACAO', tTRA_TRANSITEM)); //--
      putitemXml(vDsRegistro, 'NR_ITEM', itemF('NR_ITEM', tTRA_TRANSITEM)); //--

      clear_e(tTRA_ITEMIMPOSTO);
      creocc(tTRA_ITEMIMPOSTO, -1);
      putitem_o(tTRA_ITEMIMPOSTO, 'CD_EMPRESA', itemF('CD_EMPRESA', tTRA_TRANSITEM)); //--
      putitem_o(tTRA_ITEMIMPOSTO, 'NR_TRANSACAO', itemF('NR_TRANSACAO', tTRA_TRANSITEM)); //--
      putitem_o(tTRA_ITEMIMPOSTO, 'DT_TRANSACAO', itemD('DT_TRANSACAO', tTRA_TRANSITEM)); //--
      putitem_o(tTRA_ITEMIMPOSTO, 'NR_ITEM', itemF('NR_ITEM', tTRA_TRANSITEM)); //--
      putitem_o(tTRA_ITEMIMPOSTO, 'CD_IMPOSTO', itemXml('CD_IMPOSTO', vDsRegistro));
      retrieve_o(tTRA_ITEMIMPOSTO);

      getlistitensocc_e(vDsRegistro, tTRA_ITEMIMPOSTO);

      putitem_e(tTRA_ITEMIMPOSTO, 'CD_EMPFAT', itemF('CD_EMPFAT', tTRA_TRANSACAO));
      putitem_e(tTRA_ITEMIMPOSTO, 'CD_GRUPOEMPRESA', itemF('CD_GRUPOEMPRESA', tTRA_TRANSACAO));
      putitem_e(tTRA_ITEMIMPOSTO, 'CD_OPERADOR', itemXmlF('CD_USUARIO', PARAM_GLB));
      putitem_e(tTRA_ITEMIMPOSTO, 'DT_CADASTRO', Now);

      clear_e(tFIS_REGRAIMPOSTO);
      putitem_o(tFIS_REGRAIMPOSTO, 'CD_IMPOSTO', itemXmlF('CD_IMPOSTO', vDsRegistro));
      putitem_o(tFIS_REGRAIMPOSTO, 'CD_REGRAFISCAL', itemF('CD_REGRAFISCAL', tGER_OPERACAO));
      retrieve_e(tFIS_REGRAIMPOSTO);
      if (xStatus >= 0) then begin
        putitem_e(tTRA_ITEMIMPOSTO, 'CD_CST', itemF('CD_CST', tFIS_REGRAIMPOSTO));
      end;

      voParams := tTRA_ITEMIMPOSTO.Salvar();
      if (xStatus < 0) then begin
        Result := voParams; exit;
      end;

      delitemGld(vDsLstImposto, 1);
    until (vDsLstImposto = '');
  end;

  voParams := tTRA_TRANSITEM.Salvar();
  if (xStatus < 0) then begin
    Result := voParams; exit;
  end;

  if (vCdRegraFiscal > 0) then begin
    Result := '';
    putitemXml(Result, 'CD_CST', vCdCST);
    putitemXml(Result, 'CD_CFOP', vCdCFOP);
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
  vDtTransacao : TDateTime;
begin
  vCdEmpresa := itemXmlF('CD_EMPRESA', pParams);
  vNrTransacao := itemXmlF('NR_TRANSACAO', pParams);
  vDtTransacao := itemXmlD('DT_TRANSACAO', pParams);
  vCdVendedor := itemXmlF('CD_COMPVEND', pParams);

  if (vCdEmpresa = 0) then begin
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
  if (vCdVendedor = 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN001', 'Vendedor não informado!', cDS_METHOD);
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
  putitemXml(viParams, 'CD_EMPTRANSACAO', itemF('CD_EMPRESA', tTRA_TRANSACAO));
  putitemXml(viParams, 'NR_TRANSACAO', itemF('NR_TRANSACAO', tTRA_TRANSACAO));
  putitemXml(viParams, 'DT_TRANSACAO', item('DT_TRANSACAO', tTRA_TRANSACAO));
  putitemXml(viParams, 'CD_COMPVEND', vCdVendedor);
  voParams := activateCmp('FISSVCO004', 'AlteraVendedorNF', viParams);
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
  voParams : String;
  vDtTransacao : TDateTime;
begin
  vCdEmpresa := itemXmlF('CD_EMPRESA', pParams);
  vNrTransacao := itemXmlF('NR_TRANSACAO', pParams);
  vDtTransacao := itemXmlD('DT_TRANSACAO', pParams);
  vCdGuia := itemXmlF('CD_GUIA', pParams);
  vCdRepresentante := itemXmlF('CD_REPRESENTANT', pParams);
  vCdVendedor := itemXmlF('CD_COMPVEND', pParams);
  vTpSituacao := itemXmlF('TP_SITUACAO', pParams);

  if (vCdEmpresa = 0) then begin
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
  if (vTpSituacao = 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN001', 'Situação não informada!', cDS_METHOD);
    return(-1); exit;
  end;
  if (vTpSituacao < 0) or (vTpSituacao > 10) then begin
    Result := SetStatus(STS_ERROR, 'GEN001', 'Situação ' + FloatToStr(vTpSituacao) + ' inválida!', cDS_METHOD);
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

  putitem_e(tTRA_TRANSACAO, 'CD_GUIA', vCdGuia);
  putitem_e(tTRA_TRANSACAO, 'CD_REPRESENTANT', vCdRepresentante);
  if (vCdVendedor <> 0) then begin
    putitem_e(tTRA_TRANSACAO, 'CD_COMPVEND', vCdVendedor);
  end;
  putitem_e(tTRA_TRANSACAO, 'DT_ULTATEND', itemXmlD('DT_SISTEMA', PARAM_GLB));
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
  voParams : String;
  vDtTransacao : TDateTime;
  vInCommitImpTra : Boolean;
begin
  viParams := pParams;
  vDsLstTransacao := itemXml('DS_LSTTRANSACAO', pParams);
  vCdModeloTra := itemXmlF('CD_MODELOTRA', pParams);

  if (vDsLstTransacao = '') then begin
    Result := SetStatus(STS_ERROR, 'GEN001', 'Lista de transação não informada!', cDS_METHOD);
    return(-1); exit;
  end;
  if (vCdModeloTra = 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN001', 'Modelo de transação não informado!', cDS_METHOD);
    return(-1); exit;
  end;

  clear_e(tTRA_TRANSACAO);

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
      Result := SetStatus(STS_ERROR, 'GEN001', 'Data transação não informada!', cDS_METHOD);
      return(-1); exit;
    end;

    creocc(tTRA_TRANSACAO, -1);
    putitem_e(tTRA_TRANSACAO, 'CD_EMPRESA', vCdEmpresa);
    putitem_e(tTRA_TRANSACAO, 'NR_TRANSACAO', vNrTransacao);
    putitem_e(tTRA_TRANSACAO, 'DT_TRANSACAO', vDtTransacao);
    retrieve_o(tTRA_TRANSACAO);
    if (xStatus = -7) then begin
      retrieve_x(tTRA_TRANSACAO);
    end else if (xStatus = 0) then begin
      Result := SetStatus(STS_ERROR, 'GEN001', 'Transação ' + FloatToStr(vNrTransacao) + ' não cadastrada!', cDS_METHOD);
      return(-1); exit;
    end;

    putitem_e(tTRA_TRANSACAO, 'CD_MODELOTRA', vCdModeloTra);
    if (itemF('NR_IMPRESSAO', tTRA_TRANSACAO) = 0) then begin
      putitem_e(tTRA_TRANSACAO, 'NR_IMPRESSAO', 1);
    end else begin
      putitem_e(tTRA_TRANSACAO, 'NR_IMPRESSAO', itemF('NR_IMPRESSAO', tTRA_TRANSACAO) + 1);
    end;
    putitem_e(tTRA_TRANSACAO, 'CD_USUIMPRESSAO', itemXmlF('CD_USUARIO', PARAM_GLB));
    putitem_e(tTRA_TRANSACAO, 'DT_IMPRESSAO', Now);
    putitem_e(tTRA_TRANSACAO, 'CD_OPERADOR', itemXmlF('CD_USUARIO', PARAM_GLB));
    putitem_e(tTRA_TRANSACAO, 'DT_CADASTRO', Now);

    delitemGld(vDsLstTransacao, 1);
  until (vDsLstTransacao = '');

  voParams := tTRA_TRANSACAO.Salvar();
  if (xStatus < 0) then begin
    Result := voParams;
    return(-1); exit;
  end;

  vInCommitImpTra := itemXmlB('IN_COMMIT_IMP_TRA', viParams);
  if (vInCommitImpTra = True) then begin
    commit;
    if (xStatus < 0) then begin
      rollback;
      return(-1); exit;
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
  viParams, voParams, vDsRegistro, vDsLstImposto, vDsUFDestino, vCdCST : String;
  vTpFrete, vCdEmpresa, vNrTransacao, vCdTransport, vNrSeqendereco, vVlFreteTot, vCdTranspConhec : Real;
  vVlFrete, vVlSeguro, vVlDespAcessor, vCdImposto, vVlBaseCalc, vVlImposto, vPrIPI, vVlConhecimento : Real;
  vDtTransacao : TDateTime;
  vInDecreto, vInProduto, vInSubstituicao : Boolean;
begin
  vCdEmpresa := itemXmlF('CD_EMPRESA', pParams);
  vNrTransacao := itemXmlF('NR_TRANSACAO', pParams);
  vDtTransacao := itemXmlD('DT_TRANSACAO', pParams);
  vCdTransport := itemXmlF('CD_TRANSPORT', pParams);
  vVlFrete := itemXmlF('VL_FRETE', pParams);
  vVlSeguro := itemXmlF('VL_SEGURO', pParams);
  vVlDespAcessor := itemXmlF('VL_DESPACESSOR', pParams);
  vTpFrete := itemXmlF('TP_FRETE', pParams);
  vDsLstImposto := itemXml('DS_LSTIMPOSTO', pParams);
  vCdTranspConhec := itemXmlF('CD_TRANSPCONHEC', pParams);
  vVlConhecimento := itemXmlF('VL_CONHECIMENTO', pParams);

  if (vCdTranspConhec <> 0) and (vCdTransport = 0) then begin
    vCdTransport := vCdTranspConhec;
    vTpFrete := 2;
  end;

  if (vCdEmpresa = 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN001', 'Empresa não informada!', cDS_METHOD);
    return(-1); exit;
  end;
  if (vNrTransacao = 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN001', 'Número transação não informado!', cDS_METHOD);
    return(-1); exit;
  end;
  if (vDtTransacao = 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN001', 'Data transação não informada!', cDS_METHOD);
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
  if (empty(tTRA_REMDES) = False) then begin
    vDsUFDestino := item('DS_SIGLAESTADO', tTRA_REMDES);
  end else begin
    clear_e(tV_PES_ENDERECO);
    viParams := '';
    putitemXml(viParams, 'CD_PESSOA', itemF('CD_PESSOA', tTRA_TRANSACAO));
    voParams := activateCmp('PESSVCO005', 'buscaEnderecoFaturamento', viParams);
    if (xStatus >= 0) then begin
      vNrSeqendereco := itemXmlF('NR_SEQENDERECO', voParams);
      putitem_e(tV_PES_ENDERECO, 'CD_PESSOA', itemF('CD_PESSOA', tTRA_TRANSACAO));
      putitem_o(tV_PES_ENDERECO, 'NR_SEQUENCIA', vNrSeqendereco);
      retrieve_e(tV_PES_ENDERECO);
      if (xStatus < 0) then begin
        Result := SetStatus(STS_ERROR, 'GEN001', 'endereço ' + FloatToStr(vNrSeqendereco) + ' não cadastrado para a transportadora ' + FloatToStr(vCdTransport) + '!', cDS_METHOD);
        return(-1); exit;
      end;
    end;
    vDsUFDestino := item('DS_SIGLAESTADO', tV_PES_ENDERECO);
    clear_e(tV_PES_ENDERECO);
  end;

  if (itemF('CD_EMPFAT', tTRA_TRANSACAO) <> itemF('CD_EMPRESA', tTRA_TRANSACAO)) then begin 
    viParams := '';
    putitemXml(viParams, 'CD_EMPRESA', itemF('CD_EMPFAT', tTRA_TRANSACAO));
    getParam(pParams);
  end;

  putitem_e(tTRA_TRANSACAO, 'VL_FRETE', vVlFrete);
  putitem_e(tTRA_TRANSACAO, 'VL_SEGURO', vVlSeguro);
  putitem_e(tTRA_TRANSACAO, 'VL_DESPACESSOR', vVlDespAcessor);

  clear_e(tTRA_TRANSPORT);
  retrieve_e(tTRA_TRANSPORT);
  if (xStatus >= 0) then begin
    if (vCdTransport = 0) then begin
      clear_e(tPED_PEDIDOTRA);
      putitem_o(tPED_PEDIDOTRA, 'CD_EMPTRANSACAO', itemF('CD_EMPRESA', tTRA_TRANSACAO));
      putitem_o(tPED_PEDIDOTRA, 'NR_TRANSACAO', itemF('NR_TRANSACAO', tTRA_TRANSACAO));
      putitem_o(tPED_PEDIDOTRA, 'DT_TRANSACAO', item('DT_TRANSACAO', tTRA_TRANSACAO));
      retrieve_e(tPED_PEDIDOTRA);
      if (xStatus < 0) then begin
        setocc(tTRA_TRANSPORT, 1);
        vCdTransport := itemF('CD_TRANSPORT', tTRA_TRANSPORT);
        vTpFrete := itemF('TP_FRETE', tTRA_TRANSPORT);
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

  clear_e(tTRA_TRAIMPOSTO);
  retrieve_e(tTRA_TRAIMPOSTO);
  if (xStatus >= 0) then begin
    voParams := tTRA_TRAIMPOSTO.Excluir();
    if (xStatus < 0) then begin
      Result := voParams;
      return(-1); exit;
    end;
  end else begin
    clear_e(tTRA_TRAIMPOSTO);
  end;
  if (vCdTransport > 0) then begin
    if (vTpFrete = 0) then begin
      Result := SetStatus(STS_ERROR, 'GEN001', 'Tipo frete não informado!', cDS_METHOD);
      return(-1); exit;
    end;

    clear_e(tV_PES_ENDERECO);

    viParams := '';
    putitemXml(viParams, 'CD_PESSOA', vCdTransport);
    voParams := activateCmp('PESSVCO005', 'buscaenderecoFaturamento', viParams);
    if (xStatus >= 0) then begin
      vNrSeqendereco := itemXmlF('NR_SEQENDERECO', voParams);
      putitem_e(tV_PES_ENDERECO, 'CD_PESSOA', vCdTransport);
      putitem_o(tV_PES_ENDERECO, 'NR_SEQUENCIA', vNrSeqendereco);
      retrieve_e(tV_PES_ENDERECO);
      if (xStatus < 0) then begin
        Result := SetStatus(STS_ERROR, 'GEN001', 'endereço ' + FloatToStr(vNrSeqendereco) + ' não cadastrado para a transportadora ' + FloatToStr(vCdTransport) + '!', cDS_METHOD);
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
    voParams := activateCmp('PESSVCO005', 'buscaDadosPessoa', viParams);
    if (xStatus < 0) then begin
      Result := voParams;
      return(-1); exit;
    end;
    if (itemXml('TP_PESSOA', voParams) = 'F') then begin
      putitem_e(tTRA_TRANSPORT, 'NR_RGINSCREST', itemXml('NR_RG', voParams));
    end else begin
      putitem_e(tTRA_TRANSPORT, 'NR_RGINSCREST', itemXml('NR_INSCESTL', voParams));
    end;
    putitem_e(tTRA_TRANSPORT, 'NR_CPFCNPJ', itemXml('NR_CPFCNPJ', voParams));
    if (item('NM_TRANSPORT', tTRA_TRANSPORT) = '') then begin
      putitem_e(tTRA_TRANSPORT, 'NM_TRANSPORT', itemXml('NM_PESSOA', voParams));
    end;

    setocc(tV_PES_ENDERECO, 1);
    if (dbocc(tV_PES_ENDERECO)) then begin
      putitem_e(tTRA_TRANSPORT, 'NM_LOGRADOURO', item('NM_LOGRADOURO', tV_PES_ENDERECO));
      putitem_e(tTRA_TRANSPORT, 'DS_TPLOGRADOURO', item('DS_SIGLALOGRAD', tV_PES_ENDERECO));
      putitem_e(tTRA_TRANSPORT, 'NR_LOGRADOURO', item('NR_LOGRADOURO', tV_PES_ENDERECO));
      putitem_e(tTRA_TRANSPORT, 'NR_CAIXAPOSTAL', item('NR_CAIXAPOSTAL', tV_PES_ENDERECO));
      putitem_e(tTRA_TRANSPORT, 'NM_BAIRRO', item('DS_BAIRRO', tV_PES_ENDERECO));
      putitem_e(tTRA_TRANSPORT, 'CD_CEP', itemF('CD_CEP', tV_PES_ENDERECO));
      putitem_e(tTRA_TRANSPORT, 'NM_MUNICIPIO', item('NM_MUNICIPIO', tV_PES_ENDERECO));
      putitem_e(tTRA_TRANSPORT, 'DS_SIGLAESTADO', item('DS_SIGLAESTADO', tV_PES_ENDERECO));
    end;
    if (itemF('CD_TRANSREDESPAC', tTRA_TRANSPORT) > 0) and (item('NM_TRANSREDESPAC', tTRA_TRANSPORT) = '') then begin
      viParams := '';
      putitemXml(viParams, 'CD_PESSOA', itemF('CD_TRANSREDESPAC', tTRA_TRANSPORT));
      voParams := activateCmp('PESSVCO005', 'buscaDadosPessoa', viParams);
      if (xStatus < 0) then begin
        Result := voParams;
        return(-1); exit;
      end;
      putitem_e(tTRA_TRANSPORT, 'NM_TRANSREDESPAC', itemXml('NM_PESSOA', voParams));
    end;
    putitem_e(tTRA_TRANSPORT, 'CD_EMPFAT', itemF('CD_EMPFAT', tTRA_TRANSACAO));
    putitem_e(tTRA_TRANSPORT, 'CD_GRUPOEMPRESA', itemF('CD_GRUPOEMPRESA', tTRA_TRANSACAO));
    putitem_e(tTRA_TRANSPORT, 'CD_OPERADOR', itemXmlF('CD_USUARIO', PARAM_GLB));
    putitem_e(tTRA_TRANSPORT, 'DT_CADASTRO', Now);
  end else begin

    if (itemF('TP_DOCTO', tGER_OPERACAO) = 1) then begin
      if (vTpFrete <> 0) then begin
        Result := SetStatus(STS_ERROR, 'GEN001', 'Transportadora não informada!', cDS_METHOD);
        return(-1); exit;
      end;
      creocc(tTRA_TRANSPORT, -1);
      delitem(pParams, 'CD_EMPRESA');
      delitem(pParams, 'NR_TRANSACAO');
      delitem(pParams, 'DT_TRANSACAO');
      getlistitensocc_e(pParams, tTRA_TRANSPORT);
      putitem_e(tTRA_TRANSPORT, 'CD_EMPFAT', itemF('CD_EMPFAT', tTRA_TRANSACAO));
      putitem_e(tTRA_TRANSPORT, 'CD_GRUPOEMPRESA', itemF('CD_GRUPOEMPRESA', tTRA_TRANSACAO));
      putitem_e(tTRA_TRANSPORT, 'CD_OPERADOR', itemXmlF('CD_USUARIO', PARAM_GLB));
      putitem_e(tTRA_TRANSPORT, 'DT_CADASTRO', Now);
    end;
  end;
  if (vDsLstImposto = '') then begin
    viParams := '';
    putitemXml(viParams, 'CD_EMPRESA', itemF('CD_EMPFAT', tTRA_TRANSACAO));
    putitemXml(viParams, 'UF_DESTINO', vDsUFDestino);
    putitemXml(viParams, 'TP_ORIGEMEMISSAO', itemF('TP_ORIGEMEMISSAO', tTRA_TRANSACAO));
    putitemXml(viParams, 'CD_OPERACAO', itemF('CD_OPERACAO', tGER_OPERACAO));
    putitemXml(viParams, 'CD_PESSOA', itemF('CD_PESSOA', tTRA_TRANSACAO));
    putitemXml(viParams, 'VL_FRETE', itemF('VL_FRETE', tTRA_TRANSACAO));
    putitemXml(viParams, 'VL_SEGURO', itemF('VL_SEGURO', tTRA_TRANSACAO));
    putitemXml(viParams, 'VL_DESPACESSOR', itemF('VL_DESPACESSOR', tTRA_TRANSACAO));

    clear_e(tF_TRA_ITEMIMPOSTO);
    putitem_o(tF_TRA_ITEMIMPOSTO, 'CD_EMPRESA', itemF('CD_EMPRESA', tTRA_TRANSACAO));
    putitem_o(tF_TRA_ITEMIMPOSTO, 'NR_TRANSACAO', itemF('NR_TRANSACAO', tTRA_TRANSACAO));
    putitem_o(tF_TRA_ITEMIMPOSTO, 'DT_TRANSACAO', item('DT_TRANSACAO', tTRA_TRANSACAO));
    putitem_o(tF_TRA_ITEMIMPOSTO, 'CD_IMPOSTO', 3);
    retrieve_e(tF_TRA_ITEMIMPOSTO);
    if (xStatus >= 0) then begin
      vVlBaseCalc := 0;
      vVlImposto := 0;

      setocc(tF_TRA_ITEMIMPOSTO, 1);
      while (xStatus >= 0) do begin
        if (itemF('VL_IMPOSTO', tF_TRA_ITEMIMPOSTO) > 0) then begin
          vVlBaseCalc := vVlBaseCalc + itemF('VL_BASECALC', tF_TRA_ITEMIMPOSTO);
          vVlImposto := vVlImposto + itemF('VL_IMPOSTO', tF_TRA_ITEMIMPOSTO);
        end;
        setocc(tF_TRA_ITEMIMPOSTO, curocc(tF_TRA_ITEMIMPOSTO) + 1);
      end;

      vPrIPI := (vVlImposto / vVlBaseCalc) * 100;
      vPrIPI := rounded(vPrIPI, 2);

      putitemXml(viParams, 'PR_IPI', vPrIPI);
      putitemXml(viParams, 'IN_IPI', True);
    end else begin
      putitemXml(viParams, 'IN_IPI', False);
    end;

    if not (empty(tTRA_TRANSITEM)) then begin
      tTRA_TRANSITEM.IndexFieldNames := 'CD_DECRETO';

      vInDecreto := False;
      vInProduto := False;
      vInSubstituicao := False;

      setocc(tTRA_TRANSITEM, 1);
      while (xStatus >= 0) do begin
        if (itemF('CD_DECRETO', tTRA_TRANSITEM) <> 0) and (vInDecreto = False) then begin
          putitemXml(viParams, 'CD_DECRETO', itemF('CD_DECRETO', tTRA_TRANSITEM));
          putitemXml(viParams, 'CD_CST', itemF('CD_CST', tTRA_TRANSITEM));
          putitemXml(viParams, 'CD_PRODUTO', itemF('CD_PRODUTO', tTRA_TRANSITEM));
          vInDecreto := True;
          break;
        end;

        vCdCST := Copy(item('CD_CST', tTRA_TRANSITEM),2,2);
        if ((vCdCST = '10') or (vCdCST = '30') or (vCdCST = '60') or (vCdCST = '70')) and (vInSubstituicao = False) then begin
          putitemXml(viParams, 'CD_CST', itemF('CD_CST', tTRA_TRANSITEM));
          putitemXml(viParams, 'CD_PRODUTO', itemF('CD_PRODUTO', tTRA_TRANSITEM));
          vInSubstituicao := True;
          break;
        end;
        if (item('CD_ESPECIE', tTRA_TRANSITEM) <> gCdEspecieServico) and (vInProduto = False) then begin
          putitemXml(viParams, 'CD_PRODUTO', itemF('CD_PRODUTO', tTRA_TRANSITEM));
          vInProduto := True;
        end;

        setocc(tTRA_TRANSITEM, curocc(tTRA_TRANSITEM) + 1);
      end;
      if (vInDecreto = False) and (vInSubstituicao = False) then begin
        setocc(tTRA_TRANSITEM, 1);
        putitemXml(viParams, 'CD_CST', itemF('CD_CST', tTRA_TRANSITEM));
      end;
    end;

    voParams := activateCmp('FISSVCO015', 'calculaImpostoCapa', viParams);
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

        creocc(tTRA_TRAIMPOSTO, -1);
        getlistitensocc_e(vDsRegistro, tTRA_TRAIMPOSTO);
        putitem_e(tTRA_TRAIMPOSTO, 'CD_EMPFAT', itemF('CD_EMPFAT', tTRA_TRANSACAO));
        putitem_e(tTRA_TRAIMPOSTO, 'CD_GRUPOEMPRESA', itemF('CD_GRUPOEMPRESA', tTRA_TRANSACAO));
        putitem_e(tTRA_TRAIMPOSTO, 'CD_OPERADOR', itemXmlF('CD_USUARIO', PARAM_GLB));
        putitem_e(tTRA_TRAIMPOSTO, 'DT_CADASTRO', Now);
      end;

      delitemGld(vDsLstImposto, 1);
    until (vDsLstImposto = '');
  end;

  viParams := '';
  voParams := calculaTotalTransacao(viParams);
  if (xStatus < 0) then begin
    Result := voParams;
    return(-1); exit;
  end;

  putitem_e(tTRA_TRANSACAO, 'CD_OPERADOR', itemXmlF('CD_USUARIO', PARAM_GLB));
  putitem_e(tTRA_TRANSACAO, 'DT_CADASTRO', Now);

  if (vCdTranspConhec <> 0) then begin
    putitem_e(tTRA_TRANSPORT, 'CD_TRANSPCONHEC', vCdTranspConhec);
    putitem_e(tTRA_TRANSPORT, 'VL_CONHECIMENTO', vVlConhecimento);
  end;
  if (item('CD_EMPFAT', tTRA_TRANSPORT) = '') and (itemF('CD_TRANSPORT', tTRA_TRANSPORT) > 0) then begin
    putitem_e(tTRA_TRANSPORT, 'CD_EMPFAT', itemF('CD_EMPFAT', tTRA_TRANSACAO));
    putitem_e(tTRA_TRANSPORT, 'CD_GRUPOEMPRESA', itemF('CD_GRUPOEMPRESA', tTRA_TRANSACAO));
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
  vDsTransacao, vDsTransItem,
  viParams, voParams, vDsRegistro, vDsLstValor, vDsLstVl, vTpValor : String;
  vCdEmpresa, vCdCusto, vNrTransacao, vNrItem, vPrDescPadrao, vPrDescCabPadrao : Real;
  vVlPadrao, vPrImposto, vVlImposto, vVlOriginal, vVlCalc, vTpAtualizacaoPadrao, vTpAtualizacao : Real;
  vVlCustoValorRetido, vVlSubstTributaria : Real;
  vInPadrao, vInNaoExclui : Boolean;
  vDtTransacao : TDateTime;
  vPos : Integer;
begin
  vCdEmpresa := itemXmlF('CD_EMPRESA', pParams);
  vNrTransacao := itemXmlF('NR_TRANSACAO', pParams);
  vDtTransacao := itemXmlD('DT_TRANSACAO', pParams);
  vNrItem := itemXmlF('NR_ITEM', pParams);
  vDsLstValor := itemXml('DS_LSTVALOR', pParams);
  vInNaoExclui := itemXmlB('IN_NAOEXCLUI', pParams);

  if (vCdEmpresa = 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN001', 'Empresa não informada!', cDS_METHOD);
    return(-1); exit;
  end;
  if (vNrTransacao = 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN001', 'Número transação não informado!', cDS_METHOD);
    return(-1); exit;
  end;
  if (vDtTransacao = 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN001', 'Data transação não informada!', cDS_METHOD);
    return(-1); exit;
  end;
  if (vNrItem = 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN001', 'Item da transação não informado!', cDS_METHOD);
    return(-1); exit;
  end;

  vDsTransacao := itemXml('DS_TRANSACAO', pParams);

  clear_e(tTRA_TRANSACAO);
  if (vDsTransacao <> '') then begin
    getlistitensoccXml(vDsTransacao, tTRA_TRANSACAO);
  end else begin
    putitem_o(tTRA_TRANSACAO, 'CD_EMPRESA', vCdEmpresa);
    putitem_o(tTRA_TRANSACAO, 'NR_TRANSACAO', vNrTransacao);
    putitem_o(tTRA_TRANSACAO, 'DT_TRANSACAO', vDtTransacao);
    retrieve_e(tTRA_TRANSACAO);
    if (xStatus < 0) then begin
      Result := SetStatus(STS_ERROR, 'GEN001', 'Transação ' + FloatToStr(vNrTransacao) + ' não cadastrada!', cDS_METHOD);
      return(-1); exit;
    end;
  end;

  if (itemF('CD_EMPFAT', tTRA_TRANSACAO) <> itemF('CD_EMPRESA', tTRA_TRANSACAO)) then begin
    viParams := '';
    putitemXml(viParams, 'CD_EMPRESA', itemF('CD_EMPFAT', tTRA_TRANSACAO));
    getParam(pParams);
  end;

  vDsTransItem := itemXml('DS_TRANSITEM', pParams);

  clear_e(tTRA_TRANSITEM);
  if (vDsTransItem <> '') then begin
    getlistitensoccXml(vDsTransItem, tTRA_TRANSITEM);
  end else begin
    putitem_o(tTRA_TRANSITEM, 'NR_ITEM', vNrItem);
    retrieve_e(tTRA_TRANSITEM);
    if (xStatus < 0) then begin
      Result := SetStatus(STS_ERROR, 'GEN001', 'Item ' + FloatToStr(vNrItem) + ' da transação ' + FloatToStr(vNrTransacao) + ' não cadastrada!', cDS_METHOD);
      return(-1); exit;
    end;
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

      vTpValor := itemXml('TP_VALOR', vDsRegistro);
      vCdCusto := itemXmlF('CD_VALOR', vDsRegistro);
      vInPadrao := itemXmlB('IN_PADRAO', vDsRegistro);

      if (vTpValor = 'C') and (vCdCusto = gCdCustoMedio) and (item('TP_OPERACAO', tGER_OPERACAO) = 'E') and (itemF('TP_MODALIDADE', tGER_OPERACAO) = 4) then begin
        if (vInPadrao = True) then begin
          Result := SetStatus(STS_ERROR, 'GEN001', 'Custo padrão médio (CD_CUSTO_MEDIO_CMP) ' + FloatToStr(vCdCusto) + ' não pode ser o custo padrão!', cDS_METHOD);
          return(-1); exit;
        end;
      end else begin
        creocc(tTRA_ITEMVL, -1);
        getlistitensocc_e(vDsRegistro, tTRA_ITEMVL);
        putitem_e(tTRA_ITEMVL, 'CD_EMPFAT', itemF('CD_EMPFAT', tTRA_TRANSITEM));
        putitem_e(tTRA_ITEMVL, 'CD_GRUPOEMPRESA', itemF('CD_GRUPOEMPRESA', tTRA_TRANSITEM));
        putitem_e(tTRA_ITEMVL, 'CD_OPERADOR', itemXmlF('CD_USUARIO', PARAM_GLB));
        putitem_e(tTRA_ITEMVL, 'DT_CADASTRO', Now);

        if (item_b('IN_PADRAO', tTRA_ITEMVL) = True) then begin
          vVlPadrao := itemF('VL_UNITARIO', tTRA_ITEMVL);
          vPrDescPadrao := itemF('PR_DESCONTO', tTRA_ITEMVL);
          vPrDescCabPadrao := itemF('PR_DESCONTOCAB', tTRA_ITEMVL);
          vTpAtualizacaoPadrao := itemF('TP_ATUALIZACAO', tTRA_ITEMVL);
        end;
      end;

      delitemGld(vDsLstValor, 1);
    until (vDsLstValor = '');

    if (item('TP_OPERACAO', tGER_OPERACAO) = 'E') and ((itemF('TP_MODALIDADE', tGER_OPERACAO) = 4) or (itemF('TP_MODALIDADE', tGER_OPERACAO) = 2)) then begin
      if (vVlPadrao = 0) then begin
        Result := SetStatus(STS_ERROR, 'GEN001', 'Nenhum valor padrão encontrado na lista de valores!', cDS_METHOD);
        return(-1); exit;
      end;
    end;

    if (item('TP_OPERACAO', tGER_OPERACAO) = 'E') and (itemF('TP_MODALIDADE', tGER_OPERACAO) = 4) then begin
      if (gCdCustoMedio > 0) then begin
        viParams := '';
        putitemXml(viParams, 'CD_EMPRESA', itemF('CD_EMPFAT', tTRA_TRANSITEM));
        putitemXml(viParams, 'CD_PRODUTO', itemF('CD_PRODUTO', tTRA_TRANSITEM));
        putitemXml(viParams, 'TP_VALOR', 'C');
        putitemXml(viParams, 'CD_VALOR', gCdCustoMedio);
        voParams := activateCmp('PRDSVCO007', 'buscaValorData', viParams);
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
        putitem_e(tTRA_ITEMVL, 'CD_EMPFAT', itemF('CD_EMPFAT', tTRA_TRANSITEM));
        putitem_e(tTRA_ITEMVL, 'CD_GRUPOEMPRESA', itemF('CD_GRUPOEMPRESA', tTRA_TRANSITEM));
        putitem_e(tTRA_ITEMVL, 'CD_OPERADOR', itemXmlF('CD_USUARIO', PARAM_GLB));
        putitem_e(tTRA_ITEMVL, 'DT_CADASTRO', Now);
      end;

      if (gDsCustoSubstTributaria <> '') then begin
        clear_e(tF_TRA_ITEMIMPOSTO);
        putitem_o(tF_TRA_ITEMIMPOSTO, 'CD_EMPRESA', itemF('CD_EMPRESA', tTRA_TRANSITEM));
        putitem_o(tF_TRA_ITEMIMPOSTO, 'NR_TRANSACAO', itemF('NR_TRANSACAO', tTRA_TRANSITEM));
        putitem_o(tF_TRA_ITEMIMPOSTO, 'DT_TRANSACAO', item('DT_TRANSACAO', tTRA_TRANSITEM));
        putitem_o(tF_TRA_ITEMIMPOSTO, 'NR_ITEM', itemF('NR_ITEM', tTRA_TRANSITEM));
        putitem_o(tF_TRA_ITEMIMPOSTO, 'CD_IMPOSTO', 2);
        retrieve_e(tF_TRA_ITEMIMPOSTO);
        if (xStatus >= 0) then begin
          vVlSubstTributaria := itemF('VL_BASECALC', tF_TRA_ITEMIMPOSTO) / itemF('QT_SOLICITADA', tTRA_TRANSITEM);
          vVlSubstTributaria := rounded(vVlSubstTributaria, 2);

          vPos := Pos(';', gDsCustoSubstTributaria);
          vCdCusto := IffNuloF(Copy(gDsCustoSubstTributaria, 1, vPos-1), 0);
          vTpAtualizacao := IffNuloF(Copy(gDsCustoSubstTributaria, vPos + 1, Length(gDsCustoSubstTributaria)), 0);

          viParams := '';
          putitemXml(viParams, 'CD_EMPRESA', itemF('CD_EMPFAT', tTRA_TRANSITEM));
          putitemXml(viParams, 'CD_PRODUTO', itemF('CD_PRODUTO', tTRA_TRANSITEM));
          putitemXml(viParams, 'TP_VALOR', 'C');
          putitemXml(viParams, 'CD_VALOR', vCdCusto);
          voParams := activateCmp('PRDSVCO007', 'buscaValorData', viParams);
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
          putitem_e(tTRA_ITEMVL, 'CD_EMPFAT', itemF('CD_EMPFAT', tTRA_TRANSITEM));
          putitem_e(tTRA_ITEMVL, 'CD_GRUPOEMPRESA', itemF('CD_GRUPOEMPRESA', tTRA_TRANSITEM));
          putitem_e(tTRA_ITEMVL, 'CD_OPERADOR', itemXmlF('CD_USUARIO', PARAM_GLB));
          putitem_e(tTRA_ITEMVL, 'DT_CADASTRO', Now);
        end;
      end;

      if (gDsCustoValorRetido <> '') then begin
        clear_e(tF_TRA_ITEMIMPOSTO);
        putitem_o(tF_TRA_ITEMIMPOSTO, 'CD_EMPRESA', itemF('CD_EMPRESA', tTRA_TRANSITEM));
        putitem_o(tF_TRA_ITEMIMPOSTO, 'NR_TRANSACAO', itemF('NR_TRANSACAO', tTRA_TRANSITEM));
        putitem_o(tF_TRA_ITEMIMPOSTO, 'DT_TRANSACAO', item('DT_TRANSACAO', tTRA_TRANSITEM));
        putitem_o(tF_TRA_ITEMIMPOSTO, 'NR_ITEM', itemF('NR_ITEM', tTRA_TRANSITEM));
        putitem_o(tF_TRA_ITEMIMPOSTO, 'CD_IMPOSTO', 2);
        retrieve_e(tF_TRA_ITEMIMPOSTO);
        if (xStatus >= 0) then begin
          vVlCustoValorRetido := itemF('VL_IMPOSTO', tF_TRA_ITEMIMPOSTO) / itemF('QT_SOLICITADA', tTRA_TRANSITEM);
          vVlCustoValorRetido := rounded(vVlCustoValorRetido, 2);

          vPos := Pos(';', gDsCustoValorRetido);
          vCdCusto := IffNuloF(Copy(gDsCustoValorRetido, 1, vPos-1), 0);
          vTpAtualizacao := IffNuloF(Copy(gDsCustoValorRetido, vPos + 1, Length(gDsCustoValorRetido)), 0);

          viParams := '';
          putitemXml(viParams, 'CD_EMPRESA', itemF('CD_EMPFAT', tTRA_TRANSITEM));
          putitemXml(viParams, 'CD_PRODUTO', itemF('CD_PRODUTO', tTRA_TRANSITEM));
          putitemXml(viParams, 'TP_VALOR', 'C');
          putitemXml(viParams, 'CD_VALOR', vCdCusto);
          voParams := activateCmp('PRDSVCO007', 'buscaValorData', viParams);
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
          putitem_e(tTRA_ITEMVL, 'CD_EMPFAT', itemF('CD_EMPFAT', tTRA_TRANSITEM));
          putitem_e(tTRA_ITEMVL, 'CD_GRUPOEMPRESA', itemF('CD_GRUPOEMPRESA', tTRA_TRANSITEM));
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
  vCdEmpresa, vNrTransacao, vNrItem, {vTpContrInspSaldoLote,} vCdOperSaldo : Real;
  vDtTransacao : TDateTime;
  vInTotal, vInSemMovimento : Boolean;
begin
  vCdEmpresa := itemXmlF('CD_EMPRESA', pParams);
  vNrTransacao := itemXmlF('NR_TRANSACAO', pParams);
  vDtTransacao := itemXmlD('DT_TRANSACAO', pParams);
  vNrItem := itemXmlF('NR_ITEM', pParams);
  vInTotal := itemXmlB('IN_TOTAL', pParams);
  vInSemMovimento := itemXmlB('IN_SEMMOVIMENTO', pParams);

  //vTpContrInspSaldoLote := itemXmlF('TP_CONTR_INSP_SALDO_LOTE', PARAM_GLB);

  if (vCdEmpresa = 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN001', 'Empresa não informada!', cDS_METHOD);
    return(-1); exit;
  end;
  if (vNrTransacao = 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN001', 'Número transação não informado!', cDS_METHOD);
    return(-1); exit;
  end;
  if (vDtTransacao = 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN001', 'Data transação não informada!', cDS_METHOD);
    return(-1); exit;
  end;
  if (vInTotal = True) then begin
    vNrItem := 0;
  end else begin
    if (vNrItem = 0) then begin
      Result := SetStatus(STS_ERROR, 'GEN001', 'Item da transação não informado!', cDS_METHOD);
      return(-1); exit;
    end;
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
  if (itemF('TP_SITUACAO', tTRA_TRANSACAO) <> 1) and (itemF('TP_SITUACAO', tTRA_TRANSACAO) <> 2) then begin
    Result := SetStatus(STS_ERROR, 'GEN001', 'Transação ' + FloatToStr(vNrTransacao) + ' não esta em andamento!', cDS_METHOD);
    return(-1); exit;
  end;

  if (itemF('CD_EMPFAT', tTRA_TRANSACAO) <> itemF('CD_EMPRESA', tTRA_TRANSACAO)) then begin 
    viParams := '';
    putitemXml(viParams, 'CD_EMPRESA', itemF('CD_EMPFAT', tTRA_TRANSACAO));
    getParam(pParams);
  end;

  if (vNrItem < 0) then begin
    setocc(tTRA_TRANSITEM, -1);
    vNrItem := itemF('NR_ITEM', tTRA_TRANSITEM);
  end;

  //-- MFGALEGO - 09/12/2014 ; erro exclusao imposto
  (* clear_e(tGER_OPERSALDOPRD);
  putitem_o(tGER_OPERSALDOPRD, 'CD_OPERACAO', itemF('CD_OPERACAO', tTRA_TRANSACAO));
  putitem_o(tGER_OPERSALDOPRD, 'IN_PADRAO', True);
  retrieve_e(tGER_OPERSALDOPRD);
  if (xStatus >= 0) then begin
    vCdOperSaldo := itemF('CD_SALDO', tGER_OPERSALDOPRD);
  end; *)
  //--

  clear_e(tTRA_TRANSITEM);
  putitem_o(tTRA_TRANSITEM, 'NR_ITEM', vNrItem);
  retrieve_e(tTRA_TRANSITEM);
  if (xStatus >= 0) then begin
    //-- MFGALEGO - 09/12/2014 ; erro exclusao imposto
    (* if (vTpContrInspSaldoLote <> 1) then begin
      if not (empty(tTRA_ITEMLOTE)) and (vInSemMovimento <> True) and (item_b('IN_KARDEX', tGER_OPERACAO)) and (item('TP_OPERACAO', tTRA_TRANSACAO) = 'S') then begin
        setocc(tTRA_ITEMLOTE, 1);
        while (xStatus >= 0) do begin

          clear_e(tPRD_LOTEI);
          putitem_o(tPRD_LOTEI, 'CD_EMPRESA', itemF('CD_EMPLOTE', tTRA_ITEMLOTE));
          putitem_o(tPRD_LOTEI, 'NR_LOTE', itemF('NR_LOTE', tTRA_ITEMLOTE));
          putitem_o(tPRD_LOTEI, 'NR_ITEM', itemF('NR_ITEMLOTE', tTRA_ITEMLOTE));
          retrieve_e(tPRD_LOTEI);
          if (xStatus >= 0) then begin
            if (vCdOperSaldo <> 0) and (vCdOperSaldo <> itemF('CD_SALDO', tPRD_LOTEI)) then begin
              Result := SetStatus(STS_ERROR, 'GEN001', 'Saldo ' + item('CD_SALDO', tPRD_LOTEI) + ' do item de lote ' + item('CD_EMPRESA', tPRD_LOTEI) + ' / ' + item('NR_LOTE', tPRD_LOTEI) + ' / ' + item('NR_ITEM', tPRD_LOTEI) + ' diferente do saldo ' + FloatToStr(vCdOperSaldo) + ' que é padrão da operação ' + item('CD_OPERACAO', tTRA_TRANSACAO) + '!', cDS_METHOD);
              return(-1); exit;
            end;
          end;

          viParams := '';
          putitemXml(viParams, 'CD_EMPRESA', itemF('CD_EMPLOTE', tTRA_ITEMLOTE));
          putitemXml(viParams, 'NR_LOTE', itemF('NR_LOTE', tTRA_ITEMLOTE));
          putitemXml(viParams, 'NR_ITEM', itemF('NR_ITEMLOTE', tTRA_ITEMLOTE));
          putitemXml(viParams, 'QT_MOVIMENTO', itemF('QT_LOTE', tTRA_ITEMLOTE));
          putitemXml(viParams, 'TP_MOVIMENTO', 'B');
          putitemXml(viParams, 'IN_ESTORNO', True);
          if (itemF('TP_MODALIDADE', tGER_OPERACAO) = 3) then begin
            putitemXml(viParams, 'IN_VALIDASITUACAO', False);
          end;
          voParams := activateCmp('PRDSVCO020', 'movimentaQtLoteI', viParams);
          if (xStatus < 0) then begin
            Result := voParams;
            return(-1); exit;
          end;
          setocc(tTRA_ITEMLOTE, curocc(tTRA_ITEMLOTE) + 1);
        end;
      end;
    end; *)
    //--

    //-- MFGALEGO - 09/12/2014 ; erro exclusao imposto
    (* viParams := '';
    putitemXml(viParams, 'CD_EMPRESA', itemF('CD_EMPRESA', tTRA_TRANSITEM));
    putitemXml(viParams, 'DT_TRANSACAO', item('DT_TRANSACAO', tTRA_TRANSITEM));
    putitemXml(viParams, 'NR_TRANSACAO', itemF('NR_TRANSACAO', tTRA_TRANSITEM));
    putitemXml(viParams, 'NR_ITEM', itemF('NR_ITEM', tTRA_TRANSITEM));
    voParams := activateCmp('TRASVCO016', 'removeSerialTransacao', viParams);
    if (xStatus < 0) then begin
      Result := voParams;
      return(-1); exit;
    end; *)
    //--

    //-- MFGALEGO - 09/12/2014 ; erro exclusao imposto
    viParams := '';
    putitemXml(viParams, 'CD_EMPRESA', itemF('CD_EMPRESA', tTRA_TRANSITEM));
    putitemXml(viParams, 'DT_TRANSACAO', item('DT_TRANSACAO', tTRA_TRANSITEM));
    putitemXml(viParams, 'NR_TRANSACAO', itemF('NR_TRANSACAO', tTRA_TRANSITEM));
    putitemXml(viParams, 'NR_ITEM', itemF('NR_ITEM', tTRA_TRANSITEM));
    voParams := gModulo.ExcluirXmlUp('TRA_ITEMIMPOSTO', 'CD_EMPRESA|DT_TRANSACAO|NR_TRANSACAO|NR_ITEM|', viParams);
    if (xStatus < 0) then begin
      Result := voParams;
      return(-1); exit;
    end;
    //--

    voParams := tTRA_TRANSITEM.Excluir();
    if (xStatus < 0) then begin
      Result := voParams;
      return(-1); exit;
    end;

    viParams := '';
    voParams := calculaTotalTransacao(viParams);
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
function T_TRASVCO004.gravaEnderecoTransacao(pParams : String) : String;
//----------------------------------------------------------------------
const
  cDS_METHOD = 'ADICIONAL=Operação: T_TRASVCO004.gravaEnderecoTransacao()';
var
  vInSobrepor, vInPjIsento, vInContribuinte, inCFPesJuridica, vInAltEnderecoCli : Boolean;
  voParams, vDsNome, vTpPessoa, vUfOrigem : String;
  vCdEmpresa, vNrTransacao : Real;
  vDtTransacao : TDateTime;
begin
  vCdEmpresa := itemXmlF('CD_EMPRESA', pParams);
  vNrTransacao := itemXmlF('NR_TRANSACAO', pParams);
  vDtTransacao := itemXmlD('DT_TRANSACAO', pParams);
  vDsNome := itemXml('NM_NOME', pParams);
  vTpPessoa := itemXml('TP_PESSOA', pParams);
  vInSobrepor := itemXmlB('IN_SOBREPOR', pParams);
  inCFPesJuridica := itemXmlB('IN_CF_PESJURIDICA', pParams);
  vInAltEnderecoCli := itemXmlB('IN_ALT_ENDERECO_CLI', pParams);

  if (vCdEmpresa = 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN001', 'Empresa não informada!', cDS_METHOD);
    return(-1); exit;
  end;
  if (vNrTransacao = 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN001', 'Número transação não informado!', cDS_METHOD);
    return(-1); exit;
  end;
  if (vDtTransacao = 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN001', 'Data transação não informada!', cDS_METHOD);
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

  clear_e(tTRA_REMDES);
  retrieve_e(tTRA_REMDES);
  if (xStatus >= 0) then begin
    if (vInSobrepor = True) or (vDsNome <> '') then begin
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
  if ((itemF('TP_DOCTO', tGER_OPERACAO) = 2) or (itemF('TP_DOCTO', tGER_OPERACAO) = 3)) and (inCFPesJuridica = True) and (item('TP_PESSOA', tPES_PESSOA) = 'J') then begin
    if (gCdClientePdv <> 0) then begin
      clear_e(tPES_PESSOA);
      putitem_o(tPES_PESSOA, 'CD_PESSOA', gCdClientePdv);
      retrieve_e(tPES_PESSOA);
    end;
  end;

  creocc(tTRA_REMDES, -1);
  if (vDsNome = '') then begin
    clear_e(tV_PES_ENDERECO);
    putitem_o(tV_PES_ENDERECO, 'CD_PESSOA', itemF('CD_PESSOA', tPES_PESSOA));
    putitem_o(tV_PES_ENDERECO, 'NR_SEQUENCIA', itemF('NR_SEQENDERECO', tTRA_TRANSACAO));
    retrieve_e(tV_PES_ENDERECO);
    if (xStatus < 0) then begin
      if ((itemF('TP_DOCTO', tGER_OPERACAO) = 2) or (itemF('TP_DOCTO', tGER_OPERACAO) = 3)) and ((itemF('TP_MODALIDADE', tGER_OPERACAO) = 4) or (itemF('TP_MODALIDADE', tGER_OPERACAO) = 8) or (itemF('TP_MODALIDADE', tGER_OPERACAO) = 3)) then begin
        if (gCdPessoaEndPadrao <> 0) then begin
          clear_e(tV_PES_ENDERECO);
          putitem_o(tV_PES_ENDERECO, 'CD_PESSOA', gCdPessoaEndPadrao);
          putitem_o(tV_PES_ENDERECO, 'NR_SEQUENCIA', itemF('NR_SEQENDERECO', tTRA_TRANSACAO));
          retrieve_e(tV_PES_ENDERECO);
          if (xStatus < 0) then begin
            Result := SetStatus(STS_ERROR, 'GEN001', 'endereço ' + item('NR_SEQENDERECO', tTRA_TRANSACAO) + ' não cadastrado para a pessoa ' + FloatToStr(gCdPessoaEndPadrao) + '!', cDS_METHOD);
            return(-1); exit;
          end;
        end else begin
          Result := SetStatus(STS_ERROR, 'GEN001', 'endereço ' + item('NR_SEQENDERECO', tTRA_TRANSACAO) + ' não cadastrado para a pessoa ' + item('CD_PESSOA', tPES_PESSOA) + '!', cDS_METHOD);
          return(-1); exit;
        end;
      end else begin
        Result := SetStatus(STS_ERROR, 'GEN001', 'endereço ' + item('NR_SEQENDERECO', tTRA_TRANSACAO) + ' não cadastrado para a pessoa ' + item('CD_PESSOA', tPES_PESSOA) + '!', cDS_METHOD);
        return(-1); exit;
      end;

    end else begin

      if (itemF('TP_DOCTO', tGER_OPERACAO) = 2) or (itemF('TP_DOCTO', tGER_OPERACAO) = 3) and (itemF('TP_MODALIDADE', tGER_OPERACAO) = 4) or (itemF('TP_MODALIDADE', tGER_OPERACAO) = 8) or (itemF('TP_MODALIDADE', tGER_OPERACAO) = 3) and (item('TP_OPERACAO', tGER_OPERACAO) = 'E') and (vInAltEnderecoCli = True) then begin
        vUfOrigem := itemXml('UF_ORIGEM', PARAM_GLB);
        if (vUfOrigem <> item('DS_SIGLAESTADO', tV_PES_ENDERECO)) then begin
          if (gCdPessoaEndPadrao <> 0) then begin
            clear_e(tV_PES_ENDERECO);
            putitem_o(tV_PES_ENDERECO, 'CD_PESSOA', gCdPessoaEndPadrao);
            putitem_o(tV_PES_ENDERECO, 'NR_SEQUENCIA', itemF('NR_SEQENDERECO', tTRA_TRANSACAO));
            retrieve_e(tV_PES_ENDERECO);
            if (xStatus < 0) then begin
              Result := SetStatus(STS_ERROR, 'GEN001', 'endereço ' + item('NR_SEQENDERECO', tTRA_TRANSACAO) + ' não cadastrado para a pessoa ' + FloatToStr(gCdPessoaEndPadrao) + '!', cDS_METHOD);
              return(-1); exit;
            end;
          end else begin
            Result := SetStatus(STS_ERROR, 'GEN001', 'endereço ' + item('NR_SEQENDERECO', tTRA_TRANSACAO) + ' não cadastrado para a pessoa ' + item('CD_PESSOA', tPES_PESSOA) + '!', cDS_METHOD);
            return(-1); exit;
          end;
        end;
      end;
    end;

    vUfOrigem := itemXml('UF_ORIGEM', PARAM_GLB);

    vInPjIsento := False;
    if (item('NR_INSCESTL', tPES_PESJURIDICA) = 'ISENTO') or (item('NR_INSCESTL', tPES_PESJURIDICA) = 'ISENTA')
    or (item('NR_INSCESTL', tPES_PESJURIDICA) = 'ISENTOS') or (item('NR_INSCESTL', tPES_PESJURIDICA) = 'ISENTAS') then begin
      vInPjIsento := True;
    end;
    if (item_b('IN_CNSRFINAL', tPES_CLIENTE) = True) or (item('TP_PESSOA', tPES_PESSOA) = 'F') or (vInPjIsento = True) then begin
      if (item('TP_PESSOA', tPES_PESSOA) = 'F') and (item('NR_CODIGOFISCAL', tPES_CLIENTE) <> '') and ((vUfOrigem = 'PR') or (vUfOrigem = 'SP')) then begin
        vInContribuinte := True;
      end else begin
        vInContribuinte := False;
      end;
    end else begin
      vInContribuinte := True;
    end;
    if (inCFPesJuridica = False) then begin
      if (itemF('TP_DOCTO', tGER_OPERACAO) = 2) or (itemF('TP_DOCTO', tGER_OPERACAO) = 3) then begin
        if (vInContribuinte = True) and (item_b('IN_CNSRFINAL', tPES_CLIENTE) <> True) then begin
          Result := SetStatus(STS_ERROR, 'GEN001', 'Emissão de cupom fiscal para contribuinte não é permitido. Favor emitir Nota Fiscal!', cDS_METHOD);
          return(-1); exit;
        end;
      end;
    end;

    putitem_e(tTRA_REMDES, 'NM_NOME', item('NM_PESSOA', tPES_PESSOA));
    putitem_e(tTRA_REMDES, 'TP_PESSOA', item('TP_PESSOA', tPES_PESSOA));
    putitem_e(tTRA_REMDES, 'CD_PESSOA', itemF('CD_PESSOA', tPES_PESSOA));
    putitem_e(tTRA_REMDES, 'IN_CONTRIBUINTE', vInContribuinte);
    putitem_e(tTRA_REMDES, 'NR_LOGRADOURO', item('NR_LOGRADOURO', tV_PES_ENDERECO));
    putitem_e(tTRA_REMDES, 'NR_CAIXAPOSTAL', item('NR_CAIXAPOSTAL', tV_PES_ENDERECO));
    putitem_e(tTRA_REMDES, 'CD_CEP', itemF('CD_CEP', tV_PES_ENDERECO));
    putitem_e(tTRA_REMDES, 'DS_SIGLAESTADO', item('DS_SIGLAESTADO', tV_PES_ENDERECO));
    putitem_e(tTRA_REMDES, 'DS_TPLOGRADOURO', item('DS_SIGLALOGRAD', tV_PES_ENDERECO));
    if (item('TP_PESSOA', tPES_PESSOA) = 'F') then begin
      if (item('NR_CODIGOFISCAL', tPES_CLIENTE) = '') then begin
        putitem_e(tTRA_REMDES, 'NR_RGINSCREST', item('NR_RG', tPES_PESFISICA));
      end else begin
        putitem_e(tTRA_REMDES, 'NR_RGINSCREST', item('NR_CODIGOFISCAL', tPES_CLIENTE));
      end;
    end else begin
      putitem_e(tTRA_REMDES, 'NR_RGINSCREST', item('NR_INSCESTL', tPES_PESJURIDICA));
    end;
    putitem_e(tTRA_REMDES, 'NR_CPFCNPJ', item('NR_CPFCNPJ', tPES_PESSOA));
    clear_e(tPES_TELEFONE);
    putitem_o(tPES_TELEFONE, 'IN_PADRAO', True);
    retrieve_e(tPES_TELEFONE);
    if (xStatus >= 0) then begin
      putitem_e(tTRA_REMDES, 'NR_TELEFONE', item('NR_TELEFONE', tPES_TELEFONE));
    end else begin
      clear_e(tPES_TELEFONE);
      retrieve_e(tPES_TELEFONE);
      if (xStatus >= 0) then begin
        putitem_e(tTRA_REMDES, 'NR_TELEFONE', item('NR_TELEFONE', tPES_TELEFONE));
      end;
    end;
    putitem_e(tTRA_REMDES, 'NM_BAIRRO', item('DS_BAIRRO', tV_PES_ENDERECO));
    putitem_e(tTRA_REMDES, 'NM_LOGRADOURO', item('NM_LOGRADOURO', tV_PES_ENDERECO));
    putitem_e(tTRA_REMDES, 'NM_COMPLEMENTO', Copy(item('DS_COMPLEMENTO', tV_PES_ENDERECO),1,60));
    putitem_e(tTRA_REMDES, 'NM_MUNICIPIO', item('NM_MUNICIPIO', tV_PES_ENDERECO));
    if (itemF('CD_PESSOA', tTRA_REMDES) = 0) then begin
      putitem_e(tTRA_REMDES, 'CD_PESSOA', itemF('CD_PESSOA', tPES_PESSOA));
    end;
  end else begin
    if (vTpPessoa = '') then begin
      Result := SetStatus(STS_ERROR, 'GEN001', 'Tipo de pessoa não informado!', cDS_METHOD);
      return(-1); exit;
    end;
    delitem(pParams, 'CD_EMPRESA');
    delitem(pParams, 'NR_TRANSACAO');
    delitem(pParams, 'DT_TRANSACAO');
    getlistitensocc_e(pParams, tTRA_REMDES);
  end;

  putitem_e(tTRA_REMDES, 'CD_EMPFAT', itemF('CD_EMPFAT', tTRA_TRANSACAO));
  putitem_e(tTRA_REMDES, 'CD_GRUPOEMPRESA', itemF('CD_GRUPOEMPRESA', tTRA_TRANSACAO));
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
  voParams, vDsObservacao, vCdComponente : String;
  vCdEmpresa, vNrTransacao, vNrLinha : Real;
  vInManutencao : Boolean;
  vDtTransacao : TDateTime;
begin
  vCdEmpresa := itemXmlF('CD_EMPRESA', pParams);
  vNrTransacao := itemXmlF('NR_TRANSACAO', pParams);
  vDtTransacao := itemXmlD('DT_TRANSACAO', pParams);
  vInManutencao := itemXmlB('IN_MANUTENCAO', pParams);
  vCdComponente := itemXml('CD_COMPONENTE', pParams);
  vDsObservacao := itemXml('DS_OBSERVACAO', pParams);

  if (vCdEmpresa = 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN001', 'Empresa não informada!', cDS_METHOD);
    return(-1); exit;
  end;
  if (vNrTransacao = 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN001', 'Número transação não informado!', cDS_METHOD);
    return(-1); exit;
  end;
  if (vDtTransacao = 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN001', 'Data transação não informada!', cDS_METHOD);
    return(-1); exit;
  end;
  if (vCdComponente = '') then begin
    Result := SetStatus(STS_ERROR, 'GEN001', 'Nome do componente não informado!', cDS_METHOD);
    return(-1); exit;
  end;
  if (vDsObservacao = '') then begin
    Result := SetStatus(STS_ERROR, 'GEN001', 'Observação não informada!', cDS_METHOD);
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

  if (empty(tOBS_TRANSACAO) = False) then begin
    tOBS_TRANSACAO.IndexFieldNames := 'NR_LINHA';
    setocc(tOBS_TRANSACAO, -1);
    vNrLinha := itemF('NR_LINHA', tOBS_TRANSACAO);
  end;
  vNrLinha := vNrLinha + 1;

  clear_e(tOBS_TRANSACAO);
  putitem_e(tOBS_TRANSACAO, 'NR_LINHA', vNrLinha);
  putitem_e(tOBS_TRANSACAO, 'IN_MANUTENCAO', vInManutencao);
  putitem_e(tOBS_TRANSACAO, 'CD_COMPONENTE', vCdComponente);
  putitem_e(tOBS_TRANSACAO, 'DS_OBSERVACAO', Copy(vDsObservacao,1,80));
  putitem_e(tOBS_TRANSACAO, 'CD_OPERADOR', gModulo.GCDUSUARIO);
  putitem_e(tOBS_TRANSACAO, 'DT_CADASTRO', Now);
  voParams := tOBS_TRANSACAO.Salvar();
  if (xStatus < 0) then begin
    Result := voParams;
    return(-1); exit;
  end;

  return(0); exit;
end;

initialization
  RegisterClass(T_TRASVCO004);

end.
