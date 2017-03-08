unit cLOGSVCO003;

interface

(* COMPONENTES 
  ADMSVCO001 / ADMSVCO022 / LOGSVCO004 / SICSVCO009 / SISSVCO001

*)        

uses
  Classes, SysUtils, DB,
  cServiceUnf, cDataSetUnf;

type
  T_LOGSVCO003 = class(TcServiceUnf)
  private
    tADM_USUACES,
    tADM_USUARIO,
    tADM_USUCMPEMP,
    tADM_USUEMP,
    tGER_EMPRESA,
    tGER_POOLGRUPO,
    tGLB_SENHAESPE,
    tPES_PESSOA : TcDatasetUnf;
    function getParam(pParams : String = '') : String;
    function setEntidade(pParams : String = '') : String;
  protected
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;    
  published
    function SetSession(pParams : String = '') : String;
    function ExecLoginEmpresa(pParams : String = '') : String;
    function SetLoginParam(pParams : String = '') : String;
    function GetNivelComponente(pParams : String = '') : String;
    function VldAutorizacao(pParams : String = '') : String;
    function montaDescricaoMes(pParams : String = '') : String;
  end;

implementation

uses
  cADMSVCO001,
  cActivate, cStatus, cFuncao, cXml, dModulo;

var
  gDtAnoMesAtual,
  gnmEmpresaBarra,
  gSIS : String;

//---------------------------------------------------------------
constructor T_LOGSVCO003.Create(AOwner: TComponent);
//---------------------------------------------------------------
begin
  inherited Create(AOwner);
  setEntidade('');
end;

//--------------------------------
destructor T_LOGSVCO003.Destroy;
//--------------------------------
begin
  inherited Destroy;
end;

//---------------------------------------------------------------
function T_LOGSVCO003.getParam(pParams : String = '') : String;
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
  putitem(xParam, 'CD_EMPRESA');
  putitem(xParam, 'CD_USRLOGON');
  putitem(xParam, 'CD_USUARIO');
  putitem(xParam, 'NM_EMPRESA_BARRA');
  putitem(xParam, 'NM_LOGIN');
  putitem(xParam, 'NR_SESSAO');
  putitem(xParam, 'TP_PRIVILEGIO');
  putitem(xParam, 'TP_PRIVILEGIOALFA');

  xParam := T_ADMSVCO001.GetParametro(xParam);


  xParamEmp := '';
  putitem(xParamEmp, 'CD_EMPRESA');
  putitem(xParamEmp, 'CD_USRLOGON');
  putitem(xParamEmp, 'CD_USUARIO');
  putitem(xParamEmp, 'NM_EMPRESA_BARRA');
  putitem(xParamEmp, 'NM_LOGIN');
  putitem(xParamEmp, 'NR_SESSAO');
  putitem(xParamEmp, 'TP_PRIVILEGIO');
  putitem(xParamEmp, 'TP_PRIVILEGIOALFA');

  xParamEmp := T_ADMSVCO001.GetParamEmpresa(piCdEmpresa, xParamEmp);

  gnmEmpresaBarra := itemXml('NM_EMPRESA_BARRA', xParamEmp);

end;

//---------------------------------------------------------------
function T_LOGSVCO003.setEntidade(pParams : String = '') : String;
//---------------------------------------------------------------
begin
  tADM_USUACES := GetEntidade('ADM_USUACES');
  tADM_USUARIO := GetEntidade('ADM_USUARIO');
  tADM_USUCMPEMP := GetEntidade('ADM_USUCMPEMP');
  tADM_USUEMP := GetEntidade('ADM_USUEMP');
  tGER_EMPRESA := GetEntidade('GER_EMPRESA');
  tGER_POOLGRUPO := GetEntidade('GER_POOLGRUPO');
  tGLB_SENHAESPE := GetEntidade('GLB_SENHAESPE');
  tPES_PESSOA := GetEntidade('PES_PESSOA');
end;

//----------------------------------------------------------
function T_LOGSVCO003.SetSession(pParams : String) : String;
//----------------------------------------------------------
const
  cDS_METHOD = 'ADICIONAL=Operação: T_LOGSVCO003.SetSession()';
