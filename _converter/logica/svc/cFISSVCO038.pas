unit cFISSVCO038;

interface

(* COMPONENTES 
  ADMSVCO001 / FISSVCO014 / GERSVCO008 / GERSVCO058 / PRDSVCO006
  PRDSVCO007 / PRDSVCO008 / PRDSVCO020 / PRDSVCO022 / SICSVCO005
  SICSVCO009 / 
*)        

uses
  Classes, SysUtils, DB,
  cServiceUnf, cDataSetUnf;

type
  T_FISSVCO038 = class(TcServiceUnf)
  private
    tF_TMP_NR09,
    tFIS_NF,
    tFIS_NFITEM,
    tFIS_NFITEMPLO,
    tFIS_NFITEMPRO,
    tFIS_NFITEMUN,
    tFIS_NFITEMVL,
    tGER_EMPRESA,
    tGER_OPERACAO,
    tGER_OPERSALDO,
    tPRD_LOTEI,
    tTMP_NR09,
    tTRA_ITEMLOTE : TcDatasetUnf;
    function getParam(pParams : String = '') : String;
    function setEntidade(pParams : String = '') : String;
  protected
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;    
  published
    function atualizaEstoqueNF(pParams : String = '') : String;
  end;

implementation

uses
  cADMSVCO001,
  cActivate, cStatus, cFuncao, cXml, dModulo;

