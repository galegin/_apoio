unit cTRASVCO017;

interface

(* COMPONENTES 
  ADMSVCO001 / GERSVCO013 / GERSVCO031 / PRFSVCO001 / TRASVCO004

*)        

uses
  Classes, SysUtils, Math, DB,
  cServiceUnf, cDataSetUnf;

type
  T_TRASVCO017 = class(TcServiceUnf)
  private
    tFCX_HISTRELSU,
    tFGR_PORTADOR,
    tGER_CONDPGTOC,
    tGER_CONDPGTOI,
    tSIS_PARCELAMENTO,
    tTRA_ITEMPRDFI,
    tTRA_ITEMSIMU,
    tTRA_SIMUPARCE,
    tTRA_TRANSACAO,
    tTRA_TRANSCOND,
    tTRA_TRANSITEM : TcDatasetUnf;
    function getParam(pParams : String = '') : String;
    function setEntidade(pParams : String = '') : String;
  protected
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;    
  published
    function carregaFormaPagamento(pParams : String = '') : String;
    function gravaFormaPagamento(pParams : String = '') : String;
    function gravaItemSimulacao(pParams : String = '') : String;
    function excluiSimulacao(pParams : String = '') : String;
  end;

implementation

uses
  cADMSVCO001,
  cActivate, cStatus, cFuncao, cXml, dModulo;

var
  gInSimulador : String;

//---------------------------------------------------------------
constructor T_TRASVCO017.Create(AOwner: TComponent);
//---------------------------------------------------------------
begin
  inherited Create(AOwner);
  setEntidade('');
end;

//--------------------------------
destructor T_TRASVCO017.Destroy;
//--------------------------------
begin
  inherited Destroy;
end;

//---------------------------------------------------------------
function T_TRASVCO017.getParam(pParams : String = '') : String;
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
  putitem(xParamEmp, 'IN_SIMULADOR_COND_PGTO');

  xParamEmp := T_ADMSVCO001.GetParamEmpresa(piCdEmpresa, xParamEmp);

  gInSimulador := itemXml('IN_SIMULADOR_COND_PGTO', xParamEmp);

end;

//---------------------------------------------------------------
function T_TRASVCO017.setEntidade(pParams : String = '') : String;
//---------------------------------------------------------------
begin
  tFCX_HISTRELSU := GetEntidade('FCX_HISTRELSU');
  tFGR_PORTADOR := GetEntidade('FGR_PORTADOR');
  tGER_CONDPGTOC := GetEntidade('GER_CONDPGTOC');
  tGER_CONDPGTOI := GetEntidade('GER_CONDPGTOI');
  tSIS_PARCELAMENTO := GetEntidade('SIS_PARCELAMENTO');
  tTRA_ITEMPRDFI := GetEntidade('TRA_ITEMPRDFI');
  tTRA_ITEMSIMU := GetEntidade('TRA_ITEMSIMU');
  tTRA_SIMUPARCE := GetEntidade('TRA_SIMUPARCE');
  tTRA_TRANSACAO := GetEntidade('TRA_TRANSACAO');
  tTRA_TRANSCOND := GetEntidade('TRA_TRANSCOND');
  tTRA_TRANSITEM := GetEntidade('TRA_TRANSITEM');
end;

//---------------------------------------------------------------------
function T_TRASVCO017.carregaFormaPagamento(pParams : String) : String;
//---------------------------------------------------------------------
const
  cDS_METHOD = 'ADICIONAL=Operação: T_TRASVCO017.carregaFormaPagamento()';
var
  vDsLinha, vDsLstFormaPgto, vDsAdicional, viParams, voParams, vDsObservacao : String;
  vCdEmpresa, vNrTransacao, vVlTransacao, vVlDinheiro, vVlCalc, vVlTotal, vVlTotParcela, vTpMultiploCartao : Real;
  vVlResto, vVlParcela, vNrIndice, vNrParcela, vNrFat, vNrPrazoMedio, vTpDocumento, vNrSeqHistRelSub, vVlCartao : Real;
  vNrPortador : Real;
  vDtTransacao, vDtVencimento, vDtSistema : TDate;
