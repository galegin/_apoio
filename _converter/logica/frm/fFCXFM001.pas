unit fFCXFM001;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, fFormTouch, ExtCtrls, cPanel, cDatasetUnf;

type
  TF_FCXFM001 = class(T_FormTouch)
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
  private
    tF_FCX_CAIXAC,
    tFCX_CAIXAC,
    tFCX_CAIXAI,
    tFCX_HISTREL,
    tFCX_HISTRELEMP,
    tFCX_HISTRELSUB,
    tFCX_HISTRELUSU,
    tFGR_LIQ,
    tFGR_LIQCONF,
    tFGR_LIQITEMCR,
    tGER_EMPRESA,
    tGER_S_EMPRESA,
    tGER_TERMINAL,
    tPES_PESSOA,
    tSIS_BOTOES,
    tTMP_K02 : TcDatasetUnf;
    function getParam(pParams : String = '') : String;
    function setEntidade(pParams : String = '') : String;
    function preEDIT(pParams : String = '') : String;
    function posEDIT(pParams : String = '') : String;
    function preEDIT(pParams : String = '') : String;
    function prePRINT(pParams : String = '') : String;
    function INIT(pParams : String = '') : String;
    function CLEANUP(pParams : String = '') : String;
    function carregaHistorico(pParams : String = '') : String;
    function efetua(pParams : String = '') : String;
    function encerra(pParams : String = '') : String;
    function validaCentroCusto(pParams : String = '') : String;
    function reabre(pParams : String = '') : String;
    function conferirImpressaoContrato(pParams : String = '') : String;
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
  gDsLstCaixa,
  gInBloqueiaTraBloqCx,
  gInFCXFP022,
  gInUtilizaCCusto,
  gInUtilizaVlFundo,
  gTpValidaImpcontratoCx,
  gVlMaximoFundoCx : String;

procedure TF_FCXFM001.FormCreate(Sender: TObject);
begin
  inherited; //
  setEntidade();
end;

procedure TF_FCXFM001.FormShow(Sender: TObject);
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

procedure TF_FCXFM001.FormActivate(Sender: TObject);
begin
  inherited; //
end;

procedure TF_FCXFM001.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  inherited; //
end;

//---------------------------------------------------------------
function TF_FCXFM001.getParam(pParams : String = '') : String;
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
function TF_FCXFM001.setEntidade(pParams : String = '') : String;
//---------------------------------------------------------------
begin
  tF_FCX_CAIXAC := TcDatasetUnf.GetEntidade(Self, 'F_FCX_CAIXAC');
  tFCX_CAIXAC := TcDatasetUnf.GetEntidade(Self, 'FCX_CAIXAC');
  tFCX_CAIXAI := TcDatasetUnf.GetEntidade(Self, 'FCX_CAIXAI');
  tFCX_HISTREL := TcDatasetUnf.GetEntidade(Self, 'FCX_HISTREL');
  tFCX_HISTRELEMP := TcDatasetUnf.GetEntidade(Self, 'FCX_HISTRELEMP');
  tFCX_HISTRELSUB := TcDatasetUnf.GetEntidade(Self, 'FCX_HISTRELSUB');
  tFCX_HISTRELUSU := TcDatasetUnf.GetEntidade(Self, 'FCX_HISTRELUSU');
  tFGR_LIQ := TcDatasetUnf.GetEntidade(Self, 'FGR_LIQ');
  tFGR_LIQCONF := TcDatasetUnf.GetEntidade(Self, 'FGR_LIQCONF');
  tFGR_LIQITEMCR := TcDatasetUnf.GetEntidade(Self, 'FGR_LIQITEMCR');
  tGER_EMPRESA := TcDatasetUnf.GetEntidade(Self, 'GER_EMPRESA');
  tGER_S_EMPRESA := TcDatasetUnf.GetEntidade(Self, 'GER_S_EMPRESA');
  tGER_TERMINAL := TcDatasetUnf.GetEntidade(Self, 'GER_TERMINAL');
  tPES_PESSOA := TcDatasetUnf.GetEntidade(Self, 'PES_PESSOA');
  tSIS_BOTOES := TcDatasetUnf.GetEntidade(Self, 'SIS_BOTOES');
  tTMP_K02 := TcDatasetUnf.GetEntidade(Self, 'TMP_K02');
end;

//---------------------------------------------------------------
function TF_FCXFM001.preEDIT(pParams : String) : String;
//---------------------------------------------------------------
const
  cDS_METHOD = 'ADICIONAL=Operação: TF_FCXFM001.preEDIT()';
begin
  return(0); exit;
end;

//---------------------------------------------------------------
function TF_FCXFM001.posEDIT(pParams : String) : String;
//---------------------------------------------------------------
const
  cDS_METHOD = 'ADICIONAL=Operação: TF_FCXFM001.posEDIT()';
begin
  return(0); exit;
end;

//------------------------------------------------------
function TF_FCXFM001.preEDIT(pParams : String) : String;
//------------------------------------------------------
const
  cDS_METHOD = 'ADICIONAL=Operação: TF_FCXFM001.preEDIT()';
var
  viParams, voParams, vDsRegistro : String;
  vCdEmpresa, vCdTerminal, vNrSeq : Real;
  vDtAbertura : TDate;
  vInContinua, vInTransacao : Boolean;
