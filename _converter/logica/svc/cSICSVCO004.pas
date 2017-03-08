unit cSISVCO004;

interface

(* COMPONENTES 
  PRDSVCO006 / SICSVCO009 / 
*)        

uses
  Classes, SysUtils, DB,
  cServiceUnf, cDataSetUnf;

type
  T_SISVCO004 = class(TcServiceUnf)
  private
    tADM_USUARIO,
    tADM_USUCMPEMP,
    tADM_USUEMP,
    tGER_EMPRESA,
    tGER_GRUPOEMPR,
    tGER_POOLEMPRE,
    tGER_POOLGRUPO,
    tTMP_NR09 : TcDatasetUnf;
    function getParam(pParams : String = '') : String;
    function setEntidade(pParams : String = '') : String;
  protected
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;    
  published
    function filtraEmpresa(pParams : String = '') : String;
    function validaEmpresa(pParams : String = '') : String;
    function PoolEmpresa(pParams : String = '') : String;
    function validaEmpConta(pParams : String = '') : String;
    function LstEmpresa(pParams : String = '') : String;
    function LstEmpresaOrdenada(pParams : String = '') : String;
    function validaMovimentoPool(pParams : String = '') : String;
  end;

implementation

uses
  cADMSVCO001,
  cActivate, cStatus, cFuncao, cXml, dModulo;

var


//---------------------------------------------------------------
constructor T_SISVCO004.Create(AOwner: TComponent);
//---------------------------------------------------------------
begin
  inherited Create(AOwner);
  setEntidade('');
end;

//--------------------------------
destructor T_SISVCO004.Destroy;
//--------------------------------
begin
  inherited Destroy;
end;

//---------------------------------------------------------------
function T_SISVCO004.getParam(pParams : String = '') : String;
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
function T_SISVCO004.setEntidade(pParams : String = '') : String;
//---------------------------------------------------------------
begin
  tADM_USUARIO := GetEntidade('ADM_USUARIO');
  tADM_USUCMPEMP := GetEntidade('ADM_USUCMPEMP');
  tADM_USUEMP := GetEntidade('ADM_USUEMP');
  tGER_EMPRESA := GetEntidade('GER_EMPRESA');
  tGER_GRUPOEMPR := GetEntidade('GER_GRUPOEMPR');
  tGER_POOLEMPRE := GetEntidade('GER_POOLEMPRE');
  tGER_POOLGRUPO := GetEntidade('GER_POOLGRUPO');
  tTMP_NR09 := GetEntidade('TMP_NR09');
end;

//------------------------------------------------------------
function T_SISVCO004.filtraEmpresa(pParams : String) : String;
//------------------------------------------------------------
const
  cDS_METHOD = 'ADICIONAL=Operação: T_SISVCO004.filtraEmpresa()';
var
  vN : Real;
  vLstCdEmpresa, vLstCdGrupoEmpresa, vLstCdGrupoEmp, vLstAux, viParams, voParams : String;
