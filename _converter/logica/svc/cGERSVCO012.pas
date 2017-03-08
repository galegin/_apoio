unit cGERSVCO012;

interface

(* COMPONENTES 
  ADMSVCO001 / GERSVCO012 / GERSVCO013 / PESSVCO011 / PRDSVCO007

*)        

uses
  Classes, SysUtils, Math, DB,
  cDataSetUnf;

type
  T_GERSVCO012 = class(TComponent)
  private
    tADM_IPRM,
    tADM_PARAMETRO,
    tGER_CONDPGTOC,
    tGER_CONDPGTOI,
    tGER_OPERACAO,
    tGER_OPERVALOR,
    tPRD_ITEMVDA,
    tPRD_PRDINFO,
    tPRD_PRODUTO,
    tPRD_VALOR,
    tTRA_TRANSACAO,
    tTRA_TRANSITEM : TcDatasetUnf;
    function getParam(pParams : String = '') : String;
    function setEntidade(pParams : String = '') : String;
  protected
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;    
  published
    function GetItemPreco(pParams : String = '') : String;
    function GetPrecoCusto(pParams : String = '') : String;
    function AplicJuroItem(pParams : String = '') : String;
    function GetValorProduto(pParams : String = '') : String;
    function buscaValorOperacao(pParams : String = '') : String;
  end;

implementation

uses
  cADMSVCO001,
  cActivate, cStatus, cFuncao, cXml, dModulo;

var
  gInAplicDescItemVlLiq,
  gVlPadraoTransfPrd : String;

//---------------------------------------------------------------
constructor T_GERSVCO012.Create(AOwner: TComponent);
//---------------------------------------------------------------
begin
  inherited Create(AOwner);
  setEntidade('');
end;

//--------------------------------
destructor T_GERSVCO012.Destroy;
//--------------------------------
begin
  inherited Destroy;
end;

//---------------------------------------------------------------
function T_GERSVCO012.getParam(pParams : String = '') : String;
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
  putitem(xParamEmp, 'IN_APLIC_DESC_ITEM_VL_LIQ');
  putitem(xParamEmp, 'VL_PADRAO_TRANSF_PRD');

  xParamEmp := T_ADMSVCO001.GetParamEmpresa(piCdEmpresa, xParamEmp);

  gInAplicDescItemVlLiq := itemXml('IN_APLIC_DESC_ITEM_VL_LIQ', xParamEmp);
  gVlPadraoTransfPrd := itemXml('VL_PADRAO_TRANSF_PRD', xParamEmp);

end;

//---------------------------------------------------------------
function T_GERSVCO012.setEntidade(pParams : String = '') : String;
//---------------------------------------------------------------
begin
  tADM_IPRM := TcDatasetUnf.getEntidade('ADM_IPRM');
  tADM_PARAMETRO := TcDatasetUnf.getEntidade('ADM_PARAMETRO');
  tGER_CONDPGTOC := TcDatasetUnf.getEntidade('GER_CONDPGTOC');
  tGER_CONDPGTOI := TcDatasetUnf.getEntidade('GER_CONDPGTOI');
  tGER_OPERACAO := TcDatasetUnf.getEntidade('GER_OPERACAO');
  tGER_OPERVALOR := TcDatasetUnf.getEntidade('GER_OPERVALOR');
  tPRD_ITEMVDA := TcDatasetUnf.getEntidade('PRD_ITEMVDA');
  tPRD_PRDINFO := TcDatasetUnf.getEntidade('PRD_PRDINFO');
  tPRD_PRODUTO := TcDatasetUnf.getEntidade('PRD_PRODUTO');
  tPRD_VALOR := TcDatasetUnf.getEntidade('PRD_VALOR');
  tTRA_TRANSACAO := TcDatasetUnf.getEntidade('TRA_TRANSACAO');
  tTRA_TRANSITEM := TcDatasetUnf.getEntidade('TRA_TRANSITEM');
end;

//------------------------------------------------------------
function T_GERSVCO012.GetItemPreco(pParams : String) : String;
//------------------------------------------------------------
const
  cDS_METHOD = 'ADICONAL=Operação: T_GERSVCO012.GetItemPreco()';
