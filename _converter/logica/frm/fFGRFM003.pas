unit cFGRFM003;

interface

(* COMPONENTES 
  GERSVCO007 / GERSVCO031 / 
*)        

uses
  Classes, SysUtils, Math, DB,
  cServiceUnf, cDataSetUnf;

type
  T_FGRFM003 = class(TcServiceUnf)
  private
    tFCX_HISTRELSUB,
    tSIS_DUMMY,
    tSIS_PARCELAMENTO : TcDatasetUnf;
    function getParam(pParams : String = '') : String;
    function setEntidade(pParams : String = '') : String;
  protected
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;    
  published
    function preEDIT(pParams : String = '') : String;
    function carregarPortador(pParams : String = '') : String;
    function carregarParcelas(pParams : String = '') : String;
    function valorPadrao(pParams : String = '') : String;
    function geraParcela(pParams : String = '') : String;
    function numerar(pParams : String = '') : String;
    function validaCampos(pParams : String = '') : String;
  end;

implementation

uses
  cADMSVCO001,
  cActivate, cStatus, cFuncao, cXml, dModulo;

var
  gCdCartao,
  gDsLstParcela,
  gInDireto,
  gInSimulador,
  gNrDocumento,
  gNrParcela,
  gNrPortador,
  gNrSeqHistRelSub,
  gTpArredondamento,
  gVlDocumento : String;

//---------------------------------------------------------------
constructor T_FGRFM003.Create(AOwner: TComponent);
//---------------------------------------------------------------
begin
  inherited Create(AOwner);
  setEntidade('');
end;

//--------------------------------
destructor T_FGRFM003.Destroy;
//--------------------------------
begin
  inherited Destroy;
end;

//---------------------------------------------------------------
function T_FGRFM003.getParam(pParams : String = '') : String;
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
function T_FGRFM003.setEntidade(pParams : String = '') : String;
//---------------------------------------------------------------
begin
  tFCX_HISTRELSUB := GetEntidade('FCX_HISTRELSUB');
  tSIS_DUMMY := GetEntidade('SIS_DUMMY');
  tSIS_PARCELAMENTO := GetEntidade('SIS_PARCELAMENTO');
end;

//-----------------------------------------------------
function T_FGRFM003.preEDIT(pParams : String) : String;
//-----------------------------------------------------

var
  viParams, voParams : String;
