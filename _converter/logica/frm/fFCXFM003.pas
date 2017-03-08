unit fFCXFM003;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, fFormTouch, ExtCtrls, cPanel, cDatasetUnf;

type
  TF_FCXFM003 = class(T_FormTouch)
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
  private
    tF_FCX_CAIXAC,
    tFCC_CTADESFCX,
    tFCC_CTAPES,
    tFCC_MOV,
    tFCX_CAIXAC,
    tFCX_CAIXAI,
    tFCX_CAIXAM,
    tFCX_HISTREL,
    tFCX_HISTRELSUB,
    tGER_TERMINAL,
    tSIS_BOTOES,
    tSIS_TITULO,
    tSIS_TOTAIS,
    tTMP_K02,
    tTMP_K03NR : TcDatasetUnf;
    function getParam(pParams : String = '') : String;
    function setEntidade(pParams : String = '') : String;
    function preEDIT(pParams : String = '') : String;
    function posEDIT(pParams : String = '') : String;
    function preEDIT(pParams : String = '') : String;
    function prePRINT(pParams : String = '') : String;
    function INIT(pParams : String = '') : String;
    function CLEANUP(pParams : String = '') : String;
    function carregaHistorico(pParams : String = '') : String;
    function calculaValores(pParams : String = '') : String;
    function efetua(pParams : String = '') : String;
    function imprime(pParams : String = '') : String;
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
  gCdLstEmpresa,
  gInEfetua,
  gInFCXFP022,
  gInFicha,
  gInGeraSobraTpDocMalot,
  gInListaZeradoFecha,
  gInLogMovCtaPes,
  gInVlSistema,
  gTpLanctoFundoCx : String;

procedure TF_FCXFM003.FormCreate(Sender: TObject);
begin
  inherited; //
  setEntidade();
end;

procedure TF_FCXFM003.FormShow(Sender: TObject);
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

procedure TF_FCXFM003.FormActivate(Sender: TObject);
begin
  inherited; //
end;

procedure TF_FCXFM003.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  inherited; //
end;

//---------------------------------------------------------------
function TF_FCXFM003.getParam(pParams : String = '') : String;
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
function TF_FCXFM003.setEntidade(pParams : String = '') : String;
//---------------------------------------------------------------
begin
  tF_FCX_CAIXAC := TcDatasetUnf.GetEntidade(Self, 'F_FCX_CAIXAC');
  tFCC_CTADESFCX := TcDatasetUnf.GetEntidade(Self, 'FCC_CTADESFCX');
  tFCC_CTAPES := TcDatasetUnf.GetEntidade(Self, 'FCC_CTAPES');
  tFCC_MOV := TcDatasetUnf.GetEntidade(Self, 'FCC_MOV');
  tFCX_CAIXAC := TcDatasetUnf.GetEntidade(Self, 'FCX_CAIXAC');
  tFCX_CAIXAI := TcDatasetUnf.GetEntidade(Self, 'FCX_CAIXAI');
  tFCX_CAIXAM := TcDatasetUnf.GetEntidade(Self, 'FCX_CAIXAM');
  tFCX_HISTREL := TcDatasetUnf.GetEntidade(Self, 'FCX_HISTREL');
  tFCX_HISTRELSUB := TcDatasetUnf.GetEntidade(Self, 'FCX_HISTRELSUB');
  tGER_TERMINAL := TcDatasetUnf.GetEntidade(Self, 'GER_TERMINAL');
  tSIS_BOTOES := TcDatasetUnf.GetEntidade(Self, 'SIS_BOTOES');
  tSIS_TITULO := TcDatasetUnf.GetEntidade(Self, 'SIS_TITULO');
  tSIS_TOTAIS := TcDatasetUnf.GetEntidade(Self, 'SIS_TOTAIS');
  tTMP_K02 := TcDatasetUnf.GetEntidade(Self, 'TMP_K02');
  tTMP_K03NR := TcDatasetUnf.GetEntidade(Self, 'TMP_K03NR');
end;

//---------------------------------------------------------------
function TF_FCXFM003.preEDIT(pParams : String) : String;
//---------------------------------------------------------------
const
  cDS_METHOD = 'ADICIONAL=Operação: TF_FCXFM003.preEDIT()';
begin
  return(0); exit;
end;

//---------------------------------------------------------------
function TF_FCXFM003.posEDIT(pParams : String) : String;
//---------------------------------------------------------------
const
  cDS_METHOD = 'ADICIONAL=Operação: TF_FCXFM003.posEDIT()';
begin
  return(0); exit;
end;

//------------------------------------------------------
function TF_FCXFM003.preEDIT(pParams : String) : String;
//------------------------------------------------------
const
  cDS_METHOD = 'ADICIONAL=Operação: TF_FCXFM003.preEDIT()';
var
  vDtAbertura : TDate;
  vCdEmpresa, vCdTerminal, vNrSeq, vTpRotina : Real;
begin
  if (viParams = '') then begin
    message/info 'Nenhum caixa informado para fechamento!';
    return(-1); exit;
  end;

  gInFicha := True;
  vCdEmpresa := itemXmlF('CD_EMPRESA', viParams);
  vCdTerminal := itemXmlF('CD_TERMINAL', viParams);
  vDtAbertura := itemXml('DT_ABERTURA', viParams);
  vNrSeq := itemXmlF('NR_SEQ', viParams);
  vTpRotina := itemXmlF('TP_ROTINA', viParams);
  gInFCXFP022 := itemXmlB('IN_FCXFP022', viParams);

  clear_e(tFCX_CAIXAC);
  putitem_e(tFCX_CAIXAC, 'CD_EMPRESA', vCdEmpresa);
  putitem_e(tFCX_CAIXAC, 'CD_TERMINAL', vCdTerminal);
  putitem_e(tFCX_CAIXAC, 'DT_ABERTURA', vDtAbertura);
  putitem_e(tFCX_CAIXAC, 'NR_SEQ', vNrSeq);
  retrieve_e(tFCX_CAIXAC);

  voParams := carregaHistorico(viParams); (* *)

  voParams := calculaValores(viParams); (* *)
  if (xStatus < 0) then begin
    Result := SetStatus(STS_ERROR, xProcerror, 'xProcerrorcontext', '');
  end;
  if (vTpRotina = 2) then begin
    fieldsyntax item_a('BT_CONFIRMA', tSIS_BOTOES), 'DIM';
  end else begin
    fieldsyntax item_a('BT_CONFIRMA', tSIS_BOTOES), '';
  end;

  gInEfetua := True;

  return(0); exit;
end;

//-------------------------------------------------------
function TF_FCXFM003.prePRINT(pParams : String) : String;
//-------------------------------------------------------
const
  cDS_METHOD = 'ADICIONAL=Operação: TF_FCXFM003.prePRINT()';
begin
  voParams := imprime(viParams); (* *)
  if (xStatus < 0) then begin
    Result := voParams;
    return(-1); exit;
  end;

  return(0); exit;
end;

//---------------------------------------------------
function TF_FCXFM003.INIT(pParams : String) : String;
//---------------------------------------------------
const
  cDS_METHOD = 'ADICIONAL=Operação: TF_FCXFM003.INIT()';
