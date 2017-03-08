unit cFCRSVCO002;

interface

(* COMPONENTES 
  ADMSVCO001 / FCRSVCO087 / 
*)        

uses
  Classes, SysUtils, Math, DB,
  cServiceUnf, cDataSetUnf;

type
  T_FCRSVCO002 = class(TcServiceUnf)
  private
    tFCR_DIASANTEC,
    tGER_FERIADO,
    tV_FCR_PROMOFA : TcDatasetUnf;
    function getParam(pParams : String = '') : String;
    function setEntidade(pParams : String = '') : String;
  protected
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;    
  published
    function CalcDatas(pParams : String = '') : String;
    function CalcVlFat(pParams : String = '') : String;
    function CalculoFatRenegociacao(pParams : String = '') : String;
    function VerNrDiasAtraso(pParams : String = '') : String;
    function VerNrDiasUteisAntecip(pParams : String = '') : String;
    function VerFeriado(pParams : String = '') : String;
  end;

implementation

uses
  cADMSVCO001,
  cActivate, cStatus, cFuncao, cXml, dModulo;

var


//---------------------------------------------------------------
constructor T_FCRSVCO002.Create(AOwner: TComponent);
//---------------------------------------------------------------
begin
  inherited Create(AOwner);
  setEntidade('');
end;

//--------------------------------
destructor T_FCRSVCO002.Destroy;
//--------------------------------
begin
  inherited Destroy;
end;

//---------------------------------------------------------------
function T_FCRSVCO002.getParam(pParams : String = '') : String;
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
  putitem(xParam, 'DT_JUROS');
  putitem(xParam, 'DT_MULTA');
  putitem(xParam, 'IN_CALCULO_JUROS_POR_PAR');
  putitem(xParam, 'IN_VARIACAO_CAMBIAL');
  putitem(xParam, 'NR_DIASATRASO');
  putitem(xParam, 'NR_TIPO_CALC_DESCONTO');
  putitem(xParam, 'PR_JUROS_MENSAL_ATRASO');
  putitem(xParam, 'VL_ACRESCIMO');
  putitem(xParam, 'VL_CALCULADO');
  putitem(xParam, 'VL_DEDUCAO');
  putitem(xParam, 'VL_DESCONTOS');
  putitem(xParam, 'VL_DESPFIN');
  putitem(xParam, 'VL_JUROS');
  putitem(xParam, 'VL_MULTA');

  xParam := T_ADMSVCO001.GetParametro(xParam);


  xParamEmp := '';
  putitem(xParamEmp, 'IN_ACRESC_JURO_RECEB');
  putitem(xParamEmp, 'IN_CALCULO_JUROS_POR_PAR');
  putitem(xParamEmp, 'IN_DESCTO_ANTEC_FAT_SIMU');
  putitem(xParamEmp, 'IN_VARIACAO_CAMBIAL');
  putitem(xParamEmp, 'NR_DIAS_CARENCIA_ATRASO');
  putitem(xParamEmp, 'NR_DIAS_CARENCIA_MULTA');
  putitem(xParamEmp, 'NR_DIAS_DESC_ANTECIP1');
  putitem(xParamEmp, 'NR_DIAS_DESC_ANTECIP2');
  putitem(xParamEmp, 'NR_DIAS_DESC_PONT');
  putitem(xParamEmp, 'NR_TIPO_CALC_DESCONTO');
  putitem(xParamEmp, 'PR_DESC_ANTECIP1');
  putitem(xParamEmp, 'PR_DESC_ANTECIP2');
  putitem(xParamEmp, 'PR_DESC_PONT');
  putitem(xParamEmp, 'PR_JUROS_MENSAL_ATRASO');
  putitem(xParamEmp, 'PR_MULTA');
  putitem(xParamEmp, 'TP_CALC_NOTA_DEBITO');

  xParamEmp := T_ADMSVCO001.GetParamEmpresa(piCdEmpresa, xParamEmp);


end;

//---------------------------------------------------------------
function T_FCRSVCO002.setEntidade(pParams : String = '') : String;
//---------------------------------------------------------------
begin
  tFCR_DIASANTEC := GetEntidade('FCR_DIASANTEC');
  tGER_FERIADO := GetEntidade('GER_FERIADO');
  tV_FCR_PROMOFA := GetEntidade('V_FCR_PROMOFA');
end;

//---------------------------------------------------------
function T_FCRSVCO002.CalcDatas(pParams : String) : String;
//---------------------------------------------------------
const
  cDS_METHOD = 'ADICIONAL=Operação: T_FCRSVCO002.CalcDatas()';
var
  vDtVencimento, vDtPagamento, vDtAtraso, vDtMulta, vDtCalc : TDate;
  vNrDiasAtraso, vSabado, vNrDiasCarenciaAtraso, vNrDiasCarenciaMulta : Real;
  viParams, voParams : String;
begin
  vDtVencimento := itemXml('DT_VENCIMENTO', pParams);
  if (vDtVencimento = '') then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Data de vencimento não informada!', cDS_METHOD);
    return(-1); exit;
  end;

  vSabado := itemXmlB('IN_SABADOUTIL', pParams);
  vNrDiasCarenciaAtraso := itemXmlF('NR_DIASCARENCIAATRASO', pParams);
  vNrDiasCarenciaMulta := itemXmlF('NR_DIASCARENCIAMULTA', pParams);
  vDtCalc := itemXml('DT_VENCIMENTO', pParams);

  if (vNrDiasCarenciaAtraso > 0 ) or (vNrDiasCarenciaMulta > 0) then begin
    putitemXml(viParams, 'IN_SABADOUTIL', vSabado);
    putitemXml(viParams, 'DT_VENCIMENTO', vDtVencimento);
    putitemXml(viParams, 'DT_PAGAMENTO', vDtVencimento);
    voParams := VerNrDiasAtraso(viParams); (* PARAM_GLB, viParams, voParams, xCdErro, xCtxErro *)
    if (xStatus < 0) then begin
      Result := voParams;
      return(-1); exit;
    end;
    vDtCalc := itemXml('DT_VENCIMENTO', voParams);
  end;
  if (vNrDiasCarenciaAtraso > 0) then begin
    vDtAtraso := vDtVencimento + vNrDiasCarenciaAtraso;
  end else begin
    vDtAtraso := vDtCalc;
  end;
  if (vNrDiasCarenciaMulta > 0) then begin
    vDtMulta := vDtVencimento + vNrDiasCarenciaMulta;
  end else begin
    vDtMulta := vDtCalc;
  end;

  vDtAtraso := vDtatraso + 1;
  vDtMulta := vDtMulta + 1;

  Result := '';
  putitemXml(Result, 'DT_JUROS', vDtAtraso);
  putitemXml(Result, 'DT_MULTA', vDtMulta);
  return(0); exit;
