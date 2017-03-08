unit fTRAFP011;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, fFormTouch, ExtCtrls, cPanel, cDatasetUnf;

type
  TF_TRAFP011 = class(T_FormTouch)
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
  private
    tGER_OPERACAO,
    tSIS_BOTOES,
    tTRA_TRANSACAO : TcDatasetUnf;
    function getParam(pParams : String = '') : String;
    function setEntidade(pParams : String = '') : String;
    function preEDIT(pParams : String = '') : String;
    function posEDIT(pParams : String = '') : String;
    function preEDIT(pParams : String = '') : String;
    function INIT(pParams : String = '') : String;
    function validaBotoes(pParams : String = '') : String;
    function agrupaItem(pParams : String = '') : String;
    function observacao(pParams : String = '') : String;
    function opcaoECF(pParams : String = '') : String;
    function opcaoTEF(pParams : String = '') : String;
    function relacionaTroca(pParams : String = '') : String;
    function grade(pParams : String = '') : String;
    function cadastraPessoa(pParams : String = '') : String;
    function separaClassificacao(pParams : String = '') : String;
    function volume(pParams : String = '') : String;
    function abrirCaixa(pParams : String = '') : String;
    function contagem(pParams : String = '') : String;
    function Retirada(pParams : String = '') : String;
    function Despesa(pParams : String = '') : String;
    function agrupaTransacao(pParams : String = '') : String;
    function entradaColetor(pParams : String = '') : String;
    function suprimento(pParams : String = '') : String;
    function checaPreco(pParams : String = '') : String;
    function fichaCliente(pParams : String = '') : String;
    function simulacao(pParams : String = '') : String;
    function relacionaClassificacao(pParams : String = '') : String;
    function incluirItemCor(pParams : String = '') : String;
    function recebimentoEmpresa(pParams : String = '') : String;
    function acertoCondicional(pParams : String = '') : String;
    function acertoConsignacao(pParams : String = '') : String;
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
  gInfichaclientecx,
  gInUtilizaSimulador,
  gTpChecaPreco,
  gTpFoco,
  gTpTEF : String;

procedure TF_TRAFP011.FormCreate(Sender: TObject);
begin
  inherited; //
  setEntidade();
end;

procedure TF_TRAFP011.FormShow(Sender: TObject);
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

procedure TF_TRAFP011.FormActivate(Sender: TObject);
begin
  inherited; //
end;

procedure TF_TRAFP011.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  inherited; //
end;

//---------------------------------------------------------------
function TF_TRAFP011.getParam(pParams : String = '') : String;
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
function TF_TRAFP011.setEntidade(pParams : String = '') : String;
//---------------------------------------------------------------
begin
  tGER_OPERACAO := TcDatasetUnf.GetEntidade(Self, 'GER_OPERACAO');
  tSIS_BOTOES := TcDatasetUnf.GetEntidade(Self, 'SIS_BOTOES');
  tTRA_TRANSACAO := TcDatasetUnf.GetEntidade(Self, 'TRA_TRANSACAO');
end;

//---------------------------------------------------------------
function TF_TRAFP011.preEDIT(pParams : String) : String;
//---------------------------------------------------------------
const
  cDS_METHOD = 'ADICIONAL=Operação: TF_TRAFP011.preEDIT()';
begin
  return(0); exit;
end;

//---------------------------------------------------------------
function TF_TRAFP011.posEDIT(pParams : String) : String;
//---------------------------------------------------------------
const
  cDS_METHOD = 'ADICIONAL=Operação: TF_TRAFP011.posEDIT()';
begin
  return(0); exit;
end;

//------------------------------------------------------
function TF_TRAFP011.preEDIT(pParams : String) : String;
//------------------------------------------------------
const
  cDS_METHOD = 'ADICIONAL=Operação: TF_TRAFP011.preEDIT()';
var
  vCdEmpresa, vNrTransacao : Real;
  vDtTransacao : TDate;
