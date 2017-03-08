unit cFGRSVCO022;

interface

(* COMPONENTES 
  ADMSVCO009 / GERSVCO031 / 
*)        

uses
  Classes, SysUtils, DB,
  cServiceUnf, cDataSetUnf;

type
  T_FGRSVCO022 = class(TcServiceUnf)
  private
    tFGR_ENCERRAME,
    tFGR_LOGENCERR : TcDatasetUnf;
    function getParam(pParams : String = '') : String;
    function setEntidade(pParams : String = '') : String;

  protected
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;    
  published
    function validaFechamentoFinanceiro(pParams : String = '') : String;
    function gravaLogEncerramento(pParams : String = '') : String;
  end;

implementation

uses
  cActivate, cStatus, cFuncao, cXml, dModulo;

var
  gDtencerramento,
  gDtprocesso,
  gDtretroativa,
  gDtsistema : String;

//---------------------------------------------------------------
constructor T_FGRSVCO022.Create(AOwner: TComponent);
//---------------------------------------------------------------
begin
  inherited Create(AOwner);
  setEntidade('');
end;

//--------------------------------
destructor T_FGRSVCO022.Destroy;
//--------------------------------
begin
  inherited Destroy;
end;

//---------------------------------------------------------------
function T_FGRSVCO022.getParam(pParams : String) : String;
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
function T_FGRSVCO022.setEntidade(pParams : String) : String;
//---------------------------------------------------------------
begin
  tFGR_ENCERRAME := GetEntidade('FGR_ENCERRAME');
  tFGR_LOGENCERR := GetEntidade('FGR_LOGENCERR');
end;

//--------------------------------------------------------------------------
function T_FGRSVCO022.validaFechamentoFinanceiro(pParams : String) : String;
//--------------------------------------------------------------------------
const
  cDS_METHOD = 'ADICIONAL=Operação: T_FGRSVCO022.validaFechamentoFinanceiro()';
var
  vTpModelo, viParams, voParams : String;
  vDtRetroativa, vDtSistema, vDtProcesso : TDateTime;
