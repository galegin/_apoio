unit cADMSVCO010;

interface

        

uses
  Classes, SysUtils, DB,
  cServiceUnf, cDataSetUnf;

type
  T_ADMSVCO010 = class(TcServiceUnf)
  private
    tADM_RESTRICAO : TcDatasetUnf;
    function getParam(pParams : String = '') : String;
    function setEntidade(pParams : String = '') : String;
  protected
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;    
  published
    function gravaLogRestricaoCommit(pParams : String = '') : String;
  end;

implementation

uses
  cADMSVCO001,
  cActivate, cStatus, cFuncao, cXml, dModulo;

var


//---------------------------------------------------------------
constructor T_ADMSVCO010.Create(AOwner: TComponent);
//---------------------------------------------------------------
begin
  inherited Create(AOwner);
  setEntidade('');
end;

//--------------------------------
destructor T_ADMSVCO010.Destroy;
//--------------------------------
begin
  inherited Destroy;
end;

//---------------------------------------------------------------
function T_ADMSVCO010.getParam(pParams : String = '') : String;
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
function T_ADMSVCO010.setEntidade(pParams : String = '') : String;
//---------------------------------------------------------------
begin
  tADM_RESTRICAO := GetEntidade('ADM_RESTRICAO');
end;

//-----------------------------------------------------------------------
function T_ADMSVCO010.gravaLogRestricaoCommit(pParams : String) : String;
//-----------------------------------------------------------------------
const
  cDS_METHOD = 'ADICIONAL=Operação: T_ADMSVCO010.gravaLogRestricaoCommit()';
var
  (* string poParms :OUT *)
  vCdComponente, vDsCampo, vCdEmpresa, vCdUsuario : String;
  vVlValor, vVlNovo, vVlAtual, vTpRestricaoLog, vInicioOriginal, vFimOriginal, vCdUsuarioLib : Real;
  vCdUsuarioValidado, vDsPermite, vDsAux : String;
begin
  vCdComponente := itemXmlF('CD_COMPONENTE', pParams);
  vDsCampo := itemXml('DS_CAMPO', pParams);
  vCdEmpresa := itemXmlF('CD_EMPRESA', pParams);
  vCdUsuario := itemXmlF('CD_USUARIO', pParams);
  vVlValor := itemXmlF('VL_VALOR', pParams);
  vVlNovo := itemXmlF('VL_NOVO', pParams);
  vVlAtual := itemXmlF('VL_ATUAL', pParams);
  vTpRestricaoLog := itemXmlF('TP_RESTRICAOLOG', pParams);
  vInicioOriginal := itemXmlF('VL_INICIOORIGNAL', pParams);
  vFimOriginal := itemXmlF('VL_FIMORIGINAL', pParams);
  vCdUsuarioLib := itemXmlF('CD_USUARIOLIB', pParams);
  vDsAux := itemXml('DS_AUX', pParams);

  xStatus := -7;
  while (xStatus := -7) do begin
    clear_e(tADM_RESTRICAO);
    creocc(tADM_RESTRICAO, -1);
    putitem_e(tADM_RESTRICAO, 'DT_RESTRICAO', itemXml('DT_SISTEMA', PARAM_GLB));
    putitem_e(tADM_RESTRICAO, 'HR_RESTRICAO', gclock);
    putitem_e(tADM_RESTRICAO, 'CD_COMPONENTE', vCdComponente);
    putitem_e(tADM_RESTRICAO, 'DS_CAMPO', vDsCampo);
    putitem_e(tADM_RESTRICAO, 'CD_EMPRESA', vCdEmpresa);
    putitem_e(tADM_RESTRICAO, 'CD_USUARIO', vCdUsuario);
    retrieve_o(tADM_RESTRICAO);
    if (xStatus = 0) then begin
      putitem_e(tADM_RESTRICAO, 'CD_OPERADOR', itemXmlF('CD_USUARIO', PARAM_GLB));
      putitem_e(tADM_RESTRICAO, 'DT_CADASTRO', Now);
      putitem_e(tADM_RESTRICAO, 'TP_RESTRICAOLOG', vTpRestricaoLog);
      putitem_e(tADM_RESTRICAO, 'CD_USUARIOLIB', vCdUsuarioLib);
      putitem_e(tADM_RESTRICAO, 'VL_INICIOORIGINAL', vInicioOriginal);
      putitem_e(tADM_RESTRICAO, 'VL_FIMORIGINAL', vFimOriginal);
      putitem_e(tADM_RESTRICAO, 'VL_DIFERENCA', vVlValor);
      putitem_e(tADM_RESTRICAO, 'VL_NOVO', vVlNovo);
      putitem_e(tADM_RESTRICAO, 'VL_ATUAL', vVlAtual);
      putitem_e(tADM_RESTRICAO, 'DS_AUX', vDsAux);
      voParams := tADM_RESTRICAO.Salvar();
      if (xStatus < 0) then begin
        Result := voParams;
        return(-1); exit;
      end;
      break;
    end;
  end;

  commit;

end;

end.
