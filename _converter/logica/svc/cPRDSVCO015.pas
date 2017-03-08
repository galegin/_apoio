unit cPRDSVCO015;

interface

(* COMPONENTES 
  ADMSVCO001 / GERSVCO032 / PCPSVCO001 / PEDSVCO010 / PRDSVCO006

*)        

uses
  Classes, SysUtils, DB,
  cServiceUnf, cDataSetUnf;

type
  T_PRDSVCO015 = class(TcServiceUnf)
  private
    tGER_OPERACAO,
    tGER_OPERSALDO,
    tPCP_OPMP,
    tPCP_RELPRD,
    tPED_PEDIDOG,
    tPED_PEDIDOTRA,
    tPED_PERIODO,
    tPED_SALDOMPPE,
    tPRD_GRUPOADIC,
    tPRD_PRDGRADE,
    tPRD_PRODUTO,
    tPRD_TPSALDOF,
    tTIN_OTNI,
    tTMP_NR09,
    tV_CMC_CMPREP,
    tV_CMC_PRODUTO,
    tV_CMC_TRAREP,
    tV_CMP_PEDIDOI,
    tV_CMP_PRDOPER,
    tV_CMP_PRDPREV,
    tV_CMP_PRDSLD,
    tV_PCP_FC2,
    tV_PCP_LOTEPL,
    tV_PCP_LOTEPLC,
    tV_PCP_OPPEND,
    tV_PED_COROPER,
    tV_PED_PRDOPER,
    tV_PED_PRDPREV,
    tV_PED_PRDSALD,
    tV_PED_PRDSLD,
    tV_PRD_RESERVA,
    tV_PRD_SALDO,
    tV_TRA_PRDOPER,
    tV_TRA_SLDPRDD : TcDatasetUnf;
    function getParam(pParams : String = '') : String;
    function setEntidade(pParams : String = '') : String;
  protected
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;    
  published
    function buscaPorPartes(pParams : String = '') : String;
    function filtrarCodigo(pParams : String = '') : String;
    function verificaSaldoProduto(pParams : String = '') : String;
    function verificaSaldoPAMP(pParams : String = '') : String;
    function verificaSaldoMPPer(pParams : String = '') : String;
    function verificaSaldoPlanejamentoCor(pParams : String = '') : String;
    function verificaSaldoReserva(pParams : String = '') : String;
    function buscaSaldoProdutoCMP(pParams : String = '') : String;
    function retornaDadosPedidoG(pParams : String = '') : String;
    function verificaSaldoPlanejamentoItem(pParams : String = '') : String;
    function verificaSaldoMaterialConsumo(pParams : String = '') : String;
    function buscaSaldoDisponivel(pParams : String = '') : String;
    function buscaSaldoTransacao(pParams : String = '') : String;
  end;

implementation

uses
  cADMSVCO001,
  cActivate, cStatus, cFuncao, cXml, dModulo;

var
  gCdSaldo,
  gCdSaldoFisico,
  gCdSaldoInspecao,
  gCdSaldoReserva,
  gprSaldoOpPed,
  gTpEmpSaldoCMP,
  gTpValidacaoSaldoPed : String;

//---------------------------------------------------------------
constructor T_PRDSVCO015.Create(AOwner: TComponent);
//---------------------------------------------------------------
begin
  inherited Create(AOwner);
  setEntidade('');
end;

//--------------------------------
destructor T_PRDSVCO015.Destroy;
//--------------------------------
begin
  inherited Destroy;
end;

//---------------------------------------------------------------
function T_PRDSVCO015.getParam(pParams : String = '') : String;
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
  putitem(xParamEmp, 'CD_SALDO_FISICO_CMC');
  putitem(xParamEmp, 'CD_SALDO_INSPECAO');
  putitem(xParamEmp, 'CD_SALDO_RESERVA_CMC');
  putitem(xParamEmp, 'CD_SALDOPADRAO');
  putitem(xParamEmp, 'PR_VALIDACAO_SALDO_OP_PED');
  putitem(xParamEmp, 'TP_VALIDACAO_SALDO_PED');

  xParamEmp := T_ADMSVCO001.GetParamEmpresa(piCdEmpresa, xParamEmp);

  gCdSaldo := itemXml('CD_SALDOPADRAO', xParamEmp);
  gCdSaldoFisico := itemXml('CD_SALDO_FISICO_CMC', xParamEmp);
  gCdSaldoInspecao := itemXml('CD_SALDO_INSPECAO', xParamEmp);
  gCdSaldoReserva := itemXml('CD_SALDO_RESERVA_CMC', xParamEmp);
  gprSaldoOpPed := itemXml('PR_VALIDACAO_SALDO_OP_PED', xParamEmp);
  gTpValidacaoSaldoPed := itemXml('TP_VALIDACAO_SALDO_PED', xParamEmp);

end;

//---------------------------------------------------------------
function T_PRDSVCO015.setEntidade(pParams : String = '') : String;
//---------------------------------------------------------------
begin
  tGER_OPERACAO := GetEntidade('GER_OPERACAO');
  tGER_OPERSALDO := GetEntidade('GER_OPERSALDO');
  tPCP_OPMP := GetEntidade('PCP_OPMP');
  tPCP_RELPRD := GetEntidade('PCP_RELPRD');
  tPED_PEDIDOG := GetEntidade('PED_PEDIDOG');
  tPED_PEDIDOTRA := GetEntidade('PED_PEDIDOTRA');
  tPED_PERIODO := GetEntidade('PED_PERIODO');
  tPED_SALDOMPPE := GetEntidade('PED_SALDOMPPE');
  tPRD_GRUPOADIC := GetEntidade('PRD_GRUPOADIC');
  tPRD_PRDGRADE := GetEntidade('PRD_PRDGRADE');
  tPRD_PRODUTO := GetEntidade('PRD_PRODUTO');
  tPRD_TPSALDOF := GetEntidade('PRD_TPSALDOF');
  tTIN_OTNI := GetEntidade('TIN_OTNI');
  tTMP_NR09 := GetEntidade('TMP_NR09');
  tV_CMC_CMPREP := GetEntidade('V_CMC_CMPREP');
  tV_CMC_PRODUTO := GetEntidade('V_CMC_PRODUTO');
  tV_CMC_TRAREP := GetEntidade('V_CMC_TRAREP');
  tV_CMP_PEDIDOI := GetEntidade('V_CMP_PEDIDOI');
  tV_CMP_PRDOPER := GetEntidade('V_CMP_PRDOPER');
  tV_CMP_PRDPREV := GetEntidade('V_CMP_PRDPREV');
  tV_CMP_PRDSLD := GetEntidade('V_CMP_PRDSLD');
  tV_PCP_FC2 := GetEntidade('V_PCP_FC2');
  tV_PCP_LOTEPL := GetEntidade('V_PCP_LOTEPL');
  tV_PCP_LOTEPLC := GetEntidade('V_PCP_LOTEPLC');
  tV_PCP_OPPEND := GetEntidade('V_PCP_OPPEND');
  tV_PED_COROPER := GetEntidade('V_PED_COROPER');
  tV_PED_PRDOPER := GetEntidade('V_PED_PRDOPER');
  tV_PED_PRDPREV := GetEntidade('V_PED_PRDPREV');
  tV_PED_PRDSALD := GetEntidade('V_PED_PRDSALD');
  tV_PED_PRDSLD := GetEntidade('V_PED_PRDSLD');
  tV_PRD_RESERVA := GetEntidade('V_PRD_RESERVA');
  tV_PRD_SALDO := GetEntidade('V_PRD_SALDO');
  tV_TRA_PRDOPER := GetEntidade('V_TRA_PRDOPER');
  tV_TRA_SLDPRDD := GetEntidade('V_TRA_SLDPRDD');
end;

//--------------------------------------------------------------
function T_PRDSVCO015.buscaPorPartes(pParams : String) : String;
//--------------------------------------------------------------
const
  cDS_METHOD = 'ADICIONAL=Operação: T_PRDSVCO015.buscaPorPartes()';
var
  (* string piDsTab : IN / string piDsColuna : IN / string piDsLista : IN / string piDsCampoAdic : IN / string piDsValorAdic : IN *)
  vDsRegistro, vDsListaMenor, vDsColuna, vDsTab, vDsLista, vDsColTab, vDsCampo, vDsColTabAdic : String;
  vDsCampoAdic, vDsValorCampo : String;
  vInListar : Boolean;
begin
  vInListar := True;
  vDsLista := piDsLista;
  vDsColTab := '' + piDsColuna + '.' + piDsTab' + ';
  clear/e'' + piDsTab' + ';
  repeat
    voParams := filtrarCodigo(viParams); (* vDsLista, vDsListaMenor *)
    if (xStatus < 0) then begin
      Result := voParams;
      return(-1); exit;
    end;
    if (vInListar = False) then begin
      creocc '' + piDsTab', + ' -1;
    end;

    @vDsColTab := vDsListaMenor;
    vDsCampoAdic := piDsCampoAdic;
    while (vDsCampoAdic <> '') do begin
      getitem(vDsCampo, vDsCampoAdic, 1);

      vDsColTabAdic := '' + vDsCampo + '.' + piDsTab' + ';
      vDsValorCampo := itemXml('' + vDsCampo', + ' piDsValorAdic);
      @vDsColTabAdic := vDsValorCampo;

      delitem(vDsCampoAdic, 1);
    end;
    if (vInListar = True) then begin
      retrieve/e'' + piDsTab' + ';
      if (xStatus >= 0) then begin
        vInListar := False;
      end else begin
        clear/e'' + piDsTab' + ';
      end;
    end else begin
      retrieve/a'' + piDsTab' + ';
      if (xStatus < 0) then begin
        discard '' + piDsTab' + ';
      end;
    end;

  until (vDsLista = '');

  return(0); exit;
end;

//-------------------------------------------------------------
function T_PRDSVCO015.filtrarCodigo(pParams : String) : String;
//-------------------------------------------------------------
const
  cDS_METHOD = 'ADICIONAL=Operação: T_PRDSVCO015.filtrarCodigo()';
var
  (* string piDsCodigoEntrada : INOUT / string poDsCodigoSaida : OUT *)
  vDsCodigo : String;
  vNrCont : Real;
begin
  poDsCodigoSaida := '';
  vNrCont := 0;
  if (piDsCodigoEntrada <> '') then begin
    repeat
      getitem(vDsCodigo, piDsCodigoEntrada, 1);
      putitem(poDsCodigoSaida,  vDsCodigo);
      vNrCont := vNrCont + 1;
      delitem(piDsCodigoEntrada, 1);
    until (piDsCodigoEntrada := '' ) or (vNrCont := 25);
  end;

  return(0); exit;
end;

//--------------------------------------------------------------------
function T_PRDSVCO015.verificaSaldoProduto(pParams : String) : String;
//--------------------------------------------------------------------
const
  cDS_METHOD = 'ADICIONAL=Operação: T_PRDSVCO015.verificaSaldoProduto()';
var
  vCdEmpresa, viParams, voParams, vDsLstOperSaida, vDsLstOperEntrada : String;
  vCdEmpresaPRD, vCdEmpresaPED, vCdEmpresaCMP, vCdEmpresaOP, vDsCampo, vDsCampoValor : String;
  vCdGrupoEmpresa, vCdProduto, vQtCmpPendente, vQtPedPendente, vQtDisponivel, vQtEstoque : Real;
  vQtCmpPendenteAnt, vQtPedPendenteAnt, vQtVenda, vQtCompra, vQtEntrada, vQtSaida, vNrTinturaria : Real;
  vCdOperacao, vCdSaldoOperacao, vQtCmpSolicitada, vQtCmpAtendida, vQtCmpCancelada, vQtCmpExtra : Real;
  numeric vQtPedSolicitada, vQtPendida, vQtPedCancelada, vQtPedExtra, vQtOp, vQtOPLiberacao, vQtOPAndamento : TDate;
  vInTransacao, vInTotalCmp, vInTotalPed, vInValidaLocal, vInNecessidade : Boolean;
