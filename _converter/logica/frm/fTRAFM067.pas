unit fTRAFM067;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, fFormTouch, ExtCtrls, cPanel, cDatasetUnf;

type
  TF_TRAFM067 = class(T_FormTouch)
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
  private
    tFCX_HISTREL,
    tGER_CONDPGTOC,
    tIMB_CONTRATO,
    tIMB_CONTRATOTRA,
    tSIS_DUMMY,
    tTRA_S_TRANSACAO : TcDatasetUnf;
    function setEntidade(pParams : String = '') : String;
    function getParam(pParams : String = '') : String;
    function preEDIT(pParams : String = '') : String; override;
    function posEDIT(pParams : String = '') : String; override;

    function valorPadrao(pParams : String = '') : String;
    function carregaTipoDocumento(pParams : String = '') : String;
    function geraParcela(pParams : String = '') : String;
  protected
  public
  published
  end;

implementation

{$R *.dfm}

uses
  cActivate, cStatus, cFuncao, cXml, dModulo;

var
  gCdEmpTransacao,
  gCdPessoa,
  gDtTransacao,
  gInCheque,
  gInFatura,
  gInImobiliaria,
  gInNotaP,
  glsParcela,
  gNrFaturaPadrao,
  gNrTransacao,
  gTpArredondamento : String;

procedure TF_TRAFM067.FormCreate(Sender: TObject);
begin
  inherited; //
end;

procedure TF_TRAFM067.FormShow(Sender: TObject);
begin
  inherited; //
end;

procedure TF_TRAFM067.FormActivate(Sender: TObject);
begin
  inherited; //
end;

procedure TF_TRAFM067.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  inherited; //
end;

//---------------------------------------------------------------
function TF_TRAFM067.getParam(pParams : String = '') : String;
//---------------------------------------------------------------
var
  piCdEmpresa : Real;
begin
  piCdEmpresa := itemXmlF('CD_EMPRESA', pParams);
  if (piCdEmpresa = 0) then begin
    piCdEmpresa := itemXmlF('CD_EMPRESA', PARAM_GLB);
  end;

  (*
  xParam := '';
  putitem(xParam, 'IN_USA_COND_PGTO_ESPECIAL');
  xParam := activateCmp('ADMSVCO001', 'GetParametro', xParam);
  gUsaCondPgtoEspecial := itemXmlB('IN_USA_COND_PGTO_ESPECIAL', xParam);
  
  xParamEmp := '';
  putitem(xParamEmp, 'VL_MINIMO_PARCELA');
  xParamEmp := activateCmp('ADMSVCO001', 'GetParamEmpresa', piCdEmpresa, xParamEmp);
  gVlMinimoParcela := itemXmlF('VL_MINIMO_PARCELA', xParamEmp);  
  *)

  (* colocar o conteudo da operacao INIT aqui *)

  return(0); exit;
end;

//---------------------------------------------------------------
function TF_TRAFM067.setEntidade(pParams : String = '') : String;
//---------------------------------------------------------------
begin
  tFCX_HISTREL := TcDatasetUnf.GetEntidade(Self, 'FCX_HISTREL');
  tGER_CONDPGTOC := TcDatasetUnf.GetEntidade(Self, 'GER_CONDPGTOC');
  tIMB_CONTRATO := TcDatasetUnf.GetEntidade(Self, 'IMB_CONTRATO');
  tIMB_CONTRATOTRA := TcDatasetUnf.GetEntidade(Self, 'IMB_CONTRATOTRA');
  tSIS_DUMMY := TcDatasetUnf.GetEntidade(Self, 'SIS_DUMMY');
  tTRA_S_TRANSACAO := TcDatasetUnf.GetEntidade(Self, 'TRA_S_TRANSACAO');
end;

//---------------------------------------------------------------
function TF_TRAFM067.preEDIT(pParams : String) : String;
//---------------------------------------------------------------
const
  cDS_METHOD = 'ADICIONAL=Operação: TF_TRAFM067.preEDIT()';
begin
  return(0); exit;
end;

