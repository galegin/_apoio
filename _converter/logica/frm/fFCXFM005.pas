unit fFCXFM005;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, fFormTouch, ExtCtrls, cPanel, cDatasetUnf;

type
  TF_FCXFM005 = class(T_FormTouch)
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
  private
    tFCP_DESPESAITEM,
    tFCP_DUPDESPESA,
    tFCP_DUPLICATAC,
    tFCP_DUPLICATAI,
    tFCP_FORNDESP,
    tGEC_CCUSTO,
    tGER_EMPRESA,
    tGER_MODFINC,
    tGER_MODFINI,
    tOBS_DUPI,
    tSIS_OBSERVACAO,
    tV_PES_FORNECEDOR : TcDatasetUnf;
    function getParam(pParams : String = '') : String;
    function setEntidade(pParams : String = '') : String;
    function preEDIT(pParams : String = '') : String;
    function posEDIT(pParams : String = '') : String;
    function preEDIT(pParams : String = '') : String;
    function Converterstring(pParams : String = '') : String;
    function INIT(pParams : String = '') : String;
    function CLEANUP(pParams : String = '') : String;
    function recalculaValores(pParams : String = '') : String;
    function totalizaDespesa(pParams : String = '') : String;
    function gravaDuplicata(pParams : String = '') : String;
    function chamaObservacao(pParams : String = '') : String;
    function geraMovimentoDebito(pParams : String = '') : String;
    function geraLiquidacao(pParams : String = '') : String;
    function geraRecibo(pParams : String = '') : String;
    function valorPadrao(pParams : String = '') : String;
    function validaContaUsuario(pParams : String = '') : String;
    function validaCentroCusto(pParams : String = '') : String;
    function carregaDespesaFornecedor(pParams : String = '') : String;
    function gravaObservacaoDuplicata(pParams : String = '') : String;
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
  gCdCCustoPadraoFcp,
  gCdempliq,
  gCdUsuEscolhido,
  gDtliq,
  gInLogMovCtaPes,
  gInPdvOtimizado,
  gInSenhaLanctoCx,
  gLstEmpresa,
  gNrCtaPes,
  gNrseqliq,
  gTpDuplicataLancDespCx,
  gTpLancdespFcp : String;

procedure TF_FCXFM005.FormCreate(Sender: TObject);
begin
  inherited; //
  setEntidade();
end;

procedure TF_FCXFM005.FormShow(Sender: TObject);
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

procedure TF_FCXFM005.FormActivate(Sender: TObject);
begin
  inherited; //
end;

procedure TF_FCXFM005.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  inherited; //
end;

//---------------------------------------------------------------
function TF_FCXFM005.getParam(pParams : String = '') : String;
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
function TF_FCXFM005.setEntidade(pParams : String = '') : String;
//---------------------------------------------------------------
begin
  tFCP_DESPESAITEM := TcDatasetUnf.GetEntidade(Self, 'FCP_DESPESAITEM');
  tFCP_DUPDESPESA := TcDatasetUnf.GetEntidade(Self, 'FCP_DUPDESPESA');
  tFCP_DUPLICATAC := TcDatasetUnf.GetEntidade(Self, 'FCP_DUPLICATAC');
  tFCP_DUPLICATAI := TcDatasetUnf.GetEntidade(Self, 'FCP_DUPLICATAI');
  tFCP_FORNDESP := TcDatasetUnf.GetEntidade(Self, 'FCP_FORNDESP');
  tGEC_CCUSTO := TcDatasetUnf.GetEntidade(Self, 'GEC_CCUSTO');
  tGER_EMPRESA := TcDatasetUnf.GetEntidade(Self, 'GER_EMPRESA');
  tGER_MODFINC := TcDatasetUnf.GetEntidade(Self, 'GER_MODFINC');
  tGER_MODFINI := TcDatasetUnf.GetEntidade(Self, 'GER_MODFINI');
  tOBS_DUPI := TcDatasetUnf.GetEntidade(Self, 'OBS_DUPI');
  tSIS_OBSERVACAO := TcDatasetUnf.GetEntidade(Self, 'SIS_OBSERVACAO');
  tV_PES_FORNECEDOR := TcDatasetUnf.GetEntidade(Self, 'V_PES_FORNECEDOR');
end;

//---------------------------------------------------------------
function TF_FCXFM005.preEDIT(pParams : String) : String;
//---------------------------------------------------------------
const
  cDS_METHOD = 'ADICIONAL=Operação: TF_FCXFM005.preEDIT()';
begin
  return(0); exit;
end;

//---------------------------------------------------------------
function TF_FCXFM005.posEDIT(pParams : String) : String;
//---------------------------------------------------------------
const
  cDS_METHOD = 'ADICIONAL=Operação: TF_FCXFM005.posEDIT()';
begin
  return(0); exit;
end;

//------------------------------------------------------
function TF_FCXFM005.preEDIT(pParams : String) : String;
//------------------------------------------------------
const
  cDS_METHOD = 'ADICIONAL=Operação: TF_FCXFM005.preEDIT()';
var
  vCdGrpEmp, vCdUsu : Real;
begin
  gLstEmpresa := '';
  vCdGrpEmp := itemXmlF('CD_GRUPOEMPRESA', gModulo.gParamEmp);
  vCdUsu := itemXmlF('CD_USUARIO', PARAM_GLB);
  newinstance 'GERSVCO001', 'GERSVCO001', 'TRANSACTION=TRUE';
  voParams := activateCmp('ADMSVCO006', 'GetPerfil', viParams); (*,vCdUsu,FCXFM005,vCdGrpEmp,gLstEmpresa,vCdGrpEmp,, *)
  if (xStatus < 0) then begin
    Result := voParams;
    return(-1); exit;
  end;

  voParams := valorPadrao(viParams); (* *)
  if (xStatus < 0) then begin
    Result := voParams;
    return(-1); exit;
  end;

  return(0); exit;

end;

//--------------------------------------------------------------
function TF_FCXFM005.Converterstring(pParams : String) : String;
//--------------------------------------------------------------
const
  cDS_METHOD = 'ADICIONAL=Operação: TF_FCXFM005.Converterstring()';
var
  (* string pistring :In / string postring :Out *)
  viParams,voParams : String;