begin
  xParam := '';

  putitem(xParamEmp,  'IN_LOG_MOV_CTAPES');
  xParam := T_ADMSVCO001.GetParametro(xParam); (*xParamEmp,xParamEmp,, *)
  gInLogMovCtaPes := itemXmlB('IN_LOG_MOV_CTAPES', xParamEmp);

  xParamEmp := '';
  putitem(xParamEmp,  'IN_FECHA_CX_VL_SISTEMA');
  putitem(xParamEmp,  'TP_LANCAMENTO_FUNDO_CX');
  putitem(xParamEmp,  'IN_GERA_SOBRA_TPDOC_MALOT');
  putitem(xParamEmp,  'IN_LISTA_VLZERADO_FECHACX');
  xParamEmp := T_ADMSVCO001.GetParamEmpresa(piCdEmpresa, xParamEmp); (*itemXml('CD_EMPRESA', *)
  gInVlSistema := itemXmlB('IN_FECHA_CX_VL_SISTEMA', xParamEmp);
  gTpLanctoFundoCx := itemXmlF('TP_LANCAMENTO_FUNDO_CX', xParamEmp);
  gInGeraSobraTpDocMalot := itemXmlB('IN_GERA_SOBRA_TPDOC_MALOT', xParamEmp);
  gInListaZeradoFecha := itemXmlB('IN_LISTA_VLZERADO_FECHACX', xParamEmp);

  _Caption := '' + FCXFM + '003 - Fechamento de Caixa';
end;

//------------------------------------------------------
function TF_FCXFM003.CLEANUP(pParams : String) : String;
//------------------------------------------------------
const
  cDS_METHOD = 'ADICIONAL=Operação: TF_FCXFM003.CLEANUP()';
begin
end;

//---------------------------------------------------------------
function TF_FCXFM003.carregaHistorico(pParams : String) : String;
//---------------------------------------------------------------
const
  cDS_METHOD = 'ADICIONAL=Operação: TF_FCXFM003.carregaHistorico()';
var
  vNumero, vVlTotRes, vNumeroRes, vCdEmpresa, vCdCCusto, vEmpresa : Real;
  viParams, voParams, vDsAuxiliar, vDsAuxiliar1, vIndsort, vLstEmpresa : String;
  vInVlSistema : Boolean;
begin
  viParams := '';
  vIndsort := '';
  putitemXml(viParams, 'CD_GRUPOEMPRESA', itemXmlF('CD_GRUPOEMPRESA', PARAM_GLB));
  voParams := activateCmp('GERSVCO032', 'buscaLstGrupoEmpresa', viParams); (*,,,, *)
  if (xStatus < 0) then begin
    Result := voParams;
    return(-1); exit;
  end;
  gCdLstEmpresa := itemXmlF('CD_EMPRESA', voParams);

  vNumero := 1;
  putitem_e(tSIS_TOTAIS, 'VL_CONTADO', 0);

  vInVlSistema := True;

  if (gInVlSistema = False) then begin
    viParams := '';
    putitemXml(viParams, 'CD_COMPONENTE', 'FCXFM003');
    putitemXml(viParams, 'DS_CAMPO', 'IN_FECHA_VL_SISTEMA');
    putitemXml(viParams, 'CD_EMPRESA', itemXmlF('CD_EMPRESA', PARAM_GLB));
    putitemXml(viParams, 'CD_USUARIO', itemXmlF('CD_USUARIO', PARAM_GLB));
    voParams := activateCmp('ADMSVCO009', 'verificaRestricao', viParams); (*,,, *)
    if (xStatus < 0) then begin
      vInVlSistema := False;
    end;
  end;
  if (vInVlSistema = False) then begin
    fieldsyntax item_a('BT_CONTADO', tSIS_TITULO), 'HID';
    fieldsyntax item_a('BT_RETIRADA', tSIS_TITULO), 'HID';
    fieldsyntax item_a('BT_FUNDO', tSIS_TITULO), 'HID';
    fieldsyntax item_a('BT_DIF', tSIS_TITULO), 'HID';

    fieldsyntax item_f('VL_SISTEMA', tSIS_TOTAIS), 'HID';
    fieldsyntax item_f('VL_RETIRADA', tSIS_TOTAIS), 'HID';
    fieldsyntax item_f('VL_DIF', tSIS_TOTAIS), 'HID';
  end;

  clear_e(tTMP_K02);
  clear_e(tTMP_K03NR);
  clear_e(tFCX_HISTREL);
  retrieve_e(tFCX_HISTREL);
  setocc(tFCX_HISTREL, 1);
  while (xStatus >= 0) do begin
    if (empty(tFCX_HISTRELSUB) = False)  and (item_b('IN_RECEBIMENTO', tFCX_HISTREL) = True ) or (item_b('IN_FATURAMENTO', tFCX_HISTREL) = True) then begin
      setocc(tFCX_HISTRELSUB, 1);
      while (xStatus >= 0) do begin
        if (item_f('TP_DOCUMENTO', tFCX_HISTREL) <> 9) then begin
          creocc(tTMP_K02, -1);
          putitem_e(tTMP_K02, 'NR_CHAVE01', item_f('TP_DOCUMENTO', tFCX_HISTRELSUB));
          putitem_e(tTMP_K02, 'NR_CHAVE02', item_f('NR_SEQHISTRELSUB', tFCX_HISTRELSUB));
          retrieve_o(tTMP_K02);
          if (xStatus = -7) then begin
            retrieve_x(tTMP_K02);
          end;
          if (gInFCXFP022 = True) then begin
            fieldsyntax item_f('VL_CONTADO', tTMP_K02), '';
          end else begin
            fieldsyntax item_f('VL_CONTADO', tTMP_K02), 'NED';
          end;
          if (vInVlSistema = False) then begin
            fieldsyntax item_f('VL_SISTEMA', tTMP_K02), 'HID';
            fieldsyntax item_f('VL_RETIRADA', tTMP_K02), 'HID';
            fieldsyntax item_f('VL_FUNDO', tTMP_K02), 'HID';
            fieldsyntax item_f('VL_DIF', tTMP_K02), 'HID';
            fieldsyntax item_f('VL_FUNDO', tTMP_K02), 'HID';
          end;
          if (item_f('TP_DOCUMENTO', tFCX_HISTREL) = 1) then begin
            putitem_e(tTMP_K02, 'DS_HISTORICO', 'FATURA');
          end else if (item_f('TP_DOCUMENTO', tFCX_HISTREL) = 2) then begin
            putitem_e(tTMP_K02, 'DS_HISTORICO', 'CHEQUE');
          end else if (item_f('TP_DOCUMENTO', tFCX_HISTREL) = 3) then begin
            putitem_e(tTMP_K02, 'DS_HISTORICO', 'DINHEIRO');
          end else if (item_f('TP_DOCUMENTO', tFCX_HISTREL) = 6) then begin
            putitem_e(tTMP_K02, 'DS_HISTORICO', 'NOTA DEBITO');
          end else if (item_f('TP_DOCUMENTO', tFCX_HISTREL) = 7) then begin
            putitem_e(tTMP_K02, 'DS_HISTORICO', 'TEF');
          end else if (item_f('TP_DOCUMENTO', tFCX_HISTREL) = 10) then begin
            putitem_e(tTMP_K02, 'DS_HISTORICO', 'ADIANTAMENTO');
          end else if (item_f('TP_DOCUMENTO', tFCX_HISTREL) = 11) then begin
            putitem_e(tTMP_K02, 'DS_HISTORICO', 'DESCONTO');
          end else if (item_f('TP_DOCUMENTO', tFCX_HISTREL) = 12) then begin
            putitem_e(tTMP_K02, 'DS_HISTORICO', 'DOFNI');
          end else if (item_f('TP_DOCUMENTO', tFCX_HISTREL) = 13) then begin
            putitem_e(tTMP_K02, 'DS_HISTORICO', 'VALE');
          end else if (item_f('TP_DOCUMENTO', tFCX_HISTREL) = 14) then begin
            putitem_e(tTMP_K02, 'DS_HISTORICO', 'NOTA PROMISSORIA');
          end else if (item_f('TP_DOCUMENTO', tFCX_HISTREL) = 16) then begin
            putitem_e(tTMP_K02, 'DS_HISTORICO', 'TED/DOC');
          end else if (item_f('TP_DOCUMENTO', tFCX_HISTREL) = 20) then begin
            putitem_e(tTMP_K02, 'DS_HISTORICO', 'CREDEV');

          end else if (item_f('TP_DOCUMENTO', tFCX_HISTREL) = 18) then begin
            putitem_e(tTMP_K02, 'DS_HISTORICO', 'CHEQUE PRESENTE');

          end else if (item_f('TP_DOCUMENTO', tFCX_HISTREL) = 50) then begin
            putitem_e(tTMP_K02, 'DS_HISTORICO', 'OUTRO DOCUMENTO');
          end else begin
            putitem_e(tTMP_K02, 'DS_HISTORICO', item_a('DS_HISTRELSUB', tFCX_HISTRELSUB));
          end;
          putitem_e(tTMP_K02, 'IN_TOTALIZA', item_b('IN_TOTALIZADOR', tFCX_HISTREL));

          vDsAuxiliar := int(item_f('VL_AUX', tFCX_HISTREL));
          if (vDsAuxiliar > 0) then begin
            vIndsort := 'S';
          end;
          vDsAuxiliar1 := int(item_f('VL_AUX', tFCX_HISTRELSUB));
          if (vDsAuxiliar < 10) then begin
            vDsAuxiliar := '0' + vDsAuxiliar' + ';
          end;
          if (vDsAuxiliar1 < 10)  and (vDsAuxiliar1 <> '') then begin
            vDsAuxiliar1 := '0' + vDsAuxiliar + '1';
          end;
          putitem_e(tTMP_K02, 'DS_AUXILIAR', '' + vDsAuxiliar' + vDsAuxiliar + ' + '1');

          clear_e(tFCX_CAIXAI);
          putitem_e(tFCX_CAIXAI, 'CD_EMPRESA', item_f('CD_EMPRESA', tFCX_CAIXAC));
          putitem_e(tFCX_CAIXAI, 'CD_TERMINAL', item_f('CD_TERMINAL', tFCX_CAIXAC));
          putitem_e(tFCX_CAIXAI, 'DT_ABERTURA', item_a('DT_ABERTURA', tFCX_CAIXAC));
          putitem_e(tFCX_CAIXAI, 'NR_SEQ', item_f('NR_SEQ', tFCX_CAIXAC));
          putitem_e(tFCX_CAIXAI, 'TP_DOCUMENTO', item_f('TP_DOCUMENTO', tFCX_HISTRELSUB));
          putitem_e(tFCX_CAIXAI, 'NR_SEQHISTRELSUB', item_f('NR_SEQHISTRELSUB', tFCX_HISTRELSUB));
          retrieve_e(tFCX_CAIXAI);
          if (xStatus >= 0) then begin
            putitem_e(tTMP_K02, 'VL_CONTADO', item_f('VL_CONTADO', tFCX_CAIXAI));
            putitem_e(tTMP_K02, 'VL_FUNDO', item_f('VL_FUNDO', tFCX_CAIXAI));

            if (gInFCXFP022 <> True) then begin
              putitem_e(tSIS_TOTAIS, 'VL_CONTADO', item_f('VL_CONTADO', tSIS_TOTAIS) + item_f('VL_CONTADO', tTMP_K02));
            end;

            putitem_e(tTMP_K02, 'VL_SALDO', item_f('VL_CONTADO', tTMP_K02) - item_f('VL_FUNDO', tTMP_K02));
            putitem_e(tSIS_TOTAIS, 'VL_SALDO', item_f('VL_SALDO', tSIS_TOTAIS) + item_f('VL_SALDO', tTMP_K02));

          end;
        end;

        vLstEmpresa := gCdLstEmpresa;
        repeat
          getitem(vCdEmpresa, vLstEmpresa, 1);

          creocc(tTMP_K03NR, -1);
          putitem_e(tTMP_K03NR, 'NR_CHAVE01', vCdEmpresa);
          putitem_e(tTMP_K03NR, 'NR_CHAVE02', item_f('TP_DOCUMENTO', tFCX_HISTRELSUB));
          putitem_e(tTMP_K03NR, 'NR_CHAVE03', item_f('NR_SEQHISTRELSUB', tFCX_HISTRELSUB));
          retrieve_o(tTMP_K03NR);
          if (xStatus = -7) then begin
            retrieve_x(tTMP_K03NR);
          end;
          if (item_f('VL_FUNDO', tFCX_CAIXAI) > 0) then begin
            viParams := '';
            voParams := activateCmp('SICSVCO009', 'validaCentroCusto', viParams); (*,,,, *)
            if (xStatus < 0) then begin
              Result := voParams;
              return(-1); exit;
            end;

            vCdCCusto := itemXmlF('CD_CENTROCUSTO', voParams);
            vEmpresa := itemXmlF('CD_EMPRESA', PARAM_GLB);

            if (vCdCCusto <> vCdEmpresa)  and (gTpLanctoFundoCx <> 1) then begin
              putitem_e(tTMP_K03NR, 'VL_FUNDO', item_f('VL_FUNDO', tFCX_CAIXAI));
            end else if (gTpLanctoFundoCx = 1)  and (item_f('NR_CHAVE01', tTMP_K03NR) = vEmpresa) then begin
              putitem_e(tTMP_K03NR, 'VL_FUNDO', item_f('VL_FUNDO', tFCX_CAIXAI));
            end;
          end;

          delitem(vLstEmpresa, 1);
        until (vLstEmpresa = '');

        setocc(tFCX_HISTRELSUB, curocc(tFCX_HISTRELSUB) + 1);
      end;
    end;

    setocc(tFCX_HISTREL, curocc(tFCX_HISTREL) + 1);
  end;

  setocc(tTMP_K02, 1);
  reset gformmod;

  sort_e(tTMP_K02, '  sort/e , DS_AUXILIAR;');

  setocc(tTMP_K02, 1);
  reset gformmod;

  return(0); exit;
end;

//-------------------------------------------------------------
function TF_FCXFM003.calculaValores(pParams : String) : String;
//-------------------------------------------------------------
const
  cDS_METHOD = 'ADICIONAL=Operação: TF_FCXFM003.calculaValores()';
var
  vCdEmpresa, viParams, voParams, vLstEmpresa : String;
  vEmpresa : Real;
begin
  vCdEmpresa := gCdLstEmpresa;
  vLstEmpresa := gCdLstEmpresa;

  if (item_f('CD_OPERCONF', tFCX_CAIXAC) = 0) then begin
    gInFicha := False;
  end;

  putitem_e(tTMP_K02, 'VL_SISTEMA', '');
  putitem_e(tTMP_K02, 'VL_DIF', '');
  clear_e(tFCX_CAIXAM);
  putitem_e(tFCX_CAIXAM, 'CD_EMPRESA', vCdEmpresa);
  putitem_e(tFCX_CAIXAM, 'DT_ABERTURA', item_a('DT_ABERTURA', tFCX_CAIXAC));
  putitem_e(tFCX_CAIXAM, 'CD_TERMINAL', item_f('CD_TERMINAL', tFCX_CAIXAC));
  putitem_e(tFCX_CAIXAM, 'NR_SEQ', item_f('NR_SEQ', tFCX_CAIXAC));
  retrieve_e(tFCX_CAIXAM);

  if (xStatus >= 0) then begin
    setocc(tFCX_CAIXAM, 1);
    while (xStatus >= 0) do begin
      if (item_b('IN_ESTORNO', tFCC_MOV) = False) then begin
        creocc(tTMP_K02, -1);
        putitem_e(tTMP_K02, 'NR_CHAVE01', item_f('TP_DOCUMENTO', tFCC_MOV));
        putitem_e(tTMP_K02, 'NR_CHAVE02', item_f('NR_SEQHISTRELSUB', tFCC_MOV));
        retrieve_o(tTMP_K02);
        if (item_f('TP_DOCUMENTO', tFCC_MOV) = 9) then begin
          creocc(tTMP_K02, -1);
          putitem_e(tTMP_K02, 'NR_CHAVE01', 3);
          putitem_e(tTMP_K02, 'NR_CHAVE02', 1);
          retrieve_o(tTMP_K02);
          if (xStatus <> 4) then begin
            message/info 'Documento dinheiro não associado!';
            discard(tTMP_K02);
          end else begin
            putitem_e(tTMP_K02, 'VL_SISTEMA', item_f('VL_SISTEMA', tTMP_K02) - item_f('VL_LANCTO', tFCC_MOV));
          end;
        end else begin
          if (item_f('TP_OPERACAO', tFCC_MOV) = 'D') then begin
            putitem_e(tTMP_K02, 'VL_RETIRADA', item_f('VL_RETIRADA', tTMP_K02) + item_f('VL_LANCTO', tFCC_MOV));
          end else begin

            if (item_f('CD_HISTORICO', tFCC_MOV) <> 1112)  and (item_f('CD_HISTORICO', tFCC_MOV) <> 1113) then begin
              putitem_e(tTMP_K02, 'VL_SISTEMA', item_f('VL_SISTEMA', tTMP_K02)  + item_f('VL_LANCTO', tFCC_MOV));
            end;
          end;
        end;

        creocc(tTMP_K03NR, -1);
        putitem_e(tTMP_K03NR, 'NR_CHAVE01', item_f('CD_EMPRESA', tFCC_MOV));
        putitem_e(tTMP_K03NR, 'NR_CHAVE02', item_f('TP_DOCUMENTO', tFCC_MOV));
        putitem_e(tTMP_K03NR, 'NR_CHAVE03', item_f('NR_SEQHISTRELSUB', tFCC_MOV));
        retrieve_o(tTMP_K03NR);
        if (item_f('TP_DOCUMENTO', tFCC_MOV) = 9) then begin
          if (item_f('TP_OPERACAO', tFCC_MOV) = 'D') then begin
            putitem_e(tTMP_K03NR, 'VL_SISTEMA', item_f('VL_SISTEMA', tTMP_K03NR)  + item_f('VL_LANCTO', tFCC_MOV));
          end else begin

            if (item_f('CD_HISTORICO', tFCC_MOV) <> 1112)  and (item_f('CD_HISTORICO', tFCC_MOV) <> 1113) then begin
              putitem_e(tTMP_K03NR, 'VL_RETIRADA', item_f('VL_RETIRADA', tTMP_K03NR) + item_f('VL_LANCTO', tFCC_MOV));
            end;
          end;
        end else begin
          if (item_f('TP_OPERACAO', tFCC_MOV) = 'D') then begin
            putitem_e(tTMP_K03NR, 'VL_RETIRADA', item_f('VL_RETIRADA', tTMP_K03NR) + item_f('VL_LANCTO', tFCC_MOV));
          end else begin

            if (item_f('CD_HISTORICO', tFCC_MOV) <> 1112)  and (item_f('CD_HISTORICO', tFCC_MOV) <> 1113) then begin
              putitem_e(tTMP_K03NR, 'VL_SISTEMA', item_f('VL_SISTEMA', tTMP_K03NR)  + item_f('VL_LANCTO', tFCC_MOV));
            end;
          end;
        end;
      end;

      setocc(tFCX_CAIXAM, curocc(tFCX_CAIXAM) + 1);
    end;
  end;

  putitem_e(tSIS_TOTAIS, 'VL_DIF', 0);
  putitem_e(tSIS_TOTAIS, 'VL_SISTEMA', 0);
  putitem_e(tSIS_TOTAIS, 'VL_RETIRADA', 0);
  setocc(tTMP_K02, 1);
  while (xStatus >= 0) do begin
    if (item_b('IN_TOTALIZA', tTMP_K02) <> True) then begin
      putitem_e(tSIS_TOTAIS, 'VL_CONTADO', item_f('VL_CONTADO', tSIS_TOTAIS) - item_f('VL_CONTADO', tTMP_K02));
      putitem_e(tTMP_K02, 'VL_CONTADO', item_f('VL_SISTEMA', tTMP_K02)    - item_f('VL_RETIRADA', tTMP_K02));
      putitem_e(tSIS_TOTAIS, 'VL_CONTADO', item_f('VL_CONTADO', tSIS_TOTAIS) + item_f('VL_SISTEMA', tTMP_K02) - item_f('VL_RETIRADA', tTMP_K02));
    end;
    if (gInFCXFP022 = True) then begin
      if (item_f('VL_CONTADO', tTMP_K02) = '') then begin
        putitem_e(tTMP_K02, 'VL_CONTADO', item_f('VL_SISTEMA', tTMP_K02));
        putitem_e(tSIS_TOTAIS, 'VL_CONTADO', item_f('VL_CONTADO', tSIS_TOTAIS) + item_f('VL_CONTADO', tTMP_K02));
      end;
    end;

    putitem_e(tTMP_K02, 'VL_DIF', item_f('VL_CONTADO', tTMP_K02) + item_f('VL_RETIRADA', tTMP_K02) - item_f('VL_SISTEMA', tTMP_K02));
    putitem_e(tSIS_TOTAIS, 'VL_SISTEMA', item_f('VL_SISTEMA', tSIS_TOTAIS)  + item_f('VL_SISTEMA', tTMP_K02));
    putitem_e(tSIS_TOTAIS, 'VL_RETIRADA', item_f('VL_RETIRADA', tSIS_TOTAIS) + item_f('VL_RETIRADA', tTMP_K02));

    setocc(tTMP_K02, curocc(tTMP_K02) + 1);
  end;

  putitem_e(tSIS_TOTAIS, 'VL_DIF', item_f('VL_CONTADO', tSIS_TOTAIS) + item_f('VL_RETIRADA', tSIS_TOTAIS) - item_f('VL_SISTEMA', tSIS_TOTAIS));

  setocc(tTMP_K02, 1);

  reset gformmod;
  gprompt := item_f('VL_CONTADO', tTMP_K02);

  return(0); exit;
end;

//-----------------------------------------------------
function TF_FCXFM003.efetua(pParams : String) : String;
//-----------------------------------------------------
const
  cDS_METHOD = 'ADICIONAL=Operação: TF_FCXFM003.efetua()';
var
  viParams, voParams, vCdEmpresa, vLstEmpresa, vDsLinha, vDsLstCaixa : String;
  vCdHistorico, vCxFilial, vCxFundo, vVlDif, vCxMatriz, vCxConta, vNrCtaPesFCC, vNrSeqMovFCC, vVlSaldoAtualDoc, vVlSaldoAtual : Real;
  vCdTerminal, vNrSeq, vVlLancto, vNrSeqItem, vUsaFilial, vVlSobra, vNrSeqMovRel, vVlSaldoAntDoc, vVlSaldoAnt : Real;
  vDtAbertura, vDtMovimFCC : TDate;
  vInLoja : Boolean;
begin
  vCdTerminal := itemXmlF('CD_TERMINAL', viParams);
  vDtAbertura := itemXml('DT_ABERTURA', viParams);
  vNrSeq := itemXmlF('NR_SEQ', viParams);

  vLstEmpresa := gCdLstEmpresa;

  if (gInFCXFP022 = True)  and (item_f('CD_OPERCONF', tFCX_CAIXAC) <= 0) then begin
    setocc(tTMP_K02, 1);
    while (xStatus > 0) do begin
      putitemXml(vDsLinha, 'TP_DOCUMENTO', item_f('NR_CHAVE01', tTMP_K02));
      putitemXml(vDsLinha, 'NR_SEQHISTRELSUB', item_f('NR_CHAVE02', tTMP_K02));
      putitemXml(vDsLinha, 'DS_AUXILIAR', item_a('DS_AUXILIAR', tTMP_K02));
      putitemXml(vDsLinha, 'VL_CONTADO', item_f('VL_CONTADO', tTMP_K02));
      putitem(vDsLstCaixa,  vDsLinha);

      setocc(tTMP_K02, curocc(tTMP_K02) + 1);
    end;
    viParams := '';

    putitemXml(viParams, 'CD_TERMINAL', vCdTerminal);
    putitemXml(viParams, 'DT_ABERTURA', vDtAbertura);
    putitemXml(viParams, 'NR_SEQ', vNrSeq);
    putitemXml(viParams, 'DS_LSTCAIXA', vDsLstCaixa);
    putitemXml(viParams, 'IN_FCXFP022', True);
    voParams := activateCmp('FCXFM001', 'exec', viParams); (*,,, *)
    if (xStatus < 0) then begin
      Result := voParams;
      return(-1); exit;
    end;
  end;

  repeat
    getitem(vCdEmpresa, vLstEmpresa, 1);

    clear_e(tFCX_CAIXAC);
    putitem_e(tFCX_CAIXAC, 'CD_EMPRESA', vCdEmpresa);
    putitem_e(tFCX_CAIXAC, 'CD_TERMINAL', vCdTerminal);
    putitem_e(tFCX_CAIXAC, 'DT_ABERTURA', vDtAbertura);
    putitem_e(tFCX_CAIXAC, 'NR_SEQ', vNrSeq);
    retrieve_e(tFCX_CAIXAC);

    select max(NR_SEQITEM) 
    from 'FCX_CAIXAI' 
    where (putitem_e(tFCX_CAIXAI, 'CD_EMPRESA', vCdEmpresa ) and (
    putitem_e(tFCX_CAIXAI, 'CD_TERMINAL', vCdTerminal ) and (
    putitem_e(tFCX_CAIXAI, 'DT_ABERTURA', vDtAbertura ) and (
    putitem_e(tFCX_CAIXAI, 'NR_SEQ', vNrSeq)
    to vNrSeqItem;

    if (gInFicha = False) then begin
      if (gInFCXFP022 = True) then begin
        Result := SetStatus(STS_AVISO, 'GEN001', 'Fechamento não efetuado!!!', cDS_METHOD);
        return(-1); exit;
      end else begin
        Result := SetStatus(STS_AVISO, 'GEN001', 'Não é possível fazer o fechamento do caixa! Lançamentos (Ficha Cega) não encerrado!', cDS_METHOD);
        return(-1); exit;
      end;
    end;

    xParamEmp := '';
    putitem(xParamEmp,  'CD_CTAPES_CXMATRIZ');
    putitem(xParamEmp,  'CD_CTAPES_CXFILIAL');
    putitem(xParamEmp,  'CD_CTAPES_CXFUNDO');
    putitem(xParamEmp,  'IN_UTILIZA_CXFILIAL');
    xParamEmp := T_ADMSVCO001.GetParamEmpresa(piCdEmpresa, xParamEmp); (*vCdEmpresa,xParamEmp,xParamEmp,, *)

    vCxFilial := itemXmlF('CD_CTAPES_CXFILIAL', xParamEmp);
    vCxMatriz := itemXmlF('CD_CTAPES_CXMATRIZ', xParamEmp);
    vCxFundo := itemXmlF('CD_CTAPES_CXFUNDO', xParamEmp);
    vUsaFilial := itemXmlB('IN_UTILIZA_CXFILIAL', xParamEmp);
    vInLoja := False;

    clear_e(tFCC_CTADESFCX);
    putitem_e(tFCC_CTADESFCX, 'NR_CTAPESORI', item_f('NR_CTAPES', tFCX_CAIXAC));
    retrieve_e(tFCC_CTADESFCX);
    if (xStatus >= 0) then begin
      vCxConta := item_f('NR_CTAPESDES', tFCC_CTADESFCX);
      vInLoja := True;
    end else begin
      if (vUsaFilial = 1) then begin
        if (vCxFilial = 0) then begin
          message/info 'Valor incorreto no parametro de Conta do Caixa Filial!';
          return(-1); exit;
        end;
        vCxConta := vCxFilial;
      end else begin
        if (vCxMatriz = 0) then begin
          message/info 'Valor incorreto no parametro de Conta do Caixa Matriz!';
          return(-1); exit;
        end;
        vCxConta := vCxMatriz;
      end;
    end;
    if (vCxFundo = 0) then begin
      message/info 'Valor incorreto no parametro de Conta do Caixa Fundo!';
      return(-1); exit;
    end;

    viParams := '';
    voParams := activateCmp('FCCSVCO017', 'getNumMovRel', viParams); (*,,,, *)
    if (xStatus < 0) then begin
      Result := SetStatus(STS_ERROR, xProcerror, 'xProcerrorcontext', cDS_METHOD);
      return(-1); exit;
    end;
    vNrSeqMovRel := itemXmlF('NR_SEQMOVREL', voParams);

    setocc(tTMP_K03NR, 1);
    while (xStatus >= 0) do begin
      vVlLancto := item_f('VL_SISTEMA', tTMP_K03NR) - item_f('VL_RETIRADA', tTMP_K03NR);
      if (vCdEmpresa = item_f('NR_CHAVE01', tTMP_K03NR)) then begin
        if (item_f('VL_SISTEMA', tTMP_K03NR) > 0)  and (vVlLancto > 0) then begin
          if (gInLogMovCtaPes = True) then begin
            viParams := '';
            putitemXml(viParams, 'NR_CTAPES', item_f('NR_CTAPES', tFCX_CAIXAC));
            putitemXml(viParams, 'DT_SALDO', itemXml('DT_SISTEMA', PARAM_GLB));
            voParams := activateCmp('FCCSVCO002', 'buscaSaldoConta', viParams); (*,,'',,, *)
            if (xStatus < 0) then begin
              Result := voParams;
              return(-1); exit;
            end;
            vVlSaldoAnt := itemXmlF('VL_SALDO', voParams);

            viParams := '';
            putitemXml(viParams, 'NR_CTAPES', item_f('NR_CTAPES', tFCX_CAIXAC));
            putitemXml(viParams, 'TP_DOCUMENTO', item_f('NR_CHAVE02', tTMP_K03NR));
            putitemXml(viParams, 'NR_SEQHISTRELSUB', item_f('NR_CHAVE03', tTMP_K03NR));
            putitemXml(viParams, 'DT_SALDO', itemXml('DT_SISTEMA', PARAM_GLB));
            voParams := activateCmp('FCCSVCO002', 'buscaSaldoCtaTp', viParams); (*,,'',,, *)
            if (xStatus < 0) then begin
              Result := voParams;
              return(-1); exit;
            end;
            vVlSaldoAntDoc := itemXmlF('VL_SALDO', voParams);
          end;

          viParams := '';
          putitemXml(viParams, 'CD_EMPRESA', item_f('NR_CHAVE01', tTMP_K03NR));
          putitemXml(viParams, 'NR_CTAPES', item_f('NR_CTAPES', tFCX_CAIXAC));
          putitemXml(viParams, 'DT_MOVIMENTO', itemXml('DT_SISTEMA', PARAM_GLB));
          if (item_f('NR_CHAVE02', tTMP_K03NR) <> 9) then begin
            putitemXml(viParams, 'CD_HISTORICO', 835);
          end else begin
            putitemXml(viParams, 'CD_HISTORICO', 836);
          end;
          putitemXml(viParams, 'VL_LANCTO', vVlLancto);
          putitemXml(viParams, 'IN_ESTORNO', 'N');
          putitemXml(viParams, 'TP_DOCUMENTO', item_f('NR_CHAVE02', tTMP_K03NR));
          putitemXml(viParams, 'NR_SEQHISTRELSUB', item_f('NR_CHAVE03', tTMP_K03NR));

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

            viParams := '';
            putitemXml(viParams, 'NR_CTAPES', item_f('NR_CTAPES', tFCX_CAIXAC));
            putitemXml(viParams, 'DT_SALDO', itemXml('DT_SISTEMA', PARAM_GLB));
            voParams := activateCmp('FCCSVCO002', 'buscaSaldoConta', viParams); (*,,'',,, *)
            if (xStatus < 0) then begin
              Result := voParams;
              return(-1); exit;
            end;
            vVlSaldoAtual := itemXmlF('VL_SALDO', voParams);

            viParams := '';
            putitemXml(viParams, 'NR_CTAPES', item_f('NR_CTAPES', tFCX_CAIXAC));
            putitemXml(viParams, 'TP_DOCUMENTO', item_f('NR_CHAVE02', tTMP_K03NR));
            putitemXml(viParams, 'NR_SEQHISTRELSUB', item_f('NR_CHAVE03', tTMP_K03NR));
            putitemXml(viParams, 'DT_SALDO', itemXml('DT_SISTEMA', PARAM_GLB));
            voParams := activateCmp('FCCSVCO002', 'buscaSaldoCtaTp', viParams); (*,,'',,, *)
            if (xStatus < 0) then begin
              Result := voParams;
              return(-1); exit;
            end;
            vVlSaldoAtualDoc := itemXmlF('VL_SALDO', voParams);

            viParams := '';
            putitemXml(viParams, 'TP_PROCESSO', 5);
            putitemXml(viParams, 'TP_DOCUMENTO', item_f('NR_CHAVE02', tTMP_K03NR));
            putitemXml(viParams, 'NR_CTAPES', item_f('NR_CTAPES', tFCX_CAIXAC));
            putitemXml(viParams, 'VL_LANCAMENTO', vVlLancto);
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
            putitemXml(viParams, 'TP_DOCUMENTO', item_f('NR_CHAVE02', tTMP_K03NR));
            putitemXml(viParams, 'NR_SEQHISTRELSUB', item_f('NR_CHAVE03', tTMP_K03NR));
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
          if (item_f('NR_CHAVE02', tTMP_K03NR) <> 9) then begin
            putitemXml(viParams, 'CD_HISTORICO', 836);
            putitemXml(viParams, 'TP_DOCUMENTO', item_f('NR_CHAVE02', tTMP_K03NR));
          end else begin
            putitemXml(viParams, 'CD_HISTORICO', 835);
            putitemXml(viParams, 'TP_DOCUMENTO', 3);
          end;
          putitemXml(viParams, 'VL_LANCTO', vVlLancto);
          putitemXml(viParams, 'IN_ESTORNO', 'N');
          putitemXml(viParams, 'DS_AUX', 'OPERADOR: ' + CD_OPERADOR + '.FCX_CAIXAC');
          putitemXml(viParams, 'NR_SEQHISTRELSUB', item_f('NR_CHAVE03', tTMP_K03NR));

          if (vNrSeqMovRel > 0) then begin
            putitemXml(viParams, 'NR_SEQMOVREL', vNrSeqMovRel);
          end;

          voParams := activateCmp('FCCSVCO002', 'movimentaConta', viParams); (*,,,, *)
          if (xStatus < 0) then begin
            Result := voParams;
            return(-1); exit;
          end;
          if (gInLogMovCtaPes = True) then begin
            vNrCtaPesFCC := itemXmlF('NR_CTAPES', voParams);
            vDtMovimFCC := itemXml('DT_MOVIM', voParams);
            vNrSeqMovFCC := itemXmlF('NR_SEQMOV', voParams);

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
            putitemXml(viParams, 'TP_DOCUMENTO', item_f('NR_CHAVE02', tTMP_K03NR));
            putitemXml(viParams, 'NR_SEQHISTRELSUB', item_f('NR_CHAVE03', tTMP_K03NR));
            putitemXml(viParams, 'DT_SALDO', itemXml('DT_SISTEMA', PARAM_GLB));
            voParams := activateCmp('FCCSVCO002', 'buscaSaldoCtaTp', viParams); (*,,'',,, *)
            if (xStatus < 0) then begin
              Result := voParams;
              return(-1); exit;
            end;
            vVlSaldoAtualDoc := itemXmlF('VL_SALDO', voParams);

            viParams := '';
            putitemXml(viParams, 'TP_PROCESSO', 5);
            putitemXml(viParams, 'TP_DOCUMENTO', item_f('NR_CHAVE02', tTMP_K03NR));
            putitemXml(viParams, 'NR_CTAPES', vCxConta);
            putitemXml(viParams, 'VL_LANCAMENTO', vVlLancto);
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
          if (vUsaFilial = 0)  and (item_f('NR_CHAVE02', tTMP_K03NR) <> 3)  and (item_f('NR_CHAVE02', tTMP_K03NR) <> 9)  and (vInLoja = False) then begin
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
              putitemXml(viParams, 'TP_DOCUMENTO', item_f('NR_CHAVE02', tTMP_K03NR));
              putitemXml(viParams, 'NR_SEQHISTRELSUB', item_f('NR_CHAVE03', tTMP_K03NR));
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
            putitemXml(viParams, 'CD_HISTORICO', 835);
            putitemXml(viParams, 'VL_LANCTO', vVlLancto);
            putitemXml(viParams, 'IN_ESTORNO', 'N');
            putitemXml(viParams, 'DS_AUX', 'OPERADOR: item_f('CD_OPERADOR', tFCX_CAIXAC)');
            putitemXml(viParams, 'TP_DOCUMENTO', item_f('NR_CHAVE02', tTMP_K03NR));
            putitemXml(viParams, 'NR_SEQHISTRELSUB', item_f('NR_CHAVE03', tTMP_K03NR));

            if (vNrSeqMovRel > 0) then begin
              putitemXml(viParams, 'NR_SEQMOVREL', vNrSeqMovRel);
            end;

            voParams := activateCmp('FCCSVCO002', 'movimentaConta', viParams); (*,,,, *)
            if (xStatus < 0) then begin
              Result := voParams;
              return(-1); exit;
            end;
            if (gInLogMovCtaPes = True) then begin
              vNrCtaPesFCC := itemXmlF('NR_CTAPES', voParams);
              vDtMovimFCC := itemXml('DT_MOVIM', voParams);
              vNrSeqMovFCC := itemXmlF('NR_SEQMOV', voParams);

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
              putitemXml(viParams, 'TP_DOCUMENTO', item_f('NR_CHAVE02', tTMP_K03NR));
              putitemXml(viParams, 'NR_SEQHISTRELSUB', item_f('NR_CHAVE03', tTMP_K03NR));
              putitemXml(viParams, 'DT_SALDO', itemXml('DT_SISTEMA', PARAM_GLB));
              voParams := activateCmp('FCCSVCO002', 'buscaSaldoCtaTp', viParams); (*,,'',,, *)
              if (xStatus < 0) then begin
                Result := voParams;
                return(-1); exit;
              end;
              vVlSaldoAtualDoc := itemXmlF('VL_SALDO', voParams);

              viParams := '';
              putitemXml(viParams, 'TP_PROCESSO', 5);
              putitemXml(viParams, 'TP_DOCUMENTO', item_f('NR_CHAVE02', tTMP_K03NR));
              putitemXml(viParams, 'NR_CTAPES', vCxConta);
              putitemXml(viParams, 'VL_LANCAMENTO', vVlLancto);
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
        if (item_f('NR_CHAVE02', tTMP_K03NR) = 3) then begin
          clear_e(tFCC_CTAPES);
          putitem_e(tFCC_CTAPES, 'NR_CTAPES', item_f('NR_CTAPES', tFCX_CAIXAC));
          retrieve_e(tFCC_CTAPES);
          if (xStatus >= 0) then begin
            putitem_e(tFCC_CTAPES, 'VL_LIMITE', item_f('VL_FUNDO', tTMP_K03NR));

            voParams := tFCC_CTAPES.Salvar();
            if (xStatus < 0) then begin
              Result := voParams;
              return(-1); exit;
            end;
          end;
        end;
        if (item_f('VL_FUNDO', tTMP_K03NR) > 0)  and (item_f('NR_CHAVE02', tTMP_K03NR) = 3) then begin
          if (gInLogMovCtaPes = True) then begin
            viParams := '';
            putitemXml(viParams, 'NR_CTAPES', item_f('NR_CTAPES', tFCX_CAIXAC));
            putitemXml(viParams, 'DT_SALDO', itemXml('DT_SISTEMA', PARAM_GLB));
            voParams := activateCmp('FCCSVCO002', 'buscaSaldoConta', viParams); (*,,'',,, *)
            if (xStatus < 0) then begin
              Result := voParams;
              return(-1); exit;
            end;
            vVlSaldoAnt := itemXmlF('VL_SALDO', voParams);

            viParams := '';
            putitemXml(viParams, 'NR_CTAPES', item_f('NR_CTAPES', tFCX_CAIXAC));
            putitemXml(viParams, 'TP_DOCUMENTO', item_f('NR_CHAVE02', tTMP_K03NR));
            putitemXml(viParams, 'NR_SEQHISTRELSUB', item_f('NR_CHAVE03', tTMP_K03NR));
            putitemXml(viParams, 'DT_SALDO', itemXml('DT_SISTEMA', PARAM_GLB));
            voParams := activateCmp('FCCSVCO002', 'buscaSaldoCtaTp', viParams); (*,,'',,, *)
            if (xStatus < 0) then begin
              Result := voParams;
              return(-1); exit;
            end;
            vVlSaldoAntDoc := itemXmlF('VL_SALDO', voParams);
          end;

          viParams := '';
          putitemXml(viParams, 'CD_EMPRESA', item_f('NR_CHAVE01', tTMP_K03NR));
          putitemXml(viParams, 'NR_CTAPES', item_f('NR_CTAPES', tFCX_CAIXAC));
          putitemXml(viParams, 'DT_MOVIMENTO', itemXml('DT_SISTEMA', PARAM_GLB));
          putitemXml(viParams, 'CD_HISTORICO', 855);
          putitemXml(viParams, 'VL_LANCTO', item_f('VL_FUNDO', tTMP_K03NR));
          putitemXml(viParams, 'IN_ESTORNO', 'N');
          putitemXml(viParams, 'TP_DOCUMENTO', item_f('NR_CHAVE02', tTMP_K03NR));
          putitemXml(viParams, 'NR_SEQHISTRELSUB', item_f('NR_CHAVE03', tTMP_K03NR));

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

            viParams := '';
            putitemXml(viParams, 'NR_CTAPES', item_f('NR_CTAPES', tFCX_CAIXAC));
            putitemXml(viParams, 'DT_SALDO', itemXml('DT_SISTEMA', PARAM_GLB));
            voParams := activateCmp('FCCSVCO002', 'buscaSaldoConta', viParams); (*,,'',,, *)
            if (xStatus < 0) then begin
              Result := voParams;
              return(-1); exit;
            end;
            vVlSaldoAtual := itemXmlF('VL_SALDO', voParams);

            viParams := '';
            putitemXml(viParams, 'NR_CTAPES', item_f('NR_CTAPES', tFCX_CAIXAC));
            putitemXml(viParams, 'TP_DOCUMENTO', item_f('NR_CHAVE02', tTMP_K03NR));
            putitemXml(viParams, 'NR_SEQHISTRELSUB', item_f('NR_CHAVE03', tTMP_K03NR));
            putitemXml(viParams, 'DT_SALDO', itemXml('DT_SISTEMA', PARAM_GLB));
            voParams := activateCmp('FCCSVCO002', 'buscaSaldoCtaTp', viParams); (*,,'',,, *)
            if (xStatus < 0) then begin
              Result := voParams;
              return(-1); exit;
            end;
            vVlSaldoAtualDoc := itemXmlF('VL_SALDO', voParams);

            viParams := '';
            putitemXml(viParams, 'TP_PROCESSO', 5);
            putitemXml(viParams, 'TP_DOCUMENTO', item_f('NR_CHAVE02', tTMP_K03NR));
            putitemXml(viParams, 'NR_CTAPES', item_f('NR_CTAPES', tFCX_CAIXAC));
            putitemXml(viParams, 'VL_LANCAMENTO', item_f('VL_FUNDO', tTMP_K03NR));
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
            putitemXml(viParams, 'TP_DOCUMENTO', item_f('NR_CHAVE02', tTMP_K03NR));
            putitemXml(viParams, 'NR_SEQHISTRELSUB', item_f('NR_CHAVE03', tTMP_K03NR));
            putitemXml(viParams, 'DT_SALDO', itemXml('DT_SISTEMA', PARAM_GLB));
            voParams := activateCmp('FCCSVCO002', 'buscaSaldoCtaTp', viParams); (*,,'',,, *)
            if (xStatus < 0) then begin
              Result := voParams;
              return(-1); exit;
            end;
            vVlSaldoAntDoc := itemXmlF('VL_SALDO', voParams);
          end;

          viParams := '';
          putitemXml(viParams, 'CD_EMPRESA', item_f('NR_CHAVE01', tTMP_K03NR));
          putitemXml(viParams, 'NR_CTAPES', vCxConta);
          putitemXml(viParams, 'DT_MOVIMENTO', itemXml('DT_SISTEMA', PARAM_GLB));
          putitemXml(viParams, 'CD_HISTORICO', 857);
          putitemXml(viParams, 'VL_LANCTO', item_f('VL_FUNDO', tTMP_K03NR));
          putitemXml(viParams, 'IN_ESTORNO', 'N');
          putitemXml(viParams, 'TP_DOCUMENTO', item_f('NR_CHAVE02', tTMP_K03NR));
          putitemXml(viParams, 'NR_SEQHISTRELSUB', item_f('NR_CHAVE03', tTMP_K03NR));
          putitemXml(viParams, 'DS_AUX', 'OPERADOR: ' + CD_OPERADOR + '.FCX_CAIXAC');

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
            putitemXml(viParams, 'TP_DOCUMENTO', item_f('NR_CHAVE02', tTMP_K03NR));
            putitemXml(viParams, 'NR_SEQHISTRELSUB', item_f('NR_CHAVE03', tTMP_K03NR));
            putitemXml(viParams, 'DT_SALDO', itemXml('DT_SISTEMA', PARAM_GLB));
            voParams := activateCmp('FCCSVCO002', 'buscaSaldoCtaTp', viParams); (*,,'',,, *)
            if (xStatus < 0) then begin
              Result := voParams;
              return(-1); exit;
            end;
            vVlSaldoAtualDoc := itemXmlF('VL_SALDO', voParams);

            viParams := '';
            putitemXml(viParams, 'TP_PROCESSO', 5);
            putitemXml(viParams, 'TP_DOCUMENTO', item_f('NR_CHAVE02', tTMP_K03NR));
            putitemXml(viParams, 'NR_CTAPES', vCxConta);
            putitemXml(viParams, 'VL_LANCAMENTO', item_f('VL_FUNDO', tTMP_K03NR));
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
        if (vVlLancto < 0)  and (item_f('NR_CHAVE02', tTMP_K03NR) = 3 ) or (item_f('NR_CHAVE02', tTMP_K03NR) = 9) then begin
          vVlLancto := vVlLancto * (-1);

          if (gInLogMovCtaPes = True) then begin
            viParams := '';
            putitemXml(viParams, 'NR_CTAPES', item_f('NR_CTAPES', tFCX_CAIXAC));
            putitemXml(viParams, 'DT_SALDO', itemXml('DT_SISTEMA', PARAM_GLB));
            voParams := activateCmp('FCCSVCO002', 'buscaSaldoConta', viParams); (*,,'',,, *)
            if (xStatus < 0) then begin
              Result := voParams;
              return(-1); exit;
            end;
            vVlSaldoAnt := itemXmlF('VL_SALDO', voParams);

            viParams := '';
            putitemXml(viParams, 'NR_CTAPES', item_f('NR_CTAPES', tFCX_CAIXAC));
            putitemXml(viParams, 'TP_DOCUMENTO', item_f('NR_CHAVE02', tTMP_K03NR));
            putitemXml(viParams, 'NR_SEQHISTRELSUB', item_f('NR_CHAVE03', tTMP_K03NR));
            putitemXml(viParams, 'DT_SALDO', itemXml('DT_SISTEMA', PARAM_GLB));
            voParams := activateCmp('FCCSVCO002', 'buscaSaldoCtaTp', viParams); (*,,'',,, *)
            if (xStatus < 0) then begin
              Result := voParams;
              return(-1); exit;
            end;
            vVlSaldoAntDoc := itemXmlF('VL_SALDO', voParams);
          end;

          viParams := '';
          putitemXml(viParams, 'CD_EMPRESA', item_f('NR_CHAVE01', tTMP_K03NR));
          putitemXml(viParams, 'NR_CTAPES', item_f('NR_CTAPES', tFCX_CAIXAC));
          putitemXml(viParams, 'DT_MOVIMENTO', itemXml('DT_SISTEMA', PARAM_GLB));
          if (item_f('NR_CHAVE02', tTMP_K03NR) = 3) then begin
            putitemXml(viParams, 'CD_HISTORICO', 828);
          end else begin
            putitemXml(viParams, 'CD_HISTORICO', 829);
          end;
          putitemXml(viParams, 'VL_LANCTO', vVlLancto);
          putitemXml(viParams, 'IN_ESTORNO', 'N');
          putitemXml(viParams, 'TP_DOCUMENTO', item_f('NR_CHAVE02', tTMP_K03NR));
          putitemXml(viParams, 'NR_SEQHISTRELSUB', item_f('NR_CHAVE03', tTMP_K03NR));

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

            viParams := '';
            putitemXml(viParams, 'NR_CTAPES', item_f('NR_CTAPES', tFCX_CAIXAC));
            putitemXml(viParams, 'DT_SALDO', itemXml('DT_SISTEMA', PARAM_GLB));
            voParams := activateCmp('FCCSVCO002', 'buscaSaldoConta', viParams); (*,,'',,, *)
            if (xStatus < 0) then begin
              Result := voParams;
              return(-1); exit;
            end;
            vVlSaldoAtual := itemXmlF('VL_SALDO', voParams);

            viParams := '';
            putitemXml(viParams, 'NR_CTAPES', item_f('NR_CTAPES', tFCX_CAIXAC));
            putitemXml(viParams, 'TP_DOCUMENTO', item_f('NR_CHAVE02', tTMP_K03NR));
            putitemXml(viParams, 'NR_SEQHISTRELSUB', item_f('NR_CHAVE03', tTMP_K03NR));
            putitemXml(viParams, 'DT_SALDO', itemXml('DT_SISTEMA', PARAM_GLB));
            voParams := activateCmp('FCCSVCO002', 'buscaSaldoCtaTp', viParams); (*,,'',,, *)
            if (xStatus < 0) then begin
              Result := voParams;
              return(-1); exit;
            end;
            vVlSaldoAtualDoc := itemXmlF('VL_SALDO', voParams);

            viParams := '';
            putitemXml(viParams, 'TP_PROCESSO', 5);
            putitemXml(viParams, 'TP_DOCUMENTO', item_f('NR_CHAVE02', tTMP_K03NR));
            putitemXml(viParams, 'NR_CTAPES', item_f('NR_CTAPES', tFCX_CAIXAC));
            putitemXml(viParams, 'VL_LANCAMENTO', vVlLancto);
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
            putitemXml(viParams, 'TP_DOCUMENTO', item_f('NR_CHAVE02', tTMP_K03NR));
            putitemXml(viParams, 'NR_SEQHISTRELSUB', item_f('NR_CHAVE03', tTMP_K03NR));
            putitemXml(viParams, 'DT_SALDO', itemXml('DT_SISTEMA', PARAM_GLB));
            voParams := activateCmp('FCCSVCO002', 'buscaSaldoCtaTp', viParams); (*,,'',,, *)
            if (xStatus < 0) then begin
              Result := voParams;
              return(-1); exit;
            end;
            vVlSaldoAntDoc := itemXmlF('VL_SALDO', voParams);
          end;

          viParams := '';
          putitemXml(viParams, 'CD_EMPRESA', item_f('NR_CHAVE01', tTMP_K03NR));
          putitemXml(viParams, 'NR_CTAPES', vCxConta);
          putitemXml(viParams, 'DT_MOVIMENTO', itemXml('DT_SISTEMA', PARAM_GLB));
          if (item_f('NR_CHAVE02', tTMP_K03NR) = 3) then begin
            putitemXml(viParams, 'CD_HISTORICO', 829);
          end else begin
            putitemXml(viParams, 'CD_HISTORICO', 828);
          end;
          putitemXml(viParams, 'VL_LANCTO', vVlLancto);
          putitemXml(viParams, 'IN_ESTORNO', 'N');
          putitemXml(viParams, 'TP_DOCUMENTO', item_f('NR_CHAVE02', tTMP_K03NR));
          putitemXml(viParams, 'NR_SEQHISTRELSUB', item_f('NR_CHAVE03', tTMP_K03NR));
          putitemXml(viParams, 'DS_AUX', 'OPERADOR: ' + CD_OPERADOR + '.FCX_CAIXAC');

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
            putitemXml(viParams, 'TP_DOCUMENTO', item_f('NR_CHAVE02', tTMP_K03NR));
            putitemXml(viParams, 'NR_SEQHISTRELSUB', item_f('NR_CHAVE03', tTMP_K03NR));
            putitemXml(viParams, 'DT_SALDO', itemXml('DT_SISTEMA', PARAM_GLB));
            voParams := activateCmp('FCCSVCO002', 'buscaSaldoCtaTp', viParams); (*,,'',,, *)
            if (xStatus < 0) then begin
              Result := voParams;
              return(-1); exit;
            end;
            vVlSaldoAtualDoc := itemXmlF('VL_SALDO', voParams);

            viParams := '';
            putitemXml(viParams, 'TP_PROCESSO', 5);
            putitemXml(viParams, 'TP_DOCUMENTO', item_f('NR_CHAVE02', tTMP_K03NR));
            putitemXml(viParams, 'NR_CTAPES', vCxConta);
            putitemXml(viParams, 'VL_LANCAMENTO', vVlLancto);
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

      setocc(tTMP_K03NR, curocc(tTMP_K03NR) + 1);
    end;

    clear_e(tF_FCX_CAIXAC);
    putitem_e(tF_FCX_CAIXAC, 'CD_EMPRESA', item_f('CD_EMPRESA', tFCX_CAIXAC));
    putitem_e(tF_FCX_CAIXAC, 'CD_TERMINAL', item_f('CD_TERMINAL', tFCX_CAIXAC));
    putitem_e(tF_FCX_CAIXAC, 'DT_ABERTURA', item_a('DT_ABERTURA', tFCX_CAIXAC));
    putitem_e(tF_FCX_CAIXAC, 'NR_SEQ', item_f('NR_SEQ', tFCX_CAIXAC));
    retrieve_e(tF_FCX_CAIXAC);
    if (xStatus < 0) then begin
      Result := SetStatus(STS_ERROR, 'GEN001', 'Caixa inválido.Empresa: ' + cd_empresa + '.FCX_CAIXAC Terminal: ' + cd_terminal + '.FCX_CAIXAC Dt. abertura: ' + dt_abertura + '.FCX_CAIXAC Seq. ' + nr_seq + '.FCX_CAIXAC', '');
      rollback;
      return(-1); exit;
    end;
    if (item_b('IN_FECHADO', tF_FCX_CAIXAC) = True) then begin
      Result := SetStatus(STS_AVISO, 'GEN001', 'Este caixa já fechado por outro usuário.', '');
      rollback;
      return(-1); exit;
    end;

    putitem_e(tFCX_CAIXAC, 'IN_FECHADO', True);
    putitem_e(tFCX_CAIXAC, 'DT_FECHADO', Now);

    if (item_f('VL_DIF', tSIS_TOTAIS) = 0) then begin
      putitem_e(tFCX_CAIXAC, 'IN_DIFERENCA', 'F');
    end else begin
      putitem_e(tFCX_CAIXAC, 'IN_DIFERENCA', 'T');
    end;

    voParams := tFCX_CAIXAC.Salvar();
    if (xStatus < 0) then begin
      Result := voParams;
      return(-1); exit;
    end;

    delitem(vLstEmpresa, 1);

    if (vLstEmpresa = '') then begin
      setocc(tTMP_K02, 1);
      while (xStatus >= 0) do begin
        if (item_f('VL_SISTEMA', tTMP_K02) > 0)  or (item_f('VL_DIF', tTMP_K02) <> 0) then begin
          clear_e(tFCX_CAIXAI);
          putitem_e(tFCX_CAIXAI, 'CD_EMPRESA', vCdEmpresa);
          putitem_e(tFCX_CAIXAI, 'CD_TERMINAL', vCdTerminal);
          putitem_e(tFCX_CAIXAI, 'DT_ABERTURA', vDtAbertura);
          putitem_e(tFCX_CAIXAI, 'NR_SEQ', vNrSeq);
          putitem_e(tFCX_CAIXAI, 'TP_DOCUMENTO', item_f('NR_CHAVE01', tTMP_K02));
          putitem_e(tFCX_CAIXAI, 'NR_SEQHISTRELSUB', item_f('NR_CHAVE02', tTMP_K02));
          retrieve_e(tFCX_CAIXAI);
          if (xStatus < 0) then begin
            vNrSeqItem := vNrSeqItem + 1;
            putitem_e(tFCX_CAIXAI, 'CD_OPERADOR', itemXmlF('CD_USUARIO', PARAM_GLB));
            putitem_e(tFCX_CAIXAI, 'DT_CADASTRO', Now);
            putitem_e(tFCX_CAIXAI, 'NR_SEQITEM', vNrSeqItem);
          end;
          putitem_e(tFCX_CAIXAI, 'VL_SISTEMA', item_f('VL_SISTEMA', tTMP_K02));
          putitem_e(tFCX_CAIXAI, 'VL_DIFERENCA', item_f('VL_DIF', tTMP_K02));

          voParams := tFCX_CAIXAI.Salvar();
          if (xStatus < 0) then begin
            Result := voParams;
            return(-1); exit;
          end;
        end;
        if (gInGeraSobraTpDocMalot = True) then begin
          if (item_f('VL_DIF', tTMP_K02) <> 0) then begin
            viParams := '';
            putitemXml(viParams, 'CD_EMPRESA', vCdEmpresa);
            putitemXml(viParams, 'CD_TERMINAL', vCdTerminal);
            putitemXml(viParams, 'DT_ABERTURA', vDtAbertura);
            putitemXml(viParams, 'NR_SEQ', vNrSeq);
            putitemXml(viParams, 'TP_DOCUMENTO', item_f('NR_CHAVE01', tTMP_K02));
            putitemXml(viParams, 'NR_SEQHISTRELSUB', item_f('NR_CHAVE02', tTMP_K02));
            if (item_f('VL_DIF', tTMP_K02) > 0) then begin
              putitemXml(viParams, 'TP_SOBRA', 'C');
              vVlSobra := item_f('VL_DIF', tTMP_K02);
            end else begin
              putitemXml(viParams, 'TP_SOBRA', 'D');
              vVlSobra := item_f('VL_DIF', tTMP_K02) * (-1);
            end;
            if (gModulo.gNmUsrSo = 'delfiori' ) and (vVlSobra >= 10) then begin
              askmess/question 'EXISTE UMA DIFERENÇA NO CAIXA QUE DEVE SER VERIFICADO PELO SUPORTE DA VIRTUAL AGE. POR FAVOR ENTRE EM CONTATO PELO NÚMERO (44)3619-4555 OU (44)8839-7354. DESEJA CONTINUAR COM O FECHAMENTO?', 'Não, Sim';
              if (xStatus = 1) then begin
                rollback;
                return(-1); exit;
              end;
            end;
            putitemXml(viParams, 'VL_SOBRA', vVlSobra);
            putitemXml(viParams, 'NR_CTAPES', vCxConta);
            putitemXml(viParams, 'TP_PROCESSO', 5);
            voParams := activateCmp('FCXSVCO004', 'gravarSobraCx', viParams); (*,,,, *)
            if (xStatus < 0) then begin
              Result := voParams;
              return(-1); exit;
            end;
          end;
        end else if (item_f('VL_DIF', tTMP_K02) <> 0)  and (item_f('NR_CHAVE01', tTMP_K02) = 3) then begin
          viParams := '';
          putitemXml(viParams, 'CD_EMPRESA', vCdEmpresa);
          putitemXml(viParams, 'CD_TERMINAL', vCdTerminal);
          putitemXml(viParams, 'DT_ABERTURA', vDtAbertura);
          putitemXml(viParams, 'NR_SEQ', vNrSeq);
          putitemXml(viParams, 'TP_DOCUMENTO', item_f('NR_CHAVE01', tTMP_K02));
          putitemXml(viParams, 'NR_SEQHISTRELSUB', item_f('NR_CHAVE02', tTMP_K02));

          if (item_f('VL_DIF', tTMP_K02) > 0) then begin
            putitemXml(viParams, 'TP_SOBRA', 'C');
            vVlSobra := item_f('VL_DIF', tTMP_K02);
          end else begin
            putitemXml(viParams, 'TP_SOBRA', 'D');
            vVlSobra := item_f('VL_DIF', tTMP_K02) * (-1);
          end;
          if (gModulo.gNmUsrSo = 'delfiori' ) and (vVlSobra >= 10) then begin
            askmess/question 'EXISTE UMA DIFERENÇA NO CAIXA QUE DEVE SER VERIFICADO PELO SUPORTE DA VIRTUAL AGE. POR FAVOR ENTRE EM CONTATO PELO NÚMERO (44)3619-4555 OU (44)8839-7354. DESEJA CONTINUAR COM O FECHAMENTO?', 'Não, Sim';
            if (xStatus = 1) then begin
              rollback;
              return(-1); exit;
            end;
          end;

          putitemXml(viParams, 'VL_SOBRA', vVlSobra);
          putitemXml(viParams, 'NR_CTAPES', vCxConta);
          putitemXml(viParams, 'TP_PROCESSO', 5);
          voParams := activateCmp('FCXSVCO004', 'gravarSobraCx', viParams); (*,,,, *)
          if (xStatus < 0) then begin
            Result := voParams;
            return(-1); exit;
          end;
        end;
        if (item_f('VL_DIF', tTMP_K02) > 0) then begin
          if (gInLogMovCtaPes = True) then begin
            viParams := '';
            putitemXml(viParams, 'NR_CTAPES', vCxFundo);
            putitemXml(viParams, 'DT_SALDO', itemXml('DT_SISTEMA', PARAM_GLB));
            voParams := activateCmp('FCCSVCO002', 'buscaSaldoConta', viParams); (*,,'',,, *)
            if (xStatus < 0) then begin
              Result := voParams;
              return(-1); exit;
            end;
            vVlSaldoAnt := itemXmlF('VL_SALDO', voParams);

            viParams := '';
            putitemXml(viParams, 'NR_CTAPES', vCxFundo);
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
          putitemXml(viParams, 'NR_CTAPES', vCxFundo);
          putitemXml(viParams, 'DT_MOVIMENTO', itemXml('DT_SISTEMA', PARAM_GLB));
          putitemXml(viParams, 'CD_HISTORICO', 823);
          putitemXml(viParams, 'VL_LANCTO', item_f('VL_DIF', tTMP_K02));
          putitemXml(viParams, 'IN_ESTORNO', 'N');
          putitemXml(viParams, 'DS_AUX', 'OPERADOR: ' + CD_OPERCX + '.FCX_CAIXAC');
          putitemXml(viParams, 'TP_DOCUMENTO', item_f('NR_CHAVE01', tTMP_K02));
          putitemXml(viParams, 'NR_SEQHISTRELSUB', item_f('NR_CHAVE02', tTMP_K02));
          putitemXml(viParams, 'CD_OPERCONCI', item_f('CD_OPERCX', tFCX_CAIXAC));

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

            viParams := '';
            putitemXml(viParams, 'NR_CTAPES', vCxFundo);
            putitemXml(viParams, 'DT_SALDO', itemXml('DT_SISTEMA', PARAM_GLB));
            voParams := activateCmp('FCCSVCO002', 'buscaSaldoConta', viParams); (*,,'',,, *)
            if (xStatus < 0) then begin
              Result := voParams;
              return(-1); exit;
            end;
            vVlSaldoAtual := itemXmlF('VL_SALDO', voParams);

            viParams := '';
            putitemXml(viParams, 'NR_CTAPES', vCxFundo);
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
            putitemXml(viParams, 'TP_PROCESSO', 5);
            putitemXml(viParams, 'TP_DOCUMENTO', item_f('NR_CHAVE01', tTMP_K02));
            putitemXml(viParams, 'NR_CTAPES', vCxFundo);
            putitemXml(viParams, 'VL_LANCAMENTO', item_f('VL_DIF', tTMP_K02));
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
        if (item_f('VL_DIF', tTMP_K02) < 0) then begin
          vVlDif := item_f('VL_DIF', tTMP_K02) * (-1);

          if (gInLogMovCtaPes = True) then begin
            viParams := '';
            putitemXml(viParams, 'NR_CTAPES', vCxFundo);
            putitemXml(viParams, 'DT_SALDO', itemXml('DT_SISTEMA', PARAM_GLB));
            voParams := activateCmp('FCCSVCO002', 'buscaSaldoConta', viParams); (*,,'',,, *)
            if (xStatus < 0) then begin
              Result := voParams;
              return(-1); exit;
            end;
            vVlSaldoAnt := itemXmlF('VL_SALDO', voParams);

            viParams := '';
            putitemXml(viParams, 'NR_CTAPES', vCxFundo);
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
          putitemXml(viParams, 'NR_CTAPES', vCxFundo);
          putitemXml(viParams, 'DT_MOVIMENTO', itemXml('DT_SISTEMA', PARAM_GLB));
          putitemXml(viParams, 'CD_HISTORICO', 822);
          putitemXml(viParams, 'VL_LANCTO', vVlDif);
          putitemXml(viParams, 'IN_ESTORNO', 'N');
          putitemXml(viParams, 'DS_AUX', 'OPERADOR: ' + CD_OPERCX + '.FCX_CAIXAC');
          putitemXml(viParams, 'TP_DOCUMENTO', item_f('NR_CHAVE01', tTMP_K02));
          putitemXml(viParams, 'NR_SEQHISTRELSUB', item_f('NR_CHAVE02', tTMP_K02));
          putitemXml(viParams, 'CD_OPERCONCI', item_f('CD_OPERCX', tFCX_CAIXAC));

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

            viParams := '';
            putitemXml(viParams, 'NR_CTAPES', vCxFundo);
            putitemXml(viParams, 'DT_SALDO', itemXml('DT_SISTEMA', PARAM_GLB));
            voParams := activateCmp('FCCSVCO002', 'buscaSaldoConta', viParams); (*,,'',,, *)
            if (xStatus < 0) then begin
              Result := voParams;
              return(-1); exit;
            end;
            vVlSaldoAtual := itemXmlF('VL_SALDO', voParams);

            viParams := '';
            putitemXml(viParams, 'NR_CTAPES', vCxFundo);
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
            putitemXml(viParams, 'TP_PROCESSO', 5);
            putitemXml(viParams, 'TP_DOCUMENTO', item_f('NR_CHAVE01', tTMP_K02));
            putitemXml(viParams, 'NR_CTAPES', vCxFundo);
            putitemXml(viParams, 'VL_LANCAMENTO', vVlDif);
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
        setocc(tTMP_K02, curocc(tTMP_K02) + 1);
      end;
    end;
  until (vLstEmpresa = '');

  commit;
  if (xStatus < 0) then begin
    rollback;
    return(-1); exit;
  end else begin
    message/info 'Fechamento efetuado com sucesso!';
  end;

  return(0); exit;
end;

//------------------------------------------------------
function TF_FCXFM003.imprime(pParams : String) : String;
//------------------------------------------------------
const
  cDS_METHOD = 'ADICIONAL=Operação: TF_FCXFM003.imprime()';
var
  viParams, voParams, viFiltro, vDsLinha, vDsLstCaixa, vDsFiltro, vDsTerminal : String;
  vInVlSistema : Boolean;
begin
  vInVlSistema := True;

  if (gInVlSistema = False) then begin
    if (item_b('IN_FECHADO', tFCX_CAIXAC) <> True) then begin
      viParams := '';
      putitemXml(viParams, 'CD_COMPONENTE', 'FCXFM003');
      putitemXml(viParams, 'DS_CAMPO', 'IN_FECHA_VL_SISTEMA');
      putitemXml(viParams, 'CD_EMPRESA', itemXmlF('CD_EMPRESA', PARAM_GLB));
      putitemXml(viParams, 'CD_USUARIO', itemXmlF('CD_USUARIO', PARAM_GLB));
      voParams := activateCmp('ADMSVCO009', 'verificaRestricao', viParams); (*,,, *)
      if (xStatus < 0) then begin
        Result := voParams;
        return(-1); exit;
      end;
    end;
  end;

  vDsLstCaixa := '';

  setocc(tTMP_K02, 1);
  while (xStatus >= 0) do begin

    vDsLinha := '';
    if (vInVlSistema = True) then begin
      putlistitensocc_e(vDsLinha, tTMP_K02);
    end else begin
      putitemXml(vDsLinha, 'IN_TOTALIZA', item_b('IN_TOTALIZA', tTMP_K02));
      putitemXml(vDsLinha, 'DS_HISTORICO', item_a('DS_HISTORICO', tTMP_K02));
      putitemXml(vDsLinha, 'DS_AUXILIAR', item_a('DS_AUXILIAR', tTMP_K02));
      putitemXml(vDsLinha, 'VL_CONTADO', item_f('VL_CONTADO', tTMP_K02));
    end;
    if (gInListaZeradoFecha = 1) then begin
      putitem(vDsLstCaixa,  vDsLinha);
    end else if (gInListaZeradoFecha = 0) then begin
      if ((item_f('VL_CONTADO', tTMP_K02) <> '')  and (item_f('VL_CONTADO', tTMP_K02) <> 0))  or ((item_f('VL_SISTEMA', tTMP_K02) <> '')  and (item_f('VL_SISTEMA', tTMP_K02) <> 0))  or %\ then begin
        ((item_f('VL_RETIRADA', tTMP_K02) <> '')  and (item_f('VL_RETIRADA', tTMP_K02) <> 0))  or ((item_f('VL_FUNDO', tTMP_K02) <> '')  and (item_f('VL_FUNDO', tTMP_K02) <> 0))  or
        ((item_f('VL_SALDO', tTMP_K02) <> '')  and (item_f('VL_SALDO', tTMP_K02) <> 0))  or ((item_f('VL_DIF', tTMP_K02) <> '')  and (item_f('VL_DIF', tTMP_K02) <> 0));
        putitem(vDsLstCaixa,  vDsLinha);
      end;
    end;

    setocc(tTMP_K02, curocc(tTMP_K02) + 1);
  end;
  setocc(tTMP_K02, 1);

  if (vDsLstCaixa <> '') then begin
    viParams := '';

    putitemXml(viParams, 'CD_EMPRESACX', item_f('CD_EMPRESA', tFCX_CAIXAC));
    putitemXml(viParams, 'NR_SEQ', item_f('NR_SEQ', tFCX_CAIXAC));
    putitemXml(viParams, 'DT_ABERTURA', item_a('DT_ABERTURA', tFCX_CAIXAC));
    putitemXml(viParams, 'CD_TERMINAL', item_f('CD_TERMINAL', tGER_TERMINAL));
    putitemXml(viParams, 'DS_TERMINAL', item_a('DS_TERMINAL', tGER_TERMINAL));
    putitemXml(viParams, 'CD_USUARIO', item_f('CD_OPERCX', tFCX_CAIXAC));
    putitemXml(viParams, 'NM_USUARIO', item_a('NM_USUARIO', tFCX_CAIXAC));
    putitemXml(viParams, 'DT_FECHADO', item_a('DT_FECHADO', tFCX_CAIXAC));
    putitemXml(viFiltro, 'DS_RESUMO', vDsLstCaixa);
    voParams := activateCmp('SISFP002', 'exec', viParams); (*'FCXR012',viFiltro,,,, *)
    if (xStatus < 0) then begin
      Result := voParams;
      return(-1); exit;
    end;
  end;

  return(0); exit;
end;

end.
