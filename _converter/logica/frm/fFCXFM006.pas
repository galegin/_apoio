unit fFCXFM006;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, fFormTouch, ExtCtrls, cPanel, cDatasetUnf;

type
  TF_FCXFM006 = class(T_FormTouch)
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
  private
    tFCX_CAIXAC,
    tFCX_HISTREL,
    tFCX_HISTRELSUB,
    tGER_EMPRESA,
    tGER_MODFINC,
    tGER_S_EMPRESA,
    tTMP_K02,
    tTMP_NR08 : TcDatasetUnf;
    function getParam(pParams : String = '') : String;
    function setEntidade(pParams : String = '') : String;
    function preEDIT(pParams : String = '') : String;
    function posEDIT(pParams : String = '') : String;
    function posCLEAR(pParams : String = '') : String;
    function preEDIT(pParams : String = '') : String;
    function buscaCtaOperador(pParams : String = '') : String;
    function alinhaDireita(pParams : String = '') : String;
    function preencheEspaco(pParams : String = '') : String;
    function INIT(pParams : String = '') : String;
    function CLEANUP(pParams : String = '') : String;
    function carregaHistorico(pParams : String = '') : String;
    function efetua(pParams : String = '') : String;
    function validaValores(pParams : String = '') : String;
    function imprimeReciboSangria(pParams : String = '') : String;
    function verificaSaldoDocumento(pParams : String = '') : String;
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
  g %%,
  g insuficiente para retirada de R,
  gInLogMovCtaPes,
  gInPdvOtimizado,
  gInPermitirRetirada,
  gInutilizaretcartaocx,
  gvCdUsuarioEscolhido,
  gvInUtilizaCxFilial,
  gVl12D2,
  gVlsaldocaixa,
  gVlsangria : String;

procedure TF_FCXFM006.FormCreate(Sender: TObject);
begin
  inherited; //
  setEntidade();
end;

procedure TF_FCXFM006.FormShow(Sender: TObject);
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

procedure TF_FCXFM006.FormActivate(Sender: TObject);
begin
  inherited; //
end;

procedure TF_FCXFM006.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  inherited; //
end;

//---------------------------------------------------------------
function TF_FCXFM006.getParam(pParams : String = '') : String;
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
function TF_FCXFM006.setEntidade(pParams : String = '') : String;
//---------------------------------------------------------------
begin
  tFCX_CAIXAC := TcDatasetUnf.GetEntidade(Self, 'FCX_CAIXAC');
  tFCX_HISTREL := TcDatasetUnf.GetEntidade(Self, 'FCX_HISTREL');
  tFCX_HISTRELSUB := TcDatasetUnf.GetEntidade(Self, 'FCX_HISTRELSUB');
  tGER_EMPRESA := TcDatasetUnf.GetEntidade(Self, 'GER_EMPRESA');
  tGER_MODFINC := TcDatasetUnf.GetEntidade(Self, 'GER_MODFINC');
  tGER_S_EMPRESA := TcDatasetUnf.GetEntidade(Self, 'GER_S_EMPRESA');
  tTMP_K02 := TcDatasetUnf.GetEntidade(Self, 'TMP_K02');
  tTMP_NR08 := TcDatasetUnf.GetEntidade(Self, 'TMP_NR08');
end;

//---------------------------------------------------------------
function TF_FCXFM006.preEDIT(pParams : String) : String;
//---------------------------------------------------------------
const
  cDS_METHOD = 'ADICIONAL=Operação: TF_FCXFM006.preEDIT()';
begin
  return(0); exit;
end;

//---------------------------------------------------------------
function TF_FCXFM006.posEDIT(pParams : String) : String;
//---------------------------------------------------------------
const
  cDS_METHOD = 'ADICIONAL=Operação: TF_FCXFM006.posEDIT()';
begin
  return(0); exit;
end;

//-------------------------------------------------------
function TF_FCXFM006.posCLEAR(pParams : String) : String;
//-------------------------------------------------------
const
  cDS_METHOD = 'ADICIONAL=Operação: TF_FCXFM006.posCLEAR()';
var
  viParams, voParams : String;
  vCdEmpresa, vCdTerminal, vNrSeq : Real;
  vDtAbertura : TDate;
begin
  viParams := '';
  voParams := activateCmp('FCXSVCO001', 'buscaCaixa', viParams); (*,,,, *)
  if (xStatus < 0) then begin
    Result := voParams;
    return(-1); exit;
  end;

  vCdEmpresa := itemXmlF('CD_EMPRESA', voParams);
  vCdTerminal := itemXmlF('CD_TERMINAL', voParams);
  vDtAbertura := itemXml('DT_ABERTURA', voParams);
  vNrSeq := itemXmlF('NR_SEQ', voParams);

  clear_e(tFCX_CAIXAC);
  putitem_e(tFCX_CAIXAC, 'CD_EMPRESA', vCdEmpresa);
  putitem_e(tFCX_CAIXAC, 'CD_TERMINAL', vCdTerminal);
  putitem_e(tFCX_CAIXAC, 'DT_ABERTURA', vDtAbertura);
  putitem_e(tFCX_CAIXAC, 'NR_SEQ', vNrSeq);
  retrieve_e(tFCX_CAIXAC);
  if (xStatus < 0) then begin
    message/info 'Erro na abertura do caixa para retirada!';
    return(-1); exit;
  end;

  voParams := carregaHistorico(viParams); (* *)
  if (xStatus < 0) then begin
    Result := voParams;
    return(-1); exit;
  end;

  setocc(tTMP_NR08, 1);

  if (gvInUtilizaCxFilial = 1) then begin
    putitem_e(tFCX_CAIXAC, 'DS_CAIXA', 'Filial');
  end else begin
    putitem_e(tFCX_CAIXAC, 'DS_CAIXA', 'Matriz');
  end;

  return(0); exit;
end;

//------------------------------------------------------
function TF_FCXFM006.preEDIT(pParams : String) : String;
//------------------------------------------------------
const
  cDS_METHOD = 'ADICIONAL=Operação: TF_FCXFM006.preEDIT()';
var
  viParams, voParams, vDsMotivo : String;
  vCdEmpresa, vCdTerminal, vNrSeq : Real;
  vDtAbertura : TDate;
