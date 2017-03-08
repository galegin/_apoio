unit cGERSVCO032;

interface

(* COMPONENTES 
  ADMSVCO001 / SICSVCO002 / 
*)        

uses
  Classes, SysUtils, DB,
  cServiceUnf, cDataSetUnf;

type
  T_GERSVCO032 = class(TcServiceUnf)
  private
    tGER_EMPRESA,
    tPES_PESSOA : TcDatasetUnf;
    function getParam(pParams : String = '') : String;
    function setEntidade(pParams : String = '') : String;
  protected
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;    
  published
    function buscaLstGrupoEmpresa(pParams : String = '') : String;
    function validaEmpresaSelecionada(pParams : String = '') : String;
    function buscaDadosEmpresa(pParams : String = '') : String;
    function buscaDadosEmpresaPorPessoa(pParams : String = '') : String;
  end;

implementation

uses
  cADMSVCO001,
  cActivate, cStatus, cFuncao, cXml, dModulo;

var


//---------------------------------------------------------------
constructor T_GERSVCO032.Create(AOwner: TComponent);
//---------------------------------------------------------------
begin
  inherited Create(AOwner);
  setEntidade('');
end;

//--------------------------------
destructor T_GERSVCO032.Destroy;
//--------------------------------
begin
  inherited Destroy;
end;

//---------------------------------------------------------------
function T_GERSVCO032.getParam(pParams : String = '') : String;
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
  putitem(xParamEmp, 'CD_EMPRESA');
  putitem(xParamEmp, 'CD_GRUPOEMPRESA');
  putitem(xParamEmp, 'DT_SISTEMA');
  putitem(xParamEmp, 'IN_CCUSTO');
  putitem(xParamEmp, 'IN_EMPRESA');

  xParamEmp := T_ADMSVCO001.GetParamEmpresa(piCdEmpresa, xParamEmp);


end;

//---------------------------------------------------------------
function T_GERSVCO032.setEntidade(pParams : String = '') : String;
//---------------------------------------------------------------
begin
  tGER_EMPRESA := GetEntidade('GER_EMPRESA');
  tPES_PESSOA := GetEntidade('PES_PESSOA');
end;

//--------------------------------------------------------------------
function T_GERSVCO032.buscaLstGrupoEmpresa(pParams : String) : String;
//--------------------------------------------------------------------
const
  cDS_METHOD = 'ADICIONAL=Operação: T_GERSVCO032.buscaLstGrupoEmpresa()';
var
  viParams, voParams, vDsLstEmpresa, vDsLstEmp : String;
  vCdEmpresa, vCdGrupoEmpresa, vCdEmp : Real;
  vDtSistema, vDtEmp : TDate;
  vInEncerramento, vInCCusto, vInEmpresa, vInValidaLocal : Boolean;
begin
  vCdEmpresa := itemXmlF('CD_EMPRESA', pParams);
  vCdGrupoEmpresa := itemXmlF('CD_GRUPOEMPRESA', pParams);
  vInEncerramento := itemXmlB('IN_ENCERRAMENTO', pParams);
  vInCCusto := itemXmlB('IN_CCUSTO', pParams);
  vInEmpresa := itemXmlB('IN_EMPRESA', pParams);
  vInValidaLocal := itemXmlB('IN_VALIDALOCAL', pParams);
  if (vInValidaLocal = '') then begin
    vInValidaLocal := True;
  end;
  if (vCdEmpresa = '')  and (vCdGrupoEmpresa = '') then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Empresa/Grupo empresa não informados!', cDS_METHOD);
    return(-1); exit;
  end;
  if (vCdEmpresa > 0) then begin
    clear_e(tGER_EMPRESA);
    putitem_e(tGER_EMPRESA, 'CD_EMPRESA', vCdEmpresa);
    retrieve_e(tGER_EMPRESA);
    if (xStatus < 0) then begin
      Result := SetStatus(STS_ERROR, 'GEN0001', 'Empresa ' + FloatToStr(vCdEmpresa) + ' não cadastrada!', cDS_METHOD);
      return(-1); exit;
    end else begin
      vCdGrupoEmpresa := item_f('CD_GRUPOEMPRESA', tGER_EMPRESA);
    end;
  end;

  vDsLstEmpresa := '';

  clear_e(tGER_EMPRESA);
  putitem_e(tGER_EMPRESA, 'CD_GRUPOEMPRESA', vCdGrupoEmpresa);
  retrieve_e(tGER_EMPRESA);
  if (xStatus >= 0) then begin
    setocc(tGER_EMPRESA, -1);
    setocc(tGER_EMPRESA, 1);
    putlistitems vDsLstEmpresa, item_f('CD_EMPRESA', tGER_EMPRESA);

    if (vInValidaLocal = True) then begin
      viParams := '';
      putitemXml(viParams, 'CD_EMPRESA', vDsLstEmpresa);
      putitemXml(viParams, 'IN_CCUSTO', vInCCusto);
      putitemXml(viParams, 'IN_EMPRESA', vInEmpresa);
      voParams := activateCmp('SICSVCO002', 'validaLocal', viParams); (*,,,, *)
      if (xStatus < 0) then begin
        Result := voParams;
        return(-1); exit;
      end;
      vDsLstEmpresa := itemXmlF('CD_EMPRESA', voParams);
    end;
  end;
  if (vInEncerramento = True)  and (vDsLstEmpresa <> '') then begin
    vDtSistema := itemXml('DT_SISTEMA', PARAM_GLB);
    vDsLstEmp := vDsLstEmpresa;
    vDsLstEmpresa := '';
    repeat
      getitem(vCdEmp, vDsLstEmp, 1);

      viParams := '';
      putitem(viParams,  'DT_SISTEMA');
      xParamEmp := T_ADMSVCO001.GetParamEmpresa(piCdEmpresa, xParamEmp); (*vCdEmp,,,, *)

      vDtEmp := itemXml('DT_SISTEMA', voParams);
      if (vDtEmp = vDtSistema) then begin
        putitem(vDsLstEmpresa,  vCdEmp);
      end;

      delitem(vDsLstEmp, 1);
    until (vDsLstEmp = '');

    if (vDsLstEmpresa = '') then begin
      Result := SetStatus(STS_ERROR, 'GEN0001', 'Nenhuma empresa válida p/ encerramento diário!', cDS_METHOD);
      return(-1); exit;
    end;
  end;

  Result := '';
  putitemXml(Result, 'CD_EMPRESA', vDsLstEmpresa);

  return(0); exit;
