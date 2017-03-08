unit cTRAFM078;

interface

(* COMPONENTES 
  ADMFM020 / ADMSVCO001 / ADMSVCO009 / CTCSVCO004 / FCCSVCO002
  TRAFM062 / TRASVCO004 / TRASVCO016 / 
*)        

uses
  Classes, SysUtils, Math, DB,
  cServiceUnf, cDataSetUnf;

type
  T_TRAFM078 = class(TcServiceUnf)
  private
    tCTC_TRACARTAO,
    tF_GER_OPERACAO,
    tF_TRA_TRANSACAO,
    tFCX_HISTRELSUB,
    tGER_CONDPGTOC,
    tGER_CONDPGTOH,
    tGER_OPERACAO,
    tPES_CLIENTEFPGTO,
    tPES_PESFISICA,
    tPES_PFADIC,
    tPES_PREFCLIENTE,
    tR_TRA_TRANSACAO,
    tSIS_ABATIMENTO,
    tSIS_BOTOES,
    tSIS_DUMMY,
    tSIS_FILTRO,
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
    function INIT(pParams : String = '') : String;
    function CLEANUP(pParams : String = '') : String;
    function carregaDadosIniciais(pParams : String = '') : String;
    function recalcula(pParams : String = '') : String;
    function desconto(pParams : String = '') : String;
    function confirma(pParams : String = '') : String;
    function sugereValorEntrada(pParams : String = '') : String;
    function validaSenha(pParams : String = '') : String;
    function validaRestricaoUsuario(pParams : String = '') : String;
  end;

implementation

uses
  cADMSVCO001,
  cActivate, cStatus, cFuncao, cXml, dModulo;

