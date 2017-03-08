unit fTRAFP059;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, fFormTouch, ExtCtrls, cPanel, cDatasetUnf;

type
  TF_TRAFP059 = class(T_FormTouch)
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
  private
    tSIS_BOTOES,
    tSIS_DESCONTO,
    tTRA_LIMDESCONTO,
    tV_TRA_TOTITEM : TcDatasetUnf;
    function setEntidade(pParams : String = '') : String; override;
    function getParam(pParams : String = '') : String; override;
    function preEDIT(pParams : String = '') : String; override;
    function posEDIT(pParams : String = '') : String; override;
    function valorPadrao(pParams : String = '') : String;
    function convPriLetraMaiuscula(pParams : String = '') : String;
    function alteraDescMaximo(pParams : String = '') : String;
    function confirmar(pParams : String = '') : String;
  protected
  public
  published
  end;

implementation

{$R *.dfm}

uses
  cActivate, cStatus, cFuncao, cXml, dModulo;

var
  gCdEmpresa,
  gCdUsuarioDesc,
  gdescricaoDescMax,
  gDtTransacao,
  gInUtilizaBiometria,
  gInUtilizaDescCli,
  gNrTransacao,
  gprDescMaximo : String;

procedure TF_TRAFP059.FormCreate(Sender: TObject);
begin
  inherited; //
end;

procedure TF_TRAFP059.FormShow(Sender: TObject);
begin
  inherited; //
end;

procedure TF_TRAFP059.FormActivate(Sender: TObject);
begin
  inherited; //
end;

procedure TF_TRAFP059.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  inherited; //
end;

//---------------------------------------------------------------
function TF_TRAFP059.getParam(pParams : String = '') : String;
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
function TF_TRAFP059.setEntidade(pParams : String = '') : String;
//---------------------------------------------------------------
begin
  tSIS_BOTOES := TcDatasetUnf.GetEntidade(Self, 'SIS_BOTOES');
  tSIS_DESCONTO := TcDatasetUnf.GetEntidade(Self, 'SIS_DESCONTO');
  tTRA_LIMDESCONTO := TcDatasetUnf.GetEntidade(Self, 'TRA_LIMDESCONTO');
  tV_TRA_TOTITEM := TcDatasetUnf.GetEntidade(Self, 'V_TRA_TOTITEM');
end;

//---------------------------------------------------------------
function TF_TRAFP059.preEDIT(pParams : String) : String;
//---------------------------------------------------------------
const
  cDS_METHOD = 'ADICIONAL=Operação: TF_TRAFP059.preEDIT()';
begin
  return(0); exit;
end;

//---------------------------------------------------------------
function TF_TRAFP059.posEDIT(pParams : String) : String;
//---------------------------------------------------------------
const
  cDS_METHOD = 'ADICIONAL=Operação: TF_TRAFP059.posEDIT()';
begin
  return(0); exit;
end;

preEDIT
const
  cDS_METHOD = 'ADICIONAL=Operação: TF_TRAFP059.preEDIT()';
begin
  gCdUsuarioDesc := itemXmlF('CD_USUARIODESC', vpiParams);

  gCdEmpresa := itemXmlF('CD_EMPRESA', vpiParams);
  gNrTransacao := itemXmlF('NR_TRANSACAO', vpiParams);
  gDtTransacao := itemXml('DT_TRANSACAO', vpiParams);
  gprDescMaximo := itemXmlF('PR_DESCMAXIMO', vpiParams);

  if (gCdEmpresa = 0) then begin
    SetStatusM(STS_ERROR, 'GEN0001', 'Empresa não informada!', '');
    return(-1); exit;
  end;
  if (gNrTransacao = 0) then begin
    SetStatusM(STS_ERROR, 'GEN0001', 'Transação não informada!', '');
    return(-1); exit;
  end;
  if (gDtTransacao = '') then begin
    SetStatusM(STS_ERROR, 'GEN0001', 'Data da transação não informada!', '');
    return(-1); exit;
  end;
  if (gprDescMaximo = '') then begin
    SetStatusM(STS_ERROR, 'GEN0001', 'Desconto máximo não informado!', '');
    return(-1); exit;
  end;
  if (gprDescMaximo > 100) then begin
    SetStatusM(STS_ERROR, 'GEN0001', 'Desconto máximo maior que 100%!', '');
    return(-1); exit;
  end;

  voParams := valorPadrao(viParams); (* *)
  if (xProcerror) then begin
    SetStatusM(STS_ERROR, xProcerror, xProcerrorcontext, '');
    return(-1); exit;
  end else if (xStatus < 0)
    return(-1); exit;
  end;
  if (item_f('PR_TOTALDESC', tSIS_DESCONTO) <= item_f('PR_DESCMAXIMO', tSIS_DESCONTO)) then begin
    macro '^ACCEPT';
  end;

  gCdUsuarioDesc := '';

  return(0); exit;