begin
  voParams := validaCentroCusto(viParams); (* *)
  if (xStatus < 0) then begin
    Result := voParams;
    return(-1); exit;
  end;

  viParams := '';
  putitemXml(viParams, 'CD_EMPRESA', itemXmlF('CD_EMPRESA', viParams));
  voParams := activateCmp('FCXSVCO001', 'buscaCaixaConf', viParams); (*,,,, *)
  if (xStatus < 0) then begin
    Result := voParams;
    return(-1); exit;
  end;

  vCdEmpresa := itemXmlF('CD_EMPRESA', voParams);
  vCdTerminal := itemXmlF('CD_TERMINAL', voParams);
  vDtAbertura := itemXml('DT_ABERTURA', voParams);
  vNrSeq := itemXmlF('NR_SEQ', voParams);

  gInFCXFP022 := itemXmlB('IN_FCXFP022', viParams);
  gDsLstCaixa := itemXml('DS_LSTCAIXA', viParams);

  clear_e(tFCX_CAIXAC);
  putitem_e(tFCX_CAIXAC, 'CD_EMPRESA', vCdEmpresa);
  putitem_e(tFCX_CAIXAC, 'CD_TERMINAL', vCdTerminal);
  putitem_e(tFCX_CAIXAC, 'DT_ABERTURA', vDtAbertura);
  putitem_e(tFCX_CAIXAC, 'NR_SEQ', vNrSeq);
  retrieve_e(tFCX_CAIXAC);
  if (xStatus < 0) then begin
    message/info 'Erro na abertura do caixa para preenchimento da Ficha Cega!';
    return(-1); exit;
  end;
  if (item_f('CD_OPERCONF', tFCX_CAIXAC) > 0) then begin
    message/info 'Fechamento encerrado. Somente consulta!';
    fieldsyntax item_a('BT_ENCERRA', tSIS_BOTOES), 'DIM';
    fieldsyntax item_a('BT_CONFIRMA', tSIS_BOTOES), 'DIM';
  end else begin
    fieldsyntax item_a('BT_REABRIR', tSIS_BOTOES), 'DIM';
    end;

  vInTransacao := itemXmlB('IN_TRANSACAO', viParams);
  if (vInTransacao = True) then begin
    fieldsyntax item_f('CD_EMPRESA', tGER_EMPRESA), 'HID';
    fieldsyntax item_a('NM_PESSOA', tPES_PESSOA), 'HID';
  end;

  voParams := carregaHistorico(viParams); (* *)
  if (xStatus < 0) then begin
    Result := voParams;
    return(-1); exit;
  end;

  setocc(tTMP_K02, 1);

  if (gInFCXFP022 = True) then begin
    repeat
      getitem(vDsRegistro, gDsLstCaixa, 1);

      creocc(tTMP_K02, -1);
      putitem_e(tTMP_K02, 'NR_CHAVE01', itemXmlF('TP_DOCUMENTO', vDsRegistro));
      putitem_e(tTMP_K02, 'NR_CHAVE02', itemXmlF('NR_SEQHISTRELSUB', vDsRegistro));
      retrieve_o(tTMP_K02);
      if (xStatus = -7) then begin
        retrieve_x(tTMP_K02);
      end;
      putitem_e(tTMP_K02, 'VL_VALOR', itemXmlF('VL_CONTADO', vDsRegistro));

      delitem(gDsLstCaixa, 1);
    until  (gDsLstCaixa = '');

    voParams := encerra(viParams); (* *)
    if (xStatus < 0) then begin
      Result := SetStatus(STS_ERROR, xProcerror, 'xProcerrorcontext', '');
      return(-1); exit;
    end else begin
      return(0); exit;
    end;
  end;

  return(0); exit;
end;

//-------------------------------------------------------
function TF_FCXFM001.prePRINT(pParams : String) : String;
//-------------------------------------------------------
const
  cDS_METHOD = 'ADICIONAL=Operação: TF_FCXFM001.prePRINT()';
var
  viParams, voParams, vpiFiltro, vDsLinha, vDsCaixa : String;
begin
  setocc(tTMP_K02, 1);

  if (item_a('DS_HISTORICO', tTMP_K02) = '') then begin
    return(0); exit;
  end;

  vDsLinha := '';
  vDsCaixa := '';

  setocc(tTMP_K02, 1);
  while (xStatus >= 0) do begin
    if (item_f('VL_VALOR', tTMP_K02) <> '') then begin
      vDsLinha := '';
      putlistitensocc_e(vDsLinha, tTMP_K02);
      putitem(vDsCaixa,  vDsLinha);
    end;

    setocc(tTMP_K02, curocc(tTMP_K02) + 1);
  end;
  setocc(tTMP_K02, 1);

  viParams := '';
  putitemXml(viParams, 'CD_EMPRESA', item_f('CD_EMPRESA', tGER_EMPRESA));
  putitemXml(viParams, 'NM_PESSOA', item_a('NM_PESSOA', tPES_PESSOA));
  putitemXml(viParams, 'CD_TERMINAL', item_f('CD_TERMINAL', tGER_TERMINAL));
  putitemXml(viParams, 'DS_TERMINAL', item_a('DS_TERMINAL', tGER_TERMINAL));
  putitemXml(viParams, 'CD_USUARIO', item_f('CD_OPERADOR', tFCX_CAIXAC));
  putitemXml(viParams, 'NM_USUARIO', item_a('NM_USUARIO', tFCX_CAIXAC));
  putitemXml(viParams, 'DT_ABERTURA', item_a('DT_ABERTURA', tFCX_CAIXAC));
  putitemXml(viParams, 'DS_CAIXA', vDsCaixa);

  voParams := activateCmp('SISFP002', 'exec', viParams); (*'FCXR013',vpiFiltro,,,, *)
  if (xStatus < 0) then begin
    Result := voParams;
    return(-1); exit;
  end;
  gprompt := item_a('DS_HISTORICO', tTMP_K02);

  return(0); exit;
end;

//---------------------------------------------------
function TF_FCXFM001.INIT(pParams : String) : String;
//---------------------------------------------------
const
  cDS_METHOD = 'ADICIONAL=Operação: TF_FCXFM001.INIT()';
var
  vInCCustoEmp : Boolean;