begin
  viParams := '';
  voParams := activateCmp('FCXSVCO001', 'buscaCaixa', viParams); (*,,,, *)
  if (xStatus < 0) then begin
    Result := voParams;
    return(-1); exit;
  end;

  vCdEmpresa := itemXmlF('CD_EMPRESA', voParams);
  vCdTerminal := itemXmlF('CD_TERMINAL', voParams);
  vDtAbertura := itemXml('DT_ABERTURA', voParams);
  vNrSeq := itemXmlF('NR_SEQ', voParams);

  clear_e(tFCX_CAIXAC);
  putitem_e(tFCX_CAIXAC, 'CD_EMPRESA', vCdEmpresa);
  putitem_e(tFCX_CAIXAC, 'CD_TERMINAL', vCdTerminal);
  putitem_e(tFCX_CAIXAC, 'DT_ABERTURA', vDtAbertura);
  putitem_e(tFCX_CAIXAC, 'NR_SEQ', vNrSeq);
  retrieve_e(tFCX_CAIXAC);
  if (xStatus < 0) then begin
    message/info 'Erro na abertura do caixa para retirada!';
    return(-1); exit;
  end;

  gvInUtilizaCxFilial := itemXmlB('IN_UTILIZA_CXFILIAL', xParamEmp);

  if (gvInUtilizaCxFilial = 1) then begin
    putitem_e(tFCX_CAIXAC, 'DS_CAIXA', 'Filial');
  end else begin
    putitem_e(tFCX_CAIXAC, 'DS_CAIXA', 'Matriz');
  end;

  voParams := carregaHistorico(viParams); (* *)
  if (xStatus < 0) then begin
    Result := voParams;
    return(-1); exit;
  end;
  if (itemXml('IN_PDV', viParams) = True ) and (gInPdvOtimizado = True) then begin
    if (itemXml('DS_MOTIVO', viParams) <> '') then begin
      vDsMotivo := itemXml('DS_MOTIVO', viParams);
      vDsMotivo := vDsMotivo[1:60];
      putitem_e(tFCX_CAIXAC, 'DS_MOTIVO', vDsMotivo);
    end;
  end;

  setocc(tTMP_NR08, 1);

  return(0); exit;
end;

//---------------------------------------------------------------
function TF_FCXFM006.buscaCtaOperador(pParams : String) : String;
//---------------------------------------------------------------
const
  cDS_METHOD = 'ADICIONAL=Operação: TF_FCXFM006.buscaCtaOperador()';
var
  (* string poLstCtaPes : OUT *)
  viParams, voParams, vDsLstEmpresa, vDsLstCtaPes : String;
  vCdEmpresa, vNrCtaPes : Real;
begin
  vDsLstEmpresa := '';

  clear_e(tGER_S_EMPRESA);
  putitem_e(tGER_S_EMPRESA, 'CD_GRUPOEMPRESA', itemXmlF('CD_GRUPOEMPRESA', PARAM_GLB));
  retrieve_e(tGER_S_EMPRESA);
  if (xStatus >= 0) then begin
    setocc(tGER_S_EMPRESA, 1);
    while (xStatus >= 0) do begin
      putitem(vDsLstEmpresa,  item_f('CD_EMPRESA', tGER_S_EMPRESA));

      setocc(tGER_S_EMPRESA, curocc(tGER_S_EMPRESA) + 1);
    end;
  end;

  vDsLstCtaPes := '';

  if (vDsLstEmpresa <> '') then begin
    repeat
      getitem(vCdEmpresa, vDsLstEmpresa, 1);

      viParams := '';
      putitemXml(viParams, 'CD_EMPRESA', vCdEmpresa);
      putitemXml(viParams, 'CD_OPERADOR', itemXmlF('CD_USUARIO', PARAM_GLB));
      voParams := activateCmp('FCCSVCO002', 'buscaContaOperador', viParams); (*,,,, *)
      if (xStatus < 0) then begin
        Result := voParams;
        return(-1); exit;
      end;

      vNrCtaPes := itemXmlF('NR_CTAPES', voParams);

      putitem(vDsLstCtaPes,  vNrCtaPes);

      delitem(vDsLstEmpresa, 1);
    until (vDsLstEmpresa = '');
  end;

  poLstCtaPes := vDsLstCtaPes;

  return(0); exit;
end;

//------------------------------------------------------------
function TF_FCXFM006.alinhaDireita(pParams : String) : String;
//------------------------------------------------------------
const
  cDS_METHOD = 'ADICIONAL=Operação: TF_FCXFM006.alinhaDireita()';
var
  (* string piNumero : IN / numeric piTamanho : IN / string poNumero : OUT *)
  vNrIndice : Real;
begin
  vNrIndice := 1;
  length piNumero;
  while (vNrIndice <= piTamanho - gresult) do begin
    poNumero := '' + poNumero + ' ';
    vNrIndice := vNrIndice + 1;
  end;
  if (piTamanho < gresult) then begin
    poNumero := '' + poNumero' + piNumero[gresult + ' + ' - piTamanho + 1]';
  end else begin
    poNumero := '' + poNumero' + piNumero' + ' + ';
  end;

  return 0;
end;

//-------------------------------------------------------------
function TF_FCXFM006.preencheEspaco(pParams : String) : String;
//-------------------------------------------------------------
const
  cDS_METHOD = 'ADICIONAL=Operação: TF_FCXFM006.preencheEspaco()';
var
  (* string piDsCampo : IN / numeric piNrTamanho : IN / string poDsCampo : OUT *)
  vNrTamanho : Real;
begin
  poDsCampo := piDsCampo[1 : piNrTamanho];
  length(poDsCampo);
  vNrTamanho := gresult;
  while (vNrTamanho < piNrTamanho) do begin
    poDsCampo := '' + poDsCampo + ' ';
    vNrTamanho := vNrTamanho + 1;
  end;

  return(0); exit;
end;

//---------------------------------------------------
function TF_FCXFM006.INIT(pParams : String) : String;
//---------------------------------------------------
const
  cDS_METHOD = 'ADICIONAL=Operação: TF_FCXFM006.INIT()';