End;

posEDIT
const
  cDS_METHOD = 'ADICIONAL=Operação: TF_TRAFP059.posEDIT()';
begin
  vpoParams := '';
  putitemXml(vpoParams, 'CD_USUARIODESC', gCdUsuarioDesc);

  return(0); exit;
End;

  INIT
const
  cDS_METHOD = 'ADICIONAL=Operação: TF_TRAFP059.INIT()';
var
  viParams, voParams : String;
  vCdEmpresa : Real;
begin
  vCdEmpresa := itemXmlF('CD_EMPRESA', PARAM_GLB);

  viParams := '';
  putitem(viParams,  'DESCRICAO_DESC_MAX');
  putitem(viParams,  'IN_UTILIZA_BIOMETRIA_FAT');
  putitem(viParams,  'IN_UTILIZA_DESC_MAX_CLI');
  xParamEmp := activateCmp('ADMSVCO001', 'GetParamEmpresa', piCdEmpresa, xParamEmp); (*vCdEmpresa *)
  if (xProcerror) then begin
    SetStatusM(STS_ERROR, xProcerror, xProcerrorcontext, '');
  end else if (xCdErro)
    voParams := SetErroApl(viParams); (* xCtxErro, xCdErro, xCtxErro *)
  end;
  gdescricaoDescMax := itemXml('DESCRICAO_DESC_MAX', voParams);
  gInUtilizaBiometria := itemXmlB('IN_UTILIZA_BIOMETRIA_FAT', voParams);
  gInUtilizaDescCli := itemXmlB('IN_UTILIZA_DESC_MAX_CLI', voParams);

  voParams := convPriLetraMaiuscula(viParams); (* gdescricaoDescMax *)
  if (xProcerror) then begin
    SetStatusM(STS_ERROR, xProcerror, xProcerrorcontext, '');
  end;

  _Caption := TRAFP + '059 - Valida Desconto da Transação';
End;

  CLEANUP
const
  cDS_METHOD = 'ADICIONAL=Operação: TF_TRAFP059.CLEANUP()';
begin
End;

//----------------------------------------------------------
function TF_TRAFP059.valorPadrao(pParams : String) : String;
//----------------------------------------------------------
const
  cDS_METHOD = 'ADICIONAL=Operação: TF_TRAFP059.valorPadrao()';
begin
  clear_e(tSIS_DESCONTO);

  clear_e(tV_TRA_TOTITEM);
  putitem_o(tV_TRA_TOTITEM, 'CD_EMPRESA', gCdEmpresa);
  putitem_o(tV_TRA_TOTITEM, 'NR_TRANSACAO', gNrTransacao);
  putitem_o(tV_TRA_TOTITEM, 'DT_TRANSACAO', gDtTransacao);
  retrieve_e(tV_TRA_TOTITEM);
  if (xStatus < 0) then begin
    SetStatusM(STS_ERROR, 'GEN0001', 'Transação ' + FloatToStr(gCdEmpresa) + ' / ' + FloatToStr(gNrTransacao) + ' / ' + gDtTransacao + ' não encontrada!', '');
    return(-1); exit;
  end;

  putitem_o(tSIS_DESCONTO, 'DS_DESCMAXIMO', gdescricaoDescMax);
  putitem_o(tSIS_DESCONTO, 'VL_TOTALBRUTO', item_f('VL_TOTALBRUTO', tV_TRA_TOTITEM));
  putitem_o(tSIS_DESCONTO, 'VL_TOTALLIQUIDO', item_f('VL_TOTALLIQUIDO', tV_TRA_TOTITEM));
  putitem_o(tSIS_DESCONTO, 'PR_DESCMAXIMO', gprDescMaximo);
  putitem_o(tSIS_DESCONTO, 'VL_DESCCAPA', item_f('VL_TOTALDESCCAB', tV_TRA_TOTITEM));
  putitem_o(tSIS_DESCONTO, 'PR_DESCCAPA', (item_f('VL_TOTALDESCCAB', tV_TRA_TOTITEM) / item_f('VL_TOTALBRUTO', tV_TRA_TOTITEM)) * 100);
  putitem_o(tSIS_DESCONTO, 'VL_DESCITEM', item_f('VL_TOTALDESC', tV_TRA_TOTITEM));
  putitem_o(tSIS_DESCONTO, 'PR_DESCITEM', (item_f('VL_TOTALDESC', tV_TRA_TOTITEM) / item_f('VL_TOTALBRUTO', tV_TRA_TOTITEM)) * 100);
  putitem_o(tSIS_DESCONTO, 'VL_TOTALDESC', item_f('VL_TOTALDESCCAB', tV_TRA_TOTITEM) + item_f('VL_TOTALDESC', tV_TRA_TOTITEM));
  putitem_o(tSIS_DESCONTO, 'PR_TOTALDESC', ((item_f('VL_TOTALDESCCAB', tV_TRA_TOTITEM) + item_f('VL_TOTALDESC', tV_TRA_TOTITEM)) / item_f('VL_TOTALBRUTO', tV_TRA_TOTITEM)) * 100);

  if (gInUtilizaDescCli) then begin
    fieldsyntax 'item_a('BT_ALTERARDESCONTO', tSIS_BOTOES)', 'DIM';
  end else begin
    fieldsyntax 'item_a('BT_ALTERARDESCONTO', tSIS_BOTOES)', '';
  end;

  return(0); exit;