begin
  vCdEmpresa := itemXmlF('CD_EMPRESA', viParams);
  vNrTransacao := itemXmlF('NR_TRANSACAO', viParams);
  vDtTransacao := itemXml('DT_TRANSACAO', viParams);
  gTpFoco := itemXmlF('TP_FOCO', viParams);
  if (gTpFoco = '') then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Tipo de foco da transação não informado!', '');
    return(-1); exit;
  end;

  clear_e(tTRA_TRANSACAO);

  if (vCdEmpresa > 0)  and (vNrTransacao > 0)  and (vDtTransacao <> '') then begin
    putitem_e(tTRA_TRANSACAO, 'CD_EMPRESA', vCdEmpresa);
    putitem_e(tTRA_TRANSACAO, 'NR_TRANSACAO', vNrTransacao);
    putitem_e(tTRA_TRANSACAO, 'DT_TRANSACAO', vDtTransacao);
    retrieve_e(tTRA_TRANSACAO);
    if (xStatus < 0) then begin
      Result := SetStatus(STS_ERROR, 'GEN0001', 'Transação ' + FloatToStr(vNrTransacao) + ' não cadastrada!', '');
      return(-1); exit;
    end;
  end;

  voParams := validaBotoes(viParams); (* *)
  if (xStatus < 0) then begin
    Result := voParams;
    return(-1); exit;
  end;

  return(0); exit;
end;

//---------------------------------------------------
function TF_TRAFP011.INIT(pParams : String) : String;
//---------------------------------------------------
const
  cDS_METHOD = 'ADICIONAL=Operação: TF_TRAFP011.INIT()';
