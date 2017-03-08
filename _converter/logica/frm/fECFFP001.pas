unit fECFFP001;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, fFormTouch, ExtCtrls, cPanel, cDatasetUnf, fDialogTouch;

type
  TF_ECFFP001 = class(T_FormTouch)
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
  private
    tFIS_ECF,
    tFIS_PAFECF,
    tSIS_ECF,
    tTRA_TRANSACAO,
    tTRA_TRANSACECF : TcDatasetUnf;
    function getParam(pParams : String = '') : String;
    function setEntidade(pParams : String = '') : String;
    function preEDIT(pParams : String = '') : String;
    function cancelaCupom(pParams : String = '') : String;
    function leituraX(pParams : String = '') : String;
    function leinformacaoImpressora(pParams : String = '') : String;
    function chamaFuncao(pParams : String = '') : String;
    function reEmissao(pParams : String = '') : String;
    function instalaMonitor(pParams : String = '') : String;
    function abreGaveta(pParams : String = '') : String;
    function geraMapaFiscal(pParams : String = '') : String;
    function geraRelatorioSintegra(pParams : String = '') : String;
    function dataHoraImpressora(pParams : String = '') : String;
    function geraArqDigital(pParams : String = '') : String;
    function chamaIdentificacaoPAF(pParams : String = '') : String;
    function verificaEmpresa(pParams : String = '') : String;
    function parametrosDeConfiguracao(pParams : String = '') : String;
    function validaCancelamentoCupom(pParams : String = '') : String;
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
  gInAberturaCxECF,
  gInGravaReducaoZ,
  gInPdvOtimizado,
  gPadraoECF,
  gTpValidacaoCancEcf,
  gufOrigem : String;

procedure TF_ECFFP001.FormCreate(Sender: TObject);
begin
  inherited; //
  setEntidade();
end;

procedure TF_ECFFP001.FormShow(Sender: TObject);
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

procedure TF_ECFFP001.FormActivate(Sender: TObject);
begin
  inherited; //
end;

procedure TF_ECFFP001.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  inherited; //
end;

//---------------------------------------------------------------
function TF_ECFFP001.getParam(pParams : String = '') : String;
//---------------------------------------------------------------
var
  piCdEmpresa : Real;
begin
  piCdEmpresa := itemXmlF('CD_EMPRESA', pParams);
  if (piCdEmpresa = 0) then begin
    piCdEmpresa := itemXmlF('CD_EMPRESA', PARAM_GLB);
  end;

  xParamEmp := '';
  putitem(xParamEmp,  'IN_PDV_OTIMIZADO');
  putitem(xParamEmp,  'PADRAO_ECF');
  putitem(xParamEmp,  'IN_GRAVA_REDUCAOZ');
  putitem(xParamEmp,  'TP_VALIDACAO_CANC_TRA_ECF');
  putitem(xParamEmp,  'UF_ORIGEM');
  xParamEmp := T_ADMSVCO001.GetParamEmpresa(piCdEmpresa, xParamEmp);
  gPadraoECF := itemXml('PADRAO_ECF', xParamEmp);
  gInPdvOtimizado := itemXmlB('IN_PDV_OTIMIZADO', xParamEmp);
  gInGravaReducaoZ := itemXmlB('IN_GRAVA_REDUCAOZ', xParamEmp);
  gTpValidacaoCancEcf := itemXmlF('TP_VALIDACAO_CANC_TRA_ECF', xParamEmp);
  gufOrigem := itemXml('UF_ORIGEM', xParamEmp);
end;

//---------------------------------------------------------------
function TF_ECFFP001.setEntidade(pParams : String = '') : String;
//---------------------------------------------------------------
begin
  tFIS_ECF := TcDatasetUnf.GetEntidade(Self, 'FIS_ECF');
  tFIS_PAFECF := TcDatasetUnf.GetEntidade(Self, 'FIS_PAFECF');
  tSIS_ECF := TcDatasetUnf.GetEntidade(Self, 'SIS_ECF');
  tTRA_TRANSACAO := TcDatasetUnf.GetEntidade(Self, 'TRA_TRANSACAO');
  tTRA_TRANSACECF := TcDatasetUnf.GetEntidade(Self, 'TRA_TRANSACECF');
end;

//------------------------------------------------------
function TF_ECFFP001.preEDIT(pParams : String) : String;
//------------------------------------------------------
const
  cDS_METHOD = 'ADICIONAL=Operação: TF_ECFFP001.preEDIT()';
begin
  voParams := verificaEmpresa(viParams); (* *)
  if (xStatus < 0) then begin
    Result := voParams;
    return(-1); exit;
  end;

  gInAberturaCxECF := itemXmlB('IN_ABERTURACXECF', viParams);
  if (gInAberturaCxECF = True) then begin
    show;
    voParams := chamaFuncao(viParams); (* 4 *)
    if (xStatus < 0) then begin
      Result := voParams;
      return(-1); exit;
    end;
    return(0); exit;
  end;
  if (gInPdvOtimizado = True) then begin
    gprompt := item_a('BT_LEITURAX', tSIS_ECF);
  end else begin
    gprompt := item_a('BT_NRSERIE', tSIS_ECF);
  end;

  return(0); exit;
