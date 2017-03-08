unit fECFFP002;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, fFormTouch, ExtCtrls, cPanel, cDatasetUnf, fDialogTouch;

type
  TF_ECFFP002 = class(T_FormTouch)
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
  private
    tFCR_FATURAI,
    tFGR_LIQITEMCR,
    tFIS_ECF,
    tFIS_ECFADIC,
    tGER_OPERACAO,
    tSIS_ECF,
    tTMP_K,
    tTMP_K02DS,
    tTRA_TRANSACAO : TcDatasetUnf;
    function getParam(pParams : String = '') : String;
    function setEntidade(pParams : String = '') : String;
    function preEDIT(pParams : String = '') : String;
    function posEDIT(pParams : String = '') : String;
    function posCLEAR(pParams : String = '') : String;
    function preEDIT(pParams : String = '') : String;
    function INIT(pParams : String = '') : String;
    function CLEANUP(pParams : String = '') : String;
    function chamaFuncao(pParams : String = '') : String;
    function valorPadrao(pParams : String = '') : String;
    function obtemNumeroSerie(pParams : String = '') : String;
    function verificaECFTermica(pParams : String = '') : String;
    function meiosDePagamento(pParams : String = '') : String;
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
  gdata,
  gDataFIM,
  gDataINI,
  gInFlag,
  gInGravaReducaoZ,
  gInPdvOtimizado,
  gnomeArquivo,
  gTpLeituraMem,
  gufOrigem,
  gvData,
  gvDsConteudo,
  gvDsPath,
  gvDtFIM,
  gvDtIni,
  gvInTermica,
  gvNrSerie : String;

procedure TF_ECFFP002.FormCreate(Sender: TObject);
begin
  inherited; //
  setEntidade();
end;

