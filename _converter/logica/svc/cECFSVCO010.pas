unit cECFSVCO010;

interface

(* COMPONENTES 
  ADMSVCO001 / ECFSVCO001 / ECFSVCO011 / ECFSVCO012 / FISSVCO004
  GERFP008 / GERSVCO020 / GERSVCO032 / PESSVCO005 / SICSVCO009
  TRASVCO016 / 
*)        

uses
  Classes, SysUtils, DB,
  cServiceUnf, cDataSetUnf;

type
  T_ECFSVCO010 = class(TcServiceUnf)
  private
    tFIS_ECF,
    tFIS_ECFADIC,
    tFIS_NF,
    tFIS_NFITEM,
    tFIS_NFITEMIMP,
    tFIS_NFITEMPRO,
    tGER_OPERACAO,
    tPES_PESSOA,
    tPRD_CODIGOBAR,
    tPRD_PRODUTO,
    tTEF_RELTRANSA,
    tTEF_TRANSACAO,
    tTRA_ITEMIMPOS,
    tTRA_REMDES,
    tTRA_TRANSACAO,
    tTRA_TRANSITEM : TcDatasetUnf;
    function getParam(pParams : String = '') : String;
    function setEntidade(pParams : String = '') : String;
  protected
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;    
  published
    function buscaTipoRegime(pParams : String = '') : String;
    function preencheZero(pParams : String = '') : String;
    function verificaQtdTransacaoTEF(pParams : String = '') : String;
    function iniciaCupom(pParams : String = '') : String;
    function lancaItemConcomitante(pParams : String = '') : String;
    function lancaItemCupom(pParams : String = '') : String;
    function encerraCupom(pParams : String = '') : String;
    function geraCupomVinculado(pParams : String = '') : String;
    function reimpressaoCupomVinculado(pParams : String = '') : String;
    function imprimeCupomVinculado(pParams : String = '') : String;
    function cancelaItem(pParams : String = '') : String;
    function validaImpressoraFiscal(pParams : String = '') : String;
  end;

implementation

uses
  cADMSVCO001,
  cActivate, cStatus, cFuncao, cXml, dModulo;

var
  g %%,
  gCdClientePdv,
  gCdMmodTraEcfCartaoProp,
  gCdModTraEcfReciboBonus,
  gCdModTraObsEcfCarne,
  gDsCupom,
  gHrFim,
  gHrInicio,
  gHrTempo,
  gInCarne,
  gInImpObsECFCliVista,
  gInOptSimples,
  gInPdvOtimizado,
  gInPerguntaImpCarneEcf,
  gNrCupom,
  gNrEspacoCupom,
  gNrNivelImp,
  gNrNivelImpPgto,
  gNrViasEcfTermica,
  gPadraoEcf,
  gTpCodigoItemEcf,
  gTpDescricaoItemEcf,
  gTpImpTefPAYGO,
  gTpRegime,
  gvDtVencto,
  gvInConcomitante,
  gVlFatura : String;

//---------------------------------------------------------------
constructor T_ECFSVCO010.Create(AOwner: TComponent);
//---------------------------------------------------------------
begin
  inherited Create(AOwner);
  setEntidade('');
end;

//--------------------------------
destructor T_ECFSVCO010.Destroy;
//--------------------------------
begin
  inherited Destroy;
end;

//---------------------------------------------------------------
function T_ECFSVCO010.getParam(pParams : String = '') : String;
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
  putitem(xParam, 'CD_EMPVALOR');
  putitem(xParam, 'CD_MOTIVO_ALTVALOR_CMP');
  putitem(xParam, 'CLIENTE_PDV');

  xParam := T_ADMSVCO001.GetParametro(xParam);

  gCdClientePdv := itemXml('CLIENTE_PDV', xParam);
  gCdMmodTraEcfCartaoProp := itemXml('CD_MODTRA_ECF_CARTAOPROP', xParam);
  gCdModTraEcfReciboBonus := itemXml('CD_MODTRA_ECF_RECIBOBONUS', xParam);
  gCdModTraObsEcfCarne := itemXml('CD_MODTRA_OBS_ECF_CARNE', xParam);
  gInCarne := itemXml('IN_ECF_CARNE', xParam);
  gInImpObsECFCliVista := itemXml('IN_IMP_OBS_ECF_CLI_VISTA', xParam);
  gInPdvOtimizado := itemXml('IN_PDV_OTIMIZADO', xParam);
  gInPerguntaImpCarneEcf := itemXml('IN_PERGUNTA_IMP_CARNE_ECF', xParam);
  gNrEspacoCupom := itemXml('TEF_ESPACO_ENTRE_CUPOM', xParam);
  gNrViasEcfTermica := itemXml('NR_VIAS_ECF_TERMICA', xParam);
  gPadraoEcf := itemXml('PADRAO_ECF', xParam);
  gTpCodigoItemEcf := itemXml('TP_CODIGO_ITEM_ECF', xParam);
  gTpDescricaoItemEcf := itemXml('TP_DESCRICAO_ITEM_ECF', xParam);
  gTpImpTefPAYGO := itemXml('TP_IMPRESSAO_TEF_PAYGO', xParam);

  xParamEmp := '';
  putitem(xParamEmp, 'CD_EMPVALOR');
  putitem(xParamEmp, 'CD_MODTRA_ECF_CARTAOPROP');
  putitem(xParamEmp, 'CD_MODTRA_ECF_RECIBOBONUS');
  putitem(xParamEmp, 'CD_MODTRA_OBS_ECF_CARNE');
  putitem(xParamEmp, 'CD_MOTIVO_ALTVALOR_CMP');
  putitem(xParamEmp, 'CLIENTE_PDV');
  putitem(xParamEmp, 'IN_ECF_CARNE');
  putitem(xParamEmp, 'IN_IMP_OBS_ECF_CLI_VISTA');
  putitem(xParamEmp, 'IN_OPT_SIMPLES');
  putitem(xParamEmp, 'IN_PDV_OTIMIZADO');
  putitem(xParamEmp, 'IN_PERGUNTA_IMP_CARNE_ECF');
  putitem(xParamEmp, 'NR_VIAS_ECF_TERMICA');
  putitem(xParamEmp, 'PADRAO_ECF');
  putitem(xParamEmp, 'TEF_ESPACO_ENTRE_CUPOM');
  putitem(xParamEmp, 'TP_CODIGO_ITEM_ECF');
  putitem(xParamEmp, 'TP_DESCRICAO_ITEM_ECF');
  putitem(xParamEmp, 'TP_IMPRESSAO_TEF_PAYGO');

  xParamEmp := T_ADMSVCO001.GetParamEmpresa(piCdEmpresa, xParamEmp);

  gCdMmodTraEcfCartaoProp := itemXml('CD_MODTRA_ECF_CARTAOPROP', xParamEmp);
  gCdModTraEcfReciboBonus := itemXml('CD_MODTRA_ECF_RECIBOBONUS', xParamEmp);
  gCdModTraObsEcfCarne := itemXml('CD_MODTRA_OBS_ECF_CARNE', xParamEmp);
  gInCarne := itemXml('IN_ECF_CARNE', xParamEmp);
  gInImpObsECFCliVista := itemXml('IN_IMP_OBS_ECF_CLI_VISTA', xParamEmp);
  gInPdvOtimizado := itemXml('IN_PDV_OTIMIZADO', xParamEmp);
  gInPerguntaImpCarneEcf := itemXml('IN_PERGUNTA_IMP_CARNE_ECF', xParamEmp);
  gNrEspacoCupom := itemXml('TEF_ESPACO_ENTRE_CUPOM', xParamEmp);
  gNrViasEcfTermica := itemXml('NR_VIAS_ECF_TERMICA', xParamEmp);
  gPadraoEcf := itemXml('PADRAO_ECF', xParamEmp);
  gTpCodigoItemEcf := itemXml('TP_CODIGO_ITEM_ECF', xParamEmp);
  gTpDescricaoItemEcf := itemXml('TP_DESCRICAO_ITEM_ECF', xParamEmp);
  gTpImpTefPAYGO := itemXml('TP_IMPRESSAO_TEF_PAYGO', xParamEmp);

end;

//---------------------------------------------------------------
function T_ECFSVCO010.setEntidade(pParams : String = '') : String;
//---------------------------------------------------------------
begin
  tFIS_ECF := GetEntidade('FIS_ECF');
  tFIS_ECFADIC := GetEntidade('FIS_ECFADIC');
  tFIS_NF := GetEntidade('FIS_NF');
  tFIS_NFITEM := GetEntidade('FIS_NFITEM');
  tFIS_NFITEMIMP := GetEntidade('FIS_NFITEMIMP');
  tFIS_NFITEMPRO := GetEntidade('FIS_NFITEMPRO');
  tGER_OPERACAO := GetEntidade('GER_OPERACAO');
  tPES_PESSOA := GetEntidade('PES_PESSOA');
  tPRD_CODIGOBAR := GetEntidade('PRD_CODIGOBAR');
  tPRD_PRODUTO := GetEntidade('PRD_PRODUTO');
  tTEF_RELTRANSA := GetEntidade('TEF_RELTRANSA');
  tTEF_TRANSACAO := GetEntidade('TEF_TRANSACAO');
  tTRA_ITEMIMPOS := GetEntidade('TRA_ITEMIMPOS');
  tTRA_REMDES := GetEntidade('TRA_REMDES');
  tTRA_TRANSACAO := GetEntidade('TRA_TRANSACAO');
  tTRA_TRANSITEM := GetEntidade('TRA_TRANSITEM');
end;

//---------------------------------------------------------------
function T_ECFSVCO010.buscaTipoRegime(pParams : String) : String;
//---------------------------------------------------------------
const
  cDS_METHOD = 'ADICIONAL=Operação: T_ECFSVCO010.buscaTipoRegime()';
var
  (* string piCdCST : IN *)
  vCdCST : String;
begin
  vCdCST := piCdCST[2 : 2];
  if (vCdCST = '00') then begin
    gTpRegime := 2;
  end else if (vCdCST = '10') then begin
    gTpRegime := 1;
  end else if (vCdCST = '20') then begin
    gTpRegime := 2;
  end else if (vCdCST = '30') then begin
    gTpRegime := 6;
  end else if (vCdCST = '40') then begin
    gTpRegime := 4;
  end else if (vCdCST = '41') then begin
    gTpRegime := 5;
  end else if (vCdCST = '50') then begin
    gTpRegime := 3;
  end else if (vCdCST = '51') then begin
    gTpRegime := 3;
  end else if (vCdCST = '60') then begin
    gTpRegime := 6;
  end else if (vCdCST = '70') then begin
    gTpRegime := 6;
  end else if (vCdCST = '90') then begin
    gTpRegime := 3;
  end else begin
    gTpRegime := 2;
  end;

  return(0); exit;
end;

//------------------------------------------------------------
function T_ECFSVCO010.preencheZero(pParams : String) : String;
//------------------------------------------------------------
const
  cDS_METHOD = 'ADICIONAL=Operação: T_ECFSVCO010.preencheZero()';
begin
  poNumero := piNumero;
  length(poNumero);
  while (gresult < piTamanho) do begin
    poNumero := '0' + poNumero' + ';
    length(poNumero);
  end;
  if (gresult > piTamanho) then begin
    poNumero := poNumero[gresult - piTamanho + 1];
  end;

  return(0); exit;
end;

//-----------------------------------------------------------------------
function T_ECFSVCO010.verificaQtdTransacaoTEF(pParams : String) : String;
//-----------------------------------------------------------------------
const
  cDS_METHOD = 'ADICIONAL=Operação: T_ECFSVCO010.verificaQtdTransacaoTEF()';
begin
  clear_e(tTEF_RELTRANSA);
  putitem_e(tTEF_RELTRANSA, 'CD_EMPTRA', piCdEMPTRA);
  putitem_e(tTEF_RELTRANSA, 'NR_TRANSACAO', piNrTransacao);
  putitem_e(tTEF_RELTRANSA, 'DT_TRANSACAO', piDtTransacao);
  retrieve_e(tTEF_RELTRANSA);
  if (xStatus >= 0) then begin
    poQtdTransacao := ghits('TEF_RELTRANSASVC');
  end else begin
    poQtdTransacao := 0;
  end;

  return(0); exit;
end;

//-----------------------------------------------------------
function T_ECFSVCO010.iniciaCupom(pParams : String) : String;
//-----------------------------------------------------------
const
  cDS_METHOD = 'ADICIONAL=Operação: T_ECFSVCO010.iniciaCupom()';
var
  viParams, voParams : String;
  vDsSerie, vInAberto, vInPermiteCancelar, vDsCupom, DsProduto, vUfOrigem : String;
  vNrTransacao, vCdEmpTra, vNrCupom, vCdEmpLogin, vCdCCusto, vCdPessoa : Real;
  vDtTransacao : TDate;
  vInPjIsento, vInContribuinte, vInGravaRelacao : Boolean;
  vStatus : Real;