end;

//---------------------------------------------------
function TF_ECFFP001.INIT(pParams : String) : String;
//---------------------------------------------------
const
  cDS_METHOD = 'ADICIONAL=Operação: TF_ECFFP001.INIT()';
begin
  xParamEmp := '';
  putitem(xParamEmp,  'IN_PDV_OTIMIZADO');
  putitem(xParamEmp,  'PADRAO_ECF');
  putitem(xParamEmp,  'IN_GRAVA_REDUCAOZ');
  putitem(xParamEmp,  'TP_VALIDACAO_CANC_TRA_ECF');
  putitem(xParamEmp,  'UF_ORIGEM');
  xParamEmp := T_ADMSVCO001.GetParamEmpresa(piCdEmpresa, xParamEmp); (*itemXml('CD_EMPRESA', *)
  gPadraoECF := itemXml('PADRAO_ECF', xParamEmp);
  gInPdvOtimizado := itemXmlB('IN_PDV_OTIMIZADO', xParamEmp);
  gInGravaReducaoZ := itemXmlB('IN_GRAVA_REDUCAOZ', xParamEmp);
  gTpValidacaoCancEcf := itemXmlF('TP_VALIDACAO_CANC_TRA_ECF', xParamEmp);
  gufOrigem := itemXml('UF_ORIGEM', xParamEmp);

  _Caption := '' + ECFFP + '001 - Operação de ECF (Emissor de Cupom Fiscal)';
end;

//-----------------------------------------------------------
function TF_ECFFP001.cancelaCupom(pParams : String) : String;
//-----------------------------------------------------------
const
  cDS_METHOD = 'ADICIONAL=Operação: TF_ECFFP001.cancelaCupom()';
var
  viParams, voParams : String;
  vInCancelaTransacao : Boolean;
begin
  if (gPadraoECF = <PADRAO_AFRAC>)  or (gPadraoECF = <PADRAO_DIGIARTE>) then begin
    viParams := '';

    putitemXml(viParams, 'NR_COM', 'COM1');
    voParams := activateCmp('ECFSVCO001', 'AbrePorta', viParams); (*,,, *)
    if (xStatus < 0) then begin
      Result := voParams;
      return(-1); exit;
    end;
  end;

  viParams := '';
  putitemXml(viParams, 'NR_SERIE', itemXmlF('CD_SERIEECF', PARAM_GLB));
  voParams := activateCmp('ECFSVCO010', 'validaImpressoraFiscal', viParams); (*,,,, *)
  if (xStatus < 0) then begin
    Result := voParams;
    return(-1); exit;
  end;
  if (gTpValidacaoCancEcf = 1) then begin
    voParams := validaCancelamentoCupom(viParams); (* vInCancelaTransacao *)
    if (xStatus < 0) then begin
      Result := voParams;
      return(-1); exit;
    end;
    if (vInCancelaTransacao = True) then begin
      askmess 'Atenção, a transação: ' + item_a('NR_TRANSACAO', tTRA_TRANSACAO) + ' será cancelada, Confirma?', 'Sim, Não';
      if (xStatus = 2) then begin
        return(0); exit;
      end;
    end;
  end;

  viParams := '';
  voParams := activateCmp('ECFSVCO001', 'CancelaCupom', viParams); (*,,, *)
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
  if (gTpValidacaoCancEcf = 1)  and (vInCancelaTransacao = True) then begin
    viParams := '';
    putitemXml(viParams, 'CD_EMPRESA', item_f('CD_EMPRESA', tTRA_TRANSACAO));
    putitemXml(viParams, 'NR_TRANSACAO', item_f('NR_TRANSACAO', tTRA_TRANSACAO));
    putitemXml(viParams, 'DT_TRANSACAO', item_a('DT_TRANSACAO', tTRA_TRANSACAO));
    putitemXml(viParams, 'DS_MOTIVO', 'CANCELAMENTO DO CUPOM FISCAL ' + item_a('NR_CUPOM', tTRA_TRANSACECF) + '');
    putitemXml(viParams, 'TP_SITUACAONF', 'C');
    putitemXml(viParams, 'IN_PEDIDO', False);
    putitemXml(viParams, 'TP_QUANTIDADEPED', 'S');
    putitemXml(viParams, 'CD_CONFERENTE', itemXmlF('CD_USUARIO', PARAM_GLB));
    putitemXml(viParams, 'CD_COMPONENTE', ECFFP001);
    putitemXml(viParams, 'IN_IGNORACANCECF', True);
    voParams := activateCmp('TRASVCO013', 'cancelaTransacao', viParams); (*,,,, *)
    if (xStatus < 0) then begin
      Result := voParams;
      return(-1); exit;
    end;

    message/info 'Transação ' + item_a('NR_TRANSACAO', tTRA_TRANSACAO) + ' cancelada!';

    commit;
  end;

  return(0); exit;

end;

//-------------------------------------------------------
function TF_ECFFP001.leituraX(pParams : String) : String;
//-------------------------------------------------------
const
  cDS_METHOD = 'ADICIONAL=Operação: TF_ECFFP001.leituraX()';
var
  viParams, voParams : String;
begin
  if (gPadraoECF = <PADRAO_AFRAC>)  or (gPadraoECF = <PADRAO_DIGIARTE>) then begin
    viParams := '';

    putitemXml(viParams, 'NR_COM', 'COM1');
    voParams := activateCmp('ECFSVCO001', 'AbrePorta', viParams); (*,,, *)
    if (xStatus < 0) then begin
      Result := voParams;
      return(-1); exit;
    end;
  end;
  voParams := activateCmp('ECFSVCO001', 'leituraX', viParams); (*,,, *)
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
  return(0); exit;
end;

//---------------------------------------------------------------------
function TF_ECFFP001.leinformacaoImpressora(pParams : String) : String;
//---------------------------------------------------------------------
const
  cDS_METHOD = 'ADICIONAL=Operação: TF_ECFFP001.leinformacaoImpressora()';
var
  (* numeric vTpInfo : IN *)
  viParams, voParams, vNrserie, vNrCupom, vDsRetorno : String;
begin
  if (gPadraoECF = <PADRAO_AFRAC>) or(gPadraoECF = <PADRAO_DIGIARTE>) then begin
    viParams := '';

    putitemXml(viParams, 'NR_COM', 'COM1');
    voParams := activateCmp('ECFSVCO001', 'AbrePorta', viParams); (*,,, *)
    if (xStatus < 0) then begin
      Result := voParams;
      return(-1); exit;
    end;
  end;
  viParams := '';
  selectcase (vTpInfo);
    case 1;
      putitemXml(viParams, 'NM_FUNCAO', <ECF_NUMERO_SERIE>);
    case 2;
      putitemXml(viParams, 'IN_IMPCUPOMFISCAL', False);
      putitemXml(viParams, 'NM_FUNCAO', <ECF_NUMERO_CUPOM>);
    case 3;
      putitemXml(viParams, 'NM_FUNCAO', <ECF_ALIQUOTA>);

    case 4;
      putitemXml(viParams, 'NM_FUNCAO', <ECF_FORMAPGTO>);
  endselectcase;

  voParams := activateCmp('ECFSVCO001', 'leinformacaoImpressora', viParams); (*,,, *)
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
  selectcase (vTpInfo);
    case 1;
      vNrSerie := itemXmlF('NR_SERIE', voParams);
      message/info 'Numero de serie da impressora ' + FloatToStr(vNrSerie') + ';
    case 2;
      vNrCupom := itemXmlF('NR_CUPOM', voParams);
      message/info 'Numero de cupom ' + FloatToStr(vNrCupom') + ';
    case 3;
      vDsRetorno := itemXml('DS_ALIQUOTA', voParams);
      message/info 'Alíquotas cadastradas: ' + vDsRetorno' + ';
    case 4;
      viParams := '';
      putitemXml(viParams, 'DS_LSTFORMAPGTO', itemXml('DS_FORMAPGTO', voParams));
      voParams := activateCmp('ECFFP003', 'EXEC', viParams); (*,,, *)
      if (xStatus < 0) then begin
        Result := voParams;
        return(-1); exit;
      end;
  endselectcase;

  return(0); exit;
end;

//----------------------------------------------------------
function TF_ECFFP001.chamaFuncao(pParams : String) : String;
//----------------------------------------------------------
const
  cDS_METHOD = 'ADICIONAL=Operação: TF_ECFFP001.chamaFuncao()';
var
  (* numeric Tipo : IN *)
  viParams, voParams, vStatus : String;
begin
  if (gPadraoECF = <PADRAO_AFRAC>)  or (gPadraoECF = <PADRAO_DIGIARTE>) then begin
        viParams := '';

    putitemXml(viParams, 'NR_COM', 'COM1');
    voParams := activateCmp('ECFSVCO001', 'AbrePorta', viParams); (*,,, *)
    if (xStatus < 0) then begin
      Result := voParams;
      return(-1); exit;
    end;
  end;
  viParams := '';
  putitemXml(viParams, 'IN_FLAG', Tipo);
  if (Tipo = 1) then begin
    putitemXml(viParams, 'DS_FRAME', 'ReduçãoZ');
  end else if (Tipo = 2) then begin
    askmess 'Deseja tirar a leitura da mémoria fiscal completa por ', 'Data ECF, Redução ECF, Data Arq., Redução Arq.';
    vStatus := xStatus;
    putitemXml(viParams, 'TP_LEITURA', xStatus);
    if (vStatus = 1) then begin
      putitemXml(viParams, 'DS_FRAME', 'Data ECF');
    end else if (vStatus = 2) then begin
      putitemXml(viParams, 'DS_FRAME', 'Redução ECF');
    end else if (vStatus = 3) then begin
      putitemXml(viParams, 'DS_FRAME', 'Data para arquivo');
    end else if (vStatus = 4) then begin
      putitemXml(viParams, 'DS_FRAME', 'Redução para arquivo');
    end;
  end else if (Tipo = 3) then begin
    putitemXml(viParams, 'DS_FRAME', 'Suprimento');
  end else if (Tipo = 4) then begin
    putitemXml(viParams, 'DS_FRAME', 'Abertura do dia');
  end else if (Tipo = 5) then begin
    putitemXml(viParams, 'DS_FRAME', 'Sangria');
  end else if (Tipo = 7) then begin
    putitemXml(viParams, 'DS_FRAME', 'Gera arquivo digital');
  end else if (Tipo = 8) then begin
    askmess 'Movimento por ECF', 'Atualizar banco de dados, Gerar arquivo de movimento';
    vStatus := xStatus;
    if (vStatus = 1) then begin
      putitemXml(viParams, 'TP_SITUACAO', 1);
      putitemXml(viParams, 'DS_FRAME', 'Periodo movimento ECF');
    end else if (vStatus = 2) then begin
      putitemXml(viParams, 'TP_SITUACAO', 2);
      putitemXml(viParams, 'DS_FRAME', 'Mov por ECF');
    end;
  end else if (Tipo = 9) then begin
    askmess 'Deseja tirar a leitura da mémoria Simplificada por ', 'Data ECF, Redução ECF, Data Arq., Redução Arq.';
    vStatus := xStatus;
    putitemXml(viParams, 'TP_LEITURA', xStatus);
    if (vStatus = 1) then begin
      putitemXml(viParams, 'DS_FRAME', 'Data ECF');
    end else if (vStatus = 2) then begin
      putitemXml(viParams, 'DS_FRAME', 'Redução ECF');
    end else if (vStatus = 3) then begin
      putitemXml(viParams, 'DS_FRAME', 'Data para arquivo');
    end else if (vStatus = 4) then begin
      putitemXml(viParams, 'DS_FRAME', 'Redução para arquivo');
    end;
  end else if (Tipo = 10) then begin
    putitemXml(viParams, 'DS_FRAME', 'Data para gerencial');
  end else if (Tipo = 11) then begin
    askmess 'Arquivo MFD', 'Data, COO';
    vStatus := xStatus;
    putitemXml(viParams, 'TP_LEITURA', xStatus);
    if (vStatus = 1) then begin
      putitemXml(viParams, 'DS_FRAME', 'Data ECF');
    end else if (vStatus = 2) then begin
      putitemXml(viParams, 'DS_FRAME', 'Redução OCC');
    end;
  end;
  voParams := activateCmp('ECFFP002', 'EXEC', viParams); (*,,, *)
  if (xStatus < 0) then begin
    Result := voParams;
    return(-1); exit;
  end;

  return(0); exit;
end;

//--------------------------------------------------------
function TF_ECFFP001.reEmissao(pParams : String) : String;
//--------------------------------------------------------
const
  cDS_METHOD = 'ADICIONAL=Operação: TF_ECFFP001.reEmissao()';
var
  viParams, voParams : String;
begin
  viParams := '';
  putitemXml(viParams, 'IN_ECF', True);
  voParams := activateCmp('TRAFP020', 'EXEC', viParams); (*,,, *)
  if (xStatus < 0) then begin
    Result := voParams;
    return(-1); exit;
  end;

  return(0); exit;
end;

//-------------------------------------------------------------
function TF_ECFFP001.instalaMonitor(pParams : String) : String;
//-------------------------------------------------------------
const
  cDS_METHOD = 'ADICIONAL=Operação: TF_ECFFP001.instalaMonitor()';
var
  viParams, voParams, vDsVersao : String;
  vTpMonitor : Real;
begin
  viParams := '';
  askmess 'Instala programa que efetua comunicação com a impressora fiscal!', 'MonitorCOM, MonitorDLL';
  vTpMonitor := xStatus;
  putitemXml(viParams, 'TP_MONITOR', vTpMonitor);

  voParams := activateCmp('ECFSVCO014', 'instalaMonitor', viParams); (*,,,, *)
    commit;
    if (xStatus < 0) then begin
      rollback;
      return(-1); exit;
    end else begin
      voParams := SetHint(viParams); (* 'ID=APLINFO002' *)
    end;

    putitemXml(viParams, 'TP_MONITOR', vTpMonitor);
    voParams := activateCmp('ECFSVCO014', 'verificaVersao', viParams); (*,,,, *)
    if (xStatus < 0) then begin
      Result := voParams;
      return(-1); exit;
    end;
    vDsVersao := itemXml('DS_VERSAO', voParams);

    message/info 'Instalação concluída com sucesso! Versão ' + vDsVersao + ' execute o Monitor C:\ECF\MONITOR.EXE';
  end;

  return(0); exit;
end;

//---------------------------------------------------------
function TF_ECFFP001.abreGaveta(pParams : String) : String;
//---------------------------------------------------------
const
  cDS_METHOD = 'ADICIONAL=Operação: TF_ECFFP001.abreGaveta()';
var
  viParams, voParams : String;
begin
  if (gPadraoECF = <PADRAO_AFRAC>)  or (gPadraoECF = <PADRAO_DIGIARTE>) then begin
    viParams := '';

    putitemXml(viParams, 'NR_COM', 'COM1');
    voParams := activateCmp('ECFSVCO001', 'AbrePorta', viParams); (*,,, *)
    if (xStatus < 0) then begin
      Result := voParams;
      return(-1); exit;
    end;
  end;

  viParams := '';
  voParams := activateCmp('ECFSVCO001', 'abreGaveta', viParams); (*,,, *)
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
  return(0); exit;

end;

//-------------------------------------------------------------
function TF_ECFFP001.geraMapaFiscal(pParams : String) : String;
//-------------------------------------------------------------
const
  cDS_METHOD = 'ADICIONAL=Operação: TF_ECFFP001.geraMapaFiscal()';
var
  viParams, voParams, vNrSerie : String;
begin
  if (gInGravaReducaoZ = True) then begin
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
      vNrSerie := itemXmlF('NR_SERIE', voParams);

    viParams := '';

    putitemXml(viParams, 'NR_SERIE', vNrSerie);
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
      Result := SetStatus(<STS_INFO>, 'GEN0001', 'Processo concluído com sucesso.', cDS_METHOD);
      voParams := SetHint(viParams); (* 'ID=APLINFO002' *)
    end;
  end;
  return(0); exit;
end;

//--------------------------------------------------------------------
function TF_ECFFP001.geraRelatorioSintegra(pParams : String) : String;
//--------------------------------------------------------------------
const
  cDS_METHOD = 'ADICIONAL=Operação: TF_ECFFP001.geraRelatorioSintegra()';
var
  viParams, voParams : String;
begin
  viParams := '';
  voParams := activateCmp('ECFFP004', 'EXEC', viParams); (*,,, *)
  if (xStatus < 0) then begin
    Result := voParams;
    return(-1); exit;
  end;

  return(0); exit;
end;

//-----------------------------------------------------------------
function TF_ECFFP001.dataHoraImpressora(pParams : String) : String;
//-----------------------------------------------------------------
const
  cDS_METHOD = 'ADICIONAL=Operação: TF_ECFFP001.dataHoraImpressora()';
var
  viParams, voParams, vDsRetorno : String;
begin
  viParams := '';
  voParams := activateCmp('ECFSVCO001', 'dataHoraImpressora', viParams); (*,,, *)
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

  vDsRetorno := itemXml('DS_DATAHORA', voParams);
  message/info 'Data e hora do ECF: ' + vDsRetorno' + ';

  return(0); exit;

end;

//-------------------------------------------------------------
function TF_ECFFP001.geraArqDigital(pParams : String) : String;
//-------------------------------------------------------------
const
  cDS_METHOD = 'ADICIONAL=Operação: TF_ECFFP001.geraArqDigital()';
var
  viParams, voParams : String;
begin
  viParams := '';
  voParams := activateCmp('ECFFP004', 'EXEC', viParams); (*,,, *)
  if (xStatus < 0) then begin
    Result := voParams;
    return(-1); exit;
  end;

  return(0); exit;
end;

//--------------------------------------------------------------------
function TF_ECFFP001.chamaIdentificacaoPAF(pParams : String) : String;
//--------------------------------------------------------------------
const
  cDS_METHOD = 'ADICIONAL=Operação: TF_ECFFP001.chamaIdentificacaoPAF()';
var
  viParams, voParams, vDsMensagem, vDsMsg : String;
  vCdEmpresa, vNrCupom : Real;
  vDsRegistro, vDsLstCupom, vDsCupom, vDsLstCartao : String;
  vDtSistema : TDate;
  vInLoopImpressao : Boolean;
begin
  clear_e(tFIS_PAFECF);
  retrieve_e(tFIS_PAFECF);

  if (empty(tFIS_PAFECF) = False) then begin
    vDsMensagem := '';
    vDsMensagem := '' + vDsMensagem + ' INDENTIFICAÇÃO DO PAF-ECF';
    vDsMensagem := '' + vDsMensagem + ' Identificação do laudo: ' + item_a('CD_LAUDO', tFIS_PAFECF) + '';
    vDsMensagem := '' + vDsMensagem + ' Nr. CNPJ                  : ' + item_a('NR_CNPJ', tFIS_PAFECF) + '';
    vDsMensagem := '' + vDsMensagem + ' Razão social             : ' + item_a('NM_RAZAOSOCIAL', tFIS_PAFECF) + '';
    vDsMensagem := '' + vDsMensagem + ' endereço                  : ' + item_a('NM_endERECO', tFIS_PAFECF) + '';
    vDsMensagem := '' + vDsMensagem + ' Nr. endereço             : ' + item_a('NR_endERECO', tFIS_PAFECF) + '';
    vDsMensagem := '' + vDsMensagem + ' Bairro                       : ' + item_a('NM_BAIRRO', tFIS_PAFECF) + '';
    vDsMensagem := '' + vDsMensagem + ' Contato                    : ' + item_a('NM_CONTATO', tFIS_PAFECF) + '';
    vDsMensagem := '' + vDsMensagem + ' Telefone                    : ' + item_a('NR_TELEFONE', tFIS_PAFECF) + '';
    vDsMensagem := '' + vDsMensagem + ' Nome aplicativo        : ' + item_a('NM_APLICATIVO', tFIS_PAFECF) + '';
    vDsMensagem := '' + vDsMensagem + ' Versão                    : ' + item_a('NM_VERSAO', tFIS_PAFECF) + '';
    vDsMensagem := '' + vDsMensagem + ' Nome executável      : ' + item_a('NM_EXECUTAVEL', tFIS_PAFECF) + '';
    vDsMensagem := '' + vDsMensagem + ' Código MD5             : ' + DS_CODIGOEXE + 'item_a('1', tFIS_PAFECF)';

    if (gModulo.GNMUSRSO = 'santarita')  and (gModulo.gcdempresa = 7) then begin
      vDsMensagem := 'Identificação do laudo: IFL0122009Nr. CNPJ              : 00.157.585/0001-58Razão social          : JOSE MARCOS NABHANendereço              : AV. GOIAS, SALA 21 - SOBRELOJANr. endereço          : 810Bairro                : CENTROContato               : MARCELIA FECCHIOTelefone              : 44 3619-4500Nome aplicativo       : STOREAGEVersão                : 3.0Nome executável       : STOREAGE.EXECódigo MD5: 707499a18b5bb9b8c623633d0fb0ccd6';
    end;
    if (gufOrigem = 'ES' ) or (gufOrigem = 'PB' ) or (gufOrigem = 'AP' ) or (gufOrigem = 'AM') then begin
      vDsMensagem := 'Identificação do laudo: IFL0392011Nr. CNPJ              : 00.157.585/0001-58Razão social          : JOSE MARCOS NABHANendereço              : AV. GOIAS, SALA 21 - SOBRELOJANr. endereço          : 810Bairro                : CENTROContato               : MARCELIA FECCHIOTelefone              : 44 3619-4500Nome aplicativo       : STOREAGEVersão                : 3.1Nome executável       : STOREAGE.EXECódigo MD5: 49CE11C67B0033DD57B26EE905EAD793';
    end;

    viParams := '';

    putitemXml(viParams, 'TITULO', 'INDENTIFICAÇÃO DO PAF-ECF');
    putitemXml(viParams, 'MENSAGEM', vDsMensagem);
    voParams := activateCmp('GERFP008', 'EXEC', viParams); (*,,, *)
    if (xStatus < 0) then begin
      Result := voParams;
      return(-1); exit;
    end;

    vDsMensagem := '';
    vDsMensagem := '' + vDsMensagem + ' INDENTIFICAÇÃO DO PAF-ECF';
    vDsMensagem := '' + vDsMensagem + ' Identificação do laudo: ' + item_a('CD_LAUDO', tFIS_PAFECF) + '';
    vDsMensagem := '' + vDsMensagem + ' Nr. CNPJ              : ' + item_a('NR_CNPJ', tFIS_PAFECF) + '';
    vDsMensagem := '' + vDsMensagem + ' Razão social          : ' + item_a('NM_RAZAOSOCIAL', tFIS_PAFECF) + '';
    vDsMensagem := '' + vDsMensagem + ' endereço              : ' + item_a('NM_endERECO', tFIS_PAFECF) + '';
    vDsMensagem := '' + vDsMensagem + ' Nr. endereço          : ' + item_a('NR_endERECO', tFIS_PAFECF) + '';
    vDsMensagem := '' + vDsMensagem + ' Bairro                : ' + item_a('NM_BAIRRO', tFIS_PAFECF) + '';
    vDsMensagem := '' + vDsMensagem + ' Contato               : ' + item_a('NM_CONTATO', tFIS_PAFECF) + '';
    vDsMensagem := '' + vDsMensagem + ' Telefone              : ' + item_a('NR_TELEFONE', tFIS_PAFECF) + '';
    vDsMensagem := '' + vDsMensagem + ' Nome aplicativo       : ' + item_a('NM_APLICATIVO', tFIS_PAFECF) + '';
    vDsMensagem := '' + vDsMensagem + ' Versão                : ' + item_a('NM_VERSAO', tFIS_PAFECF) + '';
    vDsMensagem := '' + vDsMensagem + ' Nome executável       : ' + item_a('NM_EXECUTAVEL', tFIS_PAFECF) + '';

    vDsMensagem := '' + vDsMensagem + ' Código MD5   : ' + DS_CODIGOEXE + 'item_a('1', tFIS_PAFECF)';

    if (gModulo.GNMUSRSO = 'santarita')  and (gModulo.gcdempresa = 7) then begin
      vDsMensagem := 'Identificação do laudo: IFL0122009Nr. CNPJ              : 00.157.585/0001-58Razão social          : JOSE MARCOS NABHANendereço              : AV. GOIAS, SALA 21 - SOBRELOJANr. endereço          : 810Bairro                : CENTROContato               : MARCELIA FECCHIOTelefone              : 44 3619-4500Nome aplicativo       : STOREAGEVersão                : 3.0Nome executável       : STOREAGE.EXECódigo MD5: 707499a18b5bb9b8c623633d0fb0ccd6';
    end;
    if (gufOrigem = 'ES' ) or (gufOrigem = 'PB' ) or (gufOrigem = 'AP' ) or (gufOrigem = 'AM') then begin
      vDsMensagem := 'Identificação do laudo: IFL0392011Nr. CNPJ              : 00.157.585/0001-58Razão social          : JOSE MARCOS NABHANendereço              : AV. GOIAS, SALA 21 - SOBRELOJANr. endereço          : 810Bairro                : CENTROContato               : MARCELIA FECCHIOTelefone              : 44 3619-4500Nome aplicativo       : STOREAGEVersão                : 3.1Nome executável       : STOREAGE.EXECódigo MD5: 49CE11C67B0033DD57B26EE905EAD793';
    end;

    vDsRegistro := '';
    putitemXml(vDsRegistro, 'DS_CUPOM', vDsMensagem);
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
    vNrCupom := itemXmlF('NR_CUPOM', voParams);

    vCdEmpresa := itemXmlF('CD_EMPRESA', PARAM_GLB);
    vDtSistema := itemXml('DT_SISTEMA', PARAM_GLB);
  end else begin
    message/warning 'Nenhuma identificação PAF cadastrada! - contate o suporte';
  end;

  return(0); exit;
end;

//--------------------------------------------------------------
function TF_ECFFP001.verificaEmpresa(pParams : String) : String;
//--------------------------------------------------------------
const
  cDS_METHOD = 'ADICIONAL=Operação: TF_ECFFP001.verificaEmpresa()';
var
  viParams, voParams : String;
  vInPrincipal : Boolean;
begin
  viParams := '';

  putitemXml(viParams, 'NM_FUNCAO', <ECF_NUMERO_CUPOM>);
  voParams := activateCmp('SICSVCO009', 'validaCentroCusto', viParams); (*,,,, *)
  if (xStatus < 0) then begin
    Result := voParams;
    return(-1); exit;
  end;
  vInPrincipal := itemXmlB('IN_MATRIZ', voParams);

  if (vInPrincipal = False) then begin
    message/error 'Empresa não cadastrada!';
    return(0); exit;
  end;

  return(0); exit;
end;

//-----------------------------------------------------------------------
function TF_ECFFP001.parametrosDeConfiguracao(pParams : String) : String;
//-----------------------------------------------------------------------
const
  cDS_METHOD = 'ADICIONAL=Operação: TF_ECFFP001.parametrosDeConfiguracao()';
var
  viParams, voParams, vDsMensagem, vDsMsg, vDsRegistro, vDsLstCupom : String;
  vCdEmpresa, vNrCupom : Real;
  vDtSistema : TDate;
begin
  vDsMensagem := '';
  vDsMensagem := '' + vDsMensagem + ' PARÂMETROS DE CONFIGURAÇÃO';
  vDsMensagem := '' + vDsMensagem + ' *Tipo de funcionamento:*';
  vDsMensagem := '' + vDsMensagem + ' -REQUISITO III-';
  vDsMensagem := '' + vDsMensagem + ' Exclusivamente Stand Alone';
  vDsMensagem := '' + vDsMensagem + ' *Emissão de DAV:*';
  vDsMensagem := '' + vDsMensagem + ' -REQUISITO IV ';
  vDsMensagem := '' + vDsMensagem + ' Não';
  vDsMensagem := '' + vDsMensagem + ' *Emissão de Pre-venda:*';
  vDsMensagem := '' + vDsMensagem + ' -REQUISITO V ';
  vDsMensagem := '' + vDsMensagem + ' Não';

  viParams := '';

  putitemXml(viParams, 'TITULO', 'Identificação do PAF-ECF');
  putitemXml(viParams, 'MENSAGEM', vDsMensagem);
  voParams := activateCmp('GERFP008', 'EXEC', viParams); (*,,, *)
  if (xStatus < 0) then begin
    Result := voParams;
    return(-1); exit;
  end;

  vDsMensagem := '';
  vDsMensagem := '' + vDsMensagem + ' PARÂMETROS DE CONFIGURAÇÃO';
  vDsMensagem := '' + vDsMensagem + ' *Tipo de funcionamento:*';
  vDsMensagem := '' + vDsMensagem + ' -REQUISITO III-';
  vDsMensagem := '' + vDsMensagem + ' Exclusivamente Stand Alone';
  vDsMensagem := '' + vDsMensagem + ' *Emissão de DAV:*';
  vDsMensagem := '' + vDsMensagem + ' -REQUISITO IV ';
  vDsMensagem := '' + vDsMensagem + ' Não';
  vDsMensagem := '' + vDsMensagem + ' *Emissão de Pre-venda:*';
  vDsMensagem := '' + vDsMensagem + ' -REQUISITO V ';
  vDsMensagem := '' + vDsMensagem + ' Não';

  vDsRegistro := '';
  putitemXml(vDsRegistro, 'DS_CUPOM', vDsMensagem);
  vDsLstCupom := '';
  putitem(vDsLstCupom,  vDsRegistro);

  viParams := '';
  putitemXml(viParams, 'IN_IMPRIMEVIA', True);
  putitemXml(viParams, 'DS_LSTCUPOM', vDsLstCupom);
  voParams := activateCmp('ECFSVCO011', 'geraRelatorioGerencial', viParams); (*,,, *)
  if (xStatus < 0) then begin
    Result := voParams;
    return(-1); exit;
  end;

  return(0); exit;
end;

//----------------------------------------------------------------------
function TF_ECFFP001.validaCancelamentoCupom(pParams : String) : String;
//----------------------------------------------------------------------
const
  cDS_METHOD = 'ADICIONAL=Operação: TF_ECFFP001.validaCancelamentoCupom()';
var
  (* boolean pInCancelaTransacao: OUT *)
  viParams, voParams, vDsNrSerie, vNrCooDocVinculado : String;
  vNrCupom : Real;
begin
  pInCancelaTransacao := False;

  viParams := '';
  putitemXml(viParams, 'IN_IMPCUPOMFISCAL', False);
  putitemXml(viParams, 'NM_FUNCAO', <ECF_NUMERO_SERIE>);
  voParams := activateCmp('ECFSVCO001', 'leinformacaoImpressora', viParams); (*,,, *)
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

  vDsNrSerie := itemXmlF('NR_SERIE', voParams);

  viParams := '';
  putitemXml(viParams, 'IN_IMPCUPOMFISCAL', False);
  putitemXml(viParams, 'NM_FUNCAO', <ECF_NUMERO_CUPOM>);
  voParams := activateCmp('ECFSVCO001', 'leinformacaoImpressora', viParams); (*,,, *)
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

  vNrCupom := itemXmlF('NR_CUPOM', voParams);

  clear_e(tFIS_ECF);
  putitem_o(tFIS_ECF, 'CD_EMPRESA', itemXmlF('CD_EMPRESA', PARAM_GLB));
  putitem_o(tFIS_ECF, 'CD_SERIEFAB', vDsNrSerie);
  retrieve_e(tFIS_ECF);
  if (xStatus >= 0) then begin
    clear_e(tTRA_TRANSACECF);
    putitem_o(tTRA_TRANSACECF, 'CD_EMPRESA', itemXmlF('CD_EMPRESA', PARAM_GLB));
    putitem_o(tTRA_TRANSACECF, 'NR_ECF', item_f('NR_ECF', tFIS_ECF));
    putitem_o(tTRA_TRANSACECF, 'NR_CUPOM', vNrCupom);
    retrieve_e(tTRA_TRANSACECF);
    if (xStatus >= 0) then begin
      clear_e(tTRA_TRANSACAO);
      putitem_o(tTRA_TRANSACAO, 'CD_EMPRESA', item_f('CD_EMPRESA', tTRA_TRANSACECF));
      putitem_o(tTRA_TRANSACAO, 'NR_TRANSACAO', item_f('NR_TRANSACAO', tTRA_TRANSACECF));
      putitem_o(tTRA_TRANSACAO, 'DT_TRANSACAO', item_a('DT_TRANSACAO', tTRA_TRANSACECF));
      retrieve_e(tTRA_TRANSACAO);
      if (xStatus >= 0) then begin
        pInCancelaTransacao := True;
      end;
    end else begin

      viParams := '';

      putitemXml(viParams, 'NR_CUPOM', vNrCupom);
      putitemXml(viParams, 'NR_SERIE', vDsNrSerie);
      voParams := activateCmp('ECFSVCO011', 'verificaDocVinculado', viParams); (*,,, *)
      if (xStatus < 0) then begin
        Result := voParams;
        return(-1); exit;
      end;

      vNrCooDocVinculado := itemXmlF('NR_COOVINCULADO', voParams);

      if (vNrCooDocVinculado <> '') then begin
        clear_e(tTRA_TRANSACECF);
        putitem_o(tTRA_TRANSACECF, 'CD_EMPRESA', itemXmlF('CD_EMPRESA', PARAM_GLB));
        putitem_o(tTRA_TRANSACECF, 'NR_ECF', item_f('NR_ECF', tFIS_ECF));
        putitem_o(tTRA_TRANSACECF, 'NR_CUPOM', vNrCooDocVinculado);
        retrieve_e(tTRA_TRANSACECF);
        if (xStatus >= 0) then begin
          clear_e(tTRA_TRANSACAO);
          putitem_o(tTRA_TRANSACAO, 'CD_EMPRESA', item_f('CD_EMPRESA', tTRA_TRANSACECF));
          putitem_o(tTRA_TRANSACAO, 'NR_TRANSACAO', item_f('NR_TRANSACAO', tTRA_TRANSACECF));
          putitem_o(tTRA_TRANSACAO, 'DT_TRANSACAO', item_a('DT_TRANSACAO', tTRA_TRANSACECF));
          retrieve_e(tTRA_TRANSACAO);
          if (xStatus >= 0) then begin
            pInCancelaTransacao := True;
          end;
        end;
      end;
    end;
  end;

  return(0); exit;
end;

end.