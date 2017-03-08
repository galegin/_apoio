unit cTRASVCO013;

interface

(* COMPONENTES 
  ADMSVCO001 / ADMSVCO027 / CMCSVCO010 / CMPSVCO004 / ECFSVCO001
  ECFSVCO011 / FCCSVCO002 / FCPSVCO005 / FCPSVCO013 / FCPSVCO046
  FCRSVCO010 / FCRSVCO068 / FCXSVCO002 / FISSVCO004 / FISSVCO028
  FISSVCO038 / GERFP008 / GERSVCO053 / IMBSVCO001 / MKTSVCO004
  PEDSVCO002 / PESSVCO035 / PRDSVCO020 / PRDSVCO021 / PRFSVCO001
  SICSVCO005 / TRASVCO004 / TRASVCO016 / TRASVCO021 / 
*)        

uses
  Classes, SysUtils, DB,
  cServiceUnf, cDataSetUnf;

type
  T_TRASVCO013 = class(TcServiceUnf)
  private
    tADM_USUARIO,
    tCMC_SOLIMATIT,
    tF_IMB_CONTTRA,
    tF_TRA_TRANSAC,
    tFCC_CTAPES,
    tFCC_MOV,
    tFCR_CHEQUEPRE,
    tFCX_CAIXAC,
    tFCX_CAIXAM,
    tFGR_LIQ,
    tFGR_LIQITEMCC,
    tFGR_LIQITEMCR,
    tFIS_ECF,
    tFIS_ITEMCONSI,
    tFIS_NF,
    tFIS_NFE,
    tFIS_NFITEMPLO,
    tGER_OPERACAO,
    tIMB_CONTRATO,
    tIMB_CONTRATOI,
    tIMB_CONTRATOT,
    tMKT_CARTELAI,
    tPCP_OPCONT,
    tPED_PEDIDOCON,
    tPES_BONUSMOV,
    tPRD_LOTEI,
    tPRD_LOTEINF,
    tPRD_MOSTCONT,
    tTIN_AGRUPADOR,
    tTIN_OTNN,
    tTIN_REPI,
    tTRA_DEVTRA,
    tTRA_ITEMLOTE,
    tTRA_ITEMPRDFI,
    tTRA_ITEMSERIA,
    tTRA_S_TRANSAC,
    tTRA_TRANSACAO,
    tTRA_TRANSACCO,
    tTRA_TRANSACEC,
    tTRA_TRANSAGRU,
    tTRA_TRANSITEM,
    tTRA_TRANSOB,
    tTRA_TROCA : TcDatasetUnf;
    function getParam(pParams : String = '') : String;
    function setEntidade(pParams : String = '') : String;
  protected
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;    
  published
    function cancelaItemContrato(pParams : String = '') : String;
    function validaCancelamentoNFE(pParams : String = '') : String;
    function validaFatDupContabilidade(pParams : String = '') : String;
    function alteraSituacaoContagemOp(pParams : String = '') : String;
    function validaCancelamentoCupom(pParams : String = '') : String;
    function buscaTransacaoRelacionada(pParams : String = '') : String;
    function cancelaTransacao(pParams : String = '') : String;
  end;

implementation

uses
  cADMSVCO001,
  cActivate, cStatus, cFuncao, cXml, dModulo;

