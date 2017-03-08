unit cFCXSVCO001;

interface

(* COMPONENTES 
  ADMSVCO001 / ADMSVCO027 / FCCSVCO002 / FCXSVCO002 / SICSVCO007

*)        

uses
  Classes, SysUtils, Math, DB,
  cDataSetUnf;

type
  T_FCXSVCO001 = class(TComponent)
  private
    tFCX_CAIXAC,
    tFCX_TERMINALU : TcDatasetUnf;
    function getParam(pParams : String = '') : String;
    function setEntidade(pParams : String = '') : String;
  protected
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;    
  published
    function buscaCaixa(pParams : String = '') : String;
    function validaCaixaAberto(pParams : String = '') : String;
    function buscaCaixaOper(pParams : String = '') : String;
    function buscaCaixaConf(pParams : String = '') : String;
    function buscarSaldoCaixaUsuario(pParams : String = '') : String;
  end;

implementation

uses
  cADMSVCO001,
  cActivate, cStatus, cFuncao, cXml, dModulo;

var
  gInCxTerminal,
  gInLanctoRetro,
  gInPdvOtimizado,
  gInValidaCxEncerramento,
  gnmLogin,
  gVlAlertaSangriaCxUsu : String;

//---------------------------------------------------------------
constructor T_FCXSVCO001.Create(AOwner: TComponent);
//---------------------------------------------------------------
begin
  inherited Create(AOwner);
  setEntidade('');
end;

//--------------------------------
destructor T_FCXSVCO001.Destroy;
//--------------------------------
begin
  inherited Destroy;
end;

//---------------------------------------------------------------
function T_FCXSVCO001.getParam(pParams : String = '') : String;
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
  putitem(xParam, 'IN_LANCTO_RETROATIVO_CX');

  xParam := T_ADMSVCO001.GetParametro(xParam);

  gInCxTerminal := itemXml('IN_CAIXA_TERMINAL', xParam);
  gInLanctoRetro := itemXml('IN_LANCTO_RETROATIVO_CX', xParam);
  gInPdvOtimizado := itemXml('IN_PDV_OTIMIZADO', xParam);
  gInValidaCxEncerramento := itemXml('IN_VALIDA_CX_ENCERRAMENTO', xParam);
  gVlAlertaSangriaCxUsu := itemXml('VL_ALERTA_SANGRIA_CX_USU', xParam);
  vCdEmpLogin := itemXml('CD_EMPRESA', xParam);
  vCdEmpresa := itemXml('CD_EMPRESA', xParam);
  vCdOperCx := itemXml('CD_OPERADOR', xParam);
  vCdOperCx := itemXml('CD_USUARIO', xParam);
  vCdTerminal := itemXml('CD_TERMINAL', xParam);

  xParamEmp := '';
  putitem(xParamEmp, 'IN_CAIXA_TERMINAL');
  putitem(xParamEmp, 'IN_LANCTO_RETROATIVO_CX');
  putitem(xParamEmp, 'IN_PDV_OTIMIZADO');
  putitem(xParamEmp, 'IN_VALIDA_CX_ENCERRAMENTO');
  putitem(xParamEmp, 'VL_ALERTA_SANGRIA_CX_USU');

  xParamEmp := T_ADMSVCO001.GetParamEmpresa(piCdEmpresa, xParamEmp);

  gInCxTerminal := itemXml('IN_CAIXA_TERMINAL', xParamEmp);
  gInPdvOtimizado := itemXml('IN_PDV_OTIMIZADO', xParamEmp);
  gInValidaCxEncerramento := itemXml('IN_VALIDA_CX_ENCERRAMENTO', xParamEmp);
  gVlAlertaSangriaCxUsu := itemXml('VL_ALERTA_SANGRIA_CX_USU', xParamEmp);
  vCdEmpLogin := itemXml('CD_EMPRESA', xParamEmp);
  vCdEmpresa := itemXml('CD_EMPRESA', xParamEmp);
  vCdOperCx := itemXml('CD_OPERADOR', xParamEmp);
  vCdOperCx := itemXml('CD_USUARIO', xParamEmp);
  vCdTerminal := itemXml('CD_TERMINAL', xParamEmp);