begin
  vCdEmpresa := itemXmlF('CD_EMPRESA', pParams);
  vNrTransacao := itemXmlF('NR_TRANSACAO', pParams);
  vDtTransacao := itemXml('DT_TRANSACAO', pParams);
  vTpMultiploCartao := itemXmlF('TP_MULTIPLOCARTAO', pParams);

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

  vNrPrazoMedio := '';
  Result := '';
  vDsLstFormaPgto := '';
  vVlDinheiro := 0;
  vTpDocumento := 0;
  vNrPortador := 0;
  vNrSeqHistRelSub := 0;
  vVlCartao := 0;

  clear_e(tSIS_PARCELAMENTO);

  clear_e(tTRA_TRANSCOND);
  putitem_e(tTRA_TRANSCOND, 'CD_EMPRESA', vCdEmpresa);
  putitem_e(tTRA_TRANSCOND, 'NR_TRANSACAO', vNrTransacao);
  putitem_e(tTRA_TRANSCOND, 'DT_TRANSACAO', vDtTransacao);
  retrieve_e(tTRA_TRANSCOND);
  if (xStatus >= 0) then begin
    clear_e(tTRA_SIMUPARCE);
    putitem_e(tTRA_SIMUPARCE, 'CD_EMPRESA', vCdEmpresa);
    putitem_e(tTRA_SIMUPARCE, 'NR_TRANSACAO', vNrTransacao);
    putitem_e(tTRA_SIMUPARCE, 'DT_TRANSACAO', vDtTransacao);
    retrieve_e(tTRA_SIMUPARCE);
    if (xStatus >= 0) then begin
      sort/e(t TRA_SIMUPARCE, 'TP_DOCUMENTO, NR_SEQHISTRELSUB';);
      setocc(tTRA_SIMUPARCE, 1);
      while (xStatus >= 0) do begin
        if (item_f('TP_DOCUMENTO', tTRA_SIMUPARCE) = 3) then begin
          vVlDinheiro := vVlDinheiro + item_f('VL_PARCELA', tTRA_SIMUPARCE);
        end else begin
          clear_e(tGER_CONDPGTOC);
          if (item_f('TP_DOCUMENTO', tTRA_TRANSCOND) <> 4) then begin
            putitem_e(tGER_CONDPGTOC, 'CD_CONDPGTO', item_f('CD_CONDPGTO', tTRA_TRANSCOND));
            retrieve_e(tGER_CONDPGTOC);
            if (xStatus < 0) then begin
              clear_e(tGER_CONDPGTOC);
            end;
          end;
          if (item_a('DT_VENCIMENTO', tTRA_SIMUPARCE) <> '') then begin
            vDtVencimento := item_a('DT_VENCIMENTO', tTRA_SIMUPARCE);
          end else begin
            vDtVencimento := itemXml('DT_SISTEMA', PARAM_GLB);

            setocc(tGER_CONDPGTOI, 1);
            if (xStatus >= 0) then begin
              vDtVencimento := vDtVencimento + item_f('QT_DIA', tGER_CONDPGTOI);
            end;
          end;
          if (vTpMultiploCartao = 1)  and (item_f('TP_DOCUMENTO', tTRA_SIMUPARCE) = 4) then begin
            vVlCartao := vVlCartao + item_f('VL_PARCELA', tTRA_SIMUPARCE);

            if (vNrPortador = 0) then begin
              clear_e(tFCX_HISTRELSU);
              putitem_e(tFCX_HISTRELSU, 'TP_DOCUMENTO', item_f('TP_DOCUMENTO', tTRA_SIMUPARCE));
              putitem_e(tFCX_HISTRELSU, 'NR_SEQHISTRELSUB', item_f('NR_SEQHISTRELSUB', tTRA_SIMUPARCE));
              retrieve_e(tFCX_HISTRELSU);
              if (xStatus >= 0) then begin
                vNrPortador := item_f('NR_PORTADOR', tFCX_HISTRELSU);
              end;

              vNrSeqHistRelSub := item_f('NR_SEQHISTRELSUB', tTRA_SIMUPARCE);
            end;
          end else begin
            if (item_f('TP_DOCUMENTO', tTRA_TRANSCOND) = 2) then begin
              vNrFat := '';
            end else begin
              if (vNrFat = 0)  or (item_f('TP_DOCUMENTO', tTRA_SIMUPARCE) <> vTpDocumento)  or (item_f('NR_SEQHISTRELSUB', tTRA_SIMUPARCE) <> vNrSeqHistRelSub) then begin
                viParams := '';
                putitemXml(viParams, 'NM_ENTIDADE', 'FCR_FATURAI');
                voParams := activateCmp('GERSVCO031', 'getNumSeq', viParams); (*,viParams,voParams,, *)
                if (xStatus < 0) then begin
                  Result := voParams;
                  return(-1); exit;
                end;

                vNrFat := itemXmlF('NR_SEQUENCIA', voParams);
              end;
            end;

            creocc(tSIS_PARCELAMENTO, -1);
            putitem_e(tSIS_PARCELAMENTO, 'VL_DOCUMENTO', item_f('VL_PARCELA', tTRA_SIMUPARCE));
            putitem_e(tSIS_PARCELAMENTO, 'TP_DOCUMENTO', item_f('TP_DOCUMENTO', tTRA_SIMUPARCE));
            putitem_e(tSIS_PARCELAMENTO, 'NR_DOCUMENTO', vNrFat);
            putitem_e(tSIS_PARCELAMENTO, 'DT_VENCIMENTO', vDtVencimento);

            if (item_f('TP_DOCUMENTO', tTRA_SIMUPARCE) = 4) then begin
              vDsAdicional := '';
              putitemXml(vDsAdicional, 'NR_SEQHISTRELSUB', item_f('NR_SEQHISTRELSUB', tTRA_SIMUPARCE));
              putitem_e(tSIS_PARCELAMENTO, 'DS_ADICIONAL', vDsAdicional);

              clear_e(tFCX_HISTRELSU);
              putitem_e(tFCX_HISTRELSU, 'TP_DOCUMENTO', item_f('TP_DOCUMENTO', tTRA_SIMUPARCE));
              putitem_e(tFCX_HISTRELSU, 'NR_SEQHISTRELSUB', item_f('NR_SEQHISTRELSUB', tTRA_SIMUPARCE));
              retrieve_e(tFCX_HISTRELSU);
              if (xStatus >= 0) then begin
                vDsAdicional := 'Operadora: ' + NR_PORTADOR + '.FCX_HISTRELSU - ' + DS_PORTADOR + '.FGR_PORTADOR / ' + DS_HISTRELSUB + '.FCX_HISTRELSU';
                putitem_e(tSIS_PARCELAMENTO, 'DS_OBSERVACAO', vDsAdicional);
              end;
            end;

            putitem_e(tSIS_PARCELAMENTO, 'CD_TIPOCLASFCR', item_f('CD_TIPOCLASFCR', tTRA_SIMUPARCE));
            putitem_e(tSIS_PARCELAMENTO, 'CD_CLASFCR', item_f('CD_CLASFCR', tTRA_SIMUPARCE));

            vTpDocumento := item_f('TP_DOCUMENTO', tTRA_SIMUPARCE);
            vNrSeqHistRelSub := item_f('NR_SEQHISTRELSUB', tTRA_SIMUPARCE);
          end;
        end;

        setocc(tTRA_SIMUPARCE, curocc(tTRA_SIMUPARCE) + 1);
      end;
      if (vVlDinheiro > 0) then begin
        viParams := '';
        putitemXml(viParams, 'NM_ENTIDADE', 'FCR_FATURAI');
        voParams := activateCmp('GERSVCO031', 'getNumSeq', viParams); (*,viParams,voParams,, *)
        if (xStatus < 0) then begin
          Result := voParams;
          return(-1); exit;
        end;

        vNrFat := itemXmlF('NR_SEQUENCIA', voParams);

        creocc(tSIS_PARCELAMENTO, -1);
        putitem_e(tSIS_PARCELAMENTO, 'VL_DOCUMENTO', vVlDinheiro);
        putitem_e(tSIS_PARCELAMENTO, 'TP_DOCUMENTO', 3);
        putitem_e(tSIS_PARCELAMENTO, 'DT_VENCIMENTO', itemXml('DT_SISTEMA', PARAM_GLB));
        putitem_e(tSIS_PARCELAMENTO, 'NR_DOCUMENTO', vNrFat);
      end;
      if (vVlCartao > 0) then begin
        creocc(tSIS_PARCELAMENTO, -1);
        putitem_e(tSIS_PARCELAMENTO, 'TP_DOCUMENTO', 4);
        putitem_e(tSIS_PARCELAMENTO, 'VL_DOCUMENTO', vVlCartao);

        vDsAdicional := '';
        putitemXml(vDsAdicional, 'NR_PORTADOR', vNrPortador);
        putitemXml(vDsAdicional, 'NR_SEQHISTRELSUB', vNrSeqHistRelSub);
        putitem_e(tSIS_PARCELAMENTO, 'DS_ADICIONAL', vDsAdicional);
      end;

      viParams := '';
      putitemXml(viParams, 'CD_CONDPGTO', item_f('CD_CONDPGTO', tTRA_TRANSCOND));
      voParams := activateCmp('GERSVCO013', 'calcPrzMedio', viParams); (*viParams,voParams,, *)
      if (xStatus < 0) then begin
        Result := voParams;
        return(-1); exit;
      end;

      vNrPrazoMedio := itemXmlF('NR_PRAZOMEDIO', voParams);
    end else begin
      vVlTransacao := item_f('VL_TOTAL', tTRA_TRANSACAO) - item_f('VL_ENTRADA', tTRA_TRANSCOND) - item_f('VL_ADIANTAMENTO', tTRA_TRANSCOND) - item_f('VL_CREDEV', tTRA_TRANSCOND);

      if (vVlTransacao > 0) then begin
        clear_e(tFCX_HISTRELSU);
        putitem_e(tFCX_HISTRELSU, 'TP_DOCUMENTO', item_f('TP_DOCUMENTO', tTRA_TRANSCOND));
        putitem_e(tFCX_HISTRELSU, 'NR_SEQHISTRELSUB', item_f('NR_SEQHISTRELSUB', tTRA_TRANSCOND));
        retrieve_e(tFCX_HISTRELSU);
        if (xStatus >= 0) then begin
          if (item_f('VL_ENTRADA', tTRA_TRANSCOND) > 0)  or (item_f('TP_DOCUMENTO', tTRA_TRANSCOND) = 3) then begin
            viParams := '';
            putitemXml(viParams, 'NM_ENTIDADE', 'FCR_FATURAI');
            voParams := activateCmp('GERSVCO031', 'getNumSeq', viParams); (*,viParams,voParams,, *)
            if (xStatus < 0) then begin
              Result := voParams;
              return(-1); exit;
            end;

            vNrFat := itemXmlF('NR_SEQUENCIA', voParams);

            vVlDinheiro := item_f('VL_ENTRADA', tTRA_TRANSCOND);
            if (item_f('TP_DOCUMENTO', tTRA_TRANSCOND) = 3) then begin
              vVlDinheiro := vVlDinheiro + vVlTransacao;
            end;

            creocc(tSIS_PARCELAMENTO, -1);
            putitem_e(tSIS_PARCELAMENTO, 'VL_DOCUMENTO', vVlDinheiro);
            putitem_e(tSIS_PARCELAMENTO, 'TP_DOCUMENTO', 3);
            putitem_e(tSIS_PARCELAMENTO, 'DT_VENCIMENTO', itemXml('DT_SISTEMA', PARAM_GLB));
            putitem_e(tSIS_PARCELAMENTO, 'NR_DOCUMENTO', vNrFat);
          end;
          if (item_f('VL_ADIANTAMENTO', tTRA_TRANSCOND) > 0) then begin
            viParams := '';
            putitemXml(viParams, 'NM_ENTIDADE', 'FCR_FATURAI');
            voParams := activateCmp('GERSVCO031', 'getNumSeq', viParams); (*,viParams,voParams,, *)
            if (xStatus < 0) then begin
              Result := voParams;
              return(-1); exit;
            end;

            vNrFat := itemXmlF('NR_SEQUENCIA', voParams);

            creocc(tSIS_PARCELAMENTO, -1);
            putitem_e(tSIS_PARCELAMENTO, 'VL_DOCUMENTO', item_f('VL_ADIANTAMENTO', tTRA_TRANSCOND));
            putitem_e(tSIS_PARCELAMENTO, 'TP_DOCUMENTO', 10);
            putitem_e(tSIS_PARCELAMENTO, 'DT_VENCIMENTO', itemXml('DT_SISTEMA', PARAM_GLB));
            putitem_e(tSIS_PARCELAMENTO, 'NR_DOCUMENTO', vNrFat);
          end;
          if (item_f('VL_CREDEV', tTRA_TRANSCOND) > 0) then begin
            viParams := '';
            putitemXml(viParams, 'NM_ENTIDADE', 'FCR_FATURAI');
            voParams := activateCmp('GERSVCO031', 'getNumSeq', viParams); (*,viParams,voParams,, *)
            if (xStatus < 0) then begin
              Result := voParams;
              return(-1); exit;
            end;

            vNrFat := itemXmlF('NR_SEQUENCIA', voParams);

            creocc(tSIS_PARCELAMENTO, -1);
            putitem_e(tSIS_PARCELAMENTO, 'VL_DOCUMENTO', item_f('VL_CREDEV', tTRA_TRANSCOND));
            putitem_e(tSIS_PARCELAMENTO, 'TP_DOCUMENTO', 20);
            putitem_e(tSIS_PARCELAMENTO, 'DT_VENCIMENTO', itemXml('DT_SISTEMA', PARAM_GLB));
            putitem_e(tSIS_PARCELAMENTO, 'NR_DOCUMENTO', vNrFat);
          end;
          if (item_f('TP_DOCUMENTO', tTRA_TRANSCOND) <> 3) then begin
            if (vTpMultiploCartao = 1)  and (item_f('TP_DOCUMENTO', tTRA_TRANSCOND) = 4) then begin
              creocc(tSIS_PARCELAMENTO, -1);
              putitem_e(tSIS_PARCELAMENTO, 'VL_DOCUMENTO', vVlTransacao);
              putitem_e(tSIS_PARCELAMENTO, 'TP_DOCUMENTO', 4);

              vDsAdicional := '';
              putitemXml(vDsAdicional, 'NR_PORTADOR', item_f('NR_PORTADOR', tFCX_HISTRELSU));
              putitemXml(vDsAdicional, 'NR_SEQHISTRELSUB', item_f('NR_SEQHISTRELSUB', tFCX_HISTRELSU));
              putitem_e(tSIS_PARCELAMENTO, 'DS_ADICIONAL', vDsAdicional);
            end else begin
              if (item_f('TP_DOCUMENTO', tTRA_TRANSCOND) = 2) then begin
                vNrFat := '';
              end else begin
                viParams := '';
                putitemXml(viParams, 'NM_ENTIDADE', 'FCR_FATURAI');
                voParams := activateCmp('GERSVCO031', 'getNumSeq', viParams); (*,viParams,voParams,, *)
                if (xStatus < 0) then begin
                  Result := voParams;
                  return(-1); exit;
                end;

                vNrFat := itemXmlF('NR_SEQUENCIA', voParams);
              end;

              vNrParcela := 1;
              if (item_f('TP_DOCUMENTO', tTRA_TRANSCOND) = 4) then begin
                vNrParcela := item_f('NR_PARCELAS', tFCX_HISTRELSU);
              end else begin
                clear_e(tGER_CONDPGTOC);
                putitem_e(tGER_CONDPGTOC, 'CD_CONDPGTO', item_f('CD_CONDPGTO', tTRA_TRANSCOND));
                retrieve_e(tGER_CONDPGTOC);
                if (xStatus >= 0) then begin
                  vNrParcela := item_f('NR_PARCELAS', tGER_CONDPGTOC);
                end;
              end;

              vVlCalc := vVlTransacao / vNrParcela;
              vVlParcela := roundto(vVlCalc, 2);
              vVlResto := vVlTransacao;

              vNrIndice := 1;
              repeat
                setocc(tGER_CONDPGTOI, 1);
                vDtVencimento := itemXml('DT_SISTEMA', PARAM_GLB);

                if (item_f('TP_DOCUMENTO', tTRA_TRANSCOND) = 1)  or (item_f('TP_DOCUMENTO', tTRA_TRANSCOND) = 2)  or (item_f('TP_DOCUMENTO', tTRA_TRANSCOND) = 14) then begin
                  if (item_a('DT_BASE', tTRA_TRANSCOND) <> '') then begin
                    vDtVencimento := item_a('DT_BASE', tTRA_TRANSCOND);
                  end;
                end;

                vDtVencimento := vDtVencimento + item_f('QT_DIA', tGER_CONDPGTOI);

                creocc(tSIS_PARCELAMENTO, -1);
                putitem_e(tSIS_PARCELAMENTO, 'VL_DOCUMENTO', vVlParcela);
                putitem_e(tSIS_PARCELAMENTO, 'TP_DOCUMENTO', item_f('TP_DOCUMENTO', tTRA_TRANSCOND));
                putitem_e(tSIS_PARCELAMENTO, 'DT_VENCIMENTO', vDtVencimento);
                putitem_e(tSIS_PARCELAMENTO, 'NR_DOCUMENTO', vNrFat);

                if (item_f('TP_DOCUMENTO', tTRA_TRANSCOND) = 4 ) or (item_f('TP_DOCUMENTO', tTRA_TRANSCOND) = 5) then begin
                  vDsAdicional := '';
                  putitemXml(vDsAdicional, 'NR_SEQHISTRELSUB', item_f('NR_SEQHISTRELSUB', tFCX_HISTRELSU));
                  putitem_e(tSIS_PARCELAMENTO, 'DS_ADICIONAL', vDsAdicional);
                  vDsAdicional := 'Operadora: ' + NR_PORTADOR + '.FCX_HISTRELSU - ' + DS_PORTADOR + '.FGR_PORTADOR / ' + DS_HISTRELSUB + '.FCX_HISTRELSU';
                  putitem_e(tSIS_PARCELAMENTO, 'DS_OBSERVACAO', vDsAdicional);
                end;

                vVlResto := vVlResto - vVlParcela;
                vNrIndice := vNrIndice + 1;
              until (vNrIndice > vNrParcela);

              putitem_e(tSIS_PARCELAMENTO, 'VL_DOCUMENTO', item_f('VL_DOCUMENTO', tSIS_PARCELAMENTO) + vVlResto);
            end;
          end;
        end;

        viParams := '';
        putitemXml(viParams, 'CD_CONDPGTO', item_f('CD_CONDPGTO', tTRA_TRANSCOND));
        voParams := activateCmp('GERSVCO013', 'calcPrzMedio', viParams); (*viParams,voParams,, *)
        if (xStatus < 0) then begin
          Result := voParams;
          return(-1); exit;
        end;

        vNrPrazoMedio := itemXmlF('NR_PRAZOMEDIO', voParams);
      end else begin
        if (item_f('VL_ENTRADA', tTRA_TRANSCOND) > 0) then begin
          viParams := '';
          putitemXml(viParams, 'NM_ENTIDADE', 'FCR_FATURAI');
          voParams := activateCmp('GERSVCO031', 'getNumSeq', viParams); (*,viParams,voParams,, *)
          if (xStatus < 0) then begin
            Result := voParams;
            return(-1); exit;
          end;

          vNrFat := itemXmlF('NR_SEQUENCIA', voParams);

          vVlDinheiro := item_f('VL_ENTRADA', tTRA_TRANSCOND);

          creocc(tSIS_PARCELAMENTO, -1);
          putitem_e(tSIS_PARCELAMENTO, 'VL_DOCUMENTO', vVlDinheiro);
          putitem_e(tSIS_PARCELAMENTO, 'TP_DOCUMENTO', 3);
          putitem_e(tSIS_PARCELAMENTO, 'DT_VENCIMENTO', itemXml('DT_SISTEMA', PARAM_GLB));
          putitem_e(tSIS_PARCELAMENTO, 'NR_DOCUMENTO', vNrFat);
        end;
        if (item_f('VL_ADIANTAMENTO', tTRA_TRANSCOND) > 0) then begin
          viParams := '';
          putitemXml(viParams, 'NM_ENTIDADE', 'FCR_FATURAI');
          voParams := activateCmp('GERSVCO031', 'getNumSeq', viParams); (*,viParams,voParams,, *)
          if (xStatus < 0) then begin
            Result := voParams;
            return(-1); exit;
          end;

          vNrFat := itemXmlF('NR_SEQUENCIA', voParams);

          creocc(tSIS_PARCELAMENTO, -1);
          putitem_e(tSIS_PARCELAMENTO, 'VL_DOCUMENTO', item_f('VL_ADIANTAMENTO', tTRA_TRANSCOND));
          putitem_e(tSIS_PARCELAMENTO, 'TP_DOCUMENTO', 10);
          putitem_e(tSIS_PARCELAMENTO, 'DT_VENCIMENTO', itemXml('DT_SISTEMA', PARAM_GLB));
          putitem_e(tSIS_PARCELAMENTO, 'NR_DOCUMENTO', vNrFat);
        end;
        if (item_f('VL_CREDEV', tTRA_TRANSCOND) > 0) then begin
          viParams := '';
          putitemXml(viParams, 'NM_ENTIDADE', 'FCR_FATURAI');
          voParams := activateCmp('GERSVCO031', 'getNumSeq', viParams); (*,viParams,voParams,, *)
          if (xStatus < 0) then begin
            Result := voParams;
            return(-1); exit;
          end;

          vNrFat := itemXmlF('NR_SEQUENCIA', voParams);

          creocc(tSIS_PARCELAMENTO, -1);
          putitem_e(tSIS_PARCELAMENTO, 'VL_DOCUMENTO', item_f('VL_CREDEV', tTRA_TRANSCOND));
          putitem_e(tSIS_PARCELAMENTO, 'TP_DOCUMENTO', 20);
          putitem_e(tSIS_PARCELAMENTO, 'DT_VENCIMENTO', itemXml('DT_SISTEMA', PARAM_GLB));
          putitem_e(tSIS_PARCELAMENTO, 'NR_DOCUMENTO', vNrFat);
        end;

        vNrPrazoMedio := 0;
      end;
    end;
  end;
  if (empty(tSIS_PARCELAMENTO) = False) then begin
    setocc(tSIS_PARCELAMENTO, 1);
    while (xStatus >= 0) do begin
      putlistitensocc_e(vDsLinha, tSIS_PARCELAMENTO);
      putitem(vDsLstFormaPgto,  vDsLinha);
      setocc(tSIS_PARCELAMENTO, curocc(tSIS_PARCELAMENTO) + 1);
    end;
  end;

  putitemXml(Result, 'DS_FORMAPGTO', vDsLstFormaPgto);
  putitemXml(Result, 'NR_PRAZOMEDIO', vNrPrazoMedio);

  return(0); exit;