End;

//--------------------------------------------------------------------
function TF_TRAFP059.convPriLetraMaiuscula(pParams : String) : String;
//--------------------------------------------------------------------
const
  cDS_METHOD = 'ADICIONAL=Operação: TF_TRAFP059.convPriLetraMaiuscula()';
var
  vDescricao, vPriLetra, vPriLetraM : String;
begin
  if (piDsCampo = '') then begin
    return(-1); exit;
  end;
  end;
  0 : begin
  vPriLetra := SubStr(vDescricao, 1, 1);
  end;
  0 : begin

  piDsCampo := greplace(vDescricao, 1, vPriLetra, vPriLetraM);

  return(0); exit;
End;

//---------------------------------------------------------------
function TF_TRAFP059.alteraDescMaximo(pParams : String) : String;
//---------------------------------------------------------------
const
  cDS_METHOD = 'ADICIONAL=Operação: TF_TRAFP059.alteraDescMaximo()';
var
  viParams, voParams, vPrDescMaximoAnt : String;
begin
  viParams := '';
  putitemXml(viParams, 'IN_USULOGADO', uTRUE);
  putitemXml(viParams, 'DS_COMPONENTE', 'TRAFM062');
  putitemXml(viParams, 'IN_UTILIZA_BIOMETRIA', gInUtilizaBiometria);
  voParams := activateCmp('ADMFM020', 'exec', viParams);
  if (xProcerror) then begin
    SetStatusM(STS_ERROR, xProcerror, xProcerrorcontext, '');
    return(-1); exit;
  end else if (xStatus < 0)
    return(-1); exit;
  end;

  gCdUsuarioDesc := itemXmlF('CD_USUARIO', voParams);

  clear_e(tTRA_LIMDESCONTO);
  putitem_o(tTRA_LIMDESCONTO, 'CD_OPERACAO', item_f('CD_OPERACAO', tV_TRA_TOTITEM));
  putitem_o(tTRA_LIMDESCONTO, 'CD_USUARIO', gCdUsuarioDesc);
  retrieve_e(tTRA_LIMDESCONTO);
  if (xStatus >= 0) then begin
    gprDescMaximo := item_f('PR_DESCMAX', tTRA_LIMDESCONTO);
    putitem_e(tSIS_DESCONTO, 'PR_DESCMAXIMO', item_f('PR_DESCMAX', tTRA_LIMDESCONTO));
  end else begin
    gprDescMaximo := '';
    putitem_e(tSIS_DESCONTO, 'PR_DESCMAXIMO', '');
    clear_e(tTRA_LIMDESCONTO);
  end;

  return(0); exit;
End;

//--------------------------------------------------------
function TF_TRAFP059.confirmar(pParams : String) : String;
//--------------------------------------------------------
const
  cDS_METHOD = 'ADICIONAL=Operação: TF_TRAFP059.confirmar()';
begin
  if (item_f('PR_TOTALDESC', tSIS_DESCONTO) < 0) then begin
    SetStatusM(STS_ERROR, 'GEN0001', 'Desconto não pode ser negativo!', '');
    return(-1); exit;
  end;
  if (item_f('PR_TOTALDESC', tSIS_DESCONTO) > item_f('PR_DESCMAXIMO', tSIS_DESCONTO)) then begin
    if (!gInUtilizaDescCli) then begin
      voParams := alteraDescMaximo(viParams); (* *)
      if (xProcerror) then begin
        SetStatusM(STS_ERROR, xProcerror, xProcerrorcontext, '');
        return(-1); exit;
      end else if (xStatus < 0)
        return(-1); exit;
      end;
    end;
    if (item_f('PR_TOTALDESC', tSIS_DESCONTO) > item_f('PR_DESCMAXIMO', tSIS_DESCONTO)) then begin
      SetStatusM(STS_ERROR, 'GEN0001', 'Valor maior que o desconto máximo permitido para o cliente!', '');
      return(-1); exit;
    end;
  end;

  macro '^ACCEPT';

  return(0); exit;
End;

end.
