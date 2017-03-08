unit cPRDSVCO007;

interface

(* COMPONENTES 
  ADMSVCO001 / GERSVCO031 / PRDSVCO007 / 
*)        

uses
  Classes, SysUtils, Math, DB,
  cServiceUnf, cDataSetUnf;

type
  T_PRDSVCO007 = class(TcServiceUnf)
  private
    tGER_EMPRESA,
    tPRD_ALTVALOR,
    tPRD_GRUPO,
    tPRD_MOTIVOALT,
    tPRD_PRDGRADE,
    tPRD_USUCDVALO,
    tPRD_VALOR,
    tV_PRD_PROMOCA : TcDatasetUnf;
    function getParam(pParams : String = '') : String;
    function setEntidade(pParams : String = '') : String;
  protected
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;    
  published
    function arredondaPrecoPontoM(pParams : String = '') : String;
    function atualizaValor(pParams : String = '') : String;
    function gravaAltValor(pParams : String = '') : String;
    function buscaValorData(pParams : String = '') : String;
    function calculaValorMedio(pParams : String = '') : String;
    function arredondaPreco(pParams : String = '') : String;
  end;

implementation

uses
  cADMSVCO001,
  cActivate, cStatus, cFuncao, cXml, dModulo;

var
  gCdEmpresaValorEmp,
  gCdEmpresaValorSis,
  gNrDecimalAbaixoPontoM,
  gNrDecimalAcimaPontoM,
  gNrInteiroAbaixoPontoM,
  gNrInteiroAcimaPontoM,
  gNrPontomArred,
  gTpArredondamento,
  gTpValidacaoValorUsu : String;

//---------------------------------------------------------------
constructor T_PRDSVCO007.Create(AOwner: TComponent);
//---------------------------------------------------------------
begin
  inherited Create(AOwner);
  setEntidade('');
end;

//--------------------------------
destructor T_PRDSVCO007.Destroy;
//--------------------------------
begin
  inherited Destroy;
end;

//---------------------------------------------------------------
function T_PRDSVCO007.getParam(pParams : String = '') : String;
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
  putitem(xParam, 'CD_EMPRESA_VALOR');
  putitem(xParam, 'CD_EMPVALOR');
  putitem(xParam, 'NR_DECIMAL_ABAIXO_PONTOM');
  putitem(xParam, 'NR_DECIMAL_ACIMA_PONTOM');
  putitem(xParam, 'NR_INTEIRO_ABAIXO_PONTOM');
  putitem(xParam, 'NR_INTEIRO_ACIMA_PONTOM');
  putitem(xParam, 'NR_PONTOM_ARRED');
  putitem(xParam, 'TP_ARREDONDAMENTO_PRECO');

  xParam := T_ADMSVCO001.GetParametro(xParam);

  gCdEmpresaValorSis := itemXml('CD_EMPVALOR', xParam);
  gNrDecimalAbaixoPontoM := itemXml('NR_DECIMAL_ABAIXO_PONTOM', xParam);
  gNrDecimalAcimaPontoM := itemXml('NR_DECIMAL_ACIMA_PONTOM', xParam);
  gNrInteiroAbaixoPontoM := itemXml('NR_INTEIRO_ABAIXO_PONTOM', xParam);
  gNrInteiroAcimaPontoM := itemXml('NR_INTEIRO_ACIMA_PONTOM', xParam);
  gNrPontomArred := itemXml('NR_PONTOM_ARRED', xParam);
  gTpArredondamento := itemXml('TP_ARREDONDAMENTO_PRECO', xParam);

  xParamEmp := '';
  putitem(xParamEmp, 'CD_EMPRESA_VALOR');

  xParamEmp := T_ADMSVCO001.GetParamEmpresa(piCdEmpresa, xParamEmp);

  gCdEmpresaValorEmp := itemXml('CD_EMPRESA_VALOR', xParamEmp);
  gCdEmpresaValorSis := itemXml('CD_EMPVALOR', xParamEmp);
  gNrDecimalAbaixoPontoM := itemXml('NR_DECIMAL_ABAIXO_PONTOM', xParamEmp);
  gNrDecimalAcimaPontoM := itemXml('NR_DECIMAL_ACIMA_PONTOM', xParamEmp);
  gNrInteiroAbaixoPontoM := itemXml('NR_INTEIRO_ABAIXO_PONTOM', xParamEmp);
  gNrInteiroAcimaPontoM := itemXml('NR_INTEIRO_ACIMA_PONTOM', xParamEmp);
  gNrPontomArred := itemXml('NR_PONTOM_ARRED', xParamEmp);
  gTpArredondamento := itemXml('TP_ARREDONDAMENTO_PRECO', xParamEmp);

end;