begin
  if (itemXml('TP_MODELO', pParams) = '') then begin
    Result := SetStatus(STS_ERROR, 'GEN001', 'Favor informar o código do módulo a ser processado.', cDS_METHOD);
    return(-1); exit;
  end;
  if (itemXml('DT_PROCESSO', pParams) = '') then begin
    Result := SetStatus(STS_ERROR, 'GEN001', 'Favor informar a data do processo a ser executado.', cDS_METHOD);
    return(-1); exit;
  end;

  gDtretroativa := '';
  gDtsistema := itemXml('DT_SISTEMA', PARAM_GLB);
  gDtprocesso := itemXml('DT_PROCESSO', pParams);

  clear_e(tFGR_ENCERRAME);
  putitem_o(tFGR_ENCERRAME, 'TP_MODELO', itemXmlF('TP_MODELO', pParams));
  retrieve_e(tFGR_ENCERRAME);
  if (xStatus >= 0) then begin
    if (item_f('NR_DIAS', tFGR_ENCERRAME) > 0) then begin
      gDtretroativa := gDtsistema - item_f('NR_DIAS', tFGR_ENCERRAME);
      if (gDtprocesso < gDtretroativa) then begin
        viParams := '';
        putitemXml(viParams, 'CD_COMPONENTE', FGRSVCO022);
        putitemXml(viParams, 'DS_CAMPO', 'IN_ENCERRA_FINANC');
        putitemXml(viParams, 'CD_EMPRESA', itemXmlF('CD_EMPRESA', PARAM_GLB));
        putitemXml(viParams, 'CD_USUARIO', itemXmlF('CD_USUARIO', PARAM_GLB));
        putitemXml(viParams, 'VL_VALOR', '');
        voParams := activateCmp('ADMSVCO009', 'VerificaRestricao', viParams);
        if (xProcerror) then begin
          Result := SetStatus(STS_ERROR, xCdErro, xCtxErro, cDS_METHOD);
          return(-1); exit;
        end else if (xStatus < 0)
          Result := SetStatus(STS_AVISO, 'GEN001', 'Processo não permitido.Data do processo ' + gDtprocesso + ' é inferior a data de fechamento financeiro ' + gDtretroativa', + ' cDS_METHOD);
          viParams := '';
          putitemXml(viParams, 'CD_COMPONENTE', itemXmlF('CD_COMPONENTE', pParams));
          putitemXml(viParams, 'DS_COMPLEMENTO', itemXml('DS_COMPLEMENTO', pParams));
          putitemXml(viParams, 'TP_LOG', 1);
          voParams := gravaLogEncerramento(viParams); (* PARAM_GLB, viParams, voParams, xCdErro, xCtxErro *)
          if (xProcerror) then begin
            Result := SetStatus(STS_ERROR, xProcerror, xProcerrorcontext, cDS_METHOD);
          end else if (xStatus < 0)
            Result := SetStatus(STS_ERROR, xCdErro, xCtxErro, cDS_METHOD);
          end;
          return(-1); exit;
        end else begin
          viParams := '';
          putitemXml(viParams, 'CD_COMPONENTE', itemXmlF('CD_COMPONENTE', pParams));
          putitemXml(viParams, 'DS_COMPLEMENTO', itemXml('DS_COMPLEMENTO', pParams));
          putitemXml(viParams, 'TP_LOG', 2);
          voParams := gravaLogEncerramento(viParams); (* PARAM_GLB, viParams, voParams, xCdErro, xCtxErro *)
          if (xProcerror) then begin
            Result := SetStatus(STS_ERROR, xProcerror, xProcerrorcontext, cDS_METHOD);
            return(-1); exit;
          end else if (xStatus < 0)
            Result := SetStatus(STS_ERROR, xCdErro, xCtxErro, cDS_METHOD);
            return(-1); exit;
          end;
        end;
      end;
    end else begin

      if (gDtprocesso < item_a('DT_ENCERRAMENTO', tFGR_ENCERRAME)) then begin
        gDtencerramento := item_a('DT_ENCERRAMENTO', tFGR_ENCERRAME);

        viParams := '';
        putitemXml(viParams, 'CD_COMPONENTE', FGRSVCO022);
        putitemXml(viParams, 'DS_CAMPO', 'IN_ENCERRA_FINANC');
        putitemXml(viParams, 'CD_EMPRESA', itemXmlF('CD_EMPRESA', PARAM_GLB));
        putitemXml(viParams, 'CD_USUARIO', itemXmlF('CD_USUARIO', PARAM_GLB));
        putitemXml(viParams, 'VL_VALOR', '');
        voParams := activateCmp('ADMSVCO009', 'VerificaRestricao', viParams);
        if (xProcerror) then begin
          Result := SetStatus(STS_ERROR, xCdErro, xCtxErro, cDS_METHOD);
          return(-1); exit;
        end else if (xStatus < 0)
          Result := SetStatus(STS_AVISO, 'GEN001', 'Processo não permitido.Data do processo ' + gDtprocesso + ' é inferior a data de fechamento financeiro ' + gDtencerramento', + ' cDS_METHOD);
          viParams := '';
          putitemXml(viParams, 'CD_COMPONENTE', itemXmlF('CD_COMPONENTE', pParams));
          putitemXml(viParams, 'DS_COMPLEMENTO', itemXml('DS_COMPLEMENTO', pParams));
          putitemXml(viParams, 'TP_LOG', 1);
          voParams := gravaLogEncerramento(viParams); (* PARAM_GLB, viParams, voParams, xCdErro, xCtxErro *)
          if (xProcerror) then begin
            Result := SetStatus(STS_ERROR, xProcerror, xProcerrorcontext, cDS_METHOD);
          end else if (xStatus < 0)
            Result := SetStatus(STS_ERROR, xCdErro, xCtxErro, cDS_METHOD);
          end;
          return(-1); exit;
        end else begin
          viParams := '';
          putitemXml(viParams, 'CD_COMPONENTE', itemXmlF('CD_COMPONENTE', pParams));
          putitemXml(viParams, 'DS_COMPLEMENTO', itemXml('DS_COMPLEMENTO', pParams));
          putitemXml(viParams, 'TP_LOG', 2);
          voParams := gravaLogEncerramento(viParams); (* PARAM_GLB, viParams, voParams, xCdErro, xCtxErro *)
          if (xProcerror) then begin
            Result := SetStatus(STS_ERROR, xProcerror, xProcerrorcontext, cDS_METHOD);
            return(-1); exit;
          end else if (xStatus < 0)
            Result := SetStatus(STS_ERROR, xCdErro, xCtxErro, cDS_METHOD);
            return(-1); exit;
          end;
        end;
      end;
    end;
  end;

  return(0); exit;
