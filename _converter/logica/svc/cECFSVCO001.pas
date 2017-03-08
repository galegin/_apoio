unit cECFSVCO001;

interface

(* COMPONENTES 
  ADMSVCO001 / 
*)        

uses
  Classes, SysUtils, DB,
  cServiceUnf, cDataSetUnf;

type
  T_ECFSVCO001 = class(TcServiceUnf)
  private
    tFIS_ECF : TcDatasetUnf;
    function getParam(pParams : String = '') : String;
    function setEntidade(pParams : String = '') : String;
  protected
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;    
  published
    function espacoDireita(pParams : String = '') : String;
    function INIT(pParams : String = '') : String;
    function ABREPORTA(pParams : String = '') : String;
    function FECHAPORTA(pParams : String = '') : String;
    function ABRECUPOM(pParams : String = '') : String;
    function VendEITEM(pParams : String = '') : String;
    function FECHACUPOM(pParams : String = '') : String;
    function CANCELACUPOM(pParams : String = '') : String;
    function CANCELAITEM(pParams : String = '') : String;
    function ACRESCIMODESCONTOCUPOM(pParams : String = '') : String;
    function FORMAPAGAMENTO(pParams : String = '') : String;
    function REDUCAOZ(pParams : String = '') : String;
    function REGISTROTIPO60(pParams : String = '') : String;
    function LEITURAX(pParams : String = '') : String;
    function FECHAMENTODODIA(pParams : String = '') : String;
    function RELATORIOTIPO60ANALITICO(pParams : String = '') : String;
    function RELATORIOTIPO60MESTRE(pParams : String = '') : String;
    function LEITURAMEMORIAFISCALREDUCAO(pParams : String = '') : String;
    function LEITURAMEMORIAFISCALSERIALRED(pParams : String = '') : String;
    function LEITURAMEMORIAFISCALDATA(pParams : String = '') : String;
    function LEITURAMEMORIAFISCALSERIALDATA(pParams : String = '') : String;
    function ABRECOMPROVANTENFV(pParams : String = '') : String;
    function REGISTRANAOFISCAL(pParams : String = '') : String;
    function LEINFORMACAOIMPRESSORA(pParams : String = '') : String;
    function ACRESCIMODESCONTOITEM(pParams : String = '') : String;
    function VERIFICAESTADO(pParams : String = '') : String;
    function IMPRIMIRVINCULADO(pParams : String = '') : String;
    function ImprimirRelatorioGerencial(pParams : String = '') : String;
    function FechaRelatorioGerencial(pParams : String = '') : String;
    function FECHAVINCULADO(pParams : String = '') : String;
    function SUPRIMENTO(pParams : String = '') : String;
    function ABERTURADODIA(pParams : String = '') : String;
    function SANGRIA(pParams : String = '') : String;
    function INICIAMODOTEF(pParams : String = '') : String;
    function FINALIZAMODOTEF(pParams : String = '') : String;
    function abreGaveta(pParams : String = '') : String;
    function progHoraVerao(pParams : String = '') : String;
    function RELATORIOSINTEGRAMFD(pParams : String = '') : String;
    function GERARELATORIOSINTEGRAMFD(pParams : String = '') : String;
    function DOWNLOADMFD(pParams : String = '') : String;
    function DATAHORAIMPRESSORA(pParams : String = '') : String;
    function DATAMOVIMENTO(pParams : String = '') : String;
    function DATAMOVIMENTOULTIMAREDUCAO(pParams : String = '') : String;
    function ATIVADESATIVAGUILHOTINA(pParams : String = '') : String;
    function geraRegistrosCAT52MFD(pParams : String = '') : String;
    function abreRelatorioGerencial(pParams : String = '') : String;
    function verificaTermica(pParams : String = '') : String;
    function LeituraMemoriaFiscalDataMFD(pParams : String = '') : String;
    function LeituraMemoriaFiscalReducaoMFD(pParams : String = '') : String;
    function leMemoriaFiscalSerialReducaoMFD(pParams : String = '') : String;
    function leMemoriaFiscalSerialDataMFD(pParams : String = '') : String;
    function geraAtoCotep(pParams : String = '') : String;
  end;

implementation

uses
  cADMSVCO001,
  cActivate, cStatus, cFuncao, cXml, dModulo;

var
  gInHomologacaoAM : String;

//---------------------------------------------------------------
constructor T_ECFSVCO001.Create(AOwner: TComponent);
//---------------------------------------------------------------
begin
  inherited Create(AOwner);
  setEntidade('');
end;

//--------------------------------
destructor T_ECFSVCO001.Destroy;
//--------------------------------
begin
  inherited Destroy;
end;

//---------------------------------------------------------------
function T_ECFSVCO001.getParam(pParams : String = '') : String;
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
  putitem(xParamEmp, 'IN_HOMOLOGACAO_AM');
  putitem(xParamEmp, 'PADRAO_ECF');

  xParamEmp := T_ADMSVCO001.GetParamEmpresa(piCdEmpresa, xParamEmp);

  gInHomologacaoAM := itemXml('IN_HOMOLOGACAO_AM', xParamEmp);

end;

//---------------------------------------------------------------
function T_ECFSVCO001.setEntidade(pParams : String = '') : String;
//---------------------------------------------------------------
begin
  tFIS_ECF := GetEntidade('FIS_ECF');
end;

//-------------------------------------------------------------
function T_ECFSVCO001.espacoDireita(pParams : String) : String;
//-------------------------------------------------------------
const
  cDS_METHOD = 'ADICIONAL=Operação: T_ECFSVCO001.espacoDireita()';
var
  (* string vDsFormaPgto : IN / numeric vTam : IN / string vDsRetorno : OUT *)
  vCont, vTamFormaPgto : Real;
begin
  length vDsFormaPgto;
  vTamFormaPgto := gresult;
  vCont := 0;
  repeat
    vCont := vCont + 1;
    if (vCont <= vTamFormaPgto) then begin
      vDsRetorno := '' + vDsRetorno' + vDsFormaPgto[vCont, + ' + ' vCont]';
    end else begin
      vDsRetorno := '' + vDsRetorno + ' ';
    end;
  until(vCont := vTam);
  return(0); exit;
end;

//----------------------------------------------------
function T_ECFSVCO001.INIT(pParams : String) : String;
//----------------------------------------------------
const
  cDS_METHOD = 'ADICIONAL=Operação: T_ECFSVCO001.INIT()';
var
  viParams, voParams, vFlag : String;
  vPadraoECF, vCdEmpresa : Real;
begin
  if (itemXml('PADRAO_ECF', PARAM_GLB) <> '') then begin
    return(0); exit;
  end;

  viParams := '';

  vCdEmpresa := itemXmlF('CD_EMPRESA', PARAM_GLB);
  putitem(viParams,  'PADRAO_ECF');
  putitem(viParams,  'IN_HOMOLOGACAO_AM');
  xParamEmp := T_ADMSVCO001.GetParamEmpresa(piCdEmpresa, xParamEmp); (*vCdEmpresa,,,, *)
  gInHomologacaoAM := itemXmlB('IN_HOMOLOGACAO_AM', voParams);
  vPadraoECF := itemXml('PADRAO_ECF', voParams);
  putitemXml(PARAM_GLB, 'PADRAO_ECF', vPadraoECF);
  return(0); exit;
end;

//---------------------------------------------------------
function T_ECFSVCO001.ABREPORTA(pParams : String) : String;
//---------------------------------------------------------
const
  cDS_METHOD = 'ADICIONAL=Operação: T_ECFSVCO001.ABREPORTA()';
var
  vCdComponente : String;
  vStatus : Real;
begin
  vCdComponente := '';

  if (itemXml('PADRAO_ECF', PARAM_GLB) = <PADRAO_BEMATECH> ) or (itemXml('PADRAO_ECF', PARAM_GLB) = '') then begin
    vCdComponente := 'ECFSVCO002';
  end else if (itemXml('PADRAO_ECF', PARAM_GLB) = <PADRAO_AFRAC>) then begin
    vCdComponente := 'ECFSVCO005';
  end else if (itemXml('PADRAO_ECF', PARAM_GLB) = <PADRAO_YANCO>) then begin
    vCdComponente := 'ECFSVCO006';
  end else begin
  end;
  if (itemXml('PADRAO_ECF', PARAM_GLB) = <PADRAO_AFRAC>) then begin
    if (xStatus < 0) then begin
      Result := voParams;
      return(-1); exit;
    end;
  end else begin
  end;
  return(0); exit;
end;

//----------------------------------------------------------
function T_ECFSVCO001.FECHAPORTA(pParams : String) : String;
//----------------------------------------------------------
const
  cDS_METHOD = 'ADICIONAL=Operação: T_ECFSVCO001.FECHAPORTA()';
var
  vCdComponente : String;
  vStatus : Real;
begin
  vCdComponente := '';

  if (itemXml('PADRAO_ECF', PARAM_GLB) = <PADRAO_BEMATECH> ) or (itemXml('PADRAO_ECF', PARAM_GLB) = '') then begin
    vCdComponente := 'ECFSVCO002';
  end else if (itemXml('PADRAO_ECF', PARAM_GLB) = <PADRAO_AFRAC>) then begin
    vCdComponente := 'ECFSVCO005';
  end else if (itemXml('PADRAO_ECF', PARAM_GLB) = <PADRAO_YANCO>) then begin
    vCdComponente := 'ECFSVCO006';
  end else begin
  end;
  if (itemXml('PADRAO_ECF', PARAM_GLB) = <PADRAO_AFRAC>) then begin
    if (xStatus < 0) then begin
      Result := voParams;
      return(-1); exit;
    end;
  end else begin
  end;
  return(0); exit;
end;

//---------------------------------------------------------
function T_ECFSVCO001.ABRECUPOM(pParams : String) : String;
//---------------------------------------------------------
const
  cDS_METHOD = 'ADICIONAL=Operação: T_ECFSVCO001.ABRECUPOM()';
var
  vCdComponente : String;
  vStatus : Real;
  viParams, voParams, vDsSerie : String;