begin
  vLstCdEmpresa := '';
  vLstCdGrupoEmpresa := '';
  vN := 0;

  clear_e(tADM_USUARIO);
  putitem_e(tADM_USUARIO, 'CD_USUARIO', itemXmlF('CD_USUARIO', pParams));
  retrieve_e(tADM_USUARIO);
  if (!xProcerror) then begin
    clear_e(tGER_GRUPOEMPR);
    putitem_e(tGER_GRUPOEMPR, 'CD_GRUPOEMPRESA', itemXmlF('CD_GRUPOEMPRESA', pParams));
    retrieve_e(tGER_GRUPOEMPR);
    if (xStatus >= 0) then begin
      repeat
        clear_e(tGER_EMPRESA);
        putitem_e(tGER_EMPRESA, 'CD_GRUPOEMPRESA', itemXmlF('CD_GRUPOEMPRESA', pParams));
        retrieve_e(tGER_EMPRESA);
        if (!xProcerror) then begin
          setocc(tGER_EMPRESA, 1);
          while (xStatus >=0) do begin
            if (item_f('TP_PRIVILEGIO', tADM_USUARIO) = '1')  or (item_f('TP_PRIVILEGIO', tADM_USUARIO) = '4') then begin
              clear_e(tADM_USUCMPEMP);
              putitem_e(tADM_USUCMPEMP, 'CD_USUARIO', itemXmlF('CD_USUARIO', pParams));
              putitem_e(tADM_USUCMPEMP, 'CD_EMPRESA', item_f('CD_EMPRESA', tGER_EMPRESA));
              putitem_e(tADM_USUCMPEMP, 'CD_COMPONENTE', itemXmlF('CD_COMPONENTE', pParams));
              retrieve_e(tADM_USUCMPEMP);
              if (xStatus = 0) then begin
                vN := vN + 1;
                if (item_f('CD_CCUSTO', tGER_EMPRESA) = '') then begin
                  putitem(vLstCdEmpresa,  '' + cd_empresa + '.ADM_USUCMPEMP');
                end else begin
                  putitem(vLstCdGrupoEmpresa,  '' + cd_empresa + '.ADM_USUCMPEMP');
                end;
              end;
            end else begin
              vN := vN + 1;
              if (item_f('CD_CCUSTO', tGER_EMPRESA) = '') then begin
                putitem(vLstCdEmpresa,  '' + cd_empresa + '.GER_EMPRESA');
              end else begin
                putitem(vLstCdGrupoEmpresa,  '' + cd_empresa + '.GER_EMPRESA');
              end;
            end;
            setocc(tGER_EMPRESA, curocc(tGER_EMPRESA) + 1);
          end;
        end;

        setocc(tGER_GRUPOEMPR, curocc(tGER_GRUPOEMPR) + 1);
      until(xStatus < 0);
      xStatus := 0;
    end;
  end;

  sort/list vLstCdEmpresa, 'U';
  sort/list vLstCdGrupoEmpresa, 'U';

  vLstCdGrupoEmp := vLstCdGrupoEmpresa;

  clear_e(tGER_EMPRESA);
  putitem_e(tGER_EMPRESA, 'CD_EMPRESA', itemXmlF('CD_EMPRESA', PARAM_GLB));
  retrieve_e(tGER_EMPRESA);
  if (item_f('CD_CCUSTO', tGER_EMPRESA) = '') then begin
    vLstCdGrupoEmpresa := '';
  end;
  if (itemXml('IN_RECEBIMENTO', pParams) = True) then begin
    if (item_f('CD_CCUSTO', tGER_EMPRESA) = '') then begin
      if (itemXml('IN_UTILIZA_AUDITORIA', pParams) = True) then begin
        vLstCdGrupoEmpresa := vLstCdGrupoEmp;

        viParams := '';
        voParams := activateCmp('SICSVCO009', 'validaCentroCusto', viParams); (*,,,, *)
        if (xStatus < 0) then begin
          Result := voParams;
          return(-1); exit;
        end;
        end;
      end else begin
        vLstCdGrupoEmpresa := '';
      end;
    end else begin
      if (itemXml('IN_UTILIZA_AUDITORIA', pParams) = True) then begin
        if (itemXml('IN_VALIDAEMPRESA', pParams) = True) then begin
          vLstCdEmpresa := '' + vLstCdEmpresa + ';
        end else begin

          viParams := '';
          voParams := activateCmp('SICSVCO009', 'validaCentroCusto', viParams); (*,,,, *)
          if (xStatus < 0) then begin
            Result := voParams;
            return(-1); exit;
          end;
          end;
          if (itemXml('IN_FLAG', pParams) = True) then begin
            vLstCdGrupoEmpresa := vLstCdEmpresa;
          end;
        end;
      end else begin
        vLstCdGrupoEmpresa := '';
        vLstCdEmpresa := '';
        vLstCdEmpresa := vLstCdGrupoEmp;
      end;
    end;
  end;

  putitemXml(Result, 'LST_CDEMPRESA', vLstCdEmpresa);
  putitemXml(Result, 'LST_GRUPOEMPRESA', vLstCdGrupoEmpresa);

  return(0); exit;
end;

//------------------------------------------------------------
function T_SISVCO004.validaEmpresa(pParams : String) : String;
//------------------------------------------------------------
const
  cDS_METHOD = 'ADICIONAL=Operação: T_SISVCO004.validaEmpresa()';
var
  vLstCdEmpresa, vLstCdGrupoEmpresa, vLstEmpresa : String;
  vCdEmpresaLog, vCdPoolEmpresa, vCdUsuario : Real;
  vInValidaPool : Boolean;
