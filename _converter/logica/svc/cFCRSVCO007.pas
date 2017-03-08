unit cFCRSVCO007;

interface

(* COMPONENTES 
  ADMSVCO001 / FCCSVCO002 / FCCSVCO008 / FCCSVCO018 / FCRSVCO001
  FCRSVCO002 / FCRSVCO013 / FCRSVCO087 / FCRSVCO090 / FCRSVCO112

*)        

uses
  Classes, SysUtils, DB,
  cServiceUnf, cDataSetUnf;

type
  T_FCRSVCO007 = class(TcServiceUnf)
  private
    tF_FCR_CHEQUE,
    tF_FCR_COMISSA,
    tF_FCR_FATURAI,
    tF_FGR_LIQ,
    tF_FGR_LIQCP,
    tF_FGR_LIQITEM,
    tFCC_MOV,
    tFCR_CHEQUE,
    tFCR_COMISSAO,
    tFCR_FATURAC,
    tFCR_FATURAI,
    tFCR_RESERVAC,
    tFCR_RESERVAI,
    tFGR_LIQ,
    tFGR_LIQICRADI,
    tFGR_LIQITEMCC,
    tFGR_LIQITEMCR,
    tGER_EMPRESA,
    tGER_GRUPOEMPR : TcDatasetUnf;
    function getParam(pParams : String = '') : String;
    function setEntidade(pParams : String = '') : String;
  protected
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;    
  published
    function buscaTpDocumentoJuro(pParams : String = '') : String;
    function gravaHoraDtBaixa(pParams : String = '') : String;
    function baixarFatura(pParams : String = '') : String;
    function baixarFaturaParcial(pParams : String = '') : String;
    function gravaLiqFaturas(pParams : String = '') : String;
    function geraSeqParcela(pParams : String = '') : String;
    function baixaCheque(pParams : String = '') : String;
    function instancehandle->SetStatus(STS_ERROR, xProcerror, xProcerrorcontext, 'ADICIONAL= Erro na rotina de busca do número de liquidação. => -> confirmaendosso()')(pParams : String = '') : String;
    function instancehandle->SetStatus(STS_ERROR, xCdErro, xCtxErro, 'ADICIONAL= Erro na rotina de busca do número de liquidação. => -> confirmaendosso()')(pParams : String = '') : String;
    function instancehandle->SetStatus(STS_ERROR, xProcerror, xProcerrorcontext, 'ADICIONAL= / FCRSVCO007 -> baixaCheque() chamando FCCSVCO002->movimentaConta()')(pParams : String = '') : String;
    function instancehandle->SetStatus(STS_ERROR, xCdErro, xCtxErro, 'ADICIONAL= / FCRSVCO007 -> baixaCheque() chamando FCCSVCO002->movimentaConta()')(pParams : String = '') : String;
    function estornarLancamentosendosso(pParams : String = '') : String;
    function instancehandle->SetStatus(STS_ERROR, xProcerror, xProcerrorcontext, 'ADICIONAL= FCRSVCO007 -> estornarLancamentosendosso() chamando FCCSVCO002->movimentaConta()')(pParams : String = '') : String;
    function instancehandle->SetStatus(STS_ERROR, xCdErro, xCtxErro, 'ADICIONAL= FCRSVCO007 -> estornarLancamentosendosso() chamando FCCSVCO002->movimentaConta(')(pParams : String = '') : String;
    function calculaJurosDescontos(pParams : String = '') : String;
    function baixarFatCartao(pParams : String = '') : String;
    function gravaLiqMov(pParams : String = '') : String;
    function baixaReservaChq(pParams : String = '') : String;
    function cancelLiqFaturas(pParams : String = '') : String;
    function gravaLiqMovNegociacao(pParams : String = '') : String;
    function gravarComissaoRecebimento(pParams : String = '') : String;
    function gravaLiqICRAdic(pParams : String = '') : String;
  end;

implementation

uses
  cADMSVCO001,
  cActivate, cStatus, cFuncao, cXml, dModulo;

var
  g - Vl. acresc. parcial R,
  g - Vl. Desconto Parcial R,
  g %%,
  gDtpagamento,
  gInJuroIsencaoAberto,
  gInLogMovCtaPes,
  gInRecebimentoFat,
  gInsabadoutil,
  gInTpNotaDebitoJuro,
  gInVariacaoCambial,
  gNrdiasatraso,
  gNrdiascarenciaatraso,
  gNrdiascarenciamulta,
  gNrdiasdescpont,
  gNrPortadorJuro,
  gTpaplicacaojuros,
  gTpCobrancaBancoReceb,
  gVl12D2,
  gVlacrescjuroparcial,
  gVlacrescjurototal,
  gVldesconto,
  gVlDescontoParcial,
  gVlDescontoTotal,
  gVljuros,
  gVlmulta : String;

//---------------------------------------------------------------
constructor T_FCRSVCO007.Create(AOwner: TComponent);
//---------------------------------------------------------------
begin
  inherited Create(AOwner);
  setEntidade('');
end;

//--------------------------------
destructor T_FCRSVCO007.Destroy;
//--------------------------------
begin
  inherited Destroy;
end;

//---------------------------------------------------------------
function T_FCRSVCO007.getParam(pParams : String = '') : String;
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
  putitem(xParam, 'IN_LOG_MOV_CTAPES');
  putitem(xParam, 'IN_VARIACAO_CAMBIAL');

  xParam := T_ADMSVCO001.GetParametro(xParam);

  gInJuroIsencaoAberto := itemXml('IN_JURO_ISENCAO_ABERTO', xParam);
  gInLogMovCtaPes := itemXml('IN_LOG_MOV_CTAPES', xParam);
  gInTpNotaDebitoJuro := itemXml('IN_TP_NOTA_DEBITO_JURO', xParam);
  gInVariacaoCambial := itemXml('IN_VARIACAO_CAMBIAL', xParam);
  gNrPortadorJuro := itemXml('NR_PORTADOR_JUROS', xParam);
  gTpCobrancaBancoReceb := itemXml('TP_COBRANCA_BANCO_RECEB', xParam);

  xParamEmp := '';
  putitem(xParamEmp, 'IN_JURO_ISENCAO_ABERTO');
  putitem(xParamEmp, 'IN_TP_NOTA_DEBITO_JURO');
  putitem(xParamEmp, 'IN_VARIACAO_CAMBIAL');
  putitem(xParamEmp, 'NR_PORTADOR_JUROS');
  putitem(xParamEmp, 'TP_COBRANCA_BANCO_RECEB');

  xParamEmp := T_ADMSVCO001.GetParamEmpresa(piCdEmpresa, xParamEmp);

  gInJuroIsencaoAberto := itemXml('IN_JURO_ISENCAO_ABERTO', xParamEmp);
  gInTpNotaDebitoJuro := itemXml('IN_TP_NOTA_DEBITO_JURO', xParamEmp);
  gNrPortadorJuro := itemXml('NR_PORTADOR_JUROS', xParamEmp);
  gTpCobrancaBancoReceb := itemXml('TP_COBRANCA_BANCO_RECEB', xParamEmp);

end;

//---------------------------------------------------------------
function T_FCRSVCO007.setEntidade(pParams : String = '') : String;
//---------------------------------------------------------------
begin
  tF_FCR_CHEQUE := GetEntidade('F_FCR_CHEQUE');
  tF_FCR_COMISSA := GetEntidade('F_FCR_COMISSA');
  tF_FCR_FATURAI := GetEntidade('F_FCR_FATURAI');
  tF_FGR_LIQ := GetEntidade('F_FGR_LIQ');
  tF_FGR_LIQCP := GetEntidade('F_FGR_LIQCP');
  tF_FGR_LIQITEM := GetEntidade('F_FGR_LIQITEM');
  tFCC_MOV := GetEntidade('FCC_MOV');
  tFCR_CHEQUE := GetEntidade('FCR_CHEQUE');
  tFCR_COMISSAO := GetEntidade('FCR_COMISSAO');
  tFCR_FATURAC := GetEntidade('FCR_FATURAC');
  tFCR_FATURAI := GetEntidade('FCR_FATURAI');
  tFCR_RESERVAC := GetEntidade('FCR_RESERVAC');
  tFCR_RESERVAI := GetEntidade('FCR_RESERVAI');
  tFGR_LIQ := GetEntidade('FGR_LIQ');
  tFGR_LIQICRADI := GetEntidade('FGR_LIQICRADI');
  tFGR_LIQITEMCC := GetEntidade('FGR_LIQITEMCC');
  tFGR_LIQITEMCR := GetEntidade('FGR_LIQITEMCR');
  tGER_EMPRESA := GetEntidade('GER_EMPRESA');
  tGER_GRUPOEMPR := GetEntidade('GER_GRUPOEMPR');
end;

//--------------------------------------------------------------------
function T_FCRSVCO007.buscaTpDocumentoJuro(pParams : String) : String;
//--------------------------------------------------------------------
const
  cDS_METHOD = 'ADICIONAL=Operação: T_FCRSVCO007.buscaTpDocumentoJuro()';
begin
  getParams(pParams); (*  *)

  poTpDocumentoJuro := 1;

  if (gInTpNotaDebitoJuro = True) then begin
      poTpDocumentoJuro := 6;
  end;

  return(0); exit;
end;

//----------------------------------------------------------------
function T_FCRSVCO007.gravaHoraDtBaixa(pParams : String) : String;
//----------------------------------------------------------------
const
  cDS_METHOD = 'ADICIONAL=Operação: T_FCRSVCO007.gravaHoraDtBaixa()';
var
  (* numeric poTpDocumentoJuro : INOUT *)
  vData : TDate;
begin
  vData := item_a('DT_BAIXA', tFCR_FATURAI);
  putitem_e(tFCR_FATURAI, 'DT_BAIXA', '' + vData + ' ' + gclock' + ');

  return(0); exit;
end;

//------------------------------------------------------------
function T_FCRSVCO007.baixarFatura(pParams : String) : String;
//------------------------------------------------------------
const
  cDS_METHOD = 'ADICIONAL=Operação: T_FCRSVCO007.baixarFatura()';
var
  vFatOriginal, viParams, voParams, vDsRegistro, vDsCheque, vCdComponente, vDtSistema, vDsFatReg, vDsCobBanco : String;
  vVlJuros, vVlRestanteFatOrig, vVlFaturaDesc, vVlRestanteFat, vVlOriginal, vNrDiasJuroFuturo, vVlJuroMulta : Real;
  vVlFatura, vVlPago, vNrParcOrigem, vNrSequencia, vTpLanctoJuro, vVlIsencaoJuro, vVlIsencaoMulta, vTpCobrancaMover : Real;
  vCdEmpFatOrig, vCdClienteOrig, vNrFatOrig, vNrParcelaOrig, vVlPagoFat, vVlJuroReal, vTpCobranca : Real;
  vVlPagoAux, vVlFaturaAux, vVlPercentualProp, vVlBaixarFatura, vVlBaixarJuro, vVlBaixarDesconto : Real;
  vVlDiferenca, vTpCobrancaLista : Real;
  vDtLiq : TDate;
  vInCobranca, vInBaixaendosso : Boolean;