begin
    putitemXml(viParams, 'DS_string', pistring);
    putitemXml(viParams, 'IN_MAIUSCULA', True);
    putitemXml(viParams, 'IN_NUMERO', True);
    putitemXml(viParams, 'IN_ESPACO', True);
    putitemXml(viParams, 'IN_ESPECIAL', False);
    putitemXml(viParams, 'IN_MANTERPONTO', False);
    voParams := activateCmp('EDISVCO020', 'limparCampo', viParams); (*,,,, *)
    postring := itemXml('DS_string', voParams);
    return(0); exit;
end;

//---------------------------------------------------
function TF_FCXFM005.INIT(pParams : String) : String;
//---------------------------------------------------
const
  cDS_METHOD = 'ADICIONAL=Operação: TF_FCXFM005.INIT()';
begin
  xParam := '';
  putitem(xParam,  'NR_PORTADOR_CARTEIRA');
  putitem(xParam,  'IN_SENHA_LANCTO_CX');
  putitem(xParam,  'IN_LOG_MOV_CTAPES');

  xParam := T_ADMSVCO001.GetParametro(xParam); (*xParam,xParam,, *)
  gInSenhaLanctoCx := itemXmlB('IN_SENHA_LANCTO_CX', xParam);

  gInLogMovCtaPes := itemXmlB('IN_LOG_MOV_CTAPES', xParam);

  xParamEmp := '';
  putitem(xParamEmp,  'CD_RECIBO_PGTODESP');
  putitem(xParamEmp,  'CD_CTAPES_CXFILIAL');
  putitem(xParamEmp,  'CD_CTAPES_CXMATRIZ');
  putitem(xParamEmp,  'CD_PESSOA_DESPESA');
  putitem(xParamEmp,  'CD_CONTA_DESPESA');
  putitem(xParamEmp,  'IN_PDV_OTIMIZADO');
  putitem(xParamEmp,  'TP_LANCDESP_FCP');
  putitem(xParamEmp,  'CD_CCUSTOPADRAO_FCP');
  putitem(xParamEmp,  'TP_DUPLICATA_LANCDESP_CX');

  xParamEmp := T_ADMSVCO001.GetParamEmpresa(piCdEmpresa, xParamEmp); (*itemXml('CD_EMPRESA', *)
  gInPdvOtimizado := itemXmlB('IN_PDV_OTIMIZADO', xParamEmp);
  gTpLancdespFcp := itemXmlF('TP_LANCDESP_FCP', xParamEmp);
  gCdCCustoPadraoFcp := itemXmlF('CD_CCUSTOPADRAO_FCP', xParamEmp);

  gTpDuplicataLancDespCx := itemXmlF('TP_DUPLICATA_LANCDESP_CX', xParamEmp);

  _Caption := '' + FCXFM + '005 - Lançamento de Despesa no Caixa';
end;

//------------------------------------------------------
function TF_FCXFM005.CLEANUP(pParams : String) : String;
//------------------------------------------------------
const
  cDS_METHOD = 'ADICIONAL=Operação: TF_FCXFM005.CLEANUP()';
begin
end;

//---------------------------------------------------------------
function TF_FCXFM005.recalculaValores(pParams : String) : String;
//---------------------------------------------------------------
const
  cDS_METHOD = 'ADICIONAL=Operação: TF_FCXFM005.recalculaValores()';
begin
  if (empty(tFCP_DESPESAITEM)) then begin
    if (item_f('CD_FORNECEDOR', tV_PES_FORNECEDOR) > 0)  and (item_f('NR_DUPLICATA', tFCP_DUPLICATAC) > 0)  and (item_f('VL_DUPLICATA', tFCP_DUPLICATAI)) then begin
      voParams := carregaDespesaFornecedor(viParams); (* *)
      if (xStatus < 0) then begin
        Result := voParams;
        return(-1); exit;
      end;
    end;
  end;
  if (item_f('VL_DUPLICATA', tFCP_DUPLICATAI) <> '') then begin
    putitem_e(tFCP_DUPLICATAI, 'VL_TOTDESPESA', '');
    putitem_e(tFCP_DUPLICATAI, 'PR_TOTDESPESA', '');
    putitem_e(tFCP_DUPLICATAI, 'VL_RESTDESPESA', '');
    putitem_e(tFCP_DUPLICATAI, 'PR_RESTDESPESA', '');
    if (empty(tFCP_DUPDESPESA) = False) then begin
      setocc(tFCP_DUPDESPESA, 1);
      while (xStatus >= 0) do begin
        if (item_f('PR_RATEIO', tFCP_DUPDESPESA) <> '') then begin
          putitem_e(tFCP_DUPDESPESA, 'VL_RATEIO', (item_f('VL_DUPLICATA', tFCP_DUPLICATAI) * item_f('PR_RATEIO', tFCP_DUPDESPESA)) / 100);
          putitem_e(tFCP_DUPLICATAI, 'VL_TOTDESPESA', item_f('VL_TOTDESPESA', tFCP_DUPLICATAI) + item_f('VL_RATEIO', tFCP_DUPDESPESA));
          putitem_e(tFCP_DUPLICATAI, 'PR_TOTDESPESA', item_f('PR_TOTDESPESA', tFCP_DUPLICATAI) + item_f('PR_RATEIO', tFCP_DUPDESPESA));
        end;
        setocc(tFCP_DUPDESPESA, curocc(tFCP_DUPDESPESA) + 1);
      end;
      setocc(tFCP_DUPDESPESA, 1);
    end;
    putitem_e(tFCP_DUPLICATAI, 'PR_RESTDESPESA', 100 - item_f('PR_TOTDESPESA', tFCP_DUPLICATAI));
    putitem_e(tFCP_DUPLICATAI, 'VL_RESTDESPESA', item_f('VL_DUPLICATA', tFCP_DUPLICATAI) - item_f('VL_TOTDESPESA', tFCP_DUPLICATAI));
  end;

  return(0); exit;
end;

//--------------------------------------------------------------
function TF_FCXFM005.totalizaDespesa(pParams : String) : String;
//--------------------------------------------------------------
const
  cDS_METHOD = 'ADICIONAL=Operação: TF_FCXFM005.totalizaDespesa()';
var
  vReg : Real;
begin
  vReg := curocc(tFCP_DUPDESPESA);
  putitem_e(tFCP_DUPLICATAI, 'PR_TOTDESPESA', 0);
  putitem_e(tFCP_DUPLICATAI, 'VL_TOTDESPESA', 0);
  putitem_e(tFCP_DUPLICATAI, 'PR_RESTDESPESA', 0);
  putitem_e(tFCP_DUPLICATAI, 'VL_RESTDESPESA', 0);

  setocc(tFCP_DUPDESPESA, 1);
  while (xStatus >= 0) do begin
    putitem_e(tFCP_DUPLICATAI, 'PR_TOTDESPESA', item_f('PR_TOTDESPESA', tFCP_DUPLICATAI) + item_f('PR_RATEIO', tFCP_DUPDESPESA));
    putitem_e(tFCP_DUPLICATAI, 'VL_TOTDESPESA', item_f('VL_TOTDESPESA', tFCP_DUPLICATAI) + item_f('VL_RATEIO', tFCP_DUPDESPESA));
    setocc(tFCP_DUPDESPESA, curocc(tFCP_DUPDESPESA) + 1);
  end;
  putitem_e(tFCP_DUPLICATAI, 'PR_RESTDESPESA', 100 - item_f('PR_TOTDESPESA', tFCP_DUPLICATAI));
  putitem_e(tFCP_DUPLICATAI, 'VL_RESTDESPESA', item_f('VL_DUPLICATA', tFCP_DUPLICATAI) - item_f('VL_TOTDESPESA', tFCP_DUPLICATAI));
  setocc(tFCP_DUPDESPESA, 1);

  return(0); exit;
end;

//-------------------------------------------------------------
function TF_FCXFM005.gravaDuplicata(pParams : String) : String;
//-------------------------------------------------------------
const
  cDS_METHOD = 'ADICIONAL=Operação: TF_FCXFM005.gravaDuplicata()';
var
  vDsRegDesp, vDsLinha, viParams, voParams : String;
  vInErro, vInSalva : Boolean;
  vDsLinhaDesp, vDsLinhaImp, vDsAltera : String;
  vCdEmpresa, vCdFornecedor, vNrDuplicata : Real;
  vNrParcela : Real;
begin
  voParams := validaContaUsuario(viParams); (* *)
  if (xStatus < 0) then begin
    Result := voParams;
    return(-1); exit;
  end;

  viParams := '';
  putitemXml(viParams, 'IN_USULOGADO', True);
  putitemXml(viParams, 'CD_USUARIO', itemXmlF('CD_USUARIO', PARAM_GLB));
  putitemXml(viParams, 'DS_COMPONENTE', 'FCXFM005');
  voParams := activateCmp('ADMFM020', 'exec', viParams); (*,,, *)
  if (xStatus < 0) then begin
    Result := voParams;
    return(-1); exit;
  end;

  vInErro := False;

  if (gInSenhaLanctoCx = True) then begin
    viParams := '';
    putitemXml(viParams, 'CD_COMPONENTE', FCXFM005);
    putitemXml(viParams, 'DS_CAMPO', 'APROVA_LANCTO_CX');
    putitemXml(viParams, 'CD_EMPRESA', gModulo.gCdEmpresa);
    putitemXml(viParams, 'CD_USUARIO', gModulo.gCdUsuario);
    putitemXml(viParams, 'VL_VALOR', '');
    voParams := activateCmp('ADMSVCO009', 'VerificaRestricao', viParams); (*,,, *)
    if (xStatus < 0) then begin
      Result := voParams;
      return(-1); exit;
    end;
    gCdUsuEscolhido := itemXmlF('CD_USUARIO', voParams);

  end;

  putitem_e(tFCP_DUPLICATAI, 'DT_CHEGADA', item_a('DT_EMISSAO', tFCP_DUPLICATAI));
  putitem_e(tFCP_DUPLICATAI, 'NR_PORTADOR', itemXmlF('NR_PORTADOR_CARTEIRA', xParam));
  putitem_e(tFCP_DUPLICATAI, 'TP_SITUACAO', 'N');
  putitem_e(tFCP_DUPLICATAI, 'TP_DOCUMENTO', 1);

  if (gTpDuplicataLancDespCx = 1) then begin
    putitem_e(tFCP_DUPLICATAI, 'TP_DOCUMENTO', 15);
  end;

  putitem_e(tFCP_DUPLICATAI, 'TP_BAIXA', 3);
  putitem_e(tFCP_DUPLICATAI, 'TP_INCLUSAO', 3);
  putitem_e(tFCP_DUPLICATAI, 'TP_PREVISAOREAL', 2);
  putitem_e(tFCP_DUPLICATAI, 'TP_ESTAGIO', 90);

  vDsRegDesp := '';
  vDsLinha := '';
  putlistitensocc_e(vDsLinha, tFCP_DUPLICATAI);

  if (empty(tFCP_DUPDESPESA) = False) then begin
    setocc(tFCP_DUPDESPESA, 1);
    while (xStatus >= 0) do begin
      if (item_f('CD_DESPESAITEM', tFCP_DUPDESPESA) <> 0) then begin
        putlistitensocc_e(vDsLinhaDesp, tFCP_DUPDESPESA);
        putitem(vDsRegDesp,  vDsLinhaDesp);
      end;

      setocc(tFCP_DUPDESPESA, curocc(tFCP_DUPDESPESA) + 1);
    end;
  end;

  putitemXml(vDsLinha, 'DS_DUPDESPESA', vDsRegDesp);
  putitemXml(vDsLinha, 'DS_DUPIMPOSTO', '');

  viParams := '';
  putitemXml(viParams, 'DS_DUPLICATAI', vDsLinha);
  putitemXml(viParams, 'DS_COMPONENTE', 'FCXFM005');
  voParams := activateCmp('FCPSVCO001', 'geraDuplicata', viParams); (*,,,, *)
  if (xStatus < 0) then begin
    Result := voParams;
    return(-1); exit;
  end;

  putitem_e(tFCP_DUPLICATAI, 'NR_PARCELA', itemXmlF('NR_PARCELA', voParams));

  if not (empty(tSIS_OBSERVACAO)) then begin
    voParams := gravaObservacaoDuplicata(viParams); (* *)
    if (xStatus < 0) then begin
      Result := voParams;
      return(-1); exit;
    end;
  end;
  if (vInErro = False) then begin
    voParams := geraLiquidacao(viParams); (* *)
    if (xStatus < 0) then begin
      Result := SetStatus(STS_ERROR, {xCdErro} '', '{xCtxErro} ''', '');
      vInErro := True;
    end;
  end;
  if (vInErro = False) then begin
    voParams := geraMovimentoDebito(viParams); (* *)
    if (xStatus < 0) then begin
      Result := SetStatus(STS_ERROR, {xCdErro} '', '{xCtxErro} ''', '');
      vInErro := True;
    end;
  end;
  if (vInErro = False) then begin
    commit;
    if (xStatus < 0) then begin
      rollback;
      return(-1); exit;
    end;
  end else begin
    rollback;
    return(-1); exit;
  end;

  message/info 'Lançamento de despesa no caixa efetuada com sucesso!';

  if (vInErro = False) then begin
    if (gInPdvOtimizado <> True) then begin
      askmess 'Deseja dar manutenção nas observações da duplicata gerada?', 'Sim, Não';
      if (xStatus = 1) then begin
        voParams := chamaObservacao(viParams); (* *)
        if (xStatus < 0) then begin
          Result := voParams;
          return(-1); exit;
        end;
      end;
    end else begin
      voParams := chamaObservacao(viParams); (* *)
      if (xStatus < 0) then begin
        Result := voParams;
        return(-1); exit;
      end;
    end;
    if (gInPdvOtimizado <> True) then begin
      askmess 'Deseja imprimir recibo?', 'Sim, Não';
      if (xStatus = 1) then begin
        voParams := geraRecibo(viParams); (* *)
        if (xStatus < 0) then begin
          Result := voParams;
          return(-1); exit;
        end;
      end;
    end else begin
      voParams := geraRecibo(viParams); (* *)
      if (xStatus < 0) then begin
        Result := voParams;
        return(-1); exit;
      end;
    end;
  end;

  return(0); exit;

end;

//--------------------------------------------------------------
function TF_FCXFM005.chamaObservacao(pParams : String) : String;
//--------------------------------------------------------------
const
  cDS_METHOD = 'ADICIONAL=Operação: TF_FCXFM005.chamaObservacao()';
var
  viParams, voParams : String;
begin
  viParams := '';
  putitemXml(viParams, 'CD_EMPRESA', item_f('CD_EMPRESA', tFCP_DUPLICATAI));
  putitemXml(viParams, 'CD_FORNECEDOR', item_f('CD_FORNECEDOR', tFCP_DUPLICATAI));
  putitemXml(viParams, 'NR_DUPLICATA', item_f('NR_DUPLICATA', tFCP_DUPLICATAI));
  putitemXml(viParams, 'NR_PARCELA', item_f('NR_PARCELA', tFCP_DUPLICATAI));
  voParams := activateCmp('FCPFL003', 'exec', viParams); (*,,, *)
  if (xStatus < 0) then begin
    Result := voParams;
    return(-1); exit;
  end;

  return(0); exit;
end;

//------------------------------------------------------------------
function TF_FCXFM005.geraMovimentoDebito(pParams : String) : String;
//------------------------------------------------------------------
const
  cDS_METHOD = 'ADICIONAL=Operação: TF_FCXFM005.geraMovimentoDebito()';
var
  vCdEmpresa, vNrCtaPesFCC, vNrSeqMovFCC : Real;
  vCdTerminal, vNrSeq, vVlSaldoAnt, vVlSaldoAtualDoc, vVlSaldoAtual, vVlSaldo, vVlSaldoAntDoc : Real;
  viParams, voParams, vDsLstObservacao, vDsAux : String;
  vDtAbertura, vDtMovimFCC : TDate;
begin
  if (NR_CAIXA.DUMMY = 1) then begin
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
  if (gInLogMovCtaPes = True) then begin
    viParams := '';
    putitemXml(viParams, 'NR_CTAPES', NR_CTA.DUMMY);
    putitemXml(viParams, 'DT_SALDO', itemXml('DT_SISTEMA', PARAM_GLB));
    voParams := activateCmp('FCCSVCO002', 'buscaSaldoConta', viParams); (*,,'',,, *)
    if (xStatus < 0) then begin
      Result := voParams;
      return(-1); exit;
    end;
    vVlSaldoAnt := itemXmlF('VL_SALDO', voParams);

    viParams := '';
    putitemXml(viParams, 'NR_CTAPES', NR_CTA.DUMMY);
    putitemXml(viParams, 'TP_DOCUMENTO', 3);
    putitemXml(viParams, 'NR_SEQHISTRELSUB', 1);
    putitemXml(viParams, 'DT_SALDO', itemXml('DT_SISTEMA', PARAM_GLB));
    voParams := activateCmp('FCCSVCO002', 'buscaSaldoCtaTp', viParams); (*,,'',,, *)
    if (xStatus < 0) then begin
      Result := voParams;
      return(-1); exit;
    end;
    vVlSaldoAntDoc := itemXmlF('VL_SALDO', voParams);
  end;

  vDsLstObservacao := '';
  setocc(tSIS_OBSERVACAO, 1);
  while (xStatus >=0) do begin
    if (item_a('DS_OBSERVACAO', tSIS_OBSERVACAO) <> '') then begin
      putitem(vDsLstObservacao,  item_a('DS_OBSERVACAO', tSIS_OBSERVACAO));
    end;

    setocc(tSIS_OBSERVACAO, curocc(tSIS_OBSERVACAO) + 1);
  end;
  vDsAux := '' + CD_FORNECEDOR + '.FCP_DUPLICATAI  - ' + NM_PESSOA + '.V_PES_FORNECEDOR';
  voParams := Converterstring(viParams); (* vDsAux, vDsAux *)
  if (xStatus < 0) then begin
    Result := voParams;
    return(-1); exit;
  end;
  vDsAux := vDsAux[1:60];

  viParams := '';
  putitemXml(viParams, 'CD_EMPRESA', item_f('CD_EMPRESA', tGER_EMPRESA));
  putitemXml(viParams, 'NR_CTAPES', NR_CTA.DUMMY);
  putitemXml(viParams, 'DT_MOVIMENTO', itemXml('DT_SISTEMA', PARAM_GLB));
  putitemXml(viParams, 'CD_HISTORICO', 839);
  putitemXml(viParams, 'TP_DOCUMENTO', 3);
  putitemXml(viParams, 'NR_SEQHISTRELSUB', 1);
  putitemXml(viParams, 'VL_LANCTO', item_f('VL_DUPLICATA', tFCP_DUPLICATAI));
  putitemXml(viParams, 'IN_ESTORNO', False);
  putitemXml(viParams, 'DS_DOC', '' + NR_DUPLICATA + '.FCP_DUPLICATAI/' + NR_PARCELA + '.FCP_DUPLICATAI');
  putitemXml(viParams, 'DS_AUX', vDsAux);
  putitemXml(viParams, 'CD_EMPLIQ', gCdempliq);
  putitemXml(viParams, 'DT_LIQ', gDtliq);
  putitemXml(viParams, 'NR_SEQLIQ', gNrseqliq);
  if (NR_CAIXA.DUMMY = 1) then begin
    putitemXml(viParams, 'IN_CAIXA', True);
    putitemXml(viParams, 'CD_TERMINAL', vCdTerminal);
    putitemXml(viParams, 'DT_ABERTURA', vDtAbertura);
    putitemXml(viParams, 'NR_SEQCAIXA', vNrSeq);
  end else begin
    putitemXml(viParams, 'IN_CAIXA', False);
  end;

  putitemXml(viParams, 'CD_COMPONENTE', FCXFM005);
  putitemXml(viParams, 'LST_OBS', vDsLstObservacao);

  voParams := activateCmp('FCCSVCO002', 'movimentaConta', viParams); (*,,,,, *)
  if (xStatus < 0) then begin
    Result := voParams;
    return(-1); exit;
  end;
  if (gInLogMovCtaPes = True) then begin
    vNrCtaPesFCC := itemXmlF('NR_CTAPES', voParams);
    vDtMovimFCC := itemXml('DT_MOVIM', voParams);
    vNrSeqMovFCC := itemXmlF('NR_SEQMOV', voParams);

    viParams := '';
    putitemXml(viParams, 'NR_CTAPES', NR_CTA.DUMMY);
    putitemXml(viParams, 'DT_SALDO', itemXml('DT_SISTEMA', PARAM_GLB));
    voParams := activateCmp('FCCSVCO002', 'buscaSaldoConta', viParams); (*,,'',,, *)
    if (xStatus < 0) then begin
      Result := voParams;
      return(-1); exit;
    end;
    vVlSaldoAtual := itemXmlF('VL_SALDO', voParams);

    viParams := '';
    putitemXml(viParams, 'NR_CTAPES', NR_CTA.DUMMY);
    putitemXml(viParams, 'TP_DOCUMENTO', 3);
    putitemXml(viParams, 'NR_SEQHISTRELSUB', 1);
    putitemXml(viParams, 'DT_SALDO', itemXml('DT_SISTEMA', PARAM_GLB));
    voParams := activateCmp('FCCSVCO002', 'buscaSaldoCtaTp', viParams); (*,,'',,, *)
    if (xStatus < 0) then begin
      Result := voParams;
      return(-1); exit;
    end;
    vVlSaldoAtualDoc := itemXmlF('VL_SALDO', voParams);

    viParams := '';
    putitemXml(viParams, 'TP_PROCESSO', 1);
    putitemXml(viParams, 'TP_DOCUMENTO', 3);
    putitemXml(viParams, 'NR_CTAPES', NR_CTA.DUMMY);
    putitemXml(viParams, 'VL_LANCAMENTO', item_f('VL_DUPLICATA', tFCP_DUPLICATAI));
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

  return(0); exit;
end;

//-------------------------------------------------------------
function TF_FCXFM005.geraLiquidacao(pParams : String) : String;
//-------------------------------------------------------------
const
  cDS_METHOD = 'ADICIONAL=Operação: TF_FCXFM005.geraLiquidacao()';
var
  viParams, voParams : String;
begin
  gCdempliq := '';
  gDtliq := '';
  gNrseqliq := '';
  viParams := '';
  putitemXml(viParams, 'NR_CTAPES', NR_CTA.DUMMY);
  putitemXml(viParams, 'CD_EMPRESA', item_f('CD_EMPRESA', tFCP_DUPLICATAI));
  putitemXml(viParams, 'CD_FORNECEDOR', item_f('CD_FORNECEDOR', tFCP_DUPLICATAI));
  putitemXml(viParams, 'NR_DUPLICATA', item_f('NR_DUPLICATA', tFCP_DUPLICATAI));
  putitemXml(viParams, 'NR_PARCELA', item_f('NR_PARCELA', tFCP_DUPLICATAI));
  putitemXml(viParams, 'VL_PAGAMENTO', item_f('VL_DUPLICATA', tFCP_DUPLICATAI));
  putitemXml(viParams, 'VL_DESCONTO', 0);
  putitemXml(viParams, 'VL_JUROS', 0);
  putitemXml(viParams, 'TP_BAIXA', 3);
  putitemXml(viParams, 'CD_PESSOA', item_f('CD_FORNECEDOR', tFCP_DUPLICATAI));
  putitemXml(viParams, 'VL_TOTAL', item_f('VL_DUPLICATA', tFCP_DUPLICATAI));
  putitemXml(viParams, 'TP_LIQUIDACAO', 26);
  putitemXml(viParams, 'TP_PAGAMENTO', 1);

  voParams := activateCmp('FGRSVCO008', 'geraLiquidacao', viParams); (*,,,, *)
  if (xStatus < 0) then begin
    Result := voParams;
    return(-1); exit;
  end;

  gCdempliq := itemXmlF('CD_EMPLIQ', voParams);
  gDtliq := itemXml('DT_LIQ', voParams);
  gNrseqliq := itemXmlF('NR_SEQLIQ', voParams);

  return(0); exit;
end;

//---------------------------------------------------------
function TF_FCXFM005.geraRecibo(pParams : String) : String;
//---------------------------------------------------------
const
  cDS_METHOD = 'ADICIONAL=Operação: TF_FCXFM005.geraRecibo()';
var
  vFiltro, viParams, voParams, vDsConteudo, vDsRegistro, vDsLstDespesa : String;
  vTpObservacao : Real;
  vInObsDia : Boolean;
begin
  vDsConteudo := '';
  if (item_f('VL_DUPLICATA', tFCP_DUPLICATAI) = 0)  and (item_f('CD_FORNECEDOR', tFCP_DUPLICATAI) = 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN001', 'Nada a imprimir!', '');
    return(-1); exit;
  end;

  clear_e(tGER_MODFINC);
  putitem_e(tGER_MODFINC, 'NR_MODFINC', itemXmlF('CD_RECIBO_PGTODESP', xParamEmp));
  retrieve_e(tGER_MODFINC);
  if (xStatus < 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN001', 'Modelo de recibo informado não encontrado.', '');
    return(-1); exit;
  end;

  vFiltro := '';
  viParams := '';

  vDsLstDespesa := '';
  setocc(tFCP_DUPDESPESA, 1);
  while (xStatus >= 0) do begin
    vDsRegistro := '';
    putitemXml(vDsRegistro, 'CD_DESPESA', item_f('CD_DESPESAITEM', tFCP_DESPESAITEM));
    putitemXml(vDsRegistro, 'DS_DESPESA', item_a('DS_DESPESAITEM', tFCP_DESPESAITEM));
    putitem(vDsLstDespesa,  vDsRegistro);
    setocc(tFCP_DUPDESPESA, curocc(tFCP_DUPDESPESA) + 1);
  end;

  vInObsDia := False;
  clear_e(tGER_MODFINI);
  putitem_e(tGER_MODFINI, 'NR_MODFINC', item_f('NR_MODFINC', tGER_MODFINC));
  putitem_e(tGER_MODFINI, 'CD_CAMPO', '>= 301 ) and (<= 305');
  retrieve_e(tGER_MODFINI);
  if (xStatus >= 0) then begin
    clear_e(tOBS_DUPI);
    putitem_e(tOBS_DUPI, 'CD_EMPRESA', item_f('CD_EMPRESA', tFCP_DUPLICATAI));
    putitem_e(tOBS_DUPI, 'CD_FORNECEDOR', item_f('CD_FORNECEDOR', tFCP_DUPLICATAI));
    putitem_e(tOBS_DUPI, 'NR_DUPLICATA', item_f('NR_DUPLICATA', tFCP_DUPLICATAI));
    putitem_e(tOBS_DUPI, 'NR_PARCELA', item_f('NR_PARCELA', tFCP_DUPLICATAI));
    retrieve_e(tOBS_DUPI);
    if (xStatus >= 0) then begin
      if (gInPDvOtimizado <> True) then begin
        askmess 'Imprimir observação somente do dia?', 'Sim, Não';
        if (xStatus = 1) then begin
          vInObsDia := True;
        end;
      end else begin
        vInObsDia := True;
      end;
    end;
  end;

  putitemXml(viParams, 'NR_MODFIN', item_f('NR_MODFINC', tGER_MODFINC));
  putitemXml(viParams, 'DT_EMISSAO', itemXml('DT_SISTEMA', PARAM_GLB));
  putitemXml(viParams, 'CD_EMPRESA', item_f('CD_EMPRESA', tFCP_DUPLICATAI));
  putitemXml(viParams, 'CD_FORNECEDOR', item_f('CD_FORNECEDOR', tFCP_DUPLICATAI));
  putitemXml(viParams, 'NR_DUPLICATA', item_f('NR_DUPLICATA', tFCP_DUPLICATAI));
  putitemXml(viParams, 'NR_PARCELA', item_f('NR_PARCELA', tFCP_DUPLICATAI));
  putitemXml(viParams, 'VL_RECIBO', item_f('VL_DUPLICATA', tFCP_DUPLICATAI));
  putitemXml(viParams, 'CD_PESSOA', item_f('CD_FORNECEDOR', tFCP_DUPLICATAI));
  putitemXml(viParams, 'IN_OBSDIA', vInObsDia);
  putitemXml(viParams, 'CD_USULOGADO', itemXmlF('CD_USUARIO', PARAM_GLB));
  putitemXml(viParams, 'CD_USUESCOLHIDO', gCdUsuEscolhido);
  putitemXml(viParams, 'NR_CTAPES', NR_CTA.DUMMY);
  putitemXml(viParams, 'DT_SISTEMA', itemXml('DT_SISTEMA', PARAM_GLB));
  putitemXml(viParams, 'DS_LSTDESPESA', vDsLstDespesa);

  voParams := activateCmp('GERSVCO028', 'geraReciboAvulso', viParams); (*,,,, *)
  if (xStatus < 0) then begin
    Result := voParams;
    return(-1); exit;
  end;

  vDsConteudo := itemXml('DS_CONTEUDO', voParams);

  if (item_a('NM_JOB', tGER_MODFINC) = 'P_LPT1')  or (item_a('NM_JOB', tGER_MODFINC) = 'P_LN03') then begin
    filedump vDsConteudo, 'LPT1';
    if (xStatus < 0) then begin
      Result := SetStatus(STS_ERROR, 'GEN0001', 'Erro ' + xStatus + ' ao imprimir por cópia na LPT1!', '');
      return(-1); exit;
    end;
  end else if (item_a('NM_JOB', tGER_MODFINC) = 'P_LPT2')  or (item_a('NM_JOB', tGER_MODFINC) = 'P_PORT2') then begin
    filedump vDsConteudo, 'LPT2';
    if (xStatus < 0) then begin
      Result := SetStatus(STS_ERROR, 'GEN0001', 'Erro ' + xStatus + ' ao imprimir por cópia na LPT2!', '');
      return(-1); exit;
    end;
  end else if (item_a('NM_JOB', tGER_MODFINC) = 'P_LPT3') then begin
    filedump vDsConteudo, 'LPT3';
    if (xStatus < 0) then begin
      Result := SetStatus(STS_ERROR, 'GEN0001', 'Erro ' + xStatus + ' ao imprimir por cópia na LPT3!', '');
      return(-1); exit;
    end;
  end else if (item_a('NM_JOB', tGER_MODFINC) = 'P_LPT4') then begin
    filedump vDsConteudo, 'LPT4';
    if (xStatus < 0) then begin
      Result := SetStatus(STS_ERROR, 'GEN0001', 'Erro ' + xStatus + ' ao imprimir por cópia na LPT4!', '');
      return(-1); exit;
    end;
  end else if (item_a('NM_JOB', tGER_MODFINC) = 'P_LPT5') then begin
    filedump vDsConteudo, 'LPT5';
    if (xStatus < 0) then begin
      Result := SetStatus(STS_ERROR, 'GEN0001', 'Erro ' + xStatus + ' ao imprimir por cópia na LPT5!', '');
      return(-1); exit;
    end;
  end else if (item_a('NM_JOB', tGER_MODFINC) = 'P_LPT6') then begin
    filedump vDsConteudo, 'LPT6';
    if (xStatus < 0) then begin
      Result := SetStatus(STS_ERROR, 'GEN0001', 'Erro ' + xStatus + ' ao imprimir por cópia na LPT6!', '');
      return(-1); exit;
    end;
  end else if (item_a('NM_JOB', tGER_MODFINC) = 'P_LPT7') then begin
    filedump vDsConteudo, 'LPT7';
    if (xStatus < 0) then begin
      Result := SetStatus(STS_ERROR, 'GEN0001', 'Erro ' + xStatus + ' ao imprimir por cópia na LPT7!', '');
      return(-1); exit;
    end;
  end else if (item_a('NM_JOB', tGER_MODFINC) = 'P_LPT8') then begin
    filedump vDsConteudo, 'LPT8';
    if (xStatus < 0) then begin
      Result := SetStatus(STS_ERROR, 'GEN0001', 'Erro ' + xStatus + ' ao imprimir por cópia na LPT8!', '');
      return(-1); exit;
    end;
  end else if (item_a('NM_JOB', tGER_MODFINC) = 'P_LPT9') then begin
    filedump vDsConteudo, 'LPT9';
    if (xStatus < 0) then begin
      Result := SetStatus(STS_ERROR, 'GEN0001', 'Erro ' + xStatus + ' ao imprimir por cópia na LPT9!', '');
      return(-1); exit;
    end;
  end else begin
    viParams := '';
    putitemXml(viParams, 'DS_CHEQUE', vDsConteudo);
    putitemXml(viParams, 'NM_JOB', item_a('NM_JOB', tGER_MODFINC));
    putitemXml(viParams, 'IN_PREVIEW', True);
    voParams := activateCmp('FCCR002', 'exec', viParams); (*,,,, *)
    if (xStatus < 0) then begin
      Result := voParams;
      return(-1); exit;
    end;
  end;

  return(0); exit;
end;

//----------------------------------------------------------
function TF_FCXFM005.valorPadrao(pParams : String) : String;
//----------------------------------------------------------
const
  cDS_METHOD = 'ADICIONAL=Operação: TF_FCXFM005.valorPadrao()';
var
  vCaixa, viParams, voParams : String;
  vVlInicial : Real;
  vTpManutUsu, vTpManutFilial, vTpManutMatriz : Real;
  vNrCtaUsuario, vNrCtaFilial, vNrCtaMatriz : Real;
begin
  clear_e(tGER_EMPRESA);
  putitem_e(tGER_EMPRESA, 'CD_EMPRESA', itemXmlF('CD_EMPRESA', PARAM_GLB));
  retrieve_e(tGER_EMPRESA);
  if (xStatus < 0) then begin
    message/info 'Empresa não encontrada!';
    return(0); exit;
  end;

  viParams := '';
  voParams := activateCmp('FCCSVCO002', 'buscaContaOperador', viParams); (*,,,, *)
  if (xStatus < 0) then begin
    Result := voParams;
    return(-1); exit;
  end;
  if (voParams = '') then begin
    message/info 'Nenhuma conta liberada para o usuario!';
    return(-1); exit;
  end;

  vNrCtaUsuario := itemXmlF('NR_CTAPES_CXUSUARIO', voParams);
  vNrCtaFilial := itemXmlF('NR_CTAPES_CXFILIAL', voParams);
  vNrCtaMatriz := itemXmlF('NR_CTAPES_CXMATRIZ', voParams);

  vCaixa := '';
  if (vNrCtaUsuario > 0) then begin
    viParams := '';
    voParams := activateCmp('FCXSVCO001', 'buscaCaixa', viParams); (*,,,, *)
    if (xStatus < 0) then begin
      Result := voParams;
      return(-1); exit;
    end;
      vVlInicial := 1;
      NR_CTA.DUMMY := gNrCtaPes;
    end;
  end;
  if (vNrCtaFilial >= 0) then begin
    putitemXml(vCaixa, '2', 'Filial');
    if (vVlInicial = 0) then begin
      vVlInicial := 2;
      NR_CTA.DUMMY := itemXmlF('CD_CTAPES_CXFILIAL', xParamEmp);
    end;
  end;
  if (vNrCtaMatriz > 0) then begin
    putitemXml(vCaixa, '3', 'Matriz');
    if (vVlInicial = 0) then begin
      vVlInicial := 3;
      NR_CTA.DUMMY := itemXmlF('CD_CTAPES_CXMATRIZ', xParamEmp);
    end;
  end;

  valrep (NR_CAIXA.DUMMY) := vCaixa;
  NR_CAIXA.DUMMY := vVlInicial;

  if (itemXml('IN_PDV', viParams) = True ) and (gInPdvOtimizado = True) then begin
    if (itemXml('CD_PESSOA_DESPESA', xParamEmp) <> '') then begin
      putitem_e(tV_PES_FORNECEDOR, 'CD_FORNECEDOR', itemXmlF('CD_PESSOA_DESPESA', xParamEmp));
      retrieve_e(tV_PES_FORNECEDOR);
      if (xStatus < 0) then begin
        Result := SetStatus(STS_ERROR, 'GEN0001', 'Código do fornecedor cadastrado no parâmetro empresa CD_PESSOA_DESPESA não está cadastrado como fornecedor!', '');
      end;

      gprompt := item_f('NR_DUPLICATA', tFCP_DUPLICATAC);
    end else begin
      gprompt := item_f('CD_FORNECEDOR', tV_PES_FORNECEDOR);
    end;
    if (itemXml('CD_CONTA_DESPESA', xParamEmp) <> '') then begin
      putitem_e(tFCP_DESPESAITEM, 'CD_DESPESAITEM', itemXmlF('CD_CONTA_DESPESA', xParamEmp));
      retrieve_e(tFCP_DESPESAITEM);
      if (xStatus < 0) then begin
        Result := SetStatus(STS_ERROR, 'GEN0001', 'Código da despesa cadastrado no parâmetro empresa CD_CONTA_DESPESA inválida!', '');
      end else begin
        putitem_e(tFCP_DUPDESPESA, 'PR_RATEIO', 100);
      end;
    end;

    putitem_e(tFCP_DUPLICATAI, 'DT_EMISSAO', itemXml('DT_SISTEMA', PARAM_GLB));
    putitem_e(tFCP_DUPLICATAI, 'DT_VENCIMENTO', itemXml('DT_SISTEMA', PARAM_GLB));
  end;

  return(0); exit;
end;

//-----------------------------------------------------------------
function TF_FCXFM005.validaContaUsuario(pParams : String) : String;
//-----------------------------------------------------------------
const
  cDS_METHOD = 'ADICIONAL=Operação: TF_FCXFM005.validaContaUsuario()';
var
  viParams, voParams : String;
begin
  if (nr_cta.dummy = '')  or (nr_cta.dummy = 0) then begin
    return(0); exit;
  end;
  viParams := '';
  putitemXml(viParams, 'CD_USUARIO', itemXmlF('CD_USUARIO', PARAM_GLB));
  putitemXml(viParams, 'NR_CTAPES', nr_cta.dummy);
  voParams := activateCmp('FCCSVCO014', 'validaContaUsuario', viParams); (*,,,, *)
  if (xStatus < 0) then begin
    Result := voParams;
    return(-1); exit;
  end;

  return(0); exit;
end;

//----------------------------------------------------------------
function TF_FCXFM005.validaCentroCusto(pParams : String) : String;
//----------------------------------------------------------------
const
  cDS_METHOD = 'ADICIONAL=Operação: TF_FCXFM005.validaCentroCusto()';
begin
  clear_e(tGEC_CCUSTO);
  putitem_e(tGEC_CCUSTO, 'CD_CCUSTO', item_f('CD_CCUSTO', tFCP_DUPDESPESA));
  retrieve_e(tGEC_CCUSTO);
  if (xStatus < 0) then begin
    Result := SetStatus(STS_AVISO, 'GEN001', 'Código do centro de custo não cadastrado.', '');
    gprompt := item_f('CD_CCUSTO', tFCP_DUPDESPESA);
    return(-1); exit;
  end;
  return(0); exit;
end;

//-----------------------------------------------------------------------
function TF_FCXFM005.carregaDespesaFornecedor(pParams : String) : String;
//-----------------------------------------------------------------------
const
  cDS_METHOD = 'ADICIONAL=Operação: TF_FCXFM005.carregaDespesaFornecedor()';
begin
  clear_e(tFCP_FORNDESP);
  putitem_e(tFCP_FORNDESP, 'CD_EMPRESA', item_f('CD_EMPRESA', tFCP_DUPLICATAI));
  putitem_e(tFCP_FORNDESP, 'CD_FORNECEDOR', item_f('CD_FORNECEDOR', tFCP_DUPLICATAI));
  retrieve_e(tFCP_FORNDESP);
  if (xStatus >= 0) then begin
    setocc(tFCP_FORNDESP, 1);
    while (xStatus >= 0) do begin
      creocc(tFCP_DUPDESPESA, -1);
      putitem_e(tFCP_DUPDESPESA, 'CD_EMPRESA', item_f('CD_EMPRESA', tFCP_DUPLICATAI));
      putitem_e(tFCP_DUPDESPESA, 'CD_FORNECEDOR', item_f('CD_FORNECEDOR', tFCP_DUPLICATAI));
      putitem_e(tFCP_DUPDESPESA, 'NR_DUPLICATA', item_f('NR_DUPLICATA', tFCP_DUPLICATAI));
      putitem_e(tFCP_DUPDESPESA, 'NR_PARCELA', item_f('NR_PARCELA', tFCP_DUPLICATAI));
      putitem_e(tFCP_DESPESAITEM, 'CD_DESPESAITEM', item_f('CD_DESPESAITEM', tFCP_FORNDESP));
      putitem_e(tFCP_DUPDESPESA, 'CD_DESPESAITEM', item_f('CD_DESPESAITEM', tFCP_FORNDESP));
      retrieve_e(tFCP_DESPESAITEM);
      putitem_e(tFCP_DUPDESPESA, 'PR_RATEIO', item_f('PR_RATEIO', tFCP_FORNDESP));

      if (item_f('CD_DESPESAITEM', tFCP_DESPESAITEM) <> '')  and (gTpLancDespFcp = 2) then begin
        if (item_f('CD_CCUSTO', tFCP_DUPDESPESA) = 0)  or (item_f('CD_CCUSTO', tFCP_DUPDESPESA) = '') then begin
          putitem_e(tFCP_DUPDESPESA, 'CD_CCUSTO', gCdCCustoPadraoFcp);
        end;

        fieldsyntax item_f('CD_CCUSTO', tFCP_DUPDESPESA), 'DIM';
      end;

      setocc(tFCP_FORNDESP, curocc(tFCP_FORNDESP) + 1);
    end;
  end;

  return(0); exit;
end;

//-----------------------------------------------------------------------
function TF_FCXFM005.gravaObservacaoDuplicata(pParams : String) : String;
//-----------------------------------------------------------------------
const
  cDS_METHOD = 'ADICIONAL=Operação: TF_FCXFM005.gravaObservacaoDuplicata()';
var
  viParams, voParams : String;
begin
  setocc(tSIS_OBSERVACAO, 1);

  while (xStatus >=0) do begin
    if (item_a('DS_OBSERVACAO', tSIS_OBSERVACAO) <> '') then begin
      viParams := '';
      putitemXml(viParams, 'CD_EMPRESA', item_f('CD_EMPRESA', tFCP_DUPLICATAI));
      putitemXml(viParams, 'CD_FORNECEDOR', item_f('CD_FORNECEDOR', tFCP_DUPLICATAI));
      putitemXml(viParams, 'NR_DUPLICATA', item_f('NR_DUPLICATA', tFCP_DUPLICATAI));
      putitemXml(viParams, 'NR_PARCELA', item_f('NR_PARCELA', tFCP_DUPLICATAI));
      putitemXml(viParams, 'IN_MANUTENCAO', False);
      putitemXml(viParams, 'DS_OBS', item_a('DS_OBSERVACAO', tSIS_OBSERVACAO));
      putitemXml(viParams, 'DS_COMPONENTE', 'FCXFM005');
      voParams := activateCmp('FCPSVCO001', 'gravaObsDuplicata', viParams); (*,,,, *)
      if (xStatus < 0) then begin
        Result := SetStatus(STS_ERROR, xProcerror, 'xProcerrorcontext', '');
        return(-1); exit;
      end;
    end;

    setocc(tSIS_OBSERVACAO, curocc(tSIS_OBSERVACAO) + 1);
  end;

  return(0); exit;
end;

end.
