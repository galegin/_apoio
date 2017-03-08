unit cSICSVCO007;

interface

(* COMPONENTES 
  ADMSVCO001 / FCCSVCO002 / FCCSVCO017 / FCCSVCO018 / SICSVCO009

*)        

uses
  Classes, SysUtils, DB,
  cServiceUnf, cDataSetUnf;

type
  T_SICSVCO007 = class(TcServiceUnf)
  private
    tADM_USUARIO,
    tFCC_CTAPES,
    tFCC_MOV,
    tFCX_CAIXAC,
    tFCX_CAIXAM,
    tFCX_HISTREL,
    tFCX_TERMINALU,
    tGER_EMPRESA,
    tGER_TERMINAL : TcDatasetUnf;
    function getParam(pParams : String = '') : String;
    function setEntidade(pParams : String = '') : String;
  protected
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;    
  published
    function validaAberturaCaixa(pParams : String = '') : String;
    function validaFechamentoCaixa(pParams : String = '') : String;
    function validaCaixa(pParams : String = '') : String;
    function carregaTerminal(pParams : String = '') : String;
    function descricaoTerminal(pParams : String = '') : String;
    function carregaTodoTerminal(pParams : String = '') : String;
    function validaRetiradaCaixa(pParams : String = '') : String;
  end;

implementation

uses
  cADMSVCO001,
  cActivate, cStatus, cFuncao, cXml, dModulo;

var
  gCdTpManutCxUsuario,
  gcxFilial,
  gcxMatriz,
  gInCxFilial,
  gInLogMovCtaPes,
  gInUsuTerm,
  gTpLanctoFundoCx,
  gTpNomeCxUsuario : String;

//---------------------------------------------------------------
constructor T_SICSVCO007.Create(AOwner: TComponent);
//---------------------------------------------------------------
begin
  inherited Create(AOwner);
  setEntidade('');
end;

//--------------------------------
destructor T_SICSVCO007.Destroy;
//--------------------------------
begin
  inherited Destroy;
end;

//---------------------------------------------------------------
function T_SICSVCO007.getParam(pParams : String = '') : String;
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
  putitem(xParam, 'CD_TPMANUT_CXUSUARIO');
  putitem(xParam, 'IN_LOG_MOV_CTAPES');
  putitem(xParam, 'TP_NOME_CXUSUARIO');

  xParam := T_ADMSVCO001.GetParametro(xParam);

  gCdTpManutCxUsuario := itemXml('CD_TPMANUT_CXUSUARIO', xParam);
  gcxFilial := itemXml('CD_CTAPES_CXFILIAL', xParam);
  gcxMatriz := itemXml('CD_CTAPES_CXMATRIZ', xParam);
  gInCxFilial := itemXml('IN_UTILIZA_CXFILIAL', xParam);
  gInLogMovCtaPes := itemXml('IN_LOG_MOV_CTAPES', xParam);
  gInUsuTerm := itemXml('IN_VALIDA_USUTERM', xParam);
  gTpNomeCxUsuario := itemXml('TP_NOME_CXUSUARIO', xParam);

  xParamEmp := '';
  putitem(xParamEmp, 'CD_CTAPES_CXFILIAL');
  putitem(xParamEmp, 'CD_CTAPES_CXMATRIZ');
  putitem(xParamEmp, 'CD_EMPRESA');
  putitem(xParamEmp, 'CD_HISTORICO');
  putitem(xParamEmp, 'CD_OPERADOR');
  putitem(xParamEmp, 'CD_TERMINAL');
  putitem(xParamEmp, 'CD_TPMANUT_CXUSUARIO');
  putitem(xParamEmp, 'DS_AUX');
  putitem(xParamEmp, 'DS_DOC');
  putitem(xParamEmp, 'DT_ABERTURA');
  putitem(xParamEmp, 'DT_CADASTRO');
  putitem(xParamEmp, 'DT_MOVIMENTO');
  putitem(xParamEmp, 'IN_CAIXA');
  putitem(xParamEmp, 'IN_ESTORNO');
  putitem(xParamEmp, 'IN_FECHADO');
  putitem(xParamEmp, 'IN_LOG_MOV_CTAPES');
  putitem(xParamEmp, 'IN_UTILIZA_CXFILIAL');
  putitem(xParamEmp, 'IN_VALIDA_USUTERM');
  putitem(xParamEmp, 'NR_CTAPES');
  putitem(xParamEmp, 'NR_SEQCAIXA');
  putitem(xParamEmp, 'NR_SEQHISTRELSUB');
  putitem(xParamEmp, 'NR_SEQMOVREL');
  putitem(xParamEmp, 'TP_DOCUMENTO');
  putitem(xParamEmp, 'TP_LANCAMENTO_FUNDO_CX');
  putitem(xParamEmp, 'TP_NOME_CXUSUARIO');
  putitem(xParamEmp, 'VL_LANCTO');

  xParamEmp := T_ADMSVCO001.GetParamEmpresa(piCdEmpresa, xParamEmp);

  gcxFilial := itemXml('CD_CTAPES_CXFILIAL', xParamEmp);
  gcxMatriz := itemXml('CD_CTAPES_CXMATRIZ', xParamEmp);
  gInCxFilial := itemXml('IN_UTILIZA_CXFILIAL', xParamEmp);
  gInUsuTerm := itemXml('IN_VALIDA_USUTERM', xParamEmp);
  gTpLanctoFundoCx := itemXml('TP_LANCAMENTO_FUNDO_CX', xParamEmp);

end;

//---------------------------------------------------------------
function T_SICSVCO007.setEntidade(pParams : String = '') : String;
//---------------------------------------------------------------
begin
  tADM_USUARIO := GetEntidade('ADM_USUARIO');
  tFCC_CTAPES := GetEntidade('FCC_CTAPES');
  tFCC_MOV := GetEntidade('FCC_MOV');
  tFCX_CAIXAC := GetEntidade('FCX_CAIXAC');
  tFCX_CAIXAM := GetEntidade('FCX_CAIXAM');
  tFCX_HISTREL := GetEntidade('FCX_HISTREL');
  tFCX_TERMINALU := GetEntidade('FCX_TERMINALU');
  tGER_EMPRESA := GetEntidade('GER_EMPRESA');
  tGER_TERMINAL := GetEntidade('GER_TERMINAL');
end;

//-------------------------------------------------------------------
function T_SICSVCO007.validaAberturaCaixa(pParams : String) : String;
//-------------------------------------------------------------------
const
  cDS_METHOD = 'ADICIONAL=Operação: T_SICSVCO007.validaAberturaCaixa()';
var
  viParams, voParams : String;
  vCdEmpresa, vCdOperCx, vCdTerminal, vNrCtaPes, vCdEmpresaCC, vCxFilial, vVlAbertura, vCdCCusto, vNrSeqMovRel : Real;
  vCxMatriz, vNrCtaPesFundo, vCdEmpresaFundo, vNrCtaPesAux, vCdEmpPrincipal : Real;
  vInCxFilial : Boolean;
  vDtAbertura : TDate;
