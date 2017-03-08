unit cPRDSVCO008;

interface

(* COMPONENTES 
  ADMSVCO001 / 
*)        

uses
  Classes, SysUtils, Math, DB,
  cServiceUnf, cDataSetUnf;

type
  T_PRDSVCO008 = class(TcServiceUnf)
  private
    tF_PRD_GRUPOCO,
    tPRD_COMPOSC,
    tPRD_COMPOSI,
    tPRD_EMBALAGEM,
    tPRD_FIBRA,
    tPRD_GRDFREQ,
    tPRD_GRDFREQCO,
    tPRD_GRDFREQG,
    tPRD_GRUPO,
    tPRD_GRUPOCOMP,
    tPRD_GRUPOINFO,
    tPRD_PRDCOMP,
    tPRD_PRDGRADE,
    tPRD_PRDINFO,
    tPRD_PRDINFOAD,
    tPRD_PRODUTOFO : TcDatasetUnf;
    function getParam(pParams : String = '') : String;
    function setEntidade(pParams : String = '') : String;
  protected
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;    
  published
    function validaQtdFracionada(pParams : String = '') : String;
    function buscaDadosFilial(pParams : String = '') : String;
    function buscaEstoqueMinMax(pParams : String = '') : String;
    function validaEmbalagem(pParams : String = '') : String;
    function buscaDadosGrupoInfo(pParams : String = '') : String;
    function validaProdutoFornecedor(pParams : String = '') : String;
    function buscaDadosComposicaoPrd(pParams : String = '') : String;
    function buscaDadosComposicaoGrupoPrd(pParams : String = '') : String;
    function buscaGradeFrequencia(pParams : String = '') : String;
  end;

implementation

uses
  cADMSVCO001,
  cActivate, cStatus, cFuncao, cXml, dModulo;

var
  gCdEmpresaValorEmp,
  gCdEmpresaValorSis,
  gPrPercentual,
  gPrPercentual1,
  gPrPercentual4,
  gTpValidacaoEmbalagem : String;

//---------------------------------------------------------------
constructor T_PRDSVCO008.Create(AOwner: TComponent);
//---------------------------------------------------------------
begin
  inherited Create(AOwner);
  setEntidade('');
end;

//--------------------------------
destructor T_PRDSVCO008.Destroy;
//--------------------------------
begin
  inherited Destroy;
end;

//---------------------------------------------------------------
function T_PRDSVCO008.getParam(pParams : String = '') : String;
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
  putitem(xParam, 'CD_EMP_PADRAO_PRD');
  putitem(xParam, 'CD_EMPVALOR');
  putitem(xParam, 'TP_VALIDACAO_EMBALAGEM');

  xParam := T_ADMSVCO001.GetParametro(xParam);

  gCdEmpresaValorSis := itemXml('CD_EMPVALOR', xParam);
  vCdEmpresaParam := itemXml('CD_EMPRESA', xParam);
  vCdProduto := itemXml('CD_PRODUTO', xParam);
  vlValor := itemXml('QT_QUANTIDADE', xParam);

  xParamEmp := '';
  putitem(xParamEmp, 'CD_EMP_PADRAO_PRD');
  putitem(xParamEmp, 'TP_VALIDACAO_EMBALAGEM');

  xParamEmp := T_ADMSVCO001.GetParamEmpresa(piCdEmpresa, xParamEmp);

  gCdEmpresaValorEmp := itemXml('CD_EMP_PADRAO_PRD', xParamEmp);
  gCdEmpresaValorSis := itemXml('CD_EMPVALOR', xParamEmp);
  gTpValidacaoEmbalagem := itemXml('TP_VALIDACAO_EMBALAGEM', xParamEmp);
  vCdEmpresaParam := itemXml('CD_EMPRESA', xParamEmp);
  vCdProduto := itemXml('CD_PRODUTO', xParamEmp);
  vlValor := itemXml('QT_QUANTIDADE', xParamEmp);

end;

//---------------------------------------------------------------
function T_PRDSVCO008.setEntidade(pParams : String = '') : String;
//---------------------------------------------------------------
begin
  tF_PRD_GRUPOCO := GetEntidade('F_PRD_GRUPOCO');
  tPRD_COMPOSC := GetEntidade('PRD_COMPOSC');
  tPRD_COMPOSI := GetEntidade('PRD_COMPOSI');
  tPRD_EMBALAGEM := GetEntidade('PRD_EMBALAGEM');
  tPRD_FIBRA := GetEntidade('PRD_FIBRA');
  tPRD_GRDFREQ := GetEntidade('PRD_GRDFREQ');
  tPRD_GRDFREQCO := GetEntidade('PRD_GRDFREQCO');
  tPRD_GRDFREQG := GetEntidade('PRD_GRDFREQG');
  tPRD_GRUPO := GetEntidade('PRD_GRUPO');
  tPRD_GRUPOCOMP := GetEntidade('PRD_GRUPOCOMP');
  tPRD_GRUPOINFO := GetEntidade('PRD_GRUPOINFO');
  tPRD_PRDCOMP := GetEntidade('PRD_PRDCOMP');
  tPRD_PRDGRADE := GetEntidade('PRD_PRDGRADE');
  tPRD_PRDINFO := GetEntidade('PRD_PRDINFO');
  tPRD_PRDINFOAD := GetEntidade('PRD_PRDINFOAD');
  tPRD_PRODUTOFO := GetEntidade('PRD_PRODUTOFO');