var
  (* string piGlobal :IN / entity PRD_ITEMVDASVC:INOUT *)
  vDataSis,vDtInicio : TDate;
  vCtxErro,vTpValor,viParams,voParams : String;
  vVlPromocao,vVlProduto,vVlDesconto,vDescPromocao,vDescPagto,vJuro,vVlUnitLiquido : Real;
  vCdErro,vCdValor,vPrzMedio,vEmpresa,vCdPromocao,vCondPgto,vVlJuro : Real;
begin
  if (itemXml('CD_CONDPGTO', pParams) = '') then begin
    voParams := SetErroApl(viParams); (* 'ERRO=-1;
    return(-1); exit;
  end;
  if (itemXml('CD_OPERACAO', pParams) = '') then begin
    voParams := SetErroApl(viParams); (* 'ERRO=-1;
    return(-1); exit;
  end;
  if (itemXml('CD_COMPONENTE', piGlobal) = 'PDVSVCO011') then begin
    setocc(tPRD_ITEMVDA, 1);
  end;

  putitem_e(tPRD_ITEMVDA, 'VL_UNITBRUTO', 0);
  putitem_e(tPRD_ITEMVDA, 'VL_UNITLIQUIDO', 0);
  putitem_e(tPRD_ITEMVDA, 'VL_UNITLIQUIDO', 0);
  putitem_e(tPRD_ITEMVDA, 'PR_DESCONTO', 0);
  putitem_e(tPRD_ITEMVDA, 'VL_UNITDESC', 0);
  putitem_e(tPRD_ITEMVDA, 'IN_DESCONTO', '');
  putitem_e(tPRD_ITEMVDA, 'CD_PROMOCAO', 0);
  putitem_e(tPRD_ITEMVDA, 'DT_PROMOCAO', 0);
  putitem_e(tPRD_ITEMVDA, 'VL_TOTALBRUTO', 0);
  putitem_e(tPRD_ITEMVDA, 'VL_TOTALLIQUIDO', 0);
  putitem_e(tPRD_ITEMVDA, 'VL_TOTALDESC', 0);

  vJuro := 0;
  vCdValor := 0;
  vTpValor := 0;
  vVlProduto= 0;
  vDescPagto= 0;
  vVlDesconto := 0;
  vDescPromocao := 0;

  vEmpresa= itemXmlF('CD_EMPRESA', piGlobal);
  vDataSis= itemXml('DT_SISTEMA', piGlobal);
  vVLUnitLiquido := itemXmlF('VL_UNITLIQUIDO', pParams);

  clear_e(tPRD_PRODUTO);
  if (item_f('CD_PRODUTO', tPRD_ITEMVDA) = 0) then begin
    putitem_e(tPRD_ITEMVDA, 'CD_PRODUTO', itemXmlF('CD_PRODUTO', pParams));
  end;
  putitem_e(tPRD_PRODUTO, 'CD_PRODUTO', item_f('CD_PRODUTO', tPRD_ITEMVDA));
  retrieve_e(tPRD_PRODUTO);
  if (xStatus < 0) then begin
    voParams := SetErroApl(viParams); (* 'ERRO=-40;
    return(-1); exit;
  end;

  clear_e(tGER_OPERVALOR);
  putitem_e(tGER_OPERVALOR, 'CD_OPERACAO', itemXmlF('CD_OPERACAO', pParams));
  putitem_e(tGER_OPERVALOR, 'IN_PRECOBASE', True);
  retrieve_e(tGER_OPERVALOR);
  if (xStatus < 0) then begin
    if (vVlUnitLiquido <= 0) then begin
      voParams := SetErroApl(viParams); (* 'ERRO=-40;
      return(-1); exit;
    end;
  end else begin
    vCdValor := item_f('CD_UNIDVALOR', tGER_OPERVALOR);
    vTpValor := item_f('TP_UNIDVALOR', tGER_OPERVALOR);
  end;

  clear_e(tGER_CONDPGTOC);
  putitem_e(tGER_CONDPGTOC, 'CD_CONDPGTO', itemXmlF('CD_CONDPGTO', pParams));
  retrieve_e(tGER_CONDPGTOC);
  if (xStatus < 0) then begin
    voParams := SetErroProc(viParams); (* xProcerrorcontext, xCdErro, xCtxErro *)
  end else begin
    vJuro := item_f('PR_JURO', tGER_CONDPGTOC);
    vDescpagto := item_f('PR_DESCONTO', tGER_CONDPGTOC);
  end;

  clear_e(tPRD_VALOR);
  putitem_e(tPRD_VALOR, 'CD_EMPRESA', vEmpresa);
  putitem_e(tPRD_VALOR, 'CD_PRODUTO', item_f('CD_PRODUTO', tPRD_PRODUTO));
  putitem_e(tPRD_VALOR, 'TP_VALOR', vTpValor);
  putitem_e(tPRD_VALOR, 'CD_VALOR', vCdValor);
  retrieve_e(tPRD_VALOR);
  if (xStatus < 0) then begin
    Result := voParams;
    return(-1); exit;
  end;
    clear_e(tADM_PARAMETRO);
    putitem_e(tADM_PARAMETRO, 'CD_PARAMETRO', 'CD_EMPRESA');
    retrieve_e(tADM_PARAMETRO);
    if (!xProcerror) then begin
      clear_e(tPRD_VALOR);
      if (item_f('VL_PARAMETRO', tADM_IPRM) = '') then begin
        putitem_e(tPRD_VALOR, 'CD_EMPRESA', item_f('VL_PARAMETRO', tADM_PARAMETRO));
      end else begin
        putitem_e(tPRD_VALOR, 'CD_EMPRESA', item_f('VL_PARAMETRO', tADM_IPRM));
      end;
      putitem_e(tPRD_VALOR, 'CD_PRODUTO', item_f('CD_PRODUTO', tPRD_PRODUTO));
      putitem_e(tPRD_VALOR, 'TP_VALOR', vTpValor);
      putitem_e(tPRD_VALOR, 'CD_VALOR', vCdValor);
      retrieve_e(tPRD_VALOR);
      if (xStatus < 0) then begin
        Result := voParams;
        return(-1); exit;
      end;
      end;
    end;
  end;
  if (vVlUnitLiquido > 0) then begin
    vVlProduto := vVlUnitLiquido;
  end else begin
    vVlProduto := item_f('VL_PRODUTO', tPRD_VALOR);
  end;
  if (vJuro > 0)   and (vVlUnitLiquido <= 0) then begin
    vVlJuro := vVlProduto * vJuro / 100;
    vVlJuro := vVlProduto + vVlJuro;
    vVlProduto := vVlJuro [Round, 2];
    vVlJuro := vVlPromocao * vJuro / 100;
    vVlJuro := vVlPromocao + vVlJuro;
    vVlPromocao := vVlJuro [Round, 2];
  end;
  if (vDescPagto  > 0)   and (vVlUnitLiquido <= 0) then begin
    if (vDescPromocao > 0) then begin
      vVlProduto := vVlPromocao;
      vDescPagto := vDescPromocao;
    end;
    vVlDesconto := vVlProduto * vDescPagto / 100;
    vVlPromocao := vVlProduto - vVlDesconto;
    vVlPromocao := vVlPromocao [Round, 2];
  end;
  if (vVlProduto = 0) then begin
    voParams := SetErroApl(viParams); (* 'ERRO=-40;
    return(-1); exit;
  end;

  putitem_e(tPRD_ITEMVDA, 'VL_UNITBRUTO', vVlProduto);
  if (vVlPromocao > 0) then begin
    putitem_e(tPRD_ITEMVDA, 'PR_DESCONTO', vDescPagto);
    putitem_e(tPRD_ITEMVDA, 'VL_UNITDESC', vVlDesconto);
    putitem_e(tPRD_ITEMVDA, 'IN_DESCONTO', 'I');
    putitem_e(tPRD_ITEMVDA, 'CD_PROMOCAO', vCdPromocao);
    putitem_e(tPRD_ITEMVDA, 'DT_PROMOCAO', vDtInicio);
  end;
  putitem_e(tPRD_ITEMVDA, 'VL_UNITLIQUIDO', item_f('VL_UNITBRUTO', tPRD_ITEMVDA) - item_f('VL_UNITDESC', tPRD_ITEMVDA));
  putitem_e(tPRD_ITEMVDA, 'VL_TOTALBRUTO', item_f('VL_UNITBRUTO', tPRD_ITEMVDA) * item_f('QT_SOLICITADA', tPRD_ITEMVDA));
  putitem_e(tPRD_ITEMVDA, 'VL_TOTALLIQUIDO', item_f('VL_UNITLIQUIDO', tPRD_ITEMVDA) * item_f('QT_SOLICITADA', tPRD_ITEMVDA));
  putitem_e(tPRD_ITEMVDA, 'VL_TOTALDESC', item_f('VL_UNITDESC', tPRD_ITEMVDA) * item_f('QT_SOLICITADA', tPRD_ITEMVDA));
  putitemXml(Result, 'VL_PRODUTO', vVlProduto);
  putitemXml(Result, 'VL_PROMOCAO', vVlPromocao);
  putitemXml(Result, 'CD_PROMOCAO', vCdPromocao);
  putitemXml(Result, 'PR_JURO', vJuro);
  putitemXml(Result, 'PR_DESCONTO', vDescPromocao);
  putitemXml(Result, 'DT_INICIO', vDtInicio);
  putitemXml(Result, 'VL_UNITLIQUIDO', item_f('VL_UNITLIQUIDO', tPRD_ITEMVDA));
  putitemXml(Result, 'VL_UNITBRUTO', item_f('VL_UNITBRUTO', tPRD_ITEMVDA));
  putitemXml(Result, 'VL_UNITDESC', item_f('VL_UNITDESC', tPRD_ITEMVDA));

  return(0); exit;
end;

//-------------------------------------------------------------
function T_GERSVCO012.GetPrecoCusto(pParams : String) : String;
//-------------------------------------------------------------
const
  cDS_METHOD = 'ADICONAL=Operação: T_GERSVCO012.GetPrecoCusto()';
var
  (* string piGlobal :IN *)
  vDataSis,vDtInicio : TDate;
  vCtxErro,vTpValor,viParams,voParams : String;
  vVlPromocao,vVlProduto,vVlDesconto,vDescPromocao,vDescPagto,vJuro : Real;
  vCdErro,vCdValor,vPrzMedio,vEmpresa,vCdPromocao,vCondPgto,vVlJuro : Real;
begin
  vJuro := 0;
  vCdValor := 0;
  vTpValor := 0;
  vVlProduto= 0;
  vDescPagto= 0;
  vVlDesconto := 0;
  vDescPromocao := 0;

  vEmpresa= itemXmlF('CD_EMPRESA', piGlobal);
  vDataSis= itemXml('DT_SISTEMA', piGlobal);

  clear_e(tPRD_PRODUTO);
  putitem_e(tPRD_PRODUTO, 'CD_PRODUTO', itemXmlF('CD_PRODUTO', pParams));
  retrieve_e(tPRD_PRODUTO);
  if (xStatus < 0) then begin
    voParams := SetErroApl(viParams); (* 'ERRO=-1;
    return(-1); exit;
  end;

  clear_e(tGER_OPERVALOR);
  putitem_e(tGER_OPERVALOR, 'CD_OPERACAO', itemXmlF('CD_OPERACAO', pParams));
  putitem_e(tGER_OPERVALOR, 'IN_PRECOBASE', True);
  retrieve_e(tGER_OPERVALOR);
  if (xStatus < 0) then begin
    voParams := SetErroApl(viParams); (* 'ERRO=-1;
    return(-1); exit;
  end else begin
    vCdValor := item_f('CD_UNIDVALOR', tGER_OPERVALOR);
    vTpValor := item_f('TP_UNIDVALOR', tGER_OPERVALOR);
  end;

  clear_e(tGER_CONDPGTOC);
  putitem_e(tGER_CONDPGTOC, 'CD_CONDPGTO', itemXmlF('CD_CONDPGTO', pParams));
  retrieve_e(tGER_CONDPGTOC);
  if (!xProcerror) then begin
    vJuro := item_f('PR_JURO', tGER_CONDPGTOC);
    vDescpagto := item_f('PR_DESCONTO', tGER_CONDPGTOC);
  end;

  clear_e(tPRD_VALOR);
  putitem_e(tPRD_VALOR, 'CD_EMPRESA', vEmpresa);
  putitem_e(tPRD_VALOR, 'CD_PRODUTO', item_f('CD_PRODUTO', tPRD_PRODUTO));
  putitem_e(tPRD_VALOR, 'TP_VALOR', vTpValor);
  putitem_e(tPRD_VALOR, 'CD_VALOR', vCdValor);
  retrieve_e(tPRD_VALOR);
  if (xStatus < 0) then begin
    Result := voParams;
    return(-1); exit;
  end;
    clear_e(tADM_PARAMETRO);
    putitem_e(tADM_PARAMETRO, 'CD_PARAMETRO', 'CD_EMPVALOR');
    retrieve_e(tADM_PARAMETRO);
    if (!xProcerror) then begin
      clear_e(tPRD_VALOR);
      if (item_f('VL_PARAMETRO', tADM_IPRM) = '') then begin
        putitem_e(tPRD_VALOR, 'CD_EMPRESA', item_f('VL_PARAMETRO', tADM_PARAMETRO));
      end else begin
        putitem_e(tPRD_VALOR, 'CD_EMPRESA', item_f('VL_PARAMETRO', tADM_IPRM));
      end;
      putitem_e(tPRD_VALOR, 'CD_PRODUTO', item_f('CD_PRODUTO', tPRD_PRODUTO));
      putitem_e(tPRD_VALOR, 'TP_VALOR', vTpValor);
      putitem_e(tPRD_VALOR, 'CD_VALOR', vCdValor);
      retrieve_e(tPRD_VALOR);
      if (xStatus < 0) then begin
        Result := voParams;
        return(-1); exit;
      end;
    end;
  end;

  vVlProduto := item_f('VL_PRODUTO', tPRD_VALOR);

  if (vJuro > 0) then begin
    vVlJuro := vVlProduto * vJuro / 100;
    vVlJuro := vVlProduto + vVlJuro;
    vVlProduto := vVlJuro [Round, 2];
    vVlJuro := vVlPromocao * vJuro / 100;
    vVlJuro := vVlPromocao + vVlJuro;
    vVlPromocao := vVlJuro [Round, 2];
  end;
  if (vVlProduto = '') then begin
    voParams := SetErroApl(viParams); (* 'ERRO=-1;
    return(-1); exit;
  end;

  Result := 'VL_PRODUTO=' + FloatToStr(vVlProduto) + ';
  return(0); exit;
end;

//-------------------------------------------------------------
function T_GERSVCO012.AplicJuroItem(pParams : String) : String;
//-------------------------------------------------------------
const
  cDS_METHOD = 'ADICONAL=Operação: T_GERSVCO012.AplicJuroItem()';
var
  (* string piGlobal :IN *)
  vPrjuro,vVlJuro,vLiquido,vLimite,vPromocao : Real;
  viParams,voParams,vSN : String;
begin
  vPrJuro := itemXmlF('PR_JURO', pParams);
  vSN := itemXml('LIMITE_CREDITO', piGlobal);

  clear_e(tTRA_TRANSACAO);
  putitem_e(tTRA_TRANSACAO, 'CD_EMPRESA', itemXmlF('CD_EMPRESA', pParams));
  putitem_e(tTRA_TRANSACAO, 'NR_TRANSACAO', itemXmlF('NR_TRANSACAO', pParams));
  putitem_e(tTRA_TRANSACAO, 'DT_TRANSACAO', itemXml('DT_TRANSACAO', pParams));
  retrieve_e(tTRA_TRANSACAO);
  if (!xProcerror) then begin
    setocc(tTRA_TRANSITEM, 1);
    if (dbocc(t'TRA_TRANSITEM')) then begin
      repeat

        vLiquido := item_f('VL_TOTALLIQUIDO', tTRA_TRANSITEM);
        viParams='CD_PRODUTO=' + item_f('CD_PRODUTO', tTRA_TRANSITEM) + ';
        voParams := activateCmp('GERSVCO012', 'GetPrecoCusto', viParams);
        if (xStatus < 0) then begin
          Result := voParams;
          return(-1); exit;
        end;

        putitem_e(tTRA_TRANSITEM, 'VL_UNITBRUTO', itemXmlF('VL_PRODUTO', voParams));
        putitem_e(tTRA_TRANSITEM, 'PR_DESCONTO', itemXmlF('PR_DESCONTO', voParams));
        if (itemXml('VL_PROMOCAO', voParams) <> 0) then begin
          putitem_e(tTRA_TRANSITEM, 'VL_UNITLIQUIDO', itemXmlF('VL_PROMOCAO', voParams));
        end else begin
          putitem_e(tTRA_TRANSITEM, 'VL_UNITLIQUIDO', item_f('VL_UNITBRUTO', tTRA_TRANSITEM));
        end;

        putitem_e(tTRA_TRANSITEM, 'VL_TOTALBRUTO', item_f('VL_UNITBRUTO', tTRA_TRANSITEM)   * item_f('QT_SOLICITADA', tTRA_TRANSITEM));
        putitem_e(tTRA_TRANSITEM, 'VL_TOTALLIQUIDO', item_f('VL_UNITLIQUIDO', tTRA_TRANSITEM) * item_f('QT_SOLICITADA', tTRA_TRANSITEM));
        putitem_e(tTRA_TRANSITEM, 'VL_TOTALLIQUIDO', item_f('VL_TOTALLIQUIDO', tTRA_TRANSITEM) [Round, 2]);
        putitem_e(tTRA_TRANSACAO, 'VL_TRANSACAO', item_f('VL_TRANSACAO', tTRA_TRANSACAO) + item_f('VL_TOTALLIQUIDO', tTRA_TRANSITEM));
        vliquido := item_f('VL_TRANSACAO', tTRA_TRANSACAO) - vLiquido;
        putitem_e(tTRA_TRANSACAO, 'VL_TRANSACAO', vLiquido [Round, 2]);
        putitem_e(tTRA_TRANSITEM, 'CD_OPERADOR', itemXmlF('CD_USUARIO', piGlobal));
        putitem_e(tTRA_TRANSITEM, 'DT_CADASTRO', Now);
        setocc(tTRA_TRANSITEM, curocc(tTRA_TRANSITEM) + 1);
      until (xStatus <= 0);
      xStatus := 0;

      if (vSN = 'S') then begin
        viParams := 'CD_PESSOA=' + item_f('CD_PESSOA', tTRA_TRANSACAO)' + ';
        voParams := activateCmp('PESSVCO011', 'VerEstatistica', viParams);
        if (xStatus < 0) then begin
          Result := voParams;
          return(-1); exit;
        end;

        vLimite := itemXmlF('VL_LIMITE', voParams);

        clear_e(tGER_CONDPGTOC);
        putitem_e(tGER_CONDPGTOC, 'CD_CONDPGTO', itemXmlF('CD_CONDPGTO', pParams));
        retrieve_e(tGER_CONDPGTOC);
        if (!xProcerror) then begin
          if (item_f('VL_TRANSACAO', tTRA_TRANSACAO) > vLimite) then begin
            if (item_f('NR_PARCELAS', tGER_CONDPGTOC) > 1)  or %\ then begin
            (item_f('QT_DIA', tGER_CONDPGTOI) > 0);
            voParams := SetErroApl(viParams); (* 'ERRO=-1;
            return(0); exit;
          end;
        end;
      end;
    end;

    voParams := tTRA_TRANSACAO.Salvar();
    if (xStatus < 0) then begin
      Result := voParams;
      return(-1); exit;
    end;
  end;
end;
end;

//---------------------------------------------------------------
function T_GERSVCO012.GetValorProduto(pParams : String) : String;
//---------------------------------------------------------------
const
  cDS_METHOD = 'ADICONAL=Operação: T_GERSVCO012.GetValorProduto()';
begin
  clear_e(tPRD_VALOR);
  putitem_e(tPRD_VALOR, 'CD_EMPRESA', itemXmlF('CD_EMPRESA', pParams));
  putitem_e(tPRD_VALOR, 'CD_PRODUTO', itemXmlF('CD_PRODUTO', pParams));
  putitem_e(tPRD_VALOR, 'TP_VALOR', itemXmlF('TP_VALOR', pParams));
  putitem_e(tPRD_VALOR, 'CD_VALOR', itemXmlF('CD_VALOR', pParams));
  retrieve_x(tPRD_VALOR);
  if (xStatus = -7) then begin
    retrieve_o(tPRD_VALOR);
  end;

  putitemXml(Result, 'VL_VALOR', item_f('VL_PRODUTO', tPRD_VALOR));

  return(0); exit;
end;

//------------------------------------------------------------------
function T_GERSVCO012.buscaValorOperacao(pParams : String) : String;
//------------------------------------------------------------------
const
  cDS_METHOD = 'ADICONAL=Operação: T_GERSVCO012.buscaValorOperacao()';
var
  (* string piGlobal :IN *)
  vCdEmpresa, vCdProduto, vCdCondPgto, vCdOperacao, vCdValor, vCdPromocao : Real;
  vVlValor, vVlOriginal, vVlBruto, vVlLiquido, vVlDesconto, vVlProduto : Real;
  vPrJuro, vPrDesconto, vNrPrazoMedio, vVlBase : Real;
  vTpValor, viParams, viListas, voParams : String;
  vInPromocao, vInBloqDescPromocao, vInValorPadraoTransf : Boolean;
  vData : TDate;
begin
  vInBloqDescPromocao := itemXmlB('IN_BLOQ_DESC_ITEM_PROM', piGlobal);
  vData := itemXml('DT_VALOR', pParams);
  if (vData = '') then begin
    vData := itemXml('DT_SISTEMA', piGlobal);
  end;

  vCdEmpresa := itemXmlF('CD_EMPRESA', pParams);
  if (vCdEmpresa = 0) then begin
    vCdEmpresa := itemXmlF('CD_EMPRESA', piGlobal);
  end;

  getParams(pParams); (* vCdEmpresa *)
  if (xStatus < 0) then begin
    Result := voParams;
    return(-1); exit;
  end;

  vCdProduto := itemXmlF('CD_PRODUTO', pParams);
  vCdCondPgto := itemXmlF('CD_CONDPGTO', pParams);
  vCdOperacao := itemXmlF('CD_OPERACAO', pParams);
  vInValorPadraoTransf := itemXmlB('IN_VALOR_PADRAO_TRANSF', pParams);

  if (vCdProduto = 0) then begin
    voParams := SetErroApl(viParams); (* 'ERRO=-1;
    return(-1); exit;
  end;
  if (vCdOperacao = 0) then begin
    voParams := SetErroApl(viParams); (* 'ERRO=-1;
    return(-1); exit;
  end;

  clear_e(tGER_OPERVALOR);
  putitem_e(tGER_OPERVALOR, 'CD_OPERACAO', vCdOperacao);
  putitem_e(tGER_OPERVALOR, 'IN_PRECOBASE', True);
  retrieve_e(tGER_OPERVALOR);
  if (xStatus >= 0) then begin
    vCdValor := item_f('CD_UNIDVALOR', tGER_OPERVALOR);
    vTpValor := item_f('TP_UNIDVALOR', tGER_OPERVALOR);
  end else begin
    voParams := SetErroApl(viParams); (* 'ERRO=-1;
    return(-1); exit;
  end;

  vNrPrazoMedio := '';

  if (vCdCondPgto > 0) then begin
    clear_e(tGER_CONDPGTOC);
    putitem_e(tGER_CONDPGTOC, 'CD_CONDPGTO', vCdCondPgto);
    retrieve_e(tGER_CONDPGTOC);
    if (xStatus >= 0) then begin
      vPrJuro := item_f('PR_JURO', tGER_CONDPGTOC);
      vPrDesconto := item_f('PR_DESCONTO', tGER_CONDPGTOC);
    end else begin
      vPrJuro := 0;
      vPrDesconto := 0;
    end;
    viParams := '';
    putitemXml(viParams, 'CD_CONDPGTO', vCdCondPgto);
    voParams := activateCmp('GERSVCO013', 'calcPrzMedio', viParams);
    if (xStatus < 0) then begin
      Result := voParams;
      return(-1); exit;
    end;
    vNrPrazoMedio := itemXmlF('NR_PRAZOMEDIO', voParams);
  end else begin
    vPrJuro := 0;
    vPrDesconto := 0;
  end;
  if (item_f('TP_MODALIDADE', tGER_OPERACAO) = 2) then begin
    vPrJuro := 0;
    vPrDesconto := 0;
  end;

  vInPromocao := True;

  viParams := '';
  putitemXml(viParams, 'CD_EMPRESA', vCdEmpresa);
  putitemXml(viParams, 'CD_PRODUTO', vCdProduto);
  putitemXml(viParams, 'TP_VALOR', vTpValor);
  putitemXml(viParams, 'CD_VALOR', vCdValor);
  putitemXml(viParams, 'IN_PROMOCAO', vInPromocao);
  if (vNrPrazoMedio <> '') then begin
    putitemXml(viParams, 'NR_PRAZOMEDIO', vNrPrazoMedio);
  end;
  putitemXml(viParams, 'DT_VALOR', vData);
  viListas := '';
  voParams := activateCmp('PRDSVCO007', 'buscaValorData', viParams);
  if (xStatus < 0) then begin
    Result := voParams;
    return(-1); exit;
  end;

  vCdPromocao := itemXmlF('CD_PROMOCAO', voParams);
  vVlProduto := itemXmlF('VL_VALOR', voParams);
  vVlOriginal := itemXmlF('VL_VALOR', voParams);

  if (gInAplicDescItemVlLiq = True) then begin
    vVlBase := itemXmlF('VL_VALOR', voParams);
  end else begin
    vVlBase := 0;
  end;
  if (vCdPromocao > 0) then begin
    viParams := '';
    putitemXml(viParams, 'CD_EMPRESA', vCdEmpresa);
    putitemXml(viParams, 'CD_PRODUTO', vCdProduto);
    putitemXml(viParams, 'TP_VALOR', vTpValor);
    putitemXml(viParams, 'CD_VALOR', vCdValor);
    putitemXml(viParams, 'IN_PROMOCAO', False);
    putitemXml(viParams, 'DT_VALOR', vData);
    viListas := '';
    voParams := activateCmp('PRDSVCO007', 'buscaValorData', viParams);
    if (xStatus < 0) then begin
      Result := voParams;
      return(-1); exit;
    end;
    vVlOriginal := itemXmlF('VL_VALOR', voParams);
  end;
  if (vPrJuro > 0) then begin
    vVlValor := vVlProduto + (vVlProduto * vPrJuro / 100);
    vVlBruto := roundto(vVlValor, 6);
  end else begin
    vVlBruto := vVlProduto;
  end;
  if (vCdPromocao > 0)  and (vInBloqDescPromocao = True) then begin
    vVlLiquido := vVlBruto;
    vVlDesconto := 0;
  end else begin
    if (vPrDesconto > 0) then begin
      vVlValor := vVlBruto - (vVlBruto * vPrDesconto / 100);
      vVlLiquido := roundto(vVlValor, 6);
      vVlDesconto := vVlBruto - vVlLiquido;
      if (gInAplicDescItemVlLiq = True) then begin
        vVlDesconto := 0;
        vVlBruto := vVlLiquido;
      end;
    end else begin
      vVlLiquido := vVlBruto;
    end;
  end;
  if (vVlLiquido <= 0)  and (vInValorPadraoTransf = True) then begin
    if (gVlPadraoTransfPrd > 0) then begin
      clear_e(tPRD_PRDINFO);
      putitem_e(tPRD_PRDINFO, 'CD_EMPRESA', vCdEmpresa);
      putitem_e(tPRD_PRDINFO, 'CD_PRODUTO', vCdProduto);
      retrieve_e(tPRD_PRDINFO);
      if (xStatus >= 0) then begin
        if (item_b('IN_PRODACABADO', tPRD_PRDINFO) = True)  and (item_b('IN_PRODPROPRIA', tPRD_PRDINFO) = True) then begin
          vVlLiquido := gVlPadraoTransfPrd;
          vVlBruto := gVlPadraoTransfPrd;
        end;
      end;
    end;
  end;

  Result := '';
  putitemXml(Result, 'VL_ORIGINAL', vVlOriginal);
  putitemXml(Result, 'VL_BRUTO', vVlBruto);
  putitemXml(Result, 'VL_LIQUIDO', vVlLiquido);
  putitemXml(Result, 'VL_DESCONTO', vVlDesconto);
  putitemXml(Result, 'CD_PROMOCAO', vCdPromocao);
  putitemXml(Result, 'VL_BASE', vVlBase);

  return(0); exit;
end;

end.