begin
  vCdEmpresa := itemXmlF('CD_EMPRESA', pParams);
  vCdTerminal := itemXmlF('CD_TERMINAL', pParams);
  vDtAbertura := itemXml('DT_ABERTURA', pParams);
  vCdOperCx := itemXmlF('CD_OPERCX', pParams);

  vNrCtaPesFundo := itemXmlF('NR_CTAPESFUNDO', pParams);
  vCdEmpresaFundo := itemXmlF('CD_EMPRESAFUNDO', pParams);

  vVlAbertura := itemXmlF('VL_ABERTURA', pParams);

  if (vCdEmpresa = 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Empresa não informada!', cDS_METHOD);
    return(-1); exit;
  end;
  if (vCdTerminal = 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Terminal não informado!', cDS_METHOD);
    return(-1); exit;
  end;
  if (vDtAbertura = 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Data de abertura não informada!', cDS_METHOD);
    return(-1); exit;
  end;

  clear_e(tGER_EMPRESA);
  putitem_e(tGER_EMPRESA, 'CD_EMPRESA', vCdEmpresa);
  retrieve_e(tGER_EMPRESA);
  if (xStatus < 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Empresa ' + FloatToStr(vCdEmpresa) + ' não cadastrada!', cDS_METHOD);
    return(-1); exit;
  end;

  putitem(xParamEmp,  'TP_LANCAMENTO_FUNDO_CX');
  xParamEmp := T_ADMSVCO001.GetParamEmpresa(piCdEmpresa, xParamEmp); (*itemXml('CD_EMPRESA', *)
  gTpLanctoFundoCx := itemXmlF('TP_LANCAMENTO_FUNDO_CX', xParamEmp);

  if (item_f('CD_CCUSTO', tGER_EMPRESA) > 0) then begin
    vCdEmpresaCC := item_f('CD_CCUSTO', tGER_EMPRESA);
  end else begin
    clear_e(tGER_EMPRESA);
    putitem_e(tGER_EMPRESA, 'CD_CCUSTO', vCdEmpresa);
    retrieve_e(tGER_EMPRESA);
    if (xStatus >= 0) then begin
      vCdEmpresaCC := item_f('CD_EMPRESA', tGER_EMPRESA);
      vCdEmpPrincipal := vCdEmpresa;
    end else begin
      return(0); exit;
    end;
  end;

  viParams := '';
  putitemXml(viParams, 'CD_EMPRESA', vCdEmpresaCC);
  putitemXml(viParams, 'CD_TERMINAL', vCdTerminal);
  voParams := activateCmp('FCCSVCO002', 'buscaContaOperador', viParams); (*,,,, *)
  if (xStatus < 0) then begin
    Result := voParams;
    return(-1); exit;
  end;

  vNrCtaPes := itemXmlF('NR_CTAPES', voParams);

  if (vNrCtaPes = 0)  or (vNrCtaPes = '') then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Nenhuma conta cadastrada para o operador ' + FloatToStr(vCdOperCx) + ' na empresa ' + FloatToStr(vCdEmpresaCC) + '!', cDS_METHOD);
    return(-1); exit;
  end;
  if (vNrCtaPesFundo = '')  or (vCdEmpresaFundo = '') then begin
    clear_e(tFCC_CTAPES);
    putitem_e(tFCC_CTAPES, 'NR_CTAPES', vNrCtaPes);
    retrieve_e(tFCC_CTAPES);
    if (xStatus >= 0) then begin
      if (item_f('VL_LIMITE', tFCC_CTAPES) > 0) then begin
        vNrCtaPesFundo := vNrCtaPes;
        vCdEmpresaFundo := vCdEmpresaCC;
      end else begin
        viParams := '';
        putitemXml(viParams, 'CD_EMPRESA', vCdEmpresa);
        putitemXml(viParams, 'CD_TERMINAL', vCdTerminal);
        voParams := activateCmp('FCCSVCO002', 'buscaContaOperador', viParams); (*,,,, *)
        if (xStatus < 0) then begin
          Result := voParams;
          return(-1); exit;
        end;

        vNrCtaPesAux := itemXmlF('NR_CTAPES', voParams);

        clear_e(tFCC_CTAPES);
        putitem_e(tFCC_CTAPES, 'NR_CTAPES', vNrCtaPesAux);
        retrieve_e(tFCC_CTAPES);
        if (xStatus >= 0) then begin
          if (item_f('VL_LIMITE', tFCC_CTAPES) > 0) then begin
            vNrCtaPesFundo := vNrCtaPesAux;
            vCdEmpresaFundo := vCdEmpresa;
          end else begin
            vNrCtaPesFundo := vNrCtaPes;
            vCdEmpresaFundo := vCdEmpresaCC;
          end;
        end;
      end;
    end;
  end;

  clear_e(tFCX_CAIXAC);
  creocc(tFCX_CAIXAC, -1);
  getlistitensocc_e(pParams, tFCX_CAIXAC);
  putitem_e(tFCX_CAIXAC, 'CD_EMPRESA', vCdEmpresaCC);
  putitem_e(tFCX_CAIXAC, 'IN_FECHADO', False);
  putitem_e(tFCX_CAIXAC, 'NR_CTAPES', vNrCtaPes);
  putitem_e(tFCX_CAIXAC, 'CD_OPERADOR', itemXmlF('CD_USUARIO', PARAM_GLB));
  putitem_e(tFCX_CAIXAC, 'DT_CADASTRO', Now);

  voParams := tFCX_CAIXAC.Salvar();
  if (xStatus < 0) then begin
    Result := voParams;
    return(-1); exit;
  end;
  if (gTpLanctoFundoCx <> 1) then begin
    if (vVlAbertura > 0) then begin
      viParams := '';
      putitemXml(viParams, 'CD_EMPRESA', item_f('CD_EMPRESA', tFCX_CAIXAC));
      voParams := activateCmp('SICSVCO009', 'validaCentroCusto', viParams); (*,,,, *)
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

        xParamEmp := T_ADMSVCO001.GetParamEmpresa(piCdEmpresa, xParamEmp); (*item_f('CD_EMPRESA', tFCX_CAIXAC),,,, *)

        vInCxFilial := itemXmlB('IN_UTILIZA_CXFILIAL', voParams);
        vCxMatriz := itemXmlF('CD_CTAPES_CXMATRIZ', voParams);
        vCxFilial := itemXmlF('CD_CTAPES_CXFILIAL', voParams);
        if (vInCxFilial = True) then begin
          if (vCxFilial = 0)  or (vCxFilial = '') then begin
            Result := SetStatus(STS_ERROR, 'GEN0001', 'Conta caixa filial não informada para abertura de caixa.Parâmetro empresa: CD_CTAPES_CXFILIAL', '');
            rollback;
            return(-1); exit;
          end;
        end else begin
          if (vCxMatriz = 0)  or (vCxMatriz = '') then begin
            Result := SetStatus(STS_ERROR, 'GEN0001', 'Conta caixa matriz não informada para abertura de caixa.Parâmetro empresa: CD_CTAPES_CXMATRIZ', '');
            rollback;
            return(-1); exit;
          end;
        end;

        clear_e(tFCX_HISTREL);
        putitem_e(tFCX_HISTREL, 'TP_DOCUMENTO', 3);
        retrieve_e(tFCX_HISTREL);
        if (xStatus < 0) then begin
          Result := SetStatus(STS_ERROR, 'GEN0001', 'Não existe histórico associado a tipo de operação dinheiro', cDS_METHOD);
          rollback;
          return(-1); exit;
        end;

        viParams := '';
        voParams := activateCmp('FCCSVCO017', 'getNumMovRel', viParams); (*,,,, *)
        if (xStatus < 0) then begin
          Result := SetStatus(STS_ERROR, xProcerror, 'xProcerrorcontext', cDS_METHOD);
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

        voParams := activateCmp('FCCSVCO002', 'movimentaConta', viParams); (*,,,, *)
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
        putitemXml(viParams, 'NR_SEQCAIXA', item_f('NR_SEQ', tFCX_CAIXAC));
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

        voParams := activateCmp('FCCSVCO002', 'movimentaConta', viParams); (*,,,, *)
        if (xStatus < 0) then begin
          Result := voParams;
          return(-1); exit;
        end;
      end;
    end;

  end else begin
    if (vCdEmpPrincipal = vCdEmpresaFundo) then begin
      return(0); exit;
    end;
    if (vVlAbertura > 0) then begin
      viParams := '';
      putitem(viParams,  'CD_CTAPES_CXFILIAL');
      putitem(viParams,  'CD_CTAPES_CXMATRIZ');
      putitem(viParams,  'IN_UTILIZA_CXFILIAL');
      xParamEmp := T_ADMSVCO001.GetParamEmpresa(piCdEmpresa, xParamEmp); (*vCdEmpresa,,,, *)

      vInCxFilial := itemXmlB('IN_UTILIZA_CXFILIAL', voParams);
      vCxMatriz := itemXmlF('CD_CTAPES_CXMATRIZ', voParams);
      vCxFilial := itemXmlF('CD_CTAPES_CXFILIAL', voParams);
      if (vInCxFilial = True) then begin
        if (vCxFilial = 0)  or (vCxFilial = '') then begin
          Result := SetStatus(STS_ERROR, 'GEN0001', 'Conta caixa filial não informada para abertura de caixa.Parâmetro empresa: CD_CTAPES_CXFILIAL', '');
          rollback;
          return(-1); exit;
        end;
      end else begin
        if (vCxMatriz = 0)  or (vCxMatriz = '') then begin
          Result := SetStatus(STS_ERROR, 'GEN0001', 'Conta caixa matriz não informada para abertura de caixa.Parâmetro empresa: CD_CTAPES_CXMATRIZ', '');
          rollback;
          return(-1); exit;
        end;
      end;

      clear_e(tFCX_HISTREL);
      putitem_e(tFCX_HISTREL, 'TP_DOCUMENTO', 3);
      retrieve_e(tFCX_HISTREL);
      if (xStatus < 0) then begin
        Result := SetStatus(STS_ERROR, 'GEN0001', 'Não existe histórico associado a tipo de operação dinheiro', cDS_METHOD);
        rollback;
        return(-1); exit;
      end;

      viParams := '';
      voParams := activateCmp('FCCSVCO017', 'getNumMovRel', viParams); (*,,,, *)
      if (xStatus < 0) then begin
        Result := SetStatus(STS_ERROR, xProcerror, 'xProcerrorcontext', cDS_METHOD);
        return(-1); exit;
      end;
      vNrSeqMovRel := itemXmlF('NR_SEQMOVREL', voParams);

      viParams := '';
      putitemXml(viParams, 'CD_EMPRESA', vCdEmpresaFundo);
      putitemXml(viParams, 'NR_CTAPES', vNrCtaPesFundo);
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
      voParams := activateCmp('FCCSVCO002', 'movimentaConta', viParams); (*,,,, *)
      if (xStatus < 0) then begin
        Result := voParams;
        return(-1); exit;
      end;

      viParams := '';
      putitemXml(viParams, 'CD_EMPRESA', vCdEmpresaFundo);
      putitemXml(viParams, 'NR_CTAPES', vNrCtaPesFundo);
      putitemXml(viParams, 'DT_MOVIMENTO', itemXml('DT_SISTEMA', PARAM_GLB));
      putitemXml(viParams, 'CD_HISTORICO', 830);
      putitemXml(viParams, 'CD_TERMINAL', vCdTerminal);
      putitemXml(viParams, 'DT_ABERTURA', vDtAbertura);
      putitemXml(viParams, 'NR_SEQCAIXA', item_f('NR_SEQ', tFCX_CAIXAC));
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
      voParams := activateCmp('FCCSVCO002', 'movimentaConta', viParams); (*,,,, *)
      if (xStatus < 0) then begin
        Result := voParams;
        return(-1); exit;
      end;
    end;
  end;

  return(0); exit;
end;

//---------------------------------------------------------------------
function T_SICSVCO007.validaFechamentoCaixa(pParams : String) : String;
//---------------------------------------------------------------------
const
  cDS_METHOD = 'ADICIONAL=Operação: T_SICSVCO007.validaFechamentoCaixa()';
var
  vCdEmpresa, vNrSeq, vCdTerminal, vCdEmpresaCC : Real;
  vDtAbertura : TDate;
begin
  vCdEmpresa := itemXmlF('CD_EMPRESA', pParams);
  vCdTerminal := itemXmlF('CD_TERMINAL', pParams);
  vDtAbertura := itemXml('DT_ABERTURA', pParams);
  vNrSeq := itemXmlF('NR_SEQ', pParams);

  if (vCdEmpresa = 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Empresa não informada!', cDS_METHOD);
    return(-1); exit;
  end;
  if (vCdTerminal = 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Terminal não informado!', cDS_METHOD);
    return(-1); exit;
  end;
  if (vDtAbertura = 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Data de abertura não informada!', cDS_METHOD);
    return(-1); exit;
  end;
  if (vNrSeq = 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Nr. de sequência do caixa informado!', cDS_METHOD);
    return(-1); exit;
  end;

  clear_e(tGER_EMPRESA);
  putitem_e(tGER_EMPRESA, 'CD_EMPRESA', vCdEmpresa);
  retrieve_e(tGER_EMPRESA);
  if (xStatus < 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Empresa ' + FloatToStr(vCdEmpresa) + ' não cadastrada!', cDS_METHOD);
    return(-1); exit;
  end;
  if (item_f('CD_CCUSTO', tGER_EMPRESA) > 0) then begin
    vCdEmpresaCC := item_f('CD_CCUSTO', tGER_EMPRESA);
  end else begin
    clear_e(tGER_EMPRESA);
    putitem_e(tGER_EMPRESA, 'CD_CCUSTO', vCdEmpresa);
    retrieve_e(tGER_EMPRESA);
    if (xStatus >= 0) then begin
      vCdEmpresaCC := item_f('CD_EMPRESA', tGER_EMPRESA);
    end else begin
      return(0); exit;
    end;
  end;

  clear_e(tFCX_CAIXAC);
  putitem_e(tFCX_CAIXAC, 'CD_EMPRESA', vCdEmpresaCC);
  putitem_e(tFCX_CAIXAC, 'CD_TERMINAL', vCdTerminal);
  putitem_e(tFCX_CAIXAC, 'DT_ABERTURA', vDtAbertura);
  putitem_e(tFCX_CAIXAC, 'NR_SEQ', vNrSeq);
  retrieve_e(tFCX_CAIXAC);
  if (xStatus < 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Termina ' + FloatToStr(vCdTerminal) + ' não possui caixa aberto na empresa ' + FloatToStr(vCdEmpresaCC' + ) + ' + '!', cDS_METHOD);
    return(-1); exit;
  end else begin
    clear_e(tFCX_CAIXAM);
    putitem_e(tFCX_CAIXAM, 'CD_EMPRESA', item_f('CD_EMPRESA', tFCX_CAIXAC));
    putitem_e(tFCX_CAIXAM, 'CD_TERMINAL', item_f('CD_TERMINAL', tFCX_CAIXAC));
    putitem_e(tFCX_CAIXAM, 'DT_ABERTURA', item_a('DT_ABERTURA', tFCX_CAIXAC));
    putitem_e(tFCX_CAIXAM, 'NR_SEQ', item_f('NR_SEQ', tFCX_CAIXAC));
    retrieve_e(tFCX_CAIXAM);
    if (xStatus >= 0) then begin
      Result := SetStatus(STS_ERROR, 'GEN0001', 'Caixa não pode ser encerrado. Existe movimento!', cDS_METHOD);
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

  return(0); exit;
end;

//-----------------------------------------------------------
function T_SICSVCO007.validaCaixa(pParams : String) : String;
//-----------------------------------------------------------
const
  cDS_METHOD = 'ADICIONAL=Operação: T_SICSVCO007.validaCaixa()';
var
  vCdEmpresa, vNrSeq, vCdTerminal, vCdEmpresaCC : Real;
  vDtAbertura : TDate;
begin
  vCdEmpresa := itemXmlF('CD_EMPRESA', pParams);
  vCdTerminal := itemXmlF('CD_TERMINAL', pParams);
  vDtAbertura := itemXml('DT_ABERTURA', pParams);
  vNrSeq := itemXmlF('NR_SEQ', pParams);

  if (vCdEmpresa = 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Empresa não informada!', cDS_METHOD);
    return(-1); exit;
  end;
  if (vCdTerminal = 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Terminal não informado!', cDS_METHOD);
    return(-1); exit;
  end;
  if (vDtAbertura = 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Data de abertura não informada!', cDS_METHOD);
    return(-1); exit;
  end;
  if (vNrSeq = 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Nr. de sequência do caixa informado!', cDS_METHOD);
    return(-1); exit;
  end;

  clear_e(tGER_EMPRESA);
  putitem_e(tGER_EMPRESA, 'CD_EMPRESA', vCdEmpresa);
  retrieve_e(tGER_EMPRESA);
  if (xStatus < 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Empresa ' + FloatToStr(vCdEmpresa) + ' não cadastrada!', cDS_METHOD);
    return(-1); exit;
  end;
  if (item_f('CD_CCUSTO', tGER_EMPRESA) > 0) then begin
    vCdEmpresaCC := item_f('CD_CCUSTO', tGER_EMPRESA);
  end else begin
    clear_e(tGER_EMPRESA);
    putitem_e(tGER_EMPRESA, 'CD_CCUSTO', vCdEmpresa);
    retrieve_e(tGER_EMPRESA);
    if (xStatus >= 0) then begin
      vCdEmpresaCC := item_f('CD_EMPRESA', tGER_EMPRESA);
    end else begin
      return(0); exit;
    end;
  end;

  clear_e(tFCX_CAIXAC);
  putitem_e(tFCX_CAIXAC, 'CD_EMPRESA', vCdEmpresaCC);
  putitem_e(tFCX_CAIXAC, 'CD_TERMINAL', vCdTerminal);
  putitem_e(tFCX_CAIXAC, 'DT_ABERTURA', vDtAbertura);
  putitem_e(tFCX_CAIXAC, 'NR_SEQ', vNrSeq);
  retrieve_e(tFCX_CAIXAC);
  if (xStatus < 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Termina ' + FloatToStr(vCdTerminal) + ' não possui caixa aberto na empresa ' + FloatToStr(vCdEmpresaCC' + ) + ' + '!', cDS_METHOD);
    return(-1); exit;
  end;

  return(0); exit;
end;

//---------------------------------------------------------------
function T_SICSVCO007.carregaTerminal(pParams : String) : String;
//---------------------------------------------------------------
const
  cDS_METHOD = 'ADICIONAL=Operação: T_SICSVCO007.carregaTerminal()';
var
  vDsTerminal, vCdEmpresa : String;
  vInRetornaTerminal : Boolean;
begin
  vCdEmpresa := itemXmlF('CD_EMPRESA', PARAM_GLB);
  getParams(pParams); (* vCdEmpresa, xCdErro, xCtxErro *)
  if (xStatus < 0) then begin
    Result := SetStatus(STS_ERROR, {xCdErro} '', '{xCtxErro} ''', '');
    return(-1); exit;
  end;

  vCdEmpresa := itemXmlF('CD_EMPRESA', pParams);

  vInRetornaTerminal := itemXmlB('IN_RETORNATERMINAL', pParams);

  clear_e(tFCX_CAIXAC);
  putitem_e(tFCX_CAIXAC, 'CD_EMPRESA', vCdEmpresa);
  putitem_e(tFCX_CAIXAC, 'IN_FECHADO', False);
  retrieve_e(tFCX_CAIXAC);
  if (xStatus >= 0) then begin
    setocc(tFCX_CAIXAC, 1);
    while (xStatus >= 0) do begin
      clear_e(tGER_EMPRESA);
      putitem_e(tGER_EMPRESA, 'CD_EMPRESA', item_f('CD_EMPRESA', tFCX_CAIXAC));
      retrieve_e(tGER_EMPRESA);
      if (xStatus >= 0)  and (item_f('CD_CCUSTO', tGER_EMPRESA) = '') then begin
        clear_e(tGER_TERMINAL);
        putitem_e(tGER_TERMINAL, 'CD_EMPRESA', item_f('CD_EMPRESA', tFCX_CAIXAC));
        putitem_e(tGER_TERMINAL, 'CD_TERMINAL', item_f('CD_TERMINAL', tFCX_CAIXAC));
        retrieve_e(tGER_TERMINAL);
        if (xStatus >= 0) then begin
          if (gInUsuTerm = 0) then begin
            putitemXml(vDsTerminal, '' + CD_TERMINAL + '.GER_TERMINAL', DS_TERMINAL.GER_TERMINAL);
          end else begin
            clear_e(tFCX_TERMINALU);
            putitem_e(tFCX_TERMINALU, 'CD_EMPRESA', item_f('CD_EMPRESA', tGER_TERMINAL));
            putitem_e(tFCX_TERMINALU, 'CD_TERMINAL', item_f('CD_TERMINAL', tGER_TERMINAL));
            retrieve_e(tFCX_TERMINALU);
            if (xStatus >= 0) then begin
              clear_e(tADM_USUARIO);
              putitem_e(tADM_USUARIO, 'CD_USUARIO', item_f('CD_USUARIO', tFCX_TERMINALU));
              retrieve_e(tADM_USUARIO);
              if (xStatus >= 0) then begin
                if (vInRetornaTerminal = True) then begin
                  if (gTpNomeCxUsuario = 1) then begin
                    putitemXml(vDsTerminal, '' + CD_TERMINAL + '.FCX_TERMINALU', item_a('NM_USUARIO', tADM_USUARIO));
                  end else begin
                    putitemXml(vDsTerminal, '' + CD_TERMINAL + '.FCX_TERMINALU', item_a('NM_LOGIN', tADM_USUARIO));
                  end;
                end else begin

                  if (gTpNomeCxUsuario = 1) then begin
                    putitemXml(vDsTerminal, '' + CD_USUARIO + '.FCX_TERMINALU', item_a('NM_USUARIO', tADM_USUARIO));
                  end else begin
                    putitemXml(vDsTerminal, '' + CD_USUARIO + '.FCX_TERMINALU', item_a('NM_LOGIN', tADM_USUARIO));
                  end;
                end;
              end;
            end;
          end;
        end;
      end;

      setocc(tFCX_CAIXAC, curocc(tFCX_CAIXAC) + 1);
    end;
  end;

  Result := '';
  putitemXml(Result, 'DS_LSTTERMINAL', vDsTerminal);

  return(0); exit;
end;

//-----------------------------------------------------------------
function T_SICSVCO007.descricaoTerminal(pParams : String) : String;
//-----------------------------------------------------------------
const
  cDS_METHOD = 'ADICIONAL=Operação: T_SICSVCO007.descricaoTerminal()';
var
  vDsTerminal, vCdEmpresa : String;
  vCdTerminal : Real;
begin
  vCdTerminal := itemXmlF('CD_TERMINAL', pParams);
  vCdEmpresa := itemXmlF('CD_EMPRESA', pParams);

  clear_e(tGER_EMPRESA);
  putitem_e(tGER_EMPRESA, 'CD_EMPRESA', vCdEmpresa);
  retrieve_e(tGER_EMPRESA);
  if (xStatus >= 0) then begin
    setocc(tGER_EMPRESA, 1);
    while (xStatus >= 0) do begin
      if (item_f('CD_CCUSTO', tGER_EMPRESA) = '') then begin
        clear_e(tGER_TERMINAL);
        putitem_e(tGER_TERMINAL, 'CD_EMPRESA', item_f('CD_EMPRESA', tGER_EMPRESA));
        putitem_e(tGER_TERMINAL, 'CD_TERMINAL', vCdTerminal);
        retrieve_e(tGER_TERMINAL);
        if (xStatus >= 0) then begin
          if (gInUsuTerm = 0) then begin
            vDsTerminal := item_a('DS_TERMINAL', tGER_TERMINAL);
          end else begin
            clear_e(tFCX_TERMINALU);
            putitem_e(tFCX_TERMINALU, 'CD_EMPRESA', item_f('CD_EMPRESA', tGER_TERMINAL));
            putitem_e(tFCX_TERMINALU, 'CD_TERMINAL', item_f('CD_TERMINAL', tGER_TERMINAL));
            retrieve_e(tFCX_TERMINALU);
            if (xStatus >= 0) then begin
              clear_e(tADM_USUARIO);
              putitem_e(tADM_USUARIO, 'CD_USUARIO', item_f('CD_USUARIO', tFCX_TERMINALU));
              retrieve_e(tADM_USUARIO);
              if (xStatus >= 0) then begin
                if (gTpNomeCxUsuario = 1) then begin
                  vDsTerminal := item_a('NM_USUARIO', tADM_USUARIO);
                end else begin
                  vDsTerminal := item_a('NM_LOGIN', tADM_USUARIO);
                end;
              end;
            end;
          end;
        end;
      end;

      setocc(tGER_EMPRESA, curocc(tGER_EMPRESA) + 1);
    end;
  end;

  Result := '';
  putitemXml(Result, 'DS_TERMINAL', vDsTerminal);

  return(0); exit;
end;

//-------------------------------------------------------------------
function T_SICSVCO007.carregaTodoTerminal(pParams : String) : String;
//-------------------------------------------------------------------
const
  cDS_METHOD = 'ADICIONAL=Operação: T_SICSVCO007.carregaTodoTerminal()';
var
  vDsTerminal, vLstEmpresa, vDtAbertura, vTpCaixa : String;
  vInInativo, vInDiferenca : Boolean;
  vCdEmpresa : Real;
begin
  vCdEmpresa := itemXmlF('CD_EMPRESA', PARAM_GLB);

  getParams(pParams); (* vCdEmpresa, xCdErro, xCtxErro *)
  if (xStatus < 0) then begin
    Result := SetStatus(STS_ERROR, {xCdErro} '', '{xCtxErro} ''', '');
    return(-1); exit;
  end;

  vLstEmpresa := itemXmlF('CD_EMPRESA', pParams);
  vInInativo := itemXmlB('IN_INATIVO', pParams);
  vDtAbertura := itemXml('DT_ABERTURA', pParams);
  vInDiferenca := itemXmlB('IN_DIFERENCA', pParams);
  vTpCaixa := itemXmlF('TP_CAIXA', pParams);

  if (gInUsuTerm = 1) then begin
    if (vLstEmpresa <> '') then begin
      repeat
        getitem(vCdEmpresa, vLstEmpresa, 1);

        clear_e(tGER_EMPRESA);
        putitem_e(tGER_EMPRESA, 'CD_EMPRESA', vCdEmpresa);
        retrieve_e(tGER_EMPRESA);
        if (xStatus >= 0)  and (item_f('CD_CCUSTO', tGER_EMPRESA) = '') then begin
          clear_e(tFCC_CTAPES);
          putitem_e(tFCC_CTAPES, 'CD_EMPRESA', item_f('CD_EMPRESA', tGER_EMPRESA));
          putitem_e(tFCC_CTAPES, 'TP_MANUTENCAO', gCdTpManutCxUsuario);
          retrieve_e(tFCC_CTAPES);
          if (xStatus >= 0) then begin
            setocc(tFCC_CTAPES, 1);
            while (xStatus >= 0) do begin
              if (item_f('CD_OPERCAIXA', tFCC_CTAPES) > 0) then begin
                clear_e(tFCX_CAIXAC);
                putitem_e(tFCX_CAIXAC, 'CD_EMPRESA', item_f('CD_EMPRESA', tFCC_CTAPES));
                putitem_e(tFCX_CAIXAC, 'DT_ABERTURA', vDtAbertura);
                putitem_e(tFCX_CAIXAC, 'NR_CTAPES', item_f('NR_CTAPES', tFCC_CTAPES));
                if (vInDiferenca = True) then begin
                  putitem_e(tFCX_CAIXAC, 'IN_DIFERENCA', True);
                end;
                if (vTpCaixa = 'F') then begin
                  putitem_e(tFCX_CAIXAC, 'IN_FECHADO', True);
                end;
                retrieve_e(tFCX_CAIXAC);
                if (xStatus >= 0) then begin
                  clear_e(tADM_USUARIO);
                  putitem_e(tADM_USUARIO, 'CD_USUARIO', item_f('CD_OPERCAIXA', tFCC_CTAPES));
                  retrieve_e(tADM_USUARIO);
                  if (xStatus >= 0)  and (TP_BLOQUEIO = 0 ) or (vInInativo = True) then begin
                    if (gTpNomeCxUsuario = 1) then begin
                        putitemXml(vDsTerminal, '' + CD_USUARIO + '.FCX_TERMINALU', item_a('NM_USUARIO', tADM_USUARIO));
                    end else begin
                        putitemXml(vDsTerminal, '' + CD_USUARIO + '.ADM_USUARIO', NM_LOGIN.ADM_USUARIO);
                    end;
                  end;
                end;
              end;

              setocc(tFCC_CTAPES, curocc(tFCC_CTAPES) + 1);
            end;
          end;
        end;

        delitem(vLstEmpresa, 1);
      until (vLstEmpresa = '');
    end;
  end else begin
    clear_e(tFCX_CAIXAC);
    putitem_e(tFCX_CAIXAC, 'CD_EMPRESA', vLstEmpresa);
    putitem_e(tFCX_CAIXAC, 'DT_ABERTURA', vDtAbertura);
    if (vInDiferenca = True) then begin
      putitem_e(tFCX_CAIXAC, 'IN_DIFERENCA', True);
    end;
    if (vTpCaixa = 'F') then begin
      putitem_e(tFCX_CAIXAC, 'IN_FECHADO', True);
    end;
    retrieve_e(tFCX_CAIXAC);
    if (xStatus >= 0) then begin
      setocc(tFCX_CAIXAC, 1);
      while (xStatus >= 0) do begin
        clear_e(tGER_EMPRESA);
        putitem_e(tGER_EMPRESA, 'CD_EMPRESA', item_f('CD_EMPRESA', tFCX_CAIXAC));
        retrieve_e(tGER_EMPRESA);
        if (xStatus >= 0)  and (item_f('CD_CCUSTO', tGER_EMPRESA) = '') then begin
          clear_e(tGER_TERMINAL);
          putitem_e(tGER_TERMINAL, 'CD_EMPRESA', item_f('CD_EMPRESA', tFCX_CAIXAC));
          putitem_e(tGER_TERMINAL, 'CD_TERMINAL', item_f('CD_TERMINAL', tFCX_CAIXAC));
          retrieve_e(tGER_TERMINAL);
          if (xStatus >= 0) then begin
            putitemXml(vDsTerminal, '' + CD_TERMINAL + '.GER_TERMINAL', DS_TERMINAL.GER_TERMINAL);
          end;
        end;

        setocc(tFCX_CAIXAC, curocc(tFCX_CAIXAC) + 1);
      end;
    end;
  end;

  Result := '';
  putitemXml(Result, 'DS_LSTTERMINAL', vDsTerminal);

  return(0); exit;
end;

//-------------------------------------------------------------------
function T_SICSVCO007.validaRetiradaCaixa(pParams : String) : String;
//-------------------------------------------------------------------
const
  cDS_METHOD = 'ADICIONAL=Operação: T_SICSVCO007.validaRetiradaCaixa()';
var
  vCdEmpresa, vNrSeq, vCdTerminal, vVlValor, vTpDocumento, vNrSeqHistRelSub, vCdEmpresaRetorno, vVlSaldoAtualDoc, vVlSaldoAtual : Real;
  vCxConta, vVlSistema, vVlRetorno, vNrSeqMovRel, vTpProcesso, vVlSaldoAntDoc, vVlSaldoAnt, vNrCtaPesFCC, vNrSeqMovFCC : Real;
  vDtAbertura, vDtMovimFCC : TDate;
  vDsAux, vDsObs, viParams, voParams : String;
begin
  vCdEmpresa := itemXmlF('CD_EMPRESA', pParams);
  vCdTerminal := itemXmlF('CD_TERMINAL', pParams);
  vDtAbertura := itemXml('DT_ABERTURA', pParams);
  vNrSeq := itemXmlF('NR_SEQ', pParams);
  vVlValor := itemXmlF('VL_VALOR', pParams);
  vTpDocumento := itemXmlF('TP_DOCUMENTO', pParams);
  vNrSeqHistRelSub := itemXmlF('NR_SEQHISTRELSUB', pParams);
  vDsAux := itemXml('DS_AUX', pParams);
  vDsObs := itemXml('DS_OBS', pParams);

  vTpProcesso := itemXmlF('TP_PROCESSO', pParams);

  if (vCdEmpresa = 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Empresa não informada!', cDS_METHOD);
    return(-1); exit;
  end;
  if (vCdTerminal = 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Terminal não informado!', cDS_METHOD);
    return(-1); exit;
  end;
  if (vDtAbertura = 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Data de abertura não informada!', cDS_METHOD);
    return(-1); exit;
  end;
  if (vNrSeq = 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Nr. de sequência do caixa não informado!', cDS_METHOD);
    return(-1); exit;
  end;
  if (vVlValor = 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Valor da retirada não informado!', cDS_METHOD);
    return(-1); exit;
  end;
  if (vTpDocumento = 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Tipo de documento não informado!', cDS_METHOD);
    return(-1); exit;
  end;
  if (vNrSeqHistRelSub = 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Sequencia de documento não informado!', cDS_METHOD);
    return(-1); exit;
  end;

  clear_e(tGER_EMPRESA);
  putitem_e(tGER_EMPRESA, 'CD_EMPRESA', vCdEmpresa);
  retrieve_e(tGER_EMPRESA);
  if (xStatus >= 0) then begin
    if (item_f('CD_CCUSTO', tGER_EMPRESA) = 0) then begin
      clear_e(tGER_EMPRESA);
      putitem_e(tGER_EMPRESA, 'CD_CCUSTO', vCdEmpresa);
      retrieve_e(tGER_EMPRESA);
      if (xStatus >= 0) then begin
        vCdEmpresaRetorno := vCdEmpresa;
        vCdEmpresa := item_f('CD_EMPRESA', tGER_EMPRESA);

      end else begin
        vCdEmpresaRetorno := vCdEmpresa;

      end;
    end else begin
      vCdEmpresaRetorno := item_f('CD_CCUSTO', tGER_EMPRESA);
    end;
  end;

  clear_e(tFCX_CAIXAC);
  putitem_e(tFCX_CAIXAC, 'CD_EMPRESA', vCdEmpresa);
  putitem_e(tFCX_CAIXAC, 'CD_TERMINAL', vCdTerminal);
  putitem_e(tFCX_CAIXAC, 'DT_ABERTURA', vDtAbertura);
  putitem_e(tFCX_CAIXAC, 'NR_SEQ', vNrSeq);
  retrieve_e(tFCX_CAIXAC);
  if (xStatus < 0) then begin
    clear_e(tFCX_CAIXAC);
    putitem_e(tFCX_CAIXAC, 'CD_EMPRESA', vCdEmpresaRetorno);
    putitem_e(tFCX_CAIXAC, 'CD_TERMINAL', vCdTerminal);
    putitem_e(tFCX_CAIXAC, 'DT_ABERTURA', vDtAbertura);
    putitem_e(tFCX_CAIXAC, 'NR_SEQ', vNrSeq);
    retrieve_e(tFCX_CAIXAC);
    if (xStatus < 0) then begin
      Result := SetStatus(STS_ERROR, 'GEN0001', 'Caixa não encontrado!', cDS_METHOD);
      return(-1); exit;
    end;

    getParams(pParams); (* vCdEmpresaRetorno, xCdErro, xCtxErro *)
    if (xStatus < 0) then begin
      Result := SetStatus(STS_ERROR, {xCdErro} '', '{xCtxErro} ''', '');
      rollback;
      return(-1); exit;
    end;

    Result := '';
    putitemXml(Result, 'CD_EMPRESA', vCdEmpresaRetorno);
    putitemXml(Result, 'NR_CTAPES', item_f('NR_CTAPES', tFCX_CAIXAC));
    putitemXml(Result, 'CD_CTAPES_CXFILIAL', gcxFilial);
    putitemXml(Result, 'CD_CTAPES_CXMATRIZ', gcxMatriz);
    putitemXml(Result, 'VL_VALOR', vVlValor);

    return(0); exit;
  end;

  getParams(pParams); (* vCdEmpresa, xCdErro, xCtxErro *)
  if (xStatus < 0) then begin
    Result := SetStatus(STS_ERROR, {xCdErro} '', '{xCtxErro} ''', '');
    return(-1); exit;
  end;
  if (gInLogMovCtaPes = True)  and ((vTpProcesso = '')  or (vTpProcesso = 0)) then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Tipo de processo não informado!', cDS_METHOD);
    return(-1); exit;
  end;
  if (gInCxFilial = 1) then begin
    vCxConta := gcxFilial;
  end else begin
    vCxConta := gcxMatriz;
  end;

  clear_e(tFCX_CAIXAM);
  putitem_e(tFCX_CAIXAM, 'CD_EMPRESA', vCdEmpresa);
  putitem_e(tFCX_CAIXAM, 'DT_ABERTURA', vDtAbertura);
  putitem_e(tFCX_CAIXAM, 'CD_TERMINAL', vCdTerminal);
  putitem_e(tFCX_CAIXAM, 'NR_SEQ', vNrSeq);
  retrieve_e(tFCX_CAIXAM);
  if (xStatus >= 0) then begin
    setocc(tFCX_CAIXAM, 1);
    while (xStatus >= 0) do begin
      if (item_b('IN_ESTORNO', tFCC_MOV) = False) then begin
        if (item_f('TP_DOCUMENTO', tFCC_MOV) = vTpDocumento)  and (item_f('NR_SEQHISTRELSUB', tFCC_MOV) = vNrSeqHistRelSub) then begin
          if (item_f('TP_OPERACAO', tFCC_MOV) = 'D') then begin
            vVlSistema := vVlSistema - item_f('VL_LANCTO', tFCC_MOV);
          end else begin
            vVlSistema := vVlSistema + item_f('VL_LANCTO', tFCC_MOV);
          end;
        end;
        if (item_f('TP_DOCUMENTO', tFCC_MOV) = 9)  and (vTpDocumento = 3) then begin
          if (item_f('TP_OPERACAO', tFCC_MOV) = 'D') then begin
            vVlSistema := vVlSistema + item_f('VL_LANCTO', tFCC_MOV);
          end else begin
            vVlSistema := vVlSistema - item_f('VL_LANCTO', tFCC_MOV);
          end;
        end;
      end;

      setocc(tFCX_CAIXAM, curocc(tFCX_CAIXAM) + 1);
    end;
  end;
  if (vVlValor > vVlSistema)  and (vVlSistema > 0) then begin
    vVlRetorno := vVlValor - vVlSistema;
    vVlValor := vVlSistema;
  end;
  if (vVlSistema <= 0) then begin
    vVlRetorno := vVlValor;
    vVlValor := 0;
  end;
  if (vVlValor > 0) then begin
    viParams := '';
    voParams := activateCmp('FCCSVCO017', 'getNumMovRel', viParams); (*,,,, *)
    if (xStatus < 0) then begin
      Result := SetStatus(STS_ERROR, xProcerror, 'xProcerrorcontext', cDS_METHOD);
      return(-1); exit;
    end;
    vNrSeqMovRel := itemXmlF('NR_SEQMOVREL', voParams);

    if (gInLogMovCtaPes = True) then begin
      viParams := '';
      putitemXml(viParams, 'NR_CTAPES', item_f('NR_CTAPES', tFCX_CAIXAC));
      putitemXml(viParams, 'DT_SALDO', itemXml('DT_SISTEMA', PARAM_GLB));
      voParams := activateCmp('FCCSVCO002', 'buscaSaldoConta', viParams); (*,,'',,, *)
      if (xStatus < 0) then begin
        Result := voParams;
        return(-1); exit;
      end;
      vVlSaldoAnt := itemXmlF('VL_SALDO', voParams);

      viParams := '';
      putitemXml(viParams, 'NR_CTAPES', item_f('NR_CTAPES', tFCX_CAIXAC));
      putitemXml(viParams, 'TP_DOCUMENTO', vTpDocumento);
      putitemXml(viParams, 'NR_SEQHISTRELSUB', vNrSeqHistRelSub);
      putitemXml(viParams, 'DT_SALDO', itemXml('DT_SISTEMA', PARAM_GLB));
      voParams := activateCmp('FCCSVCO002', 'buscaSaldoCtaTp', viParams); (*,,'',,, *)
      if (xStatus < 0) then begin
        Result := voParams;
        return(-1); exit;
      end;
      vVlSaldoAntDoc := itemXmlF('VL_SALDO', voParams);
    end;

    viParams := '';
    putitemXml(viParams, 'CD_EMPRESA', vCdEmpresa);
    putitemXml(viParams, 'NR_CTAPES', item_f('NR_CTAPES', tFCX_CAIXAC));
    putitemXml(viParams, 'DT_MOVIMENTO', itemXml('DT_SISTEMA', PARAM_GLB));
    putitemXml(viParams, 'CD_HISTORICO', 833);
    putitemXml(viParams, 'DS_AUX', vDsAux);
    putitemXml(viParams, 'VL_LANCTO', vVlValor);
    putitemXml(viParams, 'IN_ESTORNO', 'N');
    putitemXml(viParams, 'TP_DOCUMENTO', vTpDocumento);
    putitemXml(viParams, 'NR_SEQHISTRELSUB', vNrSeqHistRelSub);
    putitemXml(viParams, 'IN_CAIXA', True);
    putitemXml(viParams, 'CD_TERMINAL', vCdTerminal);
    putitemXml(viParams, 'DT_ABERTURA', vDtAbertura);
    putitemXml(viParams, 'NR_SEQCAIXA', vNrSeq);
    putitemXml(viParams, 'DS_OBS', vDsObs);

    if (vNrSeqMovRel > 0) then begin
      putitemXml(viParams, 'NR_SEQMOVREL', vNrSeqMovRel);
    end;

    voParams := activateCmp('FCCSVCO002', 'movimentaConta', viParams); (*,,,, *)
    if (xStatus < 0) then begin
      Result := voParams;
      return(-1); exit;
    end;
    if (gInLogMovCtaPes = True) then begin
      vNrCtaPesFCC := itemXmlF('NR_CTAPES', voParams);
      vDtMovimFCC := itemXml('DT_MOVIM', voParams);
      vNrSeqMovFCC := itemXmlF('NR_SEQMOV', voParams);

      viParams := '';
      putitemXml(viParams, 'NR_CTAPES', item_f('NR_CTAPES', tFCX_CAIXAC));
      putitemXml(viParams, 'DT_SALDO', itemXml('DT_SISTEMA', PARAM_GLB));
      voParams := activateCmp('FCCSVCO002', 'buscaSaldoConta', viParams); (*,,'',,, *)
      if (xStatus < 0) then begin
        Result := voParams;
        return(-1); exit;
      end;
      vVlSaldoAtual := itemXmlF('VL_SALDO', voParams);

      viParams := '';
      putitemXml(viParams, 'NR_CTAPES', item_f('NR_CTAPES', tFCX_CAIXAC));
      putitemXml(viParams, 'TP_DOCUMENTO', vTpDocumento);
      putitemXml(viParams, 'NR_SEQHISTRELSUB', vNrSeqHistRelSub);
      putitemXml(viParams, 'DT_SALDO', itemXml('DT_SISTEMA', PARAM_GLB));
      voParams := activateCmp('FCCSVCO002', 'buscaSaldoCtaTp', viParams); (*,,'',,, *)
      if (xStatus < 0) then begin
        Result := voParams;
        return(-1); exit;
      end;
      vVlSaldoAtualDoc := itemXmlF('VL_SALDO', voParams);

      viParams := '';
      putitemXml(viParams, 'TP_PROCESSO', vTpProcesso);
      putitemXml(viParams, 'TP_DOCUMENTO', vTpDocumento);
      putitemXml(viParams, 'NR_CTAPES', item_f('NR_CTAPES', tFCX_CAIXAC));
      putitemXml(viParams, 'VL_LANCAMENTO', vVlValor);
      putitemXml(viParams, 'VL_SALDODOC', vVlSaldoAtualDoc);
      putitemXml(viParams, 'VL_SALDOCTA', vVlSaldoAtual);
      putitemXml(viParams, 'VL_SALDOANTDOC', vVlSaldoAntDoc);
      putitemXml(viParams, 'VL_SALDOANTCTA', vVlSaldoAnt);
      putitemXml(viParams, 'NR_CTAPESFCC', vNrCtaPesFCC);
      putitemXml(viParams, 'DT_MOVIMFCC', vDtMovimFCC);
      putitemXml(viParams, 'NR_SEQMOVFCC', vNrSeqMovFCC);
      voParams := activateCmp('FCCSVCO018', 'gravarLogMovtoCtaPes', viParams); (*,,,, *)
      if (xStatus < 0) then begin
        Result := voParams;
        return(-1); exit;
      end;
    end;
    if (gInLogMovCtaPes = True) then begin
      viParams := '';
      putitemXml(viParams, 'NR_CTAPES', vCxConta);
      putitemXml(viParams, 'DT_SALDO', itemXml('DT_SISTEMA', PARAM_GLB));
      voParams := activateCmp('FCCSVCO002', 'buscaSaldoConta', viParams); (*,,'',,, *)
      if (xStatus < 0) then begin
        Result := voParams;
        return(-1); exit;
      end;
      vVlSaldoAnt := itemXmlF('VL_SALDO', voParams);

      viParams := '';
      putitemXml(viParams, 'NR_CTAPES', vCxConta);
      putitemXml(viParams, 'TP_DOCUMENTO', vTpDocumento);
      putitemXml(viParams, 'NR_SEQHISTRELSUB', vNrSeqHistRelSub);
      putitemXml(viParams, 'DT_SALDO', itemXml('DT_SISTEMA', PARAM_GLB));
      voParams := activateCmp('FCCSVCO002', 'buscaSaldoCtaTp', viParams); (*,,'',,, *)
      if (xStatus < 0) then begin
        Result := voParams;
        return(-1); exit;
      end;
      vVlSaldoAntDoc := itemXmlF('VL_SALDO', voParams);
    end;

    viParams := '';
    putitemXml(viParams, 'CD_EMPRESA', vCdEmpresa);
    putitemXml(viParams, 'NR_CTAPES', vCxConta);
    putitemXml(viParams, 'DT_MOVIMENTO', itemXml('DT_SISTEMA', PARAM_GLB));
    putitemXml(viParams, 'CD_HISTORICO', 832);
    putitemXml(viParams, 'DS_AUX', 'RET. CX OP: ' + CD_OPERADOR + '.FCX_CAIXAC');
    putitemXml(viParams, 'VL_LANCTO', vVlValor);
    putitemXml(viParams, 'IN_ESTORNO', 'N');
    putitemXml(viParams, 'TP_DOCUMENTO', vTpDocumento);
    putitemXml(viParams, 'NR_SEQHISTRELSUB', vNrSeqHistRelSub);
    putitemXml(viParams, 'DS_OBS', vDsObs);

    if (vNrSeqMovRel > 0) then begin
      putitemXml(viParams, 'NR_SEQMOVREL', vNrSeqMovRel);
    end;

    voParams := activateCmp('FCCSVCO002', 'movimentaConta', viParams); (*,,,, *)
    if (xStatus < 0) then begin
      Result := voParams;
      return(-1); exit;
    end;
    if (gInLogMovCtaPes = True) then begin
      vNrCtaPesFCC := itemXmlF('NR_CTAPES', voParams);
      vDtMovimFCC := itemXml('DT_MOVIM', voParams);
      vNrSeqMovFCC := itemXmlF('NR_SEQMOV', voParams);

      viParams := '';
      putitemXml(viParams, 'NR_CTAPES', vCxConta);
      putitemXml(viParams, 'DT_SALDO', itemXml('DT_SISTEMA', PARAM_GLB));
      voParams := activateCmp('FCCSVCO002', 'buscaSaldoConta', viParams); (*,,'',,, *)
      if (xStatus < 0) then begin
        Result := voParams;
        return(-1); exit;
      end;
      vVlSaldoAtual := itemXmlF('VL_SALDO', voParams);

      viParams := '';
      putitemXml(viParams, 'NR_CTAPES', vCxConta);
      putitemXml(viParams, 'TP_DOCUMENTO', vTpDocumento);
      putitemXml(viParams, 'NR_SEQHISTRELSUB', vNrSeqHistRelSub);
      putitemXml(viParams, 'DT_SALDO', itemXml('DT_SISTEMA', PARAM_GLB));
      voParams := activateCmp('FCCSVCO002', 'buscaSaldoCtaTp', viParams); (*,,'',,, *)
      if (xStatus < 0) then begin
        Result := voParams;
        return(-1); exit;
      end;
      vVlSaldoAtualDoc := itemXmlF('VL_SALDO', voParams);

      viParams := '';
      putitemXml(viParams, 'TP_PROCESSO', vTpProcesso);
      putitemXml(viParams, 'TP_DOCUMENTO', vTpDocumento);
      putitemXml(viParams, 'NR_CTAPES', vCxConta);
      putitemXml(viParams, 'VL_LANCAMENTO', vVlValor);
      putitemXml(viParams, 'VL_SALDODOC', vVlSaldoAtualDoc);
      putitemXml(viParams, 'VL_SALDOCTA', vVlSaldoAtual);
      putitemXml(viParams, 'VL_SALDOANTDOC', vVlSaldoAntDoc);
      putitemXml(viParams, 'VL_SALDOANTCTA', vVlSaldoAnt);
      putitemXml(viParams, 'NR_CTAPESFCC', vNrCtaPesFCC);
      putitemXml(viParams, 'DT_MOVIMFCC', vDtMovimFCC);
      putitemXml(viParams, 'NR_SEQMOVFCC', vNrSeqMovFCC);
      voParams := activateCmp('FCCSVCO018', 'gravarLogMovtoCtaPes', viParams); (*,,,, *)
      if (xStatus < 0) then begin
        Result := voParams;
        return(-1); exit;
      end;
    end;
    if (vTpDocumento = 2)  and (gInCxFilial <> 1) then begin
      if (gInLogMovCtaPes = True) then begin
        viParams := '';
        putitemXml(viParams, 'NR_CTAPES', vCxConta);
        putitemXml(viParams, 'DT_SALDO', itemXml('DT_SISTEMA', PARAM_GLB));
        voParams := activateCmp('FCCSVCO002', 'buscaSaldoConta', viParams); (*,,'',,, *)
        if (xStatus < 0) then begin
          Result := voParams;
          return(-1); exit;
        end;
        vVlSaldoAnt := itemXmlF('VL_SALDO', voParams);

        viParams := '';
        putitemXml(viParams, 'NR_CTAPES', vCxConta);
        putitemXml(viParams, 'TP_DOCUMENTO', vTpDocumento);
        putitemXml(viParams, 'NR_SEQHISTRELSUB', vNrSeqHistRelSub);
        putitemXml(viParams, 'DT_SALDO', itemXml('DT_SISTEMA', PARAM_GLB));
        voParams := activateCmp('FCCSVCO002', 'buscaSaldoCtaTp', viParams); (*,,'',,, *)
        if (xStatus < 0) then begin
          Result := voParams;
          return(-1); exit;
        end;
        vVlSaldoAntDoc := itemXmlF('VL_SALDO', voParams);
      end;

      viParams := '';
      putitemXml(viParams, 'CD_EMPRESA', vCdEmpresa);
      putitemXml(viParams, 'NR_CTAPES', vCxConta);
      putitemXml(viParams, 'DT_MOVIMENTO', itemXml('DT_SISTEMA', PARAM_GLB));
      putitemXml(viParams, 'CD_HISTORICO', 833);
      putitemXml(viParams, 'VL_LANCTO', vVlValor);
      putitemXml(viParams, 'IN_ESTORNO', 'N');
      putitemXml(viParams, 'TP_DOCUMENTO', vTpDocumento);
      putitemXml(viParams, 'NR_SEQHISTRELSUB', vNrSeqHistRelSub);
      putitemXml(viParams, 'DS_AUX', 'RET. CX OP: ' + CD_OPERADOR + '.FCX_CAIXAC');
      putitemXml(viParams, 'DS_OBS', vDsObs);

      if (vNrSeqMovRel > 0) then begin
        putitemXml(viParams, 'NR_SEQMOVREL', vNrSeqMovRel);
      end;

      voParams := activateCmp('FCCSVCO002', 'movimentaConta', viParams); (*,,,, *)
      if (xStatus < 0) then begin
        Result := voParams;
        return(-1); exit;
      end;
      if (gInLogMovCtaPes = True) then begin
        vNrCtaPesFCC := itemXmlF('NR_CTAPES', voParams);
        vDtMovimFCC := itemXml('DT_MOVIM', voParams);
        vNrSeqMovFCC := itemXmlF('NR_SEQMOV', voParams);

        viParams := '';
        putitemXml(viParams, 'NR_CTAPES', vCxConta);
        putitemXml(viParams, 'DT_SALDO', itemXml('DT_SISTEMA', PARAM_GLB));
        voParams := activateCmp('FCCSVCO002', 'buscaSaldoConta', viParams); (*,,'',,, *)
        if (xStatus < 0) then begin
          Result := voParams;
          return(-1); exit;
        end;
        vVlSaldoAtual := itemXmlF('VL_SALDO', voParams);

        viParams := '';
        putitemXml(viParams, 'NR_CTAPES', vCxConta);
        putitemXml(viParams, 'TP_DOCUMENTO', vTpDocumento);
        putitemXml(viParams, 'NR_SEQHISTRELSUB', vNrSeqHistRelSub);
        putitemXml(viParams, 'DT_SALDO', itemXml('DT_SISTEMA', PARAM_GLB));
        voParams := activateCmp('FCCSVCO002', 'buscaSaldoCtaTp', viParams); (*,,'',,, *)
        if (xStatus < 0) then begin
          Result := voParams;
          return(-1); exit;
        end;
        vVlSaldoAtualDoc := itemXmlF('VL_SALDO', voParams);

        viParams := '';
        putitemXml(viParams, 'TP_PROCESSO', vTpProcesso);
        putitemXml(viParams, 'TP_DOCUMENTO', vTpDocumento);
        putitemXml(viParams, 'NR_CTAPES', vCxConta);
        putitemXml(viParams, 'VL_LANCAMENTO', vVlValor);
        putitemXml(viParams, 'VL_SALDODOC', vVlSaldoAtualDoc);
        putitemXml(viParams, 'VL_SALDOCTA', vVlSaldoAtual);
        putitemXml(viParams, 'VL_SALDOANTDOC', vVlSaldoAntDoc);
        putitemXml(viParams, 'VL_SALDOANTCTA', vVlSaldoAnt);
        putitemXml(viParams, 'NR_CTAPESFCC', vNrCtaPesFCC);
        putitemXml(viParams, 'DT_MOVIMFCC', vDtMovimFCC);
        putitemXml(viParams, 'NR_SEQMOVFCC', vNrSeqMovFCC);
        voParams := activateCmp('FCCSVCO018', 'gravarLogMovtoCtaPes', viParams); (*,,,, *)
        if (xStatus < 0) then begin
          Result := voParams;
          return(-1); exit;
        end;
      end;
    end;
  end;

  clear_e(tFCX_CAIXAC);
  putitem_e(tFCX_CAIXAC, 'CD_EMPRESA', vCdEmpresaRetorno);
  putitem_e(tFCX_CAIXAC, 'CD_TERMINAL', vCdTerminal);
  putitem_e(tFCX_CAIXAC, 'DT_ABERTURA', vDtAbertura);
  putitem_e(tFCX_CAIXAC, 'NR_SEQ', vNrSeq);
  retrieve_e(tFCX_CAIXAC);
  if (xStatus < 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Caixa não encontrado!', cDS_METHOD);
    return(-1); exit;
  end;

  getParams(pParams); (* vCdEmpresaRetorno, xCdErro, xCtxErro *)
  if (xStatus < 0) then begin
    Result := SetStatus(STS_ERROR, {xCdErro} '', '{xCtxErro} ''', '');
    return(-1); exit;
  end;

  Result := '';
  putitemXml(Result, 'CD_EMPRESA', vCdEmpresaRetorno);
  putitemXml(Result, 'NR_CTAPES', item_f('NR_CTAPES', tFCX_CAIXAC));
  putitemXml(Result, 'CD_CTAPES_CXFILIAL', gcxFilial);
  putitemXml(Result, 'CD_CTAPES_CXMATRIZ', gcxMatriz);
  putitemXml(Result, 'VL_VALOR', vVlRetorno);

  return(0); exit;
end;

end.