End;

//--------------------------------------------------------------------
function T_FGRSVCO022.gravaLogEncerramento(pParams : String) : String;
//--------------------------------------------------------------------
const
  cDS_METHOD = 'ADICIONAL=Operação: T_FGRSVCO022.gravaLogEncerramento()';
var
  viParams, voParams : String;
begin
  if (itemXml('CD_COMPONENTE', pParams) = '') then begin
    Result := SetStatus(STS_AVISO, 'GEN001', 'Falta informar o componente para gravação do log de encerramento.', cDS_METHOD);
    return(-1); exit;
  end;
  if (itemXml('TP_LOG', pParams) = '') then begin
    Result := SetStatus(STS_AVISO, 'GEN001', 'Falta informar o tipo de log para gravação do log de encerramento.', cDS_METHOD);
    return(-1); exit;
  end;

  viParams := '';
  putitemXml(viParams, 'NM_ENTIDADE', 'FGR_LOGENCERRA');
  voParams := activateCmp('GERSVCO031', 'getNumSeq', viParams);
  if (xProcerror) then begin
    Result := SetStatus(STS_ERROR, xProcerror, xProcerrorcontext, cDS_METHOD);
    return(-1); exit;
  end else if (xStatus < 0)
    Result := SetStatus(STS_ERROR, xCdErro, xCtxErro, cDS_METHOD);
    return(-1); exit;
  end;

  creocc(tFGR_LOGENCERR, -1);
  putitem_e(tFGR_LOGENCERR, 'NR_SEQ', itemXmlF('NR_SEQUENCIA', voParams));
  putitem_e(tFGR_LOGENCERR, 'DT_TENTATIVA', itemXml('DT_SISTEMA', PARAM_GLB));
  putitem_e(tFGR_LOGENCERR, 'CD_COMPONENTE', itemXmlF('CD_COMPONENTE', pParams));
  putitem_e(tFGR_LOGENCERR, 'DS_COMPLEMENTO', itemXml('DS_COMPLEMENTO', pParams));
  putitem_e(tFGR_LOGENCERR, 'TP_LOG', itemXmlF('TP_LOG', pParams));
  putitem_e(tFGR_LOGENCERR, 'CD_OPERADOR', itemXmlF('CD_USUARIO', PARAM_GLB));
  putitem_e(tFGR_LOGENCERR, 'DT_CADASTRO', Now);

  voParams := tFGR_LOGENCERR.Salvar();
  if (xProcerror) then begin
    Result := SetStatus(STS_ERROR, xProcerror, xProcerrorcontext, cDS_METHOD);
    return(-1); exit;
  end else if (xStatus < 0)
    Result := SetStatus(STS_ERROR, xCdErro, xCtxErro, cDS_METHOD);
    return(-1); exit;
  end;

  return(0); exit;
End;

end.
