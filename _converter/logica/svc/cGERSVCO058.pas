unit cGERSVCO058;

interface

        

uses
  Classes, SysUtils, Math, DB,
  cServiceUnf, cDataSetUnf;

type
  T_GERSVCO058 = class(TcServiceUnf)
  private
    tFIS_NF,
    tFIS_NFITEM,
    tGER_OPERCFOP,
    tTRA_TRANSACAO,
    tTRA_TRANSITEM : TcDatasetUnf;
    function getParam(pParams : String = '') : String;
    function setEntidade(pParams : String = '') : String;
  protected
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;    
  published
    function buscaValorFinanceiroTransacao(pParams : String = '') : String;
    function buscaDadosGerOperCfopTra(pParams : String = '') : String;
    function buscaDadosGerOperCfopNf(pParams : String = '') : String;
  end;

implementation

uses
  cADMSVCO001,
  cActivate, cStatus, cFuncao, cXml, dModulo;

var


//---------------------------------------------------------------
constructor T_GERSVCO058.Create(AOwner: TComponent);
//---------------------------------------------------------------
begin
  inherited Create(AOwner);
  setEntidade('');
end;

//--------------------------------
destructor T_GERSVCO058.Destroy;
//--------------------------------
begin
  inherited Destroy;
end;

//---------------------------------------------------------------
function T_GERSVCO058.getParam(pParams : String = '') : String;
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
function T_GERSVCO058.setEntidade(pParams : String = '') : String;
//---------------------------------------------------------------
begin
  tFIS_NF := GetEntidade('FIS_NF');
  tFIS_NFITEM := GetEntidade('FIS_NFITEM');
  tGER_OPERCFOP := GetEntidade('GER_OPERCFOP');
  tTRA_TRANSACAO := GetEntidade('TRA_TRANSACAO');
  tTRA_TRANSITEM := GetEntidade('TRA_TRANSITEM');
end;

//-----------------------------------------------------------------------------
function T_GERSVCO058.buscaValorFinanceiroTransacao(pParams : String) : String;
//-----------------------------------------------------------------------------
const
  cDS_METHOD = 'ADICONAL=Operação: T_GERSVCO058.buscaValorFinanceiroTransacao()';
var
  vCdEmpresa, vNrTransacao, vVlFinanceiro : Real;
  vDtTransacao : TDate;