end;

//------------------------------------------------------------------------
function T_GERSVCO032.validaEmpresaSelecionada(pParams : String) : String;
//------------------------------------------------------------------------
const
  cDS_METHOD = 'ADICIONAL=Operação: T_GERSVCO032.validaEmpresaSelecionada()';
var
  vCdEmpresaGrupoEmp, viParams, voParams, vLstEmpresa : String;
  vCdEmpresa, vCdGrupoEmpresa : Real;
  vInEmpValida : Boolean;
begin
  vInEmpValida := False;
  vCdGrupoEmpresa := itemXmlF('CD_GRUPOEMPRESA', pParams);
  if (vCdGrupoEmpresa = '') then begin
    vCdGrupoEmpresa := itemXmlF('CD_GRUPOEMPESA', PARAM_GLB);
  end;
  vCdEmpresa := itemXmlF('CD_EMPRESA', pParams);
  if (vCdEmpresa = '') then begin
    Result := SetStatus(STS_AVISO, 'GEN001', 'Favor informar a empresa para validação.', '');
    return(-1); exit;
  end;

  viParams := '';
  putitemXml(viParams, 'CD_GRUPOEMPRESA', vCdGrupoEmpresa);
  newinstance 'GERSVCO032', 'GERSVCO032X';
  voParams := activateCmp('GERSVCO032X', 'buscaLstGrupoEmpresa', viParams); (*,,,, *)
  if (xStatus < 0) then begin
    Result := voParams;
    return(-1); exit;
  end;
  if (itemXml('CD_EMPRESA', voParams) <> '') then begin
    vLstEmpresa := itemXmlF('CD_EMPRESA', voParams);
    repeat

      getitem(vCdEmpresaGrupoEmp, vLstEmpresa, 1);
      if (vCdEmpresaGrupoEmp = vCdEmpresa) then begin
        vInEmpValida := True;
      end;

      delitem(vLstEmpresa, 1);
    until(vLstEmpresa = '');
  end;
  if (vInEmpValida = True) then begin
    putitemXml(Result, 'CD_EMPRESA', vCdEmpresa);
  end;

  return(0); exit;
end;

//-----------------------------------------------------------------
function T_GERSVCO032.buscaDadosEmpresa(pParams : String) : String;
//-----------------------------------------------------------------
const
  cDS_METHOD = 'ADICIONAL=Operação: T_GERSVCO032.buscaDadosEmpresa()';
var
  vCdEmpresa, vCdPessoa : Real;
  vDsEmpresa : String;
begin
  vCdEmpresa := itemXmlF('CD_EMPRESA', pParams);
  if (vCdEmpresa = '') then begin
    Result := SetStatus(STS_AVISO, 'GEN001', 'Código da empresa não informado!', '');
    return(-1); exit;
  end;

  clear_e(tGER_EMPRESA);
  putitem_e(tGER_EMPRESA, 'CD_EMPRESA', vCdEmpresa);
  retrieve_e(tGER_EMPRESA);
  if (xStatus < 0) then begin
    Result := SetStatus(STS_AVISO, 'GEN001', 'Empresa informada inválida!', '');
    return(-1); exit;
  end;

  putlistitensocc_e(vDsEmpresa, tGER_EMPRESA);
  putitemXml(Result, 'DS_EMPRESA', vDsEmpresa);
  putitemXml(Result, 'CD_GRUPOEMPRESA', item_f('CD_GRUPOEMPRESA', tGER_EMPRESA));
  putitemXml(Result, 'CD_PESSOA', item_f('CD_PESSOA', tPES_PESSOA));
  putitemXml(Result, 'NM_PESSOA', item_a('NM_PESSOA', tPES_PESSOA));
  putitemXml(Result, 'NM_CPFCNPJ', item_f('NR_CPFCNPJ', tPES_PESSOA));

  return(0); exit;
end;

//--------------------------------------------------------------------------
function T_GERSVCO032.buscaDadosEmpresaPorPessoa(pParams : String) : String;
//--------------------------------------------------------------------------
const
  cDS_METHOD = 'ADICIONAL=Operação: T_GERSVCO032.buscaDadosEmpresaPorPessoa()';
var
  vCdPessoa : Real;
begin
  vCdPessoa := itemXmlF('CD_PESSOA', pParams);
  if (vCdPessoa = '') then begin
    Result := SetStatus(STS_AVISO, 'GEN001', 'Código da pessoa não informado!', '');
    return(-1); exit;
  end;

  clear_e(tGER_EMPRESA);
  putitem_e(tGER_EMPRESA, 'CD_PESSOA', vCdPessoa);
  retrieve_e(tGER_EMPRESA);
  if (xStatus < 0) then begin
    Result := SetStatus(STS_AVISO, 'GEN001', 'Pessoa informada inválida!', '');
    return(-1); exit;
  end;

  putlistitensocc_e(Result, tGER_EMPRESA);

  return(0); exit;
end;

end.
