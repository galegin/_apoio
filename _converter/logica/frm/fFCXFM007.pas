unit fFCXFM007;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, fFormTouch, ExtCtrls, cPanel, cDatasetUnf;

type
  TF_FCXFM007 = class(T_FormTouch)
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
  private
    tADM_USUARIO,
    tFCC_CTAPES,
    tFCC_TPMANUTUSU,
    tGER_EMPRESA,
    tGER_MODFINC,
    tGER_TERMINAL,
    tSIS_DUMMY : TcDatasetUnf;
    function getParam(pParams : String = '') : String;
    function setEntidade(pParams : String = '') : String;
    function preEDIT(pParams : String = '') : String;
    function posEDIT(pParams : String = '') : String;
    function posCLEAR(pParams : String = '') : String;
    function preEDIT(pParams : String = '') : String;
    function INIT(pParams : String = '') : String;
    function CLEANUP(pParams : String = '') : String;
    function inicializa(pParams : String = '') : String;
    function confirma(pParams : String = '') : String;
    function validaConta(pParams : String = '') : String;
    function imprimeReciboSuprimento(pParams : String = '') : String;
    function carregaLista(pParams : String = '') : String;
    function carregaListaOutroUsuario(pParams : String = '') : String;
    function inicializaOutroUsuario(pParams : String = '') : String;
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
  gCdusuario,
  gInPdvOtimizado,
  gNrCtaPes,
  gVlInicial : String;

procedure TF_FCXFM007.FormCreate(Sender: TObject);
begin
  inherited; //
  setEntidade();
end;

procedure TF_FCXFM007.FormShow(Sender: TObject);
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

procedure TF_FCXFM007.FormActivate(Sender: TObject);
begin
  inherited; //
end;

procedure TF_FCXFM007.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  inherited; //
end;

//---------------------------------------------------------------
function TF_FCXFM007.getParam(pParams : String = '') : String;
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
function TF_FCXFM007.setEntidade(pParams : String = '') : String;
//---------------------------------------------------------------
begin
  tADM_USUARIO := TcDatasetUnf.GetEntidade(Self, 'ADM_USUARIO');
  tFCC_CTAPES := TcDatasetUnf.GetEntidade(Self, 'FCC_CTAPES');
  tFCC_TPMANUTUSU := TcDatasetUnf.GetEntidade(Self, 'FCC_TPMANUTUSU');
  tGER_EMPRESA := TcDatasetUnf.GetEntidade(Self, 'GER_EMPRESA');
  tGER_MODFINC := TcDatasetUnf.GetEntidade(Self, 'GER_MODFINC');
  tGER_TERMINAL := TcDatasetUnf.GetEntidade(Self, 'GER_TERMINAL');
  tSIS_DUMMY := TcDatasetUnf.GetEntidade(Self, 'SIS_DUMMY');
end;

//---------------------------------------------------------------
function TF_FCXFM007.preEDIT(pParams : String) : String;
//---------------------------------------------------------------
const
  cDS_METHOD = 'ADICIONAL=Operação: TF_FCXFM007.preEDIT()';
begin
  return(0); exit;
end;

//---------------------------------------------------------------
function TF_FCXFM007.posEDIT(pParams : String) : String;
//---------------------------------------------------------------
const
  cDS_METHOD = 'ADICIONAL=Operação: TF_FCXFM007.posEDIT()';
begin
  return(0); exit;
end;

//-------------------------------------------------------
function TF_FCXFM007.posCLEAR(pParams : String) : String;
//-------------------------------------------------------
const
  cDS_METHOD = 'ADICIONAL=Operação: TF_FCXFM007.posCLEAR()';
begin
  putitem_e(tSIS_DUMMY, 'NR_CAIXA', gVlInicial);

  if (item_f('NR_CAIXA', tSIS_DUMMY) = 1) then begin
    putitem_e(tSIS_DUMMY, 'NR_CTA', gNrCtaPes);
  end else if (item_f('NR_CAIXA', tSIS_DUMMY) = 2) then begin
    putitem_e(tSIS_DUMMY, 'NR_CTA', itemXmlF('CD_CTAPES_CXFILIAL', xParamEmp));
  end else if (item_f('NR_CAIXA', tSIS_DUMMY) = 3) then begin
    putitem_e(tSIS_DUMMY, 'NR_CTA', itemXmlF('CD_CTAPES_CXMATRIZ', xParamEmp));
  end;

  voParams := inicializa(viParams); (* *)
  if (xStatus < 0) then begin
    Result := voParams;
    return(-1); exit;
  end;

  return(0); exit;