//---------------------------------------------------------------
function T_PRDSVCO007.setEntidade(pParams : String = '') : String;
//---------------------------------------------------------------
begin
  tGER_EMPRESA := GetEntidade('GER_EMPRESA');
  tPRD_ALTVALOR := GetEntidade('PRD_ALTVALOR');
  tPRD_GRUPO := GetEntidade('PRD_GRUPO');
  tPRD_MOTIVOALT := GetEntidade('PRD_MOTIVOALT');
  tPRD_PRDGRADE := GetEntidade('PRD_PRDGRADE');
  tPRD_USUCDVALO := GetEntidade('PRD_USUCDVALO');
  tPRD_VALOR := GetEntidade('PRD_VALOR');
  tV_PRD_PROMOCA := GetEntidade('V_PRD_PROMOCA');
end;

//--------------------------------------------------------------------
function T_PRDSVCO007.arredondaPrecoPontoM(pParams : String) : String;
//--------------------------------------------------------------------
const
  cDS_METHOD = 'ADICONAL=Operação: T_PRDSVCO007.arredondaPrecoPontoM()';
var
  (* numeric piVlValor : IN / numeric poVlValor : OUT *)
  viGlobal, viParams, voParams : String;
  vVlInteiro, vVlDecimal : Real;
begin
  vVlInteiro := piVlValor[Trunc];
  vVlDecimal := piVlValor[Fraction] * 100;

  if (vVlDecimal < gNrPontomArred) then begin
    vVlInteiro := vVlInteiro + gNrInteiroAbaixoPontoM;
    vVlDecimal := gNrDecimalAbaixoPontoM;
  end else begin
    vVlInteiro := vVlInteiro + gNrInteiroAcimaPontoM;
    vVlDecimal := gNrDecimalAcimaPontoM;
  end;
  poVlValor := vVlInteiro + (vVlDecimal / 100);

  return(0); exit;
end;

//-------------------------------------------------------------
function T_PRDSVCO007.atualizaValor(pParams : String) : String;
//-------------------------------------------------------------
const
  cDS_METHOD = 'ADICONAL=Operação: T_PRDSVCO007.atualizaValor()';
begin
var
  (* string piGlobal :IN *)
  vNrSequencia, vVlProdutoAnt, vCdEmpresa, vCdGrupoEmpresa, vCdProduto : Real;
  vCdValor, vVlValor, vCdMotivo, vCdSeqGrupo, vCdUsuario : Real;
  vinAlterou, vInSoProduto : Boolean;
  viParams, voParams, vTpValor, vDsLstProduto : String;
  vDtMovimento : TDate;
