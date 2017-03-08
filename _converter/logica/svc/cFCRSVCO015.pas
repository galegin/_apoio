unit cFCRSVCO015;

interface

(* COMPONENTES 
  ADMSVCO001 / CTCSVCO007 / FCCSVCO002 / FCRSVCO002 / FGRSVCO001
  PEDSVCO004 / PESSVCO010 / 
*)        

uses
  Classes, SysUtils, Math, DB,
  cServiceUnf, cDataSetUnf;

type
  T_FCRSVCO015 = class(TcServiceUnf)
  private
    tFCC_CTAPES,
    tFCR_DOFNI,
    tFCR_FATURAI,
    tFGR_LIQITEMCR,
    tPES_CLIENTEES,
    tPES_COLIGADA,
    tPES_FAMILIAR,
    tPES_LIMITECLI,
    tSIS_MESANO,
    tTMP_DDMMYYYY,
    tTRA_TRANSACAD : TcDatasetUnf;
    function getParam(pParams : String = '') : String;
    function setEntidade(pParams : String = '') : String;
  protected
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;    
  published
    function BuscaLimiteCliente(pParams : String = '') : String;
    function instancehandle->SetStatus(STS_ERROR, xCdErro, xCtxErro, 'ADICIONAL= -> carregaAdiantamento()')(pParams : String = '') : String;
    function BuscaParametro(pParams : String = '') : String;
    function BuscaColigado(pParams : String = '') : String;
    function lerCodigoCliente(pParams : String = '') : String;
    function buscaLimiteComercial(pParams : String = '') : String;
    function buscaLimiteMensal(pParams : String = '') : String;
  end;

implementation

uses
  cADMSVCO001,
  cActivate, cStatus, cFuncao, cXml, dModulo;

var
  gCdClientePDV,
  gCdTpManutCliente,
  gDtMesAno,
  gInFichaCliente,
  gInLimiteColigador,
  glstCob,
  glstDoc,
  glstFat,
  gTpLimiteCliente,
  gvInLimiteClientePool,
  gvInSabadoUtil,
  gvNrDiasCarenciaAtraso,
  gvNrDiasCarenciaMulta,
  gvNrDiasDescPont,
  gvTpAplicacaoJuros : String;

//---------------------------------------------------------------
constructor T_FCRSVCO015.Create(AOwner: TComponent);
//---------------------------------------------------------------
begin
  inherited Create(AOwner);
  setEntidade('');
end;

//--------------------------------
destructor T_FCRSVCO015.Destroy;
//--------------------------------
begin
  inherited Destroy;
end;

//---------------------------------------------------------------
function T_FCRSVCO015.getParam(pParams : String = '') : String;
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
  putitem(xParam, '      putitem(vDsLstFatAberto,  vDsRegistro);');
  putitem(xParam, 'CD_TPMANUT_CLIENTE');
  putitem(xParam, 'CLIENTE_PDV');
  putitem(xParam, 'DS_LST_FATABERTO');
  putitem(xParam, 'DT_FATURA');
  putitem(xParam, 'IN_LIMITE_COLIGADOR');
  putitem(xParam, 'NR_DIAATRASOMEDIO');
  putitem(xParam, 'NR_DIAVENCTO');
  putitem(xParam, 'PR_FAMILIAR');
  putitem(xParam, 'VL_ABERTO');
  putitem(xParam, 'VL_ABERTOFAMILIAR');
  putitem(xParam, 'VL_ADIANT');
  putitem(xParam, 'VL_AVENCER');
  putitem(xParam, 'VL_CHEQUEDEV');
  putitem(xParam, 'VL_CREDEV');
  putitem(xParam, 'VL_DOFNI');
  putitem(xParam, 'VL_FATABERTO');
  putitem(xParam, 'VL_FATCOMJURO');
  putitem(xParam, 'VL_FATSEMJURO');
  putitem(xParam, 'VL_LIMITE');
  putitem(xParam, 'VL_LIMITECARTAO');
  putitem(xParam, 'VL_LIMITEFAMILIAR');
  putitem(xParam, 'VL_RECEBERCHQ');
  putitem(xParam, 'VL_RECEBERFAT');
  putitem(xParam, 'VL_SALDO');
  putitem(xParam, 'VL_SALDODISP');
  putitem(xParam, 'VL_SALDOFAMILIAR');
  putitem(xParam, 'VL_VENCIDO');

  xParam := T_ADMSVCO001.GetParametro(xParam);

  gCdClientePDV := itemXml('CLIENTE_PDV', xParam);
  gCdTpManutCliente := itemXml('CD_TPMANUT_CLIENTE', xParam);
  gInLimiteColigador := itemXml('IN_LIMITE_COLIGADOR', xParam);
  glstCob := itemXml('DS_LST_TPCOB_VALIDAATRASO', xParam);
  glstDoc := itemXml('DS_LST_TPDOC_VALIDAATRASO', xParam);
  glstFat := itemXml('DS_LST_TPFAT_VALIDAATRASO', xParam);
  gTpLimiteCliente := itemXml('TP_LIMITE_CLIENTE', xParam);
  gvInLimiteClientePool := itemXml('IN_LIMITE_CLIENTE_POOL', xParam);
  gvInSabadoUtil := itemXml('IN_SABADO_UTIL', xParam);
  gvNrDiasCarenciaAtraso := itemXml('NR_DIAS_CARENCIA_ATRASO', xParam);
  gvNrDiasCarenciaMulta := itemXml('NR_DIAS_CARENCIA_Multa', xParam);
  gvNrDiasDescPont := itemXml('NR_DIAS_DESC_PONT', xParam);
  gvTpAplicacaoJuros := itemXml('TP_APLICACAO_JUROS', xParam);

  xParamEmp := '';
  putitem(xParamEmp, '      putitem(vDsLstFatAberto,  vDsRegistro);');
  putitem(xParamEmp, 'CD_TPMANUT_CLIENTE');
  putitem(xParamEmp, 'CLIENTE_PDV');
  putitem(xParamEmp, 'DS_LST_FATABERTO');
  putitem(xParamEmp, 'DS_LST_TPCOB_VALIDAATRASO');
  putitem(xParamEmp, 'DS_LST_TPDOC_VALIDAATRASO');
  putitem(xParamEmp, 'DS_LST_TPFAT_VALIDAATRASO');
  putitem(xParamEmp, 'DT_FATURA');
  putitem(xParamEmp, 'IN_LIMITE_CLIENTE_POOL');
  putitem(xParamEmp, 'IN_LIMITE_COLIGADOR');
  putitem(xParamEmp, 'IN_SABADO_UTIL');
  putitem(xParamEmp, 'NR_DIAS_CARENCIA_ATRASO');
  putitem(xParamEmp, 'NR_DIAS_CARENCIA_MULTA');
  putitem(xParamEmp, 'NR_DIAS_DESC_PONT');
  putitem(xParamEmp, 'TP_APLICACAO_JUROS');
  putitem(xParamEmp, 'TP_LIMITE_CLIENTE');
  putitem(xParamEmp, 'VL_FATABERTO');

  xParamEmp := T_ADMSVCO001.GetParamEmpresa(piCdEmpresa, xParamEmp);

  glstCob := itemXml('DS_LST_TPCOB_VALIDAATRASO', xParamEmp);
  glstDoc := itemXml('DS_LST_TPDOC_VALIDAATRASO', xParamEmp);
  glstFat := itemXml('DS_LST_TPFAT_VALIDAATRASO', xParamEmp);
  gTpLimiteCliente := itemXml('TP_LIMITE_CLIENTE', xParamEmp);
  gvInLimiteClientePool := itemXml('IN_LIMITE_CLIENTE_POOL', xParamEmp);
  gvInSabadoUtil := itemXml('IN_SABADO_UTIL', xParamEmp);
  gvNrDiasCarenciaAtraso := itemXml('NR_DIAS_CARENCIA_ATRASO', xParamEmp);
  gvNrDiasCarenciaMulta := itemXml('NR_DIAS_CARENCIA_Multa', xParamEmp);
  gvNrDiasDescPont := itemXml('NR_DIAS_DESC_PONT', xParamEmp);
  gvTpAplicacaoJuros := itemXml('TP_APLICACAO_JUROS', xParamEmp);

end;

//---------------------------------------------------------------
function T_FCRSVCO015.setEntidade(pParams : String = '') : String;
//---------------------------------------------------------------
begin
  tFCC_CTAPES := GetEntidade('FCC_CTAPES');
  tFCR_DOFNI := GetEntidade('FCR_DOFNI');
  tFCR_FATURAI := GetEntidade('FCR_FATURAI');
  tFGR_LIQITEMCR := GetEntidade('FGR_LIQITEMCR');
  tPES_CLIENTEES := GetEntidade('PES_CLIENTEES');
  tPES_COLIGADA := GetEntidade('PES_COLIGADA');
  tPES_FAMILIAR := GetEntidade('PES_FAMILIAR');
  tPES_LIMITECLI := GetEntidade('PES_LIMITECLI');
  tSIS_MESANO := GetEntidade('SIS_MESANO');
  tTMP_DDMMYYYY := GetEntidade('TMP_DDMMYYYY');
  tTRA_TRANSACAD := GetEntidade('TRA_TRANSACAD');
end;

//------------------------------------------------------------------
function T_FCRSVCO015.BuscaLimiteCliente(pParams : String) : String;
//------------------------------------------------------------------
const
  cDS_METHOD = 'ADICIONAL=Operação: T_FCRSVCO015.BuscaLimiteCliente()';
var
  vCdEmpresa, vLst, viParams, voParams, vDsRegistro, vDsLstFatAberto : String;
  vCdCliente, vVlLimite, vVlAberto, vVlSaldo, vVlAdiant, vVlCredev, vVlDofni, vCdFamiliar, vCdEmpLiq : Real;
  vVlVencido, vVlAVencer, vCdColigador, vNrDiaVencto, vNrDia, vVlSaldoDisp, vVlLimiteCartao, vNrSeqLiq : Real;
  vVlFatSemJuro, vVlFatComJuro, vVlReceberFat, vVlReceberChq, vVlChequeDev, vVlJuros, vNrFat, vVlFatAberto : Real;
  vVlLimiteFamiliar, vVlAbertoFamiliar, vVlSaldoFamiliar, vPrLimiteFamiliar, vVlVencTotal, vNrDiasAtrasoMedio : Real;
  viParams, vpiValores, voParams, vLstColigado, vLstPessoa, vLstCdPessoa, vDsComando : String;
  vInTotal : Boolean;
  vDtSistema, vDtLiq, vDtFatura : TDate;