var
  gCdCustoMedioSemImp,
  gCdCustoSemImp,
  gCdEmpresaValorEmp,
  gCdEmpresaValorSis,
  gCdMotivoAltValor,
  gCdOperEntEstTrans,
  gCdOperEntInspecao,
  gCdSaldoCalcVlrMedio,
  gCdSaldoEstDeTerc,
  gCdSaldoEstTerceiro,
  gCdSaldoPadrao,
  gDsCustoSubstTributaria,
  gDsCustoValorRetido,
  gDsLstOperEstDeTerc,
  gDsLstOperEstTerceiro,
  gInPDVOtimizado,
  gInRateioCustoOp,
  greplace(,
  gtinTinturaria,
  gTpSitLoteCTransf,
  gTpSitLoteITransf,
  gTpValidaCustoMedio : String;

//---------------------------------------------------------------
constructor T_FISSVCO038.Create(AOwner: TComponent);
//---------------------------------------------------------------
begin
  inherited Create(AOwner);
  setEntidade('');
end;

//--------------------------------
destructor T_FISSVCO038.Destroy;
//--------------------------------
begin
  inherited Destroy;
end;

//---------------------------------------------------------------
function T_FISSVCO038.getParam(pParams : String = '') : String;
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
  putitem(xParam, 'CD_EMPVALOR');
  putitem(xParam, 'CD_MOTIVO_ALTVALOR_CMP');

  xParam := T_ADMSVCO001.GetParametro(xParam);

  gCdEmpresaValorSis := itemXml('CD_EMPVALOR', xParam);
  gCdMotivoAltValor := itemXml('CD_MOTIVO_ALTVALOR_CMP', xParam);

  xParamEmp := '';
  putitem(xParamEmp, 'CD_CUSTO_MEDIO_S_IMPOSTO');
  putitem(xParamEmp, 'CD_CUSTO_S_IMPOSTO');
  putitem(xParamEmp, 'CD_EMPRESA_VALOR');
  putitem(xParamEmp, 'CD_EMPVALOR');
  putitem(xParamEmp, 'CD_MOTIVO_ALTVALOR_CMP');
  putitem(xParamEmp, 'CD_OPER_ENT_EST_TRANS');
  putitem(xParamEmp, 'CD_OPER_ENT_INSPECAO');
  putitem(xParamEmp, 'CD_SALDO_CALC_VLR_MEDIO');
  putitem(xParamEmp, 'CD_SALDO_EST_DE_TERC');
  putitem(xParamEmp, 'CD_SALDO_EST_TERCEIRO');
  putitem(xParamEmp, 'CD_SALDOPADRAO');
  putitem(xParamEmp, 'DS_CUSTO_SUBST_TRIBUTARIA');
  putitem(xParamEmp, 'DS_CUSTO_VALOR_RETIDO');
  putitem(xParamEmp, 'DS_LST_OPER_EST_DE_TERC');
  putitem(xParamEmp, 'DS_LST_OPER_EST_TERCEIRO');
  putitem(xParamEmp, 'IN_PDV_OTIMIZADO');
  putitem(xParamEmp, 'IN_RATEIO_CUSTO_OP');
  putitem(xParamEmp, 'TIN_TINTURARIA');
  putitem(xParamEmp, 'TP_SIT_LOTEC_DUP_TRANSF');
  putitem(xParamEmp, 'TP_SIT_LOTEI_DUP_TRANSF');
  putitem(xParamEmp, 'TP_VALIDA_CUSTO_MEDIO');

  xParamEmp := T_ADMSVCO001.GetParamEmpresa(piCdEmpresa, xParamEmp);

  gCdCustoMedioSemImp := itemXml('CD_CUSTO_MEDIO_S_IMPOSTO', xParamEmp);
  gCdCustoSemImp := itemXml('CD_CUSTO_S_IMPOSTO', xParamEmp);
  gCdEmpresaValorEmp := itemXml('CD_EMPRESA_VALOR', xParamEmp);
  gCdOperEntEstTrans := itemXml('CD_OPER_ENT_EST_TRANS', xParamEmp);
  gCdOperEntInspecao := itemXml('CD_OPER_ENT_INSPECAO', xParamEmp);
  gCdSaldoCalcVlrMedio := itemXml('CD_SALDO_CALC_VLR_MEDIO', xParamEmp);
  gCdSaldoEstDeTerc := itemXml('CD_SALDO_EST_DE_TERC', xParamEmp);
  gCdSaldoEstTerceiro := itemXml('CD_SALDO_EST_TERCEIRO', xParamEmp);
  gCdSaldoPadrao := itemXml('CD_SALDOPADRAO', xParamEmp);
  gDsCustoSubstTributaria := itemXml('DS_CUSTO_SUBST_TRIBUTARIA', xParamEmp);
  gDsCustoValorRetido := itemXml('DS_CUSTO_VALOR_RETIDO', xParamEmp);
  gDsLstOperEstDeTerc := itemXml('DS_LST_OPER_EST_DE_TERC', xParamEmp);
  gDsLstOperEstTerceiro := itemXml('DS_LST_OPER_EST_TERCEIRO', xParamEmp);
  gInPDVOtimizado := itemXml('IN_PDV_OTIMIZADO', xParamEmp);
  gInRateioCustoOp := itemXml('IN_RATEIO_CUSTO_OP', xParamEmp);
  gtinTinturaria := itemXml('TIN_TINTURARIA', xParamEmp);
  gTpSitLoteCTransf := itemXml('TP_SIT_LOTEC_DUP_TRANSF', xParamEmp);
  gTpSitLoteITransf := itemXml('TP_SIT_LOTEC_DUP_TRANSF', xParamEmp);
  gTpValidaCustoMedio := itemXml('TP_VALIDA_CUSTO_MEDIO', xParamEmp);

end;

//---------------------------------------------------------------
function T_FISSVCO038.setEntidade(pParams : String = '') : String;
//---------------------------------------------------------------
begin
  tF_TMP_NR09 := GetEntidade('F_TMP_NR09');
  tFIS_NF := GetEntidade('FIS_NF');
  tFIS_NFITEM := GetEntidade('FIS_NFITEM');
  tFIS_NFITEMPLO := GetEntidade('FIS_NFITEMPLO');
  tFIS_NFITEMPRO := GetEntidade('FIS_NFITEMPRO');
  tFIS_NFITEMUN := GetEntidade('FIS_NFITEMUN');
  tFIS_NFITEMVL := GetEntidade('FIS_NFITEMVL');
  tGER_EMPRESA := GetEntidade('GER_EMPRESA');
  tGER_OPERACAO := GetEntidade('GER_OPERACAO');
  tGER_OPERSALDO := GetEntidade('GER_OPERSALDO');
  tPRD_LOTEI := GetEntidade('PRD_LOTEI');
  tTMP_NR09 := GetEntidade('TMP_NR09');
  tTRA_ITEMLOTE := GetEntidade('TRA_ITEMLOTE');
end;

//-----------------------------------------------------------------
function T_FISSVCO038.atualizaEstoqueNF(pParams : String) : String;
//-----------------------------------------------------------------
const
  cDS_METHOD = 'ADICIONAL=Operação: T_FISSVCO038.atualizaEstoqueNF()';
var
  (* string viParams :IN *)
  viParams, voParams, viListas, vDsRegistro, vDsLstNF, vCdcomponente, vDsLstNFAux, vDsLstValor, vDsRegistroNF : String;
  vCdEmpresa, vNrFatura, vVlCalc, vVlUnitario, vVlIPI, vQtFaturado, vCdEmpresaBase, vCdOperacaoBase : Real;
  vVlProdutoAtu, vVlAtual, vQtSaldo, vQtProdutoAtu, vTpLote, vNrMesCorrente, vCdOperSaldo : Real;
  vNrMesNF, vNrAnoNF, vNrAnoCorrente, vTpInspecao, vCdCST, vQtProcessado, vTpContrInspSaldoLote : Real;
  vDtFatura, vDtNf, vDtCorrente, vDtSistema, vDtKardex : TDate;
  vInEstorno, vInTransferencia, vInValidaPool, vInEstoqueTerceiro, vInKardex, vInOperRec, vInMatriz : Boolean;
  vInEstoqueDeTerceiro, vInSoTerceiro, vInRemessaRetornoMP, vInProdAcabado, vInProdPropria, vInAchouLote : Boolean;
  vInSemInspecao, vInAchou, vInInspecao : Boolean;
begin
  vDsLstNF := itemXml('DS_LSTNF', viParams);
  vInEstorno := itemXmlB('IN_ESTORNO', viParams);
  vCdComponente := itemXmlF('CD_COMPONENTE', viParams);
  vCdEmpresaBase := itemXmlF('CD_EMPRESABASE', viParams);
  vCdOperacaoBase := itemXmlF('CD_OPERACAOBASE', viParams);
  vInTransferencia := itemXmlB('IN_TRANSFERENCIA', viParams);
  vInSoTerceiro := itemXmlB('IN_SOTERCEIRO', viParams);
  vDtSistema := itemXml('DT_SISTEMA', PARAM_GLB);
  vInSemInspecao := itemXmlB('IN_SEMINSPECAO', viParams);
  vTpContrInspSaldoLote := itemXmlF('TP_CONTR_INSP_SALDO_LOTE', PARAM_GLB);

  vDtKardex := itemXml('DT_KARDEX', viParams);

  if (vCdOperacaoBase > 0) then begin
    vInOperRec := True;
  end;
  if (vDsLstNF = '') then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Lista de NF não informada!', cDS_METHOD);
    return(-1); exit;
  end;

  getParams(pParams); (* 0 *)

  if (xStatus < 0) then begin
    return(-1); exit;
  end;

  clear_e(tTMP_NR09);
  if (gDsLstOperEstTerceiro <> '') then begin
    clear_e(tGER_OPERACAO);
    putitem_e(tGER_OPERACAO, 'CD_OPERACAO', gDsLstOperEstTerceiro);
    retrieve_e(tGER_OPERACAO);
    if (xStatus >= 0) then begin
      setocc(tGER_OPERACAO, 1);
      while (xStatus >= 0) do begin
        creocc(tTMP_NR09, -1);
        putitem_e(tTMP_NR09, 'NR_GERAL', item_f('CD_OPERACAO', tGER_OPERACAO));
        retrieve_o(tTMP_NR09);
        setocc(tGER_OPERACAO, curocc(tGER_OPERACAO) + 1);
      end;
    end;
  end;

  clear_e(tF_TMP_NR09);
  if (gDsLstOperEstDeTerc <> '') then begin
    clear_e(tGER_OPERACAO);
    putitem_e(tGER_OPERACAO, 'CD_OPERACAO', gDsLstOperEstDeTerc);
    retrieve_e(tGER_OPERACAO);
    if (xStatus >= 0) then begin
      setocc(tGER_OPERACAO, 1);
      while (xStatus >= 0) do begin
        creocc(tF_TMP_NR09, -1);
        putitem_e(tF_TMP_NR09, 'NR_GERAL', item_f('CD_OPERACAO', tGER_OPERACAO));
        retrieve_o(tF_TMP_NR09);
        setocc(tGER_OPERACAO, curocc(tGER_OPERACAO) + 1);
      end;
    end;
  end;

  repeat
    getitem(vDsRegistro, vDsLstNF, 1);
    vCdEmpresa := itemXmlF('CD_EMPRESA', vDsRegistro);
    vNrFatura := itemXmlF('NR_FATURA', vDsRegistro);
    vDtFatura := itemXml('DT_FATURA', vDsRegistro);

        vDsRegistroNF := vDsRegistro;

    if (vCdEmpresa = 0) then begin
      Result := SetStatus(STS_ERROR, 'GEN0001', 'Empresa não informada!', cDS_METHOD);
      return(-1); exit;
    end;
    if (vNrFatura = 0) then begin
      Result := SetStatus(STS_ERROR, 'GEN0001', 'Fatura não informado!', cDS_METHOD);
      return(-1); exit;
    end;
    if (vDtFatura = '') then begin
      Result := SetStatus(STS_ERROR, 'GEN0001', 'Data NF não informada!', cDS_METHOD);
      return(-1); exit;
    end;
    if (gInRateioCustoOp = True) then begin
      vNrMesNF := vDtFatura[M];
      vNrAnoNF := vDtFatura[Y];
      vNrMesCorrente := vDtSistema[M];
      vNrAnoCorrente := vDtSistema[Y];
      vDtNf := '01/' + FloatToStr(vNrMesNF) + '/' + FloatToStr(vNrAnoNF') + ';
      vDtCorrente := '01/' + FloatToStr(vNrMesCorrente) + '/' + FloatToStr(vNrAnoCorrente') + ';

      if (vDtNf <> vDtCorrente) then begin
        Result := SetStatus(STS_ERROR, 'GEN0001', 'Permitido atualizar estoque da NF apenas no mês corrente!Parâmetro empresa IN_RATEIO_CUSTO_OP configurado!', cDS_METHOD);
        return(-1); exit;
      end;
    end;

    clear_e(tFIS_NF);
    putitem_e(tFIS_NF, 'CD_EMPRESA', vCdEmpresa);
    putitem_e(tFIS_NF, 'NR_FATURA', vNrFatura);
    putitem_e(tFIS_NF, 'DT_FATURA', vDtFatura);
    retrieve_e(tFIS_NF);
    if (xStatus < 0) then begin
      Result := SetStatus(STS_ERROR, 'GEN0001', 'NF ' + FloatToStr(vNrFatura) + ' não cadastrada!', cDS_METHOD);
      return(-1); exit;
    end;

    viParams := '';
    putitemXml(viParams, 'CD_EMPRESA', item_f('CD_EMPFAT', tFIS_NF));
    voParams := activateCmp('SICSVCO009', 'validaCentroCusto', viParams); (*,,,, *)
    if (xStatus < 0) then begin
      Result := voParams;
      return(-1); exit;
    end;
    vInMatriz := itemXmlB('IN_MATRIZ', voParams);
    if (vInMatriz = '') then begin
      vInMatriz := True;
    end;

      vCdEmpresaBase := item_f('CD_EMPFAT', tFIS_NF);

    if (vCdOperacaoBase = 0 ) or (vInOperRec <> True) then begin
      vCdOperacaoBase := item_f('CD_OPERACAO', tFIS_NF);
    end;

    clear_e(tGER_OPERACAO);
    putitem_e(tGER_OPERACAO, 'CD_OPERACAO', vCdOperacaoBase);
    retrieve_e(tGER_OPERACAO);
    if (xStatus < 0) then begin
      Result := SetStatus(STS_ERROR, 'GEN0001', 'Operaçao ' + CD_OPERACAO + '.GER_OPERACAO não cadastrada!', cDS_METHOD);
      return(-1); exit;
    end else begin

      clear_e(tGER_OPERSALDO);
      putitem_e(tGER_OPERSALDO, 'CD_OPERACAO', item_f('CD_OPERACAO', tGER_OPERACAO));
      putitem_e(tGER_OPERSALDO, 'IN_PADRAO', True);
      retrieve_e(tGER_OPERSALDO);
      if (xStatus >= 0) then begin
        vCdOperSaldo := item_f('CD_SALDO', tGER_OPERSALDO);
      end;
      if (vInEstorno)  and (item_b('IN_KARDEX', tGER_OPERACAO) = True)  and (item_f('TP_OPERACAO', tGER_OPERACAO) = 'E') then begin
        viParams := '';
        putitemXml(viParams, 'CD_EMPRESA', item_f('CD_EMPRESA', tFIS_NF));
        putitemXml(viParams, 'NR_FATURA', item_f('NR_FATURA', tFIS_NF));
        putitemXml(viParams, 'DT_FATURA', item_a('DT_FATURA', tFIS_NF));
        voParams := activateCmp('FISSVCO014', 'validaInspecaoNF', viParams); (*,,,, *)
        if (xStatus < 0) then begin
          Result := voParams;
          return(-1); exit;
        end;
      end;
    end;

    vInEstoqueTerceiro := False;
    vInEstoqueDeTerceiro := False;

    if not (empty(tTMP_NR09)) then begin
      creocc(tTMP_NR09, -1);
      putitem_e(tTMP_NR09, 'NR_GERAL', item_f('CD_OPERACAO', tGER_OPERACAO));
      retrieve_o(tTMP_NR09);
      if (xStatus = 4) then begin
        vInEstoqueTerceiro := True;
      end else begin
        discard(tTMP_NR09);
      end;
    end;
    if (item_f('TP_MODALIDADE', tGER_OPERACAO) = 'F') then begin
      vInEstoqueTerceiro := True;
    end;
    if (vInEstoqueTerceiro = False) then begin
      if not (empty(tF_TMP_NR09)) then begin
        creocc(tF_TMP_NR09, -1);
        putitem_e(tF_TMP_NR09, 'NR_GERAL', item_f('CD_OPERACAO', tGER_OPERACAO));
        retrieve_o(tF_TMP_NR09);
        if (xStatus = 4) then begin
          vInEstoqueDeTerceiro := True;
        end else begin
          discard(tF_TMP_NR09);
        end;
      end;
    end;

    vDsLstValor := '';

    if (empty(tFIS_NFITEM) = False) then begin
      setocc(tFIS_NFITEM, -1);
      setocc(tFIS_NFITEM, 1);
      while (xStatus >=0) do begin

        voParams := setDisplay(viParams); (* 'Itens processados - ' + curocc(viParams); + ' (* 'FIS_NFITEMSVC')/' + totocc(viParams); + ' (* 'FIS_NFITEMSVC')', '', '' *)
        if (xStatus < 0) then begin
          Result := voParams;
          return(-1); exit;
        end;
        if (empty(tFIS_NFITEMPRO) = False) then begin
          setocc(tFIS_NFITEMPRO, 1);
          while (xStatus >=0) do begin
            vDsLstValor := '';

            if (item_b('IN_KARDEX', tGER_OPERACAO) = True) then begin
              if (empty(tFIS_NFITEMUN) = False)  and (item_f('QT_CONVERSAO', tFIS_NFITEMUN) <= 0) then begin
                Result := SetStatus(STS_ERROR, 'GEN0001', 'Produto ' + CD_PRODUTO + '.FIS_NFITEMPRO da NF ' + NR_FATURA + '.FIS_NFITEMPRO possui quantidade de conversão inválida!', cDS_METHOD);
                return(-1); exit;
              end;
            end;
            if (empty(tFIS_NFITEMVL) = False)  and (item_b('IN_KARDEX', tGER_OPERACAO) = True) then begin
              setocc(tFIS_NFITEMVL, 1);
              while (xStatus >=0) do begin
                vInAchou := False;

                if (item_f('TP_OPERACAO', tFIS_NF) = 'E')  or (item_f('TP_MODALIDADE', tGER_OPERACAO) = 3 ) and (item_f('TP_OPERACAO', tGER_OPERACAO) = 'S') then begin
                  if (item_f('TP_ATUALIZACAO', tFIS_NFITEMVL) = 1 ) or (item_f('TP_ATUALIZACAO', tFIS_NFITEMVL) = 2) then begin
                    viParams := '';
                    putitemXml(viParams, 'CD_EMPRESA', item_f('CD_EMPRESA', tFIS_NFITEMVL));
                    putitemXml(viParams, 'NR_FATURA', item_f('NR_FATURA', tFIS_NFITEMVL));
                    putitemXml(viParams, 'DT_FATURA', item_a('DT_FATURA', tFIS_NFITEMVL));
                    putitemXml(viParams, 'NR_ITEM', item_f('NR_ITEM', tFIS_NFITEMVL));
                    putitemXml(viParams, 'CD_PRODUTO', item_f('CD_PRODUTO', tFIS_NFITEMPRO));
                    putitemXml(viParams, 'TP_VALOR', item_f('TP_VALOR', tFIS_NFITEMVL));
                    putitemXml(viParams, 'CD_VALOR', item_f('CD_VALOR', tFIS_NFITEMVL));
                    putitemXml(viParams, 'VL_PRODUTOATU', vVlCalc);
                    putitemXml(viParams, 'CD_MOTIVO', gCdMotivoAltValor);
                    putitemXml(viParams, 'CD_CUSTO_S_IMPOSTO', gCdCustoSemImp);
                    putitemXml(viParams, 'CD_CUSTO_MEDIO_S_IMPOSTO', gCdCustoMedioSemImp);
                    putitemXml(viParams, 'IN_PDV_OTIMIZADO', gInPDVOtimizado);
                    putitemXml(viParams, 'DS_CUSTO_SUBST_TRIBUTARIA', gDsCustoSubstTributaria);
                    putitemXml(viParams, 'DS_CUSTO_VALOR_RETIDO', gDsCustoValorRetido);

                    voParams := activateCmp('SICSVCO005', 'arredondaCusto', viParams); (*,,,, *)
                    if (xStatus < 0) then begin
                      Result := voParams;
                      return(-1); exit;
                    end;
                    vVlUnitario := itemXmlF('VL_UNITARIO', voParams);
                    vVlIPI := itemXmlF('VL_IPI', voParams);
                    vQtFaturado := itemXmlF('QT_FATURADO', voParams);

                    vVlCalc := vVlUnitario - (vVlUnitario * item_f('PR_DESCONTO', tFIS_NFITEMVL) / 100);
                    vVlCalc := rounded(vVlCalc, 6);
                    vVlCalc := vVlCalc - (vVlCalc * item_f('PR_DESCONTOCAB', tFIS_NFITEMVL) / 100);
                    vVlCalc := rounded(vVlCalc, 6);

                    vCdCST := item_f('CD_CST', tFIS_NFITEM)[1 : 1];
                    if (vCdCST = 1) then begin
                      vVlProdutoAtu := vVlCalc;
                    end else begin
                      vVlProdutoAtu := vVlCalc + vVlIPI;
                    end;
                    if (item_f('TP_ATUALIZACAO', tFIS_NFITEMVL) = 2) then begin
                      viParams := '';
                      putitemXml(viParams, 'CD_EMPRESA', vCdEmpresaBase);
                      putitemXml(viParams, 'CD_PRODUTO', item_f('CD_PRODUTO', tFIS_NFITEMPRO));
                      putitemXml(viParams, 'TP_VALOR', item_f('TP_VALOR', tFIS_NFITEMVL));
                      putitemXml(viParams, 'CD_VALOR', item_f('CD_VALOR', tFIS_NFITEMVL));
                      putitemXml(viParams, 'CD_EMPRESA_VALOR', gCdEmpresaValorEmp);
                      putitemXml(viParams, 'CD_EMPVALOR', gCdEmpresaValorSis);
                      putitemXml(viParams, 'IN_SOEMPRESA', True);
                      viListas := '';
                      voParams := activateCmp('PRDSVCO007', 'buscaValorData', viParams); (*,,viListas,,, *)
                      if (xStatus < 0) then begin
                        Result := voParams;
                        return(-1); exit;
                      end;

                      vVlAtual := itemXmlF('VL_VALOR', voParams);
                      viParams := '';
                      putitemXml(viParams, 'CD_GRUPOEMPRESA', item_f('CD_GRUPOEMPRESA', tFIS_NFITEMPRO));
                      putitemXml(viParams, 'CD_PRODUTO', item_f('CD_PRODUTO', tFIS_NFITEMPRO));
                      if (gCdSaldoCalcVlrMedio > 0) then begin
                        putitemXml(viParams, 'CD_SALDO', gCdSaldoCalcVlrMedio);
                      end else begin

                        putitemXml(viParams, 'IN_SALDOCONSOLIDADO', True);

                      end;
                      putitemXml(viParams, 'IN_VERIFICAPRODUTOPADRAO', True);
                      viListas := '';
                      voParams := activateCmp('PRDSVCO006', 'buscaSaldoData', viParams); (*,,viListas,,, *)
                      if (xStatus < 0) then begin
                        Result := voParams;
                        return(-1); exit;
                      end;
                      vQtSaldo := itemXmlF('QT_SALDO', voParams);

                      if (gTpValidaCustoMedio = 1)  and (vQtSaldo <> 0)  and (vVlAtual = 0) then begin
                        Result := SetStatus(STS_ERROR, 'GEN0001', 'PRODUTO ' + CD_PRODUTO + '.FIS_NFITEMPRO com saldo em estoque e sem custo médio ' + CD_VALOR + '.FIS_NFITEMVL!', cDS_METHOD);
                        exit(-5);
                      end;
                      if (empty(tFIS_NFITEMUN) = False) then begin
                        if (item_f('TP_OPERACAO', tFIS_NFITEMUN) = 'M') then begin
                          vVlProdutoAtu := vVlProdutoAtu / item_f('QT_CONVERSAO', tFIS_NFITEMUN);
                          vQtFaturado := vQtFaturado * item_f('QT_CONVERSAO', tFIS_NFITEMUN);
                          vQtFaturado := rounded(vQtFaturado, 3);
                        end else begin
                          vVlProdutoAtu := vVlProdutoAtu * item_f('QT_CONVERSAO', tFIS_NFITEMUN);
                          vQtFaturado := vQtFaturado / item_f('QT_CONVERSAO', tFIS_NFITEMUN);
                          vQtFaturado := rounded(vQtFaturado, 3);
                        end;
                      end;
                      if (vInMatriz = False) then begin
                        vQtSaldo := vQtSaldo - vQtFaturado;
                      end;
                      if (vQtSaldo < 0) then begin
                        vQtSaldo := 0;
                      end;
                      if (vInEstorno = True  and (item_f('TP_OPERACAO', tFIS_NF) = 'E'))  or (item_f('TP_OPERACAO', tFIS_NF) = 'S') then begin
                        if ((vQtSaldo - vQtFaturado) = 0) then begin
                          vVlCalc := 0;
                        end else begin
                          vVlCalc := ((vQtSaldo * vVlAtual) - (vVlProdutoAtu * vQtFaturado)) / (vQtSaldo - vQtFaturado);
                        end;
                      end else begin
                        vVlCalc := ((vVlProdutoAtu * vQtFaturado) + (vQtSaldo * vVlAtual)) / (vQtFaturado + vQtSaldo);
                      end;
                      vVlProdutoAtu := rounded(vVlCalc, 6);
                    end else begin
                      if (empty(tFIS_NFITEMUN) = False) then begin
                        if (item_f('TP_OPERACAO', tFIS_NFITEMUN) = 'M') then begin
                          vVlProdutoAtu := vVlProdutoAtu / item_f('QT_CONVERSAO', tFIS_NFITEMUN);
                        end else begin
                          vVlProdutoAtu := vVlProdutoAtu * item_f('QT_CONVERSAO', tFIS_NFITEMUN);
                        end;
                      end;
                    end;
                    if (item_f('TP_ATUALIZACAO', tFIS_NFITEMVL) = 1)  and ((vInEstorno = True  and (item_f('TP_OPERACAO', tFIS_NF) = 'E'))  or (item_f('TP_OPERACAO', tFIS_NF) = 'S')) then begin
                    end else begin
                      viParams := '';
                      putitemXml(viParams, 'CD_EMPRESA', vCdEmpresaBase);
                      putitemXml(viParams, 'CD_PRODUTO', item_f('CD_PRODUTO', tFIS_NFITEMPRO));
                      putitemXml(viParams, 'TP_VALOR', item_f('TP_VALOR', tFIS_NFITEMVL));
                      putitemXml(viParams, 'CD_VALOR', item_f('CD_VALOR', tFIS_NFITEMVL));
                      putitemXml(viParams, 'VL_PRODUTOATU', vVlProdutoAtu);
                      putitemXml(viParams, 'CD_MOTIVO', gCdMotivoAltValor);
                      voParams := activateCmp('PRDSVCO007', 'atualizaValor', viParams); (*,,,, *)
                      if (xStatus < 0) then begin
                        Result := voParams;
                        return(-1); exit;
                      end;

                      vDsRegistro := '';
                      putitemXml(vDsRegistro, 'TP_VALOR', item_f('TP_VALOR', tFIS_NFITEMVL));
                      putitemXml(vDsRegistro, 'CD_VALOR', item_f('CD_VALOR', tFIS_NFITEMVL));
                      putitemXml(vDsRegistro, 'VL_PRODUTO', vVlProdutoAtu);
                      putitem(vDsLstValor,  vDsRegistro);
                      vInAchou := True;
                    end;
                  end;
                end;
                if (vInAchou = False) then begin
                    vDsRegistro := '';
                    putitemXml(vDsRegistro, 'TP_VALOR', item_f('TP_VALOR', tFIS_NFITEMVL));
                    putitemXml(vDsRegistro, 'CD_VALOR', item_f('CD_VALOR', tFIS_NFITEMVL));
                    putitemXml(vDsRegistro, 'VL_PRODUTO', item_f('VL_UNITARIO', tFIS_NFITEMVL));
                    putitem(vDsLstValor,  vDsRegistro);
                end;

                setocc(tFIS_NFITEMVL, curocc(tFIS_NFITEMVL) + 1);
              end;
            end;
            if (empty(tFIS_NFITEMUN) = False) then begin
              if (item_f('TP_OPERACAO', tFIS_NFITEMUN) = 'M') then begin
                vQtProdutoAtu := item_f('QT_FATURADO', tFIS_NFITEMPRO) * item_f('QT_CONVERSAO', tFIS_NFITEMUN);
                vVlProdutoAtu := item_f('VL_UNITLIQUIDO', tFIS_NFITEMPRO) / item_f('QT_CONVERSAO', tFIS_NFITEMUN);
              end else begin
                vQtProdutoAtu := item_f('QT_FATURADO', tFIS_NFITEMPRO) / item_f('QT_CONVERSAO', tFIS_NFITEMUN);
                vVlProdutoAtu := item_f('VL_UNITLIQUIDO', tFIS_NFITEMPRO) * item_f('QT_CONVERSAO', tFIS_NFITEMUN);
              end;
            end else begin
              vQtProdutoAtu := item_f('QT_FATURADO', tFIS_NFITEMPRO);
              vVlProdutoAtu := item_f('VL_UNITLIQUIDO', tFIS_NFITEMPRO);
            end;

            viParams := '';
            putitemXml(viParams, 'CD_EMPRESA', vCdEmpresaBase);
            putitemXml(viParams, 'CD_PRODUTO', item_f('CD_PRODUTO', tFIS_NFITEMPRO));
            voParams := activateCmp('PRDSVCO008', 'buscaDadosFilial', viParams); (*,,,, *)
            if (xStatus < 0) then begin
              Result := voParams;
              return(-1); exit;
            end;
            vTpLote := itemXmlF('TP_LOTE', voParams);
            vTpInspecao := itemXmlF('TP_INSPECAO', voParams);

            vInProdAcabado := itemXmlB('IN_PRODACABADO', voParams);
            vInProdPropria := itemXmlB('IN_PRODPROPRIA', voParams);

            if (vTpContrInspSaldoLote = 1)  and (gCdOperEntInspecao = 0)  and (vTpLote > 0) then begin
              Result := SetStatus(STS_ERROR, 'GEN0001', 'Nenhuma operação informada no parametro CD_OPER_ENT_INSPECAO. Verifique!', cDS_METHOD);
              return(-1); exit;
            end;
            if (vInProdAcabado = True)  and (vInProdPropria = True) then begin
            end else begin
              if (gCdCustoMedioSemImp > 0)  and (gTpValidaCustoMedio = 1) then begin
                clear_e(tFIS_NFITEMVL);
                putitem_e(tFIS_NFITEMVL, 'TP_VALOR', 'C');
                putitem_e(tFIS_NFITEMVL, 'CD_VALOR', gCdCustoMedioSemImp);
                retrieve_e(tFIS_NFITEMVL);
                if (xStatus >= 0) then begin
                  if (item_f('VL_UNITARIO', tFIS_NFITEMVL) = 0) then begin
                    Result := SetStatus(STS_ERROR, 'GEN0001', 'Produto ' + CD_PRODUTO + '.FIS_NFITEMPRO da NF ' + CD_EMPFAT + '.FIS_NFITEMPRO / ' + NR_FATURA + '.FIS_NFITEMPRO / ' + DT_FATURA + '.FIS_NFITEMPRO possui valor de custo médio sem imposto(CD_CUSTO_MEDIO_S_IMPOSTO) zerado!', cDS_METHOD);
                    return(-1); exit;
                  end;
                end;
                clear_e(tFIS_NFITEMVL);
                retrieve_e(tFIS_NFITEMVL);
              end;
            end;

            viParams := '';
            putitemXml(viParams, 'CD_EMPRESA', item_f('CD_EMPRESA', tFIS_NFITEMPRO));
            putitemXml(viParams, 'NR_FATURA', item_f('NR_FATURA', tFIS_NFITEMPRO));
            putitemXml(viParams, 'DT_FATURA', item_a('DT_FATURA', tFIS_NFITEMPRO));
            putitemXml(viParams, 'NR_ITEM', item_f('NR_ITEM', tFIS_NFITEMPRO));
            voParams := activateCmp('GERSVCO058', 'buscaDadosGerOperCfopNf', viParams); (*,,,, *)
            if (xStatus < 0) then begin
              Result := voParams;
              return(-1); exit;
            end;
            vInKardex := itemXmlB('IN_KARDEX', voParams);

            if (vInKardex = False) then begin
            end else begin
              if (vInSoTerceiro <> True) then begin
                vInInspecao := False;

                if (vInSemInspecao)  or (empty('BAL_BALANCOTRSVC') = 0) then begin
                end else begin
                  if (vTpContrInspSaldoLote = 1) then begin
                    if (vTpLote > 0)  and (item_f('TP_OPERACAO', tFIS_NF) = 'E') then begin
                      vInInspecao := True;
                    end;
                  end else begin
                    if (vTpLote > 0)  and (vTpInspecao > 0)  and (gCdOperEntInspecao <> '')  and (item_f('TP_OPERACAO', tFIS_NF) = 'E') then begin
                      if (gtinTinturaria = 1 ) and (item_f('TP_MODALIDADE', tGER_OPERACAO) = 3) then begin
                        vInInspecao := False;

                      end else begin
                        vInInspecao := True;
                      end;
                    end;
                    if (vInInspecao = True) then begin
                      vInAchouLote := False;
                      clear_e(tTRA_ITEMLOTE);
                      putitem_e(tTRA_ITEMLOTE, 'CD_EMPRESA', item_f('CD_EMPRESAORI', tFIS_NF));
                      putitem_e(tTRA_ITEMLOTE, 'NR_TRANSACAO', item_f('NR_TRANSACAOORI', tFIS_NF));
                      putitem_e(tTRA_ITEMLOTE, 'DT_TRANSACAO', item_a('DT_TRANSACAOORI', tFIS_NF));
                      retrieve_e(tTRA_ITEMLOTE);
                      if (xStatus >= 0) then begin
                        setocc(tTRA_ITEMLOTE, 1);
                          while(xStatus >= 0) do begin
                          clear_e(tPRD_LOTEI);
                          putitem_e(tPRD_LOTEI, 'CD_EMPRESA', item_f('CD_EMPLOTE', tTRA_ITEMLOTE));
                          putitem_e(tPRD_LOTEI, 'NR_LOTE', item_f('NR_LOTE', tTRA_ITEMLOTE));
                          putitem_e(tPRD_LOTEI, 'CD_PRODUTO', item_f('CD_PRODUTO', tFIS_NFITEMPRO));
                          retrieve_e(tPRD_LOTEI);
                          if (xStatus >= 0) then begin
                            vInAchouLote := True;
                            break;
                          end;
                          setocc(tTRA_ITEMLOTE, curocc(tTRA_ITEMLOTE) + 1);
                        end;
                      end;
                      if (vInAchouLote) then begin
                        vInInspecao := False;
                      end;
                    end;
                  end;
                end;
                if (vQtProcessado % 50 = 0) then begin
                  deleteinstance 'GERSVCO008I';
                  newinstance 'GERSVCO008', 'GERSVCO008I', 'TRANSACTION=FALSE';
                end;

                viParams := '';
                putitemXml(viParams, 'CD_EMPRESA', vCdEmpresaBase);
                putitemXml(viParams, 'CD_PRODUTO', item_f('CD_PRODUTO', tFIS_NFITEMPRO));
                putitemXml(viParams, 'NR_ITEM', item_f('NR_ITEM', tFIS_NFITEMPRO));
                putitemXml(viParams, 'IN_ESTORNO', vInEstorno);
                if (vInInspecao)  and (item_b('IN_KARDEX', tGER_OPERACAO) = True) then begin
                  putitemXml(viParams, 'CD_OPERACAO', gCdOperEntInspecao);
                end else begin
                  putitemXml(viParams, 'CD_OPERACAO', vCdOperacaoBase);
                end;
                putitemXml(viParams, 'TP_DCTOORIGEM', 2);
                putitemXml(viParams, 'NR_DCTOORIGEM', item_f('NR_FATURA', tFIS_NF));
                putitemXml(viParams, 'DT_DCTOORIGEM', item_a('DT_FATURA', tFIS_NF));
                putitemXml(viParams, 'QT_MOVIMENTO', vQtProdutoAtu);
                putitemXml(viParams, 'VL_UNITLIQUIDO', vVlProdutoAtu);
                putitemXml(viParams, 'VL_UNITSEMIMPOSTO', vVlProdutoAtu);
                putitemXml(viParams, 'CD_COMPONENTE', vCdComponente);
                putitemXml(viParams, 'DS_LSTVALOR', vDsLstValor);
                putitemXml(viParams, 'DT_KARDEX', vDtKardex);
                voParams := activateCmp('GERSVCO008', 'atualizaSaldoOperacao', viParams); (*,,,, *)
                if (xStatus < 0) then begin
                  Result := voParams;
                  return(-1); exit;
                end;
              end;
              if (vTpContrInspSaldoLote = 1)  and (vTpLote > 0)  and (item_f('TP_OPERACAO', tFIS_NF) = 'S') then begin
                if (empty(tFIS_NFITEMPLO) = False) then begin
                  setocc(tFIS_NFITEMPLO, 1);
                  while (xStatus >= 0) do begin

                    clear_e(tPRD_LOTEI);
                    putitem_e(tPRD_LOTEI, 'CD_EMPRESA', item_f('CD_EMPLOTE', tFIS_NFITEMPLO));
                    putitem_e(tPRD_LOTEI, 'NR_LOTE', item_f('NR_LOTE', tFIS_NFITEMPLO));
                    putitem_e(tPRD_LOTEI, 'NR_ITEM', item_f('NR_ITEMLOTE', tFIS_NFITEMPLO));
                    retrieve_e(tPRD_LOTEI);
                    if (xStatus >= 0) then begin
                      if (vCdOperSaldo <> 0)  and (vCdOperSaldo <> item_f('CD_SALDO', tPRD_LOTEI)) then begin
                        Result := SetStatus(STS_ERROR, 'GEN0001', 'Saldo ' + CD_SALDO + '.PRD_LOTEI do item de lote ' + CD_EMPRESA + '.PRD_LOTEI / ' + NR_LOTE + '.PRD_LOTEI / ' + NR_ITEM + '.PRD_LOTEI diferente do saldo ' + FloatToStr(vCdOperSaldo) + ' que é padrão da operação ' + FloatToStr(vCdOperacaoBase) + '!', cDS_METHOD);
                        return(-1); exit;
                      end;
                    end;

                    viParams := '';
                    putitemXml(viParams, 'CD_EMPRESA', item_f('CD_EMPLOTE', tFIS_NFITEMPLO));
                    putitemXml(viParams, 'NR_LOTE', item_f('NR_LOTE', tFIS_NFITEMPLO));
                    putitemXml(viParams, 'NR_ITEM', item_f('NR_ITEMLOTE', tFIS_NFITEMPLO));
                    putitemXml(viParams, 'QT_MOVIMENTO', item_f('QT_LOTE', tFIS_NFITEMPLO));
                    putitemXml(viParams, 'TP_MOVIMENTO', 'B');
                    putitemXml(viParams, 'IN_ESTORNO', vInEstorno);
                    if (item_f('TP_MODALIDADE', tGER_OPERACAO) = 3) then begin
                      putitemXml(viParams, 'IN_VALIDASITUACAO', False);
                    end;
                    voParams := activateCmp('PRDSVCO020', 'movimentaQtLoteI', viParams); (*,,,, *)
                    if (xStatus < 0) then begin
                      Result := voParams;
                      return(-1); exit;
                    end;

                    setocc(tFIS_NFITEMPLO, curocc(tFIS_NFITEMPLO) + 1);
                  end;
                end;
              end;
              if (gtinTinturaria = 1)  and (item_f('TP_OPERACAO', tFIS_NF) = 'E')  and (item_f('TP_MODALIDADE', tGER_OPERACAO) = 2)  and (empty(tFIS_NFITEMPLO) = False) then begin
                setocc(tFIS_NFITEMPLO, 1);
                while (xStatus >= 0) do begin
                  if (gTpSitLoteITransf > 0) then begin
                    viParams := '';
                    putitemXml(viParams, 'CD_EMPRESA', item_f('CD_EMPLOTE', tFIS_NFITEMPLO));
                    putitemXml(viParams, 'NR_LOTE', item_f('NR_LOTE', tFIS_NFITEMPLO));
                    putitemXml(viParams, 'NR_ITEM', item_f('NR_ITEMLOTE', tFIS_NFITEMPLO));
                    putitemXml(viParams, 'TP_SITUACAO', 1);
                    voParams := activateCmp('PRDSVCO020', 'alteraSituacaoLoteI', viParams); (*,,,, *)
                    if (xStatus < 0) then begin
                      Result := voParams;
                      return(-1); exit;
                    end;
                  end;
                  if (gTpSitLoteCTransf > 0) then begin
                    viParams := '';
                    putitemXml(viParams, 'CD_EMPRESA', item_f('CD_EMPLOTE', tFIS_NFITEMPLO));
                    putitemXml(viParams, 'NR_LOTE', item_f('NR_LOTE', tFIS_NFITEMPLO));
                    putitemXml(viParams, 'TP_SITUACAO', 3);
                    voParams := activateCmp('PRDSVCO020', 'alteraSituacaoLoteC', viParams); (*,,,, *)
                    if (xStatus < 0) then begin
                      Result := voParams;
                      return(-1); exit;
                    end;
                  end;

                  setocc(tFIS_NFITEMPLO, curocc(tFIS_NFITEMPLO) + 1);
                end;
              end;
            end;
            if (vInEstoqueTerceiro = True)  or (vInEstoqueDeTerceiro = True) then begin
              viParams := '';
              putitemXml(viParams, 'CD_EMPRESA', vCdEmpresaBase);
              putitemXml(viParams, 'CD_PRODUTO', item_f('CD_PRODUTO', tFIS_NFITEMPRO));
              putitemXml(viParams, 'CD_PESSOA', item_f('CD_PESSOA', tFIS_NF));
              putitemXml(viParams, 'CD_OPERACAO', vCdOperacaoBase);
              putitemXml(viParams, 'IN_ESTORNO', vInEstorno);
              putitemXml(viParams, 'TP_DCTOORIGEM', 2);
              putitemXml(viParams, 'NR_DCTOORIGEM', item_f('NR_FATURA', tFIS_NF));
              putitemXml(viParams, 'DT_DCTOORIGEM', item_a('DT_FATURA', tFIS_NF));
              putitemXml(viParams, 'QT_MOVIMENTO', vQtProdutoAtu);
              putitemXml(viParams, 'CD_COMPONENTE', vCdComponente);

              if (vInEstoqueTerceiro = True) then begin
                if (gCdSaldoEstTerceiro <> 0) then begin
                  putitemXml(viParams, 'CD_SALDO', gCdSaldoEstTerceiro);
                end;
                putitemXml(viParams, 'IN_INVERTIDO', True);
              end else begin
                if (gCdSaldoEstDeTerc = 0) then begin
                  Result := SetStatus(STS_ERROR, 'GEN0001', 'Valor do parametro empresa CD_SALDO_EST_DE_TERC não cadatrado!', cDS_METHOD);
                  return(-1); exit;
                end;
                putitemXml(viParams, 'CD_SALDO', gCdSaldoEstDeTerc);
                putitemXml(viParams, 'IN_INVERTIDO', False);
              end;

              voParams := activateCmp('PRDSVCO022', 'gravaMovimento', viParams); (*,,,, *)
              if (xStatus < 0) then begin
                Result := voParams;
                return(-1); exit;
              end;
            end;

            setocc(tFIS_NFITEMPRO, curocc(tFIS_NFITEMPRO) + 1);
          end;
        end;
        setocc(tFIS_NFITEM, curocc(tFIS_NFITEM) + 1);
      end;
      deleteinstance 'GERSVCO008I';
    end;

    clear_e(tGER_OPERACAO);
    putitem_e(tGER_OPERACAO, 'CD_OPERACAO', vCdOperacaoBase);
    retrieve_e(tGER_OPERACAO);
    if (xStatus < 0) then begin
      Result := SetStatus(STS_ERROR, 'GEN0001', 'Operaçao ' + CD_OPERACAO + '.GER_OPERACAO não cadastrada!', cDS_METHOD);
      return(-1); exit;
    end;
    if (vInTransferencia <> True)  and (vInSoTerceiro <> True) then begin
      if (item_f('TP_OPERACAO', tFIS_NF) = 'E')  and (item_f('TP_MODALIDADE', tGER_OPERACAO) = 2)  and (item_f('CD_OPERFAT', tGER_OPERACAO) > 0) then begin
        clear_e(tGER_EMPRESA);
        putitem_e(tGER_EMPRESA, 'CD_PESSOA', item_f('CD_PESSOA', tFIS_NF));
        retrieve_e(tGER_EMPRESA);
        if (xStatus >= 0) then begin
          viParams := '';
          vDsLstNFAux := '';

          putitem(vDsLstNFAux,  vDsRegistroNF);
          putitemXml(viParams, 'DS_LSTNF', vDsLstNFAux);
          putitemXml(viParams, 'IN_ESTORNO', False);
          putitemXml(viParams, 'CD_EMPRESABASE', item_f('CD_EMPRESA', tGER_EMPRESA));
          putitemXml(viParams, 'CD_OPERACAOBASE', item_f('CD_OPERFAT', tGER_OPERACAO));
          putitemXml(viParams, 'IN_TRANSFERENCIA', True);
          newinstance 'FISSVCO038', 'FISSVCO038I', 'TRANSACTION=FALSE';
          voParams := activateCmp('FISSVCO038I', 'atualizaEstoqueNF', viParams); (*,,,, *)
          if (xStatus < 0) then begin
            Result := voParams;
            return(-1); exit;
          end;
        end;
      end;
      if (item_f('TP_OPERACAO', tFIS_NF) = 'S')  and (item_f('TP_MODALIDADE', tGER_OPERACAO) = 2)  and (gCdOperEntEstTrans > 0) then begin
        clear_e(tGER_EMPRESA);
        putitem_e(tGER_EMPRESA, 'CD_PESSOA', item_f('CD_PESSOA', tFIS_NF));
        retrieve_e(tGER_EMPRESA);
        if (xStatus >= 0) then begin
          viParams := '';
          vDsLstNFAux := '';

          putitem(vDsLstNFAux,  vDsRegistroNF);
          putitemXml(viParams, 'DS_LSTNF', vDsLstNFAux);
          putitemXml(viParams, 'IN_ESTORNO', False);
          putitemXml(viParams, 'CD_EMPRESABASE', item_f('CD_EMPRESA', tGER_EMPRESA));
          putitemXml(viParams, 'CD_OPERACAOBASE', gCdOperEntEstTrans);
          putitemXml(viParams, 'IN_TRANSFERENCIA', True);
          newinstance 'FISSVCO038', 'FISSVCO038I', 'TRANSACTION=FALSE';
          voParams := activateCmp('FISSVCO038I', 'atualizaEstoqueNF', viParams); (*,,,, *)
          if (xStatus < 0) then begin
            Result := voParams;
            return(-1); exit;
          end;
        end;
      end;
    end;

    delitem(vDsLstNF, 1);
  until (vDsLstNF = '');

  return(0); exit;

end;

end.