end;

//-------------------------------------------------------------------
function T_TRASVCO017.gravaFormaPagamento(pParams : String) : String;
//-------------------------------------------------------------------
const
  cDS_METHOD = 'ADICIONAL=Operação: T_TRASVCO017.gravaFormaPagamento()';
var
  vCdEmpresa, vNrTransacao, vNrParcela : Real;
  vDtTransacao : TDate;
  vDsLstParcela, vDsLinha : String;
begin
  vCdEmpresa := itemXmlF('CD_EMPRESA', pParams);
  vNrTransacao := itemXmlF('NR_TRANSACAO', pParams);
  vDtTransacao := itemXml('DT_TRANSACAO', pParams);
  vDsLstParcela := itemXml('DS_LSTPARCELA', pParams);

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

  clear_e(tTRA_TRANSCOND);
  creocc(tTRA_TRANSCOND, -1);
  getlistitensocc_e(pParams, tTRA_TRANSCOND);
  retrieve_o(tTRA_TRANSCOND);
  if (xStatus = -7) then begin
    retrieve_x(tTRA_TRANSCOND);
  end;

  delitem(pParams, 'CD_EMPRESA');
  delitem(pParams, 'NR_TRANSACAO');
  delitem(pParams, 'DT_TRANSACAO');
  delitem(pParams, 'CD_CONDPGTO');
  delitem(pParams, 'TP_DOCUMENTO');
  delitem(pParams, 'NR_SEQHISTRELSUB');

  getlistitensocc_e(pParams, tTRA_TRANSCOND);
  putitem_e(tTRA_TRANSCOND, 'CD_OPERADOR', itemXmlF('CD_USUARIO', PARAM_GLB));
  putitem_e(tTRA_TRANSCOND, 'DT_CADASTRO', Now);

  voParams := tTRA_TRANSCOND.Salvar();
  if (xStatus < 0) then begin
    Result := voParams;
    return(-1); exit;
  end;
  if (item_f('CD_CONDPGTO', tTRA_TRANSCOND) <> 0) then begin
    putitem_e(tTRA_TRANSACAO, 'CD_CONDPGTO', item_f('CD_CONDPGTO', tTRA_TRANSCOND));
  end;

  voParams := tTRA_TRANSACAO.Salvar();
  if (xStatus < 0) then begin
    Result := voParams;
    return(-1); exit;
  end;
  if (vDsLstParcela <> '') then begin
    clear_e(tTRA_SIMUPARCE);
    repeat
      getitem(vDsLinha, vDsLstParcela, 1);

      creocc(tTRA_SIMUPARCE, -1);
      putitem_e(tTRA_SIMUPARCE, 'CD_EMPRESA', vCdEmpresa);
      putitem_e(tTRA_SIMUPARCE, 'NR_TRANSACAO', vNrTransacao);
      putitem_e(tTRA_SIMUPARCE, 'DT_TRANSACAO', vDtTransacao);

      vNrParcela := itemXmlF('NR_PARCELA', vDsLinha);
      if (vNrParcela = '') then begin
        putitem_e(tTRA_SIMUPARCE, 'NR_PARCELA', curocc(tTRA_SIMUPARCE));
      end else begin
        putitem_e(tTRA_SIMUPARCE, 'NR_PARCELA', vNrParcela);
      end;
      putitem_e(tTRA_SIMUPARCE, 'CD_OPERADOR', itemXmlF('CD_USUARIO', PARAM_GLB));
      putitem_e(tTRA_SIMUPARCE, 'DT_CADASTRO', Now);
      putitem_e(tTRA_SIMUPARCE, 'TP_DOCUMENTO', itemXmlF('TP_DOCUMENTO', vDsLinha));
      putitem_e(tTRA_SIMUPARCE, 'NR_SEQHISTRELSUB', itemXmlF('NR_SEQHISTRELSUB', vDsLinha));
      putitem_e(tTRA_SIMUPARCE, 'VL_PARCELA', itemXmlF('VL_PARCELA', vDsLinha));
      putitem_e(tTRA_SIMUPARCE, 'DT_VENCIMENTO', itemXml('DT_VENCIMENTO', vDsLinha));
      putitem_e(tTRA_SIMUPARCE, 'CD_TIPOCLASFCR', itemXmlF('CD_TIPOCLASFCR', vDsLinha));
      putitem_e(tTRA_SIMUPARCE, 'CD_CLASFCR', itemXmlF('CD_CLASFCR', vDsLinha));

      delitem(vDsLstParcela, 1);
    until (vDsLstParcela = '');

    voParams := tTRA_SIMUPARCE.Salvar();
    if (xStatus < 0) then begin
      Result := voParams;
      return(-1); exit;
    end;
  end;

  return(0); exit;
