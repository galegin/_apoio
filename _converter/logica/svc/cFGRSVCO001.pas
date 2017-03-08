unit cFGRSVCO001;

interface

(* COMPONENTES 
  ADMSVCO001 / FCCSVCO002 / FCCSVCO007 / FCPFL020 / FCPSVCO001
  FCPSVCO003 / FCPSVCO004 / FCPSVCO005 / FCPSVCO051 / FGRSVCO001
  GERSVCO031 / SICSVCO002 / SICSVCO004 / 
*)        

uses
  Classes, SysUtils, Math, DB,
  cServiceUnf, cDataSetUnf;

type
  T_FGRSVCO001 = class(TcServiceUnf)
  private
    tF_FCC_AUTOCHE,
    tF_FCC_AUTOPAG,
    tF_FCC_AUTORIZ,
    tF_FCC_CTAPES,
    tF_FCP_DUPLI,
    tFCC_AUTOCHEQ,
    tFCC_AUTOPAG,
    tFCC_AUTORIZAC,
    tFCC_CTAPES,
    tFCC_MOV,
    tFCP_DUPDESPES,
    tFCP_DUPIMPOST,
    tFCP_DUPLICATI,
    tFCP_DUPLICATISVCSALVAR;,
    tFCR_FATURAI,
    tFCR_FATURAISVCSALVAR;,
    tFGR_EMPENVSER,
    tFGR_LIQ,
    tFGR_LIQITEMCC,
    tFGR_LIQITEMCP,
    tFGR_LIQITEMCR,
    tGER_EMPRESA,
    tGER_POOLGRUPO,
    tPES_PESSOA : TcDatasetUnf;
    function getParam(pParams : String = '') : String;
    function setEntidade(pParams : String = '') : String;
  protected
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;    
  published
    function geraLiquidacao(pParams : String = '') : String;
    function gravaLiquidacao(pParams : String = '') : String;
    function gravaLiqCartao(pParams : String = '') : String;
    function calculaDespImp(pParams : String = '') : String;
    function geraSeqParcela(pParams : String = '') : String;
    function gravaDuplicata(pParams : String = '') : String;
    function cancelaLiquidacao(pParams : String = '') : String;
    function cancelaAutorizacaoDup(pParams : String = '') : String;
    function autorizacaoDeCheque(pParams : String = '') : String;
    function instancehandle->SetStatus(STS_ERROR, xProcerror, xProcerrorcontext, 'ADICIONAL= chamada -> atualizaLiq()')(pParams : String = '') : String;
    function instancehandle->SetStatus(STS_ERROR, xCdErro, xCtxErro, 'ADICIONAL= chamada -> atualizaLiq()')(pParams : String = '') : String;
    function atualizaLiq(pParams : String = '') : String;
    function instancehandle->SetStatus(STS_ERROR, 'GEN0001', 'DESCRICAO=Liquidação não encontrada!', 'ADICIONAL= -> atualizaDuplicataFatura')(pParams : String = '') : String;
    function instancehandle->SetStatus(STS_ERROR, 'GEN0001', 'DESCRICAO=Itens da liquidação não encontrada!', 'ADICIONAL= -> atualizaLiquidacao()')(pParams : String = '') : String;
    function atualizaLiqCC(pParams : String = '') : String;
    function atualizaAdiantSobras(pParams : String = '') : String;
    function pagamentoEmDinheiro(pParams : String = '') : String;
    function instancehandle->SetStatus(STS_ERROR, xProcerror, xProcerrorcontext, 'ADICIONAL= chamada -> atualizaAli()')(pParams : String = '') : String;
    function instancehandle->SetStatus(STS_ERROR, xCdErro, xCtxErro, 'ADICIONAL= chamada -> atualizaAli()')(pParams : String = '') : String;
    function instancehandle->SetStatus(STS_ERROR, xProcerror, xProcerrorcontext, 'ADICIONAL= FGRSVCO001 atualizaDifDuplicataendossoTeste chamando -> atualizaLiqCC')(pParams : String = '') : String;
    function instancehandle->SetStatus(STS_ERROR, xCdErro, xCtxErro, 'ADICIONAL= FGRSVCO001 atualizaDifDuplicataendossoTeste chamando -> atualizaLiqCC')(pParams : String = '') : String;
    function atualizaFaturasCheques(pParams : String = '') : String;
    function atualizaDuplicataendosso(pParams : String = '') : String;
    function instancehandle->SetStatus(STS_ERROR, xProcerror, xProcerrorcontext, 'ADICIONAL= FGRSVCO001 atualizaDifDuplicataendossoTeste chamando -> atualizaLiq')(pParams : String = '') : String;
    function instancehandle->SetStatus(STS_ERROR, xCdErro, xCtxErro, 'ADICIONAL= FGRSVCO001 atualizaDifDuplicataendossoTeste chamando -> atualizaLiq')(pParams : String = '') : String;
    function instancehandle->SetStatus(STS_ERROR, xProcerror, xProcerrorcontext, 'ADICIONAL= FGRSVCO001 -> atualizaDifDuplicataendossoTeste chamando -> baixaParcialDuplicata')(pParams : String = '') : String;
    function instancehandle->SetStatus(STS_ERROR, xProcerror, xProcerrorcontext, 'ADICIONAL= FGRSVCO001 -> atualizaDifDuplicataendossoTeste chamando FCCSVCO002->movimentaConta()')(pParams : String = '') : String;
    function instancehandle->SetStatus(STS_ERROR, xCdErro, xCtxErro, 'ADICIONAL= FGRSVCO001 -> atualizaDifDuplicataendossoTeste chamando FCCSVCO002->movimentaConta(')(pParams : String = '') : String;
    function baixaDuplicataParcial(pParams : String = '') : String;
    function atualizaLiqPagAut(pParams : String = '') : String;
    function validarEmpresa(pParams : String = '') : String;
    function listarEmpresa(pParams : String = '') : String;
    function listarEmpresaEnvSerasa(pParams : String = '') : String;
    function buscaDespesa(pParams : String = '') : String;
    function validarParcial(pParams : String = '') : String;
    function validarEmpEnvioSerasa(pParams : String = '') : String;
  end;

implementation

uses
  cADMSVCO001,
  cActivate, cStatus, cFuncao, cXml, dModulo;

var
  gCdctapescxfilial,
  gCdDespesaItemJuros : String;

//---------------------------------------------------------------
constructor T_FGRSVCO001.Create(AOwner: TComponent);
//---------------------------------------------------------------
begin
  inherited Create(AOwner);
  setEntidade('');
end;

//--------------------------------
destructor T_FGRSVCO001.Destroy;
//--------------------------------
begin
  inherited Destroy;
end;

//---------------------------------------------------------------
function T_FGRSVCO001.getParam(pParams : String = '') : String;
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

  xParam := T_ADMSVCO001.GetParametro(xParam);


  xParamEmp := '';
  putitem(xParamEmp, 'CD_DESPESAITEM_JUROS');

  xParamEmp := T_ADMSVCO001.GetParamEmpresa(piCdEmpresa, xParamEmp);

  gCdDespesaItemJuros := itemXml('CD_DESPESAITEM_JUROS', xParamEmp);

end;

//---------------------------------------------------------------
function T_FGRSVCO001.setEntidade(pParams : String = '') : String;
//---------------------------------------------------------------
begin
  tF_FCC_AUTOCHE := GetEntidade('F_FCC_AUTOCHE');
  tF_FCC_AUTOPAG := GetEntidade('F_FCC_AUTOPAG');
  tF_FCC_AUTORIZ := GetEntidade('F_FCC_AUTORIZ');
  tF_FCC_CTAPES := GetEntidade('F_FCC_CTAPES');
  tF_FCP_DUPLI := GetEntidade('F_FCP_DUPLI');
  tFCC_AUTOCHEQ := GetEntidade('FCC_AUTOCHEQ');
  tFCC_AUTOPAG := GetEntidade('FCC_AUTOPAG');
  tFCC_AUTORIZAC := GetEntidade('FCC_AUTORIZAC');
  tFCC_CTAPES := GetEntidade('FCC_CTAPES');
  tFCC_MOV := GetEntidade('FCC_MOV');
  tFCP_DUPDESPES := GetEntidade('FCP_DUPDESPES');
  tFCP_DUPIMPOST := GetEntidade('FCP_DUPIMPOST');
  tFCP_DUPLICATI := GetEntidade('FCP_DUPLICATI');
  tFCP_DUPLICATISVCSALVAR; := GetEntidade('FCP_DUPLICATISVCSALVAR;');
  tFCR_FATURAI := GetEntidade('FCR_FATURAI');
  tFCR_FATURAISVCSALVAR; := GetEntidade('FCR_FATURAISVCSALVAR;');
  tFGR_EMPENVSER := GetEntidade('FGR_EMPENVSER');
  tFGR_LIQ := GetEntidade('FGR_LIQ');
  tFGR_LIQITEMCC := GetEntidade('FGR_LIQITEMCC');
  tFGR_LIQITEMCP := GetEntidade('FGR_LIQITEMCP');
  tFGR_LIQITEMCR := GetEntidade('FGR_LIQITEMCR');
  tGER_EMPRESA := GetEntidade('GER_EMPRESA');
  tGER_POOLGRUPO := GetEntidade('GER_POOLGRUPO');
  tPES_PESSOA := GetEntidade('PES_PESSOA');
end;

//--------------------------------------------------------------
function T_FGRSVCO001.geraLiquidacao(pParams : String) : String;
//--------------------------------------------------------------
const
  cDS_METHOD = 'ADICONAL=Operação: T_FGRSVCO001.geraLiquidacao()';
var
  vDtMovim, vDtLiq : TDate;
  viParams, voParams, vDsRegDesp, vDsRegImp, vDupOriginal, vDsDespesa, vDsImposto, vVlMultaCalc : String;
  vNrCtapes, vNrSeqMov, vNrSeqLiq, vCdEmpresa, vVlDuplicata, vVlCheque, vNrSeqItem, vVlMulta : Real;
  vTpLiquidacao, vNrParcela, vVlDif, vVlJuros, vDupEmpresa, vDupFornecedor, vDupDuplicata, vDupParcela : Real;
  vVlDesconto, vVlDesctoTot, vVlJurosTot, vVlJurosCalc, vVlDesctoCalc, vPercentual, vVlTotalDup : Real;
