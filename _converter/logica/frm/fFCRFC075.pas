unit cFCRFC075;

interface

(* COMPONENTES 
  FCRSVCO068 / 
*)        

uses
  Classes, SysUtils, Math, DB,
  cServiceUnf, cDataSetUnf;

type
  T_FCRFC075 = class(TcServiceUnf)
  private
    tFCR_CHEQUEPRES,
    tFCR_CHEQUEPRES THEN BEGIN,
    tFGR_DUMMY,
    tV_PES_CLIENTE : TcDatasetUnf;
    function getParam(pParams : String = '') : String;
    function setEntidade(pParams : String = '') : String;
  protected
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;    
  published
    function valorPadrao(pParams : String = '') : String;
    function validaCodigoBarras(pParams : String = '') : String;
    function confirmarCheque(pParams : String = '') : String;
  end;

implementation

uses
  cADMSVCO001,
  cActivate, cStatus, cFuncao, cXml, dModulo;

var


//---------------------------------------------------------------
constructor T_FCRFC075.Create(AOwner: TComponent);
//---------------------------------------------------------------
begin
  inherited Create(AOwner);
  setEntidade('');
end;

//--------------------------------
destructor T_FCRFC075.Destroy;
//--------------------------------
begin
  inherited Destroy;
end;

//---------------------------------------------------------------
function T_FCRFC075.getParam(pParams : String = '') : String;
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
function T_FCRFC075.setEntidade(pParams : String = '') : String;
//---------------------------------------------------------------
begin
  tFCR_CHEQUEPRES := GetEntidade('FCR_CHEQUEPRES');
  tFCR_CHEQUEPRES THEN BEGIN := GetEntidade('FCR_CHEQUEPRES THEN BEGIN');
  tFGR_DUMMY := GetEntidade('FGR_DUMMY');
  tV_PES_CLIENTE := GetEntidade('V_PES_CLIENTE');
end;

//---------------------------------------------------------
function T_FCRFC075.valorPadrao(pParams : String) : String;
//---------------------------------------------------------
begin
  if (itemXml('VL_UTILIZAR', viParams)) then begin
    putitem_e(tFGR_DUMMY, 'VL_SALDOCOMPRA', itemXmlF('VL_UTILIZAR', viParams));
  end;

  gprompt := item_a('DS_BARRA', tFGR_DUMMY);

  return(0); exit;
end;

//----------------------------------------------------------------
function T_FCRFC075.validaCodigoBarras(pParams : String) : String;
//----------------------------------------------------------------

var
  viParams, voParams : String;
  vCdCliente, vNrCtaPes, vVlSaldo : Real;
  vDtSistema : TDate;
