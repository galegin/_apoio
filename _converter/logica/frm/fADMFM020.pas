unit fADMFM020;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, fFormTouch, ExtCtrls, cPanel, cDatasetUnf;

type
  TF_ADMFM020 = class(T_FormTouch)
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
  private
    tADM_USUACES,
    tADM_USUARIO,
    tGLB_SENHAESPEC,
    tLOG_BIOMETRIA,
    tLOG_USUBIOPER,
    tSIS_DUMMY : TcDatasetUnf;
    function getParam(pParams : String = '') : String;
    function setEntidade(pParams : String = '') : String;
    function preEDIT(pParams : String = '') : String;
    function posEDIT(pParams : String = '') : String;
    function preEDIT(pParams : String = '') : String;
    function posEDIT(pParams : String = '') : String;
    function INIT(pParams : String = '') : String;
    function inicializa(pParams : String = '') : String;
    function confirma(pParams : String = '') : String;
    function ativarLeitorBiometrico(pParams : String = '') : String;
    function verificaAcessoBiometria(pParams : String = '') : String;
    function verificaResposta(pParams : String = '') : String;
    function desativarLeitorBiometrico(pParams : String = '') : String;
    function trataFoco(pParams : String = '') : String;
  protected
  public
  published
  end;

implementation

{$R *.dfm}

uses
  cADMSVCO001,
  cActivate, cStatus, cFuncao, cXml, dModulo;

var
  gInTimerAtivo,
  gInUtilizaBiometria,
  gmyTimer,
  gNrTempo,
  gvDtSistema,
  gxCdNivel : String;

procedure TF_ADMFM020.FormCreate(Sender: TObject);
begin
  inherited; //
  setEntidade();
end;