end;

//---------------------------------------------------------
function T_FCRSVCO002.CalcVlFat(pParams : String) : String;
//---------------------------------------------------------
const
  cDS_METHOD = 'ADICIONAL=Operação: T_FCRSVCO002.CalcVlFat()';
var
  vDtVencimento, vDtPagamento, vDtAtraso, vDtMulta, vDtDescPontual, vDtDescAntecip1, vDtDescAntecip2, vDtEmissao : TDate;
  vVlFatura, vPrJuroMes, vVlAcrescimo, vVlOutAcres, vVlOutDesc, vVlAbatimento, vPrMulta, vVlDespFin, vVlDescAntecip1 : Real;
  vPrDescAntecip1, vVlDescAntecip2, vPrDescAntecip2, vVlDescPontual, vTpDescPontual, vPrDescPontual : Real;
  vNrDiasAtraso, vNrDiasAntecipacao, vNvVlDeducao, vNvVlAcrescimo, vNvVlFatura, vNvVlDesc, vNvVlMulta, vNvVlMora, vNvPrJuroDia : Real;
  vNvAux1, vNvAux2, vNvAux3, vNvTipoDesc, vNvJurosPorPar, vNrDiasDesc : Real;
  vSabado, vNrDiasCarenciaAtraso, vNrDiasCarenciaMulta, vNrdiasDescPont, vNrDiasDescAntecip1, vNrDiasDescAntecip2, vTpDocumento : Real;
  viParams, voParams, vTpAplicacaoJuros : String;
  vInCalculoJurosPorPar, vNrTipoCalcDesconto, vVlImposto, vTpCalcNotaDebito : Real;
  vJuroMesNegociado, vVlVarAcres, vVlVarDesct : Real;
  vParamEmp : String;
  vInRecebimento, vInAcrecJuroReceb, vInDescDiasAntecip, vInVariacaoCambial, vInAgruparFat, vInDesctoAntecFatSimu : Boolean;