//---------------------------------------------------------------
function TF_TRAFM067.posEDIT(pParams : String) : String;
//---------------------------------------------------------------
const
  cDS_METHOD = 'ADICIONAL=Operação: TF_TRAFM067.posEDIT()';
begin
  return(0); exit;
end;

preEDIT
const
  cDS_METHOD = 'ADICIONAL=Operação: TF_TRAFM067.preEDIT()';
begin
  gNrFaturaPadrao := itemXmlF('NR_FATURAPADRAO', vpiParams);
  gInFatura := itemXmlB('IN_FATURA', vpiParams);
  gInCheque := itemXmlB('IN_CHEQUE', vpiParams);
  gInNotaP := itemXmlB('IN_NOTAPROMISSORIA', vpiParams);
  gCdEmpTransacao := itemXmlF('CD_EMPTRANSACAO', vpiParams);
  gNrTransacao := itemXmlF('NR_TRANSACAO', vpiParams);
  gDtTransacao := itemXml('DT_TRANSACAO', vpiParams);

  voParams := valorPadrao(viParams); (* *)
  if (xProcerror) then begin
    SetStatusM(STS_ERROR, xProcerror, xProcerrorcontext, '');
    return(-1); exit;
  end else if (xStatus < 0)
    return(-1); exit;
  end;

  return(0); exit;
End;

  INIT
const
  cDS_METHOD = 'ADICIONAL=Operação: TF_TRAFM067.INIT()';