begin
  if (item_a('DS_BARRA', tFGR_DUMMY) = '') then begin
    return(0); exit;
  end;

  clear_e(tFCR_CHEQUEPRES);
  putitem_e(tFCR_CHEQUEPRES, 'CD_BARRA', item_a('DS_BARRA', tFGR_DUMMY));
  putitem_e(tFCR_CHEQUEPRES, 'TP_SITUACAO', 1);
  putitem_e(tFCR_CHEQUEPRES, 'TP_CHEQUE', 1);
  retrieve_e(tFCR_CHEQUEPRES);
  if (xStatus < 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN001', , cDS_METHOD);
    return(-1); exit;
  end else begin
    if (ghits('FCR_CHEQUEPRES') > 1) then begin
      Result := SetStatus(STS_ERROR, 'GEN001', , cDS_METHOD);
      clear_e(tFGR_DUMMY);
      clear_e(tFCR_CHEQUEPRES);
      return(-1); exit;
    end;
    if (item_a('DT_CANCELAMENTO', tFCR_CHEQUEPRES) <> '')  and (item_f('CD_OPERCANCEL', tFCR_CHEQUEPRES) <> '') then begin
      Result := SetStatus(STS_ERROR, 'GEN001', , cDS_METHOD);
      clear_e(tFGR_DUMMY);
      clear_e(tFCR_CHEQUEPRES);
      return(-1); exit;
    end;
    if (item_a('DT_VALIDADE', tFCR_CHEQUEPRES) < itemXml('DT_SISTEMA', PARAM_GLB)) then begin
      Result := SetStatus(STS_ERROR, 'GEN001', , cDS_METHOD);
      clear_e(tFGR_DUMMY);
      clear_e(tFCR_CHEQUEPRES);
      return(-1); exit;
    end;
    if (item_a('DT_UTILIZACAO', tFCR_CHEQUEPRES) > 0) then begin
      Result := SetStatus(STS_ERROR, 'GEN001', , cDS_METHOD);
      clear_e(tFGR_DUMMY);
      clear_e(tFCR_CHEQUEPRES);
      return(-1); exit;
    end;
  end;
  putitem_e(tFGR_DUMMY, 'CD_CLIENTE', item_f('CD_CLIENTE', tFCR_CHEQUEPRES));
  clear_e(tV_PES_CLIENTE);
  putitem_e(tV_PES_CLIENTE, 'CD_CLIENTE', item_f('CD_CLIENTE', tFGR_DUMMY));
  retrieve_e(tV_PES_CLIENTE);
  if (xStatus >=0) then begin
    putitem_e(tFGR_DUMMY, 'NM_CLIENTE', item_a('NM_PESSOA', tV_PES_CLIENTE));
  end else begin
    putitem_e(tFGR_DUMMY, 'NM_CLIENTE', 'Inexistente');
  end;

  vNrCtaPes := item_f('NR_CTAPES', tFCR_CHEQUEPRES);
  viParams := '';
  vDtSistema := itemXml('DT_SISTEMA', PARAM_GLB);
  putitemXml(viParams, 'NR_CTAPES', vNrCtapes);
  putitemXml(viParams, 'TP_DOCUMENTO', 18);
  putitemXml(viParams, 'NR_SEQHISTRELSUB', 1);
  putitemXml(viParams, 'CD_EMPRESA', item_f('CD_EMPRESA', tFCR_CHEQUEPRES));
  putitemXml(viParams, 'CD_CLIENTE', item_f('CD_CLIENTE', tFCR_CHEQUEPRES));
  putitemXml(viParams, 'NR_CHEQUE', item_f('NR_CHEQUE', tFCR_CHEQUEPRES));
  voParams := activateCmp('FCRSVCO068', 'buscaSaldoChequePresente', viParams); (*,viParams,voParams,, *)
  if (xStatus < 0) then begin
    Result := voParams;
    return(-1); exit;
  end;

  vVlSaldo := itemXmlF('VL_SALDO', voParams);
  putitem_e(tFGR_DUMMY, 'VL_SALDO', vVlSaldo);
  putitem_e(tFGR_DUMMY, 'DT_VALIDADE', item_a('DT_VALIDADE', tFCR_CHEQUEPRES));
  putitem_e(tFGR_DUMMY, 'VL_UTILIZAR', vVlSaldo);
  if (item_f('VL_SALDOCOMPRA', tFGR_DUMMY) < vVlSaldo) then begin
    putitem_e(tFGR_DUMMY, 'VL_UTILIZAR', item_f('VL_SALDOCOMPRA', tFGR_DUMMY));
  end;
  return(0); exit;
end;

//-------------------------------------------------------------
function T_FCRFC075.confirmarCheque(pParams : String) : String;
//-------------------------------------------------------------

var
  viParams, voParams, vpiFiltro : String;
begin
  if (item_a('DS_BARRA', tFGR_DUMMY) = 0)  or (item_a('DS_BARRA', tFGR_DUMMY) = '') then begin
    Result := SetStatus(STS_AVISO, 'GEN001', , cDS_METHOD);
    gprompt := item_a('DS_BARRA', tFGR_DUMMY);
    return(-1); exit;
  end;
  if (item_f('VL_UTILIZAR', tFGR_DUMMY) = 0)  or (item_f('VL_UTILIZAR', tFGR_DUMMY) = '') then begin
    Result := SetStatus(STS_AVISO, 'GEN001', , cDS_METHOD);
    gprompt := item_f('VL_UTILIZAR', tFGR_DUMMY);
    return(-1); exit;
  end;
  if (item_f('VL_UTILIZAR', tFGR_DUMMY) > item_f('VL_SALDO', tFGR_DUMMY)) then begin
    Result := SetStatus(STS_AVISO, 'GEN001', , cDS_METHOD);
    putitem_e(tFGR_DUMMY, 'VL_UTILIZAR', item_f('VL_SALDO', tFGR_DUMMY));
    gprompt := item_f('VL_UTILIZAR', tFGR_DUMMY);
    return(-1); exit;
  end;
  if (item_f('VL_UTILIZAR', tFGR_DUMMY) > item_f('VL_SALDOCOMPRA', tFGR_DUMMY)) then begin
    Result := SetStatus(STS_AVISO, 'GEN001', , cDS_METHOD);
    gprompt := item_a('DS_BARRA', tFGR_DUMMY);
    return(-1); exit;
  end;
  if (dbocc(tFCR_CHEQUEPRES)) then begin
    putitemXml(voParams, 'CD_BARRA', item_a('DS_BARRA', tFGR_DUMMY));
    putitemXml(voParams, 'CD_EMPRESA', item_f('CD_EMPRESA', tFCR_CHEQUEPRES));
    putitemXml(voParams, 'CD_CLIENTE', item_f('CD_CLIENTE', tFCR_CHEQUEPRES));
    putitemXml(voParams, 'NR_CHEQUE', item_f('NR_CHEQUE', tFCR_CHEQUEPRES));
    putitemXml(voParams, 'CD_EMPLIQ', item_f('CD_EMPLIQ', tFCR_CHEQUEPRES));
    putitemXml(voParams, 'DT_LIQ', item_a('DT_LIQ', tFCR_CHEQUEPRES));
    putitemXml(voParams, 'NR_SEQLIQ', item_f('NR_SEQLIQ', tFCR_CHEQUEPRES));
    putitemXml(voParams, 'VL_CHEQUE', item_f('VL_UTILIZAR', tFGR_DUMMY));
    putitemXml(voParams, 'DT_CHEQUE', itemXml('DT_SISTEMA', PARAM_GLB));
    putitemXml(voParams, 'NR_CTAPES', item_f('NR_CTAPES', tFCR_CHEQUEPRES));
  end else begin
    Result := SetStatus(STS_AVISO, 'GEN001', , cDS_METHOD);
    gprompt := item_a('DS_BARRA', tFGR_DUMMY);
    return(-1); exit;
  end;

  macro '^ACCEPT';

  return(0); exit;
end;

end.