var
  gCdComponente,
  gCdCtaPesCxFilial,
  gCdTpManutCxUsuario,
  gDtAtual,
  gDtAuxiliar,
  gDtNfe,
  gDtServidor,
  gInBloqueiaCancNfe,
  gInCancTransCxFechado,
  gInEnvioRecebMalote,
  gInSuprimentoAutomatico,
  gInUtilizaCxFilial,
  gNrCtaMatriz,
  gNrHoraCancelNFE,
  gNrHrDifFusoHorario,
  greplace(,
  gtinTituraria,
  gTpAmbienteNFE,
  gTpBonus,
  gTpValidacaoCancEcf,
  gvTpSituacaoNF : String;

//---------------------------------------------------------------
constructor T_TRASVCO013.Create(AOwner: TComponent);
//---------------------------------------------------------------
begin
  inherited Create(AOwner);
  setEntidade('');
end;

//--------------------------------
destructor T_TRASVCO013.Destroy;
//--------------------------------
begin
  inherited Destroy;
end;

//---------------------------------------------------------------
function T_TRASVCO013.getParam(pParams : String = '') : String;
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
  putitem(xParam, 'CD_TPMANUT_CXUSUARIO');

  xParam := T_ADMSVCO001.GetParametro(xParam);

  gCdCtaPesCxFilial := itemXml('CD_CTAPES_CXFILIAL', xParam);
  gCdTpManutCxUsuario := itemXml('CD_TPMANUT_CXUSUARIO', xParam);
  gInBloqueiaCancNfe := itemXml('IN_BLOQUEIA_CANC_NFE', xParam);
  gInCancTransCxFechado := itemXml('IN_CANC_TRANS_CX_FECHADO', xParam);
  gInEnvioRecebMalote := itemXml('IN_ENVIO_RECEB_MALOTE', xParam);
  gInSuprimentoAutomatico := itemXml('IN_SUPRIMENTO_AUTOMATICO', xParam);
  gInUtilizaCxFilial := itemXml('IN_UTILIZA_CXFILIAL', xParam);
  gNrCtaMatriz := itemXml('CD_CTAPES_CXMATRIZ', xParam);
  gNrHoraCancelNFE := itemXml('NR_HORA_CANCEL_NFE', xParam);
  gNrHrDifFusoHorario := itemXml('NR_HR_DIF_FUSOHORARIO', xParam);
  gtinTituraria := itemXml('TIN_TINTURARIA', xParam);
  gTpAmbienteNFE := itemXml('TP_AMBIENTE_NFE', xParam);
  gTpBonus := itemXml('TP_BONUS_DESCONTO', xParam);
  gTpValidacaoCancEcf := itemXml('TP_VALIDACAO_CANC_TRA_ECF', xParam);

  xParamEmp := '';
  putitem(xParamEmp, 'CD_CTAPES_CXFILIAL');
  putitem(xParamEmp, 'CD_CTAPES_CXMATRIZ');
  putitem(xParamEmp, 'CD_EMPLIQ');
  putitem(xParamEmp, 'CD_TPMANUT_CXUSUARIO');
  putitem(xParamEmp, 'DS_COMPONENTE');
  putitem(xParamEmp, 'DS_MOTIVOCANC');
  putitem(xParamEmp, 'DT_LIQ');
  putitem(xParamEmp, 'DT_SALDO');
  putitem(xParamEmp, 'IN_BLOQUEIA_CANC_NFE');
  putitem(xParamEmp, 'IN_CANC_TRANS_CX_FECHADO');
  putitem(xParamEmp, 'IN_ENVIO_RECEB_MALOTE');
  putitem(xParamEmp, 'IN_SUPRIMENTO_AUTOMATICO');
  putitem(xParamEmp, 'IN_UTILIZA_CXFILIAL');
  putitem(xParamEmp, 'NR_CTAPES');
  putitem(xParamEmp, 'NR_HORA_CANCEL_NFE');
  putitem(xParamEmp, 'NR_HR_DIF_FUSOHORARIO');
  putitem(xParamEmp, 'NR_SEQHISTRELSUB');
  putitem(xParamEmp, 'NR_SEQLIQ');
  putitem(xParamEmp, 'TIN_TINTURARIA');
  putitem(xParamEmp, 'TP_AMBIENTE_NFE');
  putitem(xParamEmp, 'TP_BONUS_DESCONTO');
  putitem(xParamEmp, 'TP_DOCUMENTO');
  putitem(xParamEmp, 'TP_VALIDACAO_CANC_TRA_ECF');

  xParamEmp := T_ADMSVCO001.GetParamEmpresa(piCdEmpresa, xParamEmp);

  gCdCtaPesCxFilial := itemXml('CD_CTAPES_CXFILIAL', xParamEmp);
  gInBloqueiaCancNfe := itemXml('IN_BLOQUEIA_CANC_NFE', xParamEmp);
  gInCancTransCxFechado := itemXml('IN_CANC_TRANS_CX_FECHADO', xParamEmp);
  gInEnvioRecebMalote := itemXml('IN_ENVIO_RECEB_MALOTE', xParamEmp);
  gInSuprimentoAutomatico := itemXml('IN_SUPRIMENTO_AUTOMATICO', xParamEmp);
  gInUtilizaCxFilial := itemXml('IN_UTILIZA_CXFILIAL', xParamEmp);
  gNrCtaMatriz := itemXml('CD_CTAPES_CXMATRIZ', xParamEmp);
  gNrHoraCancelNFE := itemXml('NR_HORA_CANCEL_NFE', xParamEmp);
  gNrHrDifFusoHorario := itemXml('NR_HR_DIF_FUSOHORARIO', xParamEmp);
  gtinTituraria := itemXml('TIN_TINTURARIA', xParamEmp);
  gTpAmbienteNFE := itemXml('TP_AMBIENTE_NFE', xParamEmp);
  gTpBonus := itemXml('TP_BONUS_DESCONTO', xParamEmp);
  gTpValidacaoCancEcf := itemXml('TP_VALIDACAO_CANC_TRA_ECF', xParamEmp);

end;

//---------------------------------------------------------------
function T_TRASVCO013.setEntidade(pParams : String = '') : String;
//---------------------------------------------------------------
begin
  tADM_USUARIO := GetEntidade('ADM_USUARIO');
  tCMC_SOLIMATIT := GetEntidade('CMC_SOLIMATIT');
  tF_IMB_CONTTRA := GetEntidade('F_IMB_CONTTRA');
  tF_TRA_TRANSAC := GetEntidade('F_TRA_TRANSAC');
  tFCC_CTAPES := GetEntidade('FCC_CTAPES');
  tFCC_MOV := GetEntidade('FCC_MOV');
  tFCR_CHEQUEPRE := GetEntidade('FCR_CHEQUEPRE');
  tFCX_CAIXAC := GetEntidade('FCX_CAIXAC');
  tFCX_CAIXAM := GetEntidade('FCX_CAIXAM');
  tFGR_LIQ := GetEntidade('FGR_LIQ');
  tFGR_LIQITEMCC := GetEntidade('FGR_LIQITEMCC');
  tFGR_LIQITEMCR := GetEntidade('FGR_LIQITEMCR');
  tFIS_ECF := GetEntidade('FIS_ECF');
  tFIS_ITEMCONSI := GetEntidade('FIS_ITEMCONSI');
  tFIS_NF := GetEntidade('FIS_NF');
  tFIS_NFE := GetEntidade('FIS_NFE');
  tFIS_NFITEMPLO := GetEntidade('FIS_NFITEMPLO');
  tGER_OPERACAO := GetEntidade('GER_OPERACAO');
  tIMB_CONTRATO := GetEntidade('IMB_CONTRATO');
  tIMB_CONTRATOI := GetEntidade('IMB_CONTRATOI');
  tIMB_CONTRATOT := GetEntidade('IMB_CONTRATOT');
  tMKT_CARTELAI := GetEntidade('MKT_CARTELAI');
  tPCP_OPCONT := GetEntidade('PCP_OPCONT');
  tPED_PEDIDOCON := GetEntidade('PED_PEDIDOCON');
  tPES_BONUSMOV := GetEntidade('PES_BONUSMOV');
  tPRD_LOTEI := GetEntidade('PRD_LOTEI');
  tPRD_LOTEINF := GetEntidade('PRD_LOTEINF');
  tPRD_MOSTCONT := GetEntidade('PRD_MOSTCONT');
  tTIN_AGRUPADOR := GetEntidade('TIN_AGRUPADOR');
  tTIN_OTNN := GetEntidade('TIN_OTNN');
  tTIN_REPI := GetEntidade('TIN_REPI');
  tTRA_DEVTRA := GetEntidade('TRA_DEVTRA');
  tTRA_ITEMLOTE := GetEntidade('TRA_ITEMLOTE');
  tTRA_ITEMPRDFI := GetEntidade('TRA_ITEMPRDFI');
  tTRA_ITEMSERIA := GetEntidade('TRA_ITEMSERIA');
  tTRA_S_TRANSAC := GetEntidade('TRA_S_TRANSAC');
  tTRA_TRANSACAO := GetEntidade('TRA_TRANSACAO');
  tTRA_TRANSACCO := GetEntidade('TRA_TRANSACCO');
  tTRA_TRANSACEC := GetEntidade('TRA_TRANSACEC');
  tTRA_TRANSAGRU := GetEntidade('TRA_TRANSAGRU');
  tTRA_TRANSITEM := GetEntidade('TRA_TRANSITEM');
  tTRA_TRANSOB := GetEntidade('TRA_TRANSOB');
  tTRA_TROCA := GetEntidade('TRA_TROCA');
end;

//-------------------------------------------------------------------
function T_TRASVCO013.cancelaItemContrato(pParams : String) : String;
//-------------------------------------------------------------------
const
  cDS_METHOD = 'ADICIONAL=Operação: T_TRASVCO013.cancelaItemContrato()';
var
  (* numeric piCdEmpContrato : IN / numeric piNrSeqContrato : IN / numeric piNrSeqItem : IN *)
  viParams, voParams : String;
  vIndiscard : Boolean;
begin
  return(0); exit;
  if (piNrSeqItem <> 0) then begin
    clear_e(tIMB_CONTRATOI);
    putitem_e(tIMB_CONTRATOI, 'NR_SEQITEM', piNrSeqItem);
    retrieve_e(tIMB_CONTRATOI);
    if (xStatus >= 0) then begin
      clear_e(tF_IMB_CONTTRA);
      putitem_e(tF_IMB_CONTTRA, 'CD_EMPCONTRATO', piCdEmpContrato);
      putitem_e(tF_IMB_CONTTRA, 'NR_SEQCONTRATO', piNrSeqContrato);
      putitem_e(tF_IMB_CONTTRA, 'NR_SEQITEM', piNrSeqItem);
      putitem_e(tF_IMB_CONTTRA, 'NR_TRANSACAO', item_f('NR_TRANSACAO', tTRA_TRANSACAO));
      putitem_e(tF_IMB_CONTTRA, 'DT_TRANSACAO', item_a('DT_TRANSACAO', tTRA_TRANSACAO));
      retrieve_e(tF_IMB_CONTTRA);
      if (xStatus >= 0) then begin
        setocc(tF_IMB_CONTTRA, -1);
        setocc(tF_IMB_CONTTRA, 1);
        while (xStatus >= 0) do begin
          clear_e(tF_TRA_TRANSAC);
          putitem_e(tF_TRA_TRANSAC, 'CD_EMPRESA', item_f('CD_EMPTRANSACAO', tF_IMB_CONTTRA));
          putitem_e(tF_TRA_TRANSAC, 'NR_TRANSACAO', item_f('NR_TRANSACAO', tF_IMB_CONTTRA));
          putitem_e(tF_TRA_TRANSAC, 'DT_TRANSACAO', item_a('DT_TRANSACAO', tF_IMB_CONTTRA));
          retrieve_e(tF_TRA_TRANSAC);
          if (xStatus >= 0) then begin
            if (item_f('TP_SITUACAO', tF_TRA_TRANSAC) = 6) then begin
              return(0); exit;
            end;
          end;
          setocc(tF_IMB_CONTTRA, curocc(tF_IMB_CONTTRA) + 1);
        end;
      end;

      clear_e(tF_IMB_CONTTRA);
      putitem_e(tF_IMB_CONTTRA, 'CD_EMPCONTRATO', piCdEmpContrato);
      putitem_e(tF_IMB_CONTTRA, 'NR_SEQCONTRATO', piNrSeqContrato);
      putitem_e(tF_IMB_CONTTRA, 'NR_SEQITEM', piNrSeqItem);
      putitem_e(tF_IMB_CONTTRA, 'CD_EMPTRANSACAO', item_f('CD_EMPRESA', tTRA_TRANSACAO));
      retrieve_e(tF_IMB_CONTTRA);
      if (xStatus >= 0) then begin
        setocc(tF_IMB_CONTTRA, -1);
        setocc(tF_IMB_CONTTRA, 1);
        while (xStatus >= 0) do begin
          vIndiscard := False;

          clear_e(tF_TRA_TRANSAC);
          putitem_e(tF_TRA_TRANSAC, 'CD_EMPRESA', item_f('CD_EMPTRANSACAO', tF_IMB_CONTTRA));
          putitem_e(tF_TRA_TRANSAC, 'NR_TRANSACAO', item_f('NR_TRANSACAO', tF_IMB_CONTTRA));
          putitem_e(tF_TRA_TRANSAC, 'DT_TRANSACAO', item_a('DT_TRANSACAO', tF_IMB_CONTTRA));
          retrieve_e(tF_TRA_TRANSAC);
          if (xStatus >= 0) then begin
            if (item_f('TP_SITUACAO', tF_TRA_TRANSAC) = 6) then begin
              vIndiscard := True;
            end;
          end;
          if (vIndiscard = True) then begin
            discard(tF_IMB_CONTTRA);
            if (xStatus = 0) then begin
              xStatus := -1;
            end;
          end else begin
            setocc(tF_IMB_CONTTRA, curocc(tF_IMB_CONTTRA) + 1);
          end;
        end;

        sort_e(tF_IMB_CONTTRA, '        sort/e , CD_EMPCONTRATO, NR_SEQCONTRATO, CD_EMPTRANSACAO, DT_PERIODOFINAL :d;');

        setocc(tF_IMB_CONTTRA, 1);
        while (xStatus >= 0) do begin

          clear_e(tF_TRA_TRANSAC);
          putitem_e(tF_TRA_TRANSAC, 'CD_EMPRESA', item_f('CD_EMPTRANSACAO', tF_IMB_CONTTRA));
          putitem_e(tF_TRA_TRANSAC, 'NR_TRANSACAO', item_f('NR_TRANSACAO', tF_IMB_CONTTRA));
          putitem_e(tF_TRA_TRANSAC, 'DT_TRANSACAO', item_a('DT_TRANSACAO', tF_IMB_CONTTRA));
          retrieve_e(tF_TRA_TRANSAC);
          if (xStatus >= 0) then begin
            if (item_f('NR_TRANSACAO', tF_IMB_CONTTRA) <> item_f('NR_TRANSACAO', tTRA_TRANSACAO)) then begin
              Result := SetStatus(STS_ERROR, 'GEN0001', 'É necessária cancelar primeiramente a transação: ' + CD_EMPTRANSACAO + '.F_IMB_CONTTRA - ' + DT_TRANSACAO + '.F_IMB_CONTTRA - ' + NR_TRANSACAO + '.F_IMB_CONTTRA!', '');
              return(-1); exit;
            end else begin
              putitem_e(tIMB_CONTRATOI, 'DT_ULTFAT', gnext('item_a('DT_PERIODOFINAL', tF_IMB_CONTTRA)'));
              break;
            end;
          end;

          setocc(tF_IMB_CONTTRA, curocc(tF_IMB_CONTTRA) + 1);
        end;
      end;
      if (item_f('NR_PARCELA', tIMB_CONTRATOI) = 1) then begin
        putitem_e(tIMB_CONTRATOI, 'NR_PARCELA', '');
      end else begin
        putitem_e(tIMB_CONTRATOI, 'NR_PARCELA', item_f('NR_PARCELA', tIMB_CONTRATOI) - 1);
      end;
      if (item_f('TP_SITUACAO', tIMB_CONTRATOI) = 5) then begin
        putitem_e(tIMB_CONTRATOI, 'TP_SITUACAO', 1);
      end;

      viParams := '';
      putlistitensocc_e(viParams, tIMB_CONTRATOI);
      putitemXml(viParams, 'CD_EMPCONTRATO', piCdEmpContrato);
      putitemXml(viParams, 'NR_SEQCONTRATO', piNrSeqContrato);
      putitemXml(viParams, 'NR_SEQITEM', piNrSeqItem);
      putitemXml(viParams, 'CD_COMPONENTE', gCdComponente);
      voParams := activateCmp('IMBSVCO001', 'gravaItemContrato', viParams); (*,,,, *)
      if (xStatus < 0) then begin
        Result := voParams;
        return(-1); exit;
      end;
    end;
  end;

  return(0); exit;

end;

//---------------------------------------------------------------------
function T_TRASVCO013.validaCancelamentoNFE(pParams : String) : String;
//---------------------------------------------------------------------
const
  cDS_METHOD = 'ADICIONAL=Operação: T_TRASVCO013.validaCancelamentoNFE()';
var
  viParams, voParams, vPriLetra : String;
  vNrHora : Real;
begin
  if (gInBloqueiaCancNfe = True) then begin
    if (gvTpSituacaoNF = 'C')and(item_f('TP_MODDCTOFISCAL', tFIS_NF) = 55)and(item_f('TP_PROCESSAMENTO', tFIS_NFE) <> 'A') then begin
      Result := SetStatus(STS_ERROR, 'GEN0001', 'Para NF-e que não esteja Autorizada não é permitido o cancelamento!', cDS_METHOD);
      return(-1); exit;
    end;
  end;
  if (gTpAmbienteNFE = 1) then begin
    if (item_f('TP_PROCESSAMENTO', tFIS_NFE) = 'A') then begin
      gDtServidor := Now;
      gDtAuxiliar := item_a('DT_RECEBIMENTO', tFIS_NFE);
      vPriLetra := gDtAuxiliar[1, 1];
      gDtAuxiliar := greplace(DtAuxiliarg, 1, vPriLetra, '2');

      gDtNfe := gDtAuxiliar;
      vNrHora := gDtServidor - gDtNfe;

      vNrHora := (vNrHora * 24)  - gNrHrDifFusoHorario;
      if (vNrHora > gNrHoraCancelNFE) then begin
        Result := SetStatus(STS_ERROR, 'GEN0001', 'Nota fiscal eletrônica - ' + NR_NF + '.FIS_NF autorizada mais de ' + FloatToStr(gNrHoraCancelNFE) + ' horas!', cDS_METHOD);
        return(-1); exit;
      end;
    end;
  end;

  return(0); exit;
end;

//-------------------------------------------------------------------------
function T_TRASVCO013.validaFatDupContabilidade(pParams : String) : String;
//-------------------------------------------------------------------------
const
  cDS_METHOD = 'ADICIONAL=Operação: T_TRASVCO013.validaFatDupContabilidade()';
var
  (* numeric piCdEmpLiq : IN / date piDtLiq : IN / numeric piNrSeqLiq : IN / string piTpLiq : IN *)
  viParams, voParams, vDsMensagem : String;
begin
  if (piCdEmpLiq = '') then begin
    return(0); exit;
  end;
  if (piDtLiq = '') then begin
    return(0); exit;
  end;
  if (piNrSeqLiq = '') then begin
    return(0); exit;
  end;
  if (piTpLiq = '') then begin
    return(0); exit;
  end;
  if (piTpLiq = 'CP') then begin
    clear_e(tFGR_LIQITEMCC);
    putitem_e(tFGR_LIQITEMCC, 'CD_EMPLIQ', piCdEmpLiq);
    putitem_e(tFGR_LIQITEMCC, 'DT_LIQ', piDtLiq);
    putitem_e(tFGR_LIQITEMCC, 'NR_SEQLIQ', piNrSeqLiq);
    retrieve_e(tFGR_LIQITEMCC);
    if (xStatus >= 0) then begin
      setocc(tFGR_LIQITEMCC, 1);
      while (xStatus >= 0) do begin
        if (item_f('CD_EMPRESADUP', tFGR_LIQITEMCC) <> 0 ) and (item_f('CD_FORNECDUP', tFGR_LIQITEMCC) <> 0 ) and (item_f('NR_DUPLICATADUP', tFGR_LIQITEMCC) <> 0 ) and (item_f('NR_PARCELADUP', tFGR_LIQITEMCC) <> 0) then begin
          viParams := '';
          putitemXml(viParams, 'CD_EMPRESA', item_f('CD_EMPRESADUP', tFGR_LIQITEMCC));
          putitemXml(viParams, 'CD_FORNECEDOR', item_f('CD_FORNECDUP', tFGR_LIQITEMCC));
          putitemXml(viParams, 'NR_DUPLICATA', item_f('NR_DUPLICATADUP', tFGR_LIQITEMCC));
          putitemXml(viParams, 'NR_PARCELA', item_f('NR_PARCELADUP', tFGR_LIQITEMCC));
          putitemXml(viParams, 'TP_PROCESSO', 0);
          voParams := activateCmp('FCPSVCO005', 'validarLanctoContabilDup', viParams); (*,,,, *)
          if (xStatus < 0) then begin
            Result := voParams;
            return(-1); exit;
          end;
          if (itemXml('IN_CONTABILIZADO', voParams) = True) then begin
            vDsMensagem := 'Transação não pode ser cancelada pois a duplicata ' + NR_DUPLICATADUP + '.FGR_LIQITEMCC-' + NR_PARCELADUP + '.FGR_LIQITEMCC';
            vDsMensagem := '' + vDsMensagem + ' já está contabilizada no pool empresa ' + itemXmlF('CD_POOLEMPRESA', + ' voParams)';
            vDsMensagem := '' + vDsMensagem + ' - exercício contábil ' + itemXml('DT_EXERCONTABIL', + ' voParams) - lote ' + itemXml('NR_LOTE', + ' voParams)';
            Result := SetStatus(STS_ERROR, 'GEN0001', '' + vDsMensagem', + ' cDS_METHOD);
            return(-1); exit;
          end;
        end;
        setocc(tFGR_LIQITEMCC, curocc(tFGR_LIQITEMCC) + 1);
      end;
    end;
  end else if (piTpLiq = 'CR') then begin
    clear_e(tFGR_LIQITEMCR);
    putitem_e(tFGR_LIQITEMCR, 'CD_EMPLIQ', piCdEmpLiq);
    putitem_e(tFGR_LIQITEMCR, 'DT_LIQ', piDtLiq);
    putitem_e(tFGR_LIQITEMCR, 'NR_SEQLIQ', piNrSeqLiq);
    putitem_e(tFGR_LIQITEMCR, 'TP_TIPOREG', 2);
    retrieve_e(tFGR_LIQITEMCR);
    if (xStatus >= 0) then begin
      setocc(tFGR_LIQITEMCR, 1);
      while (xStatus >= 0) do begin
        if (item_f('CD_EMPFAT', tFGR_LIQITEMCR) <> 0 ) and (item_f('CD_CLIENTE', tFGR_LIQITEMCR) <> 0 ) and (item_f('NR_FAT', tFGR_LIQITEMCR) <> 0 ) and (item_f('NR_PARCELA', tFGR_LIQITEMCR) <> 0) then begin
          viParams := '';
          putitemXml(viParams, 'CD_EMPRESA', item_f('CD_EMPFAT', tFGR_LIQITEMCR));
          putitemXml(viParams, 'CD_CLIENTE', item_f('CD_CLIENTE', tFGR_LIQITEMCR));
          putitemXml(viParams, 'NR_FAT', item_f('NR_FAT', tFGR_LIQITEMCR));
          putitemXml(viParams, 'NR_PARCELA', item_f('NR_PARCELA', tFGR_LIQITEMCR));
          putitemXml(viParams, 'TP_PROCESSO', 0);
          voParams := activateCmp('FCRSVCO010', 'validarLanctoContabilFat', viParams); (*,,,, *)
          if (xStatus < 0) then begin
            Result := voParams;
            return(-1); exit;
          end;
          if (itemXml('IN_CONTABILIZADO', voParams) = True) then begin
            vDsMensagem := 'Transação não pode ser cancelada pois a fatura ' + NR_FAT + '.FGR_LIQITEMCR-' + NR_PARCELA + '.FGR_LIQITEMCR';
            vDsMensagem := '' + vDsMensagem + ' já está contabilizada no pool empresa ' + itemXmlF('CD_POOLEMPRESA', + ' voParams)';
            vDsMensagem := '' + vDsMensagem + ' - exercício contábil ' + itemXml('DT_EXERCONTABIL', + ' voParams) - lote ' + itemXml('NR_LOTE', + ' voParams)';
            Result := SetStatus(STS_ERROR, 'GEN0001', '' + vDsMensagem', + ' cDS_METHOD);
            return(-1); exit;
          end;
        end;
        setocc(tFGR_LIQITEMCR, curocc(tFGR_LIQITEMCR) + 1);
      end;
    end;
  end;

  return(0); exit;

end;

//------------------------------------------------------------------------
function T_TRASVCO013.alteraSituacaoContagemOp(pParams : String) : String;
//------------------------------------------------------------------------
const
  cDS_METHOD = 'ADICIONAL=Operação: T_TRASVCO013.alteraSituacaoContagemOp()';
var
  viParams, voParams : String;
begin
  clear_e(tPCP_OPCONT);
  putitem_e(tPCP_OPCONT, 'CD_EMPCONTAGEM', item_f('CD_EMPCONTAGEM', tTRA_TRANSACCO));
  putitem_e(tPCP_OPCONT, 'NR_CONTAGEM', item_f('NR_CONTAGEM', tTRA_TRANSACCO));
  retrieve_e(tPCP_OPCONT);
  if (xStatus >= 0) then begin
    viParams := '';
    putitemXml(viParams, 'CD_EMPRESA', item_f('CD_EMPCONTAGEM', tPCP_OPCONT));
    putitemXml(viParams, 'NR_CONTAGEM', item_f('NR_CONTAGEM', tPCP_OPCONT));
    putitemXml(viParams, 'CD_EMPOP', item_f('CD_EMPOP', tPCP_OPCONT));
    putitemXml(viParams, 'NR_CICLO', item_f('NR_CICLO', tPCP_OPCONT));
    putitemXml(viParams, 'NR_OP', item_f('NR_OP', tPCP_OPCONT));
    putitemXml(viParams, 'TP_SITUACAO', 1);
    putitemXml(viParams, 'TP_RELACIONAMENTO', 1);
    voParams := activateCmp('GERSVCO053', 'alteraSitOpContagem', viParams); (*,,,, *)
    if (xStatus < 0) then begin
      Result := voParams;
      return(-1); exit;
    end;
  end;

  return(0); exit;

end;

//-----------------------------------------------------------------------
function T_TRASVCO013.validaCancelamentoCupom(pParams : String) : String;
//-----------------------------------------------------------------------
const
  cDS_METHOD = 'ADICIONAL=Operação: T_TRASVCO013.validaCancelamentoCupom()';
var
  viParams, voParams, vDsNrSerie : String;
  vNrCupom : Real;
  vInCancelou : Boolean;
begin
  vInCancelou := False;

  clear_e(tTRA_TRANSACEC);
  putitem_e(tTRA_TRANSACEC, 'CD_EMPRESA', item_f('CD_EMPRESA', tTRA_TRANSACAO));
  putitem_e(tTRA_TRANSACEC, 'NR_TRANSACAO', item_f('NR_TRANSACAO', tTRA_TRANSACAO));
  putitem_e(tTRA_TRANSACEC, 'DT_TRANSACAO', item_a('DT_TRANSACAO', tTRA_TRANSACAO));
  retrieve_e(tTRA_TRANSACEC);
  if (xStatus >= 0) then begin
    clear_e(tFIS_ECF);
    putitem_e(tFIS_ECF, 'CD_EMPRESA', item_f('CD_EMPECF', tTRA_TRANSACEC));
    putitem_e(tFIS_ECF, 'NR_ECF', item_f('NR_ECF', tTRA_TRANSACEC));
    retrieve_e(tFIS_ECF);
    if (xStatus >= 0) then begin
      viParams := '';
      putitemXml(viParams, 'IN_IMPCUPOMFISCAL', False);
      putitemXml(viParams, 'NM_FUNCAO', <ECF_NUMERO_SERIE>);
      voParams := activateCmp('ECFSVCO001', 'leinformacaoImpressora', viParams); (*,,, *)
      if (xStatus < 0) then begin
        Result := voParams;
        return(-1); exit;
      end;
        putitemXml(viParams, 'TITULO', 'Erro de comunicação com a ECF');
        putitemXml(viParams, 'MENSAGEM', itemXml('DESCRICAO', xCtxErro));
        voParams := activateCmp('GERFP008', 'EXEC', viParams); (*,,, *)
        if (xStatus < 0) then begin
          Result := voParams;
          return(-1); exit;
        end;
        return(-1); exit;
      end else if (xStatus < 0) then begin
        Result := SetStatus(STS_ERROR, {xCdErro} '', '{xCtxErro} ''', '');
        return(-1); exit;
      end;

      vDsNrSerie := itemXmlF('NR_SERIE', voParams);
      vDsNrSerie := grtrim(vDsNrSerie, ' ');
    end else begin
      Result := SetStatus(STS_ERROR, 'GEN001', 'Não é possível cancelar a transação!ECF não cadastrada.', cDS_METHOD);
      return(-1); exit;
    end;
    if (vDsNrSerie = item_f('CD_SERIEFAB', tFIS_ECF)) then begin
      viParams := '';
      putitemXml(viParams, 'IN_IMPCUPOMFISCAL', False);
      putitemXml(viParams, 'NM_FUNCAO', <ECF_NUMERO_CUPOM>);
      voParams := activateCmp('ECFSVCO001', 'leinformacaoImpressora', viParams); (*,,, *)
      if (xStatus < 0) then begin
        Result := voParams;
        return(-1); exit;
      end;
        putitemXml(viParams, 'TITULO', 'Erro de comunicação com a ECF');
        putitemXml(viParams, 'MENSAGEM', itemXml('DESCRICAO', xCtxErro));
        voParams := activateCmp('GERFP008', 'EXEC', viParams); (*,,, *)
        if (xStatus < 0) then begin
          Result := voParams;
          return(-1); exit;
        end;
        return(-1); exit;
      end else if (xStatus < 0) then begin
        Result := SetStatus(STS_ERROR, {xCdErro} '', '{xCtxErro} ''', '');
        return(-1); exit;
      end;

      vNrCupom := itemXmlF('NR_CUPOM', voParams);

      if (vNrCupom = item_f('NR_CUPOM', tTRA_TRANSACEC)) then begin
        viParams := '';
        voParams := activateCmp('ECFSVCO001', 'CancelaCupom', viParams); (*,,, *)
        if (xStatus < 0) then begin
          Result := voParams;
          return(-1); exit;
        end;
          putitemXml(viParams, 'TITULO', 'Erro de comunicação com a ECF');
          putitemXml(viParams, 'MENSAGEM', itemXml('DESCRICAO', xCtxErro));
          voParams := activateCmp('GERFP008', 'EXEC', viParams); (*,,, *)
          if (xStatus < 0) then begin
            Result := voParams;
            return(-1); exit;
          end;
          return(-1); exit;
        end else if (xStatus < 0) then begin
          Result := SetStatus(STS_ERROR, {xCdErro} '', '{xCtxErro} ''', '');
          return(-1); exit;
        end;

        vInCancelou := True;
      end else begin

        viParams := '';

        putitemXml(viParams, 'NR_CUPOM', vNrCupom);
        putitemXml(viParams, 'NR_SERIE', vDsNrSerie);
        voParams := activateCmp('ECFSVCO011', 'verificaDocVinculado', viParams); (*,,, *)
        if (xStatus < 0) then begin
          Result := voParams;
          return(-1); exit;
        end;
        if (itemXml('NR_COOVINCULADO', voParams) = item_f('NR_CUPOM', tTRA_TRANSACEC)) then begin
          viParams := '';
          voParams := activateCmp('ECFSVCO001', 'CancelaCupom', viParams); (*,,, *)
          if (xStatus < 0) then begin
            Result := voParams;
            return(-1); exit;
          end;
            putitemXml(viParams, 'TITULO', 'Erro de comunicação com a ECF');
            putitemXml(viParams, 'MENSAGEM', itemXml('DESCRICAO', xCtxErro));
            voParams := activateCmp('GERFP008', 'EXEC', viParams); (*,,, *)
            if (xStatus < 0) then begin
              Result := voParams;
              return(-1); exit;
            end;
            return(-1); exit;
          end else if (xStatus < 0) then begin
            Result := SetStatus(STS_ERROR, {xCdErro} '', '{xCtxErro} ''', '');
            return(-1); exit;
          end;

          vInCancelou := True;
        end else begin
          Result := SetStatus(STS_ERROR, 'GEN001', 'Não é possível cancelar a transação!Cupom fiscal da transação não é o último.', cDS_METHOD);
          return(-1); exit;
        end;
      end;
    end else begin
      Result := SetStatus(STS_ERROR, 'GEN001', 'Não é possível cancelar a transação!Número de série da ECF não pertente a ECF da transação.', cDS_METHOD);
      return(-1); exit;
    end;
  end;
  if (vInCancelou = True) then begin
    putitem_e(tTRA_TRANSACEC, 'TP_SITUACAO', 'C');
    voParams := tTRA_TRANSACEC.Salvar();
  end;

  return(0); exit;
end;

//-------------------------------------------------------------------------
function T_TRASVCO013.buscaTransacaoRelacionada(pParams : String) : String;
//-------------------------------------------------------------------------
const
  cDS_METHOD = 'ADICIONAL=Operação: T_TRASVCO013.buscaTransacaoRelacionada()';
var
  vDtTransacao, vDtLiq : TDate;
  vDsRegistro, vDsLstTransacao : String;
  vInAchou, vInCancelada : Boolean;
  vCdEmpresa, vNrTransacao, vCdEmpLiq, vNrSeqLiq : Real;
begin
  vCdEmpresa := itemXmlF('CD_EMPRESA', pParams);
  vNrTransacao := itemXmlF('NR_TRANSACAO', pParams);
  vDtTransacao := itemXml('DT_TRANSACAO', pParams);
  vInCancelada := itemXmlB('IN_CANCELADA', pParams);

  if (vCdEmpresa = 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN001', 'Empresa origem não informada!', cDS_METHOD);
    return(-1); exit;
  end;
  if (vNrTransacao = 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN001', 'Número transação origem não informado', cDS_METHOD);
    return(-1); exit;
  end;
  if (vDtTransacao = '') then begin
    Result := SetStatus(STS_ERROR, 'GEN001', 'Data transação origem não informada', cDS_METHOD);
    return(-1); exit;
  end;
  if (vInCancelada = '') then begin
    vInCancelada := True;
  end;

  clear_e(tTRA_TRANSACAO);
  putitem_e(tTRA_TRANSACAO, 'CD_EMPRESA', vCdEmpresa);
  putitem_e(tTRA_TRANSACAO, 'NR_TRANSACAO', vNrTransacao);
  putitem_e(tTRA_TRANSACAO, 'DT_TRANSACAO', vDtTransacao);
  retrieve_e(tTRA_TRANSACAO);
  if (xStatus < 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN001', 'Transação ' + FloatToStr(vNrTransacao) + ' não cadastrada!', cDS_METHOD);
    return(-1); exit;
  end;

  clear_e(tTRA_S_TRANSAC);

  clear_e(tFGR_LIQITEMCR);
  putitem_e(tFGR_LIQITEMCR, 'CD_EMPTRANSACAO', vCdEmpresa);
  putitem_e(tFGR_LIQITEMCR, 'NR_TRANSACAO', vNrTransacao);
  putitem_e(tFGR_LIQITEMCR, 'DT_TRANSACAO', vDtTransacao);
  putitem_e(tFGR_LIQITEMCR, 'TP_TIPOREG', 1);
  retrieve_e(tFGR_LIQITEMCR);
  if (xStatus >= 0) then begin
    vCdEmpLiq := item_f('CD_EMPLIQ', tFGR_LIQITEMCR);
    vDtLiq := item_a('DT_LIQ', tFGR_LIQITEMCR);
    vNrSeqLiq := item_f('NR_SEQLIQ', tFGR_LIQITEMCR);
    clear_e(tFGR_LIQITEMCR);
    putitem_e(tFGR_LIQITEMCR, 'CD_EMPLIQ', vCdEmpLiq);
    putitem_e(tFGR_LIQITEMCR, 'NR_SEQLIQ', vNrSeqLiq);
    putitem_e(tFGR_LIQITEMCR, 'DT_LIQ', vDtLiq);
    putitem_e(tFGR_LIQITEMCR, 'TP_TIPOREG', 1);
    retrieve_e(tFGR_LIQITEMCR);
    setocc(tFGR_LIQITEMCR, -1);
    setocc(tFGR_LIQITEMCR, 1);
    while (xStatus >= 0) do begin

      if (item_f('CD_EMPTRANSACAO', tFGR_LIQITEMCR) <> vCdEmpresa ) or (item_f('NR_TRANSACAO', tFGR_LIQITEMCR) <> vNrTransacao ) or (item_a('DT_TRANSACAO', tFGR_LIQITEMCR) <> vDtTransacao) then begin
        if (item_f('NR_TRANSACAO', tFGR_LIQITEMCR) > 0) then begin
          creocc(tTRA_S_TRANSAC, -1);
          putitem_e(tTRA_S_TRANSAC, 'CD_EMPRESA', item_f('CD_EMPTRANSACAO', tFGR_LIQITEMCR));
          putitem_e(tTRA_S_TRANSAC, 'NR_TRANSACAO', item_f('NR_TRANSACAO', tFGR_LIQITEMCR));
          putitem_e(tTRA_S_TRANSAC, 'DT_TRANSACAO', item_a('DT_TRANSACAO', tFGR_LIQITEMCR));
          retrieve_o(tTRA_S_TRANSAC);
          if (xStatus = -7) then begin
            retrieve_x(tTRA_S_TRANSAC);
          end else if (xStatus = 0) then begin
            Result := SetStatus(STS_ERROR, 'GEN001', 'Transação ' + NR_TRANSACAO + '.TRA_S_TRANSAC não cadastrada!', cDS_METHOD);
            return(-1); exit;
          end;
        end;
      end;
      setocc(tFGR_LIQITEMCR, curocc(tFGR_LIQITEMCR) + 1);
    end;
  end;

  clear_e(tTRA_TRANSAGRU);
  putitem_e(tTRA_TRANSAGRU, 'CD_EMPRESA', vCdEmpresa);
  putitem_e(tTRA_TRANSAGRU, 'NR_TRANSACAO', vNrtransacao);
  putitem_e(tTRA_TRANSAGRU, 'DT_TRANSACAO', vDtTransacao);
  retrieve_e(tTRA_TRANSAGRU);
  if (xStatus >=0) then begin
    setocc(tTRA_TRANSAGRU, -1);
    setocc(tTRA_TRANSAGRU, 1);
    while (xStatus >=0) do begin
      creocc(tTRA_S_TRANSAC, -1);
      putitem_e(tTRA_S_TRANSAC, 'CD_EMPRESA', item_f('CD_EMPRESAORI', tTRA_TRANSAGRU));
      putitem_e(tTRA_S_TRANSAC, 'NR_TRANSACAO', item_f('NR_TRANSACAOORI', tTRA_TRANSAGRU));
      putitem_e(tTRA_S_TRANSAC, 'DT_TRANSACAO', item_a('DT_TRANSACAOORI', tTRA_TRANSAGRU));
      retrieve_o(tTRA_S_TRANSAC);
      if (xStatus = -7) then begin
        retrieve_x(tTRA_S_TRANSAC);
      end else if (xStatus = 0) then begin
        Result := SetStatus(STS_ERROR, 'GEN001', 'Transação ' + NR_TRANSACAO + '.TRA_S_TRANSAC não cadastrada!', cDS_METHOD);
        return(-1); exit;
      end;
      if (item_f('TP_SITUACAO', tTRA_S_TRANSAC) = 4) then begin
        discard(tTRA_S_TRANSAC);
      end;

      setocc(tTRA_TRANSAGRU, curocc(tTRA_TRANSAGRU) + 1);
    end;
  end;

  clear_e(tTRA_TROCA);
  putitem_e(tTRA_TROCA, 'CD_EMPDEV', vCdEmpresa);
  putitem_e(tTRA_TROCA, 'NR_TRADEV', vNrTransacao);
  putitem_e(tTRA_TROCA, 'DT_TRADEV', vDtTransacao);
  retrieve_e(tTRA_TROCA);
  if (xStatus >= 0) then begin
    creocc(tTRA_S_TRANSAC, -1);
    putitem_e(tTRA_S_TRANSAC, 'CD_EMPRESA', item_f('CD_EMPVEN', tTRA_TROCA));
    putitem_e(tTRA_S_TRANSAC, 'NR_TRANSACAO', item_f('NR_TRAVEN', tTRA_TROCA));
    putitem_e(tTRA_S_TRANSAC, 'DT_TRANSACAO', item_a('DT_TRAVEN', tTRA_TROCA));
    retrieve_o(tTRA_S_TRANSAC);
    if (xStatus = -7) then begin
      retrieve_x(tTRA_S_TRANSAC);
    end else if (xStatus = 0) then begin
      Result := SetStatus(STS_ERROR, 'GEN001', 'Transação ' + NR_TRANSACAO + '.TRA_S_TRANSAC não cadastrada!', cDS_METHOD);
      return(-1); exit;
    end;
  end;

  clear_e(tTRA_TROCA);
  putitem_e(tTRA_TROCA, 'CD_EMPVEN', vCdEmpresa);
  putitem_e(tTRA_TROCA, 'NR_TRAVEN', vNrTransacao);
  putitem_e(tTRA_TROCA, 'DT_TRAVEN', vDtTransacao);
  retrieve_e(tTRA_TROCA);
  if (xStatus >= 0) then begin
    creocc(tTRA_S_TRANSAC, -1);
    putitem_e(tTRA_S_TRANSAC, 'CD_EMPRESA', item_f('CD_EMPDEV', tTRA_TROCA));
    putitem_e(tTRA_S_TRANSAC, 'NR_TRANSACAO', item_f('NR_TRADEV', tTRA_TROCA));
    putitem_e(tTRA_S_TRANSAC, 'DT_TRANSACAO', item_a('DT_TRADEV', tTRA_TROCA));
    retrieve_o(tTRA_S_TRANSAC);
    if (xStatus = -7) then begin
      retrieve_x(tTRA_S_TRANSAC);
    end else if (xStatus = 0) then begin
      Result := SetStatus(STS_ERROR, 'GEN001', 'Transação ' + NR_TRANSACAO + '.TRA_S_TRANSAC não cadastrada!', cDS_METHOD);
      return(-1); exit;
    end;
  end;

  clear_e(tTRA_TRANSACAO);
  putitem_e(tTRA_TRANSACAO, 'CD_EMPRESAORI', vCdEmpresa);
  putitem_e(tTRA_TRANSACAO, 'NR_TRANSACAOORI', vNrTransacao);
  putitem_e(tTRA_TRANSACAO, 'DT_TRANSACAOORI', vDtTransacao);
  retrieve_e(tTRA_TRANSACAO);
  if (xStatus >= 0) then begin
    setocc(tTRA_TRANSACAO, 1);
    while (xStatus >=0) do begin
      if (item_f('TP_MODALIDADE', tGER_OPERACAO) = 9) then begin
        creocc(tTRA_S_TRANSAC, -1);
        putitem_e(tTRA_S_TRANSAC, 'CD_EMPRESA', item_f('CD_EMPRESA', tTRA_TRANSACAO));
        putitem_e(tTRA_S_TRANSAC, 'NR_TRANSACAO', item_f('NR_TRANSACAO', tTRA_TRANSACAO));
        putitem_e(tTRA_S_TRANSAC, 'DT_TRANSACAO', item_a('DT_TRANSACAO', tTRA_TRANSACAO));
        retrieve_o(tTRA_S_TRANSAC);
        if (xStatus = -7) then begin
          retrieve_x(tTRA_S_TRANSAC);
        end else if (xStatus = 0) then begin
          Result := SetStatus(STS_ERROR, 'GEN001', 'Transação ' + NR_TRANSACAO + '.TRA_S_TRANSAC não cadastrada!', cDS_METHOD);
          return(-1); exit;
        end;
      end;
      setocc(tTRA_TRANSACAO, curocc(tTRA_TRANSACAO) + 1);
    end;
  end;
  if (empty(tTRA_S_TRANSAC) = False) then begin
    repeat
      vInAchou := False;
      clear_e(tF_TRA_TRANSAC);
      setocc(tTRA_S_TRANSAC, 1);
      while (xStatus >= 0) do begin
        if (item_b('IN_VERIFICADO', tTRA_S_TRANSAC) = True) then begin
        end else begin
          clear_e(tTRA_TRANSAGRU);
          putitem_e(tTRA_TRANSAGRU, 'CD_EMPRESA', item_f('CD_EMPRESA', tTRA_S_TRANSAC));
          putitem_e(tTRA_TRANSAGRU, 'NR_TRANSACAO', item_f('NR_TRANSACAO', tTRA_S_TRANSAC));
          putitem_e(tTRA_TRANSAGRU, 'DT_TRANSACAO', item_a('DT_TRANSACAO', tTRA_S_TRANSAC));
          retrieve_e(tTRA_TRANSAGRU);
          if (xStatus >=0) then begin
            setocc(tTRA_TRANSAGRU, -1);
            setocc(tTRA_TRANSAGRU, 1);
            while (xStatus >=0) do begin
              creocc(tF_TRA_TRANSAC, -1);
              putitem_e(tF_TRA_TRANSAC, 'CD_EMPRESA', item_f('CD_EMPRESAORI', tTRA_TRANSAGRU));
              putitem_e(tF_TRA_TRANSAC, 'NR_TRANSACAO', item_f('NR_TRANSACAOORI', tTRA_TRANSAGRU));
              putitem_e(tF_TRA_TRANSAC, 'DT_TRANSACAO', item_a('DT_TRANSACAOORI', tTRA_TRANSAGRU));
              retrieve_o(tF_TRA_TRANSAC);
              if (xStatus = -7) then begin
                retrieve_x(tF_TRA_TRANSAC);
              end else if (xStatus = 0) then begin
                Result := SetStatus(STS_ERROR, 'GEN001', 'Transação ' + NR_TRANSACAO + '.F_TRA_TRANSAC não cadastrada!', cDS_METHOD);
                return(-1); exit;
              end;
              if (item_f('TP_SITUACAO', tF_TRA_TRANSAC) = 4) then begin
                discard(tF_TRA_TRANSAC);
              end;

              setocc(tTRA_TRANSAGRU, curocc(tTRA_TRANSAGRU) + 1);
            end;
          end;
          putitem_e(tTRA_S_TRANSAC, 'IN_VERIFICADO', True);
        end;
        setocc(tTRA_S_TRANSAC, curocc(tTRA_S_TRANSAC) + 1);
      end;
      if (empty(tF_TRA_TRANSAC) = False) then begin
        vInAchou := True;
        setocc(tF_TRA_TRANSAC, 1);
        while (xStatus >= 0) do begin
          creocc(tTRA_S_TRANSAC, -1);
          putitem_e(tTRA_S_TRANSAC, 'CD_EMPRESA', item_f('CD_EMPRESA', tF_TRA_TRANSAC));
          putitem_e(tTRA_S_TRANSAC, 'NR_TRANSACAO', item_f('NR_TRANSACAO', tF_TRA_TRANSAC));
          putitem_e(tTRA_S_TRANSAC, 'DT_TRANSACAO', item_a('DT_TRANSACAO', tF_TRA_TRANSAC));
          retrieve_o(tTRA_S_TRANSAC);
          if (xStatus = -7) then begin
            retrieve_x(tTRA_S_TRANSAC);
          end else if (xStatus = 0) then begin
            Result := SetStatus(STS_ERROR, 'GEN001', 'Transação ' + NR_TRANSACAO + '.TRA_S_TRANSAC não cadastrada!', cDS_METHOD);
            return(-1); exit;
          end;
          setocc(tF_TRA_TRANSAC, curocc(tF_TRA_TRANSAC) + 1);
        end;
      end;
    until (vInAchou := False);
  end;

  clear_e(tF_TRA_TRANSAC);
  putitem_e(tF_TRA_TRANSAC, 'CD_EMPRESAORI', vCdEmpresa);
  putitem_e(tF_TRA_TRANSAC, 'NR_TRANSACAOORI', vNrTransacao);
  putitem_e(tF_TRA_TRANSAC, 'DT_TRANSACAOORI', vDtTransacao);
  retrieve_e(tF_TRA_TRANSAC);
  if (xStatus >= 0) then begin
    clear_e(tCMC_SOLIMATIT);
    putitem_e(tCMC_SOLIMATIT, 'CD_EMPTRANSACAO', item_f('CD_EMPRESA', tF_TRA_TRANSAC));
    putitem_e(tCMC_SOLIMATIT, 'NR_TRANSACAO', item_f('NR_TRANSACAO', tF_TRA_TRANSAC));
    putitem_e(tCMC_SOLIMATIT, 'DT_TRANSACAO', item_a('DT_TRANSACAO', tF_TRA_TRANSAC));
    retrieve_e(tCMC_SOLIMATIT);
    if (xStatus >= 0) then begin
      creocc(tTRA_S_TRANSAC, -1);
      putitem_e(tTRA_S_TRANSAC, 'CD_EMPRESA', item_f('CD_EMPRESA', tF_TRA_TRANSAC));
      putitem_e(tTRA_S_TRANSAC, 'NR_TRANSACAO', item_f('NR_TRANSACAO', tF_TRA_TRANSAC));
      putitem_e(tTRA_S_TRANSAC, 'DT_TRANSACAO', item_a('DT_TRANSACAO', tF_TRA_TRANSAC));
      retrieve_o(tTRA_S_TRANSAC);
      if (xStatus = -7) then begin
        retrieve_x(tTRA_S_TRANSAC);
      end else if (xStatus = 0) then begin
        Result := SetStatus(STS_ERROR, 'GEN001', 'Transação ' + NR_TRANSACAO + '.TRA_S_TRANSAC não cadastrada!', cDS_METHOD);
        return(-1); exit;
      end;
    end;
  end;
  if (empty(tTRA_S_TRANSAC) = False) then begin
    vDsLstTransacao := '';
    setocc(tTRA_S_TRANSAC, -1);
    setocc(tTRA_S_TRANSAC, 1);
    while (xStatus >= 0) do begin

      if (vInCancelada = True)  or (item_f('TP_SITUACAO', tTRA_S_TRANSAC) <> 6) then begin
        vDsRegistro := '';
        putitemXml(vDsRegistro, 'CD_EMPRESA', item_f('CD_EMPRESA', tTRA_S_TRANSAC));
        putitemXml(vDsRegistro, 'NR_TRANSACAO', item_f('NR_TRANSACAO', tTRA_S_TRANSAC));
        putitemXml(vDsRegistro, 'DT_TRANSACAO', item_a('DT_TRANSACAO', tTRA_S_TRANSAC));
        putitem(vDsLstTransacao,  vDsRegistro);
      end;

      setocc(tTRA_S_TRANSAC, curocc(tTRA_S_TRANSAC) + 1);
    end;
    Result := '';
    putitemXml(Result, 'DS_LSTTRANSACAO', vDsLstTransacao);
  end;

  return(0); exit;
end;

//----------------------------------------------------------------
function T_TRASVCO013.cancelaTransacao(pParams : String) : String;
//----------------------------------------------------------------
const
  cDS_METHOD = 'ADICIONAL=Operação: T_TRASVCO013.cancelaTransacao()';
var
  vDtTransacao, vDtLiq, vDtSistema : TDate;
  viParams, voParams, vDsObs, vDsLstNF, vDsLstConsignado, vTpLiq, vDsCaixa : String;
  vDsMotivo, vDsRegistro, vDsLstTransacao, vTpQuantidadePED, vDsLstSerial : String;
  vDsRegStatus, vDsLstStatusRep, vDsLstStatusNormal, vNmUsuario, vCdCodBarras : String;
  vInSoFinanceiro, vInFinanceiro, vInAchou, vInEstoque, vInCxFechado, vInEstornaCxUsu, vInAchouAgrupador, vInPedido : Boolean;
  vInTrocaDocumento, vInEstoqueNao, vInOrigem, vInCancelar , vInSemInspecao, vInUtilizaCxFilialMov, vInSupreCaixa : Boolean;
  vInValidaChqPresente, vInIgnoraCancECF : Boolean;
  vCdEmpresa, vNrTransacao, vCdEmpLiq, vNrSeqLiq, vCdUsuario, vCdConferente, vNrTransacaoOri, vQtFaturado : Real;
  vQtPendente, vTpContrInspSaldoLote, vVlSaldo, vNrCaixa, vCdCtaPesCxFilialMov, vCdCtaPesCxMatrizMov, vVlDiferenca : Real;
begin
  vCdEmpresa := itemXmlF('CD_EMPRESA', pParams);
  vNrTransacao := itemXmlF('NR_TRANSACAO', pParams);
  vDtTransacao := itemXml('DT_TRANSACAO', pParams);
  vDsMotivo := itemXml('DS_MOTIVO', pParams);
  gvTpSituacaoNF := itemXmlF('TP_SITUACAONF', pParams);
  vTpQuantidadePED := itemXmlF('TP_QUANTIDADEPED', pParams);
  vInSoFinanceiro := itemXmlB('IN_SOFINANCEIRO', pParams);
  vCdConferente := itemXmlF('CD_CONFERENTE', pParams);
  gCdComponente := itemXmlF('CD_COMPONENTE', pParams);
  vInCxFechado := itemXmlB('IN_CXFECHADO', pParams);
  vInEstoqueNao := itemXmlB('IN_ESTOQUENAO', pParams);
  vInEstornaCxUsu := itemXmlB('IN_ESTORNACXUXU', pParams);
  vInOrigem := itemXmlB('IN_ORIGEM', pParams);
  vDtSistema := itemXml('DT_SISTEMA', PARAM_GLB);
  vCdUsuario := itemXmlF('CD_USUARIO', PARAM_GLB);
  vInPedido := itemXmlB('IN_PEDIDO', pParams);
  vInTrocaDocumento := itemXmlB('IN_TROCADOCUMENTO', pParams);
  vInSemInspecao := itemXmlB('IN_SEMINSPECAO', pParams);
  vInValidaChqPresente := itemXmlB('IN_VALIDACHQPRESENTE', pParams);
  vInIgnoraCancECF := itemXmlB('IN_IGNORACANCECF', pParams);

  vTpContrInspSaldoLote := itemXmlF('TP_CONTR_INSP_SALDO_LOTE', PARAM_GLB);

  if (vInPedido = '') then begin
    vInPedido := True;
  end;
  if (gCdComponente = '') then begin
    gCdComponente := TRASVCO013;
  end;
  if (vInValidaChqPresente = '') then begin
    vInValidaChqPresente := True;
  end;
  if (vCdEmpresa = 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN001', 'Empresa origem não informada!', cDS_METHOD);
    return(-1); exit;
  end;
  if (vNrTransacao = 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN001', 'Número transação origem não informado', cDS_METHOD);
    return(-1); exit;
  end;
  if (vDtTransacao = '') then begin
    Result := SetStatus(STS_ERROR, 'GEN001', 'Data transação origem não informada', cDS_METHOD);
    return(-1); exit;
  end;
  if (vDsMotivo = '') then begin
    Result := SetStatus(STS_ERROR, 'GEN001', 'Motivo de cancelamento não informado', cDS_METHOD);
    return(-1); exit;
  end;

  vDsMotivo := 'MOTIVO: ' + vDsMotivo' + ';
  vDsMotivo := vDsMotivo[1 : 80];

  if (gvTpSituacaoNF = '') then begin
    Result := SetStatus(STS_ERROR, 'GEN001', 'Situação da NF não informada', cDS_METHOD);
    return(-1); exit;
  end;
  if (vTpQuantidadePED = '')  and (vInPedido = True) then begin
    Result := SetStatus(STS_ERROR, 'GEN001', 'Tipo de quantidade do pedido de compra da NF não informada', cDS_METHOD);
    return(-1); exit;
  end;

  clear_e(tADM_USUARIO);

  if (vCdConferente > 0) then begin
    putitem_e(tADM_USUARIO, 'CD_USUARIO', vCdConferente);
    retrieve_e(tADM_USUARIO);
    if (xStatus < 0) then begin
      Result := SetStatus(STS_ERROR, 'GEN001', 'Usuário de conferência ' + FloatToStr(vCdConferente) + ' não cadastrado', cDS_METHOD);
      return(-1); exit;
    end;
  end;

  clear_e(tTRA_TRANSACAO);
  putitem_e(tTRA_TRANSACAO, 'CD_EMPRESA', vCdEmpresa);
  putitem_e(tTRA_TRANSACAO, 'NR_TRANSACAO', vNrTransacao);
  putitem_e(tTRA_TRANSACAO, 'DT_TRANSACAO', vDtTransacao);
  retrieve_e(tTRA_TRANSACAO);
  if (xStatus < 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN001', 'Transação ' + FloatToStr(vNrTransacao) + ' não cadastrada!', cDS_METHOD);
    return(-1); exit;
  end;
  if (item_f('TP_SITUACAO', tTRA_TRANSACAO) = 6) then begin
    return(0); exit;
  end;
  if (item_f('TP_SITUACAO', tTRA_TRANSACAO) = 4) then begin
    if (item_b('IN_FINANCEIRO', tGER_OPERACAO) <> False) then begin
      vInFinanceiro := True;
    end;
  end;

  getParams(pParams); (* item_f('CD_EMPFAT', tTRA_TRANSACAO) *)
  if (xStatus < 0) then begin
    return(-1); exit;
  end;

  voParams := validaCancelamentoNFE(viParams); (* *)
  if (xStatus < 0) then begin
    return(-1); exit;
  end;
  if (gTpValidacaoCancEcf = 1)  and (vInIgnoraCancECF = False) then begin
    voParams := validaCancelamentoCupom(viParams); (* *)
    if (xStatus < 0) then begin
      Result := voParams;
      return(-1); exit;
    end;
  end;

  clear_e(tMKT_CARTELAI);
  putitem_e(tMKT_CARTELAI, 'CD_EMPR', itemXmlF('CD_EMPRESA', pParams));
  putitem_e(tMKT_CARTELAI, 'NR_TRANSACAO', itemXmlF('NR_TRANSACAO', pParams));
  putitem_e(tMKT_CARTELAI, 'DT_TRANSACAO', itemXml('DT_TRANSACAO', pParams));
  retrieve_e(tMKT_CARTELAI);
  if (xStatus >= 0) then begin
    putitemXml(viParams, 'CD_EMPRESA', vCdEmpresa);
    putitemXml(viParams, 'NR_TRANSACAO', vNrTransacao);
    putitemXml(viParams, 'DT_TRANSACAO', vDtTransacao);
    voParams := activateCmp('MKTSVCO004', 'AlteraSituacaoCartela', viParams); (*,,,, *)
    if (xStatus < 0) then begin
      Result := voParams;
      return(-1); exit;
    end;
  end;

  vCdEmpLiq := '';
  vNrSeqLiq := '';
  vDtLiq := '';

  if (vInFinanceiro = True) then begin
    vInAchou := False;

    if (item_f('TP_OPERACAO', tTRA_TRANSACAO) = 'E')  and (item_f('TP_MODALIDADE', tGER_OPERACAO) = 1 ) or (item_f('TP_MODALIDADE', tGER_OPERACAO) = 2 ) or (item_f('TP_MODALIDADE', tGER_OPERACAO) = 4 ) or (item_f('TP_MODALIDADE', tGER_OPERACAO) = 5 ) or (item_f('TP_MODALIDADE', tGER_OPERACAO) = 'E') then begin
      vTpLiq := 'CP';
      clear_e(tFGR_LIQITEMCC);
      putitem_e(tFGR_LIQITEMCC, 'CD_EMPTRANSACAO', item_f('CD_EMPRESA', tTRA_TRANSACAO));
      putitem_e(tFGR_LIQITEMCC, 'NR_TRANSACAO', item_f('NR_TRANSACAO', tTRA_TRANSACAO));
      putitem_e(tFGR_LIQITEMCC, 'DT_TRANSACAO', item_a('DT_TRANSACAO', tTRA_TRANSACAO));
      retrieve_e(tFGR_LIQITEMCC);
      if (xStatus >= 0) then begin
        setocc(tFGR_LIQITEMCC, 1);
        while (xStatus >= 0)  and (vInAchou := False) do begin
          clear_e(tFGR_LIQ);
          putitem_e(tFGR_LIQ, 'CD_EMPLIQ', item_f('CD_EMPLIQ', tFGR_LIQITEMCC));
          putitem_e(tFGR_LIQ, 'DT_LIQ', item_a('DT_LIQ', tFGR_LIQITEMCC));
          putitem_e(tFGR_LIQ, 'NR_SEQLIQ', item_f('NR_SEQLIQ', tFGR_LIQITEMCC));
          retrieve_e(tFGR_LIQ);
          if (xStatus >= 0) then begin
            if (item_a('DT_CANCELAMENTO', tFGR_LIQ) = '')  and (item_f('CD_EMPRESADUP', tFGR_LIQITEMCC) > 0 ) and (item_f('CD_FORNECDUP', tFGR_LIQITEMCC) > 0 ) and (item_f('NR_DUPLICATADUP', tFGR_LIQITEMCC) > 0 ) and (item_f('NR_PARCELADUP', tFGR_LIQITEMCC) > 0) then begin
              vCdEmpLiq := item_f('CD_EMPLIQ', tFGR_LIQITEMCC);
              vDtLiq := item_a('DT_LIQ', tFGR_LIQITEMCC);
              vNrSeqLiq := item_f('NR_SEQLIQ', tFGR_LIQITEMCC);
              vInAchou := True;
            end;
          end;
          setocc(tFGR_LIQITEMCC, curocc(tFGR_LIQITEMCC) + 1);
        end;
      end;
    end else begin
      vTpLiq := 'CR';
      clear_e(tFGR_LIQITEMCR);
      putitem_e(tFGR_LIQITEMCR, 'CD_EMPTRANSACAO', item_f('CD_EMPRESA', tTRA_TRANSACAO));
      putitem_e(tFGR_LIQITEMCR, 'NR_TRANSACAO', item_f('NR_TRANSACAO', tTRA_TRANSACAO));
      putitem_e(tFGR_LIQITEMCR, 'DT_TRANSACAO', item_a('DT_TRANSACAO', tTRA_TRANSACAO));
      retrieve_e(tFGR_LIQITEMCR);
      if (xStatus >= 0) then begin
        setocc(tFGR_LIQITEMCR, 1);
        while (xStatus >= 0)  and (vInAchou := False) do begin
          clear_e(tFGR_LIQ);
          putitem_e(tFGR_LIQ, 'CD_EMPLIQ', item_f('CD_EMPLIQ', tFGR_LIQITEMCR));
          putitem_e(tFGR_LIQ, 'DT_LIQ', item_a('DT_LIQ', tFGR_LIQITEMCR));
          putitem_e(tFGR_LIQ, 'NR_SEQLIQ', item_f('NR_SEQLIQ', tFGR_LIQITEMCR));
          retrieve_e(tFGR_LIQ);
          if (xStatus >= 0) then begin
            if (item_f('TP_LIQUIDACAO', tFGR_LIQ) = 82)  and (item_f('TP_TIPOREG', tFGR_LIQITEMCR) = 2)  and (vInValidaChqPresente = True) then begin
              Result := SetStatus(STS_AVISO, 'GEN001', 'Não é possível cancelar transação de cheque presente por este componente.Utilizar o FCRFP003 para cancelar a liquidação nr.' + NR_SEQLIQ + '.FGR_LIQ.', cDS_METHOD);
              return(-1); exit;
            end;
            if (item_a('DT_CANCELAMENTO', tFGR_LIQ) = '') then begin
              vCdEmpLiq := item_f('CD_EMPLIQ', tFGR_LIQITEMCR);
              vDtLiq := item_a('DT_LIQ', tFGR_LIQITEMCR);
              vNrSeqLiq := item_f('NR_SEQLIQ', tFGR_LIQITEMCR);
              vInAchou := True;
            end;
          end;

          setocc(tFGR_LIQITEMCR, curocc(tFGR_LIQITEMCR) + 1);
        end;
      end;
      if (item_f('TP_OPERACAO', tTRA_TRANSACAO) = 'S')  and (item_f('TP_MODALIDADE', tGER_OPERACAO) <> 3)  and (vNrSeqLiq > 0) then begin
        if (vInCxFechado <> True) then begin
          vInAchou := False;
          clear_e(tFCC_MOV);
          putitem_e(tFCC_MOV, 'CD_EMPLIQ', vCdEmpLiq);
          putitem_e(tFCC_MOV, 'DT_LIQ', vDtLiq);
          putitem_e(tFCC_MOV, 'NR_SEQLIQ', vNrSeqLiq);
          retrieve_e(tFCC_MOV);
          if (xStatus >= 0) then begin
            setocc(tFCC_MOV, 1);
            while (xStatus >= 0)  and (vInAchou := False) do begin

              if (item_f('CD_HISTORICO', tFCC_MOV) = 930)  or (item_f('CD_HISTORICO', tFCC_MOV) = 935) then begin
                clear_e(tFCX_CAIXAM);
                putitem_e(tFCX_CAIXAM, 'NR_CTAPES', item_f('NR_CTAPES', tFCC_MOV));
                putitem_e(tFCX_CAIXAM, 'DT_MOVIM', item_a('DT_MOVIM', tFCC_MOV));
                putitem_e(tFCX_CAIXAM, 'NR_SEQMOV', item_f('NR_SEQMOV', tFCC_MOV));
                retrieve_e(tFCX_CAIXAM);
                if (xStatus >= 0) then begin
                  if (gInCancTransCxFechado = False) then begin
                    if (item_b('IN_FECHADO', tFCX_CAIXAC) > 0) then begin
                      Result := SetStatus(STS_ERROR, 'GEN001', 'O caixa onde a transação ' + FloatToStr(vNrTransacao) + ' foi recebida está fechado!', cDS_METHOD);
                      return(-1); exit;
                    end else begin

                      if (item_f('CD_OPERCONF', tFCX_CAIXAC) > 0) then begin
                        Result := SetStatus(STS_ERROR, 'GEN001', 'O caixa onde a transação ' + FloatToStr(vNrTransacao) + ' foi recebida está com a contagem fechada.Reabrir contagem para cancelar transação.', cDS_METHOD);
                        exit(-2);
                      end;
                    end;
                  end else if (gInCancTransCxFechado = True) then begin
                    if (item_b('IN_FECHADO', tFCX_CAIXAC) > 0) then begin
                      Result := SetStatus(STS_AVISO, 'GEN001', 'O caixa onde a transação ' + FloatToStr(vNrTransacao) + ' foi recebida está fechado! O cancelamento pode ocasionar diferença no caixa.', cDS_METHOD);
                      exit(-2);
                    end else begin
                      if (item_f('CD_OPERCONF', tFCX_CAIXAC) > 0) then begin
                        Result := SetStatus(STS_ERROR, 'GEN001', 'O caixa onde a transação ' + FloatToStr(vNrTransacao) + ' foi recebida está com a contagem fechada.Reabrir contagem para cancelar transação.', cDS_METHOD);
                        return(-1); exit;
                      end;
                    end;
                  end;

                  vInAchou := True;
                end;
              end;
              setocc(tFCC_MOV, curocc(tFCC_MOV) + 1);
            end;
          end;

        end else begin
          if (gInCancTransCxFechado = False) then begin
            Result := SetStatus(STS_ERROR, 'GEN001', 'O caixa onde a transação ' + FloatToStr(vNrTransacao) + ' foi recebida está fechado!', cDS_METHOD);
            exit(-2);
          end;
        end;
      end;
    end;
    if (vCdEmpLiq <> '')  and (vDtLiq <> '')  and (vNrSeqLiq <> '') then begin
      voParams := validaFatDupContabilidade(viParams); (* vCdEmpLiq, vDtLiq, vNrSeqLiq, vTpLiq *)
      if (xStatus < 0) then begin
        Result := voParams;
        return(-1); exit;
      end;
    end;
  end;

  vDsLstTransacao := '';
  vDsRegistro := '';
  putitemXml(vDsRegistro, 'CD_EMPRESA', item_f('CD_EMPRESA', tTRA_TRANSACAO));
  putitemXml(vDsRegistro, 'NR_TRANSACAO', item_f('NR_TRANSACAO', tTRA_TRANSACAO));
  putitemXml(vDsRegistro, 'DT_TRANSACAO', item_a('DT_TRANSACAO', tTRA_TRANSACAO));
  putitem(vDsLstTransacao,  vDsRegistro);

  if (vInSoFinanceiro = True) then begin
    if (item_f('TP_SITUACAO', tTRA_TRANSACAO) = 4) then begin
      vDsLstNF := '';
      if (empty(tFIS_NF) = False) then begin
        setocc(tFIS_NF, 1);
        while (xStatus >= 0) do begin
          putitemXml(vDsRegistro, 'CD_EMPRESA', item_f('CD_EMPRESA', tFIS_NF));
          putitemXml(vDsRegistro, 'NR_FATURA', item_f('NR_FATURA', tFIS_NF));
          putitemXml(vDsRegistro, 'DT_FATURA', item_a('DT_FATURA', tFIS_NF));
          putitem(vDsLstNF,  vDsRegistro);
          setocc(tFIS_NF, curocc(tFIS_NF) + 1);
        end;
      end;

      vInEstoque := False;

      if ((item_f('TP_DOCTO', tGER_OPERACAO) = 2 ) or (item_f('TP_DOCTO', tGER_OPERACAO) = 3)  and vInTrocaDocumento <> True ) and (item_f('TP_MODALIDADE', tGER_OPERACAO) <> 9) then begin
        vInEstoque := True;
      end;
      if (vInEstoqueNao = True) then begin
        vInEstoque := False;
      end;
      if (vInEstoque = True) then begin
        viParams := '';
        putitemXml(viParams, 'DS_LSTTRANSACAO', vDsLstTransacao);
        putitemXml(viParams, 'IN_ESTORNO', True);
        voParams := activateCmp('TRASVCO004', 'atualizaEstoqueTransacao', viParams); (*,,,, *)
        if (xStatus < 0) then begin
          Result := voParams;
          return(-1); exit;
        end;
        if (vDsLstNF <> '') then begin
          viParams := '';
          putitemXml(viParams, 'DS_LSTNF', vDsLstNF);
          putitemXml(viParams, 'IN_ESTORNO', True);
          putitemXml(viParams, 'IN_SEMINSPECAO', vInSemInspecao);
          voParams := activateCmp('FISSVCO038', 'atualizaEstoqueNF', viParams); (*,,,, *)

          if (xStatus < 0) then begin
            Result := voParams;
            return(-1); exit;
          end;
        end;
      end;

      viParams := '';
      putitemXml(viParams, 'DS_LSTTRANSACAO', vDsLstTransacao);
      putitemXml(viParams, 'TP_SITUACAO', 5);
      putitemXml(viParams, 'DS_MOTIVOALT', vDsMotivo);
      voParams := activateCmp('TRASVCO004', 'alteraSituacaoTransacao', viParams); (*,,,, *)
      if (xStatus < 0) then begin
        Result := voParams;
        return(-1); exit;
      end;
    end;

    gDtAtual := Now;
    vDsObs := 'Financeiro da transacao cancelado pelo usuario ' + FloatToStr(vCdUsuario) + ' em ' + gDtAtual' + ';

    if (vInFinanceiro = True)  and (vNrSeqLiq > 0) then begin
      if (item_f('TP_OPERACAO', tTRA_TRANSACAO) = 'E')  and (item_f('TP_MODALIDADE', tGER_OPERACAO) = 1 ) or (item_f('TP_MODALIDADE', tGER_OPERACAO) = 2 ) or (item_f('TP_MODALIDADE', tGER_OPERACAO) = 4 ) or (item_f('TP_MODALIDADE', tGER_OPERACAO) = 5 ) or (item_f('TP_MODALIDADE', tGER_OPERACAO) = 'E') then begin
        viParams := '';
        putitemXml(viParams, 'CD_EMPLIQ', vCdEmpLiq);
        putitemXml(viParams, 'DT_LIQ', vDtLiq);
        putitemXml(viParams, 'NR_SEQLIQ', vNrSeqLiq);
        voParams := activateCmp('FCPSVCO046', 'estornaRetencaoImposto', viParams); (*,,,, *)
        if (xStatus < 0) then begin
          Result := voParams;
          return(-1); exit;
        end;

        viParams := '';
        putitemXml(viParams, 'CD_EMPLIQ', vCdEmpLiq);
        putitemXml(viParams, 'DT_LIQ', vDtLiq);
        putitemXml(viParams, 'NR_SEQLIQ', vNrSeqLiq);
        putitemXml(viParams, 'TP_CANCELAMENTO', 'C');
        putitemXml(viParams, 'CD_COMPONENTE', gCdComponente);
        putitemXml(viParams, 'DS_OBS', vDsMotivo);
        putitemXml(viParams, 'DS_LOG', vDsObs);
        voParams := activateCmp('FCPSVCO013', 'cancelaLiquidacao', viParams); (*,,,, *)
        if (xStatus < 0) then begin
          Result := voParams;
          return(-1); exit;
        end;
      end else begin

        viParams := '';
        putitemXml(viParams, 'CD_EMPLIQ', vCdEmpLiq);
        putitemXml(viParams, 'DT_LIQ', vDtLiq);
        putitemXml(viParams, 'NR_SEQLIQ', vNrSeqLiq);
        voParams := activateCmp('FCPSVCO046', 'estornaRetencaoImposto', viParams); (*,,,, *)
        if (xStatus < 0) then begin
          Result := voParams;
          return(-1); exit;
        end;

        viParams := '';
        putitemXml(viParams, 'CD_EMPLIQ', vCdEmpLiq);
        putitemXml(viParams, 'DT_LIQ', vDtLiq);
        putitemXml(viParams, 'NR_SEQLIQ', vNrSeqLiq);
        putitemXml(viParams, 'DS_MOTIVOCANC', vDsMotivo);
        putitemXml(viParams, 'DS_COMPONENTE', gCdComponente);

        voParams := activateCmp('FCRSVCO010', 'cancelaLiquidacao', viParams); (*,,,, *)
        if (xStatus < 0) then begin
          Result := voParams;
          return(-1); exit;
        end;

        clear_e(tFCC_MOV);
        putitem_e(tFCC_MOV, 'CD_EMPLIQ', vCdEmpLiq);
        putitem_e(tFCC_MOV, 'DT_LIQ', vDtLiq);
        putitem_e(tFCC_MOV, 'NR_SEQLIQ', vNrSeqLiq);
        retrieve_e(tFCC_MOV);
        if (xStatus >= 0) then begin
          setocc(tFCC_MOV, 1);
          while (xStatus >= 0) do begin

            if (gInSuprimentoAutomatico = True) then begin
              clear_e(tFCC_CTAPES);
              putitem_e(tFCC_CTAPES, 'NR_CTAPES', item_f('NR_CTAPES', tFCC_MOV));
              retrieve_e(tFCC_CTAPES);
              if (xStatus >= 0)  and (item_f('TP_MANUTENCAO', tFCC_CTAPES) = gCdTpManutCxUsuario)  and %\ then begin
                (vInCxFechado <> True)  and (item_f('TP_DOCUMENTO', tFCC_MOV) <> 9);

                viParams := '';
                putitemXml(viParams, 'NR_CTAPES', item_f('NR_CTAPES', tFCC_MOV));
                putitemXml(viParams, 'TP_DOCUMENTO', item_f('TP_DOCUMENTO', tFCC_MOV));
                putitemXml(viParams, 'NR_SEQHISTRELSUB', item_f('NR_SEQHISTRELSUB', tFCC_MOV));
                putitemXml(viParams, 'DT_SALDO', itemXml('DT_SISTEMA', PARAM_GLB));
                voParams := activateCmp('FCCSVCO002', 'buscaSaldoCtaTp', viParams); (*,,'',,, *)
                if (xStatus < 0) then begin
                  Result := voParams;
                  return(-1); exit;
                end;
                vVlSaldo := itemXmlF('VL_SALDO', voParams);

                if (vVlSaldo < item_f('VL_LANCTO', tFCC_MOV)) then begin
                  viParams= '';
                  putitem(viParams,  'IN_UTILIZA_CXFILIAL');
                  putitem(viParams,  'CD_CTAPES_CXMATRIZ');
                  putitem(viParams,  'CD_CTAPES_CXFILIAL');
                  xParamEmp := T_ADMSVCO001.GetParamEmpresa(piCdEmpresa, xParamEmp); (*item_f('CD_EMPRESA', tFCC_MOV),,,, *)
                  vInUtilizaCxFilialMov := itemXmlB('IN_UTILIZA_CXFILIAL', voParams);
                  vCdCtaPesCxMatrizMov := itemXmlF('CD_CTAPES_CXMATRIZ', voParams);
                  vCdCtaPesCxFilialMov := itemXmlF('CD_CTAPES_CXFILIAL', voParams);

                  if (vInUtilizaCxFilialMov = True) then begin
                    vDsCaixa := 'Filial';
                    vNrCaixa := vCdCtaPesCxFilialMov;
                  end else begin
                    vDsCaixa := 'Matriz';
                    vNrCaixa := vCdCtaPesCxMatrizMov;
                  end;
                  if (vInSupreCaixa <> True) then begin
                    askmess/question 'Saldo da conta insuficiente para realizar o cancelamento. Realizar suprimento do caixa ' + vDsCaixa?', + ' 'Não, Sim';
                    if (xStatus = 1) then begin
                      Result := SetStatus(STS_AVISO, 'GEN001', 'Cancelamento não realizado.', cDS_METHOD);
                      return(-1); exit;
                    end;
                    vInSupreCaixa := True;
                  end;

                  vVlDiferenca := item_f('VL_LANCTO', tFCC_MOV) - vVlSaldo;
                  vVlDiferenca := rounded(vVlDiferenca, 2);

                  clear_e(tFCX_CAIXAM);
                  putitem_e(tFCX_CAIXAM, 'NR_CTAPES', item_f('NR_CTAPES', tFCC_MOV));
                  putitem_e(tFCX_CAIXAM, 'DT_MOVIM', item_a('DT_MOVIM', tFCC_MOV));
                  putitem_e(tFCX_CAIXAM, 'NR_SEQMOV', item_f('NR_SEQMOV', tFCC_MOV));
                  retrieve_e(tFCX_CAIXAM);
                  if (xStatus < 0) then begin
                    Result := SetStatus(STS_AVISO, 'GEN001', 'Movimento não está relacionado a um caixa!', cDS_METHOD);
                    return(-1); exit;
                  end;

                  viParams := '';
                  putitemXml(viParams, 'NR_CTAORIGEM', vNrCaixa);
                  putitemXml(viParams, 'NR_CTADESTINO', item_f('NR_CTAPES', tFCC_MOV));
                  putitemXml(viParams, 'VL_SUPRIMENTO', vVlDiferenca);
                  putitemXml(viParams, 'CD_TERMINALDEST', item_f('CD_TERMINAL', tFCX_CAIXAM));
                  putitemXml(viParams, 'DT_ABERTURADEST', item_a('DT_ABERTURA', tFCX_CAIXAM));
                  putitemXml(viParams, 'NR_SEQDEST', item_f('NR_SEQ', tFCX_CAIXAM));
                  putitemXml(viParams, 'DS_OBS', 'SUPRIMENTO REF. CANCEL. TRANSACAO ' + NR_TRANSACAO + '.TRA_TRANSACAO');
                  putitemXml(viParams, 'IN_CXUSUARIO', False);
                  putitemXml(viParams, 'TP_PROCESSO', 3);
                  putitemXml(viParams, 'TP_DOCUMENTO', item_f('TP_DOCUMENTO', tFCC_MOV));
                  putitemXml(viParams, 'NR_SEQHISTRELSUB', item_f('NR_SEQHISTRELSUB', tFCC_MOV));
                  voParams := activateCmp('FCXSVCO002', 'supreCaixa', viParams); (*,,,, *)
                  if (xStatus < 0) then begin
                    Result := voParams;
                    return(-1); exit;
                  end;
                end;
              end;
            end;
            if (item_f('CD_HISTORICO', tFCC_MOV) = 930)  or (item_f('CD_HISTORICO', tFCC_MOV) = 935) then begin
              if (vInCxFechado = True) then begin
                if (item_f('TP_DOCUMENTO', tFCC_MOV) = 3 ) or (item_f('TP_DOCUMENTO', tFCC_MOV) = 9) then begin
                  viParams := '';
                  putitemXml(viParams, 'CD_EMPRESA', item_f('CD_EMPRESA', tFCC_MOV));
                  if (gInEnvioRecebMalote) then begin
                    if (gNrCtaMatriz = '') then begin
                      Result := SetStatus(STS_ERROR, 'GEN001', 'Conta não informada! Verificar o parâmetro CD_CTAPES_CXMATRIZ', cDS_METHOD);
                      return(-1); exit;
                    end else begin

                      putitemXml(viParams, 'NR_CTAPES', gNrCtaMatriz);
                    end;
                  end else begin
                    if (gInUtilizaCxFilial = True) then begin
                      if (gCdCtaPesCxFilial = '') then begin
                        Result := SetStatus(STS_ERROR, 'GEN001', 'Conta não informada! Verificar o parâmetro CD_CTAPES_CXFILIAL', cDS_METHOD);
                        return(-1); exit;
                      end else begin

                        putitemXml(viParams, 'NR_CTAPES', gCdCtaPesCxFilial);
                      end;
                    end else begin

                      if (gNrCtaMatriz = '') then begin
                        Result := SetStatus(STS_ERROR, 'GEN001', 'Conta não informada! Verificar o parâmetro CD_CTAPES_CXMATRIZ', cDS_METHOD);
                        return(-1); exit;
                      end else begin

                        putitemXml(viParams, 'NR_CTAPES', gNrCtaMatriz);
                      end;
                    end;
                  end;

                  putitemXml(viParams, 'DT_MOVIMENTO', itemXml('DT_SISTEMA', PARAM_GLB));
                  if (item_f('TP_OPERACAO', tFCC_MOV) = 'C') then begin
                    putitemXml(viParams, 'CD_HISTORICO', 962);
                  end else begin
                    putitemXml(viParams, 'CD_HISTORICO', 963);
                  end;
                  putitemXml(viParams, 'VL_LANCTO', item_f('VL_LANCTO', tFCC_MOV));
                  putitemXml(viParams, 'IN_ESTORNO', 'N');
                  putitemXml(viParams, 'TP_DOCUMENTO', item_f('TP_DOCUMENTO', tFCC_MOV));
                  putitemXml(viParams, 'NR_SEQHISTRELSUB', item_f('NR_SEQHISTRELSUB', tFCC_MOV));
                  putitemXml(viParams, 'DS_AUX', 'TRANSACAO: ' + NR_TRANSACAO + '.TRA_TRANSACAO');
                  voParams := activateCmp('FCCSVCO002', 'movimentaConta', viParams); (*,,,,, *)
                  if (xStatus < 0) then begin
                    Result := voParams;
                    return(-1); exit;
                  end;
                end;
                if (vInEstornaCxUsu = True) then begin
                  viParams := '';
                  putitemXml(viParams, 'NR_CTAPES', item_f('NR_CTAPES', tFCC_MOV));
                  putitemXml(viParams, 'DT_MOVIM', item_a('DT_MOVIM', tFCC_MOV));
                  putitemXml(viParams, 'NR_SEQMOV', item_f('NR_SEQMOV', tFCC_MOV));
                  voParams := activateCmp('FCCSVCO002', 'estornaMovimento', viParams); (*,,,, *)
                  if (xStatus < 0) then begin
                    Result := voParams;
                    return(-1); exit;
                  end;
                end;
              end else begin
                viParams := '';
                putitemXml(viParams, 'NR_CTAPES', item_f('NR_CTAPES', tFCC_MOV));
                putitemXml(viParams, 'DT_MOVIM', item_a('DT_MOVIM', tFCC_MOV));
                putitemXml(viParams, 'NR_SEQMOV', item_f('NR_SEQMOV', tFCC_MOV));
                voParams := activateCmp('FCCSVCO002', 'estornaMovimento', viParams); (*,,,, *)
                if (xStatus < 0) then begin
                  Result := voParams;
                  return(-1); exit;
                end;
              end;
            end;
            if (item_f('CD_HISTORICO', tFCC_MOV) = 1093)  or (item_f('CD_HISTORICO', tFCC_MOV) = 1094) then begin
              if (item_f('CD_HISTORICO', tFCC_MOV) = 1093) then begin
                viParams := '';
                putitemXml(viParams, 'NR_CTAPES', item_f('NR_CTAPES', tFCC_MOV));
                putitemXml(viParams, 'TP_DOCUMENTO', 18);
                putitemXml(viParams, 'NR_SEQHISTRELSUB', 1);
                putitemXml(viParams, 'CD_EMPRESA', item_f('CD_EMPCHQPRES', tFCC_MOV));
                putitemXml(viParams, 'CD_CLIENTE', item_f('CD_CLICHQPRES', tFCC_MOV));
                putitemXml(viParams, 'NR_CHEQUE', item_f('NR_CHEQUEPRES', tFCC_MOV));
                voParams := activateCmp('FCRSVCO068', 'buscaSaldoChequePresente', viParams); (*,,,, *)
                if (xStatus < 0) then begin
                  Result := voParams;
                  return(-1); exit;
                end;
                vVlSaldo := itemXmlF('VL_SALDO', voParams);
                if (vVlSaldo < 0) then begin
                  Result := SetStatus(STS_ERROR, 'GEN0001', 'Não é permitido fazer cancelamento. O saldo da conta ' + NR_CTAPES + '.FCC_MOV está negativo!', cDS_METHOD);
                  return(-1); exit;
                end;
              end;

              viParams := '';
              putitemXml(viParams, 'NR_CTAPES', item_f('NR_CTAPES', tFCC_MOV));
              putitemXml(viParams, 'DT_MOVIM', item_a('DT_MOVIM', tFCC_MOV));
              putitemXml(viParams, 'NR_SEQMOV', item_f('NR_SEQMOV', tFCC_MOV));
              voParams := activateCmp('FCCSVCO002', 'estornaMovimento', viParams); (*,,,, *)
              if (xStatus < 0) then begin
                Result := voParams;
                return(-1); exit;
              end;

              viParams := '';
              putitemXml(viParams, 'NR_CTAPES', item_f('NR_CTAPES', tFCC_MOV));
              putitemXml(viParams, 'DT_MOVIM', item_a('DT_MOVIM', tFCC_MOV));
              putitemXml(viParams, 'NR_SEQMOV', item_f('NR_SEQMOV', tFCC_MOV));
              putitemXml(viParams, 'CD_COMPONENTE', 'TRASVCO013');
              putitemXml(viParams, 'DS_OBS', 'Canc. cheque presente');
              voParams := activateCmp('FCCSVCO002', 'gravaObsMov', viParams); (*,,,, *)
              if (xStatus < 0) then begin
                Result := voParams;
                return(-1); exit;
              end;

              clear_e(tFCR_CHEQUEPRE);
              putitem_e(tFCR_CHEQUEPRE, 'CD_EMPRESA', item_f('CD_EMPCHQPRES', tFCC_MOV));
              putitem_e(tFCR_CHEQUEPRE, 'CD_CLIENTE', item_f('CD_CLICHQPRES', tFCC_MOV));
              putitem_e(tFCR_CHEQUEPRE, 'NR_CHEQUE', item_f('NR_CHEQUEPRES', tFCC_MOV));
              retrieve_e(tFCR_CHEQUEPRE);
              if (xStatus >=0) then begin
                vCdCodBarras := item_f('CD_BARRA', tFCR_CHEQUEPRE);
                clear_e(tFCR_CHEQUEPRE);
                putitem_e(tFCR_CHEQUEPRE, 'CD_BARRA', vCdCodBarras);
                putitem_e(tFCR_CHEQUEPRE, 'TP_SITUACAO', 1);
                retrieve_e(tFCR_CHEQUEPRE);
                if (xStatus >=0) then begin
                  setocc(tFCR_CHEQUEPRE, 1);
                  while (xStatus >= 0) do begin
                    if (item_f('CD_EMPRESA', tFCR_CHEQUEPRE) <> item_f('CD_EMPCHQPRES', tFCC_MOV))  or (item_f('CD_CLIENTE', tFCR_CHEQUEPRE) <> item_f('CD_CLICHQPRES', tFCC_MOV))  or (item_f('NR_CHEQUE', tFCR_CHEQUEPRE) <> item_f('NR_CHEQUEPRES', tFCC_MOV)) then begin
                      Result := SetStatus(STS_ERROR, 'GEN001', 'Existe cheque presente ativo com o código de barras utilizado neste cancelamento. Não é permitido cancelar a transação.', '');
                      return(-1); exit;
                    end;
                    setocc(tFCR_CHEQUEPRE, curocc(tFCR_CHEQUEPRE) + 1);
                  end;
                end;
              end;

              viParams := '';
              putitemXml(viParams, 'NR_CTAPES', item_f('NR_CTAPES', tFCC_MOV));
              putitemXml(viParams, 'TP_DOCUMENTO', 18);
              putitemXml(viParams, 'NR_SEQHISTRELSUB', 1);
              putitemXml(viParams, 'CD_EMPRESA', item_f('CD_EMPCHQPRES', tFCC_MOV));
              putitemXml(viParams, 'CD_CLIENTE', item_f('CD_CLICHQPRES', tFCC_MOV));
              putitemXml(viParams, 'NR_CHEQUE', item_f('NR_CHEQUEPRES', tFCC_MOV));
              voParams := activateCmp('FCRSVCO068', 'buscaSaldoChequePresente', viParams); (*,,,, *)
              if (xStatus < 0) then begin
                Result := voParams;
                return(-1); exit;
              end;
              vVlSaldo := itemXmlF('VL_SALDO', voParams);
              if (vVlSaldo = 0) then begin
                if (item_f('CD_EMPCHQPRES', tFCC_MOV) <> '')  and (item_f('CD_CLICHQPRES', tFCC_MOV) <> '')  and (item_f('NR_CHEQUEPRES', tFCC_MOV) <> '') then begin
                  viParams := '';
                  putitemXml(viParams, 'CD_EMPRESA', item_f('CD_EMPCHQPRES', tFCC_MOV));
                  putitemXml(viParams, 'CD_CLIENTE', item_f('CD_CLICHQPRES', tFCC_MOV));
                  putitemXml(viParams, 'NR_CHEQUE', item_f('NR_CHEQUEPRES', tFCC_MOV));
                  putitemXml(viParams, 'TP_CHEQUE', 1);
                  voParams := activateCmp('FCRSVCO068', 'gravarUtilizacaoChequePresente', viParams); (*,,,, *)
                  if (xStatus < 0) then begin
                    Result := voParams;
                    return(-1); exit;
                  end;
                end;
              end;
            end;

            setocc(tFCC_MOV, curocc(tFCC_MOV) + 1);
          end;
        end;
      end;
    end;
  end else begin
    if (empty(tTRA_TRANSACCO) = False) then begin
      setocc(tTRA_TRANSACCO, 1);
      while (xStatus >= 0) do begin
        clear_e(tPED_PEDIDOCON);
        putitem_e(tPED_PEDIDOCON, 'CD_EMPCONTAGEM', item_f('CD_EMPCONTAGEM', tTRA_TRANSACCO));
        putitem_e(tPED_PEDIDOCON, 'NR_CONTAGEM', item_f('NR_CONTAGEM', tTRA_TRANSACCO));
        retrieve_e(tPED_PEDIDOCON);
        if (xStatus >= 0) then begin
          putitem_e(tPED_PEDIDOCON, 'TP_SITUACAO', 1);
          putitem_e(tPED_PEDIDOCON, 'CD_OPERADOR', itemXmlF('CD_USUARIO', PARAM_GLB));
          putitem_e(tPED_PEDIDOCON, 'DT_CADASTRO', Now);
          voParams := tPED_PEDIDOCON.Salvar();
          if (xStatus < 0) then begin
            Result := voParams;
            return(-1); exit;
          end;
        end;

        clear_e(tPRD_MOSTCONT);
        putitem_e(tPRD_MOSTCONT, 'CD_EMPCONTAGEM', item_f('CD_EMPCONTAGEM', tTRA_TRANSACCO));
        putitem_e(tPRD_MOSTCONT, 'NR_CONTAGEM', item_f('NR_CONTAGEM', tTRA_TRANSACCO));
        retrieve_e(tPRD_MOSTCONT);
        if (xStatus >= 0) then begin
          putitem_e(tPRD_MOSTCONT, 'TP_SITUACAO', 1);
          putitem_e(tPRD_MOSTCONT, 'CD_OPERADOR', itemXmlF('CD_USUARIO', PARAM_GLB));
          putitem_e(tPRD_MOSTCONT, 'DT_CADASTRO', Now);
          voParams := tPRD_MOSTCONT.Salvar();
          if (xStatus < 0) then begin
            Result := voParams;
            return(-1); exit;
          end;
        end;

        voParams := alteraSituacaoContagemOp(viParams); (* *)
        if (xStatus < 0) then begin
          return(-1); exit;
        end;

        setocc(tTRA_TRANSACCO, curocc(tTRA_TRANSACCO) + 1);
      end;
    end;
    if (empty(tIMB_CONTRATOT) = False) then begin
      if (item_f('NR_SEQITEM', tIMB_CONTRATOT) <> '') then begin
        voParams := cancelaItemContrato(viParams); (* item_f('CD_EMPRESA', tIMB_CONTRATO), item_f('NR_SEQ', tIMB_CONTRATO), item_f('NR_SEQITEM', tIMB_CONTRATOT) *)
        if (xStatus < 0) then begin
          return(-1); exit;
        end;
      end else begin

        viParams := '';
        putitemXml(viParams, 'CD_EMPCONTRATO', item_f('CD_EMPRESA', tIMB_CONTRATO));
        putitemXml(viParams, 'NR_SEQCONTRATO', item_f('NR_SEQ', tIMB_CONTRATO));
        putitemXml(viParams, 'CD_COMPONENTE', gCdComponente);
        voParams := activateCmp('IMBSVCO001', 'cancelaContrato', viParams); (*,,,, *)
        if (xStatus < 0) then begin
          Result := voParams;
          return(-1); exit;
        end;
      end;
    end;

    vInEstoque := True;

    if (item_f('TP_DOCTO', tGER_OPERACAO) = 2)  or (item_f('TP_DOCTO', tGER_OPERACAO) = 3) then begin
      if (item_f('TP_SITUACAO', tTRA_TRANSACAO) <> 4) then begin
        vInEstoque := False;
      end;
    end;
    if (vInEstoqueNao = True) then begin
      vInEstoque := False;
    end;
    if ((item_f('TP_SITUACAO', tTRA_TRANSACAO) <> 4 ) and (item_f('TP_SITUACAO', tTRA_TRANSACAO) <> 5)  or item_f('TP_MODALIDADE', tGER_OPERACAO) = 9) then begin
      vInEstoque := False;
    end;
    if (vInEstoque = True) then begin
      viParams := '';
      putitemXml(viParams, 'DS_LSTTRANSACAO', vDsLstTransacao);
      putitemXml(viParams, 'IN_ESTORNO', True);
      voParams := activateCmp('TRASVCO004', 'atualizaEstoqueTransacao', viParams); (*,,,, *)
      if (xStatus < 0) then begin
        Result := voParams;
        return(-1); exit;
      end;
    end;

    viParams := '';
    putitemXml(viParams, 'DS_LSTTRANSACAO', vDsLstTransacao);
    putitemXml(viParams, 'TP_SITUACAO', 6);
    putitemXml(viParams, 'DS_MOTIVOALT', vDsMotivo);
    voParams := activateCmp('TRASVCO004', 'alteraSituacaoTransacao', viParams); (*,,,, *)
    if (xStatus < 0) then begin
      Result := voParams;
      return(-1); exit;
    end;

    clear_e(tTRA_ITEMPRDFI);
    putitem_e(tTRA_ITEMPRDFI, 'CD_EMPRESA', item_f('CD_EMPRESA', tTRA_TRANSACAO));
    putitem_e(tTRA_ITEMPRDFI, 'NR_TRANSACAO', item_f('NR_TRANSACAO', tTRA_TRANSACAO));
    putitem_e(tTRA_ITEMPRDFI, 'DT_TRANSACAO', item_a('DT_TRANSACAO', tTRA_TRANSACAO));
    retrieve_e(tTRA_ITEMPRDFI);
    if (xStatus >= 0) then begin
      setocc(tTRA_ITEMPRDFI, 1);
      while (xStatus >= 0) do begin
        viParams := '';
        putitemXml(viParams, 'CD_EMPRESA', item_f('CD_EMPPRDFIN', tTRA_ITEMPRDFI));
        putitemXml(viParams, 'NR_PRDFIN', item_f('NR_PRDFIN', tTRA_ITEMPRDFI));
        putitemXml(viParams, 'CD_COMPONENTE', gCdComponente);
        voParams := activateCmp('PRFSVCO001', 'cancelaProdutoFinanceiro', viParams); (*,,,, *)
        if (xStatus < 0) then begin
          Result := voParams;
          return(-1); exit;
        end;

        setocc(tTRA_ITEMPRDFI, curocc(tTRA_ITEMPRDFI) + 1);
      end;
    end;

    vDsLstSerial='';
    clear_e(tTRA_ITEMSERIA);
    putitem_e(tTRA_ITEMSERIA, 'CD_EMPRESA', item_f('CD_EMPRESA', tTRA_TRANSACAO));
    putitem_e(tTRA_ITEMSERIA, 'NR_TRANSACAO', item_f('NR_TRANSACAO', tTRA_TRANSACAO));
    putitem_e(tTRA_ITEMSERIA, 'DT_TRANSACAO', item_a('DT_TRANSACAO', tTRA_TRANSACAO));
    retrieve_e(tTRA_ITEMSERIA);
    if (xStatus >= 0) then begin
      setocc(tTRA_ITEMSERIA, 1);
      while (xStatus >= 0) do begin
        if (item_a('DS_SERIAL', tTRA_ITEMSERIA) <> '') then begin
          if (vDsLstSerial = '') then begin
            vDsLstSerial := item_a('DS_SERIAL', tTRA_ITEMSERIA);
          end else begin
            vDsLstSerial := '' + vDsLstSeriaL + ';
          end;
        end;
        setocc(tTRA_ITEMSERIA, curocc(tTRA_ITEMSERIA) + 1);
      end;
      viParams := '';
      if (item_f('TP_OPERACAO', tTRA_TRANSACAO) = 'E') then begin
        putitemXml(viParams, 'TP_SITUACAO', 2);
      end else if (item_f('TP_OPERACAO', tTRA_TRANSACAO) = 'S') then begin
        putitemXml(viParams, 'TP_SITUACAO', 1);
      end;
      putitemXml(viParams, 'CD_PRODUTO', item_f('CD_PRODUTO', tTRA_TRANSITEM));
      putitemXml(viParams, 'DS_LSTSERIAL', vDsLstSerial);
      voParams := activateCmp('PRDSVCO021', 'alteraSituacaoSerialPrd', viParams); (*,,,, *)
      if (xStatus < 0) then begin
        Result := voParams;
        return(-1); exit;
      end;
    end;
    if (item_f('TP_SITUACAO', tTRA_TRANSACAO) > 1) then begin
      vDsLstNF := '';
      if (empty(tFIS_NF) = False) then begin
        setocc(tFIS_NF, 1);
        while (xStatus >= 0) do begin
          putitemXml(vDsRegistro, 'CD_EMPRESA', item_f('CD_EMPRESA', tFIS_NF));
          putitemXml(vDsRegistro, 'NR_FATURA', item_f('NR_FATURA', tFIS_NF));
          putitemXml(vDsRegistro, 'DT_FATURA', item_a('DT_FATURA', tFIS_NF));
          putitem(vDsLstNF,  vDsRegistro);
          setocc(tFIS_NF, curocc(tFIS_NF) + 1);
        end;
      end;
      if (vDsLstNF <> '') then begin
        if (vInEstoque = True) then begin
          viParams := '';
          putitemXml(viParams, 'DS_LSTNF', vDsLstNF);
          putitemXml(viParams, 'IN_ESTORNO', True);
          putitemXml(viParams, 'IN_SEMINSPECAO', vInSemInspecao);
          voParams := activateCmp('FISSVCO038', 'atualizaEstoqueNF', viParams); (*,,,, *)

          if (xStatus < 0) then begin
            Result := voParams;
            return(-1); exit;
          end;
        end;

        viParams := '';
        putitemXml(viParams, 'DS_LSTNF', vDsLstNF);
        putitemXml(viParams, 'TP_SITUACAO', gvTpSituacaoNF);
        putitemXml(viParams, 'DS_MOTIVOALT', vDsMotivo);
        voParams := activateCmp('FISSVCO004', 'alteraSituacaoNF', viParams); (*,,,, *)
        if (xStatus < 0) then begin
          Result := voParams;
          return(-1); exit;
        end;
      end;
    end;
    if (vInPedido = True) then begin
      if (empty('CMP_PEDIDOTRASVC') = 0) then begin
        viParams := '';
        putitemXml(viParams, 'CD_EMPRESA', item_f('CD_EMPRESA', tTRA_TRANSACAO));
        putitemXml(viParams, 'NR_TRANSACAO', item_f('NR_TRANSACAO', tTRA_TRANSACAO));
        putitemXml(viParams, 'DT_TRANSACAO', item_a('DT_TRANSACAO', tTRA_TRANSACAO));
        putitemXml(viParams, 'TP_QUANTIDADE', vTpQuantidadePED);
        putitemXml(viParams, 'CD_COMPONENTE', gCdComponente);
        voParams := activateCmp('CMPSVCO004', 'cancelaBaixa', viParams); (*,,,, *)
        if (xStatus < 0) then begin
          Result := voParams;
          return(-1); exit;
        end;
      end else if (empty('PED_PEDIDOTRASVC') = 0) then begin
        viParams := '';
        putitemXml(viParams, 'CD_EMPRESA', item_f('CD_EMPRESA', tTRA_TRANSACAO));
        putitemXml(viParams, 'NR_TRANSACAO', item_f('NR_TRANSACAO', tTRA_TRANSACAO));
        putitemXml(viParams, 'DT_TRANSACAO', item_a('DT_TRANSACAO', tTRA_TRANSACAO));
        putitemXml(viParams, 'TP_QUANTIDADE', vTpQuantidadePED);
        putitemXml(viParams, 'CD_COMPONENTE', gCdComponente);
        voParams := activateCmp('PEDSVCO002', 'cancelaBaixa', viParams); (*,,,, *)
        if (xStatus < 0) then begin
          Result := voParams;
          return(-1); exit;
        end;
      end;
    end;

    clear_e(tCMC_SOLIMATIT);
    putitem_e(tCMC_SOLIMATIT, 'CD_EMPTRANSACAO', item_f('CD_EMPRESA', tTRA_TRANSACAO));
    putitem_e(tCMC_SOLIMATIT, 'NR_TRANSACAO', item_f('NR_TRANSACAO', tTRA_TRANSACAO));
    putitem_e(tCMC_SOLIMATIT, 'DT_TRANSACAO', item_a('DT_TRANSACAO', tTRA_TRANSACAO));
    retrieve_e(tCMC_SOLIMATIT);
    if (xStatus >= 0)  or (empty('CMP_PEDIDOTRASVC') = 0) then begin
      viParams := '';
      putitemXml(viParams, 'CD_EMPRESA', item_f('CD_EMPRESA', tTRA_TRANSACAO));
      putitemXml(viParams, 'NR_TRANSACAO', item_f('NR_TRANSACAO', tTRA_TRANSACAO));
      putitemXml(viParams, 'DT_TRANSACAO', item_a('DT_TRANSACAO', tTRA_TRANSACAO));
      putitemXml(viParams, 'CD_COMPONENTE', gCdComponente);
      voParams := activateCmp('CMCSVCO010', 'cancelaBaixaSolicitacao', viParams); (*,,,, *)
      if (xStatus < 0) then begin
        Result := voParams;
        return(-1); exit;
      end;
    end else begin
      clear_e(tCMC_SOLIMATIT);
    end;

    gDtAtual := Now;
    vDsObs := 'Transacao cancelada pelo usuario ' + FloatToStr(vCdUsuario) + ' em ' + gDtAtual' + ';

    if (vInFinanceiro = True)  and (vNrSeqLiq > 0) then begin
      if (item_f('TP_OPERACAO', tTRA_TRANSACAO) = 'E')  and (item_f('TP_MODALIDADE', tGER_OPERACAO) = 1 ) or (item_f('TP_MODALIDADE', tGER_OPERACAO) = 2 ) or (item_f('TP_MODALIDADE', tGER_OPERACAO) = 4 ) or (item_f('TP_MODALIDADE', tGER_OPERACAO) = 5 ) or (item_f('TP_MODALIDADE', tGER_OPERACAO) = 'E') then begin
        viParams := '';
        putitemXml(viParams, 'CD_EMPLIQ', vCdEmpLiq);
        putitemXml(viParams, 'DT_LIQ', vDtLiq);
        putitemXml(viParams, 'NR_SEQLIQ', vNrSeqLiq);
        voParams := activateCmp('FCPSVCO046', 'estornaRetencaoImposto', viParams); (*,,,, *)
        if (xStatus < 0) then begin
          Result := voParams;
          return(-1); exit;
        end;

        viParams := '';
        putitemXml(viParams, 'CD_EMPLIQ', vCdEmpLiq);
        putitemXml(viParams, 'DT_LIQ', vDtLiq);
        putitemXml(viParams, 'NR_SEQLIQ', vNrSeqLiq);
        putitemXml(viParams, 'TP_CANCELAMENTO', 'C');
        putitemXml(viParams, 'CD_COMPONENTE', gCdComponente);
        putitemXml(viParams, 'DS_OBS', vDsMotivo);
        putitemXml(viParams, 'DS_LOG', vDsObs);
        voParams := activateCmp('FCPSVCO013', 'cancelaLiquidacao', viParams); (*,,,, *)
        if (xStatus < 0) then begin
          Result := voParams;
          return(-1); exit;
        end;
      end else begin

        viParams := '';
        putitemXml(viParams, 'CD_EMPLIQ', vCdEmpLiq);
        putitemXml(viParams, 'DT_LIQ', vDtLiq);
        putitemXml(viParams, 'NR_SEQLIQ', vNrSeqLiq);
        putitemXml(viParams, 'DS_MOTIVOCANC', vDsMotivo);
        putitemXml(viParams, 'DS_COMPONENTE', gCdComponente);

        voParams := activateCmp('FCRSVCO010', 'cancelaLiquidacao', viParams); (*,,,, *)
        if (xStatus < 0) then begin
          Result := voParams;
          return(-1); exit;
        end;

        clear_e(tFCC_MOV);
        putitem_e(tFCC_MOV, 'CD_EMPLIQ', vCdEmpLiq);
        putitem_e(tFCC_MOV, 'DT_LIQ', vDtLiq);
        putitem_e(tFCC_MOV, 'NR_SEQLIQ', vNrSeqLiq);
        retrieve_e(tFCC_MOV);
        if (xStatus >= 0) then begin
          setocc(tFCC_MOV, 1);
          while (xStatus >= 0) do begin

            if (gInSuprimentoAutomatico = True) then begin
              clear_e(tFCC_CTAPES);
              putitem_e(tFCC_CTAPES, 'NR_CTAPES', item_f('NR_CTAPES', tFCC_MOV));
              retrieve_e(tFCC_CTAPES);
              if (xStatus >= 0)  and (item_f('TP_MANUTENCAO', tFCC_CTAPES) = gCdTpManutCxUsuario)  and %\ then begin
                (vInCxFechado <> True)  and (item_f('TP_DOCUMENTO', tFCC_MOV) <> 9);

                viParams := '';
                putitemXml(viParams, 'NR_CTAPES', item_f('NR_CTAPES', tFCC_MOV));
                putitemXml(viParams, 'TP_DOCUMENTO', item_f('TP_DOCUMENTO', tFCC_MOV));
                putitemXml(viParams, 'NR_SEQHISTRELSUB', item_f('NR_SEQHISTRELSUB', tFCC_MOV));
                putitemXml(viParams, 'DT_SALDO', itemXml('DT_SISTEMA', PARAM_GLB));
                voParams := activateCmp('FCCSVCO002', 'buscaSaldoCtaTp', viParams); (*,,'',,, *)
                if (xStatus < 0) then begin
                  Result := voParams;
                  return(-1); exit;
                end;
                vVlSaldo := itemXmlF('VL_SALDO', voParams);

                if (vVlSaldo < item_f('VL_LANCTO', tFCC_MOV)) then begin
                  viParams= '';
                  putitem(viParams,  'IN_UTILIZA_CXFILIAL');
                  putitem(viParams,  'CD_CTAPES_CXMATRIZ');
                  putitem(viParams,  'CD_CTAPES_CXFILIAL');
                  xParamEmp := T_ADMSVCO001.GetParamEmpresa(piCdEmpresa, xParamEmp); (*item_f('CD_EMPRESA', tFCC_MOV),,,, *)
                  vInUtilizaCxFilialMov := itemXmlB('IN_UTILIZA_CXFILIAL', voParams);
                  vCdCtaPesCxMatrizMov := itemXmlF('CD_CTAPES_CXMATRIZ', voParams);
                  vCdCtaPesCxFilialMov := itemXmlF('CD_CTAPES_CXFILIAL', voParams);

                  if (vInUtilizaCxFilialMov = True) then begin
                    vDsCaixa := 'Filial';
                    vNrCaixa := vCdCtaPesCxFilialMov;
                  end else begin
                    vDsCaixa := 'Matriz';
                    vNrCaixa := vCdCtaPesCxMatrizMov;
                  end;
                  if (vInSupreCaixa <> True) then begin
                    askmess/question 'Saldo da conta insuficiente para realizar o cancelamento. Realizar suprimento do caixa ' + vDsCaixa?', + ' 'Não, Sim';
                    if (xStatus = 1) then begin
                      Result := SetStatus(STS_AVISO, 'GEN001', 'Cancelamento não realizado.', cDS_METHOD);
                      return(-1); exit;
                    end;
                    vInSupreCaixa := True;
                  end;

                  vVlDiferenca := item_f('VL_LANCTO', tFCC_MOV) - vVlSaldo;
                  vVlDiferenca := rounded(vVlDiferenca, 2);

                  clear_e(tFCX_CAIXAM);
                  putitem_e(tFCX_CAIXAM, 'NR_CTAPES', item_f('NR_CTAPES', tFCC_MOV));
                  putitem_e(tFCX_CAIXAM, 'DT_MOVIM', item_a('DT_MOVIM', tFCC_MOV));
                  putitem_e(tFCX_CAIXAM, 'NR_SEQMOV', item_f('NR_SEQMOV', tFCC_MOV));
                  retrieve_e(tFCX_CAIXAM);
                  if (xStatus < 0) then begin
                    Result := SetStatus(STS_AVISO, 'GEN001', 'Movimento não está relacionado a um caixa!', cDS_METHOD);
                    return(-1); exit;
                  end;

                  viParams := '';
                  putitemXml(viParams, 'NR_CTAORIGEM', vNrCaixa);
                  putitemXml(viParams, 'NR_CTADESTINO', item_f('NR_CTAPES', tFCC_MOV));
                  putitemXml(viParams, 'VL_SUPRIMENTO', vVlDiferenca);
                  putitemXml(viParams, 'CD_TERMINALDEST', item_f('CD_TERMINAL', tFCX_CAIXAM));
                  putitemXml(viParams, 'DT_ABERTURADEST', item_a('DT_ABERTURA', tFCX_CAIXAM));
                  putitemXml(viParams, 'NR_SEQDEST', item_f('NR_SEQ', tFCX_CAIXAM));
                  putitemXml(viParams, 'DS_OBS', 'SUPRIMENTO REF. CANCEL. TRANSACAO ' + NR_TRANSACAO + '.TRA_TRANSACAO');
                  putitemXml(viParams, 'IN_CXUSUARIO', False);
                  putitemXml(viParams, 'TP_PROCESSO', 3);
                  putitemXml(viParams, 'TP_DOCUMENTO', item_f('TP_DOCUMENTO', tFCC_MOV));
                  putitemXml(viParams, 'NR_SEQHISTRELSUB', item_f('NR_SEQHISTRELSUB', tFCC_MOV));
                  voParams := activateCmp('FCXSVCO002', 'supreCaixa', viParams); (*,,,, *)
                  if (xStatus < 0) then begin
                    Result := voParams;
                    return(-1); exit;
                  end;
                end;
              end;
            end;
            if (item_f('CD_HISTORICO', tFCC_MOV) = 930)  or (item_f('CD_HISTORICO', tFCC_MOV) = 935) then begin
              if (vInCxFechado = True) then begin
                if (item_f('TP_DOCUMENTO', tFCC_MOV) = 3 ) or (item_f('TP_DOCUMENTO', tFCC_MOV) = 9) then begin
                  viParams := '';
                  putitemXml(viParams, 'CD_EMPRESA', item_f('CD_EMPRESA', tFCC_MOV));

                  if (gInEnvioRecebMalote) then begin
                    putitemXml(viParams, 'NR_CTAPES', gNrCtaMatriz);
                  end else begin
                    if (gInUtilizaCxFilial = True) then begin
                      putitemXml(viParams, 'NR_CTAPES', gCdCtaPesCxFilial);
                    end else begin
                      putitemXml(viParams, 'NR_CTAPES', gNrCtaMatriz);
                    end;
                  end;

                  putitemXml(viParams, 'DT_MOVIMENTO', itemXml('DT_SISTEMA', PARAM_GLB));
                  if (item_f('TP_OPERACAO', tFCC_MOV) = 'C') then begin
                    putitemXml(viParams, 'CD_HISTORICO', 962);
                  end else begin
                    putitemXml(viParams, 'CD_HISTORICO', 963);
                  end;
                  putitemXml(viParams, 'VL_LANCTO', item_f('VL_LANCTO', tFCC_MOV));
                  putitemXml(viParams, 'IN_ESTORNO', 'N');
                  putitemXml(viParams, 'TP_DOCUMENTO', item_f('TP_DOCUMENTO', tFCC_MOV));
                  putitemXml(viParams, 'NR_SEQHISTRELSUB', item_f('NR_SEQHISTRELSUB', tFCC_MOV));
                  putitemXml(viParams, 'DS_AUX', 'TRANSACAO: ' + NR_TRANSACAO + '.TRA_TRANSACAO');
                  voParams := activateCmp('FCCSVCO002', 'movimentaConta', viParams); (*,,,,, *)
                  if (xStatus < 0) then begin
                    Result := voParams;
                    return(-1); exit;
                  end;
                end;
                if (vInEstornaCxUsu = True) then begin
                  viParams := '';
                  putitemXml(viParams, 'NR_CTAPES', item_f('NR_CTAPES', tFCC_MOV));
                  putitemXml(viParams, 'DT_MOVIM', item_a('DT_MOVIM', tFCC_MOV));
                  putitemXml(viParams, 'NR_SEQMOV', item_f('NR_SEQMOV', tFCC_MOV));
                  voParams := activateCmp('FCCSVCO002', 'estornaMovimento', viParams); (*,,,, *)
                  if (xStatus < 0) then begin
                    Result := voParams;
                    return(-1); exit;
                  end;
                end;
              end else begin
                viParams := '';
                putitemXml(viParams, 'NR_CTAPES', item_f('NR_CTAPES', tFCC_MOV));
                putitemXml(viParams, 'DT_MOVIM', item_a('DT_MOVIM', tFCC_MOV));
                putitemXml(viParams, 'NR_SEQMOV', item_f('NR_SEQMOV', tFCC_MOV));
                voParams := activateCmp('FCCSVCO002', 'estornaMovimento', viParams); (*,,,, *)
                if (xStatus < 0) then begin
                  Result := voParams;
                  return(-1); exit;
                end;
              end;
            end;
            setocc(tFCC_MOV, curocc(tFCC_MOV) + 1);
          end;
        end;
      end;
    end;
    if (vTpContrInspSaldoLote <> 1) then begin
      if (item_b('IN_KARDEX', tGER_OPERACAO) = True)  and (item_f('TP_SITUACAO', tTRA_TRANSACAO) <> 10) then begin
        if (item_f('TP_OPERACAO', tTRA_TRANSACAO) = 'S') then begin
          clear_e(tTRA_ITEMLOTE);
          putitem_e(tTRA_ITEMLOTE, 'CD_EMPRESA', vCdEmpresa);
          putitem_e(tTRA_ITEMLOTE, 'NR_TRANSACAO', vNrTransacao);
          putitem_e(tTRA_ITEMLOTE, 'DT_TRANSACAO', vDtTransacao);
          retrieve_e(tTRA_ITEMLOTE);
          if (xStatus >= 0) then begin
            setocc(tTRA_ITEMLOTE, 1);
            while (xStatus >= 0) do begin
              viParams := '';
              putitemXml(viParams, 'CD_EMPRESA', item_f('CD_EMPLOTE', tTRA_ITEMLOTE));
              putitemXml(viParams, 'NR_LOTE', item_f('NR_LOTE', tTRA_ITEMLOTE));
              putitemXml(viParams, 'NR_ITEM', item_f('NR_ITEMLOTE', tTRA_ITEMLOTE));
              putitemXml(viParams, 'QT_MOVIMENTO', item_f('QT_LOTE', tTRA_ITEMLOTE));
              putitemXml(viParams, 'TP_MOVIMENTO', 'B');
              putitemXml(viParams, 'IN_ESTORNO', True);
              if (item_f('TP_MODALIDADE', tGER_OPERACAO) = 3) then begin
                putitemXml(viParams, 'IN_VALIDASITUACAO', False);
              end;
              voParams := activateCmp('PRDSVCO020', 'movimentaQtLoteI', viParams); (*,,,, *)
              if (xStatus < 0) then begin
                Result := voParams;
                return(-1); exit;
              end;
              setocc(tTRA_ITEMLOTE, curocc(tTRA_ITEMLOTE) + 1);
            end;
          end;

        end else begin
          clear_e(tTRA_ITEMLOTE);
          putitem_e(tTRA_ITEMLOTE, 'CD_EMPRESA', vCdEmpresa);
          putitem_e(tTRA_ITEMLOTE, 'NR_TRANSACAO', vNrTransacao);
          putitem_e(tTRA_ITEMLOTE, 'DT_TRANSACAO', vDtTransacao);
          retrieve_e(tTRA_ITEMLOTE);
          if (xStatus >= 0) then begin
            setocc(tTRA_ITEMLOTE, 1);
            while (xStatus >= 0) do begin
              vInCancelar := False;
              if (gtinTituraria = 1) then begin
                vInCancelar := True;
              end else begin
                clear_e(tPRD_LOTEINF);
                putitem_e(tPRD_LOTEINF, 'CD_EMPRESA', item_f('CD_EMPLOTE', tTRA_ITEMLOTE));
                putitem_e(tPRD_LOTEINF, 'NR_LOTE', item_f('NR_LOTE', tTRA_ITEMLOTE));
                putitem_e(tPRD_LOTEINF, 'NR_ITEM', item_f('NR_ITEMLOTE', tTRA_ITEMLOTE));
                retrieve_e(tPRD_LOTEINF);
                if (xStatus < 0) then begin
                  clear_e(tPRD_LOTEINF);
                  clear_e(tFIS_NFITEMPLO);
                  putitem_e(tFIS_NFITEMPLO, 'CD_EMPLOTE', item_f('CD_EMPLOTE', tTRA_ITEMLOTE));
                  putitem_e(tFIS_NFITEMPLO, 'NR_LOTE', item_f('NR_LOTE', tTRA_ITEMLOTE));
                  putitem_e(tFIS_NFITEMPLO, 'NR_ITEMLOTE', item_f('NR_ITEMLOTE', tTRA_ITEMLOTE));
                  retrieve_e(tFIS_NFITEMPLO);
                  if (xStatus >= 0) then begin
                    vInCancelar := True;
                  end;
                end;
              end;
              if (vInCancelar) then begin
                viParams := '';
                putitemXml(viParams, 'CD_EMPRESA', item_f('CD_EMPLOTE', tTRA_ITEMLOTE));
                putitemXml(viParams, 'NR_LOTE', item_f('NR_LOTE', tTRA_ITEMLOTE));
                putitemXml(viParams, 'NR_ITEM', item_f('NR_ITEMLOTE', tTRA_ITEMLOTE));
                putitemXml(viParams, 'QT_MOVIMENTO', item_f('QT_LOTE', tTRA_ITEMLOTE));
                putitemXml(viParams, 'TP_MOVIMENTO', 'C');
                putitemXml(viParams, 'IN_VALIDASITUACAO', False);
                putitemXml(viParams, 'IN_ESTORNO', False);
                voParams := activateCmp('PRDSVCO020', 'movimentaQtLoteI', viParams); (*,,,, *)
                if (xStatus < 0) then begin
                  Result := voParams;
                  return(-1); exit;
                end;
              end;
              setocc(tTRA_ITEMLOTE, curocc(tTRA_ITEMLOTE) + 1);
            end;
          end;
        end;
      end;
    end;

    clear_e(tTRA_DEVTRA);
    putitem_e(tTRA_DEVTRA, 'CD_EMPTRANSACAO', item_f('CD_EMPRESA', tTRA_TRANSACAO));
    putitem_e(tTRA_DEVTRA, 'NR_TRANSACAO', item_f('NR_TRANSACAO', tTRA_TRANSACAO));
    putitem_e(tTRA_DEVTRA, 'DT_TRANSACAO', item_a('DT_TRANSACAO', tTRA_TRANSACAO));
    retrieve_e(tTRA_DEVTRA);
    if (xStatus >= 0) then begin
      viParams := '';
      putitemXml(viParams, 'CD_EMPRESA', item_f('CD_EMPRESA', tTRA_TRANSACAO));
      putitemXml(viParams, 'NR_TRANSACAO', item_f('NR_TRANSACAO', tTRA_TRANSACAO));
      putitemXml(viParams, 'DT_TRANSACAO', item_a('DT_TRANSACAO', tTRA_TRANSACAO));
      voParams := activateCmp('TRASVCO021', 'cancelaMovTransacao', viParams); (*,,,, *)
      if (xStatus < 0) then begin
        Result := voParams;
        return(-1); exit;
      end;
    end;

    viParams := '';
    putitemXml(viParams, 'CD_EMPRESA', item_f('CD_EMPRESA', tTRA_TRANSACAO));
    putitemXml(viParams, 'NR_TRANSACAO', item_f('NR_TRANSACAO', tTRA_TRANSACAO));
    putitemXml(viParams, 'DT_TRANSACAO', item_a('DT_TRANSACAO', tTRA_TRANSACAO));
    voParams := activateCmp('FISSVCO028', 'cancelaDevolucaoTransacao', viParams); (*,,,, *)
    if (xStatus < 0) then begin
      Result := voParams;
      return(-1); exit;
    end;
  end;
  if (gTpBonus = 2) then begin
    clear_e(tPES_BONUSMOV);
    putitem_e(tPES_BONUSMOV, 'CD_EMPTRANSACAO', item_f('CD_EMPRESA', tTRA_TRANSACAO));
    putitem_e(tPES_BONUSMOV, 'DT_TRANSACAO', item_a('DT_TRANSACAO', tTRA_TRANSACAO));
    putitem_e(tPES_BONUSMOV, 'NR_TRANSACAO', item_f('NR_TRANSACAO', tTRA_TRANSACAO));
    putitem_e(tPES_BONUSMOV, 'CD_EMPLIQ', vCdEmpLiq);
    putitem_e(tPES_BONUSMOV, 'DT_LIQ', vDtLiq);
    putitem_e(tPES_BONUSMOV, 'NR_SEQLIQ', vNrSeqLiq);
    retrieve_e(tPES_BONUSMOV);
    if (xStatus >= 0) then begin
      setocc(tPES_BONUSMOV, 1);
      while (xStatus >= 0) do begin
        viParams := '';
        putitemXml(viParams, 'CD_EMPRESA', item_f('CD_EMPRESA', tPES_BONUSMOV));
        putitemXml(viParams, 'CD_PESSOA', item_f('CD_PESSOA', tPES_BONUSMOV));
        putitemXml(viParams, 'TP_BONUS', item_f('TP_BONUS', tPES_BONUSMOV));

        if (item_f('TP_OPERACAO', tPES_BONUSMOV) = 'D') then begin
          putitemXml(viParams, 'TP_OPERACAO', 'C');
          putitemXml(viParams, 'CD_HISTORICO', 7);
        end else if (item_f('TP_OPERACAO', tPES_BONUSMOV) = 'C') then begin
          putitemXml(viParams, 'TP_OPERACAO', 'D');
          putitemXml(viParams, 'CD_HISTORICO', 6);
        end;

        putitemXml(viParams, 'CD_COMPONENTE', TRASVCO013);
        putitemXml(viParams, 'VL_BONUS', item_f('VL_MOVIMENTO', tPES_BONUSMOV));
        putitemXml(viParams, 'CD_EMPTRANSACAO', item_f('CD_EMPTRANSACAO', tPES_BONUSMOV));
        putitemXml(viParams, 'DT_TRANSACAO', item_a('DT_TRANSACAO', tPES_BONUSMOV));
        putitemXml(viParams, 'NR_TRANSACAO', item_f('NR_TRANSACAO', tPES_BONUSMOV));
        putitemXml(viParams, 'CD_EMPFAT', item_f('CD_EMPFAT', tPES_BONUSMOV));
        putitemXml(viParams, 'NR_FAT', item_f('NR_FAT', tPES_BONUSMOV));
        putitemXml(viParams, 'NR_PARCELA', item_f('NR_PARCELA', tPES_BONUSMOV));
        putitemXml(viParams, 'CD_EMPLIQ', vCdEmpLiq);
        putitemXml(viParams, 'DT_LIQ', vDtLiq);
        putitemXml(viParams, 'NR_SEQLIQ', vNrSeqLiq);
        putitemXml(viParams, 'DS_OBSERVACAO', 'Lançamento gerado pelo cancelamento da liquidação ' + FloatToStr(vCdEmpLiq) + '/' + vDtLiq + '/' + FloatToStr(vNrSeqLiq')) + ';
        voParams := activateCmp('PESSVCO035', 'lancaBonusDesconto', viParams); (*,,,, *)
        if (xStatus < 0) then begin
          Result := voParams;
          return(-1); exit;
        end;

        setocc(tPES_BONUSMOV, curocc(tPES_BONUSMOV) + 1);
      end;
    end;
  end;

  viParams := '';
  putitemXml(viParams, 'DS_LSTTRANSACAO', vDsLstTransacao);
  putitemXml(viParams, 'CD_COMPONENTE', gCdComponente);
  putitemXml(viParams, 'DS_OBSERVACAO', vDsObs);
  voParams := activateCmp('TRASVCO016', 'gravaObsTransacao', viParams); (*,,,, *)
  if (xStatus < 0) then begin
    Result := voParams;
    return(-1); exit;
  end;

  viParams := '';
  putitemXml(viParams, 'DS_LSTTRANSACAO', vDsLstTransacao);
  putitemXml(viParams, 'CD_COMPONENTE', gCdComponente);
  putitemXml(viParams, 'DS_OBSERVACAO', vDsMotivo);
  voParams := activateCmp('TRASVCO016', 'gravaObsTransacao', viParams); (*,,,, *)
  if (xStatus < 0) then begin
    Result := voParams;
    return(-1); exit;
  end;
  if (vInSoFinanceiro <> True) then begin
    if (item_f('CD_USUARIO', tADM_USUARIO) > 0) then begin
      vNmUsuario := '';
      viParams := '';

      putitemXml(viParams, 'CD_USUARIO', item_f('CD_USUARIO', tADM_USUARIO));
      voParams := activateCmp('ADMSVCO027', 'validaUsuarioEspecial', viParams); (*,,,, *)
      if (xStatus < 0) then begin
        Result := voParams;
        return(-1); exit;
      end;
      if (voParams <> '') then begin
        vNmUsuario := itemXml('NM_USUARIO', voParams);
      end;

      viParams := '';
      putitemXml(viParams, 'DS_LSTTRANSACAO', vDsLstTransacao);
      putitemXml(viParams, 'CD_COMPONENTE', gCdComponente);
      putitemXml(viParams, 'DS_OBSERVACAO', 'Conferente de cancelamento: ' + CD_USUARIO + '.ADM_USUARIO %vNmUsuario');
      voParams := activateCmp('TRASVCO016', 'gravaObsTransacao', viParams); (*,,,, *)
      if (xStatus < 0) then begin
        Result := voParams;
        return(-1); exit;
      end;
    end;
  end;
  if (vInOrigem <> True) then begin
    viParams := '';
    putitemXml(viParams, 'CD_EMPRESA', vCdEmpresa);
    putitemXml(viParams, 'NR_TRANSACAO', vNrTransacao);
    putitemXml(viParams, 'DT_TRANSACAO', vDtTransacao);
    voParams := activateCmp('SICSVCO005', 'buscaTransacaoOrigem', viParams); (*,,,, *)
    if (xStatus < 0) then begin
      Result := voParams;
      return(-1); exit;
    end;
    vNrTransacaoOri := itemXmlF('NR_TRANSACAO', voParams);
    if (vNrTransacaoOri > 0) then begin
      viParams := pParams;
      putitemXml(viParams, 'CD_EMPRESA', itemXmlF('CD_EMPRESA', voParams));
      putitemXml(viParams, 'NR_TRANSACAO', itemXmlF('NR_TRANSACAO', voParams));
      putitemXml(viParams, 'DT_TRANSACAO', itemXml('DT_TRANSACAO', voParams));
      putitemXml(viParams, 'IN_ORIGEM', True);
      newinstance 'TRASVCO013', 'TRASVCO013O', 'TRANSACTION=FALSE';
      voParams := activateCmp('TRASVCO013O', 'cancelaTransacao', viParams); (*,,,, *)
      if (xStatus < 0) then begin
        Result := voParams;
        return(-1); exit;
      end;
    end;
  end;
  if ((item_f('TP_SITUACAO', tTRA_TRANSACAO) = 4 ) or (item_f('TP_SITUACAO', tTRA_TRANSACAO) = 5)  and vInSoFinanceiro <> True) then begin
    vDsLstConsignado := '';
    clear_e(tFIS_ITEMCONSI);
    putitem_e(tFIS_ITEMCONSI, 'CD_EMPTRA', vCdEmpresa);
    putitem_e(tFIS_ITEMCONSI, 'NR_TRANSACAO', vNrTransacao);
    putitem_e(tFIS_ITEMCONSI, 'DT_TRANSACAO', vDtTransacao);
    retrieve_e(tFIS_ITEMCONSI);
    if (xStatus >= 0) then begin
      setocc(tFIS_ITEMCONSI, 1);
      while (xStatus >= 0) do begin
        vQtFaturado := 0;

        clear_e(tTRA_TRANSITEM);
        putitem_e(tTRA_TRANSITEM, 'CD_EMPRESA', item_f('CD_EMPRESA', tFIS_ITEMCONSI));
        putitem_e(tTRA_TRANSITEM, 'NR_TRANSACAO', item_f('NR_TRANSACAO', tFIS_ITEMCONSI));
        putitem_e(tTRA_TRANSITEM, 'DT_TRANSACAO', item_a('DT_TRANSACAO', tFIS_ITEMCONSI));
        putitem_e(tTRA_TRANSITEM, 'CD_PRODUTO', item_f('CD_PRODUTO', tFIS_ITEMCONSI));
        retrieve_e(tTRA_TRANSITEM);
        if (xStatus >= 0) then begin
          vQtFaturado := item_f('QT_SOLICITADA', tTRA_TRANSITEM);
        end;

        vDsRegistro := '';
        putitemXml(vDsRegistro, 'CD_EMPRESA', item_f('CD_EMPRESA', tFIS_ITEMCONSI));
        putitemXml(vDsRegistro, 'NR_FATURA', item_f('NR_FATURA', tFIS_ITEMCONSI));
        putitemXml(vDsRegistro, 'DT_FATURA', item_a('DT_FATURA', tFIS_ITEMCONSI));
        putitemXml(vDsRegistro, 'NR_ITEM', item_f('NR_ITEM', tFIS_ITEMCONSI));
        putitemXml(vDsRegistro, 'CD_PRODUTO', item_f('CD_PRODUTO', tFIS_ITEMCONSI));

        if (item_f('TP_OPERACAO', tGER_OPERACAO) = 'E') then begin
          putitemXml(vDsRegistro, 'QT_DEVOLVIDA', vQtFaturado);
        end else begin
          putitemXml(vDsRegistro, 'QT_VendIDA', vQtFaturado);
        end;

        putitem(vDsLstConsignado,  vDsRegistro);

        setocc(tFIS_ITEMCONSI, curocc(tFIS_ITEMCONSI) + 1);
      end;

      viParams := '';
      putitemXml(viParams, 'DS_CONSIGNADO', vDsLstConsignado);
      if (item_f('TP_OPERACAO', tGER_OPERACAO) = 'E') then begin
        putitemXml(viParams, 'TP_CONSIGNADO', 'DEVOLVER');
      end else begin
        putitemXml(viParams, 'TP_CONSIGNADO', 'FATURAR');
      end;
      voParams := activateCmp('FISSVCO004', 'consignadoCancelar', viParams); (*,,,, *)
    end;
  end;

  vInAchou := False;
  vInAchouAgrupador := False;

  clear_e(tTIN_OTNN);
  putitem_e(tTIN_OTNN, 'CD_EMPTRA', vCdEmpresa);
  putitem_e(tTIN_OTNN, 'NR_TRANSACAO', vNrTransacao);
  putitem_e(tTIN_OTNN, 'DT_TRANSACAO', vDtTransacao);
  retrieve_e(tTIN_OTNN);
  if (xStatus >= 0) then begin
    vInAchou := True;

    setocc(tTIN_OTNN, 1);
    while(xStatus >= 0) do begin

      if (item_f('CD_EMPDEST', tTIN_OTNN) > 0 ) and (item_f('NR_LOTEDEST', tTIN_OTNN) > 0 ) and (item_f('NR_ITEMDEST', tTIN_OTNN) > 0) then begin
        clear_e(tPRD_LOTEI);
        putitem_e(tPRD_LOTEI, 'CD_EMPRESA', item_f('CD_EMPDEST', tTIN_OTNN));
        putitem_e(tPRD_LOTEI, 'NR_LOTE', item_f('NR_LOTEDEST', tTIN_OTNN));
        putitem_e(tPRD_LOTEI, 'NR_ITEM', item_f('NR_ITEMDEST', tTIN_OTNN));
        retrieve_e(tPRD_LOTEI);
        if (xStatus >=0 ) and (item_f('CD_AGRUPA', tPRD_LOTEI) <> '') then begin
          creocc(tTIN_AGRUPADOR, -1);
          putitem_e(tTIN_AGRUPADOR, 'CD_AGRUPA', item_f('CD_AGRUPA', tPRD_LOTEI));
          retrieve_o(tTIN_AGRUPADOR);
          if (xStatus = -7) then begin
            retrieve_x(tTIN_AGRUPADOR);
            vInAchouAgrupador := True;
            putitem_e(tTIN_AGRUPADOR, 'IN_FINALIZADO', False);
          end;
        end;
      end;

      vDsRegStatus := '';
      putitemXml(vDsRegStatus, 'CD_EMPRESA', item_f('CD_EMPRESA', tTIN_OTNN));
      putitemXml(vDsRegStatus, 'CD_OTN', item_f('CD_OTN', tTIN_OTNN));
      putitemXml(vDsRegStatus, 'CD_PRDORIGEM', item_f('CD_PRDORIGEM', tTIN_OTNN));
      putitemXml(vDsRegStatus, 'CD_EMPLOTE', item_f('CD_EMPLOTE', tTIN_OTNN));
      putitemXml(vDsRegStatus, 'NR_LOTE', item_f('NR_LOTE', tTIN_OTNN));
      putitemXml(vDsRegStatus, 'NR_ITEM', item_f('NR_ITEM', tTIN_OTNN));
      clear_e(tTIN_REPI);
      putitem_e(tTIN_REPI, 'CD_EMPRESA', item_f('CD_EMPRESA', tTIN_OTNN));
      putitem_e(tTIN_REPI, 'CD_OTN', item_f('CD_OTN', tTIN_OTNN));
      putitem_e(tTIN_REPI, 'CD_PRDORIGEM', item_f('CD_PRDORIGEM', tTIN_OTNN));
      putitem_e(tTIN_REPI, 'CD_EMPLOTE', item_f('CD_EMPLOTE', tTIN_OTNN));
      putitem_e(tTIN_REPI, 'NR_LOTE', item_f('NR_LOTE', tTIN_OTNN));
      putitem_e(tTIN_REPI, 'NR_ITEM', item_f('NR_ITEM', tTIN_OTNN));
      retrieve_e(tTIN_REPI);
      if (xStatus >= 0) then begin
        putitem_e(tTIN_OTNN, 'IN_STATUS', 'R');
      end else begin

        putitem_e(tTIN_OTNN, 'IN_STATUS', 'N');
      end;
      clear_e(tTIN_REPI);

      putitem_e(tTIN_OTNN, 'CD_EMPTRA', '');
      putitem_e(tTIN_OTNN, 'NR_TRANSACAO', '');
      putitem_e(tTIN_OTNN, 'DT_TRANSACAO', '');
      putitem_e(tTIN_OTNN, 'NR_ITEMTRA', '');
      putitem_e(tTIN_OTNN, 'NR_SEQUENCIA', '');
      putitem_e(tTIN_OTNN, 'NR_GUIA', '');

      setocc(tTIN_OTNN, curocc(tTIN_OTNN) + 1);
    end;
  end;
  if (vInAchou) then begin
    voParams := tTIN_OTNN.Salvar();
    if (xStatus < 0) then begin
      Result := voParams;
      return(-1); exit;
    end;
  end;
  if (vInAchouAgrupador) then begin
    voParams := tTIN_AGRUPADOR.Salvar();
    if (xStatus < 0) then begin
      Result := voParams;
      return(-1); exit;
    end;
  end;

  clear_e(tTIN_OTNN);
  clear_e(tPRD_LOTEI);
  clear_e(tTIN_AGRUPADOR);

  clear_e(tTRA_TRANSOB);
  putitem_e(tTRA_TRANSOB, 'CD_EMPTRA', vCdEmpresa);
  putitem_e(tTRA_TRANSOB, 'NR_TRANSACAO', vNrTransacao);
  putitem_e(tTRA_TRANSOB, 'DT_TRANSACAO', vDtTransacao);
  retrieve_e(tTRA_TRANSOB);
  if (xStatus >= 0) then begin
    voParams := tTRA_TRANSOB.Excluir();
    if (xStatus < 0) then begin
      Result := voParams;
      return(-1); exit;
    end;

    voParams := tTRA_TRANSOB.Salvar();
    if (xStatus < 0) then begin
      Result := voParams;
      return(-1); exit;
    end;
  end;

  return(0); exit;
end;

end.
