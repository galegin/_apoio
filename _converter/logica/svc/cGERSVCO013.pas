unit cGERSVCO013;

interface

(* COMPONENTES 
  ADMSVCO001 / 
*)        

uses
  Classes, SysUtils, Math, DB,
  cDataSetUnf;

type
  T_GERSVCO013 = class(TComponent)
  private
    tGER_CONDPGTOC,
    tGER_CONDPGTOE,
    tGER_CONDPGTOH,
    tGER_CONDPGTOI,
    tSIS_PARCELAMENTO,
    tTMP_NR09 : TcDatasetUnf;
    function getParam(pParams : String = '') : String;
    function setEntidade(pParams : String = '') : String;
  protected
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;    
  published
    function INIT(pParams : String = '') : String;
    function calcPrzMedio(pParams : String = '') : String;
    function geraParcela(pParams : String = '') : String;
    function gravaDocumento(pParams : String = '') : String;
    function geraParcelaLimiteMinimo(pParams : String = '') : String;
  end;

implementation

uses
  cADMSVCO001,
  cActivate, cStatus, cFuncao, cXml, dModulo;

var
  gInParcelaMinima,
  gUsaCondPgtoEspecial,
  gVlMinimoParcela : String;

//---------------------------------------------------------------
constructor T_GERSVCO013.Create(AOwner: TComponent);
//---------------------------------------------------------------
begin
  inherited Create(AOwner);
  setEntidade('');
end;

//--------------------------------
destructor T_GERSVCO013.Destroy;
//--------------------------------
begin
  inherited Destroy;
end;

//---------------------------------------------------------------
function T_GERSVCO013.getParam(pParams : String = '') : String;
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
  putitem(xParam, 'IN_USA_COND_PGTO_ESPECIAL');

  xParam := T_ADMSVCO001.GetParametro(xParam);

  gUsaCondPgtoEspecial := itemXml('IN_USA_COND_PGTO_ESPECIAL', xParam);
  gVlMinimoParcela := itemXml('VL_MINIMO_PARCELA', xParam);
  vCdCondPgto := itemXml('CD_CONDPGTO', xParam);

  xParamEmp := '';
  putitem(xParamEmp, 'IN_USA_COND_PGTO_ESPECIAL');
  putitem(xParamEmp, 'VL_MINIMO_PARCELA');

  xParamEmp := T_ADMSVCO001.GetParamEmpresa(piCdEmpresa, xParamEmp);

  gVlMinimoParcela := itemXml('VL_MINIMO_PARCELA', xParamEmp);
  vCdCondPgto := itemXml('CD_CONDPGTO', xParamEmp);

end;

//---------------------------------------------------------------
function T_GERSVCO013.setEntidade(pParams : String = '') : String;
//---------------------------------------------------------------
begin
  tGER_CONDPGTOC := TcDatasetUnf.getEntidade('GER_CONDPGTOC');
  tGER_CONDPGTOE := TcDatasetUnf.getEntidade('GER_CONDPGTOE');
  tGER_CONDPGTOH := TcDatasetUnf.getEntidade('GER_CONDPGTOH');
  tGER_CONDPGTOI := TcDatasetUnf.getEntidade('GER_CONDPGTOI');
  tSIS_PARCELAMENTO := TcDatasetUnf.getEntidade('SIS_PARCELAMENTO');
  tTMP_NR09 := TcDatasetUnf.getEntidade('TMP_NR09');
end;

//----------------------------------------------------
function T_GERSVCO013.INIT(pParams : String) : String;
//----------------------------------------------------
const
  cDS_METHOD = 'ADICONAL=Operação: T_GERSVCO013.INIT()';
begin
  xParam := '';
  putitem(xParam,  'IN_USA_COND_PGTO_ESPECIAL');
  xParam := T_ADMSVCO001.GetParametro(xParam);
  gUsaCondPgtoEspecial := itemXmlB('IN_USA_COND_PGTO_ESPECIAL', xParam);

  putitem(xParamEmp,  'VL_MINIMO_PARCELA');
  xParamEmp := T_ADMSVCO001.GetParamEmpresa(piCdEmpresa, xParamEmp);
  gVlMinimoParcela := itemXmlF('VL_MINIMO_PARCELA', xParamEmp);