var
  gCdClientePDV,
  gCdEmpresa,
  gCdUsuarioDesc,
  gDsLstCondPgto,
  gDtTransacao,
  gInAniver,
  gInBloqDesItemProm,
  gInUsaCalculoLimite4,
  gNrTransacao,
  gprDescAniver,
  gprEscoreEntrada4,
  greplace(,
  gTpCalculoSimularVd,
  gTpSimuladorFat,
  gVlEntrada,
  gVlMaxAbatimentoSim : String;

//---------------------------------------------------------------
constructor T_TRAFM078.Create(AOwner: TComponent);
//---------------------------------------------------------------
begin
  inherited Create(AOwner);
  setEntidade('');
end;

//--------------------------------
destructor T_TRAFM078.Destroy;
//--------------------------------
begin
  inherited Destroy;
end;

//---------------------------------------------------------------
function T_TRAFM078.getParam(pParams : String = '') : String;
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
  putitem(xParam, 'CD_CONDPGTO');
  putitem(xParam, 'CD_EMPRESA');
  putitem(xParam, 'CD_USUARIODESC');
  putitem(xParam, 'CLIENTE_PDV');
  putitem(xParam, 'DT_TRANSACAO');
  putitem(xParam, 'IN_USA_CALCULO_LIMITE_4');
  putitem(xParam, 'NR_SEQHISTRELSUB');
  putitem(xParam, 'NR_TRANSACAO');
  putitem(xParam, 'PR_DESCONTO');
  putitem(xParam, 'PR_ESCORE_ENTRADA_4');
  putitem(xParam, 'TP_DOCUMENTO');
  putitem(xParam, 'VL_ADIANTAMENTO');
  putitem(xParam, 'VL_CREDEV');
  putitem(xParam, 'VL_DESCONTO');
  putitem(xParam, 'VL_ENTRADA');

  xParam := T_ADMSVCO001.GetParametro(xParam);

  gCdClientePDV := itemXml('CLIENTE_PDV', xParam);
  gDsLstCondPgto := itemXml('DS_LST_CONDPGTO_SIM_FAT', xParam);
  gInBloqDesItemProm := itemXml('IN_BLOQ_DESC_ITEM_PROM', xParam);
  gprDescAniver := itemXml('PR_DESC_ANIVERSARIANTE', xParam);
  gprEscoreEntrada4 := itemXml('PR_ESCORE_ENTRADA_4', xParam);
  gTpCalculoSimularVd := itemXml('TP_CALCULO_SIMULADOR_VD', xParam);
  gTpSimuladorFat := itemXml('TP_SIMULADOR_FAT', xParam);
  gVlMaxAbatimentoSim := itemXml('VL_MAX_ABATIMENTO_SIM', xParam);

  xParamEmp := '';
  putitem(xParamEmp, 'CD_CONDPGTO');
  putitem(xParamEmp, 'CD_EMPRESA');
  putitem(xParamEmp, 'CD_USUARIODESC');
  putitem(xParamEmp, 'CLIENTE_PDV');
  putitem(xParamEmp, 'DS_LST_CONDPGTO_SIM_FAT');
  putitem(xParamEmp, 'DT_TRANSACAO');
  putitem(xParamEmp, 'IN_BLOQ_DESC_ITEM_PROM');
  putitem(xParamEmp, 'IN_USA_CALCULO_LIMITE_4');
  putitem(xParamEmp, 'NR_SEQHISTRELSUB');
  putitem(xParamEmp, 'NR_TRANSACAO');
  putitem(xParamEmp, 'PR_DESC_ANIVERSARIANTE');
  putitem(xParamEmp, 'PR_DESCONTO');
  putitem(xParamEmp, 'PR_ESCORE_ENTRADA_4');
  putitem(xParamEmp, 'TP_CALCULO_SIMULADOR_VD');
  putitem(xParamEmp, 'TP_DOCUMENTO');
  putitem(xParamEmp, 'TP_SIMULADOR_FAT');
  putitem(xParamEmp, 'VL_ADIANTAMENTO');
  putitem(xParamEmp, 'VL_CREDEV');
  putitem(xParamEmp, 'VL_DESCONTO');
  putitem(xParamEmp, 'VL_ENTRADA');
  putitem(xParamEmp, 'VL_MAX_ABATIMENTO_SIM');

  xParamEmp := T_ADMSVCO001.GetParamEmpresa(piCdEmpresa, xParamEmp);

  gDsLstCondPgto := itemXml('DS_LST_CONDPGTO_SIM_FAT', xParamEmp);
  gInBloqDesItemProm := itemXml('IN_BLOQ_DESC_ITEM_PROM', xParamEmp);
  gprDescAniver := itemXml('PR_DESC_ANIVERSARIANTE', xParamEmp);
  gTpCalculoSimularVd := itemXml('TP_CALCULO_SIMULADOR_VD', xParamEmp);
  gTpSimuladorFat := itemXml('TP_SIMULADOR_FAT', xParamEmp);
  gVlMaxAbatimentoSim := itemXml('VL_MAX_ABATIMENTO_SIM', xParamEmp);

end;

//---------------------------------------------------------------
function T_TRAFM078.setEntidade(pParams : String = '') : String;
//---------------------------------------------------------------
begin
  tCTC_TRACARTAO := GetEntidade('CTC_TRACARTAO');
  tF_GER_OPERACAO := GetEntidade('F_GER_OPERACAO');
  tF_TRA_TRANSACAO := GetEntidade('F_TRA_TRANSACAO');
  tFCX_HISTRELSUB := GetEntidade('FCX_HISTRELSUB');
  tGER_CONDPGTOC := GetEntidade('GER_CONDPGTOC');
  tGER_CONDPGTOH := GetEntidade('GER_CONDPGTOH');
  tGER_OPERACAO := GetEntidade('GER_OPERACAO');
  tPES_CLIENTEFPGTO := GetEntidade('PES_CLIENTEFPGTO');
  tPES_PESFISICA := GetEntidade('PES_PESFISICA');
  tPES_PFADIC := GetEntidade('PES_PFADIC');
  tPES_PREFCLIENTE := GetEntidade('PES_PREFCLIENTE');
  tR_TRA_TRANSACAO := GetEntidade('R_TRA_TRANSACAO');
  tSIS_ABATIMENTO := GetEntidade('SIS_ABATIMENTO');
  tSIS_BOTOES := GetEntidade('SIS_BOTOES');
  tSIS_DUMMY := GetEntidade('SIS_DUMMY');
  tSIS_FILTRO := GetEntidade('SIS_FILTRO');
  tTRA_LIMDESCONTO := GetEntidade('TRA_LIMDESCONTO');
  tTRA_TRANSACADIC := GetEntidade('TRA_TRANSACADIC');
  tTRA_TRANSACAO := GetEntidade('TRA_TRANSACAO');
  tTRA_TRANSCONDPGTOH := GetEntidade('TRA_TRANSCONDPGTOH');
  tTRA_TRANSITEM := GetEntidade('TRA_TRANSITEM');
end;

//-----------------------------------------------------
function T_TRAFM078.preEDIT(pParams : String) : String;
//-----------------------------------------------------

var
  vMesAniver, vMesAtual : Real;
  vDtSistema : TDate;
begin
  gCdEmpresa := itemXmlF('CD_EMPRESA', viParams);
  gDtTransacao := itemXml('DT_TRANSACAO', viParams);
  gNrTransacao := itemXmlF('NR_TRANSACAO', viParams);

  if (gCdEmpresa = 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN001', 'Empresa da transação não informada!', '');
    return(-1); exit;
  end;
  if (gDtTransacao = 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN001', 'Data da transação não informada!', '');
    return(-1); exit;
  end;
  if (gNrTransacao = 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN001', 'Número da transação não informada!', '');
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
function T_TRAFM078.posEDIT(pParams : String) : String;
//-----------------------------------------------------

var
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

      putlistitensocc_e(voParams, tTRA_TRANSCONDPGTOH);
      putitemXml(voParams, 'CD_USUARIODESC', gCdUsuarioDesc);
    end;
  end;

  return(0); exit;
end;

//--------------------------------------------------
function T_TRAFM078.INIT(pParams : String) : String;
//--------------------------------------------------
begin
  xParam := '';
  putitem(xParam,  'CLIENTE_PDV');
  putitem(xParam,  'IN_USA_CALCULO_LIMITE_4');
  putitem(xParam,  'PR_ESCORE_ENTRADA_4');
  xParam := T_ADMSVCO001.GetParametro(xParam); (*xParam,xParam,, *)

  gCdClientePDV := itemXml('CLIENTE_PDV', xParam);
  gInUsaCalculoLimite4= itemXmlB('IN_USA_CALCULO_LIMITE_4', xParam);
  gprEscoreEntrada4 := itemXmlF('PR_ESCORE_ENTRADA_4', xParam);

  xParamEmp := '';
  putitem(xParamEmp,  'TP_SIMULADOR_FAT');
  putitem(xParamEmp,  'TP_CALCULO_SIMULADOR_VD');
  putitem(xParamEmp,  'IN_BLOQ_DESC_ITEM_PROM');
  putitem(xParamEmp,  'PR_DESC_ANIVERSARIANTE');
  putitem(xParamEmp,  'VL_MAX_ABATIMENTO_SIM');
  putitem(xParamEmp,  'DS_LST_CONDPGTO_SIM_FAT');
  xParamEmp := T_ADMSVCO001.GetParamEmpresa(piCdEmpresa, xParamEmp); (*itemXml('CD_EMPRESA', *)

  gTpSimuladorFat := itemXmlF('TP_SIMULADOR_FAT', xParamEmp);
  gTpCalculoSimularVd := itemXmlF('TP_CALCULO_SIMULADOR_VD', xParamEmp);
  gInBloqDesItemProm := itemXmlB('IN_BLOQ_DESC_ITEM_PROM', xParamEmp);
  gprDescAniver := itemXmlF('PR_DESC_ANIVERSARIANTE', xParamEmp);
  gVlMaxAbatimentoSim := itemXmlF('VL_MAX_ABATIMENTO_SIM', xParamEmp);
  gDsLstCondPgto := itemXml('DS_LST_CONDPGTO_SIM_FAT', xParamEmp);
  gDsLstCondPgto := greplace(DsLstCondPgtog, 1, ';

  _Caption := '' + TRAFM + '078 - Simulação de Forma de Pagamento';
end;

//-----------------------------------------------------
function T_TRAFM078.CLEANUP(pParams : String) : String;
//-----------------------------------------------------
begin
end;

//------------------------------------------------------------------
function T_TRAFM078.carregaDadosIniciais(pParams : String) : String;
//------------------------------------------------------------------

var
  vNrCtaCliente : Real;
  vDtSaldo : TDate;
  viParams, voParams : String;
  vInPDV, vInTroca, vInUtilizar : Boolean;
  vDsGeral, vDsLstTpDocumento, vDsTpDocumento, vDsDocumento, vDsLstDocumento, vDsCampo : String;
  vNrDocumento : Real;
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
    Result := SetStatus(STS_ERROR, 'GEN001', 'Transação não encontrada. Emp. ' + FloatToStr(gCdEmpresa) + ' Transação ' + FloatToStr(gNrTransacao) + ' Dt. ' + gDtTransacao', + ' '');
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
  if (item_f('CD_CARTAO', tCTC_TRACARTAO) <> '') then begin
    vDsLstDocumento := valrep(item_f('TP_DOCUMENTO', tSIS_FILTRO));
    valrep(putitem_e(tSIS_FILTRO, 'TP_DOCUMENTO'), '');
    repeat
      getitem(vDsDocumento, vDsLstDocumento, 1);
      vNrDocumento := vDsDocumento;
      vDsCampo := itemXml('' + FloatToStr(vNrDocumento',) + ' vDsLstDocumento);
      viParams := '';
      putitemXml(viParams, 'CD_CARTAO', item_f('CD_CARTAO', tCTC_TRACARTAO));
      putitemXml(viParams, 'TP_DOCUMENTO', vNrDocumento);
      voParams := activateCmp('CTCSVCO004', 'verificaTpDocumentoCartao', viParams); (*,viParams,voParams,, *)
      if (xStatus < 0) then begin
        Result := voParams;
        return(-1); exit;
      end;
      if (voParams <> '') then begin
        vInUtilizar := itemXmlB('IN_VALIDO', voParams);
      end;
      if (vInUtilizar = True) then begin
        vDsTpDocumento := '';
        putitemXml(vDsTpDocumento, vNrDocumento, vDsCampo);
        putitem(vDsLstTpDocumento,  vDsTpDocumento);
      end;
      delitem(vDsLstDocumento, 1);
    until (vDsLstDocumento = '');

    valrep(putitem_e(tSIS_FILTRO, 'TP_DOCUMENTO'), vDsLstTpDocumento);
    gprompt := item_f('TP_DOCUMENTO', tSIS_FILTRO);
  end;
  if (gVlMaxAbatimentoSim <= 0) then begin
    fieldsyntax item_f('VL_ABATIMENTO', tSIS_ABATIMENTO), 'DIM';
  end;

  voParams := sugereValorEntrada(viParams); (* *)
  if (xStatus < 0) then begin
    Result := voParams;
    return(-1); exit;
  end;

  return(0); exit;
end;

//-------------------------------------------------------
function T_TRAFM078.recalcula(pParams : String) : String;
//-------------------------------------------------------

var
  vVlAbatimento, vVlTotal, vVlTransacao, vVlPlano, vCdCondPgto : Real;
  vInAniver : Boolean;
begin
  vVlTransacao := item_f('VL_TRANSACAO', tTRA_TRANSACAO) + item_f('VL_BONUSUTIL', tCTC_TRACARTAO) + item_f('VL_BONUSDESC', tTRA_TRANSACADIC);
  vVlAbatimento := item_f('VL_ADIANTAMENTO', tSIS_DUMMY) + item_f('VL_CREDEV', tSIS_DUMMY) + item_f('VL_ENTRADA', tSIS_DUMMY) + item_f('VL_DESCONTO', tSIS_DUMMY);
  vVlTotal := vVlTransacao - vVlAbatimento;

  if (vVlTotal < 0) then begin
    message/info 'Valores incorretos para geração das formas de pagamento!';
    return(-1); exit;
  end;

  vCdCondPgto := '';

  clear_e(tPES_PREFCLIENTE);
  putitem_e(tPES_PREFCLIENTE, 'CD_CLIENTE', item_f('CD_PESSOA', tTRA_TRANSACAO));
  retrieve_e(tPES_PREFCLIENTE);
  if (xStatus >= 0) then begin
    vCdCondPgto := item_f('CD_CONDPAGTO', tPES_PREFCLIENTE);
  end;

  clear_e(tGER_CONDPGTOH);

  if (vVlTotal > 0) then begin
    if (vCdCondPgto <> 0) then begin
      putitem_e(tGER_CONDPGTOH, 'CD_CONDPGTO', vCdCondPgto);
    end else if (gDsLstCondPgto <> '') then begin
      putitem_e(tGER_CONDPGTOH, 'CD_CONDPGTO', gDsLstCondPgto);
    end;
    if (item_f('TP_DOCUMENTO', tSIS_FILTRO) <> 0) then begin
      putitem_e(tGER_CONDPGTOH, 'TP_DOCUMENTO', item_f('TP_DOCUMENTO', tSIS_FILTRO));
    end;
    retrieve_e(tGER_CONDPGTOH);
    if (xStatus >= 0) then begin
      setocc(tGER_CONDPGTOH, 1);
      while (xStatus >= 0) do begin
        if (gInAniver = True) then begin
          if (item_f('PR_VARIACAO', tGER_CONDPGTOH) <= 0)  and (gprDescAniver < item_f('PR_VARIACAO', tGER_CONDPGTOH)) then begin
            putitem_e(tGER_CONDPGTOH, 'PR_VARIACAO', gprDescAniver);
          end;

          vVlTransacao := item_f('VL_TRANSACAO', tTRA_TRANSACAO) + item_f('VL_BONUSUTIL', tCTC_TRACARTAO) + item_f('VL_BONUSDESC', tTRA_TRANSACADIC);

          vVlAbatimento := item_f('VL_ADIANTAMENTO', tSIS_DUMMY) + item_f('VL_CREDEV', tSIS_DUMMY) + item_f('VL_ENTRADA', tSIS_DUMMY) + item_f('VL_DESCONTO', tSIS_DUMMY);
          vVlTotal := vVlTransacao - vVlAbatimento;

          if (gTpCalculoSimularVd = 0) then begin
            if (item_f('PR_VARIACAO', tGER_CONDPGTOH) > 0) then begin
              vVlPlano := vVlTotal + (vVlTotal * gprDescAniver / 100);
              vVlTotal := vVlPlano;
            end;

            vVlPlano := vVlTotal + (vVlTotal * item_f('PR_VARIACAO', tGER_CONDPGTOH) / 100);
          end else if (gTpCalculoSimularVd = 1) then begin
            if (item_f('PR_VARIACAO', tGER_CONDPGTOH) > 0) then begin
              vVlPlano := vVlTransacao + (vVlTransacao * gprDescAniver / 100);
              vVlTransacao := vVlPlano;
            end;

            vVlPlano := vVlTransacao + (vVlTransacao * item_f('PR_VARIACAO', tGER_CONDPGTOH) / 100);
            vVlPlano := vVlPlano - vVlAbatimento;
          end else if (gTpCalculoSimularVd = 2) then begin
            if (item_f('PR_VARIACAO', tGER_CONDPGTOH) <= 0) then begin
              vVlPlano := vVlTransacao + (vVlTransacao * item_f('PR_VARIACAO', tGER_CONDPGTOH) / 100);
              vVlPlano := vVlPlano - vVlAbatimento;
            end else begin
              vVlPlano := vVlTotal + (vVlTotal * gprDescAniver / 100);
              vVlPlano := vVlPlano + (vVlPlano * item_f('PR_VARIACAO', tGER_CONDPGTOH) / 100);
            end;
          end else if (gTpCalculoSimularVd = 3) then begin
            if (item_f('PR_VARIACAO', tGER_CONDPGTOH) <= 0) then begin
              vVlPlano := vVlTotal + (vVlTotal * item_f('PR_VARIACAO', tGER_CONDPGTOH) / 100);
            end else begin
              vVlPlano := vVlTransacao + (vVlTotal * gprDescAniver / 100);
              vVlPlano := vVlPlano + (vVlTransacao * item_f('PR_VARIACAO', tGER_CONDPGTOH) / 100);
              vVlPlano := vVlPlano - vVlAbatimento;
            end;
          end;
        end else begin
          if (gTpCalculoSimularVd = 0) then begin
            vVlPlano := vVlTotal + (vVlTotal * item_f('PR_VARIACAO', tGER_CONDPGTOH) / 100);
          end else if (gTpCalculoSimularVd = 1) then begin
            vVlPlano := vVlTransacao + (vVlTransacao * item_f('PR_VARIACAO', tGER_CONDPGTOH) / 100);
            vVlPlano := vVlPlano - vVlAbatimento;
          end else if (gTpCalculoSimularVd = 2) then begin
            if (item_f('PR_VARIACAO', tGER_CONDPGTOH) <= 0) then begin
              vVlPlano := vVlTransacao + (vVlTransacao * item_f('PR_VARIACAO', tGER_CONDPGTOH) / 100);
              vVlPlano := vVlPlano - vVlAbatimento;
            end else begin
              vVlPlano := vVlTotal + (vVlTotal * item_f('PR_VARIACAO', tGER_CONDPGTOH) / 100);
            end;
          end else if (gTpCalculoSimularVd = 3) then begin
            if (item_f('PR_VARIACAO', tGER_CONDPGTOH) <= 0) then begin
              vVlPlano := vVlTotal + (vVlTotal * item_f('PR_VARIACAO', tGER_CONDPGTOH) / 100);
            end else begin
              vVlPlano := vVlTransacao + (vVlTransacao * item_f('PR_VARIACAO', tGER_CONDPGTOH) / 100);
              vVlPlano := vVlPlano - vVlAbatimento;
            end;
          end;
        end;

        vVlPlano := vVlPlano - (item_f('VL_BONUSUTIL', tCTC_TRACARTAO) + item_f('VL_BONUSDESC', tTRA_TRANSACADIC));

        if (vVlPlano < 0) then begin
          vVlPlano := 0;
        end;

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
        if (item_f('TP_DOCUMENTO', tGER_CONDPGTOH) = 7 ) or (item_f('TP_DOCUMENTO', tGER_CONDPGTOH) = 8 ) or (item_f('TP_DOCUMENTO', tGER_CONDPGTOH) = 13 ) or (item_f('TP_DOCUMENTO', tGER_CONDPGTOH) = 19 ) or (item_f('TP_DOCUMENTO', tGER_CONDPGTOH) = 22) then begin
          putitem_e(tGER_CONDPGTOH, 'NR_PARCELAS', 1);
        end;

        vVlPlano := roundto(vVlPlano, 2);

        if (item_f('VL_ABATIMENTO', tSIS_ABATIMENTO) > 0) then begin
          vVlPlano := vVlPlano - item_f('VL_ABATIMENTO', tSIS_ABATIMENTO);
        end;

        putitem_e(tGER_CONDPGTOH, 'VL_PARCELA', vVlPlano / item_f('NR_PARCELAS', tGER_CONDPGTOH));
        putitem_e(tGER_CONDPGTOH, 'VL_TOTAL', item_f('VL_PARCELA', tGER_CONDPGTOH) * item_f('NR_PARCELAS', tGER_CONDPGTOH));

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

  reset gformmod;

  return(0); exit;
end;

//------------------------------------------------------
function T_TRAFM078.desconto(pParams : String) : String;
//------------------------------------------------------

var
  (* numeric piVlDesconto : IN *)
  viParams, voParams : String;
  vVlDesconto, vVlTotalDesc, vPrTotalDesc, vVlCalc, vVlBonus : Real;
  vVlBrutoTransacao, vVlLiquidoTransacao, vCdUsuario, vVlLiquido : Real;
begin
  vCdUsuario := itemXmlF('CD_USUARIO', PARAM_GLB);
  vVlDesconto := 0;
  vVlLiquido := 0;

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
  vVlBonus := (item_f('VL_BONUSUTIL', tCTC_TRACARTAO) +  item_f('VL_BONUSDESC', tTRA_TRANSACADIC));

  if (gTpCalculoSimularVd = 0) then begin
    vVlCalc := vVlLiquido;
  end else if (gTpCalculoSimularVd = 1) then begin
    vVlCalc := vVlLiquido + vVlDesconto;
    putitemXml(viParams, 'VL_BONUS', vVlBonus);

  end else if (gTpCalculoSimularVd = 2) then begin
    vVlCalc := vVlLiquido + vVlDesconto;
    putitemXml(viParams, 'VL_BONUS', vVlBonus);

  end else if (gTpCalculoSimularVd = 3) then begin
    vVlCalc := vVlLiquido;
  end;

  putitemXml(viParams, 'VL_BASEDESC', vVlCalc);
  putitemXml(viParams, 'IN_ARREDONDA_PRECO', False);
  putitemXml(viParams, 'CD_OPERACAO', item_f('CD_OPERACAO', tTRA_TRANSACAO));
  putitemXml(viParams, 'CD_PESSOA', item_f('CD_PESSOA', tTRA_TRANSACAO));

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
    vVlLiquidoTransacao := item_f('VL_TRANSACAO', tTRA_TRANSACAO) + (item_f('VL_BONUSUTIL', tCTC_TRACARTAO) + item_f('VL_BONUSDESC', tTRA_TRANSACADIC)) - vVlTotalDesc;
    vVlCalc := (vVlBrutoTransacao - vVlLiquidoTransacao) / vVlBrutoTransacao * 100;
    vVlCalc := roundto(vVlCalc, 6);
    if (vVlCalc > item_f('PR_DESCMAX', tTRA_LIMDESCONTO)) then begin
      Result := SetStatus(STS_ERROR, 'GEN0001', 'Perc. de desconto na transação de ' + FloatToStr(vVlCalc) + ' maior que o máximo permitido de ' + PR_DESCMAX + '.TRA_LIMDESCONTO! Existe desconto nos itens!', '');
      return(-1); exit;
    end;
  end;

  putitem_e(tSIS_DUMMY, 'VL_DESCONTO', vVlTotalDesc);
  putitem_e(tSIS_DUMMY, 'PR_DESCONTO', vPrTotalDesc);

  voParams := recalcula(viParams); (* *)
  if (xStatus < 0) then begin
    Result := voParams;
    return(-1); exit;
  end;

  return(0); exit;
end;

//------------------------------------------------------
function T_TRAFM078.confirma(pParams : String) : String;
//------------------------------------------------------

var
  vVlResto, vPrTotalDesc, vVlCalc, vPrVariacao, vVlMaior, vNrOcc, vVlAbatimento, vVlDesconto : Real;
  vVlBrutoTransacao, vVlLiquidoTransacao, vPrAbatimento, vPrSimulador, vVlLiquido : Real;
  vDsLstTransacao, vDsRegistro, viParams, voParams : String;
begin
  vVlAbatimento := item_f('VL_ADIANTAMENTO', tSIS_DUMMY) + item_f('VL_CREDEV', tSIS_DUMMY) + item_f('VL_ENTRADA', tSIS_DUMMY) + item_f('VL_DESCONTO', tSIS_DUMMY) + item_f('VL_ABATIMENTO', tSIS_ABATIMENTO);
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

  vVlResto := item_f('VL_DESCONTO', tSIS_DUMMY) + item_f('VL_BONUSUTIL', tCTC_TRACARTAO) + item_f('VL_ABATIMENTO', tSIS_ABATIMENTO) + item_f('VL_BONUSDESC', tTRA_TRANSACADIC);

  if (item_f('VL_DESCONTO', tSIS_DUMMY) > 0)  or (item_f('VL_ABATIMENTO', tSIS_ABATIMENTO) > 0) then begin
    vVlBrutoTransacao := item_f('VL_TRANSACAO', tTRA_TRANSACAO) + item_f('VL_DESCONTO', tTRA_TRANSACAO);
    vPrTotalDesc := (((item_f('VL_DESCONTO', tSIS_DUMMY) + item_f('VL_ABATIMENTO', tSIS_ABATIMENTO)) / vVlBrutoTransacao) * 100);
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

  vVlLiquido := item_f('VL_TRANSACAO', tTRA_TRANSACAO) - (item_f('VL_ENTRADA', tSIS_DUMMY) + item_f('VL_ADIANTAMENTO', tSIS_DUMMY) + item_f('VL_CREDEV', tSIS_DUMMY) + item_f('VL_DESCONTO', tSIS_DUMMY) + item_f('VL_ABATIMENTO', tSIS_ABATIMENTO));
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

//----------------------------------------------------------------
function T_TRAFM078.sugereValorEntrada(pParams : String) : String;
//----------------------------------------------------------------

var
  vNrEscore, vNrInicial, vNrFinal, vPrEntrada : Real;
  vInPrimeiraCompra : Boolean;
  vDsLstPrEscoreEntrada4 : String;
begin
  if (gInUsaCalculoLimite4) then begin
    show;
    if (gprEscoreEntrada4 = 0) then begin
      message/error 'Parâmetro IN_USA_CALCULO_LIMITE4 setado e parâmetro PR_ESCORE_ENTRADA_4 sem valor setado, verifique!';
      return(-1); exit;
    end;

    clear_e(tPES_PESFISICA);
    putitem_e(tPES_PESFISICA, 'CD_PESSOA', item_f('CD_PESSOA', tTRA_TRANSACAO));
    retrieve_e(tPES_PESFISICA);

    vNrEscore := 0;
    vInPrimeiraCompra := True;
    clear_e(tF_TRA_TRANSACAO);
    putitem_e(tF_TRA_TRANSACAO, 'CD_PESSOA', item_f('CD_PESSOA', tTRA_TRANSACAO));
    putitem_e(tF_TRA_TRANSACAO, 'TP_SITUACAO', 4);
    retrieve_e(tF_TRA_TRANSACAO);
    if (xStatus >= 0) then begin
      setocc(tF_TRA_TRANSACAO, 1);
      while(xStatus >= 0)  and (vInPrimeiraCompra) do begin
        clear_e(tF_GER_OPERACAO);
        putitem_e(tF_GER_OPERACAO, 'CD_OPERACAO', item_f('CD_OPERACAO', tF_TRA_TRANSACAO));
        retrieve_e(tF_GER_OPERACAO);
        if (xStatus >= 0) then begin
          if (item_f('NR_TRANSACAO', tF_TRA_TRANSACAO) <> item_f('NR_TRANSACAO', tTRA_TRANSACAO))  and (item_f('TP_MODALIDADE', tF_GER_OPERACAO) = 4)  and (item_f('TP_OPERACAO', tF_TRA_TRANSACAO) = 'S') then begin
            vInPrimeiraCompra := False;
          end;
        end;

        setocc(tF_TRA_TRANSACAO, curocc(tF_TRA_TRANSACAO) + 1);
      end;
    end;
    if (vInPrimeiraCompra) then begin
      vDsLstPrEscoreEntrada4 := greplace(prEscoreEntrada4g, 1, ';

      if (item_f('NR_ESCORE', tPES_PFADIC) > 0) then begin
        vNrEscore := item_f('NR_ESCORE', tPES_PFADIC);
      end else begin
        message/info 'Escore não informado. Será utilizado o Escore zero.';
        vNrEscore := 0;
      end;

      gVlEntrada := 0;
      repeat

        getitem(vNrInicial, vDsLstPrEscoreEntrada4, 1);
        delitem(vDsLstPrEscoreEntrada4, 1);
        getitem(vNrFinal, vDsLstPrEscoreEntrada4, 1);
        delitem(vDsLstPrEscoreEntrada4, 1);
        getitem(vPrEntrada, vDsLstPrEscoreEntrada4, 1);
        delitem(vDsLstPrEscoreEntrada4, 1);

        if (vNrInicial = '') then begin
          message/info 'Valor inicial para parâmetro PR_ESCORE_ENTRADA_4 não cadastrado!';
          return(-1); exit;
        end;
        if (vNrFinal = '') then begin
          message/info 'Valor final para parâmetro PR_ESCORE_ENTRADA_4 não cadastrado!';
          return(-1); exit;
        end;
        if (vPrEntrada = '') then begin
          message/info 'Valor percentual para parâmetro PR_ESCORE_ENTRADA_4 não cadastrado!';
          return(-1); exit;
        end;
        if (vNrEscore >= vNrInicial)  and (vNrEscore <= vNrFinal) then begin
          if (vPrEntrada > 0) then begin
            gVlEntrada := (item_f('VL_TRANSACAO', tTRA_TRANSACAO) * (vPrEntrada / 100));
          end;
          vDsLstPrEscoreEntrada4 := '';
        end;

      until(vDsLstPrEscoreEntrada4 = '');

      gVlEntrada := roundto(gVlEntrada, 2);
      putitem_e(tSIS_DUMMY, 'VL_ENTRADA', gVlEntrada);
    end;
  end;

  return(0); exit;
end;

//---------------------------------------------------------
function T_TRAFM078.validaSenha(pParams : String) : String;
//---------------------------------------------------------

var
  viParams, voParams : String;
begin
  viParams := '';
  voParams := activateCmp('ADMFM020', 'EXEC', viParams); (*viParams,voParams,, *)
  if (xStatus < 0) then begin
    Result := voParams;
    return(-1); exit;
  end;

  return(0); exit;
end;

//--------------------------------------------------------------------
function T_TRAFM078.validaRestricaoUsuario(pParams : String) : String;
//--------------------------------------------------------------------

var
  (* string psParametro : IN / string psAcao : IN / string psComponente : IN *)
  viParams, voParams : String;
begin
  viParams := '';
  putitemXml(viParams, 'CD_COMPONENTE', TRAFM078);
  putitemXml(viParams, 'DS_CAMPO', '' + psParametro') + ';
  putitemXml(viParams, 'CD_EMPRESA', itemXmlF('CD_EMPRESA', PARAM_GLB));
  putitemXml(viParams, 'CD_USUARIO', itemXmlF('CD_USUARIO', PARAM_GLB));
  voParams := activateCmp('ADMSVCO009', 'verificaRestricao', viParams); (*viParams,voParams,, *)
  if (xStatus < 0) then begin
    Result := voParams;
    return(-1); exit;
  end;
  return(0); exit;
end;

end.