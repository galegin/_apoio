unit cFCCSVCO002;

interface

(* COMPONENTES 
  ADMSVCO001 / EDISVCO020 / FCCSVCO002 / FCCSVCO017 / GERSVCO031

*)        

uses
  Classes, SysUtils, Math, DB,
  cDataSetUnf;

type
  T_FCCSVCO002 = class(TComponent)
  private
    tF_FCC_AUTOCHEQUE,
    tFCC_AUTOCHEQ,
    tFCC_AUTOCHEQSVC;,
    tFCC_AUTOPAG,
    tFCC_AUTOPAGSVCSALVAR;,
    tFCC_AUTORIZAC,
    tFCC_AUTORIZACSVCSALVAR;,
    tFCC_CTAPES,
    tFCC_CTASALDO,
    tFCC_CTASALDOR,
    tFCC_HISTORICO,
    tFCC_MOV,
    tFCC_SEQCHEQUE,
    tFCC_SEQCHEQUESVCSALVAR;,
    tFCC_TPMANUTUS,
    tFCP_DUPLICATI,
    tFCR_COMISSAO,
    tFCR_FATURAI,
    tFCX_CAIXAM,
    tGER_EMPRESA,
    tGER_TERMINAL,
    tGLB_FCCHISTOR,
    tOBS_MOV,
    tPES_PESSOA : TcDatasetUnf;
    function getParam(pParams : String = '') : String;
    function setEntidade(pParams : String = '') : String;
  protected
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;    
  published
    function Converterstring(pParams : String = '') : String;
    function movimentaConta(pParams : String = '') : String;
    function ValidaCtaFilialMatriz(pParams : String = '') : String;
    function buscaSaldoConta(pParams : String = '') : String;
    function buscaSaldoCtaTp(pParams : String = '') : String;
    function BuscaSaldoAnt(pParams : String = '') : String;
    function ValidaDt(pParams : String = '') : String;
    function conciliaMovimento(pParams : String = '') : String;
    function ProximaSeqCheque(pParams : String = '') : String;
    function AutorizaCheque(pParams : String = '') : String;
    function criaContaPessoa(pParams : String = '') : String;
    function buscaContaPessoa(pParams : String = '') : String;
    function AutorizaDup(pParams : String = '') : String;
    function AutoChqAvulsoDup(pParams : String = '') : String;
    function BuscarBAC(pParams : String = '') : String;
    function BuscarCaixa(pParams : String = '') : String;
    function BuscarCxUsuario(pParams : String = '') : String;
    function BuscarPessoaCta(pParams : String = '') : String;
    function gravaLiquidacaoMov(pParams : String = '') : String;
    function gravaObsMov(pParams : String = '') : String;
    function seqLinhaObs(pParams : String = '') : String;
    function estornaMovimento(pParams : String = '') : String;
    function BuscarMov(pParams : String = '') : String;
    function RegraTpManut(pParams : String = '') : String;
    function AlteraDtAberturaCta(pParams : String = '') : String;
    function buscaContaOperador(pParams : String = '') : String;
    function atualizaHistoricoFcc(pParams : String = '') : String;
    function instancehandle->SetStatus(STS_ERROR, xProcerror, xProcerrorcontext, 'ADICIONAL=Erro gravação histsrico. - atualizaHistoricoFcc() FCCSVCO013')(pParams : String = '') : String;
    function instancehandle->SetStatus(STS_ERROR, xProcerror, xProcerrorcontext, 'ADICIONAL=Erro gravação histórico. - atualizaHistoricoFcc() FCCSVCO013')(pParams : String = '') : String;
    function atualizaHistoricoGlb(pParams : String = '') : String;
    function instancehandle->SetStatus(STS_ERROR, xProcerror, xProcerrorcontext, 'ADICIONAL=Erro gravação histórico. - atualizaHistoricoGlb() FCCSVCO013')(pParams : String = '') : String;
    function alteraMovimento(pParams : String = '') : String;
    function AlteraMovAutocheque(pParams : String = '') : String;
    function BuscaUltimoSaldo(pParams : String = '') : String;
    function gravarObsMovLista(pParams : String = '') : String;
  end;

implementation

uses
  cADMSVCO001,
  cActivate, cStatus, cFuncao, cXml, dModulo;

var
  gCdTpCliente,
  gCdTpCxFilial,
  gCdTpCxMatriz,
  gCdTpCxUsuario,
  gCdTpFornecedor,
  gCdTpManutSocio,
  gCdTpRepresentante,
  gDtMovimento,
  gInCxTerminal,
  gInLogMovCtapes,
  gvCdHistorico_Temp,
  gvDsHistorico_Temp,
  gvDtMovim_Temp,
  gvNrCtapes_Temp : String;

//---------------------------------------------------------------
constructor T_FCCSVCO002.Create(AOwner: TComponent);
//---------------------------------------------------------------
begin
  inherited Create(AOwner);
  setEntidade('');
end;

//--------------------------------
destructor T_FCCSVCO002.Destroy;
//--------------------------------
begin
  inherited Destroy;
end;

//---------------------------------------------------------------
function T_FCCSVCO002.getParam(pParams : String = '') : String;
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
  putitem(xParam, 'CD_COMPONENTE');
  putitem(xParam, 'CD_TPMANUT_CLIENTE');
  putitem(xParam, 'CD_TPMANUT_CXFILIAL');
  putitem(xParam, 'CD_TPMANUT_CXMATRIZ');
  putitem(xParam, 'CD_TPMANUT_CXUSUARIO');
  putitem(xParam, 'CD_TPMANUT_FORNECEDOR');
  putitem(xParam, 'CD_TPMANUT_REPRE');
  putitem(xParam, 'CD_TPMANUT_SOCIO');
  putitem(xParam, 'DS_OBS');
  putitem(xParam, 'DT_MOVIM');
  putitem(xParam, 'IN_LOG_MOV_CTAPES');
  putitem(xParam, 'NR_CTAPES');
  putitem(xParam, 'NR_SEQMOV');
  putitem(xParam, 'NR_TIPO_CONTRA_CAIXA');

  xParam := T_ADMSVCO001.GetParametro(xParam);

  gCdTpCliente := itemXml('CD_TPMANUT_CLIENTE', xParam);
  gCdTpCxFilial := itemXml('CD_TPMANUT_CXFILIAL', xParam);
  gCdTpCxMatriz := itemXml('CD_TPMANUT_CXMATRIZ', xParam);
  gCdTpCxUsuario := itemXml('CD_TPMANUT_CXUSUARIO', xParam);
  gCdTpFornecedor := itemXml('CD_TPMANUT_FORNECEDOR', xParam);
  gCdTpManutSocio := itemXml('CD_TPMANUT_SOCIO', xParam);
  gCdTpRepresentante := itemXml('CD_TPMANUT_REPRE', xParam);
  gInCxTerminal := itemXml('IN_CAIXA_TERMINAL', xParam);
  gInLogMovCtapes := itemXml('IN_LOG_MOV_CTAPES', xParam);
  vCdEmpresa := itemXml('CD_EMPRESA', xParam);
  vNrCtapesContraCaixa := itemXml('NR_CTAPES_CONTRACX', xParam);
  vNrTipContraCaixa := itemXml('NR_TIPO_CONTRA_CAIXA', xParam);

  xParamEmp := '';
  putitem(xParamEmp, 'CD_CTAPES_CXFILIAL');
  putitem(xParamEmp, 'CD_CTAPES_CXMATRIZ');
  putitem(xParamEmp, 'CD_EMPMOV');
  putitem(xParamEmp, 'DT_MOV');
  putitem(xParamEmp, 'DT_MOVIM');
  putitem(xParamEmp, 'IN_CAIXA_TERMINAL');
  putitem(xParamEmp, 'NR_CTAPES');
  putitem(xParamEmp, 'NR_CTAPESFCC');
  putitem(xParamEmp, 'NR_SEQMOV');
  putitem(xParamEmp, 'NR_SEQMOVFCC');
  putitem(xParamEmp, 'TP_LIQUIDACAO_FCC');
  putitem(xParamEmp, 'TP_OPERACAO');
  putitem(xParamEmp, 'TP_ORIGEM');

  xParamEmp := T_ADMSVCO001.GetParamEmpresa(piCdEmpresa, xParamEmp);

  gInCxTerminal := itemXml('IN_CAIXA_TERMINAL', xParamEmp);
  postring := itemXml('DS_string', xParamEmp);
  vContaCxFilial := itemXml('CD_CTAPES_CXFILIAL', xParamEmp);
  vContaCxMatriz := itemXml('CD_CTAPES_CXMATRIZ', xParamEmp);
  vDtSaldo := itemXml('DT_SALDO', xParamEmp);
  vNrCtaPes := itemXml('NR_CTAPES', xParamEmp);
  vTpLiquidacao := itemXml('TP_LIQUIDACAO_FCC', xParamEmp);

end;

//---------------------------------------------------------------
function T_FCCSVCO002.setEntidade(pParams : String = '') : String;
//---------------------------------------------------------------
begin
  tF_FCC_AUTOCHEQUE := TcDatasetUnf.getEntidade('F_FCC_AUTOCHEQUE');
  tFCC_AUTOCHEQ := TcDatasetUnf.getEntidade('FCC_AUTOCHEQ');
  tFCC_AUTOCHEQSVC; := TcDatasetUnf.getEntidade('FCC_AUTOCHEQSVC;');
  tFCC_AUTOPAG := TcDatasetUnf.getEntidade('FCC_AUTOPAG');
  tFCC_AUTOPAGSVCSALVAR; := TcDatasetUnf.getEntidade('FCC_AUTOPAGSVCSALVAR;');
  tFCC_AUTORIZAC := TcDatasetUnf.getEntidade('FCC_AUTORIZAC');
  tFCC_AUTORIZACSVCSALVAR; := TcDatasetUnf.getEntidade('FCC_AUTORIZACSVCSALVAR;');
  tFCC_CTAPES := TcDatasetUnf.getEntidade('FCC_CTAPES');
  tFCC_CTASALDO := TcDatasetUnf.getEntidade('FCC_CTASALDO');
  tFCC_CTASALDOR := TcDatasetUnf.getEntidade('FCC_CTASALDOR');
  tFCC_HISTORICO := TcDatasetUnf.getEntidade('FCC_HISTORICO');
  tFCC_MOV := TcDatasetUnf.getEntidade('FCC_MOV');
  tFCC_SEQCHEQUE := TcDatasetUnf.getEntidade('FCC_SEQCHEQUE');
  tFCC_SEQCHEQUESVCSALVAR; := TcDatasetUnf.getEntidade('FCC_SEQCHEQUESVCSALVAR;');
  tFCC_TPMANUTUS := TcDatasetUnf.getEntidade('FCC_TPMANUTUS');
  tFCP_DUPLICATI := TcDatasetUnf.getEntidade('FCP_DUPLICATI');
  tFCR_COMISSAO := TcDatasetUnf.getEntidade('FCR_COMISSAO');
  tFCR_FATURAI := TcDatasetUnf.getEntidade('FCR_FATURAI');
  tFCX_CAIXAM := TcDatasetUnf.getEntidade('FCX_CAIXAM');
  tGER_EMPRESA := TcDatasetUnf.getEntidade('GER_EMPRESA');
  tGER_TERMINAL := TcDatasetUnf.getEntidade('GER_TERMINAL');
  tGLB_FCCHISTOR := TcDatasetUnf.getEntidade('GLB_FCCHISTOR');
  tOBS_MOV := TcDatasetUnf.getEntidade('OBS_MOV');
  tPES_PESSOA := TcDatasetUnf.getEntidade('PES_PESSOA');
end;

//---------------------------------------------------------------
function T_FCCSVCO002.Converterstring(pParams : String) : String;
//---------------------------------------------------------------
const
  cDS_METHOD = 'ADICONAL=Operação: T_FCCSVCO002.Converterstring()';
var
  (* string pistring :In / string postring :Out *)
  viParams,voParams : String;
begin
    putitemXml(viParams, 'DS_string', pistring);
    putitemXml(viParams, 'IN_MAIUSCULA', True);
    putitemXml(viParams, 'IN_NUMERO', True);
    putitemXml(viParams, 'IN_ESPACO', True);
    putitemXml(viParams, 'IN_ESPECIAL', False);
    putitemXml(viParams, 'IN_MANTERPONTO', False);
    voParams := activateCmp('EDISVCO020', 'limparCampo', viParams);
    postring := itemXml('DS_string', voParams);
    return(0); exit;
end;

//--------------------------------------------------------------
function T_FCCSVCO002.movimentaConta(pParams : String) : String;
//--------------------------------------------------------------
const
  cDS_METHOD = 'ADICONAL=Operação: T_FCCSVCO002.movimentaConta()';
var
  (* string piValores :IN *)
  vDtLiq, vDtMovimento, vDtSistema, vDtAbertura, vDtSaldoAnt, vDtConci : TDate;
  viParams, voParams, vTpOperacao, vDsDoc, vDsAux, piValidaCtaFilialMatriz, poValidaCtaFilialMatriz, vDs, vDsObs, vDsLstObservacao : String;
  vInEstorno, vInAchou, vInData, vInCaixa, vInCalcCtaAuto : Boolean;
  vLanctoContraCaixa : Boolean;
  vNrTipContraCaixa : Real;
  vCdEmpresa, vNrCtaPes, vCdHistorico, vVlLancto, vVlSaldoAnt, vCdEmpMovRel, vCdEmpLiq, vNrSeqLiq, vNrSeqMov, vCdOperador, vVlSaldoConciAnt : Real;
  vCdTerminal, vNrSeqCaixa, vTpDocumento, vNrSeqHistRelSub, vCdOPerConci, vNrCtapesContraCaixa, vNrSeqMovRel, vTpOrigem, vCdEmpChqPres, vCdCliChqPres, vNrChequePres : Real;
