unit cTRASVCO016;

interface

(* COMPONENTES 
  ADMSVCO001 / GERSVCO032 / PRDSVCO007 / PRDSVCO020 / SICSVCO006
  TRASVCO013 / 
*)        

uses
  Classes, SysUtils, Math, DB,
  cDataSetUnf;

type
  T_TRASVCO016 = class(TComponent)
  private
    tCDF_RETNF,
    tF_TRA_ITEMLOT,
    tF_TRA_TRANSAC,
    tGER_EMPRESA,
    tGER_OPERACAO,
    tGER_OPERSALDO,
    tIMB_CONTRATO,
    tOBS_TRANSACAO,
    tOBS_TRANSACNF,
    tOBS_TRANSFISC,
    tPED_CLASPEDFC,
    tPED_PEDIDOC,
    tPED_PEDIDOCLA,
    tPED_PEDIDOTRA,
    tPES_FAMILIAR,
    tPES_PESSOA,
    tPRD_LOTEI,
    tPRD_PRDSERIAL,
    tPRD_TIPOVALOR,
    tTRA_DEVNFITEM,
    tTRA_ITEMCLAS,
    tTRA_ITEMDESP,
    tTRA_ITEMDEV,
    tTRA_ITEMLOTE,
    tTRA_ITEMSERIA,
    tTRA_ITEMUN,
    tTRA_ITEMVL,
    tTRA_LIBERACAO,
    tTRA_TIPOCLAS,
    tTRA_TRANSACAD,
    tTRA_TRANSACAO,
    tTRA_TRANSACEC,
    tTRA_TRANSCLAS,
    tTRA_TRANSITEM,
    tTRA_TROCA,
    tTRA_VENCIMENT : TcDatasetUnf;
    function getParam(pParams : String = '') : String;
    function setEntidade(pParams : String = '') : String;
  protected
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;    
  published
    function validastring(pParams : String = '') : String;
    function gravaLiberacaoTransacao(pParams : String = '') : String;
    function geraParcelaTransacaoContrato(pParams : String = '') : String;
    function alteraVctoParcContratoSimulador(pParams : String = '') : String;
    function cancelaTransacaoBloqueada(pParams : String = '') : String;
    function gravaObsTransacao(pParams : String = '') : String;
    function gravaUnidadeCompra(pParams : String = '') : String;
    function gravaItemLote(pParams : String = '') : String;
    function gravaItemSerial(pParams : String = '') : String;
    function relacionaOpTransacao(pParams : String = '') : String;
    function gravaClassificacaoCapa(pParams : String = '') : String;
    function gravaClassificacaoItem(pParams : String = '') : String;
    function gravaItemValor(pParams : String = '') : String;
    function removeTrocaTransacao(pParams : String = '') : String;
    function gravaTrocaTransacao(pParams : String = '') : String;
    function gravaDadosAdicionais(pParams : String = '') : String;
    function buscaDadosAdicionais(pParams : String = '') : String;
    function buscaRelacClasPedidoFatura(pParams : String = '') : String;
    function gravaECFTransacao(pParams : String = '') : String;
    function gravaDevolucaoItemTransacao(pParams : String = '') : String;
    function consultaLiberacaoTransacao(pParams : String = '') : String;
    function gravaSerialTransacao(pParams : String = '') : String;
    function removeSerialTransacao(pParams : String = '') : String;
    function gravaDespesaItem(pParams : String = '') : String;
    function buscaDespesaItem(pParams : String = '') : String;
    function gravaDevolucaoItem(pParams : String = '') : String;
    function validaCapaTransacao(pParams : String = '') : String;
  end;

implementation

uses
  cADMSVCO001,
  cActivate, cStatus, cFuncao, cXml, dModulo;

var
  gCdTipoClasPed,
  gCdTpManutRepre,
  gNrDia,
  gNrDiaCancTransBloqueada,
  gNrMes,
  gNrMesAux,
  gTpValidaFamiliar,
  gUsaCondPgtoEspecial,
  gVlMinimoParcela : String;

//---------------------------------------------------------------
constructor T_TRASVCO016.Create(AOwner: TComponent);
//---------------------------------------------------------------
begin
  inherited Create(AOwner);
  setEntidade('');
end;

//--------------------------------
destructor T_TRASVCO016.Destroy;
//--------------------------------
begin
  inherited Destroy;
end;

//---------------------------------------------------------------
function T_TRASVCO016.getParam(pParams : String = '') : String;
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
  putitem(xParam, 'CD_TPMANUT_REPRE');
  putitem(xParam, 'IN_USA_COND_PGTO_ESPECIAL');

  xParam := T_ADMSVCO001.GetParametro(xParam);

  gCdTipoClasPed := itemXml('CD_TIPOCLAS_PED', xParam);
  gCdTpManutRepre := itemXml('CD_TPMANUT_REPRE', xParam);
  gNrDiaCancTransBloqueada := itemXml('NR_DIA_CANC_TRANS_BLOQ', xParam);
  gTpValidaFamiliar := itemXml('TP_VALIDA_FAMILIAR_VD', xParam);
  gUsaCondPgtoEspecial := itemXml('IN_USA_COND_PGTO_ESPECIAL', xParam);
  gVlMinimoParcela := itemXml('VL_MINIMO_PARCELA', xParam);

  xParamEmp := '';
  putitem(xParamEmp, 'CD_TIPOCLAS_PED');
  putitem(xParamEmp, 'CD_TPMANUT_REPRE');
  putitem(xParamEmp, 'IN_USA_COND_PGTO_ESPECIAL');
  putitem(xParamEmp, 'NR_DIA_CANC_TRANS_BLOQ');
  putitem(xParamEmp, 'TP_VALIDA_FAMILIAR_VD');
  putitem(xParamEmp, 'VL_MINIMO_PARCELA');

  xParamEmp := T_ADMSVCO001.GetParamEmpresa(piCdEmpresa, xParamEmp);

  gCdTipoClasPed := itemXml('CD_TIPOCLAS_PED', xParamEmp);
  gNrDiaCancTransBloqueada := itemXml('NR_DIA_CANC_TRANS_BLOQ', xParamEmp);
  gTpValidaFamiliar := itemXml('TP_VALIDA_FAMILIAR_VD', xParamEmp);
  gVlMinimoParcela := itemXml('VL_MINIMO_PARCELA', xParamEmp);
  vCdEmpresa := itemXml('CD_EMPRESA', xParamEmp);
  vCdLiberador := itemXml('CD_LIBERADOR', xParamEmp);
  vDtTransacao := itemXml('DT_TRANSACAO', xParamEmp);
  vNrDiaAtraso := itemXml('NR_DIAATRASO', xParamEmp);
  vNrTransacao := itemXml('NR_TRANSACAO', xParamEmp);
  vTpLiberacao := itemXml('TP_LIBERACAO', xParamEmp);
  vVlDisponivel := itemXml('VL_DISPONIVEL', xParamEmp);

end;

//---------------------------------------------------------------
function T_TRASVCO016.setEntidade(pParams : String = '') : String;
//---------------------------------------------------------------
begin
  tCDF_RETNF := TcDatasetUnf.getEntidade('CDF_RETNF');
  tF_TRA_ITEMLOT := TcDatasetUnf.getEntidade('F_TRA_ITEMLOT');
  tF_TRA_TRANSAC := TcDatasetUnf.getEntidade('F_TRA_TRANSAC');
  tGER_EMPRESA := TcDatasetUnf.getEntidade('GER_EMPRESA');
  tGER_OPERACAO := TcDatasetUnf.getEntidade('GER_OPERACAO');
  tGER_OPERSALDO := TcDatasetUnf.getEntidade('GER_OPERSALDO');
  tIMB_CONTRATO := TcDatasetUnf.getEntidade('IMB_CONTRATO');
  tOBS_TRANSACAO := TcDatasetUnf.getEntidade('OBS_TRANSACAO');
  tOBS_TRANSACNF := TcDatasetUnf.getEntidade('OBS_TRANSACNF');
  tOBS_TRANSFISC := TcDatasetUnf.getEntidade('OBS_TRANSFISC');
  tPED_CLASPEDFC := TcDatasetUnf.getEntidade('PED_CLASPEDFC');
  tPED_PEDIDOC := TcDatasetUnf.getEntidade('PED_PEDIDOC');
  tPED_PEDIDOCLA := TcDatasetUnf.getEntidade('PED_PEDIDOCLA');
  tPED_PEDIDOTRA := TcDatasetUnf.getEntidade('PED_PEDIDOTRA');
  tPES_FAMILIAR := TcDatasetUnf.getEntidade('PES_FAMILIAR');
  tPES_PESSOA := TcDatasetUnf.getEntidade('PES_PESSOA');
  tPRD_LOTEI := TcDatasetUnf.getEntidade('PRD_LOTEI');
  tPRD_PRDSERIAL := TcDatasetUnf.getEntidade('PRD_PRDSERIAL');
  tPRD_TIPOVALOR := TcDatasetUnf.getEntidade('PRD_TIPOVALOR');
  tTRA_DEVNFITEM := TcDatasetUnf.getEntidade('TRA_DEVNFITEM');
  tTRA_ITEMCLAS := TcDatasetUnf.getEntidade('TRA_ITEMCLAS');
  tTRA_ITEMDESP := TcDatasetUnf.getEntidade('TRA_ITEMDESP');
  tTRA_ITEMDEV := TcDatasetUnf.getEntidade('TRA_ITEMDEV');
  tTRA_ITEMLOTE := TcDatasetUnf.getEntidade('TRA_ITEMLOTE');
  tTRA_ITEMSERIA := TcDatasetUnf.getEntidade('TRA_ITEMSERIA');
  tTRA_ITEMUN := TcDatasetUnf.getEntidade('TRA_ITEMUN');
  tTRA_ITEMVL := TcDatasetUnf.getEntidade('TRA_ITEMVL');
  tTRA_LIBERACAO := TcDatasetUnf.getEntidade('TRA_LIBERACAO');
  tTRA_TIPOCLAS := TcDatasetUnf.getEntidade('TRA_TIPOCLAS');
  tTRA_TRANSACAD := TcDatasetUnf.getEntidade('TRA_TRANSACAD');
  tTRA_TRANSACAO := TcDatasetUnf.getEntidade('TRA_TRANSACAO');
  tTRA_TRANSACEC := TcDatasetUnf.getEntidade('TRA_TRANSACEC');
  tTRA_TRANSCLAS := TcDatasetUnf.getEntidade('TRA_TRANSCLAS');
  tTRA_TRANSITEM := TcDatasetUnf.getEntidade('TRA_TRANSITEM');
  tTRA_TROCA := TcDatasetUnf.getEntidade('TRA_TROCA');
  tTRA_VENCIMENT := TcDatasetUnf.getEntidade('TRA_VENCIMENT');
end;

//------------------------------------------------------------
function T_TRASVCO016.validastring(pParams : String) : String;
//------------------------------------------------------------
const
  cDS_METHOD = 'ADICONAL=Operação: T_TRASVCO016.validastring()';
begin
  length strIN;
  while (gresult > 0) do begin
    if ((strIN[1:1] > ' ')  and (strIN[1:1] < '{')) then begin
      strOUT := '' + strOUT' + strIN[ + ' + '1:1]';
    end else begin
      strOUT := '' + strOUT + ' ';
    end;
    strIN := strIN[2];
    length strIN;
  end;

  return(0); exit;
end;

//-----------------------------------------------------------------------
function T_TRASVCO016.gravaLiberacaoTransacao(pParams : String) : String;
//-----------------------------------------------------------------------
const
  cDS_METHOD = 'ADICONAL=Operação: T_TRASVCO016.gravaLiberacaoTransacao()';
var
  viParams, voParams : String;
  vCdEmpresa, vNrTransacao, vTpLiberacao, vVlDisponivel, vNrDiaAtraso, vCdLiberador : Real;
  vDtTransacao : TDate;
