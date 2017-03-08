unit cPRDSVCO006;

interface

(* COMPONENTES 
  ADMSVCO001 / GERSVCO031 / PRDSVCO006 / PRDSVCO007 / PRDSVCO008
  SICSVCO002 / 
*)        

uses
  Classes, SysUtils, Math, DB,
  cServiceUnf, cDataSetUnf;

type
  T_PRDSVCO006 = class(TcServiceUnf)
  private
    tGER_EMPRESA,
    tGER_OPERSALDO,
    tPRD_GRUPO,
    tPRD_KARDEX,
    tPRD_KARDEXVAL,
    tPRD_PRDGRADE,
    tPRD_PRDSALDO,
    tPRD_TIPOSALDO,
    tPRD_TPSALDOF,
    tSIS_PRDHIST,
    tV_PRD_LOTESAL,
    tV_PRD_SALDO : TcDatasetUnf;
    function getParam(pParams : String = '') : String;
    function setEntidade(pParams : String = '') : String;
  protected
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;    
  published
    function buscaValor(pParams : String = '') : String;
    function atualizaSaldo(pParams : String = '') : String;
    function buscaSaldoData(pParams : String = '') : String;
    function buscaSaldoAnteriorData(pParams : String = '') : String;
  end;

implementation

uses
  cADMSVCO001,
  cActivate, cStatus, cFuncao, cXml, dModulo;

var
  gDsLstValorKardex,
  gDsPiGlobal,
  gDtMovimento,
  gDtSistema : String;

//---------------------------------------------------------------
constructor T_PRDSVCO006.Create(AOwner: TComponent);
//---------------------------------------------------------------
begin
  inherited Create(AOwner);
  setEntidade('');
end;

//--------------------------------
destructor T_PRDSVCO006.Destroy;
//--------------------------------
begin
  inherited Destroy;
end;

//---------------------------------------------------------------
function T_PRDSVCO006.getParam(pParams : String = '') : String;
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
  putitem(xParamEmp, 'DS_LST_VLR_KARDEX');

  xParamEmp := T_ADMSVCO001.GetParamEmpresa(piCdEmpresa, xParamEmp);

  gDsLstValorKardex := itemXml('DS_LST_VLR_KARDEX', xParamEmp);
  poVlValor := itemXml('VL_VALOR', xParamEmp);

end;

//---------------------------------------------------------------
function T_PRDSVCO006.setEntidade(pParams : String = '') : String;
//---------------------------------------------------------------
begin
  tGER_EMPRESA := GetEntidade('GER_EMPRESA');
  tGER_OPERSALDO := GetEntidade('GER_OPERSALDO');
  tPRD_GRUPO := GetEntidade('PRD_GRUPO');
  tPRD_KARDEX := GetEntidade('PRD_KARDEX');
  tPRD_KARDEXVAL := GetEntidade('PRD_KARDEXVAL');
  tPRD_PRDGRADE := GetEntidade('PRD_PRDGRADE');
  tPRD_PRDSALDO := GetEntidade('PRD_PRDSALDO');
  tPRD_TIPOSALDO := GetEntidade('PRD_TIPOSALDO');
  tPRD_TPSALDOF := GetEntidade('PRD_TPSALDOF');
  tSIS_PRDHIST := GetEntidade('SIS_PRDHIST');
  tV_PRD_LOTESAL := GetEntidade('V_PRD_LOTESAL');
  tV_PRD_SALDO := GetEntidade('V_PRD_SALDO');
end;

//----------------------------------------------------------
function T_PRDSVCO006.buscaValor(pParams : String) : String;
//----------------------------------------------------------
const
  cDS_METHOD = 'ADICONAL=Operação: T_PRDSVCO006.buscaValor()';
var
  (* numeric piCdEmpresa : IN / numeric piCdProduto : IN / string piTpValor : IN / numeric piCdValor : IN / numeric poVlValor : OUT *)
  viParams, viListas, voParams, vCdEmpresa : String;
begin
  if (piCdValor = '') then begin
    poVlValor := '';
    return(0); exit;
  end;

  viParams := '';
  putitemXml(viParams, 'CD_EMPRESA', piCdEmpresa);
  putitemXml(viParams, 'CD_PRODUTO', piCdProduto);
  putitemXml(viParams, 'TP_VALOR', piTpValor);
  putitemXml(viParams, 'CD_VALOR', piCdValor);
  putitemXml(viParams, 'DT_VALOR', '');
  viListas := '';
  voParams := activateCmp('PRDSVCO007', 'buscaValorData', viParams);
  if (xStatus < 0) then begin
    Result := voParams;
    return(-1); exit;
  end;

  poVlValor := itemXmlF('VL_VALOR', voParams);

  return(0); exit;
end;

//-------------------------------------------------------------
function T_PRDSVCO006.atualizaSaldo(pParams : String) : String;
//-------------------------------------------------------------
const
  cDS_METHOD = 'ADICONAL=Operação: T_PRDSVCO006.atualizaSaldo()';