procedure TF_ADMFM020.FormShow(Sender: TObject);
var voParams : String;
begin
  inherited; //

  getParam(vpiParams);

  voParams := preEDIT(vpiParams);
  if (xStatus < 0) then begin
    MensagemTouchErro(itemXml('message', voParams) + #13 + itemXml('adic', voParams));
    TimerSair.Enabled := True;
    return(-1); exit;
  end;

  //recalcula();

  return(0); exit;
end;

procedure TF_ADMFM020.FormActivate(Sender: TObject);
begin
  inherited; //
end;

procedure TF_ADMFM020.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  inherited; //
end;

//---------------------------------------------------------------
function TF_ADMFM020.getParam(pParams : String = '') : String;
//---------------------------------------------------------------
var
  piCdEmpresa : Real;
begin
  piCdEmpresa := itemXmlF('CD_EMPRESA', pParams);
  if (piCdEmpresa = 0) then begin
    piCdEmpresa := itemXmlF('CD_EMPRESA', PARAM_GLB);
  end;

  (* colocar o conteudo da operacao INIT aqui *)

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
end;

//---------------------------------------------------------------
function TF_ADMFM020.setEntidade(pParams : String = '') : String;
//---------------------------------------------------------------
begin
  tADM_USUACES := TcDatasetUnf.GetEntidade(Self, 'ADM_USUACES');
  tADM_USUARIO := TcDatasetUnf.GetEntidade(Self, 'ADM_USUARIO');
  tGLB_SENHAESPEC := TcDatasetUnf.GetEntidade(Self, 'GLB_SENHAESPEC');
  tLOG_BIOMETRIA := TcDatasetUnf.GetEntidade(Self, 'LOG_BIOMETRIA');
  tLOG_USUBIOPER := TcDatasetUnf.GetEntidade(Self, 'LOG_USUBIOPER');
  tSIS_DUMMY := TcDatasetUnf.GetEntidade(Self, 'SIS_DUMMY');
end;

//---------------------------------------------------------------
function TF_ADMFM020.preEDIT(pParams : String) : String;
//---------------------------------------------------------------
const
  cDS_METHOD = 'ADICIONAL=Operação: TF_ADMFM020.preEDIT()';
begin
  return(0); exit;
end;

//---------------------------------------------------------------
function TF_ADMFM020.posEDIT(pParams : String) : String;
//---------------------------------------------------------------
const
  cDS_METHOD = 'ADICIONAL=Operação: TF_ADMFM020.posEDIT()';
begin
  return(0); exit;
end;

//------------------------------------------------------
function TF_ADMFM020.preEDIT(pParams : String) : String;
//------------------------------------------------------
const
  cDS_METHOD = 'ADICIONAL=Operação: TF_ADMFM020.preEDIT()';
begin
  voParams := inicializa(viParams); (* *)
  if (xStatus < 0) then begin
    Result := voParams;
    return(-1); exit;
  end;

  return(0); exit;
end;

//------------------------------------------------------
function TF_ADMFM020.posEDIT(pParams : String) : String;
//------------------------------------------------------
const
  cDS_METHOD = 'ADICIONAL=Operação: TF_ADMFM020.posEDIT()';
begin
  putitemXml(voParams, 'CD_USUARIO', item_f('CD_USUARIO', tADM_USUARIO));
  putitemXml(voParams, 'CD_NIVEL', gxCdNivel);

  return(0); exit;
end;

//---------------------------------------------------
function TF_ADMFM020.INIT(pParams : String) : String;
//---------------------------------------------------
const
  cDS_METHOD = 'ADICIONAL=Operação: TF_ADMFM020.INIT()';
begin
  _Caption := '' + ADMFM + '020 - Validação de Usuário';
end;

//---------------------------------------------------------
function TF_ADMFM020.inicializa(pParams : String) : String;
//---------------------------------------------------------
const
  cDS_METHOD = 'ADICIONAL=Operação: TF_ADMFM020.inicializa()';
var
  vCdUsuario : Real;
  vDsHint, VDSMENSAGEM, viParams, voParams : String;
  vInAcesso : Boolean;
begin
  gInUtilizaBiometria := itemXmlB('IN_UTILIZA_BIOMETRIA', viParams);
  vCdUsuario := itemXmlF('CD_USUARIO', viParams);

  vDsHint := itemXml('DS_HINT', viParams);
  if (vDsHint<>'') then begin
    message/hint vDsHint;
  end;
  if (vCdUsuario <> 0) then begin
    clear_e(tADM_USUARIO);
    putitem_e(tADM_USUARIO, 'CD_USUARIO', vCdUsuario);
    retrieve_e(tADM_USUARIO);

    putitem_e(tSIS_DUMMY, 'NM_LOGIN', item_a('NM_LOGIN', tADM_USUARIO));
    fieldsyntax item_a('NM_LOGIN', tSIS_DUMMY), 'DIM';
    gprompt := item_f('CD_SENHA', tSIS_DUMMY);
  end else begin
    gprompt := item_a('NM_LOGIN', tSIS_DUMMY);
  end;

  sql 'select to_char(sysdate, 'dd/mm/yyyy') from dual', 'gDEF';
  gvDtSistema := gresult;

  if ((item_f('CD_USUARIO', tADM_USUARIO) = '999998') oror (item_f('CD_USUARIO', tADM_USUARIO) = '999999') oror (item_f('CD_USUARIO', tADM_USUARIO) = '999995') oror (item_f('CD_USUARIO', tADM_USUARIO) = '999992') oror (item_f('CD_USUARIO', tADM_USUARIO) = '999993')) then begin
    gInUtilizaBiometria := False;
  end;
  if (gInUtilizaBiometria = True) then begin
    voParams := ativarLeitorBiometrico(viParams); (* *)
    if (xStatus < 0) then begin
      Result := voParams;
      return(-1); exit;
    end;

    newInstance 'UTIMER', gmyTimer;
    gmyTimer -> setRepeat(0);
    gmyTimer -> setmessage('' + gInstancename', + ' 'CONSULTA', '');
    gmyTimer -> start(gNrTempo);

    voParams := verificaAcessoBiometria(viParams); (* item_f('CD_USUARIO', tADM_USUARIO), vInAcesso *)
    if (xStatus < 0) then begin
      Result := voParams;
      return(-1); exit;
    end;
    if (vInAcesso = False) then begin
      viParams := '';

      vDsMensagem := '';
      vDsMensagem := 'Acesso restrito.';
      vDsMensagem := '' + vDsMensagemParametro + ' coorporativo IN_UTILIZA_BIOMETRIA.';
      vDsMensagem := '' + vDsMensagemUsuário + ' ' + NM_LOGIN + '.ADM_USUARIO não possui acesso ao sistema.';
      vDsMensagem := '' + vDsMensagemÉ + ' necessário cadastrar usuário no LOGFM008.';
      vDsMensagem := '' + vDsMensagemVirtualAge' + ';
      putitemXml(viParams, 'TITULO', 'Atenção acesso não autorizado');
      putitemXml(viParams, 'MENSAGEM', vDsMensagem);
      voParams := activateCmp('GERFP008', 'EXEC', viParams); (*,,, *)
      if (xStatus < 0) then begin
        Result := voParams;
        return(-1); exit;
      end;
      return(-1); exit;
    end;

    putitem_e(tSIS_DUMMY, 'NM_LOGIN', item_a('NM_LOGIN', tADM_USUARIO));
    voParams := confirma(viParams); (* *)
    if (xStatus < 0) then begin
      Result := voParams;
      return(-1); exit;
    end;

    voParams := PosEdit(viParams); (* *)
    if (xStatus < 0) then begin
      Result := voParams;
      return(-1); exit;
    end;

    return(0); exit;

  end;

  return(0); exit;
end;

//-------------------------------------------------------
function TF_ADMFM020.confirma(pParams : String) : String;
//-------------------------------------------------------
const
  cDS_METHOD = 'ADICIONAL=Operação: TF_ADMFM020.confirma()';
var
  vComponente : String;
  vCdUsuario, vCdEmpresa, vCdUsuLogado, vCdOperador : Real;
  vInUsuLogado : Boolean;
begin
  vCdOperador := itemXmlF('CD_USUARIO', viParams);
  vCdUsuLogado := itemXmlF('CD_USUARIO', PARAM_GLB);

  if (item_a('NM_LOGIN', tSIS_DUMMY) = '') then begin
    message/info 'Informe o usuário!';
    gprompt := item_a('NM_LOGIN', tSIS_DUMMY);
    return(-1); exit;
  end;
  if (!dbocc(t'ADM_USUARIO')) then begin
    clear_e(tADM_USUACES);
    putitem_e(tADM_USUACES, 'NM_LOGIN20', item_a('NM_LOGIN', tSIS_DUMMY));
    retrieve_e(tADM_USUACES);
    if (xStatus >= 0) then begin
      clear_e(tADM_USUARIO);
      putitem_e(tADM_USUARIO, 'CD_USUARIO', item_f('CD_USUARIO', tADM_USUACES));
      retrieve_e(tADM_USUARIO);
    end else begin
      clear_e(tADM_USUARIO);
      putitem_e(tADM_USUARIO, 'NM_LOGIN', item_a('NM_LOGIN', tSIS_DUMMY));
      retrieve_e(tADM_USUARIO);
    end;
    if (xStatus < 0) then begin
      message/info 'Usuário não cadastrado!';
      if (vCdOperador = 0) then begin
        clear_e(tSIS_DUMMY);
        gprompt := item_a('NM_LOGIN', tSIS_DUMMY);
      end else begin
        putitem_e(tSIS_DUMMY, 'CD_SENHA', '');
        gprompt := item_f('CD_SENHA', tSIS_DUMMY);
      end;
      return(-1); exit;
    end;
  end;
  if (item_f('CD_USUARIO', tADM_USUARIO) = 1 ) or (item_f('CD_USUARIO', tADM_USUARIO) = 999999 ) or (item_f('CD_USUARIO', tADM_USUARIO) = 999998 ) or (item_f('CD_USUARIO', tADM_USUARIO) = 999995 ) or (item_f('CD_USUARIO', tADM_USUARIO) = 999992 ) or (item_f('CD_USUARIO', tADM_USUARIO) = 999993 ) or (item_f('CD_USUARIO', tADM_USUARIO) = 999987 ) or (item_f('CD_USUARIO', tADM_USUARIO) = 999988 ) or (item_f('CD_USUARIO', tADM_USUARIO) = 999989) then begin
    clear_e(tGLB_SENHAESPEC);
    putitem_e(tGLB_SENHAESPEC, 'CD_USUARIO', item_f('CD_USUARIO', tADM_USUARIO));
    putitem_e(tGLB_SENHAESPEC, 'DT_ANOMES', '01/' + gvDtSistema[M] + '/' + gvDtSistema[Y]' + ');
    retrieve_e(tGLB_SENHAESPEC);
    if (xStatus >= 0) then begin
      if (item_f('CD_SENHA', tSIS_DUMMY) <> item_f('CD_SENHA', tGLB_SENHAESPEC)) then begin
        message/info 'Senha incorreta para o usuário!';
        if (vCdOperador = 0) then begin
          clear_e(tSIS_DUMMY);
          gprompt := item_a('NM_LOGIN', tSIS_DUMMY);
        end else begin
          putitem_e(tSIS_DUMMY, 'CD_SENHA', '');
          gprompt := item_f('CD_SENHA', tSIS_DUMMY);
        end;
        return(-1); exit;
      end;

    end else begin

      message/info 'Usuário não cadastrado em senha especiais para o MÊS/ANO corrente !';
      if (vCdOperador = 0) then begin
        clear_e(tSIS_DUMMY);
        gprompt := item_a('NM_LOGIN', tSIS_DUMMY);
      end else begin
        putitem_e(tSIS_DUMMY, 'CD_SENHA', '');
        gprompt := item_f('CD_SENHA', tSIS_DUMMY);
      end;
      return(-1); exit;

    end;
  end else begin

    if (item_f('CD_SENHA', tSIS_DUMMY) <> item_f('CD_SENHA', tADM_USUARIO)) then begin
      message/info 'Senha incorreta para o usuário!';
      if (vCdOperador = 0) then begin
        clear_e(tSIS_DUMMY);
        gprompt := item_a('NM_LOGIN', tSIS_DUMMY);
      end else begin
        clear_e(tSIS_DUMMY);
        putitem_e(tSIS_DUMMY, 'CD_SENHA', '');
        gprompt := item_f('CD_SENHA', tSIS_DUMMY);
      end;
      clear_e(tADM_USUARIO);
      return(-1); exit;
    end;
  end;
  if (item_f('TP_BLOQUEIO', tADM_USUARIO) <> 0) then begin
    message/info 'Usuário bloqueado, contate o administrador!';
    if (vCdOperador = 0) then begin
      clear_e(tSIS_DUMMY);
      gprompt := item_a('NM_LOGIN', tSIS_DUMMY);
    end else begin
      putitem_e(tSIS_DUMMY, 'CD_SENHA', '');
      gprompt := item_f('CD_SENHA', tSIS_DUMMY);
    end;
    clear_e(tADM_USUARIO);
    return(-1); exit;
  end;

  vInUsuLogado := itemXmlB('IN_USULOGADO', viParams);
  if (vInUsuLogado = False) then begin
    if (vCdUsuLogado = item_f('CD_USUARIO', tADM_USUARIO)) then begin
      clear_e(tADM_USUARIO);
      message/info 'Usuário dever ser diferente do usuário de login!';
      if (vCdOperador = 0) then begin
        clear_e(tSIS_DUMMY);
        gprompt := item_a('NM_LOGIN', tSIS_DUMMY);
      end else begin
        putitem_e(tSIS_DUMMY, 'CD_SENHA', '');
        gprompt := item_f('CD_SENHA', tSIS_DUMMY);
      end;
      clear_e(tADM_USUARIO);
      return(-1); exit;
    end;
  end;

  vCdUsuario := item_f('CD_USUARIO', tADM_USUARIO);
  vCdEmpresa := itemXmlF('CD_EMPRESA', PARAM_GLB);
  vComponente := itemXml('DS_COMPONENTE', viParams);
  if (vComponente <> '') then begin
    voParams := activateCmp('LOGSVCO003', 'GetNivelComponente', viParams); (*vCdUsuario,vCdEmpresa,vComponente,gxCdNivel,, *)
    if (xStatus < 0) then begin
      Result := voParams;
      return(-1); exit;
    end;
    if (gxCdNivel = 0) then begin
      message/info 'Usuário sem nível de acesso para o componente: ' + vComponente' + ';
      if (vCdOperador = 0) then begin
        clear_e(tSIS_DUMMY);
        gprompt := item_a('NM_LOGIN', tSIS_DUMMY);
      end else begin
        putitem_e(tSIS_DUMMY, 'CD_SENHA', '');
        gprompt := item_f('CD_SENHA', tSIS_DUMMY);
      end;
      clear_e(tADM_USUARIO);
      return(-1); exit;
    end;
  end;

  macro 'ACCEPT';

  return(0); exit;
end;

//---------------------------------------------------------------------
function TF_ADMFM020.ativarLeitorBiometrico(pParams : String) : String;
//---------------------------------------------------------------------
const
  cDS_METHOD = 'ADICIONAL=Operação: TF_ADMFM020.ativarLeitorBiometrico()';
var
  viParams, voParams, vDsMensagem : String;
  vQtde : Real;
  vInResp : Boolean;
begin
  viParams := '';
  voParams := activateCmp('GERSVCO068', 'ativar', viParams); (*,,, *)
  if (xStatus < 0) then begin
    Result := voParams;
    return(-1); exit;
  end;
    vDsMensagem := '';
    vDsMensagem := 'Erro de comunicação com o Leitor Biometrico.';
    vDsMensagem := '' + vDsMensagemVerique + ' se o Leitor esta conectado ao computador.';
    vDsMensagem := '' + vDsMensagemVerique + ' se o Leitor esta ativo ao lado do relógio do Windows.';
    vDsMensagem := '' + vDsMensagemAtive + ' o Leitor, pasta C:\BIO\BioMetrico.exe.';
    vDsMensagem := '' + vDsMensagemVirtualAge' + ';
    putitemXml(viParams, 'TITULO', 'Erro de comunicação com Leitor Biometrico');
    putitemXml(viParams, 'MENSAGEM', vDsMensagem);
    voParams := activateCmp('GERFP008', 'EXEC', viParams); (*,,, *)
    if (xStatus < 0) then begin
      Result := voParams;
      return(-1); exit;
    end;
    return(-1); exit;
  end else if (xStatus < 0) then begin
    Result := SetStatus(STS_ERROR, {xCdErro} '', '{xCtxErro} ''', '');
    return(-1); exit;
  end;

  vQtde := 0;
  while (vQtde < 200) do begin
    vQtde := vQtde + 1;
    voParams := verificaResposta(viParams); (* vInResp *)
    if (xStatus < 0) then begin
      Result := voParams;
      return(-1); exit;
    end;
    if (vInResp = True) then begin
      vQtde := 201;
    end;
  end;

  return(0); exit;
end;

//----------------------------------------------------------------------
function TF_ADMFM020.verificaAcessoBiometria(pParams : String) : String;
//----------------------------------------------------------------------
const
  cDS_METHOD = 'ADICIONAL=Operação: TF_ADMFM020.verificaAcessoBiometria()';
begin
  if ((piCdUsuario = '999998') oror (piCdUsuario = '999999') oror (piCdUsuario = '999995') oror (piCdUsuario = '999992') oror (piCdUsuario = '999993')) then begin
    poAutorizado := True;
  end else begin
    clear_e(tLOG_BIOMETRIA);
    putitem_e(tLOG_BIOMETRIA, 'CD_USUARIO', piCdUsuario);
    retrieve_e(tLOG_BIOMETRIA);
    if (xStatus >= 0) then begin
      poAutorizado := True;
    end else begin
      clear_e(tLOG_USUBIOPER);
      putitem_e(tLOG_USUBIOPER, 'CD_USUARIO', piCdUsuario);
      retrieve_e(tLOG_USUBIOPER);
      if (xStatus >=0) then begin
        poAutorizado := True;
      end else begin
        poAutorizado := False;
      end;
    end;
  end;

  return(0); exit;
end;

//---------------------------------------------------------------
function TF_ADMFM020.verificaResposta(pParams : String) : String;
//---------------------------------------------------------------
const
  cDS_METHOD = 'ADICIONAL=Operação: TF_ADMFM020.verificaResposta()';
var
  (* boolean vInResp:Out *)
  viParams, voParams, vDsRetorno, vCdSenha, vNmLogin, vDsMensagem : String;
  vDtSistema : TDate;
begin
  viParams := '';
  voParams := activateCmp('GERSVCO068', 'verificaResposta', viParams); (*,,, *)
  if (xStatus < 0) then begin
    Result := voParams;
    return(-1); exit;
  end;
    vDsMensagem := '';
    vDsMensagem := 'Erro de comunicação com o Leitor Biometrico.';
    vDsMensagem := '' + vDsMensagemVerique + ' se o Leitor esta conectado ao computador.';
    vDsMensagem := '' + vDsMensagemVerique + ' se o Leitor esta ativo ao lado do relógio do Windows.';
    vDsMensagem := '' + vDsMensagemAtive + ' o Leitor, pasta C:\BIO\BioMetrico.exe.';
    vDsMensagem := '' + vDsMensagemVirtualAge' + ';
    putitemXml(viParams, 'TITULO', 'Erro de comunicação com Leitor Biometrico');
    putitemXml(viParams, 'MENSAGEM', vDsMensagem);
    voParams := activateCmp('GERFP008', 'EXEC', viParams); (*,,, *)
    if (xStatus < 0) then begin
      Result := voParams;
      return(-1); exit;
    end;
    return(-1); exit;
  end else if (xStatus < 0) then begin
    Result := SetStatus(STS_ERROR, {xCdErro} '', '{xCtxErro} ''', '');
    return(-1); exit;
  end;

  vInResp := 'False';
  if (itemXml('CD_USUARIO', voParams) <> '') then begin
    clear_e(tADM_USUARIO);
    putitem_e(tADM_USUARIO, 'CD_USUARIO', itemXmlF('CD_USUARIO', voParams));
    retrieve_e(tADM_USUARIO);
    if (xStatus >= 0) then begin
      putitem_e(tSIS_DUMMY, 'NM_LOGIN', item_a('NM_LOGIN', tADM_USUARIO));
      vCdSenha := item_f('CD_SENHA', tADM_USUARIO);

      putitem_e(tSIS_DUMMY, 'CD_SENHA', vCdSenha);

      gInTimerAtivo := False;
      deleteInstance gmyTimer;

      voParams := desativarLeitorBiometrico(viParams); (* *)
      if (xStatus < 0) then begin
        Result := voParams;
        return(-1); exit;
      end;

      voParams := trataFoco(viParams); (* True *)
      if (xStatus < 0) then begin
        Result := voParams;
        return(-1); exit;
      end;
      vInResp := True;
    end;
  end;

  return(0); exit;
end;

//------------------------------------------------------------------------
function TF_ADMFM020.desativarLeitorBiometrico(pParams : String) : String;
//------------------------------------------------------------------------
const
  cDS_METHOD = 'ADICIONAL=Operação: TF_ADMFM020.desativarLeitorBiometrico()';
var
  viParams, voParams, vDsMensagem : String;
begin
  viParams := '';
  voParams := activateCmp('GERSVCO068', 'desativar', viParams); (*,,, *)
  if (xStatus < 0) then begin
    Result := voParams;
    return(-1); exit;
  end;
    vDsMensagem := '';
    vDsMensagem := 'Erro de comunicação com o Leitor Biometrico.';
    vDsMensagem := '' + vDsMensagemVerique + ' se o Leitor esta conectado ao computador.';
    vDsMensagem := '' + vDsMensagemVerique + ' se o Leitor esta ativo ao lado do relógio do Windows.';
    vDsMensagem := '' + vDsMensagemAtive + ' o Leitor, pasta C:\BIO\BioMetrico.exe.';
    vDsMensagem := '' + vDsMensagemVirtualAge' + ';
    putitemXml(viParams, 'TITULO', 'Erro de comunicação com Leitor Biometrico');
    putitemXml(viParams, 'MENSAGEM', vDsMensagem);
    voParams := activateCmp('GERFP008', 'EXEC', viParams); (*,,, *)
    if (xStatus < 0) then begin
      Result := voParams;
      return(-1); exit;
    end;
    return(-1); exit;
  end else if (xStatus < 0) then begin
    Result := SetStatus(STS_ERROR, {xCdErro} '', '{xCtxErro} ''', '');
    return(-1); exit;
  end;

  return(0); exit;
end;

//--------------------------------------------------------
function TF_ADMFM020.trataFoco(pParams : String) : String;
//--------------------------------------------------------
const
  cDS_METHOD = 'ADICIONAL=Operação: TF_ADMFM020.trataFoco()';
var
  (*  *)
  viParams, voParams, vDsMensagem : String;
  vStatusFoco : Boolean;
begin
  if (pParams = True) then begin
    vStatusFoco := True;
  end else begin
    vStatusFoco := False;
  end;

  viParams := '';
  putitemXml(viParams 'IN_MINIMIZA', vStatusFoco);
  voParams := activateCmp('GERSVCO068', 'trataFoco', viParams); (*,,, *)
  if (xStatus < 0) then begin
    Result := voParams;
    return(-1); exit;
  end;
    vDsMensagem := '';
    vDsMensagem := 'Erro de comunicação com o Leitor Biometrico.';
    vDsMensagem := '' + vDsMensagemVerique + ' se o Leitor esta conectado ao computador.';
    vDsMensagem := '' + vDsMensagemVerique + ' se o Leitor esta ativo ao lado do relógio do Windows.';
    vDsMensagem := '' + vDsMensagemAtive + ' o Leitor, pasta C:\BIO\BioMetrico.exe.';
    vDsMensagem := '' + vDsMensagemVirtualAge' + ';
    putitemXml(viParams, 'TITULO', 'Erro de comunicação com Leitor Biometrico');
    putitemXml(viParams, 'MENSAGEM', vDsMensagem);
    voParams := activateCmp('GERFP008', 'EXEC', viParams); (*,,, *)
    if (xStatus < 0) then begin
      Result := voParams;
      return(-1); exit;
    end;
    return(-1); exit;
  end else if (xStatus < 0) then begin
    Result := SetStatus(STS_ERROR, {xCdErro} '', '{xCtxErro} ''', '');
    return(-1); exit;
  end;

  return(0); exit;
end;

end.
