unit cSICSVCO002;

interface

(* COMPONENTES 
  ADMSVCO001 / 
*)        

uses
  Classes, SysUtils, DB,
  cServiceUnf, cDataSetUnf;

type
  T_SICSVCO002 = class(TcServiceUnf)
  private
    tGER_EMPRESA,
    tGER_POOLGRUPO,
    tGER_TERMINAL,
    tTMP_NR09 : TcDatasetUnf;
    function getParam(pParams : String = '') : String;
    function setEntidade(pParams : String = '') : String;
  protected
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;    
  published
    function validaLocal(pParams : String = '') : String;
    function validaterminal(pParams : String = '') : String;
    function validaNivelEmpresa(pParams : String = '') : String;
    function validaLogin(pParams : String = '') : String;
  end;

implementation

uses
  cADMSVCO001,
  cActivate, cStatus, cFuncao, cXml, dModulo;

var
  gDtEmpresa,
  gDtSistema,
  gInSaldoOFF : String;

//---------------------------------------------------------------
constructor T_SICSVCO002.Create(AOwner: TComponent);
//---------------------------------------------------------------
begin
  inherited Create(AOwner);
  setEntidade('');
end;

//--------------------------------
destructor T_SICSVCO002.Destroy;
//--------------------------------
begin
  inherited Destroy;
end;

//---------------------------------------------------------------
function T_SICSVCO002.getParam(pParams : String = '') : String;
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
  putitem(xParam, 'IN_SALDO_PRD_OFF');

  xParam := T_ADMSVCO001.GetParametro(xParam);

  gInSaldoOFF := itemXml('IN_SALDO_PRD_OFF', xParam);

  xParamEmp := '';
  putitem(xParamEmp, 'CD_CCUSTO');
  putitem(xParamEmp, 'CD_EMPRESA');
  putitem(xParamEmp, 'DT_SISTEMA');

  xParamEmp := T_ADMSVCO001.GetParamEmpresa(piCdEmpresa, xParamEmp);

  gDtEmpresa := itemXml('DT_SISTEMA', xParamEmp);

end;

//---------------------------------------------------------------
function T_SICSVCO002.setEntidade(pParams : String = '') : String;
//---------------------------------------------------------------
begin
  tGER_EMPRESA := GetEntidade('GER_EMPRESA');
  tGER_POOLGRUPO := GetEntidade('GER_POOLGRUPO');
  tGER_TERMINAL := GetEntidade('GER_TERMINAL');
  tTMP_NR09 := GetEntidade('TMP_NR09');
end;

//-----------------------------------------------------------
function T_SICSVCO002.validaLocal(pParams : String) : String;
//-----------------------------------------------------------
const
  cDS_METHOD = 'ADICIONAL=Operação: T_SICSVCO002.validaLocal()';
var
  vCdEmpValidacao, vCdPoolEmpresa : Real;
  vCdEmpresaIN, vCdEmpresaOUT, vTpValidacao : String;
  vInCCusto, vInEmpresa : Boolean;
