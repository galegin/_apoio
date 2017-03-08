unit cTRAFM113;

interface

(* COMPONENTES 
  ADMFM020 / ADMSVCO001 / ADMSVCO009 / FCCSVCO002 / FCRSVCO015
  PRDSVCO008 / TRAFM062 / TRASVCO004 / TRASVCO016 / 
*)        

uses
  Classes, SysUtils, Math, DB,
  cServiceUnf, cDataSetUnf;

type
  T_TRAFM113 = class(TcServiceUnf)
  private
    tCTC_TRACARTAO,
    tFCX_HISTRELSUB,
    tGER_CONDPGTOC,
    tGER_CONDPGTOH,
    tGER_CONDPGTOI,
    tGER_OPERACAO,
    tPES_CLIENTEFPGTO,
    tPES_PESFISICA,
    tR_TRA_TRANSACAO,
    tSIS_BOTOES,
    tSIS_DUMMY,
    tSIS_FILTRO,
    tTMP_K04,
    tTRA_ITEMSIMU,
    tTRA_LIMDESCONTO,
    tTRA_TRANSACADIC,
    tTRA_TRANSACAO,
    tTRA_TRANSCONDPGTOH,
    tTRA_TRANSITEM : TcDatasetUnf;
    function getParam(pParams : String = '') : String;
    function setEntidade(pParams : String = '') : String;
  protected
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;    
  published
    function preEDIT(pParams : String = '') : String;
    function posEDIT(pParams : String = '') : String;
    function preQUIT(pParams : String = '') : String;
    function INIT(pParams : String = '') : String;
    function carregaDadosIniciais(pParams : String = '') : String;
    function recalcula(pParams : String = '') : String;
    function desconto(pParams : String = '') : String;
    function calculaParcela(pParams : String = '') : String;
    function confirma(pParams : String = '') : String;
  end;

implementation

uses
  cADMSVCO001,
  cActivate, cStatus, cFuncao, cXml, dModulo;

var
  gCdClientePDV,
  gCdEmpresa,
  gCdUsuarioDesc,
  gDsLimiteCredito,
  gDtTransacao,
  gInAniver,
  gInBloqDesItemProm,
  gNrTransacao,
  gprDescAniver,
  gTpCalculoSimularVd,
  gTpCampo : String;

//---------------------------------------------------------------
constructor T_TRAFM113.Create(AOwner: TComponent);
//---------------------------------------------------------------
begin
  inherited Create(AOwner);
  setEntidade('');
end;

//--------------------------------
destructor T_TRAFM113.Destroy;
//--------------------------------
begin
  inherited Destroy;
end;

//---------------------------------------------------------------
function T_TRAFM113.getParam(pParams : String = '') : String;
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
  putitem(xParam, '          putitem(vDsLstParcela,  vDsLinha);');
  putitem(xParam, 'CLIENTE_PDV');
  putitem(xParam, 'DS_LSTPARCELA');
  putitem(xParam, 'DT_VENCIMENTO');
  putitem(xParam, 'NR_PARCELA');
  putitem(xParam, 'NR_SEQHISTRELSUB');
  putitem(xParam, 'TP_DOCUMENTO');
  putitem(xParam, 'VL_PARCELA');

  xParam := T_ADMSVCO001.GetParametro(xParam);

  gCdClientePDV := itemXml('CLIENTE_PDV', xParam);
  gDsLimiteCredito := itemXml('LIMITE_CREDITO', xParam);
  gInBloqDesItemProm := itemXml('IN_BLOQ_DESC_ITEM_PROM', xParam);
  gprDescAniver := itemXml('PR_DESC_ANIVERSARIANTE', xParam);
  gTpCalculoSimularVd := itemXml('TP_CALCULO_SIMULADOR_VD', xParam);

  xParamEmp := '';
  putitem(xParamEmp, '          putitem(vDsLstParcela,  vDsLinha);');
  putitem(xParamEmp, 'CLIENTE_PDV');
  putitem(xParamEmp, 'DS_LSTPARCELA');
  putitem(xParamEmp, 'DT_VENCIMENTO');
  putitem(xParamEmp, 'IN_BLOQ_DESC_ITEM_PROM');
  putitem(xParamEmp, 'IN_LIMITE_FAMILIAR_VD');
  putitem(xParamEmp, 'LIMITE_CREDITO');
  putitem(xParamEmp, 'NR_PARCELA');
  putitem(xParamEmp, 'NR_SEQHISTRELSUB');
  putitem(xParamEmp, 'PR_DESC_ANIVERSARIANTE');
  putitem(xParamEmp, 'TP_CALCULO_SIMULADOR_VD');
  putitem(xParamEmp, 'TP_DOCUMENTO');
  putitem(xParamEmp, 'TP_SIMULADOR_FAT');
  putitem(xParamEmp, 'VL_PARCELA');

  xParamEmp := T_ADMSVCO001.GetParamEmpresa(piCdEmpresa, xParamEmp);

  gDsLimiteCredito := itemXml('LIMITE_CREDITO', xParamEmp);
  gInBloqDesItemProm := itemXml('IN_BLOQ_DESC_ITEM_PROM', xParamEmp);
  gprDescAniver := itemXml('PR_DESC_ANIVERSARIANTE', xParamEmp);
  gTpCalculoSimularVd := itemXml('TP_CALCULO_SIMULADOR_VD', xParamEmp);

end;

//---------------------------------------------------------------
function T_TRAFM113.setEntidade(pParams : String = '') : String;
//---------------------------------------------------------------
begin
  tCTC_TRACARTAO := GetEntidade('CTC_TRACARTAO');
  tFCX_HISTRELSUB := GetEntidade('FCX_HISTRELSUB');
  tGER_CONDPGTOC := GetEntidade('GER_CONDPGTOC');
  tGER_CONDPGTOH := GetEntidade('GER_CONDPGTOH');
  tGER_CONDPGTOI := GetEntidade('GER_CONDPGTOI');
  tGER_OPERACAO := GetEntidade('GER_OPERACAO');
  tPES_CLIENTEFPGTO := GetEntidade('PES_CLIENTEFPGTO');
  tPES_PESFISICA := GetEntidade('PES_PESFISICA');
  tR_TRA_TRANSACAO := GetEntidade('R_TRA_TRANSACAO');
  tSIS_BOTOES := GetEntidade('SIS_BOTOES');
  tSIS_DUMMY := GetEntidade('SIS_DUMMY');
  tSIS_FILTRO := GetEntidade('SIS_FILTRO');
  tTMP_K04 := GetEntidade('TMP_K04');
  tTRA_ITEMSIMU := GetEntidade('TRA_ITEMSIMU');
  tTRA_LIMDESCONTO := GetEntidade('TRA_LIMDESCONTO');
  tTRA_TRANSACADIC := GetEntidade('TRA_TRANSACADIC');
  tTRA_TRANSACAO := GetEntidade('TRA_TRANSACAO');
  tTRA_TRANSCONDPGTOH := GetEntidade('TRA_TRANSCONDPGTOH');
  tTRA_TRANSITEM := GetEntidade('TRA_TRANSITEM');
end;

//-----------------------------------------------------
function T_TRAFM113.preEDIT(pParams : String) : String;
//-----------------------------------------------------

var
  vMesAniver, vMesAtual : Real;
  vDtSistema : TDate;
