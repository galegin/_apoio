unit cFGRSVCO006;

interface

(* COMPONENTES 
  FGRSVCO007 / 
*)        

uses
  Classes, SysUtils, DB,
  cServiceUnf, cDataSetUnf;

type
  T_FGRSVCO006 = class(TcServiceUnf)
  private
    tDUMMY_VECTOS,
    tFCX_HISTRELSU,
    tFGR_FORMULACA,
    tFGR_FORMULACASVC,,
    tFGR_FORMULACDT,
    tFGR_FORMULACE,
    tFGR_PORTEMPRE : TcDatasetUnf;
    function getParam(pParams : String = '') : String;
    function setEntidade(pParams : String = '') : String;
  protected
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;    
  published
    function VencimentoParcelas(pParams : String = '') : String;
    function geraDataDiaFixo(pParams : String = '') : String;
    function geraVenctoConvenio(pParams : String = '') : String;
  end;

implementation

uses
  cADMSVCO001,
  cActivate, cStatus, cFuncao, cXml, dModulo;

var
  gDtVencimento : String;

//---------------------------------------------------------------
constructor T_FGRSVCO006.Create(AOwner: TComponent);
//---------------------------------------------------------------
begin
  inherited Create(AOwner);
  setEntidade('');
end;

//--------------------------------
destructor T_FGRSVCO006.Destroy;
//--------------------------------
begin
  inherited Destroy;
end;

//---------------------------------------------------------------
function T_FGRSVCO006.getParam(pParams : String) : String;
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

  xParamEmp := T_ADMSVCO001.GetParamEmpresa(piCdEmpresa, xParamEmp);


end;

//---------------------------------------------------------------
function T_FGRSVCO006.setEntidade(pParams : String) : String;
//---------------------------------------------------------------
begin
  tDUMMY_VECTOS := GetEntidade('DUMMY_VECTOS');
  tFCX_HISTRELSU := GetEntidade('FCX_HISTRELSU');
  tFGR_FORMULACA := GetEntidade('FGR_FORMULACA');
  tFGR_FORMULACASVC, := GetEntidade('FGR_FORMULACASVC,');
  tFGR_FORMULACDT := GetEntidade('FGR_FORMULACDT');
  tFGR_FORMULACE := GetEntidade('FGR_FORMULACE');
  tFGR_PORTEMPRE := GetEntidade('FGR_PORTEMPRE');
end;

//------------------------------------------------------------------
function T_FGRSVCO006.VencimentoParcelas(pParams : String) : String;
//------------------------------------------------------------------
const
  cDS_METHOD = 'ADICIONAL=Operação: T_FGRSVCO006.VencimentoParcelas()';
var
  CdEmpresa, CdPortador, NrParcelas, NrContador, NrDiasSoma, NrVectoCliente, NrMesCompra, NrDiasCarencia : Real;
  vNrDiasCarencia, vNrDiasBase, vNrDias, vDiaVenctoConvenio, vCdFormulaCartao, vNrDiasAux : Real;
  vDiaFixo, vNrMes, vNrAno, vTpDocumento, vNrSeqHistRelSub, vBisexto, vPrTaxa : Real;
  ListaVencimento, viParams, voParams, DsDiaUtil, DsWhile, viParams, voParams : String;
  DtVenda, DtMelhorDataCompra, DtVenctoClienteMesCorrente, DtVencimentoFinal, DtSistema, DtVectoBase : TDate;
  DtBase, DtVenctoClienteAux : TDate;
  vInProprio, vInDiaFixo, vInCarenciaUtil, vInDiasUtil, vInConvenio, vInFaturamento, vInFevereiro28, vInGeraFaturaOp : Boolean;
