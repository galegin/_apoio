unit fTRAFP005;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, fFormTouch, ExtCtrls, cPanel, cDatasetUnf, fDialogTouch;

type
  TF_TRAFP005 = class(T_FormTouch)
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
  private
    tF_TRA_TRANSACAO,
    tGER_OPERACAO,
    tR_TRA_TRANSACAO,
    tSIS_BOTOES,
    tTRA_LIMDESCONTO,
    tTRA_TRANSACAO,
    tTRA_TRANSITEM : TcDatasetUnf;
    function getParam(pParams : String = '') : String;
    function setEntidade(pParams : String = '') : String;
    function preEDIT(pParams : String = '') : String;
    function posEDIT(pParams : String = '') : String;
    function posCLEAR(pParams : String = '') : String;
    function preEDIT(pParams : String = '') : String;
    function prePRINT(pParams : String = '') : String;
    function INIT(pParams : String = '') : String;
    function CLEANUP(pParams : String = '') : String;
    function consultaFichaCliente(pParams : String = '') : String;
    function encerraTransacao(pParams : String = '') : String;
    function recebeTransacao(pParams : String = '') : String;
    function agrupaTransacao(pParams : String = '') : String;
    function valorPadrao(pParams : String = '') : String;
    function agrupaTraRecebto(pParams : String = '') : String;
    function operacaoTEF(pParams : String = '') : String;
    function venda(pParams : String = '') : String;
    function imprimirTransacao(pParams : String = '') : String;
    function detalheTransacao(pParams : String = '') : String;
    function recebeFatura(pParams : String = '') : String;
    function desbloqueiaTransacao(pParams : String = '') : String;
    function desconto(pParams : String = '') : String;
    function observacao(pParams : String = '') : String;
    function volume(pParams : String = '') : String;
    function recarregaTransacao(pParams : String = '') : String;
    function carregaFormaPagamento(pParams : String = '') : String;
    function verificaTransacaoAberta(pParams : String = '') : String;
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
  gCdEmpresa,
  gCdModeloMinuta,
  gCdModImpRecebTra,
  gCdModRichTextVD,
  gCdOperacaoVenda,
  gCdUsuarioDesc,
  gDtTransacao,
  gInBloqDesItemProm,
  gInDireto,
  gInFichaNova,
  gInImobiliaria,
  gInSimuladorCondPgto,
  gInSimuladorProduto,
  gnmJobMinuta,
  gNrTransacao,
  gTpCancelaTraAndamento,
  gTpConsultaSaldoCredev,
  gTpFatMin,
  gTpImpEtiqExpVd,
  gTpImpressaoNFVenda,
  gTpImpRichTextVD,
  gTpImpTraVd,
  gTpSimuladorFat,
  gTpTrocoMaximo,
  gTpVerifCupomImpresso,
  gxCdNivel : String;

procedure TF_TRAFP005.FormCreate(Sender: TObject);
begin
  inherited; //
  setEntidade();
end;

procedure TF_TRAFP005.FormShow(Sender: TObject);
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

procedure TF_TRAFP005.FormActivate(Sender: TObject);
begin
  inherited; //
end;

procedure TF_TRAFP005.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  inherited; //
end;

//---------------------------------------------------------------
function TF_TRAFP005.getParam(pParams : String = '') : String;
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
function TF_TRAFP005.setEntidade(pParams : String = '') : String;
//---------------------------------------------------------------
begin
  tF_TRA_TRANSACAO := TcDatasetUnf.GetEntidade(Self, 'F_TRA_TRANSACAO');
  tGER_OPERACAO := TcDatasetUnf.GetEntidade(Self, 'GER_OPERACAO');
  tR_TRA_TRANSACAO := TcDatasetUnf.GetEntidade(Self, 'R_TRA_TRANSACAO');
  tSIS_BOTOES := TcDatasetUnf.GetEntidade(Self, 'SIS_BOTOES');
  tTRA_LIMDESCONTO := TcDatasetUnf.GetEntidade(Self, 'TRA_LIMDESCONTO');
  tTRA_TRANSACAO := TcDatasetUnf.GetEntidade(Self, 'TRA_TRANSACAO');
  tTRA_TRANSITEM := TcDatasetUnf.GetEntidade(Self, 'TRA_TRANSITEM');
end;

//---------------------------------------------------------------
function TF_TRAFP005.preEDIT(pParams : String) : String;
//---------------------------------------------------------------
const
  cDS_METHOD = 'ADICIONAL=Operação: TF_TRAFP005.preEDIT()';
begin
  return(0); exit;
end;

//---------------------------------------------------------------
function TF_TRAFP005.posEDIT(pParams : String) : String;
//---------------------------------------------------------------
const
  cDS_METHOD = 'ADICIONAL=Operação: TF_TRAFP005.posEDIT()';
begin
  return(0); exit;
end;

//-------------------------------------------------------
function TF_TRAFP005.posCLEAR(pParams : String) : String;
//-------------------------------------------------------
const
  cDS_METHOD = 'ADICIONAL=Operação: TF_TRAFP005.posCLEAR()';
begin
  voParams := valorPadrao(viParams); (* *)
  if (xStatus < 0) then begin
    Result := voParams;
    return(-1); exit;
  end;

  return(0); exit;
end;

//------------------------------------------------------
function TF_TRAFP005.preEDIT(pParams : String) : String;
//------------------------------------------------------
const
  cDS_METHOD = 'ADICIONAL=Operação: TF_TRAFP005.preEDIT()';
begin
  gCdEmpresa := itemXmlF('CD_EMPRESA', viParams);
  gNrTransacao := itemXmlF('NR_TRANSACAO', viParams);
  gDtTransacao := itemXml('DT_TRANSACAO', viParams);
  gInDireto := itemXmlB('IN_DIRETO', viParams);

  voParams := valorPadrao(viParams); (* *)
  if (xStatus < 0) then begin
    Result := voParams;
    return(-1); exit;
  end;
  if (gTpCancelaTraAndamento = 1)  and (gCdOperacaoVenda > 0) then begin
    clear_e(tGER_OPERACAO);
    putitem_e(tGER_OPERACAO, 'CD_OPERACAO', gCdOperacaoVenda);
    retrieve_e(tGER_OPERACAO);
    if (xStatus >= 0) then begin
      if (item_f('TP_DOCTO', tGER_OPERACAO) = 3) then begin
        voParams := verificaTransacaoAberta(viParams); (* *)
        if (xStatus < 0) then begin
          Result := voParams;
          return(-1); exit;
        end;
      end;
    end;
  end;
  if (gInDireto = True)  and (dbocc(t'TRA_TRANSACAO')) then begin
    if (item_f('TP_SITUACAO', tTRA_TRANSACAO) = 1 ) or (item_f('TP_SITUACAO', tTRA_TRANSACAO) = 2) then begin
      gprompt := item_a('BT_ENCERRAR', tSIS_BOTOES);
      macro '^DETAIL';
    end else if (item_f('TP_SITUACAO', tTRA_TRANSACAO) = 5) then begin
      gprompt := item_a('BT_RECEBER', tSIS_BOTOES);
      macro '^DETAIL';
    end;
  end;

  return(0); exit;
end;

//-------------------------------------------------------
function TF_TRAFP005.prePRINT(pParams : String) : String;
//-------------------------------------------------------
const
  cDS_METHOD = 'ADICIONAL=Operação: TF_TRAFP005.prePRINT()';
var
  viParams, voParams, vDsLstTransacao, vDsRegistro, vDsFiltro : String;
begin
  if (empty(tTRA_TRANSACAO) <> False) then begin
    return(-1); exit;
  end;

  viParams := '';
  vDsLstTransacao := '';
  vDsRegistro := '';
  putitemXml(vDsRegistro 'CD_EMPRESA', item_f('CD_EMPRESA', tTRA_TRANSACAO));
  putitemXml(vDsRegistro 'NR_TRANSACAO', item_f('NR_TRANSACAO', tTRA_TRANSACAO));
  putitemXml(vDsRegistro 'DT_TRANSACAO', item_a('DT_TRANSACAO', tTRA_TRANSACAO));
  putitem(vDsLstTransacao,  vDsRegistro);
  putitemXml(viParams, 'DS_LSTTRANSACAO', vDsLstTransacao);

  if (item_f('TP_SITUACAO', tTRA_TRANSACAO) = 4)  and (gTpImpTraVd = 07 ) or (gTpImpTraVd = 08) then begin
    voParams := activateCmp('SISFP002', 'exec', viParams); (*'TRAR016',vDsFiltro,,,, *)
    if (xStatus < 0) then begin
      Result := voParams;
      return(-1); exit;
    end;
  end else begin

    voParams := activateCmp('TRAFP004', 'EXEC', viParams); (*,,, *)
  end;
  if (xStatus >= 0) then begin
    commit;
    if (xStatus < 0) then begin
      rollback;
      return(-1); exit;
    end else begin
      voParams := SetHint(viParams); (* 'ID=APLINFO002' *)
    end;
  end else begin
    rollback;
    return(-1); exit;
  end;

  return(0); exit;
end;

//---------------------------------------------------
function TF_TRAFP005.INIT(pParams : String) : String;
//---------------------------------------------------
const
  cDS_METHOD = 'ADICIONAL=Operação: TF_TRAFP005.INIT()';