begin
  _Caption := '' + FCXFM + '001 - Contagem de Caixa';

  putitem(xParam,  'IN_UTILIZA_CCUSTO');
  xParam := T_ADMSVCO001.GetParametro(xParam); (*xParam,xParam,, *)
  gInUtilizaCCusto := itemXmlB('IN_UTILIZA_CCUSTO', xParam);

  putitem(xParamEmp,  'IN_UTILIZA_VLFUNDO');
  putitem(xParamEmp,  'IN_CONFERENTE_CAIXA');
  putitem(xParamEmp,  'TP_VALIDA_NF_IMPRESSA');
  putitem(xParamEmp,  'IN_BLOQUEIA_FICHA_CEGA_CX');
  putitem(xParamEmp,  'IN_BLOQUEIA_TRA_BLOQ_CX');
  putitem(xParamEmp,  'VL_MAXIMO_FUNDO_CX');
  putitem(xParamEmp,  'TP_VALIDA_IMPCONTRATO_CX');
  putitem(xParamEmp,  'IN_UTILIZA_CCUSTO');
  xParamEmp := T_ADMSVCO001.GetParamEmpresa(piCdEmpresa, xParamEmp); (*itemXml('CD_EMPRESA', *)

  gInUtilizaVlFundo := itemXmlB('IN_UTILIZA_VLFUNDO', xParamEmp);

  gTpValidaImpcontratoCx := itemXmlF('TP_VALIDA_IMPCONTRATO_CX', xParamEmp);

  gInBloqueiaTraBloqCx := itemXmlB('IN_BLOQUEIA_TRA_BLOQ_CX', xParamEmp);

  gVlMaximoFundoCx := itemXmlF('VL_MAXIMO_FUNDO_CX', xParamEmp);

  vInCCustoEmp := itemXmlB('IN_UTILIZA_CCUSTO', xParamEmp);

  if (vInCCustoEmp <> '') then begin
    gInUtilizaCCusto := vInCCustoEmp;
  end;

  return(0); exit;
end;

//------------------------------------------------------
function TF_FCXFM001.CLEANUP(pParams : String) : String;
//------------------------------------------------------
const
  cDS_METHOD = 'ADICIONAL=Operação: TF_FCXFM001.CLEANUP()';
begin
end;

//---------------------------------------------------------------
function TF_FCXFM001.carregaHistorico(pParams : String) : String;
//---------------------------------------------------------------
const
  cDS_METHOD = 'ADICIONAL=Operação: TF_FCXFM001.carregaHistorico()';
var
  vInVlFundo, vTpDocumento : Real;
  vInBloqueiaReabertura, vInRecebimento, vInFaturamento, vInTotalizador : Boolean;
  vDsEntidade : String;
begin
  vInVlFundo := itemXmlB('IN_UTILIZA_VLFUNDO', xParamEmp);

  vDsEntidade := '';

  clear_e(tFCX_HISTRELUSU);
  putitem_e(tFCX_HISTRELUSU, 'CD_USUARIO', itemXmlF('CD_USUARIO', PARAM_GLB));
  retrieve_e(tFCX_HISTRELUSU);
  if (xStatus >= 0) then begin
    vDsEntidade := 'FCX_HISTRELUSU';
  end else begin

    clear_e(tFCX_HISTRELEMP);
    putitem_e(tFCX_HISTRELEMP, 'CD_EMPRESA', itemXmlF('CD_EMPRESA', PARAM_GLB));
    retrieve_e(tFCX_HISTRELEMP);
    if (xStatus >= 0) then begin
      vDsEntidade := 'FCX_HISTRELEMP';
    end;
  end;
  if (vDsEntidade = '') then begin
    clear_e(tFCX_HISTREL);
    retrieve_e(tFCX_HISTREL);

    vDsEntidade := 'FCX_HISTREL';
  end;

  setocc vDsEntidade, 1);
  while (xStatus >= 0) do begin

    if (vDsEntidade = 'FCX_HISTRELUSU') then begin
      vTpDocumento := item_f('TP_DOCUMENTO', tFCX_HISTRELUSU);
      vInRecebimento := item_b('IN_RECEBIMENTO', tFCX_HISTRELUSU);
      vInFaturamento := item_b('IN_FATURAMENTO', tFCX_HISTRELUSU);
      vInTotalizador := item_b('IN_TOTALIZADOR', tFCX_HISTRELUSU);
    end else if (vDsEntidade = 'FCX_HISTRELEMP') then begin
      vTpDocumento := item_f('TP_DOCUMENTO', tFCX_HISTRELEMP);
      vInRecebimento := item_b('IN_RECEBIMENTO', tFCX_HISTRELEMP);
      vInFaturamento := item_b('IN_FATURAMENTO', tFCX_HISTRELEMP);
      vInTotalizador := item_b('IN_TOTALIZADOR', tFCX_HISTRELEMP);
    end else begin
      vTpDocumento := item_f('TP_DOCUMENTO', tFCX_HISTREL);
      vInRecebimento := item_b('IN_RECEBIMENTO', tFCX_HISTREL);
      vInFaturamento := item_b('IN_FATURAMENTO', tFCX_HISTREL);
      vInTotalizador := item_b('IN_TOTALIZADOR', tFCX_HISTREL);
    end;
    if (vTpDocumento <> 9)  and (vInRecebimento = True ) or (vInFaturamento = True)  and (vInTotalizador = True) then begin
      clear_e(tFCX_HISTRELSUB);
      putitem_e(tFCX_HISTRELSUB, 'TP_DOCUMENTO', vTpDocumento);
      retrieve_e(tFCX_HISTRELSUB);

      if (empty(tFCX_HISTRELSUB) = False) then begin
        setocc(tFCX_HISTRELSUB, 1);
        while (xStatus >= 0) do begin
          creocc(tTMP_K02, -1);
          putitem_e(tTMP_K02, 'NR_CHAVE01', item_f('TP_DOCUMENTO', tFCX_HISTRELSUB));
          putitem_e(tTMP_K02, 'NR_CHAVE02', item_f('NR_SEQHISTRELSUB', tFCX_HISTRELSUB));
          retrieve_o(tTMP_K02);
          if (xStatus = -7) then begin
            retrieve_x(tTMP_K02);
          end;
          if (vTpDocumento = 1) then begin
            putitem_e(tTMP_K02, 'DS_HISTORICO', 'FATURA');
          end else if (vTpDocumento = 2) then begin
            putitem_e(tTMP_K02, 'DS_HISTORICO', 'CHEQUE');
          end else if (vTpDocumento = 3) then begin
            putitem_e(tTMP_K02, 'DS_HISTORICO', 'DINHEIRO');
          end else if (vTpDocumento = 6) then begin
            putitem_e(tTMP_K02, 'DS_HISTORICO', 'NOTA DEBITO');
          end else if (vTpDocumento = 7) then begin
            putitem_e(tTMP_K02, 'DS_HISTORICO', 'TEF');
          end else if (vTpDocumento = 10) then begin
            putitem_e(tTMP_K02, 'DS_HISTORICO', 'ADIANTAMENTO');
          end else if (vTpDocumento = 11) then begin
            putitem_e(tTMP_K02, 'DS_HISTORICO', 'DESCONTO');
          end else if (vTpDocumento = 12) then begin
            putitem_e(tTMP_K02, 'DS_HISTORICO', 'DOFNI');
          end else if (vTpDocumento = 13) then begin
            putitem_e(tTMP_K02, 'DS_HISTORICO', 'VALE');
          end else if (vTpDocumento = 14) then begin
            putitem_e(tTMP_K02, 'DS_HISTORICO', 'NOTA PROMISSORIA');
          end else if (vTpDocumento = 16) then begin
            putitem_e(tTMP_K02, 'DS_HISTORICO', 'TED/DOC');
          end else if (vTpDocumento = 20) then begin
            putitem_e(tTMP_K02, 'DS_HISTORICO', 'CREDEV');
          end else if (vTpDocumento = 18) then begin
            putitem_e(tTMP_K02, 'DS_HISTORICO', 'CHEQUE PRESENTE');
          end else begin
            putitem_e(tTMP_K02, 'DS_HISTORICO', item_a('DS_HISTRELSUB', tFCX_HISTRELSUB));
          end;

          clear_e(tFCX_CAIXAI);
          putitem_e(tFCX_CAIXAI, 'CD_EMPRESA', item_f('CD_EMPRESA', tFCX_CAIXAC));
          putitem_e(tFCX_CAIXAI, 'CD_TERMINAL', item_f('CD_TERMINAL', tFCX_CAIXAC));
          putitem_e(tFCX_CAIXAI, 'DT_ABERTURA', item_a('DT_ABERTURA', tFCX_CAIXAC));
          putitem_e(tFCX_CAIXAI, 'NR_SEQ', item_f('NR_SEQ', tFCX_CAIXAC));
          putitem_e(tFCX_CAIXAI, 'TP_DOCUMENTO', item_f('TP_DOCUMENTO', tFCX_HISTRELSUB));
          putitem_e(tFCX_CAIXAI, 'NR_SEQHISTRELSUB', item_f('NR_SEQHISTRELSUB', tFCX_HISTRELSUB));
          retrieve_e(tFCX_CAIXAI);
          if (xStatus >= 0) then begin
            putitem_e(tTMP_K02, 'VL_VALOR', item_f('VL_CONTADO', tFCX_CAIXAI));
            putitem_e(tTMP_K02, 'VL_FUNDO', item_f('VL_FUNDO', tFCX_CAIXAI));
          end;
          if (vInVlFundo = 1) then begin
            if (vTpDocumento = 3) then begin
              fieldsyntax item_f('VL_FUNDO', tTMP_K02), '';
            end else begin
              fieldsyntax item_f('VL_FUNDO', tTMP_K02), 'HID';
            end;
          end else begin
            fieldsyntax item_f('VL_FUNDO', tTMP_K02), 'HID';
          end;

          setocc(tFCX_HISTRELSUB, curocc(tFCX_HISTRELSUB) + 1);
        end;
      end;
    end;

    setocc vDsEntidade, curocc(vDsEntidade) + 1;
  end;

  clear_e(tFCX_CAIXAI);

  reset gformmod;

  vInBloqueiaReabertura := itemXmlB('IN_BLOQUEIA_FICHA_CEGA_CX', xParamEmp);

  if (vInBloqueiaReabertura = True) then begin
    fieldsyntax item_a('BT_REABRIR', tSIS_BOTOES), 'HID';
  end;

  return(0); exit;
