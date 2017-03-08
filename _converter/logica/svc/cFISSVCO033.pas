unit cFISSVCO033;

interface

        

uses
  Classes, SysUtils, Math, DB,
  cDataSetUnf;

type
  T_FISSVCO033 = class(TComponent)
  private
    tFIS_REGRAADIC,
    tFIS_REGRAFISC,
    tFIS_REGRASRV,
    tPRD_PRDREGRAF : TcDatasetUnf;
    function getParam(pParams : String = '') : String;
    function setEntidade(pParams : String = '') : String;
  protected
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;    
  published
    function buscaDadosRegraFiscal(pParams : String = '') : String;
    function buscaRegraFiscalProduto(pParams : String = '') : String;
    function buscaCfopExterior(pParams : String = '') : String;
  end;

implementation

uses
  cADMSVCO001,
  cActivate, cStatus, cFuncao, cXml, dModulo;

var


//---------------------------------------------------------------
constructor T_FISSVCO033.Create(AOwner: TComponent);
//---------------------------------------------------------------
begin
  inherited Create(AOwner);
  setEntidade('');
end;

//--------------------------------
destructor T_FISSVCO033.Destroy;
//--------------------------------
begin
  inherited Destroy;
end;

//---------------------------------------------------------------
function T_FISSVCO033.getParam(pParams : String = '') : String;
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
function T_FISSVCO033.setEntidade(pParams : String = '') : String;
//---------------------------------------------------------------
begin
  tFIS_REGRAADIC := TcDatasetUnf.getEntidade('FIS_REGRAADIC');
  tFIS_REGRAFISC := TcDatasetUnf.getEntidade('FIS_REGRAFISC');
  tFIS_REGRASRV := TcDatasetUnf.getEntidade('FIS_REGRASRV');
  tPRD_PRDREGRAF := TcDatasetUnf.getEntidade('PRD_PRDREGRAF');
end;

//---------------------------------------------------------------------
function T_FISSVCO033.buscaDadosRegraFiscal(pParams : String) : String;
//---------------------------------------------------------------------
const
  cDS_METHOD = 'ADICONAL=Operação: T_FISSVCO033.buscaDadosRegraFiscal()';
var
  vCdRegraFiscal : Real;
begin
  vCdRegraFiscal := itemXmlF('CD_REGRAFISCAL', pParams);

  if (vCdRegraFiscal = '') then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Regra fiscal não informada!', cDS_METHOD);
    return(-1); exit;
  end;

  clear_e(tFIS_REGRAFISC);
  putitem_e(tFIS_REGRAFISC, 'CD_REGRAFISCAL', vCdRegraFiscal);
  retrieve_e(tFIS_REGRAFISC);
  if (xStatus < 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Regra fiscal inválida!', cDS_METHOD);
    return(-1); exit;
  end;

  Result := '';
  putlistitensocc_e(Result, tFIS_REGRAFISC);
  putitemXml(Result, 'CD_CFOPSERVICO', item_f('CD_CFOP', tFIS_REGRASRV));
  putitemXml(Result, 'CD_CSTSERVICO', item_f('CD_CST', tFIS_REGRASRV));

  return(0); exit;
end;

//-----------------------------------------------------------------------
function T_FISSVCO033.buscaRegraFiscalProduto(pParams : String) : String;
//-----------------------------------------------------------------------
const
  cDS_METHOD = 'ADICONAL=Operação: T_FISSVCO033.buscaRegraFiscalProduto()';
var
  vCdProduto, vCdOperacao : Real;
begin
  vCdProduto := itemXmlF('CD_PRODUTO', pParams);
  vCdOperacao := itemXmlF('CD_OPERACAO', pParams);

  if (vCdProduto = '') then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Código do produto não informado!', cDS_METHOD);
    return(-1); exit;
  end;
  if (vCdOperacao = '') then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Código da operação não informado!', cDS_METHOD);
    return(-1); exit;
  end;

  clear_e(tPRD_PRDREGRAF);
  putitem_e(tPRD_PRDREGRAF, 'CD_PRODUTO', vCdProduto);
  putitem_e(tPRD_PRDREGRAF, 'CD_OPERACAO', vCdOperacao);
  retrieve_e(tPRD_PRDREGRAF);
  if (xStatus < 0) then begin
    clear_e(tPRD_PRDREGRAF);
  end;

  Result := '';
  putlistitensocc_e(Result, tPRD_PRDREGRAF);

  return(0); exit;

end;

//-----------------------------------------------------------------
function T_FISSVCO033.buscaCfopExterior(pParams : String) : String;
//-----------------------------------------------------------------
const
  cDS_METHOD = 'ADICONAL=Operação: T_FISSVCO033.buscaCfopExterior()';
var
  vCdRegraFiscal : Real;
begin
  vCdRegraFiscal := itemXmlF('CD_REGRAFISCAL', pParams);

  if (vCdRegraFiscal = '') then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Regra fiscal não informada!', cDS_METHOD);
    return(-1); exit;
  end;

  clear_e(tFIS_REGRAADIC);
  putitem_e(tFIS_REGRAADIC, 'CD_REGRAFISCAL', vCdRegraFiscal);
  retrieve_e(tFIS_REGRAADIC);
  if (xStatus < 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'CFOP para o exterior não configurada para a regra fiscal!', cDS_METHOD);
    return(-1); exit;
  end;

  Result := '';
  putlistitensocc_e(Result, tFIS_REGRAADIC);

  return(0); exit;

end;

end.