begin
  CdEmpresa := itemXmlF('CD_EMPRESA', pParams);
  CdPortador := itemXmlF('CD_PORTADOR', pParams);
  DtVenda := itemXml('DT_VendA', pParams);
  NrParcelas := itemXmlF('NR_PARCELAS', pParams);
  NrVectoCliente := itemXmlF('NR_VECTOCLIENTE', pParams);
  DtSistema := itemXml('DT_SISTEMA', PARAM_GLB);

  vTpDocumento := itemXmlF('TP_DOCUMENTO', pParams);
  vNrSeqHistRelSub := itemXmlF('NR_SEQHISTRELSUB', pParams);
  vCdFormulaCartao := 0;

  if (vTpDocumento <> 0 ) and (vNrSeqHistRelSub <> 0) then begin
    clear_e(tFCX_HISTRELSU);
    putitem_o(tFCX_HISTRELSU, 'TP_DOCUMENTO', vTpDocumento);
    putitem_o(tFCX_HISTRELSU, 'NR_SEQHISTRELSUB', vNrSeqHistRelSub);
    retrieve_e(tFCX_HISTRELSU);
    if (xStatus >= 0) then begin
      if (item_f('CD_FORMULACARTAO', tFCX_HISTRELSU) <> 0) then begin
        vCdFormulaCartao := item_f('CD_FORMULACARTAO', tFCX_HISTRELSU);
      end;
    end;
  end;

  clear_e(tFGR_PORTEMPRE);
  putitem_o(tFGR_PORTEMPRE, 'CD_EMPRESA', cdEmpresa);
  putitem_o(tFGR_PORTEMPRE, 'NR_PORTADOR', cdPortador);
  retrieve_e(tFGR_PORTEMPRE);
  if (xStatus >= 0) then begin
    if (vCdFormulaCartao = 0) then begin
      vCdFormulaCartao := item_f('CD_FORMULACARTAO', tFGR_PORTEMPRE);
    end;
  end else begin
    if (vCdFormulaCartao = 0) then begin
      Result := SetStatus(STS_AVISO, 'GEN001', 'Fórmula não encontrada para o portador: ' + item_a('NR_PORTADOR', tFGR_PORTEMPRE) + ' na empresa: ' + item_a('CD_EMPRESA', tFGR_PORTEMPRE) + '. Favor verificar o componente FGRFM004.', cDS_METHOD);
      return(-1); exit;
    end;
  end;

  vInProprio := False;
  vInCarenciaUtil := False;
  vInDiaFixo := False;
  vInDiasUtil := False;
  vNrDiasCarencia := '';
  vNrDiasBase := '';
  vNrDias := '';

  vInFaturamento := itemXmlB('IN_FATURAMENTO', pParams);
  vInConvenio := False;
  vDiaVenctoConvenio := '';

  clear_e(tDUMMY_VECTOS);

  if (vCdFormulaCartao <> 0) then begin
    clear_e(tFGR_FORMULACA);
    putitem_o(tFGR_FORMULACA, 'CD_FORMULACARTAO', vCdFormulaCartao);
    retrieve_e(tFGR_FORMULACA);
    if (xStatus >= 0) then begin
      clear_e(tFGR_FORMULACE);
      putitem_o(tFGR_FORMULACE, 'CD_EMPRESA', item_f('CD_EMPRESA', tFGR_PORTEMPRE));
      putitem_o(tFGR_FORMULACE, 'CD_FORMULACARTAO', vCdFormulaCartao);
      retrieve_e(tFGR_FORMULACE);

      if (xStatus >= 0)  and (item_f('CD_EMPRESA', tFGR_PORTEMPRE) > 0) then begin
        vInProprio := item_b('IN_PROPRIO', tFGR_FORMULACE);
        vInCarenciaUtil := item_b('IN_CARENCIAUTIL', tFGR_FORMULACE);
        vInDiaFixo := item_b('IN_DIAFIXO', tFGR_FORMULACE);
        vInDiasUtil := item_b('IN_DIASUTIL', tFGR_FORMULACE);
        vNrDiasCarencia := item_f('NR_DIASCARENCIA', tFGR_FORMULACE);
        vNrDiasBase := item_f('NR_DIASBASE', tFGR_FORMULACE);
        vNrDias := item_f('NR_DIAS', tFGR_FORMULACE);
        vInFevereiro28 := item_b('IN_FEVEREIRO28', tFGR_FORMULACE);

        if (item_b('IN_CONVENIO', tFGR_FORMULACE) = True) then begin
          vInConvenio := True;
          vDiaVenctoConvenio := item_f('NR_DIACONVENIO', tFGR_FORMULACE);
        end;

        vInGeraFaturaOp := item_b('IN_GERAFATOPERADORA', tFGR_FORMULACE);

        if not (empty(tFGR_FORMULACDT)) then begin
          setocc(tFGR_FORMULACDT, 1);
          while (xStatus >= 0) do begin

            if (item_a('DT_INI', tFGR_FORMULACDT) <= DtSistema)  and (item_a('DT_FIM', tFGR_FORMULACDT) >= DtSistema)  and (item_f('TP_SITUACAO', tFGR_FORMULACDT) = 1) then begin
              vPrTaxa := item_f('PR_TAXA', tFGR_FORMULACDT);
              break;
            end;

            setocc(tFGR_FORMULACDT, curocc(tFGR_FORMULACDT) + 1);
          end;
        end;
        if (vPrTaxa = 0)  or (vPrTaxa = '') then begin
          vPrTaxa := item_f('PR_TAXA', tFGR_FORMULACE);
        end;
      end else begin

        vInProprio := item_b('IN_PROPRIO', tFGR_FORMULACA);
        vInCarenciaUtil := item_b('IN_CARENCIAUTIL', tFGR_FORMULACA);
        vInDiaFixo := item_b('IN_DIAFIXO', tFGR_FORMULACA);
        vInDiasUtil := item_b('IN_DIASUTIL', tFGR_FORMULACA);
        vNrDiasCarencia := item_f('NR_DIASCARENCIA', tFGR_FORMULACA);
        vNrDiasBase := item_f('NR_DIASBASE', tFGR_FORMULACA);
        vNrDias := item_f('NR_DIAS', tFGR_FORMULACA);
        vInFevereiro28 := item_b('IN_FEVEREIRO28', tFGR_FORMULACA);

        if (item_b('IN_CONVENIO', tFGR_FORMULACA) = True) then begin
          vInConvenio := True;
          vDiaVenctoConvenio := item_f('NR_DIACONVENIO', tFGR_FORMULACA);
        end;

        vInGeraFaturaOp := item_b('IN_GERAFATOPERADORA', tFGR_FORMULACA);
        vPrTaxa := item_f('PR_TAXA', tFGR_FORMULACA);
      end;
    end;
    if (vInConvenio = True)  and (vInFaturamento = True) then begin
      if (vDiaVenctoConvenio = '')  or (vDiaVenctoConvenio = 0) then begin
        Result := SetStatus(STS_AVISO, 'GEN001', 'Dia de vencimento de convênio não informado para formula cartão ' + item_a('cd_formulacartao', tFGR_FORMULACASVC,) + ' cDS_METHOD);
        return(-1); exit;
      end;

      viParams := '';
      putitemXml(viParams, 'CD_PORTADOR', cdportador);
      putitemXml(viParams, 'DT_VendA', dtvenda);
      putitemXml(viParams, 'NR_PARCELAS', nrparcelas);
      putitemXml(viParams, 'DIA_VENCTOCONVENIO', vDiaVenctoConvenio);
      putitemXml(viParams, 'NR_DIASCARENCIA', vNrDiasCarencia);
      voParams := geraVenctoConvenio(viParams); (* PARAM_GLB, viParams, voParams, xCdErro, xCtxErro *)
      if (xStatus < 0) then begin
        Result := voParams;
        return(-1); exit;
      end;
    end else begin

      if (vInProprio = True) then begin
        if (vNrDiasCarencia = '')  or (vNrDiasCarencia <= 0) then begin
          vNrDiasCarencia := 0;
        end;
        if (NrVectoCliente <> '' ) and (NrVectoCliente > 0) then begin
          DtVenctoClienteMesCorrente := '' + NrVectoCliente + '/' + DtVenda[M] + '/' + DtVenda[Y]' + ';
        end else begin
          Result := SetStatus(STS_ERROR, 'GEN001', 'Dia do vencimento do cliente não informado !', cDS_METHOD);
          return(-1); exit;
        end;
        if (vInCarenciaUtil = True) then begin
          NrContador := 0;
          DtBase := DtVenctoClienteMesCorrente;
          DsWhile := 'SIM';
          while (DsWhile := 'SIM') do begin

            if (NrContador >= vNrDiasCarencia) then begin
              break;
            end;

            DtBase := DtBase -1d;

            putitemXml(viParams, 'CD_EMPRESA', '' + CdEmpresa') + ';
            putitemXml(viParams, 'DT_DATABASE', '' + DtBase') + ';
            putitemXml(viParams, 'IN_SABADOUTIL', '0');
              voParams := activateCmp('FGRSVCO007', 'ValidaDiaUtil', viParams); (*,,,, *)
            if (xStatus < 0) then begin
              Result := voParams;
              return(1);
            end;

            DsDiaUtil := itemXml('DS_DIAUTIL', voParams);
            if (DsDiaUtil = 'SIM') then begin
              NrContador := NrContador + 1;
            end;
          end;
          DtMelhorDataCompra := DtBase;
        end else begin

          if (DtVenctoClienteMesCorrente < DtVenda) then begin
            DtVenctoClienteAux := DtVenctoClienteMesCorrente;
              addmonths 1, '' + DtVenctoClienteAux' + ';
            DtVenctoClienteAux := gresult;
            vNrDiasAux := DtVenctoClienteAux - DtVenda;
            if (vNrDiasAux <= vNrDiasCarencia) then begin
                addmonths 1, '' + DtVenctoClienteMesCorrente' + ';
              DtVenctoClienteMesCorrente := gresult;
            end;
          end;

          DtMelhorDataCompra := (DtVenctoClienteMesCorrente - vNrDiasCarencia);

        end;

        NrContador := 1;
        while (NrContador <= NrParcelas) do begin

          if (NrContador = 1) then begin
            if (DtVenda > DtMelhorDataCompra) then begin
                addmonths 1, '' + DtVenctoClienteMesCorrente' + ';
              gDtVencimento := gresult;
            end else begin

              gDtVencimento := DtVenctoClienteMesCorrente;
            end;

            addmonths -1, '' + gDtVencimento' + ';
            DtVectoBase := gresult;

            if (vInDiaFixo = True) then begin
              vDiaFixo := gDtvencimento[D];
              vNrMes := gDtvencimento[M];
              vNrAno := gDtvencimento[Y];
            end;

          end else begin

            if (vInDiaFixo = True) then begin
              viParams := '';
              vNrMes := vNrMes + 1;
              putitemXml(viParams, 'CD_EMPRESA', cdEmpresa);
              putitemXml(viParams, 'DT_VENCIMENTO', gDtvencimento);
              putitemXml(viParams, 'DIA_FIXO', vDiaFixo);
              putitemXml(viParams, 'NR_MES', vNrMes);
              putitemXml(viParams, 'NR_ANO', vNrAno);
              voParams := geraDataDiaFixo(viParams); (* PARAM_GLB, viParams, voParams, xCdErro, xCtxErro *)
              if (xStatus < 0) then begin
                Result := voParams;
                return(-1); exit;
              end;

              gDtVencimento := itemXml('DT_VENCIMENTO', voParams);
              vNrMes := itemXmlF('NR_MES', voParams);
              vNrAno := itemXmlF('NR_ANO', voParams);
            end else begin
              addmonths '' + NrContador', + ' '' + DtVectoBase' + ';
              gDtVencimento := gresult;
            end;
          end;

          creocc(tDUMMY_VECTOS, -1);
          putitem_e(tDUMMY_VECTOS, 'NR_PARCELA', NrContador);
          putitem_e(tDUMMY_VECTOS, 'DT_VENCIMENTO', gDtVencimento);

          Nrcontador := NrContador + 1;
        end;
      end else begin
        NrContador := 1;
        while (NrContador <= NrParcelas) do begin

          if (NrContador = 1) then begin
            NrDiasSoma := (vNrDiasBase + vNrDias);

            if (DtVenda[M] = 2 ) and (vInFevereiro28 = True) then begin
              vBiSexto := DtVenda[Y] / 4;
              vBiSexto := vBiSexto[fraction];
              if (vBiSexto = 0) then begin
                gDtVencimento := (DtVenda + 29);
              end else begin
                gDtVencimento := (DtVenda + 28);
              end;
            end else begin
              gDtVencimento := (DtVenda + NrDiasSoma);
            end;
          end else begin

            if (vInDiaFixo = True) then begin
              viParams := '';
              vNrMes := vNrMes + 1;
              putitemXml(viParams, 'CD_EMPRESA', cdEmpresa);
              putitemXml(viParams, 'DT_VENCIMENTO', dtVencimentoFinal);
              putitemXml(viParams, 'DIA_FIXO', vDiaFixo);
              putitemXml(viParams, 'NR_MES', vNrMes);
              putitemXml(viParams, 'NR_ANO', vNrAno);
              voParams := geraDataDiaFixo(viParams); (* PARAM_GLB, viParams, voParams, xCdErro, xCtxErro *)
              if (xStatus < 0) then begin
                Result := voParams;
                return(-1); exit;
              end;

              gDtVencimento := itemXml('DT_VENCIMENTO', voParams);
              vNrMes := itemXmlF('NR_MES', voParams);
              vNrAno := itemXmlF('NR_ANO', voParams);
            end else begin

              NrDiasSoma := vNrDias;

              if (gDtVencimento[M] = 2 ) and (vInFevereiro28 = True) then begin
                vBiSexto := gDtVencimento[Y] / 4;
                vBiSexto := vBiSexto[fraction];
                if (vBiSexto = 0) then begin
                  gDtVencimento := (gDtVencimento + 29);
                end else begin
                  gDtVencimento := (gDtVencimento + 28);
                end;
              end else begin
                gDtVencimento := (gDtVencimento + vNrDias);
              end;
            end;
          end;
          if (vInDiasUtil = True) then begin
            putitemXml(viParams, 'CD_EMPRESA', '' + CdEmpresa') + ';
            putitemXml(viParams, 'DT_DATA', '' + gDtVencimento') + ';
            putitemXml(viParams, 'IN_SABADOUTIL', '0');
            voParams := activateCmp('FGRSVCO007', 'RetornaProximoDiaUtil', viParams); (*,,,, *)
            if (xStatus < 0) then begin
              Result := voParams;
              return(1);
            end;
            DtVencimentoFinal := itemXml('DT_DIAUTIL', voParams);

          end else begin
            DtVencimentoFinal := gDtVencimento;
          end;
          if (nrContador = 1)  and (vInDiaFixo = True) then begin
            vDiaFixo := dtVencimentoFinal[D];
            vNrMes := dtVencimentoFinal[M];
            vNrAno := dtVencimentoFinal[Y];
          end;

          creocc(tDUMMY_VECTOS, -1);
          putitem_e(tDUMMY_VECTOS, 'NR_PARCELA', NrContador);
          putitem_e(tDUMMY_VECTOS, 'DT_VENCIMENTO', DtVencimentoFinal);
          putitem_e(tDUMMY_VECTOS, 'NR_DIAS', NrDiasSoma);

          Nrcontador := NrContador + 1;
        end;
      end;
    end;
  end;

  setocc(tDUMMY_VECTOS, 1);
  while (xStatus >= 0) do begin
    putlistitensocc_e(ListaVencimento, tDUMMY_VECTOS);

    putitemXml(ListaVencimento, 'IN_PROPRIO', vInProprio);
    putitemXml(ListaVencimento, 'IN_GERAFATOP', vInGeraFaturaOp);
    putitem(Result,  ListaVencimento);
    setocc(tDUMMY_VECTOS, curocc(tDUMMY_VECTOS) + 1);
  end;
  putitemXml(Result, 'PR_TAXA', vPrTaxa);

  gDtVencimento := '';

  return(0); exit;
end;

//---------------------------------------------------------------
function T_FGRSVCO006.geraDataDiaFixo(pParams : String) : String;
//---------------------------------------------------------------
const
  cDS_METHOD = 'ADICIONAL=Operação: T_FGRSVCO006.geraDataDiaFixo()';
var
  viParams, voParams : String;
  vCdEmpresa, vDiaFixo, vDia, vMes, vAno, vBiSexto : Real;
  vDtVencimento : TDate;
begin
  vCdEmpresa := itemXmlF('CD_EMPRESA', pParams);
  vDiaFixo := itemXml('DIA_FIXO', pParams);
  vMes := itemXmlF('NR_MES', pParams);
  vAno := itemXmlF('NR_ANO', pParams);
  if (vMes > 12) then begin
    vMes := 1;
    vAno := vAno + 1;
  end;
  vDtVencimento := '' + vDiaFixo + '/' + vMes + '/' + vAno' + ';
  if (vDtVencimento = '') then begin
    if (vMes = 1) then begin
      vDia := 31;
    end;
    if (vMes = 2) then begin
      vBiSexto := vAno / 4;
      vBiSexto := vBiSexto[fraction];
      if (vBiSexto = 0) then begin
        vDia := 29;
      end else begin
        vDia := 28;
      end;
    end;
    if (vMes = 3) then begin
      vDia := 31;
    end;
    if (vMes = 4) then begin
      vDia := 30;
    end;
    if (vMes = 5) then begin
      vDia := 31;
    end;
    if (vMes = 6) then begin
      vDia := 30;
    end;
    if (vMes = 7) then begin
      vDia := 31;
    end;
    if (vMes = 8) then begin
      vDia := 31;
    end;
    if (vMes = 9) then begin
      vDia := 30;
    end;
    if (vMes = 10) then begin
      vDia := 31;
    end;
    if (vMes = 11) then begin
      vDia := 30;
    end;
    if (vMes = 12) then begin
      vDia := 31;
    end;

    vDtVencimento := '' + vDia + '/' + vMes + '/' + vAno' + ';
  end;

  Result := '';
  putitemXml(Result, 'NR_MES', vMes);
  putitemXml(Result, 'NR_ANO', vAno);
  putitemXml(Result, 'DT_VENCIMENTO', vDtVencimento);

  return(0); exit;
end;

//------------------------------------------------------------------
function T_FGRSVCO006.geraVenctoConvenio(pParams : String) : String;
//------------------------------------------------------------------
const
  cDS_METHOD = 'ADICIONAL=Operação: T_FGRSVCO006.geraVenctoConvenio()';
var
  viParams, voParams, vDataAux : String;
  vCdPortador, vNrParcelas, vNrDiasCarencia, vDiaVenctoConvenio, vNrMes, vNrAno, vNrContador : Real;
  vDtVenda, vDtConvenio, vDtVencimento : TDate;
begin
  vDtVenda := itemXml('DT_VendA', pParams);
  vCdPortador := itemXmlF('CD_PORTADOR', pParams);
  vNrParcelas := itemXmlF('NR_PARCELAS', pParams);
  vDiaVenctoConvenio := itemXml('DIA_VENCTOCONVENIO', pParams);
  vNrDiasCarencia := itemXmlF('NR_DIASCARENCIA', pParams);

  if (vDtVenda = '') then begin
    Result := SetStatus(STS_ERROR, 'GEN001', 'Favor informar data de venda para gerar data de vencimento de convênio', cDS_METHOD);
    return(-1); exit;
  end;
  if (vNrParcelas = '') then begin
    Result := SetStatus(STS_ERROR, 'GEN001', 'Favor informar número de parcelas para gerar data de vencimento de convênio', cDS_METHOD);
    return(-1); exit;
  end;
  if (vDiaVenctoConvenio = '') then begin
    Result := SetStatus(STS_ERROR, 'GEN001', 'Favor informar o dia de vencimento do convênio', cDS_METHOD);
    return(-1); exit;
  end;

  vNrContador := 1;
  repeat

    if (vNrContador = 1) then begin
      vNrMes := vDtVenda[M];
      vNrAno := vDtVenda[Y];
      vDtConvenio := '' + vDiaVenctoConvenio + '/' + FloatToStr(vNrMes) + '/' + FloatToStr(vNrAno') + ';
      vDtVencimento := vDtVenda + vNrDiasCarencia;
      if (vDtVencimento > vDtConvenio) then begin
        vNrMes := vNrMes + 1;
      end;
    end else begin
      vNrMes := vNrMes + 1;
    end;

    viParams := '';
    putitemXml(viParams, 'DIA_FIXO', vDiaVenctoConvenio);
    putitemXml(viParams, 'NR_MES', vNrMes);
    putitemXml(viParams, 'NR_ANO', vNrAno);
    voParams := geraDataDiaFixo(viParams); (* PARAM_GLB, viParams, voParams, xCdErro, xCtxErro *)
    if (xStatus < 0) then begin
      Result := voParams;
      return(-1); exit;
    end;

    vDtVencimento := itemXml('DT_VENCIMENTO', voParams);
    vNrMes := itemXmlF('NR_MES', voParams);
    vNrAno := itemXmlF('NR_ANO', voParams);

    creocc(tDUMMY_VECTOS, -1);
    putitem_e(tDUMMY_VECTOS, 'NR_PARCELA', vNrContador);
    putitem_e(tDUMMY_VECTOS, 'DT_VENCIMENTO', vDtVencimento);

    vNrContador := vNrContador + 1;
  until(vNrParcelas < vNrContador);

  return(0); exit;
end;

end.