begin
  gCdEmpresa := itemXmlF('CD_EMPRESA', viParams);
  gDtTransacao := itemXml('DT_TRANSACAO', viParams);
  gNrTransacao := itemXmlF('NR_TRANSACAO', viParams);

  if (gCdEmpresa = 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN001', , cDS_METHOD);
    return(-1); exit;
  end;
  if (gDtTransacao = 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN001', , cDS_METHOD);
    return(-1); exit;
  end;
  if (gNrTransacao = 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN001', , cDS_METHOD);
    return(-1); exit;
  end;

  voParams := carregaDadosIniciais(viParams); (* *)
  if (xStatus < 0) then begin
    Result := voParams;
    return(-1); exit;
  end;

  gInAniver := False;

  if (gprDescAniver > 0) then begin
    clear_e(tPES_PESFISICA);
    putitem_e(tPES_PESFISICA, 'CD_PESSOA', item_f('CD_PESSOA', tTRA_TRANSACAO));
    retrieve_e(tPES_PESFISICA);
    if (xStatus >= 0) then begin
      vMesAniver := DT_NASCIMENTO[M];
      vDtSistema := itemXml('DT_SISTEMA', PARAM_GLB);
      vMesAtual := vDtSistema[M];

      if (vMesAniver = vMesAtual) then begin
        gInAniver := True;
        message/info 'Aniversariante do mês!!! Desconto de ' + gprDescAniver%' + ';
      end;
    end;

    gprDescAniver := gprDescAniver * (-1);
  end;

  return(0); exit;
end;

//-----------------------------------------------------
function T_TRAFM113.posEDIT(pParams : String) : String;
//-----------------------------------------------------

var
  vDsLstParcela, vDsLinha : String;
  vVlAbatimento : Real;
begin
  vVlAbatimento := item_f('VL_ADIANTAMENTO', tSIS_DUMMY) + item_f('VL_CREDEV', tSIS_DUMMY) + item_f('VL_ENTRADA', tSIS_DUMMY) + item_f('VL_DESCONTO', tSIS_DUMMY);

  if (item_f('VL_TRANSACAO', tTRA_TRANSACAO) = vVlAbatimento) then begin
    clear_e(tTRA_TRANSCONDPGTOH);
    putitem_e(tTRA_TRANSCONDPGTOH, 'CD_EMPRESA', item_f('CD_EMPRESA', tTRA_TRANSACAO));
    putitem_e(tTRA_TRANSCONDPGTOH, 'NR_TRANSACAO', item_f('NR_TRANSACAO', tTRA_TRANSACAO));
    putitem_e(tTRA_TRANSCONDPGTOH, 'DT_TRANSACAO', item_a('DT_TRANSACAO', tTRA_TRANSACAO));
    putitem_e(tTRA_TRANSCONDPGTOH, 'CD_CONDPGTO', 0);
    putitem_e(tTRA_TRANSCONDPGTOH, 'TP_DOCUMENTO', 0);
    putitem_e(tTRA_TRANSCONDPGTOH, 'NR_SEQHISTRELSUB', 0);
    putitem_e(tTRA_TRANSCONDPGTOH, 'VL_ENTRADA', item_f('VL_ENTRADA', tSIS_DUMMY));
    putitem_e(tTRA_TRANSCONDPGTOH, 'VL_CREDEV', item_f('VL_CREDEV', tSIS_DUMMY));
    putitem_e(tTRA_TRANSCONDPGTOH, 'VL_ADIANTAMENTO', item_f('VL_ADIANTAMENTO', tSIS_DUMMY));
    putitem_e(tTRA_TRANSCONDPGTOH, 'VL_DESCONTO', item_f('VL_DESCONTO', tSIS_DUMMY));
    putitem_e(tTRA_TRANSCONDPGTOH, 'PR_DESCONTO', item_f('PR_DESCONTO', tSIS_DUMMY));

    putlistitensocc_e(voParams, tTRA_TRANSCONDPGTOH);
    putitemXml(voParams, 'CD_USUARIODESC', gCdUsuarioDesc);
  end else begin
    if (dbocc(t'GER_CONDPGTOH')) then begin
      clear_e(tTRA_TRANSCONDPGTOH);
      putitem_e(tTRA_TRANSCONDPGTOH, 'CD_EMPRESA', item_f('CD_EMPRESA', tTRA_TRANSACAO));
      putitem_e(tTRA_TRANSCONDPGTOH, 'NR_TRANSACAO', item_f('NR_TRANSACAO', tTRA_TRANSACAO));
      putitem_e(tTRA_TRANSCONDPGTOH, 'DT_TRANSACAO', item_a('DT_TRANSACAO', tTRA_TRANSACAO));
      putitem_e(tTRA_TRANSCONDPGTOH, 'CD_CONDPGTO', item_f('CD_CONDPGTO', tGER_CONDPGTOH));
      putitem_e(tTRA_TRANSCONDPGTOH, 'TP_DOCUMENTO', item_f('TP_DOCUMENTO', tGER_CONDPGTOH));
      putitem_e(tTRA_TRANSCONDPGTOH, 'NR_SEQHISTRELSUB', item_f('NR_SEQHISTRELSUB', tGER_CONDPGTOH));
      putitem_e(tTRA_TRANSCONDPGTOH, 'VL_ENTRADA', item_f('VL_ENTRADA', tSIS_DUMMY));
      putitem_e(tTRA_TRANSCONDPGTOH, 'VL_CREDEV', item_f('VL_CREDEV', tSIS_DUMMY));
      putitem_e(tTRA_TRANSCONDPGTOH, 'VL_ADIANTAMENTO', item_f('VL_ADIANTAMENTO', tSIS_DUMMY));
      putitem_e(tTRA_TRANSCONDPGTOH, 'VL_DESCONTO', item_f('VL_DESCONTO', tSIS_DUMMY));
      putitem_e(tTRA_TRANSCONDPGTOH, 'PR_DESCONTO', item_f('PR_DESCONTO', tSIS_DUMMY));
      putitem_e(tTRA_TRANSCONDPGTOH, 'DT_BASE', item_a('DT_BASE', tSIS_DUMMY));

      putlistitensocc_e(voParams, tTRA_TRANSCONDPGTOH);
      putitemXml(voParams, 'CD_USUARIODESC', gCdUsuarioDesc);

      vDsLstParcela := '';

      if (empty(tTMP_K04) = False) then begin
        setocc(tTMP_K04, 1);
        while (xStatus >= 0) do begin
          vDsLinha := '';
          putitemXml(vDsLinha, 'NR_PARCELA', item_f('NR_K01', tTMP_K04));
          putitemXml(vDsLinha, 'TP_DOCUMENTO', item_f('NR_K02', tTMP_K04));
          putitemXml(vDsLinha, 'NR_SEQHISTRELSUB', item_f('NR_K03', tTMP_K04));
          putitemXml(vDsLinha, 'DT_VENCIMENTO', item_a('DT_GERAL', tTMP_K04));
          putitemXml(vDsLinha, 'VL_PARCELA', item_f('VL_PARCELA', tTMP_K04));
          putitemXml(vDsLinha, 'DT_VENCIMENTO', item_a('DT_GERAL', tTMP_K04));
          putitem(vDsLstParcela,  vDsLinha);
          setocc(tTMP_K04, curocc(tTMP_K04) + 1);
        end;
      end;

      putitemXml(voParams, 'DS_LSTPARCELA', vDsLstParcela);
    end;
  end;

  return(0); exit;
end;

//-----------------------------------------------------
function T_TRAFM113.preQUIT(pParams : String) : String;
//-----------------------------------------------------

var
  vTpSimuladorFat : Real;
begin
  vTpSimuladorFat := itemXmlF('TP_SIMULADOR_FAT', xParamEmp);

  if (vTpSimuladorFat = 1)  or (vTpSimuladorFat = 2)  or (vTpSimuladorFat = 4)  or (vTpSimuladorFat = 0) then begin
    return(-1); exit;
  end else begin
    return(0); exit;
  end;
end;

//--------------------------------------------------
function T_TRAFM113.INIT(pParams : String) : String;
//--------------------------------------------------
begin
  xParam := '';
  putitem(xParam,  'CLIENTE_PDV');
  xParam := T_ADMSVCO001.GetParametro(xParam); (*xParam,xParam,, *)

  gCdClientePDV := itemXml('CLIENTE_PDV', xParam);

  xParamEmp := '';
  putitem(xParamEmp,  'TP_SIMULADOR_FAT');
  putitem(xParamEmp,  'TP_CALCULO_SIMULADOR_VD');
  putitem(xParamEmp,  'IN_BLOQ_DESC_ITEM_PROM');
  putitem(xParamEmp,  'LIMITE_CREDITO');
  putitem(xParamEmp,  'PR_DESC_ANIVERSARIANTE');
  putitem(xParamEmp,  'IN_LIMITE_FAMILIAR_VD');
  xParamEmp := T_ADMSVCO001.GetParamEmpresa(piCdEmpresa, xParamEmp); (*itemXml('CD_EMPRESA', *)

  gTpCalculoSimularVd := itemXmlF('TP_CALCULO_SIMULADOR_VD', xParamEmp);
  gInBloqDesItemProm := itemXmlB('IN_BLOQ_DESC_ITEM_PROM', xParamEmp);
  gDsLimiteCredito := itemXml('LIMITE_CREDITO', xParamEmp);
  gprDescAniver := itemXmlF('PR_DESC_ANIVERSARIANTE', xParamEmp);

  _Caption := '' + TRAFM + '113 - Simulação de Venda por Produto';
end;

//------------------------------------------------------------------
function T_TRAFM113.carregaDadosIniciais(pParams : String) : String;
//------------------------------------------------------------------

var
  vNrCtaCliente, vCdLiberador : Real;
  vDtSaldo : TDate;
  viParams, voParams : String;
  vInPDV, vInTroca, vInValidaFamiliar : Boolean;
begin
  vInPDV := itemXmlB('IN_PDV', viParams);
  if (vInPDV = True) then begin
    fieldsyntax item_a('BT_CONFIRMA', tSIS_BOTOES), 'HID';
  end;

  clear_e(tTRA_TRANSACAO);
  putitem_e(tTRA_TRANSACAO, 'CD_EMPRESA', gCdEmpresa);
  putitem_e(tTRA_TRANSACAO, 'DT_TRANSACAO', gDtTransacao);
  putitem_e(tTRA_TRANSACAO, 'NR_TRANSACAO', gNrTransacao);
  retrieve_e(tTRA_TRANSACAO);
  if (xStatus < 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN001', , cDS_METHOD);
    return(-1); exit;
  end;

  vInTroca := False;
  if (item_f('TP_MODALIDADE', tGER_OPERACAO) = 8 ) and (item_f('TP_OPERACAO', tTRA_TRANSACAO) = 'S') then begin
    vInTroca := True;

    if (empty(tR_TRA_TRANSACAO) = False) then begin
      putitem_e(tSIS_DUMMY, 'VL_CREDEV', item_f('VL_TRANSACAO', tR_TRA_TRANSACAO));
    end;
  end;

  vNrCtaCliente := 0;

  if (item_f('CD_PESSOA', tTRA_TRANSACAO) <> gCdClientePDV)  and (vInTroca = False) then begin
    viParams := '';
    putitemXml(viParams, 'CD_EMPRESA', item_f('CD_EMPFAT', tTRA_TRANSACAO));
    putitemXml(viParams, 'CD_PESSOA', item_f('CD_PESSOA', tTRA_TRANSACAO));
    if (item_f('TP_OPERACAO', tTRA_TRANSACAO) = 'S') then begin
      putitemXml(viParams, 'TP_CONTA', 'C');
    end else begin
      putitemXml(viParams, 'TP_CONTA', 'F');
    end;
    putitemXml(viParams, 'IN_OBRIGATORIO', False);
    voParams := activateCmp('FCCSVCO002', 'buscaContaPessoa', viParams); (*,viParams,voParams,, *)
    if (xStatus < 0) then begin
      Result := voParams;
      return(-1); exit;
    end;

    vNrCtaCliente := itemXmlF('NR_CTAPES', voParams);
  end else begin
    fieldsyntax item_f('VL_ADIANTAMENTO', tSIS_DUMMY), 'DIM';
    fieldsyntax item_f('VL_CREDEV', tSIS_DUMMY), 'DIM';
    fieldsyntax item_f('VL_SALDOADIANT', tSIS_DUMMY), 'DIM';
    fieldsyntax item_f('VL_SALDOCREDEV', tSIS_DUMMY), 'DIM';
  end;
  if (vNrCtaCliente > 0) then begin
    vDtSaldo := itemXml('DT_SISTEMA', PARAM_GLB);

    viParams := '';
    putitemXml(viParams, 'NR_CTAPES', vNrCtaCliente);
    putitemXml(viParams, 'TP_DOCUMENTO', 10);
    putitemXml(viParams, 'NR_SEQHISTRELSUB', 1);
    putitemXml(viParams, 'DT_SALDO', vDtSaldo);
    voParams := activateCmp('FCCSVCO002', 'buscaSaldoCtaTp', viParams); (*,viParams,voParams,, *)
    if (xStatus < 0) then begin
      Result := voParams;
      return(-1); exit;
    end;

    putitem_e(tSIS_DUMMY, 'VL_SALDOADIANT', itemXmlF('VL_SALDO', voParams));

    viParams := '';
    putitemXml(viParams, 'NR_CTAPES', vNrCtaCliente);
    putitemXml(viParams, 'TP_DOCUMENTO', 20);
    putitemXml(viParams, 'NR_SEQHISTRELSUB', 1);
    putitemXml(viParams, 'DT_SALDO', vDtSaldo);
    voParams := activateCmp('FCCSVCO002', 'buscaSaldoCtaTp', viParams); (*,viParams,voParams,, *)
    if (xStatus < 0) then begin
      Result := voParams;
      return(-1); exit;
    end;

    putitem_e(tSIS_DUMMY, 'VL_SALDOCREDEV', itemXmlF('VL_SALDO', voParams));
  end;
  if (item_a('DT_BASE', tSIS_DUMMY) = '') then begin
    putitem_e(tSIS_DUMMY, 'DT_BASE', itemXml('DT_SISTEMA', PARAM_GLB));
  end;

  vInValidaFamiliar := itemXmlB('IN_LIMITE_FAMILIAR_VD', xParamEmp);

  viParams := '';
  putitemXml(viParams, 'CD_CLIENTE', item_f('CD_PESSOA', tTRA_TRANSACAO));
  putitemXml(viParams, 'IN_TOTAL', True);

  if (vInValidaFamiliar = True)  and (item_f('CD_FAMILIAR', tTRA_TRANSACADIC) <> 0) then begin
    putitemXml(viParams, 'CD_FAMILIAR', item_f('CD_FAMILIAR', tTRA_TRANSACADIC));
  end else begin
    vInValidaFamiliar := False;
  end;

  voParams := activateCmp('FCRSVCO015', 'buscaLimiteCliente', viParams); (*,viParams,voParams,, *)
  if (xStatus < 0) then begin
    Result := voParams;
    return(-1); exit;
  end;
  if (vInValidaFamiliar = True) then begin
    putitem_e(tSIS_DUMMY, 'VL_LIMITETOTAL', itemXmlF('VL_SALDOFAMILIAR', voParams));
    putitem_e(tSIS_DUMMY, 'VL_LIMITE', itemXmlF('VL_SALDOFAMILIAR', voParams));
  end else begin
    putitem_e(tSIS_DUMMY, 'VL_LIMITETOTAL', itemXmlF('VL_SALDO', voParams));
    putitem_e(tSIS_DUMMY, 'VL_LIMITE', itemXmlF('VL_SALDO', voParams));
  end;

  return(0); exit;
end;

//-------------------------------------------------------
function T_TRAFM113.recalcula(pParams : String) : String;
//-------------------------------------------------------

var
  vVlAbatimento, vVlTotal, vVlTransacao, vVlPlano : Real;
  vInAniver : Boolean;
begin
  vVlTransacao := item_f('VL_TRANSACAO', tTRA_TRANSACAO) + item_f('VL_BONUSUTIL', tCTC_TRACARTAO);
  vVlAbatimento := item_f('VL_ADIANTAMENTO', tSIS_DUMMY) + item_f('VL_CREDEV', tSIS_DUMMY) + item_f('VL_ENTRADA', tSIS_DUMMY);
  vVlTotal := vVlTransacao - vVlAbatimento;

  if (vVlTotal < 0) then begin
    message/info 'Valores incorretos para geração das formas de pagamento!';
    return(-1); exit;
  end;
  if (item_f('TP_DOCUMENTO', tSIS_FILTRO) = '') then begin
    message/info 'Tipo de documento não informado!';
    gprompt := item_f('TP_DOCUMENTO', tSIS_FILTRO);
    return(0); exit;
  end;

  clear_e(tGER_CONDPGTOH);

  if (vVlTotal > 0) then begin
    if (item_f('TP_DOCUMENTO', tSIS_FILTRO) <> 0)  and (item_f('TP_DOCUMENTO', tSIS_FILTRO) <> 7)  and (item_f('TP_DOCUMENTO', tSIS_FILTRO) <> 8)  and (item_f('TP_DOCUMENTO', tSIS_FILTRO) <> 19)  and (item_f('TP_DOCUMENTO', tSIS_FILTRO) <> 22) then begin
      putitem_e(tGER_CONDPGTOH, 'TP_DOCUMENTO', item_f('TP_DOCUMENTO', tSIS_FILTRO));
    end;
    retrieve_e(tGER_CONDPGTOH);
    if (xStatus >= 0) then begin
      setocc(tGER_CONDPGTOH, 1);
      while (xStatus >= 0) do begin
        putitem_e(tGER_CONDPGTOH, 'NR_PARCELAS', 1);

        if (item_f('TP_DOCUMENTO', tGER_CONDPGTOH) = 4) then begin
          clear_e(tFCX_HISTRELSUB);
          putitem_e(tFCX_HISTRELSUB, 'TP_DOCUMENTO', item_f('TP_DOCUMENTO', tGER_CONDPGTOH));
          putitem_e(tFCX_HISTRELSUB, 'NR_SEQHISTRELSUB', item_f('NR_SEQHISTRELSUB', tGER_CONDPGTOH));
          retrieve_e(tFCX_HISTRELSUB);
          if (xStatus >= 0) then begin
            putitem_e(tGER_CONDPGTOH, 'NR_PARCELAS', item_f('NR_PARCELAS', tFCX_HISTRELSUB));
          end;
        end else begin
          clear_e(tGER_CONDPGTOC);
          putitem_e(tGER_CONDPGTOC, 'CD_CONDPGTO', item_f('CD_CONDPGTO', tGER_CONDPGTOH));
          retrieve_e(tGER_CONDPGTOC);
          if (xStatus >= 0) then begin
            putitem_e(tGER_CONDPGTOH, 'NR_PARCELAS', item_f('NR_PARCELAS', tGER_CONDPGTOC));
          end;
        end;

        voParams := calculaParcela(viParams); (* *)
        if (xStatus < 0) then begin
          Result := voParams;
          return(-1); exit;
        end;

        setocc(tGER_CONDPGTOH, curocc(tGER_CONDPGTOH) + 1);
      end;

      clear_e(tPES_CLIENTEFPGTO);
      putitem_e(tPES_CLIENTEFPGTO, 'CD_CLIENTE', item_f('CD_PESSOA', tTRA_TRANSACAO));
      retrieve_e(tPES_CLIENTEFPGTO);
      if (xStatus >= 0) then begin
        setocc(tPES_CLIENTEFPGTO, -1);
        setocc(tGER_CONDPGTOH, -1);
        setocc(tGER_CONDPGTOH, 1);
        while (xStatus >= 0) do begin
          creocc(tPES_CLIENTEFPGTO, -1);
          putitem_e(tPES_CLIENTEFPGTO, 'CD_CLIENTE', item_f('CD_PESSOA', tTRA_TRANSACAO));
          putitem_e(tPES_CLIENTEFPGTO, 'TP_DOCUMENTO', item_f('TP_DOCUMENTO', tGER_CONDPGTOH));
          retrieve_o(tPES_CLIENTEFPGTO);
          if (xStatus <> 4) then begin
            discard 'PES_CLIENTEFPGTO';
            discard 'GER_CONDPGTOH';
            if (xStatus = 0) then begin
              xStatus := -1;
            end;
          end else begin
            setocc(tGER_CONDPGTOH, curocc(tGER_CONDPGTOH) + 1);
          end;
        end;
      end;

      sort/e(t GER_CONDPGTOH, 'DS_RESUMIDA';);
      setocc(tGER_CONDPGTOH, 1);
    end;
  end;

  voParams := calculaParcela(viParams); (* *)
  if (xStatus < 0) then begin
    Result := voParams;
    return(-1); exit;
  end;

  reset gformmod;

  return(0); exit;
end;

//------------------------------------------------------
function T_TRAFM113.desconto(pParams : String) : String;
//------------------------------------------------------

var
  (* numeric piVlDesconto : IN *)
  viParams, voParams, vDsLstTransacao, vDsRegistro : String;
  vVlDesconto, vVlTotalDesc, vPrTotalDesc, vVlCalc, vPrDescMax, vVlResto, vVlMaior : Real;
  vVlBrutoTransacao, vVlLiquidoTransacao, vCdUsuario, vVlLiquido, vNrOcc : Real;
  vPrVariacao, vVlTotal, vPrDesconto : Real;
begin
  vCdUsuario := itemXmlF('CD_USUARIO', PARAM_GLB);
  vVlDesconto := 0;
  vVlLiquido := 0;

  clear_e(tTRA_TRANSITEM);
  retrieve_e(tTRA_TRANSITEM);
  if (empty(tTRA_TRANSITEM) = False) then begin
    setocc(tTRA_TRANSITEM, 1);
    while (xStatus >= 0) do begin
      if ((gInBloqDesItemProm = True)  and (item_f('CD_PROMOCAO', tTRA_TRANSITEM) > 0)) then begin
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

  if (gTpCalculoSimularVd = 0) then begin
    vVlCalc := vVlLiquido;
  end else if (gTpCalculoSimularVd = 1) then begin
    vVlCalc := vVlLiquido + vVlDesconto;
    putitemXml(viParams, 'VL_BONUS', item_f('VL_BONUSUTIL', tCTC_TRACARTAO));
  end else if (gTpCalculoSimularVd = 2) then begin
    vVlCalc := vVlLiquido + vVlDesconto;
    putitemXml(viParams, 'VL_BONUS', item_f('VL_BONUSUTIL', tCTC_TRACARTAO));
  end else if (gTpCalculoSimularVd = 3) then begin
    vVlCalc := vVlLiquido;
  end;

  putitemXml(viParams, 'VL_BASEDESC', vVlCalc);
  putitemXml(viParams, 'IN_ARREDONDA_PRECO', False);
  putitemXml(viParams, 'CD_OPERACAO', item_f('CD_OPERACAO', tTRA_TRANSACAO));
  putitemXml(viParams, 'CD_PESSOA', item_f('CD_PESSOA', tTRA_TRANSACAO));
  putitemXml(viParams, 'VL_BONUS', item_f('VL_BONUSUTIL', tCTC_TRACARTAO));
  voParams := activateCmp('TRAFM062', 'EXEC', viParams); (*viParams,voParams,, *)
  if (xStatus < 0) then begin
    Result := voParams;
    return(-1); exit;
  end;

  vVlTotalDesc := itemXmlF('VL_TOTALDESC', voParams);
  vPrTotalDesc := itemXmlF('PR_TOTALDESC', voParams);
  gCdUsuarioDesc := itemXmlF('CD_USUARIODESC', voParams);

  if (gCdUsuarioDesc > 0)  and (gCdUsuarioDesc <> vCdUsuario) then begin
    clear_e(tTRA_LIMDESCONTO);
    putitem_e(tTRA_LIMDESCONTO, 'CD_OPERACAO', item_f('CD_OPERACAO', tTRA_TRANSACAO));
    putitem_e(tTRA_LIMDESCONTO, 'CD_USUARIO', gCdUsuarioDesc);
    retrieve_e(tTRA_LIMDESCONTO);
    if (xStatus < 0) then begin
      clear_e(tTRA_LIMDESCONTO);
    end;
  end;
  if (dbocc(t'TRA_LIMDESCONTO')) then begin
    vVlBrutoTransacao := item_f('VL_TRANSACAO', tTRA_TRANSACAO) + item_f('VL_DESCONTO', tTRA_TRANSACAO);
    vVlLiquidoTransacao := item_f('VL_TRANSACAO', tTRA_TRANSACAO) + item_f('VL_BONUSUTIL', tCTC_TRACARTAO) - vVlTotalDesc;
    vVlCalc := (vVlBrutoTransacao - vVlLiquidoTransacao) / vVlBrutoTransacao * 100;
    vVlCalc := roundto(vVlCalc, 2);
    if (vVlCalc > item_f('PR_DESCMAX', tTRA_LIMDESCONTO)) then begin
      Result := SetStatus(STS_ERROR, 'GEN0001', , cDS_METHOD);
      return(-1); exit;
    end;
  end;
  if (empty(tTRA_TRANSITEM) = False) then begin
    setocc(tTRA_TRANSITEM, 1);
    while (xStatus >= 0) do begin
      viParams := '';
      putitemXml(viParams, 'CD_PRODUTO', item_f('CD_PRODUTO', tTRA_TRANSITEM));
      voParams := activateCmp('PRDSVCO008', 'buscaDadosFilial', viParams); (*,viParams,voParams,, *)
      if (xStatus < 0) then begin
        Result := voParams;
        return(-1); exit;
      end;

      vPrDescMax := itemXmlF('PR_DESCMAX', voParams);

      if (vPrTotalDesc > vPrDescMax)  and (vPrDescMax <> '') then begin
        Result := SetStatus(STS_ERROR, 'GEN0001', , cDS_METHOD);
        return(-1); exit;
      end;

      setocc(tTRA_TRANSITEM, curocc(tTRA_TRANSITEM) + 1);
    end;
  end;

  putitem_e(tSIS_DUMMY, 'VL_DESCONTO', vVlTotalDesc);
  putitem_e(tSIS_DUMMY, 'PR_DESCONTO', vPrTotalDesc);

  vPrTotalDesc := item_f('PR_DESCONTO', tSIS_DUMMY);
  vPrVariacao := item_f('PR_VARIACAO', tGER_CONDPGTOH);

  vVlBrutoTransacao := item_f('VL_TRANSACAO', tTRA_TRANSACAO) + item_f('VL_BONUSUTIL', tCTC_TRACARTAO);

  vVlDesconto := item_f('VL_DESCONTO', tSIS_DUMMY);
  vVlCalc := vVlDesconto / vVlBrutoTransacao * 100;
  vPrDesconto := roundto(vVlCalc, 2);

  clear_e(tTRA_TRANSITEM);
  retrieve_e(tTRA_TRANSITEM);
  if (empty(tTRA_TRANSITEM) = False)  and (vVlBrutoTransacao <> vVlDesconto) then begin
    vVlMaior := 0;
    setocc(tTRA_TRANSITEM, 1);
    while (xStatus >= 0) do begin
      if (item_f('VL_BONUSUTIL', tCTC_TRACARTAO) = 0) then begin
        putitem_e(tTRA_TRANSITEM, 'VL_TOTALBRUTO', item_f('VL_TOTALLIQUIDO', tTRA_TRANSITEM));
        putitem_e(tTRA_TRANSITEM, 'VL_UNITBRUTO', item_f('VL_UNITLIQUIDO', tTRA_TRANSITEM));
        putitem_e(tTRA_TRANSITEM, 'PR_DESCONTO', '');
        putitem_e(tTRA_TRANSITEM, 'VL_TOTALDESC', '');
        putitem_e(tTRA_TRANSITEM, 'VL_TOTALDESCCAB', '');
        putitem_e(tTRA_TRANSITEM, 'VL_UNITDESCCAB', '');
        putitem_e(tTRA_TRANSITEM, 'VL_UNITDESC', '');
      end;

      setocc(tTRA_TRANSITEM, curocc(tTRA_TRANSITEM) + 1);
    end;
  end;

  vVlResto := item_f('VL_DESCONTO', tSIS_DUMMY) + item_f('VL_BONUSUTIL', tCTC_TRACARTAO);

  if (empty(tTRA_TRANSITEM) = False)  and (vVlResto > 0) then begin
    vVlMaior := 0;
    setocc(tTRA_TRANSITEM, 1);
    while (xStatus >= 0) do begin
      vVlCalc := item_f('VL_TOTALLIQUIDO', tTRA_TRANSITEM) + item_f('VL_TOTALDESCCAB', tTRA_TRANSITEM);
      vVlCalc := vVlCalc * vPrTotalDesc / 100;
      putitem_e(tTRA_TRANSITEM, 'VL_TOTALDESCCAB', item_f('VL_TOTALDESCCAB', tTRA_TRANSITEM) + roundto(vVlCalc, 2));
      putitem_e(tTRA_TRANSITEM, 'VL_TOTALLIQUIDO', item_f('VL_TOTALBRUTO', tTRA_TRANSITEM) - (item_f('VL_TOTALDESC', tTRA_TRANSITEM) + item_f('VL_TOTALDESCCAB', tTRA_TRANSITEM)));
      vVlCalc := item_f('VL_TOTALDESCCAB', tTRA_TRANSITEM) / item_f('QT_SOLICITADA', tTRA_TRANSITEM);
      putitem_e(tTRA_TRANSITEM, 'VL_UNITDESCCAB', roundto(vVLCalc, 2));
      vVlCalc := item_f('VL_TOTALLIQUIDO', tTRA_TRANSITEM) / item_f('QT_SOLICITADA', tTRA_TRANSITEM);
      putitem_e(tTRA_TRANSITEM, 'VL_UNITLIQUIDO', roundto(vVLCalc, 2));
      vVlResto := vVlResto - item_f('VL_TOTALDESCCAB', tTRA_TRANSITEM);
      if (item_f('VL_TOTALLIQUIDO', tTRA_TRANSITEM) > vVlMaior) then begin
        vVlMaior := item_f('VL_TOTALLIQUIDO', tTRA_TRANSITEM);
        vNrOcc := curocc(tTRA_TRANSITEM);
      end;

      setocc(tTRA_TRANSITEM, curocc(tTRA_TRANSITEM) + 1);
    end;
    if (vVlResto <> 0) then begin
      setocc(tTRA_TRANSITEM, 1);
      putitem_e(tTRA_TRANSITEM, 'VL_TOTALDESCCAB', item_f('VL_TOTALDESCCAB', tTRA_TRANSITEM) + vVlResto);
      putitem_e(tTRA_TRANSITEM, 'VL_TOTALLIQUIDO', item_f('VL_TOTALBRUTO', tTRA_TRANSITEM) - (item_f('VL_TOTALDESC', tTRA_TRANSITEM) + item_f('VL_TOTALDESCCAB', tTRA_TRANSITEM)));
      vVlCalc := item_f('VL_TOTALDESCCAB', tTRA_TRANSITEM) / item_f('QT_SOLICITADA', tTRA_TRANSITEM);
      putitem_e(tTRA_TRANSITEM, 'VL_UNITDESCCAB', roundto(vVLCalc, 2));
      vVlCalc := item_f('VL_TOTALLIQUIDO', tTRA_TRANSITEM) / item_f('QT_SOLICITADA', tTRA_TRANSITEM);
      putitem_e(tTRA_TRANSITEM, 'VL_UNITLIQUIDO', roundto(vVLCalc, 2));
    end;
  end;

  setocc(tTRA_TRANSITEM, 1);
  while (xStatus >= 0) do begin
    if (item_f('VL_UNITLIQUIDO', tTRA_TRANSITEM) < 0.01) then begin
      putitem_e(tTRA_TRANSITEM, 'VL_UNITLIQUIDO', 0.01);
      vVlCalc := item_f('VL_UNITLIQUIDO', tTRA_TRANSITEM) * item_f('QT_SOLICITADA', tTRA_TRANSITEM);
      putitem_e(tTRA_TRANSITEM, 'VL_TOTALLIQUIDO', roundto(vVlCalc, 2));
    end;

    viParams := '';
    putlistitensocc_e(viParams, tTRA_TRANSITEM);
    putitemXml(viParams, 'IN_TOTAL', False);
    voParams := activateCmp('TRASVCO004', 'gravaItemTransacao', viParams); (*,viParams,voParams,, *)
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
  voParams := activateCmp('TRASVCO004', 'gravaTotalTransacao', viParams); (*,viParams,voParams,, *)
  if (xStatus < 0) then begin
    Result := voParams;
    return(-1); exit;
  end;

  voParams := recalcula(viParams); (* *)
  if (xStatus < 0) then begin
    Result := voParams;
    return(-1); exit;
  end;

  return(0); exit;
end;

//------------------------------------------------------------
function T_TRAFM113.calculaParcela(pParams : String) : String;
//------------------------------------------------------------

var
  viParams, voParams, vDsResumida, vDsCampo : String;
  vNrParcela, vVlAbatimento, vPrVariacao, vVlCalc, vPrAbatimento, vVlTotalItem, vPrDescMax : Real;
  vNrContador, vVlBrutoTransacao, vVlDesconto, vVlTotal, vVlDif, vNrOcc, vVlParcela, vPrLimite : Real;
  vTpDocumento, vNrSeqHistRelSub, vVlBonus, vPrEntrada, vVlEntrada, vVlEntradaUnit : Real;
  vVlProdLiquido, vVlProdBruto, vVlTransacao, vVlTotalCalculo, vVlUnitTransacao : Real;
  vDtVencimento : TDate;
  vInVariacao : Boolean;
begin
  vVlTransacao := item_f('VL_TRANSACAO', tTRA_TRANSACAO) + item_f('VL_BONUSUTIL', tCTC_TRACARTAO) + item_f('VL_BONUSDESC', tTRA_TRANSACADIC);
  vVlAbatimento := item_f('VL_ADIANTAMENTO', tSIS_DUMMY) + item_f('VL_CREDEV', tSIS_DUMMY) + item_f('VL_ENTRADA', tSIS_DUMMY) + item_f('VL_DESCONTO', tSIS_DUMMY);
  vVlTotalCalculo := vVlTransacao - vVlAbatimento;
  vVlEntrada := item_f('VL_ENTRADA', tSIS_DUMMY) + item_f('VL_ADIANTAMENTO', tSIS_DUMMY) + item_f('VL_CREDEV', tSIS_DUMMY);
  vPrEntrada := (vVlEntrada / vVlTransacao) * 100;

  clear_e(tTMP_K04);

  clear_e(tGER_CONDPGTOC);
  if (item_f('TP_DOCUMENTO', tGER_CONDPGTOH) <> 4) then begin
    putitem_e(tGER_CONDPGTOC, 'CD_CONDPGTO', item_f('CD_CONDPGTO', tGER_CONDPGTOH));
    retrieve_e(tGER_CONDPGTOC);
    if (xStatus < 0) then begin
      clear_e(tGER_CONDPGTOC);
    end;
  end;

  putitem_e(tGER_CONDPGTOH, 'VL_TOTAL', 0);
  vVlTotalItem := 0;

  clear_e(tTRA_ITEMSIMU);
  putitem_e(tTRA_ITEMSIMU, 'CD_EMPRESA', item_f('CD_EMPRESA', tTRA_TRANSACAO));
  putitem_e(tTRA_ITEMSIMU, 'NR_TRANSACAO', item_f('NR_TRANSACAO', tTRA_TRANSACAO));
  putitem_e(tTRA_ITEMSIMU, 'DT_TRANSACAO', item_a('DT_TRANSACAO', tTRA_TRANSACAO));
  retrieve_e(tTRA_ITEMSIMU);
  if (xStatus >= 0) then begin
    setocc(tTRA_ITEMSIMU, 1);
    while (xStatus >= 0) do begin
      clear_e(tTRA_TRANSITEM);
      putitem_e(tTRA_TRANSITEM, 'NR_ITEM', item_f('NR_ITEM', tTRA_ITEMSIMU));
      retrieve_e(tTRA_TRANSITEM);
      if (xStatus >= 0) then begin
        if (item_f('VL_BONUSUTIL', tCTC_TRACARTAO) = 0) then begin
          putitem_e(tTRA_TRANSITEM, 'VL_TOTALBRUTO', item_f('VL_TOTALLIQUIDO', tTRA_TRANSITEM));
          putitem_e(tTRA_TRANSITEM, 'VL_UNITBRUTO', item_f('VL_UNITLIQUIDO', tTRA_TRANSITEM));
        end;

        vVlTotalItem := vVlTotalItem + item_f('VL_TOTALBRUTO', tTRA_TRANSITEM);
      end;

      setocc(tTRA_ITEMSIMU, curocc(tTRA_ITEMSIMU) + 1);
    end;
  end;

  vVlAbatimento := item_f('VL_ADIANTAMENTO', tSIS_DUMMY) + item_f('VL_CREDEV', tSIS_DUMMY) + item_f('VL_ENTRADA', tSIS_DUMMY);
  vVlBrutoTransacao := item_f('VL_TRANSACAO', tTRA_TRANSACAO) + item_f('VL_BONUSUTIL', tCTC_TRACARTAO) - vVlTotalItem;
  vVlCalc := vVlAbatimento / vVlBrutoTransacao * 100;
  vPrAbatimento := roundto(vVlCalc, 2);
  vVlTotal := 0;
  vInVariacao := False;
  vVlBonus := item_f('VL_BONUSUTIL', tCTC_TRACARTAO);

  if (vVlBrutoTransacao > vVlAbatimento) then begin
    clear_e(tTRA_TRANSITEM);
    retrieve_e(tTRA_TRANSITEM);
    if (xStatus >= 0) then begin
      setocc(tTRA_TRANSITEM, 1);
      while (xStatus >= 0) do begin
        clear_e(tTRA_ITEMSIMU);
        putitem_e(tTRA_ITEMSIMU, 'CD_EMPRESA', item_f('CD_EMPRESA', tTRA_TRANSITEM));
        putitem_e(tTRA_ITEMSIMU, 'NR_TRANSACAO', item_f('NR_TRANSACAO', tTRA_TRANSITEM));
        putitem_e(tTRA_ITEMSIMU, 'DT_TRANSACAO', item_a('DT_TRANSACAO', tTRA_TRANSITEM));
        putitem_e(tTRA_ITEMSIMU, 'NR_ITEM', item_f('NR_ITEM', tTRA_TRANSITEM));
        retrieve_e(tTRA_ITEMSIMU);
        if (xStatus < 0) then begin
          viParams := '';
          putitemXml(viParams, 'CD_PRODUTO', item_f('CD_PRODUTO', tTRA_TRANSITEM));
          voParams := activateCmp('PRDSVCO008', 'buscaDadosFilial', viParams); (*,viParams,voParams,, *)
          if (xStatus < 0) then begin
            Result := voParams;
            return(-1); exit;
          end;

          vNrParcela := itemXmlF('NR_PARCELAMAX', voParams);
          vPrDescMax := itemXmlF('PR_DESCMAX', voParams);

          if (vPrDescMax <> '') then begin
            vPrDescMax := vPrDescMax * (-1);

            if (vPrDescMax > item_f('PR_VARIACAO', tGER_CONDPGTOH)) then begin
              vPrVariacao := vPrDescMax;
            end else begin
              vPrVariacao := item_f('PR_VARIACAO', tGER_CONDPGTOH);
            end;
          end else begin
            vPrVariacao := item_f('PR_VARIACAO', tGER_CONDPGTOH);
          end;
          if (vPrVariacao <> 0) then begin
            vInVariacao := True;
          end;
          if (item_f('VL_BONUSUTIL', tCTC_TRACARTAO) = 0) then begin
            putitem_e(tTRA_TRANSITEM, 'VL_TOTALBRUTO', item_f('VL_TOTALLIQUIDO', tTRA_TRANSITEM));
            putitem_e(tTRA_TRANSITEM, 'VL_UNITBRUTO', item_f('VL_UNITLIQUIDO', tTRA_TRANSITEM));
          end;

          vVlDesconto := item_f('VL_UNITBRUTO', tTRA_TRANSITEM) * vPrAbatimento / 100;
          vVlDesconto := roundto(vVlDesconto, 2);

          if (gInAniver = True) then begin
            if (item_f('PR_VARIACAO', tGER_CONDPGTOH) <= 0)  and (gprDescAniver < item_f('PR_VARIACAO', tGER_CONDPGTOH)) then begin
              putitem_e(tGER_CONDPGTOH, 'PR_VARIACAO', gprDescAniver);
            end;
            if (vPrDescMax <> '') then begin
              if (vPrDescMax > item_f('PR_VARIACAO', tGER_CONDPGTOH)) then begin
                vPrVariacao := vPrDescMax;
              end else begin
                vPrVariacao := item_f('PR_VARIACAO', tGER_CONDPGTOH);
              end;
            end else begin
              vPrVariacao := item_f('PR_VARIACAO', tGER_CONDPGTOH);
            end;

            vVlProdLiquido := (item_f('VL_UNITBRUTO', tTRA_TRANSITEM) - vVlDesconto);
            vVlProdBruto := item_f('VL_UNITBRUTO', tTRA_TRANSITEM);

            if (gTpCalculoSimularVd = 0) then begin
              if (item_f('PR_VARIACAO', tGER_CONDPGTOH) > 0) then begin
                vVlCalc := vVlProdLiquido + (vVlProdLiquido * gprDescAniver / 100);
                vVlProdLiquido := vVlCalc;
              end;

              vVlCalc := vVlProdLiquido + (vVlProdLiquido * item_f('PR_VARIACAO', tGER_CONDPGTOH) / 100);
            end else if (gTpCalculoSimularVd = 1) then begin
              if (item_f('PR_VARIACAO', tGER_CONDPGTOH) > 0) then begin
                vVlCalc := vVlProdBruto + (vVlProdBruto * gprDescAniver / 100);
                vVlProdBruto := vVlCalc;
              end;

              vVlCalc := vVlProdBruto + (vVlProdBruto * item_f('PR_VARIACAO', tGER_CONDPGTOH) / 100);
              vVlCalc := vVlCalc - vVlDesconto;
            end else if (gTpCalculoSimularVd = 2) then begin
              if (item_f('PR_VARIACAO', tGER_CONDPGTOH) <= 0) then begin
                vVlCalc := vVlProdBruto + (vVlProdBruto * item_f('PR_VARIACAO', tGER_CONDPGTOH) / 100);
                vVlCalc := vVlCalc - vVlDesconto;
              end else begin
                vVlCalc := vVlProdLiquido + (vVlProdLiquido * gprDescAniver / 100);
                vVlCalc := vVlCalc + (vVlCalc * item_f('PR_VARIACAO', tGER_CONDPGTOH) / 100);
              end;
            end else if (gTpCalculoSimularVd = 3) then begin
              if (item_f('PR_VARIACAO', tGER_CONDPGTOH) <= 0) then begin
                vVlCalc := vVlProdLiquido + (vVlProdLiquido * item_f('PR_VARIACAO', tGER_CONDPGTOH) / 100);
              end else begin
                vVlCalc := vVlProdBruto + (vVlProdLiquido * gprDescAniver / 100);
                vVlCalc := vVlCalc + (vVlProdBruto * item_f('PR_VARIACAO', tGER_CONDPGTOH) / 100);
                vVlCalc := vVlCalc - vVlDesconto;
              end;
            end;
          end else begin

            if (vVlBonus > 0) then begin
              vVlTotalCalculo := item_f('VL_UNITBRUTO', tTRA_TRANSITEM) - item_f('VL_UNITDESC', tTRA_TRANSITEM);
            end else begin
              vVlTotalCalculo := item_f('VL_UNITBRUTO', tTRA_TRANSITEM);
            end;
            vVlEntradaUnit := (vVlTotalCalculo * vPrEntrada) / 100;
            vVlUnitTransacao := vVlTotalCalculo - vVlEntradaUnit;

            if (gTpCalculoSimularVd = 0) then begin
              vVlCalc := vVlUnitTransacao + (vVlUnitTransacao * item_f('PR_VARIACAO', tGER_CONDPGTOH) / 100);
            end else if (gTpCalculoSimularVd = 1) then begin
              vVlCalc := vVlTotalCalculo + (vVlTotalCalculo * item_f('PR_VARIACAO', tGER_CONDPGTOH) / 100);
              vVlCalc := vVlCalc - vVlEntradaUnit;
            end else if (gTpCalculoSimularVd = 2) then begin
              if (item_f('PR_VARIACAO', tGER_CONDPGTOH) <= 0) then begin
                vVlCalc := vVlTotalCalculo + (vVlTotalCalculo * item_f('PR_VARIACAO', tGER_CONDPGTOH) / 100);
                vVlCalc := vVlCalc - vVlEntradaUnit;
              end else begin
                vVlCalc := vVlUnitTransacao + (vVlUnitTransacao * item_f('PR_VARIACAO', tGER_CONDPGTOH) / 100);
              end;
            end else if (gTpCalculoSimularVd = 3) then begin
              if (item_f('PR_VARIACAO', tGER_CONDPGTOH) <= 0) then begin
                vVlCalc := vVlUnitTransacao + (vVlUnitTransacao * item_f('PR_VARIACAO', tGER_CONDPGTOH) / 100);
              end else begin
                vVlCalc := vVlTotalCalculo + (vVlTotalCalculo * item_f('PR_VARIACAO', tGER_CONDPGTOH) / 100);
                vVlCalc := vVlCalc - vVlEntradaUnit;
              end;
            end;
          end;

          vVlCalc := roundto(vVlCalc, 2);
          vVlCalc := vVlCalc * item_f('QT_SOLICITADA', tTRA_TRANSITEM);

          if (vNrParcela > item_f('NR_PARCELAS', tGER_CONDPGTOH))  or (vNrParcela = 0) then begin
            vNrParcela := item_f('NR_PARCELAS', tGER_CONDPGTOH);
          end;
          if (item_f('TP_DOCUMENTO', tSIS_FILTRO) = 7)  or (item_f('TP_DOCUMENTO', tSIS_FILTRO) = 8)  or (item_f('TP_DOCUMENTO', tSIS_FILTRO) = 19)  or (item_f('TP_DOCUMENTO', tSIS_FILTRO) = 22) then begin
            vNrParcela := 1;
          end;

          vNrContador := 1;
          while (vNrParcela >= vNrContador) do begin
            if (item_f('TP_DOCUMENTO', tGER_CONDPGTOH) = 1)  or (item_f('TP_DOCUMENTO', tGER_CONDPGTOH) = 2)  or (item_f('TP_DOCUMENTO', tGER_CONDPGTOH) = 14) then begin
              vDtVencimento := item_a('DT_BASE', tSIS_DUMMY);
            end else begin
              vDtVencimento := itemXml('DT_SISTEMA', PARAM_GLB);
            end;

            setocc(tGER_CONDPGTOI, 1);
            if (xStatus >= 0) then begin
              vDtVencimento := vDtVencimento + item_f('QT_DIA', tGER_CONDPGTOI);
            end;
            if (item_f('TP_DOCUMENTO', tSIS_FILTRO) = 7)  or (item_f('TP_DOCUMENTO', tSIS_FILTRO) = 8)  or (item_f('TP_DOCUMENTO', tSIS_FILTRO) = 19)  or (item_f('TP_DOCUMENTO', tSIS_FILTRO) = 22) then begin
              vDtVencimento := itemXml('DT_SISTEMA', PARAM_GLB);
              gTpCampo := item_f('TP_DOCUMENTO', tSIS_FILTRO);
              vDsCampo := valrep(item_f('TP_DOCUMENTO', tSIS_FILTRO));
              vDsCampo := itemXml('' + FloatToStr(gTpCampo',) + ' vDsCampo);
              vTpDocumento := item_f('TP_DOCUMENTO', tSIS_FILTRO);
              vNrSeqHistRelSub := 1;
            end else begin
              vDsCampo := item_a('DS_RESUMIDA', tGER_CONDPGTOH);
              vTpDocumento := item_f('TP_DOCUMENTO', tGER_CONDPGTOH);
              vNrSeqHistRelSub := item_f('NR_SEQHISTRELSUB', tGER_CONDPGTOH);
            end;

            creocc(tTMP_K04, -1);
            putitem_e(tTMP_K04, 'NR_K01', vNrContador);
            putitem_e(tTMP_K04, 'NR_K02', vTpDocumento);
            putitem_e(tTMP_K04, 'NR_K03', vNrSeqHistRelSub);
            putitem_e(tTMP_K04, 'DT_GERAL', vDtVencimento);
            retrieve_o(tTMP_K04);
            if (xStatus = -7) then begin
              retrieve_x(tTMP_K04);
            end;

            vVlParcela := (vVlCalc / vNrParcela);
            vVlParcela := roundto(vVlParcela, 2);

            putitem_e(tTMP_K04, 'VL_PARCELA', item_f('VL_PARCELA', tTMP_K04) + vVlParcela);
            vVlTotal := vVlTotal + vVlParcela;
            putitem_e(tTMP_K04, 'NR_PARCELA', vNrContador);
            putitem_e(tTMP_K04, 'DS_RESUMIDA', vDsCampo);

            vNrContador := vNrContador + 1;
          end;

          putitem_e(tGER_CONDPGTOH, 'VL_TOTAL', item_f('VL_TOTAL', tGER_CONDPGTOH) + vVlCalc);
        end;

        setocc(tTRA_TRANSITEM, curocc(tTRA_TRANSITEM) + 1);
      end;

      putitem_e(tGER_CONDPGTOH, 'VL_TOTAL', item_f('VL_TOTAL', tGER_CONDPGTOH) - vVlBonus);

      vVlDif := vVlTotal - item_f('VL_TOTAL', tGER_CONDPGTOH);
      if (vVlDif <> 0) then begin
        setocc(tTMP_K04, -1);
        putitem_e(tTMP_K04, 'VL_PARCELA', item_f('VL_PARCELA', tTMP_K04) - vVlDif);
      end;
    end;
  end;
  if (vVlAbatimento > vVlBrutoTransacao) then begin
    if (vVlBrutoTransacao > 0) then begin
      vVlAbatimento := vVlAbatimento - vVlBrutoTransacao;
      vVlCalc := vVlAbatimento / vVlBrutoTransacao * 100;
    end else begin
      vVlCalc := vVlAbatimento / vVlTotalItem * 100;
    end;

    vPrAbatimento := roundto(vVlCalc, 2);
  end else begin
    vPrAbatimento := 0;
  end;

  clear_e(tTRA_ITEMSIMU);
  putitem_e(tTRA_ITEMSIMU, 'CD_EMPRESA', item_f('CD_EMPRESA', tTRA_TRANSACAO));
  putitem_e(tTRA_ITEMSIMU, 'NR_TRANSACAO', item_f('NR_TRANSACAO', tTRA_TRANSACAO));
  putitem_e(tTRA_ITEMSIMU, 'DT_TRANSACAO', item_a('DT_TRANSACAO', tTRA_TRANSACAO));
  retrieve_e(tTRA_ITEMSIMU);
  if (xStatus >= 0) then begin
    setocc(tTRA_ITEMSIMU, 1);
    while (xStatus >= 0) do begin
      clear_e(tTRA_TRANSITEM);
      putitem_e(tTRA_TRANSITEM, 'NR_ITEM', item_f('NR_ITEM', tTRA_ITEMSIMU));
      retrieve_e(tTRA_TRANSITEM);
      if (xStatus >= 0) then begin
        vNrOcc := curocc(tGER_CONDPGTOH);
        vPrVariacao := 0;

        creocc(tGER_CONDPGTOH, -1);
        putitem_e(tGER_CONDPGTOH, 'CD_CONDPGTO', item_f('CD_CONDPGTO', tTRA_ITEMSIMU));
        putitem_e(tGER_CONDPGTOH, 'TP_DOCUMENTO', item_f('TP_DOCUMENTO', tTRA_ITEMSIMU));
        putitem_e(tGER_CONDPGTOH, 'NR_SEQHISTRELSUB', item_f('NR_SEQHISTRELSUB', tTRA_ITEMSIMU));
        retrieve_o(tGER_CONDPGTOH);
        if (xStatus = 4) then begin
          vNrParcela := item_f('NR_PARCELAS', tGER_CONDPGTOH);
          vDsResumida := item_a('DS_RESUMIDA', tGER_CONDPGTOH);

          viParams := '';
          putitemXml(viParams, 'CD_PRODUTO', item_f('CD_PRODUTO', tTRA_TRANSITEM));
          voParams := activateCmp('PRDSVCO008', 'buscaDadosFilial', viParams); (*,viParams,voParams,, *)
          if (xStatus < 0) then begin
            Result := voParams;
            return(-1); exit;
          end;

          vPrDescMax := itemXmlF('PR_DESCMAX', voParams);

          if (vPrDescMax <> '') then begin
            vPrDescMax := vPrDescMax * (-1);

            if (vPrDescMax > item_f('PR_VARIACAO', tGER_CONDPGTOH)) then begin
              vPrVariacao := vPrDescMax;
            end else begin
              vPrVariacao := item_f('PR_VARIACAO', tGER_CONDPGTOH);
            end;
          end else begin
            vPrVariacao := item_f('PR_VARIACAO', tGER_CONDPGTOH);
          end;

          clear_e(tGER_CONDPGTOC);
          if (item_f('TP_DOCUMENTO', tTRA_ITEMSIMU) <> 4) then begin
            putitem_e(tGER_CONDPGTOC, 'CD_CONDPGTO', item_f('CD_CONDPGTO', tGER_CONDPGTOH));
            retrieve_e(tGER_CONDPGTOC);
            if (xStatus < 0) then begin
              clear_e(tGER_CONDPGTOC);
            end;
          end;
        end else begin
          discard 'GER_CONDPGTOH';
        end;
        if (vPrVariacao <> 0) then begin
          vInVariacao := True;
        end;

        setocc(tGER_CONDPGTOH, 1);

        if (item_f('VL_BONUSUTIL', tCTC_TRACARTAO) = 0) then begin
          putitem_e(tTRA_TRANSITEM, 'VL_TOTALBRUTO', item_f('VL_TOTALLIQUIDO', tTRA_TRANSITEM));
          putitem_e(tTRA_TRANSITEM, 'VL_UNITBRUTO', item_f('VL_UNITLIQUIDO', tTRA_TRANSITEM));
        end;

        vVlTotal := 0;

        vVlDesconto := (item_f('VL_UNITBRUTO', tTRA_TRANSITEM) - item_f('VL_UNITDESC', tTRA_TRANSITEM)) * vPrAbatimento / 100;
        vVlDesconto := roundto(vVlDesconto, 2);

        if (gInAniver = True) then begin
          if (item_f('PR_VARIACAO', tGER_CONDPGTOH) <= 0)  and (gprDescAniver < item_f('PR_VARIACAO', tGER_CONDPGTOH)) then begin
            putitem_e(tGER_CONDPGTOH, 'PR_VARIACAO', gprDescAniver);
          end;
          if (vPrDescMax <> '') then begin
            if (vPrDescMax > item_f('PR_VARIACAO', tGER_CONDPGTOH)) then begin
              vPrVariacao := vPrDescMax;
            end else begin
              vPrVariacao := item_f('PR_VARIACAO', tGER_CONDPGTOH);
            end;
          end else begin
            vPrVariacao := item_f('PR_VARIACAO', tGER_CONDPGTOH);
          end;

          vVlProdLiquido := (item_f('VL_UNITBRUTO', tTRA_TRANSITEM) - vVlDesconto);
          vVlProdBruto := item_f('VL_UNITBRUTO', tTRA_TRANSITEM);

          if (gTpCalculoSimularVd = 0) then begin
            if (item_f('PR_VARIACAO', tGER_CONDPGTOH) > 0) then begin
              vVlCalc := vVlProdLiquido + (vVlProdLiquido * gprDescAniver / 100);
              vVlProdLiquido := vVlCalc;
            end;

            vVlCalc := vVlProdLiquido + (vVlProdLiquido * item_f('PR_VARIACAO', tGER_CONDPGTOH) / 100);
          end else if (gTpCalculoSimularVd = 1) then begin
            if (item_f('PR_VARIACAO', tGER_CONDPGTOH) > 0) then begin
              vVlCalc := vVlProdBruto + (vVlProdBruto * gprDescAniver / 100);
              vVlProdBruto := vVlCalc;
            end;

            vVlCalc := vVlProdBruto + (vVlProdBruto * item_f('PR_VARIACAO', tGER_CONDPGTOH) / 100);
            vVlCalc := vVlCalc - vVlAbatimento;
          end else if (gTpCalculoSimularVd = 2) then begin
            if (item_f('PR_VARIACAO', tGER_CONDPGTOH) <= 0) then begin
              vVlCalc := vVlProdBruto + (vVlProdBruto * item_f('PR_VARIACAO', tGER_CONDPGTOH) / 100);
              vVlCalc := vVlCalc - vVlDesconto;
            end else begin
              vVlCalc := vVlProdLiquido + (vVlProdLiquido * gprDescAniver / 100);
              vVlCalc := vVlCalc + (vVlCalc * item_f('PR_VARIACAO', tGER_CONDPGTOH) / 100);
            end;
          end else if (gTpCalculoSimularVd = 3) then begin
            if (item_f('PR_VARIACAO', tGER_CONDPGTOH) <= 0) then begin
              vVlCalc := vVlProdLiquido + (vVlProdLiquido * item_f('PR_VARIACAO', tGER_CONDPGTOH) / 100);
            end else begin
              vVlCalc := vVlProdBruto + (vVlProdLiquido * gprDescAniver / 100);
              vVlCalc := vVlCalc + (vVlProdBruto * item_f('PR_VARIACAO', tGER_CONDPGTOH) / 100);
              vVlCalc := vVlCalc - vVlDesconto;
            end;
          end;
        end else begin
          if (vPrVariacao = 0) then begin
            vVlCalc := (item_f('VL_UNITBRUTO', tTRA_TRANSITEM) - vVlDesconto);
          end else begin
            if (gTpCalculoSimularVd = 0)  or (gTpCalculoSimularVd = 2 ) and (vPrVariacao > 0)  or (gTpCalculoSimularVd = 3 ) and (vPrVariacao < 0) then begin
              vVlCalc := (item_f('VL_UNITBRUTO', tTRA_TRANSITEM) - vVlDesconto);
              vVlCalc := vVlCalc + (vVlCalc * vPrVariacao / 100);
            end else begin
              vVlCalc := item_f('VL_UNITBRUTO', tTRA_TRANSITEM);
              vVlCalc := vVlCalc + (vVlCalc * vPrVariacao / 100);
              vVlCalc := vVlCalc - vVlDesconto;
            end;
          end;
        end;

        vVlCalc := roundto(vVlCalc, 2);
        vVlCalc := vVlCalc * item_f('QT_SOLICITADA', tTRA_TRANSITEM);

        vNrContador := 1;
        while (vNrParcela >= vNrContador) do begin
          if (item_f('TP_DOCUMENTO', tTRA_ITEMSIMU) = 1)  or (item_f('TP_DOCUMENTO', tTRA_ITEMSIMU) = 2)  or (item_f('TP_DOCUMENTO', tTRA_ITEMSIMU) = 14) then begin
            vDtVencimento := item_a('DT_BASE', tSIS_DUMMY);
          end else begin
            vDtVencimento := itemXml('DT_SISTEMA', PARAM_GLB);
          end;

          setocc(tGER_CONDPGTOI, 1);
          if (xStatus >= 0) then begin
            vDtVencimento := vDtVencimento + item_f('QT_DIA', tGER_CONDPGTOI);
          end;

          creocc(tTMP_K04, -1);
          putitem_e(tTMP_K04, 'NR_K01', vNrContador);
          putitem_e(tTMP_K04, 'NR_K02', item_f('TP_DOCUMENTO', tTRA_ITEMSIMU));
          putitem_e(tTMP_K04, 'NR_K03', item_f('NR_SEQHISTRELSUB', tTRA_ITEMSIMU));
          putitem_e(tTMP_K04, 'DT_GERAL', vDtVencimento);
          retrieve_o(tTMP_K04);
          if (xStatus = -7) then begin
            retrieve_x(tTMP_K04);
          end;

          vVlParcela := (vVlCalc / vNrParcela);
          vVlParcela := roundto(vVlParcela, 2);

          putitem_e(tTMP_K04, 'VL_PARCELA', item_f('VL_PARCELA', tTMP_K04) + vVlParcela);
          vVlTotal := vVlTotal + vVlParcela;
          putitem_e(tTMP_K04, 'NR_PARCELA', vNrContador);

          if (item_a('DS_RESUMIDA', tTMP_K04) = '') then begin
            putitem_e(tTMP_K04, 'DS_RESUMIDA', vDsResumida);
          end else begin
            putitem_e(tTMP_K04, 'DS_RESUMIDA', '' + DS_RESUMIDA + '.TMP_K04);
          end;

          vNrContador := vNrContador + 1;
        end;

        putitem_e(tGER_CONDPGTOH, 'VL_TOTAL', item_f('VL_TOTAL', tGER_CONDPGTOH) + vVlCalc);

        vVlDif := vVlTotal - vVlCalc;
        putitem_e(tTMP_K04, 'VL_PARCELA', item_f('VL_PARCELA', tTMP_K04) - vVlDif);
      end;

      setocc(tTRA_ITEMSIMU, curocc(tTRA_ITEMSIMU) + 1);
    end;
  end;
  if (item_f('VL_ENTRADA', tSIS_DUMMY) > 0) then begin
    creocc(tTMP_K04, -1);
    putitem_e(tTMP_K04, 'NR_K01', curocc(tTMP_K04));
    putitem_e(tTMP_K04, 'NR_K02', 3);
    putitem_e(tTMP_K04, 'NR_K03', 1);
    putitem_e(tTMP_K04, 'DT_GERAL', itemXml('DT_SISTEMA', PARAM_GLB));
    retrieve_o(tTMP_K04);
    if (xStatus = -7) then begin
      retrieve_x(tTMP_K04);
    end;

    putitem_e(tTMP_K04, 'VL_PARCELA', item_f('VL_ENTRADA', tSIS_DUMMY));
    putitem_e(tTMP_K04, 'NR_PARCELA', '');
    putitem_e(tTMP_K04, 'DS_RESUMIDA', 'ENTRADA');
  end;
  if (item_f('VL_ADIANTAMENTO', tSIS_DUMMY) > 0) then begin
    creocc(tTMP_K04, -1);
    putitem_e(tTMP_K04, 'NR_K01', curocc(tTMP_K04));
    putitem_e(tTMP_K04, 'NR_K02', 10);
    putitem_e(tTMP_K04, 'NR_K03', 1);
    putitem_e(tTMP_K04, 'DT_GERAL', itemXml('DT_SISTEMA', PARAM_GLB));
    retrieve_o(tTMP_K04);
    if (xStatus = -7) then begin
      retrieve_x(tTMP_K04);
    end;

    putitem_e(tTMP_K04, 'VL_PARCELA', item_f('VL_ADIANTAMENTO', tSIS_DUMMY));
    putitem_e(tTMP_K04, 'NR_PARCELA', '');
    putitem_e(tTMP_K04, 'DS_RESUMIDA', 'ADIANTAMENTO');
  end;
  if (item_f('VL_CREDEV', tSIS_DUMMY) > 0) then begin
    creocc(tTMP_K04, -1);
    putitem_e(tTMP_K04, 'NR_K01', curocc(tTMP_K04));
    putitem_e(tTMP_K04, 'NR_K02', 20);
    putitem_e(tTMP_K04, 'NR_K03', 1);
    putitem_e(tTMP_K04, 'DT_GERAL', itemXml('DT_SISTEMA', PARAM_GLB));
    retrieve_o(tTMP_K04);
    if (xStatus = -7) then begin
      retrieve_x(tTMP_K04);
    end;

    putitem_e(tTMP_K04, 'VL_PARCELA', item_f('VL_CREDEV', tSIS_DUMMY));
    putitem_e(tTMP_K04, 'NR_PARCELA', '');
    putitem_e(tTMP_K04, 'DS_RESUMIDA', 'CREDEV');
  end;

  vVlTotal := 0;

  setocc(tTMP_K04, 1);
  while (xStatus >= 0) do begin
    vVlTotal := vVlTotal + item_f('VL_PARCELA', tTMP_K04);

    setocc(tTMP_K04, curocc(tTMP_K04) + 1);
  end;
  setocc(tTMP_K04, 1);

  putitem_e(tSIS_DUMMY, 'VL_LIMITE', item_f('VL_LIMITETOTAL', tSIS_DUMMY) - vVlTotal + (item_f('VL_ENTRADA', tSIS_DUMMY) + item_f('VL_CREDEV', tSIS_DUMMY) + item_f('VL_ADIANTAMENTO', tSIS_DUMMY)));
  putitem_e(tSIS_DUMMY, 'PR_LIMITE', '');

  vVlTotal := vVlTotal + item_f('VL_DESCONTO', tSIS_DUMMY);

  if (vVlTotal <> vVlBrutoTransacao)  and (vInVariacao = False)  and (gInAniver = False) then begin
    vVlDif := vVlTotal - vVlBrutoTransacao;
    putitem_e(tTMP_K04, 'VL_PARCELA', item_f('VL_PARCELA', tTMP_K04) - vVlDif);
    putitem_e(tTMP_K04, 'VL_PARCELA', item_f('VL_PARCELA', tTMP_K04) - vVlBonus);
    putitem_e(tGER_CONDPGTOH, 'VL_TOTAL', item_f('VL_TOTAL', tGER_CONDPGTOH) - vVlDif);
    putitem_e(tGER_CONDPGTOH, 'VL_TOTAL', item_f('VL_TOTAL', tGER_CONDPGTOH) - vVlBonus);
  end;
  if (gDsLimiteCredito = 'S')  or ((gDsLimiteCredito = 'V')  and (item_f('TP_DOCUMENTO', tGER_CONDPGTOH) = 1 ) or (item_f('TP_DOCUMENTO', tGER_CONDPGTOH) = 2 ) or (item_f('TP_DOCUMENTO', tGER_CONDPGTOH) = 14)) then begin
    vPrLimite := (item_f('VL_LIMITE', tSIS_DUMMY) / item_f('VL_LIMITETOTAL', tSIS_DUMMY)) * 100;

    if (vPrLimite < 0) then begin
      putitem_e(tSIS_DUMMY, 'PR_LIMITE', vPrLimite * -1);
    end;
  end;

  return(0); exit;
end;

//------------------------------------------------------
function T_TRAFM113.confirma(pParams : String) : String;
//------------------------------------------------------

var
  vVlResto, vPrTotalDesc, vVlCalc, vPrVariacao, vVlMaior, vNrOcc, vVlAbatimento, vVlDesconto : Real;
  vVlBrutoTransacao, vVlLiquidoTransacao, vPrAbatimento, vPrSimulador, vVlLiquido, vCdLiberador : Real;
  vDsLstTransacao, vDsRegistro, viParams, voParams : String;
begin
  if (gCdClientePDV <> item_f('CD_PESSOA', tTRA_TRANSACAO))  and ((item_f('PR_LIMITE', tSIS_DUMMY) > 0)  or (item_f('VL_LIMITETOTAL', tSIS_DUMMY) <= 0)) then begin
    viParams := '';
    putitemXml(viParams, 'IN_USULOGADO', True);
    voParams := activateCmp('ADMFM020', 'exec', viParams); (*viParams,voParams,, *)
    if (xStatus < 0) then begin
      Result := voParams;
      return(-1); exit;
    end;
    if (itemXml('CD_USUARIO', voParams) > 0) then begin
      vCdLiberador := itemXmlF('CD_USUARIO', voParams);
    end else begin
      vCdLiberador := itemXmlF('CD_USUARIO', PARAM_GLB);
    end;
    if (item_f('PR_LIMITE', tSIS_DUMMY) > 0) then begin
      viParams := '';
      putitemXml(viParams, 'CD_COMPONENTE', TRAFM113);
      putitemXml(viParams, 'DS_CAMPO', 'PR_LIBERACAO_LIMITE');
      putitemXml(viParams, 'CD_EMPRESA', itemXmlF('CD_EMPRESA', PARAM_GLB));
      putitemXml(viParams, 'CD_USUARIO', vCdLiberador);
      putitemXml(viParams, 'VL_VALOR', item_f('PR_LIMITE', tSIS_DUMMY));
      voParams := activateCmp('ADMSVCO009', 'verificaRestricao', viParams); (*viParams,voParams,, *)
      if (xStatus < 0) then begin
        Result := voParams;
        return(-1); exit;
      end;
        if (xStatus < 0) then begin
          Result := voParams;
          return(-1); exit;
        end;
      end;
    end else if (item_f('VL_LIMITETOTAL', tSIS_DUMMY) <= 0) then begin
      viParams := '';
      putitemXml(viParams, 'CD_COMPONENTE', TRAFM113);
      putitemXml(viParams, 'DS_CAMPO', 'VL_LIBERACAO_LIMITE');
      putitemXml(viParams, 'CD_EMPRESA', itemXmlF('CD_EMPRESA', PARAM_GLB));
      putitemXml(viParams, 'CD_USUARIO', vCdLiberador);
      putitemXml(viParams, 'VL_VALOR', gabs(item_f('VL_LIMITE', tSIS_DUMMY)));
      voParams := activateCmp('ADMSVCO009', 'verificaRestricao', viParams); (*viParams,voParams,, *)
      if (xStatus < 0) then begin
        Result := voParams;
        return(-1); exit;
      end;
    end;
  end;

  vVlAbatimento := item_f('VL_ADIANTAMENTO', tSIS_DUMMY) + item_f('VL_CREDEV', tSIS_DUMMY) + item_f('VL_ENTRADA', tSIS_DUMMY) + item_f('VL_DESCONTO', tSIS_DUMMY);
  vVlResto := item_f('VL_TOTAL', tGER_CONDPGTOH) + vVlAbatimento - item_f('VL_TRANSACAO', tTRA_TRANSACAO);
  vPrTotalDesc := item_f('PR_DESCONTO', tSIS_DUMMY);
  vPrVariacao := item_f('PR_VARIACAO', tGER_CONDPGTOH);

  if (item_b('IN_DESCVARIACAO', tGER_CONDPGTOH) = True) then begin
    vPrVariacao := 0;
    vVlResto := 0;
  end;

  vVlBrutoTransacao := item_f('VL_TRANSACAO', tTRA_TRANSACAO) + item_f('VL_BONUSUTIL', tCTC_TRACARTAO) + item_f('VL_BONUSDESC', tTRA_TRANSACADIC);
  vVlCalc := vVlAbatimento / vVlBrutoTransacao * 100;
  vPrAbatimento := roundto(vVlCalc, 6);

  if (item_f('VL_TOTAL', tGER_CONDPGTOH) <= 0)  and (item_f('VL_TRANSACAO', tTRA_TRANSACAO) <> vVlAbatimento) then begin
    message/info 'Valor insuficiente para forma de pagamento selecionada!';
    return(-1); exit;
  end;
  if (empty(tTRA_TRANSITEM) = False)  and (item_f('VL_TRANSACAO', tTRA_TRANSACAO) <> vVlAbatimento) then begin
    vVlMaior := 0;
    setocc(tTRA_TRANSITEM, 1);
    while (xStatus >= 0) do begin

      if (item_f('VL_BONUSUTIL', tCTC_TRACARTAO) = 0 ) and (item_f('VL_BONUSDESC', tTRA_TRANSACADIC) = 0) then begin
        putitem_e(tTRA_TRANSITEM, 'VL_TOTALBRUTO', item_f('VL_TOTALLIQUIDO', tTRA_TRANSITEM));
        putitem_e(tTRA_TRANSITEM, 'VL_UNITBRUTO', item_f('VL_UNITLIQUIDO', tTRA_TRANSITEM));
        putitem_e(tTRA_TRANSITEM, 'PR_DESCONTO', '');
        putitem_e(tTRA_TRANSITEM, 'VL_TOTALDESC', '');
        putitem_e(tTRA_TRANSITEM, 'VL_TOTALDESCCAB', '');
        putitem_e(tTRA_TRANSITEM, 'VL_UNITDESCCAB', '');
        putitem_e(tTRA_TRANSITEM, 'VL_UNITDESC', '');
      end;
      if (vPrVariacao <> 0) then begin
        vVlDesconto := item_f('VL_TOTALBRUTO', tTRA_TRANSITEM) * vPrAbatimento / 100;
        vVlCalc := ((item_f('VL_TOTALBRUTO', tTRA_TRANSITEM) - vVlDesconto) * vPrVariacao) / 100;

        vVlCalc := roundto(vVlCalc, 2);
        vVlResto := vVlResto - vVlCalc;
        putitem_e(tTRA_TRANSITEM, 'VL_TOTALBRUTO', item_f('VL_TOTALBRUTO', tTRA_TRANSITEM) + vVlCalc);
        vVlCalc := item_f('VL_TOTALBRUTO', tTRA_TRANSITEM) / item_f('QT_SOLICITADA', tTRA_TRANSITEM);
        putitem_e(tTRA_TRANSITEM, 'VL_UNITBRUTO', roundto(vVlCalc, 6));
        putitem_e(tTRA_TRANSITEM, 'VL_TOTALLIQUIDO', item_f('VL_TOTALBRUTO', tTRA_TRANSITEM));
        putitem_e(tTRA_TRANSITEM, 'VL_UNITLIQUIDO', item_f('VL_UNITBRUTO', tTRA_TRANSITEM));
      end;
      if (item_f('VL_TOTALBRUTO', tTRA_TRANSITEM) > vVlMaior) then begin
        vVlMaior := item_f('VL_TOTALLIQUIDO', tTRA_TRANSITEM);
        vNrOcc := curocc(tTRA_TRANSITEM);
      end;

      setocc(tTRA_TRANSITEM, curocc(tTRA_TRANSITEM) + 1);
    end;
    if (vVlResto <> 0)  and (vVlAbatimento <> 0 ) or (vPrVariacao <> 0) then begin
      setocc(tTRA_TRANSITEM, 1);
      putitem_e(tTRA_TRANSITEM, 'VL_TOTALBRUTO', item_f('VL_TOTALBRUTO', tTRA_TRANSITEM) + vVlResto);
      vVlCalc := item_f('VL_TOTALBRUTO', tTRA_TRANSITEM) / item_f('QT_SOLICITADA', tTRA_TRANSITEM);
      putitem_e(tTRA_TRANSITEM, 'VL_UNITBRUTO', roundto(vVLCalc, 6));
      putitem_e(tTRA_TRANSITEM, 'VL_TOTALLIQUIDO', item_f('VL_TOTALBRUTO', tTRA_TRANSITEM));
      putitem_e(tTRA_TRANSITEM, 'VL_UNITLIQUIDO', item_f('VL_UNITBRUTO', tTRA_TRANSITEM));
    end;
  end;

  vVlResto := item_f('VL_DESCONTO', tSIS_DUMMY) + item_f('VL_BONUSUTIL', tCTC_TRACARTAO) + item_f('VL_BONUSDESC', tTRA_TRANSACADIC);

  if (item_f('VL_DESCONTO', tSIS_DUMMY) > 0) then begin
    vVlBrutoTransacao := item_f('VL_TRANSACAO', tTRA_TRANSACAO) + item_f('VL_DESCONTO', tTRA_TRANSACAO);
    vPrTotalDesc := (((item_f('VL_DESCONTO', tSIS_DUMMY)) / vVlBrutoTransacao) * 100);
    vPrTotalDesc := roundto(vPrTotalDesc, 2);
  end;
  if (empty(tTRA_TRANSITEM) = False)  and (vVlResto > 0) then begin
    vVlMaior := 0;
    setocc(tTRA_TRANSITEM, 1);
    while (xStatus >= 0) do begin

      if ((gInBloqDesItemProm = True)  and (item_f('CD_PROMOCAO', tTRA_TRANSITEM) > 0)) then begin
      end else begin
        vVlCalc := item_f('VL_TOTALLIQUIDO', tTRA_TRANSITEM) + item_f('VL_TOTALDESCCAB', tTRA_TRANSITEM);
        vVlCalc := vVlCalc * vPrTotalDesc / 100;
        putitem_e(tTRA_TRANSITEM, 'VL_TOTALDESCCAB', item_f('VL_TOTALDESCCAB', tTRA_TRANSITEM) + roundto(vVlCalc, 2));
        putitem_e(tTRA_TRANSITEM, 'VL_TOTALLIQUIDO', item_f('VL_TOTALBRUTO', tTRA_TRANSITEM) - (item_f('VL_TOTALDESC', tTRA_TRANSITEM) + item_f('VL_TOTALDESCCAB', tTRA_TRANSITEM)));
        vVlCalc := item_f('VL_TOTALDESCCAB', tTRA_TRANSITEM) / item_f('QT_SOLICITADA', tTRA_TRANSITEM);
        putitem_e(tTRA_TRANSITEM, 'VL_UNITDESCCAB', roundto(vVLCalc, 6));
        vVlCalc := item_f('VL_TOTALLIQUIDO', tTRA_TRANSITEM) / item_f('QT_SOLICITADA', tTRA_TRANSITEM);
        putitem_e(tTRA_TRANSITEM, 'VL_UNITLIQUIDO', roundto(vVLCalc, 6));
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
      putitem_e(tTRA_TRANSITEM, 'VL_UNITDESCCAB', roundto(vVLCalc, 6));
      vVlCalc := item_f('VL_TOTALLIQUIDO', tTRA_TRANSITEM) / item_f('QT_SOLICITADA', tTRA_TRANSITEM);
      putitem_e(tTRA_TRANSITEM, 'VL_UNITLIQUIDO', roundto(vVLCalc, 6));
    end;
  end;

  setocc(tTRA_TRANSITEM, 1);
  while (xStatus >= 0) do begin

    if (item_f('VL_UNITLIQUIDO', tTRA_TRANSITEM) < 0.01) then begin
      putitem_e(tTRA_TRANSITEM, 'VL_UNITLIQUIDO', 0.01);
      vVlCalc := item_f('VL_UNITLIQUIDO', tTRA_TRANSITEM) * item_f('QT_SOLICITADA', tTRA_TRANSITEM);
      putitem_e(tTRA_TRANSITEM, 'VL_TOTALLIQUIDO', roundto(vVlCalc, 2));
    end;

    viParams := '';
    putlistitensocc_e(viParams, tTRA_TRANSITEM);
    putitemXml(viParams, 'IN_TOTAL', False);
    voParams := activateCmp('TRASVCO004', 'gravaItemTransacao', viParams); (*,viParams,voParams,, *)
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
  voParams := activateCmp('TRASVCO004', 'gravaTotalTransacao', viParams); (*,viParams,voParams,, *)
  if (xStatus < 0) then begin
    Result := voParams;
    return(-1); exit;
  end;

  viParams := '';
  putitemXml(viParams, 'CD_EMPRESA', item_f('CD_EMPRESA', tTRA_TRANSACAO));
  putitemXml(viParams, 'NR_TRANSACAO', item_f('NR_TRANSACAO', tTRA_TRANSACAO));
  putitemXml(viParams, 'DT_TRANSACAO', item_a('DT_TRANSACAO', tTRA_TRANSACAO));
  putitemXml(viParams, 'IN_SOBREPOR', True);
  voParams := activateCmp('TRASVCO004', 'gravaParcelaTransacao', viParams); (*,viParams,voParams,, *)
  if (xStatus < 0) then begin
    Result := voParams;
    return(-1); exit;
  end;

  vVlLiquido := item_f('VL_TRANSACAO', tTRA_TRANSACAO) - (item_f('VL_ENTRADA', tSIS_DUMMY) + item_f('VL_ADIANTAMENTO', tSIS_DUMMY) + item_f('VL_CREDEV', tSIS_DUMMY) + item_f('VL_DESCONTO', tSIS_DUMMY));
  vVlLiquido := roundto(vVlLiquido, 2);
  vPrSimulador := ((vVlLiquido / item_f('VL_TOTAL', tGER_CONDPGTOH)) * 100) - 100;
  vPrSimulador := roundto(vPrSimulador, 4);
  vPrSimulador := gabs(vPrSimulador);
  viParams := '';
  putitemXml(viParams, 'CD_EMPRESA', item_f('CD_EMPRESA', tTRA_TRANSACAO));
  putitemXml(viParams, 'NR_TRANSACAO', item_f('NR_TRANSACAO', tTRA_TRANSACAO));
  putitemXml(viParams, 'DT_TRANSACAO', item_a('DT_TRANSACAO', tTRA_TRANSACAO));
  putitemXml(viParams, 'VL_SIMULADOR', item_f('VL_TOTAL', tGER_CONDPGTOH));
  putitemXml(viParams, 'PR_SIMULADOR', vPrSimulador);
  voParams := activateCmp('TRASVCO016', 'gravaDadosAdicionais', viParams); (*,viParams,voParams,, *)
  if (xStatus < 0) then begin
    Result := voParams;
    return(-1); exit;
  end;

  return(0); exit;
end;

end.
