unit cSISSVCO007;

interface

(* COMPONENTES 
  SISSVCO007 / 
*)        

uses
  Classes, SysUtils, DB,
  cServiceUnf, cDataSetUnf;

type
  T_SISSVCO007 = class(TcServiceUnf)
  private

    function getParam(pParams : String = '') : String;
    function setEntidade(pParams : String = '') : String;
    function RedefinirContexto(pId : String; pContexto : String; pCdErro : String; pCtxErro : String) : String;
    function DefinirMensagem(pId : String; pContexto : String) : String;
    function DefinirInfo(pId : String; pContexto : String) : String;
    function DefinirInfoProcerror(pId : String; pContexto : String) : String;
    function DefinirInfoValidate(pId : String; pContexto : String) : String;
    function DefinirInfoSistema(pId : String; pContexto : String) : String;
    function DefinirStatus(pId : String; pContexto : String) : String;
    function IgnorarStatus(pId : String) : String;
    function SetarStatus(pTipo : String; pId : String; pContexto : String; pInfo : String) : String;
    function DefinirContexto(pTipo : String; pId : String; pContexto : String) : String;
    function ExibirMensagem(pId : String; pContexto : String) : String;
  protected
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;    
  published

  end;

implementation

uses
  cActivate, cStatus, cFuncao, cXml, dModulo;

var
  gxcs,
  gxlcs : String;

//---------------------------------------------------------------
constructor T_SISSVCO007.Create(AOwner: TComponent);
//---------------------------------------------------------------
begin
  inherited Create(AOwner);
  setEntidade('');
end;

//--------------------------------
destructor T_SISSVCO007.Destroy;
//--------------------------------
begin
  inherited Destroy;
end;

//---------------------------------------------------------------
function T_SISSVCO007.getParam(pParams : String) : String;
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
  xParam := activateCmp('ADMSVCO001', 'GetParametro', xParam);
  gUsaCondPgtoEspecial := itemXmlB('IN_USA_COND_PGTO_ESPECIAL', xParam);
  
  xParamEmp := '';
  putitem(xParamEmp, 'VL_MINIMO_PARCELA');
  xParamEmp := activateCmp('ADMSVCO001', 'GetParamEmpresa', piCdEmpresa, xParamEmp);
  gVlMinimoParcela := itemXmlF('VL_MINIMO_PARCELA', xParamEmp);  
  *)

  xParam := '';

  xParam := activateCmp('ADMSVCO001', 'GetParametro', xParam);


  xParamEmp := '';

  xParamEmp := activateCmp('ADMSVCO001', 'GetParamEmpresa', piCdEmpresa, xParamEmp);


end;

//---------------------------------------------------------------
function T_SISSVCO007.setEntidade(pParams : String) : String;
//---------------------------------------------------------------
begin

end;

//----------------------------------------------------------------------------------------------------------------------
function T_SISSVCO007.RedefinirContexto(pId : String; pContexto : String; pCdErro : String; pCtxErro : String) : String;
//----------------------------------------------------------------------------------------------------------------------
const
  cDS_METHOD = 'ADICIONAL=Operação: T_SISSVCO007.RedefinirContexto()';
begin
  voParams := DefinirStatus(viParams); (* pId, pContexto *)
  voParams := DefinirMensagem(viParams); (* pId, pContexto *)
  voParams := DefinirInfo(viParams); (* pId, pContexto *)
  pCdErro := itemXml('STATUS', pContexto);
  pCtxErro := pContexto;
  return (pCdErro);
end;

//-------------------------------------------------------------------------------
function T_SISSVCO007.DefinirMensagem(pId : String; pContexto : String) : String;
//-------------------------------------------------------------------------------
const
  cDS_METHOD = 'ADICIONAL=Operação: T_SISSVCO007.DefinirMensagem()';
var
  vId, vContexto, vDescricao : String;
