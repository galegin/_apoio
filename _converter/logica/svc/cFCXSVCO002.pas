unit cFCXSVCO002;

interface

(* COMPONENTES 
  ADMSVCO001 / FCCSVCO002 / FCCSVCO017 / FCCSVCO018 / GERSVCO011
  SICSVCO007 / SICSVCO009 / 
*)        

uses
  Classes, SysUtils, Math, DB,
  cDataSetUnf;

type
  T_FCXSVCO002 = class(TComponent)
  private
    tFCC_CTAPES,
    tFCX_CAIXAC,
    tFCX_CAIXAI,
    tFCX_CAIXAM,
    tFCX_CAIXASALD,
    tFCX_HISTREL : TcDatasetUnf;
    function getParam(pParams : String = '') : String;
    function setEntidade(pParams : String = '') : String;
  protected
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;    
  published
    function abreCaixa(pParams : String = '') : String;
    function fechaCaixa(pParams : String = '') : String;
    function supreCaixa(pParams : String = '') : String;
    function gravaCaixaC(pParams : String = '') : String;
    function gravaCaixaI(pParams : String = '') : String;
    function gravaFechamentoCaixa(pParams : String = '') : String;
  end;

implementation

uses
  cADMSVCO001,
  cActivate, cStatus, cFuncao, cXml, dModulo;

var
  gInLogMovCtaPes : String;

//---------------------------------------------------------------
constructor T_FCXSVCO002.Create(AOwner: TComponent);
//---------------------------------------------------------------
begin
  inherited Create(AOwner);
  setEntidade('');
end;

//--------------------------------
destructor T_FCXSVCO002.Destroy;
//--------------------------------
begin
  inherited Destroy;
end;

//---------------------------------------------------------------
function T_FCXSVCO002.getParam(pParams : String = '') : String;
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
  putitem(xParam, 'IN_LOG_MOV_CTAPES');

  xParam := T_ADMSVCO001.GetParametro(xParam);

  gInLogMovCtaPes := itemXml('IN_LOG_MOV_CTAPES', xParam);
  vCdEmpresa := itemXml('CD_EMPRESA', xParam);
  vCdEmpresaFundo := itemXml('CD_EMPRESAFUNDO', xParam);
  vCdOperCx := itemXml('CD_OPERCX', xParam);
  vCdOperCx := itemXml('CD_USUARIO', xParam);
  vCdTerminal := itemXml('CD_TERMINAL', xParam);
  vDtAbertura := itemXml('DT_ABERTURA', xParam);
  vInCxTerminal := itemXml('IN_CXTERMINAL', xParam);
  vNrCtaPesFundo := itemXml('NR_CTAPESFUNDO', xParam);
  vVlAbertura := itemXml('VL_ABERTURA', xParam);

  xParamEmp := '';
  putitem(xParamEmp, 'CD_CTAPES_CXFILIAL');
  putitem(xParamEmp, 'CD_CTAPES_CXMATRIZ');
  putitem(xParamEmp, 'CD_EMPRESA');
  putitem(xParamEmp, 'CD_EMPRESAFUNDO');
  putitem(xParamEmp, 'CD_OPERADOR');
  putitem(xParamEmp, 'CD_OPERCX');
  putitem(xParamEmp, 'DT_CADASTRO');
  putitem(xParamEmp, 'IN_FECHADO');
  putitem(xParamEmp, 'IN_UTILIZA_CXFILIAL');
  putitem(xParamEmp, 'NR_CTAPES');
  putitem(xParamEmp, 'NR_CTAPESFUNDO');
  putitem(xParamEmp, 'NR_SEQ');
  putitem(xParamEmp, 'VL_ABERTURA');

  xParamEmp := T_ADMSVCO001.GetParamEmpresa(piCdEmpresa, xParamEmp);

  vCxFilial := itemXml('CD_CTAPES_CXFILIAL', xParamEmp);
  vCxMatriz := itemXml('CD_CTAPES_CXMATRIZ', xParamEmp);
  vInCxFilial := itemXml('IN_UTILIZA_CXFILIAL', xParamEmp);

end;

//---------------------------------------------------------------
function T_FCXSVCO002.setEntidade(pParams : String = '') : String;
//---------------------------------------------------------------
begin
  tFCC_CTAPES := TcDatasetUnf.getEntidade('FCC_CTAPES');
  tFCX_CAIXAC := TcDatasetUnf.getEntidade('FCX_CAIXAC');
  tFCX_CAIXAI := TcDatasetUnf.getEntidade('FCX_CAIXAI');
  tFCX_CAIXAM := TcDatasetUnf.getEntidade('FCX_CAIXAM');
  tFCX_CAIXASALD := TcDatasetUnf.getEntidade('FCX_CAIXASALD');
  tFCX_HISTREL := TcDatasetUnf.getEntidade('FCX_HISTREL');
end;

//---------------------------------------------------------
function T_FCXSVCO002.abreCaixa(pParams : String) : String;
//---------------------------------------------------------
const
  cDS_METHOD = 'ADICONAL=Operação: T_FCXSVCO002.abreCaixa()';
var
  viParams, voParams : String;
  vCdEmpresa, vCdOperCx, vCdTerminal, vNrCtaPes, vNrSeq, vVlAbertura, vCxFilial : Real;
  vCdCCusto, vNrSeqMovRel, vCxMatriz, vCdEmpresaFUndo, vNrCtaPesFundo : Real;
  vDtAbertura : TDate;
  vInFundo, vInCxTerminal, vInCxFilial : Boolean;