begin
  _Caption := '' + TRAFP + '005 - Continuação de Transação de Venda';

  xParam := '';
  putitem(xParam,  'IN_FICHA_NOVO');
  xParam := T_ADMSVCO001.GetParametro(xParam); (*xParam,xParam,, *)
  gInFichaNova := itemXmlB('IN_FICHA_NOVO', xParam);

  xParamEmp := '';
  putitem(xParamEmp,  'TP_IMPRESSAO_NF_VD');
  putitem(xParamEmp,  'IN_IMOBILIARIA');
  putitem(xParamEmp,  'IN_BLOQ_DESC_ITEM_PROM');
  putitem(xParamEmp,  'TP_IMP_ETIQ_EXP_VD');
  putitem(xParamEmp,  'TP_IMPRESSAO_TRA_VD');
  putitem(xParamEmp,  'CD_MODELONF_MINUTA');
  putitem(xParamEmp,  'JOB_IMPRESSAO_MINUTA_EXP');
  putitem(xParamEmp,  'TP_SIMULADOR_FAT');
  putitem(xParamEmp,  'CD_COMPONENTE_VendA');
  putitem(xParamEmp,  'IN_SIMULADOR_FAT_PRODUTO');
  putitem(xParamEmp,  'TP_IMP_PACKING_NF_PED');
  putitem(xParamEmp,  'IN_SIMULADOR_COND_PGTO');
  putitem(xParamEmp,  'CD_MOD_RICHTEXT_VD');
  putitem(xParamEmp,  'TP_IMP_RICHTEXT_VD');
  putitem(xParamEmp,  'TP_CONSULTA_SALDO_CREDEV');
  putitem(xParamEmp,  'CD_MOD_IMP_RECEBTRA');
  putitem(xParamEmp,  'TP_UTILIZA_FAT_MIN_REGIAO');
  putitem(xParamEmp,  'CD_OPER_ECF');
  putitem(xParamEmp,  'TP_CANCELA_TRA_ANDAMENTO');
  putitem(xParamEmp,  'TP_VERIF_CUPOM_IMPRESSO');
  xParamEmp := T_ADMSVCO001.GetParamEmpresa(piCdEmpresa, xParamEmp); (*itemXml('CD_EMPRESA', *)

  gTpImpressaoNFVenda := itemXmlF('TP_IMPRESSAO_NF_VD', xParamEmp);
  gInImobiliaria := itemXmlB('IN_IMOBILIARIA', xParamEmp);
  gInBloqDesItemProm := itemXmlB('IN_BLOQ_DESC_ITEM_PROM', xParamEmp);

  gTpImpEtiqExpVd := itemXmlF('TP_IMP_ETIQ_EXP_VD', xParamEmp);
  gTpImpTraVd := itemXmlF('TP_IMPRESSAO_TRA_VD', xParamEmp);
  gCdModeloMinuta := itemXmlF('CD_MODELONF_MINUTA', xParamEmp);
  gnmJobMinuta := itemXml('JOB_IMPRESSAO_MINUTA_EXP', xParamEmp);
  gTpSimuladorFat := itemXmlF('TP_SIMULADOR_FAT', xParamEmp);
  gInSimuladorProduto := itemXmlB('IN_SIMULADOR_FAT_PRODUTO', xParamEmp);
  gInSimuladorCondPgto := itemXmlB('IN_SIMULADOR_COND_PGTO', xParamEmp);
  gCdModRichTextVD := itemXmlF('CD_MOD_RICHTEXT_VD', xParamEmp);
  gTpImpRichTextVD := itemXmlF('TP_IMP_RICHTEXT_VD', xParamEmp);
  gTpConsultaSaldoCredev := itemXmlF('TP_CONSULTA_SALDO_CREDEV', xParamEmp);
  gCdModImpRecebTra := itemXmlF('CD_MOD_IMP_RECEBTRA', xParamEmp);
  gTpFatMin := itemXmlF('TP_UTILIZA_FAT_MIN_REGIAO', xParamEmp);
  gCdOperacaoVenda := itemXmlF('CD_OPER_ECF', xParamEmp);
  gTpCancelaTraAndamento := itemXmlF('TP_CANCELA_TRA_ANDAMENTO', xParamEmp);
  gTpVerifCupomImpresso := itemXmlF('TP_VERIF_CUPOM_IMPRESSO', xParamEmp);

  return(0); exit;
end;

//------------------------------------------------------
function TF_TRAFP005.CLEANUP(pParams : String) : String;
//------------------------------------------------------
const
  cDS_METHOD = 'ADICIONAL=Operação: TF_TRAFP005.CLEANUP()';
begin
end;

//-------------------------------------------------------------------
function TF_TRAFP005.consultaFichaCliente(pParams : String) : String;
//-------------------------------------------------------------------
const
  cDS_METHOD = 'ADICIONAL=Operação: TF_TRAFP005.consultaFichaCliente()';
var
  viParams, voParams : String;
begin
  viParams := '';

  if (gInFichaNova = True)  or (gModulo.gTpMenu = 103 ) or (gModulo.gTpMenu = 106) then begin
    putitemXml(viParams, 'CD_CLIENTE', item_f('CD_PESSOA', tTRA_TRANSACAO));
    voParams := activateCmp('FCRFL061', 'EXEC', viParams); (*,,, *)
  end else begin
    putitemXml(viParams, 'CD_EMPRESA', item_f('CD_EMPRESA', tTRA_TRANSACAO));
    putitemXml(viParams, 'NR_TRANSACAO', item_f('NR_TRANSACAO', tTRA_TRANSACAO));
    putitemXml(viParams, 'DT_TRANSACAO', item_a('DT_TRANSACAO', tTRA_TRANSACAO));
    voParams := activateCmp('FCRFL004', 'EXEC', viParams); (*,,, *)
  end;
  if (xStatus < 0) then begin
    Result := voParams;
    return(-1); exit;
  end;

  return(0); exit;
end;

//---------------------------------------------------------------
function TF_TRAFP005.encerraTransacao(pParams : String) : String;
//---------------------------------------------------------------
const
  cDS_METHOD = 'ADICIONAL=Operação: TF_TRAFP005.encerraTransacao()';
var
  viParams, voParams, vDsFiltro, vDsRegistro, vDsComponente, vDsMinuta, vDsRelatorio : String;
  vDsLstTransacao, vDsLinha : String;
  vCdEmpresa, vNrTransacao, vNrLote, vStatus, vTpImpressao, vQtMinima, vQtMaxima, vCdUsuario : Real;
  vDtTransacao : TDate;
begin
  voParams := carregaFormaPagamento(viParams); (* *)
  if (xStatus < 0) then begin
    Result := voParams;
    return(-1); exit;
  end;
  if (item_f('TP_MODALIDADE', tGER_OPERACAO) = 4)  and (item_f('TP_OPERACAO', tTRA_TRANSACAO) = 'S') then begin
    viParams := '';
    putitemXml(viParams, 'CD_OPERACAO', item_f('CD_OPERACAO', tTRA_TRANSACAO));
    voParams := activateCmp('GERSVCO054', 'dadosAdicionaisOperacao', viParams); (*,,,, *)
    if (xStatus < 0) then begin
      Result := voParams;
      return(-1); exit;
    end;

    vQtMinima := itemXmlF('QT_MINIMA', voParams);
    vQtMaxima := itemXmlF('QT_MAXIMA', voParams);

    if (vQtMinima > 0)  and (item_f('QT_SOLICITADA', tTRA_TRANSACAO) < vQtMinima) then begin
      Result := SetStatus(STS_ERROR, 'GEN0001', 'Transação ' + NR_TRANSACAO + '.TRA_TRANSACAO não possui quantidade mínima ' + vQtMinima + ' por operação!', '');
      return(-1); exit;
    end else if (vQtMaxima > 0)  and (item_f('QT_SOLICITADA', tTRA_TRANSACAO) > vQtMaxima) then begin
      Result := SetStatus(STS_ERROR, 'GEN0001', 'Transação ' + NR_TRANSACAO + '.TRA_TRANSACAO ultrapassou a quantidade máxima ' + vQtMaxima + ' por operação!', '');
      return(-1); exit;
    end;
    if (gTpFatMin = 1) then begin
      viParams := '';
      putitemXml(viParams, 'CD_PESSOA', item_f('CD_PESSOA', tTRA_TRANSACAO));
      putitemXml(viParams, 'VL_FATURAMENTO', item_f('VL_TRANSACAO', tTRA_TRANSACAO));
      voParams := activateCmp('PEDSVCO015', 'validaFaturamentoMinRegiao', viParams); (*,,,, *)
      if (xStatus < 0) then begin
        Result := voParams;
        return(-1); exit;
      end;

          vCdUsuario := itemXmlF('CD_USUARIO', PARAM_GLB);

          vDsLstTransacao := '';
          vDsRegistro := '';
          putitemXml(vDsRegistro, 'CD_EMPRESA', item_f('CD_EMPRESA', tTRA_TRANSACAO));
          putitemXml(vDsRegistro, 'NR_TRANSACAO', item_f('NR_TRANSACAO', tTRA_TRANSACAO));
          putitemXml(vDsRegistro, 'DT_TRANSACAO', item_a('DT_TRANSACAO', tTRA_TRANSACAO));
          putitem(vDsLstTransacao,  vDsRegistro);

          vDsLinha := 'FATURAMENTO ABAIXO DO MINIMO LIBERADO PELO USUARIO ' + FloatToStr(vCdUsuario') + ';
          viParams := '';
          putitemXml(viParams, 'DS_LSTTRANSACAO', vDsLstTransacao);
          putitemXml(viParams, 'DS_OBSERVACAO', vDsLinha);
          putitemXml(viParams, 'CD_COMPONENTE', TRAFP005);
          putitemXml(viParams, 'IN_OBSNF', False);
          voParams := activateCmp('TRASVCO016', 'gravaObsTransacao', viParams); (*,,,, *)
          if (xStatus < 0) then begin
            Result := voParams;
            return(-1); exit;
          end;
        end else begin
          Result := SetStatus(STS_ERROR, {xCdErro} '', '{xCtxErro} ''', '');
          return(-1); exit;
        end;
      end;
    end;
  end;

  vTpImpressao := itemXmlF('TP_IMP_PACKING_NF_PED', xParamEmp);

  viParams := '';
  putitemXml(viParams, 'CD_EMPRESA', item_f('CD_EMPRESA', tTRA_TRANSACAO));
  putitemXml(viParams, 'NR_TRANSACAO', item_f('NR_TRANSACAO', tTRA_TRANSACAO));
  putitemXml(viParams, 'DT_TRANSACAO', item_a('DT_TRANSACAO', tTRA_TRANSACAO));
  putitemXml(viParams, 'IN_MODELONF', True);

  if (item_f('TP_DOCTO', tGER_OPERACAO) = 2)  or (item_f('TP_DOCTO', tGER_OPERACAO) = 3) then begin
    putitemXml(viParams, 'IN_DIRETO', True);
  end else begin
    putitemXml(viParams, 'IN_DIRETO', False);
  end;
  if (gInImobiliaria = True) then begin
    askmess 'Deseja gerar?', 'Contrato, Nota fiscal, Cancelar';
    if (xStatus = 1) then begin
      vDsComponente := 'TRAFM104';
    end else if (xStatus = 2) then begin
      vDsComponente := 'TRAFM061';
    end else begin
      return(-1); exit;
    end;
  end else begin

    if (gTpImpEtiqExpVd = 5)  or (gTpImpEtiqExpVd = 6) then begin
      voParams := volume(viParams); (* *)
      if (xStatus < 0) then begin
        Result := voParams;
        return(-1); exit;
      end;

      viParams := '';
      putitemXml(viParams, 'CD_EMPTRANSACAO', item_f('CD_EMPRESA', tTRA_TRANSACAO));
      putitemXml(viParams, 'NR_TRANSACAO', item_f('NR_TRANSACAO', tTRA_TRANSACAO));
      putitemXml(viParams, 'DT_TRANSACAO', item_a('DT_TRANSACAO', tTRA_TRANSACAO));
      voParams := activateCmp('EXPSVCO001', 'geraLoteExpedicao', viParams); (*,,,, *)

      commit;
      if (xStatus < 0) then begin
        rollback;
        return(-1); exit;
      end else begin
        voParams := SetHint(viParams); (* 'ID=APLINFO002' *)
      end;

      vNrLote := itemXmlF('NR_LOTE', voParams);

      //keyboard := 'KB_GLOBAL';
      if (gTpImpEtiqExpVd = 5) then begin
        putitemXml(viParams, 'IN_IMPRIMIAUTO', True);
      end else if (gTpImpEtiqExpVd = 6) then begin
        putitemXml(viParams, 'IN_IMPRIMIAUTO', False);
      end;

      putitemXml(viParams, 'NR_LOTE', vNrLote);
      voParams := activateCmp('EXPFP001', 'EXEC', viParams); (*,,, *)
      if (xStatus < 0) then begin
        Result := voParams;
        return(-1); exit;
      end;
    end;

    vDsComponente := 'TRAFM061';
  end;

  viParams := '';
  putitemXml(viParams, 'CD_EMPRESA', item_f('CD_EMPRESA', tTRA_TRANSACAO));
  putitemXml(viParams, 'NR_TRANSACAO', item_f('NR_TRANSACAO', tTRA_TRANSACAO));
  putitemXml(viParams, 'DT_TRANSACAO', item_a('DT_TRANSACAO', tTRA_TRANSACAO));
  putitemXml(viParams, 'IN_MODELONF', True);

  if (item_f('TP_DOCTO', tGER_OPERACAO) = 2)  or (item_f('TP_DOCTO', tGER_OPERACAO) = 3) then begin
    putitemXml(viParams, 'IN_DIRETO', True);
  end else begin
    putitemXml(viParams, 'IN_DIRETO', False);
  end;

  voParams := activateCmp('' + vDsComponente', + ' 'EXEC', viParams); (*,,, *)

  if (xStatus >= 0)  or (xStatus = -3) then begin
    vStatus := xStatus;
    commit;
    if (xStatus < 0) then begin
      rollback;
      return(-1); exit;
    end else begin
      voParams := SetHint(viParams); (* 'ID=APLINFO002' *)
    end;
    if (vStatus = -3) then begin
      voParams := recarregaTransacao(viParams); (* *)
      if (xStatus < 0) then begin
        Result := voParams;
        return(-1); exit;
      end;
      return(-1); exit;
    end;

  end else begin
    rollback;
    return(-1); exit;
  end;
  if (item_f('TP_DOCTO', tGER_OPERACAO) = 1) then begin
    vDsMinuta := voParams;
    viParams := voParams;
    if (item_f('TP_MODALIDADE', tGER_OPERACAO) = 4) then begin
      if (gTpImpressaoNFVenda = 01) then begin
        putitemXml(viParams, 'IN_DIRETO', False);
      end else begin
        putitemXml(viParams, 'IN_DIRETO', True);
      end;
    end else begin
      putitemXml(viParams, 'IN_DIRETO', False);
    end;
    voParams := activateCmp('FISFP008', 'EXEC', viParams); (*,,, *)
    if (xStatus >= 0) then begin
      commit;
      if (xStatus < 0) then begin
        rollback;
      end else begin
        voParams := SetHint(viParams); (* 'ID=APLINFO002' *)
      end;
    end else begin
      rollback;
    end;
    if (gCdModeloMinuta > 0) then begin
      askmess/question 'Deseja imprimir minuta?', 'Sim, Não';
      if (xStatus = 1) then begin
        viParams := vDsMinuta;
        putitemXml(viParams, 'IN_DIRETO', False);
        putitemXml(viParams, 'CD_MODELONF', gCdModeloMinuta);
        if (gnmJobMinuta <> '') then begin
          putitemXml(viParams, 'NM_JOBNF', gnmJobMinuta);
        end;
        voParams := activateCmp('FISFP008', 'EXEC', viParams); (*,,, *)
        if (xStatus >= 0) then begin
          commit;
          if (xStatus < 0) then begin
            rollback;
          end else begin
            voParams := SetHint(viParams); (* 'ID=APLINFO002' *)
          end;
        end else begin
          rollback;
        end;
      end;
    end;
  end;
  if (item_f('TP_OPERACAO', tGER_OPERACAO) = 'S')  and (gTpImpEtiqExpVd = 3 ) or (gTpImpEtiqExpVd = 4) then begin
    viParams := '';
    putitemXml(viParams, 'CD_EMPTRANSACAO', item_f('CD_EMPRESA', tTRA_TRANSACAO));
    putitemXml(viParams, 'NR_TRANSACAO', item_f('NR_TRANSACAO', tTRA_TRANSACAO));
    putitemXml(viParams, 'DT_TRANSACAO', item_a('DT_TRANSACAO', tTRA_TRANSACAO));
    voParams := activateCmp('EXPSVCO001', 'geraLoteExpedicao', viParams); (*,,,, *)

    commit;
    if (xStatus < 0) then begin
      rollback;
      return(-1); exit;
    end else begin
      voParams := SetHint(viParams); (* 'ID=APLINFO002' *)
    end;

    vNrLote := itemXmlF('NR_LOTE', voParams);

    //keyboard := 'KB_GLOBAL';
    if (gTpImpEtiqExpVd = 3) then begin
      putitemXml(viParams, 'IN_IMPRIMIAUTO', True);
    end else if (gTpImpEtiqExpVd = 4) then begin
      putitemXml(viParams, 'IN_IMPRIMIAUTO', False);
    end;
    putitemXml(viParams, 'NR_LOTE', vNrLote);
    voParams := activateCmp('EXPFP001', 'EXEC', viParams); (*,,, *)

    if (xStatus < 0) then begin
      Result := voParams;
      return(-1); exit;
    end;
  end;
  if (vTpImpressao > 0) then begin
    vDsRelatorio := '';

    if (vTpImpressao = 1) then begin
      vDsRelatorio := 'PEDR023';
    end else if (vTpImpressao = 2) then begin
      vDsRelatorio := 'PEDR024';
    end else if (vTpImpressao = 3) then begin
      vDsRelatorio := 'PEDR025';
    end else if (vTpImpressao = 4) then begin
      vDsRelatorio := 'PEDR101';
    end;
    if (vDsRelatorio <> '') then begin
      viParams := '';
      putitemXml(viParams, 'CD_EMPRESA', item_f('CD_EMPRESA', tTRA_TRANSACAO));
      putitemXml(viParams, 'NR_TRANSACAO', item_f('NR_TRANSACAO', tTRA_TRANSACAO));
      putitemXml(viParams, 'DT_TRANSACAO', item_a('DT_TRANSACAO', tTRA_TRANSACAO));
      voParams := activateCmp('SISFP002', 'exec', viParams); (*vDsRelatorio,vDsFiltro,,,, *)
      if (xStatus < 0) then begin
        Result := voParams;
        return(-1); exit;
      end;
    end;
  end;
  if (empty('TRA_TRANSCONDPGTOH') = 0) then begin
    voParams := recebeTransacao(viParams); (* *)
    if (xStatus < 0) then begin
      vCdEmpresa := item_f('CD_EMPRESA', tTRA_TRANSACAO);
      vNrTransacao := item_f('NR_TRANSACAO', tTRA_TRANSACAO);
      vDtTransacao := item_a('DT_TRANSACAO', tTRA_TRANSACAO);
      if (vNrTransacao <> '' ) and (vNrTransacao <>  '' ) and (vDtTransacao <> '') then begin
        clear_e(tTRA_TRANSACAO);
        putitem_e(tTRA_TRANSACAO, 'CD_EMPRESA', vCdEmpresa);
        putitem_e(tTRA_TRANSACAO, 'NR_TRANSACAO', vNrTransacao);
        putitem_e(tTRA_TRANSACAO, 'DT_TRANSACAO', vDtTransacao);
        retrieve_e(tTRA_TRANSACAO);
      end;
    end;
  end else if (item_f('TP_MODALIDADE', tGER_OPERACAO) = 4)  and (item_f('TP_OPERACAO', tTRA_TRANSACAO) = 'S') then begin
    voParams := recebeTransacao(viParams); (* *)
    if (xStatus < 0) then begin
      vCdEmpresa := item_f('CD_EMPRESA', tTRA_TRANSACAO);
      vNrTransacao := item_f('NR_TRANSACAO', tTRA_TRANSACAO);
      vDtTransacao := item_a('DT_TRANSACAO', tTRA_TRANSACAO);
      if (vNrTransacao <> '' ) and (vNrTransacao <>  '' ) and (vDtTransacao <> '') then begin
        clear_e(tTRA_TRANSACAO);
        putitem_e(tTRA_TRANSACAO, 'CD_EMPRESA', vCdEmpresa);
        putitem_e(tTRA_TRANSACAO, 'NR_TRANSACAO', vNrTransacao);
        putitem_e(tTRA_TRANSACAO, 'DT_TRANSACAO', vDtTransacao);
        retrieve_e(tTRA_TRANSACAO);
      end;
    end;
  end else if (gInDireto = True) then begin
    voParams := recebeTransacao(viParams); (* *)
    if (xStatus < 0) then begin
      vCdEmpresa := item_f('CD_EMPRESA', tTRA_TRANSACAO);
      vNrTransacao := item_f('NR_TRANSACAO', tTRA_TRANSACAO);
      vDtTransacao := item_a('DT_TRANSACAO', tTRA_TRANSACAO);
      if (vNrTransacao <> '' ) and (vNrTransacao <>  '' ) and (vDtTransacao <> '') then begin
        clear_e(tTRA_TRANSACAO);
        putitem_e(tTRA_TRANSACAO, 'CD_EMPRESA', vCdEmpresa);
        putitem_e(tTRA_TRANSACAO, 'NR_TRANSACAO', vNrTransacao);
        putitem_e(tTRA_TRANSACAO, 'DT_TRANSACAO', vDtTransacao);
        retrieve_e(tTRA_TRANSACAO);
      end;
    end;
  end else begin
    vCdEmpresa := item_f('CD_EMPRESA', tTRA_TRANSACAO);
    vNrTransacao := item_f('NR_TRANSACAO', tTRA_TRANSACAO);
    vDtTransacao := item_a('DT_TRANSACAO', tTRA_TRANSACAO);
    clear_e(tTRA_TRANSACAO);
    putitem_e(tTRA_TRANSACAO, 'CD_EMPRESA', vCdEmpresa);
    putitem_e(tTRA_TRANSACAO, 'NR_TRANSACAO', vNrTransacao);
    putitem_e(tTRA_TRANSACAO, 'DT_TRANSACAO', vDtTransacao);
    retrieve_e(tTRA_TRANSACAO);
  end;

  return(0); exit;
end;

//--------------------------------------------------------------
function TF_TRAFP005.recebeTransacao(pParams : String) : String;
//--------------------------------------------------------------
const
  cDS_METHOD = 'ADICIONAL=Operação: TF_TRAFP005.recebeTransacao()';
var
  viParams, voParams, vDsRegistro, vDsLstTransacao, vDsLstEncargoFin, vDsLstNF, vDsLstLiquidacao, vDsLinha : String;
  vVlTrocoMaximoTra, vVlTrocoMaximoEnc, vNrCupom : Real;
  vInTrocoMaximo, vInFatura, vInConsultaSaldoCredev, vInImprimirCupom : Boolean;
begin
  vInImprimirCupom := True;

  if (gTpVerifCupomImpresso = 1)  or (gTpVerifCupomImpresso = 2) then begin
    viParams := '';
    putitemXml(viParams, 'CD_EMPRESA', item_f('CD_EMPRESA', tTRA_TRANSACAO));
    putitemXml(viParams, 'NR_TRANSACAO', item_f('NR_TRANSACAO', tTRA_TRANSACAO));
    putitemXml(viParams, 'DT_TRANSACAO', item_a('DT_TRANSACAO', tTRA_TRANSACAO));
    voParams := activateCmp('TRASVCO022', 'buscaDadosTransacao', viParams); (*,,,, *)
    if (xStatus < 0) then begin
      Result := voParams;
      return(-1); exit;
    end;
    if (itemXml('NR_CUPOM', voParams) <> '') then begin
      vDsLinha := '';
      vNrCupom := itemXmlF('NR_CUPOM', voParams);

      if (gTpVerifCupomImpresso = 1) then begin
        askmess 'Cupom COO:' + FloatToStr(vNrCupom) + ' já foi emitido para esta transação.Deseja imprimir novo cupom?', 'Não, Sim';
        if (xStatus = 2) then begin
          vInImprimirCupom := True;
          vDsLinha := 'TRANSACAO COM REIMPRESSAO DE CUPOM.';
        end else begin
          vInImprimirCupom := False;
          vDsLinha := 'TRANSACAO SEM REIMPRESSAO DE CUPOM.';
        end;
      end else if (gTpVerifCupomImpresso = 2) then begin
        message/info 'Cupom COO:' + FloatToStr(vNrCupom) + ' já foi emitido para esta transação.';
        vInImprimirCupom := False;
        vDsLinha := 'TRANSACAO SEM REIMPRESSAO DE CUPOM.';
      end;

      vDsLstTransacao := '';
      vDsRegistro := '';
      putitemXml(vDsRegistro, 'CD_EMPRESA', item_f('CD_EMPRESA', tTRA_TRANSACAO));
      putitemXml(vDsRegistro, 'NR_TRANSACAO', item_f('NR_TRANSACAO', tTRA_TRANSACAO));
      putitemXml(vDsRegistro, 'DT_TRANSACAO', item_a('DT_TRANSACAO', tTRA_TRANSACAO));
      putitem(vDsLstTransacao,  vDsRegistro);

      viParams := '';
      putitemXml(viParams, 'DS_LSTTRANSACAO', vDsLstTransacao);
      putitemXml(viParams, 'DS_OBSERVACAO', vDsLinha);
      putitemXml(viParams, 'CD_COMPONENTE', TRAFP005);
      putitemXml(viParams, 'IN_OBSNF', False);
      voParams := activateCmp('TRASVCO016', 'gravaObsTransacao', viParams); (*,,,, *)
      if (xStatus < 0) then begin
        Result := voParams;
        return(-1); exit;
      end;
    end;
  end;

  viParams := '';
  vDsLstTransacao := '';
  vDsRegistro := '';
  putitemXml(vDsRegistro, 'CD_EMPRESA', item_f('CD_EMPRESA', tTRA_TRANSACAO));
  putitemXml(vDsRegistro, 'NR_TRANSACAO', item_f('NR_TRANSACAO', tTRA_TRANSACAO));
  putitemXml(vDsRegistro, 'DT_TRANSACAO', item_a('DT_TRANSACAO', tTRA_TRANSACAO));
  putitem(vDsLstTransacao,  vDsRegistro);
  putitemXml(viParams, 'DS_LSTTRANSACAO', vDsLstTransacao);
  voParams := activateCmp('SICSVCO005', 'validaRecebimento', viParams); (*,,,, *)
  if (xStatus < 0) then begin
    Result := voParams;
    return(-1); exit;
  end;

  vDsLstTransacao := itemXml('DS_LSTTRANSACAO', voParams);
  vDsLstEncargoFin := itemXml('DS_LSTENCARGOFIN', voParams);

  if (vDsLstTransacao = '')  and (vDsLstEncargoFin = '') then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Nenhuma transação validada para recebimento!', '');
    return(-1); exit;
  end;

  viParams := '';
  putitemXml(viParams, 'DS_LSTTRANSACAO', vDsLstTransacao);
  putitemXml(viParams, 'DS_LSTENCARGOFIN', vDsLstEncargoFin);
  voParams := activateCmp('SICSVCO005', 'buscaMaxTroco', viParams); (*,,,, *)
  if (xStatus < 0) then begin
    Result := voParams;
    return(-1); exit;
  end;

  gTpTrocoMaximo := itemXmlF('TP_TROCOMAXIMO', voParams);
  vVlTrocoMaximoTra := itemXmlF('VL_TROCOMAXIMOTRA', voParams);
  vVlTrocoMaximoEnc := itemXmlF('VL_TROCOMAXIMOENC', voParams);

  vInTrocoMaximo := False;

  if (gTpTrocoMaximo = 1) then begin
    vInTrocoMaximo := True;
  end else if (gTpTrocoMaximo = 2) then begin
    askmess 'Utiliza controle de troco máximo?', 'Sim, Não';
    if (xStatus = 1) then begin
      vInTrocoMaximo := True;
    end else begin
      vInTrocoMaximo := False;
    end;
  end;
  if (vDsLstTransacao <> '') then begin
    viParams := '';
    putitemXml(viParams, 'DS_LSTTRANSACAO', vDsLstTransacao);
    putitemXml(viParams, 'IN_TROCOMAXIMO', vInTrocoMaximo);
    putitemXml(viParams, 'VL_TROCOMAXIMO', vVlTrocoMaximoTra);
    putitemXml(viParams, 'IN_IMPRIMIRCUPOM', vInImprimirCupom);
    if (gInImobiliaria = True) then begin
      putitemXml(viParams, 'IN_RECAUTOMATICO', True);
    end;
    if (item_f('TP_MODALIDADE', tGER_OPERACAO) = 3) then begin
      voParams := activateCmp('TRAFM068', 'EXEC', viParams); (*,,, *)
      if (xStatus < 0) then begin
        Result := voParams;
        return(-1); exit;
      end;
    end else begin
      voParams := activateCmp('TRAFM066', 'EXEC', viParams); (*,,, *)
      if (xStatus < 0) then begin
        Result := voParams;
        return(-1); exit;
      end;
      vInFatura := itemXmlB('IN_FATURA', voParams);
      vDsLstNF := itemXml('DS_LSTNF', voParams);

      if (itemXml('CD_EMPLIQ', voParams)<> '')  and (itemXml('DT_LIQ', voParams)<> '')  and itemXmlF('NR_SEQLIQ', voParams) then begin
        vDsRegistro := '';
        putitemXml(vDsRegistro, 'CD_EMPLIQ', itemXmlF('CD_EMPLIQ', voParams));
        putitemXml(vDsRegistro, 'DT_LIQ', itemXml('DT_LIQ', voParams));
        putitemXml(vDsRegistro, 'NR_SEQLIQ', itemXmlF('NR_SEQLIQ', voParams));
        vDsLstLiquidacao := '';
        putitem(vDsLstLiquidacao,  vDsRegistro);
      end;
    end;
  end else begin
    xStatus := 0;
  end;
  if (xStatus >= 0)  and (vDsLstEncargoFin <> '') then begin
    viParams := '';
    putitemXml(viParams, 'DS_LSTTRANSACAO', vDsLstEncargoFin);
    putitemXml(viParams, 'IN_TROCOMAXIMO', vInTrocoMaximo);
    putitemXml(viParams, 'VL_TROCOMAXIMO', vVlTrocoMaximoEnc);
    putitemXml(viParams, 'IN_IMPRIMIRCUPOM', vInImprimirCupom);
    if (gInImobiliaria = True) then begin
      putitemXml(viParams, 'IN_RECAUTOMATICO', True);
    end;
    if (item_f('TP_MODALIDADE', tGER_OPERACAO) = 3) then begin
      voParams := activateCmp('TRAFM068', 'EXEC', viParams); (*,,, *)
      if (xStatus < 0) then begin
        Result := voParams;
        return(-1); exit;
      end;
    end else begin
      voParams := activateCmp('TRAFM066', 'EXEC', viParams); (*,,, *)
      if (xStatus < 0) then begin
        Result := voParams;
        return(-1); exit;
      end;
      if (itemXml('CD_EMPLIQ', voParams)<> '')  and (itemXml('DT_LIQ', voParams)<> '')  and itemXmlF('NR_SEQLIQ', voParams) then begin
        vDsRegistro := '';
        putitemXml(vDsRegistro, 'CD_EMPLIQ', itemXmlF('CD_EMPLIQ', voParams));
        putitemXml(vDsRegistro, 'DT_LIQ', itemXml('DT_LIQ', voParams));
        putitemXml(vDsRegistro, 'NR_SEQLIQ', itemXmlF('NR_SEQLIQ', voParams));
        putitem(vDsLstLiquidacao,  vDsRegistro);
      end;
    end;
  end;
  if (xStatus >= 0) then begin
    commit;
    if (xStatus < 0) then begin
      Result := SetStatus(STS_ERROR, 'GEN0001', 'Erro ' + xStatus + ' no commit do processo!', '');
      rollback;
      return(-1); exit;
    end else begin
      voParams := SetHint(viParams); (* 'ID=APLINFO002' *)
    end;
  end else begin
    rollback;
    return(-1); exit;
  end;
  if (vDsLstLiquidacao <> '')  and (gCdModImpRecebTra > 0) then begin
    repeat
      getitem(vDsRegistro, vDsLstLiquidacao, 1);

      viParams := '';
      putitemXml(viParams, 'CD_EMPLIQ', itemXmlF('CD_EMPLIQ', vDsRegistro));
      putitemXml(viParams, 'DT_LIQ', itemXml('DT_LIQ', vDsRegistro));
      putitemXml(viParams, 'NR_SEQLIQ', itemXmlF('NR_SEQLIQ', vDsRegistro));
      putitemXml(viParams, 'CD_MODFIN', gCdModImpRecebTra);
      putitemXml(viParams, 'IN_FATURAMENTO', True);
      voParams := activateCmp('FCRFF002', 'EXEC', viParams); (*,,, *)
      if (xStatus < 0) then begin
        Result := voParams;
        return(-1); exit;
      end;

      delitem(vDsLstLiquidacao, 1);
    until (vDsLstLiquidacao = '');
  end;
  if (vDsLstNF <> '') then begin
    viParams := '';
    putitemXml(viParams, 'DS_LSTNF', vDsLstNF);
    putitemXml(viParams, 'IN_GERA_NFE_AUTOMATIC', True);
    voParams := activateCmp('FISFP042', 'EXEC', viParams); (*,,, *)
    if (xStatus < 0) then begin
      Result := voParams;
      return(-1); exit;
    end;
  end;
  if (vDsLstTransacao <> '')  and (gTpImpRichTextVD = 1)  and (gCdModRichTextVD <> '')  and (vInFatura = True) then begin
    viParams := '';
    putitemXml(viParams, 'CD_EMPRESA', item_f('CD_EMPRESA', tTRA_TRANSACAO));
    putitemXml(viParams, 'DT_TRANSACAO', item_a('DT_TRANSACAO', tTRA_TRANSACAO));
    putitemXml(viParams, 'NR_TRANSACAO', item_f('NR_TRANSACAO', tTRA_TRANSACAO));
    putitemXml(viParams, 'CD_MODELO', 'TRA');
    putitemXml(viParams, 'CD_RICHTEXT', gCdModRichTextVD);
    voParams := activateCmp('TRAFP061', 'EXEC', viParams); (*,,, *)
    if (xStatus < 0) then begin
      Result := voParams;
      return(-1); exit;
    end;
  end;

  vInConsultaSaldoCredev := False;
  selectcase gTpConsultaSaldoCredev;
  case 1;
    askmess 'Deseja consultar Saldo Credev?', 'Sim, Não';
    if (xStatus = 1) then begin
      vInConsultaSaldoCredev := True;
    end;
  case 2;
    vInConsultaSaldoCredev := True;
  endselectcase;

  if (vInConsultaSaldoCredev = True) then begin
    viParams := '';
    putitemXml(viParams, 'CD_EMPRESA', item_f('CD_EMPRESA', tTRA_TRANSACAO));
    putitemXml(viParams, 'CD_PESSOA', item_f('CD_PESSOA', tTRA_TRANSACAO));
    voParams := activateCmp('TRAFC018', 'EXEC', viParams); (*,,, *)
    if (xStatus < 0) then begin
      Result := voParams;
      return(-1); exit;
    end;
  end;
  if (gInDireto = True) then begin
    macro '^QUIT';
  end else begin
    macro '^CLEAR';
  end;

  return(0); exit;
end;

//--------------------------------------------------------------
function TF_TRAFP005.agrupaTransacao(pParams : String) : String;
//--------------------------------------------------------------
const
  cDS_METHOD = 'ADICIONAL=Operação: TF_TRAFP005.agrupaTransacao()';
var
  viParams, voParams : String;
begin
  viParams := '';
  putitemXml(viParams, 'IN_AGRUPA', True);
  voParams := activateCmp('TRAFP002', 'EXEC', viParams); (*,,, *)

  if (xStatus < 0) then begin
    return(-1); exit;
  end;
  if (itemXml('NR_TRANSACAO', voParams) <> '') then begin
    clear_e(tTRA_TRANSACAO);
    putitem_e(tTRA_TRANSACAO, 'CD_EMPRESA', itemXmlF('CD_EMPRESA', voParams));
    putitem_e(tTRA_TRANSACAO, 'NR_TRANSACAO', itemXmlF('NR_TRANSACAO', voParams));
    putitem_e(tTRA_TRANSACAO, 'DT_TRANSACAO', itemXml('DT_TRANSACAO', voParams));
    retrieve_e(tTRA_TRANSACAO);
  end;
  return(0); exit;
end;

//----------------------------------------------------------
function TF_TRAFP005.valorPadrao(pParams : String) : String;
//----------------------------------------------------------
const
  cDS_METHOD = 'ADICIONAL=Operação: TF_TRAFP005.valorPadrao()';
begin
  fieldsyntax item_a('DT_TRANSACAO', tTRA_TRANSACAO), '';
  fieldsyntax item_f('NR_TRANSACAO', tTRA_TRANSACAO), '';

  if (gCdEmpresa <> '') then begin
    clear_e(tTRA_TRANSACAO);
    putitem_e(tTRA_TRANSACAO, 'CD_EMPRESA', gCdEmpresa);
    putitem_e(tTRA_TRANSACAO, 'DT_TRANSACAO', gDtTransacao);
    putitem_e(tTRA_TRANSACAO, 'NR_TRANSACAO', gNrTransacao);
    retrieve_e(tTRA_TRANSACAO);
    if (xStatus < 0) then begin
      message/info 'Transação não encontrada!';
      return(0); exit;
    end;

    fieldsyntax item_a('DT_TRANSACAO', tTRA_TRANSACAO), 'DIM';
    fieldsyntax item_f('NR_TRANSACAO', tTRA_TRANSACAO), 'DIM';
  end else begin
    putitem_e(tTRA_TRANSACAO, 'DT_TRANSACAO', itemXml('DT_SISTEMA', PARAM_GLB));
    putitem_e(tTRA_TRANSACAO, 'CD_EMPRESA', itemXmlF('CD_EMPRESA', PARAM_GLB));
  end;

  return(0); exit;
end;

//---------------------------------------------------------------
function TF_TRAFP005.agrupaTraRecebto(pParams : String) : String;
//---------------------------------------------------------------
const
  cDS_METHOD = 'ADICIONAL=Operação: TF_TRAFP005.agrupaTraRecebto()';
var
  viParams, voParams : String;
begin
  viParams := '';
  voParams := activateCmp('TRAFP008', 'EXEC', viParams); (*,,, *)

  if (xStatus < 0) then begin
    return(-1); exit;
  end;

  return(0); exit;
end;

//----------------------------------------------------------
function TF_TRAFP005.operacaoTEF(pParams : String) : String;
//----------------------------------------------------------
const
  cDS_METHOD = 'ADICIONAL=Operação: TF_TRAFP005.operacaoTEF()';
var
  viParams, voParams : String;
begin
  viParams := '';
  voParams := activateCmp('TEFFP001', 'EXEC', viParams); (*,,, *)
  if (xStatus < 0) then begin
    Result := voParams;
    return(-1); exit;
  end;

  return(0); exit;
end;

//----------------------------------------------------
function TF_TRAFP005.venda(pParams : String) : String;
//----------------------------------------------------
const
  cDS_METHOD = 'ADICIONAL=Operação: TF_TRAFP005.venda()';
var
  viParams, voParams : String;
  vTpVenda : Real;
begin
  vTpVenda := itemXmlF('CD_COMPONENTE_VendA', xParamEmp);

  if (vTpVenda = 1)  or (gModulo.gTpMenu = 103 ) or (gModulo.gTpMenu = 106) then begin
    viParams := '';
    voParams := activateCmp('TRAFM080', 'EXEC', viParams); (*,,, *)
    if (xStatus < 0) then begin
      Result := voParams;
      return(-1); exit;
    end;
  end else begin
    viParams := '';
    voParams := activateCmp('TRAFM060', 'EXEC', viParams); (*,,, *)
  end;
  if (xStatus < 0) then begin
    return(-1); exit;
  end;

  return(0); exit;
end;

//----------------------------------------------------------------
function TF_TRAFP005.imprimirTransacao(pParams : String) : String;
//----------------------------------------------------------------
const
  cDS_METHOD = 'ADICIONAL=Operação: TF_TRAFP005.imprimirTransacao()';
var
  viParams, voParams, vDsLstTransacao, vDsRegistro, vDsFiltro : String;
begin
  viParams := '';
  vDsLstTransacao := '';
  vDsRegistro := '';

  if ((item_f('TP_SITUACAO', tTRA_TRANSACAO) = 4)  and (gTpImpTraVd = 07 ) or (gTpImpTraVd = 08)) then begin
    viParams := '';
    putitem(vDsLstTransacao,  vDsRegistro);
    putitemXml(viParams, 'DS_LSTTRANSACAO', vDsLstTransacao);
    voParams := activateCmp('SISFP002', 'exec', viParams); (*'TRAR016',vDsFiltro,,,, *)
    if (xStatus < 0) then begin
      Result := voParams;
      return(-1); exit;
    end;

  end else begin
    viParams := '';
    putitemXml(vDsRegistro 'CD_EMPRESA', item_f('CD_EMPRESA', tTRA_TRANSACAO));
    putitemXml(vDsRegistro 'NR_TRANSACAO', item_f('NR_TRANSACAO', tTRA_TRANSACAO));
    putitemXml(vDsRegistro 'DT_TRANSACAO', item_a('DT_TRANSACAO', tTRA_TRANSACAO));
    putitem(vDsLstTransacao,  vDsRegistro);
    putitemXml(viParams, 'DS_LSTTRANSACAO', vDsLstTransacao);
    voParams := activateCmp('TRAFP004', 'EXEC', viParams); (*,,, *)
  end;
  if (xStatus >= 0) then begin
    commit;
    if (xStatus < 0) then begin
      rollback;
      return(-1); exit;
    end else begin
      voParams := SetHint(viParams); (* 'ID=APLINFO002' *)
    end;
  end else begin
    rollback;
    return(-1); exit;
  end;

  return(0); exit;
end;

//---------------------------------------------------------------
function TF_TRAFP005.detalheTransacao(pParams : String) : String;
//---------------------------------------------------------------
const
  cDS_METHOD = 'ADICIONAL=Operação: TF_TRAFP005.detalheTransacao()';
var
  viParams, voParams : String;
begin
  viParams := '';
  putitemXml(viParams, 'CD_EMPRESA', item_f('CD_EMPRESA', tTRA_TRANSACAO));
  putitemXml(viParams, 'NR_TRANSACAO', item_f('NR_TRANSACAO', tTRA_TRANSACAO));
  putitemXml(viParams, 'DT_TRANSACAO', item_a('DT_TRANSACAO', tTRA_TRANSACAO));
  voParams := activateCmp('TRAFL017', 'exec', viParams); (*,,, *)
  if (xStatus < 0) then begin
    Result := voParams;
    return(-1); exit;
  end;

  return(0); exit;
end;

//-----------------------------------------------------------
function TF_TRAFP005.recebeFatura(pParams : String) : String;
//-----------------------------------------------------------
const
  cDS_METHOD = 'ADICIONAL=Operação: TF_TRAFP005.recebeFatura()';
var
  viParams, voParams : String;
begin
  viParams := '';
  voParams := activateCmp('FCRFP002', 'EXEC', viParams); (*,,, *)

  if (xStatus < 0) then begin
    return(-1); exit;
  end;

  return(0); exit;
end;

//-------------------------------------------------------------------
function TF_TRAFP005.desbloqueiaTransacao(pParams : String) : String;
//-------------------------------------------------------------------
const
  cDS_METHOD = 'ADICIONAL=Operação: TF_TRAFP005.desbloqueiaTransacao()';
var
  viParams, voParams : String;
begin
  viParams := '';
  putitemXml(viParams, 'CD_EMPRESA', item_f('CD_EMPRESA', tTRA_TRANSACAO));
  putitemXml(viParams, 'NR_TRANSACAO', item_f('NR_TRANSACAO', tTRA_TRANSACAO));
  putitemXml(viParams, 'DT_TRANSACAO', item_a('DT_TRANSACAO', tTRA_TRANSACAO));
  voParams := activateCmp('TRAFP030', 'exec', viParams); (*,,, *)
  if (xStatus < 0) then begin
    return(-1); exit;
  end;
  if (itemXml('NR_TRANSACAO', voParams) <> '') then begin
    clear_e(tTRA_TRANSACAO);
    putitem_e(tTRA_TRANSACAO, 'CD_EMPRESA', itemXmlF('CD_EMPRESA', voParams));
    putitem_e(tTRA_TRANSACAO, 'NR_TRANSACAO', itemXmlF('NR_TRANSACAO', voParams));
    putitem_e(tTRA_TRANSACAO, 'DT_TRANSACAO', itemXml('DT_TRANSACAO', voParams));
    retrieve_e(tTRA_TRANSACAO);
  end;
  return(0); exit;
end;

//-------------------------------------------------------
function TF_TRAFP005.desconto(pParams : String) : String;
//-------------------------------------------------------
const
  cDS_METHOD = 'ADICIONAL=Operação: TF_TRAFP005.desconto()';
var
  viParams, voParams, vDsRegistro, vDsLstTransacao, vDsLinha : String;
  vVlDesconto, vVlTotalDesc, vPrTotalDesc, vVlResto, vVlCalc, vVlMaior, vNrOcc : Real;
  vVlBrutoTransacao, vVlLiquidoTransacao, vCdUsuario, vVlLiquido : Real;
  vCdEmpresa, vNrTransacao, vPrDescMaximo : Real;
  vDtTransacao : TDate;
begin
  if (gInSimuladorProduto > 0)  or (empty('TRA_TRANSCONDPGTOH') = 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Não é possível aplicar desconto o parâmetro por empresa IN_SIMULADOR_FAT_PRODUTO está configurado!', '');
    return(-1); exit;
  end;
  if (gInSimuladorCondPgto > 0)  or (empty('TRA_TRANSCONDPGTOH') = 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Não é possível aplicar desconto o parâmetro por empresa IN_SIMULADOR_COND_PGTO está configurado!', '');
    return(-1); exit;
  end;
  if (gTpSimuladorFat > 0)  or (empty('TRA_TRANSCONDPGTOH') = 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Não é possível aplicar desconto o parâmetro por empresa TP_SIMULADOR_FAT está configurado!', '');
    return(-1); exit;
  end;

  vCdUsuario := itemXmlF('CD_USUARIO', PARAM_GLB);

  vVlDesconto := 0;
  vVlLiquido := 0;
  if (empty(tTRA_TRANSITEM) = False) then begin
    setocc(tTRA_TRANSITEM, 1);
    while (xStatus >= 0) do begin

      if (gInBloqDesItemProm = True)  and (item_f('CD_PROMOCAO', tTRA_TRANSITEM) > 0) then begin
      end else begin
        vVlLiquido := vVlLiquido +  item_f('VL_TOTALLIQUIDO', tTRA_TRANSITEM);
        vVlDesconto := vVlDesconto + item_f('VL_TOTALDESCCAB', tTRA_TRANSITEM);
      end;
      setocc(tTRA_TRANSITEM, curocc(tTRA_TRANSITEM) + 1);
    end;
  end;

  viParams := '';

  putitemXml(viParams, 'CD_EMPTRA', item_f('CD_EMPRESA', tTRA_TRANSACAO));
  putitemXml(viParams, 'DT_TRANSACAO', item_a('DT_TRANSACAO', tTRA_TRANSACAO));
  putitemXml(viParams, 'NR_TRANSACAO', item_f('NR_TRANSACAO', tTRA_TRANSACAO));
  putitemXml(viParams, 'VL_TOTALBRUTO', item_f('VL_TRANSACAO', tTRA_TRANSACAO));
  vVlCalc := vVlLiquido + vVlDesconto;
  putitemXml(viParams, 'VL_BASEDESC', vVlCalc);
  putitemXml(viParams, 'VL_DESCONTO', vVlDesconto);
  putitemXml(viParams, 'IN_ARREDONDA_PRECO', False);
  putitemXml(viParams, 'CD_OPERACAO', item_f('CD_OPERACAO', tTRA_TRANSACAO));
  putitemXml(viParams, 'CD_PESSOA', item_f('CD_PESSOA', tTRA_TRANSACAO));
  voParams := activateCmp('TRAFM062', 'EXEC', viParams); (*,,, *)

  if (xStatus < 0) then begin
    return(-1); exit;
  end;

  vVlTotalDesc := itemXmlF('VL_TOTALDESC', voParams);
  vPrTotalDesc := itemXmlF('PR_TOTALDESC', voParams);
  gCdUsuarioDesc := itemXmlF('CD_USUARIODESC', voParams);
  vPrDescMaximo := itemXmlF('PR_DESCMAXIMO', voParams);

  if (gCdUsuarioDesc > 0)  and (gCdUsuarioDesc <> vCdUsuario) then begin
    clear_e(tTRA_LIMDESCONTO);
    putitem_e(tTRA_LIMDESCONTO, 'CD_OPERACAO', item_f('CD_OPERACAO', tTRA_TRANSACAO));
    putitem_e(tTRA_LIMDESCONTO, 'CD_USUARIO', gCdUsuarioDesc);
    retrieve_e(tTRA_LIMDESCONTO);
    if (xStatus < 0) then begin
      clear_e(tTRA_LIMDESCONTO);
    end;
  end;

  vVlResto := vVlTotalDesc;

  if (empty(tTRA_TRANSITEM) = False) then begin
    vVlMaior := 0;
    setocc(tTRA_TRANSITEM, 1);
    while (xStatus >= 0) do begin
      if (gInBloqDesItemProm = True)  and (item_f('CD_PROMOCAO', tTRA_TRANSITEM) > 0) then begin
      end else begin
        vVlCalc := item_f('VL_TOTALLIQUIDO', tTRA_TRANSITEM) + item_f('VL_TOTALDESCCAB', tTRA_TRANSITEM);
        vVlCalc := vVlCalc * vPrTotalDesc / 100;
        putitem_e(tTRA_TRANSITEM, 'VL_TOTALDESCCAB', rounded(vVlCalc, 2));
        putitem_e(tTRA_TRANSITEM, 'VL_TOTALLIQUIDO', item_f('VL_TOTALBRUTO', tTRA_TRANSITEM) - (item_f('VL_TOTALDESC', tTRA_TRANSITEM) + item_f('VL_TOTALDESCCAB', tTRA_TRANSITEM)));
        vVlCalc := item_f('VL_TOTALDESCCAB', tTRA_TRANSITEM) / item_f('QT_SOLICITADA', tTRA_TRANSITEM);
        putitem_e(tTRA_TRANSITEM, 'VL_UNITDESCCAB', rounded(vVLCalc, 6));
        vVlCalc := item_f('VL_TOTALLIQUIDO', tTRA_TRANSITEM) / item_f('QT_SOLICITADA', tTRA_TRANSITEM);
        putitem_e(tTRA_TRANSITEM, 'VL_UNITLIQUIDO', rounded(vVLCalc, 6));
        vVlResto := vVlResto - item_f('VL_TOTALDESCCAB', tTRA_TRANSITEM);
        if (item_f('VL_TOTALLIQUIDO', tTRA_TRANSITEM) > vVlMaior) then begin
          vVlMaior := item_f('VL_TOTALLIQUIDO', tTRA_TRANSITEM);
          vNrOcc := curocc(tTRA_TRANSITEM);
        end;
      end;
      setocc(tTRA_TRANSITEM, curocc(tTRA_TRANSITEM) + 1);
    end;
    if (vVlResto <> 0) then begin
      setocc(tTRA_TRANSITEM, 1);
      putitem_e(tTRA_TRANSITEM, 'VL_TOTALDESCCAB', item_f('VL_TOTALDESCCAB', tTRA_TRANSITEM) + vVlResto);
      putitem_e(tTRA_TRANSITEM, 'VL_TOTALLIQUIDO', item_f('VL_TOTALBRUTO', tTRA_TRANSITEM) - (item_f('VL_TOTALDESC', tTRA_TRANSITEM) + item_f('VL_TOTALDESCCAB', tTRA_TRANSITEM)));
      vVlCalc := item_f('VL_TOTALDESCCAB', tTRA_TRANSITEM) / item_f('QT_SOLICITADA', tTRA_TRANSITEM);
      putitem_e(tTRA_TRANSITEM, 'VL_UNITDESCCAB', rounded(vVLCalc, 6));
      vVlCalc := item_f('VL_TOTALLIQUIDO', tTRA_TRANSITEM) / item_f('QT_SOLICITADA', tTRA_TRANSITEM);
      putitem_e(tTRA_TRANSITEM, 'VL_UNITLIQUIDO', rounded(vVLCalc, 6));
    end;

    setocc(tTRA_TRANSITEM, 1);
    while (xStatus >= 0) do begin
      viParams := '';
      putlistitensocc_e(viParams, tTRA_TRANSITEM);
      putitemXml(viParams, 'IN_TOTAL', False);
      voParams := activateCmp('TRASVCO004', 'gravaItemTransacao', viParams); (*,,,, *)
      if (xStatus < 0) then begin
        Result := voParams;
        return(-1); exit;
      end;
      setocc(tTRA_TRANSITEM, curocc(tTRA_TRANSITEM) + 1);
    end;

    vDsLstTransacao := '';
    vDsRegistro := '';
    putitemXml(vDsRegistro, 'CD_EMPRESA', item_f('CD_EMPRESA', tTRA_TRANSACAO));
    putitemXml(vDsRegistro, 'NR_TRANSACAO', item_f('NR_TRANSACAO', tTRA_TRANSACAO));
    putitemXml(vDsRegistro, 'DT_TRANSACAO', item_a('DT_TRANSACAO', tTRA_TRANSACAO));
    putitem(vDsLstTransacao,  vDsRegistro);
    putitemXml(viParams, 'DS_LSTTRANSACAO', vDsLstTransacao);
    voParams := activateCmp('TRASVCO004', 'gravaTotalTransacao', viParams); (*,,,, *)
    if (xStatus < 0) then begin
      Result := voParams;
      return(-1); exit;
    end;

    viParams := '';
    putitemXml(viParams, 'CD_EMPRESA', item_f('CD_EMPRESA', tTRA_TRANSACAO));
    putitemXml(viParams, 'NR_TRANSACAO', item_f('NR_TRANSACAO', tTRA_TRANSACAO));
    putitemXml(viParams, 'DT_TRANSACAO', item_a('DT_TRANSACAO', tTRA_TRANSACAO));
    putitemXml(viParams, 'IN_SOBREPOR', True);
    voParams := activateCmp('TRASVCO004', 'gravaParcelaTransacao', viParams); (*,,,, *)
    if (xStatus < 0) then begin
      Result := voParams;
      return(-1); exit;
    end;
  end;

  viParams := '';
  putitemXml(viParams, 'CD_EMPRESA', item_f('CD_EMPRESA', tTRA_TRANSACAO));
  putitemXml(viParams, 'NR_TRANSACAO', item_f('NR_TRANSACAO', tTRA_TRANSACAO));
  putitemXml(viParams, 'DT_TRANSACAO', item_a('DT_TRANSACAO', tTRA_TRANSACAO));
  putitemXml(viParams, 'PR_DESCMAXIMO', vPrDescMaximo);
  voParams := activateCmp('TRAFP059', 'EXEC', viParams); (*,,, *)
  if (xStatus < 0) then begin
    Result := voParams;
    return(-1); exit;
  end;

  gCdUsuarioDesc := itemXmlF('CD_USUARIODESC', voParams);

  if (gCdUsuarioDesc > 0)  and (gCdUsuarioDesc <> vCdUsuario) then begin
    clear_e(tTRA_LIMDESCONTO);
    putitem_e(tTRA_LIMDESCONTO, 'CD_OPERACAO', item_f('CD_OPERACAO', tTRA_TRANSACAO));
    putitem_e(tTRA_LIMDESCONTO, 'CD_USUARIO', gCdUsuarioDesc);
    retrieve_e(tTRA_LIMDESCONTO);
    if (xStatus < 0) then begin
      clear_e(tTRA_LIMDESCONTO);
    end;

    vDsLstTransacao := '';
    vDsRegistro := '';
    putitemXml(vDsRegistro, 'CD_EMPRESA', item_f('CD_EMPRESA', tTRA_TRANSACAO));
    putitemXml(vDsRegistro, 'NR_TRANSACAO', item_f('NR_TRANSACAO', tTRA_TRANSACAO));
    putitemXml(vDsRegistro, 'DT_TRANSACAO', item_a('DT_TRANSACAO', tTRA_TRANSACAO));
    putitem(vDsLstTransacao,  vDsRegistro);

    vDsLinha := 'Desconto liberado pelo usuario ' + FloatToStr(gCdUsuarioDesc,) + ' componente TRAFP059';
    viParams := '';
    putitemXml(viParams, 'DS_LSTTRANSACAO', vDsLstTransacao);
    putitemXml(viParams, 'DS_OBSERVACAO', vDsLinha);
    putitemXml(viParams, 'CD_COMPONENTE', TRAFP005);
    putitemXml(viParams, 'IN_OBSNF', False);
    voParams := activateCmp('TRASVCO016', 'gravaObsTransacao', viParams); (*,,,, *)
  end;

  commit;
  if (xStatus < 0) then begin
    rollback;
    return(-1); exit;
  end else begin
    voParams := SetHint(viParams); (* 'ID=APLINFO002' *)
  end;

  vCdEmpresa := item_f('CD_EMPRESA', tTRA_TRANSACAO);
  vNrTransacao := item_f('NR_TRANSACAO', tTRA_TRANSACAO);
  vDtTransacao := item_a('DT_TRANSACAO', tTRA_TRANSACAO);

  clear_e(tTRA_TRANSACAO);
  putitem_e(tTRA_TRANSACAO, 'CD_EMPRESA', vCdEmpresa);
  putitem_e(tTRA_TRANSACAO, 'NR_TRANSACAO', vNrTransacao);
  putitem_e(tTRA_TRANSACAO, 'DT_TRANSACAO', vDtTransacao);
  retrieve_e(tTRA_TRANSACAO);

  return(0); exit;
end;

//---------------------------------------------------------
function TF_TRAFP005.observacao(pParams : String) : String;
//---------------------------------------------------------
const
  cDS_METHOD = 'ADICIONAL=Operação: TF_TRAFP005.observacao()';
var
  viParams, voParams : String;
begin
  viParams := '';
  putitemXml(viParams, 'CD_EMPRESA', item_f('CD_EMPRESA', tTRA_TRANSACAO));
  putitemXml(viParams, 'NR_TRANSACAO', item_f('NR_TRANSACAO', tTRA_TRANSACAO));
  putitemXml(viParams, 'DT_TRANSACAO', item_a('DT_TRANSACAO', tTRA_TRANSACAO));
  voParams := activateCmp('TRAFM065', 'EXEC', viParams); (*,,, *)

  if (xStatus < 0) then begin
    rollback;
    return(-1); exit;
  end;

  commit;
  if (xStatus < 0) then begin
    rollback;
    return(-1); exit;
  end else begin
    voParams := SetHint(viParams); (* 'ID=APLINFO002' *)
  end;

  return(0); exit;

end;

//-----------------------------------------------------
function TF_TRAFP005.volume(pParams : String) : String;
//-----------------------------------------------------
const
  cDS_METHOD = 'ADICIONAL=Operação: TF_TRAFP005.volume()';
var
  viParams, voParams : String;
begin
  viParams := '';
  putitemXml(viParams, 'CD_EMPRESA', item_f('CD_EMPRESA', tTRA_TRANSACAO));
  putitemXml(viParams, 'NR_TRANSACAO', item_f('NR_TRANSACAO', tTRA_TRANSACAO));
  putitemXml(viParams, 'DT_TRANSACAO', item_a('DT_TRANSACAO', tTRA_TRANSACAO));
  voParams := activateCmp('TRAFM077', 'EXEC', viParams); (*,,, *)
  if (xStatus < 0) then begin
    rollback;
    return(-1); exit;
  end;

  commit;
  if (xStatus < 0) then begin
    rollback;
    return(-1); exit;
  end else begin
    voParams := SetHint(viParams); (* 'ID=APLINFO002' *)
  end;

  return(0); exit;
end;

//-----------------------------------------------------------------
function TF_TRAFP005.recarregaTransacao(pParams : String) : String;
//-----------------------------------------------------------------
const
  cDS_METHOD = 'ADICIONAL=Operação: TF_TRAFP005.recarregaTransacao()';
var
  vCdEmpresa, vNrTransacao : Real;
  vDtTransacao : TDate;
begin
  vCdEmpresa := item_f('CD_EMPRESA', tTRA_TRANSACAO);
  vNrTransacao := item_f('NR_TRANSACAO', tTRA_TRANSACAO);
  vDtTransacao := item_a('DT_TRANSACAO', tTRA_TRANSACAO);

  clear_e(tTRA_TRANSACAO);
  putitem_e(tTRA_TRANSACAO, 'CD_EMPRESA', vCdEmpresa);
  putitem_e(tTRA_TRANSACAO, 'NR_TRANSACAO', vNrTransacao);
  putitem_e(tTRA_TRANSACAO, 'DT_TRANSACAO', vDtTransacao);
  retrieve_e(tTRA_TRANSACAO);

  return(0); exit;
end;

//--------------------------------------------------------------------
function TF_TRAFP005.carregaFormaPagamento(pParams : String) : String;
//--------------------------------------------------------------------
const
  cDS_METHOD = 'ADICIONAL=Operação: TF_TRAFP005.carregaFormaPagamento()';
var
  viParams, voParams : String;
begin
  if (gTpSimuladorFat = 0)  and (gInSimuladorProduto = False)  and (gInSimuladorCondPgto = False) then begin
    return(0); exit;
  end;
  if (item_f('TP_OPERACAO', tTRA_TRANSACAO) = 'S')  and (item_f('TP_MODALIDADE', tGER_OPERACAO) = 8)  and (item_f('VL_TRANSACAO', tTRA_TRANSACAO) <= item_f('VL_TOTAL', tR_TRA_TRANSACAO)) then begin
    return(0); exit;
  end;
  if (item_f('TP_MODALIDADE', tGER_OPERACAO) = 4 ) or (item_f('TP_MODALIDADE', tGER_OPERACAO) = 8)  and (item_f('TP_OPERACAO', tTRA_TRANSACAO) = 'S') then begin
  end else begin

    return(0); exit;
  end;
  if (empty('TRA_TRANSCONDPGTOH') = 0) then begin
    return(0); exit;
  end;
  if (gInSimuladorProduto = True) then begin
    voParams := activateCmp('LOGSVCO003', 'GetNivelComponente', viParams); (*gModulo.gCdUsuario,gModulo.gCdEmpresa,'TRAFM113',gxCdNivel,, *)
    if (xStatus < 0) then begin
      Result := voParams;
      return(-1); exit;
    end;

    viParams := '';
    putitemXml(viParams, 'CD_EMPRESA', item_f('CD_EMPRESA', tTRA_TRANSACAO));
    putitemXml(viParams, 'NR_TRANSACAO', item_f('NR_TRANSACAO', tTRA_TRANSACAO));
    putitemXml(viParams, 'DT_TRANSACAO', item_a('DT_TRANSACAO', tTRA_TRANSACAO));
    //keyboard := 'KB_GLOBAL';
    voParams := activateCmp('TRAFM113', 'EXEC', viParams); (*,,, *)
    //keyboard := 'KB_PDV';
    if (xStatus < 0) then begin
      return(-1); exit;
    end;
  end else if (gInSimuladorCondPgto = True) then begin
    voParams := activateCmp('LOGSVCO003', 'GetNivelComponente', viParams); (*gModulo.gCdUsuario,gModulo.gCdEmpresa,'TRAFM113',gxCdNivel,, *)
    if (xStatus < 0) then begin
      Result := voParams;
      return(-1); exit;
    end;

    viParams := '';
    putitemXml(viParams, 'CD_EMPRESA', item_f('CD_EMPRESA', tTRA_TRANSACAO));
    putitemXml(viParams, 'NR_TRANSACAO', item_f('NR_TRANSACAO', tTRA_TRANSACAO));
    putitemXml(viParams, 'DT_TRANSACAO', item_a('DT_TRANSACAO', tTRA_TRANSACAO));
    //keyboard := 'KB_GLOBAL';
    voParams := activateCmp('TRAFM123', 'EXEC', viParams); (*,,, *)
    //keyboard := 'KB_PDV';
    if (xStatus < 0) then begin
      return(-1); exit;
    end;
  end else if (gTpSimuladorFat > 0) then begin
    voParams := activateCmp('LOGSVCO003', 'GetNivelComponente', viParams); (*gModulo.gCdUsuario,gModulo.gCdEmpresa,'TRAFM078',gxCdNivel,, *)
    if (xStatus < 0) then begin
      Result := voParams;
      return(-1); exit;
    end;

    viParams := '';
    putitemXml(viParams, 'CD_EMPRESA', item_f('CD_EMPRESA', tTRA_TRANSACAO));
    putitemXml(viParams, 'NR_TRANSACAO', item_f('NR_TRANSACAO', tTRA_TRANSACAO));
    putitemXml(viParams, 'DT_TRANSACAO', item_a('DT_TRANSACAO', tTRA_TRANSACAO));
    voParams := activateCmp('TRAFM078', 'EXEC', viParams); (*,,, *)
    if (xStatus < 0) then begin
      return(-1); exit;
    end;
  end;
  if (voParams <> '') then begin
    gCdUsuarioDesc := itemXmlF('CD_USUARIODESC', voParams);

    viParams := voParams;
    voParams := activateCmp('TRASVCO017', 'gravaFormaPagamento', viParams); (*,,,, *)
    if (xStatus < 0) then begin
      Result := voParams;
      return(-1); exit;
    end;

    viParams := '';
    putitemXml(viParams, 'CD_EMPRESA', item_f('CD_EMPRESA', tTRA_TRANSACAO));
    putitemXml(viParams, 'NR_TRANSACAO', item_f('NR_TRANSACAO', tTRA_TRANSACAO));
    putitemXml(viParams, 'DT_TRANSACAO', item_a('DT_TRANSACAO', tTRA_TRANSACAO));
    putitemXml(viParams, 'IN_SOBREPOR', True);
    voParams := activateCmp('TRASVCO004', 'gravaParcelaTransacao', viParams); (*,,,, *)

    commit;
    if (xStatus < 0) then begin
      rollback;
    end else begin
      voParams := SetHint(viParams); (* 'ID=APLINFO002' *)
    end;
  end;
  voParams := recarregaTransacao(viParams); (* *)
  if (xStatus < 0) then begin
    Result := voParams;
    return(-1); exit;
  end;

  return(0); exit;
end;

//----------------------------------------------------------------------
function TF_TRAFP005.verificaTransacaoAberta(pParams : String) : String;
//----------------------------------------------------------------------
const
  cDS_METHOD = 'ADICIONAL=Operação: TF_TRAFP005.verificaTransacaoAberta()';
var
  viParams, voParams : String;
begin
  clear_e(tF_TRA_TRANSACAO);
  putitem_e(tF_TRA_TRANSACAO, 'CD_EMPRESA', itemXmlF('CD_EMPRESA', PARAM_GLB));
  putitem_e(tF_TRA_TRANSACAO, 'CD_OPERADOR', itemXmlF('CD_USUARIO', PARAM_GLB));
  putitem_e(tF_TRA_TRANSACAO, 'DT_TRANSACAO', itemXml('DT_SISTEMA', PARAM_GLB));
  putitem_e(tF_TRA_TRANSACAO, 'TP_SITUACAO', 1);
  putitem_e(tF_TRA_TRANSACAO, 'TP_OPERACAO', 'S');
  putitem_e(tF_TRA_TRANSACAO, 'CD_OPERACAO', gCdOperacaoVenda);
  retrieve_e(tF_TRA_TRANSACAO);
  if (xStatus >= 0) then begin
    setocc(tF_TRA_TRANSACAO, 1);
    while (xStatus > 0) do begin

      voParams := setDisplay(viParams); (* 'Aguarde, cancelando transação: ' + NR_TRANSACAO + '.F_TRA_TRANSACAO', '', '' *)
      if (xStatus < 0) then begin
        Result := voParams;
        return(-1); exit;
      end;

      viParams := '';
      putitemXml(viParams, 'CD_EMPRESA', item_f('CD_EMPRESA', tF_TRA_TRANSACAO));
      putitemXml(viParams, 'NR_TRANSACAO', item_f('NR_TRANSACAO', tF_TRA_TRANSACAO));
      putitemXml(viParams, 'DT_TRANSACAO', item_a('DT_TRANSACAO', tF_TRA_TRANSACAO));
      putitemXml(viParams, 'DS_MOTIVO', 'CANCELAMENTO AUTOMATICO DE TRANSACAO DO USUARIO');
      putitemXml(viParams, 'TP_SITUACAONF', 'C');
      putitemXml(viParams, 'IN_PEDIDO', False);
      putitemXml(viParams, 'TP_QUANTIDADEPED', 'S');
      putitemXml(viParams, 'CD_CONFERENTE', itemXmlF('CD_USUARIO', PARAM_GLB));
      putitemXml(viParams, 'CD_COMPONENTE', TRAFP005);
      voParams := activateCmp('TRASVCO013', 'cancelaTransacao', viParams); (*,,,, *)
      if (xStatus < 0) then begin
        Result := voParams;
        return(-1); exit;
      end;

      setocc(tF_TRA_TRANSACAO, curocc(tF_TRA_TRANSACAO) + 1);
    end;

    commit;
    if (xStatus < 0) then begin
      rollback;
    end;
  end;

  return(0); exit;

end;

end.