begin
  vUfOrigem := itemXml('UF_ORIGEM', PARAM_GLB);
  vInGravaRelacao := itemXmlB('IN_GRAVARELACAO', pParams);

  if (itemXml('IN_LOG_TEMPO_VendA', PARAM_GLB) = 1) then begin
    gHrInicio := gclock;
    putmess 'ECFSVCO010: iniciaCupom - Inicio: ' + gHrInicio' + ';
  end;

  getParams(pParams); (*  *)
  if (xStatus < 0) then begin
    return(-1); exit;
  end;

  vCdEmpLogin := itemXmlF('CD_EMPRESA', PARAM_GLB);
  if (vCdEmpLogin = 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Empresa de login não informada!', cDS_METHOD);
    return(-1); exit;
  end;

  vCdEmpTra := itemXmlF('CD_EMPRESA', pParams);
  if (vCdEmpTra = 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Empresa da transação não informada!', cDS_METHOD);
    return(-1); exit;
  end;

  vNrTransacao := itemXmlF('NR_TRANSACAO', pParams);
  if (vNrTransacao = 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Numero da transação não informado!', cDS_METHOD);
    return(-1); exit;
  end;

  vDtTransacao := itemXml('DT_TRANSACAO', pParams);
  if (vDtTransacao = 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Data da transação não informada!', cDS_METHOD);
    return(-1); exit;
  end;

  clear_e(tTRA_TRANSACAO);
  putitem_e(tTRA_TRANSACAO, 'CD_EMPRESA', vCdEmpTra);
  putitem_e(tTRA_TRANSACAO, 'NR_TRANSACAO', vNrTransacao);
  putitem_e(tTRA_TRANSACAO, 'DT_TRANSACAO', vDtTransacao);
  retrieve_e(tTRA_TRANSACAO);
  if (xStatus < 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Transação ' + FloatToStr(vNrTransacao) + ' não encontrada!', cDS_METHOD);
    return(-1); exit;
  end;
  if (item_f('TP_DOCTO', tGER_OPERACAO) = 3) then begin
    gvInConcomitante := True;
  end else begin
    gvInConcomitante := False;
  end;
  if (gvInConcomitante = False) then begin
    clear_e(tFIS_NF);
    putitem_e(tFIS_NF, 'CD_EMPRESAORI', vCdEmpTra);
    putitem_e(tFIS_NF, 'NR_TRANSACAOORI', vNrTransacao);
    putitem_e(tFIS_NF, 'DT_TRANSACAOORI', vDtTransacao);
    retrieve_e(tFIS_NF);
    if (xStatus < 0) then begin
      Result := SetStatus(STS_ERROR, 'GEN0001', 'Nota Fiscal não encontrada para a transação ' + FloatToStr(vNrTransacao) + '!', cDS_METHOD);
      return(-1); exit;
    end;

    setocc(tFIS_NF, -1);
    if (totocc (FIS_NF) > 1) then begin
      Result := SetStatus(STS_ERROR, 'GEN0001', 'Existe mais de uma nota para essa transação!', cDS_METHOD);
      return(-1); exit;
    end;
  end;

  viParams := '';
  putitemXml(viParams, 'CD_EMPRESA', item_f('CD_EMPFAT', tTRA_TRANSACAO));
  voParams := activateCmp('SICSVCO009', 'validaCentroCusto', viParams); (*,,,, *)
  if (xStatus < 0) then begin
    Result := voParams;
    return(-1); exit;
  end;

  vCdCCusto := itemXmlF('CD_CENTROCUSTO', voParams);

  if (item_f('CD_EMPFAT', tTRA_TRANSACAO) = vCdCCusto) then begin
    if (gPadraoEcf = <PADRAO_LOCALIMPFIM>) then begin
      if (gInPdvOtimizado <> True) then begin
        viParams := '';
        voParams := activateCmp('ECFSVCO001', 'abreGaveta', viParams); (*,,, *)
        if (xStatus < 0) then begin
          Result := voParams;
          return(-1); exit;
        end;
      end;
    end;
    return(0); exit;
  end;

  vInAberto := '';
  vInPermiteCancelar := '';
  viParams := '';
  if (gPadraoEcf = <PADRAO_AFRAC>) then begin
    voParams := activateCmp('ECFSVCO001', 'abrePorta', viParams); (*,,, *)
    if (xStatus < 0) then begin
      Result := voParams;
      return(-1); exit;
    end;
  end;
  if (itemXml('IN_LOG_TEMPO_VendA', PARAM_GLB) = 1) then begin
    gHrInicio := gclock;
    putmess 'ECFSVCO010: iniciaCupom - Inicio verificaEstado: ' + gHrInicio' + ';
  end;
  if (itemXml('IN_LOG_TEMPO_VendA', PARAM_GLB) = 1) then begin
    gHrFim := gclock;
    putmess 'ECFSVCO010: iniciaCupom - Fim verificaEstado: ' + gHrFim' + ';
  end;
  if (itemXml('IN_LOG_TEMPO_VendA', PARAM_GLB) = 1) then begin
    gHrInicio := gclock;
    putmess 'ECFSVCO010: iniciaCupom - Inicio abreCupom: ' + gHrInicio' + ';
  end;
  if (gPadraoEcf = <PADRAO_BEMATECH>) then begin
    viParams := '';

    putitemXml(viParams, 'IN_ATIVA', False);
    voParams := activateCmp('ECFSVCO001', 'ativaDesativaGuilhotina', viParams); (*,,, *)
    if (xStatus < 0) then begin
      Result := voParams;
      return(-1); exit;
    end;
  end;
  if (item_f('CD_PESSOA', tTRA_REMDES) <> '') then begin
    vCdPessoa := item_f('CD_PESSOA', tTRA_REMDES);
  end else begin
    vCdPessoa := item_f('CD_PESSOA', tTRA_TRANSACAO);
  end;

  viParams := '';

  putitemXml(viParams, 'CD_PESSOA', vCdPessoa);
  voParams := activateCmp('PESSVCO005', 'buscaDadosPessoa', viParams); (*,,,, *)
  if (xStatus < 0) then begin
    Result := voParams;
    return(-1); exit;
  end;
    if (item_f('NR_CPFCNPJ', tTRA_REMDES) <> '') then begin
    putitemXml(viParams, 'NR_CPFCNPJ', item_f('NR_CPFCNPJ', tTRA_REMDES));
  end else begin
    putitemXml(viParams, 'NR_CPFCNPJ', itemXmlF('NR_CPFCNPJ', voParams));
  end;

  vInPjIsento := False;
  if (itemXml('NR_INSCESTL', voParams) = 'ISENTO')   or (itemXml('NR_INSCESTL', voParams) = 'ISENTA')  or %\ then begin
    (itemXml('NR_INSCESTL', voParams) := 'ISENTOS')  or (itemXml('NR_INSCESTL', voParams) := 'ISENTAS');
    vInPjIsento := True;
  end;
  if (itemXml('IN_CNSRFINAL', voParams) = True)  or (itemXml('TP_PESSOA', voParams) = 'F')  or (vInPjIsento = True) then begin
    if (itemXml('TP_PESSOA', voParams) = 'F')  and (itemXml('NR_CODIGOFISCAL', voParams) <> '')  and (vUfOrigem = 'PR' ) or (vUfOrigem = 'SP') then begin
      vInContribuinte := True;
    end else begin
      vInContribuinte := False;
    end;
  end else begin
    vInContribuinte := True;
  end;
  if (item_f('TP_DOCTO', tGER_OPERACAO) = 2 ) or (item_f('TP_DOCTO', tGER_OPERACAO) = 3) then begin
    if (vInContribuinte = True)  and (itemXml('IN_CNSRFINAL', voParams)  <> True) then begin
      Result := SetStatus(STS_ERROR, 'GEN0001', 'Emissão de cupom fiscal para contribuinte não é permitido. Favor emitir Nota Fiscal!', cDS_METHOD);
      return(-1); exit;
    end;
  end;

  putitemXml(viParams, 'IN_CONCOMITANTE', gvInConcomitante);
  voParams := activateCmp('ECFSVCO001', 'AbreCupom', viParams); (*,,, *)
  if (xStatus < 0) then begin
    Result := voParams;
    return(-1); exit;
  end;

  vDsCupom := itemXml('DS_CUPOM', voParams);
  gDsCupom := '' + gDsCupom' + vDsCupom' + ' + ';
  vNrCupom := itemXmlF('NR_CUPOM', voParams);

  if (gvInConcomitante = True) then begin
    if (vNrCupom = '') then begin
      viParams := '';

      putitemXml(viParams, 'NM_FUNCAO', <ECF_NUMERO_CUPOM>);
      voParams := activateCmp('ECFSVCO001', 'leInformacaoImpressora', viParams); (*,,, *)
      if (xStatus < 0) then begin
        Result := voParams;
        return(-1); exit;
      end;
      vNrCupom := itemXmlF('NR_CUPOM', voParams);
    end;
    if (vNrCupom = '') then begin
      Result := SetStatus(STS_ERROR, 'GEN0001', 'Não foi possível obter o número do cupom fiscal!', cDS_METHOD);
      return(-1); exit;
    end;
    if (itemXml('CD_SERIEECF', PARAM_GLB) = '') then begin
      if (itemXml('IN_LOG_TEMPO_VendA', PARAM_GLB) = 1) then begin
        gHrInicio := gclock;
        putmess 'ECFSVCO010: iniciaCupom - Inicio leNumeroSerie: ' + gHrInicio' + ';
      end;

      viParams := '';
      putitemXml(viParams, 'NM_FUNCAO', <ECF_NUMERO_SERIE>);
      voParams := activateCmp('ECFSVCO001', 'leInformacaoImpressora', viParams); (*,,, *)
      if (xStatus < 0) then begin
        Result := voParams;
        return(-1); exit;
      end;
      vDsSerie := itemXmlF('NR_SERIE', voParams);
      putitemXml(PARAM_GLB, 'CD_SERIEECF', vDsSerie);

      if (itemXml('IN_LOG_TEMPO_VendA', PARAM_GLB) = 1) then begin
        gHrFim := gclock;
        putmess 'ECFSVCO010: iniciaCupom - Fim leNumeroSerie: ' + gHrFim' + ';
      end;
    end else begin
      vDsSerie := itemXmlF('CD_SERIEECF', PARAM_GLB);
    end;
    if (vDsSerie = '') then begin
      Result := SetStatus(STS_ERROR, 'GEN0001', 'Não foi possível obter o nr. de série da impressora!', cDS_METHOD);
      return(-1); exit;
    end;

    viParams := '';
    putitemXml(viParams, 'NR_SERIE', vDsSerie);
    voParams := validaImpressoraFiscal(viParams); (* PARAM_GLB, viParams, voParams, xCdErro, xCtxErro *)
    if (xStatus < 0) then begin
      Result := voParams;
      return(-1); exit;
    end;
  end;
  if (gvInConcomitante = True) then begin
    viParams := '';
    putitemXml(viParams, 'CD_EMPRESA', item_f('CD_EMPRESA', tTRA_TRANSACAO));
    putitemXml(viParams, 'NR_TRANSACAO', item_f('NR_TRANSACAO', tTRA_TRANSACAO));
    putitemXml(viParams, 'DT_TRANSACAO', item_a('DT_TRANSACAO', tTRA_TRANSACAO));
    putitemXml(viParams, 'CD_EMPECF', item_f('CD_EMPRESA', tFIS_ECF));
    putitemXml(viParams, 'NR_ECF', item_f('NR_ECF', tFIS_ECF));
    putitemXml(viParams, 'NR_CUPOM', vNrCupom);
    putitemXml(viParams, 'IN_GRAVARELACAO', vInGravaRelacao);
    if (vInGravaRelacao = True) then begin
      newinstance 'TRASVCO016', 'TRASVCO016X', 'TRANSACTION=TRUE';
      voParams := activateCmp('TRASVCO016X', 'gravaECFTransacao', viParams); (*,,,, *)
      if (xStatus < 0) then begin
        Result := voParams;
        return(-1); exit;
      end;
      deleteinstance 'TRASVCO016X';
    end else begin
      voParams := activateCmp('TRASVCO016', 'gravaECFTransacao', viParams); (*,,,, *)
      if (xStatus < 0) then begin
        Result := voParams;
        return(-1); exit;
      end;
    end;
  end;
  if (itemXml('IN_LOG_TEMPO_VendA', PARAM_GLB) = 1) then begin
    gHrFim := gclock;
    putmess 'ECFSVCO010: iniciaCupom -  Fim Abre Cupom: ' + gHrFim' + ';
  end;
    if (itemXml('IN_LOG_TEMPO_VendA', PARAM_GLB) = 1) then begin
      gHrInicio := gclock;
      putmess 'ECFSVCO010: iniciaCupom - Inicio LeNumeroCupom: ' + gHrInicio' + ';
    end;
    if (itemXml('IN_LOG_TEMPO_VendA', PARAM_GLB) = 1) then begin
      gHrFim := gclock;
      putmess 'ECFSVCO010: iniciaCupom - Fim leNumeroCupom: ' + gHrFim' + ';
    end;
  if (gPadraoEcf <> <PADRAO_LOCALIMPFIM> ) or (gvInConcomitante = True) then begin
    if (vNrCupom = 0) then begin
      vNrCupom := itemXmlF('NR_CUPOM', voParams);
    end;
    if (vNrCupom = 0) then begin
      Result := SetStatus(STS_ERROR, 'GEN0001', 'Não foi possível obter o nr. do cupom fiscal!', cDS_METHOD);
      return(-1); exit;
    end;
    gNrCupom := vNrCupom;
  end;

  Result := '';
  putitemXml(Result, 'CD_EMPECF', item_f('CD_EMPRESA', tFIS_ECF));
  putitemXml(Result, 'NR_ECF', item_f('NR_ECF', tFIS_ECF));
  putitemXml(Result, 'NR_CUPOM', vNrCupom);

  if (itemXml('IN_LOG_TEMPO_VendA', PARAM_GLB) = 1) then begin
    gHrFim := gclock;
    putmess 'ECFSVCO010: iniciaCupom - Fim Inicia Cupom: ' + gHrFim' + ';
  end;

  return(0); exit;
end;

//---------------------------------------------------------------------
function T_ECFSVCO010.lancaItemConcomitante(pParams : String) : String;
//---------------------------------------------------------------------
const
  cDS_METHOD = 'ADICIONAL=Operação: T_ECFSVCO010.lancaItemConcomitante()';
var
  viParams, voParams, vCdProduto : String;
  vInAberto, vDsSerie, vCdCodigoBarra, vDsProduto, vCdCST : String;
  vNrTransacao, vCdEmpTra, vCdEmpLogin, vCdCCusto, vNrItem : Real;
  vDtTransacao : TDate;
  vStatus, vCdCompVend : Real;
begin
  getParams(pParams); (*  *)
  if (xStatus < 0) then begin
    return(-1); exit;
  end;

  vCdEmpLogin := itemXmlF('CD_EMPRESA', PARAM_GLB);
  if (vCdEmpLogin = 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Empresa de login não informada!', cDS_METHOD);
    return(-1); exit;
  end;

  vCdEmpTra := itemXmlF('CD_EMPRESA', pParams);
  if (vCdEmpTra = 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Empresa da transação não informada!', cDS_METHOD);
    return(-1); exit;
  end;

  vNrTransacao := itemXmlF('NR_TRANSACAO', pParams);
  if (vNrTransacao = 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Numero da transação não informado!', cDS_METHOD);
    return(-1); exit;
  end;

  vDtTransacao := itemXml('DT_TRANSACAO', pParams);
  if (vDtTransacao = 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Data da transação não informada!', cDS_METHOD);
    return(-1); exit;
  end;

  vNritem := itemXmlF('NR_ITEM', pParams);
  if (vDtTransacao = 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Número do item da transação não informado!', cDS_METHOD);
    return(-1); exit;
  end;

  clear_e(tTRA_TRANSACAO);
  putitem_e(tTRA_TRANSACAO, 'CD_EMPRESA', vCdEmpTra);
  putitem_e(tTRA_TRANSACAO, 'NR_TRANSACAO', vNrTransacao);
  putitem_e(tTRA_TRANSACAO, 'DT_TRANSACAO', vDtTransacao);
  retrieve_e(tTRA_TRANSACAO);
  if (xStatus < 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Transação ' + FloatToStr(vNrTransacao) + ' não encontrada!', cDS_METHOD);
    return(-1); exit;
  end;

  clear_e(tTRA_TRANSITEM);
  putitem_e(tTRA_TRANSITEM, 'NR_ITEM', vNrItem);
  retrieve_e(tTRA_TRANSITEM);
  if (xStatus < 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Item ' + FloatToStr(vNrItem) + ' da transação ' + FloatToStr(vNrTransacao) + ' não encontrada!', cDS_METHOD);
    return(-1); exit;
  end;

  viParams := '';
  putitemXml(viParams, 'CD_EMPRESA', item_f('CD_EMPFAT', tTRA_TRANSACAO));
  voParams := activateCmp('SICSVCO009', 'validaCentroCusto', viParams); (*,,,, *)
  if (xStatus < 0) then begin
    Result := voParams;
    return(-1); exit;
  end;

  vCdCCusto := itemXmlF('CD_CENTROCUSTO', voParams);

  if (item_f('CD_EMPFAT', tTRA_TRANSACAO) = vCdCCusto) then begin
    return(0); exit;
  end;
  if (gPadraoECF = <PADRAO_BEMATECH>) then begin
    vInAberto := '';
    viParams := '';
    voParams := activateCmp('ECFSVCO001', 'verificaEstado', viParams); (*,,, *)
    if (xStatus < 0) then begin
      Result := voParams;
      return(-1); exit;
    end;

    vInAberto := itemXml('INABERTO', voParams);

    if (vInAberto <> 'S') then begin
      Result := SetStatus(STS_ERROR, 'GEN0001', 'Não existe cupom aberto na impressora!', cDS_METHOD);
      return(-1); exit;
    end;

    viParams := '';
    putitemXml(viParams, 'NM_FUNCAO', <ECF_NUMERO_SERIE>);
    voParams := activateCmp('ECFSVCO001', 'leInformacaoImpressora', viParams); (*,,, *)
    if (xStatus < 0) then begin
      Result := voParams;
      return(-1); exit;
    end;
    vDsSerie := itemXmlF('NR_SERIE', voParams);

    viParams := '';
    putitemXml(viParams, 'NR_SERIE', vDsSerie);
    putitemXml(viParams, 'IN_CUPOM', True);
    voParams := validaImpressoraFiscal(viParams); (* PARAM_GLB, viParams, voParams, xCdErro, xCtxErro *)
    if (xStatus < 0) then begin
      Result := voParams;
      return(-1); exit;
    end;
  end;

  vCdCST := item_f('CD_CST', tTRA_TRANSITEM)[2:2];

  if (vCdCST <> '40')  and (vCdCST <> '41')  and (vCdCST <> '60') then begin
    if (item_f('PR_ALIQUOTA', tTRA_ITEMIMPOS) = 0 ) and (!gInOptSimples) then begin
      if (itemXml('UF_ORIGEM', PARAM_GLB) <> 'RO') then begin
        Result := SetStatus(STS_ERROR, 'GEN0001', 'ICMS não calculado para o item ' + CD_PRODUTO + '.FIS_NFITEM da nota ' + NR_FATURA + '.FIS_NF!', cDS_METHOD);
        return(-1); exit;
      end;
    end;
  end;
  if (gInOptSimples)  and (itemXml('UF_ORIGEM', PARAM_GLB) = 'PR') then begin
    putitem_e(tTRA_ITEMIMPOS, 'PR_ALIQUOTA', 0);
  end;

  voParams := buscaTipoRegime(viParams); (* item_f('CD_CST', tTRA_TRANSITEM) *)
  if (xStatus < 0) then begin
    Result := voParams;
    return(-1); exit;
  end;

  clear_e(tPRD_PRODUTO);
  putitem_e(tPRD_PRODUTO, 'CD_PRODUTO', item_f('CD_PRODUTO', tTRA_TRANSITEM));
  retrieve_e(tPRD_PRODUTO);

  viParams := '';

  if (gTpCodigoItemEcf = 1) then begin
    clear_e(tPRD_CODIGOBAR);
    putitem_e(tPRD_CODIGOBAR, 'IN_PADRAO', True);
    retrieve_e(tPRD_CODIGOBAR);
    if (xStatus < 0) then begin
      clear_e(tPRD_CODIGOBAR);
      retrieve_e(tPRD_CODIGOBAR);
      if (xStatus >= 0) then begin
        setocc(tPRD_CODIGOBAR, 1);
        vCdProduto := item_f('CD_BARRAPRD', tPRD_CODIGOBAR);
      end else begin
        vCdProduto := item_f('CD_PRODUTO', tTRA_TRANSITEM);
      end;
    end else begin
      vCdProduto := item_f('CD_BARRAPRD', tPRD_CODIGOBAR);
    end;
  end else begin
    vCdProduto := item_f('CD_PRODUTO', tTRA_TRANSITEM);
  end;

  length vCdProduto;
  if (gresult > 13) then begin
    vCdProduto := vCdProduto[1, 13];
  end;
  putitemXml(viParams, 'CD_PRODUTO', vCdProduto);

  if (gTpDescricaoItemEcf = 1) then begin
    vDsProduto := item_a('DS_PRODUTO', tPRD_PRODUTO)[1:23];
    vCdCompVend := item_f('CD_COMPVEND', tTRA_TRANSITEM);
    vDsProduto := '' + vDsProduto(' + FloatToStr(vCdCompVend' + )' + ') + ' + ' + ' + ';
    putitemXml(viParams, 'DS_PRODUTO', vDsProduto);
  end else begin
    putitemXml(viParams, 'DS_PRODUTO', item_a('DS_PRODUTO', tPRD_PRODUTO));
  end;

  putitemXml(viParams, 'CD_ESPECIE', item_f('CD_ESPECIE', tPRD_PRODUTO));
  putitemXml(viParams, 'QT_SOLICITADA', item_f('QT_SOLICITADA', tTRA_TRANSITEM));
  putitemXml(viParams, 'PR_ALIQICMS', item_f('PR_ALIQUOTA', tTRA_ITEMIMPOS));
  putitemXml(viParams, 'VL_DESCONTO', item_f('VL_TOTALDESC', tTRA_TRANSITEM));
  putitemXml(viParams, 'VL_UNITARIO', item_f('VL_UNITBRUTO', tTRA_TRANSITEM));
  putitemXml(viParams, 'VL_TOTALLIQUIDO', item_f('VL_TOTALBRUTO', tTRA_TRANSITEM));
  putitemXml(viParams, 'CD_ESPECIE', item_f('CD_ESPECIE', tTRA_TRANSITEM));
  putitemXml(viParams, 'TP_REGIMESUB', gTpRegime);
  putitemXml(viParams, 'IN_CONCOMITANTE', True);
  voParams := activateCmp('ECFSVCO001', 'VendeItem', viParams); (*,,, *)
  if (xStatus < 0) then begin
    Result := voParams;
    return(-1); exit;
  end;

  gNrNivelImp := 0;
  gNrNivelImpPgto := 0;
  return(0); exit;
end;

//--------------------------------------------------------------
function T_ECFSVCO010.lancaItemCupom(pParams : String) : String;
//--------------------------------------------------------------
const
  cDS_METHOD = 'ADICIONAL=Operação: T_ECFSVCO010.lancaItemCupom()';
var
  viParams, voParams, vDsCupom, vDsProduto, vCdCST : String;
  vInAberto, vDsSerie : String;
  vNrTransacao, vCdEmpTra, vCdEmpLogin, vCdCCusto, vNrCupom : Real;
  vDtTransacao : TDate;
  vInTEF : Boolean;
  vStatus, vCdCompVend : Real;
begin
  if (itemXml('IN_LOG_TEMPO_VendA', PARAM_GLB) = 1) then begin
    gHrInicio := gclock;
    putmess 'ECFSVCO010: lancaItemCupom - Inicio lancaItemCupom: ' + gHrInicio' + ';
  end;

  getParams(pParams); (*  *)
  if (xStatus < 0) then begin
    return(-1); exit;
  end;

  vCdEmpLogin := itemXmlF('CD_EMPRESA', PARAM_GLB);
  if (vCdEmpLogin = 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Empresa de login não informada!', cDS_METHOD);
    return(-1); exit;
  end;

  vCdEmpTra := itemXmlF('CD_EMPRESA', pParams);
  if (vCdEmpTra = 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Empresa da transação não informada!', cDS_METHOD);
    return(-1); exit;
  end;

  vNrTransacao := itemXmlF('NR_TRANSACAO', pParams);
  if (vNrTransacao = 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Numero da transação não informado!', cDS_METHOD);
    return(-1); exit;
  end;

  vDtTransacao := itemXml('DT_TRANSACAO', pParams);
  if (vDtTransacao = 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Data da transação não informada!', cDS_METHOD);
    return(-1); exit;
  end;

  vInTEF := itemXmlB('IN_TEF', pParams);
  if (vInTEF = '') then begin
    vInTEF := False;
  end;

  clear_e(tTRA_TRANSACAO);
  putitem_e(tTRA_TRANSACAO, 'CD_EMPRESA', vCdEmpTra);
  putitem_e(tTRA_TRANSACAO, 'NR_TRANSACAO', vNrTransacao);
  putitem_e(tTRA_TRANSACAO, 'DT_TRANSACAO', vDtTransacao);
  retrieve_e(tTRA_TRANSACAO);
  if (xStatus < 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Transação ' + FloatToStr(vNrTransacao) + ' não encontrada!', cDS_METHOD);
    return(-1); exit;
  end;

  clear_e(tFIS_NF);
  putitem_e(tFIS_NF, 'CD_EMPRESAORI', vCdEmpTra);
  putitem_e(tFIS_NF, 'NR_TRANSACAOORI', vNrTransacao);
  putitem_e(tFIS_NF, 'DT_TRANSACAOORI', vDtTransacao);
  retrieve_e(tFIS_NF);
  if (xStatus < 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Nota Fiscal não encontrada para a transação ' + FloatToStr(vNrTransacao) + '!', cDS_METHOD);
    return(-1); exit;
  end;

  setocc(tFIS_NF, -1);
  if (totocc (FIS_NF) > 1) then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Existe mais de uma nota para essa transação!', cDS_METHOD);
    return(-1); exit;
  end;

  viParams := '';
  putitemXml(viParams, 'CD_EMPRESA', item_f('CD_EMPFAT', tTRA_TRANSACAO));
  voParams := activateCmp('SICSVCO009', 'validaCentroCusto', viParams); (*,,,, *)
  if (xStatus < 0) then begin
    Result := voParams;
    return(-1); exit;
  end;

  vCdCCusto := itemXmlF('CD_CENTROCUSTO', voParams);

  if (item_f('CD_EMPFAT', tTRA_TRANSACAO) = vCdCCusto) then begin
    return(0); exit;
  end;
  if (itemXml('IN_LOG_TEMPO_VendA', PARAM_GLB) = 1) then begin
    gHrInicio := gclock;
    putmess 'ECFSVCO010: lancaItemCupom - Inicio verificaEstado: ' + gHrInicio' + ';
  end;
  if (gPadraoEcf = <PADRAO_BEMATECH>) then begin
    vInAberto := '';
    viParams := '';
    voParams := activateCmp('ECFSVCO001', 'verificaEstado', viParams); (*,,, *)
    if (xStatus < 0) then begin
      Result := voParams;
      return(-1); exit;
    end;

    vInAberto := itemXml('INABERTO', voParams);

    if (vInAberto <> 'S') then begin
      Result := SetStatus(STS_ERROR, 'GEN0001', 'Não existe cupom aberto na impressora!', cDS_METHOD);
      return(-1); exit;
    end;
  end;
  if (itemXml('IN_LOG_TEMPO_VendA', PARAM_GLB) = 1) then begin
    gHrFim := gclock;

    putmess 'ECFSVCO010: lancaItemCupom - Fim verificaEstado: ' + gHrFim' + ';
  end;

  setocc(tFIS_NFITEM, 1);
  while (xStatus >=0) do begin

    clear_e(tFIS_NFITEMIMP);
    putitem_e(tFIS_NFITEMIMP, 'CD_IMPOSTO', 1);
    retrieve_e(tFIS_NFITEMIMP);
    if (xStatus < 0) then begin
      clear_e(tFIS_NFITEMIMP);
      putitem_e(tFIS_NFITEMIMP, 'CD_IMPOSTO', 2);
      retrieve_e(tFIS_NFITEMIMP);
      if (xStatus < 0) then begin
        Result := SetStatus(STS_ERROR, 'GEN0001', 'Imposto não encontrado para o item ' + CD_PRODUTO + '.FIS_NFITEM da nota ' + NR_FATURA + '.FIS_NF!', cDS_METHOD);
        return(-1); exit;
      end;
    end;

    vCdCST := item_f('CD_CST', tFIS_NFITEM)[2:2];

    if (vCdCST <> '40')  and (vCdCST <> '41')  and (vCdCST <> '60') then begin
      if (item_f('PR_ALIQUOTA', tFIS_NFITEMIMP) = 0 ) and (!gInOptSimples) then begin
        if (itemXml('UF_ORIGEM', PARAM_GLB) <> 'RO') then begin
          Result := SetStatus(STS_ERROR, 'GEN0001', 'ICMS não calculado para o item ' + CD_PRODUTO + '.FIS_NFITEM da nota ' + NR_FATURA + '.FIS_NF!', cDS_METHOD);
          return(-1); exit;
        end;
      end;
    end;
    if (gInOptSimples)  and (itemXml('UF_ORIGEM', PARAM_GLB) = 'PR') then begin
      putitem_e(tFIS_NFITEMIMP, 'PR_ALIQUOTA', 0);
    end;

    voParams := buscaTipoRegime(viParams); (* item_f('CD_CST', tFIS_NFITEM) *)
    if (xStatus < 0) then begin
      Result := voParams;
      return(-1); exit;
    end;

    clear_e(tPRD_PRODUTO);
    putitem_e(tPRD_PRODUTO, 'CD_PRODUTO', item_f('CD_PRODUTO', tFIS_NFITEM));
    retrieve_e(tPRD_PRODUTO);

    clear_e(tFIS_NFITEMPRO);
    putitem_e(tFIS_NFITEMPRO, 'CD_EMPRESA', item_f('CD_EMPRESA', tFIS_NFITEM));
    putitem_e(tFIS_NFITEMPRO, 'NR_FATURA', item_f('NR_FATURA', tFIS_NFITEM));
    putitem_e(tFIS_NFITEMPRO, 'DT_FATURA', item_a('DT_FATURA', tFIS_NFITEM));
    putitem_e(tFIS_NFITEMPRO, 'NR_ITEM', item_f('NR_ITEM', tFIS_NFITEM));
    putitem_e(tFIS_NFITEMPRO, 'CD_PRODUTO', item_f('CD_PRODUTO', tFIS_NFITEM));
    retrieve_e(tFIS_NFITEMPRO);

    clear_e(tTRA_TRANSITEM);
    putitem_e(tTRA_TRANSITEM, 'CD_EMPRESA', vCdEmpTra);
    putitem_e(tTRA_TRANSITEM, 'NR_TRANSACAO', vNrTransacao);
    putitem_e(tTRA_TRANSITEM, 'DT_TRANSACAO', vDtTransacao);
    putitem_e(tTRA_TRANSITEM, 'NR_ITEM', item_f('NR_ITEM', tFIS_NFITEM));
    retrieve_e(tTRA_TRANSITEM);

    viParams := '';

    putitemXml(viParams, 'CD_PRODUTO', item_f('CD_PRODUTO', tFIS_NFITEM));

    if (gTpDescricaoItemEcf = 1) then begin
      vDsProduto := item_a('DS_PRODUTO', tFIS_NFITEM)[1:23];
      vCdCompVend := item_f('CD_COMPVEND', tFIS_NFITEMPRO);
      vDsProduto := '' + vDsProduto(' + FloatToStr(vCdCompVend' + )' + ') + ' + ' + ' + ';
      putitemXml(viParams, 'DS_PRODUTO', vDsProduto);
    end else begin
      putitemXml(viParams, 'DS_PRODUTO', item_a('DS_PRODUTO', tFIS_NFITEM));
    end;

    putitemXml(viParams, 'CD_ESPECIE', item_f('CD_ESPECIE', tPRD_PRODUTO));
    putitemXml(viParams, 'QT_SOLICITADA', item_f('QT_FATURADO', tFIS_NFITEM));
    putitemXml(viParams, 'PR_ALIQICMS', item_f('PR_ALIQUOTA', tFIS_NFITEMIMP));
    putitemXml(viParams, 'VL_DESCONTO', item_f('VL_TOTALDESC', tFIS_NFITEM));
    putitemXml(viParams, 'VL_ACRESCIMO', 0);
    putitemXml(viParams, 'VL_UNITARIO', item_f('VL_UNITBRUTO', tFIS_NFITEM));
    putitemXml(viParams, 'VL_TOTALLIQUIDO', item_f('VL_TOTALBRUTO', tFIS_NFITEM));
    putitemXml(viParams, 'CD_ESPECIE', item_f('CD_ESPECIE', tFIS_NFITEM));
    putitemXml(viParams, 'TP_REGIMESUB', gTpRegime);
    if (gPadraoEcf = <PADRAO_LOCAL> ) or (gPadraoEcf = <PADRAO_LOCALIMPFIM>) then begin
      if (gnext(item_f('CD_PRODUTO', tFIS_NFITEM))= '') then begin
        putitemXml(viParams, 'IN_IMPRIMEAOFINAL', True);
        if (vInTEF = True) then begin
          putitemXml(viParams, 'DS_CUPOM', gDsCupom);
          gDsCupom := '';
        end;
      end else begin
        putitemXml(viParams, 'IN_IMPRIMEAOFINAL', False);
      end;
    end;
    putitemXml(viParams, 'IN_TEF', vInTEF);
    voParams := activateCmp('ECFSVCO001', 'VendeItem', viParams); (*,,, *)
    if (xStatus < 0) then begin
      Result := voParams;
      return(-1); exit;
    end;
    vNrCupom := itemXmlF('NR_CUPOM', voParams);
    vDsCupom := itemXml('DS_CUPOM', voParams);
    gDsCupom := '' + gDsCupom' + vDsCupom' + ' + ';
    vDsSerie := itemXmlF('NR_SERIE', voParams);

    setocc(tFIS_NFITEM, curocc(tFIS_NFITEM) + 1);
  end;
  if (vNrCupom > 0) then begin
    putitemXml(Result, 'NR_CUPOM', vNrCupom);
  end;
  if (itemXml('IN_LOG_TEMPO_VendA', PARAM_GLB) = 1) then begin
    gHrFim := gclock;

    putmess 'ECFSVCO010: lancaItemCupom - Fim lancaItemCupom: ' + gHrFim' + ';
  end;

  gNrNivelImp := 0;
  gNrNivelImpPgto := 0;

  if (gvInConcomitante = False) then begin
    viParams := '';
    putitemXml(viParams, 'NR_SERIE', vDsSerie);
    voParams := validaImpressoraFiscal(viParams); (* PARAM_GLB, viParams, voParams, xCdErro, xCtxErro *)
    if (xStatus < 0) then begin
      Result := voParams;
      return(-1); exit;
    end;

    Result := '';
    putitemXml(Result, 'CD_EMPECF', item_f('CD_EMPRESA', tFIS_ECF));
    putitemXml(Result, 'NR_ECF', item_f('NR_ECF', tFIS_ECF));
  end;

  return(0); exit;
end;

//------------------------------------------------------------
function T_ECFSVCO010.encerraCupom(pParams : String) : String;
//------------------------------------------------------------
const
  cDS_METHOD = 'ADICIONAL=Operação: T_ECFSVCO010.encerraCupom()';
var
  viParams, voParams, vDsRegistro, vDsFormaPgto, vDsLstFormaPgto, vDsLstNF : String;
  vInAberto, vDsConteudo, vDsLstTransacao, vDsAux, vDsLinha : String;
  vDsLstFatura, vDsFatura, vDsCupom, vDsMensagem, vDsLstCheque, vDsCheque, vDsLstCheque2 : String;
  vNrTransacao, vCdEmpTra, vVlFormaPgto, vNrCupom, vCdEmpLogin, vCdCCusto : Real;
  vCdEmpECF, vNrECF, vVlDesconto, vNrFatura, vNrParcela, vlFatura, vNrNivelImpPgto, vVlCheque : Real;
  vDtTransacao : TDate;
  vInTEF, vInImprimirCarner, vInCartaoProprio, vInBonus, vinImprimiGerencial, vInConcomitante, vInGravaRelacao : Boolean;
  vStatus, vNrLinha, vPadraoECF, vVlTotalFatura, vVlTotalCheque, vQtTransacaoTEF : Real;
begin
  vQtTransacaoTEF := 0;

  if (itemXml('IN_LOG_TEMPO_VendA', PARAM_GLB) = 1) then begin
    gHrInicio := gclock;
    putmess 'ECFSVCO010: encerraCupom - Inicio Encerra Cupom: ' + gHrInicio' + ';
  end;

  vInGravaRelacao := itemXmlB('IN_GRAVARELACAO', pParams);

  vinImprimiGerencial := False;

  vInTEF := itemXmlB('IN_TEF', pParams);
  if (vInTEF = '') then begin
    vInTEF := False;
  end;

  vInConcomitante := itemXmlB('IN_CONCOMITANTE', pParams);

  getParams(pParams); (*  *)
  if (xStatus < 0) then begin
    return(-1); exit;
  end;

  vCdEmpLogin := itemXmlF('CD_EMPRESA', PARAM_GLB);
  if (vCdEmpLogin = 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Empresa de login não informada!', cDS_METHOD);
    return(-1); exit;
  end;

  vCdEmpTra := itemXmlF('CD_EMPRESA', pParams);
  if (vCdEmpTra = 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Empresa da transação não informada!', cDS_METHOD);
    return(-1); exit;
  end;

  vNrTransacao := itemXmlF('NR_TRANSACAO', pParams);
  if (vNrTransacao = 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Numero da transação não informado!', cDS_METHOD);
    return(-1); exit;
  end;

  vDtTransacao := itemXml('DT_TRANSACAO', pParams);
  if (vDtTransacao = 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Data da transação não informada!', cDS_METHOD);
    return(-1); exit;
  end;

  vDsLstFormaPgto := itemXml('DS_LSTFORMAPGTO', pParams);
  if (vDsLstFormaPgto = '') then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Forma de pagamento não informada!', cDS_METHOD);
    return(-1); exit;
  end;

  vVlDesconto := itemXmlF('VL_DESCONTO', pParams);
  vDsLstFatura := itemXml('DS_LSTFATURAS', pParams);
  vInCartaoProprio := itemXmlB('IN_CARTAOPROPRIO', pParams);
  vInBonus := itemXmlB('IN_BONUS', pParams);
  vDsLstCheque := itemXml('DS_LSTCHEQUE', pParams);

  viParams := '';
  putitemXml(viParams, 'CD_EMPRESA', item_f('CD_EMPFAT', tTRA_TRANSACAO));
  voParams := activateCmp('SICSVCO009', 'validaCentroCusto', viParams); (*,,,, *)
  if (xStatus < 0) then begin
    Result := voParams;
    return(-1); exit;
  end;

  vCdCCusto := itemXmlF('CD_CENTROCUSTO', voParams);

  if (item_f('CD_EMPFAT', tTRA_TRANSACAO) = vCdCCusto) then begin
    if (gPadraoEcf = <PADRAO_LOCALIMPFIM>) then begin
      if (gInPdvOtimizado <> True) then begin
        viParams := '';
        voParams := activateCmp('ECFSVCO001', 'abreGaveta', viParams); (*,,, *)
        if (xStatus < 0) then begin
          Result := voParams;
          return(-1); exit;
        end;
      end;
    end;
    return(0); exit;
  end;

  vCdEmpECF := itemXmlF('CD_EMPECF', pParams);
  if (vCdEmpECF = 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Empresa da ECF não informada!', cDS_METHOD);
    return(-1); exit;
  end;

  vNrECF := itemXmlF('NR_ECF', pParams);
  if (vNrECF = 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Número da ECF não informado!', cDS_METHOD);
    return(-1); exit;
  end;
  if (gPadraoEcf = <PADRAO_BEMATECH>) then begin
    vNrCupom := itemXmlF('NR_CUPOM', pParams);
    if (vNrCupom = 0) then begin
      Result := SetStatus(STS_ERROR, 'GEN0001', 'Número do cupom fiscal não informado!', cDS_METHOD);
      return(-1); exit;
    end;
  end else begin
    vNrCupom := itemXmlF('NR_CUPOM', pParams);
  end;

  clear_e(tFIS_ECF);
  putitem_e(tFIS_ECF, 'CD_EMPRESA', vCdEmpECF);
  putitem_e(tFIS_ECF, 'NR_ECF', vNrECF);
  retrieve_e(tFIS_ECF);
  if (xStatus < 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Impressora fiscal ' + FloatToStr(vCdEmpECF) + ' / ' + FloatToStr(vNrECF) + ' não cadastrada!', cDS_METHOD);
    return(-1); exit;
  end;

  clear_e(tTRA_TRANSACAO);
  putitem_e(tTRA_TRANSACAO, 'CD_EMPRESA', vCdEmpTra);
  putitem_e(tTRA_TRANSACAO, 'NR_TRANSACAO', vNrTransacao);
  putitem_e(tTRA_TRANSACAO, 'DT_TRANSACAO', vDtTransacao);
  retrieve_e(tTRA_TRANSACAO);
  if (xStatus < 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Transação ' + FloatToStr(vNrTransacao) + ' não encontrada!', cDS_METHOD);
    return(-1); exit;
  end;
  clear_e(tFIS_NF);
  putitem_e(tFIS_NF, 'CD_EMPRESAORI', vCdEmpTra);
  putitem_e(tFIS_NF, 'NR_TRANSACAOORI', vNrTransacao);
  putitem_e(tFIS_NF, 'DT_TRANSACAOORI', vDtTransacao);
  retrieve_e(tFIS_NF);
  if (xStatus < 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Nota Fiscal não encontrada para a transação ' + FloatToStr(vNrTransacao) + '!', cDS_METHOD);
    return(-1); exit;
  end;
  setocc(tFIS_NF, -1);
  if (totocc (FIS_NF) > 1) then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Existe mais de uma nota para essa transação!', cDS_METHOD);
    return(-1); exit;
  end;
  if (gPadraoEcf = <PADRAO_BEMATECH>) then begin
    if (itemXml('IN_LOG_TEMPO_VendA', PARAM_GLB) = 1) then begin
      gHrInicio := gclock;
      putmess 'ECFSVCO010: encerraCupom - Inicio Verifica Estado: ' + gHrInicio' + ';
    end;

    vInAberto := '';
    viParams := '';
    voParams := activateCmp('ECFSVCO001', 'verificaEstado', viParams); (*,,, *)
    if (xStatus < 0) then begin
      Result := voParams;
      return(-1); exit;
    end;
    if (itemXml('IN_LOG_TEMPO_VendA', PARAM_GLB) = 1) then begin
      gHrFim := gclock;
      putmess 'ECFSVCO010: encerraCupom - Fim Verifica Estado: ' + gHrFim' + ';
    end;

    vInAberto := itemXml('INABERTO', voParams);

    if (vInAberto <> 'S') then begin
      Result := SetStatus(STS_ERROR, 'GEN0001', 'Não existe cupom aberto na impressora!', cDS_METHOD);
      return(-1); exit;
    end;
  end;

  viParams := '';
  putitemXml(viParams, 'CD_EMPRESA', item_f('CD_EMPFAT', tTRA_TRANSACAO));
  voParams := activateCmp('SICSVCO009', 'validaCentroCusto', viParams); (*,,,, *)
  if (xStatus < 0) then begin
    Result := voParams;
    return(-1); exit;
  end;

  vCdCCusto := itemXmlF('CD_CENTROCUSTO', voParams);

  if (item_f('CD_EMPFAT', tTRA_TRANSACAO) = vCdCCusto) then begin
    return(0); exit;
  end;
  if (itemXml('IN_LOG_TEMPO_VendA', PARAM_GLB) = 1) then begin
    gHrInicio := gclock;
    putmess 'ECFSVCO010: encerraCupom - Inicio Acrescimo Desconto: ' + gHrInicio' + ';
  end;
  if (vInConcomitante = True) then begin
    setocc(tTRA_TRANSITEM, 1);
    while (xStatus >= 0) do begin
      vVlDesconto := vVlDesconto + item_f('VL_TOTALDESCCAB', tTRA_TRANSITEM);

      setocc(tTRA_TRANSITEM, curocc(tTRA_TRANSITEM) + 1);
    end;
  end else begin
    vVlDesconto := vVlDesconto + item_f('VL_DESCONTO', tTRA_TRANSACAO);
  end;

  viParams := '';
  if (vVlDesconto > 0) then begin
    putitemXml(viParams, 'IN_ACRESDESC', 'D');
    putitemXml(viParams, 'TP_ACRESDESC', 'g');
    putitemXml(viParams, 'VL_ACRESDESC', vVlDesconto);
  end else begin
    putitemXml(viParams, 'IN_ACRESDESC', '');
    putitemXml(viParams, 'TP_ACRESDESC', '');
    putitemXml(viParams, 'VL_ACRESDESC', 0);
  end;
  if (vInTEF = True ) and (gNrNivelImp >= 1) then begin
    gDsCupom := '';
  end else begin
    putitemXml(viParams, 'IN_CONCOMITANTE', vInConcomitante);
    voParams := activateCmp('ECFSVCO001', 'AcrescimoDescontoCupom', viParams); (*,,, *)
    if (xStatus < 0) then begin
      Result := voParams;
      return(-1); exit;
    end;
    gNrNivelImp := 1;
    vDsCupom := itemXml('DS_CUPOM', voParams);
    gDsCupom := '' + gDsCupom' + vDsCupom' + ' + ';
  end;
  if (itemXml('IN_LOG_TEMPO_VendA', PARAM_GLB) = 1) then begin
    gHrFim := gclock;
    putmess 'ECFSVCO010: encerraCupom - Fim Acrescimo Desconto: ' + gHrFim' + ';
  end;
  if (itemXml('IN_LOG_TEMPO_VendA', PARAM_GLB) = 1) then begin
    gHrInicio := gclock;
    putmess 'ECFSVCO010: encerraCupom - Inicio Forma de pagamento: ' + gHrInicio' + ';
  end;
  if (vInTEF = True ) and (gNrNivelImp >= 2) then begin
    gDsCupom := '';
  end else begin
    vNrNivelImpPgto := 0;
    repeat
      getitem(vDsRegistro, vDsLstFormaPgto, 1);
      vDsFormaPgto := itemXml('DS_FORMAPGTO', vDsRegistro);
      if (vDsFormaPgto = '') then begin
        Result := SetStatus(STS_ERROR, 'GEN0001', 'Descrição da forma de pagamento não informada!', cDS_METHOD);
        return(-1); exit;
      end;

      vVlFormaPgto := itemXmlF('VL_FORMAPGTO', vDsRegistro);
      if (vVlFormaPgto = 0) then begin
        Result := SetStatus(STS_ERROR, 'GEN0001', 'Valor da forma de pagamento não informado!', cDS_METHOD);
        return(-1); exit;
      end;

      vNrNivelImpPgto := vNrNivelImpPgto + 1;

      viParams := '';

      putitemXml(viParams 'DS_FORMAPGTO', vDsFormaPgto);
      putitemXml(viParams 'VL_FORMAPGTO', vVlFormaPgto);
      if (vInTEF = True ) and (vNrNivelImpPgto <= gNrNivelImpPgto) then begin
        gDsCupom := '';
      end else begin
        voParams := activateCmp('ECFSVCO001', 'FormaPagamento', viParams); (*,,, *)
        if (xStatus < 0) then begin
          Result := voParams;
          return(-1); exit;
        end;
        gNrNivelImpPgto := gNrNivelImpPgto + 1;
        vDsCupom := itemXml('DS_CUPOM', voParams);
        gDsCupom := '' + gDsCupom' + vDsCupom' + ' + ';
      end;

      delitem(vDsLstFormaPgto, 1);
    until (vDsLstFormaPgto = '');
  end;
  gNrNivelImp := 2;

  if (itemXml('IN_LOG_TEMPO_VendA', PARAM_GLB) = 1) then begin
    gHrFim := gclock;
    putmess 'ECFSVCO010: encerraCupom - Fim Forma de pagamento: ' + gHrfim' + ';
  end;
  if (itemXml('IN_LOG_TEMPO_VendA', PARAM_GLB) = 1) then begin
    gHrInicio := gclock;
    putmess 'ECFSVCO010: encerraCupom - Inicio Fechamento do Cupom: ' + gHrInicio' + ';
  end;

  voParams := verificaQtdTransacaoTEF(viParams); (* vCdEmpTra, vNrTransacao, vDtTransacao, vQtTransacaoTEF *)
  if (xStatus < 0) then begin
    return(-1); exit;
  end;
  if (gTpImpTefPAYGO = 1 ) and (vQtTransacaoTEF = 1) then begin
    clear_e(tTEF_RELTRANSA);
    putitem_e(tTEF_RELTRANSA, 'CD_EMPTRA', vCdEmpTra);
    putitem_e(tTEF_RELTRANSA, 'NR_TRANSACAO', vNrTransacao);
    putitem_e(tTEF_RELTRANSA, 'DT_TRANSACAO', vDtTransacao);
    retrieve_e(tTEF_RELTRANSA);
    if (xStatus >=0) then begin
      clear_e(tTEF_TRANSACAO);
      putitem_e(tTEF_TRANSACAO, 'CD_EMPRESA', item_f('CD_EMPTEF', tTEF_RELTRANSA));
      putitem_e(tTEF_TRANSACAO, 'DT_MOVIMENTO', item_a('DT_MOVIMENTO', tTEF_RELTRANSA));
      putitem_e(tTEF_TRANSACAO, 'NR_SEQ', item_f('NR_SEQ', tTEF_RELTRANSA));
      retrieve_e(tTEF_TRANSACAO);
      if (xStatus >= 0) then begin
        vDsMensagem := item_a('DS_CUPOM', tTEF_TRANSACAO);
      end;
    end;

  end else begin

    viParams := '';

    if (gInImpObsECFCliVista=1) then begin
      putitemXml(viParams, 'CD_CLIENTE', item_f('CD_PESSOA', tTRA_TRANSACAO));
      putitemXml(viParams, 'CD_EMPRESA', item_f('CD_EMPRESA', tTRA_TRANSACAO));
      putitemXml(viParams, 'NR_TRANSACAO', item_f('NR_TRANSACAO', tTRA_TRANSACAO));
      putitemXml(viParams, 'DT_TRANSACAO', item_a('DT_TRANSACAO', tTRA_TRANSACAO));
      putitemXml(viParams, 'CD_COMPVend', item_f('CD_COMPVEND', tTRA_TRANSACAO));
      voParams := activateCmp('ECFSVCO012', 'geraObsECF', viParams); (*,,,, *)
      if (xStatus < 0) then begin
        Result := voParams;
        return(-1); exit;
      end;
      vDsMensagem := itemXml('DS_MENSAGEM', voParams);
    end else begin
      if (gCdClientePdv <> item_f('CD_PESSOA', tTRA_TRANSACAO)) then begin
        putitemXml(viParams, 'CD_CLIENTE', item_f('CD_PESSOA', tTRA_TRANSACAO));
        putitemXml(viParams, 'CD_EMPRESA', item_f('CD_EMPRESA', tTRA_TRANSACAO));
        putitemXml(viParams, 'NR_TRANSACAO', item_f('NR_TRANSACAO', tTRA_TRANSACAO));
        putitemXml(viParams, 'DT_TRANSACAO', item_a('DT_TRANSACAO', tTRA_TRANSACAO));
        putitemXml(viParams, 'CD_COMPVend', item_f('CD_COMPVEND', tTRA_TRANSACAO));
        voParams := activateCmp('ECFSVCO012', 'geraObsECF', viParams); (*,,,, *)
        if (xStatus < 0) then begin
          Result := voParams;
          return(-1); exit;
        end;
        vDsMensagem := itemXml('DS_MENSAGEM', voParams);

      end;
    end;
  end;

  putitemXml(viParams, 'NR_SERIE', item_f('CD_SERIEFAB', tFIS_ECF));
  putitemXml(viParams, 'NR_CUPOM', vNrCupom);
  putitemXml(viParams, 'DS_CUPOM', gDsCupom);
  putitemXml(viParams, 'DS_MENSAGEM', vDsMensagem);
  voParams := activateCmp('ECFSVCO001', 'FechaCupom', viParams); (*,,, *)
  if (xStatus < 0) then begin
    Result := voParams;
    return(-1); exit;
  end;
  if (gPadraoEcf = <PADRAO_LOCALIMPFIM> ) and (vNrCupom = 0) then begin
    vNrCupom := itemXmlF('NR_CUPOM', voParams);
    putitemXml(Result, 'NR_CUPOM', vNrCupom);
  end;
  if (gTpImpTefPAYGO = 1 ) and (vQtTransacaoTEF = 1) then begin
    putitemXml(Result, 'TP_IMPTEFPAYGO', gTpImpTefPAYGO);
  end;

  gDsCupom := '';
  gNrNivelImp := 0;
  gNrNivelImpPgto := 0;

  if (itemXml('IN_LOG_TEMPO_VendA', PARAM_GLB) = 1) then begin
    gHrFim := gclock;
    putmess 'ECFSVCO010: encerraCupom - Fim Fechamento do Cupom: ' + gHrFim' + ';
  end;
  if (vNrCupom = 0) then begin
    viParams := '';

    putitemXml(viParams, 'NM_FUNCAO', <ECF_NUMERO_CUPOM>);
    putitemXml(viParams, 'IN_IMPCUPOMFISCAL', False);
    voParams := activateCmp('ECFSVCO001', 'leInformacaoImpressora', viParams); (*,,, *)
    if (xStatus < 0) then begin
      Result := voParams;
      return(-1); exit;
    end;
    vNrCupom := itemXmlF('NR_CUPOM', voParams);
    if (vNrCupom = 0) then begin
      vNrCupom := item_f('NR_TRANSACAO', tTRA_TRANSACAO);
    end;
  end;
  if (vInConcomitante = False) then begin
    viParams := '';
    putitemXml(viParams, 'CD_EMPRESA', item_f('CD_EMPRESA', tTRA_TRANSACAO));
    putitemXml(viParams, 'NR_TRANSACAO', item_f('NR_TRANSACAO', tTRA_TRANSACAO));
    putitemXml(viParams, 'DT_TRANSACAO', item_a('DT_TRANSACAO', tTRA_TRANSACAO));
    putitemXml(viParams, 'CD_EMPECF', vCdEmpECF);
    putitemXml(viParams, 'NR_ECF', vNrECF);
    putitemXml(viParams, 'NR_CUPOM', vNrCupom);
    putitemXml(viParams, 'IN_GRAVARELACAO', True);

    newinstance 'TRASVCO016', 'TRASVCO016X', 'TRANSACTION=TRUE';
    voParams := activateCmp('TRASVCO016X', 'gravaECFTransacao', viParams); (*,,,, *)
    if (xStatus < 0) then begin
      Result := voParams;
      return(-1); exit;
    end;
    deleteinstance 'TRASVCO016X';
  end;

  viParams := '';
  putitemXml(viParams, 'CD_EMPRESA', item_f('CD_EMPRESA', tFIS_NF));
  putitemXml(viParams, 'NR_FATURA', item_f('NR_FATURA', tFIS_NF));
  putitemXml(viParams, 'DT_FATURA', item_a('DT_FATURA', tFIS_NF));
  putitemXml(viParams, 'CD_EMPECF', vCdEmpECF);
  putitemXml(viParams, 'NR_ECF', vNrECF);
  putitemXml(viParams, 'NR_CUPOM', vNrCupom);
  voParams := activateCmp('FISSVCO004', 'gravaECFNF', viParams); (*,,,, *)
  if (xStatus < 0) then begin
    Result := voParams;
    return(-1); exit;
  end;
  if (gInCarne = 'S')  and ((vDsLstFatura <> '')  or (vDsLstCheque<> '')) then begin
    if (gInPerguntaImpCarneEcf = True) then begin
      askmess 'Deseja imprimir o carne ECF?', 'Sim, Não';
      if (xStatus = 1) then begin
        viParams := '';

        if (vDsLstFatura <> '') then begin
          putitem(vDsFatura,  '' + CD_PESSOA + '.PES_PESSOA ' + NM_PESSOA + '.PES_PESSOA');
          repeat
            getitem(vDsRegistro, vDsLstFatura, 1);
            vNrFatura := itemXmlF('NR_FATURA', vDsRegistro);
            gvDtVencto := itemXml('DT_VENCIMENTO', vDsRegistro);
            vNrParcela := itemXmlF('NR_PARCELA', vDsRegistro);
            gVlFatura := itemXmlF('VL_FATURA', vDsRegistro);
            vVlTotalFatura := vVlTotalFatura + gVlFatura;
            putitem(vDsFatura,  '' + FloatToStr(vNrFatura) + '/' + FloatToStr(vNrParcela) + ' Venc.: ' + gvDtVencto + ' .:Rg ' + VlFaturag') + ';
            delitem(vDsLstFatura, 1);
          until (vDsLstFatura = '');

          putitemXml(viParams, 'DS_LSTCUPOMVINCULADO', vDsFatura);
        end;
        if (vDsLstCheque <> '') then begin
          if (vDsFatura = '') then begin
            putitem(vDsCheque,  '' + CD_PESSOA + '.PES_PESSOA ' + NM_PESSOA + '.PES_PESSOA');
          end;
          vDsLstCheque2 := vDsLstCheque;
          repeat
            getitem(vDsRegistro, vDsLstCheque2, 1);
            vNrFatura := itemXmlF('NR_FATURA', vDsRegistro);
            gvDtVencto := itemXml('DT_VENCIMENTO', vDsRegistro);
            vVlCheque := itemXmlF('VL_FATURA', vDsRegistro);
            vVlTotalCheque := vVlTotalCheque + vVlCheque;
            putitem(vDsCheque,  '' + FloatToStr(vNrFatura) + '/' + FloatToStr(vNrParcela) + ' Venc.: ' + gvDtVencto + ' .:Rg ' + VlFaturag') + ';
            delitem(vDsLstCheque2, 1);
          until (vDsLstCheque2 = '');

          putitemXml(viParams, 'DS_LSTCUPOMVINCULADO', vDsCheque);
        end;
        if (gCdModTraObsEcfCarne <> '') then begin
          vDsLstTransacao := '';
          vDsRegistro := '';
          putitemXml(vDsRegistro, 'CD_EMPRESA', item_f('CD_EMPRESA', tTRA_TRANSACAO));
          putitemXml(vDsRegistro, 'NR_TRANSACAO', item_f('NR_TRANSACAO', tTRA_TRANSACAO));
          putitemXml(vDsRegistro, 'DT_TRANSACAO', item_a('DT_TRANSACAO', tTRA_TRANSACAO));
          putitem(vDsLstTransacao,  vDsRegistro);
          putitemXml(viParams, 'DS_LSTTRANSACAO', vDsLstTransacao);
          putitemXml(viParams, 'CD_MODELOTRA', gCdModTraObsEcfCarne);
          putitemXml(viParams, 'DS_LSTCHEQUE', vDSLstCheque);
          voParams := activateCmp('GERSVCO020', 'geraImpressaoTransacao', viParams); (*,,,, *)
          if (xStatus < 0) then begin
            Result := voParams;
            return(-1); exit;
          end;

          vDsAux := itemXml('DS_CONTEUDO', voParams);

          vDsConteudo := '' + vDsConteudo' + vDsAux' + ' + ';

        end;
        if (vInCartaoProprio = True) then begin
          if (gCdMmodTraEcfCartaoProp > 0) then begin
            vDsLstTransacao := '';
            vDsRegistro := '';
            putitemXml(vDsRegistro, 'CD_EMPRESA', item_f('CD_EMPRESA', tTRA_TRANSACAO));
            putitemXml(vDsRegistro, 'NR_TRANSACAO', item_f('NR_TRANSACAO', tTRA_TRANSACAO));
            putitemXml(vDsRegistro, 'DT_TRANSACAO', item_a('DT_TRANSACAO', tTRA_TRANSACAO));
            putitem(vDsLstTransacao,  vDsRegistro);
            putitemXml(viParams, 'DS_LSTTRANSACAO', vDsLstTransacao);
            putitemXml(viParams, 'CD_MODELOTRA', gCdMmodTraEcfCartaoProp);
            putitemXml(viParams, 'DS_LSTCHEQUE', vDSLstCheque);
            voParams := activateCmp('GERSVCO020', 'geraImpressaoTransacao', viParams); (*,,,, *)
            if (xStatus < 0) then begin
              Result := voParams;
              return(-1); exit;
            end;

            vDsAux := itemXml('DS_CONTEUDO', voParams);

            vDsConteudo := '' + vDsConteudo' + vDsAux' + ' + ';

          end;
        end;
        if (vInBonus = True) then begin
          if (gCdModTraEcfReciboBonus > 0) then begin
            vDsLstTransacao := '';
            vDsRegistro := '';
            putitemXml(vDsRegistro, 'CD_EMPRESA', item_f('CD_EMPRESA', tTRA_TRANSACAO));
            putitemXml(vDsRegistro, 'NR_TRANSACAO', item_f('NR_TRANSACAO', tTRA_TRANSACAO));
            putitemXml(vDsRegistro, 'DT_TRANSACAO', item_a('DT_TRANSACAO', tTRA_TRANSACAO));
            putitem(vDsLstTransacao,  vDsRegistro);
            putitemXml(viParams, 'DS_LSTTRANSACAO', vDsLstTransacao);
            putitemXml(viParams, 'CD_MODELOTRA', gCdModTraEcfReciboBonus);
            putitemXml(viParams, 'DS_LSTCHEQUE', vDSLstCheque);
            voParams := activateCmp('GERSVCO020', 'geraImpressaoTransacao', viParams); (*,,,, *)
            if (xStatus < 0) then begin
              Result := voParams;
              return(-1); exit;
            end;

            vDsAux := itemXml('DS_CONTEUDO', voParams);

            vDsConteudo := '' + vDsConteudo' + vDsAux' + ' + ';

          end;
        end;
        if (vDsFatura <> '') then begin
          putitemXml(viParams, 'DS_FORMAPGTO', 'Fatura');
          putitemXml(viParams, 'VL_VALOR', vVlTotalFatura);
        end else begin
          putitemXml(viParams, 'DS_FORMAPGTO', 'Cheque');
          putitemXml(viParams, 'VL_VALOR', vVlTotalCheque);
        end;

        putitemXml(viParams, 'NR_CUPOM', vNrCupom);

        if (vDsConteudo <> '') then begin
          putitemXml(viParams, 'DS_LSTCUPOMVINCULADO', vDsConteudo);
        end;

        voParams := geraCupomVinculado(viParams); (* PARAM_GLB, viParams, voParams, xCdErro, xCtxErro *)
        if (xStatus < 0) then begin
          Result := voParams;
          return(-1); exit;
        end;
      end;
    end else begin
      if (vDsLstFatura <> '') then begin
        putitem(vDsFatura,  '' + CD_PESSOA + '.PES_PESSOA ' + NM_PESSOA + '.PES_PESSOA');
        repeat
          viParams := '';

          getitem(vDsRegistro, vDsLstFatura, 1);
          vNrFatura := itemXmlF('NR_FATURA', vDsRegistro);
          gvDtVencto := itemXml('DT_VENCIMENTO', vDsRegistro);
          vNrParcela := itemXmlF('NR_PARCELA', vDsRegistro);
          gVlFatura := itemXmlF('VL_FATURA', vDsRegistro);
          vVlTotalFatura := vVlTotalFatura + gVlFatura;
          putitem(vDsFatura,  '' + FloatToStr(vNrFatura) + '/' + FloatToStr(vNrParcela) + ' Venc.: ' + gvDtVencto + ' .:Rg ' + VlFaturag') + ';
          delitem(vDsLstFatura, 1);
        until (vDsLstFatura = '');
        putitemXml(viParams, 'DS_LSTCUPOMVINCULADO', vDsFatura);
      end;
      if (vDsLstCheque <> '') then begin
        if (vDsFatura = '') then begin
          putitem(vDsCheque,  '' + CD_PESSOA + '.PES_PESSOA ' + NM_PESSOA + '.PES_PESSOA');
        end;
        vDsLstCheque2 := vDsLstCheque;
        repeat
          getitem(vDsRegistro, vDsLstCheque2, 1);
          vNrFatura := itemXmlF('NR_FATURA', vDsRegistro);
          gvDtVencto := itemXml('DT_VENCIMENTO', vDsRegistro);
          vVlCheque := itemXmlF('VL_FATURA', vDsRegistro);
          vVlTotalCheque := vVlTotalCheque + vVlCheque;
          putitem(vDsCheque,  '' + FloatToStr(vNrFatura) + '/' + FloatToStr(vNrParcela) + ' Venc.: ' + gvDtVencto + ' .:Rg ' + VlFaturag') + ';
          delitem(vDsLstCheque2, 1);
        until (vDsLstCheque2 = '');

        putitemXml(viParams, 'DS_LSTCUPOMVINCULADO', vDsCheque);
      end;
      if (gCdModTraObsEcfCarne <> '') then begin
        vDsLstTransacao := '';
        vDsRegistro := '';
        putitemXml(vDsRegistro, 'CD_EMPRESA', item_f('CD_EMPRESA', tTRA_TRANSACAO));
        putitemXml(vDsRegistro, 'NR_TRANSACAO', item_f('NR_TRANSACAO', tTRA_TRANSACAO));
        putitemXml(vDsRegistro, 'DT_TRANSACAO', item_a('DT_TRANSACAO', tTRA_TRANSACAO));
        putitem(vDsLstTransacao,  vDsRegistro);
        putitemXml(viParams, 'DS_LSTTRANSACAO', vDsLstTransacao);
        putitemXml(viParams, 'CD_MODELOTRA', gCdModTraObsEcfCarne);
        putitemXml(viParams, 'DS_LSTCHEQUE', vDSLstCheque);
        voParams := activateCmp('GERSVCO020', 'geraImpressaoTransacao', viParams); (*,,,, *)
        if (xStatus < 0) then begin
          Result := voParams;
          return(-1); exit;
        end;

        vDsAux := itemXml('DS_CONTEUDO', voParams);

        vDsConteudo := '' + vDsConteudo' + vDsAux' + ' + ';

      end;
      if (vInCartaoProprio = True) then begin
        if (gCdMmodTraEcfCartaoProp > 0) then begin
          vDsLstTransacao := '';
          vDsRegistro := '';
          putitemXml(vDsRegistro, 'CD_EMPRESA', item_f('CD_EMPRESA', tTRA_TRANSACAO));
          putitemXml(vDsRegistro, 'NR_TRANSACAO', item_f('NR_TRANSACAO', tTRA_TRANSACAO));
          putitemXml(vDsRegistro, 'DT_TRANSACAO', item_a('DT_TRANSACAO', tTRA_TRANSACAO));
          putitem(vDsLstTransacao,  vDsRegistro);
          putitemXml(viParams, 'DS_LSTTRANSACAO', vDsLstTransacao);
          putitemXml(viParams, 'CD_MODELOTRA', gCdMmodTraEcfCartaoProp);
          putitemXml(viParams, 'DS_LSTCHEQUE', vDSLstCheque);
          voParams := activateCmp('GERSVCO020', 'geraImpressaoTransacao', viParams); (*,,,, *)
          if (xStatus < 0) then begin
            Result := voParams;
            return(-1); exit;
          end;

          vDsAux := itemXml('DS_CONTEUDO', voParams);

          vDsConteudo := '' + vDsConteudo' + vDsAux' + ' + ';
        end;
      end;
      if (vInBonus = True) then begin
        if (gCdModTraEcfReciboBonus > 0) then begin
          vDsLstTransacao := '';
          vDsRegistro := '';
          putitemXml(vDsRegistro, 'CD_EMPRESA', item_f('CD_EMPRESA', tTRA_TRANSACAO));
          putitemXml(vDsRegistro, 'NR_TRANSACAO', item_f('NR_TRANSACAO', tTRA_TRANSACAO));
          putitemXml(vDsRegistro, 'DT_TRANSACAO', item_a('DT_TRANSACAO', tTRA_TRANSACAO));
          putitem(vDsLstTransacao,  vDsRegistro);
          putitemXml(viParams, 'DS_LSTTRANSACAO', vDsLstTransacao);
          putitemXml(viParams, 'CD_MODELOTRA', gCdModTraEcfReciboBonus);
          putitemXml(viParams, 'DS_LSTCHEQUE', vDSLstCheque);
          voParams := activateCmp('GERSVCO020', 'geraImpressaoTransacao', viParams); (*,,,, *)
          if (xStatus < 0) then begin
            Result := voParams;
            return(-1); exit;
          end;

          vDsAux := itemXml('DS_CONTEUDO', voParams);

          vDsConteudo := '' + vDsConteudo' + vDsAux' + ' + ';
        end;
      end;
      if (vDsFatura <> '') then begin
        putitemXml(viParams, 'DS_FORMAPGTO', 'Fatura');
        putitemXml(viParams, 'NR_CUPOM', vNrCupom);
        putitemXml(viParams, 'VL_VALOR', vVlTotalFatura);
      end else begin
        putitemXml(viParams, 'DS_FORMAPGTO', 'Cheque');
        putitemXml(viParams, 'VL_VALOR', vVlTotalCheque);
      end;
      if (vDsConteudo <> '') then begin
        putitemXml(viParams, 'DS_LSTCUPOMVINCULADO', vDsConteudo);
      end;

      voParams := geraCupomVinculado(viParams); (* PARAM_GLB, viParams, voParams, xCdErro, xCtxErro *)
      if (xStatus < 0) then begin
        Result := voParams;
        return(-1); exit;
      end;
    end;

  end else begin
    vinImprimiGerencial := False;
    if (vInCartaoProprio = True) then begin
      if (gCdMmodTraEcfCartaoProp > 0) then begin
        vinImprimiGerencial := True;
        vDsLstTransacao := '';
        vDsRegistro := '';
        putitemXml(vDsRegistro, 'CD_EMPRESA', item_f('CD_EMPRESA', tTRA_TRANSACAO));
        putitemXml(vDsRegistro, 'NR_TRANSACAO', item_f('NR_TRANSACAO', tTRA_TRANSACAO));
        putitemXml(vDsRegistro, 'DT_TRANSACAO', item_a('DT_TRANSACAO', tTRA_TRANSACAO));
        putitem(vDsLstTransacao,  vDsRegistro);
        putitemXml(viParams, 'DS_LSTTRANSACAO', vDsLstTransacao);
        putitemXml(viParams, 'CD_MODELOTRA', gCdMmodTraEcfCartaoProp);
        putitemXml(viParams, 'DS_LSTCHEQUE', vDSLstCheque);
        voParams := activateCmp('GERSVCO020', 'geraImpressaoTransacao', viParams); (*,,,, *)
        if (xStatus < 0) then begin
          Result := voParams;
          return(-1); exit;
        end;
              vDsAux := itemXml('DS_CONTEUDO', voParams);
        vDsConteudo := '' + vDsConteudo' + vDsAux' + ' + ';
      end;
    end;
    if (vInBonus = True) then begin
      if (gCdModTraEcfReciboBonus > 0) then begin
        vinImprimiGerencial := True;
        vDsLstTransacao := '';
        vDsRegistro := '';
        putitemXml(vDsRegistro, 'CD_EMPRESA', item_f('CD_EMPRESA', tTRA_TRANSACAO));
        putitemXml(vDsRegistro, 'NR_TRANSACAO', item_f('NR_TRANSACAO', tTRA_TRANSACAO));
        putitemXml(vDsRegistro, 'DT_TRANSACAO', item_a('DT_TRANSACAO', tTRA_TRANSACAO));
        putitem(vDsLstTransacao,  vDsRegistro);
        putitemXml(viParams, 'DS_LSTTRANSACAO', vDsLstTransacao);
        putitemXml(viParams, 'CD_MODELOTRA', gCdModTraEcfReciboBonus);
        putitemXml(viParams, 'DS_LSTCHEQUE', vDSLstCheque);
        voParams := activateCmp('GERSVCO020', 'geraImpressaoTransacao', viParams); (*,,,, *)
        if (xStatus < 0) then begin
          Result := voParams;
          return(-1); exit;
        end;
          vDsAux := itemXml('DS_CONTEUDO', voParams);
          vDsConteudo := '' + vDsConteudo' + vDsAux' + ' + ';
      end;
    end;
    if (vinImprimiGerencial = True) then begin
      viParams := '';
      putitemXml(viParams, 'DS_FORMAPGTO', vDsFormaPgto);
      putitemXml(viParams, 'VL_VALOR', vVlFormaPgto);
      putitemXml(viParams, 'NR_CUPOM', vNrCupom);
      voParams := activateCmp('ECFSVCO011', 'abreRelatorioGerencial', viParams); (*,,, *)
      if (xStatus < 0) then begin
        Result := voParams;
        return(-1); exit;
      end;

      gDsCupom := '';
      vDsCupom := itemXml('DS_CUPOM', voParams);
      gDsCupom := '' + gDsCupom' + vDsCupom' + ' + ';

      length vDsConteudo;
      while(gresult > 0) do begin
        scan vDsConteudo, '';
        if (gresult > 0) then begin
          vDsLinha := vDsConteudo[1, gresult - 1];
          vDsConteudo := vDsConteudo[gresult + 1];
        end else begin
          vDsLinha := vDsConteudo;
          vDsConteudo := '';
        end;
        gDsCupom := '' + gDsCupom + '025' + vDsLinha' + ';
        vDsCupom := '' + vDsCupom + '025' + vDsLinha' + ';
        length vDsConteudo;
      end;

      gHrInicio := gclock;
      putmess '- Inicio impressao geraCupomVinculado: ' + gHrInicio' + ';

      gDsCupom := '' + gDsCupom + '026';

      viParams := '';
      putitemXml(viParams, 'IN_IMPRIMEVIA', True);
      putitemXml(viParams, 'DS_TEXTO', gDsCupom);
      voParams := activateCmp('ECFSVCO001', 'ImprimirVinculado', viParams); (*,,, *)
      if (xStatus < 0) then begin
        Result := voParams;
        return(-1); exit;
      end;
        putitemXml(viParams, 'TITULO', 'Erro de comunicação com a ECF');
        putitemXml(viParams, 'MENSAGEM', itemXml('DESCRICAO', xCtxErro));
        voParams := activateCmp('GERFP008', 'EXEC', viParams); (*,,, *)
        if (xStatus < 0) then begin
          Result := voParams;
          return(-1); exit;
        end;

        gHrFim := gclock;
        gHrTempo := gHrFim - gHrInicio;
        putmess '- Fim : impressao geraCupomVinculado ' + gHrFim + ' - ' + gHrTempo' + ';
      end;
    end;
  end;

  gNrCupom := '';

  if (itemXml('IN_LOG_TEMPO_VendA', PARAM_GLB) = 1) then begin
    gHrFim := gclock;
    putmess 'ECFSVCO010: encerraCupom - Fim Encerra Cupom: ' + gHrFim' + ';
  end;

  return(0); exit;
end;

//------------------------------------------------------------------
function T_ECFSVCO010.geraCupomVinculado(pParams : String) : String;
//------------------------------------------------------------------
const
  cDS_METHOD = 'ADICIONAL=Operação: T_ECFSVCO010.geraCupomVinculado()';
var
  DsLstCupomVinculado,vDsRegistro,viParams,voParams, DsFormaPgto, vInAberto : String;
  vDsConteudo, vDsLinha, vDsCupom, vDsLstTransacao : String;
  vlValor, vNrCupom, vNrCopia, vNrLinha, vNrVia, vNrLinhasCorte, vNrLinhaCorteAtual, vDsSerie : Real;
  InReimpressao, vInCorteVia : Boolean;
  vStatus : Real;
begin
  InReimpressao := False;
  vInAberto := '';
  viParams := '';
  voParams := activateCmp('ECFSVCO001', 'VerificaEstado', viParams); (*,,, *)
  if (xStatus < 0) then begin
    Result := voParams;
    return(-1); exit;
  end;
  vDsCupom := itemXml('DS_CUPOM', voParams);
  gDsCupom := '' + gDsCupom' + vDsCupom' + ' + ';

  InReimpressao := itemXmlB('IN_REIMPRESSAO', pParams);

  vInAberto := itemXml('INABERTO', voParams);
  if (vInAberto = 'S' ) and (InReimpressao) then begin
    vDsRegistro := itemXml('DS_TEXTO', pParams);
    voParams := reimpressaoCupomVinculado(viParams); (* *)
    if (xStatus < 0) then begin
      Result := voParams;
      return(-1); exit;
    end;
    return(0); exit;
  end;

  DsFormaPgto := itemXml('DS_FORMAPGTO', pParams);
  vlValor := itemXmlF('VL_VALOR', pParams);
  vNrCupom := itemXmlF('NR_CUPOM', pParams);

  viParams := '';
  putitemXml(viParams, 'DS_FORMAPGTO', DsFormaPgto);
  putitemXml(viParams, 'VL_VALOR', vlValor);
  putitemXml(viParams, 'NR_CUPOM', vNrCupom);
  voParams := activateCmp('ECFSVCO001', 'AbreComprovanteNFV', viParams); (*,,, *)
  if (xStatus < 0) then begin
    Result := voParams;
    return(-1); exit;
  end;
  vDsCupom := itemXml('DS_CUPOM', voParams);
  gDsCupom := '' + gDsCupom' + vDsCupom' + ' + ';

  DsLstCupomVinculado := itemXml('DS_LSTCUPOMVINCULADO', pParams);

  if (DsLstCupomVinculado <> '') then begin
    vNrCopia := 1;

    clear_e(tFIS_ECFADIC);
    putitem_e(tFIS_ECFADIC, 'CD_EMPRESA', item_f('CD_EMPRESA', tFIS_ECF));
    putitem_e(tFIS_ECFADIC, 'NR_ECF', item_f('NR_ECF', tFIS_ECF));
    retrieve_e(tFIS_ECFADIC);
    if (xStatus >= 0) then begin
      if (item_f('NR_VIACARNE', tFIS_ECFADIC) > 0) then begin
        gNrViasEcfTermica := item_f('NR_VIACARNE', tFIS_ECFADIC);
      end;
      if (item_b('IN_CORTEVIA', tFIS_ECFADIC) = True) then begin
        vInCorteVia := True;
      end else begin
        vInCorteVia := False;
      end;
      if (item_f('NR_LINHACORTE', tFIS_ECFADIC) > 0) then begin
        vNrLinhasCorte := item_f('NR_LINHACORTE', tFIS_ECFADIC);
      end else begin
        vNrLinhasCorte := 0;
      end;
    end;

    repeat
      vDsConteudo := DsLstCupomVinculado;
      length vDsConteudo;
      while(gresult > 0) do begin
        scan vDsConteudo, '';
        if (gresult > 0) then begin
          vDsLinha := vDsConteudo[1, gresult - 1];
          vDsConteudo := vDsConteudo[gresult + 1];
        end else begin
          vDsLinha := vDsConteudo;
          vDsConteudo := '';
        end;

        voParams := imprimeCupomVinculado(viParams); (* vDsLinha, vNrLinhasCorte *)
        if (xStatus < 0) then begin
          Result := voParams;
          return(-1); exit;
        end;
        length vDsConteudo;
      end;
      if (vNrCopia >= gNrViasEcfTermica) then begin
        gDsCupom := '' + gDsCupom + '023';
      end else begin

        vNrVia := vNrCopia + 1;

        vNrLinhaCorteAtual := vNrLinhasCorte;
        if (vNrLinhaCorteAtual > 0) then begin
          while (vNrLinhaCorteAtual > 1) do begin
            gDsCupom := '' + gDsCupom + '022';
            vNrLinhaCorteAtual := vNrLinhaCorteAtual - 1;
          end;
        end;
        if (vInCorteVia = True) then begin
          gDsCupom := '' + gDsCupom + '131';
        end;

        gDsCupom := '' + gDsCupom + '022' + FloatToStr(vNrViaª) + ' VIA';

      end;

      vNrCopia := vNrCopia + 1;
    until (vNrCopia > gNrViasEcfTermica);
  end;
  if (gPadraoEcf = <PADRAO_LOCALIMPFIM>) then begin
    viParams := '';
    putitemXml(viParams, 'DS_TEXTO', gDsCupom);
    putitemXml(viParams, 'IN_IMPRIMEVIA', True);
    voParams := activateCmp('ECFSVCO001', 'ImprimirVinculado', viParams); (*,,, *)
    if (xStatus < 0) then begin
      Result := voParams;
      return(-1); exit;
    end;
  end;
  if (gPadraoEcf <> <PADRAO_LOCALIMPFIM>) then begin
    viParams := '';
    putitemXml(viParams, 'DS_CUPOM', gDsCupom);
    voParams := activateCmp('ECFSVCO001', 'FechaVinculado', viParams); (*,,, *)
    if (xStatus < 0) then begin
      Result := voParams;
      return(-1); exit;
    end;
  end;
  gDsCupom := '';

  return(0); exit;
end;

//-------------------------------------------------------------------------
function T_ECFSVCO010.reimpressaoCupomVinculado(pParams : String) : String;
//-------------------------------------------------------------------------
const
  cDS_METHOD = 'ADICIONAL=Operação: T_ECFSVCO010.reimpressaoCupomVinculado()';
var
  (* string vDsTexto : IN *)
  viParams, voParams, vDsConteudo, vDsLinha : String;
  vStatus : Real;
begin
  viParams := '';
  voParams := activateCmp('ECFSVCO001', 'FechaVinculado', viParams); (*,,, *)
  if (xStatus < 0) then begin
    Result := voParams;
    return(-1); exit;
  end;

  vDsConteudo := vDsTexto;
  length vDsConteudo;
  while(gresult > 0) do begin
    scan vDsConteudo, '';
    if (gresult > 0) then begin
      vDsLinha := vDsConteudo[1, gresult - 1];
      vDsConteudo := vDsConteudo[gresult + 1];
    end else begin
      vDsLinha := vDsConteudo;
      vDsConteudo := '';
    end;

    viParams := '';
    putitemXml(viParams, 'DS_TEXTO', vDsLinha);
    voParams := activateCmp('ECFSVCO001', 'ImprimirRelatorioGerencial', viParams); (*,,, *)
    if (xStatus < 0) then begin
      Result := voParams;
      return(-1); exit;
    end;

    length vDsConteudo;
  end;

  viParams := '';
  voParams := activateCmp('ECFSVCO001', 'FechaRelatorioGerencial', viParams); (*,,, *)
  if (xStatus < 0) then begin
    Result := voParams;
    return(-1); exit;
  end;

  return(0); exit;
end;

//---------------------------------------------------------------------
function T_ECFSVCO010.imprimeCupomVinculado(pParams : String) : String;
//---------------------------------------------------------------------
const
  cDS_METHOD = 'ADICIONAL=Operação: T_ECFSVCO010.imprimeCupomVinculado()';
var
  (* string DsLstCupomVinculado : IN / numeric vNrLinhasCorte : IN *)
  vDsRegistro, viParams, voParams, vDsCupom : String;
  vStatus, vTamanho, vContador : Real;
  vInCorteVia : Boolean;
begin
  repeat
    getitem(vDsRegistro, DsLstCupomVinculado, 1);
    viParams := '';
    putitemXml(viParams, 'DS_TEXTO', vDsRegistro);
    if (gPadraoEcf <> <PADRAO_LOCALIMPFIM>) then begin
      voParams := activateCmp('ECFSVCO001', 'ImprimirVinculado', viParams); (*,,, *)
      if (xStatus < 0) then begin
        Result := voParams;
        return(-1); exit;
      end;
    end else begin

      scan vDsRegistro, '[BARRA]';
      if (gresult > 0) then begin
        vTamanho := glength(vDsRegistro);
        vDsCupom := '135' + vDsRegistro[ + '8, vTamanho]';
      end else begin

        scan vDsRegistro, '[CORTE]';
        if (gresult > 0) then begin
          vContador := 1;
          while (vContador <= vNrLinhasCorte) do begin
            vDsCupom := '' + vDsCupom + '022';
            vContador := vContador + 1;
          end;
          vDsCupom := '' + vDsCupom + '131';
          vDsCupom := '' + vDsCupom + '022';
        end else begin
          vDsCupom := '022' + vDsRegistro' + ';
        end;
      end;
      if (vInCorteVia = True) then begin
        gDsCupom := '' + gDsCupom + '022022131';
      end else begin
        gDsCupom := '' + gDsCupom' + vDsCupom' + ' + ';
      end;
    end;

    delitem(DsLstCupomVinculado, 1);
  until(DsLstCupomVinculado = '');

  return(0); exit;

end;

//-----------------------------------------------------------
function T_ECFSVCO010.cancelaItem(pParams : String) : String;
//-----------------------------------------------------------
const
  cDS_METHOD = 'ADICIONAL=Operação: T_ECFSVCO010.cancelaItem()';
var
  viParams, voParams : String;
  vNrItem, vCdEmpTra, vNrTransacao : Real;
  vDtTransacao : TDate;
  vStatus : Real;
begin
  vCdEmpTra := itemXmlF('CD_EMPRESA', pParams);
  if (vCdEmpTra = 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Empresa da transação não informada!', cDS_METHOD);
    return(-1); exit;
  end;

  vNrTransacao := itemXmlF('NR_TRANSACAO', pParams);
  if (vNrTransacao = 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Numero da transação não informado!', cDS_METHOD);
    return(-1); exit;
  end;

  vDtTransacao := itemXml('DT_TRANSACAO', pParams);
  if (vDtTransacao = 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Data da transação não informada!', cDS_METHOD);
    return(-1); exit;
  end;

  vNrItem= itemXmlF('NR_ITEM', pParams);
  if (vNrItem = 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Número do item não informado!', cDS_METHOD);
    return(-1); exit;
  end;

  clear_e(tTRA_TRANSACAO);
  putitem_e(tTRA_TRANSACAO, 'CD_EMPRESA', vCdEmpTra);
  putitem_e(tTRA_TRANSACAO, 'NR_TRANSACAO', vNrTransacao);
  putitem_e(tTRA_TRANSACAO, 'DT_TRANSACAO', vDtTransacao);
  retrieve_e(tTRA_TRANSACAO);
  if (xStatus < 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Transação ' + FloatToStr(vNrTransacao) + ' não encontrada!', cDS_METHOD);
    return(-1); exit;
  end;

  viParams := '';
  putitemXml(viParams, 'NR_ITEM', vNrItem);
  voParams := activateCmp('ECFSVCO001', 'cancelaItem', viParams); (*,,, *)
  if (xStatus < 0) then begin
    Result := voParams;
    return(-1); exit;
  end;

  return(0); exit;
end;

//----------------------------------------------------------------------
function T_ECFSVCO010.validaImpressoraFiscal(pParams : String) : String;
//----------------------------------------------------------------------
const
  cDS_METHOD = 'ADICIONAL=Operação: T_ECFSVCO010.validaImpressoraFiscal()';
var
  viParams, voParams, vDsSerie : String;
  vStatus, vCdGrupoEmpresa : Real;
begin
  vDsSerie := itemXmlF('NR_SERIE', pParams);
  if (vDsSerie = '') then begin
    viParams := '';
    putitemXml(viParams, 'NM_FUNCAO', <ECF_NUMERO_SERIE>);
    voParams := activateCmp('ECFSVCO001', 'leInformacaoImpressora', viParams); (*,,, *)
    if (xStatus < 0) then begin
      Result := voParams;
      return(-1); exit;
    end;

    vDsSerie := itemXmlF('NR_SERIE', voParams);
    if (vDsSerie = '') then begin
      Result := SetStatus(STS_ERROR, 'GEN0001', 'Não foi possível obter número de série!', cDS_METHOD);
      return(-1); exit;
    end;
  end;
  clear_e(tFIS_ECF);
  putitem_e(tFIS_ECF, 'CD_SERIEFAB', vDsSerie);
  retrieve_e(tFIS_ECF);
  if (xStatus < 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Número de série ' + vDsSerie + ' não cadastrado p/ ECF!', cDS_METHOD);
    return(-1); exit;
  end;

  viParams := '';
  putitemXml(viParams, 'CD_EMPRESA', item_f('CD_EMPRESA', tFIS_ECF));
  voParams := activateCmp('GERSVCO032', 'buscaDadosEmpresa', viParams); (*,,,, *)
  if (xStatus < 0) then begin
    Result := voParams;
    return(-1); exit;
  end;

  vCdGrupoEmpresa := itemXmlF('CD_GRUPOEMPRESA', voParams);

  if (vCdGrupoEmpresa = '') then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Empresa da ECF não encontrada!', cDS_METHOD);
    return(-1); exit;
  end else begin
    if (vCdGrupoEmpresa <> itemXmlF('CD_GRUPOEMPRESA', PARAM_GLB)) then begin
      Result := SetStatus(STS_ERROR, 'GEN0001', 'Empresa da ECF não pertence a esse grupo empresa!', cDS_METHOD);
      return(-1); exit;
    end;
  end;

  return(0); exit;
end;

end.