end;

//-----------------------------------------------------
function TF_FCXFM001.efetua(pParams : String) : String;
//-----------------------------------------------------
const
  cDS_METHOD = 'ADICIONAL=Operação: TF_FCXFM001.efetua()';
var
  vNrSeq : Real;
  viParams, voParams, vLstLiq, vDsLinha, vDsRegistro : String;
  vInConferir : Boolean;
begin
  if (gformmod = 0) then begin
    message/info 'Nenhuma alteração efetuada!';
    return(-1); exit;
  end;

  voParams := conferirImpressaoContrato(viParams); (* *)
  if (xStatus < 0) then begin
    Result := voParams;
    return(-1); exit;
  end;

  setocc(tTMP_K02, 1);
  while (xStatus >= 0) do begin
    if (item_f('VL_FUNDO', tTMP_K02) > item_f('VL_VALOR', tTMP_K02)) then begin
      message/info 'Valor de fundo informado maior que valor de contagem!';
      return(-1); exit;
    end;
    setocc(tTMP_K02, curocc(tTMP_K02) + 1);
  end;

  clear_e(tFCX_CAIXAI);
  putitem_e(tFCX_CAIXAI, 'CD_EMPRESA', item_f('CD_EMPRESA', tFCX_CAIXAC));
  putitem_e(tFCX_CAIXAI, 'CD_TERMINAL', item_f('CD_TERMINAL', tFCX_CAIXAC));
  putitem_e(tFCX_CAIXAI, 'DT_ABERTURA', item_a('DT_ABERTURA', tFCX_CAIXAC));
  putitem_e(tFCX_CAIXAI, 'NR_SEQ', item_f('NR_SEQ', tFCX_CAIXAC));
  retrieve_e(tFCX_CAIXAI);
  if (xStatus >= 0) then begin
    voParams := tFCX_CAIXAI.Excluir();
    if (xStatus < 0) then begin
      Result := voParams;
      return(-1); exit;
    end;
  end;

  vNrSeq := 1;

  clear_e(tFCX_CAIXAI);

  setocc(tTMP_K02, 1);
  while (xStatus >= 0) do begin
    if (item_f('VL_VALOR', tTMP_K02) > 0) then begin
      creocc(tFCX_CAIXAI, -1);
      putitem_e(tFCX_CAIXAI, 'CD_EMPRESA', item_f('CD_EMPRESA', tFCX_CAIXAC));
      putitem_e(tFCX_CAIXAI, 'CD_TERMINAL', item_f('CD_TERMINAL', tFCX_CAIXAC));
      putitem_e(tFCX_CAIXAI, 'DT_ABERTURA', item_a('DT_ABERTURA', tFCX_CAIXAC));
      putitem_e(tFCX_CAIXAI, 'NR_SEQ', item_f('NR_SEQ', tFCX_CAIXAC));
      putitem_e(tFCX_CAIXAI, 'TP_DOCUMENTO', item_f('NR_CHAVE01', tTMP_K02));
      putitem_e(tFCX_CAIXAI, 'NR_SEQHISTRELSUB', item_f('NR_CHAVE02', tTMP_K02));
      putitem_e(tFCX_CAIXAI, 'VL_CONTADO', item_f('VL_VALOR', tTMP_K02));
      putitem_e(tFCX_CAIXAI, 'VL_FUNDO', item_f('VL_FUNDO', tTMP_K02));
      putitem_e(tFCX_CAIXAI, 'NR_SEQITEM', vNrSeq);
      vNrSeq := vNrSeq + 1;
    end;
    setocc(tTMP_K02, curocc(tTMP_K02) + 1);
  end;

  voParams := tFCX_CAIXAI.Salvar();

  commit;
  if (xStatus < 0) then begin
    rollback;
    return(-1); exit;
  end else begin
    message/info 'Confirmação de contagem efetuado com sucesso!';
  end;

  clear_e(tFCX_CAIXAC);
  clear_e(tTMP_K02);

  return(0); exit;