begin
  clear_e(tFCC_MOV);
  clear_e(tFCC_CTASALDO);
  clear_e(tFCC_CTASALDOR);

  vCdEmpresa := itemXmlF('CD_EMPRESA', pParams);
  vNrCtaPes := itemXmlF('NR_CTAPES', pParams);
  vCdHistorico := itemXmlF('CD_HISTORICO', pParams);
  vDtMovimento := itemXml('DT_MOVIMENTO', pParams);
  vVlLancto := itemXmlF('VL_LANCTO', pParams);
  vVlLancto := roundto(vVlLancto, 2);
  vInEstorno := itemXmlB('IN_ESTORNO', pParams);
  vCdEmpLiq := itemXmlF('CD_EMPLIQ', pParams);
  vDtLiq := itemXml('DT_LIQ', pParams);
  vNrSeqLiq := itemXmlF('NR_SEQLIQ', pParams);
  vDsDoc := itemXml('DS_DOC', pParams);
  vDsAux := itemXml('DS_AUX', pParams);
  vInCaixa := itemXmlB('IN_CAIXA', pParams);
  vCdTerminal := itemXmlF('CD_TERMINAL', pParams);
  vDtAbertura := itemXml('DT_ABERTURA', pParams);
  vNrSeqCaixa := itemXmlF('NR_SEQCAIXA', pParams);
  vTpDocumento := itemXmlF('TP_DOCUMENTO', pParams);
  vNrSeqHistRelSub := itemXmlF('NR_SEQHISTRELSUB', pParams);
  vDtConci := itemXml('DT_CONCI', pParams);
  vDsLstObservacao := itemXml('LST_OBS', pParams);
  vCdOperador := itemXmlF('CD_USUARIO', PARAM_GLB);
  vDtSistema := itemXml('DT_SISTEMA', PARAM_GLB);
  vCdOperConci := itemXmlF('CD_OPERCONCI', pParams);

  vNrSeqMovRel := itemXmlF('NR_SEQMOVREL', pParams);
  vTpOrigem := itemXmlF('TP_ORIGEM', pParams);

  vCdEmpMovRel := itemXmlF('CD_EMPMOVREL', pParams);

  vCdEmpChqPres := itemXmlF('CD_EMPCHQPRES', pParams);
  vCdCliChqPres := itemXmlF('CD_CLICHQPRES', pParams);
  vNrChequePres := itemXmlF('NR_CHEQUEPRES', pParams);

  vLanctoContraCaixa := itemXmlB('IN_LANCTO_CONTRA_CAIXA', pParams);
  vDsObs := itemXml('DS_OBS', pParams);

  voParams := Converterstring(viParams); (* vDsAux, vDsAux *)
  if (xStatus < 0) then begin
    Result := voParams;
    return(-1); exit;
  end;

  vDsAux := vDsAux[1:60];

  if (vCdEmpresa = 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN001', 'Empresa não informada!', cDS_METHOD);
    return(-1); exit;
  end;

  clear_e(tGER_EMPRESA);
  putitem_e(tGER_EMPRESA, 'CD_EMPRESA', vCdEmpresa);
  retrieve_e(tGER_EMPRESA);
  if (xStatus < 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN01', , cDS_METHOD);
    return(-1); exit;
  end;
  if (vNrCtaPes = 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN001', 'Conta não informada!', cDS_METHOD);
    return(-1); exit;
  end;

  clear_e(tFCC_CTAPES);
  putitem_e(tFCC_CTAPES, 'NR_CTAPES', vNrCtaPes);
  retrieve_e(tFCC_CTAPES);
  if (xStatus < 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN001', 'Conta ' + FloatToStr(vNrCtaPes) + ' não cadastrada!', cDS_METHOD);
    return(-1); exit;
  end;
  if (vCdHistorico = 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN001', 'Histórico não informado!', cDS_METHOD);
    return(-1); exit;
  end;
  if (vInCaixa = True) then begin
    if (vCdTerminal = 0) then begin
      Result := SetStatus(STS_ERROR, 'GEN001', 'Terminal não informado!', cDS_METHOD);
      return(-1); exit;
    end;
    if (vDtAbertura = '') then begin
      Result := SetStatus(STS_ERROR, 'GEN001', 'Dt. de abertura do caixa não informada!', cDS_METHOD);
      return(-1); exit;
    end;
    if (vNrSeqCaixa = 0) then begin
      Result := SetStatus(STS_ERROR, 'GEN001', 'Nr. de sequência de caixa não informado!', cDS_METHOD);
      return(-1); exit;
    end;
  end;

  clear_e(tFCC_HISTORICO);
  putitem_e(tFCC_HISTORICO, 'CD_HISTORICO', vCdHistorico);
  retrieve_e(tFCC_HISTORICO);
  if (xStatus < 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN001', 'Histórico ' + FloatToStr(vCdHistorico) + ' não cadastrado!', cDS_METHOD);
    return(-1); exit;
  end;
  if (item_b('IN_AUTACONCI', tFCC_HISTORICO) = True)  and (vDtConci  = '') then begin
    vDtConci := vDtMovimento;
  end;

  vTpOperacao := item_f('TP_OPERACAO', tFCC_HISTORICO);

  if (vDtMovimento = 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN001', 'Data movimento não informada!', cDS_METHOD);
    return(-1); exit;
  end;
  if (vVlLancto = 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN001', 'Valor não informado!', cDS_METHOD);
    return(-1); exit;
  end;
  if (vCdEmpLiq = 0)  and ((vDtLiq <> '')  or (vNrSeqLiq > 0)) then begin
    Result := SetStatus(STS_ERROR, 'GEN001', 'Empresa liquidação não informada!', cDS_METHOD);
    return(-1); exit;
  end;
  if (vDtLiq = '')  and ((vCdEmpLiq > 0)  or (vNrSeqLiq > 0)) then begin
    Result := SetStatus(STS_ERROR, 'GEN001', 'Data liquidação não informada!', cDS_METHOD);
    return(-1); exit;
  end;
  if (vNrSeqLiq = 0)  and ((vCdEmpLiq > 0)  or (vDtLiq <> '')) then begin
    Result := SetStatus(STS_ERROR, 'GEN001', 'Número sequência liquidação não informada!', cDS_METHOD);
    return(-1); exit;
  end;
  if (vTpDocumento = 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN001', 'Tipo de documento não informado!', cDS_METHOD);
    return(-1); exit;
  end;
  if (vNrSeqHistRelSub = 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN001', 'Sequencia auxiliar de parcelamento não informada!', cDS_METHOD);
    return(-1); exit;
  end;

  getParams(pParams); (*  *)
  if (xStatus < 0) then begin
    Result := voParams;
    return(-1); exit;
  end;

  viParams := '';

  putitemXml(viParams, 'NR_CTAPES', vNrCtaPes);
  putitemXml(viParams, 'DT_LANCTO', vDtMovimento);
  voParams := activateCmp('FCCSVCO002', 'ValidaDt', viParams);
  if (xStatus < 0) then begin
    Result := voParams;
    return(-1); exit;
  end;
  end;

  vVlLancto := gabs(vVlLancto);

  viParams := '';

  putitemXml(viParams, 'NM_ENTIDADE', 'FCC_MOV');
  voParams := activateCmp('GERSVCO031', 'getNumSeq', viParams);
  if (xStatus < 0) then begin
    Result := voParams;
    return(-1); exit;
  end;

  vNrSeqMov := itemXmlF('NR_SEQUENCIA', voParams);

  clear_e(tFCC_MOV);
  putitem_e(tFCC_MOV, 'NR_CTAPES', vNrCtaPes);
  putitem_e(tFCC_MOV, 'DT_MOVIM', vDtMovimento);
  putitem_e(tFCC_MOV, 'NR_SEQMOV', vNrSeqMov);
  putitem_e(tFCC_MOV, 'CD_EMPRESA', vCdEmpresa);
  putitem_e(tFCC_MOV, 'TP_OPERACAO', vTpOperacao);
  putitem_e(tFCC_MOV, 'CD_GRUPOEMPRESA', item_f('CD_GRUPOEMPRESA', tGER_EMPRESA));
  putitem_e(tFCC_MOV, 'CD_HISTORICO', vCdHistorico);
  putitem_e(tFCC_MOV, 'TP_DOCUMENTO', vTpDocumento);
  putitem_e(tFCC_MOV, 'NR_SEQHISTRELSUB', vNrSeqHistRelSub);
  putitem_e(tFCC_MOV, 'VL_LANCTO', vVlLancto);
  putitem_e(tFCC_MOV, 'IN_ESTORNO', vInEstorno);
  putitem_e(tFCC_MOV, 'CD_EMPLIQ', vCdEmpLiq);
  putitem_e(tFCC_MOV, 'DT_LIQ', vDtLiq);
  putitem_e(tFCC_MOV, 'NR_SEQLIQ', vNrSeqLiq);
  putitem_e(tFCC_MOV, 'DS_DOC', vDsDoc[1:15]);
  putitem_e(tFCC_MOV, 'DS_AUX', vDsAux[1:60]);

  if (vInEstorno = True) then begin
    putitem_e(tFCC_MOV, 'CD_OPERESTORNO', itemXmlF('CD_USUARIO', PARAM_GLB));
    putitem_e(tFCC_MOV, 'DT_ESTORNO', Now);
  end;
  if (vDtConci <> '') then begin
    putitem_e(tFCC_MOV, 'CD_OPERCONCI', itemXmlF('CD_USUARIO', PARAM_GLB));
    putitem_e(tFCC_MOV, 'DT_CONCI', vDtConci);
  end else begin
    putitem_e(tFCC_MOV, 'CD_OPERCONCI', '');
    putitem_e(tFCC_MOV, 'DT_CONCI', '');
  end;
  if (vCdOPerConci <> '') then begin
    putitem_e(tFCC_MOV, 'CD_OPERCONCI', vCdOperConci);
  end;

  putitem_e(tFCC_MOV, 'CD_EMPCHQPRES', vCdEmpChqPres);
  putitem_e(tFCC_MOV, 'CD_CLICHQPRES', vCdCliChqPres);
  putitem_e(tFCC_MOV, 'NR_CHEQUEPRES', vNrChequePres);
  putitem_e(tFCC_MOV, 'CD_OPERADOR', vCdOperador);
  putitem_e(tFCC_MOV, 'DT_CADASTRO', Now);

  if (gInLogMovCtapes = True) then begin
    if (xStatus = -10)  or (xStatus = -11) then begin
      Result := SetStatus(STS_ERROR, 'GEN001', , cDS_METHOD);
      return(-1); exit;
    end;
  end;
  if (vInCaixa = True) then begin
    creocc(tFCX_CAIXAM, -1);
    putitem_e(tFCX_CAIXAM, 'CD_EMPRESA', vCdEmpresa);
    putitem_e(tFCX_CAIXAM, 'CD_TERMINAL', vCdTerminal);
    putitem_e(tFCX_CAIXAM, 'DT_ABERTURA', vDtAbertura);
    putitem_e(tFCX_CAIXAM, 'NR_SEQ', vNrSeqCaixa);
    putitem_e(tFCX_CAIXAM, 'CD_OPERADOR', vCdOperador);
    putitem_e(tFCX_CAIXAM, 'DT_CADASTRO', Now);
  end;

  tFCC_MOV.Salvar();
  if (xStatus < 0) then begin
    Result := voParams;
    return(-1); exit;
  end;
  if (vDtConci <> '') then begin
    vInAchou := False;
    vVlSaldoAnt := 0;
    vVlSaldoConciAnt := 0;

    vDtSaldoAnt := '';

    selectdb max(DT_MOVIM) %\
    from 'FCC_CTASALDOSVC' %\
    u_where (putitem_e(tFCC_CTASALDO, 'NR_CTAPES', vNrCtaPes ) and (%\
    item_a('DT_MOVIM', tFCC_CTASALDO) < vDtConci) %\
    to vDtSaldoAnt;
    if (xStatus < 0) then begin
      Result := SetStatus(STS_ERROR, xProcerror, xProcerrorcontext, '');
      return(-1); exit;
    end else begin
      if (vDtSaldoAnt <> '') then begin
        clear_e(tFCC_CTASALDO);
        putitem_e(tFCC_CTASALDO, 'NR_CTAPES', vNrCtaPes);
        putitem_e(tFCC_CTASALDO, 'DT_MOVIM', vDtSaldoAnt);
        retrieve_e(tFCC_CTASALDO);
        if (xStatus >= 0) then begin
          vVlSaldoAnt := item_f('VL_SALDO', tFCC_CTASALDO);
          vVlSaldoConciAnt := item_f('VL_SALDOCONCI', tFCC_CTASALDO);
        end else begin
          Result := SetStatus(STS_ERROR, 'GEN0001', 'Não foi possível obter o saldo do dia ' + vDtSaldoAnt + ' da conta ' + FloatToStr(vNrCtaPes!',) + ' cDS_METHOD);
          return(-1); exit;
        end;
      end;
    end;

    clear_e(tFCC_CTASALDO);

    creocc(tFCC_CTASALDO, -1);
    putitem_e(tFCC_CTASALDO, 'NR_CTAPES', vNrCtaPes);
    putitem_e(tFCC_CTASALDO, 'DT_MOVIM', vDtConci);
    retrieve_o(tFCC_CTASALDO);
    if (xStatus = -7) then begin
      retrieve_x(tFCC_CTASALDO);

      if (item_f('TP_OPERACAO', tFCC_MOV) = 'C') then begin
        putitem_e(tFCC_CTASALDO, 'VL_SALDOCONCI', item_f('VL_SALDOCONCI', tFCC_CTASALDO) + item_f('VL_LANCTO', tFCC_MOV));
      end else begin
        putitem_e(tFCC_CTASALDO, 'VL_SALDOCONCI', item_f('VL_SALDOCONCI', tFCC_CTASALDO) - item_f('VL_LANCTO', tFCC_MOV));
      end;
    end else begin
      if (vTpOperacao = 'C') then begin
        putitem_e(tFCC_CTASALDO, 'VL_SALDOCONCI', vVlSaldoConciAnt + item_f('VL_LANCTO', tFCC_MOV));
      end else begin
        putitem_e(tFCC_CTASALDO, 'VL_SALDOCONCI', vVlSaldoConciAnt  - item_f('VL_LANCTO', tFCC_MOV));
      end;
      putitem_e(tFCC_CTASALDO, 'VL_SALDO', vVlSaldoAnt);
    end;

    putitem_e(tFCC_CTASALDO, 'CD_OPERADOR', vCdOperador);
    putitem_e(tFCC_CTASALDO, 'DT_CADASTRO', Now);

    if (gInLogMovCtapes = True) then begin
      if (xStatus = -10)  or (xStatus = -11) then begin
        Result := SetStatus(STS_ERROR, 'GEN001', , cDS_METHOD);
        return(-1); exit;
      end;
    end;

    tFCC_CTASALDO.Salvar();
    if (xStatus < 0) then begin
      Result := voParams;
      return(-1); exit;
    end;

    clear_e(tFCC_CTASALDO);
    putitem_e(tFCC_CTASALDO, 'NR_CTAPES', vNrCtaPes);
    putitem_e(tFCC_CTASALDO, 'DT_MOVIM', '>' + vDtConci' + ');
    retrieve_e(tFCC_CTASALDO);
    if (xStatus >= 0) then begin
      setocc(tFCC_CTASALDO, 1);
      while (xStatus >= 0) do begin
        if (item_f('TP_OPERACAO', tFCC_MOV) = 'C') then begin
          putitem_e(tFCC_CTASALDO, 'VL_SALDOCONCI', item_f('VL_SALDOCONCI', tFCC_CTASALDO) + item_f('VL_LANCTO', tFCC_MOV));
        end else begin
          putitem_e(tFCC_CTASALDO, 'VL_SALDOCONCI', item_f('VL_SALDOCONCI', tFCC_CTASALDO) - item_f('VL_LANCTO', tFCC_MOV));
        end;
        putitem_e(tFCC_CTASALDO, 'CD_OPERADOR', vCdOperador);
        putitem_e(tFCC_CTASALDO, 'DT_CADASTRO', Now);

        if (gInLogMovCtapes = True) then begin
          if (xStatus = -10)  or (xStatus = -11) then begin
            Result := SetStatus(STS_ERROR, 'GEN001', , cDS_METHOD);
            return(-1); exit;
          end;
        end;

        setocc(tFCC_CTASALDO, curocc(tFCC_CTASALDO) + 1);
      end;

      tFCC_CTASALDO.Salvar();
      if (xStatus < 0) then begin
        Result := voParams;
        return(-1); exit;
      end;
    end;
  end;

  vInAchou := False;
  vVlSaldoAnt := 0;
  vVlSaldoConciAnt := 0;

  vDtSaldoAnt := '';

  selectdb max(DT_MOVIM) %\
  from 'FCC_CTASALDOSVC' %\
  u_where (putitem_e(tFCC_CTASALDO, 'NR_CTAPES', vNrCtaPes ) and (%\
  item_a('DT_MOVIM', tFCC_CTASALDO) < vDtMovimento) %\
  to vDtSaldoAnt;
  if (xStatus < 0) then begin
    Result := SetStatus(STS_ERROR, xProcerror, xProcerrorcontext, '');
    return(-1); exit;
  end else begin
    if (vDtSaldoAnt <> '') then begin
      clear_e(tFCC_CTASALDO);
      putitem_e(tFCC_CTASALDO, 'NR_CTAPES', vNrCtaPes);
      putitem_e(tFCC_CTASALDO, 'DT_MOVIM', vDtSaldoAnt);
      retrieve_e(tFCC_CTASALDO);
      if (xStatus >= 0) then begin
        vVlSaldoAnt := item_f('VL_SALDO', tFCC_CTASALDO);
        vVlSaldoConciAnt := item_f('VL_SALDOCONCI', tFCC_CTASALDO);
        vInAchou := True;
      end else begin
        Result := SetStatus(STS_ERROR, 'GEN0001', 'Não foi possível obter o saldo do dia ' + vDtSaldoAnt + ' da conta ' + FloatToStr(vNrCtaPes!',) + ' cDS_METHOD);
        return(-1); exit;
      end;
    end;
  end;

  clear_e(tFCC_CTASALDO);

  creocc(tFCC_CTASALDO, -1);
  putitem_e(tFCC_CTASALDO, 'NR_CTAPES', vNrCtaPes);
  putitem_e(tFCC_CTASALDO, 'DT_MOVIM', vDtMovimento);
  retrieve_o(tFCC_CTASALDO);
  if (xStatus = -7) then begin
    retrieve_x(tFCC_CTASALDO);
    if (item_f('VL_CREDITOS', tFCC_CTASALDO) = 0 ) and (item_f('VL_DEBITOS', tFCC_CTASALDO) = 0) then begin
      if (vTpOperacao = 'C') then begin
        putitem_e(tFCC_CTASALDO, 'VL_SALDO', vVlSaldoAnt + vVlLancto);
        putitem_e(tFCC_CTASALDO, 'VL_CREDITOS', vVlLancto);
      end else begin
        putitem_e(tFCC_CTASALDO, 'VL_SALDO', vVlSaldoAnt - vVlLancto);
        putitem_e(tFCC_CTASALDO, 'VL_DEBITOS', vVlLancto);
      end;
      if (vInAchou = True) then begin
        putitem_e(tFCC_CTASALDO, 'IN_INICIAL', False);
      end else begin
        putitem_e(tFCC_CTASALDO, 'IN_INICIAL', True);
      end;
    end else begin
      if (vTpOperacao = 'C') then begin
        putitem_e(tFCC_CTASALDO, 'VL_SALDO', item_f('VL_SALDO', tFCC_CTASALDO)    + vVlLancto);
        putitem_e(tFCC_CTASALDO, 'VL_CREDITOS', item_f('VL_CREDITOS', tFCC_CTASALDO) + vVlLancto);
      end else begin
        putitem_e(tFCC_CTASALDO, 'VL_SALDO', item_f('VL_SALDO', tFCC_CTASALDO)    - vVlLancto);
        putitem_e(tFCC_CTASALDO, 'VL_DEBITOS', item_f('VL_DEBITOS', tFCC_CTASALDO)  + vVlLancto);
      end;
    end;
  end else begin
    if (vTpOperacao = 'C') then begin
      putitem_e(tFCC_CTASALDO, 'VL_SALDO', vVlSaldoAnt + vVlLancto);
      putitem_e(tFCC_CTASALDO, 'VL_CREDITOS', vVlLancto);
    end else begin
      putitem_e(tFCC_CTASALDO, 'VL_SALDO', vVlSaldoAnt  - vVlLancto);
      putitem_e(tFCC_CTASALDO, 'VL_DEBITOS', vVlLancto);
    end;
    if (vInAchou = True) then begin
      putitem_e(tFCC_CTASALDO, 'IN_INICIAL', False);
    end else begin
      putitem_e(tFCC_CTASALDO, 'IN_INICIAL', True);
    end;
    putitem_e(tFCC_CTASALDO, 'VL_SALDOCONCI', vVlSaldoConciAnt);
  end;
  if (gInLogMovCtapes = True) then begin
    if (xStatus = -10)  or (xStatus = -11) then begin
      Result := SetStatus(STS_ERROR, 'GEN001', , cDS_METHOD);
      return(-1); exit;
    end;
  end;

  putitem_e(tFCC_CTASALDO, 'CD_OPERADOR', vCdOperador);
  putitem_e(tFCC_CTASALDO, 'DT_CADASTRO', Now);

  tFCC_CTASALDO.Salvar();
  if (xStatus < 0) then begin
    Result := voParams;
    return(-1); exit;
  end;

  clear_e(tFCC_CTASALDO);
  putitem_e(tFCC_CTASALDO, 'NR_CTAPES', vNrCtaPes);
  putitem_e(tFCC_CTASALDO, 'DT_MOVIM', '>' + vDtMovimento' + ');
  retrieve_e(tFCC_CTASALDO);
  if (xStatus >= 0) then begin
    setocc(tFCC_CTASALDO, 1);
    while (xStatus >= 0) do begin
      if (vTpOperacao = 'C') then begin
        putitem_e(tFCC_CTASALDO, 'VL_SALDO', item_f('VL_SALDO', tFCC_CTASALDO)    + vVlLancto);

      end else begin
        putitem_e(tFCC_CTASALDO, 'VL_SALDO', item_f('VL_SALDO', tFCC_CTASALDO)   - vVlLancto);

      end;
      if (gInLogMovCtapes = True) then begin
        if (xStatus = -10)  or (xStatus = -11) then begin
          Result := SetStatus(STS_ERROR, 'GEN001', , cDS_METHOD);
          return(-1); exit;
        end;
      end;

      putitem_e(tFCC_CTASALDO, 'CD_OPERADOR', vCdOperador);
      putitem_e(tFCC_CTASALDO, 'DT_CADASTRO', Now);

      setocc(tFCC_CTASALDO, curocc(tFCC_CTASALDO) + 1);
    end;

    tFCC_CTASALDO.Salvar();
    if (xStatus < 0) then begin
      Result := voParams;
      return(-1); exit;
    end;
  end;

  vInAchou := False;
  vVlSaldoAnt := 0;

  vDtSaldoAnt := '';
  selectdb max(DT_MOVIM) %\
  from 'FCC_CTASALDORSVC' %\
  u_where (putitem_e(tFCC_CTASALDOR, 'NR_CTAPES', vNrCtaPes        ) and (%\
  putitem_e(tFCC_CTASALDOR, 'TP_DOCUMENTO', vTpDocumento     ) and (%\
  putitem_e(tFCC_CTASALDOR, 'NR_SEQHISTRELSUB', vNrSeqHistRelSub ) and (%\
  item_a('DT_MOVIM', tFCC_CTASALDOR) < vDtMovimento) %\
  to vDtSaldoAnt;
  if (xStatus < 0) then begin
    Result := SetStatus(STS_ERROR, xProcerror, xProcerrorcontext, '');
    return(-1); exit;
  end else begin
    if (vDtSaldoAnt = '') then begin
      clear_e(tFCC_CTASALDOR);
      creocc(tFCC_CTASALDOR, -1);
      putitem_e(tFCC_CTASALDOR, 'NR_CTAPES', item_f('NR_CTAPES', tFCC_CTAPES));
      putitem_e(tFCC_CTASALDOR, 'TP_DOCUMENTO', vTpDocumento);
      putitem_e(tFCC_CTASALDOR, 'NR_SEQHISTRELSUB', vNrSeqHistRelSub);
      putitem_e(tFCC_CTASALDOR, 'DT_MOVIM', item_a('DT_ABERTURA', tFCC_CTAPES) - 1);
      putitem_e(tFCC_CTASALDOR, 'IN_INICIAL', True);
      putitem_e(tFCC_CTASALDOR, 'VL_SALDO', 0);
      putitem_e(tFCC_CTASALDOR, 'VL_SALDOCONCI', 0);
      putitem_e(tFCC_CTASALDOR, 'VL_CREDITOS', 0);
      putitem_e(tFCC_CTASALDOR, 'VL_DEBITOS', 0);
      putitem_e(tFCC_CTASALDOR, 'CD_OPERADOR', vCdOperador);
      putitem_e(tFCC_CTASALDOR, 'DT_CADASTRO', Now);

      if (gInLogMovCtapes = True) then begin
        if (xStatus = -10)  or (xStatus = -11) then begin
          Result := SetStatus(STS_ERROR, 'GEN001', , cDS_METHOD);
          return(-1); exit;
        end;
      end;

      tFCC_CTASALDOR.Salvar();
      if (xStatus < 0) then begin
        Result := voParams;
        return(-1); exit;
      end;
    end else begin
      clear_e(tFCC_CTASALDOR);
      putitem_e(tFCC_CTASALDOR, 'NR_CTAPES', vNrCtaPes);
      putitem_e(tFCC_CTASALDOR, 'TP_DOCUMENTO', vTpDocumento);
      putitem_e(tFCC_CTASALDOR, 'NR_SEQHISTRELSUB', vNrSeqHistRelSub);
      putitem_e(tFCC_CTASALDOR, 'DT_MOVIM', vDtSaldoAnt);
      retrieve_e(tFCC_CTASALDOR);
      if (xStatus >= 0) then begin
        vVlSaldoAnt := item_f('VL_SALDO', tFCC_CTASALDOR);
        vInAchou := True;
      end else begin
        Result := SetStatus(STS_ERROR, 'GEN0001', 'Não foi possível obter o saldo do dia ' + vDtSaldoAnt + ' da conta ' + FloatToStr(vNrCtaPes!',) + ' cDS_METHOD);
        return(-1); exit;
      end;
    end;
  end;

  clear_e(tFCC_CTASALDOR);
  creocc(tFCC_CTASALDOR, -1);
  putitem_e(tFCC_CTASALDOR, 'NR_CTAPES', vNrCtaPes);
  putitem_e(tFCC_CTASALDOR, 'TP_DOCUMENTO', vTpDocumento);
  putitem_e(tFCC_CTASALDOR, 'NR_SEQHISTRELSUB', vNrSeqHistRelSub);
  putitem_e(tFCC_CTASALDOR, 'DT_MOVIM', vDtMovimento);
  retrieve_o(tFCC_CTASALDOR);
  if (xStatus = -7) then begin
    retrieve_x(tFCC_CTASALDOR);

    if (vTpOperacao = 'C') then begin
      putitem_e(tFCC_CTASALDOR, 'VL_SALDO', item_f('VL_SALDO', tFCC_CTASALDOR)    + vVlLancto);
      putitem_e(tFCC_CTASALDOR, 'VL_CREDITOS', item_f('VL_CREDITOS', tFCC_CTASALDOR) + vVlLancto);
    end else begin
      putitem_e(tFCC_CTASALDOR, 'VL_SALDO', item_f('VL_SALDO', tFCC_CTASALDOR)    - vVlLancto);
      putitem_e(tFCC_CTASALDOR, 'VL_DEBITOS', item_f('VL_DEBITOS', tFCC_CTASALDOR)  + vVlLancto);
    end;
  end else begin
    if (vTpOperacao = 'C') then begin
      putitem_e(tFCC_CTASALDOR, 'VL_SALDO', vVlSaldoAnt + vVlLancto);
      putitem_e(tFCC_CTASALDOR, 'VL_CREDITOS', vVlLancto);
    end else begin
      putitem_e(tFCC_CTASALDOR, 'VL_SALDO', vVlSaldoAnt  - vVlLancto);
      putitem_e(tFCC_CTASALDOR, 'VL_DEBITOS', vVlLancto);
    end;
    if (vInAchou = True) then begin
      putitem_e(tFCC_CTASALDOR, 'IN_INICIAL', False);
    end else begin
      putitem_e(tFCC_CTASALDOR, 'IN_INICIAL', True);
    end;
  end;
  if (gInLogMovCtapes = True) then begin
    if (xStatus = -10)  or (xStatus = -11) then begin
      Result := SetStatus(STS_ERROR, 'GEN001', , cDS_METHOD);
      return(-1); exit;
    end;
  end;

  putitem_e(tFCC_CTASALDOR, 'VL_SALDOCONCI', 0);
  putitem_e(tFCC_CTASALDOR, 'CD_OPERADOR', vCdOperador);
  putitem_e(tFCC_CTASALDOR, 'DT_CADASTRO', Now);

  tFCC_CTASALDOR.Salvar();
  if (xStatus < 0) then begin
    Result := voParams;
    return(-1); exit;
  end;

  clear_e(tFCC_CTASALDOR);
  putitem_e(tFCC_CTASALDOR, 'NR_CTAPES', vNrCtaPes);
  putitem_e(tFCC_CTASALDOR, 'TP_DOCUMENTO', vTpDocumento);
  putitem_e(tFCC_CTASALDOR, 'NR_SEQHISTRELSUB', vNrSeqHistRelSub);
  putitem_e(tFCC_CTASALDOR, 'DT_MOVIM', '>' + vDtMovimento' + ');
  retrieve_e(tFCC_CTASALDOR);
  if (xStatus >= 0) then begin
    setocc(tFCC_CTASALDOR, 1);
    while (xStatus >= 0) do begin
      if (item_a('DT_MOVIM', tFCC_CTASALDOR) = '') then begin
      end;
      if (vTpOperacao = 'C') then begin
        putitem_e(tFCC_CTASALDOR, 'VL_SALDO', item_f('VL_SALDO', tFCC_CTASALDOR)    + vVlLancto);

        if (item_f('CD_OPERCONCI', tFCC_MOV) > 0) then begin
          putitem_e(tFCC_CTASALDOR, 'VL_SALDOCONCI', item_f('VL_SALDOCONCI', tFCC_CTASALDOR) + vVlLancto);
        end;
      end else begin
        putitem_e(tFCC_CTASALDOR, 'VL_SALDO', item_f('VL_SALDO', tFCC_CTASALDOR)   - vVlLancto);

        if (item_f('CD_OPERCONCI', tFCC_MOV) > 0) then begin
          putitem_e(tFCC_CTASALDOR, 'VL_SALDOCONCI', item_f('VL_SALDOCONCI', tFCC_CTASALDOR) - vVlLancto);
        end;
      end;
      if (gInLogMovCtapes = True) then begin
          if (xStatus = -10)  or (xStatus = -11) then begin
          Result := SetStatus(STS_ERROR, 'GEN001', , cDS_METHOD);
          return(-1); exit;
        end;
      end;

      putitem_e(tFCC_CTASALDOR, 'CD_OPERADOR', vCdOperador);
      putitem_e(tFCC_CTASALDOR, 'DT_CADASTRO', Now);

      setocc(tFCC_CTASALDOR, curocc(tFCC_CTASALDOR) + 1);
    end;

    tFCC_CTASALDOR.Salvar();
    if (xStatus < 0) then begin
      Result := voParams;
      return(-1); exit;
    end;
  end;
  if (vDsLstObservacao <> '') then begin
    repeat
      getitem(vDs, vDsLstObservacao, 1);

      if (vDs <> '') then begin
        putitemXml(viParams, 'NR_CTAPES', item_f('NR_CTAPES', tFCC_MOV));
        putitemXml(viParams, 'DT_MOVIM', item_a('DT_MOVIM', tFCC_MOV));
        putitemXml(viParams, 'NR_SEQMOV', item_f('NR_SEQMOV', tFCC_MOV));
        putitemXml(viParams, 'CD_COMPONENTE', 'FCCSVCO002');
        putitemXml(viParams, 'DS_OBS', vDs);
        voParams := activateCmp('FCCSVCO002', 'gravaObsMov', viParams);
        if (xStatus < 0) then begin
          Result := voParams;
          return(-1); exit;
        end;
      end;

      delitem(vDsLstObservacao, 1);
    until (vDsLstObservacao = '');
    vDs := '';
  end;
  if (vDsObs <> '') then begin
    viParams := '';
    putitemXml(viParams, 'NR_CTAPES', item_f('NR_CTAPES', tFCC_MOV));
    putitemXml(viParams, 'DT_MOVIM', item_a('DT_MOVIM', tFCC_MOV));
    putitemXml(viParams, 'NR_SEQMOV', item_f('NR_SEQMOV', tFCC_MOV));
    putitemXml(viParams, 'CD_COMPONENTE', 'FCCSVCO002');
    putitemXml(viParams, 'DS_OBS', vDsObs);
    voParams := activateCmp('FCCSVCO002', 'gravaObsMov', viParams);
    if (xStatus < 0) then begin
      Result := voParams;
      return(-1); exit;
    end;
  end;
  if (vLanctoContraCaixa = False ) or (vLanctoContraCaixa = '') then begin
    Result := '';
    putitemXml(Result, 'NR_CTAPES', item_f('NR_CTAPES', tFCC_MOV));
    putitemXml(Result, 'DT_MOVIM', item_a('DT_MOVIM', tFCC_MOV));
    putitemXml(Result, 'NR_SEQMOV', item_f('NR_SEQMOV', tFCC_MOV));

    gvDtMovim_Temp := item_a('DT_MOVIM', tFCC_MOV);
    gvNrCtapes_Temp := item_f('NR_CTAPES', tFCC_MOV);
    gvCdHistorico_Temp := item_f('CD_HISTORICO', tFCC_MOV);
    gvDsHistorico_Temp := item_a('DS_HISTORICO', tFCC_HISTORICO);
  end;
  if (item_b('IN_CONTRACX', tFCC_HISTORICO) = True  and (vLanctoContraCaixa = False ) or (vLanctoContraCaixa = '')) then begin
    xParam := '';
    putitem(xParam,  'NR_TIPO_CONTRA_CAIXA');
    xParam := T_ADMSVCO001.GetParametro(xParam);
    if (xCdErro) then begin
      voParams := SetErroApl(viParams); (* xCtxErro, xCdErro, xCtxErro *)
    end;
    vNrTipContraCaixa := itemXmlF('NR_TIPO_CONTRA_CAIXA', xParam);

    if (vNrTipContraCaixa <> '' ) and (vNrTipContraCaixa <> 0) then begin
      putitemXml(piValidaCtaFilialMatriz, 'NR_TIPOCONTRACAIXA', vNrTipContraCaixa);
      putitemXml(piValidaCtaFilialMatriz, 'CD_EMPCTAPES', item_f('CD_EMPRESA', tFCC_MOV));
      voParams := ValidaCtaFilialMatriz(viParams); (* piValidaCtaFilialMatriz, poValidaCtaFilialMatriz *)
      if (xStatus < 0) then begin
        Result := voParams;
        return(-1); exit;
      end;

      vNrCtapesContraCaixa := itemXmlF('NR_CTAPES_CONTRACX', poValidaCtaFilialMatriz);

      viParams := '';
      putitemXml(viParams, 'DS_OBS', 'LANCTO. CONTRA-CX DE: ' + gvDtMovim_Temp, + ' CTA: ' + gvNrCtapes_Temp, + ' HIST: ' + gvCdHistorico_Temp-' + gvDsHistorico_Temp') + ' + ';
      putitemXml(viParams, 'IN_LANCTO_CONTRA_CAIXA', True);
      putitemXml(viParams, 'NR_CTAPES', vNrCtapesContraCaixa);
      putitemXml(viParams, 'CD_HISTORICO', 980);
      putitemXml(viParams, 'DT_MOVIMENTO', item_a('DT_MOVIM', tFCC_MOV));
      putitemXml(viParams, 'VL_LANCTO', item_f('VL_LANCTO', tFCC_MOV));
      putitemXml(viParams, 'CD_EMPLIQ', item_f('CD_EMPLIQ', tFCC_MOV));
      putitemXml(viParams, 'DT_LIQ', item_a('DT_LIQ', tFCC_MOV));
      putitemXml(viParams, 'NR_SEQLIQ', item_f('NR_SEQLIQ', tFCC_MOV));
      putitemXml(viParams, 'DS_DOC', item_a('DS_DOC', tFCC_MOV));
      putitemXml(viParams, 'DS_AUX', '**VER OBS. MOVTO.**');
      putitemXml(viParams, 'TP_DOCUMENTO', item_f('TP_DOCUMENTO', tFCC_MOV));
      putitemXml(viParams, 'NR_SEQHISTRELSUB', item_f('NR_SEQHISTRELSUB', tFCC_MOV));
      putitemXml(viParams, 'TP_OPERACAO', item_f('TP_OPERACAO', tFCC_MOV));
      putitemXml(viParams, 'CD_EMPRESA', item_f('CD_EMPRESA', tFCC_MOV));
      putitemXml(viParams, 'CD_GRUPOEMPRESA', item_f('CD_GRUPOEMPRESA', tFCC_MOV));
      putitemXml(viParams, 'DT_CONCI', '');
      putitemXml(viParams, 'CD_OPERCONCI', '');
      putitemXml(viParams, 'IN_ESTORNO', False);
      putitemXml(viParams, 'CD_OPERESTORNO', '');
      putitemXml(viParams, 'DT_ESTORNO', '');
      voParams := activateCmp('FCCSVCO002', 'movimentaConta', viParams);
      if (xStatus < 0) then begin
        Result := voParams;
        return(-1); exit;
      end;

      viParams := '';
      putitemXml(viParams, 'DS_OBS', 'LANCTO. CONTRA-CX DE: ' + gvDtMovim_Temp, + ' CTA: ' + gvNrCtapes_Temp, + ' HIST: ' + gvCdHistorico_Temp-' + gvDsHistorico_Temp') + ' + ';
      putitemXml(viParams, 'IN_LANCTO_CONTRA_CAIXA', True);
      putitemXml(viParams, 'NR_CTAPES', vNrCtapesContraCaixa);
      putitemXml(viParams, 'CD_HISTORICO', 981);
      putitemXml(viParams, 'DT_MOVIMENTO', item_a('DT_MOVIM', tFCC_MOV));
      putitemXml(viParams, 'VL_LANCTO', item_f('VL_LANCTO', tFCC_MOV));
      putitemXml(viParams, 'CD_EMPLIQ', item_f('CD_EMPLIQ', tFCC_MOV));
      putitemXml(viParams, 'DT_LIQ', item_a('DT_LIQ', tFCC_MOV));
      putitemXml(viParams, 'NR_SEQLIQ', item_f('NR_SEQLIQ', tFCC_MOV));
      putitemXml(viParams, 'DS_DOC', item_a('DS_DOC', tFCC_MOV));
      putitemXml(viParams, 'DS_AUX', '**VER OBS. MOVTO.**');
      putitemXml(viParams, 'TP_DOCUMENTO', item_f('TP_DOCUMENTO', tFCC_MOV));
      putitemXml(viParams, 'NR_SEQHISTRELSUB', item_f('NR_SEQHISTRELSUB', tFCC_MOV));
      putitemXml(viParams, 'TP_OPERACAO', item_f('TP_OPERACAO', tFCC_MOV));
      putitemXml(viParams, 'CD_EMPRESA', item_f('CD_EMPRESA', tFCC_MOV));
      putitemXml(viParams, 'CD_GRUPOEMPRESA', item_f('CD_GRUPOEMPRESA', tFCC_MOV));
      putitemXml(viParams, 'DT_CONCI', '');
      putitemXml(viParams, 'CD_OPERCONCI', '');
      putitemXml(viParams, 'IN_ESTORNO', False);
      putitemXml(viParams, 'CD_OPERESTORNO', '');
      putitemXml(viParams, 'DT_ESTORNO', '');
      voParams := activateCmp('FCCSVCO002', 'movimentaConta', viParams);
      if (xStatus < 0) then begin
        Result := voParams;
        return(-1); exit;
      end;
    end;
  end;
  if (vNrSeqMovRel > 0) then begin
    viParams := '';

    if (vCdEmpMovRel > 0) then begin
      putitemXml(viParams, 'CD_EMPMOV', vCdEmpMovRel);
    end else begin
      putitemXml(viParams, 'CD_EMPMOV', vCdEmpresa);
    end;

    putitemXml(viParams, 'DT_MOV', item_a('DT_MOVIM', tFCC_MOV));
    putitemXml(viParams, 'NR_SEQMOV', vNrSeqMovRel);
    putitemXml(viParams, 'NR_CTAPESFCC', item_f('NR_CTAPES', tFCC_MOV));
    putitemXml(viParams, 'NR_SEQMOVFCC', item_f('NR_SEQMOV', tFCC_MOV));
    putitemXml(viParams, 'TP_OPERACAO', vTpOperacao);
    if (vTpOrigem = '') then begin
      if (vTpOperacao = 'D') then begin
        putitemXml(viParams, 'TP_ORIGEM', 1);
      end else begin
        putitemXml(viParams, 'TP_ORIGEM', 2);
      end;
    end else begin
      putitemXml(viParams, 'TP_ORIGEM', vTpOrigem);
    end;

    voParams := activateCmp('FCCSVCO017', 'gravaMovRel', viParams);
    if (xStatus < 0) then begin
      Result := SetStatus(STS_ERROR, 'GEN0001', 'Gravação do relacionamento de movimento não efetuado !', cDS_METHOD);
      return(-1); exit;
    end;
  end;

  putitemXml(Result, 'NR_SEQMOV', vNrSeqMov);

  return(0); exit;
end;

//---------------------------------------------------------------------
function T_FCCSVCO002.ValidaCtaFilialMatriz(pParams : String) : String;
//---------------------------------------------------------------------
const
  cDS_METHOD = 'ADICONAL=Operação: T_FCCSVCO002.ValidaCtaFilialMatriz()';
var
  (* string pviParams :IN / string pvoParams :OUT *)
  viParams : String;
  voParams : String;
  vCdEmpresaCtapes : Real;
  pNrTipoTipoContraCaixa : Real;
  vContaCxMatriz : Real;
  vContaCxFilial : Real;
begin
  pNrTipoTipoContraCaixa := itemXmlF('NR_TIPOCONTRACAIXA', pviParams);
  vCdEmpresaCtapes := itemXmlF('CD_EMPCTAPES', pviParams);

  viParams := '';
  putitem(viParams,  'CD_CTAPES_CXFILIAL');
  putitem(viParams,  'CD_CTAPES_CXMATRIZ');
  xParamEmp := T_ADMSVCO001.GetParamEmpresa(piCdEmpresa, xParamEmp);

  vContaCxMatriz := itemXmlF('CD_CTAPES_CXMATRIZ', voParams);
  vContaCxFilial := itemXmlF('CD_CTAPES_CXFILIAL', voParams);

  if (pNrTipoTipoContraCaixa = 1) then begin
    if (vContaCxMatriz  <> '') then begin
      putitemXml(pvoParams, 'NR_CTAPES_CONTRACX', vContaCxMatriz);
    end else begin
      Result := SetStatus(STS_ERROR, 'GEN0001', 'Conta matriz não configurada no parâmetro CD_CTAPES_CXMATRIZ !', cDS_METHOD);
      return(-1); exit;
    end;
  end;
  if (pNrTipoTipoContraCaixa = 2) then begin
    if (vContaCxFilial <> '') then begin
      putitemXml(pvoParams, 'NR_CTAPES_CONTRACX', vContaCxFilial);
    end else begin
      Result := SetStatus(STS_ERROR, 'GEN0001', 'Conta filial não configurada no parâmetro CD_CTAPES_CXFILIAL !', cDS_METHOD);
      return(-1); exit;
    end;
  end;

  return(0); exit;

end;

//---------------------------------------------------------------
function T_FCCSVCO002.buscaSaldoConta(pParams : String) : String;
//---------------------------------------------------------------
const
  cDS_METHOD = 'ADICONAL=Operação: T_FCCSVCO002.buscaSaldoConta()';
var
  (* string piValores :IN *)
  vNrCtaPes, vVlSaldo, vVlSaldoConci : Real;
  vDtSaldo, vDtMovim : TDate;
begin
  vNrCtaPes := itemXmlF('NR_CTAPES', pParams);
  vDtSaldo := itemXml('DT_SALDO', pParams);

  if (vNrCtaPes = 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Conta não informada!', cDS_METHOD);
    return(-1); exit;
  end;
  if (vDtSaldo = '') then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Data saldo não informada!', cDS_METHOD);
    return(-1); exit;
  end;

  vVlSaldo := 0;
  vVlSaldoConci := 0;
  vDtMovim := '';
  selectdb max(DT_MOVIM) %\
  from 'FCC_CTASALDOSVC' %\
  u_where (putitem_e(tFCC_CTASALDO, 'NR_CTAPES', vNrCtaPes ) and (%\
  item_a('DT_MOVIM', tFCC_CTASALDO) <= vDtSaldo) %\
  to vDtMovim;
  if (xStatus < 0) then begin
    Result := SetStatus(STS_ERROR, xProcerror, xProcerrorcontext, '');
    return(-1); exit;
  end;
  if (vDtMovim = '') then begin
    selectdb min(DT_MOVIM) %\
    from 'FCC_CTASALDOSVC' %\
    u_where (putitem_e(tFCC_CTASALDO, 'NR_CTAPES', vNrCtaPes) %\
    to vDtMovim;
    if (xStatus < 0) then begin
      Result := SetStatus(STS_ERROR, xProcerror, xProcerrorcontext, '');
      return(-1); exit;
    end;
  end;
  if (vDtMovim <> '') then begin
    clear_e(tFCC_CTASALDO);
    putitem_e(tFCC_CTASALDO, 'NR_CTAPES', vNrCtaPes);
    putitem_e(tFCC_CTASALDO, 'DT_MOVIM', vDtMovim);
    retrieve_e(tFCC_CTASALDO);
    if (xStatus >= 0) then begin
      vVlSaldo := item_f('VL_SALDO', tFCC_CTASALDO);
      vVlSaldoConci := item_f('VL_SALDOCONCI', tFCC_CTASALDO);
    end;
  end;

  Result := '';
  putitemXml(Result, 'VL_SALDO', vVlSaldo);
  putitemXml(Result, 'VL_SALDOCONCI', vVlSaldoConci);
  putitemXml(Result, 'DT_SALDO', vDtMovim);

  return(0); exit;
end;

//---------------------------------------------------------------
function T_FCCSVCO002.buscaSaldoCtaTp(pParams : String) : String;
//---------------------------------------------------------------
const
  cDS_METHOD = 'ADICONAL=Operação: T_FCCSVCO002.buscaSaldoCtaTp()';
var
  (* string piValores :IN *)
  vVlSaldo, vVlSaldoConci, vTpDocumento, vNrSeqHistRelSub : Real;
  vNrCtaPes, vDsconta, vDscta : String;
  vDtSaldo, vDtMovim : TDate;
begin
  clear_e(tFCC_CTASALDOR);
  vNrCtaPes := itemXmlF('NR_CTAPES', pParams);
  vTpDocumento := itemXmlF('TP_DOCUMENTO', pParams);
  vNrSeqHistRelSub := itemXmlF('NR_SEQHISTRELSUB', pParams);
  vDtSaldo := itemXml('DT_SALDO', pParams);
  if (vNrCtaPes = '') then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Conta não informada!', cDS_METHOD);
    return(-1); exit;
  end;
  if (vTpDocumento = 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', ' Tipo documento da conta não informado!', cDS_METHOD);
    return(-1); exit;
  end;
  if (vNrSeqHistRelSub = 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', ' Número de sequência da conta não informado!', cDS_METHOD);
    return(-1); exit;
  end;
  if (vDtSaldo = '') then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Data saldo não informada!', cDS_METHOD);
    return(-1); exit;
  end;
  vVlSaldo := 0;
  vVlSaldoConci := 0;
  vDtMovim := '';

  selectdb max(DT_MOVIM) %\
      from 'FCC_CTASALDORSVC' %\
    u_where    (putitem_e(tFCC_CTASALDOR, 'NR_CTAPES', vNrCtaPes        ) and (%\
          putitem_e(tFCC_CTASALDOR, 'TP_DOCUMENTO', vTpDocumento     ) and (%\
        putitem_e(tFCC_CTASALDOR, 'NR_SEQHISTRELSUB', vNrSeqHistRelSub ) and (%\
            item_a('DT_MOVIM', tFCC_CTASALDOR) <= vDtSaldo)          %\
        to vDtMovim;
  if (xStatus < 0) then begin
    Result := SetStatus(STS_ERROR, xProcerror, xProcerrorcontext, '');
    return(-1); exit;
  end;
  if (vDtMovim = '') then begin
    selectdb min(DT_MOVIM) %\
      from 'FCC_CTASALDORSVC' %\
    u_where     (putitem_e(tFCC_CTASALDOR, 'NR_CTAPES', vNrCtaPes)       ) and (%\
          (putitem_e(tFCC_CTASALDOR, 'TP_DOCUMENTO', vTpDocumento)    ) and (%\
        (putitem_e(tFCC_CTASALDOR, 'NR_SEQHISTRELSUB', vNrSeqHistRelSub)  %\
        to vDtMovim;
    if (xStatus < 0) then begin
      Result := SetStatus(STS_ERROR, xProcerror, xProcerrorcontext, '');
      return(-1); exit;
    end;
  end;
  if (vDtMovim <> '') then begin
    clear_e(tFCC_CTASALDOR);
    putitem_e(tFCC_CTASALDOR, 'NR_CTAPES', vNrCtaPes);
    putitem_e(tFCC_CTASALDOR, 'TP_DOCUMENTO', vTpDocumento);
    putitem_e(tFCC_CTASALDOR, 'NR_SEQHISTRELSUB', vNrSeqHistRelSub);
    putitem_e(tFCC_CTASALDOR, 'DT_MOVIM', vDtMovim);
    retrieve_e(tFCC_CTASALDOR);
    if (xStatus >= 0) then begin
      vVlSaldo := item_f('VL_SALDO', tFCC_CTASALDOR);
      vVlSaldoConci := item_f('VL_SALDOCONCI', tFCC_CTASALDOR);
    end;
  end;
  Result := '';
  putitemXml(Result, 'VL_SALDO', vVlSaldo);
  putitemXml(Result, 'VL_SALDOCONCI', vVlSaldoConci);
  putitemXml(Result, 'DT_SALDO', vDtMovim);
  return(0); exit;
end;

//-------------------------------------------------------------
function T_FCCSVCO002.BuscaSaldoAnt(pParams : String) : String;
//-------------------------------------------------------------
const
  cDS_METHOD = 'ADICONAL=Operação: T_FCCSVCO002.BuscaSaldoAnt()';
var
  (* string piValores :IN *)
  vNrCtaPes, vVlSaldo, vVlSaldoConci, vVlCreditos, vVlDebitos : Real;
  vDtSaldo, vDtMovim : TDate;
begin
  vNrCtaPes := itemXmlF('NR_CTAPES', pParams);
  vDtSaldo := itemXml('DT_SALDO', pParams);

  if (vNrCtaPes = 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Conta não informada!', cDS_METHOD);
    return(-1); exit;
  end;
  if (vDtSaldo = '') then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Data saldo não informada!', cDS_METHOD);
    return(-1); exit;
  end;
  vVlSaldo := 0;
  vDtMovim := '';
  selectdb max(DT_MOVIM) %\
  from 'FCC_CTASALDOSVC' %\
  u_where (putitem_e(tFCC_CTASALDO, 'NR_CTAPES', vNrCtaPes ) and (%\
            item_a('DT_MOVIM', tFCC_CTASALDO) < vDtSaldo) %\
  to vDtMovim;
  if (xStatus < 0) then begin
    Result := SetStatus(STS_ERROR, xProcerror, xProcerrorcontext, '');
    return(-1); exit;
  end;
  if (vDtMovim <> '') then begin
    clear_e(tFCC_CTASALDO);
    putitem_e(tFCC_CTASALDO, 'NR_CTAPES', vNrCtaPes);
    putitem_e(tFCC_CTASALDO, 'DT_MOVIM', vDtMovim);
    retrieve_e(tFCC_CTASALDO);
    if (xStatus >= 0) then begin
      vVlSaldo := item_f('VL_SALDO', tFCC_CTASALDO);
      vVlSaldoConci := item_f('VL_SALDOCONCI', tFCC_CTASALDO);
      vVlDebitos := item_f('VL_DEBITOS', tFCC_CTASALDO);
      vVlCreditos := item_f('VL_CREDITOS', tFCC_CTASALDO);
    end;
  end;

  Result := '';
  putitemXml(Result, 'VL_SALDO', vVlSaldo);
  putitemXml(Result, 'VL_SALDOCONCI', vVlSaldoConci);
  putitemXml(Result, 'VL_DEBITOS', vVlDebitos);
  putitemXml(Result, 'VL_CREDITOS', vVlCreditos);
  putitemXml(Result, 'DT_SALDO', vDtMovim);

  return(0); exit;
  end;

//--------------------------------------------------------
function T_FCCSVCO002.ValidaDt(pParams : String) : String;
//--------------------------------------------------------
const
  cDS_METHOD = 'ADICONAL=Operação: T_FCCSVCO002.ValidaDt()';
var
  vCtaPes : Real;
  vDtLancto, vDtMovIni : TDate;
  vOK : Boolean;
begin
  vCtaPes := itemXmlF('NR_CTAPES', pParams);
  vDtLancto := itemXml('DT_LANCTO', pParams);
  if (vCtaPes = 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Conta não informada!', cDS_METHOD);
    return(-1); exit;
  end;
  if (vDtLancto = '') then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Data movimento não informada!', cDS_METHOD);
    return(-1); exit;
  end;

  vDtMovIni := '';
  selectdb max(DT_MOVIM) %\
  from 'FCC_CTASALDOSVC' %\
  u_where (putitem_e(tFCC_CTASALDO, 'NR_CTAPES', vCtaPes ) and (%\
  putitem_e(tFCC_CTASALDO, 'IN_INICIAL', True) %\
  to vDtMovIni;
  if (xStatus < 0) then begin
    Result := SetStatus(STS_ERROR, xProcerror, xProcerrorcontext, '');
    return(-1); exit;
  end else if (vDtMovIni = '') then begin
    clear_e(tFCC_CTAPES);
    putitem_e(tFCC_CTAPES, 'NR_CTAPES', vCtaPes);
    retrieve_e(tFCC_CTAPES);
    if (xStatus < 0) then begin
      Result := SetStatus(STS_ERROR, 'GEN0001', 'Conta não localizada!', cDS_METHOD);
      return(-1); exit;
    end else begin
      clear_e(tFCC_CTASALDO);
      creocc(tFCC_CTASALDO, -1);
      putitem_e(tFCC_CTASALDO, 'NR_CTAPES', item_f('NR_CTAPES', tFCC_CTAPES));
      putitem_e(tFCC_CTASALDO, 'DT_MOVIM', item_a('DT_ABERTURA', tFCC_CTAPES) - 1);
      putitem_e(tFCC_CTASALDO, 'CD_OPERADOR', '999999');
      putitem_e(tFCC_CTASALDO, 'IN_INICIAL', True);
      putitem_e(tFCC_CTASALDO, 'VL_SALDO', 0);
      putitem_e(tFCC_CTASALDO, 'VL_SALDOCONCI', 0);
      putitem_e(tFCC_CTASALDO, 'VL_CREDITOS', 0);
      putitem_e(tFCC_CTASALDO, 'VL_DEBITOS', 0);
      putitem_e(tFCC_CTASALDO, 'DT_CADASTRO', Now);

      tFCC_CTASALDO.Salvar();
      if (xStatus < 0) then begin
        Result := voParams;
        return(-1); exit;
      end;
      vDtMovIni := item_a('DT_MOVIM', tFCC_CTASALDO);
    end;
  end;
  if (vDtMovIni <> '') then begin
    if (vDtMovIni >= vDtLancto) then begin
      vOK := False;
    end else begin

      vOK := True;
    end;
  end else begin

    vOK := False;
  end;

  Result := '';
  putitemXml(Result, 'DT_INICIAL', vDtMovIni);
  putitemXml(Result, 'IN_OK', vOK);

  return(0); exit;
  end;

//-----------------------------------------------------------------
function T_FCCSVCO002.conciliaMovimento(pParams : String) : String;
//-----------------------------------------------------------------
const
  cDS_METHOD = 'ADICONAL=Operação: T_FCCSVCO002.conciliaMovimento()';
var
  (* string piValores :IN *)
  vNrCtaPes, vNrSeqMov, vCdOperador, vCdOperConci : Real;
  vVlSaldoAnt, vVlSaldoConciAnt : Real;
  vDtMovimento, vDtConci, vDtSaldoAnt : TDate;
  vInCancelamento : Boolean;
begin
  vNrCtaPes := itemXmlF('NR_CTAPES', pParams);
  vDtMovimento := itemXml('DT_MOVIMENTO', pParams);
  vNrSeqMov := itemXmlF('NR_SEQMOV', pParams);
  vInCancelamento := itemXmlB('IN_CANCELAMENTO', pParams);
  vCdOperador := itemXmlF('CD_USUARIO', PARAM_GLB);
  vCdOperConci := itemXmlF('CD_USUARIO', PARAM_GLB);
  vDtConci := itemXml('DT_CONCILIA', pParams);

  if (vNrCtaPes = 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN001', 'Conta não informada!', cDS_METHOD);
    return(-1); exit;
  end;
  if (vDtMovimento = 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN001', 'Data movimento não informada!', cDS_METHOD);
    return(-1); exit;
  end;
  if (vNrSeqMov = 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN001', 'Sequência de movimento não informada!', cDS_METHOD);
    return(-1); exit;
  end;
  if (vDtConci = 0)  and (vInCancelamento = False) then begin
    Result := SetStatus(STS_ERROR, 'GEN001', 'Data de conciliação não informada!', cDS_METHOD);
    return(-1); exit;
  end;

  clear_e(tFCC_MOV);
  putitem_e(tFCC_MOV, 'NR_CTAPES', vNrCtaPes);
  putitem_e(tFCC_MOV, 'DT_MOVIM', vDtMovimento);
  putitem_e(tFCC_MOV, 'NR_SEQMOV', vNrSeqMov);
  retrieve_e(tFCC_MOV);
  if (xStatus >= 0) then begin
    if (vInCancelamento = True) then begin
      if (item_f('CD_OPERCONCI', tFCC_MOV) = 0) then begin
        Result := SetStatus(STS_ERROR, 'GEN001', 'Movimento não está conciliado!', cDS_METHOD);
        return(-1); exit;
      end;
    end else begin
      if (item_f('CD_OPERCONCI', tFCC_MOV) > 0) then begin
        Result := SetStatus(STS_ERROR, 'GEN001', 'Movimento já está conciliado!', cDS_METHOD);
        return(-1); exit;
      end;
    end;
  end else begin
    Result := SetStatus(STS_ERROR, 'GEN001', 'Movimento não cadastrado!', cDS_METHOD);
    return(-1); exit;
  end;
  if (vInCancelamento = True) then begin
    putitem_e(tFCC_MOV, 'CD_OPERCONCI', '');
    putitem_e(tFCC_MOV, 'DT_CONCI', '');
  end else begin
    putitem_e(tFCC_MOV, 'CD_OPERCONCI', vCdOperConci);
    putitem_e(tFCC_MOV, 'DT_CONCI', vDtConci);
  end;

  putitem_e(tFCC_MOV, 'CD_OPERADOR', vCdOperador);
  putitem_e(tFCC_MOV, 'DT_CADASTRO', Now);
  tFCC_MOV.Salvar();
  if (xStatus < 0) then begin
    Result := voParams;
    return(-1); exit;
  end;
  if (vDtConci = 0) then begin
    if (item_a('DT_CONCI', tFCC_MOV) <> '') then begin
      vDtConci := item_a('DT_CONCI', tFCC_MOV);
    end else begin
      vDtConci := item_a('DT_MOVIM', tFCC_MOV);
    end;
  end;

  vVlSaldoAnt := 0;
  vVlSaldoConciAnt := 0;

  vDtSaldoAnt := '';

  if (vDtConci > 0) then begin
    selectdb max(DT_MOVIM) %\
    from 'FCC_CTASALDOSVC' %\
    u_where (putitem_e(tFCC_CTASALDO, 'NR_CTAPES', vNrCtaPes ) and (%\
    item_a('DT_MOVIM', tFCC_CTASALDO) < vDtConci) %\
    to vDtSaldoAnt;
    if (xStatus < 0) then begin
      Result := SetStatus(STS_ERROR, xProcerror, xProcerrorcontext, '');
      return(-1); exit;
    end else begin
      if (vDtSaldoAnt <> '') then begin
        clear_e(tFCC_CTASALDO);
        putitem_e(tFCC_CTASALDO, 'NR_CTAPES', vNrCtaPes);
        putitem_e(tFCC_CTASALDO, 'DT_MOVIM', vDtSaldoAnt);
        retrieve_e(tFCC_CTASALDO);
        if (xStatus >= 0) then begin
          vVlSaldoAnt := item_f('VL_SALDO', tFCC_CTASALDO);
          vVlSaldoConciAnt := item_f('VL_SALDOCONCI', tFCC_CTASALDO);
        end else begin
          Result := SetStatus(STS_ERROR, 'GEN001', 'Não foi possível obter o saldo do dia ' + vDtSaldoAnt + ' da conta ' + FloatToStr(vNrCtaPes!',) + ' cDS_METHOD);
          return(-1); exit;
        end;
      end;
    end;

    clear_e(tFCC_CTASALDO);

    creocc(tFCC_CTASALDO, -1);
    putitem_e(tFCC_CTASALDO, 'NR_CTAPES', vNrCtaPes);
    putitem_e(tFCC_CTASALDO, 'DT_MOVIM', vDtConci);
    retrieve_o(tFCC_CTASALDO);
    if (xStatus = -7) then begin
      retrieve_x(tFCC_CTASALDO);

      if (vInCancelamento = True) then begin
        if (item_f('TP_OPERACAO', tFCC_MOV) = 'C') then begin
          putitem_e(tFCC_CTASALDO, 'VL_SALDOCONCI', item_f('VL_SALDOCONCI', tFCC_CTASALDO) - item_f('VL_LANCTO', tFCC_MOV));
        end else begin
          putitem_e(tFCC_CTASALDO, 'VL_SALDOCONCI', item_f('VL_SALDOCONCI', tFCC_CTASALDO) + item_f('VL_LANCTO', tFCC_MOV));
        end;
      end else begin
        if (item_f('TP_OPERACAO', tFCC_MOV) = 'C') then begin
          putitem_e(tFCC_CTASALDO, 'VL_SALDOCONCI', item_f('VL_SALDOCONCI', tFCC_CTASALDO) + item_f('VL_LANCTO', tFCC_MOV));
        end else begin
          putitem_e(tFCC_CTASALDO, 'VL_SALDOCONCI', item_f('VL_SALDOCONCI', tFCC_CTASALDO) - item_f('VL_LANCTO', tFCC_MOV));
        end;
      end;
    end else begin
      if (vInCancelamento = True) then begin
        if (item_f('TP_OPERACAO', tFCC_MOV) = 'C') then begin
          putitem_e(tFCC_CTASALDO, 'VL_SALDOCONCI', vVlSaldoConciAnt - item_f('VL_LANCTO', tFCC_MOV));
        end else begin
          putitem_e(tFCC_CTASALDO, 'VL_SALDOCONCI', vVlSaldoConciAnt + item_f('VL_LANCTO', tFCC_MOV));
        end;
      end else begin
        if (item_f('TP_OPERACAO', tFCC_MOV) = 'C') then begin
          putitem_e(tFCC_CTASALDO, 'VL_SALDOCONCI', vVlSaldoConciAnt + item_f('VL_LANCTO', tFCC_MOV));
        end else begin
          putitem_e(tFCC_CTASALDO, 'VL_SALDOCONCI', vVlSaldoConciAnt - item_f('VL_LANCTO', tFCC_MOV));
        end;
      end;

      putitem_e(tFCC_CTASALDO, 'VL_SALDO', vVlSaldoAnt);
    end;

    putitem_e(tFCC_CTASALDO, 'CD_OPERADOR', vCdOperador);
    putitem_e(tFCC_CTASALDO, 'DT_CADASTRO', Now);

    tFCC_CTASALDO.Salvar();
    if (xStatus < 0) then begin
      Result := voParams;
      return(-1); exit;
    end;

    clear_e(tFCC_CTASALDO);
    putitem_e(tFCC_CTASALDO, 'NR_CTAPES', vNrCtaPes);
    putitem_e(tFCC_CTASALDO, 'DT_MOVIM', '>' + vDtConci' + ');
    retrieve_e(tFCC_CTASALDO);
    if (xStatus >= 0) then begin
      setocc(tFCC_CTASALDO, 1);
      while (xStatus >= 0) do begin
        if (vInCancelamento = True) then begin
          if (item_f('TP_OPERACAO', tFCC_MOV) = 'C') then begin
            putitem_e(tFCC_CTASALDO, 'VL_SALDOCONCI', item_f('VL_SALDOCONCI', tFCC_CTASALDO) - item_f('VL_LANCTO', tFCC_MOV));
          end else begin
            putitem_e(tFCC_CTASALDO, 'VL_SALDOCONCI', item_f('VL_SALDOCONCI', tFCC_CTASALDO) + item_f('VL_LANCTO', tFCC_MOV));
          end;
        end else begin
          if (item_f('TP_OPERACAO', tFCC_MOV) = 'C') then begin
            putitem_e(tFCC_CTASALDO, 'VL_SALDOCONCI', item_f('VL_SALDOCONCI', tFCC_CTASALDO) + item_f('VL_LANCTO', tFCC_MOV));
          end else begin
            putitem_e(tFCC_CTASALDO, 'VL_SALDOCONCI', item_f('VL_SALDOCONCI', tFCC_CTASALDO) - item_f('VL_LANCTO', tFCC_MOV));
          end;
        end;

        putitem_e(tFCC_CTASALDO, 'CD_OPERADOR', vCdOperador);
        putitem_e(tFCC_CTASALDO, 'DT_CADASTRO', Now);

        setocc(tFCC_CTASALDO, curocc(tFCC_CTASALDO) + 1);
      end;

      tFCC_CTASALDO.Salvar();
      if (xStatus < 0) then begin
        Result := voParams;
        return(-1); exit;
      end;
    end;
  end;

  return(0); exit;
end;

//----------------------------------------------------------------
function T_FCCSVCO002.ProximaSeqCheque(pParams : String) : String;
//----------------------------------------------------------------
const
  cDS_METHOD = 'ADICONAL=Operação: T_FCCSVCO002.ProximaSeqCheque()';
var
  (* numeric piNrCtaPes :IN / numeric piNrChequeImp :IN / numeric poNrCheque :OUT *)
  vNrCheque : Real;
begin
  poNrCheque := 0;
  if (piNrCtaPes = '') then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Faltou o nr. da conta!', cDS_METHOD);
    return(-1); exit;
  end;
  clear_e(tFCC_CTAPES);
  putitem_e(tFCC_CTAPES, 'NR_CTAPES', piNrCtaPes);
  retrieve_e(tFCC_CTAPES);
          putitem_e(tFCC_SEQCHEQUE, 'NR_CHEQUE', piNrChequeImp);
        end;
        putitem_e(tFCC_SEQCHEQUE, 'NR_CHEQUE', item_f('NR_CHEQUE', tFCC_SEQCHEQUE) + 1);
      end;
      putitem_e(tFCC_SEQCHEQUE, 'CD_OPERADOR', itemXmlF('CD_USUARIO', PARAM_GLB));
      putitem_e(tFCC_SEQCHEQUE, 'DT_CADASTRO', Now);

      tFCC_SEQCHEQUESVCSALVAR;.Salvar();
      if (xStatus < 0) then begin
        Result := voParams;
        return(-1); exit;
      end;
    end else begin
      Result := SetStatus(STS_ERROR, 'GEN0001', , cDS_METHOD);
      return(-1); exit;
    end;
  end;
end;

//--------------------------------------------------------------
function T_FCCSVCO002.AutorizaCheque(pParams : String) : String;
//--------------------------------------------------------------
const
  cDS_METHOD = 'ADICONAL=Operação: T_FCCSVCO002.AutorizaCheque()';
var
  vNrCtapes, vNrCtaPesC, vCont, vNrOrdem, vVlCheque, vTotChq : Real;
  vTpAutorizacao, vDsNominal, vDsDoc, vDsAux : String;
  vDtCheque : TDate;
begin
  getitem/id vNrCtapes, pParams, 'NR_CTAPES';
  getitem/id vNrCtapesC, pParams, 'NR_CTAPESC';
  getitem/id vTpAutorizacao, pParams, 'TP_AUTORIZACAO';
  getitem/id vDsDoc, pParams, 'DS_DOC';
  getitem/id vDsAux, pParams, 'DS_AUX';
  if (vNrCtaPes = '') then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Faltou o nr. da conta!', cDS_METHOD);
    return(-1); exit;
  end;
  clear_e(tFCC_CTAPES);
  putitem_e(tFCC_CTAPES, 'NR_CTAPES', vNrCtaPes);
  retrieve_e(tFCC_CTAPES);
  if (xStatus < 0) then begin
    Result := voParams;
    return(-1); exit;
  end;
      if (xStatus < 0) then begin
        Result := voParams;
        return(-1); exit;
      end;
      putitem_e(tFCC_AUTORIZAC, 'NR_CTAPES', item_f('NR_CTAPES', tFCC_CTAPES));
      putitem_e(tFCC_AUTORIZAC, 'IN_AUTOMATICO', False);
      putitem_e(tFCC_AUTORIZAC, 'TP_EMITIDO', 'N');
      putitem_e(tFCC_AUTORIZAC, 'TP_AUTORIZACAO', vTpAutorizacao);
      putitem_e(tFCC_AUTORIZAC, 'CD_OPERADOR', itemXmlF('CD_USUARIO', PARAM_GLB));
      putitem_e(tFCC_AUTORIZAC, 'DT_CADASTRO', Now);
      tFCC_AUTORIZACSVCSALVAR;.Salvar();
      if (xStatus < 0) then begin
        Result := voParams;
        return(-1); exit;
      end;
        vCont := 1;
        getitem/id vNrOrdem, pParams, 'NR_ORDEM' + vCont' + ';
        getitem/id vDtcheque, pParams, 'DT_CHEQUE' + vCont' + ';
        getitem/id vVlcheque, pParams, 'VL_CHEQUE' + vCont' + ';
        getitem/id vDsNominal, pParams, 'DS_NOMINAL' + vCont' + ';
        while (vNrOrdem <> '') do begin
          creocc(tFCC_AUTOCHEQ, -1);
          putitem_e(tFCC_AUTOCHEQ, 'DT_AUTORIZACAO', item_a('DT_AUTORIZACAO', tFCC_AUTORIZAC));
          putitem_e(tFCC_AUTOCHEQ, 'NR_SEQAUTO', item_f('NR_SEQAUTO', tFCC_AUTORIZAC));
          putitem_e(tFCC_AUTOCHEQ, 'NR_SEQCHEQUE', vNrOrdem);
          putitem_e(tFCC_AUTOCHEQ, 'VL_CHEQUE', vVlCheque);
          putitem_e(tFCC_AUTOCHEQ, 'DT_VENCIMENTO', vDtCheque);
          putitem_e(tFCC_AUTOCHEQ, 'IN_EMITIDO', False);
          putitem_e(tFCC_AUTOCHEQ, 'DT_EMISSAO', '');
          putitem_e(tFCC_AUTOCHEQ, 'CD_OPEREMITIDO', '');
          putitem_e(tFCC_AUTOCHEQ, 'CD_OPERCOPIA', '');
          putitem_e(tFCC_AUTOCHEQ, 'IN_COPIA', False);
          putitem_e(tFCC_AUTOCHEQ, 'NR_CHEQUE', '');

          voParams := Converterstring(viParams); (* vDsNominal, vDsNominal *)
          if (xStatus < 0) then begin
            Result := voParams;
            return(-1); exit;
          end;

          putitem_e(tFCC_AUTOCHEQ, 'DS_NOMINAL', vDsNominal[1:30]);
          putitem_e(tFCC_AUTOCHEQ, 'CD_EMPLIQ', '');
          putitem_e(tFCC_AUTOCHEQ, 'DT_LIQ', '');
          putitem_e(tFCC_AUTOCHEQ, 'NR_SEQLIQ', '');
          putitem_e(tFCC_AUTOCHEQ, 'NR_CTAPES', '');
          putitem_e(tFCC_AUTOCHEQ, 'DT_MOVIM', '');
          putitem_e(tFCC_AUTOCHEQ, 'NR_SEQMOV', '');
          putitem_e(tFCC_AUTOCHEQ, 'CD_OPERADOR', itemXmlF('CD_USUARIO', PARAM_GLB));
          putitem_e(tFCC_AUTOCHEQ, 'DT_CADASTRO', Now);
          vCont := vCont + 1;
          getitem/id vNrOrdem, pParams, 'NR_ORDEM' + vCont' + ';
          getitem/id vDtcheque, pParams, 'DT_CHEQUE' + vCont' + ';
          getitem/id vVlcheque, pParams, 'VL_CHEQUE' + vCont' + ';
          getitem/id vDsNominal, pParams, 'DS_NOMINAL' + vCont' + ';
        end;
        if (vCont > 1) then begin
          vTotChq := vCont - 1;
          tFCC_AUTORIZACSVCSALVAR;.Salvar();
          if (xStatus < 0) then begin
            Result := voParams;
            return(-1); exit;
          end;
            putitemXml(Result, 'DT_AUTORIZACAO', item_a('DT_AUTORIZACAO', tFCC_AUTORIZAC));
            putitemXml(Result, 'NR_SEQAUTO', item_f('NR_SEQAUTO', tFCC_AUTOCHEQ));

            vCont := 0;
            clear_e(tFCC_AUTOCHEQ);
            putitem_e(tFCC_AUTOCHEQ, 'DT_AUTORIZACAO', item_a('DT_AUTORIZACAO', tFCC_AUTORIZAC));
            putitem_e(tFCC_AUTOCHEQ, 'NR_SEQAUTO', item_f('NR_SEQAUTO', tFCC_AUTORIZAC));
            retrieve_e(tFCC_AUTOCHEQ);
            setocc(tFCC_AUTOCHEQ, 1);
            while (xStatus >= 0) do begin
              vCont := vCont + 1;
              putitemXml(Result, 'NR_SEQCHEQUE' + vCont', + ' item_f('NR_SEQCHEQUE', tFCC_AUTOCHEQ));
              setocc(tFCC_AUTOCHEQ, curocc(tFCC_AUTOCHEQ) + 1);
              if (vCont > vTotChq) then begin
                xStatus := -1;
              end;
            end;
            putitemXml(Result, 'NR_SEQCHEQUE', item_f('NR_SEQCHEQUE', tFCC_AUTOCHEQ));
            return(0); exit;
          end;
        end else begin
          Result := SetStatus(STS_ERROR, 'GEN001', 'Não autorizou nenhum cheque!', cDS_METHOD);
          return(-1); exit;
        end;
      end;
    end else begin
      Result := SetStatus(STS_ERROR, 'GEN001', ' Conta inativa! ', cDS_METHOD);
      return(-1); exit;
    end;
  end;
end;

//---------------------------------------------------------------
function T_FCCSVCO002.criaContaPessoa(pParams : String) : String;
//---------------------------------------------------------------
const
  cDS_METHOD = 'ADICONAL=Operação: T_FCCSVCO002.criaContaPessoa()';
var
  vCdEmpresa, vNrCtaPes, vNrCta, vCdMoeda : Real;
  vCdPessoa, vCdOperCaixa : Real;
  viParams, voParams, vInNatureza, vTpConta, vDsTitular : String;
  vDtSistema : TDate;
  vTpManutencao : Real;
begin
  Result := '';

  vCdEmpresa := itemXmlF('CD_EMPRESA', pParams);
  if (vCdEmpresa = 0) then begin
    vCdEmpresa := itemXmlF('CD_EMPRESA', PARAM_GLB);
  end;
  vInNatureza := itemXmlB('IN_NATUREZA', pParams);
  vCdMoeda := itemXmlF('CD_MOEDA', pParams);
  if (vCdMoeda = 0) then begin
    vCdMoeda := itemXmlF('CD_MOEDA', PARAM_GLB);
  end;
  vCdPessoa := itemXmlF('CD_PESSOA', pParams);
  vCdOperCaixa := itemXmlF('CD_OPERCAIXA', pParams);
  vTpConta := itemXmlF('TP_CONTA', pParams);
  vDtSistema := itemXml('DT_SISTEMA', pParams);
  if (vDtSistema = '') then begin
    vDtSistema := itemXml('DT_SISTEMA', PARAM_GLB);
  end;
  vDsTitular := itemXml('DS_TITULAR', pParams);
  vTpManutencao := itemXmlF('TP_MANUTENCAO', pParams);

  clear_e(tGER_EMPRESA);
  putitem_e(tGER_EMPRESA, 'CD_EMPRESA', vCdEmpresa);
  retrieve_e(tGER_EMPRESA);
  if (xStatus < 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Empresa ' + FloatToStr(vCdEmpresa) + ' não cadastrada!', cDS_METHOD);
    return(-1); exit;
  end;
  if (vCdPessoa = 0)  and (vCdOperCaixa = 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Pessoa e operador de caixa não informados!', cDS_METHOD);
    return(-1); exit;
  end;
  if (vInNatureza = '') then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Natureza da conta não informada!', cDS_METHOD);
    return(-1); exit;
  end;
  if (itemXml('IN_LANCTODOFNI', pParams) = True)  and (itemXml('DT_MOVTODOFNI', pParams) = '') then begin
    Result := SetStatus(STS_ERROR, 'GEN001', 'Data de movimento do Dofni não informada!', cDS_METHOD);
    return(-1); exit;
  end;

  getParams(pParams); (*  *)
  if (xStatus < 0) then begin
    Result := voParams;
    return(-1); exit;
  end;

  clear_e(tFCC_CTAPES);
  if (vCdPessoa > 0) then begin
    putitem_e(tFCC_CTAPES, 'CD_PESSOA', vCdPessoa);
    putitem_e(tFCC_CTAPES, 'CD_EMPRESA', vCdEmpresa);
    if (vTpManutencao = 0) then begin
      if (vTpConta = 'F') then begin
        putitem_e(tFCC_CTAPES, 'TP_MANUTENCAO', gCdTpFornecedor);
      end else if (vTpConta = 'R') then begin
        putitem_e(tFCC_CTAPES, 'TP_MANUTENCAO', gCdTpRepresentante);
      end else if (vTpConta = 'C') then begin
        putitem_e(tFCC_CTAPES, 'TP_MANUTENCAO', gCdTpCliente);
      end;
    end else begin
      putitem_e(tFCC_CTAPES, 'TP_MANUTENCAO', vTpManutencao);
    end;

    retrieve_e(tFCC_CTAPES);
    if (xStatus >= 0) then begin
      putitemXml(Result, 'DS_TITULAR', item_a('DS_TITULAR', tFCC_CTAPES));
      putitemXml(Result, 'NR_CTAPES', item_f('NR_CTAPES', tFCC_CTAPES));
      putitemXml(Result, 'IN_ACHOU', True);
      return(0); exit;
    end;
  end else begin
    putitem_e(tFCC_CTAPES, 'CD_OPERCAIXA', vCdOperCaixa);
    putitem_e(tFCC_CTAPES, 'CD_EMPRESA', vCdEmpresa);
    putitem_e(tFCC_CTAPES, 'TP_MANUTENCAO', gCdTpCxUsuario);
    retrieve_e(tFCC_CTAPES);
    if (xStatus >= 0) then begin
      putitemXml(Result, 'DS_TITULAR', item_a('DS_TITULAR', tFCC_CTAPES));
      putitemXml(Result, 'NR_CTAPES', item_f('NR_CTAPES', tFCC_CTAPES));
      putitemXml(Result, 'IN_ACHOU', True);
      return(0); exit;
    end;
  end;

  vNrCtaPes := 0;
  while (vNrCtaPes := 0) do begin
    viParams := '';
    putitemXml(viParams, 'NM_ENTIDADE', 'FCC_CTAPES');
    voParams := activateCmp('GERSVCO031', 'getNumSeq', viParams);
    if (xStatus < 0) then begin
      Result := voParams;
      return(-1); exit;
    end;

    vNrCta := itemXmlF('NR_SEQUENCIA', voParams);

    clear_e(tFCC_CTAPES);
    putitem_e(tFCC_CTAPES, 'NR_CTAPES', vNrCta);
    retrieve_e(tFCC_CTAPES);
    if (xStatus < 0) then begin
      vNrCtaPes := vNrCta;
    end;
  end;

  clear_e(tFCC_CTAPES);
  creocc(tFCC_CTAPES, -1);
  putitem_e(tFCC_CTAPES, 'NR_CTAPES', vNrCtaPes);
  putitem_e(tFCC_CTAPES, 'IN_NATUREZA', vInNatureza);
  putitem_e(tFCC_CTAPES, 'CD_EMPRESA', item_f('CD_EMPRESA', tGER_EMPRESA));
  putitem_e(tFCC_CTAPES, 'CD_GRUPOEMPRESA', item_f('CD_GRUPOEMPRESA', tGER_EMPRESA));
  putitem_e(tFCC_CTAPES, 'CD_MOEDA', vCdMoeda);
  putitem_e(tFCC_CTAPES, 'DT_LIMITEVENC', vDtSistema);

  if (itemXml('IN_LANCTODOFNI', pParams) = True) then begin
    putitem_e(tFCC_CTAPES, 'DT_ABERTURA', itemXml('DT_MOVTODOFNI', pParams));
  end else begin
    putitem_e(tFCC_CTAPES, 'DT_ABERTURA', vDtSistema - 30);
  end;

  putitem_e(tFCC_CTAPES, 'NR_SITUACAO', 0);
  putitem_e(tFCC_CTAPES, 'IN_ATIVO', True);
  putitem_e(tFCC_CTAPES, 'TP_CONTA', 0);
  if (vCdPessoa > 0) then begin
    putitem_e(tFCC_CTAPES, 'CD_PESSOA', vCdPessoa);
    if (vTpManutencao = 0) then begin
      if (vTpConta = 'F') then begin
        putitem_e(tFCC_CTAPES, 'TP_MANUTENCAO', gCdTpFornecedor);
      end else if (vTpConta = 'R') then begin
        putitem_e(tFCC_CTAPES, 'TP_MANUTENCAO', gCdTpRepresentante);
      end else if (vTpConta = 'C') then begin
        putitem_e(tFCC_CTAPES, 'TP_MANUTENCAO', gCdTpCliente);
      end;
    end else begin
      putitem_e(tFCC_CTAPES, 'TP_MANUTENCAO', vTpManutencao);
    end;
    if (vDsTitular = '')  and ((vTpConta = 'F')  or (vTpConta = 'R')  or (vTpConta = 'C')) then begin
      clear_e(tPES_PESSOA);
      putitem_e(tPES_PESSOA, 'CD_PESSOA', vCdPessoa);
      retrieve_e(tPES_PESSOA);
      if (xStatus >= 0) then begin
        vDsTitular := item_a('NM_PESSOA', tPES_PESSOA)[1:20];
      end;
    end;

  end else begin
    putitem_e(tFCC_CTAPES, 'CD_OPERCAIXA', vCdOperCaixa);
    putitem_e(tFCC_CTAPES, 'TP_MANUTENCAO', gCdTpCxUsuario);
  end;

  voParams := Converterstring(viParams); (* vDsTitular, vDsTitular *)
  if (xStatus < 0) then begin
    Result := voParams;
    return(-1); exit;
  end;

  putitem_e(tFCC_CTAPES, 'DS_TITULAR', vDsTitular[1:20]);
  putitem_e(tFCC_CTAPES, 'NR_MODFINC', 0);
  putitem_e(tFCC_CTAPES, 'CD_OPERADOR', itemXmlF('CD_USUARIO', PARAM_GLB));
  putitem_e(tFCC_CTAPES, 'DT_CADASTRO', Now);

  if (item_a('DT_CADASTRO', tFCC_CTAPES)= '') then begin
    putitem_e(tFCC_CTAPES, 'DT_CADASTRO', Date - 1d);
  end;
  tFCC_CTAPES.Salvar();
  if (xStatus < 0) then begin
    Result := voParams;
    return(-1); exit;
  end;
  putitemXml(Result, 'DS_TITULAR', item_a('DS_TITULAR', tFCC_CTAPES));
  putitemXml(Result, 'NR_CTAPES', item_f('NR_CTAPES', tFCC_CTAPES));
  putitemXml(Result, 'IN_ACHOU', False);

  return(0); exit;
end;

//----------------------------------------------------------------
function T_FCCSVCO002.buscaContaPessoa(pParams : String) : String;
//----------------------------------------------------------------
const
  cDS_METHOD = 'ADICONAL=Operação: T_FCCSVCO002.buscaContaPessoa()';
var
  vTpConta : String;
  vCdPessoa, vCdEmpresa : Real;
  vInObrigatorio : Boolean;
begin
  vCdPessoa := itemXmlF('CD_PESSOA', pParams);
  vCdEmpresa := itemXmlF('CD_EMPRESA', pParams);
  if (vCdEmpresa = 0) then begin
    vCdEmpresa := itemXmlF('CD_EMPRESA', PARAM_GLB);
  end;
  vTpConta := itemXmlF('TP_CONTA', pParams);
  vInObrigatorio := itemXmlB('IN_OBRIGATORIO', pParams);

  if (vCdPessoa = 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Pessoa não informada!', cDS_METHOD);
    return(-1); exit;
  end;

  getParams(pParams); (*  *)
  if (xStatus < 0) then begin
    Result := voParams;
    return(-1); exit;
  end;

  clear_e(tFCC_CTAPES);
  putitem_e(tFCC_CTAPES, 'CD_PESSOA', vCdPessoa);
  putitem_e(tFCC_CTAPES, 'CD_EMPRESA', vCdEmpresa);
  if (vTpConta = 'F') then begin
    putitem_e(tFCC_CTAPES, 'TP_MANUTENCAO', gCdTpFornecedor);
  end else if (vTpConta = 'R') then begin
    putitem_e(tFCC_CTAPES, 'TP_MANUTENCAO', gCdTpRepresentante);

  end else if (vTpConta = 'S') then begin
    putitem_e(tFCC_CTAPES, 'TP_MANUTENCAO', gCdTpManutSocio);

  end else begin
    putitem_e(tFCC_CTAPES, 'TP_MANUTENCAO', gCdTpCliente);
  end;
  retrieve_e(tFCC_CTAPES);
  if (xStatus < 0) then begin
    if (vInObrigatorio = False) then begin
      return(0); exit;
    end else begin
      Result := SetStatus(STS_ERROR, 'GEN0001', 'Nenhuma conta corrente cadastada para a pessoa ' + FloatToStr(vCdPessoa) + ' na empresa ' + FloatToStr(vCdEmpresa!',) + ' cDS_METHOD);
      return(-1); exit;
    end;
  end else begin
    setocc(tFCC_CTAPES, -1);
    setocc(tFCC_CTAPES, 1);
    if (totocc(tFCC_CTAPES) > 1) then begin
      Result := SetStatus(STS_ERROR, 'GEN0001', 'Exite mais de uma conta corrente cadastada para a pessoa ' + FloatToStr(vCdPessoa) + ' na empresa ' + FloatToStr(vCdEmpresa!',) + ' cDS_METHOD);
      return(-1); exit;
    end;
  end;

  Result := '';
  putitemXml(Result, 'NR_CTAPES', item_f('NR_CTAPES', tFCC_CTAPES));

  return(0); exit;
end;

//-----------------------------------------------------------
function T_FCCSVCO002.AutorizaDup(pParams : String) : String;
//-----------------------------------------------------------
const
  cDS_METHOD = 'ADICONAL=Operação: T_FCCSVCO002.AutorizaDup()';
var
  vCdEmp, vCdForn, vNrDup, vNrParcela, vVlPagto, vNrCtapes, vVlJuros, %\ : Real;
  vDsDoc, vDsAux : String;
begin
  getitem/id vNrCtapes, pParams, 'NR_CTAPES';
  if (vNrCtaPes = '') then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Faltou o nr. da conta!', cDS_METHOD);
    return(-1); exit;
  end;
  clear_e(tFCC_CTAPES);
  putitem_e(tFCC_CTAPES, 'NR_CTAPES', vNrCtaPes);
  retrieve_e(tFCC_CTAPES);
  if (xStatus < 0) then begin
    Result := voParams;
    return(-1); exit;
  end;

    vCont := 1;
    vPosAuto := 1;
    vSeqPag := 0;
    getitem/id vCdEmp, pParams, 'CD_EMPRESA' + vCont' + ';
    getitem/id vCdForn, pParams, 'CD_FORNECEDOR' + vCont' + ';
    getitem/id vNrCtapesC, pParams, 'NR_CTAPESC' + vCont' + ';
    getitem/id vNrDup, pParams, 'NR_DUPLICATA' + vCont' + ';
    getitem/id vNrParcela, pParams, 'NR_PARCELA' + vCont' + ';
    getitem/id vVlPagto, pParams, 'VL_PAGAMENTO' + vCont' + ';
    getitem/id vVlJuros, pParams, 'VL_JUROS' + vCont' + ';
    getitem/id vVlDesconto, pParams, 'VL_DESCONTO' + vCont' + ';
    getitem/id vDsDoc, pParams, 'DS_DOC' + vCont' + ';
    getitem/id vDsAux, pParams, 'DS_AUX' + vCont' + ';
    while (vCdEmp <> '') do begin
      vVlRateio := 0;

      clear_e(tFCC_AUTOCHEQ);
      putitem_e(tFCC_AUTOCHEQ, 'DT_AUTORIZACAO', itemXml('DT_AUTORIZACAO', pParams));
      putitem_e(tFCC_AUTOCHEQ, 'NR_SEQAUTO', itemXmlF('NR_SEQAUTO', pParams));
      retrieve_e(tFCC_AUTOCHEQ);
      if (xStatus >= 0) then begin
        vVlChq := 0;
        vVlPagto := roundto(vVlPagto, 2);
        vVlRateio := vVlPagto;
        setocc(tFCC_AUTOCHEQ, 1);
        while (vVlRateio > 0) do begin
          if (vVlChq = 0) then begin
            vVlChq := item_f('VL_CHEQUE', tFCC_AUTOCHEQSVC;)
            vVlChq := roundto(vVlChq, 2);
          end;
          creocc(tFCC_AUTOPAG, -1);

          vSeqPag := vSeqPag + 1;

          putitem_e(tFCC_AUTOPAG, 'DT_AUTORIZACAO', itemXml('DT_AUTORIZACAO', pParams));
          putitem_e(tFCC_AUTOPAG, 'NR_SEQAUTO', itemXmlF('NR_SEQAUTO', pParams));
          putitem_e(tFCC_AUTOPAG, 'NR_SEQCHEQUE', item_f('NR_SEQCHEQUE', tFCC_AUTOCHEQ));
          putitem_e(tFCC_AUTOPAG, 'NR_SEQPAG', vSeqPag);
          putitem_e(tFCC_AUTOPAG, 'CD_OPERADOR', itemXmlF('CD_USUARIO', PARAM_GLB));
          putitem_e(tFCC_AUTOPAG, 'DT_CADASTRO', Now);
          putitem_e(tFCC_AUTOPAG, 'NR_CTAPES', vNrCtaPesC);
          putitem_e(tFCC_AUTOPAG, 'CD_EMPRESA', vCdEmp);
          putitem_e(tFCC_AUTOPAG, 'CD_FORNECEDOR', vCdForn);
          putitem_e(tFCC_AUTOPAG, 'NR_DUPLICATA', vNrDup);
          putitem_e(tFCC_AUTOPAG, 'NR_PARCELA', vNrParcela);

          if (vVlChq > vVlRateio) then begin
            putitem_e(tFCC_AUTOPAG, 'VL_PAGAMENTO', vVlRateio);
            vVlChq := vVlChq - vVlRateio;
            vVlRateio := 0;
          end else begin

            putitem_e(tFCC_AUTOPAG, 'VL_PAGAMENTO', vVlChq);
            vVlRateio := vVlRateio - vVlChq;
            vVlChq := 0;
          end;

          vVlJuros := roundto(vVlJuros, 2);
          putitem_e(tFCC_AUTOPAG, 'VL_JUROS', vVlJuros);
          putitem_e(tFCC_AUTOPAG, 'VL_DESCONTO', vVlDesconto);

          voParams := Converterstring(viParams); (* vDsDoc, vDsDoc *)
          if (xStatus < 0) then begin
            Result := voParams;
            return(-1); exit;
          end;

          putitem_e(tFCC_AUTOPAG, 'DS_DOC', vDsDoc[1:15]);

          voParams := Converterstring(viParams); (* vDsAux, vDsAux *)
          if (xStatus < 0) then begin
            Result := voParams;
            return(-1); exit;
          end;

          putitem_e(tFCC_AUTOPAG, 'DS_AUX', vDsAux[1:20]);
          if (vVlChq > 0)  and (vVlRateio <= 0) then begin
            vCont := vCont + 1;
            getitem/id vCdEmp, pParams, 'CD_EMPRESA' + vCont' + ';
            getitem/id vCdForn, pParams, 'CD_FORNECEDOR' + vCont' + ';
            getitem/id vNrCtaPesC, pParams, 'NR_CTAPESC' + vCont' + ';
            getitem/id vNrDup, pParams, 'NR_DUPLICATA' + vCont' + ';
            getitem/id vNrParcela, pParams, 'NR_PARCELA' + vCont' + ';
            getitem/id vVlPagto, pParams, 'VL_PAGAMENTO' + vCont' + ';
            getitem/id vVlJuros, pParams, 'VL_JUROS' + vCont' + ';
            getitem/id vVlDesconto, pParams, 'VL_DESCONTO' + vCont' + ';
            getitem/id vDsDoc, pParams, 'DS_DOC' + vCont' + ';
            getitem/id vDsAux, pParams, 'DS_AUX' + vCont' + ';
            vVlRateio := vVlPagto;
            vVlRateio := roundto(vVlRateio, 2);
            vVlJuros := roundto(vVlJuros, 2);
            if (vCdEmp = '') then begin
              Result := SetStatus(STS_ERROR, 'GEN0001', 'Não localizou o nr. da conta!', cDS_METHOD);
              return(-1); exit;
            end;
          end else begin

            setocc(tFCC_AUTOCHEQ, curocc(tFCC_AUTOCHEQ) + 1);
            if (xStatus < 0) then begin
              vVlRateio := -1;
            end else begin
              vPosAuto := curocc(tFCC_AUTOCHEQSVC);
            end;
          end;
        end;
      end;
      xStatus := 0;
      vCont := vCont + 1;
      getitem/id vCdEmp, pParams, 'CD_EMPRESA' + vCont' + ';
      getitem/id vCdForn, pParams, 'CD_FORNECEDOR' + vCont' + ';
      getitem/id vNrDup, pParams, 'NR_DUPLICATA' + vCont' + ';
      getitem/id vNrParcela, pParams, 'NR_PARCELA' + vCont' + ';
      getitem/id vVlPagto, pParams, 'VL_PAGAMENTO' + vCont' + ';
      getitem/id vVlJuros, pParams, 'VL_JUROS' + vCont' + ';
      getitem/id vVlDesconto, pParams, 'VL_DESCONTO' + vCont' + ';
      getitem/id vDsDoc, pParams, 'DS_DOC' + vCont' + ';
      getitem/id vDsAux, pParams, 'DS_AUX' + vCont' + ';
    end;
    xStatus := 0;
    tFCC_AUTOPAGSVCSALVAR;.Salvar();
    if (xStatus < 0) then begin
      Result := voParams;
      return(-1); exit;
    end;
      return(0); exit;
    end;
  end;
end;

//----------------------------------------------------------------
function T_FCCSVCO002.AutoChqAvulsoDup(pParams : String) : String;
//----------------------------------------------------------------
const
  cDS_METHOD = 'ADICONAL=Operação: T_FCCSVCO002.AutoChqAvulsoDup()';
var
  vCdEmp, vCdForn, vNrDup, vNrParcela, vVlPagto, vNrCtapes, vVlJuros, %\ : Real;
  vDsDoc, vDsAux : String;
begin
  getitem/id vNrCtapes, pParams, 'NR_CTAPES';
  if (vNrCtaPes = '') then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Faltou o nr. da conta!', cDS_METHOD);
    return(-1); exit;
  end;
  clear_e(tFCC_CTAPES);
  putitem_e(tFCC_CTAPES, 'NR_CTAPES', vNrCtaPes);
  retrieve_e(tFCC_CTAPES);
  if (xStatus < 0) then begin
    Result := voParams;
    return(-1); exit;
  end;

    clear_e(tFCC_AUTOCHEQ);
    putitem_e(tFCC_AUTOCHEQ, 'DT_AUTORIZACAO', itemXml('DT_AUTORIZACAO', pParams));
    putitem_e(tFCC_AUTOCHEQ, 'NR_SEQAUTO', itemXmlF('NR_SEQAUTO', pParams));
    retrieve_e(tFCC_AUTOCHEQ);
    setocc(tFCC_AUTOCHEQ, 1);
    vCont := 1;
    getitem/id vCdEmp, pParams, 'CD_EMPRESA' + vCont' + ';
    getitem/id vCdForn, pParams, 'CD_FORNECEDOR' + vCont' + ';
    getitem/id vNrCtapesC, pParams, 'NR_CTAPESC' + vCont' + ';
    getitem/id vNrDup, pParams, 'NR_DUPLICATA' + vCont' + ';
    getitem/id vNrParcela, pParams, 'NR_PARCELA' + vCont' + ';
    getitem/id vVlPagto, pParams, 'VL_PAGAMENTO' + vCont' + ';
    getitem/id vVlJuros, pParams, 'VL_JUROS' + vCont' + ';
    getitem/id vVlDesconto, pParams, 'VL_DESCONTO' + vCont' + ';
    getitem/id vDsDoc, pParams, 'DS_DOC' + vCont' + ';
    getitem/id vDsAux, pParams, 'DS_AUX' + vCont' + ';
    while (vCdEmp <> '') do begin
      creocc(tFCC_AUTOPAG, -1);
      putitem_e(tFCC_AUTOPAG, 'DT_AUTORIZACAO', itemXml('DT_AUTORIZACAO', pParams));
      putitem_e(tFCC_AUTOPAG, 'NR_SEQAUTO', itemXmlF('NR_SEQAUTO', pParams));
      putitem_e(tFCC_AUTOPAG, 'NR_SEQCHEQUE', item_f('NR_SEQCHEQUE', tFCC_AUTOCHEQ));
      putitem_e(tFCC_AUTOPAG, 'NR_SEQPAG', vCont);
      putitem_e(tFCC_AUTOPAG, 'CD_OPERADOR', itemXmlF('CD_USUARIO', PARAM_GLB));
      putitem_e(tFCC_AUTOPAG, 'DT_CADASTRO', Now);
      putitem_e(tFCC_AUTOPAG, 'NR_CTAPES', vNrCtaPesC);
      putitem_e(tFCC_AUTOPAG, 'CD_EMPRESA', vCdEmp);
      putitem_e(tFCC_AUTOPAG, 'CD_FORNECEDOR', vCdForn);
      putitem_e(tFCC_AUTOPAG, 'NR_DUPLICATA', vNrDup);
      putitem_e(tFCC_AUTOPAG, 'NR_PARCELA', vNrParcela);
      putitem_e(tFCC_AUTOPAG, 'VL_PAGAMENTO', vVlPagto);
      putitem_e(tFCC_AUTOPAG, 'VL_JUROS', vVlJuros);
      putitem_e(tFCC_AUTOPAG, 'VL_DESCONTO', vVlDesconto);

      voParams := Converterstring(viParams); (* vDsDoc, vDsDoc *)
      if (xStatus < 0) then begin
        Result := voParams;
        return(-1); exit;
      end;

      putitem_e(tFCC_AUTOPAG, 'DS_DOC', vDsDoc[1:15]);

      voParams := Converterstring(viParams); (* vDsAux, vDsAux *)
      if (xStatus < 0) then begin
        Result := voParams;
        return(-1); exit;
      end;

      putitem_e(tFCC_AUTOPAG, 'DS_AUX', vDsAux[1:20]);

      vCont := vCont + 1;
      getitem/id vCdEmp, pParams, 'CD_EMPRESA' + vCont' + ';
      getitem/id vCdForn, pParams, 'CD_FORNECEDOR' + vCont' + ';
      getitem/id vNrCtaPesC, pParams, 'NR_CTAPESC' + vCont' + ';
      getitem/id vNrDup, pParams, 'NR_DUPLICATA' + vCont' + ';
      getitem/id vNrParcela, pParams, 'NR_PARCELA' + vCont' + ';
      getitem/id vVlPagto, pParams, 'VL_PAGAMENTO' + vCont' + ';
      getitem/id vVlJuros, pParams, 'VL_JUROS' + vCont' + ';
      getitem/id vVlDesconto, pParams, 'VL_DESCONTO' + vCont' + ';
      getitem/id vDsDoc, pParams, 'DS_DOC' + vCont' + ';
      getitem/id vDsAux, pParams, 'DS_AUX' + vCont' + ';
    end;
    xStatus := 0;
    tFCC_AUTOPAGSVCSALVAR;.Salvar();
    if (xStatus < 0) then begin
      Result := voParams;
      return(-1); exit;
    end;
      return(0); exit;
    end;
  end;
end;

//---------------------------------------------------------
function T_FCCSVCO002.BuscarBAC(pParams : String) : String;
//---------------------------------------------------------
const
  cDS_METHOD = 'ADICONAL=Operação: T_FCCSVCO002.BuscarBAC()';
begin
  clear_e(tFCC_CTAPES);
  putitem_e(tFCC_CTAPES, 'NR_BANCO', itemXmlF('NR_BANCO', pParams));
  putitem_e(tFCC_CTAPES, 'NR_AGENCIA', itemXmlF('NR_AGENCIA', pParams));
  putitem_e(tFCC_CTAPES, 'DS_CONTA', itemXml('DS_CONTA', pParams));
  retrieve_e(tFCC_CTAPES);
  if (xStatus >= 0) then begin
    Result := 'NR_CTAPES=' + item_f('NR_CTAPES', tFCC_CTAPES)' + ';
  end else begin
    Result := '';
  end;
  return(0); exit;

end;

//-----------------------------------------------------------
function T_FCCSVCO002.BuscarCaixa(pParams : String) : String;
//-----------------------------------------------------------
const
  cDS_METHOD = 'ADICONAL=Operação: T_FCCSVCO002.BuscarCaixa()';
begin
  clear_e(tFCC_CTAPES);
  putitem_e(tFCC_CTAPES, 'CD_EMPRESA', itemXmlF('CD_EMPRESA', pParams));
  putitem_e(tFCC_CTAPES, 'TP_MANUTENCAO', itemXmlF('TP_MANUTENCAO', pParams));
  retrieve_e(tFCC_CTAPES);
  if (xStatus >= 0) then begin
    Result := 'NR_CTAPES=' + item_f('NR_CTAPES', tFCC_CTAPES)' + ';
  end else begin
    Result := '';
  end;
  return(0); exit;

//---------------------------------------------------------------
function T_FCCSVCO002.BuscarCxUsuario(pParams : String) : String;
//---------------------------------------------------------------
const
  cDS_METHOD = 'ADICONAL=Operação: T_FCCSVCO002.BuscarCxUsuario()';
begin
  clear_e(tFCC_CTAPES);
  putitem_e(tFCC_CTAPES, 'CD_EMPRESA', itemXmlF('CD_EMPRESA', pParams));
  putitem_e(tFCC_CTAPES, 'TP_MANUTENCAO', itemXmlF('TP_MANUTENCAO', pParams));
  putitem_e(tFCC_CTAPES, 'CD_OPERCAIXA', itemXmlF('CD_OPERCAIXA', pParams));
  retrieve_e(tFCC_CTAPES);
  if (xStatus >= 0) then begin
    Result := 'NR_CTAPES=' + item_f('NR_CTAPES', tFCC_CTAPES)' + ';
  end else begin
    Result := '';
  end;
  return(0); exit;

end;

//---------------------------------------------------------------
function T_FCCSVCO002.BuscarPessoaCta(pParams : String) : String;
//---------------------------------------------------------------
const
  cDS_METHOD = 'ADICONAL=Operação: T_FCCSVCO002.BuscarPessoaCta()';
var
  vNrCtaPes : Real;
begin
  clear_e(tFCC_CTAPES);
  putitem_e(tFCC_CTAPES, 'CD_EMPRESA', itemXmlF('CD_EMPRESA', pParams));
  putitem_e(tFCC_CTAPES, 'TP_MANUTENCAO', itemXmlF('TP_MANUTENCAO', pParams));
  putitem_e(tFCC_CTAPES, 'CD_PESSOA', itemXmlF('CD_PESSOA', pParams));
  putitem_e(tFCC_CTAPES, 'NR_BANCO', itemXmlF('NR_BANCO', pParams));
  putitem_e(tFCC_CTAPES, 'NR_AGENCIA', itemXmlF('NR_AGENCIA', pParams));
  putitem_e(tFCC_CTAPES, 'DS_CONTA', itemXml('DS_CONTA', pParams));

  retrieve_e(tFCC_CTAPES);
  if (xStatus >= 0) then begin
    vNrCtaPes := item_f('NR_CTAPES', tFCC_CTAPES);
    Result := 'NR_CTAPES=' + FloatToStr(vNrCtaPes') + ';
  end else begin
    Result := '';
  end;

  return(0); exit;

end;

//------------------------------------------------------------------
function T_FCCSVCO002.gravaLiquidacaoMov(pParams : String) : String;
//------------------------------------------------------------------
const
  cDS_METHOD = 'ADICONAL=Operação: T_FCCSVCO002.gravaLiquidacaoMov()';
var
  vNrCtapes, vNrSeqMov, vCdEmpLiq, vNrSeqLiq : Real;
  vDtMovim, vDtLiq : TDate;
begin
  vNrCtapes := itemXmlF('NR_CTAPES', pParams);
  vDtMovim := itemXml('DT_MOVIM', pParams);
  vNrSeqMov := itemXmlF('NR_SEQMOV', pParams);
  vCdEmpLiq := itemXmlF('CD_EMPLIQ', pParams);
  vDtLiq := itemXml('DT_LIQ', pParams);
  vNrSeqLiq := itemXmlF('NR_SEQLIQ', pParams);

  if (vNrCtapes = 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Número CTA não informado!', cDS_METHOD);
    return(-1); exit;
  end;
  if (vDtMovim = '') then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Data de movimento não informada!', cDS_METHOD);
    return(-1); exit;
  end;
  if (vNrSeqMov = 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Número da sequência de movimento não informada!', cDS_METHOD);
    return(-1); exit;
  end;
  if (vCdEmpLiq = 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Empresa da liquidação não informada!', cDS_METHOD);
    return(-1); exit;
  end;
  if (vDtLiq = '') then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Data da liquidação não informada!', cDS_METHOD);
    return(-1); exit;
  end;
  if (vNrSeqLiq = 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Número da liquidação não informada!', cDS_METHOD);
    return(-1); exit;
  end;

  clear_e(tFCC_MOV);
  putitem_e(tFCC_MOV, 'NR_CTAPES', vNrCtaPes);
  putitem_e(tFCC_MOV, 'DT_MOVIM', vDtMovim);
  putitem_e(tFCC_MOV, 'NR_SEQMOV', vNrSeqMov);
  retrieve_e(tFCC_MOV);
  if (xStatus < 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Movimentação ' + item_a('NR_CTAPES', tFCC_MOV) + ' / ' + item_a('DT_MOVIM', tFCC_MOV) + ' / ' + item_a('NR_SEQMOV', tFCC_MOV) + ' não cadastrada!', cDS_METHOD);
    return(-1); exit;
  end;

  putitem_e(tFCC_MOV, 'CD_EMPLIQ', vCdEmpLiq);
  putitem_e(tFCC_MOV, 'DT_LIQ', vDtLiq);
  putitem_e(tFCC_MOV, 'NR_SEQLIQ', vNrSeqLiq);
  putitem_e(tFCC_MOV, 'CD_OPERADOR', itemXmlF('CD_USUARIO', PARAM_GLB));
  putitem_e(tFCC_MOV, 'DT_CADASTRO', Now);

  tFCC_MOV.Salvar();
  if (xStatus < 0) then begin
    Result := voParams;
    return(-1); exit;
  end;

  return(0); exit;
end;

//-----------------------------------------------------------
function T_FCCSVCO002.gravaObsMov(pParams : String) : String;
//-----------------------------------------------------------
const
  cDS_METHOD = 'ADICONAL=Operação: T_FCCSVCO002.gravaObsMov()';
var
  vNrCtapes, vNrSeqMov, voLinha : Real;
  vCdComponente, vDsObs : String;
  vInManutencao : Boolean;
  vDtMovim : TDate;
begin
  vNrCtapes := itemXmlF('NR_CTAPES', pParams);
  vDtMovim := itemXml('DT_MOVIM', pParams);
  vNrSeqMov := itemXmlF('NR_SEQMOV', pParams);
  vCdComponente := itemXmlF('CD_COMPONENTE', pParams);
  vInManutencao := itemXmlB('IN_MANUTENCAO', pParams);
  vDsObs := itemXml('DS_OBS', pParams);

  if (vNrCtapes = 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Número CTA não informado!', cDS_METHOD);
    return(-1); exit;
  end;
  if (vDtMovim = '') then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Data de movimento não informada!', cDS_METHOD);
    return(-1); exit;
  end;
  if (vNrSeqMov = 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Número da sequência de movimento não informada!', cDS_METHOD);
    return(-1); exit;
  end;
  if (vCdComponente = '') then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Código do componente não informado!', cDS_METHOD);
    return(-1); exit;
  end;
  if (vDsObs = '') then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Descrição da observação não informada!', cDS_METHOD);
    return(-1); exit;
  end;

  voParams := activateCmp('FCCSVCO002', 'seqLinhaObs', viParams);
  if (xStatus < 0) then begin
    Result := voParams;
    return(-1); exit;
  end;
  if (voLinha = 0) then begin
    voLinha := 1;
  end;

  voParams := Converterstring(viParams); (* vDsObs, vDsObs *)
  if (xStatus < 0) then begin
    Result := voParams;
    return(-1); exit;
  end;

  clear_e(tOBS_MOV);
  creocc(tOBS_MOV, -1);
  putitem_e(tOBS_MOV, 'NR_CTAPES', vNrCtapes);
  putitem_e(tOBS_MOV, 'DT_MOVIM', vDtMovim);
  putitem_e(tOBS_MOV, 'NR_SEQMOV', vNrSeqMov);
  putitem_e(tOBS_MOV, 'NR_LINHA', voLinha);
  putitem_e(tOBS_MOV, 'CD_OPERADOR', itemXmlF('CD_USUARIO', PARAM_GLB));
  putitem_e(tOBS_MOV, 'DT_CADASTRO', Now);
  putitem_e(tOBS_MOV, 'CD_COMPONENTE', vCdComponente);
  putitem_e(tOBS_MOV, 'IN_MANUTENCAO', vInManutencao);
  putitem_e(tOBS_MOV, 'DS_OBS', vDsObs[1:80]);
  tFCC_MOV.Salvar();
  if (xStatus < 0) then begin
    Result := voParams;
    return(-1); exit;
  end;

  return(0); exit;
end;

//-----------------------------------------------------------
function T_FCCSVCO002.seqLinhaObs(pParams : String) : String;
//-----------------------------------------------------------
const
  cDS_METHOD = 'ADICONAL=Operação: T_FCCSVCO002.seqLinhaObs()';
begin
  selectdb max(NR_LINHA) %\
  from 'OBS_MOVSVC' %\
  u_where (putitem_e(tOBS_MOV, 'NR_CTAPES', piNrCtapes ) and (%\
  putitem_e(tOBS_MOV, 'DT_MOVIM', piDtMovim ) and (%\
  putitem_e(tOBS_MOV, 'NR_SEQMOV', piNrSeqMov) %\
  to poLinha;
  if (xStatus < 0) then begin
    Result := SetStatus(STS_ERROR, xProcerror, xProcerrorcontext, '');
    return(-1); exit;
  end;

  poLinha := poLinha + 1;

  return(0); exit;
end;

//----------------------------------------------------------------
function T_FCCSVCO002.estornaMovimento(pParams : String) : String;
//----------------------------------------------------------------
const
  cDS_METHOD = 'ADICONAL=Operação: T_FCCSVCO002.estornaMovimento()';
var
  vNrCtaPes, vNrSeqMov, vTpLiquidacao, vNrSeqMovRel, vVlSaldo : Real;
  vDtMovim : TDate;
  viParams, voParams : String;
  vInConci, vIndicaRetorno, vInValidaAutoChq : Boolean;
  vDsObs : String;
begin
  vNrCtaPes := itemXmlF('NR_CTAPES', pParams);
  vDtMovim := itemXml('DT_MOVIM', pParams);
  vNrSeqMov := itemXmlF('NR_SEQMOV', pParams);

  vInValidaAutoChq := itemXmlB('IN_VALIDAAUTOCHQ', pParams);
  vDsObs := itemXml('DS_OBS', pParams);

  if (vNrCtaPes <= 0)  or (vNrCtaPes = '') then begin
    Result := SetStatus(STS_ERROR, 'GEN001', , cDS_METHOD);
    return(-1); exit;
  end;
  if (vDtMovim <= 0)  or (vDtMovim = '') then begin
    Result := SetStatus(STS_ERROR, 'GEN001', 'Data do movimento não informada para estorno de movimento de conta!', cDS_METHOD);
    return(-1); exit;
  end;
  if (vNrSeqMov <= 0)  or (vNrSeqMov = '') then begin
    Result := SetStatus(STS_ERROR, 'GEN001', 'Sequência do movimento não informada para estorno de movimento de conta!', cDS_METHOD);
    return(-1); exit;
  end;

  viParams := '';
  putitem(viParams,  'TP_LIQUIDACAO_FCC');
  xParamEmp := T_ADMSVCO001.GetParamEmpresa(piCdEmpresa, xParamEmp);
  vTpLiquidacao := itemXmlF('TP_LIQUIDACAO_FCC', voParams);

  if (vTpLiquidacao = 1)  and (vInValidaAutoChq = True) then begin
    vIndicaRetorno := False;
    clear_e(tFCC_AUTOCHEQ);
    putitem_e(tFCC_AUTOCHEQ, 'NR_CTAPES', vNrCtaPes);
    putitem_e(tFCC_AUTOCHEQ, 'DT_MOVIM', vDtMovim);
    putitem_e(tFCC_AUTOCHEQ, 'NR_SEQMOV', vNrSeqMov);
    retrieve_e(tFCC_AUTOCHEQ);
    if (xStatus >= 0) then begin
      setocc(tFCC_AUTOCHEQ, 1);

      while (xStatus >= 0) do begin
        clear_e(tFCC_AUTOPAG);
        putitem_e(tFCC_AUTOPAG, 'DT_AUTORIZACAO', item_a('DT_AUTORIZACAO', tFCC_AUTOCHEQ));
        putitem_e(tFCC_AUTOPAG, 'NR_SEQAUTO', item_f('NR_SEQAUTO', tFCC_AUTOCHEQ));
        putitem_e(tFCC_AUTOPAG, 'NR_SEQCHEQUE', item_f('NR_SEQCHEQUE', tFCC_AUTOCHEQ));
        retrieve_e(tFCC_AUTOPAG);
        if (xStatus >= 0) then begin
          setocc(tFCC_AUTOPAG, 1);

          while (xStatus >= 0) do begin
            clear_e(tFCP_DUPLICATI);
            putitem_e(tFCP_DUPLICATI, 'CD_EMPRESA', item_f('CD_EMPRESA', tFCC_AUTOPAG));
            putitem_e(tFCP_DUPLICATI, 'CD_FORNECEDOR', item_f('CD_FORNECEDOR', tFCC_AUTOPAG));
            putitem_e(tFCP_DUPLICATI, 'NR_DUPLICATA', item_f('NR_DUPLICATA', tFCC_AUTOPAG));
            putitem_e(tFCP_DUPLICATI, 'NR_PARCELA', item_f('NR_PARCELA', tFCC_AUTOPAG));
            retrieve_e(tFCP_DUPLICATI);
            if (xStatus >=0) then begin
              if (item_f('TP_ESTAGIO', tFCP_DUPLICATI) = 4) then begin
                vIndicaRetorno := True;
              end;
            end else begin
              xStatus := 0;
            end;

            setocc(tFCC_AUTOPAG, curocc(tFCC_AUTOPAG) + 1);
          end;
          xStatus := 0;
        end;

        setocc(tFCC_AUTOCHEQ, curocc(tFCC_AUTOCHEQ) + 1);
      end;
      xStatus := 0;
    end;
    if (vIndicaRetorno = True) then begin
      message/warning 'Movimento possui duplicata com estágio igual a CHEQUE EMITIDO aguardando conciliação, não podendo ser estornado o movimento!';
      return(-1); exit;
    end;
  end;

  clear_e(tFCC_MOV);
  putitem_e(tFCC_MOV, 'NR_CTAPES', vNrCtaPes);
  putitem_e(tFCC_MOV, 'DT_MOVIM', vDtMovim);
  putitem_e(tFCC_MOV, 'NR_SEQMOV', vNrSeqMov);
  retrieve_e(tFCC_MOV);
  if (xStatus < 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN001', 'Movimento para estorno não encontrado!', cDS_METHOD);
    return(-1); exit;
  end;
  if (item_b('IN_ESTORNO', tFCC_MOV)) then begin
    Result := SetStatus(STS_ERROR, 'GEN001', 'Movimento já estornado!', cDS_METHOD);
    return(-1); exit;
  end;

  putitem_e(tFCC_MOV, 'CD_OPERESTORNO', itemXmlF('CD_USUARIO', PARAM_GLB));
  putitem_e(tFCC_MOV, 'DT_ESTORNO', Now);
  putitem_e(tFCC_MOV, 'IN_ESTORNO', True);
  tFCC_MOV.Salvar();
  if (xStatus < 0) then begin
    Result := voParams;
    return(-1); exit;
  end;
  if (itemXml('IN_SOMENTEESTORNO', pParams) = True) then begin
    return(0); exit;
  end;

  viParams := '';
  putitemXml(viParams, 'CD_EMPRESA', item_f('CD_EMPRESA', tFCC_MOV));
  putitemXml(viParams, 'NR_CTAPES', item_f('NR_CTAPES', tFCC_MOV));
  putitemXml(viParams, 'DT_MOVIMENTO', item_a('DT_MOVIM', tFCC_MOV));
  if (item_f('TP_OPERACAO', tFCC_MOV) = 'C') then begin
    putitemXml(viParams, 'CD_HISTORICO', 805);
  end else begin
    putitemXml(viParams, 'CD_HISTORICO', 804);
  end;
  putitemXml(viParams, 'VL_LANCTO', item_f('VL_LANCTO', tFCC_MOV));
  putitemXml(viParams, 'IN_ESTORNO', True);
  putitemXml(viParams, 'DS_DOC', item_f('NR_SEQMOV', tFCC_MOV));
  putitemXml(viParams, 'DS_AUX', item_a('DS_AUX', tFCC_MOV));
  putitemXml(viParams, 'DT_CONCI', item_a('DT_CONCI', tFCC_MOV));
  putitemXml(viParams, 'CD_OPERCONCI', item_f('CD_OPERCONCI', tFCC_MOV));
  putitemXml(viParams, 'TP_DOCUMENTO', item_f('TP_DOCUMENTO', tFCC_MOV));
  putitemXml(viParams, 'NR_SEQHISTRELSUB', item_f('NR_SEQHISTRELSUB', tFCC_MOV));
  newinstance 'FCCSVCO002', 'FCCSVCO002A', 'TRANSACTION=FALSE';
  voParams := activateCmp('FCCSVCO002A', 'movimentaConta', viParams);
  if (xStatus < 0) then begin
    Result := voParams;
    return(-1); exit;
  end;
  deleteinstance 'FCCSVCO002A';

  viParams := '';
  putitemXml(viParams, 'NR_CTAPES', item_f('NR_CTAPES', tFCC_MOV));
  putitemXml(viParams, 'DT_MOVIM', item_a('DT_MOVIM', tFCC_MOV));
  putitemXml(viParams, 'NR_SEQMOV', item_f('NR_SEQMOV', tFCC_MOV));

  if (itemXml('CD_COMPONENTE', pParams) <> '') then begin
    putitemXml(viParams, 'CD_COMPONENTE', itemXmlF('CD_COMPONENTE', pParams));
  end else begin

    putitemXml(viParams, 'CD_COMPONENTE', 'FCCSVCO002');
  end;
  if (vDsObs <> '') then begin
    putitemXml(viParams, 'DS_OBS', vDsObs);
  end else begin
    putitemXml(viParams, 'DS_OBS', 'ESTORNO DA MOVIMENTACAO');
  end;

  newinstance 'FCCSVCO002', 'FCCSVCO002B', 'TRANSACTION=FALSE';
  voParams := activateCmp('FCCSVCO002B', 'gravaObsMov', viParams);
  if (xStatus < 0) then begin
    Result := voParams;
    return(-1); exit;
  end;
  deleteinstance 'FCCSVCO002B';

  return(0); exit;
end;

//---------------------------------------------------------
function T_FCCSVCO002.BuscarMov(pParams : String) : String;
//---------------------------------------------------------
const
  cDS_METHOD = 'ADICONAL=Operação: T_FCCSVCO002.BuscarMov()';
var
  vInEncontrou : Boolean;
begin
  vInEncontrou := False;
  clear_e(tFCC_CTAPES);
  putitem_e(tFCC_CTAPES, 'NR_CTAPES', itemXmlF('NR_CTAPES', pParams));
  retrieve_e(tFCC_CTAPES);
  if (xStatus >= 0) then begin
    clear_e(tFCC_MOV);
    putitem_e(tFCC_MOV, 'NR_CTAPES', item_f('NR_CTAPES', tFCC_CTAPES));
    retrieve_e(tFCC_MOV);
    if (xStatus >= 0) then begin
      vInEncontrou := True;
    end;
  end;
  Result := 'IN_ENCONTROU=' + vInEncontrou' + ';
  return(0); exit;

end;

//------------------------------------------------------------
function T_FCCSVCO002.RegraTpManut(pParams : String) : String;
//------------------------------------------------------------
const
  cDS_METHOD = 'ADICONAL=Operação: T_FCCSVCO002.RegraTpManut()';
var
  vTpManutencao : Real;
  vInDiferente : Boolean;
begin
  vInDiferente := False;
  vTpManutencao := itemXmlF('TP_MANUTENCAO', pParams);
  clear_e(tFCC_CTAPES);
  putitem_e(tFCC_CTAPES, 'NR_CTAPES', itemXmlF('NR_CTAPES', pParams));
  retrieve_e(tFCC_CTAPES);
  if (xStatus >= 0) then begin
    clear_e(tFCC_MOV);
    putitem_e(tFCC_MOV, 'NR_CTAPES', item_f('NR_CTAPES', tFCC_CTAPES));
    retrieve_e(tFCC_MOV);
    if (xStatus >= 0) then begin
      if (vTpManutencao <> item_f('TP_MANUTENCAO', tFCC_CTAPES)) then begin
        vInDiferente := True;
      end;
    end;
  end;
  Result := 'IN_DIFERENTE=' + vInDiferente' + ';
  return(0); exit;

end;

//-------------------------------------------------------------------
function T_FCCSVCO002.AlteraDtAberturaCta(pParams : String) : String;
//-------------------------------------------------------------------
const
  cDS_METHOD = 'ADICONAL=Operação: T_FCCSVCO002.AlteraDtAberturaCta()';
var
  vNrCta : Real;
  vDtAbertura : TDate;
begin
  vNrCta := itemXmlF('NR_CTAPES', pParams);
  vDtAbertura := itemXml('DT_ABERTURA', pParams);
  if (vNrCta = 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN001', 'Número CTA não informado!', cDS_METHOD);
    return(-1); exit;
  end;
  if (vDtAbertura = 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN001', 'Data de Abertura CTA não informada!', cDS_METHOD);
    return(-1); exit;
  end;
  if (vDtAbertura > Date) then begin
    Result := SetStatus(STS_ERROR, 'GEN001', 'Data de Abertura CTA não pode ser superior a data de hoje!', cDS_METHOD);
    return(-1); exit;
  end;

  clear_e(tFCC_CTAPES);
  putitem_e(tFCC_CTAPES, 'NR_CTAPES', vNrCta);
  retrieve_e(tFCC_CTAPES);
  if (xStatus < 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN001', 'Não conseguiu localizar a conta informada!', cDS_METHOD);
    return(-1); exit;
  end;
  if (item_a('DT_ABERTURA', tFCC_CTAPES) <> vDtAbertura) then begin
    clear_e(tFCC_CTASALDO);
    putitem_e(tFCC_CTASALDO, 'NR_CTAPES', item_f('NR_CTAPES', tFCC_CTAPES));
    putitem_e(tFCC_CTASALDO, 'IN_INICIAL', True);
    retrieve_e(tFCC_CTASALDO);
    if (xStatus < 0) then begin
      Result := SetStatus(STS_ERROR, 'GEN001', 'Não conseguiu localizar o lancamento de saldo inicial!', cDS_METHOD);
      return(-1); exit;
    end;

    remocc 'FCC_CTASALDOSVC';
    if (xStatus < 0) then begin
      Result := SetStatus(STS_ERROR, 'GEN001', 'Não conseguiu remover o lancamento de saldo inicial!', cDS_METHOD);
      return(-1); exit;
    end;
    tFCC_CTASALDO.Salvar();
    if (xStatus < 0) then begin
      Result := voParams;
      return(-1); exit;
    end;

    creocc(tFCC_CTASALDO, -1);
    putitem_e(tFCC_CTASALDO, 'NR_CTAPES', item_f('NR_CTAPES', tFCC_CTAPES));
    putitem_e(tFCC_CTASALDO, 'DT_MOVIM', vDtAbertura);
    putitem_e(tFCC_CTASALDO, 'IN_INICIAL', True);
    putitem_e(tFCC_CTASALDO, 'VL_SALDO', 0);
    putitem_e(tFCC_CTASALDO, 'VL_SALDOCONCI', 0);
    putitem_e(tFCC_CTASALDO, 'VL_CREDITOS', 0);
    putitem_e(tFCC_CTASALDO, 'VL_DEBITOS', 0);
    putitem_e(tFCC_CTASALDO, 'CD_OPERADOR', itemXmlF('CD_USUARIO', PARAM_GLB));
    putitem_e(tFCC_CTASALDO, 'DT_CADASTRO', Now);
    tFCC_CTASALDO.Salvar();
    if (xStatus < 0) then begin
      Result := voParams;
      return(-1); exit;
    end;

    putitem_e(tFCC_CTAPES, 'DT_ABERTURA', vDtAbertura);
    putitem_e(tFCC_CTAPES, 'CD_OPERADOR', itemXmlF('CD_USUARIO', PARAM_GLB));
    putitem_e(tFCC_CTAPES, 'DT_CADASTRO', Now);
    tFCC_CTAPES.Salvar();
    if (xStatus < 0) then begin
      Result := voParams;
      return(-1); exit;
    end;
  end else begin
    return(-1); exit;
  end;
  return(0); exit;

end;

//------------------------------------------------------------------
function T_FCCSVCO002.buscaContaOperador(pParams : String) : String;
//------------------------------------------------------------------
const
  cDS_METHOD = 'ADICONAL=Operação: T_FCCSVCO002.buscaContaOperador()';
var
  (* string poLstCtaPesCx:OUT *)
  vCdTerminal, vCdEmpresa, vCdOperador : Real;
  vInValidaCxUsuario : Boolean;
begin
  vCdOperador := itemXmlF('CD_OPERADOR', pParams);
  if (vCdOperador = 0) then begin
    vCdOperador := itemXmlF('CD_USUARIO', PARAM_GLB);
  end;

  vCdTerminal := itemXmlF('CD_TERMINAL', pParams);
  if (vCdTerminal = 0) then begin
    vCdTerminal := itemXmlF('CD_TERMINAL', PARAM_GLB);
  end;

  vCdEmpresa := itemXmlF('CD_EMPRESA', pParams);
  if (vCdEmpresa = 0) then begin
    vCdEmpresa := itemXmlF('CD_EMPRESA', PARAM_GLB);
  end;

  vInValidaCxUsuario := itemXmlB('IN_VALIDA_CXUSUARIO', pParams);
  if (vInValidaCxUsuario = '') then begin
    vInValidaCxUsuario := True;
  end;

  getParams(pParams); (*  *)
  if (xStatus < 0) then begin
    Result := voParams;
    return(-1); exit;
  end;

  clear_e(tFCC_TPMANUTUS);
  putitem_e(tFCC_TPMANUTUS, 'CD_EMPRESA', vCdEmpresa);
  putitem_e(tFCC_TPMANUTUS, 'CD_USULIBERADO', vCdOperador);
  putitem_e(tFCC_TPMANUTUS, 'TP_MANUTENCAO', gCdTpCxMatriz);
  retrieve_e(tFCC_TPMANUTUS);
  if (xStatus >= 0) then begin
    clear_e(tFCC_CTAPES);
    putitem_e(tFCC_CTAPES, 'CD_EMPRESA', vCdEmpresa);
    putitem_e(tFCC_CTAPES, 'TP_MANUTENCAO', gCdTpCxMatriz);
    putitem_e(tFCC_CTAPES, 'IN_ATIVO', True);

    retrieve_e(tFCC_CTAPES);
    if (xStatus >= 0) then begin
      if (item_b('IN_ATIVO', tFCC_CTAPES)) then begin
        putitemXml(poLstCtaPesCx, 'NR_CTAPES_CXMATRIZ', item_f('NR_CTAPES', tFCC_CTAPES));
      end;
    end;
  end;

  clear_e(tFCC_TPMANUTUS);
  putitem_e(tFCC_TPMANUTUS, 'CD_EMPRESA', vCdEmpresa);
  putitem_e(tFCC_TPMANUTUS, 'CD_USULIBERADO', vCdOperador);
  putitem_e(tFCC_TPMANUTUS, 'TP_MANUTENCAO', gCdTpCxFilial);
  retrieve_e(tFCC_TPMANUTUS);
  if (xStatus >= 0) then begin
    clear_e(tFCC_CTAPES);
    putitem_e(tFCC_CTAPES, 'CD_EMPRESA', vCdEmpresa);
    putitem_e(tFCC_CTAPES, 'TP_MANUTENCAO', gCdTpCxFilial);
    putitem_e(tFCC_CTAPES, 'IN_ATIVO', True);

    retrieve_e(tFCC_CTAPES);
    if (xStatus >= 0) then begin
      if (item_b('IN_ATIVO', tFCC_CTAPES)) then begin
        putitemXml(poLstCtaPesCx, 'NR_CTAPES_CXFILIAL', item_f('NR_CTAPES', tFCC_CTAPES));
      end;
    end;
  end;

  clear_e(tFCC_TPMANUTUS);
  putitem_e(tFCC_TPMANUTUS, 'CD_EMPRESA', vCdEmpresa);
  putitem_e(tFCC_TPMANUTUS, 'CD_USULIBERADO', vCdOperador);
  putitem_e(tFCC_TPMANUTUS, 'TP_MANUTENCAO', gCdTpCxUsuario);
  retrieve_e(tFCC_TPMANUTUS);
  if (xStatus >= 0) then begin
    if (gInCxTerminal = 0) then begin
      clear_e(tFCC_CTAPES);
      putitem_e(tFCC_CTAPES, 'CD_EMPRESA', vCdEmpresa);
      putitem_e(tFCC_CTAPES, 'CD_OPERCAIXA', vCdOperador);
      putitem_e(tFCC_CTAPES, 'TP_MANUTENCAO', gCdTpCxUsuario);
      putitem_e(tFCC_CTAPES, 'IN_ATIVO', True);

      retrieve_e(tFCC_CTAPES);
      if (xStatus >= 0) then begin
        if (item_b('IN_ATIVO', tFCC_CTAPES)) then begin
          putitemXml(poLstCtaPesCx, 'NR_CTAPES_CXUSUARIO', item_f('NR_CTAPES', tFCC_CTAPES));
          putitemXml(poLstCtaPesCx, 'NR_CTAPES', item_f('NR_CTAPES', tFCC_CTAPES));
        end else begin
          Result := SetStatus(STS_ERROR, 'GEN001', 'Conta ' + item_a('NR_CTAPES', tFCC_CTAPES) + ' esta inativa!', cDS_METHOD);
          return(-1); exit;
        end;
      end else begin
        if (vInValidaCxUsuario = True) then begin
          Result := SetStatus(STS_ERROR, 'GEN001', 'Nenhuma conta cadastrada para o usuário ' + FloatToStr(vCdOperador) + ' na empresa ' + FloatToStr(vCdEmpresa!',) + ' cDS_METHOD);
          return(-1); exit;
        end;
      end;
    end else begin
      if (vCdTerminal = 0) then begin
        Result := SetStatus(STS_ERROR, 'GEN001', 'Terminal não informado!', cDS_METHOD);
        return(-1); exit;
      end;

      clear_e(tGER_TERMINAL);
      putitem_e(tGER_TERMINAL, 'CD_EMPRESA', vCdEmpresa);
      putitem_e(tGER_TERMINAL, 'CD_TERMINAL', vCdTerminal);
      retrieve_e(tGER_TERMINAL);
      if (xStatus >= 0) then begin
        if (item_f('NR_CTAPES', tGER_TERMINAL) = 0) then begin
          Result := SetStatus(STS_ERROR, 'GEN001', 'Nenhuma conta informada para o terminal ' + FloatToStr(vCdTerminal',) + ' cDS_METHOD);
          return(-1); exit;
        end else begin
          clear_e(tFCC_CTAPES);
          putitem_e(tFCC_CTAPES, 'NR_CTAPES', item_f('NR_CTAPES', tGER_TERMINAL));
          retrieve_e(tFCC_CTAPES);
          if (xStatus >= 0) then begin
            if (item_b('IN_ATIVO', tFCC_CTAPES)) then begin
              putitemXml(poLstCtaPesCx, 'NR_CTAPES_CXUSUARIO', item_f('NR_CTAPES', tFCC_CTAPES));
              putitemXml(poLstCtaPesCx, 'NR_CTAPES', item_f('NR_CTAPES', tFCC_CTAPES));
            end else begin
              Result := SetStatus(STS_ERROR, 'GEN001', 'Conta ' + item_a('NR_CTAPES', tFCC_CTAPES) + ' esta inativa!', cDS_METHOD);
              return(-1); exit;
            end;
          end else begin
            Result := SetStatus(STS_ERROR, 'GEN001', 'Conta ' + item_a('NR_CTAPES', tGER_TERMINAL) + ' cadastrada para o terminal não encontrada!', cDS_METHOD);
            return(-1); exit;
          end;
        end;
      end else begin
        Result := SetStatus(STS_ERROR, 'GEN001', 'Nenhuma conta cadastrada para o terminal ' + FloatToStr(vCdTerminal) + ' na empresa ' + FloatToStr(vCdEmpresa!',) + ' cDS_METHOD);
        return(-1); exit;
      end;
    end;
  end;
  if (poLstCtaPesCx = '') then begin
    Result := SetStatus(STS_ERROR, 'GEN001', 'Não foram localizadas contas tipo manutencao caixa para o terminal ' + FloatToStr(vCdTerminal) + ' na empresa ' + FloatToStr(vCdEmpresa!',) + ' cDS_METHOD);
    return(-1); exit;
  end;

  return(0); exit;
end;

//--------------------------------------------------------------------
function T_FCCSVCO002.atualizaHistoricoFcc(pParams : String) : String;
//--------------------------------------------------------------------
const
  cDS_METHOD = 'ADICONAL=Operação: T_FCCSVCO002.atualizaHistoricoFcc()';
var
  (* string piGlobal :IN *)
  vNrRegistros : Real;
  vInGrava : Boolean;
begin
  vNrRegistros := 0;
  clear_e(tGLB_FCCHISTOR);
  putitem_e(tGLB_FCCHISTOR, 'CD_HISTORICO', '>799');
  retrieve_e(tGLB_FCCHISTOR);
  if (xStatus >= 0) then begin
    setocc(tGLB_FCCHISTOR, 1);
    repeat

      message/hint 'Atualizando histórico: ' + item_f('CD_HISTORICO', tGLB_FCCHISTOR)' + ';

      clear_e(tFCC_HISTORICO);
      putitem_e(tFCC_HISTORICO, 'CD_HISTORICO', item_f('CD_HISTORICO', tGLB_FCCHISTOR));
      retrieve_e(tFCC_HISTORICO);
      if (xStatus < 0) then begin
        clear_e(tFCC_HISTORICO);
        creocc(tFCC_HISTORICO, -1);
        putitem_e(tFCC_HISTORICO, 'CD_HISTORICO', item_f('CD_HISTORICO', tGLB_FCCHISTOR));
        putitem_e(tFCC_HISTORICO, 'TP_OPERACAO', item_f('TP_OPERACAO', tGLB_FCCHISTOR));
        putitem_e(tFCC_HISTORICO, 'DS_HISTORICO', item_a('DS_HISTORICO', tGLB_FCCHISTOR));
        putitem_e(tFCC_HISTORICO, 'IN_PEDESENHA', item_b('IN_PEDESENHA', tGLB_FCCHISTOR));
        putitem_e(tFCC_HISTORICO, 'IN_AUTACONCI', item_b('IN_AUTACONCI', tGLB_FCCHISTOR));
        putitem_e(tFCC_HISTORICO, 'IN_CONTRACX', item_b('IN_CONTRACX', tGLB_FCCHISTOR));
        putitem_e(tFCC_HISTORICO, 'IN_GERACP', item_b('IN_GERACP', tGLB_FCCHISTOR));
        putitem_e(tFCC_HISTORICO, 'CD_OPERADOR', itemXmlF('CD_USUARIO', piGlobal));
        putitem_e(tFCC_HISTORICO, 'DT_CADASTRO', Now);

        tFCC_HISTORICO.Salvar();
        if (xStatus < 0) then begin
Result := SetStatus(STS_ERROR, xProcerror, xProcerrorcontext, cDS_METHOD);
const
  Result := SetStatus(STS_ERROR, xProcerror, xProcerrorcontext, cDS_METHOD);
begin
          return(-1); exit;
        end;
        vNrRegistros := vNrRegistros + 1;
      end else begin
        vInGrava := False;
        if (item_f('TP_OPERACAO', tFCC_HISTORICO) <> item_f('TP_OPERACAO', tGLB_FCCHISTOR)) then begin
          putitem_e(tFCC_HISTORICO, 'TP_OPERACAO', item_f('TP_OPERACAO', tGLB_FCCHISTOR));
          vInGrava := True;
        end;
        if (item_a('DS_HISTORICO', tFCC_HISTORICO) <> item_a('DS_HISTORICO', tGLB_FCCHISTOR)) then begin
          putitem_e(tFCC_HISTORICO, 'DS_HISTORICO', item_a('DS_HISTORICO', tGLB_FCCHISTOR));
          vInGrava := True;
        end;
        if (item_b('IN_PEDESENHA', tFCC_HISTORICO) <> item_b('IN_PEDESENHA', tGLB_FCCHISTOR)) then begin
          putitem_e(tFCC_HISTORICO, 'IN_PEDESENHA', item_b('IN_PEDESENHA', tGLB_FCCHISTOR));
          vInGrava := True;
        end;
        if (item_b('IN_AUTACONCI', tFCC_HISTORICO) <> item_b('IN_AUTACONCI', tGLB_FCCHISTOR)) then begin
          putitem_e(tFCC_HISTORICO, 'IN_AUTACONCI', item_b('IN_AUTACONCI', tGLB_FCCHISTOR));
          vInGrava := True;
        end;
        if (item_b('IN_CONTRACX', tFCC_HISTORICO) <> item_b('IN_CONTRACX', tGLB_FCCHISTOR)) then begin
          putitem_e(tFCC_HISTORICO, 'IN_CONTRACX', item_b('IN_CONTRACX', tGLB_FCCHISTOR));
          vInGrava := True;
        end;
        if (item_b('IN_GERACP', tFCC_HISTORICO) <> item_b('IN_GERACP', tGLB_FCCHISTOR)) then begin
          putitem_e(tFCC_HISTORICO, 'IN_GERACP', item_b('IN_GERACP', tGLB_FCCHISTOR));
          vInGrava := True;
        end;
        if (vInGrava = True) then begin
          putitem_e(tFCC_HISTORICO, 'CD_OPERADOR', itemXmlF('CD_USUARIO', piGlobal));
          putitem_e(tFCC_HISTORICO, 'DT_CADASTRO', Now);

          tFCC_HISTORICO.Salvar();
          if (xStatus < 0) then begin
Result := SetStatus(STS_ERROR, xProcerror, xProcerrorcontext, cDS_METHOD);
const
  Result := SetStatus(STS_ERROR, xProcerror, xProcerrorcontext, cDS_METHOD);
begin
            return(-1); exit;
          end;
          vNrRegistros := vNrRegistros + 1;
        end;
      end;

      setocc(tGLB_FCCHISTOR, curocc(tGLB_FCCHISTOR) + 1);
    until(xStatus < 0);
    xStatus := 0;
  end;
  message/hint '';
  putitemXml(Result, 'NR_REGISTROS', vNrRegistros);

  return(0); exit;
end;

//--------------------------------------------------------------------
function T_FCCSVCO002.atualizaHistoricoGlb(pParams : String) : String;
//--------------------------------------------------------------------
const
  cDS_METHOD = 'ADICONAL=Operação: T_FCCSVCO002.atualizaHistoricoGlb()';
var
  (* string piGlobal :IN *)
  vTpOperacao, vDsHistorico, vLstHistorico, vDsLinha : String;
  vCdHistorico : Real;
  vInPedeSenha, vInAutaConci, vInContraCx, vInGeraCp, vInGrava : Boolean;
begin
  vLstHistorico := itemXml('DS_HISTORICO', pParams);
  if (vLstHistorico = '') then begin
    Result := SetStatus(STS_ERROR, 'GEN001', , cDS_METHOD);
    return(-1); exit;
  end;

  repeat

    getitem(vDsLinha, vLstHistorico, 1);
    vCdHistorico := itemXmlF('CD_HISTORICO', vDsLinha);
    vTpOperacao := itemXmlF('TP_OPERACAO', vDsLinha);
    vDsHistorico := itemXml('DS_HISTORICO', vDsLinha);
    vInPedeSenha := itemXmlB('IN_PEDESENHA', vDsLinha);
    vInAutaConci := itemXmlB('IN_AUTACONCI', vDsLinha);
    vInContraCx := itemXmlB('IN_CONTRACX', vDsLinha);
    vInGeraCp := itemXmlB('IN_GERACP', vDsLinha);

    message/hint 'Atualizando histórico: ' + FloatToStr(vCdHistorico') + ';

    clear_e(tGLB_FCCHISTOR);
    putitem_e(tGLB_FCCHISTOR, 'CD_HISTORICO', vCdHistorico);
    retrieve_e(tGLB_FCCHISTOR);
    if (xStatus < 0) then begin
      clear_e(tGLB_FCCHISTOR);
      creocc(tGLB_FCCHISTOR, -1);
      putitem_e(tGLB_FCCHISTOR, 'CD_HISTORICO', vCdHistorico);
      putitem_e(tGLB_FCCHISTOR, 'TP_OPERACAO', vTpOperacao);
      putitem_e(tGLB_FCCHISTOR, 'DS_HISTORICO', vDsHistorico);
      putitem_e(tGLB_FCCHISTOR, 'IN_PEDESENHA', vInPedeSenha);
      putitem_e(tGLB_FCCHISTOR, 'IN_AUTACONCI', vInAutaConci);
      putitem_e(tGLB_FCCHISTOR, 'IN_CONTRACX', vInContraCx);
      putitem_e(tGLB_FCCHISTOR, 'IN_GERACP', vInGeraCp);
      putitem_e(tGLB_FCCHISTOR, 'CD_OPERADOR', itemXmlF('CD_USUARIO', piGlobal));
      putitem_e(tGLB_FCCHISTOR, 'DT_CADASTRO', Now);

      tGLB_FCCHISTOR.Salvar();
      if (xStatus < 0) then begin
Result := SetStatus(STS_ERROR, xProcerror, xProcerrorcontext, cDS_METHOD);
const
  Result := SetStatus(STS_ERROR, xProcerror, xProcerrorcontext, cDS_METHOD);
begin
        return(-1); exit;
      end;
    end else begin
      vInGrava := False;
      if (item_f('TP_OPERACAO', tGLB_FCCHISTOR) <> vTpOperacao) then begin
        putitem_e(tGLB_FCCHISTOR, 'TP_OPERACAO', vTpOperacao);
        vInGrava := True;
      end;
      if (item_a('DS_HISTORICO', tGLB_FCCHISTOR) <> vDsHistorico) then begin
        putitem_e(tGLB_FCCHISTOR, 'DS_HISTORICO', vDsHistorico);
        vInGrava := True;
      end;
      if (item_b('IN_PEDESENHA', tGLB_FCCHISTOR) <> vInPedeSenha) then begin
        putitem_e(tGLB_FCCHISTOR, 'IN_PEDESENHA', vInPedeSenha);
        vInGrava := True;
      end;
      if (item_b('IN_AUTACONCI', tGLB_FCCHISTOR) <> vInAutaConci) then begin
        putitem_e(tFCC_HISTORICO, 'IN_AUTACONCI', vInAutaConci);
        vInGrava := True;
      end;
      if (item_b('IN_CONTRACX', tGLB_FCCHISTOR) <> vInContraCx) then begin
        putitem_e(tGLB_FCCHISTOR, 'IN_CONTRACX', vInContraCx);
        vInGrava := True;
      end;
      if (item_b('IN_GERACP', tGLB_FCCHISTOR) <> vInGeraCp) then begin
        putitem_e(tGLB_FCCHISTOR, 'IN_GERACP', vInGeraCp);
        vInGrava := True;
      end;
      if (vInGrava = True) then begin
        putitem_e(tGLB_FCCHISTOR, 'CD_OPERADOR', itemXmlF('CD_USUARIO', piGlobal));
        putitem_e(tGLB_FCCHISTOR, 'DT_CADASTRO', Now);

        tGLB_FCCHISTOR.Salvar();
        if (xStatus < 0) then begin
Result := SetStatus(STS_ERROR, xProcerror, xProcerrorcontext, cDS_METHOD);
const
  Result := SetStatus(STS_ERROR, xProcerror, xProcerrorcontext, cDS_METHOD);
begin
          return(-1); exit;
        end;
      end;
    end;

    delitem(vLstHistorico, 1);
  until(vLstHistorico = '');

  message/hint '';

  return(0); exit;
end;

//---------------------------------------------------------------
function T_FCCSVCO002.alteraMovimento(pParams : String) : String;
//---------------------------------------------------------------
const
  cDS_METHOD = 'ADICONAL=Operação: T_FCCSVCO002.alteraMovimento()';
var
  vNrCtaPes, vNrSeqMov, vTpDocumento, vNrSeqHistRelSub, vCdHistorico, vVlLancto : Real;
  vVlSaldoAnt, vCdOperador, vVlSaldoConciAnt, vVlLanctoAnt : Real;
  vDtMovim, vDtConci, vDtSaldoAnt : TDate;
  vTpOperacao, vTpOperacaoAnt : String;
  vInAchou : Boolean;
begin
  vNrCtaPes := itemXmlF('NR_CTAPES', pParams);
  vDtMovim := itemXml('DT_MOVIM', pParams);
  vNrSeqMov := itemXmlF('NR_SEQMOV', pParams);
  vTpDocumento := itemXmlF('TP_DOCUMENTO', pParams);
  vNrSeqHistRelSub := itemXmlF('NR_SEQHISTRELSUB', pParams);
  vCdHistorico := itemXmlF('CD_HISTORICO', pParams);
  vVlLancto := itemXmlF('VL_LANCTO', pParams);
  vCdOperador := itemXmlF('CD_USUARIO', PARAM_GLB);

  if (vNrCtaPes = 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Conta não informada!', cDS_METHOD);
    return(-1); exit;
  end;
  if (vDtMovim = 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Data movimento não informada!', cDS_METHOD);
    return(-1); exit;
  end;
  if (vNrSeqMov = 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Sequencia do movimento não informado!', cDS_METHOD);
    return(-1); exit;
  end;
  if (vTpDocumento = 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Tipo de documento não informado!', cDS_METHOD);
    return(-1); exit;
  end;
  if (vTpDocumento = 4 ) or (vTpDocumento = 5)  and (vNrSeqHistRelSub = 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Sequencia auxiliar de parcelamento não informada!', cDS_METHOD);
    return(-1); exit;
  end;
  if (vNrSeqHistRelSub = 0) then begin
    vNrSeqHistRelSub := 1;
  end;
  if (vCdHistorico = 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Histórico não informado!', cDS_METHOD);
    return(-1); exit;
  end;
  if (vVlLancto = 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Valor não informado!', cDS_METHOD);
    return(-1); exit;
  end;

  clear_e(tFCC_CTAPES);
  putitem_e(tFCC_CTAPES, 'NR_CTAPES', vNrCtaPes);
  retrieve_e(tFCC_CTAPES);
  if (xStatus < 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Conta ' + FloatToStr(vNrCtaPes) + ' não cadastrada!', cDS_METHOD);
    return(-1); exit;
  end;

  clear_e(tFCC_HISTORICO);
  putitem_e(tFCC_HISTORICO, 'CD_HISTORICO', vCdHistorico);
  retrieve_e(tFCC_HISTORICO);
  if (xStatus < 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Histórico ' + FloatToStr(vCdHistorico) + ' não cadastrado!', cDS_METHOD);
    return(-1); exit;
  end;
  if (item_b('IN_AUTACONCI', tFCC_HISTORICO) = True)  and (vDtConci  = '') then begin
    vDtConci := vDtMovim;
  end;

  vTpOperacao := item_f('TP_OPERACAO', tFCC_HISTORICO);
  vVlLancto := gabs(vVlLancto);

  clear_e(tFCC_MOV);
  putitem_e(tFCC_MOV, 'NR_CTAPES', vNrCtaPes);
  putitem_e(tFCC_MOV, 'DT_MOVIM', vDtMovim);
  putitem_e(tFCC_MOV, 'NR_SEQMOV', vNrSeqMov);
  retrieve_e(tFCC_MOV);
  if (xStatus < 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Movimento para alteração não encotrado!', cDS_METHOD);
    return(-1); exit;
  end;
  if (item_b('IN_ESTORNO', tFCC_MOV) = True) then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Movimento estornado. Não i possível fazer alteração!', cDS_METHOD);
    return(-1); exit;
  end;

  vTpOperacaoAnt := item_f('TP_OPERACAO', tFCC_MOV);
  vVlLanctoAnt := item_f('VL_LANCTO', tFCC_MOV);

  vDtConci := item_a('DT_CONCI', tFCC_MOV);

  if (vTpDocumento = 4 ) or (vTpDocumento = 5) then begin
    putitem_e(tFCC_MOV, 'NR_SEQHISTRELSUB', vNrSeqHistRelSub);
  end else begin
    putitem_e(tFCC_MOV, 'NR_SEQHISTRELSUB', 1);
  end;
  if (vDtConci <> '') then begin
    putitem_e(tFCC_MOV, 'CD_OPERCONCI', itemXmlF('CD_USUARIO', PARAM_GLB));
    putitem_e(tFCC_MOV, 'DT_CONCI', vDtConci);
  end else begin
    putitem_e(tFCC_MOV, 'CD_OPERCONCI', '');
    putitem_e(tFCC_MOV, 'DT_CONCI', '');
  end;

  putitem_e(tFCC_MOV, 'CD_OPERADOR', vCdOperador);
  putitem_e(tFCC_MOV, 'DT_CADASTRO', Now);
  putitem_e(tFCC_MOV, 'TP_DOCUMENTO', vTpDocumento);
  putitem_e(tFCC_MOV, 'CD_HISTORICO', vCdHistorico);
  putitem_e(tFCC_MOV, 'VL_LANCTO', vVlLancto);
  putitem_e(tFCC_MOV, 'TP_OPERACAO', vTpOperacao);

  tFCC_MOV.Salvar();
  if (xStatus < 0) then begin
    Result := voParams;
    return(-1); exit;
  end;
  if (vDtConci <> '') then begin
    vInAchou := False;
    vVlSaldoAnt := 0;
    vVlSaldoConciAnt := 0;

    vDtSaldoAnt := '';

    selectdb max(DT_MOVIM) %\
    from 'FCC_CTASALDOSVC' %\
    u_where (putitem_e(tFCC_CTASALDO, 'NR_CTAPES', vNrCtaPes ) and (%\
    item_a('DT_MOVIM', tFCC_CTASALDO) < vDtConci) %\
    to vDtSaldoAnt;
    if (xStatus < 0) then begin
      Result := SetStatus(STS_ERROR, xProcerror, xProcerrorcontext, '');
      return(-1); exit;
    end else begin
      if (vDtSaldoAnt <> '') then begin
        clear_e(tFCC_CTASALDO);
        putitem_e(tFCC_CTASALDO, 'NR_CTAPES', vNrCtaPes);
        putitem_e(tFCC_CTASALDO, 'DT_MOVIM', vDtSaldoAnt);
        retrieve_e(tFCC_CTASALDO);
        if (xStatus >= 0) then begin
          vVlSaldoAnt := item_f('VL_SALDO', tFCC_CTASALDO);
          vVlSaldoConciAnt := item_f('VL_SALDOCONCI', tFCC_CTASALDO);
        end else begin
          Result := SetStatus(STS_ERROR, 'GEN0001', 'Não foi possível obter o saldo do dia ' + vDtSaldoAnt + ' da conta ' + FloatToStr(vNrCtaPes!',) + ' cDS_METHOD);
          return(-1); exit;
        end;
      end;
    end;

    clear_e(tFCC_CTASALDO);

    creocc(tFCC_CTASALDO, -1);
    putitem_e(tFCC_CTASALDO, 'NR_CTAPES', vNrCtaPes);
    putitem_e(tFCC_CTASALDO, 'DT_MOVIM', vDtConci);
    retrieve_o(tFCC_CTASALDO);
    if (xStatus = -7) then begin
      retrieve_x(tFCC_CTASALDO);

      if (item_f('TP_OPERACAO', tFCC_MOV) = 'C') then begin
        putitem_e(tFCC_CTASALDO, 'VL_SALDOCONCI', item_f('VL_SALDOCONCI', tFCC_CTASALDO) + item_f('VL_LANCTO', tFCC_MOV));
      end else begin
        putitem_e(tFCC_CTASALDO, 'VL_SALDOCONCI', item_f('VL_SALDOCONCI', tFCC_CTASALDO) - item_f('VL_LANCTO', tFCC_MOV));
      end;
    end else begin
      if (vTpOperacao = 'C') then begin
        putitem_e(tFCC_CTASALDO, 'VL_SALDOCONCI', vVlSaldoConciAnt + item_f('VL_LANCTO', tFCC_MOV));
      end else begin
        putitem_e(tFCC_CTASALDO, 'VL_SALDOCONCI', vVlSaldoConciAnt - item_f('VL_LANCTO', tFCC_MOV));
      end;

      putitem_e(tFCC_CTASALDO, 'VL_SALDO', vVlSaldoAnt);
    end;

    putitem_e(tFCC_CTASALDO, 'CD_OPERADOR', vCdOperador);
    putitem_e(tFCC_CTASALDO, 'DT_CADASTRO', Now);

    tFCC_CTASALDO.Salvar();
    if (xStatus < 0) then begin
      Result := voParams;
      return(-1); exit;
    end;

    clear_e(tFCC_CTASALDO);
    putitem_e(tFCC_CTASALDO, 'NR_CTAPES', vNrCtaPes);
    putitem_e(tFCC_CTASALDO, 'DT_MOVIM', '>' + vDtConci' + ');
    retrieve_e(tFCC_CTASALDO);
    if (xStatus >= 0) then begin
      setocc(tFCC_CTASALDO, 1);
      while (xStatus >= 0) do begin
        if (item_f('TP_OPERACAO', tFCC_MOV) = 'C') then begin
          putitem_e(tFCC_CTASALDO, 'VL_SALDOCONCI', item_f('VL_SALDOCONCI', tFCC_CTASALDO) + item_f('VL_LANCTO', tFCC_MOV));
        end else begin
          putitem_e(tFCC_CTASALDO, 'VL_SALDOCONCI', item_f('VL_SALDOCONCI', tFCC_CTASALDO) - item_f('VL_LANCTO', tFCC_MOV));
        end;
        putitem_e(tFCC_CTASALDO, 'CD_OPERADOR', vCdOperador);
        putitem_e(tFCC_CTASALDO, 'DT_CADASTRO', Now);

        setocc(tFCC_CTASALDO, curocc(tFCC_CTASALDO) + 1);
      end;

      tFCC_CTASALDO.Salvar();
      if (xStatus < 0) then begin
        Result := voParams;
        return(-1); exit;
      end;
    end;
  end;

  vInAchou := False;
  vVlSaldoAnt := 0;
  vVlSaldoConciAnt := 0;

  vDtSaldoAnt := '';

  selectdb max(DT_MOVIM) %\
  from 'FCC_CTASALDOSVC' %\
  u_where (putitem_e(tFCC_CTASALDO, 'NR_CTAPES', vNrCtaPes ) and (%\
  item_a('DT_MOVIM', tFCC_CTASALDO) < vDtMovim) %\
  to vDtSaldoAnt;
  if (xStatus < 0) then begin
    Result := SetStatus(STS_ERROR, xProcerror, xProcerrorcontext, '');
    return(-1); exit;
  end else begin
    if (vDtSaldoAnt <> '') then begin
      clear_e(tFCC_CTASALDO);
      putitem_e(tFCC_CTASALDO, 'NR_CTAPES', vNrCtaPes);
      putitem_e(tFCC_CTASALDO, 'DT_MOVIM', vDtSaldoAnt);
      retrieve_e(tFCC_CTASALDO);
      if (xStatus >= 0) then begin
        vVlSaldoAnt := item_f('VL_SALDO', tFCC_CTASALDO);
        vVlSaldoConciAnt := item_f('VL_SALDOCONCI', tFCC_CTASALDO);
        vInAchou := True;
      end else begin
        Result := SetStatus(STS_ERROR, 'GEN0001', 'Não foi possível obter o saldo do dia ' + vDtSaldoAnt + ' da conta ' + FloatToStr(vNrCtaPes!',) + ' cDS_METHOD);
        return(-1); exit;
      end;
    end;
  end;

  clear_e(tFCC_CTASALDO);

  creocc(tFCC_CTASALDO, -1);
  putitem_e(tFCC_CTASALDO, 'NR_CTAPES', vNrCtaPes);
  putitem_e(tFCC_CTASALDO, 'DT_MOVIM', vDtMovim);
  retrieve_o(tFCC_CTASALDO);
  if (xStatus = -7) then begin
    retrieve_x(tFCC_CTASALDO);
    if (item_f('VL_CREDITOS', tFCC_CTASALDO) = 0 ) and (item_f('VL_DEBITOS', tFCC_CTASALDO) = 0) then begin
      if (vTpOperacao = 'C') then begin
        putitem_e(tFCC_CTASALDO, 'VL_SALDO', vVlSaldoAnt + vVlLancto);
        putitem_e(tFCC_CTASALDO, 'VL_CREDITOS', vVlLancto);
      end else begin
        putitem_e(tFCC_CTASALDO, 'VL_SALDO', vVlSaldoAnt - vVlLancto);
        putitem_e(tFCC_CTASALDO, 'VL_DEBITOS', vVlLancto);
      end;
      if (vInAchou = True) then begin
        putitem_e(tFCC_CTASALDO, 'IN_INICIAL', False);
      end else begin
        putitem_e(tFCC_CTASALDO, 'IN_INICIAL', True);
      end;
    end else begin
      if (vTpOperacao = 'C') then begin
        putitem_e(tFCC_CTASALDO, 'VL_SALDO', item_f('VL_SALDO', tFCC_CTASALDO) + vVlLancto);
        putitem_e(tFCC_CTASALDO, 'VL_CREDITOS', item_f('VL_CREDITOS', tFCC_CTASALDO) + vVlLancto);
      end else begin
        putitem_e(tFCC_CTASALDO, 'VL_SALDO', item_f('VL_SALDO', tFCC_CTASALDO) - vVlLancto);
        putitem_e(tFCC_CTASALDO, 'VL_DEBITOS', item_f('VL_DEBITOS', tFCC_CTASALDO) + vVlLancto);
      end;
    end;
  end else begin
    if (vTpOperacao = 'C') then begin
      putitem_e(tFCC_CTASALDO, 'VL_SALDO', vVlSaldoAnt + vVlLancto);
      putitem_e(tFCC_CTASALDO, 'VL_CREDITOS', vVlLancto);
    end else begin
      putitem_e(tFCC_CTASALDO, 'VL_SALDO', vVlSaldoAnt - vVlLancto);
      putitem_e(tFCC_CTASALDO, 'VL_DEBITOS', vVlLancto);
    end;
    if (vInAchou = True) then begin
      putitem_e(tFCC_CTASALDO, 'IN_INICIAL', False);
    end else begin
      putitem_e(tFCC_CTASALDO, 'IN_INICIAL', True);
    end;
    putitem_e(tFCC_CTASALDO, 'VL_SALDOCONCI', vVlSaldoConciAnt);
  end;
  putitem_e(tFCC_CTASALDO, 'CD_OPERADOR', vCdOperador);
  putitem_e(tFCC_CTASALDO, 'DT_CADASTRO', Now);

  tFCC_CTASALDO.Salvar();
  if (xStatus < 0) then begin
    Result := voParams;
    return(-1); exit;
  end;

  clear_e(tFCC_CTASALDO);
  putitem_e(tFCC_CTASALDO, 'NR_CTAPES', vNrCtaPes);
  putitem_e(tFCC_CTASALDO, 'DT_MOVIM', '>' + vDtMovim' + ');
  retrieve_e(tFCC_CTASALDO);
  if (xStatus >= 0) then begin
    setocc(tFCC_CTASALDO, 1);
    while (xStatus >= 0) do begin
      if (vTpOperacao = 'C') then begin
        putitem_e(tFCC_CTASALDO, 'VL_SALDO', item_f('VL_SALDO', tFCC_CTASALDO) + vVlLancto);
        putitem_e(tFCC_CTASALDO, 'VL_CREDITOS', item_f('VL_CREDITOS', tFCC_CTASALDO) + vVlLancto);
      end else begin
        putitem_e(tFCC_CTASALDO, 'VL_SALDO', item_f('VL_SALDO', tFCC_CTASALDO) - vVlLancto);
        putitem_e(tFCC_CTASALDO, 'VL_DEBITOS', item_f('VL_DEBITOS', tFCC_CTASALDO) + vVlLancto);
      end;
      putitem_e(tFCC_CTASALDO, 'CD_OPERADOR', vCdOperador);
      putitem_e(tFCC_CTASALDO, 'DT_CADASTRO', Now);

      setocc(tFCC_CTASALDO, curocc(tFCC_CTASALDO) + 1);
    end;

    tFCC_CTASALDO.Salvar();
    if (xStatus < 0) then begin
      Result := voParams;
      return(-1); exit;
    end;
  end;

  vInAchou := False;
  vVlSaldoAnt := 0;

  vDtSaldoAnt := '';
  selectdb max(DT_MOVIM) %\
  from 'FCC_CTASALDORSVC' %\
  u_where (putitem_e(tFCC_CTASALDOR, 'NR_CTAPES', vNrCtaPes ) and (%\
  putitem_e(tFCC_CTASALDOR, 'TP_DOCUMENTO', vTpDocumento ) and (%\
  putitem_e(tFCC_CTASALDOR, 'NR_SEQHISTRELSUB', vNrSeqHistRelSub ) and (%\
  item_a('DT_MOVIM', tFCC_CTASALDOR) < vDtMovim) %\
  to vDtSaldoAnt;
  if (xStatus < 0) then begin
    Result := SetStatus(STS_ERROR, xProcerror, xProcerrorcontext, '');
    return(-1); exit;
  end else begin
    if (vDtSaldoAnt = '') then begin
      clear_e(tFCC_CTASALDOR);
      creocc(tFCC_CTASALDOR, -1);
      putitem_e(tFCC_CTASALDOR, 'NR_CTAPES', item_f('NR_CTAPES', tFCC_CTAPES));
      putitem_e(tFCC_CTASALDOR, 'TP_DOCUMENTO', vTpDocumento);
      putitem_e(tFCC_CTASALDOR, 'NR_SEQHISTRELSUB', vNrSeqHistRelSub);
      putitem_e(tFCC_CTASALDOR, 'DT_MOVIM', item_a('DT_ABERTURA', tFCC_CTAPES) - 1);
      putitem_e(tFCC_CTASALDOR, 'IN_INICIAL', True);
      putitem_e(tFCC_CTASALDOR, 'VL_SALDO', 0);
      putitem_e(tFCC_CTASALDOR, 'VL_SALDOCONCI', 0);
      putitem_e(tFCC_CTASALDOR, 'VL_CREDITOS', 0);
      putitem_e(tFCC_CTASALDOR, 'VL_DEBITOS', 0);
      putitem_e(tFCC_CTASALDOR, 'CD_OPERADOR', vCdOperador);
      putitem_e(tFCC_CTASALDOR, 'DT_CADASTRO', Now);

      tFCC_CTASALDOR.Salvar();
      if (xStatus < 0) then begin
        Result := voParams;
        return(-1); exit;
      end;
    end else begin
      clear_e(tFCC_CTASALDOR);
      putitem_e(tFCC_CTASALDOR, 'NR_CTAPES', vNrCtaPes);
      putitem_e(tFCC_CTASALDOR, 'TP_DOCUMENTO', vTpDocumento);
      putitem_e(tFCC_CTASALDOR, 'NR_SEQHISTRELSUB', vNrSeqHistRelSub);
      putitem_e(tFCC_CTASALDOR, 'DT_MOVIM', vDtSaldoAnt);
      retrieve_e(tFCC_CTASALDOR);
      if (xStatus >= 0) then begin
        vVlSaldoAnt := item_f('VL_SALDO', tFCC_CTASALDOR);
        vInAchou := True;
      end else begin
        Result := SetStatus(STS_ERROR, 'GEN0001', 'Não foi possível obter o saldo do dia ' + vDtSaldoAnt + ' da conta ' + FloatToStr(vNrCtaPes!',) + ' cDS_METHOD);
        return(-1); exit;
      end;
    end;
  end;

  clear_e(tFCC_CTASALDOR);

  creocc(tFCC_CTASALDOR, -1);
  putitem_e(tFCC_CTASALDOR, 'NR_CTAPES', vNrCtaPes);
  putitem_e(tFCC_CTASALDOR, 'TP_DOCUMENTO', vTpDocumento);
  putitem_e(tFCC_CTASALDOR, 'NR_SEQHISTRELSUB', vNrSeqHistRelSub);
  putitem_e(tFCC_CTASALDOR, 'DT_MOVIM', vDtMovim);
  retrieve_o(tFCC_CTASALDOR);
  if (xStatus = -7) then begin
    retrieve_x(tFCC_CTASALDOR);

    if (vTpOperacaoAnt = 'C') then begin
      putitem_e(tFCC_CTASALDOR, 'VL_SALDO', item_f('VL_SALDO', tFCC_CTASALDOR) - vVlLanctoAnt);
    end else begin
      putitem_e(tFCC_CTASALDOR, 'VL_SALDO', item_f('VL_SALDO', tFCC_CTASALDOR) + vVlLanctoAnt);
    end;
    if (vTpOperacao = 'C') then begin
      putitem_e(tFCC_CTASALDOR, 'VL_SALDO', item_f('VL_SALDO', tFCC_CTASALDOR) + vVlLancto);
      putitem_e(tFCC_CTASALDOR, 'VL_CREDITOS', item_f('VL_CREDITOS', tFCC_CTASALDOR) + vVlLancto - vVlLanctoAnt);
    end else begin
      putitem_e(tFCC_CTASALDOR, 'VL_SALDO', item_f('VL_SALDO', tFCC_CTASALDOR) - vVlLancto);
      putitem_e(tFCC_CTASALDOR, 'VL_DEBITOS', item_f('VL_DEBITOS', tFCC_CTASALDOR) + vVlLancto - vVlLanctoAnt);
    end;
  end else begin
    if (vTpOperacaoAnt = 'C') then begin
      putitem_e(tFCC_CTASALDOR, 'VL_SALDO', item_f('VL_SALDO', tFCC_CTASALDOR) - vVlLanctoAnt);
    end else begin
      putitem_e(tFCC_CTASALDOR, 'VL_SALDO', item_f('VL_SALDO', tFCC_CTASALDOR) + vVlLanctoAnt);
    end;
    if (vTpOperacao = 'C') then begin
      putitem_e(tFCC_CTASALDOR, 'VL_SALDO', vVlSaldoAnt + vVlLancto);
      putitem_e(tFCC_CTASALDOR, 'VL_CREDITOS', vVlLancto - vVlLanctoAnt);
    end else begin
      putitem_e(tFCC_CTASALDOR, 'VL_SALDO', vVlSaldoAnt - vVlLancto);
      putitem_e(tFCC_CTASALDOR, 'VL_DEBITOS', vVlLancto - vVlLanctoAnt);
    end;
    if (vInAchou = True) then begin
      putitem_e(tFCC_CTASALDOR, 'IN_INICIAL', False);
    end else begin
      putitem_e(tFCC_CTASALDOR, 'IN_INICIAL', True);
    end;
  end;

  putitem_e(tFCC_CTASALDOR, 'VL_SALDOCONCI', 0);
  putitem_e(tFCC_CTASALDOR, 'CD_OPERADOR', vCdOperador);
  putitem_e(tFCC_CTASALDOR, 'DT_CADASTRO', Now);

  tFCC_CTASALDOR.Salvar();
  if (xStatus < 0) then begin
    Result := voParams;
    return(-1); exit;
  end;

  clear_e(tFCC_CTASALDOR);
  putitem_e(tFCC_CTASALDOR, 'NR_CTAPES', vNrCtaPes);
  putitem_e(tFCC_CTASALDOR, 'TP_DOCUMENTO', vTpDocumento);
  putitem_e(tFCC_CTASALDOR, 'NR_SEQHISTRELSUB', vNrSeqHistRelSub);
  putitem_e(tFCC_CTASALDOR, 'DT_MOVIM', '>' + vDtMovim' + ');
  retrieve_e(tFCC_CTASALDOR);
  if (xStatus >= 0) then begin
    setocc(tFCC_CTASALDOR, 1);
    while (xStatus >= 0) do begin
      if (vTpOperacaoAnt = 'C') then begin
        putitem_e(tFCC_CTASALDOR, 'VL_SALDO', item_f('VL_SALDO', tFCC_CTASALDOR) - vVlLanctoAnt);
      end else begin
        putitem_e(tFCC_CTASALDOR, 'VL_SALDO', item_f('VL_SALDO', tFCC_CTASALDOR) + vVlLanctoAnt);
      end;
      if (vTpOperacao = 'C') then begin
        putitem_e(tFCC_CTASALDOR, 'VL_SALDO', item_f('VL_SALDO', tFCC_CTASALDOR) + vVlLancto);
        putitem_e(tFCC_CTASALDOR, 'VL_CREDITOS', item_f('VL_CREDITOS', tFCC_CTASALDOR) + vVlLancto - vVlLanctoAnt);
      end else begin
        putitem_e(tFCC_CTASALDOR, 'VL_SALDO', item_f('VL_SALDO', tFCC_CTASALDOR) - vVlLancto);
        putitem_e(tFCC_CTASALDOR, 'VL_DEBITOS', item_f('VL_DEBITOS', tFCC_CTASALDOR) + vVlLancto - vVlLanctoAnt);
      end;

      putitem_e(tFCC_CTASALDOR, 'CD_OPERADOR', vCdOperador);
      putitem_e(tFCC_CTASALDOR, 'DT_CADASTRO', Now);

      setocc(tFCC_CTASALDOR, curocc(tFCC_CTASALDOR) + 1);
    end;

    tFCC_CTASALDOR.Salvar();
    if (xStatus < 0) then begin
      Result := voParams;
      return(-1); exit;
    end;
  end;

  return(0); exit;
end;

//-------------------------------------------------------------------
function T_FCCSVCO002.AlteraMovAutocheque(pParams : String) : String;
//-------------------------------------------------------------------
const
  cDS_METHOD = 'ADICONAL=Operação: T_FCCSVCO002.AlteraMovAutocheque()';
begin
var
  vNrCtapesAnt : Real;
  vDtMovimAnt : TDate;
  vNrSeqmovAnt : Real;
  vNrCtapesNovo : Real;
  vDtMovimNovo : TDate;
  vNrSeqmovNovo : Real;
begin
  vNrCtapesAnt := itemXmlF('NR_CTAPESANT', pParams);
  vDtMovimAnt := itemXml('DT_MOVIMANT', pParams);
  vNrSeqmovAnt := itemXmlF('NR_SEQMOVANT', pParams);

  vNrCtapesNovo := itemXmlF('NR_CTAPESNOVO', pParams);
  vDtMovimNovo := itemXml('DT_MOVIMNOVO', pParams);
  vNrSeqmovNovo := itemXmlF('NR_SEQMOVNOVO', pParams);

  if (vNrCtapesAnt = '') then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Conta não informada !', cDS_METHOD);
    return(-1); exit;
  end;
  if (vDtMovimAnt = '') then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Data do movimento não informada !', cDS_METHOD);
    return(-1); exit;
  end;
  if (vNrSeqmovAnt = '') then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Sequência do movimento não informada !', cDS_METHOD);
    return(-1); exit;
  end;

  clear_e(tF_FCC_AUTOCHEQUE);
  putitem_e(tF_FCC_AUTOCHEQUE, 'NR_CTAPES', vNrCtapesAnt);
  putitem_e(tF_FCC_AUTOCHEQUE, 'DT_MOVIM', vDtMovimAnt);
  putitem_e(tF_FCC_AUTOCHEQUE, 'NR_SEQMOV', vNrSeqmovAnt);
  retrieve_e(tF_FCC_AUTOCHEQUE);
  if (xStatus >= 0) then begin
    putitem_e(tF_FCC_AUTOCHEQUE, 'NR_CTAPES', vNrCtaPesNovo);
    putitem_e(tF_FCC_AUTOCHEQUE, 'DT_MOVIM', vDtMovimNovo);
    putitem_e(tF_FCC_AUTOCHEQUE, 'NR_SEQMOV', vNrSeqMovNovo);
    putitem_e(tF_FCC_AUTOCHEQUE, 'DT_VENCIMENTO', vDtMovimNovo);
    tF_FCC_AUTOCHEQUE.Salvar();
    if (xStatus < 0) then begin
      Result := voParams;
      rollback;
      commit;
      return(-1); exit;
    end;
  end else begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Não foi possível encontrar a autorização para este movimento !', cDS_METHOD);
    return(-1); exit;
  end;

  return(0); exit;

end;

//----------------------------------------------------------------
function T_FCCSVCO002.BuscaUltimoSaldo(pParams : String) : String;
//----------------------------------------------------------------
const
  cDS_METHOD = 'ADICONAL=Operação: T_FCCSVCO002.BuscaUltimoSaldo()';
var
  (* string piGlobal :IN / string piValores :IN *)
  vNrCtaPes, vVlSaldo, vVlSaldoConci, vVlCreditos, vVlDebitos : Real;
  vDtSaldo, vDtMovim : TDate;
begin
  vNrCtaPes := itemXmlF('NR_CTAPES', pParams);

  if (vNrCtaPes = 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Conta não informada!', cDS_METHOD);
    return(-1); exit;
  end;

  vDtMovim := '';

  selectdb max(DT_MOVIM) %\
  from 'FCC_CTASALDOSVC' %\
  u_where (putitem_e(tFCC_CTASALDO, 'NR_CTAPES', vNrCtaPes) %\
  to vDtMovim;
  if (xStatus < 0) then begin
    Result := SetStatus(STS_ERROR, xProcerror, xProcerrorcontext, '');
    return(-1); exit;
  end;
  if (vDtMovim <> '') then begin
    clear_e(tFCC_CTASALDO);
    putitem_e(tFCC_CTASALDO, 'NR_CTAPES', vNrCtaPes);
    putitem_e(tFCC_CTASALDO, 'DT_MOVIM', vDtMovim);
    retrieve_e(tFCC_CTASALDO);
    if (xStatus >= 0) then begin
      vVlSaldo := item_f('VL_SALDO', tFCC_CTASALDO);
      vVlSaldoConci := item_f('VL_SALDOCONCI', tFCC_CTASALDO);
      vVlDebitos := item_f('VL_DEBITOS', tFCC_CTASALDO);
      vVlCreditos := item_f('VL_CREDITOS', tFCC_CTASALDO);
    end;
  end;

  Result := '';
  putitemXml(Result, 'VL_SALDO', vVlSaldo);
  putitemXml(Result, 'VL_SALDOCONCI', vVlSaldoConci);
  putitemXml(Result, 'VL_DEBITOS', vVlDebitos);
  putitemXml(Result, 'VL_CREDITOS', vVlCreditos);
  putitemXml(Result, 'DT_SALDO', vDtMovim);

  return(0); exit;
end;

//-----------------------------------------------------------------
function T_FCCSVCO002.gravarObsMovLista(pParams : String) : String;
//-----------------------------------------------------------------
const
  cDS_METHOD = 'ADICONAL=Operação: T_FCCSVCO002.gravarObsMovLista()';
var
  (* string piGlobal :IN *)
  viParams, voParams, vDsObs, vLstObs, vDsDocumento, vDsProcesso, vDsMotivo : String;
  vCdEmpresa, vCdCliente, vNrFat, vNrParcela, vTpDocumento : Real;
begin
  if (itemXml('NR_CTAPES', pParams) = '') then begin
    Result := SetStatus(STS_ERROR, 'GEN001', 'Número da conta não informado para gravar observação.', cDS_METHOD);
    return(-1); exit;
  end;
  if (itemXml('DT_MOVIM', pParams) = '') then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Data de movimento não informada para gravar observação.', cDS_METHOD);
    return(-1); exit;
  end;
  if (itemXml('NR_SEQMOV', pParams) = '') then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Data de movimento não informada para gravar observação.', cDS_METHOD);
    return(-1); exit;
  end;
  if (itemXml('CD_COMPONENTE', pParams) = '') then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Componente não informado para gravar observação.', cDS_METHOD);
    return(-1); exit;
  end;
  vLstObs := itemXml('LST_OBS', pParams);

  if (itemXml('IN_FATURA', pParams) = True) then begin
    vCdEmpresa := itemXmlF('CD_EMPRESA', pParams);
    vCdCliente := itemXmlF('CD_CLIENTE', pParams);
    vNrFat := itemXmlF('NR_FAT', pParams);
    vNrParcela := itemXmlF('NR_PARCELA', pParams);
    vDsProcesso := itemXml('DS_PROCESSO', pParams);
    vDsMotivo := itemXml('DS_MOTIVO', pParams);

    if (vCdEmpresa = '')  or (vCdEmpresa = 0) then begin
      Result := SetStatus(STS_ERROR, 'GEN0001', 'Empresa da fatura não informada para gravar observação.', cDS_METHOD);
      return(-1); exit;
    end;
    if (vCdCliente = '')  or (vCdCliente = 0) then begin
      Result := SetStatus(STS_ERROR, 'GEN0001', 'Cliente da fatura não informado para gravar observação.', cDS_METHOD);
      return(-1); exit;
    end;
    if (vNrFat = '')  or (vNrFat = 0) then begin
      Result := SetStatus(STS_ERROR, 'GEN0001', 'Número da fatura não informado para gravar observação.', cDS_METHOD);
      return(-1); exit;
    end;
    if (vNrParcela = '')  or (vNrParcela = 0) then begin
      Result := SetStatus(STS_ERROR, 'GEN0001', 'Número da parcela não informado para gravar observação.', cDS_METHOD);
      return(-1); exit;
    end;
    if (itemXml('CD_PESCOMIS', pParams) = '') then begin
      Result := SetStatus(STS_ERROR, 'GEN0001', 'Comissionado não informado para gravar observação.', cDS_METHOD);
      return(-1); exit;
    end;
    if (vDsProcesso = '') then begin
      Result := SetStatus(STS_ERROR, 'GEN0001', 'Processo não informado para gravar observação.', cDS_METHOD);
      return(-1); exit;
    end;
    if (vDsMotivo = '') then begin
      Result := SetStatus(STS_ERROR, 'GEN0001', 'Motivo não informado para gravar observação.', cDS_METHOD);
      return(-1); exit;
    end;

    clear_e(tFCR_FATURAI);
    putitem_e(tFCR_FATURAI, 'CD_EMPRESA', vCdEmpresa);
    putitem_e(tFCR_FATURAI, 'CD_CLIENTE', vCdCliente);
    putitem_e(tFCR_FATURAI, 'NR_FAT', vNrFat);
    putitem_e(tFCR_FATURAI, 'NR_PARCELA', vNrParcela);
    retrieve_e(tFCR_FATURAI);
    if (xStatus < 0) then begin
      Result := SetStatus(STS_ERROR, 'GEN001', 'Fatura não encontrada para gravação de observação.Emp.: ' + FloatToStr(vCdEmpresa) + ' Cliente: ' + FloatToStr(vCdCliente) + ' Fatura: ' + FloatToStr(vNrFat) + ' Parcela: ' + FloatToStr(vNrParcela',) + ' cDS_METHOD);
      return(-1); exit;
    end;
    vTpDocumento := item_f('TP_DOCUMENTO', tFCR_FATURAI);
    vDsDocumento := valrep(item_f('TP_DOCUMENTO', tFCR_FATURAI));
    vDsDocumento := itemXml('' + FloatToStr(vTpDocumento',) + ' vDsDocumento);

    clear_e(tPES_PESSOA);
    putitem_e(tPES_PESSOA, 'CD_PESSOA', vCdCliente);
    retrieve_e(tPES_PESSOA);
    if (xStatus < 0) then begin
      clear_e(tPES_PESSOA);
    end;

    clear_e(tFCR_COMISSAO);
    putitem_e(tFCR_COMISSAO, 'CD_EMPRESA', vCdEmpresa);
    putitem_e(tFCR_COMISSAO, 'CD_CLIENTE', vCdCliente);
    putitem_e(tFCR_COMISSAO, 'NR_FATURA', vNrFat);
    putitem_e(tFCR_COMISSAO, 'NR_PARCELA', vNrParcela);
    putitem_e(tFCR_COMISSAO, 'CD_PESCOMIS', itemXmlF('CD_PESCOMIS', pParams));
    retrieve_e(tFCR_COMISSAO);
    if (xStatus < 0) then begin
      clear_e(tFCR_COMISSAO);
    end;

    vDsObs := 'Cliente : ' + FloatToStr(vCdCliente) + ' - ' + item_a('NM_PESSOA', tPES_PESSOA)' + ';
    putitem(vLstObs,  vDsObs);
    vDsObs := 'Documento : ' + FloatToStr(vNrFat) + ' / ' + FloatToStr(vNrParcela) + ' - ' + vDsDocumento' + ';
    putitem(vLstObs,  vDsObs);
    vDsObs := 'Valor de : ' + item_f('VL_FATURA', tFCR_FATURAI)' + ';
    putitem(vLstObs,  vDsObs);
    vDsObs := 'Perc. comis. fat. : ' + item_f('PR_COMISSAOFAT', tFCR_COMISSAO)' + ';
    putitem(vLstObs,  vDsObs);
    vDsObs := 'Perc. comis. rec. : ' + item_f('PR_COMISSAOREC', tFCR_COMISSAO)' + ';
    putitem(vLstObs,  vDsObs);
    vDsObs := 'Processo : ' + vDsProcesso' + ';
    putitem(vLstObs,  vDsObs);
    vDsObs := 'Motivo : ' + vDsMotivo' + ';
    putitem(vLstObs,  vDsObs);
  end;
  if (vLstObs = '') then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Lista de observação não informada para gravação.', cDS_METHOD);
    return(-1); exit;
  end;

  repeat
    getitem(vDsObs, vLstObs, 1);

    viParams := '';
    putitemXml(viParams, 'NR_CTAPES', itemXmlF('NR_CTAPES', pParams));
    putitemXml(viParams, 'DT_MOVIM', itemXml('DT_MOVIM', pParams));
    putitemXml(viParams, 'NR_SEQMOV', itemXmlF('NR_SEQMOV', pParams));
    putitemXml(viParams, 'CD_COMPONENTE', itemXmlF('CD_COMPONENTE', pParams));
    putitemXml(viParams, 'DS_OBS', vDsObs);
    voParams := gravaObsMov(viParams); (* piGlobal, viParams, voParams, xCdErro, xCtxErro *)
    if (xStatus < 0) then begin
      Result := voParams;
      return(-1); exit;
    end;

    delitem(vLstObs, 1);
  until (vLstObs = '');

  return(0); exit;
end;

end.