begin
  vCdEmpresa := itemXmlF('CD_EMPRESA', pParams);
  vCdEmpresaPRD := itemXmlF('CD_EMPRESAPRD', pParams);
  vCdEmpresaPED := itemXmlF('CD_EMPRESAPED', pParams);
  vCdEmpresaCMP := itemXmlF('CD_EMPRESACMP', pParams);
  vCdEmpresaOP := itemXmlF('CD_EMPRESAOP', pParams);
  vCdGrupoEmpresa := itemXmlF('CD_GRUPOEMPRESA', pParams);
  vCdProduto := itemXmlF('CD_PRODUTO', pParams);
  vQtPedPendenteAnt := itemXmlF('QT_PEDPendENTEANT', pParams);
  vQtCmpPendenteAnt := itemXmlF('QT_CMPPendENTEANT', pParams);
  vInTransacao := itemXmlB('IN_TRANSACAO', pParams);
  vInTotalCmp := itemXmlB('IN_TOTALCMP', pParams);
  vInTotalPed := itemXmlB('IN_TOTALPED', pParams);
  vCdOperacao := itemXmlF('CD_OPERACAO', pParams);
  vCdSaldoOperacao := itemXmlF('CD_SALDO', pParams);
  vInValidaLocal := itemXmlB('IN_VALIDALOCAL', pParams);
  gCdSaldo := itemXmlF('CD_SALDOPADRAO', pParams);
  gTpValidacaoSaldoPed := itemXmlF('TP_VALIDACAO_SALDO_PED', pParams);
  gTpEmpSaldoCMP := itemXmlF('TP_EMP_SALDO_CMP', PARAM_GLB);
  vNrTinturaria := itemXml('TIN_TINTURARIA', PARAM_GLB);
  vInNecessidade := itemXmlB('IN_NECESSIDADE', pParams);

  if (vCdEmpresa = '') then begin
    if (vCdGrupoEmpresa > 0) then begin
      viParams := '';
      putitemXml(viParams, 'CD_GRUPOEMPRESA', vCdGrupoEmpresa);
      putitemXml(viParams, 'IN_VALIDALOCAL', vInValidaLocal);
      voParams := activateCmp('GERSVCO032', 'buscaLstGrupoEmpresa', viParams); (*,,,, *)
      if (xStatus < 0) then begin
        Result := voParams;
        return(-1); exit;
      end;
      vCdEmpresa := itemXmlF('CD_EMPRESA', voParams);
    end else begin
      vCdEmpresa := itemXmlF('CD_EMPRESA', PARAM_GLB);
    end;
  end;
  if (vCdEmpresa = '') then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Empresa não informada!', cDS_METHOD);
    return(-1); exit;
  end;
  if (vInTransacao = True) then begin
    if (gCdSaldo = '') then begin
      getParams(pParams); (* vCdEmpresa *)
      if (xStatus < 0) then begin
        return(-1); exit;
      end;
    end;
  end else begin
    if (gCdSaldo = '')  or (gTpValidacaoSaldoPed = '') then begin
      getParams(pParams); (* vCdEmpresa *)
      if (xStatus < 0) then begin
        return(-1); exit;
      end;
    end;
  end;

  vDsLstOperSaida := '';
  vDsLstOperEntrada := '';

  if (vCdOperacao > 0) then begin
    vCdSaldoOperacao := '';
    clear_e(tGER_OPERACAO);
    putitem_e(tGER_OPERACAO, 'CD_OPERACAO', vCdOperacao);
    retrieve_e(tGER_OPERACAO);
    if (xStatus < 0) then begin
      Result := SetStatus(STS_ERROR, 'GEN0001', 'Operação %vCdOperacao não cadastrada!', cDS_METHOD);
      return(-1); exit;
    end;
    clear_e(tGER_OPERSALDO);
    putitem_e(tGER_OPERSALDO, 'IN_PADRAO', True);
    retrieve_e(tGER_OPERSALDO);
    if (xStatus >= 0) then begin
      vCdSaldoOperacao := item_f('CD_SALDO', tGER_OPERSALDO);
    end else begin
      clear_e(tGER_OPERSALDO);
      retrieve_e(tGER_OPERSALDO);
      if (xStatus >= 0) then begin
        vCdSaldoOperacao := item_f('CD_SALDO', tGER_OPERSALDO);
      end else begin
        clear_e(tGER_OPERSALDO);
      end;
    end;
  end;
  if (vCdSaldoOperacao = '') then begin
    vCdSaldoOperacao := gCdSaldo;
  end;

  clear_e(tTMP_NR09);

  if (vCdSaldoOperacao > 0) then begin
    clear_e(tPRD_TPSALDOF);
    putitem_e(tPRD_TPSALDOF, 'CD_SALDO', vCdSaldoOperacao);
    retrieve_e(tPRD_TPSALDOF);
    if (xStatus >= 0) then begin
      setocc(tPRD_TPSALDOF, 1);
      while (xStatus >= 0) do begin
        if (item_f('TP_OPERACAO', tPRD_TPSALDOF) = 1) then begin
          Result := SetStatus(STS_ERROR, 'GEN0001', 'Tipo de saldo ' + FloatToStr(vCdSaldoOperacao) + ' possui saldos em sua composição com operação de subtração que é incompatível com esta rotina!', cDS_METHOD);
          return(-1); exit;
        end;
        creocc(tTMP_NR09, -1);
        putitem_e(tTMP_NR09, 'NR_GERAL', item_f('CD_SALDOF', tPRD_TPSALDOF));
        retrieve_o(tTMP_NR09);
        setocc(tPRD_TPSALDOF, curocc(tPRD_TPSALDOF) + 1);
      end;
    end;
    creocc(tTMP_NR09, -1);
    putitem_e(tTMP_NR09, 'NR_GERAL', vCdSaldoOperacao);
    retrieve_o(tTMP_NR09);

    clear_e(tGER_OPERACAO);
    putitem_e(tGER_OPERACAO, 'TP_OPERACAO', 'E');
    putitem_e(tGER_OPERACAO, 'IN_KARDEX', True);
    putitem_e(tGER_OPERACAO, 'CD_OPERFAT', '>0');
    retrieve_e(tGER_OPERACAO);
    if (xStatus >= 0) then begin
      setocc(tGER_OPERACAO, 1);
      while (xStatus >= 0) do begin
        clear_e(tGER_OPERSALDO);
        putitem_e(tGER_OPERSALDO, 'IN_PADRAO', True);
        retrieve_e(tGER_OPERSALDO);
        if (xStatus >= 0) then begin
          creocc(tTMP_NR09, -1);
          putitem_e(tTMP_NR09, 'NR_GERAL', item_f('CD_SALDO', tGER_OPERSALDO));
          retrieve_o(tTMP_NR09);
          if (xStatus = 4) then begin
            putitem(vDsLstOperEntrada,  item_f('CD_OPERACAO', tGER_OPERACAO));
          end else begin
            discard(tTMP_NR09);
          end;
        end;
        setocc(tGER_OPERACAO, curocc(tGER_OPERACAO) + 1);
      end;
    end;

    clear_e(tGER_OPERACAO);
    putitem_e(tGER_OPERACAO, 'TP_OPERACAO', 'S');
    putitem_e(tGER_OPERACAO, 'IN_KARDEX', True);
    putitem_e(tGER_OPERACAO, 'CD_OPERFAT', '>0');
    retrieve_e(tGER_OPERACAO);
    if (xStatus >= 0) then begin
      setocc(tGER_OPERACAO, 1);
      while (xStatus >= 0) do begin
        clear_e(tGER_OPERSALDO);
        putitem_e(tGER_OPERSALDO, 'IN_PADRAO', True);
        retrieve_e(tGER_OPERSALDO);
        if (xStatus >= 0) then begin
          creocc(tTMP_NR09, -1);
          putitem_e(tTMP_NR09, 'NR_GERAL', item_f('CD_SALDO', tGER_OPERSALDO));
          retrieve_o(tTMP_NR09);
          if (xStatus = 4) then begin
            putitem(vDsLstOperSaida,  item_f('CD_OPERACAO', tGER_OPERACAO));
          end else begin
            discard(tTMP_NR09);
          end;
        end;
        setocc(tGER_OPERACAO, curocc(tGER_OPERACAO) + 1);
      end;
    end;
  end;

  vQtEstoque := 0;

  if (vCdEmpresaPRD <> '') then begin
    viParams := '';
    putitemXml(viParams, 'CD_PRODUTO', vCdProduto);
    putitemXml(viParams, 'CD_SALDO', vCdSaldoOperacao);
    putitemXml(viParams, 'IN_VALIDALOCAL', False);
    voParams := activateCmp('PRDSVCO006', 'buscaSaldoData', viParams); (*,,vCdEmpresaPRD,,, *)
    if (xStatus < 0) then begin
      Result := voParams;
      return(-1); exit;
    end;
  end else begin
    viParams := '';
    putitemXml(viParams, 'CD_PRODUTO', vCdProduto);
    putitemXml(viParams, 'CD_SALDO', vCdSaldoOperacao);
    putitemXml(viParams, 'IN_VALIDALOCAL', False);
    voParams := activateCmp('PRDSVCO006', 'buscaSaldoData', viParams); (*,,vCdEmpresa,,, *)
    if (xStatus < 0) then begin
      Result := voParams;
      return(-1); exit;
    end;
  end;

  vQtEstoque := itemXmlF('QT_SALDO', voParams);

  if (vInTransacao = True) then begin
    vQtEntrada := 0;

    if (vDsLstOperEntrada <> '') then begin
      vDsCampo := '';
      putitem(vDsCampo,  'CD_EMPFAT');
      putitem(vDsCampo,  'CD_PRODUTO');
      putitem(vDsCampo,  'TP_SITUACAO');
      putitem(vDsCampo,  'TP_OPERACAO');

      vDsCampoValor := '';
      if (vCdEmpresaPRD <> '') then begin
        putitemXml(vDsCampoValor, 'CD_EMPFAT', vCdEmpresaPRD);
      end else begin
        putitemXml(vDsCampoValor, 'CD_EMPFAT', vCdEmpresa);
      end;
      putitemXml(vDsCampoValor, 'CD_PRODUTO', vCdProduto);
      putitemXml(vDsCampoValor, 'TP_SITUACAO', '1);
      putitemXml(vDsCampoValor, 'TP_OPERACAO', 'E');
      voParams := buscaPorPartes(viParams); (* 'V_TRA_PRDOPERSVC', 'CD_OPERACAO', vDsLstOperEntrada, vDsCampo, vDsCampoValor *)
      if (xStatus < 0) then begin
        Result := voParams;
        return(-1); exit;
      end;
      if not (empty(tV_TRA_PRDOPER)) then begin
        setocc(tV_TRA_PRDOPER, 1);
        while (xStatus >= 0) do begin
          vQtEntrada := vQtEntrada + item_f('QT_SOLICITADA', tV_TRA_PRDOPER);
          setocc(tV_TRA_PRDOPER, curocc(tV_TRA_PRDOPER) + 1);
        end;
      end;
    end;

    vQtSaida := 0;

    if (vDsLstOperSaida <> '') then begin
      vDsCampo := '';
      putitem(vDsCampo,  'CD_EMPFAT');
      putitem(vDsCampo,  'CD_PRODUTO');
      putitem(vDsCampo,  'TP_SITUACAO');
      putitem(vDsCampo,  'TP_OPERACAO');

      vDsCampoValor := '';
      if (vCdEmpresaPRD <> '') then begin
        putitemXml(vDsCampoValor, 'CD_EMPFAT', vCdEmpresaPRD);
      end else begin
        putitemXml(vDsCampoValor, 'CD_EMPFAT', vCdEmpresa);
      end;
      putitemXml(vDsCampoValor, 'CD_PRODUTO', vCdProduto);
      putitemXml(vDsCampoValor, 'TP_SITUACAO', '1);
      putitemXml(vDsCampoValor, 'TP_OPERACAO', 'S');
      voParams := buscaPorPartes(viParams); (* 'V_TRA_PRDOPERSVC', 'CD_OPERACAO', vDsLstOperSaida, vDsCampo, vDsCampoValor *)
      if (xStatus < 0) then begin
        Result := voParams;
        return(-1); exit;
      end;
      if not (empty(tV_TRA_PRDOPER)) then begin
        setocc(tV_TRA_PRDOPER, 1);
        while (xStatus >= 0) do begin
          vQtSaida := vQtSaida + item_f('QT_SOLICITADA', tV_TRA_PRDOPER);
          setocc(tV_TRA_PRDOPER, curocc(tV_TRA_PRDOPER) + 1);
        end;
      end;
    end;

    vQtDisponivel := vQtEstoque + vQtEntrada - vQtSaida;

    Result := '';
    putitemXml(Result, 'QT_DISPONIVEL', vQtDisponivel);
    putitemXml(Result, 'QT_ENTRADA', vQtEntrada);
    putitemXml(Result, 'QT_SAIDA', vQtSaida);
    putitemXml(Result, 'QT_ESTOQUE', vQtEstoque);
  end else begin
    vQtCmpPendente := 0;
    vQtCompra := 0;

    if (vDsLstOperEntrada <> '') then begin
      vDsCampo := '';
      putitem(vDsCampo,  'CD_EMPESTOQUE');
      putitem(vDsCampo,  'CD_EMPRESA');
      putitem(vDsCampo,  'CD_PRODUTO');
      putitem(vDsCampo,  'TP_SITUACAO');

      vDsCampoValor := '';
      if (gTpEmpSaldoCMP = 01) then begin
        if (vCdEmpresaCMP <> '') then begin
          putitemXml(vDsCampoValor, 'CD_EMPESTOQUE', vCdEmpresaCMP);
        end else begin
          putitemXml(vDsCampoValor, 'CD_EMPESTOQUE', vCdEmpresa);
        end;
      end else begin
        if (vCdEmpresaCMP <> '') then begin
          putitemXml(vDsCampoValor, 'CD_EMPRESA', vCdEmpresaCMP);
        end else begin
          putitemXml(vDsCampoValor, 'CD_EMPRESA', vCdEmpresa);
        end;
      end;
      putitemXml(vDsCampoValor, 'CD_PRODUTO', vCdProduto);
      putitemXml(vDsCampoValor, 'TP_SITUACAO', '1);
      voParams := buscaPorPartes(viParams); (* 'V_CMP_PRDOPERSVC', 'CD_OPERACAO', vDsLstOperEntrada, vDsCampo, vDsCampoValor *)
      if (xStatus < 0) then begin
        Result := voParams;
        return(-1); exit;
      end;
      if not (empty(tV_CMP_PRDOPER)) then begin
        setocc(tV_CMP_PRDOPER, 1);
        while (xStatus >= 0) do begin
          vQtCmpPendente := vQtCmpPendente + item_f('QT_PENDENTE', tV_CMP_PRDOPER);
          setocc(tV_CMP_PRDOPER, curocc(tV_CMP_PRDOPER) + 1);
        end;
      end;
    end;
    if (vDsLstOperEntrada <> '') then begin
      vDsCampo := '';
      putitem(vDsCampo,  'CD_EMPFAT');
      putitem(vDsCampo,  'CD_PRODUTO');
      putitem(vDsCampo,  'TP_SITUACAO');
      putitem(vDsCampo,  'TP_MODALIDADE');
      putitem(vDsCampo,  'TP_OPERACAO');

      vDsCampoValor := '';
      if (vCdEmpresaPRD <> '') then begin
        putitemXml(vDsCampoValor, 'CD_EMPFAT', vCdEmpresaPRD);
      end else begin
        putitemXml(vDsCampoValor, 'CD_EMPFAT', vCdEmpresa);
      end;
      putitemXml(vDsCampoValor, 'CD_PRODUTO', vCdProduto);
      putitemXml(vDsCampoValor, 'TP_SITUACAO', '1);
      putitemXml(vDsCampoValor, 'TP_MODALIDADE', 4);
      putitemXml(vDsCampoValor, 'TP_OPERACAO', 'E');
      voParams := buscaPorPartes(viParams); (* 'V_TRA_PRDOPERSVC', 'CD_OPERACAO', vDsLstOperEntrada, vDsCampo, vDsCampoValor *)
      if (xStatus < 0) then begin
        Result := voParams;
        return(-1); exit;
      end;
      if not (empty(tV_TRA_PRDOPER)) then begin
        setocc(tV_TRA_PRDOPER, 1);
        while (xStatus >= 0) do begin
          vQtCompra := vQtCompra + item_f('QT_SOLICITADA', tV_TRA_PRDOPER);
          setocc(tV_TRA_PRDOPER, curocc(tV_TRA_PRDOPER) + 1);
        end;
      end;
    end;
    if (vDsLstOperSaida <> '') then begin
      vDsCampo := '';
      putitem(vDsCampo,  'CD_EMPFAT');
      putitem(vDsCampo,  'CD_PRODUTO');
      putitem(vDsCampo,  'TP_SITUACAO');
      putitem(vDsCampo,  'TP_MODALIDADE');
      putitem(vDsCampo,  'TP_OPERACAO');

      vDsCampoValor := '';
      if (vCdEmpresaPRD <> '') then begin
        putitemXml(vDsCampoValor, 'CD_EMPFAT', vCdEmpresaPRD);
      end else begin
        putitemXml(vDsCampoValor, 'CD_EMPFAT', vCdEmpresa);
      end;
      putitemXml(vDsCampoValor, 'CD_PRODUTO', vCdProduto);
      putitemXml(vDsCampoValor, 'TP_SITUACAO', '1);
      putitemXml(vDsCampoValor, 'TP_MODALIDADE', 3);
      putitemXml(vDsCampoValor, 'TP_OPERACAO', 'E');
      voParams := buscaPorPartes(viParams); (* 'V_TRA_PRDOPERSVC', 'CD_OPERACAO', vDsLstOperSaida, vDsCampo, vDsCampoValor *)
      if (xStatus < 0) then begin
        Result := voParams;
        return(-1); exit;
      end;
      if not (empty(tV_TRA_PRDOPER)) then begin
        setocc(tV_TRA_PRDOPER, 1);
        while (xStatus >= 0) do begin
          vQtCompra := vQtCompra - item_f('QT_SOLICITADA', tV_TRA_PRDOPER);
          setocc(tV_TRA_PRDOPER, curocc(tV_TRA_PRDOPER) + 1);
        end;
      end;
    end;

    vQtCmpPendente := vQtCmpPendente - vQtCmpPendenteAnt;

    vQtPedPendente := 0;
    vQtVenda := 0;

    if (vDsLstOperSaida <> '') then begin
      vDsCampo := '';
      putitem(vDsCampo,  'CD_EMPRESA');
      putitem(vDsCampo,  'CD_PRODUTO');
      putitem(vDsCampo,  'TP_SITUACAO');

      vDsCampoValor := '';
      if (vCdEmpresaPED <> '') then begin
        putitemXml(vDsCampoValor, 'CD_EMPRESA', vCdEmpresaPED);
      end else begin
        putitemXml(vDsCampoValor, 'CD_EMPRESA', vCdEmpresa);
      end;
      putitemXml(vDsCampoValor, 'CD_PRODUTO', vCdProduto);
      putitemXml(vDsCampoValor, 'TP_SITUACAO', '1);
      voParams := buscaPorPartes(viParams); (* 'V_PED_PRDOPERSVC', 'CD_OPERACAO', vDsLstOperSaida, vDsCampo, vDsCampoValor *)
      if (xStatus < 0) then begin
        Result := voParams;
        return(-1); exit;
      end;
      if not (empty(tV_PED_PRDOPER)) then begin
        setocc(tV_PED_PRDOPER, 1);
        while (xStatus >= 0) do begin
          vQtPedPendente := vQtPedPendente + item_f('QT_PENDENTE', tV_PED_PRDOPER);
          setocc(tV_PED_PRDOPER, curocc(tV_PED_PRDOPER) + 1);
        end;
      end;
    end;
    if (vDsLstOperSaida <> '') then begin
      vDsCampo := '';
      putitem(vDsCampo,  'CD_EMPFAT');
      putitem(vDsCampo,  'CD_PRODUTO');
      putitem(vDsCampo,  'TP_SITUACAO');
      putitem(vDsCampo,  'TP_MODALIDADE');
      putitem(vDsCampo,  'TP_OPERACAO');

      vDsCampoValor := '';
      if (vCdEmpresaPRD <> '') then begin
        putitemXml(vDsCampoValor, 'CD_EMPFAT', vCdEmpresaPRD);
      end else begin
        putitemXml(vDsCampoValor, 'CD_EMPFAT', vCdEmpresa);
      end;
      putitemXml(vDsCampoValor, 'CD_PRODUTO', vCdProduto);
      putitemXml(vDsCampoValor, 'TP_SITUACAO', '1);
      putitemXml(vDsCampoValor, 'TP_MODALIDADE', 4);
      putitemXml(vDsCampoValor, 'TP_OPERACAO', 'S');
      voParams := buscaPorPartes(viParams); (* 'V_TRA_PRDOPERSVC', 'CD_OPERACAO', vDsLstOperSaida, vDsCampo, vDsCampoValor *)
      if (xStatus < 0) then begin
        Result := voParams;
        return(-1); exit;
      end;
      if not (empty(tV_TRA_PRDOPER)) then begin
        setocc(tV_TRA_PRDOPER, 1);
        while (xStatus >= 0) do begin
          vQtVenda := vQtVenda + item_f('QT_SOLICITADA', tV_TRA_PRDOPER);
          setocc(tV_TRA_PRDOPER, curocc(tV_TRA_PRDOPER) + 1);
        end;
      end;
    end;
    if (vDsLstOperEntrada <> '') then begin
      vDsCampo := '';
      putitem(vDsCampo,  'CD_EMPFAT');
      putitem(vDsCampo,  'CD_PRODUTO');
      putitem(vDsCampo,  'TP_SITUACAO');
      putitem(vDsCampo,  'TP_MODALIDADE');
      putitem(vDsCampo,  'TP_OPERACAO');

      vDsCampoValor := '';
      if (vCdEmpresaPRD <> '') then begin
        putitemXml(vDsCampoValor, 'CD_EMPFAT', vCdEmpresaPRD);
      end else begin
        putitemXml(vDsCampoValor, 'CD_EMPFAT', vCdEmpresa);
      end;
      putitemXml(vDsCampoValor, 'CD_PRODUTO', vCdProduto);
      putitemXml(vDsCampoValor, 'TP_SITUACAO', '1);
      putitemXml(vDsCampoValor, 'TP_MODALIDADE', 3);
      putitemXml(vDsCampoValor, 'TP_OPERACAO', 'E');
      voParams := buscaPorPartes(viParams); (* 'V_TRA_PRDOPERSVC', 'CD_OPERACAO', vDsLstOperEntrada, vDsCampo, vDsCampoValor *)
      if (xStatus < 0) then begin
        Result := voParams;
        return(-1); exit;
      end;
      if not (empty(tV_TRA_PRDOPER)) then begin
        setocc(tV_TRA_PRDOPER, 1);
        while (xStatus >= 0) do begin
          vQtVenda := vQtVenda - item_f('QT_SOLICITADA', tV_TRA_PRDOPER);
          setocc(tV_TRA_PRDOPER, curocc(tV_TRA_PRDOPER) + 1);
        end;
      end;
    end;

    vQtPedPendente := vQtPedPendente - vQtPedPendenteAnt;

    vQtOp := 0;
    vQtOPLiberacao := 0;
    vQtOPAndamento := 0;

    if (vNrTinturaria = 1) then begin
      clear_e(tTIN_OTNI);
      putitem_e(tTIN_OTNI, 'CD_EMPRESA', vCdEmpresa);
      putitem_e(tTIN_OTNI, 'CD_PRDDESTINO', vCdProduto);
      retrieve_e(tTIN_OTNI);
      if (xStatus >= 0) then begin
        setocc(tTIN_OTNI, 1);
        while (xStatus >= 0) do begin
          vQtOPAndamento := vQtOPAndamento + item_f('QT_ITEM', tTIN_OTNI) - item_f('QT_BAIXADA', tTIN_OTNI);
          setocc(tTIN_OTNI, curocc(tTIN_OTNI) + 1);
        end;
      end;
    end else begin
      clear_e(tV_PCP_OPPEND);
      if (vCdEmpresaOP <> '') then begin
        putitem_e(tV_PCP_OPPEND, 'CD_EMPRESA', vCdEmpresaOP);
      end else begin
        putitem_e(tV_PCP_OPPEND, 'CD_EMPRESA', vCdEmpresa);
      end;
      putitem_e(tV_PCP_OPPEND, 'CD_PRODUTO', vCdProduto);
      retrieve_e(tV_PCP_OPPEND);
      if (xStatus >= 0) then begin
        setocc(tV_PCP_OPPEND, 1);
        while (xStatus >= 0) do begin
          vQtOp := vQtOp + item_f('QT_PENDENTE', tV_PCP_OPPEND);
          if (item_f('TP_SITUACAO', tV_PCP_OPPEND) = 10) then begin
              vQtOPLiberacao := vQtOPLiberacao + item_f('QT_PENDENTE', tV_PCP_OPPEND);
          end else begin
              vQtOPAndamento := vQtOPAndamento + item_f('QT_PENDENTE', tV_PCP_OPPEND);
          end;
          setocc(tV_PCP_OPPEND, curocc(tV_PCP_OPPEND) + 1);
        end;
      end;
    end;
    if (gprSaldoOpPed > 0) then begin
      vQtOp := vQtOp - (vQtOp *(gprSaldoOpPed / 100));
    end;
    if (gTpValidacaoSaldoPed = 2) then begin
      vQtDisponivel := vQtEstoque + vQtCmpPendente + vQtCompra - vQtPedPendente - vQtVenda;
    end else if (gTpValidacaoSaldoPed = 1) then begin
      vQtDisponivel := vQtEstoque - vQtPedPendente - vQtVenda;
    end else if (gTpValidacaoSaldoPed = 3) then begin
      vQtDisponivel := vQtEstoque + vQtCmpPendente + vQtCompra + vQtOp - vQtPedPendente - vQtVenda;
    end else begin
      vQtDisponivel := vQtEstoque;
    end;

    Result := '';
    putitemXml(Result, 'QT_DISPONIVEL', vQtDisponivel);
    putitemXml(Result, 'QT_CMPPendENTE', vQtCmpPendente);
    putitemXml(Result, 'QT_COMPRA', vQtCompra);
    putitemXml(Result, 'QT_PEDPendENTE', vQtPedPendente);
    putitemXml(Result, 'QT_VendA', vQtVenda);
    putitemXml(Result, 'QT_ESTOQUE', vQtEstoque);
    putitemXml(Result, 'QT_OP', vQtOp);
    putitemXml(Result, 'QT_OPLIBERACAO', vQtOpLiberacao);
    putitemXml(Result, 'QT_OPANDAMENTO', vQtOpAndamento);

    if (vInTotalCmp = True) then begin
      vQtCmpSolicitada := 0;
      vQtCmpAtendida := 0;
      vQtCmpCancelada := 0;
      vQtCmpExtra := 0;

      vDsCampo := '';
      putitem(vDsCampo,  'CD_EMPESTOQUE');
      putitem(vDsCampo,  'CD_EMPRESA');
      putitem(vDsCampo,  'CD_PRODUTO');
      putitem(vDsCampo,  'TP_SITUACAO');

      vDsCampoValor := '';
      if (gTpEmpSaldoCMP = 01) then begin
        if (vCdEmpresaCMP <> '') then begin
          putitemXml(vDsCampoValor, 'CD_EMPESTOQUE', vCdEmpresaCMP);
        end else begin
          putitemXml(vDsCampoValor, 'CD_EMPESTOQUE', vCdEmpresa);
        end;
      end else begin
        if (vCdEmpresaCMP <> '') then begin
          putitemXml(vDsCampoValor, 'CD_EMPRESA', vCdEmpresaCMP);
        end else begin
          putitemXml(vDsCampoValor, 'CD_EMPRESA', vCdEmpresa);
        end;
      end;
      putitemXml(vDsCampoValor, 'CD_PRODUTO', vCdProduto);
      putitemXml(vDsCampoValor, 'TP_SITUACAO', '1);
      voParams := buscaPorPartes(viParams); (* 'V_CMP_PRDOPERSVC', 'CD_OPERACAO', vDsLstOperEntrada, vDsCampo, vDsCampoValor *)
      if (xStatus < 0) then begin
        Result := voParams;
        return(-1); exit;
      end;
      if not (empty(tV_CMP_PRDOPER)) then begin
        setocc(tV_CMP_PRDOPER, 1);
        while (xStatus >= 0) do begin
          vQtCmpSolicitada := vQtCmpSolicitada + item_f('QT_SOLICITADA', tV_CMP_PRDOPER);
          vQtCmpAtendida := vQtCmpAtendida + item_f('QT_ATENDIDA', tV_CMP_PRDOPER);
          vQtCmpCancelada := vQtCmpCancelada + item_f('QT_CANCELADA', tV_CMP_PRDOPER);
          vQtCmpExtra := vQtCmpExtra + item_f('QT_EXTRA', tV_CMP_PRDOPER);
          setocc(tV_CMP_PRDOPER, curocc(tV_CMP_PRDOPER) + 1);
        end;
      end;

      putitemXml(Result, 'QT_CMPSOLICITADA', vQtCmpSolicitada);
      putitemXml(Result, 'QT_CMPATendIDA', vQtCmpAtendida);
      putitemXml(Result, 'QT_CMPCANCELADA', vQtCmpCancelada);
      putitemXml(Result, 'QT_CMPEXTRA', vQtCmpExtra);
    end;
    if (vInTotalPed = True) then begin
      vQtPedSolicitada := 0;
      vQtPedatendida := 0;
      vQtPedCancelada := 0;
      vQtPedExtra := 0;

      vDsCampo := '';
      putitem(vDsCampo,  'CD_EMPRESA');
      putitem(vDsCampo,  'CD_PRODUTO');
      putitem(vDsCampo,  'TP_SITUACAO');

      vDsCampoValor := '';
      if (vCdEmpresaPED <> '') then begin
        putitemXml(vDsCampoValor, 'CD_EMPRESA', vCdEmpresaPED);
      end else begin
        putitemXml(vDsCampoValor, 'CD_EMPRESA', vCdEmpresa);
      end;
      putitemXml(vDsCampoValor, 'CD_PRODUTO', vCdProduto);
      putitemXml(vDsCampoValor, 'TP_SITUACAO', '1);
      voParams := buscaPorPartes(viParams); (* 'V_PED_PRDOPERSVC', 'CD_OPERACAO', vDsLstOperSaida, vDsCampo, vDsCampoValor *)
      if (xStatus < 0) then begin
        Result := voParams;
        return(-1); exit;
      end;
      if not (empty(tV_PED_PRDOPER)) then begin
        setocc(tV_PED_PRDOPER, 1);
        while (xStatus >= 0) do begin
          vQtPedSolicitada := vQtPedSolicitada + item_f('QT_SOLICITADA', tV_PED_PRDOPER);
          vQtPedatendida := vQtPedatendida + item_f('QT_ATENDIDA', tV_PED_PRDOPER);
          vQtPedCancelada := vQtPedCancelada + item_f('QT_CANCELADA', tV_PED_PRDOPER);
          vQtPedExtra := vQtPedExtra + item_f('QT_EXTRA', tV_PED_PRDOPER);
          setocc(tV_PED_PRDOPER, curocc(tV_PED_PRDOPER) + 1);
        end;
      end;

      putitemXml(Result, 'QT_PEDSOLICITADA', vQtPedSolicitada);
      putitemXml(Result, 'QT_PEdatendIDA', vQtPedatendida);
      putitemXml(Result, 'QT_PEDCANCELADA', vQtPedCancelada);
      putitemXml(Result, 'QT_PEDEXTRA', vQtPedExtra);
    end;
    if (vInNecessidade) then begin
      vQtEntrada := 0;

      if (vDsLstOperEntrada <> '') then begin
        vDsCampo := '';
        putitem(vDsCampo,  'CD_EMPFAT');
        putitem(vDsCampo,  'CD_PRODUTO');
        putitem(vDsCampo,  'TP_SITUACAO');
        putitem(vDsCampo,  'TP_OPERACAO');

        vDsCampoValor := '';
        if (vCdEmpresaPRD <> '') then begin
          putitemXml(vDsCampoValor, 'CD_EMPFAT', vCdEmpresaPRD);
        end else begin
          putitemXml(vDsCampoValor, 'CD_EMPFAT', vCdEmpresa);
        end;
        putitemXml(vDsCampoValor, 'CD_PRODUTO', vCdProduto);
        putitemXml(vDsCampoValor, 'TP_SITUACAO', '1);
        putitemXml(vDsCampoValor, 'TP_OPERACAO', 'E');
        voParams := buscaPorPartes(viParams); (* 'V_TRA_PRDOPERSVC', 'CD_OPERACAO', vDsLstOperEntrada, vDsCampo, vDsCampoValor *)
        if (xStatus < 0) then begin
          Result := voParams;
          return(-1); exit;
        end;
        if not (empty(tV_TRA_PRDOPER)) then begin
          setocc(tV_TRA_PRDOPER, 1);
          while (xStatus >= 0) do begin
            vQtEntrada := vQtEntrada + item_f('QT_SOLICITADA', tV_TRA_PRDOPER);
            setocc(tV_TRA_PRDOPER, curocc(tV_TRA_PRDOPER) + 1);
          end;
        end;
      end;

      vQtSaida := 0;

      if (vDsLstOperSaida <> '') then begin
        vDsCampo := '';
        putitem(vDsCampo,  'CD_EMPFAT');
        putitem(vDsCampo,  'CD_PRODUTO');
        putitem(vDsCampo,  'TP_SITUACAO');
        putitem(vDsCampo,  'TP_OPERACAO');

        vDsCampoValor := '';
        if (vCdEmpresaPRD <> '') then begin
          putitemXml(vDsCampoValor, 'CD_EMPFAT', vCdEmpresaPRD);
        end else begin
          putitemXml(vDsCampoValor, 'CD_EMPFAT', vCdEmpresa);
        end;
        putitemXml(vDsCampoValor, 'CD_PRODUTO', vCdProduto);
        putitemXml(vDsCampoValor, 'TP_SITUACAO', '1);
        putitemXml(vDsCampoValor, 'TP_OPERACAO', 'S');
        voParams := buscaPorPartes(viParams); (* 'V_TRA_PRDOPERSVC', 'CD_OPERACAO', vDsLstOperSaida, vDsCampo, vDsCampoValor *)
        if (xStatus < 0) then begin
          Result := voParams;
          return(-1); exit;
        end;
        if not (empty(tV_TRA_PRDOPER)) then begin
          setocc(tV_TRA_PRDOPER, 1);
          while (xStatus >= 0) do begin
              vQtSaida := vQtSaida + item_f('QT_SOLICITADA', tV_TRA_PRDOPER);
            setocc(tV_TRA_PRDOPER, curocc(tV_TRA_PRDOPER) + 1);
          end;
        end;
      end;

      putitemXml(Result, 'QT_ENTRADA', vQtEntrada);
      putitemXml(Result, 'QT_SAIDA', vQtSaida);
    end;
  end;

    clear_e(tPRD_PRDGRADE);
    putitem_e(tPRD_PRDGRADE, 'CD_PRODUTO', vCdProduto);
    retrieve_e(tPRD_PRDGRADE);
  if (xStatus >= 0) then begin
    clear_e(tPRD_GRUPOADIC);
    putitem_e(tPRD_GRUPOADIC, 'CD_SEQGRUPO', item_f('CD_SEQGRUPO', tPRD_PRDGRADE));
    retrieve_e(tPRD_GRUPOADIC);
    if (xStatus >= 0) then begin
      putitemXml(Result, 'CD_NIVEL' item_f('CD_NIVEL', tPRD_GRUPOADIC));
      putitemXml(Result, 'DS_NIVEL' item_a('DS_NIVEL', tPRD_GRUPOADIC));
    end;
  end;

  return(0); exit;
end;

//-----------------------------------------------------------------
function T_PRDSVCO015.verificaSaldoPAMP(pParams : String) : String;
//-----------------------------------------------------------------
const
  cDS_METHOD = 'ADICIONAL=Operação: T_PRDSVCO015.verificaSaldoPAMP()';
var
  viParams, voParams, vDtPeriodoPED, vDtPeriodoCMP, vDsRegistro, vDsLstProdutoMP, vDsLstRelacao : String;
  vCdProdutoPA, vCdCor : String;
  vCdEmpresa, vCdEmpresaPRD, vCdEmpresaPED, vCdEmpresaCMP, vCdGrupoEmpresa, vCdProduto, vQtProdutoPED : Real;
  vCdEmpPedido, vQtCMPPendente, vQtPEDPendente, vQtCalc, vNrPeriodoCMP, vQtDisponivel, vQtMP : Real;
  vCdProdutoRel, vCdTamanho, vQtSaldoMP, vNrCicloCMP : Real;
  vDtPeriodoIni, vDtPeriodoFim, vDtPrevBaixa : TDate;
begin
  vCdEmpresa := itemXmlF('CD_EMPRESA', pParams);
  vCdEmpPedido := itemXmlF('CD_EMPPEDIDO', pParams);
  vCdEmpresaPRD := itemXmlF('CD_EMPRESAPRD', pParams);
  vCdEmpresaPED := itemXmlF('CD_EMPRESAPED', pParams);
  vCdEmpresaCMP := itemXmlF('CD_EMPRESACMP', pParams);
  vCdGrupoEmpresa := itemXmlF('CD_GRUPOEMPRESA', pParams);
  vCdProduto := itemXmlF('CD_PRODUTO', pParams);
  vQtProdutoPED := itemXmlF('QT_ITEMPED', pParams);
  vDtPrevBaixa := itemXml('DT_PREVBAIXA', pParams);
  gTpEmpSaldoCMP := itemXmlF('TP_EMP_SALDO_CMP', PARAM_GLB);

  if (vCdEmpresa = '') then begin
    if (vCdGrupoEmpresa > 0) then begin
      viParams := '';
      putitemXml(viParams, 'CD_GRUPOEMPRESA', vCdGrupoEmpresa);
      putitemXml(viParams, 'IN_VALIDALOCAL', False);
      voParams := activateCmp('GERSVCO032', 'buscaLstGrupoEmpresa', viParams); (*,,,, *)
      if (xStatus < 0) then begin
        Result := voParams;
        return(-1); exit;
      end;
      vCdEmpresa := itemXmlF('CD_EMPRESA', voParams);
    end else begin
      vCdEmpresa := itemXmlF('CD_EMPRESA', PARAM_GLB);
    end;
  end;
  if (vCdEmpresa = '') then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Empresa não informada!', cDS_METHOD);
    return(-1); exit;
  end;
  if (vCdEmpPedido = 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Empresa do pedido não informada!', cDS_METHOD);
    return(-1); exit;
  end;
  if (vCdProduto = 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Produto não informado!', cDS_METHOD);
    return(-1); exit;
  end;
  if (vDtPrevBaixa = '') then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Dt. previsão faturamento não informada!', cDS_METHOD);
    return(-1); exit;
  end;

  viParams := '';
  putitemXml(viParams, 'CD_EMPRESA', vCdEmpPedido);
  putitemXml(viParams, 'DT_PERIODO', vDtPrevBaixa);
  voParams := activateCmp('PEDSVCO010', 'buscaPeriodoPedido', viParams); (*,,,, *)
  if (xStatus < 0) then begin
    Result := voParams;
    return(-1); exit;
  end;
  vDtPeriodoIni := itemXml('DT_INICIO', voParams);
  vDtPeriodoFim := itemXml('DT_FIM', voParams);
  vDtPeriodoPED := '>= ' + vDtPeriodoIni + ' and<= ' + vDtPeriodoFim' + ';
  vNrCicloCMP := itemXmlF('NR_CICLO', voParams);
  vNrPeriodoCMP := itemXmlF('NR_PERIODO', voParams);
  vDtPeriodoCMP := '>= ' + vDtPeriodoIni + ' and<= ' + vDtPeriodoFim' + ';

  viParams := '';

  putitemXml(viParams, 'CD_PRODUTO', vCdProduto);
  putitemXml(viParams, 'TP_RELACIONAMENTO', 1);
  voParams := activateCmp('PCPSVCO001', 'buscaRelProdutos', viParams); (*,,,, *)
  if (xStatus < 0) then begin
    Result := voParams;
    return(-1); exit;
  end;
  vDsLstRelacao := itemXml('DS_LSTRELACAO', voParams);

  if (vDsLstRelacao <> '') then begin
    repeat
      getitem(vDsRegistro, vDsLstRelacao, 1);
      vCdProdutoRel := itemXmlF('CD_PRODUTOREL', vDsRegistro);
      putitem(vCdProduto,  vCdProdutoRel);
      delitem(vDsLstRelacao, 1);
    until (vDsLstRelacao = '');
  end;

  clear_e(tPRD_PRODUTO);

  clear_e(tV_PCP_FC2);
  putitem_e(tV_PCP_FC2, 'CD_PRODUTOPA', vCdProduto);
  putitem_e(tV_PCP_FC2, 'IN_MPOBRIGATORIA', True);
  retrieve_e(tV_PCP_FC2);
  if (xStatus >= 0) then begin
    setocc(tV_PCP_FC2, -1);
    setocc(tV_PCP_FC2, 1);
    while (xStatus >= 0) do begin
      creocc(tPRD_PRODUTO, -1);
      putitem_e(tPRD_PRODUTO, 'CD_PRODUTO', item_f('CD_PRODUTOMP', tV_PCP_FC2));
      retrieve_o(tPRD_PRODUTO);
      if (xStatus = -7) then begin
        retrieve_x(tPRD_PRODUTO);
      end;
      setocc(tV_PCP_FC2, curocc(tV_PCP_FC2) + 1);
    end;
  end else begin
    return(0); exit;
  end;

  vDsLstProdutoMP := '';

  setocc(tPRD_PRODUTO, 1);
  while (xStatus >= 0) do begin

    vQtPEDPendente := 0;
    vQtSaldoMP := 0;

    clear_e(tPED_SALDOMPPE);
    putitem_e(tPED_SALDOMPPE, 'CD_EMPRESA', vCdEmpPedido);
    putitem_e(tPED_SALDOMPPE, 'CD_PRODUTO', item_f('CD_PRODUTO', tPRD_PRODUTO));
    putitem_e(tPED_SALDOMPPE, 'NR_CICLO', vNrCicloCMP);
    putitem_e(tPED_SALDOMPPE, 'NR_PERIODO', vNrPeriodoCMP);
    retrieve_e(tPED_SALDOMPPE);
    if (xStatus >= 0) then begin
      vQtSaldoMP := item_f('QT_SALDO', tPED_SALDOMPPE);
    end;

    clear_e(tV_PCP_FC2);
    putitem_e(tV_PCP_FC2, 'CD_PRODUTOMP', item_f('CD_PRODUTO', tPRD_PRODUTO));
    putitem_e(tV_PCP_FC2, 'IN_MPOBRIGATORIA', True);
    retrieve_e(tV_PCP_FC2);
    if (xStatus >= 0) then begin
      setocc(tV_PCP_FC2, 1);
      while (xStatus >= 0) do begin
        vCdProdutoPA := item_f('CD_PRODUTOPA', tV_PCP_FC2);

        clear_e(tPRD_PRDGRADE);
        putitem_e(tPRD_PRDGRADE, 'CD_PRODUTO', item_f('CD_PRODUTOPA', tV_PCP_FC2));
        retrieve_e(tPRD_PRDGRADE);
        if (xStatus >= 0) then begin
          vCdCor := item_f('CD_COR', tPRD_PRDGRADE);
          vCdTamanho := item_f('CD_TAMANHO', tPRD_PRDGRADE);
          clear_e(tPCP_RELPRD);
          putitem_e(tPCP_RELPRD, 'CD_SEQGRUPOREL', item_f('CD_SEQGRUPO', tPRD_PRDGRADE));
          putitem_e(tPCP_RELPRD, 'CD_CORREL', '0');
          putitem_e(tPCP_RELPRD, 'CD_TAMANHOREL', 0);
          retrieve_e(tPCP_RELPRD);
          if (xStatus >= 0) then begin
            clear_e(tPRD_PRDGRADE);
            putitem_e(tPRD_PRDGRADE, 'CD_SEQGRUPO', item_f('CD_SEQGRUPO', tPCP_RELPRD));
            putitem_e(tPRD_PRDGRADE, 'CD_COR', vCdCor);
            putitem_e(tPRD_PRDGRADE, 'CD_TAMANHO', vCdTamanho);
            retrieve_e(tPRD_PRDGRADE);
            if (xStatus >= 0) then begin
              putitem(vCdProdutoPA,  item_f('CD_PRODUTO', tPRD_PRDGRADE));
            end;
          end;
        end;

        clear_e(tV_PED_PRDPREV);
        if (vCdEmpresaPED <> '') then begin
          putitem_e(tV_PED_PRDPREV, 'CD_EMPRESA', vCdEmpresaPED);
        end else begin
          putitem_e(tV_PED_PRDPREV, 'CD_EMPRESA', vCdEmpresa);
        end;
        putitem_e(tV_PED_PRDPREV, 'CD_PRODUTO', vCdProdutoPA);
        putitem_e(tV_PED_PRDPREV, 'TP_SITUACAO', '1);
        putitem_e(tV_PED_PRDPREV, 'DT_PREVBAIXA', vDtPeriodoPED);
        retrieve_e(tV_PED_PRDPREV);
        if (xStatus >= 0) then begin
          setocc(tV_PED_PRDPREV, 1);
          while (xStatus >= 0) do begin
            vQtCalc := item_f('QT_PENDENTE', tV_PED_PRDPREV) * item_f('QT_CONSUMO', tV_PCP_FC2);
            vQtCalc := rounded(vQtCalc, 3);
            vQtPEDPendente := vQtPEDPendente + vQtCalc;
            setocc(tV_PED_PRDPREV, curocc(tV_PED_PRDPREV) + 1);
          end;
        end;

        setocc(tV_PCP_FC2, curocc(tV_PCP_FC2) + 1);
      end;
    end;

    vQtMP := 0;
    clear_e(tV_PCP_FC2);
    putitem_e(tV_PCP_FC2, 'CD_PRODUTOPA', vCdProduto);
    putitem_e(tV_PCP_FC2, 'CD_PRODUTOMP', item_f('CD_PRODUTO', tPRD_PRODUTO));
    retrieve_e(tV_PCP_FC2);
    if (xStatus >= 0) then begin
      setocc(tV_PCP_FC2, 1);
      while (xStatus >= 0) do begin
        vQtCalc := vQtProdutoPED * item_f('QT_CONSUMO', tV_PCP_FC2);
        vQtMP := vQtMP + rounded(vQtCalc, 3);
        setocc(tV_PCP_FC2, curocc(tV_PCP_FC2) + 1);
      end;
    end;

    vQtDisponivel := vQtSaldoMP - vQtPEDPendente;

    vDsRegistro := '';
    putitemXml(vDsRegistro, 'CD_PRODUTOMP', item_f('CD_PRODUTO', tPRD_PRODUTO));
    putitemXml(vDsRegistro, 'QT_CMPPendENTE', vQtCMPPendente);
    putitemXml(vDsRegistro, 'QT_SALDOMP', vQtSaldoMP);
    putitemXml(vDsRegistro, 'QT_PEDPendENTE', vQtPEDPendente);
    putitemXml(vDsRegistro, 'QT_DISPONIVEL', vQtDisponivel);
    putitemXml(vDsRegistro, 'QT_MP', vQtMP);
    putitem(vDsLstProdutoMP,  vDsRegistro);

    setocc(tPRD_PRODUTO, curocc(tPRD_PRODUTO) + 1);
  end;

  Result := '';
  putitemXml(Result, 'CD_EMPPERIODO', vCdEmpPedido);
  putitemXml(Result, 'NR_CICLO', vNrCicloCMP);
  putitemXml(Result, 'NR_PERIODO', vNrPeriodoCMP);
  putitemXml(Result, 'DS_LSTPRODUTOMP', vDsLstProdutoMP);

  return(0); exit;
end;

//------------------------------------------------------------------
function T_PRDSVCO015.verificaSaldoMPPer(pParams : String) : String;
//------------------------------------------------------------------
const
  cDS_METHOD = 'ADICIONAL=Operação: T_PRDSVCO015.verificaSaldoMPPer()';
var
  viParams, voParams, vDtPeriodoPED, vDtPeriodoCMP, vDsRegistro, vDsLstProdutoMP, vDsLstRelacao : String;
  vCdProdutoPA, vCdCor : String;
  vCdEmpresa, vCdEmpresaPRD, vCdEmpresaPED, vCdEmpresaCMP, vCdGrupoEmpresa, vCdProduto, vQtProdutoPED : Real;
  vQtCMPPendente, vQtPEDPendente, vQtCalc, vNrPeriodoCMP, vQtDisponivel, vQtMP : Real;
  vCdEmpPeriodo, vNrCiclo, vNrPeriodo : Real;
  vCdProdutoRel, vCdTamanho, vQtSaldoMP, vNrCicloCMP : Real;
  vDtPeriodoIni, vDtPeriodoFim : TDate;
begin
  vCdEmpresa := itemXmlF('CD_EMPRESA', pParams);
  vCdEmpresaPRD := itemXmlF('CD_EMPRESAPRD', pParams);
  vCdEmpresaPED := itemXmlF('CD_EMPRESAPED', pParams);
  vCdEmpresaCMP := itemXmlF('CD_EMPRESACMP', pParams);
  vCdProduto := itemXmlF('CD_PRODUTO', pParams);
  vCdEmpPeriodo := itemXmlF('CD_EMPPERIODO', pParams);
  vNrCiclo := itemXmlF('NR_CICLO', pParams);
  vNrPeriodo := itemXmlF('NR_PERIODO', pParams);
  gTpEmpSaldoCMP := itemXmlF('TP_EMP_SALDO_CMP', PARAM_GLB);

  if (vCdEmpresa = '') then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Empresa não informada!', cDS_METHOD);
    return(-1); exit;
  end;
  if (vCdProduto = 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Produto não informado!', cDS_METHOD);
    return(-1); exit;
  end;
  if (vCdEmpPeriodo = 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Empresa do período não informada!', cDS_METHOD);
    return(-1); exit;
  end;
  if (vNrCiclo = 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Ciclo não informado!', cDS_METHOD);
    return(-1); exit;
  end;
  if (vNrPeriodo = 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Período não informado!', cDS_METHOD);
    return(-1); exit;
  end;

  clear_e(tPED_PERIODO);
  putitem_e(tPED_PERIODO, 'CD_EMPRESA', vCdEmpPeriodo);
  putitem_e(tPED_PERIODO, 'NR_CICLO', vNrCiclo);
  putitem_e(tPED_PERIODO, 'NR_PERIODO', vNrPeriodo);
  retrieve_e(tPED_PERIODO);
  if (xStatus < 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Período gModulo.vCdEmpPeriodo / ' + FloatToStr(vNrCiclo) + ' / ' + FloatToStr(vNrPeriodo) + ' não cadastrado!', cDS_METHOD);
    return(-1); exit;
  end;
  vDtPeriodoPED := '>= ' + DT_INICIO + '.PED_PERIODO and<= ' + DT_FIM + '.PED_PERIODO';
  vNrCicloCMP := vNrCiclo;
  vNrPeriodoCMP := vNrPeriodo;
  vDtPeriodoIni := item_a('DT_INICIO', tPED_PERIODO);
  vDtPeriodoFim := item_a('DT_FIM', tPED_PERIODO);
  vDtPeriodoCMP := '>= ' + vDtPeriodoIni + ' and<= ' + vDtPeriodoFim' + ';

  vQtCMPPendente := 0;
  vQtPEDPendente := 0;
  vQtSaldoMP := 0;

  clear_e(tV_CMP_PRDPREV);
  if (gTpEmpSaldoCMP = 01) then begin
    if (vCdEmpresaCMP <> '') then begin
      putitem_e(tV_CMP_PRDPREV, 'CD_EMPESTOQUE', vCdEmpresaCMP);
    end else begin
      putitem_e(tV_CMP_PRDPREV, 'CD_EMPESTOQUE', vCdEmpresa);
    end;
  end else begin
    if (vCdEmpresaCMP <> '') then begin
      putitem_e(tV_CMP_PRDPREV, 'CD_EMPRESA', vCdEmpresaCMP);
    end else begin
      putitem_e(tV_CMP_PRDPREV, 'CD_EMPRESA', vCdEmpresa);
    end;
  end;
  putitem_e(tV_CMP_PRDPREV, 'CD_PRODUTO', vCdProduto);
  putitem_e(tV_CMP_PRDPREV, 'TP_SITUACAO', '1);
  putitem_e(tV_CMP_PRDPREV, 'DT_LIMENTREGAC', vDtPeriodoCMP);
  retrieve_e(tV_CMP_PRDPREV);
  if (xStatus >= 0) then begin
    setocc(tV_CMP_PRDPREV, 1);
    while (xStatus >= 0) do begin
      vQtCMPPendente := vQtCMPPendente + item_f('QT_PENDENTE', tV_CMP_PRDPREV);
      setocc(tV_CMP_PRDPREV, curocc(tV_CMP_PRDPREV) + 1);
    end;
  end;
  if (vQtCMPPendente = 0) then begin
    clear_e(tPED_SALDOMPPE);
    putitem_e(tPED_SALDOMPPE, 'CD_EMPRESA', vCdEmpPeriodo);
    putitem_e(tPED_SALDOMPPE, 'CD_PRODUTO', vCdProduto);
    putitem_e(tPED_SALDOMPPE, 'NR_CICLO', vNrCicloCMP);
    putitem_e(tPED_SALDOMPPE, 'NR_PERIODO', vNrPeriodoCMP);
    retrieve_e(tPED_SALDOMPPE);
    if (xStatus >= 0) then begin
      vQtSaldoMP := item_f('QT_SALDO', tPED_SALDOMPPE);
    end;
  end;

  clear_e(tV_PCP_FC2);
  putitem_e(tV_PCP_FC2, 'CD_PRODUTOMP', vCdProduto);
  putitem_e(tV_PCP_FC2, 'IN_MPOBRIGATORIA', True);
  retrieve_e(tV_PCP_FC2);
  if (xStatus >= 0) then begin
    setocc(tV_PCP_FC2, 1);
    while (xStatus >= 0) do begin
      vCdProdutoPA := item_f('CD_PRODUTOPA', tV_PCP_FC2);

      clear_e(tPRD_PRDGRADE);
      putitem_e(tPRD_PRDGRADE, 'CD_PRODUTO', item_f('CD_PRODUTOPA', tV_PCP_FC2));
      retrieve_e(tPRD_PRDGRADE);
      if (xStatus >= 0) then begin
        vCdCor := item_f('CD_COR', tPRD_PRDGRADE);
        vCdTamanho := item_f('CD_TAMANHO', tPRD_PRDGRADE);
        clear_e(tPCP_RELPRD);
        putitem_e(tPCP_RELPRD, 'CD_SEQGRUPOREL', item_f('CD_SEQGRUPO', tPRD_PRDGRADE));
        putitem_e(tPCP_RELPRD, 'CD_CORREL', '0');
        putitem_e(tPCP_RELPRD, 'CD_TAMANHOREL', 0);
        retrieve_e(tPCP_RELPRD);
        if (xStatus >= 0) then begin
          clear_e(tPRD_PRDGRADE);
          putitem_e(tPRD_PRDGRADE, 'CD_SEQGRUPO', item_f('CD_SEQGRUPO', tPCP_RELPRD));
          putitem_e(tPRD_PRDGRADE, 'CD_COR', vCdCor);
          putitem_e(tPRD_PRDGRADE, 'CD_TAMANHO', vCdTamanho);
          retrieve_e(tPRD_PRDGRADE);
          if (xStatus >= 0) then begin
            putitem(vCdProdutoPA,  item_f('CD_PRODUTO', tPRD_PRDGRADE));
          end;
        end;
      end;

      clear_e(tV_PED_PRDPREV);
      if (vCdEmpresaPED <> '') then begin
        putitem_e(tV_PED_PRDPREV, 'CD_EMPRESA', vCdEmpresaPED);
      end else begin
        putitem_e(tV_PED_PRDPREV, 'CD_EMPRESA', vCdEmpresa);
      end;
      putitem_e(tV_PED_PRDPREV, 'CD_PRODUTO', vCdProdutoPA);
      putitem_e(tV_PED_PRDPREV, 'TP_SITUACAO', '1);
      putitem_e(tV_PED_PRDPREV, 'DT_PREVBAIXA', vDtPeriodoPED);
      retrieve_e(tV_PED_PRDPREV);
      if (xStatus >= 0) then begin
        setocc(tV_PED_PRDPREV, 1);
        while (xStatus >= 0) do begin
          vQtCalc := item_f('QT_PENDENTE', tV_PED_PRDPREV) * item_f('QT_CONSUMO', tV_PCP_FC2);
          vQtCalc := rounded(vQtCalc, 3);
          vQtPEDPendente := vQtPEDPendente + vQtCalc;
          setocc(tV_PED_PRDPREV, curocc(tV_PED_PRDPREV) + 1);
        end;
      end;

      setocc(tV_PCP_FC2, curocc(tV_PCP_FC2) + 1);
    end;
  end;

  vQtDisponivel := vQtCMPPendente + vQtSaldoMP - vQtPEDPendente;

  Result := '';
  putitemXml(Result, 'QT_CMPPendENTE', vQtCMPPendente);
  putitemXml(Result, 'QT_SALDOMP', vQtSaldoMP);
  putitemXml(Result, 'QT_PEDPendENTE', vQtPEDPendente);
  putitemXml(Result, 'QT_DISPONIVEL', vQtDisponivel);

  return(0); exit;
end;

//----------------------------------------------------------------------------
function T_PRDSVCO015.verificaSaldoPlanejamentoCor(pParams : String) : String;
//----------------------------------------------------------------------------
const
  cDS_METHOD = 'ADICIONAL=Operação: T_PRDSVCO015.verificaSaldoPlanejamentoCor()';
var
  vCdEmpresa, viParams, voParams, vDsLstOperSaida, vCdEmpresaPED, vDsCampoValor, vDsCampo : String;
  vCdProduto, vQtPedPendente, vQtDisponivel : Real;
  vCdOperacao, vCdSaldoOperacao, vQtPedPendenteAnt, vQtLote : Real;
  vInValidaLocal : Boolean;
begin
  vCdEmpresa := itemXmlF('CD_EMPRESA', pParams);
  vCdEmpresaPED := itemXmlF('CD_EMPRESAPED', pParams);
  vCdProduto := itemXmlF('CD_PRODUTO', pParams);
  vQtPedPendenteAnt := itemXmlF('QT_PEDPendENTEANT', pParams);
  vCdOperacao := itemXmlF('CD_OPERACAO', pParams);
  vInValidaLocal := itemXmlB('IN_VALIDALOCAL', pParams);

  gCdSaldo := itemXmlF('CD_SALDOPADRAO', pParams);
  gTpValidacaoSaldoPed := itemXmlF('TP_VALIDACAO_SALDO_PED', pParams);
  gTpEmpSaldoCMP := itemXmlF('TP_EMP_SALDO_CMP', PARAM_GLB);

  if (vCdEmpresa = '') then begin
    vCdEmpresa := itemXmlF('CD_EMPRESA', PARAM_GLB);
  end;
  if (vCdEmpresa = '') then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Empresa não informada!', cDS_METHOD);
    return(-1); exit;
  end;

  vDsLstOperSaida := '';

  if (vCdOperacao > 0) then begin
    vCdSaldoOperacao := '';
    clear_e(tGER_OPERACAO);
    putitem_e(tGER_OPERACAO, 'CD_OPERACAO', vCdOperacao);
    retrieve_e(tGER_OPERACAO);
    if (xStatus < 0) then begin
      Result := SetStatus(STS_ERROR, 'GEN0001', 'Operação %vCdOperacao não cadastrada!', cDS_METHOD);
      return(-1); exit;
    end;

    clear_e(tGER_OPERSALDO);
    putitem_e(tGER_OPERSALDO, 'IN_PADRAO', True);
    retrieve_e(tGER_OPERSALDO);
    if (xStatus >= 0) then begin
      vCdSaldoOperacao := item_f('CD_SALDO', tGER_OPERSALDO);
    end else begin
      clear_e(tGER_OPERSALDO);
      retrieve_e(tGER_OPERSALDO);
      if (xStatus >= 0) then begin
        vCdSaldoOperacao := item_f('CD_SALDO', tGER_OPERSALDO);
      end else begin
        clear_e(tGER_OPERSALDO);
      end;
    end;
  end;
  if (vCdSaldoOperacao = '') then begin
    vCdSaldoOperacao := gCdSaldo;
  end;

  clear_e(tTMP_NR09);

  if (vCdSaldoOperacao > 0) then begin
    clear_e(tPRD_TPSALDOF);
    putitem_e(tPRD_TPSALDOF, 'CD_SALDO', vCdSaldoOperacao);
    retrieve_e(tPRD_TPSALDOF);
    if (xStatus >= 0) then begin
      setocc(tPRD_TPSALDOF, 1);
      while (xStatus >= 0) do begin
        if (item_f('TP_OPERACAO', tPRD_TPSALDOF) = 1) then begin
          Result := SetStatus(STS_ERROR, 'GEN0001', 'Tipo de saldo ' + FloatToStr(vCdSaldoOperacao) + ' possui saldos em sua composição com operação de subtração que é incompatível com esta rotina!', cDS_METHOD);
          return(-1); exit;
        end;
        creocc(tTMP_NR09, -1);
        putitem_e(tTMP_NR09, 'NR_GERAL', item_f('CD_SALDOF', tPRD_TPSALDOF));
        retrieve_o(tTMP_NR09);
        setocc(tPRD_TPSALDOF, curocc(tPRD_TPSALDOF) + 1);
      end;
    end;
    creocc(tTMP_NR09, -1);
    putitem_e(tTMP_NR09, 'NR_GERAL', vCdSaldoOperacao);
    retrieve_o(tTMP_NR09);

    clear_e(tGER_OPERACAO);
    putitem_e(tGER_OPERACAO, 'TP_OPERACAO', 'S');
    putitem_e(tGER_OPERACAO, 'IN_KARDEX', True);
    putitem_e(tGER_OPERACAO, 'CD_OPERFAT', '>0');
    retrieve_e(tGER_OPERACAO);
    if (xStatus >= 0) then begin
      setocc(tGER_OPERACAO, 1);
      while (xStatus >= 0) do begin

        creocc(tTMP_NR09, -1);
        putitem_e(tTMP_NR09, 'NR_GERAL', item_f('CD_SALDO', tGER_OPERSALDO));
        retrieve_o(tTMP_NR09);
        if (xStatus = 4) then begin
          putitem(vDsLstOperSaida,  item_f('CD_OPERACAO', tGER_OPERACAO));
        end else begin
          discard(tTMP_NR09);
        end;

        setocc(tGER_OPERACAO, curocc(tGER_OPERACAO) + 1);
      end;
    end;
  end;

  vQtPedPendente := 0;

  clear_e(tPRD_PRDGRADE);
  putitem_e(tPRD_PRDGRADE, 'CD_PRODUTO', vCdProduto);
  retrieve_e(tPRD_PRDGRADE);
  if (xStatus >= 0) then begin
    vDsCampo := '';
    putitem(vDsCampo,  'CD_EMPRESA');
    putitem(vDsCampo,  'CD_SEQGRUPO');
    putitem(vDsCampo,  'CD_COR');

    vDsCampoValor := '';
    if (vCdEmpresaPED <> '') then begin
      putitemXml(vDsCampoValor, 'CD_EMPRESA', vCdEmpresaPED);
    end else begin
      putitemXml(vDsCampoValor, 'CD_EMPRESA', vCdEmpresa);
    end;
    putitemXml(vDsCampoValor, 'CD_SEQGRUPO', item_f('CD_SEQGRUPO', tPRD_PRDGRADE));
    putitemXml(vDsCampoValor, 'CD_COR', item_f('CD_COR', tPRD_PRDGRADE));
    voParams := buscaPorPartes(viParams); (* 'V_PED_COROPERSVC', 'CD_OPERACAO', vDsLstOperSaida, vDsCampo, vDsCampoValor *)
    if (xStatus < 0) then begin
      Result := voParams;
      return(-1); exit;
    end;
    if not (empty(tV_PED_COROPER)) then begin
      setocc(tV_PED_COROPER, 1);
      while (xStatus >= 0) do begin
        vQtPedPendente := vQtPedPendente + item_f('QT_PENDENTE', tV_PED_COROPER);
        setocc(tV_PED_COROPER, curocc(tV_PED_COROPER) + 1);
      end;
    end;

    vQtPedPendente := vQtPedPendente - vQtPedPendenteAnt;

    clear_e(tV_PCP_LOTEPLC);
    putitem_e(tV_PCP_LOTEPLC, 'CD_EMPRESA', vCdEmpresa);
    putitem_e(tV_PCP_LOTEPLC, 'TP_SITUACAO', 1);
    putitem_e(tV_PCP_LOTEPLC, 'TP_LOTE', 1);
    putitem_e(tV_PCP_LOTEPLC, 'CD_SEQGRUPO', item_f('CD_SEQGRUPO', tPRD_PRDGRADE));
    putitem_e(tV_PCP_LOTEPLC, 'CD_COR', item_f('CD_COR', tPRD_PRDGRADE));
    retrieve_e(tV_PCP_LOTEPLC);
    if (xStatus >= 0) then begin
      setocc(tV_PCP_LOTEPLC, 1);
      while (xStatus >= 0) do begin
        vQtLote := vQtLote + item_f('QT_LOTE', tV_PCP_LOTEPLC);
        setocc(tV_PCP_LOTEPLC, curocc(tV_PCP_LOTEPLC) + 1);
      end;
    end;
  end;

  vQtDisponivel := vQtLote - vQtPedPendente;

  Result := '';
  putitemXml(Result, 'QT_DISPONIVEL', vQtDisponivel);
  putitemXml(Result, 'QT_LOTE', vQtLote);
  putitemXml(Result, 'QT_PEDPendENTE', vQtPedPendente);

  return(0); exit;
end;

//--------------------------------------------------------------------
function T_PRDSVCO015.verificaSaldoReserva(pParams : String) : String;
//--------------------------------------------------------------------
const
  cDS_METHOD = 'ADICIONAL=Operação: T_PRDSVCO015.verificaSaldoReserva()';
var
  vCdEmpresa : String;
  vCdProduto, vCdSaldo, vQtSaldo, vQtSaldoCmp, vQtSaldoEstoque, vQtSaldoOp, vQtSaldoCancelada, vQtSaldoBaixa, vTpSituacao : Real;
begin
  vCdEmpresa := itemXmlF('CD_EMPRESA', pParams);
  vCdProduto := itemXmlF('CD_PRODUTO', pParams);

  vQtSaldo := 0;

  vTpSituacao := itemXmlF('TP_SITUACAO', pParams);
  vQtSaldoCmp := 0;
  vQtSaldoEstoque := 0;
  vQtSaldoOp := 0;
  vQtSaldoCancelada := 0;
  vQtSaldoBaixa := 0;

  if (vCdEmpresa = '') then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Empresa não informada!', cDS_METHOD);
    return(-1); exit;
  end;
  if (vCdProduto = 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Produto não informado!', cDS_METHOD);
    return(-1); exit;
  end;

  clear_e(tV_PRD_RESERVA);
  putitem_e(tV_PRD_RESERVA, 'CD_EMPRESA', vCdEmpresa);
  putitem_e(tV_PRD_RESERVA, 'CD_PRODUTO', vCdProduto);
  putitem_e(tV_PRD_RESERVA, 'TP_SITUACAO', vTpSituacao);
  retrieve_e(tV_PRD_RESERVA);
  if (xStatus >= 0) then begin
    setocc(tV_PRD_RESERVA, 1);
    while(xStatus >= 0) do begin

      vQtSaldoCmp := vQtSaldoCmp + item_f('QT_PEDIDOCMP', tV_PRD_RESERVA);
      vQtSaldoEstoque := vQtSaldoEstoque + item_f('QT_ESTOQUE', tV_PRD_RESERVA);
      vQtSaldoOp := vQtSaldoOp + item_f('QT_OP', tV_PRD_RESERVA);
      vQtSaldoCancelada := vQtSaldoCancelada + item_f('QT_CANCELADA', tV_PRD_RESERVA);
      vQtSaldoBaixa := vQtSaldoBaixa + item_f('QT_BAIXA', tV_PRD_RESERVA);

      setocc(tV_PRD_RESERVA, curocc(tV_PRD_RESERVA) + 1);
    end;
  end;

  vQtSaldo := vQtSaldoCmp + vQtSaldoEstoque + vQtSaldoOp;

  putitemXml(Result, 'QT_SALDO', vQtSaldo);
  putitemXml(Result, 'QT_PEDIDOCMP', vQtSaldoCmp);
  putitemXml(Result, 'QT_ESTOQUE', vQtSaldoEstoque);
  putitemXml(Result, 'QT_OP', vQtSaldoOp);
  putitemXml(Result, 'QT_CANCELADA', vQtSaldoCancelada);
  putitemXml(Result, 'QT_BAIXA', vQtSaldoBaixa);

  return(0); exit;
end;

//--------------------------------------------------------------------
function T_PRDSVCO015.buscaSaldoProdutoCMP(pParams : String) : String;
//--------------------------------------------------------------------
const
  cDS_METHOD = 'ADICIONAL=Operação: T_PRDSVCO015.buscaSaldoProdutoCMP()';
var
  vCdProduto, vQtEntrada, vQtCmpPendente : Real;
  vDsLstPedCMP, vDsRegistro, vDsLstEmpresa, vDsLstOperEntrada, vDsCampo, vDsCampoValor : String;
begin
  vCdProduto := itemXmlF('CD_PRODUTO', pParams);
  vDsLstPedCMP := itemXml('DS_LSTPEDCMP', pParams);
  vDsLstEmpresa= itemXmlF('CD_EMPRESA', pParams);

  if (vCdProduto = 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Produto não informado!', cDS_METHOD);
    return(-1); exit;
  end;
  if (vDsLstEmpresa = 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Empresa não informada!', cDS_METHOD);
    return(-1); exit;
  end;

  clear_e(tGER_OPERACAO);
  putitem_e(tGER_OPERACAO, 'TP_OPERACAO', 'E');
  putitem_e(tGER_OPERACAO, 'IN_KARDEX', True);
  putitem_e(tGER_OPERACAO, 'CD_OPERFAT', '>0');
  retrieve_e(tGER_OPERACAO);
  if (xStatus >= 0) then begin
    setocc(tGER_OPERACAO, 1);
    while (xStatus >= 0) do begin
      putitem(vDsLstOperEntrada,  item_f('CD_OPERACAO', tGER_OPERACAO));

      setocc(tGER_OPERACAO, curocc(tGER_OPERACAO) + 1);
    end;
  end;

  vDsCampo := '';
  putitem(vDsCampo,  'CD_EMPFAT');
  putitem(vDsCampo,  'CD_PRODUTO');
  putitem(vDsCampo,  'TP_SITUACAO');
  putitem(vDsCampo,  'TP_OPERACAO');

  vDsCampoValor := '';
  putitemXml(vDsCampoValor, 'CD_EMPFAT', vDsLstEmpresa);
  putitemXml(vDsCampoValor, 'CD_PRODUTO', vCdProduto);
  putitemXml(vDsCampoValor, 'TP_SITUACAO', '1);
  putitemXml(vDsCampoValor, 'TP_OPERACAO', 'E');
  voParams := buscaPorPartes(viParams); (* 'V_TRA_PRDOPERSVC', 'CD_OPERACAO', vDsLstOperEntrada, vDsCampo, vDsCampoValor *)
  if (xStatus < 0) then begin
    Result := voParams;
    return(-1); exit;
  end;

  if not (empty(tV_TRA_PRDOPER)) then begin
    setocc(tV_TRA_PRDOPER, 1);
    while (xStatus >= 0) do begin
      vQtEntrada := vQtEntrada + item_f('QT_SOLICITADA', tV_TRA_PRDOPER);
      setocc(tV_TRA_PRDOPER, curocc(tV_TRA_PRDOPER) + 1);
    end;
  end;

  repeat
    getitem(vDsRegistro, vDsLstPedCMP, 1);

    vDsCampo := '';
    putitem(vDsCampo,  'CD_EMPESTOQUE');
    putitem(vDsCampo,  'CD_EMPRESA');
    putitem(vDsCampo,  'CD_PEDIDO');
    putitem(vDsCampo,  'CD_PRODUTO');
    putitem(vDsCampo,  'TP_SITUACAO');

    vDsCampoValor := '';
    putitemXml(vDsCampoValor, 'CD_EMPESTOQUE', vDsLstEmpresa);
    putitemXml(vDsCampoValor, 'CD_EMPRESA', itemXmlF('CD_EMPRESA', vDsRegistro));
    putitemXml(vDsCampoValor, 'CD_PEDIDO', itemXmlF('CD_PEDIDO', vDsRegistro));
    putitemXml(vDsCampoValor, 'CD_PRODUTO', vCdProduto);
    putitemXml(vDsCampoValor, 'TP_SITUACAO', '1);
    voParams := buscaPorPartes(viParams); (* 'V_CMP_PEDIDOISVC', 'CD_OPERACAO', vDsLstOperEntrada, vDsCampo, vDsCampoValor *)
    if (xStatus < 0) then begin
      Result := voParams;
      return(-1); exit;
    end;
    if not (empty(tV_CMP_PEDIDOI)) then begin
      setocc(tV_CMP_PEDIDOI, 1);
      while (xStatus >= 0) do begin
        vQtCmpPendente := vQtCmpPendente + item_f('QT_PENDENTE', tV_CMP_PEDIDOI);
        setocc(tV_CMP_PEDIDOI, curocc(tV_CMP_PEDIDOI) + 1);
      end;
    end;

    putitemXml(Result, 'QT_COMPRA', vQtEntrada);
    putitemXml(Result, 'QT_CMPPendENTE', vQtCmpPendente);

    delitem(vDsLstPedCMP, 1);
  until(vDsLstPedCMP = '');
  return(0); exit;
end;

//-------------------------------------------------------------------
function T_PRDSVCO015.retornaDadosPedidoG(pParams : String) : String;
//-------------------------------------------------------------------
const
  cDS_METHOD = 'ADICIONAL=Operação: T_PRDSVCO015.retornaDadosPedidoG()';
var
  vCdEmpresa, vNrTransacao, vCdProduto, vCdSeqGrupo : Real;
  viParams, voParams, vDsPedidoTra, vDsDesconto, vDsAgendamento : String;
  vDtTransacao, vDtAgendamento : TDate;
begin
  vCdEmpresa := itemXmlF('CD_EMPRESA', pParams);
  vNrTransacao := itemXmlF('NR_TRANSACAO', pParams);
  vDtTransacao := itemXml('DT_TRANSACAO', pParams);
  vCdProduto := itemXmlF('CD_PRODUTO', pParams);
  vCdSeqGrupo := itemXmlF('CD_SEQGRUPO', pParams);

  if (vCdEmpresa = 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Empresa do pedido não informada!', cDS_METHOD);
    return(-1); exit;
  end;
  if (vNrTransacao = 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Número da transação não informada!', cDS_METHOD);
    return(-1); exit;
  end;
  if (vDtTransacao = 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Data da transação não informada!', cDS_METHOD);
    return(-1); exit;
  end;
  if (vCdProduto = 0)  and (vCdSeqGrupo = 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Produto não informado!', cDS_METHOD);
    return(-1); exit;
  end;
  if (vCdSeqGrupo = 0) then begin
    clear_e(tPRD_PRDGRADE);
    putitem_e(tPRD_PRDGRADE, 'CD_PRODUTO', vCdProduto);
    retrieve_e(tPRD_PRDGRADE);
    if (xStatus >= 0) then begin
      vCdSeqGrupo := item_f('CD_SEQGRUPO', tPRD_PRDGRADE);
    end;
  end;

  Result := '';

  if (vCdSeqGrupo = 0) then begin
    return(0); exit;
  end;

  clear_e(tPED_PEDIDOTRA);
  putitem_e(tPED_PEDIDOTRA, 'CD_EMPTRANSACAO', vCdEmpresa);
  putitem_e(tPED_PEDIDOTRA, 'NR_TRANSACAO', vNrTransacao);
  putitem_e(tPED_PEDIDOTRA, 'DT_TRANSACAO', vDtTransacao);
  retrieve_e(tPED_PEDIDOTRA);
  if (xStatus >= 0) then begin
    clear_e(tPED_PEDIDOG);
    putitem_e(tPED_PEDIDOG, 'CD_EMPRESA', item_f('CD_EMPPEDIDO', tPED_PEDIDOTRA));
    putitem_e(tPED_PEDIDOG, 'CD_PEDIDO', item_f('CD_PEDIDO', tPED_PEDIDOTRA));
    putitem_e(tPED_PEDIDOG, 'CD_SEQGRUPO', vCdSeqGrupo);
    retrieve_e(tPED_PEDIDOG);
    if (xStatus >= 0) then begin
      putitemXml(Result, 'NR_SEQUENCIA', item_f('NR_SEQUENCIA', tPED_PEDIDOG));
      putitemXml(Result, 'CD_NIVELFAT', item_f('CD_NIVELFAT', tPED_PEDIDOG));
      putitemXml(Result, 'DS_NIVELFAT', item_a('DS_NIVELFAT', tPED_PEDIDOG));
    end;
  end;

  return(0); exit;
end;

//-----------------------------------------------------------------------------
function T_PRDSVCO015.verificaSaldoPlanejamentoItem(pParams : String) : String;
//-----------------------------------------------------------------------------
const
  cDS_METHOD = 'ADICIONAL=Operação: T_PRDSVCO015.verificaSaldoPlanejamentoItem()';
var
  vCdEmpresa, viParams, voParams, vDsLstOperSaida, vCdEmpresaPED, vDsCampoValor, vDsCampo : String;
  vCdProduto, vQtPedPendente, vQtDisponivel : Real;
  vCdOperacao, vCdSaldoOperacao, vQtPedPendenteAnt, vQtLote : Real;
  vInValidaLocal : Boolean;
begin
  vCdEmpresa := itemXmlF('CD_EMPRESA', pParams);
  vCdEmpresaPED := itemXmlF('CD_EMPRESAPED', pParams);
  vCdProduto := itemXmlF('CD_PRODUTO', pParams);
  vQtPedPendenteAnt := itemXmlF('QT_PEDPendENTEANT', pParams);
  vCdOperacao := itemXmlF('CD_OPERACAO', pParams);
  vInValidaLocal := itemXmlB('IN_VALIDALOCAL', pParams);

  gCdSaldo := itemXmlF('CD_SALDOPADRAO', pParams);
  gTpValidacaoSaldoPed := itemXmlF('TP_VALIDACAO_SALDO_PED', pParams);
  gTpEmpSaldoCMP := itemXmlF('TP_EMP_SALDO_CMP', PARAM_GLB);

  if (vCdEmpresa = '') then begin
    vCdEmpresa := itemXmlF('CD_EMPRESA', PARAM_GLB);
  end;
  if (vCdEmpresa = '') then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Empresa não informada!', cDS_METHOD);
    return(-1); exit;
  end;

  vDsLstOperSaida := '';

  if (vCdOperacao > 0) then begin
    vCdSaldoOperacao := '';
    clear_e(tGER_OPERACAO);
    putitem_e(tGER_OPERACAO, 'CD_OPERACAO', vCdOperacao);
    retrieve_e(tGER_OPERACAO);
    if (xStatus < 0) then begin
      Result := SetStatus(STS_ERROR, 'GEN0001', 'Operação %vCdOperacao não cadastrada!', cDS_METHOD);
      return(-1); exit;
    end;

    clear_e(tGER_OPERSALDO);
    putitem_e(tGER_OPERSALDO, 'IN_PADRAO', True);
    retrieve_e(tGER_OPERSALDO);
    if (xStatus >= 0) then begin
      vCdSaldoOperacao := item_f('CD_SALDO', tGER_OPERSALDO);
    end else begin
      clear_e(tGER_OPERSALDO);
      retrieve_e(tGER_OPERSALDO);
      if (xStatus >= 0) then begin
        vCdSaldoOperacao := item_f('CD_SALDO', tGER_OPERSALDO);
      end else begin
        clear_e(tGER_OPERSALDO);
      end;
    end;
  end;
  if (vCdSaldoOperacao = '') then begin
    vCdSaldoOperacao := gCdSaldo;
  end;

  clear_e(tTMP_NR09);

  if (vCdSaldoOperacao > 0) then begin
    clear_e(tPRD_TPSALDOF);
    putitem_e(tPRD_TPSALDOF, 'CD_SALDO', vCdSaldoOperacao);
    retrieve_e(tPRD_TPSALDOF);
    if (xStatus >= 0) then begin
      setocc(tPRD_TPSALDOF, 1);
      while (xStatus >= 0) do begin
        if (item_f('TP_OPERACAO', tPRD_TPSALDOF) = 1) then begin
          Result := SetStatus(STS_ERROR, 'GEN0001', 'Tipo de saldo ' + FloatToStr(vCdSaldoOperacao) + ' possui saldos em sua composição com operação de subtração que é incompatível com esta rotina!', cDS_METHOD);
          return(-1); exit;
        end;
        creocc(tTMP_NR09, -1);
        putitem_e(tTMP_NR09, 'NR_GERAL', item_f('CD_SALDOF', tPRD_TPSALDOF));
        retrieve_o(tTMP_NR09);
        setocc(tPRD_TPSALDOF, curocc(tPRD_TPSALDOF) + 1);
      end;
    end;
    creocc(tTMP_NR09, -1);
    putitem_e(tTMP_NR09, 'NR_GERAL', vCdSaldoOperacao);
    retrieve_o(tTMP_NR09);

    clear_e(tGER_OPERACAO);
    putitem_e(tGER_OPERACAO, 'TP_OPERACAO', 'S');
    putitem_e(tGER_OPERACAO, 'IN_KARDEX', True);
    putitem_e(tGER_OPERACAO, 'CD_OPERFAT', '>0');
    retrieve_e(tGER_OPERACAO);
    if (xStatus >= 0) then begin
      setocc(tGER_OPERACAO, 1);
      while (xStatus >= 0) do begin
        creocc(tTMP_NR09, -1);
        putitem_e(tTMP_NR09, 'NR_GERAL', item_f('CD_SALDO', tGER_OPERSALDO));
        retrieve_o(tTMP_NR09);
        if (xStatus = 4) then begin
          putitem(vDsLstOperSaida,  item_f('CD_OPERACAO', tGER_OPERACAO));
        end else begin
          discard(tTMP_NR09);
        end;

        setocc(tGER_OPERACAO, curocc(tGER_OPERACAO) + 1);
      end;
    end;
  end;

  vQtPedPendente := 0;

  clear_e(tV_PED_PRDSALD);
  if (vCdEmpresaPED <> '') then begin
    putitem_e(tV_PED_PRDSALD, 'CD_EMPRESA', vCdEmpresaPED);
  end else begin
    putitem_e(tV_PED_PRDSALD, 'CD_EMPRESA', vCdEmpresa);
  end;
  putitem_e(tV_PED_PRDSALD, 'CD_PRODUTO', vCdProduto);
  putitem_e(tV_PED_PRDSALD, 'TP_SITUACAO', '1);
  retrieve_e(tV_PED_PRDSALD);
  if (xStatus >= 0) then begin
    setocc(tV_PED_PRDSALD, 1);
    while (xStatus >= 0) do begin
      vQtPedPendente := vQtPedPendente + item_f('QT_PENDENTE', tV_PED_PRDSALD);
      setocc(tV_PED_PRDSALD, curocc(tV_PED_PRDSALD) + 1);
    end;
  end;

  vQtPedPendente := vQtPedPendente - vQtPedPendenteAnt;

  clear_e(tV_PCP_LOTEPL);
  putitem_e(tV_PCP_LOTEPL, 'CD_EMPRESA', vCdEmpresa);
  putitem_e(tV_PCP_LOTEPL, 'CD_PRODUTO', vCdProduto);
  retrieve_e(tV_PCP_LOTEPL);
  if (xStatus >= 0) then begin
    setocc(tV_PCP_LOTEPL, 1);
    while (xStatus >= 0) do begin
      vQtLote := vQtLote + item_f('QT_LOTE', tV_PCP_LOTEPL);
      setocc(tV_PCP_LOTEPL, curocc(tV_PCP_LOTEPL) + 1);
    end;
  end;

  vQtDisponivel := vQtLote - vQtPedPendente;

  Result := '';
  putitemXml(Result, 'QT_DISPONIVEL', vQtDisponivel);
  putitemXml(Result, 'QT_LOTE', vQtLote);
  putitemXml(Result, 'QT_PEDPendENTE', vQtPedPendente);

  return(0); exit;
end;

//----------------------------------------------------------------------------
function T_PRDSVCO015.verificaSaldoMaterialConsumo(pParams : String) : String;
//----------------------------------------------------------------------------
const
  cDS_METHOD = 'ADICIONAL=Operação: T_PRDSVCO015.verificaSaldoMaterialConsumo()';
var
  vQtDisponivel, vQtEstoque, vCdEmpresa, vCdEmpresaCMP, vCdEmpresaPRD, vCdGrupoEmpresa, vQtEmpenhadaOP : Real;
  vCdProduto, vCdSaldoOperacao, vCdOperacao, vQtEntrada, vQtSaida, vQtCmpPendente, vQtCmcPendente : Real;
  vQtReserva, vQtInspecao : Real;
  viParams, voParams, vDsLstOperSaida, vDsLstOperEntrada, vDsCampo, vDsCampoValor, vTpValidacaoSaldoCmc : String;
  vInValidaLocal, vInTransacao : Boolean;
begin
  vCdEmpresa := itemXmlF('CD_EMPRESA', pParams);
  vCdEmpresaPRD := itemXmlF('CD_EMPRESAPRD', pParams);
  vCdEmpresaCMP := itemXmlF('CD_EMPRESACMP', pParams);
  vCdOperacao := itemXmlF('CD_OPERACAO', pParams);
  vCdSaldoOperacao := itemXmlF('CD_SALDO', pParams);
  vCdProduto := itemXmlF('CD_PRODUTO', pParams);
  vCdGrupoEmpresa := itemXmlF('CD_GRUPOEMPRESA', pParams);
  vInValidaLocal := itemXmlB('IN_VALIDALOCAL', pParams);
  vInTransacao := itemXmlB('IN_TRANSACAO', pParams);
  gCdSaldo := itemXmlF('CD_SALDOPADRAO', pParams);
  gCdSaldoInspecao := itemXmlF('CD_SALDOINSPECAO', pParams);
  vTpValidacaoSaldoCmc := itemXmlF('TP_VALIDACAO_SALDO_CMC', PARAM_GLB);

  if (vCdEmpresa = '') then begin
    if (vCdGrupoEmpresa > 0) then begin
      viParams := '';
      putitemXml(viParams, 'CD_GRUPOEMPRESA', vCdGrupoEmpresa);
      putitemXml(viParams, 'IN_VALIDALOCAL', vInValidaLocal);
      voParams := activateCmp('GERSVCO032', 'buscaLstGrupoEmpresa', viParams); (*,,,, *)
      if (xStatus < 0) then begin
        Result := voParams;
        return(-1); exit;
      end;
      vCdEmpresa := itemXmlF('CD_EMPRESA', voParams);
    end else begin
      vCdEmpresa := itemXmlF('CD_EMPRESA', PARAM_GLB);
    end;
  end;
  if (vCdEmpresa = '') then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Empresa não informada!', cDS_METHOD);
    return(-1); exit;
  end;
  if (vInTransacao = True) then begin
    if (gCdSaldo = '')  or (gCdSaldoInspecao = '')  or (gCdSaldoReserva = '') then begin
      getParams(pParams); (* vCdEmpresa *)
      if (xStatus < 0) then begin
        return(-1); exit;
      end;
    end;
  end else begin
    if (gCdSaldo = '')  or (gCdSaldoInspecao = '')  or (gCdSaldoReserva = '') then begin
      getParams(pParams); (* vCdEmpresa *)
      if (xStatus < 0) then begin
        return(-1); exit;
      end;
    end;
  end;

  vDsLstOperSaida := '';
  vDsLstOperEntrada := '';

  if (vCdOperacao > 0) then begin
    vCdSaldoOperacao := '';
    clear_e(tGER_OPERACAO);
    putitem_e(tGER_OPERACAO, 'CD_OPERACAO', vCdOperacao);
    retrieve_e(tGER_OPERACAO);
    if (xStatus < 0) then begin
      Result := SetStatus(STS_ERROR, 'GEN0001', 'Operação %vCdOperacao não cadastrada!', cDS_METHOD);
      return(-1); exit;
    end;
    clear_e(tGER_OPERSALDO);
    putitem_e(tGER_OPERSALDO, 'IN_PADRAO', True);
    retrieve_e(tGER_OPERSALDO);
    if (xStatus >= 0) then begin
      vCdSaldoOperacao := item_f('CD_SALDO', tGER_OPERSALDO);
    end else begin
      clear_e(tGER_OPERSALDO);
      retrieve_e(tGER_OPERSALDO);
      if (xStatus >= 0) then begin
        vCdSaldoOperacao := item_f('CD_SALDO', tGER_OPERSALDO);
      end else begin
        clear_e(tGER_OPERSALDO);
      end;
    end;
  end;
  if (vCdSaldoOperacao = '') then begin
    vCdSaldoOperacao := gCdSaldo;
  end;

  clear_e(tTMP_NR09);

  if (vCdSaldoOperacao > 0) then begin
    clear_e(tPRD_TPSALDOF);
    putitem_e(tPRD_TPSALDOF, 'CD_SALDO', vCdSaldoOperacao);
    retrieve_e(tPRD_TPSALDOF);
    if (xStatus >= 0) then begin
      setocc(tPRD_TPSALDOF, 1);
      while (xStatus >= 0) do begin
        if (item_f('TP_OPERACAO', tPRD_TPSALDOF) = 1) then begin
          Result := SetStatus(STS_ERROR, 'GEN0001', 'Tipo de saldo ' + FloatToStr(vCdSaldoOperacao) + ' possui saldos em sua composição com operação de subtração que é incompatível com esta rotina!', cDS_METHOD);
          return(-1); exit;
        end;
        creocc(tTMP_NR09, -1);
        putitem_e(tTMP_NR09, 'NR_GERAL', item_f('CD_SALDOF', tPRD_TPSALDOF));
        retrieve_o(tTMP_NR09);
        setocc(tPRD_TPSALDOF, curocc(tPRD_TPSALDOF) + 1);
      end;
    end;
    creocc(tTMP_NR09, -1);
    putitem_e(tTMP_NR09, 'NR_GERAL', vCdSaldoOperacao);
    retrieve_o(tTMP_NR09);

    clear_e(tGER_OPERACAO);
    putitem_e(tGER_OPERACAO, 'TP_OPERACAO', 'S');
    putitem_e(tGER_OPERACAO, 'IN_KARDEX', True);
    putitem_e(tGER_OPERACAO, 'CD_OPERFAT', '>0');
    retrieve_e(tGER_OPERACAO);
    if (xStatus >= 0) then begin
      setocc(tGER_OPERACAO, 1);
      while (xStatus >= 0) do begin
        clear_e(tGER_OPERSALDO);
        putitem_e(tGER_OPERSALDO, 'IN_PADRAO', True);
        retrieve_e(tGER_OPERSALDO);
        if (xStatus >= 0) then begin
          creocc(tTMP_NR09, -1);
          putitem_e(tTMP_NR09, 'NR_GERAL', item_f('CD_SALDO', tGER_OPERSALDO));
          retrieve_o(tTMP_NR09);
          if (xStatus = 4) then begin
            putitem(vDsLstOperSaida,  item_f('CD_OPERACAO', tGER_OPERACAO));
          end else begin
            discard(tTMP_NR09);
          end;
        end;
        setocc(tGER_OPERACAO, curocc(tGER_OPERACAO) + 1);
      end;
    end;
  end;

  vQtEstoque := 0;

  if (vCdEmpresaPRD <> '') then begin
    viParams := '';
    putitemXml(viParams, 'CD_PRODUTO', vCdProduto);
    putitemXml(viParams, 'CD_SALDO', vCdSaldoOperacao);
    putitemXml(viParams, 'IN_VALIDALOCAL', False);
    voParams := activateCmp('PRDSVCO006', 'buscaSaldoData', viParams); (*,,vCdEmpresaPRD,,, *)
    if (xStatus < 0) then begin
      Result := voParams;
      return(-1); exit;
    end;
  end else begin
    viParams := '';
    putitemXml(viParams, 'CD_PRODUTO', vCdProduto);
    putitemXml(viParams, 'CD_SALDO', vCdSaldoOperacao);
    putitemXml(viParams, 'IN_VALIDALOCAL', False);
    voParams := activateCmp('PRDSVCO006', 'buscaSaldoData', viParams); (*,,vCdEmpresa,,, *)
    if (xStatus < 0) then begin
      Result := voParams;
      return(-1); exit;
    end;
  end;

  vQtEstoque := itemXmlF('QT_SALDO', voParams);

  if (vInTransacao = True) then begin
    vQtEntrada := 0;

    clear_e(tV_CMC_TRAREP);
    putitem_e(tV_CMC_TRAREP, 'CD_EMPRESA', vCdEmpresa);
    putitem_e(tV_CMC_TRAREP, 'CD_PRODUTO', vCdProduto);
    putitem_e(tV_CMC_TRAREP, 'CD_SALDO', gCdSaldoFisico);
    retrieve_e(tV_CMC_TRAREP);
    if (xStatus >= 0) then begin
      vQtEntrada := item_f('QT_PENDENTE', tV_CMC_TRAREP);
    end;

    vQtSaida := 0;

    if (vDsLstOperSaida <> '') then begin
      vDsCampo := '';
      putitem(vDsCampo,  'CD_EMPFAT');
      putitem(vDsCampo,  'CD_PRODUTO');
      putitem(vDsCampo,  'TP_SITUACAO');
      putitem(vDsCampo,  'TP_OPERACAO');

      vDsCampoValor := '';
      if (vCdEmpresaPRD <> '') then begin
        putitemXml(vDsCampoValor, 'CD_EMPFAT', vCdEmpresaPRD);
      end else begin
        putitemXml(vDsCampoValor, 'CD_EMPFAT', vCdEmpresa);
      end;
      putitemXml(vDsCampoValor, 'CD_PRODUTO', vCdProduto);
      putitemXml(vDsCampoValor, 'TP_SITUACAO', '1);
      putitemXml(vDsCampoValor, 'TP_OPERACAO', 'S');
      voParams := buscaPorPartes(viParams); (* 'V_TRA_PRDOPERSVC', 'CD_OPERACAO', vDsLstOperSaida, vDsCampo, vDsCampoValor *)
      if (xStatus < 0) then begin
        Result := voParams;
        return(-1); exit;
      end;
      if not (empty(tV_TRA_PRDOPER)) then begin
        setocc(tV_TRA_PRDOPER, 1);
        while (xStatus >= 0) do begin
          vQtSaida := vQtSaida + item_f('QT_SOLICITADA', tV_TRA_PRDOPER);
          setocc(tV_TRA_PRDOPER, curocc(tV_TRA_PRDOPER) + 1);
        end;
      end;
    end;

    vQtDisponivel := vQtEstoque + vQtEntrada - vQtSaida;
  end;

  clear_e(tV_CMC_CMPREP);
  if (vCdEmpresaCMP = '') then begin
    putitem_e(tV_CMC_CMPREP, 'CD_EMPSOLI', vCdEmpresa);
  end else begin
    putitem_e(tV_CMC_CMPREP, 'CD_EMPSOLI', vCdEmpresaCMP);
  end;
  putitem_e(tV_CMC_CMPREP, 'CD_PRODUTO', vCdProduto);
  putitem_e(tV_CMC_CMPREP, 'TP_FINALIDADE', '3);
  retrieve_e(tV_CMC_CMPREP);
  if not (empty(tV_CMC_CMPREP)) then begin
    setocc(tV_CMC_CMPREP, 1);
    while(xStatus >= 0) do begin
      vQtCmpPendente := vQtCmpPendente + item_f('QT_PENDENTE', tV_CMC_CMPREP);
      setocc(tV_CMC_CMPREP, curocc(tV_CMC_CMPREP) + 1);
    end;
  end;

  vQtCmcPendente := 0;
  clear_e(tV_CMC_PRODUTO);
  putitem_e(tV_CMC_PRODUTO, 'CD_EMPRESA', vCdEmpresa);
  putitem_e(tV_CMC_PRODUTO, 'CD_PRODUTO', vCdProduto);
  putitem_e(tV_CMC_PRODUTO, 'TP_FINALIDADE', 4);
  retrieve_e(tV_CMC_PRODUTO);
  if (xStatus >= 0) then begin
    setocc(tV_CMC_PRODUTO, 1);
    while (xStatus >= 0) do begin
      vQtCmcPendente := vQtCmcPendente + item_f('QT_PENDENTE', tV_CMC_PRODUTO);
      setocc(tV_CMC_PRODUTO, curocc(tV_CMC_PRODUTO) + 1);
    end;
  end;
  if (vTpValidacaoSaldoCmc = 1) then begin
    vQtDisponivel := vQtDisponivel - vQtCmcPendente;
  end else if (vTpValidacaoSaldoCmc = 2) then begin
    vQtDisponivel := vQtDisponivel - vQtCmcPendente + vQtCmpPendente;
  end else if (vTpValidacaoSaldoCmc = 3) then begin
    if (gCdSaldoInspecao = 0) then begin
      Result := SetStatus(STS_ERROR, 'GEN0001', 'Saldo de Inspecao não encontrado no parametro CD_SALDO_INSPECAO!', cDS_METHOD);
      return(-1); exit;
    end;
    viParams := '';
    putitemXml(viParams, 'CD_PRODUTO', vCdProduto);
    putitemXml(viParams, 'CD_SALDO', gCdSaldoInspecao);
    putitemXml(viParams, 'IN_VALIDALOCAL', False);
    voParams := activateCmp('PRDSVCO006', 'buscaSaldoData', viParams); (*,,vCdEmpresa,,, *)
    if (xStatus < 0) then begin
      Result := voParams;
      return(-1); exit;
    end;
    vQtInspecao := itemXmlF('QT_SALDO', voParams);

    vQtDisponivel := (vQtDisponivel + vQtInspecao) - vQtCmcPendente;

  end else if (vTpValidacaoSaldoCmc = 4)  or (vTpValidacaoSaldoCmc = 5) then begin
    vQtEmpenhadaOP := 0;

    clear_e(tPCP_OPMP);
    putitem_e(tPCP_OPMP, 'CD_PRODUTO', vCdProduto);
    putitem_e(tPCP_OPMP, 'DT_FECHAMENTOBAIXA', '=');
    retrieve_e(tPCP_OPMP);
    if (xStatus >= 0) then begin
      setocc(tPCP_OPMP, 1);
      while (xStatus >= 0) do begin
        vQtEmpenhadaOP := vQtEmpenhadaOP + (item_f('QT_ESTIMADA', tPCP_OPMP) - item_f('QT_RETIRADA', tPCP_OPMP) + item_f('QT_RETORNADA', tPCP_OPMP));
        setocc(tPCP_OPMP, curocc(tPCP_OPMP) + 1);
      end;
    end;
    if (vTpValidacaoSaldoCmc = 4) then begin
      vQtDisponivel := vQtDisponivel - vQtCmcPendente - vQtEmpenhadaOP;
    end else if (vTpValidacaoSaldoCmc = 5) then begin
      vQtDisponivel := vQtDisponivel - vQtCmcPendente - vQtEmpenhadaOP + vQtCmpPendente;
    end;

  end else begin
    vQtDisponivel := vQtEstoque;
  end;

  Result := '';
  putitemXml(Result, 'QT_DISPONIVEL', vQtDisponivel);
  putitemXml(Result, 'QT_ESTOQUE', vQtEstoque);
  putitemXml(Result, 'QT_CMPPendENTE', vQtCmpPendente);
  putitemXml(Result, 'QT_CMCPendENTE', vQtCmcPendente);
  putitemXml(Result, 'QT_ENTRADA', vQtEntrada);
  putitemXml(Result, 'QT_SAIDA', vQtSaida);

  return(0); exit;
end;

//--------------------------------------------------------------------
function T_PRDSVCO015.buscaSaldoDisponivel(pParams : String) : String;
//--------------------------------------------------------------------
const
  cDS_METHOD = 'ADICIONAL=Operação: T_PRDSVCO015.buscaSaldoDisponivel()';
var
  viParams, voParams, vTpSituacaoPED, vTpSituacaoCMP : String;
  vCdProduto, vCdEmpresaPRD, vCdGrupoEmpresa, vNrTinturaria, vCdEmpresaOP : Real;
  vCdOperacao, vCdSaldoOperacao, vCdEmpresa, vQtEstoque, vQtSaldoTra, vQtDisponivel : Real;
  vQtCmpPendente, vQtPedPendente, vQtCompra, vQtVenda, vQtOpLiberacao, vQtOpAndamento, vQtOp : Real;
  vInValidaLocal : Boolean;
begin
  vCdEmpresa := itemXmlF('CD_EMPRESA', pParams);
  vCdEmpresaPRD := itemXmlF('CD_EMPRESAPRD', pParams);
  vCdGrupoEmpresa := itemXmlF('CD_GRUPOEMPRESA', pParams);
  vCdProduto := itemXmlF('CD_PRODUTO', pParams);
  vCdSaldoOperacao := itemXmlF('CD_SALDO', pParams);
  vInValidaLocal := itemXmlB('IN_VALIDALOCAL', pParams);
  gTpValidacaoSaldoPed := itemXmlF('TP_VALIDACAO_SALDO_PED', pParams);
  vNrTinturaria := itemXml('TIN_TINTURARIA', PARAM_GLB);
  vTpSituacaoPED := itemXmlF('TP_SITUACAOPED', pParams);
  vTpSituacaoCMP := itemXmlF('TP_SITUACAOCMP', pParams);

  if (vCdProduto = 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Produto não informado!', cDS_METHOD);
    return(-1); exit;
  end;
  if (vCdSaldoOperacao = 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Saldo do produto não informado!', cDS_METHOD);
    return(-1); exit;
  end;
  if (vCdEmpresa = '') then begin
    if (vCdGrupoEmpresa > 0) then begin
      viParams := '';
      putitemXml(viParams, 'CD_GRUPOEMPRESA', vCdGrupoEmpresa);
      putitemXml(viParams, 'IN_VALIDALOCAL', vInValidaLocal);
      voParams := activateCmp('GERSVCO032', 'buscaLstGrupoEmpresa', viParams); (*,,,, *)
      if (xStatus < 0) then begin
        Result := voParams;
        return(-1); exit;
      end;
      vCdEmpresa := itemXmlF('CD_EMPRESA', voParams);
    end else begin
      vCdEmpresa := itemXmlF('CD_EMPRESA', PARAM_GLB);
    end;
  end;
  if (vCdEmpresa = '') then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Empresa não informada!', cDS_METHOD);
    return(-1); exit;
  end;
  if (gTpValidacaoSaldoPed = '') then begin
    getParams(pParams); (* vCdEmpresa *)
    if (xStatus < 0) then begin
      return(-1); exit;
    end;
  end;

  vQtEstoque := 0;

  clear_e(tV_PRD_SALDO);
  putitem_e(tV_PRD_SALDO, 'CD_EMPRESA', vCdEmpresa);
  putitem_e(tV_PRD_SALDO, 'CD_PRODUTO', vCdProduto);
  putitem_e(tV_PRD_SALDO, 'CD_SALDO', vCdSaldoOperacao);
  retrieve_e(tV_PRD_SALDO);
  if (xStatus >= 0) then begin
    setocc(tV_PRD_SALDO, 1);
    while (xStatus >= 0) do begin
      vQtEstoque := vQtEstoque + item_f('QT_SALDO', tV_PRD_SALDO);
      setocc(tV_PRD_SALDO, curocc(tV_PRD_SALDO) + 1);
    end;
  end;
  if (vTpSituacaoPED = '') then begin
    vTpSituacaoPED := '1;
  end;

  vQtPedPendente := 0;

  clear_e(tV_PED_PRDSLD);
  if (vCdEmpresaPRD <> '') then begin
    putitem_e(tV_PED_PRDSLD, 'CD_EMPRESA', vCdEmpresaPRD);
  end else begin
    putitem_e(tV_PED_PRDSLD, 'CD_EMPRESA', vCdEmpresa);
  end;
  putitem_e(tV_PED_PRDSLD, 'CD_PRODUTO', vCdProduto);
  putitem_e(tV_PED_PRDSLD, 'TP_SITUACAO', vTpSituacaoPED);
  putitem_e(tV_PED_PRDSLD, 'CD_SALDO', vCdSaldoOperacao);
  retrieve_e(tV_PED_PRDSLD);
  if (xStatus >= 0) then begin
    setocc(tV_PED_PRDSLD, 1);
    while(xStatus >= 0) do begin
      vQtPedPendente := vQtPedPendente + item_f('QT_SOLICITADA', tV_PED_PRDSLD);
      setocc(tV_PED_PRDSLD, curocc(tV_PED_PRDSLD) + 1);
    end;
  end;
  if (vTpSituacaoCMP = '') then begin
    vTpSituacaoCMP := '1;
  end;

  vQtCmpPendente := 0;

  clear_e(tV_CMP_PRDSLD);
  if (vCdEmpresaPRD <> '') then begin
    putitem_e(tV_CMP_PRDSLD, 'CD_EMPRESA', vCdEmpresaPRD);
  end else begin
    putitem_e(tV_CMP_PRDSLD, 'CD_EMPRESA', vCdEmpresa);
  end;
  putitem_e(tV_CMP_PRDSLD, 'CD_PRODUTO', vCdProduto);
  putitem_e(tV_CMP_PRDSLD, 'TP_SITUACAO', vTpSituacaoCMP);
  putitem_e(tV_CMP_PRDSLD, 'CD_SALDO', vCdSaldoOperacao);
  retrieve_e(tV_CMP_PRDSLD);
  if (xStatus >= 0) then begin
    setocc(tV_CMP_PRDSLD, 1);
    while(xStatus >= 0) do begin
      vQtCmpPendente := vQtCmpPendente + item_f('QT_SOLICITADA', tV_CMP_PRDSLD);
      setocc(tV_CMP_PRDSLD, curocc(tV_CMP_PRDSLD) + 1);
    end;
  end;

  vQtCompra := 0;
  vQtVenda := 0;
  vQtSaldoTra := 0;

  clear_e(tV_TRA_SLDPRDD);
  if (vCdEmpresaPRD <> '') then begin
    putitem_e(tV_TRA_SLDPRDD, 'CD_EMPFAT', vCdEmpresaPRD);
  end else begin
    putitem_e(tV_TRA_SLDPRDD, 'CD_EMPFAT', vCdEmpresa);
  end;
  putitem_e(tV_TRA_SLDPRDD, 'CD_SALDO', vCdSaldoOperacao);
  putitem_e(tV_TRA_SLDPRDD, 'CD_PRODUTO', vCdProduto);
  retrieve_e(tV_TRA_SLDPRDD);
  if (xStatus >= 0) then begin
    setocc(tV_TRA_SLDPRDD, 1);
    while(xStatus >= 0) do begin
      vQtCompra := vQtCompra + item_f('QT_COMPRA', tV_TRA_SLDPRDD);
      vQtVenda := vQtVenda + item_f('QT_VENDA', tV_TRA_SLDPRDD);
      vQtSaldoTra := vQtSaldoTra + item_f('QT_SALDO', tV_TRA_SLDPRDD);
      setocc(tV_TRA_SLDPRDD, curocc(tV_TRA_SLDPRDD) + 1);
    end;
  end;

  vQtOp := 0;
  vQtOPLiberacao := 0;
  vQtOPAndamento := 0;

  if (vNrTinturaria = 1) then begin
    clear_e(tTIN_OTNI);
    putitem_e(tTIN_OTNI, 'CD_EMPRESA', vCdEmpresa);
    putitem_e(tTIN_OTNI, 'CD_PRDDESTINO', vCdProduto);
    retrieve_e(tTIN_OTNI);
    if (xStatus >= 0) then begin
      setocc(tTIN_OTNI, 1);
      while (xStatus >= 0) do begin
        vQtOPAndamento := vQtOPAndamento + item_f('QT_ITEM', tTIN_OTNI) - item_f('QT_BAIXADA', tTIN_OTNI);
        setocc(tTIN_OTNI, curocc(tTIN_OTNI) + 1);
      end;
    end;
  end else begin
    clear_e(tV_PCP_OPPEND);
    if (vCdEmpresaOP <> '') then begin
      putitem_e(tV_PCP_OPPEND, 'CD_EMPRESA', vCdEmpresaOP);
    end else begin
      putitem_e(tV_PCP_OPPEND, 'CD_EMPRESA', vCdEmpresa);
    end;
    putitem_e(tV_PCP_OPPEND, 'CD_PRODUTO', vCdProduto);
    retrieve_e(tV_PCP_OPPEND);
    if (xStatus >= 0) then begin
      setocc(tV_PCP_OPPEND, 1);
      while (xStatus >= 0) do begin
        vQtOp := vQtOp + item_f('QT_PENDENTE', tV_PCP_OPPEND);
        if (item_f('TP_SITUACAO', tV_PCP_OPPEND) = 10) then begin
          vQtOPLiberacao := vQtOPLiberacao + item_f('QT_PENDENTE', tV_PCP_OPPEND);
        end else begin
          vQtOPAndamento := vQtOPAndamento + item_f('QT_PENDENTE', tV_PCP_OPPEND);
        end;
        setocc(tV_PCP_OPPEND, curocc(tV_PCP_OPPEND) + 1);
      end;
    end;
  end;
  if (gprSaldoOpPed > 0) then begin
    vQtOp := vQtOp - (vQtOp *(gprSaldoOpPed / 100));
  end;
  if (gTpValidacaoSaldoPed = 2) then begin
    vQtDisponivel := vQtEstoque + vQtCmpPendente + vQtCompra - vQtPedPendente - vQtVenda;
  end else if (gTpValidacaoSaldoPed = 1) then begin
    vQtDisponivel := vQtEstoque - vQtPedPendente - vQtVenda;
  end else if (gTpValidacaoSaldoPed = 3) then begin
    vQtDisponivel := vQtEstoque + vQtCmpPendente + vQtCompra + vQtOp - vQtPedPendente - vQtVenda;
  end else begin
    vQtDisponivel := vQtEstoque;
  end;

  Result := '';
  putitemXml(Result, 'QT_DISPONIVEL', vQtDisponivel);
  putitemXml(Result, 'QT_SALDOTRANSACAO', vQtSaldoTra);
  putitemXml(Result, 'QT_CMPPendENTE', vQtCmpPendente);
  putitemXml(Result, 'QT_COMPRA', vQtCompra);
  putitemXml(Result, 'QT_PEDPendENTE', vQtPedPendente);
  putitemXml(Result, 'QT_VendA', vQtVenda);
  putitemXml(Result, 'QT_ESTOQUE', vQtEstoque);
  putitemXml(Result, 'QT_OP', vQtOp);
  putitemXml(Result, 'QT_OPLIBERACAO', vQtOpLiberacao);
  putitemXml(Result, 'QT_OPANDAMENTO', vQtOpAndamento);

  return(0); exit;
end;

//-------------------------------------------------------------------
function T_PRDSVCO015.buscaSaldoTransacao(pParams : String) : String;
//-------------------------------------------------------------------
const
  cDS_METHOD = 'ADICIONAL=Operação: T_PRDSVCO015.buscaSaldoTransacao()';
var
  viParams, voParams : String;
  vCdProduto, vCdEmpresaPRD, vCdGrupoEmpresa : Real;
  vCdSaldoOperacao, vCdEmpresa, vQtEstoque, vQtSaldoTra, vQtDisponivel : Real;
  vQtVenda, vQtEntrada, vQtSaida, vQtCompra : Real;
  vInValidaLocal : Boolean;
begin
  vCdEmpresa := itemXmlF('CD_EMPRESA', pParams);
  vCdEmpresaPRD := itemXmlF('CD_EMPRESAPRD', pParams);
  vCdGrupoEmpresa := itemXmlF('CD_GRUPOEMPRESA', pParams);
  vCdProduto := itemXmlF('CD_PRODUTO', pParams);
  vCdSaldoOperacao := itemXmlF('CD_SALDO', pParams);
  vInValidaLocal := itemXmlB('IN_VALIDALOCAL', pParams);
  gTpValidacaoSaldoPed := itemXmlF('TP_VALIDACAO_SALDO_PED', pParams);

  if (vCdProduto = 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Produto não informado!', cDS_METHOD);
    return(-1); exit;
  end;
  if (vCdSaldoOperacao = 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Saldo do produto não informado!', cDS_METHOD);
    return(-1); exit;
  end;
  if (vCdEmpresa = '') then begin
    if (vCdGrupoEmpresa > 0) then begin
      viParams := '';
      putitemXml(viParams, 'CD_GRUPOEMPRESA', vCdGrupoEmpresa);
      putitemXml(viParams, 'IN_VALIDALOCAL', vInValidaLocal);
      voParams := activateCmp('GERSVCO032', 'buscaLstGrupoEmpresa', viParams); (*,,,, *)
      if (xStatus < 0) then begin
        Result := voParams;
        return(-1); exit;
      end;
      vCdEmpresa := itemXmlF('CD_EMPRESA', voParams);
    end else begin
      vCdEmpresa := itemXmlF('CD_EMPRESA', PARAM_GLB);
    end;
  end;
  if (vCdEmpresa = '') then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Empresa não informada!', cDS_METHOD);
    return(-1); exit;
  end;

  vQtEstoque := 0;

  clear_e(tV_PRD_SALDO);
  putitem_e(tV_PRD_SALDO, 'CD_EMPRESA', vCdEmpresa);
  putitem_e(tV_PRD_SALDO, 'CD_PRODUTO', vCdProduto);
  putitem_e(tV_PRD_SALDO, 'CD_SALDO', vCdSaldoOperacao);
  retrieve_e(tV_PRD_SALDO);
  if (xStatus >= 0) then begin
    setocc(tV_PRD_SALDO, 1);
    while (xStatus >= 0) do begin
      vQtEstoque := vQtEstoque + item_f('QT_SALDO', tV_PRD_SALDO);
      setocc(tV_PRD_SALDO, curocc(tV_PRD_SALDO) + 1);
    end;
  end;

  vQtSaldoTra := 0;
  vQtEntrada := 0;
  vQtSaida := 0;
  vQtCompra := 0;
  vQtVenda := 0;

  clear_e(tV_TRA_SLDPRDD);
  putitem_e(tV_TRA_SLDPRDD, 'CD_EMPFAT', vCdEmpresa);
  putitem_e(tV_TRA_SLDPRDD, 'CD_SALDO', vCdSaldoOperacao);
  putitem_e(tV_TRA_SLDPRDD, 'CD_PRODUTO', vCdProduto);
  retrieve_e(tV_TRA_SLDPRDD);
  if (xStatus >= 0) then begin
    setocc(tV_TRA_SLDPRDD, 1);
    while (xStatus >= 0) do begin
      vQtSaldoTra := vQtSaldoTra + item_f('QT_SALDO', tV_TRA_SLDPRDD);
      vQtEntrada := vQtEntrada + item_f('QT_ENTRADA', tV_TRA_SLDPRDD);
      vQtSaida := vQtSaida + item_f('QT_SAIDA', tV_TRA_SLDPRDD);
      vQtCompra := vQtCompra + item_f('QT_COMPRA', tV_TRA_SLDPRDD);
      vQtVenda := vQtVenda + item_f('QT_VENDA', tV_TRA_SLDPRDD);
      setocc(tV_TRA_SLDPRDD, curocc(tV_TRA_SLDPRDD) + 1);
    end;
  end;

  vQtDisponivel := vQtEstoque - vQtSaldoTra;

  putitemXml(Result, 'QT_DISPONIVEL', vQtDisponivel);
  putitemXml(Result, 'QT_SALDOTRANSACAO', vQtSaldoTra);
  putitemXml(Result, 'QT_ENTRADA', vQtEntrada);
  putitemXml(Result, 'QT_SAIDA', vQtSaida);
  putitemXml(Result, 'QT_COMPRA', vQtCompra);
  putitemXml(Result, 'QT_VendA', vQtVenda);

  return(0); exit;
end;

end.