begin
  vDtLiq := itemXml('DT_LIQ', pParams);
  if (itemXml('DT_LIQ', pParams) = '') then begin
    vDtLiq := itemXml('DT_SISTEMA', PARAM_GLB);
  end;

  vNrCtaPes := itemXmlF('NR_CTAPES', pParams);
  if (itemXml('NR_CTAPES', pParams) = '') then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Número da conta corrente não informado para gerar liquidação.', cDS_METHOD);
    return(-1); exit;
  end;

  vDtMovim := itemXml('DT_MOVIM', pParams);
  if (itemXml('DT_MOVIM', pParams) = '') then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Data do movimento não informado para gerar liquidação.', cDS_METHOD);
    return(-1); exit;
  end;

  vNrSeqMov := itemXmlF('NR_SEQMOV', pParams);
  if (itemXml('NR_SEQMOV', pParams) = '') then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Número de sequência do movimento não informado para gerar liquidação.', cDS_METHOD);
    return(-1); exit;
  end;

  vTpLiquidacao := itemXmlF('TP_LIQUIDACAO', pParams);
  if (itemXml('TP_LIQUIDACAO', pParams) = '') then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Tipo de liquidação não informado para gerar liquidação.', cDS_METHOD);
    return(-1); exit;
  end;

  clear_e(tF_FCC_CTAPES);
  putitem_e(tF_FCC_CTAPES, 'NR_CTAPES', vNrCtaPes);
  retrieve_e(tF_FCC_CTAPES);
  if (xStatus >=0) then begin
    vCdEmpresa := item_f('CD_EMPRESA', tF_FCC_CTAPES);
  end else begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Conta corrente inválida para gerar liquidação de conciliação de cheque.', cDS_METHOD);
    return(-1); exit;
  end;
  if (vCdEmpresa = '') then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Empresa não informada para gerar liquidação.', cDS_METHOD);
    return(-1); exit;
  end;

  clear_e(tGER_EMPRESA);
  putitem_e(tGER_EMPRESA, 'CD_EMPRESA', vCdEmpresa);
  retrieve_e(tGER_EMPRESA);
  if (xStatus < 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Empresa para gerar liquidação não cadastrada.', cDS_METHOD);
    return(-1); exit;
  end;

  vNrSeqItem := 1;
  vVlCheque := 0;

  clear_e(tFCC_MOV);
  putitem_e(tFCC_MOV, 'NR_CTAPES', vNrCtaPes);
  putitem_e(tFCC_MOV, 'DT_MOVIM', vDtMovim);
  putitem_e(tFCC_MOV, 'NR_SEQMOV', vNrSeqMov);
  retrieve_e(tFCC_MOV);
  if (xStatus < 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Movimentação de conta corrente não encontrada para gerar liquidação.', cDS_METHOD);
    return(-1); exit;
  end;

  clear_e(tFCC_AUTOCHEQ);
  putitem_e(tFCC_AUTOCHEQ, 'NR_CTAPES', vNrCtaPes);
  putitem_e(tFCC_AUTOCHEQ, 'DT_MOVIM', vDtMovim);
  putitem_e(tFCC_AUTOCHEQ, 'NR_SEQMOV', vNrSeqMov);
  retrieve_e(tFCC_AUTOCHEQ);
  if (xStatus < 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Movimento de conta corrente não encontrado na autorização de cheque para gerar liquidação.', cDS_METHOD);
    return(-1); exit;
  end else begin
    vVlCheque := item_f('VL_CHEQUE', tFCC_AUTOCHEQ);
  end;

  clear_e(tFCC_AUTORIZAC);
  putitem_e(tFCC_AUTORIZAC, 'DT_AUTORIZACAO', item_a('DT_AUTORIZACAO', tFCC_AUTOCHEQ));
  putitem_e(tFCC_AUTORIZAC, 'NR_SEQAUTO', item_f('NR_SEQAUTO', tFCC_AUTOCHEQ));
  retrieve_e(tFCC_AUTORIZAC);
  if (xStatus < 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Autorização de cheque não encontrada para gerar liquidação.', cDS_METHOD);
    return(-1); exit;
  end;

  getParams(pParams); (* vCdEmpresa *)
  if (xStatus < 0) then begin
    Result := voParams;
    return(-1); exit;
  end;

  viParams := '';
  putitemXml(viParams, 'NM_ENTIDADE', 'FGR_LIQ');
  newinstance 'GERSVCO031', 'GERSVCO031', 'TRANSACTION=TRUE';
  voParams := activateCmp('GERSVCO031', 'getNumSeq', viParams); (*,viParams,voParams,, *)
  if (xStatus < 0) then begin
    Result := voParams;
    return(-1); exit;
  end;
  vNrSeqLiq := itemXmlF('NR_SEQUENCIA', voParams);

  if (itemXml('NR_SEQUENCIA', voParams) = '') then begin
    Result := SetStatus(STS_ERROR, 'GEN001', 'Sequência de liquidação não gerada para autorização de cheque., '');
    return(-1); exit;
  end;

  clear_e(tFCC_AUTOPAG);
  putitem_e(tFCC_AUTOPAG, 'DT_AUTORIZACAO', item_a('DT_AUTORIZACAO', tFCC_AUTOCHEQ));
  putitem_e(tFCC_AUTOPAG, 'NR_SEQAUTO', item_f('NR_SEQAUTO', tFCC_AUTOCHEQ));
  if (item_f('TP_RATEIO', tFCC_AUTORIZAC) = 1)  or (item_f('TP_RATEIO', tFCC_AUTORIZAC) = 2) then begin
    putitem_e(tFCC_AUTOPAG, 'NR_SEQCHEQUE', item_f('NR_SEQCHEQUE', tFCC_AUTOCHEQ));
  end;
  retrieve_e(tFCC_AUTOPAG);
  if (xStatus < 0) then begin
    clear_e(tFCC_AUTOPAG);
  end;
  if (item_f('NR_DUPLICATA', tFCC_AUTOPAG) = 0)  and (item_f('NR_CTAPES', tFCC_AUTOPAG) <> 0) then begin
    viParams := '';
    putitemXml(viParams, 'CD_EMPRESA', vCdEmpresa);
    putitemXml(viParams, 'NR_SEQLIQ', vNrSeqLiq);
    putitemXml(viParams, 'NR_SEQITEM', vNrSeqItem);
    putitemXml(viParams, 'NR_CTAPES', item_f('NR_CTAPES', tFCC_AUTORIZAC));
    putitemXml(viParams, 'TP_LIQUIDACAO', vTpLiquidacao);
    putitemXml(viParams, 'VL_PAGAMENTO', item_f('VL_CHEQUE', tFCC_AUTOCHEQ));
    putitemXml(viParams, 'VL_TOTAL', item_f('VL_CHEQUE', tFCC_AUTOCHEQ));

    if (item_f('CD_FORNECEDOR', tFCC_AUTOPAG) > 0) then begin
      putitemXml(viParams, 'CD_FORNECEDOR', item_f('CD_FORNECEDOR', tFCC_AUTOPAG));
    end else begin

      putitemXml(viParams, 'CD_FORNECEDOR', item_f('CD_PESSOA', tFCC_CTAPES));
    end;
    putitemXml(viParams, 'TP_PAGAMENTO', 4);
    putitemXml(viParams, 'DT_LIQ', vDtLiq);
    voParams := gravaLiquidacao(viParams); (* PARAM_GLB, viParams, voParams, xCdErro, xCtxErro *)
    if (xStatus < 0) then begin
      Result := voParams;
      return(-1); exit;
    end;

    putitem_e(tFCC_MOV, 'CD_EMPLIQ', vCdEmpresa);
    putitem_e(tFCC_MOV, 'DT_LIQ', vDtLiq);
    putitem_e(tFCC_MOV, 'NR_SEQLIQ', vNrSeqLiq);

    voParams := tFCC_MOV.Salvar();
    if (xStatus < 0) then begin
      Result := voParams;
      return(-1); exit;
    end;

    putitem_e(tFCC_AUTOCHEQ, 'CD_EMPLIQ', vCdEmpresa);
    putitem_e(tFCC_AUTOCHEQ, 'DT_LIQ', vDtLiq);
    putitem_e(tFCC_AUTOCHEQ, 'NR_SEQLIQ', vNrSeqLiq);
    voParams := tFCC_AUTOCHEQ.Salvar();
    if (xStatus < 0) then begin
      Result := voParams;
      return(-1); exit;
    end;
  end;
  if (item_f('NR_DUPLICATA', tFCC_AUTOPAG) <> 0)  and (item_f('NR_CTAPES', tFCC_AUTOPAG) = 0) then begin
    setocc(tFCC_AUTOPAG, 1);
    while (xStatus >= 0) do begin

      clear_e(tFCP_DUPLICATI);
      putitem_e(tFCP_DUPLICATI, 'CD_EMPRESA', item_f('CD_EMPRESA', tFCC_AUTOPAG));
      putitem_e(tFCP_DUPLICATI, 'CD_FORNECEDOR', item_f('CD_FORNECEDOR', tFCC_AUTOPAG));
      putitem_e(tFCP_DUPLICATI, 'NR_DUPLICATA', item_f('NR_DUPLICATA', tFCC_AUTOPAG));
      putitem_e(tFCP_DUPLICATI, 'NR_PARCELA', item_f('NR_PARCELA', tFCC_AUTOPAG));
      retrieve_e(tFCP_DUPLICATI);
      if (xStatus < 0) then begin
        Result := SetStatus(STS_ERROR, 'GEN0001', 'Duplicata vinculada ao cheque não encontrada.Empresa: ' + cd_empresa + '.FCC_AUTOPAG Fornecedor: ' + cd_fornecedor + '.FCC_AUTOPAG Duplicata: ' + nr_duplicata + '.FCC_AUTOPAG Parcela: ' + nr_parcela + '.FCC_AUTOPAG', cDS_METHOD);
        return(-1); exit;
      end;

      clear_e(tFCP_DUPDESPES);
      putitem_e(tFCP_DUPDESPES, 'CD_EMPRESA', item_f('CD_EMPRESA', tFCP_DUPLICATI));
      putitem_e(tFCP_DUPDESPES, 'CD_FORNECEDOR', item_f('CD_FORNECEDOR', tFCP_DUPLICATI));
      putitem_e(tFCP_DUPDESPES, 'NR_DUPLICATA', item_f('NR_DUPLICATA', tFCP_DUPLICATI));
      putitem_e(tFCP_DUPDESPES, 'NR_PARCELA', item_f('NR_PARCELA', tFCP_DUPLICATI));
      retrieve_e(tFCP_DUPDESPES);
      if (xStatus < 0) then begin
        Result := SetStatus(STS_ERROR, 'GEN0001', 'Duplicata vinculada ao cheque sem despesa.Empresa: ' + cd_empresa + '.FCC_AUTOPAG Fornecedor: ' + cd_fornecedor + '.FCC_AUTOPAG Duplicata: ' + nr_duplicata + '.FCC_AUTOPAG Parcela: ' + nr_parcela + '.FCC_AUTOPAG', cDS_METHOD);
        return(-1); exit;
      end;
      clear_e(tFCP_DUPIMPOST);
      putitem_e(tFCP_DUPIMPOST, 'CD_EMPRESA', item_f('CD_EMPRESA', tFCP_DUPLICATI));
      putitem_e(tFCP_DUPIMPOST, 'CD_FORNECEDOR', item_f('CD_FORNECEDOR', tFCP_DUPLICATI));
      putitem_e(tFCP_DUPIMPOST, 'NR_DUPLICATA', item_f('NR_DUPLICATA', tFCP_DUPLICATI));
      putitem_e(tFCP_DUPIMPOST, 'NR_PARCELA', item_f('NR_PARCELA', tFCP_DUPLICATI));
      retrieve_e(tFCP_DUPIMPOST);
      if (xStatus < 0) then begin
        clear_e(tFCP_DUPIMPOST);
      end;

      viParams := '';
      putitemXml(viParams, 'CD_EMPRESA', vCdEmpresa);
      putitemXml(viParams, 'DT_LIQ', vDtLiq);
      putitemXml(viParams, 'NR_SEQLIQ', vNrSeqLiq);
      putitemXml(viParams, 'NR_SEQITEM', vNrSeqItem);
      putitemXml(viParams, 'NR_CTAPES', item_f('NR_CTAPES', tFCC_AUTORIZAC));
      putitemXml(viParams, 'TP_LIQUIDACAO', vTpLiquidacao);
      putitemXml(viParams, 'VL_PAGAMENTO', item_f('VL_PAGAMENTO', tFCC_AUTOPAG));
      putitemXml(viParams, 'VL_TOTAL', item_f('VL_CHEQUE', tFCC_AUTOCHEQ));
      putitemXml(viParams, 'CD_EMPRESADUP', item_f('CD_EMPRESA', tFCP_DUPLICATI));
      putitemXml(viParams, 'CD_FORNECDUP', item_f('CD_FORNECEDOR', tFCP_DUPLICATI));
      putitemXml(viParams, 'NR_DUPLICATADUP', item_f('NR_DUPLICATA', tFCP_DUPLICATI));
      putitemXml(viParams, 'NR_PARCELADUP', item_f('NR_PARCELA', tFCP_DUPLICATI));
      putitemXml(viParams, 'TP_PAGAMENTO', 2);
      voParams := gravaLiquidacao(viParams); (* PARAM_GLB, viParams, voParams, xCdErro, xCtxErro *)
      if (xStatus < 0) then begin
        Result := voParams;
        return(-1); exit;
      end;
      if (item_a('DT_LIQ', tFCP_DUPLICATI) = '')  and ((item_f('NR_SEQLIQ', tFCP_DUPLICATI) = '')  or (item_f('NR_SEQLIQ', tFCP_DUPLICATI) = 0)) then begin
        vDupOriginal := '';
        putlistitensocc_e(vDupOriginal, tFCP_DUPLICATI);

        viParams := '';
        putitemXml(viParams, 'CD_EMPRESA', item_f('CD_EMPRESA', tFCP_DUPLICATI));
        putitemXml(viParams, 'CD_FORNECEDOR', item_f('CD_FORNECEDOR', tFCP_DUPLICATI));
        putitemXml(viParams, 'NR_DUPLICATA', item_f('NR_DUPLICATA', tFCP_DUPLICATI));
        putitemXml(viParams, 'NR_PARCELA', item_f('NR_PARCELA', tFCP_DUPLICATI));
        putitemXml(viParams, 'VL_DUPLICATA', item_f('VL_DUPLICATA', tFCP_DUPLICATI));
        putitemXml(viParams, 'DT_PAGAMENTO', vDtLiq);
        putitemXml(viParams, 'IN_AUTORIZACAOCHEQUE', True);
        voParams := activateCmp('FCPSVCO004', 'calculaValorDuplicata', viParams); (*,viParams,voParams,, *)
        if (xStatus < 0) then begin
          Result := voParams;
          return(-1); exit;
        end;
        vVlJurosTot := itemXmlF('VL_JUROS', voParams);
        VVlDesctoTot := itemXmlF('VL_DESCONTOS', voParams);
        vVlTotalDup := itemXmlF('VL_CALCULADO', voParams);

        vVlMulta := itemXmlF('VL_MULTA', voParams);

        vPercentual := (item_f('VL_PAGAMENTO', tFCC_AUTOPAG) / vVlTotalDup) * 100;
        vPercentual := roundto(vPercentual, 6);

        vVlJuros := vVlJurosTot - item_f('VL_DESPFIN', tFCP_DUPLICATI) - item_f('VL_ACRESCIMO', tFCP_DUPLICATI) - item_f('VL_OUTROACR', tFCP_DUPLICATI);
        vVlDesconto := vVlDesctoTot - item_f('VL_ABATIMENTO', tFCP_DUPLICATI) - item_f('VL_OUTROSDESC', tFCP_DUPLICATI) - item_f('VL_INDENIZACAO', tFCP_DUPLICATI);

        if (item_f('VL_IMPOSTO', tFCP_DUPLICATI) > 0)  and (item_b('IN_IMPOSTO', tFCP_DUPLICATI) = True) then begin
          vVlTotalDup := vVlTotalDup - item_f('VL_IMPOSTO', tFCP_DUPLICATI);
          vPercentual := (item_f('VL_PAGAMENTO', tFCC_AUTOPAG) / vVlTotalDup) * 100;
          vPercentual := roundto(vPercentual, 6);

          vVlDesctoTot := vVlDesctoTot + item_f('VL_IMPOSTO', tFCP_DUPLICATI);
        end;

        vVlJurosCalc := vVlJuros * vPercentual / 100;
        vVlJurosCalc := roundto(vVlJurosCalc, 2);
        vVlDesctoCalc := vVlDesconto * vPercentual / 100;
        vVlDesctoCalc := roundto(vVlDesctoCalc, 2);

        vVlMultaCalc := vVlMulta * vPercentual / 100;
        vVlMultaCalc := roundto(vVlMultaCalc, 2);

        vVlJurosTot := vVlJurosTot - vVlJuros + vVlJurosCalc;
        vVlDesctoTot := vVlDesctoTot - vVlDesconto + vVlDesctoCalc;
        vVlDif := item_f('VL_DUPLICATA', tFCP_DUPLICATI) - (item_f('VL_PAGAMENTO', tFCC_AUTOPAG) + vVlDesctoTot - vVlJurosTot);

        putitem_e(tFCP_DUPLICATI, 'VL_DUPLICATA', item_f('VL_PAGAMENTO', tFCC_AUTOPAG) + vVlDesctoTot - vVlJurosTot);
        putitem_e(tFCP_DUPLICATI, 'VL_PAGO', item_f('VL_PAGAMENTO', tFCC_AUTOPAG));
        putitem_e(tFCP_DUPLICATI, 'VL_DESCONTO', vVlDesctoTot);
        putitem_e(tFCP_DUPLICATI, 'VL_JUROS', vVlJurosTot);
        putitem_e(tFCP_DUPLICATI, 'VL_PGTOMULTA', vVlMultaCalc);
        putitem_e(tFCP_DUPLICATI, 'DT_BAIXA', vDtLiq);
        putitem_e(tFCP_DUPLICATI, 'TP_BAIXA', 1);
        putitem_e(tFCP_DUPLICATI, 'CD_OPERBAIXA', itemXmlF('CD_USUARIO', PARAM_GLB));
        putitem_e(tFCP_DUPLICATI, 'CD_EMPLIQ', vCdEmpresa);
        putitem_e(tFCP_DUPLICATI, 'DT_LIQ', vDtLiq);
        putitem_e(tFCP_DUPLICATI, 'NR_SEQLIQ', vNrSeqLiq);
        putitem_e(tFCP_DUPLICATI, 'CD_OPERADOR', itemXmlF('CD_USUARIO', PARAM_GLB));
        putitem_e(tFCP_DUPLICATI, 'DT_CADASTRO', Now);

        viParams := '';
        voParams := gravaDuplicata(viParams); (* viParams, voParams, xCdErro, xCtxErro *)
        if (xStatus < 0) then begin
          Result := voParams;
          return(-1); exit;
        end;
        vDsRegDesp := itemXml('DS_REGDESP', voParams);
        vDsRegImp := itemXml('DS_REGIMP', voParams);

        viParams := '';
        putitemXml(viParams, 'CD_EMPRESA', item_f('CD_EMPRESA', tFCP_DUPLICATI));
        putitemXml(viParams, 'CD_FORNECEDOR', item_f('CD_FORNECEDOR', tFCP_DUPLICATI));
        putitemXml(viParams, 'NR_DUPLICATA', item_f('NR_DUPLICATA', tFCP_DUPLICATI));
        putitemXml(viParams, 'NR_PARCELA', item_f('NR_PARCELA', tFCP_DUPLICATI));
        putitemXml(viParams, 'TP_ESTAGIO', 90);
        putitemXml(viParams, 'TP_BAIXA', 1);
        voParams := activateCmp('FCPSVCO005', 'alteraEstagioDuplicata', viParams); (*,viParams,voParams,, *)
        if (xStatus < 0) then begin
          Result := voParams;
          return(-1); exit;
        end;

        viParams := '';
        putitemXml(viParams, 'CD_EMPRESA', item_f('CD_EMPRESA', tFCP_DUPLICATI));
        putitemXml(viParams, 'CD_FORNECEDOR', item_f('CD_FORNECEDOR', tFCP_DUPLICATI));
        putitemXml(viParams, 'NR_DUPLICATA', item_f('NR_DUPLICATA', tFCP_DUPLICATI));
        putitemXml(viParams, 'NR_PARCELA', item_f('NR_PARCELA', tFCP_DUPLICATI));
        putitemXml(viParams, 'TP_LOGDUP', 5);
        putitemXml(viParams, 'DS_COMPONENTE', 'FGRSVCO001');
        putitemXml(viParams, 'DS_OBS', 'LIQUIDACAO DA DUPLICATA');
        voParams := activateCmp('FCPSVCO001', 'gravaLogDuplicata', viParams); (*,viParams,voParams,, *)
        if (xStatus < 0) then begin
          Result := voParams;
          return(-1); exit;
        end;
        if (vVlDif > 0) then begin
          clear_e(tFCP_DUPLICATI);
          clear_e(tFCP_DUPDESPES);
          clear_e(tFCP_DUPIMPOST);

          creocc(tFCP_DUPLICATI, -1);
          getlistitensocc_e(vDupOriginal, tFCP_DUPLICATI);

          viParams := '';
          putitemXml(viParams, 'TP_PARCELA', 2);
          voParams := geraSeqParcela(viParams); (* viParams, voParams, xCdErro, xCtxErro *)
          if (xStatus < 0) then begin
            Result := voParams;
            return(-1); exit;
          end;
          vNrParcela := itemXmlF('NR_PARCELA', voParams);

          if (vNrParcela > 999) then begin
            viParams := '';
            putitemXml(viParams, 'CD_EMPRESA', item_f('CD_EMPRESA', tFCP_DUPLICATI));
            putitemXml(viParams, 'CD_FORNECEDOR', item_f('CD_FORNECEDOR', tFCP_DUPLICATI));
            putitemXml(viParams, 'NR_DUPLICATA', item_f('NR_DUPLICATA', tFCP_DUPLICATI));
            putitemXml(viParams, 'NR_PARCELA', item_f('NR_PARCELA', tFCP_DUPLICATI));
            voParams := activateCmp('FCPSVCO051', 'buscarSeqParcelaDupParcial', viParams); (*,viParams,voParams,, *)
            if (xStatus < 0) then begin
              Result := voParams;
              return(-1); exit;
            end;
            if (itemXml('NR_PARCELA', voParams) > 0) then begin
              vNrParcela := itemXmlF('NR_PARCELA', voParams);
            end;
          end;

          putitem_e(tFCP_DUPLICATI, 'VL_DUPLICATA', vVlDif);
          putitem_e(tFCP_DUPLICATI, 'VL_ORIGINAL', vVlDif);
          putitem_e(tFCP_DUPLICATI, 'DT_CADASTRO', Now);
          putitem_e(tFCP_DUPLICATI, 'CD_OPERADOR', itemXmlF('CD_USUARIO', PARAM_GLB));
          putitem_e(tFCP_DUPLICATI, 'TP_INCLUSAO', 2);
          putitem_e(tFCP_DUPLICATI, 'NR_PARORIGINAL', item_f('NR_PARCELA', tFCP_DUPLICATI));
          putitem_e(tFCP_DUPLICATI, 'NR_PARCELA', vNrParcela);
          putitem_e(tFCP_DUPLICATI, 'VL_DESPFIN', '');
          putitem_e(tFCP_DUPLICATI, 'VL_ABATIMENTO', '');
          putitem_e(tFCP_DUPLICATI, 'VL_ACRESCIMO', '');
          putitem_e(tFCP_DUPLICATI, 'VL_OUTROSDESC', '');
          putitem_e(tFCP_DUPLICATI, 'VL_OUTROACR', '');
          putitem_e(tFCP_DUPLICATI, 'VL_JUROS', '');
          putitem_e(tFCP_DUPLICATI, 'VL_DESCONTO', '');
          putitem_e(tFCP_DUPLICATI, 'TP_ESTAGIO', 2);
          putitem_e(tFCP_DUPLICATI, 'VL_INDENIZACAO', '');
          if (vDsRegDesp <> '') then begin
            repeat
              getitem(vDsDespesa, vDsRegDesp, 1);
              creocc(tFCP_DUPDESPES, -1);
              getlistitensocc_e(vDsDespesa, tFCP_DUPDESPES);
              putitem_e(tFCP_DUPDESPES, 'NR_PARCELA', vNrParcela);
              delitem(vDsRegDesp, 1);
            until (vDsRegDesp = '');
          end;
          if (vDsRegImp <> '') then begin
            repeat
              getitem(vDsImposto, vDsRegImp, 1);
              creocc(tFCP_DUPIMPOST, -1);
              getlistitensocc_e(vDsImposto, tFCP_DUPIMPOST);
              putitem_e(tFCP_DUPIMPOST, 'NR_PARCELA', vNrParcela);
              delitem(vDsRegImp, 1);
            until (vDsRegImp = '');
          end;

          viParams := '';
          voParams := gravaDuplicata(viParams); (* viParams, voParams, xCdErro, xCtxErro *)
          if (xStatus < 0) then begin
            Result := voParams;
            return(-1); exit;
          end;
        end;
      end;

      vNrSeqItem := vNrSeqItem + 1;

      setocc(tFCC_AUTOPAG, curocc(tFCC_AUTOPAG) + 1);
    end;
  end;

  Result := '';
  putitemXml(Result, 'CD_EMPLIQ', vCdEmpresa);
  putitemXml(Result, 'DT_LIQ', vDtLiq);
  putitemXml(Result, 'NR_SEQLIQ', vNrSeqLiq);

  return(0); exit;
end;

//---------------------------------------------------------------
function T_FGRSVCO001.gravaLiquidacao(pParams : String) : String;
//---------------------------------------------------------------
const
  cDS_METHOD = 'ADICONAL=Operação: T_FGRSVCO001.gravaLiquidacao()';
var
  vCdEmpresa, vNrSeqLiq, vVlPagamento, vVlTotal, vNrSeqItem, vNrCtaPes : Real;
  vCdEmpresaDup, vCdFornecDup, vNrDuplicataDup, vNrParcelaDup, vTpLiquidacao : Real;
  vCdFornecedor, vTpPagamento : Real;
  vDtSistema : TDate;
begin
  vCdEmpresa := itemXmlF('CD_EMPRESA', pParams);
  vNrSeqLiq := itemXmlF('NR_SEQLIQ', pParams);
  vVlPagamento := itemXmlF('VL_PAGAMENTO', pParams);
  vCdEmpresaDup := itemXmlF('CD_EMPRESADUP', pParams);
  vCdFornecDup := itemXmlF('CD_FORNECDUP', pParams);
  vNrDuplicataDup := itemXmlF('NR_DUPLICATADUP', pParams);
  vNrParcelaDup := itemXmlF('NR_PARCELADUP', pParams);
  vNrSeqItem := itemXmlF('NR_SEQITEM', pParams);
  vNrCtaPes := itemXmlF('NR_CTAPES', pParams);
  vVlTotal := itemXmlF('VL_TOTAL', pParams);
  vTpLiquidacao := itemXmlF('TP_LIQUIDACAO', pParams);
  vCdFornecedor := itemXmlF('CD_FORNECEDOR', pParams);
  vTpPagamento := itemXmlF('TP_PAGAMENTO', pParams);
  vDtSistema := itemXml('DT_LIQ', pParams);
  if (vDtSistema = '') then begin
    vDtSistema := itemXml('DT_SISTEMA', PARAM_GLB);
  end;

  creocc(tFGR_LIQ, -1);
  putitem_e(tFGR_LIQ, 'CD_EMPLIQ', vCdEmpresa);
  putitem_e(tFGR_LIQ, 'DT_LIQ', vDtSistema);
  putitem_e(tFGR_LIQ, 'NR_SEQLIQ', vNrSeqLiq);
  retrieve_o(tFGR_LIQ);
  if (xStatus = -7) then begin
    retrieve_x(tFGR_LIQ);
  end;
  putitem_e(tFGR_LIQ, 'CD_OPERADOR', itemXmlF('CD_USUARIO', PARAM_GLB));
  putitem_e(tFGR_LIQ, 'DT_CADASTRO', Now);
  putitem_e(tFGR_LIQ, 'VL_TOTAL', vVlTotal);
  putitem_e(tFGR_LIQ, 'TP_LIQUIDACAO', vTpLiquidacao);
  putitem_e(tFGR_LIQ, 'CD_GRUPOEMPRESA', item_f('CD_GRUPOEMPRESA', tGER_EMPRESA));

  if (item_f('CD_PESSOA', tFGR_LIQ) = '')  and (vCdFornecedor > 0) then begin
    putitem_e(tFGR_LIQ, 'CD_PESSOA', vCdFornecedor);
  end;

  creocc(tFGR_LIQITEMCC, -1);
  putitem_e(tFGR_LIQITEMCC, 'NR_SEQITEM', vNrSeqItem);
  retrieve_o(tFGR_LIQITEMCC);
  if (xStatus = -7) then begin
    retrieve_x(tFGR_LIQITEMCC);
  end;

  putitem_e(tFGR_LIQITEMCC, 'NR_CTAPES', vNrCtaPes);
  if (item_f('NR_CTAPES', tFGR_LIQITEMCC) = '') then begin
    putitem_e(tFGR_LIQITEMCC, 'NR_CTAPES', '999999999');
  end;

  putitem_e(tFGR_LIQITEMCC, 'VL_PAGAMENTO', vVlPagamento);
  if (vCdEmpresaDup <> 0) then begin
    putitem_e(tFGR_LIQITEMCC, 'CD_EMPRESADUP', vCdEmpresaDup);
    putitem_e(tFGR_LIQITEMCC, 'CD_FORNECDUP', vCdFornecDup);
    putitem_e(tFGR_LIQITEMCC, 'NR_DUPLICATADUP', vNrDuplicataDup);
    putitem_e(tFGR_LIQITEMCC, 'NR_PARCELADUP', vNrParcelaDup);
  end else begin
    putitem_e(tFGR_LIQITEMCC, 'CD_FORNECEDOR', vCdFornecedor);
  end;
  putitem_e(tFGR_LIQITEMCC, 'CD_OPERADOR', itemXmlF('CD_USUARIO', PARAM_GLB));
  putitem_e(tFGR_LIQITEMCC, 'DT_CADASTRO', Now);

  creocc(tFGR_LIQITEMCP, -1);
  putitem_e(tFGR_LIQITEMCP, 'NR_SEQITEM', 1);
  retrieve_o(tFGR_LIQITEMCP);
  if (xStatus = -7) then begin
    retrieve_x(tFGR_LIQITEMCP);
  end;
  putitem_e(tFGR_LIQITEMCP, 'TP_LIQITEMCP', vTpPagamento);
  putitem_e(tFGR_LIQITEMCP, 'VL_PAGO', vVlTotal);
  putitem_e(tFGR_LIQITEMCP, 'NR_CTAPES', vNrCtaPes);
  putitem_e(tFGR_LIQITEMCP, 'DT_AUTORIZACAO', item_a('DT_AUTORIZACAO', tFCC_AUTOCHEQ));
  putitem_e(tFGR_LIQITEMCP, 'NR_SEQAUTO', item_f('NR_SEQAUTO', tFCC_AUTOCHEQ));
  putitem_e(tFGR_LIQITEMCP, 'NR_SEQCHEQUE', item_f('NR_SEQCHEQUE', tFCC_AUTOCHEQ));
  putitem_e(tFGR_LIQITEMCP, 'CD_OPERADOR', itemXmlF('CD_USUARIO', PARAM_GLB));
  putitem_e(tFGR_LIQITEMCP, 'DT_CADASTRO', Now);

  creocc(tFGR_LIQITEMCR, -1);
  putitem_e(tFGR_LIQITEMCR, 'NR_SEQITEM', 1);
  retrieve_o(tFGR_LIQITEMCR);
  if (xStatus = -7) then begin
    retrieve_x(tFGR_LIQITEMCR);
  end;

  putitem_e(tFGR_LIQITEMCR, 'CD_OPERADOR', itemXmlF('CD_USUARIO', PARAM_GLB));
  putitem_e(tFGR_LIQITEMCR, 'DT_CADASTRO', Now);

  voParams := tFGR_LIQ.Salvar();
  if (xStatus < 0) then begin
    Result := voParams;
    return(-1); exit;
  end;

  putitem_e(tFCC_AUTOCHEQ, 'CD_EMPLIQ', vCdEmpresa);
  putitem_e(tFCC_AUTOCHEQ, 'DT_LIQ', vDtSistema);
  putitem_e(tFCC_AUTOCHEQ, 'NR_SEQLIQ', vNrSeqLiq);
  voParams := tFCC_AUTOCHEQ.Salvar();
  if (xStatus < 0) then begin
    Result := voParams;
    return(-1); exit;
  end;

  putitemXml(Result, 'CD_EMPLIQ', vCdEmpresa);
  putitemXml(Result, 'DT_LIQ', vDtSistema);
  putitemXml(Result, 'NR_SEQLIQ', vNrSeqLiq);

  return(0); exit;
end;

//--------------------------------------------------------------
function T_FGRSVCO001.gravaLiqCartao(pParams : String) : String;
//--------------------------------------------------------------
const
  cDS_METHOD = 'ADICONAL=Operação: T_FGRSVCO001.gravaLiqCartao()';
var
  vCdEmpresa, vNrSeqLiq, vVlPagamento, vVlTotal, vNrSeqItem, vNrCtaPes,vCdEmpLiq : Real;
  vCdEmpresaDup, vCdFornecDup, vNrDuplicataDup, vNrParcelaDup, vTpLiquidacao : Real;
  vCdFornecedor, vTpPagamento : Real;
  vDtSistema, vDtLiq : TDate;
begin
  vCdEmpresa := itemXmlF('CD_EMPRESA', pParams);
  vCdEmpLiq := itemXmlF('CD_EMPLIQ', pParams);
  vDtLiq := itemXml('DT_LIQ', pParams);
  vNrSeqLiq := itemXmlF('NR_SEQLIQ', pParams);
  vVlPagamento := itemXmlF('VL_PAGAMENTO', pParams);
  vCdEmpresaDup := itemXmlF('CD_EMPRESADUP', pParams);
  vCdFornecDup := itemXmlF('CD_FORNECDUP', pParams);
  vNrDuplicataDup := itemXmlF('NR_DUPLICATADUP', pParams);
  vNrParcelaDup := itemXmlF('NR_PARCELADUP', pParams);
  vNrSeqItem := itemXmlF('NR_SEQITEM', pParams);
  vNrCtaPes := itemXmlF('NR_CTAPES', pParams);
  vVlTotal := itemXmlF('VL_TOTAL', pParams);
  vTpLiquidacao := itemXmlF('TP_LIQUIDACAO', pParams);
  vCdFornecedor := itemXmlF('CD_FORNECEDOR', pParams);
  vTpPagamento := itemXmlF('TP_PAGAMENTO', pParams);
  vDtSistema := itemXml('DT_SISTEMA', PARAM_GLB);

  clear_e(tFGR_LIQ);
  putitem_e(tFGR_LIQ, 'CD_EMPLIQ', vCdEmpLiq);
  putitem_e(tFGR_LIQ, 'DT_LIQ', vDtLiq);
  putitem_e(tFGR_LIQ, 'NR_SEQLIQ', vNrSeqLiq);
  retrieve_e(tFGR_LIQ);

  creocc(tFGR_LIQITEMCC, -1);
  putitem_e(tFGR_LIQITEMCC, 'NR_SEQITEM', vNrSeqItem);
  retrieve_o(tFGR_LIQITEMCC);
  if (xStatus = -7) then begin
    retrieve_x(tFGR_LIQITEMCC);
  end;
  putitem_e(tFGR_LIQITEMCC, 'NR_CTAPES', vNrCtaPes);
  putitem_e(tFGR_LIQITEMCC, 'VL_PAGAMENTO', vVlPagamento);
  if (vCdEmpresaDup <> 0) then begin
    putitem_e(tFGR_LIQITEMCC, 'CD_EMPRESADUP', vCdEmpresaDup);
    putitem_e(tFGR_LIQITEMCC, 'CD_FORNECDUP', vCdFornecDup);
    putitem_e(tFGR_LIQITEMCC, 'NR_DUPLICATADUP', vNrDuplicataDup);
    putitem_e(tFGR_LIQITEMCC, 'NR_PARCELADUP', vNrParcelaDup);
  end else begin
    putitem_e(tFGR_LIQITEMCC, 'CD_FORNECEDOR', vCdFornecedor);
  end;
  putitem_e(tFGR_LIQITEMCC, 'CD_OPERADOR', itemXmlF('CD_USUARIO', PARAM_GLB));
  putitem_e(tFGR_LIQITEMCC, 'DT_CADASTRO', Now);

  creocc(tFGR_LIQITEMCP, -1);
  putitem_e(tFGR_LIQITEMCP, 'NR_SEQITEM', vNrSeqItem);
  retrieve_o(tFGR_LIQITEMCP);
  if (xStatus = -7) then begin
    retrieve_x(tFGR_LIQITEMCP);
  end;
  putitem_e(tFGR_LIQITEMCP, 'TP_LIQITEMCP', vTpPagamento);
  putitem_e(tFGR_LIQITEMCP, 'VL_PAGO', vVlTotal);
  putitem_e(tFGR_LIQITEMCP, 'NR_CTAPES', vNrCtaPes);
  putitem_e(tFGR_LIQITEMCP, 'DT_AUTORIZACAO', item_a('DT_AUTORIZACAO', tFCC_AUTOCHEQ));
  putitem_e(tFGR_LIQITEMCP, 'NR_SEQAUTO', item_f('NR_SEQAUTO', tFCC_AUTOCHEQ));
  putitem_e(tFGR_LIQITEMCP, 'NR_SEQCHEQUE', item_f('NR_SEQCHEQUE', tFCC_AUTOCHEQ));
  putitem_e(tFGR_LIQITEMCP, 'CD_OPERADOR', itemXmlF('CD_USUARIO', PARAM_GLB));
  putitem_e(tFGR_LIQITEMCP, 'DT_CADASTRO', Now);

  voParams := tFGR_LIQ.Salvar();
  if (xStatus < 0) then begin
    Result := voParams;
    return(-1); exit;
  end;
  return(0); exit;
end;

//--------------------------------------------------------------
function T_FGRSVCO001.calculaDespImp(pParams : String) : String;
//--------------------------------------------------------------
const
  cDS_METHOD = 'ADICONAL=Operação: T_FGRSVCO001.calculaDespImp()';
var
  vValor, vVlTotal, vVlDif, vVlBaseCalcImp : Real;
  viParams, voParams : String;
begin
  vValor := item_f('VL_DUPLICATA', tFCP_DUPLICATI) - item_f('VL_ABATIMENTO', tFCP_DUPLICATI) - item_f('VL_INDENIZACAO', tFCP_DUPLICATI);

  vVlTotal := 0;
  if (empty (FCP_DUPDESPES) = False) then begin
    setocc(tFCP_DUPDESPES, -1);
    setocc(tFCP_DUPDESPES, 1);

    while (xStatus >= 0)  and (item_f('CD_DESPESAITEM', tFCP_DUPDESPES) > 0) do begin
      putitem_e(tFCP_DUPDESPES, 'VL_RATEIO', (vValor * item_f('PR_RATEIO', tFCP_DUPDESPES)) / 100);
      putitem_e(tFCP_DUPDESPES, 'VL_RATEIO', roundto(item_f('VL_RATEIO', tFCP_DUPDESPES), 2));
      vVlTotal := vVlTotal + item_f('VL_RATEIO', tFCP_DUPDESPES);

      setocc(tFCP_DUPDESPES, curocc(tFCP_DUPDESPES) + 1);
    end;
    if (vValor <> vVlTotal) then begin
      vVlDif := vValor - vVlTotal;
      setocc(tFCP_DUPDESPES, -1);
      putitem_e(tFCP_DUPDESPES, 'VL_RATEIO', item_f('VL_RATEIO', tFCP_DUPDESPES) + vVlDif);
      putitem_e(tFCP_DUPDESPES, 'PR_RATEIO', roundto((item_f('VL_RATEIO', tFCP_DUPDESPES), 2) / item_f('VL_DUPLICATA', tFCP_DUPLICATI)) * 100);
    end;
  end;

  viParams := '';
  putitemXml(viParams, 'CD_EMPRESA', item_f('CD_EMPRESA', tFCP_DUPLICATI));
  putitemXml(viParams, 'CD_FORNECEDOR', item_f('CD_FORNECEDOR', tFCP_DUPLICATI));
  putitemXml(viParams, 'NR_DUPLICATA', item_f('NR_DUPLICATA', tFCP_DUPLICATI));
  putitemXml(viParams, 'NR_PARCELA', item_f('NR_PARCELA', tFCP_DUPLICATI));
  voParams := activateCmp('FCPSVCO003', 'calculaBaseCalcImp', viParams); (*,viParams,voParams,, *)
  if (xStatus < 0) then begin
    Result := voParams;
    return(-1); exit;
  end;
  vVlBaseCalcImp := (itemXml('VL_BASECALCIMP', voParams) * item_f('PR_BASECALCIMP', tFCP_DUPLICATI)) / 100;
  vVlBaseCalcImp := roundto(vVlBaseCalcImp, 2);

  if (empty (FCP_DUPIMPOST) = False) then begin
    setocc(tFCP_DUPIMPOST, -1);
    setocc(tFCP_DUPIMPOST, 1);
    while (xStatus >= 0)  and (item_f('CD_IMPOSTO', tFCP_DUPIMPOST) > 0) do begin
      if (item_f('TP_SITUACAO', tFCP_DUPIMPOST) = 0) then begin
        putitem_e(tFCP_DUPIMPOST, 'VL_IMPOSTO', (vVlBaseCalcImp * item_f('PR_ALIQUOTA', tFCP_DUPIMPOST)) / 100);
        putitem_e(tFCP_DUPIMPOST, 'VL_IMPOSTO', roundto(item_f('VL_IMPOSTO', tFCP_DUPIMPOST), 2));
      end;

      setocc(tFCP_DUPIMPOST, curocc(tFCP_DUPIMPOST) + 1);
    end;
  end;

  return(0); exit;
end;

//--------------------------------------------------------------
function T_FGRSVCO001.geraSeqParcela(pParams : String) : String;
//--------------------------------------------------------------
const
  cDS_METHOD = 'ADICONAL=Operação: T_FGRSVCO001.geraSeqParcela()';
var
  vCdEmpresa, vCdFornecedor, vNrDuplicata, vNrParcela, vNrParcelaIni, vNrParcelaFim, vTpParcela : Real;
begin
  vCdEmpresa := item_f('CD_EMPRESA', tFCP_DUPLICATI);
  vCdFornecedor := item_f('CD_FORNECEDOR', tFCP_DUPLICATI);
  vNrDuplicata := item_f('NR_DUPLICATA', tFCP_DUPLICATI);
  select max(NR_PARCELA) 
    from 'FCP_DUPLICATISVC' 
    where (putitem_e(tFCP_DUPLICATI, 'CD_EMPRESA', vCdEmpresa ) and (
    putitem_e(tFCP_DUPLICATI, 'CD_FORNECEDOR', vCdFornecedor ) and (
    putitem_e(tFCP_DUPLICATI, 'NR_DUPLICATA', vNrDuplicata)
    to vNrParcela;

  if (vNrParcela >= 200) then begin
    vNrParcela := vNrParcela + 1;
  end else begin
    vNrParcela := 200;
  end;

  Result := '';
  putitemXml(Result, 'NR_PARCELA', vNrParcela);

  return(0); exit;

end;

//--------------------------------------------------------------
function T_FGRSVCO001.gravaDuplicata(pParams : String) : String;
//--------------------------------------------------------------
const
  cDS_METHOD = 'ADICONAL=Operação: T_FGRSVCO001.gravaDuplicata()';
var
  viParams, voParams : String;
  vDsLinha, vDsRegImp, vDsRegDesp, vDsLinhaDesp, vDsLinhaImp : String;
  vVlTotalRateio, vPrTotalRateio, vVlValor, vVlDiferenca : Real;
begin
  viParams := '';
  voParams := calculaDespImp(viParams); (* viParams, voParams, xCdErro, xCtxErro *)
  if (xStatus < 0) then begin
    Result := voParams;
    return(-1); exit;
  end;

  vDsLinha := '';
  vDsRegDesp := '';
  vDsRegImp := '';
  vDsLinha := '';
  putlistitensocc_e(vDsLinha, tFCP_DUPLICATI);

  if not (empty(FCP_DUPDESPES)) then begin
    vVlValor := item_f('VL_DUPLICATA', tFCP_DUPLICATI) - item_f('VL_ABATIMENTO', tFCP_DUPLICATI) - item_f('VL_INDENIZACAO', tFCP_DUPLICATI);
    setocc(tFCP_DUPDESPES, 1);
    while (xStatus >= 0) do begin
      if (item_f('PR_RATEIO', tFCP_DUPDESPES) <> '') then begin
        putitem_e(tFCP_DUPDESPES, 'VL_RATEIO', (vVlValor * item_f('PR_RATEIO', tFCP_DUPDESPES)) / 100);
        putitem_e(tFCP_DUPDESPES, 'VL_RATEIO', roundto(item_f('VL_RATEIO', tFCP_DUPDESPES), 2));
        vVlTotalRateio := vVlTotalRateio + item_f('VL_RATEIO', tFCP_DUPDESPES);
        vPrTotalRateio := vPrTotalRateio + item_f('PR_RATEIO', tFCP_DUPDESPES);
      end;
      setocc(tFCP_DUPDESPES, curocc(tFCP_DUPDESPES) + 1);
    end;
    if (vVlTotalRateio > vVlValor) then begin
      vVlDiferenca := vVlTotalRateio - vVlValor;
      putitem_e(tFCP_DUPDESPES, 'VL_RATEIO', item_f('VL_RATEIO', tFCP_DUPDESPES) - vVlDiferenca);
    end;
    if (vVlTotalRateio < vVlValor) then begin
      vVlDiferenca := vVlValor - vVlTotalRateio;
      putitem_e(tFCP_DUPDESPES, 'VL_RATEIO', item_f('VL_RATEIO', tFCP_DUPDESPES) + vVlDiferenca);
    end;
    if (vPrTotalRateio > 100) then begin
      vVlDiferenca := vPrTotalRateio - 100;
      putitem_e(tFCP_DUPDESPES, 'PR_RATEIO', item_f('PR_RATEIO', tFCP_DUPDESPES) - vVlDiferenca);
    end;
    if (vPrTotalRateio < 100) then begin
      vVlDiferenca := 100 - vPrTotalRateio;
      putitem_e(tFCP_DUPDESPES, 'PR_RATEIO', item_f('PR_RATEIO', tFCP_DUPDESPES) + vVlDiferenca);
    end;
  end;

  setocc(tFCP_DUPDESPES, -1);
  setocc(tFCP_DUPDESPES, 1);
  if (empty (FCP_DUPDESPES) = False) then begin
    while (xStatus >= 0)  and (item_f('CD_DESPESAITEM', tFCP_DUPDESPES) > 0) do begin
      putlistitensocc_e(vDsLinhaDesp, tFCP_DUPDESPES);
      putitem(vDsRegDesp,  vDsLinhaDesp);
      setocc(tFCP_DUPDESPES, curocc(tFCP_DUPDESPES) + 1);
    end;
  end;

  setocc(tFCP_DUPIMPOST, -1);
  setocc(tFCP_DUPIMPOST, 1);
  if (empty (FCP_DUPIMPOST) = False) then begin
    while (xStatus >= 0)  and (item_f('CD_IMPOSTO', tFCP_DUPIMPOST) <> 0) do begin
      putlistitensocc_e(vDsLinhaImp, tFCP_DUPIMPOST);
      putitem(vDsRegImp,  vDsLinhaImp);
      setocc(tFCP_DUPIMPOST, curocc(tFCP_DUPIMPOST) + 1);
    end;
  end;

  putitemXml(vDsLinha, 'DS_DUPDESPESA', vDsRegDesp);
  putitemXml(vDsLinha, 'DS_DUPIMPOSTO', vDsRegImp);

  viParams := '';
  putitemXml(viParams, 'DS_DUPLICATAI', vDsLinha);
  putitemXml(viParams, 'DS_COMPONENTE', 'FGRSVCO001');
  voParams := activateCmp('FCPSVCO001', 'geraDuplicata', viParams); (*,viParams,voParams,, *)
  if (xStatus < 0) then begin
    Result := voParams;
    return(-1); exit;
  end;

  putitemXml(Result, 'DS_REGDESP', vDsRegDesp);
  putitemXml(Result, 'DS_REGIMP', vDsRegImp);

  return(0); exit;
end;

//-----------------------------------------------------------------
function T_FGRSVCO001.cancelaLiquidacao(pParams : String) : String;
//-----------------------------------------------------------------
const
  cDS_METHOD = 'ADICONAL=Operação: T_FGRSVCO001.cancelaLiquidacao()';
var
  vDtLiq : TDate;
  vCdEmpLiq, vNrSeqLiq, vTpEstagio : Real;
  viParams, voParams : String;
begin
  vCdEmpLiq := itemXmlF('CD_EMPLIQ', pParams);
  vDtLiq := itemXml('DT_LIQ', pParams);
  vNrSeqLiq := itemXmlF('NR_SEQLIQ', pParams);
  vTpEstagio := itemXmlF('TP_ESTAGIO', pParams);

  if (vCdEmpLiq = 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Empresa da liquidação não informada!', cDS_METHOD);
    return(-1); exit;
  end;
  if (vDtLiq = '') then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Data da liquidação não informada!', cDS_METHOD);
    return(-1); exit;
  end;
  if (vNrSeqLiq = 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Sequência da liquidação não informada!', cDS_METHOD);
    return(-1); exit;
  end;

  clear_e(tFGR_LIQ);
  putitem_e(tFGR_LIQ, 'CD_EMPLIQ', vCdEmpLiq);
  putitem_e(tFGR_LIQ, 'DT_LIQ', vDtLiq);
  putitem_e(tFGR_LIQ, 'NR_SEQLIQ', vNrSeqLiq);
  retrieve_e(tFGR_LIQ);
  if (xStatus < 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Liquidação não encontrada!', cDS_METHOD);
    return(-1); exit;
  end;

  putitem_e(tFGR_LIQ, 'DT_CANCELAMENTO', Now);
  putitem_e(tFGR_LIQ, 'CD_OPERCANCEL', itemXmlF('CD_USUARIO', PARAM_GLB));

  voParams := tFGR_LIQ.Salvar();
  if (xStatus < 0) then begin
    Result := voParams;
    return(-1); exit;
  end;

  clear_e(tFCP_DUPLICATI);
  putitem_e(tFCP_DUPLICATI, 'CD_EMPLIQ', vCdEmpLiq);
  putitem_e(tFCP_DUPLICATI, 'DT_LIQ', vDtLiq);
  putitem_e(tFCP_DUPLICATI, 'NR_SEQLIQ', vNrSeqLiq);
  retrieve_e(tFCP_DUPLICATI);
  if (xStatus >= 0) then begin
    setocc(tFCP_DUPLICATI, 1);
    while (xStatus >= 0) do begin

      viParams := '';
      putitemXml(viParams, 'CD_EMPRESA', item_f('CD_EMPRESA', tFCP_DUPLICATI));
      putitemXml(viParams, 'CD_FORNECEDOR', item_f('CD_FORNECEDOR', tFCP_DUPLICATI));
      putitemXml(viParams, 'NR_DUPLICATA', item_f('NR_DUPLICATA', tFCP_DUPLICATI));
      putitemXml(viParams, 'NR_PARCELA', item_f('NR_PARCELA', tFCP_DUPLICATI));
      putitemXml(viParams, 'IN_CANCELARDUP', True);
      voParams := validarParcial(viParams); (* PARAM_GLB, viParams, voParams, xCdErro, xCtxErro *)
      if (xStatus < 0) then begin
        Result := voParams;
        return(-1); exit;
      end;
      if (itemXml('VL_DUPLICATA', voParams) > 0) then begin
        putitem_e(tFCP_DUPLICATI, 'VL_DUPLICATA', item_f('VL_DUPLICATA', tFCP_DUPLICATI) + itemXmlF('VL_DUPLICATA', voParams));
      end;
      putitem_e(tFCP_DUPLICATI, 'CD_EMPLIQ', 0);

      if (xStatus = -10)  or (xStatus = -11) then begin
        Result := SetStatus(STS_ERROR, 'GEN0001', 'Registro da duplicata bloqueado por outro usuário!', cDS_METHOD);
        rollback;
        return(-1); exit;
      end;

      putitem_e(tFCP_DUPLICATI, 'CD_EMPLIQ', '');
      putitem_e(tFCP_DUPLICATI, 'DT_LIQ', '');
      putitem_e(tFCP_DUPLICATI, 'NR_SEQLIQ', '');
      putitem_e(tFCP_DUPLICATI, 'IN_AUTORIZADO', False);
      putitem_e(tFCP_DUPLICATI, 'TP_ESTAGIO', vTpEstagio);
      putitem_e(tFCP_DUPLICATI, 'TP_SITUACAO', 'N');
      putitem_e(tFCP_DUPLICATI, 'TP_BAIXA', 0);
      putitem_e(tFCP_DUPLICATI, 'CD_OPERBAIXA', '');
      putitem_e(tFCP_DUPLICATI, 'DT_BAIXA', '');
      putitem_e(tFCP_DUPLICATI, 'VL_PAGO', 0);
      putitem_e(tFCP_DUPLICATI, 'VL_JUROS', 0);
      putitem_e(tFCP_DUPLICATI, 'VL_DESCONTO', 0);
      putitem_e(tFCP_DUPLICATI, 'CD_OPERADOR', itemXmlF('CD_USUARIO', PARAM_GLB));
      putitem_e(tFCP_DUPLICATI, 'DT_CADASTRO', Now);
      putitem_e(tFCP_DUPLICATI, 'VL_PGTOMULTA', '');

      voParams := tFCP_DUPLICATI.Salvar();
      if (xStatus < 0) then begin
        Result := voParams;
        return(-1); exit;
      end;

      viParams := '';
      putitemXml(viParams, 'CD_EMPRESA', item_f('CD_EMPRESA', tFCP_DUPLICATI));
      putitemXml(viParams, 'CD_FORNECEDOR', item_f('CD_FORNECEDOR', tFCP_DUPLICATI));
      putitemXml(viParams, 'NR_DUPLICATA', item_f('NR_DUPLICATA', tFCP_DUPLICATI));
      putitemXml(viParams, 'NR_PARCELA', item_f('NR_PARCELA', tFCP_DUPLICATI));
      voParams := activateCmp('FCPSVCO005', 'calculaValorDespesa', viParams); (*,viParams,voParams,, *)
      if (xStatus < 0) then begin
        Result := voParams;
        return(-1); exit;
      end;

      setocc(tFCP_DUPLICATI, curocc(tFCP_DUPLICATI) + 1);
    end;
  end;

  return(0); exit;
end;

//---------------------------------------------------------------------
function T_FGRSVCO001.cancelaAutorizacaoDup(pParams : String) : String;
//---------------------------------------------------------------------
const
  cDS_METHOD = 'ADICONAL=Operação: T_FGRSVCO001.cancelaAutorizacaoDup()';
var
  vCdEmpresa, vCdFornecedor, vNrDuplicata, vNrParcela, vTpEstagio : Real;
  viParams, voParams : String;
begin
  vCdEmpresa := itemXmlF('CD_EMPRESA', pParams);
  vCdFornecedor := itemXmlF('CD_FORNECEDOR', pParams);
  vNrDuplicata := itemXmlF('NR_DUPLICATA', pParams);
  vNrParcela := itemXmlF('NR_PARCELA', pParams);
  vTpEstagio := itemXmlF('TP_ESTAGIO', pParams);
  if (vCdEmpresa = 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Empresa da duplicata não informada!', cDS_METHOD);
    return(-1); exit;
  end;
  if (vCdFornecedor = '') then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Fornecedor da duplicata não informado!', cDS_METHOD);
    return(-1); exit;
  end;
  if (vNrDuplicata = 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Número da duplicata não informado!', cDS_METHOD);
    return(-1); exit;
  end;
  if (vNrParcela = 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Número da parcela não informado!', cDS_METHOD);
    return(-1); exit;
  end;
  clear_e(tFCP_DUPLICATI);
  putitem_e(tFCP_DUPLICATI, 'CD_EMPRESA', vCdEmpresa);
  putitem_e(tFCP_DUPLICATI, 'CD_FORNECEDOR', vCdFornecedor);
  putitem_e(tFCP_DUPLICATI, 'NR_DUPLICATA', vNrDuplicata);
  putitem_e(tFCP_DUPLICATI, 'NR_PARCELA', vNrParcela);
  retrieve_e(tFCP_DUPLICATI);
  if (xStatus >= 0) then begin
    viParams := '';
    putitemXml(viParams, 'CD_EMPRESA', item_f('CD_EMPRESA', tFCP_DUPLICATI));
    putitemXml(viParams, 'CD_FORNECEDOR', item_f('CD_FORNECEDOR', tFCP_DUPLICATI));
    putitemXml(viParams, 'NR_DUPLICATA', item_f('NR_DUPLICATA', tFCP_DUPLICATI));
    putitemXml(viParams, 'NR_PARCELA', item_f('NR_PARCELA', tFCP_DUPLICATI));
    putitemXml(viParams, 'IN_CANCELARDUP', True);
    voParams := validarParcial(viParams); (* PARAM_GLB, viParams, voParams, xCdErro, xCtxErro *)
    if (xStatus < 0) then begin
      Result := voParams;
      return(-1); exit;
    end;

    putitem_e(tFCP_DUPLICATI, 'CD_EMPLIQ', 0);
    putitem_e(tFCP_DUPLICATI, 'DT_LIQ', '');
    putitem_e(tFCP_DUPLICATI, 'NR_SEQLIQ', 0);
    putitem_e(tFCP_DUPLICATI, 'IN_AUTORIZADO', False);
    putitem_e(tFCP_DUPLICATI, 'TP_ESTAGIO', vTpEstagio);
    putitem_e(tFCP_DUPLICATI, 'TP_SITUACAO', 'N');
    putitem_e(tFCP_DUPLICATI, 'TP_BAIXA', 0);
    putitem_e(tFCP_DUPLICATI, 'CD_OPERBAIXA', '');
    putitem_e(tFCP_DUPLICATI, 'DT_BAIXA', '');
    putitem_e(tFCP_DUPLICATI, 'VL_PAGO', 0);
    putitem_e(tFCP_DUPLICATI, 'VL_JUROS', 0);
    putitem_e(tFCP_DUPLICATI, 'VL_DESCONTO', 0);
    putitem_e(tFCP_DUPLICATI, 'CD_OPERADOR', itemXmlF('CD_USUARIO', PARAM_GLB));
    putitem_e(tFCP_DUPLICATI, 'DT_CADASTRO', Now);
    putitem_e(tFCP_DUPLICATI, 'VL_PGTOMULTA', '');

    voParams := tFCP_DUPLICATI.Salvar();
    if (xStatus < 0) then begin
      Result := voParams;
      return(-1); exit;
    end;

    viParams := '';
    putitemXml(viParams, 'CD_EMPRESA', item_f('CD_EMPRESA', tFCP_DUPLICATI));
    putitemXml(viParams, 'CD_FORNECEDOR', item_f('CD_FORNECEDOR', tFCP_DUPLICATI));
    putitemXml(viParams, 'NR_DUPLICATA', item_f('NR_DUPLICATA', tFCP_DUPLICATI));
    putitemXml(viParams, 'NR_PARCELA', item_f('NR_PARCELA', tFCP_DUPLICATI));
    voParams := activateCmp('FCPSVCO005', 'calculaValorDespesa', viParams); (*,viParams,voParams,, *)
    if (xStatus < 0) then begin
      Result := voParams;
      return(-1); exit;
    end;
  end else begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Duplicata não localizada!', cDS_METHOD);
    return(-1); exit;
  end;

  return(0); exit;
end;

//-------------------------------------------------------------------
function T_FGRSVCO001.autorizacaoDeCheque(pParams : String) : String;
//-------------------------------------------------------------------
const
  cDS_METHOD = 'ADICONAL=Operação: T_FGRSVCO001.autorizacaoDeCheque()';
var
  vDtAutorizacao, vDtCheque : TDate;
  viParams, voParams, vDuplicatas, vDsLinha, vNrCtaPes : String;
  vDsTitular, vDsNominal, vDsChequeAutorizacao : String;
  vCont, vNrSeqAuto, vVlJuros, vVlDesconto, vPosAux, vNrOrdem, vNrSeqCheque, vVlCheque, vNrSeqItem : Real;
begin
  vDsChequeAutorizacao := itemXml('DS_CHEQUEAUTORIZACAO', pParams);
  vDuplicatas := itemXml('DS_DUPLICATAS', pParams);
  vNrOrdem := itemXmlF('NR_ORDEM', pParams);
  vDsTitular := '';

  if (itemXml('NR_CTAPESCHE', pParams) = '') then begin
    Result := SetStatus(STS_ERROR, 'GEN001', 'Descricao=Número da conta banco p/ emissão de cheques não informado', '');
    return(-1); exit;
  end;

  putitemXml(viParams, 'CD_PESSOA', itemXmlF('CD_FORNECEDOR', pParams));
  putitemXml(viParams, 'TP_CONTA', 'F');
  putitemXml(viParams, 'IN_NATUREZA', 'C');

  voParams := activateCmp('FCCSVCO002', 'criaContaPessoa', viParams); (*,viParams,voParams,, *)
  if (xStatus < 0) then begin
    Result := voParams;
    return(-1); exit;
  end;

  vNrCtaPes := itemXmlF('NR_CTAPES', voParams);
  vDsTitular := itemXml('DS_TITULAR', voParams);

  if (vDsTitular = '') then begin
    clear_e(tPES_PESSOA);
    putitem_e(tPES_PESSOA, 'CD_PESSOA', itemXmlF('CD_FORNECEDOR', pParams));
    retrieve_e(tPES_PESSOA);
    if (xStatus >= 0) then begin
      vDsTitular := item_a('NM_PESSOA', tPES_PESSOA);
    end;
  end;

  viParams := '';
  vCont := 1;

  putitemXml(viParams, 'NR_CTAPES', itemXmlF('NR_CTAPESCHE', pParams));
  putitemXml(viParams, 'NR_CTAPESC', vNrCtaPes);
  putitemXml(viParams, 'TP_AUTORIZACAO', 4);
  if (itemXml('IN_VARIOSCHEQUES', pParams) = True) then begin
    repeat
      vDsLinha := '';
      getitem(vDsLinha, vDsChequeAutorizacao, 1);
      putitemXml(viParams, 'NR_ORDEM' + vCont', + ' itemXmlF('NR_ORDEM' + vCont', + ' vDsLinha));
      putitemXml(viParams, 'VL_CHEQUE' + vCont', + ' itemXmlF('VL_CHEQUE' + vCont', + ' vDsLinha));
      putitemXml(viParams, 'DT_CHEQUE' + vCont', + ' itemXml('DT_CHEQUE' + vCont', + ' vDsLinha));
      if (itemXml('DS_NOMINAL' + vCont', + ' vDsLinha) = '') then begin
        putitemXml(viParams, 'DS_NOMINAL' + vCont', + ' vDsTitular);
      end else begin
        putitemXml(viParams, 'DS_NOMINAL' + vCont', + ' itemXml('DS_NOMINAL' + vCont', + ' vDsLinha));
      end;

      delitem(vDsChequeAutorizacao, 1);
      vCont := vCont + 1;
    until(vDsChequeAutorizacao = '');
  end else begin
    putitemXml(viParams, 'NR_ORDEM' + vCont', + ' itemXmlF('NR_ORDEM', pParams));
    putitemXml(viParams, 'VL_CHEQUE' + vCont', + ' itemXmlF('VL_PAGO', pParams));
    putitemXml(viParams, 'DT_CHEQUE' + vCont', + ' itemXml('DT_CHEQUE', pParams));
    putitemXml(viParams, 'DS_NOMINAL' + vCont', + ' vDsTitular);
  end;

  vCont := 1;
  if (vDuplicatas <> '') then begin
    repeat

      getitem(  vDsLinha, vDuplicatas, 1);
      putitemXml(viParams, 'CD_EMPRESA' + vCont', + ' itemXmlF('CD_EMPRESA', vDsLinha));
      putitemXml(viParams, 'NR_CTAPESC' + vCont', + ' vNrCtaPes);
      putitemXml(viParams, 'CD_FORNECEDOR' + vCont', + ' itemXmlF('CD_FORNECEDOR', vDsLinha));
      putitemXml(viParams, 'NR_DUPLICATA' + vCont', + ' itemXmlF('NR_DUPLICATA', vDsLinha));
      putitemXml(viParams, 'NR_PARCELA' + vCont', + ' itemXmlF('NR_PARCELA', vDslinha));
      putitemXml(viParams, 'VL_PAGAMENTO' + vCont', + ' itemXmlF('VL_PAGAMENTO', vDsLinha));
      putitemXml(viParams, 'VL_JUROS' + vCont', + ' itemXmlF('VL_JUROS', vDsLinha));
      putitemXml(viParams, 'VL_DESCONTO' + vCont', + ' itemXmlF('VL_DESCONTOS', vDsLinha));
      putitemXml(viParams, 'DS_DOC' + vCont', + ' '');
      putitemXml(viParams, 'DS_AUX' + vCont', + ' '');
      vCont := vCont + 1;

      delitem(vDuplicatas, 1);
    until (vDuplicatas = '');
  end;

  voParams := activateCmp('FCCSVCO007', 'AutorizaCheque', viParams); (*,viParams,voParams,, *)
  if (xStatus < 0) then begin
    Result := voParams;
    return(-1); exit;
  end;

  viParams := '';
  viParams := pParams;
  putitemXml(viParams, 'NR_CTAPES', vNrCtaPes);
  putitemXml(viParams, 'DT_AUTORIZACAO', vDtAutorizacao);
  putitemXml(viParams, 'NR_SEQAUTO', vNrSeqAuto);
  putitemXml(viParams, 'NR_SEQCHEQUE', vNrSeqCheque);
  if (vNrSeqCheque = 1) then begin
    voParams := atualizaLiq(viParams); (* PARAM_GLB, viParams, voParams, xCdErro, xCtxErro *)
    if (xStatus < 0) then begin
      Result := voParams;
      return(-1); exit;
    end;
  end else begin

    vCont := 1;
    vNrSeqItem := 6;
    vDsChequeAutorizacao := itemXml('DS_CHEQUEAUTORIZACAO', pParams);

    repeat
      vDsLinha := '';
      getitem(vDsLinha, vDsChequeAutorizacao, 1);
      viParams := '';
      viParams := pParams;
      putitemXml(viParams, 'NR_CTAPES', vNrCtaPes);
      putitemXml(viParams, 'DT_AUTORIZACAO', vDtAutorizacao);
      putitemXml(viParams, 'NR_SEQAUTO', vNrSeqAuto);
      putitemXml(viParams, 'NR_SEQCHEQUE', vCont);
      putitemXml(viParams, 'NR_SEQITEM', vNrSeqItem);
      putitemXml(viParams, 'VL_PAGO', itemXmlF('VL_CHEQUE' + vCont', + ' vDsLinha));
      voParams := atualizaLiq(viParams); (* PARAM_GLB, viParams, voParams, xCdErro, xCtxErro *)
      if (xStatus < 0) then begin
        Result := voParams;
        return(-1); exit;
      end;

      vCont := vCont + 1;
      vNrSeqItem := vNrSeqItem + 1;
      delitem(vDsChequeautorizacao, 1);
    until(vCont > vNrSeqCheque);
  end;
  if (itemXml('DS_DUPLICATAS', pParams) <> '') then begin
    getitem/id vDtAutorizacao, voParams, 'DT_AUTORIZACAO';
    getitem/id vNrSeqAuto, voParams, 'NR_SEQAUTO';

    vCont := 1;
    viParams := '';
    vDuplicatas := itemXml('DS_DUPLICATAS', pParams);
    repeat

      getitem(vDsLinha, vDuplicatas, 1);

      clear_e(tFCP_DUPLICATI);
      putitem_e(tFCP_DUPLICATI, 'CD_EMPRESA', itemXmlF('CD_EMPRESA', vDsLinha));
      putitem_e(tFCP_DUPLICATI, 'CD_FORNECEDOR', itemXmlF('CD_FORNECEDOR', vDsLinha));
      putitem_e(tFCP_DUPLICATI, 'NR_DUPLICATA', itemXmlF('NR_DUPLICATA', vDsLinha));
      putitem_e(tFCP_DUPLICATI, 'NR_PARCELA', itemXmlF('NR_PARCELA', vDsLinha));
      retrieve_e(tFCP_DUPLICATI);
      if (xStatus >= 0) then begin
        putitem_e(tFCP_DUPLICATI, 'IN_AUTORIZADO', True);
        putitem_e(tFCP_DUPLICATI, 'TP_BAIXA', 2);
        putitem_e(tFCP_DUPLICATI, 'TP_ESTAGIO', 10);
        voParams := tFCP_DUPLICATISVCSALVAR;.Salvar();
        if (xStatus < 0) then begin
          Result := voParams;
          return(-1); exit;
        end;
      end;
      vCont := vCont + 1;

      delitem(vDuplicatas, 1);
    until (vDuplicatas = '');
  end;

  return(0); exit;
end;

//-----------------------------------------------------------
function T_FGRSVCO001.atualizaLiq(pParams : String) : String;
//-----------------------------------------------------------
const
  cDS_METHOD = 'ADICONAL=Operação: T_FGRSVCO001.atualizaLiq()';
var
  vInAtualiza : String;
  vVlPago : Real;
begin
  if (itemXml('CD_EMPLIQ', pParams) = '') then begin
    Result := SetStatus(STS_ERROR, 'GEN001', 'Falta o código da empresa da liquidação, '');
    return(-1); exit;
  end;
  if (itemXml('DT_LIQ', pParams) = '') then begin
    Result := SetStatus(STS_ERROR, 'GEN001', 'Falta a data da liquidação, '');
    return(-1); exit;
  end;
  if (itemXml('NR_SEQLIQ', pParams) = '') then begin
    Result := SetStatus(STS_ERROR, 'GEN001', 'Falta a sequencia da liquidação, '');
    return(-1); exit;
  end;
  if (itemXml('NR_SEQITEM', pParams) = '') then begin
    Result := SetStatus(STS_ERROR, 'GEN001', 'Falta a sequencia do item da liquidação, '');
    return(-1); exit;
  end;
  vInAtualiza := itemXmlB('IN_ATUALIZA', pParams);
  vVlPago := itemXmlF('VL_PAGO', pParams);

  clear_e(tFGR_LIQ);
  putitem_e(tFGR_LIQ, 'CD_EMPLIQ', itemXmlF('CD_EMPLIQ', pParams));
  putitem_e(tFGR_LIQ, 'DT_LIQ', itemXml('DT_LIQ', pParams));
  putitem_e(tFGR_LIQ, 'NR_SEQLIQ', itemXmlF('NR_SEQLIQ', pParams));
  retrieve_e(tFGR_LIQ);
  if (xStatus < 0) then begin
    if (xStatus = -2) then begin
      clear_e(tFGR_LIQ);
      creocc(tFGR_LIQ, -1);
      putitem_e(tFGR_LIQ, 'CD_EMPLIQ', itemXmlF('CD_EMPLIQ', pParams));
      putitem_e(tFGR_LIQ, 'DT_LIQ', itemXml('DT_LIQ', pParams));
      putitem_e(tFGR_LIQ, 'NR_SEQLIQ', itemXmlF('NR_SEQLIQ', pParams));
      putitem_e(tFGR_LIQ, 'CD_GRUPOEMPRESA', itemXmlF('CD_GRUPOEMPRESA', PARAM_GLB));
      putitem_e(tFGR_LIQ, 'TP_LIQUIDACAO', itemXmlF('TP_LIQUIDACAO', pParams));

      creocc(tFGR_LIQITEMCP, -1);
      putitem_e(tFGR_LIQITEMCP, 'CD_EMPLIQ', itemXmlF('CD_EMPLIQ', pParams));
      putitem_e(tFGR_LIQITEMCP, 'DT_LIQ', itemXml('DT_LIQ', pParams));
      putitem_e(tFGR_LIQITEMCP, 'NR_SEQLIQ', itemXmlF('NR_SEQLIQ', pParams));
      putitem_e(tFGR_LIQITEMCP, 'NR_SEQITEM', itemXmlF('NR_SEQITEM', pParams));
      putitem_e(tFGR_LIQITEMCP, 'TP_LIQITEMCP', itemXmlF('TP_LIQITEMCP', pParams));
      putitem_e(tFGR_LIQITEMCP, 'CD_EMPENDOSSO', itemXmlF('CD_EMPendOSSO', pParams));
      putitem_e(tFGR_LIQITEMCP, 'NR_ANO', itemXmlF('NR_ANO', pParams));
      putitem_e(tFGR_LIQITEMCP, 'NR_ENDOSSO', itemXmlF('NR_endOSSO', pParams));
      putitem_e(tFGR_LIQITEMCP, 'NR_SEQAUTO', itemXmlF('NR_SEQAUTO', pParams));
      putitem_e(tFGR_LIQITEMCP, 'DT_AUTORIZACAO', itemXml('DT_AUTORIZACAO', pParams));
      putitem_e(tFGR_LIQITEMCP, 'NR_SEQCHEQUE', itemXmlF('NR_SEQCHEQUE', pParams));
      putitem_e(tFGR_LIQITEMCP, 'NR_CTAPES', itemXmlF('NR_CTAPES', pParams));
      putitem_e(tFGR_LIQITEMCP, 'NR_SEQFOR', itemXmlF('NR_SEQFOR', pParams));
    end else begin
Result := SetStatus(STS_ERROR, 'GEN0001', 'Liquidação não encontrada!', cDS_METHOD);
const
  Result := SetStatus(STS_ERROR, 'GEN0001', 'Liquidação não encontrada!', cDS_METHOD);
begin
      return(-1); exit;
    end;
  end else begin
    clear_e(tFGR_LIQITEMCP);
    putitem_e(tFGR_LIQITEMCP, 'CD_EMPLIQ', itemXmlF('CD_EMPLIQ', pParams));
    putitem_e(tFGR_LIQITEMCP, 'DT_LIQ', itemXml('DT_LIQ', pParams));
    putitem_e(tFGR_LIQITEMCP, 'NR_SEQLIQ', itemXmlF('NR_SEQLIQ', pParams));
    putitem_e(tFGR_LIQITEMCP, 'NR_SEQITEM', itemXmlF('NR_SEQITEM', pParams));
    retrieve_e(tFGR_LIQITEMCP);
    if (xStatus < 0) then begin
      if (xStatus = -2) then begin
        clear_e(tFGR_LIQITEMCP);
        creocc(tFGR_LIQITEMCP, -1);
        putitem_e(tFGR_LIQITEMCP, 'CD_EMPLIQ', itemXmlF('CD_EMPLIQ', pParams));
        putitem_e(tFGR_LIQITEMCP, 'DT_LIQ', itemXml('DT_LIQ', pParams));
        putitem_e(tFGR_LIQITEMCP, 'NR_SEQLIQ', itemXmlF('NR_SEQLIQ', pParams));
        putitem_e(tFGR_LIQITEMCP, 'NR_SEQITEM', itemXmlF('NR_SEQITEM', pParams));
        putitem_e(tFGR_LIQITEMCP, 'TP_LIQITEMCP', itemXmlF('TP_LIQITEMCP', pParams));
        putitem_e(tFGR_LIQITEMCP, 'CD_EMPENDOSSO', itemXmlF('CD_EMPendOSSO', pParams));
        putitem_e(tFGR_LIQITEMCP, 'NR_ANO', itemXmlF('NR_ANO', pParams));
        putitem_e(tFGR_LIQITEMCP, 'NR_ENDOSSO', itemXmlF('NR_endOSSO', pParams));
        putitem_e(tFGR_LIQITEMCP, 'NR_SEQAUTO', itemXmlF('NR_SEQAUTO', pParams));
        putitem_e(tFGR_LIQITEMCP, 'DT_AUTORIZACAO', itemXml('DT_AUTORIZACAO', pParams));
        putitem_e(tFGR_LIQITEMCP, 'NR_SEQCHEQUE', itemXmlF('NR_SEQCHEQUE', pParams));
        putitem_e(tFGR_LIQITEMCP, 'NR_CTAPES', itemXmlF('NR_CTAPES', pParams));
        putitem_e(tFGR_LIQITEMCP, 'NR_SEQFOR', itemXmlF('NR_SEQFOR', pParams));
      end else begin
Result := SetStatus(STS_ERROR, 'GEN0001', 'Itens da liquidação não encontrada!', cDS_METHOD);
const
  Result := SetStatus(STS_ERROR, 'GEN0001', 'Itens da liquidação não encontrada!', cDS_METHOD);
begin
        return(-1); exit;
      end;
    end;
  end;
  if (vInAtualiza <> 'N') then begin
    putitem_e(tFGR_LIQ, 'VL_TOTAL', item_f('VL_TOTAL', tFGR_LIQ) + vVlPago);
  end;
  putitem_e(tFGR_LIQ, 'CD_OPERADOR', itemXmlF('CD_USUARIO', PARAM_GLB));
  putitem_e(tFGR_LIQ, 'DT_CADASTRO', Now);
  putitem_e(tFGR_LIQITEMCP, 'NR_SEQAUTO', itemXmlF('NR_SEQAUTO', pParams));
  putitem_e(tFGR_LIQITEMCP, 'DT_AUTORIZACAO', itemXml('DT_AUTORIZACAO', pParams));
  putitem_e(tFGR_LIQITEMCP, 'NR_SEQCHEQUE', itemXmlF('NR_SEQCHEQUE', pParams));
  putitem_e(tFGR_LIQITEMCP, 'NR_CTAPES', itemXmlF('NR_CTAPES', pParams));
  putitem_e(tFGR_LIQITEMCP, 'VL_PAGO', item_f('VL_PAGO', tFGR_LIQITEMCP) + vVlPago);
  putitem_e(tFGR_LIQITEMCP, 'NR_SEQFOR', itemXmlF('NR_SEQFOR', pParams));
  putitem_e(tFGR_LIQITEMCP, 'CD_OPERADOR', itemXmlF('CD_USUARIO', PARAM_GLB));
  putitem_e(tFGR_LIQITEMCP, 'DT_CADASTRO', Now);

  voParams := tFGR_LIQ.Salvar();
  if (xStatus < 0) then begin
    Result := voParams;
    return(-1); exit;
  end;

  return(0); exit;
end;

//-------------------------------------------------------------
function T_FGRSVCO001.atualizaLiqCC(pParams : String) : String;
//-------------------------------------------------------------
const
  cDS_METHOD = 'ADICONAL=Operação: T_FGRSVCO001.atualizaLiqCC()';
begin
  if (itemXml('CD_EMPLIQ', pParams) = '') then begin
    Result := SetStatus(STS_ERROR, 'GEN001', 'Falta o código da empresa da liquidação, '');
    return(-1); exit;
  end;
  if (itemXml('DT_LIQ', pParams) = '') then begin
    Result := SetStatus(STS_ERROR, 'GEN001', 'Falta a data da liquidação, '');
    return(-1); exit;
  end;
  if (itemXml('NR_SEQLIQ', pParams) = '') then begin
    Result := SetStatus(STS_ERROR, 'GEN001', 'Falta a sequencia da liquidação, '');
    return(-1); exit;
  end;
  if (itemXml('NR_SEQDUPLICATA', pParams) = '') then begin
    Result := SetStatus(STS_ERROR, 'GEN001', 'Falta a sequencia da duplicata, '');
    return(-1); exit;
  end;

  clear_e(tFGR_LIQITEMCC);
  putitem_e(tFGR_LIQITEMCC, 'CD_EMPLIQ', itemXmlF('CD_EMPLIQ', pParams));
  putitem_e(tFGR_LIQITEMCC, 'DT_LIQ', itemXml('DT_LIQ', pParams));
  putitem_e(tFGR_LIQITEMCC, 'NR_SEQLIQ', itemXmlF('NR_SEQLIQ', pParams));
  putitem_e(tFGR_LIQITEMCC, 'NR_SEQITEM', itemXmlF('NR_SEQDUPLICATA', pParams));
  retrieve_e(tFGR_LIQITEMCC);
  if (xStatus < 0) then begin
    if (xStatus = -2) then begin
      clear_e(tFGR_LIQITEMCC);
      creocc(tFGR_LIQITEMCC, -1);
      putitem_e(tFGR_LIQITEMCC, 'CD_EMPLIQ', itemXmlF('CD_EMPLIQ', pParams));
      putitem_e(tFGR_LIQITEMCC, 'DT_LIQ', itemXml('DT_LIQ', pParams));
      putitem_e(tFGR_LIQITEMCC, 'NR_SEQLIQ', itemXmlF('NR_SEQLIQ', pParams));
      putitem_e(tFGR_LIQITEMCC, 'NR_SEQITEM', itemXmlF('NR_SEQDUPLICATA', pParams));
      putitem_e(tFGR_LIQITEMCC, 'TP_SUBLIQ', itemXmlF('TP_SUBLIQ', pParams));
      putitem_e(tFGR_LIQITEMCC, 'CD_EMPRESADUP', itemXmlF('CD_EMPRESADUP', pParams));
      putitem_e(tFGR_LIQITEMCC, 'CD_FORNECDUP', itemXmlF('CD_FORNECDUP', pParams));
      putitem_e(tFGR_LIQITEMCC, 'NR_DUPLICATADUP', itemXmlF('NR_DUPLICATADUP', pParams));
      putitem_e(tFGR_LIQITEMCC, 'NR_PARCELADUP', itemXmlF('NR_PARCELADUP', pParams));
      putitem_e(tFGR_LIQITEMCC, 'VL_PAGAMENTO', itemXmlF('VL_PAGO', pParams));
      putitem_e(tFGR_LIQITEMCC, 'DT_CADASTRO', Now);
      putitem_e(tFGR_LIQITEMCC, 'CD_OPERADOR', itemXmlF('CD_USUARIO', PARAM_GLB));
    end else begin
Result := SetStatus(STS_ERROR, 'GEN0001', 'Itens da liquidação não encontrada!', cDS_METHOD);
const
  Result := SetStatus(STS_ERROR, 'GEN0001', 'Itens da liquidação não encontrada!', cDS_METHOD);
begin
      return(-1); exit;
    end;
  end;

  voParams := tFGR_LIQITEMCC.Salvar();
  if (xStatus < 0) then begin
    Result := voParams;
    return(-1); exit;
  end;

  return(0); exit;
end;

//--------------------------------------------------------------------
function T_FGRSVCO001.atualizaAdiantSobras(pParams : String) : String;
//--------------------------------------------------------------------
const
  cDS_METHOD = 'ADICONAL=Operação: T_FGRSVCO001.atualizaAdiantSobras()';
begin
  if (itemXml('CD_EMPLIQ', pParams) = '') then begin
    Result := SetStatus(STS_ERROR, 'GEN001', 'Falta o código da empresa da liquidação, '');
    return(-1); exit;
  end;
  if (itemXml('DT_LIQ', pParams) = '') then begin
    Result := SetStatus(STS_ERROR, 'GEN001', 'Falta a data da liquidação, '');
    return(-1); exit;
  end;
  if (itemXml('NR_SEQLIQ', pParams) = '') then begin
    Result := SetStatus(STS_ERROR, 'GEN001', 'Falta a sequencia da liquidação, '');
    return(-1); exit;
  end;
  if (itemXml('IN_EXCLUIR', pParams) = True) then begin
    clear_e(tFGR_LIQITEMCP);
    putitem_e(tFGR_LIQITEMCP, 'CD_EMPLIQ', itemXmlF('CD_EMPLIQ', pParams));
    putitem_e(tFGR_LIQITEMCP, 'DT_LIQ', itemXml('DT_LIQ', pParams));
    putitem_e(tFGR_LIQITEMCP, 'NR_SEQLIQ', itemXmlF('NR_SEQLIQ', pParams));
    putitem_e(tFGR_LIQITEMCP, 'NR_SEQITEM', itemXmlF('NR_SEQEXCLUIR', pParams));
    retrieve_e(tFGR_LIQITEMCP);
    if (xStatus < 0) then begin
      Result := SetStatus(STS_ERROR, 'GEN001', 'Lançamento de adiantamento não encontrado, '');
      return(-1); exit;
    end;
    voParams := tFGR_LIQITEMCP.Excluir();
    if (xStatus < 0) then begin
      Result := voParams;
      return(-1); exit;
    end;
  end;

  creocc(tFGR_LIQITEMCP, -1);
  putitem_e(tFGR_LIQITEMCP, 'CD_EMPLIQ', itemXmlF('CD_EMPLIQ', pParams));
  putitem_e(tFGR_LIQITEMCP, 'DT_LIQ', itemXml('DT_LIQ', pParams));
  putitem_e(tFGR_LIQITEMCP, 'NR_SEQLIQ', itemXmlF('NR_SEQLIQ', pParams));
  putitem_e(tFGR_LIQITEMCP, 'NR_SEQITEM', itemXmlF('NR_SEQITEM', pParams));
  putitem_e(tFGR_LIQITEMCP, 'TP_LIQITEMCP', itemXmlF('TP_LIQITEMCP', pParams));
  putitem_e(tFGR_LIQITEMCP, 'CD_EMPENDOSSO', itemXmlF('CD_EMPendOSSO', pParams));
  putitem_e(tFGR_LIQITEMCP, 'NR_ANO', itemXmlF('NR_ANO', pParams));
  putitem_e(tFGR_LIQITEMCP, 'NR_ENDOSSO', itemXmlF('NR_endOSSO', pParams));
  putitem_e(tFGR_LIQITEMCP, 'NR_CTAPES', itemXmlF('NR_CTAPES', pParams));
  putitem_e(tFGR_LIQITEMCP, 'NR_SEQFOR', itemXmlF('NR_SEQFOR', pParams));
  putitem_e(tFGR_LIQITEMCP, 'VL_PAGO', itemXmlF('VL_PAGO', pParams));
  putitem_e(tFGR_LIQITEMCP, 'CD_OPERADOR', itemXmlF('CD_USUARIO', PARAM_GLB));
  putitem_e(tFGR_LIQITEMCP, 'DT_CADASTRO', Now);

  voParams := tFGR_LIQITEMCP.Salvar();
  if (xStatus < 0) then begin
    Result := voParams;
    return(-1); exit;
  end;

  return(0); exit;
end;

//-------------------------------------------------------------------
function T_FGRSVCO001.pagamentoEmDinheiro(pParams : String) : String;
//-------------------------------------------------------------------
const
  cDS_METHOD = 'ADICONAL=Operação: T_FGRSVCO001.pagamentoEmDinheiro()';
var
  vDuplicatas, viParams, voParams, vDsLinha : String;
  vCont, vNrSeqDuplicata : Real;
begin
  vDuplicatas := itemXml('DS_DUPLICATAS', pParams);
  vNrSeqDuplicata := itemXmlF('NR_SEQDUPLICATA', pParams);
  viParams := pParams;
  voParams := atualizaLiq(viParams); (* PARAM_GLB, viParams, voParams, xCdErro, xCtxErro *)
  if (xStatus < 0) then begin
    Result := voParams;
    return(-1); exit;
  end;
  if (vDuplicatas <> '') then begin
    vCont := 1;
    viParams := '';

    repeat

      getitem(vDsLinha, vDuplicatas, 1);

      clear_e(tFCP_DUPLICATI);
      putitem_e(tFCP_DUPLICATI, 'CD_EMPRESA', itemXmlF('CD_EMPRESA', vDsLinha));
      putitem_e(tFCP_DUPLICATI, 'CD_FORNECEDOR', itemXmlF('CD_FORNECEDOR', vDsLinha));
      putitem_e(tFCP_DUPLICATI, 'NR_DUPLICATA', itemXmlF('NR_DUPLICATA', vDsLinha));
      putitem_e(tFCP_DUPLICATI, 'NR_PARCELA', itemXmlF('NR_PARCELA', vDsLinha));
      retrieve_e(tFCP_DUPLICATI);
      if (xStatus >= 0) then begin
        message/hint 'Baixando duplicatas pagas em dinheiro: ' + nr_duplicata + '.FCP_DUPLICATI / ' + nr_parcela + '.FCP_DUPLICATI';
        putitem_e(tFCP_DUPLICATI, 'VL_PAGO', itemXmlF('VL_PAGAMENTO', vDsLinha));
        putitem_e(tFCP_DUPLICATI, 'VL_DESCONTO', itemXmlF('VL_DESCONTOS', vDsLinha));
        putitem_e(tFCP_DUPLICATI, 'DT_BAIXA', itemXml('DT_SISTEMA', PARAM_GLB));
        putitem_e(tFCP_DUPLICATI, 'CD_OPERBAIXA', itemXmlF('CD_USUARIO', PARAM_GLB));
        putitem_e(tFCP_DUPLICATI, 'CD_EMPLIQ', itemXmlF('CD_EMPLIQ', pParams));
        putitem_e(tFCP_DUPLICATI, 'DT_LIQ', itemXml('DT_LIQ', pParams));
        putitem_e(tFCP_DUPLICATI, 'NR_SEQLIQ', itemXmlF('NR_SEQLIQ', pParams));
        putitem_e(tFCP_DUPLICATI, 'TP_ESTAGIO', 10);

        voParams := tFCP_DUPLICATISVCSALVAR;.Salvar();
        if (xStatus < 0) then begin
          Result := voParams;
          return(-1); exit;
        end;
          if (xStatus < 0) then begin
            Result := voParams;
            return(-1); exit;
          end;
          vNrSeqDuplicata := vNrSeqDuplicata + 1;
        end;
      end;
      vCont := vCont + 1;

      delitem(vDuplicatas, 1);
    until (vDuplicatas = '');
  end;
  message/hint '';

  return(0); exit;
end;

//----------------------------------------------------------------------
function T_FGRSVCO001.atualizaFaturasCheques(pParams : String) : String;
//----------------------------------------------------------------------
const
  cDS_METHOD = 'ADICONAL=Operação: T_FGRSVCO001.atualizaFaturasCheques()';
var
  vFaturasCheques, vDsLinha : String;
  vCont, vContAtu : Real;
begin
  vFaturasCheques := itemXml('FATURASCHEQUES', pParams);
  vCont := 1;
  VContAtu := itemXmlF('NR_SEQCHEQUES', pParams);
  repeat

    getitem(vDsLinha, vFaturasCheques, 1);

    clear_e(tFCR_FATURAI);
    putitem_e(tFCR_FATURAI, 'CD_EMPRESA', itemXmlF('CD_EMPRESA', vDsLinha));
    putitem_e(tFCR_FATURAI, 'CD_CLIENTE', itemXmlF('CD_CLIENTE', vDsLinha));
    putitem_e(tFCR_FATURAI, 'NR_FAT', itemXmlF('NR_FAT', vDsLinha));
    putitem_e(tFCR_FATURAI, 'NR_PARCELA', itemXmlF('NR_PARCELA', vDsLinha));
    retrieve_e(tFCR_FATURAI);
    if (xStatus >= 0) then begin
      message/hint 'Gravando cheques do endosso: ' + nr_fat + '.FCR_FATURAI / ' + nr_parcela + '.FCR_FATURAI';

      putitem_e(tFCR_FATURAI, 'NR_PORTADOR', itemXml('NEW_PORTADOR', pParams));
      putitem_e(tFCR_FATURAI, 'TP_COBRANCA', 13);
      putitem_e(tFCR_FATURAI, 'CD_OPERADOR', itemXmlF('CD_USUARIO', PARAM_GLB));
      putitem_e(tFCR_FATURAI, 'DT_CADASTRO', Now);

      voParams := tFCR_FATURAISVCSALVAR;.Salvar();
      if (xStatus < 0) then begin
        Result := voParams;
        return(-1); exit;
      end;
        voParams := tFGR_LIQITEMCR.Salvar();
        if (xStatus < 0) then begin
          Result := voParams;
          return(-1); exit;
        end;
      end;
    end;
    vCont := vCont + 1;
    vContAtu := vContAtu + 1;

    delitem(vFaturasCheques, 1);
  until (vFaturasCheques = '');
  putitemXml(Result, 'NR_SEQCHEQUES', vContAtu);
  message/hint '';

  return(0); exit;
end;

//------------------------------------------------------------------------
function T_FGRSVCO001.atualizaDuplicataendosso(pParams : String) : String;
//------------------------------------------------------------------------
const
  cDS_METHOD = 'ADICONAL=Operação: T_FGRSVCO001.atualizaDuplicataendosso()';
var
  viParams, voParams, vDupOriginal, vDsDuplicatas, vpiValores : String;
  vDsLinha, vDsRegImp, vDsRegDesp, vDsLinhaDesp, vDsLinhaImp, vDsDespesa, vDsImposto : String;
  vVlAdiantamento, vVlDuplicatas, vVlFaturas, vVlDup, vVlDiferencaDup, vNrParcela, vNrParcelaAux : Real;
  vVlPagoemDinheiro, vVlPagoemChequeTer, vVlPagoemAdiantamento, vVlPagoemChequePro, vNrSeqDuplicata : Real;
  vVlPago, vVlMaximoDin, vVlMinimoChe : Real;
  vInGerouQuebra : Boolean;
begin
  vVlAdiantamento := itemXmlF('VL_ADIANTAMENTO', pParams);
  vVlDuplicatas := itemXmlF('VL_DUPLICATAS', pParams);
  vVlFaturas := itemXmlF('VL_FATURAS', pParams);
  vDsDuplicatas := itemXml('DS_DUPLICATAS', pParams);
  vVlPagoemAdiantamento := itemXmlF('VL_PAGOEMADIANTAMENTO', pParams);
  vVlPagoemDinheiro := itemXmlF('VL_PAGOEMDINHEIRO', pParams);
  vVlPagoemChequeTer := itemXmlF('VL_PAGOEMCHEQUETER', pParams);
  vVlPagoemChequePro := itemXmlF('VL_PAGOEMCHEQUEPRO', pParams);
  vInGerouQuebra := False;
  gCdctapescxfilial := itemXmlF('CD_CTAPESCXFILIAL', pParams);
  vNrSeqDuplicata := itemXmlF('NR_SEQDUPLICATA', pParams);

  vVlPago := itemXmlF('VL_PAGO', pParams);
  vVlMaximoDin := itemXmlF('VL_MAXIMODIN', pParams);
  vVlMinimoChe := itemXmlF('VL_MINIMOCHE', pParams);

  clear_e(tFCP_DUPLICATI);
  putitem_e(tFCP_DUPLICATI, 'CD_EMPRESA', itemXmlF('CD_EMPRESA', pParams));
  putitem_e(tFCP_DUPLICATI, 'CD_FORNECEDOR', itemXmlF('CD_FORNECEDOR', pParams));
  putitem_e(tFCP_DUPLICATI, 'NR_DUPLICATA', itemXmlF('NR_DUPLICATA', pParams));
  putitem_e(tFCP_DUPLICATI, 'NR_PARCELA', itemXmlF('NR_PARCELA', pParams));
  retrieve_e(tFCP_DUPLICATI);
  if (xStatus < 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN001', 'Duplicata não encontrada, '');
    return(-1); exit;
  end;

  message/hint 'Gravando duplicatas do endosso: ' + nr_duplicata + '.FCP_DUPLICATI / ' + nr_parcela + '.FCP_DUPLICATI';
  if ((vVlAdiantamento + vVlFaturas) >= vVlPago) then begin
    putitem_e(tFCP_DUPLICATI, 'CD_EMPLIQ', itemXmlF('CD_EMPLIQ', pParams));
    putitem_e(tFCP_DUPLICATI, 'DT_LIQ', itemXml('DT_LIQ', pParams));
    putitem_e(tFCP_DUPLICATI, 'NR_SEQLIQ', itemXmlF('NR_SEQLIQ', pParams));
    putitem_e(tFCP_DUPLICATI, 'VL_PAGO', itemXmlF('VL_PAGO', pParams));
    putitem_e(tFCP_DUPLICATI, 'VL_JUROS', itemXmlF('VL_JUROS', pParams));
    putitem_e(tFCP_DUPLICATI, 'VL_DESCONTO', itemXmlF('VL_DESCONTOS', pParams));
    putitem_e(tFCP_DUPLICATI, 'DT_BAIXA', itemXml('DT_SISTEMA', PARAM_GLB));
    putitem_e(tFCP_DUPLICATI, 'CD_OPERBAIXA', itemXmlF('CD_USUARIO', PARAM_GLB));
    putitem_e(tFCP_DUPLICATI, 'TP_BAIXA', 2);
    putitem_e(tFCP_DUPLICATI, 'TP_ESTAGIO', 10);

    voParams := tFCP_DUPLICATI.Salvar();
    if (xStatus < 0) then begin
      Result := voParams;
      return(-1); exit;
    end;

    vVlDup := itemXmlF('VL_PAGO', pParams);

    if (vVlAdiantamento > 0) then begin
      viParams := '';
      putitemXml(viParams, 'CD_EMPLIQ', itemXmlF('CD_EMPLIQ', pParams));
      putitemXml(viParams, 'DT_LIQ', itemXml('DT_LIQ', pParams));
      putitemXml(viParams, 'NR_SEQLIQ', itemXmlF('NR_SEQLIQ', pParams));
      putitemXml(viParams, 'NR_SEQFOR', itemXmlF('NR_SEQFOR', pParams));
      putitemXml(viParams, 'TP_LIQUIDACAO', 8);
      putitemXml(viParams, 'NR_SEQITEM', 1);
      putitemXml(viParams, 'TP_LIQITEMCP', 4);
      putitemXml(viParams, 'NR_CTAPES', itemXmlF('NR_CTAPES', pParams));
      putitemXml(viParams, 'CD_EMPendOSSO', itemXmlF('CD_EMPendOSSO', pParams));
      putitemXml(viParams, 'NR_ANO', itemXmlF('NR_ANO', pParams));
      putitemXml(viParams, 'NR_endOSSO', itemXmlF('NR_endOSSO', pParams));

      if (vVlAdiantamento <= vVlDup) then begin
        putitemXml(viParams, 'VL_PAGO', vVlAdiantamento);
        vVlDup := vVlDup - vVlAdiantamento;
        vVlAdiantamento := 0;
      end else begin
        putitemXml(viParams, 'VL_PAGO', vVlDup);
        vVlAdiantamento := vVlAdiantamento - vVlDup;
        vVlDup := 0;
      end;
      vVlPagoemAdiantamento := vVlPagoemAdiantamento + itemXmlF('VL_PAGO', viParams);

      voParams := atualizaLiq(viParams); (* PARAM_GLB, viParams, voParams, xCdErro, xCtxErro *)
      if (xStatus < 0) then begin
        Result := voParams;
        return(-1); exit;
      end;
    end;
    if (vVldup > 0) then begin
      viParams := '';
      putitemXml(viParams, 'CD_EMPLIQ', itemXmlF('CD_EMPLIQ', pParams));
      putitemXml(viParams, 'DT_LIQ', itemXml('DT_LIQ', pParams));
      putitemXml(viParams, 'NR_SEQLIQ', itemXmlF('NR_SEQLIQ', pParams));
      putitemXml(viParams, 'NR_SEQFOR', itemXmlF('NR_SEQFOR', pParams));
      putitemXml(viParams, 'TP_LIQUIDACAO', 8);
      putitemXml(viParams, 'NR_SEQITEM', 2);
      putitemXml(viParams, 'TP_LIQITEMCP', 3);
      putitemXml(viParams, 'CD_EMPendOSSO', itemXmlF('CD_EMPendOSSO', pParams));
      putitemXml(viParams, 'NR_ANO', itemXmlF('NR_ANO', pParams));
      putitemXml(viParams, 'NR_endOSSO', itemXmlF('NR_endOSSO', pParams));
      putitemXml(viParams, 'VL_PAGO', vVlDup);

      if (vVlFaturas <= vVlDup) then begin
        putitemXml(viParams, 'VL_PAGO', vVlFaturas);
        vVlDup := vVlDup - vVlFaturas;
        vVlFaturas := 0;
      end else begin
        putitemXml(viParams, 'VL_PAGO', vVlDup);
        vVlFaturas := vVlFaturas - vVlDup;
      end;
      vVlPagoemChequeTer := vVlPagoemChequeTer + itemXmlF('VL_PAGO', viParams);

      voParams := atualizaLiq(viParams); (* PARAM_GLB, viParams, voParams, xCdErro, xCtxErro *)
      if (xStatus < 0) then begin
        Result := voParams;
        return(-1); exit;
      end;
    end;

    viParams := '';
    putitemXml(viParams, 'CD_EMPLIQ', itemXmlF('CD_EMPLIQ', pParams));
    putitemXml(viParams, 'DT_LIQ', itemXml('DT_LIQ', pParams));
    putitemXml(viParams, 'NR_SEQLIQ', itemXmlF('NR_SEQLIQ', pParams));
    putitemXml(viParams, 'NR_SEQDUPLICATA', itemXmlF('NR_SEQDUPLICATA', pParams));
    putitemXml(viParams, 'TP_SUBLIQ', 2);
    putitemXml(viParams, 'NR_SEQFOR', itemXmlF('NR_SEQFOR', pParams));
    putitemXml(viParams, 'CD_EMPRESADUP', item_f('CD_EMPRESA', tFCP_DUPLICATI));
    putitemXml(viParams, 'CD_FORNECDUP', item_f('CD_FORNECEDOR', tFCP_DUPLICATI));
    putitemXml(viParams, 'NR_DUPLICATADUP', item_f('NR_DUPLICATA', tFCP_DUPLICATI));
    putitemXml(viParams, 'NR_PARCELADUP', item_f('NR_PARCELA', tFCP_DUPLICATI));
    putitemXml(viParams, 'VL_PAGO', item_f('VL_PAGO', tFCP_DUPLICATI));
    voParams := atualizaLiqCC(viParams); (* PARAM_GLB, viParams, voParams, xCdErro, xCtxErro *)
    if (xStatus < 0) then begin
      Result := voParams;
      return(-1); exit;
    end;
    vNrSeqDuplicata := vNrSeqDuplicata + 1;
  end else begin
    vVlDup := itemXmlF('VL_PAGO', pParams);
    if (vVlAdiantamento > 0) then begin
      viParams := '';
      putitemXml(viParams, 'CD_EMPLIQ', itemXmlF('CD_EMPLIQ', pParams));
      putitemXml(viParams, 'DT_LIQ', itemXml('DT_LIQ', pParams));
      putitemXml(viParams, 'NR_SEQLIQ', itemXmlF('NR_SEQLIQ', pParams));
      putitemXml(viParams, 'NR_SEQFOR', itemXmlF('NR_SEQFOR', pParams));
      putitemXml(viParams, 'TP_LIQUIDACAO', 8);
      putitemXml(viParams, 'NR_SEQITEM', 1);
      putitemXml(viParams, 'TP_LIQITEMCP', 4);
      putitemXml(viParams, 'NR_CTAPES', itemXmlF('NR_CTAPES', pParams));
      putitemXml(viParams, 'CD_EMPendOSSO', itemXmlF('CD_EMPendOSSO', pParams));
      putitemXml(viParams, 'NR_ANO', itemXmlF('NR_ANO', pParams));
      putitemXml(viParams, 'NR_endOSSO', itemXmlF('NR_endOSSO', pParams));

      if (vVlAdiantamento <= vVlDup) then begin
        putitemXml(viParams, 'VL_PAGO', vVlAdiantamento);
        vVlDup := vVlDup - vVlAdiantamento;
        vVlAdiantamento := 0;
      end else begin
        putitemXml(viParams, 'VL_PAGO', vVlDup);
        vVlAdiantamento := vVlAdiantamento - vVlDup;
      end;
      vVlPagoemAdiantamento := vVlPagoemAdiantamento + itemXmlF('VL_PAGO', viParams);

      voParams := atualizaLiq(viParams); (* PARAM_GLB, viParams, voParams, xCdErro, xCtxErro *)
      if (xStatus < 0) then begin
        Result := voParams;
        return(-1); exit;
      end;
    end;
    if (vVldup > 0) then begin
      if (vVlFaturas > 0) then begin
        viParams := '';
        putitemXml(viParams, 'CD_EMPLIQ', itemXmlF('CD_EMPLIQ', pParams));
        putitemXml(viParams, 'DT_LIQ', itemXml('DT_LIQ', pParams));
        putitemXml(viParams, 'NR_SEQLIQ', itemXmlF('NR_SEQLIQ', pParams));
        putitemXml(viParams, 'NR_SEQFOR', itemXmlF('NR_SEQFOR', pParams));
        putitemXml(viParams, 'TP_LIQUIDACAO', 8);
        putitemXml(viParams, 'NR_SEQITEM', 2);
        putitemXml(viParams, 'TP_LIQITEMCP', 3);
        putitemXml(viParams, 'CD_EMPendOSSO', itemXmlF('CD_EMPendOSSO', pParams));
        putitemXml(viParams, 'NR_ANO', itemXmlF('NR_ANO', pParams));
        putitemXml(viParams, 'NR_endOSSO', itemXmlF('NR_endOSSO', pParams));

        if (vVlFaturas <= vVlDup) then begin
          putitemXml(viParams, 'VL_PAGO', vVlFaturas);
          vVlDup := vVlDup - vVlFaturas;
          vVlFaturas := 0;
        end else begin
          putitemXml(viParams, 'VL_PAGO', vVlDup);
          vVlFaturas := vVlFaturas - vVlDup;
        end;

        voParams := atualizaLiq(viParams); (* PARAM_GLB, viParams, voParams, xCdErro, xCtxErro *)
        if (xStatus < 0) then begin
          Result := voParams;
          return(-1); exit;
        end;
        vVlPagoemChequeTer := vVlPagoemChequeTer + itemXmlF('VL_PAGO', viParams);
      end;
    end;
    if (vVlDup = 0) then begin
      putitem_e(tFCP_DUPLICATI, 'CD_EMPLIQ', itemXmlF('CD_EMPLIQ', pParams));
      putitem_e(tFCP_DUPLICATI, 'DT_LIQ', itemXml('DT_LIQ', pParams));
      putitem_e(tFCP_DUPLICATI, 'NR_SEQLIQ', itemXmlF('NR_SEQLIQ', pParams));
      putitem_e(tFCP_DUPLICATI, 'VL_PAGO', itemXmlF('VL_PAGO', pParams));
      putitem_e(tFCP_DUPLICATI, 'VL_JUROS', itemXmlF('VL_JUROS', pParams));
      putitem_e(tFCP_DUPLICATI, 'VL_DESCONTO', itemXmlF('VL_DESCONTOS', pParams));
      putitem_e(tFCP_DUPLICATI, 'DT_BAIXA', itemXml('DT_SISTEMA', PARAM_GLB));
      putitem_e(tFCP_DUPLICATI, 'CD_OPERBAIXA', itemXmlF('CD_USUARIO', PARAM_GLB));
      putitem_e(tFCP_DUPLICATI, 'TP_BAIXA', 2);
      putitem_e(tFCP_DUPLICATI, 'TP_ESTAGIO', 10);

      voParams := tFCP_DUPLICATI.Salvar();
      if (xStatus < 0) then begin
        Result := voParams;
        return(-1); exit;
      end;

      viParams := '';
      putitemXml(viParams, 'CD_EMPLIQ', itemXmlF('CD_EMPLIQ', pParams));
      putitemXml(viParams, 'DT_LIQ', itemXml('DT_LIQ', pParams));
      putitemXml(viParams, 'NR_SEQLIQ', itemXmlF('NR_SEQLIQ', pParams));
      putitemXml(viParams, 'NR_SEQDUPLICATA', itemXmlF('NR_SEQDUPLICATA', pParams));
      putitemXml(viParams, 'TP_SUBLIQ', 2);
      putitemXml(viParams, 'NR_SEQFOR', itemXmlF('NR_SEQFOR', pParams));
      putitemXml(viParams, 'CD_EMPRESADUP', item_f('CD_EMPRESA', tFCP_DUPLICATI));
      putitemXml(viParams, 'CD_FORNECDUP', item_f('CD_FORNECEDOR', tFCP_DUPLICATI));
      putitemXml(viParams, 'NR_DUPLICATADUP', item_f('NR_DUPLICATA', tFCP_DUPLICATI));
      putitemXml(viParams, 'NR_PARCELADUP', item_f('NR_PARCELA', tFCP_DUPLICATI));
      putitemXml(viParams, 'VL_PAGO', item_f('VL_PAGO', tFCP_DUPLICATI));
      voParams := atualizaLiqCC(viParams); (* PARAM_GLB, viParams, voParams, xCdErro, xCtxErro *)
      if (xStatus < 0) then begin
        Result := voParams;
        return(-1); exit;
      end;
      vNrSeqDuplicata := vNrSeqDuplicata + 1;
    end else begin

      if (vVlDup <> vVlPago) then begin
        viParams := '';
        vVlDiferencaDup := vVlPago - vVlDup;
        vNrParcelaAux := item_f('NR_PARCELA', tFCP_DUPLICATI);
        putitemXml(viParams, 'CD_EMPLIQ', itemXmlF('CD_EMPLIQ', pParams));
        putitemXml(viParams, 'DT_LIQ', itemXml('DT_LIQ', pParams));
        putitemXml(viParams, 'NR_SEQLIQ', itemXmlF('NR_SEQLIQ', pParams));
        putitemXml(viParams, 'VL_JUROS', itemXmlF('VL_JUROS', pParams));
        putitemXml(viParams, 'VL_DESCONTOS', itemXmlF('VL_DESCONTOS', pParams));
        putitemXml(viParams, 'VL_PAGO', vVlDiferencaDup);
        putitemXml(viParams, 'VL_RESTANTE', vVlDup);
        putitemXml(viParams, 'IN_DINHEIRO', itemXmlB('IN_DINHEIRO', pParams));
        putitemXml(viParams, 'VL_MAXIMODIN', itemXmlF('VL_MAXIMODIN', pParams));

        voParams := baixaDuplicataParcial(viParams); (* PARAM_GLB, viParams, voParams, xCdErro, xCtxErro *)
        if (xStatus < 0) then begin
          Result := voParams;
          return(-1); exit;
        end;

        viParams := '';
        putitemXml(viParams, 'CD_EMPLIQ', itemXmlF('CD_EMPLIQ', pParams));
        putitemXml(viParams, 'DT_LIQ', itemXml('DT_LIQ', pParams));
        putitemXml(viParams, 'NR_SEQLIQ', itemXmlF('NR_SEQLIQ', pParams));
        putitemXml(viParams, 'NR_SEQDUPLICATA', itemXmlF('NR_SEQDUPLICATA', pParams));
        putitemXml(viParams, 'TP_SUBLIQ', 2);
        putitemXml(viParams, 'NR_SEQFOR', itemXmlF('NR_SEQFOR', pParams));
        putitemXml(viParams, 'CD_EMPRESADUP', item_f('CD_EMPRESA', tFCP_DUPLICATI));
        putitemXml(viParams, 'CD_FORNECDUP', item_f('CD_FORNECEDOR', tFCP_DUPLICATI));
        putitemXml(viParams, 'NR_DUPLICATADUP', item_f('NR_DUPLICATA', tFCP_DUPLICATI));
        putitemXml(viParams, 'NR_PARCELADUP', vNrParcelaAux);
        putitemXml(viParams, 'VL_PAGO', vVlDiferencaDup);
        voParams := atualizaLiqCC(viParams); (* PARAM_GLB, viParams, voParams, xCdErro, xCtxErro *)
        if (xStatus < 0) then begin
          Result := voParams;
          return(-1); exit;
        end;

        vDsLinha := '';
        putitemXml(vDsLinha, 'CD_EMPRESA', item_f('CD_EMPRESA', tFCP_DUPLICATI));
        putitemXml(vDslinha, 'CD_FORNECEDOR', item_f('CD_FORNECEDOR', tFCP_DUPLICATI));
        putitemXml(vDsLinha, 'NR_DUPLICATA', item_f('NR_DUPLICATA', tFCP_DUPLICATI));
        putitemXml(vDsLinha, 'NR_PARCELA', vNrParcela);
        putitemXml(vDsLinha, 'VL_PAGAMENTO', vVlDup);
        putitemXml(vDsLinha, 'VL_DESCONTOS', itemXmlF('VL_DESCONTOS', pParams));
        putitemXml(vDsLinha, 'VL_JUROS', itemXmlF('VL_JUROS', pParams));
        putitem(vDsDuplicatas,  vDsLinha);

        if (itemXml('IN_DINHEIRO', pParams) = True) then begin
          if (vVlDup <= vVlMaximoDin) then begin
            viParams := '';
            putitemXml(viParams, 'CD_EMPRESA', itemXmlF('CD_EMPRESA', PARAM_GLB));
            putitemXml(viParams, 'NR_CTAPES', gCdctapescxfilial);
            putitemXml(viParams, 'DT_MOVIMENTO', itemXml('DT_SISTEMA', PARAM_GLB));
            putitemXml(viParams, 'TP_DOCUMENTO', 3);
            putitemXml(viParams, 'NR_SEQHISTRELSUB', 1);
            putitemXml(viParams, 'CD_HISTORICO', 904);
            putitemXml(viParams, 'VL_LANCTO', vVlDup);
            putitemXml(viParams, 'IN_ESTORNO', 'N');
            putitemXml(viParams, 'DS_AUX', 'Pagamento de endosso com dinheiro');
            voParams := activateCmp('FCCSVCO002', 'movimentaConta', viParams); (*,viParams,vpiValores,voParams,, *)
            if (xStatus < 0) then begin
              Result := voParams;
              return(-1); exit;
            end;
          end;
        end;
        if (itemXml('IN_CHEQUE', pParams) = True) then begin
          if (vVlDup >= vVlMinimoChe) then begin
            vVlPagoemChequePro := vVlPagoemChequePro + vVlDup;
          end;
        end;
        vNrSeqDuplicata := vNrSeqDuplicata + 1;
      end else begin
        if (itemXml('IN_DINHEIRO', pParams) = True) then begin
          if (vVlPago <= vVlMaximoDin) then begin
            viParams := '';
            putitemXml(viParams, 'CD_EMPRESA', itemXmlF('CD_EMPRESA', PARAM_GLB));
            putitemXml(viParams, 'NR_CTAPES', gCdctapescxfilial);
            putitemXml(viParams, 'DT_MOVIMENTO', itemXml('DT_SISTEMA', PARAM_GLB));
            putitemXml(viParams, 'TP_DOCUMENTO', 3);
            putitemXml(viParams, 'NR_SEQHISTRELSUB', 1);
            putitemXml(viParams, 'CD_HISTORICO', 904);
            putitemXml(viParams, 'VL_LANCTO', itemXmlF('VL_PAGO', pParams));
            putitemXml(viParams, 'IN_ESTORNO', 'N');
            putitemXml(viParams, 'DS_AUX', 'Pagamento de endosso com dinheiro');
            voParams := activateCmp('FCCSVCO002', 'movimentaConta', viParams); (*,viParams,vpiValores,voParams,, *)
            if (xStatus < 0) then begin
              Result := voParams;
              return(-1); exit;
            end;
          end;
        end;
        if (itemXml('IN_CHEQUE', pParams) = True) then begin
          if (vVlPago >= vVlMinimoChe) then begin
            vVlPagoemChequePro := vVlPagoemChequePro + vVlPago;
          end;
        end;

        vDsLinha := '';
        putitemXml(vDsLinha, 'CD_EMPRESA', item_f('CD_EMPRESA', tFCP_DUPLICATI));
        putitemXml(vDslinha, 'CD_FORNECEDOR', item_f('CD_FORNECEDOR', tFCP_DUPLICATI));
        putitemXml(vDsLinha, 'NR_DUPLICATA', item_f('NR_DUPLICATA', tFCP_DUPLICATI));
        putitemXml(vDsLinha, 'NR_PARCELA', item_f('NR_PARCELA', tFCP_DUPLICATI));
        putitemXml(vDsLinha, 'VL_PAGAMENTO', itemXmlF('VL_PAGO', pParams));
        putitemXml(vDsLinha, 'VL_DESCONTOS', itemXmlF('VL_DESCONTOS', pParams));
        putitemXml(vDsLinha, 'VL_JUROS', itemXmlF('VL_JUROS', pParams));
        putitem(vDsDuplicatas,  vDsLinha);
      end;
    end;
  end;

  putitemXml(Result, 'VL_ADIANTAMENTO', vVlAdiantamento);
  putitemXml(Result, 'VL_FATURAS', vVlFaturas);
  putitemXml(Result, 'DS_DUPLICATAS', vDsDuplicatas);
  putitemXml(Result, 'VL_PAGOEMDINHEIRO', vVlPagoemDinheiro);
  putitemXml(Result, 'VL_PAGOEMCHEQUETER', vVlPagoemChequeTer);
  putitemXml(Result, 'VL_PAGOEMCHEQUEPRO', vVlPagoemChequePro);
  putitemXml(Result, 'VL_PAGOEMADIANTAMENTO', vVlPagoemAdiantamento);
  putitemXml(Result, 'NR_SEQDUPLICATA', vNrSeqDuplicata);

  if (vInGerouQuebra = True) then begin
    putitemXml(Result, 'IN_GEROUQUEBRA', True);
    putitemXml(Result, 'VL_PAGO', vVlDiferencaDup);
    putitemXml(Result, 'VL_RESTANTE', vVlDup);
    putitemXml(Result, 'NR_PARCELA', vNrParcela);
  end;
  message/hint '';

  return(0); exit;
end;

//---------------------------------------------------------------------
function T_FGRSVCO001.baixaDuplicataParcial(pParams : String) : String;
//---------------------------------------------------------------------
const
  cDS_METHOD = 'ADICONAL=Operação: T_FGRSVCO001.baixaDuplicataParcial()';
var
  viParams, voParams, vDupOriginal : String;
  vDsLinha, vDsRegImp, vDsRegDesp, vDsLinhaDesp, vDsLinhaImp, vDsDespesa, vDsImposto : String;
  vNrParcela, vVlDuplicataOrig, vVlDiferenca, vVlMaximoDin, vVlMinimoChe : Real;
begin
  viParams := '';

  vVlMaximoDin := itemXmlF('VL_MAXIMODIN', pParams);
  vVlMinimoChe := itemXmlF('VL_MINIMOCHE', pParams);

  clear_e(tFCP_DUPDESPES);
  putitem_e(tFCP_DUPDESPES, 'CD_EMPRESA', item_f('CD_EMPRESA', tFCP_DUPLICATI));
  putitem_e(tFCP_DUPDESPES, 'CD_FORNECEDOR', item_f('CD_FORNECEDOR', tFCP_DUPLICATI));
  putitem_e(tFCP_DUPDESPES, 'NR_DUPLICATA', item_f('NR_DUPLICATA', tFCP_DUPLICATI));
  putitem_e(tFCP_DUPDESPES, 'NR_PARCELA', item_f('NR_PARCELA', tFCP_DUPLICATI));
  retrieve_e(tFCP_DUPDESPES);
  if (xStatus < 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Duplicata vinculada ao cheque sem despesa!', cDS_METHOD);
    return(-1); exit;
  end;

  clear_e(tFCP_DUPIMPOST);
  putitem_e(tFCP_DUPIMPOST, 'CD_EMPRESA', item_f('CD_EMPRESA', tFCP_DUPLICATI));
  putitem_e(tFCP_DUPIMPOST, 'CD_FORNECEDOR', item_f('CD_FORNECEDOR', tFCP_DUPLICATI));
  putitem_e(tFCP_DUPIMPOST, 'NR_DUPLICATA', item_f('NR_DUPLICATA', tFCP_DUPLICATI));
  putitem_e(tFCP_DUPIMPOST, 'NR_PARCELA', item_f('NR_PARCELA', tFCP_DUPLICATI));
  retrieve_e(tFCP_DUPIMPOST);

  putlistitensocc_e(vDupOriginal, tFCP_DUPLICATI);

  vDsRegDesp := '';
  vDsRegImp := '';

  putitem_e(tFCP_DUPLICATI, 'CD_EMPLIQ', itemXmlF('CD_EMPLIQ', pParams));
  putitem_e(tFCP_DUPLICATI, 'DT_LIQ', itemXml('DT_LIQ', pParams));
  putitem_e(tFCP_DUPLICATI, 'NR_SEQLIQ', itemXmlF('NR_SEQLIQ', pParams));
  putitem_e(tFCP_DUPLICATI, 'VL_DUPLICATA', itemXmlF('VL_PAGO', pParams));
  putitem_e(tFCP_DUPLICATI, 'VL_PAGO', itemXmlF('VL_PAGO', pParams));
  putitem_e(tFCP_DUPLICATI, 'DT_BAIXA', Now);
  putitem_e(tFCP_DUPLICATI, 'CD_OPERBAIXA', itemXmlF('CD_USUARIO', PARAM_GLB));
  putitem_e(tFCP_DUPLICATI, 'TP_BAIXA', 2);
  putitem_e(tFCP_DUPLICATI, 'TP_ESTAGIO', 10);

  viParams := '';
  voParams := gravaDuplicata(viParams); (* viParams, voParams, xCdErro, xCtxErro *)
  if (xStatus < 0) then begin
    Result := voParams;
    return(-1); exit;
  end;
  vDsRegDesp := itemXml('DS_REGDESP', voParams);
  vDsRegImp := itemXml('DS_REGIMP', voParams);

  viParams := '';
  putitemXml(viParams, 'CD_EMPRESA', item_f('CD_EMPRESA', tFCP_DUPLICATI));
  putitemXml(viParams, 'CD_FORNECEDOR', item_f('CD_FORNECEDOR', tFCP_DUPLICATI));
  putitemXml(viParams, 'NR_DUPLICATA', item_f('NR_DUPLICATA', tFCP_DUPLICATI));
  putitemXml(viParams, 'NR_PARCELA', item_f('NR_PARCELA', tFCP_DUPLICATI));
  putitemXml(viParams, 'TP_LOGDUP', 5);
  putitemXml(viParams, 'DS_COMPONENTE', 'FGRSVCO001');
  putitemXml(viParams, 'DS_OBS', 'LIQUIDACAO DA DUPLICATA');
  voParams := activateCmp('FCPSVCO001', 'gravaLogDuplicata', viParams); (*,viParams,voParams,, *)
  if (xStatus < 0) then begin
    Result := voParams;
    return(-1); exit;
  end;
  if (itemXml('VL_RESTANTE', pParams) > 0) then begin
    clear_e(tFCP_DUPLICATI);
    clear_e(tFCP_DUPDESPES);
    clear_e(tFCP_DUPIMPOST);

    creocc(tFCP_DUPLICATI, -1);
    getlistitensocc_e(vDupOriginal, tFCP_DUPLICATI);

    viParams := '';

    putitemXml(viParams, 'TP_PARCELA', 2);

    voParams := geraSeqParcela(viParams); (* viParams, voParams, xCdErro, xCtxErro *)
    if (xStatus < 0) then begin
      Result := voParams;
      return(-1); exit;
    end;
    vNrParcela := itemXmlF('NR_PARCELA', voParams);
    putitem_e(tFCP_DUPLICATI, 'VL_DUPLICATA', itemXmlF('VL_RESTANTE', pParams));
    putitem_e(tFCP_DUPLICATI, 'VL_JUROS', itemXmlF('VL_JUROS', pParams));
    putitem_e(tFCP_DUPLICATI, 'VL_DESCONTO', itemXmlF('VL_DESCONTOS', pParams));
    putitem_e(tFCP_DUPLICATI, 'DT_CADASTRO', Now);
    putitem_e(tFCP_DUPLICATI, 'CD_OPERADOR', itemXmlF('CD_USUARIO', PARAM_GLB));
    putitem_e(tFCP_DUPLICATI, 'TP_INCLUSAO', 1);
    putitem_e(tFCP_DUPLICATI, 'NR_PARORIGINAL', item_f('NR_PARCELA', tFCP_DUPLICATI));
    putitem_e(tFCP_DUPLICATI, 'NR_PARCELA', vNrParcela);
    putitem_e(tFCP_DUPLICATI, 'TP_BAIXA', 2);
    putitem_e(tFCP_DUPLICATI, 'TP_ESTAGIO', 10);

    if (itemXml('IN_DINHEIRO', pParams) = True) then begin
      if (item_f('VL_DUPLICATA', tFCP_DUPLICATI) <= vVlMaximoDin) then begin
        putitem_e(tFCP_DUPLICATI, 'VL_PAGO', itemXmlF('VL_RESTANTE', pParams));
        putitem_e(tFCP_DUPLICATI, 'VL_PAGO', item_f('VL_PAGO', tFCP_DUPLICATI) + itemXmlF('VL_JUROS', pParams) - itemXml('VL_DESCONTOS', pParams));
        putitem_e(tFCP_DUPLICATI, 'CD_OPERBAIXA', itemXmlF('CD_USUARIO', PARAM_GLB));
        putitem_e(tFCP_DUPLICATI, 'DT_BAIXA', itemXml('DT_SISTEMA', PARAM_GLB));
      end;
    end;
    if (vDsRegDesp <> '') then begin
      repeat

        getitem(vDsDespesa, vDsRegDesp, 1);
        creocc(tFCP_DUPDESPES, -1);
        getlistitensocc_e(vDsDespesa, tFCP_DUPDESPES);
        putitem_e(tFCP_DUPDESPES, 'NR_PARCELA', vNrParcela);

        delitem(vDsRegDesp, 1);
      until (vDsRegDesp = '');
    end;
    if (vDsRegImp <> '') then begin
      repeat

        getitem(vDsImposto, vDsRegImp, 1);
        creocc(tFCP_DUPIMPOST, -1);
        getlistitensocc_e(vDsImposto, tFCP_DUPIMPOST);
        putitem_e(tFCP_DUPIMPOST, 'NR_PARCELA', vNrParcela);

        delitem(vDsRegImp, 1);
      until (vDsRegImp = '');
    end;

    viParams := '';
    voParams := gravaDuplicata(viParams); (* viParams, voParams, xCdErro, xCtxErro *)
    if (xStatus < 0) then begin
      Result := voParams;
      return(-1); exit;
    end;
  end;
  putitemXml(Result, 'NR_PARCELA', vNrParcela);
  putitemXml(Result, 'VL_PARCELA', item_f('VL_DUPLICATA', tFCP_DUPLICATI));

  return(0); exit;
end;

//-----------------------------------------------------------------
function T_FGRSVCO001.atualizaLiqPagAut(pParams : String) : String;
//-----------------------------------------------------------------
const
  cDS_METHOD = 'ADICONAL=Operação: T_FGRSVCO001.atualizaLiqPagAut()';
var
  vInAtualiza : String;
begin
  if (itemXml('CD_EMPLIQ', pParams) = '') then begin
    Result := SetStatus(STS_ERROR, 'GEN001', 'Falta o código da empresa da liquidação, '');
    return(-1); exit;
  end;
  if (itemXml('DT_LIQ', pParams) = '') then begin
    Result := SetStatus(STS_ERROR, 'GEN001', 'Falta a data da liquidação, '');
    return(-1); exit;
  end;
  if (itemXml('NR_SEQLIQ', pParams) = '') then begin
    Result := SetStatus(STS_ERROR, 'GEN001', 'Falta a sequencia da liquidação, '');
    return(-1); exit;
  end;
  if (itemXml('NR_SEQITEM', pParams) = '') then begin
    Result := SetStatus(STS_ERROR, 'GEN001', 'Falta a sequencia do item da liquidação, '');
    return(-1); exit;
  end;
  vInAtualiza := itemXmlB('IN_ATUALIZA', pParams);

  clear_e(tFGR_LIQ);
  putitem_e(tFGR_LIQ, 'CD_EMPLIQ', itemXmlF('CD_EMPLIQ', pParams));
  putitem_e(tFGR_LIQ, 'DT_LIQ', itemXml('DT_LIQ', pParams));
  putitem_e(tFGR_LIQ, 'NR_SEQLIQ', itemXmlF('NR_SEQLIQ', pParams));
  retrieve_e(tFGR_LIQ);
  if (xStatus < 0) then begin
    if (xStatus = -2) then begin
      clear_e(tFGR_LIQ);
      creocc(tFGR_LIQ, -1);
      putitem_e(tFGR_LIQ, 'CD_EMPLIQ', itemXmlF('CD_EMPLIQ', pParams));
      putitem_e(tFGR_LIQ, 'DT_LIQ', itemXml('DT_LIQ', pParams));
      putitem_e(tFGR_LIQ, 'NR_SEQLIQ', itemXmlF('NR_SEQLIQ', pParams));
      putitem_e(tFGR_LIQ, 'CD_GRUPOEMPRESA', itemXmlF('CD_GRUPOEMPRESA', PARAM_GLB));
      putitem_e(tFGR_LIQ, 'TP_LIQUIDACAO', itemXmlF('TP_LIQUIDACAO', pParams));

      creocc(tFGR_LIQITEMCP, -1);
      putitem_e(tFGR_LIQITEMCP, 'CD_EMPLIQ', itemXmlF('CD_EMPLIQ', pParams));
      putitem_e(tFGR_LIQITEMCP, 'DT_LIQ', itemXml('DT_LIQ', pParams));
      putitem_e(tFGR_LIQITEMCP, 'NR_SEQLIQ', itemXmlF('NR_SEQLIQ', pParams));
      putitem_e(tFGR_LIQITEMCP, 'NR_SEQITEM', itemXmlF('NR_SEQITEM', pParams));
      putitem_e(tFGR_LIQITEMCP, 'TP_LIQITEMCP', itemXmlF('TP_LIQITEMCP', pParams));
      putitem_e(tFGR_LIQITEMCP, 'NR_ANO', itemXmlF('NR_ANO', pParams));
      putitem_e(tFGR_LIQITEMCP, 'NR_SEQAUTO', itemXmlF('NR_SEQAUTO', pParams));
      putitem_e(tFGR_LIQITEMCP, 'NR_CTAPES', itemXmlF('NR_CTAPES', pParams));
    end else begin
Result := SetStatus(STS_ERROR, 'GEN0001', 'Liquidação não encontrada!', cDS_METHOD);
const
  Result := SetStatus(STS_ERROR, 'GEN0001', 'Liquidação não encontrada!', cDS_METHOD);
begin
      return(-1); exit;
    end;
  end else begin
    clear_e(tFGR_LIQITEMCP);
    putitem_e(tFGR_LIQITEMCP, 'CD_EMPLIQ', itemXmlF('CD_EMPLIQ', pParams));
    putitem_e(tFGR_LIQITEMCP, 'DT_LIQ', itemXml('DT_LIQ', pParams));
    putitem_e(tFGR_LIQITEMCP, 'NR_SEQLIQ', itemXmlF('NR_SEQLIQ', pParams));
    putitem_e(tFGR_LIQITEMCP, 'NR_SEQITEM', itemXmlF('NR_SEQITEM', pParams));
    retrieve_e(tFGR_LIQITEMCP);
    if (xStatus < 0) then begin
      if (xStatus = -2) then begin
        clear_e(tFGR_LIQITEMCP);
        creocc(tFGR_LIQITEMCP, -1);
        putitem_e(tFGR_LIQITEMCP, 'CD_EMPLIQ', itemXmlF('CD_EMPLIQ', pParams));
        putitem_e(tFGR_LIQITEMCP, 'DT_LIQ', itemXml('DT_LIQ', pParams));
        putitem_e(tFGR_LIQITEMCP, 'NR_SEQLIQ', itemXmlF('NR_SEQLIQ', pParams));
        putitem_e(tFGR_LIQITEMCP, 'NR_SEQITEM', itemXmlF('NR_SEQITEM', pParams));
        putitem_e(tFGR_LIQITEMCP, 'TP_LIQITEMCP', itemXmlF('TP_LIQITEMCP', pParams));
        putitem_e(tFGR_LIQITEMCP, 'NR_ANO', itemXmlF('NR_ANO', pParams));
        putitem_e(tFGR_LIQITEMCP, 'NR_SEQAUTO', itemXmlF('NR_SEQAUTO', pParams));
        putitem_e(tFGR_LIQITEMCP, 'NR_CTAPES', itemXmlF('NR_CTAPES', pParams));
      end else begin
Result := SetStatus(STS_ERROR, 'GEN0001', 'Itens da liquidação não encontrada!', cDS_METHOD);
const
  Result := SetStatus(STS_ERROR, 'GEN0001', 'Itens da liquidação não encontrada!', cDS_METHOD);
begin
        return(-1); exit;
      end;
    end;
  end;
  if (vInAtualiza <> 'N') then begin
    putitem_e(tFGR_LIQ, 'VL_TOTAL', item_f('VL_TOTAL', tFGR_LIQ) + itemXmlF('VL_PAGO', pParams));
  end;
  putitem_e(tFGR_LIQ, 'CD_OPERADOR', itemXmlF('CD_USUARIO', PARAM_GLB));
  putitem_e(tFGR_LIQ, 'DT_CADASTRO', Now);
  putitem_e(tFGR_LIQITEMCP, 'NR_SEQAUTO', itemXmlF('NR_SEQAUTO', pParams));
  putitem_e(tFGR_LIQITEMCP, 'DT_AUTORIZACAO', itemXml('DT_AUTORIZACAO', pParams));
  putitem_e(tFGR_LIQITEMCP, 'NR_SEQCHEQUE', itemXmlF('NR_SEQCHEQUE', pParams));
  putitem_e(tFGR_LIQITEMCP, 'NR_CTAPES', itemXmlF('NR_CTAPES', pParams));
  putitem_e(tFGR_LIQITEMCP, 'VL_PAGO', item_f('VL_PAGO', tFGR_LIQITEMCP) + itemXmlF('VL_PAGO', pParams));
  putitem_e(tFGR_LIQITEMCP, 'CD_OPERADOR', itemXmlF('CD_USUARIO', PARAM_GLB));
  putitem_e(tFGR_LIQITEMCP, 'DT_CADASTRO', Now);

  voParams := tFGR_LIQ.Salvar();
  if (xStatus < 0) then begin
    Result := voParams;
    return(-1); exit;
  end;

  return(0); exit;
end;

//--------------------------------------------------------------
function T_FGRSVCO001.validarEmpresa(pParams : String) : String;
//--------------------------------------------------------------
const
  cDS_METHOD = 'ADICONAL=Operação: T_FGRSVCO001.validarEmpresa()';
var
  vCdPoolEmpresa, vCdGrupoEmpresa, vCdEmpresa, viParams, voParams, vLstEmpresa, vDsMsg : String;
  vInCCusto, vInValidaPool : Boolean;
  vCd : Real;
begin
  Result := '';

  vDsMsg := 'ADICIONAL=  / FGRSVCO001.validarEmpresa()';

  vCdPoolEmpresa := itemXmlF('CD_POOLEMPRESA', pParams);
  if (vCdPoolEmpresa = '') then begin
    vCdPoolEmpresa := gModulo.gCdPoolEmpresa;
  end;

  vCdGrupoEmpresa := itemXmlF('CD_GRUPOEMPRESA', pParams);
  if (vCdGrupoEmpresa = '') then begin
    vCdGrupoEmpresa := gModulo.gCdGrupoEmpresa;
  end;

  vCdEmpresa := itemXmlF('CD_EMPRESA', pParams);
  if (vCdEmpresa = '') then begin
    Result := SetStatus(STS_ERROR, 'GEN001', , cDS_METHOD);
    return(-1); exit;
  end;

  vInCCusto := itemXmlB('IN_CCUSTO', pParams);
  if (vInCCusto = '') then begin
    vInCCusto := False;
  end;

  vInValidaPool := itemXmlB('IN_VALIDAPOOL', pParams);
  if (vInValidaPool = '') then begin
    vInValidaPool := True;
  end;

  clear_e(tGER_EMPRESA);
  putitem_e(tGER_EMPRESA, 'CD_EMPRESA', vCdEmpresa);
  retrieve_e(tGER_EMPRESA);
  if (xStatus < 0) then begin
    Result := SetStatus(<STS_INFO>, 'GEN001', , cDS_METHOD);
    return(-1); exit;
  end;
  if (itemXml('CD_EMPVALIDACAO', pParams) <> '') then begin
    viParams := '';
    putitemXml(viParams, 'CD_EMPRESA', vCdEmpresa);
    putitemXml(viParams, 'IN_CCUSTO', vInCCusto);
    putitemXml(viParams, 'CD_EMPVALIDACAO', itemXmlF('CD_EMPVALIDACAO', pParams));
    voParams := activateCmp('SICSVCO002', 'validaLocal', viParams); (*,viParams,voParams,, *)
    if (xStatus < 0) then begin
      Result := voParams;
      return(-1); exit;
    end;
    vCdEmpresa := itemXmlF('CD_EMPRESA', voParams);
  end;

  viParams := '';
  putitemXml(viParams, 'CD_EMPRESA', vCdEmpresa);
  putitemXml(viParams, 'IN_CCUSTO', vInCCusto);
  putitemXml(viParams, 'IN_VALIDAPOOL', vInValidaPool);
  putitemXml(viParams, 'CD_POOLEMPRESA', vCdPoolEmpresa);
  if (itemXml('CD_COMPONENTE', pParams) <> '') then begin
    putitemXml(viParams, 'CD_COMPONENTE', itemXmlF('CD_COMPONENTE', pParams));
  end;
  if (itemXml('CD_EMPRESALOG', pParams) <> '') then begin
    putitemXml(viParams, 'CD_EMPRESALOG', itemXmlF('CD_EMPRESALOG', pParams));
  end;
  voParams := activateCmp('SICSVCO004', 'validaEmpresa', viParams); (*,viParams,voParams,, *)
  if (xStatus < 0) then begin
    Result := voParams;
    return(-1); exit;
  end;

  vLstEmpresa := itemXml('LST_EMPRESA', voParams);
  if (vLstEmpresa = '') then begin
    if (gModulo.gCdPoolEmpresa > 0) then begin
      Result := SetStatus(STS_ERROR, 'GEN001', , cDS_METHOD);
    end else begin
      Result := SetStatus(STS_ERROR, 'GEN001', , cDS_METHOD);
    end;
    return(-1); exit;
  end;

  clear_e(tGER_EMPRESA);
  putitem_e(tGER_EMPRESA, 'CD_EMPRESA', vLstEmpresa);
  retrieve_e(tGER_EMPRESA);
  if (xStatus >= 0) then begin
    vLstEmpresa := '';
    sort/e(t GER_EMPRESA, 'CD_EMPRESA';);
    setocc(tGER_EMPRESA, 1);
    while (xStatus >= 0) do begin
      vCd := item_f('CD_EMPRESA', tGER_EMPRESA);

      if (vLstEmpresa = '') then begin
        vLstEmpresa := vCd;
      end else begin
        vLstEmpresa := '' + vLstEmpresa + ';
      end;

      setocc(tGER_EMPRESA, curocc(tGER_EMPRESA) + 1);
    end;
  end;

  Result := '';
  putitemXml(Result, 'LST_EMPRESA', vLstEmpresa);

  return(0); exit;
end;

//-------------------------------------------------------------
function T_FGRSVCO001.listarEmpresa(pParams : String) : String;
//-------------------------------------------------------------
const
  cDS_METHOD = 'ADICONAL=Operação: T_FGRSVCO001.listarEmpresa()';
var
  vCdPoolEmpresa, vCdGrupoEmpresa, vCdEmpresa, viParams, voParams, vLstGrupoEmpresa, vLstEmpresa, vDsMsg : String;
  vInCCusto, vInValidaPool : Boolean;
  vCd : Real;
begin
  Result := '';

  vDsMsg := 'ADICIONAL=  / FGRSVCO001.listaEmpresa()';

  vCdPoolEmpresa := itemXmlF('CD_POOLEMPRESA', pParams);
  if (vCdPoolEmpresa = '') then begin
    vCdPoolEmpresa := gModulo.gCdPoolEmpresa;
  end;

  vCdGrupoEmpresa := itemXmlF('CD_GRUPOEMPRESA', pParams);
  if (vCdGrupoEmpresa = '')  and (gModulo.gCdGrupoEmpresa > 0) then begin
    vCdGrupoEmpresa := gModulo.gCdGrupoEmpresa;
  end;

  vInCCusto := itemXmlB('IN_CCUSTO', pParams);
  if (vInCCusto = '') then begin
    vInCCusto := False;
  end;
  vLstGrupoEmpresa := vCdGrupoEmpresa;

  vInValidaPool := itemXmlB('IN_VALIDAPOOL', pParams);
  if (vInValidaPool = '') then begin
    vInValidaPool := True;
  end;
  if (vCdPoolEmpresa <> '')  and (gModulo.gCdPoolEmpresa > 0) then begin
    vLstGrupoEmpresa := '';

    clear_e(tGER_POOLGRUPO);
    putitem_e(tGER_POOLGRUPO, 'CD_POOLEMPRESA', vCdPoolEmpresa);
    putitem_e(tGER_POOLGRUPO, 'CD_GRUPOEMPRESA', vCdGrupoEmpresa);
    retrieve_e(tGER_POOLGRUPO);
    if (xStatus >= 0) then begin
      setocc(tGER_POOLGRUPO, 1);
      while (xStatus >= 0) do begin

        vCd := item_f('CD_GRUPOEMPRESA', tGER_POOLGRUPO);
        if (vLstGrupoEmpresa = '') then begin
          vLstGrupoEmpresa := vCd;
        end else begin
          vLstGrupoEmpresa := '' + vLstGrupoEmpresa + ';
        end;

        setocc(tGER_POOLGRUPO, curocc(tGER_POOLGRUPO) + 1);
      end;
    end;
  end;
  if (vLstGrupoEmpresa = '') then begin
    Result := SetStatus(STS_ERROR, 'GEN001', , cDS_METHOD);
    return(-1); exit;
  end;

  vLstEmpresa := '';

  clear_e(tGER_EMPRESA);
  putitem_e(tGER_EMPRESA, 'CD_GRUPOEMPRESA', vLstGrupoEmpresa);
  retrieve_e(tGER_EMPRESA);
  if (xStatus >= 0) then begin
    sort/e(t GER_EMPRESA, 'CD_EMPRESA';);
    setocc(tGER_EMPRESA, 1);
    while (xStatus >= 0) do begin
      vCd := item_f('CD_EMPRESA', tGER_EMPRESA);

      if (vLstEmpresa = '') then begin
        vLstEmpresa := vCd;
      end else begin
        vLstEmpresa := '' + vLstEmpresa + ';
      end;

      setocc(tGER_EMPRESA, curocc(tGER_EMPRESA) + 1);
    end;
  end;

  viParams := '';
  putitemXml(viParams, 'CD_POOLEMPRESA', vCdPoolEmpresa);
  putitemXml(viParams, 'CD_GRUPOEMPRESA', vCdGrupoEmpresa);
  putitemXml(viParams, 'CD_EMPRESA', vLstEmpresa);
  putitemXml(viParams, 'IN_CCUSTO', vInCCusto);
  putitemXml(viParams, 'IN_VALIDAPOOL', vInValidaPool);
  if (itemXml('CD_COMPONENTE', pParams) <> '') then begin
    putitemXml(viParams, 'CD_COMPONENTE', itemXmlF('CD_COMPONENTE', pParams));
  end;
  if (itemXml('CD_EMPVALIDACAO', pParams) <> '') then begin
    putitemXml(viParams, 'CD_EMPVALIDACAO', itemXmlF('CD_EMPVALIDACAO', pParams));
  end;
  if (itemXml('CD_EMPRESALOG', pParams) <> '') then begin
    putitemXml(viParams, 'CD_EMPRESALOG', itemXmlF('CD_EMPRESALOG', pParams));
  end;
  voParams := activateCmp('FGRSVCO001', 'validarEmpresa', viParams); (*,viParams,voParams,, *)
  if (xStatus < 0) then begin
    Result := voParams;
    return(-1); exit;
  end;
  vLstEmpresa := itemXml('LST_EMPRESA', voParams);

  Result := '';
  putitemXml(Result, 'LST_EMPRESA', vLstEmpresa);

  return(0); exit;
end;

//----------------------------------------------------------------------
function T_FGRSVCO001.listarEmpresaEnvSerasa(pParams : String) : String;
//----------------------------------------------------------------------
const
  cDS_METHOD = 'ADICONAL=Operação: T_FGRSVCO001.listarEmpresaEnvSerasa()';
var
  vCdEmpresa, viParams, voParams, vLstEmpresa : String;
  vInContemCfg : Boolean;
  vCd : Real;
begin
  Result := '';

  vCdEmpresa := itemXmlF('CD_EMPRESA', pParams);
  if (vCdEmpresa = '') then begin
    vCdEmpresa := gModulo.gCdEmpresa;
  end;

  vLstEmpresa := '';

  vInContemCfg := False;
  clear_e(tFGR_EMPENVSER);
  retrieve_e(tFGR_EMPENVSER);
  if (xStatus >= 0) then begin
    vInContemCfg := True;
  end;
  clear_e(tFGR_EMPENVSER);

  clear_e(tFGR_EMPENVSER);
  putitem_e(tFGR_EMPENVSER, 'CD_EMPENVIO', vCdEmpresa);
  retrieve_e(tFGR_EMPENVSER);
  if (xStatus >= 0) then begin
    sort/e(t FGR_EMPENVSER, 'CD_EMPRESA';);
    setocc(tFGR_EMPENVSER, 1);
    while (xStatus >= 0) do begin
      vCd := item_f('CD_EMPRESA', tFGR_EMPENVSER);
      if (vLstEmpresa = '') then begin
        vLstEmpresa := vCd;
      end else begin
        vLstEmpresa := '' + vLstEmpresa + ';
      end;
      setocc(tFGR_EMPENVSER, curocc(tFGR_EMPENVSER) + 1);
    end;
  end;
  clear_e(tFGR_EMPENVSER);

  if (vLstEmpresa <> '') then begin
    viParams := '';
    putitemXml(viParams, 'CD_EMPRESA', '' + vLstEmpresa) + ';
    putitemXml(viParams, 'CD_COMPONENTE', itemXmlF('CD_COMPONENTE', pParams));
    voParams := activateCmp('FGRSVCO001', 'validarEmpresa', viParams); (*,viParams,voParams,, *)
    if (xStatus < 0) then begin
      Result := voParams;
      return(-1); exit;
    end;
    vLstEmpresa := itemXml('LST_EMPRESA', voParams);
  end else begin
    if (vInContemCfg = True) then begin
      Result := SetStatus(STS_ERROR, 'GEN001', 'Empresa não configurada para envio PEFIN - Serasa.', cDS_METHOD);
      return(-1); exit;
    end;
  end;

  putitemXml(Result, 'LST_EMPRESA', vLstEmpresa);

  return(0); exit;

end;

//------------------------------------------------------------
function T_FGRSVCO001.buscaDespesa(pParams : String) : String;
//------------------------------------------------------------
const
  cDS_METHOD = 'ADICONAL=Operação: T_FGRSVCO001.buscaDespesa()';
var
  (* string piCdDespesaItemJuros : INOUT *)
  viParams, voParams, vDsDespesa, vDsRegistro : String;
begin
  if (piCdDespesaItemJuros <> 0)  and (piCdDespesaItemJuros <> '') then begin
    return(0); exit;
  end;

  voParams := activateCmp('FCPFL020', 'exec', viParams); (*viParams,voParams,, *)
  if (xStatus < 0) then begin
    Result := voParams;
    return(-1); exit;
  end;

  vDsDespesa := itemXml('DS_DESPESAITEM', voParams);

  if (vDsDespesa <> '') then begin
    getitem(vDsRegistro, vDsDespesa, 1);
    piCdDespesaItemJuros := itemXmlF('CD_DESPESAITEM', vDsRegistro);
  end;

  return(0); exit;

end;

//--------------------------------------------------------------
function T_FGRSVCO001.validarParcial(pParams : String) : String;
//--------------------------------------------------------------
const
  cDS_METHOD = 'ADICONAL=Operação: T_FGRSVCO001.validarParcial()';
var
  vVlDuplicata, vCdEmpDup, vCdFornecedor, vNrDuplicata, vNrParcela : Real;
  viParams, voParams : String;
begin
  vCdEmpDup := itemXmlF('CD_EMPRESA', pParams);
  if (itemXml('CD_EMPRESA', pParams) = '') then begin
    Result := SetStatus(STS_ERROR, 'GEN001', 'Empresa da duplicata não informada para validar parcial., '');
    return(-1); exit;
  end;
  vCdFornecedor := itemXmlF('CD_FORNECEDOR', pParams);
  if (itemXml('CD_FORNECEDOR', pParams) = '') then begin
    Result := SetStatus(STS_ERROR, 'GEN001', 'Fornecedor da duplicata não informado para validar parcial., '');
    return(-1); exit;
  end;
  vNrDuplicata := itemXmlF('NR_DUPLICATA', pParams);
  if (itemXml('NR_DUPLICATA', pParams) = '') then begin
    Result := SetStatus(STS_ERROR, 'GEN001', 'Número da duplicata não informado para validar parcial., '');
    return(-1); exit;
  end;
  vNrParcela := itemXmlF('NR_PARCELA', pParams);
  if (itemXml('NR_PARCELA', pParams) = '') then begin
    Result := SetStatus(STS_ERROR, 'GEN001', 'Parcela da duplicata não informada para validar parcial., '');
    return(-1); exit;
  end;

  clear_e(tF_FCP_DUPLI);
  putitem_e(tF_FCP_DUPLI, 'CD_EMPRESA', vCdEmpDup);
  putitem_e(tF_FCP_DUPLI, 'CD_FORNECEDOR', vCdFornecedor);
  putitem_e(tF_FCP_DUPLI, 'NR_DUPLICATA', vNrDuplicata);
  putitem_e(tF_FCP_DUPLI, 'NR_PARORIGINAL', vNrParcela);
  putitem_e(tF_FCP_DUPLI, 'NR_PARCELA', '!=' + FloatToStr(vNrParcela') + ');
  putitem_e(tF_FCP_DUPLI, 'TP_SITUACAO', 'N');
  retrieve_e(tF_FCP_DUPLI);
  if (xStatus >=0) then begin
    setocc(tF_FCP_DUPLI, 1);
    while (xStatus >= 0) do begin
      if (item_f('NR_SEQLIQ', tF_FCP_DUPLI) <> '')  and (item_f('NR_SEQLIQ', tF_FCP_DUPLI) > 0) then begin
        Result := SetStatus(STS_ERROR, 'GEN001', 'Cancelamento não permitido.Duplicata parcial já liquidada por outro processo.Empresa: ' + CD_EMPRESA + '.F_FCP_DUPLI Fornecedor: ' + CD_FORNECEDOR + '.F_FCP_DUPLI Duplicata: ' + NR_DUPLICATA + '.F_FCP_DUPLI Parcela: ' + NR_PARCELA + '.F_FCP_DUPLI Liquidação : Emp.: ' + CD_EMPLIQ + '.F_FCP_DUPLI Data: ' + DT_LIQ + '.F_FCP_DUPLI Liquidação: ' + NR_SEQLIQ + '.F_FCP_DUPLI, '');
        return(-1); exit;
      end;
      if (item_f('TP_ESTAGIO', tF_FCP_DUPLI) = 3)  or (item_f('TP_ESTAGIO', tF_FCP_DUPLI) = 4) then begin
        clear_e(tF_FCC_AUTOPAG);
        putitem_e(tF_FCC_AUTOPAG, 'CD_EMPRESA', item_f('CD_EMPRESA', tF_FCP_DUPLI));
        putitem_e(tF_FCC_AUTOPAG, 'CD_FORNECEDOR', item_f('CD_FORNECEDOR', tF_FCP_DUPLI));
        putitem_e(tF_FCC_AUTOPAG, 'NR_DUPLICATA', item_f('NR_DUPLICATA', tF_FCP_DUPLI));
        putitem_e(tF_FCC_AUTOPAG, 'NR_PARCELA', item_f('NR_PARCELA', tF_FCP_DUPLI));
        retrieve_e(tF_FCC_AUTOPAG);
        if (xStatus < 0) then begin
          Result := SetStatus(STS_ERROR, 'GEN001', 'Cheque com estágio de autorizado para pagamento com cheque próprio, mas autorização não encontrada., '');
          return(-1); exit;
        end;

        setocc(tF_FCC_AUTOPAG, 1);
        while (xStatus >= 1) do begin
          clear_e(tF_FCC_AUTOCHE);
          putitem_e(tF_FCC_AUTOCHE, 'DT_AUTORIZACAO', item_a('DT_AUTORIZACAO', tF_FCC_AUTOPAG));
          putitem_e(tF_FCC_AUTOCHE, 'NR_SEQAUTO', item_f('NR_SEQAUTO', tF_FCC_AUTOPAG));
          putitem_e(tF_FCC_AUTOCHE, 'NR_SEQCHEQUE', item_f('NR_SEQCHEQUE', tF_FCC_AUTOPAG));
          retrieve_e(tF_FCC_AUTOCHE);
          if (xStatus >= 0)  and (item_a('DT_CANCELADO', tF_FCC_AUTOCHE) = '')  and (item_a('DT_AUTORIZACAO', tF_FCC_AUTOPAG) <> item_a('DT_AUTORIZACAO', tFCC_AUTOPAG))  and (item_f('NR_SEQAUTO', tF_FCC_AUTOPAG) <> item_f('NR_SEQAUTO', tFCC_AUTOPAG)) then begin
            clear_e(tF_FCC_AUTORIZ);
            putitem_e(tF_FCC_AUTORIZ, 'DT_AUTORIZACAO', item_a('DT_AUTORIZACAO', tF_FCC_AUTOPAG));
            putitem_e(tF_FCC_AUTORIZ, 'NR_SEQAUTO', item_f('NR_SEQAUTO', tF_FCC_AUTOPAG));
            retrieve_e(tF_FCC_AUTORIZ);
            if (xStatus >= 0)  and (item_f('TP_EMITIDO', tF_FCC_AUTORIZ) <> 'C') then begin
              Result := SetStatus(STS_ERROR, 'GEN001', 'Cancelamento não permitido.Duplicata com autorização de cheque gerada.Emp.: ' + CD_EMPRESA + '.F_FCP_DUPLI Fornec.: ' + CD_FORNECEDOR + '.F_FCP_DUPLI Duplic.: ' + NR_DUPLICATA + '.F_FCP_DUPLI Parc.: ' + NR_PARCELA + '.F_FCP_DUPLI Data: ' + DT_AUTORIZACAO + '.F_FCC_AUTORIZ Seq.: ' + NR_SEQAUTO + '.F_FCC_AUTORIZ, '');
              return(-1); exit;
            end;
          end;

          setocc(tF_FCC_AUTOPAG, curocc(tF_FCC_AUTOPAG) + 1);
        end;
      end;
      if (itemXml('IN_CANCELARDUP', pParams) = True) then begin
        viParams := '';
        putitemXml(viParams, 'CD_EMPRESA', item_f('CD_EMPRESA', tF_FCP_DUPLI));
        putitemXml(viParams, 'CD_FORNECEDOR', item_f('CD_FORNECEDOR', tF_FCP_DUPLI));
        putitemXml(viParams, 'NR_DUPLICATA', item_f('NR_DUPLICATA', tF_FCP_DUPLI));
        putitemXml(viParams, 'NR_PARCELA', item_f('NR_PARCELA', tF_FCP_DUPLI));
        putitemXml(viParams, 'CD_COMPONENTE', FGRSVCO001);
        putitemXml(viParams, 'DS_OBS', '');
        putitemXml(viParams, 'DS_LOG', 'Duplicata cancelada');
        putitemXml(viParams, 'TP_CANCELAMENTO', 'C');
        voParams := activateCmp('FCPSVCO005', 'cancelaDuplicata', viParams); (*,viParams,voParams,, *)
        if (xStatus < 0) then begin
          Result := voParams;
          return(-1); exit;
        end;
      end;

      vVlDuplicata := vVlDuplicata + item_f('VL_DUPLICATA', tF_FCP_DUPLI);

      setocc(tF_FCP_DUPLI, curocc(tF_FCP_DUPLI) + 1);
    end;
    clear_e(tF_FCC_AUTORIZ);
    clear_e(tF_FCC_AUTOCHE);
    clear_e(tF_FCC_AUTOPAG);
    clear_e(tF_FCP_DUPLI);
  end;
  Result := '';
  putitemXml(Result, 'VL_DUPLICATA', vVlDuplicata);

  return(0); exit;
end;

//---------------------------------------------------------------------
function T_FGRSVCO001.validarEmpEnvioSerasa(pParams : String) : String;
//---------------------------------------------------------------------
const
  cDS_METHOD = 'ADICONAL=Operação: T_FGRSVCO001.validarEmpEnvioSerasa()';
var
  vLstEmpresa, viParams, voParams, vCdComponente : String;
  vCdEmpLogada, vCdEmpresa : Real;
begin
  Result := '';
  vCdEmpLogada := itemXmlF('CD_EMPLOGADA', pParams);
  if (vCdEmpLogada = '') then begin
    vCdEmpLogada := gModulo.gCdEmpresa;
  end;
  vCdComponente := itemXmlF('CD_COMPONENTE', pParams);
  if (vCdComponente = '') then begin
    Result := SetStatus(STS_ERROR, 'GEN001', 'Componente não informado para validação de empresa de envio PEFIN/SERASA, '');
    return(-1); exit;
  end;
  vLstEmpresa := itemXml('LST_EMPRESA', pParams);
  if (vLstEmpresa = '') then begin
    Result := SetStatus(STS_ERROR, 'GEN001', 'Lista de empresa não informada.', cDS_METHOD);
    return(-1); exit;
  end;

  clear_e(tFGR_EMPENVSER);
  putitem_e(tFGR_EMPENVSER, 'CD_EMPRESA', vLstEmpresa);
  retrieve_e(tFGR_EMPENVSER);
  if (xStatus < 0) then begin
    putitemXml(Result, 'LST_EMPRESA', '');
    return(0); exit;
  end;

  vLstEmpresa := '';
  setocc(tFGR_EMPENVSER, 1);
  while (xStatus >= 0) do begin
    if (item_f('CD_EMPENVIO', tFGR_EMPENVSER) = vCdEmpLogada) then begin
      if (vLstEmpresa = '') then begin
        vLstEmpresa := item_f('CD_EMPRESA', tFGR_EMPENVSER);
      end else begin
        vCdEmpresa := item_f('CD_EMPRESA', tFGR_EMPENVSER);
        vLstEmpresa := '' + vLstEmpresa + ';
      end;
    end;
    setocc(tFGR_EMPENVSER, curocc(tFGR_EMPENVSER) + 1);
  end;
  clear_e(tFGR_EMPENVSER);

  viParams := '';
  putitemXml(viParams, 'CD_EMPRESA', vLstEmpresa);
  putitemXml(viParams, 'IN_CCUSTO', True);
  putitemXml(viParams, 'CD_COMPONENTE', vCdComponente);
  voParams := activateCmp('FGRSVCO001', 'validarEmpresa', viParams); (*,viParams,voParams,, *)
  if (xStatus < 0) then begin
    Result := voParams;
    return(-1); exit;
  end;
  vLstEmpresa := itemXml('LST_EMPRESA', voParams);

  if (vLstEmpresa = '') then begin
    Result := SetStatus(STS_ERROR, 'GEN001', 'Empresa não configurada para envio PEFIN - Serasa.', cDS_METHOD);
    return(-1); exit;
  end;
  putitemXml(Result, 'LST_EMPRESA', vLstEmpresa);

  return(0); exit;
end;

end.