begin
  vCdEmpresa := itemXmlF('CD_EMPRESA', pParams);
  vCdTerminal := itemXmlF('CD_TERMINAL', pParams);
  vDtAbertura := itemXml('DT_ABERTURA', pParams);
  vCdOperCx := itemXmlF('CD_OPERCX', pParams);
  vVlAbertura := itemXmlF('VL_ABERTURA', pParams);
  vInCxTerminal := itemXmlB('IN_CXTERMINAL', pParams);

  vCdEmpresaFundo := itemXmlF('CD_EMPRESAFUNDO', pParams);
  vNrCtaPesFundo := itemXmlF('NR_CTAPESFUNDO', pParams);

  if (vCdEmpresa = 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN001', 'Empresa não informada!', cDS_METHOD);
    return(-1); exit;
  end;
  if (vCdTerminal = 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN001', 'Terminal não informado!', cDS_METHOD);
    return(-1); exit;
  end;
  if (vDtAbertura = 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN001', 'Data de abertura não informada!', cDS_METHOD);
    return(-1); exit;
  end;
  if (vCdOperCx = 0) then begin
    vCdOperCx := itemXmlF('CD_USUARIO', PARAM_GLB);
  end;

  viParams := '';
  putitemXml(viParams, 'CD_EMPRESA', vCdEmpresa);
  putitemXml(viParams, 'CD_OPERADOR', vCdOperCx);
  putitemXml(viParams, 'CD_TERMINAL', vCdTerminal);
  voParams := activateCmp('FCCSVCO002', 'buscaContaOperador', viParams);
  if (xStatus < 0) then begin
    Result := voParams;
    return(-1); exit;
  end;

  clear_e(tFCX_CAIXAC);
  putitem_e(tFCX_CAIXAC, 'CD_EMPRESA', vCdEmpresa);
  putitem_e(tFCX_CAIXAC, 'CD_TERMINAL', vCdTerminal);
  putitem_e(tFCX_CAIXAC, 'IN_FECHADO', False);
  retrieve_e(tFCX_CAIXAC);
  if (xStatus >= 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN001', 'Terminal ' + FloatToStr(vCdTerminal) + ' já possui caixa aberto para o operador ' + item_a('CD_OPERCX', tFCX_CAIXAC)!', + ' cDS_METHOD);
    return(-1); exit;
  end;
  if (vInCxTerminal <> True) then begin
    clear_e(tFCX_CAIXAC);
    putitem_e(tFCX_CAIXAC, 'CD_EMPRESA', vCdEmpresa);
    putitem_e(tFCX_CAIXAC, 'CD_OPERCX', vCdOperCx);
    putitem_e(tFCX_CAIXAC, 'IN_FECHADO', False);
    retrieve_e(tFCX_CAIXAC);
    if (xStatus >= 0) then begin
      Result := SetStatus(STS_ERROR, 'GEN001', 'Operador ' + FloatToStr(vCdOperCx) + ' já possui caixa aberto no terminal ' + item_a('CD_TERMINAL', tFCX_CAIXAC)!', + ' cDS_METHOD);
      return(-1); exit;
    end;
  end;

  vNrCtaPes := itemXmlF('NR_CTAPES', voParams);
  if (vNrCtaPes = 0)  or (vNrCtaPes = '') then begin
    Result := SetStatus(STS_ERROR, 'GEN001', 'Nenhuma conta cadatrada para o operador ' + FloatToStr(vCdOperCx) + ' na empresa ' + FloatToStr(vCdEmpresa!',) + ' cDS_METHOD);
    return(-1); exit;
  end;

  newinstance 'GERSVCO011', 'GERSVCO011', 'TRANSACTION=TRUE';
  voParams := activateCmp('GERSVCO011', 'GetNumSeq', viParams);
  if (xStatus < 0) then begin
    Result := voParams;
    return(-1); exit;
  end;

  clear_e(tFCX_CAIXAC);
  creocc(tFCX_CAIXAC, -1);
  getlistitensocc_e(pParams, tFCX_CAIXAC);

  if (vInCxTerminal = True) then begin
    putitem_e(tFCX_CAIXAC, 'CD_OPERCX', '');
  end else begin
    putitem_e(tFCX_CAIXAC, 'CD_OPERCX', vCdOperCx);
  end;
  putitem_e(tFCX_CAIXAC, 'NR_SEQ', vNrSeq);
  putitem_e(tFCX_CAIXAC, 'IN_FECHADO', False);
  putitem_e(tFCX_CAIXAC, 'NR_CTAPES', vNrCtaPes);
  putitem_e(tFCX_CAIXAC, 'CD_OPERADOR', itemXmlF('CD_USUARIO', PARAM_GLB));
  putitem_e(tFCX_CAIXAC, 'DT_CADASTRO', Now);

  voParams := tFCX_CAIXAC.Salvar();
  if (xStatus < 0) then begin
    Result := voParams;
    return(-1); exit;
  end;

  viParams := '';
  putlistitensocc_e(viParams, tFCX_CAIXAC);
  putitemXml(viParams, 'VL_ABERTURA', vVlAbertura);
  putitemXml(viParams, 'CD_EMPRESAFUNDO', vCdEmpresaFundo);
  putitemXml(viParams, 'NR_CTAPESFUNDO', vNrCtaPesFundo);

  voParams := activateCmp('SICSVCO007', 'validaAberturaCaixa', viParams);
  if (xStatus < 0) then begin
    Result := voParams;
    return(-1); exit;
  end;
  if (vVlAbertura > 0) then begin
    viParams := '';
    putitemXml(viParams, 'CD_EMPRESA', item_f('CD_EMPRESA', tFCX_CAIXAC));
    voParams := activateCmp('SICSVCO009', 'validaCentroCusto', viParams);
    if (xStatus < 0) then begin
      Result := voParams;
      return(-1); exit;
    end;

    vCdCCusto := itemXmlF('CD_CENTROCUSTO', voParams);
    if (vCdCCusto <> item_f('CD_EMPRESA', tFCX_CAIXAC)) then begin
      viParams := '';
      putitem(viParams,  'CD_CTAPES_CXFILIAL');
      putitem(viParams,  'CD_CTAPES_CXMATRIZ');
      putitem(viParams,  'IN_UTILIZA_CXFILIAL');

      xParamEmp := T_ADMSVCO001.GetParamEmpresa(piCdEmpresa, xParamEmp);

      vInCxFilial := itemXmlB('IN_UTILIZA_CXFILIAL', voParams);
      vCxMatriz := itemXmlF('CD_CTAPES_CXMATRIZ', voParams);
      vCxFilial := itemXmlF('CD_CTAPES_CXFILIAL', voParams);
      if (vInCxFilial = True) then begin
        if (vCxFilial = 0)  or (vCxFilial = '') then begin
          Result := SetStatus(STS_ERROR, 'GEN001', , cDS_METHOD);
          rollback;
          return(-1); exit;
        end;
      end else begin
        if (vCxMatriz = 0)  or (vCxMatriz = '') then begin
          Result := SetStatus(STS_ERROR, 'GEN001', , cDS_METHOD);
          rollback;
          return(-1); exit;
        end;
      end;

      clear_e(tFCX_HISTREL);
      putitem_e(tFCX_HISTREL, 'TP_DOCUMENTO', 3);
      retrieve_e(tFCX_HISTREL);
      if (xStatus < 0) then begin
        Result := SetStatus(STS_ERROR, 'GEN001', 'Não existe histórico associado a tipo de operação dinheiro', cDS_METHOD);
        rollback;
        return(-1); exit;
      end;

      viParams := '';
      voParams := activateCmp('FCCSVCO017', 'getNumMovRel', viParams);
      if (xStatus < 0) then begin
        Result := SetStatus(STS_ERROR, xProcerror, xProcerrorcontext, cDS_METHOD);
        rollback;
        return(-1); exit;
      end;
      vNrSeqMovRel := itemXmlF('NR_SEQMOVREL', voParams);

      viParams := '';
      putitemXml(viParams, 'CD_EMPRESA', item_f('CD_EMPRESA', tFCX_CAIXAC));
      putitemXml(viParams, 'NR_CTAPES', vNrCtaPes);
      putitemXml(viParams, 'DT_MOVIMENTO', itemXml('DT_SISTEMA', PARAM_GLB));
      putitemXml(viParams, 'CD_HISTORICO', 856);
      putitemXml(viParams, 'TP_DOCUMENTO', 3);
      putitemXml(viParams, 'NR_SEQHISTRELSUB', 1);
      putitemXml(viParams, 'VL_LANCTO', vVlAbertura);
      putitemXml(viParams, 'IN_ESTORNO', False);
      putitemXml(viParams, 'IN_CAIXA', False);
      putitemXml(viParams, 'DS_DOC', '');
      putitemXml(viParams, 'DS_AUX', '');

      if (vNrSeqMovRel > 0) then begin
        putitemXml(viParams, 'NR_SEQMOVREL', vNrSeqMovRel);
      end;

      voParams := activateCmp('FCCSVCO002', 'movimentaConta', viParams);
      if (xStatus < 0) then begin
        Result := voParams;
        return(-1); exit;
      end;

      viParams := '';
      putitemXml(viParams, 'CD_EMPRESA', item_f('CD_EMPRESA', tFCX_CAIXAC));
      putitemXml(viParams, 'NR_CTAPES', vNrCtaPes);
      putitemXml(viParams, 'DT_MOVIMENTO', itemXml('DT_SISTEMA', PARAM_GLB));
      putitemXml(viParams, 'CD_HISTORICO', 830);
      putitemXml(viParams, 'CD_TERMINAL', vCdTerminal);
      putitemXml(viParams, 'DT_ABERTURA', vDtAbertura);
      putitemXml(viParams, 'NR_SEQCAIXA', vNrSeq);
      putitemXml(viParams, 'TP_DOCUMENTO', 3);
      putitemXml(viParams, 'NR_SEQHISTRELSUB', 1);
      putitemXml(viParams, 'VL_LANCTO', vVlAbertura);
      putitemXml(viParams, 'IN_ESTORNO', False);
      putitemXml(viParams, 'IN_CAIXA', True);
      putitemXml(viParams, 'DS_DOC', '');
      putitemXml(viParams, 'DS_AUX', '');

      if (vNrSeqMovRel > 0) then begin
        putitemXml(viParams, 'NR_SEQMOVREL', vNrSeqMovRel);
      end;

      voParams := activateCmp('FCCSVCO002', 'movimentaConta', viParams);
      if (xStatus < 0) then begin
        Result := voParams;
        return(-1); exit;
      end;
    end;
  end;

  return(0); exit;
end;

//----------------------------------------------------------
function T_FCXSVCO002.fechaCaixa(pParams : String) : String;
//----------------------------------------------------------
const
  cDS_METHOD = 'ADICONAL=Operação: T_FCXSVCO002.fechaCaixa()';
var
  viParams, voParams : String;
  vCdEmpresa, vNrSeq, vCdTerminal, vCdOperCx, vCdEmpresaCC : Real;
  vDtAbertura : TDate;
  vInCxTerminal : Boolean;
begin
  vCdOperCx := itemXmlF('CD_USUARIO', PARAM_GLB);
  vCdEmpresa := itemXmlF('CD_EMPRESA', pParams);
  vCdTerminal := itemXmlF('CD_TERMINAL', pParams);
  vDtAbertura := itemXml('DT_ABERTURA', pParams);
  vNrSeq := itemXmlF('NR_SEQ', pParams);
  vInCxTerminal := itemXmlB('IN_CXTERMINAL', pParams);

  if (vCdEmpresa = 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN001', 'Empresa não informada!', cDS_METHOD);
    return(-1); exit;
  end;
  if (vCdTerminal = 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN001', 'Terminal não informado!', cDS_METHOD);
    return(-1); exit;
  end;
  if (vDtAbertura = 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN001', 'Data de abertura não informada!', cDS_METHOD);
    return(-1); exit;
  end;
  if (vNrSeq = 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN001', 'Nr. de sequência do caixa informado!', cDS_METHOD);
    return(-1); exit;
  end;

  clear_e(tFCX_CAIXAC);
  putitem_e(tFCX_CAIXAC, 'CD_EMPRESA', vCdEmpresa);
  putitem_e(tFCX_CAIXAC, 'CD_TERMINAL', vCdTerminal);
  putitem_e(tFCX_CAIXAC, 'DT_ABERTURA', vDtAbertura);
  putitem_e(tFCX_CAIXAC, 'NR_SEQ', vNrSeq);
  retrieve_e(tFCX_CAIXAC);
  if (xStatus < 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN001', 'Caixa do terminal ' + FloatToStr(vCdTerminal) + ' não cadastrado!', cDS_METHOD);
    return(-1); exit;
  end else begin
    clear_e(tFCX_CAIXAM);
    putitem_e(tFCX_CAIXAM, 'CD_EMPRESA', item_f('CD_EMPRESA', tFCX_CAIXAC));
    putitem_e(tFCX_CAIXAM, 'CD_TERMINAL', item_f('CD_TERMINAL', tFCX_CAIXAC));
    putitem_e(tFCX_CAIXAM, 'DT_ABERTURA', item_a('DT_ABERTURA', tFCX_CAIXAC));
    putitem_e(tFCX_CAIXAM, 'NR_SEQ', item_f('NR_SEQ', tFCX_CAIXAC));
    retrieve_e(tFCX_CAIXAM);
    if (xStatus >= 0) then begin
      Result := SetStatus(STS_ERROR, 'GEN001', 'Caixa não pode ser encerrado. Existe movimento!', cDS_METHOD);
      return(-1); exit;
    end;
  end;
  if (vInCxTerminal <> True) then begin
    if (item_f('CD_OPERCX', tFCX_CAIXAC) <> vCdOperCx) then begin
      Result := SetStatus(STS_ERROR, 'GEN001', 'Caixa não pode ser fechado pelo operador ' + FloatToStr(vCdOperCx) + ' pois pertence ao operador ' + item_a('CD_OPERCX', tFCX_CAIXAC)!', + ' cDS_METHOD);
      return(-1); exit;
    end;
  end;

  putitem_e(tFCX_CAIXAC, 'IN_FECHADO', True);
  putitem_e(tFCX_CAIXAC, 'CD_OPERADOR', itemXmlF('CD_USUARIO', PARAM_GLB));
  putitem_e(tFCX_CAIXAC, 'DT_CADASTRO', Now);

  voParams := tFCX_CAIXAC.Salvar();
  if (xStatus < 0) then begin
    Result := voParams;
    return(-1); exit;
  end;

  viParams := '';
  putlistitensocc_e(viParams, tFCX_CAIXAC);
  putitemXml(viParams, 'IN_CXTERMINAL', vInCxTerminal);
  voParams := activateCmp('SICSVCO007', 'validaFechamentoCaixa', viParams);
  if (xStatus < 0) then begin
    Result := voParams;
    return(-1); exit;
  end;

  return(0); exit;
end;

//----------------------------------------------------------
function T_FCXSVCO002.supreCaixa(pParams : String) : String;
//----------------------------------------------------------
const
  cDS_METHOD = 'ADICONAL=Operação: T_FCXSVCO002.supreCaixa()';
var
  viParams, voParams, vDsObs : String;
  vCdEmpresa, vCdTerminal, vNrCtaPes, vNrSeq, vVlSuprimento, vNrSeqMovRel, vVlSaldoAntDoc, vVlSaldoAnt, vNrCtaPesFCC, vTpDocumento, vNrSeqHistRelSub : Real;
  vCdTerminalDest, vNrSeqDest, vNrCtaOrigem, vNrCtaDestino, vTpProcesso, vNrSeqMovFCC, vVlSaldoAtualDoc, vVlSaldoAtual : Real;
  vDtAbertura, vDtAberturaDest, vDtMovimFCC : TDate;
  vInCxUsuario, vInManual : Boolean;
begin
  vCdEmpresa := itemXmlF('CD_EMPRESA', PARAM_GLB);
  vNrCtaOrigem := itemXmlF('NR_CTAORIGEM', pParams);
  vNrCtaDestino := itemXmlF('NR_CTADESTINO', pParams);
  vVlSuprimento := itemXmlF('VL_SUPRIMENTO', pParams);
  vInCxUsuario := itemXmlB('IN_CXUSUARIO', pParams);
  vCdTerminalDest := itemXmlF('CD_TERMINALDEST', pParams);
  vDtAberturaDest := itemXml('DT_ABERTURADEST', pParams);
  vNrSeqDest := itemXmlF('NR_SEQDEST', pParams);
  vDsObs := itemXml('DS_OBS', pParams);
  vTpProcesso := itemXmlF('TP_PROCESSO', pParams);
  if (vInCxUsuario = True) then begin
    vCdTerminal := itemXmlF('CD_TERMINAL', pParams);
    vDtAbertura := itemXml('DT_ABERTURA', pParams);
    vNrSeq := itemXmlF('NR_SEQ', pParams);
  end;

  vTpDocumento := itemXmlF('TP_DOCUMENTO', pParams);
  vNrSeqHistRelSub := itemXmlF('NR_SEQHISTRELSUB', pParams);
  vInManual := itemXmlB('IN_MANUAL', pParams);

  if (vTpDocumento = '')  or (vTpDocumento = 0) then begin
    vTpDocumento := 3;
  end;
  if (vNrSeqHistRelSub = '')  or (vNrSeqHistRelSub = 0) then begin
    vNrSeqHistRelSub := 1;
  end;
  if (vCdEmpresa = 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN001', 'Empresa não informada!', cDS_METHOD);
    return(-1); exit;
  end;

  getParams(pParams); (* vCdEmpresa, xCdErro, xCtxErro *)
  if (xStatus < 0) then begin
    Result := voParams;
    return(-1); exit;
  end;
  if (gInLogMovCtaPes = True)  and ((vTpProcesso = '')  or (vTpProcesso = 0)) then begin
    Result := SetStatus(STS_ERROR, 'GEN001', 'Tipo de processo não informado!', cDS_METHOD);
    return(-1); exit;
  end;
  if (vVlSuprimento > 0) then begin
    viParams := '';
    voParams := activateCmp('FCCSVCO017', 'getNumMovRel', viParams);
    if (xStatus < 0) then begin
      Result := voParams;
      return(-1); exit;
    end;
    vNrSeqMovRel := itemXmlF('NR_SEQMOVREL', voParams);

    if (gInLogMovCtaPes = True) then begin
      viParams := '';
      putitemXml(viParams, 'NR_CTAPES', vNrCtaDestino);
      putitemXml(viParams, 'DT_SALDO', itemXml('DT_SISTEMA', PARAM_GLB));
      voParams := activateCmp('FCCSVCO002', 'buscaSaldoConta', viParams);
      if (xStatus < 0) then begin
        Result := voParams;
        return(-1); exit;
      end;
      vVlSaldoAnt := itemXmlF('VL_SALDO', voParams);

      viParams := '';
      putitemXml(viParams, 'NR_CTAPES', vNrCtaDestino);
      putitemXml(viParams, 'TP_DOCUMENTO', vTpDocumento);
      putitemXml(viParams, 'NR_SEQHISTRELSUB', vNrSeqHistRelSub);
      putitemXml(viParams, 'DT_SALDO', itemXml('DT_SISTEMA', PARAM_GLB));
      voParams := activateCmp('FCCSVCO002', 'buscaSaldoCtaTp', viParams);
      if (xStatus < 0) then begin
        Result := voParams;
        return(-1); exit;
      end;
      vVlSaldoAntDoc := itemXmlF('VL_SALDO', voParams);
    end;

    viParams := '';
    putitemXml(viParams, 'CD_EMPRESA', vCdEmpresa);
    putitemXml(viParams, 'NR_CTAPES', vNrCtaDestino);
    putitemXml(viParams, 'DT_MOVIMENTO', itemXml('DT_SISTEMA', PARAM_GLB));

        if (vInManual = True) then begin
      putitemXml(viParams, 'CD_HISTORICO', 837);
    end else begin
      putitemXml(viParams, 'CD_HISTORICO', 1112);
    end;

    putitemXml(viParams, 'IN_CAIXA', True);
    putitemXml(viParams, 'CD_TERMINAL', vCdTerminalDest);
    putitemXml(viParams, 'DT_ABERTURA', vDtAberturaDest);
    putitemXml(viParams, 'NR_SEQCAIXA', vNrSeqDest);
    putitemXml(viParams, 'TP_DOCUMENTO', vTpDocumento);
    putitemXml(viParams, 'NR_SEQHISTRELSUB', vNrSeqHistRelSub);
    putitemXml(viParams, 'VL_LANCTO', vVlSuprimento);
    putitemXml(viParams, 'IN_ESTORNO', False);
    putitemXml(viParams, 'DS_DOC', '');
    putitemXml(viParams, 'DS_AUX', 'CTA ORIG.: ' + FloatToStr(vNrCtaOrigem')) + ';
    putitemXml(viParams, 'DS_OBS', vDsObs);

    if (vNrSeqMovRel > 0) then begin
      putitemXml(viParams, 'NR_SEQMOVREL', vNrSeqMovRel);
    end;

    voParams := activateCmp('FCCSVCO002', 'movimentaConta', viParams);
    if (xStatus < 0) then begin
      Result := voParams;
      return(-1); exit;
    end;
    if (gInLogMovCtaPes = True) then begin
      vNrCtaPesFCC := itemXmlF('NR_CTAPES', voParams);
      vDtMovimFCC := itemXml('DT_MOVIM', voParams);
      vNrSeqMovFCC := itemXmlF('NR_SEQMOV', voParams);

      viParams := '';
      putitemXml(viParams, 'NR_CTAPES', vNrCtaDestino);
      putitemXml(viParams, 'DT_SALDO', itemXml('DT_SISTEMA', PARAM_GLB));
      voParams := activateCmp('FCCSVCO002', 'buscaSaldoConta', viParams);
      if (xStatus < 0) then begin
        Result := voParams;
        return(-1); exit;
      end;
      vVlSaldoAtual := itemXmlF('VL_SALDO', voParams);

      viParams := '';
      putitemXml(viParams, 'NR_CTAPES', vNrCtaDestino);
      putitemXml(viParams, 'TP_DOCUMENTO', vTpDocumento);
      putitemXml(viParams, 'NR_SEQHISTRELSUB', vNrSeqHistRelSub);
      putitemXml(viParams, 'DT_SALDO', itemXml('DT_SISTEMA', PARAM_GLB));
      voParams := activateCmp('FCCSVCO002', 'buscaSaldoCtaTp', viParams);
      if (xStatus < 0) then begin
        Result := voParams;
        return(-1); exit;
      end;
      vVlSaldoAtualDoc := itemXmlF('VL_SALDO', voParams);

      viParams := '';
      putitemXml(viParams, 'TP_PROCESSO', vTpProcesso);
      putitemXml(viParams, 'TP_DOCUMENTO', vTpDocumento);
      putitemXml(viParams, 'NR_CTAPES', vNrCtaDestino);
      putitemXml(viParams, 'VL_LANCAMENTO', vVlSuprimento);
      putitemXml(viParams, 'VL_SALDODOC', vVlSaldoAtualDoc);
      putitemXml(viParams, 'VL_SALDOCTA', vVlSaldoAtual);
      putitemXml(viParams, 'VL_SALDOANTDOC', vVlSaldoAntDoc);
      putitemXml(viParams, 'VL_SALDOANTCTA', vVlSaldoAnt);
      putitemXml(viParams, 'NR_CTAPESFCC', vNrCtaPesFCC);
      putitemXml(viParams, 'DT_MOVIMFCC', vDtMovimFCC);
      putitemXml(viParams, 'NR_SEQMOVFCC', vNrSeqMovFCC);
      voParams := activateCmp('FCCSVCO018', 'gravarLogMovtoCtaPes', viParams);
      if (xStatus < 0) then begin
        Result := voParams;
        return(-1); exit;
      end;
    end;
    if (gInLogMovCtaPes = True) then begin
      viParams := '';
      putitemXml(viParams, 'NR_CTAPES', vNrCtaOrigem);
      putitemXml(viParams, 'DT_SALDO', itemXml('DT_SISTEMA', PARAM_GLB));
      voParams := activateCmp('FCCSVCO002', 'buscaSaldoConta', viParams);
      if (xStatus < 0) then begin
        Result := voParams;
        return(-1); exit;
      end;
      vVlSaldoAnt := itemXmlF('VL_SALDO', voParams);

      viParams := '';
      putitemXml(viParams, 'NR_CTAPES', vNrCtaOrigem);
      putitemXml(viParams, 'TP_DOCUMENTO', vTpDocumento);
      putitemXml(viParams, 'NR_SEQHISTRELSUB', vNrSeqHistRelSub);
      putitemXml(viParams, 'DT_SALDO', itemXml('DT_SISTEMA', PARAM_GLB));
      voParams := activateCmp('FCCSVCO002', 'buscaSaldoCtaTp', viParams);
      if (xStatus < 0) then begin
        Result := voParams;
        return(-1); exit;
      end;
      vVlSaldoAntDoc := itemXmlF('VL_SALDO', voParams);
    end;

    viParams := '';
    putitemXml(viParams, 'CD_EMPRESA', vCdEmpresa);
    putitemXml(viParams, 'NR_CTAPES', vNrCtaOrigem);
    putitemXml(viParams, 'DT_MOVIMENTO', itemXml('DT_SISTEMA', PARAM_GLB));

        if (vInManual = True) then begin
      putitemXml(viParams, 'CD_HISTORICO', 838);
    end else begin
      putitemXml(viParams, 'CD_HISTORICO', 1113);
    end;

    putitemXml(viParams, 'VL_LANCTO', vVlSuprimento);
    putitemXml(viParams, 'TP_DOCUMENTO', vTpDocumento);
    putitemXml(viParams, 'NR_SEQHISTRELSUB', vNrSeqHistRelSub);
    putitemXml(viParams, 'IN_ESTORNO', False);

    if (vInCxUsuario = False) then begin
      putitemXml(viParams, 'IN_CAIXA', False);
    end else begin
      putitemXml(viParams, 'IN_CAIXA', True);
      putitemXml(viParams, 'CD_TERMINAL', vCdTerminal);
      putitemXml(viParams, 'DT_ABERTURA', vDtAbertura);
      putitemXml(viParams, 'NR_SEQCAIXA', vNrSeq);
    end;
    putitemXml(viParams, 'DS_AUX', 'CTA DEST.: ' + FloatToStr(vNrCtaDestino')) + ';
    putitemXml(viParams, 'DS_OBS', vDsObs);

    if (vNrSeqMovRel > 0) then begin
      putitemXml(viParams, 'NR_SEQMOVREL', vNrSeqMovRel);
    end;

    voParams := activateCmp('FCCSVCO002', 'movimentaConta', viParams);
    if (xStatus < 0) then begin
      Result := voParams;
      return(-1); exit;
    end;
    if (gInLogMovCtaPes = True) then begin
      vNrCtaPesFCC := itemXmlF('NR_CTAPES', voParams);
      vDtMovimFCC := itemXml('DT_MOVIM', voParams);
      vNrSeqMovFCC := itemXmlF('NR_SEQMOV', voParams);

      viParams := '';
      putitemXml(viParams, 'NR_CTAPES', vNrCtaOrigem);
      putitemXml(viParams, 'DT_SALDO', itemXml('DT_SISTEMA', PARAM_GLB));
      voParams := activateCmp('FCCSVCO002', 'buscaSaldoConta', viParams);
      if (xStatus < 0) then begin
        Result := voParams;
        return(-1); exit;
      end;
      vVlSaldoAtual := itemXmlF('VL_SALDO', voParams);

      viParams := '';
      putitemXml(viParams, 'NR_CTAPES', vNrCtaOrigem);
      putitemXml(viParams, 'TP_DOCUMENTO', vTpDocumento);
      putitemXml(viParams, 'NR_SEQHISTRELSUB', vNrSeqHistRelSub);
      putitemXml(viParams, 'DT_SALDO', itemXml('DT_SISTEMA', PARAM_GLB));
      voParams := activateCmp('FCCSVCO002', 'buscaSaldoCtaTp', viParams);
      if (xStatus < 0) then begin
        Result := voParams;
        return(-1); exit;
      end;
      vVlSaldoAtualDoc := itemXmlF('VL_SALDO', voParams);

      viParams := '';
      putitemXml(viParams, 'TP_PROCESSO', vTpProcesso);
      putitemXml(viParams, 'TP_DOCUMENTO', vTpDocumento);
      putitemXml(viParams, 'NR_CTAPES', vNrCtaOrigem);
      putitemXml(viParams, 'VL_LANCAMENTO', vVlSuprimento);
      putitemXml(viParams, 'VL_SALDODOC', vVlSaldoAtualDoc);
      putitemXml(viParams, 'VL_SALDOCTA', vVlSaldoAtual);
      putitemXml(viParams, 'VL_SALDOANTDOC', vVlSaldoAntDoc);
      putitemXml(viParams, 'VL_SALDOANTCTA', vVlSaldoAnt);
      putitemXml(viParams, 'NR_CTAPESFCC', vNrCtaPesFCC);
      putitemXml(viParams, 'DT_MOVIMFCC', vDtMovimFCC);
      putitemXml(viParams, 'NR_SEQMOVFCC', vNrSeqMovFCC);
      voParams := activateCmp('FCCSVCO018', 'gravarLogMovtoCtaPes', viParams);
      if (xStatus < 0) then begin
        Result := voParams;
        return(-1); exit;
      end;
    end;
  end;

  return(0); exit;
end;

//-----------------------------------------------------------
function T_FCXSVCO002.gravaCaixaC(pParams : String) : String;
//-----------------------------------------------------------
const
  cDS_METHOD = 'ADICONAL=Operação: T_FCXSVCO002.gravaCaixaC()';
var
  vCdEmpresa, vCdTerminal, vNrSeq, vVlFundo : Real;
  vDtAbertura : TDate;
  vInDiferenca : Boolean;
begin
  vCdEmpresa := itemXmlF('CD_EMPRESA', pParams);
  vCdTerminal := itemXmlF('CD_TERMINAL', pParams);
  vNrSeq := itemXmlF('NR_SEQ', pParams);
  vDtAbertura := itemXml('DT_ABERTURA', pParams);
  vInDiferenca := itemXmlB('IN_DIFERENCA', pParams);
  vVlFundo := itemXmlF('VL_FUNDO', pParams);

  clear_e(tFCX_CAIXAC);
  putitem_e(tFCX_CAIXAC, 'CD_EMPRESA', vCdEmpresa);
  putitem_e(tFCX_CAIXAC, 'CD_TERMINAL', vCdTerminal);
  putitem_e(tFCX_CAIXAC, 'DT_ABERTURA', vDtAbertura);
  putitem_e(tFCX_CAIXAC, 'NR_SEQ', vNrSeq);
  retrieve_e(tFCX_CAIXAC);
  if (xStatus >= 0) then begin
    putitem_e(tFCX_CAIXAC, 'IN_FECHADO', True);
    putitem_e(tFCX_CAIXAC, 'DT_FECHADO', Now);
    putitem_e(tFCX_CAIXAC, 'IN_DIFERENCA', vInDiferenca);

    voParams := tFCX_CAIXAC.Salvar();
    if (xStatus < 0) then begin
      Result := voParams;
      return(-1); exit;
    end;

    clear_e(tFCC_CTAPES);
    putitem_e(tFCC_CTAPES, 'NR_CTAPES', item_f('NR_CTAPES', tFCX_CAIXAC));
    retrieve_e(tFCC_CTAPES);
    if (xStatus >= 0) then begin
      putitem_e(tFCC_CTAPES, 'VL_LIMITE', vVlFundo);

      voParams := tFCC_CTAPES.Salvar();
      if (xStatus < 0) then begin
        Result := voParams;
        return(-1); exit;
      end;
    end;
  end;

  return(0); exit;
end;

//-----------------------------------------------------------
function T_FCXSVCO002.gravaCaixaI(pParams : String) : String;
//-----------------------------------------------------------
const
  cDS_METHOD = 'ADICONAL=Operação: T_FCXSVCO002.gravaCaixaI()';
var
  vCdEmpresa, vCdTerminal, vNrSeq, vTpDocumento : Real;
  vNrSeqHistRelSub, vVlSistema, vVlDif, vNrSeqItem : Real;
  vDtAbertura : TDate;
begin
  vCdEmpresa := itemXmlF('CD_EMPRESA', pParams);
  vCdTerminal := itemXmlF('CD_TERMINAL', pParams);
  vNrSeq := itemXmlF('NR_SEQ', pParams);
  vNrSeqItem := itemXmlF('NR_SEQITEM', pParams);
  vDtAbertura := itemXml('DT_ABERTURA', pParams);
  vTpDocumento := itemXmlF('TP_DOCUMENTO', pParams);
  vNrSeqHistRelSub := itemXmlF('NR_SEQHISTRELSUB', pParams);
  vVlSistema := itemXmlF('VL_SISTEMA', pParams);
  vVlDif := itemXmlF('VL_DIF', pParams);

  clear_e(tFCX_CAIXAI);
  putitem_e(tFCX_CAIXAI, 'CD_EMPRESA', vCdEmpresa);
  putitem_e(tFCX_CAIXAI, 'CD_TERMINAL', vCdTerminal);
  putitem_e(tFCX_CAIXAI, 'DT_ABERTURA', vDtAbertura);
  putitem_e(tFCX_CAIXAI, 'NR_SEQ', vNrSeq);
  putitem_e(tFCX_CAIXAI, 'TP_DOCUMENTO', vTpDocumento);
  putitem_e(tFCX_CAIXAI, 'NR_SEQHISTRELSUB', vNrSeqHistRelSub);
  retrieve_e(tFCX_CAIXAI);
  if (xStatus < 0) then begin
    vNrSeqItem := vNrSeqItem + 1;
    putitem_e(tFCX_CAIXAI, 'CD_OPERADOR', itemXmlF('CD_USUARIO', PARAM_GLB));
    putitem_e(tFCX_CAIXAI, 'DT_CADASTRO', Now);
    putitem_e(tFCX_CAIXAI, 'NR_SEQITEM', vNrSeqItem);
  end;

  putitem_e(tFCX_CAIXAI, 'VL_SISTEMA', vVlSistema);
  putitem_e(tFCX_CAIXAI, 'VL_DIFERENCA', vVlDif);

  voParams := tFCX_CAIXAI.Salvar();
  if (xStatus < 0) then begin
    Result := voParams;
    return(-1); exit;
  end;

  Result := '';
  putitemXml(Result, 'NR_SEQITEM', vNrSeqItem);

  return(0); exit;
end;

//--------------------------------------------------------------------
function T_FCXSVCO002.gravaFechamentoCaixa(pParams : String) : String;
//--------------------------------------------------------------------
const
  cDS_METHOD = 'ADICONAL=Operação: T_FCXSVCO002.gravaFechamentoCaixa()';
var
  vCdEmpresa, vNrSeqHistRelSub, vTpDocumento, vCdTerminal : Real;
  vVlFaturamento, vVlEntrada, vVlRetirada, vVlContado, vVlDif : Real;
  vDtAbertura : TDate;
begin
  vCdEmpresa := itemXmlF('CD_EMPRESA', pParams);
  vCdTerminal := itemXmlF('CD_TERMINAL', pParams);
  vDtAbertura := itemXml('DT_ABERTURA', pParams);
  vTpDocumento := itemXmlF('TP_DOCUMENTO', pParams);
  vNrSeqHistRelSub := itemXmlF('NR_SEQHISTRELSUB', pParams);
  vVlFaturamento := itemXmlF('VL_FATURAMENTO', pParams);
  vVlEntrada := itemXmlF('VL_ENTRADA', pParams);
  vVlRetirada := itemXmlF('VL_RETIRADA', pParams);
  vVlContado := itemXmlF('VL_CONTADO', pParams);
  vVlDif := itemXmlF('VL_DIF', pParams);

  if (vCdEmpresa = 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN001', 'Empresa não informada!', cDS_METHOD);
    return(-1); exit;
  end;
  if (vCdTerminal = 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN001', 'Terminal não informado!', cDS_METHOD);
    return(-1); exit;
  end;
  if (vDtAbertura = '') then begin
    Result := SetStatus(STS_ERROR, 'GEN001', 'Data de abertura não informada!', cDS_METHOD);
    return(-1); exit;
  end;
  if (vTpDocumento = 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN001', 'Tipo documento não informado!', cDS_METHOD);
    return(-1); exit;
  end;
  if (vNrSeqHistRelSub = 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN001', 'Sequência de tipo documento não informado!', cDS_METHOD);
    return(-1); exit;
  end;

  clear_e(tFCX_CAIXASALD);
  creocc(tFCX_CAIXASALD, -1);
  putitem_e(tFCX_CAIXASALD, 'CD_EMPRESA', vCdEmpresa);
  putitem_e(tFCX_CAIXASALD, 'CD_TERMINAL', vCdTerminal);
  putitem_e(tFCX_CAIXASALD, 'DT_ABERTURA', vDtAbertura);
  putitem_e(tFCX_CAIXASALD, 'TP_DOCUMENTO', vTpDocumento);
  putitem_e(tFCX_CAIXASALD, 'NR_HISTRELSUB', vNrSeqHistRelSub);
  retrieve_o(tFCX_CAIXASALD);
  if (xStatus = -7) then begin
    retrieve_x(tFCX_CAIXASALD);
  end;

  putitem_e(tFCX_CAIXASALD, 'CD_OPERADOR', itemXmlF('CD_USUARIO', PARAM_GLB));
  putitem_e(tFCX_CAIXASALD, 'DT_CADASTRO', Now);
  putitem_e(tFCX_CAIXASALD, 'VL_FATURAMENTO', item_f('VL_FATURAMENTO', tFCX_CAIXASALD) + vVlFaturamento);
  putitem_e(tFCX_CAIXASALD, 'VL_ENTRADA', item_f('VL_ENTRADA', tFCX_CAIXASALD)     + vVlEntrada);
  putitem_e(tFCX_CAIXASALD, 'VL_RETIRADA', item_f('VL_RETIRADA', tFCX_CAIXASALD)    + vVlRetirada);
  putitem_e(tFCX_CAIXASALD, 'VL_CONTADO', item_f('VL_CONTADO', tFCX_CAIXASALD)     + vVlContado);
  putitem_e(tFCX_CAIXASALD, 'VL_DIF', item_f('VL_DIF', tFCX_CAIXASALD)         + vVlDif);

  voParams := tFCX_CAIXASALD.Salvar();
  if (xStatus < 0) then begin
    Result := voParams;
    return(-1); exit;
  end;

  return(0); exit;
end;

end.