procedure TF_ECFFP002.FormShow(Sender: TObject);
var voParams : String;
begin
  inherited; //

  getParam(vpiParams);

  voParams := preEDIT(vpiParams);
  if (xStatus < 0) then begin
    MensagemTouch(tpmErro, itemXml('message', voParams) + #13 + itemXml('adic', voParams));
    TimerSair.Enabled := True;
    return(-1); exit;
  end;

  //recalcula();

  return(0); exit;
end;

procedure TF_ECFFP002.FormActivate(Sender: TObject);
begin
  inherited; //
end;

procedure TF_ECFFP002.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  inherited; //
end;

//---------------------------------------------------------------
function TF_ECFFP002.getParam(pParams : String = '') : String;
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
function TF_ECFFP002.setEntidade(pParams : String = '') : String;
//---------------------------------------------------------------
begin
  tFCR_FATURAI := TcDatasetUnf.GetEntidade(Self, 'FCR_FATURAI');
  tFGR_LIQITEMCR := TcDatasetUnf.GetEntidade(Self, 'FGR_LIQITEMCR');
  tFIS_ECF := TcDatasetUnf.GetEntidade(Self, 'FIS_ECF');
  tFIS_ECFADIC := TcDatasetUnf.GetEntidade(Self, 'FIS_ECFADIC');
  tGER_OPERACAO := TcDatasetUnf.GetEntidade(Self, 'GER_OPERACAO');
  tSIS_ECF := TcDatasetUnf.GetEntidade(Self, 'SIS_ECF');
  tTMP_K := TcDatasetUnf.GetEntidade(Self, 'TMP_K');
  tTMP_K02DS := TcDatasetUnf.GetEntidade(Self, 'TMP_K02DS');
  tTRA_TRANSACAO := TcDatasetUnf.GetEntidade(Self, 'TRA_TRANSACAO');
end;

//---------------------------------------------------------------
function TF_ECFFP002.preEDIT(pParams : String) : String;
//---------------------------------------------------------------
const
  cDS_METHOD = 'ADICIONAL=Operação: TF_ECFFP002.preEDIT()';
begin
  return(0); exit;
end;

//---------------------------------------------------------------
function TF_ECFFP002.posEDIT(pParams : String) : String;
//---------------------------------------------------------------
const
  cDS_METHOD = 'ADICIONAL=Operação: TF_ECFFP002.posEDIT()';
begin
  return(0); exit;
end;

//-------------------------------------------------------
function TF_ECFFP002.posCLEAR(pParams : String) : String;
//-------------------------------------------------------
const
  cDS_METHOD = 'ADICIONAL=Operação: TF_ECFFP002.posCLEAR()';
begin
voParams := valorPadrao(viParams); (* *)
if (xStatus < 0) then begin
  Result := voParams;
  return(-1); exit;
end;
return(0); exit;
end;

//------------------------------------------------------
function TF_ECFFP002.preEDIT(pParams : String) : String;
//------------------------------------------------------
const
  cDS_METHOD = 'ADICIONAL=Operação: TF_ECFFP002.preEDIT()';
begin
gInFlag := itemXmlB('IN_FLAG', viParams);

gTpLeituraMem := itemXmlF('TP_LEITURA', viParams);

voParams := obtemNumeroSerie(viParams); (* *)
if (xStatus < 0) then begin
  Result := voParams;
  return(-1); exit;
end;

voParams := valorPadrao(viParams); (* *)
if (xStatus < 0) then begin
  Result := voParams;
  return(-1); exit;
end;

putitem_e(tSIS_ECF, 'DS_DATA', Now);
putitem_e(tSIS_ECF, 'DS_DATAFIM', Now);

return(0); exit;
end;

//---------------------------------------------------
function TF_ECFFP002.INIT(pParams : String) : String;
//---------------------------------------------------
const
  cDS_METHOD = 'ADICIONAL=Operação: TF_ECFFP002.INIT()';
begin
  xParamEmp := '';
  putitem(xParamEmp,  'IN_PDV_OTIMIZADO');
  putitem(xParamEmp,  'IN_GRAVA_REDUCAOZ');
  putitem(xParamEmp,  'UF_ORIGEM');
  xParamEmp := T_ADMSVCO001.GetParamEmpresa(piCdEmpresa, xParamEmp); (*itemXml('CD_EMPRESA', *)
  gInPdvOtimizado := itemXmlB('IN_PDV_OTIMIZADO', xParamEmp);
  gInGravaReducaoZ := itemXmlB('IN_GRAVA_REDUCAOZ', xParamEmp);
  gufOrigem := itemXml('UF_ORIGEM', xParamEmp);

  _Caption := '' + ECFFP + '002 - Entrada de Valor ECF (Emissor de Cupom Fiscal)';
end;

//------------------------------------------------------
function TF_ECFFP002.CLEANUP(pParams : String) : String;
//------------------------------------------------------
const
  cDS_METHOD = 'ADICIONAL=Operação: TF_ECFFP002.CLEANUP()';
begin
end;

//----------------------------------------------------------
function TF_ECFFP002.chamaFuncao(pParams : String) : String;
//----------------------------------------------------------
const
  cDS_METHOD = 'ADICIONAL=Operação: TF_ECFFP002.chamaFuncao()';
var
  viParams, voParams, vDtini, vDtFim, vNrCupom, vDsMsg, vDsAux, vDsPath, vTpSituacao : String;
  vDadoIni, vDadoFim : Real;
  vDataIni, vDataFim : TDate;
  vTermica, vFlag, vInMonitorDLL : Boolean;
begin
  voParams := obtemNumeroSerie(viParams); (* *)
  if (xStatus < 0) then begin
    Result := voParams;
    return(-1); exit;
  end;

  voParams := verificaECFTermica(viParams); (* *)
  if (xStatus < 0) then begin
    Result := voParams;
    return(-1); exit;
  end;

  vInMonitorDLL := False;
  clear_e(tFIS_ECF);
  putitem_o(tFIS_ECF, 'CD_EMPRESA', itemXmlF('CD_EMPRESA', PARAM_GLB));
  putitem_o(tFIS_ECF, 'CD_SERIEFAB', gvNrSerie);
  retrieve_e(tFIS_ECF);
  if (xStatus >= 0) then begin
    clear_e(tFIS_ECFADIC);
    putitem_o(tFIS_ECFADIC, 'CD_EMPRESA', item_f('CD_EMPRESA', tFIS_ECF));
    putitem_o(tFIS_ECFADIC, 'NR_ECF', item_f('NR_ECF', tFIS_ECF));
    retrieve_e(tFIS_ECFADIC);
    if (xStatus >= 0) then begin
      if (item_f('TP_MONITOR', tFIS_ECFADIC) = 01) then begin
        vInMonitorDLL := True;
      end;
    end;
  end;

  viParams := '';
  if (gInFlag = 1) then begin
    if (gufOrigem = '') then begin
      Result := SetStatus(STS_ERROR, 'GEN0001', 'Parâmetro empresa UF_ORIGEM não configurado!', cDS_METHOD);
      return(-1); exit;
    end;
    if (vInMonitorDLL = True)  or ((gvNrSerie[1:2] <> 'EP')  and (gvNrSerie[1:2] <> 'ZP')  and (gvNrSerie[1:2] <> 'DR')  and (gvNrSerie[1:2] <> 'IW')) then begin
      voParams := activateCmp('ECFSVCO001', 'ReducaoZ', viParams); (*,,, *)
      if (xStatus < 0) then begin
        Result := voParams;
        return(-1); exit;
      end;
        putitemXml(viParams, 'TITULO', 'Erro de comunicação com a ECF');
        putitemXml(viParams, 'MENSAGEM', itemXml('DESCRICAO', xCtxErro));
        voParams := activateCmp('GERFP008', 'EXEC', viParams); (*,,, *)
        if (xStatus < 0) then begin
          Result := voParams;
          return(-1); exit;
        end;
        return(-1); exit;
      end else if (xStatus < 0) then begin
        Result := voParams;
        return(-1); exit;
      end;
    end;
    if (gInGravaReducaoZ = True) then begin
      if (itemXml('CD_SERIEECF', PARAM_GLB) = '') then begin
        viParams := '';

        putitemXml(viParams, 'NM_FUNCAO', <ECF_NUMERO_SERIE>);
        voParams := activateCmp('ECFSVCO001', 'leInformacaoImpressora', viParams); (*,,, *)
        if (xStatus < 0) then begin
          Result := voParams;
          return(-1); exit;
        end;
          putitemXml(viParams, 'TITULO', 'Erro de comunicação com a ECF');
          putitemXml(viParams, 'MENSAGEM', itemXml('DESCRICAO', xCtxErro));
          voParams := activateCmp('GERFP008', 'EXEC', viParams); (*,,, *)
          if (xStatus < 0) then begin
            Result := voParams;
            return(-1); exit;
          end;
          return(-1); exit;
        end else if (xStatus < 0) then begin
          Result := voParams;
          return(-1); exit;
        end;
        gvNrSerie := itemXmlF('NR_SERIE', voParams);
      end else begin
        gvNrSerie := itemXmlF('CD_SERIEECF', PARAM_GLB);
      end;

      viParams := '';

      putitemXml(viParams, 'NR_SERIE', gvNrSerie);
      voParams := activateCmp('ECFSVCO001', 'registroTipo60', viParams); (*,,, *)
      if (xStatus < 0) then begin
        Result := voParams;
        return(-1); exit;
      end;
        putitemXml(viParams, 'TITULO', 'Erro de comunicação com a ECF');
        putitemXml(viParams, 'MENSAGEM', itemXml('DESCRICAO', xCtxErro));
        voParams := activateCmp('GERFP008', 'EXEC', viParams); (*,,, *)
        if (xStatus < 0) then begin
          Result := voParams;
          return(-1); exit;
        end;
        return(-1); exit;
      end else if (xStatus < 0) then begin
        Result := voParams;
        return(-1); exit;
      end;

      commit;
      if (xStatus < 0) then begin
        rollback;
        return(-1); exit;
      end else begin
        voParams := SetHint(viParams); (* 'ID=APLINFO002' *)
      end;
    end;
    if ((gvNrSerie[1:2] = 'BE')  and (gufOrigem='SP')  and (gvInTermica=True)) then begin
      gdata := Now;
      putitemXml(viParams, 'DS_DATA', gdata);
      putitemXml(viParams, 'DS_DATAFIM', gdata);
      voParams := activateCmp('ECFSVCO001', 'geraRegistrosCAT52MFD', viParams); (*,,, *)
      if (xStatus < 0) then begin
        Result := voParams;
        return(-1); exit;
      end;
        putitemXml(viParams, 'TITULO', 'Erro de comunicação com a ECF');
        putitemXml(viParams, 'MENSAGEM', itemXml('DESCRICAO', xCtxErro));
        voParams := activateCmp('GERFP008', 'EXEC', viParams); (*,,, *)
        if (xStatus < 0) then begin
          Result := voParams;
          return(-1); exit;
        end;
        return(-1); exit;
      end else if (xStatus < 0) then begin
        Result := voParams;
        return(-1); exit;
      end;
    end;
    if (vInMonitorDLL = False) then begin
      if (gvNrSerie[1:2] = 'EP')  or (gvNrSerie[1:2] = 'ZP')  or (gvNrSerie[1:2] = 'DR')  or (gvNrSerie[1:2] = 'IW') then begin
        voParams := activateCmp('ECFSVCO001', 'ReducaoZ', viParams); (*,,, *)
        if (xStatus < 0) then begin
          Result := voParams;
          return(-1); exit;
        end;
          putitemXml(viParams, 'TITULO', 'Erro de comunicação com a ECF');
          putitemXml(viParams, 'MENSAGEM', itemXml('DESCRICAO', xCtxErro));
          voParams := activateCmp('GERFP008', 'EXEC', viParams); (*,,, *)
          if (xStatus < 0) then begin
            Result := voParams;
            return(-1); exit;
          end;
          return(-1); exit;
        end else if (xStatus < 0) then begin
          Result := voParams;
          return(-1); exit;
        end;
      end;
    end;
    if (gvNrSerie[1:2] = 'EP')  and (gufOrigem='SP')  and (gvInTermica=True) then begin
      askmess 'Deseja gerar arquivo digital da Nota Fiscal Paulista?', 'Sim, Não';
      if (xStatus = 1) then begin
        putitemXml(viParams, 'DS_DATA', Now);
        voParams := activateCmp('ECFSVCO001', 'geraRegistrosCAT52MFD', viParams); (*,,, *)
        if (xStatus < 0) then begin
          Result := voParams;
          return(-1); exit;
        end;
          putitemXml(viParams, 'TITULO', 'Erro de comunicação com a ECF');
          putitemXml(viParams, 'MENSAGEM', itemXml('DESCRICAO', xCtxErro));
          voParams := activateCmp('GERFP008', 'EXEC', viParams); (*,,, *)
          if (xStatus < 0) then begin
            Result := voParams;
            return(-1); exit;
          end;
          return(-1); exit;
        end else if (xStatus < 0) then begin
          Result := voParams;
          return(-1); exit;
        end;
        Result := SetStatus(<STS_INFO>, '', 'Arquivo digital Nota Fiscal Paulista, gerado com sucesso.', cDS_METHOD);
      end;
    end;
  end else if (gInFlag = 2) then begin
    if (item_a('DS_DADOINI', tSIS_ECF) = '' ) or (item_a('DS_DADOFIM', tSIS_ECF) = '') then begin
      if (gTpLeituraMem = 1) then begin
        gDataINI := Date;
        gDataFIM := Date;
        putitem_o(tSIS_ECF, 'DS_DADOINI', '' + gDataINI' + ');
        putitem_o(tSIS_ECF, 'DS_DADOFIM', '' + gDataFIM' + ');
      end else begin
        putitem_o(tSIS_ECF, 'DS_DADOINI', 1);
        putitem_o(tSIS_ECF, 'DS_DADOFIM', 1);
      end;
    end;

    gnomeArquivo := '' + item_a('DS_DADOINI', tSIS_ECF) + '' + item_a('DS_DADOFIM', tSIS_ECF) + '';

    if (gTpLeituraMem = 1)  or (gTpLeituraMem = 3) then begin
      gData := item_a('DS_DADOINI', tSIS_ECF);
      putitem_o(tSIS_ECF, 'DS_DADOINI', '' + gData' + ');
      gData := item_a('DS_DADOFIM', tSIS_ECF);
      putitem_o(tSIS_ECF, 'DS_DADOFIM', '' + gData' + ');
      putitemXml(viParams, 'DT_INICIO', item_a('DS_DADOINI', tSIS_ECF));
      putitemXml(viParams, 'DT_FIM', item_a('DS_DADOFIM', tSIS_ECF));
      if (gTpLeituraMem = 1) then begin
        voParams := activateCmp('ECFSVCO001', 'LeituraMemoriaFiscalData', viParams); (*,,, *)
      end else begin
        putitemXml(viParams 'TP_TIPO', 'c');
        voParams := activateCmp('ECFSVCO001', 'leMemoriaFiscalSerialDataMFD', viParams); (*,,, *)
        gvDsPath := itemXml('DS_PATH', voParams);
        voParams := activateCmp('KERNEL32', 'SLEEP', viParams); (*2000 *)
        voParams := activateCmp('vbfileman', 'arqexiste', viParams); (*vFlag,'' + gvDsPathRETORNO + '.TXT' *)
        if (vFlag = True) then begin
          viParams := '';

          putitemXml(viParams 'DS_PATH', '' + gvDsPathRETORNO + '.TXT');
          putitemXml(viParams 'DS_NOMEARQ', '' + gvDsPath' + gnomeArquivo + ' + '.TXT');
          voParams := activateCmp('ECFSVCO002', 'geraEAD', viParams); (*,,, *)
          if (xStatus < 0) then begin
            Result := voParams;
            return(-1); exit;
          end;

          vDsMsg := itemXml('DS_MENSAGEM', voParams);
          if (vDsMsg <> '') then begin
            Result := SetStatus(<STS_INFO>, 'GEN0001', '' + vDsMsg', + ' cDS_METHOD);
          end;
        end;
      end;
    end else if (gTpLeituraMem = 2)  or (gTpLeituraMem = 4) then begin
      putitemXml(viParams, 'NR_REDINI', item_a('DS_DADOINI', tSIS_ECF));
      putitemXml(viParams, 'NR_REDFIM', item_a('DS_DADOFIM', tSIS_ECF));
      if (gTpLeituraMem = 2) then begin
        voParams := activateCmp('ECFSVCO001', 'LeituraMemoriaFiscalReducao', viParams); (*,,, *)
      end else begin
        putitemXml(viParams 'TP_TIPO', 'c');
        voParams := activateCmp('ECFSVCO001', 'leMemoriaFiscalSerialReducaoMFD', viParams); (*,,, *)
        gvDsPath := itemXml('DS_PATH', voParams);
        voParams := activateCmp('KERNEL32', 'SLEEP', viParams); (*2000 *)
        voParams := activateCmp('vbfileman', 'arqexiste', viParams); (*vFlag,'' + gvDsPathRETORNO + '.TXT' *)
        if (vFlag = True) then begin
          viParams := '';

          putitemXml(viParams 'DS_PATH', '' + gvDsPathRETORNO + '.TXT');
          putitemXml(viParams 'DS_NOMEARQ', '' + gvDsPath' + gnomeArquivo + ' + '.TXT');
          voParams := activateCmp('ECFSVCO002', 'geraEAD', viParams); (*,,, *)
          if (xStatus < 0) then begin
            Result := voParams;
            return(-1); exit;
          end;

          vDsMsg := itemXml('DS_MENSAGEM', voParams);
          if (vDsMsg <> '') then begin
            Result := SetStatus(<STS_INFO>, 'GEN0001', '' + vDsMsg', + ' cDS_METHOD);
          end;
        end;
      end;
    end;
    if (xStatus < 0) then begin
      Result := voParams;
      return(-1); exit;
    end;
      putitemXml(viParams, 'TITULO', 'Erro de comunicação com a ECF');
      putitemXml(viParams, 'MENSAGEM', itemXml('DESCRICAO', xCtxErro));
      voParams := activateCmp('GERFP008', 'EXEC', viParams); (*,,, *)
      if (xStatus < 0) then begin
        Result := voParams;
        return(-1); exit;
      end;
      return(-1); exit;
    end else if (xStatus < 0) then begin
      Result := voParams;
      return(-1); exit;
    end;
  end else if (gInFlag = 3) then begin
    if (item_f('VL_LANCAMENTO', tSIS_ECF) <= 0) then begin
      message/error 'Valor não informado!';
      return(-1); exit;
    end;
    putitemXml(viParams, 'VL_SUPRIMENTO', item_f('VL_LANCAMENTO', tSIS_ECF));
    voParams := activateCmp('ECFSVCO001', 'Suprimento', viParams); (*,,, *)
    if (xStatus < 0) then begin
      Result := voParams;
      return(-1); exit;
    end;
      putitemXml(viParams, 'TITULO', 'Erro de comunicação com a ECF');
      putitemXml(viParams, 'MENSAGEM', itemXml('DESCRICAO', xCtxErro));
      voParams := activateCmp('GERFP008', 'EXEC', viParams); (*,,, *)
      if (xStatus < 0) then begin
        Result := voParams;
        return(-1); exit;
      end;
      return(-1); exit;
    end else if (xStatus < 0) then begin
      Result := voParams;
      return(-1); exit;
    end;
  end else if (gInFlag = 4) then begin
    if (item_f('VL_LANCAMENTO', tSIS_ECF) <= 0) then begin
      message/error 'Valor não informado!';
      return(-1); exit;
    end;
    putitemXml(viParams, 'VL_ABERTURADIA', item_f('VL_LANCAMENTO', tSIS_ECF));
    voParams := activateCmp('ECFSVCO001', 'AberturadoDia', viParams); (*,,, *)
    if (xStatus < 0) then begin
      Result := voParams;
      return(-1); exit;
    end;
      putitemXml(viParams, 'TITULO', 'Erro de comunicação com a ECF');
      putitemXml(viParams, 'MENSAGEM', itemXml('DESCRICAO', xCtxErro));
      voParams := activateCmp('GERFP008', 'EXEC', viParams); (*,,, *)
      if (xStatus < 0) then begin
        Result := voParams;
        return(-1); exit;
      end;
      return(-1); exit;
    end else if (xStatus < 0) then begin
      Result := voParams;
      return(-1); exit;
    end;
  end else if (gInFlag = 5) then begin
    if (item_f('VL_LANCAMENTO', tSIS_ECF) <= 0) then begin
      message/error 'Valor não informado!';
      return(-1); exit;
    end;
    putitemXml(viParams, 'VL_SANGRIA', item_f('VL_LANCAMENTO', tSIS_ECF));
    voParams := activateCmp('ECFSVCO001', 'Sangria', viParams); (*,,, *)
    if (xStatus < 0) then begin
      Result := voParams;
      return(-1); exit;
    end;
      putitemXml(viParams, 'TITULO', 'Erro de comunicação com a ECF');
      putitemXml(viParams, 'MENSAGEM', itemXml('DESCRICAO', xCtxErro));
      voParams := activateCmp('GERFP008', 'EXEC', viParams); (*,,, *)
      if (xStatus < 0) then begin
        Result := voParams;
        return(-1); exit;
      end;
      return(-1); exit;
    end else if (xStatus < 0) then begin
      Result := voParams;
      return(-1); exit;
    end;
  end else if (gInFlag = 6) then begin
    voParams := activateCmp('ECFSVCO001', 'progHoraVerao', viParams); (*,,, *)
    if (xStatus < 0) then begin
      Result := voParams;
      return(-1); exit;
    end;
      putitemXml(viParams, 'TITULO', 'Erro de comunicação com a ECF');
      putitemXml(viParams, 'MENSAGEM', itemXml('DESCRICAO', xCtxErro));
      voParams := activateCmp('GERFP008', 'EXEC', viParams); (*,,, *)
      if (xStatus < 0) then begin
        Result := voParams;
        return(-1); exit;
      end;
      return(-1); exit;
    end else if (xStatus < 0) then begin
      Result := voParams;
      return(-1); exit;
    end;
  end else if (gInFlag = 7) then begin
    if (gvNrSerie[1:2] = 'ZP') then begin
      vDadoIni := item_a('DS_DADOINI', tSIS_ECF);
      vDadoFim := item_a('DS_DADOFIM', tSIS_ECF);

      while (vDadoFim >= vDadoIni) do begin
        putitemXml(viParams, 'DS_DATA', vDataIni);
        voParams := activateCmp('ECFSVCO001', 'geraRegistrosCAT52MFD', viParams); (*,,, *)
        if (xStatus < 0) then begin
          Result := voParams;
          return(-1); exit;
        end;
          putitemXml(viParams, 'TITULO', 'Erro de comunicação com a ECF');
          putitemXml(viParams, 'MENSAGEM', itemXml('DESCRICAO', xCtxErro));
          voParams := activateCmp('GERFP008', 'EXEC', viParams); (*,,, *)
          if (xStatus < 0) then begin
            Result := voParams;
            return(-1); exit;
          end;
          return(-1); exit;
        end else if (xStatus < 0) then begin
          Result := voParams;
          return(-1); exit;
        end;
        vDadoIni := vDadoIni + 1;
      end;
    end else begin

      vDataIni := item_a('DS_DATA', tSIS_ECF);
      vDataFim := item_a('DS_DATAFIM', tSIS_ECF);

        putitemXml(viParams, 'DS_DATA', vDataIni);
        putitemXml(viParams, 'DS_DATAFIM', vDataFim);
        voParams := activateCmp('ECFSVCO001', 'geraRegistrosCAT52MFD', viParams); (*,,, *)
        if (xStatus < 0) then begin
          Result := voParams;
          return(-1); exit;
        end;
          putitemXml(viParams, 'TITULO', 'Erro de comunicação com a ECF');
          putitemXml(viParams, 'MENSAGEM', itemXml('DESCRICAO', xCtxErro));
          voParams := activateCmp('GERFP008', 'EXEC', viParams); (*,,, *)
          if (xStatus < 0) then begin
            Result := voParams;
            return(-1); exit;
          end;
          return(-1); exit;
        end else if (xStatus < 0) then begin
          Result := voParams;
          return(-1); exit;
        end;
    end;
  end else if (gInFlag = 8) then begin
    vDataIni := item_a('DS_DATA', tSIS_ECF);
    vDataFim := item_a('DS_DATAFIM', tSIS_ECF);
    vTpSituacao := itemXmlF('TP_SITUACAO', viParams);

    if (vTpSituacao = 1) then begin
      putitemXml(viParams, 'DS_DADOINI', vDataIni);
      putitemXml(viParams, 'DS_DADOFIM', vDataFim);
      putitemXml(viParams, 'NR_TPDOWNLOAD', '1');
      voParams := activateCmp('ECFSVCO011', 'efetuaLeituraArqMFD', viParams); (*,,,, *)
      vDsPath := itemXml('DS_PATH', voParams);

      commit;
      if (xStatus < 0) then begin
        rollback;
        return(-1); exit;
      end else begin
        voParams := SetHint(viParams); (* 'ID=APLINFO002' *)
      end;
    end;
    if (vTpSituacao = 2) then begin
      while (vDataFim  >= vDataIni) do begin
        putitemXml(viParams, 'DT_EMISSAO', vDataIni);
        putitemXml(viParams, 'CD_ECF', 1);
        putitemXml(viParams, 'CD_EMPRESA', itemXmlF('CD_EMPRESA', PARAM_GLB));
        putitemXml(viParams, 'DS_PATH', vDsPath);
        voParams := activateCmp('FISSVCO047', 'movimentoPorECF', viParams); (*,,,, *)
        if (xStatus < 0) then begin
          Result := voParams;
          return(-1); exit;
        end;
        vDataIni := vDataIni + 1;
      end;
    end;
  end else if (gInFlag = 9) then begin
    if (item_a('DS_DADOINI', tSIS_ECF) = '' ) or (item_a('DS_DADOFIM', tSIS_ECF) = '') then begin
      if (gTpLeituraMem = 1) then begin
        gDataINI := Date;
        gDataFIM := Date;
        putitem_o(tSIS_ECF, 'DS_DADOINI', '' + gDataINI' + ');
        putitem_o(tSIS_ECF, 'DS_DADOFIM', '' + gDataFIM' + ');
      end else begin
        putitem_o(tSIS_ECF, 'DS_DADOINI', 1);
        putitem_o(tSIS_ECF, 'DS_DADOFIM', 1);
      end;
    end;
    if (gTpLeituraMem = 1)  or (gTpLeituraMem = 3) then begin
      gData := item_a('DS_DADOINI', tSIS_ECF);
      putitem_o(tSIS_ECF, 'DS_DADOINI', '' + gData' + ');
      gData := item_a('DS_DADOFIM', tSIS_ECF);
      putitem_o(tSIS_ECF, 'DS_DADOFIM', '' + gData' + ');
      putitemXml(viParams, 'DT_INICIO', item_a('DS_DADOINI', tSIS_ECF));
      putitemXml(viParams, 'DT_FIM', item_a('DS_DADOFIM', tSIS_ECF));
      putitemXml(viParams, 'TP_TIPO', 's');

      gnomeArquivo := '' + item_a('DS_DADOINI', tSIS_ECF) + '' + item_a('DS_DADOFIM', tSIS_ECF) + '';

      if (gTpLeituraMem = 1) then begin
        voParams := activateCmp('ECFSVCO001', 'LeituraMemoriaFiscalDataMFD', viParams); (*,,, *)
      end else begin
        voParams := activateCmp('ECFSVCO001', 'leMemoriaFiscalSerialDataMFD', viParams); (*,,, *)

        gvDsPath := itemXml('DS_PATH', voParams);
        voParams := activateCmp('KERNEL32', 'SLEEP', viParams); (*2000 *)
        voParams := activateCmp('vbfileman', 'arqexiste', viParams); (*vFlag,'' + gvDsPathRETORNO + '.TXT' *)
        if (vFlag = True) then begin
          gvDsConteudo := '';
          viParams := '';

          putitemXml(viParams 'DS_PATH', '' + gvDsPathRETORNO + '.TXT');
          putitemXml(viParams 'DS_NOMEARQ', '' + gvDsPath' + gnomeArquivo + ' + '.TXT');
          voParams := activateCmp('ECFSVCO002', 'geraEAD', viParams); (*,,, *)
          if (xStatus < 0) then begin
            Result := voParams;
            return(-1); exit;
          end;

          vDsMsg := itemXml('DS_MENSAGEM', voParams);
          if (vDsMsg <> '') then begin
            Result := SetStatus(<STS_INFO>, 'GEN0001', '' + vDsMsg', + ' cDS_METHOD);
          end;
        end;
      end;
      end else if (gTpLeituraMem = 2)  or (gTpLeituraMem = 4) then begin
        putitemXml(viParams, 'NR_REDINI', item_a('DS_DADOINI', tSIS_ECF));
        putitemXml(viParams, 'NR_REDFIM', item_a('DS_DADOFIM', tSIS_ECF));
        putitemXml(viParams, 'TP_TIPO', 's');
        gnomeArquivo := '' + item_a('DS_DADOINI', tSIS_ECF) + '' + item_a('DS_DADOFIM', tSIS_ECF) + '';
      if (gTpLeituraMem = 2) then begin
        voParams := activateCmp('ECFSVCO001', 'LeituraMemoriaFiscalReducaoMFD', viParams); (*,,, *)
      end else begin
        voParams := activateCmp('ECFSVCO001', 'leMemoriaFiscalSerialReducaoMFD', viParams); (*,,, *)

        gvDsPath := itemXml('DS_PATH', voParams);
        voParams := activateCmp('KERNEL32', 'SLEEP', viParams); (*2000 *)
        voParams := activateCmp('vbfileman', 'arqexiste', viParams); (*vFlag,'' + gvDsPathRETORNO + '.TXT' *)
        if (vFlag = True) then begin
          viParams := '';

          putitemXml(viParams 'DS_PATH', '' + gvDsPathRETORNO + '.TXT');
          putitemXml(viParams 'DS_NOMEARQ', '' + gvDsPath' + gnomeArquivo + ' + '.TXT');
          voParams := activateCmp('ECFSVCO002', 'geraEAD', viParams); (*,,, *)
          if (xStatus < 0) then begin
            Result := voParams;
            return(-1); exit;
          end;

          vDsMsg := itemXml('DS_MENSAGEM', voParams);
          if (vDsMsg <> '') then begin
            Result := SetStatus(<STS_INFO>, 'GEN0001', '' + vDsMsg', + ' cDS_METHOD);
          end;
        end;
      end;
    end;
    if (xStatus < 0) then begin
      Result := voParams;
      return(-1); exit;
    end;
      putitemXml(viParams, 'TITULO', 'Erro de comunicação com a ECF');
      putitemXml(viParams, 'MENSAGEM', itemXml('DESCRICAO', xCtxErro));
      voParams := activateCmp('GERFP008', 'EXEC', viParams); (*,,, *)
      if (xStatus < 0) then begin
        Result := voParams;
        return(-1); exit;
      end;
      return(-1); exit;
    end else if (xStatus < 0) then begin
      Result := voParams;
      return(-1); exit;
    end;
  end else if (gInFlag = 10) then begin
    voParams := meiosDePagamento(viParams); (* *)
    if (xStatus < 0) then begin
      Result := voParams;
      return(-1); exit;
    end;
  end else if (gInFlag = 11) then begin
    if (item_a('DS_DADOINI', tSIS_ECF) <> '' ) or (item_a('DS_DADOFIM', tSIS_ECF) <> '') then begin
      viParams := '';

      if (gTpLeituraMem = 1) then begin
        gvDtIni := item_a('DS_DADOINI', tSIS_ECF);
        gvDtFIM := item_a('DS_DADOFIM', tSIS_ECF);
        putitem_o(tSIS_ECF, 'DS_DADOINI', '' + gvDtINI' + ');
        putitem_o(tSIS_ECF, 'DS_DADOFIM', '' + gvDtFIM' + ');
        putitemXml(viParams, 'TP_DOWNLOAD', '1');
        putitemXml(viParams, 'DS_DADOINI', '' + gvDtINI') + ';
        putitemXml(viParams, 'DS_DADOFIM', '' + gvDtFIM') + ';
      end else begin
        putitemXml(viParams, 'DS_DADOINI', item_a('DS_DADOINI', tSIS_ECF));
        putitemXml(viParams, 'DS_DADOFIM', item_a('DS_DADOFIM', tSIS_ECF));
        putitemXml(viParams, 'TP_DOWNLOAD', '2');
      end;

      gnomeArquivo := 'Cotep1704' + item_a('DS_DADOINI', tSIS_ECF) + '' + item_a('DS_DADOFIM', tSIS_ECF) + '';

      message/hint 'Efetuando download da MFD...';

      putitemXml(viParams, 'DS_ARQUIVO', 'DOWNLOAD.MFD');
      putitemXml(viParams, 'TP_FORMATO', '0');
      putitemXml(viParams, 'NR_USUARIO', '1');
      voParams := activateCmp('ECFSVCO001', 'downloadMFD', viParams); (*,,, *)
      if (xStatus < 0) then begin
        Result := voParams;
        return(-1); exit;
      end;
        putitemXml(viParams, 'TITULO', 'Erro de comunicação com a ECF');
        putitemXml(viParams, 'MENSAGEM', itemXml('DESCRICAO', xCtxErro));
        voParams := activateCmp('GERFP008', 'EXEC', viParams); (*,,, *)
        if (xStatus < 0) then begin
          Result := voParams;
          return(-1); exit;
        end;
        return(-1); exit;
      end else if (xStatus < 0) then begin
        Result := voParams;
        return(-1); exit;
      end;

      gvDsPath := itemXml('DS_PATH', voParams);

      message/hint 'Download da MFD concluído...';

      if (gTpLeituraMem <> 1) then begin
        viParams := '';

        putitemXml(viParams, 'DS_ARQUIVO', '' + gvDsPathDOWNLOAD + '.TXT');
        voParams := activateCmp('ECFSVCO011', 'extrairCOO', viParams); (*,,,, *)
        if (xStatus < 0) then begin
          Result := voParams;
          return(-1); exit;
        end;
        gDataINI := itemXml('DS_DATAINI', voParams);
        gDataFIM := itemXml('DS_DATAFIM', voParams);
      end;

      message/hint 'Gerando arquivo AC17/04...';
      viParams := '';
      putitemXml(viParams, 'DS_ARQMFD', 'DOWNLOAD.MFD');
      putitemXml(viParams, 'DS_ARQTXT', '' + gnomeArquivo + '.TXT');
      putitemXml(viParams, 'DS_RAZAO', 'EMPRESA TESTE');
      putitemXml(viParams, 'DS_endERECO', 'R. Teste');
      putitemXml(viParams, 'DS_DADOINI', '' + gvDtIni') + ';
      putitemXml(viParams, 'DS_DADOFIM', '' + gvDtFIM') + ';

      if (gTpLeituraMem = 1) then begin
        putitemXml(viParams, 'TP_DOWNLOAD', '1');
      end else begin
        putitemXml(viParams, 'TP_DOWNLOAD', '2');
      end;
      voParams := activateCmp('ECFSVCO001', 'geraAtoCotep', viParams); (*,,, *)
      if (xStatus < 0) then begin
        Result := voParams;
        return(-1); exit;
      end;

      message/hint 'Arquivo AC17/04 concluído...';

      voParams := activateCmp('vbfileman', 'arqexiste', viParams); (*vFlag,'' + gvDsPath' + gnomeArquivo + ' + '.TXT' *)
      if (vFlag = True) then begin
        message/hint 'Efetuando assinatura digital...';

        viParams := '';

        putitemXml(viParams 'DS_PATH', '' + gvDsPath' + gnomeArquivo + ' + '.TXT');
        voParams := activateCmp('ECFSVCO011', 'geraEAD', viParams); (*,,, *)
        if (xStatus < 0) then begin
          Result := voParams;
          return(-1); exit;
        end;

        vDsMsg := itemXml('DS_MENSAGEM', voParams);
        if (vDsMsg <> '') then begin
          Result := SetStatus(<STS_INFO>, 'GEN0001', '' + vDsMsg', + ' cDS_METHOD);
        end;

        message/hint 'Assinatura digital concluída...';
      end;
    end;
  end;

  return(0); exit;
end;

//----------------------------------------------------------
function TF_ECFFP002.valorPadrao(pParams : String) : String;
//----------------------------------------------------------
const
  cDS_METHOD = 'ADICIONAL=Operação: TF_ECFFP002.valorPadrao()';
var
  vDsMensagem : String;
begin
  putitem_o(tSIS_ECF, 'DS_FRAME', itemXml('DS_FRAME', viParams));
  selectcase gInFlag;
    case 1;
      fieldsyntax 'item_f('VL_LANCAMENTO', tSIS_ECF)', 'HID';
      fieldsyntax 'item_a('DS_DADOINI', tSIS_ECF)', 'HID';
      fieldsyntax 'item_a('DS_DADOFIM', tSIS_ECF)', 'HID';
      putitem_e(tSIS_ECF, 'LB_REDZ', 'A redução Z acarretará o fechamento do dia!');
      fieldsyntax 'item_a('LB_REDZ', tSIS_ECF)', '';
      fieldsyntax 'item_a('DS_LABEL', tSIS_ECF)', 'HID';
      fieldsyntax 'item_a('DS_DATA', tSIS_ECF)', 'HID';
      fieldsyntax 'item_a('DS_LABEL1', tSIS_ECF)', 'HID';
      fieldsyntax 'item_a('DS_DATAFIM', tSIS_ECF)', 'HID';
    case 2;
      fieldsyntax 'item_f('VL_LANCAMENTO', tSIS_ECF)', 'HID';
      fieldsyntax 'item_a('DS_DADOINI', tSIS_ECF)', '';
      fieldsyntax 'item_a('DS_DADOFIM', tSIS_ECF)', '';
      fieldsyntax 'item_a('LB_REDZ', tSIS_ECF)', 'HID';
      if (gTpLeituraMem = 1)  or (gTpLeituraMem = 3) then begin
        putitem_o(tSIS_ECF, 'DS_LABEL', 'Intervalo de data');
      end else if (gTpLeituraMem = 2)  or (gTpLeituraMem = 4) then begin
        putitem_o(tSIS_ECF, 'DS_LABEL', 'Intervalo de Redução');
      end;
      fieldsyntax 'item_a('DS_DATA', tSIS_ECF)', 'HID';
      fieldsyntax 'item_a('DS_LABEL1', tSIS_ECF)', 'HID';
      fieldsyntax 'item_a('DS_DATAFIM', tSIS_ECF)', 'HID';
    case 6;
      fieldsyntax 'item_f('VL_LANCAMENTO', tSIS_ECF)', 'HID';
      fieldsyntax 'item_a('DS_DADOINI', tSIS_ECF)', 'HID';
      fieldsyntax 'item_a('DS_DADOFIM', tSIS_ECF)', 'HID';
      vDsMensagem := 'A programação do horário de verão será realizada';
      vDsMensagem := '' + vDsMensagem + ' somente após uma Redução Z';
      putitem_e(tSIS_ECF, 'LB_REDZ', vDsMensagem);
      fieldsyntax 'item_a('LB_REDZ', tSIS_ECF)', '';
      fieldsyntax 'item_a('DS_LABEL', tSIS_ECF)', 'HID';
      fieldsyntax 'item_a('DS_DATA', tSIS_ECF)', 'HID';
      fieldsyntax 'item_a('DS_LABEL1', tSIS_ECF)', 'HID';
      fieldsyntax 'item_a('DS_DATAFIM', tSIS_ECF)', 'HID';
    case 7;
      fieldsyntax 'item_f('VL_LANCAMENTO', tSIS_ECF)', 'HID';
      fieldsyntax 'item_a('LB_REDZ', tSIS_ECF)', 'HID';
      if (gvNrSerie[1:2] = 'ZP') then begin
        putitem_o(tSIS_ECF, 'DS_LABEL', 'Intervalo de redução');
        fieldsyntax 'item_a('DS_DATA', tSIS_ECF)', 'HID';
        fieldsyntax 'item_a('DS_DATAFIM', tSIS_ECF)', 'HID';
        fieldsyntax 'item_a('DS_LABEL1', tSIS_ECF)', 'HID';

      end else begin
        putitem_o(tSIS_ECF, 'DS_LABEL1', 'Data movimento');
        fieldsyntax 'item_a('DS_DADOINI', tSIS_ECF)', 'HID';
        fieldsyntax 'item_a('DS_DADOFIM', tSIS_ECF)', 'HID';
        fieldsyntax 'item_a('DS_LABEL', tSIS_ECF)', 'HID';
      end;
    case 8;
      fieldsyntax 'item_f('VL_LANCAMENTO', tSIS_ECF)', 'HID';
      fieldsyntax 'item_a('LB_REDZ', tSIS_ECF)', 'HID';
      putitem_o(tSIS_ECF, 'DS_LABEL1', 'Data movimento');
      fieldsyntax 'item_a('DS_DADOINI', tSIS_ECF)', 'HID';
      fieldsyntax 'item_a('DS_DADOFIM', tSIS_ECF)', 'HID';
      fieldsyntax 'item_a('DS_LABEL', tSIS_ECF)', 'HID';
    case 9;
      fieldsyntax 'item_f('VL_LANCAMENTO', tSIS_ECF)', 'HID';
      fieldsyntax 'item_a('DS_DADOINI', tSIS_ECF)', '';
      fieldsyntax 'item_a('DS_DADOFIM', tSIS_ECF)', '';
      fieldsyntax 'item_a('LB_REDZ', tSIS_ECF)', 'HID';
      if (gTpLeituraMem = 1)  or (gTpLeituraMem = 3) then begin
        putitem_o(tSIS_ECF, 'DS_LABEL', 'Intervalo de data');
      end else if (gTpLeituraMem = 2)  or (gTpLeituraMem = 4) then begin
        putitem_o(tSIS_ECF, 'DS_LABEL', 'Intervalo de Redução');
      end;
      fieldsyntax 'item_a('DS_DATA', tSIS_ECF)', 'HID';
      fieldsyntax 'item_a('DS_LABEL1', tSIS_ECF)', 'HID';
      fieldsyntax 'item_a('DS_DATAFIM', tSIS_ECF)', 'HID';
    case 10;
      fieldsyntax 'item_f('VL_LANCAMENTO', tSIS_ECF)', 'HID';
      fieldsyntax 'item_a('DS_DADOINI', tSIS_ECF)', 'HID';
      fieldsyntax 'item_a('DS_DADOFIM', tSIS_ECF)', 'HID';
      fieldsyntax 'item_a('LB_REDZ', tSIS_ECF)', 'HID';
      putitem_o(tSIS_ECF, 'DS_LABEL1', 'Intervalo de Meio Pagto');
      fieldsyntax 'item_a('DS_DATA', tSIS_ECF)', '';
      fieldsyntax 'item_a('DS_LABEL', tSIS_ECF)', 'HID';
      fieldsyntax 'item_a('DS_DATAFIM', tSIS_ECF)', '';
    case 11;
      fieldsyntax 'item_f('VL_LANCAMENTO', tSIS_ECF)', 'HID';
      fieldsyntax 'item_a('DS_DADOINI', tSIS_ECF)', '';
      fieldsyntax 'item_a('DS_DADOFIM', tSIS_ECF)', '';
      fieldsyntax 'item_a('LB_REDZ', tSIS_ECF)', 'HID';
      if (gTpLeituraMem = 1)  or (gTpLeituraMem = 3) then begin
        putitem_o(tSIS_ECF, 'DS_LABEL', 'Intervalo de data');
      end else if (gTpLeituraMem = 2)  or (gTpLeituraMem = 4) then begin
        putitem_o(tSIS_ECF, 'DS_LABEL', 'Intervalo de COO');
      end;
      fieldsyntax 'item_a('DS_DATA', tSIS_ECF)', 'HID';
      fieldsyntax 'item_a('DS_LABEL1', tSIS_ECF)', 'HID';
      fieldsyntax 'item_a('DS_DATAFIM', tSIS_ECF)', 'HID';
    end else begincase
      fieldsyntax 'item_f('VL_LANCAMENTO', tSIS_ECF)', '';
      fieldsyntax 'item_a('DS_DADOINI', tSIS_ECF)', 'HID';
      fieldsyntax 'item_a('DS_DADOFIM', tSIS_ECF)', 'HID';
      fieldsyntax 'item_a('DS_DATA', tSIS_ECF)', 'HID';
      fieldsyntax 'item_a('LB_REDZ', tSIS_ECF)', 'HID';
      fieldsyntax 'item_a('DS_LABEL', tSIS_ECF)', 'HID';
      fieldsyntax 'item_a('DS_LABEL1', tSIS_ECF)', 'HID';
      fieldsyntax 'item_a('DS_DATAFIM', tSIS_ECF)', 'HID';
  endselectcase;
  return(0); exit;
end;

//---------------------------------------------------------------
function TF_ECFFP002.obtemNumeroSerie(pParams : String) : String;
//---------------------------------------------------------------
const
  cDS_METHOD = 'ADICIONAL=Operação: TF_ECFFP002.obtemNumeroSerie()';
var
  viParams, voParams : String;
begin
  viParams := '';
  putitemXml(viParams, 'NM_FUNCAO', <ECF_NUMERO_SERIE>);
  voParams := activateCmp('ECFSVCO001', 'LeInformacaoImpressora', viParams); (*,,, *)
  if (xStatus < 0) then begin
    Result := voParams;
    return(-1); exit;
  end;
    putitemXml(viParams, 'TITULO', 'Erro de comunicação com a ECF');
    putitemXml(viParams, 'MENSAGEM', itemXml('DESCRICAO', xCtxErro));
    voParams := activateCmp('GERFP008', 'EXEC', viParams); (*,,, *)
    if (xStatus < 0) then begin
      Result := voParams;
      return(-1); exit;
    end;
    return(-1); exit;
  end else if (xStatus < 0)  and (xStatus <> -11) then begin
    Result := voParams;
    return(-1); exit;
  end;
  gvNrSerie := itemXmlF('NR_SERIE', voParams);
  if (gvNrSerie = '') then begin
    gvNrSerie := itemXmlF('CD_SERIEECF', PARAM_GLB);
  end;
  return(0); exit;
end;

//-----------------------------------------------------------------
function TF_ECFFP002.verificaECFTermica(pParams : String) : String;
//-----------------------------------------------------------------
const
  cDS_METHOD = 'ADICIONAL=Operação: TF_ECFFP002.verificaECFTermica()';
var
  viParams, voParams : String;
begin
  viParams := '';
  voParams := activateCmp('ECFSVCO001', 'verificaTermica', viParams); (*,,, *)
  if (xStatus < 0) then begin
    Result := voParams;
    return(-1); exit;
  end;
    putitemXml(viParams, 'TITULO', 'Erro de comunicação com a ECF');
    putitemXml(viParams, 'MENSAGEM', itemXml('DESCRICAO', xCtxErro));
    voParams := activateCmp('GERFP008', 'EXEC', viParams); (*,,, *)
    if (xStatus < 0) then begin
      Result := voParams;
      return(-1); exit;
    end;
    return(-1); exit;
  end else if (xStatus < 0)  and (xStatus <> -11) then begin
    Result := voParams;
    return(-1); exit;
  end;
  gvInTermica := itemXmlB('IN_TERMICA', voParams);
  return(0); exit;
end;

//---------------------------------------------------------------
function TF_ECFFP002.meiosDePagamento(pParams : String) : String;
//---------------------------------------------------------------
const
  cDS_METHOD = 'ADICIONAL=Operação: TF_ECFFP002.meiosDePagamento()';
var
  vDtInicial, vDtFinal : TDate;
  vDsRegFormaPagto, viParams, voParams, vDsMsg, vDsRegistro, vDsLstCartao : String;
  vCdEmpLiq, vNrSeqLiq, vDtLiq, vDtAnterior : Real;
  vVlTroco, vVlFatura, vVlDinheiro, vVlCheque, vVlCartaoCredito, vVlCartaoDebito : Real;
begin
  vDtInicial := item_a('DS_DATA', tSIS_ECF);
  vDtFinal := item_a('DS_DATAFIM', tSIS_ECF);

  if (vDtInicial = '') then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Data inicial não informada!', cDS_METHOD);
    return(-1); exit;
  end;
  if (vDtFinal = '') then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Data final não informada!', cDS_METHOD);
    return(-1); exit;
  end;

  vDsRegFormaPagto := '';

  clear_e(tFCR_FATURAI);

  clear_e(tTRA_TRANSACAO);
  putitem_o(tTRA_TRANSACAO, 'CD_EMPRESA', itemXmlF('CD_EMPRESA', PARAM_GLB));
  putitem_o(tTRA_TRANSACAO, 'DT_TRANSACAO', '>= ' + vDtInicial + ' and<= ' + vDtFinal' + ');
  putitem_o(tTRA_TRANSACAO, 'TP_SITUACAO', 4);
  putitem_o(tTRA_TRANSACAO, 'TP_OPERACAO', 'S');
  retrieve_e(tTRA_TRANSACAO);
  if (xStatus >= 0) then begin
    setocc(tTRA_TRANSACAO, -1);
    setocc(tTRA_TRANSACAO, 1);
    while (xStatus >= 0) do begin

      if (item_f('TP_DOCTO', tGER_OPERACAO) = 3) then begin
        clear_e(tFGR_LIQITEMCR);
        putitem_o(tFGR_LIQITEMCR, 'CD_EMPTRANSACAO', item_f('CD_EMPRESA', tTRA_TRANSACAO));
        putitem_o(tFGR_LIQITEMCR, 'NR_TRANSACAO', item_f('NR_TRANSACAO', tTRA_TRANSACAO));
        putitem_o(tFGR_LIQITEMCR, 'DT_TRANSACAO', item_a('DT_TRANSACAO', tTRA_TRANSACAO));
        retrieve_e(tFGR_LIQITEMCR);
        if (xStatus >= 0) then begin
          vCdEmpLiq := item_f('CD_EMPLIQ', tFGR_LIQITEMCR);
          vDtLiq := item_a('DT_LIQ', tFGR_LIQITEMCR);
          vNrSeqLiq := item_f('NR_SEQLIQ', tFGR_LIQITEMCR);

          clear_e(tFGR_LIQITEMCR);
          putitem_o(tFGR_LIQITEMCR, 'CD_EMPLIQ', vCdEmpLiq);
          putitem_o(tFGR_LIQITEMCR, 'DT_LIQ', vDtLiq);
          putitem_o(tFGR_LIQITEMCR, 'NR_SEQLIQ', vNrSeqLiq);
          putitem_o(tFGR_LIQITEMCR, 'TP_TIPOREG', 2);
          retrieve_e(tFGR_LIQITEMCR);
          if (xStatus >= 0) then begin
            setocc(tFGR_LIQITEMCR, -1);
            setocc(tFGR_LIQITEMCR, 1);
            while (xStatus >= 0) do begin
              if (item_f('NR_FAT', tFGR_LIQITEMCR) > 0) then begin
                creocc(tFCR_FATURAI, -1);
                putitem_o(tFCR_FATURAI, 'CD_EMPRESA', item_f('CD_EMPFAT', tFGR_LIQITEMCR));
                putitem_o(tFCR_FATURAI, 'CD_CLIENTE', item_f('CD_CLIENTE', tFGR_LIQITEMCR));
                putitem_o(tFCR_FATURAI, 'NR_FAT', item_f('NR_FAT', tFGR_LIQITEMCR));
                putitem_o(tFCR_FATURAI, 'NR_PARCELA', item_f('NR_PARCELA', tFGR_LIQITEMCR));
                retrieve_o(tFCR_FATURAI);
                if (xStatus = -7) then begin
                  retrieve_x(tFCR_FATURAI);
                end;
              end;
              setocc(tFGR_LIQITEMCR, curocc(tFGR_LIQITEMCR) + 1);
            end;
          end;
        end;
      end;

      setocc(tTRA_TRANSACAO, curocc(tTRA_TRANSACAO) + 1);
    end;
    if (empty(tFCR_FATURAI) = False) then begin
      vVlFatura := 0;
      vVlCheque := 0;
      vVlDinheiro := 0;
      vVlCartaoCredito := 0;
      vVlCartaoDebito := 0;
      vVlTroco := 0;
      setocc(tFCR_FATURAI, 1);
      while (xStatus >= 0) do begin
        selectcase (item_f('TP_DOCUMENTO', tFCR_FATURAI));
          case 1;
            vVlFatura := vVlFatura + item_f('VL_FATURA', tFCR_FATURAI);
            creocc(tTMP_K02DS, -1);
            putitem_e(tTMP_K02DS, 'DS_K01', item_a('DT_EMISSAO', tFCR_FATURAI));
            putitem_e(tTMP_K02DS, 'DS_K02', 'Fatura');
            retrieve_o(tTMP_K02DS);
            putitem_e(tTMP_K02DS, 'VL_TOTAL', item_f('VL_TOTAL', tTMP_K02DS) + item_f('VL_FATURA', tFCR_FATURAI));
          case 2;
            vVlCheque := vVlCheque + item_f('VL_FATURA', tFCR_FATURAI);
            creocc(tTMP_K02DS, -1);
            putitem_e(tTMP_K02DS, 'DS_K01', item_a('DT_EMISSAO', tFCR_FATURAI));
            putitem_e(tTMP_K02DS, 'DS_K02', 'Cheque');
            retrieve_o(tTMP_K02DS);
            putitem_e(tTMP_K02DS, 'VL_TOTAL', item_f('VL_TOTAL', tTMP_K02DS) + item_f('VL_FATURA', tFCR_FATURAI));
          case 3;
            vVlDinheiro := vVlDinheiro + item_f('VL_FATURA', tFCR_FATURAI);
            creocc(tTMP_K02DS, -1);
            putitem_e(tTMP_K02DS, 'DS_K01', item_a('DT_EMISSAO', tFCR_FATURAI));
            putitem_e(tTMP_K02DS, 'DS_K02', 'Dinheiro');
            retrieve_o(tTMP_K02DS);
            putitem_e(tTMP_K02DS, 'VL_TOTAL', item_f('VL_TOTAL', tTMP_K02DS) + item_f('VL_FATURA', tFCR_FATURAI));
          case 4;
            vVlCartaoCredito := vVlCartaoCredito + item_f('VL_FATURA', tFCR_FATURAI);
            creocc(tTMP_K02DS, -1);
            putitem_e(tTMP_K02DS, 'DS_K01', item_a('DT_EMISSAO', tFCR_FATURAI));
            putitem_e(tTMP_K02DS, 'DS_K02', 'Cartao credito');
            retrieve_o(tTMP_K02DS);
            putitem_e(tTMP_K02DS, 'VL_TOTAL', item_f('VL_TOTAL', tTMP_K02DS) + item_f('VL_FATURA', tFCR_FATURAI));
          case 5;
            vVlCartaoDebito := vVlCartaoDebito + item_f('VL_FATURA', tFCR_FATURAI);
            creocc(tTMP_K02DS, -1);
            putitem_e(tTMP_K02DS, 'DS_K01', item_a('DT_EMISSAO', tFCR_FATURAI));
            putitem_e(tTMP_K02DS, 'DS_K02', 'Cartao Debito');
            retrieve_o(tTMP_K02DS);
            putitem_e(tTMP_K02DS, 'VL_TOTAL', item_f('VL_TOTAL', tTMP_K02DS) + item_f('VL_FATURA', tFCR_FATURAI));
          case 9;
            vVlTroco := vVlTroco + item_f('VL_FATURA', tFCR_FATURAI);
            creocc(tTMP_K02DS, -1);
            putitem_e(tTMP_K02DS, 'DS_K01', item_a('DT_EMISSAO', tFCR_FATURAI));
            putitem_e(tTMP_K02DS, 'DS_K02', 'Troco');
            retrieve_o(tTMP_K02DS);
            putitem_e(tTMP_K02DS, 'VL_TOTAL', item_f('VL_TOTAL', tTMP_K02DS) + item_f('VL_FATURA', tFCR_FATURAI));
        endselectcase;
        setocc(tFCR_FATURAI, curocc(tFCR_FATURAI) + 1);
      end;

      vDsRegFormaPagto := 'MEIOS DE PAGAMENTO';
      gvData := vDtInicial;
      vDsRegFormaPagto := '' + vDsRegFormaPagto + ' Data Inicial...: ' + gvData' + ';
      gvData := vDtFinal;
      vDsRegFormaPagto := '' + vDsRegFormaPagto + ' Data Final.....: ' + gvData' + ';
      vDsRegFormaPagto := '' + vDsRegFormaPagto + ' Resumo por data...:';
      setocc(tTMP_K02DS, -1);
      setocc(tTMP_K02DS, 1);
      sort_e(tTMP_K02DS, '      sort/e , DS_K01;');
      setocc(tTMP_K02DS, 1);
      while(xStatus >= 0) do begin
        if (vDtAnterior <> item_a('DS_K01', tTMP_K02DS)) then begin
          vDtAnterior := item_a('DS_K01', tTMP_K02DS);
          gvData := item_a('DS_K01', tTMP_K02DS);
            vDsRegFormaPagto := '' + vDsRegFormaPagto + ' Data...: ' + gvData' + ';
          vDsRegFormaPagto := '' + vDsRegFormaPagto + ' ' + DS_K + 'item_a('02', tTMP_K02DS): ' + item_a('VL_TOTAL', tTMP_K) + '02DS';
        end else begin
          vDsRegFormaPagto := '' + vDsRegFormaPagto + ' ' + DS_K + 'item_a('02', tTMP_K02DS): ' + item_a('VL_TOTAL', tTMP_K) + '02DS';
        end;
        setocc(tTMP_K02DS, curocc(tTMP_K02DS) + 1);
      end;

      vDsRegFormaPagto := '' + vDsRegFormaPagto + ' Resumo Total...:';
      vDsRegFormaPagto := '' + vDsRegFormaPagto + ' Dinheiro.......: ' + FloatToStr(vVlDinheiro') + ';
      vDsRegFormaPagto := '' + vDsRegFormaPagto + ' Fatura.........: ' + FloatToStr(vVlFatura') + ';
      vDsRegFormaPagto := '' + vDsRegFormaPagto + ' Cheque.........: ' + FloatToStr(vVlCheque') + ';
      vDsRegFormaPagto := '' + vDsRegFormaPagto + ' Cartao credito.: ' + FloatToStr(vVlCartaoCredito') + ';
      vDsRegFormaPagto := '' + vDsRegFormaPagto + ' Cartao Debito..: ' + FloatToStr(vVlCartaoDebito') + ';
      vDsRegFormaPagto := '' + vDsRegFormaPagto + ' Troco..........: ' + FloatToStr(vVlTroco') + ';
    end;
  end;
  if (vDsRegFormaPagto <> '') then begin
    vDsRegistro := '';
    putitemXml(vDsRegistro, 'DS_CUPOM', vDsRegFormaPagto);
    vDsLstCartao := '';
    putitem(vDsLstCartao,  vDsRegistro);

    viParams := '';
    putitemXml(viParams, 'IN_IMPRIMEVIA', True);
    putitemXml(viParams, 'DS_LSTCUPOM', vDsLstCartao);
    voParams := activateCmp('ECFSVCO011', 'geraRelatorioGerencial', viParams); (*,,, *)
    if (xStatus < 0) then begin
      Result := voParams;
      return(-1); exit;
    end;
      putitemXml(viParams, 'TITULO', 'Erro de comunicação com a ECF');
      putitemXml(viParams, 'MENSAGEM', itemXml('DESCRICAO', xCtxErro));
      voParams := activateCmp('GERFP008', 'EXEC', viParams); (*,,, *)
      if (xStatus < 0) then begin
        Result := voParams;
        return(-1); exit;
      end;
      return(-1); exit;
    end else if (xStatus < 0) then begin
      Result := voParams;
      return(-1); exit;
    end;

    viParams := '';

    putitemXml(viParams, 'NM_FUNCAO', <ECF_NUMERO_CUPOM>);
    voParams := activateCmp('ECFSVCO001', 'leInformacaoImpressora', viParams); (*,,, *)
    if (xStatus < 0) then begin
      Result := voParams;
      return(-1); exit;
    end;
  end;
  return(0); exit;
end;

end.
