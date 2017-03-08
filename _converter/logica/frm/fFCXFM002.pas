unit fFCXFM002;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, fFormTouch, ExtCtrls, cPanel, cDatasetUnf;

type
  TF_FCXFM002 = class(T_FormTouch)
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
  private
    tADM_S_USUARIO,
    tF_GER_TERMINAL,
    tFCX_CAIXAC,
    tSIS_DUMMY,
    tSIS_OPERADOR : TcDatasetUnf;
    function getParam(pParams : String = '') : String;
    function setEntidade(pParams : String = '') : String;
    function preEDIT(pParams : String = '') : String;
    function posEDIT(pParams : String = '') : String;
    function posCLEAR(pParams : String = '') : String;
    function preEDIT(pParams : String = '') : String;
    function INIT(pParams : String = '') : String;
    function CLEANUP(pParams : String = '') : String;
    function chamaEncerra(pParams : String = '') : String;
    function consulta(pParams : String = '') : String;
    function filtroDtAbertura(pParams : String = '') : String;
    function filtroDtFechamento(pParams : String = '') : String;
    function validaCentroCusto(pParams : String = '') : String;
    function chamaConsulta(pParams : String = '') : String;
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
  gInUtilizaCCusto : String;

procedure TF_FCXFM002.FormCreate(Sender: TObject);
begin
  inherited; //
  setEntidade();
end;

procedure TF_FCXFM002.FormShow(Sender: TObject);
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

procedure TF_FCXFM002.FormActivate(Sender: TObject);
begin
  inherited; //
end;

procedure TF_FCXFM002.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  inherited; //
end;

//---------------------------------------------------------------
function TF_FCXFM002.getParam(pParams : String = '') : String;
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
function TF_FCXFM002.setEntidade(pParams : String = '') : String;
//---------------------------------------------------------------
begin
  tADM_S_USUARIO := TcDatasetUnf.GetEntidade(Self, 'ADM_S_USUARIO');
  tF_GER_TERMINAL := TcDatasetUnf.GetEntidade(Self, 'F_GER_TERMINAL');
  tFCX_CAIXAC := TcDatasetUnf.GetEntidade(Self, 'FCX_CAIXAC');
  tSIS_DUMMY := TcDatasetUnf.GetEntidade(Self, 'SIS_DUMMY');
  tSIS_OPERADOR := TcDatasetUnf.GetEntidade(Self, 'SIS_OPERADOR');
end;

//---------------------------------------------------------------
function TF_FCXFM002.preEDIT(pParams : String) : String;
//---------------------------------------------------------------
const
  cDS_METHOD = 'ADICIONAL=Operação: TF_FCXFM002.preEDIT()';
begin
  return(0); exit;
end;

//---------------------------------------------------------------
function TF_FCXFM002.posEDIT(pParams : String) : String;
//---------------------------------------------------------------
const
  cDS_METHOD = 'ADICIONAL=Operação: TF_FCXFM002.posEDIT()';
begin
  return(0); exit;
end;

//-------------------------------------------------------
function TF_FCXFM002.posCLEAR(pParams : String) : String;
//-------------------------------------------------------
const
  cDS_METHOD = 'ADICIONAL=Operação: TF_FCXFM002.posCLEAR()';
var
  vInCxTerminal : Real;
begin
  vInCxTerminal := itemXmlB('IN_CAIXA_TERMINAL', xParamEmp);
  if (vInCxTerminal = 0) then begin
    fieldsyntax item_f('CD_USUARIO', tADM_S_USUARIO), '';
  end else begin
    fieldsyntax item_f('CD_USUARIO', tADM_S_USUARIO), 'DIM';
  end;

  putitem_e(tFCX_CAIXAC, 'CD_EMPRESA', itemXmlF('CD_EMPRESA', PARAM_GLB));
  putitem_e(tSIS_DUMMY, 'IN_FECHADO', False);
  clear_e(tSIS_OPERADOR);

  return(0); exit;
end;

//------------------------------------------------------
function TF_FCXFM002.preEDIT(pParams : String) : String;
//------------------------------------------------------
const
  cDS_METHOD = 'ADICIONAL=Operação: TF_FCXFM002.preEDIT()';
var
  vInCxTerminal : Real;
begin
  vInCxTerminal := itemXmlB('IN_CAIXA_TERMINAL', xParamEmp);

  if (vInCxTerminal = 0) then begin
    fieldsyntax item_f('CD_USUARIO', tADM_S_USUARIO), '';
  end else begin
    fieldsyntax item_f('CD_USUARIO', tADM_S_USUARIO), 'DIM';
  end;

  putitem_e(tSIS_DUMMY, 'IN_FECHADO', False);
  clear_e(tSIS_OPERADOR);

  clear_e(tFCX_CAIXAC);
  putitem_e(tFCX_CAIXAC, 'CD_EMPRESA', itemXmlF('CD_EMPRESA', PARAM_GLB));
  putitem_e(tFCX_CAIXAC, 'IN_FECHADO', False);
  retrieve_e(tFCX_CAIXAC);

  gprompt := item_a('DT_ABERTURA', tFCX_CAIXAC);

  return(0); exit;