begin
  gVlDocumento := itemXmlF('VL_DOCUMENTO', viParams);
  gNrPortador := itemXmlF('NR_PORTADOR', viParams);
  gNrSeqHistRelSub := itemXmlF('NR_SEQHISTRELSUB', viParams);
  gNrDocumento := itemXmlF('NR_DOCUMENTO', viParams);
  gTpArredondamento := itemXmlF('TP_ARREDONDAMENTO', viParams);
  gInDireto := itemXmlB('IN_DIRETO', viParams);
  gCdCartao := itemXmlF('CD_CARTAO', viParams);
  gInSimulador := itemXmlB('IN_SIMULADOR', viParams);

  if (gVlDocumento = 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', , cDS_METHOD);
    return(-1); exit;
  end;

  voParams := carregarPortador(viParams); (* *)
  if (xStatus < 0) then begin
    Result := voParams;
    return(-1); exit;
  end;

  voParams := valorPadrao(viParams); (* *)
  if (xStatus < 0) then begin
    Result := voParams;
    return(-1); exit;
  end;

  return(0); exit;
end;

//--------------------------------------------------------------
function T_FGRFM003.carregarPortador(pParams : String) : String;
//--------------------------------------------------------------

var
  viParams, voParams : String;
begin
  viParams := '';
  putitemXml(viParams, 'TP_PORTADOR', 3);
  voParams := activateCmp('GERSVCO007', 'ListPortador', viParams); (*viParams,voParams,, *)
  if (xStatus < 0) then begin
    Result := voParams;
    return(-1); exit;
  end;

  valrep(putitem_e(tSIS_DUMMY, 'TP_PORTADOR'), voParams);

  return(0); exit;
end;

//--------------------------------------------------------------
function T_FGRFM003.carregarParcelas(pParams : String) : String;
//--------------------------------------------------------------

var
  viParams, voParams : String;
begin
  viParams := '';
  putitemXml(viParams, 'TP_DOCUMENTO', 4);
  putitemXml(viParams, 'NR_PORTADOR', item_f('TP_PORTADOR', tSIS_DUMMY));
  putitemXml(viParams, 'CD_CARTAO', gCdCartao);
  voParams := activateCmp('GERSVCO007', 'ListHistRelSub', viParams); (*viParams,voParams,, *)
  if (xStatus < 0) then begin
    Result := voParams;
    return(-1); exit;
  end;

  valrep(putitem_e(tSIS_DUMMY, 'NR_SEQHISTRELSUB'), voParams);

  return(0); exit;
end;

//---------------------------------------------------------
function T_FGRFM003.valorPadrao(pParams : String) : String;
//---------------------------------------------------------

var
  viParams, voParams, vDsLstDocumento : String;
  vNrDocumento : Real;
begin
  if (gInDireto = True) then begin
    if (gNrSeqHistRelSub = 0) then begin
      Result := SetStatus(STS_ERROR, 'GEN0001', , cDS_METHOD);
      return(-1); exit;
    end;
    if (gNrDocumento = 0) then begin
      voParams := numerar(viParams); (* *)
    end;

    clear_e(tFCX_HISTRELSUB);
    putitem_e(tFCX_HISTRELSUB, 'TP_DOCUMENTO', 4);
    putitem_e(tFCX_HISTRELSUB, 'NR_SEQHISTRELSUB', gNrSeqHistRelSub);
    retrieve_e(tFCX_HISTRELSUB);
    if (xStatus < 0) then begin
      Result := SetStatus(STS_ERROR, 'GEN0001', , cDS_METHOD);
      return(-1); exit;
    end;

    gNrPortador := item_f('NR_PORTADOR', tFCX_HISTRELSUB);
    fieldsyntax item_f('TP_PORTADOR', tSIS_DUMMY), 'DIM';
    fieldsyntax item_f('NR_SEQHISTRELSUB', tSIS_DUMMY), 'DIM';
  end;

  putitem_e(tSIS_DUMMY, 'VL_DOCUMENTO', gVlDocumento);
  putitem_e(tSIS_DUMMY, 'TP_PORTADOR', gNrPortador);
  voParams := carregarParcelas(viParams); (* *)
  if (xStatus < 0) then begin
    Result := voParams;
    return(-1); exit;
  end;

  putitem_e(tSIS_DUMMY, 'NR_SEQHISTRELSUB', gNrSeqHistRelSub);
  putitem_e(tSIS_DUMMY, 'NR_DOCUMENTO', gNrDocumento);

  if (gInSimulador = True) then begin
    fieldsyntax item_f('VL_DOCUMENTO', tSIS_DUMMY), '';

    gNrParcela := 0;
    if (gNrSeqHistRelSub <> 0) then begin
      clear_e(tFCX_HISTRELSUB);
      putitem_e(tFCX_HISTRELSUB, 'TP_DOCUMENTO', 4);
      putitem_e(tFCX_HISTRELSUB, 'NR_SEQHISTRELSUB', gNrSeqHistRelSub);
      retrieve_e(tFCX_HISTRELSUB);
      if (xStatus >= 0) then begin
        gNrParcela := item_f('NR_PARCELAS', tFCX_HISTRELSUB);
      end;
    end;
  end else begin
    fieldsyntax item_f('VL_DOCUMENTO', tSIS_DUMMY), 'DIM';
  end;

  gprompt := item_f('NR_DOCUMENTO', tSIS_DUMMY);

  return(0); exit;
end;

//---------------------------------------------------------
function T_FGRFM003.geraParcela(pParams : String) : String;
//---------------------------------------------------------

var
  vDsRegistro, viParams, voParams, listaVencimento, lstVencto : String;
  vNrIndice, vVlCalc, vVlParcela, vVlResto : Real;
begin
  clear_e(tFCX_HISTRELSUB);
  putitem_e(tFCX_HISTRELSUB, 'TP_DOCUMENTO', 4);
  putitem_e(tFCX_HISTRELSUB, 'NR_SEQHISTRELSUB', item_f('NR_SEQHISTRELSUB', tSIS_DUMMY));
  retrieve_e(tFCX_HISTRELSUB);
  if (xStatus < 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', , cDS_METHOD);
    return(-1); exit;
  end;
  if (item_f('NR_PARCELAS', tFCX_HISTRELSUB) = 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', , cDS_METHOD);
    return(-1); exit;
  end;
  if (gInSimulador = True)  and (gNrParcela <> 0)  and (gNrParcela <> item_f('NR_PARCELAS', tFCX_HISTRELSUB)) then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', , cDS_METHOD);
    return(-1); exit;
  end;
  if (gInSimulador = True)  and (item_f('VL_DOCUMENTO', tSIS_DUMMY) <= 0 ) or (item_f('VL_DOCUMENTO', tSIS_DUMMY) > gVlDocumento) then begin
    message/info 'O valor do documento deve ser maior que 0 (zero) e menor ou igual a ' + FloatToStr(gVlDocumento) + '!';
    gprompt := item_f('VL_DOCUMENTO', tSIS_DUMMY);
    return(-1); exit;
  end;

  gDsLstParcela := '';
  clear_e(tSIS_PARCELAMENTO);

  vVlCalc := item_f('VL_DOCUMENTO', tSIS_DUMMY) / item_f('NR_PARCELAS', tFCX_HISTRELSUB);
  vVlParcela := roundto(vVlCalc, 2);
  vVlResto := item_f('VL_DOCUMENTO', tSIS_DUMMY);

  vNrIndice := 1;
  repeat
    creocc(tSIS_PARCELAMENTO, -1);
    putitem_e(tSIS_PARCELAMENTO, 'NR_PARCELA', vNrIndice);
    putitem_e(tSIS_PARCELAMENTO, 'VL_PARCELA', vVlParcela);
    putitem_e(tSIS_PARCELAMENTO, 'DT_VENCIMENTO', itemXml('DT_SISTEMA', PARAM_GLB));
    vVlResto := vVlResto - vVlParcela;
    vNrIndice := vNrIndice + 1;
  until (vNrIndice > item_f('NR_PARCELAS', tFCX_HISTRELSUB));

  setocc(tSIS_PARCELAMENTO, 1);

  putitem_e(tSIS_PARCELAMENTO, 'VL_PARCELA', item_f('VL_PARCELA', tSIS_PARCELAMENTO) + vVlResto);

  if (empty(tSIS_PARCELAMENTO) = False) then begin
    setocc(tSIS_PARCELAMENTO, 1);
    while (xStatus >= 0) do begin
      putlistitensocc_e(vDsRegistro, tSIS_PARCELAMENTO);
      putitem(gDsLstParcela,  vDsRegistro);
      setocc(tSIS_PARCELAMENTO, curocc(tSIS_PARCELAMENTO) + 1);
    end;
  end;

  return(0); exit;
end;

//-----------------------------------------------------
function T_FGRFM003.numerar(pParams : String) : String;
//-----------------------------------------------------

var
  vNrFat : Real;
  vDtSistema : TDate;
  viParams,voParams : String;
begin
  viParams := '';
  putitemXml(viParams, 'NM_ENTIDADE', 'FCR_FATURAI');
  voParams := activateCmp('GERSVCO031', 'getNumSeq', viParams); (*,viParams,voParams,, *)
  if (xStatus < 0) then begin
    Result := voParams;
    return(-1); exit;
  end;

  gNrDocumento := itemXmlF('NR_SEQUENCIA', voParams);

  return(0); exit;
end;

//----------------------------------------------------------
function T_FGRFM003.validaCampos(pParams : String) : String;
//----------------------------------------------------------
begin
if (item_f('NR_DOCUMENTO', tSIS_DUMMY) = 0) then begin
  Result := SetStatus(STS_ERROR, 'GEN0001', , cDS_METHOD);
  return(-1); exit;
end;
if (item_f('TP_PORTADOR', tSIS_DUMMY) = 0) then begin
  Result := SetStatus(STS_ERROR, 'GEN0001', , cDS_METHOD);
  return(-1); exit;
end;
if (item_f('NR_SEQHISTRELSUB', tSIS_DUMMY) = 0) then begin
  Result := SetStatus(STS_ERROR, 'GEN0001', , cDS_METHOD);
  return(-1); exit;
end;

voParams := geraParcela(viParams); (* *)

if (xStatus < 0) then begin
  return(-1); exit;
end;

putitemXml(voParams, 'DS_LSTPARCELA', gDsLstParcela);
putitemXml(voParams, 'NR_PORTADOR', item_f('TP_PORTADOR', tSIS_DUMMY));
putitemXml(voParams, 'NR_SEQHISTRELSUB', item_f('NR_SEQHISTRELSUB', tSIS_DUMMY));
putitemXml(voParams, 'NR_DOCUMENTO', item_f('NR_DOCUMENTO', tSIS_DUMMY));
putitemXml(voParams, 'CD_AUTORIZACAO', item_f('NR_AUTORIZACAO', tSIS_DUMMY));
putitemXml(voParams, 'NR_PARCELAS', item_f('NR_PARCELAS', tFCX_HISTRELSUB));

return(0); exit;

end.
