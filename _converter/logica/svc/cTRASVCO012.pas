unit cTRASVCO012;

interface

(* COMPONENTES 
  ADMSVCO001 / ADMSVCO027 / GERSVCO013 / GERSVCO032 / 
*)        

uses
  Classes, SysUtils, DB,
  cServiceUnf, cDataSetUnf;

type
  T_TRASVCO012 = class(TcServiceUnf)
  private
    tADM_USUARIO,
    tFCX_HISTRELSU,
    tFIS_NF,
    tGER_CONDPGTOC,
    tGER_CONDPGTOH,
    tGER_OPERACAO,
    tGER_TIPOEMBAL,
    tPED_PEDIDOC,
    tPED_PEDIDOTRA,
    tPRD_EMBALAGEM,
    tPRD_LOTEI,
    tPRD_PRODUTO,
    tPRD_PRODUTOF,
    tTRA_ITEMADIC,
    tTRA_ITEMLOTE,
    tTRA_TRANSACAO,
    tTRA_TRANSCOND,
    tTRA_TRANSITEM,
    tTRA_TROCA,
    tTRA_VENCIMENT : TcDatasetUnf;
    function getParam(pParams : String = '') : String;
    function setEntidade(pParams : String = '') : String;
  protected
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;    
  published
    function buscaVlAbertoCliente(pParams : String = '') : String;
    function validaTransacaoEncerrada(pParams : String = '') : String;
    function validaTroca(pParams : String = '') : String;
    function calculaPeso(pParams : String = '') : String;
    function calculaVolume(pParams : String = '') : String;
    function buscaDadosdoPedido(pParams : String = '') : String;
    function buscaDadosSimulador(pParams : String = '') : String;
    function validaTransacaoAndamento(pParams : String = '') : String;
    function validaTransacaoBloqueada(pParams : String = '') : String;
    function calculaPrazoMedio(pParams : String = '') : String;
    function validaNFTransacao(pParams : String = '') : String;
  end;

implementation

uses
  cADMSVCO001,
  cActivate, cStatus, cFuncao, cXml, dModulo;

var
  gCdEspecieCone,
  gCdEspecieKG,
  gCdOperacaoTroca,
  gCdOperacaoValeTroca,
  gDsLstEspecieCalcPeso,
  gDtImplantacaoV3,
  greplace(,
  gtinTinturaria,
  gTpCalcPesoLiqItemTra : String;

//---------------------------------------------------------------
constructor T_TRASVCO012.Create(AOwner: TComponent);
//---------------------------------------------------------------
begin
  inherited Create(AOwner);
  setEntidade('');
end;

//--------------------------------
destructor T_TRASVCO012.Destroy;
//--------------------------------
begin
  inherited Destroy;
end;

//---------------------------------------------------------------
function T_TRASVCO012.getParam(pParams : String = '') : String;
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
  xParam := T_ADMSVCO001.GetParametro(xParam);

  gUsaCondPgtoEspecial := itemXmlB('IN_USA_COND_PGTO_ESPECIAL', xParam);

  xParamEmp := '';
  putitem(xParamEmp, 'VL_MINIMO_PARCELA');
  xParamEmp := T_ADMSVCO001.GetParamEmpresa(piCdEmpresa, xParamEmp);

  gVlMinimoParcela := itemXmlF('VL_MINIMO_PARCELA', xParamEmp);  
  *)

  xParam := '';
  putitem(xParam, 'DT_IMPLANTACAO_V3');

  xParam := T_ADMSVCO001.GetParametro(xParam);

  gCdEspecieCone := itemXml('CD_ESPECIE_CONE', xParam);
  gCdEspecieKG := itemXml('CD_ESPECIE_KG', xParam);
  gCdOperacaoTroca := itemXml('CD_OPER_TROCA', xParam);
  gCdOperacaoValeTroca := itemXml('CD_OPER_DEV_TROCA', xParam);
  gDsLstEspecieCalcPeso := itemXml('DS_LST_ESPECIE_CALC_PESO', xParam);
  gDtImplantacaoV3 := itemXml('DT_IMPLANTACAO_V3', xParam);
  gtinTinturaria := itemXml('TIN_TINTURARIA', xParam);
  gTpCalcPesoLiqItemTra := itemXml('TP_CALC_PESOLIQ_ITEM_TRA', xParam);

  xParamEmp := '';
  putitem(xParamEmp, 'CD_ESPECIE_CONE');
  putitem(xParamEmp, 'CD_ESPECIE_KG');
  putitem(xParamEmp, 'CD_OPER_DEV_TROCA');
  putitem(xParamEmp, 'CD_OPER_TROCA');
  putitem(xParamEmp, 'DS_LST_ESPECIE_CALC_PESO');
  putitem(xParamEmp, 'DT_IMPLANTACAO_V3');
  putitem(xParamEmp, 'TIN_TINTURARIA');
  putitem(xParamEmp, 'TP_CALC_PESOLIQ_ITEM_TRA');

  xParamEmp := T_ADMSVCO001.GetParamEmpresa(piCdEmpresa, xParamEmp);

  gCdEspecieCone := itemXml('CD_ESPECIE_CONE', xParamEmp);
  gCdEspecieKG := itemXml('CD_ESPECIE_KG', xParamEmp);
  gCdOperacaoTroca := itemXml('CD_OPER_TROCA', xParamEmp);
  gCdOperacaoValeTroca := itemXml('CD_OPER_DEV_TROCA', xParamEmp);
  gDsLstEspecieCalcPeso := itemXml('DS_LST_ESPECIE_CALC_PESO', xParamEmp);
  gtinTinturaria := itemXml('TIN_TINTURARIA', xParamEmp);
  gTpCalcPesoLiqItemTra := itemXml('TP_CALC_PESOLIQ_ITEM_TRA', xParamEmp);

end;

//---------------------------------------------------------------
function T_TRASVCO012.setEntidade(pParams : String = '') : String;
//---------------------------------------------------------------
begin
  tADM_USUARIO := GetEntidade('ADM_USUARIO');
  tFCX_HISTRELSU := GetEntidade('FCX_HISTRELSU');
  tFIS_NF := GetEntidade('FIS_NF');
  tGER_CONDPGTOC := GetEntidade('GER_CONDPGTOC');
  tGER_CONDPGTOH := GetEntidade('GER_CONDPGTOH');
  tGER_OPERACAO := GetEntidade('GER_OPERACAO');
  tGER_TIPOEMBAL := GetEntidade('GER_TIPOEMBAL');
  tPED_PEDIDOC := GetEntidade('PED_PEDIDOC');
  tPED_PEDIDOTRA := GetEntidade('PED_PEDIDOTRA');
  tPRD_EMBALAGEM := GetEntidade('PRD_EMBALAGEM');
  tPRD_LOTEI := GetEntidade('PRD_LOTEI');
  tPRD_PRODUTO := GetEntidade('PRD_PRODUTO');
  tPRD_PRODUTOF := GetEntidade('PRD_PRODUTOF');
  tTRA_ITEMADIC := GetEntidade('TRA_ITEMADIC');
  tTRA_ITEMLOTE := GetEntidade('TRA_ITEMLOTE');
  tTRA_TRANSACAO := GetEntidade('TRA_TRANSACAO');
  tTRA_TRANSCOND := GetEntidade('TRA_TRANSCOND');
  tTRA_TRANSITEM := GetEntidade('TRA_TRANSITEM');
  tTRA_TROCA := GetEntidade('TRA_TROCA');
  tTRA_VENCIMENT := GetEntidade('TRA_VENCIMENT');