end;

//------------------------------------------------------------
function T_GERSVCO013.calcPrzMedio(pParams : String) : String;
//------------------------------------------------------------
const
  cDS_METHOD = 'ADICONAL=Operação: T_GERSVCO013.calcPrzMedio()';
var
  vCdCondPgto, vQtCalc, vNrParcela, vQtDia, vNrPrazoMedio : Real;
begin
  vCdCondPgto := itemXmlF('CD_CONDPGTO', pParams);

  if (vCdCondPgto = 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Condição de pagamento não informada!', cDS_METHOD);
    return(-1); exit;
  end;
  if (gUsaCondPgtoEspecial = 0) then begin
    clear_e(tGER_CONDPGTOC);
    putitem_e(tGER_CONDPGTOC, 'CD_CONDPGTO', vCdCondPgto);
    retrieve_e(tGER_CONDPGTOC);
    if (xStatus < 0) then begin
      Result := SetStatus(STS_ERROR, 'GEN0001', 'Condição de pagamento ' + FloatToStr(vCdCondPgto) + ' não cadastrada!', cDS_METHOD);
      return(-1); exit;
    end;
    if (empty(tGER_CONDPGTOI) <> False) then begin
      Result := '';
      putitemXml(Result, 'NR_PRAZOMEDIO', 0);
      return(0); exit;
    end;
    if (empty(tGER_CONDPGTOI) <> False) then begin
      voParams := SetErroApl(viParams); (* 'ERRO=-1;
      return(-1); exit;
    end;

    setocc(tGER_CONDPGTOI, -1);
    vNrParcela := totocc(tGER_CONDPGTOI);

    vQtDia := 0;

    setocc(tGER_CONDPGTOI, 1);
    while (xStatus >= 0) do begin
      vQtDia := vQtDia + item_f('QT_DIA', tGER_CONDPGTOI);
      setocc(tGER_CONDPGTOI, curocc(tGER_CONDPGTOI) + 1);
    end;

    vQtCalc := vQtDia / vNrParcela;
    vNrPrazoMedio := roundto(vQtCalc);

    Result := '';
    putitemXml(Result, 'NR_PRAZOMEDIO', vNrPrazoMedio);

  end else if (gUsaCondPgtoEspecial = 1) then begin
    clear_e(tGER_CONDPGTOC);
    putitem_e(tGER_CONDPGTOC, 'CD_CONDPGTO', vCdCondPgto);
    retrieve_e(tGER_CONDPGTOC);
    if (xStatus < 0) then begin
      Result := SetStatus(STS_ERROR, 'GEN0001', 'Condição de pagamento ' + FloatToStr(vCdCondPgto) + ' não cadastrada!', cDS_METHOD);
      return(-1); exit;
    end;
    if (empty(tGER_CONDPGTOI) <> False)  and (empty(tGER_CONDPGTOE) <> False) then begin
      Result := '';
      putitemXml(Result, 'NR_PRAZOMEDIO', 0);
      voParams := SetErroApl(viParams); (* 'ERRO=-1;
      return(-1); exit;
    end;
    if (empty(tGER_CONDPGTOI) = False) then begin
      setocc(tGER_CONDPGTOI, -1);
      vNrParcela := totocc(tGER_CONDPGTOI);

      vQtDia := 0;

      setocc(tGER_CONDPGTOI, 1);
      while (xStatus >= 0) do begin
        vQtDia := vQtDia + item_f('QT_DIA', tGER_CONDPGTOI);
        setocc(tGER_CONDPGTOI, curocc(tGER_CONDPGTOI) + 1);
      end;
    end;
    if (empty(tGER_CONDPGTOE) = False) then begin
      setocc(tGER_CONDPGTOE, -1);
      vNrParcela := totocc(tGER_CONDPGTOE);

      vQtDia := 0;

      setocc(tGER_CONDPGTOE, 1);
      while (xStatus >= 0) do begin
        vQtDia := vQtDia + item_f('NR_DIAVENCIMENTO', tGER_CONDPGTOE);
        setocc(tGER_CONDPGTOE, curocc(tGER_CONDPGTOE) + 1);
      end;
    end;
    vQtCalc := vQtDia / vNrParcela;
    vNrPrazoMedio := roundto(vQtCalc);

    Result := '';
    putitemXml(Result, 'NR_PRAZOMEDIO', vNrPrazoMedio);
  end;
  return(0); exit;
end;

//-----------------------------------------------------------
function T_GERSVCO013.geraParcela(pParams : String) : String;
//-----------------------------------------------------------
const
  cDS_METHOD = 'ADICONAL=Operação: T_GERSVCO013.geraParcela()';
var
  vDsRegistro, vDsLstParcela : String;
  vCdCondPgto, vNrParcela, vVlCalc, vVlParcela, vNrTotalDia : Real;
  vVlResto, vVlTotal, vNrPrazoMedio, vTpArredondamento : Real;
  vNrDiaFinal, vNrDiaSistem, vNrMesSistem, vNrAnoSistem : Real;
  vDtBase, vDtaSistemDia : TDate;
begin
  gInParcelaMinima := itemXmlB('IN_PARCELAMINIMA', pParams);
  if (gInParcelaMinima <> True) then begin
    gVlMinimoParcela := 0;
  end;

  vCdCondPgto := itemXmlF('CD_CONDPGTO', pParams);
  vVlTotal := itemXmlF('VL_TOTAL', pParams);
  vDtBase := itemXml('DT_BASE', pParams);
  if (vDtBase = '') then begin
    vDtBase := itemXml('DT_SISTEMA', PARAM_GLB);
  end;
  vTpArredondamento := itemXmlF('TP_ARREDONDAMENTO', pParams);

  if (vVlTotal = 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Valor não informado!', cDS_METHOD);
    return(-1); exit;
  end;
  if (vCdCondPgto = 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Condição de pagamento não informada!', cDS_METHOD);
    return(-1); exit;
  end;
  if (gUsaCondPgtoEspecial = 0) then begin
    clear_e(tGER_CONDPGTOC);
    putitem_e(tGER_CONDPGTOC, 'CD_CONDPGTO', vCdCondPgto);
    retrieve_e(tGER_CONDPGTOC);
    if (xStatus < 0) then begin
      Result := SetStatus(STS_ERROR, 'GEN0001', 'Condição de pagamento ' + FloatToStr(vCdCondPgto) + ' não cadastrada!', cDS_METHOD);
      return(-1); exit;
    end;
    if (empty(tGER_CONDPGTOI) <> False) then begin
      Result := SetStatus(STS_ERROR, 'GEN0001', 'Condição de pagamento ' + FloatToStr(vCdCondPgto) + ' sem parcelas cadastradas!', cDS_METHOD);
      return(-1); exit;
    end;

    setocc(tGER_CONDPGTOI, -1);
    vNrParcela := totocc(tGER_CONDPGTOI);

    vVlResto := vVlTotal;
    vVlCalc := vVlTotal / vNrParcela;

    if (vVlCalc < gVlMinimoParcela) then begin
      vNrParcela := 1;
      vVlResto := vVlTotal;
      vVlCalc := vVlTotal / vNrParcela;
    end;

    vVlParcela := roundto(vVlCalc, 2);
    if (vTpArredondamento = 1) then begin
      vVlParcela := gInt(vVlCalc);
      if (vVlParcela < 1) then begin
        vVlParcela := roundto(vVlCalc, 2);
      end;
    end;
    vNrTotalDia := 0;

    if (vNrParcela > 1) then begin
      clear_e(tSIS_PARCELAMENTO);
      setocc(tGER_CONDPGTOI, 1);
      while (xStatus >= 0) do begin
        creocc(tSIS_PARCELAMENTO, -1);
        putitem_e(tSIS_PARCELAMENTO, 'NR_PARCELA', curocc(tGER_CONDPGTOI));
        putitem_e(tSIS_PARCELAMENTO, 'VL_PARCELA', vVlParcela);
        putitem_e(tSIS_PARCELAMENTO, 'DT_VENCIMENTO', vDtBase + item_f('QT_DIA', tGER_CONDPGTOI));
        vNrTotalDia := vNrTotalDia + item_f('QT_DIA', tGER_CONDPGTOI);
        vVlResto := vVlResto - vVlParcela;
        setocc(tGER_CONDPGTOI, curocc(tGER_CONDPGTOI) + 1);
      end;
    end else begin
      clear_e(tSIS_PARCELAMENTO);
      setocc(tGER_CONDPGTOI, 1);
      creocc(tSIS_PARCELAMENTO, -1);
      putitem_e(tSIS_PARCELAMENTO, 'NR_PARCELA', 1);
      putitem_e(tSIS_PARCELAMENTO, 'VL_PARCELA', vVlParcela);
      putitem_e(tSIS_PARCELAMENTO, 'DT_VENCIMENTO', vDtBase + item_f('QT_DIA', tGER_CONDPGTOI));
      vNrTotalDia := vNrTotalDia + vNrPrazoMedio;
      vVlResto := vVlResto - vVlParcela;
    end;
    if (vVlResto <> 0) then begin
      if (vVlResto > 0) then begin
        setocc(tSIS_PARCELAMENTO, 1);
      end else begin
        setocc(tSIS_PARCELAMENTO, -1);
      end;
      putitem_e(tSIS_PARCELAMENTO, 'VL_PARCELA', item_f('VL_PARCELA', tSIS_PARCELAMENTO) + vVlResto);
    end;

    vDsLstParcela := '';
    setocc(tSIS_PARCELAMENTO, 1);
    while (xStatus >= 0) do begin
      vDsRegistro := '';
      putlistitensocc_e(vDsRegistro, tSIS_PARCELAMENTO);
      putitem(vDsLstParcela,  vDsRegistro);
      setocc(tSIS_PARCELAMENTO, curocc(tSIS_PARCELAMENTO) + 1);
    end;

    vVlCalc := vNrTotalDia / vNrParcela;
    vNrPrazoMedio := roundto(vVlCalc, 3);

    Result := '';
    putitemXml(Result, 'DS_LSTPARCELA', vDsLstParcela);
    putitemXml(Result, 'NR_PRAZOMEDIO', vNrPrazoMedio);

  end else if (gUsaCondPgtoEspecial = 1) then begin
    clear_e(tGER_CONDPGTOC);
    putitem_e(tGER_CONDPGTOC, 'CD_CONDPGTO', vCdCondPgto);
    retrieve_e(tGER_CONDPGTOC);
    if (xStatus < 0) then begin
      Result := SetStatus(STS_ERROR, 'GEN0001', 'Condição de pagamento ' + FloatToStr(vCdCondPgto) + ' não cadastrada!', cDS_METHOD);
      return(-1); exit;
    end;
    if (empty(tGER_CONDPGTOI) <> False)  and (empty(tGER_CONDPGTOE) <> False) then begin
      Result := SetStatus(STS_ERROR, 'GEN0001', 'Condição de pagamento ' + FloatToStr(vCdCondPgto) + ' sem parcelas cadastradas!', cDS_METHOD);
      return(-1); exit;
    end;
    if (empty(tGER_CONDPGTOI) = False) then begin
      setocc(tGER_CONDPGTOI, -1);
      vNrParcela := totocc(tGER_CONDPGTOI);

      vVlResto := vVlTotal;
      vVlCalc := vVlTotal / vNrParcela;
      vVlParcela := roundto(vVlCalc, 2);
      if (vTpArredondamento = 1) then begin
        vVlParcela := gInt(vVlCalc);
        if (vVlParcela < 1) then begin
          vVlParcela := roundto(vVlCalc, 2);
        end;
      end;
      vNrTotalDia := 0;

      clear_e(tSIS_PARCELAMENTO);
      setocc(tGER_CONDPGTOI, 1);
      while (xStatus >= 0) do begin
        creocc(tSIS_PARCELAMENTO, -1);
        putitem_e(tSIS_PARCELAMENTO, 'NR_PARCELA', curocc(tGER_CONDPGTOI));
        putitem_e(tSIS_PARCELAMENTO, 'VL_PARCELA', vVlParcela);
        putitem_e(tSIS_PARCELAMENTO, 'DT_VENCIMENTO', vDtBase + item_f('QT_DIA', tGER_CONDPGTOI));
        vNrTotalDia := vNrTotalDia + item_f('QT_DIA', tGER_CONDPGTOI);
        vVlResto := vVlResto - vVlParcela;
        setocc(tGER_CONDPGTOI, curocc(tGER_CONDPGTOI) + 1);
      end;
      if (vVlResto <> 0) then begin
        if (vVlResto > 0) then begin
          setocc(tSIS_PARCELAMENTO, 1);
        end else begin
          setocc(tSIS_PARCELAMENTO, -1);
        end;
        putitem_e(tSIS_PARCELAMENTO, 'VL_PARCELA', item_f('VL_PARCELA', tSIS_PARCELAMENTO) + vVlResto);
      end;

      vDsLstParcela := '';
      setocc(tSIS_PARCELAMENTO, 1);
      while (xStatus >= 0) do begin
        vDsRegistro := '';
        putlistitensocc_e(vDsRegistro, tSIS_PARCELAMENTO);
        putitem(vDsLstParcela,  vDsRegistro);
        setocc(tSIS_PARCELAMENTO, curocc(tSIS_PARCELAMENTO) + 1);
      end;

      vVlCalc := vNrTotalDia / vNrParcela;
      vNrPrazoMedio := roundto(vVlCalc, 3);

      Result := '';
      putitemXml(Result, 'DS_LSTPARCELA', vDsLstParcela);
      putitemXml(Result, 'NR_PRAZOMEDIO', vNrPrazoMedio);
      return(0); exit;
    end;
    if (empty(tGER_CONDPGTOE) = False) then begin
      setocc(tGER_CONDPGTOE, -1);
      vNrParcela := totocc(tGER_CONDPGTOE);

      vVlResto := vVlTotal;
      vVlCalc := vVlTotal;
      vVlParcela := roundto(vVlCalc, 2);

      vNrTotalDia := 0;
      vNrDiaFinal := 0;
      vDtaSistemDia := vDtBase;
      vNrDiaSistem := vDtaSistemDia[D];
      vNrMesSistem := vDtaSistemDia[M];
      vNrAnoSistem := vDtaSistemDia[Y];

      clear_e(tSIS_PARCELAMENTO);
      setocc(tGER_CONDPGTOE, 1);
      while (xStatus >= 0) do begin
        if (vNrDiaSistem >= item_f('NR_DIAINICIAL', tGER_CONDPGTOE))  and (vNrDiaSistem <= item_f('NR_DIAFINAL', tGER_CONDPGTOE)) then begin
          creocc(tSIS_PARCELAMENTO, -1);

          if (item_f('NR_PARCELAS', tGER_CONDPGTOC) = 1) then begin
            vNrMesSistem := vNrMesSistem + 1;
          end;
          if (item_f('NR_PARCELAS', tGER_CONDPGTOC) = 2)  or (item_f('NR_PARCELAS', tGER_CONDPGTOC) = 3) then begin
            vNrDiaFinal := item_f('NR_DIAFINAL', tGER_CONDPGTOE) + 10;
            if (vNrDiaFinal >= 30) then begin
              vNrMesSistem := vNrMesSistem + 1;
            end;
          end;
          if (vNrMesSistem > 12) then begin
            vNrMesSistem := 1;
            vNrAnoSistem := vNrAnoSistem + 1;
          end;

          putitem_e(tSIS_PARCELAMENTO, 'NR_PARCELA', curocc(tGER_CONDPGTOE));
          putitem_e(tSIS_PARCELAMENTO, 'VL_PARCELA', vVlParcela);
          putitem_e(tSIS_PARCELAMENTO, 'DT_VENCIMENTO', '' + item_f('NR_DIAVENCIMENTO', tGER_CONDPGTOE)/' + FloatToStr(vNrMesSistem/' + FloatToStr(vNrAnoSistem')) + ' + ' + ');
          vNrTotalDia := item_f('NR_DIAVENCIMENTO', tGER_CONDPGTOE);

          setocc(tGER_CONDPGTOE, curocc(tGER_CONDPGTOE) + 1);
        end;

        setocc(tGER_CONDPGTOE, curocc(tGER_CONDPGTOE) + 1);
      end;

      vDsLstParcela := '';
      setocc(tSIS_PARCELAMENTO, 1);
      while (xStatus >= 0) do begin
        vDsRegistro := '';
        putlistitensocc_e(vDsRegistro, tSIS_PARCELAMENTO);
        putitem(vDsLstParcela,  vDsRegistro);
        setocc(tSIS_PARCELAMENTO, curocc(tSIS_PARCELAMENTO) + 1);
      end;

      vVlCalc := vNrTotalDia;
      vNrPrazoMedio := roundto(vVlCalc, 3);

      Result := '';
      putitemXml(Result, 'DS_LSTPARCELA', vDsLstParcela);
      putitemXml(Result, 'NR_PRAZOMEDIO', vNrPrazoMedio);
    end;
  end;

  return(0); exit;
end;

//--------------------------------------------------------------
function T_GERSVCO013.gravaDocumento(pParams : String) : String;
//--------------------------------------------------------------
const
  cDS_METHOD = 'ADICONAL=Operação: T_GERSVCO013.gravaDocumento()';
var
  vCdCondPgto : Real;
  vDsLstDocumento, vDsRegistro : String;
begin
  vCdCondPgto := itemXmlF('CD_CONDPGTO', pParams);
  vDsLstDocumento := itemXml('DS_LSTDOCUMENTO', pParams);

  if (vCdCondPgto = 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Condição de pagamento não informada!', cDS_METHOD);
    return(-1); exit;
  end;

  clear_e(tGER_CONDPGTOC);
  putitem_e(tGER_CONDPGTOC, 'CD_CONDPGTO', vCdCondPgto);
  retrieve_e(tGER_CONDPGTOC);
  if (xStatus < 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Condição de pagamento ' + FloatToStr(vCdCondPgto) + ' não encontrada!', cDS_METHOD);
    return(-1); exit;
  end;
  if (empty(tGER_CONDPGTOH) = False) then begin
    setocc(tGER_CONDPGTOH, -1);

    voParams := tGER_CONDPGTOH.Excluir();
    if (xStatus < 0) then begin
      Result := voParams;
      return(-1); exit;
    end;
  end;
  if (vDsLstDocumento <> '') then begin
    repeat
      getitem(vDsRegistro, vDsLstDocumento, 1);

      creocc(tGER_CONDPGTOH, -1);
      getlistitensocc_e(vDsRegistro, tGER_CONDPGTOH);
      putitem_e(tGER_CONDPGTOH, 'CD_OPERADOR', itemXmlF('CD_USUARIO', PARAM_GLB));
      putitem_e(tGER_CONDPGTOH, 'DT_CADASTRO', Now);

      delitem(vDsLstDocumento, 1);
    until (vDsLstDocumento = '');
  end;

  voParams := tGER_CONDPGTOH.Salvar();
  if (xStatus < 0) then begin
    Result := voParams;
    return(-1); exit;
  end;

  return(0); exit;
end;

//-----------------------------------------------------------------------
function T_GERSVCO013.geraParcelaLimiteMinimo(pParams : String) : String;
//-----------------------------------------------------------------------
const
  cDS_METHOD = 'ADICONAL=Operação: T_GERSVCO013.geraParcelaLimiteMinimo()';
var
  vCdCondPgto, vQtCalc, vNrParcela, vQtDia, vNrPrazoMedio : Real;
  vVlCalc, vVlTotal, vVlMinimo, vVlParcela : Real;
  vDsLstDia, vDsRegistro : String;
  vInSair : Boolean;
begin
  vCdCondPgto := itemXmlF('CD_CONDPGTO', pParams);
  vVlTotal := itemXmlF('VL_TOTAL', pParams);
  vVlMinimo := itemXmlF('VL_MINIMO', pParams);

  if (vCdCondPgto = 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Condição de pagamento não informada!', cDS_METHOD);
    return(-1); exit;
  end;
  if (vVlTotal = 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Valor total não informado!', cDS_METHOD);
    return(-1); exit;
  end;
  if (vVlMinimo = 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Valor mínimo da parcela não informado!', cDS_METHOD);
    return(-1); exit;
  end;
  if (gUsaCondPgtoEspecial <> 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Para esse tipo de parcelamento não é permitido usar forma de pgto especial!', cDS_METHOD);
    return(-1); exit;
  end;

  clear_e(tGER_CONDPGTOC);
  putitem_e(tGER_CONDPGTOC, 'CD_CONDPGTO', vCdCondPgto);
  retrieve_e(tGER_CONDPGTOC);
  if (xStatus < 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Condição de pagamento ' + FloatToStr(vCdCondPgto) + ' não cadastrada!', cDS_METHOD);
    return(-1); exit;
  end;
  if (empty(tGER_CONDPGTOI) <> False) then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Condição de pagamento sem parcelas cadastradas!', cDS_METHOD);
    return(-1); exit;
  end;

  clear_e(tTMP_NR09);

  setocc(tGER_CONDPGTOI, 1);
  while (xStatus >= 0) do begin
    creocc(tTMP_NR09, -1);
    putitem_e(tTMP_NR09, 'NR_GERAL', curocc(tGER_CONDPGTOI));
    putitem_e(tTMP_NR09, 'NR_DIAS', item_f('QT_DIA', tGER_CONDPGTOI));
    setocc(tGER_CONDPGTOI, curocc(tGER_CONDPGTOI) + 1);
  end;

  vNrParcela := totocc(tTMP_NR09);
  vVlCalc := vVlTotal / vNrParcela;
  vVlParcela := roundto(vVlCalc, 2);

  while (vVlParcela < vVlMinimo) do begin
    if (totocc(tTMP_NR09) > 1) then begin
      setocc(tTMP_NR09, 1);
      while (xStatus >= 0) do begin
        if (curocc(tTMP_NR09) = totocc(TMP_NR09)) then begin
          discard 'TMP_NR09SVC';
          break;
        end else begin
          vVlCalc := (item_f('NR_DIAS', tTMP_NR09) + gnext('item_f('NR_DIAS', tTMP_NR09)')) / 2;
          vQtDia := roundto(vVlCalc, 0);
          putitem_e(tTMP_NR09, 'NR_DIAS', vQtDia);
          setocc(tTMP_NR09, curocc(tTMP_NR09) + 1);
        end;
      end;
      vNrParcela := totocc(tTMP_NR09);
      vVlCalc := vVlTotal / vNrParcela;
      vVlParcela := roundto(vVlCalc, 2);
    end else begin
      vNrParcela := 1;
      vVlParcela := roundto(vVlCalc, 2);
      break;
    end;
  end;

  setocc(tTMP_NR09, 1);
  vDsLstDia := '';
  putlistitems vDsLstDia, item_f('NR_DIAS', tTMP_NR09);

  putitemXml(Result, 'NR_PARCELA', vNrParcela);
  putitemXml(Result, 'DS_LSTDIA', vDsLstDia);

  return(0); exit;
end;

end.