begin
  vCdComponente := '';
  message/hint 'Preparando impressão de cupom fiscal...';
  if (itemXml('PADRAO_ECF', PARAM_GLB) = <PADRAO_BEMATECH> ) or (itemXml('PADRAO_ECF', PARAM_GLB) = '') then begin
    vCdComponente := 'ECFSVCO002';
  end else if (itemXml('PADRAO_ECF', PARAM_GLB) = <PADRAO_AFRAC>) then begin
    vCdComponente := 'ECFSVCO005';
  end else if (itemXml('PADRAO_ECF', PARAM_GLB) = <PADRAO_YANCO>) then begin
    vCdComponente := 'ECFSVCO006';
  end else if (itemXml('PADRAO_ECF', PARAM_GLB) = <PADRAO_LOCAL>) then begin
    vCdComponente := 'ECFSVCO011';
  end else if (itemXml('PADRAO_ECF', PARAM_GLB) = <PADRAO_LOCALIMPFIM>) then begin
    vCdComponente := 'ECFSVCO011';
  end else begin
  end;
  if (itemXml('PADRAO_ECF', PARAM_GLB) = <PADRAO_BEMATECH> ) or (itemXml('PADRAO_ECF', PARAM_GLB) = '') then begin
    viParams := '';
    if (gInHomologacaoAM = True) then begin
      putitemXml(viParams, 'NM_FUNCAO', <ECF_NUMERO_SERIE_C>);
    end else begin
      putitemXml(viParams, 'NM_FUNCAO', <ECF_NUMERO_SERIE>);
    end;
    voParams := activateCmp('' + FloatToStr(vCdComponente',) + ' 'LeInformacaoImpressora', viParams); (*,,, *)
    if (xStatus < 0) then begin
      Result := voParams;
      return(-1); exit;
    end;
    vDsSerie := itemXmlF('NR_SERIE', voParams);
    clear_e(tFIS_ECF);
    putitem_e(tFIS_ECF, 'CD_SERIEFAB', vDsSerie);
    retrieve_e(tFIS_ECF);
    if (xStatus < 0) then begin
      Result := SetStatus(STS_ERROR, 'GEN0001', 'ECF inválida para o sistema - contate suporte!', '');
      return(-50);
    end;
  end;
  if (xStatus < 0) then begin
    Result := voParams;
    return(-1); exit;
  end;
  return(0); exit;
end;

//---------------------------------------------------------
function T_ECFSVCO001.VendEITEM(pParams : String) : String;
//---------------------------------------------------------
const
  cDS_METHOD = 'ADICIONAL=Operação: T_ECFSVCO001.VendEITEM()';
var
  vCdComponente : String;
  vStatus : Real;
  viParams, voParams, vDsSerie : String;
  vInConcomitante : Boolean;
begin
  vInConcomitante := itemXmlB('IN_CONCOMITANTE', pParams);

  vCdComponente := '';

  if (itemXml('PADRAO_ECF', PARAM_GLB) = <PADRAO_BEMATECH> ) or (itemXml('PADRAO_ECF', PARAM_GLB) = '') then begin
    vCdComponente := 'ECFSVCO002';
  end else if (itemXml('PADRAO_ECF', PARAM_GLB) = <PADRAO_AFRAC>) then begin
    vCdComponente := 'ECFSVCO005';
  end else if (itemXml('PADRAO_ECF', PARAM_GLB) = <PADRAO_YANCO>) then begin
    vCdComponente := 'ECFSVCO006';
  end else if (itemXml('PADRAO_ECF', PARAM_GLB) = <PADRAO_LOCAL>) then begin
    vCdComponente := 'ECFSVCO011';
  end else if (itemXml('PADRAO_ECF', PARAM_GLB) = <PADRAO_LOCALIMPFIM>) then begin
    vCdComponente := 'ECFSVCO011';
  end else begin
  end;
  if (itemXml('PADRAO_ECF', PARAM_GLB) = <PADRAO_BEMATECH> ) or (itemXml('PADRAO_ECF', PARAM_GLB) = '') then begin
    viParams := '';
    if (gInHomologacaoAM = True) then begin
      putitemXml(viParams, 'NM_FUNCAO', <ECF_NUMERO_SERIE_C>);
    end else begin
      putitemXml(viParams, 'NM_FUNCAO', <ECF_NUMERO_SERIE>);
    end;
    voParams := activateCmp('' + FloatToStr(vCdComponente',) + ' 'LeInformacaoImpressora', viParams); (*,,, *)
    if (xStatus < 0) then begin
      Result := voParams;
      return(-1); exit;
    end;
    vDsSerie := itemXmlF('NR_SERIE', voParams);
    clear_e(tFIS_ECF);
    putitem_e(tFIS_ECF, 'CD_SERIEFAB', vDsSerie);
    retrieve_e(tFIS_ECF);
    if (xStatus < 0) then begin
      Result := SetStatus(STS_ERROR, 'GEN0001', 'ECF inválida para o sistema - contate suporte!', '');
      return(-50);
    end;
  end;

  putitemXml(pParams, 'IN_CONCOMITANTE', vInConcomitante);
  if (xStatus < 0) then begin
    Result := voParams;
    return(-1); exit;
  end;

  return(0); exit;
end;

//----------------------------------------------------------
function T_ECFSVCO001.FECHACUPOM(pParams : String) : String;
//----------------------------------------------------------
const
  cDS_METHOD = 'ADICIONAL=Operação: T_ECFSVCO001.FECHACUPOM()';
var
  vCdComponente : String;
  vStatus : Real;
  viParams, voParams, vDsSerie : String;
begin
  vCdComponente := '';

  if (itemXml('PADRAO_ECF', PARAM_GLB) = <PADRAO_BEMATECH> ) or (itemXml('PADRAO_ECF', PARAM_GLB) = '') then begin
    vCdComponente := 'ECFSVCO002';
  end else if (itemXml('PADRAO_ECF', PARAM_GLB) = <PADRAO_AFRAC>) then begin
    vCdComponente := 'ECFSVCO005';
  end else if (itemXml('PADRAO_ECF', PARAM_GLB) = <PADRAO_YANCO>) then begin
    vCdComponente := 'ECFSVCO006';
  end else if (itemXml('PADRAO_ECF', PARAM_GLB) = <PADRAO_LOCAL>) then begin
    vCdComponente := 'ECFSVCO011';
  end else if (itemXml('PADRAO_ECF', PARAM_GLB) = <PADRAO_LOCALIMPFIM>) then begin
    vCdComponente := 'ECFSVCO011';
  end else begin
  end;
  if (itemXml('PADRAO_ECF', PARAM_GLB) = <PADRAO_BEMATECH> ) or (itemXml('PADRAO_ECF', PARAM_GLB) = '') then begin
    viParams := '';
    if (gInHomologacaoAM = True) then begin
      putitemXml(viParams, 'NM_FUNCAO', <ECF_NUMERO_SERIE_C>);
    end else begin
      putitemXml(viParams, 'NM_FUNCAO', <ECF_NUMERO_SERIE>);
    end;
    voParams := activateCmp('' + FloatToStr(vCdComponente',) + ' 'LeInformacaoImpressora', viParams); (*,,, *)
    if (xStatus < 0) then begin
      Result := voParams;
      return(-1); exit;
    end;
    vDsSerie := itemXmlF('NR_SERIE', voParams);
    clear_e(tFIS_ECF);
    putitem_e(tFIS_ECF, 'CD_SERIEFAB', vDsSerie);
    retrieve_e(tFIS_ECF);
    if (xStatus < 0) then begin
      Result := SetStatus(STS_ERROR, 'GEN0001', 'ECF inválida para o sistema - contate suporte!', '');
      return(-50);
    end;
  end;
  if (xStatus < 0) then begin
    Result := voParams;
    return(-1); exit;
  end;
  message/hint 'Finalizando impressão de cupom fiscal...';
  return(0); exit;
end;

//------------------------------------------------------------
function T_ECFSVCO001.CANCELACUPOM(pParams : String) : String;
//------------------------------------------------------------
const
  cDS_METHOD = 'ADICIONAL=Operação: T_ECFSVCO001.CANCELACUPOM()';
var
  vCdComponente : String;
  vStatus : Real;
  viParams, voParams, vDsSerie : String;
begin
  vCdComponente := '';

  if (itemXml('PADRAO_ECF', PARAM_GLB) = <PADRAO_BEMATECH> ) or (itemXml('PADRAO_ECF', PARAM_GLB) = '') then begin
    vCdComponente := 'ECFSVCO002';
  end else if (itemXml('PADRAO_ECF', PARAM_GLB) = <PADRAO_AFRAC>) then begin
    vCdComponente := 'ECFSVCO005';
  end else if (itemXml('PADRAO_ECF', PARAM_GLB) = <PADRAO_YANCO>) then begin
    vCdComponente := 'ECFSVCO006';
  end else if (itemXml('PADRAO_ECF', PARAM_GLB) = <PADRAO_LOCAL>) then begin
    vCdComponente := 'ECFSVCO011';
  end else if (itemXml('PADRAO_ECF', PARAM_GLB) = <PADRAO_LOCALIMPFIM>) then begin
    vCdComponente := 'ECFSVCO011';
  end else begin
  end;
  if (itemXml('PADRAO_ECF', PARAM_GLB) = <PADRAO_BEMATECH> ) or (itemXml('PADRAO_ECF', PARAM_GLB) = '') then begin
    viParams := '';
    if (gInHomologacaoAM = True) then begin
      putitemXml(viParams, 'NM_FUNCAO', <ECF_NUMERO_SERIE_C>);
    end else begin
      putitemXml(viParams, 'NM_FUNCAO', <ECF_NUMERO_SERIE>);
    end;
    voParams := activateCmp('' + FloatToStr(vCdComponente',) + ' 'LeInformacaoImpressora', viParams); (*,,, *)
    if (xStatus < 0) then begin
      Result := voParams;
      return(-1); exit;
    end;
    vDsSerie := itemXmlF('NR_SERIE', voParams);
    clear_e(tFIS_ECF);
    putitem_e(tFIS_ECF, 'CD_SERIEFAB', vDsSerie);
    retrieve_e(tFIS_ECF);
    if (xStatus < 0) then begin
      Result := SetStatus(STS_ERROR, 'GEN0001', 'ECF inválida para o sistema - contate suporte!', '');
      return(-50);
    end;
  end;
  if (xStatus < 0) then begin
    Result := voParams;
    return(-1); exit;
  end;
  return(0); exit;
end;

//-----------------------------------------------------------
function T_ECFSVCO001.CANCELAITEM(pParams : String) : String;
//-----------------------------------------------------------
const
  cDS_METHOD = 'ADICIONAL=Operação: T_ECFSVCO001.CANCELAITEM()';
var
  vCdComponente : String;
  vStatus : Real;
  viParams, voParams, vDsSerie : String;
begin
  vCdComponente := '';

  if (itemXml('PADRAO_ECF', PARAM_GLB) = <PADRAO_BEMATECH> ) or (itemXml('PADRAO_ECF', PARAM_GLB) = '') then begin
    vCdComponente := 'ECFSVCO002';
  end else if (itemXml('PADRAO_ECF', PARAM_GLB) = <PADRAO_AFRAC>) then begin
    vCdComponente := 'ECFSVCO005';
  end else if (itemXml('PADRAO_ECF', PARAM_GLB) = <PADRAO_YANCO>) then begin
    vCdComponente := 'ECFSVCO006';
  end else if (itemXml('PADRAO_ECF', PARAM_GLB) = <PADRAO_LOCAL>) then begin
    vCdComponente := 'ECFSVCO011';
  end else if (itemXml('PADRAO_ECF', PARAM_GLB) = <PADRAO_LOCALIMPFIM>) then begin
    vCdComponente := 'ECFSVCO011';
  end else begin
  end;
  if (itemXml('PADRAO_ECF', PARAM_GLB) = <PADRAO_BEMATECH> ) or (itemXml('PADRAO_ECF', PARAM_GLB) = '') then begin
    viParams := '';
    if (gInHomologacaoAM = True) then begin
      putitemXml(viParams, 'NM_FUNCAO', <ECF_NUMERO_SERIE_C>);
    end else begin
      putitemXml(viParams, 'NM_FUNCAO', <ECF_NUMERO_SERIE>);
    end;
    voParams := activateCmp('' + FloatToStr(vCdComponente',) + ' 'LeInformacaoImpressora', viParams); (*,,, *)
    if (xStatus < 0) then begin
      Result := voParams;
      return(-1); exit;
    end;
    vDsSerie := itemXmlF('NR_SERIE', voParams);
    clear_e(tFIS_ECF);
    putitem_e(tFIS_ECF, 'CD_SERIEFAB', vDsSerie);
    retrieve_e(tFIS_ECF);
    if (xStatus < 0) then begin
      Result := SetStatus(STS_ERROR, 'GEN0001', 'ECF inválida para o sistema - contate suporte!', '');
      return(-50);
    end;
  end;
  if (xStatus < 0) then begin
    Result := voParams;
    return(-1); exit;
  end;
  return(0); exit;
end;

//----------------------------------------------------------------------
function T_ECFSVCO001.ACRESCIMODESCONTOCUPOM(pParams : String) : String;
//----------------------------------------------------------------------
const
  cDS_METHOD = 'ADICIONAL=Operação: T_ECFSVCO001.ACRESCIMODESCONTOCUPOM()';
var
  vCdComponente : String;
  vStatus : Real;
  viParams, voParams, vDsSerie : String;
  vInConcomitante : Boolean;
begin
  vInConcomitante := itemXmlB('IN_CONCOMITANTE', pParams);

  vCdComponente := '';

  if (itemXml('PADRAO_ECF', PARAM_GLB) = <PADRAO_BEMATECH> ) or (itemXml('PADRAO_ECF', PARAM_GLB) = '') then begin
    vCdComponente := 'ECFSVCO002';
  end else if (itemXml('PADRAO_ECF', PARAM_GLB) = <PADRAO_AFRAC>) then begin
    vCdComponente := 'ECFSVCO005';
  end else if (itemXml('PADRAO_ECF', PARAM_GLB) = <PADRAO_YANCO>) then begin
    vCdComponente := 'ECFSVCO006';
  end else if (itemXml('PADRAO_ECF', PARAM_GLB) = <PADRAO_LOCAL>) then begin
    vCdComponente := 'ECFSVCO011';
  end else if (itemXml('PADRAO_ECF', PARAM_GLB) = <PADRAO_LOCALIMPFIM>) then begin
    vCdComponente := 'ECFSVCO011';
  end else begin
  end;
  if (itemXml('PADRAO_ECF', PARAM_GLB) = <PADRAO_BEMATECH> ) or (itemXml('PADRAO_ECF', PARAM_GLB) = '') then begin
    viParams := '';
    if (gInHomologacaoAM = True) then begin
      putitemXml(viParams, 'NM_FUNCAO', <ECF_NUMERO_SERIE_C>);
    end else begin
      putitemXml(viParams, 'NM_FUNCAO', <ECF_NUMERO_SERIE>);
    end;
    voParams := activateCmp('' + FloatToStr(vCdComponente',) + ' 'LeInformacaoImpressora', viParams); (*,,, *)
    if (xStatus < 0) then begin
      Result := voParams;
      return(-1); exit;
    end;
    vDsSerie := itemXmlF('NR_SERIE', voParams);
    clear_e(tFIS_ECF);
    putitem_e(tFIS_ECF, 'CD_SERIEFAB', vDsSerie);
    retrieve_e(tFIS_ECF);
    if (xStatus < 0) then begin
      Result := SetStatus(STS_ERROR, 'GEN0001', 'ECF inválida para o sistema - contate suporte!', '');
      return(-50);
    end;
  end;

  putitemXml(pParams, 'IN_CONCOMITANTE', vInConcomitante);
  if (xStatus < 0) then begin
    Result := voParams;
    return(-1); exit;
  end;
  return(0); exit;
end;

//--------------------------------------------------------------
function T_ECFSVCO001.FORMAPAGAMENTO(pParams : String) : String;
//--------------------------------------------------------------
const
  cDS_METHOD = 'ADICIONAL=Operação: T_ECFSVCO001.FORMAPAGAMENTO()';
var
  vCdComponente : String;
  vStatus : Real;
  viParams, voParams, vDsSerie : String;
begin
  vCdComponente := '';

  if (itemXml('PADRAO_ECF', PARAM_GLB) = <PADRAO_BEMATECH> ) or (itemXml('PADRAO_ECF', PARAM_GLB) = '') then begin
    vCdComponente := 'ECFSVCO002';
  end else if (itemXml('PADRAO_ECF', PARAM_GLB) = <PADRAO_AFRAC>) then begin
    vCdComponente := 'ECFSVCO005';
  end else if (itemXml('PADRAO_ECF', PARAM_GLB) = <PADRAO_YANCO>) then begin
    vCdComponente := 'ECFSVCO006';
  end else if (itemXml('PADRAO_ECF', PARAM_GLB) = <PADRAO_LOCAL>) then begin
    vCdComponente := 'ECFSVCO011';
  end else if (itemXml('PADRAO_ECF', PARAM_GLB) = <PADRAO_LOCALIMPFIM>) then begin
    vCdComponente := 'ECFSVCO011';
  end else begin
  end;
  if (itemXml('PADRAO_ECF', PARAM_GLB) = <PADRAO_BEMATECH> ) or (itemXml('PADRAO_ECF', PARAM_GLB) = '') then begin
    viParams := '';
    if (gInHomologacaoAM = True) then begin
      putitemXml(viParams, 'NM_FUNCAO', <ECF_NUMERO_SERIE_C>);
    end else begin
      putitemXml(viParams, 'NM_FUNCAO', <ECF_NUMERO_SERIE>);
    end;
    voParams := activateCmp('' + FloatToStr(vCdComponente',) + ' 'LeInformacaoImpressora', viParams); (*,,, *)
    if (xStatus < 0) then begin
      Result := voParams;
      return(-1); exit;
    end;
    vDsSerie := itemXmlF('NR_SERIE', voParams);
    clear_e(tFIS_ECF);
    putitem_e(tFIS_ECF, 'CD_SERIEFAB', vDsSerie);
    retrieve_e(tFIS_ECF);
    if (xStatus < 0) then begin
      Result := SetStatus(STS_ERROR, 'GEN0001', 'ECF inválida para o sistema - contate suporte!', '');
      return(-50);
    end;
  end;
  if (xStatus < 0) then begin
    Result := voParams;
    return(-1); exit;
  end;
  return(0); exit;
end;

//--------------------------------------------------------
function T_ECFSVCO001.REDUCAOZ(pParams : String) : String;
//--------------------------------------------------------
const
  cDS_METHOD = 'ADICIONAL=Operação: T_ECFSVCO001.REDUCAOZ()';
var
  vCdComponente : String;
  vStatus : Real;
  viParams, voParams, vDsSerie : String;
begin
  vCdComponente := '';

  if (itemXml('PADRAO_ECF', PARAM_GLB) = <PADRAO_BEMATECH> ) or (itemXml('PADRAO_ECF', PARAM_GLB) = '') then begin
    vCdComponente := 'ECFSVCO002';
  end else if (itemXml('PADRAO_ECF', PARAM_GLB) = <PADRAO_AFRAC>) then begin
    vCdComponente := 'ECFSVCO005';
  end else if (itemXml('PADRAO_ECF', PARAM_GLB) = <PADRAO_YANCO>) then begin
    vCdComponente := 'ECFSVCO006';
  end else if (itemXml('PADRAO_ECF', PARAM_GLB) = <PADRAO_LOCAL>) then begin
    vCdComponente := 'ECFSVCO011';
  end else if (itemXml('PADRAO_ECF', PARAM_GLB) = <PADRAO_LOCALIMPFIM>) then begin
    vCdComponente := 'ECFSVCO011';
  end else begin
  end;
  if (itemXml('PADRAO_ECF', PARAM_GLB) = <PADRAO_BEMATECH> ) or (itemXml('PADRAO_ECF', PARAM_GLB) = '') then begin
    viParams := '';
    if (gInHomologacaoAM = True) then begin
      putitemXml(viParams, 'NM_FUNCAO', <ECF_NUMERO_SERIE_C>);
    end else begin
      putitemXml(viParams, 'NM_FUNCAO', <ECF_NUMERO_SERIE>);
    end;
    voParams := activateCmp('' + FloatToStr(vCdComponente',) + ' 'LeInformacaoImpressora', viParams); (*,,, *)
    if (xStatus < 0) then begin
      Result := voParams;
      return(-1); exit;
    end;
    vDsSerie := itemXmlF('NR_SERIE', voParams);
    clear_e(tFIS_ECF);
    putitem_e(tFIS_ECF, 'CD_SERIEFAB', vDsSerie);
    retrieve_e(tFIS_ECF);
    if (xStatus < 0) then begin
      Result := SetStatus(STS_ERROR, 'GEN0001', 'ECF inválida para o sistema - contate suporte!', '');
      return(-50);
    end;
  end;
  if (xStatus < 0) then begin
    Result := voParams;
    return(-1); exit;
  end;
  return(0); exit;
end;

//--------------------------------------------------------------
function T_ECFSVCO001.REGISTROTIPO60(pParams : String) : String;
//--------------------------------------------------------------
const
  cDS_METHOD = 'ADICIONAL=Operação: T_ECFSVCO001.REGISTROTIPO60()';
var
  vCdComponente : String;
  vStatus : Real;
  viParams, voParams, vDsSerie : String;
begin
  vCdComponente := '';

  if (itemXml('PADRAO_ECF', PARAM_GLB) = <PADRAO_BEMATECH> ) or (itemXml('PADRAO_ECF', PARAM_GLB) = '') then begin
    vCdComponente := 'ECFSVCO002';
  end else if (itemXml('PADRAO_ECF', PARAM_GLB) = <PADRAO_AFRAC>) then begin
    vCdComponente := 'ECFSVCO005';
  end else if (itemXml('PADRAO_ECF', PARAM_GLB) = <PADRAO_YANCO>) then begin
    vCdComponente := 'ECFSVCO006';
  end else if (itemXml('PADRAO_ECF', PARAM_GLB) = <PADRAO_LOCAL>) then begin
    vCdComponente := 'ECFSVCO011';
  end else if (itemXml('PADRAO_ECF', PARAM_GLB) = <PADRAO_LOCALIMPFIM>) then begin
    vCdComponente := 'ECFSVCO011';
  end else begin
  end;
  if (itemXml('PADRAO_ECF', PARAM_GLB) = <PADRAO_BEMATECH> ) or (itemXml('PADRAO_ECF', PARAM_GLB) = '') then begin
    viParams := '';
    if (gInHomologacaoAM = True) then begin
      putitemXml(viParams, 'NM_FUNCAO', <ECF_NUMERO_SERIE_C>);
    end else begin
      putitemXml(viParams, 'NM_FUNCAO', <ECF_NUMERO_SERIE>);
    end;
    voParams := activateCmp('' + FloatToStr(vCdComponente',) + ' 'LeInformacaoImpressora', viParams); (*,,, *)
    if (xStatus < 0) then begin
      Result := voParams;
      return(-1); exit;
    end;
    vDsSerie := itemXmlF('NR_SERIE', voParams);
    clear_e(tFIS_ECF);
    putitem_e(tFIS_ECF, 'CD_SERIEFAB', vDsSerie);
    retrieve_e(tFIS_ECF);
    if (xStatus < 0) then begin
      Result := SetStatus(STS_ERROR, 'GEN0001', 'ECF inválida para o sistema - contate suporte!', '');
      return(-50);
    end;
  end;
  if (xStatus < 0) then begin
    Result := voParams;
    return(-1); exit;
  end;
  return(0); exit;
end;

//--------------------------------------------------------
function T_ECFSVCO001.LEITURAX(pParams : String) : String;
//--------------------------------------------------------
const
  cDS_METHOD = 'ADICIONAL=Operação: T_ECFSVCO001.LEITURAX()';
var
  vCdComponente : String;
  vStatus : Real;
  viParams, voParams, vDsSerie : String;
begin
  vCdComponente := '';

  if (itemXml('PADRAO_ECF', PARAM_GLB) = <PADRAO_BEMATECH> ) or (itemXml('PADRAO_ECF', PARAM_GLB) = '') then begin
    vCdComponente := 'ECFSVCO002';
  end else if (itemXml('PADRAO_ECF', PARAM_GLB) = <PADRAO_AFRAC>) then begin
    vCdComponente := 'ECFSVCO005';
  end else if (itemXml('PADRAO_ECF', PARAM_GLB) = <PADRAO_YANCO>) then begin
    vCdComponente := 'ECFSVCO006';
  end else if (itemXml('PADRAO_ECF', PARAM_GLB) = <PADRAO_LOCAL>) then begin
    vCdComponente := 'ECFSVCO011';
  end else if (itemXml('PADRAO_ECF', PARAM_GLB) = <PADRAO_LOCALIMPFIM>) then begin
    vCdComponente := 'ECFSVCO011';
  end else begin
  end;
  if (itemXml('PADRAO_ECF', PARAM_GLB) = <PADRAO_BEMATECH> ) or (itemXml('PADRAO_ECF', PARAM_GLB) = '') then begin
    viParams := '';
    if (gInHomologacaoAM = True) then begin
      putitemXml(viParams, 'NM_FUNCAO', <ECF_NUMERO_SERIE_C>);
    end else begin
      putitemXml(viParams, 'NM_FUNCAO', <ECF_NUMERO_SERIE>);
    end;
    voParams := activateCmp('' + FloatToStr(vCdComponente',) + ' 'LeInformacaoImpressora', viParams); (*,,, *)
    if (xStatus < 0) then begin
      Result := voParams;
      return(-1); exit;
    end;
    vDsSerie := itemXmlF('NR_SERIE', voParams);
    clear_e(tFIS_ECF);
    putitem_e(tFIS_ECF, 'CD_SERIEFAB', vDsSerie);
    retrieve_e(tFIS_ECF);
    if (xStatus < 0) then begin
      Result := SetStatus(STS_ERROR, 'GEN0001', 'ECF inválida para o sistema - contate suporte!', '');
      return(-50);
    end;
  end;
  if (xStatus < 0) then begin
    Result := voParams;
    return(-1); exit;
  end;
  return(0); exit;
end;

//---------------------------------------------------------------
function T_ECFSVCO001.FECHAMENTODODIA(pParams : String) : String;
//---------------------------------------------------------------
const
  cDS_METHOD = 'ADICIONAL=Operação: T_ECFSVCO001.FECHAMENTODODIA()';
var
  vCdComponente : String;
  vStatus : Real;
  viParams, voParams, vDsSerie : String;
begin
  vCdComponente := '';

  if (itemXml('PADRAO_ECF', PARAM_GLB) = <PADRAO_BEMATECH> ) or (itemXml('PADRAO_ECF', PARAM_GLB) = '') then begin
    vCdComponente := 'ECFSVCO002';
  end else if (itemXml('PADRAO_ECF', PARAM_GLB) = <PADRAO_AFRAC>) then begin
    vCdComponente := 'ECFSVCO005';
  end else if (itemXml('PADRAO_ECF', PARAM_GLB) = <PADRAO_YANCO>) then begin
    vCdComponente := 'ECFSVCO006';
  end else begin
  end;
  if (itemXml('PADRAO_ECF', PARAM_GLB) = <PADRAO_BEMATECH> ) or (itemXml('PADRAO_ECF', PARAM_GLB) = '') then begin
    viParams := '';
    if (gInHomologacaoAM = True) then begin
      putitemXml(viParams, 'NM_FUNCAO', <ECF_NUMERO_SERIE_C>);
    end else begin
      putitemXml(viParams, 'NM_FUNCAO', <ECF_NUMERO_SERIE>);
    end;
    voParams := activateCmp('' + FloatToStr(vCdComponente',) + ' 'LeInformacaoImpressora', viParams); (*,,, *)
    if (xStatus < 0) then begin
      Result := voParams;
      return(-1); exit;
    end;
    vDsSerie := itemXmlF('NR_SERIE', voParams);
    clear_e(tFIS_ECF);
    putitem_e(tFIS_ECF, 'CD_SERIEFAB', vDsSerie);
    retrieve_e(tFIS_ECF);
    if (xStatus < 0) then begin
      Result := SetStatus(STS_ERROR, 'GEN0001', 'ECF inválida para o sistema - contate suporte!', '');
      return(-50);
    end;
  end;
  if (xStatus < 0) then begin
    Result := voParams;
    return(-1); exit;
  end;
  return(0); exit;
end;

//------------------------------------------------------------------------
function T_ECFSVCO001.RELATORIOTIPO60ANALITICO(pParams : String) : String;
//------------------------------------------------------------------------
const
  cDS_METHOD = 'ADICIONAL=Operação: T_ECFSVCO001.RELATORIOTIPO60ANALITICO()';
var
  vCdComponente : String;
  vStatus : Real;
  viParams, voParams, vDsSerie : String;
begin
  vCdComponente := '';

  if (itemXml('PADRAO_ECF', PARAM_GLB) = <PADRAO_BEMATECH> ) or (itemXml('PADRAO_ECF', PARAM_GLB) = '') then begin
    vCdComponente := 'ECFSVCO002';
  end else if (itemXml('PADRAO_ECF', PARAM_GLB) = <PADRAO_AFRAC>) then begin
    vCdComponente := 'ECFSVCO005';
  end else if (itemXml('PADRAO_ECF', PARAM_GLB) = <PADRAO_YANCO>) then begin
    vCdComponente := 'ECFSVCO006';
  end else begin
  end;
  if (itemXml('PADRAO_ECF', PARAM_GLB) = <PADRAO_BEMATECH> ) or (itemXml('PADRAO_ECF', PARAM_GLB) = '') then begin
    viParams := '';
    if (gInHomologacaoAM = True) then begin
      putitemXml(viParams, 'NM_FUNCAO', <ECF_NUMERO_SERIE_C>);
    end else begin
      putitemXml(viParams, 'NM_FUNCAO', <ECF_NUMERO_SERIE>);
    end;
    voParams := activateCmp('' + FloatToStr(vCdComponente',) + ' 'LeInformacaoImpressora', viParams); (*,,, *)
    if (xStatus < 0) then begin
      Result := voParams;
      return(-1); exit;
    end;
    vDsSerie := itemXmlF('NR_SERIE', voParams);
    clear_e(tFIS_ECF);
    putitem_e(tFIS_ECF, 'CD_SERIEFAB', vDsSerie);
    retrieve_e(tFIS_ECF);
    if (xStatus < 0) then begin
      Result := SetStatus(STS_ERROR, 'GEN0001', 'ECF inválida para o sistema - contate suporte!', '');
      return(-50);
    end;
  end;
  if (xStatus < 0) then begin
    Result := voParams;
    return(-1); exit;
  end;
  return(0); exit;
end;

//---------------------------------------------------------------------
function T_ECFSVCO001.RELATORIOTIPO60MESTRE(pParams : String) : String;
//---------------------------------------------------------------------
const
  cDS_METHOD = 'ADICIONAL=Operação: T_ECFSVCO001.RELATORIOTIPO60MESTRE()';
var
  vCdComponente : String;
  vStatus : Real;
  viParams, voParams, vDsSerie : String;
begin
  vCdComponente := '';

  if (itemXml('PADRAO_ECF', PARAM_GLB) = <PADRAO_BEMATECH> ) or (itemXml('PADRAO_ECF', PARAM_GLB) = '') then begin
    vCdComponente := 'ECFSVCO002';
  end else if (itemXml('PADRAO_ECF', PARAM_GLB) = <PADRAO_AFRAC>) then begin
    vCdComponente := 'ECFSVCO005';
  end else if (itemXml('PADRAO_ECF', PARAM_GLB) = <PADRAO_YANCO>) then begin
    vCdComponente := 'ECFSVCO006';
  end else if (itemXml('PADRAO_ECF', PARAM_GLB) = <PADRAO_LOCAL>) then begin
    vCdComponente := 'ECFSVCO011';
  end else if (itemXml('PADRAO_ECF', PARAM_GLB) = <PADRAO_LOCALIMPFIM>) then begin
    vCdComponente := 'ECFSVCO011';
  end else begin
  end;
  if (itemXml('PADRAO_ECF', PARAM_GLB) = <PADRAO_BEMATECH> ) or (itemXml('PADRAO_ECF', PARAM_GLB) = '') then begin
    viParams := '';
    if (gInHomologacaoAM = True) then begin
      putitemXml(viParams, 'NM_FUNCAO', <ECF_NUMERO_SERIE_C>);
    end else begin
      putitemXml(viParams, 'NM_FUNCAO', <ECF_NUMERO_SERIE>);
    end;
    voParams := activateCmp('' + FloatToStr(vCdComponente',) + ' 'LeInformacaoImpressora', viParams); (*,,, *)
    if (xStatus < 0) then begin
      Result := voParams;
      return(-1); exit;
    end;
    vDsSerie := itemXmlF('NR_SERIE', voParams);
    clear_e(tFIS_ECF);
    putitem_e(tFIS_ECF, 'CD_SERIEFAB', vDsSerie);
    retrieve_e(tFIS_ECF);
    if (xStatus < 0) then begin
      Result := SetStatus(STS_ERROR, 'GEN0001', 'ECF inválida para o sistema - contate suporte!', '');
      return(-50);
    end;
  end;
  if (xStatus < 0) then begin
    Result := voParams;
    return(-1); exit;
  end;
  return(0); exit;
end;

//---------------------------------------------------------------------------
function T_ECFSVCO001.LEITURAMEMORIAFISCALREDUCAO(pParams : String) : String;
//---------------------------------------------------------------------------
const
  cDS_METHOD = 'ADICIONAL=Operação: T_ECFSVCO001.LEITURAMEMORIAFISCALREDUCAO()';
var
  vCdComponente : String;
  vStatus : Real;
  viParams, voParams, vDsSerie : String;
begin
  vCdComponente := '';

  if (itemXml('PADRAO_ECF', PARAM_GLB) = <PADRAO_BEMATECH> ) or (itemXml('PADRAO_ECF', PARAM_GLB) = '') then begin
    vCdComponente := 'ECFSVCO002';
  end else if (itemXml('PADRAO_ECF', PARAM_GLB) = <PADRAO_AFRAC>) then begin
    vCdComponente := 'ECFSVCO005';
  end else if (itemXml('PADRAO_ECF', PARAM_GLB) = <PADRAO_YANCO>) then begin
    vCdComponente := 'ECFSVCO006';
  end else if (itemXml('PADRAO_ECF', PARAM_GLB) = <PADRAO_LOCAL>) then begin
    vCdComponente := 'ECFSVCO011';
  end else if (itemXml('PADRAO_ECF', PARAM_GLB) = <PADRAO_LOCALIMPFIM>) then begin
    vCdComponente := 'ECFSVCO011';
  end else begin
  end;
  if (itemXml('PADRAO_ECF', PARAM_GLB) = <PADRAO_BEMATECH> ) or (itemXml('PADRAO_ECF', PARAM_GLB) = '') then begin
    viParams := '';
    if (gInHomologacaoAM = True) then begin
      putitemXml(viParams, 'NM_FUNCAO', <ECF_NUMERO_SERIE_C>);
    end else begin
      putitemXml(viParams, 'NM_FUNCAO', <ECF_NUMERO_SERIE>);
    end;
    voParams := activateCmp('' + FloatToStr(vCdComponente',) + ' 'LeInformacaoImpressora', viParams); (*,,, *)
    if (xStatus < 0) then begin
      Result := voParams;
      return(-1); exit;
    end;
    vDsSerie := itemXmlF('NR_SERIE', voParams);
    clear_e(tFIS_ECF);
    putitem_e(tFIS_ECF, 'CD_SERIEFAB', vDsSerie);
    retrieve_e(tFIS_ECF);
    if (xStatus < 0) then begin
      Result := SetStatus(STS_ERROR, 'GEN0001', 'ECF inválida para o sistema - contate suporte!', '');
      return(-50);
    end;
  end;
  if (xStatus < 0) then begin
    Result := voParams;
    return(-1); exit;
  end;
  return(0); exit;
end;

//-----------------------------------------------------------------------------
function T_ECFSVCO001.LEITURAMEMORIAFISCALSERIALRED(pParams : String) : String;
//-----------------------------------------------------------------------------
const
  cDS_METHOD = 'ADICIONAL=Operação: T_ECFSVCO001.LEITURAMEMORIAFISCALSERIALRED()';
var
  vCdComponente : String;
  vStatus : Real;
  viParams, voParams, vDsSerie : String;
begin
  vCdComponente := '';

  if (itemXml('PADRAO_ECF', PARAM_GLB) = <PADRAO_BEMATECH> ) or (itemXml('PADRAO_ECF', PARAM_GLB) = '') then begin
    vCdComponente := 'ECFSVCO002';
  end else if (itemXml('PADRAO_ECF', PARAM_GLB) = <PADRAO_AFRAC>) then begin
    vCdComponente := 'ECFSVCO005';
  end else if (itemXml('PADRAO_ECF', PARAM_GLB) = <PADRAO_YANCO>) then begin
    vCdComponente := 'ECFSVCO006';
  end else if (itemXml('PADRAO_ECF', PARAM_GLB) = <PADRAO_LOCAL>) then begin
    vCdComponente := 'ECFSVCO011';
  end else if (itemXml('PADRAO_ECF', PARAM_GLB) = <PADRAO_LOCALIMPFIM>) then begin
    vCdComponente := 'ECFSVCO011';
  end else begin
  end;
  if (itemXml('PADRAO_ECF', PARAM_GLB) = <PADRAO_BEMATECH> ) or (itemXml('PADRAO_ECF', PARAM_GLB) = '') then begin
    viParams := '';
    if (gInHomologacaoAM = True) then begin
      putitemXml(viParams, 'NM_FUNCAO', <ECF_NUMERO_SERIE_C>);
    end else begin
      putitemXml(viParams, 'NM_FUNCAO', <ECF_NUMERO_SERIE>);
    end;
    voParams := activateCmp('' + FloatToStr(vCdComponente',) + ' 'LeInformacaoImpressora', viParams); (*,,, *)
    if (xStatus < 0) then begin
      Result := voParams;
      return(-1); exit;
    end;
    vDsSerie := itemXmlF('NR_SERIE', voParams);
    clear_e(tFIS_ECF);
    putitem_e(tFIS_ECF, 'CD_SERIEFAB', vDsSerie);
    retrieve_e(tFIS_ECF);
    if (xStatus < 0) then begin
      Result := SetStatus(STS_ERROR, 'GEN0001', 'ECF inválida para o sistema - contate suporte!', '');
      return(-50);
    end;
  end;
  if (xStatus < 0) then begin
    Result := voParams;
    return(-1); exit;
  end;
  return(0); exit;
end;

//------------------------------------------------------------------------
function T_ECFSVCO001.LEITURAMEMORIAFISCALDATA(pParams : String) : String;
//------------------------------------------------------------------------
const
  cDS_METHOD = 'ADICIONAL=Operação: T_ECFSVCO001.LEITURAMEMORIAFISCALDATA()';
var
  vCdComponente : String;
  vStatus : Real;
  viParams, voParams, vDsSerie : String;
begin
  vCdComponente := '';

  if (itemXml('PADRAO_ECF', PARAM_GLB) = <PADRAO_BEMATECH> ) or (itemXml('PADRAO_ECF', PARAM_GLB) = '') then begin
    vCdComponente := 'ECFSVCO002';
  end else if (itemXml('PADRAO_ECF', PARAM_GLB) = <PADRAO_AFRAC>) then begin
    vCdComponente := 'ECFSVCO005';
  end else if (itemXml('PADRAO_ECF', PARAM_GLB) = <PADRAO_YANCO>) then begin
    vCdComponente := 'ECFSVCO006';
  end else if (itemXml('PADRAO_ECF', PARAM_GLB) = <PADRAO_LOCAL>) then begin
    vCdComponente := 'ECFSVCO011';
  end else if (itemXml('PADRAO_ECF', PARAM_GLB) = <PADRAO_LOCALIMPFIM>) then begin
    vCdComponente := 'ECFSVCO011';
  end else begin
  end;
  if (itemXml('PADRAO_ECF', PARAM_GLB) = <PADRAO_BEMATECH> ) or (itemXml('PADRAO_ECF', PARAM_GLB) = '') then begin
    viParams := '';
    if (gInHomologacaoAM = True) then begin
      putitemXml(viParams, 'NM_FUNCAO', <ECF_NUMERO_SERIE_C>);
    end else begin
      putitemXml(viParams, 'NM_FUNCAO', <ECF_NUMERO_SERIE>);
    end;
    voParams := activateCmp('' + FloatToStr(vCdComponente',) + ' 'LeInformacaoImpressora', viParams); (*,,, *)
    if (xStatus < 0) then begin
      Result := voParams;
      return(-1); exit;
    end;
    vDsSerie := itemXmlF('NR_SERIE', voParams);
    clear_e(tFIS_ECF);
    putitem_e(tFIS_ECF, 'CD_SERIEFAB', vDsSerie);
    retrieve_e(tFIS_ECF);
    if (xStatus < 0) then begin
      Result := SetStatus(STS_ERROR, 'GEN0001', 'ECF inválida para o sistema - contate suporte!', '');
      return(-50);
    end;
  end;
  if (xStatus < 0) then begin
    Result := voParams;
    return(-1); exit;
  end;
  return(0); exit;
end;

//------------------------------------------------------------------------------
function T_ECFSVCO001.LEITURAMEMORIAFISCALSERIALDATA(pParams : String) : String;
//------------------------------------------------------------------------------
const
  cDS_METHOD = 'ADICIONAL=Operação: T_ECFSVCO001.LEITURAMEMORIAFISCALSERIALDATA()';
var
  vCdComponente : String;
  vStatus : Real;
  viParams, voParams, vDsSerie : String;
begin
  vCdComponente := '';

  if (itemXml('PADRAO_ECF', PARAM_GLB) = <PADRAO_BEMATECH> ) or (itemXml('PADRAO_ECF', PARAM_GLB) = '') then begin
    vCdComponente := 'ECFSVCO002';
  end else if (itemXml('PADRAO_ECF', PARAM_GLB) = <PADRAO_AFRAC>) then begin
    vCdComponente := 'ECFSVCO005';
  end else if (itemXml('PADRAO_ECF', PARAM_GLB) = <PADRAO_YANCO>) then begin
    vCdComponente := 'ECFSVCO006';
  end else if (itemXml('PADRAO_ECF', PARAM_GLB) = <PADRAO_LOCAL>) then begin
    vCdComponente := 'ECFSVCO011';
  end else if (itemXml('PADRAO_ECF', PARAM_GLB) = <PADRAO_LOCALIMPFIM>) then begin
    vCdComponente := 'ECFSVCO011';
  end else begin
  end;
  if (itemXml('PADRAO_ECF', PARAM_GLB) = <PADRAO_BEMATECH> ) or (itemXml('PADRAO_ECF', PARAM_GLB) = '') then begin
    viParams := '';
    if (gInHomologacaoAM = True) then begin
      putitemXml(viParams, 'NM_FUNCAO', <ECF_NUMERO_SERIE_C>);
    end else begin
      putitemXml(viParams, 'NM_FUNCAO', <ECF_NUMERO_SERIE>);
    end;
    voParams := activateCmp('' + FloatToStr(vCdComponente',) + ' 'LeInformacaoImpressora', viParams); (*,,, *)
    if (xStatus < 0) then begin
      Result := voParams;
      return(-1); exit;
    end;
    vDsSerie := itemXmlF('NR_SERIE', voParams);
    clear_e(tFIS_ECF);
    putitem_e(tFIS_ECF, 'CD_SERIEFAB', vDsSerie);
    retrieve_e(tFIS_ECF);
    if (xStatus < 0) then begin
      Result := SetStatus(STS_ERROR, 'GEN0001', 'ECF inválida para o sistema - contate suporte!', '');
      return(-50);
    end;
  end;
  if (xStatus < 0) then begin
    Result := voParams;
    return(-1); exit;
  end;
  return(0); exit;
end;

//------------------------------------------------------------------
function T_ECFSVCO001.ABRECOMPROVANTENFV(pParams : String) : String;
//------------------------------------------------------------------
const
  cDS_METHOD = 'ADICIONAL=Operação: T_ECFSVCO001.ABRECOMPROVANTENFV()';
var
  vCdComponente : String;
  vStatus : Real;
  viParams, voParams, vDsSerie : String;
begin
  vCdComponente := '';

  if (itemXml('PADRAO_ECF', PARAM_GLB) = <PADRAO_BEMATECH> ) or (itemXml('PADRAO_ECF', PARAM_GLB) = '') then begin
    vCdComponente := 'ECFSVCO002';
  end else if (itemXml('PADRAO_ECF', PARAM_GLB) = <PADRAO_AFRAC>) then begin
    vCdComponente := 'ECFSVCO005';
  end else if (itemXml('PADRAO_ECF', PARAM_GLB) = <PADRAO_YANCO>) then begin
    vCdComponente := 'ECFSVCO006';
  end else if (itemXml('PADRAO_ECF', PARAM_GLB) = <PADRAO_LOCAL>) then begin
    vCdComponente := 'ECFSVCO011';
  end else if (itemXml('PADRAO_ECF', PARAM_GLB) = <PADRAO_LOCALIMPFIM>) then begin
    vCdComponente := 'ECFSVCO011';
  end else begin
  end;
  if (itemXml('PADRAO_ECF', PARAM_GLB) = <PADRAO_BEMATECH> ) or (itemXml('PADRAO_ECF', PARAM_GLB) = '') then begin
    viParams := '';
    if (gInHomologacaoAM = True) then begin
      putitemXml(viParams, 'NM_FUNCAO', <ECF_NUMERO_SERIE_C>);
    end else begin
      putitemXml(viParams, 'NM_FUNCAO', <ECF_NUMERO_SERIE>);
    end;
    voParams := activateCmp('' + FloatToStr(vCdComponente',) + ' 'LeInformacaoImpressora', viParams); (*,,, *)
    if (xStatus < 0) then begin
      Result := voParams;
      return(-1); exit;
    end;
    vDsSerie := itemXmlF('NR_SERIE', voParams);
    clear_e(tFIS_ECF);
    putitem_e(tFIS_ECF, 'CD_SERIEFAB', vDsSerie);
    retrieve_e(tFIS_ECF);
    if (xStatus < 0) then begin
      Result := SetStatus(STS_ERROR, 'GEN0001', 'ECF inválida para o sistema - contate suporte!', '');
      return(-50);
    end;
  end;
  if (xStatus < 0) then begin
    Result := voParams;
    return(-1); exit;
  end;
  return(0); exit;
end;

//-----------------------------------------------------------------
function T_ECFSVCO001.REGISTRANAOFISCAL(pParams : String) : String;
//-----------------------------------------------------------------
const
  cDS_METHOD = 'ADICIONAL=Operação: T_ECFSVCO001.REGISTRANAOFISCAL()';
var
  vCdComponente : String;
  vStatus : Real;
  viParams, voParams, vDsSerie : String;
begin
  vCdComponente := '';

  if (itemXml('PADRAO_ECF', PARAM_GLB) = <PADRAO_BEMATECH> ) or (itemXml('PADRAO_ECF', PARAM_GLB) = '') then begin
    vCdComponente := 'ECFSVCO002';
  end else if (itemXml('PADRAO_ECF', PARAM_GLB) = <PADRAO_AFRAC>) then begin
    vCdComponente := 'ECFSVCO005';
  end else if (itemXml('PADRAO_ECF', PARAM_GLB) = <PADRAO_YANCO>) then begin
    vCdComponente := 'ECFSVCO006';
  end else begin
  end;
  if (itemXml('PADRAO_ECF', PARAM_GLB) = <PADRAO_BEMATECH> ) or (itemXml('PADRAO_ECF', PARAM_GLB) = '') then begin
    viParams := '';
    if (gInHomologacaoAM = True) then begin
      putitemXml(viParams, 'NM_FUNCAO', <ECF_NUMERO_SERIE_C>);
    end else begin
      putitemXml(viParams, 'NM_FUNCAO', <ECF_NUMERO_SERIE>);
    end;
    voParams := activateCmp('' + FloatToStr(vCdComponente',) + ' 'LeInformacaoImpressora', viParams); (*,,, *)
    if (xStatus < 0) then begin
      Result := voParams;
      return(-1); exit;
    end;
    vDsSerie := itemXmlF('NR_SERIE', voParams);
    clear_e(tFIS_ECF);
    putitem_e(tFIS_ECF, 'CD_SERIEFAB', vDsSerie);
    retrieve_e(tFIS_ECF);
    if (xStatus < 0) then begin
      Result := SetStatus(STS_ERROR, 'GEN0001', 'ECF inválida para o sistema - contate suporte!', '');
      return(-50);
    end;
  end;
  if (xStatus < 0) then begin
    Result := voParams;
    return(-1); exit;
  end;
  return(0); exit;
end;

//----------------------------------------------------------------------
function T_ECFSVCO001.LEINFORMACAOIMPRESSORA(pParams : String) : String;
//----------------------------------------------------------------------
const
  cDS_METHOD = 'ADICIONAL=Operação: T_ECFSVCO001.LEINFORMACAOIMPRESSORA()';
var
  vCdComponente, vEOF, vDsLinha, vDsRetorno : String;
  vInSair : Boolean;
  vDtMovimentoECF : TDate;
  vStatus : Real;
  viParams, voParams, vDsSerie : String;
begin
  vCdComponente := '';

  if (itemXml('PADRAO_ECF', PARAM_GLB) = <PADRAO_BEMATECH> ) or (itemXml('PADRAO_ECF', PARAM_GLB) = '') then begin
    vCdComponente := 'ECFSVCO002';
  end else if (itemXml('PADRAO_ECF', PARAM_GLB) = <PADRAO_AFRAC>) then begin
    if (itemXml('NM_FUNCAO', pParams) = '<ECF_NUMERO_CUPOM>') then begin
      putitemXml(pParams, 'TP_INFO', '023');
    end else if (itemXml('NM_FUNCAO', pParams) = '<ECF_NUMERO_SERIE>')  or (itemXml('NM_FUNCAO', pParams) = '<ECF_NUMERO_SERIE_C>') then begin
      putitemXml(pParams, 'TP_INFO', '002');
    end;
    vCdComponente := 'ECFSVCO005';
  end else if (itemXml('PADRAO_ECF', PARAM_GLB) = <PADRAO_YANCO>) then begin
    vCdComponente := 'ECFSVCO006';
  end else if (itemXml('PADRAO_ECF', PARAM_GLB) = <PADRAO_LOCAL>) then begin
    vCdComponente := 'ECFSVCO011';
  end else if (itemXml('PADRAO_ECF', PARAM_GLB) = <PADRAO_LOCALIMPFIM>) then begin
    vCdComponente := 'ECFSVCO011';
  end else begin
  end;
  if (xStatus < 0) then begin
    Result := voParams;
    return(-1); exit;
  end;

  return(0); exit;
end;

//---------------------------------------------------------------------
function T_ECFSVCO001.ACRESCIMODESCONTOITEM(pParams : String) : String;
//---------------------------------------------------------------------
const
  cDS_METHOD = 'ADICIONAL=Operação: T_ECFSVCO001.ACRESCIMODESCONTOITEM()';
var
  vCdComponente : String;
  vStatus : Real;
  viParams, voParams, vDsSerie : String;
begin
  vCdComponente := '';

  if (itemXml('PADRAO_ECF', PARAM_GLB) = <PADRAO_BEMATECH> ) or (itemXml('PADRAO_ECF', PARAM_GLB) = '') then begin
    vCdComponente := 'ECFSVCO002';
  end else if (itemXml('PADRAO_ECF', PARAM_GLB) = <PADRAO_AFRAC>) then begin
    vCdComponente := 'ECFSVCO005';
  end else if (itemXml('PADRAO_ECF', PARAM_GLB) = <PADRAO_YANCO>) then begin
    vCdComponente := 'ECFSVCO006';

  end else if (itemXml('PADRAO_ECF', PARAM_GLB) = <PADRAO_LOCAL>) then begin
    vCdComponente := 'ECFSVCO011';
  end else if (itemXml('PADRAO_ECF', PARAM_GLB) = <PADRAO_LOCALIMPFIM>) then begin
    vCdComponente := 'ECFSVCO011';
  end else begin
  end;
  if (itemXml('PADRAO_ECF', PARAM_GLB) = <PADRAO_BEMATECH> ) or (itemXml('PADRAO_ECF', PARAM_GLB) = '') then begin
    viParams := '';
    if (gInHomologacaoAM = True) then begin
      putitemXml(viParams, 'NM_FUNCAO', <ECF_NUMERO_SERIE_C>);
    end else begin
      putitemXml(viParams, 'NM_FUNCAO', <ECF_NUMERO_SERIE>);
    end;
    voParams := activateCmp('' + FloatToStr(vCdComponente',) + ' 'LeInformacaoImpressora', viParams); (*,,, *)
    if (xStatus < 0) then begin
      Result := voParams;
      return(-1); exit;
    end;
    vDsSerie := itemXmlF('NR_SERIE', voParams);
    clear_e(tFIS_ECF);
    putitem_e(tFIS_ECF, 'CD_SERIEFAB', vDsSerie);
    retrieve_e(tFIS_ECF);
    if (xStatus < 0) then begin
      Result := SetStatus(STS_ERROR, 'GEN0001', 'ECF inválida para o sistema - contate suporte!', '');
      return(-50);
    end;
  end;
  if (xStatus < 0) then begin
    Result := voParams;
    return(-1); exit;
  end;

  return(0); exit;
end;

//--------------------------------------------------------------
function T_ECFSVCO001.VERIFICAESTADO(pParams : String) : String;
//--------------------------------------------------------------
const
  cDS_METHOD = 'ADICIONAL=Operação: T_ECFSVCO001.VERIFICAESTADO()';
var
  vCdComponente, vDsRetorno, vEOF, vDsLinha : String;
  vInSair : Boolean;
  vStatus : Real;
  viParams, voParams, vDsSerie : String;
begin
  vCdComponente := '';

  if (itemXml('PADRAO_ECF', PARAM_GLB) = <PADRAO_BEMATECH> ) or (itemXml('PADRAO_ECF', PARAM_GLB) = '') then begin
    vCdComponente := 'ECFSVCO002';
  end else if (itemXml('PADRAO_ECF', PARAM_GLB) = <PADRAO_AFRAC>) then begin
    vCdComponente := 'ECFSVCO005';
  end else if (itemXml('PADRAO_ECF', PARAM_GLB) = <PADRAO_YANCO>) then begin
    vCdComponente := 'ECFSVCO006';
  end else if (itemXml('PADRAO_ECF', PARAM_GLB) = <PADRAO_LOCAL>) then begin
    vCdComponente := 'ECFSVCO011';
  end else if (itemXml('PADRAO_ECF', PARAM_GLB) = <PADRAO_LOCALIMPFIM>) then begin
    vCdComponente := 'ECFSVCO011';
  end else begin
  end;
  if (xStatus < 0) then begin
    Result := voParams;
    return(-1); exit;
  end;
  return(0); exit;
end;

//-----------------------------------------------------------------
function T_ECFSVCO001.IMPRIMIRVINCULADO(pParams : String) : String;
//-----------------------------------------------------------------
const
  cDS_METHOD = 'ADICIONAL=Operação: T_ECFSVCO001.IMPRIMIRVINCULADO()';
var
  vCdComponente : String;
  vStatus : Real;
  viParams, voParams, vDsSerie : String;
begin
  vCdComponente := '';

  if (itemXml('PADRAO_ECF', PARAM_GLB) = <PADRAO_BEMATECH> ) or (itemXml('PADRAO_ECF', PARAM_GLB) = '') then begin
    vCdComponente := 'ECFSVCO002';
  end else if (itemXml('PADRAO_ECF', PARAM_GLB) = <PADRAO_AFRAC>) then begin
    vCdComponente := 'ECFSVCO005';
  end else if (itemXml('PADRAO_ECF', PARAM_GLB) = <PADRAO_YANCO>) then begin
    vCdComponente := 'ECFSVCO006';
  end else if (itemXml('PADRAO_ECF', PARAM_GLB) = <PADRAO_LOCAL>) then begin
    vCdComponente := 'ECFSVCO011';
  end else if (itemXml('PADRAO_ECF', PARAM_GLB) = <PADRAO_LOCALIMPFIM>) then begin
    vCdComponente := 'ECFSVCO011';
  end else begin
  end;
  if (itemXml('PADRAO_ECF', PARAM_GLB) = <PADRAO_BEMATECH> ) or (itemXml('PADRAO_ECF', PARAM_GLB) = '') then begin
    viParams := '';
    if (gInHomologacaoAM = True) then begin
      putitemXml(viParams, 'NM_FUNCAO', <ECF_NUMERO_SERIE_C>);
    end else begin
      putitemXml(viParams, 'NM_FUNCAO', <ECF_NUMERO_SERIE>);
    end;
    voParams := activateCmp('' + FloatToStr(vCdComponente',) + ' 'LeInformacaoImpressora', viParams); (*,,, *)
    if (xStatus < 0) then begin
      Result := voParams;
      return(-1); exit;
    end;
    vDsSerie := itemXmlF('NR_SERIE', voParams);
    clear_e(tFIS_ECF);
    putitem_e(tFIS_ECF, 'CD_SERIEFAB', vDsSerie);
    retrieve_e(tFIS_ECF);
    if (xStatus < 0) then begin
      Result := SetStatus(STS_ERROR, 'GEN0001', 'ECF inválida para o sistema - contate suporte!', '');
      return(-50);
    end;
  end;
  if (xStatus < 0) then begin
    Result := voParams;
    return(-1); exit;
  end;
  return(0); exit;
end;

//--------------------------------------------------------------------------
function T_ECFSVCO001.ImprimirRelatorioGerencial(pParams : String) : String;
//--------------------------------------------------------------------------
const
  cDS_METHOD = 'ADICIONAL=Operação: T_ECFSVCO001.ImprimirRelatorioGerencial()';
var
  vCdComponente : String;
  vStatus : Real;
  viParams, voParams, vDsSerie : String;
begin
  vCdComponente := '';

  if (itemXml('PADRAO_ECF', PARAM_GLB) = <PADRAO_BEMATECH> ) or (itemXml('PADRAO_ECF', PARAM_GLB) = '') then begin
    vCdComponente := 'ECFSVCO002';
  end else if (itemXml('PADRAO_ECF', PARAM_GLB) = <PADRAO_AFRAC>) then begin
    vCdComponente := 'ECFSVCO005';
  end else if (itemXml('PADRAO_ECF', PARAM_GLB) = <PADRAO_YANCO>) then begin
    vCdComponente := 'ECFSVCO006';
  end else if (itemXml('PADRAO_ECF', PARAM_GLB) = <PADRAO_LOCAL>) then begin
    vCdComponente := 'ECFSVCO011';
  end else if (itemXml('PADRAO_ECF', PARAM_GLB) = <PADRAO_LOCALIMPFIM>) then begin
    vCdComponente := 'ECFSVCO011';
  end else begin
  end;
  if (itemXml('PADRAO_ECF', PARAM_GLB) = <PADRAO_BEMATECH> ) or (itemXml('PADRAO_ECF', PARAM_GLB) = '') then begin
    viParams := '';
    if (gInHomologacaoAM = True) then begin
      putitemXml(viParams, 'NM_FUNCAO', <ECF_NUMERO_SERIE_C>);
    end else begin
      putitemXml(viParams, 'NM_FUNCAO', <ECF_NUMERO_SERIE>);
    end;
    voParams := activateCmp('' + FloatToStr(vCdComponente',) + ' 'LeInformacaoImpressora', viParams); (*,,, *)
    if (xStatus < 0) then begin
      Result := voParams;
      return(-1); exit;
    end;
    vDsSerie := itemXmlF('NR_SERIE', voParams);
    clear_e(tFIS_ECF);
    putitem_e(tFIS_ECF, 'CD_SERIEFAB', vDsSerie);
    retrieve_e(tFIS_ECF);
    if (xStatus < 0) then begin
      Result := SetStatus(STS_ERROR, 'GEN0001', 'ECF inválida para o sistema - contate suporte!', '');
      return(-50);
    end;
  end;
  if (xStatus < 0) then begin
    Result := voParams;
    return(-1); exit;
  end;
  return(0); exit;
end;

//-----------------------------------------------------------------------
function T_ECFSVCO001.FechaRelatorioGerencial(pParams : String) : String;
//-----------------------------------------------------------------------
const
  cDS_METHOD = 'ADICIONAL=Operação: T_ECFSVCO001.FechaRelatorioGerencial()';
var
  vCdComponente : String;
  vStatus : Real;
  viParams, voParams, vDsSerie : String;
begin
  vCdComponente := '';

  if (itemXml('PADRAO_ECF', PARAM_GLB) = <PADRAO_BEMATECH> ) or (itemXml('PADRAO_ECF', PARAM_GLB) = '') then begin
    vCdComponente := 'ECFSVCO002';
  end else if (itemXml('PADRAO_ECF', PARAM_GLB) = <PADRAO_AFRAC>) then begin
    vCdComponente := 'ECFSVCO005';
  end else if (itemXml('PADRAO_ECF', PARAM_GLB) = <PADRAO_YANCO>) then begin
    vCdComponente := 'ECFSVCO006';
  end else if (itemXml('PADRAO_ECF', PARAM_GLB) = <PADRAO_LOCAL>) then begin
    vCdComponente := 'ECFSVCO011';
  end else if (itemXml('PADRAO_ECF', PARAM_GLB) = <PADRAO_LOCALIMPFIM>) then begin
    vCdComponente := 'ECFSVCO011';
  end else begin
  end;
  if (itemXml('PADRAO_ECF', PARAM_GLB) = <PADRAO_BEMATECH> ) or (itemXml('PADRAO_ECF', PARAM_GLB) = '') then begin
    viParams := '';
    if (gInHomologacaoAM = True) then begin
      putitemXml(viParams, 'NM_FUNCAO', <ECF_NUMERO_SERIE_C>);
    end else begin
      putitemXml(viParams, 'NM_FUNCAO', <ECF_NUMERO_SERIE>);
    end;
    voParams := activateCmp('' + FloatToStr(vCdComponente',) + ' 'LeInformacaoImpressora', viParams); (*,,, *)
    if (xStatus < 0) then begin
      Result := voParams;
      return(-1); exit;
    end;
    vDsSerie := itemXmlF('NR_SERIE', voParams);
    clear_e(tFIS_ECF);
    putitem_e(tFIS_ECF, 'CD_SERIEFAB', vDsSerie);
    retrieve_e(tFIS_ECF);
    if (xStatus < 0) then begin
      Result := SetStatus(STS_ERROR, 'GEN0001', 'ECF inválida para o sistema - contate suporte!', '');
      return(-50);
    end;
  end;
  if (xStatus < 0) then begin
    Result := voParams;
    return(-1); exit;
  end;
  return(0); exit;
end;

//--------------------------------------------------------------
function T_ECFSVCO001.FECHAVINCULADO(pParams : String) : String;
//--------------------------------------------------------------
const
  cDS_METHOD = 'ADICIONAL=Operação: T_ECFSVCO001.FECHAVINCULADO()';
var
  vCdComponente : String;
  vStatus : Real;
  viParams, voParams, vDsSerie : String;
begin
  vCdComponente := '';

  if (itemXml('PADRAO_ECF', PARAM_GLB) = <PADRAO_BEMATECH> ) or (itemXml('PADRAO_ECF', PARAM_GLB) = '') then begin
    vCdComponente := 'ECFSVCO002';
  end else if (itemXml('PADRAO_ECF', PARAM_GLB) = <PADRAO_AFRAC>) then begin
    vCdComponente := 'ECFSVCO005';
  end else if (itemXml('PADRAO_ECF', PARAM_GLB) = <PADRAO_YANCO>) then begin
    vCdComponente := 'ECFSVCO006';
  end else if (itemXml('PADRAO_ECF', PARAM_GLB) = <PADRAO_LOCAL>) then begin
    vCdComponente := 'ECFSVCO011';
  end else if (itemXml('PADRAO_ECF', PARAM_GLB) = <PADRAO_LOCALIMPFIM>) then begin
    vCdComponente := 'ECFSVCO011';
  end else begin
  end;
  if (itemXml('PADRAO_ECF', PARAM_GLB) = <PADRAO_BEMATECH> ) or (itemXml('PADRAO_ECF', PARAM_GLB) = '') then begin
    viParams := '';
    if (gInHomologacaoAM = True) then begin
      putitemXml(viParams, 'NM_FUNCAO', <ECF_NUMERO_SERIE_C>);
    end else begin
      putitemXml(viParams, 'NM_FUNCAO', <ECF_NUMERO_SERIE>);
    end;
    voParams := activateCmp('' + FloatToStr(vCdComponente',) + ' 'LeInformacaoImpressora', viParams); (*,,, *)
    if (xStatus < 0) then begin
      Result := voParams;
      return(-1); exit;
    end;
    vDsSerie := itemXmlF('NR_SERIE', voParams);
    clear_e(tFIS_ECF);
    putitem_e(tFIS_ECF, 'CD_SERIEFAB', vDsSerie);
    retrieve_e(tFIS_ECF);
    if (xStatus < 0) then begin
      Result := SetStatus(STS_ERROR, 'GEN0001', 'ECF inválida para o sistema - contate suporte!', '');
      return(-50);
    end;
  end;
  if (xStatus < 0) then begin
    Result := voParams;
    return(-1); exit;
  end;
  return(0); exit;
end;

//----------------------------------------------------------
function T_ECFSVCO001.SUPRIMENTO(pParams : String) : String;
//----------------------------------------------------------
const
  cDS_METHOD = 'ADICIONAL=Operação: T_ECFSVCO001.SUPRIMENTO()';
var
  vCdComponente : String;
  vStatus : Real;
  viParams, voParams, vDsSerie : String;
begin
  vCdComponente := '';

  if (itemXml('PADRAO_ECF', PARAM_GLB) = <PADRAO_BEMATECH> ) or (itemXml('PADRAO_ECF', PARAM_GLB) = '') then begin
    vCdComponente := 'ECFSVCO002';
  end else if (itemXml('PADRAO_ECF', PARAM_GLB) = <PADRAO_AFRAC>) then begin
    vCdComponente := 'ECFSVCO005';
  end else if (itemXml('PADRAO_ECF', PARAM_GLB) = <PADRAO_YANCO>) then begin
    vCdComponente := 'ECFSVCO006';
  end else if (itemXml('PADRAO_ECF', PARAM_GLB) = <PADRAO_LOCAL>) then begin
    vCdComponente := 'ECFSVCO011';
  end else if (itemXml('PADRAO_ECF', PARAM_GLB) = <PADRAO_LOCALIMPFIM>) then begin
    vCdComponente := 'ECFSVCO011';
  end else begin
  end;
  if (itemXml('PADRAO_ECF', PARAM_GLB) = <PADRAO_BEMATECH> ) or (itemXml('PADRAO_ECF', PARAM_GLB) = '') then begin
    viParams := '';
    if (gInHomologacaoAM = True) then begin
      putitemXml(viParams, 'NM_FUNCAO', <ECF_NUMERO_SERIE_C>);
    end else begin
      putitemXml(viParams, 'NM_FUNCAO', <ECF_NUMERO_SERIE>);
    end;
    voParams := activateCmp('' + FloatToStr(vCdComponente',) + ' 'LeInformacaoImpressora', viParams); (*,,, *)
    if (xStatus < 0) then begin
      Result := voParams;
      return(-1); exit;
    end;
    vDsSerie := itemXmlF('NR_SERIE', voParams);
    clear_e(tFIS_ECF);
    putitem_e(tFIS_ECF, 'CD_SERIEFAB', vDsSerie);
    retrieve_e(tFIS_ECF);
    if (xStatus < 0) then begin
      Result := SetStatus(STS_ERROR, 'GEN0001', 'ECF inválida para o sistema - contate suporte!', '');
      return(-50);
    end;
  end;
  if (xStatus < 0) then begin
    Result := voParams;
    return(-1); exit;
  end;
  return(0); exit;
end;

//-------------------------------------------------------------
function T_ECFSVCO001.ABERTURADODIA(pParams : String) : String;
//-------------------------------------------------------------
const
  cDS_METHOD = 'ADICIONAL=Operação: T_ECFSVCO001.ABERTURADODIA()';
var
  vCdComponente : String;
  vStatus : Real;
  viParams, voParams, vDsSerie : String;
begin
  vCdComponente := '';

  if (itemXml('PADRAO_ECF', PARAM_GLB) = <PADRAO_BEMATECH> ) or (itemXml('PADRAO_ECF', PARAM_GLB) = '') then begin
    vCdComponente := 'ECFSVCO002';
  end else if (itemXml('PADRAO_ECF', PARAM_GLB) = <PADRAO_AFRAC>) then begin
    vCdComponente := 'ECFSVCO005';
  end else if (itemXml('PADRAO_ECF', PARAM_GLB) = <PADRAO_YANCO>) then begin
    vCdComponente := 'ECFSVCO006';
  end else if (itemXml('PADRAO_ECF', PARAM_GLB) = <PADRAO_LOCAL>) then begin
    vCdComponente := 'ECFSVCO011';
  end else if (itemXml('PADRAO_ECF', PARAM_GLB) = <PADRAO_LOCALIMPFIM>) then begin
    vCdComponente := 'ECFSVCO011';
  end else begin
  end;
  if (itemXml('PADRAO_ECF', PARAM_GLB) = <PADRAO_BEMATECH> ) or (itemXml('PADRAO_ECF', PARAM_GLB) = '') then begin
    viParams := '';
    if (gInHomologacaoAM = True) then begin
      putitemXml(viParams, 'NM_FUNCAO', <ECF_NUMERO_SERIE_C>);
    end else begin
      putitemXml(viParams, 'NM_FUNCAO', <ECF_NUMERO_SERIE>);
    end;
    voParams := activateCmp('' + FloatToStr(vCdComponente',) + ' 'LeInformacaoImpressora', viParams); (*,,, *)
    if (xStatus < 0) then begin
      Result := voParams;
      return(-1); exit;
    end;
    vDsSerie := itemXmlF('NR_SERIE', voParams);
    clear_e(tFIS_ECF);
    putitem_e(tFIS_ECF, 'CD_SERIEFAB', vDsSerie);
    retrieve_e(tFIS_ECF);
    if (xStatus < 0) then begin
      Result := SetStatus(STS_ERROR, 'GEN0001', 'ECF inválida para o sistema - contate suporte!', '');
      return(-50);
    end;
  end;
  if (xStatus < 0) then begin
    Result := voParams;
    return(-1); exit;
  end;
  return(0); exit;
end;

//-------------------------------------------------------
function T_ECFSVCO001.SANGRIA(pParams : String) : String;
//-------------------------------------------------------
const
  cDS_METHOD = 'ADICIONAL=Operação: T_ECFSVCO001.SANGRIA()';
var
  vCdComponente : String;
  vStatus : Real;
  viParams, voParams, vDsSerie : String;
begin
  vCdComponente := '';

  if (itemXml('PADRAO_ECF', PARAM_GLB) = <PADRAO_BEMATECH> ) or (itemXml('PADRAO_ECF', PARAM_GLB) = '') then begin
    vCdComponente := 'ECFSVCO002';
  end else if (itemXml('PADRAO_ECF', PARAM_GLB) = <PADRAO_AFRAC>) then begin
    vCdComponente := 'ECFSVCO005';
  end else if (itemXml('PADRAO_ECF', PARAM_GLB) = <PADRAO_YANCO>) then begin
    vCdComponente := 'ECFSVCO006';
  end else if (itemXml('PADRAO_ECF', PARAM_GLB) = <PADRAO_LOCAL>) then begin
    vCdComponente := 'ECFSVCO011';
  end else if (itemXml('PADRAO_ECF', PARAM_GLB) = <PADRAO_LOCALIMPFIM>) then begin
    vCdComponente := 'ECFSVCO011';
  end else begin
  end;
  if (itemXml('PADRAO_ECF', PARAM_GLB) = <PADRAO_BEMATECH> ) or (itemXml('PADRAO_ECF', PARAM_GLB) = '') then begin
    viParams := '';
    if (gInHomologacaoAM = True) then begin
      putitemXml(viParams, 'NM_FUNCAO', <ECF_NUMERO_SERIE_C>);
    end else begin
      putitemXml(viParams, 'NM_FUNCAO', <ECF_NUMERO_SERIE>);
    end;
    voParams := activateCmp('' + FloatToStr(vCdComponente',) + ' 'LeInformacaoImpressora', viParams); (*,,, *)
    if (xStatus < 0) then begin
      Result := voParams;
      return(-1); exit;
    end;
    vDsSerie := itemXmlF('NR_SERIE', voParams);
    clear_e(tFIS_ECF);
    putitem_e(tFIS_ECF, 'CD_SERIEFAB', vDsSerie);
    retrieve_e(tFIS_ECF);
    if (xStatus < 0) then begin
      Result := SetStatus(STS_ERROR, 'GEN0001', 'ECF inválida para o sistema - contate suporte!', '');
      return(-50);
    end;
  end;
  if (xStatus < 0) then begin
    Result := voParams;
    return(-1); exit;
  end;
  return(0); exit;
end;

//-------------------------------------------------------------
function T_ECFSVCO001.INICIAMODOTEF(pParams : String) : String;
//-------------------------------------------------------------
const
  cDS_METHOD = 'ADICIONAL=Operação: T_ECFSVCO001.INICIAMODOTEF()';
var
  vCdComponente : String;
  vStatus : Real;
  viParams, voParams, vDsSerie : String;
begin
  vCdComponente := '';

  if (itemXml('PADRAO_ECF', PARAM_GLB) = <PADRAO_BEMATECH> ) or (itemXml('PADRAO_ECF', PARAM_GLB) = '') then begin
    vCdComponente := 'ECFSVCO002';
  end else if (itemXml('PADRAO_ECF', PARAM_GLB) = <PADRAO_AFRAC>) then begin
    vCdComponente := 'ECFSVCO005';
  end else if (itemXml('PADRAO_ECF', PARAM_GLB) = <PADRAO_YANCO>) then begin
    vCdComponente := 'ECFSVCO006';
  end else if (itemXml('PADRAO_ECF', PARAM_GLB) = <PADRAO_LOCAL>) then begin
    vCdComponente := 'ECFSVCO011';
  end else if (itemXml('PADRAO_ECF', PARAM_GLB) = <PADRAO_LOCALIMPFIM>) then begin
    vCdComponente := 'ECFSVCO011';
  end else begin
  end;
  if (itemXml('PADRAO_ECF', PARAM_GLB) = <PADRAO_BEMATECH> ) or (itemXml('PADRAO_ECF', PARAM_GLB) = '') then begin
    viParams := '';
    if (gInHomologacaoAM = True) then begin
      putitemXml(viParams, 'NM_FUNCAO', <ECF_NUMERO_SERIE_C>);
    end else begin
      putitemXml(viParams, 'NM_FUNCAO', <ECF_NUMERO_SERIE>);
    end;
    voParams := activateCmp('' + FloatToStr(vCdComponente',) + ' 'LeInformacaoImpressora', viParams); (*,,, *)
    if (xStatus < 0) then begin
      Result := voParams;
      return(-1); exit;
    end;
    vDsSerie := itemXmlF('NR_SERIE', voParams);
    clear_e(tFIS_ECF);
    putitem_e(tFIS_ECF, 'CD_SERIEFAB', vDsSerie);
    retrieve_e(tFIS_ECF);
    if (xStatus < 0) then begin
      Result := SetStatus(STS_ERROR, 'GEN0001', 'ECF inválida para o sistema - contate suporte!', '');
      return(-50);
    end;
  end;
  if (xStatus < 0) then begin
    Result := voParams;
    return(-1); exit;
  end;
  return(0); exit;
end;

//---------------------------------------------------------------
function T_ECFSVCO001.FINALIZAMODOTEF(pParams : String) : String;
//---------------------------------------------------------------
const
  cDS_METHOD = 'ADICIONAL=Operação: T_ECFSVCO001.FINALIZAMODOTEF()';
var
  vCdComponente : String;
  vStatus : Real;
  viParams, voParams, vDsSerie : String;
begin
  vCdComponente := '';

  if (itemXml('PADRAO_ECF', PARAM_GLB) = <PADRAO_BEMATECH> ) or (itemXml('PADRAO_ECF', PARAM_GLB) = '') then begin
    vCdComponente := 'ECFSVCO002';
  end else if (itemXml('PADRAO_ECF', PARAM_GLB) = <PADRAO_AFRAC>) then begin
    vCdComponente := 'ECFSVCO005';
  end else if (itemXml('PADRAO_ECF', PARAM_GLB) = <PADRAO_YANCO>) then begin
    vCdComponente := 'ECFSVCO006';
  end else if (itemXml('PADRAO_ECF', PARAM_GLB) = <PADRAO_LOCAL>) then begin
    vCdComponente := 'ECFSVCO011';
  end else if (itemXml('PADRAO_ECF', PARAM_GLB) = <PADRAO_LOCALIMPFIM>) then begin
    vCdComponente := 'ECFSVCO011';
  end else begin
  end;
  if (itemXml('PADRAO_ECF', PARAM_GLB) = <PADRAO_BEMATECH> ) or (itemXml('PADRAO_ECF', PARAM_GLB) = '') then begin
    viParams := '';
    if (gInHomologacaoAM = True) then begin
      putitemXml(viParams, 'NM_FUNCAO', <ECF_NUMERO_SERIE_C>);
    end else begin
      putitemXml(viParams, 'NM_FUNCAO', <ECF_NUMERO_SERIE>);
    end;
    voParams := activateCmp('' + FloatToStr(vCdComponente',) + ' 'LeInformacaoImpressora', viParams); (*,,, *)
    if (xStatus < 0) then begin
      Result := voParams;
      return(-1); exit;
    end;
    vDsSerie := itemXmlF('NR_SERIE', voParams);
    clear_e(tFIS_ECF);
    putitem_e(tFIS_ECF, 'CD_SERIEFAB', vDsSerie);
    retrieve_e(tFIS_ECF);
    if (xStatus < 0) then begin
      Result := SetStatus(STS_ERROR, 'GEN0001', 'ECF inválida para o sistema - contate suporte!', '');
      return(-50);
    end;
  end;
  if (xStatus < 0) then begin
    Result := voParams;
    return(-1); exit;
  end;
  return(0); exit;
end;

//----------------------------------------------------------
function T_ECFSVCO001.abreGaveta(pParams : String) : String;
//----------------------------------------------------------
const
  cDS_METHOD = 'ADICIONAL=Operação: T_ECFSVCO001.abreGaveta()';
var
  vCdComponente : String;
  vStatus : Real;
  viParams, voParams, vDsSerie : String;
begin
  if (itemXml('IN_ABRE_GAVETA_VendA', PARAM_GLB) = 0)  and (itemXml('IN_RECEBTITULO', pParams) <> True) then begin
    return(0); exit;
  end;

  vCdComponente := '';

  if (itemXml('PADRAO_ECF', PARAM_GLB) = <PADRAO_BEMATECH> ) or (itemXml('PADRAO_ECF', PARAM_GLB) = '') then begin
    vCdComponente := 'ECFSVCO002';
  end else if (itemXml('PADRAO_ECF', PARAM_GLB) = <PADRAO_AFRAC>) then begin
    vCdComponente := 'ECFSVCO005';
  end else if (itemXml('PADRAO_ECF', PARAM_GLB) = <PADRAO_YANCO>) then begin
    vCdComponente := 'ECFSVCO006';
  end else if (itemXml('PADRAO_ECF', PARAM_GLB) = <PADRAO_LOCAL>) then begin
    vCdComponente := 'ECFSVCO011';
  end else if (itemXml('PADRAO_ECF', PARAM_GLB) = <PADRAO_LOCALIMPFIM>) then begin
    vCdComponente := 'ECFSVCO011';
  end else begin
  end;
  if (itemXml('PADRAO_ECF', PARAM_GLB) = <PADRAO_BEMATECH> ) or (itemXml('PADRAO_ECF', PARAM_GLB) = '') then begin
    viParams := '';
    if (gInHomologacaoAM = True) then begin
      putitemXml(viParams, 'NM_FUNCAO', <ECF_NUMERO_SERIE_C>);
    end else begin
      putitemXml(viParams, 'NM_FUNCAO', <ECF_NUMERO_SERIE>);
    end;
    voParams := activateCmp('' + FloatToStr(vCdComponente',) + ' 'LeInformacaoImpressora', viParams); (*,,, *)
    if (xStatus < 0) then begin
      Result := voParams;
      return(-1); exit;
    end;
    vDsSerie := itemXmlF('NR_SERIE', voParams);
    clear_e(tFIS_ECF);
    putitem_e(tFIS_ECF, 'CD_SERIEFAB', vDsSerie);
    retrieve_e(tFIS_ECF);
    if (xStatus < 0) then begin
      Result := SetStatus(STS_ERROR, 'GEN0001', 'ECF inválida para o sistema - contate suporte!', '');
      return(-50);
    end;
  end;
  if (xStatus < 0) then begin
    Result := voParams;
    return(-1); exit;
  end;
  return(0); exit;
end;

//-------------------------------------------------------------
function T_ECFSVCO001.progHoraVerao(pParams : String) : String;
//-------------------------------------------------------------
const
  cDS_METHOD = 'ADICIONAL=Operação: T_ECFSVCO001.progHoraVerao()';
var
  vCdComponente : String;
  vStatus : Real;
  viParams, voParams, vDsSerie : String;
begin
  vCdComponente := '';

  if (itemXml('PADRAO_ECF', PARAM_GLB) = <PADRAO_BEMATECH> ) or (itemXml('PADRAO_ECF', PARAM_GLB) = '') then begin
    vCdComponente := 'ECFSVCO002';
  end else if (itemXml('PADRAO_ECF', PARAM_GLB) = <PADRAO_AFRAC>) then begin
    vCdComponente := 'ECFSVCO005';
  end else if (itemXml('PADRAO_ECF', PARAM_GLB) = <PADRAO_YANCO>) then begin
    vCdComponente := 'ECFSVCO006';
  end else if (itemXml('PADRAO_ECF', PARAM_GLB) = <PADRAO_LOCAL>) then begin
    vCdComponente := 'ECFSVCO011';
  end else if (itemXml('PADRAO_ECF', PARAM_GLB) = <PADRAO_LOCALIMPFIM>) then begin
    vCdComponente := 'ECFSVCO011';
  end else begin
  end;
  if (itemXml('PADRAO_ECF', PARAM_GLB) = <PADRAO_BEMATECH> ) or (itemXml('PADRAO_ECF', PARAM_GLB) = '') then begin
    viParams := '';
    if (gInHomologacaoAM = True) then begin
      putitemXml(viParams, 'NM_FUNCAO', <ECF_NUMERO_SERIE_C>);
    end else begin
      putitemXml(viParams, 'NM_FUNCAO', <ECF_NUMERO_SERIE>);
    end;
    voParams := activateCmp('' + FloatToStr(vCdComponente',) + ' 'LeInformacaoImpressora', viParams); (*,,, *)
    if (xStatus < 0) then begin
      Result := voParams;
      return(-1); exit;
    end;
    vDsSerie := itemXmlF('NR_SERIE', voParams);
    clear_e(tFIS_ECF);
    putitem_e(tFIS_ECF, 'CD_SERIEFAB', vDsSerie);
    retrieve_e(tFIS_ECF);
    if (xStatus < 0) then begin
      Result := SetStatus(STS_ERROR, 'GEN0001', 'ECF inválida para o sistema - contate suporte!', '');
      return(-50);
    end;
  end;
  if (xStatus < 0) then begin
    Result := voParams;
    return(-1); exit;
  end;
  return(0); exit;
end;

//--------------------------------------------------------------------
function T_ECFSVCO001.RELATORIOSINTEGRAMFD(pParams : String) : String;
//--------------------------------------------------------------------
const
  cDS_METHOD = 'ADICIONAL=Operação: T_ECFSVCO001.RELATORIOSINTEGRAMFD()';
var
  vCdComponente : String;
  vStatus : Real;
  viParams, voParams, vDsSerie : String;
begin
  vCdComponente := '';

  if (itemXml('PADRAO_ECF', PARAM_GLB) = <PADRAO_BEMATECH> ) or (itemXml('PADRAO_ECF', PARAM_GLB) = '') then begin
    vCdComponente := 'ECFSVCO002';
  end else if (itemXml('PADRAO_ECF', PARAM_GLB) = <PADRAO_AFRAC>) then begin
    vCdComponente := 'ECFSVCO005';
  end else if (itemXml('PADRAO_ECF', PARAM_GLB) = <PADRAO_YANCO>) then begin
    vCdComponente := 'ECFSVCO006';
  end else if (itemXml('PADRAO_ECF', PARAM_GLB) = <PADRAO_LOCAL>) then begin
    vCdComponente := 'ECFSVCO011';
  end else if (itemXml('PADRAO_ECF', PARAM_GLB) = <PADRAO_LOCALIMPFIM>) then begin
    vCdComponente := 'ECFSVCO011';
  end else begin
  end;
  if (itemXml('PADRAO_ECF', PARAM_GLB) = <PADRAO_BEMATECH> ) or (itemXml('PADRAO_ECF', PARAM_GLB) = '') then begin
    viParams := '';
    if (gInHomologacaoAM = True) then begin
      putitemXml(viParams, 'NM_FUNCAO', <ECF_NUMERO_SERIE_C>);
    end else begin
      putitemXml(viParams, 'NM_FUNCAO', <ECF_NUMERO_SERIE>);
    end;
    voParams := activateCmp('' + FloatToStr(vCdComponente',) + ' 'LeInformacaoImpressora', viParams); (*,,, *)
    if (xStatus < 0) then begin
      Result := voParams;
      return(-1); exit;
    end;
    vDsSerie := itemXmlF('NR_SERIE', voParams);
    clear_e(tFIS_ECF);
    putitem_e(tFIS_ECF, 'CD_SERIEFAB', vDsSerie);
    retrieve_e(tFIS_ECF);
    if (xStatus < 0) then begin
      Result := SetStatus(STS_ERROR, 'GEN0001', 'ECF inválida para o sistema - contate suporte!', '');
      return(-50);
    end;
  end;
  if (xStatus < 0) then begin
    Result := voParams;
    return(-1); exit;
  end;
  return(0); exit;
end;

//------------------------------------------------------------------------
function T_ECFSVCO001.GERARELATORIOSINTEGRAMFD(pParams : String) : String;
//------------------------------------------------------------------------
const
  cDS_METHOD = 'ADICIONAL=Operação: T_ECFSVCO001.GERARELATORIOSINTEGRAMFD()';
var
  vCdComponente : String;
  vStatus : Real;
  viParams, voParams, vDsSerie : String;
begin
  vCdComponente := '';

  if (itemXml('PADRAO_ECF', PARAM_GLB) = <PADRAO_BEMATECH> ) or (itemXml('PADRAO_ECF', PARAM_GLB) = '') then begin
    vCdComponente := 'ECFSVCO002';
  end else if (itemXml('PADRAO_ECF', PARAM_GLB) = <PADRAO_AFRAC>) then begin
    vCdComponente := 'ECFSVCO005';
  end else if (itemXml('PADRAO_ECF', PARAM_GLB) = <PADRAO_YANCO>) then begin
    vCdComponente := 'ECFSVCO006';
  end else if (itemXml('PADRAO_ECF', PARAM_GLB) = <PADRAO_LOCAL>) then begin
    vCdComponente := 'ECFSVCO011';
  end else if (itemXml('PADRAO_ECF', PARAM_GLB) = <PADRAO_LOCALIMPFIM>) then begin
    vCdComponente := 'ECFSVCO011';
  end else begin
  end;
  if (itemXml('PADRAO_ECF', PARAM_GLB) = <PADRAO_BEMATECH> ) or (itemXml('PADRAO_ECF', PARAM_GLB) = '') then begin
    viParams := '';
    if (gInHomologacaoAM = True) then begin
      putitemXml(viParams, 'NM_FUNCAO', <ECF_NUMERO_SERIE_C>);
    end else begin
      putitemXml(viParams, 'NM_FUNCAO', <ECF_NUMERO_SERIE>);
    end;
    voParams := activateCmp('' + FloatToStr(vCdComponente',) + ' 'LeInformacaoImpressora', viParams); (*,,, *)
    if (xStatus < 0) then begin
      Result := voParams;
      return(-1); exit;
    end;
    vDsSerie := itemXmlF('NR_SERIE', voParams);
    clear_e(tFIS_ECF);
    putitem_e(tFIS_ECF, 'CD_SERIEFAB', vDsSerie);
    retrieve_e(tFIS_ECF);
    if (xStatus < 0) then begin
      Result := SetStatus(STS_ERROR, 'GEN0001', 'ECF inválida para o sistema - contate suporte!', '');
      return(-50);
    end;
  end;
  if (xStatus < 0) then begin
    Result := voParams;
    return(-1); exit;
  end;
  return(0); exit;
end;

//-----------------------------------------------------------
function T_ECFSVCO001.DOWNLOADMFD(pParams : String) : String;
//-----------------------------------------------------------
const
  cDS_METHOD = 'ADICIONAL=Operação: T_ECFSVCO001.DOWNLOADMFD()';
var
  vCdComponente : String;
  vStatus : Real;
  viParams, voParams, vDsSerie : String;
begin
  vCdComponente := '';

  if (itemXml('PADRAO_ECF', PARAM_GLB) = <PADRAO_BEMATECH> ) or (itemXml('PADRAO_ECF', PARAM_GLB) = '') then begin
    vCdComponente := 'ECFSVCO002';
  end else if (itemXml('PADRAO_ECF', PARAM_GLB) = <PADRAO_AFRAC>) then begin
    vCdComponente := 'ECFSVCO005';
  end else if (itemXml('PADRAO_ECF', PARAM_GLB) = <PADRAO_YANCO>) then begin
    vCdComponente := 'ECFSVCO006';
  end else if (itemXml('PADRAO_ECF', PARAM_GLB) = <PADRAO_LOCAL>) then begin
    vCdComponente := 'ECFSVCO011';
  end else if (itemXml('PADRAO_ECF', PARAM_GLB) = <PADRAO_LOCALIMPFIM>) then begin
    vCdComponente := 'ECFSVCO011';
  end else begin
  end;
  if (itemXml('PADRAO_ECF', PARAM_GLB) = <PADRAO_BEMATECH> ) or (itemXml('PADRAO_ECF', PARAM_GLB) = '') then begin
    viParams := '';
    if (gInHomologacaoAM = True) then begin
      putitemXml(viParams, 'NM_FUNCAO', <ECF_NUMERO_SERIE_C>);
    end else begin
      putitemXml(viParams, 'NM_FUNCAO', <ECF_NUMERO_SERIE>);
    end;
    voParams := activateCmp('' + FloatToStr(vCdComponente',) + ' 'LeInformacaoImpressora', viParams); (*,,, *)
    if (xStatus < 0) then begin
      Result := voParams;
      return(-1); exit;
    end;
    vDsSerie := itemXmlF('NR_SERIE', voParams);
    clear_e(tFIS_ECF);
    putitem_e(tFIS_ECF, 'CD_SERIEFAB', vDsSerie);
    retrieve_e(tFIS_ECF);
    if (xStatus < 0) then begin
      Result := SetStatus(STS_ERROR, 'GEN0001', 'ECF inválida para o sistema - contate suporte!', '');
      return(-50);
    end;
  end;
  if (xStatus < 0) then begin
    Result := voParams;
    return(-1); exit;
  end;
  return(0); exit;
end;

//------------------------------------------------------------------
function T_ECFSVCO001.DATAHORAIMPRESSORA(pParams : String) : String;
//------------------------------------------------------------------
const
  cDS_METHOD = 'ADICIONAL=Operação: T_ECFSVCO001.DATAHORAIMPRESSORA()';
var
  vCdComponente : String;
  vStatus : Real;
  viParams, voParams, vDsSerie : String;
begin
  vCdComponente := '';

  if (itemXml('PADRAO_ECF', PARAM_GLB) = <PADRAO_BEMATECH> ) or (itemXml('PADRAO_ECF', PARAM_GLB) = '') then begin
    vCdComponente := 'ECFSVCO002';
  end else if (itemXml('PADRAO_ECF', PARAM_GLB) = <PADRAO_AFRAC>) then begin
    vCdComponente := 'ECFSVCO005';
  end else if (itemXml('PADRAO_ECF', PARAM_GLB) = <PADRAO_YANCO>) then begin
    vCdComponente := 'ECFSVCO006';
  end else if (itemXml('PADRAO_ECF', PARAM_GLB) = <PADRAO_LOCAL>) then begin
    vCdComponente := 'ECFSVCO011';
  end else if (itemXml('PADRAO_ECF', PARAM_GLB) = <PADRAO_LOCALIMPFIM>) then begin
    vCdComponente := 'ECFSVCO011';
  end else begin
  end;
  if (itemXml('PADRAO_ECF', PARAM_GLB) = <PADRAO_BEMATECH> ) or (itemXml('PADRAO_ECF', PARAM_GLB) = '') then begin
    viParams := '';
    if (gInHomologacaoAM = True) then begin
      putitemXml(viParams, 'NM_FUNCAO', <ECF_NUMERO_SERIE_C>);
    end else begin
      putitemXml(viParams, 'NM_FUNCAO', <ECF_NUMERO_SERIE>);
    end;
    voParams := activateCmp('' + FloatToStr(vCdComponente',) + ' 'LeInformacaoImpressora', viParams); (*,,, *)
    if (xStatus < 0) then begin
      Result := voParams;
      return(-1); exit;
    end;
    vDsSerie := itemXmlF('NR_SERIE', voParams);
    clear_e(tFIS_ECF);
    putitem_e(tFIS_ECF, 'CD_SERIEFAB', vDsSerie);
    retrieve_e(tFIS_ECF);
    if (xStatus < 0) then begin
      Result := SetStatus(STS_ERROR, 'GEN0001', 'ECF inválida para o sistema - contate suporte!', '');
      return(-50);
    end;
  end;
  if (xStatus < 0) then begin
    Result := voParams;
    return(-1); exit;
  end;
  return(0); exit;
end;

//-------------------------------------------------------------
function T_ECFSVCO001.DATAMOVIMENTO(pParams : String) : String;
//-------------------------------------------------------------
const
  cDS_METHOD = 'ADICIONAL=Operação: T_ECFSVCO001.DATAMOVIMENTO()';
var
  vCdComponente : String;
  vStatus : Real;
  viParams, voParams, vDsSerie : String;
begin
  vCdComponente := '';

  if (itemXml('PADRAO_ECF', PARAM_GLB) = <PADRAO_BEMATECH> ) or (itemXml('PADRAO_ECF', PARAM_GLB) = '') then begin
    vCdComponente := 'ECFSVCO002';
  end else if (itemXml('PADRAO_ECF', PARAM_GLB) = <PADRAO_AFRAC>) then begin
    vCdComponente := 'ECFSVCO005';
  end else if (itemXml('PADRAO_ECF', PARAM_GLB) = <PADRAO_YANCO>) then begin
    vCdComponente := 'ECFSVCO006';
  end else if (itemXml('PADRAO_ECF', PARAM_GLB) = <PADRAO_LOCAL>) then begin
    vCdComponente := 'ECFSVCO011';
  end else if (itemXml('PADRAO_ECF', PARAM_GLB) = <PADRAO_LOCALIMPFIM>) then begin
    vCdComponente := 'ECFSVCO011';
  end else begin
  end;
  if (itemXml('PADRAO_ECF', PARAM_GLB) = <PADRAO_BEMATECH> ) or (itemXml('PADRAO_ECF', PARAM_GLB) = '') then begin
    viParams := '';
    if (gInHomologacaoAM = True) then begin
      putitemXml(viParams, 'NM_FUNCAO', <ECF_NUMERO_SERIE_C>);
    end else begin
      putitemXml(viParams, 'NM_FUNCAO', <ECF_NUMERO_SERIE>);
    end;
    voParams := activateCmp('' + FloatToStr(vCdComponente',) + ' 'LeInformacaoImpressora', viParams); (*,,, *)
    if (xStatus < 0) then begin
      Result := voParams;
      return(-1); exit;
    end;
    vDsSerie := itemXmlF('NR_SERIE', voParams);
    clear_e(tFIS_ECF);
    putitem_e(tFIS_ECF, 'CD_SERIEFAB', vDsSerie);
    retrieve_e(tFIS_ECF);
    if (xStatus < 0) then begin
      Result := SetStatus(STS_ERROR, 'GEN0001', 'ECF inválida para o sistema - contate suporte!', '');
      return(-50);
    end;
  end;
  if (xStatus < 0) then begin
    Result := voParams;
    return(-1); exit;
  end;
  return(0); exit;
end;

//--------------------------------------------------------------------------
function T_ECFSVCO001.DATAMOVIMENTOULTIMAREDUCAO(pParams : String) : String;
//--------------------------------------------------------------------------
const
  cDS_METHOD = 'ADICIONAL=Operação: T_ECFSVCO001.DATAMOVIMENTOULTIMAREDUCAO()';
var
  vCdComponente : String;
  vStatus : Real;
  viParams, voParams, vDsSerie : String;
begin
  vCdComponente := '';

  if (itemXml('PADRAO_ECF', PARAM_GLB) = <PADRAO_BEMATECH> ) or (itemXml('PADRAO_ECF', PARAM_GLB) = '') then begin
    vCdComponente := 'ECFSVCO002';
  end else if (itemXml('PADRAO_ECF', PARAM_GLB) = <PADRAO_AFRAC>) then begin
    vCdComponente := 'ECFSVCO005';
  end else if (itemXml('PADRAO_ECF', PARAM_GLB) = <PADRAO_YANCO>) then begin
    vCdComponente := 'ECFSVCO006';
  end else if (itemXml('PADRAO_ECF', PARAM_GLB) = <PADRAO_LOCAL>) then begin
    vCdComponente := 'ECFSVCO011';
  end else if (itemXml('PADRAO_ECF', PARAM_GLB) = <PADRAO_LOCALIMPFIM>) then begin
    vCdComponente := 'ECFSVCO011';
  end else begin
  end;
  if (xStatus < 0) then begin
    Result := voParams;
    return(-1); exit;
  end;
  return(0); exit;
end;

//-----------------------------------------------------------------------
function T_ECFSVCO001.ATIVADESATIVAGUILHOTINA(pParams : String) : String;
//-----------------------------------------------------------------------
const
  cDS_METHOD = 'ADICIONAL=Operação: T_ECFSVCO001.ATIVADESATIVAGUILHOTINA()';
var
  vCdComponente : String;
  vStatus : Real;
  viParams, voParams, vDsSerie : String;
begin
  vCdComponente := '';

  if (itemXml('PADRAO_ECF', PARAM_GLB) = <PADRAO_BEMATECH> ) or (itemXml('PADRAO_ECF', PARAM_GLB) = '') then begin
    vCdComponente := 'ECFSVCO002';
  end else if (itemXml('PADRAO_ECF', PARAM_GLB) = <PADRAO_AFRAC>) then begin
    vCdComponente := 'ECFSVCO005';
  end else if (itemXml('PADRAO_ECF', PARAM_GLB) = <PADRAO_YANCO>) then begin
    vCdComponente := 'ECFSVCO006';
  end else if (itemXml('PADRAO_ECF', PARAM_GLB) = <PADRAO_LOCAL>) then begin
    vCdComponente := 'ECFSVCO011';
  end else if (itemXml('PADRAO_ECF', PARAM_GLB) = <PADRAO_LOCALIMPFIM>) then begin
    vCdComponente := 'ECFSVCO011';
  end else begin
  end;
  if (xStatus < 0) then begin
    Result := voParams;
    return(-1); exit;
  end;

  return(0); exit;
end;

//---------------------------------------------------------------------
function T_ECFSVCO001.geraRegistrosCAT52MFD(pParams : String) : String;
//---------------------------------------------------------------------
const
  cDS_METHOD = 'ADICIONAL=Operação: T_ECFSVCO001.geraRegistrosCAT52MFD()';
var
  vCdComponente : String;
  vStatus : Real;
  viParams, voParams, vDsSerie : String;
begin
  vCdComponente := '';

  if (itemXml('PADRAO_ECF', PARAM_GLB) = <PADRAO_BEMATECH> ) or (itemXml('PADRAO_ECF', PARAM_GLB) = '') then begin
    vCdComponente := 'ECFSVCO002';
  end else if (itemXml('PADRAO_ECF', PARAM_GLB) = <PADRAO_AFRAC>) then begin
    vCdComponente := 'ECFSVCO005';
  end else if (itemXml('PADRAO_ECF', PARAM_GLB) = <PADRAO_YANCO>) then begin
    vCdComponente := 'ECFSVCO006';
  end else if (itemXml('PADRAO_ECF', PARAM_GLB) = <PADRAO_LOCAL>) then begin
    vCdComponente := 'ECFSVCO011';
  end else if (itemXml('PADRAO_ECF', PARAM_GLB) = <PADRAO_LOCALIMPFIM>) then begin
    vCdComponente := 'ECFSVCO011';
  end else begin
  end;
  if (itemXml('PADRAO_ECF', PARAM_GLB) = <PADRAO_BEMATECH> ) or (itemXml('PADRAO_ECF', PARAM_GLB) = '') then begin
    viParams := '';
    if (gInHomologacaoAM = True) then begin
      putitemXml(viParams, 'NM_FUNCAO', <ECF_NUMERO_SERIE_C>);
    end else begin
      putitemXml(viParams, 'NM_FUNCAO', <ECF_NUMERO_SERIE>);
    end;
    voParams := activateCmp('' + FloatToStr(vCdComponente',) + ' 'LeInformacaoImpressora', viParams); (*,,, *)
    if (xStatus < 0) then begin
      Result := voParams;
      return(-1); exit;
    end;
    vDsSerie := itemXmlF('NR_SERIE', voParams);
    clear_e(tFIS_ECF);
    putitem_e(tFIS_ECF, 'CD_SERIEFAB', vDsSerie);
    retrieve_e(tFIS_ECF);
    if (xStatus < 0) then begin
      Result := SetStatus(STS_ERROR, 'GEN0001', 'ECF inválida para o sistema - contate suporte!', '');
      return(-50);
    end;
  end;
  if (xStatus < 0) then begin
    Result := voParams;
    return(-1); exit;
  end;
  return(0); exit;

end;

//----------------------------------------------------------------------
function T_ECFSVCO001.abreRelatorioGerencial(pParams : String) : String;
//----------------------------------------------------------------------
const
  cDS_METHOD = 'ADICIONAL=Operação: T_ECFSVCO001.abreRelatorioGerencial()';
var
  vCdComponente : String;
  vStatus : Real;
  viParams, voParams, vDsSerie : String;
begin
  vCdComponente := '';

  if (itemXml('PADRAO_ECF', PARAM_GLB) = <PADRAO_BEMATECH> ) or (itemXml('PADRAO_ECF', PARAM_GLB) = '') then begin
    vCdComponente := 'ECFSVCO002';
  end else if (itemXml('PADRAO_ECF', PARAM_GLB) = <PADRAO_AFRAC>) then begin
    vCdComponente := 'ECFSVCO005';
  end else if (itemXml('PADRAO_ECF', PARAM_GLB) = <PADRAO_YANCO>) then begin
    vCdComponente := 'ECFSVCO006';
  end else if (itemXml('PADRAO_ECF', PARAM_GLB) = <PADRAO_LOCAL>) then begin
    vCdComponente := 'ECFSVCO011';
  end else if (itemXml('PADRAO_ECF', PARAM_GLB) = <PADRAO_LOCALIMPFIM>) then begin
    vCdComponente := 'ECFSVCO011';
  end else begin
  end;
  if (itemXml('PADRAO_ECF', PARAM_GLB) = <PADRAO_BEMATECH> ) or (itemXml('PADRAO_ECF', PARAM_GLB) = '') then begin
    viParams := '';
    if (gInHomologacaoAM = True) then begin
      putitemXml(viParams, 'NM_FUNCAO', <ECF_NUMERO_SERIE_C>);
    end else begin
      putitemXml(viParams, 'NM_FUNCAO', <ECF_NUMERO_SERIE>);
    end;
    voParams := activateCmp('' + FloatToStr(vCdComponente',) + ' 'LeInformacaoImpressora', viParams); (*,,, *)
    if (xStatus < 0) then begin
      Result := voParams;
      return(-1); exit;
    end;
    vDsSerie := itemXmlF('NR_SERIE', voParams);
    clear_e(tFIS_ECF);
    putitem_e(tFIS_ECF, 'CD_SERIEFAB', vDsSerie);
    retrieve_e(tFIS_ECF);
    if (xStatus < 0) then begin
      Result := SetStatus(STS_ERROR, 'GEN0001', 'ECF inválida para o sistema - contate suporte!', '');
      return(-50);
    end;
  end;
  if (xStatus < 0) then begin
    Result := voParams;
    return(-1); exit;
  end;
  return(0); exit;
end;

//---------------------------------------------------------------
function T_ECFSVCO001.verificaTermica(pParams : String) : String;
//---------------------------------------------------------------
const
  cDS_METHOD = 'ADICIONAL=Operação: T_ECFSVCO001.verificaTermica()';
var
  vCdComponente : String;
  vStatus : Real;
  viParams, voParams, vDsSerie : String;
begin
  vCdComponente := '';

  if (itemXml('PADRAO_ECF', PARAM_GLB) = <PADRAO_BEMATECH> ) or (itemXml('PADRAO_ECF', PARAM_GLB) = '') then begin
    vCdComponente := 'ECFSVCO002';
  end else if (itemXml('PADRAO_ECF', PARAM_GLB) = <PADRAO_AFRAC>) then begin
    vCdComponente := 'ECFSVCO005';
  end else if (itemXml('PADRAO_ECF', PARAM_GLB) = <PADRAO_YANCO>) then begin
    vCdComponente := 'ECFSVCO006';
  end else if (itemXml('PADRAO_ECF', PARAM_GLB) = <PADRAO_LOCAL>) then begin
    vCdComponente := 'ECFSVCO011';
  end else if (itemXml('PADRAO_ECF', PARAM_GLB) = <PADRAO_LOCALIMPFIM>) then begin
    vCdComponente := 'ECFSVCO011';
  end else begin
  end;
  if (itemXml('PADRAO_ECF', PARAM_GLB) = <PADRAO_BEMATECH> ) or (itemXml('PADRAO_ECF', PARAM_GLB) = '') then begin
    viParams := '';
    if (gInHomologacaoAM = True) then begin
      putitemXml(viParams, 'NM_FUNCAO', <ECF_NUMERO_SERIE_C>);
    end else begin
      putitemXml(viParams, 'NM_FUNCAO', <ECF_NUMERO_SERIE>);
    end;
    voParams := activateCmp('' + FloatToStr(vCdComponente',) + ' 'LeInformacaoImpressora', viParams); (*,,, *)
    if (xStatus < 0) then begin
      Result := voParams;
      return(-1); exit;
    end;
    vDsSerie := itemXmlF('NR_SERIE', voParams);
    clear_e(tFIS_ECF);
    putitem_e(tFIS_ECF, 'CD_SERIEFAB', vDsSerie);
    retrieve_e(tFIS_ECF);
    if (xStatus < 0) then begin
      Result := SetStatus(STS_ERROR, 'GEN0001', 'ECF inválida para o sistema - contate suporte!', '');
      return(-50);
    end;
  end;
  if (xStatus < 0) then begin
    Result := voParams;
    return(-1); exit;
  end;
  return(0); exit;
end;

//---------------------------------------------------------------------------
function T_ECFSVCO001.LeituraMemoriaFiscalDataMFD(pParams : String) : String;
//---------------------------------------------------------------------------
const
  cDS_METHOD = 'ADICIONAL=Operação: T_ECFSVCO001.LeituraMemoriaFiscalDataMFD()';
var
  vCdComponente : String;
  vStatus : Real;
  viParams, voParams, vDsSerie : String;
begin
  vCdComponente := '';

  if (itemXml('PADRAO_ECF', PARAM_GLB) = <PADRAO_BEMATECH> ) or (itemXml('PADRAO_ECF', PARAM_GLB) = '') then begin
    vCdComponente := 'ECFSVCO002';
  end else if (itemXml('PADRAO_ECF', PARAM_GLB) = <PADRAO_AFRAC>) then begin
    vCdComponente := 'ECFSVCO005';
  end else if (itemXml('PADRAO_ECF', PARAM_GLB) = <PADRAO_YANCO>) then begin
    vCdComponente := 'ECFSVCO006';
  end else if (itemXml('PADRAO_ECF', PARAM_GLB) = <PADRAO_LOCAL>) then begin
    vCdComponente := 'ECFSVCO011';
  end else if (itemXml('PADRAO_ECF', PARAM_GLB) = <PADRAO_LOCALIMPFIM>) then begin
    vCdComponente := 'ECFSVCO011';
  end else begin
  end;
  if (itemXml('PADRAO_ECF', PARAM_GLB) = <PADRAO_BEMATECH> ) or (itemXml('PADRAO_ECF', PARAM_GLB) = '') then begin
    viParams := '';
    if (gInHomologacaoAM = True) then begin
      putitemXml(viParams, 'NM_FUNCAO', <ECF_NUMERO_SERIE_C>);
    end else begin
      putitemXml(viParams, 'NM_FUNCAO', <ECF_NUMERO_SERIE>);
    end;
    voParams := activateCmp('' + FloatToStr(vCdComponente',) + ' 'LeInformacaoImpressora', viParams); (*,,, *)
    if (xStatus < 0) then begin
      Result := voParams;
      return(-1); exit;
    end;
    vDsSerie := itemXmlF('NR_SERIE', voParams);
    clear_e(tFIS_ECF);
    putitem_e(tFIS_ECF, 'CD_SERIEFAB', vDsSerie);
    retrieve_e(tFIS_ECF);
    if (xStatus < 0) then begin
      Result := SetStatus(STS_ERROR, 'GEN0001', 'ECF inválida para o sistema - contate suporte!', '');
      return(-50);
    end;
  end;
  if (xStatus < 0) then begin
    Result := voParams;
    return(-1); exit;
  end;
  return(0); exit;
end;

//------------------------------------------------------------------------------
function T_ECFSVCO001.LeituraMemoriaFiscalReducaoMFD(pParams : String) : String;
//------------------------------------------------------------------------------
const
  cDS_METHOD = 'ADICIONAL=Operação: T_ECFSVCO001.LeituraMemoriaFiscalReducaoMFD()';
var
  vCdComponente : String;
  vStatus : Real;
  viParams, voParams, vDsSerie : String;
begin
  vCdComponente := '';

  if (itemXml('PADRAO_ECF', PARAM_GLB) = <PADRAO_BEMATECH> ) or (itemXml('PADRAO_ECF', PARAM_GLB) = '') then begin
    vCdComponente := 'ECFSVCO002';
  end else if (itemXml('PADRAO_ECF', PARAM_GLB) = <PADRAO_AFRAC>) then begin
    vCdComponente := 'ECFSVCO005';
  end else if (itemXml('PADRAO_ECF', PARAM_GLB) = <PADRAO_YANCO>) then begin
    vCdComponente := 'ECFSVCO006';
  end else if (itemXml('PADRAO_ECF', PARAM_GLB) = <PADRAO_LOCAL>) then begin
    vCdComponente := 'ECFSVCO011';
  end else if (itemXml('PADRAO_ECF', PARAM_GLB) = <PADRAO_LOCALIMPFIM>) then begin
    vCdComponente := 'ECFSVCO011';
  end else begin
  end;
  if (itemXml('PADRAO_ECF', PARAM_GLB) = <PADRAO_BEMATECH> ) or (itemXml('PADRAO_ECF', PARAM_GLB) = '') then begin
    viParams := '';
    if (gInHomologacaoAM = True) then begin
      putitemXml(viParams, 'NM_FUNCAO', <ECF_NUMERO_SERIE_C>);
    end else begin
      putitemXml(viParams, 'NM_FUNCAO', <ECF_NUMERO_SERIE>);
    end;
    voParams := activateCmp('' + FloatToStr(vCdComponente',) + ' 'LeInformacaoImpressora', viParams); (*,,, *)
    if (xStatus < 0) then begin
      Result := voParams;
      return(-1); exit;
    end;
    vDsSerie := itemXmlF('NR_SERIE', voParams);
    clear_e(tFIS_ECF);
    putitem_e(tFIS_ECF, 'CD_SERIEFAB', vDsSerie);
    retrieve_e(tFIS_ECF);
    if (xStatus < 0) then begin
      Result := SetStatus(STS_ERROR, 'GEN0001', 'ECF inválida para o sistema - contate suporte!', '');
      return(-50);
    end;
  end;
  if (xStatus < 0) then begin
    Result := voParams;
    return(-1); exit;
  end;
  return(0); exit;
end;

//-------------------------------------------------------------------------------
function T_ECFSVCO001.leMemoriaFiscalSerialReducaoMFD(pParams : String) : String;
//-------------------------------------------------------------------------------
const
  cDS_METHOD = 'ADICIONAL=Operação: T_ECFSVCO001.leMemoriaFiscalSerialReducaoMFD()';
var
  vCdComponente : String;
  vStatus : Real;
  viParams, voParams, vDsSerie : String;
begin
  vCdComponente := '';

  if (itemXml('PADRAO_ECF', PARAM_GLB) = <PADRAO_BEMATECH> ) or (itemXml('PADRAO_ECF', PARAM_GLB) = '') then begin
    vCdComponente := 'ECFSVCO002';
  end else if (itemXml('PADRAO_ECF', PARAM_GLB) = <PADRAO_AFRAC>) then begin
    vCdComponente := 'ECFSVCO005';
  end else if (itemXml('PADRAO_ECF', PARAM_GLB) = <PADRAO_YANCO>) then begin
    vCdComponente := 'ECFSVCO006';
  end else if (itemXml('PADRAO_ECF', PARAM_GLB) = <PADRAO_LOCAL>) then begin
    vCdComponente := 'ECFSVCO011';
  end else if (itemXml('PADRAO_ECF', PARAM_GLB) = <PADRAO_LOCALIMPFIM>) then begin
    vCdComponente := 'ECFSVCO011';
  end else begin
  end;
  if (itemXml('PADRAO_ECF', PARAM_GLB) = <PADRAO_BEMATECH> ) or (itemXml('PADRAO_ECF', PARAM_GLB) = '') then begin
    viParams := '';
    if (gInHomologacaoAM = True) then begin
      putitemXml(viParams, 'NM_FUNCAO', <ECF_NUMERO_SERIE_C>);
    end else begin
      putitemXml(viParams, 'NM_FUNCAO', <ECF_NUMERO_SERIE>);
    end;
    voParams := activateCmp('' + FloatToStr(vCdComponente',) + ' 'LeInformacaoImpressora', viParams); (*,,, *)
    if (xStatus < 0) then begin
      Result := voParams;
      return(-1); exit;
    end;
    vDsSerie := itemXmlF('NR_SERIE', voParams);
    clear_e(tFIS_ECF);
    putitem_e(tFIS_ECF, 'CD_SERIEFAB', vDsSerie);
    retrieve_e(tFIS_ECF);
    if (xStatus < 0) then begin
      Result := SetStatus(STS_ERROR, 'GEN0001', 'ECF inválida para o sistema - contate suporte!', '');
      return(-50);
    end;
  end;
  if (xStatus < 0) then begin
    Result := voParams;
    return(-1); exit;
  end;
  return(0); exit;
end;

//----------------------------------------------------------------------------
function T_ECFSVCO001.leMemoriaFiscalSerialDataMFD(pParams : String) : String;
//----------------------------------------------------------------------------
const
  cDS_METHOD = 'ADICIONAL=Operação: T_ECFSVCO001.leMemoriaFiscalSerialDataMFD()';
var
  vCdComponente : String;
  vStatus : Real;
  viParams, voParams, vDsSerie : String;
begin
  vCdComponente := '';

  if (itemXml('PADRAO_ECF', PARAM_GLB) = <PADRAO_BEMATECH> ) or (itemXml('PADRAO_ECF', PARAM_GLB) = '') then begin
    vCdComponente := 'ECFSVCO002';
  end else if (itemXml('PADRAO_ECF', PARAM_GLB) = <PADRAO_AFRAC>) then begin
    vCdComponente := 'ECFSVCO005';
  end else if (itemXml('PADRAO_ECF', PARAM_GLB) = <PADRAO_YANCO>) then begin
    vCdComponente := 'ECFSVCO006';
  end else if (itemXml('PADRAO_ECF', PARAM_GLB) = <PADRAO_LOCAL>) then begin
    vCdComponente := 'ECFSVCO011';
  end else if (itemXml('PADRAO_ECF', PARAM_GLB) = <PADRAO_LOCALIMPFIM>) then begin
    vCdComponente := 'ECFSVCO011';
  end else begin
  end;
  if (itemXml('PADRAO_ECF', PARAM_GLB) = <PADRAO_BEMATECH> ) or (itemXml('PADRAO_ECF', PARAM_GLB) = '') then begin
    viParams := '';
    if (gInHomologacaoAM = True) then begin
      putitemXml(viParams, 'NM_FUNCAO', <ECF_NUMERO_SERIE_C>);
    end else begin
      putitemXml(viParams, 'NM_FUNCAO', <ECF_NUMERO_SERIE>);
    end;
    voParams := activateCmp('' + FloatToStr(vCdComponente',) + ' 'LeInformacaoImpressora', viParams); (*,,, *)
    if (xStatus < 0) then begin
      Result := voParams;
      return(-1); exit;
    end;
    vDsSerie := itemXmlF('NR_SERIE', voParams);
    clear_e(tFIS_ECF);
    putitem_e(tFIS_ECF, 'CD_SERIEFAB', vDsSerie);
    retrieve_e(tFIS_ECF);
    if (xStatus < 0) then begin
      Result := SetStatus(STS_ERROR, 'GEN0001', 'ECF inválida para o sistema - contate suporte!', '');
      return(-50);
    end;
  end;
  if (xStatus < 0) then begin
    Result := voParams;
    return(-1); exit;
  end;
  return(0); exit;
end;

//------------------------------------------------------------
function T_ECFSVCO001.geraAtoCotep(pParams : String) : String;
//------------------------------------------------------------
const
  cDS_METHOD = 'ADICIONAL=Operação: T_ECFSVCO001.geraAtoCotep()';
var
  vCdComponente : String;
  vStatus : Real;
  viParams, voParams, vDsSerie, vTpDownload : String;
begin
  viParams := '';
  vTpDownload := itemXmlF('TP_DOWNLOAD', pParams);
  vCdComponente := '';

  if (itemXml('PADRAO_ECF', PARAM_GLB) = <PADRAO_BEMATECH> ) or (itemXml('PADRAO_ECF', PARAM_GLB) = '') then begin
    vCdComponente := 'ECFSVCO002';
  end else if (itemXml('PADRAO_ECF', PARAM_GLB) = <PADRAO_AFRAC>) then begin
    vCdComponente := 'ECFSVCO005';
  end else if (itemXml('PADRAO_ECF', PARAM_GLB) = <PADRAO_YANCO>) then begin
    vCdComponente := 'ECFSVCO006';
  end else if (itemXml('PADRAO_ECF', PARAM_GLB) = <PADRAO_LOCAL>) then begin
    vCdComponente := 'ECFSVCO011';
  end else if (itemXml('PADRAO_ECF', PARAM_GLB) = <PADRAO_LOCALIMPFIM>) then begin
    vCdComponente := 'ECFSVCO011';
  end else begin
  end;
  if (itemXml('PADRAO_ECF', PARAM_GLB) = <PADRAO_BEMATECH> ) or (itemXml('PADRAO_ECF', PARAM_GLB) = '') then begin
    viParams := '';
    if (gInHomologacaoAM = True) then begin
      putitemXml(viParams, 'NM_FUNCAO', <ECF_NUMERO_SERIE_C>);
    end else begin
      putitemXml(viParams, 'NM_FUNCAO', <ECF_NUMERO_SERIE>);
    end;
    voParams := activateCmp('' + FloatToStr(vCdComponente',) + ' 'LeInformacaoImpressora', viParams); (*,,, *)
    if (xStatus < 0) then begin
      Result := voParams;
      return(-1); exit;
    end;
    vDsSerie := itemXmlF('NR_SERIE', voParams);
    clear_e(tFIS_ECF);
    putitem_e(tFIS_ECF, 'CD_SERIEFAB', vDsSerie);
    retrieve_e(tFIS_ECF);
    if (xStatus < 0) then begin
      Result := SetStatus(STS_ERROR, 'GEN0001', 'ECF inválida para o sistema - contate suporte!', '');
      return(-50);
    end;
  end;

  putitemXml(viParams, 'TP_DOWNLOAD', vTpDownload);
  if (xStatus < 0) then begin
    Result := voParams;
    return(-1); exit;
  end;

  return(0); exit;
end;

end.