end;

//------------------------------------------------------
function TF_FCXFM001.encerra(pParams : String) : String;
//------------------------------------------------------
const
  cDS_METHOD = 'ADICIONAL=Operação: TF_FCXFM001.encerra()';
var
  viParams, voParams, vLstEmpresa, vDsErro, vDsPermite : String;
  vCdOperConf, vCdEmpresa, vCdTerminal, vNrSeq, vInConferenteCx, vCdGrupoEmpresa : Real;
  vDtAbertura : TDate;
  vTpValidaNFImpressa : Real;
begin
  voParams := conferirImpressaoContrato(viParams); (* *)
  if (xStatus < 0) then begin
    Result := voParams;
    return(-1); exit;
  end;
  if (gInFCXFP022 <> True) then begin
    askmess 'Após efetuar o Encerramento, a Contagem de Caixa poderá ser reaberta, mas após o Fechamento de Caixa, NÃO poderão ser mais lançados valores. Deseja continuar o processo?', 'Continuar, Cancelar';
    if (xStatus <> 1) then begin
      return(0); exit;
    end;
  end;
  if (gInFCXFP022 <> True) then begin
    setocc(tTMP_K02, 1);
    while (xStatus >= 0) do begin

      if (item_f('NR_CHAVE01', tTMP_K02) = 3)  and (item_f('VL_VALOR', tTMP_K02) > 0)  and (item_f('VL_FUNDO', tTMP_K02) = '' ) or (item_f('VL_FUNDO', tTMP_K02) = 0)  and (gInUtilizaVlFundo = 1) then begin
        askmess 'Valor de fundo não informado, confirma o encerramento da contagem?', 'Não, Sim';
        if (xStatus = 1) then begin
          return(-1); exit;
        end;
      end;
      if (item_f('VL_FUNDO', tTMP_K02) > item_f('VL_VALOR', tTMP_K02)) then begin
        message/info 'Valor de fundo informado maior que valor de contagem!';
        return(-1); exit;
      end;
      setocc(tTMP_K02, curocc(tTMP_K02) + 1);
    end;
  end;

  vCdEmpresa := itemXmlF('CD_EMPRESA', viParams);

  if (vCdEmpresa = 0) then begin
    viParams := '';
    putitemXml(viParams, 'CD_GRUPOEMPRESA', itemXmlF('CD_GRUPOEMPRESA', PARAM_GLB));
    voParams := activateCmp('GERSVCO032', 'buscaLstGrupoEmpresa', viParams); (*,,,, *)
    if (xStatus < 0) then begin
      Result := voParams;
      return(-1); exit;
    end;

    vLstEmpresa := itemXmlF('CD_EMPRESA', voParams);
  end else begin
    clear_e(tGER_S_EMPRESA);
    putitem_e(tGER_S_EMPRESA, 'CD_EMPRESA', vCdEmpresa);
    retrieve_e(tGER_S_EMPRESA);
    if (xStatus >= 0) then begin
      vCdGrupoempresa := item_f('CD_GRUPOEMPRESA', tGER_S_EMPRESA);

      clear_e(tGER_S_EMPRESA);
      putitem_e(tGER_S_EMPRESA, 'CD_GRUPOEMPRESA', vCdGrupoEmpresa);
      retrieve_e(tGER_S_EMPRESA);
      if (xStatus >= 0) then begin
        setocc(tGER_S_EMPRESA, -1);
        setocc(tGER_S_EMPRESA, 1);

        putlistitems vLstEmpresa, item_f('CD_EMPRESA', tGER_S_EMPRESA);
      end;
    end;
  end;

  viParams := '';
  putitemXml(viParams, 'CD_EMPRESA', vLstEmpresa);
  putitemXml(viParams, 'CD_USUARIO', itemXmlF('CD_USUARIO', PARAM_GLB));
  voParams := activateCmp('TRASVCO012', 'validaTransacaoEncerrada', viParams); (*,,,, *)
  if (xStatus < 0) then begin
    Result := voParams;
    return(-1); exit;
  end;
    viParams := '';
    vDsErro := '  Transação não recebida: ' + vDsErro' + ';
    putitemXml(viParams, 'TITULO', 'Validação de Fechamento de Caixa');
    putitemXml(viParams, 'MENSAGEM', vDsErro);
    voParams := activateCmp('GERFP008', 'EXEC', viParams); (*,,, *)
    if (xStatus < 0) then begin
      Result := voParams;
      return(-1); exit;
    end;
    return(-1); exit;
  end;
  if (gInBloqueiaTraBloqCx = True) then begin
    viParams := '';
    putitemXml(viParams, 'CD_EMPRESA', vLstEmpresa);
    putitemXml(viParams, 'CD_USUARIO', itemXmlF('CD_USUARIO', PARAM_GLB));
    voParams := activateCmp('TRASVCO012', 'validaTransacaoBloqueada', viParams); (*,,,, *)
    if (xStatus < 0) then begin
      Result := voParams;
      return(-1); exit;
    end;
      viParams := '';
      vDsErro := '  Transação bloqueada para faturamento: ' + vDsErro' + ';
      putitemXml(viParams, 'TITULO', 'Validação de Fechamento de Caixa');
      putitemXml(viParams, 'MENSAGEM', vDsErro);
      voParams := activateCmp('GERFP008', 'EXEC', viParams); (*,,, *)
      if (xStatus < 0) then begin
        Result := voParams;
        return(-1); exit;
      end;
      return(-1); exit;
    end;
  end;

  vTpValidaNFImpressa := itemXmlF('TP_VALIDA_NF_IMPRESSA', xParamEmp);

  if (vTpValidaNFImpressa = 1 ) or (vTpValidaNFImpressa = 3) then begin
    viParams := '';
    putitemXml(viParams, 'CD_EMPRESA', vLstEmpresa);
    putitemXml(viParams, 'CD_USUARIO', itemXmlF('CD_USUARIO', PARAM_GLB));
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

      putitemXml(viParams, 'CD_COMPONENTE', FCXFM001);
      putitemXml(viParams, 'DS_CAMPO', 'IN_LIBERA_FECHA_NF');
      putitemXml(viParams, 'CD_EMPRESA', itemXmlF('CD_EMPRESA', PARAM_GLB));
      putitemXml(viParams, 'CD_USUARIO', itemXmlF('CD_USUARIO', voParams));
      voParams := activateCmp('ADMSVCO009', 'verificaRestricao', viParams); (*,,, *)
      if (xStatus < 0) then begin
        Result := SetStatus(STS_ERROR, {xCdErro} '', '{xCtxErro} ''', '');
        return(-1); exit;
      end;
    end;
  end;

  viParams := '';
  putitemXml(viParams, 'IN_USULOGADO', True);
  putitemXml(viParams, 'CD_USUARIO', itemXmlF('CD_USUARIO', PARAM_GLB));
  putitemXml(viParams, 'DS_COMPONENTE', '');
  voParams := activateCmp('ADMFM020', 'exec', viParams); (*,,, *)
  if (xStatus < 0) then begin
    return(-1); exit;
  end;

  vInConferenteCx := itemXmlB('IN_CONFERENTE_CAIXA', xParamEmp);

  if (vInConferenteCx = 1) then begin
    viParams := '';
    putitemXml(viParams, 'IN_USULOGADO', False);
    putitemXml(viParams, 'CD_USUARIO', 0);
    putitemXml(viParams, 'DS_COMPONENTE', '');
    voParams := activateCmp('ADMFM020', 'exec', viParams); (*,,, *)
    if (xStatus < 0) then begin
      return(-1); exit;
    end;

    vCdOperConf := itemXmlF('CD_USUARIO', voParams);
  end else begin
    vCdOperConf := itemXmlF('CD_USUARIO', PARAM_GLB);
  end;

  clear_e(tFCX_CAIXAI);
  putitem_e(tFCX_CAIXAI, 'CD_EMPRESA', item_f('CD_EMPRESA', tFCX_CAIXAC));
  putitem_e(tFCX_CAIXAI, 'CD_TERMINAL', item_f('CD_TERMINAL', tFCX_CAIXAC));
  putitem_e(tFCX_CAIXAI, 'DT_ABERTURA', item_a('DT_ABERTURA', tFCX_CAIXAC));
  putitem_e(tFCX_CAIXAI, 'NR_SEQ', item_f('NR_SEQ', tFCX_CAIXAC));
  retrieve_e(tFCX_CAIXAI);
  if (xStatus >= 0) then begin
    voParams := tFCX_CAIXAI.Excluir();
    if (xStatus < 0) then begin
      Result := voParams;
      return(-1); exit;
    end;
  end;

  vNrSeq := 1;

  clear_e(tFCX_CAIXAI);

  setocc(tTMP_K02, 1);
  while (xStatus >= 0) do begin
    if (item_f('VL_VALOR', tTMP_K02) > 0) then begin
      creocc(tFCX_CAIXAI, -1);
      putitem_e(tFCX_CAIXAI, 'CD_EMPRESA', item_f('CD_EMPRESA', tFCX_CAIXAC));
      putitem_e(tFCX_CAIXAI, 'CD_TERMINAL', item_f('CD_TERMINAL', tFCX_CAIXAC));
      putitem_e(tFCX_CAIXAI, 'DT_ABERTURA', item_a('DT_ABERTURA', tFCX_CAIXAC));
      putitem_e(tFCX_CAIXAI, 'NR_SEQ', item_f('NR_SEQ', tFCX_CAIXAC));
      putitem_e(tFCX_CAIXAI, 'TP_DOCUMENTO', item_f('NR_CHAVE01', tTMP_K02));
      putitem_e(tFCX_CAIXAI, 'NR_SEQHISTRELSUB', item_f('NR_CHAVE02', tTMP_K02));
      putitem_e(tFCX_CAIXAI, 'VL_CONTADO', item_f('VL_VALOR', tTMP_K02));
      putitem_e(tFCX_CAIXAI, 'VL_FUNDO', item_f('VL_FUNDO', tTMP_K02));
      putitem_e(tFCX_CAIXAI, 'NR_SEQITEM', vNrSeq);
      vNrSeq := vNrSeq + 1;
    end;
    setocc(tTMP_K02, curocc(tTMP_K02) + 1);
  end;

  voParams := tFCX_CAIXAI.Salvar();
  if (xStatus < 0) then begin
    Result := voParams;
    return(-1); exit;
  end;

  vCdTerminal := item_f('CD_TERMINAL', tFCX_CAIXAC);
  vDtAbertura := item_a('DT_ABERTURA', tFCX_CAIXAC);
  vNrSeq := item_f('NR_SEQ', tFCX_CAIXAC);

  if (vLstEmpresa <> '') then begin
    repeat
      getitem(vCdEmpresa, vLstEmpresa, 1);

      clear_e(tFCX_CAIXAC);
      putitem_e(tFCX_CAIXAC, 'CD_EMPRESA', vCdEmpresa);
      putitem_e(tFCX_CAIXAC, 'CD_TERMINAL', vCdTerminal);
      putitem_e(tFCX_CAIXAC, 'DT_ABERTURA', vDtAbertura);
      putitem_e(tFCX_CAIXAC, 'NR_SEQ', vNrSeq);
      retrieve_e(tFCX_CAIXAC);
      if (xStatus >= 0) then begin
        putitem_e(tFCX_CAIXAC, 'CD_OPERCONF', vCdOperConf);

        voParams := tFCX_CAIXAC.Salvar();
        if (xStatus < 0) then begin
          Result := voParams;
          return(-1); exit;
        end;
      end;

      delitem(vLstEmpresa, 1);
    until (vLstEmpresa = '');
  end;

  commit;
  if (xStatus < 0) then begin
    rollback;
    return(-1); exit;
  end else begin

    if (gInFCXFP022 <> True) then begin
      Result := SetStatus(STS_AVISO, 'GEN001', 'Encerramento de contagem efetuado com sucesso!', cDS_METHOD);
    end;
  end;

  clear_e(tFCX_CAIXAC);
  clear_e(tTMP_K02);

  return(0); exit;