end;

//---------------------------------------------------------------
function T_FCXSVCO001.setEntidade(pParams : String = '') : String;
//---------------------------------------------------------------
begin
  tFCX_CAIXAC := TcDatasetUnf.getEntidade('FCX_CAIXAC');
  tFCX_TERMINALU := TcDatasetUnf.getEntidade('FCX_TERMINALU');
end;

//----------------------------------------------------------
function T_FCXSVCO001.buscaCaixa(pParams : String) : String;
//----------------------------------------------------------
const
  cDS_METHOD = 'ADICONAL=Operação: T_FCXSVCO001.buscaCaixa()';
var
  viParams, voParams : String;
  vCdTerminal, vCdOperCx, vCdEmpresa, vCdEmpLogin : Real;
  vDtSistema : TDate;
begin
  vCdEmpLogin := itemXmlF('CD_EMPRESA', PARAM_GLB);

  vCdEmpresa := itemXmlF('CD_EMPRESA', pParams);
  if (vCdEmpresa = 0) then begin
    vCdEmpresa := itemXmlF('CD_EMPRESA', PARAM_GLB);
  end;
  vCdOperCx := itemXmlF('CD_OPERADOR', pParams);
  if (vCdOperCx = 0) then begin
    vCdOperCx := itemXmlF('CD_USUARIO', PARAM_GLB);
  end;
  vCdTerminal := itemXmlF('CD_TERMINAL', PARAM_GLB);

  if (vCdTerminal = 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Terminal não informado - Empresa ' + FloatToStr(vCdEmpLogin!',) + ' cDS_METHOD);
    return(-1); exit;
  end;

  getParams(pParams); (*  *)
  if (xStatus < 0) then begin
    return(-1); exit;
  end;

  clear_e(tFCX_CAIXAC);
  putitem_e(tFCX_CAIXAC, 'CD_EMPRESA', vCdEmpresa);
  putitem_e(tFCX_CAIXAC, 'CD_TERMINAL', vCdTerminal);
  putitem_e(tFCX_CAIXAC, 'IN_FECHADO', False);
  retrieve_e(tFCX_CAIXAC);
  if (xStatus < 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Não existe caixa aberto para o terminal ' + FloatToStr(vCdTerminal) + ' - Empresa ' + FloatToStr(vCdEmpLogin!',) + ' cDS_METHOD);
    return(-1); exit;
  end else begin
    if (item_f('CD_OPERCONF', tFCX_CAIXAC) > 0) then begin
      Result := SetStatus(STS_ERROR, 'GEN0001', 'Caixa para o terminal ' + FloatToStr(vCdTerminal) + ' encerrado!', cDS_METHOD);
      return(-1); exit;
    end;
  end;
  if (gInCxTerminal <> True) then begin
    if (item_f('CD_OPERCX', tFCX_CAIXAC) <> vCdOperCx) then begin
      Result := SetStatus(STS_ERROR, 'GEN0001', 'Terminal ' + FloatToStr(vCdTerminal) + ' possui caixa aberto para o usuário ' + item_a('CD_OPERCX', tFCX_CAIXAC) + ' - Empresa ' + FloatToStr(vCdEmpLogin!',) + ' cDS_METHOD);
      return(-1); exit;
    end;
  end;

  viParams := '';
  putlistitensocc_e(viParams, tFCX_CAIXAC);
  voParams := activateCmp('SICSVCO007', 'validaCaixa', viParams);
  if (xStatus < 0) then begin
    Result := voParams;
    return(-1); exit;
  end;

  vDtSistema := itemXml('DT_SISTEMA', PARAM_GLB);

  Result := '';
  putitemXml(Result, 'CD_EMPRESA', item_f('CD_EMPRESA', tFCX_CAIXAC));
  putitemXml(Result, 'CD_TERMINAL', item_f('CD_TERMINAL', tFCX_CAIXAC));
  putitemXml(Result, 'DT_ABERTURA', item_a('DT_ABERTURA', tFCX_CAIXAC));
  putitemXml(Result, 'NR_SEQ', item_f('NR_SEQ', tFCX_CAIXAC));
  putitemXml(Result, 'NR_CTAPES', item_f('NR_CTAPES', tFCX_CAIXAC));

  if (gInLanctoRetro <> True)  and (item_a('DT_ABERTURA', tFCX_CAIXAC) <> vDtSistema) then begin
    putitemXml(Result, 'IN_CONTINUA', True);

    Result := SetStatus(STS_ERROR, 'GEN0001', 'Caixa aberto com data retroativa ' + item_a('DT_ABERTURA', tFCX_CAIXAC). + ' Verifique!', cDS_METHOD);
    return(-1); exit;
  end;

  return(0); exit;
end;

//-----------------------------------------------------------------
function T_FCXSVCO001.validaCaixaAberto(pParams : String) : String;
//-----------------------------------------------------------------
const
  cDS_METHOD = 'ADICONAL=Operação: T_FCXSVCO001.validaCaixaAberto()';
var
  vCdEmpresa, vDsErro, viParams, voParams : String;
begin
  gnmLogin := '';
  vCdEmpresa := itemXmlF('CD_EMPRESA', pParams);
  if (vCdEmpresa = '') then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Empresa não informada!', cDS_METHOD);
    return(-1); exit;
  end;

  getParams(pParams); (*  *)
  if (xStatus < 0) then begin
    return(-1); exit;
  end;

  vDsErro := '';

  clear_e(tFCX_CAIXAC);
  putitem_e(tFCX_CAIXAC, 'CD_EMPRESA', vCdEmpresa);
  putitem_e(tFCX_CAIXAC, 'IN_FECHADO', False);
  retrieve_e(tFCX_CAIXAC);
  if (xStatus >= 0) then begin
    setocc(tFCX_CAIXAC, 1);
    while(xStatus >= 0) do begin
      if (gInPdvOtimizado = True) then begin
        if (empty('FCX_CAIXAMSVC') = 0) then begin
          clear_e(tFCX_TERMINALU);
          putitem_e(tFCX_TERMINALU, 'CD_EMPRESA', item_f('CD_EMPRESA', tFCX_CAIXAC));
          putitem_e(tFCX_TERMINALU, 'CD_TERMINAL', item_f('CD_TERMINAL', tFCX_CAIXAC));
          retrieve_e(tFCX_TERMINALU);
          if (xStatus >= 0) then begin
            if (item_f('CD_USUARIO', tFCX_TERMINALU) <> '') then begin
              viParams := '';
              putitemXml(viParams, 'CD_USUARIO', item_f('CD_USUARIO', tFCX_TERMINALU));
              voParams := activateCmp('ADMSVCO027', 'validaUsuarioEspecial', viParams);
              if (xStatus < 0) then begin
                Result := voParams;
                return(-1); exit;
              end;
            end;
          end else begin
            vDsErro := '' + vDsErroEmpresa/Terminal: + ' ' + item_f('CD_EMPRESA', tFCX_CAIXAC) + ' / ' + item_f('CD_TERMINAL', tFCX_CAIXAC) + ' ';
          end;
        end else begin
          viParams := '';
          putlistitensocc_e(viParams, tFCX_CAIXAC);

          putitemXml(viParams, 'IN_CXTERMINAL', True);
          voParams := activateCmp('FCXSVCO002', 'fechaCaixa', viParams);
          if (xStatus < 0) then begin
            Result := voParams;
            return(-1); exit;
          end;
        end;
      end else begin
        vDsErro := '' + vDsErroEmpresa/Terminal: + ' ' + item_f('CD_EMPRESA', tFCX_CAIXAC) + ' / ' + item_f('CD_TERMINAL', tFCX_CAIXAC) + ' ';
      end;
      setocc(tFCX_CAIXAC, curocc(tFCX_CAIXAC) + 1);
    end;
  end;

  Result := '';
  if (vDsErro <> '') then begin
    putitemXml(Result, 'DS_LOGERRO', vDsErro);
    return(-1); exit;
  end;

  return(0); exit;
end;

//--------------------------------------------------------------
function T_FCXSVCO001.buscaCaixaOper(pParams : String) : String;
//--------------------------------------------------------------
const
  cDS_METHOD = 'ADICONAL=Operação: T_FCXSVCO001.buscaCaixaOper()';
var
  viParams, voParams : String;
  vCdOperCx, vCdEmpresa, vCdTerminal : Real;
begin
  getParams(pParams); (*  *)
  if (xStatus < 0) then begin
    return(-1); exit;
  end;

  vCdEmpresa := itemXmlF('CD_EMPRESA', pParams);
  if (vCdEmpresa = 0) then begin
    vCdEmpresa := itemXmlF('CD_EMPRESA', PARAM_GLB);
  end;
  if (gInCxTerminal <> True) then begin
    vCdOperCx := itemXmlF('CD_OPERCX', pParams);

    if (vCdOperCx = 0) then begin
      Result := SetStatus(STS_ERROR, 'GEN0001', 'Operador não informado!', cDS_METHOD);
      return(-1); exit;
    end;

    clear_e(tFCX_CAIXAC);
    putitem_e(tFCX_CAIXAC, 'CD_EMPRESA', vCdEmpresa);
    putitem_e(tFCX_CAIXAC, 'CD_OPERCX', vCdOperCx);
    putitem_e(tFCX_CAIXAC, 'IN_FECHADO', False);
    retrieve_e(tFCX_CAIXAC);
    if (xStatus < 0) then begin
      Result := SetStatus(STS_ERROR, 'GEN0001', 'Não existe caixa aberto para o operador ' + FloatToStr(vCdOperCx!',) + ' cDS_METHOD);
      return(-1); exit;
    end else begin
      if (item_f('CD_OPERCONF', tFCX_CAIXAC) > 0) then begin
        Result := SetStatus(STS_ERROR, 'GEN0001', 'Caixa para o operador ' + FloatToStr(vCdOperCx) + ' encerrado!', cDS_METHOD);
        return(-1); exit;
      end;
    end;
  end else begin
    vCdTerminal := itemXmlF('CD_TERMINAL', pParams);
    if (vCdTerminal = 0) then begin
      vCdTerminal := itemXmlF('CD_TERMINAL', PARAM_GLB);
    end;
    if (vCdTerminal = 0) then begin
      Result := SetStatus(STS_ERROR, 'GEN0001', 'Terminal não informado!', cDS_METHOD);
      return(-1); exit;
    end;

    clear_e(tFCX_CAIXAC);
    putitem_e(tFCX_CAIXAC, 'CD_EMPRESA', vCdEmpresa);
    putitem_e(tFCX_CAIXAC, 'CD_TERMINAL', vCdTerminal);
    putitem_e(tFCX_CAIXAC, 'IN_FECHADO', False);
    retrieve_e(tFCX_CAIXAC);
    if (xStatus < 0) then begin
      Result := SetStatus(STS_ERROR, 'GEN0001', 'Não existe caixa aberto para o terminal ' + FloatToStr(vCdTerminal!',) + ' cDS_METHOD);
      return(-1); exit;
    end else begin
      if (item_f('CD_OPERCONF', tFCX_CAIXAC) > 0) then begin
        Result := SetStatus(STS_ERROR, 'GEN0001', 'Caixa para o terminal ' + FloatToStr(vCdTerminal) + ' encerrado!', cDS_METHOD);
        return(-1); exit;
      end;
    end;
  end;

  viParams := '';
  putlistitensocc_e(viParams, tFCX_CAIXAC);
  voParams := activateCmp('SICSVCO007', 'validaCaixa', viParams);
  if (xStatus < 0) then begin
    Result := voParams;
    return(-1); exit;
  end;

  Result := '';
  putitemXml(Result, 'CD_EMPRESA', item_f('CD_EMPRESA', tFCX_CAIXAC));
  putitemXml(Result, 'CD_TERMINAL', item_f('CD_TERMINAL', tFCX_CAIXAC));
  putitemXml(Result, 'DT_ABERTURA', item_a('DT_ABERTURA', tFCX_CAIXAC));
  putitemXml(Result, 'NR_SEQ', item_f('NR_SEQ', tFCX_CAIXAC));
  putitemXml(Result, 'NR_CTAPES', item_f('NR_CTAPES', tFCX_CAIXAC));

  return(0); exit;
end;

//--------------------------------------------------------------
function T_FCXSVCO001.buscaCaixaConf(pParams : String) : String;
//--------------------------------------------------------------
const
  cDS_METHOD = 'ADICONAL=Operação: T_FCXSVCO001.buscaCaixaConf()';
var
  viParams, voParams : String;
  vCdTerminal, vCdOperCx, vCdEmpresa, vCdEmpLogin : Real;
  vDtSistema : TDate;
begin
  vCdEmpLogin := itemXmlF('CD_EMPRESA', PARAM_GLB);

  vCdEmpresa := itemXmlF('CD_EMPRESA', pParams);
  if (vCdEmpresa = 0) then begin
    vCdEmpresa := itemXmlF('CD_EMPRESA', PARAM_GLB);
  end;
  vCdOperCx := itemXmlF('CD_OPERADOR', pParams);
  if (vCdOperCx = 0) then begin
    vCdOperCx := itemXmlF('CD_USUARIO', PARAM_GLB);
  end;
  vCdTerminal := itemXmlF('CD_TERMINAL', PARAM_GLB);

  if (vCdTerminal = 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Terminal não informado - Empresa ' + FloatToStr(vCdEmpLogin!',) + ' cDS_METHOD);
    return(-1); exit;
  end;

  getParams(pParams); (*  *)
  if (xStatus < 0) then begin
    return(-1); exit;
  end;

  clear_e(tFCX_CAIXAC);
  putitem_e(tFCX_CAIXAC, 'CD_EMPRESA', vCdEmpresa);
  putitem_e(tFCX_CAIXAC, 'CD_TERMINAL', vCdTerminal);
  putitem_e(tFCX_CAIXAC, 'IN_FECHADO', False);
  retrieve_e(tFCX_CAIXAC);
  if (xStatus < 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Não existe caixa aberto para o terminal ' + FloatToStr(vCdTerminal) + ' - Empresa ' + FloatToStr(vCdEmpLogin!',) + ' cDS_METHOD);
    return(-1); exit;
  end;
  if (gInCxTerminal <> True) then begin
    if (item_f('CD_OPERCX', tFCX_CAIXAC) <> vCdOperCx) then begin
      Result := SetStatus(STS_ERROR, 'GEN0001', 'Terminal ' + FloatToStr(vCdTerminal) + ' possui caixa aberto para o usuário ' + item_a('CD_OPERCX', tFCX_CAIXAC) + ' - Empresa ' + FloatToStr(vCdEmpLogin!',) + ' cDS_METHOD);
      return(-1); exit;
    end;
  end;

  viParams := '';
  putlistitensocc_e(viParams, tFCX_CAIXAC);
  voParams := activateCmp('SICSVCO007', 'validaCaixa', viParams);
  if (xStatus < 0) then begin
    Result := voParams;
    return(-1); exit;
  end;

  vDtSistema := itemXml('DT_SISTEMA', PARAM_GLB);

  Result := '';
  putitemXml(Result, 'CD_EMPRESA', item_f('CD_EMPRESA', tFCX_CAIXAC));
  putitemXml(Result, 'CD_TERMINAL', item_f('CD_TERMINAL', tFCX_CAIXAC));
  putitemXml(Result, 'DT_ABERTURA', item_a('DT_ABERTURA', tFCX_CAIXAC));
  putitemXml(Result, 'NR_SEQ', item_f('NR_SEQ', tFCX_CAIXAC));
  putitemXml(Result, 'NR_CTAPES', item_f('NR_CTAPES', tFCX_CAIXAC));

  return(0); exit;

end;

//-----------------------------------------------------------------------
function T_FCXSVCO001.buscarSaldoCaixaUsuario(pParams : String) : String;
//-----------------------------------------------------------------------
const
  cDS_METHOD = 'ADICONAL=Operação: T_FCXSVCO001.buscarSaldoCaixaUsuario()';
var
  viParams, voParams, vLstEmpresa, vCdEmpresa : String;
  vSaldoDinheiro, vSaldoCheque, vSaldoCaixa, vCdTerminal, vNrCtaPes : Real;
begin
  vLstEmpresa := itemXml('LST_EMPRESA', pParams);
  if (vLstEmpresa = '') then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Empresa não informada!', cDS_METHOD);
    return(-1); exit;
  end;

  getParams(pParams); (*  *)
  if (xStatus < 0) then begin
    Result := voParams;
    return(-1); exit;
  end;

  vSaldoDinheiro := 0;
  vSaldoCheque := 0;
  repeat
    getitem(vCdEmpresa, vLstEmpresa, 1);

    viParams := '';
    putitemXml(viParams, 'CD_EMPRESA', vCdEmpresa);
    voParams := buscaCaixa(viParams); (* PARAM_GLB, viParams, voParams, xCdErro, xCtxErro *)
    if (xStatus < 0) then begin
      Result := voParams;
      return(-1); exit;
    end;
    if (itemXml('NR_CTAPES', voParams)<> '') then begin
      vNrCtaPes := itemXmlF('NR_CTAPES', voParams);

      viParams := '';
      putitemXml(viParams, 'NR_CTAPES', vNrCtaPes);
      putitemXml(viParams, 'TP_DOCUMENTO', 3);
      putitemXml(viParams, 'NR_SEQHISTRELSUB', 1);
      putitemXml(viParams, 'DT_SALDO', itemXml('DT_SISTEMA', PARAM_GLB));
      voParams := activateCmp('FCCSVCO002', 'buscaSaldoCtaTp', viParams);
      if (xStatus < 0) then begin
        Result := voParams;
        return(-1); exit;
      end;
      if (itemXml('VL_SALDO', voParams) > 0) then begin
        vSaldoDinheiro := vSaldoDinheiro + itemXmlF('VL_SALDO', voParams);
      end;

      viParams := '';
      putitemXml(viParams, 'NR_CTAPES', vNrCtaPes);
      putitemXml(viParams, 'TP_DOCUMENTO', 2);
      putitemXml(viParams, 'NR_SEQHISTRELSUB', 1);
      putitemXml(viParams, 'DT_SALDO', itemXml('DT_SISTEMA', PARAM_GLB));
      voParams := activateCmp('FCCSVCO002', 'buscaSaldoCtaTp', viParams);
      if (xStatus < 0) then begin
        Result := voParams;
        return(-1); exit;
      end;
      if (itemXml('VL_SALDO', voParams) > 0) then begin
        vSaldoCheque := vSaldoCheque + itemXmlF('VL_SALDO', voParams);
      end;
    end;
    delitem(vLstEmpresa, 1);
  until(vLstEmpresa = '');

  if ((vSaldoDinheiro + vSaldocheque) >= gVlAlertaSangriaCxUsu) then begin
    Result := SetStatus(STS_AVISO, 'GEN0001', , cDS_METHOD);
    Result := '';
    putitemXml(Result, 'IN_SANGRIA', True);
    return(0); exit;
  end;

  return(0); exit;
end;

end.