begin
  xParam := '';

  putitem(xParam,  'IN_LOG_MOV_CTAPES');

  xParam := T_ADMSVCO001.GetParametro(xParam); (*xParam,xParam,, *)

  gInLogMovCtaPes := itemXmlB('IN_LOG_MOV_CTAPES', xParam);

  putitem(xParamEmp,  'CD_CTAPES_CXFILIAL');
  putitem(xParamEmp,  'CD_CTAPES_CXMATRIZ');
  putitem(xParamEmp,  'IN_UTILIZA_CXFILIAL');
  putitem(xParamEmp,  'NR_MODREC_SANGRIA');
  putitem(xParamEmp,  'IN_PDV_OTIMIZADO');
  putitem(xParamEmp,  'IN_UTILIZA_RET_CARTAO_CX');
  putitem(xParamEmp,  'IN_PERMITIR_AUTO_RET');
  xParamEmp := T_ADMSVCO001.GetParamEmpresa(piCdEmpresa, xParamEmp); (*itemXml('CD_EMPRESA', *)
  gInPdvOtimizado := itemXmlB('IN_PDV_OTIMIZADO', xParamEmp);

  gInutilizaretcartaocx= itemXmlB('IN_UTILIZA_RET_CARTAO_CX', xParamEmp);

  gInPermitirRetirada := itemXmlB('IN_PERMITIR_AUTO_RET', xParamEmp);

  _Caption := '' + FCXFM + '006 - Retirada de Caixa';

end;

//------------------------------------------------------
function TF_FCXFM006.CLEANUP(pParams : String) : String;
//------------------------------------------------------
const
  cDS_METHOD = 'ADICIONAL=Operação: TF_FCXFM006.CLEANUP()';
begin
end;

//---------------------------------------------------------------
function TF_FCXFM006.carregaHistorico(pParams : String) : String;
//---------------------------------------------------------------
const
  cDS_METHOD = 'ADICIONAL=Operação: TF_FCXFM006.carregaHistorico()';
var
  vInGerar : Boolean;
begin
  clear_e(tFCX_HISTREL);
  retrieve_e(tFCX_HISTREL);
  setocc(tFCX_HISTREL, 1);
  while (xStatus >= 0) do begin

    if (item_f('TP_DOCUMENTO', tFCX_HISTREL) = 2 ) or (item_f('TP_DOCUMENTO', tFCX_HISTREL) = 3 ) or (item_f('TP_DOCUMENTO', tFCX_HISTREL) = 4  or (item_f('TP_DOCUMENTO', tFCX_HISTREL) = 5))  and (item_b('IN_RECEBIMENTO', tFCX_HISTREL) = True ) or (item_b('IN_FATURAMENTO', tFCX_HISTREL) = True) then begin
      if (empty(tFCX_HISTRELSUB) = False) then begin
        setocc(tFCX_HISTRELSUB, 1);
        while (xStatus >= 0) do begin

          vInGerar := True;
          if (gInutilizaretcartaocx <> True)  and (item_f('TP_DOCUMENTO', tFCX_HISTREL) = 4 ) or (item_f('TP_DOCUMENTO', tFCX_HISTREL) = 5) then begin
            vInGerar := False;
          end;
          if (vInGerar = True) then begin
            creocc(tTMP_K02, -1);
            putitem_e(tTMP_K02, 'NR_CHAVE01', item_f('TP_DOCUMENTO', tFCX_HISTRELSUB));
            putitem_e(tTMP_K02, 'NR_CHAVE02', item_f('NR_SEQHISTRELSUB', tFCX_HISTRELSUB));
            retrieve_o(tTMP_K02);
            if (xStatus = -7) then begin
              retrieve_x(tTMP_K02);
            end;
            if (item_f('TP_DOCUMENTO', tFCX_HISTREL) = 2) then begin
              putitem_e(tTMP_K02, 'DS_HISTORICO', 'CHEQUE');
            end else if (item_f('TP_DOCUMENTO', tFCX_HISTREL) = 3) then begin
              putitem_e(tTMP_K02, 'DS_HISTORICO', 'DINHEIRO');
            end else if (item_f('TP_DOCUMENTO', tFCX_HISTREL) = 16) then begin
              putitem_e(tTMP_K02, 'DS_HISTORICO', 'TED/DOC');
            end else if (item_f('TP_DOCUMENTO', tFCX_HISTREL) = 4)  or (item_f('TP_DOCUMENTO', tFCX_HISTREL) = 5) then begin
              putitem_e(tTMP_K02, 'DS_HISTORICO', item_a('DS_HISTRELSUB', tFCX_HISTRELSUB));

            end;
          end;

          setocc(tFCX_HISTRELSUB, curocc(tFCX_HISTRELSUB) + 1);
        end;
      end;
    end;
    setocc(tFCX_HISTREL, curocc(tFCX_HISTREL) + 1);
  end;

  sort_e(tTMP_K02, '  sort/e , nr_chave01;');

  setocc(tTMP_K02, 1);

  reset gformmod;

  return(0); exit;
end;

//-----------------------------------------------------
function TF_FCXFM006.efetua(pParams : String) : String;
//-----------------------------------------------------
const
  cDS_METHOD = 'ADICIONAL=Operação: TF_FCXFM006.efetua()';
var
  viParams, voParams, vInErro, vDsObs : String;
  vCxConta, vInUtilizaCxFilial, vCdUsuario, vCdEmpresa, vNrCtaPes, vVlValor, vNrSeqMovRel : Real;
  vNrCtaPesObs, vNrSeqMovObs, vVlSaldoAntDoc, vVlSaldoAnt, vNrCtaPesFCC, vNrSeqMovFCC, vVlSaldoAtual, vVlSaldoAtualDoc : Real;
  vDtMovimObs, vDtMovimFCC : TDate;
begin
  vCdUsuario := itemXmlF('CD_USUARIO', PARAM_GLB);

  gVlsangria := '';

  viParams := '';
  putitemXml(viParams, 'IN_USULOGADO', True);
  putitemXml(viParams, 'CD_USUARIO', vCdUsuario);
  putitemXml(viParams, 'DS_COMPONENTE', '');
  voParams := activateCmp('ADMFM020', 'exec', viParams); (*,,, *)
  if (xStatus < 0) then begin
    return(-1); exit;
  end;

  viParams := '';
  putitemXml(viParams, 'IN_USULOGADO', False);
  putitemXml(viParams, 'CD_USUARIO', 0);
  if (gInPermitirRetirada = True) then begin
    putitemXml(viParams, 'DS_COMPONENTE', 'FCXFM006R');
  end else begin
    putitemXml(viParams, 'DS_COMPONENTE', 'FCXFM006');
  end;
  voParams := activateCmp('ADMFM020', 'exec', viParams); (*,,, *)
  if (xStatus < 0) then begin
    return(-1); exit;
  end;
  gvCdUsuarioEscolhido := itemXmlF('CD_USUARIO', voParams);

  vDsObs := 'LIBERACAO DE RETIRADA: USUARIOS ' + FloatToStr(vCdUsuario) + ' E ' + gvCdUsuarioEscolhido' + ';

  vInUtilizaCxFilial := itemXmlB('IN_UTILIZA_CXFILIAL', xParamEmp);

  if (vInUtilizaCxFilial = 1) then begin
    vCxConta := itemXmlF('CD_CTAPES_CXFILIAL', xParamEmp);
  end else begin
    vCxConta := itemXmlF('CD_CTAPES_CXMATRIZ', xParamEmp);
  end;

  vInErro := False;

  setocc(tTMP_K02, 1);
  while (xStatus >= 0) do begin
    if (item_f('VL_VALOR', tTMP_K02) > 0) then begin
      if (gInPdvOtimizado <> True) then begin
        viParams := '';
        putitemXml(viParams, 'CD_EMPRESA', item_f('CD_EMPRESA', tFCX_CAIXAC));
        putitemXml(viParams, 'CD_TERMINAL', item_f('CD_TERMINAL', tFCX_CAIXAC));
        putitemXml(viParams, 'DT_ABERTURA', item_a('DT_ABERTURA', tFCX_CAIXAC));
        putitemXml(viParams, 'NR_SEQ', item_f('NR_SEQ', tFCX_CAIXAC));
        putitemXml(viParams, 'VL_VALOR', item_f('VL_VALOR', tTMP_K02));
        putitemXml(viParams, 'TP_DOCUMENTO', item_f('NR_CHAVE01', tTMP_K02));
        putitemXml(viParams, 'NR_SEQHISTRELSUB', item_f('NR_CHAVE02', tTMP_K02));
        putitemXml(viParams, 'DS_AUX', item_a('DS_MOTIVO', tFCX_CAIXAC));
        putitemXml(viParams, 'DS_OBS', vDsObs);
        putitemXml(viParams, 'TP_PROCESSO', 2);

        voParams := activateCmp('SICSVCO007', 'validaRetiradaCaixa', viParams); (*,,,, *)
        if (xStatus < 0) then begin
          Result := voParams;
          return(-1); exit;
        end;

        vCdEmpresa := itemXmlF('CD_EMPRESA', voParams);
        vNrCtaPes := itemXmlF('NR_CTAPES', voParams);
        vVlValor := itemXmlF('VL_VALOR', voParams);

        if (vInUtilizaCxFilial = 1) then begin
          vCxConta := itemXmlF('CD_CTAPES_CXFILIAL', voParams);
        end else begin
          vCxConta := itemXmlF('CD_CTAPES_CXMATRIZ', voParams);
        end;
      end else begin
        vCdEmpresa := item_f('CD_EMPRESA', tFCX_CAIXAC);
        vNrCtaPes := item_f('NR_CTAPES', tFCX_CAIXAC);
        vVlValor := item_f('VL_VALOR', tTMP_K02);
      end;
      if (vVlValor > 0) then begin
        if (gInLogMovCtaPes = True) then begin
          viParams := '';
          putitemXml(viParams, 'NR_CTAPES', vNrCtaPes);
          putitemXml(viParams, 'DT_SALDO', itemXml('DT_SISTEMA', PARAM_GLB));
          voParams := activateCmp('FCCSVCO002', 'buscaSaldoConta', viParams); (*,,'',,, *)
          if (xStatus < 0) then begin
            Result := voParams;
            return(-1); exit;
          end;
          vVlSaldoAnt := itemXmlF('VL_SALDO', voParams);

          viParams := '';
          putitemXml(viParams, 'NR_CTAPES', vNrCtaPes);
          putitemXml(viParams, 'TP_DOCUMENTO', item_f('NR_CHAVE01', tTMP_K02));
          putitemXml(viParams, 'NR_SEQHISTRELSUB', item_f('NR_CHAVE02', tTMP_K02));
          putitemXml(viParams, 'DT_SALDO', itemXml('DT_SISTEMA', PARAM_GLB));
          voParams := activateCmp('FCCSVCO002', 'buscaSaldoCtaTp', viParams); (*,,'',,, *)
          if (xStatus < 0) then begin
            Result := voParams;
            return(-1); exit;
          end;
          vVlSaldoAntDoc := itemXmlF('VL_SALDO', voParams);
        end;

        viParams := '';
        putitemXml(viParams, 'CD_EMPRESA', vCdEmpresa);
        putitemXml(viParams, 'NR_CTAPES', vNrCtaPes);
        putitemXml(viParams, 'DT_MOVIMENTO', itemXml('DT_SISTEMA', PARAM_GLB));
        putitemXml(viParams, 'CD_HISTORICO', 833);
        putitemXml(viParams, 'DS_AUX', item_a('DS_MOTIVO', tFCX_CAIXAC));
        putitemXml(viParams, 'VL_LANCTO', vVlValor);
        putitemXml(viParams, 'IN_ESTORNO', 'N');
        putitemXml(viParams, 'TP_DOCUMENTO', item_f('NR_CHAVE01', tTMP_K02));
        putitemXml(viParams, 'NR_SEQHISTRELSUB', item_f('NR_CHAVE02', tTMP_K02));
        putitemXml(viParams, 'IN_CAIXA', True);
        putitemXml(viParams, 'CD_TERMINAL', item_f('CD_TERMINAL', tFCX_CAIXAC));
        putitemXml(viParams, 'DT_ABERTURA', item_a('DT_ABERTURA', tFCX_CAIXAC));
        putitemXml(viParams, 'NR_SEQCAIXA', item_f('NR_SEQ', tFCX_CAIXAC));
        putitemXml(viParams, 'DS_OBS', vDsObs);

        if (vNrSeqMovRel > 0) then begin
          putitemXml(viParams, 'NR_SEQMOVREL', vNrSeqMovRel);
        end;

        voParams := activateCmp('FCCSVCO002', 'movimentaConta', viParams); (*,,,,, *)
        if (xStatus < 0) then begin
          Result := voParams;
          return(-1); exit;
        end;
        if (gInLogMovCtaPes = True) then begin
          vNrCtaPesFCC := itemXmlF('NR_CTAPES', voParams);
          vDtMovimFCC := itemXml('DT_MOVIM', voParams);
          vNrSeqMovFCC := itemXmlF('NR_SEQMOV', voParams);
        end;

        vNrCtaPesObs := itemXmlF('NR_CTAPES', voParams);
        vDtMovimObs := itemXml('DT_MOVIM', voParams);
        vNrSeqMovObs := itemXmlF('NR_SEQMOV', voParams);
        putitemXml(viParams, 'NR_CTAPES', vNrCtaPesObs);
        putitemXml(viParams, 'DT_MOVIM', vDtMovimObs);
        putitemXml(viParams, 'NR_SEQMOV', vNrSeqMovObs);
        putitemXml(viParams, 'CD_COMPONENTE', 'FCXFM006');
        putitemXml(viParams, 'DS_OBS', item_a('DS_MOTIVO', tFCX_CAIXAC));
        voParams := activateCmp('FCCSVCO002', 'gravaObsMov', viParams); (*,,,, *)
        if (xStatus < 0) then begin
          Result := SetStatus(STS_ERROR, {xCdErro} '', '{xCtxErro} ''', '');
          vInErro := True;
        end;
        if (gInLogMovCtaPes = True) then begin
          viParams := '';
          putitemXml(viParams, 'NR_CTAPES', vNrCtaPes);
          putitemXml(viParams, 'DT_SALDO', itemXml('DT_SISTEMA', PARAM_GLB));
          voParams := activateCmp('FCCSVCO002', 'buscaSaldoConta', viParams); (*,,'',,, *)
          if (xStatus < 0) then begin
            Result := voParams;
            return(-1); exit;
          end;
          vVlSaldoAtual := itemXmlF('VL_SALDO', voParams);

          viParams := '';
          putitemXml(viParams, 'NR_CTAPES', vNrCtaPes);
          putitemXml(viParams, 'TP_DOCUMENTO', item_f('NR_CHAVE01', tTMP_K02));
          putitemXml(viParams, 'NR_SEQHISTRELSUB', item_f('NR_CHAVE02', tTMP_K02));
          putitemXml(viParams, 'DT_SALDO', itemXml('DT_SISTEMA', PARAM_GLB));
          voParams := activateCmp('FCCSVCO002', 'buscaSaldoCtaTp', viParams); (*,,'',,, *)
          if (xStatus < 0) then begin
            Result := voParams;
            return(-1); exit;
          end;
          vVlSaldoAtualDoc := itemXmlF('VL_SALDO', voParams);

          viParams := '';
          putitemXml(viParams, 'TP_PROCESSO', 2);
          putitemXml(viParams, 'TP_DOCUMENTO', item_f('NR_CHAVE01', tTMP_K02));
          putitemXml(viParams, 'NR_CTAPES', vNrCtaPes);
          putitemXml(viParams, 'VL_LANCAMENTO', vVlValor);
          putitemXml(viParams, 'VL_SALDODOC', vVlSaldoAtualDoc);
          putitemXml(viParams, 'VL_SALDOCTA', vVlSaldoAtual);
          putitemXml(viParams, 'VL_SALDOANTDOC', vVlSaldoAntDoc);
          putitemXml(viParams, 'VL_SALDOANTCTA', vVlSaldoAnt);
          putitemXml(viParams, 'NR_CTAPESFCC', vNrCtaPesFCC);
          putitemXml(viParams, 'DT_MOVIMFCC', vDtMovimFCC);
          putitemXml(viParams, 'NR_SEQMOVFCC', vNrSeqMovFCC);
          voParams := activateCmp('FCCSVCO018', 'gravarLogMovtoCtaPes', viParams); (*,,,, *)
          if (xStatus < 0) then begin
            Result := voParams;
            return(-1); exit;
          end;
        end;
        if (gInLogMovCtaPes = True) then begin
          viParams := '';
          putitemXml(viParams, 'NR_CTAPES', vCxConta);
          putitemXml(viParams, 'DT_SALDO', itemXml('DT_SISTEMA', PARAM_GLB));
          voParams := activateCmp('FCCSVCO002', 'buscaSaldoConta', viParams); (*,,'',,, *)
          if (xStatus < 0) then begin
            Result := voParams;
            return(-1); exit;
          end;
          vVlSaldoAnt := itemXmlF('VL_SALDO', voParams);

          viParams := '';
          putitemXml(viParams, 'NR_CTAPES', vCxConta);
          putitemXml(viParams, 'TP_DOCUMENTO', item_f('NR_CHAVE01', tTMP_K02));
          putitemXml(viParams, 'NR_SEQHISTRELSUB', item_f('NR_CHAVE02', tTMP_K02));
          putitemXml(viParams, 'DT_SALDO', itemXml('DT_SISTEMA', PARAM_GLB));
          voParams := activateCmp('FCCSVCO002', 'buscaSaldoCtaTp', viParams); (*,,'',,, *)
          if (xStatus < 0) then begin
            Result := voParams;
            return(-1); exit;
          end;
          vVlSaldoAntDoc := itemXmlF('VL_SALDO', voParams);
        end;

        viParams := '';
        putitemXml(viParams, 'CD_EMPRESA', vCdEmpresa);
        putitemXml(viParams, 'NR_CTAPES', vCxConta);
        putitemXml(viParams, 'DT_MOVIMENTO', itemXml('DT_SISTEMA', PARAM_GLB));
        putitemXml(viParams, 'CD_HISTORICO', 832);
        putitemXml(viParams, 'VL_LANCTO', vVlValor);
        putitemXml(viParams, 'TP_DOCUMENTO', item_f('NR_CHAVE01', tTMP_K02));
        putitemXml(viParams, 'NR_SEQHISTRELSUB', item_f('NR_CHAVE02', tTMP_K02));
        putitemXml(viParams, 'IN_ESTORNO', 'N');
        putitemXml(viParams, 'DS_AUX', 'RET. CX OP: ' + CD_OPERADOR + '.FCX_CAIXAC');
        putitemXml(viParams, 'DS_OBS', vDsObs);

        if (vNrSeqMovRel > 0) then begin
          putitemXml(viParams, 'NR_SEQMOVREL', vNrSeqMovRel);
        end;

        voParams := activateCmp('FCCSVCO002', 'movimentaConta', viParams); (*,,,, *)
        if (xStatus < 0) then begin
          Result := voParams;
          return(-1); exit;
        end;

        vNrCtaPesObs := itemXmlF('NR_CTAPES', voParams);
        vDtMovimObs := itemXml('DT_MOVIM', voParams);
        vNrSeqMovObs := itemXmlF('NR_SEQMOV', voParams);

        if (gInLogMovCtaPes = True) then begin
          vNrCtaPesFCC := itemXmlF('NR_CTAPES', voParams);
          vDtMovimFCC := itemXml('DT_MOVIM', voParams);
          vNrSeqMovFCC := itemXmlF('NR_SEQMOV', voParams);
        end;

        putitemXml(viParams, 'NR_CTAPES', vNrCtaPesObs);
        putitemXml(viParams, 'DT_MOVIM', vDtMovimObs);
        putitemXml(viParams, 'NR_SEQMOV', vNrSeqMovObs);
        putitemXml(viParams, 'CD_COMPONENTE', 'FCXFM006');
        putitemXml(viParams, 'DS_OBS', item_a('DS_MOTIVO', tFCX_CAIXAC));
        voParams := activateCmp('FCCSVCO002', 'gravaObsMov', viParams); (*,,,, *)
        if (xStatus < 0) then begin
          Result := SetStatus(STS_ERROR, {xCdErro} '', '{xCtxErro} ''', '');
          vInErro := True;
        end;
        if (gInLogMovCtaPes = True) then begin
          viParams := '';
          putitemXml(viParams, 'NR_CTAPES', vCxConta);
          putitemXml(viParams, 'DT_SALDO', itemXml('DT_SISTEMA', PARAM_GLB));
          voParams := activateCmp('FCCSVCO002', 'buscaSaldoConta', viParams); (*,,'',,, *)
          if (xStatus < 0) then begin
            Result := voParams;
            return(-1); exit;
          end;
          vVlSaldoAtual := itemXmlF('VL_SALDO', voParams);

          viParams := '';
          putitemXml(viParams, 'NR_CTAPES', vCxConta);
          putitemXml(viParams, 'TP_DOCUMENTO', item_f('NR_CHAVE01', tTMP_K02));
          putitemXml(viParams, 'NR_SEQHISTRELSUB', item_f('NR_CHAVE02', tTMP_K02));
          putitemXml(viParams, 'DT_SALDO', itemXml('DT_SISTEMA', PARAM_GLB));
          voParams := activateCmp('FCCSVCO002', 'buscaSaldoCtaTp', viParams); (*,,'',,, *)
          if (xStatus < 0) then begin
            Result := voParams;
            return(-1); exit;
          end;
          vVlSaldoAtualDoc := itemXmlF('VL_SALDO', voParams);

          viParams := '';
          putitemXml(viParams, 'TP_PROCESSO', 2);
          putitemXml(viParams, 'TP_DOCUMENTO', item_f('NR_CHAVE01', tTMP_K02));
          putitemXml(viParams, 'NR_CTAPES', vCxConta);
          putitemXml(viParams, 'VL_LANCAMENTO', vVlValor);
          putitemXml(viParams, 'VL_SALDODOC', vVlSaldoAtualDoc);
          putitemXml(viParams, 'VL_SALDOCTA', vVlSaldoAtual);
          putitemXml(viParams, 'VL_SALDOANTDOC', vVlSaldoAntDoc);
          putitemXml(viParams, 'VL_SALDOANTCTA', vVlSaldoAnt);
          putitemXml(viParams, 'NR_CTAPESFCC', vNrCtaPesFCC);
          putitemXml(viParams, 'DT_MOVIMFCC', vDtMovimFCC);
          putitemXml(viParams, 'NR_SEQMOVFCC', vNrSeqMovFCC);
          voParams := activateCmp('FCCSVCO018', 'gravarLogMovtoCtaPes', viParams); (*,,,, *)
          if (xStatus < 0) then begin
            Result := voParams;
            return(-1); exit;
          end;
        end;
        if (item_f('NR_CHAVE01', tTMP_K02) = 2)  and (vInUtilizaCxFilial <> 1) then begin
          if (gInLogMovCtaPes = True) then begin
            viParams := '';
            putitemXml(viParams, 'NR_CTAPES', vCxConta);
            putitemXml(viParams, 'DT_SALDO', itemXml('DT_SISTEMA', PARAM_GLB));
            voParams := activateCmp('FCCSVCO002', 'buscaSaldoConta', viParams); (*,,'',,, *)
            if (xStatus < 0) then begin
              Result := voParams;
              return(-1); exit;
            end;
            vVlSaldoAnt := itemXmlF('VL_SALDO', voParams);

            viParams := '';
            putitemXml(viParams, 'NR_CTAPES', vCxConta);
            putitemXml(viParams, 'TP_DOCUMENTO', item_f('NR_CHAVE01', tTMP_K02));
            putitemXml(viParams, 'NR_SEQHISTRELSUB', item_f('NR_CHAVE02', tTMP_K02));
            putitemXml(viParams, 'DT_SALDO', itemXml('DT_SISTEMA', PARAM_GLB));
            voParams := activateCmp('FCCSVCO002', 'buscaSaldoCtaTp', viParams); (*,,'',,, *)
            if (xStatus < 0) then begin
              Result := voParams;
              return(-1); exit;
            end;
            vVlSaldoAntDoc := itemXmlF('VL_SALDO', voParams);
          end;

          viParams := '';
          putitemXml(viParams, 'CD_EMPRESA', vCdEmpresa);
          putitemXml(viParams, 'NR_CTAPES', vCxConta);
          putitemXml(viParams, 'DT_MOVIMENTO', itemXml('DT_SISTEMA', PARAM_GLB));
          putitemXml(viParams, 'CD_HISTORICO', 833);
          putitemXml(viParams, 'DS_AUX', item_a('DS_MOTIVO', tFCX_CAIXAC));
          putitemXml(viParams, 'VL_LANCTO', vVlValor);
          putitemXml(viParams, 'IN_ESTORNO', 'N');
          putitemXml(viParams, 'TP_DOCUMENTO', item_f('NR_CHAVE01', tTMP_K02));
          putitemXml(viParams, 'NR_SEQHISTRELSUB', item_f('NR_CHAVE02', tTMP_K02));
          putitemXml(viParams, 'DS_AUX', 'RET. CX OP: ' + CD_OPERADOR + '.FCX_CAIXAC');
          putitemXml(viParams, 'DS_OBS', vDsObs);

          voParams := activateCmp('FCCSVCO002', 'movimentaConta', viParams); (*,,,, *)
          if (xStatus < 0) then begin
            Result := voParams;
            return(-1); exit;
          end;

          vNrCtaPesObs := itemXmlF('NR_CTAPES', voParams);
          vDtMovimObs := itemXml('DT_MOVIM', voParams);
          vNrSeqMovObs := itemXmlF('NR_SEQMOV', voParams);

          if (gInLogMovCtaPes = True) then begin
            vNrCtaPesFCC := itemXmlF('NR_CTAPES', voParams);
            vDtMovimFCC := itemXml('DT_MOVIM', voParams);
            vNrSeqMovFCC := itemXmlF('NR_SEQMOV', voParams);
          end;

          putitemXml(viParams, 'NR_CTAPES', vNrCtaPesObs);
          putitemXml(viParams, 'DT_MOVIM', vDtMovimObs);
          putitemXml(viParams, 'NR_SEQMOV', vNrSeqMovObs);
          putitemXml(viParams, 'CD_COMPONENTE', 'FCXFM006');
          putitemXml(viParams, 'DS_OBS', item_a('DS_MOTIVO', tFCX_CAIXAC));
          voParams := activateCmp('FCCSVCO002', 'gravaObsMov', viParams); (*,,,, *)
          if (xStatus < 0) then begin
            Result := SetStatus(STS_ERROR, {xCdErro} '', '{xCtxErro} ''', '');
            vInErro := True;
          end;
          if (gInLogMovCtaPes = True) then begin
            viParams := '';
            putitemXml(viParams, 'NR_CTAPES', vCxConta);
            putitemXml(viParams, 'DT_SALDO', itemXml('DT_SISTEMA', PARAM_GLB));
            voParams := activateCmp('FCCSVCO002', 'buscaSaldoConta', viParams); (*,,'',,, *)
            if (xStatus < 0) then begin
              Result := voParams;
              return(-1); exit;
            end;
            vVlSaldoAtual := itemXmlF('VL_SALDO', voParams);

            viParams := '';
            putitemXml(viParams, 'NR_CTAPES', vCxConta);
            putitemXml(viParams, 'TP_DOCUMENTO', item_f('NR_CHAVE01', tTMP_K02));
            putitemXml(viParams, 'NR_SEQHISTRELSUB', item_f('NR_CHAVE02', tTMP_K02));
            putitemXml(viParams, 'DT_SALDO', itemXml('DT_SISTEMA', PARAM_GLB));
            voParams := activateCmp('FCCSVCO002', 'buscaSaldoCtaTp', viParams); (*,,'',,, *)
            if (xStatus < 0) then begin
              Result := voParams;
              return(-1); exit;
            end;
            vVlSaldoAtualDoc := itemXmlF('VL_SALDO', voParams);

            viParams := '';
            putitemXml(viParams, 'TP_PROCESSO', 2);
            putitemXml(viParams, 'TP_DOCUMENTO', item_f('NR_CHAVE01', tTMP_K02));
            putitemXml(viParams, 'NR_CTAPES', vCxConta);
            putitemXml(viParams, 'VL_LANCAMENTO', vVlValor);
            putitemXml(viParams, 'VL_SALDODOC', vVlSaldoAtualDoc);
            putitemXml(viParams, 'VL_SALDOCTA', vVlSaldoAtual);
            putitemXml(viParams, 'VL_SALDOANTDOC', vVlSaldoAntDoc);
            putitemXml(viParams, 'VL_SALDOANTCTA', vVlSaldoAnt);
            putitemXml(viParams, 'NR_CTAPESFCC', vNrCtaPesFCC);
            putitemXml(viParams, 'DT_MOVIMFCC', vDtMovimFCC);
            putitemXml(viParams, 'NR_SEQMOVFCC', vNrSeqMovFCC);
            voParams := activateCmp('FCCSVCO018', 'gravarLogMovtoCtaPes', viParams); (*,,,, *)
            if (xStatus < 0) then begin
              Result := voParams;
              return(-1); exit;
            end;
          end;
        end;
      end;

      gVlSangria := gVlSangria + item_f('VL_VALOR', tTMP_K02);

    end;
    setocc(tTMP_K02, curocc(tTMP_K02) + 1);
  end;
  if (vInErro = False) then begin
    voParams := tFCX_CAIXAC.Salvar();
    if (xStatus < 0) then begin
      Result := voParams;
      return(-1); exit;
    end;
  end;
  if (vInErro = False) then begin
    commit;
    if (xStatus < 0) then begin
      rollback;
      return(-1); exit;
    end else begin
      message/info 'Retirada efetuada com sucesso!';
    end;
  end else begin
    rollback;
    return(-1); exit;
  end;
  if (gInPdvOtimizado <> True) then begin
    askmess 'Deseja imprimir recibo?', 'Sim, Não';
    if (xStatus = 1) then begin
      voParams := imprimeReciboSangria(viParams); (* *)
      if (xStatus < 0) then begin
        Result := voParams;
        return(-1); exit;
      end;
    end;
  end else begin
    voParams := imprimeReciboSangria(viParams); (* *)
    if (xStatus < 0) then begin
      Result := voParams;
      return(-1); exit;
    end;
  end;

  clear_e(tFCX_CAIXAC);
  clear_e(tTMP_K02);

  return(0); exit;
end;

//------------------------------------------------------------
function TF_FCXFM006.validaValores(pParams : String) : String;
//------------------------------------------------------------
const
  cDS_METHOD = 'ADICIONAL=Operação: TF_FCXFM006.validaValores()';
var
  vSomaVl : Real;
begin
if (item_a('DS_MOTIVO', tFCX_CAIXAC) = '') then begin
  message/info 'Motivo da retirada deve ser preenchido.';
  return(-1); exit;
end;

vSomaVl := 0;
setocc(tTMP_K02, 1);
while (xStatus >= 0) do begin
  vSomaVl := vSomaVl + item_f('VL_VALOR', tTMP_K02);
  setocc(tTMP_K02, curocc(tTMP_K02) + 1);
end;
if (vSomaVl = 0) then begin
  message/info 'Deve ser digitado algum valor para retirada.';
  return(-2);
end;

return(0); exit;

end;

//-------------------------------------------------------------------
function TF_FCXFM006.imprimeReciboSangria(pParams : String) : String;
//-------------------------------------------------------------------
const
  cDS_METHOD = 'ADICIONAL=Operação: TF_FCXFM006.imprimeReciboSangria()';
var
  viParams, voParams, vDsConteudo, vDsCampo : String;
begin
  if (itemXml('NR_MODREC_SANGRIA', xParamEmp) = '') then begin
    Result := SetStatus(STS_AVISO, 'GEN001', 'Número do modelo de recibo de sangria não informado no parametro empresa. Parametro -> NR_MODREC_SANGRIA', '');
    return(-1); exit;
  end;

  clear_e(tGER_MODFINC);
  putitem_e(tGER_MODFINC, 'NR_MODFINC', itemXmlF('NR_MODREC_SANGRIA', xParamEmp));
  retrieve_e(tGER_MODFINC);
  if (xStatus < 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN001', 'Modelo de recibo de sangria não cadastrado.', '');
    return(-1); exit;
  end;

  viParams := '';
  putitemXml(viParams, 'NR_CTAPES_SANGRIA_SUPRIMENTO', item_f('NR_CTAPES', tFCX_CAIXAC));
  putitemXml(viParams, 'DT_SANGRIA_SUPRIMENTO', itemXml('DT_SISTEMA', PARAM_GLB));
  putitemXml(viParams, 'VL_SANGRIA_SUPRIMENTO', gVlsangria);
  putitemXml(viParams, 'CD_USU_ESCOLHIDO', gvCdUsuarioEscolhido);
  putitemXml(viParams, 'CD_USU_LOGADO', itemXmlF('CD_USUARIO', PARAM_GLB));
  putitemXml(viParams, 'CD_EMPRESA', item_f('CD_EMPRESA', tGER_EMPRESA));
  putitemXml(viParams, 'NR_REC_SANGRIA_SUPRIMENTO', itemXmlF('NR_MODREC_SANGRIA', xParamEmp));
  putitemXml(viParams, 'DS_AUX', item_a('DS_MOTIVO', tFCX_CAIXAC));

  voParams := activateCmp('GERSVCO028', 'geraReciboSangriaSuprimento', viParams); (*,,,, *)
  if (xStatus < 0) then begin
    Result := voParams;
    return(-1); exit;
  end;

  vDsConteudo := itemXml('DS_CONTEUDO', voParams);

  if (gInPdvOtimizado <> True) then begin
    vDsConteudo := '' + vDsConteudoHISTORICO + '                         VALOR';
    setocc(tTMP_K02, 1);
    while (xStatus >= 0) do begin
      if (item_f('VL_VALOR', tTMP_K02) > 0) then begin
        voParams := preencheEspaco(viParams); (* item_a('DS_HISTORICO', tTMP_K02), 24, vDsCampo *)
        if (xStatus < 0) then begin
          Result := voParams;
          return(-1); exit;
        end;
        vDsConteudo := '' + vDsConteudo' + vDsCampo + ' + ' ';

        gVl12D2 := item_f('VL_VALOR', tTMP_K02);
        vDsCampo := '' + FloatToStr(gVl) + '12D2';
        voParams := alinhaDireita(viParams); (* vDsCampo, 14, vDsCampo *)
        if (xStatus < 0) then begin
          Result := voParams;
          return(-1); exit;
        end;

        vDsConteudo := '' + vDsConteudo' + vDsCampo' + ' + ';
      end;

      setocc(tTMP_K02, curocc(tTMP_K02) + 1);
    end;
    setocc(tTMP_K02, 1);
  end;
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

//---------------------------------------------------------------------
function TF_FCXFM006.verificaSaldoDocumento(pParams : String) : String;
//---------------------------------------------------------------------
const
  cDS_METHOD = 'ADICIONAL=Operação: TF_FCXFM006.verificaSaldoDocumento()';
var
  viParams, voParams, vpiValores, vDsDocumento, vLstCtaPes, vLstCtaPesAux : String;
  vNrCtaPes : Real;
begin
  voParams := buscaCtaOperador(viParams); (* vLstCtaPes *)
  if (vLstCtaPes = '') then begin
    message/info 'Nenhuma conta encontrada para o operador!';
    return(-1); exit;
  end;

  setocc(tTMP_K02, 1);
  repeat

    if (item_f('VL_VALOR', tTMP_K02) > 0) then begin
      vLstCtaPesAux := vLstCtaPes;

      gVlsaldocaixa := 0;

      repeat
        getitem(vNrCtaPes, vLstCtaPesAux, 1);

        viParams := '';
        putitemXml(viParams, 'NR_CTAPES', vNrCtaPes);
        putitemXml(viParams, 'TP_DOCUMENTO', item_f('NR_CHAVE01', tTMP_K02));
        putitemXml(viParams, 'NR_SEQHISTRELSUB', item_f('NR_CHAVE02', tTMP_K02));
        putitemXml(viParams, 'DT_SALDO', itemXml('DT_SISTEMA', PARAM_GLB));
        voParams := activateCmp('FCCSVCO002', 'buscaSaldoCtaTp', viParams); (*,,vpiValores,,, *)
        if (xStatus < 0) then begin
          Result := voParams;
          return(-1); exit;
        end;
        gVlsaldocaixa := gVlsaldocaixa + itemXmlF('VL_SALDO', voParams);

        if (item_f('NR_CHAVE01', tTMP_K02) = 3) then begin
          viParams := '';
          putitemXml(viParams, 'NR_CTAPES', vNrCtaPes);
          putitemXml(viParams, 'TP_DOCUMENTO', 9);
          putitemXml(viParams, 'NR_SEQHISTRELSUB', 1);
          putitemXml(viParams, 'DT_SALDO', itemXml('DT_SISTEMA', PARAM_GLB));
          voParams := activateCmp('FCCSVCO002', 'buscaSaldoCtaTp', viParams); (*,,vpiValores,,, *)
          if (xStatus < 0) then begin
            Result := voParams;
            return(-1); exit;
          end;

          gVlsaldocaixa := gVlsaldocaixa + itemXmlF('VL_SALDO', voParams);
        end;

        delitem(vLstCtaPesAux, 1);
      until (vLstCtaPesAux = '');

      if (item_f('VL_VALOR', tTMP_K02) > gVlsaldocaixa) then begin
        if (item_f('NR_CHAVE01', tTMP_K02) = 2)  or (item_f('NR_CHAVE01', tTMP_K02) = 3) then begin
          if (item_f('NR_CHAVE01', tTMP_K02) = 2) then begin
            vDsDocumento := 'Cheque';
          end else begin
            vDsDocumento := 'Dinheiro';
          end;
          Result := SetStatus(STS_AVISO, 'GEN001', 'Saldo em ' + vDsDocumento + ' Rg ' + Vlsaldocaixag + ' insuficiente para retirada de R ' + vl_valor + '.TMP_K02', '');
          gprompt := item_f('VL_VALOR', tTMP_K02);
          return(-1); exit;
        end else begin
          if (item_f('NR_CHAVE01', tTMP_K02) = 4) then begin
            vDsDocumento := 'Cartão crédito';
          end else begin

            vDsDocumento := 'Cartão débito';
          end;
          Result := SetStatus(STS_AVISO, 'GEN001', 'Saldo de ' + vDsDocumento + ' Rg ' + Vlsaldocaixag + ' insuficiente para retirada de R ' + vl_valor + '.TMP_K02', '');
          gprompt := item_f('VL_VALOR', tTMP_K02);
          return(-1); exit;
        end;
      end;
    end;

    setocc(tTMP_K02, curocc(tTMP_K02) + 1);
  until(xStatus < 0);
  xStatus := 0;
  setocc(tTMP_K02, 1);

  return(0); exit;
end;

end.