begin
  if (itemXml('LST_PARAM_CORPORATIVO', pParams) <> '') then begin
    voParams := itemXml('LST_PARAM_CORPORATIVO', pParams);
    vInCalculoJurosPorPar := itemXmlB('IN_CALCULO_JUROS_POR_PAR', voParams);
    vNrTipoCalcDesconto := itemXmlF('NR_TIPO_CALC_DESCONTO', voParams);
    vInVariacaoCambial := itemXmlB('IN_VARIACAO_CAMBIAL', voParams);
  end else begin

    viParams := '';
    putitem(viParams,  'IN_CALCULO_JUROS_POR_PAR');
    putitem(viParams,  'NR_TIPO_CALC_DESCONTO');
    putitem(viParams,  'IN_VARIACAO_CAMBIAL');
    xParam := T_ADMSVCO001.GetParametro(xParam); (*viParams,voParams,, *)
  end;
  if (itemXml('LST_PARAM_EMPRESA', pParams) <> '') then begin
    voParams := itemXml('LST_PARAM_EMPRESA', pParams);
    vParamEmp := '' + voParams' + ';
  end else begin

    viParams := '';
    putitem(viParams,  'NR_DIAS_CARENCIA_ATRASO');
    putitem(viParams,  'NR_DIAS_CARENCIA_MULTA');
    putitem(viParams,  'NR_DIAS_DESC_PONT');
    putitem(viParams,  'PR_JUROS_MENSAL_ATRASO');
    putitem(viParams,  'PR_MULTA');
    putitem(viParams,  'PR_DESC_PONT');
    putitem(viParams,  'PR_DESC_ANTECIP1');
    putitem(viParams,  'PR_DESC_ANTECIP2');
    putitem(viParams,  'NR_DIAS_DESC_ANTECIP1');
    putitem(viParams,  'NR_DIAS_DESC_ANTECIP2');
    putitem(viParams,  'TP_CALC_NOTA_DEBITO');
    putitem(viParams,  'IN_ACRESC_JURO_RECEB');
    putitem(viParams,  'IN_DESCTO_ANTEC_FAT_SIMU');

    xParamEmp := T_ADMSVCO001.GetParamEmpresa(piCdEmpresa, xParamEmp); (*itemXml('CD_EMPRESA', *)
  end;

  vInDesctoAntecFatSimu := itemXmlB('IN_DESCTO_ANTEC_FAT_SIMU', vParamEmp);

  vTpCalcNotaDebito := itemXmlF('TP_CALC_NOTA_DEBITO', vParamEmp);
  vInAcrecJuroReceb := itemXmlB('IN_ACRESC_JURO_RECEB', vParamEmp);
  vTpDocumento := itemXmlF('TP_DOCUMENTO', pParams);

  vInRecebimento := itemXmlB('IN_RECEBIMENTO', pParams);

  vNvVlFatura := itemXmlF('VL_FATURA', pParams);

  vNvVlDesc := 0;
  vNvVlMulta := 0;
  vNvVlMora := 0;
  vNvVlDeducao := 0;
  vNvVlAcrescimo := 0;
  vVlOutAcres := 0;
  vInAgruparFat := itemXmlB('IN_AGRUPARFAT', pParams);
  vNvTipoDesc := itemXmlF('NR_TIPO_CALC_DESCONTO', pParams);

  if (vNvTipoDesc <> '') then begin
    vNrTipoCalcDesconto := vNvTipoDesc;
  end;

  vNvJurosPorPar := itemXmlB('IN_CALCULO_JUROS_POR_PAR', pParams);
  if (vNvJurosPorPar<>'') then begin
    vInCalculoJurosPorPar := vNvJurosPorPar;
  end;

  vDtVencimento := itemXml('DT_VENCIMENTO', pParams);
  if (vDtVencimento = '') then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Data de vencimento não informada!', cDS_METHOD);
    return(-1); exit;
  end;

  vDtPagamento := itemXml('DT_PAGAMENTO', pParams);
  if (vDtPagamento = '') then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Data de pagamento não informada!', cDS_METHOD);
    return(-1); exit;
  end;

  vVlFatura := itemXmlF('VL_FATURA', pParams);
  if (vVlFatura = '') then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Valor da fatura não informado!', cDS_METHOD);
    return(-1); exit;
  end;

  vSabado := itemXmlB('IN_SABADOUTIL', pParams);
  vTpAplicacaoJuros := itemXmlF('TP_APLICACAOJUROS', pParams);

  if (vInCalculoJurosPorPar = 1) then begin
    vNrDiasCarenciaAtraso := itemXmlF('NR_DIAS_CARENCIA_ATRASO', vParamEmp);
    vNrDiasCarenciaMulta := itemXmlF('NR_DIAS_CARENCIA_MULTA', vParamEmp);
    vNrDiasDescPont := itemXmlF('NR_DIAS_DESC_PONT', vParamEmp);
    vPrJuroMes := itemXmlF('PR_JUROS_MENSAL_ATRASO', vParamEmp);
    vJuroMesNegociado := itemXmlF('VL_JUROMES_NEGOCIADO', pParams);

    if (vPrJuroMes = 0)  or (vPrJuroMes = '')  or (vInRecebimento = True) then begin
      if (vJuroMesNegociado <> '') then begin
        vPrJuroMes := vJuroMesNegociado;
      end;
    end else if (vJuroMesNegociado > 0)  and (vJuroMesNegociado <> vPrJuroMes) then begin
      vPrJuroMes := vJuroMesNegociado;
    end;
    if (vPrJuroMes = '') then begin
      vPrJuroMes := 0;
    end;

    vPrMulta := itemXmlF('PR_MULTA', vParamEmp);
    if (vPrMulta = '') then begin
      vPrMulta := 0;
    end;

    vPrDescAntecip1 := itemXmlF('PR_DESC_ANTECIP1', vParamEmp);
    vNrDiasDescAntecip1 := itemXmlF('NR_DIAS_DESC_ANTECIP1', vParamEmp);
    if (vNrDiasDescAntecip1 = '') then begin
      vNrDiasDescAntecip1 := 0;
    end;
    if (vPrDescAntecip1 = '') then begin
      vPrDescAntecip1 := 0;
    end;
    if (vPrDescAntecip1 > 0) then begin
      vDtDescAntecip1 := vDtVencimento - vNrDiasDescAntecip1;
    end;
    if (vPrDescAntecip2 > 0) then begin
      vDtDescAntecip2 := vDtVencimento - vNrDiasDescAntecip2;
    end;
    if (itemXml('PR_DESCANTECIP1', pParams) <> '')  and (itemXml('DT_DESCANTECIP1', pParams) <> '') then begin
      vPrDescAntecip1 := itemXmlF('PR_DESCANTECIP1', pParams);
      vDtDescAntecip1 := itemXml('DT_DESCANTECIP1', pParams);
    end;

  end else begin
    vNrDiasCarenciaAtraso := itemXmlF('NR_DIASCARENCIAATRASO', pParams);
    vNrDiasCarenciaMulta := itemXmlF('NR_DIASCARENCIAMULTA', pParams);
    vNrDiasDescPont := itemXmlF('NR_DIASDESCPONT', pParams);
    vPrJuroMes := itemXmlF('PR_JUROMES', pParams);
    if (vPrJuroMes = 0) then begin
      vPrJuroMes := itemXmlF('PR_JUROS_MENSAL_ATRASO', vParamEmp);
    end;

    vPrMulta := itemXmlF('PR_MULTA', pParams);
    if (vPrMulta = '') then begin
      vPrMulta := 0;
    end;
    vPrDescAntecip1 := itemXmlF('PR_DESCANTECIP1', pParams);
    vDtDescAntecip1 := itemXml('DT_DESCANTECIP1', pParams);

  end;
  if (itemXml('IN_PROMOCAOFAT', pParams) = True)  and (itemXml('NR_FAT', pParams) <> '') then begin
    clear_e(tV_FCR_PROMOFA);
    putitem_e(tV_FCR_PROMOFA, 'CD_EMPFAT', itemXmlF('CD_EMPRESA', pParams));
    putitem_e(tV_FCR_PROMOFA, 'CD_CLIENTE', itemXmlF('CD_CLIENTE', pParams));
    putitem_e(tV_FCR_PROMOFA, 'NR_FAT', itemXmlF('NR_FAT', pParams));
    putitem_e(tV_FCR_PROMOFA, 'NR_PARCELA', itemXmlF('NR_PARCELA', pParams));
    putitem_e(tV_FCR_PROMOFA, 'DT_VIGENCIAINI', '<=' + vDtPagamento' + ');
    putitem_e(tV_FCR_PROMOFA, 'DT_VIGENCIAFIM', '>=' + vDtPagamento' + ');
    putitem_e(tV_FCR_PROMOFA, 'PR_TXJURO', '!=');
    retrieve_e(tV_FCR_PROMOFA);
    if (xStatus >= 0) then begin
      vPrJuroMes := item_f('PR_TXJURO', tV_FCR_PROMOFA);
    end;
  end;

  vDtEmissao := itemXml('DT_EMISSAO', pParams);

  vPrDescPontual := itemXmlF('PR_DESCPGPRAZO', pParams);
  if (itemXml('PR_DESCPGPRAZO', pParams) = '') then begin
    vPrDescPontual := itemXmlF('PR_DESC_PONT', vParamEmp);
  end;
  vVlOutAcres := itemXmlF('VL_OUTACRES', pParams);
  vVlAbatimento := itemXmlF('VL_ABATIMENTO', pParams);
  vVlDespFin := itemXmlF('VL_DESPFIN', pParams);
  vVlImposto := itemXmlF('VL_IMPOSTO', pParams);
  vVlOutDesc := itemXmlF('VL_OUTDESC', pParams);
  vDtMulta := vDtVencimento + vNrDiasCarenciaMulta;
  vDtAtraso := vDtVencimento + vNrDiasCarenciaAtraso;
  vDtDescPontual := vDtVencimento - vNrDiasDescPont;

  vNvVlFatura := vVlFatura - vVlAbatimento - vVlImposto;

  if (vDtPagamento > vDtMulta) then begin
    if (vPrMulta > 0) then begin
      vNvVlMulta := (vNvVlFatura * vPrMulta) / 100;
      vNvVlMulta := roundto(vNvVlMulta, 2);
    end;
  end;
  if (vDtPagamento > vDtAtraso) then begin
    putitemXml(viParams, 'IN_SABADOUTIL', vSabado);
    putitemXml(viParams, 'DT_VENCIMENTO', vDtVencimento);
    putitemXml(viParams, 'DT_PAGAMENTO', vDtPagamento);
    voParams := VerNrDiasAtraso(viParams); (* PARAM_GLB, viParams, voParams, xCdErro, xCtxErro *)
    if (xStatus < 0) then begin
      Result := voParams;
      return(-1); exit;
    end;
    vNrDiasAtraso := itemXmlF('NR_DIASATRASO', voParams);
    if (vNrDiasAtraso > 0) then begin
      if (vPrJuroMes > 0) then begin
        if (vTpAplicacaoJuros = 'J') then begin
          vNvAux1 := gInt(vNrDiasAtraso / 30);
          vNvAux2 := vNvVlFatura;
          vNvAux3 := (1 + vPrJuroMes   / 100);
          vNvAux2 := vNvAux2 * gpower(vNvAux3, vNvAux1);
          vNvAux2 := vNvAux2 + (vNvAux2 * vPrJuroMes * (vNrDiasAtraso - vNvAux1 * 30) / 3000);
          vNvVlMora := vNvAux2 - vNvVlFatura;
          vNvVlMora := roundto(vNvVlMora, 2);
        end else begin
          vNvPrJuroDia := vPrJuroMes / 30;
          vNvVlMora := (vNvVlFatura * vNvPrJuroDia) / 100;
          vNvVlMora := vNvVlMora  * vNrDiasAtraso;
          vNvVlMora := roundto(vNvVlMora, 2);
        end;
      end;
    end;

    vNvVlFatura := vNvVlFatura + vVlDespFin + vVlOutAcres - vVlOutDesc;
    vNvVlFatura := vNvVlFatura + vNvVlMulta + vNvVlMora;
  end else begin
    if (vInAgruparFat = False) then begin
      if (vNrTipoCalcDesconto = 1) then begin
        if   (vDtPagamento <= vDtDescPontual);
          vNvVlDesc := ((vNvVlFatura * vPrDescPontual) / 100);
          vNvVlDesc := roundto(vNvVlDesc, 2);
          vNvVlFatura := vNvVlFatura   - vNvVlDesc;
        end;
      end else begin

        vInDescDiasAntecip := False;
        clear_e(tFCR_DIASANTEC);
        putitem_e(tFCR_DIASANTEC, 'CD_EMPRESA', itemXmlF('CD_EMPRESA', PARAM_GLB));
        retrieve_e(tFCR_DIASANTEC);
        if (xStatus >= 0)  and (vDtPagamento < vDtVencimento) then begin
          vNrDiasAntecipacao := vDtVencimento - vDtPagamento;
          sort/e(t FCR_DIASANTEC, 'NR_DIAS:a';);
          setocc(tFCR_DIASANTEC, 1);
          while (xStatus >= 0) do begin
            if (curocc(tFCR_DIASANTEC) = totocc(FCR_DIASANTEC)) then begin
              if (vNrDiasAntecipacao >= item_f('NR_DIAS', tFCR_DIASANTEC)) then begin
                vNvVlDesc := (vNvVlFatura * item_f('PR_ATENCIP', tFCR_DIASANTEC))/100;
                vNvVlDesc := roundto(vNvVlDesc, 2);
                vNvVlFatura := vNvVlFatura - vNvVlDesc;
                vInDescDiasAntecip := True;
                break;
              end;
            end else begin
              if (vNrDiasAntecipacao >= item_f('NR_DIAS', tFCR_DIASANTEC))  and (vNrDiasAntecipacao < gnext('item_f('NR_DIAS', tFCR_DIASANTEC)')) then begin
                vNvVlDesc := (vNvVlFatura * item_f('PR_ATENCIP', tFCR_DIASANTEC))/100;
                vNvVlDesc := roundto(vNvVlDesc, 2);
                vNvVlFatura := vNvVlFatura - vNvVlDesc;
                vInDescDiasAntecip := True;
                break;
              end;
            end;
            setocc(tFCR_DIASANTEC, curocc(tFCR_DIASANTEC) + 1);
          end;
        end;
        if (vDtPagamento <= vDtDescAntecip1)    and (vInDescDiasAntecip = False) then begin
          vNrDiasAntecipacao := vDtVencimento - vDtPagamento;

          if (vInDesctoAntecFatSimu = True) then begin
            vNrDiasDesc := vDtVencimento - vDtEmissao;
            vNvAux2 := (vPrDescAntecip1 / vNrDiasDesc) * vNrDiasAntecipacao;
          end else begin
            vNvAux2 := (vPrDescAntecip1 / 30) * vNrDiasAntecipacao;
          end;

          vNvVlDesc := (vNvVlFatura     * vNvAux2) / 100;
          vNvVlDesc := roundto(vNvVlDesc, 2);
          vNvVlFatura := vNvVlFatura      - vNvVlDesc;
        end;
      end;
    end;

    vNvVlFatura := vNvVlFatura + vVlDespFin + vVlOutAcres - vVlOutDesc;

  end;

  vNvVlDeducao := vNvVlDesc + vVlAbatimento + vVlImposto + vVlOutDesc;

  if (vTpDocumento = 6) then begin
    if (vTpCalcNotaDebito = 1) then begin
      vNvVlFatura := vNvVlFatura - vNvVlMulta;
      vNvVlMulta := '';
    end else if (vTpCalcNotaDebito = 2) then begin
      vNvVlFatura := vNvVlFatura - vNvVlMora;
      vNvVlMora := '';
      vPrJuroMes := '';
    end else if (vTpCalcNotaDebito = 3) then begin
      vNvVlFatura := itemXmlF('VL_FATURA', pParams);
      vNvVlMulta := '';
      vNvVlMora := '';
      vPrJuroMes := '';
    end;
  end;
  if (vInAcrecJuroReceb <> True) then begin
    vNvVlAcrescimo := vVlDespFin + vNvVlMora + vNvVlMulta;
  end else begin
    vNvVlAcrescimo := vVlDespFin + vNvVlMora + vNvVlMulta + vVlOutAcres;
  end;
  if (vInVariacaoCambial = True)  and (itemXml('CD_EMPRESA', pParams) <> '') then begin
    viParams := '';
    putitemXml(viParams, 'CD_EMPFAT', itemXmlF('CD_EMPRESA', pParams));
    putitemXml(viParams, 'CD_CLIENTE', itemXmlF('CD_CLIENTE', pParams));
    putitemXml(viParams, 'NR_FAT', itemXmlF('NR_FAT', pParams));
    putitemXml(viParams, 'NR_PARCELA', itemXmlF('NR_PARCELA', pParams));
    putitemXml(viParams, 'DT_PAGAMENTO', itemXml('DT_PAGAMENTO', pParams));
    voParams := activateCmp('FCRSVCO087', 'buscaFatVariacao', viParams); (*viParams,voParams,, *)
    if (xStatus < 0) then begin
      Result := voParams;
      return(-1); exit;
    end;
    vVlVarAcres := itemXmlF('VL_VARACRES', voParams);
        vVlVarDesct := itemXmlF('VL_VARDESCT', voParams);
    vNvVlMora := vNvVlMora      + vVlVarAcres;
    vNvVlDesc := vNvVlDesc      + vVlVarDesct;
    vNvVlAcrescimo := vNvVlAcrescimo + vVlVarAcres;
    vNvVlDeducao := vNvVlDeducao   + vVlVarDesct;
  end;

  Result := '';
  putitemXml(Result, 'VL_CALCULADO', vNvVlFatura);
  putitemXml(Result, 'VL_JUROS', vNvVlMora);
  putitemXml(Result, 'VL_DESCONTOS', vNvVlDesc);
  putitemXml(Result, 'VL_ACRESCIMO', vNvVlAcrescimo);
  putitemXml(Result, 'VL_DEDUCAO', vNvVlDeducao);
  putitemXml(Result, 'VL_MULTA', vNvVlMulta);
  putitemXml(Result, 'PR_JUROS_MENSAL_ATRASO', vPrJuroMes);
  putitemXml(Result, 'VL_DESPFIN', vVlDespFin);
  putitemXml(Result, 'NR_DIASATRASO', vNrdiasAtraso);

  return(0); exit;
end;

//----------------------------------------------------------------------
function T_FCRSVCO002.CalculoFatRenegociacao(pParams : String) : String;
//----------------------------------------------------------------------
const
  cDS_METHOD = 'ADICIONAL=Operação: T_FCRSVCO002.CalculoFatRenegociacao()';
var
  viParams, voParams, vTpAplicacaoJuros, vParamEmp : String;
  vVlFatura, vPrJuroMes, vVlAcrescimo, vVlOutAcres, vVlOutDesc, vVlAbatimento, vPrMulta, vVlDespFin : Real;
  vVlDescAntecip1, vPrDescAntecip1, vVlDescAntecip2, vPrDescAntecip2, vVlDescPontual, vTpDescPontual : Real;
  vPrDescPontual, vNrDiasAtraso, vNrDiasAntecipacao, vNvVlDeducao, vNvVlAcrescimo, vNvVlFatura : Real;
  vNvVlDesc, vNvVlMulta, vNvVlMora, vNvPrJuroDia, vNvAux1, vNvAux2, vNvAux3, vNvTipoDesc, vNvJurosPorPar : Real;
  vSabado, vNrDiasCarenciaAtraso, vNrDiasCarenciaMulta, vNrdiasDescPont, vNrDiasDescAntecip1 : Real;
  vNrDiasDescAntecip2, vInCalculoJurosPorPar, vNrTipoCalcDesconto, vJuroMesNegociado, vNrModalidadeCalculo : Real;
  vIndice, vPeriodo, vTpDocumento, vTpCalcNotaDebito, vVlImposto : Real;
  vDtVencimento, vDtPagamento, vDtAtraso, vDtMulta, vDtDescPontual, vDtDescAntecip1, vDtDescAntecip2 : TDate;
  InDespFin, InMulta : Boolean;
begin
  InDespFin := itemXmlB('IN_DESP_FIN', pParams);
  InMulta := itemXmlB('IN_MULTA', pParams);

  vNrModalidadeCalculo := itemXmlF('NR_MODALIDADE_CALCULO', pParams);

  viParams := '';
  putitem(viParams,  'IN_CALCULO_JUROS_POR_PAR');
  putitem(viParams,  'NR_TIPO_CALC_DESCONTO');
  xParam := T_ADMSVCO001.GetParametro(xParam); (*viParams,voParams,, *)

  viParams := '';
  putitem(viParams,  'NR_DIAS_CARENCIA_ATRASO');
  putitem(viParams,  'NR_DIAS_CARENCIA_MULTA');
  putitem(viParams,  'NR_DIAS_DESC_PONT');
  putitem(viParams,  'PR_JUROS_MENSAL_ATRASO');
  putitem(viParams,  'PR_MULTA');
  putitem(viParams,  'PR_DESC_PONT');
  putitem(viParams,  'PR_DESC_ANTECIP1');
  putitem(viParams,  'PR_DESC_ANTECIP2');
  putitem(viParams,  'NR_DIAS_DESC_ANTECIP1');
  putitem(viParams,  'NR_DIAS_DESC_ANTECIP2');
  putitem(viParams,  'TP_CALC_NOTA_DEBITO');
  xParamEmp := T_ADMSVCO001.GetParamEmpresa(piCdEmpresa, xParamEmp); (*itemXml('CD_EMPRESA', *)
    vParamEmp := '' + voParams' + ';
  end;

  vNvVlFatura := itemXmlF('VL_FATURA', pParams);
  vNvVlDesc := 0;
  vNvVlMulta := 0;
  vNvVlMora := 0;
  vNvVlDeducao := 0;
  vNvVlAcrescimo := 0;
  vNrDiasCarenciaAtraso := 0;
  vNrDiasCarenciaMulta := 0;
  vNrDiasDescPont := 0;
  vPrJuroMes := 0;
  vPrMulta := 0;
  vNrDiasDescAntecip1 := 0;
  vPrDescAntecip1 := 0;

  vNvTipoDesc := itemXmlF('NR_TIPO_CALC_DESCONTO', pParams);
  if (vNvTipoDesc <> '') then begin
    vNrTipoCalcDesconto := vNvTipoDesc;
  end;

  vNvJurosPorPar := itemXmlB('IN_CALCULO_JUROS_POR_PAR', pParams);
  if (vNvJurosPorPar<>'') then begin
    vInCalculoJurosPorPar := vNvJurosPorPar;
  end;

  vDtVencimento := itemXml('DT_VENCIMENTO', pParams);
  if (vDtVencimento = '') then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Data de vencimento não informada!', cDS_METHOD);
    return(-1); exit;
  end;

  vDtPagamento := itemXml('DT_PAGAMENTO', pParams);
  if (vDtPagamento = '') then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Data de pagamento não informada!', cDS_METHOD);
    return(-1); exit;
  end;

  vVlFatura := itemXmlF('VL_FATURA', pParams);
  if (vVlFatura = '') then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Valor da fatura não informado!', cDS_METHOD);
    return(-1); exit;
  end;
  vSabado := itemXmlB('IN_SABADOUTIL', pParams);
  vTpAplicacaoJuros := itemXmlF('TP_APLICACAO_JUROS', pParams);

  if (vInCalculoJurosPorPar = 1) then begin
    vNrDiasCarenciaAtraso := itemXmlF('NR_DIAS_CARENCIA_ATRASO', vParamEmp);
    vNrDiasCarenciaMulta := itemXmlF('NR_DIAS_CARENCIA_MULTA', vParamEmp);
    vNrDiasDescPont := itemXmlF('NR_DIAS_DESC_PONT', vParamEmp);
    vPrJuroMes := itemXmlF('PR_JUROS_MENSAL_ATRASO', vParamEmp);
    vPrMulta := itemXmlF('PR_MULTA', vParamEmp);
    vPrDescAntecip1 := itemXmlF('PR_DESC_ANTECIP1', vParamEmp);
    vNrDiasDescAntecip1 := itemXmlF('NR_DIAS_DESC_ANTECIP1', vParamEmp);
  end;
  if (vInCalculoJurosPorPar = 0) then begin
    vNrDiasCarenciaAtraso := itemXmlF('NR_DIASCARENCIAATRASO', pParams);
    vNrDiasCarenciaMulta := itemXmlF('NR_DIASCARENCIAMULTA', pParams);
    vNrDiasDescPont := itemXmlF('NR_DIASDESCPONT', pParams);
    vPrJuroMes := itemXmlF('PR_JUROMES', pParams);
    vPrMulta := itemXmlF('PR_MULTA', pParams);
    vPrDescAntecip1 := itemXmlF('PR_DESCANTECIP1', pParams);
    vDtDescAntecip1 := itemXml('DT_DESCANTECIP1', pParams);
  end;

  vJuroMesNegociado := itemXmlF('VL_JUROMES_NEGOCIADO', pParams);
  if (vJuroMesNegociado <> '') then begin
    vPrJuroMes := vJuroMesNegociado;
  end;

  vPrDescPontual := itemXmlF('PR_DESCPGPRAZO', pParams);
  vVlAbatimento := itemXmlF('VL_ABATIMENTO', pParams);
  vVlDespFin := itemXmlF('VL_DESPFIN', pParams);
  vVlOutAcres := itemXmlF('VL_OUTACRES', pParams);
  vVlImposto := itemXmlF('VL_IMPOSTO', pParams);
  vVlOutDesc := itemXmlF('VL_OUTDESC', pParams);

  vTpCalcNotaDebito := itemXmlF('TP_CALC_NOTA_DEBITO', vParamEmp);
  if (vNvTipoDesc <> '') then begin
    vNrTipoCalcDesconto := vNvTipoDesc;
  end;
  vTpDocumento := itemXmlF('TP_DOCUMENTO', pParams);

  if (vPrDescAntecip1 > 0) then begin
    vDtDescAntecip1 := vDtVencimento - vNrDiasDescAntecip1;
  end;
  if (vPrDescAntecip2 > 0) then begin
    vDtDescAntecip2 := vDtVencimento - vNrDiasDescAntecip2;
  end;

  vDtMulta := vDtVencimento + vNrDiasCarenciaMulta;

  vDtAtraso := vDtVencimento + vNrDiasCarenciaAtraso;

  vDtDescPontual := vDtVencimento - vNrDiasDescPont;

  vNvVlFatura := vVlFatura - vVlAbatimento - vVlImposto;

  if (vDtPagamento > vDtMulta) then begin
    if (vPrMulta > 0) then begin
      vNvVlMulta := (vNvVlFatura * vPrMulta) / 100;
      vNvVlMulta := roundto(vNvVlMulta, 2);
    end;
  end;
  if (vDtPagamento > vDtAtraso) then begin
    putitemXml(viParams, 'IN_SABADOUTIL', vSabado);
    putitemXml(viParams, 'DT_VENCIMENTO', vDtVencimento);
    putitemXml(viParams, 'DT_PAGAMENTO', vDtPagamento);
    voParams := VerNrDiasAtraso(viParams); (* PARAM_GLB, viParams, voParams, xCdErro, xCtxErro *)
    if (xStatus < 0) then begin
      Result := voParams;
      return(-1); exit;
    end;
    vNrDiasAtraso := itemXmlF('NR_DIASATRASO', voParams);
    if (vNrDiasAtraso > 0) then begin
      if (vPrJuroMes > 0) then begin
        if (vTpAplicacaoJuros = 'J') then begin
          vNvAux1 := gInt(vNrDiasAtraso / 30);
          vNvAux2 := vNvVlFatura;
          vNvAux3 := (1 + vPrJuroMes   / 100);
          vNvAux2 := vNvAux2 * gpower(vNvAux3, vNvAux1);
          vNvAux2 := vNvAux2 + (vNvAux2 * vPrJuroMes * (vNrDiasAtraso - vNvAux1 * 30) / 3000);
          vNvVlMora := vNvAux2 - vNvVlFatura;
          vNvVlMora := roundto(vNvVlMora, 2);
        end else begin

          vNvPrJuroDia := vPrJuroMes / 30;
          vNvVlMora := (vNvVlFatura * vNvPrJuroDia) / 100;
          vNvVlMora := vNvVlMora  * vNrDiasAtraso;
          vNvVlMora := roundto(vNvVlMora, 2);
        end;
      end;
    end;
    vNvVlFatura := vNvVlFatura + vVlDespFin + vVlOutAcres;
    vNvVlFatura := vNvVlFatura + vNvVlMulta + vNvVlMora;
  end;
  if (vDtPagamento <= vDtAtraso) then begin
    if (vNrTipoCalcDesconto = 1) then begin
      if   (vDtPagamento <= vDtDescPontual);
        vNvVlDesc := ((vNvVlFatura * vPrDescPontual) / 100);
        vNvVlDesc := roundto(vNvVlDesc, 2);
        vNvVlFatura := vNvVlFatura   - vNvVlDesc;
      end;
    end else begin

      if (vDtPagamento <= vDtDescAntecip1) then begin
        if (vTpAplicacaoJuros = 'J') then begin
          if (vNrModalidadeCalculo = 1) then begin
            vNrDiasAntecipacao := vDtVencimento - vDtPagamento;
            vPeriodo := gInt(vNrDiasAntecipacao / 30);
            vNvVlDesc := vNvVlFatura * gpower(1 - vPrJuroMes / 100, vPeriodo);
            vNvVlDesc := vNvVlDesc - (vNvVlDesc * (vNrDiasAntecipacao - vPeriodo * 30) * vPrJuroMes / 100 / 30);

            vNvVlDesc := (vNvVlFatura - vNvVlDesc);
            vNvVlDesc := roundto(vNvVlDesc, 2);
            vNvVlFatura := (vNvVlFatura - vNvVlDesc);
          end else begin

            vNrDiasAntecipacao := vDtVencimento - vDtPagamento;
            vPeriodo := gInt(vNrDiasAntecipacao / 30);
            vNvVlDesc := vNvVlFatura / gpower(1 + vPrJuroMes / 100, vPeriodo);
            vNvVlDesc := vNvVlDesc - (vNvVlDesc * (vNrDiasAntecipacao - vPeriodo * 30) * vPrJuroMes / 100 / 30);

            vNvVlDesc := (vNvVlFatura - vNvVlDesc);
            vNvVlDesc := roundto(vNvVlDesc, 2);
            vNvVlFatura := (vNvVlFatura - vNvVlDesc);
          end;
        end else begin

          if (vNrModalidadeCalculo = 1) then begin
            vNrDiasAntecipacao := vDtVencimento    - vDtPagamento;
            vNvAux2 := (vPrDescAntecip1 / 30) * vNrDiasAntecipacao;
            vNvVlDesc := (vNvVlFatura     * vNvAux2) / 100;
            vNvVlDesc := roundto(vNvVlDesc, 2);
            vNvVlFatura := vNvVlFatura      - vNvVlDesc;
          end else begin

            vNrDiasAntecipacao := vDtVencimento    - vDtPagamento;
            vNvVlDesc := (vNvVlFatura / (1 + vNrDiasAntecipacao * vPrDescAntecip1 / 100 / 30));

            vNvVlDesc := (vNvVlFatura - vNvVlDesc);
            vNvVlDesc := roundto(vNvVlDesc, 2);
            vNvVlFatura := (vNvVlFatura - vNvVlDesc);
          end;
        end;
      end;
    end;

    vNvVlFatura := vNvVlFatura + vVlDespFin + vVlOutAcres - vVlOutDesc;

  end;

  vNvVlDeducao := vNvVlDesc + vVlAbatimento + vVlImposto + vVlOutDesc;

  if (vTpDocumento = 6) then begin
    if (vTpCalcNotaDebito = 1) then begin
      vNvVlFatura := vNvVlFatura - vNvVlMulta;
      vNvVlMulta := '';
    end else if (vTpCalcNotaDebito = 2) then begin
      vNvVlFatura := vNvVlFatura - vNvVlMora;
      vNvVlMora := '';
      vPrJuroMes := '';
    end else if (vTpCalcNotaDebito = 3) then begin
      vNvVlFatura := itemXmlF('VL_FATURA', pParams);
      vNvVlMulta := '';
      vNvVlMora := '';
      vPrJuroMes := '';
    end;
  end;
  if (InDespFin = False) then begin
    vVlDespFin := 0;
  end;
  if (InMulta   = False) then begin
    vNvVlMulta := 0;
  end;

  vNvVlAcrescimo := vVlDespFin + vNvVlMora + vNvVlMulta + vVlOutAcres;

  Result := '';
  putitemXml(Result, 'VL_CALCULADO', vNvVlFatura);
  putitemXml(Result, 'VL_JUROS', vNvVlMora);
  putitemXml(Result, 'VL_DESCONTOS', vNvVlDesc);
  putitemXml(Result, 'VL_ACRESCIMO', vNvVlAcrescimo);
  putitemXml(Result, 'VL_DEDUCAO', vNvVlDeducao);
  putitemXml(Result, 'VL_MULTA', vNvVlMulta);
  putitemXml(Result, 'PR_JUROS_MENSAL_ATRASO', vPrJuroMes);

  return(0); exit;
end;

//---------------------------------------------------------------
function T_FCRSVCO002.VerNrDiasAtraso(pParams : String) : String;
//---------------------------------------------------------------
const
  cDS_METHOD = 'ADICIONAL=Operação: T_FCRSVCO002.VerNrDiasAtraso()';
var
  vCdEmp, vSabado, vDiaVcto, vNrDiasAtraso : Real;
  viParams, voParams, vInFeriado : String;
  vDtVcto, vDtPgto : TDate;
begin
  vSabado := itemXmlB('IN_SABADOUTIL', pParams);

  vDtVcto := itemXml('DT_VENCIMENTO', pParams);
  vDtPgto := itemXml('DT_PAGAMENTO', pParams);
  vInFeriado := 'S';
  while (vInFeriado := 'S') do begin

    viParams := 'DT_DATA=' + vDtVcto' + ';

    voParams := VerFeriado(viParams); (* PARAM_GLB, viParams, voParams, xCdErro, xCtxErro *)
    if (xStatus < 0) then begin
      Result := voParams;
      return(-1); exit;
    end;
    if (vInFeriado = 'S') then begin
      vDtVcto := vDtVcto + 1d;
    end;
  end;

  vDiaVcto := vDtVcto[A];
  if (vDiaVcto = 6) then begin
    if (vSabado = 1) then begin
    end else begin

      vDtVcto := vDtVcto + 2d;
    end;
  end else if (vDiaVcto = 7) then begin
    vDtVcto := vDtVcto + 1d;
  end;

  vInFeriado := 'S';
  while (vInFeriado := 'S') do begin

    viParams := 'DT_DATA=' + vDtVcto' + ';
    voParams := VerFeriado(viParams); (* PARAM_GLB, viParams, voParams, xCdErro, xCtxErro *)
    if (xStatus < 0) then begin
      Result := voParams;
      return(-1); exit;
    end;
    if (vInFeriado = 'S') then begin
      vDtVcto := vDtVcto + 1d;
    end;
  end;
  if (vDtVcto <> vDtPgto) then begin
    vDtVcto := itemXml('DT_VENCIMENTO', pParams);

    vNrDiasAtraso := (vDtPgto - vDtVcto);
  end else begin

    vNrDiasAtraso := 0;
  end;

  Result := '';
  putitemXml(Result, 'NR_DIASATRASO', vNrDiasAtraso);
  putitemXml(Result, 'DT_VENCIMENTO', vDtVcto);

  return(0); exit;

end;

//---------------------------------------------------------------------
function T_FCRSVCO002.VerNrDiasUteisAntecip(pParams : String) : String;
//---------------------------------------------------------------------
const
  cDS_METHOD = 'ADICIONAL=Operação: T_FCRSVCO002.VerNrDiasUteisAntecip()';
var
  vCdEmp, vSabado, vDiaAux, vNrDiasUteis : Real;
  viParams, voParams, vInFeriado : String;
  vDtVcto, vDtAux : TDate;
begin
  vSabado := itemXmlB('IN_SABADOUTIL', pParams);
  vNrDiasUteis := 0;
  vDtAux := itemXml('DT_PAGAMENTO', pParams);
  vDtVcto := itemXml('DT_VENCIMENTO', pParams);
  while (vDtAux < vDtVcto) do begin
    vDiaAux := vDtAux[A];

    viParams := 'DT_DATA=' + vDtAux' + ';

    voParams := VerFeriado(viParams); (* PARAM_GLB, viParams, voParams, xCdErro, xCtxErro *)
    if (xStatus < 0) then begin
      Result := voParams;
      return(-1); exit;
    end;
    if (vInFeriado ='S') then begin
      vDtAux := vDtAux + 1d;
    end else begin
      if (vDiaAux = 6) then begin
        if (vSabado = 1) then begin
          vNrDiasUteis := vNrDiasUteis + 1;
          vDtAux := vDtAux + 2d;
        end else begin

          vDtAux := vDtAux + 2d;
        end;
      end else if (vDiaAux = 7) then begin
          vDtAux := vDtAux + 1d;
      end else begin

        vNrDiasUteis := vNrDiasUteis + 1;
        vDtAux := vDtAux + 1d;
      end;
    end;
  end;
  Result := 'NR_DIASUTEISANTECIP=' + FloatToStr(vNrDiasUteis') + ';
  return(0); exit;

end;

//----------------------------------------------------------
function T_FCRSVCO002.VerFeriado(pParams : String) : String;
//----------------------------------------------------------
const
  cDS_METHOD = 'ADICIONAL=Operação: T_FCRSVCO002.VerFeriado()';
var
  vData : TDate;
  vAno : Real;
begin
  vData := itemXml('DT_DATA', pParams);
  if (vData = '') then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Data não informado!', cDS_METHOD);
    return(-1); exit;
  end;
  vAno := vData[Y];
  clear_e(tGER_FERIADO);
  putitem_e(tGER_FERIADO, 'CD_EMPRESA', itemXmlF('CD_EMPRESA', PARAM_GLB));
  putitem_e(tGER_FERIADO, 'CD_TURNO', 999);
  putitem_e(tGER_FERIADO, 'DT_FERIADO', vData);
  retrieve_e(tGER_FERIADO);
  if (xStatus >= 0) then begin
    Result := 'IN_FERIADO=S';
  end else begin
    Result := 'IN_FERIADO=N';
  end;

  return(0); exit;

end;

end.