begin
  Result := '';

  vCdEmpresaOUT := '';

  vCdEmpValidacao := itemXmlF('CD_EMPVALIDACAO', pParams);

  vCdEmpresaIN := itemXmlF('CD_EMPRESA', pParams);

  vInCCusto := itemXmlB('IN_CCUSTO', pParams);

  vInEmpresa := itemXmlB('IN_EMPRESA', pParams);

  if (vCdEmpValidacao = 0) then begin
    vCdEmpValidacao := itemXmlF('CD_EMPRESA', PARAM_GLB);
  end;
  if (vInEmpresa = True) then begin
    vTpValidacao := 'EMPRESA';
  end else begin
    clear_e(tGER_EMPRESA);
    putitem_e(tGER_EMPRESA, 'CD_EMPRESA', vCdEmpValidacao);
    retrieve_e(tGER_EMPRESA);
    if (xStatus >= 0) then begin
      if (item_f('CD_CCUSTO', tGER_EMPRESA) > 0) then begin
        if (vInCCusto = True) then begin
          vTpValidacao := 'CCUSTO';
        end else begin
          vTpValidacao := 'TOTAL';
        end;
      end else begin
        vTpValidacao := 'EMPRESA';
      end;
    end else begin
      vTpValidacao := 'EMPRESA';
    end;
  end;

  clear_e(tGER_EMPRESA);
  putitem_e(tGER_EMPRESA, 'CD_EMPRESA', vCdEmpresaIN);
  retrieve_e(tGER_EMPRESA);
  if (xStatus >= 0) then begin
    setocc(tGER_EMPRESA, 1);
    while (xStatus >=0) do begin
      if (vTpValidacao = 'EMPRESA') then begin
        if (item_f('CD_CCUSTO', tGER_EMPRESA) = 0) then begin
          putitem(vCdEmpresaOUT,  item_f('CD_EMPRESA', tGER_EMPRESA));
        end;
      end else if (vTpValidacao = 'CCUSTO') then begin
        if (item_f('CD_CCUSTO', tGER_EMPRESA) > 0) then begin
          putitem(vCdEmpresaOUT,  item_f('CD_EMPRESA', tGER_EMPRESA));
        end;
      end else if (vTpValidacao = 'TOTAL') then begin
        putitem(vCdEmpresaOUT,  item_f('CD_EMPRESA', tGER_EMPRESA));
      end;
      setocc(tGER_EMPRESA, curocc(tGER_EMPRESA) + 1);
    end;
  end;
  if (itemXml('IN_CONS_POOL', pParams) <> True) then begin
    vCdPoolEmpresa := itemXmlF('CD_POOLEMPRESA', PARAM_GLB);

    if (itemXml('CD_POOLEMPRESA', pParams) <> '') then begin
      vCdPoolEmpresa := itemXmlF('CD_POOLEMPRESA', pParams);
    end;

    clear_e(tTMP_NR09);
    getlistitems vCdEmpresaOUT, item_f('NR_GERAL', tTMP_NR09);

    if (vCdPoolEmpresa > 0) then begin
      setocc(tTMP_NR09, 1);
      while (xStatus >= 0) do begin
        clear_e(tGER_EMPRESA);
        putitem_e(tGER_EMPRESA, 'CD_EMPRESA', item_f('NR_GERAL', tTMP_NR09));
        retrieve_e(tGER_EMPRESA);
        if (xStatus >= 0) then begin
          clear_e(tGER_POOLGRUPO);
          putitem_e(tGER_POOLGRUPO, 'CD_POOLEMPRESA', vCdPoolEmpresa);
          putitem_e(tGER_POOLGRUPO, 'CD_GRUPOEMPRESA', item_f('CD_GRUPOEMPRESA', tGER_EMPRESA));
          retrieve_e(tGER_POOLGRUPO);
          if (xStatus >= 0) then begin
            setocc(tTMP_NR09, curocc(tTMP_NR09) + 1);
          end else begin
            discard(tTMP_NR09);
            if (xStatus = 0) then begin
              xStatus := -1;
            end;
          end;
        end else begin
          discard(tTMP_NR09);
          if (xStatus = 0) then begin
            xStatus := -1;
          end;
        end;
      end;
    end;

    sort_e(tTMP_NR09, '    sort/e , NR_GERAL;');
    putlistitems vCdEmpresaOUT, item_f('NR_GERAL', tTMP_NR09);
  end;

  Result := '';
  putitemXml(Result, 'CD_EMPRESA', vCdEmpresaOUT);

  return(0); exit;
end;

//--------------------------------------------------------------
function T_SICSVCO002.validaterminal(pParams : String) : String;
//--------------------------------------------------------------
const
  cDS_METHOD = 'ADICIONAL=Operação: T_SICSVCO002.validaterminal()';
var
  vCdEmpresa, vCdTerminal, vCdEmpresaCC : Real;
