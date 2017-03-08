unit cFCXSVCO004;

interface

(* COMPONENTES 
  ADMSVCO001 / FCCSVCO002 / FCCSVCO017 / FCCSVCO018 / 
*)        

uses
  Classes, SysUtils, Math, DB,
  cDataSetUnf;

type
  T_FCXSVCO004 = class(TComponent)
  private
    tFCX_MALOTEENV,
    tFCX_MALOTEFAT,
    tFCX_SOBRACX : TcDatasetUnf;
    function getParam(pParams : String = '') : String;
    function setEntidade(pParams : String = '') : String;
  protected
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;    
  published
    function gravarSobraCx(pParams : String = '') : String;
    function gravarMaloteSobraCx(pParams : String = '') : String;
    function gravarMovimentoSobraCx(pParams : String = '') : String;
    function buscaSobraCX(pParams : String = '') : String;
    function buscaSobraCxTpDoc(pParams : String = '') : String;
    function buscaSobraCxMalote(pParams : String = '') : String;
    function gravarMovimentoEnvioMalote(pParams : String = '') : String;
  end;

implementation

uses
  cADMSVCO001,
  cActivate, cStatus, cFuncao, cXml, dModulo;

var
  gInCxFilial,
  gInLogMovCtaPes : String;

//---------------------------------------------------------------
constructor T_FCXSVCO004.Create(AOwner: TComponent);
//---------------------------------------------------------------
begin
  inherited Create(AOwner);
  setEntidade('');
end;

//--------------------------------
destructor T_FCXSVCO004.Destroy;
//--------------------------------
begin
  inherited Destroy;
end;

//---------------------------------------------------------------
function T_FCXSVCO004.getParam(pParams : String = '') : String;
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

  gInCxFilial := itemXml('IN_UTILIZA_CXFILIAL', xParam);
  gInLogMovCtaPes := itemXml('IN_LOG_MOV_CTAPES', xParam);
  vCdEmpresa := itemXml('CD_EMPRESA', xParam);
  vCdTerminal := itemXml('CD_TERMINAL', xParam);
  vDtAbertura := itemXml('DT_ABERTURA', xParam);
  vNrCtaPes := itemXml('NR_CTAPES', xParam);
  vNrSeq := itemXml('NR_SEQ', xParam);
  vNrSeqHistRelSub := itemXml('NR_SEQHISTRELSUB', xParam);
  vTpDocumento := itemXml('TP_DOCUMENTO', xParam);
  vTpProcesso := itemXml('TP_PROCESSO', xParam);
  vTpSobra := itemXml('TP_SOBRA', xParam);
  vVlSobra := itemXml('VL_SOBRA', xParam);

  xParamEmp := '';
  putitem(xParamEmp, 'IN_LOG_MOV_CTAPES');
  putitem(xParamEmp, 'IN_UTILIZA_CXFILIAL');

  xParamEmp := T_ADMSVCO001.GetParamEmpresa(piCdEmpresa, xParamEmp);

  gInCxFilial := itemXml('IN_UTILIZA_CXFILIAL', xParamEmp);
  vCdEmpresa := itemXml('CD_EMPRESA', xParamEmp);
  vCdTerminal := itemXml('CD_TERMINAL', xParamEmp);
  vDtAbertura := itemXml('DT_ABERTURA', xParamEmp);
  vNrCtaPes := itemXml('NR_CTAPES', xParamEmp);
  vNrSeq := itemXml('NR_SEQ', xParamEmp);
  vNrSeqHistRelSub := itemXml('NR_SEQHISTRELSUB', xParamEmp);
  vTpDocumento := itemXml('TP_DOCUMENTO', xParamEmp);
  vTpProcesso := itemXml('TP_PROCESSO', xParamEmp);
  vTpSobra := itemXml('TP_SOBRA', xParamEmp);
  vVlSobra := itemXml('VL_SOBRA', xParamEmp);

end;

//---------------------------------------------------------------
function T_FCXSVCO004.setEntidade(pParams : String = '') : String;
//---------------------------------------------------------------
begin
  tFCX_MALOTEENV := TcDatasetUnf.getEntidade('FCX_MALOTEENV');
  tFCX_MALOTEFAT := TcDatasetUnf.getEntidade('FCX_MALOTEFAT');
  tFCX_SOBRACX := TcDatasetUnf.getEntidade('FCX_SOBRACX');