begin
  _Caption := '' + TRAFP + '011 - Opção Adicional de Transação de Venda';

  xParam := '';
  putitem(xParam,  'CD_TRANSP_PADRAO');
  xParam := T_ADMSVCO001.GetParametro(xParam); (*xParam,xParam,, *)

  xParamEmp := '';
  putitem(xParamEmp,  'TEF_TIPO');
  putitem(xParamEmp,  'TP_CHECAPRECO_FAT');
  putitem(xParamEmp,  'IN_FICHA_CLIENTE_CX');
  putitem(xParamEmp,  'IN_UTILIZA_SIMULADOR_PDV');
  xParamEmp := T_ADMSVCO001.GetParamEmpresa(piCdEmpresa, xParamEmp); (*itemXml('CD_EMPRESA', *)

  gTpTEF := itemXml('TEF_TIPO', xParamEmp);
  gTpChecaPreco := itemXmlF('TP_CHECAPRECO_FAT', xParamEmp);
  gInfichaclientecx := itemXmlB('IN_FICHA_CLIENTE_CX', xParamEmp);
  gInUtilizaSimulador := itemXmlB('IN_UTILIZA_SIMULADOR_PDV', xParamEmp);
  return(0); exit;
end;

//-----------------------------------------------------------
function TF_TRAFP011.validaBotoes(pParams : String) : String;
//-----------------------------------------------------------
const
  cDS_METHOD = 'ADICIONAL=Operação: TF_TRAFP011.validaBotoes()';
begin
  fieldsyntax item_a('BT_SIMULADOR', tSIS_BOTOES), 'DIM';

  if (empty(tTRA_TRANSACAO) = False) then begin
    if (itemXml('IN_ITENS', viParams) = False) then begin
      fieldsyntax item_a('BT_AGRUPARITEM', tSIS_BOTOES), 'DIM';
    end else begin
      fieldsyntax item_a('BT_AGRUPARITEM', tSIS_BOTOES), '';
    end;
    fieldsyntax item_a('BT_OBSERVACAO', tSIS_BOTOES), '';
    fieldsyntax item_a('BT_SEPARACAO', tSIS_BOTOES), '';
    fieldsyntax item_a('BT_TRATRANSPORT', tSIS_BOTOES), '';
    fieldsyntax item_a('BT_TIPCLASS', tSIS_BOTOES), '';

    if (item_f('TP_OPERACAO', tTRA_TRANSACAO) = 'S')  and (item_f('TP_MODALIDADE', tGER_OPERACAO) = 8) then begin
      fieldsyntax item_a('BT_TROCA', tSIS_BOTOES), '';
    end else begin
      fieldsyntax item_a('BT_TROCA', tSIS_BOTOES), 'DIM';
    end;
    fieldsyntax item_a('BT_GRADE', tSIS_BOTOES), '';

    if (item_f('TP_DOCTO', tGER_OPERACAO) = 3) then begin
      fieldsyntax item_a('BT_ECF', tSIS_BOTOES), 'DIM';
    end;
    fieldsyntax item_a('BT_COLETOR', tSIS_BOTOES), '';
    if (gInUtilizaSimulador = True) then begin
      fieldsyntax item_a('BT_SIMULADOR', tSIS_BOTOES), '';
    end;
  end else begin
    fieldsyntax item_a('BT_AGRUPARITEM', tSIS_BOTOES), 'DIM';
    fieldsyntax item_a('BT_OBSERVACAO', tSIS_BOTOES), 'DIM';
    fieldsyntax item_a('BT_SEPARACAO', tSIS_BOTOES), 'DIM';
    fieldsyntax item_a('BT_TROCA', tSIS_BOTOES), 'DIM';
    fieldsyntax item_a('BT_GRADE', tSIS_BOTOES), 'DIM';
    fieldsyntax item_a('BT_TRATRANSPORT', tSIS_BOTOES), 'DIM';
    fieldsyntax item_a('BT_COLETOR', tSIS_BOTOES), 'DIM';
    fieldsyntax item_a('BT_TIPCLASS', tSIS_BOTOES), 'DIM';

  end;
  if (gTpTEF = 1)  or (gTpTEF = 2) then begin
    fieldsyntax item_a('BT_TEF', tSIS_BOTOES), '';
  end else begin
    fieldsyntax item_a('BT_TEF', tSIS_BOTOES), 'DIM';
  end;

  fieldsyntax item_a('BT_FICHACLIENTE', tSIS_BOTOES), 'HID';
  if (gInfichaclientecx) then begin
    fieldsyntax item_a('BT_FICHACLIENTE', tSIS_BOTOES), '';
  end;

  return(0); exit;
end;

//---------------------------------------------------------
function TF_TRAFP011.agrupaItem(pParams : String) : String;
//---------------------------------------------------------
const
  cDS_METHOD = 'ADICIONAL=Operação: TF_TRAFP011.agrupaItem()';
begin
  putitemXml(voParams, 'IN_AGRUPARITEM', True);

  macro '^ACCEPT';

  return(0); exit;
end;

//---------------------------------------------------------
function TF_TRAFP011.observacao(pParams : String) : String;
//---------------------------------------------------------
const
  cDS_METHOD = 'ADICIONAL=Operação: TF_TRAFP011.observacao()';
var
  viParams, voParams : String;
begin
  askmess 'Tipo de observação?', 'Transação, Nota fiscal, Cancelar';
  if (xStatus = 1) then begin
    viParams := '';
    putitemXml(viParams, 'CD_EMPRESA', item_f('CD_EMPRESA', tTRA_TRANSACAO));
    putitemXml(viParams, 'NR_TRANSACAO', item_f('NR_TRANSACAO', tTRA_TRANSACAO));
    putitemXml(viParams, 'DT_TRANSACAO', item_a('DT_TRANSACAO', tTRA_TRANSACAO));
    voParams := activateCmp('TRAFM065', 'EXEC', viParams); (*,,, *)
    if (xStatus < 0) then begin
      Result := voParams;
      return(-1); exit;
    end;
  end else if (xStatus = 2) then begin
    viParams := '';
    putitemXml(viParams, 'CD_EMPRESA', item_f('CD_EMPRESA', tTRA_TRANSACAO));
    putitemXml(viParams, 'NR_TRANSACAO', item_f('NR_TRANSACAO', tTRA_TRANSACAO));
    putitemXml(viParams, 'DT_TRANSACAO', item_a('DT_TRANSACAO', tTRA_TRANSACAO));
    voParams := activateCmp('TRAFM073', 'EXEC', viParams); (*,,, *)
  end else begin
    return(-1); exit;
  end;
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

//-------------------------------------------------------
function TF_TRAFP011.opcaoECF(pParams : String) : String;
//-------------------------------------------------------
const
  cDS_METHOD = 'ADICIONAL=Operação: TF_TRAFP011.opcaoECF()';
var
  viParams, voParams : String;
begin
  viParams := '';
  voParams := activateCmp('ECFFP001', 'EXEC', viParams); (*,,, *)
  if (xStatus < 0) then begin
    Result := voParams;
    return(-1); exit;
  end;

  return(0); exit;
end;

//-------------------------------------------------------
function TF_TRAFP011.opcaoTEF(pParams : String) : String;
//-------------------------------------------------------
const
  cDS_METHOD = 'ADICIONAL=Operação: TF_TRAFP011.opcaoTEF()';
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

//-------------------------------------------------------------
function TF_TRAFP011.relacionaTroca(pParams : String) : String;
//-------------------------------------------------------------
const
  cDS_METHOD = 'ADICIONAL=Operação: TF_TRAFP011.relacionaTroca()';
var
  viParams, voParams, vDsRegTroca : String;
  vCdEmpresaDev, vNrTransacaoDev : Real;
  vDtTransacaoDev : TDate;
begin
  viParams := '';
  putitemXml(viParams, 'CD_EMPRESA', item_f('CD_EMPRESA', tTRA_TRANSACAO));
  putitemXml(viParams, 'NR_TRANSACAO', item_f('NR_TRANSACAO', tTRA_TRANSACAO));
  putitemXml(viParams, 'DT_TRANSACAO', item_a('DT_TRANSACAO', tTRA_TRANSACAO));
  voParams := activateCmp('TRAFM082', 'EXEC', viParams); (*,,, *)
  if (xStatus < 0) then begin
    return(-1); exit;
  end;

  vCdEmpresaDev := itemXmlF('CD_EMPRESA', voParams);
  vNrTransacaoDev := itemXmlF('NR_TRANSACAO', voParams);
  vDtTransacaoDev := itemXml('DT_TRANSACAO', voParams);

  if (vNrTransacaoDev = 0) then begin
    return(-1); exit;
  end;

  viParams := '';
  putitemXml(viParams, 'CD_EMPDEV', vCdEmpresaDev);
  putitemXml(viParams, 'NR_TRADEV', vNrTransacaoDev);
  putitemXml(viParams, 'DT_TRADEV', vDtTransacaoDev);
  putitemXml(viParams, 'CD_EMPVEN', item_f('CD_EMPRESA', tTRA_TRANSACAO));
  putitemXml(viParams, 'NR_TRAVEN', item_f('NR_TRANSACAO', tTRA_TRANSACAO));
  putitemXml(viParams, 'DT_TRAVEN', item_a('DT_TRANSACAO', tTRA_TRANSACAO));
  voParams := activateCmp('TRASVCO016', 'gravaTrocaTransacao', viParams); (*,,,, *)

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

//----------------------------------------------------
function TF_TRAFP011.grade(pParams : String) : String;
//----------------------------------------------------
const
  cDS_METHOD = 'ADICIONAL=Operação: TF_TRAFP011.grade()';
var
  viParams, voParams : String;
begin
  viParams := '';
  putitemXml(viParams, 'CD_EMPRESA', item_f('CD_EMPRESA', tTRA_TRANSACAO));
  putitemXml(viParams, 'NR_TRANSACAO', item_f('NR_TRANSACAO', tTRA_TRANSACAO));
  putitemXml(viParams, 'DT_TRANSACAO', item_a('DT_TRANSACAO', tTRA_TRANSACAO));
  voParams := activateCmp('TRAFM076', 'EXEC', viParams); (*,,, *)

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

  putitemXml(voParams, 'IN_RECARREGA', True);

  macro '^ACCEPT';

  return(0); exit;
end;

//-------------------------------------------------------------
function TF_TRAFP011.cadastraPessoa(pParams : String) : String;
//-------------------------------------------------------------
const
  cDS_METHOD = 'ADICIONAL=Operação: TF_TRAFP011.cadastraPessoa()';
var
  viParams, voParams : String;
begin
  viParams := '';
  voParams := activateCmp('PESFM010', 'EXEC', viParams); (*,,, *)
  if (xStatus < 0) then begin
    Result := voParams;
    return(-1); exit;
  end;

  voParams := voParams;

  macro '^ACCEPT';

  return(0); exit;
end;

//------------------------------------------------------------------
function TF_TRAFP011.separaClassificacao(pParams : String) : String;
//------------------------------------------------------------------
const
  cDS_METHOD = 'ADICIONAL=Operação: TF_TRAFP011.separaClassificacao()';
var
  viParams, voParams : String;
begin
  viParams := '';
  putitemXml(viParams, 'CD_EMPRESA', item_f('CD_EMPRESA', tTRA_TRANSACAO));
  putitemXml(viParams, 'NR_TRANSACAO', item_f('NR_TRANSACAO', tTRA_TRANSACAO));
  putitemXml(viParams, 'DT_TRANSACAO', item_a('DT_TRANSACAO', tTRA_TRANSACAO));
  voParams := activateCmp('TRAFP010', 'EXEC', viParams); (*,,, *)

  if (xStatus < 0) then begin
    return(-1); exit;
  end;

  voParams := voParams;
  putitemXml(voParams, 'IN_SEPARACLASSIFICACAO', True);

  macro '^ACCEPT';

  return(0); exit;
end;

//-----------------------------------------------------
function TF_TRAFP011.volume(pParams : String) : String;
//-----------------------------------------------------
const
  cDS_METHOD = 'ADICIONAL=Operação: TF_TRAFP011.volume()';
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

//---------------------------------------------------------
function TF_TRAFP011.abrirCaixa(pParams : String) : String;
//---------------------------------------------------------
const
  cDS_METHOD = 'ADICIONAL=Operação: TF_TRAFP011.abrirCaixa()';
var
  viParams, voParams : String;
begin
  voParams := activateCmp('FCXFM004', 'EXEC', viParams); (*,,, *)
  if (xStatus < 0) then begin
    Result := voParams;
    return(-1); exit;
  end;

  return(0); exit;
end;

//-------------------------------------------------------
function TF_TRAFP011.contagem(pParams : String) : String;
//-------------------------------------------------------
const
  cDS_METHOD = 'ADICIONAL=Operação: TF_TRAFP011.contagem()';
var
  viParams, voParams : String;
begin
  viParams := '';

  putitemXml(viParams, 'CD_EMPRESA', itemXmlF('CD_EMP', PARAM_GLB));
  putitemXml(viParams, 'IN_TRANSACAO', True);

  voParams := activateCmp('FCXFM001', 'EXEC', viParams); (*,,, *)
  if (xStatus < 0) then begin
    Result := voParams;
    return(-1); exit;
  end;

  return(0); exit;
end;

//-------------------------------------------------------
function TF_TRAFP011.Retirada(pParams : String) : String;
//-------------------------------------------------------
const
  cDS_METHOD = 'ADICIONAL=Operação: TF_TRAFP011.Retirada()';
var
  viParams, voParams : String;
begin
  viParams := '';
  putitemXml(viParams, 'IN_PDV', True);
  putitemXml(viParams, 'DS_MOTIVO', 'RETIRADO PELO GERENTE');
  voParams := activateCmp('FCXFM006', 'EXEC', viParams); (*,,, *)
  if (xStatus < 0) then begin
    Result := voParams;
    return(-1); exit;
  end;

  return(0); exit;
end;

//------------------------------------------------------
function TF_TRAFP011.Despesa(pParams : String) : String;
//------------------------------------------------------
const
  cDS_METHOD = 'ADICIONAL=Operação: TF_TRAFP011.Despesa()';
var
  viParams, voParams : String;
begin
  viParams := '';
  putitemXml(viParams, 'IN_PDV', True);
  voParams := activateCmp('FCXFM005', 'EXEC', viParams); (*,,, *)
  if (xStatus < 0) then begin
    Result := voParams;
    return(-1); exit;
  end;

  return(0); exit;
end;

//--------------------------------------------------------------
function TF_TRAFP011.agrupaTransacao(pParams : String) : String;
//--------------------------------------------------------------
const
  cDS_METHOD = 'ADICIONAL=Operação: TF_TRAFP011.agrupaTransacao()';
var
  voParams, viParams : String;
begin
  //keyboard := 'KB_GLOBAL';
  voParams := activateCmp('TRAFP019', 'EXEC', viParams); (*,,, *)
  //keyboard := 'KB_PDV';
  if (xStatus < 0) then begin
    Result := voParams;
    return(-1); exit;
  end;
  if (xStatus >= 0) then begin
    putitemXml(voParams, 'IN_AGRUPATRANSACAO', True);
    voParams := voParams;
    macro '^ACCEPT';
  end;

  return(0); exit;
end;

//-------------------------------------------------------------
function TF_TRAFP011.entradaColetor(pParams : String) : String;
//-------------------------------------------------------------
const
  cDS_METHOD = 'ADICIONAL=Operação: TF_TRAFP011.entradaColetor()';
var
  voParams, viParams, vDsRegistro, vDsLinha, vDsLstColetor, vDsLista : String;
begin
  //keyboard := 'KB_GLOBAL';
  viParams := '';
  voParams := activateCmp('PRDFP015', 'EXEC', viParams); (*,vDsLista,,, *)
  //keyboard := 'KB_PDV';
  if (xStatus < 0) then begin
    Result := voParams;
    return(-1); exit;
  end;
  if (xStatus >= 0) then begin
    if (vDsLista <> '') then begin
      repeat
        vDsRegistro := '';
        getitem(vDsRegistro, vDsLista, 1);
        vDsLinha := '';
        putitemXml(vDsLinha, 'CD_PRODUTO', itemXmlF('CD_PRODUTO', vDsRegistro));
        putitemXml(vDsLinha, 'CD_BARRAPRD', itemXmlF('CD_BARRAPRD', vDsRegistro));
        putitemXml(vDsLinha, 'QT_COLETA', itemXmlF('QT_COLETA', vDsRegistro));
        putitem(vDsLstColetor,  vDsLinha);
        delitem(vDsLista, 1);
      until (vDsLista = '');
      putitemXml(voParams, 'IN_ENTRADACOLETOR', True);
      putitemXml(voParams, 'DS_LSTCOLETOR', vDsLstColetor);
      macro '^ACCEPT';
    end;
  end;

  return(0); exit;
end;

//---------------------------------------------------------
function TF_TRAFP011.suprimento(pParams : String) : String;
//---------------------------------------------------------
const
  cDS_METHOD = 'ADICIONAL=Operação: TF_TRAFP011.suprimento()';
var
  viParams, voParams : String;
begin
  voParams := activateCmp('FCXFM007', 'EXEC', viParams); (*,,, *)
  if (xStatus < 0) then begin
    Result := voParams;
    return(-1); exit;
  end;

  return(0); exit;
end;

//---------------------------------------------------------
function TF_TRAFP011.checaPreco(pParams : String) : String;
//---------------------------------------------------------
const
  cDS_METHOD = 'ADICIONAL=Operação: TF_TRAFP011.checaPreco()';
var
  viParams, voParams : String;
begin
  viParams := '';
  if (gTpChecaPreco = 1) then begin
    voParams := activateCmp('PRDFC010', 'EXEC', viParams); (*,,, *)
  end else if (gTpChecaPreco = 2) then begin
    voParams := activateCmp('PRDFC012', 'EXEC', viParams); (*,,, *)
  end;
  if (xStatus < 0) then begin
    Result := voParams;
    return(-1); exit;
  end;

  return(0); exit;
end;

//-----------------------------------------------------------
function TF_TRAFP011.fichaCliente(pParams : String) : String;
//-----------------------------------------------------------
const
  cDS_METHOD = 'ADICIONAL=Operação: TF_TRAFP011.fichaCliente()';
var
  viParams, voParams : String;
begin
  viParams := '';
  putitemXml(viParams, 'CD_CLIENTE', item_f('CD_PESSOA', tTRA_TRANSACAO));
  voParams := activateCmp('FCRFL004', 'EXEC', viParams); (*,,, *)
  if (xStatus < 0) then begin
    Result := voParams;
    return(-1); exit;
  end;

  return(0); exit;
end;

//--------------------------------------------------------
function TF_TRAFP011.simulacao(pParams : String) : String;
//--------------------------------------------------------
const
  cDS_METHOD = 'ADICIONAL=Operação: TF_TRAFP011.simulacao()';
var
  viParams, voParams : String;
begin
  viParams := '';
  putitemXml(viParams, 'CD_EMPRESA', item_f('CD_EMPRESA', tTRA_TRANSACAO));
  putitemXml(viParams, 'NR_TRANSACAO', item_f('NR_TRANSACAO', tTRA_TRANSACAO));
  putitemXml(viParams, 'DT_TRANSACAO', item_a('DT_TRANSACAO', tTRA_TRANSACAO));
  putitemXml(viParams, 'IN_PDV', True);
  voParams := activateCmp('TRAFM078', 'EXEC', viParams); (*,,, *)
  if (xStatus < 0) then begin
    Result := voParams;
    return(-1); exit;
  end;

  return(0); exit;
end;

//---------------------------------------------------------------------
function TF_TRAFP011.relacionaClassificacao(pParams : String) : String;
//---------------------------------------------------------------------
const
  cDS_METHOD = 'ADICIONAL=Operação: TF_TRAFP011.relacionaClassificacao()';
var
  viParams, voParams : String;
begin
  viParams := '';
  putitemXml(viParams, 'CD_EMPRESA', item_f('CD_EMPRESA', tTRA_TRANSACAO));
  putitemXml(viParams, 'NR_TRANSACAO', item_f('NR_TRANSACAO', tTRA_TRANSACAO));
  putitemXml(viParams, 'DT_TRANSACAO', item_a('DT_TRANSACAO', tTRA_TRANSACAO));
  voParams := activateCmp('TRAFM102', 'EXEC', viParams); (*,,, *)

  if (xStatus < 0) then begin
    return(-1); exit;
  end;

  macro '^ACCEPT';

  return(0); exit;
end;

//-------------------------------------------------------------
function TF_TRAFP011.incluirItemCor(pParams : String) : String;
//-------------------------------------------------------------
const
  cDS_METHOD = 'ADICIONAL=Operação: TF_TRAFP011.incluirItemCor()';
var
  viParams, voParams : String;
begin
  viParams := '';
  putitemXml(viParams, 'CD_EMPRESA', item_f('CD_EMPRESA', tTRA_TRANSACAO));
  putitemXml(viParams, 'NR_TRANSACAO', item_f('NR_TRANSACAO', tTRA_TRANSACAO));
  putitemXml(viParams, 'DT_TRANSACAO', item_a('DT_TRANSACAO', tTRA_TRANSACAO));
  voParams := activateCmp('TRAFM120', 'EXEC', viParams); (*,,, *)

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

  putitemXml(voParams, 'IN_RECARREGA', True);

  macro '^ACCEPT';

  return(0); exit;
end;

//-----------------------------------------------------------------
function TF_TRAFP011.recebimentoEmpresa(pParams : String) : String;
//-----------------------------------------------------------------
const
  cDS_METHOD = 'ADICIONAL=Operação: TF_TRAFP011.recebimentoEmpresa()';
var
  viParams, voParams : String;
begin
  viParams := '';
  newinstance 'FCRFP002', 'FCRFP002', 'TRANSACTION=TRUE';
  voParams := activateCmp('FCRFP002', 'EXEC', viParams); (*,,, *)
  if (xStatus < 0) then begin
    Result := voParams;
    return(-1); exit;
  end;

  return(0); exit;
end;

//----------------------------------------------------------------
function TF_TRAFP011.acertoCondicional(pParams : String) : String;
//----------------------------------------------------------------
const
  cDS_METHOD = 'ADICIONAL=Operação: TF_TRAFP011.acertoCondicional()';
var
  viParams, voParams : String;
begin
  viParams := '';
  newinstance 'TRAFP017', 'TRAFP017', 'TRANSACTION=TRUE';
  voParams := activateCmp('TRAFP017', 'EXEC', viParams); (*,,, *)
  if (xStatus < 0) then begin
    Result := voParams;
    return(-1); exit;
  end;

  return(0); exit;
end;

//----------------------------------------------------------------
function TF_TRAFP011.acertoConsignacao(pParams : String) : String;
//----------------------------------------------------------------
const
  cDS_METHOD = 'ADICIONAL=Operação: TF_TRAFP011.acertoConsignacao()';
var
  viParams, voParams : String;
begin
  viParams := '';
  newinstance 'TRAFP034', 'TRAFP034', 'TRANSACTION=TRUE';
  voParams := activateCmp('TRAFP034', 'EXEC', viParams); (*,,, *)
  if (xStatus < 0) then begin
    Result := voParams;
    return(-1); exit;
  end;

  return(0); exit;
end;

end.