end;

//--------------------------------------------------------------------
function T_TRASVCO012.buscaVlAbertoCliente(pParams : String) : String;
//--------------------------------------------------------------------
const
  cDS_METHOD = 'ADICIONAL=Operação: T_TRASVCO012.buscaVlAbertoCliente()';
var
  vCdEmpresa, viParams, voParams : String;
  vCdGrupoEmpresa, vCdCliente, vVlAberto : Real;
begin
  vCdGrupoEmpresa := itemXmlF('CD_GRUPOEMPRESA', pParams);
  if (vCdGrupoEmpresa = 0) then begin
    vCdGrupoEmpresa := itemXmlF('CD_GRUPOEMPRESA', PARAM_GLB);
  end;

  vCdCliente := itemXmlF('CD_CLIENTE', pParams);
  if (vCdCliente = 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Cliente não informado!', cDS_METHOD);
    return(-1); exit;
  end;

  viParams := '';
  putitemXml(viParams, 'CD_GRUPOEMPRESA', vCdGrupoEmpresa);
  putitemXml(viParams, 'IN_VALIDALOCAL', False);
  voParams := activateCmp('GERSVCO032', 'buscaLstGrupoEmpresa', viParams); (*,,,, *)
  if (xStatus < 0) then begin
    Result := voParams;
    return(-1); exit;
  end;

  vCdEmpresa := itemXmlF('CD_EMPRESA', voParams);

  vVlAberto := 0;

  clear_e(tTRA_TRANSACAO);
  putitem_e(tTRA_TRANSACAO, 'CD_EMPRESA', vCdEmpresa);
  putitem_e(tTRA_TRANSACAO, 'CD_PESSOA', vCdCliente);
  putitem_e(tTRA_TRANSACAO, 'TP_SITUACAO', 05);
  putitem_e(tTRA_TRANSACAO, 'TP_OPERACAO', 'S');
  retrieve_e(tTRA_TRANSACAO);
  if (xStatus >= 0) then begin
    setocc(tTRA_TRANSACAO, 1);
    while (xStatus >=0) do begin
      if (item_f('TP_MODALIDADE', tGER_OPERACAO) = 4) then begin
        vVlAberto := vVlAberto + item_f('VL_TRANSACAO', tTRA_TRANSACAO);

      end;
      setocc(tTRA_TRANSACAO, curocc(tTRA_TRANSACAO) + 1);
    end;
  end;

  Result := '';
  putitemXml(Result, 'VL_ABERTO', vVlAberto);

  return(0); exit;
end;

//------------------------------------------------------------------------
function T_TRASVCO012.validaTransacaoEncerrada(pParams : String) : String;
//------------------------------------------------------------------------
const
  cDS_METHOD = 'ADICIONAL=Operação: T_TRASVCO012.validaTransacaoEncerrada()';
var
  vCdEmpresa, vDsErro, viParams, voParams, vNmUsuario : String;
  vCdUsuario : Real;
  vDtMovimento : TDate;
begin
  vCdEmpresa := itemXmlF('CD_EMPRESA', pParams);
  if (vCdEmpresa = '') then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Empresa não informada!', cDS_METHOD);
    return(-1); exit;
  end;

  getParams(pParams); (* vCdEmpresa *)
  if (xStatus < 0) then begin
    return(-1); exit;
  end;

  vCdUsuario := itemXmlF('CD_USUARIO', pParams);
  vDtMovimento := itemXml('DT_MOVIMENTO', pParams);

  vDsErro := '';
  clear_e(tTRA_TRANSACAO);
  if (gDtImplantacaoV3 <> '') then begin
    putitem_e(tTRA_TRANSACAO, 'DT_TRANSACAO', '>=' + gDtImplantacaoV + '3');
  end;
  putitem_e(tTRA_TRANSACAO, 'CD_EMPFAT', vCdEmpresa);
  putitem_e(tTRA_TRANSACAO, 'TP_ORIGEMEMISSAO', 1);
  putitem_e(tTRA_TRANSACAO, 'TP_SITUACAO', 5);
  if (vCdUsuario > 0) then begin
    putitem_e(tTRA_TRANSACAO, 'CD_OPERADOR', vCdUsuario);
  end;
  if (vDtMovimento <> '') then begin
    putitem_e(tTRA_TRANSACAO, 'DT_TRANSACAO', vDtMovimento);
  end;
  retrieve_e(tTRA_TRANSACAO);
  if (xStatus >= 0) then begin
    setocc(tTRA_TRANSACAO, 1);
    while(xStatus >= 0) do begin

      clear_e(tADM_USUARIO);
      putitem_e(tADM_USUARIO, 'CD_USUARIO', item_f('CD_OPERADOR', tTRA_TRANSACAO));
      retrieve_e(tADM_USUARIO);
      if (xStatus >= 0) then begin
        if (item_f('CD_USUARIO', tADM_USUARIO) > 0) then begin
          viParams := '';

          vNmUsuario := '';
          putitemXml(viParams, 'CD_USUARIO', item_f('CD_USUARIO', tADM_USUARIO));
          voParams := activateCmp('ADMSVCO027', 'validaUsuarioEspecial', viParams); (*,,,, *)
          if (xStatus < 0) then begin
            Result := voParams;
            return(-1); exit;
          end;
          if (voParams <> '') then begin
            vNmUsuario := itemXml('NM_USUARIO', voParams);
          end;
        end else begin
          vNmUsuario := '';
        end;
      end;
      vDsErro := '' + vDsErroEmp + './Trans./Data/Usu.: ' + CD_EMPFAT + '.TRA_TRANSACAO / ' + NR_TRANSACAO + '.TRA_TRANSACAO / ' + DT_TRANSACAO + '.TRA_TRANSACAO / ' + CD_OPERADOR + '.TRA_TRANSACAO - ' + vNmUsuario + ' ';

      setocc(tTRA_TRANSACAO, curocc(tTRA_TRANSACAO) + 1);
    end;
  end;

  Result := '';
  if (vDsErro <> '') then begin
    putitemXml(Result, 'DS_LOGERRO', vDsErro);
    return(-1); exit;
  end;

  return(0); exit;
end;

//-----------------------------------------------------------
function T_TRASVCO012.validaTroca(pParams : String) : String;
//-----------------------------------------------------------
const
  cDS_METHOD = 'ADICIONAL=Operação: T_TRASVCO012.validaTroca()';
var
  vCdEmpresa, vDsErro, vDsRegistro, vDsLstTroca : String;
  vCdUsuario, vTpSituacaoDev, vTpSituacaoVen : Real;
  vDtMovimento : TDate;
  vInErro : Boolean;
begin
  vCdEmpresa := itemXmlF('CD_EMPRESA', pParams);
  if (vCdEmpresa = '') then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Empresa não informada!', cDS_METHOD);
    return(-1); exit;
  end;

  getParams(pParams); (* vCdEmpresa *)
  if (xStatus < 0) then begin
    return(-1); exit;
  end;
  if (gCdOperacaoValeTroca = 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Parametro empresa CD_OPER_DEV_TROCA sem valor cadastrado!', cDS_METHOD);
    return(-1); exit;
  end;
  if (gCdOperacaoTroca = 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Parametro empresa CD_OPER_TROCA sem valor cadastrado!', cDS_METHOD);
    return(-1); exit;
  end;

  vDtMovimento := itemXml('DT_MOVIMENTO', pParams);

  vDsErro := '';
  vDsLstTroca := '';

  clear_e(tTRA_TRANSACAO);
  if (gDtImplantacaoV3 <> '') then begin
    putitem_e(tTRA_TRANSACAO, 'DT_TRANSACAO', '>=' + gDtImplantacaoV + '3');
  end;
  putitem_e(tTRA_TRANSACAO, 'CD_EMPFAT', vCdEmpresa);
  putitem_e(tTRA_TRANSACAO, 'TP_ORIGEMEMISSAO', 1);
  putitem_e(tTRA_TRANSACAO, 'TP_SITUACAO', 4);
  putitem_e(tTRA_TRANSACAO, 'CD_OPERACAO', gCdOperacaoValeTroca);
  if (vDtMovimento <> '') then begin
    putitem_e(tTRA_TRANSACAO, 'DT_TRANSACAO', vDtMovimento);
  end;
  retrieve_e(tTRA_TRANSACAO);
  if (xStatus >= 0) then begin
    setocc(tTRA_TRANSACAO, 1);
    while(xStatus >= 0) do begin
      clear_e(tTRA_TROCA);
      putitem_e(tTRA_TROCA, 'CD_EMPDEV', item_f('CD_EMPRESA', tTRA_TRANSACAO));
      putitem_e(tTRA_TROCA, 'NR_TRADEV', item_f('NR_TRANSACAO', tTRA_TRANSACAO));
      putitem_e(tTRA_TROCA, 'DT_TRADEV', item_a('DT_TRANSACAO', tTRA_TRANSACAO));
      retrieve_e(tTRA_TROCA);
      if (xStatus < 0) then begin
        vDsRegistro := '';
        putitemXml(vDsRegistro, 'CD_EMPDEV', item_f('CD_EMPRESA', tTRA_TRANSACAO));
        putitemXml(vDsRegistro, 'NR_TRADEV', item_f('NR_TRANSACAO', tTRA_TRANSACAO));
        putitemXml(vDsRegistro, 'DT_TRADEV', item_a('DT_TRANSACAO', tTRA_TRANSACAO));
        putitemXml(vDsRegistro, 'DS_MOTIVO', 'Vale troca sem troca vinculada');
        putitem(vDsLstTroca,  vDsRegistro);
        vDsErro := '' + vDsErroVale + ' troca sem troca vinculada: ' + CD_EMPFAT + '.TRA_TRANSACAO / ' + NR_TRANSACAO + '.TRA_TRANSACAO / ' + DT_TRANSACAO + '.TRA_TRANSACAO ';
      end;
      setocc(tTRA_TRANSACAO, curocc(tTRA_TRANSACAO) + 1);
    end;
  end;

  clear_e(tTRA_TRANSACAO);
  if (gDtImplantacaoV3 <> '') then begin
    putitem_e(tTRA_TRANSACAO, 'DT_TRANSACAO', '>=' + gDtImplantacaoV + '3');
  end;
  putitem_e(tTRA_TRANSACAO, 'CD_EMPFAT', vCdEmpresa);
  putitem_e(tTRA_TRANSACAO, 'TP_ORIGEMEMISSAO', 1);
  putitem_e(tTRA_TRANSACAO, 'TP_SITUACAO', 4);
  putitem_e(tTRA_TRANSACAO, 'CD_OPERACAO', gCdOperacaoTroca);
  if (vDtMovimento <> '') then begin
    putitem_e(tTRA_TRANSACAO, 'DT_TRANSACAO', vDtMovimento);
  end;
  retrieve_e(tTRA_TRANSACAO);
  if (xStatus >= 0) then begin
    setocc(tTRA_TRANSACAO, 1);
    while(xStatus >= 0) do begin
      clear_e(tTRA_TROCA);
      putitem_e(tTRA_TROCA, 'CD_EMPVEN', item_f('CD_EMPRESA', tTRA_TRANSACAO));
      putitem_e(tTRA_TROCA, 'NR_TRAVEN', item_f('NR_TRANSACAO', tTRA_TRANSACAO));
      putitem_e(tTRA_TROCA, 'DT_TRAVEN', item_a('DT_TRANSACAO', tTRA_TRANSACAO));
      retrieve_e(tTRA_TROCA);
      if (xStatus < 0) then begin
        vDsRegistro := '';
        putitemXml(vDsRegistro, 'CD_EMPVEN', item_f('CD_EMPRESA', tTRA_TRANSACAO));
        putitemXml(vDsRegistro, 'NR_TRAVEN', item_f('NR_TRANSACAO', tTRA_TRANSACAO));
        putitemXml(vDsRegistro, 'DT_TRAVEN', item_a('DT_TRANSACAO', tTRA_TRANSACAO));
        putitemXml(vDsRegistro, 'DS_MOTIVO', 'Troca sem vale troca vinculado');
        putitem(vDsLstTroca,  vDsRegistro);
        vDsErro := '' + vDsErroTroca + ' sem vale troca vinculado: ' + CD_EMPFAT + '.TRA_TRANSACAO / ' + NR_TRANSACAO + '.TRA_TRANSACAO / ' + DT_TRANSACAO + '.TRA_TRANSACAO ';
      end;
      setocc(tTRA_TRANSACAO, curocc(tTRA_TRANSACAO) + 1);
    end;
  end;

  clear_e(tTRA_TROCA);
  if (gDtImplantacaoV3 <> '') then begin
    putitem_e(tTRA_TROCA, 'DT_TRADEV', '>=' + gDtImplantacaoV + '3');
    putitem_e(tTRA_TROCA, 'DT_TRAVEN', '>=' + gDtImplantacaoV + '3');
  end;
  putitem_e(tTRA_TROCA, 'CD_EMPFATDEV', vCdEmpresa);
  putitem_e(tTRA_TROCA, 'CD_EMPFATVEN', vCdEmpresa);
  if (vDtMovimento <> '') then begin
    putitem_e(tTRA_TROCA, 'DT_TRADEV', vDtMovimento);
    putitem_e(tTRA_TROCA, 'DT_TRAVEN', vDtMovimento);
  end;
  retrieve_e(tTRA_TROCA);
  if (xStatus >= 0) then begin
    setocc(tTRA_TROCA, 1);
    while(xStatus >= 0) do begin
      vInErro := False;

      vTpSituacaoDev := '';
      clear_e(tTRA_TRANSACAO);
      putitem_e(tTRA_TRANSACAO, 'CD_EMPRESA', item_f('CD_EMPDEV', tTRA_TROCA));
      putitem_e(tTRA_TRANSACAO, 'NR_TRANSACAO', item_f('NR_TRADEV', tTRA_TROCA));
      putitem_e(tTRA_TRANSACAO, 'DT_TRANSACAO', item_a('DT_TRADEV', tTRA_TROCA));
      retrieve_e(tTRA_TRANSACAO);
      if (xStatus < 0) then begin
        vInErro := True;
      end else begin
        if (item_f('TP_SITUACAO', tTRA_TRANSACAO) <> 4)  and (item_f('TP_SITUACAO', tTRA_TRANSACAO) <> 6) then begin
          vInErro := True;
        end;
        vTpSituacaoDev := item_f('TP_SITUACAO', tTRA_TRANSACAO);
      end;

      vTpSituacaoVen := '';
      clear_e(tTRA_TRANSACAO);
      putitem_e(tTRA_TRANSACAO, 'CD_EMPRESA', item_f('CD_EMPVEN', tTRA_TROCA));
      putitem_e(tTRA_TRANSACAO, 'NR_TRANSACAO', item_f('NR_TRAVEN', tTRA_TROCA));
      putitem_e(tTRA_TRANSACAO, 'DT_TRANSACAO', item_a('DT_TRAVEN', tTRA_TROCA));
      retrieve_e(tTRA_TRANSACAO);
      if (xStatus < 0) then begin
        vInErro := True;
      end else begin
        if (item_f('TP_SITUACAO', tTRA_TRANSACAO) <> 4)  and (item_f('TP_SITUACAO', tTRA_TRANSACAO) <> 6) then begin
          vInErro := True;
        end;
        vTpSituacaoVen := item_f('TP_SITUACAO', tTRA_TRANSACAO);
      end;
      if (vInErro = False) then begin
        if (vTpSituacaoDev <> vTpSituacaoVen) then begin
          vInErro := True;
        end;
      end;
      if (vInErro = True) then begin
        vDsRegistro := '';
        putitemXml(vDsRegistro, 'CD_EMPDEV', item_f('CD_EMPDEV', tTRA_TROCA));
        putitemXml(vDsRegistro, 'NR_TRADEV', item_f('NR_TRADEV', tTRA_TROCA));
        putitemXml(vDsRegistro, 'DT_TRADEV', item_a('DT_TRADEV', tTRA_TROCA));
        putitemXml(vDsRegistro, 'CD_EMPVEN', item_f('CD_EMPVEN', tTRA_TROCA));
        putitemXml(vDsRegistro, 'NR_TRAVEN', item_f('NR_TRAVEN', tTRA_TROCA));
        putitemXml(vDsRegistro, 'DT_TRAVEN', item_a('DT_TRAVEN', tTRA_TROCA));
        putitemXml(vDsRegistro, 'DS_MOTIVO', 'Troca / Vale troca com situacao invalida');
        putitem(vDsLstTroca,  vDsRegistro);
        vDsErro := '' + vDsErroTroca + ' / Vale troca com situação inválida: ' + CD_EMPFATDEV + '.TRA_TROCA / ' + NR_TRADEV + '.TRA_TROCA / ' + DT_TRADEV + '.TRA_TROCA - ' + CD_EMPFATVEN + '.TRA_TROCA / ' + NR_TRAVEN + '.TRA_TROCA / ' + DT_TRAVEN + '.TRA_TROCA ';
      end;

      setocc(tTRA_TROCA, curocc(tTRA_TROCA) + 1);
    end;
  end;

  Result := '';
  if (vDsErro <> '') then begin
    putitemXml(Result, 'DS_LOGERRO', vDsErro);
    putitemXml(Result, 'DS_LSTTROCA', vDsLstTroca);
    return(-1); exit;
  end;

  return(0); exit;
end;

//-----------------------------------------------------------
function T_TRASVCO012.calculaPeso(pParams : String) : String;
//-----------------------------------------------------------
const
  cDS_METHOD = 'ADICIONAL=Operação: T_TRASVCO012.calculaPeso()';
var
  vDsLstEspecieCalcPeso, vCdEspecieCalcPeso : String;
  vCdEmpresa, vNrTransacao, vQtPeso, vQtTotContagem : Real;
  vDtTransacao : TDate;
  vQtTara, vQtPesoLiquido, vQtPesoBruto, vQtPesoEmb, vQtEmbalagem, vQtFracao : Real;
  vInAchouEspecieProduto : Boolean;
begin
  vCdEmpresa := itemXmlF('CD_EMPRESA', pParams);
  vNrTransacao := itemXmlF('NR_TRANSACAO', pParams);
  vDtTransacao := itemXml('DT_TRANSACAO', pParams);

  if (vCdEmpresa = 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Empresa da transação de devolução não informada!', cDS_METHOD);
    return(-1); exit;
  end;
  if (vNrTransacao = 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Número da transação de devolução não informado!', cDS_METHOD);
    return(-1); exit;
  end;
  if (vDtTransacao = '') then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Data da transação de devolução não informada!', cDS_METHOD);
    return(-1); exit;
  end;

  clear_e(tTRA_TRANSACAO);
  putitem_e(tTRA_TRANSACAO, 'CD_EMPRESA', vCdEmpresa);
  putitem_e(tTRA_TRANSACAO, 'NR_TRANSACAO', vNrTransacao);
  putitem_e(tTRA_TRANSACAO, 'DT_TRANSACAO', vDtTransacao);
  retrieve_e(tTRA_TRANSACAO);
  if (xStatus < 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Transação ' + FloatToStr(vNrTransacao) + ' não cadastrada!', cDS_METHOD);
    return(-1); exit;
  end;

  getParams(pParams); (* vCdEmpresa *)
  if (xStatus < 0) then begin
    return(-1); exit;
  end;

  vQtPesoEmb := 0;
  vQtEmbalagem := 0;
  vQtFracao := 0;

  vQtPeso := 0;
  vQtPesoLiquido := 0;
  vQtPesoBruto := 0;

  if (gTpCalcPesoLiqItemTra = 1) then begin
    clear_e(tTRA_ITEMADIC);
    putitem_e(tTRA_ITEMADIC, 'CD_EMPRESA', vCdEmpresa);
    putitem_e(tTRA_ITEMADIC, 'NR_TRANSACAO', vNrTransacao);
    putitem_e(tTRA_ITEMADIC, 'DT_TRANSACAO', vDtTransacao);
    retrieve_e(tTRA_ITEMADIC);
    if (xStatus >= 0) then begin
      setocc(tTRA_ITEMADIC, 1);
      while (xStatus >=0) do begin
        vQtPesoLiquido := vQtPesoLiquido + item_f('QT_PESOLIQUIDO', tTRA_ITEMADIC);
        vQtPesoBruto := vQtPesoBruto + item_f('QT_PESOBRUTO', tTRA_ITEMADIC);
        vQtPeso := vQtPesoLiquido;
        setocc(tTRA_ITEMADIC, curocc(tTRA_ITEMADIC) + 1);
      end;
    end;

  end else begin

    if (empty(tTRA_TRANSITEM) = False) then begin
      setocc(tTRA_TRANSITEM, 1);
      while (xStatus >=0) do begin
        if (gtinTinturaria = 1) then begin
          vInAchouEspecieProduto := False;
          vDsLstEspecieCalcPeso := gDsLstEspecieCalcPeso;

          repeat
            getitem(vCdEspecieCalcPeso, vDsLstEspecieCalcPeso, 1);

            if (vCdEspecieCalcPeso = item_f('CD_ESPECIE', tPRD_PRODUTO)) then begin
              vInAchouEspecieProduto := True;
            end;

            delitem(vDsLstEspecieCalcPeso, 1);
          until(vDsLstEspecieCalcPeso = '');

          if (vInAchouEspecieProduto = True) then begin
            if (gCdEspecieKG <> '')  and (gCdEspecieKG = item_f('CD_ESPECIE', tPRD_PRODUTO)) then begin
              vQtTara := 0;
              clear_e(tTRA_ITEMLOTE);
              putitem_e(tTRA_ITEMLOTE, 'CD_EMPRESA', item_f('CD_EMPRESA', tTRA_TRANSITEM));
              putitem_e(tTRA_ITEMLOTE, 'NR_TRANSACAO', item_f('NR_TRANSACAO', tTRA_TRANSITEM));
              putitem_e(tTRA_ITEMLOTE, 'DT_TRANSACAO', item_a('DT_TRANSACAO', tTRA_TRANSITEM));
              putitem_e(tTRA_ITEMLOTE, 'NR_ITEM', item_f('NR_ITEM', tTRA_TRANSITEM));
              retrieve_e(tTRA_ITEMLOTE);
              if (xStatus >= 0) then begin
                setocc(tTRA_ITEMLOTE, 1);
                while (xStatus >= 0) do begin
                  clear_e(tPRD_LOTEI);
                  putitem_e(tPRD_LOTEI, 'CD_EMPRESA', item_f('CD_EMPLOTE', tTRA_ITEMLOTE));
                  putitem_e(tPRD_LOTEI, 'NR_LOTE', item_f('NR_LOTE', tTRA_ITEMLOTE));
                  putitem_e(tPRD_LOTEI, 'NR_ITEM', item_f('NR_ITEMLOTE', tTRA_ITEMLOTE));
                  retrieve_e(tPRD_LOTEI);
                  if (xStatus >= 0) then begin
                    setocc(tPRD_LOTEI, 1);
                    while (xStatus >=0) do begin
                      vQtTara := vQtTara + item_f('QT_TARA', tPRD_LOTEI);
                      setocc(tPRD_LOTEI, curocc(tPRD_LOTEI) + 1);
                    end;
                  end;
                  setocc(tTRA_ITEMLOTE, curocc(tTRA_ITEMLOTE) + 1);
                end;
              end;
              vQtPesoLiquido := vQtPesoLiquido + item_f('QT_SOLICITADA', tTRA_TRANSITEM);
              vQtPesoBruto := vQtPesoBruto + (item_f('QT_SOLICITADA', tTRA_TRANSITEM) + vQtTara);
              vQtPeso := vQtPesoLiquido;
            end else begin
              if (item_f('QT_PESO', tPRD_PRODUTO) > 0) then begin
                if not (empty(tPRD_PRODUTOF)) then begin
                  if (vQtPesoEmb = 0) then begin
                    clear_e(tGER_TIPOEMBAL);
                    putitem_e(tGER_TIPOEMBAL, 'CD_TIPOEMBALAGEM', item_f('CD_TIPOEMBALAGEM', tPRD_PRODUTOF));
                    retrieve_e(tGER_TIPOEMBAL);
                    if (xStatus >= 0) then begin
                      vQtPesoEmb := item_f('QT_PESO', tGER_TIPOEMBAL);
                    end;

                    vQtEmbalagem := item_f('QT_EMBALAGEM', tPRD_PRODUTOF);

                  end;
                end;

                vQtTotContagem := vQtTotContagem + item_f('QT_SOLICITADA', tTRA_TRANSITEM);
                vQtPesoLiquido := vQtPesoLiquido + (item_f('QT_PESO', tPRD_PRODUTO) * item_f('QT_SOLICITADA', tTRA_TRANSITEM));

                vQtPesoBruto := vQtPesoBruto + ((item_f('QT_PESO', tPRD_PRODUTO) + item_f('QT_TARA', tPRD_PRODUTOF)) * item_f('QT_SOLICITADA', tTRA_TRANSITEM));

                vQtPeso := vQtPesoLiquido;
              end;
            end;
          end;

        end else begin
          if (item_f('QT_PESO', tPRD_PRODUTO) > 0) then begin
            vQtPesoLiquido := vQtPesoLiquido + (item_f('QT_SOLICITADA', tTRA_TRANSITEM) * item_f('QT_PESO', tPRD_PRODUTO));
            vQtPesoBruto := vQtPesoBruto   + (item_f('QT_SOLICITADA', tTRA_TRANSITEM) * item_f('QT_PESO', tPRD_PRODUTO));
            vQtPeso := vQtPesoLiquido;
          end;
        end;
        setocc(tTRA_TRANSITEM, curocc(tTRA_TRANSITEM) + 1);
      end;
    end;
  end;

  vQtEmbalagem := (vQtTotContagem / vQtEmbalagem);
  vQtFracao := vQtEmbalagem[fraction];

  if (vQtFracao > 0) then begin
    vQtEmbalagem := int(vQtEmbalagem) + 1;
  end;

  vQtPesoBruto := vQtPesoBruto + (vQtEmbalagem * vQtPesoEmb);

  Result := '';
  putitemXml(Result, 'QT_PESO', vQtPeso);
  putitemXml(Result, 'QT_PESOLIQUIDO', vQtPesoLiquido);
  putitemXml(Result, 'QT_PESOBRUTO', vQtPesoBruto);

  return(0); exit;
end;

//-------------------------------------------------------------
function T_TRASVCO012.calculaVolume(pParams : String) : String;
//-------------------------------------------------------------
const
  cDS_METHOD = 'ADICIONAL=Operação: T_TRASVCO012.calculaVolume()';
var
  vCdEmpresa, vNrTransacao, vQtVolume, vResto, vQtEmbalagem : Real;
  vDtTransacao : TDate;
begin
  vCdEmpresa := itemXmlF('CD_EMPRESA', pParams);
  vNrTransacao := itemXmlF('NR_TRANSACAO', pParams);
  vDtTransacao := itemXml('DT_TRANSACAO', pParams);

  if (vCdEmpresa = 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Empresa da transação de devolução não informada!', cDS_METHOD);
    return(-1); exit;
  end;
  if (vNrTransacao = 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Número da transação de devolução não informado!', cDS_METHOD);
    return(-1); exit;
  end;
  if (vDtTransacao = '') then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Data da transação de devolução não informada!', cDS_METHOD);
    return(-1); exit;
  end;

  clear_e(tTRA_TRANSACAO);
  putitem_e(tTRA_TRANSACAO, 'CD_EMPRESA', vCdEmpresa);
  putitem_e(tTRA_TRANSACAO, 'NR_TRANSACAO', vNrTransacao);
  putitem_e(tTRA_TRANSACAO, 'DT_TRANSACAO', vDtTransacao);
  retrieve_e(tTRA_TRANSACAO);
  if (xStatus < 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Transação ' + FloatToStr(vNrTransacao) + ' não cadastrada!', cDS_METHOD);
    return(-1); exit;
  end;

  vQtVolume := 0;

  if (empty(tTRA_TRANSITEM) = False) then begin
    setocc(tTRA_TRANSITEM, 1);
    while (xStatus >=0) do begin
      clear_e(tPRD_EMBALAGEM);
      putitem_e(tPRD_EMBALAGEM, 'CD_PRODUTO', item_f('CD_PRODUTO', tTRA_TRANSITEM));
      retrieve_e(tPRD_EMBALAGEM);
      if (xStatus < 0) then begin
        vQtEmbalagem := 0;
      end else begin
        setocc(tPRD_EMBALAGEM, -1);
        sort_e(tPRD_EMBALAGEM, '        sort/e , CD_PRODUTO, QT_EMBALAGEM;');
        setocc(tPRD_EMBALAGEM, 1);
        vQtEmbalagem := item_f('QT_EMBALAGEM', tPRD_EMBALAGEM);
      end;

      vResto := '';
      if (vQtEmbalagem = 0) then begin
          vQtVolume := vQtVolume + item_f('QT_SOLICITADA', tTRA_TRANSITEM);
      end else if (vQtEmbalagem <= item_f('QT_SOLICITADA', tTRA_TRANSITEM)) then begin
        vResto := (item_f('QT_SOLICITADA', tTRA_TRANSITEM) % vQtEmbalagem);
        if (vResto = 0) then begin
          vQtVolume := vQtVolume + (item_f('QT_SOLICITADA', tTRA_TRANSITEM) / vQtEmbalagem);
        end else begin
            vQtVolume := vQtVolume + item_f('QT_SOLICITADA', tTRA_TRANSITEM);
        end;
      end;
      setocc(tTRA_TRANSITEM, curocc(tTRA_TRANSITEM) + 1);
    end;
  end;

  Result := '';
  putitemXml(Result, 'QT_VOLUME', vQtVolume);

  return(0); exit;
end;

//------------------------------------------------------------------
function T_TRASVCO012.buscaDadosdoPedido(pParams : String) : String;
//------------------------------------------------------------------
const
  cDS_METHOD = 'ADICIONAL=Operação: T_TRASVCO012.buscaDadosdoPedido()';
var
  vCdEmpresa, vNrTransacao : Real;
  vDtTransacao : TDate;
  vCdPedido, vPrDesconto : String;
begin
  vCdEmpresa := itemXmlF('CD_EMPTRANSACAO', pParams);
  vNrTransacao := itemXmlF('NR_TRANSACAO', pParams);
  vDtTransacao := itemXml('DT_TRANSACAO', pParams);
  vCdPedido := '';

  if (vCdEmpresa = 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Empresa da transação não informada!', cDS_METHOD);
    return(-1); exit;
  end;
  if (vNrTransacao = 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Número da transação não informado!', cDS_METHOD);
    return(-1); exit;
  end;
  if (vDtTransacao = '') then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Data da transação não informada!', cDS_METHOD);
    return(-1); exit;
  end;

  clear_e(tPED_PEDIDOTRA);
  putitem_e(tPED_PEDIDOTRA, 'CD_EMPTRANSACAO', vCdEmpresa);
  putitem_e(tPED_PEDIDOTRA, 'NR_TRANSACAO', vNrTransacao);
  putitem_e(tPED_PEDIDOTRA, 'DT_TRANSACAO', vDtTransacao);
  retrieve_e(tPED_PEDIDOTRA);
  if (empty(tPED_PEDIDOTRA) = False) then begin
    setocc(tPED_PEDIDOTRA, 1);
    while (xStatus >=0) do begin
      if (vCdPedido = '') then begin
        vCdPedido := item_f('NR_PEDIDOCLIENTE', tPED_PEDIDOC);
        vPrDesconto := item_f('PR_DESCONTO', tPED_PEDIDOC);
      end else begin
        vCdPedido := '' + FloatToStr(vCdPedido) + ' / ' + NR_PEDIDOCLIENTE + '.PED_PEDIDOC';
        vPrDesconto := '' + vPrDesconto + ' / ' + PR_DESCONTO + '.PED_PEDIDOC';
      end;
      setocc(tPED_PEDIDOTRA, curocc(tPED_PEDIDOTRA) + 1);
    end;
  end;
  putitemXml(Result, 'CD_PEDIDO', vCdPedido);
  putitemXml(Result, 'PR_DESCONTO', vPrDesconto);

  return(0); exit;
end;

//-------------------------------------------------------------------
function T_TRASVCO012.buscaDadosSimulador(pParams : String) : String;
//-------------------------------------------------------------------
const
  cDS_METHOD = 'ADICIONAL=Operação: T_TRASVCO012.buscaDadosSimulador()';
var
  vCdEmpresa, vNrTransacao, vPrVariacao, vVlAbatimento, vNrParcela, vVlParcela : Real;
  vDtTransacao : TDate;
begin
  vCdEmpresa := itemXmlF('CD_EMPRESA', pParams);
  vNrTransacao := itemXmlF('NR_TRANSACAO', pParams);
  vDtTransacao := itemXml('DT_TRANSACAO', pParams);

  if (vCdEmpresa = 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Empresa da transação não informada!', cDS_METHOD);
    return(-1); exit;
  end;
  if (vNrTransacao = 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Número da transação não informado!', cDS_METHOD);
    return(-1); exit;
  end;
  if (vDtTransacao = '') then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Data da transação não informada!', cDS_METHOD);
    return(-1); exit;
  end;

  clear_e(tTRA_TRANSACAO);
  putitem_e(tTRA_TRANSACAO, 'CD_EMPRESA', vCdEmpresa);
  putitem_e(tTRA_TRANSACAO, 'NR_TRANSACAO', vNrTransacao);
  putitem_e(tTRA_TRANSACAO, 'DT_TRANSACAO', vDtTransacao);
  retrieve_e(tTRA_TRANSACAO);
  if (xStatus < 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Transação não encontrada!', cDS_METHOD);
    return(-1); exit;
  end;
  if (empty(tTRA_TRANSCOND) = 1) then begin
    return(0); exit;
  end;

  vVlAbatimento := item_f('VL_ADIANTAMENTO', tTRA_TRANSCOND) + item_f('VL_CREDEV', tTRA_TRANSCOND) + item_f('VL_ENTRADA', tTRA_TRANSCOND);

  vNrParcela := 1;
  if (item_f('TP_DOCUMENTO', tGER_CONDPGTOH) = 4) then begin
    clear_e(tFCX_HISTRELSU);
    putitem_e(tFCX_HISTRELSU, 'TP_DOCUMENTO', item_f('TP_DOCUMENTO', tGER_CONDPGTOH));
    putitem_e(tFCX_HISTRELSU, 'NR_SEQHISTRELSUB', item_f('NR_SEQHISTRELSUB', tGER_CONDPGTOH));
    retrieve_e(tFCX_HISTRELSU);
    if (xStatus >= 0) then begin
      vNrParcela := item_f('NR_PARCELAS', tFCX_HISTRELSU);
    end;
  end else begin
    clear_e(tGER_CONDPGTOC);
    putitem_e(tGER_CONDPGTOC, 'CD_CONDPGTO', item_f('CD_CONDPGTO', tGER_CONDPGTOH));
    retrieve_e(tGER_CONDPGTOC);
    if (xStatus >= 0) then begin
      if (item_f('NR_PARCELAS', tGER_CONDPGTOC) > 1) then begin
        vNrParcela := item_f('NR_PARCELAS', tGER_CONDPGTOC);
      end;
    end;
  end;

  vVlParcela := (item_f('VL_TRANSACAO', tTRA_TRANSACAO) - vVlAbatimento) / vNrParcela;
  vVlParcela := rounded(vVlParcela, 2);

  putitemXml(Result, 'PR_VARIACAO', item_f('PR_VARIACAO', tGER_CONDPGTOH));
  putitemXml(Result, 'DS_RESUMIDA', item_a('DS_RESUMIDA', tGER_CONDPGTOH));
  putitemXml(Result, 'VL_ENTRADA', item_f('VL_ENTRADA', tTRA_TRANSCOND));
  putitemXml(Result, 'VL_DESCONTO', item_f('VL_DESCONTO', tTRA_TRANSCOND));
  putitemXml(Result, 'VL_CREDEV', item_f('VL_CREDEV', tTRA_TRANSCOND));
  putitemXml(Result, 'VL_ADIANTAMENTO', item_f('VL_ADIANTAMENTO', tTRA_TRANSCOND));
  putitemXml(Result, 'VL_PARCELA', vVlParcela);
  putitemXml(Result, 'NR_PARCELA', vNrParcela);
  putitemXml(Result, 'VL_ABATIMENTO', vVlAbatimento);

  return(0); exit;
end;

//------------------------------------------------------------------------
function T_TRASVCO012.validaTransacaoAndamento(pParams : String) : String;
//------------------------------------------------------------------------
const
  cDS_METHOD = 'ADICIONAL=Operação: T_TRASVCO012.validaTransacaoAndamento()';
var
  vCdEmpresa, vDsErro, viParams, voParams, vNmUsuario : String;
  vCdUsuario : Real;
  vDtMovimento : TDate;
begin
  vCdEmpresa := itemXmlF('CD_EMPRESA', pParams);
  if (vCdEmpresa = '') then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Empresa não informada!', cDS_METHOD);
    return(-1); exit;
  end;

  getParams(pParams); (* vCdEmpresa *)
  if (xStatus < 0) then begin
    return(-1); exit;
  end;

  vCdUsuario := itemXmlF('CD_USUARIO', pParams);
  vDtMovimento := itemXml('DT_MOVIMENTO', pParams);

  vDsErro := '';
  clear_e(tTRA_TRANSACAO);
  if (gDtImplantacaoV3 <> '') then begin
    putitem_e(tTRA_TRANSACAO, 'DT_TRANSACAO', '>=' + gDtImplantacaoV + '3');
  end;
  putitem_e(tTRA_TRANSACAO, 'CD_EMPFAT', vCdEmpresa);
  putitem_e(tTRA_TRANSACAO, 'TP_ORIGEMEMISSAO', 1);
  putitem_e(tTRA_TRANSACAO, 'TP_SITUACAO', 1);
  if (vCdUsuario > 0) then begin
    putitem_e(tTRA_TRANSACAO, 'CD_OPERADOR', vCdUsuario);
  end;
  if (vDtMovimento <> '') then begin
    putitem_e(tTRA_TRANSACAO, 'DT_TRANSACAO', vDtMovimento);
  end;
  retrieve_e(tTRA_TRANSACAO);
  if (xStatus >= 0) then begin
    setocc(tTRA_TRANSACAO, 1);
    while(xStatus >= 0) do begin
      clear_e(tADM_USUARIO);
      putitem_e(tADM_USUARIO, 'CD_USUARIO', item_f('CD_OPERADOR', tTRA_TRANSACAO));
      retrieve_e(tADM_USUARIO);
      if (xStatus >= 0) then begin
        if (item_f('CD_USUARIO', tADM_USUARIO) > 0) then begin
          viParams := '';

          vNmUsuario := '';
          putitemXml(viParams, 'CD_USUARIO', item_f('CD_USUARIO', tADM_USUARIO));
          voParams := activateCmp('ADMSVCO027', 'validaUsuarioEspecial', viParams); (*,,,, *)
          if (xStatus < 0) then begin
            Result := voParams;
            return(-1); exit;
          end;
          if (voParams <> '') then begin
            vNmUsuario := itemXml('NM_USUARIO', voParams);
          end;
        end else begin
          vNmUsuario := '';
        end;
      end;
      vDsErro := '' + vDsErroEmp + './Trans. And./Data/Usu.: ' + CD_EMPFAT + '.TRA_TRANSACAO / ' + NR_TRANSACAO + '.TRA_TRANSACAO / ' + DT_TRANSACAO + '.TRA_TRANSACAO / ' + CD_OPERADOR + '.TRA_TRANSACAO - ' + vNmUsuario + ' ';
      setocc(tTRA_TRANSACAO, curocc(tTRA_TRANSACAO) + 1);
    end;
  end;

  Result := '';
  if (vDsErro <> '') then begin
    putitemXml(Result, 'DS_LOGERRO', vDsErro);
    return(-1); exit;
  end;

  return(0); exit;
end;

//------------------------------------------------------------------------
function T_TRASVCO012.validaTransacaoBloqueada(pParams : String) : String;
//------------------------------------------------------------------------
const
  cDS_METHOD = 'ADICIONAL=Operação: T_TRASVCO012.validaTransacaoBloqueada()';
var
  vCdEmpresa, vDsErro, viParams, voParams, vNmUsuario : String;
  vCdUsuario : Real;
  vDtMovimento : TDate;
begin
  vCdEmpresa := itemXmlF('CD_EMPRESA', pParams);
  if (vCdEmpresa = '') then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Empresa não informada!', cDS_METHOD);
    return(-1); exit;
  end;

  getParams(pParams); (* vCdEmpresa *)
  if (xStatus < 0) then begin
    return(-1); exit;
  end;

  vCdUsuario := itemXmlF('CD_USUARIO', pParams);
  vDtMovimento := itemXml('DT_MOVIMENTO', pParams);

  vDsErro := '';
  clear_e(tTRA_TRANSACAO);
  if (gDtImplantacaoV3 <> '') then begin
    putitem_e(tTRA_TRANSACAO, 'DT_TRANSACAO', '>=' + gDtImplantacaoV + '3');
  end;
  putitem_e(tTRA_TRANSACAO, 'CD_EMPFAT', vCdEmpresa);
  putitem_e(tTRA_TRANSACAO, 'TP_ORIGEMEMISSAO', 1);
  putitem_e(tTRA_TRANSACAO, 'TP_SITUACAO', 8);
  if (vCdUsuario > 0) then begin
    putitem_e(tTRA_TRANSACAO, 'CD_OPERADOR', vCdUsuario);
  end;
  if (vDtMovimento <> '') then begin
    putitem_e(tTRA_TRANSACAO, 'DT_TRANSACAO', vDtMovimento);
  end;
  retrieve_e(tTRA_TRANSACAO);
  if (xStatus >= 0) then begin
    setocc(tTRA_TRANSACAO, 1);
    while(xStatus >= 0) do begin
      clear_e(tADM_USUARIO);
      putitem_e(tADM_USUARIO, 'CD_USUARIO', item_f('CD_OPERADOR', tTRA_TRANSACAO));
      retrieve_e(tADM_USUARIO);
      if (xStatus >= 0) then begin
        if (item_f('CD_USUARIO', tADM_USUARIO) > 0) then begin
          viParams := '';

          vNmUsuario := '';
          putitemXml(viParams, 'CD_USUARIO', item_f('CD_USUARIO', tADM_USUARIO));
          voParams := activateCmp('ADMSVCO027', 'validaUsuarioEspecial', viParams); (*,,,, *)
          if (xStatus < 0) then begin
            Result := voParams;
            return(-1); exit;
          end;
          if (voParams <> '') then begin
            vNmUsuario := itemXml('NM_USUARIO', voParams);
          end;
        end else begin
          vNmUsuario := '';
        end;
      end;
      vDsErro := '' + vDsErroEmp + './Trans. Bloq./Data/Usu.: ' + CD_EMPFAT + '.TRA_TRANSACAO / ' + NR_TRANSACAO + '.TRA_TRANSACAO / ' + DT_TRANSACAO + '.TRA_TRANSACAO / ' + CD_OPERADOR + '.TRA_TRANSACAO - ' + vNmUsuario + ' ';
      setocc(tTRA_TRANSACAO, curocc(tTRA_TRANSACAO) + 1);
    end;
  end;

  Result := '';
  if (vDsErro <> '') then begin
    putitemXml(Result, 'DS_LOGERRO', vDsErro);
    return(-1); exit;
  end;

  return(0); exit;

end;

//-----------------------------------------------------------------
function T_TRASVCO012.calculaPrazoMedio(pParams : String) : String;
//-----------------------------------------------------------------
const
  cDS_METHOD = 'ADICIONAL=Operação: T_TRASVCO012.calculaPrazoMedio()';
var
  viParams, voParams : String;
  vCdEmpresa, vNrTransacao, vVlTotalTransacao, vVlTotal, vNrPrzMedio : Real;
  vDtTransacao : TDate;
begin
  vCdEmpresa := itemXmlF('CD_EMPRESA', pParams);
  vNrTransacao := itemXmlF('NR_TRANSACAO', pParams);
  vDtTransacao := itemXml('DT_TRANSACAO', pParams);
  vVlTotalTransacao := 0;
  vVlTotal := 0;
  vNrPrzMedio := 0;

  if (vCdEmpresa = 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Empresa da transação não informada!', cDS_METHOD);
    return(-1); exit;
  end;
  if (vNrTransacao = 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Número da transação não informado!', cDS_METHOD);
    return(-1); exit;
  end;
  if (vDtTransacao = '') then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Data da transação não informada!', cDS_METHOD);
    return(-1); exit;
  end;

  clear_e(tTRA_TRANSACAO);
  putitem_e(tTRA_TRANSACAO, 'CD_EMPRESA', vCdEmpresa);
  putitem_e(tTRA_TRANSACAO, 'NR_TRANSACAO', vNrTransacao);
  putitem_e(tTRA_TRANSACAO, 'DT_TRANSACAO', vDtTransacao);
  retrieve_e(tTRA_TRANSACAO);
  if (xStatus < 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Transação não encontrada!', cDS_METHOD);
    return(-1); exit;
  end;

  if not (empty(tTRA_VENCIMENT)) then begin
    setocc(tTRA_VENCIMENT, 1);
    while (xStatus >= 0) do begin
      vVlTotalTransacao := vVlTotalTransacao + item_f('VL_PARCELA', tTRA_VENCIMENT);
      vVlTotal := vVlTotal + (item_f('VL_PARCELA', tTRA_VENCIMENT) * (item_a('DT_VENCIMENTO', tTRA_VENCIMENT) - item_a('DT_TRANSACAO', tTRA_VENCIMENT)));
      setocc(tTRA_VENCIMENT, curocc(tTRA_VENCIMENT) + 1);
    end;
    vNrPrzMedio := vVlTotal / vVlTotalTransacao;
    vNrPrzMedio := rounded(vNrPrzMedio, 1);
  end else begin
    viParams := '';
    putitemXml(viParams, 'CD_CONDPGTO', item_f('CD_CONDPGTO', tTRA_TRANSACAO));
    voParams := activateCmp('GERSVCO013', 'calcPrzMedio', viParams); (*,,, *)
    if (xStatus < 0) then begin
      Result := voParams;
      return(-1); exit;
    end;
    vNrPrzMedio := itemXmlF('NR_PRAZOMEDIO', voParams);
  end;

  putitemXml(Result, 'NR_PRAZOMEDIO', vNrPrzMedio);

  return(0); exit;
end;

//-----------------------------------------------------------------
function T_TRASVCO012.validaNFTransacao(pParams : String) : String;
//-----------------------------------------------------------------
const
  cDS_METHOD = 'ADICIONAL=Operação: T_TRASVCO012.validaNFTransacao()';
var
  vCdEmpresa, vNrTransacao, vPrVariacao, vVlAbatimento, vNrParcela, vVlParcela : Real;
  vDtTransacao : TDate;
begin
  vCdEmpresa := itemXmlF('CD_EMPRESA', pParams);
  vNrTransacao := itemXmlF('NR_TRANSACAO', pParams);
  vDtTransacao := itemXml('DT_TRANSACAO', pParams);

  if (vCdEmpresa = 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Empresa da transação não informada!', cDS_METHOD);
    return(-1); exit;
  end;
  if (vNrTransacao = 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Número da transação não informado!', cDS_METHOD);
    return(-1); exit;
  end;
  if (vDtTransacao = '') then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Data da transação não informada!', cDS_METHOD);
    return(-1); exit;
  end;

  clear_e(tTRA_TRANSACAO);
  putitem_e(tTRA_TRANSACAO, 'CD_EMPRESA', vCdEmpresa);
  putitem_e(tTRA_TRANSACAO, 'NR_TRANSACAO', vNrTransacao);
  putitem_e(tTRA_TRANSACAO, 'DT_TRANSACAO', vDtTransacao);
  retrieve_e(tTRA_TRANSACAO);
  if (xStatus < 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Transação ' + FloatToStr(vNrTransacao) + ' não cadastrada!', cDS_METHOD);
    return(-1); exit;
  end;

  clear_e(tFIS_NF);
  putitem_e(tFIS_NF, 'CD_EMPRESAORI', item_f('CD_EMPRESA', tTRA_TRANSACAO));
  putitem_e(tFIS_NF, 'NR_TRANSACAOORI', item_f('NR_TRANSACAO', tTRA_TRANSACAO));
  putitem_e(tFIS_NF, 'DT_TRANSACAOORI', item_a('DT_TRANSACAO', tTRA_TRANSACAO));
  retrieve_e(tFIS_NF);
  if (xStatus < 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Transação ' + FloatToStr(vNrTransacao) + ' não possui NF relacionada!', cDS_METHOD);
    return(-1); exit;
  end;

  return(0); exit;
end;

end.
