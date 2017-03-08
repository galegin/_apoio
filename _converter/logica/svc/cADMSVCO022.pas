unit cADMSVCO022;

interface

(* COMPONENTES 
  ADMSVCO001 / GERSVCO031 / 
*)        

uses
  Classes, SysUtils, DB,
  cServiceUnf, cDataSetUnf;

type
  T_ADMSVCO022 = class(TcServiceUnf)
  private
    tADM_LNCMP,
    tADM_LNLOG,
    tADM_LNUSU : TcDatasetUnf;
    function getParam(pParams : String = '') : String;
    function setEntidade(pParams : String = '') : String;
  protected
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;    
  published
    function gravaLog(pParams : String = '') : String;
  end;

implementation

uses
  cADMSVCO001,
  cActivate, cStatus, cFuncao, cXml, dModulo;

var
  gTpLog : String;

//---------------------------------------------------------------
constructor T_ADMSVCO022.Create(AOwner: TComponent);
//---------------------------------------------------------------
begin
  inherited Create(AOwner);
  setEntidade('');
end;

//--------------------------------
destructor T_ADMSVCO022.Destroy;
//--------------------------------
begin
  inherited Destroy;
end;

//---------------------------------------------------------------
function T_ADMSVCO022.getParam(pParams : String = '') : String;
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
  putitem(xParam, 'IN_USA_LOG_NAVEGACAO');

  xParam := T_ADMSVCO001.GetParametro(xParam);

  gTpLog := itemXml('IN_USA_LOG_NAVEGACAO', xParam);

  xParamEmp := '';

  xParamEmp := T_ADMSVCO001.GetParamEmpresa(piCdEmpresa, xParamEmp);


end;

//---------------------------------------------------------------
function T_ADMSVCO022.setEntidade(pParams : String = '') : String;
//---------------------------------------------------------------
begin
  tADM_LNCMP := GetEntidade('ADM_LNCMP');
  tADM_LNLOG := GetEntidade('ADM_LNLOG');
  tADM_LNUSU := GetEntidade('ADM_LNUSU');
end;

//--------------------------------------------------------
function T_ADMSVCO022.gravaLog(pParams : String) : String;
//--------------------------------------------------------
const
  cDS_METHOD = 'ADICIONAL=Operação: T_ADMSVCO022.gravaLog()';
var
  vCdComponente, viParams, voParams : String;
  vCdUsuario, vNrSequencia, vCdNivel, vTpLog, vNrSessao : Real;
  vInGravar : Boolean;
begin
  vCdUsuario := itemXmlF('CD_USUARIO', pParams);
  vCdComponente := itemXmlF('CD_COMPONENTE', pParams);
  vCdNivel := itemXmlF('CD_NIVEL', pParams);
  vTpLog := itemXmlF('TP_LOG', pParams);
  vNrSessao := itemXmlF('NR_SESSAO', gModulo.gParamUsr);

  getParams(pParams); (* 'gravaLog' *)
  if (xStatus < 0) then begin
    return(-1); exit;
  end;

  vInGravar := True;

  if (vTpLog = 5)  and (gTpLog = 1) then begin
    vInGravar := False;
  end else if (vTpLog = 5)  and (gTpLog = 2) then begin
    clear_e(tADM_LNUSU);
    putitem_e(tADM_LNUSU, 'CD_USUARIO', vCdUsuario);
    retrieve_e(tADM_LNUSU);
    if (xStatus >= 0) then begin
      if (item_b('IN_TODOS', tADM_LNUSU) <> True) then begin
        clear_e(tADM_LNCMP);
        putitem_e(tADM_LNCMP, 'CD_COMPONENTE', vCdComponente);
        retrieve_e(tADM_LNCMP);
        if (xStatus < 0) then begin
          vInGravar := False;
        end;
      end;
    end else begin
      vInGravar := False;
    end;
  end else if (vTpLog = 5)  and (gTpLog = 3) then begin
    clear_e(tADM_LNUSU);
    putitem_e(tADM_LNUSU, 'CD_USUARIO', vCdUsuario);
    retrieve_e(tADM_LNUSU);
    if (xStatus < 0) then begin
      clear_e(tADM_LNCMP);
      putitem_e(tADM_LNCMP, 'CD_COMPONENTE', vCdComponente);
      retrieve_e(tADM_LNCMP);
      if (xStatus >= 0) then begin
        if (item_b('IN_TODOS', tADM_LNCMP) <> True) then begin
          vInGravar := False;
        end;
      end else begin
        vInGravar := False;
      end;
    end;
  end else if (vTpLog = 5)  and (gTpLog = 4) then begin
    clear_e(tADM_LNCMP);
    putitem_e(tADM_LNCMP, 'CD_COMPONENTE', vCdComponente);
    retrieve_e(tADM_LNCMP);
    if (xStatus < 0) then begin
      vInGravar := False;
    end;
  end;
  if (vInGravar = True) then begin
    vNrSequencia := 1;

      viParams := '';

      putitemXml(viParams, 'NM_ENTIDADE', 'ADM_LNLOG');
      putitemXml(viParams, 'NM_ATRIBUTO', 'NR_SEQUENCIA');
      voParams := activateCmp('GERSVCO031', 'getNumSeq', viParams); (*,,,, *)
      if (xStatus < 0) then begin
        Result := voParams;
        return(-1); exit;
      end;

      vNrSequencia := itemXmlF('NR_SEQUENCIA', voParams);

    clear_e(tADM_LNLOG);
    creocc(tADM_LNLOG, -1);
    putitem_e(tADM_LNLOG, 'DT_EVENTO', Now);
    putitem_e(tADM_LNLOG, 'NR_SEQUENCIA', vNrSequencia);
    putitem_e(tADM_LNLOG, 'CD_OPERADOR', itemXmlF('CD_USUARIO', PARAM_GLB));
    putitem_e(tADM_LNLOG, 'DT_CADASTRO', Now);
    putitem_e(tADM_LNLOG, 'CD_USUARIO', vCdUsuario);
    putitem_e(tADM_LNLOG, 'CD_COMPONENTE', vCdComponente);
    putitem_e(tADM_LNLOG, 'CD_NIVEL', vCdNivel);
    putitem_e(tADM_LNLOG, 'TP_LOG', vTpLog);
    putitem_e(tADM_LNLOG, 'VL_PARAMETRO', gTpLog);
    putitem_e(tADM_LNLOG, 'NR_SESSAO', vNrSessao);

    voParams := tADM_LNLOG.Salvar();
    if (xStatus < 0) then begin
      Result := voParams;
      return(-1); exit;
    end;
  end;

  return(0); exit;
end;

end.