end;

//-------------------------------------------------------------------
function T_PRDSVCO008.validaQtdFracionada(pParams : String) : String;
//-------------------------------------------------------------------
const
  cDS_METHOD = 'ADICONAL=Operação: T_PRDSVCO008.validaQtdFracionada()';
var
  vDsLstEmpresa, vDsLstEmp : String;
  vCdProduto, vCdEmpresa, vCdEmpresaParam, vlValor, vlResto : Real;
  vInAchou, voParams : Boolean;
begin
  vCdProduto := itemXmlF('CD_PRODUTO', pParams);
  vCdEmpresaParam := itemXmlF('CD_EMPRESA', pParams);
  if (vCdEmpresaParam = 0) then begin
    vCdEmpresaParam := itemXmlF('CD_EMPRESA', PARAM_GLB);
  end;
  vlValor := itemXmlF('QT_QUANTIDADE', pParams);

  if (vCdProduto = 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Produto não informado!', cDS_METHOD);
    return(-1); exit;
  end;

  getParams(pParams); (* vCdEmpresaParam, 'PRDSVCO008.validaQtdFracionada' *)
  if (xStatus < 0) then begin
    return(-1); exit;
  end;

  vDsLstEmpresa := '';
  putitem(vDsLstEmpresa,  vCdEmpresaParam);
  if (gCdEmpresaValorEmp > 0)  and (gCdEmpresaValorEmp <> vCdEmpresaParam) then begin
    putitem(vDsLstEmpresa,  gCdEmpresaValorEmp);
  end;
  if (gCdEmpresaValorSis > 0)  and (gCdEmpresaValorSis <> vCdEmpresaParam) then begin
    putitem(vDsLstEmpresa,  gCdEmpresaValorSis);
  end;

  vInAchou := False;
  vDsLstEmp := vDsLstEmpresa;
  repeat
    getitem(vCdEmpresa, vDsLstEmpresa, 1);
    clear_e(tPRD_PRDINFO);
    putitem_e(tPRD_PRDINFO, 'CD_EMPRESA', vCdEmpresa);
    putitem_e(tPRD_PRDINFO, 'CD_PRODUTO', vCdProduto);
    retrieve_e(tPRD_PRDINFO);
    if (xStatus >= 0) then begin
      vInAchou := True;
    end;
    delitem(vDsLstEmpresa, 1);
  until (vDsLstEmpresa := '')  or (vInAchou := True);

  if (vInAchou = False) then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Produto ' + FloatToStr(vCdProduto) + ' sem dados p/ a(s) empresa(s) ' + vDsLstEmp + ' cadastrados!', cDS_METHOD);
    return(-1); exit;
  end;

  vlResto := gfrac(vlValor);
  if (vlResto > 0 ) and (item_b('IN_FRACIONADO', tPRD_PRDINFO) <> True) then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Produto ' + FloatToStr(vCdProduto) + ' não aceita quantidade gfracionada!', cDS_METHOD);
    return(-1); exit;
  end;

  return(0); exit;
end;

//----------------------------------------------------------------
function T_PRDSVCO008.buscaDadosFilial(pParams : String) : String;
//----------------------------------------------------------------
const
  cDS_METHOD = 'ADICONAL=Operação: T_PRDSVCO008.buscaDadosFilial()';
var
  vDsLstEmpresa : String;
  vCdEmpresa, vCdEmpresaParam, vCdProduto : Real;
  vInAchou : Boolean;
begin
  vCdProduto := itemXmlF('CD_PRODUTO', pParams);
  vCdEmpresaParam := itemXmlF('CD_EMPRESA', pParams);
  if (vCdEmpresaParam = 0) then begin
    vCdEmpresaParam := itemXmlF('CD_EMPRESA', PARAM_GLB);
  end;
  if (vCdProduto = 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Produto não informado!', cDS_METHOD);
    return(-1); exit;
  end;

  getParams(pParams); (* vCdEmpresaParam, 'PRDSVCO008.buscaDadosFilial' *)
  if (xStatus < 0) then begin
    return(-1); exit;
  end;

  vDsLstEmpresa := '';
  putitem(vDsLstEmpresa,  vCdEmpresaParam);
  if (gCdEmpresaValorEmp > 0)  and (gCdEmpresaValorEmp <> vCdEmpresaParam) then begin
    putitem(vDsLstEmpresa,  gCdEmpresaValorEmp);
  end;
  if (gCdEmpresaValorSis > 0)  and (gCdEmpresaValorSis <> vCdEmpresaParam) then begin
    putitem(vDsLstEmpresa,  gCdEmpresaValorSis);
  end;

  vInAchou := False;
  repeat
    getitem(vCdEmpresa, vDsLstEmpresa, 1);
    clear_e(tPRD_PRDINFO);
    putitem_e(tPRD_PRDINFO, 'CD_EMPRESA', vCdEmpresa);
    putitem_e(tPRD_PRDINFO, 'CD_PRODUTO', vCdProduto);
    retrieve_e(tPRD_PRDINFO);
    if (xStatus >= 0) then begin
      vInAchou := True;
    end;
    delitem(vDsLstEmpresa, 1);
  until (vDsLstEmpresa := '')  or (vInAchou := True);

  if (vInAchou = False) then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Dados p/ filial não cadastrados p/ o produto ' + FloatToStr(vCdProduto) + '!', cDS_METHOD);
    return(-1); exit;
  end;

  clear_e(tPRD_PRDINFOAD);
  if not (empty(tPRD_PRDINFO)) then begin
    putitem_e(tPRD_PRDINFOAD, 'CD_EMPRESA', item_f('CD_EMPRESA', tPRD_PRDINFO));
    putitem_e(tPRD_PRDINFOAD, 'CD_PRODUTO', item_f('CD_PRODUTO', tPRD_PRDINFO));
    retrieve_e(tPRD_PRDINFOAD);
  end;

  Result := '';
  putlistitensocc_e(Result, tPRD_PRDINFO);
  putitemXml(Result, 'QT_COMPMULTIPLA', item_f('QT_COMPMULTIPLA', tPRD_PRDINFOAD));
  putitemXml(Result, 'QT_COMPECONOMICA', item_f('QT_COMPECONOMICA', tPRD_PRDINFOAD));
  putitemXml(Result, 'TP_FREQVendA', item_f('TP_FREQVENDA', tPRD_PRDINFOAD));
  putitemXml(Result, 'NR_VARIACAO', item_f('NR_VARIACAO', tPRD_PRDINFOAD));
  return(0); exit;
end;

//------------------------------------------------------------------
function T_PRDSVCO008.buscaEstoqueMinMax(pParams : String) : String;
//------------------------------------------------------------------
const
  cDS_METHOD = 'ADICONAL=Operação: T_PRDSVCO008.buscaEstoqueMinMax()';
var
  vDsLstEmpresa : String;
  vCdEmpresa, vCdProduto, vCdGrupoempresa : Real;
  vInAchou : Boolean;
begin
  vCdProduto := itemXmlF('CD_PRODUTO', pParams);
  vCdEmpresa := itemXmlF('CD_EMPRESA', pParams);

  if (vCdProduto = 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Produto não informado!', cDS_METHOD);
    return(-1); exit;
  end;
  if (vCdEmpresa = 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Empresa não informada!', cDS_METHOD);
    return(-1); exit;
  end;

    clear_e(tPRD_PRDINFO);
    putitem_e(tPRD_PRDINFO, 'CD_EMPRESA', vCdEmpresa);
    putitem_e(tPRD_PRDINFO, 'CD_PRODUTO', vCdProduto);
    retrieve_e(tPRD_PRDINFO);
    if (xStatus >= 0) then begin
      vInAchou := True;
    end;

  Result := '';
  putlistitensocc_e(Result, tPRD_PRDINFO);

  return(0); exit;
end;

//---------------------------------------------------------------
function T_PRDSVCO008.validaEmbalagem(pParams : String) : String;
//---------------------------------------------------------------
const
  cDS_METHOD = 'ADICONAL=Operação: T_PRDSVCO008.validaEmbalagem()';
var
  vCdProduto, vQtSolicitada, vQtMin, vQtMax, vQtResto, vQtEmbalagem : Real;
  vDsQtPermitida : String;
begin
  vCdProduto := itemXmlF('CD_PRODUTO', pParams);
  vQtSolicitada := itemXmlF('QT_QUANTIDADE', pParams);

  if (vCdProduto = 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Produto não informado!', cDS_METHOD);
    return(-1); exit;
  end;

  clear_e(tPRD_EMBALAGEM);
  putitem_e(tPRD_EMBALAGEM, 'CD_PRODUTO', vCdProduto);
  retrieve_e(tPRD_EMBALAGEM);
  if (xStatus >= 0) then begin
    if (gTpValidacaoEmbalagem = 1) then begin
      setocc(tPRD_EMBALAGEM, 1);
      while (xStatus >= 0) do begin
        if (item_f('QT_EMBALAGEM', tPRD_EMBALAGEM) > 1) then begin
          if (vDsQtPermitida =  '') then begin
            vDsQtPermitida := roundto(item_f('QT_EMBALAGEM', tPRD_EMBALAGEM), 0);
          end else begin
            vDsQtPermitida := '' + vDsQtPermitida, + ' roundto(' + item_f('QT_EMBALAGEM', tPRD_EMBALAGEM), + ' 0)';
          end;
        end;
        setocc(tPRD_EMBALAGEM, curocc(tPRD_EMBALAGEM) + 1);
      end;

      clear_e(tPRD_EMBALAGEM);
      putitem_e(tPRD_EMBALAGEM, 'CD_PRODUTO', vCdProduto);
      putitem_e(tPRD_EMBALAGEM, 'QT_EMBALAGEM', vQtSolicitada);
      retrieve_e(tPRD_EMBALAGEM);
      if (xStatus < 0) then begin
        Result := SetStatus(STS_ERROR, 'GEN0001', 'Quantidade não cadastrada para o produto ' + FloatToStr(vCdProduto) + '! Quantidade(s)permitida(s) ' + vDsQtPermitida', + ' cDS_METHOD);
        return(-1); exit;
      end;

    end else begin
      vQtEmbalagem := 0;
      sort/e(t PRD_EMBALAGEM, 'QT_EMBALAGEM';);
      setocc(tPRD_EMBALAGEM, 1);
      while (xStatus >= 0)  and (vQtEmbalagem := 0) do begin
        if (item_f('QT_EMBALAGEM', tPRD_EMBALAGEM) > 1) then begin
          vQtEmbalagem := item_f('QT_EMBALAGEM', tPRD_EMBALAGEM);
        end;
        setocc(tPRD_EMBALAGEM, curocc(tPRD_EMBALAGEM) + 1);
      end;
      if (vQtEmbalagem > 1) then begin
        vQtResto := vQtSolicitada % vQtEmbalagem;

        if (vQtResto <> 0) then begin
          vQtMin := vQtSolicitada - vQtResto;
          vQtMax := vQtMin + vQtEmbalagem;

          Result := SetStatus(STS_ERROR, 'GEN0001', 'A quantidade ' + vQtSolicitada + ' não é multipla da quantidade da embalagem ' + vQtEmbalagem.As + ' quantidades mais próximas são ' + vQtMin + ' e ' + vQtMax + '!', cDS_METHOD);
          return(-1); exit;
        end;

        Result := '';
        putitemXml(Result, 'QT_EMBALAGEM', vQtEmbalagem);
      end;
    end;
  end;

  return(0); exit;
end;

//-------------------------------------------------------------------
function T_PRDSVCO008.buscaDadosGrupoInfo(pParams : String) : String;
//-------------------------------------------------------------------
const
  cDS_METHOD = 'ADICONAL=Operação: T_PRDSVCO008.buscaDadosGrupoInfo()';
var
  vDsLstEmpresa : String;
  vCdEmpresa, vCdEmpresaParam, vCdSeqGrupo : Real;
  vInAchou : Boolean;
begin
  vCdSeqGrupo := itemXmlF('CD_SEQGRUPO', pParams);
  vCdEmpresaParam := itemXmlF('CD_EMPRESA', pParams);
  if (vCdEmpresaParam = 0) then begin
    vCdEmpresaParam := itemXmlF('CD_EMPRESA', PARAM_GLB);
  end;
  if (vCdSeqGrupo = 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Grupo não informado!', cDS_METHOD);
    return(-1); exit;
  end;

  getParams(pParams); (* vCdEmpresaParam, 'PRDSVCO008.buscaDadosFilial' *)
  if (xStatus < 0) then begin
    return(-1); exit;
  end;

  vDsLstEmpresa := '';
  putitem(vDsLstEmpresa,  vCdEmpresaParam);
  if (gCdEmpresaValorEmp > 0)  and (gCdEmpresaValorEmp <> vCdEmpresaParam) then begin
    putitem(vDsLstEmpresa,  gCdEmpresaValorEmp);
  end;
  if (gCdEmpresaValorSis > 0)  and (gCdEmpresaValorSis <> vCdEmpresaParam) then begin
    putitem(vDsLstEmpresa,  gCdEmpresaValorSis);
  end;

  vInAchou := False;
  repeat
    getitem(vCdEmpresa, vDsLstEmpresa, 1);
    clear_e(tPRD_GRUPOINFO);
    putitem_e(tPRD_GRUPOINFO, 'CD_EMPRESA', vCdEmpresa);
    putitem_e(tPRD_GRUPOINFO, 'CD_SEQGRUPO', vCdSeqGrupo);
    retrieve_e(tPRD_GRUPOINFO);
    if (xStatus >= 0) then begin
      vInAchou := True;
    end;
    delitem(vDsLstEmpresa, 1);
  until (vDsLstEmpresa := '')  or (vInAchou := True);

  if (vInAchou = False) then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Dados de informação não cadastrados para o grupo ' + FloatToStr(vCdSeqGrupo) + '!', cDS_METHOD);
    return(-1); exit;
  end;

  Result := '';
  putlistitensocc_e(Result, tPRD_GRUPOINFO);

  return(0); exit;
end;

//-----------------------------------------------------------------------
function T_PRDSVCO008.validaProdutoFornecedor(pParams : String) : String;
//-----------------------------------------------------------------------
const
  cDS_METHOD = 'ADICONAL=Operação: T_PRDSVCO008.validaProdutoFornecedor()';
var
  vCdFornecedor, vCdProduto, vCdProdutoGenerico : Real;
begin
  vCdFornecedor := itemXmlF('CD_FORNECEDOR', pParams);
  vCdProduto := itemXmlF('CD_PRODUTO', pParams);
  vCdProdutoGenerico := itemXmlF('CD_PRODUTO_GENERICO_DEV', PARAM_GLB);

  if (vCdProdutoGenerico = vCdProduto) then begin
    return(0); exit;
  end;
  if (vCdFornecedor = 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Fornecedor não informado!', cDS_METHOD);
    return(-1); exit;
  end;
  if (vCdProduto = 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Produto não informado!', cDS_METHOD);
    return(-1); exit;
  end;

  clear_e(tPRD_PRODUTOFO);
  putitem_e(tPRD_PRODUTOFO, 'CD_FORNECEDOR', vCdFornecedor);
  retrieve_e(tPRD_PRODUTOFO);
  if (xStatus >= 0) then begin
    clear_e(tPRD_PRODUTOFO);
    putitem_e(tPRD_PRODUTOFO, 'CD_FORNECEDOR', vCdFornecedor);
    putitem_e(tPRD_PRODUTOFO, 'CD_PRODUTO', vCdProduto);
    retrieve_e(tPRD_PRODUTOFO);
    if (xStatus < 0) then begin
      Result := SetStatus(STS_ERROR, 'GEN0001', 'Produto ' + FloatToStr(vCdProduto) + ' não cadastrado para o fornecedor ' + FloatToStr(vCdFornecedor) + '!', cDS_METHOD);
      return(-1); exit;
    end;
  end;

  return(0); exit;
end;

//-----------------------------------------------------------------------
function T_PRDSVCO008.buscaDadosComposicaoPrd(pParams : String) : String;
//-----------------------------------------------------------------------
const
  cDS_METHOD = 'ADICONAL=Operação: T_PRDSVCO008.buscaDadosComposicaoPrd()';
var
  vCdProduto, vNrComposicao, vNrItemComposicao : Real;
  vTpComposicao, vDsCampo, vTpPercentual : String;
begin
  vDsCampo := '';
  vTpPercentual := '';
  vCdProduto := itemXmlF('CD_PRODUTO', pParams);
  vNrComposicao := itemXmlF('NR_COMPOSICAO', pParams);
  vNrItemComposicao =itemXml('NR_ITEMCOMPOSICAO', pParams);
  vTpComposicao =itemXml('TP_COMPOSICAO', pParams);
  vTpPercentual := itemXmlF('TP_PERCENTUAL', pParams);

  if (vCdProduto = 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Produto não informado!', cDS_METHOD);
    return(-1); exit;
  end;
  if (vNrComposicao = 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Código da composição não informado!', cDS_METHOD);
    return(-1); exit;
  end;
  if (vTpComposicao = 'I')  and (vNrItemComposicao = 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Código do item da composição não informado!', cDS_METHOD);
    return(-1); exit;
  end;

  clear_e(tPRD_PRDCOMP);
  putitem_e(tPRD_PRDCOMP, 'CD_PRODUTO', vCdProduto);
  retrieve_e(tPRD_PRDCOMP);
  if (xStatus >= 0) then begin
    setocc(tPRD_PRDCOMP, -1);
    setocc(tPRD_PRDCOMP, 1);
    if (xStatus < 0) then begin
      Result := SetStatus(STS_ERROR, 'GEN0001', 'Composição não cadastrada para o produto!', cDS_METHOD);
      return(-1); exit;
    end;

    clear_e(tPRD_COMPOSC);
    putitem_e(tPRD_COMPOSC, 'CD_COMPOSICAO', item_f('CD_COMPOSICAO', tPRD_PRDCOMP));
    retrieve_e(tPRD_COMPOSC);
    if (xStatus < 0) then begin
      Result := SetStatus(STS_ERROR, 'GEN0001', 'Composição não cadastrada!', cDS_METHOD);
      return(-1); exit;
    end;
    if (vTpComposicao = 'C') then begin
      vDsCampo := '' + item_a('DS_COMPOSICAO', tPRD_COMPOSC)' + ';
    end else begin
      setocc(tPRD_COMPOSC, 1);
      sort/e(t PRD_COMPOSI, 'PR_COMPOSICAO desc';);
      setocc(tPRD_COMPOSI, 1);
      if (xStatus < 0) then begin
        Result := SetStatus(STS_ERROR, 'GEN0001', 'Item não cadastrado na composição!', cDS_METHOD);
        return(-1); exit;
      end;

      clear_e(tPRD_FIBRA);
      putitem_e(tPRD_FIBRA, 'CD_FIBRA', item_f('CD_FIBRA', tPRD_COMPOSI));
      retrieve_e(tPRD_FIBRA);
      if (xStatus >= 0) then begin
        if (vTpPercentual = 1) then begin
          gPrPercentual1 := item_f('PR_COMPOSICAO', tPRD_COMPOSI);
          vDsCampo := '' + gPrPercentual + '1 % ' + item_a('DS_FIBRA', tPRD_FIBRA)' + ';

        end else if (vTpPercentual  = 4) then begin
          gPrPercentual4 := item_f('PR_COMPOSICAO', tPRD_COMPOSI);
          vDsCampo := '' + gPrPercentual + '4 % ' + item_a('DS_FIBRA', tPRD_FIBRA)' + ';

        end else begin
          gPrPercentual := item_f('PR_COMPOSICAO', tPRD_COMPOSI);
          vDsCampo := '' + gPrPercentual + ' % ' + item_a('DS_FIBRA', tPRD_FIBRA)' + ';
        end;
      end else begin
        vDsCampo := '';
      end;
    end;
  end else begin
    clear_e(tPRD_PRDGRADE);
    putitem_e(tPRD_PRDGRADE, 'CD_PRODUTO', vCdProduto);
    retrieve_e(tPRD_PRDGRADE);
    if (xStatus >= 0) then begin
      sort/e(t PRD_GRUPOCOMP, 'CD_COMPOSICAO';);
      setocc(tPRD_GRUPOCOMP, 1);
      if (xStatus < 0) then begin
        Result := SetStatus(STS_ERROR, 'GEN0001', 'Composição não cadastrada para o grupo!', cDS_METHOD);
        return(-1); exit;
      end;
      if (item_f('CD_COMPOSICAO', tPRD_GRUPOCOMP) = 0) then begin
        Result := SetStatus(STS_ERROR, 'GEN0001', 'Código da composição não cadastrado!', cDS_METHOD);
        return(-1); exit;
      end;

      clear_e(tPRD_COMPOSC);
      putitem_e(tPRD_COMPOSC, 'CD_COMPOSICAO', item_f('CD_COMPOSICAO', tPRD_GRUPOCOMP));
      retrieve_e(tPRD_COMPOSC);
      if (xStatus < 0) then begin
        Result := SetStatus(STS_ERROR, 'GEN0001', 'Composição não cadastrada!', cDS_METHOD);
        return(-1); exit;
      end;
      if (vTpComposicao = 'C') then begin
        vDsCampo := '' + item_a('DS_COMPOSICAO', tPRD_COMPOSC)' + ';
      end else begin
        setocc(tPRD_COMPOSC, 1);
        sort/e(t PRD_COMPOSI, 'PR_COMPOSICAO desc';);
        setocc(tPRD_COMPOSI, 1);
        if (xStatus < 0) then begin
          Result := SetStatus(STS_ERROR, 'GEN0001', 'Item não cadastrado na composição!', cDS_METHOD);
          return(-1); exit;
        end;
        clear_e(tPRD_FIBRA);
        putitem_e(tPRD_FIBRA, 'CD_FIBRA', item_f('CD_FIBRA', tPRD_COMPOSI));
        retrieve_e(tPRD_FIBRA);
        if (xStatus >= 0) then begin
          if (vTpPercentual = 1) then begin
            gPrPercentual1 := item_f('PR_COMPOSICAO', tPRD_COMPOSI);
            vDsCampo := '' + gPrPercentual + '1 % ' + item_a('DS_FIBRA', tPRD_FIBRA)' + ';

          end else if (vTpPercentual  = 4) then begin
            gPrPercentual4 := item_f('PR_COMPOSICAO', tPRD_COMPOSI);
            vDsCampo := '' + gPrPercentual + '4 % ' + item_a('DS_FIBRA', tPRD_FIBRA)' + ';

          end else begin
            gPrPercentual := item_f('PR_COMPOSICAO', tPRD_COMPOSI);
            vDsCampo := '' + gPrPercentual + ' % ' + item_a('DS_FIBRA', tPRD_FIBRA)' + ';
          end;
        end else begin
          vDsCampo := '';
        end;
      end;
    end;
  end;

  Result := '';
  putitemXml(Result, 'DS_COMPOSICAO', vDsCampo);

  return(0); exit;
end;

//----------------------------------------------------------------------------
function T_PRDSVCO008.buscaDadosComposicaoGrupoPrd(pParams : String) : String;
//----------------------------------------------------------------------------
const
  cDS_METHOD = 'ADICONAL=Operação: T_PRDSVCO008.buscaDadosComposicaoGrupoPrd()';
var
  vCdProduto, vNrComposicao, vCdSeqGrupo : Real;
  vDsLstCompGrupo, vDsItemFibra, vDsLstFibra, vDsItemCompGrupo : String;
  vDsItemCompProd, vDsLstCompProd : String;
begin
  vCdSeqGrupo := itemXmlF('CD_SEQGRUPO', pParams);
  vCdProduto := itemXmlF('CD_PRODUTO', pParams);

  if (vCdSeqGrupo = 0 ) and (vCdProduto = 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Código do grupo e/ou produto não informado!', cDS_METHOD);
    return(-1); exit;
  end;

  vDsLstCompProd := '';
  vDsLstCompGrupo := '';

  if (vCdSeqGrupo > 0) then begin
    clear_e(tF_PRD_GRUPOCO);
    putitem_e(tF_PRD_GRUPOCO, 'CD_SEQGRUPO', vCdSeqGrupo);
    retrieve_e(tF_PRD_GRUPOCO);
    if (xStatus >= 0) then begin
      setocc(tF_PRD_GRUPOCO, 1);
      while (xStatus >= 0) do begin
        clear_e(tPRD_COMPOSC);
        putitem_e(tPRD_COMPOSC, 'CD_COMPOSICAO', item_f('CD_COMPOSICAO', tF_PRD_GRUPOCO));
        retrieve_e(tPRD_COMPOSC);
        if not (xStatus >= 0 ) and (empty(PRD_COMPOSI)) then begin
          vDsLstFibra := '';
          setocc(tPRD_COMPOSI, 1);
            while (xStatus >= 0) do begin

            clear_e(tPRD_FIBRA);
            putitem_e(tPRD_FIBRA, 'CD_FIBRA', item_f('CD_FIBRA', tPRD_COMPOSI));
            retrieve_e(tPRD_FIBRA);
            if (xStatus >= 0) then begin
              vDsItemFibra := '';
              putitemXml(vDsItemFibra, 'CD_FIBRA', item_f('CD_FIBRA', tPRD_COMPOSI));
              putitemXml(vDsItemFibra, 'PR_COMPOSICAO', item_f('PR_COMPOSICAO', tPRD_COMPOSI));
              putitemXml(vDsItemFibra, 'DS_FIBRA', item_a('DS_FIBRA', tPRD_FIBRA));
              putitem(vDsLstFibra,  vDsItemFibra);
            end;

            setocc(tPRD_COMPOSI, curocc(tPRD_COMPOSI) + 1);
          end;

          vDsItemCompGrupo := '';
          putitemXml(vDsItemCompGrupo, 'CD_COMPOSICAO', item_f('CD_COMPOSICAO', tPRD_COMPOSC));
          putitemXml(vDsItemCompGrupo, 'DS_LSTFIBRA', vDsLstFibra);
          putitem(vDsLstCompGrupo,  vDsItemCompGrupo);

        end;
        setocc(tF_PRD_GRUPOCO, curocc(tF_PRD_GRUPOCO) + 1);
      end;
    end;
    if (vDsLstCompGrupo <> '') then begin
      putitemXml(Result, 'DS_LSTCOMPGRUPO', vDsLstCompGrupo);
    end;
  end;
  if (vCdProduto > 0) then begin
    clear_e(tPRD_PRDCOMP);
    putitem_e(tPRD_PRDCOMP, 'CD_PRODUTO', vCdProduto);
    retrieve_e(tPRD_PRDCOMP);
    if (xStatus >= 0) then begin
      setocc(tPRD_PRDCOMP, 1);
      while (xStatus >= 0) do begin
        clear_e(tPRD_COMPOSC);
        putitem_e(tPRD_COMPOSC, 'CD_COMPOSICAO', item_f('CD_COMPOSICAO', tPRD_PRDCOMP));
        retrieve_e(tPRD_COMPOSC);
        if not (xStatus >= 0 ) and (empty(PRD_COMPOSI)) then begin
          vDsLstFibra := '';
          setocc(tPRD_COMPOSI, 1);
          while (xStatus >= 0) do begin

            clear_e(tPRD_FIBRA);
            putitem_e(tPRD_FIBRA, 'CD_FIBRA', item_f('CD_FIBRA', tPRD_COMPOSI));
            retrieve_e(tPRD_FIBRA);
            if (xStatus >= 0) then begin
              vDsItemFibra := '';
              putitemXml(vDsItemFibra, 'CD_FIBRA', item_f('CD_FIBRA', tPRD_COMPOSI));
              putitemXml(vDsItemFibra, 'PR_COMPOSICAO', item_f('PR_COMPOSICAO', tPRD_COMPOSI));
              putitemXml(vDsItemFibra, 'DS_FIBRA', item_a('DS_FIBRA', tPRD_FIBRA));
              putitem(vDsLstFibra,  vDsItemFibra);
            end;

            setocc(tPRD_COMPOSI, curocc(tPRD_COMPOSI) + 1);
          end;

          vDsItemCompProd := '';
          putitemXml(vDsItemCompProd, 'CD_COMPOSICAO', item_f('CD_COMPOSICAO', tPRD_COMPOSC));
          putitemXml(vDsItemCompProd, 'DS_LSTFIBRA', vDsLstFibra);
          putitem(vDsLstCompProd,  vDsItemCompProd);

        end;

        setocc(tPRD_PRDCOMP, curocc(tPRD_PRDCOMP) + 1);
      end;
    end;
    if (vDsLstCompProd <> '') then begin
      putitemXml(Result, 'DS_LSTCOMPPRODUTO', vDsLstCompProd);
    end;
  end;

  return(0); exit;
end;

//--------------------------------------------------------------------
function T_PRDSVCO008.buscaGradeFrequencia(pParams : String) : String;
//--------------------------------------------------------------------
const
  cDS_METHOD = 'ADICONAL=Operação: T_PRDSVCO008.buscaGradeFrequencia()';
var
  vCdSeqGrupo, vCdTamanho, vQtFrequencia : Real;
  vCdCor : String;
begin
  vCdSeqGrupo := itemXmlF('CD_SEQGRUPO', pParams);
  vCdCor := itemXmlF('CD_COR', pParams);
  vCdTamanho := itemXmlF('CD_TAMANHO', pParams);

  if (vCdSeqGrupo = 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Grupo não informado!', cDS_METHOD);
    return(-1); exit;
  end;
  if (vCdCor = '') then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Cor não informada!', cDS_METHOD);
    return(-1); exit;
  end;
  if (vCdTamanho = 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Tamnho não informado!', cDS_METHOD);
    return(-1); exit;
  end;

  clear_e(tPRD_PRDGRADE);
  putitem_e(tPRD_PRDGRADE, 'CD_SEQGRUPO', vCdSeqGrupo);
  retrieve_e(tPRD_PRDGRADE);
  if (xStatus < 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Grupo não encontrado!', cDS_METHOD);
    return(-1); exit;
  end;

  vQtFrequencia := 0;

  clear_e(tPRD_GRDFREQCO);
  putitem_e(tPRD_GRDFREQCO, 'CD_SEQ', vCdSeqGrupo);
  putitem_e(tPRD_GRDFREQCO, 'CD_COR', vCdCor);
  putitem_e(tPRD_GRDFREQCO, 'CD_TAMANHO', vCdTamanho);
  putitem_e(tPRD_GRDFREQCO, 'IN_PADRAO', True);
  retrieve_e(tPRD_GRDFREQCO);
  if (xStatus >= 0) then begin
    vQtFrequencia := item_f('QT_FREQUENCIA', tPRD_GRDFREQCO);
  end;
  if (vQtFrequencia = 0) then begin
    clear_e(tPRD_GRDFREQG);
    putitem_e(tPRD_GRDFREQG, 'CD_SEQGRUPO', vCdSeqGrupo);
    putitem_e(tPRD_GRDFREQG, 'CD_TAMANHO', vCdTamanho);
    putitem_e(tPRD_GRDFREQG, 'IN_PADRAO', True);
    retrieve_e(tPRD_GRDFREQG);
    if (xStatus >= 0) then begin
      vQtFrequencia := item_f('QT_FREQUENCIA', tPRD_GRDFREQG);
    end;
  end;
  if (vQtFrequencia = 0) then begin
    clear_e(tPRD_GRDFREQ);
    putitem_e(tPRD_GRDFREQ, 'CD_GRADE', '=' + item_f('CD_GRADE', tPRD_GRUPO)' + ');
    putitem_e(tPRD_GRDFREQ, 'CD_TAMANHO', vCdTamanho);
    putitem_e(tPRD_GRDFREQ, 'IN_PADRAO', True);
    retrieve_e(tPRD_GRDFREQ);
    if (xStatus >= 0) then begin
      vQtFrequencia := item_f('QT_FREQUENCIA', tPRD_GRDFREQ);
    end;
  end;

  Result := '';
  putitemXml(Result, 'QT_FREQUENCIA', vQtFrequencia);

  return(0); exit;
end;

end.