end;

//---------------------------------------------------
function TF_FCXFM002.INIT(pParams : String) : String;
//---------------------------------------------------
const
  cDS_METHOD = 'ADICIONAL=Operação: TF_FCXFM002.INIT()';
var
  vInCCustoEmp : Boolean;
begin
  _Caption := '' + FCXFM + '002 - Fechamento de Caixa';

  putitem(xParam,  'IN_UTILIZA_CCUSTO');
  xParam := T_ADMSVCO001.GetParametro(xParam); (*xParam,xParam,, *)
  gInUtilizaCCusto := itemXmlB('IN_UTILIZA_CCUSTO', xParam);

  xParamEmp := '';
  putitem(xParamEmp,  'IN_CAIXA_TERMINAL');
  putitem(xParamEmp,  'TP_VALIDA_NF_IMPRESSA');
  putitem(xParamEmp,  'IN_BLOQUEIA_FICHA_CEGA_CX');
  putitem(xParamEmp,  'IN_UTILIZA_CCUSTO');
  xParamEmp := T_ADMSVCO001.GetParamEmpresa(piCdEmpresa, xParamEmp); (*itemXml('CD_EMPRESA', *)

  vInCCustoEmp := itemXmlB('IN_UTILIZA_CCUSTO', xParamEmp);
  if (vInCCustoEmp <> '') then begin
    gInUtilizaCCusto := vInCCustoEmp;
  end;

  return(0); exit;
end;

//------------------------------------------------------
function TF_FCXFM002.CLEANUP(pParams : String) : String;
//------------------------------------------------------
const
  cDS_METHOD = 'ADICIONAL=Operação: TF_FCXFM002.CLEANUP()';
begin
end;

//-----------------------------------------------------------
function TF_FCXFM002.chamaEncerra(pParams : String) : String;
//-----------------------------------------------------------
const
  cDS_METHOD = 'ADICIONAL=Operação: TF_FCXFM002.chamaEncerra()';
var
  viParams, voParams, vDsErro, vDsPermite, vLstEmpresa : String;
  vReg, vTpValidaNFImpressa : Real;
  vInBloqueiaFicha, vInFechamentoCaixa : Boolean;
begin
  vInBloqueiaFicha := itemXmlB('IN_BLOQUEIA_FICHA_CEGA_CX', xParamEmp);

  vInFechamentoCaixa := True;
  viParams := '';
  putitemXml(viParams, 'CD_COMPONENTE', FCXFM002);
  putitemXml(viParams, 'DS_CAMPO', 'IN_FECHAMENTO_CAIXA');
  putitemXml(viParams, 'CD_EMPRESA', itemXmlF('CD_EMPRESA', PARAM_GLB));
  putitemXml(viParams, 'CD_USUARIO', itemXmlF('CD_USUARIO', PARAM_GLB));
  putitemXml(viParams, 'VL_VALOR', '');
  voParams := activateCmp('ADMSVCO009', 'VerificaRestricao', viParams); (*,,, *)
  if (xStatus < 0) then begin
    Result := voParams;
    return(-1); exit;
  end;
  if (vInFechamentoCaixa = False) then begin
    Result := SetStatus(STS_AVISO, 'GEN001', 'Usuário sem permissão para efetuar fechamento de caixa. Restrição IN_FECHAMENTO_CAIXA.', '');
    return(-1); exit;
  end;
  if (!dbocc(t'FCX_CAIXAC')) then begin
    message/info 'Necessário escolher um fechamento para encerrar!';
    return(-1); exit;
  end;
  if (item_b('IN_FECHADO', tFCX_CAIXAC) = True) then begin
    message/info 'Não é possível encerrar, fechamento já encerrado!';
    return(-1); exit;
  end;
  if (vInBloqueiaFicha = True)  and (item_f('CD_OPERCONF', tFCX_CAIXAC) = 0) then begin
    message/info 'Não é possível fazer o fechamento do caixa! Lançamentos (Ficha Cega) não encerrado!';
    return(-1); exit;
  end;

  vTpValidaNFImpressa := itemXmlF('TP_VALIDA_NF_IMPRESSA', xParamEmp);

  if (vTpValidaNFImpressa = 2 ) or (vTpValidaNFImpressa = 3) then begin
    viParams := '';
    putitemXml(viParams, 'CD_GRUPOEMPRESA', itemXmlF('CD_GRUPOEMPRESA', PARAM_GLB));
    voParams := activateCmp('GERSVCO032', 'buscaLstGrupoEmpresa', viParams); (*,,,, *)
    if (xStatus < 0) then begin
      Result := voParams;
      return(-1); exit;
    end;

    vLstEmpresa := itemXmlF('CD_EMPRESA', voParams);

    viParams := '';
    putitemXml(viParams, 'CD_EMPRESA', vLstEmpresa);
    putitemXml(viParams, 'CD_USUARIO', item_f('CD_OPERCX', tFCX_CAIXAC));
    putitemXml(viParams, 'CD_TERMINAL', item_f('CD_TERMINAL', tFCX_CAIXAC));
    voParams := activateCmp('FCXSVCO003', 'validaEncerramentoCx', viParams); (*,,,, *)
    if (xStatus < 0) then begin
      Result := voParams;
      return(-1); exit;
    end;
      viParams := '';
      vDsErro := '  NF não impressa: ' + vDsErro' + ';
      putitemXml(viParams, 'TITULO', 'Validação de Fechamento de Caixa');
      putitemXml(viParams, 'MENSAGEM', vDsErro);
      voParams := activateCmp('GERFP008', 'EXEC', viParams); (*,,, *)
      if (xStatus < 0) then begin
        Result := voParams;
        return(-1); exit;
      end;

      viParams := '';
      putitemXml(viParams, 'IN_USULOGADO', True);
      putitemXml(viParams, 'CD_USUARIO', 0);
      putitemXml(viParams, 'DS_COMPONENTE', '');
      voParams := activateCmp('ADMFM020', 'exec', viParams); (*,,, *)
      if (xStatus < 0) then begin
        return(-1); exit;
      end;

      putitemXml(viParams, 'CD_COMPONENTE', 'FCXFM001');
      putitemXml(viParams, 'DS_CAMPO', 'IN_LIBERA_FECHA_NF');
      putitemXml(viParams, 'CD_EMPRESA', itemXmlF('CD_EMPRESA', PARAM_GLB));
      putitemXml(viParams, 'CD_USUARIO', itemXmlF('CD_USUARIO', voParams));
      voParams := activateCmp('ADMSVCO009', 'verificaRestricao', viParams); (*,,, *)
      if (xStatus < 0) then begin
        Result := SetStatus(STS_ERROR, {xCdErro} '', '{xCtxErro} ''', '');
        return(-1); exit;
      end;
      if (voParams <> '') then begin
        vDsPermite := itemXml('DS_PERMITE', voParams);
      end;
      if (vDsPermite = 'NAO') then begin
        return(-1); exit;
      end;
    end;
  end;

  viParams := '';
  putitemXml(viParams, 'CD_EMPRESA', item_f('CD_EMPRESA', tFCX_CAIXAC));
  putitemXml(viParams, 'CD_TERMINAL', item_f('CD_TERMINAL', tFCX_CAIXAC));
  putitemXml(viParams, 'DT_ABERTURA', item_a('DT_ABERTURA', tFCX_CAIXAC));
  putitemXml(viParams, 'NR_SEQ', item_f('NR_SEQ', tFCX_CAIXAC));
  putitemXml(viParams, 'TP_ROTINA', 1);
  voParams := activateCmp('FCXFM003', 'exec', viParams); (*,,, *)
  if (xStatus < 0) then begin
    Result := voParams;
    return(-1); exit;
  end;

  macro '^RETRIEVE';

  return(0); exit;
end;

//-------------------------------------------------------
function TF_FCXFM002.consulta(pParams : String) : String;
//-------------------------------------------------------
const
  cDS_METHOD = 'ADICIONAL=Operação: TF_FCXFM002.consulta()';
begin
  clear_e(tFCX_CAIXAC);
  putitem_e(tFCX_CAIXAC, 'CD_EMPRESA', itemXmlF('CD_EMPRESA', PARAM_GLB));
  putitem_e(tFCX_CAIXAC, 'CD_TERMINAL', item_f('CD_TERMINAL', tF_GER_TERMINAL));
  putitem_e(tFCX_CAIXAC, 'CD_OPERCX', item_f('CD_USUARIO', tADM_S_USUARIO));
  putitem_e(tFCX_CAIXAC, 'DT_ABERTURA', item_a('DT_ABERTURA', tSIS_DUMMY));
  putitem_e(tFCX_CAIXAC, 'DT_FECHADO', item_a('DT_FECHADO', tSIS_DUMMY));
  putitem_e(tFCX_CAIXAC, 'IN_FECHADO', item_b('IN_FECHADO', tSIS_DUMMY));
  retrieve_e(tFCX_CAIXAC);

  gprompt := item_a('DT_ABERTURA', tFCX_CAIXAC);

  return(0); exit;
end;

//---------------------------------------------------------------
function TF_FCXFM002.filtroDtAbertura(pParams : String) : String;
//---------------------------------------------------------------
const
  cDS_METHOD = 'ADICIONAL=Operação: TF_FCXFM002.filtroDtAbertura()';
begin
  putitem_e(tSIS_DUMMY, 'DT_ABERTURA', '');
  if (item_a('DT_ABERTURAINI', tSIS_DUMMY) > item_a('DT_ABERTURAFIM', tSIS_DUMMY)) then begin
    message/info 'Data de abertura inicial maior que a final!';
  end else begin
    if (item_a('DT_ABERTURAINI', tSIS_DUMMY) <> '')  and (item_a('DT_ABERTURAFIM', tSIS_DUMMY) <> '') then begin
      putitem_e(tSIS_DUMMY, 'DT_ABERTURA', '>= ' + DT_ABERTURAINI + '.SIS_DUMMY and<= ' + DT_ABERTURAFIM + '.SIS_DUMMY');
    end;
  end;

  return(0); exit;
end;

//-----------------------------------------------------------------
function TF_FCXFM002.filtroDtFechamento(pParams : String) : String;
//-----------------------------------------------------------------
const
  cDS_METHOD = 'ADICIONAL=Operação: TF_FCXFM002.filtroDtFechamento()';
begin
  putitem_e(tSIS_DUMMY, 'DT_FECHADO', '');
  if (item_a('DT_FECHADOINI', tSIS_DUMMY) > item_a('DT_FECHADOFIM', tSIS_DUMMY)) then begin
    message/info 'Data de fechamento inicial maior que a final!';
  end else begin
    if (item_a('DT_FECHADOINI', tSIS_DUMMY) <> '')  and (item_a('DT_FECHADOFIM', tSIS_DUMMY) <> '') then begin
      putitem_e(tSIS_DUMMY, 'DT_FECHADO', '>= ' + DT_FECHADOINI + '.SIS_DUMMY and<= ' + DT_FECHADOFIM + '.SIS_DUMMY');
    end;
  end;

  return(0); exit;
end;

//----------------------------------------------------------------
function TF_FCXFM002.validaCentroCusto(pParams : String) : String;
//----------------------------------------------------------------
const
  cDS_METHOD = 'ADICIONAL=Operação: TF_FCXFM002.validaCentroCusto()';
var
  viParams, voParams : String;
  vCdEmpresa, vCdCCUsto : Real;
begin
  if (gInUtilizaCCusto <> True) then begin
    return(0); exit;
  end;

  viParams := '';
  voParams := activateCmp('SICSVCO009', 'validaCentroCusto', viParams); (*,,,, *)
  if (xStatus < 0) then begin
    Result := voParams;
    return(-1); exit;
  end;

  vCdCCusto := itemXmlF('CD_CENTROCUSTO', voParams);
  vCdEmpresa := itemXmlF('CD_EMPRESA', PARAM_GLB);

  if (vCdCCusto <> vCdEmpresa) then begin
    message/info 'Empresa não possui centro de custo cadastrado!';
    return(-1); exit;
  end;

  return(0); exit;
end;

//------------------------------------------------------------
function TF_FCXFM002.chamaConsulta(pParams : String) : String;
//------------------------------------------------------------
const
  cDS_METHOD = 'ADICIONAL=Operação: TF_FCXFM002.chamaConsulta()';
var
  viParams, voParams : String;
  vReg : Real;
begin
  if (!dbocc(t'FCX_CAIXAC')) then begin
    message/info 'Necessário escolher um fechamento para encerrar!';
    return(-1); exit;
  end;
  if (item_b('IN_FECHADO', tFCX_CAIXAC) = False) then begin
    message/info 'Não é possível consultar, fechamento não encerrado!';
    return(-1); exit;
  end;

  viParams := '';
  putitemXml(viParams, 'CD_EMPRESA', item_f('CD_EMPRESA', tFCX_CAIXAC));
  putitemXml(viParams, 'CD_TERMINAL', item_f('CD_TERMINAL', tFCX_CAIXAC));
  putitemXml(viParams, 'DT_ABERTURA', item_a('DT_ABERTURA', tFCX_CAIXAC));
  putitemXml(viParams, 'NR_SEQ', item_f('NR_SEQ', tFCX_CAIXAC));
  putitemXml(viParams, 'TP_ROTINA', 2);
  voParams := activateCmp('FCXFM003', 'exec', viParams); (*,,, *)
  if (xStatus < 0) then begin
    Result := voParams;
    return(-1); exit;
  end;

  macro '^RETRIEVE';

  return(0); exit;
end;

end.