end;

//------------------------------------------------------------------
function T_TRASVCO017.gravaItemSimulacao(pParams : String) : String;
//------------------------------------------------------------------
const
  cDS_METHOD = 'ADICIONAL=Operação: T_TRASVCO017.gravaItemSimulacao()';
var
  vCdEmpresa, vNrTransacao, vNrItem, vCdCondPgto, vTpDocumento, vNrSeqHistRelSub : Real;
  vDtTransacao : TDate;
  vDsLstParcela, vDsLinha : String;
begin
  vCdEmpresa := itemXmlF('CD_EMPRESA', pParams);
  vNrTransacao := itemXmlF('NR_TRANSACAO', pParams);
  vDtTransacao := itemXml('DT_TRANSACAO', pParams);
  vNrItem := itemXmlF('NR_ITEM', pParams);
  vCdCondPgto := itemXmlF('CD_CONDPGTO', pParams);
  vTpDocumento := itemXmlF('TP_DOCUMENTO', pParams);
  vNrSeqHistRelSub := itemXmlF('NR_SEQHISTRELSUB', pParams);

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
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Item não informado!', cDS_METHOD);
    return(-1); exit;
  end;
  if (vCdCondPgto = 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Condição de pagamento não informada!', cDS_METHOD);
    return(-1); exit;
  end;
  if (vTpDocumento = 0)  or (vNrSeqHistRelSub = 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Documento não informado!', cDS_METHOD);
    return(-1); exit;
  end;

  clear_e(tTRA_ITEMSIMU);
  creocc(tTRA_ITEMSIMU, -1);
  putitem_e(tTRA_ITEMSIMU, 'CD_EMPRESA', vCdEmpresa);
  putitem_e(tTRA_ITEMSIMU, 'NR_TRANSACAO', vNrTransacao);
  putitem_e(tTRA_ITEMSIMU, 'DT_TRANSACAO', vDtTransacao);
  putitem_e(tTRA_ITEMSIMU, 'NR_ITEM', vNrItem);
  retrieve_o(tTRA_ITEMSIMU);
  if (xStatus = -7) then begin
    retrieve_x(tTRA_ITEMSIMU);
  end;

  putitem_e(tTRA_ITEMSIMU, 'CD_CONDPGTO', vCdCondPgto);
  putitem_e(tTRA_ITEMSIMU, 'TP_DOCUMENTO', vTpDocumento);
  putitem_e(tTRA_ITEMSIMU, 'NR_SEQHISTRELSUB', vNrSeqHistRelSub);
  putitem_e(tTRA_ITEMSIMU, 'CD_OPERADOR', itemXmlF('CD_USUARIO', PARAM_GLB));
  putitem_e(tTRA_ITEMSIMU, 'DT_CADASTRO', Now);

  voParams := tTRA_ITEMSIMU.Salvar();
  if (xStatus < 0) then begin
    Result := voParams;
    return(-1); exit;
  end;

  return(0); exit;
end;

//---------------------------------------------------------------
function T_TRASVCO017.excluiSimulacao(pParams : String) : String;
//---------------------------------------------------------------
const
  cDS_METHOD = 'ADICIONAL=Operação: T_TRASVCO017.excluiSimulacao()';
var
  viParams, voParams, vDsLstTransacao, vDsRegistro, vDsLstItem : String;
  vCdEmpresa, vNrTransacao : Real;
  vDtTransacao : TDate;
  vInPrdFin : Boolean;
begin
  vCdEmpresa := itemXmlF('CD_EMPRESA', pParams);
  vNrTransacao := itemXmlF('NR_TRANSACAO', pParams);
  vDtTransacao := itemXml('DT_TRANSACAO', pParams);
  vDsLstItem := '';

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

  getParams(pParams); (* vCdEmpresa, 'excluiSimulacao' *)
  if (xStatus < 0) then begin
    Result := voParams;
    return(-1); exit;
  end;

  clear_e(tTRA_ITEMSIMU);
  putitem_e(tTRA_ITEMSIMU, 'CD_EMPRESA', vCdEmpresa);
  putitem_e(tTRA_ITEMSIMU, 'NR_TRANSACAO', vNrTransacao);
  putitem_e(tTRA_ITEMSIMU, 'DT_TRANSACAO', vDtTransacao);
  retrieve_e(tTRA_ITEMSIMU);
  if (xStatus >= 0) then begin
    voParams := tTRA_ITEMSIMU.Excluir();
    if (xStatus < 0) then begin
      Result := voParams;
      return(-1); exit;
    end;

    voParams := tTRA_ITEMSIMU.Salvar();
    if (xStatus < 0) then begin
      Result := voParams;
      return(-1); exit;
    end;
  end;

  clear_e(tTRA_SIMUPARCE);
  putitem_e(tTRA_SIMUPARCE, 'CD_EMPRESA', vCdEmpresa);
  putitem_e(tTRA_SIMUPARCE, 'NR_TRANSACAO', vNrTransacao);
  putitem_e(tTRA_SIMUPARCE, 'DT_TRANSACAO', vDtTransacao);
  retrieve_e(tTRA_SIMUPARCE);
  if (xStatus >= 0) then begin
    voParams := tTRA_SIMUPARCE.Excluir();
    if (xStatus < 0) then begin
      Result := voParams;
      return(-1); exit;
    end;

    voParams := tTRA_SIMUPARCE.Salvar();
    if (xStatus < 0) then begin
      Result := voParams;
      return(-1); exit;
    end;
  end;

  clear_e(tTRA_TRANSCOND);
  putitem_e(tTRA_TRANSCOND, 'CD_EMPRESA', vCdEmpresa);
  putitem_e(tTRA_TRANSCOND, 'NR_TRANSACAO', vNrTransacao);
  putitem_e(tTRA_TRANSCOND, 'DT_TRANSACAO', vDtTransacao);
  retrieve_e(tTRA_TRANSCOND);
  if (xStatus >= 0) then begin
    voParams := tTRA_TRANSCOND.Excluir();
    if (xStatus < 0) then begin
      Result := voParams;
      return(-1); exit;
    end;

    voParams := tTRA_TRANSCOND.Salvar();
    if (xStatus < 0) then begin
      Result := voParams;
      return(-1); exit;
    end;
  end;

  clear_e(tTRA_TRANSITEM);
  putitem_e(tTRA_TRANSITEM, 'CD_EMPRESA', vCdEmpresa);
  putitem_e(tTRA_TRANSITEM, 'NR_TRANSACAO', vNrTransacao);
  putitem_e(tTRA_TRANSITEM, 'DT_TRANSACAO', vDtTransacao);
  retrieve_e(tTRA_TRANSITEM);
  if (xStatus >= 0) then begin
    setocc(tTRA_TRANSITEM, 1);
    while (xStatus >= 0) do begin

      vInPrdFin := False;

      if (gInSimulador = True) then begin
        clear_e(tTRA_ITEMPRDFI);
        putitem_e(tTRA_ITEMPRDFI, 'CD_EMPRESA', item_f('CD_EMPRESA', tTRA_TRANSITEM));
        putitem_e(tTRA_ITEMPRDFI, 'NR_TRANSACAO', item_f('NR_TRANSACAO', tTRA_TRANSITEM));
        putitem_e(tTRA_ITEMPRDFI, 'DT_TRANSACAO', item_a('DT_TRANSACAO', tTRA_TRANSITEM));
        putitem_e(tTRA_ITEMPRDFI, 'NR_ITEM', item_f('NR_ITEM', tTRA_TRANSITEM));
        retrieve_e(tTRA_ITEMPRDFI);
        if (xStatus >= 0) then begin
          vInPrdFin := True;

          setocc(tTRA_ITEMPRDFI, 1);
          while (xStatus >= 0) do begin
            viParams := '';
            putitemXml(viParams, 'CD_EMPRESA', item_f('CD_EMPPRDFIN', tTRA_ITEMPRDFI));
            putitemXml(viParams, 'NR_PRDFIN', item_f('NR_PRDFIN', tTRA_ITEMPRDFI));
            putitemXml(viParams, 'CD_COMPONENTE', TRASVCO017);
            putitemXml(viParams, 'IN_VALIDAENVIO', True);
            voParams := activateCmp('PRFSVCO001', 'cancelaProdutoFinanceiro', viParams); (*,viParams,voParams,, *)
            if (xStatus < 0) then begin
              Result := voParams;
              return(-1); exit;
            end;

            setocc(tTRA_ITEMPRDFI, curocc(tTRA_ITEMPRDFI) + 1);
          end;
        end;
      end;

      viParams := '';
      putlistitensocc_e(viParams, tTRA_TRANSITEM);

      if (vInPrdFin = False) then begin
        putitem(vDsLstItem,  viParams);
      end;

      voParams := activateCmp('TRASVCO004', 'removeItemTransacao', viParams); (*,viParams,voParams,, *)
      if (xStatus < 0) then begin
        Result := voParams;
        return(-1); exit;
      end;

      setocc(tTRA_TRANSITEM, curocc(tTRA_TRANSITEM) + 1);
    end;
  end;

  repeat
    getitem(vDsRegistro, vDsLstItem, 1);

      viParams := '';
      putitemXml(viParams, 'CD_EMPRESA', item_f('CD_EMPRESA', tTRA_TRANSACAO));
      putitemXml(viParams, 'NR_TRANSACAO', item_f('NR_TRANSACAO', tTRA_TRANSACAO));
      putitemXml(viParams, 'DT_TRANSACAO', item_a('DT_TRANSACAO', tTRA_TRANSACAO));
      putitemXml(viParams, 'CD_COMPVend', itemXmlF('CD_COMPVend', vDsRegistro));
      putitemXml(viParams, 'CD_BARRAPRD', itemXmlF('CD_PRODUTO', vDsRegistro));
      putitemXml(viParams, 'IN_CODIGO', True);
      putitemXml(viParams, 'QT_SOLICITADA', itemXmlF('QT_SOLICITADA', vDsRegistro));
      voParams := activateCmp('TRASVCO004', 'validaItemTransacao', viParams); (*,viParams,voParams,, *)
      if (xStatus < 0) then begin
        Result := voParams;
        return(-1); exit;
      end;

      viParams := voParams;
      putitemXml(viParams, 'CD_EMPRESA', item_f('CD_EMPRESA', tTRA_TRANSACAO));
      putitemXml(viParams, 'NR_TRANSACAO', item_f('NR_TRANSACAO', tTRA_TRANSACAO));
      putitemXml(viParams, 'DT_TRANSACAO', item_a('DT_TRANSACAO', tTRA_TRANSACAO));
      putitemXml(viParams, 'IN_SEMMOVIMENTO', False);
      voParams := activateCmp('TRASVCO004', 'gravaItemTransacao', viParams); (*,viParams,voParams,, *)
      if (xStatus < 0) then begin
        Result := voParams;
        return(-1); exit;
      end;
    delitem(vDsLstItem, 1);
  until (vDsLstItem = '');

  vDsLstTransacao := '';
  vDsRegistro := '';
  putitemXml(vDsRegistro, 'CD_EMPRESA', vCdEmpresa);
  putitemXml(vDsRegistro, 'NR_TRANSACAO', vNrTransacao);
  putitemXml(vDsRegistro, 'DT_TRANSACAO', vDtTransacao);
  putitem(vDsLstTransacao,  vDsRegistro);
  putitemXml(viParams, 'DS_LSTTRANSACAO', vDsLstTransacao);
  voParams := activateCmp('TRASVCO004', 'gravaTotalTransacao', viParams); (*,viParams,voParams,, *)
  if (xStatus < 0) then begin
    Result := voParams;
    return(-1); exit;
  end;

  return(0); exit;
end;

end.