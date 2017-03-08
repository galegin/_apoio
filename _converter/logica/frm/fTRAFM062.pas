unit fTRAFM062;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, fFormTouch, ExtCtrls, cPanel, cDatasetUnf, fDialogTouch;

type
  TF_TRAFM062 = class(T_FormTouch)
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
  private
    tPES_CLIADIC,
    tPES_EMPCLIDESC,
    tPES_TABDESC,
    tSIS_DESCONTOS,
    tTRA_LIMDESCONTO : TcDatasetUnf;
    function getParam(pParams : String = '') : String;
    function setEntidade(pParams : String = '') : String;
    function preEDIT(pParams : String = '') : String;
    function posEDIT(pParams : String = '') : String;
    function preCLEAR(pParams : String = '') : String;
    function posCLEAR(pParams : String = '') : String;
    function preEDIT(pParams : String = '') : String;
    function INIT(pParams : String = '') : String;
    function valorPadrao(pParams : String = '') : String;
    function alteraDescMaximo(pParams : String = '') : String;
    function calculaDesconto(pParams : String = '') : String;
    function calculaPercDescontoMaximo(pParams : String = '') : String;
    function convPriLetraMaiuscula(pParams : String = '') : String;
    function confirmar(pParams : String = '') : String;
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
  gCdCliente,
  gCdOperacao,
  gCdUsuarioDesc,
  gdescricaoDescMax,
  gInAlteraVlLiquido,
  gInArredondaPreco,
  gInUtilizaBiometria,
  gInUtilizaDescCli,
  glowercase(,
  gprDescMax,
  gprDescMaxCli,
  gprDesconto,
  gTpLimiteDesconto,
  gVlBaseDesc,
  gVlBonus,
  gVlDesconto,
  gVlTotBruto : String;

procedure TF_TRAFM062.FormCreate(Sender: TObject);
begin
  inherited; //
  setEntidade();
end;

procedure TF_TRAFM062.FormShow(Sender: TObject);
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

procedure TF_TRAFM062.FormActivate(Sender: TObject);
begin
  inherited; //
end;

procedure TF_TRAFM062.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  inherited; //
end;

//---------------------------------------------------------------
function TF_TRAFM062.getParam(pParams : String = '') : String;
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
function TF_TRAFM062.setEntidade(pParams : String = '') : String;
//---------------------------------------------------------------
begin
  tPES_CLIADIC := TcDatasetUnf.GetEntidade(Self, 'PES_CLIADIC');
  tPES_EMPCLIDESC := TcDatasetUnf.GetEntidade(Self, 'PES_EMPCLIDESC');
  tPES_TABDESC := TcDatasetUnf.GetEntidade(Self, 'PES_TABDESC');
  tSIS_DESCONTOS := TcDatasetUnf.GetEntidade(Self, 'SIS_DESCONTOS');
  tTRA_LIMDESCONTO := TcDatasetUnf.GetEntidade(Self, 'TRA_LIMDESCONTO');
end;

//---------------------------------------------------------------
function TF_TRAFM062.preEDIT(pParams : String) : String;
//---------------------------------------------------------------
const
  cDS_METHOD = 'ADICIONAL=Operação: TF_TRAFM062.preEDIT()';
begin
  return(0); exit;
end;

//---------------------------------------------------------------
function TF_TRAFM062.posEDIT(pParams : String) : String;
//---------------------------------------------------------------
const
  cDS_METHOD = 'ADICIONAL=Operação: TF_TRAFM062.posEDIT()';
begin
  return(0); exit;
end;

//-------------------------------------------------------
function TF_TRAFM062.preCLEAR(pParams : String) : String;
//-------------------------------------------------------
const
  cDS_METHOD = 'ADICIONAL=Operação: TF_TRAFM062.preCLEAR()';
var
  viParams, voParams, vDsDescMax : String;
begin
  clear_e(tSIS_DESCONTOS);

  voParams := valorPadrao(viParams); (* *)
  if (xStatus < 0) then begin
    Result := voParams;
    return(-1); exit;
  end;

  vDsDescMax := '';
  vDsDescMax := glowercase(descricaoDescMaxg);
  voParams := convPriLetraMaiuscula(viParams); (* gdescricaoDescMax, voParams *)
  If (xProcerror);
    Result := SetStatus(STS_ERROR, xProcerror, 'xProcerrorcontext', cDS_METHOD);
  end;
  putitem_e(tSIS_DESCONTOS, 'DS_DESCMAX', voParams);

  gprompt := item_f('PR_DESCONTO', tSIS_DESCONTOS);

  return(-1); exit;
end;

//-------------------------------------------------------
function TF_TRAFM062.posCLEAR(pParams : String) : String;
//-------------------------------------------------------
const
  cDS_METHOD = 'ADICIONAL=Operação: TF_TRAFM062.posCLEAR()';
var
  viParams, voParams, vDsDescMax : String;
begin
  gprompt := item_f('PR_DESCONTO', tSIS_DESCONTOS);

  voParams := calculaPercDescontoMaximo(viParams); (* *)
  if (xStatus < 0) then begin
    Result := voParams;
    return(-1); exit;
  end;

  vDsDescMax := '';
  vDsDescMax := glowercase(descricaoDescMaxg);
  voParams := convPriLetraMaiuscula(viParams); (* gdescricaoDescMax, voParams *)
  If (xProcerror);
    Result := SetStatus(STS_ERROR, xProcerror, 'xProcerrorcontext', cDS_METHOD);
  end;
  putitem_e(tSIS_DESCONTOS, 'DS_DESCMAX', voParams);

  return(0); exit;
end;

//------------------------------------------------------
function TF_TRAFM062.preEDIT(pParams : String) : String;
//------------------------------------------------------
const
  cDS_METHOD = 'ADICIONAL=Operação: TF_TRAFM062.preEDIT()';
var
  viParams, voParams, vDsDescMax : String;
  vCdEmpresa, vCdEmpTra, vNrTransacao : Real;
  vDtTransacao : TDate;
begin
  gInArredondaPreco := itemXmlB('IN_ARREDONDAPRECO', viParams);
  gInAlteraVlLiquido := itemXmlB('IN_ALTERAVLLIQUIDO', viParams);
  gVlTotBruto := itemXmlF('VL_TOTALBRUTO', viParams);
  gVlBaseDesc := itemXmlF('VL_BASEDESC', viParams);
  gprDescMax := itemXmlF('PR_DESCMAXIMO', viParams);
  gprDesconto := itemXmlF('PR_DESCONTO', viParams);
  gVlDesconto := itemXmlF('VL_DESCONTO', viParams);
  gCdOperacao := itemXmlF('CD_OPERACAO', viParams);
  gCdCliente := itemXmlF('CD_PESSOA', viParams);
  gVlBonus := itemXmlF('VL_BONUS', viParams);
  vCdEmpresa := itemXmlF('CD_EMPRESA', PARAM_GLB);

  voParams := calculaPercDescontoMaximo(viParams); (* *)
  if (xStatus < 0) then begin
    Result := voParams;
    return(-1); exit;
  end;

  vDsDescMax := glowercase(descricaoDescMaxg);
  voParams := convPriLetraMaiuscula(viParams); (* gdescricaoDescMax, voParams *)
  If (xProcerror);
    Result := SetStatus(STS_ERROR, xProcerror, 'xProcerrorcontext', cDS_METHOD);
  end;
  putitem_e(tSIS_DESCONTOS, 'DS_DESCMAX', voParams);

  if (gprDescMax > 100) then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Desconto máximo maior que 100%!', cDS_METHOD);
    return(-1); exit;
  end;
  if (gVlBaseDesc = 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Valor base para cálculo não informado!', cDS_METHOD);
    return(-1); exit;
  end;

  voParams := valorPadrao(viParams); (* *)
  if (xStatus < 0) then begin
    Result := voParams;
    return(-1); exit;
  end;

  return(0); exit;
end;

//---------------------------------------------------
function TF_TRAFM062.INIT(pParams : String) : String;
//---------------------------------------------------
const
  cDS_METHOD = 'ADICIONAL=Operação: TF_TRAFM062.INIT()';
begin
  xParamEmp := '';
  putitem(xParamEmp,  'IN_UTILIZA_DESC_MAX_CLI');
  putitem(xParamEmp,  'TP_LIMITE_DESCONTO');
  putitem(xParamEmp,  'DESCRICAO_DESC_MAX');
  putitem(xParamEmp,  'IN_UTILIZA_BIOMETRIA_FAT');
  xParamEmp := T_ADMSVCO001.GetParamEmpresa(piCdEmpresa, xParamEmp); (*itemXml('CD_EMPRESA', *)

  gdescricaoDescMax := itemXml('DESCRICAO_DESC_MAX', xParamEmp);
  gInUtilizaDescCli := itemXmlB('IN_UTILIZA_DESC_MAX_CLI', xParamEmp);
  gTpLimiteDesconto := itemXmlF('TP_LIMITE_DESCONTO', xParamEmp);
  gInUtilizaBiometria := itemXmlB('IN_UTILIZA_BIOMETRIA_FAT', xParamEmp);

  _Caption := '' + TRAFM + '062 - Manutenção de Desconto Geral';
end;

//----------------------------------------------------------
function TF_TRAFM062.valorPadrao(pParams : String) : String;
//----------------------------------------------------------
const
  cDS_METHOD = 'ADICIONAL=Operação: TF_TRAFM062.valorPadrao()';
begin
  putitem_o(tSIS_DESCONTOS, 'PR_DESCMAX', gprDescMax);
  putitem_o(tSIS_DESCONTOS, 'VL_TOTBRUTO', gVlTotBruto);
  putitem_o(tSIS_DESCONTOS, 'VL_BASEDESC', gVlBaseDesc);
  putitem_o(tSIS_DESCONTOS, 'VL_DESCONTO', gVlDesconto);
  putitem_o(tSIS_DESCONTOS, 'PR_DESCONTO', gprDesconto);
  gCdUsuarioDesc := '';

  voParams := calculaDesconto(viParams); (* *)
  if (xStatus < 0) then begin
    Result := voParams;
    return(-1); exit;
  end;
  if (gInUtilizaDescCli = True)  and (gCdCliente > 0)  or (gTpLimiteDesconto = 1) then begin
    fieldsyntax item_a('BT_NIVELDESCONTO', tSIS_DESCONTOS), 'DIM';
  end else begin
    if (gCdOperacao = 0) then begin
      fieldsyntax item_a('BT_NIVELDESCONTO', tSIS_DESCONTOS), 'DIM';
    end else begin
      fieldsyntax item_a('BT_NIVELDESCONTO', tSIS_DESCONTOS), '';
    end;
  end;

  return(0); exit;
end;

//---------------------------------------------------------------
function TF_TRAFM062.alteraDescMaximo(pParams : String) : String;
//---------------------------------------------------------------
const
  cDS_METHOD = 'ADICIONAL=Operação: TF_TRAFM062.alteraDescMaximo()';
var
  viParams, voParams : String;
begin
  viParams := '';
  putitemXml(viParams, 'IN_USULOGADO', True);
  putitemXml(viParams, 'DS_COMPONENTE', 'TRAFM062');
  putitemXml(viParams, 'IN_UTILIZA_BIOMETRIA', gInUtilizaBiometria);
  voParams := activateCmp('ADMFM020', 'exec', viParams); (*,,, *)
  if (xStatus < 0) then begin
    return(-1); exit;
  end;

  gCdUsuarioDesc := itemXmlF('CD_USUARIO', voParams);

  clear_e(tTRA_LIMDESCONTO);
  putitem_o(tTRA_LIMDESCONTO, 'CD_OPERACAO', gCdOperacao);
  putitem_o(tTRA_LIMDESCONTO, 'CD_USUARIO', gCdUsuarioDesc);
  retrieve_e(tTRA_LIMDESCONTO);
  if (xStatus >= 0) then begin
    gprDescMax := item_f('PR_DESCMAX', tTRA_LIMDESCONTO);
    putitem_e(tSIS_DESCONTOS, 'PR_DESCMAX', item_f('PR_DESCMAX', tTRA_LIMDESCONTO));
  end else begin
    gprDescMax := 0;
    putitem_e(tSIS_DESCONTOS, 'PR_DESCMAX', 0);
    clear_e(tTRA_LIMDESCONTO);
  end;

  return(0); exit;
end;

//--------------------------------------------------------------
function TF_TRAFM062.calculaDesconto(pParams : String) : String;
//--------------------------------------------------------------
const
  cDS_METHOD = 'ADICIONAL=Operação: TF_TRAFM062.calculaDesconto()';
var
  vCalc : Real;
  viParams,voParams : String;
  vInBloqueio : Boolean;
begin
  vCalc := (item_f('VL_BASEDESC', tSIS_DESCONTOS) * item_f('PR_DESCONTO', tSIS_DESCONTOS) / 100);
  putitem_e(tSIS_DESCONTOS, 'VL_TOTALDES', vCalc[Round, 2]);
  putitem_e(tSIS_DESCONTOS, 'VL_TOTALDES', item_f('VL_TOTALDES', tSIS_DESCONTOS) + item_f('VL_DESCONTO', tSIS_DESCONTOS));
  vCalc := item_f('VL_TOTALDES', tSIS_DESCONTOS) / item_f('VL_BASEDESC', tSIS_DESCONTOS) * 100;
  putitem_e(tSIS_DESCONTOS, 'PR_TOTALDES', vCalc[Round, 6]);
  putitem_e(tSIS_DESCONTOS, 'VL_TOTLIQ', item_f('VL_BASEDESC', tSIS_DESCONTOS) - (item_f('VL_TOTALDES', tSIS_DESCONTOS) + gVlBonus));
  if (gInArredondaPreco = 1) then begin
    viParams := '';
    putitemXml(viParams, 'VL_PRECO', item_f('VL_TOTLIQ', tSIS_DESCONTOS));
    voParams := activateCmp('PRDSVCO007', 'arredondaPreco', viParams); (*,,,, *)
    if (xStatus < 0) then begin
      Result := voParams;
      return(-1); exit;
    end;
    putitem_e(tSIS_DESCONTOS, 'VL_TOTLIQ', itemXmlF('VL_PRECO', voParams));
    vCalc := ((1 - (item_f('VL_TOTLIQ', tSIS_DESCONTOS) / item_f('VL_BASEDESC', tSIS_DESCONTOS))) * 100);
    putitem_e(tSIS_DESCONTOS, 'PR_TOTALDES', vCalc [Round, 6]);
    putitem_e(tSIS_DESCONTOS, 'VL_TOTALDES', (item_f('VL_BASEDESC', tSIS_DESCONTOS) - item_f('VL_TOTLIQ', tSIS_DESCONTOS)));
  end;

  return(0); exit;
end;

//------------------------------------------------------------------------
function TF_TRAFM062.calculaPercDescontoMaximo(pParams : String) : String;
//------------------------------------------------------------------------
const
  cDS_METHOD = 'ADICIONAL=Operação: TF_TRAFM062.calculaPercDescontoMaximo()';
var
  viParams, voParams : String;
  vCdEmpresa, vCdEmpTra, vNrTransacao : Real;
  vDtTransacao : TDate;
  vInAchou : Boolean;
begin
  vCdEmpresa := itemXmlF('CD_EMPRESA', PARAM_GLB);

  if (gprDescMax > 0) then begin
  end else if (gCdCliente > 0)  and ((gInUtilizaDescCli = True)  or (gTpLimiteDesconto = 3)) then begin
    clear_e(tPES_EMPCLIDESC);
    putitem_o(tPES_EMPCLIDESC, 'CD_EMPRESA', vCdEmpresa);
    putitem_o(tPES_EMPCLIDESC, 'CD_CLIENTE', gCdCliente);
    retrieve_e(tPES_EMPCLIDESC);
    if (xStatus >= 0) then begin
      gprDescMaxCli := item_f('PR_DESCMAX', tPES_EMPCLIDESC);
      gprDescMax := item_f('PR_DESCMAX', tPES_EMPCLIDESC);
    end else begin
      gprDescMax := 0;
    end;
  end else if (gTpLimiteDesconto = 0) then begin
    gCdUsuarioDesc := itemXmlF('CD_USUARIO', PARAM_GLB);

    clear_e(tTRA_LIMDESCONTO);
    putitem_o(tTRA_LIMDESCONTO, 'CD_OPERACAO', gCdOperacao);
    putitem_o(tTRA_LIMDESCONTO, 'CD_USUARIO', gCdUsuarioDesc);
    retrieve_e(tTRA_LIMDESCONTO);
    if (xStatus >= 0) then begin
      gprDescMax := item_f('PR_DESCMAX', tTRA_LIMDESCONTO);
      putitem_e(tSIS_DESCONTOS, 'PR_DESCMAX', item_f('PR_DESCMAX', tTRA_LIMDESCONTO));
    end else begin
      gprDescMax := 0;
      putitem_e(tSIS_DESCONTOS, 'PR_DESCMAX', 0);
      clear_e(tTRA_LIMDESCONTO);
    end;
  end else if (gTpLimiteDesconto = 1 ) or (gTpLimiteDesconto = 2 ) or (gTpLimiteDesconto = 4) then begin
    vCdEmpTra := itemXmlF('CD_EMPTRA', viParams);
    vDtTransacao= itemXml('DT_TRANSACAO', viParams);
    vNrTransacao= itemXmlF('NR_TRANSACAO', viParams);

    if (vCdEmpTra = 0)  or (vDtTransacao = 0)  or (vNrTransacao = 0) then begin
      message/info 'Dados da transação não informado!';
      return(-1); exit;
    end;

    viParams := '';
    putitemXml(viParams, 'CD_EMPRESA', vCdEmpTra);
    putitemXml(viParams, 'DT_TRANSACAO', vDtTransacao);
    putitemXml(viParams, 'NR_TRANSACAO', vNrTransacao);
    voParams := activateCmp('GERSVCO110', 'validaLimiteDesconto', viParams); (*,,,, *)
    if (xStatus < 0) then begin
      Result := voParams;
      return(-1); exit;
    end;
    gprDescMax := itemXmlF('PR_DESCONTOMAX', voParams);

  end else if (gTpLimiteDesconto = 5) then begin
    vInAchou := False;

    clear_e(tPES_CLIADIC);
    putitem_o(tPES_CLIADIC, 'CD_CLIENTE', gCdCliente);
    retrieve_e(tPES_CLIADIC);
    if (xStatus >= 0) then begin
      if (item_f('CD_TABDESC', tPES_CLIADIC) <> '') then begin
        clear_e(tPES_TABDESC);
        putitem_o(tPES_TABDESC, 'CD_TABDESC', item_f('CD_TABDESC', tPES_CLIADIC));
        retrieve_e(tPES_TABDESC);
        if (xStatus >= 0) then begin
          gdescricaoDescMax := 'Tab. desconto';
          gprDescMax := item_f('PR_TABDESC', tPES_TABDESC);
          vInAchou := True;
        end;
      end;
    end;
    if (vInAchou = False) then begin
      gCdUsuarioDesc := itemXmlF('CD_USUARIO', PARAM_GLB);

      clear_e(tTRA_LIMDESCONTO);
      putitem_o(tTRA_LIMDESCONTO, 'CD_OPERACAO', gCdOperacao);
      putitem_o(tTRA_LIMDESCONTO, 'CD_USUARIO', gCdUsuarioDesc);
      retrieve_e(tTRA_LIMDESCONTO);
      if (xStatus >= 0) then begin
        gprDescMax := item_f('PR_DESCMAX', tTRA_LIMDESCONTO);
        putitem_e(tSIS_DESCONTOS, 'PR_DESCMAX', item_f('PR_DESCMAX', tTRA_LIMDESCONTO));
      end else begin
        gprDescMax := 0;
        putitem_e(tSIS_DESCONTOS, 'PR_DESCMAX', 0);
        clear_e(tTRA_LIMDESCONTO);
      end;
    end;
  end;

  return(0); exit;
end;

//--------------------------------------------------------------------
function TF_TRAFM062.convPriLetraMaiuscula(pParams : String) : String;
//--------------------------------------------------------------------
const
  cDS_METHOD = 'ADICIONAL=Operação: TF_TRAFM062.convPriLetraMaiuscula()';
var
  (* string viParams :IN / string voParams :OUT *)
  vDescricao, vPriLetra, vPriLetraM : String;
begin
  lowercase viParams, vDescricao;
  vPriLetra := vDescricao[1, 1];
  uppercase vPriLetra, vPriLetraM;
  voParams := greplace(vDescricao, 1, vPriLetra, vPriLetraM);

  return(0); exit;
end;
if (item_f('PR_TOTALDES', tSIS_DESCONTOS) < 0) then begin
  Result := SetStatus(STS_ERROR, 'GEN0001', 'Desconto não pode ser negativo!', cDS_METHOD);
  return(-1); exit;
end;

//--------------------------------------------------------
function TF_TRAFM062.confirmar(pParams : String) : String;
//--------------------------------------------------------
const
  cDS_METHOD = 'ADICIONAL=Operação: TF_TRAFM062.confirmar()';
begin
if (item_f('PR_TOTALDES', tSIS_DESCONTOS) > item_f('PR_DESCMAX', tSIS_DESCONTOS)) then begin
  if (gInUtilizaDescCli = True)  and (gCdCliente > 0) then begin
    if (item_f('PR_TOTALDES', tSIS_DESCONTOS) > gprDescMaxCli) then begin
      Result := SetStatus(STS_ERROR, 'GEN0001', 'Valor maior que o desconto máximo permitido para o cliente!', cDS_METHOD);
      return(-1); exit;
    end else begin
      if (gCdOperacao = 0) then begin
        Result := SetStatus(STS_ERROR, 'GEN0001', 'Valor maior que o desconto máximo permitido para o cliente!', cDS_METHOD);
        return(-1); exit;
      end else begin
        voParams := alteraDescMaximo(viParams); (* *)
        if (xStatus < 0) then begin
          return(-1); exit;
        end;
        if (item_f('PR_DESCMAX', tSIS_DESCONTOS) > gprDescMaxCli) then begin
          putitem_e(tSIS_DESCONTOS, 'PR_DESCMAX', gprDescMaxCli);
        end;
        if (item_f('PR_TOTALDES', tSIS_DESCONTOS) > item_f('PR_DESCMAX', tSIS_DESCONTOS)) then begin
          Result := SetStatus(STS_ERROR, 'GEN0001', 'Valor maior que o desconto máximo permitido para o cliente!', cDS_METHOD);
          return(-1); exit;
        end;
      end;
    end;
  end else begin
    if (gCdOperacao = 0) then begin
      Result := SetStatus(STS_ERROR, 'GEN0001', 'Valor maior que o desconto máximo!', cDS_METHOD);
      return(-1); exit;
    end else begin
      voParams := alteraDescMaximo(viParams); (* *)
      if (xStatus < 0) then begin
        return(-1); exit;
      end;
      if (item_f('PR_TOTALDES', tSIS_DESCONTOS) > item_f('PR_DESCMAX', tSIS_DESCONTOS)) then begin
        Result := SetStatus(STS_ERROR, 'GEN0001', 'Valor maior que o desconto máximo!', cDS_METHOD);
        return(-1); exit;
      end;
    end;
  end;
end;

putitemXml(voParams, 'PR_DESCONTO', item_f('PR_DESCONTO', tSIS_DESCONTOS));
putitemXml(voParams, 'VL_DESCONTO', item_f('VL_DESCONTO', tSIS_DESCONTOS));
putitemXml(voParams, 'PR_TOTALDESC', item_f('PR_TOTALDES', tSIS_DESCONTOS));
putitemXml(voParams, 'VL_TOTALDESC', item_f('VL_TOTALDES', tSIS_DESCONTOS));
putitemXml(voParams, 'VL_TOTALLIQUIDO', item_f('VL_TOTLIQ', tSIS_DESCONTOS));
putitemXml(voParams, 'CD_USUARIODESC', gCdUsuarioDesc);
putitemXml(voParams, 'PR_DESCMAXIMO', item_f('PR_DESCMAX', tSIS_DESCONTOS));

return(0); exit;

end;

end.