begin
  vCdEmpresa := itemXmlF('CD_EMPRESA', pParams);
  vNrTransacao := itemXmlF('NR_TRANSACAO', pParams);
  vDtTransacao := itemXml('DT_TRANSACAO', pParams);
  vCdLiberador := itemXmlF('CD_LIBERADOR', pParams);
  vTpLiberacao := itemXmlF('TP_LIBERACAO', pParams);
  vVlDisponivel := itemXmlF('VL_DISPONIVEL', pParams);
  vNrDiaAtraso := itemXmlF('NR_DIAATRASO', pParams);

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
  if (vTpLiberacao = 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Tipo de liberação não informada!', cDS_METHOD);
    return(-1); exit;
  end;
  if (vCdLiberador = 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Usuário liberação não informada!', cDS_METHOD);
    return(-1); exit;
  end;
  if (vTpLiberacao = 02) then begin
    if (vNrDiaAtraso = 0) then begin
      Result := SetStatus(STS_ERROR, 'GEN0001', 'Números de dias em atraso não informado!', cDS_METHOD);
      return(-1); exit;
    end;
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

  clear_e(tTRA_LIBERACAO);
  retrieve_e(tTRA_LIBERACAO);
  if (xStatus >= 0) then begin
    if (item_f('TP_LIBERACAO', tTRA_LIBERACAO) <> vTpLiberacao) then begin
      vTpLiberacao := 3;
    end;
  end else begin
    clear_e(tTRA_LIBERACAO);
  end;

  putitem_e(tTRA_LIBERACAO, 'TP_LIBERACAO', vTpLiberacao);
  putitem_e(tTRA_LIBERACAO, 'DT_LIBERACAO', itemXml('DT_SISTEMA', PARAM_GLB));
  putitem_e(tTRA_LIBERACAO, 'CD_LIBERADOR', vCdLiberador);
  if (vVlDisponivel <> '') then begin
    putitem_e(tTRA_LIBERACAO, 'VL_LIMITE', vVlDisponivel);
  end;
  if (vNrDiaAtraso <> '') then begin
    putitem_e(tTRA_LIBERACAO, 'NR_DIAATRASO', vNrDiaAtraso);
  end;
  putitem_e(tTRA_LIBERACAO, 'CD_EMPFAT', item_f('CD_EMPFAT', tTRA_TRANSACAO));
  putitem_e(tTRA_LIBERACAO, 'CD_GRUPOEMPRESA', item_f('CD_GRUPOEMPRESA', tTRA_TRANSACAO));
  putitem_e(tTRA_LIBERACAO, 'CD_OPERADOR', itemXmlF('CD_USUARIO', PARAM_GLB));
  putitem_e(tTRA_LIBERACAO, 'DT_CADASTRO', Now);

  voParams := tTRA_LIBERACAO.Salvar();
  if (xStatus < 0) then begin
    Result := voParams;
    return(-1); exit;
  end;

  return(0); exit;
end;

//----------------------------------------------------------------------------
function T_TRASVCO016.geraParcelaTransacaoContrato(pParams : String) : String;
//----------------------------------------------------------------------------
const
  cDS_METHOD = 'ADICONAL=Operação: T_TRASVCO016.geraParcelaTransacaoContrato()';
var
  viParams, voParams : String;
  vCdEmpresa, vNrTransacao, vNrCont : Real;
  vDtTransacao, vDtSistema, vData : TDate;
  vNrParcela, vVlCalc, vVlParcela, vNrTotalDia, vNrAno, vNrDia, vNrAnoAux : Real;
  vVlResto, vVlTotal, vTpArredondamento, vNrDiaFixo, vlAuxiliar : Real;
begin
  vCdEmpresa := itemXmlF('CD_EMPRESA', pParams);
  vNrTransacao := itemXmlF('NR_TRANSACAO', pParams);
  vDtTransacao := itemXml('DT_TRANSACAO', pParams);
  vTpArredondamento := itemXmlF('TP_ARREDONDAMENTO', pParams);
  vDtSistema := itemXml('DT_SISTEMA', PARAM_GLB);

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
  if (empty('IMB_CONTRATOTSVC') <> False) then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Transação não possui um contrato vinculado!', cDS_METHOD);
    return(-1); exit;
  end;
  if (item_f('NR_PARCELA', tIMB_CONTRATO) = 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Número de parcelas não informado no contrato!', cDS_METHOD);
    return(-1); exit;
  end;
  if (item_f('NR_DIABASEVCTO', tIMB_CONTRATO) = 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Dia base de vencimento não informado no contrato!', cDS_METHOD);
    return(-1); exit;
  end;
  if (empty(tTRA_VENCIMENT) = False) then begin
    voParams := tTRA_VENCIMENT.Excluir();
    if (xStatus < 0) then begin
      Result := voParams;
      return(-1); exit;
    end;
  end;
  if (item_a('DT_INIVCTO', tIMB_CONTRATO) <> '') then begin
    vDtSistema := item_a('DT_INIVCTO', tIMB_CONTRATO);
  end;

  vVlTotal := item_f('VL_TOTAL', tTRA_TRANSACAO);
  vNrParcela := item_f('NR_PARCELA', tIMB_CONTRATO);
  vNrDiaFixo := item_f('NR_DIABASEVCTO', tIMB_CONTRATO);

  vVlResto := vVlTotal;
  vVlCalc := vVlTotal / vNrParcela;

  vVlParcela := roundto(vVlCalc, 2);
  if (vTpArredondamento = 1) then begin
    vVlParcela := gInt(vVlCalc);
    if (vVlParcela < 1) then begin
      vVlParcela := roundto(vVlCalc, 2);
    end;
  end;

  clear_e(tTRA_VENCIMENT);

  gNrMes := vDtSistema[M];
  vNrAno := vDtSistema[Y];
  vNrAnoAux := vDtSistema[Y];

  vNrCont := 0;
  repeat

    gNrMesAux := gNrMes + 1;
    if (gNrMesAux = 13) then begin
      gNrMesAux := 1;
      vNrAnoAux := vNrAnoAux + 1;
    end;
    vData := '01/' + FloatToStr(gNrMesAux/' + FloatToStr(vNrAnoAux')) + ' + ';
    vData := vData - 1;
    vNrDia := vData[D];
    if (gNrDia > vNrDia) then begin
      gNrDia := vNrDia;
    end else begin
      gNrDia := vNrDiaFixo;
    end;

    creocc(tTRA_VENCIMENT, 1);
    putitem_e(tTRA_VENCIMENT, 'NR_PARCELA', vNrCont + 1);
    putitem_e(tTRA_VENCIMENT, 'DT_VENCIMENTO', '' + FloatToStr(gNrDia' + FloatToStr(gNrMes' + FloatToStr(vNrAno'))) + ' + ' + ');
    putitem_e(tTRA_VENCIMENT, 'VL_PARCELA', vVlParcela);
    putitem_e(tTRA_VENCIMENT, 'CD_EMPFAT', item_f('CD_EMPFAT', tTRA_TRANSACAO));
    putitem_e(tTRA_VENCIMENT, 'CD_GRUPOEMPRESA', item_f('CD_GRUPOEMPRESA', tTRA_TRANSACAO));
    putitem_e(tTRA_VENCIMENT, 'CD_OPERADOR', itemXmlF('CD_USUARIO', PARAM_GLB));
    putitem_e(tTRA_VENCIMENT, 'DT_CADASTRO', Now);

    vVlResto := vVlResto - vVlParcela;

    gNrMes := gNrMes + 1;
    if (gNrMes = 13) then begin
      gNrMes := 1;
      vNrAno := vNrAno + 1;
    end;

    vNrCont := vNrCont + 1;
  until (vNrCont := vNrParcela);

  if (vVlResto <> 0) then begin
    vlAuxiliar := vVlResto / vNrParcela;
    if (vlAuxiliar > 1) then begin
      setocc(tTRA_VENCIMENT, 1);
      while (xStatus >= 0) do begin
        putitem_e(tTRA_VENCIMENT, 'VL_PARCELA', item_f('VL_PARCELA', tTRA_VENCIMENT) + vlAuxiliar);
        vVlResto := vVlResto - vlAuxiliar;
        setocc(tTRA_VENCIMENT, curocc(tTRA_VENCIMENT) + 1);
      end;
      if (vVlResto <> 0) then begin
        setocc(tTRA_VENCIMENT, 1);
        putitem_e(tTRA_VENCIMENT, 'VL_PARCELA', item_f('VL_PARCELA', tTRA_VENCIMENT) + vVlResto);
      end;
    end else begin
      setocc(tTRA_VENCIMENT, 1);
      putitem_e(tTRA_VENCIMENT, 'VL_PARCELA', item_f('VL_PARCELA', tTRA_VENCIMENT) + vVlResto);
    end;
  end;

  voParams := tTRA_VENCIMENT.Salvar();
  if (xStatus < 0) then begin
    Result := voParams;
    return(-1); exit;
  end;

  return(0); exit;
end;

//-------------------------------------------------------------------------------
function T_TRASVCO016.alteraVctoParcContratoSimulador(pParams : String) : String;
//-------------------------------------------------------------------------------
const
  cDS_METHOD = 'ADICONAL=Operação: T_TRASVCO016.alteraVctoParcContratoSimulador()';
var
  viParams, voParams : String;
  vCdEmpresa, vNrTransacao : Real;
  vDtTransacao, vDtSistema, vData : TDate;
  vNrDiaFixo, vNrParcela, vNrAno, vNrDia, vNrCont : Real;
  vDsLstVencimento, vDsRegistro : String;
  vInEntrada : Boolean;
begin
  vCdEmpresa := itemXmlF('CD_EMPRESA', pParams);
  vNrTransacao := itemXmlF('NR_TRANSACAO', pParams);
  vDtTransacao := itemXml('DT_TRANSACAO', pParams);
  vNrDiaFixo := itemXmlF('NR_DIAFIXO', pParams);

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
  if (vNrDiaFixo = 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Dia fixo de vencimento não informado!', cDS_METHOD);
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
  if (empty('IMB_CONTRATOTSVC') <> False) then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Transação não possui um contrato vinculado!', cDS_METHOD);
    return(-1); exit;
  end;
  if (item_f('NR_DIABASEVCTO', tIMB_CONTRATO) = 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Dia base de vencimento não informado no contrato!', cDS_METHOD);
    return(-1); exit;
  end;
  if (item_a('DT_INIVCTO', tIMB_CONTRATO) <> '') then begin
    vDtSistema := item_a('DT_INIVCTO', tIMB_CONTRATO);
  end else begin
    vDtSistema := itemXml('DT_SISTEMA', PARAM_GLB);
  end;
  vInEntrada := False;

  if (empty(tTRA_VENCIMENT) = False) then begin
    setocc(tTRA_VENCIMENT, 1);
    while (xStatus >= 0) do begin
      if (curocc(tTRA_VENCIMENT) = 1) then begin
        if (item_a('DT_VENCIMENTO', tTRA_VENCIMENT) = itemXml('DT_SISTEMA', PARAM_GLB)  and item_f('VL_PARCELA', tTRA_VENCIMENT) <> gnext('item_f('VL_PARCELA', tTRA_VENCIMENT)')) then begin
          vInEntrada := True;
        end;
      end;
      vDsRegistro := '';
      putlistitensocc_e(vDsRegistro, tTRA_VENCIMENT);
      putitem(vDsLstVencimento,  vDsRegistro);
      setocc(tTRA_VENCIMENT, curocc(tTRA_VENCIMENT) + 1);
    end;
    voParams := tTRA_VENCIMENT.Excluir();
    if (xStatus < 0) then begin
      Result := voParams;
      return(-1); exit;
    end;
  end;
  if (vDsLstVencimento <> '') then begin
    gNrMes := vDtSistema[M];
    vNrAno := vDtSistema[Y];

    clear_e(tTRA_VENCIMENT);

    vNrCont := 1;
    repeat
      getitem(vDsRegistro, vDsLstVencimento, 1);

      if (vInEntrada = True ) and (vNrCont = 1) then begin
        vCdEmpresa := itemXmlF('CD_EMPRESA', vDsRegistro);
        vNrTransacao := itemXmlF('NR_TRANSACAO', vDsRegistro);
        vDtTransacao := itemXml('DT_TRANSACAO', vDsRegistro);
        vNrParcela := itemXmlF('NR_PARCELA', vDsRegistro);

        creocc(tTRA_VENCIMENT, -1);
        putitem_e(tTRA_VENCIMENT, 'CD_EMPRESA', vCdEmpresa);
        putitem_e(tTRA_VENCIMENT, 'NR_TRANSACAO', vNrTransacao);
        putitem_e(tTRA_VENCIMENT, 'DT_TRANSACAO', vDtTransacao);
        putitem_e(tTRA_VENCIMENT, 'NR_PARCELA', vNrParcela);

        delitem(vDsRegistro, 'CD_EMPRESA');
        delitem(vDsRegistro, 'NR_TRANSACAO');
        delitem(vDsRegistro, 'DT_TRANSACAO');
        delitem(vDsRegistro, 'NR_PARCELA');

        getlistitensocc_e(vDsRegistro, tTRA_VENCIMENT);
        putitem_e(tTRA_VENCIMENT, 'DT_VENCIMENTO', vDtSistema);
        if (vNrDiaFixo <= vDtSistema[D]) then begin
          gNrMes := gNrMes + 1;
          if (gNrMes = 13) then begin
            gNrMes := 1;
            vNrAno := vNrAno + 1;
          end;
        end;
      end else begin

        gNrMesAux := gNrMes + 1;
        if (gNrMesAux = 13) then begin
          gNrMesAux := 1;
        end;
        vData := '01/' + FloatToStr(gNrMesAux/' + FloatToStr(vNrAno')) + ' + ';
        vData := vData - 1;
        vNrDia := vData[D];
        if (gNrDia > vNrDia) then begin
          gNrDia := vNrDia;
        end else begin
          gNrDia := vNrDiaFixo;
        end;

        vData := '' + FloatToStr(gNrDia' + FloatToStr(gNrMes' + FloatToStr(vNrAno'))) + ' + ' + ';

        vCdEmpresa := itemXmlF('CD_EMPRESA', vDsRegistro);
        vNrTransacao := itemXmlF('NR_TRANSACAO', vDsRegistro);
        vDtTransacao := itemXml('DT_TRANSACAO', vDsRegistro);
        vNrParcela := itemXmlF('NR_PARCELA', vDsRegistro);

        creocc(tTRA_VENCIMENT, -1);
        putitem_e(tTRA_VENCIMENT, 'CD_EMPRESA', vCdEmpresa);
        putitem_e(tTRA_VENCIMENT, 'NR_TRANSACAO', vNrTransacao);
        putitem_e(tTRA_VENCIMENT, 'DT_TRANSACAO', vDtTransacao);
        putitem_e(tTRA_VENCIMENT, 'NR_PARCELA', vNrParcela);

        delitem(vDsRegistro, 'CD_EMPRESA');
        delitem(vDsRegistro, 'NR_TRANSACAO');
        delitem(vDsRegistro, 'DT_TRANSACAO');
        delitem(vDsRegistro, 'NR_PARCELA');

        getlistitensocc_e(vDsRegistro, tTRA_VENCIMENT);

        putitem_e(tTRA_VENCIMENT, 'DT_VENCIMENTO', vData);
        if (item_f('TP_FORMAPGTO', tTRA_VENCIMENT) <> 1) then begin
          putitem_e(tTRA_VENCIMENT, 'TP_FORMAPGTO', 1);
        end;
        gNrMes := gNrMes + 1;
        if (gNrMes = 13) then begin
          gNrMes := 1;
          vNrAno := vNrAno + 1;
        end;
      end;

      vNrCont := vNrCont + 1;

      delitem(vDsLstVencimento, 1);
    until (vDsLstVencimento = '');
  end;

  voParams := tTRA_VENCIMENT.Salvar();
  if (xStatus < 0) then begin
    Result := voParams;
    return(-1); exit;
  end;

  return(0); exit;
end;

//-------------------------------------------------------------------------
function T_TRASVCO016.cancelaTransacaoBloqueada(pParams : String) : String;
//-------------------------------------------------------------------------
const
  cDS_METHOD = 'ADICONAL=Operação: T_TRASVCO016.cancelaTransacaoBloqueada()';
var
  viParams, voParams, vDsLstEmpresa : String;
  vCdEmpresa, vNrTransacao, vNrDiaTransacao, vCdGrupoEmpresa : Real;
  vDtTransacao, vDtSistema, vDataBase : TDate;
begin
  vDtSistema := itemXml('DT_SISTEMA', PARAM_GLB);
  vCdEmpresa := itemXmlF('CD_EMPRESA', PARAM_GLB);
  getParams(pParams); (* vCdEmpresa, 'cancelaTransacaoBloqueada' *)
  if (xStatus < 0) then begin
    return(-1); exit;
  end;

  vCdGrupoEmpresa := itemXmlF('CD_GRUPOEMPRESA', PARAM_GLB);
  viParams := '';

  putitemXml(viParams 'CD_GRUPOEMPRESA', vCdGrupoEmpresa);
  voParams := activateCmp('GERSVCO032', 'buscaLstGrupoEmpresa', viParams);
  if (xStatus < 0) then begin
    Result := voParams;
    return(-1); exit;
  end;
  vDsLstEmpresa := itemXmlF('CD_EMPRESA', voParams);

  vDataBase := vDtSistema - gNrDiaCancTransBloqueada;
  clear_e(tF_TRA_TRANSAC);
  putitem_e(tF_TRA_TRANSAC, 'CD_EMPRESA', vDsLstEmpresa);
  putitem_e(tF_TRA_TRANSAC, 'DT_TRANSACAO', '<=' + vDataBase' + ');
  putitem_e(tF_TRA_TRANSAC, 'TP_SITUACAO', 8);
  retrieve_e(tF_TRA_TRANSAC);
  if (xStatus >= 0) then begin
    setocc(tF_TRA_TRANSAC, -1);
    setocc(tF_TRA_TRANSAC, 1);
    while (xStatus >= 0) do begin

      viParams := '';
      putitemXml(viParams, 'CD_EMPRESA', item_f('CD_EMPRESA', tF_TRA_TRANSAC));
      putitemXml(viParams, 'NR_TRANSACAO', item_f('NR_TRANSACAO', tF_TRA_TRANSAC));
      putitemXml(viParams, 'DT_TRANSACAO', item_a('DT_TRANSACAO', tF_TRA_TRANSAC));
      putitemXml(viParams, 'DS_MOTIVO', 'Cancelamento de transacoes bloqueadas no encerramento diario. Parametro NR_DIA_CANC_TRANS_BLOQ');
      putitemXml(viParams, 'TP_SITUACAONF', 'C');
      putitemXml(viParams, 'TP_QUANTIDADEPED', '');
      putitemXml(viParams, 'IN_SOFINANCEIRO', '');
      putitemXml(viParams, 'IN_PEDIDO', False);
      putitemXml(viParams, 'CD_CONFERENTE', itemXmlF('CD_USUARIO', PARAM_GLB));
      putitemXml(viParams, 'CD_COMPONENTE', TRASVCO016);
      voParams := activateCmp('TRASVCO013', 'cancelaTransacao', viParams);
      if (xStatus < 0) then begin
        Result := voParams;
        return(-1); exit;
      end;

      setocc(tF_TRA_TRANSAC, curocc(tF_TRA_TRANSAC) + 1);
    end;
  end;

  return(0); exit;
end;

//-----------------------------------------------------------------
function T_TRASVCO016.gravaObsTransacao(pParams : String) : String;
//-----------------------------------------------------------------
const
  cDS_METHOD = 'ADICONAL=Operação: T_TRASVCO016.gravaObsTransacao()';
var
  vDsLinhaObs, vDsLstTransacao, vDsRegistro, vCdComponente : String;
  vCdEmpresa, vNrTransacao, vNrLinha : Real;
  vDtTransacao : TDate;
  vInObsNF, vInManutencao, vInObsFisco : Boolean;
begin
  vInManutencao := itemXmlB('IN_MANUTENCAO', pParams);

  vDsLstTransacao := itemXml('DS_LSTTRANSACAO', pParams);
  if (vDsLstTransacao = '') then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Lista de transação não informada!', cDS_METHOD);
    return(-1); exit;
  end;

  vDsLinhaObs := itemXml('DS_OBSERVACAO', pParams);
  if (vDsLinhaObs = '') then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Observação não informada!', cDS_METHOD);
    return(-1); exit;
  end;

  vCdComponente := itemXmlF('CD_COMPONENTE', pParams);
  if (vCdComponente = '') then begin
    vCdComponente := TRASVCO016;
  end;

  vInObsNF := itemXmlB('IN_OBSNF', pParams);

  vInObsFisco := itemXmlB('IN_OBSFISCO', pParams);

  if (vInObsNF = True)  and (vInObsFisco = True) then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Não é possível gravar observação de fisco e de nota fiscal ao mesmo tempo!', cDS_METHOD);
    return(-1); exit;
  end;

  voParams := validastring(viParams); (* vDsLinhaObs, vDsLinhaObs *)
  if (xStatus < 0) then begin
    Result := voParams;
    return(-1); exit;
  end;

  clear_e(tTRA_TRANSACAO);

  repeat
    getitem(vDsRegistro, vDsLstTransacao, 1);
    vCdEmpresa := itemXmlF('CD_EMPRESA', vDsRegistro);
    vNrTransacao := itemXmlF('NR_TRANSACAO', vDsRegistro);
    vDtTransacao := itemXml('DT_TRANSACAO', vDsRegistro);

    if (vDtTransacao = '') then begin
      Result := SetStatus(STS_ERROR, 'GEN0001', 'Data da transação não informada!', cDS_METHOD);
      return(-1); exit;
    end;
    if (vNrTransacao = 0) then begin
      Result := SetStatus(STS_ERROR, 'GEN0001', 'Número da transação não informada!', cDS_METHOD);
      return(-1); exit;
    end;
    if (vCdEmpresa = 0) then begin
      Result := SetStatus(STS_ERROR, 'GEN0001', 'Empresa da transação não informada!', cDS_METHOD);
      return(-1); exit;
    end;

    creocc(tTRA_TRANSACAO, -1);
    putitem_e(tTRA_TRANSACAO, 'CD_EMPRESA', vCdEmpresa);
    putitem_e(tTRA_TRANSACAO, 'NR_TRANSACAO', vNrTransacao);
    putitem_e(tTRA_TRANSACAO, 'DT_TRANSACAO', vDtTransacao);
    retrieve_o(tTRA_TRANSACAO);
    if (xStatus = -7) then begin
      retrieve_x(tTRA_TRANSACAO);
    end else if (xStatus = 0) then begin
      Result := SetStatus(STS_ERROR, 'GEN0001', 'Transação ' + FloatToStr(vNrTransacao) + ' não cadastrada!', cDS_METHOD);
      return(-1); exit;
    end;
    if (vInObsNF = True) then begin
      setocc(tOBS_TRANSACNF, -1);
      vNrLinha := item_f('NR_LINHA', tOBS_TRANSACNF) + 1;
      creocc(tOBS_TRANSACNF, -1);
      putitem_e(tOBS_TRANSACNF, 'NR_LINHA', vNrLinha);
      putitem_e(tOBS_TRANSACNF, 'DS_OBSERVACAO', vDsLinhaObs[1 : 80]);
      putitem_e(tOBS_TRANSACNF, 'CD_COMPONENTE', vCdComponente);
      putitem_e(tOBS_TRANSACNF, 'CD_OPERADOR', itemXmlF('CD_USUARIO', PARAM_GLB));
      putitem_e(tOBS_TRANSACNF, 'DT_CADASTRO', Now);
    end else begin

      if (vInObsFisco = True) then begin
        setocc(tOBS_TRANSFISC, -1);
        vNrLinha := item_f('NR_LINHA', tOBS_TRANSFISC) + 1;
        creocc(tOBS_TRANSFISC, -1);
        putitem_e(tOBS_TRANSFISC, 'NR_LINHA', vNrLinha);
        putitem_e(tOBS_TRANSFISC, 'DS_OBSERVACAO', vDsLinhaObs[1 : 80]);
        putitem_e(tOBS_TRANSFISC, 'CD_COMPONENTE', vCdComponente);
        putitem_e(tOBS_TRANSFISC, 'CD_OPERADOR', itemXmlF('CD_USUARIO', PARAM_GLB));
        putitem_e(tOBS_TRANSFISC, 'DT_CADASTRO', Now);
      end else begin

        setocc(tOBS_TRANSACAO, -1);
        vNrLinha := item_f('NR_LINHA', tOBS_TRANSACAO) + 1;
        creocc(tOBS_TRANSACAO, -1);
        putitem_e(tOBS_TRANSACAO, 'NR_LINHA', vNrLinha);
        putitem_e(tOBS_TRANSACAO, 'DS_OBSERVACAO', vDsLinhaObs[1 : 80]);
        putitem_e(tOBS_TRANSACAO, 'CD_COMPONENTE', vCdComponente);
        putitem_e(tOBS_TRANSACAO, 'IN_MANUTENCAO', vInManutencao);
        putitem_e(tOBS_TRANSACAO, 'CD_OPERADOR', itemXmlF('CD_USUARIO', PARAM_GLB));
        putitem_e(tOBS_TRANSACAO, 'DT_CADASTRO', Now);
      end;
    end;

    delitem(vDsLstTransacao, 1);
  until (vDsLstTransacao = '');

  voParams := tTRA_TRANSACAO.Salvar();
  if (xStatus < 0) then begin
    Result := voParams;
    return(-1); exit;
  end;

  return(0); exit;
end;

//------------------------------------------------------------------
function T_TRASVCO016.gravaUnidadeCompra(pParams : String) : String;
//------------------------------------------------------------------
const
  cDS_METHOD = 'ADICONAL=Operação: T_TRASVCO016.gravaUnidadeCompra()';
var
  vCdEmpresa, vNrTransacao, vNrItem : Real;
  vDtTransacao : TDate;
begin
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
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Item da transação não informada!', cDS_METHOD);
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
  if (empty(tTRA_ITEMUN) <> False) then begin
    creocc(tTRA_ITEMUN, -1);
  end;

  putitem_e(tTRA_ITEMUN, 'CD_EMPFAT', item_f('CD_EMPFAT', tTRA_TRANSACAO));
  putitem_e(tTRA_ITEMUN, 'CD_GRUPOEMPRESA', item_f('CD_GRUPOEMPRESA', tTRA_TRANSACAO));
  putitem_e(tTRA_ITEMUN, 'CD_ESPECIE', itemXmlF('CD_ESPECIE', pParams));
  putitem_e(tTRA_ITEMUN, 'TP_OPERACAO', itemXmlF('TP_OPERACAO', pParams));
  putitem_e(tTRA_ITEMUN, 'QT_CONVERSAO', itemXmlF('QT_CONVERSAO', pParams));
  putitem_e(tTRA_ITEMUN, 'CD_OPERADOR', itemXmlF('CD_USUARIO', PARAM_GLB));
  putitem_e(tTRA_ITEMUN, 'DT_CADASTRO', Now);

  if (item_f('QT_CONVERSAO', tTRA_ITEMUN) <= 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Item ' + FloatToStr(vNrItem) + ' da transação ' + FloatToStr(vNrTransacao) + ' possui quantidade de conversão inválida!', cDS_METHOD);
    return(-1); exit;
  end;

  voParams := tTRA_ITEMUN.Salvar();
  if (xStatus < 0) then begin
    Result := voParams;
    return(-1); exit;
  end;

  return(0); exit;
end;

//-------------------------------------------------------------
function T_TRASVCO016.gravaItemLote(pParams : String) : String;
//-------------------------------------------------------------
const
  cDS_METHOD = 'ADICONAL=Operação: T_TRASVCO016.gravaItemLote()';
var
  vDsRegistro, vDsLstItemLote, vDsLstIlote, viParams, voParams, vCdBarraLote : String;
  vCdEmpresa, vNrTransacao, vNrItem, vQtLote, vQtTotalLote, vQtPendente, vQtRelacionada : Real;
  vCdEmpLote, vNrLote, vNrItemLote, vQtCone, vTpContrInspSaldoLote, vCdOperSaldo : Real;
  vDtTransacao : TDate;
  vInSemMovimento : Boolean;
begin
  vCdEmpresa := itemXmlF('CD_EMPRESA', pParams);
  vNrTransacao := itemXmlF('NR_TRANSACAO', pParams);
  vDtTransacao := itemXml('DT_TRANSACAO', pParams);
  vNrItem := itemXmlF('NR_ITEM', pParams);
  vDsLstItemLote := itemXml('DS_LSTITEMLOTE', pParams);
  vInSemMovimento := itemXmlB('IN_SEMMOVIMENTO', pParams);

  vTpContrInspSaldoLote := itemXmlF('TP_CONTR_INSP_SALDO_LOTE', PARAM_GLB);

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
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Item da transação não informada!', cDS_METHOD);
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
  if (item_f('QT_SOLICITADA', tTRA_TRANSITEM) = 0) then begin
    return(0); exit;
  end;

  vQtTotalLote := 0;
  vDsLstILote := vDsLstItemLote;
  if (vDsLstILote <> '') then begin
    repeat
      getitem(vDsRegistro, vDsLstILote, 1);
      vCdEmpLote := itemXmlF('CD_EMPRESA', vDsRegistro);
      vNrLote := itemXmlF('NR_LOTE', vDsRegistro);
      vNrItemLote := itemXmlF('NR_ITEM', vDsRegistro);

      vQtLote := itemXmlF('QT_MOVIMENTO', vDsRegistro);

      if (vCdEmpLote = 0) then begin
        Result := SetStatus(STS_ERROR, 'GEN0001', 'Empresa do item de lote não informada!', cDS_METHOD);
        return(-1); exit;
      end;
      if (vNrLote = 0) then begin
        Result := SetStatus(STS_ERROR, 'GEN0001', 'Nr. do lote não informada!', cDS_METHOD);
        return(-1); exit;
      end;
      if (vNrItemLote = 0) then begin
        Result := SetStatus(STS_ERROR, 'GEN0001', 'Nr. do item de lote não informada!', cDS_METHOD);
        return(-1); exit;
      end;
      if (vQtLote = 0) then begin
        Result := SetStatus(STS_ERROR, 'GEN0001', 'Qt. do item de lote ' + FloatToStr(vCdEmpLote) + ' / ' + FloatToStr(vNrLote) + ' / ' + FloatToStr(vNrItemLote) + ' não informada!', cDS_METHOD);
        return(-1); exit;
      end;

      vQtTotalLote := vQtTotalLote + vQtLote;

      if (vTpContrInspSaldoLote = 1) then begin
        vQtPendente := 0;
        vQtRelacionada := 0;

        clear_e(tPRD_LOTEI);
        putitem_e(tPRD_LOTEI, 'CD_EMPRESA', vCdEmpLote);
        putitem_e(tPRD_LOTEI, 'NR_LOTE', vNrLote);
        putitem_e(tPRD_LOTEI, 'NR_ITEM', vNrItemLote);
        retrieve_e(tPRD_LOTEI);
        if (xStatus >= 0) then begin
          vQtPendente := item_f('QT_LOTE', tPRD_LOTEI) - (item_f('QT_BAIXADA', tPRD_LOTEI) + item_f('QT_CANCELADA', tPRD_LOTEI));
        end;

        clear_e(tF_TRA_ITEMLOT);
        putitem_e(tF_TRA_ITEMLOT, 'CD_EMPLOTE', vCdEmpLote);
        putitem_e(tF_TRA_ITEMLOT, 'NR_LOTE', vNrLote);
        putitem_e(tF_TRA_ITEMLOT, 'NR_ITEMLOTE', vNrItemLote);
        retrieve_e(tF_TRA_ITEMLOT);
        if (xStatus >= 0) then begin
          while (xStatus >= 0) do begin
            clear_e(tF_TRA_TRANSAC);
            putitem_e(tF_TRA_TRANSAC, 'CD_EMPRESA', item_f('CD_EMPRESA', tF_TRA_ITEMLOT));
            putitem_e(tF_TRA_TRANSAC, 'NR_TRANSACAO', item_f('NR_TRANSACAO', tF_TRA_ITEMLOT));
            putitem_e(tF_TRA_TRANSAC, 'DT_TRANSACAO', item_a('DT_TRANSACAO', tF_TRA_ITEMLOT));

            retrieve_e(tF_TRA_TRANSAC);
            if (xStatus >= 0) then begin
              if (item_f('TP_SITUACAO', tF_TRA_TRANSAC) = 1 ) and (item_f('TP_OPERACAO', tF_TRA_TRANSAC) = 'S') then begin
                vQtRelacionada := vQtRelacionada + item_f('QT_LOTE', tF_TRA_ITEMLOT);
              end;
            end;

            setocc(tF_TRA_ITEMLOT, curocc(tF_TRA_ITEMLOT) + 1);
          end;
        end;
        if ((vQtLote + vQtRelacionada) > vQtPendente) then begin
          Result := SetStatus(STS_ERROR, 'GEN0001', 'Não é possível relacionar a quantidade (' + vQtLote) + ' do item de lote ' + FloatToStr(vCdEmpLote) + ' / ' + FloatToStr(vNrLote) + ' / ' + FloatToStr(vNrItemLote) + ' na transação ' + FloatToStr(vCdEmpresa) + ' / ' + FloatToStr(vNrTransacao) + ' / ' + vDtTransacao, + ' já que esta quantidade + quantidades relacionadas a outras transações (' + vQtRelacionada), + ' é maior que a quantidade pendente (' + vQtPendente)!', + ' cDS_METHOD);
          return(-1); exit;
        end;
      end;

      delitem(vDsLstILote, 1);
    until (vDsLstILote = '');
  end;
  if (vQtTotalLote <> item_f('QT_SOLICITADA', tTRA_TRANSITEM)) then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Qt. soma dos itens de lote ' + vQtTotalLote + ' diferente da quantidade do produto ' + item_a('CD_PRODUTO', tTRA_TRANSITEM) + ' da trasação ' + item_a('NR_TRANSACAO', tTRA_TRANSITEM)!', + ' cDS_METHOD);
    return(-1); exit;
  end;

  clear_e(tTRA_ITEMLOTE);
  retrieve_e(tTRA_ITEMLOTE);
  if (xStatus >= 0) then begin
    voParams := tTRA_ITEMLOTE.Excluir();
    if (xStatus < 0) then begin
      Result := voParams;
      return(-1); exit;
    end;
  end else begin
    clear_e(tTRA_ITEMLOTE);
  end;

  clear_e(tGER_OPERSALDO);
  putitem_e(tGER_OPERSALDO, 'CD_OPERACAO', item_f('CD_OPERACAO', tTRA_TRANSACAO));
  putitem_e(tGER_OPERSALDO, 'IN_PADRAO', True);
  retrieve_e(tGER_OPERSALDO);
  if (xStatus >= 0) then begin
    vCdOperSaldo := item_f('CD_SALDO', tGER_OPERSALDO);
  end;
  if (vDsLstItemLote <> '') then begin
    repeat
      getitem(vDsRegistro, vDsLstItemLote, 1);
      vCdEmpLote := itemXmlF('CD_EMPRESA', vDsRegistro);
      vNrLote := itemXmlF('NR_LOTE', vDsRegistro);
      vNrItemLote := itemXmlF('NR_ITEM', vDsRegistro);
      vQtLote := itemXmlF('QT_MOVIMENTO', vDsRegistro);
      vQtCone := itemXmlF('QT_CONE', vDsRegistro);
      vCdBarraLote := itemXmlF('CD_BARRALOTE', vDsRegistro);
      creocc(tTRA_ITEMLOTE, -1);
      putitem_e(tTRA_ITEMLOTE, 'NR_SEQUENCIA', curocc(tTRA_ITEMLOTE));
      putitem_e(tTRA_ITEMLOTE, 'CD_EMPLOTE', vCdEmpLote);
      putitem_e(tTRA_ITEMLOTE, 'NR_LOTE', vNrLote);
      putitem_e(tTRA_ITEMLOTE, 'NR_ITEMLOTE', vNrItemLote);
      putitem_e(tTRA_ITEMLOTE, 'QT_LOTE', vQtLote);
      putitem_e(tTRA_ITEMLOTE, 'QT_CONE', vQtCone);
      putitem_e(tTRA_ITEMLOTE, 'CD_BARRALOTE', vCdBarraLote);
      putitem_e(tTRA_ITEMLOTE, 'CD_EMPFAT', item_f('CD_EMPFAT', tTRA_TRANSACAO));
      putitem_e(tTRA_ITEMLOTE, 'CD_GRUPOEMPRESA', item_f('CD_GRUPOEMPRESA', tTRA_TRANSACAO));
      putitem_e(tTRA_ITEMLOTE, 'CD_OPERADOR', itemXmlF('CD_USUARIO', PARAM_GLB));
      putitem_e(tTRA_ITEMLOTE, 'DT_CADASTRO', Now);

      if (vTpContrInspSaldoLote <> 1) then begin
        if (vInSemMovimento <> True)  and (item_b('IN_KARDEX', tGER_OPERACAO))  and (item_f('TP_OPERACAO', tTRA_TRANSACAO) = 'S') then begin
          clear_e(tPRD_LOTEI);
          putitem_e(tPRD_LOTEI, 'CD_EMPRESA', vCdEmpLote);
          putitem_e(tPRD_LOTEI, 'NR_LOTE', vNrLote);
          putitem_e(tPRD_LOTEI, 'NR_ITEM', vNrItemLote);
          retrieve_e(tPRD_LOTEI);
          if (xStatus >= 0) then begin
            if (vCdOperSaldo <> 0)  and (vCdOperSaldo <> item_f('CD_SALDO', tPRD_LOTEI)) then begin
              Result := SetStatus(STS_ERROR, 'GEN0001', 'Saldo ' + item_a('CD_SALDO', tPRD_LOTEI) + ' do item de lote ' + FloatToStr(vCdEmpLote) + ' / ' + FloatToStr(vNrLote) + ' / ' + FloatToStr(vNrItemLote) + ' diferente do saldo ' + FloatToStr(vCdOperSaldo) + ' que é padrão da operação ' + item_a('CD_OPERACAO', tTRA_TRANSACAO)!', + ' cDS_METHOD);
              return(-1); exit;
            end;
          end;

          viParams := '';
          putitemXml(viParams, 'CD_EMPRESA', vCdEmpLote);
          putitemXml(viParams, 'NR_LOTE', vNrLote);
          putitemXml(viParams, 'NR_ITEM', vNrItemLote);
          putitemXml(viParams, 'QT_MOVIMENTO', vQtLote);
          putitemXml(viParams, 'TP_MOVIMENTO', 'B');
          if (item_f('TP_MODALIDADE', tGER_OPERACAO) = 3) then begin
            putitemXml(viParams, 'IN_VALIDASITUACAO', False);
          end;
          voParams := activateCmp('PRDSVCO020', 'movimentaQtLoteI', viParams);
          if (xStatus < 0) then begin
            Result := voParams;
            return(-1); exit;
          end;
        end;
      end;

      delitem(vDsLstItemLote, 1);
    until (vDsLstItemLote = '');

    voParams := tTRA_ITEMLOTE.Salvar();
    if (xStatus < 0) then begin
      Result := voParams;
      return(-1); exit;
    end;
  end;

  return(0); exit;
end;

//---------------------------------------------------------------
function T_TRASVCO016.gravaItemSerial(pParams : String) : String;
//---------------------------------------------------------------
const
  cDS_METHOD = 'ADICONAL=Operação: T_TRASVCO016.gravaItemSerial()';
var
  vDsSerial, vDsLstSerial : String;
  vCdEmpresa, vNrTransacao, vNrItem : Real;
  vDtTransacao : TDate;
begin
  vCdEmpresa := itemXmlF('CD_EMPRESA', pParams);
  vNrTransacao := itemXmlF('NR_TRANSACAO', pParams);
  vDtTransacao := itemXml('DT_TRANSACAO', pParams);
  vNrItem := itemXmlF('NR_ITEM', pParams);
  vDsLstSerial := itemXml('DS_LSTSERIAL', pParams);

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
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Item da transação não informada!', cDS_METHOD);
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

  clear_e(tTRA_ITEMSERIA);
  retrieve_e(tTRA_ITEMSERIA);
  if (xStatus >= 0) then begin
    voParams := tTRA_ITEMSERIA.Excluir();
    if (xStatus < 0) then begin
      Result := voParams;
      return(-1); exit;
    end;
  end else begin
    clear_e(tTRA_ITEMSERIA);
  end;
  if (vDsLstSerial <> '') then begin
    repeat
      getitem(vDsSerial, vDsLstSerial, 1);

      creocc(tTRA_ITEMSERIA, -1);
      putitem_e(tTRA_ITEMSERIA, 'NR_SEQUENCIA', curocc(tTRA_ITEMSERIA));
      putitem_e(tTRA_ITEMSERIA, 'DS_SERIAL', vDsSerial);
      putitem_e(tTRA_ITEMSERIA, 'CD_EMPFAT', item_f('CD_EMPFAT', tTRA_TRANSACAO));
      putitem_e(tTRA_ITEMSERIA, 'CD_GRUPOEMPRESA', item_f('CD_GRUPOEMPRESA', tTRA_TRANSACAO));
      putitem_e(tTRA_ITEMSERIA, 'CD_OPERADOR', itemXmlF('CD_USUARIO', PARAM_GLB));
      putitem_e(tTRA_ITEMSERIA, 'DT_CADASTRO', Now);

      delitem(vDsLstSerial, 1);
    until (vDsLstSerial= '');

    voParams := tTRA_ITEMSERIA.Salvar();
    if (xStatus < 0) then begin
      Result := voParams;
      return(-1); exit;
    end;
  end;

  return(0); exit;
end;

//--------------------------------------------------------------------
function T_TRASVCO016.relacionaOpTransacao(pParams : String) : String;
//--------------------------------------------------------------------
const
  cDS_METHOD = 'ADICONAL=Operação: T_TRASVCO016.relacionaOpTransacao()';
var
  vDsLstOP, vDsRegistro : String;
  vCdEmpresa, vNrTransacao : Real;
  vDtTransacao : TDate;
begin
  vCdEmpresa := itemXmlF('CD_EMPRESA', pParams);
  vNrTransacao := itemXmlF('NR_TRANSACAO', pParams);
  vDtTransacao := itemXml('DT_TRANSACAO', pParams);
  vDsLstOp := itemXml('DS_LSTOP', pParams);

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
  if (vDsLstOp = '') then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Tipo de liberação não informada!', cDS_METHOD);
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

  repeat
    getitem(vDsRegistro, vDsLstOp, 1);

    creocc(tCDF_RETNF, -1);
    getlistitensocc_e(vDsRegistro, tCDF_RETNF);
    putitem_e(tCDF_RETNF, 'CD_EMPTRANSACAO', vCdEmpresa);
    putitem_e(tCDF_RETNF, 'NR_TRANSACAO', vNrTransacao);
    putitem_e(tCDF_RETNF, 'DT_TRANSACAO', vDtTransacao);
    retrieve_o(tCDF_RETNF);
    if (xStatus = -7) then begin
      retrieve_x(tCDF_RETNF);
    end;

    putitem_e(tCDF_RETNF, 'TP_NFRET', itemXmlF('TP_NFRET', vDsRegistro));
    putitem_e(tCDF_RETNF, 'CD_OPERADOR', itemXmlF('CD_USUARIO', PARAM_GLB));
    putitem_e(tCDF_RETNF, 'DT_CADASTRO', Now);

    delitem(vDsLstOp, 1);
  until (vDsLstOp = '');

  voParams := tCDF_RETNF.Salvar();
  if (xStatus < 0) then begin
    Result := voParams;
    return(-1); exit;
  end;

  return(0); exit;
end;

//----------------------------------------------------------------------
function T_TRASVCO016.gravaClassificacaoCapa(pParams : String) : String;
//----------------------------------------------------------------------
const
  cDS_METHOD = 'ADICONAL=Operação: T_TRASVCO016.gravaClassificacaoCapa()';
var
  vDsLstClassificacao, vDsRegistro, vCdComponente, vDsLstClass, vDsReg, vDsLstClas : String;
  vCdClassificacao, vCdTipoClas : String;
  vCdEmpresa, vNrTransacao : Real;
  vDtTransacao : TDate;
  vInExcluir : Boolean;
begin
  vCdEmpresa := itemXmlF('CD_EMPRESA', pParams);
  vNrTransacao := itemXmlF('NR_TRANSACAO', pParams);
  vDtTransacao := itemXml('DT_TRANSACAO', pParams);

  vDsLstClassificacao := itemXml('DS_LSTCLASSIFICACAO', pParams);

  if (vCdEmpresa = 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Empresa da transação não informada!', cDS_METHOD);
    return(-1); exit;
  end;
  if (vNrTransacao = 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Número da transação não informado!', cDS_METHOD);
    return(-1); exit;
  end;
  if (vDtTransacao = '') then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Data da transação não informada!', cDS_METHOD);
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
  if (vDsLstClassificacao <> '') then begin
    vDsLstClas := vDsLstClassificacao;
    clear_e(tTRA_TIPOCLAS);
    repeat
      getitem(vDsRegistro, vDsLstClas, 1);
      vCdTipoClas := itemXmlF('CD_TIPOCLAS', vDsRegistro);
      if (vCdTipoClas > 0) then begin
        creocc(tTRA_TIPOCLAS, -1);
        putitem_e(tTRA_TIPOCLAS, 'CD_TIPOCLAS', vCdTipoClas);
        retrieve_o(tTRA_TIPOCLAS);
        if (xStatus = -7) then begin
          retrieve_x(tTRA_TIPOCLAS);
        end else if (xStatus = 4) then begin
          if (item_b('IN_TRAMULTCLAS', tTRA_TIPOCLAS) <> True) then begin
            Result := SetStatus(STS_ERROR, 'GEN0001', 'Tipo de classificação ' + FloatToStr(vCdTipoclas) + ' da transação ' + FloatToStr(vCdEmpresa) + ' / ' + FloatToStr(vNrTransacao) + ' / ' + vDTTransacao + ' não permite mais de uma classificação por transação!', cDS_METHOD);
            return(-1); exit;
          end;
        end;
      end;
      delitem(vDsLstClas, 1);
    until (vDsLstClas = '');
    clear_e(tTRA_TIPOCLAS);
  end;
  if (empty(tTRA_TRANSCLAS) = False) then begin
    voParams := tTRA_TRANSCLAS.Excluir();
    if (xStatus < 0) then begin
      Result := voParams;
      return(-1); exit;
    end;
  end;
  if (vDsLstClassificacao <> '') then begin
    repeat
      getitem(vDsRegistro, vDsLstClassificacao, 1);

      vCdTipoClas := itemXmlF('CD_TIPOCLAS', vDsRegistro);
      if (vCdTipoClas = '') then begin
        Result := SetStatus(STS_ERROR, 'GEN0001', 'Tipo de classificação inválido!', cDS_METHOD);
        return(-1); exit;
      end;

      vCdClassificacao := itemXmlF('CD_CLASSIFICACAO', vDsRegistro);
      if (vCdClassificacao = '') then begin
        Result := SetStatus(STS_ERROR, 'GEN0001', 'Classificação inválida!', cDS_METHOD);
        return(-1); exit;
      end;

      creocc(tTRA_TRANSCLAS, -1);
      putitem_e(tTRA_TRANSCLAS, 'CD_EMPRESA', vCdEmpresa);
      putitem_e(tTRA_TRANSCLAS, 'NR_TRANSACAO', vNrTransacao);
      putitem_e(tTRA_TRANSCLAS, 'DT_TRANSACAO', vDtTransacao);
      putitem_e(tTRA_TRANSCLAS, 'CD_TIPOCLAS', itemXmlF('CD_TIPOCLAS', vDsRegistro));
      putitem_e(tTRA_TRANSCLAS, 'CD_CLASSIFICACAO', itemXmlF('CD_CLASSIFICACAO', vDsRegistro));
      retrieve_o(tTRA_TRANSCLAS);
      if (xStatus = -7) then begin
        retrieve_x(tTRA_TRANSCLAS);
        delitem(vDsLstClassificacao, 1);
      end else begin
        putitem_e(tTRA_TRANSCLAS, 'CD_OPERADOR', itemXmlF('CD_USUARIO', PARAM_GLB));
        putitem_e(tTRA_TRANSCLAS, 'DT_CADASTRO', Now);
        delitem(vDsLstClassificacao, 1);
      end;
    until (vDsLstClassificacao = '');

    voParams := tTRA_TRANSCLAS.Salvar();
    if (xStatus < 0) then begin
      Result := voParams;
      return(-1); exit;
    end;
  end;

  return(0); exit;

end;

//----------------------------------------------------------------------
function T_TRASVCO016.gravaClassificacaoItem(pParams : String) : String;
//----------------------------------------------------------------------
const
  cDS_METHOD = 'ADICONAL=Operação: T_TRASVCO016.gravaClassificacaoItem()';
var
  vDsLstClassificacao, vDsRegistro, vCdComponente, vDsLstClass, vDsReg, vDsLstClas : String;
  vCdClassificacao, vCdTipoClas : String;
  vCdEmpresa, vNrTransacao, vNrItem : Real;
  vDtTransacao : TDate;
  vInExcluir : Boolean;
begin
  vCdEmpresa := itemXmlF('CD_EMPRESA', pParams);
  vNrTransacao := itemXmlF('NR_TRANSACAO', pParams);
  vDtTransacao := itemXml('DT_TRANSACAO', pParams);
  vNrItem := itemXmlF('NR_ITEM', pParams);

  vDsLstClassificacao := itemXml('DS_LSTCLASSIFICACAO', pParams);

  if (vCdEmpresa = 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Empresa da transação não informada!', cDS_METHOD);
    return(-1); exit;
  end;
  if (vNrTransacao = 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Número da transação não informado!', cDS_METHOD);
    return(-1); exit;
  end;
  if (vDtTransacao = '') then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Data da transação não informada!', cDS_METHOD);
    return(-1); exit;
  end;
  if (vNrItem = '') then begin
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
  end else begin
    clear_e(tTRA_TRANSITEM);
    putitem_e(tTRA_TRANSITEM, 'NR_ITEM', vNrItem);
    retrieve_e(tTRA_TRANSITEM);
    if (xStatus < 0) then begin
      Result := SetStatus(STS_ERROR, 'GEN0001', 'Item ' + FloatToStr(vNrItem) + ' da Transação ' + FloatToStr(vNrTransacao) + ' não cadastrado!', cDS_METHOD);
      return(-1); exit;
    end;
  end;
  if (vDsLstClassificacao <> '') then begin
    vDsLstClas := vDsLstClassificacao;
    clear_e(tTRA_TIPOCLAS);
    repeat
      getitem(vDsRegistro, vDsLstClas, 1);
      vCdTipoClas := itemXmlF('CD_TIPOCLAS', vDsRegistro);
      if (vCdTipoClas > 0) then begin
        creocc(tTRA_TIPOCLAS, -1);
        putitem_e(tTRA_TIPOCLAS, 'CD_TIPOCLAS', vCdTipoClas);
        retrieve_o(tTRA_TIPOCLAS);
        if (xStatus = -7) then begin
          retrieve_x(tTRA_TIPOCLAS);
        end else if (xStatus = 4) then begin
          if (item_b('IN_TRAMULTCLAS', tTRA_TIPOCLAS) <> True) then begin
            Result := SetStatus(STS_ERROR, 'GEN0001', 'Tipo de classificação ' + FloatToStr(vCdTipoclas) + ' da transação ' + FloatToStr(vCdEmpresa) + ' / ' + FloatToStr(vNrTransacao) + ' / ' + vDTTransacao + ' não permite mais de uma classificação por transação!', cDS_METHOD);
            return(-1); exit;
          end;
        end;
      end;
      delitem(vDsLstClas, 1);
    until (vDsLstClas = '');
    clear_e(tTRA_TIPOCLAS);
  end;
  if (empty(tTRA_ITEMCLAS) = False) then begin
    voParams := tTRA_ITEMCLAS.Excluir();
    if (xStatus < 0) then begin
      Result := voParams;
      return(-1); exit;
    end;
  end;
  if (vDsLstClassificacao <> '') then begin
    repeat
      getitem(vDsRegistro, vDsLstClassificacao, 1);

      vCdTipoClas := itemXmlF('CD_TIPOCLAS', vDsRegistro);
      if (vCdTipoClas = '') then begin
        Result := SetStatus(STS_ERROR, 'GEN0001', 'Tipo de classificação inválido!', cDS_METHOD);
        return(-1); exit;
      end;

      vCdClassificacao := itemXmlF('CD_CLASSIFICACAO', vDsRegistro);
      if (vCdClassificacao = '') then begin
        Result := SetStatus(STS_ERROR, 'GEN0001', 'Classificação inválida!', cDS_METHOD);
        return(-1); exit;
      end;

      creocc(tTRA_ITEMCLAS, -1);
      putitem_e(tTRA_ITEMCLAS, 'CD_EMPRESA', vCdEmpresa);
      putitem_e(tTRA_ITEMCLAS, 'NR_TRANSACAO', vNrTransacao);
      putitem_e(tTRA_ITEMCLAS, 'DT_TRANSACAO', vDtTransacao);
      putitem_e(tTRA_ITEMCLAS, 'NR_ITEM', vNrItem);
      putitem_e(tTRA_ITEMCLAS, 'CD_TIPOCLAS', itemXmlF('CD_TIPOCLAS', vDsRegistro));
      putitem_e(tTRA_ITEMCLAS, 'CD_CLASSIFICACAO', itemXmlF('CD_CLASSIFICACAO', vDsRegistro));
      retrieve_o(tTRA_ITEMCLAS);
      if (xStatus = -7) then begin
        retrieve_x(tTRA_ITEMCLAS);
        delitem(vDsLstClassificacao, 1);
      end else begin
        putitem_e(tTRA_ITEMCLAS, 'CD_OPERADOR', itemXmlF('CD_USUARIO', PARAM_GLB));
        putitem_e(tTRA_ITEMCLAS, 'DT_CADASTRO', Now);
        delitem(vDsLstClassificacao, 1);
      end;
    until (vDsLstClassificacao = '');

    voParams := tTRA_ITEMCLAS.Salvar();
    if (xStatus < 0) then begin
      Result := voParams;
      return(-1); exit;
    end;
  end;

  return(0); exit;

end;

//--------------------------------------------------------------
function T_TRASVCO016.gravaItemValor(pParams : String) : String;
//--------------------------------------------------------------
const
  cDS_METHOD = 'ADICONAL=Operação: T_TRASVCO016.gravaItemValor()';
var
  vDsLstValor, viParams, voParams, viListas : String;
  vPosInicio, vPosFim, vTamParam, vCdEmpresa, vNrTransacao : Real;
  vCdEmpFat, vNrItem, vCdGrupoEmpresa, vVlValor, vCdProduto : Real;
  vDtTransacao : TDate;
  vDsLstValorVendaGeral, vDsLstValorVenda : String;
begin
  vDsLstValor := itemXml('DS_LSTVALOR', pParams);
  vCdEmpresa := itemXmlF('CD_EMPRESA', pParams);
  vNrTransacao := itemXmlF('NR_TRANSACAO', pParams);
  vDtTransacao := itemXml('DT_TRANSACAO', pParams);
  vNrItem := itemXmlF('NR_ITEM', pParams);
  vCdEmpFat := itemXmlF('CD_EMPFAT', pParams);
  vCdGrupoEmpresa := itemXmlF('CD_GRUPOEMPRESA', pParams);
  vCdProduto := itemXmlF('CD_PRODUTO', pParams);

  if (vDsLstValor = '') then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Lista de valores não informado!', cDS_METHOD);
    return(-1); exit;
  end;
  if (vCdEmpresa = 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Empresa da transação não informada!', cDS_METHOD);
    return(-1); exit;
  end;
  if (vNrTransacao = 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Número da transação não informada!', cDS_METHOD);
    return(-1); exit;
  end;
  if (vDtTransacao = '') then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Data da transação não informada!', cDS_METHOD);
    return(-1); exit;
  end;
  if (vNrItem = 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Item da transação não informada!', cDS_METHOD);
    return(-1); exit;
  end;
  if (vCdProduto = 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Produto da transação não informado!', cDS_METHOD);
    return(-1); exit;
  end;
  if (vCdEmpFat = 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Empresa de faturamento da transação não informada!', cDS_METHOD);
    return(-1); exit;
  end;
  if (vCdGrupoEmpresa = 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Grupo empresa da transação não informada!', cDS_METHOD);
    return(-1); exit;
  end;

  clear_e(tTRA_ITEMVL);

  vDsLstValorVendaGeral := '';
  vPosInicio := 1;
  vPosFim := 1;
  length vDsLstValor;
  vTamParam := gresult;
  while (vPosInicio < vTamParam) do begin
    scan vDsLstValor[vPosInicio, vTamParam], ';
    if (gresult > 0) then begin
      vPosFim := vPosInicio + gresult - 2;
      clear_e(tPRD_TIPOVALOR);
      putitem_e(tPRD_TIPOVALOR, 'TP_VALOR', vDsLstValor[vPosInicio, vPosFim]);
      vPosInicio := vPosFim + 2;
      scan vDsLstValor[vPosInicio, vTamParam], ';
      if (gresult > 0) then begin
        vPosFim := vPosInicio + gresult - 2;
        putitem_e(tPRD_TIPOVALOR, 'CD_VALOR', vDsLstValor[vPosInicio, vPosFim]);
        retrieve_e(tPRD_TIPOVALOR);
        if (xStatus >= 0) then begin
          viParams := '';
          putitemXml(viParams, 'CD_EMPRESA', vCdEmpFat);
          putitemXml(viParams, 'CD_PRODUTO', vCdProduto);
          putitemXml(viParams, 'TP_VALOR', item_f('TP_VALOR', tPRD_TIPOVALOR));
          putitemXml(viParams, 'CD_VALOR', item_f('CD_VALOR', tPRD_TIPOVALOR));
          viListas := '';
          voParams := activateCmp('PRDSVCO007', 'buscaValorData', viParams);
          if (xStatus < 0) then begin
            Result := voParams;
            return(-1); exit;
          end;

          vVlValor := itemXmlF('VL_VALOR', voParams);

          creocc(tTRA_ITEMVL, -1);
          putitem_e(tTRA_ITEMVL, 'CD_EMPRESA', vCdEmpresa);
          putitem_e(tTRA_ITEMVL, 'NR_TRANSACAO', vNrTransacao);
          putitem_e(tTRA_ITEMVL, 'DT_TRANSACAO', vDtTransacao);
          putitem_e(tTRA_ITEMVL, 'NR_ITEM', vNrItem);
          putitem_e(tTRA_ITEMVL, 'TP_VALOR', item_f('TP_VALOR', tPRD_TIPOVALOR));
          putitem_e(tTRA_ITEMVL, 'CD_VALOR', item_f('CD_VALOR', tPRD_TIPOVALOR));
          retrieve_o(tTRA_ITEMVL);
          if (xStatus = -7) then begin
            retrieve_x(tTRA_ITEMVL);
          end;

          putitem_e(tTRA_ITEMVL, 'CD_EMPFAT', vCdEmpFat);
          putitem_e(tTRA_ITEMVL, 'CD_GRUPOEMPRESA', vCdGrupoEmpresa);
          putitem_e(tTRA_ITEMVL, 'CD_OPERADOR', itemXmlF('CD_USUARIO', PARAM_GLB));
          putitem_e(tTRA_ITEMVL, 'DT_CADASTRO', Now);
          putitem_e(tTRA_ITEMVL, 'TP_ATUALIZACAO', 3);
          putitem_e(tTRA_ITEMVL, 'VL_UNITARIO', vVlValor);

          viParams := '';
          putlistitensocc_e(viParams, tTRA_ITEMVL);
          putitemXml(viParams, 'CD_PRODUTO', vCdProduto);
          voParams := activateCmp('SICSVCO006', 'arredondaValor', viParams);
          if (xStatus < 0) then begin
            Result := voParams;
            return(-1); exit;
          end;

          vVlValor := itemXmlF('VL_VALOR', voParams);
          putitem_e(tTRA_ITEMVL, 'VL_UNITARIO', vVlValor);

          vDsLstValorVenda := '';
          putlistitensocc_e(vDsLstValorVenda, tTRA_ITEMVL);
          putitem(vDsLstValorVendaGeral,  vDsLstValorVenda);

        end;
        vPosInicio := vPosFim + 2;
      end else begin
        break;
      end;
    end;
  end;

  voParams := tTRA_ITEMVL.Salvar();
  if (xStatus < 0) then begin
    Result := voParams;
    return(-1); exit;
  end;

  Result := '';
  putitemXml(Result, 'DS_LSTVALORVendA', vDsLstValorVendaGeral);

  return(0); exit;
end;

//--------------------------------------------------------------------
function T_TRASVCO016.removeTrocaTransacao(pParams : String) : String;
//--------------------------------------------------------------------
const
  cDS_METHOD = 'ADICONAL=Operação: T_TRASVCO016.removeTrocaTransacao()';
var
  vCdEmpresa, vNrTransacao : Real;
  vDtTransacao : TDate;
begin
  vCdEmpresa := itemXmlF('CD_EMPRESA', pParams);
  vNrTransacao := itemXmlF('NR_TRANSACAO', pParams);
  vDtTransacao := itemXml('DT_TRANSACAO', pParams);

  if (vCdEmpresa = 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Empresa da transação de devolução não informada!', cDS_METHOD);
    return(-1); exit;
  end;
  if (vNrTransacao = 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Número da transação de devolução não informado!', cDS_METHOD);
    return(-1); exit;
  end;
  if (vDtTransacao = '') then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Data da transação de devolução não informada!', cDS_METHOD);
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
  if (item_f('TP_OPERACAO', tTRA_TRANSACAO) = 'E') then begin
    clear_e(tTRA_TROCA);
    putitem_e(tTRA_TROCA, 'CD_EMPDEV', vCdEmpresa);
    putitem_e(tTRA_TROCA, 'NR_TRADEV', vNrTransacao);
    putitem_e(tTRA_TROCA, 'DT_TRADEV', vDtTransacao);
    retrieve_e(tTRA_TROCA);
    if (xStatus >= 0) then begin
      voParams := tTRA_TROCA.Excluir();
      if (xStatus < 0) then begin
        Result := voParams;
        return(-1); exit;
      end;
    end;
  end else begin
    clear_e(tTRA_TROCA);
    putitem_e(tTRA_TROCA, 'CD_EMPVEN', vCdEmpresa);
    putitem_e(tTRA_TROCA, 'NR_TRAVEN', vNrTransacao);
    putitem_e(tTRA_TROCA, 'DT_TRAVEN', vDtTransacao);
    retrieve_e(tTRA_TROCA);
    if (xStatus >= 0) then begin
      voParams := tTRA_TROCA.Excluir();
      if (xStatus < 0) then begin
        Result := voParams;
        return(-1); exit;
      end;
    end;
  end;

  return(0); exit;
end;

//-------------------------------------------------------------------
function T_TRASVCO016.gravaTrocaTransacao(pParams : String) : String;
//-------------------------------------------------------------------
const
  cDS_METHOD = 'ADICONAL=Operação: T_TRASVCO016.gravaTrocaTransacao()';
var
  vCdEmpresaDev, vCdEmpresaVen, vNrTransacaoDev, vNrTransacaoVen : Real;
  vCdGrupoEmpresaDev, vCdGrupoEmpresaVen, vCdEmpFatDev, vCdEmpFatVen : Real;
  vDtTransacaoDev, vDtTransacaoVen : TDate;
begin
  vCdEmpresaDev := itemXmlF('CD_EMPDEV', pParams);
  vNrTransacaoDev := itemXmlF('NR_TRADEV', pParams);
  vDtTransacaoDev := itemXml('DT_TRADEV', pParams);
  vCdEmpresaVen := itemXmlF('CD_EMPVEN', pParams);
  vNrTransacaoVen := itemXmlF('NR_TRAVEN', pParams);
  vDtTransacaoVen := itemXml('DT_TRAVEN', pParams);

  if (vCdEmpresaDev = 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Empresa da transação de devolução não informada!', cDS_METHOD);
    return(-1); exit;
  end;
  if (vNrTransacaoDev = 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Número da transação de devolução não informado!', cDS_METHOD);
    return(-1); exit;
  end;
  if (vDtTransacaoDev = '') then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Data da transação de devolução não informada!', cDS_METHOD);
    return(-1); exit;
  end;
  if (vCdEmpresaVen = 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Empresa da transação de venda não informada!', cDS_METHOD);
    return(-1); exit;
  end;
  if (vNrTransacaoVen = 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Número da transação de venda não informado!', cDS_METHOD);
    return(-1); exit;
  end;
  if (vDtTransacaoVen = '') then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Data da transação de venda não informada!', cDS_METHOD);
    return(-1); exit;
  end;

  vCdGrupoEmpresaDev := 0;
  vCdGrupoEmpresaVen := 0;

  clear_e(tGER_EMPRESA);
  putitem_e(tGER_EMPRESA, 'CD_EMPRESA', vCdEmpresaDev);
  retrieve_e(tGER_EMPRESA);
  if (xStatus >= 0) then begin
    vCdGrupoEmpresaDev := item_f('CD_GRUPOEMPRESA', tGER_EMPRESA);
  end;

  clear_e(tGER_EMPRESA);
  putitem_e(tGER_EMPRESA, 'CD_EMPRESA', vCdEmpresaVen);
  retrieve_e(tGER_EMPRESA);
  if (xStatus >= 0) then begin
    vCdGrupoEmpresaVen := item_f('CD_GRUPOEMPRESA', tGER_EMPRESA);
  end;

  clear_e(tTRA_TRANSACAO);
  putitem_e(tTRA_TRANSACAO, 'CD_EMPRESA', vCdEmpresaDev);
  putitem_e(tTRA_TRANSACAO, 'NR_TRANSACAO', vNrTransacaoDev);
  putitem_e(tTRA_TRANSACAO, 'DT_TRANSACAO', vDtTransacaoDev);
  retrieve_e(tTRA_TRANSACAO);
  if (xStatus < 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Transação ' + FloatToStr(vNrTransacaoDev) + ' de devolução não cadastrada!', cDS_METHOD);
    return(-1); exit;
  end;

  vCdEmpFatDev := item_f('CD_EMPFAT', tTRA_TRANSACAO);

  clear_e(tTRA_TRANSACAO);
  putitem_e(tTRA_TRANSACAO, 'CD_EMPRESA', vCdEmpresaVen);
  putitem_e(tTRA_TRANSACAO, 'NR_TRANSACAO', vNrTransacaoVen);
  putitem_e(tTRA_TRANSACAO, 'DT_TRANSACAO', vDtTransacaoVen);
  retrieve_e(tTRA_TRANSACAO);
  if (xStatus < 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Transação ' + FloatToStr(vNrTransacaoVen) + ' de venda não cadastrada!', cDS_METHOD);
    return(-1); exit;
  end;

  vCdEmpFatVen := item_f('CD_EMPFAT', tTRA_TRANSACAO);

  clear_e(tTRA_TRANSACAO);

  clear_e(tTRA_TROCA);
  putitem_e(tTRA_TROCA, 'CD_EMPDEV', vCdEmpresaDev);
  putitem_e(tTRA_TROCA, 'NR_TRADEV', vNrTransacaoDev);
  putitem_e(tTRA_TROCA, 'DT_TRADEV', vDtTransacaoDev);
  retrieve_e(tTRA_TROCA);
  if (xStatus >= 0) then begin
    voParams := tTRA_TROCA.Excluir();
    if (xStatus < 0) then begin
      Result := voParams;
      return(-1); exit;
    end;
  end;

  clear_e(tTRA_TROCA);
  putitem_e(tTRA_TROCA, 'CD_EMPVEN', vCdEmpresaVen);
  putitem_e(tTRA_TROCA, 'NR_TRAVEN', vNrTransacaoVen);
  putitem_e(tTRA_TROCA, 'DT_TRAVEN', vDtTransacaoVen);
  retrieve_e(tTRA_TROCA);
  if (xStatus >= 0) then begin
    voParams := tTRA_TROCA.Excluir();
    if (xStatus < 0) then begin
      Result := voParams;
      return(-1); exit;
    end;
  end;

  clear_e(tTRA_TROCA);
  creocc(tTRA_TROCA, -1);
  putitem_e(tTRA_TROCA, 'CD_EMPDEV', vCdEmpresaDev);
  putitem_e(tTRA_TROCA, 'NR_TRADEV', vNrTransacaoDev);
  putitem_e(tTRA_TROCA, 'DT_TRADEV', vDtTransacaoDev);
  putitem_e(tTRA_TROCA, 'CD_EMPVEN', vCdEmpresaVen);
  putitem_e(tTRA_TROCA, 'NR_TRAVEN', vNrTransacaoVen);
  putitem_e(tTRA_TROCA, 'DT_TRAVEN', vDtTransacaoVen);
  putitem_e(tTRA_TROCA, 'CD_EMPFATDEV', vCdEmpFatDev);
  putitem_e(tTRA_TROCA, 'CD_GRUPOEMPDEV', vCdGrupoEmpresaDev);
  putitem_e(tTRA_TROCA, 'CD_EMPFATVEN', vCdEmpFatVen);
  putitem_e(tTRA_TROCA, 'CD_GRUPOEMPVEN', vCdGrupoEmpresaVen);
  putitem_e(tTRA_TROCA, 'CD_OPERADOR', itemXmlF('CD_USUARIO', PARAM_GLB));
  putitem_e(tTRA_TROCA, 'DT_CADASTRO', Now);

  voParams := tTRA_TROCA.Salvar();
  if (xStatus < 0) then begin
    Result := voParams;
    return(-1); exit;
  end;

  return(0); exit;
end;

//--------------------------------------------------------------------
function T_TRASVCO016.gravaDadosAdicionais(pParams : String) : String;
//--------------------------------------------------------------------
const
  cDS_METHOD = 'ADICONAL=Operação: T_TRASVCO016.gravaDadosAdicionais()';
var
  viParams, voParams, vDsParaUltEmail, vNmCheckout, vCdAgrupador : String;
  vCdEmpresa, vNrTransacao, vNrPrazoMedio, vCdTabPreco, vCdCCusto, vCdEmpAgrup, vCdDespesa : Real;
  vTpBonus, vVlBonus, vVlBase, vCdFamiliar, vCdPropriedade, vCdPessoaProp, vPrSimulador, vVlSimulador : Real;
  vDtTransacao, vDtBaseParcela : TDate;
  vInEmail, vInPrazoMedio, vInBaseParcela, vInCheckout, vInTabPreco, vInCCusto : Boolean;
  vInTabPrecoZero, vInBonus, vInFamiliar : Boolean;
begin
  vCdEmpresa := itemXmlF('CD_EMPRESA', pParams);
  vNrTransacao := itemXmlF('NR_TRANSACAO', pParams);
  vDtTransacao := itemXml('DT_TRANSACAO', pParams);
  vInCheckOut := itemXmlB('IN_CHECKOUT', pParams);
  vInPrazoMedio := itemXmlB('IN_PRAZOMEDIO', pParams);
  vInBaseParcela := itemXmlB('IN_BASEPARCELA', pParams);
  vInEmail := itemXmlB('IN_EMAIL', pParams);
  vDsParaUltEmail := itemXml('DS_PARAULTEMAIL', pParams);
  vNrPrazoMedio := itemXmlF('NR_PRAZOMEDIO', pParams);
  vDtBaseParcela := itemXml('DT_BASEPARCELA', pParams);
  vNmCheckout := itemXml('NM_CHECKOUT', pParams);
  vInTabPreco := itemXmlB('IN_TABPRECO', pParams);
  vCdTabPreco := itemXmlF('CD_TABPRECO', pParams);
  vInTabPrecoZero := itemXmlB('IN_TABPRECOZERO', pParams);
  vInCCusto := itemXmlB('IN_CCUSTO', pParams);
  vCdCCusto := itemXmlF('CD_CCUSTO', pParams);
  vCdDespesa := itemXmlF('CD_DESPESA', pParams);
  vCdEmpAgrup := itemXmlF('CD_EMPAGRUP', pParams);
  vCdAgrupador := itemXmlF('CD_AGRUPADOR', pParams);
  vCdPropriedade := itemXmlF('CD_PROPRIEDADE', pParams);
  vCdPessoaProp := itemXmlF('CD_PESSOAPROP', pParams);
  vInBonus := itemXmlB('IN_BONUS', pParams);
  vTpBonus := itemXmlF('TP_BONUSDESC', pParams);
  vVlBonus := itemXmlF('VL_BONUSDESC', pParams);
  vVlBase := itemXmlF('VL_BASEBONUSDESC', pParams);
  vCdFamiliar := itemXmlF('CD_FAMILIAR', pParams);
  vInFamiliar := itemXmlB('IN_FAMILIAR', pParams);

  vVlSimulador := itemXmlF('VL_SIMULADOR', pParams);
  vPrSimulador := itemXmlF('PR_SIMULADOR', pParams);

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

  clear_e(tTRA_TRANSACAD);
  creocc(tTRA_TRANSACAD, -1);
  putitem_e(tTRA_TRANSACAD, 'CD_EMPRESA', vCdEmpresa);
  putitem_e(tTRA_TRANSACAD, 'NR_TRANSACAO', vNrTransacao);
  putitem_e(tTRA_TRANSACAD, 'DT_TRANSACAO', vDtTransacao);
  retrieve_o(tTRA_TRANSACAD);
  if (xStatus = -7) then begin
    retrieve_x(tTRA_TRANSACAD);
  end else begin
    putitem_e(tTRA_TRANSACAD, 'DT_INCLUSAO', Now);
  end;
  if (vInEmail = True) then begin
    putitem_e(tTRA_TRANSACAD, 'CD_USUEMAIL', itemXmlF('CD_USUARIO', PARAM_GLB));
    putitem_e(tTRA_TRANSACAD, 'DT_ULTEMAIL', itemXml('DT_SISTEMA', PARAM_GLB));
    putitem_e(tTRA_TRANSACAD, 'DS_PARAULTEMAIL', vDsParaUltEmail);
    putitem_e(tTRA_TRANSACAD, 'NR_ENVIOEMAIL', item_f('NR_ENVIOEMAIL', tTRA_TRANSACAD) + 1);
  end;
  if (vInPrazoMedio = True) then begin
    putitem_e(tTRA_TRANSACAD, 'NR_PRAZOMEDIO', vNrPrazoMedio);
  end;
  if (vInBaseParcela = True) then begin
    putitem_e(tTRA_TRANSACAD, 'DT_BASEPARCELA', vDtBaseParcela);
  end;
  if (vInCheckOut = True) then begin
    putitem_e(tTRA_TRANSACAD, 'NM_CHECKOUT', vNmCheckout);
  end;
  if (vInTabPreco = True) then begin
    if (item_f('CD_TABPRECO', tTRA_TRANSACAD) = 0 ) or (vInTabPrecoZero <> True) then begin
      putitem_e(tTRA_TRANSACAD, 'CD_TABPRECO', vCdTabPreco);
    end;
  end;
  if (vInBonus = True) then begin
    putitem_e(tTRA_TRANSACAD, 'TP_BONUSDESC', vTpBonus);
    putitem_e(tTRA_TRANSACAD, 'VL_BONUSDESC', vVlBonus);
    putitem_e(tTRA_TRANSACAD, 'VL_BASEBONUSDESC', vVlBase);
  end;
  if (vInCCusto = True) then begin
    putitem_e(tTRA_TRANSACAD, 'CD_CCUSTO', vCdCCusto);
  end;
  if (vCdAgrupador = '') then begin
    putitem_e(tTRA_TRANSACAD, 'CD_EMPAGRUP', '');
    putitem_e(tTRA_TRANSACAD, 'CD_AGRUPADOR', '');
  end else begin
    putitem_e(tTRA_TRANSACAD, 'CD_EMPAGRUP', vCdEmpAgrup);
    putitem_e(tTRA_TRANSACAD, 'CD_AGRUPADOR', vCdAgrupador);
  end;
  if (vCdDespesa > 0) then begin
    putitem_e(tTRA_TRANSACAD, 'CD_DESPESA', vCdDespesa);
  end;
  if (vCdPropriedade > 0) then begin
    putitem_e(tTRA_TRANSACAD, 'CD_PROPRIEDADE', vCdPropriedade);
  end;
  if (vCdPessoaProp > 0) then begin
    putitem_e(tTRA_TRANSACAD, 'CD_PESSOAPROP', vCdPessoaProp);
  end;
  if (vInFamiliar = True) then begin
    putitem_e(tTRA_TRANSACAD, 'CD_FAMILIAR', vCdFamiliar);
  end;

  putitem_e(tTRA_TRANSACAD, 'CD_OPERADOR', itemXmlF('CD_USUARIO', PARAM_GLB));
  putitem_e(tTRA_TRANSACAD, 'DT_CADASTRO', Now);

  if (vVlSimulador <> '') then begin
    putitem_e(tTRA_TRANSACAD, 'VL_SIMULADOR', vVlSimulador);
  end;
  if (vPrSimulador <> '') then begin
    putitem_e(tTRA_TRANSACAD, 'PR_SIMULADOR', vPrSimulador);
  end;

  voParams := tTRA_TRANSACAD.Salvar();
  if (xStatus < 0) then begin
    Result := voParams;
    return(-1); exit;
  end;

  return(0); exit;
end;

//--------------------------------------------------------------------
function T_TRASVCO016.buscaDadosAdicionais(pParams : String) : String;
//--------------------------------------------------------------------
const
  cDS_METHOD = 'ADICONAL=Operação: T_TRASVCO016.buscaDadosAdicionais()';
var
  viParams, voParams : String;
  vCdEmpresa, vNrTransacao : Real;
  vDtTransacao : TDate;
begin
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

  Result := '';

  clear_e(tTRA_TRANSACAD);
  putitem_e(tTRA_TRANSACAD, 'CD_EMPRESA', vCdEmpresa);
  putitem_e(tTRA_TRANSACAD, 'NR_TRANSACAO', vNrTransacao);
  putitem_e(tTRA_TRANSACAD, 'DT_TRANSACAO', vDtTransacao);
  retrieve_e(tTRA_TRANSACAD);
  if (xStatus >= 0) then begin
    putlistitensocc_e(Result, tTRA_TRANSACAD);
  end;

  return(0); exit;
end;

//--------------------------------------------------------------------------
function T_TRASVCO016.buscaRelacClasPedidoFatura(pParams : String) : String;
//--------------------------------------------------------------------------
const
  cDS_METHOD = 'ADICONAL=Operação: T_TRASVCO016.buscaRelacClasPedidoFatura()';
var
  viParams, voParams, vDsLstClassificacao, vDsRegistro : String;
  vCdEmpresa, vCdPedido : Real;
begin
  vCdEmpresa := itemXmlF('CD_EMPRESA', pParams);
  vCdPedido := itemXmlF('CD_PEDIDO', pParams);
  Result := '';

  if (vCdEmpresa = 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Empresa não informada!', cDS_METHOD);
    return(-1); exit;
  end;
  if (vCdPedido = 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Número do pedido não informado!', cDS_METHOD);
    return(-1); exit;
  end;

  getParams(pParams); (* vCdEmpresa, 'buscaRelacClasPedidoFatura' *)
  if (xStatus < 0) then begin
    return(-1); exit;
  end;

  vDsLstClassificacao := '';

  if (gCdTipoClasPed > 0) then begin
    clear_e(tPED_PEDIDOCLA);
    putitem_e(tPED_PEDIDOCLA, 'CD_EMPRESA', vCdEmpresa);
    putitem_e(tPED_PEDIDOCLA, 'CD_PEDIDO', vCdPedido);
    putitem_e(tPED_PEDIDOCLA, 'CD_TIPOCLAS', gCdTipoClasPed);
    retrieve_e(tPED_PEDIDOCLA);
    if (xStatus >= 0) then begin
      clear_e(tPED_CLASPEDFC);
      putitem_e(tPED_CLASPEDFC, 'CD_TIPOCLASPED', item_f('CD_TIPOCLAS', tPED_PEDIDOCLA));
      putitem_e(tPED_CLASPEDFC, 'CD_CLASSIFICACAOPED', item_f('CD_CLASSIFICACAO', tPED_PEDIDOCLA));
      retrieve_e(tPED_CLASPEDFC);
      if (xStatus >= 0) then begin
        setocc(tPED_CLASPEDFC, 1);
        while (xStatus >= 0) do begin
          vDsRegistro := '';
          putitemXml(vDsRegistro, 'CD_TIPOCLAS', item_f('CD_TIPOCLASFCR', tPED_CLASPEDFC));
          putitemXml(vDsRegistro, 'CD_CLASSIFICACAO', item_f('CD_CLASSIFICACAOFCR', tPED_CLASPEDFC));
          putitem(vDsLstClassificacao,  vDsRegistro);

          setocc(tPED_CLASPEDFC, curocc(tPED_CLASPEDFC) + 1);
        end;
      end;

      putlistitensocc_e(Result, tTRA_TRANSACAD);
    end;
  end;

  putitemXml(Result, 'DS_LSTCLASSIFICACAO', vDsLstClassificacao);

  return(0); exit;
end;

//-----------------------------------------------------------------
function T_TRASVCO016.gravaECFTransacao(pParams : String) : String;
//-----------------------------------------------------------------
const
  cDS_METHOD = 'ADICONAL=Operação: T_TRASVCO016.gravaECFTransacao()';
var
  viParams, voParams : String;
  vCdEmpresa, vNrTransacao, vCdEmpECF, vNrECF, vNrCupom : Real;
  vDtTransacao : TDate;
  vInGravaRelacao : Boolean;
begin
  vCdEmpresa := itemXmlF('CD_EMPRESA', pParams);
  vNrTransacao := itemXmlF('NR_TRANSACAO', pParams);
  vDtTransacao := itemXml('DT_TRANSACAO', pParams);
  vCdEmpECF := itemXmlF('CD_EMPECF', pParams);
  vNrECF := itemXmlF('NR_ECF', pParams);
  vNrCupom := itemXmlF('NR_CUPOM', pParams);
  vInGravaRelacao := itemXmlB('IN_GRAVARELACAO', pParams);

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
  if (vCdEmpECF = 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Empresa da ECF não informada!', cDS_METHOD);
    return(-1); exit;
  end;
  if (vNrECF = 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Número da ECF não informada!', cDS_METHOD);
    return(-1); exit;
  end;
  if (vNrCupom = 0) then begin
    vNrCupom := vNrTransacao;
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

  clear_e(tTRA_TRANSACEC);
  retrieve_e(tTRA_TRANSACEC);
  if (xStatus >= 0) then begin
    voParams := tTRA_TRANSACEC.Excluir();
    if (xStatus < 0) then begin
      Result := voParams;
      return(-1); exit;
    end;
  end else begin
    clear_e(tTRA_TRANSACEC);
  end;

  putitem_e(tTRA_TRANSACEC, 'CD_EMPECF', vCdEmpECF);
  putitem_e(tTRA_TRANSACEC, 'NR_ECF', vNrECF);
  putitem_e(tTRA_TRANSACEC, 'CD_EMPFAT', item_f('CD_EMPFAT', tTRA_TRANSACAO));
  putitem_e(tTRA_TRANSACEC, 'CD_GRUPOEMPRESA', item_f('CD_GRUPOEMPRESA', tTRA_TRANSACAO));
  putitem_e(tTRA_TRANSACEC, 'TP_SITUACAO', 'N');
  putitem_e(tTRA_TRANSACEC, 'NR_CUPOM', vNrCupom);
  putitem_e(tTRA_TRANSACEC, 'CD_OPERADOR', itemXmlF('CD_USUARIO', PARAM_GLB));
  putitem_e(tTRA_TRANSACEC, 'DT_CADASTRO', Now);

  voParams := tTRA_TRANSACEC.Salvar();
  if (xStatus < 0) then begin
    Result := voParams;
    return(-1); exit;
  end;
  if (vInGravaRelacao = True) then begin
    commit;
  end;

  return(0); exit;
end;

//---------------------------------------------------------------------------
function T_TRASVCO016.gravaDevolucaoItemTransacao(pParams : String) : String;
//---------------------------------------------------------------------------
const
  cDS_METHOD = 'ADICONAL=Operação: T_TRASVCO016.gravaDevolucaoItemTransacao()';
var
  viParams, voParams, viListas, vDsRegistro, vDsLstDev : String;
  vCdEmpresa, vNrTransacao, vNrItem : Real;
  vDtTransacao : TDate;
  vInInclusao : Boolean;
begin
  vCdEmpresa := itemXmlF('CD_EMPRESA', pParams);
  vNrTransacao := itemXmlF('NR_TRANSACAO', pParams);
  vDtTransacao := itemXml('DT_TRANSACAO', pParams);
  vNrItem := itemXmlF('NR_ITEM', pParams);
  vDsLstDev := itemXml('DS_LSTDEV', pParams);

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

  vInInclusao := True;

  clear_e(tTRA_ITEMDEV);
  retrieve_e(tTRA_ITEMDEV);
  if (xStatus >= 0) then begin
    voParams := tTRA_ITEMDEV.Excluir();
    if (xStatus < 0) then begin
      Result := voParams;
      return(-1); exit;
    end;
    vInInclusao := False;
  end;
  if (vDsLstDev <> '') then begin
    repeat
      getitem(vDsRegistro, vDsLstDev, 1);
      creocc(tTRA_ITEMDEV, -1);
      getlistitensocc_e(vDsRegistro, tTRA_ITEMDEV);
      putitem_e(tTRA_ITEMDEV, 'NR_SEQUENCIA', curocc(tTRA_ITEMDEV));
      putitem_e(tTRA_ITEMDEV, 'CD_EMPFAT', item_f('CD_EMPFAT', tTRA_TRANSITEM));
      putitem_e(tTRA_ITEMDEV, 'CD_GRUPOEMPRESA', item_f('CD_GRUPOEMPRESA', tTRA_TRANSITEM));
      putitem_e(tTRA_ITEMDEV, 'CD_OPERADOR', itemXmlF('CD_USUARIO', PARAM_GLB));
      putitem_e(tTRA_ITEMDEV, 'DT_CADASTRO', Now);

      if (vInInclusao = True) then begin
        if (item_f('NR_TRANSACAOORI', tTRA_ITEMDEV) > 0) then begin
          clear_e(tPED_PEDIDOTRA);
          putitem_e(tPED_PEDIDOTRA, 'CD_EMPTRANSACAO', item_f('CD_EMPRESAORI', tTRA_ITEMDEV));
          putitem_e(tPED_PEDIDOTRA, 'NR_TRANSACAO', item_f('NR_TRANSACAOORI', tTRA_ITEMDEV));
          putitem_e(tPED_PEDIDOTRA, 'DT_TRANSACAO', item_a('DT_TRANSACAOORI', tTRA_ITEMDEV));
          retrieve_e(tPED_PEDIDOTRA);
          if (xStatus >= 0) then begin
            putitem_e(tTRA_ITEMDEV, 'CD_REPRESENTANT', item_f('CD_REPRESENTANT', tPED_PEDIDOC));
            putitem_e(tTRA_ITEMDEV, 'PR_COMISSAOFAT', item_f('PR_COMISSAOFAT', tPED_PEDIDOC));
            putitem_e(tTRA_ITEMDEV, 'PR_COMISSAOREC', item_f('PR_COMISSAOREC', tPED_PEDIDOC));
          end;
        end;
      end;

      delitem(vDsLstDev, 1);
    until (vDsLstDev = '');

    voParams := tTRA_ITEMDEV.Salvar();
    if (xStatus < 0) then begin
      Result := voParams;
      return(-1); exit;
    end;
  end;

  return(0); exit;
end;

//--------------------------------------------------------------------------
function T_TRASVCO016.consultaLiberacaoTransacao(pParams : String) : String;
//--------------------------------------------------------------------------
const
  cDS_METHOD = 'ADICONAL=Operação: T_TRASVCO016.consultaLiberacaoTransacao()';
var
  viParams, voParams : String;
  vCdGrupoEmpresa, vNrTransacao, vTpLiberacao : Real;
  vDtTransacao : TDate;
begin
  vCdGrupoEmpresa := itemXmlF('CD_GRUPOEMPRESA', pParams);
  vNrTransacao := itemXmlF('NR_TRANSACAO', pParams);
  vDtTransacao := itemXml('DT_TRANSACAO', pParams);

  if (vCdGrupoEmpresa = 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Grupo empresa não informado!', cDS_METHOD);
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
  putitem_e(tTRA_TRANSACAO, 'CD_GRUPOEMPRESA', vCdGrupoEmpresa);
  putitem_e(tTRA_TRANSACAO, 'NR_TRANSACAO', vNrTransacao);
  putitem_e(tTRA_TRANSACAO, 'DT_TRANSACAO', vDtTransacao);
  retrieve_e(tTRA_TRANSACAO);
  if (xStatus < 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Transação ' + FloatToStr(vNrTransacao) + ' não cadastrada!', cDS_METHOD);
    return(-1); exit;
  end;

  clear_e(tTRA_LIBERACAO);
  retrieve_e(tTRA_LIBERACAO);
  if (xStatus >= 0) then begin
    putitemXml(Result, 'TP_LIBERACAO', item_f('TP_LIBERACAO', tTRA_LIBERACAO));
  end;

  return(0); exit;

end;

//--------------------------------------------------------------------
function T_TRASVCO016.gravaSerialTransacao(pParams : String) : String;
//--------------------------------------------------------------------
const
  cDS_METHOD = 'ADICONAL=Operação: T_TRASVCO016.gravaSerialTransacao()';
var
  vCdEmpresa, vNrTransacao, vNrItem, vNrSequencia, vNrSeqSerial : Real;
  vDtTransacao : TDate;
  vDsLstSerial, vDsSerial : String;
begin
  vCdEmpresa := itemXmlF('CD_EMPRESA', pParams);
  vNrTransacao := itemXmlF('NR_TRANSACAO', pParams);
  vDtTransacao := itemXml('DT_TRANSACAO', pParams);
  vNrItem := itemXmlF('NR_ITEM', pParams);
  vDsLstSerial := itemXml('DS_LSTSERIAL', pParams);

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
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Item da transação não informada!', cDS_METHOD);
    return(-1); exit;
  end;
  if (vDsLstSerial = '') then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Lista de serial não informada!', cDS_METHOD);
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
  if (empty(tTRA_ITEMSERIA) <> False) then begin
    setocc(tTRA_ITEMSERIA, -1);
    vNrSequencia := item_f('NR_SEQUENCIA', tTRA_ITEMSERIA) + 1;
  end else begin
    vNrSequencia := 1;
  end;

  repeat
    getitem(vDsSerial, vDsLstSerial, 1);

    creocc(tTRA_ITEMSERIA, -1);
    putitem_e(tTRA_ITEMSERIA, 'NR_SEQUENCIA', vNrSequencia);
    putitem_e(tTRA_ITEMSERIA, 'CD_OPERADOR', itemXmlF('CD_USUARIO', PARAM_GLB));
    putitem_e(tTRA_ITEMSERIA, 'DT_CADASTRO', Now);
    putitem_e(tTRA_ITEMSERIA, 'CD_EMPFAT', item_f('CD_EMPFAT', tTRA_TRANSACAO));
    putitem_e(tTRA_ITEMSERIA, 'CD_GRUPOEMPRESA', item_f('CD_GRUPOEMPRESA', tTRA_TRANSACAO));
    putitem_e(tTRA_ITEMSERIA, 'DS_SERIAL', vDsSerial);

    clear_e(tPRD_PRDSERIAL);
    putitem_e(tPRD_PRDSERIAL, 'CD_PRODUTO', item_f('CD_PRODUTO', tTRA_TRANSITEM));
    putitem_e(tPRD_PRDSERIAL, 'DS_SERIAL', vDsSerial);
    if (item_f('TP_OPERACAO', tTRA_TRANSACAO) = 'S') then begin
      putitem_e(tPRD_PRDSERIAL, 'TP_SITUACAO', 1);
    end else begin
      putitem_e(tPRD_PRDSERIAL, 'TP_SITUACAO', 2);
    end;
    retrieve_e(tPRD_PRDSERIAL);
    if (xStatus >= 0) then begin
      setocc(tPRD_PRDSERIAL, 1);
      if (item_f('TP_OPERACAO', tTRA_TRANSACAO) = 'S') then begin
        putitem_e(tPRD_PRDSERIAL, 'TP_SITUACAO', 2);
      end else begin
        putitem_e(tPRD_PRDSERIAL, 'TP_SITUACAO', 1);
      end;

      voParams := tPRD_PRDSERIAL.Salvar();
      if (xStatus < 0) then begin
        Result := voParams;
        return(-1); exit;
      end;
    end;

    vNrSequencia := vNrSequencia + 1;
    delitem(vDsLstSerial, 1);
  until (vDsLstSerial = '');

  voParams := tTRA_ITEMSERIA.Salvar();
  if (xStatus < 0) then begin
    Result := voParams;
    return(-1); exit;
  end;

  return(0); exit;
end;

//---------------------------------------------------------------------
function T_TRASVCO016.removeSerialTransacao(pParams : String) : String;
//---------------------------------------------------------------------
const
  cDS_METHOD = 'ADICONAL=Operação: T_TRASVCO016.removeSerialTransacao()';
var
  vCdEmpresa, vNrTransacao, vNrItem : Real;
  vDtTransacao : TDate;
begin
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
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Item da transação não informada!', cDS_METHOD);
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
  if (empty(tTRA_ITEMSERIA) = False) then begin
    setocc(tTRA_ITEMSERIA, 1);
    while (xStatus >= 0) do begin
      clear_e(tPRD_PRDSERIAL);
      putitem_e(tPRD_PRDSERIAL, 'CD_PRODUTO', item_f('CD_PRODUTO', tTRA_TRANSITEM));
      putitem_e(tPRD_PRDSERIAL, 'DS_SERIAL', item_a('DS_SERIAL', tTRA_ITEMSERIA));
      if (item_f('TP_OPERACAO', tTRA_TRANSACAO) = 'S') then begin
        putitem_e(tPRD_PRDSERIAL, 'TP_SITUACAO', 2);
      end else begin
        putitem_e(tPRD_PRDSERIAL, 'TP_SITUACAO', 1);
      end;
      retrieve_e(tPRD_PRDSERIAL);
      if (xStatus >= 0) then begin
        setocc(tPRD_PRDSERIAL, 1);
        if (item_f('TP_OPERACAO', tTRA_TRANSACAO) = 'S') then begin
          putitem_e(tPRD_PRDSERIAL, 'TP_SITUACAO', 1);
        end else begin
          putitem_e(tPRD_PRDSERIAL, 'TP_SITUACAO', 2);
        end;

        voParams := tPRD_PRDSERIAL.Salvar();
        if (xStatus < 0) then begin
          Result := voParams;
          return(-1); exit;
        end;
      end;

      setocc(tTRA_ITEMSERIA, curocc(tTRA_ITEMSERIA) + 1);
    end;
  end;

  voParams := tTRA_ITEMSERIA.Excluir();
  if (xStatus < 0) then begin
    Result := voParams;
    return(-1); exit;
  end;

  return(0); exit;
end;

//----------------------------------------------------------------
function T_TRASVCO016.gravaDespesaItem(pParams : String) : String;
//----------------------------------------------------------------
const
  cDS_METHOD = 'ADICONAL=Operação: T_TRASVCO016.gravaDespesaItem()';
var
  vDsLstDespesa, vDsRegistro, vCdComponente : String;
  vCdEmpresa, vNrTransacao, vNrItem, vCdDespesaItem, vCdCCusto, vPrRateio : Real;
  vDtTransacao : TDate;
begin
  vCdEmpresa := itemXmlF('CD_EMPRESA', pParams);
  vNrTransacao := itemXmlF('NR_TRANSACAO', pParams);
  vDtTransacao := itemXml('DT_TRANSACAO', pParams);
  vNrItem := itemXmlF('NR_ITEM', pParams);
  vDsLstDespesa := itemXml('DS_LSTDESPESA', pParams);
  vCdDespesaItem := '';
  vCdCCusto := '';

  if (vCdEmpresa = 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Empresa da transação não informada!', cDS_METHOD);
    return(-1); exit;
  end;
  if (vNrTransacao = 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Número da transação não informado!', cDS_METHOD);
    return(-1); exit;
  end;
  if (vDtTransacao = '') then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Data da transação não informada!', cDS_METHOD);
    return(-1); exit;
  end;
  if (vNrItem = '') then begin
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
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Item ' + FloatToStr(vNrItem) + ' da Transação ' + FloatToStr(vNrTransacao) + ' não cadastrado!', cDS_METHOD);
    return(-1); exit;
  end;

  if not (empty(tTRA_ITEMDESP)) then begin
    voParams := tTRA_ITEMDESP.Excluir();
    if (xStatus < 0) then begin
      Result := voParams;
      return(-1); exit;
    end;
  end;
  if (vDsLstDespesa <> '') then begin
    repeat
      getitem(vDsRegistro, vDsLstDespesa, 1);

      vCdDespesaItem := itemXmlF('CD_DESPESAITEM', vDsRegistro);
      if (vCdDespesaItem = '') then begin
        Result := SetStatus(STS_ERROR, 'GEN0001', 'Despesa inválida!', cDS_METHOD);
        return(-1); exit;
      end;

      vCdCCusto := itemXmlF('CD_CCUSTO', vDsRegistro);
      if (vCdCCusto = '') then begin
        Result := SetStatus(STS_ERROR, 'GEN0001', 'Centro de custo inválido!', cDS_METHOD);
        return(-1); exit;
      end;

      vPrRateio := itemXmlF('PR_RATEIO', vDsRegistro);
      if (vPrRateio > 0) then begin
        creocc(tTRA_ITEMDESP, -1);
        putitem_e(tTRA_ITEMDESP, 'CD_EMPRESA', vCdEmpresa);
        putitem_e(tTRA_ITEMDESP, 'NR_TRANSACAO', vNrTransacao);
        putitem_e(tTRA_ITEMDESP, 'DT_TRANSACAO', vDtTransacao);
        putitem_e(tTRA_ITEMDESP, 'NR_ITEM', vNrItem);
        putitem_e(tTRA_ITEMDESP, 'CD_DESPESAITEM', vCdDespesaItem);
        putitem_e(tTRA_ITEMDESP, 'CD_CCUSTO', vCdCCusto);
        retrieve_o(tTRA_ITEMDESP);
        if (xStatus = -7) then begin
          retrieve_x(tTRA_ITEMDESP);
        end;

        putitem_e(tTRA_ITEMDESP, 'CD_OPERADOR', itemXmlF('CD_USUARIO', PARAM_GLB));
        putitem_e(tTRA_ITEMDESP, 'DT_CADASTRO', Now);
        putitem_e(tTRA_ITEMDESP, 'PR_RATEIO', item_f('PR_RATEIO', tTRA_ITEMDESP) + vPrRateio);
      end;
      delitem(vDsLstDespesa, 1);
    until (vDsLstDespesa = '');

    voParams := tTRA_ITEMDESP.Salvar();
    if (xStatus < 0) then begin
      Result := voParams;
      return(-1); exit;
    end;
  end;

  return(0); exit;

end;

//----------------------------------------------------------------
function T_TRASVCO016.buscaDespesaItem(pParams : String) : String;
//----------------------------------------------------------------
const
  cDS_METHOD = 'ADICONAL=Operação: T_TRASVCO016.buscaDespesaItem()';
var
  vDsLstDespesa, vDsRegistro, vCdComponente : String;
  vCdEmpresa, vNrTransacao, vNrItem : Real;
  vDtTransacao : TDate;
begin
  vCdEmpresa := itemXmlF('CD_EMPRESA', pParams);
  vNrTransacao := itemXmlF('NR_TRANSACAO', pParams);
  vDtTransacao := itemXml('DT_TRANSACAO', pParams);
  vNrItem := itemXmlF('NR_ITEM', pParams);
  vDsLstDespesa := '';

  if (vCdEmpresa = 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Empresa da transação não informada!', cDS_METHOD);
    return(-1); exit;
  end;
  if (vNrTransacao = 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Número da transação não informado!', cDS_METHOD);
    return(-1); exit;
  end;
  if (vDtTransacao = '') then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Data da transação não informada!', cDS_METHOD);
    return(-1); exit;
  end;
  if (vNrItem = '') then begin
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
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Item ' + FloatToStr(vNrItem) + ' da Transação ' + FloatToStr(vNrTransacao) + ' não cadastrado!', cDS_METHOD);
    return(-1); exit;
  end;

  if not (empty(tTRA_ITEMDESP)) then begin
    setocc(tTRA_ITEMDESP, 1);
    while (xStatus >= 0) do begin
      vDsRegistro := '';
      putlistitensocc_e(vDsRegistro, tTRA_ITEMDESP);
      putitem(vDsLstDespesa,  vDsRegistro);
      setocc(tTRA_ITEMDESP, curocc(tTRA_ITEMDESP) + 1);
    end;
  end;

  putitemXml(Result, 'DS_LSTDESPESA', vDsLstDespesa);

  return(0); exit;

end;

//------------------------------------------------------------------
function T_TRASVCO016.gravaDevolucaoItem(pParams : String) : String;
//------------------------------------------------------------------
const
  cDS_METHOD = 'ADICONAL=Operação: T_TRASVCO016.gravaDevolucaoItem()';
var
  vDsLstDevolucao, vDsRegistro : String;
  vCdEmpresa, vNrTransacao, vNrSequencia : Real;
  vDtTransacao : TDate;
begin
  vCdEmpresa := itemXmlF('CD_EMPRESA', pParams);
  vNrTransacao := itemXmlF('NR_TRANSACAO', pParams);
  vDtTransacao := itemXml('DT_TRANSACAO', pParams);
  vDsLstDevolucao := itemXml('DS_LSTDEVOLUCAO', pParams);

  if (vCdEmpresa = 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Empresa da transação não informada!', cDS_METHOD);
    return(-1); exit;
  end;
  if (vNrTransacao = 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Número da transação não informado!', cDS_METHOD);
    return(-1); exit;
  end;
  if (vDtTransacao = '') then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Data da transação não informada!', cDS_METHOD);
    return(-1); exit;
  end;
  if (vDsLstDevolucao = '') then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Item de devolução não informado!', cDS_METHOD);
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

  vNrSequencia := 1;

  if (vDsLstDevolucao <> '') then begin
    repeat
      getitem(vDsRegistro, vDsLstDevolucao, 1);

      creocc(tTRA_DEVNFITEM, -1);
      putitem_e(tTRA_DEVNFITEM, 'CD_EMPRESA', vCdEmpresa);
      putitem_e(tTRA_DEVNFITEM, 'NR_TRANSACAO', vNrTransacao);
      putitem_e(tTRA_DEVNFITEM, 'DT_TRANSACAO', vDtTransacao);
      putitem_e(tTRA_DEVNFITEM, 'NR_SEQUENCIA', vNrSequencia);
      retrieve_o(tTRA_DEVNFITEM);
      if (xStatus = -7) then begin
        retrieve_x(tTRA_DEVNFITEM);
      end;

      putitem_e(tTRA_DEVNFITEM, 'CD_OPERADOR', itemXmlF('CD_USUARIO', PARAM_GLB));
      putitem_e(tTRA_DEVNFITEM, 'DT_CADASTRO', Now);
      putitem_e(tTRA_DEVNFITEM, 'CD_EMPFAT', itemXmlF('CD_EMPFAT', vDsRegistro));
      putitem_e(tTRA_DEVNFITEM, 'NR_FATURA', itemXmlF('NR_FATURA', vDsRegistro));
      putitem_e(tTRA_DEVNFITEM, 'DT_FATURA', itemXml('DT_FATURA', vDsRegistro));
      putitem_e(tTRA_DEVNFITEM, 'NR_ITEM', itemXmlF('NR_ITEM', vDsRegistro));
      putitem_e(tTRA_DEVNFITEM, 'CD_PRODUTO', itemXmlF('CD_PRODUTO', vDsRegistro));
      putitem_e(tTRA_DEVNFITEM, 'QT_DEVOLUCAO', itemXmlF('QT_DEVOLUCAO', vDsRegistro));

      vNrSequencia := vNrSequencia + 1;

      delitem(vDsLstDevolucao, 1);
    until (vDsLstDevolucao = '');

    voParams := tTRA_DEVNFITEM.Salvar();
    if (xStatus < 0) then begin
      Result := voParams;
      return(-1); exit;
    end;
  end;

  return(0); exit;
end;

//-------------------------------------------------------------------
function T_TRASVCO016.validaCapaTransacao(pParams : String) : String;
//-------------------------------------------------------------------
const
  cDS_METHOD = 'ADICONAL=Operação: T_TRASVCO016.validaCapaTransacao()';
var
  vCdPessoa : Real;
begin
  vCdPessoa := itemXmlF('CD_PESSOA', pParams);

  if (vCdPessoa = 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Pessoa não informada!', cDS_METHOD);
    return(-1); exit;
  end;

  getParams(pParams); (* itemXmlF('CD_EMPRESA', PARAM_GLB), 'buscaRelacClasPedidoFatura' *)
  if (xStatus < 0) then begin
    return(-1); exit;
  end;
  if (gTpValidaFamiliar = 1) then begin
    clear_e(tPES_FAMILIAR);
    putitem_e(tPES_FAMILIAR, 'CD_PARENTE', vCdPessoa);
    retrieve_e(tPES_FAMILIAR);
    if (xStatus >= 0) then begin
      clear_e(tPES_PESSOA);
      putitem_e(tPES_PESSOA, 'CD_PESSOA', item_f('CD_PESSOA', tPES_FAMILIAR));
      retrieve_e(tPES_PESSOA);
      if (xStatus >= 0) then begin
        Result := SetStatus(STS_ERROR, 'GEN0001', 'Pessoa ' + FloatToStr(vCdPessoa) + ' da transação é familiar de ' + item_a('CD_PESSOA', tPES_FAMILIAR) + ' - ' + item_a('NM_PESSOA', tPES_PESSOA)!', + ' cDS_METHOD);
        return(-1); exit;
      end;
    end;
  end;

  return(0); exit;
end;

end.