end;

//------------------------------------------------------
function TF_FCXFM007.preEDIT(pParams : String) : String;
//------------------------------------------------------
const
  cDS_METHOD = 'ADICIONAL=Operação: TF_FCXFM007.preEDIT()';
begin
  if (gInPdvOtimizado <> True) then begin
    voParams := carregaLista(viParams); (* *)
    if (xStatus < 0) then begin
      Result := voParams;
      return(-1); exit;
    end;
    voParams := inicializa(viParams); (* *)
    if (xStatus < 0) then begin
      Result := voParams;
      return(-1); exit;
    end;
  end else begin
    voParams := carregaListaOutroUsuario(viParams); (* *)
    if (xStatus < 0) then begin
      Result := voParams;
      return(-1); exit;
    end;
    voParams := inicializaOutroUsuario(viParams); (* *)
    if (xStatus < 0) then begin
      Result := voParams;
      return(-1); exit;
    end;
  end;

  return(0); exit;
end;

//---------------------------------------------------
function TF_FCXFM007.INIT(pParams : String) : String;
//---------------------------------------------------
const
  cDS_METHOD = 'ADICIONAL=Operação: TF_FCXFM007.INIT()';
begin
  _Caption := '' + FCXFM + '007 - Suprimento de Caixa';

  xParam := '';
  putitem(xParam,  'CD_TPMANUT_CXUSUARIO');
  putitem(xParam,  'CD_TPMANUT_CXFILIAL');
  putitem(xParam,  'CD_TPMANUT_CXMATRIZ');
  xParam := T_ADMSVCO001.GetParametro(xParam); (*xParam,xParam,, *)

  xParamEmp := '';
  putitem(xParamEmp,  'IN_CONTROLE_PAGPORT');
  putitem(xParamEmp,  'CD_CTAPES_CXFILIAL');
  putitem(xParamEmp,  'CD_CTAPES_CXMATRIZ');
  putitem(xParamEmp,  'IN_CAIXA_TERMINAL');
  putitem(xParamEmp,  'NR_MODREC_SUPRIMENTO');
  putitem(xParamEmp,  'IN_PDV_OTIMIZADO');
  xParamEmp := T_ADMSVCO001.GetParamEmpresa(piCdEmpresa, xParamEmp); (*itemXml('CD_EMPRESA', *)

  gInPdvOtimizado := itemXmlB('IN_PDV_OTIMIZADO', xParamEmp);

end;

//------------------------------------------------------
function TF_FCXFM007.CLEANUP(pParams : String) : String;
//------------------------------------------------------
const
  cDS_METHOD = 'ADICIONAL=Operação: TF_FCXFM007.CLEANUP()';
begin
end;

//---------------------------------------------------------
function TF_FCXFM007.inicializa(pParams : String) : String;
//---------------------------------------------------------
const
  cDS_METHOD = 'ADICIONAL=Operação: TF_FCXFM007.inicializa()';
var
  vInCxTerminal : Real;
begin
  vInCxTerminal := itemXmlB('IN_CAIXA_TERMINAL', xParamEmp);

  if (vInCxTerminal = 0) then begin
    fieldsyntax item_f('CD_TERMINAL', tGER_TERMINAL), 'DIM';
    fieldsyntax item_f('CD_USUARIO', tADM_USUARIO), '';
    fieldsyntax item_a('BT_LTERMINAL', tGER_TERMINAL), 'DIM';
    fieldsyntax item_a('BT_LUSUARIO', tADM_USUARIO), '';
  end else begin
    fieldsyntax item_f('CD_USUARIO', tADM_USUARIO), 'DIM';
    fieldsyntax item_f('CD_TERMINAL', tGER_TERMINAL), '';
    fieldsyntax item_a('BT_LUSUARIO', tADM_USUARIO), 'DIM';
    fieldsyntax item_a('BT_LTERMINAL', tGER_TERMINAL), '';
  end;

  clear_e(tGER_EMPRESA);
  putitem_e(tGER_EMPRESA, 'CD_EMPRESA', itemXmlF('CD_EMPRESA', PARAM_GLB));
  retrieve_e(tGER_EMPRESA);
  if (xStatus < 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Empresa não encontrada!', '');
    gprompt := item_f('CD_USUARIO', tADM_USUARIO);
    return(-1); exit;
  end;

  return(0); exit;
end;

//-------------------------------------------------------
function TF_FCXFM007.confirma(pParams : String) : String;
//-------------------------------------------------------
const
  cDS_METHOD = 'ADICIONAL=Operação: TF_FCXFM007.confirma()';
var
  viParams, voParams : String;
  vCdTerminal, vNrSeq, vCdTerminalDest, vNrSeqDest : Real;
  vDtAbertura, vDtAberturaDest : TDate;
begin
  if (item_f('NR_CTAPES', tSIS_DUMMY) = '') then begin
    message/info 'Conta para suprimento não informada!';
    gprompt := item_f('CD_USUARIO', tADM_USUARIO);
    return(-1); exit;
  end;
  if (item_f('NR_CTA', tSIS_DUMMY) = item_f('NR_CTAPES', tSIS_DUMMY)) then begin
    message/info 'Não é possível transferir para a mesma conta!';
    gprompt := item_f('CD_USUARIO', tADM_USUARIO);
    return(-1); exit;
  end;
  if (item_f('VL_ABERTURA', tSIS_DUMMY) <= 0) then begin
    message/info 'Valor de suprimento incorreto!';
    gprompt := item_f('VL_ABERTURA', tSIS_DUMMY);
    return(-1); exit;
  end;
  if (item_f('NR_CAIXA', tSIS_DUMMY) = 1) then begin
    viParams := '';
    voParams := activateCmp('FCXSVCO001', 'buscaCaixa', viParams); (*,,,, *)
    if (xStatus < 0) then begin
      Result := voParams;
      return(-1); exit;
    end;

    vCdTerminal := itemXmlF('CD_TERMINAL', voParams);
    vDtAbertura := itemXml('DT_ABERTURA', voParams);
    vNrSeq := itemXmlF('NR_SEQ', voParams);
  end;

  viParams := '';
  putitemXml(viParams, 'CD_OPERCX', item_f('CD_USUARIO', tADM_USUARIO));
  putitemXml(viParams, 'CD_TERMINAL', item_f('CD_TERMINAL', tGER_TERMINAL));
  voParams := activateCmp('FCXSVCO001', 'buscaCaixaOper', viParams); (*,,,, *)
  if (xStatus < 0) then begin
    Result := voParams;
    return(-1); exit;
  end;

  vCdTerminalDest := itemXmlF('CD_TERMINAL', voParams);
  vDtAberturaDest := itemXml('DT_ABERTURA', voParams);
  vNrSeqDest := itemXmlF('NR_SEQ', voParams);

  viParams := '';
  putitemXml(viParams, 'NR_CTAORIGEM', item_f('NR_CTA', tSIS_DUMMY));
  putitemXml(viParams, 'NR_CTADESTINO', item_f('NR_CTAPES', tSIS_DUMMY));
  putitemXml(viParams, 'VL_SUPRIMENTO', item_f('VL_ABERTURA', tSIS_DUMMY));
  putitemXml(viParams, 'CD_TERMINALDEST', vCdTerminalDest);
  putitemXml(viParams, 'DT_ABERTURADEST', vDtAberturaDest);
  putitemXml(viParams, 'NR_SEQDEST', vNrSeqDest);
  putitemXml(viParams, 'DS_OBS', item_a('DS_OBS', tSIS_DUMMY));

  if (item_f('NR_CAIXA', tSIS_DUMMY) = 1) then begin
    putitemXml(viParams, 'IN_CXUSUARIO', True);
    putitemXml(viParams, 'CD_TERMINAL', vCdTerminal);
    putitemXml(viParams, 'DT_ABERTURA', vDtAbertura);
    putitemXml(viParams, 'NR_SEQ', vNrSeq);
  end else begin
    putitemXml(viParams, 'IN_CXUSUARIO', False);
  end;

  putitemXml(viParams, 'TP_PROCESSO', 3);
  putitemXml(viParams, 'IN_MANUAL', True);

  voParams := activateCmp('FCXSVCO002', 'supreCaixa', viParams); (*,,,, *)

  commit;
  if (xStatus < 0) then begin
    rollback;
    return(-1); exit;
  end else begin
    message/info 'Suprimento efetuado com sucesso!';
  end;
  if (gInPdvOtimizado <> True) then begin
    askmess 'Deseja imprimir recibo?', 'Sim, Não';
    if (xStatus = 1) then begin
      voParams := imprimeReciboSuprimento(viParams); (* *)
      if (xStatus < 0) then begin
        Result := voParams;
        return(-1); exit;
      end;
    end;
  end else begin
    voParams := imprimeReciboSuprimento(viParams); (* *)
    if (xStatus < 0) then begin
      Result := voParams;
      return(-1); exit;
    end;
  end;

  return(0); exit;
end;

//----------------------------------------------------------
function TF_FCXFM007.validaConta(pParams : String) : String;
//----------------------------------------------------------
const
  cDS_METHOD = 'ADICIONAL=Operação: TF_FCXFM007.validaConta()';
var
  viParams, voParams, vEmpresa, lstConta : String;
begin
  if (item_f('CD_USUARIO', tADM_USUARIO) > 0)  or (item_f('CD_TERMINAL', tGER_TERMINAL) > 0) then begin
    viParams := '';
    putitemXml(viParams, 'CD_EMPRESA', itemXmlF('CD_EMPRESA', PARAM_GLB));
    putitemXml(viParams, 'CD_OPERADOR', item_f('CD_USUARIO', tADM_USUARIO));
    putitemXml(viParams, 'CD_TERMINAL', item_f('CD_TERMINAL', tGER_TERMINAL));
    voParams := activateCmp('FCCSVCO002', 'buscaContaOperador', viParams); (*,,,, *)
    if (xStatus < 0) then begin
      Result := voParams;
      return(-1); exit;
    end;

    putitem_e(tSIS_DUMMY, 'NR_CTAPES', itemXmlF('NR_CTAPES', voParams));
  end else begin
    putitem_e(tSIS_DUMMY, 'NR_CTAPES', '');
  end;

  return(0); exit;
end;

//----------------------------------------------------------------------
function TF_FCXFM007.imprimeReciboSuprimento(pParams : String) : String;
//----------------------------------------------------------------------
const
  cDS_METHOD = 'ADICIONAL=Operação: TF_FCXFM007.imprimeReciboSuprimento()';
var
  viParams, voParams, vDsConteudo : String;
begin
  if (itemXml('NR_MODREC_SUPRIMENTO', xParamEmp) = '') then begin
    Result := SetStatus(STS_AVISO, 'GEN001', 'Número do modelo de recibo de suprimento não informado no parametro empresa. Parametro -> NR_MODREC_SUPRIMENTO', '');
    return(-1); exit;
  end;

  clear_e(tGER_MODFINC);
  putitem_e(tGER_MODFINC, 'NR_MODFINC', itemXmlF('NR_MODREC_SUPRIMENTO', xParamEmp));
  retrieve_e(tGER_MODFINC);
  if (xStatus < 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN001', 'Modelo de recibo de suprimento não cadastrado.', '');
    return(-1); exit;
  end;

  viParams := '';
  putitemXml(viParams, 'NR_CTAPES_SANGRIA_SUPRIMENTO', item_f('NR_CTAPES', tSIS_DUMMY));
  putitemXml(viParams, 'DT_SANGRIA_SUPRIMENTO', itemXml('DT_SISTEMA', PARAM_GLB));
  putitemXml(viParams, 'VL_SANGRIA_SUPRIMENTO', item_f('VL_ABERTURA', tSIS_DUMMY));
  if (gCdusuario = '') then begin
    gCdusuario := itemXmlF('CD_USUARIO', PARAM_GLB);
  end;
  putitemXml(viParams, 'CD_USU_ESCOLHIDO', gCdUsuario);
  putitemXml(viParams, 'CD_USU_LOGADO', itemXmlF('CD_USUARIO', PARAM_GLB));
  putitemXml(viParams, 'CD_EMPRESA', item_f('CD_EMPRESA', tGER_EMPRESA));
  putitemXml(viParams, 'NR_REC_SANGRIA_SUPRIMENTO', itemXmlF('NR_MODREC_SUPRIMENTO', xParamEmp));
  voParams := activateCmp('GERSVCO028', 'geraReciboSangriaSuprimento', viParams); (*,,,, *)
  if (xStatus < 0) then begin
    Result := voParams;
    return(-1); exit;
  end;

  vDsConteudo := itemXml('DS_CONTEUDO', voParams);
  if (item_a('NM_JOB', tGER_MODFINC) = 'P_LPT1')  or (item_a('NM_JOB', tGER_MODFINC) = 'P_LN03') then begin
    filedump vDsConteudo, 'LPT1';
    if (xStatus < 0) then begin
      Result := SetStatus(STS_ERROR, 'GEN0001', 'Erro ' + xStatus + ' ao imprimir recibo na LPT1!', '');
      return(-1); exit;
    end;
  end else if (item_a('NM_JOB', tGER_MODFINC) = 'P_LPT2')  or (item_a('NM_JOB', tGER_MODFINC) = 'P_PORT2') then begin
    filedump vDsConteudo, 'LPT2';
    if (xStatus < 0) then begin
      Result := SetStatus(STS_ERROR, 'GEN0001', 'Erro ' + xStatus + ' ao imprimir recibo na LPT2!', '');
      return(-1); exit;
    end;
  end else if (item_a('NM_JOB', tGER_MODFINC) = 'P_LPT3') then begin
    filedump vDsConteudo, 'LPT3';
    if (xStatus < 0) then begin
      Result := SetStatus(STS_ERROR, 'GEN0001', 'Erro ' + xStatus + ' ao imprimir recibo na LPT3!', '');
      return(-1); exit;
    end;
  end else if (item_a('NM_JOB', tGER_MODFINC) = 'P_LPT4') then begin
    filedump vDsConteudo, 'LPT4';
    if (xStatus < 0) then begin
      Result := SetStatus(STS_ERROR, 'GEN0001', 'Erro ' + xStatus + ' ao imprimir recibo na LPT4!', '');
      return(-1); exit;
    end;
  end else if (item_a('NM_JOB', tGER_MODFINC) = 'P_LPT5') then begin
    filedump vDsConteudo, 'LPT5';
    if (xStatus < 0) then begin
      Result := SetStatus(STS_ERROR, 'GEN0001', 'Erro ' + xStatus + ' ao imprimir recibo na LPT5!', '');
      return(-1); exit;
    end;
  end else if (item_a('NM_JOB', tGER_MODFINC) = 'P_LPT6') then begin
    filedump vDsConteudo, 'LPT6';
    if (xStatus < 0) then begin
      Result := SetStatus(STS_ERROR, 'GEN0001', 'Erro ' + xStatus + ' ao imprimir recibo na LPT6!', '');
      return(-1); exit;
    end;
  end else if (item_a('NM_JOB', tGER_MODFINC) = 'P_LPT7') then begin
    filedump vDsConteudo, 'LPT7';
    if (xStatus < 0) then begin
      Result := SetStatus(STS_ERROR, 'GEN0001', 'Erro ' + xStatus + ' ao imprimir recibo na LPT7!', '');
      return(-1); exit;
    end;
  end else if (item_a('NM_JOB', tGER_MODFINC) = 'P_LPT8') then begin
    filedump vDsConteudo, 'LPT8';
    if (xStatus < 0) then begin
      Result := SetStatus(STS_ERROR, 'GEN0001', 'Erro ' + xStatus + ' ao imprimir recibo na LPT8!', '');
      return(-1); exit;
    end;
  end else if (item_a('NM_JOB', tGER_MODFINC) = 'P_LPT9') then begin
    filedump vDsConteudo, 'LPT9';
    if (xStatus < 0) then begin
      Result := SetStatus(STS_ERROR, 'GEN0001', 'Erro ' + xStatus + ' ao imprimir recibo na LPT9!', '');
      return(-1); exit;
    end;
  end else begin
    viParams := '';
    putitemXml(viParams, 'DS_CHEQUE', vDsConteudo);
    putitemXml(viParams, 'NM_JOB', item_a('NM_JOB', tGER_MODFINC));
    putitemXml(viParams, 'IN_PREVIEW', True);
    voParams := activateCmp('FCXR007', 'exec', viParams); (*,,,, *)
    if (xStatus < 0) then begin
      Result := voParams;
      return(-1); exit;
    end;
  end;

  return(0); exit;
end;

//-----------------------------------------------------------
function TF_FCXFM007.carregaLista(pParams : String) : String;
//-----------------------------------------------------------
const
  cDS_METHOD = 'ADICIONAL=Operação: TF_FCXFM007.carregaLista()';
var
  vCaixa : String;
  vTpUsuario, vTpFilial, vTpMatriz, vTpBanco, vInCxTerminal : Real;
  vNrCtaUsuario, vNrCtaFilial, vNrCtaMatriz : Real;
begin
  vTpUsuario := itemXmlF('CD_TPMANUT_CXUSUARIO', xParam);
  vTpFilial := itemXmlF('CD_TPMANUT_CXFILIAL', xParam);
  vTpMatriz := itemXmlF('CD_TPMANUT_CXMATRIZ', xParam);
  vInCxTerminal := itemXmlB('IN_CAIXA_TERMINAL', xParamEmp);

  vCaixa := '';

  if (vInCxTerminal = 0) then begin
    clear_e(tFCC_TPMANUTUSU);
    putitem_e(tFCC_TPMANUTUSU, 'CD_EMPRESA', itemXmlF('CD_EMPRESA', PARAM_GLB));
    putitem_e(tFCC_TPMANUTUSU, 'CD_USULIBERADO', itemXmlF('CD_USUARIO', PARAM_GLB));
    putitem_e(tFCC_TPMANUTUSU, 'TP_MANUTENCAO', vTpUsuario);
    retrieve_e(tFCC_TPMANUTUSU);
    if (xStatus >= 0) then begin
      putitemXml(vCaixa, '1', 'Usuário');

      clear_e(tFCC_CTAPES);
      putitem_e(tFCC_CTAPES, 'CD_EMPRESA', itemXmlF('CD_EMPRESA', PARAM_GLB));
      putitem_e(tFCC_CTAPES, 'CD_OPERCAIXA', itemXmlF('CD_USUARIO', PARAM_GLB));
      retrieve_e(tFCC_CTAPES);
      if (xStatus >= 0) then begin
        gNrCtaPes := item_f('NR_CTAPES', tFCC_CTAPES);
      end;

      gVlInicial := 1;
      putitem_e(tSIS_DUMMY, 'NR_CTA', gNrCtaPes);
    end;
  end;

  clear_e(tFCC_TPMANUTUSU);
  putitem_e(tFCC_TPMANUTUSU, 'CD_EMPRESA', itemXmlF('CD_EMPRESA', PARAM_GLB));
  putitem_e(tFCC_TPMANUTUSU, 'CD_USULIBERADO', itemXmlF('CD_USUARIO', PARAM_GLB));
  putitem_e(tFCC_TPMANUTUSU, 'TP_MANUTENCAO', vTpFilial);
  retrieve_e(tFCC_TPMANUTUSU);
  if (xStatus >= 0) then begin
    putitemXml(vCaixa, '2', 'Filial');
    if (gVlInicial = 0) then begin
      gVlInicial := 2;
      putitem_e(tSIS_DUMMY, 'NR_CTA', itemXmlF('CD_CTAPES_CXFILIAL', xParamEmp));
    end;
  end;

  clear_e(tFCC_TPMANUTUSU);
  putitem_e(tFCC_TPMANUTUSU, 'CD_EMPRESA', itemXmlF('CD_EMPRESA', PARAM_GLB));
  putitem_e(tFCC_TPMANUTUSU, 'CD_USULIBERADO', itemXmlF('CD_USUARIO', PARAM_GLB));
  putitem_e(tFCC_TPMANUTUSU, 'TP_MANUTENCAO', vTpMatriz);
  retrieve_e(tFCC_TPMANUTUSU);
  if (xStatus >= 0) then begin
    putitemXml(vCaixa, '3', 'Matriz');
    if (gVlInicial = 0) then begin
      gVlInicial := 3;
      putitem_e(tSIS_DUMMY, 'NR_CTA', itemXmlF('CD_CTAPES_CXMATRIZ', xParamEmp));
    end;
  end;

  valrep (putitem_e(tSIS_DUMMY, 'NR_CAIXA'), vCaixa);
  putitem_e(tSIS_DUMMY, 'NR_CAIXA', gVlInicial);

  return(0); exit;
end;

//-----------------------------------------------------------------------
function TF_FCXFM007.carregaListaOutroUsuario(pParams : String) : String;
//-----------------------------------------------------------------------
const
  cDS_METHOD = 'ADICIONAL=Operação: TF_FCXFM007.carregaListaOutroUsuario()';
var
  viParams, voParams, vCaixa : String;
  vTpMatriz, vTpBanco, vCdUsuario, vCdNivel : Real;
  vNrCtaUsuario, vNrCtaFilial, vNrCtaMatriz : Real;
begin
  viParams := '';
  putitemXml(viParams, 'IN_USULOGADO', True);
  putitemXml(viParams, 'DS_COMPONENTE', FCXFM007);
  putitemXml(viParams, 'DS_TITULO', '');
  voParams := activateCmp('ADMFM020', 'exec', viParams); (*,,, *)
  if (xStatus < 0) then begin
    return(-1); exit;
  end;

  gCdUsuario := itemXmlF('CD_USUARIO', voParams);
  vCdUsuario := itemXmlF('CD_USUARIO', voParams);
  vCdNivel := itemXmlF('CD_NIVEL', voParams);

  vTpMatriz := itemXmlF('CD_TPMANUT_CXMATRIZ', xParam);

  vCaixa := '';

  clear_e(tFCC_TPMANUTUSU);
  putitem_e(tFCC_TPMANUTUSU, 'CD_EMPRESA', itemXmlF('CD_EMPRESA', PARAM_GLB));
  putitem_e(tFCC_TPMANUTUSU, 'CD_USULIBERADO', vCdUsuario);
  putitem_e(tFCC_TPMANUTUSU, 'TP_MANUTENCAO', vTpMatriz);
  retrieve_e(tFCC_TPMANUTUSU);
  if (xStatus >= 0) then begin
    putitemXml(vCaixa, '3', 'Matriz');
    if (gVlInicial = 0) then begin
      gVlInicial := 3;
      putitem_e(tSIS_DUMMY, 'NR_CTA', itemXmlF('CD_CTAPES_CXMATRIZ', xParamEmp));
    end;
  end else begin
    message/error 'Usuário sem nível no caixa Matriz';
    return(0); exit;
  end;

  valrep (putitem_e(tSIS_DUMMY, 'NR_CAIXA'), vCaixa);
  putitem_e(tSIS_DUMMY, 'NR_CAIXA', gVlInicial);

  return(0); exit;
end;

//---------------------------------------------------------------------
function TF_FCXFM007.inicializaOutroUsuario(pParams : String) : String;
//---------------------------------------------------------------------
const
  cDS_METHOD = 'ADICIONAL=Operação: TF_FCXFM007.inicializaOutroUsuario()';
var
  vInCxTerminal : Real;
begin
  vInCxTerminal := itemXmlB('IN_CAIXA_TERMINAL', xParamEmp);

  fieldsyntax item_f('NR_CAIXA', tSIS_DUMMY), 'DIM';
  if (vInCxTerminal = 0) then begin
    clear_e(tADM_USUARIO);
    putitem_e(tADM_USUARIO, 'CD_USUARIO', itemXmlF('CD_USUARIO', PARAM_GLB));
    retrieve_e(tADM_USUARIO);
    fieldsyntax item_f('CD_TERMINAL', tGER_TERMINAL), 'DIM';
    fieldsyntax item_f('CD_USUARIO', tADM_USUARIO), 'DIM';
    fieldsyntax item_a('BT_LTERMINAL', tGER_TERMINAL), 'DIM';
    fieldsyntax item_a('BT_LUSUARIO', tADM_USUARIO), 'DIM';
  end else begin
    clear_e(tGER_TERMINAL);
    putitem_e(tGER_TERMINAL, 'CD_TERMINAL', itemXmlF('CD_TERMINAL', PARAM_GLB));
    retrieve_e(tGER_TERMINAL);
    fieldsyntax item_f('CD_USUARIO', tADM_USUARIO), 'DIM';
    fieldsyntax item_f('CD_TERMINAL', tGER_TERMINAL), 'DIM';
    fieldsyntax item_a('BT_LUSUARIO', tADM_USUARIO), 'DIM';
    fieldsyntax item_a('BT_LTERMINAL', tGER_TERMINAL), 'DIM';
  end;

  clear_e(tGER_EMPRESA);
  putitem_e(tGER_EMPRESA, 'CD_EMPRESA', itemXmlF('CD_EMPRESA', PARAM_GLB));
  retrieve_e(tGER_EMPRESA);
  if (xStatus < 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Empresa não encontrada!', '');
    gprompt := item_f('VL_ABERTURA', tSIS_DUMMY);
    return(-1); exit;
  end;

  voParams := validaConta(viParams); (* *)
  if (xStatus < 0) then begin
    return(-1); exit;
  end;

  return(0); exit;
end;

end.
