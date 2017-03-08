unit cFGRSVCO003;

interface

        

uses
  Classes, SysUtils, Math, DB,
  cServiceUnf, cDataSetUnf;

type
  T_FGRSVCO003 = class(TcServiceUnf)
  private
    tGER_TERMINAL,
    tGER_TERMINALP,
    tGLB_PERIFERIC : TcDatasetUnf;
    function getParam(pParams : String = '') : String;
    function setEntidade(pParams : String = '') : String;
  protected
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;    
  published
    function processaCheque(pParams : String = '') : String;
    function leCheque(pParams : String = '') : String;
  end;

implementation

uses
  cADMSVCO001,
  cActivate, cStatus, cFuncao, cXml, dModulo;

var


//---------------------------------------------------------------
constructor T_FGRSVCO003.Create(AOwner: TComponent);
//---------------------------------------------------------------
begin
  inherited Create(AOwner);
  setEntidade('');
end;

//--------------------------------
destructor T_FGRSVCO003.Destroy;
//--------------------------------
begin
  inherited Destroy;
end;

//---------------------------------------------------------------
function T_FGRSVCO003.getParam(pParams : String = '') : String;
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

  xParamEmp := T_ADMSVCO001.GetParamEmpresa(piCdEmpresa, xParamEmp);


end;

//---------------------------------------------------------------
function T_FGRSVCO003.setEntidade(pParams : String = '') : String;
//---------------------------------------------------------------
begin
  tGER_TERMINAL := GetEntidade('GER_TERMINAL');
  tGER_TERMINALP := GetEntidade('GER_TERMINALP');
  tGLB_PERIFERIC := GetEntidade('GLB_PERIFERIC');
end;

//--------------------------------------------------------------
function T_FGRSVCO003.processaCheque(pParams : String) : String;
//--------------------------------------------------------------
const
  cDS_METHOD = 'ADICONAL=Operação: T_FGRSVCO003.processaCheque()';
var
  voParams, viParams : String;
  vCdTerminal , vTotPeriferico : Real;
begin
  vCdTerminal := itemXmlF('CD_TERMINAL', PARAM_GLB);
  if (vCdTerminal = 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Terminal não informado!', cDS_METHOD);
    return(-1); exit;
  end;

  clear_e(tGER_TERMINALP);
  putitem_e(tGER_TERMINALP, 'CD_EMPRESA', itemXmlF('CD_EMPRESA', PARAM_GLB));
  putitem_e(tGER_TERMINALP, 'CD_TERMINAL', vCdTerminal);
  putitem_e(tGER_TERMINALP, 'TP_PERIFERICO', 1);
  retrieve_e(tGER_TERMINALP);
  if (xStatus < 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Nenhuma impressora de cheque encontrada para o terminal ' + FloatToStr(vCdTerminal) + ' na empresa ' + CD_EMPRESA + '.GER_TERMINALP!', cDS_METHOD);
    return(-1); exit;
  end else begin
    setocc(tGER_TERMINALP, -1);
    vTotPeriferico := totocc(tGER_TERMINAL);
    if (vTotPeriferico > 1) then begin
      Result := SetStatus(STS_ERROR, 'GEN0001', 'Existem ' + vTotPeriferico + ' impressoras de cheque cadastrado ao terminal. Verificar no componente GERFL040!', cDS_METHOD);
      return(-1); exit;
    end;
  end;

  clear_e(tGLB_PERIFERIC);
  putitem_e(tGLB_PERIFERIC, 'CD_PERIFERICO', item_f('CD_PERIFERICO', tGER_TERMINALP));
  retrieve_e(tGLB_PERIFERIC);
  if (xStatus < 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Periférico ' + CD_PERIFERICO + '.GER_TERMINALP não encontrado!', cDS_METHOD);
    return(-1); exit;
  end;

  putitemXml(pParams, 'DS_PORTA', item_a('DS_PORTA', tGER_TERMINALP));
  voParams := activateCmp('' + DS_COMPONENTE + '.GLB_PERIFERIC', 'GLB_PERIFERIC'.imprimeCheque', viParams); (*,pParams,voParams,, *)
  if (xStatus < 0) then begin
    Result := voParams;
    return(-1); exit;
  end;

  Result := voParams;

  return(0); exit;
end;

//--------------------------------------------------------
function T_FGRSVCO003.leCheque(pParams : String) : String;
//--------------------------------------------------------
const
  cDS_METHOD = 'ADICONAL=Operação: T_FGRSVCO003.leCheque()';
var
  voParams : String;
  vCdTerminal : Real;
begin
  vCdTerminal := itemXmlF('CD_TERMINAL', PARAM_GLB);
  if (vCdTerminal = 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Terminal não informado!', cDS_METHOD);
    return(-1); exit;
  end;

  clear_e(tGER_TERMINALP);
  putitem_e(tGER_TERMINALP, 'CD_EMPRESA', itemXmlF('CD_EMPRESA', PARAM_GLB));
  putitem_e(tGER_TERMINALP, 'CD_TERMINAL', vCdTerminal);
  putitem_e(tGER_TERMINALP, 'TP_PERIFERICO', '1or2');
  retrieve_e(tGER_TERMINALP);
  if (xStatus < 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Nenhuma impressora de cheque encontrada para o terminal ' + FloatToStr(vCdTerminal) + ' na empresa ' + CD_EMPRESA + '.GER_TERMINALP!', cDS_METHOD);
    return(-1); exit;
  end;

  clear_e(tGLB_PERIFERIC);
  putitem_e(tGLB_PERIFERIC, 'CD_PERIFERICO', item_f('CD_PERIFERICO', tGER_TERMINALP));
  retrieve_e(tGLB_PERIFERIC);
  if (xStatus < 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Periférico ' + CD_PERIFERICO + '.GER_TERMINALP não encontrado!', cDS_METHOD);
    return(-1); exit;
  end;

  voParams := activateCmp('' + DS_COMPONENTE + '.GLB_PERIFERIC', 'GLB_PERIFERIC'.leCheque', viParams); (*,pParams,voParams,, *)
  if (xStatus < 0) then begin
    Result := voParams;
    return(-1); exit;
  end;
  Result := voParams;

  return(0); exit;
end;

end.
