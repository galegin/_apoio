unit cFGRFM002;

interface

(* COMPONENTES 
  GERSVCO007 / GERSVCO031 / 
*)        

uses
  Classes, SysUtils, Math, DB,
  cServiceUnf, cDataSetUnf;

type
  T_FGRFM002 = class(TcServiceUnf)
  private
    tFCX_HISTRELSUB,
    tFGR_FORMULACAREMP,
    tFGR_FORMULACARTAO,
    tSIS_DUMMY : TcDatasetUnf;
    function getParam(pParams : String = '') : String;
    function setEntidade(pParams : String = '') : String;
  protected
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;    
  published
    function preEDIT(pParams : String = '') : String;
    function carregarCartao(pParams : String = '') : String;
    function valorPadrao(pParams : String = '') : String;
    function numerar(pParams : String = '') : String;
    function validaCampos(pParams : String = '') : String;
    function buscaDiasMaxPre(pParams : String = '') : String;
  end;

implementation

uses
  cADMSVCO001,
  cActivate, cStatus, cFuncao, cXml, dModulo;

var
  gInDireto,
  gNrDocumento,
  gNrSeqHistRelSub : String;

//---------------------------------------------------------------
constructor T_FGRFM002.Create(AOwner: TComponent);
//---------------------------------------------------------------
begin
  inherited Create(AOwner);
  setEntidade('');
end;

//--------------------------------
destructor T_FGRFM002.Destroy;
//--------------------------------
begin
  inherited Destroy;
end;

//---------------------------------------------------------------
function T_FGRFM002.getParam(pParams : String = '') : String;
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
function T_FGRFM002.setEntidade(pParams : String = '') : String;
//---------------------------------------------------------------
begin
  tFCX_HISTRELSUB := GetEntidade('FCX_HISTRELSUB');
  tFGR_FORMULACAREMP := GetEntidade('FGR_FORMULACAREMP');
  tFGR_FORMULACARTAO := GetEntidade('FGR_FORMULACARTAO');
  tSIS_DUMMY := GetEntidade('SIS_DUMMY');
end;

//-----------------------------------------------------
function T_FGRFM002.preEDIT(pParams : String) : String;
//-----------------------------------------------------
begin
  gNrSeqHistRelSub := itemXmlF('NR_SEQHISTRELSUB', viParams);
  gNrDocumento := itemXmlF('NR_DOCUMENTO', viParams);
  gInDireto := itemXmlB('IN_DIRETO', viParams);

  if (gNrDocumento = 0) then begin
    voParams := numerar(viParams); (* *)
    if (xStatus < 0) then begin
      Result := voParams;
      return(-1); exit;
    end;
  end;

  voParams := carregarCartao(viParams); (* *)
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

//------------------------------------------------------------
function T_FGRFM002.carregarCartao(pParams : String) : String;
//------------------------------------------------------------

var
  viParams, voParams : String;
begin
  viParams := '';
  putitemXml(viParams, 'TP_DOCUMENTO', 5);

  voParams := activateCmp('GERSVCO007', 'ListHistRelSub', viParams); (*viParams,voParams,, *)
  if (xStatus < 0) then begin
    Result := voParams;
    return(-1); exit;
  end;

  valrep(putitem_e(tSIS_DUMMY, 'NR_SEQHISTRELSUB'), voParams);

  return(0); exit;
end;

//---------------------------------------------------------
function T_FGRFM002.valorPadrao(pParams : String) : String;
//---------------------------------------------------------

var
  vDsLstDocumento : String;
  vNrDocumento : Real;
begin
  if (gInDireto = True) then begin
    if (gNrSeqHistRelSub = 0) then begin
      Result := SetStatus(STS_ERROR, 'GEN0001', , cDS_METHOD);
      return(-1); exit;
    end;
    fieldsyntax item_f('NR_SEQHISTRELSUB', tSIS_DUMMY), 'DIM';
  end;

  putitem_e(tSIS_DUMMY, 'NR_SEQHISTRELSUB', gNrSeqHistRelSub);
  putitem_e(tSIS_DUMMY, 'NR_DOCUMENTO', gNrDocumento);

  return(0); exit;
end;

//-----------------------------------------------------
function T_FGRFM002.numerar(pParams : String) : String;
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
function T_FGRFM002.validaCampos(pParams : String) : String;
//----------------------------------------------------------
var
  vDtSistema, vDtVencimento : TDate;