end;

//----------------------------------------------------------------
function TF_FCXFM001.validaCentroCusto(pParams : String) : String;
//----------------------------------------------------------------
const
  cDS_METHOD = 'ADICIONAL=Operação: TF_FCXFM001.validaCentroCusto()';
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
  vCdEmpresa := itemXmlF('CD_EMPRESA', viParams);
  if (vCdEmpresa = 0) then begin
    vCdEmpresa := itemXmlF('CD_EMPRESA', PARAM_GLB);
  end;
  if (vCdCCusto <> vCdEmpresa) then begin
    message/info 'Empresa não possui centro de custo cadastrado!';
    return(-1); exit;
  end;

  return(0); exit;
end;

//-----------------------------------------------------
function TF_FCXFM001.reabre(pParams : String) : String;
//-----------------------------------------------------
const
  cDS_METHOD = 'ADICIONAL=Operação: TF_FCXFM001.reabre()';
var
  viParams, voParams, vLstEmpresa : String;
  vCdEmpresa, vCdGrupoempresa : Real;
begin
  vCdEmpresa := itemXmlF('CD_EMPRESA', viParams);

  viParams := '';
  putitemXml(viParams, 'IN_USULOGADO', True);
  putitemXml(viParams, 'CD_USUARIO', 0);
  putitemXml(viParams, 'DS_COMPONENTE', '');
  voParams := activateCmp('ADMFM020', 'exec', viParams); (*,,, *)
  if (xStatus < 0) then begin
    return(-1); exit;
  end;
  if (vCdEmpresa = 0) then begin
    viParams := '';
    putitemXml(viParams, 'CD_GRUPOEMPRESA', itemXmlF('CD_GRUPOEMPRESA', PARAM_GLB));
    voParams := activateCmp('GERSVCO032', 'buscaLstGrupoEmpresa', viParams); (*,,,, *)
    if (xStatus < 0) then begin
      Result := voParams;
      return(-1); exit;
    end;

    vLstEmpresa := itemXmlF('CD_EMPRESA', voParams);
  end else begin
    clear_e(tGER_S_EMPRESA);
    putitem_e(tGER_S_EMPRESA, 'CD_EMPRESA', vCdEmpresa);
    retrieve_e(tGER_S_EMPRESA);
    if (xStatus >= 0) then begin
      vCdGrupoempresa := item_f('CD_GRUPOEMPRESA', tGER_S_EMPRESA);

      clear_e(tGER_S_EMPRESA);
      putitem_e(tGER_S_EMPRESA, 'CD_GRUPOEMPRESA', vCdGrupoEmpresa);
      retrieve_e(tGER_S_EMPRESA);
      if (xStatus >= 0) then begin
        setocc(tGER_S_EMPRESA, -1);
        setocc(tGER_S_EMPRESA, 1);

        putlistitems vLstEmpresa, item_f('CD_EMPRESA', tGER_S_EMPRESA);
      end;
    end;
  end;

  clear_e(tF_FCX_CAIXAC);
  putitem_e(tF_FCX_CAIXAC, 'CD_EMPRESA', vLstEmpresa);
  putitem_e(tF_FCX_CAIXAC, 'CD_TERMINAL', item_f('CD_TERMINAL', tFCX_CAIXAC));
  putitem_e(tF_FCX_CAIXAC, 'DT_ABERTURA', item_a('DT_ABERTURA', tFCX_CAIXAC));
  putitem_e(tF_FCX_CAIXAC, 'NR_SEQ', item_f('NR_SEQ', tFCX_CAIXAC));
  retrieve_e(tF_FCX_CAIXAC);
  if (xStatus < 0) then begin
    message/info 'Erro na abertura do caixa para preenchimento da Ficha Cega!';
    return(-1); exit;
  end else begin
    setocc(tF_FCX_CAIXAC, 1);
    while (xStatus >= 0) do begin
        if (item_f('CD_OPERCONF', tF_FCX_CAIXAC) = 0) then begin
        message/info 'Não foi feito o Encerramento do Caixa nesta data';
        return(0); exit;
      end;

        putitem_e(tF_FCX_CAIXAC, 'CD_OPERCONF', '');

      setocc(tF_FCX_CAIXAC, curocc(tF_FCX_CAIXAC) + 1);
    end;

    voParams := tF_FCX_CAIXAC.Salvar();
    if (xStatus < 0) then begin
      Result := voParams;
      return(-1); exit;
    end;

    commit;
    if (xStatus < 0) then begin
      Result := voParams;
      return(-1); exit;
    end;
  end;
