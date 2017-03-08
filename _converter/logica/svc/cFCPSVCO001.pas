unit cFCPSVCO001;

interface

(* COMPONENTES 
  ADMSVCO001 / EDISVCO020 / FCPSVCO001 / FCPSVCO005 / FCPSVCO047
  FGRSVCO022 / 
*)        

uses
  Classes, SysUtils, DB,
  cServiceUnf, cDataSetUnf;

type
  T_FCPSVCO001 = class(TcServiceUnf)
  private
    tCTB_LOTE,
    tCTB_MOVTOD,
    tF_FCP_DUPIMPO,
    tF_FCP_DUPIMPOSTO,
    tF_FCP_DUPLI,
    tF_OBS_DUPI,
    tF_PES_FORNECE,
    tFCP_ACEITE,
    tFCP_CLAS,
    tFCP_DESPCCUSTEMP,
    tFCP_DUPABATC,
    tFCP_DUPCLAS,
    tFCP_DUPDESPAP,
    tFCP_DUPDESPES,
    tFCP_DUPIADIC,
    tFCP_DUPIMPOST,
    tFCP_DUPLICATC,
    tFCP_DUPLICATI,
    tFCP_LOGDUP,
    tFCP_TIPOCLAS,
    tOBS_DUPI,
    tPES_CLASSIFIC,
    tPES_PESSOACLA,
    tPES_TIPOCLAS,
    tTMP_NR09 : TcDatasetUnf;
    function getParam(pParams : String = '') : String;
    function setEntidade(pParams : String = '') : String;
  protected
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;    
  published
    function Converterstring(pParams : String = '') : String;
    function GravaLogGravacao(pParams : String = '') : String;
    function MsgRegBloq(pParams : String = '') : String;
    function LimpaRegBloq(pParams : String = '') : String;
    function validaCentroCusto(pParams : String = '') : String;
    function validaDespesa(pParams : String = '') : String;
    function validaDespCcusto(pParams : String = '') : String;
    function geraDuplicata(pParams : String = '') : String;
    function gravaLogDuplicata(pParams : String = '') : String;
    function seqLogDup(pParams : String = '') : String;
    function gravaAceite(pParams : String = '') : String;
    function ExcluirParcelaDup(pParams : String = '') : String;
    function gravaObsDuplicata(pParams : String = '') : String;
    function seqObsDup(pParams : String = '') : String;
    function calcVencBase(pParams : String = '') : String;
    function duplicarObservacaoDup(pParams : String = '') : String;
    function BaixaDuplicata(pParams : String = '') : String;
    function ReabreDuplicata(pParams : String = '') : String;
    function CancelaDuplicata(pParams : String = '') : String;
    function gravaImposto(pParams : String = '') : String;
    function gravaDespesaAproDuplicata(pParams : String = '') : String;
    function exclusaoDespesaAproDuplicata(pParams : String = '') : String;
    function gravarClassificacaoDuplicata(pParams : String = '') : String;
    function validarClassificacaoDuplicata(pParams : String = '') : String;
    function gravaClassificacaoForDup(pParams : String = '') : String;
    function verLanctoCtbDuplicata(pParams : String = '') : String;
    function validaLanctoContabilPeriodo(pParams : String = '') : String;
    function gravaFcpDupAdic(pParams : String = '') : String;
  end;

implementation

uses
  cADMSVCO001,
  cActivate, cStatus, cFuncao, cXml, dModulo;

var
  g %%vVlrTotalRateio não confere com o valor da parcela R,
  gCdCCustoPadraoFcp,
  gCdEmpresa,
  gCdFornecedor,
  gCdTipoClasCmpDup,
  gCdTipoClasForDup,
  gCdTipoClasPrdDup,
  gDtData,
  gDtFechaContabCP,
  gNrDuplicata,
  gNrParcela,
  gNrSeqLog,
  gvenctoDest,
  gvenctoOri : String;

//---------------------------------------------------------------
constructor T_FCPSVCO001.Create(AOwner: TComponent);
//---------------------------------------------------------------
begin
  inherited Create(AOwner);
  setEntidade('');
end;

//--------------------------------
destructor T_FCPSVCO001.Destroy;
//--------------------------------
begin
  inherited Destroy;
end;

//---------------------------------------------------------------
function T_FCPSVCO001.getParam(pParams : String) : String;
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
  putitem(xParam, 'CD_EMPRESA');
  putitem(xParam, 'CD_GRUPO_EMISSAO_CP');
  putitem(xParam, 'CD_PESSOA');
  putitem(xParam, 'CD_POOLEMPRESA');
  putitem(xParam, 'DT_EXERCONTABIL');
  putitem(xParam, 'IN_CONTABILIZADO');
  putitem(xParam, 'NR_DUPLICATA');
  putitem(xParam, 'NR_LOTE');
  putitem(xParam, 'NR_ORDEM');
  putitem(xParam, 'NR_PARCELA');

  xParam := T_ADMSVCO001.GetParametro(xParam);


  xParamEmp := '';
  putitem(xParamEmp, 'CD_CCUSTO');
  putitem(xParamEmp, 'CD_CCUSTOPADRAO_FCP');
  putitem(xParamEmp, 'CD_COMPONENTE');
  putitem(xParamEmp, 'CD_DESPESA');
  putitem(xParamEmp, 'CD_EMPLIQ');
  putitem(xParamEmp, 'CD_EMPRESA');
  putitem(xParamEmp, 'CD_FORNECEDOR');
  putitem(xParamEmp, 'CD_OPERALTERACAO');
  putitem(xParamEmp, 'CD_OPERBAIXA');
  putitem(xParamEmp, 'CD_TIPOCLAS_CMP_DUP');
  putitem(xParamEmp, 'CD_TIPOCLAS_FOR_DUP');
  putitem(xParamEmp, 'CD_TIPOCLAS_PRD_DUP');
  putitem(xParamEmp, 'DS_CALCBASEDUP');
  putitem(xParamEmp, 'DS_CALCVENCDUP');
  putitem(xParamEmp, 'DT_ALTERACAO');
  putitem(xParamEmp, 'DT_BAIXA');
  putitem(xParamEmp, 'DT_FECHA_CONTABILIDADE_CP');
  putitem(xParamEmp, 'DT_LIQ');
  putitem(xParamEmp, 'IN_VALIDA_DESPESA_CCUSTO');
  putitem(xParamEmp, 'NR_DUPLICATA');
  putitem(xParamEmp, 'NR_OBSDUP');
  putitem(xParamEmp, 'NR_PARCELA');
  putitem(xParamEmp, 'NR_SEQLIQ');
  putitem(xParamEmp, 'TP_BAIXA');
  putitem(xParamEmp, 'TP_SITUACAO');
  putitem(xParamEmp, 'VL_PAGO');

  xParamEmp := T_ADMSVCO001.GetParamEmpresa(piCdEmpresa, xParamEmp);

  gCdCCustoPadraoFcp := itemXml('CD_CCUSTOPADRAO_FCP', xParamEmp);
  gCdTipoClasCmpDup := itemXml('CD_TIPOCLAS_CMP_DUP', xParamEmp);
  gCdTipoClasForDup := itemXml('CD_TIPOCLAS_FOR_DUP', xParamEmp);
  gCdTipoClasPrdDup := itemXml('CD_TIPOCLAS_PRD_DUP', xParamEmp);
  gDtFechaContabCP := itemXml('DT_FECHA_CONTABILIDADE_CP', xParamEmp);

end;

//---------------------------------------------------------------
function T_FCPSVCO001.setEntidade(pParams : String) : String;
//---------------------------------------------------------------
begin
  tCTB_LOTE := GetEntidade('CTB_LOTE');
  tCTB_MOVTOD := GetEntidade('CTB_MOVTOD');
  tF_FCP_DUPIMPO := GetEntidade('F_FCP_DUPIMPO');
  tF_FCP_DUPIMPOSTO := GetEntidade('F_FCP_DUPIMPOSTO');
  tF_FCP_DUPLI := GetEntidade('F_FCP_DUPLI');
  tF_OBS_DUPI := GetEntidade('F_OBS_DUPI');
  tF_PES_FORNECE := GetEntidade('F_PES_FORNECE');
  tFCP_ACEITE := GetEntidade('FCP_ACEITE');
  tFCP_CLAS := GetEntidade('FCP_CLAS');
  tFCP_DESPCCUSTEMP := GetEntidade('FCP_DESPCCUSTEMP');
  tFCP_DUPABATC := GetEntidade('FCP_DUPABATC');
  tFCP_DUPCLAS := GetEntidade('FCP_DUPCLAS');
  tFCP_DUPDESPAP := GetEntidade('FCP_DUPDESPAP');
  tFCP_DUPDESPES := GetEntidade('FCP_DUPDESPES');
  tFCP_DUPIADIC := GetEntidade('FCP_DUPIADIC');
  tFCP_DUPIMPOST := GetEntidade('FCP_DUPIMPOST');
  tFCP_DUPLICATC := GetEntidade('FCP_DUPLICATC');
  tFCP_DUPLICATI := GetEntidade('FCP_DUPLICATI');
  tFCP_LOGDUP := GetEntidade('FCP_LOGDUP');
  tFCP_TIPOCLAS := GetEntidade('FCP_TIPOCLAS');
  tOBS_DUPI := GetEntidade('OBS_DUPI');
  tPES_CLASSIFIC := GetEntidade('PES_CLASSIFIC');
  tPES_PESSOACLA := GetEntidade('PES_PESSOACLA');
  tPES_TIPOCLAS := GetEntidade('PES_TIPOCLAS');
  tTMP_NR09 := GetEntidade('TMP_NR09');
end;

//---------------------------------------------------------------
function T_FCPSVCO001.Converterstring(pParams : String) : String;
//---------------------------------------------------------------
const
  cDS_METHOD = 'ADICIONAL=Operação: T_FCPSVCO001.Converterstring()';
var
  (* string pistring :In / string postring :Out *)
  viParams, voParams : String;
begin
  putitemXml(viParams, 'DS_string', pistring);
  putitemXml(viParams, 'IN_MAIUSCULA', True);
  putitemXml(viParams, 'IN_NUMERO', True);
  putitemXml(viParams, 'IN_ESPACO', True);
  putitemXml(viParams, 'IN_ESPECIAL', False);
  putitemXml(viParams, 'IN_MANTERPONTO', True);
  voParams := activateCmp('EDISVCO020', 'limparCampo', viParams); (*,,,, *)
  postring := itemXml('DS_string', voParams);

  return(0); exit;
end;

//----------------------------------------------------------------
function T_FCPSVCO001.GravaLogGravacao(pParams : String) : String;
//----------------------------------------------------------------
const
  cDS_METHOD = 'ADICIONAL=Operação: T_FCPSVCO001.GravaLogGravacao()';
var
  (* string pDsAux : IN *)
  viParams, voParams, vDsAux : String;
  time vData : TDatetime;