begin
  vDtSistema := itemXml('DT_SISTEMA', PARAM_GLB);
  gInsabadoutil := itemXmlB('IN_SABADO_UTIL', pParams);
  gNrdiascarenciaatraso := itemXmlF('NR_DIAS_CARENCIA_ATRASO', pParams);
  gNrdiascarenciamulta := itemXmlF('NR_DIAS_CARENCIA_MULTA', pParams);
  gNrdiasdescpont := itemXmlF('NR_DIAS_DESC_PONT', pParams);
  gTpaplicacaojuros := itemXmlF('TP_APLICACAO_JUROS', pParams);

  gDtpagamento := itemXml('DT_PAGAMENTO', pParams);

  vNrSequencia := itemXmlF('NR_SEQUENCIA', pParams);
  vVlOriginal := itemXmlF('VL_ORIGINAL', pParams) - itemXml('VL_ABATIMENTO', pParams);
  vVlFatura := itemXmlF('VL_FATURA', pParams);
  vVlPago := itemXmlF('VL_PAGO', pParams);
  vVlIsencaoJuro := itemXmlF('VL_ISENCAOJURO', pParams);
  vTpLanctoJuro := itemXmlF('TP_LANCTOJURO', pParams);
  vVlIsencaoMulta := itemXmlF('VL_ISENCAOMULTA', pParams);
  vNrDiasJuroFuturo := itemXmlF('NR_DIAS_JURO_FUTURO', pParams);

  gVlacrescjurototal := itemXmlF('VL_ACRESC_JURO_TOTAL', pParams);
  gVlacrescjuroparcial := itemXmlF('VL_ACRESC_JURO_PARCIAL', pParams);
  vCdComponente := itemXmlF('CD_COMPONENTE', pParams);

  gNrdiasatraso := itemXmlF('NR_DIASATRASO', pParams);
  gVljuros := itemXmlF('VL_JUROS', pParams);
  gVlmulta := itemXmlF('VL_MULTA', pParams);
  gVldesconto := itemXmlF('VL_DESCONTO', pParams);

  gInRecebimentoFat := itemXmlB('IN_RECEBIMENTO_FAT', pParams);

  gVlDescontoTotal := itemXmlF('VL_DESCONTO_TOTAL', pParams);
  gVlDescontoParcial := itemXmlF('VL_DESCONTO_PARCIAL', pParams);

  vInBaixaendosso := itemXmlB('IN_BAIXAendOSSO', pParams);
  if (vInBaixaendosso = '') then begin
    vInBaixaendosso := False;
  end;
  if (itemXml('CD_EMPRESA', pParams) = '') then begin
    Result := SetStatus(STS_AVISO, 'GEN001', 'Código de empresa não informada', '');
    return(-1); exit;
  end;
  if (itemXml('CD_CLIENTE', pParams) = '') then begin
    Result := SetStatus(STS_AVISO, 'GEN001', 'Código de cliente não informado', '');
    return(-1); exit;
  end;
  if (itemXml('NR_FAT', pParams) = '') then begin
    Result := SetStatus(STS_AVISO, 'GEN001', 'Número da fatura não informado', '');
    return(-1); exit;
  end;
  if (itemXml('NR_PARCELA', pParams) = '') then begin
    Result := SetStatus(STS_AVISO, 'GEN001', 'Número da parcela da fatura não informado', '');
    return(-1); exit;
  end;
  if (itemXml('VL_PAGO', pParams) = '') then begin
    Result := SetStatus(STS_AVISO, 'GEN001', 'Valor da fatura não informado', '');
    return(-1); exit;
  end;

  clear_e(tFCR_FATURAI);
  putitem_e(tFCR_FATURAI, 'CD_EMPRESA', itemXmlF('CD_EMPRESA', pParams));
  putitem_e(tFCR_FATURAI, 'CD_CLIENTE', itemXmlF('CD_CLIENTE', pParams));
  putitem_e(tFCR_FATURAI, 'NR_FAT', itemXmlF('NR_FAT', pParams));
  putitem_e(tFCR_FATURAI, 'NR_PARCELA', itemXmlF('NR_PARCELA', pParams));
  retrieve_e(tFCR_FATURAI);
  if (xStatus < 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN001', 'Fatura não encontrada', '');
    return(-1); exit;
  end;

  gInJuroIsencaoAberto := '';

  getParams(pParams); (*  *)
  if (xStatus < 0) then begin
    return(-1); exit;
  end;

  vTpCobranca := item_f('TP_COBRANCA', tFCR_FATURAI);
  vNrParcOrigem := item_f('NR_PARCELA', tFCR_FATURAI);
  vFatOriginal := '';

  putlistitensocc_e(vFatOriginal, tFCR_FATURAI);
  if (vVlPago = vVlFatura)  and (itemXml('IN_PARCIAL', pParams) <> True) then begin
    putitem_e(tFCR_FATURAI, 'VL_DESCONTO', itemXmlF('VL_DESCONTO', pParams));
    putitem_e(tFCR_FATURAI, 'VL_JUROS', itemXmlF('VL_JUROS', pParams));
    putitem_e(tFCR_FATURAI, 'VL_ACRESCIMO', itemXmlF('VL_ACRESCIMO', pParams));
    putitem_e(tFCR_FATURAI, 'VL_DESPFIN', itemXmlF('VL_DESPFIN', pParams));
    putitem_e(tFCR_FATURAI, 'VL_ABATIMENTO', itemXmlF('VL_ABATIMENTO', pParams));

    if (itemXml('IN_BAIXA_RENEGOCIACAO', pParams) = True) then begin
      putitem_e(tFCR_FATURAI, 'TP_BAIXA', 9);
    end else begin
      putitem_e(tFCR_FATURAI, 'TP_BAIXA', 1);
    end;
    if (itemXml('IN_BAIXAVIABANCO', pParams) = True) then begin
      putitem_e(tFCR_FATURAI, 'TP_BAIXA', 12);
    end;
    if (itemXml('IN_BAIXAFUNC', pParams) = True) then begin
      putitem_e(tFCR_FATURAI, 'TP_BAIXA', 24);
    end;
    if (vInBaixaendosso = True) then begin
      putitem_e(tFCR_FATURAI, 'TP_BAIXA', 28);
      putitem_e(tFCR_FATURAI, 'TP_COBRANCA', 13);
    end;

    putitem_e(tFCR_FATURAI, 'CD_OPERBAIXA', itemXmlF('CD_USUARIO', PARAM_GLB));
    putitem_e(tFCR_FATURAI, 'VL_PAGO', itemXmlF('VL_PAGO', pParams));

    if (item_a('DT_LIQ', tFCR_FATURAI) <> '') then begin
      Result := SetStatus(STS_ERROR, 'GEN001', 'Fatura já liquidada por outro processo ou manutenção.Empresa: ' + cd_empresa + '.FCR_FATURAI Cliente: ' + cd_cliente + '.FCR_FATURAI Fatura: ' + nr_fat + '.FCR_FATURAI Parcela: ' + nr_parcela + '.FCR_FATURAI', '');
      return(-1); exit;
    end;
    putitem_e(tFCR_FATURAI, 'CD_EMPLIQ', itemXmlF('CD_EMPLIQ', pParams));
    putitem_e(tFCR_FATURAI, 'DT_LIQ', itemXml('DT_LIQ', pParams));
    putitem_e(tFCR_FATURAI, 'NR_SEQLIQ', itemXmlF('NR_SEQLIQ', pParams));
    if (gDtpagamento <> '') then begin
      putitem_e(tFCR_FATURAI, 'DT_BAIXA', gDtpagamento);
    end else begin
      putitem_e(tFCR_FATURAI, 'DT_BAIXA', itemXml('DT_SISTEMA', PARAM_GLB));
    end;

    voParams := gravaHoraDtBaixa(viParams); (* *)
    if (vCdComponente <> '') then begin
      putitem_e(tFCR_FATURAI, 'CD_COMPONENTE', vCdComponente);
    end;

    putitem_e(tFCR_FATURAI, 'CD_OPERADOR', itemXmlF('CD_USUARIO', PARAM_GLB));
    putitem_e(tFCR_FATURAI, 'DT_CADASTRO', Now);
    if (xStatus = -11) then begin
      Result := SetStatus(STS_ERROR, 'GEN001', 'Fatura sendo utilizada em outro processo ou manutenção.Empresa: ' + cd_empresa + '.FCR_FATURAI Cliente: ' + cd_cliente + '.FCR_FATURAI Fatura: ' + nr_fat + '.FCR_FATURAI Parcela: ' + nr_parcela + '.FCR_FATURAI', '');
      return(-1); exit;
    end;
    if (item_f('VL_PAGO', tFCR_FATURAI) <> (item_f('VL_FATURA', tFCR_FATURAI) + item_f('VL_ACRESCIMO', tFCR_FATURAI) - (item_f('VL_DESCONTO', tFCR_FATURAI) + item_f('VL_ABATIMENTO', tFCR_FATURAI) + item_f('VL_OUTDESC', tFCR_FATURAI) + item_f('VL_IMPOSTO', tFCR_FATURAI)))) then begin
      Result := SetStatus(STS_ERROR, 'GEN001', 'Valores de baixa do título incorretos.Empresa: ' + cd_empresa + '.FCR_FATURAI Cliente: ' + cd_cliente + '.FCR_FATURAI Fatura: ' + nr_fat + '.FCR_FATURAI Parcela: ' + nr_parcela + '.FCR_FATURAI', '');
      return(-1); exit;
    end;

    vDsFatReg := '';
    putlistitensocc_e(vDsFatReg, tFCR_FATURAI);
    viParams := '';
    putitemXml(viParams, 'DS_FATURAI', vDsFatReg);
    putitemXml(viParams, 'CD_COMPONENTE', FCRSVCO007);
    putitemXml(viParams, 'DS_CHEQUE', '');
    putitemXml(viParams, 'IN_SEMCOMISSAO', True);
    putitemXml(viParams, 'IN_SEMIMPOSTO', True);
    putitemXml(viParams, 'IN_ALTSOFATURAI', True);
    voParams := activateCmp('FCRSVCO001', 'geraFatura', viParams); (*,,,, *)
    if (xStatus < 0) then begin
      Result := voParams;
      return(-1); exit;
    end;
    if (vInBaixaendosso = False) then begin
      viParams := '';

      viParams := pParams;
      putitemXml(viParams, 'IN_NAOSOMA', True);
      putitemXml(viParams, 'VL_PAGO', item_f('VL_PAGO', tFCR_FATURAI));
      voParams := gravaLiqFaturas(viParams); (* PARAM_GLB, viParams, voParams, xCdErro, xCtxErro *)
      if (xStatus < 0) then begin
        Result := voParams;
        return(-1); exit;
      end;
    end;
    if (itemXml('DS_COMISSAO', pParams) <> '') then begin
      viParams := '';
      putitemXml(viParams, 'CD_EMPRESA', item_f('CD_EMPRESA', tFCR_FATURAI));
      putitemXml(viParams, 'CD_CLIENTE', item_f('CD_CLIENTE', tFCR_FATURAI));
      putitemXml(viParams, 'NR_FAT', item_f('NR_FAT', tFCR_FATURAI));
      putitemXml(viParams, 'NR_PARCELA', item_f('NR_PARCELA', tFCR_FATURAI));
      voParams := activateCmp('FCRSVCO013', 'atualizaTransfComissao', viParams); (*,,,, *)
      if (xStatus < 0) then begin
        Result := voParams;
        return(-1); exit;
      end;
    end;
    if (gVlacrescjuroparcial > 0) then begin
      viParams := '';
      putitemXml(viParams, 'CD_EMPRESA', item_f('CD_EMPRESA', tFCR_FATURAI));
      putitemXml(viParams, 'CD_CLIENTE', item_f('CD_CLIENTE', tFCR_FATURAI));
      putitemXml(viParams, 'NR_FAT', item_f('NR_FAT', tFCR_FATURAI));
      putitemXml(viParams, 'NR_PARCELA', item_f('NR_PARCELA', tFCR_FATURAI));
      putitemXml(viParams, 'DS_OBSERVACAO', 'Vl. acresc. juro receb. Rg ' + Vlacrescjurototalg + ' - Vl. acresc. parcial R ' + FloatToStr(gVlacrescjuroparcial')) + ';
      putitemXml(viParams, 'CD_COMPONENTE', vCdComponente);
      voParams := activateCmp('FCRSVCO001', 'gravaObsFatura', viParams); (*,,,, *)
      if (xStatus < 0) then begin
        Result := voParams;
        return(-1); exit;
      end;
    end;
    if (gVlDescontoParcial > 0) then begin
      viParams := '';
      putitemXml(viParams, 'CD_EMPRESA', item_f('CD_EMPRESA', tFCR_FATURAI));
      putitemXml(viParams, 'CD_CLIENTE', item_f('CD_CLIENTE', tFCR_FATURAI));
      putitemXml(viParams, 'NR_FAT', item_f('NR_FAT', tFCR_FATURAI));
      putitemXml(viParams, 'NR_PARCELA', item_f('NR_PARCELA', tFCR_FATURAI));
      putitemXml(viParams, 'DS_OBSERVACAO', 'Vl. Desconto Total. Rg ' + VlDescontoTotalg + ' - Vl. Desconto Parcial R ' + FloatToStr(gVlDescontoParcial')) + ';
      putitemXml(viParams, 'CD_COMPONENTE', vCdComponente);
      voParams := activateCmp('FCRSVCO001', 'gravaObsFatura', viParams); (*,,,, *)
      if (xStatus < 0) then begin
        Result := voParams;
        return(-1); exit;
      end;
    end;
    if (gNrdiasatraso > 0)  and (gVljuros = 0)  and (gVlmulta = 0)  and (gVldesconto > 0) then begin
      viParams := '';
      putitemXml(viParams, 'CD_EMPRESA', item_f('CD_EMPRESA', tFCR_FATURAI));
      putitemXml(viParams, 'CD_CLIENTE', item_f('CD_CLIENTE', tFCR_FATURAI));
      putitemXml(viParams, 'NR_FAT', item_f('NR_FAT', tFCR_FATURAI));
      putitemXml(viParams, 'NR_PARCELA', item_f('NR_PARCELA', tFCR_FATURAI));
      putitemXml(viParams, 'DS_OBSERVACAO', 'Fatura recebida com atraso e com desconto de Rg ' + Vldescontog') + ';
      putitemXml(viParams, 'CD_COMPONENTE', vCdComponente);
      voParams := activateCmp('FCRSVCO001', 'gravaObsFatura', viParams); (*,,,, *)
      if (xStatus < 0) then begin
        Result := voParams;
        return(-1); exit;
      end;
    end;

  end else begin
    vVlOriginal := 0;

    vVlOriginal := itemXmlF('VL_ORIGINAL', pParams) - item_f('VL_ABATIMENTO', tFCR_FATURAI) - item_f('VL_IMPOSTO', tFCR_FATURAI) - item_f('VL_OUTDESC', tFCR_FATURAI) + item_f('VL_DESPFIN', tFCR_FATURAI) + item_f('VL_OUTACRES', tFCR_FATURAI);

    putitem_e(tFCR_FATURAI, 'TP_BAIXA', 1);
    if (itemXml('IN_BAIXAVIABANCO', pParams) = True) then begin
      putitem_e(tFCR_FATURAI, 'TP_BAIXA', 12);
    end;
    if (itemXml('IN_BAIXAFUNC', pParams) = True) then begin
      putitem_e(tFCR_FATURAI, 'TP_BAIXA', 24);
    end;
    if (vInBaixaendosso) then begin
      putitem_e(tFCR_FATURAI, 'TP_BAIXA', 28);
      putitem_e(tFCR_FATURAI, 'TP_COBRANCA', 13);
    end;

    putitem_e(tFCR_FATURAI, 'CD_OPERBAIXA', itemXmlF('CD_USUARIO', PARAM_GLB));
    vVlRestanteFat := item_f('VL_FATURA', tFCR_FATURAI);
    putitem_e(tFCR_FATURAI, 'VL_DESCONTO', itemXmlF('VL_DESCONTO', pParams));
    putitem_e(tFCR_FATURAI, 'VL_JUROS', itemXmlF('VL_JUROS', pParams));
    putitem_e(tFCR_FATURAI, 'VL_ACRESCIMO', itemXmlF('VL_ACRESCIMO', pParams));
    putitem_e(tFCR_FATURAI, 'VL_FATURA', vVlPago - (item_f('VL_ACRESCIMO', tFCR_FATURAI) - (item_f('VL_ABATIMENTO', tFCR_FATURAI) + item_f('VL_IMPOSTO', tFCR_FATURAI) + item_f('VL_OUTDESC', tFCR_FATURAI) + itemXmlF('VL_DESCONTO', pParams))));

    if (item_f('VL_FATURA', tFCR_FATURAI) < 0) then begin
      vVlOriginal := 0;
      vVlOriginal := itemXmlF('VL_ORIGINAL', pParams);
      if (vVlPago < vVlOriginal) then begin
        vVlOriginal := vVlPago - item_f('VL_ABATIMENTO', tFCR_FATURAI) + item_f('VL_DESPFIN', tFCR_FATURAI) + item_f('VL_OUTACRES', tFCR_FATURAI) - item_f('VL_IMPOSTO', tFCR_FATURAI) - item_f('VL_OUTDESC', tFCR_FATURAI);
      end else begin
        vVlOriginal := itemXmlF('VL_ORIGINAL', pParams) - item_f('VL_ABATIMENTO', tFCR_FATURAI) + item_f('VL_DESPFIN', tFCR_FATURAI) + item_f('VL_OUTACRES', tFCR_FATURAI) - item_f('VL_IMPOSTO', tFCR_FATURAI) - item_f('VL_OUTDESC', tFCR_FATURAI);
      end;
      vVlPagoAux := vVlPago   - gVlacrescjuroparcial + gVlDescontoParcial - (item_f('VL_OUTACRES', tFCR_FATURAI) + item_f('VL_DESPFIN', tFCR_FATURAI)) + (item_f('VL_ABATIMENTO', tFCR_FATURAI) + item_f('VL_OUTDESC', tFCR_FATURAI) + item_f('VL_IMPOSTO', tFCR_FATURAI));

      vVlFaturaAux := vVlFatura - gVlacrescjuroparcial + gVlDescontoParcial - (item_f('VL_OUTACRES', tFCR_FATURAI) + item_f('VL_DESPFIN', tFCR_FATURAI)) + (item_f('VL_ABATIMENTO', tFCR_FATURAI) + item_f('VL_OUTDESC', tFCR_FATURAI) + item_f('VL_IMPOSTO', tFCR_FATURAI));

      vVlPercentualProp := vVlPagoAux / vVlFaturaAux;
      vVlPercentualProp := rounded(vVlPercentualProp, 6);
      vVlBaixarFatura := vVlOriginal - gVlacrescjuroparcial + gVlDescontoParcial - (item_f('VL_OUTACRES', tFCR_FATURAI) + item_f('VL_DESPFIN', tFCR_FATURAI)) + (item_f('VL_ABATIMENTO', tFCR_FATURAI) + item_f('VL_OUTDESC', tFCR_FATURAI) + item_f('VL_IMPOSTO', tFCR_FATURAI));
      vVlBaixarFatura := vVlBaixarFatura * vVlPercentualProp;
      vVlBaixarFatura := rounded(vVlBaixarFatura, 2);
      vVlJuroMulta := gVlJuros + gVlMulta;
      vVlBaixarJuro := (vVlJuroMulta - gVlacrescjuroparcial) * vVlPercentualProp;
      vVlBaixarJuro := rounded(vVlBaixarJuro, 2);
      vVlBaixarDesconto := (gVlDesconto + gVlDescontoParcial) * vVlPercentualProp;
      vVlBaixarDesconto := rounded(vVlBaixarDesconto, 2);
      putitem_e(tFCR_FATURAI, 'VL_FATURA', vVlBaixarFatura);
      putitem_e(tFCR_FATURAI, 'VL_JUROS', vVlBaixarJuro);
      putitem_e(tFCR_FATURAI, 'VL_DESCONTO', vVlBaixarDesconto);
      putitem_e(tFCR_FATURAI, 'VL_ACRESCIMO', item_f('VL_JUROS', tFCR_FATURAI) + item_f('VL_OUTACRES', tFCR_FATURAI) + item_f('VL_DESPFIN', tFCR_FATURAI));
    end;
    if ((vVlIsencaoJuro + vVlIsencaoMulta) > 0)  and (vVlPago <> (item_f('VL_FATURA', tFCR_FATURAI) + (item_f('VL_JUROS', tFCR_FATURAI) + item_f('VL_DESPFIN', tFCR_FATURAI) + item_f('VL_OUTACRES', tFCR_FATURAI)) - (item_f('VL_DESCONTO', tFCR_FATURAI) + item_f('VL_ABATIMENTO', tFCR_FATURAI) + item_f('VL_IMPOSTO', tFCR_FATURAI) + item_f('VL_OUTDESC', tFCR_FATURAI)))) then begin
      vVlDiferenca := vVlPago + (item_f('VL_DESCONTO', tFCR_FATURAI) + item_f('VL_ABATIMENTO', tFCR_FATURAI) + item_f('VL_OUTDESC', tFCR_FATURAI) + item_f('VL_IMPOSTO', tFCR_FATURAI)) - (item_f('VL_OUTACRES', tFCR_FATURAI) + item_f('VL_DESPFIN', tFCR_FATURAI) + item_f('VL_JUROS', tFCR_FATURAI) + item_f('VL_FATURA', tFCR_FATURAI));
      putitem_e(tFCR_FATURAI, 'VL_FATURA', item_f('VL_FATURA', tFCR_FATURAI) + vVlDiferenca);
    end;

    vVlRestanteFat := vVlRestanteFat - item_f('VL_FATURA', tFCR_FATURAI);
    putitem_e(tFCR_FATURAI, 'VL_PAGO', vVlPago);
    putitem_e(tFCR_FATURAI, 'CD_EMPLIQ', itemXmlF('CD_EMPLIQ', pParams));
    if (item_a('DT_LIQ', tFCR_FATURAI) <> '') then begin
      Result := SetStatus(STS_ERROR, 'GEN001', 'Fatura já liquidada por outro processo ou manutenção.Empresa: ' + cd_empresa + '.FCR_FATURAI Cliente: ' + cd_cliente + '.FCR_FATURAI Fatura: ' + nr_fat + '.FCR_FATURAI Parcela: ' + nr_parcela + '.FCR_FATURAI', '');
      return(-1); exit;
    end;

    putitem_e(tFCR_FATURAI, 'DT_LIQ', itemXml('DT_LIQ', pParams));
    putitem_e(tFCR_FATURAI, 'NR_SEQLIQ', itemXmlF('NR_SEQLIQ', pParams));
    if (gDtpagamento <> '') then begin
      putitem_e(tFCR_FATURAI, 'DT_BAIXA', gDtpagamento);
    end else begin
      putitem_e(tFCR_FATURAI, 'DT_BAIXA', itemXml('DT_SISTEMA', PARAM_GLB));
    end;

    voParams := gravaHoraDtBaixa(viParams); (* *)

    if (vCdComponente <> '') then begin
      putitem_e(tFCR_FATURAI, 'CD_COMPONENTE', vCdComponente);
    end;
    putitem_e(tFCR_FATURAI, 'CD_OPERADOR', itemXmlF('CD_USUARIO', PARAM_GLB));
    putitem_e(tFCR_FATURAI, 'DT_CADASTRO', Now);

    if (xStatus = -11) then begin
      Result := SetStatus(STS_ERROR, 'GEN001', 'Fatura sendo utilizada em outro processo ou manutenção.Empresa: ' + cd_empresa + '.FCR_FATURAI Cliente: ' + cd_cliente + '.FCR_FATURAI Fatura: ' + nr_fat + '.FCR_FATURAI Parcela: ' + nr_parcela + '.FCR_FATURAI', '');
      return(-1); exit;
    end;
    if (item_f('VL_PAGO', tFCR_FATURAI) <> (item_f('VL_FATURA', tFCR_FATURAI) + item_f('VL_ACRESCIMO', tFCR_FATURAI) - (item_f('VL_DESCONTO', tFCR_FATURAI) + item_f('VL_ABATIMENTO', tFCR_FATURAI) + item_f('VL_OUTDESC', tFCR_FATURAI) + item_f('VL_IMPOSTO', tFCR_FATURAI)))) then begin
      Result := SetStatus(STS_ERROR, 'GEN001', 'Valores de baixa do título incorretos.Empresa: ' + cd_empresa + '.FCR_FATURAI Cliente: ' + cd_cliente + '.FCR_FATURAI Fatura: ' + nr_fat + '.FCR_FATURAI Parcela: ' + nr_parcela + '.FCR_FATURAI', '');
      return(-1); exit;
    end;

    vDsFatReg := '';
    putlistitensocc_e(vDsFatReg, tFCR_FATURAI);
    viParams := '';
    putitemXml(viParams, 'DS_FATURAI', vDsFatReg);
    putitemXml(viParams, 'CD_COMPONENTE', FCRSVCO007);
    putitemXml(viParams, 'DS_CHEQUE', '');
    putitemXml(viParams, 'IN_SEMCOMISSAO', True);
    putitemXml(viParams, 'IN_SEMIMPOSTO', True);
    putitemXml(viParams, 'IN_ALTSOFATURAI', True);
    voParams := activateCmp('FCRSVCO001', 'geraFatura', viParams); (*,,,, *)
    if (xStatus < 0) then begin
      Result := voParams;
      return(-1); exit;
    end;

    vCdEmpFatOrig := item_f('CD_EMPRESA', tFCR_FATURAI);
    vCdClienteOrig := item_f('CD_CLIENTE', tFCR_FATURAI);
    vNrFatOrig := item_f('NR_FAT', tFCR_FATURAI);
    vNrParcelaOrig := item_f('NR_PARCELA', tFCR_FATURAI);

    if (vInBaixaendosso = False) then begin
      viParams := '';

      viParams := pParams;
      putitemXml(viParams, 'IN_NAOSOMA', True);
      putitemXml(viParams, 'TP_DOCUMENTO', item_f('TP_DOCUMENTO', tFCR_FATURAI));
      putitemXml(viParams, 'VL_PAGO', item_f('VL_PAGO', tFCR_FATURAI));
      voParams := gravaLiqFaturas(viParams); (* PARAM_GLB, viParams, voParams, xCdErro, xCtxErro *)
      if (xStatus < 0) then begin
        Result := voParams;
        return(-1); exit;
      end;
    end;
    if (gVlacrescjuroparcial > 0) then begin
      viParams := '';
      putitemXml(viParams, 'CD_EMPRESA', item_f('CD_EMPRESA', tFCR_FATURAI));
      putitemXml(viParams, 'CD_CLIENTE', item_f('CD_CLIENTE', tFCR_FATURAI));
      putitemXml(viParams, 'NR_FAT', item_f('NR_FAT', tFCR_FATURAI));
      putitemXml(viParams, 'NR_PARCELA', item_f('NR_PARCELA', tFCR_FATURAI));
      putitemXml(viParams, 'DS_OBSERVACAO', 'Vl. acresc. juro receb. Rg ' + Vlacrescjurototalg + ' - Vl. acresc. parcial R ' + FloatToStr(gVlacrescjuroparcial')) + ';
      putitemXml(viParams, 'CD_COMPONENTE', vCdComponente);
      voParams := activateCmp('FCRSVCO001', 'gravaObsFatura', viParams); (*,,,, *)
      if (xStatus < 0) then begin
        Result := voParams;
        return(-1); exit;
      end;
    end;
    if (gVlDescontoParcial > 0) then begin
      viParams := '';
      putitemXml(viParams, 'CD_EMPRESA', item_f('CD_EMPRESA', tFCR_FATURAI));
      putitemXml(viParams, 'CD_CLIENTE', item_f('CD_CLIENTE', tFCR_FATURAI));
      putitemXml(viParams, 'NR_FAT', item_f('NR_FAT', tFCR_FATURAI));
      putitemXml(viParams, 'NR_PARCELA', item_f('NR_PARCELA', tFCR_FATURAI));
      putitemXml(viParams, 'DS_OBSERVACAO', 'Vl. Desconto Total. Rg ' + VlDescontoTotalg + ' - Vl. Desconto Parcial R ' + FloatToStr(gVlDescontoParcial')) + ';
      putitemXml(viParams, 'CD_COMPONENTE', vCdComponente);
      voParams := activateCmp('FCRSVCO001', 'gravaObsFatura', viParams); (*,,,, *)
      if (xStatus < 0) then begin
        Result := voParams;
        return(-1); exit;
      end;
    end;
    if (gNrdiasatraso > 0)  and (gVldesconto > 0) then begin
      viParams := '';
      putitemXml(viParams, 'CD_EMPRESA', item_f('CD_EMPRESA', tFCR_FATURAI));
      putitemXml(viParams, 'CD_CLIENTE', item_f('CD_CLIENTE', tFCR_FATURAI));
      putitemXml(viParams, 'NR_FAT', item_f('NR_FAT', tFCR_FATURAI));
      putitemXml(viParams, 'NR_PARCELA', item_f('NR_PARCELA', tFCR_FATURAI));
      putitemXml(viParams, 'DS_OBSERVACAO', 'Fatura recebida com atraso e com desconto de Rg ' + Vldescontog') + ';
      putitemXml(viParams, 'CD_COMPONENTE', vCdComponente);
      voParams := activateCmp('FCRSVCO001', 'gravaObsFatura', viParams); (*,,,, *)
      if (xStatus < 0) then begin
        Result := voParams;
        return(-1); exit;
      end;
    end;
    if (itemXml('DS_COMISSAO', pParams) <> '') then begin
      viParams := '';
      putitemXml(viParams, 'CD_EMPRESA', item_f('CD_EMPRESA', tFCR_FATURAI));
      putitemXml(viParams, 'CD_CLIENTE', item_f('CD_CLIENTE', tFCR_FATURAI));
      putitemXml(viParams, 'NR_FAT', item_f('NR_FAT', tFCR_FATURAI));
      putitemXml(viParams, 'NR_PARCELA', item_f('NR_PARCELA', tFCR_FATURAI));
      voParams := activateCmp('FCRSVCO013', 'atualizaTransfComissao', viParams); (*,,,, *)
      if (xStatus < 0) then begin
        Result := voParams;
        return(-1); exit;
      end;
    end;
    if (vVlRestanteFat > 0) then begin
      clear_e(tFCR_FATURAI);
      creocc(tFCR_FATURAI, -1);
      getlistitensocc_e(vFatOriginal, tFCR_FATURAI);

      viParams := '';

      putitemXml(viParams, 'TP_PARCELA', 2);
      voParams := geraSeqParcela(viParams); (* viParams, voParams, xCdErro, xCtxErro *)
      if (xStatus < 0) then begin
        Result := voParams;
        return(-1); exit;
      end;
      putitem_e(tFCR_FATURAI, 'NR_PARCELAORIGEM', vNrParcOrigem);
      putitem_e(tFCR_FATURAI, 'NR_PARCELA', itemXmlF('NR_PARCELA', voParams));
      putitem_e(tFCR_FATURAI, 'VL_JUROS', '');
      putitem_e(tFCR_FATURAI, 'VL_DESCONTO', '');
      putitem_e(tFCR_FATURAI, 'VL_FATURA', vVlRestanteFat);
      putitem_e(tFCR_FATURAI, 'VL_PAGO', 0);
      putitem_e(tFCR_FATURAI, 'VL_ACRESCIMO', '');
      putitem_e(tFCR_FATURAI, 'VL_OUTDESC', '');
      putitem_e(tFCR_FATURAI, 'VL_OUTACRES', '');
      putitem_e(tFCR_FATURAI, 'VL_ABATIMENTO', '');
      putitem_e(tFCR_FATURAI, 'VL_DESPFIN', '');
      putitem_e(tFCR_FATURAI, 'VL_IMPOSTO', '');
      putitem_e(tFCR_FATURAI, 'CD_OPERADOR', itemXmlF('CD_USUARIO', PARAM_GLB));
      putitem_e(tFCR_FATURAI, 'DT_CADASTRO', Now);
      putitem_e(tFCR_FATURAI, 'CD_OPERCAD', itemXmlF('CD_USUARIO', PARAM_GLB));
      putitem_e(tFCR_FATURAI, 'DT_OPERCAD', Now);
      putitem_e(tFCR_FATURAI, 'TP_INCLUSAO', 2);
      putitem_e(tFCR_FATURAI, 'NR_NOSSONUMERO', '');
      putitem_e(tFCR_FATURAI, 'DS_DACNOSSONR', '');
      putitem_e(tFCR_FATURAI, 'TP_COBRANCA', 0);

      if (vTpCobranca = 16)  or (vTpCobranca = 17) then begin
        putitem_e(tFCR_FATURAI, 'TP_COBRANCA', vTpCobranca);

      end else begin
        if (gTpCobrancaBancoReceb <> '') then begin
          vTpCobrancaMover := '';
          vDsCobBanco := gTpCobrancaBancoReceb;
          repeat
            getitem(vTpCobrancaLista, vDsCobBanco, 1);
            if (vTpCobrancaLista = vTpCobranca) then begin
              vTpCobrancaMover := vTpCobrancaLista;
            end;
            delitem(vDsCobBanco, 1);
          until (vDsCobBanco = '');
          if (vTpCobrancaMover > 0) then begin
            putitem_e(tFCR_FATURAI, 'TP_COBRANCA', vTPCobrancaMover);
          end;
        end;
      end;
      if (vCdComponente <> '') then begin
        putitem_e(tFCR_FATURAI, 'CD_COMPONENTE', vCdComponente);
      end;

      vDsFatReg := '';
      putlistitensocc_e(vDsFatReg, tFCR_FATURAI);
      viParams := '';
      putitemXml(viParams, 'DS_FATURAI', vDsFatReg);
      putitemXml(viParams, 'CD_COMPONENTE', FCRSVCO007);
      putitemXml(viParams, 'DS_CHEQUE', '');
      putitemXml(viParams, 'IN_SEMCOMISSAO', True);
      putitemXml(viParams, 'IN_SEMIMPOSTO', True);
      putitemXml(viParams, 'IN_ALTSOFATURAI', False);
      voParams := activateCmp('FCRSVCO001', 'geraFatura', viParams); (*,,,, *)
      if (xStatus < 0) then begin
        Result := voParams;
        return(-1); exit;
      end;
      if (vInBaixaendosso = False) then begin
        viParams := '';

        viParams := pParams;
        vNrSequencia := vNrSequencia + 1;
        putitemXml(viParams, 'NR_FAT', item_f('NR_FAT', tFCR_FATURAI));
        putitemXml(viParams, 'NR_PARCELA', item_f('NR_PARCELA', tFCR_FATURAI));
        putitemXml(viParams, 'VL_FATURA', item_f('VL_FATURA', tFCR_FATURAI));
        putitemXml(viParams, 'NR_SEQUENCIA', vNrSequencia);
        putitemXml(viParams, 'TP_DOCUMENTO', item_f('TP_DOCUMENTO', tFCR_FATURAI));
        putitemXml(viParams, 'TP_TIPOREG', 2);
        putitemXml(viParams, 'IN_NAOSOMA', True);
        if (gInRecebimentoFat = True) then begin
          putitemXml(viParams, 'VL_PAGO', item_f('VL_FATURA', tFCR_FATURAI));
        end else begin
          putitemXml(viParams, 'VL_PAGO', 0);
        end;

        voParams := gravaLiqFaturas(viParams); (* PARAM_GLB, viParams, voParams, xCdErro, xCtxErro *)
        if (xStatus < 0) then begin
          Result := voParams;
          return(-1); exit;
        end;
      end;

      viParams := '';
      putitemXml(viParams, 'CD_EMPFATORIG', vCdEmpFatOrig);
      putitemXml(viParams, 'CD_CLIENTEORIG', vCdClienteOrig);
      putitemXml(viParams, 'NR_FATORIG', vNrFatOrig);
      putitemXml(viParams, 'NR_PARCELAORIG', vNrParcelaOrig);
      putitemXml(viParams, 'CD_EMPRESA', item_f('CD_EMPRESA', tFCR_FATURAI));
      putitemXml(viParams, 'CD_CLIENTE', item_f('CD_CLIENTE', tFCR_FATURAI));
      putitemXml(viParams, 'NR_FAT', item_f('NR_FAT', tFCR_FATURAI));
      putitemXml(viParams, 'NR_PARCELA', item_f('NR_PARCELA', tFCR_FATURAI));
      voParams := gravarComissaoRecebimento(viParams); (* PARAM_GLB, viParams, voParams, xCdErro, xCtxErro *)
      if (xStatus < 0) then begin
        Result := voParams;
        return(-1); exit;
      end;

      viParams := '';
      putitemXml(viParams, 'CD_EMPRESA', item_f('CD_EMPRESA', tFCR_FATURAI));
      putitemXml(viParams, 'CD_CLIENTE', item_f('CD_CLIENTE', tFCR_FATURAI));
      putitemXml(viParams, 'NR_FAT', item_f('NR_FAT', tFCR_FATURAI));
      putitemXml(viParams, 'NR_PARCELA', item_f('NR_PARCELA', tFCR_FATURAI));
      putitemXml(viParams, 'IN_NOVAFATURA', True);
      voParams := activateCmp('FCRSVCO090', 'gravarClassificacaoFatura', viParams); (*,,,, *)
      if (xStatus < 0) then begin
        Result := voParams;
        return(-1); exit;
      end;
      if (item_f('TP_DOCUMENTO', tFCR_FATURAI) = 2) then begin
        clear_e(tF_FCR_CHEQUE);
        putitem_e(tF_FCR_CHEQUE, 'CD_EMPRESA', vCdEmpFatOrig);
        putitem_e(tF_FCR_CHEQUE, 'CD_CLIENTE', vCdClienteOrig);
        putitem_e(tF_FCR_CHEQUE, 'NR_FAT', vNrFatOrig);
        putitem_e(tF_FCR_CHEQUE, 'NR_PARCELA', vNrParcelaOrig);
        retrieve_e(tF_FCR_CHEQUE);
        if (xStatus >= 0)  and (item_a('DT_DEVOLUCAO1', tF_FCR_CHEQUE) <> '') then begin
          creocc(tFCR_CHEQUE, -1);
          putitem_e(tFCR_CHEQUE, 'CD_EMPRESA', item_f('CD_EMPRESA', tFCR_FATURAI));
          putitem_e(tFCR_CHEQUE, 'CD_CLIENTE', item_f('CD_CLIENTE', tFCR_FATURAI));
          putitem_e(tFCR_CHEQUE, 'NR_FAT', item_f('NR_FAT', tFCR_FATURAI));
          putitem_e(tFCR_CHEQUE, 'NR_PARCELA', item_f('NR_PARCELA', tFCR_FATURAI));
          retrieve_o(tFCR_CHEQUE);
          if (xStatus = 4)  or (xStatus = -7) then begin
            retrieve_x(tFCR_CHEQUE);
          end;
          putitem_e(tFCR_CHEQUE, 'CD_MOTDEVCHQ', item_f('CD_MOTDEVCHQ', tF_FCR_CHEQUE));
          putitem_e(tFCR_CHEQUE, 'DT_DEVOLUCAO1', item_a('DT_DEVOLUCAO1', tF_FCR_CHEQUE));
          putitem_e(tFCR_CHEQUE, 'NR_CTAPESDEV1', item_f('NR_CTAPESDEV1', tF_FCR_CHEQUE));
          putitem_e(tFCR_CHEQUE, 'DT_BAIXA1', item_a('DT_BAIXA1', tF_FCR_CHEQUE));
          putitem_e(tFCR_CHEQUE, 'NR_CTAPESBX1', item_f('NR_CTAPESBX1', tF_FCR_CHEQUE));
          putitem_e(tFCR_CHEQUE, 'CD_MOTDEVCHQ2', item_f('CD_MOTDEVCHQ2', tF_FCR_CHEQUE));
          putitem_e(tFCR_CHEQUE, 'DT_DEVOLUCAO2', item_a('DT_DEVOLUCAO2', tF_FCR_CHEQUE));
          putitem_e(tFCR_CHEQUE, 'NR_CTAPESDEV2', item_f('NR_CTAPESDEV2', tF_FCR_CHEQUE));
          putitem_e(tFCR_CHEQUE, 'DT_BAIXA2', item_a('DT_BAIXA2', tF_FCR_CHEQUE));
          putitem_e(tFCR_CHEQUE, 'NR_CTAPESBX2', item_f('NR_CTAPESBX2', tF_FCR_CHEQUE));
          putitem_e(tFCR_CHEQUE, 'IN_REAPRESENTA', item_b('IN_REAPRESENTA', tF_FCR_CHEQUE));
          putitem_e(tFCR_CHEQUE, 'CD_OPERADOR', itemXmlF('CD_USUARIO', PARAM_GLB));
          putitem_e(tFCR_CHEQUE, 'DT_CADASTRO', Now);

          voParams := tFCR_CHEQUE.Salvar();
          if (xStatus < 0) then begin
            Result := voParams;
            return(-1); exit;
          end;
        end;
      end;
    end;

    Result := '';
    putitemXml(Result, 'NR_SEQUENCIA', vNrSequencia);

  end;
  if ((vVlIsencaoJuro > 0)  or (vVlIsencaoMulta > 0))  and %\ then begin
    (itemXml('TP_LANCTOJURO', pParams) <> 99);

    clear_e(tFCR_FATURAI);
    creocc(tFCR_FATURAI, -1);
    getlistitensocc_e(vFatOriginal, tFCR_FATURAI);

    if (gNrPortadorJuro > 0) then begin
      putitem_e(tFCR_FATURAI, 'NR_PORTADOR', gNrPortadorJuro);
    end;
    if (itemXml('TP_LANCTOJURO', pParams) = 2) then begin
      clear_e(tGER_EMPRESA);
      putitem_e(tGER_EMPRESA, 'CD_EMPRESA', itemXmlF('CD_EMPRECEBIMENTO', pParams));
      retrieve_e(tGER_EMPRESA);
      if (xStatus < 0) then begin
        Result := SetStatus(STS_ERROR, 'GEN001', 'Empresa inválida p/ gravar fatura de isençao de juros', '');
        return(-1); exit;
      end;
      putitem_e(tFCR_FATURAI, 'CD_CLIENTE', item_f('CD_PESSOA', tGER_EMPRESA));
    end;

    viParams := '';
    voParams := geraSeqParcela(viParams); (* viParams, voParams, xCdErro, xCtxErro *)
    if (xStatus < 0) then begin
      Result := voParams;
      return(-1); exit;
    end;

    putitem_e(tFCR_FATURAI, 'NR_PARCELA', itemXmlF('NR_PARCELA', voParams));
    if (itemXml('TP_LANCTOJURO', pParams) = 2) then begin
      clear_e(tF_FCR_FATURAI);
      putitem_e(tF_FCR_FATURAI, 'CD_EMPRESA', item_f('CD_EMPRESA', tFCR_FATURAI));
      putitem_e(tF_FCR_FATURAI, 'CD_CLIENTE', item_f('CD_CLIENTE', tFCR_FATURAI));
      putitem_e(tF_FCR_FATURAI, 'NR_FAT', item_f('NR_FAT', tFCR_FATURAI));
      retrieve_e(tF_FCR_FATURAI);
      if (xStatus >= 0) then begin
        setocc(tF_FCR_FATURAI, -1);
        if (item_f('NR_PARCELA', tF_FCR_FATURAI) = 999) then begin
          putitem_e(tFCR_FATURAI, 'NR_FAT', vDtSistema);

          voParams := geraSeqParcela(viParams); (* viParams, voParams, xCdErro, xCtxErro *)
          if (xStatus < 0) then begin
            Result := voParams;
            return(-1); exit;
          end;
          putitem_e(tFCR_FATURAI, 'NR_PARCELA', itemXmlF('NR_PARCELA', voParams));
        end;
      end;

      clear_e(tFCR_FATURAC);
      creocc(tFCR_FATURAC, -1);
      putitem_e(tFCR_FATURAC, 'CD_EMPRESA', item_f('CD_EMPRESA', tFCR_FATURAI));
      putitem_e(tFCR_FATURAC, 'CD_CLIENTE', item_f('CD_CLIENTE', tFCR_FATURAI));
      putitem_e(tFCR_FATURAC, 'NR_FAT', item_f('NR_FAT', tFCR_FATURAI));
      retrieve_o(tFCR_FATURAC);
      if (xStatus = -7) then begin
        retrieve_x(tFCR_FATURAC);
      end;

      putitem_e(tFCR_FATURAC, 'CD_OPERADOR', itemXmlF('CD_USUARIO', PARAM_GLB));
      putitem_e(tFCR_FATURAC, 'DT_CADASTRO', Now);
      voParams := tFCR_FATURAC.Salvar();
      if (xStatus < 0) then begin
        Result := voParams;
        return(-1); exit;
      end;
    end;

    voParams := buscaTpDocumentoJuro(viParams); (* item_f('TP_DOCUMENTO', tFCR_FATURAI) *)

    putitem_e(tFCR_FATURAI, 'DT_EMISSAO', gDtpagamento);
    putitem_e(tFCR_FATURAI, 'DT_VENCIMENTO', gDtpagamento + vNrDiasJuroFuturo);
    putitem_e(tFCR_FATURAI, 'VL_JUROS', '');
    putitem_e(tFCR_FATURAI, 'VL_DESCONTO', '');
    putitem_e(tFCR_FATURAI, 'VL_OUTACRES', 0);
    putitem_e(tFCR_FATURAI, 'VL_OUTDESC', 0);
    putitem_e(tFCR_FATURAI, 'VL_ABATIMENTO', 0);
    putitem_e(tFCR_FATURAI, 'VL_DESPFIN', 0);
    putitem_e(tFCR_FATURAI, 'VL_IMPOSTO', 0);
    putitem_e(tFCR_FATURAI, 'VL_ACRESCIMO', 0);
    putitem_e(tFCR_FATURAI, 'VL_OUTDESC', 0);
    putitem_e(tFCR_FATURAI, 'TP_FATURAMENTO', 5);
    putitem_e(tFCR_FATURAI, 'VL_FATURA', vVlIsencaoJuro + vVlIsencaoMulta);
    putitem_e(tFCR_FATURAI, 'VL_ORIGINAL', vVlIsencaoJuro + vVlIsencaoMulta);
    putitem_e(tFCR_FATURAI, 'VL_PAGO', 0);
    putitem_e(tFCR_FATURAI, 'CD_OPERADOR', itemXmlF('CD_USUARIO', PARAM_GLB));
    putitem_e(tFCR_FATURAI, 'DT_CADASTRO', Now);

    if (vCdComponente <> '') then begin
      putitem_e(tFCR_FATURAI, 'CD_COMPONENTE', vCdComponente);
    end;
    if (itemXml('TP_LANCTOJURO', pParams) = 2) then begin
      putitem_e(tFCR_FATURAI, 'CD_EMPLIQ', itemXmlF('CD_EMPLIQ', pParams));

      if (item_a('DT_LIQ', tFCR_FATURAI) <> '') then begin
        Result := SetStatus(STS_ERROR, 'GEN001', 'Fatura já liquidada por outro processo ou manutenção.Empresa: ' + cd_empresa + '.FCR_FATURAI Cliente: ' + cd_cliente + '.FCR_FATURAI Fatura: ' + nr_fat + '.FCR_FATURAI Parcela: ' + nr_parcela + '.FCR_FATURAI', '');
        return(-1); exit;
      end;

      putitem_e(tFCR_FATURAI, 'DT_LIQ', itemXml('DT_LIQ', pParams));
      putitem_e(tFCR_FATURAI, 'NR_SEQLIQ', itemXmlF('NR_SEQLIQ', pParams));

      if (gDtpagamento <> '') then begin
        putitem_e(tFCR_FATURAI, 'DT_BAIXA', gDtpagamento);
      end else begin
        putitem_e(tFCR_FATURAI, 'DT_BAIXA', itemXml('DT_SISTEMA', PARAM_GLB));
      end;

      voParams := gravaHoraDtBaixa(viParams); (* *)

      putitem_e(tFCR_FATURAI, 'TP_BAIXA', 1);

      if (itemXml('IN_BAIXAVIABANCO', pParams) = True) then begin
        putitem_e(tFCR_FATURAI, 'TP_BAIXA', 12);
      end;
    end;
    if (gInJuroIsencaoAberto = True) then begin
      putitem_e(tFCR_FATURAI, 'TP_BAIXA', 16);
    end;
    if (xStatus = -11) then begin
      Result := SetStatus(STS_ERROR, 'GEN001', 'Fatura sendo utilizada em outro processo ou manutenção.Empresa: ' + cd_empresa + '.FCR_FATURAI Cliente: ' + cd_cliente + '.FCR_FATURAI Fatura: ' + nr_fat + '.FCR_FATURAI Parcela: ' + nr_parcela + '.FCR_FATURAI', '');
      return(-1); exit;
    end;

    putitem_e(tFCR_FATURAI, 'NR_NOSSONUMERO', '');
    putitem_e(tFCR_FATURAI, 'DS_DACNOSSONR', '');
    putitem_e(tFCR_FATURAI, 'TP_COBRANCA', 0);

    voParams := tFCR_FATURAI.Salvar();
    if (xStatus < 0) then begin
      Result := voParams;
      return(-1); exit;
    end;

    viParams := '';
    putlistitensocc_e(     vDsRegistro, tFCR_FATURAI);
    putitemXml(viParams, 'DS_FATURAI', vDsRegistro);
    putitemXml(viParams, 'DS_CHEQUE', vDsCheque);
    putitemXml(viParams, 'IN_ALTSOFATURAI', False);
    putitemXml(viParams, 'IN_SEMCOMISSAO', True);
    putitemXml(viParams, 'IN_SEMIMPOSTO', True);
    putitemXml(viParams, 'IN_NAOGRVDESCANT', True);
    putitemXml(viParams, 'IN_NAOGRVDESC1', True);
    putitemXml(viParams, 'IN_NAOGRVDESC2', True);

    if (vCdComponente <> '') then begin
      putitemXml(viParams, 'CD_COMPONENTE', vCdComponente);
    end else begin
      putitemXml(viParams, 'CD_COMPONENTE', FCRSVCO007);
    end;

    voParams := activateCmp('FCRSVCO001', 'geraFatura', viParams); (*,,,, *)
    if (xStatus < 0) then begin
      Result := voParams;
      return(-1); exit;
    end;
    if (voParams = '') then begin
      Result := SetStatus(STS_ERROR, 'GEN0001', 'Nenhuma fatura retornada pelo serviço de gravação na isenção de juro.', '');
      return(-1); exit;
    end;

    viParams := '';

    viParams := pParams;
    putitemXml(viParams, 'CD_EMPRESA', item_f('CD_EMPRESA', tFCR_FATURAI));
    putitemXml(viParams, 'CD_CLIENTE', item_f('CD_CLIENTE', tFCR_FATURAI));
    vNrSequencia := vNrSequencia + 1;
    putitemXml(viParams, 'NR_FAT', item_f('NR_FAT', tFCR_FATURAI));
    putitemXml(viParams, 'NR_PARCELA', item_f('NR_PARCELA', tFCR_FATURAI));
    putitemXml(viParams, 'VL_FATURA', item_f('VL_FATURA', tFCR_FATURAI));
    putitemXml(viParams, 'NR_SEQUENCIA', vNrSequencia);
    putitemXml(viParams, 'TP_TIPOREG', 2);
    putitemXml(viParams, 'TP_DOCUMENTO', item_f('TP_DOCUMENTO', tFCR_FATURAI));
    putitemXml(viParams, 'IN_NAOSOMA', True);

    if (gInRecebimentoFat = True) then begin
      putitemXml(viParams, 'VL_PAGO', item_f('VL_FATURA', tFCR_FATURAI));
    end else begin
      putitemXml(viParams, 'VL_PAGO', 0);
    end;

    voParams := gravaLiqFaturas(viParams); (* PARAM_GLB, viParams, voParams, xCdErro, xCtxErro *)
    if (xStatus < 0) then begin
      Result := voParams;
      return(-1); exit;
    end;
    Result := '';
    putitemXml(Result, 'NR_SEQUENCIA', vNrSequencia);
  end;
  if ((vVlIsencaoJuro > 0)  or (vVlIsencaoMulta > 0))  and %\ then begin
    (itemXml('TP_LANCTOJURO', pParams) := 99);
    gVl12D2 := vVlIsencaoJuro + vVlIsencaoMulta;
    viParams := '';
    putitemXml(viParams, 'CD_EMPRESA', item_f('CD_EMPRESA', tFCR_FATURAI));
    putitemXml(viParams, 'CD_CLIENTE', item_f('CD_CLIENTE', tFCR_FATURAI));
    putitemXml(viParams, 'NR_FAT', item_f('NR_FAT', tFCR_FATURAI));
    putitemXml(viParams, 'NR_PARCELA', item_f('NR_PARCELA', tFCR_FATURAI));
    putitemXml(viParams, 'TP_LOGFAT', 14);
    putitemXml(viParams, 'DS_COMPONENTE', vCdComponente);
    putitemXml(viParams, 'DS_OBS', 'ISENCAO DE JURO/MULTA NO VALOR DE ' + FloatToStr(gVl) + '12D2');
    voParams := activateCmp('FCRSVCO001', 'gravaLogFatura', viParams); (*,,,, *)
    if (xStatus < 0) then begin
      Result := voParams;
      return(-1); exit;
    end;
  end;
  if (gInVariacaoCambial = True) then begin
    viParams := '';
    putitemXml(viParams, 'CD_EMPFAT', itemXmlF('CD_EMPRESA', pParams));
    putitemXml(viParams, 'CD_CLIENTE', itemXmlF('CD_CLIENTE', pParams));
    putitemXml(viParams, 'NR_FAT', itemXmlF('NR_FAT', pParams));
    putitemXml(viParams, 'NR_PARCELA', itemXmlF('NR_PARCELA', pParams));
    putitemXml(viParams, 'IN_BAIXA', True);
    putitemXml(viParams, 'IN_PARCIAL', False);
    voParams := activateCmp('FCRSVCO087', 'gravaFatVariacaoPagto', viParams); (*,,, *)
    if (xStatus < 0) then begin
      Result := voParams;
      return(-1); exit;
    end;
  end;

  return(0); exit;
end;

//-------------------------------------------------------------------
function T_FCRSVCO007.baixarFaturaParcial(pParams : String) : String;
//-------------------------------------------------------------------
const
  cDS_METHOD = 'ADICIONAL=Operação: T_FCRSVCO007.baixarFaturaParcial()';
var
  vFatOriginal, viParams, voParams, vDsRegistro, vDsCheque, vCdComponente, vDtSistema, vDsFatReg, vDsCobBanco : String;
  vVlJuros, vVlOriginal, vPercentualProp, vVlFatura, vVlPago, vNrParcOrigem, vNrSequencia, vTpCobrancaLista, vTpCobrancaMover : Real;
  vTpLanctoJuro, vVlIsencaoJuro, vVlIsencaoMulta, vVlMulta, vVlBaixarJuro, vVlBaixarFatura, vVlBaixarDesconto : Real;
  vVlJuroMulta, vVlPercentualProp, vVlRestante, vNrDiasJuroFuturo, vVlDescVar, vTpCobranca, vVlDiferenca : Real;
  vCdEmpFatOrig, vCdClienteOrig, vNrFatOrig, vNrParcelaOrig, vVlFaturaLiq, vVlPagoAux, vVlFaturaAux : Real;
  vInProporcional : Boolean;
begin
  vDtSistema := itemXml('DT_SISTEMA', PARAM_GLB);
  gDtpagamento := itemXml('DT_PAGAMENTO', pParams);
  vNrSequencia := itemXmlF('NR_SEQUENCIA', pParams);
  vVlOriginal := itemXmlF('VL_ORIGINAL', pParams);
  vVlFatura := itemXmlF('VL_FATURA', pParams);
  vVlPago := itemXmlF('VL_PAGO', pParams);
  vVlIsencaoJuro := itemXmlF('VL_ISENCAOJURO', pParams);
  vTpLanctoJuro := itemXmlF('TP_LANCTOJURO', pParams);
  vVlIsencaoMulta := itemXmlF('VL_ISENCAOMULTA', pParams);
  vVlJuroMulta := itemXmlF('VL_JUROS', pParams) + itemXml('VL_MULTA', pParams);

  vNrDiasJuroFuturo := itemXmlF('NR_DIAS_JURO_FUTURO', pParams);

  gVlacrescjurototal := itemXmlF('VL_ACRESC_JURO_TOTAL', pParams);
  gVlacrescjuroparcial := itemXmlF('VL_ACRESC_JURO_PARCIAL', pParams);
  vCdComponente := itemXmlF('CD_COMPONENTE', pParams);

  gNrdiasatraso := itemXmlF('NR_DIASATRASO', pParams);
  gVljuros := itemXmlF('VL_JUROS', pParams);
  gVlmulta := itemXmlF('VL_MULTA', pParams);
  gVldesconto := itemXmlF('VL_DESCONTO', pParams);

  gVlDescontoTotal := itemXmlF('VL_DESCONTO_TOTAL', pParams);
  gVlDescontoParcial := itemXmlF('VL_DESCONTO_PARCIAL', pParams);

  if (itemXml('CD_EMPRESA', pParams) = '') then begin
    Result := SetStatus(STS_AVISO, 'GEN001', 'Código de empresa não informada', '');
    return(-1); exit;
  end;
  if (itemXml('CD_CLIENTE', pParams) = '') then begin
    Result := SetStatus(STS_AVISO, 'GEN001', 'Código de cliente não informado', '');
    return(-1); exit;
  end;
  if (itemXml('NR_FAT', pParams) = '') then begin
    Result := SetStatus(STS_AVISO, 'GEN001', 'Número da fatura não informado', '');
    return(-1); exit;
  end;
  if (itemXml('NR_PARCELA', pParams) = '') then begin
    Result := SetStatus(STS_AVISO, 'GEN001', 'Número da parcela da fatura não informado', '');
    return(-1); exit;
  end;
  if (itemXml('VL_PAGO', pParams) = '') then begin
    Result := SetStatus(STS_AVISO, 'GEN001', 'Valor da fatura não informado', '');
    return(-1); exit;
  end;

  clear_e(tFCR_FATURAI);
  putitem_e(tFCR_FATURAI, 'CD_EMPRESA', itemXmlF('CD_EMPRESA', pParams));
  putitem_e(tFCR_FATURAI, 'CD_CLIENTE', itemXmlF('CD_CLIENTE', pParams));
  putitem_e(tFCR_FATURAI, 'NR_FAT', itemXmlF('NR_FAT', pParams));
  putitem_e(tFCR_FATURAI, 'NR_PARCELA', itemXmlF('NR_PARCELA', pParams));
  retrieve_e(tFCR_FATURAI);
  if (xStatus < 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN001', 'Fatura não encontrada', '');
    return(-1); exit;
  end;

  gInJuroIsencaoAberto := '';

  getParams(pParams); (*  *)
  if (xStatus < 0) then begin
    return(-1); exit;
  end;

  vTpCobranca := item_f('TP_COBRANCA', tFCR_FATURAI);
  vNrParcOrigem := item_f('NR_PARCELA', tFCR_FATURAI);
  vFatOriginal := '';
  putlistitensocc_e(vFatOriginal, tFCR_FATURAI);

  vVlOriginal := 0;
  vVlOriginal := itemXmlF('VL_ORIGINAL', pParams);
  if (vVlPago < vVlOriginal) then begin
    vVlOriginal := vVlPago - itemXmlF('VL_ABATIMENTO', pParams) + itemXml('VL_DESPFIN', pParams) + item_f('VL_OUTACRES', tFCR_FATURAI) - item_f('VL_IMPOSTO', tFCR_FATURAI) - item_f('VL_OUTDESC', tFCR_FATURAI);
    vVlRestante := itemXmlF('VL_ORIGINAL', pParams) - vVlPago;
  end else begin
    vVlOriginal := itemXmlF('VL_ORIGINAL', pParams) - itemXml('VL_ABATIMENTO', pParams) + itemXml('VL_DESPFIN', pParams) + item_f('VL_OUTACRES', tFCR_FATURAI) - item_f('VL_IMPOSTO', tFCR_FATURAI) - item_f('VL_OUTDESC', tFCR_FATURAI);
  end;

  if   ((putitem_e(tFCR_FATURAI, 'VL_DESPFIN', 0)  or (item_f('VL_DESPFIN', tFCR_FATURAI), ''))  and
    ((putitem_e(tFCR_FATURAI, 'VL_OUTACRES', 0)  or (item_f('VL_OUTACRES', tFCR_FATURAI), '')));

    vVlPagoAux := vVlPago   - gVlacrescjuroparcial + gVlDescontoParcial;
    vVlFaturaAux := vVlFatura - gVlacrescjuroparcial + gVlDescontoParcial;
    vVlPercentualProp := vVlPagoAux / vVlFaturaAux;
    vVlPercentualProp := rounded(vVlPercentualProp, 6);
    vVlBaixarFatura := (vVlOriginal - gVlacrescjuroparcial) * vVlPercentualProp;
    vVlBaixarFatura := rounded(vVlBaixarFatura, 2);
    vVlBaixarJuro := (vVlJuroMulta - gVlacrescjuroparcial) * vVlPercentualProp;
    vVlBaixarJuro := rounded(vVlBaixarJuro, 2);
    vVlBaixarDesconto := (gVlDesconto + gVlDescontoParcial) * vVlPercentualProp;
    vVlBaixarDesconto := rounded(vVlBaixarDesconto, 2);
    vInProporcional := True;
  end else begin
    vVlBaixarFatura := vVlPago;
    vVlBaixarJuro := vVlJuroMulta;
  end;
  if (itemXml('IN_CAPITAL', pParams) = True) then begin
    vVlBaixarFatura := vVlPago - vVlJuroMulta;
    vVlBaixarJuro := vVlJuroMulta;
  end;

  putitem_e(tFCR_FATURAI, 'TP_BAIXA', 1);
  if (itemXml('IN_BAIXAVIABANCO', pParams) = True) then begin
    putitem_e(tFCR_FATURAI, 'TP_BAIXA', 12);
  end;
  if (itemXml('IN_BAIXAFUNC', pParams) = True) then begin
    putitem_e(tFCR_FATURAI, 'TP_BAIXA', 24);
  end;
  putitem_e(tFCR_FATURAI, 'CD_OPERBAIXA', itemXmlF('CD_USUARIO', PARAM_GLB));
  putitem_e(tFCR_FATURAI, 'VL_JUROS', itemXmlF('VL_JUROS', pParams));
  putitem_e(tFCR_FATURAI, 'VL_ACRESCIMO', itemXmlF('VL_JUROS', pParams) + itemXml('VL_MULTA', pParams) + item_f('VL_OUTACRES', tFCR_FATURAI) + item_f('VL_DESPFIN', tFCR_FATURAI));
  putitem_e(tFCR_FATURAI, 'VL_DESCONTO', itemXmlF('VL_DESCONTO', pParams));
  vVlRestante := item_f('VL_FATURA', tFCR_FATURAI);
  if (itemXml('IN_CAPITAL', pParams) = True) then begin
    putitem_e(tFCR_FATURAI, 'VL_FATURA', vVlBaixarFatura - (item_f('VL_OUTACRES', tFCR_FATURAI) + item_f('VL_DESPFIN', tFCR_FATURAI) - item_f('VL_ABATIMENTO', tFCR_FATURAI) - item_f('VL_OUTDESC', tFCR_FATURAI) - item_f('VL_IMPOSTO', tFCR_FATURAI)));
  end else if (vInProporcional = True) then begin
    putitem_e(tFCR_FATURAI, 'VL_FATURA', vVlBaixarFatura + item_f('VL_ABATIMENTO', tFCR_FATURAI) + item_f('VL_IMPOSTO', tFCR_FATURAI) + item_f('VL_OUTDESC', tFCR_FATURAI));
    putitem_e(tFCR_FATURAI, 'VL_DESCONTO', vVlBaixarDesconto + gVlDescontoParcial);
    putitem_e(tFCR_FATURAI, 'VL_JUROS', vVlBaixarJuro   + gVlacrescjuroparcial);
    putitem_e(tFCR_FATURAI, 'VL_ACRESCIMO', item_f('VL_JUROS', tFCR_FATURAI) + item_f('VL_OUTACRES', tFCR_FATURAI) + item_f('VL_DESPFIN', tFCR_FATURAI));

    if ((vVlIsencaoJuro + vVlIsencaoMulta) > 0)  and (vVlPago <> (item_f('VL_FATURA', tFCR_FATURAI) + (item_f('VL_JUROS', tFCR_FATURAI) + item_f('VL_DESPFIN', tFCR_FATURAI) + item_f('VL_OUTACRES', tFCR_FATURAI)) - (item_f('VL_DESCONTO', tFCR_FATURAI) + item_f('VL_ABATIMENTO', tFCR_FATURAI) + item_f('VL_IMPOSTO', tFCR_FATURAI) + item_f('VL_OUTDESC', tFCR_FATURAI)))) then begin
      vVlDiferenca := vVlPago + (item_f('VL_DESCONTO', tFCR_FATURAI) + item_f('VL_ABATIMENTO', tFCR_FATURAI) + item_f('VL_OUTDESC', tFCR_FATURAI) + item_f('VL_IMPOSTO', tFCR_FATURAI)) - (item_f('VL_OUTACRES', tFCR_FATURAI) + item_f('VL_DESPFIN', tFCR_FATURAI) + item_f('VL_JUROS', tFCR_FATURAI) + item_f('VL_FATURA', tFCR_FATURAI));
      putitem_e(tFCR_FATURAI, 'VL_FATURA', item_f('VL_FATURA', tFCR_FATURAI) + vVlDiferenca);
    end;

  end else begin
    putitem_e(tFCR_FATURAI, 'VL_FATURA', vVlBaixarFatura - ((itemXml('VL_JUROS', pParams) + itemXmlF('VL_MULTA', pParams) + item_f('VL_OUTACRES', tFCR_FATURAI) + item_f('VL_DESPFIN', tFCR_FATURAI)) - (item_f('VL_ABATIMENTO', tFCR_FATURAI) + item_f('VL_OUTDESC', tFCR_FATURAI) + item_f('VL_IMPOSTO', tFCR_FATURAI) + itemXml('VL_DESCONTO', pParams))));

    if (item_f('VL_FATURA', tFCR_FATURAI) < 0) then begin
      vVlPagoAux := vVlPago   - gVlacrescjuroparcial + gVlDescontoParcial - (item_f('VL_OUTACRES', tFCR_FATURAI) + item_f('VL_DESPFIN', tFCR_FATURAI)) + (item_f('VL_ABATIMENTO', tFCR_FATURAI) + item_f('VL_OUTDESC', tFCR_FATURAI) + item_f('VL_IMPOSTO', tFCR_FATURAI));
      vVlFaturaAux := vVlFatura - gVlacrescjuroparcial + gVlDescontoParcial - (item_f('VL_OUTACRES', tFCR_FATURAI) + item_f('VL_DESPFIN', tFCR_FATURAI)) + (item_f('VL_ABATIMENTO', tFCR_FATURAI) + item_f('VL_OUTDESC', tFCR_FATURAI) + item_f('VL_IMPOSTO', tFCR_FATURAI));
      vVlPercentualProp := vVlPagoAux / vVlFaturaAux;
      vVlPercentualProp := rounded(vVlPercentualProp, 6);
      vVlBaixarFatura := vVlOriginal - gVlacrescjuroparcial + gVlDescontoParcial - (item_f('VL_OUTACRES', tFCR_FATURAI) + item_f('VL_DESPFIN', tFCR_FATURAI)) + (item_f('VL_ABATIMENTO', tFCR_FATURAI) + item_f('VL_OUTDESC', tFCR_FATURAI) + item_f('VL_IMPOSTO', tFCR_FATURAI));
      vVlBaixarFatura := vVlBaixarFatura * vVlPercentualProp;
      vVlBaixarFatura := rounded(vVlBaixarFatura, 2);
      vVlBaixarJuro := (vVlJuroMulta - gVlacrescjuroparcial) * vVlPercentualProp;
      vVlBaixarJuro := rounded(vVlBaixarJuro, 2);
      vVlBaixarDesconto := (gVlDesconto + gVlDescontoParcial) * vVlPercentualProp;
      vVlBaixarDesconto := rounded(vVlBaixarDesconto, 2);
      putitem_e(tFCR_FATURAI, 'VL_FATURA', vVlBaixarFatura);
      putitem_e(tFCR_FATURAI, 'VL_JUROS', vVlBaixarJuro);
      putitem_e(tFCR_FATURAI, 'VL_DESCONTO', vVlBaixarDesconto);
      putitem_e(tFCR_FATURAI, 'VL_ACRESCIMO', item_f('VL_JUROS', tFCR_FATURAI) + item_f('VL_OUTACRES', tFCR_FATURAI) + item_f('VL_DESPFIN', tFCR_FATURAI));
    end;
  end;
  vVlRestante := vVlRestante - item_f('VL_FATURA', tFCR_FATURAI);
  putitem_e(tFCR_FATURAI, 'VL_PAGO', vVlPago);
  putitem_e(tFCR_FATURAI, 'CD_EMPLIQ', itemXmlF('CD_EMPLIQ', pParams));

  if (item_f('VL_PAGO', tFCR_FATURAI) <> (item_f('VL_FATURA', tFCR_FATURAI) + item_f('VL_ACRESCIMO', tFCR_FATURAI) - (item_f('VL_DESCONTO', tFCR_FATURAI) + item_f('VL_ABATIMENTO', tFCR_FATURAI) + item_f('VL_OUTDESC', tFCR_FATURAI) + item_f('VL_IMPOSTO', tFCR_FATURAI)))) then begin
    Result := SetStatus(STS_ERROR, 'GEN001', 'Valores de baixa do título incorretos.Empresa: ' + cd_empresa + '.FCR_FATURAI Cliente: ' + cd_cliente + '.FCR_FATURAI Fatura: ' + nr_fat + '.FCR_FATURAI Parcela: ' + nr_parcela + '.FCR_FATURAI', '');
    return(-1); exit;
  end;
  if (item_a('DT_LIQ', tFCR_FATURAI) <> '') then begin
    Result := SetStatus(STS_ERROR, 'GEN001', 'Fatura já liquidada por outro processo ou manutenção.Empresa: ' + cd_empresa + '.FCR_FATURAI Cliente: ' + cd_cliente + '.FCR_FATURAI Fatura: ' + nr_fat + '.FCR_FATURAI Parcela: ' + nr_parcela + '.FCR_FATURAI', '');
    return(-1); exit;
  end;

  putitem_e(tFCR_FATURAI, 'DT_LIQ', itemXml('DT_LIQ', pParams));
  putitem_e(tFCR_FATURAI, 'NR_SEQLIQ', itemXmlF('NR_SEQLIQ', pParams));

  if (gDtpagamento <> '') then begin
    putitem_e(tFCR_FATURAI, 'DT_BAIXA', gDtpagamento);
  end else begin
    putitem_e(tFCR_FATURAI, 'DT_BAIXA', itemXml('DT_SISTEMA', PARAM_GLB));
  end;

  voParams := gravaHoraDtBaixa(viParams); (* *)

  if (vCdComponente <> '') then begin
    putitem_e(tFCR_FATURAI, 'CD_COMPONENTE', vCdComponente);
  end;

  putitem_e(tFCR_FATURAI, 'CD_OPERADOR', itemXmlF('CD_USUARIO', PARAM_GLB));
  putitem_e(tFCR_FATURAI, 'DT_CADASTRO', Now);

  if (xStatus = -11) then begin
    Result := SetStatus(STS_ERROR, 'GEN001', 'Fatura sendo utilizada em outro processo ou manutenção.Empresa: ' + cd_empresa + '.FCR_FATURAI Cliente: ' + cd_cliente + '.FCR_FATURAI Fatura: ' + nr_fat + '.FCR_FATURAI Parcela: ' + nr_parcela + '.FCR_FATURAI', '');
    return(-1); exit;
  end;

  vDsFatReg := '';
  putlistitensocc_e(vDsFatReg, tFCR_FATURAI);
  viParams := '';
  putitemXml(viParams, 'DS_FATURAI', vDsFatReg);
  putitemXml(viParams, 'CD_COMPONENTE', FCRSVCO007);
  putitemXml(viParams, 'DS_CHEQUE', '');
  putitemXml(viParams, 'IN_SEMCOMISSAO', True);
  putitemXml(viParams, 'IN_SEMIMPOSTO', True);
  putitemXml(viParams, 'IN_ALTSOFATURAI', True);
  voParams := activateCmp('FCRSVCO001', 'geraFatura', viParams); (*,,,, *)
  if (xStatus < 0) then begin
    Result := voParams;
    return(-1); exit;
  end;

  viParams := '';
  viParams := pParams;
  putitemXml(viParams, 'IN_NAOSOMA', True);
  putitemXml(viParams, 'VL_PAGO', item_f('VL_PAGO', tFCR_FATURAI));
  voParams := gravaLiqFaturas(viParams); (* PARAM_GLB, viParams, voParams, xCdErro, xCtxErro *)
  if (xStatus < 0) then begin
    Result := voParams;
    return(-1); exit;
  end;
  if (gVlacrescjuroparcial > 0) then begin
    viParams := '';
    putitemXml(viParams, 'CD_EMPRESA', item_f('CD_EMPRESA', tFCR_FATURAI));
    putitemXml(viParams, 'CD_CLIENTE', item_f('CD_CLIENTE', tFCR_FATURAI));
    putitemXml(viParams, 'NR_FAT', item_f('NR_FAT', tFCR_FATURAI));
    putitemXml(viParams, 'NR_PARCELA', item_f('NR_PARCELA', tFCR_FATURAI));
    putitemXml(viParams, 'DS_OBSERVACAO', 'Vl. acresc. juro receb. Rg ' + Vlacrescjurototalg + ' - Vl. acresc. parcial R ' + FloatToStr(gVlacrescjuroparcial')) + ';
    putitemXml(viParams, 'CD_COMPONENTE', vCdComponente);
    voParams := activateCmp('FCRSVCO001', 'gravaObsFatura', viParams); (*,,,, *)
    if (xStatus < 0) then begin
      Result := voParams;
      return(-1); exit;
    end;
  end;
  if (gVlDescontoParcial > 0) then begin
    viParams := '';
    putitemXml(viParams, 'CD_EMPRESA', item_f('CD_EMPRESA', tFCR_FATURAI));
    putitemXml(viParams, 'CD_CLIENTE', item_f('CD_CLIENTE', tFCR_FATURAI));
    putitemXml(viParams, 'NR_FAT', item_f('NR_FAT', tFCR_FATURAI));
    putitemXml(viParams, 'NR_PARCELA', item_f('NR_PARCELA', tFCR_FATURAI));
    putitemXml(viParams, 'DS_OBSERVACAO', 'Vl. Desconto Total. Rg ' + VlDescontoTotalg + ' - Vl. Desconto Parcial R ' + FloatToStr(gVlDescontoParcial')) + ';
    putitemXml(viParams, 'CD_COMPONENTE', vCdComponente);
    voParams := activateCmp('FCRSVCO001', 'gravaObsFatura', viParams); (*,,,, *)
    if (xStatus < 0) then begin
      Result := voParams;
      return(-1); exit;
    end;
  end;
  if (gNrdiasatraso > 0)  and (gVljuros = 0)  and (gVlmulta = 0)  and (gVldesconto > 0) then begin
    viParams := '';
    putitemXml(viParams, 'CD_EMPRESA', item_f('CD_EMPRESA', tFCR_FATURAI));
    putitemXml(viParams, 'CD_CLIENTE', item_f('CD_CLIENTE', tFCR_FATURAI));
    putitemXml(viParams, 'NR_FAT', item_f('NR_FAT', tFCR_FATURAI));
    putitemXml(viParams, 'NR_PARCELA', item_f('NR_PARCELA', tFCR_FATURAI));
    putitemXml(viParams, 'DS_OBSERVACAO', 'Fatura recebida com atraso e com desconto de Rg ' + Vldescontog') + ';
    putitemXml(viParams, 'CD_COMPONENTE', vCdComponente);
    voParams := activateCmp('FCRSVCO001', 'gravaObsFatura', viParams); (*,,,, *)
    if (xStatus < 0) then begin
      Result := voParams;
      return(-1); exit;
    end;
  end;
  if (itemXml('DS_COMISSAO', pParams) <> '') then begin
    viParams := '';
    putitemXml(viParams, 'CD_EMPRESA', item_f('CD_EMPRESA', tFCR_FATURAI));
    putitemXml(viParams, 'CD_CLIENTE', item_f('CD_CLIENTE', tFCR_FATURAI));
    putitemXml(viParams, 'NR_FAT', item_f('NR_FAT', tFCR_FATURAI));
    putitemXml(viParams, 'NR_PARCELA', item_f('NR_PARCELA', tFCR_FATURAI));
    voParams := activateCmp('FCRSVCO013', 'atualizaTransfComissao', viParams); (*,,,, *)
    if (xStatus < 0) then begin
      Result := voParams;
      return(-1); exit;
    end;
  end;
  if (vVlRestante > 0) then begin
    vCdEmpFatOrig := item_f('CD_EMPRESA', tFCR_FATURAI);
    vCdClienteOrig := item_f('CD_CLIENTE', tFCR_FATURAI);
    vNrFatOrig := item_f('NR_FAT', tFCR_FATURAI);
    vNrParcelaOrig := item_f('NR_PARCELA', tFCR_FATURAI);

    clear_e(tFCR_FATURAI);
    creocc(tFCR_FATURAI, -1);
    getlistitensocc_e(vFatOriginal, tFCR_FATURAI);

    viParams := '';
    voParams := geraSeqParcela(viParams); (* viParams, voParams, xCdErro, xCtxErro *)
    if (xStatus < 0) then begin
      Result := voParams;
      return(-1); exit;
    end;
    putitem_e(tFCR_FATURAI, 'NR_PARCELAORIGEM', vNrParcOrigem);
    putitem_e(tFCR_FATURAI, 'NR_PARCELA', itemXmlF('NR_PARCELA', voParams));
    putitem_e(tFCR_FATURAI, 'VL_JUROS', 0);
    putitem_e(tFCR_FATURAI, 'VL_DESCONTO', 0);
    putitem_e(tFCR_FATURAI, 'VL_FATURA', vVlRestante);

    if (itemXml('IN_CAPITAL', pParams) = True) then begin
      putitem_e(tFCR_FATURAI, 'VL_FATURA', vVlRestante);
    end;

    putitem_e(tFCR_FATURAI, 'VL_PAGO', 0);
    putitem_e(tFCR_FATURAI, 'VL_OUTDESC', 0);
    putitem_e(tFCR_FATURAI, 'VL_OUTACRES', 0);
    putitem_e(tFCR_FATURAI, 'VL_ABATIMENTO', 0);
    putitem_e(tFCR_FATURAI, 'VL_DESPFIN', 0);
    putitem_e(tFCR_FATURAI, 'VL_IMPOSTO', 0);
    putitem_e(tFCR_FATURAI, 'VL_LIQUIDO', 0);
    putitem_e(tFCR_FATURAI, 'VL_ACRESCIMO', 0);
    putitem_e(tFCR_FATURAI, 'CD_OPERADOR', itemXmlF('CD_USUARIO', PARAM_GLB));
    putitem_e(tFCR_FATURAI, 'DT_CADASTRO', Now);

    if (vCdComponente <> '') then begin
      putitem_e(tFCR_FATURAI, 'CD_COMPONENTE', vCdComponente);
    end;

    putitem_e(tFCR_FATURAI, 'CD_OPERCAD', itemXmlF('CD_USUARIO', PARAM_GLB));
    putitem_e(tFCR_FATURAI, 'DT_OPERCAD', Now);
    putitem_e(tFCR_FATURAI, 'TP_INCLUSAO', 2);
    putitem_e(tFCR_FATURAI, 'NR_NOSSONUMERO', '');
    putitem_e(tFCR_FATURAI, 'DS_DACNOSSONR', '');
    putitem_e(tFCR_FATURAI, 'TP_COBRANCA', 0);

    if (vTpCobranca = 16)  or (vTpCobranca = 17) then begin
      putitem_e(tFCR_FATURAI, 'TP_COBRANCA', vTpCobranca);

    end else begin
      if (gTpCobrancaBancoReceb <> '') then begin
        vTpCobrancaMover := '';
        vDsCobBanco := gTpCobrancaBancoReceb;
        repeat
          getitem(vTpCobrancaLista, vDsCobBanco, 1);
          if (vTpCobrancaLista = vTpCobranca) then begin
            vTpCobrancaMover := vTpCobrancaLista;
          end;
          delitem(vDsCobBanco, 1);
        until (vDsCobBanco = '');
        if (vTpCobrancaMover > 0) then begin
          putitem_e(tFCR_FATURAI, 'TP_COBRANCA', vTPCobrancaMover);
        end;
      end;
    end;

    vDsFatReg := '';
    putlistitensocc_e(vDsFatReg, tFCR_FATURAI);
    viParams := '';
    putitemXml(viParams, 'DS_FATURAI', vDsFatReg);
    putitemXml(viParams, 'CD_COMPONENTE', FCRSVCO007);
    putitemXml(viParams, 'DS_CHEQUE', '');
    putitemXml(viParams, 'IN_SEMCOMISSAO', True);
    putitemXml(viParams, 'IN_SEMIMPOSTO', True);
    putitemXml(viParams, 'IN_ALTSOFATURAI', False);
    voParams := activateCmp('FCRSVCO001', 'geraFatura', viParams); (*,,,, *)
    if (xStatus < 0) then begin
      Result := voParams;
      return(-1); exit;
    end;

    viParams := '';
    viParams := pParams;
    vNrSequencia := vNrSequencia + 1;
    putitemXml(viParams, 'NR_FAT', item_f('NR_FAT', tFCR_FATURAI));
    putitemXml(viParams, 'NR_PARCELA', item_f('NR_PARCELA', tFCR_FATURAI));
    putitemXml(viParams, 'VL_FATURA', item_f('VL_FATURA', tFCR_FATURAI));
    putitemXml(viParams, 'TP_DOCUMENTO', item_f('TP_DOCUMENTO', tFCR_FATURAI));
    putitemXml(viParams, 'NR_SEQUENCIA', vNrSequencia);
    putitemXml(viParams, 'TP_TIPOREG', 2);
    putitemXml(viParams, 'IN_NAOSOMA', True);

    if (gInRecebimentoFat = True) then begin
      putitemXml(viParams, 'VL_PAGO', item_f('VL_FATURA', tFCR_FATURAI));
    end else begin
      putitemXml(viParams, 'VL_PAGO', 0);
    end;

    voParams := gravaLiqFaturas(viParams); (* PARAM_GLB, viParams, voParams, xCdErro, xCtxErro *)
    if (xStatus < 0) then begin
      Result := voParams;
      return(-1); exit;
    end;

    viParams := '';
    putitemXml(viParams, 'CD_EMPFATORIG', vCdEmpFatOrig);
    putitemXml(viParams, 'CD_CLIENTEORIG', vCdClienteOrig);
    putitemXml(viParams, 'NR_FATORIG', vNrFatOrig);
    putitemXml(viParams, 'NR_PARCELAORIG', vNrParcelaOrig);
    putitemXml(viParams, 'CD_EMPRESA', item_f('CD_EMPRESA', tFCR_FATURAI));
    putitemXml(viParams, 'CD_CLIENTE', item_f('CD_CLIENTE', tFCR_FATURAI));
    putitemXml(viParams, 'NR_FAT', item_f('NR_FAT', tFCR_FATURAI));
    putitemXml(viParams, 'NR_PARCELA', item_f('NR_PARCELA', tFCR_FATURAI));
    voParams := gravarComissaoRecebimento(viParams); (* PARAM_GLB, viParams, voParams, xCdErro, xCtxErro *)
    if (xStatus < 0) then begin
      Result := voParams;
      return(-1); exit;
    end;

    viParams := '';
    putitemXml(viParams, 'CD_EMPRESA', item_f('CD_EMPRESA', tFCR_FATURAI));
    putitemXml(viParams, 'CD_CLIENTE', item_f('CD_CLIENTE', tFCR_FATURAI));
    putitemXml(viParams, 'NR_FAT', item_f('NR_FAT', tFCR_FATURAI));
    putitemXml(viParams, 'NR_PARCELA', item_f('NR_PARCELA', tFCR_FATURAI));
    putitemXml(viParams, 'IN_NOVAFATURA', True);
    voParams := activateCmp('FCRSVCO090', 'gravarClassificacaoFatura', viParams); (*,,,, *)
    if (xStatus < 0) then begin
      Result := voParams;
      return(-1); exit;
    end;
  end;
  if ((vVlIsencaoJuro > 0)  or (vVlIsencaoMulta > 0))  and %\ then begin
    (itemXml('TP_LANCTOJURO', pParams) <> 99);

    clear_e(tFCR_FATURAI);
    creocc(tFCR_FATURAI, -1);
    getlistitensocc_e(vFatOriginal, tFCR_FATURAI);

    if (gNrPortadorJuro > 0) then begin
      putitem_e(tFCR_FATURAI, 'NR_PORTADOR', gNrPortadorJuro);
    end;
    if (itemXml('TP_LANCTOJURO', pParams) = 2) then begin
      clear_e(tGER_EMPRESA);
      putitem_e(tGER_EMPRESA, 'CD_EMPRESA', itemXmlF('CD_EMPRECEBIMENTO', pParams));
      retrieve_e(tGER_EMPRESA);
      if (xStatus < 0) then begin
        Result := SetStatus(STS_ERROR, 'GEN001', 'Empresa inválida p/ gravar fatura de isençao de juros', '');
        return(-1); exit;
      end;
      putitem_e(tFCR_FATURAI, 'CD_CLIENTE', item_f('CD_PESSOA', tGER_EMPRESA));
    end;

    viParams := '';
    voParams := geraSeqParcela(viParams); (* viParams, voParams, xCdErro, xCtxErro *)
    if (xStatus < 0) then begin
      Result := voParams;
      return(-1); exit;
    end;

    putitem_e(tFCR_FATURAI, 'NR_PARCELA', itemXmlF('NR_PARCELA', voParams));
    if (itemXml('TP_LANCTOJURO', pParams) = 2) then begin
      clear_e(tF_FCR_FATURAI);
      putitem_e(tF_FCR_FATURAI, 'CD_EMPRESA', item_f('CD_EMPRESA', tFCR_FATURAI));
      putitem_e(tF_FCR_FATURAI, 'CD_CLIENTE', item_f('CD_CLIENTE', tFCR_FATURAI));
      putitem_e(tF_FCR_FATURAI, 'NR_FAT', item_f('NR_FAT', tFCR_FATURAI));
      retrieve_e(tF_FCR_FATURAI);
      if (xStatus >= 0) then begin
        setocc(tF_FCR_FATURAI, -1);
        if (item_f('NR_PARCELA', tF_FCR_FATURAI) = 999) then begin
          putitem_e(tFCR_FATURAI, 'NR_FAT', vDtSistema);

          voParams := geraSeqParcela(viParams); (* viParams, voParams, xCdErro, xCtxErro *)
          if (xStatus < 0) then begin
            Result := voParams;
            return(-1); exit;
          end;
          putitem_e(tFCR_FATURAI, 'NR_PARCELA', itemXmlF('NR_PARCELA', voParams));
        end;
      end;

      clear_e(tFCR_FATURAC);
      creocc(tFCR_FATURAC, -1);
      putitem_e(tFCR_FATURAC, 'CD_EMPRESA', item_f('CD_EMPRESA', tFCR_FATURAI));
      putitem_e(tFCR_FATURAC, 'CD_CLIENTE', item_f('CD_CLIENTE', tFCR_FATURAI));
      putitem_e(tFCR_FATURAC, 'NR_FAT', item_f('NR_FAT', tFCR_FATURAI));
      retrieve_o(tFCR_FATURAC);
      if (xStatus = -7) then begin
        retrieve_x(tFCR_FATURAC);
      end;

      putitem_e(tFCR_FATURAC, 'CD_OPERADOR', itemXmlF('CD_USUARIO', PARAM_GLB));
      putitem_e(tFCR_FATURAC, 'DT_CADASTRO', Now);
      voParams := tFCR_FATURAC.Salvar();
      if (xStatus < 0) then begin
        Result := voParams;
        return(-1); exit;
      end;
    end;

    voParams := buscaTpDocumentoJuro(viParams); (* item_f('TP_DOCUMENTO', tFCR_FATURAI) *)

    putitem_e(tFCR_FATURAI, 'DT_EMISSAO', gDtpagamento);
    putitem_e(tFCR_FATURAI, 'DT_VENCIMENTO', gDtpagamento + vNrDiasJuroFuturo);
    putitem_e(tFCR_FATURAI, 'VL_JUROS', '');
    putitem_e(tFCR_FATURAI, 'VL_DESCONTO', '');
    putitem_e(tFCR_FATURAI, 'VL_OUTACRES', 0);
    putitem_e(tFCR_FATURAI, 'VL_OUTDESC', 0);
    putitem_e(tFCR_FATURAI, 'VL_ABATIMENTO', 0);
    putitem_e(tFCR_FATURAI, 'VL_DESPFIN', 0);
    putitem_e(tFCR_FATURAI, 'VL_IMPOSTO', 0);
    putitem_e(tFCR_FATURAI, 'VL_ACRESCIMO', 0);
    putitem_e(tFCR_FATURAI, 'TP_FATURAMENTO', 5);
    putitem_e(tFCR_FATURAI, 'VL_FATURA', vVlIsencaoJuro + vVlIsencaoMulta);
    putitem_e(tFCR_FATURAI, 'VL_ORIGINAL', vVlIsencaoJuro + vVlIsencaoMulta);
    putitem_e(tFCR_FATURAI, 'VL_PAGO', 0);
    putitem_e(tFCR_FATURAI, 'CD_OPERADOR', itemXmlF('CD_USUARIO', PARAM_GLB));
    putitem_e(tFCR_FATURAI, 'DT_CADASTRO', Now);

    if (vCdComponente <> '') then begin
      putitem_e(tFCR_FATURAI, 'CD_COMPONENTE', vCdComponente);
    end;

    putitem_e(tFCR_FATURAI, 'NR_NOSSONUMERO', '');
    putitem_e(tFCR_FATURAI, 'DS_DACNOSSONR', '');
    putitem_e(tFCR_FATURAI, 'TP_COBRANCA', 0);

    if (itemXml('TP_LANCTOJURO', pParams) = 2) then begin
      putitem_e(tFCR_FATURAI, 'CD_EMPLIQ', itemXmlF('CD_EMPLIQ', pParams));

      if (item_a('DT_LIQ', tFCR_FATURAI) <> '') then begin
        Result := SetStatus(STS_ERROR, 'GEN001', 'Fatura já liquidada por outro processo ou manutenção.Empresa: ' + cd_empresa + '.FCR_FATURAI Cliente: ' + cd_cliente + '.FCR_FATURAI Fatura: ' + nr_fat + '.FCR_FATURAI Parcela: ' + nr_parcela + '.FCR_FATURAI', '');
        return(-1); exit;
      end;

      putitem_e(tFCR_FATURAI, 'DT_LIQ', itemXml('DT_LIQ', pParams));
      putitem_e(tFCR_FATURAI, 'NR_SEQLIQ', itemXmlF('NR_SEQLIQ', pParams));

      if (gDtpagamento <> '') then begin
        putitem_e(tFCR_FATURAI, 'DT_BAIXA', gDtpagamento);
      end else begin
        putitem_e(tFCR_FATURAI, 'DT_BAIXA', itemXml('DT_SISTEMA', PARAM_GLB));
      end;

      voParams := gravaHoraDtBaixa(viParams); (* *)

      putitem_e(tFCR_FATURAI, 'TP_BAIXA', 1);

      if (itemXml('IN_BAIXAVIABANCO', pParams) = True) then begin
        putitem_e(tFCR_FATURAI, 'TP_BAIXA', 12);
      end;
    end;
    if (gInJuroIsencaoAberto = True) then begin
      putitem_e(tFCR_FATURAI, 'TP_BAIXA', 16);
    end;
    if (xStatus = -11) then begin
      Result := SetStatus(STS_ERROR, 'GEN001', 'Fatura sendo utilizada em outro processo ou manutenção.Empresa: ' + cd_empresa + '.FCR_FATURAI Cliente: ' + cd_cliente + '.FCR_FATURAI Fatura: ' + nr_fat + '.FCR_FATURAI Parcela: ' + nr_parcela + '.FCR_FATURAI', '');
      return(-1); exit;
    end;

    voParams := tFCR_FATURAI.Salvar();
    if (xStatus < 0) then begin
      Result := voParams;
      return(-1); exit;
    end;

    viParams := '';
    putlistitensocc_e(     vDsRegistro, tFCR_FATURAI);
    putitemXml(viParams, 'DS_FATURAI', vDsRegistro);
    putitemXml(viParams, 'DS_CHEQUE', vDsCheque);
    putitemXml(viParams, 'IN_ALTSOFATURAI', False);
    putitemXml(viParams, 'IN_SEMCOMISSAO', True);
    putitemXml(viParams, 'IN_SEMIMPOSTO', True);
    putitemXml(viParams, 'IN_NAOGRVDESCANT', True);
    putitemXml(viParams, 'IN_NAOGRVDESC1', True);
    putitemXml(viParams, 'IN_NAOGRVDESC2', True);

    if (vCdComponente <> '') then begin
      putitemXml(viParams, 'CD_COMPONENTE', vCdComponente);
    end else begin
      putitemXml(viParams, 'CD_COMPONENTE', FCRSVCO007);
    end;

    voParams := activateCmp('FCRSVCO001', 'geraFatura', viParams); (*,,,, *)
    if (xStatus < 0) then begin
      Result := voParams;
      return(-1); exit;
    end;
    if (voParams = '') then begin
      Result := SetStatus(STS_ERROR, 'GEN0001', 'Nenhuma fatura retornada pelo serviço de gravação na isenção de juro.', '');
      return(-1); exit;
    end;

    viParams := '';

    viParams := pParams;
    putitemXml(viParams, 'CD_EMPRESA', item_f('CD_EMPRESA', tFCR_FATURAI));
    putitemXml(viParams, 'CD_CLIENTE', item_f('CD_CLIENTE', tFCR_FATURAI));
    vNrSequencia := vNrSequencia + 1;
    putitemXml(viParams, 'NR_FAT', item_f('NR_FAT', tFCR_FATURAI));
    putitemXml(viParams, 'NR_PARCELA', item_f('NR_PARCELA', tFCR_FATURAI));
    putitemXml(viParams, 'VL_FATURA', item_f('VL_FATURA', tFCR_FATURAI));
    putitemXml(viParams, 'NR_SEQUENCIA', vNrSequencia);
    putitemXml(viParams, 'TP_TIPOREG', 2);
    putitemXml(viParams, 'TP_DOCUMENTO', item_f('TP_DOCUMENTO', tFCR_FATURAI));
    putitemXml(viParams, 'IN_NAOSOMA', True);

    if (gInRecebimentoFat = True) then begin
      putitemXml(viParams, 'VL_PAGO', item_f('VL_FATURA', tFCR_FATURAI));
    end else begin
      putitemXml(viParams, 'VL_PAGO', 0);
    end;

    voParams := gravaLiqFaturas(viParams); (* PARAM_GLB, viParams, voParams, xCdErro, xCtxErro *)
    if (xStatus < 0) then begin
      Result := voParams;
      return(-1); exit;
    end;
  end;
  if ((vVlIsencaoJuro > 0)  or (vVlIsencaoMulta > 0))  and %\ then begin
    (itemXml('TP_LANCTOJURO', pParams) := 99);
    gVl12D2 := vVlIsencaoJuro + vVlIsencaoMulta;
    viParams := '';
    putitemXml(viParams, 'CD_EMPRESA', item_f('CD_EMPRESA', tFCR_FATURAI));
    putitemXml(viParams, 'CD_CLIENTE', item_f('CD_CLIENTE', tFCR_FATURAI));
    putitemXml(viParams, 'NR_FAT', item_f('NR_FAT', tFCR_FATURAI));
    putitemXml(viParams, 'NR_PARCELA', item_f('NR_PARCELA', tFCR_FATURAI));
    putitemXml(viParams, 'TP_LOGFAT', 14);
    putitemXml(viParams, 'DS_COMPONENTE', vCdComponente);
    putitemXml(viParams, 'DS_OBS', 'ISENCAO DE JURO/MULTA NO VALOR DE ' + FloatToStr(gVl) + '12D2');
    voParams := activateCmp('FCRSVCO001', 'gravaLogFatura', viParams); (*,,,, *)
    if (xStatus < 0) then begin
      Result := voParams;
      return(-1); exit;
    end;
  end;
  if (gInVariacaoCambial = True) then begin
    viParams := '';
    putitemXml(viParams, 'CD_EMPFAT', itemXmlF('CD_EMPRESA', pParams));
    putitemXml(viParams, 'CD_CLIENTE', itemXmlF('CD_CLIENTE', pParams));
    putitemXml(viParams, 'NR_FAT', itemXmlF('NR_FAT', pParams));
    putitemXml(viParams, 'NR_PARCELA', itemXmlF('NR_PARCELA', pParams));
    putitemXml(viParams, 'IN_BAIXA', True);
    putitemXml(viParams, 'IN_PARCIAL', True);
    voParams := activateCmp('FCRSVCO087', 'gravaFatVariacaoPagto', viParams); (*,,, *)
    if (xStatus < 0) then begin
      Result := voParams;
      return(-1); exit;
    end;
  end;

  Result := '';
  putitemXml(Result, 'NR_SEQUENCIA', vNrSequencia);

  return(0); exit;
end;

//---------------------------------------------------------------
function T_FCRSVCO007.gravaLiqFaturas(pParams : String) : String;
//---------------------------------------------------------------
const
  cDS_METHOD = 'ADICIONAL=Operação: T_FCRSVCO007.gravaLiqFaturas()';
var
  vDtTransacao, vDtSistema : TDate;
  vDsRegistro, vDsLstTransacao, vDsLstFatura, viParams, voParams : String;
  vCdEmpresa, vNrTransacao, vNrSeqLiq, vNrCtaPesCx, vNrSeqHistRelSub : Real;
  vCdCliente, vNrFat, vNrParcela, vNrSeq, vVlPago : Real;
begin
  if (itemXml('IN_VALIDA', pParams) <> True) then begin
    if (itemXml('CD_EMPRESA', pParams) = '') then begin
      Result := SetStatus(STS_ERROR, 'GEN001', 'Código de empresa não informada', '');
      return(-1); exit;
    end;
    if (itemXml('CD_CLIENTE', pParams) = '') then begin
      Result := SetStatus(STS_ERROR, 'GEN001', 'Código de cliente não informado', '');
      return(-1); exit;
    end;
    if (itemXml('NR_FAT', pParams) = '') then begin
      Result := SetStatus(STS_ERROR, 'GEN001', 'Número da fatura nco informado', '');
      return(-1); exit;
    end;
    if (itemXml('NR_PARCELA', pParams) = '') then begin
      Result := SetStatus(STS_ERROR, 'GEN001', 'Número da parcela da fatura não informado', '');
      return(-1); exit;
    end;
    if (itemXml('TP_DOCUMENTO', pParams) = '') then begin
      Result := SetStatus(STS_ERROR, 'GEN001', 'Tipo de documento da fatura não informado', '');
      return(-1); exit;
    end;
  end;
  if (itemXml('CD_EMPLIQ', pParams) = '') then begin
    Result := SetStatus(STS_ERROR, 'GEN001', 'Falta informar a empresa da liquidação', '');
    return(-1); exit;
  end;
  if (itemXml('DT_LIQ', pParams) = '') then begin
    Result := SetStatus(STS_ERROR, 'GEN001', 'Falta informar a data da liquidação', '');
    return(-1); exit;
  end;
  if (itemXml('NR_SEQLIQ', pParams) = '') then begin
    Result := SetStatus(STS_ERROR, 'GEN001', 'Falta informar a sequencia da liquidação', '');
    return(-1); exit;
  end;
  if (itemXml('TP_LIQUIDACAO', pParams) = '') then begin
    Result := SetStatus(STS_ERROR, 'GEN001', 'Falta informar o tipo da liquidação', '');
    return(-1); exit;
  end;
  vVlPago := itemXmlF('VL_PAGO', pParams);
  if (itemXml('IN_NAOSOMA', pParams) <> True) then begin
    if (vVlPago  = 0) then begin
      Result := SetStatus(STS_ERROR, 'GEN001', 'Falta informar o valor a liquidação', '');
      return(-1); exit;
    end;
  end;

  clear_e(tFGR_LIQ);
  putitem_e(tFGR_LIQ, 'CD_EMPLIQ', itemXmlF('CD_EMPLIQ', pParams));
  putitem_e(tFGR_LIQ, 'DT_LIQ', itemXml('DT_LIQ', pParams));
  putitem_e(tFGR_LIQ, 'NR_SEQLIQ', itemXmlF('NR_SEQLIQ', pParams));
  retrieve_e(tFGR_LIQ);
  if (xStatus < 0) then begin
    creocc(tFGR_LIQ, -1);
    putitem_e(tFGR_LIQ, 'CD_EMPLIQ', itemXmlF('CD_EMPLIQ', pParams));
    putitem_e(tFGR_LIQ, 'DT_LIQ', itemXml('DT_LIQ', pParams));
    putitem_e(tFGR_LIQ, 'NR_SEQLIQ', itemXmlF('NR_SEQLIQ', pParams));
    putitem_e(tFGR_LIQ, 'TP_LIQUIDACAO', itemXmlF('TP_LIQUIDACAO', pParams));
    putitem_e(tFGR_LIQ, 'CD_GRUPOEMPRESA', itemXmlF('CD_GRUPOEMPRESA', PARAM_GLB));
    putitem_e(tFGR_LIQ, 'CD_PESSOA', itemXmlF('CD_PESSOA', pParams));
  end;

  creocc(tFGR_LIQITEMCR, -1);
  putitem_e(tFGR_LIQITEMCR, 'CD_EMPLIQ', item_f('CD_EMPLIQ', tFGR_LIQ));
  putitem_e(tFGR_LIQITEMCR, 'DT_LIQ', item_a('DT_LIQ', tFGR_LIQ));
  putitem_e(tFGR_LIQITEMCR, 'NR_SEQLIQ', item_f('NR_SEQLIQ', tFGR_LIQ));
  putitem_e(tFGR_LIQITEMCR, 'NR_SEQITEM', itemXmlF('NR_SEQUENCIA', pParams));
  putitem_e(tFGR_LIQITEMCR, 'TP_TIPOREG', itemXmlF('TP_TIPOREG', pParams));
  putitem_e(tFGR_LIQITEMCR, 'NR_CTAPES', itemXmlF('NR_CTACREDITO', pParams));
  putitem_e(tFGR_LIQITEMCR, 'NR_CTAPESCX', itemXmlF('NR_CTADEBITO', pParams));
  putitem_e(tFGR_LIQITEMCR, 'NR_CTAPESFCC', itemXmlF('NR_CTAPESFILIAL', pParams));
  putitem_e(tFGR_LIQITEMCR, 'CD_EMPFAT', itemXmlF('CD_EMPRESA', pParams));
  putitem_e(tFGR_LIQITEMCR, 'CD_CLIENTE', itemXmlF('CD_CLIENTE', pParams));
  putitem_e(tFGR_LIQITEMCR, 'NR_FAT', itemXmlF('NR_FAT', pParams));
  putitem_e(tFGR_LIQITEMCR, 'NR_PARCELA', itemXmlF('NR_PARCELA', pParams));
  putitem_e(tFGR_LIQITEMCR, 'TP_DOCUMENTO', itemXmlF('TP_DOCUMENTO', pParams));
  putitem_e(tFGR_LIQITEMCR, 'NR_ANO', itemXmlF('NR_PORTADOR', pParams));
  putitem_e(tFGR_LIQ, 'CD_OPERADOR', itemXmlF('CD_USUARIO', PARAM_GLB));
  putitem_e(tFGR_LIQITEMCR, 'CD_OPERADOR', itemXmlF('CD_USUARIO', PARAM_GLB));
  putitem_e(tFGR_LIQ, 'DT_CADASTRO', Now);
  putitem_e(tFGR_LIQITEMCR, 'DT_CADASTRO', Now);
  putitem_e(tFGR_LIQITEMCR, 'VL_LANCAMENTO', vVlPago);
  putitem_e(tFGR_LIQITEMCR, 'NR_DOFNI', itemXmlF('NR_DOFNI', pParams));
  if (itemXml('IN_NAOSOMA', pParams) <> True) then begin
    putitem_e(tFGR_LIQ, 'VL_TOTAL', item_f('VL_TOTAL', tFGR_LIQ) + vVlPago);
  end;

  putitem_e(tFGR_LIQITEMCR, 'CD_EMPTRANSACAO', itemXmlF('CD_EMPTRANSACAO', pParams));
  putitem_e(tFGR_LIQITEMCR, 'NR_TRANSACAO', itemXmlF('NR_TRANSACAO', pParams));
  putitem_e(tFGR_LIQITEMCR, 'DT_TRANSACAO', itemXml('DT_TRANSACAO', pParams));

  voParams := tFGR_LIQ.Salvar();
  if (xStatus < 0) then begin
    Result := voParams;
    return(-1); exit;
  end;
  if (item_f('CD_EMPFAT', tFGR_LIQITEMCR) <> '')  and (item_f('CD_CLIENTE', tFGR_LIQITEMCR) <> '')  and (item_f('NR_FAT', tFGR_LIQITEMCR) <> '')  and (item_f('NR_PARCELA', tFGR_LIQITEMCR) <> '') then begin
    viParams := '';
    putitemXml(viParams, 'CD_EMPLIQ', item_f('CD_EMPLIQ', tFGR_LIQITEMCR));
    putitemXml(viParams, 'DT_LIQ', item_a('DT_LIQ', tFGR_LIQITEMCR));
    putitemXml(viParams, 'NR_SEQLIQ', item_f('NR_SEQLIQ', tFGR_LIQITEMCR));
    putitemXml(viParams, 'NR_SEQITEM', item_f('NR_SEQITEM', tFGR_LIQITEMCR));
    putitemXml(viParams, 'CD_EMPFAT', item_f('CD_EMPFAT', tFGR_LIQITEMCR));
    putitemXml(viParams, 'CD_CLIENTE', item_f('CD_CLIENTE', tFGR_LIQITEMCR));
    putitemXml(viParams, 'NR_FAT', item_f('NR_FAT', tFGR_LIQITEMCR));
    putitemXml(viParams, 'NR_PARCELA', item_f('NR_PARCELA', tFGR_LIQITEMCR));
    if (xStatus < 0) then begin
      Result := voParams;
      return(-1); exit;
    end;
  end;

  return(0); exit;
end;

//--------------------------------------------------------------
function T_FCRSVCO007.geraSeqParcela(pParams : String) : String;
//--------------------------------------------------------------
const
  cDS_METHOD = 'ADICIONAL=Operação: T_FCRSVCO007.geraSeqParcela()';
var
  vCdEmpresa, vCdCliente, vNrFatura, vNrParcela, vNrParcelaIni, vNrParcelaFim, vTpParcela : Real;
  viParams, voParams : String;
begin
  vCdEmpresa := item_f('CD_EMPRESA', tFCR_FATURAI);
  vCdCliente := item_f('CD_CLIENTE', tFCR_FATURAI);
  vNrFatura := item_f('NR_FAT', tFCR_FATURAI);

  select max(nr_parcela) from 'FCR_FATURAI' where (putitem_e(tFCR_FATURAI, 'CD_EMPRESA', vCdEmpresa ) and (
                                  putitem_e(tFCR_FATURAI, 'CD_CLIENTE', vCdCliente ) and (
                            putitem_e(tFCR_FATURAI, 'NR_FAT', vNrFatura)
                            to vNrParcela;
  if (vNrParcela >= 200) then begin
    vNrParcela := vNrParcela + 1;
  end else begin
    vNrParcela := 200;
  end;

  Result := '';
  putitemXml(Result, 'NR_PARCELA', vNrParcela);

  return(0); exit;
end;

//-----------------------------------------------------------
function T_FCRSVCO007.baixaCheque(pParams : String) : String;
//-----------------------------------------------------------
const
  cDS_METHOD = 'ADICIONAL=Operação: T_FCRSVCO007.baixaCheque()';
var
  vDsFaturas, vDsLinha, viParams, voParams, vpiValores, vDsAux : String;
  vInUtilizaCxFilial : Boolean;
  vCdCliente, vNrFat, vNrParcela, vVlaCreditar, vNrSeqLiq, vNrSequencia, vNrPortador, vTpDocumento, vTpProcesso : Real;
  vTpCobranca, vVlSaldoAnt, vVlSaldoAtualDoc, vVlSaldoAtual, vVlSaldo, vVlSaldoAntDoc, vNrCtaPesFCC, vNrSeqMovFCC : Real;
  vDtLiq, vDtMovimFCC, vDtBaixa : TDate;
begin
  vInUtilizaCxFilial := itemXmlB('IN_UTILIZA_CXFILIAL', pParams);
  if (itemXml('CD_EMPPADRAO', pParams) = '') then begin
    Result := SetStatus(STS_ERROR, 'GEN001', 'Falta informar o código da empresa', '');
    return(-1); exit;
  end;
  if (itemXml('NR_CTADEBITO', pParams) = '') then begin
    Result := SetStatus(STS_ERROR, 'GEN001', 'Falta informar o código da conta p/ debito', '');
    return(-1); exit;
  end;
  if (itemXml('NR_CTACREDITO', pParams) = '') then begin
    Result := SetStatus(STS_ERROR, 'GEN001', 'Falta informar o código da conta p/ crédito', '');
    return(-1); exit;
  end;
  if (itemXml('DT_BAIXA', pParams) = '') then begin
    Result := SetStatus(STS_ERROR, 'GEN001', 'Falta informar a data de baixa dos cheques', '');
    return(-1); exit;
  end;
  if (itemXml('NR_PORTADOR', pParams) = '') then begin
    Result := SetStatus(STS_ERROR, 'GEN001', 'Falta informar o novo portador para baixa dos cheques', '');
    return(-1); exit;
  end;

  vTpDocumento := itemXmlF('TP_DOCUMENTO', pParams);
  if (vTpDocumento = '') then begin
    Result := SetStatus(STS_ERROR, 'GEN001', 'Favor informar o tipo de documento para baixa de cheques', '');
    return(-1); exit;
  end;

  vDtBaixa := itemXml('DT_BAIXA', pParams);
  vTpCobranca := itemXmlF('TP_COBRANCA', pParams);
  vDsAux := itemXml('DS_AUX', pParams);

  vTpProcesso := itemXmlF('TP_PROCESSO', pParams);
  xParamEmp := '';
  putitem(xParamEmp,  'IN_LOG_MOV_CTAPES');
  xParam := T_ADMSVCO001.GetParametro(xParam); (*xParamEmp,xParamEmp,, *)
  gInLogMovCtaPes := itemXmlB('IN_LOG_MOV_CTAPES', xParamEmp);
  if (gInLogMovCtaPes = True)  and ((vTpProcesso = '')  or (vTpProcesso = 0)) then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Tipo de processo não informado!', cDS_METHOD);
    return(-1); exit;
  end;

  viParams := '';
  putitemXml(viParams, 'NM_ENTIDADE', 'FGR_LIQ');
  newinstance 'GERSVCO031', 'GERSVCO031X';
  voParams := activateCmp('GERSVCO031X', 'getNumSeq', viParams); (*,,,, *)
  if (xStatus < 0) then begin
    Result := voParams;
    return(-1); exit;
  end;
  if (itemXml('NR_SEQUENCIA', voParams) = '') then begin
    Result := SetStatus(STS_ERROR, 'GEN001', 'Não gerou sequência de liquidação', '');
    return(-1); exit;
  end;

  vNrSeqLiq := itemXmlF('NR_SEQUENCIA', voParams);
  vDsFaturas := itemXml('DS_FATURAS', pParams);
  vNrSequencia := 1;

  if (vDsFaturas <> '') then begin
    repeat
      getitem(vDsLinha, vDsFaturas, 1);

      clear_e(tFCR_FATURAI);
      putitem_e(tFCR_FATURAI, 'CD_EMPRESA', itemXmlF('CD_EMPRESA', vDsLinha));
      putitem_e(tFCR_FATURAI, 'CD_CLIENTE', itemXmlF('CD_CLIENTE', vDsLinha));
      putitem_e(tFCR_FATURAI, 'NR_FAT', itemXmlF('NR_FAT', vDsLinha));
      putitem_e(tFCR_FATURAI, 'NR_PARCELA', itemXmlF('NR_PARCELA', vDsLinha));
      retrieve_e(tFCR_FATURAI);
      if (xStatus < 0) then begin
        vCdCliente := itemXmlF('CD_CLIENTE', vDsLinha);
        vNrFat := itemXmlF('NR_FAT', vDsLinha);
        vNrParcela := itemXmlF('NR_PARCELA', vDsLinha);
        Result := SetStatus(STS_ERROR, 'GEN001', 'Cheque não encontrado - Cliente= ' + FloatToStr(vCdCliente) + ' Cheque Nr.= ' + FloatToStr(vNrFat) + ' Parcela= ' + FloatToStr(vNrParcela',) + ' '');
      end else begin
        message/hint 'Baixando cheque  -> nr. ' + nr_fat + '.FCR_FATURAI / ' + nr_parcela + '.FCR_FATURAI';

        vNrPortador := item_f('NR_PORTADOR', tFCR_FATURAI);

        if (vTpCobranca = 2) then begin
          putitem_e(tFCR_FATURAI, 'TP_BAIXA', 18);
        end else begin
          putitem_e(tFCR_FATURAI, 'TP_BAIXA', 2);
        end;

        putitem_e(tFCR_FATURAI, 'CD_OPERBAIXA', itemXmlF('CD_USUARIO', PARAM_GLB));
        putitem_e(tFCR_FATURAI, 'NR_PORTADOR', itemXmlF('NR_PORTADOR', pParams));
        putitem_e(tFCR_FATURAI, 'CD_EMPLIQ', itemXmlF('CD_EMPPADRAO', pParams));

        if (item_a('DT_LIQ', tFCR_FATURAI) <> '') then begin
          Result := SetStatus(STS_ERROR, 'GEN001', 'Fatura já liquidada por outro processo ou manutenção.Empresa: ' + cd_empresa + '.FCR_FATURAI Cliente: ' + cd_cliente + '.FCR_FATURAI Fatura: ' + nr_fat + '.FCR_FATURAI Parcela: ' + nr_parcela + '.FCR_FATURAI', '');
          return(-1); exit;
        end;

        putitem_e(tFCR_FATURAI, 'DT_LIQ', vDtBaixa);
        putitem_e(tFCR_FATURAI, 'NR_SEQLIQ', vNrSeqLiq);
        putitem_e(tFCR_FATURAI, 'VL_PAGO', itemXmlF('VL_FATURA', vDsLinha));
        putitem_e(tFCR_FATURAI, 'DT_BAIXA', itemXml('DT_SISTEMA', PARAM_GLB));

        if (vDtBaixa <= itemXml('DT_SISTEMA', PARAM_GLB)  and (vDtBaixa >= item_a('DT_EMISSAO', tFCR_FATURAI))) then begin
          putitem_e(tFCR_FATURAI, 'DT_BAIXA', vDtBaixa);
        end;

        voParams := gravaHoraDtBaixa(viParams); (* *)

        putitem_e(tFCR_FATURAI, 'CD_OPERADOR', itemXmlF('CD_USUARIO', PARAM_GLB));
        putitem_e(tFCR_FATURAI, 'DT_CADASTRO', Now);

        if (xStatus = -11) then begin
          Result := SetStatus(STS_ERROR, 'GEN001', 'Fatura sendo utilizada em outro processo ou manutenção.Empresa: ' + cd_empresa + '.FCR_FATURAI Cliente: ' + cd_cliente + '.FCR_FATURAI Fatura: ' + nr_fat + '.FCR_FATURAI Parcela: ' + nr_parcela + '.FCR_FATURAI', '');
          return(-1); exit;
        end;

        voParams := tFCR_FATURAI.Salvar();
        if (xStatus < 0) then begin
          Result := SetStatus(STS_ERROR, {xCdErro} '', '{xCtxErro} ''', cDS_METHOD);
          return(-1); exit;
        end;

        clear_e(tFCR_CHEQUE);
        putitem_e(tFCR_CHEQUE, 'CD_EMPRESA', item_f('CD_EMPRESA', tFCR_FATURAI));
        putitem_e(tFCR_CHEQUE, 'CD_CLIENTE', item_f('CD_CLIENTE', tFCR_FATURAI));
        putitem_e(tFCR_CHEQUE, 'NR_FAT', item_f('NR_FAT', tFCR_FATURAI));
        putitem_e(tFCR_CHEQUE, 'NR_PARCELA', item_f('NR_PARCELA', tFCR_FATURAI));
        retrieve_e(tFCR_CHEQUE);
        if (xStatus >= 0) then begin
          if (item_a('DT_BAIXA1', tFCR_CHEQUE) = '') then begin
            putitem_e(tFCR_CHEQUE, 'DT_BAIXA1', itemXml('DT_BAIXA', pParams));
            putitem_e(tFCR_CHEQUE, 'NR_CTAPESBX1', itemXmlF('NR_CTACREDITO', pParams));
          end else if (item_a('DT_BAIXA2', tFCR_CHEQUE) = '') then begin
            putitem_e(tFCR_CHEQUE, 'DT_BAIXA2', itemXml('DT_BAIXA', pParams));
            putitem_e(tFCR_CHEQUE, 'NR_CTAPESBX2', itemXmlF('NR_CTACREDITO', pParams));
          end;
          if (item_a('DT_BAIXA2', tFCR_CHEQUE) <> '')  and (item_a('DT_BAIXA1', tFCR_CHEQUE) >= item_a('DT_BAIXA2', tFCR_CHEQUE)) then begin
            Result := SetStatus(STS_AVISO, 'GEN001', 'Baixa não permitida.Data da segunda baixa do cheque (' + dt_baixa + 'item_a('2', tFCR_CHEQUE)) deve ser superior a data da primeira baixa (' + dt_baixa + 'item_a('1', tFCR_CHEQUE)).', '');
            return(-1); exit;
          end;

          putitem_e(tFCR_CHEQUE, 'CD_OPERADOR', itemXmlF('CD_USUARIO', PARAM_GLB));
          putitem_e(tFCR_CHEQUE, 'DT_CADASTRO', Now);
          voParams := tFCR_CHEQUE.Salvar();
          if (xStatus < 0) then begin
            Result := SetStatus(STS_ERROR, {xCdErro} '', '{xCtxErro} ''', cDS_METHOD);
            return(-1); exit;
          end;
        end;
      end;

      viParams := '';
      putitemXml(viParams, 'CD_EMPLIQ', itemXmlF('CD_EMPPADRAO', pParams));
      putitemXml(viParams, 'DT_LIQ', itemXml('DT_BAIXA', pParams));
      putitemXml(viParams, 'NR_SEQLIQ', vNrSeqLiq);

      if (vTpCobranca = 2) then begin
        putitemXml(viParams, 'TP_LIQUIDACAO', 79);

      end else if (vTpCobranca = 22) then begin
        putitemXml(viParams, 'TP_LIQUIDACAO', 106);

      end else begin

        if (itemXml('IN_DEPOSITODINHEIRO', pParams) = True) then begin
          putitemXml(viParams, 'TP_LIQUIDACAO', 112);
        end else begin
          putitemXml(viParams, 'TP_LIQUIDACAO', 7);
        end;
      end;

      putitemXml(viParams, 'NR_SEQUENCIA', vNrSequencia);
      putitemXml(viParams, 'TP_TIPOREG', 1);
      putitemXml(viParams, 'CD_EMPRESA', item_f('CD_EMPRESA', tFCR_FATURAI));
      putitemXml(viParams, 'CD_CLIENTE', item_f('CD_CLIENTE', tFCR_FATURAI));
      putitemXml(viParams, 'TP_DOCUMENTO', item_f('TP_DOCUMENTO', tFCR_FATURAI));
      putitemXml(viParams, 'NR_FAT', item_f('NR_FAT', tFCR_FATURAI));
      putitemXml(viParams, 'NR_PARCELA', item_f('NR_PARCELA', tFCR_FATURAI));
      putitemXml(viParams, 'NR_CTACREDITO', itemXmlF('NR_CTACREDITO', pParams));
      putitemXml(viParams, 'VL_PAGO', item_f('VL_PAGO', tFCR_FATURAI));
      putitemXml(viParams, 'NR_PORTADOR', vNrPortador);
      voParams := gravaLiqFaturas(viParams); (* PARAM_GLB, viParams, voParams, xCdErro, xCtxErro *)
      if (xStatus < 0) then begin
        Result := voParams;
        return(-1); exit;
      end;
      vNrSequencia := vNrSequencia + 1;

      delitem(vDsFaturas, 1);
    until (vDsFaturas = '');

    viParams := '';
    putitemXml(viParams, 'CD_EMPLIQ', itemXmlF('CD_EMPPADRAO', pParams));
    putitemXml(viParams, 'DT_LIQ', itemXml('DT_BAIXA', pParams));
    putitemXml(viParams, 'NR_SEQLIQ', vNrSeqLiq);

    if (vTpCobranca = 2) then begin
      putitemXml(viParams, 'TP_LIQUIDACAO', 79);

    end else if (vTpCobranca = 22) then begin
      putitemXml(viParams, 'TP_LIQUIDACAO', 106);

    end else begin

      if (itemXml('IN_DEPOSITODINHEIRO', pParams) = True) then begin
        putitemXml(viParams, 'TP_LIQUIDACAO', 112);
      end else begin

        putitemXml(viParams, 'TP_LIQUIDACAO', 7);
      end;
    end;

    putitemXml(viParams, 'NR_SEQUENCIA', vNrSequencia);
    putitemXml(viParams, 'TP_TIPOREG', 2);
    putitemXml(viParams, 'NR_CTACREDITO', itemXmlF('NR_CTACREDITO', pParams));
    putitemXml(viParams, 'TP_DOCUMENTO', 2);
    if (vInUtilizaCxFilial = True) then begin
      putitemXml(viParams, 'NR_CTAPESFILIAL', itemXmlF('NR_CTADEBITO', pParams));
    end;
    putitemXml(viParams, 'VL_PAGO', itemXmlF('VL_BAIXACHEQUE', pParams));
    putitemXml(viParams, 'IN_NAOSOMA', True);
    putitemXml(viParams, 'IN_VALIDA', True);
    voParams := gravaLiqFaturas(viParams); (* PARAM_GLB, viParams, voParams, xCdErro, xCtxErro *)
    if (xStatus < 0) then begin
      Result := voParams;
      return(-1); exit;
    end;
  end;

  clear_e(tGER_GRUPOEMPR);
  putitem_e(tGER_GRUPOEMPR, 'CD_GRUPOEMPRESA', itemXmlF('CD_GRUPOEMPRESA', PARAM_GLB));
  retrieve_e(tGER_GRUPOEMPR);

  if (itemXml('VL_DINHEIRO', pParams) > 0) then begin
    if (gInLogMovCtaPes = True) then begin
      viParams := '';
      putitemXml(viParams, 'NR_CTAPES', itemXmlF('NR_CTADEBITO', pParams));
      putitemXml(viParams, 'DT_SALDO', itemXml('DT_SISTEMA', PARAM_GLB));
      voParams := activateCmp('FCCSVCO002', 'buscaSaldoConta', viParams); (*,,'',,, *)
      if (xStatus < 0) then begin
        Result := voParams;
        return(-1); exit;
      end;
      vVlSaldoAnt := itemXmlF('VL_SALDO', voParams);

      viParams := '';
      putitemXml(viParams, 'NR_CTAPES', itemXmlF('NR_CTADEBITO', pParams));
      putitemXml(viParams, 'TP_DOCUMENTO', 3);
      putitemXml(viParams, 'NR_SEQHISTRELSUB', 1);
      putitemXml(viParams, 'DT_SALDO', itemXml('DT_SISTEMA', PARAM_GLB));
      voParams := activateCmp('FCCSVCO002', 'buscaSaldoCtaTp', viParams); (*,,'',,, *)
      if (xStatus < 0) then begin
        Result := voParams;
        return(-1); exit;
      end;
      vVlSaldoAntDoc := itemXmlF('VL_SALDO', voParams);
    end;

    viParams := '';
    putitemXml(viParams, 'CD_EMPRESA', itemXmlF('CD_EMPRESA', PARAM_GLB));
    putitemXml(viParams, 'NR_CTAPES', itemXmlF('NR_CTADEBITO', pParams));
    putitemXml(viParams, 'DT_MOVIMENTO', itemXml('DT_BAIXA', pParams));
    putitemXml(viParams, 'TP_DOCUMENTO', 3);
    putitemXml(viParams, 'NR_SEQHISTRELSUB', 1);
    putitemXml(viParams, 'CD_HISTORICO', 915);
    putitemXml(viParams, 'VL_LANCTO', itemXmlF('VL_DINHEIRO', pParams));
    putitemXml(viParams, 'IN_ESTORNO', 'N');

    if (vDsAux <> '') then begin
      putitemXml(viParams, 'DS_AUX', '' + CD_GRUPOEMPRESA + '.GER_GRUPOEMPR ' + NM_GRUPOEMPRESA + '.GER_GRUPOEMPR ' + vDsAux') + ';
    end else begin
      putitemXml(viParams, 'DS_AUX', '' + CD_GRUPOEMPRESA + '.GER_GRUPOEMPR ' + NM_GRUPOEMPRESA + '.GER_GRUPOEMPR');
    end;

    putitemXml(viParams, 'CD_EMPLIQ', itemXmlF('CD_EMPPADRAO', pParams));
    putitemXml(viParams, 'DT_LIQ', itemXml('DT_BAIXA', pParams));
    putitemXml(viParams, 'NR_SEQLIQ', vNrSeqLiq);
    voParams := activateCmp('FCCSVCO002', 'movimentaConta', viParams); (*,,vpiValores,,, *)
    if (xStatus < 0) then begin
      Result := voParams;
      return(-1); exit;
    end;
    if (gInLogMovCtaPes = True) then begin
      vNrCtaPesFCC := itemXmlF('NR_CTAPES', voParams);
      vDtMovimFCC := itemXml('DT_MOVIM', voParams);
      vNrSeqMovFCC := itemXmlF('NR_SEQMOV', voParams);

      viParams := '';
      putitemXml(viParams, 'NR_CTAPES', itemXmlF('NR_CTADEBITO', pParams));
      putitemXml(viParams, 'DT_SALDO', itemXml('DT_SISTEMA', PARAM_GLB));
      voParams := activateCmp('FCCSVCO002', 'buscaSaldoConta', viParams); (*,,'',,, *)
      if (xStatus < 0) then begin
        Result := voParams;
        return(-1); exit;
      end;
      vVlSaldoAtual := itemXmlF('VL_SALDO', voParams);

      viParams := '';
      putitemXml(viParams, 'NR_CTAPES', itemXmlF('NR_CTADEBITO', pParams));
      putitemXml(viParams, 'TP_DOCUMENTO', 3);
      putitemXml(viParams, 'NR_SEQHISTRELSUB', 1);
      putitemXml(viParams, 'DT_SALDO', itemXml('DT_SISTEMA', PARAM_GLB));
      voParams := activateCmp('FCCSVCO002', 'buscaSaldoCtaTp', viParams); (*,,'',,, *)
      if (xStatus < 0) then begin
        Result := voParams;
        return(-1); exit;
      end;
      vVlSaldoAtualDoc := itemXmlF('VL_SALDO', voParams);

      viParams := '';
      putitemXml(viParams, 'TP_PROCESSO', vTpProcesso);
      putitemXml(viParams, 'TP_DOCUMENTO', 3);
      putitemXml(viParams, 'NR_CTAPES', itemXmlF('NR_CTADEBITO', pParams));
      putitemXml(viParams, 'VL_LANCAMENTO', itemXmlF('VL_DINHEIRO', pParams));
      putitemXml(viParams, 'VL_SALDODOC', vVlSaldoAtualDoc);
      putitemXml(viParams, 'VL_SALDOCTA', vVlSaldoAtual);
      putitemXml(viParams, 'VL_SALDOANTDOC', vVlSaldoAntDoc);
      putitemXml(viParams, 'VL_SALDOANTCTA', vVlSaldoAnt);
      putitemXml(viParams, 'NR_CTAPESFCC', vNrCtaPesFCC);
      putitemXml(viParams, 'DT_MOVIMFCC', vDtMovimFCC);
      putitemXml(viParams, 'NR_SEQMOVFCC', vNrSeqMovFCC);
      voParams := activateCmp('FCCSVCO018', 'gravarLogMovtoCtaPes', viParams); (*,,,, *)
      if (xStatus < 0) then begin
        Result := voParams;
        return(-1); exit;
      end;
    end;
    if (gInLogMovCtaPes = True) then begin
      viParams := '';
      putitemXml(viParams, 'NR_CTAPES', itemXmlF('NR_CTACREDITO', pParams));
      putitemXml(viParams, 'DT_SALDO', itemXml('DT_SISTEMA', PARAM_GLB));
      voParams := activateCmp('FCCSVCO002', 'buscaSaldoConta', viParams); (*,,'',,, *)
      if (xStatus < 0) then begin
        Result := voParams;
        return(-1); exit;
      end;
      vVlSaldoAnt := itemXmlF('VL_SALDO', voParams);

      viParams := '';
      putitemXml(viParams, 'NR_CTAPES', itemXmlF('NR_CTACREDITO', pParams));
      putitemXml(viParams, 'TP_DOCUMENTO', 3);
      putitemXml(viParams, 'NR_SEQHISTRELSUB', 1);
      putitemXml(viParams, 'DT_SALDO', itemXml('DT_SISTEMA', PARAM_GLB));
      voParams := activateCmp('FCCSVCO002', 'buscaSaldoCtaTp', viParams); (*,,'',,, *)
      if (xStatus < 0) then begin
        Result := voParams;
        return(-1); exit;
      end;
      vVlSaldoAntDoc := itemXmlF('VL_SALDO', voParams);
    end;

    viParams := '';
    putitemXml(viParams, 'CD_EMPRESA', itemXmlF('CD_EMPPADRAO', pParams));
    putitemXml(viParams, 'NR_CTAPES', itemXmlF('NR_CTACREDITO', pParams));
    putitemXml(viParams, 'DT_MOVIMENTO', itemXml('DT_BAIXA', pParams));
    putitemXml(viParams, 'TP_DOCUMENTO', 3);
    putitemXml(viParams, 'NR_SEQHISTRELSUB', 1);
    putitemXml(viParams, 'CD_HISTORICO', 916);
    putitemXml(viParams, 'VL_LANCTO', itemXmlF('VL_DINHEIRO', pParams));
    putitemXml(viParams, 'IN_ESTORNO', 'N');
    putitemXml(viParams, 'DS_AUX', '' + CD_GRUPOEMPRESA + '.GER_GRUPOEMPR ' + NM_GRUPOEMPRESA + '.GER_GRUPOEMPR');
    putitemXml(viParams, 'CD_EMPLIQ', itemXmlF('CD_EMPPADRAO', pParams));
    putitemXml(viParams, 'DT_LIQ', itemXml('DT_BAIXA', pParams));
    putitemXml(viParams, 'NR_SEQLIQ', vNrSeqLiq);
    voParams := activateCmp('FCCSVCO002', 'movimentaConta', viParams); (*,,vpiValores,,, *)
    if (xStatus < 0) then begin
      Result := voParams;
      return(-1); exit;
    end;
    if (gInLogMovCtaPes = True) then begin
      vNrCtaPesFCC := itemXmlF('NR_CTAPES', voParams);
      vDtMovimFCC := itemXml('DT_MOVIM', voParams);
      vNrSeqMovFCC := itemXmlF('NR_SEQMOV', voParams);

      viParams := '';
      putitemXml(viParams, 'NR_CTAPES', itemXmlF('NR_CTACREDITO', pParams));
      putitemXml(viParams, 'DT_SALDO', itemXml('DT_SISTEMA', PARAM_GLB));
      voParams := activateCmp('FCCSVCO002', 'buscaSaldoConta', viParams); (*,,'',,, *)
      if (xStatus < 0) then begin
        Result := voParams;
        return(-1); exit;
      end;
      vVlSaldoAtual := itemXmlF('VL_SALDO', voParams);

      viParams := '';
      putitemXml(viParams, 'NR_CTAPES', itemXmlF('NR_CTACREDITO', pParams));
      putitemXml(viParams, 'TP_DOCUMENTO', 3);
      putitemXml(viParams, 'NR_SEQHISTRELSUB', 1);
      putitemXml(viParams, 'DT_SALDO', itemXml('DT_SISTEMA', PARAM_GLB));
      voParams := activateCmp('FCCSVCO002', 'buscaSaldoCtaTp', viParams); (*,,'',,, *)
      if (xStatus < 0) then begin
        Result := voParams;
        return(-1); exit;
      end;
      vVlSaldoAtualDoc := itemXmlF('VL_SALDO', voParams);

      viParams := '';
      putitemXml(viParams, 'TP_PROCESSO', vTpProcesso);
      putitemXml(viParams, 'TP_DOCUMENTO', 3);
      putitemXml(viParams, 'NR_CTAPES', itemXmlF('NR_CTACREDITO', pParams));
      putitemXml(viParams, 'VL_LANCAMENTO', itemXmlF('VL_DINHEIRO', pParams));
      putitemXml(viParams, 'VL_SALDODOC', vVlSaldoAtualDoc);
      putitemXml(viParams, 'VL_SALDOCTA', vVlSaldoAtual);
      putitemXml(viParams, 'VL_SALDOANTDOC', vVlSaldoAntDoc);
      putitemXml(viParams, 'VL_SALDOANTCTA', vVlSaldoAnt);
      putitemXml(viParams, 'NR_CTAPESFCC', vNrCtaPesFCC);
      putitemXml(viParams, 'DT_MOVIMFCC', vDtMovimFCC);
      putitemXml(viParams, 'NR_SEQMOVFCC', vNrSeqMovFCC);
      voParams := activateCmp('FCCSVCO018', 'gravarLogMovtoCtaPes', viParams); (*,,,, *)
      if (xStatus < 0) then begin
        Result := voParams;
        return(-1); exit;
      end;
    end;

    viParams := '';
    vNrSequencia := vNrSequencia + 1;
    putitemXml(viParams, 'CD_EMPLIQ', itemXmlF('CD_EMPPADRAO', pParams));
    putitemXml(viParams, 'DT_LIQ', itemXml('DT_BAIXA', pParams));
    putitemXml(viParams, 'NR_SEQLIQ', vNrSeqLiq);

    if (vTpCobranca = 2) then begin
      putitemXml(viParams, 'TP_LIQUIDACAO', 79);

    end else if (vTpCobranca = 22) then begin
      putitemXml(viParams, 'TP_LIQUIDACAO', 106);

    end else begin

      if (itemXml('IN_DEPOSITODINHEIRO', pParams) = True) then begin
        putitemXml(viParams, 'TP_LIQUIDACAO', 112);
      end else begin

        putitemXml(viParams, 'TP_LIQUIDACAO', 7);
      end;
    end;

    putitemXml(viParams, 'NR_SEQUENCIA', vNrSequencia);
    putitemXml(viParams, 'TP_TIPOREG', 2);
    putitemXml(viParams, 'TP_DOCUMENTO', 3);
    putitemXml(viParams, 'NR_CTADEBITO', itemXmlF('NR_CTADEBITO', pParams));
    putitemXml(viParams, 'NR_CTACREDITO', itemXmlF('NR_CTACREDITO', pParams));
    putitemXml(viParams, 'VL_PAGO', itemXmlF('VL_DINHEIRO', pParams));
    putitemXml(viParams, 'IN_VALIDA', True);
    voParams := gravaLiqFaturas(viParams); (* PARAM_GLB, viParams, voParams, xCdErro, xCtxErro *)
    if (xStatus < 0) then begin
      Result := voParams;
      return(-1); exit;
    end;
  end;

  vDsFaturas := '';
  vDsFaturas := itemXml('DS_FATURAS', pParams);
  if (vDsFaturas <> '') then begin
    repeat
      getitem(vDsLinha, vDsFaturas, 1);

      if (itemXml('TP_COBRANCA', vDsLinha) <> 2)  and (itemXml('TP_COBRANCA', vDsLinha) <> 6) then begin
        vNrFat := itemXmlF('NR_FAT', vDsLinha);
        vNrParcela := itemXmlF('NR_PARCELA', vDsLinha);
        message/hint 'Lançando cheque(s) na conta depósito - nr. ' + FloatToStr(vNrFat) + ' / ' + FloatToStr(vNrParcela') + ';

        vVlaCreditar := vVlaCreditar + itemXmlF('VL_FATURA', vDsLinha);
        if (itemXml('TP_DEPOSITO', pParams) = 'I') then begin
          if (gInLogMovCtaPes = True) then begin
            viParams := '';
            putitemXml(viParams, 'NR_CTAPES', itemXmlF('NR_CTACREDITO', pParams));
            putitemXml(viParams, 'DT_SALDO', itemXml('DT_SISTEMA', PARAM_GLB));
            voParams := activateCmp('FCCSVCO002', 'buscaSaldoConta', viParams); (*,,'',,, *)
            if (xStatus < 0) then begin
              Result := voParams;
              return(-1); exit;
            end;
            vVlSaldoAnt := itemXmlF('VL_SALDO', voParams);

            viParams := '';
            putitemXml(viParams, 'NR_CTAPES', itemXmlF('NR_CTACREDITO', pParams));
            if (itemXml('TP_CXFILIAL_CXMATRIZ', pParams) = True) then begin
              putitemXml(viParams, 'TP_DOCUMENTO', 3);
            end else begin
              putitemXml(viParams, 'TP_DOCUMENTO', 2);
            end;
            putitemXml(viParams, 'NR_SEQHISTRELSUB', 1);
            putitemXml(viParams, 'DT_SALDO', itemXml('DT_SISTEMA', PARAM_GLB));
            voParams := activateCmp('FCCSVCO002', 'buscaSaldoCtaTp', viParams); (*,,'',,, *)
            if (xStatus < 0) then begin
              Result := voParams;
              return(-1); exit;
            end;
            vVlSaldoAntDoc := itemXmlF('VL_SALDO', voParams);
          end;

          viParams := '';
          putitemXml(viParams, 'CD_EMPRESA', itemXmlF('CD_EMPPADRAO', pParams));
          putitemXml(viParams, 'NR_CTAPES', itemXmlF('NR_CTACREDITO', pParams));
          putitemXml(viParams, 'DT_MOVIMENTO', itemXml('DT_BAIXA', pParams));
          if (itemXml('TP_CXFILIAL_CXMATRIZ', pParams) = True) then begin
            putitemXml(viParams, 'TP_DOCUMENTO', 3);
            putitemXml(viParams, 'DS_AUX', '' + CD_GRUPOEMPRESA + '.GER_GRUPOEMPR ' + NM_GRUPOEMPRESA + '.GER_GRUPOEMPR');
          end else begin
            putitemXml(viParams, 'TP_DOCUMENTO', 2);
            putitemXml(viParams, 'DS_AUX', '' + CD_GRUPOEMPRESA + '.GER_GRUPOEMPR ' + NM_GRUPOEMPRESA + '.GER_GRUPOEMPR');

          end;
          putitemXml(viParams, 'NR_SEQHISTRELSUB', 1);

          if (vTpDocumento = 1) then begin
            putitemXml(viParams, 'CD_HISTORICO', 978);
          end else begin
            putitemXml(viParams, 'CD_HISTORICO', 917);
          end;

          putitemXml(viParams, 'VL_LANCTO', itemXmlF('VL_FATURA', vDsLinha));
          putitemXml(viParams, 'IN_ESTORNO', 'N');
          putitemXml(viParams, 'CD_EMPLIQ', itemXmlF('CD_EMPPADRAO', pParams));
          putitemXml(viParams, 'DT_LIQ', itemXml('DT_BAIXA', pParams));
          putitemXml(viParams, 'NR_SEQLIQ', vNrSeqLiq);
          voParams := activateCmp('FCCSVCO002', 'movimentaConta', viParams); (*,,vpiValores,,, *)
          if (xStatus < 0) then begin
            Result := voParams;
            return(-1); exit;
          end;
          if (gInLogMovCtaPes = True) then begin
            vNrCtaPesFCC := itemXmlF('NR_CTAPES', voParams);
            vDtMovimFCC := itemXml('DT_MOVIM', voParams);
            vNrSeqMovFCC := itemXmlF('NR_SEQMOV', voParams);

            viParams := '';
            putitemXml(viParams, 'NR_CTAPES', itemXmlF('NR_CTACREDITO', pParams));
            putitemXml(viParams, 'DT_SALDO', itemXml('DT_SISTEMA', PARAM_GLB));
            voParams := activateCmp('FCCSVCO002', 'buscaSaldoConta', viParams); (*,,'',,, *)
            if (xStatus < 0) then begin
              Result := voParams;
              return(-1); exit;
            end;
            vVlSaldoAtual := itemXmlF('VL_SALDO', voParams);

            viParams := '';
            putitemXml(viParams, 'NR_CTAPES', itemXmlF('NR_CTACREDITO', pParams));
            if (itemXml('TP_CXFILIAL_CXMATRIZ', pParams) = True) then begin
              putitemXml(viParams, 'TP_DOCUMENTO', 3);
            end else begin
              putitemXml(viParams, 'TP_DOCUMENTO', 2);
            end;
            putitemXml(viParams, 'NR_SEQHISTRELSUB', 1);
            putitemXml(viParams, 'DT_SALDO', itemXml('DT_SISTEMA', PARAM_GLB));
            voParams := activateCmp('FCCSVCO002', 'buscaSaldoCtaTp', viParams); (*,,'',,, *)
            if (xStatus < 0) then begin
              Result := voParams;
              return(-1); exit;
            end;
            vVlSaldoAtualDoc := itemXmlF('VL_SALDO', voParams);

            viParams := '';
            putitemXml(viParams, 'TP_PROCESSO', vTpProcesso);
            if (itemXml('TP_CXFILIAL_CXMATRIZ', pParams) = True) then begin
              putitemXml(viParams, 'TP_DOCUMENTO', 3);
            end else begin
              putitemXml(viParams, 'TP_DOCUMENTO', 2);
            end;
            putitemXml(viParams, 'NR_CTAPES', itemXmlF('NR_CTACREDITO', pParams));
            putitemXml(viParams, 'VL_LANCAMENTO', itemXmlF('VL_FATURA', vDsLinha));
            putitemXml(viParams, 'VL_SALDODOC', vVlSaldoAtualDoc);
            putitemXml(viParams, 'VL_SALDOCTA', vVlSaldoAtual);
            putitemXml(viParams, 'VL_SALDOANTDOC', vVlSaldoAntDoc);
            putitemXml(viParams, 'VL_SALDOANTCTA', vVlSaldoAnt);
            putitemXml(viParams, 'NR_CTAPESFCC', vNrCtaPesFCC);
            putitemXml(viParams, 'DT_MOVIMFCC', vDtMovimFCC);
            putitemXml(viParams, 'NR_SEQMOVFCC', vNrSeqMovFCC);
            voParams := activateCmp('FCCSVCO018', 'gravarLogMovtoCtaPes', viParams); (*,,,, *)
            if (xStatus < 0) then begin
              Result := voParams;
              return(-1); exit;
            end;
          end;
        end;
      end;

      delitem(vDsFaturas, 1);
    until(vDsFaturas = '');

    if (itemXml('TP_DEPOSITO', pParams) = 'A')  and (vVlaCreditar > 0) then begin
      if (gInLogMovCtaPes = True) then begin
        viParams := '';
        putitemXml(viParams, 'NR_CTAPES', itemXmlF('NR_CTACREDITO', pParams));
        putitemXml(viParams, 'DT_SALDO', itemXml('DT_SISTEMA', PARAM_GLB));
        voParams := activateCmp('FCCSVCO002', 'buscaSaldoConta', viParams); (*,,'',,, *)
        if (xStatus < 0) then begin
          Result := voParams;
          return(-1); exit;
        end;
        vVlSaldoAnt := itemXmlF('VL_SALDO', voParams);

        viParams := '';
        putitemXml(viParams, 'NR_CTAPES', itemXmlF('NR_CTACREDITO', pParams));
        if (itemXml('TP_CXFILIAL_CXMATRIZ', pParams) = True) then begin
          putitemXml(viParams, 'TP_DOCUMENTO', 3);
        end else begin
          putitemXml(viParams, 'TP_DOCUMENTO', 2);
        end;
        putitemXml(viParams, 'NR_SEQHISTRELSUB', 1);
        putitemXml(viParams, 'DT_SALDO', itemXml('DT_SISTEMA', PARAM_GLB));
        voParams := activateCmp('FCCSVCO002', 'buscaSaldoCtaTp', viParams); (*,,'',,, *)
        if (xStatus < 0) then begin
          Result := voParams;
          return(-1); exit;
        end;
        vVlSaldoAntDoc := itemXmlF('VL_SALDO', voParams);
      end;

      viParams := '';
      putitemXml(viParams, 'CD_EMPRESA', itemXmlF('CD_EMPPADRAO', pParams));
      putitemXml(viParams, 'NR_CTAPES', itemXmlF('NR_CTACREDITO', pParams));
      if (itemXml('TP_CXFILIAL_CXMATRIZ', pParams) = True) then begin
        putitemXml(viParams, 'TP_DOCUMENTO', 3);
        putitemXml(viParams, 'DS_AUX', '' + CD_GRUPOEMPRESA + '.GER_GRUPOEMPR ' + NM_GRUPOEMPRESA + '.GER_GRUPOEMPR');

      end else begin
        putitemXml(viParams, 'TP_DOCUMENTO', 2);
        putitemXml(viParams, 'DS_AUX', '' + CD_GRUPOEMPRESA + '.GER_GRUPOEMPR ' + NM_GRUPOEMPRESA + '.GER_GRUPOEMPR');

      end;
      putitemXml(viParams, 'NR_SEQHISTRELSUB', 1);
      putitemXml(viParams, 'DT_MOVIMENTO', itemXml('DT_BAIXA', pParams));

      if (vTpDocumento = 1) then begin
        putitemXml(viParams, 'CD_HISTORICO', 978);
      end else begin
        putitemXml(viParams, 'CD_HISTORICO', 917);
      end;

      putitemXml(viParams, 'VL_LANCTO', vVlaCreditar);
      putitemXml(viParams, 'IN_ESTORNO', 'N');
      putitemXml(viParams, 'DS_AUX', '' + CD_GRUPOEMPRESA + '.GER_GRUPOEMPR ' + NM_GRUPOEMPRESA + '.GER_GRUPOEMPR');
      putitemXml(viParams, 'CD_EMPLIQ', itemXmlF('CD_EMPPADRAO', pParams));
      putitemXml(viParams, 'DT_LIQ', itemXml('DT_BAIXA', pParams));
      putitemXml(viParams, 'NR_SEQLIQ', vNrSeqLiq);
      voParams := activateCmp('FCCSVCO002', 'movimentaConta', viParams); (*,,vpiValores,,, *)
      if (xStatus < 0) then begin
        Result := voParams;
        return(-1); exit;
      end;
      if (gInLogMovCtaPes = True) then begin
        vNrCtaPesFCC := itemXmlF('NR_CTAPES', voParams);
        vDtMovimFCC := itemXml('DT_MOVIM', voParams);
        vNrSeqMovFCC := itemXmlF('NR_SEQMOV', voParams);

        viParams := '';
        putitemXml(viParams, 'NR_CTAPES', itemXmlF('NR_CTACREDITO', pParams));
        putitemXml(viParams, 'DT_SALDO', itemXml('DT_SISTEMA', PARAM_GLB));
        voParams := activateCmp('FCCSVCO002', 'buscaSaldoConta', viParams); (*,,'',,, *)
        if (xStatus < 0) then begin
          Result := voParams;
          return(-1); exit;
        end;
        vVlSaldoAtual := itemXmlF('VL_SALDO', voParams);

        viParams := '';
        putitemXml(viParams, 'NR_CTAPES', itemXmlF('NR_CTACREDITO', pParams));
        if (itemXml('TP_CXFILIAL_CXMATRIZ', pParams) = True) then begin
          putitemXml(viParams, 'TP_DOCUMENTO', 3);
        end else begin
          putitemXml(viParams, 'TP_DOCUMENTO', 2);
        end;
        putitemXml(viParams, 'NR_SEQHISTRELSUB', 1);
        putitemXml(viParams, 'DT_SALDO', itemXml('DT_SISTEMA', PARAM_GLB));
        voParams := activateCmp('FCCSVCO002', 'buscaSaldoCtaTp', viParams); (*,,'',,, *)
        if (xStatus < 0) then begin
          Result := voParams;
          return(-1); exit;
        end;
        vVlSaldoAtualDoc := itemXmlF('VL_SALDO', voParams);

        viParams := '';
        putitemXml(viParams, 'TP_PROCESSO', vTpProcesso);
        if (itemXml('TP_CXFILIAL_CXMATRIZ', pParams) = True) then begin
          putitemXml(viParams, 'TP_DOCUMENTO', 3);
        end else begin
          putitemXml(viParams, 'TP_DOCUMENTO', 2);
        end;
        putitemXml(viParams, 'NR_CTAPES', itemXmlF('NR_CTACREDITO', pParams));
        putitemXml(viParams, 'VL_LANCAMENTO', vVlaCreditar);
        putitemXml(viParams, 'VL_SALDODOC', vVlSaldoAtualDoc);
        putitemXml(viParams, 'VL_SALDOCTA', vVlSaldoAtual);
        putitemXml(viParams, 'VL_SALDOANTDOC', vVlSaldoAntDoc);
        putitemXml(viParams, 'VL_SALDOANTCTA', vVlSaldoAnt);
        putitemXml(viParams, 'NR_CTAPESFCC', vNrCtaPesFCC);
        putitemXml(viParams, 'DT_MOVIMFCC', vDtMovimFCC);
        putitemXml(viParams, 'NR_SEQMOVFCC', vNrSeqMovFCC);
        voParams := activateCmp('FCCSVCO018', 'gravarLogMovtoCtaPes', viParams); (*,,,, *)
        if (xStatus < 0) then begin
          Result := voParams;
          return(-1); exit;
        end;
      end;
    end;
    if (vInUtilizaCxFilial = True)  and (vVlaCreditar > 0) then begin
      if (gInLogMovCtaPes = True) then begin
        viParams := '';
        putitemXml(viParams, 'NR_CTAPES', itemXmlF('NR_CTADEBITO', pParams));
        putitemXml(viParams, 'DT_SALDO', itemXml('DT_SISTEMA', PARAM_GLB));
        voParams := activateCmp('FCCSVCO002', 'buscaSaldoConta', viParams); (*,,'',,, *)
        if (xStatus < 0) then begin
          Result := voParams;
          return(-1); exit;
        end;
        vVlSaldoAnt := itemXmlF('VL_SALDO', voParams);

        viParams := '';
        putitemXml(viParams, 'NR_CTAPES', itemXmlF('NR_CTADEBITO', pParams));
        putitemXml(viParams, 'TP_DOCUMENTO', 3);
        putitemXml(viParams, 'NR_SEQHISTRELSUB', 1);
        putitemXml(viParams, 'DT_SALDO', itemXml('DT_SISTEMA', PARAM_GLB));
        voParams := activateCmp('FCCSVCO002', 'buscaSaldoCtaTp', viParams); (*,,'',,, *)
        if (xStatus < 0) then begin
          Result := voParams;
          return(-1); exit;
        end;
        vVlSaldoAntDoc := itemXmlF('VL_SALDO', voParams);
      end;

      viParams := '';
      putitemXml(viParams, 'CD_EMPRESA', itemXmlF('CD_EMPPADRAO', pParams));
      putitemXml(viParams, 'NR_CTAPES', itemXmlF('NR_CTADEBITO', pParams));
      putitemXml(viParams, 'TP_DOCUMENTO', 2);
      putitemXml(viParams, 'NR_SEQHISTRELSUB', 1);
      putitemXml(viParams, 'DT_MOVIMENTO', itemXml('DT_BAIXA', pParams));
      putitemXml(viParams, 'CD_HISTORICO', 919);
      putitemXml(viParams, 'VL_LANCTO', vVlaCreditar);
      putitemXml(viParams, 'IN_ESTORNO', 'N');

      if (vDsAux <> '') then begin
        putitemXml(viParams, 'DS_AUX', '' + CD_GRUPOEMPRESA + '.GER_GRUPOEMPR ' + NM_GRUPOEMPRESA + '.GER_GRUPOEMPR ' + vDsAux') + ';
      end else begin
        putitemXml(viParams, 'DS_AUX', '' + CD_GRUPOEMPRESA + '.GER_GRUPOEMPR ' + NM_GRUPOEMPRESA + '.GER_GRUPOEMPR');
      end;

      putitemXml(viParams, 'CD_EMPLIQ', itemXmlF('CD_EMPPADRAO', pParams));
      putitemXml(viParams, 'DT_LIQ', itemXml('DT_BAIXA', pParams));
      putitemXml(viParams, 'NR_SEQLIQ', vNrSeqLiq);
      voParams := activateCmp('FCCSVCO002', 'movimentaConta', viParams); (*,,vpiValores,,, *)
      if (xStatus < 0) then begin
        Result := voParams;
        return(-1); exit;
      end;
      if (gInLogMovCtaPes = True) then begin
        vNrCtaPesFCC := itemXmlF('NR_CTAPES', voParams);
        vDtMovimFCC := itemXml('DT_MOVIM', voParams);
        vNrSeqMovFCC := itemXmlF('NR_SEQMOV', voParams);

        viParams := '';
        putitemXml(viParams, 'NR_CTAPES', itemXmlF('NR_CTADEBITO', pParams));
        putitemXml(viParams, 'DT_SALDO', itemXml('DT_SISTEMA', PARAM_GLB));
        voParams := activateCmp('FCCSVCO002', 'buscaSaldoConta', viParams); (*,,'',,, *)
        if (xStatus < 0) then begin
          Result := voParams;
          return(-1); exit;
        end;
        vVlSaldoAtual := itemXmlF('VL_SALDO', voParams);

        viParams := '';
        putitemXml(viParams, 'NR_CTAPES', itemXmlF('NR_CTADEBITO', pParams));
        putitemXml(viParams, 'TP_DOCUMENTO', 2);
        putitemXml(viParams, 'NR_SEQHISTRELSUB', 1);
        putitemXml(viParams, 'DT_SALDO', itemXml('DT_SISTEMA', PARAM_GLB));
        voParams := activateCmp('FCCSVCO002', 'buscaSaldoCtaTp', viParams); (*,,'',,, *)
        if (xStatus < 0) then begin
          Result := voParams;
          return(-1); exit;
        end;
        vVlSaldoAtualDoc := itemXmlF('VL_SALDO', voParams);

        viParams := '';
        putitemXml(viParams, 'TP_PROCESSO', vTpProcesso);
        putitemXml(viParams, 'TP_DOCUMENTO', 2);
        putitemXml(viParams, 'NR_CTAPES', itemXmlF('NR_CTADEBITO', pParams));
        putitemXml(viParams, 'VL_LANCAMENTO', vVlaCreditar);
        putitemXml(viParams, 'VL_SALDODOC', vVlSaldoAtualDoc);
        putitemXml(viParams, 'VL_SALDOCTA', vVlSaldoAtual);
        putitemXml(viParams, 'VL_SALDOANTDOC', vVlSaldoAntDoc);
        putitemXml(viParams, 'VL_SALDOANTCTA', vVlSaldoAnt);
        putitemXml(viParams, 'NR_CTAPESFCC', vNrCtaPesFCC);
        putitemXml(viParams, 'DT_MOVIMFCC', vDtMovimFCC);
        putitemXml(viParams, 'NR_SEQMOVFCC', vNrSeqMovFCC);
        voParams := activateCmp('FCCSVCO018', 'gravarLogMovtoCtaPes', viParams); (*,,,, *)
        if (xStatus < 0) then begin
          Result := voParams;
          return(-1); exit;
        end;
      end;
    end;
  end;

  Result := '';
  putitemXml(Result, 'CD_EMPLIQ', itemXmlF('CD_EMPPADRAO', pParams));
  putitemXml(Result, 'DT_LIQ', itemXml('DT_BAIXA', pParams));
  putitemXml(Result, 'NR_SEQLIQ', vNrSeqLiq);

  return(0); exit;
end;

//--------------------------------------------------------------------------
function T_FCRSVCO007.estornarLancamentosendosso(pParams : String) : String;
//--------------------------------------------------------------------------
const
  cDS_METHOD = 'ADICIONAL=Operação: T_FCRSVCO007.estornarLancamentosendosso()';
var
  viParams, voParams, vpiValores : String;
  vTpendosso : Real;
begin
  if (itemXml('CD_EMPendOSSO', pParams) = '') then begin
    Result := SetStatus(STS_ERROR, 'GEN001', 'Empresa do endosso não informada!', '');
    return(-1); exit;
  end;
  if (itemXml('NR_ANO', pParams) = '') then begin
    Result := SetStatus(STS_ERROR, 'GEN001', 'Ano do endosso não informado!', '');
    return(-1); exit;
  end;
  if (itemXml('NR_endOSSO', pParams) = '') then begin
    Result := SetStatus(STS_ERROR, 'GEN001', 'Número do endosso não informado!', '');
    return(-1); exit;
  end;
  if (itemXml('NR_SEQFOR', pParams) = '') then begin
    Result := SetStatus(STS_ERROR, 'GEN001', 'Fornecedor do endosso não informado!', '');
    return(-1); exit;
  end;
  if (itemXml('TP_endOSSO', pParams) = '') then begin
    Result := SetStatus(STS_ERROR, 'GEN001', 'Tipo do endosso não informado.', '');
    return(-1); exit;
  end;
  vTpendosso := itemXmlF('TP_endOSSO', pParams);

  clear_e(tGER_GRUPOEMPR);
  putitem_e(tGER_GRUPOEMPR, 'CD_GRUPOEMPRESA', itemXmlF('CD_GRUPOEMPRESA', PARAM_GLB));
  retrieve_e(tGER_GRUPOEMPR);

  clear_e(tF_FGR_LIQCP);
  putitem_e(tF_FGR_LIQCP, 'CD_EMPENDOSSO', itemXmlF('CD_EMPendOSSO', pParams));
  putitem_e(tF_FGR_LIQCP, 'NR_ANO', itemXmlF('NR_ANO', pParams));
  putitem_e(tF_FGR_LIQCP, 'NR_ENDOSSO', itemXmlF('NR_endOSSO', pParams));
  if (vTpendosso = 2)  or (vTpendosso = 4) then begin
    putitem_e(tF_FGR_LIQCP, 'NR_SEQFOR', itemXmlF('NR_SEQFOR', pParams));
  end;
  retrieve_e(tF_FGR_LIQCP);
  if (xStatus < 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN001', 'Não há movimentação para este endosso!', '');
    return(-1); exit;
  end;

  setocc(tF_FGR_LIQCP, 1);
  repeat

    message/hint 'Estornando lançamento do endosso: ' + nr_endosso + '.F_FGR_LIQCP / ' + nr_seqfor + '.F_FGR_LIQCP';
    viParams := '';
    if (item_f('TP_LIQITEMCP', tF_FGR_LIQCP) = 1) then begin
      putitemXml(viParams, 'CD_EMPRESA', item_f('CD_EMPENDOSSO', tF_FGR_LIQCP));
      putitemXml(viParams, 'NR_CTAPES', item_f('NR_CTAPES', tF_FGR_LIQCP));
      putitemXml(viParams, 'DT_MOVIMENTO', itemXml('DT_SISTEMA', PARAM_GLB));
      putitemXml(viParams, 'TP_DOCUMENTO', 3);
      putitemXml(viParams, 'NR_SEQHISTRELSUB', 1);
      putitemXml(viParams, 'CD_HISTORICO', 905);
      putitemXml(viParams, 'VL_LANCTO', item_f('VL_PAGO', tF_FGR_LIQCP));
      putitemXml(viParams, 'IN_ESTORNO', 'N');
      putitemXml(viParams, 'DS_AUX', '' + CD_GRUPOEMPRESA + '.GER_GRUPOEMPR ' + NM_GRUPOEMPRESA + '.GER_GRUPOEMPR');
    end;
    if (item_f('TP_LIQITEMCP', tF_FGR_LIQCP) = 4) then begin
      putitemXml(viParams, 'CD_EMPRESA', item_f('CD_EMPENDOSSO', tF_FGR_LIQCP));
      putitemXml(viParams, 'NR_CTAPES', item_f('NR_CTAPES', tF_FGR_LIQCP));
      putitemXml(viParams, 'DT_MOVIMENTO', itemXml('DT_SISTEMA', PARAM_GLB));
      putitemXml(viParams, 'TP_DOCUMENTO', 10);
      putitemXml(viParams, 'NR_SEQHISTRELSUB', 1);
      putitemXml(viParams, 'CD_HISTORICO', 906);
      putitemXml(viParams, 'VL_LANCTO', item_f('VL_PAGO', tF_FGR_LIQCP));
      putitemXml(viParams, 'IN_ESTORNO', 'N');
      putitemXml(viParams, 'DS_AUX', '' + CD_GRUPOEMPRESA + '.GER_GRUPOEMPR ' + NM_GRUPOEMPRESA + '.GER_GRUPOEMPR');
    end;
    if (item_f('TP_LIQITEMCP', tF_FGR_LIQCP) = 5) then begin
      putitemXml(viParams, 'CD_EMPRESA', item_f('CD_EMPENDOSSO', tF_FGR_LIQCP));
      putitemXml(viParams, 'NR_CTAPES', item_f('NR_CTAPES', tF_FGR_LIQCP));
      putitemXml(viParams, 'DT_MOVIMENTO', itemXml('DT_SISTEMA', PARAM_GLB));
      putitemXml(viParams, 'TP_DOCUMENTO', 10);
      putitemXml(viParams, 'NR_SEQHISTRELSUB', 1);
      putitemXml(viParams, 'CD_HISTORICO', 907);
      putitemXml(viParams, 'VL_LANCTO', item_f('VL_PAGO', tF_FGR_LIQCP));
      putitemXml(viParams, 'IN_ESTORNO', 'N');
      putitemXml(viParams, 'DS_AUX', '' + CD_GRUPOEMPRESA + '.GER_GRUPOEMPR ' + NM_GRUPOEMPRESA + '.GER_GRUPOEMPR');
    end;
    if (viParams <> '') then begin
      voParams := activateCmp('FCCSVCO002', 'movimentaConta', viParams); (*,,vpiValores,,, *)
      if (xStatus < 0) then begin
        Result := voParams;
        return(-1); exit;
      end;
    end;
    if (item_f('TP_LIQITEMCP', tF_FGR_LIQCP) = 2) then begin
      viParams := '';
      putitemXml(viParams, 'DT_AUTORIZACAO', item_a('DT_AUTORIZACAO', tF_FGR_LIQCP));
      putitemXml(viParams, 'NR_SEQAUTO', item_f('NR_SEQAUTO', tF_FGR_LIQCP));
      putitemXml(viParams, 'NR_SEQCHEQUE', item_f('NR_SEQCHEQUE', tF_FGR_LIQCP));
      voParams := activateCmp('FCCSVCO008', 'cancelarAutorizacao', viParams); (*,,,, *)
      if (xStatus < 0) then begin
        Result := voParams;
        return(-1); exit;
      end;
    end;

    setocc(tF_FGR_LIQCP, curocc(tF_FGR_LIQCP) + 1);
  until(xStatus < 0);
  xStatus := 0;
  message/hint '';

  clear_e(tF_FGR_LIQ);
  putitem_e(tF_FGR_LIQ, 'CD_EMPLIQ', item_f('CD_EMPLIQ', tF_FGR_LIQCP));
  putitem_e(tF_FGR_LIQ, 'DT_LIQ', item_a('DT_LIQ', tF_FGR_LIQCP));
  putitem_e(tF_FGR_LIQ, 'NR_SEQLIQ', item_f('NR_SEQLIQ', tF_FGR_LIQCP));
  retrieve_e(tF_FGR_LIQ);
  if (xStatus < 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN001', 'Cabeça da liquidação do endosso não encontrada!', '');
    return(-1); exit;
  end;
  putitem_e(tF_FGR_LIQ, 'DT_CANCELAMENTO', itemXml('DT_SISTEMA', PARAM_GLB));
  putitem_e(tF_FGR_LIQ, 'CD_OPERCANCEL', itemXmlF('CD_USUARIO', PARAM_GLB));

  voParams := tF_FGR_LIQ.Salvar();
  if (xStatus < 0) then begin
    Result := voParams;
    return(-1); exit;
  end;

  return(0); exit;
end;

//---------------------------------------------------------------------
function T_FCRSVCO007.calculaJurosDescontos(pParams : String) : String;
//---------------------------------------------------------------------
const
  cDS_METHOD = 'ADICIONAL=Operação: T_FCRSVCO007.calculaJurosDescontos()';
var
  viParams, voParams : String;
begin
  putitemXml(viParams, 'IN_SABADOUTIL', gInsabadoutil);
  putitemXml(viParams, 'NR_DIASCARENCIAATRASO', gNrdiascarenciaatraso);
  putitemXml(viParams, 'NR_DIASCARENCIAMULTA', gNrdiascarenciamulta);
  putitemXml(viParams, 'NR_DIASDESCPONT', gNrdiasdescpont);
  putitemXml(viParams, 'TP_APLICACAOJUROS', gTpaplicacaojuros);
  putitemXml(viParams, 'DT_VENCIMENTO', item_a('DT_VENCIMENTO', tFCR_FATURAI));
  putitemXml(viParams, 'DT_PAGAMENTO', gDtpagamento);
  putitemXml(viParams, 'VL_FATURA', itemXmlF('VL_APAGAR', pParams));
  putitemXml(viParams, 'VL_ACRESCIMO', item_f('VL_ACRESCIMO', tFCR_FATURAI));
  putitemXml(viParams, 'VL_ABATIMENTO', item_f('VL_ABATIMENTO', tFCR_FATURAI));
  putitemXml(viParams, 'VL_OUTACRES', item_f('VL_OUTACRES', tFCR_FATURAI));
  putitemXml(viParams, 'VL_OUTDESC', item_f('VL_OUTDESC', tFCR_FATURAI));
  putitemXml(viParams, 'VL_DESPFIN', item_f('VL_DESPFIN', tFCR_FATURAI));
  putitemXml(viParams, 'PR_JUROMES', item_f('PR_JUROMES', tFCR_FATURAI));
  putitemXml(viParams, 'PR_MULTA', item_f('PR_MULTA', tFCR_FATURAI));
  putitemXml(viParams, 'PR_DESCPGPRAZO', item_f('PR_DESCPGPRAZO', tFCR_FATURAI));
  putitemXml(viParams, 'PR_DESCANTECIP1', item_f('PR_DESCANTECIP1', tFCR_FATURAI));
  putitemXml(viParams, 'PR_DESCANTECIP2', item_f('PR_DESCANTECIP2', tFCR_FATURAI));
  putitemXml(viParams, 'DT_DESCANTECIP1', item_a('DT_DESCANTECIP1', tFCR_FATURAI));
  putitemXml(viParams, 'DT_DESCANTECIP2', item_a('DT_DESCANTECIP2', tFCR_FATURAI));

  voParams := activateCmp('FCRSVCO002', 'CalcVlFat', viParams); (*,,,, *)
  if (xStatus < 0) then begin
    Result := voParams;
    return(-1); exit;
  end;

  Result := '';
  putitemXml(Result, 'VL_ACRESCIMO', itemXmlF('VL_ACRESCIMO', voParams));
  putitemXml(Result, 'VL_ABATIMENTO', itemXmlF('VL_DEDUCAO', voParams));
  putitemXml(Result, 'VL_JUROS', itemXmlF('VL_JUROS', voParams));

  return(0); exit;
end;

//---------------------------------------------------------------
function T_FCRSVCO007.baixarFatCartao(pParams : String) : String;
//---------------------------------------------------------------
const
  cDS_METHOD = 'ADICIONAL=Operação: T_FCRSVCO007.baixarFatCartao()';
var
  viParams, voParams : String;
  vVlOriginal, vVlFatura, vVlPago : Real;
  vDtLiq : TDate;
begin
  vVlOriginal := itemXmlF('VL_ORIGINAL', pParams);
  vVlFatura := itemXmlF('VL_FATURA', pParams);
  vVlPago := itemXmlF('VL_PAGO', pParams);
  if (itemXml('CD_EMPRESA', pParams) = '') then begin
    Result := SetStatus(STS_AVISO, 'GEN001', 'Código de empresa não informada', '');
    return(-1); exit;
  end;
  if (itemXml('CD_CLIENTE', pParams) = '') then begin
    Result := SetStatus(STS_AVISO, 'GEN001', 'Código de cliente não informado', '');
    return(-1); exit;
  end;
  if (itemXml('NR_FAT', pParams) = '') then begin
    Result := SetStatus(STS_AVISO, 'GEN001', 'Número da fatura nco informado', '');
    return(-1); exit;
  end;
  if (itemXml('NR_PARCELA', pParams) = '') then begin
    Result := SetStatus(STS_AVISO, 'GEN001', 'Número da parcela da fatura não informado', '');
    return(-1); exit;
  end;
  if (itemXml('VL_PAGO', pParams) = '') then begin
    Result := SetStatus(STS_AVISO, 'GEN001', 'Valor da fatura não informado', '');
    return(-1); exit;
  end;

  clear_e(tFCR_FATURAI);
  creocc(tFCR_FATURAI, -1);
  putitem_e(tFCR_FATURAI, 'CD_EMPRESA', itemXmlF('CD_EMPRESA', pParams));
  putitem_e(tFCR_FATURAI, 'CD_CLIENTE', itemXmlF('CD_CLIENTE', pParams));
  putitem_e(tFCR_FATURAI, 'NR_FAT', itemXmlF('NR_FAT', pParams));
  putitem_e(tFCR_FATURAI, 'NR_PARCELA', itemXmlF('NR_PARCELA', pParams));
  retrieve_o(tFCR_FATURAI);
  if (xStatus = -7)  or (xStatus = 4) then begin
    retrieve_x(tFCR_FATURAI);

    putitem_e(tFCR_FATURAI, 'VL_LIQUIDO', itemXmlF('VL_LIQUIDO', pParams));
    putitem_e(tFCR_FATURAI, 'VL_DESCONTO', itemXmlF('VL_DESCONTO', pParams));
    putitem_e(tFCR_FATURAI, 'VL_JUROS', itemXmlF('VL_JUROS', pParams));
    putitem_e(tFCR_FATURAI, 'TP_BAIXA', 1);
    putitem_e(tFCR_FATURAI, 'CD_OPERBAIXA', itemXmlF('CD_USUARIO', PARAM_GLB));
    putitem_e(tFCR_FATURAI, 'VL_PAGO', itemXmlF('VL_PAGO', pParams));
    putitem_e(tFCR_FATURAI, 'CD_EMPLIQ', itemXmlF('CD_EMPLIQ', pParams));

    if (item_a('DT_LIQ', tFCR_FATURAI) <> '') then begin
      Result := SetStatus(STS_ERROR, 'GEN001', 'Fatura já liquidada por outro processo ou manutenção.Empresa: ' + cd_empresa + '.FCR_FATURAI Cliente: ' + cd_cliente + '.FCR_FATURAI Fatura: ' + nr_fat + '.FCR_FATURAI Parcela: ' + nr_parcela + '.FCR_FATURAI', '');
      return(-1); exit;
    end;
    if (itemXml('DT_BAIXA', pParams) <> '') then begin
      putitem_e(tFCR_FATURAI, 'DT_BAIXA', Now);
    end;
    if (itemXml('TP_BAIXA', pParams) <> '') then begin
      putitem_e(tFCR_FATURAI, 'TP_BAIXA', itemXmlF('TP_BAIXA', pParams));
    end;

    putitem_e(tFCR_FATURAI, 'DT_LIQ', itemXml('DT_LIQ', pParams));
    putitem_e(tFCR_FATURAI, 'NR_SEQLIQ', itemXmlF('NR_SEQLIQ', pParams));
    putitem_e(tFCR_FATURAI, 'CD_OPERADOR', itemXmlF('CD_USUARIO', PARAM_GLB));
    putitem_e(tFCR_FATURAI, 'DT_CADASTRO', Now);
    putitem_e(tFCR_FATURAI, 'TP_COBRANCA', 14);

    if (xStatus = -11) then begin
      Result := SetStatus(STS_ERROR, 'GEN001', 'Fatura sendo utilizada em outro processo ou manutenção.Empresa: ' + cd_empresa + '.FCR_FATURAI Cliente: ' + cd_cliente + '.FCR_FATURAI Fatura: ' + nr_fat + '.FCR_FATURAI Parcela: ' + nr_parcela + '.FCR_FATURAI', '');
      return(-1); exit;
    end;

    voParams := tFCR_FATURAI.Salvar();
    if (xStatus < 0) then begin
      Result := SetStatus(STS_ERROR, xProcerror, 'xProcerrorcontext', '');
      return(-1); exit;
    end;
  end else begin
    Result := SetStatus(STS_ERROR, 'GEN001', 'Fatura não encontrada ' + CD_EMPRESA + '.FCR_FATURAI ' + CD_CLIENTE + '.FCR_FATURAI ' + NR_FAT + '.FCR_FATURAI ' + NR_PARCELA + '.FCR_FATURAI', '');
    return(-1); exit;
  end;

  return(0); exit;
end;

//-----------------------------------------------------------
function T_FCRSVCO007.gravaLiqMov(pParams : String) : String;
//-----------------------------------------------------------
const
  cDS_METHOD = 'ADICIONAL=Operação: T_FCRSVCO007.gravaLiqMov()';
var
  vDtMovim, vDtLiq : TDate;
  vDsLstMovCc, vDsRegistro, vCdEmpLiq, vNrSeqLiq, vNrSeqItem, viParams, voParams : String;
  vNrSeqMov, vNrCtaPesMov, vVlPago : Real;
begin
  if (itemXml('CD_EMPRESA', pParams) = '') then begin
    Result := SetStatus(STS_ERROR, 'GEN001', 'Código de empresa não informada', '');
    return(-1); exit;
  end;
  if (itemXml('CD_CLIENTE', pParams) = '') then begin
    Result := SetStatus(STS_ERROR, 'GEN001', 'Código de cliente não informado', '');
    return(-1); exit;
  end;
  if (itemXml('NR_FAT', pParams) = '') then begin
    Result := SetStatus(STS_ERROR, 'GEN001', 'Número da fatura nco informado', '');
    return(-1); exit;
  end;
  if (itemXml('NR_PARCELA', pParams) = '') then begin
    Result := SetStatus(STS_ERROR, 'GEN001', 'Número da parcela da fatura não informado', '');
    return(-1); exit;
  end;
  if (itemXml('TP_DOCUMENTO', pParams) = '') then begin
    Result := SetStatus(STS_ERROR, 'GEN001', 'Número da parcela da fatura não informado', '');
    return(-1); exit;
  end;
  if (itemXml('CD_EMPLIQ', pParams) = '') then begin
    Result := SetStatus(STS_ERROR, 'GEN001', 'Falta informar a empresa da liquidação', '');
    return(-1); exit;
  end;
  if (itemXml('DT_LIQ', pParams) = '') then begin
    Result := SetStatus(STS_ERROR, 'GEN001', 'Falta informar a data da liquidação', '');
    return(-1); exit;
  end;
  if (itemXml('NR_SEQLIQ', pParams) = '') then begin
    Result := SetStatus(STS_ERROR, 'GEN001', 'Falta informar a sequencia da liquidação', '');
    return(-1); exit;
  end;
  if (itemXml('TP_LIQUIDACAO', pParams) = '') then begin
    Result := SetStatus(STS_ERROR, 'GEN001', 'Falta informar o tipo da sequencia da liquidação', '');
    return(-1); exit;
  end;
  if (itemXml('VL_PAGO', pParams) = '') then begin
    Result := SetStatus(STS_ERROR, 'GEN001', 'Falta informar o valor a liquidação', '');
    return(-1); exit;
  end;

  vCdEmpLiq := itemXmlF('CD_EMPLIQ', pParams);
  vDtLiq := itemXml('DT_LIQ', pParams);
  vNrSeqLiq := itemXmlF('NR_SEQLIQ', pParams);
  vDsLstMovCC := itemXml('DS_LSTMOVCC', pParams);

  if (vDsLstMovCC <> '') then begin
    repeat
      getitem(vDsRegistro, vDsLstMovCC, 1);
      vNrCtaPesMov := itemXmlF('NR_CTAPES', vDsRegistro);
      vDtMovim := itemXml('DT_MOVIM', vDsRegistro);
      vNrSeqMov := itemXmlF('NR_SEQMOV', vDsRegistro);

      if (vNrCtaPesMov = 0) then begin
        Result := SetStatus(STS_ERROR, 'GEN001', 'Conta da movimentação não informada!', cDS_METHOD);
        return(-1); exit;
      end;
      if (vDtMovim = '') then begin
        Result := SetStatus(STS_ERROR, 'GEN001', 'Data da movimentação não informada!', cDS_METHOD);
        return(-1); exit;
      end;
      if (vNrSeqMov = 0) then begin
        Result := SetStatus(STS_ERROR, 'GEN001', 'Sequência da movimentação não informada!', cDS_METHOD);
        return(-1); exit;
      end;

      creocc(tFCC_MOV, -1);
      putitem_e(tFCC_MOV, 'NR_CTAPES', vNrCtaPesMov);
      putitem_e(tFCC_MOV, 'DT_MOVIM', vDtMovim);
      putitem_e(tFCC_MOV, 'NR_SEQMOV', vNrSeqMov);
      retrieve_o(tFCC_MOV);
      if (xStatus = -7) then begin
        retrieve_x(tFCC_MOV);
      end else if (xStatus = 0) then begin
        Result := SetStatus(STS_ERROR, 'GEN0001', 'Movimentação ' + NR_CTAPES + '.FCC_MOV / ' + DT_MOVIM + '.FCC_MOV / ' + NR_SEQMOV + '.FCC_MOV não cadastrada!', cDS_METHOD);
        return(-1); exit;
      end;

      delitem(vDsLstMovCC, 1);
    until (vDsLstMovCC = '');

    setocc(tFCC_MOV, 1);
  end;

  vNrSeqItem := itemXmlF('NR_SEQUENCIA', pParams);
  vVlPago := itemXmlF('VL_PAGO', pParams);
  clear_e(tFGR_LIQ);
  putitem_e(tFGR_LIQ, 'CD_EMPLIQ', itemXmlF('CD_EMPLIQ', pParams));
  putitem_e(tFGR_LIQ, 'DT_LIQ', itemXml('DT_LIQ', pParams));
  putitem_e(tFGR_LIQ, 'NR_SEQLIQ', itemXmlF('NR_SEQLIQ', pParams));
  retrieve_e(tFGR_LIQ);
  if (xStatus < 0) then begin
    creocc(tFGR_LIQ, -1);
    putitem_e(tFGR_LIQ, 'CD_EMPLIQ', itemXmlF('CD_EMPLIQ', pParams));
    putitem_e(tFGR_LIQ, 'DT_LIQ', itemXml('DT_LIQ', pParams));
    putitem_e(tFGR_LIQ, 'NR_SEQLIQ', itemXmlF('NR_SEQLIQ', pParams));
    putitem_e(tFGR_LIQ, 'TP_LIQUIDACAO', itemXmlF('TP_LIQUIDACAO', pParams));
    putitem_e(tFGR_LIQ, 'CD_GRUPOEMPRESA', itemXmlF('CD_GRUPOEMPRESA', PARAM_GLB));
    putitem_e(tFGR_LIQ, 'CD_PESSOA', itemXmlF('CD_PESSOA', pParams));
  end;

  creocc(tFGR_LIQITEMCR, -1);
  putitem_e(tFGR_LIQITEMCR, 'CD_EMPLIQ', vCdEmpLiq);
  putitem_e(tFGR_LIQITEMCR, 'DT_LIQ', vDtLiq);
  putitem_e(tFGR_LIQITEMCR, 'NR_SEQLIQ', vNrSeqLiq);
  putitem_e(tFGR_LIQITEMCR, 'NR_SEQITEM', vNrSeqItem);
  putitem_e(tFGR_LIQITEMCR, 'TP_TIPOREG', 1);
  putitem_e(tFGR_LIQITEMCR, 'CD_EMPFAT', itemXmlF('CD_EMPRESA', pParams));
  putitem_e(tFGR_LIQITEMCR, 'CD_CLIENTE', itemXmlF('CD_CLIENTE', pParams));
  putitem_e(tFGR_LIQITEMCR, 'NR_FAT', itemXmlF('NR_FAT', pParams));
  putitem_e(tFGR_LIQITEMCR, 'NR_PARCELA', itemXmlF('NR_PARCELA', pParams));
  putitem_e(tFGR_LIQITEMCR, 'TP_DOCUMENTO', itemXmlF('TP_DOCUMENTO', pParams));
  putitem_e(tFGR_LIQITEMCR, 'NR_CTAPESFCC', item_f('NR_CTAPES', tFCC_MOV));
  putitem_e(tFGR_LIQITEMCR, 'DT_MOVIMFCC', item_a('DT_MOVIM', tFCC_MOV));
  putitem_e(tFGR_LIQITEMCR, 'NR_SEQMOVFCC', item_f('NR_SEQMOV', tFCC_MOV));
  putitem_e(tFGR_LIQITEMCR, 'CD_OPERADOR', itemXmlF('CD_USUARIO', PARAM_GLB));
  putitem_e(tFGR_LIQITEMCR, 'DT_CADASTRO', Now);
  putitem_e(tFGR_LIQITEMCR, 'VL_LANCAMENTO', vVlPago);
  putitem_e(tFGR_LIQ, 'CD_OPERADOR', itemXmlF('CD_USUARIO', PARAM_GLB));
  putitem_e(tFGR_LIQ, 'DT_CADASTRO', Now);
  voParams := tFGR_LIQ.Salvar();
  if (xStatus < 0) then begin
    Result := voParams;
    return(-1); exit;
  end;

  viParams := '';
  putitemXml(viParams, 'CD_EMPLIQ', item_f('CD_EMPLIQ', tFGR_LIQ));
  putitemXml(viParams, 'DT_LIQ', item_a('DT_LIQ', tFGR_LIQ));
  putitemXml(viParams, 'NR_SEQLIQ', item_f('NR_SEQLIQ', tFGR_LIQ));
  putitemXml(viParams, 'CD_EMPRESA', itemXmlF('CD_EMPRESA', pParams));
  putitemXml(viParams, 'CD_CLIENTE', itemXmlF('CD_CLIENTE', pParams));
  putitemXml(viParams, 'NR_FAT', itemXmlF('NR_FAT', pParams));
  putitemXml(viParams, 'NR_PARCELA', itemXmlF('NR_PARCELA', pParams));
  voParams := activateCmp('FCRSVCO112', 'gravarLiqFaturaVenda', viParams); (*,,,, *)
  if (xStatus < 0) then begin
    Result := voParams;
    return(-1); exit;
  end;

  return(0); exit;
end;

//---------------------------------------------------------------
function T_FCRSVCO007.baixaReservaChq(pParams : String) : String;
//---------------------------------------------------------------
const
  cDS_METHOD = 'ADICIONAL=Operação: T_FCRSVCO007.baixaReservaChq()';
var
  vDsLinha, vDsFaturas, vCdEmpReserva, vNrReserva : String;
begin
  vDsFaturas := itemXml('DS_FATURAS', pParams);
  vCdEmpReserva := itemXmlF('CD_EMPRESERVA', pParams);
  vNrReserva := itemXmlF('NR_RESERVA', pParams);

  if (vCdEmpReserva = '') then begin
    Result := SetStatus(STS_ERROR, 'GEN001', 'Falta informar a empresa da reserva de cheque!', '');
    return(-1); exit;
  end;
  if (vNrReserva = '') then begin
    Result := SetStatus(STS_ERROR, 'GEN001', 'Falta informar o número da reserva de cheque!', '');
    return(-1); exit;
  end;
  if (vDsFaturas = '') then begin
    Result := SetStatus(STS_ERROR, 'GEN001', 'Falta informar os cheques a serem baixados!', '');
    return(-1); exit;
  end;

  clear_e(tFCR_RESERVAC);
  putitem_e(tFCR_RESERVAC, 'CD_EMPRESERVA', vCdEmpReserva);
  putitem_e(tFCR_RESERVAC, 'NR_RESERVA', vNrReserva);
  retrieve_e(tFCR_RESERVAC);
  if (xStatus < 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN001', 'Reserva de cheque para baixa não encontrada !', '');
    return(-1); exit;
  end;

  repeat
    vDsLinha := '';
    getitem(vDsLinha, vDsFaturas, 1);

    clear_e(tFCR_RESERVAI);
    putitem_e(tFCR_RESERVAI, 'CD_EMPRESERVA', vCdEmpReserva);
    putitem_e(tFCR_RESERVAI, 'NR_RESERVA', vNrReserva);
    putitem_e(tFCR_RESERVAI, 'CD_EMPFAT', itemXmlF('CD_EMPRESA', vDsLinha));
    putitem_e(tFCR_RESERVAI, 'CD_CLIENTE', itemXmlF('CD_CLIENTE', vDsLinha));
    putitem_e(tFCR_RESERVAI, 'NR_FAT', itemXmlF('NR_FAT', vDsLinha));
    putitem_e(tFCR_RESERVAI, 'NR_PARCELA', itemXmlF('NR_PARCELA', vDsLinha));
    retrieve_e(tFCR_RESERVAI);
    if (xStatus < 0) then begin
      Result := SetStatus(STS_ERROR, 'GEN001', 'Cheque selecionado para baixa não localizado na reserva informada!', '');
      return(-1); exit;
    end;

    putitem_e(tFCR_RESERVAI, 'DT_BAIXA', itemXml('DT_SISTEMA', PARAM_GLB));
    putitem_e(tFCR_RESERVAI, 'CD_OPERBAIXA', itemXmlF('CD_USUARIO', PARAM_GLB));
    putitem_e(tFCR_RESERVAI, 'TP_BAIXA', 1);
    putitem_e(tFCR_RESERVAI, 'CD_OPERADOR', itemXmlF('CD_USUARIO', PARAM_GLB));
    putitem_e(tFCR_RESERVAI, 'DT_CADASTRO', Now);

    voParams := tFCR_RESERVAI.Salvar();
    if (xStatus < 0) then begin
      Result := voParams;
      return(-1); exit;
    end;

    clear_e(tFCR_FATURAI);
    putitem_e(tFCR_FATURAI, 'CD_EMPRESA', item_f('CD_EMPFAT', tFCR_RESERVAI));
    putitem_e(tFCR_FATURAI, 'CD_CLIENTE', item_f('CD_CLIENTE', tFCR_RESERVAI));
    putitem_e(tFCR_FATURAI, 'NR_FAT', item_f('NR_FAT', tFCR_RESERVAI));
    putitem_e(tFCR_FATURAI, 'NR_PARCELA', item_f('NR_PARCELA', tFCR_RESERVAI));
    retrieve_e(tFCR_FATURAI);
    if (xStatus < 0) then begin
      Result := SetStatus(STS_ERROR, 'GEN001', 'Cheque selecionado para baixa não localizado no cadastro.Emp.: ' + cd_empfat + '.FCR_RESERVAI Cliente: ' + cd_cliente + '.FCR_RESERVAI Cheque: ' + nr_fat + '.FCR_RESERVAI Parcela: ' + nr_parcela + '.FCR_RESERVAI', '');
      return(-1); exit;
    end;

    putitem_e(tFCR_FATURAI, 'TP_COBRANCA', 0);
    putitem_e(tFCR_FATURAI, 'CD_OPERADOR', itemXmlF('CD_USUARIO', PARAM_GLB));
    putitem_e(tFCR_FATURAI, 'DT_CADASTRO', Now);

    voParams := tFCR_FATURAI.Salvar();
    if (xStatus < 0) then begin
      Result := voParams;
      return(-1); exit;
    end;

    delitem(vDsFaturas, 1);
  until(vDsFaturas = '');

  putitem_e(tFCR_RESERVAC, 'DT_BAIXA', itemXml('DT_SISTEMA', PARAM_GLB));
  putitem_e(tFCR_RESERVAC, 'CD_OPERBAIXA', itemXmlF('CD_USUARIO', PARAM_GLB));
  putitem_e(tFCR_RESERVAC, 'TP_BAIXA', 1);

  voParams := tFCR_RESERVAC.Salvar();
  if (xStatus < 0) then begin
    Result := voParams;
    return(-1); exit;
  end;

  return(0); exit;
end;

//----------------------------------------------------------------
function T_FCRSVCO007.cancelLiqFaturas(pParams : String) : String;
//----------------------------------------------------------------
const
  cDS_METHOD = 'ADICIONAL=Operação: T_FCRSVCO007.cancelLiqFaturas()';
var
  vDsLinha, vDsFaturas, viParams, voParams, vDsBanda : String;
begin
  if (itemXml('CD_EMPLIQ', pParams) = '') then begin
    Result := SetStatus(STS_ERROR, 'GEN001', 'Falta informar a empresa da liquidação', '');
    return(-1); exit;
  end;
  if (itemXml('DT_LIQ', pParams) = '') then begin
    Result := SetStatus(STS_ERROR, 'GEN001', 'Falta informar a data da liquidação', '');
    return(-1); exit;
  end;
  if (itemXml('NR_SEQLIQ', pParams) = '') then begin
    Result := SetStatus(STS_ERROR, 'GEN001', 'Falta informar a sequencia da liquidação', '');
    return(-1); exit;
  end;
  if (itemXml('DS_FATURAS', pParams) = '') then begin
    Result := SetStatus(STS_ERROR, 'GEN001', 'Falta informar as faturas a serem canceladas.', '');
    return(-1); exit;
  end else begin
    vDsFaturas := '';
    vDsFaturas := itemXml('DS_FATURAS', pParams);
  end;

  clear_e(tFGR_LIQ);
  putitem_e(tFGR_LIQ, 'CD_EMPLIQ', itemXmlF('CD_EMPLIQ', pParams));
  putitem_e(tFGR_LIQ, 'DT_LIQ', itemXml('DT_LIQ', pParams));
  putitem_e(tFGR_LIQ, 'NR_SEQLIQ', itemXmlF('NR_SEQLIQ', pParams));
  retrieve_e(tFGR_LIQ);
  if (xStatus < 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN001', 'Número de liquidação não encontrado para efetuar estornos.', '');
    return(-1); exit;
  end;

  repeat
    getitem(vDsLinha, vDsFaturas, 1);
    clear_e(tFCR_FATURAI);
    putitem_e(tFCR_FATURAI, 'CD_EMPRESA', itemXmlF('CD_EMPFAT', vDsLinha));
    putitem_e(tFCR_FATURAI, 'CD_CLIENTE', itemXmlF('CD_CLIENTE', vDsLinha));
    putitem_e(tFCR_FATURAI, 'NR_FAT', itemXmlF('NR_FAT', vDsLinha));
    putitem_e(tFCR_FATURAI, 'NR_PARCELA', itemXmlF('NR_PARCELA', vDsLinha));
    retrieve_e(tFCR_FATURAI);
    if (xStatus < 0) then begin
      Result := SetStatus(STS_ERROR, 'GEN001', 'Fatura não encontrada para cancelamento.', '');
      return(-1); exit;
    end;

    putitem_e(tFCR_FATURAI, 'TP_SITUACAO', 3);
    putitem_e(tFCR_FATURAI, 'CD_OPERCANCEL', itemXmlF('CD_USUARIO', PARAM_GLB));
    putitem_e(tFCR_FATURAI, 'CD_OPERADOR', itemXmlF('CD_USUARIO', PARAM_GLB));
    putitem_e(tFCR_FATURAI, 'DT_CANCELAMENTO', itemXml('DT_SISTEMA', PARAM_GLB));
    putitem_e(tFCR_FATURAI, 'DT_CADASTRO', Now);

    if (xStatus = -11) then begin
      Result := SetStatus(STS_ERROR, 'GEN001', 'Fatura sendo utilizada em outro processo ou manutenção.Empresa: ' + cd_empresa + '.FCR_FATURAI Cliente: ' + cd_cliente + '.FCR_FATURAI Fatura: ' + nr_fat + '.FCR_FATURAI Parcela: ' + nr_parcela + '.FCR_FATURAI', '');
      return(-1); exit;
    end;
    if (empty(tFCR_CHEQUE) = False) then begin
      vDsBanda := 'C' + ds_banda + '.FCR_CHEQUE';
      putitem_e(tFCR_CHEQUE, 'DS_BANDA', vDsBanda[1:30]);

    end;
    if (xStatus = -11) then begin
      Result := SetStatus(STS_ERROR, 'GEN001', 'Fatura sendo utilizada em outro processo ou manutenção.Empresa: ' + cd_empresa + '.FCR_FATURAI Cliente: ' + cd_cliente + '.FCR_FATURAI Fatura: ' + nr_fat + '.FCR_FATURAI Parcela: ' + nr_parcela + '.FCR_FATURAI', '');
      return(-1); exit;
    end;

    voParams := tFCR_FATURAI.Salvar();
    if (xStatus < 0) then begin
      Result := voParams;
      return(-1); exit;
    end;

    putitem_e(tFGR_LIQ, 'VL_TOTAL', item_f('VL_TOTAL', tFGR_LIQ) - item_f('VL_FATURA', tFCR_FATURAI));

    clear_e(tF_FGR_LIQITEM);
    putitem_e(tF_FGR_LIQITEM, 'CD_EMPLIQ', item_f('CD_EMPLIQ', tFGR_LIQ));
    putitem_e(tF_FGR_LIQITEM, 'DT_LIQ', item_a('DT_LIQ', tFGR_LIQ));
    putitem_e(tF_FGR_LIQITEM, 'NR_SEQLIQ', item_f('NR_SEQLIQ', tFGR_LIQ));
    putitem_e(tF_FGR_LIQITEM, 'CD_EMPFAT', item_f('CD_EMPRESA', tFCR_FATURAI));
    putitem_e(tF_FGR_LIQITEM, 'CD_CLIENTE', item_f('CD_CLIENTE', tFCR_FATURAI));
    putitem_e(tF_FGR_LIQITEM, 'NR_FAT', item_f('NR_FAT', tFCR_FATURAI));
    putitem_e(tF_FGR_LIQITEM, 'NR_PARCELA', item_f('NR_PARCELA', tFCR_FATURAI));
    retrieve_e(tF_FGR_LIQITEM);
    if (xStatus < 0) then begin
      Result := SetStatus(STS_ERROR, 'GEN001', 'Fatura não encontrada no FGR_LIQITEMCR para troca de documento.', '');
      return(-1); exit;
    end;

    voParams := tF_FGR_LIQITEM.Excluir();
    if (xStatus < 0) then begin
      Result := voParams;
      return(-1); exit;
    end;

      viParams := '';
      putitemXml(viParams, 'CD_EMPRESA', item_f('CD_EMPRESA', tFCR_FATURAI));
      putitemXml(viParams, 'CD_CLIENTE', item_f('CD_CLIENTE', tFCR_FATURAI));
      putitemXml(viParams, 'NR_FAT', item_f('NR_FAT', tFCR_FATURAI));
      putitemXml(viParams, 'NR_PARCELA', item_f('NR_PARCELA', tFCR_FATURAI));
      voParams := activateCmp('FCRSVCO013', 'atualizaTransfComissao', viParams); (*,,,, *)
      if (xStatus < 0) then begin
        Result := voParams;
        return(-1); exit;
      end;

    delitem(vDsFaturas, 1);
  until(vDsFaturas = '');

  voParams := tFGR_LIQ.Salvar();
  if (xStatus < 0) then begin
    Result := voParams;
    return(-1); exit;
  end;

  return(0); exit;
end;

//---------------------------------------------------------------------
function T_FCRSVCO007.gravaLiqMovNegociacao(pParams : String) : String;
//---------------------------------------------------------------------
const
  cDS_METHOD = 'ADICIONAL=Operação: T_FCRSVCO007.gravaLiqMovNegociacao()';
var
  vDtMovim, vDtLiq : TDate;
  vDsLstMovCc, vDsRegistro, vCdEmpLiq, vNrSeqLiq, vNrSeqItem, vDsDuplicata, vDsLstDuplicata : String;
  vNrSeqMov, vNrCtaPesMov, vVlPago, vNrSeqCheque, vNrSeqDuplicata, vTpProcesso : Real;
begin
  if (itemXml('CD_PESSOA', pParams) = '') then begin
    Result := SetStatus(STS_ERROR, 'GEN001', 'Código de pessoa da liquidação não informado.', '');
    return(-1); exit;
  end;
  if (itemXml('CD_EMPLIQ', pParams) = '') then begin
    Result := SetStatus(STS_ERROR, 'GEN001', 'Falta informar a empresa da liquidação', '');
    return(-1); exit;
  end;
  if (itemXml('DT_LIQ', pParams) = '') then begin
    Result := SetStatus(STS_ERROR, 'GEN001', 'Falta informar a data da liquidação', '');
    return(-1); exit;
  end;
  if (itemXml('NR_SEQLIQ', pParams) = '') then begin
    Result := SetStatus(STS_ERROR, 'GEN001', 'Falta informar a sequencia da liquidação', '');
    return(-1); exit;
  end;
  if (itemXml('TP_LIQUIDACAO', pParams) = '') then begin
    Result := SetStatus(STS_ERROR, 'GEN001', 'Falta informar o tipo da sequencia da liquidação', '');
    return(-1); exit;
  end;
  if (itemXml('TP_TIPOREG', pParams) = '') then begin
    Result := SetStatus(STS_ERROR, 'GEN001', 'Falta informar o tipo de registro a gravar na liquidação.', '');
    return(-1); exit;
  end;
  if (itemXml('TP_PROCESSO', pParams) = '') then begin
    Result := SetStatus(STS_ERROR, 'GEN001', 'Falta informar o tipo de processo.', '');
    return(-1); exit;
  end;
  vTpProcesso := itemXmlF('TP_PROCESSO', pParams);
  if (itemXml('VL_PAGO', pParams) = '') then begin
    Result := SetStatus(STS_ERROR, 'GEN001', 'Falta informar o valor a liquidação', '');
    return(-1); exit;
  end;

  vCdEmpLiq := itemXmlF('CD_EMPLIQ', pParams);
  vDtLiq := itemXml('DT_LIQ', pParams);
  vNrSeqLiq := itemXmlF('NR_SEQLIQ', pParams);
  vDsLstMovCC := itemXml('DS_LSTMOVCC', pParams);
  vDsLstDuplicata := itemXml('DS_LSTDUPLICATA', pParams);
  if (vDsLstMovCC <> '') then begin
    repeat
      getitem(vDsRegistro, vDsLstMovCC, 1);
      vNrCtaPesMov := itemXmlF('NR_CTAPES', vDsRegistro);
      vDtMovim := itemXml('DT_MOVIM', vDsRegistro);
      vNrSeqMov := itemXmlF('NR_SEQMOV', vDsRegistro);

      if (vNrCtaPesMov = 0) then begin
        Result := SetStatus(STS_ERROR, 'GEN001', 'Conta da movimentação não informada!', cDS_METHOD);
        return(-1); exit;
      end;
      if (vDtMovim = '') then begin
        Result := SetStatus(STS_ERROR, 'GEN001', 'Data da movimentação não informada!', cDS_METHOD);
        return(-1); exit;
      end;
      if (vNrSeqMov = 0) then begin
        Result := SetStatus(STS_ERROR, 'GEN001', 'Sequência da movimentação não informada!', cDS_METHOD);
        return(-1); exit;
      end;

      creocc(tFCC_MOV, -1);
      putitem_e(tFCC_MOV, 'NR_CTAPES', vNrCtaPesMov);
      putitem_e(tFCC_MOV, 'DT_MOVIM', vDtMovim);
      putitem_e(tFCC_MOV, 'NR_SEQMOV', vNrSeqMov);
      retrieve_o(tFCC_MOV);
      if (xStatus = -7) then begin
        retrieve_x(tFCC_MOV);
      end else if (xStatus = 0) then begin
        Result := SetStatus(STS_ERROR, 'GEN001', 'Movimentação ' + NR_CTAPES + '.FCC_MOV / ' + DT_MOVIM + '.FCC_MOV / ' + NR_SEQMOV + '.FCC_MOV não cadastrada!', cDS_METHOD);
        return(-1); exit;
      end;

      delitem(vDsLstMovCC, 1);
    until (vDsLstMovCC = '');

    setocc(tFCC_MOV, 1);
  end;

  vNrSeqCheque := itemXmlF('NR_SEQCHEQUE', pParams);
  vNrSeqDuplicata := itemXmlF('NR_SEQDUPLICATA', pParams);
  vVlPago := itemXmlF('VL_PAGO', pParams);

  clear_e(tFGR_LIQ);
  putitem_e(tFGR_LIQ, 'CD_EMPLIQ', itemXmlF('CD_EMPLIQ', pParams));
  putitem_e(tFGR_LIQ, 'DT_LIQ', itemXml('DT_LIQ', pParams));
  putitem_e(tFGR_LIQ, 'NR_SEQLIQ', itemXmlF('NR_SEQLIQ', pParams));
  retrieve_e(tFGR_LIQ);
  if (xStatus < 0) then begin
    creocc(tFGR_LIQ, -1);
    putitem_e(tFGR_LIQ, 'CD_EMPLIQ', itemXmlF('CD_EMPLIQ', pParams));
    putitem_e(tFGR_LIQ, 'DT_LIQ', itemXml('DT_LIQ', pParams));
    putitem_e(tFGR_LIQ, 'NR_SEQLIQ', itemXmlF('NR_SEQLIQ', pParams));
    putitem_e(tFGR_LIQ, 'TP_LIQUIDACAO', itemXmlF('TP_LIQUIDACAO', pParams));
    putitem_e(tFGR_LIQ, 'CD_GRUPOEMPRESA', itemXmlF('CD_GRUPOEMPRESA', PARAM_GLB));
    putitem_e(tFGR_LIQ, 'CD_PESSOA', itemXmlF('CD_PESSOA', pParams));
  end;

  creocc(tFGR_LIQITEMCR, -1);
  putitem_e(tFGR_LIQITEMCR, 'CD_EMPLIQ', vCdEmpLiq);
  putitem_e(tFGR_LIQITEMCR, 'DT_LIQ', vDtLiq);
  putitem_e(tFGR_LIQITEMCR, 'NR_SEQLIQ', vNrSeqLiq);
  putitem_e(tFGR_LIQITEMCR, 'NR_SEQITEM', vNrSeqCheque);
  putitem_e(tFGR_LIQITEMCR, 'TP_TIPOREG', itemXmlF('TP_TIPOREG', pParams));
  putitem_e(tFGR_LIQITEMCR, 'NR_CTAPESFCC', item_f('NR_CTAPES', tFCC_MOV));
  putitem_e(tFGR_LIQITEMCR, 'NR_CTAPES', item_f('NR_CTAPES', tFCC_MOV));
  putitem_e(tFGR_LIQITEMCR, 'DT_MOVIMFCC', item_a('DT_MOVIM', tFCC_MOV));
  putitem_e(tFGR_LIQITEMCR, 'NR_SEQMOVFCC', item_f('NR_SEQMOV', tFCC_MOV));
  putitem_e(tFGR_LIQITEMCR, 'CD_OPERADOR', itemXmlF('CD_USUARIO', PARAM_GLB));
  putitem_e(tFGR_LIQITEMCR, 'DT_CADASTRO', Now);
  putitem_e(tFGR_LIQITEMCR, 'VL_LANCAMENTO', vVlPago);
  if (vTpProcesso = 2)  and (itemXml('TP_TIPOREG', pParams) = 1) then begin
    vVlPago := 0;
  end;
  putitem_e(tFGR_LIQ, 'CD_OPERADOR', itemXmlF('CD_USUARIO', PARAM_GLB));
  putitem_e(tFGR_LIQ, 'DT_CADASTRO', Now);

  if (vDsLstDuplicata <> '') then begin
    repeat
      getitem(vDsDuplicata, vDsLstDuplicata, 1);
      vNrSeqDuplicata := vNrSeqDuplicata + 1;

      creocc(tFGR_LIQITEMCC, -1);
      putitem_e(tFGR_LIQITEMCC, 'NR_SEQITEM', vNrSeqDuplicata);
      putitem_e(tFGR_LIQITEMCC, 'CD_EMPRESADUP', itemXmlF('CD_EMPRESA', vDsDuplicata));
      putitem_e(tFGR_LIQITEMCC, 'CD_FORNECDUP', itemXmlF('CD_FORNECEDOR', vDsDuplicata));
      putitem_e(tFGR_LIQITEMCC, 'NR_DUPLICATADUP', itemXmlF('NR_DUPLICATA', vDsDuplicata));
      putitem_e(tFGR_LIQITEMCC, 'NR_PARCELADUP', itemXmlF('NR_PARCELA', vDsDuplicata));
      putitem_e(tFGR_LIQITEMCC, 'CD_OPERADOR', itemXmlF('CD_USUARIO', PARAM_GLB));
      putitem_e(tFGR_LIQITEMCC, 'DT_CADASTRO', Now);

      delitem(vDsLstDuplicata, 1);
    until (vDsLstDuplicata = '');
  end;

  voParams := tFGR_LIQ.Salvar();
  if (xStatus < 0) then begin
    Result := voParams;
    return(-1); exit;
  end;

  putitemXml(Result, 'NR_SEQCHEQUE', vNrSeqCheque);
  putitemXml(Result, 'NR_SEQDUPLICATA', vNrSeqDuplicata);

  return(0); exit;
end;

//-------------------------------------------------------------------------
function T_FCRSVCO007.gravarComissaoRecebimento(pParams : String) : String;
//-------------------------------------------------------------------------
const
  cDS_METHOD = 'ADICIONAL=Operação: T_FCRSVCO007.gravarComissaoRecebimento()';
var
  vRegComissao, viParams, voParams : String;
  vCdEmpFatOrig, vCdClienteOrig, vNrFatOrig, vNrParcelaOrig, vCdEmpFat, vCdCliente, vNrFat, vNrParcela : Real;
begin
  vCdEmpFatOrig := itemXmlF('CD_EMPFATORIG', pParams);
  if (vCdEmpFatOrig = '')  or (vCdEmpFatOrig = 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN001', 'Empresa da fatura origem não informada para gravar comissão.', '');
    return(-1); exit;
  end;
  vCdClienteOrig := itemXmlF('CD_CLIENTEORIG', pParams);
  if (vCdClienteOrig = '')  or (vCdClienteOrig = 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN001', 'Cliente da fatura origem não informado para gravar comissão.', '');
    return(-1); exit;
  end;
  vNrFatOrig := itemXmlF('NR_FATORIG', pParams);
  if (vNrFatOrig = '')  or (vNrFatOrig = 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN001', 'Número da fatura origem não informado para gravar comissão.', '');
    return(-1); exit;
  end;
  vNrParcelaOrig := itemXmlF('NR_PARCELAORIG', pParams);
  if (vNrParcelaOrig = '')  or (vNrParcelaOrig = 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN001', 'Parcela da fatura origem não informada para gravar comissão.', '');
    return(-1); exit;
  end;
  vCdEmpFat := itemXmlF('CD_EMPRESA', pParams);
  if (vCdEmpFat = '')  or (vCdEmpFat = 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN001', 'Empresa da nova fatura não informada para gravar comissão.', '');
    return(-1); exit;
  end;
  vCdCliente := itemXmlF('CD_CLIENTE', pParams);
  if (vCdCliente = '')  or (vCdCliente = 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN001', 'Cliente da nova fatura não informado para gravar comissão.', '');
    return(-1); exit;
  end;
  vNrFat := itemXmlF('NR_FAT', pParams);
  if (vNrFat = '')  or (vNrFat = 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN001', 'Número da nova fatura não informado para gravar comissão.', '');
    return(-1); exit;
  end;
  vNrParcela := itemXmlF('NR_PARCELA', pParams);
  if (vNrParcela = '')  or (vNrParcela = 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN001', 'Parcela da nova fatura não informada para gravar comissão.', '');
    return(-1); exit;
  end;

  clear_e(tF_FCR_COMISSA);
  putitem_e(tF_FCR_COMISSA, 'CD_EMPRESA', vCdEmpFatOrig);
  putitem_e(tF_FCR_COMISSA, 'CD_CLIENTE', vCdClienteOrig);
  putitem_e(tF_FCR_COMISSA, 'NR_FATURA', vNrFatOrig);
  putitem_e(tF_FCR_COMISSA, 'NR_PARCELA', vNrParcelaOrig);
  retrieve_e(tF_FCR_COMISSA);
  if (xStatus >= 0) then begin
    setocc(tF_FCR_COMISSA, -1);
    setocc(tF_FCR_COMISSA, 1);
    repeat

      putitem_e(tF_FCR_COMISSA, 'VL_COMISSAOREC', 0);
      putitem_e(tF_FCR_COMISSA, 'VL_COMISSAOFAT', 0);

      viParams := '';
      putlistitensocc_e(viParams, tF_FCR_COMISSA);
      voParams := activateCmp('FCRSVCO001', 'gravaComissaoFatura', viParams); (*,,,, *)
      if (xStatus < 0) then begin
        Result := voParams;
        return(-1); exit;
      end;

      vRegComissao := '';
      putlistitensocc_e(vRegComissao, tF_FCR_COMISSA);
      clear_e(tFCR_COMISSAO);
      creocc(tFCR_COMISSAO, -1);
      getlistitensocc_e(vRegComissao, tFCR_COMISSAO);

      putitem_e(tFCR_COMISSAO, 'CD_EMPRESA', vCdEmpFat);
      putitem_e(tFCR_COMISSAO, 'CD_CLIENTE', vCdCliente);
      putitem_e(tFCR_COMISSAO, 'NR_FATURA', vNrFat);
      putitem_e(tFCR_COMISSAO, 'NR_PARCELA', vNrParcela);
      putitem_e(tFCR_COMISSAO, 'TP_SITUACAO', 0);
      putitem_e(tFCR_COMISSAO, 'CD_OPERADOR', itemXmlF('CD_USUARIO', PARAM_GLB));
      putitem_e(tFCR_COMISSAO, 'DT_CADASTRO', Now);

      viParams := '';
      putlistitensocc_e(viParams, tFCR_COMISSAO);
      voParams := activateCmp('FCRSVCO001', 'gravaComissaoFatura', viParams); (*,,,, *)
      if (xStatus < 0) then begin
        Result := voParams;
        return(-1); exit;
      end;

      setocc(tF_FCR_COMISSA, curocc(tF_FCR_COMISSA) + 1);
    until(xStatus < 0);
    xStatus := 0;
  end;

  return(0); exit;
end;

//---------------------------------------------------------------
function T_FCRSVCO007.gravaLiqICRAdic(pParams : String) : String;
//---------------------------------------------------------------
const
  cDS_METHOD = 'ADICIONAL=Operação: T_FCRSVCO007.gravaLiqICRAdic()';
var
  vCdEmpLiq, vNrSeqLiq, vNrSeqItem : Real;
  vDtLiq : TDate;
  vCdEmpFat, vCdCliente, vNrFat, vNrParcela : Real;
begin
  vCdEmpLiq := itemXmlF('CD_EMPLIQ', pParams);
  if (vCdEmpLiq = '') then begin
    Result := SetStatus(STS_ERROR, 'GEN001', 'Empresa da liquidação não informada!', cDS_METHOD);
    return(-1); exit;
  end;

  vDtLiq := itemXml('DT_LIQ', pParams);
  if (vDtLiq = '') then begin
    Result := SetStatus(STS_ERROR, 'GEN001', 'Data da liquidação não informada!', cDS_METHOD);
    return(-1); exit;
  end;

  vNrSeqLiq := itemXmlF('NR_SEQLIQ', pParams);
  if (vNrSeqLiq = '') then begin
    Result := SetStatus(STS_ERROR, 'GEN001', 'Número da liquidação não informado!', cDS_METHOD);
    return(-1); exit;
  end;

  vNrSeqItem := itemXmlF('NR_SEQITEM', pParams);
  if (vNrSeqItem = '') then begin
    Result := SetStatus(STS_ERROR, 'GEN001', 'Item da liquidação não informado!', cDS_METHOD);
    return(-1); exit;
  end;

  vCdEmpFat := itemXmlF('CD_EMPFAT', pParams);
  if (vCdEmpFat = '') then begin
    Result := SetStatus(STS_ERROR, 'GEN001', 'Empresa da fatura não informada!', cDS_METHOD);
    return(-1); exit;
  end;

  vCdCliente := itemXmlF('CD_CLIENTE', pParams);
  if (vCdCliente = '') then begin
    Result := SetStatus(STS_ERROR, 'GEN001', 'Cliente da fatura não informado!', cDS_METHOD);
    return(-1); exit;
  end;

  vNrFat := itemXmlF('NR_FAT', pParams);
  if (vNrFat = '') then begin
    Result := SetStatus(STS_ERROR, 'GEN001', 'Número da fatura não informado!', cDS_METHOD);
    return(-1); exit;
  end;

  vNrParcela := itemXmlF('NR_PARCELA', pParams);
  if (vNrParcela = '') then begin
    Result := SetStatus(STS_ERROR, 'GEN001', 'Parcela da fatura não informada!', cDS_METHOD);
    return(-1); exit;
  end;

  clear_e(tFGR_LIQITEMCR);
  putitem_e(tFGR_LIQITEMCR, 'CD_EMPLIQ', vCdEmpLiq);
  putitem_e(tFGR_LIQITEMCR, 'DT_LIQ', vDtLiq);
  putitem_e(tFGR_LIQITEMCR, 'NR_SEQLIQ', vNrSeqLiq);
  putitem_e(tFGR_LIQITEMCR, 'NR_SEQITEM', vNrSeqItem);
  retrieve_e(tFGR_LIQITEMCR);
  if (xStatus >= 0) then begin
    clear_e(tFCR_FATURAI);
    putitem_e(tFCR_FATURAI, 'CD_EMPRESA', vCdEmpFat);
    putitem_e(tFCR_FATURAI, 'CD_CLIENTE', vCdCliente);
    putitem_e(tFCR_FATURAI, 'NR_FAT', vNrFat);
    putitem_e(tFCR_FATURAI, 'NR_PARCELA', vNrParcela);
    retrieve_e(tFCR_FATURAI);
    if (xStatus >= 0) then begin
      creocc(tFGR_LIQICRADI, -1);
      putitem_e(tFGR_LIQICRADI, 'CD_EMPLIQ', vCdEmpLiq);
      putitem_e(tFGR_LIQICRADI, 'DT_LIQ', vDtLiq);
      putitem_e(tFGR_LIQICRADI, 'NR_SEQLIQ', vNrSeqLIq);
      putitem_e(tFGR_LIQICRADI, 'NR_SEQITEM', vNrSeqItem);

      retrieve_o(tFGR_LIQICRADI);
      if (xStatus = -7) then begin
        retrieve_x(tFGR_LIQICRADI);
      end;

      putitem_e(tFGR_LIQICRADI, 'CD_OPERADOR', itemXmlF('CD_USUARIO', PARAM_GLB));
      putitem_e(tFGR_LIQICRADI, 'DT_CADASTRO', Now);
      putitem_e(tFGR_LIQICRADI, 'TP_FATURAMENTO', item_f('TP_FATURAMENTO', tFCR_FATURAI));
      putitem_e(tFGR_LIQICRADI, 'TP_COBRANCA', item_f('TP_COBRANCA', tFCR_FATURAI));
      putitem_e(tFGR_LIQICRADI, 'TP_BAIXA', item_f('TP_BAIXA', tFCR_FATURAI));
      putitem_e(tFGR_LIQICRADI, 'CD_MOEDA', item_f('CD_MOEDA', tFCR_FATURAI));
      putitem_e(tFGR_LIQICRADI, 'NR_PORTADOR', item_f('NR_PORTADOR', tFCR_FATURAI));
      putitem_e(tFGR_LIQICRADI, 'DT_EMISSAO', item_a('DT_EMISSAO', tFCR_FATURAI));
      putitem_e(tFGR_LIQICRADI, 'DT_VENCIMENTO', item_a('DT_VENCIMENTO', tFCR_FATURAI));
      putitem_e(tFGR_LIQICRADI, 'VL_FATURA', item_f('VL_FATURA', tFCR_FATURAI));
      putitem_e(tFGR_LIQICRADI, 'VL_ORIGINAL', item_f('VL_ORIGINAL', tFCR_FATURAI));
      putitem_e(tFGR_LIQICRADI, 'VL_PAGO', item_f('VL_PAGO', tFCR_FATURAI));
      putitem_e(tFGR_LIQICRADI, 'VL_JUROS', item_f('VL_JUROS', tFCR_FATURAI));
      putitem_e(tFGR_LIQICRADI, 'VL_DESCONTO', item_f('VL_DESCONTO', tFCR_FATURAI));
      putitem_e(tFGR_LIQICRADI, 'VL_OUTACRES', item_f('VL_OUTACRES', tFCR_FATURAI));
      putitem_e(tFGR_LIQICRADI, 'VL_OUTDESC', item_f('VL_OUTDESC', tFCR_FATURAI));
      putitem_e(tFGR_LIQICRADI, 'VL_ABATIMENTO', item_f('VL_ABATIMENTO', tFCR_FATURAI));
      putitem_e(tFGR_LIQICRADI, 'VL_DESPFIN', item_f('VL_DESPFIN', tFCR_FATURAI));
      putitem_e(tFGR_LIQICRADI, 'VL_IMPOSTO', item_f('VL_IMPOSTO', tFCR_FATURAI));
      putitem_e(tFGR_LIQICRADI, 'VL_LIQUIDO', item_f('VL_LIQUIDO', tFCR_FATURAI));
      putitem_e(tFGR_LIQICRADI, 'VL_ACRESCIMO', item_f('VL_ACRESCIMO', tFCR_FATURAI));
      putitem_e(tFGR_LIQICRADI, 'VL_RENEGOCIACAO', item_f('VL_RENEGOCIACAO', tFCR_FATURAI));
      putitem_e(tFGR_LIQICRADI, 'PR_DESCPGPRAZO', item_f('PR_DESCPGPRAZO', tFCR_FATURAI));
      putitem_e(tFGR_LIQICRADI, 'PR_JUROMES', item_f('PR_JUROMES', tFCR_FATURAI));
      putitem_e(tFGR_LIQICRADI, 'PR_MULTA', item_f('PR_MULTA', tFCR_FATURAI));
      putitem_e(tFGR_LIQICRADI, 'PR_DESCANTECIP1', item_f('PR_DESCANTECIP1', tFCR_FATURAI));
      putitem_e(tFGR_LIQICRADI, 'PR_DESCANTECIP2', item_f('PR_DESCANTECIP2', tFCR_FATURAI));
      putitem_e(tFGR_LIQICRADI, 'DT_DESCANTECIP1', item_a('DT_DESCANTECIP1', tFCR_FATURAI));
      putitem_e(tFGR_LIQICRADI, 'DT_DESCANTECIP2', item_a('DT_DESCANTECIP2', tFCR_FATURAI));
      putitem_e(tFGR_LIQICRADI, 'NR_CARENCIAATRASO', item_f('NR_CARENCIAATRASO', tFCR_FATURAI));
      putitem_e(tFGR_LIQICRADI, 'NR_CARENCIAMULTA', item_f('NR_CARENCIAMULTA', tFCR_FATURAI));
      putitem_e(tFGR_LIQICRADI, 'NR_DESCPONT', item_f('NR_DESCPONT', tFCR_FATURAI));

      voParams := tFGR_LIQICRADI.Salvar();
      if (xStatus < 0) then begin
        Result := voParams;
        return(-1); exit;
      end;
    end;
  end;

  return(0); exit;
end;

end.