begin
  putitemXml(pContexto, 'ID', pId);
  if (itemXml('CATEGORIA', pContexto) = '<STS_CATEGORIA_PROCERROR>') then begin
    voParams := PrcErroProc(viParams); (* pID, vDescricao *)
    putitemXml(pContexto, 'DESCRICAO', vDescricao);
  end else if (itemXml('DESCRICAO', pContexto) = '')
    putitemXml(pContexto, 'DESCRICAO', gtext('' + pId')) + ';
  end;
end;

//---------------------------------------------------------------------------
function T_SISSVCO007.DefinirInfo(pId : String; pContexto : String) : String;
//---------------------------------------------------------------------------
const
  cDS_METHOD = 'ADICIONAL=Operação: T_SISSVCO007.DefinirInfo()';
begin
  if (itemXml('CATEGORIA', pCONTEXTO) = '<STS_CATEGORIA_PROCERROR>') then begin
    voParams := DefinirInfoProcerror(viParams); (* pId, pContexto *)
  end else if (itemXml('CATEGORIA', pCONTEXTO) = '<STS_CATEGORIA_VALIdate>')
    voParams := DefinirInfoValidate(viParams); (* pId, pContexto *)
  end else if (itemXml('CATEGORIA', pCONTEXTO) = '<STS_CATEGORIA_SISTEMA>')
    voParams := DefinirInfoSistema(viParams); (* pId, pContexto *)
  end;
end;

//------------------------------------------------------------------------------------
function T_SISSVCO007.DefinirInfoProcerror(pId : String; pContexto : String) : String;
//------------------------------------------------------------------------------------
const
  cDS_METHOD = 'ADICIONAL=Operação: T_SISSVCO007.DefinirInfoProcerror()';
var
  vContexto,vMnem,vProcname,vTrigger,vLine,vAditional,vObject : String;
begin
  getitem/id vMnem, pContexto, 'MNEM';
  getitem/id vProcname, pContexto, 'PROCNAME';
  getitem/id vTrigger, pContexto, 'TRIGGER';
  getitem/id vLine, pContexto, 'LINE';
  getitem/id vAditional, pContexto, 'ADITIONAL';
  getitem/id vObject, pContexto, 'OBJECT';

  delitem(pContexto, 'MNEM');
  delitem(pContexto, 'PROCNAME');
  delitem(pContexto, 'TRIGGER');
  delitem(pContexto, 'LINE');
  delitem(pContexto, 'ADITIONAL');
  delitem(pContexto, 'OBJECT');

  putitemXml(vContexto, 'OBJETO', '' + vObject);
  putitemXml(vContexto, 'OPERACAO', '' + vProcname);
  putitemXml(vContexto, 'LINHA', '' + vLine);
  putitemXml(vContexto, 'ADICIONAL', '' + vAditional);
  putitemXml(pContexto, 'INFO', vContexto);
end;

//-----------------------------------------------------------------------------------
function T_SISSVCO007.DefinirInfoValidate(pId : String; pContexto : String) : String;
//-----------------------------------------------------------------------------------
const
  cDS_METHOD = 'ADICIONAL=Operação: T_SISSVCO007.DefinirInfoValidate()';
var
  vTopic, vOcc, vKey, vObject, vContexto : String;
begin
  getitem/id vTopic, pContexto, 'TOPIC';
  getitem/id vOcc, pContexto, 'OCC';
  getitem/id vKey, pContexto, 'KEY';
  getitem/id vObject, pContexto, 'OBJECT';

  delitem(pContexto, 'TOPIC');
  delitem(pContexto, 'OCC');
  delitem(pContexto, 'KEY');
  delitem(pContexto, 'OBJECT');

  putitemXml(vContexto, 'OBJETO', '' + vObject);
  putitemXml(vContexto, 'TOPICO', '' + vTopic);
  putitemXml(vContexto, 'OCORRENCIA', '' + vOcc);
  if (vKey) then begin
    putitemXml(vContexto, 'CHAVE', '' + vKey);
  end;

  putitemXml(pContexto, 'INFO', vContexto);
end;

//----------------------------------------------------------------------------------
function T_SISSVCO007.DefinirInfoSistema(pId : String; pContexto : String) : String;
//----------------------------------------------------------------------------------
const
  cDS_METHOD = 'ADICIONAL=Operação: T_SISSVCO007.DefinirInfoSistema()';
var
  vContexto : String;
begin
  putitemXml(vContexto, 'CAMPO', itemXml('CAMPO', pContexto));
  putitemXml(vContexto, 'ENTIDADE', itemXml('ENTIDADE', pContexto));
  putitemXml(vContexto, 'COMPONENTE', itemXml('COMPONENTE', pContexto));
  putitemXml(pContexto, 'INFO', vContexto);

end;

//-----------------------------------------------------------------------------
function T_SISSVCO007.DefinirStatus(pId : String; pContexto : String) : String;
//-----------------------------------------------------------------------------
const
  cDS_METHOD = 'ADICIONAL=Operação: T_SISSVCO007.DefinirStatus()';
var
  vTipo : String;
begin
  vTipo := itemXml('TIPO', pContexto);
  if (vtipo = <STS_DICA>) then begin
    putitemXml(pContexto, 'STATUS', 1);
  end else if (vTipo = STS_AVISO)
    putitemXml(pContexto, 'STATUS', 2);
  end else if (vtipo = <STS_INFO>)
    putitemXml(pContexto, 'STATUS', 3);
  end else if (vtipo = STS_ERROR)
    putitemXml(pContexto, 'STATUS', -1);
  end;
  return (itemXml('STATUS', pContexto));
end;

//---------------------------------------------------------
function T_SISSVCO007.IgnorarStatus(pId : String) : String;
//---------------------------------------------------------
const
  cDS_METHOD = 'ADICIONAL=Operação: T_SISSVCO007.IgnorarStatus()';
var
  vTipo : String;
begin
  case round(pId) of
  end;
  0 : begin
    return (1);
  end;
  0 : begin
    return(-1); exit;
  end;
  0 : begin
    return (1);
  end;
  0 : begin
    return (1);
  end;
  0 : begin
    return(-1); exit;
  else
    return(0); exit;
  end;
end;

//-----------------------------------------------------------------------------------------------------------
function T_SISSVCO007.SetarStatus(pTipo : String; pId : String; pContexto : String; pInfo : String) : String;
//-----------------------------------------------------------------------------------------------------------
const
  cDS_METHOD = 'ADICIONAL=Operação: T_SISSVCO007.SetarStatus()';
begin
  pContexto := pContexto + ';
  if (pId = -35) then begin
    if ('<gcomponenttype>' = <SVC>) then begin
      pid := xCdErro;
      pContexto := xCtxErro;
    end else begin
      pid := '';
      pContexto := '';
      return (xCdErro);
    end;
  end;

  voParams := activateCmp('SISSVCO007', 'IgnorarStatus', viParams); (*pId *)
  if (xStatus = 0) then begin
    voParams := DefinirContexto(viParams); (* pTipo, pId, pContexto *)
    if (xProcerror) then begin
    end else if (xStatus < 0)
    end else if (xStatus >= 0)
      voParams := activateCmp('SISSVCO007', 'RedefinirContexto', viParams); (*pid,pContexto,gxcs,gxlcs *)
      if (xProcerror) then begin
        putmess '' + xProcerror + ' - ' + xProcerrorcontext;
      end else begin
        voParams := ExibirMensagem(viParams); (* pId, pContexto *)
      end;
    end;
  end;

  return (xStatus);
end;

//-----------------------------------------------------------------------------------------------
function T_SISSVCO007.DefinirContexto(pTipo : String; pId : String; pContexto : String) : String;
//-----------------------------------------------------------------------------------------------
const
  cDS_METHOD = 'ADICIONAL=Operação: T_SISSVCO007.DefinirContexto()';
var
  vGlobal : String;
  vSessao,vCategoria,vUsuario,vComponente : String;
  vTipo,vTipoComponente : String;
  vData,vHora : String;
  vCampo,vEntidade : String;
begin
  if (pId = '') then begin
    pId := itemXml('ID', pContexto);
    if (pId = '') then begin
        pId := 8006;
    end;
  end;
  #if ('<gcomponenttype>' = <FRM>) then begin
    vGlobal := PARAM_GLB;
  #end else begin

  #end;

  if (pID < 0) then begin
    vCategoria := '<STS_CATEGORIA_PROCERROR>';
  end else if (itemXml('CONTEXT', pContexto) = 'VALIDATION')
    vCategoria := '<STS_CATEGORIA_VALIdate>';
  end else begin
    vCategoria := '<STS_CATEGORIA_SISTEMA>';
  end;
  if (pTipo = '') then begin
    pTipo := itemXml('TIPO', pContexto);
  end;
  vTIPO := pTipo;

  vDATA := Date;

  vHORA := Time;

  vUSUARIO := itemXml('ID_USR', vGLOBAL);

  vCOMPONENTE := itemXml('COMPONENT', pContexto);
  if (vCOMPONENTE = '') then begin
    vCOMPONENTE := SISSVCO007;
  end;

  vTIPOCOMPONENTE := gcomponenttype(vComponente);

  vCampo := gfieldname;

  vEntidade := gentname;

  putitemXml(pContexto, 'TIPO', vTipo);
  putitemXml(pContexto, 'DATA', vData);
  putitemXml(pContexto, 'HORA', vHora);
  putitemXml(pContexto, 'USUARIO', vUsuario);
  putitemXml(pContexto, 'CATEGORIA', vCategoria);
  putitemXml(pContexto, 'COMPONENTE', vComponente);
  putitemXml(pContexto, 'ENTIDADE', vEntidade);
  putitemXml(pContexto, 'CAMPO', vCampo);
  putitemXml(pContexto, 'TIPO_COMPONENTE', vTipoComponente);

end;

//------------------------------------------------------------------------------
function T_SISSVCO007.ExibirMensagem(pId : String; pContexto : String) : String;
//------------------------------------------------------------------------------
const
  cDS_METHOD = 'ADICIONAL=Operação: T_SISSVCO007.ExibirMensagem()';
var
  vDescricao, vTipo, vObjeto, vInfo, vDica, vLog, vAdicional, vDsTipo : String;
begin
  vTipo := itemXml('TIPO', pContexto);
  vDescricao := itemXml('DESCRICAO', pContexto);
  vInfo := itemXml('INFO', pContexto);
  vDica := itemXml('DICA', pContexto);
  vAdicional := itemXml('ADICIONAL', pContexto);
  vLog := itemXml('LOG', pContexto);
  vObjeto := itemXml('OBJETO', vInfo);

  if (vTipo = <STS_DICA>) then begin
    vDsTipo := 'DICA';
    #if ('<gcomponenttype>' = <FRM>) then begin
      message/hint '' + pId + ' - ' + vDescricao + ' ' + vAdicional + ' ' + vDica;
    #end;
    xStatus := <STS_DICA>;
  end else if (vTipo = STS_AVISO)
    vDsTipo := 'AVISO';
    #if ('<gcomponenttype>' = <FRM>) then begin
      message/warning '' + pId + ' - ' + vDescricao + ' ' + vAdicional;
    #end;
    putmess '' + vDsTipo-> + ' ' + pId;
    putmess '    DESCR    -> ' + vDescricao;
    if (vAdicional <> '') putmess '    ADIC    -> ' + vAdicional' + ' then begin
    if (vInfo <> '')      putmess '    INFO    -> ' + vInfo' + ' then begin
    if (vLog  <> '')      putmess '    LOG    -> ' + vLog' + ' then begin
    putmess ' ';
    xStatus := STS_AVISO;
  end else if (vTipo = <STS_INFO>)
    vDsTipo := 'INFO';
    #if ('<gcomponenttype>' = <FRM>) then begin
      message/info '' + pId + ' - ' + vDescricao + ' ' + vAdicional;
    #end;
    putmess '' + vDsTipo-> + ' ' + pId;
    putmess '    DESCR    -> ' + vDescricao;
    if (vAdicional <> '') putmess '    ADIC    -> ' + vAdicional' + ' then begin
    if (vInfo <> '')      putmess '    INFO    -> ' + vInfo' + ' then begin
    if (vLog  <> '')      putmess '    LOG    -> ' + vLog' + ' then begin
    putmess ' ';
    xStatus := <STS_INFO>;
  end else if (vTipo = <STS_LOG>)
    vDsTipo := 'LOG';
    putmess '' + vDsTipo-> + ' ' + pId;
    putmess '    DESCR    -> ' + vDescricao;
    if (vAdicional <> '') putmess '    ADIC    -> ' + vAdicional' + ' then begin
    if (vInfo <> '')      putmess '    INFO    -> ' + vInfo' + ' then begin
    if (vLog  <> '')      putmess '    LOG    -> ' + vLog' + ' then begin
    putmess ' ';
    xStatus := <STS_LOG>;
  end else if (vTipo = STS_ERROR)
    vDsTipo := 'ERRO';
    if (pId = '-50') or (pId = '-58') or (pId = '-59') then begin
      vDescricao := 'Componente em desenvolvimento!';
    end;
    #if ('<gcomponenttype>' = <FRM>) then begin
      message/error '' + pId + ' - ' + vDescricao + ' ' + vAdicional;
    #end;
    putmess '' + vDsTipo-> + ' ' + pId;
    putmess '    DESCR    -> ' + vDescricao;
    if (vAdicional <> '') putmess '    ADIC    -> ' + vAdicional' + ' then begin
    if (vInfo <> '')      putmess '    INFO    -> ' + vInfo' + ' then begin
    if (vLog  <> '')      putmess '    LOG    -> ' + vLog' + ' then begin
    putmess ' ';
    xStatus := STS_ERROR;
  end;
  #if ('<gcomponenttype>' = <FRM>) then begin
    if (vDica <> '')and (vTipo <> <STS_DICA>) message/hint vDica then begin
  #end;

  xCdErro := pID;
  xCtxErro := pContexto;
  $xcs$ := pId;
  $xlcs$ := pContexto;

  return (xStatus);
end;

end.