begin
  if (gModulo.gCdUsuario <> 999998)  and (gModulo.gCdUsuario <> 999999) then begin
    return(0); exit;
  end;

  vDsAux := pDsAux;

  if (pDsAux = 'INICIO') then begin
    clrmess;
    gDtData := Now;
    putmess 'Inicio as ' + gDtData' + ';
    gNrSeqLog := 0;
  end;
  if (pDsAux <> '') then begin
    vData := Now - gDtData;
    vDsAux := '' + vDsAux + '... ' + gDtData + ' / Tempo ' + vData' + ';
  end;
  if (pDsAux = 'FIM') then begin
    putmess 'Termino as ' + gDtData + ' / Tempo ' + vData' + ';
  end;
  if (pDsAux = 'RETRIEVE FCP_DUPLICATAC')  or (pDsAux = 'FIM') then begin
    vDsAux := '' + vDsAux + '... EMP.' + FloatToStr(gCdEmpresa) + '/ FOR.' + FloatToStr(gCdFornecedor) + '/ DUP.' + FloatToStr(gNrDuplicata) + '/ PAR.' + FloatToStr(gNrParcela') + ';
  end;

  gNrSeqLog := gNrSeqLog + 1;
  viParams := '';
  putitemXml(viParams, 'CD_COMPONENTE', FCPSVCO001);
  putitemXml(viParams, 'DS_CAMPO', 'LOG_GRAVACAO' + FloatToStr(gNrSeqLog')) + ';
  putitemXml(viParams, 'CD_EMPRESA', gModulo.gCdEmpresa);
  putitemXml(viParams, 'CD_USUARIO', gModulo.gCdUsuario);
  putitemXml(viParams, 'DS_AUX', vDsAux);
  newinstance 'ADMSVCO010', 'ADMSVCO010X', 'TRANSACTION=TRUE';
  voParams := activateCmp('ADMSVCO010X', 'gravaLogRestricaoCommit', viParams); (*,,, *)
  deleteinstance 'ADMSVCO010X';

  if (pDsAux = 'FIM') then begin
    gNrSeqLog := gNrSeqLog + 1;
    viParams := '';
    putitemXml(viParams, 'CD_COMPONENTE', FCPSVCO001);
    putitemXml(viParams, 'DS_CAMPO', 'LOG_GRAVACAO' + FloatToStr(gNrSeqLog')) + ';
    putitemXml(viParams, 'CD_EMPRESA', gModulo.gCdEmpresa);
    putitemXml(viParams, 'CD_USUARIO', gModulo.gCdUsuario);
    putitemXml(viParams, 'DS_AUX', '');
    newinstance 'ADMSVCO010', 'ADMSVCO010X', 'TRANSACTION=TRUE';
    voParams := activateCmp('ADMSVCO010X', 'gravaLogRestricaoCommit', viParams); (*,,, *)
    deleteinstance 'ADMSVCO010X';
  end;

  return(0); exit;
end;

//----------------------------------------------------------
function T_FCPSVCO001.MsgRegBloq(pParams : String) : String;
//----------------------------------------------------------
const
  cDS_METHOD = 'ADICIONAL=Operação: T_FCPSVCO001.MsgRegBloq()';
begin
  clear_e(tFCP_DUPLICATC);
  rollback;

  exit(-11);
end;

//------------------------------------------------------------
function T_FCPSVCO001.LimpaRegBloq(pParams : String) : String;
//------------------------------------------------------------
const
  cDS_METHOD = 'ADICIONAL=Operação: T_FCPSVCO001.LimpaRegBloq()';
begin
  clear_e(tFCP_DUPLICATC);
  rollback;

  return(0); exit;
end;

//-----------------------------------------------------------------
function T_FCPSVCO001.validaCentroCusto(pParams : String) : String;
//-----------------------------------------------------------------
const
  cDS_METHOD = 'ADICIONAL=Operação: T_FCPSVCO001.validaCentroCusto()';
var
  (* numeric vCdCCusto : IN *)
  vDsComando, vDsAux : String;
begin
  if (vCdCCusto = 0)  or (vCdCCusto = '') then begin
    Result := SetStatus(STS_ERROR, 'GEN001', 'Código do centro de custo da despesa não informado!', cDS_METHOD);
    return(-1); exit;
  end;

  vDsComando := 'SELECT DS_CCUSTO FROM GEC_CCUSTO WHERE CD_CCUSTO=' + FloatToStr(vCdCCusto') + ';
  sql vDsComando, 'DEF';
  if (xStatus < 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN001', 'Erro ao busca centro de custo!', cDS_METHOD);
    return(-1); exit;
  end;
  vDsAux := gresult;
  if (vDsAux = '') then begin
    Result := SetStatus(STS_ERROR, 'GEN001', 'Centro de custo ' + FloatToStr(vCdCCusto) + ' não cadastrado!', cDS_METHOD);
    return(-1); exit;
  end;

  vDsComando := 'SELECT IN_INATIVO FROM GEC_CCUSTO WHERE CD_CCUSTO=' + FloatToStr(vCdCCusto') + ';
  sql vDsComando, 'DEF';
  if (xStatus < 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN001', 'Erro ao busca centro de custo!', cDS_METHOD);
    return(-1); exit;
  end;
  vDsAux := gresult;
  if (vDsAux = 'T') then begin
    Result := SetStatus(STS_ERROR, 'GEN001', 'Centro de custo ' + FloatToStr(vCdCCusto) + ' está INATIVO!', cDS_METHOD);
    return(-1); exit;
  end;

  return(0); exit;
end;

//-------------------------------------------------------------
function T_FCPSVCO001.validaDespesa(pParams : String) : String;
//-------------------------------------------------------------
const
  cDS_METHOD = 'ADICIONAL=Operação: T_FCPSVCO001.validaDespesa()';
var
  (* numeric vCdDespesa : IN *)
  vDsComando, vDsAux : String;
begin
  if (vCdDespesa = 0)  or (vCdDespesa = '') then begin
    Result := SetStatus(STS_ERROR, 'GEN001', 'Código do item da despesa não informado!', cDS_METHOD);
    return(-1); exit;
  end;

  vDsComando := 'SELECT DS_DESPESAITEM FROM FCP_DESPESAITEM WHERE CD_DESPESAITEM=' + FloatToStr(vCdDespesa') + ';
  sql vDsComando, 'DEF';
  if (xStatus < 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN001', 'Erro ao busca centro de item de despesa!', cDS_METHOD);
    return(-1); exit;
  end;
  vDsAux := gresult;
  if (vDsAux = '') then begin
    Result := SetStatus(STS_ERROR, 'GEN001', 'Item de despesa ' + FloatToStr(vCdDespesa) + ' não cadastrado!', cDS_METHOD);
    return(-1); exit;
  end;

  return(0); exit;
end;

//----------------------------------------------------------------
function T_FCPSVCO001.validaDespCcusto(pParams : String) : String;
//----------------------------------------------------------------
const
  cDS_METHOD = 'ADICIONAL=Operação: T_FCPSVCO001.validaDespCcusto()';
begin
  clear_e(tFCP_DESPCCUSTEMP);
  putitem_o(tFCP_DESPCCUSTEMP, 'CD_EMPRESA', vCdEmpresa);
  putitem_o(tFCP_DESPCCUSTEMP, 'CD_DESPESA', vCdDespesa);
  putitem_o(tFCP_DESPCCUSTEMP, 'CD_CCUSTO', vCdCusto);
  retrieve_e(tFCP_DESPCCUSTEMP);
  if (xStatus < 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN001', 'Item de despesa ' + FloatToStr(vCdDespesa) + ' não possui vínculo com o centro de custo ' + FloatToStr(vCdcusto) + '!', cDS_METHOD);
    return(-1); exit;
  end;

  return(0); exit;
end;

//-------------------------------------------------------------
function T_FCPSVCO001.geraDuplicata(pParams : String) : String;
//-------------------------------------------------------------
const
  cDS_METHOD = 'ADICIONAL=Operação: T_FCPSVCO001.geraDuplicata()';
var
  vVenctoAnt, vDtEmissao, vDtLiq : TDate;
  vVlrTotalRateio, vPortadorAnt, vNrParcela, vValorAnt, vVlDiferenca, vVlSaldo, vVlTotal, vVlImpostoRetido : Real;
  vDsRegDesp, vDsRegImp, vDsRegDespApr, vDsRegisttro : String;
  vDsDespesa, vDsImposto, vDsDuplicataI, vDsDespesaApr : String;
  viParams, voParams, vDsComponente, vDsRegistro : String;
  vVlTotalPerc, vVlTotalDesc, vVlTotalDuplicata, vVlImposto, vTpPrevisaoAnt, vCdFornecedor : Real;
  vCdEmpDup, vCdFornecDup, vNrDup, vNrParcelaDup, vPercentualDespesa : Real;
  vVlTotalImposto, vPrTotalImposto, vPrImposto, vVlValor, vVlBaseCalcImp, vVlImpRetencao, vTpEstagio : Real;
  vInValidaDespesaCcusto : Real;
  vInConferida, vInPermLancDtSup, vInDtEntradaEmissao : Boolean;
begin
  voParams := GravaLogGravacao(viParams); (* 'INICIO' *)

  viParams := '';
  putitem(viParams,  'CD_TIPOCLAS_FOR_DUP');
  putitem(viParams,  'CD_CCUSTOPADRAO_FCP');
  putitem(viParams,  'CD_TIPOCLAS_CMP_DUP');
  putitem(viParams,  'CD_TIPOCLAS_PRD_DUP');
  putitem(viParams,  'DT_FECHA_CONTABILIDADE_CP');
  putitem(viParams,  'IN_VALIDA_DESPESA_CCUSTO');

  xParamEmp := T_ADMSVCO001.GetParamEmpresa(piCdEmpresa, xParamEmp); (*itemXml('CD_EMPRESA', *)
  gCdTipoClasForDup := itemXmlF('CD_TIPOCLAS_FOR_DUP', voParams);
  gCdCCustoPadraoFcp := itemXmlF('CD_CCUSTOPADRAO_FCP', voParams);

  gCdTipoClasCmpDup := itemXmlF('CD_TIPOCLAS_CMP_DUP', voParams);
  gCdTipoClasPrdDup := itemXmlF('CD_TIPOCLAS_PRD_DUP', voParams);

  vInValidaDespesaCcusto := itemXmlB('IN_VALIDA_DESPESA_CCUSTO', voParams);

  gDtFechaContabCP := itemXml('DT_FECHA_CONTABILIDADE_CP', voParams);

  vDsDuplicataI := itemXml('DS_DUPLICATAI', pParams);
  vDsComponente := itemXml('DS_COMPONENTE', pParams);
  vInConferida := itemXmlB('IN_CONFERIDAMANUAL', pParams);
  vInPermLancDtSup := itemXmlB('IN_PERM_LANC_DT_SUP', pParams);
  vInDtEntradaEmissao := itemXmlB('IN_DTENTRADAEMISSAO', pParams);
  vVlImpostoRetido := itemXmlF('VL_IMPRETENCAO', pParams);

  if (vDsComponente = '') then begin
    Result := SetStatus(STS_ERROR, 'GEN001', 'Não existe nome do componente chamador da rotina de gravação da duplicata!', cDS_METHOD);
    return(-1); exit;
  end;

  vDtEmissao := itemXml('DT_EMISSAO', vDsDuplicataI);
  vDtLiq := itemXml('DT_LIQ', vDsDuplicataI);

  if (gDtFechaContabCP > 0) then begin
    if (gDtFechaContabCP >= vDtEmissao) then begin
      Result := SetStatus(STS_ERROR, 'GEN001', 'Data emissão dentro do fechamento contábil do contas a pagar! Parâmetro DT_FECHA_CONTABILIDADE_CP', cDS_METHOD);
      return(-1); exit;
    end;
  end;

  gCdEmpresa := itemXmlF('CD_EMPRESA', vDsDuplicataI);
  gCdFornecedor := itemXmlF('CD_FORNECEDOR', vDsDuplicataI);
  gNrDuplicata := itemXmlF('NR_DUPLICATA', vDsDuplicataI);
  gNrParcela := itemXmlF('NR_PARCELA', vDsDuplicataI);
  vTpEstagio := itemXmlF('TP_ESTAGIO', vDsDuplicataI);

  if (vTpEstagio <> 1)  and (vTpEstagio <> 5) then begin
    if (gCdEmpresa > 0)  and (gCdFornecedor > 0)  and (gNrDuplicata > 0)  and (gNrParcela > 0)  and (vDtEmissao <> '')  and (vDtLiq = '') then begin
      clear_e(tF_FCP_DUPLI);
      putitem_o(tF_FCP_DUPLI, 'CD_EMPRESA', gCdEmpresa);
      putitem_o(tF_FCP_DUPLI, 'CD_FORNECEDOR', gCdFornecedor);
      putitem_o(tF_FCP_DUPLI, 'NR_DUPLICATA', gNrDuplicata);
      putitem_o(tF_FCP_DUPLI, 'NR_PARCELA', gNrParcela);
      retrieve_e(tF_FCP_DUPLI);
      if (xStatus < 0) then begin
        viParams := '';
        putitemXml(viParams, 'TP_MODELO', 2);
        putitemXml(viParams, 'DT_PROCESSO', vDtEmissao);
        putitemXml(viParams, 'CD_COMPONENTE', FCPSVCO001);
        putitemXml(viParams, 'DS_COMPLEMENTO', 'Inclusao de Duplicata.');
        voParams := activateCmp('FGRSVCO022', 'validaFechamentoFinanceiro', viParams); (*,,,, *)
        if (xStatus < 0) then begin
          Result := voParams;
          return(-1); exit;
        end;

        viParams := '';
        putitemXml(viParams, 'CD_EMPRESA', gCdEmpresa);
        putitemXml(viParams, 'DT_CHEGADA', itemXml('DT_CHEGADA', vDsDuplicataI));
        putitemXml(viParams, 'TP_INCLUSAO', itemXmlF('TP_INCLUSAO', vDsDuplicataI));
        voParams := activateCmp('FCPSVCO001', 'validaLanctoContabilPeriodo', viParams); (*,,,, *)
        if (xStatus < 0) then begin
          Result := voParams;
          return(-1); exit;
        end;

      end else begin

        if (item_a('DT_LIQ', tF_FCP_DUPLI) = '') then begin
          putitemXml(viParams, 'TP_MODELO', 2);
          putitemXml(viParams, 'DT_PROCESSO', item_a('DT_EMISSAO', tF_FCP_DUPLI));
          putitemXml(viParams, 'CD_COMPONENTE', FCPSVCO001);
          putitemXml(viParams, 'DS_COMPLEMENTO', 'Alteracao de Duplicata.');
          voParams := activateCmp('FGRSVCO022', 'validaFechamentoFinanceiro', viParams); (*,,,, *)
          if (xStatus < 0) then begin
            Result := voParams;
            return(-1); exit;
          end;
        end else begin
          putitemXml(viParams, 'TP_MODELO', 2);
          putitemXml(viParams, 'DT_PROCESSO', item_a('DT_LIQ', tF_FCP_DUPLI));
          putitemXml(viParams, 'CD_COMPONENTE', FCPSVCO001);
          putitemXml(viParams, 'DS_COMPLEMENTO', 'Alteracao de Duplicata.');
          voParams := activateCmp('FGRSVCO022', 'validaFechamentoFinanceiro', viParams); (*,,,, *)
          if (xStatus < 0) then begin
            Result := voParams;
            return(-1); exit;
          end;
        end;
      end;
    end;
    if (gCdEmpresa > 0)  and (gCdFornecedor > 0)  and (gNrDuplicata > 0)  and (gNrParcela > 0)  and (vDtEmissao <> '')  and (vDtLiq = '') then begin
      clear_e(tF_FCP_DUPLI);
      putitem_o(tF_FCP_DUPLI, 'CD_EMPRESA', gCdEmpresa);
      putitem_o(tF_FCP_DUPLI, 'CD_FORNECEDOR', gCdFornecedor);
      putitem_o(tF_FCP_DUPLI, 'NR_DUPLICATA', gNrDuplicata);
      putitem_o(tF_FCP_DUPLI, 'NR_PARCELA', gNrParcela);
      retrieve_e(tF_FCP_DUPLI);
      if (xStatus >=0)  and (item_a('DT_LIQ', tF_FCP_DUPLI) = '') then begin
        putitemXml(viParams, 'TP_MODELO', 2);
        putitemXml(viParams, 'DT_PROCESSO', vDtEmissao);
        putitemXml(viParams, 'CD_COMPONENTE', FCPSVCO001);
        putitemXml(viParams, 'DS_COMPLEMENTO', 'Alteracao de Duplicata.');
        voParams := activateCmp('FGRSVCO022', 'validaFechamentoFinanceiro', viParams); (*,,,, *)
        if (xStatus < 0) then begin
          Result := voParams;
          return(-1); exit;
        end;
      end;
    end;
    if (vDtLiq <> '') then begin
      if (gDtFechaContabCP > 0) then begin
        if (gDtFechaContabCP >= vDtLiq) then begin
          Result := SetStatus(STS_ERROR, 'GEN001', 'Data liquidação dentro fechamento contábil do contas a pagar! Parâmetro DT_FECHA_CONTABILIDADE_CP', cDS_METHOD);
          return(-1); exit;
        end;
      end;
      if (gDtFechaContabCP > 0)  and (item_a('DT_LIQ', tF_FCP_DUPLI) <> '') then begin
        if (gDtFechaContabCP >= item_a('DT_LIQ', tF_FCP_DUPLI)) then begin
          Result := SetStatus(STS_ERROR, 'GEN001', 'Fechamento contábil do contas a pagar já realizado! Parâmetro DT_FECHA_CONTABILIDADE_CP', cDS_METHOD);
          return(-1); exit;
        end;
      end;
      if (vDtLiq <> '') then begin
        viParams := '';
        putitemXml(viParams, 'TP_MODELO', 2);
        putitemXml(viParams, 'DT_PROCESSO', vDtLiq);
        putitemXml(viParams, 'CD_COMPONENTE', FCPSVCO001);
        putitemXml(viParams, 'DS_COMPLEMENTO', 'Baixa de Duplicata.');
        voParams := activateCmp('FGRSVCO022', 'validaFechamentoFinanceiro', viParams); (*,,,, *)
        if (xStatus < 0) then begin
          Result := voParams;
          return(-1); exit;
        end;
      end;
      if (item_a('DT_LIQ', tF_FCP_DUPLI) <> '') then begin
        viParams := '';
        putitemXml(viParams, 'TP_MODELO', 2);
        putitemXml(viParams, 'DT_PROCESSO', item_a('DT_LIQ', tF_FCP_DUPLI));
        putitemXml(viParams, 'CD_COMPONENTE', FCPSVCO001);
        putitemXml(viParams, 'DS_COMPLEMENTO', 'Baixa de Duplicata.');
        voParams := activateCmp('FGRSVCO022', 'validaFechamentoFinanceiro', viParams); (*,,,, *)
        if (xStatus < 0) then begin
          Result := voParams;
          return(-1); exit;
        end;
      end;
    end;
  end;
  if (gNrDuplicata > 0) then begin
  end else begin

    Result := SetStatus(STS_ERROR, 'GEN001', 'Duplicata: Emp.:' + FloatToStr(gCdEmpresa) + ' Fornec.:' + FloatToStr(gCdFornecedor) + ' Nr.:' + FloatToStr(gNrDuplicata) + ' Número da duplicata não informado!', cDS_METHOD);
    return(-1); exit;
  end;

  voParams := GravaLogGravacao(viParams); (* 'RETRIEVE FCP_DUPLICATAC' *)

  clear_e(tFCP_DUPLICATC);
  if (vDsDuplicataI <> '') then begin
    creocc(tFCP_DUPLICATC, -1);
    putitem_e(tFCP_DUPLICATC, 'CD_EMPRESA', itemXmlF('CD_EMPRESA', vDsDuplicataI));
    putitem_e(tFCP_DUPLICATC, 'CD_FORNECEDOR', itemXmlF('CD_FORNECEDOR', vDsDuplicataI));
    putitem_e(tFCP_DUPLICATC, 'NR_DUPLICATA', itemXmlF('NR_DUPLICATA', vDsDuplicataI));

    vCdFornecedor := itemXmlF('CD_FORNECEDOR', vDsDuplicataI);
    if (vCdFornecedor > 0) then begin
      clear_e(tF_PES_FORNECE);
      putitem_o(tF_PES_FORNECE, 'CD_FORNECEDOR', vCdFornecedor);
      retrieve_e(tF_PES_FORNECE);
      if (xStatus < 0) then begin
        Result := SetStatus(STS_ERROR, 'GEN001', 'Duplicata: Emp.:' + item_a('CD_EMPRESA', tFCP_DUPLICATC) + ' Fornec.:' + FloatToStr(vCdFornecedor) + ' Nr.:' + item_a('NR_DUPLICATA', tFCP_DUPLICATC) + ' Código não está cadastrado como fornecedor: ' + FloatToStr(vCdFornecedor) + '!', cDS_METHOD);
        return(-1); exit;
      end;
    end;
    if (item_f('CD_EMPRESA', tFCP_DUPLICATC) = 0) then begin
      Result := SetStatus(STS_ERROR, 'GEN001', 'Duplicata: Emp.:' + item_a('CD_EMPRESA', tFCP_DUPLICATC) + ' Fornec.:' + item_a('CD_FORNECEDOR', tFCP_DUPLICATC) + ' Nr.:' + item_a('NR_DUPLICATA', tFCP_DUPLICATC) + ' Empresa não informada!', cDS_METHOD);
      return(-1); exit;
    end;
    if (item_f('CD_FORNECEDOR', tFCP_DUPLICATC) = 0) then begin
      Result := SetStatus(STS_ERROR, 'GEN001', 'Duplicata: Emp.:' + item_a('CD_EMPRESA', tFCP_DUPLICATC) + ' Fornec.:' + item_a('CD_FORNECEDOR', tFCP_DUPLICATC) + ' Nr.:' + item_a('NR_DUPLICATA', tFCP_DUPLICATC) + ' Fornecedor da duplicata não informado!', cDS_METHOD);
      return(-1); exit;
    end;
    if (item_f('NR_DUPLICATA', tFCP_DUPLICATC) = 0) then begin
      Result := SetStatus(STS_ERROR, 'GEN001', 'Duplicata: Emp.:' + item_a('CD_EMPRESA', tFCP_DUPLICATC) + ' Fornec.:' + item_a('CD_FORNECEDOR', tFCP_DUPLICATC) + ' Nr.:' + item_a('NR_DUPLICATA', tFCP_DUPLICATC) + ' Número da duplicata não informado!', cDS_METHOD);
      return(-1); exit;
    end;

    retrieve_o(tFCP_DUPLICATC);
    if (xStatus = -7) then begin
      retrieve_x(tFCP_DUPLICATC);
    end;

    putitem_e(tFCP_DUPLICATC, 'CD_CONDPAGTO', itemXmlF('CD_CONDPAGTO', pParams));

    if (xStatus = -10)  or (xStatus = -11) then begin
      Result := SetStatus(STS_ERROR, 'GEN001', 'Duplicata: Emp.:' + item_a('CD_EMPRESA', tFCP_DUPLICATC) + ' Fornec.:' + FloatToStr(vCdFornecedor) + ' Nr.:' + item_a('NR_DUPLICATA', tFCP_DUPLICATC) + ' Registro da duplicata bloqueado por outro usuário!', cDS_METHOD);
      voParams := LimpaRegBloq(viParams); (* *)
      return(-1); exit;
    end;

    vNrParcela := itemXmlF('NR_PARCELA', vDsDuplicataI);
    if (vNrParcela > 0) then begin
      clear_e(tFCP_DUPLICATI);
      putitem_e(tFCP_DUPLICATI, 'NR_PARCELA', vNrParcela);
      retrieve_e(tFCP_DUPLICATI);

      if (xStatus = -10)  or (xStatus = -11) then begin
        Result := SetStatus(STS_ERROR, 'GEN001', 'Duplicata: Emp.:' + item_a('CD_EMPRESA', tFCP_DUPLICATI) + ' Fornec.:' + item_a('CD_FORNECEDOR', tFCP_DUPLICATI) + ' Nr.:' + item_a('NR_DUPLICATA', tFCP_DUPLICATI) + ' Parc.:' + item_a('NR_PARCELA', tFCP_DUPLICATI) + ' Registro de item da duplicata bloqueado por outro usuário!', cDS_METHOD);
        voParams := LimpaRegBloq(viParams); (* *)
        return(-1); exit;
      end;
      if (xStatus >= 0) then begin
        vPortadorAnt := item_f('NR_PORTADOR', tFCP_DUPLICATI);
        vVenctoAnt := item_a('DT_VENCIMENTO', tFCP_DUPLICATI);
        vTpPrevisaoAnt := item_f('TP_PREVISAOREAL', tFCP_DUPLICATI);
        vValorAnt := item_f('VL_DUPLICATA', tFCP_DUPLICATI);

        vDsRegDespApr := itemXml('DS_DUPDESPAPR', vDsDuplicataI);
        if (vDsRegDespApr = '')  and (empty(tFCP_DUPDESPAP)=0) then begin
          voParams := GravaLogGravacao(viParams); (* 'LEITURA FCP_DUPDESPAPR' *)

          setocc(tFCP_DUPDESPAP, 1);
          while (xStatus >= 0) do begin
            vDsRegistro := '';
            putlistitensocc_e(vDsRegistro, tFCP_DUPDESPAP);
            putitem(vDsRegDespApr,  vDsRegistro);
            setocc(tFCP_DUPDESPAP, curocc(tFCP_DUPDESPAP) + 1);
          end;
          putitemXml(vDsDuplicataI, 'DS_DUPDESPAPR', vDsRegDespApr);
        end;
        if (empty(tFCP_DUPDESPAP)=0) then begin
          voParams := GravaLogGravacao(viParams); (* 'EXCLUSAO FCP_DUPDESPAPR' *)

          voParams := tFCP_DUPDESPAP.Excluir();
          if (xStatus < 0) then begin
            Result := voParams;
            return(-1); exit;
          end;
        end;

        voParams := GravaLogGravacao(viParams); (* 'EXCLUSAO FCP_DUPDESPESA' *)

        voParams := tFCP_DUPDESPES.Excluir();
        if (xStatus < 0) then begin
          Result := voParams;
          return(-1); exit;
        end;

        voParams := GravaLogGravacao(viParams); (* 'EXCLUSAO FCP_DUPIMPOSTO' *)

        if (empty(tFCP_DUPIMPOST)=0) then begin
          voParams := tFCP_DUPIMPOST.Excluir();
          if (xStatus < 0) then begin
            Result := voParams;
            return(-1); exit;
          end;
        end;

        delitem(vDsDuplicataI, 'CD_EMPRESA');
        delitem(vDsDuplicataI, 'CD_FORNECEDOR');
        delitem(vDsDuplicataI, 'NR_DUPLICATA');
        delitem(vDsDuplicataI, 'NR_PARCELA');
        getlistitensocc_e(vDsDuplicataI, tFCP_DUPLICATI);

        if (itemXml('DT_CHEGADA', vDsDuplicatai) = '') then begin
          putitem_e(tFCP_DUPLICATI, 'DT_CHEGADA', '');
        end;

      end else begin
        if (xStatus = -2) then begin
          clear_e(tFCP_DUPLICATI);
          creocc(tFCP_DUPLICATI, -1);
          getlistitensocc_e(vDsDuplicataI, tFCP_DUPLICATI);

          if (itemXml('DT_CHEGADA', vDsDuplicatai) = '') then begin
            putitem_e(tFCP_DUPLICATI, 'DT_CHEGADA', '');
          end;

        end else begin

          Result := SetStatus(STS_ERROR, 'GEN001', 'Duplicata: Emp.:' + item_a('CD_EMPRESA', tFCP_DUPLICATI) + ' Fornec.:' + item_a('CD_FORNECEDOR', tFCP_DUPLICATI) + ' Nr.:' + item_a('NR_DUPLICATA', tFCP_DUPLICATI) + ' Parc.:' + item_a('NR_PARCELA', tFCP_DUPLICATI) + ' Erro ao recuperar a parcela.', cDS_METHOD);
          return(-1); exit;
        end;
      end;
    end else begin

      clear_e(tFCP_DUPLICATI);
      creocc(tFCP_DUPLICATI, -1);
      getlistitensocc_e(vDsDuplicataI, tFCP_DUPLICATI);

      if (itemXml('DT_CHEGADA', vDsDuplicataI) = '') then begin
        putitem_e(tFCP_DUPLICATI, 'DT_CHEGADA', '');
      end;
    end;

    vDsRegImp := itemXml('DS_DUPIMPOSTO', vDsDuplicataI);
    if (vDsRegImp <> '') then begin
      voParams := GravaLogGravacao(viParams); (* 'GRAVACAO FCP_DUPIMPOSTO' *)

      repeat
        getitem(vDsImposto, vDsRegImp, 1);
        creocc(tFCP_DUPIMPOST, -1);

        getlistitensocc_e(vDsImposto, tFCP_DUPIMPOST);
        delitem(vDsRegImp, 1);
      until (vDsRegImp = '');
      xStatus := 0;
    end;

    if not (empty(FCP_DUPIMPOST)) then begin

      if (item_f('VL_ABATIMENTO', tFCP_DUPLICATI) > 0) then begin
        clear_e(tFCP_DUPABATC);
        putitem_o(tFCP_DUPABATC, 'CD_EMPRESA', item_f('CD_EMPRESA', tFCP_DUPLICATI));
        putitem_o(tFCP_DUPABATC, 'CD_FORNECEDOR', item_f('CD_FORNECEDOR', tFCP_DUPLICATI));
        putitem_o(tFCP_DUPABATC, 'NR_DUPLICATA', item_f('NR_DUPLICATA', tFCP_DUPLICATI));
        putitem_o(tFCP_DUPABATC, 'NR_PARCELA', item_f('NR_PARCELA', tFCP_DUPLICATI));
        retrieve_e(tFCP_DUPABATC);
        if (xStatus >= 0) then begin
          vVlBaseCalcImp := ((item_f('VL_DUPLICATA', tFCP_DUPLICATI) - item_f('VL_INCIDEIMPOSTO', tFCP_DUPABATC)) * item_f('PR_BASECALCIMP', tFCP_DUPLICATI)) / 100;
        end else begin
          vVlBaseCalcImp := ((item_f('VL_DUPLICATA', tFCP_DUPLICATI) - item_f('VL_ABATIMENTO', tFCP_DUPLICATI)) * item_f('PR_BASECALCIMP', tFCP_DUPLICATI)) / 100;
        end;
      end else begin
        vVlBaseCalcImp := (item_f('VL_DUPLICATA', tFCP_DUPLICATI) * item_f('PR_BASECALCIMP', tFCP_DUPLICATI)) / 100;
      end;
      vVlBaseCalcImp := rounded(vVlBaseCalcImp, 2);

      setocc(tFCP_DUPIMPOST, 1);
      while (xStatus >= 0) do begin

        if (item_f('PR_ALIQUOTA', tFCP_DUPIMPOST) < 0) then begin
          Result := SetStatus(STS_ERROR, 'GEN001', 'Duplicata: Emp.:' + item_a('CD_EMPRESA', tFCP_DUPLICATI) + ' Fornec.:' + item_a('CD_FORNECEDOR', tFCP_DUPLICATI) + ' Nr.:' + item_a('NR_DUPLICATA', tFCP_DUPLICATI) + ' Parc.:' + item_a('NR_PARCELA', tFCP_DUPLICATI) + ' Imposto ' + item_a('CD_IMPOSTO', tFCP_DUPIMPOST) + ' com percentual de aliquota inválido.', cDS_METHOD);
          return(-1); exit;
        end;
        if (item_f('VL_IMPOSTO', tFCP_DUPIMPOST) < 0) then begin
          Result := SetStatus(STS_ERROR, 'GEN001', 'Duplicata: Emp.:' + item_a('CD_EMPRESA', tFCP_DUPLICATI) + ' Fornec.:' + item_a('CD_FORNECEDOR', tFCP_DUPLICATI) + ' Nr.:' + item_a('NR_DUPLICATA', tFCP_DUPLICATI) + ' Parc.:' + item_a('NR_PARCELA', tFCP_DUPLICATI) + ' Imposto ' + item_a('CD_IMPOSTO', tFCP_DUPIMPOST) + ' com percentual de aliquota inválido.', cDS_METHOD);
          return(-1); exit;
        end;
        if (item_f('TP_SITUACAO', tFCP_DUPIMPOST) = 0) then begin
          putitem_e(tFCP_DUPIMPOST, 'VL_IMPOSTO', (vVlBaseCalcImp * rounded(item_f('PR_ALIQUOTA', tFCP_DUPIMPOST), 6)) / 100);
          putitem_e(tFCP_DUPIMPOST, 'VL_IMPOSTO', rounded(item_f('VL_IMPOSTO', tFCP_DUPIMPOST), 2));
        end;

        vVlTotalImposto := vVlTotalImposto + rounded(item_f('VL_IMPOSTO', tFCP_DUPIMPOST), 2);
        vPrTotalImposto := vPrTotalImposto + rounded(item_f('PR_ALIQUOTA', tFCP_DUPIMPOST), 6);

        setocc(tFCP_DUPIMPOST, curocc(tFCP_DUPIMPOST) + 1);
      end;

      if rounded((vPrTotalImposto, 2) > 100) then begin

        Result := SetStatus(STS_ERROR, 'GEN001', 'Duplicata: Emp.:' + item_a('CD_EMPRESA', tFCP_DUPLICATI) + ' Fornec.:' + item_a('CD_FORNECEDOR', tFCP_DUPLICATI) + ' Nr.:' + item_a('NR_DUPLICATA', tFCP_DUPLICATI) + ' Parc.:' + item_a('NR_PARCELA', tFCP_DUPLICATI) + ' Percentual de imposto superior a 100 % (Informado: ' + vPrTotalImposto) + '!', cDS_METHOD);
        return(-1); exit;
      end;
    end;

    vDsRegDesp := itemXml('DS_DUPDESPESA', vDsDuplicataI);
    if (vDsRegDesp <> '') then begin
      voParams := GravaLogGravacao(viParams); (* 'GRAVACAO FCP_DUPDESPESA' *)

      repeat
        getitem(vDsDespesa, vDsRegDesp, 1);
        creocc(tFCP_DUPDESPES, -1);

        getlistitensocc_e(vDsDespesa, tFCP_DUPDESPES);

        if (item_f('CD_CCUSTO', tFCP_DUPDESPES) = '')  and (gCdCCustoPadraoFcp > 0) then begin
          putitem_e(tFCP_DUPDESPES, 'CD_CCUSTO', gCdCCustoPadraoFcp);
        end;

        delitem(vDsRegDesp, 1);
      until (vDsRegDesp = '');
      xStatus := 0;
    end;

    vPercentualDespesa := 0;
    if (xStatus >=0) then begin
      setocc(tFCP_DUPDESPES, 1);
      while (xStatus >= 0) do begin

        if (item_f('PR_RATEIO', tFCP_DUPDESPES) < 0) then begin
          Result := SetStatus(STS_ERROR, 'GEN001', 'Duplicata: Emp.:' + item_a('CD_EMPRESA', tFCP_DUPLICATI) + ' Fornec.:' + item_a('CD_FORNECEDOR', tFCP_DUPLICATI) + ' Nr.:' + item_a('NR_DUPLICATA', tFCP_DUPLICATI) + ' Parc.:' + item_a('NR_PARCELA', tFCP_DUPLICATI) + ' Imposto ' + item_a('CD_CCUSTO', tFCP_DUPDESPES) + ' com percentual de aliquota inválido.', cDS_METHOD);
          return(-1); exit;
        end;
        if (item_f('VL_RATEIO', tFCP_DUPDESPES) < 0) then begin
          Result := SetStatus(STS_ERROR, 'GEN001', 'Duplicata: Emp.:' + item_a('CD_EMPRESA', tFCP_DUPLICATI) + ' Fornec.:' + item_a('CD_FORNECEDOR', tFCP_DUPLICATI) + ' Nr.:' + item_a('NR_DUPLICATA', tFCP_DUPLICATI) + ' Parc.:' + item_a('NR_PARCELA', tFCP_DUPLICATI) + ' Imposto ' + item_a('CD_CCUSTO', tFCP_DUPDESPES) + ' com percentual de aliquota inválido.', cDS_METHOD);
          return(-1); exit;
        end;

        vPercentualDespesa := vPercentualDespesa + rounded(item_f('PR_RATEIO', tFCP_DUPDESPES), 6);
        setocc(tFCP_DUPDESPES, curocc(tFCP_DUPDESPES) + 1);
      end;

      vPercentualDespesa := rounded(vPercentualDespesa, 2);

      if (vPercentualDespesa < 100) then begin
        Result := SetStatus(STS_ERROR, 'GEN001', 'Duplicata: Emp.:' + item_a('CD_EMPRESA', tFCP_DUPLICATI) + ' Fornec.:' + item_a('CD_FORNECEDOR', tFCP_DUPLICATI) + ' Nr.:' + item_a('NR_DUPLICATA', tFCP_DUPLICATI) + ' Parc.:' + item_a('NR_PARCELA', tFCP_DUPLICATI) + ' Percentual de despesa informado deve ser 100 % (Informado: ' + vPercentualDespesa) + '!', cDS_METHOD);
        return(-1); exit;
      end;
    end;

    clear_e(tFCP_DUPDESPAP);
    vDsRegDespApr := itemXml('DS_DUPDESPAPR', vDsDuplicataI);
    if (vDsRegDespApr <> '') then begin
      voParams := GravaLogGravacao(viParams); (* 'GRAVACAO FCP_DUPDESPAPR' *)

      repeat
        getitem(vDsDespesaApr, vDsRegDespApr, 1);

        if (itemXml('PR_RATEIO', vDsDespesaApr)<0) then begin
          Result := SetStatus(STS_ERROR, 'GEN001', 'Duplicata: Emp.:' + item_a('CD_EMPRESA', tFCP_DUPLICATI) + ' Fornec.:' + item_a('CD_FORNECEDOR', tFCP_DUPLICATI) + ' Nr.:' + item_a('NR_DUPLICATA', tFCP_DUPLICATI) + ' Parc.:' + item_a('NR_PARCELA', tFCP_DUPLICATI) + ' Apropriação de despesa ' + itemXml(CD_DESPESAITEM, + ' vDsDespesaApr)!', cDS_METHOD);
          return(-1); exit;
        end;
        if (itemXml('VL_RATEIO', vDsDespesaApr)<0) then begin
          Result := SetStatus(STS_ERROR, 'GEN001', 'Duplicata: Emp.:' + item_a('CD_EMPRESA', tFCP_DUPLICATI) + ' Fornec.:' + item_a('CD_FORNECEDOR', tFCP_DUPLICATI) + ' Nr.:' + item_a('NR_DUPLICATA', tFCP_DUPLICATI) + ' Parc.:' + item_a('NR_PARCELA', tFCP_DUPLICATI) + ' Apropriação de despesa ' + itemXml(CD_DESPESAITEM, + ' vDsDespesaApr)!', cDS_METHOD);
          return(-1); exit;
        end;
        if (itemXml('VL_RATEIO', vDsDespesaApr)<0) then begin
        end;
        creocc(tFCP_DUPDESPAP, -1);
        getlistitensocc_e(vDsDespesaApr, tFCP_DUPDESPAP);
        delitem(vDsRegDespApr, 1);
      until (vDsRegDespApr = '');
      xStatus := 0;
    end;
  end;

  setocc(tFCP_DUPLICATI, 1);
  setocc(tFCP_DUPDESPES, 1);
  setocc(tFCP_DUPIMPOST, 1);

  Result := '';

  if (empty(tFCP_DUPLICATI)) then begin
    Result := SetStatus(STS_ERROR, 'GEN001', 'Duplicata: Emp.:' + item_a('CD_EMPRESA', tFCP_DUPLICATI) + ' Fornec.:' + item_a('CD_FORNECEDOR', tFCP_DUPLICATI) + ' Nr.:' + item_a('NR_DUPLICATA', tFCP_DUPLICATI) + ' Parc.:' + item_a('NR_PARCELA', tFCP_DUPLICATI) + ' Não existe parcela da duplicata para ser salva!', cDS_METHOD);
    return(-1); exit;
  end;
  if (item_f('NR_PARCELA', tFCP_DUPLICATI) = 0) then begin
    vNrParcela := '';
    select max(NR_PARCELA) 
    from 'FCP_DUPLICATISVC' 
    where (putitem_e(tFCP_DUPLICATI, 'CD_EMPRESA', item_f('CD_EMPRESA', tFCP_DUPLICATC)    ) and (
              putitem_e(tFCP_DUPLICATI, 'CD_FORNECEDOR', item_f('CD_FORNECEDOR', tFCP_DUPLICATC) ) and (
            putitem_e(tFCP_DUPLICATI, 'NR_DUPLICATA', item_f('NR_DUPLICATA', tFCP_DUPLICATC))
    to vNrParcela;
    if (xStatus < 0) then begin
      voParams := SetErroOpr(viParams); (* xProcerrorcontext, xCdErro, xCtxErro *)
      return(-1); exit;
    end else begin
      if (vNrParcela > 0) then begin
        vNrParcela := vNrParcela + 1;
      end else begin
        vNrParcela := 1;
      end;
    end;
    putitem_e(tFCP_DUPLICATI, 'NR_PARCELA', vNrParcela);
  end;
  if (item_a('DT_CHEGADA', tFCP_DUPLICATI) = '') then begin
    voParams := GravaLogGravacao(viParams); (* 'ALTERACAO DATA CHEGADA' *)

    putitem_e(tFCP_DUPLICATI, 'DT_CHEGADA', item_a('DT_EMISSAO', tFCP_DUPLICATI));
  end;
  if (item_a('DT_EMISSAO', tFCP_DUPLICATI) = 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN001', 'Duplicata: Emp.:' + item_a('CD_EMPRESA', tFCP_DUPLICATI) + ' Fornec.:' + item_a('CD_FORNECEDOR', tFCP_DUPLICATI) + ' Nr.:' + item_a('NR_DUPLICATA', tFCP_DUPLICATI) + ' Parc.:' + item_a('NR_PARCELA', tFCP_DUPLICATI) + ' Data emissão não encontrada!', cDS_METHOD);
    return(-1); exit;
  end;
  if (item_a('DT_VENCIMENTO', tFCP_DUPLICATI) = 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN001', 'Duplicata: Emp.:' + item_a('CD_EMPRESA', tFCP_DUPLICATI) + ' Fornec.:' + item_a('CD_FORNECEDOR', tFCP_DUPLICATI) + ' Nr.:' + item_a('NR_DUPLICATA', tFCP_DUPLICATI) + ' Parc.:' + item_a('NR_PARCELA', tFCP_DUPLICATI) + ' Data vencimento não encontrada!', cDS_METHOD);
    return(-1); exit;
  end else begin
    if (item_a('DT_VENCIMENTO', tFCP_DUPLICATI) <> vVenctoAnt)  and (vVenctoAnt <> '') then begin
      voParams := GravaLogGravacao(viParams); (* 'GRAVACAO LOG ALTERACAO VENCTO' *)

      viParams := '';
      putitemXml(viParams, 'CD_EMPRESA', item_f('CD_EMPRESA', tFCP_DUPLICATI));
      putitemXml(viParams, 'CD_FORNECEDOR', item_f('CD_FORNECEDOR', tFCP_DUPLICATI));
      putitemXml(viParams, 'NR_DUPLICATA', item_f('NR_DUPLICATA', tFCP_DUPLICATI));
      putitemXml(viParams, 'NR_PARCELA', item_f('NR_PARCELA', tFCP_DUPLICATI));
      putitemXml(viParams, 'TP_LOGDUP', 3);
      putitemXml(viParams, 'DT_ORIGEM', vVenctoAnt);
      putitemXml(viParams, 'DT_DESTINO', item_a('DT_VENCIMENTO', tFCP_DUPLICATI));
      putitemXml(viParams, 'DS_COMPONENTE', vDsComponente);
      voParams := gravaLogDuplicata(viParams); (* PARAM_GLB, viParams, voParams, xCdErro, xCtxErro *)
      if (xStatus < 0) then begin
        Result := SetStatus(STS_ERROR, xProcerror, 'xProcerrorcontext', cDS_METHOD);
        return(-1); exit;
      end;
    end;
  end;
  if (item_f('TP_PREVISAOREAL', tFCP_DUPLICATI) = '') then begin
    Result := SetStatus(STS_ERROR, 'GEN001', 'Duplicata: Emp.:' + item_a('CD_EMPRESA', tFCP_DUPLICATI) + ' Fornec.:' + item_a('CD_FORNECEDOR', tFCP_DUPLICATI) + ' Nr.:' + item_a('NR_DUPLICATA', tFCP_DUPLICATI) + ' Parc.:' + item_a('NR_PARCELA', tFCP_DUPLICATI) + ' Tipo de previsão/real/consignação com problema!', cDS_METHOD);
    return(-1); exit;
  end else begin
    if (item_f('TP_PREVISAOREAL', tFCP_DUPLICATI) <> vTpPrevisaoAnt)  and (vTpPrevisaoAnt <> '') then begin
      voParams := GravaLogGravacao(viParams); (* 'GRAVACAO LOG ALTERACAO PREVISAO' *)

      viParams := '';
      putitemXml(viParams, 'CD_EMPRESA', item_f('CD_EMPRESA', tFCP_DUPLICATI));
      putitemXml(viParams, 'CD_FORNECEDOR', item_f('CD_FORNECEDOR', tFCP_DUPLICATI));
      putitemXml(viParams, 'NR_DUPLICATA', item_f('NR_DUPLICATA', tFCP_DUPLICATI));
      putitemXml(viParams, 'NR_PARCELA', item_f('NR_PARCELA', tFCP_DUPLICATI));
      putitemXml(viParams, 'TP_LOGDUP', 15);
      putitemXml(viParams, 'DS_ORIGEM', vTpPrevisaoAnt);
      putitemXml(viParams, 'DS_DESTINO', item_f('TP_PREVISAOREAL', tFCP_DUPLICATI));
      putitemXml(viParams, 'DS_OBS', 'ALTERACAO DO CAMPO TP. PREVISAO');
      putitemXml(viParams, 'DS_COMPONENTE', vDsComponente);
      voParams := gravaLogDuplicata(viParams); (* PARAM_GLB, viParams, voParams, xCdErro, xCtxErro *)
      if (xStatus < 0) then begin
        Result := SetStatus(STS_ERROR, xProcerror, 'xProcerrorcontext', cDS_METHOD);
        return(-1); exit;
      end;
    end;
  end;
  if (item_a('DT_EMISSAO', tFCP_DUPLICATI) > item_a('DT_VENCIMENTO', tFCP_DUPLICATI)) then begin
    Result := SetStatus(STS_ERROR, 'GEN001', 'Duplicata: Emp.:' + item_a('CD_EMPRESA', tFCP_DUPLICATI) + ' Fornec.:' + item_a('CD_FORNECEDOR', tFCP_DUPLICATI) + ' Nr.:' + item_a('NR_DUPLICATA', tFCP_DUPLICATI) + ' Parc.:' + item_a('NR_PARCELA', tFCP_DUPLICATI) + ' Parcela com data emissão maior que data vencimento!', cDS_METHOD);
    return(-1); exit;
  end;
  if (item_f('VL_DUPLICATA', tFCP_DUPLICATI) <= 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN001', 'Duplicata: Emp.:' + item_a('CD_EMPRESA', tFCP_DUPLICATI) + ' Fornec.:' + item_a('CD_FORNECEDOR', tFCP_DUPLICATI) + ' Nr.:' + item_a('NR_DUPLICATA', tFCP_DUPLICATI) + ' Parc.:' + item_a('NR_PARCELA', tFCP_DUPLICATI) + ' Parcela com valor incorreto!', cDS_METHOD);
    return(-1); exit;
  end else begin
    if (item_f('VL_DUPLICATA', tFCP_DUPLICATI) <> vValorAnt)  and (vValorAnt <> '') then begin
      voParams := GravaLogGravacao(viParams); (* 'GRAVACAO LOG ALTERACAO VALOR' *)

      viParams := '';
      putitemXml(viParams, 'CD_EMPRESA', item_f('CD_EMPRESA', tFCP_DUPLICATI));
      putitemXml(viParams, 'CD_FORNECEDOR', item_f('CD_FORNECEDOR', tFCP_DUPLICATI));
      putitemXml(viParams, 'NR_DUPLICATA', item_f('NR_DUPLICATA', tFCP_DUPLICATI));
      putitemXml(viParams, 'NR_PARCELA', item_f('NR_PARCELA', tFCP_DUPLICATI));
      putitemXml(viParams, 'TP_LOGDUP', 2);
      putitemXml(viParams, 'VL_ORIGEM', vValorAnt);
      putitemXml(viParams, 'VL_DESTINO', item_f('VL_DUPLICATA', tFCP_DUPLICATI));
      putitemXml(viParams, 'DS_COMPONENTE', vDsComponente);
      voParams := gravaLogDuplicata(viParams); (* PARAM_GLB, viParams, voParams, xCdErro, xCtxErro *)
      if (xStatus < 0) then begin
        Result := SetStatus(STS_ERROR, xProcerror, 'xProcerrorcontext', cDS_METHOD);
        return(-1); exit;
      end;
    end;
  end;
  if (item_f('NR_PORTADOR', tFCP_DUPLICATI) = 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN001', 'Duplicata: Emp.:' + item_a('CD_EMPRESA', tFCP_DUPLICATI) + ' Fornec.:' + item_a('CD_FORNECEDOR', tFCP_DUPLICATI) + ' Nr.:' + item_a('NR_DUPLICATA', tFCP_DUPLICATI) + ' Parc.:' + item_a('NR_PARCELA', tFCP_DUPLICATI) + ' Parcela sem portador!', cDS_METHOD);
    return(-1); exit;
  end else begin
    if (item_f('NR_PORTADOR', tFCP_DUPLICATI) <> vPortadorAnt)  and (vPortadorAnt <> 0) then begin
      voParams := GravaLogGravacao(viParams); (* 'GRAVACAO LOG ALTERACAO PORTADOR' *)

      viParams := '';
      putitemXml(viParams, 'CD_EMPRESA', item_f('CD_EMPRESA', tFCP_DUPLICATI));
      putitemXml(viParams, 'CD_FORNECEDOR', item_f('CD_FORNECEDOR', tFCP_DUPLICATI));
      putitemXml(viParams, 'NR_DUPLICATA', item_f('NR_DUPLICATA', tFCP_DUPLICATI));
      putitemXml(viParams, 'NR_PARCELA', item_f('NR_PARCELA', tFCP_DUPLICATI));
      putitemXml(viParams, 'TP_LOGDUP', 1);
      putitemXml(viParams, 'NR_ORIGEM', vPortadorAnt);
      putitemXml(viParams, 'NR_DESTINO', item_f('NR_PORTADOR', tFCP_DUPLICATI));
      putitemXml(viParams, 'DS_COMPONENTE', vDsComponente);
      voParams := gravaLogDuplicata(viParams); (* PARAM_GLB, viParams, voParams, xCdErro, xCtxErro *)
      if (xStatus < 0) then begin
        Result := SetStatus(STS_ERROR, xProcerror, 'xProcerrorcontext', cDS_METHOD);
        return(-1); exit;
      end;
    end;
  end;
  if (item_f('TP_PREVISAOREAL', tFCP_DUPLICATI) = 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN001', 'Duplicata: Emp.:' + item_a('CD_EMPRESA', tFCP_DUPLICATI) + ' Fornec.:' + item_a('CD_FORNECEDOR', tFCP_DUPLICATI) + ' Nr.:' + item_a('NR_DUPLICATA', tFCP_DUPLICATI) + ' Parc.:' + item_a('NR_PARCELA', tFCP_DUPLICATI) + ' Parcela sem tipo previsão!', cDS_METHOD);
    return(-1); exit;
  end;
  if (item_f('TP_SITUACAO', tFCP_DUPLICATI) = '') then begin
    Result := SetStatus(STS_ERROR, 'GEN001', 'Duplicata: Emp.:' + item_a('CD_EMPRESA', tFCP_DUPLICATI) + ' Fornec.:' + item_a('CD_FORNECEDOR', tFCP_DUPLICATI) + ' Nr.:' + item_a('NR_DUPLICATA', tFCP_DUPLICATI) + ' Parc.:' + item_a('NR_PARCELA', tFCP_DUPLICATI) + ' Parcela sem tipo de situação!', cDS_METHOD);
    return(-1); exit;
  end;
  if (item_f('TP_DOCUMENTO', tFCP_DUPLICATI) = 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Duplicata: Emp.:' + item_a('CD_EMPRESA', tFCP_DUPLICATI) + ' Fornec.:' + item_a('CD_FORNECEDOR', tFCP_DUPLICATI) + ' Nr.:' + item_a('NR_DUPLICATA', tFCP_DUPLICATI) + ' Parc.:' + item_a('NR_PARCELA', tFCP_DUPLICATI) + ' Parcela sem tipo documento!', cDS_METHOD);
    return(-1); exit;
  end;
  if (item_a('DT_EMISSAO', tFCP_DUPLICATI) > item_a('DT_CHEGADA', tFCP_DUPLICATI))  and (item_a('DT_CHEGADA', tFCP_DUPLICATI) <> '') then begin
    Result := SetStatus(STS_ERROR, 'GEN001', 'Duplicata: Emp.:' + item_a('CD_EMPRESA', tFCP_DUPLICATI) + ' Fornec.:' + item_a('CD_FORNECEDOR', tFCP_DUPLICATI) + ' Nr.:' + item_a('NR_DUPLICATA', tFCP_DUPLICATI) + ' Parc.:' + item_a('NR_PARCELA', tFCP_DUPLICATI) + ' Parcela com data emissão maior que data de chegada!', cDS_METHOD);
    return(-1); exit;
  end;
  if (vInPermLancDtSup <> True)  and (vInDtEntradaEmissao = True) then begin
    if (item_a('DT_EMISSAO', tFCP_DUPLICATI) > item_a('DT_ENTRADA', tFCP_DUPLICATI))  and (item_a('DT_ENTRADA', tFCP_DUPLICATI) <> '') then begin
      Result := SetStatus(STS_ERROR, 'GEN001', 'Duplicata: Emp.:' + item_a('CD_EMPRESA', tFCP_DUPLICATI) + ' Fornec.:' + item_a('CD_FORNECEDOR', tFCP_DUPLICATI) + ' Nr.:' + item_a('NR_DUPLICATA', tFCP_DUPLICATI) + ' Parc.:' + item_a('NR_PARCELA', tFCP_DUPLICATI) + ' Parcela com data emissão maior que data de lançamento!', cDS_METHOD);
      return(-1); exit;
    end;
  end;
  if (item_a('DT_SAIDAFORN', tFCP_DUPLICATI) > item_a('DT_CHEGADA', tFCP_DUPLICATI)) then begin
    Result := SetStatus(STS_ERROR, 'GEN001', 'Duplicata: Emp.:' + item_a('CD_EMPRESA', tFCP_DUPLICATI) + ' Fornec.:' + item_a('CD_FORNECEDOR', tFCP_DUPLICATI) + ' Nr.:' + item_a('NR_DUPLICATA', tFCP_DUPLICATI) + ' Parc.:' + item_a('NR_PARCELA', tFCP_DUPLICATI) + ' Parcela com data saida do fornecedor maior que data de chegada!', cDS_METHOD);
    return(-1); exit;
  end;
  if (item_f('PR_MORADIA', tFCP_DUPLICATI) >= 100) then begin
    Result := SetStatus(STS_ERROR, 'GEN001', 'Duplicata: Emp.:' + item_a('CD_EMPRESA', tFCP_DUPLICATI) + ' Fornec.:' + item_a('CD_FORNECEDOR', tFCP_DUPLICATI) + ' Nr.:' + item_a('NR_DUPLICATA', tFCP_DUPLICATI) + ' Parc.:' + item_a('NR_PARCELA', tFCP_DUPLICATI) + ' Percentual mora dia maior que 100%!', cDS_METHOD);
    return(-1); exit;
  end;
  if (item_f('PR_MULTA', tFCP_DUPLICATI) >= 100) then begin
    Result := SetStatus(STS_ERROR, 'GEN001', 'Duplicata: Emp.:' + item_a('CD_EMPRESA', tFCP_DUPLICATI) + ' Fornec.:' + item_a('CD_FORNECEDOR', tFCP_DUPLICATI) + ' Nr.:' + item_a('NR_DUPLICATA', tFCP_DUPLICATI) + ' Parc.:' + item_a('NR_PARCELA', tFCP_DUPLICATI) + ' Percentual multa maior que 100%!', cDS_METHOD);
    return(-1); exit;
  end;
  if (item_f('PR_DESCPONTUAL', tFCP_DUPLICATI) >= 100) then begin
    Result := SetStatus(STS_ERROR, 'GEN001', 'Duplicata: Emp.:' + item_a('CD_EMPRESA', tFCP_DUPLICATI) + ' Fornec.:' + item_a('CD_FORNECEDOR', tFCP_DUPLICATI) + ' Nr.:' + item_a('NR_DUPLICATA', tFCP_DUPLICATI) + ' Parc.:' + item_a('NR_PARCELA', tFCP_DUPLICATI) + ' Percentual desc. pontualidade maior que 100%!', cDS_METHOD);
    return(-1); exit;
  end;
  if (item_f('PR_DESCANTECIP1', tFCP_DUPLICATI) >= 100) then begin
    Result := SetStatus(STS_ERROR, 'GEN001', 'Duplicata: Emp.:' + item_a('CD_EMPRESA', tFCP_DUPLICATI) + ' Fornec.:' + item_a('CD_FORNECEDOR', tFCP_DUPLICATI) + ' Nr.:' + item_a('NR_DUPLICATA', tFCP_DUPLICATI) + ' Parc.:' + item_a('NR_PARCELA', tFCP_DUPLICATI) + ' Percentual desc. adiantamento 1 maior que 100%!', cDS_METHOD);
    return(-1); exit;
  end;
  if (item_f('PR_DESCANTECIP2', tFCP_DUPLICATI) >= 100) then begin
    Result := SetStatus(STS_ERROR, 'GEN001', 'Duplicata: Emp.:' + item_a('CD_EMPRESA', tFCP_DUPLICATI) + ' Fornec.:' + item_a('CD_FORNECEDOR', tFCP_DUPLICATI) + ' Nr.:' + item_a('NR_DUPLICATA', tFCP_DUPLICATI) + ' Parc.:' + item_a('NR_PARCELA', tFCP_DUPLICATI) + ' Percentual desc. adiantamento 2 maior que 100%!', cDS_METHOD);
    return(-1); exit;
  end;

  vVlTotalPerc := item_f('PR_MORADIA', tFCP_DUPLICATI) + item_f('PR_MULTA', tFCP_DUPLICATI) + item_f('PR_DESCPONTUAL', tFCP_DUPLICATI);
  vVlTotalPerc := vVlTotalPerc + item_f('PR_DESCANTECIP1', tFCP_DUPLICATI) + item_f('PR_DESCANTECIP2', tFCP_DUPLICATI);

  if (item_f('VL_ABATIMENTO', tFCP_DUPLICATI) > item_f('VL_DUPLICATA', tFCP_DUPLICATI)) then begin
    Result := SetStatus(STS_ERROR, 'GEN001', 'Duplicata: Emp.:' + item_a('CD_EMPRESA', tFCP_DUPLICATI) + ' Fornec.:' + item_a('CD_FORNECEDOR', tFCP_DUPLICATI) + ' Nr.:' + item_a('NR_DUPLICATA', tFCP_DUPLICATI) + ' Parc.:' + item_a('NR_PARCELA', tFCP_DUPLICATI) + ' Valor de abatimento maior que o valor da duplicata!', cDS_METHOD);
    return(-1); exit;
  end;
  if (item_f('VL_INDENIZACAO', tFCP_DUPLICATI) >= item_f('VL_DUPLICATA', tFCP_DUPLICATI)) then begin
    Result := SetStatus(STS_ERROR, 'GEN001', 'Duplicata: Emp.:' + item_a('CD_EMPRESA', tFCP_DUPLICATI) + ' Fornec.:' + item_a('CD_FORNECEDOR', tFCP_DUPLICATI) + ' Nr.:' + item_a('NR_DUPLICATA', tFCP_DUPLICATI) + ' Parc.:' + item_a('NR_PARCELA', tFCP_DUPLICATI) + ' Valor de indenização maior que o valor da duplicata.', cDS_METHOD);
    return(-1); exit;
  end;
  if (item_f('VL_OUTROSDESC', tFCP_DUPLICATI) >= item_f('VL_DUPLICATA', tFCP_DUPLICATI)) then begin
    Result := SetStatus(STS_ERROR, 'GEN001', 'Duplicata: Emp.:' + item_a('CD_EMPRESA', tFCP_DUPLICATI) + ' Fornec.:' + item_a('CD_FORNECEDOR', tFCP_DUPLICATI) + ' Nr.:' + item_a('NR_DUPLICATA', tFCP_DUPLICATI) + ' Parc.:' + item_a('NR_PARCELA', tFCP_DUPLICATI) + ' Valor de outros descontos maior que o valor da duplicata!', cDS_METHOD);
    return(-1); exit;
  end;
  if (item_f('VL_DESCPONTUAL', tFCP_DUPLICATI) >= item_f('VL_DUPLICATA', tFCP_DUPLICATI)) then begin
    Result := SetStatus(STS_ERROR, 'GEN001', 'Duplicata: Emp.:' + item_a('CD_EMPRESA', tFCP_DUPLICATI) + ' Fornec.:' + item_a('CD_FORNECEDOR', tFCP_DUPLICATI) + ' Nr.:' + item_a('NR_DUPLICATA', tFCP_DUPLICATI) + ' Parc.:' + item_a('NR_PARCELA', tFCP_DUPLICATI) + ' Valor de desconto pontual maior que o valor da duplicata!', cDS_METHOD);
    return(-1); exit;
  end;
  if (item_f('VL_DESCANTECIP1', tFCP_DUPLICATI) >= item_f('VL_DUPLICATA', tFCP_DUPLICATI)) then begin
    Result := SetStatus(STS_ERROR, 'GEN001', 'Duplicata: Emp.:' + item_a('CD_EMPRESA', tFCP_DUPLICATI) + ' Fornec.:' + item_a('CD_FORNECEDOR', tFCP_DUPLICATI) + ' Nr.:' + item_a('NR_DUPLICATA', tFCP_DUPLICATI) + ' Parc.:' + item_a('NR_PARCELA', tFCP_DUPLICATI) + ' Valor de desconto adiantamento 1 maior que o valor da duplicata!', cDS_METHOD);
    return(-1); exit;
  end;
  if (item_f('VL_DESCANTECIP2', tFCP_DUPLICATI) >= item_f('VL_DUPLICATA', tFCP_DUPLICATI)) then begin
    Result := SetStatus(STS_ERROR, 'GEN001', 'Duplicata: Emp.:' + item_a('CD_EMPRESA', tFCP_DUPLICATI) + ' Fornec.:' + item_a('CD_FORNECEDOR', tFCP_DUPLICATI) + ' Nr.:' + item_a('NR_DUPLICATA', tFCP_DUPLICATI) + ' Parc.:' + item_a('NR_PARCELA', tFCP_DUPLICATI) + ' Valor de desconto adiantamento 2 maior que o valor da duplicata!', cDS_METHOD);
    return(-1); exit;
  end;

  vVlTotalDesc := (item_f('VL_DUPLICATA', tFCP_DUPLICATI) * vVlTotalPerc) / 100;

  vVlTotalDesc := vVlTotalDesc + item_f('VL_ABATIMENTO', tFCP_DUPLICATI)   + item_f('VL_INDENIZACAO', tFCP_DUPLICATI) + item_f('VL_OUTROSDESC', tFCP_DUPLICATI) + item_f('VL_DESCPONTUAL', tFCP_DUPLICATI);

  vVlTotalDesc := vVlTotalDesc + item_f('VL_DESCANTECIP1', tFCP_DUPLICATI) + item_f('VL_DESCANTECIP2', tFCP_DUPLICATI);

  if (vVlTotalDesc > item_f('VL_DUPLICATA', tFCP_DUPLICATI)) then begin
    Result := SetStatus(STS_ERROR, 'GEN001', 'Duplicata: Emp.:' + item_a('CD_EMPRESA', tFCP_DUPLICATI) + ' Fornec.:' + item_a('CD_FORNECEDOR', tFCP_DUPLICATI) + ' Nr.:' + item_a('NR_DUPLICATA', tFCP_DUPLICATI) + ' Parc.:' + item_a('NR_PARCELA', tFCP_DUPLICATI) + ' Valor de descontos maior que o valor da duplicata!', cDS_METHOD);
    return(-1); exit;
  end;
  if (item_f('TP_INCLUSAO', tFCP_DUPLICATI) = 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN001', 'Duplicata: Emp.:' + item_a('CD_EMPRESA', tFCP_DUPLICATI) + ' Fornec.:' + item_a('CD_FORNECEDOR', tFCP_DUPLICATI) + ' Nr.:' + item_a('NR_DUPLICATA', tFCP_DUPLICATI) + ' Parc.:' + item_a('NR_PARCELA', tFCP_DUPLICATI) + ' Parcela sem tipo de inclusão!', cDS_METHOD);
    return(-1); exit;
  end;
  if (item_f('PR_BASECALCIMP', tFCP_DUPLICATI) > 100) then begin
    Result := SetStatus(STS_ERROR, 'GEN001', 'Duplicata: Emp.:' + item_a('CD_EMPRESA', tFCP_DUPLICATI) + ' Fornec.:' + item_a('CD_FORNECEDOR', tFCP_DUPLICATI) + ' Nr.:' + item_a('NR_DUPLICATA', tFCP_DUPLICATI) + ' Parc.:' + item_a('NR_PARCELA', tFCP_DUPLICATI) + ' Percentual de base de cálculo de retenção de imposto superior a 100 %', cDS_METHOD);
    return(-1); exit;
  end;
  if (item_f('VL_MORADIA', tFCP_DUPLICATI) <> 0)  and (item_f('PR_MORADIA', tFCP_DUPLICATI) <> 0)  and (item_f('TP_INCLUSAO', tFCP_DUPLICATI) <> 9) then begin
    Result := SetStatus(STS_ERROR, 'GEN001', 'Duplicata: Emp.:' + item_a('CD_EMPRESA', tFCP_DUPLICATI) + ' Fornec.:' + item_a('CD_FORNECEDOR', tFCP_DUPLICATI) + ' Nr.:' + item_a('NR_DUPLICATA', tFCP_DUPLICATI) + ' Parc.:' + item_a('NR_PARCELA', tFCP_DUPLICATI) + ' Informe somente valor ou percentual para mora dia!', cDS_METHOD);
    return(-1); exit;
  end;
  if (item_f('VL_DESCPONTUAL', tFCP_DUPLICATI) <> 0)  and (item_f('PR_DESCPONTUAL', tFCP_DUPLICATI) <> 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN001', 'Duplicata: Emp.:' + item_a('CD_EMPRESA', tFCP_DUPLICATI) + ' Fornec.:' + item_a('CD_FORNECEDOR', tFCP_DUPLICATI) + ' Nr.:' + item_a('NR_DUPLICATA', tFCP_DUPLICATI) + ' Parc.:' + item_a('NR_PARCELA', tFCP_DUPLICATI) + ' Informe somente valor ou percentual para desconto pontualidade!', cDS_METHOD);
    return(-1); exit;
  end;
  if (item_f('VL_DESCANTECIP1', tFCP_DUPLICATI) <> 0)  and (item_f('PR_DESCANTECIP1', tFCP_DUPLICATI) <> 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN001', 'Informe somente valor ou percentual para desconto adiantamento 1!', cDS_METHOD);
    return(-1); exit;
  end else begin
    if (item_f('VL_DESCANTECIP1', tFCP_DUPLICATI) <> 0)  or (item_f('PR_DESCANTECIP1', tFCP_DUPLICATI) <> 0) then begin
      if (item_a('DT_DESCANTECIP1', tFCP_DUPLICATI) = 0) then begin
        Result := SetStatus(STS_ERROR, 'GEN001', 'Duplicata: Emp.:' + item_a('CD_EMPRESA', tFCP_DUPLICATI) + ' Fornec.:' + item_a('CD_FORNECEDOR', tFCP_DUPLICATI) + ' Nr.:' + item_a('NR_DUPLICATA', tFCP_DUPLICATI) + ' Parc.:' + item_a('NR_PARCELA', tFCP_DUPLICATI) + ' Informe a data para desconto adiantamento 1!', cDS_METHOD);
        return(-1); exit;
      end;
    end;
  end;
  if (item_f('VL_DESCANTECIP2', tFCP_DUPLICATI) <> 0)  and (item_f('PR_DESCANTECIP2', tFCP_DUPLICATI) <> 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN001', 'Duplicata: Emp.:' + item_a('CD_EMPRESA', tFCP_DUPLICATI) + ' Fornec.:' + item_a('CD_FORNECEDOR', tFCP_DUPLICATI) + ' Nr.:' + item_a('NR_DUPLICATA', tFCP_DUPLICATI) + ' Parc.:' + item_a('NR_PARCELA', tFCP_DUPLICATI) + ' Informe somente valor ou percentual para desconto adiantamento 2!', cDS_METHOD);
    return(-1); exit;
  end else begin
    if (item_f('VL_DESCANTECIP2', tFCP_DUPLICATI) <> 0)  or (item_f('PR_DESCANTECIP2', tFCP_DUPLICATI) <> 0) then begin
      if (item_a('DT_DESCANTECIP2', tFCP_DUPLICATI) = 0) then begin
        Result := SetStatus(STS_ERROR, 'GEN001', 'Duplicata: Emp.:' + item_a('CD_EMPRESA', tFCP_DUPLICATI) + ' Fornec.:' + item_a('CD_FORNECEDOR', tFCP_DUPLICATI) + ' Nr.:' + item_a('NR_DUPLICATA', tFCP_DUPLICATI) + ' Parc.:' + item_a('NR_PARCELA', tFCP_DUPLICATI) + ' Informe a data para desconto adiantamento 2!', cDS_METHOD);
        return(-1); exit;
      end;
    end;
  end;
  if (item_f('VL_DESCPONTUAL', tFCP_DUPLICATI) <> 0) then begin
    if (item_f('TP_DESCANTECIPP', tFCP_DUPLICATI) = 2)  or (item_f('TP_DESCANTECIPP', tFCP_DUPLICATI) = 5)  or (item_f('TP_DESCANTECIPP', tFCP_DUPLICATI) = 6) then begin
      Result := SetStatus(STS_ERROR, 'GEN001', 'Duplicata: Emp.:' + item_a('CD_EMPRESA', tFCP_DUPLICATI) + ' Fornec.:' + item_a('CD_FORNECEDOR', tFCP_DUPLICATI) + ' Nr.:' + item_a('NR_DUPLICATA', tFCP_DUPLICATI) + ' Parc.:' + item_a('NR_PARCELA', tFCP_DUPLICATI) + ' Foi selecionado um desconto de pontualidade do tipo percentual. Selecione outro tipo!', cDS_METHOD);
      return(-1); exit;
    end;
  end;
  if (item_f('PR_DESCPONTUAL', tFCP_DUPLICATI) <> 0) then begin
    if (item_f('TP_DESCANTECIPP', tFCP_DUPLICATI) = 1)  or (item_f('TP_DESCANTECIPP', tFCP_DUPLICATI) = 3)  or (item_f('TP_DESCANTECIPP', tFCP_DUPLICATI) = 4) then begin
      Result := SetStatus(STS_ERROR, 'GEN001', 'Duplicata: Emp.:' + item_a('CD_EMPRESA', tFCP_DUPLICATI) + ' Fornec.:' + item_a('CD_FORNECEDOR', tFCP_DUPLICATI) + ' Nr.:' + item_a('NR_DUPLICATA', tFCP_DUPLICATI) + ' Parc.:' + item_a('NR_PARCELA', tFCP_DUPLICATI) + ' Foi selecionado um desconto de pontualidade do tipo valor. Selecione outro tipo!', cDS_METHOD);
      return(-1); exit;
    end;
  end;
  if (item_f('VL_DESCANTECIP1', tFCP_DUPLICATI) <> 0) then begin
    if (item_f('TP_DESCANTECIP1', tFCP_DUPLICATI) = 2)  or (item_f('TP_DESCANTECIP1', tFCP_DUPLICATI) = 5)  or (item_f('TP_DESCANTECIP1', tFCP_DUPLICATI) = 6) then begin
      Result := SetStatus(STS_ERROR, 'GEN001', 'Duplicata: Emp.:' + item_a('CD_EMPRESA', tFCP_DUPLICATI) + ' Fornec.:' + item_a('CD_FORNECEDOR', tFCP_DUPLICATI) + ' Nr.:' + item_a('NR_DUPLICATA', tFCP_DUPLICATI) + ' Parc.:' + item_a('NR_PARCELA', tFCP_DUPLICATI) + ' Foi selecionado um desconto de antecipação(1) do tipo percentual. Selecione outro tipo!', cDS_METHOD);
      return(-1); exit;
    end;
  end;
  if (item_f('PR_DESCANTECIP1', tFCP_DUPLICATI) <> 0) then begin
    if (item_f('TP_DESCANTECIP1', tFCP_DUPLICATI) = 1)  or (item_f('TP_DESCANTECIP1', tFCP_DUPLICATI) = 3)  or (item_f('TP_DESCANTECIP1', tFCP_DUPLICATI) = 4) then begin
      Result := SetStatus(STS_ERROR, 'GEN001', 'Duplicata: Emp.:' + item_a('CD_EMPRESA', tFCP_DUPLICATI) + ' Fornec.:' + item_a('CD_FORNECEDOR', tFCP_DUPLICATI) + ' Nr.:' + item_a('NR_DUPLICATA', tFCP_DUPLICATI) + ' Parc.:' + item_a('NR_PARCELA', tFCP_DUPLICATI) + ' Foi selecionado um desconto de antecipação(1) do tipo valor. Selecione outro tipo!', cDS_METHOD);
      return(-1); exit;
    end;
  end;
  if (item_f('VL_DESCANTECIP2', tFCP_DUPLICATI) <> 0) then begin
    if (item_f('TP_DESCANTECIP2', tFCP_DUPLICATI) = 2)  or (item_f('TP_DESCANTECIP2', tFCP_DUPLICATI) = 5)  or (item_f('TP_DESCANTECIP2', tFCP_DUPLICATI) = 6) then begin
      Result := SetStatus(STS_ERROR, 'GEN001', 'Duplicata: Emp.:' + item_a('CD_EMPRESA', tFCP_DUPLICATI) + ' Fornec.:' + item_a('CD_FORNECEDOR', tFCP_DUPLICATI) + ' Nr.:' + item_a('NR_DUPLICATA', tFCP_DUPLICATI) + ' Parc.:' + item_a('NR_PARCELA', tFCP_DUPLICATI) + ' Foi selecionado um desconto de antecipação(2) do tipo percentual. Selecione outro tipo!', cDS_METHOD);
      return(-1); exit;
    end;
  end;
  if (item_f('PR_DESCANTECIP2', tFCP_DUPLICATI) <> 0) then begin
    if (item_f('TP_DESCANTECIP2', tFCP_DUPLICATI) = 1)  or (item_f('TP_DESCANTECIP2', tFCP_DUPLICATI) = 3)  or (item_f('TP_DESCANTECIP2', tFCP_DUPLICATI) = 4) then begin
      Result := SetStatus(STS_ERROR, 'GEN001', 'Duplicata: Emp.:' + item_a('CD_EMPRESA', tFCP_DUPLICATI) + ' Fornec.:' + item_a('CD_FORNECEDOR', tFCP_DUPLICATI) + ' Nr.:' + item_a('NR_DUPLICATA', tFCP_DUPLICATI) + ' Parc.:' + item_a('NR_PARCELA', tFCP_DUPLICATI) + ' Foi selecionado um desconto de antecipação(2) do tipo valor. Selecione outro tipo!', cDS_METHOD);
      return(-1); exit;
    end;
  end;
  if (item_a('DT_DESCANTECIP1', tFCP_DUPLICATI) > item_a('DT_VENCIMENTO', tFCP_DUPLICATI))  and (item_a('DT_DESCANTECIP1', tFCP_DUPLICATI) <> '') then begin
    Result := SetStatus(STS_ERROR, 'GEN001', 'Duplicata: Emp.:' + item_a('CD_EMPRESA', tFCP_DUPLICATI) + ' Fornec.:' + item_a('CD_FORNECEDOR', tFCP_DUPLICATI) + ' Nr.:' + item_a('NR_DUPLICATA', tFCP_DUPLICATI) + ' Parc.:' + item_a('NR_PARCELA', tFCP_DUPLICATI) + ' Parcela com data adiantamento 1 maior que a data de vencimento!', cDS_METHOD);
    return(-1); exit;
  end;
  if (item_a('DT_DESCANTECIP2', tFCP_DUPLICATI) > item_a('DT_VENCIMENTO', tFCP_DUPLICATI))  and (item_a('DT_DESCANTECIP2', tFCP_DUPLICATI) <> '') then begin
    Result := SetStatus(STS_ERROR, 'GEN001', 'Duplicata: Emp.:' + item_a('CD_EMPRESA', tFCP_DUPLICATI) + ' Fornec.:' + item_a('CD_FORNECEDOR', tFCP_DUPLICATI) + ' Nr.:' + item_a('NR_DUPLICATA', tFCP_DUPLICATI) + ' Parc.:' + item_a('NR_PARCELA', tFCP_DUPLICATI) + ' Parcela com data adiantamento 2 maior que a data de vencimento!', cDS_METHOD);
    return(-1); exit;
  end;
  if (item_a('DT_VENCIMENTO', tFCP_DUPLICATI) > item_a('DT_MULTA', tFCP_DUPLICATI))  and (item_a('DT_MULTA', tFCP_DUPLICATI) <> '') then begin
    Result := SetStatus(STS_ERROR, 'GEN001', 'Duplicata: Emp.:' + item_a('CD_EMPRESA', tFCP_DUPLICATI) + ' Fornec.:' + item_a('CD_FORNECEDOR', tFCP_DUPLICATI) + ' Nr.:' + item_a('NR_DUPLICATA', tFCP_DUPLICATI) + ' Parc.:' + item_a('NR_PARCELA', tFCP_DUPLICATI) + ' Parcela com data de multa inferior a data de vencimento!', cDS_METHOD);
    return(-1); exit;
  end;
  if (item_f('VL_MULTA', tFCP_DUPLICATI) <> 0)  and (item_f('PR_MULTA', tFCP_DUPLICATI) <> 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN001', 'Duplicata: Emp.:' + item_a('CD_EMPRESA', tFCP_DUPLICATI) + ' Fornec.:' + item_a('CD_FORNECEDOR', tFCP_DUPLICATI) + ' Nr.:' + item_a('NR_DUPLICATA', tFCP_DUPLICATI) + ' Parc.:' + item_a('NR_PARCELA', tFCP_DUPLICATI) + ' Informe somente valor ou percentual para multa!', cDS_METHOD);
    return(-1); exit;
  end else begin
    if (item_f('VL_MULTA', tFCP_DUPLICATI) <> 0)  or (item_f('PR_MULTA', tFCP_DUPLICATI) <> 0) then begin
      if (item_a('DT_MULTA', tFCP_DUPLICATI) = 0) then begin
        Result := SetStatus(STS_ERROR, 'GEN001', 'Duplicata: Emp.:' + item_a('CD_EMPRESA', tFCP_DUPLICATI) + ' Fornec.:' + item_a('CD_FORNECEDOR', tFCP_DUPLICATI) + ' Nr.:' + item_a('NR_DUPLICATA', tFCP_DUPLICATI) + ' Parc.:' + item_a('NR_PARCELA', tFCP_DUPLICATI) + ' Informe a data para multa!', cDS_METHOD);
        return(-1); exit;
      end;
    end;
  end;
  if (empty(tFCP_DUPDESPES)) then begin
    Result := SetStatus(STS_ERROR, 'GEN001', 'Duplicata: Emp.:' + item_a('CD_EMPRESA', tFCP_DUPLICATI) + ' Fornec.:' + item_a('CD_FORNECEDOR', tFCP_DUPLICATI) + ' Nr.:' + item_a('NR_DUPLICATA', tFCP_DUPLICATI) + ' Parc.:' + item_a('NR_PARCELA', tFCP_DUPLICATI) + ' Não existe rateio para a parcela!', cDS_METHOD);
    return(-1); exit;
  end;

  voParams := GravaLogGravacao(viParams); (* 'VALIDACAO TOTAL RATEIO DESPESA' *)

  setocc(tFCP_DUPDESPES, 1);
  vVlrTotalRateio := 0;
  while (xStatus >= 0) do begin

    vVlrTotalRateio := vVlrTotalRateio + rounded(item_f('VL_RATEIO', tFCP_DUPDESPES), 2);

    if (item_f('NR_PARCELA', tFCP_DUPDESPES) = 0) then begin
      putitem_e(tFCP_DUPDESPES, 'NR_PARCELA', item_f('NR_PARCELA', tFCP_DUPLICATI));
    end;

    putitem_e(tFCP_DUPDESPES, 'CD_OPERADOR', itemXmlF('CD_USUARIO', PARAM_GLB));
    putitem_e(tFCP_DUPDESPES, 'DT_CADASTRO', Now);

    if (xStatus = -10)  or (xStatus = -11) then begin
      Result := SetStatus(STS_ERROR, 'GEN001', 'Duplicata: Emp.:' + item_a('CD_EMPRESA', tFCP_DUPLICATI) + ' Fornec.:' + item_a('CD_FORNECEDOR', tFCP_DUPLICATI) + ' Nr.:' + item_a('NR_DUPLICATA', tFCP_DUPLICATI) + ' Parc.:' + item_a('NR_PARCELA', tFCP_DUPLICATI) + ' Registro da duplicata bloqueado por outro usuário!', cDS_METHOD);
      voParams := LimpaRegBloq(viParams); (* *)
      return(-1); exit;
    end;
    if (item_f('CD_DESPESAITEM', tFCP_DUPDESPES) = 0) then begin
      Result := SetStatus(STS_ERROR, 'GEN001', 'Duplicata: Emp.:' + item_a('CD_EMPRESA', tFCP_DUPLICATI) + ' Fornec.:' + item_a('CD_FORNECEDOR', tFCP_DUPLICATI) + ' Nr.:' + item_a('NR_DUPLICATA', tFCP_DUPLICATI) + ' Parc.:' + item_a('NR_PARCELA', tFCP_DUPLICATI) + ' Código do item da despesa não informado!', cDS_METHOD);
      return(-1); exit;
    end;

    voParams := validaDespesa(viParams); (* item_f('CD_DESPESAITEM', tFCP_DUPDESPES), xCdErro, xCtxErro *)
    if (xStatus < 0) then begin
      Result := voParams;
      return(-1); exit;
    end;

    voParams := validaCentroCusto(viParams); (* item_f('CD_CCUSTO', tFCP_DUPDESPES), xCdErro, xCtxErro *)
    if (xStatus < 0) then begin
      Result := voParams;
      return(-1); exit;
    end;
    if (vInValidaDespesaCcusto = 1) then begin
      voParams := validaDespCcusto(viParams); (* item_f('CD_EMPRESA', tFCP_DUPDESPES), item_f('CD_DESPESAITEM', tFCP_DUPDESPES), item_f('CD_CCUSTO', tFCP_DUPDESPES), xCdErro, xCtxErro *)
      if (xStatus < 0) then begin
        Result := voParams;
        return(-1); exit;
      end;
    end;

    setocc(tFCP_DUPDESPES, curocc(tFCP_DUPDESPES) + 1);
  end;
  xStatus := 0;

  vVlTotalDuplicata := '';
  if (item_f('VL_PAGO', tFCP_DUPLICATI) > 0) then begin
    vVlTotalDuplicata := item_f('VL_PAGO', tFCP_DUPLICATI);
  end else begin

    vVlTotalDuplicata := item_f('VL_DUPLICATA', tFCP_DUPLICATI) - item_f('VL_ABATIMENTO', tFCP_DUPLICATI) - item_f('VL_INDENIZACAO', tFCP_DUPLICATI);

  end;
  if rounded((vVlrTotalRateio, 2) <> rounded(vVlTotalDuplicata, 2)) then begin
    vVlDiferenca := '';
    vVlDiferenca := rounded(vVlrTotalRateio, 2) - rounded(vVlTotalDuplicata, 2);
    if (vVlDiferenca > -0.005)  and (vVlDiferenca < 0.005) then begin
      Result := SetStatus(STS_ERROR, 'GEN001', 'Duplicata: Emp.:' + item_a('CD_EMPRESA', tFCP_DUPLICATI) + ' Fornec.:' + item_a('CD_FORNECEDOR', tFCP_DUPLICATI) + ' Nr.:' + item_a('NR_DUPLICATA', tFCP_DUPLICATI) + ' Parc.:' + item_a('NR_PARCELA', tFCP_DUPLICATI) + ' O total rateio Rg ' + FloatToStr(vVlrTotalRateio) + ' não confere com o valor da parcela R ' + FloatToStr(vVlTotalDuplicata',) + ' cDS_METHOD);
      return(-1); exit;
    end;
  end;

  vVlImposto := 0;

  if (empty(tFCP_DUPIMPOST) = False) then begin
    voParams := GravaLogGravacao(viParams); (* 'TOTALIZA IMPOSTO' *)

    setocc(tFCP_DUPIMPOST, 1);
    while (xStatus >= 0) do begin
      putitem_e(tFCP_DUPIMPOST, 'CD_OPERADOR', itemXmlF('CD_USUARIO', PARAM_GLB));
      putitem_e(tFCP_DUPIMPOST, 'DT_CADASTRO', Now);

      if (xStatus = -10)  or (xStatus = -11) then begin
        Result := SetStatus(STS_ERROR, 'GEN001', 'Duplicata: Emp.:' + item_a('CD_EMPRESA', tFCP_DUPLICATI) + ' Fornec.:' + item_a('CD_FORNECEDOR', tFCP_DUPLICATI) + ' Nr.:' + item_a('NR_DUPLICATA', tFCP_DUPLICATI) + ' Parc.:' + item_a('NR_PARCELA', tFCP_DUPLICATI) + ' Registro da duplicata bloqueado por outro usuário!', cDS_METHOD);
        voParams := LimpaRegBloq(viParams); (* *)
        return(-1); exit;
      end;
      if (item_f('CD_IMPOSTO', tFCP_DUPIMPOST) = 0) then begin
        Result := SetStatus(STS_ERROR, 'GEN001', 'Duplicata: Emp.:' + item_a('CD_EMPRESA', tFCP_DUPLICATI) + ' Fornec.:' + item_a('CD_FORNECEDOR', tFCP_DUPLICATI) + ' Nr.:' + item_a('NR_DUPLICATA', tFCP_DUPLICATI) + ' Parc.:' + item_a('NR_PARCELA', tFCP_DUPLICATI) + ' Código do item do imposto não informado!', cDS_METHOD);
        return(-1); exit;
      end;
      if (item_f('TP_SITUACAO', tFCP_DUPIMPOST) = '') then begin
        putitem_e(tFCP_DUPIMPOST, 'TP_SITUACAO', 0);
      end;
      if (item_f('TP_SITUACAO', tFCP_DUPIMPOST) = 1 ) or (item_f('TP_SITUACAO', tFCP_DUPIMPOST) = 2) then begin
        vVlImposto := vVlImposto + rounded(item_f('VL_IMPOSTO', tFCP_DUPIMPOST), 2);
      end;

      setocc(tFCP_DUPIMPOST, curocc(tFCP_DUPIMPOST) + 1);
    end;
    xStatus := 0;
  end;

  voParams := GravaLogGravacao(viParams); (* 'GRAVACAO PARCELA' *)

  if (vDsComponente <> 'FCPFP016')  or (item_b('IN_PGTOFORNEC', tFCP_DUPLICATI) <> True)  or (item_a('DT_MESANORET', tFCP_DUPLICATI) = '') then begin
    if (vVlImpostoRetido > 0) then begin
      putitem_e(tFCP_DUPLICATI, 'VL_IMPOSTO', vVlImpostoRetido);
    end else begin
      putitem_e(tFCP_DUPLICATI, 'VL_IMPOSTO', vVlImposto);
    end;
  end;
  if (xStatus = -10)  or (xStatus = -11) then begin
    Result := SetStatus(STS_ERROR, 'GEN001', 'Duplicata: Emp.:' + item_a('CD_EMPRESA', tFCP_DUPLICATI) + ' Fornec.:' + item_a('CD_FORNECEDOR', tFCP_DUPLICATI) + ' Nr.:' + item_a('NR_DUPLICATA', tFCP_DUPLICATI) + ' Parc.:' + item_a('NR_PARCELA', tFCP_DUPLICATI) + ' Registro da duplicata bloqueado por outro usuário!', cDS_METHOD);
    voParams := LimpaRegBloq(viParams); (* *)
    return(-1); exit;
  end;
  if (item_f('VL_ORIGINAL', tFCP_DUPLICATI) = 0) then begin
    putitem_e(tFCP_DUPLICATI, 'VL_ORIGINAL', item_f('VL_DUPLICATA', tFCP_DUPLICATI));
  end;
  if (item_a('DT_ENTRADA', tFCP_DUPLICATI) = '') then begin
    putitem_e(tFCP_DUPLICATI, 'DT_ENTRADA', itemXml('DT_SISTEMA', PARAM_GLB));
  end else begin
    putitem_e(tFCP_DUPLICATI, 'CD_OPERALTERACAO', itemXmlF('CD_USUARIO', PARAM_GLB));
    putitem_e(tFCP_DUPLICATI, 'DT_ALTERACAO', Now);
  end;

  putitem_e(tFCP_DUPLICATI, 'CD_OPERADOR', itemXmlF('CD_USUARIO', PARAM_GLB));
  putitem_e(tFCP_DUPLICATI, 'DT_CADASTRO', Now);

  if (item_f('TP_ESTAGIO', tFCP_DUPLICATI) = 0) then begin
    putitem_e(tFCP_DUPLICATI, 'TP_ESTAGIO', 1);
  end;
  if (item_b('IN_AUTORIZADO', tFCP_DUPLICATI) <> True) then begin
    putitem_e(tFCP_DUPLICATI, 'IN_AUTORIZADO', False);
  end;
  if (item_f('VL_PAGO', tFCP_DUPLICATI) = '') then begin
    putitem_e(tFCP_DUPLICATI, 'VL_PAGO', 0);
  end;
  if (item_f('TP_BAIXA', tFCP_DUPLICATI) = '') then begin
    putitem_e(tFCP_DUPLICATI, 'TP_BAIXA', 0);
  end;
  if (item_a('DT_VENCTOORIGEM', tFCP_DUPLICATI) = 0) then begin
    putitem_e(tFCP_DUPLICATI, 'DT_VENCTOORIGEM', item_a('DT_VENCIMENTO', tFCP_DUPLICATI));
  end;
  if (item_f('CD_MOEDA', tFCP_DUPLICATI) = '')  or %\ then begin
    (putitem_e(tFCP_DUPLICATI, 'CD_MOEDA', 0));
    putitem_e(tFCP_DUPLICATI, 'CD_MOEDA', itemXmlF('CD_MOEDA', PARAM_GLB));
  end;
  putitem_e(tFCP_DUPLICATI, 'CD_COMPONENTE', vDsComponente);

  if (itemXml('IN_NEGOCIACAO_DESC', pParams) = True) then begin
    putitem_e(tFCP_DUPLICATI, 'CD_EMPLIQ', itemXmlF('CD_EMPLIQ', pParams));
    putitem_e(tFCP_DUPLICATI, 'DT_LIQ', itemXml('DT_LIQ', pParams));
    putitem_e(tFCP_DUPLICATI, 'NR_SEQLIQ', itemXmlF('NR_SEQLIQ', pParams));
  end;
  if (item_f('CD_OPERINCLUSAO', tFCP_DUPLICATI) = '') then begin
    putitem_e(tFCP_DUPLICATI, 'CD_OPERINCLUSAO', itemXmlF('CD_USUARIO', PARAM_GLB));
    putitem_e(tFCP_DUPLICATI, 'DT_INCLUSAO', Now);
  end;

  putitem_e(tFCP_DUPLICATC, 'CD_OPERADOR', itemXmlF('CD_USUARIO', PARAM_GLB));
  putitem_e(tFCP_DUPLICATC, 'DT_CADASTRO', Now);

  if (xStatus = -10)  or (xStatus = -11) then begin
    Result := SetStatus(STS_ERROR, 'GEN001', 'Duplicata: Emp.:' + item_a('CD_EMPRESA', tFCP_DUPLICATI) + ' Fornec.:' + item_a('CD_FORNECEDOR', tFCP_DUPLICATI) + ' Nr.:' + item_a('NR_DUPLICATA', tFCP_DUPLICATI) + ' Parc.:' + item_a('NR_PARCELA', tFCP_DUPLICATI) + ' Registro da duplicata bloqueado por outro usuário!', cDS_METHOD);
    voParams := LimpaRegBloq(viParams); (* *)
    return(-1); exit;
  end;

  voParams := GravaLogGravacao(viParams); (* 'SALVAR FCP_DUPLICATAC' *)

  voParams := tFCP_DUPLICATC.Salvar();
  if (xStatus < 0) then begin
    Result := voParams;
    return(-1); exit;
  end;
  if (vInConferida) then begin
    voParams := GravaLogGravacao(viParams); (* 'ALTERA ESTAGIO CONFERIDA' *)

    putitemXml(viParams, 'CD_EMPRESA', item_f('CD_EMPRESA', tFCP_DUPLICATI));
    putitemXml(viParams, 'CD_FORNECEDOR', item_f('CD_FORNECEDOR', tFCP_DUPLICATI));
    putitemXml(viParams, 'NR_DUPLICATA', item_f('NR_DUPLICATA', tFCP_DUPLICATI));
    putitemXml(viParams, 'NR_PARCELA', item_f('NR_PARCELA', tFCP_DUPLICATI));
    putitemXml(viParams, 'TP_ESTAGIO', 2);
    voParams := activateCmp('FCPSVCO005', 'alteraEstagioDuplicata', viParams); (*,,,, *)
    if (xStatus < 0) then begin
      Result := voParams;
      return(-1); exit;
    end;

    viParams := '';
    putitemXml(viParams, 'CD_EMPRESA', item_f('CD_EMPRESA', tFCP_DUPLICATI));
    putitemXml(viParams, 'CD_FORNECEDOR', item_f('CD_FORNECEDOR', tFCP_DUPLICATI));
    putitemXml(viParams, 'NR_DUPLICATA', item_f('NR_DUPLICATA', tFCP_DUPLICATI));
    putitemXml(viParams, 'NR_PARCELA', item_f('NR_PARCELA', tFCP_DUPLICATI));
    putitemXml(viParams, 'TP_LOGDUP', 7);
    putitemXml(viParams, 'DS_OBS', 'EFETUADO CONFERENCIA - LIBERADO');
    putitemXml(viParams, 'DS_COMPONENTE', 'FCPFM004');
    voParams := activateCmp('FCPSVCO001', 'gravaLogDuplicata', viParams); (*,,,, *)
    if (xStatus < 0) then begin
      Result := voParams;
      return(-1); exit;
    end;
  end;

  voParams := GravaLogGravacao(viParams); (* 'GRAVACAO SALDO DUPLICATA' *)

  select sum(VL_DUPLICATA) 
  from 'FCP_DUPLICATISVC' 
  where (putitem_e(tFCP_DUPLICATI, 'CD_EMPRESA', item_f('CD_EMPRESA', tFCP_DUPLICATC)    ) and (
            putitem_e(tFCP_DUPLICATI, 'CD_FORNECEDOR', item_f('CD_FORNECEDOR', tFCP_DUPLICATC) ) and (
            putitem_e(tFCP_DUPLICATI, 'NR_DUPLICATA', item_f('NR_DUPLICATA', tFCP_DUPLICATC))
  to vVlTotal;
  if (xStatus < 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN001', 'Duplicata: Emp.:' + item_a('CD_EMPRESA', tFCP_DUPLICATI) + ' Fornec.:' + item_a('CD_FORNECEDOR', tFCP_DUPLICATI) + ' Nr.:' + item_a('NR_DUPLICATA', tFCP_DUPLICATI) + ' Parc.:' + item_a('NR_PARCELA', tFCP_DUPLICATI) + ' Erro ao buscar último número da O.P.', cDS_METHOD);
    return(-1); exit;
  end;
  putitem_e(tFCP_DUPLICATC, 'VL_TOTAL', vVlTotal);

  select sum(VL_DUPLICATA) 
  from 'FCP_DUPLICATISVC' 
  where (putitem_e(tFCP_DUPLICATI, 'CD_EMPRESA', item_f('CD_EMPRESA', tFCP_DUPLICATC)    ) and (
            putitem_e(tFCP_DUPLICATI, 'CD_FORNECEDOR', item_f('CD_FORNECEDOR', tFCP_DUPLICATC) ) and (
            putitem_e(tFCP_DUPLICATI, 'NR_DUPLICATA', item_f('NR_DUPLICATA', tFCP_DUPLICATC)  ) and (
            putitem_e(tFCP_DUPLICATI, 'DT_LIQ', '!=')
  to vVlSaldo;
  if (xStatus < 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN001', 'Duplicata: Emp.:' + item_a('CD_EMPRESA', tFCP_DUPLICATI) + ' Fornec.:' + item_a('CD_FORNECEDOR', tFCP_DUPLICATI) + ' Nr.:' + item_a('NR_DUPLICATA', tFCP_DUPLICATI) + ' Parc.:' + item_a('NR_PARCELA', tFCP_DUPLICATI) + ' Erro ao buscar último número da O.P.', cDS_METHOD);
    return(-1); exit;
  end;
  putitem_e(tFCP_DUPLICATC, 'VL_SALDO', vVlSaldo);
  putitem_e(tFCP_DUPLICATC, 'CD_OPERADOR', itemXmlF('CD_USUARIO', PARAM_GLB));
  putitem_e(tFCP_DUPLICATC, 'DT_CADASTRO', Now);

  if (xStatus = -10)  or (xStatus = -11) then begin
    Result := SetStatus(STS_ERROR, 'GEN001', 'Duplicata: Emp.:' + item_a('CD_EMPRESA', tFCP_DUPLICATI) + ' Fornec.:' + item_a('CD_FORNECEDOR', tFCP_DUPLICATI) + ' Nr.:' + item_a('NR_DUPLICATA', tFCP_DUPLICATI) + ' Parc.:' + item_a('NR_PARCELA', tFCP_DUPLICATI) + ' Registro da duplicata bloqueado por outro usuário!', cDS_METHOD);
    voParams := LimpaRegBloq(viParams); (* *)
    return(-1); exit;
  end;

  voParams := tFCP_DUPLICATC.Salvar();
  if (xStatus < 0) then begin
    Result := voParams;
    return(-1); exit;
  end;

  Result := '';
  putitemXml(Result, 'CD_EMPRESA', item_f('CD_EMPRESA', tFCP_DUPLICATI));
  putitemXml(Result, 'CD_FORNECEDOR', item_f('CD_FORNECEDOR', tFCP_DUPLICATI));
  putitemXml(Result, 'NR_DUPLICATA', item_f('NR_DUPLICATA', tFCP_DUPLICATI));
  putitemXml(Result, 'NR_PARCELA', item_f('NR_PARCELA', tFCP_DUPLICATI));

  vCdEmpDup := item_f('CD_EMPRESA', tFCP_DUPLICATI);
  vCdFornecDup := item_f('CD_FORNECEDOR', tFCP_DUPLICATI);
  vNrDup := item_f('NR_DUPLICATA', tFCP_DUPLICATI);
  vNrParcelaDup := item_f('NR_PARCELA', tFCP_DUPLICATI);

  if (gCdTipoClasForDup <> '') then begin
    voParams := GravaLogGravacao(viParams); (* 'GRAVACAO TIPO DE CLAS FORNECEDOR' *)

    viParams := '';
    putitemXml(viParams, 'CD_EMPRESA', item_f('CD_EMPRESA', tFCP_DUPLICATI));
    putitemXml(viParams, 'CD_FORNECEDOR', item_f('CD_FORNECEDOR', tFCP_DUPLICATI));
    putitemXml(viParams, 'NR_DUPLICATA', item_f('NR_DUPLICATA', tFCP_DUPLICATI));
    putitemXml(viParams, 'NR_PARCELA', item_f('NR_PARCELA', tFCP_DUPLICATI));
    putitemXml(viParams, 'LST_TPCLAS', gCdTipoClasForDup);
    putitemXml(viParams, 'IN_NOVADUP', True);
    voParams := activateCmp('FCPSVCO047', 'gravarClassificacaoForDup', viParams); (*,,,, *)

    if (xStatus < 0) then begin
      Result := voParams;
      return(-1); exit;
    end;
  end;
  if (gCdTipoClasCmpDup <> '') then begin
    viParams := '';
    putitemXml(viParams, 'CD_EMPRESA', vCdEmpDup);
    putitemXml(viParams, 'CD_FORNECEDOR', vCdFornecDup);
    putitemXml(viParams, 'NR_DUPLICATA', vNrDup);
    putitemXml(viParams, 'NR_PARCELA', vNrParcelaDup);
    putitemXml(viParams, 'LST_TPCLAS', gCdTipoClasCmpDup);
    putitemXml(viParams, 'LST_TRANSACAO', itemXml('LST_TRANSACAO', pParams));
    putitemXml(viParams, 'IN_NOVADUP', True);
    voParams := activateCmp('FCPSVCO047', 'gravarClassificacaoCmpDup', viParams); (*,,,, *)
    if (xStatus < 0) then begin
      Result := voParams;
      return(-1); exit;
    end;
  end;
  if (gCdTipoClasPrdDup <> '') then begin
    viParams := '';
    putitemXml(viParams, 'CD_EMPRESA', vCdEmpDup);
    putitemXml(viParams, 'CD_FORNECEDOR', vCdFornecDup);
    putitemXml(viParams, 'NR_DUPLICATA', vNrDup);
    putitemXml(viParams, 'NR_PARCELA', vNrParcelaDup);
    putitemXml(viParams, 'LST_TPCLAS', gCdTipoClasPrdDup);
    putitemXml(viParams, 'LST_TRANSACAO', itemXml('LST_TRANSACAO', pParams));
    putitemXml(viParams, 'IN_NOVADUP', True);
    voParams := activateCmp('FCPSVCO047', 'gravarClassificacaoPrdDup', viParams); (*,,,, *)
    if (xStatus < 0) then begin
      Result := voParams;
      return(-1); exit;
    end;
  end;

  voParams := GravaLogGravacao(viParams); (* 'FIM' *)

  voParams := GravaLogGravacao(viParams); (* '' *)

  clear_e(tFCP_DUPLICATC);

  return(0); exit;
end;

//-----------------------------------------------------------------
function T_FCPSVCO001.gravaLogDuplicata(pParams : String) : String;
//-----------------------------------------------------------------
const
  cDS_METHOD = 'ADICIONAL=Operação: T_FCPSVCO001.gravaLogDuplicata()';
var
  vCdEmpresa, vCdFornecedor, vNrDuplicata, vNrParcela, vTpLogDup : Real;
  vNrOrigem, vNrDestino, vSeqLogDup, vVlOrigem, vVlDestino : Real;
  vDsOrigem, vDsDestino : String;
  vDtOrigem, vDtDestino : TDate;
  viParams, voParams : String;
  vDsComponente, vDsObs, vDsComando : String;
begin
  vCdEmpresa := itemXmlF('CD_EMPRESA', pParams);
  vCdFornecedor := itemXmlF('CD_FORNECEDOR', pParams);
  vNrDuplicata := itemXmlF('NR_DUPLICATA', pParams);
  vNrParcela := itemXmlF('NR_PARCELA', pParams);
  vTpLogDup := itemXmlF('TP_LOGDUP', pParams);
  vDtOrigem := itemXml('DT_ORIGEM', pParams);
  vDtDestino := itemXml('DT_DESTINO', pParams);
  vNrOrigem := itemXmlF('NR_ORIGEM', pParams);
  vNrDestino := itemXmlF('NR_DESTINO', pParams);
  vVlOrigem := itemXmlF('VL_ORIGEM', pParams);
  vVlDestino := itemXmlF('VL_DESTINO', pParams);
  vDsOrigem := itemXml('DS_ORIGEM', pParams);
  vDsDestino := itemXml('DS_DESTINO', pParams);
  vDsComponente := itemXml('DS_COMPONENTE', pParams);
  vDsObs := itemXml('DS_OBS', pParams);

  viParams := '';
  putitemXml(viParams, 'CD_EMPRESA', vCdEmpresa);
  putitemXml(viParams, 'CD_FORNECEDOR', vCdFornecedor);
  putitemXml(viParams, 'NR_DUPLICATA', vNrDuplicata);
  putitemXml(viParams, 'NR_PARCELA', vNrParcela);
  voParams := seqLogDup(viParams); (* viParams, voParams *)
  if (xStatus < 0) then begin
    Result := voParams;
    return(-1); exit;
  end;
  vSeqLogDup := itemXmlF('NR_LOGDUP', voParams);
  if (vSeqLogDup = 0) then begin
    vSeqLogDup := 1;
  end;
  if (vTpLogDup = 1) then begin
    if (vNrOrigem = 0)  or (vNrDestino = 0) then begin
      Result := SetStatus(STS_ERROR, 'GEN001', 'Portador informado incorreto!', cDS_METHOD);
      return(-1); exit;
    end;
    if (vNrOrigem = vNrDestino) then begin
      Result := SetStatus(STS_ERROR, 'GEN001', 'Não foi trocado o portador!', cDS_METHOD);
      return(-1); exit;
    end;
    if (vDsObs <> '') then begin
      vDsObs := 'TROCA DE PORTADOR - ' + vDsObs' + ';
    end else begin
      vDsObs := 'TROCA DE PORTADOR';
    end;
  end;
  if (vTpLogDup = 2) then begin
    if (vVlOrigem = '')  or (vVlDestino = '') then begin
      Result := SetStatus(STS_ERROR, 'GEN001', 'Valor informado incorreto!', cDS_METHOD);
      return(-1); exit;
    end;
    if (vVlOrigem = vVlDestino) then begin
      Result := SetStatus(STS_ERROR, 'GEN001', 'Não foi trocado o valor!', cDS_METHOD);
      return(-1); exit;
    end;
    if (vDsObs <> '') then begin
        vDsObs := 'TROCA DE VALOR - ' + vDsObs' + ';
    end else begin
        vDsObs := 'TROCA DE VALOR';
    end;
  end;
  if (vTpLogDup = 3) then begin
    gvenctoOri := vDtOrigem;
    gvenctoDest := vDtDestino;

    if (vDtOrigem = '')  or (vDtDestino = '') then begin
      Result := SetStatus(STS_ERROR, 'GEN001', 'Data de vencimento infomardo incorreto!', cDS_METHOD);
      return(-1); exit;
    end;
    if (vDtOrigem = vDtDestino) then begin
      Result := SetStatus(STS_ERROR, 'GEN001', 'Não foi trocada a data de vencimento!', cDS_METHOD);
      return(-1); exit;
    end;
    if (vDsObs <> '') then begin
      vDsObs := 'TROCA DA DATA DE VENCIMENTO - ' + vDsObs' + ';
    end else begin
      vDsObs := 'TROCA DA DATA DE VENCIMENTO';
    end;
  end;

  vDsComando := 'SELECT TP_LOGDUP FROM FCP_LOGTIPO WHERE TP_LOGDUP := ' + FloatToStr(vTpLogDup') + ';
  sql vDsComando, 'DEF';
  if (xStatus < 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN001', 'Não foi buscar tipo de log de duplicata!', cDS_METHOD);
    return(-1); exit;
  end;
  if (gresult = '') then begin
    Result := SetStatus(STS_ERROR, 'GEN001', 'Tipo de log de duplicata não cadastrado (Código tipo: ' + FloatToStr(vTpLogDup)) + '! Verificar componente FCPFL006!', cDS_METHOD);
    return(-1); exit;
  end;

  clear_e(tFCP_LOGDUP);
  putitem_e(tFCP_LOGDUP, 'CD_EMPRESA', vCdEmpresa);
  putitem_e(tFCP_LOGDUP, 'CD_FORNECEDOR', vCdFornecedor);
  putitem_e(tFCP_LOGDUP, 'NR_DUPLICATA', vNrDuplicata);
  putitem_e(tFCP_LOGDUP, 'NR_PARCELA', vNrParcela);
  putitem_e(tFCP_LOGDUP, 'NR_LOGDUP', vSeqLogDup);
  putitem_e(tFCP_LOGDUP, 'CD_OPERADOR', itemXmlF('CD_USUARIO', PARAM_GLB));
  putitem_e(tFCP_LOGDUP, 'DT_CADASTRO', Now);
  putitem_e(tFCP_LOGDUP, 'TP_LOGDUP', vTpLogDup);
  putitem_e(tFCP_LOGDUP, 'DT_OPERACAO', itemXml('DT_SISTEMA', PARAM_GLB));
  putitem_e(tFCP_LOGDUP, 'DT_ORIGEM', vDtOrigem);
  putitem_e(tFCP_LOGDUP, 'DT_DESTINO', vDtDestino);
  putitem_e(tFCP_LOGDUP, 'NR_ORIGEM', vNrOrigem);
  putitem_e(tFCP_LOGDUP, 'NR_DESTINO', vNrDestino);
  putitem_e(tFCP_LOGDUP, 'VL_ORIGEM', vVlOrigem);
  putitem_e(tFCP_LOGDUP, 'VL_DESTINO', vVlDestino);
  putitem_e(tFCP_LOGDUP, 'DS_ORIGEM', vDsOrigem);
  putitem_e(tFCP_LOGDUP, 'DS_DESTINO', vDsDestino);
  putitem_e(tFCP_LOGDUP, 'DS_COMPONENTE', vDsComponente);

  voParams := converterstring(viParams); (* vDsObs, vDsObs *)
  if (xStatus < 0) then begin
    Result := voParams;
    return(-1); exit;
  end;
  putitem_e(tFCP_LOGDUP, 'DS_OBS', vDsObs[1:100]);

  voParams := tFCP_LOGDUP.Salvar();
  if (xStatus < 0) then begin
    Result := voParams;
    return(-1); exit;
  end;

  clear_e(tFCP_LOGDUP);

  return(0); exit;
end;

//---------------------------------------------------------
function T_FCPSVCO001.seqLogDup(pParams : String) : String;
//---------------------------------------------------------
const
  cDS_METHOD = 'ADICIONAL=Operação: T_FCPSVCO001.seqLogDup()';
var
  vCdEmpresa, vCdFornecedor, vNrDuplicata, vNrParcela, vSeqLogDup : Real;
begin
  vSeqLogDup := 0;
  vCdEmpresa := itemXmlF('CD_EMPRESA', pParams);
  vCdFornecedor := itemXmlF('CD_FORNECEDOR', pParams);
  vNrDuplicata := itemXmlF('NR_DUPLICATA', pParams);
  vNrParcela := itemXmlF('NR_PARCELA', pParams);
  select max(NR_LOGDUP) 
    from 'FCP_LOGDUPSVC' 
    where (putitem_e(tFCP_LOGDUP, 'CD_EMPRESA', vCdEmpresa ) and (
    putitem_e(tFCP_LOGDUP, 'CD_FORNECEDOR', vCdFornecedor ) and (
    putitem_e(tFCP_LOGDUP, 'NR_DUPLICATA', vNrDuplicata  ) and (
    putitem_e(tFCP_LOGDUP, 'NR_PARCELA', vNrParcela)
    to vSeqLogDup;

  vSeqLogDup := vSeqLogDup + 1;
  Result := '';
  putitemXml(Result, 'NR_LOGDUP', vSeqLogDup);

  return(0); exit;
end;

//-----------------------------------------------------------
function T_FCPSVCO001.gravaAceite(pParams : String) : String;
//-----------------------------------------------------------
const
  cDS_METHOD = 'ADICIONAL=Operação: T_FCPSVCO001.gravaAceite()';
var
  vCdEmpresa, vCdFornecedor, vNrDuplicata, vNrParcela : Real;
  vNrCedente, vNrCedenteAg, VNrCedenteCt, vCdOperAceite, vNrNossoNumero : Real;
  vDtAceite : TDate;
  viParams, voParams, vDsBarra : String;
begin
  vCdEmpresa := itemXmlF('CD_EMPRESA', pParams);
  vCdFornecedor := itemXmlF('CD_FORNECEDOR', pParams);
  vNrDuplicata := itemXmlF('NR_DUPLICATA', pParams);
  vNrParcela := itemXmlF('NR_PARCELA', pParams);
  vDsBarra := itemXml('DS_BARRA', pParams);
  vDtAceite := itemXml('DT_ACEITE', pParams);
  vNrCedente := itemXmlF('NR_CEDENTE', pParams);
  vNrCedenteAg := itemXmlF('NR_CEDENTEAG', pParams);
  vNrCedenteCt := itemXmlF('NR_CEDENTECT', pParams);
  vCdOperAceite := itemXmlF('CD_OPERACEITE', pParams);
  vNrNossoNumero := itemXmlF('NR_NOSSONUMERO', pParams);

  clear_e(tFCP_ACEITE);

  creocc(tFCP_ACEITE, -1);
  putitem_e(tFCP_ACEITE, 'CD_EMPRESA', vCdEmpresa);
  putitem_e(tFCP_ACEITE, 'CD_FORNECEDOR', vCdFornecedor);
  putitem_e(tFCP_ACEITE, 'NR_DUPLICATA', vNrDuplicata);
  putitem_e(tFCP_ACEITE, 'NR_PARCELA', vNrParcela);
  retrieve_o(tFCP_ACEITE);
  if (xStatus = -7) then begin
    retrieve_x(tFCP_ACEITE);
  end;

  putitem_e(tFCP_ACEITE, 'CD_OPERADOR', itemXmlF('CD_USUARIO', PARAM_GLB));
  putitem_e(tFCP_ACEITE, 'DT_CADASTRO', Now);
  putitem_e(tFCP_ACEITE, 'DS_BARRA', vDsBarra);
  putitem_e(tFCP_ACEITE, 'DT_ACEITE', vDtAceite);
  putitem_e(tFCP_ACEITE, 'NR_CEDENTE', vNrCedente);
  putitem_e(tFCP_ACEITE, 'NR_CEDENTEAG', vNrCedenteAg);
  putitem_e(tFCP_ACEITE, 'NR_CEDENTECT', VNrCedenteCt);
  putitem_e(tFCP_ACEITE, 'NR_NOSSONUMERO', vNrNossoNumero);

  if (vCdOperAceite = '') then begin
    putitem_e(tFCP_ACEITE, 'CD_OPERACEITE', itemXmlF('CD_USUARIO', PARAM_GLB));
  end else begin
    putitem_e(tFCP_ACEITE, 'CD_OPERACEITE', vCdOperAceite);
  end;

  voParams := tFCP_ACEITE.Salvar();
  if (xStatus < 0) then begin
    Result := voParams;
    return(-1); exit;
  end;

  viParams := '';
  putitemXml(viParams, 'CD_EMPRESA', vCdEmpresa);
  putitemXml(viParams, 'CD_FORNECEDOR', vCdFornecedor);
  putitemXml(viParams, 'NR_DUPLICATA', vNrDuplicata);
  putitemXml(viParams, 'NR_PARCELA', vNrParcela);
  putitemXml(viParams, 'TP_LOGDUP', 4);
  putitemXml(viParams, 'DS_COMPONENTE', 'FCPFM007');
  putitemXml(viParams, 'DS_OBS', 'ACEITE DA DUPLICATA');
  voParams := gravaLogDuplicata(viParams); (* PARAM_GLB, viParams, voParams, xCdErro, xCtxErro *)
  if (xStatus < 0) then begin
    Result := voParams;
    return(-1); exit;
  end;

  clear_e(tFCP_ACEITE);

  return(0); exit;
end;

//-----------------------------------------------------------------
function T_FCPSVCO001.ExcluirParcelaDup(pParams : String) : String;
//-----------------------------------------------------------------
const
  cDS_METHOD = 'ADICIONAL=Operação: T_FCPSVCO001.ExcluirParcelaDup()';
var
  vNrParcela : Real;
  vDsDuplicataI : String;
begin
  vDsDuplicataI := itemXml('DS_DUPLICATAI', pParams);

  clear_e(tFCP_DUPLICATC);

  if (vDsDuplicataI <> '') then begin
    creocc(tFCP_DUPLICATC, -1);
    putitem_e(tFCP_DUPLICATC, 'CD_EMPRESA', itemXmlF('CD_EMPRESA', vDsDuplicataI));
    putitem_e(tFCP_DUPLICATC, 'CD_FORNECEDOR', itemXmlF('CD_FORNECEDOR', vDsDuplicataI));
    putitem_e(tFCP_DUPLICATC, 'NR_DUPLICATA', itemXmlF('NR_DUPLICATA', vDsDuplicataI));

    if (item_f('CD_EMPRESA', tFCP_DUPLICATC) = 0) then begin
      Result := SetStatus(STS_ERROR, 'GEN001', 'Empresa não informada!', cDS_METHOD);
      return(-1); exit;
    end;
    if (item_f('CD_FORNECEDOR', tFCP_DUPLICATC) = 0) then begin
      Result := SetStatus(STS_ERROR, 'GEN001', 'Fornecedor da duplicata não informado!', cDS_METHOD);
      return(-1); exit;
    end;
    if (item_f('NR_DUPLICATA', tFCP_DUPLICATC) = 0) then begin
      Result := SetStatus(STS_ERROR, 'GEN001', 'Número da duplicata não informado!', cDS_METHOD);
      return(-1); exit;
    end;

    retrieve_o(tFCP_DUPLICATC);
    if (xStatus = -7) then begin
      retrieve_x(tFCP_DUPLICATC);
    end;

    vNrParcela := itemXmlF('NR_PARCELA', vDsDuplicataI);
    if (vNrParcela > 0) then begin
      clear_e(tFCP_DUPLICATI);
      putitem_e(tFCP_DUPLICATI, 'NR_PARCELA', vNrParcela);
      retrieve_e(tFCP_DUPLICATI);
      if (xStatus >= 0) then begin
        voParams := tFCP_DUPLICATI.Excluir();
        if (xStatus < 0) then begin
          Result := voParams;
          return(-1); exit;
        end;
      end;
    end;
  end else begin
    Result := SetStatus(STS_ERROR, 'GEN001', 'Duplicata/parcela não informada!', cDS_METHOD);
    return(-1); exit;
  end;

  clear_e(tFCP_DUPLICATC);

  return(0); exit;
end;

//-----------------------------------------------------------------
function T_FCPSVCO001.gravaObsDuplicata(pParams : String) : String;
//-----------------------------------------------------------------
const
  cDS_METHOD = 'ADICIONAL=Operação: T_FCPSVCO001.gravaObsDuplicata()';
var
  vCdEmpresa, vCdFornecedor, vNrDuplicata, vNrParcela, vSeqObsDup : Real;
  viParams, voParams : String;
  vDsComponente, vDsObs : String;
  vInManutencao : Boolean;
begin
  vCdEmpresa := itemXmlF('CD_EMPRESA', pParams);
  vCdFornecedor := itemXmlF('CD_FORNECEDOR', pParams);
  vNrDuplicata := itemXmlF('NR_DUPLICATA', pParams);
  vNrParcela := itemXmlF('NR_PARCELA', pParams);
  vInManutencao := itemXmlB('IN_MANUTENCAO', pParams);
  vDsComponente := itemXml('DS_COMPONENTE', pParams);
  vDsObs := itemXml('DS_OBS', pParams);

  if (vInManutencao <> True) then begin
    vInManutencao := False;
  end;
  if (vDsComponente = '') then begin
    Result := SetStatus(STS_ERROR, 'GEN001', 'Componente não informado!', cDS_METHOD);
    return(-1); exit;
  end;

  viParams := '';
  putitemXml(viParams, 'CD_EMPRESA', vCdEmpresa);
  putitemXml(viParams, 'CD_FORNECEDOR', vCdFornecedor);
  putitemXml(viParams, 'NR_DUPLICATA', vNrDuplicata);
  putitemXml(viParams, 'NR_PARCELA', vNrParcela);
  voParams := seqObsDup(viParams); (* viParams, voParams *)
  if (xStatus < 0) then begin
    Result := voParams;
    return(-1); exit;
  end;

  vSeqObsDup := itemXmlF('NR_OBSDUP', voParams);
  if (vSeqObsDup = 0) then begin
    vSeqObsDup := 1;
  end;

  clear_e(tOBS_DUPI);
  putitem_e(tOBS_DUPI, 'CD_EMPRESA', vCdEmpresa);
  putitem_e(tOBS_DUPI, 'CD_FORNECEDOR', vCdFornecedor);
  putitem_e(tOBS_DUPI, 'NR_DUPLICATA', vNrDuplicata);
  putitem_e(tOBS_DUPI, 'NR_PARCELA', vNrParcela);
  putitem_e(tOBS_DUPI, 'NR_LINHA', vSeqObsDup);
  putitem_e(tOBS_DUPI, 'CD_OPERADOR', itemXmlF('CD_USUARIO', PARAM_GLB));
  putitem_e(tOBS_DUPI, 'DT_CADASTRO', Now);
  putitem_e(tOBS_DUPI, 'IN_MANUTENCAO', vInManutencao);
  putitem_e(tOBS_DUPI, 'CD_COMPONENTE', vDsComponente);

  voParams := converterstring(viParams); (* vDsObs, vDsObs *)
  if (xStatus < 0) then begin
    Result := voParams;
    return(-1); exit;
  end;
  putitem_e(tOBS_DUPI, 'DS_OBSERVACAO', vDsObs[1:80]);

  voParams := tOBS_DUPI.Salvar();
  if (xStatus < 0) then begin
    Result := voParams;
    return(-1); exit;
  end;

  clear_e(tOBS_DUPI);

  return(0); exit;
end;

//---------------------------------------------------------
function T_FCPSVCO001.seqObsDup(pParams : String) : String;
//---------------------------------------------------------
const
  cDS_METHOD = 'ADICIONAL=Operação: T_FCPSVCO001.seqObsDup()';
var
  vCdEmpresa, vCdFornecedor, vNrDuplicata, vNrParcela, vSeqObsDup : Real;
begin
  vSeqObsDup := 0;
  vCdEmpresa := itemXmlF('CD_EMPRESA', pParams);
  vCdFornecedor := itemXmlF('CD_FORNECEDOR', pParams);
  vNrDuplicata := itemXmlF('NR_DUPLICATA', pParams);
  vNrParcela := itemXmlF('NR_PARCELA', pParams);
  select max(NR_LINHA) 
    from 'OBS_DUPISVC' 
    where (putitem_e(tOBS_DUPI, 'CD_EMPRESA', vCdEmpresa ) and (
    putitem_e(tOBS_DUPI, 'CD_FORNECEDOR', vCdFornecedor ) and (
    putitem_e(tOBS_DUPI, 'NR_DUPLICATA', vNrDuplicata  ) and (
    putitem_e(tOBS_DUPI, 'NR_PARCELA', vNrParcela)
    to vSeqObsDup;

  vSeqObsDup := vSeqObsDup + 1;
  Result := '';
  putitemXml(Result, 'NR_OBSDUP', vSeqObsDup);

  return(0); exit;
end;

//------------------------------------------------------------
function T_FCPSVCO001.calcVencBase(pParams : String) : String;
//------------------------------------------------------------
const
  cDS_METHOD = 'ADICIONAL=Operação: T_FCPSVCO001.calcVencBase()';
var
  vioparams, vDsLista : String;
  vDiaBase, vDiaSemana, vNrDia, vTpCalculo : Real;
  vInPrimeiro : Boolean;
  vDtCalculo : TDate;
begin
  vDtCalculo := itemXml('DT_CALCULO', pParams);
  vTpCalculo := itemXmlF('TP_CALCULO', pParams);

  xParamEmp := '';
  if (vTpCalculo = 1) then begin
    putitem(xParamEmp,  'DS_CALCBASEDUP');
  end else begin
    putitem(xParamEmp,  'DS_CALCVENCDUP');
  end;
  xParamEmp := T_ADMSVCO001.GetParamEmpresa(piCdEmpresa, xParamEmp); (*itemXml('CD_EMPRESA', *)

  if (vTpCalculo = 1) then begin
    vDsLista := itemXml('DS_CALCBASEDUP', vioparams);
  end else begin
    vDsLista := itemXml('DS_CALCVENCDUP', vioparams);
  end;

  vInPrimeiro := True;

  if (vDsLista <> '') then begin
    length vDsLista;
    while (gresult > 0) do begin
      scan vDsLista, ';
      if (gresult > 0) then begin
        vNrDia := vDsLista[1 : (gresult - 1)];
        vDsLista := vDsLista[(gresult + 1)];
      end else begin
        vNrDia := vDsLista;
        vDsLista := '';
      end;
      if (vInPrimeiro = True) then begin
        vDiaBase := vNrDia;
        vInPrimeiro := False;
      end else begin
        creocc(tTMP_NR09, -1);
        putitem_e(tTMP_NR09, 'NR_GERAL', vNrDia);
        retrieve_o(tTMP_NR09);
        if (xStatus = -7) then begin
          retrieve_x(tTMP_NR09);
        end;
      end;

      length vDsLista;
    end;

    vDiaSemana := vDtCalculo[A];
    creocc(tTMP_NR09, -1);
    putitem_e(tTMP_NR09, 'NR_GERAL', vDiaSemana);
    retrieve_o(tTMP_NR09);
    if (xStatus = 4) then begin
      vNrDia := vDiaBase - vDiaSemana;
    end else begin
      vNrDia := vDiaBase - vDiaSemana + 7;
      discard(tTMP_NR09);
    end;

    vDtCalculo := vDtCalculo + vNrDia;
  end;

  Result := '';
  putitemXml(Result, 'DT_CALCULO', vDtCalculo);

  return(0); exit;
end;

//---------------------------------------------------------------------
function T_FCPSVCO001.duplicarObservacaoDup(pParams : String) : String;
//---------------------------------------------------------------------
const
  cDS_METHOD = 'ADICIONAL=Operação: T_FCPSVCO001.duplicarObservacaoDup()';
var
  vCdEmpresa, vCdFornecedor, vNrDuplicata, vNrParcelaOrigem, vNrParcelaDuplicar, vNrLinha : Real;
begin
  vCdEmpresa := itemXmlF('CD_EMPRESA', pParams);
  if (vCdEmpresa = '') then begin
    Result := SetStatus(STS_ERROR, 'GEN001', 'Favor informar a empresa da duplicata para efetuar duplicação de observação.', cDS_METHOD);
    return(-1); exit;
  end;
  vCdFornecedor := itemXmlF('CD_FORNECEDOR', pParams);
  if (vCdFornecedor = '') then begin
    Result := SetStatus(STS_ERROR, 'GEN001', 'Favor informar o fornecedor da duplicata para efetuar duplicação de observação.', cDS_METHOD);
    return(-1); exit;
  end;
  vNrDuplicata := itemXmlF('NR_DUPLICATA', pParams);
  if (vNrDuplicata = '') then begin
    Result := SetStatus(STS_ERROR, 'GEN001', 'Favor informar o número da duplicata para efetuar duplicação de observação.', cDS_METHOD);
    return(-1); exit;
  end;
  vNrParcelaOrigem := itemXmlF('NR_PARCELAORIGEM', pParams);
  if (vNrParcelaOrigem = '') then begin
    Result := SetStatus(STS_ERROR, 'GEN001', 'Favor informar o número da parcela origem da duplicata para efetuar duplicação de observação.', cDS_METHOD);
    return(-1); exit;
  end;
  vNrParcelaDuplicar := itemXmlF('NR_PARCELADUPLICAR', pParams);
  if (vNrParcelaDuplicar = '') then begin
    Result := SetStatus(STS_ERROR, 'GEN001', 'Favor informar o número da parcela da duplicata a ser duplicada as observações.', cDS_METHOD);
    return(-1); exit;
  end;

  clear_e(tF_OBS_DUPI);
  putitem_o(tF_OBS_DUPI, 'CD_EMPRESA', vCdEmpresa);
  putitem_o(tF_OBS_DUPI, 'CD_FORNECEDOR', vCdFornecedor);
  putitem_o(tF_OBS_DUPI, 'NR_DUPLICATA', vNrDuplicata);
  putitem_o(tF_OBS_DUPI, 'NR_PARCELA', vNrParcelaOrigem);
  retrieve_e(tF_OBS_DUPI);
  if (xStatus >= 0) then begin
    vNrLinha := 0;
    setocc(tF_OBS_DUPI, 1);
    repeat

      vNrLinha := vNrLinha + 1;
      creocc(tOBS_DUPI, -1);
      putitem_e(tOBS_DUPI, 'CD_EMPRESA', vCdEmpresa);
      putitem_e(tOBS_DUPI, 'CD_FORNECEDOR', vCdFornecedor);
      putitem_e(tOBS_DUPI, 'NR_DUPLICATA', vNrDuplicata);
      putitem_e(tOBS_DUPI, 'NR_PARCELA', vNrParcelaDuplicar);
      putitem_e(tOBS_DUPI, 'NR_LINHA', vNrLinha);
      putitem_e(tOBS_DUPI, 'IN_MANUTENCAO', item_b('IN_MANUTENCAO', tF_OBS_DUPI));
      putitem_e(tOBS_DUPI, 'CD_COMPONENTE', 'FCPFP002');

      voParams := converterstring(viParams); (* item_a('DS_OBSERVACAO', tF_OBS_DUPI), item_a('DS_OBSERVACAO', tF_OBS_DUPI) *)
      if (xStatus < 0) then begin
        Result := voParams;
        return(-1); exit;
      end;
      putitem_e(tOBS_DUPI, 'DS_OBSERVACAO', item_a('DS_OBSERVACAO', tF_OBS_DUPI)[1:80]);
      putitem_e(tOBS_DUPI, 'CD_OPERADOR', item_f('CD_OPERADOR', tF_OBS_DUPI));
      putitem_e(tOBS_DUPI, 'DT_CADASTRO', item_a('DT_CADASTRO', tF_OBS_DUPI));

      voParams := tOBS_DUPI.Salvar();
      if (xStatus < 0) then begin
        Result := voParams;
        return(-1); exit;
      end;

      setocc(tF_OBS_DUPI, curocc(tF_OBS_DUPI) + 1);
    until(xStatus < 0);
    xStatus := 0;
  end;

  return(0); exit;
end;

//--------------------------------------------------------------
function T_FCPSVCO001.BaixaDuplicata(pParams : String) : String;
//--------------------------------------------------------------
const
  cDS_METHOD = 'ADICIONAL=Operação: T_FCPSVCO001.BaixaDuplicata()';
begin
var
  vDsListaDuplicata : String;
  vDsLinhaDuplicata : String;
  viParams, voParams : String;
  vCdEmpLiq : Real;
  vNrSeqLiq : Real;
  vDtLiq : TDate;
begin
  vDsListaDuplicata := pParams;

  if (vDsListaDuplicata = '') then begin
    Result := SetStatus(STS_ERROR, 'GEN001', 'Lista de duplicata não informada!', cDS_METHOD);
    return(-1); exit;
  end;

  repeat

    getitem(vDsLinhaDuplicata, vDsListaDuplicata, 1);

    if (itemXml('TP_BAIXA', vDsLinhaDuplicata) = '') then begin
      Result := SetStatus(STS_ERROR, 'GEN001', 'Tipo de baixa não informado !', cDS_METHOD);
      return(-1); exit;
    end;
    if (itemXml('VL_PAGO', vDsLinhaDuplicata)  = '' ) or (itemXmlF('VL_PAGO', vDsLinhaDuplicata) = 0) then begin
      Result := SetStatus(STS_ERROR, 'GEN001', 'Valor pago não informado !', cDS_METHOD);
      return(-1); exit;
    end;
    if (itemXml('CD_EMPRESA', vDsLinhaDuplicata)     = '' ) or (%\ then begin
            itemXmlF('CD_FORNECEDOR', vDsLinhaDuplicata) := '' ) or (
            itemXmlF('NR_DUPLICATA', vDsLinhaDuplicata) := '' ) or (
            itemXmlF('NR_PARCELA', vDsLinhaDuplicata) = '');
      Result := SetStatus(STS_ERROR, 'GEN001', 'Chave da duplicata não informada!', cDS_METHOD);
      return(-1); exit;
    end;
    if (itemXml('CD_EMPLIQ', vDsLinhaDuplicata)  = '' ) or (%\ then begin
            itemXmlF('NR_SEQLIQ', vDsLinhaDuplicata) := '' ) or (
            itemXml('DT_LIQ', vDsLinhaDuplicata) = '');
      Result := SetStatus(STS_ERROR, 'GEN001', 'Chave da liquidação não informada!', cDS_METHOD);
      return(-1); exit;
    end;

    vDtLiq := itemXml('DT_LIQ', vDsLinhaDuplicata);
    if (vDtLiq <> '') then begin
      viParams := '';
      putitemXml(viParams, 'TP_MODELO', 2);
      putitemXml(viParams, 'DT_PROCESSO', vDtLiq);
      putitemXml(viParams, 'CD_COMPONENTE', FCPSVCO001);
      putitemXml(viParams, 'DS_COMPLEMENTO', 'Baixa de Duplicata.');
      voParams := activateCmp('FGRSVCO022', 'validaFechamentoFinanceiro', viParams); (*,,,, *)
      if (xStatus < 0) then begin
        Result := voParams;
        return(-1); exit;
      end;
    end;

    clear_e(tFCP_DUPLICATC);
    creocc(tFCP_DUPLICATC, -1);
    putitem_e(tFCP_DUPLICATC, 'CD_EMPRESA', itemXmlF('CD_EMPRESA', vDsLinhaDuplicata));
    putitem_e(tFCP_DUPLICATC, 'CD_FORNECEDOR', itemXmlF('CD_FORNECEDOR', vDsLinhaDuplicata));
    putitem_e(tFCP_DUPLICATC, 'NR_DUPLICATA', itemXmlF('NR_DUPLICATA', vDsLinhaDuplicata));
    retrieve_o(tFCP_DUPLICATC);
    if (xStatus = -7) then begin
      retrieve_x(tFCP_DUPLICATC);
    end;

    clear_e(tFCP_DUPLICATI);
    putitem_o(tFCP_DUPLICATI, 'NR_PARCELA', itemXmlF('NR_PARCELA', vDsLinhaDuplicata));

    retrieve_e(tFCP_DUPLICATI);
    if (xStatus >= 0) then begin
      putitem_e(tFCP_DUPLICATI, 'TP_SITUACAO', itemXmlF('TP_SITUACAO', vDsLinhaDuplicata));
      putitem_e(tFCP_DUPLICATI, 'TP_BAIXA', itemXmlF('TP_BAIXA', vDsLinhaDuplicata));
      putitem_e(tFCP_DUPLICATI, 'CD_OPERBAIXA', itemXmlF('CD_USUARIO', PARAM_GLB));
      putitem_e(tFCP_DUPLICATI, 'VL_PAGO', itemXmlF('VL_PAGO', vDsLinhaDuplicata));
      putitem_e(tFCP_DUPLICATI, 'DT_BAIXA', itemXml('DT_SISTEMA', PARAM_GLB));
      putitem_e(tFCP_DUPLICATI, 'CD_COMPONENTE', itemXmlF('CD_COMPONENTE', vDsLinhaDuplicata));
      putitem_e(tFCP_DUPLICATI, 'CD_EMPLIQ', itemXmlF('CD_EMPLIQ', vDsLinhaDuplicata));
      putitem_e(tFCP_DUPLICATI, 'DT_LIQ', itemXml('DT_LIQ', vDsLinhaDuplicata));
      putitem_e(tFCP_DUPLICATI, 'NR_SEQLIQ', itemXmlF('NR_SEQLIQ', vDsLinhaDuplicata));
      putitem_e(tFCP_DUPLICATI, 'CD_OPERALTERACAO', itemXmlF('CD_USUARIO', PARAM_GLB));
      putitem_e(tFCP_DUPLICATI, 'DT_ALTERACAO', Now);
    end else begin
      Result := SetStatus(STS_ERROR, 'GEN0001', 'Duplicata não encontrada !', cDS_METHOD);
      return(-1); exit;
    end;

    voParams := tFCP_DUPLICATI.Salvar();
    if (xStatus < 0) then begin
      Result := voParams;
      return(-1); exit;
    end;

    delitem(vDsListaDuplicata, 1);

  until(vDsListaDuplicata = '');

  clear_e(tFCP_DUPLICATC);

  return(0); exit;

end;

//---------------------------------------------------------------
function T_FCPSVCO001.ReabreDuplicata(pParams : String) : String;
//---------------------------------------------------------------
const
  cDS_METHOD = 'ADICIONAL=Operação: T_FCPSVCO001.ReabreDuplicata()';
begin
var
  vDsListaDuplicata : String;
  vDsLinhaDuplicata : String;
  viParams, voParams : String;
  vDtLiq, vDtEmissao : TDate;
begin
  putitem(viParams,  'DT_FECHA_CONTABILIDADE_CP');
  xParamEmp := T_ADMSVCO001.GetParamEmpresa(piCdEmpresa, xParamEmp); (*itemXml('CD_EMPRESA', *)
  gDtFechaContabCP := itemXml('DT_FECHA_CONTABILIDADE_CP', voParams);

  vDsListaDuplicata := pParams;

  if (vDsListaDuplicata = '') then begin
    Result := SetStatus(STS_ERROR, 'GEN001', 'Lista de duplicata não informada!', cDS_METHOD);
    return(-1); exit;
  end;

  repeat

    getitem(vDsLinhaDuplicata, vDsListaDuplicata, 1);

    if (itemXml('CD_EMPRESA', vDsLinhaDuplicata)     = '' ) or (%\ then begin
            itemXmlF('CD_FORNECEDOR', vDsLinhaDuplicata) := '' ) or (
            itemXmlF('NR_DUPLICATA', vDsLinhaDuplicata) := '' ) or (
            itemXmlF('NR_PARCELA', vDsLinhaDuplicata) = '');
      Result := SetStatus(STS_ERROR, 'GEN001', 'Chave da duplicata não informada !', cDS_METHOD);
      return(-1); exit;
    end;

    clear_e(tFCP_DUPLICATC);
    creocc(tFCP_DUPLICATC, -1);
    putitem_e(tFCP_DUPLICATC, 'CD_EMPRESA', itemXmlF('CD_EMPRESA', vDsLinhaDuplicata));
    putitem_e(tFCP_DUPLICATC, 'CD_FORNECEDOR', itemXmlF('CD_FORNECEDOR', vDsLinhaDuplicata));
    putitem_e(tFCP_DUPLICATC, 'NR_DUPLICATA', itemXmlF('NR_DUPLICATA', vDsLinhaDuplicata));
    retrieve_o(tFCP_DUPLICATC);
    if (xStatus = -7) then begin
      retrieve_x(tFCP_DUPLICATC);
    end;

    clear_e(tFCP_DUPLICATI);
    putitem_o(tFCP_DUPLICATI, 'NR_PARCELA', itemXmlF('NR_PARCELA', vDsLinhaDuplicata));

    retrieve_e(tFCP_DUPLICATI);
    if (xStatus >= 0) then begin
      if (item_a('DT_LIQ', tFCP_DUPLICATI) <> '') then begin
        viParams := '';
        putitemXml(viParams, 'TP_MODELO', 2);
        putitemXml(viParams, 'DT_PROCESSO', item_a('DT_LIQ', tFCP_DUPLICATI));
        putitemXml(viParams, 'CD_COMPONENTE', FCPSVCO001);
        putitemXml(viParams, 'DS_COMPLEMENTO', 'Reabertura de Duplicata.');
        voParams := activateCmp('FGRSVCO022', 'validaFechamentoFinanceiro', viParams); (*,,,, *)
        if (xStatus < 0) then begin
          Result := voParams;
          return(-1); exit;
        end;
        if (gDtFechaContabCP > 0) then begin
          if (gDtFechaContabCP >= item_a('DT_LIQ', tFCP_DUPLICATI)) then begin
            Result := SetStatus(STS_ERROR, 'GEN001', 'Fechamento contábil do contas a pagar já realizado! Parâmetro DT_FECHA_CONTABILIDADE_CP', cDS_METHOD);
            return(-1); exit;
          end;
        end;
      end else begin

        viParams := '';
        putitemXml(viParams, 'TP_MODELO', 2);
        putitemXml(viParams, 'DT_PROCESSO', item_a('DT_EMISSAO', tFCP_DUPLICATI));
        putitemXml(viParams, 'CD_COMPONENTE', FCPSVCO001);
        putitemXml(viParams, 'DS_COMPLEMENTO', 'Reabertura de Duplicata.');
        voParams := activateCmp('FGRSVCO022', 'validaFechamentoFinanceiro', viParams); (*,,,, *)
        if (xStatus < 0) then begin
          Result := voParams;
          return(-1); exit;
        end;
        if (gDtFechaContabCP > 0) then begin
          if (gDtFechaContabCP >= item_a('DT_EMISSAO', tFCP_DUPLICATI)) then begin
            Result := SetStatus(STS_ERROR, 'GEN001', 'Fechamento contábil do contas a pagar já realizado! Parâmetro DT_FECHA_CONTABILIDADE_CP', cDS_METHOD);
            return(-1); exit;
          end;
        end;
      end;

      putitem_e(tFCP_DUPLICATI, 'TP_SITUACAO', itemXmlF('TP_SITUACAO', vDsLinhaDuplicata));
      putitem_e(tFCP_DUPLICATI, 'TP_BAIXA', itemXmlF('TP_BAIXA', vDsLinhaDuplicata));
      putitem_e(tFCP_DUPLICATI, 'CD_OPERBAIXA', '');
      putitem_e(tFCP_DUPLICATI, 'VL_PAGO', 0);
      putitem_e(tFCP_DUPLICATI, 'DT_BAIXA', '');
      putitem_e(tFCP_DUPLICATI, 'CD_COMPONENTE', itemXmlF('CD_COMPONENTE', vDsLinhaDuplicata));
      putitem_e(tFCP_DUPLICATI, 'CD_EMPLIQ', '');
      putitem_e(tFCP_DUPLICATI, 'DT_LIQ', '');
      putitem_e(tFCP_DUPLICATI, 'NR_SEQLIQ', '');
      putitem_e(tFCP_DUPLICATI, 'CD_OPERALTERACAO', itemXmlF('CD_USUARIO', PARAM_GLB));
      putitem_e(tFCP_DUPLICATI, 'DT_ALTERACAO', itemXml('DT_SISTEMA', PARAM_GLB));
    end else begin
      Result := SetStatus(STS_ERROR, 'GEN001', 'Duplicata não encontrada !', cDS_METHOD);
      return(-1); exit;
    end;

    voParams := tFCP_DUPLICATI.Salvar();
    if (xStatus < 0) then begin
      Result := voParams;
      return(-1); exit;
    end;

    delitem(vDsListaDuplicata, 1);

  until(vDsListaDuplicata = '');

  clear_e(tFCP_DUPLICATC);

  return(0); exit;

end;

//----------------------------------------------------------------
function T_FCPSVCO001.CancelaDuplicata(pParams : String) : String;
//----------------------------------------------------------------
const
  cDS_METHOD = 'ADICIONAL=Operação: T_FCPSVCO001.CancelaDuplicata()';
begin
var
  vDsListaDuplicata : String;
  vDsLinhaDuplicata : String;
  viParams, voParams : String;
begin
  putitem(viParams,  'DT_FECHA_CONTABILIDADE_CP');
  xParamEmp := T_ADMSVCO001.GetParamEmpresa(piCdEmpresa, xParamEmp); (*itemXml('CD_EMPRESA', *)
  gDtFechaContabCP := itemXml('DT_FECHA_CONTABILIDADE_CP', voParams);

  vDsListaDuplicata := pParams;

  if (vDsListaDuplicata = '') then begin
    Result := SetStatus(STS_ERROR, 'GEN001', 'Lista de duplicata não informada!', cDS_METHOD);
    return(-1); exit;
  end;

  repeat

    getitem(vDsLinhaDuplicata, vDsListaDuplicata, 1);

    if (itemXml('CD_EMPRESA', vDsLinhaDuplicata)     = '' ) or (%\ then begin
            itemXmlF('CD_FORNECEDOR', vDsLinhaDuplicata) := '' ) or (
            itemXmlF('NR_DUPLICATA', vDsLinhaDuplicata) := '' ) or (
            itemXmlF('NR_PARCELA', vDsLinhaDuplicata) = '');
      Result := SetStatus(STS_ERROR, 'GEN001', 'Chave da duplicata não informada !', cDS_METHOD);
      return(-1); exit;
    end;

    clear_e(tFCP_DUPLICATC);
    creocc(tFCP_DUPLICATC, -1);
    putitem_e(tFCP_DUPLICATC, 'CD_EMPRESA', itemXmlF('CD_EMPRESA', vDsLinhaDuplicata));
    putitem_e(tFCP_DUPLICATC, 'CD_FORNECEDOR', itemXmlF('CD_FORNECEDOR', vDsLinhaDuplicata));
    putitem_e(tFCP_DUPLICATC, 'NR_DUPLICATA', itemXmlF('NR_DUPLICATA', vDsLinhaDuplicata));
    retrieve_o(tFCP_DUPLICATC);
    if (xStatus = -7) then begin
      retrieve_x(tFCP_DUPLICATC);
    end;

    clear_e(tFCP_DUPLICATI);
    putitem_o(tFCP_DUPLICATI, 'NR_PARCELA', itemXmlF('NR_PARCELA', vDsLinhaDuplicata));

    retrieve_e(tFCP_DUPLICATI);
    if (xStatus >= 0) then begin
      putitem_e(tFCP_DUPLICATI, 'TP_SITUACAO', 'C');
      putitem_e(tFCP_DUPLICATI, 'CD_OPERALTERACAO', itemXmlF('CD_USUARIO', PARAM_GLB));
      putitem_e(tFCP_DUPLICATI, 'DT_ALTERACAO', itemXml('DT_SISTEMA', PARAM_GLB));
      putitem_e(tFCP_DUPLICATI, 'CD_COMPONENTE', itemXmlF('CD_COMPONENTE', vDsLinhaDuplicata));
    end else begin
      Result := SetStatus(STS_ERROR, 'GEN0001', 'Duplicata não encontrada !', cDS_METHOD);
      return(-1); exit;
    end;

    viParams := '';
    putitemXml(viParams, 'TP_MODELO', 2);
    putitemXml(viParams, 'DT_PROCESSO', itemXml('DT_SISTEMA', PARAM_GLB));
    putitemXml(viParams, 'CD_COMPONENTE', FCPSVCO001);
    putitemXml(viParams, 'DS_COMPLEMENTO', 'Cancelamento de Duplicata.');
    voParams := activateCmp('FGRSVCO022', 'validaFechamentoFinanceiro', viParams); (*,,,, *)
    if (xStatus < 0) then begin
      Result := voParams;
      return(-1); exit;
    end;
    if (gDtFechaContabCP > 0) then begin
      if (gDtFechaContabCP >= itemXml('DT_SISTEMA', PARAM_GLB)) then begin
        Result := SetStatus(STS_ERROR, 'GEN001', 'Fechamento contábil do contas a pagar já realizado! Parâmetro DT_FECHA_CONTABILIDADE_CP', cDS_METHOD);
        return(-1); exit;
      end;
    end;

    voParams := tFCP_DUPLICATI.Salvar();
    if (xStatus < 0) then begin
      Result := voParams;
      return(-1); exit;
    end;

    delitem(vDsListaDuplicata, 1);

  until(vDsListaDuplicata = '');

  clear_e(tFCP_DUPLICATC);

  return(0); exit;

end;

//------------------------------------------------------------
function T_FCPSVCO001.gravaImposto(pParams : String) : String;
//------------------------------------------------------------
const
  cDS_METHOD = 'ADICIONAL=Operação: T_FCPSVCO001.gravaImposto()';
var
  vCdEmpresa, vCdFornecedor, vNrDuplicata, vNrParcela, vCdImposto : Real;
  vDsImposto : String;
begin
  vDsImposto := pParams;
  vCdEmpresa := itemXmlF('CD_EMPRESA', pParams);
  vCdFornecedor := itemXmlF('CD_FORNECEDOR', pParams);
  vNrDuplicata := itemXmlF('NR_DUPLICATA', pParams);
  vNrParcela := itemXmlF('NR_PARCELA', pParams);
  vCdImposto := itemXmlF('CD_IMPOSTO', pParams);

  if (vCdEmpresa = '') then begin
    Result := SetStatus(STS_ERROR, 'GEN001', 'Empresa não informada!', cDS_METHOD);
    return(-1); exit;
  end;
  if (vCdFornecedor = '') then begin
    Result := SetStatus(STS_ERROR, 'GEN001', 'Fornecedor não informado!', cDS_METHOD);
    return(-1); exit;
  end;
  if (vNrDuplicata = '') then begin
    Result := SetStatus(STS_ERROR, 'GEN001', 'Duplicata não informada!', cDS_METHOD);
    return(-1); exit;
  end;
  if (vNrParcela = '') then begin
    Result := SetStatus(STS_ERROR, 'GEN001', 'Parcela não informada!', cDS_METHOD);
    return(-1); exit;
  end;
  if (vCdImposto = '') then begin
    Result := SetStatus(STS_ERROR, 'GEN001', 'Imposto não informado!', cDS_METHOD);
    return(-1); exit;
  end;

  clear_e(tFCP_DUPLICATI);
  putitem_e(tFCP_DUPLICATI, 'CD_EMPRESA', vCdEmpresa);
  putitem_e(tFCP_DUPLICATI, 'CD_FORNECEDOR', vCdFornecedor);
  putitem_e(tFCP_DUPLICATI, 'NR_DUPLICATA', vNrDuplicata);
  putitem_e(tFCP_DUPLICATI, 'NR_PARCELA', vNrParcela);
  retrieve_e(tFCP_DUPLICATI);
  if (xStatus < 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN001', 'Duplicata ' + FloatToStr(vCdEmpresa) + '/' + FloatToStr(vCdFornecedor) + '/' + FloatToStr(vNrDuplicata) + '/' + FloatToStr(vNrParcela) + '!', cDS_METHOD);
    return(-1); exit;
  end;

  clear_e(tF_FCP_DUPIMPO);
  creocc(tF_FCP_DUPIMPO, -1);
  putitem_e(tF_FCP_DUPIMPO, 'CD_EMPRESA', vCdEmpresa);
  putitem_e(tF_FCP_DUPIMPO, 'CD_FORNECEDOR', vCdFornecedor);
  putitem_e(tF_FCP_DUPIMPO, 'NR_DUPLICATA', vNrDuplicata);
  putitem_e(tF_FCP_DUPIMPO, 'NR_PARCELA', vNrParcela);
  putitem_e(tF_FCP_DUPIMPO, 'CD_IMPOSTO', vCdImposto);
  retrieve_o(tF_FCP_DUPIMPO);
  if (xStatus = -7) then begin
    retrieve_x(tF_FCP_DUPIMPO);
  end;

  delitem(vDsImposto, 'CD_EMPRESA');
  delitem(vDsImposto, 'CD_FORNECEDOR');
  delitem(vDsImposto, 'NR_DUPLICATA');
  delitem(vDsImposto, 'NR_PARCELA');
  delitem(vDsImposto, 'CD_IMPOSTO');
  getlistitensocc_e(vDsImposto, tF_FCP_DUPIMPO);
  putitem_e(tF_FCP_DUPIMPO, 'CD_OPERADOR', itemXmlF('CD_USUARIO', PARAM_GLB));
  putitem_e(tF_FCP_DUPIMPO, 'DT_CADASTRO', Now);
  voParams := tF_FCP_DUPIMPO.Salvar();
  if (xStatus < 0) then begin
    Result := voParams;
    return(-1); exit;
  end;

  clear_e(tFCP_DUPLICATC);
  clear_e(tF_FCP_DUPIMPOSTO);

  return(0); exit;
end;

//-------------------------------------------------------------------------
function T_FCPSVCO001.gravaDespesaAproDuplicata(pParams : String) : String;
//-------------------------------------------------------------------------
const
  cDS_METHOD = 'ADICIONAL=Operação: T_FCPSVCO001.gravaDespesaAproDuplicata()';
var
  vCdEmpresa, vCdFornecedor, vNrDuplicata, vNrParcela, vCdDespesaItem, vNrSeqApro : Real;
  vPrRateio, vVlRateio, vTpCustoDespesa : Real;
  vDtApropriacao : TDate;
begin
  vCdEmpresa := itemXmlF('CD_EMPRESA', pParams);
  vCdFornecedor := itemXmlF('CD_FORNECEDOR', pParams);
  vNrDuplicata := itemXmlF('NR_DUPLICATA', pParams);
  vNrParcela := itemXmlF('NR_PARCELA', pParams);
  vCdDespesaItem := itemXmlF('CD_DESPESAITEM', pParams);
  vNrSeqApro := itemXmlF('NR_SEQAPRO', pParams);
  if (vNrSeqApro = '' ) or (vNrSeqApro = 0) then begin
    select max(NR_SEQAPRO) 
      from 'FCP_DUPDESPAPSVC'    
      where (putitem_e(tFCP_DUPDESPAP, 'CD_EMPRESA', vCdEmpresa      ) and (
              putitem_e(tFCP_DUPDESPAP, 'CD_FORNECEDOR', vCdFornecedor   ) and (
              putitem_e(tFCP_DUPDESPAP, 'NR_DUPLICATA', vNrDuplicata    ) and (
              putitem_e(tFCP_DUPDESPAP, 'NR_PARCELA', vNrParcela      ) and (
              putitem_e(tFCP_DUPDESPAP, 'CD_DESPESAITEM', vCdDespesaItem)
            to vNrSeqApro;
  end;
  if (vNrSeqApro = '' ) or (vNrSeqApro = 0) then begin
    vNrSeqApro := 1;
  end else begin
    vNrSeqApro := vNrSeqApro + 1;
  end;
  vTpCustoDespesa := itemXmlF('TP_CUSTODESPESA', pParams);
  vDtApropriacao := itemXml('DT_APROPRIACAO', pParams);
  vPrRateio := itemXmlF('PR_RATEIO', pParams);
  vVlRateio := itemXmlF('VL_RATEIO', pParams);

  clear_e(tFCP_DUPDESPAP);

  creocc(tFCP_DUPDESPAP, -1);
  putitem_e(tFCP_DUPDESPAP, 'CD_EMPRESA', vCdEmpresa);
  putitem_e(tFCP_DUPDESPAP, 'CD_FORNECEDOR', vCdFornecedor);
  putitem_e(tFCP_DUPDESPAP, 'NR_DUPLICATA', vNrDuplicata);
  putitem_e(tFCP_DUPDESPAP, 'NR_PARCELA', vNrParcela);
  putitem_e(tFCP_DUPDESPAP, 'CD_DESPESAITEM', vCdDespesaItem);
  putitem_e(tFCP_DUPDESPAP, 'NR_SEQAPRO', vNrSeqApro);
  retrieve_o(tFCP_DUPDESPAP);
  if (xStatus = -7) then begin
    retrieve_x(tFCP_DUPDESPAP);
  end;

  putitem_e(tFCP_DUPDESPAP, 'CD_OPERADOR', itemXmlF('CD_USUARIO', PARAM_GLB));
  putitem_e(tFCP_DUPDESPAP, 'DT_CADASTRO', Now);
  putitem_e(tFCP_DUPDESPAP, 'TP_CUSTODESPESA', vTpCustoDespesa);
  putitem_e(tFCP_DUPDESPAP, 'DT_APROPRIACAO', vDtApropriacao);
  putitem_e(tFCP_DUPDESPAP, 'PR_RATEIO', vPrRateio);
  putitem_e(tFCP_DUPDESPAP, 'VL_RATEIO', vVlRateio);

  voParams := tFCP_DUPDESPAP.Salvar();
  if (xStatus < 0) then begin
    Result := voParams;
    return(-1); exit;
  end;

  clear_e(tFCP_DUPDESPAP);

  return(0); exit;
end;

//----------------------------------------------------------------------------
function T_FCPSVCO001.exclusaoDespesaAproDuplicata(pParams : String) : String;
//----------------------------------------------------------------------------
const
  cDS_METHOD = 'ADICIONAL=Operação: T_FCPSVCO001.exclusaoDespesaAproDuplicata()';
var
  vCdEmpresa, vCdFornecedor, vNrDuplicata, vNrParcela, vCdDespesaItem, vNrSeqApro : Real;
  vPrRateio, vVlRateio, vTpCustoDespesa : Real;
  vDtApropriacao : TDate;
begin
  vCdEmpresa := itemXmlF('CD_EMPRESA', pParams);
  vCdFornecedor := itemXmlF('CD_FORNECEDOR', pParams);
  vNrDuplicata := itemXmlF('NR_DUPLICATA', pParams);
  vNrParcela := itemXmlF('NR_PARCELA', pParams);
  vCdDespesaItem := itemXmlF('CD_DESPESAITEM', pParams);

  clear_e(tFCP_DUPDESPAP);

  putitem_o(tFCP_DUPDESPAP, 'CD_EMPRESA', vCdEmpresa);
  putitem_o(tFCP_DUPDESPAP, 'CD_FORNECEDOR', vCdFornecedor);
  putitem_o(tFCP_DUPDESPAP, 'NR_DUPLICATA', vNrDuplicata);
  putitem_o(tFCP_DUPDESPAP, 'NR_PARCELA', vNrParcela);
  putitem_o(tFCP_DUPDESPAP, 'CD_DESPESAITEM', vCdDespesaItem);
  retrieve_e(tFCP_DUPDESPAP);
  if (xStatus >= 0) then begin
    setocc(tFCP_DUPDESPAP, 1);
    while (xStatus >= 0) do begin
      voParams := tFCP_DUPDESPAP.Excluir();
      if (xStatus < 0) then begin
        Result := voParams;
        return(-1); exit;
      end;
      if (empty(tFCP_DUPDESPAP)) then begin
        xStatus := -1;
      end else begin
        setocc(tFCP_DUPDESPAP, curocc(tFCP_DUPDESPAP) + 1);
      end;
    end;
  end;

  clear_e(tFCP_DUPDESPAP);

  return(0); exit;
end;

//----------------------------------------------------------------------------
function T_FCPSVCO001.gravarClassificacaoDuplicata(pParams : String) : String;
//----------------------------------------------------------------------------
const
  cDS_METHOD = 'ADICIONAL=Operação: T_FCPSVCO001.gravarClassificacaoDuplicata()';
var
  vLstDuplicata, vLstClas, vLstClasAux, vCdClas, vDsRegistro : String;
  vCdEmpDup, vCdFornecDup, vNrDuplicata, vNrParcelaDup, vCdTipoClas : Real;
begin
  vLstDuplicata := itemXml('LST_DUPLICATA', pParams);
  if (vLstDuplicata = '') then begin
    Result := SetStatus(STS_ERROR, 'GEN001', 'Lista de duplicata não informada para atualizar classificação.', cDS_METHOD);
    return(-1); exit;
  end;
  if (itemXml('LST_CLAS', pParams) = '') then begin
    Result := SetStatus(STS_ERROR, 'GEN001', 'Lista de classificação não informada para atualização.', cDS_METHOD);
    return(-1); exit;
  end;

  repeat
    getitem(vDsRegistro, vLstDuplicata, 1);

    vCdEmpDup := itemXmlF('CD_EMPRESA', vDsRegistro);
    vCdFornecDup := itemXmlF('CD_FORNECEDOR', vDsRegistro);
    vNrDuplicata := itemXmlF('NR_DUPLICATA', vDsRegistro);
    vNrParcelaDup := itemXmlF('NR_PARCELA', vDsRegistro);

    if (vCdEmpDup = '')  or (vCdEmpDup = 0) then begin
      Result := SetStatus(STS_ERROR, 'GEN001', 'Empresa da duplicata não informada para atualização de classificação.', cDS_METHOD);
      return(-1); exit;
    end;
    if (vCdFornecDup = '')  or (vCdFornecDup = 0) then begin
      Result := SetStatus(STS_ERROR, 'GEN001', 'Fornecedor da duplicata não informado para atualização de classificação.', cDS_METHOD);
      return(-1); exit;
    end;
    if (vNrDuplicata = '')  or (vNrDuplicata = 0) then begin
      Result := SetStatus(STS_ERROR, 'GEN001', 'Número da duplicata não informado para atualização de classificação.', cDS_METHOD);
      return(-1); exit;
    end;
    if (vNrParcelaDup = '')  or (vNrParcelaDup = 0) then begin
      Result := SetStatus(STS_ERROR, 'GEN001', 'Parcela da duplicata não informada para atualização de classificação.', cDS_METHOD);
      return(-1); exit;
    end;

    clear_e(tFCP_DUPLICATI);
    putitem_o(tFCP_DUPLICATI, 'CD_EMPRESA', vCdEmpDup);
    putitem_o(tFCP_DUPLICATI, 'CD_FORNECEDOR', vCdFornecDup);
    putitem_o(tFCP_DUPLICATI, 'NR_DUPLICATA', vNrDuplicata);
    putitem_o(tFCP_DUPLICATI, 'NR_PARCELA', vNrParcelaDup);
    retrieve_e(tFCP_DUPLICATI);
    if (xStatus < 0) then begin
      Result := SetStatus(STS_ERROR, 'GEN001', 'Duplicata inválida.Empresa: ' + FloatToStr(vCdEmpDup) + ' Fornecedor: ' + FloatToStr(vCdFornecDup) + ' Duplicata: ' + FloatToStr(vNrDuplicata) + ' Parcela: ' + FloatToStr(vNrParcelaDup',) + ' cDS_METHOD);
      return(-1); exit;
    end;

    message/hint 'Atualizando classificação da duplicata: ' + FloatToStr(vNrDuplicata) + ' / ' + FloatToStr(vNrParcelaDup') + ';
    vLstClas := itemXml('LST_CLAS', pParams);
    repeat
      vDsRegistro := '';
      getitem(vDsRegistro, vLstClas, 1);

      vCdTipoClas := itemXmlF('CD_TIPOCLAS', vDsRegistro);
      vCdClas := itemXmlF('CD_CLAS', vDsRegistro);
      if (vCdTipoClas = '') then begin
        Result := SetStatus(STS_ERROR, 'GEN001', 'Tipo de classificação não informado para atualização.', cDS_METHOD);
        return(-1); exit;
      end;
      if (vCdClas = '') then begin
        Result := SetStatus(STS_ERROR, 'GEN001', 'Classificação não informada para atualização.', cDS_METHOD);
        return(-1); exit;
      end;

      clear_e(tFCP_TIPOCLAS);
      putitem_o(tFCP_TIPOCLAS, 'CD_TIPOCLAS', vCdTipoClas);
      retrieve_e(tFCP_TIPOCLAS);
      if (xStatus < 0) then begin
        Result := SetStatus(STS_ERROR, 'GEN001', 'Tipo de classificação inválido para atualização.Tipo classificação: ' + FloatToStr(vCdTipoClas',) + ' cDS_METHOD);
        return(-1); exit;
      end;

      clear_e(tFCP_CLAS);
      putitem_o(tFCP_CLAS, 'CD_TIPOCLAS', vCdTipoClas);
      putitem_o(tFCP_CLAS, 'CD_CLASSIFICACAO', vCdClas);
      retrieve_e(tFCP_CLAS);
      if (xStatus < 0) then begin
        Result := SetStatus(STS_ERROR, 'GEN001', 'Tipo e classificação inválidos para atualização.Tipo classificação: ' + FloatToStr(vCdTipoClas) + ' Classificação: ' + FloatToStr(vCdClas',) + ' cDS_METHOD);
        return(-1); exit;
      end;

      creocc(tFCP_DUPCLAS, -1);
      putitem_e(tFCP_DUPCLAS, 'CD_EMPRESA', vCdEmpDup);
      putitem_e(tFCP_DUPCLAS, 'CD_FORNECEDOR', vCdFornecDup);
      putitem_e(tFCP_DUPCLAS, 'NR_DUPLICATA', vNrDuplicata);
      putitem_e(tFCP_DUPCLAS, 'NR_PARCELA', vNrParcelaDup);
      putitem_e(tFCP_DUPCLAS, 'CD_TIPOCLAS', vCdTipoClas);
      putitem_e(tFCP_DUPCLAS, 'CD_CLASSIFICACAO', vCdClas);
      retrieve_o(tFCP_DUPCLAS);
      if (xStatus = -7) then begin
        retrieve_x(tFCP_DUPCLAS);
      end;
      putitem_e(tFCP_DUPCLAS, 'CD_OPERADOR', itemXmlF('CD_USUARIO', PARAM_GLB));
      putitem_e(tFCP_DUPCLAS, 'DT_CADASTRO', Now);

      voParams := tFCP_DUPCLAS.Salvar();
      if (xStatus < 0) then begin
        Result := voParams;
        return(-1); exit;
      end;

      delitem(vLstClas, 1);
    until(vLstClas = '');

    delitem(vLstDuplicata, 1);
  until(vLstDuplicata = '');
  message/hint '';

  clear_e(tFCP_DUPLICATI);

  return(0); exit;
end;

//-----------------------------------------------------------------------------
function T_FCPSVCO001.validarClassificacaoDuplicata(pParams : String) : String;
//-----------------------------------------------------------------------------
const
  cDS_METHOD = 'ADICIONAL=Operação: T_FCPSVCO001.validarClassificacaoDuplicata()';
var
  vLstClas, vCdClas, vDsRegistro : String;
  vCdEmpDup, vCdFornecDup, vNrDuplicata, vNrParcelaDup, vCdTipoClas : Real;
  vInClassificacao : Boolean;
begin
  vCdEmpDup := itemXmlF('CD_EMPRESA', pParams);
  vCdFornecDup := itemXmlF('CD_FORNECEDOR', pParams);
  vNrDuplicata := itemXmlF('NR_DUPLICATA', pParams);
  vNrParcelaDup := itemXmlF('NR_PARCELA', pParams);

  if (vCdEmpDup = '')  or (vCdEmpDup = 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN001', 'Empresa da duplicata não informada para validar classificação.', cDS_METHOD);
    return(-1); exit;
  end;
  if (vCdFornecDup = '')  or (vCdFornecDup = 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN001', 'Fornecedor da duplicata não informado para validar classificação.', cDS_METHOD);
    return(-1); exit;
  end;
  if (vNrDuplicata = '')  or (vNrDuplicata = 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN001', 'Número da duplicata não informado para validar classificação.', cDS_METHOD);
    return(-1); exit;
  end;
  if (vNrParcelaDup = '')  or (vNrParcelaDup = 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN001', 'Parcela da duplicata não informada para validar classificação.', cDS_METHOD);
    return(-1); exit;
  end;

  vLstClas := itemXml('LST_CLAS', pParams);
  if (vLstClas = '') then begin
    Result := SetStatus(STS_ERROR, 'GEN001', 'Lista de classificação não informada para validação.', cDS_METHOD);
    return(-1); exit;
  end;

  vInClassificacao := True;

  repeat
    getitem(vDsRegistro, vLstClas, 1);
    vCdTipoClas := itemXmlF('CD_TIPOCLAS', vDsRegistro);
    vCdClas := itemXmlF('CD_CLAS', vDsRegistro);
    if (vCdTipoClas = '') then begin
      Result := SetStatus(STS_ERROR, 'GEN001', 'Tipo de classificação não informado para atualização.', cDS_METHOD);
      return(-1); exit;
    end;
    if (vCdClas = '') then begin
      Result := SetStatus(STS_ERROR, 'GEN001', 'Classificação não informada para atualização.', cDS_METHOD);
      return(-1); exit;
    end;

    clear_e(tFCP_TIPOCLAS);
    putitem_o(tFCP_TIPOCLAS, 'CD_TIPOCLAS', vCdTipoClas);
    retrieve_e(tFCP_TIPOCLAS);
    if (xStatus < 0) then begin
      Result := SetStatus(STS_ERROR, 'GEN001', 'Tipo de classificação inválido para validação.Tipo classificação: ' + FloatToStr(vCdTipoClas',) + ' cDS_METHOD);
      return(-1); exit;
    end;

    clear_e(tFCP_CLAS);
    putitem_o(tFCP_CLAS, 'CD_TIPOCLAS', vCdTipoClas);
    putitem_o(tFCP_CLAS, 'CD_CLASSIFICACAO', vCdClas);
    retrieve_e(tFCP_CLAS);
    if (xStatus < 0) then begin
      Result := SetStatus(STS_ERROR, 'GEN001', 'Tipo e classificação inválidos para validação.Tipo classificação: ' + FloatToStr(vCdTipoClas) + ' Classificação: ' + FloatToStr(vCdClas',) + ' cDS_METHOD);
      return(-1); exit;
    end;

    clear_e(tFCP_DUPCLAS);
    putitem_o(tFCP_DUPCLAS, 'CD_EMPRESA', vCdEmpDup);
    putitem_o(tFCP_DUPCLAS, 'CD_FORNECEDOR', vCdFornecDup);
    putitem_o(tFCP_DUPCLAS, 'NR_DUPLICATA', vNrDuplicata);
    putitem_o(tFCP_DUPCLAS, 'NR_PARCELA', vNrParcelaDup);
    putitem_o(tFCP_DUPCLAS, 'CD_TIPOCLAS', vCdTipoClas);
    putitem_o(tFCP_DUPCLAS, 'CD_CLASSIFICACAO', vCdClas);
    retrieve_e(tFCP_DUPCLAS);

    if (xStatus < 0) then begin
      vInClassificacao := False;
    end;

    delitem(vLstClas, 1);
  until(vLstClas = '');
  Result := '';
  putitemXml(Result, 'IN_CLASSIFICACAO', vInClassificacao);

  return(0); exit;
end;

//------------------------------------------------------------------------
function T_FCPSVCO001.gravaClassificacaoForDup(pParams : String) : String;
//------------------------------------------------------------------------
const
  cDS_METHOD = 'ADICIONAL=Operação: T_FCPSVCO001.gravaClassificacaoForDup()';
var
  viParams, voParams, vDsLstClas, vDsLstDuplicata, vDsRegistro : String;
  vCdEmpresa, vCdFornecedor, vNrDuplicata, vNrParcela : Real;
begin
  vCdEmpresa := itemXmlF('CD_EMPRESA', pParams);
  vCdFornecedor := itemXmlF('CD_FORNECEDOR', pParams);
  vNrDuplicata := itemXmlF('NR_DUPLICATA', pParams);
  vNrParcela := itemXmlF('NR_PARCELA', pParams);

  clear_e(tPES_PESSOACLA);
  putitem_o(tPES_PESSOACLA, 'CD_PESSOA', vCdFornecedor);
  putitem_o(tPES_PESSOACLA, 'CD_TIPOCLAS', gCdTipoClasForDup);
  retrieve_e(tPES_PESSOACLA);
  if (xStatus >= 0) then begin
    setocc(tPES_PESSOACLA, 1);
    while (xStatus >= 0) do begin

      clear_e(tFCP_TIPOCLAS);
      creocc(tFCP_TIPOCLAS, -1);
      putitem_o(tFCP_TIPOCLAS, 'CD_TIPOCLAS', item_f('CD_TIPOCLAS', tPES_PESSOACLA));
      retrieve_o(tFCP_TIPOCLAS);
      if (xStatus = -7) then begin
        retrieve_x(tFCP_TIPOCLAS);
      end else begin
        clear_e(tPES_TIPOCLAS);
        putitem_e(tPES_TIPOCLAS, 'CD_TIPOCLAS', item_f('CD_TIPOCLAS', tPES_PESSOACLA));
        retrieve_e(tPES_TIPOCLAS);
        if (xStatus >= 0) then begin
          putitem_e(tFCP_TIPOCLAS, 'DS_TIPOCLAS', item_a('DS_TIPOCLAS', tPES_TIPOCLAS));
        end;

        putitem_e(tFCP_TIPOCLAS, 'CD_OPERADOR', itemXmlF('CD_USUARIO', PARAM_GLB));
        putitem_e(tFCP_TIPOCLAS, 'DT_CADASTRO', Now);

        voParams := tFCP_TIPOCLAS.Salvar();
        if (xStatus < 0) then begin
          Result := voParams;
          return(-1); exit;
        end;
      end;

      clear_e(tFCP_CLAS);
      creocc(tFCP_CLAS, -1);
      putitem_o(tFCP_CLAS, 'CD_TIPOCLAS', item_f('CD_TIPOCLAS', tPES_PESSOACLA));
      putitem_o(tFCP_CLAS, 'CD_CLASSIFICACAO', item_f('CD_CLASSIFICACAO', tPES_PESSOACLA));
      retrieve_o(tFCP_CLAS);
      if (xStatus = -7) then begin
        retrieve_x(tFCP_CLAS);
      end else begin
        clear_e(tPES_CLASSIFIC);
        putitem_e(tPES_CLASSIFIC, 'CD_TIPOCLAS', item_f('CD_TIPOCLAS', tPES_PESSOACLA));
        putitem_e(tPES_CLASSIFIC, 'CD_CLASSIFICACAO', item_f('CD_CLASSIFICACAO', tPES_PESSOACLA));
        retrieve_e(tPES_CLASSIFIC);
        if (xStatus >= 0) then begin
          putitem_e(tFCP_CLAS, 'DS_CLASSIFICACAO', item_a('DS_CLASSIFICACAO', tPES_CLASSIFIC));
        end;

        putitem_e(tFCP_CLAS, 'CD_OPERADOR', itemXmlF('CD_USUARIO', PARAM_GLB));
        putitem_e(tFCP_CLAS, 'DT_CADASTRO', Now);

        voParams := tFCP_CLAS.Salvar();
        if (xStatus < 0) then begin
          Result := voParams;
          return(-1); exit;
        end;
      end;

      vDsLstDuplicata := '';
      vDsRegistro := '';
      putitemXml(vDsRegistro, 'CD_EMPRESA', vCdEmpresa);
      putitemXml(vDsRegistro, 'CD_FORNECEDOR', vCdFornecedor);
      putitemXml(vDsRegistro, 'NR_DUPLICATA', vNrDuplicata);
      putitemXml(vDsRegistro, 'NR_PARCELA', vNrParcela);
      putitem(vDsLstDuplicata,  vDsRegistro);

      vDsRegistro := '';
      putitemXml(vDsRegistro, 'CD_TIPOCLAS', item_f('CD_TIPOCLAS', tPES_PESSOACLA));
      putitemXml(vDsRegistro, 'CD_CLAS', item_f('CD_CLASSIFICACAO', tPES_PESSOACLA));
      putitem(vDsLstClas,  vDsRegistro);

      clear_e(tFCP_DUPCLAS);
      putitem_o(tFCP_DUPCLAS, 'CD_EMPRESA', vCdEmpresa);
      putitem_o(tFCP_DUPCLAS, 'CD_FORNECEDOR', vCdFornecedor);
      putitem_o(tFCP_DUPCLAS, 'NR_DUPLICATA', vNrDuplicata);
      putitem_o(tFCP_DUPCLAS, 'NR_PARCELA', vNrParcela);
      retrieve_e(tFCP_DUPCLAS);
      if (xStatus >= 0) then begin
        setocc(tFCP_DUPCLAS, 1);
        while (xStatus >= 0) do begin
          vDsRegistro := '';
          putitemXml(vDsRegistro, 'CD_TIPOCLAS', item_f('CD_TIPOCLAS', tFCP_DUPCLAS));
          putitemXml(vDsRegistro, 'CD_CLAS', item_f('CD_CLASSIFICACAO', tFCP_DUPCLAS));
          putitem(vDsLstClas,  vDsRegistro);

          setocc(tFCP_DUPCLAS, curocc(tFCP_DUPCLAS) + 1);
        end;
      end;

      viParams := '';
      putitemXml(viParams, 'LST_DUPLICATA', vDsLstDuplicata);
      putitemXml(viParams, 'LST_CLAS', vDsLstClas);
      voParams := gravarClassificacaoDuplicata(viParams); (* PARAM_GLB, viParams, voParams, xCdErro, xCtxErro *)
      if (xStatus < 0) then begin
        Result := SetStatus(STS_ERROR, xProcerror, 'xProcerrorcontext', cDS_METHOD);
        return(-1); exit;
      end;

      setocc(tPES_PESSOACLA, curocc(tPES_PESSOACLA) + 1);
    end;
  end;

  return(0); exit;
end;

//---------------------------------------------------------------------
function T_FCPSVCO001.verLanctoCtbDuplicata(pParams : String) : String;
//---------------------------------------------------------------------
const
  cDS_METHOD = 'ADICIONAL=Operação: T_FCPSVCO001.verLanctoCtbDuplicata()';
var
  vCdEmpresa, vCdFornecedor, vNrDuplicata, vNrParcela : Real;
begin
  vCdEmpresa := itemXmlF('CD_EMPRESA', pParams);
  if (vCdEmpresa = '') then begin
    Result := SetStatus(STS_ERROR, 'GEN001', 'Favor informar a empresa da duplicata para efetuar a consulta de contabilização.', cDS_METHOD);
    return(-1); exit;
  end;
  vCdFornecedor := itemXmlF('CD_FORNECEDOR', pParams);
  if (vCdFornecedor = '') then begin
    Result := SetStatus(STS_ERROR, 'GEN001', 'Favor informar o fornecedor da duplicata para efetuar a consulta de contabilização.', cDS_METHOD);
    return(-1); exit;
  end;
  vNrDuplicata := itemXmlF('NR_DUPLICATA', pParams);
  if (vNrDuplicata = '') then begin
    Result := SetStatus(STS_ERROR, 'GEN001', 'Favor informar o número da duplicata para efetuar a consulta de contabilização.', cDS_METHOD);
    return(-1); exit;
  end;
  vNrParcela := itemXmlF('NR_PARCELA', pParams);
  if (vNrParcela = '') then begin
    Result := SetStatus(STS_ERROR, 'GEN001', 'Favor informar o número da parcela da duplicata para efetuar a consulta de contabilização.', cDS_METHOD);
    return(-1); exit;
  end;

  clear_e(tCTB_MOVTOD);
  putitem_o(tCTB_MOVTOD, 'CD_EMPRESA', vCdEmpresa);
  putitem_o(tCTB_MOVTOD, 'CD_PESSOA', vCdFornecedor);
  putitem_o(tCTB_MOVTOD, 'NR_DUPLICATA', vNrDuplicata);
  putitem_o(tCTB_MOVTOD, 'NR_PARCELA', vNrParcela);
  retrieve_e(tCTB_MOVTOD);
  if (xStatus < 0) then begin
    putitemXml(Result, 'IN_CONTABILIZADO', False);
    return(0); exit;
  end;

  putitemXml(Result, 'IN_CONTABILIZADO', True);
  putitemXml(Result, 'CD_POOLEMPRESA', item_f('CD_POOLEMPRESA', tCTB_MOVTOD));
  putitemXml(Result, 'DT_EXERCONTABIL', item_a('DT_EXERCONTABIL', tCTB_MOVTOD));
  putitemXml(Result, 'NR_LOTE', item_f('NR_LOTE', tCTB_MOVTOD));
  putitemXml(Result, 'NR_ORDEM', item_f('NR_ORDEM', tCTB_MOVTOD));

  return(0); exit;

end;

//---------------------------------------------------------------------------
function T_FCPSVCO001.validaLanctoContabilPeriodo(pParams : String) : String;
//---------------------------------------------------------------------------
const
  cDS_METHOD = 'ADICIONAL=Operação: T_FCPSVCO001.validaLanctoContabilPeriodo()';
var
  vDtChegada : TDate;
  viParams, voParams, vTpInclusao : String;
  vCdEmpresa, vCdGrupoEmissaoCP : Real;
begin
  vTpInclusao := itemXmlF('TP_INCLUSAO', pParams);
  if (vTpInclusao <> 1) then begin
    return(0); exit;
  end;
  vCdEmpresa := itemXmlF('CD_EMPRESA', pParams);
  if (vCdEmpresa = '')  or (vCdEmpresa <= 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN001', 'Empresa da duplicata não informada!', cDS_METHOD);
    return(-1); exit;
  end;
  vDtChegada := itemXml('DT_CHEGADA', pParams);
  if (vDtChegada = '') then begin
    Result := SetStatus(STS_ERROR, 'GEN001', 'Data de chegada da duplicata não informada!', cDS_METHOD);
    return(-1); exit;
  end;

  putitem(viParams,  'CD_GRUPO_EMISSAO_CP');
  xParam := T_ADMSVCO001.GetParametro(xParam); (*,,, *)
  vCdGrupoEmissaoCP := itemXmlF('CD_GRUPO_EMISSAO_CP', voParams);

  clear_e(tCTB_LOTE);
  putitem_o(tCTB_LOTE, 'CD_POOLEMPRESA', itemXmlF('CD_POOLEMPRESA', PARAM_GLB));
  putitem_o(tCTB_LOTE, 'DT_FINAL', '>=' + vDtChegada' + ');
  putitem_o(tCTB_LOTE, 'CD_GRUPO', vCdGrupoEmissaoCP);
  putitem_o(tCTB_LOTE, 'CD_MODULO', 'FCP');
  retrieve_e(tCTB_LOTE);
  if (xStatus >= 0) then begin
    setocc(tCTB_LOTE, 1);
    while (xStatus >= 0) do begin

      clear_e(tCTB_MOVTOD);
      putitem_o(tCTB_MOVTOD, 'CD_POOLEMPRESA', item_f('CD_POOLEMPRESA', tCTB_LOTE));
      putitem_o(tCTB_MOVTOD, 'DT_EXERCONTABIL', item_a('DT_EXERCONTABIL', tCTB_LOTE));
      putitem_o(tCTB_MOVTOD, 'NR_LOTE', item_f('NR_LOTE', tCTB_LOTE));
      putitem_o(tCTB_MOVTOD, 'CD_EMPRESA', vCdEmpresa);
      retrieve_e(tCTB_MOVTOD);
      if (xStatus >= 0) then begin
        Result := SetStatus(STS_AVISO, 'GEN001', 'Não é possível cadastrar duplicata, pois existe lote já contabilizado no período. Data: ' + item_a('DT_EXERCONTABIL', tCTB_LOTE) + ' Lote: ' + item_a('NR_LOTE', tCTB_LOTE) + '', cDS_METHOD);
        return(-1); exit;
      end;

      setocc(tCTB_LOTE, curocc(tCTB_LOTE) + 1);
    end;
  end;

  return(0); exit;
end;

//---------------------------------------------------------------
function T_FCPSVCO001.gravaFcpDupAdic(pParams : String) : String;
//---------------------------------------------------------------
const
  cDS_METHOD = 'ADICIONAL=Operação: T_FCPSVCO001.gravaFcpDupAdic()';
var
  vCdEmpresa, vCdFornecedor, vNrDuplicata, vNrParcela, vNrParcelamento, vPrJurosBNDES, vVlFinanBNDES : Real;
  vDtBasePagamento : TDate;
begin
  vCdEmpresa := itemXmlF('CD_EMPRESA', pParams);
  vCdFornecedor := itemXmlF('CD_FORNECEDOR', pParams);
  vNrDuplicata := itemXmlF('NR_DUPLICATA', pParams);
  vNrParcela := itemXmlF('NR_PARCELA', pParams);
  vDtBasePagamento := itemXml('DT_BASEPGTO', pParams);
  vNrParcelamento := itemXmlF('NR_PARCELAMENTO', pParams);
  vPrJurosBNDES := itemXmlF('PR_JUROSBNDES', pParams);
  vVlFinanBNDES := itemXmlF('VL_FINANBNDES', pParams);

  if (vCdEmpresa = 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Empresa não informada!', cDS_METHOD);
    return(-1); exit;
  end;
  if (vCdFornecedor = 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Fornecedor não informada!', cDS_METHOD);
    return(-1); exit;
  end;
  if (vNrDuplicata = 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Duplicata não informada!', cDS_METHOD);
    return(-1); exit;
  end;
  if (vNrParcela = 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Parcela não informada!', cDS_METHOD);
    return(-1); exit;
  end;

  creocc(tFCP_DUPIADIC, -1);
  putitem_e(tFCP_DUPIADIC, 'CD_EMPRESA', vCdEmpresa);
  putitem_e(tFCP_DUPIADIC, 'CD_FORNECEDOR', vCdFornecedor);
  putitem_e(tFCP_DUPIADIC, 'NR_DUPLICATA', vNrDuplicata);
  putitem_e(tFCP_DUPIADIC, 'NR_PARCELA', vNrParcela);
  retrieve_o(tFCP_DUPIADIC);
  if (xStatus = -7) then begin
    retrieve_x(tFCP_DUPIADIC);
  end;
  putitem_e(tFCP_DUPIADIC, 'DT_CADASTRO', itemXml('DT_SISTEMA', PARAM_GLB));
  putitem_e(tFCP_DUPIADIC, 'CD_OPERADOR', itemXmlF('CD_USUARIO', PARAM_GLB));
  putitem_e(tFCP_DUPIADIC, 'DT_BASEPAGTO', vDtBasePagamento);
  putitem_e(tFCP_DUPIADIC, 'NR_PARCELABNDES', vNrParcelamento);
  putitem_e(tFCP_DUPIADIC, 'PR_JUROSBNDES', vPrJurosBNDES);
  putitem_e(tFCP_DUPIADIC, 'VL_FINANBNDES', vVlFinanBNDES);

  voParams := tFCP_DUPIADIC.Salvar();
  if (xStatus < 0) then begin
    Result := voParams;
    return(-1); exit;
  end;
end;

end.