begin
  vCdEmpresaLog := itemXmlF('CD_EMPRESALOG', pParams);
  vCdUsuario := itemXmlF('CD_USUARIO', pParams);
  if (vCdUsuario = 0) then begin
    vCdUsuario := itemXmlF('CD_USUARIO', PARAM_GLB);
  end;
  vInValidaPool := itemXmlB('IN_VALIDAPOOL', pParams);
  if (vInValidaPool = '') then begin
    vInValidaPool := True;
  end;

  clear_e(tADM_USUARIO);
  putitem_e(tADM_USUARIO, 'CD_USUARIO', vCdUsuario);
  retrieve_e(tADM_USUARIO);
  if (xStatus >= 0) then begin
    clear_e(tGER_EMPRESA);
    putitem_e(tGER_EMPRESA, 'CD_EMPRESA', itemXmlF('CD_EMPRESA', pParams));
    retrieve_e(tGER_EMPRESA);
    if (xStatus >= 0) then begin
      setocc(tGER_EMPRESA, 1);
      repeat
        if (item_f('TP_PRIVILEGIO', tADM_USUARIO) = '1')  or (item_f('TP_PRIVILEGIO', tADM_USUARIO) = '4') then begin
          clear_e(tADM_USUCMPEMP);
          putitem_e(tADM_USUCMPEMP, 'CD_USUARIO', vCdUsuario);
          putitem_e(tADM_USUCMPEMP, 'CD_EMPRESA', item_f('CD_EMPRESA', tGER_EMPRESA));
          putitem_e(tADM_USUCMPEMP, 'CD_COMPONENTE', itemXmlF('CD_COMPONENTE', pParams));
          retrieve_e(tADM_USUCMPEMP);
          if (xStatus >= 0) then begin
            if (item_f('CD_CCUSTO', tGER_EMPRESA) = '') then begin
              putitem(vLstCdEmpresa,  '' + cd_empresa + '.ADM_USUCMPEMP');
            end else begin
              putitem(vLstCdGrupoEmpresa,  '' + cd_empresa + '.ADM_USUCMPEMP');
            end;
          end;
        end else begin

          if (item_f('TP_PRIVILEGIO', tADM_USUARIO) = '5') then begin
            clear_e(tADM_USUEMP);
            putitem_e(tADM_USUEMP, 'CD_USUARIO', vCdUsuario);
            putitem_e(tADM_USUEMP, 'CD_EMPRESA', item_f('CD_EMPRESA', tGER_EMPRESA));
            retrieve_e(tADM_USUEMP);
            if (xStatus >= 0) then begin
              if (item_f('CD_CCUSTO', tGER_EMPRESA) = '') then begin
                putitem(vLstCdEmpresa,  '' + cd_empresa + '.GER_EMPRESA');
              end else begin
                putitem(vLstCdGrupoEmpresa,  '' + cd_empresa + '.GER_EMPRESA');
              end;
            end;

          end else begin
            if (item_f('CD_CCUSTO', tGER_EMPRESA) = '') then begin
              putitem(vLstCdEmpresa,  '' + cd_empresa + '.GER_EMPRESA');
            end else begin
              putitem(vLstCdGrupoEmpresa,  '' + cd_empresa + '.GER_EMPRESA');
            end;
          end;
        end;
        setocc(tGER_EMPRESA, curocc(tGER_EMPRESA) + 1);
      until(xStatus < 0);
      xStatus := 0;
    end;
  end;
  if (itemXml('CD_POOLEMPRESA', pParams) <> '') then begin
    vCdPoolEmpresa := itemXmlF('CD_POOLEMPRESA', pParams);
  end else begin
    vCdPoolEmpresa := itemXmlF('CD_POOLEMPRESA', PARAM_GLB);
  end;
  if (vCdPoolEmpresa > 0)  and (vInValidaPool = True) then begin
    clear_e(tTMP_NR09);
    getlistitems vLstCdEmpresa, item_f('NR_GERAL', tTMP_NR09);
    setocc(tTMP_NR09, 1);
    while (xStatus >= 0) do begin
      clear_e(tGER_EMPRESA);
      putitem_e(tGER_EMPRESA, 'CD_EMPRESA', item_f('NR_GERAL', tTMP_NR09));
      retrieve_e(tGER_EMPRESA);
      if (xStatus >= 0) then begin
        clear_e(tGER_POOLGRUPO);
        putitem_e(tGER_POOLGRUPO, 'CD_POOLEMPRESA', vCdPoolEmpresa);
        putitem_e(tGER_POOLGRUPO, 'CD_GRUPOEMPRESA', item_f('CD_GRUPOEMPRESA', tGER_EMPRESA));
        retrieve_e(tGER_POOLGRUPO);
        if (xStatus >= 0) then begin
          setocc(tTMP_NR09, curocc(tTMP_NR09) + 1);
        end else begin
          discard(tTMP_NR09);
          if (xStatus = 0) then begin
            xStatus := -1;
          end;
        end;
      end else begin
        discard(tTMP_NR09);
        if (xStatus = 0) then begin
          xStatus := -1;
        end;
      end;
    end;

    sort_e(tTMP_NR09, '    sort/e , NR_GERAL;');
    putlistitems vLstCdEmpresa, item_f('NR_GERAL', tTMP_NR09);

    clear_e(tTMP_NR09);
    getlistitems vLstCdGrupoEmpresa, item_f('NR_GERAL', tTMP_NR09);
    setocc(tTMP_NR09, 1);
    while (xStatus >= 0) do begin
      clear_e(tGER_EMPRESA);
      putitem_e(tGER_EMPRESA, 'CD_EMPRESA', item_f('NR_GERAL', tTMP_NR09));
      retrieve_e(tGER_EMPRESA);
      if (xStatus >= 0) then begin
        clear_e(tGER_POOLGRUPO);
        putitem_e(tGER_POOLGRUPO, 'CD_POOLEMPRESA', vCdPoolEmpresa);
        putitem_e(tGER_POOLGRUPO, 'CD_GRUPOEMPRESA', item_f('CD_GRUPOEMPRESA', tGER_EMPRESA));
        retrieve_e(tGER_POOLGRUPO);
        if (xStatus >= 0) then begin
          setocc(tTMP_NR09, curocc(tTMP_NR09) + 1);
        end else begin
          discard(tTMP_NR09);
          if (xStatus = 0) then begin
            xStatus := -1;
          end;
        end;
      end else begin
        discard(tTMP_NR09);
        if (xStatus = 0) then begin
          xStatus := -1;
        end;
      end;
    end;

    sort_e(tTMP_NR09, '    sort/e , NR_GERAL;');
    putlistitems vLstCdGrupoEmpresa, item_f('NR_GERAL', tTMP_NR09);
  end;

  Result := '';
  vLstEmpresa := '';

  if (itemXml('IN_AUDITORIA', pParams) = True) then begin
    clear_e(tGER_EMPRESA);
    putitem_e(tGER_EMPRESA, 'CD_EMPRESA', itemXmlF('CD_EMPRESA', PARAM_GLB));
    retrieve_e(tGER_EMPRESA);
    if (item_f('CD_CCUSTO', tGER_EMPRESA) = '') then begin
      putitemXml(vLstEmpresa, 'CD_EMPRESA', vLstCdEmpresa);
      putitemXml(Result, 'LISTA_EMPRESA', vLstEmpresa);
      putitemXml(Result, 'LST_EMPRESA', '' + vLstCdEmpresa') + ';
      putitemXml(Result, 'CD_EMPRESA', vLstCdEmpresa);
    end else begin
      putitemXml(vLstEmpresa, 'CD_EMPRESA', vLstCdEmpresa);
      putitemXml(vLstEmpresa, 'CD_CENTROCUSTO', vLstCdGrupoEmpresa);
      putitemXml(Result, 'LISTA_EMPRESA', vLstEmpresa);
      putitemXml(Result, 'LST_EMPRESA', '' + vLstCdEmpresa) + ';
      putitemXml(Result, 'CD_EMPRESA', vLstCdEmpresa);
      putitemXml(Result, 'CD_CENTROCUSTO', vLstCdGrupoEmpresa);
    end;

  end else begin
    clear_e(tGER_EMPRESA);
    if (vCdEmpresaLog = '') then begin
      putitem_e(tGER_EMPRESA, 'CD_EMPRESA', itemXmlF('CD_EMPRESA', PARAM_GLB));
    end else begin
      putitem_e(tGER_EMPRESA, 'CD_EMPRESA', vCdEmpresaLog);
    end;
    retrieve_e(tGER_EMPRESA);
    if (xStatus >= 0) then begin
      if (item_f('CD_CCUSTO', tGER_EMPRESA) = '') then begin
        if (itemXml('IN_EMP_PAGTO_AUTO', pParams) = True) then begin
          Result := '';
          putitemXml(Result, 'CD_EMPRESA', vLstCdEmpresa);
        end else begin
          putitemXml(vLstEmpresa, 'CD_EMPRESA', vLstCdEmpresa);
          putitemXml(Result, 'LISTA_EMPRESA', vLstEmpresa);
          putitemXml(Result, 'LST_EMPRESA', '' + vLstCdEmpresa') + ';
          putitemXml(Result, 'CD_EMPRESA', vLstCdEmpresa);
        end;
      end else begin

        if (itemXml('IN_RECEBIMENTO', pParams) = True) then begin
          putitemXml(vLstEmpresa, 'CD_CENTROCUSTO', vLstCdGrupoEmpresa);
          putitemXml(Result, 'LISTA_EMPRESA', vLstEmpresa);
          putitemXml(Result, 'LST_EMPRESA', '' + vLstCdGrupoEmpresa') + ';
          putitemXml(Result, 'CD_EMPRESA', vLstCdGrupoEmpresa);
        end else begin
          if (itemXml('IN_EMP_PAGTO_AUTO', pParams) = True) then begin
            Result := '';
            putitemXml(Result, 'CD_EMPRESA', vLstCdGrupoEmpresa);
          end else begin

            if (itemXml('IN_CCUSTO', pParams) = True) then begin
              putitemXml(Result, 'LST_EMPRESA', vLstCdGrupoEmpresa);
              if (itemXml('IN_MATRIZ', pParams) = True) then begin
                vLstEmpresa := '';
                putitemXml(vLstEmpresa, 'CD_EMPRESA', vLstCdGrupoEmpresa);
                putitemXml(Result, 'LISTA_EMPRESA', vLstEmpresa);
                putitemXml(Result, 'CD_EMPRESA', vLstCdEmpresa);
              end;
            end else begin
              putitemXml(vLstEmpresa, 'CD_EMPRESA', vLstCdEmpresa);
              putitemXml(vLstEmpresa, 'CD_CENTROCUSTO', vLstCdGrupoEmpresa);
              putitemXml(Result, 'LISTA_EMPRESA', vLstEmpresa);
              putitemXml(Result, 'CD_EMPRESA', vLstCdEmpresa);
              putitemXml(Result, 'CD_CENTROCUSTO', vLstCdGrupoEmpresa);
              if (vLstCdEmpresa <> '')  and (vLstCdGrupoEmpresa <> '') then begin
                putitemXml(Result, 'LST_EMPRESA', '' + vLstCdEmpresa) + ';
              end else if (vLstCdEmpresa <> '') then begin
                putitemXml(Result, 'LST_EMPRESA', vLstCdEmpresa);
              end else if (vLstCdGrupoEmpresa <> '') then begin
                putitemXml(Result, 'LST_EMPRESA', vLstCdGrupoEmpresa);
              end;
            end;
          end;
        end;
      end;
    end;
  end;

  return(0); exit;
end;

//----------------------------------------------------------
function T_SISVCO004.PoolEmpresa(pParams : String) : String;
//----------------------------------------------------------
const
  cDS_METHOD = 'ADICIONAL=Operação: T_SISVCO004.PoolEmpresa()';
var
  vCdPoolEmpresa : Real;
  vLstEmpresa,vLstGrupoEmpresa,vLstCdEmpresa,vLstCdGrupoEmpresa,vCdEmpresa,vDsLinha : String;
  vInCCusto,vInSomenteCC : Boolean;
begin
  vCdPoolEmpresa := itemXmlF('CD_POOLEMPRESA', pParams);
  vCdEmpresa := itemXmlF('CD_EMPRESA', pParams);
  vInSomenteCC := itemXmlB('IN_CCUSTO', pParams);

  if (vCdEmpresa = '') then begin
    Result := SetStatus(STS_ERROR, 'GEN001', 'Empresa não informada', '');
    return(-1); exit;
  end;
  if (vCdPoolEmpresa = '') then begin
    Result := SetStatus(STS_ERROR, 'GEN001', 'Pool empresa não informado', '');
    return(-1); exit;
  end;

  clear_e(tGER_EMPRESA);
  putitem_e(tGER_EMPRESA, 'CD_EMPRESA', vCdEmpresa);
  retrieve_e(tGER_EMPRESA);
  if (xStatus < 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN001', 'Empresa não existe', '');
    return(-1); exit;
  end;

  vInCCusto := False;
  if (item_f('CD_CCUSTO', tGER_EMPRESA) <> '') then begin
    vInCCusto := True;
  end;
  if (vInSomenteCC = True)  and (vInCCusto = False) then begin
    Result := SetStatus(STS_ERROR, 'GEN001', 'Login de empresa não confere com Centro de Custo', '');
    return(-1); exit;
  end;

  clear_e(tGER_POOLGRUPO);
  putitem_e(tGER_POOLGRUPO, 'CD_POOLEMPRESA', vCdPoolEmpresa);
  retrieve_e(tGER_POOLGRUPO);
  if (xStatus < 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN001', 'Grupo de pooll empresa não existe', '');
    return(-1); exit;
  end;

  sort_e(tGER_POOLGRUPO, '  sort/e , CD_GRUPOEMPRESA;');

  setocc(tGER_POOLGRUPO, 1);
  while (xStatus >= 0) do begin
    clear_e(tGER_EMPRESA);
    putitem_e(tGER_EMPRESA, 'CD_GRUPOEMPRESA', item_f('CD_GRUPOEMPRESA', tGER_POOLGRUPO));
    retrieve_e(tGER_EMPRESA);
    if (xStatus >= 0) then begin
      setocc(tGER_EMPRESA, 1);
      while (xStatus >= 0) do begin
        if (item_f('CD_CCUSTO', tGER_EMPRESA) = '') then begin
          if (vInSomenteCC <> True) then begin
            if (vLstCdEmpresa = '') then begin
              vLstCdEmpresa := item_f('CD_EMPRESA', tGER_EMPRESA);
            end else begin
              vLstCdEmpresa := '' + vLstCdEmpresa + ';
            end;
            vDsLinha := '';
            putitemXml(vDsLinha, 'CD_EMPRESA', item_f('CD_EMPRESA', tGER_EMPRESA));
            putitem(vLstEmpresa,  vDsLinha);
          end;
        end else begin
          if (vInCCusto = True) then begin
            if (vLstCdEmpresa = '') then begin
              vLstCdEmpresa := item_f('CD_EMPRESA', tGER_EMPRESA);
            end else begin
              vLstCdEmpresa := '' + vLstCdEmpresa + ';
            end;
            vDsLinha := '';
            putitemXml(vDsLinha, 'CD_EMPRESA', item_f('CD_EMPRESA', tGER_EMPRESA));
            putitem(vLstEmpresa,  vDsLinha);
          end;
        end;

        setocc(tGER_EMPRESA, curocc(tGER_EMPRESA) + 1);
      end;
      if (vLstCdGrupoEmpresa = '') then begin
        vLstCdGrupoEmpresa := item_f('CD_GRUPOEMPRESA', tGER_EMPRESA);
      end else begin
        vLstCdGrupoEmpresa := '' + vLstCdGrupoEmpresa + ';
      end;

      vDsLinha := '';
      putitemXml(vDsLinha, 'CD_GRUPOEMPRESA', item_f('CD_GRUPOEMPRESA', tGER_EMPRESA));
      putitem(vLstGrupoEmpresa,  vDsLinha);

    end;
    setocc(tGER_POOLGRUPO, curocc(tGER_POOLGRUPO) + 1);
  end;

  putitemXml(Result, 'LS_CDEMPRESA', vLstCdEmpresa);
  putitemXml(Result, 'LS_CDGRUPOEMPRESA', vLstCdGrupoEmpresa);
  putitemXml(Result, 'LS_EMPRESA', vLstEmpresa);
  putitemXml(Result, 'LS_GRUPOEMPRESA', vLstGrupoEmpresa);

  return(0); exit;
end;

//-------------------------------------------------------------
function T_SISVCO004.validaEmpConta(pParams : String) : String;
//-------------------------------------------------------------
const
  cDS_METHOD = 'ADICIONAL=Operação: T_SISVCO004.validaEmpConta()';
var
  viParams, voParams, vLstCdEmpresa, vLstCdGrupoEmpresa : String;
begin
  if (itemXml('LST_EMPRESA', pParams) = '') then begin
    Result := SetStatus(STS_ERROR, 'GEN001', 'Não há empresas informada para recebimento', '');
    return(-1); exit;
  end;
  if (itemXml('CD_EMPRESA_CONTA', pParams) = '') then begin
    Result := SetStatus(STS_ERROR, 'GEN001', 'Empresa da conta banco não informada.', '');
    return(-1); exit;
  end;

  clear_e(tADM_USUARIO);
  putitem_e(tADM_USUARIO, 'CD_USUARIO', itemXmlF('CD_USUARIO', PARAM_GLB));
  retrieve_e(tADM_USUARIO);
  if (xStatus >= 0) then begin
    clear_e(tGER_EMPRESA);
    putitem_e(tGER_EMPRESA, 'CD_EMPRESA', itemXml('LST_EMPRESA', pParams));
    retrieve_e(tGER_EMPRESA);
    if (xStatus >= 0) then begin
      setocc(tGER_EMPRESA, 1);
      repeat
        if (item_f('TP_PRIVILEGIO', tADM_USUARIO) = '1')  or (item_f('TP_PRIVILEGIO', tADM_USUARIO) = '4') then begin
          clear_e(tADM_USUCMPEMP);
          putitem_e(tADM_USUCMPEMP, 'CD_USUARIO', itemXmlF('CD_USUARIO', pParams));
          putitem_e(tADM_USUCMPEMP, 'CD_EMPRESA', item_f('CD_EMPRESA', tGER_EMPRESA));
          putitem_e(tADM_USUCMPEMP, 'CD_COMPONENTE', itemXmlF('CD_COMPONENTE', pParams));
          retrieve_e(tADM_USUCMPEMP);
          if (xStatus >= 0) then begin
            if (item_f('CD_CCUSTO', tGER_EMPRESA) = '') then begin
              putitem(vLstCdEmpresa,  '' + cd_empresa + '.ADM_USUCMPEMP');
            end else begin
              putitem(vLstCdGrupoEmpresa,  '' + cd_empresa + '.ADM_USUCMPEMP');
            end;
          end;
        end else begin
          if (item_f('CD_CCUSTO', tGER_EMPRESA) = '') then begin
            putitem(vLstCdEmpresa,  '' + cd_empresa + '.GER_EMPRESA');
          end else begin
            putitem(vLstCdGrupoEmpresa,  '' + cd_empresa + '.GER_EMPRESA');
          end;
        end;
        setocc(tGER_EMPRESA, curocc(tGER_EMPRESA) + 1);
      until(xStatus < 0);
      xStatus := 0;
    end;
  end;

  viParams := '';
  putitemXml(viParams, 'CD_EMPRESA', itemXmlF('CD_EMPRESA_CONTA', pParams));
  voParams := activateCmp('SICSVCO009', 'validaCentroCusto', viParams); (*,,,, *)
  if (xStatus < 0) then begin
    Result := voParams;
    return(-1); exit;
  end;
  end;

  return(0); exit;
end;

//---------------------------------------------------------
function T_SISVCO004.LstEmpresa(pParams : String) : String;
//---------------------------------------------------------
const
  cDS_METHOD = 'ADICIONAL=Operação: T_SISVCO004.LstEmpresa()';
var
  vCdEmpresa : Real;
  vLstEmpresa,vLstGrupoEmpresa,vLstCdEmpresa,vLstCdGrupoEmpresa : String;
  vDsLinha : String;
  vInCCusto,vInSomenteCC : Boolean;
begin
  vCdEmpresa := itemXmlF('CD_EMPRESA', pParams);
  vInSomenteCC := itemXmlB('IN_CCUSTO', pParams);

  if (vCdEmpresa = '') then begin
    Result := SetStatus(STS_ERROR, 'GEN001', 'Empresa não informada', '');
    return(-1); exit;
  end;

  clear_e(tGER_EMPRESA);
  putitem_e(tGER_EMPRESA, 'CD_EMPRESA', vCdEmpresa);
  retrieve_e(tGER_EMPRESA);
  if (xStatus < 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN001', 'Empresa não existe', '');
    return(-1); exit;
  end;

  vInCCusto := False;
  if (item_f('CD_CCUSTO', tGER_EMPRESA) <> '') then begin
    vInCCusto := True;
  end;
  if (vInSomenteCC = True)  and (vInCCusto = False) then begin
    Result := SetStatus(STS_ERROR, 'GEN001', 'Login de empresa não confere com Centro de Custo', '');
    return(-1); exit;
  end;

  clear_e(tGER_EMPRESA);
  retrieve_e(tGER_EMPRESA);
  if (xStatus >= 0) then begin
    setocc(tGER_EMPRESA, 1);
    while (xStatus >= 0) do begin
      if (item_f('CD_CCUSTO', tGER_EMPRESA) = '') then begin
        if (vInSomenteCC <> True) then begin
          if (vLstCdEmpresa = '') then begin
            vLstCdEmpresa := item_f('CD_EMPRESA', tGER_EMPRESA);
          end else begin
            vLstCdEmpresa := '' + vLstCdEmpresa + ';
          end;
          putitemXml(vDsLinha, 'CD_EMPRESA', item_f('CD_EMPRESA', tGER_EMPRESA));
          putitem(vLstEmpresa,  vDsLinha);
        end;
      end else begin
        if (vInCCusto = True) then begin
          if (vLstCdEmpresa = '') then begin
            vLstCdEmpresa := item_f('CD_EMPRESA', tGER_EMPRESA);
          end else begin
            vLstCdEmpresa := '' + vLstCdEmpresaor' + CD_EMPRESA + ' + '.GER_EMPRESA';
          end;
          putitemXml(vDsLinha, 'CD_EMPRESA', item_f('CD_EMPRESA', tGER_EMPRESA));
          putitem(vLstEmpresa,  vDsLinha);
        end;
      end;

      vDsLinha := '';
      if (vLstCdGrupoEmpresa = '') then begin
        vLstCdGrupoEmpresa := item_f('CD_GRUPOEMPRESA', tGER_EMPRESA);
      end else begin
        vLstCdGrupoEmpresa := '' + vLstCdGrupoEmpresaor' + CD_GRUPOEMPRESA + ' + '.GER_EMPRESA';
      end;

      putitemXml(vDsLinha, 'CD_GRUPOEMPRESA', item_f('CD_GRUPOEMPRESA', tGER_EMPRESA));
      putitem(vLstGrupoEmpresa,  vDsLinha);
      setocc(tGER_EMPRESA, curocc(tGER_EMPRESA) + 1);
    end;
  end;

  putitemXml(Result, 'LS_CDEMPRESA', vLstCdEmpresa);
  putitemXml(Result, 'LS_CDGRUPOEMPRESA', vLstCdGrupoEmpresa);
  putitemXml(Result, 'LS_EMPRESA', vLstEmpresa);
  putitemXml(Result, 'LS_GRUPOEMPRESA', vLstGrupoEmpresa);

  return(0); exit;

end;

//-----------------------------------------------------------------
function T_SISVCO004.LstEmpresaOrdenada(pParams : String) : String;
//-----------------------------------------------------------------
const
  cDS_METHOD = 'ADICIONAL=Operação: T_SISVCO004.LstEmpresaOrdenada()';
var
  vCdEmpresa : Real;
  vLstCdEmpresa, vLstCdGrupoEmpresa, vDsLinha : String;
  vInCCusto, vInSomenteCC : Boolean;
begin
  vCdEmpresa := itemXmlF('CD_EMPRESA', pParams);
  vInSomenteCC := itemXmlB('IN_CCUSTO', pParams);

  if (vCdEmpresa = '') then begin
    Result := SetStatus(STS_ERROR, 'GEN001', 'Empresa não informada', '');
    return(-1); exit;
  end;

  clear_e(tGER_EMPRESA);
  putitem_e(tGER_EMPRESA, 'CD_EMPRESA', vCdEmpresa);
  retrieve_e(tGER_EMPRESA);
  if (xStatus < 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN001', 'Empresa não existe', '');
    return(-1); exit;
  end;

  vInCCusto := False;
  if (item_f('CD_CCUSTO', tGER_EMPRESA) <> '') then begin
    vInCCusto := True;
  end;
  if (vInSomenteCC = True)  and (vInCCusto = False) then begin
    Result := SetStatus(STS_ERROR, 'GEN001', 'Login de empresa não confere com Centro de Custo', '');
    return(-1); exit;
  end;

  clear_e(tGER_EMPRESA);
  if (vInCCusto = True) then begin
    putitem_e(tGER_EMPRESA, 'CD_CCUSTO', '!=');
  end else begin
    putitem_e(tGER_EMPRESA, 'CD_CCUSTO', '=');
  end;
  retrieve_e(tGER_EMPRESA);
  if (xStatus >= 0) then begin
    if (vInCCusto = True) then begin
      sort_e(tGER_EMPRESA, '      sort/e , CD_CCUSTO;');
    end else begin
      sort_e(tGER_EMPRESA, '      sort/e , CD_EMPRESA;');
    end;

    setocc(tGER_EMPRESA, 1);
    while (xStatus >= 0) do begin
      if (vInCCusto = True) then begin
        if (vInSomenteCC <> True) then begin
          if (vLstCdEmpresa = '') then begin
            vLstCdEmpresa := item_f('CD_CCUSTO', tGER_EMPRESA);
          end else begin
            vLstCdEmpresa := '' + vLstCdEmpresa + ';
          end;
        end;
        if (vLstCdEmpresa = '') then begin
          vLstCdEmpresa := item_f('CD_EMPRESA', tGER_EMPRESA);
        end else begin
          vLstCdEmpresa := '' + vLstCdEmpresa + ';
        end;
      end else begin
        if (vLstCdEmpresa = '') then begin
          vLstCdEmpresa := item_f('CD_EMPRESA', tGER_EMPRESA);
        end else begin
          vLstCdEmpresa := '' + vLstCdEmpresa + ';
        end;
      end;

      vDsLinha := '';
      if (vLstCdGrupoEmpresa = '') then begin
        vLstCdGrupoEmpresa := item_f('CD_GRUPOEMPRESA', tGER_EMPRESA);
      end else begin
        vLstCdGrupoEmpresa := '' + vLstCdGrupoEmpresaor' + CD_GRUPOEMPRESA + ' + '.GER_EMPRESA';
      end;

      setocc(tGER_EMPRESA, curocc(tGER_EMPRESA) + 1);
    end;
  end;

  putitemXml(Result, 'LS_CDEMPRESA', vLstCdEmpresa);
  putitemXml(Result, 'LS_CDGRUPOEMPRESA', vLstCdGrupoEmpresa);
  putitemXml(Result, 'IN_CCUSTO', vInCCusto);

  return(0); exit;

end;

//------------------------------------------------------------------
function T_SISVCO004.validaMovimentoPool(pParams : String) : String;
//------------------------------------------------------------------
const
  cDS_METHOD = 'ADICIONAL=Operação: T_SISVCO004.validaMovimentoPool()';
var
  (* string viValores :IN *)
  viParams, voParams : String;
  vCdEmpBase, vCdGrupoEmpBase, vCdPoolEmpBase, vCdEmpCCusto : Real;
  vCdGrupoEmpMatriz, vCdEmpMatCCusto : Real;
begin
  vCdEmpBase := itemXmlF('CD_EMPRESA', pParams);
  if (vCdEmpBase = '') then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', ' ' + FloatToStr(vCdEmpBase) + ' empresa base não informada!', cDS_METHOD);
    return(-1); exit;
  end;

  clear_e(tGER_EMPRESA);
  putitem_e(tGER_EMPRESA, 'CD_EMPRESA', vCdEmpBase);
  retrieve_e(tGER_EMPRESA);
  if (xStatus < 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', ' ' + FloatToStr(vCdEmpBase) + ' empresa base não cadastrada!', cDS_METHOD);
    return(-1); exit;
  end;
  vCdGrupoEmpBase := item_f('CD_GRUPOEMPRESA', tGER_EMPRESA);

  clear_e(tGER_EMPRESA);
  putitem_e(tGER_EMPRESA, 'CD_GRUPOEMPRESA', vCdGrupoEmpBase);
  retrieve_e(tGER_EMPRESA);
  if (xStatus < 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', ' ' + FloatToStr(vCdGrupoEmpBase) + ' grupo empresa não inválido!', cDS_METHOD);
    return(-1); exit;
  end;

  setocc(tGER_EMPRESA, -1);
  setocc(tGER_EMPRESA, 1);
  while(xStatus >= 0) do begin
    if (item_f('CD_CCUSTO', tGER_EMPRESA) > 0) then begin
      vCdEmpCCusto := item_f('CD_EMPRESA', tGER_EMPRESA);
    end;
    setocc(tGER_EMPRESA, curocc(tGER_EMPRESA) + 1);
  end;

  clear_e(tGER_POOLGRUPO);
  putitem_e(tGER_POOLGRUPO, 'CD_GRUPOEMPRESA', vCdGrupoEmpBase);
  retrieve_e(tGER_POOLGRUPO);
  if (xStatus < 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', ' ' + FloatToStr(vCdGrupoEmpBase) + ' grupo empresa não cadastrada no pool!', cDS_METHOD);
    return(-1); exit;
  end;
  vCdPoolEmpBase := item_f('CD_POOLEMPRESA', tGER_POOLGRUPO);

  clear_e(tGER_POOLEMPRE);
  putitem_e(tGER_POOLEMPRE, 'CD_POOLEMPRESA', vCdPoolEmpBase);
  retrieve_e(tGER_POOLEMPRE);
  if (xStatus < 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', ' ' + FloatToStr(vCdPoolEmpBase) + ' pool não cadastrado!', cDS_METHOD);
    return(-1); exit;
  end;
  vCdGrupoEmpMatriz := item_f('CD_GRUPOEMPMATRIZ', tGER_POOLEMPRE);
  if (vCdGrupoEmpMatriz = '') then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', ' Grupo empresa matriz não cadastrado!', cDS_METHOD);
    return(-1); exit;
  end;

  clear_e(tGER_EMPRESA);
  putitem_e(tGER_EMPRESA, 'CD_GRUPOEMPRESA', vCdGrupoEmpMatriz);
  retrieve_e(tGER_EMPRESA);
  if (xStatus < 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'NF ' + FloatToStr(vCdGrupoEmpBase) + ' grupo empresa não inválido!', cDS_METHOD);
    return(-1); exit;
  end;
  setocc(tGER_EMPRESA, -1);
  setocc(tGER_EMPRESA, 1);
  while(xStatus >= 0) do begin
    if (item_f('CD_CCUSTO', tGER_EMPRESA) > 0) then begin
      vCdEmpMatCCusto := item_f('CD_EMPRESA', tGER_EMPRESA);
    end;
    setocc(tGER_EMPRESA, curocc(tGER_EMPRESA) + 1);
  end;
  if (vCdGrupoEmpMatriz <> vCdGrupoEmpBase) then begin
    viParams := '';
    viParams := pParams;
    putitemXml(viParams, 'CD_EMPRESA', vCdEmpCCusto);
    putitemXml(viParams, 'IN_ESTORNO', True);
    voParams := activateCmp('PRDSVCO006', 'atualizaSaldo', viParams); (*,,,, *)
    if (xStatus < 0) then begin
      Result := voParams;
      return(-1); exit;
    end;
    viParams := '';
    viParams := pParams;
    putitemXml(viParams, 'CD_EMPRESA', vCdEmpMatCCusto);
    voParams := activateCmp('PRDSVCO006', 'atualizaSaldo', viParams); (*,,,, *)
    if (xStatus < 0) then begin
      Result := voParams;
      return(-1); exit;
    end;
  end;

  return(0); exit;
end;

end.