end;

//-------------------------------------------------------------
function T_FCXSVCO004.gravarSobraCx(pParams : String) : String;
//-------------------------------------------------------------
const
  cDS_METHOD = 'ADICONAL=Operação: T_FCXSVCO004.gravarSobraCx()';
var
  viParams, voParams, vTpSobra : String;
  vCdEmpresa, vCdTerminal, vNrCtaPes, vNrSeq, vVlSobra, vTpDocumento, vNrSeqMovRel, vVlSaldoAntDoc, vVlSaldoAnt, vNrCtaPesFCC : Real;
  vTpProcesso, vNrSeqMovFCC, vVlSaldoAtualDoc, vVlSaldoAtual, vNrSeqHistRelSub : Real;
  vDtAbertura, vDtMovimFCC : TDate;
begin
  vCdEmpresa := itemXmlF('CD_EMPRESA', pParams);
  vCdTerminal := itemXmlF('CD_TERMINAL', pParams);
  vDtAbertura := itemXml('DT_ABERTURA', pParams);
  vNrSeq := itemXmlF('NR_SEQ', pParams);
  vTpDocumento := itemXmlF('TP_DOCUMENTO', pParams);
  vNrSeqHistRelSub := itemXmlF('NR_SEQHISTRELSUB', pParams);
  vVlSobra := itemXmlF('VL_SOBRA', pParams);
  vTpSobra := itemXmlF('TP_SOBRA', pParams);
  vNrCtaPes := itemXmlF('NR_CTAPES', pParams);
  vTpProcesso := itemXmlF('TP_PROCESSO', pParams);

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
  if (vNrSeq = 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN001', 'Sequência de abertura não informada!', cDS_METHOD);
    return(-1); exit;
  end;
  if (vTpDocumento = 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN001', 'Tipo de documento não informado!', cDS_METHOD);
    return(-1); exit;
  end;
  if (vNrSeqHistRelSub = 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN001', 'Sub item do tipo de documento não informado!', cDS_METHOD);
    return(-1); exit;
  end;
  if (vVlSobra = 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN001', 'Valor de sobra não informado!', cDS_METHOD);
    return(-1); exit;
  end;
  if (vTpSobra = '') then begin
    Result := SetStatus(STS_ERROR, 'GEN001', 'Tipo de sobra não informado!', cDS_METHOD);
    return(-1); exit;
  end;

  getParams(pParams); (* vCdEmpresa *)
  if (xStatus < 0) then begin
    Result := voParams;
    return(-1); exit;
  end;
  if (gInLogMovCtaPes = True)  and ((vTpProcesso = '')  or (vTpProcesso = 0)) then begin
    Result := SetStatus(STS_ERROR, 'GEN001', 'Tipo de processo não informado!', cDS_METHOD);
    return(-1); exit;
  end;

  clear_e(tFCX_SOBRACX);
  creocc(tFCX_SOBRACX, -1);
  putitem_e(tFCX_SOBRACX, 'CD_EMPRESA', vCdEmpresa);
  putitem_e(tFCX_SOBRACX, 'CD_TERMINAL', vCdTerminal);
  putitem_e(tFCX_SOBRACX, 'DT_ABERTURA', vDtAbertura);
  putitem_e(tFCX_SOBRACX, 'NR_SEQ', vNrSeq);
  putitem_e(tFCX_SOBRACX, 'TP_DOCUMENTO', vTpDocumento);
  putitem_e(tFCX_SOBRACX, 'NR_SEQHISTRELSUB', vNrSeqHistRelSub);
  retrieve_o(tFCX_SOBRACX);
  if (xStatus = -7) then begin
    retrieve_x(tFCX_SOBRACX);
  end;

  putitem_e(tFCX_SOBRACX, 'CD_OPERADOR', itemXmlF('CD_USUARIO', PARAM_GLB));
  putitem_e(tFCX_SOBRACX, 'DT_CADASTRO', Now);
  putitem_e(tFCX_SOBRACX, 'VL_SOBRACX', vVlSobra);
  putitem_e(tFCX_SOBRACX, 'TP_SOBRACX', vTpSobra);

  if (gInCxFilial = False) then begin
    viParams := '';
    voParams := activateCmp('FCCSVCO017', 'getNumMovRel', viParams);
    if (xStatus < 0) then begin
      Result := voParams;
      return(-1); exit;
    end;
    vNrSeqMovRel := itemXmlF('NR_SEQMOVREL', voParams);

    if (gInLogMovCtaPes = True) then begin
      viParams := '';
      putitemXml(viParams, 'NR_CTAPES', vNrCtaPes);
      putitemXml(viParams, 'DT_SALDO', itemXml('DT_SISTEMA', PARAM_GLB));
      voParams := activateCmp('FCCSVCO002', 'buscaSaldoConta', viParams);
      if (xStatus < 0) then begin
        Result := voParams;
        return(-1); exit;
      end;
      vVlSaldoAnt := itemXmlF('VL_SALDO', voParams);

      viParams := '';
      putitemXml(viParams, 'NR_CTAPES', vNrCtaPes);
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
    putitemXml(viParams, 'NR_CTAPES', vNrCtaPes);
    putitemXml(viParams, 'DT_MOVIMENTO', itemXml('DT_SISTEMA', PARAM_GLB));
    if (vTpSobra = 'C') then begin
      putitemXml(viParams, 'CD_HISTORICO', 1038);
    end else begin
      putitemXml(viParams, 'CD_HISTORICO', 1039);
    end;
    putitemXml(viParams, 'TP_DOCUMENTO', vTpDocumento);
    putitemXml(viParams, 'NR_SEQHISTRELSUB', vNrSeqHistRelSub);
    putitemXml(viParams, 'VL_LANCTO', vVlSobra);
    putitemXml(viParams, 'IN_ESTORNO', False);

    if (vNrSeqMovRel > 0) then begin
      putitemXml(viParams, 'NR_SEQMOVREL', vNrSeqMovRel);
    end;

    voParams := activateCmp('FCCSVCO002', 'movimentaConta', viParams);
    if (xStatus < 0) then begin
      Result := voParams;
      return(-1); exit;
    end;

    putitem_e(tFCX_SOBRACX, 'NR_CTAPES', vNrCtaPes);
    putitem_e(tFCX_SOBRACX, 'DT_MOVIM', itemXml('DT_MOVIM', voParams));
    putitem_e(tFCX_SOBRACX, 'NR_SEQMOV', itemXmlF('NR_SEQMOV', voParams));

    if (gInLogMovCtaPes = True) then begin
      vNrCtaPesFCC := itemXmlF('NR_CTAPES', voParams);
      vDtMovimFCC := itemXml('DT_MOVIM', voParams);
      vNrSeqMovFCC := itemXmlF('NR_SEQMOV', voParams);

      viParams := '';
      putitemXml(viParams, 'NR_CTAPES', vNrCtaPes);
      putitemXml(viParams, 'DT_SALDO', itemXml('DT_SISTEMA', PARAM_GLB));
      voParams := activateCmp('FCCSVCO002', 'buscaSaldoConta', viParams);
      if (xStatus < 0) then begin
        Result := voParams;
        return(-1); exit;
      end;
      vVlSaldoAtual := itemXmlF('VL_SALDO', voParams);

      viParams := '';
      putitemXml(viParams, 'NR_CTAPES', vNrCtaPes);
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
      putitemXml(viParams, 'NR_CTAPES', vNrCtaPes);
      putitemXml(viParams, 'VL_LANCAMENTO', vVlSobra);
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

  voParams := tFCX_SOBRACX.Salvar();
  if (xStatus < 0) then begin
    Result := voParams;
    return(-1); exit;
  end;

  return(0); exit;
end;

//-------------------------------------------------------------------
function T_FCXSVCO004.gravarMaloteSobraCx(pParams : String) : String;
//-------------------------------------------------------------------
const
  cDS_METHOD = 'ADICONAL=Operação: T_FCXSVCO004.gravarMaloteSobraCx()';
var
  viParams, voParams, vTpSobra : String;
  vCdEmpresa, vCdTerminal, vNrSeq, vTpDocumento, vNrSeqMalote, vCdGrupoEmpresa : Real;
  vDtAbertura, vDtMalote : TDate;
begin
  vCdEmpresa := itemXmlF('CD_EMPRESA', pParams);
  vCdGrupoEmpresa := itemXmlF('CD_GRUPOEMPRESA', pParams);
  vDtMalote := itemXml('DT_MALOTE', pParams);
  vNrSeqMalote := itemXmlF('NR_SEQMALOTE', pParams);

  if (vCdEmpresa = 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN001', 'Empresa não informada!', cDS_METHOD);
    return(-1); exit;
  end;
  if (vCdGrupoEmpresa = 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN001', 'Grupo empresa não informado!', cDS_METHOD);
    return(-1); exit;
  end;
  if (vDtMalote = '') then begin
    Result := SetStatus(STS_ERROR, 'GEN001', 'Data do malote não informado!', cDS_METHOD);
    return(-1); exit;
  end;
  if (vNrSeqMalote = 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN001', 'Sequência do malote não informado!', cDS_METHOD);
    return(-1); exit;
  end;

  clear_e(tFCX_SOBRACX);
  putitem_e(tFCX_SOBRACX, 'CD_EMPRESA', vCdEmpresa);
  putitem_e(tFCX_SOBRACX, 'DT_MALOTE', '=');
  retrieve_e(tFCX_SOBRACX);
  if (xStatus >= 0) then begin
    setocc(tFCX_SOBRACX, 1);
    while (xStatus >= 0) do begin
      putitem_e(tFCX_SOBRACX, 'CD_OPERADOR', itemXmlF('CD_USUARIO', PARAM_GLB));
      putitem_e(tFCX_SOBRACX, 'DT_CADASTRO', Now);
      putitem_e(tFCX_SOBRACX, 'CD_GRUPOEMPRESA', vCdGrupoEmpresa);
      putitem_e(tFCX_SOBRACX, 'DT_MALOTE', vDtMalote);
      putitem_e(tFCX_SOBRACX, 'NR_SEQMALOTE', vNrSeqMalote);

      setocc(tFCX_SOBRACX, curocc(tFCX_SOBRACX) + 1);
    end;

    voParams := tFCX_SOBRACX.Salvar();
    if (xStatus < 0) then begin
      Result := voParams;
      return(-1); exit;
    end;
  end;

  return(0); exit;
end;

//----------------------------------------------------------------------
function T_FCXSVCO004.gravarMovimentoSobraCx(pParams : String) : String;
//----------------------------------------------------------------------
const
  cDS_METHOD = 'ADICONAL=Operação: T_FCXSVCO004.gravarMovimentoSobraCx()';
var
  viParams, voParams : String;
  vCdEmpresa, vCdTerminal, vNrCtaPes, vNrSeq, vTpDocumento, vNrSeqMovRel, vVlSaldoAntDoc, vVlSaldoAnt, vNrCtaPesFCC : Real;
  vTpProcesso, vNrSeqMovFCC, vVlSaldoAtualDoc, vVlSaldoAtual, vNrSeqHistRelSub : Real;
  vDtAbertura, vDtMovimFCC : TDate;
begin
  vCdEmpresa := itemXmlF('CD_EMPRESA', pParams);
  vCdTerminal := itemXmlF('CD_TERMINAL', pParams);
  vDtAbertura := itemXml('DT_ABERTURA', pParams);
  vNrSeq := itemXmlF('NR_SEQ', pParams);
  vTpDocumento := itemXmlF('TP_DOCUMENTO', pParams);
  vNrSeqHistRelSub := itemXmlF('NR_SEQHISTRELSUB', pParams);
  vNrCtaPes := itemXmlF('NR_CTAPES', pParams);
  vTpProcesso := itemXmlF('TP_PROCESSO', pParams);

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
  if (vNrSeq = 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN001', 'Sequência de abertura não informada!', cDS_METHOD);
    return(-1); exit;
  end;
  if (vTpDocumento = 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN001', 'Tipo de documento não informado!', cDS_METHOD);
    return(-1); exit;
  end;
  if (vNrSeqHistRelSub = 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN001', 'Sub item tipo de documento não informado!', cDS_METHOD);
    return(-1); exit;
  end;
  if (vNrCtaPes = 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN001', 'Conta não informada!', cDS_METHOD);
    return(-1); exit;
  end;

  getParams(pParams); (* vCdEmpresa *)
  if (xStatus < 0) then begin
    Result := voParams;
    return(-1); exit;
  end;
  if (gInLogMovCtaPes = True)  and ((vTpProcesso = '')  or (vTpProcesso = 0)) then begin
    Result := SetStatus(STS_ERROR, 'GEN001', 'Tipo de processo não informado!', cDS_METHOD);
    return(-1); exit;
  end;

  clear_e(tFCX_SOBRACX);
  putitem_e(tFCX_SOBRACX, 'CD_EMPRESA', vCdEmpresa);
  putitem_e(tFCX_SOBRACX, 'CD_TERMINAL', vCdTerminal);
  putitem_e(tFCX_SOBRACX, 'DT_ABERTURA', vDtAbertura);
  putitem_e(tFCX_SOBRACX, 'NR_SEQ', vNrSeq);
  putitem_e(tFCX_SOBRACX, 'TP_DOCUMENTO', vTpDocumento);
  putitem_e(tFCX_SOBRACX, 'NR_SEQHISTRELSUB', vNrSeqHistRelSub);
  retrieve_e(tFCX_SOBRACX);
  if (xStatus < 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Sobra de caixa não encontrada!', cDS_METHOD);
    return(-1); exit;
  end;

  viParams := '';
  voParams := activateCmp('FCCSVCO017', 'getNumMovRel', viParams);
  if (xStatus < 0) then begin
    Result := voParams;
    return(-1); exit;
  end;
  vNrSeqMovRel := itemXmlF('NR_SEQMOVREL', voParams);

  if (gInLogMovCtaPes = True) then begin
    viParams := '';
    putitemXml(viParams, 'NR_CTAPES', vNrCtaPes);
    putitemXml(viParams, 'DT_SALDO', itemXml('DT_SISTEMA', PARAM_GLB));
    voParams := activateCmp('FCCSVCO002', 'buscaSaldoConta', viParams);
    if (xStatus < 0) then begin
      Result := voParams;
      return(-1); exit;
    end;
    vVlSaldoAnt := itemXmlF('VL_SALDO', voParams);

    viParams := '';
    putitemXml(viParams, 'NR_CTAPES', vNrCtaPes);
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
  putitemXml(viParams, 'NR_CTAPES', vNrCtaPes);
  putitemXml(viParams, 'DT_MOVIMENTO', itemXml('DT_SISTEMA', PARAM_GLB));
  if (item_f('TP_SOBRACX', tFCX_SOBRACX) = 'C') then begin
    putitemXml(viParams, 'CD_HISTORICO', 1038);
  end else begin
    putitemXml(viParams, 'CD_HISTORICO', 1039);
  end;
  putitemXml(viParams, 'TP_DOCUMENTO', vTpDocumento);
  putitemXml(viParams, 'NR_SEQHISTRELSUB', vNrSeqHistRelSub);
  putitemXml(viParams, 'VL_LANCTO', item_f('VL_SOBRACX', tFCX_SOBRACX));
  putitemXml(viParams, 'IN_ESTORNO', False);

  if (vNrSeqMovRel > 0) then begin
    putitemXml(viParams, 'NR_SEQMOVREL', vNrSeqMovRel);
  end;

  voParams := activateCmp('FCCSVCO002', 'movimentaConta', viParams);
  if (xStatus < 0) then begin
    Result := voParams;
    return(-1); exit;
  end;

  vNrCtaPesFCC := itemXmlF('NR_CTAPES', voParams);
  vDtMovimFCC := itemXml('DT_MOVIM', voParams);
  vNrSeqMovFCC := itemXmlF('NR_SEQMOV', voParams);
  if (gInLogMovCtaPes = True) then begin
    viParams := '';
    putitemXml(viParams, 'NR_CTAPES', vNrCtaPes);
    putitemXml(viParams, 'DT_SALDO', itemXml('DT_SISTEMA', PARAM_GLB));
    voParams := activateCmp('FCCSVCO002', 'buscaSaldoConta', viParams);
    if (xStatus < 0) then begin
      Result := voParams;
      return(-1); exit;
    end;
    vVlSaldoAtual := itemXmlF('VL_SALDO', voParams);

    viParams := '';
    putitemXml(viParams, 'NR_CTAPES', vNrCtaPes);
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
    putitemXml(viParams, 'NR_CTAPES', vNrCtaPes);
    putitemXml(viParams, 'VL_LANCAMENTO', item_f('VL_SOBRACX', tFCX_SOBRACX));
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

  putitem_e(tFCX_SOBRACX, 'NR_CTAPES', vNrCtaPes);
  putitem_e(tFCX_SOBRACX, 'DT_MOVIM', vDtMovimFCC);
  putitem_e(tFCX_SOBRACX, 'NR_SEQMOV', vNrSeqMovFCC);
  putitem_e(tFCX_SOBRACX, 'CD_OPERADOR', itemXmlF('CD_USUARIO', PARAM_GLB));
  putitem_e(tFCX_SOBRACX, 'DT_CADASTRO', Now);

  voParams := tFCX_SOBRACX.Salvar();
  if (xStatus < 0) then begin
    Result := voParams;
    return(-1); exit;
  end;

  return(0); exit;
end;

//------------------------------------------------------------
function T_FCXSVCO004.buscaSobraCX(pParams : String) : String;
//------------------------------------------------------------
const
  cDS_METHOD = 'ADICONAL=Operação: T_FCXSVCO004.buscaSobraCX()';
var
  viValores : String;
  vCdEmpresa, vVlSobra : Real;
begin
  vCdEmpresa := itemXmlF('CD_EMPRESA', pParams);
  if (vCdEmpresa = 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN001', 'Empresa não informada!', cDS_METHOD);
    return(-1); exit;
  end;

  vVlSobra := 0;

  clear_e(tFCX_SOBRACX);
  putitem_e(tFCX_SOBRACX, 'CD_EMPRESA', vCdEmpresa);
  putitem_e(tFCX_SOBRACX, 'DT_MALOTE', '=');
  retrieve_e(tFCX_SOBRACX);
  if (xStatus >= 0) then begin
    setocc(tFCX_SOBRACX, 1);
    while (xStatus >= 0) do begin
      if (item_f('TP_SOBRACX', tFCX_SOBRACX) = 'C') then begin
        vVlSobra := vVlSobra + item_f('VL_SOBRACX', tFCX_SOBRACX);
      end else begin
        vVlSobra := vVlSobra - item_f('VL_SOBRACX', tFCX_SOBRACX);
      end;

      setocc(tFCX_SOBRACX, curocc(tFCX_SOBRACX) + 1);
    end;
  end;

  Result := '';
  putitemXml(Result, 'VL_SOBRA', vVlSobra);

  return(0); exit;
end;

//-----------------------------------------------------------------
function T_FCXSVCO004.buscaSobraCxTpDoc(pParams : String) : String;
//-----------------------------------------------------------------
const
  cDS_METHOD = 'ADICONAL=Operação: T_FCXSVCO004.buscaSobraCxTpDoc()';
var
  viValores : String;
  vCdEmpresa, vVlSobra, vTpDocumento, vNrSeqHistRelSub : Real;
begin
  vCdEmpresa := itemXmlF('CD_EMPRESA', pParams);
  vTpDocumento := itemXmlF('TP_DOCUMENTO', pParams);
  vNrSeqHistRelSub := itemXmlF('NR_SEQHISTRELSUB', pParams);

  if (vCdEmpresa = 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN001', 'Empresa não informada!', cDS_METHOD);
    return(-1); exit;
  end;

  vVlSobra := 0;

  clear_e(tFCX_SOBRACX);
  putitem_e(tFCX_SOBRACX, 'CD_EMPRESA', vCdEmpresa);
  putitem_e(tFCX_SOBRACX, 'DT_MALOTE', '=');
  putitem_e(tFCX_SOBRACX, 'TP_DOCUMENTO', vTpDocumento);
  putitem_e(tFCX_SOBRACX, 'NR_SEQHISTRELSUB', vNrSeqHistRelSub);
  retrieve_e(tFCX_SOBRACX);
  if (xStatus >= 0) then begin
    setocc(tFCX_SOBRACX, 1);
    while (xStatus >= 0) do begin

      if (item_f('TP_SOBRACX', tFCX_SOBRACX) = 'C') then begin
        vVlSobra := vVlSobra + item_f('VL_SOBRACX', tFCX_SOBRACX);
      end else begin
        vVlSobra := vVlSobra - item_f('VL_SOBRACX', tFCX_SOBRACX);
      end;
      setocc(tFCX_SOBRACX, curocc(tFCX_SOBRACX) + 1);
    end;
  end;

  Result := '';
  putitemXml(Result, 'VL_SOBRA', vVlSobra);

  return(0); exit;
end;

//------------------------------------------------------------------
function T_FCXSVCO004.buscaSobraCxMalote(pParams : String) : String;
//------------------------------------------------------------------
const
  cDS_METHOD = 'ADICONAL=Operação: T_FCXSVCO004.buscaSobraCxMalote()';
var
  vCdGrupoEmpresa, vNrSeqMalote, vVlSobra : Real;
  vDtMalote : TDate;
begin
  vCdGrupoEmpresa := itemXmlF('CD_GRUPOEMPRESA', pParams);
  vDtMalote := itemXml('DT_MALOTE', pParams);
  vNrSeqMalote := itemXmlF('NR_SEQMALOTE', pParams);

  if (vCdGrupoEmpresa = 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN001', 'Grupo empresa não informado!', cDS_METHOD);
    return(-1); exit;
  end;
  if (vDtMalote = '') then begin
    Result := SetStatus(STS_ERROR, 'GEN001', 'Data do malote não informado!', cDS_METHOD);
    return(-1); exit;
  end;
  if (vNrSeqMalote = 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN001', 'Sequência do malote não informado!', cDS_METHOD);
    return(-1); exit;
  end;

  vVlSobra := 0;

  clear_e(tFCX_SOBRACX);
  putitem_e(tFCX_SOBRACX, 'CD_GRUPOEMPRESA', vCdGrupoEmpresa);
  putitem_e(tFCX_SOBRACX, 'DT_MALOTE', vDtMalote);
  putitem_e(tFCX_SOBRACX, 'NR_SEQMALOTE', vNrSeqMalote);
  retrieve_e(tFCX_SOBRACX);
  if (xStatus >= 0) then begin
    setocc(tFCX_SOBRACX, 1);
    while (xStatus >= 0) do begin
      if (item_f('TP_SOBRACX', tFCX_SOBRACX) = 'C') then begin
        vVlSobra := vVlSobra + item_f('VL_SOBRACX', tFCX_SOBRACX);
      end else begin
        vVlSobra := vVlSobra - item_f('VL_SOBRACX', tFCX_SOBRACX);
      end;

      setocc(tFCX_SOBRACX, curocc(tFCX_SOBRACX) + 1);
    end;
  end;

  Result := '';
  putitemXml(Result, 'VL_SOBRA', vVlSobra);

  return(0); exit;
end;

//--------------------------------------------------------------------------
function T_FCXSVCO004.gravarMovimentoEnvioMalote(pParams : String) : String;
//--------------------------------------------------------------------------
const
  cDS_METHOD = 'ADICONAL=Operação: T_FCXSVCO004.gravarMovimentoEnvioMalote()';
var
  viParams, voParams, vLstDocumentos, vDsRegistros : String;
  vCdGrupoEmpresa, vNrCtaPes, vTpDocumento, vNrSeqHistRelSub, vNrSeqMalote, vVlSaldo, vVlEnvio : Real;
  vDtMovimento : TDate;
begin
  vCdGrupoEmpresa := itemXmlF('CD_GRUPOEMPRESA', pParams);
  vNrCtaPes := itemXmlF('NR_CTAPES', pParams);
  vDtMovimento := itemXml('DT_MOVIMENTO', pParams);
  vTpDocumento := itemXmlF('TP_DOCUMENTO', pParams);
  vNrSeqHistRelSub := itemXmlF('NR_SEQHISTRELSUB', pParams);
  vNrSeqMalote := itemXmlF('NR_SEQMALOTE', pParams);
  vVlSaldo := itemXmlF('VL_SALDO', pParams);
  vVlEnvio := itemXmlF('VL_ENVIO', pParams);
  vLstDocumentos := itemXml('LST_DOCUMENTOS', pParams);
  if (vCdGrupoEmpresa = 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Grupo Empresa não informado!', cDS_METHOD);
    return(-1); exit;
  end;
  if (vNrCtaPes = 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN001', 'Conta não informada!', cDS_METHOD);
    return(-1); exit;
  end;
  if (vDtMovimento = '') then begin
    Result := SetStatus(STS_ERROR, 'GEN001', 'Data de movimento não informada!', cDS_METHOD);
    return(-1); exit;
  end;
  if (vTpDocumento = 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN001', 'Tipo de documento não informado!', cDS_METHOD);
    return(-1); exit;
  end;
  if (vNrSeqHistRelSub = 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN001', 'Sequência de histórico não informado!', cDS_METHOD);
    return(-1); exit;
  end;

  clear_e(tFCX_MALOTEENV);
  creocc(tFCX_MALOTEENV, -1);
  putitem_e(tFCX_MALOTEENV, 'CD_GRUPOEMPRESA', vCdGrupoEmpresa);
  putitem_e(tFCX_MALOTEENV, 'NR_CTAPES', vNrCtaPes);
  putitem_e(tFCX_MALOTEENV, 'DT_MOVIMENTO', vDtMovimento);
  putitem_e(tFCX_MALOTEENV, 'TP_DOCUMENTO', vTpDocumento);
  putitem_e(tFCX_MALOTEENV, 'NR_SEQHISTRELSUB', vNrSeqHistRelSub);
  putitem_e(tFCX_MALOTEENV, 'NR_SEQMALOTE', vNrSeqMalote);
  retrieve_o(tFCX_MALOTEENV);
  if (xStatus = -7) then begin
    retrieve_x(tFCX_MALOTEENV);
    putitem_e(tFCX_MALOTEENV, 'VL_ENVIO', item_f('VL_ENVIO', tFCX_MALOTEENV) + vVlEnvio);
  end else begin
    putitem_e(tFCX_MALOTEENV, 'VL_SALDO', vVlSaldo);
    putitem_e(tFCX_MALOTEENV, 'VL_ENVIO', vVlEnvio);
  end;
  if (item_f('VL_ENVIO', tFCX_MALOTEENV) = '') then begin
    putitem_e(tFCX_MALOTEENV, 'VL_ENVIO', 0);
  end;
  if (item_f('VL_SALDO', tFCX_MALOTEENV) = '') then begin
    putitem_e(tFCX_MALOTEENV, 'VL_SALDO', 0);
  end;
  putitem_e(tFCX_MALOTEENV, 'CD_OPERADOR', itemXmlF('CD_USUARIO', PARAM_GLB));
  putitem_e(tFCX_MALOTEENV, 'DT_CADASTRO', Now);

  voParams := tFCX_MALOTEENV.Salvar();
  if (xStatus < 0) then begin
    Result := voParams;
    return(-1); exit;
  end;
  if (vLstDocumentos <> '') then begin
    repeat
      getitem(vDsRegistros, vLstDocumentos, 1);
      creocc(tFCX_MALOTEFAT, -1);
      putitem_e(tFCX_MALOTEFAT, 'CD_GRUPOEMPRESA', vCdGrupoEmpresa);
      putitem_e(tFCX_MALOTEFAT, 'NR_CTAPES', vNrCtaPes);
      putitem_e(tFCX_MALOTEFAT, 'DT_MOVIMENTO', vDtMovimento);
      putitem_e(tFCX_MALOTEFAT, 'TP_DOCUMENTO', vTpDocumento);
      putitem_e(tFCX_MALOTEFAT, 'NR_SEQHISTRELSUB', vNrSeqHistRelSub);
      putitem_e(tFCX_MALOTEFAT, 'NR_SEQMALOTE', vNrSeqMalote);
      putitem_e(tFCX_MALOTEFAT, 'CD_EMPRESA', itemXmlF('CD_EMPRESA', vDsRegistros));
      putitem_e(tFCX_MALOTEFAT, 'CD_CLIENTE', itemXmlF('CD_CLIENTE', vDsRegistros));
      putitem_e(tFCX_MALOTEFAT, 'NR_FAT', itemXmlF('NR_FAT', vDsRegistros));
      putitem_e(tFCX_MALOTEFAT, 'NR_PARCELA', itemXmlF('NR_PARCELA', vDsRegistros));
      putitem_e(tFCX_MALOTEFAT, 'DT_CADASTRO', itemXml('DT_SISTEMA', PARAM_GLB));
      putitem_e(tFCX_MALOTEFAT, 'CD_OPERADOR', itemXmlF('CD_USUARIO', PARAM_GLB));
      voParams := tFCX_MALOTEFAT.Salvar();
      if (xStatus < 0) then begin
        Result := voParams;
        return(-1); exit;
      end;
      delitem(vLstDocumentos, 1);
    until (vLstDocumentos = '');
  end;

  return(0); exit;
end;

end.