begin
  xParamEmp := '';
  putitem(xParamEmp,  'TP_ARREDOND_PARCELA_VD');
  putitem(xParamEmp,  'IN_IMOBILIARIA');
  xParamEmp := activateCmp('ADMSVCO001', 'GetParamEmpresa', piCdEmpresa, xParamEmp); (*itemXml('CD_EMPRESA' *)
  if (xProcerror) then begin
    SetStatusM(STS_ERROR, xProcerror, xProcerrorcontext, '');
  end else if (xCdErro)
    voParams := SetErroApl(viParams); (* xCtxErro, xCdErro, xCtxErro *)
  end;

  gTpArredondamento := itemXmlF('TP_ARREDOND_PARCELA_VD', xParamEmp);
  gInImobiliaria := itemXmlB('IN_IMOBILIARIA', xParamEmp);

  _Caption := TRAFM + '067 - Parcelamento de Recebimento da Transação de Venda';
End;

//----------------------------------------------------------
function TF_TRAFM067.valorPadrao(pParams : String) : String;
//----------------------------------------------------------
const
  cDS_METHOD = 'ADICIONAL=Operação: TF_TRAFM067.valorPadrao()';
begin
  voParams := carregaTipoDocumento(viParams); (* *)
  if (xProcerror) then begin
    SetStatusM(STS_ERROR, xProcerror, xProcerrorcontext, '');
    return(-1); exit;
  end;
  if (itemXml('IN_RECEBIMENTO', vpiParams) = uTRUE) then begin
    _Caption := TRAFM + '067 - Parcelamento de Recebimento';
  end;

  gCdPessoa := 0;

  clear_e(tTRA_S_TRANSACAO);
  putitem_o(tTRA_S_TRANSACAO, 'CD_EMPRESA', gCdEmpTransacao);
  putitem_o(tTRA_S_TRANSACAO, 'NR_TRANSACAO', gNrTransacao);
  putitem_o(tTRA_S_TRANSACAO, 'DT_TRANSACAO', gDtTransacao);
  retrieve_e(tTRA_S_TRANSACAO);
  if (xStatus >= 0) then begin
    gCdPessoa := item_f('CD_PESSOA', tTRA_S_TRANSACAO);
  end;
  if (gInImobiliaria = uTRUE) then begin
    clear_e(tIMB_CONTRATOTRA);
    putitem_o(tIMB_CONTRATOTRA, 'CD_EMPTRANSACAO', gCdEmpTransacao);
    putitem_o(tIMB_CONTRATOTRA, 'NR_TRANSACAO', gNrTransacao);
    putitem_o(tIMB_CONTRATOTRA, 'DT_TRANSACAO', gDtTransacao);
    retrieve_e(tIMB_CONTRATOTRA);
    if (xStatus >= 0) then begin
      if (item_f('NR_PARCELA', tIMB_CONTRATO) > 0) and (item_f('NR_DIABASEVCTO', tIMB_CONTRATO) > 0) then begin
        fieldsyntax 'item_f('CD_CONDPGTO', tGER_CONDPGTOC)', 'DIM';
        fieldsyntax 'item_a('BT_BUSCA', tGER_CONDPGTOC)', 'DIM';
        gNrFaturaPadrao := item_f('NR_CONTRATO', tIMB_CONTRATO);
      end else begin
        fieldsyntax 'item_f('CD_CONDPGTO', tGER_CONDPGTOC)', '';
        fieldsyntax 'item_a('BT_BUSCA', tGER_CONDPGTOC)', '';
      end;
    end;
  end;

  return(0); exit;
End;

//-------------------------------------------------------------------
function TF_TRAFM067.carregaTipoDocumento(pParams : String) : String;
//-------------------------------------------------------------------
const
  cDS_METHOD = 'ADICIONAL=Operação: TF_TRAFM067.carregaTipoDocumento()';
var
  vDsLstTotal, vDsGeral, vDsTpDocumento, vDsLstTpDocumento : String;
begin
  vDsLstTotal := valrep(item_a('DS_FORMAPGTO', tSIS_DUMMY));
  vDsLstTpDocumento := '';
  clear_e(tFCX_HISTREL);
  if (itemXml('IN_RECEBIMENTO', vpiParams) = uTRUE) then begin
    putitem_o(tFCX_HISTREL, 'TP_DOCUMENTO', 2);
  end else begin
    vDsTpDocumento := '';
    if (gInFatura <> uFALSE) then begin
      putitem(vDsTpDocumento,  1);
    end;
    if (gInCheque <> uFALSE) then begin
      putitem(vDsTpDocumento,  2);
    end;
    if (gInNotaP <> uFALSE) then begin
      putitem(vDsTpDocumento,  14);
    end;
    if (vDsTpDocumento = '') then begin
      putitem(vDsTpDocumento,  1);
      putitem(vDsTpDocumento,  14);
      putitem(vDsTpDocumento,  2);
    end;
    putitem_o(tFCX_HISTREL, 'TP_DOCUMENTO', vDsTpDocumento);
  end;
  putitem_o(tFCX_HISTREL, 'IN_FATURAMENTO', uTRUE);
  retrieve_e(tFCX_HISTREL);
  if (xStatus >= 0) then begin
    setocc(tFCX_HISTREL, 1);
    while (xStatus >= 0) do begin
      vDsGeral := itemXml(item_f('TP_DOCUMENTO', tFCX_HISTREL), vDsLstTotal);
      vDsTpDocumento := '';
      putitemXml(vDsTpDocumento, item_f('TP_DOCUMENTO', tFCX_HISTREL), vDsGeral);
      putitem(vDsLstTpDocumento,  vDsTpDocumento);
      setocc(tFCX_HISTREL, curocc(tFCX_HISTREL) + 1);
    end;
  end;

  valrep(putitem_e(tSIS_DUMMY, 'DS_FORMAPGTO'), vDsLstTpDocumento);

  return(0); exit;
end;

//----------------------------------------------------------
function TF_TRAFM067.geraParcela(pParams : String) : String;
//----------------------------------------------------------
const
  cDS_METHOD = 'ADICIONAL=Operação: TF_TRAFM067.geraParcela()';
var
  viParams, voParams : String;
  vDsRegistro, vDsLstParcela, vDtVencto, vDsListaParcela : String;
  vNrDia, vNrMes, vNrAno, vNrBisexto : Real;
  vDtVencimento : TDateTime;
begin
  if (gInImobiliaria = uTRUE) and (item_f('NR_PARCELA', tIMB_CONTRATO) > 0) and (item_f('NR_DIABASEVCTO', tIMB_CONTRATO) > 0) then begin
    viParams := '';
    putitemXml(viParams, 'CD_EMPCONTRATO', item_f('CD_EMPRESA', tIMB_CONTRATO));
    putitemXml(viParams, 'NR_SEQCONTRATO', item_f('NR_SEQ', tIMB_CONTRATO));
    putitemXml(viParams, 'VL_TOTAL', item_f('VL_VALOR', tSIS_DUMMY));
    if (gTpArredondamento <> '') then begin
      putitemXml(viParams, 'TP_ARREDONDAMENTO', gTpArredondamento);
    end else begin
      putitemXml(viParams, 'TP_ARREDONDAMENTO', 1);
    end;
    voParams := activateCmp('IMBSVCO001', 'geraParcelaContrato', viParams);
    if (xProcerror) then begin
      SetStatusM(STS_ERROR, xProcerror, xProcerrorcontext, '');
      return(-1); exit;
    end else if (xStatus < 0)
      SetStatusM(STS_ERROR, xCdErro, xCtxErro, '');
      return(-1); exit;
    end;
  end else begin
    viParams := '';
    putitemXml(viParams, 'CD_CONDPGTO', item_f('CD_CONDPGTO', tGER_CONDPGTOC));
    putitemXml(viParams, 'VL_TOTAL', item_f('VL_VALOR', tSIS_DUMMY));
    putitemXml(viParams, 'DT_BASE', itemXml('DT_SISTEMA', PARAM_GLB));
    putitemXml(viParams, 'CD_PESSOA', gCdPessoa);
    if (gTpArredondamento <> '') then begin
      putitemXml(viParams, 'TP_ARREDONDAMENTO', gTpArredondamento);
    end else begin
      putitemXml(viParams, 'TP_ARREDONDAMENTO', 1);
    end;
    voParams := activateCmp('GERSVCO013', 'geraParcela', viParams);
    if (xProcerror) then begin
      SetStatusM(STS_ERROR, xProcerror, xProcerrorcontext, '');
      return(-1); exit;
    end else if (xStatus < 0)
      SetStatusM(STS_ERROR, xCdErro, xCtxErro, '');
      return(-1); exit;
    end;
  end;

  glsParcela := itemXml('DS_LSTPARCELA', voParams);
  vNrMes := 0;

  if (item_f('NR_DIA', tGER_CONDPGTOC) <> 0) and (glsParcela <> '') then begin
    vDsListaParcela := '';
    vDsLstParcela := glsParcela;

    repeat
      getitem(vDsRegistro, vDsLstParcela, 1);

      vDtVencimento := itemXml('DT_VENCIMENTO', vDsRegistro);
      vNrDia := item_f('NR_DIA', tGER_CONDPGTOC);

      if (vNrMes = 0) then begin
        vNrMes := SubStr(vDtVencimento, M);
        vNrAno := SubStr(vDtVencimento, Y);
      end else begin
        vNrMes := vNrMes + 1;
        if (vNrMes > 12) then begin
          vNrMes := 1;
          vNrAno := vNrAno + 1;
        end;
      end;

      vNrBisexto := vNrAno / 4;

      if (vNrMes = 4) or (vNrMes = 6) or (vNrMes = 9) or (vNrMes = 11) and (vNrDia = 31) then begin
        vNrDia := 30;
      end else if (vNrMes = 2) and (vNrDia > 28)
        if (vNrBisexto = int(vNrBisexto)) then begin
          vNrDia := 29;
        end else begin
          vNrDia := 28;
        end;
      end;

      vDtVencto := FloatToStr(vNrDia) + '/' + FloatToStr(vNrMes) + '/' + FloatToStr(vNrAno);

      putitemXml(vDsRegistro, 'DT_VENCIMENTO', vDtVencto);
      putitem(vDsListaParcela,  vDsRegistro);

      delitem(vDsLstParcela, 1);
    until (vDsLstParcela = '');

    glsParcela := vDsListaParcela;
  end;

  return(0); exit;
End;

end.