var
  (* numeric piCdEmpresa :IN / numeric piCdGrupoEmpresa :IN / numeric piCdUsuario :IN / string piTpPrivilegio :IN / numeric poSession :OUT *)
  viParams,voParams : String;
begin
  viParams := '';
  putitemXml(viParams, 'CD_EMPRESA', piCdEmpresa);
  putitemXml(viParams, 'CD_GRUPOEMPRESA', piCdGrupoEmpresa);
  putitemXml(viParams, 'CD_USUARIO', piCdUsuario);
  putitemXml(viParams, 'TP_PRIVILEGIO', piTpPrivilegio);
  if (xStatus < 0) then begin
    Result := voParams;
    return(-1); exit;
  end;

  poSession := itemXmlF('NR_SESSAO', voParams);

  return(0); exit;
end;

//----------------------------------------------------------------
function T_LOGSVCO003.ExecLoginEmpresa(pParams : String) : String;
//----------------------------------------------------------------
const
  cDS_METHOD = 'ADICIONAL=Operação: T_LOGSVCO003.ExecLoginEmpresa()';
var
  (* string piNmLogin :IN / string piCdSenha :IN / numeric piCdEmpresa :IN *)
  vSessao, vDiaSistema, vMesSistema : Real;
  voParams, viParams, vDescMes : String;
  vDtSistema : TDate;