begin
  vCdEmpresa := itemXmlF('CD_EMPRESA', pParams);
  vCdTerminal := itemXmlF('CD_TERMINAL', pParams);

  if (vCdEmpresa = 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Empresa não informada!', cDS_METHOD);
    return(-1); exit;
  end;
  if (vCdTerminal = 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Terminal não informado!', cDS_METHOD);
    return(-1); exit;
  end;

  vCdEmpresaCC := 0;

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

  clear_e(tGER_TERMINAL);
  putitem_e(tGER_TERMINAL, 'CD_EMPRESA', vCdEmpresaCC);
  putitem_e(tGER_TERMINAL, 'CD_TERMINAL', vCdTerminal);
  retrieve_e(tGER_TERMINAL);
  if (xStatus < 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Terminal ' + FloatToStr(vCdTerminal) + ' não cadastrado na empresa ' + FloatToStr(vCdEmpresa) + '!', cDS_METHOD);
    return(-1); exit;
  end;

  return(0); exit;
end;

//------------------------------------------------------------------
function T_SICSVCO002.validaNivelEmpresa(pParams : String) : String;
//------------------------------------------------------------------
const
  cDS_METHOD = 'ADICIONAL=Operação: T_SICSVCO002.validaNivelEmpresa()';
var
  viParams, voParams, vDsLstEmpresa, vTpValidacao : String;
  vCdEmpresa : Real;
begin
  vDsLstEmpresa := '';
  vCdEmpresa := itemXmlF('CD_EMPRESA', pParams);

  if (vCdEmpresa = 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Empresa não informada!', cDS_METHOD);
    return(-1); exit;
  end;

  clear_e(tGER_EMPRESA);
  putitem_e(tGER_EMPRESA, 'CD_EMPRESA', vCdEmpresa);
  retrieve_e(tGER_EMPRESA);
  if (xStatus < 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Empresa ' + FloatToStr(vCdEmpresa) + ' não cadastrada!', cDS_METHOD);
    return(-1); exit;
  end;

  putitem(vDsLstEmpresa,  item_f('CD_EMPRESA', tGER_EMPRESA));

  if (item_f('CD_CCUSTO', tGER_EMPRESA) > 0) then begin
    putitem(vDsLstEmpresa,  item_f('CD_CCUSTO', tGER_EMPRESA));
  end;

  viParams := '';
  putitemXml(viParams, 'CD_EMPRESA', vDsLstEmpresa);
  newinstance 'SICSVCO002', 'SICSVCO002X', 'TRANSACTION=FALSE';
  voParams := activateCmp('SICSVCO002X', 'validaLocal', viParams); (*,,,, *)
  if (xStatus < 0) then begin
    Result := voParams;
    return(-1); exit;
  end;

  Result := voParams;

  return(0); exit;
end;

//-----------------------------------------------------------
function T_SICSVCO002.validaLogin(pParams : String) : String;
//-----------------------------------------------------------
const
  cDS_METHOD = 'ADICIONAL=Operação: T_SICSVCO002.validaLogin()';
var
  viParams, voParams, vDsLstEmpresa : String;
  vCdEmpresa, vCdEmpresaLogin : Real;
  vInCC : Boolean;
begin
  vCdEmpresaLogin := itemXmlF('CD_EMPRESA', PARAM_GLB);
  gDtSistema := itemXml('DT_SISTEMA', PARAM_GLB);
  vInCC := False;
  clear_e(tGER_EMPRESA);
  putitem_e(tGER_EMPRESA, 'CD_EMPRESA', vCdEmpresaLogin);
  retrieve_e(tGER_EMPRESA);
  if (xStatus < 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Empresa ' + FloatToStr(vCdEmpresa) + ' não cadastrada!', cDS_METHOD);
    return(-1); exit;
  end else begin
    if (item_f('CD_CCUSTO', tGER_EMPRESA) > 0) then begin
      vCdEmpresa := item_f('CD_CCUSTO', tGER_EMPRESA);
      vInCC := True;
    end else begin
      clear_e(tGER_EMPRESA);
      putitem_e(tGER_EMPRESA, 'CD_CCUSTO', vCdEmpresaLogin);
      retrieve_e(tGER_EMPRESA);
      if (xStatus >= 0) then begin
        vCdEmpresa := item_f('CD_EMPRESA', tGER_EMPRESA);
      end else begin
        return(0); exit;
      end;
    end;
  end;

  viParams := '';
  putitem(viParams,  'DT_SISTEMA');
  xParamEmp := T_ADMSVCO001.GetParamEmpresa(piCdEmpresa, xParamEmp); (*vCdEmpresa,,,, *)

  gDtEmpresa := itemXml('DT_SISTEMA', voParams);

  if (gDtEmpresa <> gDtSistema) then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Data da empresa ' + gDtSistema + ' incompativel com a data do grupo empresa ' + gDtEmpresa + '!', cDS_METHOD);
    if (vInCC = True) then begin
      exit(-2);
    end else begin
      return(-1); exit;
    end;
  end;

  return(0); exit;
end;


end.