var
  (* string piGlobal :IN / string piValores :IN *)
  vCdHistorico, vCdEmpresa, vCdGrupoEmpresa, vCdProduto, vCdSaldo, vCdOperador, voParams : Real;
  vQtMovimento, vQtSaldoAnt, vNrSeq, vVlUnitLiquido, vVlUnitario, vQtSaldo, vVlProduto : Real;
  vCdValor, vCdValorPadrao, vTpDctoOrigem, vNrDctoOrigem, vNrItem, vInBloqNeg : Real;
  vTamParam, vDSPosInicio, vPosFim : Real;
  viParams, voParams, viListas, vTpValor, vTpValorPadrao, vTpMvto, vCdComponente : String;
  vDsValor, vDsListaValores : String;
  vInEstorno, vInProdAcabado, vInMatPrima, vInRetroativo, vInMovimentoZerado : Boolean;
  vDtSistema, vDtMovimento, vDtSaldoAnt, vDtDctoOrigem : TDate;
begin
  gDsPiGlobal := piGlobal;

  vCdHistorico := itemXmlF('CD_HISTORICO', pParams);
  vCdEmpresa := itemXmlF('CD_EMPRESA', pParams);
  vCdOperador := itemXmlF('CD_USUARIO', piGlobal);
  vCdProduto := itemXmlF('CD_PRODUTO', pParams);
  vNrItem := itemXmlF('NR_ITEM', pParams);
  vCdSaldo := itemXmlF('CD_SALDO', pParams);
  vQtMovimento := itemXmlF('QT_MOVIMENTO', pParams);
  vTpDctoOrigem := itemXmlF('TP_DCTOORIGEM', pParams);
  vNrDctoOrigem := itemXmlF('NR_DCTOORIGEM', pParams);
  vDtDctoOrigem := itemXml('DT_DCTOORIGEM', pParams);
  vInEstorno := itemXmlB('IN_ESTORNO', pParams);
  vTpValorPadrao := itemXmlF('TP_VALOR', pParams);
  vCdValorPadrao := itemXmlF('CD_VALOR', pParams);
  vVlUnitLiquido := itemXmlF('VL_UNITLIQUIDO', pParams);
  vDtSistema := itemXml('DT_SISTEMA', piGlobal);
  vDtMovimento := itemXml('DT_MOVIMENTO', pParams);
  vInRetroativo := itemXmlB('IN_RETROATIVO', pParams);
  vInMovimentoZerado := itemXmlB('IN_MOVIMENTOZERADO', pParams);

  if (vInRetroativo = '') then begin
    vInRetroativo := False;
  end;
  if (vDtMovimento < vDtSistema ) and (vDtMovimento > 0)  and (!vInRetroativo) then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Data de movimento menor que a data de sistema!', cDS_METHOD);
    return(-1); exit;
  end;
  if (vDtMovimento = '') then begin
    vDtMovimento := vDtSistema;
  end;
  vCdComponente := itemXmlF('CD_COMPONENTE', pParams);
  vInBloqNeg := itemXmlB('IN_BLOQ_SALDO_NEG', piGlobal);

  if (vCdEmpresa = 0) then begin
    voParams := SetErroApl(viParams); (* 'ERRO=-1;
    return(-1); exit;
  end;
  if (vCdProduto = 0) then begin
    voParams := SetErroApl(viParams); (* 'ERRO=-1;
    return(-1); exit;
  end;
  if (vCdSaldo = 0) then begin
    voParams := SetErroApl(viParams); (* 'ERRO=-1;
    return(-1); exit;
  end;

  clear_e(tPRD_TPSALDOF);
  putitem_e(tPRD_TPSALDOF, 'CD_SALDO', vCdSaldo);
  retrieve_e(tPRD_TPSALDOF);
  if (xStatus >= 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Saldo ' + FloatToStr(vCdSaldo) + ' consolidado. Não permitido movimentar!', cDS_METHOD);
    return(-1); exit;
  end;
  if (vQtMovimento = 0) then begin
    voParams := SetErroApl(viParams); (* 'ERRO=-1;
    return(-1); exit;
  end;

  voParams := gabs(vQtMovimento);
  if (voParams > 99999999.999) then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Quantidade não pode ser superior a 99.999.999, 999!', cDS_METHOD);
    return(-1); exit;
  end;
  if (vCdHistorico = 0) then begin
    voParams := SetErroApl(viParams); (* 'ERRO=-1;
    return(-1); exit;
  end;

  getParams(pParams); (* vCdEmpresa *)
  if (xStatus < 0) then begin
    voParams := SetErroApl(viParams); (* 'ERRO=-1;
    return(-1); exit;
  end;
  if (vDtMovimento > vDtSistema) then begin
    gDtMovimento := vDtMovimento;
    gDtSistema := vDtSistema;
    voParams := SetErroApl(viParams); (* 'ERRO=-1;
    return(-1); exit;
  end;
  if (vQtMovimento < 0) then begin
    vQtMovimento := vQtMovimento * -1;
  end;
  if (itemXml('CD_GRUPOEMPRESA', pParams) = '') then begin
    clear_e(tGER_EMPRESA);
    putitem_e(tGER_EMPRESA, 'CD_EMPRESA', vCdEmpresa);
    retrieve_e(tGER_EMPRESA);
    if (xStatus >= 0) then begin
      vCdGrupoEmpresa := item_f('CD_GRUPOEMPRESA', tGER_EMPRESA);
    end else begin
      vCdGrupoEmpresa := itemXmlF('CD_GRUPOEMPRESA', piGlobal);
    end;
  end else begin
    vCdGrupoEmpresa := itemXmlF('CD_GRUPOEMPRESA', pParams);
  end;

  clear_e(tSIS_PRDHIST);
  putitem_e(tSIS_PRDHIST, 'CD_HISTORICO', vCdHistorico);
  retrieve_o(tSIS_PRDHIST);
  if (xStatus = -7) then begin
    retrieve_x(tSIS_PRDHIST);
    vTpMvto := item_f('TP_OPERACAO', tSIS_PRDHIST);
  end else begin
    voParams := SetErroApl(viParams); (* 'ERRO=-1;
    return(-1); exit;
  end;
  if (vTpMvto = '') then begin
    voParams := SetErroApl(viParams); (* 'ERRO=-1;
    return(-1); exit;
  end;
  if (vTpMvto = 'N') then begin
    return(0); exit;
  end;

  viParams := '';

  putitemXml(viParams, 'NM_ENTIDADE', 'PRD_KARDEX');
  voParams := activateCmp('GERSVCO031', 'getNumSeq', viParams);
  if (xStatus < 0) then begin
    Result := voParams;
    return(-1); exit;
  end;

  vNrSeq := itemXmlF('NR_SEQUENCIA', voParams);

  if (vInEstorno = True) then begin
    if (vTpMvto = 'E') then begin
      vQtMovimento := vQtMovimento * -1;
    end;
  end else begin
    if (vTpMvto = 'S') then begin
      vQtMovimento := vQtMovimento * -1;
    end;
  end;
  if (vInBloqNeg > 0)  and (vInMovimentoZerado <> True) then begin
    if (vTpDctoOrigem = 3) then begin
    end else if (vInEstorno = True ) and (vTpMvto = 'E')  or (vTpDctoOrigem <> 1 ) and (vTpDctoOrigem <> 2 ) and (vTpMvto = 'S') then begin
      if (vInBloqNeg = 2 ) or (vInBloqNeg = 3) then begin
        viParams := '';
        putitemXml(viParams, 'CD_PRODUTO', vCdProduto);
        voParams := activateCmp('PRDSVCO008', 'buscaDadosFilial', viParams);
        if (xStatus < 0) then begin
          Result := voParams;
          return(-1); exit;
        end;
        vInProdAcabado := itemXmlB('IN_PRODACABADO', voParams);
        vInMatPrima := itemXmlB('IN_MATPRIMA', voParams);
      end;
      if ((vInBloqNeg = 1)  or (vInBloqNeg = 2 ) and (vInProdAcabado = True)  or (vInBloqNeg = 3 ) and (vInMatPrima = True)) then begin
        viParams := '';
        viListas := '';
        putitemXml(viParams, 'CD_PRODUTO', vCdProduto);
        putitemXml(viParams, 'CD_SALDO', vCdSaldo);
        putitemXml(viParams, 'CD_GRUPOEMPRESA', vCdGrupoEmpresa);
        putitemXml(viParams, 'IN_VALIDALOCAL', False);
        voParams := activateCmp('PRDSVCO006', 'buscaSaldoData', viParams);
        if (xStatus < 0) then begin
          Result := voParams;
          return(-1); exit;
        end;

        vQtSaldo := itemXmlF('QT_SALDO', voParams);
        vQtSaldo := vQtSaldo + vQtMovimento;

        if (vQtSaldo < 0) then begin
          vQtSaldo := itemXmlF('QT_SALDO', voParams);
          vQtMovimento := vQtMovimento * -1;

          Result := SetStatus(STS_ERROR, 'GEN0001', 'Quantidade de saída: ' + vQtMovimento + ' do produto: ' + FloatToStr(vCdProduto) + ' não pode ser maior que a quantidade do estoque: ' + vQtSaldo + '!', cDS_METHOD);
          return(-1); exit;
        end;
      end;
    end;
  end;

  clear_e(tPRD_KARDEX);
  putitem_e(tPRD_KARDEX, 'CD_EMPRESA', vCdEmpresa);
  putitem_e(tPRD_KARDEX, 'CD_PRODUTO', vCdProduto);
  putitem_e(tPRD_KARDEX, 'NR_ITEM', vNrItem);
  putitem_e(tPRD_KARDEX, 'CD_SALDO', vCdSaldo);
  putitem_e(tPRD_KARDEX, 'DT_MOVIMENTO', vDtMovimento);
  putitem_e(tPRD_KARDEX, 'NR_SEQUENCIA', vNrSeq);
  putitem_e(tPRD_KARDEX, 'CD_GRUPOEMPRESA', vCdGrupoEmpresa);
  putitem_e(tPRD_KARDEX, 'CD_HISTORICO', vCdHistorico);
  putitem_e(tPRD_KARDEX, 'IN_ESTORNO', vInEstorno);
  putitem_e(tPRD_KARDEX, 'TP_DCTOORIGEM', vTpDctoOrigem);
  putitem_e(tPRD_KARDEX, 'NR_DCTOORIGEM', vNrDctoOrigem);
  putitem_e(tPRD_KARDEX, 'DT_DCTOORIGEM', vDtDctoOrigem);

  if (vInMovimentoZerado = True) then begin
    putitem_e(tPRD_KARDEX, 'QT_MOVIMENTADA', 0);
  end else begin

    putitem_e(tPRD_KARDEX, 'QT_MOVIMENTADA', vQtMovimento);
  end;

  putitem_e(tPRD_KARDEX, 'CD_COMPONENTE', vCdComponente);
  putitem_e(tPRD_KARDEX, 'CD_OPERADOR', vCdOperador);
  putitem_e(tPRD_KARDEX, 'DT_CADASTRO', Now);
  if (vTpValorPadrao <> '' ) and (vCdValorPadrao <> '') then begin
    putitem_e(tPRD_KARDEX, 'TP_VALOR', vTpValorPadrao);
    putitem_e(tPRD_KARDEX, 'CD_VALOR', vCdValorPadrao);
    if (vVlUnitLiquido > 0) then begin
      putitem_e(tPRD_KARDEX, 'VL_UNITARIO', vVlUnitLiquido);
    end else begin
      voParams := buscaValor(viParams); (* vCdEmpresa, vCdProduto, vTpValorPadrao, vCdValorPadrao, vVlUnitario *)
      if (xStatus < 0) then begin
        Result := voParams;
        return(-1); exit;
      end;
      putitem_e(tPRD_KARDEX, 'VL_UNITARIO', vVlUnitario);
    end;
    creocc(tPRD_KARDEXVAL, -1);
    putitem_e(tPRD_KARDEXVAL, 'TP_VALOR', vTpValorPadrao);
    putitem_e(tPRD_KARDEXVAL, 'CD_VALOR', vCdValorPadrao);
    putitem_e(tPRD_KARDEXVAL, 'CD_GRUPOEMPRESA', vCdGrupoEmpresa);
    putitem_e(tPRD_KARDEXVAL, 'CD_OPERADOR', vCdOperador);
    putitem_e(tPRD_KARDEXVAL, 'DT_CADASTRO', Now);
    putitem_e(tPRD_KARDEXVAL, 'VL_VALOR', item_f('VL_UNITARIO', tPRD_KARDEX));
  end;

  vDsListaValores := piValores;
  if (vDsListaValores <> '') then begin
    repeat
      getitem(vDsValor, vDsListaValores, 1);
      vTpValor := itemXmlF('TP_VALOR', vDsValor);
      vCdValor := itemXmlF('CD_VALOR', vDsValor);
      vVlProduto := itemXmlF('VL_PRODUTO', vDsValor);
      if (vTpValor <> '' ) and (vCdValor <> '') then begin
        if (vTpValor = vTpValorPadrao ) and (vCdValor = vCdValorPadrao) then begin
        end else begin
          creocc(tPRD_KARDEXVAL, -1);
          putitem_e(tPRD_KARDEXVAL, 'TP_VALOR', vTpValor);
          putitem_e(tPRD_KARDEXVAL, 'CD_VALOR', vCdValor);
          retrieve_o(tPRD_KARDEXVAL);
          if (xStatus = -7) then begin
            retrieve_x(tPRD_KARDEXVAL);
          end;

          putitem_e(tPRD_KARDEXVAL, 'CD_GRUPOEMPRESA', vCdGrupoEmpresa);
          putitem_e(tPRD_KARDEXVAL, 'CD_OPERADOR', vCdOperador);
          putitem_e(tPRD_KARDEXVAL, 'DT_CADASTRO', Now);
          if (vVlProduto > 0) then begin
            vVlUnitario := vVlProduto;
          end else begin
            voParams := buscaValor(viParams); (* vCdEmpresa, vCdProduto, vTpValor, vCdValor, vVlUnitario *)
            if (xStatus < 0) then begin
              Result := voParams;
              return(-1); exit;
            end;
          end;
          putitem_e(tPRD_KARDEXVAL, 'VL_VALOR', vVlUnitario);
        end;
      end;
      delitem(vDsListaValores, 1);
    until (vDsListaValores = '');
  end;

  voParams := tPRD_KARDEX.Salvar();
  if (xStatus < 0) then begin
    Result := voParams;
    return(-1); exit;
  end;
  if (itemXml('TP_VALIDACAO_SALDO_LOTE', piGlobal) = 1) then begin
    if (itemXml('CD_OPER_ENT_INSPECAO', piGlobal) <> '') then begin
      clear_e(tGER_OPERSALDO);
      putitem_e(tGER_OPERSALDO, 'CD_OPERACAO', itemXmlF('CD_OPER_ENT_INSPECAO', piGlobal));
      putitem_e(tGER_OPERSALDO, 'IN_PADRAO', True);
      retrieve_e(tGER_OPERSALDO);
      if (xStatus >= 0) then begin
        if (vCdSaldo <> item_f('CD_SALDO', tGER_OPERSALDO)) then begin
          clear_e(tV_PRD_LOTESAL);
          putitem_e(tV_PRD_LOTESAL, 'CD_EMPRESA', vCdEmpresa);
          putitem_e(tV_PRD_LOTESAL, 'CD_PRODUTO', vCdProduto);
          putitem_e(tV_PRD_LOTESAL, 'CD_SALDO', vCdSaldo);
          retrieve_e(tV_PRD_LOTESAL);
          if (xStatus >= 0) then begin
            if (item_f('QT_LOTE', tV_PRD_LOTESAL) <> item_f('QT_SALDO', tV_PRD_LOTESAL)) then begin
              Result := SetStatus(STS_ERROR, 'GEN0001', 'O saldo ' + item_a('CD_SALDO', tV_PRD_LOTESAL) + ' do produto ' + item_a('CD_PRODUTO', tV_PRD_LOTESAL) + ' na empresa ' + item_a('CD_EMPRESA', tV_PRD_LOTESAL) + ' possui quantidade diferente entre estoque ' + item_a('QT_SALDO', tV_PRD_LOTESAL) + ' e quantidade em lote ' + item_a('QT_LOTE', tV_PRD_LOTESAL) + ' !', cDS_METHOD);
              return(-1); exit;
            end;
          end;
        end;
      end;
    end;
  end;

  return(0); exit;
end;

//--------------------------------------------------------------
function T_PRDSVCO006.buscaSaldoData(pParams : String) : String;
//--------------------------------------------------------------
const
  cDS_METHOD = 'ADICONAL=Operação: T_PRDSVCO006.buscaSaldoData()';
var
  (* string piGlobal :IN / string piListas :IN *)
  vCdGrupoEmpresa, vCdProduto, vCdSaldo, vQtSaldo, vCdSaldoF, vCdSeqGrupo : Real;
  vCdEmpresa, viParams, voParams, vDsLstProduto : String;
  vDtSaldo, vDtSaldoEstoque, vDtUltimoSaldo : TDate;
  vInValidaLocal, vInVerificaProdutoPadrao, vInSaldoConsolidado : Boolean;
  vCdSaldoConsolidado : String;
begin
  gDsPiGlobal := piGlobal;

  vQtSaldo := 0;
  vCdGrupoEmpresa := itemXmlF('CD_GRUPOEMPRESA', pParams);
  vCdEmpresa := piListas;
  vCdProduto := itemXmlF('CD_PRODUTO', pParams);
  vCdSeqGrupo := itemXmlF('CD_SEQGRUPO', pParams);
  vCdSaldo := itemXmlF('CD_SALDO', pParams);
  vDtSaldo := itemXml('DT_SALDO', pParams);
  vInValidaLocal := itemXmlB('IN_VALIDALOCAL', pParams);

  vInVerificaProdutoPadrao := itemXmlB('IN_VERIFICAPRODUTOPADRAO', pParams);
  if (vInValidaLocal = '') then begin
    vInValidaLocal := True;
  end;

  vInSaldoConsolidado := itemXmlB('IN_SALDOCONSOLIDADO', pParams);
  if (vInSaldoConsolidado = '') then begin
    vInSaldoConsolidado := False;
  end;
  if (vInSaldoConsolidado = True) then begin
    vCdSaldoConsolidado := '';
    clear_e(tPRD_TIPOSALDO);
    retrieve_e(tPRD_TIPOSALDO);
    if (xStatus >= 0) then begin
      setocc(tPRD_TIPOSALDO, 1);
      while (xStatus >= 0) do begin
        clear_e(tPRD_TPSALDOF);
        putitem_e(tPRD_TPSALDOF, 'CD_SALDO', item_f('CD_SALDO', tPRD_TIPOSALDO));
        retrieve_e(tPRD_TPSALDOF);
        if (xStatus >= 0) then begin
        end else begin
          putitem(vCdSaldoConsolidado,  item_f('CD_SALDO', tPRD_TIPOSALDO));
        end;
        setocc(tPRD_TIPOSALDO, curocc(tPRD_TIPOSALDO) + 1);
      end;
      vCdSaldo := vCdSaldoConsolidado;
    end;
  end;

  vDtUltimoSaldo := '';

  if (vCdEmpresa = '')  and (vCdGrupoEmpresa > 0) then begin
    clear_e(tGER_EMPRESA);
    putitem_e(tGER_EMPRESA, 'CD_GRUPOEMPRESA', vCdGrupoEmpresa);
    retrieve_e(tGER_EMPRESA);
    if (xStatus >= 0) then begin
      setocc(tGER_EMPRESA, -1);
      setocc(tGER_EMPRESA, 1);
      putlistitems vCdEmpresa, item_f('CD_EMPRESA', tGER_EMPRESA);
    end;
  end;
  if (vInValidaLocal = True) then begin
    viParams := '';
    putitemXml(viParams, 'CD_EMPRESA', vCdEmpresa);
    voParams := activateCmp('SICSVCO002', 'validaLocal', viParams);
    if (xStatus < 0) then begin
      Result := voParams;
      return(-1); exit;
    end;
    vCdEmpresa := itemXmlF('CD_EMPRESA', voParams);
  end;
  if (vCdEmpresa = '') then begin
    vCdEmpresa := itemXmlF('CD_EMPRESA', piGlobal);
  end;
  if (vCdProduto > 0)  and (vCdSeqGrupo > 0) then begin
    voParams := SetErroApl(viParams); (* 'ERRO=-1;
    return(-1); exit;
  end;

  vDsLstProduto := '';

  if (vCdSeqGrupo > 0) then begin
    clear_e(tPRD_PRDGRADE);
    putitem_e(tPRD_PRDGRADE, 'CD_SEQGRUPO', vCdSeqGrupo);
    retrieve_e(tPRD_PRDGRADE);
    if (xStatus >= 0) then begin
      setocc(tPRD_PRDGRADE, -1);
      setocc(tPRD_PRDGRADE, 1);
      putlistitems vDsLstProduto, item_f('CD_PRODUTO', tPRD_PRDGRADE);
    end;
  end else begin
    if (vInVerificaProdutoPadrao = True) then begin
      clear_e(tPRD_PRDGRADE);
      putitem_e(tPRD_PRDGRADE, 'CD_PRODUTO', vCdProduto);
      retrieve_e(tPRD_PRDGRADE);
      if (xStatus >= 0) then begin
        clear_e(tPRD_GRUPO);
        putitem_e(tPRD_GRUPO, 'CD_SEQ', item_f('CD_SEQGRUPO', tPRD_PRDGRADE));
        retrieve_e(tPRD_GRUPO);
        if (xStatus >= 0) then begin
          if (item_f('CD_PRODUTO', tPRD_GRUPO) > 0) then begin
            clear_e(tPRD_PRDGRADE);
            putitem_e(tPRD_PRDGRADE, 'CD_SEQGRUPO', item_f('CD_SEQ', tPRD_GRUPO));
            retrieve_e(tPRD_PRDGRADE);
            if (xStatus >= 0) then begin
              setocc(tPRD_PRDGRADE, -1);
              setocc(tPRD_PRDGRADE, 1);
              putlistitems vDsLstProduto, item_f('CD_PRODUTO', tPRD_PRDGRADE);
            end;
          end;
        end;
      end;
    end;
    if (vDsLstProduto = '') then begin
      putitem(vDsLstProduto,  vCdProduto);
    end;
  end;
  if (vDsLstProduto = '') then begin
    Result := '';
    return(0); exit;
  end;

  repeat
    getitem(vCdProduto, vDsLstProduto, 1);

    clear_e(tPRD_TPSALDOF);
    putitem_e(tPRD_TPSALDOF, 'CD_SALDO', vCdSaldo);
    retrieve_e(tPRD_TPSALDOF);
    if (xStatus >= 0) then begin
      setocc(tPRD_TPSALDOF, 1);
      while (xStatus >= 0) do begin
        clear_e(tGER_EMPRESA);
        putitem_e(tGER_EMPRESA, 'CD_EMPRESA', vCdEmpresa);
        retrieve_e(tGER_EMPRESA);
        if (xStatus >= 0) then begin
          setocc(tGER_EMPRESA, 1);
          while (xStatus >= 0) do begin
            if (vDtSaldo = '') then begin
              clear_e(tV_PRD_SALDO);
              putitem_e(tV_PRD_SALDO, 'CD_EMPRESA', item_f('CD_EMPRESA', tGER_EMPRESA));
              putitem_e(tV_PRD_SALDO, 'CD_PRODUTO', vCdProduto);
              putitem_e(tV_PRD_SALDO, 'CD_SALDO', item_f('CD_SALDOF', tPRD_TPSALDOF));
              retrieve_e(tV_PRD_SALDO);
              if (xStatus >= 0) then begin
                if (item_f('TP_OPERACAO', tPRD_TPSALDOF) = 0) then begin
                  vQtSaldo := vQtSaldo + item_f('QT_SALDO', tV_PRD_SALDO);
                end else begin
                  vQtSaldo := vQtSaldo - item_f('QT_SALDO', tV_PRD_SALDO);
                end;
                if (item_a('DT_SALDO', tV_PRD_SALDO) > vDtUltimoSaldo) then begin
                  vDtUltimoSaldo := item_a('DT_SALDO', tV_PRD_SALDO);
                end;
              end;
            end else begin
              vDtSaldoEstoque := '';
              select max(DT_SALDO) 
              FROM 'PRD_PRDSALDOSVC' 
              where (putitem_e(tPRD_PRDSALDO, 'CD_EMPRESA', item_f('CD_EMPRESA', tGER_EMPRESA) ) and (
              putitem_e(tPRD_PRDSALDO, 'CD_PRODUTO', vCdProduto ) and (
              putitem_e(tPRD_PRDSALDO, 'CD_SALDO', item_f('CD_SALDOF', tPRD_TPSALDOF) ) and (
              item_a('DT_SALDO', tPRD_PRDSALDO) <= vDtSaldo)
              to vDtSaldoEstoque;
              if (xStatus < 0) then begin
                voParams := SetErroOpr(viParams); (* xProcerrorcontext, xCdErro, xCtxErro *)
                return(-1); exit;
              end else begin
                if (vDtSaldoEstoque <> '') then begin
                  clear_e(tPRD_PRDSALDO);
                  putitem_e(tPRD_PRDSALDO, 'CD_EMPRESA', item_f('CD_EMPRESA', tGER_EMPRESA));
                  putitem_e(tPRD_PRDSALDO, 'CD_PRODUTO', vCdProduto);
                  putitem_e(tPRD_PRDSALDO, 'CD_SALDO', item_f('CD_SALDOF', tPRD_TPSALDOF));
                  putitem_e(tPRD_PRDSALDO, 'DT_SALDO', vDtSaldoEstoque);
                  retrieve_e(tPRD_PRDSALDO);
                  if (xStatus >= 0) then begin
                    if (item_f('TP_OPERACAO', tPRD_TPSALDOF) = 0) then begin
                        vQtSaldo := vQtSaldo + item_f('QT_SALDO', tPRD_PRDSALDO);
                    end else begin
                        vQtSaldo := vQtSaldo - item_f('QT_SALDO', tPRD_PRDSALDO);
                    end;
                    if (vDtSaldoEstoque > vDtUltimoSaldo) then begin
                        vDtUltimoSaldo := vDtSaldoEstoque;
                    end;
                  end;
                end;
              end;
            end;
            setocc(tGER_EMPRESA, curocc(tGER_EMPRESA) + 1);
          end;
        end;
        setocc(tPRD_TPSALDOF, curocc(tPRD_TPSALDOF) + 1);
      end;
    end else begin
      clear_e(tGER_EMPRESA);
      putitem_e(tGER_EMPRESA, 'CD_EMPRESA', vCdEmpresa);
      retrieve_e(tGER_EMPRESA);
      if (xStatus >= 0) then begin
        setocc(tGER_EMPRESA, 1);
        while (xStatus >= 0) do begin
          if (vDtSaldo = '') then begin
            clear_e(tV_PRD_SALDO);
            putitem_e(tV_PRD_SALDO, 'CD_EMPRESA', item_f('CD_EMPRESA', tGER_EMPRESA));
            putitem_e(tV_PRD_SALDO, 'CD_PRODUTO', vCdProduto);
            putitem_e(tV_PRD_SALDO, 'CD_SALDO', vCdSaldo);
            retrieve_e(tV_PRD_SALDO);
            if (xStatus >= 0) then begin
              if (vInSaldoConsolidado = True) then begin
                setocc(tV_PRD_SALDO, 1);
                while (xStatus >= 0) do begin
                  vQtSaldo := vQtSaldo + item_f('QT_SALDO', tV_PRD_SALDO);
                  if (item_a('DT_SALDO', tV_PRD_SALDO) > vDtUltimoSaldo) then begin
                    vDtUltimoSaldo := item_a('DT_SALDO', tV_PRD_SALDO);
                  end;
                  setocc(tV_PRD_SALDO, curocc(tV_PRD_SALDO) + 1);
                end;
              end else begin

                vQtSaldo := vQtSaldo + item_f('QT_SALDO', tV_PRD_SALDO);
                if (item_a('DT_SALDO', tV_PRD_SALDO) > vDtUltimoSaldo) then begin
                  vDtUltimoSaldo := item_a('DT_SALDO', tV_PRD_SALDO);
                end;
              end;
            end;
          end else begin
            vDtSaldoEstoque := '';
            select max(DT_SALDO) 
            FROM 'PRD_PRDSALDOSVC' 
            where (putitem_e(tPRD_PRDSALDO, 'CD_EMPRESA', item_f('CD_EMPRESA', tGER_EMPRESA) ) and (
            putitem_e(tPRD_PRDSALDO, 'CD_PRODUTO', vCdProduto ) and (
            putitem_e(tPRD_PRDSALDO, 'CD_SALDO', vCdSaldo ) and (
            item_a('DT_SALDO', tPRD_PRDSALDO) <= vDtSaldo)
            to vDtSaldoEstoque;
            if (xStatus < 0) then begin
              voParams := SetErroOpr(viParams); (* xProcerrorcontext, xCdErro, xCtxErro *)
              return(-1); exit;
            end else begin
              if (vDtSaldoEstoque <> '') then begin
                clear_e(tPRD_PRDSALDO);
                putitem_e(tPRD_PRDSALDO, 'CD_EMPRESA', item_f('CD_EMPRESA', tGER_EMPRESA));
                putitem_e(tPRD_PRDSALDO, 'CD_PRODUTO', vCdProduto);
                putitem_e(tPRD_PRDSALDO, 'CD_SALDO', vCdSaldo);
                putitem_e(tPRD_PRDSALDO, 'DT_SALDO', vDtSaldoEstoque);
                retrieve_e(tPRD_PRDSALDO);
                if (xStatus >= 0) then begin
                  if (vInSaldoConsolidado = True) then begin
                    setocc(tPRD_PRDSALDO, 1);
                    while (xStatus >= 0) do begin
                          vQtSaldo := vQtSaldo + item_f('QT_SALDO', tPRD_PRDSALDO);
                        if (vDtSaldoEstoque > vDtUltimoSaldo) then begin
                      vDtUltimoSaldo := vDtSaldoEstoque;
                        end;
                        setocc(tPRD_PRDSALDO, curocc(tPRD_PRDSALDO) + 1);
                    end;
                  end else begin

                    vQtSaldo := vQtSaldo + item_f('QT_SALDO', tPRD_PRDSALDO);
                    if (vDtSaldoEstoque > vDtUltimoSaldo) then begin
                      vDtUltimoSaldo := vDtSaldoEstoque;
                    end;
                  end;
                end;
              end;
            end;
          end;
          setocc(tGER_EMPRESA, curocc(tGER_EMPRESA) + 1);
        end;
      end;
    end;
    delitem(vDsLstProduto, 1);
  until (vDsLstProduto = '');

  Result := '';
  putitemXml(Result, 'QT_SALDO', vQtSaldo);
  putitemXml(Result, 'DT_SALDO', vDtUltimoSaldo);

  return(0); exit;
end;

//----------------------------------------------------------------------
function T_PRDSVCO006.buscaSaldoAnteriorData(pParams : String) : String;
//----------------------------------------------------------------------
const
  cDS_METHOD = 'ADICONAL=Operação: T_PRDSVCO006.buscaSaldoAnteriorData()';
var
  (* string piGlobal :IN / string piListas :IN *)
  vCdGrupoEmpresa, vCdProduto, vCdSaldo, vQtSaldo : Real;
  vCdEmpresa, viParams, voParams : String;
  vDtSaldo, vDtSaldoEstoque, vDtUltimoSaldo : TDate;
  vInValidaLocal : Boolean;
begin
  gDsPiGlobal := piGlobal;

  vQtSaldo := 0;
  vCdGrupoEmpresa := itemXmlF('CD_GRUPOEMPRESA', pParams);
  vCdEmpresa := piListas;
  vCdProduto := itemXmlF('CD_PRODUTO', pParams);
  vCdSaldo := itemXmlF('CD_SALDO', pParams);
  vDtSaldo := itemXml('DT_SALDO', pParams);
  vInValidaLocal := itemXmlB('IN_VALIDALOCAL', pParams);
  if (vInValidaLocal = '') then begin
    vInValidaLocal := True;
  end;
  if (vDtSaldo = '') then begin
    vDtSaldo := itemXml('DT_SISTEMA', piGlobal);
  end;

  vDtUltimoSaldo := '';

  if (vCdEmpresa = '')  and (vCdGrupoEmpresa > 0) then begin
    clear_e(tGER_EMPRESA);
    putitem_e(tGER_EMPRESA, 'CD_GRUPOEMPRESA', vCdGrupoEmpresa);
    retrieve_e(tGER_EMPRESA);
    if (xStatus >= 0) then begin
      setocc(tGER_EMPRESA, -1);
      setocc(tGER_EMPRESA, 1);
      putlistitems vCdEmpresa, item_f('CD_EMPRESA', tGER_EMPRESA);
    end;
  end;
  if (vInValidaLocal = True) then begin
    viParams := '';
    putitemXml(viParams, 'CD_EMPRESA', vCdEmpresa);
    voParams := activateCmp('SICSVCO002', 'validaLocal', viParams);
    if (xStatus < 0) then begin
      Result := voParams;
      return(-1); exit;
    end;
    vCdEmpresa := itemXmlF('CD_EMPRESA', voParams);
  end;
  if (vCdEmpresa = '') then begin
    vCdEmpresa := itemXmlF('CD_EMPRESA', piGlobal);
  end;

  clear_e(tGER_EMPRESA);
  putitem_e(tGER_EMPRESA, 'CD_EMPRESA', vCdEmpresa);
  retrieve_e(tGER_EMPRESA);
  if (xStatus >= 0) then begin
    setocc(tGER_EMPRESA, 1);
    while (xStatus >= 0) do begin
      vDtSaldoEstoque := '';
      select max(DT_SALDO) 
      FROM 'PRD_PRDSALDOSVC' 
      where (putitem_e(tPRD_PRDSALDO, 'CD_EMPRESA', item_f('CD_EMPRESA', tGER_EMPRESA) ) and (
      putitem_e(tPRD_PRDSALDO, 'CD_PRODUTO', vCdProduto ) and (
      putitem_e(tPRD_PRDSALDO, 'CD_SALDO', vCdSaldo ) and (
      item_a('DT_SALDO', tPRD_PRDSALDO) < vDtSaldo)
      to vDtSaldoEstoque;
      if (xStatus < 0) then begin
        voParams := SetErroOpr(viParams); (* xProcerrorcontext, xCdErro, xCtxErro *)
        return(-1); exit;
      end else begin
        if (vDtSaldoEstoque <> '') then begin
          clear_e(tPRD_PRDSALDO);
          putitem_e(tPRD_PRDSALDO, 'CD_EMPRESA', item_f('CD_EMPRESA', tGER_EMPRESA));
          putitem_e(tPRD_PRDSALDO, 'CD_PRODUTO', vCdProduto);
          putitem_e(tPRD_PRDSALDO, 'CD_SALDO', vCdSaldo);
          putitem_e(tPRD_PRDSALDO, 'DT_SALDO', vDtSaldoEstoque);
          retrieve_e(tPRD_PRDSALDO);
          if (xStatus >= 0) then begin
            vQtSaldo := vQtSaldo + item_f('QT_SALDO', tPRD_PRDSALDO);
            if (vDtSaldoEstoque > vDtUltimoSaldo) then begin
              vDtUltimoSaldo := vDtSaldoEstoque;
            end;
          end;
        end;
      end;

      setocc(tGER_EMPRESA, curocc(tGER_EMPRESA) + 1);
    end;
  end;

  Result := '';
  putitemXml(Result, 'QT_SALDO', vQtSaldo);
  putitemXml(Result, 'DT_SALDO', vDtUltimoSaldo);

  return(0); exit;
end;


end.