begin
  clear_e(tADM_USUACES);
  putitem_e(tADM_USUACES, 'NM_LOGIN20', piNmLogin);
  retrieve_e(tADM_USUACES);
  if (xStatus >= 0) then begin
    clear_e(tADM_USUARIO);
    putitem_e(tADM_USUARIO, 'CD_USUARIO', item_f('CD_USUARIO', tADM_USUACES));
    retrieve_o(tADM_USUARIO);
    if (xStatus = -7) then begin
      retrieve_x(tADM_USUARIO);
    end;
    piNmLogin := item_a('NM_LOGIN', tADM_USUARIO);
  end;

  clear_e(tADM_USUARIO);
  putitem_e(tADM_USUARIO, 'NM_LOGIN', piNmLogin);
  retrieve_e(tADM_USUARIO);
  if (xStatus < 0) then begin
    voParams := SetErroApl(viParams); (* 'ERRO=-1;
    return(-1); exit;
  end;
  if (item_f('TP_PRIVILEGIO', tADM_USUARIO) <> 2) then begin
    clear_e(tADM_USUEMP);
    putitem_e(tADM_USUEMP, 'CD_USUARIO', item_f('CD_USUARIO', tADM_USUARIO));
    retrieve_e(tADM_USUEMP);
    if (xStatus >= 0) then begin
      clear_e(tADM_USUEMP);
      putitem_e(tADM_USUEMP, 'CD_USUARIO', item_f('CD_USUARIO', tADM_USUARIO));
      putitem_e(tADM_USUEMP, 'CD_EMPRESA', piCdEmpresa);
      retrieve_e(tADM_USUEMP);
      if (xStatus < 0) then begin
        voParams := SetErroApl(viParams); (* 'ERRO=-1;
        return(-1); exit;
      end;
    end;
  end;
  if (item_f('CD_USUARIO', tADM_USUARIO) = 1)  or (item_f('CD_USUARIO', tADM_USUARIO) = 999987)  or (item_f('CD_USUARIO', tADM_USUARIO) = 999988)  or (item_f('CD_USUARIO', tADM_USUARIO) = 999989)  or %\ then begin
    (putitem_e(tADM_USUARIO, 'CD_USUARIO', 999998)  or (item_f('CD_USUARIO', tADM_USUARIO), 999999)  or (item_f('CD_USUARIO', tADM_USUARIO), 999995)  or (item_f('CD_USUARIO', tADM_USUARIO), 999992)  or
    (putitem_e(tADM_USUARIO, 'CD_USUARIO', 999993));
    sql 'select to_char(sysdate, 'dd/mm/yyyy') from dual', 'gDEF';
    vDtSistema := gresult;

    vDescMes := '';
    voParams := montaDescricaoMes(viParams); (* vDtSistema[M], vDescMes *)

    gDtAnoMesAtual := '01/' + vDtSistema[M] + '/' + vDtSistema[Y]' + ';
    clear_e(tGLB_SENHAESPE);
    putitem_e(tGLB_SENHAESPE, 'CD_USUARIO', item_f('CD_USUARIO', tADM_USUARIO));
    putitem_e(tGLB_SENHAESPE, 'DT_ANOMES', gDtAnoMesAtual);
    retrieve_e(tGLB_SENHAESPE);
    if (xStatus < 0) then begin
      if (item_f('CD_USUARIO', tADM_USUARIO) = 999999) then begin
        clear_e(tGLB_SENHAESPE);
        putitem_e(tGLB_SENHAESPE, 'CD_USUARIO', item_f('CD_USUARIO', tADM_USUARIO));
        putitem_e(tGLB_SENHAESPE, 'DT_ANOMES', '<' + gDtAnoMesAtual' + ');
        retrieve_e(tGLB_SENHAESPE);
        if (xStatus > 0) then begin
          setocc(tGLB_SENHAESPE, -1);
        end else begin
          voParams := SetErroApl(viParams); (* 'ERRO=-1;
          return(-1); exit;
        end;
      end else begin

        if (vDescMes <> '') then begin
          voParams := SetErroApl(viParams); (* 'ERRO=-1;
          return(-1); exit;
        end else begin
          voParams := SetErroApl(viParams); (* 'ERRO=-1;
          return(-1); exit;
        end;
      end;
    end;
    if (piCdSenha <> item_f('CD_SENHA', tGLB_SENHAESPE)) then begin
      voParams := SetErroApl(viParams); (* 'ERRO=-1;
      exit (-6);
    end;
  end else begin
    if (piCdSenha <> item_f('CD_SENHA', tADM_USUARIO)) then begin
      voParams := SetErroApl(viParams); (* 'ERRO=-1;
      exit (-6);
    end;
  end;
  if (item_f('TP_BLOQUEIO', tADM_USUARIO)=1) then begin
    voParams := SetErroApl(viParams); (* 'ERRO=-1;
    exit (-4);
  end;
  if (item_f('TP_BLOQUEIO', tADM_USUARIO)=2)  and (item_a('NM_LOGIN', tADM_USUARIO) <> 'VIRTUAL') then begin
    voParams := SetErroApl(viParams); (* 'ERRO=-1;
    exit (-5);

  end;

  putitem_e(tGER_EMPRESA, 'CD_EMPRESA', piCdEmpresa);
  retrieve_e(tGER_EMPRESA);
  if (xStatus < 0) then begin
    voParams := SetErroProc(viParams); (* 'ERRO=-1;

    return(-1); exit;
  end;

  putitem_e(tGER_POOLGRUPO, 'CD_GRUPOEMPRESA', item_f('CD_GRUPOEMPRESA', tGER_EMPRESA));
  retrieve_e(tGER_POOLGRUPO);
  if (xStatus >= 0) then begin
    gModulo.gCdPoolEmpresa := item_f('CD_POOLEMPRESA', tGER_POOLGRUPO);
  end else begin
    gModulo.gCdPoolEmpresa := '';
  end;

  putitem_e(tPES_PESSOA, 'CD_PESSOA', item_f('CD_PESSOA', tGER_EMPRESA));
  retrieve_e(tPES_PESSOA);
  if (xStatus < 0) then begin
    return(-1); exit;
  end else begin
    if (item_b('IN_INATIVO', tPES_PESSOA) = True) then begin
      if (item_f('CD_USUARIO', tADM_USUARIO) <> 1      ) and (item_f('CD_USUARIO', tADM_USUARIO) <> 999987 ) and (item_f('CD_USUARIO', tADM_USUARIO) <> 999988 ) and (item_f('CD_USUARIO', tADM_USUARIO) <> 999989 ) and (%\ then begin
          item_f('CD_USUARIO', tADM_USUARIO) <> 999998 ) and (item_f('CD_USUARIO', tADM_USUARIO) <> 999999 ) and (item_f('CD_USUARIO', tADM_USUARIO) <> 999996 ) and (item_f('CD_USUARIO', tADM_USUARIO) <> 999995 ) and (
        item_f('CD_USUARIO', tADM_USUARIO) <> 999992 ) and (item_f('CD_USUARIO', tADM_USUARIO) <> 999993);
        voParams := SetErroApl(viParams); (* 'ERRO=-1;
        return(-1); exit;
      end;
    end;
  end;
  if (item_f('TP_PRIVILEGIO', tADM_USUARIO) <> '2')  and (item_f('TP_PRIVILEGIO', tADM_USUARIO) <> '3')  and (item_f('TP_PRIVILEGIO', tADM_USUARIO) <> '5')  and (item_f('TP_PRIVILEGIO', tADM_USUARIO) <> 'R') then begin
    clear_e(tADM_USUCMPEMP);
    putitem_e(tADM_USUCMPEMP, 'CD_USUARIO', item_f('CD_USUARIO', tADM_USUARIO));
    putitem_e(tADM_USUCMPEMP, 'CD_EMPRESA', PICDEMPRESA);
    retrieve_e(tADM_USUCMPEMP);
    if (xStatus < 0) then begin
      voParams := SetErroApl(viParams); (* 'ERRO=-1;
      return(-1); exit;
    end;
  end;
  if (gModulo.gMenu) then begin
    vSessao := itemXmlF('NR_SESSAO', gModulo.gParamUsr);
    viParams := '';
    putitemXml(viParams, 'NR_SESSAO', vSessao);
    putitemXml(viParams, 'NR_CONTROLE', 27);
    voParams := activateCmp('SISSVCO001', 'getSessaoLogout', viParams); (*,,, *)

    if (xStatus < 0) then begin
      Result := voParams;
      return(-1); exit;
    end;
  end;
  if (xStatus < 0) then begin
    Result := voParams;
    return(-1); exit;
  end;

  clear_e(tPES_PESSOA);
  putitem_e(tPES_PESSOA, 'CD_PESSOA', item_f('CD_PESSOA', tGER_EMPRESA));
  retrieve_e(tPES_PESSOA);
  if (xStatus >= 0) then begin
    if (item_b('IN_INATIVO', tPES_PESSOA) = True) then begin
      voParams := SetErroApl(viParams); (* 'ERRO=-1;
      exit(-10);
    end;
  end;

  return(0); exit;
end;

//-------------------------------------------------------------
function T_LOGSVCO003.SetLoginParam(pParams : String) : String;
//-------------------------------------------------------------
const
  cDS_METHOD = 'ADICIONAL=Operação: T_LOGSVCO003.SetLoginParam()';
var
  (* numeric piCdEmpresa :IN / numeric piCdGrupoEmpresa:IN / string piNmEmpresa :IN / numeric piCdUsuario :IN / numeric piTpPrivilegio :IN / string piDsUF :IN *)
  vDtSistema : TDate;
  vSession, vInModuloPedido, vCdTerminal : Real;
  voParams, viParams, vDsLstParamGlobal : String;
  vInManterSessao : Boolean;
begin
  vCdTerminal := itemXmlF('CD_TERMINAL', PARAM_GLB);
  vInManterSessao := itemXmlB('IN_MANTERSESSAO', pParams);

  clear_e(tADM_USUARIO);
  putitem_e(tADM_USUARIO, 'CD_USUARIO', piCdUsuario);
  retrieve_e(tADM_USUARIO);
  if (xStatus < 0) then begin
    voParams := SetErroApl(viParams); (* 'ERRO=-1;
  end else begin
    vDtSistema := itemXml('DT_SISTEMA', PARAM_GLB);
    gappltitle := '' + piNmEmpresa + ' ';
  end;
  if (vInManterSessao <> True) then begin
    if (xStatus < 0) then begin
    end;
  end;

  gModulo.gCdEmpresa := piCdEmpresa;
  gModulo.gCdGrupoEmpresa := piCdGrupoEmpresa;
  gModulo.gNmEmpresa := piNmEmpresa;
  gModulo.gCdUsuario := piCdUsuario;

  putitemXml(gModulo.GPARAMUSR, 'CD_USUARIO', piCdUsuario);
  putitemXml(gModulo.GPARAMUSR, 'NM_LOGIN', item_a('NM_LOGIN', tADM_USUARIO));
  putitemXml(gModulo.GPARAMUSR, 'CD_USRLOGON', piCdUsuario);
  putitemXml(gModulo.GPARAMUSR, 'TP_PRIVILEGIO', piTpPrivilegio);
  putitemXml(gModulo.GPARAMUSR, 'TP_PRIVILEGIOALFA', item_f('TP_PRIVILEGIO', tADM_USUARIO));
  putitem(xParamEmp,  'NM_EMPRESA_BARRA');

  if (vInManterSessao <> True) then begin
    putitemXml(gModulo.GPARAMUSR, 'NR_SESSAO', vSession);
  end;

  viParams := '';
  putitemXml(viParams, 'CD_EMPRESA', gModulo.gCdEmpresa);
  xParamEmp := T_ADMSVCO001.GetParamEmpresa(piCdEmpresa, xParamEmp); (*,,gModulo.gParamEmp,, *)

  gnmEmpresaBarra := itemXml('NM_EMPRESA_BARRA', gModulo.gParamEmp);
  if (gnmEmpresaBarra <> '') then begin
    gModulo.gNmEmpresa := gnmEmpresaBarra;
  end;

  viParams := '';
  xParam := T_ADMSVCO001.GetParametro(xParam); (*,,vDsLstParamGlobal,, *)

  xParam := T_ADMSVCO001.GetParametro(xParam); (*'SIS',gSIS,, *)
  end;

  PARAM_GLB := '' + vDsLstParamGlobal + ';

  viParams := '';
  putitemXml(viParams, 'CD_EMPRESA', gModulo.gCdEmpresa);
  voParams := activateCmp('SICSVCO009', 'validaCentroCusto', viParams); (*,,,, *)
  if (xStatus < 0) then begin
    Result := voParams;
    return(-1); exit;
  end;
  putitemXml(PARAM_GLB, 'CD_EMP', itemXmlF('CD_CENTROCUSTO', voParams));

  vInModuloPedido := itemXmlB('IN_MODULO_PEDIDO', PARAM_GLB);
  if (vInModuloPedido = 1) then begin
    putitemXml(PARAM_GLB, 'DT_SISTEMA', Date);
  end;

  putitemXml(PARAM_GLB, 'CD_TERMINAL', vCdTerminal);

  return(0); exit;
end;

//------------------------------------------------------------------
function T_LOGSVCO003.GetNivelComponente(pParams : String) : String;
//------------------------------------------------------------------
const
  cDS_METHOD = 'ADICIONAL=Operação: T_LOGSVCO003.GetNivelComponente()';
var
  (* string piCdUsuario :IN / string piCdEmpresa :IN / string piCdComponente :IN / numeric poCdNivel :OUT *)
  viParams, voParams : String;
  vComponente : String;
begin
  clear_e(tADM_USUARIO);
  putitem_e(tADM_USUARIO, 'CD_USUARIO', piCdUsuario);
  retrieve_e(tADM_USUARIO);
  if (xStatus >= 0) then begin
    if (item_f('TP_PRIVILEGIO', tADM_USUARIO) = '2')  or (item_f('TP_PRIVILEGIO', tADM_USUARIO) = '3') then begin
      poCdNivel := 5;

    end else if (item_f('TP_PRIVILEGIO', tADM_USUARIO) = '5') then begin
      clear_e(tADM_USUEMP);
      putitem_e(tADM_USUEMP, 'CD_USUARIO', item_f('CD_USUARIO', tADM_USUARIO));
      retrieve_e(tADM_USUEMP);
      if (xStatus >= 0) then begin
        poCdNivel := 5;
      end else begin
        poCdNivel := 0;
      end;
    end;
  end;
  if ((poCdNivel <> 5)  and (item_f('TP_PRIVILEGIO', tADM_USUARIO) <> '5')) then begin
    clear_e(tADM_USUCMPEMP);
    putitem_e(tADM_USUCMPEMP, 'CD_USUARIO', piCdUsuario);
    putitem_e(tADM_USUCMPEMP, 'CD_EMPRESA', piCdEmpresa);
    putitem_e(tADM_USUCMPEMP, 'CD_COMPONENTE', piCdComponente);
    retrieve_e(tADM_USUCMPEMP);
    if (xStatus < 0) then begin
      poCdNivel := 0;

    end else begin
      poCdNivel := item_f('CD_NIVEL', tADM_USUCMPEMP);
      if (poCdNivel = 1) then begin
        poCdNivel := 3;
      end;
    end;
  end;

  viParams := '';
  putitemXml(viParams, 'CD_USUARIO', piCdUsuario);
  putitemXml(viParams, 'CD_COMPONENTE', piCdComponente);
  putitemXml(viParams, 'CD_NIVEL', poCdNivel);
  putitemXml(viParams, 'TP_LOG', 5);
  newinstance 'ADMSVCO022', 'ADMSVCO022', 'TRANSACTION=TRUE';
  voParams := activateCmp('ADMSVCO022', 'gravaLog', viParams); (*,,,, *)
  if (xStatus < 0) then begin
    Result := voParams;
    return(-1); exit;
  end;
    return(-1); exit;
  end else if (xStatus < 0) then begin
    Result := SetStatus(STS_ERROR, {xCdErro} '', '{xCtxErro} ''', '');

    return(-1); exit;
  end;
  deleteinstance 'ADMSVCO022';

  vComponente := piCdComponente;
  vComponente := vComponente[4:2];
  if (vComponente <> 'FL') then begin
    viParams := '';
    putitemXml(viParams, 'CD_USUARIO', piCdUsuario);
    putitemXml(viParams, 'CD_COMPONENTE', piCdComponente);
    newinstance 'LOGSVCO004', 'LOGSVCO004', 'TRANSACTION=TRUE';
    voParams := activateCmp('LOGSVCO004', 'gravaUltComponente', viParams); (*,,,, *)
    if (xStatus < 0) then begin
      Result := voParams;
      return(-1); exit;
    end;
      return(-1); exit;
    end else if (xStatus < 0) then begin
      Result := SetStatus(STS_ERROR, {xCdErro} '', '{xCtxErro} ''', '');

      return(-1); exit;
    end;
    deleteinstance 'LOGSVCO004';

  end;
  return(0); exit;
end;

//--------------------------------------------------------------
function T_LOGSVCO003.VldAutorizacao(pParams : String) : String;
//--------------------------------------------------------------
const
  cDS_METHOD = 'ADICIONAL=Operação: T_LOGSVCO003.VldAutorizacao()';
begin
  clear_e(tADM_USUARIO);
  putitem_e(tADM_USUARIO, 'NM_LOGIN', piNmLogin);
  retrieve_e(tADM_USUARIO);
  if (xStatus < 0) then begin
    voParams := SetErroApl(viParams); (* 'ERRO=-1;
  end else begin
    if (piCdSenha <> item_f('CD_SENHA', tADM_USUARIO))  or (item_f('TP_BLOQUEIO', tADM_USUARIO) > 0) then begin
      voParams := SetErroApl(viParams); (* 'ERRO=-1;
    end else begin
      piCdUsuario := item_f('CD_USUARIO', tADM_USUARIO);
      voParams := SetErroApl(viParams); (* 'ERRO=1000;
    end;
  end;

  return(0); exit;
end;

//-----------------------------------------------------------------
function T_LOGSVCO003.montaDescricaoMes(pParams : String) : String;
//-----------------------------------------------------------------
const
  cDS_METHOD = 'ADICIONAL=Operação: T_LOGSVCO003.montaDescricaoMes()';
begin
  poDescMes := '';

  if (piMes > 0) then begin
    selectcase(piMes);
      case 01;
        poDescMes := 'Janeiro';

      case 02;
        poDescMes := 'Fevereiro';

      case 03;
        poDescMes := 'Março';

      case 04;
        poDescMes := 'Abril';

      case 05;
        poDescMes := 'Maio';

      case 06;
        poDescMes := 'Junho';

      case 07;
        poDescMes := 'Julho';

      case 08;
        poDescMes := 'Agosto';

      case 09;
        poDescMes := 'Setembro';

      case 10;
        poDescMes := 'Outubro';

      case 11;
        poDescMes := 'Novembro';

      case 12;
        poDescMes := 'Dezembro';

    endselectcase;

  end;

  return(0); exit;

end;


end.