begin
  vVlFinanceiro := '';
  vCdEmpresa := itemXmlF('CD_EMPRESA', pParams);
  vNrTransacao := itemXmlF('NR_TRANSACAO', pParams);
  vDtTransacao := itemXml('DT_TRANSACAO', pParams);

  if (vCdEmpresa = 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Empresa não informada!', cDS_METHOD);
    return(-1); exit;
  end;
  if (vNrTransacao = 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Número transação não informado!', cDS_METHOD);
    return(-1); exit;
  end;
  if (vDtTransacao = '') then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Data transação não informada!', cDS_METHOD);
    return(-1); exit;
  end;

  clear_e(tTRA_TRANSACAO);
  putitem_e(tTRA_TRANSACAO, 'CD_EMPRESA', vCdEmpresa);
  putitem_e(tTRA_TRANSACAO, 'NR_TRANSACAO', vNrTransacao);
  putitem_e(tTRA_TRANSACAO, 'DT_TRANSACAO', vDtTransacao);
  retrieve_e(tTRA_TRANSACAO);
  if (xStatus < 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Transação ' + FloatToStr(vNrTransacao) + ' não cadastrada!', cDS_METHOD);
    return(-1); exit;
  end;

  clear_e(tGER_OPERCFOP);
  putitem_e(tGER_OPERCFOP, 'CD_OPERACAO', item_f('CD_OPERACAO', tTRA_TRANSACAO));
  retrieve_e(tGER_OPERCFOP);
  if (xStatus >= 0) then begin
    setocc(tTRA_TRANSITEM, 1);
    while (xStatus >= 0) do begin
      clear_e(tGER_OPERCFOP);
      putitem_e(tGER_OPERCFOP, 'CD_OPERACAO', item_f('CD_OPERACAO', tTRA_TRANSACAO));
      putitem_e(tGER_OPERCFOP, 'CD_CFOP', item_f('CD_CFOP', tTRA_TRANSITEM));
      retrieve_e(tGER_OPERCFOP);
      if (xStatus >= 0) then begin
        if (item_b('IN_FINANCEIRO', tGER_OPERCFOP) = True) then begin
          vVlFinanceiro := vVlFinanceiro + item_f('VL_TOTALLIQUIDO', tTRA_TRANSITEM);
        end;
      end else begin
        vVlFinanceiro := vVlFinanceiro + item_f('VL_TOTALLIQUIDO', tTRA_TRANSITEM);
      end;
      setocc(tTRA_TRANSITEM, curocc(tTRA_TRANSITEM) + 1);
    end;
    vVlFinanceiro := vVlFinanceiro + (item_f('VL_TOTAL', tTRA_TRANSACAO) - item_f('VL_TRANSACAO', tTRA_TRANSACAO));
  end else begin
    vVlFinanceiro := item_f('VL_TOTAL', tTRA_TRANSACAO);
  end;

  putitemXml(Result, 'VL_FINANCEIRO', vVlFinanceiro);

  return(0); exit;

end;

//------------------------------------------------------------------------
function T_GERSVCO058.buscaDadosGerOperCfopTra(pParams : String) : String;
//------------------------------------------------------------------------
const
  cDS_METHOD = 'ADICONAL=Operação: T_GERSVCO058.buscaDadosGerOperCfopTra()';
var
  vCdEmpresa, vNrTransacao, vNrItem, vVlFinanceiro : Real;
  vDtTransacao : TDate;
begin
  vVlFinanceiro := '';
  vCdEmpresa := itemXmlF('CD_EMPRESA', pParams);
  vNrTransacao := itemXmlF('NR_TRANSACAO', pParams);
  vDtTransacao := itemXml('DT_TRANSACAO', pParams);
  vNrItem := itemXmlF('NR_ITEM', pParams);

  if (vCdEmpresa = 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Empresa não informada!', cDS_METHOD);
    return(-1); exit;
  end;
  if (vNrTransacao = 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Número transação não informado!', cDS_METHOD);
    return(-1); exit;
  end;
  if (vDtTransacao = '') then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Data transação não informada!', cDS_METHOD);
    return(-1); exit;
  end;
  if (vNrItem = 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Item da transação não informado!', cDS_METHOD);
    return(-1); exit;
  end;

  clear_e(tTRA_TRANSACAO);
  putitem_e(tTRA_TRANSACAO, 'CD_EMPRESA', vCdEmpresa);
  putitem_e(tTRA_TRANSACAO, 'NR_TRANSACAO', vNrTransacao);
  putitem_e(tTRA_TRANSACAO, 'DT_TRANSACAO', vDtTransacao);
  retrieve_e(tTRA_TRANSACAO);
  if (xStatus < 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Transação ' + FloatToStr(vNrTransacao) + ' não cadastrada!', cDS_METHOD);
    return(-1); exit;
  end;

  clear_e(tTRA_TRANSITEM);
  putitem_e(tTRA_TRANSITEM, 'NR_ITEM', vNrItem);
  retrieve_e(tTRA_TRANSITEM);
  if (xStatus < 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Item ' + FloatToStr(vNrItem) + ' da transação ' + FloatToStr(vNrTransacao) + ' não cadastrada!', cDS_METHOD);
    return(-1); exit;
  end;

  clear_e(tGER_OPERCFOP);
  putitem_e(tGER_OPERCFOP, 'CD_OPERACAO', item_f('CD_OPERACAO', tTRA_TRANSACAO));
  putitem_e(tGER_OPERCFOP, 'CD_CFOP', item_f('CD_CFOP', tTRA_TRANSITEM));
  retrieve_e(tGER_OPERCFOP);
  if (xStatus >= 0) then begin
    putitemXml(Result, 'IN_FINANCEIRO', item_b('IN_FINANCEIRO', tGER_OPERCFOP));
    putitemXml(Result, 'IN_KARDEX', item_b('IN_KARDEX', tGER_OPERCFOP));
  end else begin
    putitemXml(Result, 'IN_FINANCEIRO', True);
    putitemXml(Result, 'IN_KARDEX', True);
  end;

  return(0); exit;

end;

//-----------------------------------------------------------------------
function T_GERSVCO058.buscaDadosGerOperCfopNf(pParams : String) : String;
//-----------------------------------------------------------------------
const
  cDS_METHOD = 'ADICONAL=Operação: T_GERSVCO058.buscaDadosGerOperCfopNf()';
var
  vCdEmpresa, vNrFatura, vCdProduto,vNritem : Real;
  vDtFatura : TDate;
begin
  vCdEmpresa := itemXmlF('CD_EMPRESA', pParams);
  vNrFatura := itemXmlF('NR_FATURA', pParams);
  vDtFatura := itemXml('DT_FATURA', pParams);
  vNrItem := itemXmlF('NR_ITEM', pParams);

  if (vCdEmpresa = 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Empresa não informada!', cDS_METHOD);
    return(-1); exit;
  end;
  if (vNrFatura = 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Número transação não informado!', cDS_METHOD);
    return(-1); exit;
  end;
  if (vDtFatura = '') then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Data transação não informada!', cDS_METHOD);
    return(-1); exit;
  end;
  if (vNrItem = 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Item da transação não informado!', cDS_METHOD);
    return(-1); exit;
  end;

  clear_e(tFIS_NF);
  putitem_e(tFIS_NF, 'CD_EMPRESA', vCdEmpresa);
  putitem_e(tFIS_NF, 'NR_FATURA', vNrFatura);
  putitem_e(tFIS_NF, 'DT_FATURA', vDtFatura);
  retrieve_e(tFIS_NF);
  if (xStatus < 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Nota Fiscal não encotrada!', cDS_METHOD);
    return(-1); exit;
  end;

  clear_e(tFIS_NFITEM);
  putitem_e(tFIS_NFITEM, 'NR_ITEM', vNrItem);
  retrieve_e(tFIS_NFITEM);
  if (xStatus < 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Itens da Nota Fiscal não encotrada!', cDS_METHOD);
    return(-1); exit;
  end;

  clear_e(tGER_OPERCFOP);
  putitem_e(tGER_OPERCFOP, 'CD_OPERACAO', item_f('CD_OPERACAO', tFIS_NF));
  putitem_e(tGER_OPERCFOP, 'CD_CFOP', item_f('CD_CFOP', tFIS_NFITEM));
  retrieve_e(tGER_OPERCFOP);
  if (xStatus >= 0) then begin
    putitemXml(Result, 'IN_FINANCEIRO', item_b('IN_FINANCEIRO', tGER_OPERCFOP));
    putitemXml(Result, 'IN_KARDEX', item_b('IN_KARDEX', tGER_OPERCFOP));
  end else begin
    putitemXml(Result, 'IN_FINANCEIRO', True);
    putitemXml(Result, 'IN_KARDEX', True);
  end;

  return(0); exit;

end;

end.