begin
  if (item_f('NR_SEQHISTRELSUB', tSIS_DUMMY) = 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', , cDS_METHOD);
    gprompt := item_f('NR_SEQHISTRELSUB', tSIS_DUMMY);
    return(-1); exit;
  end;
  if (item_f('NR_DOCUMENTO', tSIS_DUMMY) = 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', , cDS_METHOD);
    gprompt := item_f('NR_DOCUMENTO', tSIS_DUMMY);
    return(-1); exit;
  end;
  if (item_a('DT_VENCIMENTO', tSIS_DUMMY) <> '') then begin
    vDtSistema := itemXml('DT_SISTEMA', PARAM_GLB);
    vDtVencimento := vDtSistema + item_f('NR_DIASMAXPRE', tSIS_DUMMY);

    if (DT_VENCIMENTO > vDtVencimento) then begin
      Result := SetStatus(STS_ERROR, 'GEN0001', , cDS_METHOD);
      gprompt := item_a('DT_VENCIMENTO', tSIS_DUMMY);
      return(-1); exit;
    end;
  end;

  putitemXml(voParams, 'NR_SEQHISTRELSUB', item_f('NR_SEQHISTRELSUB', tSIS_DUMMY));
  putitemXml(voParams, 'NR_DOCUMENTO', item_f('NR_DOCUMENTO', tSIS_DUMMY));
  if (item_a('DT_VENCIMENTO', tSIS_DUMMY) = '') then begin
    putitemXml(voParams, 'DT_VENCIMENTO', itemXml('DT_SISTEMA', PARAM_GLB));
    putitemXml(voParams, 'IN_PREDATADO', False);
  end else begin
    putitemXml(voParams, 'DT_VENCIMENTO', item_a('DT_VENCIMENTO', tSIS_DUMMY));
    putitemXml(voParams, 'IN_PREDATADO', True);
  end;

  putitemXml(voParams, 'CD_AUTORIZACAO', item_f('NR_AUTORIZACAO', tSIS_DUMMY));

  return(0); exit;
end;

//-------------------------------------------------------------
function T_FGRFM002.buscaDiasMaxPre(pParams : String) : String;
//-------------------------------------------------------------
begin
putitem_e(tSIS_DUMMY, 'NR_DIASMAXPRE', '');

clear_e(tFCX_HISTRELSUB);
putitem_e(tFCX_HISTRELSUB, 'TP_DOCUMENTO', 5);
putitem_e(tFCX_HISTRELSUB, 'NR_SEQHISTRELSUB', item_f('NR_SEQHISTRELSUB', tSIS_DUMMY));
retrieve_e(tFCX_HISTRELSUB);
if (xStatus >= 0) then begin
  clear_e(tFGR_FORMULACAREMP);
  putitem_e(tFGR_FORMULACAREMP, 'CD_EMPRESA', itemXmlF('CD_EMPRESA', PARAM_GLB));
  putitem_e(tFGR_FORMULACAREMP, 'CD_FORMULACARTAO', item_f('CD_FORMULACARTAO', tFCX_HISTRELSUB));
  retrieve_e(tFGR_FORMULACAREMP);
  if (xStatus >= 0)  and (item_b('IN_PREDATADO', tFGR_FORMULACAREMP) = True) then begin
    fieldsyntax item_a('DT_VENCIMENTO', tSIS_DUMMY), '';
    putitem_e(tSIS_DUMMY, 'NR_DIASMAXPRE', item_f('NR_DIASMAXPRE', tFGR_FORMULACAREMP));
  end else begin
    clear_e(tFGR_FORMULACARTAO);
    putitem_e(tFGR_FORMULACARTAO, 'CD_FORMULACARTAO', item_f('CD_FORMULACARTAO', tFCX_HISTRELSUB));
    retrieve_e(tFGR_FORMULACARTAO);
    if (xStatus >= 0)  and (item_b('IN_PREDATADO', tFGR_FORMULACARTAO) = True) then begin
      fieldsyntax item_a('DT_VENCIMENTO', tSIS_DUMMY), '';
      putitem_e(tSIS_DUMMY, 'NR_DIASMAXPRE', item_f('NR_DIASMAXPRE', tFGR_FORMULACARTAO));
    end else begin
      putitem_e(tSIS_DUMMY, 'DT_VENCIMENTO', '');
      fieldsyntax item_a('DT_VENCIMENTO', tSIS_DUMMY), 'DIM';
    end;
  end;
end else begin
  putitem_e(tSIS_DUMMY, 'DT_VENCIMENTO', '');
  fieldsyntax item_a('DT_VENCIMENTO', tSIS_DUMMY), 'DIM';
end;

return(0); exit;

end;

end.