begin
  vDsLstProduto := '';
  vInAlterou := False;
  vCdEmpresa := itemXmlF('CD_EMPRESA', pParams);
  vCdProduto := itemXmlF('CD_PRODUTO', pParams);
  vCdSeqGrupo := itemXmlF('CD_SEQGRUPO', pParams);
  vTpValor := itemXmlF('TP_VALOR', pParams);
  vCdValor := itemXmlF('CD_VALOR', pParams);
  vVlValor := itemXmlF('VL_PRODUTOATU', pParams);
  vCdMotivo := itemXmlF('CD_MOTIVO', pParams);
  vInSoProduto := itemXmlB('IN_SOPRODUTO', pParams);
  vDtMovimento := itemXml('DT_SISTEMA', piGlobal);
  vCdUsuario := itemXmlF('CD_USUARIO', PARAM_GLB);

  gTpValidacaoValorUsu := itemXmlF('TP_VALIDACAO_VALOR_USU', PARAM_GLB);

  if (vCdProduto = 0) then begin
    if (vCdSeqGrupo > 0) then begin
      clear_e(tPRD_GRUPO);
      putitem_e(tPRD_GRUPO, 'CD_SEQ', vCdSeqGrupo);
      retrieve_e(tPRD_GRUPO);
      if (xStatus >= 0) then begin
        if (item_f('CD_PRODUTO', tPRD_GRUPO) = 0) then begin
          clear_e(tPRD_PRDGRADE);
          putitem_e(tPRD_PRDGRADE, 'CD_SEQGRUPO', item_f('CD_SEQ', tPRD_GRUPO));
          retrieve_e(tPRD_PRDGRADE);
          if (xStatus >= 0) then begin
            setocc(tPRD_PRDGRADE, 1);
            while (xStatus >= 0) do begin
              putitem(vDsLstProduto,  item_f('CD_PRODUTO', tPRD_PRDGRADE));
              setocc(tPRD_PRDGRADE, curocc(tPRD_PRDGRADE) + 1);
            end;
          end;
        end else begin
          vDsLstProduto := item_f('CD_PRODUTO', tPRD_GRUPO);
        end;
      end;
      if (vDsLstProduto = '') then begin
        voParams := SetErroApl(viParams); (* 'ERRO=-1;
        return(-1); exit;
      end;
    end;
  end else begin
    if (vInSoProduto <> True) then begin
      clear_e(tPRD_PRDGRADE);
      putitem_e(tPRD_PRDGRADE, 'CD_PRODUTO', vCdProduto);
      retrieve_e(tPRD_PRDGRADE);
      if (xStatus >= 0) then begin
        clear_e(tPRD_GRUPO);
        putitem_e(tPRD_GRUPO, 'CD_SEQ', item_f('CD_SEQGRUPO', tPRD_PRDGRADE));
        retrieve_e(tPRD_GRUPO);
        if (xStatus >= 0) then begin
          if (item_f('CD_PRODUTO', tPRD_GRUPO) > 0) then begin
            vCdProduto := item_f('CD_PRODUTO', tPRD_GRUPO);
          end;
        end;
      end;
    end;
    vDsLstProduto := vCdProduto;
  end;
  if (vCdEmpresa = '') then begin
    voParams := SetErroApl(viParams); (* 'ERRO=-1;
    return(-1); exit;
  end;
  if (vDsLstProduto = '') then begin
    voParams := SetErroApl(viParams); (* 'ERRO=-1;
    return(-3);
  end;
  if (vTpValor = '') then begin
    voParams := SetErroApl(viParams); (* 'ERRO=-1;
    return(-1); exit;
  end;
  if (vCdValor = '') then begin
    voParams := SetErroApl(viParams); (* 'ERRO=-1;
    return(-1); exit;
  end;
  if (vCdMotivo = '') then begin
    voParams := SetErroApl(viParams); (* 'ERRO=-1;
    return(-1); exit;
  end;

  clear_e(tGER_EMPRESA);
  putitem_e(tGER_EMPRESA, 'CD_EMPRESA', vCdEmpresa);
  retrieve_e(tGER_EMPRESA);
  if (xStatus >= 0) then begin
    vCdGrupoEmpresa := item_f('CD_GRUPOEMPRESA', tGER_EMPRESA);
  end else begin
    vCdGrupoEmpresa := itemXmlF('CD_GRUPOEMPRESA', piGlobal);
  end;

  repeat
    getitem(vCdProduto, vDsLstProduto, 1);

    if (gTpValidacaoValorUsu = 1) then begin
      clear_e(tPRD_USUCDVALO);
      putitem_e(tPRD_USUCDVALO, 'CD_EMPRESA', vCdEmpresa);
      putitem_e(tPRD_USUCDVALO, 'CD_USUARIO', vCdUsuario);
      putitem_e(tPRD_USUCDVALO, 'CD_VALOR', vCdValor);
      putitem_e(tPRD_USUCDVALO, 'TP_VALOR', vTpValor);
      retrieve_e(tPRD_USUCDVALO);
      if (xStatus < 0) then begin
        voParams := SetErroApl(viParams); (* 'ERRO=-1;
        return(-1); exit;
      end;
    end;

    viParams := '';

    putitemXml(viParams, 'NM_ENTIDADE', 'PRD_ALTVALOR');
    voParams := activateCmp('GERSVCO031', 'getNumSeq', viParams);
    if (xStatus < 0) then begin
      Result := voParams;
      return(-1); exit;
    end;

    vNrSequencia := itemXmlF('NR_SEQUENCIA', voParams);

    clear_e(tPRD_VALOR);
    creocc(tPRD_VALOR, -1);
    putitem_e(tPRD_VALOR, 'CD_EMPRESA', vCdEmpresa);
    putitem_e(tPRD_VALOR, 'CD_PRODUTO', vCdProduto);
    putitem_e(tPRD_VALOR, 'TP_VALOR', vTpValor);
    putitem_e(tPRD_VALOR, 'CD_VALOR', vCdValor);
    retrieve_o(tPRD_VALOR);
    if (xStatus = -7) then begin
      retrieve_x(tPRD_VALOR);
    end;
    if (item_f('VL_PRODUTO', tPRD_VALOR) <> vVlValor) then begin
      vVlProdutoAnt := item_f('VL_PRODUTO', tPRD_VALOR);
      putitem_e(tPRD_VALOR, 'VL_PRODUTO', vVlValor);
      putitem_e(tPRD_VALOR, 'CD_GRUPOEMPRESA', vCdGrupoEmpresa);
      putitem_e(tPRD_VALOR, 'CD_OPERADOR', itemXmlF('CD_USUARIO', piGlobal));
      putitem_e(tPRD_VALOR, 'DT_CADASTRO', Now);
      putitem_e(tPRD_VALOR, 'IN_BASEMARKUP', False);
      voParams := tPRD_VALOR.Salvar();
      if (xStatus < 0) then begin
        Result := voParams;
        return(-1); exit;
      end;
        putitem_e(tPRD_ALTVALOR, 'CD_MOTIVO', vCdMotivo);
        putitem_e(tPRD_ALTVALOR, 'VL_ANTERIOR', vVlProdutoAnt);
        putitem_e(tPRD_ALTVALOR, 'VL_ATUALIZADO', vVlValor);
        putitem_e(tPRD_ALTVALOR, 'CD_GRUPOEMPRESA', vCdGrupoEmpresa);
        putitem_e(tPRD_ALTVALOR, 'CD_OPERADOR', itemXmlF('CD_USUARIO', piGlobal));
        putitem_e(tPRD_ALTVALOR, 'DT_CADASTRO', Now);
        voParams := tPRD_ALTVALOR.Salvar();
        if (xStatus < 0) then begin
          Result := voParams;
          return(-1); exit;
        end;
      end;
    end;

    delitem(vDsLstProduto, 1);
  until (vDsLstProduto = '');

  putitemXml(Result, 'IN_ALTEROU', vInAlterou);

  return(0); exit;
end;

//-------------------------------------------------------------
function T_PRDSVCO007.gravaAltValor(pParams : String) : String;
//-------------------------------------------------------------
const
  cDS_METHOD = 'ADICONAL=Operação: T_PRDSVCO007.gravaAltValor()';
var
  (* string piGlobal : IN *)
  vCdEmpresa, vCdProduto, vCdValor, vVlValor, vNrSeq, vVlAnterior, vCdGrupoEmpresa, vCdMotivo : Real;
  vDsTpValor, viParams, voParams : String;
  vDtMovimento : TDate;
begin
  vCdEmpresa := itemXmlF('CD_EMPRESA', pParams);
  vCdProduto := itemXmlF('CD_PRODUTO', pParams);
  vDsTpValor := itemXmlF('TP_VALOR', pParams);
  vCdValor := itemXmlF('CD_VALOR', pParams);
  vCdMotivo := itemXmlF('CD_MOTIVO', pParams);
  vDtMovimento := itemXml('DT_MOVIMENTO', pParams);
  vVlValor := itemXmlF('VL_ATUALIZADO', pParams);

  if (vCdEmpresa = 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Empresa não informada. Verifique!', cDS_METHOD);
    return(-1); exit;
  end;
  if (vCdProduto = 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Produto não informado. Verifique!', cDS_METHOD);
    return(-1); exit;
  end;
  if (vDsTpValor = '') then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Tipo de valor não informado. Verifique!', cDS_METHOD);
    return(-1); exit;
  end;
  if (vCdValor = 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Código do valor não informado. Verifique!', cDS_METHOD);
    return(-1); exit;
  end;
  if (vCdMotivo = 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Motivo não informado. Verifique!', cDS_METHOD);
    return(-1); exit;
  end;
  if (vDtMovimento = '') then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Data do movimento não informado. Verifique!', cDS_METHOD);
    return(-1); exit;
  end;
  if (vVlValor = 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Valor não informado. Verifique!', cDS_METHOD);
    return(-1); exit;
  end;

  clear_e(tPRD_MOTIVOALT);
  putitem_e(tPRD_MOTIVOALT, 'CD_MOTIVO', vCdMotivo);
  retrieve_e(tPRD_MOTIVOALT);
  if (xStatus < 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Motivo ' + FloatToStr(vCdMotivo) + ' não encontrado. Verifique!', cDS_METHOD);
    return(-1); exit;
  end;

  clear_e(tGER_EMPRESA);
  putitem_e(tGER_EMPRESA, 'CD_EMPRESA', vCdEmpresa);
  retrieve_e(tGER_EMPRESA);
  if (xStatus >= 0) then begin
    vCdGrupoEmpresa := item_f('CD_GRUPOEMPRESA', tGER_EMPRESA);
  end else begin
    vCdGrupoEmpresa := itemXmlF('CD_GRUPOEMPRESA', piGlobal);
  end;

  clear_e(tPRD_PRDGRADE);
  putitem_e(tPRD_PRDGRADE, 'CD_PRODUTO', vCdProduto);
  retrieve_e(tPRD_PRDGRADE);
  if (xStatus >= 0) then begin
    clear_e(tPRD_GRUPO);
    putitem_e(tPRD_GRUPO, 'CD_SEQ', item_f('CD_SEQGRUPO', tPRD_PRDGRADE));
    retrieve_e(tPRD_GRUPO);
    if (xStatus >= 0 ) and (item_f('CD_PRODUTO', tPRD_GRUPO) > 0) then begin
      vCdProduto := item_f('CD_PRODUTO', tPRD_GRUPO);
    end;
  end else begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Produto ' + FloatToStr(vCdProduto) + ' não encontrado. Verifique!', cDS_METHOD);
    return(-1); exit;
  end;

  clear_e(tPRD_ALTVALOR);
  putitem_e(tPRD_ALTVALOR, 'CD_EMPRESA', vCdEmpresa);
  putitem_e(tPRD_ALTVALOR, 'CD_PRODUTO', vCdProduto);
  putitem_e(tPRD_ALTVALOR, 'TP_VALOR', vDsTpValor);
  putitem_e(tPRD_ALTVALOR, 'CD_VALOR', vCdValor);
  putitem_e(tPRD_ALTVALOR, 'DT_MOVIMENTO', '<=' + vDtMovimento' + ');
  retrieve_e(tPRD_ALTVALOR);
  if (xStatus >= 0) then begin
    sort/e(t PRD_ALTVALOR, 'NR_SEQUENCIA:d';);
    setocc(tPRD_ALTVALOR, 1);
    vVlAnterior := item_f('VL_ATUALIZADO', tPRD_ALTVALOR);
  end else begin
    vVlAnterior := 0;
  end;

  viParams := '';

  putitemXml(viParams, 'NM_ENTIDADE', 'PRD_ALTVALOR');
  voParams := activateCmp('GERSVCO031', 'getNumSeq', viParams);
  if (xStatus < 0) then begin
    Result := voParams;
    return(-1); exit;
  end;

  vNrSeq := itemXmlF('NR_SEQUENCIA', voParams);

  clear_e(tPRD_ALTVALOR);
  putitem_e(tPRD_ALTVALOR, 'CD_EMPRESA', vCdEmpresa);
  putitem_e(tPRD_ALTVALOR, 'CD_PRODUTO', vCdProduto);
  putitem_e(tPRD_ALTVALOR, 'TP_VALOR', vDsTpValor);
  putitem_e(tPRD_ALTVALOR, 'CD_VALOR', vCdValor);
  putitem_e(tPRD_ALTVALOR, 'DT_MOVIMENTO', vDtMovimento);
  putitem_e(tPRD_ALTVALOR, 'NR_SEQUENCIA', vNrSeq);
  retrieve_o(tPRD_ALTVALOR);
  if (xStatus = -7) then begin
    retrieve_x(tPRD_ALTVALOR);
  end;

  putitem_e(tPRD_ALTVALOR, 'CD_GRUPOEMPRESA', vCdGrupoEmpresa);
  putitem_e(tPRD_ALTVALOR, 'CD_MOTIVO', vCdMotivo);
  putitem_e(tPRD_ALTVALOR, 'VL_ATUALIZADO', vVlValor);

  if (vVlAnterior > 0) then begin
    putitem_e(tPRD_ALTVALOR, 'VL_ANTERIOR', vVlAnterior);
  end;

  putitem_e(tPRD_ALTVALOR, 'CD_OPERADOR', itemXmlF('CD_USUARIO', piGlobal));
  putitem_e(tPRD_ALTVALOR, 'DT_CADASTRO', Now);

  voParams := tPRD_ALTVALOR.Salvar();
  if (xStatus < 0) then begin
    Result := voParams;
    return(-1); exit;
  end;

  putlistitensocc_e(Result, tPRD_ALTVALOR);

  return(0); exit;
end;

//--------------------------------------------------------------
function T_PRDSVCO007.buscaValorData(pParams : String) : String;
//--------------------------------------------------------------
const
  cDS_METHOD = 'ADICONAL=Operação: T_PRDSVCO007.buscaValorData()';
var
  (* string piGlobal :IN / string piListas :IN *)
  vCdEmpresaParam, vCdProduto, vCdSeqGrupo, vCdValor, vQtSaldo, vVlValor : Real;
  vCdEmpresa, vCdPromocao, vNrPrazoMedio, vCdEmpPromocao : Real;
  vTpValor, vDsLstEmpresa, vDsNulo : String;
  vInPromocao, vInSoProduto, vInSoEmpresa, vInPromocaoAberta : Boolean;
  vDtValor, vDtSistema, vDtMovimentoAnt : TDate;
begin
  vVlValor := 0;
  vCdPromocao := 0;
  vDsNulo := '';
  vCdEmpresaParam := itemXmlF('CD_EMPRESA', pParams);
  if (vCdEmpresaParam = '') then begin
    vCdEmpresaParam := itemXmlF('CD_EMPRESA', piGlobal);
  end;
  vCdProduto := itemXmlF('CD_PRODUTO', pParams);
  vCdSeqGrupo := itemXmlF('CD_SEQGRUPO', pParams);
  vTpValor := itemXmlF('TP_VALOR', pParams);
  vCdValor := itemXmlF('CD_VALOR', pParams);
  vInPromocao := itemXmlB('IN_PROMOCAO', pParams);
  vNrPrazoMedio := itemXmlF('NR_PRAZOMEDIO', pParams);
  vInSoProduto := itemXmlB('IN_SOPRODUTO', pParams);
  vInSoEmpresa := itemXmlB('IN_SOEMPRESA', pParams);
  vDtValor := itemXml('DT_VALOR', pParams);
  vDtSistema := itemXml('DT_SISTEMA', piGlobal);
  if (vDtValor  = '') then begin
    vDtValor := itemXml('DT_SISTEMA', piGlobal);
  end;
  gCdEmpresaValorEmp := itemXmlF('CD_EMPRESA_VALOR', pParams);
  gCdEmpresaValorSis := itemXmlF('CD_EMPVALOR', pParams);
  vInPromocaoAberta := itemXmlB('IN_PROMOCAOABERTA', pParams);
  if (gCdEmpresaValorEmp = '')  and (gCdEmpresaValorSis = '') then begin
    if (itemXml('CD_EMPVALOR', piGlobal) = '')  and (itemXml('CD_EMPRESA_VALOR', piGlobal) = '') then begin
      getParams(pParams); (* vCdEmpresaParam *)
      if (xStatus < 0) then begin
        return(-1); exit;
      end;
    end else begin
      gCdEmpresaValorEmp := itemXmlF('CD_EMPRESA_VALOR', piGlobal);
      gCdEmpresaValorSis := itemXmlF('CD_EMPVALOR', piGlobal);
    end;
  end;
  if (vCdProduto = 0) then begin
    if (vCdSeqGrupo > 0) then begin
      clear_e(tPRD_GRUPO);
      putitem_e(tPRD_GRUPO, 'CD_SEQ', vCdSeqGrupo);
      retrieve_e(tPRD_GRUPO);
      if (xStatus >= 0) then begin
        if (item_f('CD_PRODUTO', tPRD_GRUPO) = 0) then begin
          clear_e(tPRD_PRDGRADE);
          putitem_e(tPRD_PRDGRADE, 'CD_SEQGRUPO', item_f('CD_SEQ', tPRD_GRUPO));
          retrieve_e(tPRD_PRDGRADE);
          if (xStatus >= 0) then begin
            vCdProduto := item_f('CD_PRODUTO', tPRD_PRDGRADE);
          end;
        end else begin
          vCdProduto := item_f('CD_PRODUTO', tPRD_GRUPO);
        end;
      end;
    end;
  end else begin
    if (vInSoProduto <> True) then begin
      clear_e(tPRD_PRDGRADE);
      putitem_e(tPRD_PRDGRADE, 'CD_PRODUTO', vCdProduto);
      retrieve_e(tPRD_PRDGRADE);
      if (xStatus >= 0) then begin
        clear_e(tPRD_GRUPO);
        putitem_e(tPRD_GRUPO, 'CD_SEQ', item_f('CD_SEQGRUPO', tPRD_PRDGRADE));
        retrieve_e(tPRD_GRUPO);
        if (xStatus >= 0) then begin
          if (item_f('CD_PRODUTO', tPRD_GRUPO) > 0) then begin
            vCdProduto := item_f('CD_PRODUTO', tPRD_GRUPO);
          end;
        end;
      end;
    end;
  end;
  if (vInPromocao = True) then begin
    if (vCdEmpresaParam > 0) then begin
      putitem(vDsLstEmpresa,  vCdEmpresaParam);
    end;
    if (vInSoEmpresa <> True) then begin
      if (gCdEmpresaValorEmp > 0)  and (gCdEmpresaValorEmp <> vCdEmpresaParam) then begin
        putitem(vDsLstEmpresa,  gCdEmpresaValorEmp);
      end;
      if (gCdEmpresaValorSis > 0)  and (gCdEmpresaValorSis <> vCdEmpresaParam) then begin
        putitem(vDsLstEmpresa,  gCdEmpresaValorSis);
      end;
    end;

    while (vDsLstEmpresa <> '')  and (vVlValor := 0) do begin
      getitem(vCdEmpresa, vDsLstEmpresa, 1);
      clear_e(tV_PRD_PROMOCA);
      putitem_e(tV_PRD_PROMOCA, 'CD_EMPRESA', vCdEmpresa);
      putitem_e(tV_PRD_PROMOCA, 'CD_PRODUTO', vCdProduto);
      putitem_e(tV_PRD_PROMOCA, 'TP_VALOR', vTpValor);
      putitem_e(tV_PRD_PROMOCA, 'CD_VALOR', vCdValor);
      putitem_e(tV_PRD_PROMOCA, 'TP_SITUACAO', 'A');
      if (vInPromocaoAberta <> True) then begin
        putitem_e(tV_PRD_PROMOCA, 'DT_INICIO', '<=' + vDtValor' + ');
      end;
      putitem_e(tV_PRD_PROMOCA, 'DT_FINAL', '>=' + vDtValor' + ');
      if (vNrPrazoMedio <> '') then begin
        putitem_e(tV_PRD_PROMOCA, 'NR_PRAZOMEDIO', '>=' + FloatToStr(vNrPrazoMedioor=' + vDsNulo') + ' + ');
      end;
      retrieve_e(tV_PRD_PROMOCA);
      if (xStatus >= 0) then begin
        vVlValor := item_f('VL_PROMOCAO', tV_PRD_PROMOCA);
        vCdPromocao := item_f('CD_PROMOCAO', tV_PRD_PROMOCA);
        vCdEmpPromocao := item_f('CD_EMPRESA', tV_PRD_PROMOCA);
      end;
      delitem(vDsLstEmpresa, 1);
    end;
  end;
  if (vVlValor = 0) then begin
    if (vCdEmpresaParam > 0) then begin
      putitem(vDsLstEmpresa,  vCdEmpresaParam);
    end;
    if (vInSoEmpresa <> True) then begin
      if (gCdEmpresaValorEmp > 0)  and (gCdEmpresaValorEmp <> vCdEmpresaParam) then begin
        putitem(vDsLstEmpresa,  gCdEmpresaValorEmp);
      end;
      if (gCdEmpresaValorSis > 0)  and (gCdEmpresaValorSis <> vCdEmpresaParam) then begin
        putitem(vDsLstEmpresa,  gCdEmpresaValorSis);
      end;
    end;
    while (vDsLstEmpresa <> '')  and (vVlValor := 0) do begin
      getitem(vCdEmpresa, vDsLstEmpresa, 1);

      if (vDtValor <> vDtSistema) then begin
        vDtMovimentoAnt := '';
        select max(DT_MOVIMENTO) 
        FROM 'PRD_ALTVALORSVC' 
        where (putitem_e(tPRD_ALTVALOR, 'CD_EMPRESA', vCdEmpresa ) and (
        putitem_e(tPRD_ALTVALOR, 'CD_PRODUTO', vCdProduto ) and (
        putitem_e(tPRD_ALTVALOR, 'TP_VALOR', vTpValor ) and (
        putitem_e(tPRD_ALTVALOR, 'CD_VALOR', vCdValor ) and (
        item_a('DT_MOVIMENTO', tPRD_ALTVALOR) <= vDtValor)
        to vDtMovimentoAnt;
        if (xStatus < 0) then begin
          voParams := SetErroOpr(viParams); (* xProcerrorcontext, xCdErro, xCtxErro *)
          return(-1); exit;
        end else begin
          if (vDtMovimentoAnt <> '') then begin
            clear_e(tPRD_ALTVALOR);
            putitem_e(tPRD_ALTVALOR, 'CD_EMPRESA', vCdEmpresa);
            putitem_e(tPRD_ALTVALOR, 'CD_PRODUTO', vCdProduto);
            putitem_e(tPRD_ALTVALOR, 'TP_VALOR', vTpValor);
            putitem_e(tPRD_ALTVALOR, 'CD_VALOR', vCdValor);
            putitem_e(tPRD_ALTVALOR, 'DT_MOVIMENTO', vDtMovimentoAnt);
            retrieve_e(tPRD_ALTVALOR);
            if (xStatus >= 0) then begin
              sort/e(t PRD_ALTVALOR, 'DT_CADASTRO, NR_SEQUENCIA';);
              setocc(tPRD_ALTVALOR, -1);
              vVlValor := item_f('VL_ATUALIZADO', tPRD_ALTVALOR);
            end;
          end;
        end;
      end else begin
        clear_e(tPRD_VALOR);
        putitem_e(tPRD_VALOR, 'CD_EMPRESA', vCdEmpresa);
        putitem_e(tPRD_VALOR, 'CD_PRODUTO', vCdProduto);
        putitem_e(tPRD_VALOR, 'TP_VALOR', vTpValor);
        putitem_e(tPRD_VALOR, 'CD_VALOR', vCdValor);
        retrieve_e(tPRD_VALOR);
        if (xStatus >= 0) then begin
          vVlValor := item_f('VL_PRODUTO', tPRD_VALOR);
        end;
      end;
      if (vVlValor > 0) then begin
        break;
      end;

      delitem(vDsLstEmpresa, 1);
    end;
  end;

  Result := '';
  putitemXml(Result, 'VL_VALOR', vVlValor);
  putitemXml(Result, 'CD_PROMOCAO', vCdPromocao);
  putitemXml(Result, 'CD_EMPPROMOCAO', vCdEmpPromocao);

  return(0); exit;
end;

//-----------------------------------------------------------------
function T_PRDSVCO007.calculaValorMedio(pParams : String) : String;
//-----------------------------------------------------------------
const
  cDS_METHOD = 'ADICONAL=Operação: T_PRDSVCO007.calculaValorMedio()';
var
  (* string piGlobal :IN *)
  vDsLstEmpresa, vDsRegistro, viParams, viListas, voParams, vTpValor : String;
  vCdProduto, vCdSeqGrupo, vCdValor, vVlValor, vNrCont, vVlMedio : Real;
  vCdEmpresaValorEmp, vCdEmpresaValorSis : Real;
  vDtValor : TDate;
begin
  vDsLstEmpresa := itemXmlF('CD_EMPRESA', pParams);
  vCdProduto := itemXmlF('CD_PRODUTO', pParams);
  vCdSeqGrupo := itemXmlF('CD_SEQGRUPO', pParams);
  vCdValor := itemXmlF('CD_VALOR', pParams);
  vTpValor := itemXmlF('TP_VALOR', pParams);
  vDtValor := itemXml('DT_VALOR', pParams);
  vCdEmpresaValorEmp := itemXmlF('CD_EMPRESA_VALOR', pParams);
  vCdEmpresaValorSis := itemXmlF('CD_EMPVALOR', pParams);

  if (vDsLstEmpresa = '') then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Nenhuma empresa informada!', cDS_METHOD);
    return(-1); exit;
  end;

  vNrCont := 0;
  vVlValor := 0;

  repeat
    getitem(vDsRegistro, vDsLstEmpresa, 1);
    vNrCont := vNrCont + 1;

    viParams := '';
    viListas := '';
    putitemXml(viParams, 'CD_EMPRESA', vDsRegistro);
    putitemXml(viParams, 'CD_SEQGRUPO', vCdSeqGrupo);
    putitemXml(viParams, 'CD_PRODUTO', vCdProduto);
    putitemXml(viParams, 'TP_VALOR', vTpValor);
    putitemXml(viParams, 'CD_VALOR', vCdValor);
    putitemXml(viParams, 'DT_VALOR', vDtValor);
    putitemXml(viParams, 'CD_EMPRESA_VALOR', vCdEmpresaValorEmp);
    putitemXml(viParams, 'CD_EMPVALOR', vCdEmpresaValorSis);
    newinstance 'PRDSVCO007', 'PRDSVCO007A1', 'TRANSACTION=FALSE';
    voParams := activateCmp('PRDSVCO007', 'buscaValorData', viParams);
    if (xStatus < 0) then begin
      Result := voParams;
      return(-1); exit;
    end;
    deleteinstance 'PRDSVCO007A1';

    vVlValor := vVlValor + itemXmlF('VL_VALOR', voParams);

    delitem(vDsLstEmpresa, 1);
  until(vDsLstEmpresa = '');

  vVlMedio := 0;
  if (vNrCont > 0) then begin
    vVlMedio := vVlValor / vNrCont;
  end;

  Result := '';
  putitemXml(Result, 'VL_MEDIO', vVlMedio);

  return(0); exit;
end;

//--------------------------------------------------------------
function T_PRDSVCO007.arredondaPreco(pParams : String) : String;
//--------------------------------------------------------------
const
  cDS_METHOD = 'ADICONAL=Operação: T_PRDSVCO007.arredondaPreco()';
var
  (* string piGlobal :IN *)
  vVlPreco, vCdEmpresa, vVlArredondado : Real;
begin
  vCdEmpresa := itemXmlF('CD_EMPRESA', piGlobal);

  getParams(pParams); (* vCdEmpresa *)
  if (xStatus < 0) then begin
    return(-1); exit;
  end;

  vVlPreco := itemXmlF('VL_PRECO', pParams);

  if (vVlPreco > 0) then begin
    selectcase gTpArredondamento;
      case 00;
        vVlPreco := roundto(vVlPreco, 2);
      case 01;
        vVlPreco := roundto(vVlPreco, 1);
      case 02;
        vVlPreco := roundto(vVlPreco, 0);
      case 03;
        voParams := arredondaPrecoPontoM(viParams); (* vVlPreco, vVlArredondado *)
        if (xStatus < 0) then begin
          return(-1); exit;
        end;
        vVlPreco := vVlArredondado;
    endselectcase;
  end;

  Result := '';
  putitemXml(Result, 'VL_PRECO', vVlPreco);

  return(0); exit;
end;

end.