end;

//------------------------------------------------------------------------
function TF_FCXFM001.conferirImpressaoContrato(pParams : String) : String;
//------------------------------------------------------------------------
const
  cDS_METHOD = 'ADICIONAL=Operação: TF_FCXFM001.conferirImpressaoContrato()';
var
  vNrSeq : Real;
  viParams, voParams, vLstLiq, vDsLinha, vDsRegistro : String;
  vInConferir : Boolean;
begin
  if (gTpValidaImpcontratoCx = 1) then begin
    vLstLiq := '';
    vInConferir := False;
    clear_e(tFGR_LIQ);
    putitem_e(tFGR_LIQ, 'CD_EMPLIQ', item_f('CD_EMPRESA', tGER_EMPRESA));
    putitem_e(tFGR_LIQ, 'DT_LIQ', '>=' + DT_ABERTURA + '.FCX_CAIXAC');
    putitem_e(tFGR_LIQ, 'CD_OPERADOR', item_f('CD_OPERADOR', tFCX_CAIXAC));
    putitem_e(tFGR_LIQ, 'DT_CANCELAMENTO', '');
    retrieve_e(tFGR_LIQ);
    setocc(tFGR_LIQ, -1);
    setocc(tFGR_LIQ, 1);
    while (xStatus >= 0) do begin
      clear_e(tFGR_LIQITEMCR);
      putitem_e(tFGR_LIQITEMCR, 'CD_EMPLIQ', item_f('CD_EMPLIQ', tFGR_LIQ));
      putitem_e(tFGR_LIQITEMCR, 'DT_LIQ', item_a('DT_LIQ', tFGR_LIQ));
      putitem_e(tFGR_LIQITEMCR, 'NR_SEQLIQ', item_f('NR_SEQLIQ', tFGR_LIQ));
      putitem_e(tFGR_LIQITEMCR, 'TP_TIPOREG', 2);
      putitem_e(tFGR_LIQITEMCR, 'TP_DOCUMENTO', 1);
      retrieve_e(tFGR_LIQITEMCR);
      while(xStatus >=0) do begin
        clear_e(tFGR_LIQCONF);
        putitem_e(tFGR_LIQCONF, 'CD_EMPLIQ', item_f('CD_EMPLIQ', tFGR_LIQITEMCR));
        putitem_e(tFGR_LIQCONF, 'DT_LIQ', item_a('DT_LIQ', tFGR_LIQITEMCR));
        putitem_e(tFGR_LIQCONF, 'NR_SEQLIQ', item_f('NR_SEQLIQ', tFGR_LIQITEMCR));
        retrieve_e(tFGR_LIQCONF);
        if (xStatus >= 0) then begin
          if (item_b('IN_CONF', tFGR_LIQCONF) = False) then begin
            vInConferir := True;
          end;
        end else begin
          vInConferir := True;
        end;
        vDsRegistro := '';
        putitemXml(vDsRegistro, 'CD_EMPLIQ', item_f('CD_EMPLIQ', tFGR_LIQITEMCR));
        putitemXml(vDsRegistro, 'DT_LIQ', item_a('DT_LIQ', tFGR_LIQITEMCR));
        putitemXml(vDsRegistro, 'NR_SEQLIQ', item_f('NR_SEQLIQ', tFGR_LIQITEMCR));
        putitemXml(vDsRegistro, 'CD_EMPFAT', item_f('CD_EMPFAT', tFGR_LIQITEMCR));
        putitemXml(vDsRegistro, 'CD_CLIENTE', item_f('CD_CLIENTE', tFGR_LIQITEMCR));
        putitemXml(vDsRegistro, 'NR_FAT', item_f('NR_FAT', tFGR_LIQITEMCR));
        putitemXml(vDsRegistro, 'NR_PARCELA', item_f('NR_PARCELA', tFGR_LIQITEMCR));

        if (item_b('IN_CONF', tFGR_LIQCONF) = '') then begin
          putitemXml(vDsRegistro, 'IN_CONF', False);
        end else begin
          putitemXml(vDsRegistro, 'IN_CONF', item_b('IN_CONF', tFGR_LIQCONF));
        end;
        putitem(vLstLiq,  vDsRegistro);

        setocc(tFGR_LIQITEMCR, curocc(tFGR_LIQITEMCR) + 1);
      end;

      setocc(tFGR_LIQ, curocc(tFGR_LIQ) + 1);
    end;
    if (vInConferir = True) then begin
      putitemXml(viParams, 'CD_EMPRESA', item_f('CD_EMPRESA', tGER_EMPRESA));
      putitemXml(viParams, 'CD_TERMINAL', item_f('CD_TERMINAL', tGER_TERMINAL));
      putitemXml(viParams, 'DT_ABERTURA', item_a('DT_ABERTURA', tFCX_CAIXAC));
      putitemXml(viParams, 'DS_LSTLIQ', vLstLiq);
      voParams := activateCmp('FCXFP021', 'exec', viParams); (*,,, *)
      if (xStatus < 0) then begin
        Result := voParams;
        return(-1); exit;
      end;
        return(-1); exit;
      end;
    end else if (xStatus = 2) then begin
      return(-1); exit;
    end;
  end;

  return(0); exit;
end;


end.