begin
  vDtSistema := itemXml('DT_SISTEMA', PARAM_GLB);
  vCdEmpresa := itemXmlF('CD_EMPRESA', pParams);
  vCdCliente := itemXmlF('CD_CLIENTE', pParams);
  vCdFamiliar := itemXmlF('CD_FAMILIAR', pParams);
  vInTotal := itemXmlB('IN_TOTAL', pParams);
  Result := '';
  vVlLimite := 0;
  vVlAberto := 0;
  vVlSaldo := 0;
  vVlLimiteFamiliar := 0;
  vVlAbertoFamiliar := 0;
  vVlSaldoFamiliar := 0;
  vPrLimiteFamiliar := 0;
  vVlAdiant := 0;
  vVlCredev := 0;
  vVlDofni := 0;
  vVlVencido := 0;
  vVlAVencer := 0;

  gInFichaCliente := itemXmlB('IN_FICHACLIENTE', pParams);

  vVlFatSemJuro := 0;
  vVlFatComJuro := 0;
  vVlReceberFat := 0;
  vVlReceberChq := 0;
  vVlChequeDev := 0;

  voParams := buscaParametro(viParams); (* *)

  if (xStatus < 0) then begin
    return(-1); exit;
  end;
  if (gCdTpManutCliente = '') then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Parâmetro com o código do tipo de manutenção do cliente não cadastrado!', cDS_METHOD);
    return(-1); exit;
  end;
  if (vCdCliente = '') then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Cliente não informado!', cDS_METHOD);
    return(-1); exit;
  end;
  if (vCdCliente = gCdClientePDV) then begin
    return(0); exit;
  end;
  if (itemXml('CD_EMPRESA', pParams) = '') then begin
    if (gTpLimiteCliente = 2) then begin
      viParams := '';
      putitemXml(viParams, 'CD_GRUPOEMPRESA', '>=0and<=9999');
      voParams := activateCmp('FGRSVCO001', 'listarEmpresa', viParams); (*,viParams,voParams,, *)
      if (xStatus < 0) then begin
        Result := voParams;
        return(-1); exit;
      end;
      vCdEmpresa := itemXml('LST_EMPRESA', voParams);
    end;
  end;
  if (itemXml('CD_EMPRESA', pParams) = '') then begin
    if (gTpLimiteCliente = 1) then begin
      vCdEmpresa := gModulo.gCdEmpresa;

      viParams := '';
      putitemXml(viParams, 'CD_GRUPOEMPRESA', itemXmlF('CD_GRUPOEMPRESA', PARAM_GLB));
      voParams := activateCmp('FGRSVCO001', 'listarEmpresa', viParams); (*,viParams,voParams,, *)
      if (xStatus < 0) then begin
        Result := voParams;
        return(-1); exit;
      end;
      vCdEmpresa := itemXml('LST_EMPRESA', voParams);

    end;
  end;

  vCdColigador := '';
  vLstColigado := '';
  if (gInLimiteColigador = True) then begin
    viParams := '';
    putitemXml(viParams, 'CD_PESSOA', vCdCliente);
    voParams := activateCmp('PESSVCO010', 'BuscaColigado', viParams); (*,viParams,voParams,, *)
    if (xStatus < 0) then begin
      Result := voParams;
      return(-1); exit;
    end;
    vCdColigador := itemXmlF('CD_COLIGADOR', voParams);
    vLstColigado := itemXml('DS_LSTCOLIGADO', voParams);
  end;

  clear_e(tPES_CLIENTEES);
  putitem_e(tPES_CLIENTEES, 'CD_EMPRESA', vCdEmpresa);
  putitem_e(tPES_CLIENTEES, 'CD_CLIENTE', vCdCliente);
  if (vCdColigador <> '') then begin
    putitem_e(tPES_CLIENTEES, 'CD_CLIENTE', vCdColigador);
  end;
  retrieve_e(tPES_CLIENTEES);
  if (xStatus >= 0) then begin
    setocc(tPES_CLIENTEES, 1);
    while (xStatus >= 0) do begin
      vVlLimite := vVlLimite + item_f('VL_FATORLIMITE', tPES_CLIENTEES);
      setocc(tPES_CLIENTEES, curocc(tPES_CLIENTEES) + 1);
    end;
  end;

  vNrDiaVencto := 0;

  if (vLstColigado <> '') then begin
    vLstPessoa := vLstColigado;
  end else begin
    vLstPessoa := vCdCliente;
  end;

  repeat
    voParams := lerCodigoCliente(viParams); (* vLstPessoa, vLstCdPessoa *)
    if (xStatus < 0) then begin
      Result := voParams;
      return(-1); exit;
    end;

    clear_e(tFCR_FATURAI);
    putitem_e(tFCR_FATURAI, 'CD_EMPRESA', vCdEmpresa);
    putitem_e(tFCR_FATURAI, 'CD_CLIENTE', vLstCdPessoa);
    putitem_e(tFCR_FATURAI, 'TP_SITUACAO', 1);

    if (glstDoc = '') then begin
      putitem_e(tFCR_FATURAI, 'TP_DOCUMENTO', '!= 11');
    end else begin
      voParams := SeparaItemLista(viParams); (* glstDoc, vLst *)
      if (xStatus < 0) then begin
        Result := voParams;
        return(-1); exit;
      end;

      putitem_e(tFCR_FATURAI, 'TP_DOCUMENTO', vLst);
    end;
    if (glstCob <> '') then begin
      voParams := SeparaItemLista(viParams); (* glstCob, vLst *)
      if (xStatus < 0) then begin
        Result := voParams;
        return(-1); exit;
      end;

      putitem_e(tFCR_FATURAI, 'TP_COBRANCA', vLst);
    end;
    if (glstFat <> '') then begin
      voParams := SeparaItemLista(viParams); (* glstFat, vLst *)
      if (xStatus < 0) then begin
        Result := voParams;
        return(-1); exit;
      end;

      putitem_e(tFCR_FATURAI, 'TP_FATURAMENTO', vLst);
    end;

    putitem_e(tFCR_FATURAI, 'DT_LIQ', '=');
    putitem_e(tFCR_FATURAI, 'TP_BAIXA', 0);

    if (gInFichaCliente = True) then begin
      putitem_e(tFCR_FATURAI, 'TP_DOCUMENTO', '1);
    end;

    retrieve_e(tFCR_FATURAI);
    if (xStatus >= 0) then begin
      setocc(tFCR_FATURAI, 1);
      while (xStatus >= 0) do begin
        vVlAberto := vVlAberto + item_f('VL_FATURA', tFCR_FATURAI) - item_f('VL_ABATIMENTO', tFCR_FATURAI);

        vVlFatAberto := '';
        vVlFatAberto := vVlFatAberto + item_f('VL_FATURA', tFCR_FATURAI) - item_f('VL_ABATIMENTO', tFCR_FATURAI);
        vDtFatura := '01/' + DT_VENCIMENTO + '.FCR_FATURAI[m]/' + DT_VENCIMENTO + '.FCR_FATURAI[Y]';
        creocc(tTMP_DDMMYYYY, -1);
        putitem_e(tTMP_DDMMYYYY, 'DT_GERAL', vDtFatura);
        retrieve_o(tTMP_DDMMYYYY);
        if (xStatus = -7) then begin
          retrieve_x(tTMP_DDMMYYYY);
        end;

        putitem_e(tTMP_DDMMYYYY, 'VL_FATABERTO', item_f('VL_FATABERTO', tTMP_DDMMYYYY) + vVlFatAberto);

        if (vCdFamiliar <> 0) then begin
          clear_e(tFGR_LIQITEMCR);
          putitem_e(tFGR_LIQITEMCR, 'CD_EMPFAT', item_f('CD_EMPRESA', tFCR_FATURAI));
          putitem_e(tFGR_LIQITEMCR, 'CD_CLIENTE', item_f('CD_CLIENTE', tFCR_FATURAI));
          putitem_e(tFGR_LIQITEMCR, 'NR_FAT', item_f('NR_FAT', tFCR_FATURAI));
          putitem_e(tFGR_LIQITEMCR, 'NR_PARCELA', item_f('NR_PARCELA', tFCR_FATURAI));
          putitem_e(tFGR_LIQITEMCR, 'TP_TIPOREG', 2);
          retrieve_e(tFGR_LIQITEMCR);
          if (xStatus >= 0) then begin
            vCdEmpLiq := item_f('CD_EMPLIQ', tFGR_LIQITEMCR);
            vDtLiq := item_a('DT_LIQ', tFGR_LIQITEMCR);
            vNrSeqLiq := item_f('NR_SEQLIQ', tFGR_LIQITEMCR);

            clear_e(tFGR_LIQITEMCR);
            putitem_e(tFGR_LIQITEMCR, 'CD_EMPLIQ', vCdEmpLiq);
            putitem_e(tFGR_LIQITEMCR, 'DT_LIQ', vDtLiq);
            putitem_e(tFGR_LIQITEMCR, 'NR_SEQLIQ', vNrSeqLiq);
            putitem_e(tFGR_LIQITEMCR, 'TP_TIPOREG', 1);
            retrieve_e(tFGR_LIQITEMCR);
            if (xStatus >= 0) then begin
              setocc(tFGR_LIQITEMCR, 1);
              while (xStatus >= 0) do begin
                if (item_f('NR_TRANSACAO', tFGR_LIQITEMCR) <> 0) then begin
                  clear_e(tTRA_TRANSACAD);
                  putitem_e(tTRA_TRANSACAD, 'CD_EMPRESA', item_f('CD_EMPTRANSACAO', tFGR_LIQITEMCR));
                  putitem_e(tTRA_TRANSACAD, 'DT_TRANSACAO', item_a('DT_TRANSACAO', tFGR_LIQITEMCR));
                  putitem_e(tTRA_TRANSACAD, 'NR_TRANSACAO', item_f('NR_TRANSACAO', tFGR_LIQITEMCR));
                  retrieve_e(tTRA_TRANSACAD);
                  if (xStatus >= 0)  and (item_f('CD_FAMILIAR', tTRA_TRANSACAD) = vCdFamiliar) then begin
                    vVlAbertoFamiliar := vVlAbertoFamiliar + item_f('VL_FATURA', tFCR_FATURAI) - item_f('VL_ABATIMENTO', tFCR_FATURAI);

                    break;
                  end;
                end;

                setocc(tFGR_LIQITEMCR, curocc(tFGR_LIQITEMCR) + 1);
              end;
            end;
          end;
        end;
        if (item_a('DT_VENCIMENTO', tFCR_FATURAI) >= vDtSistema) then begin
          vVlAVencer := vVlAVencer + item_f('VL_FATURA', tFCR_FATURAI) - item_f('VL_ABATIMENTO', tFCR_FATURAI);
        end else begin
          vVlVencido := vVlVencido + item_f('VL_FATURA', tFCR_FATURAI) - item_f('VL_ABATIMENTO', tFCR_FATURAI);

          vVlVencTotal := vVlVencTotal + ((item_f('VL_FATURA', tFCR_FATURAI) - item_f('VL_ABATIMENTO', tFCR_FATURAI)) * (vDtSistema - item_a('DT_VENCIMENTO', tFCR_FATURAI)));

          vNrDia := vDtSistema - item_a('DT_VENCIMENTO', tFCR_FATURAI);
          if (vNrDia > vNrDiaVencto) then begin
            vNrDiaVencto := vNrDia;
          end;
        end;
        if (gInFichaCliente = True) then begin
          if (item_f('TP_DOCUMENTO', tFCR_FATURAI) = 1) then begin
            vVlReceberFat := vVlReceberFat + item_f('VL_FATURA', tFCR_FATURAI) - item_f('VL_ABATIMENTO', tFCR_FATURAI);

            if (item_a('DT_VENCIMENTO', tFCR_FATURAI) < vDtSistema) then begin
              vVlFatSemJuro := vVlFatSemJuro + item_f('VL_FATURA', tFCR_FATURAI) - item_f('VL_ABATIMENTO', tFCR_FATURAI);

              viParams := '';
              putlistitensocc_e(viParams, tFCR_FATURAI);
              putitemXml(viParams, 'IN_SABADOUTIL', gvInSabadoUtil);
              putitemXml(viParams, 'NR_DIASCARENCIAATRASO', gvNrDiasCarenciaAtraso);
              putitemXml(viParams, 'NR_DIASCARENCIAMULTA', gvNrDiasCarenciaMulta);
              putitemXml(viParams, 'NR_DIASDESCPONT', gvNrDiasDescPont);
              putitemXml(viParams, 'TP_APLICACAOJUROS', gvTpAplicacaoJuros);
              if (item_a('DT_LIQ', tFCR_FATURAI) <> '') then begin
                putitemXml(viParams, 'DT_PAGAMENTO', item_a('DT_LIQ', tFCR_FATURAI));
              end else begin
                putitemXml(viParams, 'DT_PAGAMENTO', vDtSistema);
              end;
              voParams := activateCmp('FCRSVCO002', 'CalcVlFat', viParams); (*,viParams,voParams,, *)
              if (xStatus < 0) then begin
                Result := voParams;
                return(-1); exit;
              end;
              vVlFatComJuro := vVlFatComJuro + itemXmlF('VL_CALCULADO', voParams);

            end;
          end;
          if (item_f('TP_DOCUMENTO', tFCR_FATURAI) = 2) then begin
            vVlReceberChq := vVlReceberChq + item_f('VL_FATURA', tFCR_FATURAI);

            vNrFat := item_f('NR_FAT', tFCR_FATURAI);
            vDsComando := 'select count(*) from FCR_CHEQUE';
            vDsComando := '' + vDsComando + ' where CD_EMPRESA := ' + CD_EMPRESA + '.FCR_FATURAI';
            vDsComando := '' + vDsComando + ' ) and (CD_CLIENTE := ' + CD_CLIENTE + '.FCR_FATURAI';
            vDsComando := '' + vDsComando + ' ) and (NR_FAT := ' + FloatToStr(vNrFat') + ';
            vDsComando := '' + vDsComando + ' ) and (NR_PARCELA := ' + NR_PARCELA + '.FCR_FATURAI';
            vDsComando := '' + vDsComando + '  and (DT_DEVOLUCAO1 is not null ) or (DT_DEVOLUCAO2 is not null)';

            sql vDsComando, 'DEF';
            if (gresult > 0) then begin
              vVlChequeDev := vVlChequeDev + item_f('VL_FATURA', tFCR_FATURAI);
            end;
          end;
        end;

        setocc(tFCR_FATURAI, curocc(tFCR_FATURAI) + 1);
      end;
      if (vVlVencTotal > 0) then begin
        vNrDiasAtrasoMedio := vVlVencTotal / vVlVencido;
        vNrDiasAtrasoMedio := roundto(vNrDiasAtrasoMedio, 1);
      end;
    end;

  until (vLstPessoa = '');

  if (vLstColigado <> '') then begin
    vLstPessoa := vLstColigado;
  end else begin
    vLstPessoa := vCdCliente;
  end;

  repeat
    voParams := lerCodigoCliente(viParams); (* vLstPessoa, vLstCdPessoa *)
    if (xStatus < 0) then begin
      Result := voParams;
      return(-1); exit;
    end;

    clear_e(tFCC_CTAPES);
    putitem_e(tFCC_CTAPES, 'CD_PESSOA', vLstCdPessoa);
    putitem_e(tFCC_CTAPES, 'CD_EMPRESA', vCdEmpresa);
    putitem_e(tFCC_CTAPES, 'TP_MANUTENCAO', gCdTpManutCliente);
    retrieve_e(tFCC_CTAPES);
    if (xStatus >= 0) then begin
      setocc(tFCC_CTAPES, 1);
      while (xStatus >= 0) do begin
        viParams := '';
        putitemXml(viParams, 'NR_CTAPES', item_f('NR_CTAPES', tFCC_CTAPES));
        putitemXml(viParams, 'TP_DOCUMENTO', 10);
        putitemXml(viParams, 'NR_SEQHISTRELSUB', 1);
        putitemXml(viParams, 'DT_SALDO', itemXml('DT_SISTEMA', PARAM_GLB));
        voParams := activateCmp('FCCSVCO002', 'buscaSaldoCtaTp', viParams); (*,viParams,vpiValores,voParams,, *)
        if (xStatus < 0) then begin
          Result := voParams;
          return(-1); exit;
        end;

        vVlAdiant := vVlAdiant + itemXmlF('VL_SALDO', voParams);

        viParams := '';
        putitemXml(viParams, 'NR_CTAPES', item_f('NR_CTAPES', tFCC_CTAPES));
        putitemXml(viParams, 'TP_DOCUMENTO', 20);
        putitemXml(viParams, 'NR_SEQHISTRELSUB', 1);
        putitemXml(viParams, 'DT_SALDO', itemXml('DT_SISTEMA', PARAM_GLB));
        voParams := activateCmp('FCCSVCO002', 'buscaSaldoCtaTp', viParams); (*,viParams,vpiValores,voParams,, *)
        if (xStatus < 0) then begin
          Result := voParams;
          return(-1); exit;
        end;

        vVlCredev := vVlCredev + itemXmlF('VL_SALDO', voParams);
        setocc(tFCC_CTAPES, curocc(tFCC_CTAPES) + 1);
      end;
    end;

  until (vLstPessoa = '');

  if (vLstColigado <> '') then begin
    vLstPessoa := vLstColigado;
  end else begin
    vLstPessoa := vCdCliente;
  end;

  repeat
    voParams := lerCodigoCliente(viParams); (* vLstPessoa, vLstCdPessoa *)
    if (xStatus < 0) then begin
      Result := voParams;
      return(-1); exit;
    end;

    clear_e(tFCR_DOFNI);
    putitem_e(tFCR_DOFNI, 'CD_EMPDOFNI', vCdEmpresa);
    putitem_e(tFCR_DOFNI, 'CD_PESSOA', vLstCdPessoa);
    putitem_e(tFCR_DOFNI, 'IN_ABERTO', True);
    putitem_e(tFCR_DOFNI, 'TP_BAIXA', '!=9');

    retrieve_e(tFCR_DOFNI);
    if (xStatus >= 0) then begin
      setocc(tFCR_DOFNI, 1);
      while (xStatus >= 0) do begin
        if (item_f('TP_CREDITODEBITO', tFCR_DOFNI) = 1) then begin
          vVlDofni := vVlDofni + item_f('VL_DOCUMENTO', tFCR_DOFNI);
        end;
        setocc(tFCR_DOFNI, curocc(tFCR_DOFNI) + 1);
      end;
    end;

  until (vLstPessoa = '');

  vVlSaldo := vVlLimite + vVlAdiant + vVlCredev + vVlDofni - vVlAberto;

  if (vCdFamiliar <> 0) then begin
    clear_e(tPES_FAMILIAR);
    putitem_e(tPES_FAMILIAR, 'CD_PESSOA', vCdCliente);
    putitem_e(tPES_FAMILIAR, 'CD_PARENTE', vCdFamiliar);
    retrieve_e(tPES_FAMILIAR);
    if (xStatus >= 0) then begin
      vPrLimiteFamiliar := item_f('PR_LIMITE', tPES_FAMILIAR);

      if (vPrLimiteFamiliar = 0) then begin
        vVlLimiteFamiliar := vVlLimite;
      end else begin
        vVlLimiteFamiliar := vVlLimite * vPrLimiteFamiliar / 100;
      end;

      vVlSaldoFamiliar := vVlLimiteFamiliar - vVlAbertoFamiliar;
    end;
  end;

  viParams := '';

  vVlSaldoDisp := 0;
  vVlLimiteCartao := 0;

  if (vLstColigado <> '') then begin
    putitemXml(viParams, 'CD_CLIENTE', vLstColigado);
  end else begin
    putitemXml(viParams, 'CD_CLIENTE', vCdCliente);
  end;
  putitemXml(viParams, 'CD_EMPRESA', vCdEmpresa);

  voParams := activateCmp('CTCSVCO007', 'buscaLimiteCartao', viParams); (*,viParams,voParams,, *)
  if (xStatus < 0) then begin
    Result := voParams;
    return(-1); exit;
  end;
  if (voParams <> '') then begin
    vVlSaldoDisp := itemXmlF('VL_SALDODISP', voParams);
    vVlLimiteCartao := itemXml('vVlLimiteCartao', voParams);
  end;

  putitemXml(Result, 'VL_LIMITE', vVlLimite);
  putitemXml(Result, 'VL_ABERTO', vVlAberto);
  putitemXml(Result, 'VL_SALDO', vVlSaldo);
  putitemXml(Result, 'VL_ADIANT', vVlAdiant);
  putitemXml(Result, 'VL_CREDEV', vVlCredev);
  putitemXml(Result, 'VL_DOFNI', vVlDofni);
  putitemXml(Result, 'VL_VENCIDO', vVlVencido);
  putitemXml(Result, 'VL_AVENCER', vVlAVencer);
  putitemXml(Result, 'VL_LIMITEFAMILIAR', vVlLimiteFamiliar);
  putitemXml(Result, 'VL_ABERTOFAMILIAR', vVlAbertoFamiliar);
  putitemXml(Result, 'VL_SALDOFAMILIAR', vVlSaldoFamiliar);
  putitemXml(Result, 'PR_FAMILIAR', vPrLimiteFamiliar);
  putitemXml(Result, 'NR_DIAVENCTO', vNrDiaVencto);
  putitemXml(Result, 'VL_SALDODISP', vVlSaldoDisp);
  putitemXml(Result, 'VL_LIMITECARTAO', vVlLimiteCartao);
  putitemXml(Result, 'VL_FATSEMJURO', vVlFatSemJuro);
  putitemXml(Result, 'VL_FATCOMJURO', vVlFatComJuro);
  putitemXml(Result, 'VL_RECEBERFAT', vVlReceberFat);
  putitemXml(Result, 'VL_RECEBERCHQ', vVlReceberChq);
  putitemXml(Result, 'VL_CHEQUEDEV', vVlChequeDev);
  putitemXml(Result, 'NR_DIAATRASOMEDIO', vNrDiasAtrasoMedio);

  if not (empty(tTMP_DDMMYYYY)) then begin
    setocc(tTMP_DDMMYYYY, 1);
    while(xStatus >= 0) do begin
      putitemXml(vDsRegistro, 'DT_FATURA', item_a('DT_GERAL', tTMP_DDMMYYYY));
      putitemXml(vDsRegistro, 'VL_FATABERTO', item_f('VL_FATABERTO', tTMP_DDMMYYYY));
      putitem(vDsLstFatAberto,  vDsRegistro);
      setocc(tTMP_DDMMYYYY, curocc(tTMP_DDMMYYYY) + 1);
    end;
  end;
  putitemXml(Result, 'DS_LST_FATABERTO', vDsLstFatAberto);

  return(0); exit;
end;

//--------------------------------------------------------------
function T_FCRSVCO015.BuscaParametro(pParams : String) : String;
//--------------------------------------------------------------
const
  cDS_METHOD = 'ADICIONAL=Operação: T_FCRSVCO015.BuscaParametro()';
begin
  viParams := '';
  putitem(viParams,  'CD_TPMANUT_CLIENTE');
  putitem(viParams,  'IN_LIMITE_COLIGADOR');
  putitem(viParams,  'CLIENTE_PDV');

  xParam := T_ADMSVCO001.GetParametro(xParam); (*viParams,voParams,, *)
    return(-1); exit;
  end;

  gCdTpManutCliente := itemXmlF('CD_TPMANUT_CLIENTE', voParams);
  gInLimiteColigador := itemXmlB('IN_LIMITE_COLIGADOR', voParams);

  gCdClientePDV := itemXml('CLIENTE_PDV', voParams);

  viParams := '';
  putitem(viParams,  'IN_LIMITE_CLIENTE_POOL');
  putitem(viParams,  'TP_LIMITE_CLIENTE');
  putitem(viParams,  'DS_LST_TPDOC_VALIDAATRASO');
  putitem(viParams,  'DS_LST_TPCOB_VALIDAATRASO');
  putitem(viParams,  'DS_LST_TPFAT_VALIDAATRASO');

  if (gInFichaCliente = True) then begin
    putitem(viParams,  'IN_SABADO_UTIL');
    putitem(viParams,  'NR_DIAS_CARENCIA_ATRASO');
    putitem(viParams,  'NR_DIAS_CARENCIA_MULTA');
    putitem(viParams,  'NR_DIAS_DESC_PONT');
    putitem(viParams,  'TP_APLICACAO_JUROS');
  end;

  xParamEmp := T_ADMSVCO001.GetParamEmpresa(piCdEmpresa, xParamEmp); (*itemXml('CD_EMPRESA', *)
  gvInLimiteClientePool := itemXmlB('IN_LIMITE_CLIENTE_POOL', voParams);

  gTpLimiteCliente := itemXmlF('TP_LIMITE_CLIENTE', voParams);

  glstDoc := itemXml('DS_LST_TPDOC_VALIDAATRASO', voParams);
  glstCob := itemXml('DS_LST_TPCOB_VALIDAATRASO', voParams);
  glstFat := itemXml('DS_LST_TPFAT_VALIDAATRASO', voParams);

  if (gInFichaCliente = True) then begin
    gvInSabadoUtil := itemXmlB('IN_SABADO_UTIL', voParams);
    gvNrDiasCarenciaAtraso := itemXmlF('NR_DIAS_CARENCIA_ATRASO', voParams);
    gvNrDiasCarenciaMulta := itemXmlF('NR_DIAS_CARENCIA_Multa', voParams);
    gvNrDiasDescPont := itemXmlF('NR_DIAS_DESC_PONT', voParams);
    gvTpAplicacaoJuros := itemXmlF('TP_APLICACAO_JUROS', voParams);
  end;

  return(0); exit;
end;

//-------------------------------------------------------------
function T_FCRSVCO015.BuscaColigado(pParams : String) : String;
//-------------------------------------------------------------
const
  cDS_METHOD = 'ADICIONAL=Operação: T_FCRSVCO015.BuscaColigado()';
var
  vCdColigador,vCdPessoa : Real;
  vLstColigado : String;
begin
  vCdPessoa := itemXmlF('CD_PESSOA', pParams);

  clear_e(tPES_COLIGADA);
  putitem_e(tPES_COLIGADA, 'CD_PESSOA', vCdPessoa);
  retrieve_e(tPES_COLIGADA);
  if (xStatus >= 0) then begin
    putitemXml(Result, 'CD_COLIGADOR', item_f('CD_PESSOA', tPES_COLIGADA));
    vLstColigado := item_f('CD_PESSOA', tPES_COLIGADA);
    setocc(tPES_COLIGADA, 1);
    while (xStatus >= 0) do begin
      vLstColigado := '' + vLstColigadoor' + CD_COLIGADO + ' + '.PES_COLIGADA';
      setocc(tPES_COLIGADA, curocc(tPES_COLIGADA) + 1);
    end;
    putitemXml(Result, 'CD_PESSOA', vLstcoligado);
  end else begin

    clear_e(tPES_COLIGADA);
    putitem_e(tPES_COLIGADA, 'CD_COLIGADO', vCdPessoa);
    retrieve_e(tPES_COLIGADA);
    if (xStatus >= 0) then begin
      putitemXml(Result, 'CD_COLIGADOR', item_f('CD_PESSOA', tPES_COLIGADA));
      vLstColigado := item_f('CD_PESSOA', tPES_COLIGADA);
      clear_e(tPES_COLIGADA);
      putitem_e(tPES_COLIGADA, 'CD_PESSOA', vLstColigado);
      retrieve_e(tPES_COLIGADA);
      if (xStatus >= 0) then begin
        setocc(tPES_COLIGADA, 1);
        while (xStatus >= 0) do begin
          vLstColigado := '' + vLstColigadoor' + CD_COLIGADO + ' + '.PES_COLIGADA';
          setocc(tPES_COLIGADA, curocc(tPES_COLIGADA) + 1);
        end;
        putitemXml(Result, 'CD_PESSOA', vLstcoligado);
      end;
    end;
  end;

  return(0); exit;
end;

//----------------------------------------------------------------
function T_FCRSVCO015.lerCodigoCliente(pParams : String) : String;
//----------------------------------------------------------------
const
  cDS_METHOD = 'ADICIONAL=Operação: T_FCRSVCO015.lerCodigoCliente()';
var
  (* string piCodigoEntrada : INOUT / string poCodigoSaida : OUT *)
  vCdPessoa, vCont : Real;
begin
  poCodigoSaida := '';

  vCont := 0;

  if (piCodigoEntrada <> '') then begin
    repeat
      getitem(vCdPessoa, piCodigoEntrada, 1);

      putitem(poCodigoSaida,  vCdPessoa);

      vCont := vCont + 1;

      delitem(piCodigoEntrada, 1);
    until (piCodigoEntrada := '' ) or (vCont := 50);
  end;

  return(0); exit;
end;

//--------------------------------------------------------------------
function T_FCRSVCO015.buscaLimiteComercial(pParams : String) : String;
//--------------------------------------------------------------------
const
  cDS_METHOD = 'ADICIONAL=Operação: T_FCRSVCO015.buscaLimiteComercial()';
var
  vCdEmpresa, vLst, viParams, voParams : String;
  vCdCliente, vVlLimite, vVlAberto, vVlSaldo, vVlAdiant, vVlCredev, vVlDofni, vCdFamiliar, vCdEmpLiq : Real;
  vVlVencido, vVlAVencer, vCdColigador, vNrDiaVencto, vNrDia, vVlSaldoDisp, vVlLimiteCartao, vNrSeqLiq : Real;
  vVlFatSemJuro, vVlFatComJuro, vVlReceberFat, vVlReceberChq, vVlChequeDev, vVlJuros, vNrFat : Real;
  vVlLimiteFamiliar, vVlAbertoFamiliar, vVlSaldoFamiliar, vPrLimiteFamiliar, vVlVencTotal, vNrDiasAtrasoMedio, vVlPedPend : Real;
  viParams, vpiValores, voParams, vLstColigado, vLstPessoa, vLstCdPessoa, vDsComando : String;
  vInTotal : Boolean;
  vDtSistema, vDtLiq : TDate;
begin
  vDtSistema := itemXml('DT_SISTEMA', PARAM_GLB);
  vCdEmpresa := itemXmlF('CD_EMPRESA', pParams);
  vCdCliente := itemXmlF('CD_CLIENTE', pParams);
  vCdFamiliar := itemXmlF('CD_FAMILIAR', pParams);
  vInTotal := itemXmlB('IN_TOTAL', pParams);
  Result := '';
  vVlLimite := 0;
  vVlAberto := 0;
  vVlSaldo := 0;
  vVlLimiteFamiliar := 0;
  vVlAbertoFamiliar := 0;
  vVlSaldoFamiliar := 0;
  vPrLimiteFamiliar := 0;
  vVlAdiant := 0;
  vVlCredev := 0;
  vVlDofni := 0;
  vVlVencido := 0;
  vVlAVencer := 0;
  vVlPedPend := 0;

  gInFichaCliente := itemXmlB('IN_FICHACLIENTE', pParams);

  vVlFatSemJuro := 0;
  vVlFatComJuro := 0;
  vVlReceberFat := 0;
  vVlReceberChq := 0;
  vVlChequeDev := 0;

  voParams := buscaParametro(viParams); (* *)

  if (xStatus < 0) then begin
    return(-1); exit;
  end;
  if (gCdTpManutCliente = '') then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Parâmetro com o código do tipo de manutenção do cliente não cadastrado!', cDS_METHOD);
    return(-1); exit;
  end;
  if (vCdCliente = '') then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Cliente não informado!', cDS_METHOD);
    return(-1); exit;
  end;
  if (vCdCliente = gCdClientePDV) then begin
    return(0); exit;
  end;
  if (itemXml('CD_EMPRESA', pParams) = '') then begin
    if (gTpLimiteCliente = 2) then begin
      viParams := '';
      putitemXml(viParams, 'CD_GRUPOEMPRESA', '>=0and<=9999');
      voParams := activateCmp('FGRSVCO001', 'listarEmpresa', viParams); (*,viParams,voParams,, *)
      if (xStatus < 0) then begin
        Result := voParams;
        return(-1); exit;
      end;
      vCdEmpresa := itemXml('LST_EMPRESA', voParams);
    end;
  end;
  if (itemXml('CD_EMPRESA', pParams) = '') then begin
    if (gTpLimiteCliente = 1) then begin
      vCdEmpresa := gModulo.gCdEmpresa;

      viParams := '';
      putitemXml(viParams, 'CD_GRUPOEMPRESA', itemXmlF('CD_GRUPOEMPRESA', PARAM_GLB));
      voParams := activateCmp('FGRSVCO001', 'listarEmpresa', viParams); (*,viParams,voParams,, *)
      if (xStatus < 0) then begin
        Result := voParams;
        return(-1); exit;
      end;
      vCdEmpresa := itemXml('LST_EMPRESA', voParams);

    end;
  end;

  vCdColigador := '';
  vLstColigado := '';
  if (gInLimiteColigador = True) then begin
    viParams := '';
    putitemXml(viParams, 'CD_PESSOA', vCdCliente);
    voParams := activateCmp('PESSVCO010', 'BuscaColigado', viParams); (*,viParams,voParams,, *)
    if (xStatus < 0) then begin
      Result := voParams;
      return(-1); exit;
    end;
    vCdColigador := itemXmlF('CD_COLIGADOR', voParams);
    vLstColigado := itemXml('DS_LSTCOLIGADO', voParams);
  end;

  clear_e(tPES_LIMITECLI);
  putitem_e(tPES_LIMITECLI, 'CD_EMPRESA', vCdEmpresa);
  putitem_e(tPES_LIMITECLI, 'CD_CLIENTE', vCdCliente);
  if (vCdColigador <> '') then begin
    putitem_e(tPES_LIMITECLI, 'CD_CLIENTE', vCdColigador);
  end;
  retrieve_e(tPES_LIMITECLI);
  if (xStatus >= 0) then begin
    setocc(tPES_LIMITECLI, 1);
    while (xStatus >= 0) do begin
      vVlLimite := vVlLimite + item_f('VL_LIMITECOM', tPES_LIMITECLI);
      setocc(tPES_LIMITECLI, curocc(tPES_LIMITECLI) + 1);
    end;
  end;

  vNrDiaVencto := 0;

  if (vLstColigado <> '') then begin
    vLstPessoa := vLstColigado;
  end else begin
    vLstPessoa := vCdCliente;
  end;

  repeat
    voParams := lerCodigoCliente(viParams); (* vLstPessoa, vLstCdPessoa *)
    if (xStatus < 0) then begin
      Result := voParams;
      return(-1); exit;
    end;

    clear_e(tFCR_FATURAI);
    putitem_e(tFCR_FATURAI, 'CD_EMPRESA', vCdEmpresa);
    putitem_e(tFCR_FATURAI, 'CD_CLIENTE', vLstCdPessoa);
    putitem_e(tFCR_FATURAI, 'TP_SITUACAO', 1);

    if (glstDoc = '') then begin
      putitem_e(tFCR_FATURAI, 'TP_DOCUMENTO', '!= 11');
    end else begin
      voParams := SeparaItemLista(viParams); (* glstDoc, vLst *)
      if (xStatus < 0) then begin
        Result := voParams;
        return(-1); exit;
      end;

      putitem_e(tFCR_FATURAI, 'TP_DOCUMENTO', vLst);
    end;
    if (glstCob <> '') then begin
      voParams := SeparaItemLista(viParams); (* glstCob, vLst *)
      if (xStatus < 0) then begin
        Result := voParams;
        return(-1); exit;
      end;

      putitem_e(tFCR_FATURAI, 'TP_COBRANCA', vLst);
    end;
    if (glstFat <> '') then begin
      voParams := SeparaItemLista(viParams); (* glstFat, vLst *)
      if (xStatus < 0) then begin
        Result := voParams;
        return(-1); exit;
      end;

      putitem_e(tFCR_FATURAI, 'TP_FATURAMENTO', vLst);
    end;

    putitem_e(tFCR_FATURAI, 'DT_LIQ', '=');
    putitem_e(tFCR_FATURAI, 'TP_BAIXA', 0);

    if (gInFichaCliente = True) then begin
      putitem_e(tFCR_FATURAI, 'TP_DOCUMENTO', '1);
    end;

    retrieve_e(tFCR_FATURAI);
    if (xStatus >= 0) then begin
      setocc(tFCR_FATURAI, 1);
      while (xStatus >= 0) do begin
        vVlAberto := vVlAberto + item_f('VL_FATURA', tFCR_FATURAI) - item_f('VL_ABATIMENTO', tFCR_FATURAI);

        if (vCdFamiliar <> 0) then begin
          clear_e(tFGR_LIQITEMCR);
          putitem_e(tFGR_LIQITEMCR, 'CD_EMPFAT', item_f('CD_EMPRESA', tFCR_FATURAI));
          putitem_e(tFGR_LIQITEMCR, 'CD_CLIENTE', item_f('CD_CLIENTE', tFCR_FATURAI));
          putitem_e(tFGR_LIQITEMCR, 'NR_FAT', item_f('NR_FAT', tFCR_FATURAI));
          putitem_e(tFGR_LIQITEMCR, 'NR_PARCELA', item_f('NR_PARCELA', tFCR_FATURAI));
          putitem_e(tFGR_LIQITEMCR, 'TP_TIPOREG', 2);
          retrieve_e(tFGR_LIQITEMCR);
          if (xStatus >= 0) then begin
            vCdEmpLiq := item_f('CD_EMPLIQ', tFGR_LIQITEMCR);
            vDtLiq := item_a('DT_LIQ', tFGR_LIQITEMCR);
            vNrSeqLiq := item_f('NR_SEQLIQ', tFGR_LIQITEMCR);

            clear_e(tFGR_LIQITEMCR);
            putitem_e(tFGR_LIQITEMCR, 'CD_EMPLIQ', vCdEmpLiq);
            putitem_e(tFGR_LIQITEMCR, 'DT_LIQ', vDtLiq);
            putitem_e(tFGR_LIQITEMCR, 'NR_SEQLIQ', vNrSeqLiq);
            putitem_e(tFGR_LIQITEMCR, 'TP_TIPOREG', 1);
            retrieve_e(tFGR_LIQITEMCR);
            if (xStatus >= 0) then begin
              setocc(tFGR_LIQITEMCR, 1);
              while (xStatus >= 0) do begin
                if (item_f('NR_TRANSACAO', tFGR_LIQITEMCR) <> 0) then begin
                  clear_e(tTRA_TRANSACAD);
                  putitem_e(tTRA_TRANSACAD, 'CD_EMPRESA', item_f('CD_EMPTRANSACAO', tFGR_LIQITEMCR));
                  putitem_e(tTRA_TRANSACAD, 'DT_TRANSACAO', item_a('DT_TRANSACAO', tFGR_LIQITEMCR));
                  putitem_e(tTRA_TRANSACAD, 'NR_TRANSACAO', item_f('NR_TRANSACAO', tFGR_LIQITEMCR));
                  retrieve_e(tTRA_TRANSACAD);
                  if (xStatus >= 0)  and (item_f('CD_FAMILIAR', tTRA_TRANSACAD) = vCdFamiliar) then begin
                    vVlAbertoFamiliar := vVlAbertoFamiliar + item_f('VL_FATURA', tFCR_FATURAI) - item_f('VL_ABATIMENTO', tFCR_FATURAI);

                    break;
                  end;
                end;

                setocc(tFGR_LIQITEMCR, curocc(tFGR_LIQITEMCR) + 1);
              end;
            end;
          end;
        end;
        if (item_a('DT_VENCIMENTO', tFCR_FATURAI) >= vDtSistema) then begin
          vVlAVencer := vVlAVencer + item_f('VL_FATURA', tFCR_FATURAI) - item_f('VL_ABATIMENTO', tFCR_FATURAI);
        end else begin
          vVlVencido := vVlVencido + item_f('VL_FATURA', tFCR_FATURAI) - item_f('VL_ABATIMENTO', tFCR_FATURAI);

          vVlVencTotal := vVlVencTotal + ((item_f('VL_FATURA', tFCR_FATURAI) - item_f('VL_ABATIMENTO', tFCR_FATURAI)) * (vDtSistema - item_a('DT_VENCIMENTO', tFCR_FATURAI)));

          vNrDia := vDtSistema - item_a('DT_VENCIMENTO', tFCR_FATURAI);
          if (vNrDia > vNrDiaVencto) then begin
            vNrDiaVencto := vNrDia;
          end;
        end;
        if (gInFichaCliente = True) then begin
          if (item_f('TP_DOCUMENTO', tFCR_FATURAI) = 1) then begin
            vVlReceberFat := vVlReceberFat + item_f('VL_FATURA', tFCR_FATURAI) - item_f('VL_ABATIMENTO', tFCR_FATURAI);

            if (item_a('DT_VENCIMENTO', tFCR_FATURAI) < vDtSistema) then begin
              vVlFatSemJuro := vVlFatSemJuro + item_f('VL_FATURA', tFCR_FATURAI) - item_f('VL_ABATIMENTO', tFCR_FATURAI);

              viParams := '';
              putlistitensocc_e(viParams, tFCR_FATURAI);
              putitemXml(viParams, 'IN_SABADOUTIL', gvInSabadoUtil);
              putitemXml(viParams, 'NR_DIASCARENCIAATRASO', gvNrDiasCarenciaAtraso);
              putitemXml(viParams, 'NR_DIASCARENCIAMULTA', gvNrDiasCarenciaMulta);
              putitemXml(viParams, 'NR_DIASDESCPONT', gvNrDiasDescPont);
              putitemXml(viParams, 'TP_APLICACAOJUROS', gvTpAplicacaoJuros);
              if (item_a('DT_LIQ', tFCR_FATURAI) <> '') then begin
                putitemXml(viParams, 'DT_PAGAMENTO', item_a('DT_LIQ', tFCR_FATURAI));
              end else begin
                putitemXml(viParams, 'DT_PAGAMENTO', vDtSistema);
              end;
              voParams := activateCmp('FCRSVCO002', 'CalcVlFat', viParams); (*,viParams,voParams,, *)
              if (xStatus < 0) then begin
                Result := voParams;
                return(-1); exit;
              end;
              vVlFatComJuro := vVlFatComJuro + itemXmlF('VL_CALCULADO', voParams);

            end;
          end;
          if (item_f('TP_DOCUMENTO', tFCR_FATURAI) = 2) then begin
            vVlReceberChq := vVlReceberChq + item_f('VL_FATURA', tFCR_FATURAI);

            vNrFat := item_f('NR_FAT', tFCR_FATURAI);
            vDsComando := 'select count(*) from FCR_CHEQUE';
            vDsComando := '' + vDsComando + ' where CD_EMPRESA := ' + CD_EMPRESA + '.FCR_FATURAI';
            vDsComando := '' + vDsComando + ' ) and (CD_CLIENTE := ' + CD_CLIENTE + '.FCR_FATURAI';
            vDsComando := '' + vDsComando + ' ) and (NR_FAT := ' + FloatToStr(vNrFat') + ';
            vDsComando := '' + vDsComando + ' ) and (NR_PARCELA := ' + NR_PARCELA + '.FCR_FATURAI';
            vDsComando := '' + vDsComando + '  and (DT_DEVOLUCAO1 is not null ) or (DT_DEVOLUCAO2 is not null)';

            sql vDsComando, 'DEF';
            if (gresult > 0) then begin
              vVlChequeDev := vVlChequeDev + item_f('VL_FATURA', tFCR_FATURAI);
            end;
          end;
        end;

        setocc(tFCR_FATURAI, curocc(tFCR_FATURAI) + 1);
      end;
      if (vVlVencTotal > 0) then begin
        vNrDiasAtrasoMedio := vVlVencTotal / vVlVencido;
        vNrDiasAtrasoMedio := roundto(vNrDiasAtrasoMedio, 1);
      end;
    end;

  until (vLstPessoa = '');

  if (vLstColigado <> '') then begin
    vLstPessoa := vLstColigado;
  end else begin
    vLstPessoa := vCdCliente;
  end;

  repeat
    voParams := lerCodigoCliente(viParams); (* vLstPessoa, vLstCdPessoa *)
    if (xStatus < 0) then begin
      Result := voParams;
      return(-1); exit;
    end;

    clear_e(tFCC_CTAPES);
    putitem_e(tFCC_CTAPES, 'CD_PESSOA', vLstCdPessoa);
    putitem_e(tFCC_CTAPES, 'CD_EMPRESA', vCdEmpresa);
    putitem_e(tFCC_CTAPES, 'TP_MANUTENCAO', gCdTpManutCliente);
    retrieve_e(tFCC_CTAPES);
    if (xStatus >= 0) then begin
      setocc(tFCC_CTAPES, 1);
      while (xStatus >= 0) do begin
        viParams := '';
        putitemXml(viParams, 'NR_CTAPES', item_f('NR_CTAPES', tFCC_CTAPES));
        putitemXml(viParams, 'TP_DOCUMENTO', 10);
        putitemXml(viParams, 'NR_SEQHISTRELSUB', 1);
        putitemXml(viParams, 'DT_SALDO', itemXml('DT_SISTEMA', PARAM_GLB));
        voParams := activateCmp('FCCSVCO002', 'buscaSaldoCtaTp', viParams); (*,viParams,vpiValores,voParams,, *)
        if (xStatus < 0) then begin
          Result := voParams;
          return(-1); exit;
        end;

        vVlAdiant := vVlAdiant + itemXmlF('VL_SALDO', voParams);

        viParams := '';
        putitemXml(viParams, 'NR_CTAPES', item_f('NR_CTAPES', tFCC_CTAPES));
        putitemXml(viParams, 'TP_DOCUMENTO', 20);
        putitemXml(viParams, 'NR_SEQHISTRELSUB', 1);
        putitemXml(viParams, 'DT_SALDO', itemXml('DT_SISTEMA', PARAM_GLB));
        voParams := activateCmp('FCCSVCO002', 'buscaSaldoCtaTp', viParams); (*,viParams,vpiValores,voParams,, *)
        if (xStatus < 0) then begin
          Result := voParams;
          return(-1); exit;
        end;

        vVlCredev := vVlCredev + itemXmlF('VL_SALDO', voParams);
        setocc(tFCC_CTAPES, curocc(tFCC_CTAPES) + 1);
      end;
    end;

  until (vLstPessoa = '');

  if (vLstColigado <> '') then begin
    vLstPessoa := vLstColigado;
  end else begin
    vLstPessoa := vCdCliente;
  end;

  repeat
    voParams := lerCodigoCliente(viParams); (* vLstPessoa, vLstCdPessoa *)
    if (xStatus < 0) then begin
      Result := voParams;
      return(-1); exit;
    end;

    clear_e(tFCR_DOFNI);
    putitem_e(tFCR_DOFNI, 'CD_EMPDOFNI', vCdEmpresa);
    putitem_e(tFCR_DOFNI, 'CD_PESSOA', vLstCdPessoa);
    putitem_e(tFCR_DOFNI, 'IN_ABERTO', True);
    putitem_e(tFCR_DOFNI, 'TP_BAIXA', '!=9');

    retrieve_e(tFCR_DOFNI);
    if (xStatus >= 0) then begin
      setocc(tFCR_DOFNI, 1);
      while (xStatus >= 0) do begin
        if (item_f('TP_CREDITODEBITO', tFCR_DOFNI) = 1) then begin
          vVlDofni := vVlDofni + item_f('VL_DOCUMENTO', tFCR_DOFNI);
        end;
        setocc(tFCR_DOFNI, curocc(tFCR_DOFNI) + 1);
      end;
    end;

  until (vLstPessoa = '');

  viParams := '';
  putitemXml(viParams, 'CD_CLIENTE', vCdCliente);
  putitemXml(viParams, 'IN_TOTAL', True);
  voParams := activateCmp('PEDSVCO004', 'buscaSaldoPedPendente', viParams); (*,viParams,voParams,, *)
  if (xStatus < 0) then begin
    Result := voParams;
    return(-1); exit;
  end;

  vVlPedPend := itemXmlF('VL_SALDO', voParams);

  vVlSaldo := vVlLimite + vVlAdiant + vVlCredev + vVlDofni - vVlAberto - vVlPedPend;

  if (vCdFamiliar <> 0) then begin
    clear_e(tPES_FAMILIAR);
    putitem_e(tPES_FAMILIAR, 'CD_PESSOA', vCdCliente);
    putitem_e(tPES_FAMILIAR, 'CD_PARENTE', vCdFamiliar);
    retrieve_e(tPES_FAMILIAR);
    if (xStatus >= 0) then begin
      vPrLimiteFamiliar := item_f('PR_LIMITE', tPES_FAMILIAR);

      if (vPrLimiteFamiliar = 0) then begin
        vVlLimiteFamiliar := vVlLimite;
      end else begin
        vVlLimiteFamiliar := vVlLimite * vPrLimiteFamiliar / 100;
      end;

      vVlSaldoFamiliar := vVlLimiteFamiliar - vVlAbertoFamiliar;
    end;
  end;

  viParams := '';

  vVlSaldoDisp := 0;
  vVlLimiteCartao := 0;

  if (vLstColigado <> '') then begin
    putitemXml(viParams, 'CD_CLIENTE', vLstColigado);
  end else begin
    putitemXml(viParams, 'CD_CLIENTE', vCdCliente);
  end;
  putitemXml(viParams, 'CD_EMPRESA', vCdEmpresa);

  voParams := activateCmp('CTCSVCO007', 'buscaLimiteCartao', viParams); (*,viParams,voParams,, *)
  if (xStatus < 0) then begin
    Result := voParams;
    return(-1); exit;
  end;
  if (voParams <> '') then begin
    vVlSaldoDisp := itemXmlF('VL_SALDODISP', voParams);
    vVlLimiteCartao := itemXml('vVlLimiteCartao', voParams);
  end;

  putitemXml(Result, 'VL_LIMITE', vVlLimite);
  putitemXml(Result, 'VL_ABERTO', vVlAberto);
  putitemXml(Result, 'VL_SALDO', vVlSaldo);
  putitemXml(Result, 'VL_ADIANT', vVlAdiant);
  putitemXml(Result, 'VL_CREDEV', vVlCredev);
  putitemXml(Result, 'VL_DOFNI', vVlDofni);
  putitemXml(Result, 'VL_VENCIDO', vVlVencido);
  putitemXml(Result, 'VL_AVENCER', vVlAVencer);
  putitemXml(Result, 'VL_LIMITEFAMILIAR', vVlLimiteFamiliar);
  putitemXml(Result, 'VL_ABERTOFAMILIAR', vVlAbertoFamiliar);
  putitemXml(Result, 'VL_SALDOFAMILIAR', vVlSaldoFamiliar);
  putitemXml(Result, 'PR_FAMILIAR', vPrLimiteFamiliar);
  putitemXml(Result, 'VL_PEDPend', vVlPedPend);
  putitemXml(Result, 'NR_DIAVENCTO', vNrDiaVencto);
  putitemXml(Result, 'VL_SALDODISP', vVlSaldoDisp);
  putitemXml(Result, 'VL_LIMITECARTAO', vVlLimiteCartao);
  putitemXml(Result, 'VL_FATSEMJURO', vVlFatSemJuro);
  putitemXml(Result, 'VL_FATCOMJURO', vVlFatComJuro);
  putitemXml(Result, 'VL_RECEBERFAT', vVlReceberFat);
  putitemXml(Result, 'VL_RECEBERCHQ', vVlReceberChq);
  putitemXml(Result, 'VL_CHEQUEDEV', vVlChequeDev);
  putitemXml(Result, 'NR_DIAATRASOMEDIO', vNrDiasAtrasoMedio);

  return(0); exit;

end;

//-----------------------------------------------------------------
function T_FCRSVCO015.buscaLimiteMensal(pParams : String) : String;
//-----------------------------------------------------------------
const
  cDS_METHOD = 'ADICIONAL=Operação: T_FCRSVCO015.buscaLimiteMensal()';
var
  vCdEmpresa, vLst, viParams, voParams : String;
  vCdCliente, vVlLimite, vVlAberto, vVlSaldo, vVlAdiant, vVlCredev, vVlDofni, vCdFamiliar, vCdEmpLiq : Real;
  vVlVencido, vVlAVencer, vCdColigador, vNrDiaVencto, vNrDia, vVlSaldoDisp, vVlLimiteCartao, vNrSeqLiq : Real;
  vVlFatSemJuro, vVlFatComJuro, vVlReceberFat, vVlReceberChq, vVlChequeDev, vVlJuros, vNrFat : Real;
  vVlLimiteFamiliar, vVlAbertoFamiliar, vVlSaldoFamiliar, vPrLimiteFamiliar, vVlVencTotal, vNrDiasAtrasoMedio, vVlPedPend : Real;
  viParams, vpiValores, voParams, vLstColigado, vLstPessoa, vLstCdPessoa, vDsComando : String;
  vInTotal : Boolean;
  vDtSistema, vDtLiq : TDate;
begin
  vDtSistema := itemXml('DT_SISTEMA', PARAM_GLB);
  vCdEmpresa := itemXmlF('CD_EMPRESA', pParams);
  vCdCliente := itemXmlF('CD_CLIENTE', pParams);
  vCdFamiliar := itemXmlF('CD_FAMILIAR', pParams);
  vInTotal := itemXmlB('IN_TOTAL', pParams);
  Result := '';
  vVlLimite := 0;
  vVlAberto := 0;
  vVlSaldo := 0;
  vVlLimiteFamiliar := 0;
  vVlAbertoFamiliar := 0;
  vVlSaldoFamiliar := 0;
  vPrLimiteFamiliar := 0;
  vVlAdiant := 0;
  vVlCredev := 0;
  vVlDofni := 0;
  vVlVencido := 0;
  vVlAVencer := 0;
  vVlPedPend := 0;

  gInFichaCliente := itemXmlB('IN_FICHACLIENTE', pParams);

  vVlFatSemJuro := 0;
  vVlFatComJuro := 0;
  vVlReceberFat := 0;
  vVlReceberChq := 0;
  vVlChequeDev := 0;

  voParams := buscaParametro(viParams); (* *)

  if (xStatus < 0) then begin
    return(-1); exit;
  end;
  if (gCdTpManutCliente = '') then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Parâmetro com o código do tipo de manutenção do cliente não cadastrado!', cDS_METHOD);
    return(-1); exit;
  end;
  if (vCdCliente = '') then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Cliente não informado!', cDS_METHOD);
    return(-1); exit;
  end;
  if (vCdCliente = gCdClientePDV) then begin
    return(0); exit;
  end;
  if (itemXml('CD_EMPRESA', pParams) = '') then begin
    if (gTpLimiteCliente = 2) then begin
      viParams := '';
      putitemXml(viParams, 'CD_GRUPOEMPRESA', '>=0and<=9999');
      voParams := activateCmp('FGRSVCO001', 'listarEmpresa', viParams); (*,viParams,voParams,, *)
      if (xStatus < 0) then begin
        Result := voParams;
        return(-1); exit;
      end;
      vCdEmpresa := itemXml('LST_EMPRESA', voParams);
    end;
  end;
  if (itemXml('CD_EMPRESA', pParams) = '') then begin
    if (gTpLimiteCliente = 1) then begin
      vCdEmpresa := gModulo.gCdEmpresa;

      viParams := '';
      putitemXml(viParams, 'CD_GRUPOEMPRESA', itemXmlF('CD_GRUPOEMPRESA', PARAM_GLB));
      voParams := activateCmp('FGRSVCO001', 'listarEmpresa', viParams); (*,viParams,voParams,, *)
      if (xStatus < 0) then begin
        Result := voParams;
        return(-1); exit;
      end;
      vCdEmpresa := itemXml('LST_EMPRESA', voParams);

    end;
  end;

  vCdColigador := '';
  vLstColigado := '';
  if (gInLimiteColigador = True) then begin
    viParams := '';
    putitemXml(viParams, 'CD_PESSOA', vCdCliente);
    voParams := activateCmp('PESSVCO010', 'BuscaColigado', viParams); (*,viParams,voParams,, *)
    if (xStatus < 0) then begin
      Result := voParams;
      return(-1); exit;
    end;
    vCdColigador := itemXmlF('CD_COLIGADOR', voParams);
    vLstColigado := itemXml('DS_LSTCOLIGADO', voParams);
  end;

  clear_e(tPES_LIMITECLI);
  putitem_e(tPES_LIMITECLI, 'CD_EMPRESA', vCdEmpresa);
  putitem_e(tPES_LIMITECLI, 'CD_CLIENTE', vCdCliente);
  if (vCdColigador <> '') then begin
    putitem_e(tPES_LIMITECLI, 'CD_CLIENTE', vCdColigador);
  end;
  retrieve_e(tPES_LIMITECLI);
  if (xStatus >= 0) then begin
    setocc(tPES_LIMITECLI, 1);
    while (xStatus >= 0) do begin
      vVlLimite := vVlLimite + item_f('VL_LIMITEMEN', tPES_LIMITECLI);
      setocc(tPES_LIMITECLI, curocc(tPES_LIMITECLI) + 1);
    end;
  end;

  vNrDiaVencto := 0;

  if (vLstColigado <> '') then begin
    vLstPessoa := vLstColigado;
  end else begin
    vLstPessoa := vCdCliente;
  end;

  repeat
    voParams := lerCodigoCliente(viParams); (* vLstPessoa, vLstCdPessoa *)
    if (xStatus < 0) then begin
      Result := voParams;
      return(-1); exit;
    end;

    clear_e(tFCR_FATURAI);
    putitem_e(tFCR_FATURAI, 'CD_EMPRESA', vCdEmpresa);
    putitem_e(tFCR_FATURAI, 'CD_CLIENTE', vLstCdPessoa);
    putitem_e(tFCR_FATURAI, 'TP_SITUACAO', 1);

    if (glstDoc = '') then begin
      putitem_e(tFCR_FATURAI, 'TP_DOCUMENTO', '!= 11');
    end else begin
      voParams := SeparaItemLista(viParams); (* glstDoc, vLst *)
      if (xStatus < 0) then begin
        Result := voParams;
        return(-1); exit;
      end;

      putitem_e(tFCR_FATURAI, 'TP_DOCUMENTO', vLst);
    end;
    if (glstCob <> '') then begin
      voParams := SeparaItemLista(viParams); (* glstCob, vLst *)
      if (xStatus < 0) then begin
        Result := voParams;
        return(-1); exit;
      end;

      putitem_e(tFCR_FATURAI, 'TP_COBRANCA', vLst);
    end;
    if (glstFat <> '') then begin
      voParams := SeparaItemLista(viParams); (* glstFat, vLst *)
      if (xStatus < 0) then begin
        Result := voParams;
        return(-1); exit;
      end;

      putitem_e(tFCR_FATURAI, 'TP_FATURAMENTO', vLst);
    end;

    putitem_e(tFCR_FATURAI, 'DT_LIQ', '=');
    putitem_e(tFCR_FATURAI, 'TP_BAIXA', 0);

    if (gInFichaCliente = True) then begin
      putitem_e(tFCR_FATURAI, 'TP_DOCUMENTO', '1);
    end;

    gDtMesAno := itemXml('DT_SISTEMA', PARAM_GLB);
    putitem_e(tSIS_MESANO, 'DT_MESANO', '01/' + gDtMESANO' + ');
    putitem_e(tFCR_FATURAI, 'DT_EMISSAO', '>.=' + DT_MESANO + '.SIS_MESANO');
    retrieve_e(tFCR_FATURAI);
    if (xStatus >= 0) then begin
      setocc(tFCR_FATURAI, 1);
      while (xStatus >= 0) do begin
        vVlAberto := vVlAberto + item_f('VL_FATURA', tFCR_FATURAI) - item_f('VL_ABATIMENTO', tFCR_FATURAI);

        if (vCdFamiliar <> 0) then begin
          clear_e(tFGR_LIQITEMCR);
          putitem_e(tFGR_LIQITEMCR, 'CD_EMPFAT', item_f('CD_EMPRESA', tFCR_FATURAI));
          putitem_e(tFGR_LIQITEMCR, 'CD_CLIENTE', item_f('CD_CLIENTE', tFCR_FATURAI));
          putitem_e(tFGR_LIQITEMCR, 'NR_FAT', item_f('NR_FAT', tFCR_FATURAI));
          putitem_e(tFGR_LIQITEMCR, 'NR_PARCELA', item_f('NR_PARCELA', tFCR_FATURAI));
          putitem_e(tFGR_LIQITEMCR, 'TP_TIPOREG', 2);
          retrieve_e(tFGR_LIQITEMCR);
          if (xStatus >= 0) then begin
            vCdEmpLiq := item_f('CD_EMPLIQ', tFGR_LIQITEMCR);
            vDtLiq := item_a('DT_LIQ', tFGR_LIQITEMCR);
            vNrSeqLiq := item_f('NR_SEQLIQ', tFGR_LIQITEMCR);

            clear_e(tFGR_LIQITEMCR);
            putitem_e(tFGR_LIQITEMCR, 'CD_EMPLIQ', vCdEmpLiq);
            putitem_e(tFGR_LIQITEMCR, 'DT_LIQ', vDtLiq);
            putitem_e(tFGR_LIQITEMCR, 'NR_SEQLIQ', vNrSeqLiq);
            putitem_e(tFGR_LIQITEMCR, 'TP_TIPOREG', 1);
            retrieve_e(tFGR_LIQITEMCR);
            if (xStatus >= 0) then begin
              setocc(tFGR_LIQITEMCR, 1);
              while (xStatus >= 0) do begin
                if (item_f('NR_TRANSACAO', tFGR_LIQITEMCR) <> 0) then begin
                  clear_e(tTRA_TRANSACAD);
                  putitem_e(tTRA_TRANSACAD, 'CD_EMPRESA', item_f('CD_EMPTRANSACAO', tFGR_LIQITEMCR));
                  putitem_e(tTRA_TRANSACAD, 'DT_TRANSACAO', item_a('DT_TRANSACAO', tFGR_LIQITEMCR));
                  putitem_e(tTRA_TRANSACAD, 'NR_TRANSACAO', item_f('NR_TRANSACAO', tFGR_LIQITEMCR));
                  retrieve_e(tTRA_TRANSACAD);
                  if (xStatus >= 0)  and (item_f('CD_FAMILIAR', tTRA_TRANSACAD) = vCdFamiliar) then begin
                    vVlAbertoFamiliar := vVlAbertoFamiliar + item_f('VL_FATURA', tFCR_FATURAI) - item_f('VL_ABATIMENTO', tFCR_FATURAI);

                    break;
                  end;
                end;

                setocc(tFGR_LIQITEMCR, curocc(tFGR_LIQITEMCR) + 1);
              end;
            end;
          end;
        end;
        if (item_a('DT_VENCIMENTO', tFCR_FATURAI) >= vDtSistema) then begin
          vVlAVencer := vVlAVencer + item_f('VL_FATURA', tFCR_FATURAI) - item_f('VL_ABATIMENTO', tFCR_FATURAI);
        end else begin
          vVlVencido := vVlVencido + item_f('VL_FATURA', tFCR_FATURAI) - item_f('VL_ABATIMENTO', tFCR_FATURAI);

          vVlVencTotal := vVlVencTotal + ((item_f('VL_FATURA', tFCR_FATURAI) - item_f('VL_ABATIMENTO', tFCR_FATURAI)) * (vDtSistema - item_a('DT_VENCIMENTO', tFCR_FATURAI)));

          vNrDia := vDtSistema - item_a('DT_VENCIMENTO', tFCR_FATURAI);
          if (vNrDia > vNrDiaVencto) then begin
            vNrDiaVencto := vNrDia;
          end;
        end;
        if (gInFichaCliente = True) then begin
          if (item_f('TP_DOCUMENTO', tFCR_FATURAI) = 1) then begin
            vVlReceberFat := vVlReceberFat + item_f('VL_FATURA', tFCR_FATURAI) - item_f('VL_ABATIMENTO', tFCR_FATURAI);

            if (item_a('DT_VENCIMENTO', tFCR_FATURAI) < vDtSistema) then begin
              vVlFatSemJuro := vVlFatSemJuro + item_f('VL_FATURA', tFCR_FATURAI) - item_f('VL_ABATIMENTO', tFCR_FATURAI);

              viParams := '';
              putlistitensocc_e(viParams, tFCR_FATURAI);
              putitemXml(viParams, 'IN_SABADOUTIL', gvInSabadoUtil);
              putitemXml(viParams, 'NR_DIASCARENCIAATRASO', gvNrDiasCarenciaAtraso);
              putitemXml(viParams, 'NR_DIASCARENCIAMULTA', gvNrDiasCarenciaMulta);
              putitemXml(viParams, 'NR_DIASDESCPONT', gvNrDiasDescPont);
              putitemXml(viParams, 'TP_APLICACAOJUROS', gvTpAplicacaoJuros);
              if (item_a('DT_LIQ', tFCR_FATURAI) <> '') then begin
                putitemXml(viParams, 'DT_PAGAMENTO', item_a('DT_LIQ', tFCR_FATURAI));
              end else begin
                putitemXml(viParams, 'DT_PAGAMENTO', vDtSistema);
              end;
              voParams := activateCmp('FCRSVCO002', 'CalcVlFat', viParams); (*,viParams,voParams,, *)
              if (xStatus < 0) then begin
                Result := voParams;
                return(-1); exit;
              end;
              vVlFatComJuro := vVlFatComJuro + itemXmlF('VL_CALCULADO', voParams);

            end;
          end;
          if (item_f('TP_DOCUMENTO', tFCR_FATURAI) = 2) then begin
            vVlReceberChq := vVlReceberChq + item_f('VL_FATURA', tFCR_FATURAI);

            vNrFat := item_f('NR_FAT', tFCR_FATURAI);
            vDsComando := 'select count(*) from FCR_CHEQUE';
            vDsComando := '' + vDsComando + ' where CD_EMPRESA := ' + CD_EMPRESA + '.FCR_FATURAI';
            vDsComando := '' + vDsComando + ' ) and (CD_CLIENTE := ' + CD_CLIENTE + '.FCR_FATURAI';
            vDsComando := '' + vDsComando + ' ) and (NR_FAT := ' + FloatToStr(vNrFat') + ';
            vDsComando := '' + vDsComando + ' ) and (NR_PARCELA := ' + NR_PARCELA + '.FCR_FATURAI';
            vDsComando := '' + vDsComando + '  and (DT_DEVOLUCAO1 is not null ) or (DT_DEVOLUCAO2 is not null)';

            sql vDsComando, 'DEF';
            if (gresult > 0) then begin
              vVlChequeDev := vVlChequeDev + item_f('VL_FATURA', tFCR_FATURAI);
            end;
          end;
        end;

        setocc(tFCR_FATURAI, curocc(tFCR_FATURAI) + 1);
      end;
      if (vVlVencTotal > 0) then begin
        vNrDiasAtrasoMedio := vVlVencTotal / vVlVencido;
        vNrDiasAtrasoMedio := roundto(vNrDiasAtrasoMedio, 1);
      end;
    end;

  until (vLstPessoa = '');

  if (vLstColigado <> '') then begin
    vLstPessoa := vLstColigado;
  end else begin
    vLstPessoa := vCdCliente;
  end;

  repeat
    voParams := lerCodigoCliente(viParams); (* vLstPessoa, vLstCdPessoa *)
    if (xStatus < 0) then begin
      Result := voParams;
      return(-1); exit;
    end;

    clear_e(tFCC_CTAPES);
    putitem_e(tFCC_CTAPES, 'CD_PESSOA', vLstCdPessoa);
    putitem_e(tFCC_CTAPES, 'CD_EMPRESA', vCdEmpresa);
    putitem_e(tFCC_CTAPES, 'TP_MANUTENCAO', gCdTpManutCliente);
    retrieve_e(tFCC_CTAPES);
    if (xStatus >= 0) then begin
      setocc(tFCC_CTAPES, 1);
      while (xStatus >= 0) do begin
        viParams := '';
        putitemXml(viParams, 'NR_CTAPES', item_f('NR_CTAPES', tFCC_CTAPES));
        putitemXml(viParams, 'TP_DOCUMENTO', 10);
        putitemXml(viParams, 'NR_SEQHISTRELSUB', 1);
        putitemXml(viParams, 'DT_SALDO', itemXml('DT_SISTEMA', PARAM_GLB));
        voParams := activateCmp('FCCSVCO002', 'buscaSaldoCtaTp', viParams); (*,viParams,vpiValores,voParams,, *)
        if (xStatus < 0) then begin
          Result := voParams;
          return(-1); exit;
        end;

        vVlAdiant := vVlAdiant + itemXmlF('VL_SALDO', voParams);

        viParams := '';
        putitemXml(viParams, 'NR_CTAPES', item_f('NR_CTAPES', tFCC_CTAPES));
        putitemXml(viParams, 'TP_DOCUMENTO', 20);
        putitemXml(viParams, 'NR_SEQHISTRELSUB', 1);
        putitemXml(viParams, 'DT_SALDO', itemXml('DT_SISTEMA', PARAM_GLB));
        voParams := activateCmp('FCCSVCO002', 'buscaSaldoCtaTp', viParams); (*,viParams,vpiValores,voParams,, *)
        if (xStatus < 0) then begin
          Result := voParams;
          return(-1); exit;
        end;

        vVlCredev := vVlCredev + itemXmlF('VL_SALDO', voParams);
        setocc(tFCC_CTAPES, curocc(tFCC_CTAPES) + 1);
      end;
    end;

  until (vLstPessoa = '');

  if (vLstColigado <> '') then begin
    vLstPessoa := vLstColigado;
  end else begin
    vLstPessoa := vCdCliente;
  end;

  repeat
    voParams := lerCodigoCliente(viParams); (* vLstPessoa, vLstCdPessoa *)
    if (xStatus < 0) then begin
      Result := voParams;
      return(-1); exit;
    end;

    clear_e(tFCR_DOFNI);
    putitem_e(tFCR_DOFNI, 'CD_EMPDOFNI', vCdEmpresa);
    putitem_e(tFCR_DOFNI, 'CD_PESSOA', vLstCdPessoa);
    putitem_e(tFCR_DOFNI, 'IN_ABERTO', True);
    putitem_e(tFCR_DOFNI, 'TP_BAIXA', '!=9');

    retrieve_e(tFCR_DOFNI);
    if (xStatus >= 0) then begin
      setocc(tFCR_DOFNI, 1);
      while (xStatus >= 0) do begin
        if (item_f('TP_CREDITODEBITO', tFCR_DOFNI) = 1) then begin
          vVlDofni := vVlDofni + item_f('VL_DOCUMENTO', tFCR_DOFNI);
        end;
        setocc(tFCR_DOFNI, curocc(tFCR_DOFNI) + 1);
      end;
    end;

  until (vLstPessoa = '');

  vVlSaldo := vVlLimite + vVlAdiant + vVlCredev + vVlDofni - vVlAberto;

  if (vCdFamiliar <> 0) then begin
    clear_e(tPES_FAMILIAR);
    putitem_e(tPES_FAMILIAR, 'CD_PESSOA', vCdCliente);
    putitem_e(tPES_FAMILIAR, 'CD_PARENTE', vCdFamiliar);
    retrieve_e(tPES_FAMILIAR);
    if (xStatus >= 0) then begin
      vPrLimiteFamiliar := item_f('PR_LIMITE', tPES_FAMILIAR);

      if (vPrLimiteFamiliar = 0) then begin
        vVlLimiteFamiliar := vVlLimite;
      end else begin
        vVlLimiteFamiliar := vVlLimite * vPrLimiteFamiliar / 100;
      end;

      vVlSaldoFamiliar := vVlLimiteFamiliar - vVlAbertoFamiliar;
    end;
  end;

  viParams := '';

  vVlSaldoDisp := 0;
  vVlLimiteCartao := 0;

  if (vLstColigado <> '') then begin
    putitemXml(viParams, 'CD_CLIENTE', vLstColigado);
  end else begin
    putitemXml(viParams, 'CD_CLIENTE', vCdCliente);
  end;
  putitemXml(viParams, 'CD_EMPRESA', vCdEmpresa);

  voParams := activateCmp('CTCSVCO007', 'buscaLimiteCartao', viParams); (*,viParams,voParams,, *)
  if (xStatus < 0) then begin
    Result := voParams;
    return(-1); exit;
  end;
  if (voParams <> '') then begin
    vVlSaldoDisp := itemXmlF('VL_SALDODISP', voParams);
    vVlLimiteCartao := itemXml('vVlLimiteCartao', voParams);
  end;

  putitemXml(Result, 'VL_LIMITE', vVlLimite);
  putitemXml(Result, 'VL_ABERTO', vVlAberto);
  putitemXml(Result, 'VL_SALDO', vVlSaldo);
  putitemXml(Result, 'VL_ADIANT', vVlAdiant);
  putitemXml(Result, 'VL_CREDEV', vVlCredev);
  putitemXml(Result, 'VL_DOFNI', vVlDofni);
  putitemXml(Result, 'VL_VENCIDO', vVlVencido);
  putitemXml(Result, 'VL_AVENCER', vVlAVencer);
  putitemXml(Result, 'VL_LIMITEFAMILIAR', vVlLimiteFamiliar);
  putitemXml(Result, 'VL_ABERTOFAMILIAR', vVlAbertoFamiliar);
  putitemXml(Result, 'VL_SALDOFAMILIAR', vVlSaldoFamiliar);
  putitemXml(Result, 'PR_FAMILIAR', vPrLimiteFamiliar);
  putitemXml(Result, 'VL_PEDPend', vVlPedPend);
  putitemXml(Result, 'NR_DIAVENCTO', vNrDiaVencto);
  putitemXml(Result, 'VL_SALDODISP', vVlSaldoDisp);
  putitemXml(Result, 'VL_LIMITECARTAO', vVlLimiteCartao);
  putitemXml(Result, 'VL_FATSEMJURO', vVlFatSemJuro);
  putitemXml(Result, 'VL_FATCOMJURO', vVlFatComJuro);
  putitemXml(Result, 'VL_RECEBERFAT', vVlReceberFat);
  putitemXml(Result, 'VL_RECEBERCHQ', vVlReceberChq);
  putitemXml(Result, 'VL_CHEQUEDEV', vVlChequeDev);
  putitemXml(Result, 'NR_DIAATRASOMEDIO', vNrDiasAtrasoMedio);

  return(0); exit;

end;

end.
