unit cFGRFM001;

interface

(* COMPONENTES 
  ADMSVCO001 / FGRSVCO002 / FGRSVCO003 / 
*)        

uses
  Classes, SysUtils, Math, DB,
  cServiceUnf, cDataSetUnf;

type
  T_FGRFM001 = class(TcServiceUnf)
  private
    tF_FCR_CHEQUE,
    tF_FCR_FATURAI,
    tGER_BANCO,
    tGER_EMPRESA,
    tGER_POOLGRUPOEMP,
    tPES_PESSOACC,
    tSIS_BOTOES,
    tSIS_DUMMY,
    tV_PES_CLIENTE : TcDatasetUnf;
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
    function validaBanco(pParams : String = '') : String;
    function validaCampos(pParams : String = '') : String;
    function validaBanda(pParams : String = '') : String;
    function valorPadrao(pParams : String = '') : String;
    function processaCheque(pParams : String = '') : String;
    function leCheque(pParams : String = '') : String;
    function validarChequeProprio(pParams : String = '') : String;
    function validarCheque(pParams : String = '') : String;
  end;

implementation

uses
  cADMSVCO001,
  cActivate, cStatus, cFuncao, cXml, dModulo;

var
  gCdCliente,
  gCdClientePdv,
  gCpfCnpj,
  gDsNominalChqEnt,
  gDsUltimaConta,
  gDtVencimento,
  gInPdvOtimizado,
  gInRecebChqProprio,
  gInSomenteBanda,
  gLstEmpresa,
  gNrAgencia,
  gNrBanco,
  gNrBanda,
  gNrCheque,
  gNrConta,
  gNrTelefone,
  gNrUltimaAgencia,
  gNrUltimoBanco,
  gNrUltimoCheque,
  gTpNominalCheque,
  gVlCheque : String;

//---------------------------------------------------------------
constructor T_FGRFM001.Create(AOwner: TComponent);
//---------------------------------------------------------------
begin
  inherited Create(AOwner);
  setEntidade('');
end;

//--------------------------------
destructor T_FGRFM001.Destroy;
//--------------------------------
begin
  inherited Destroy;
end;

//---------------------------------------------------------------
function T_FGRFM001.getParam(pParams : String = '') : String;
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
  putitem(xParam, 'CD_CLIENTE');
  putitem(xParam, 'CLIENTE_PDV');
  putitem(xParam, 'DT_VENCIMENTO');
  putitem(xParam, 'IN_TERCEIRO');
  putitem(xParam, 'NR_AGENCIA');
  putitem(xParam, 'NR_BANCO');
  putitem(xParam, 'NR_BANDA');
  putitem(xParam, 'NR_CHEQUE');
  putitem(xParam, 'NR_CONTA');
  putitem(xParam, 'NR_CPFCNPJ');
  putitem(xParam, 'NR_TELEFONE');

  xParam := T_ADMSVCO001.GetParametro(xParam);

  gCdClientePdv := itemXml('CLIENTE_PDV', xParam);
  gInPdvOtimizado := itemXml('IN_PDV_OTIMIZADO', xParam);
  gInRecebChqProprio := itemXml('IN_RECEB_CHQ_PROPRIO', xParam);
  gInSomenteBanda := itemXml('IN_UTILIZA_APENAS_BANDA', xParam);
  gprompt := itemXml('NR_BANCO', xParam);

  xParamEmp := '';
  putitem(xParamEmp, 'CD_CLIENTE');
  putitem(xParamEmp, 'CLIENTE_PDV');
  putitem(xParamEmp, 'DS_NOMINAL_CHQ_ENT');
  putitem(xParamEmp, 'DT_VENCIMENTO');
  putitem(xParamEmp, 'IN_DATAHORA_VERSO_CHEQUE');
  putitem(xParamEmp, 'IN_PDV_OTIMIZADO');
  putitem(xParamEmp, 'IN_RECEB_CHQ_PROPRIO');
  putitem(xParamEmp, 'IN_TERCEIRO');
  putitem(xParamEmp, 'IN_UTILIZA_APENAS_BANDA');
  putitem(xParamEmp, 'NR_AGENCIA');
  putitem(xParamEmp, 'NR_BANCO');
  putitem(xParamEmp, 'NR_BANDA');
  putitem(xParamEmp, 'NR_CHEQUE');
  putitem(xParamEmp, 'NR_CONTA');
  putitem(xParamEmp, 'NR_CPFCNPJ');
  putitem(xParamEmp, 'NR_TELEFONE');
  putitem(xParamEmp, 'TP_NOMINAL_CHEQUE');

  xParamEmp := T_ADMSVCO001.GetParamEmpresa(piCdEmpresa, xParamEmp);

  gInPdvOtimizado := itemXml('IN_PDV_OTIMIZADO', xParamEmp);
  gInRecebChqProprio := itemXml('IN_RECEB_CHQ_PROPRIO', xParamEmp);
  gInSomenteBanda := itemXml('IN_UTILIZA_APENAS_BANDA', xParamEmp);
  gprompt := itemXml('CD_CLIENTE', xParamEmp);
  gprompt := itemXml('NR_BANCO', xParamEmp);

end;

//---------------------------------------------------------------
function T_FGRFM001.setEntidade(pParams : String = '') : String;
//---------------------------------------------------------------
begin
  tF_FCR_CHEQUE := GetEntidade('F_FCR_CHEQUE');
  tF_FCR_FATURAI := GetEntidade('F_FCR_FATURAI');
  tGER_BANCO := GetEntidade('GER_BANCO');
  tGER_EMPRESA := GetEntidade('GER_EMPRESA');
  tGER_POOLGRUPOEMP := GetEntidade('GER_POOLGRUPOEMP');
  tPES_PESSOACC := GetEntidade('PES_PESSOACC');
  tSIS_BOTOES := GetEntidade('SIS_BOTOES');
  tSIS_DUMMY := GetEntidade('SIS_DUMMY');
  tV_PES_CLIENTE := GetEntidade('V_PES_CLIENTE');
end;

//-----------------------------------------------------
function T_FGRFM001.preEDIT(pParams : String) : String;
//-----------------------------------------------------
begin
  gVlCheque := itemXmlF('VL_CHEQUE', viParams);
  gNrBanco := itemXmlF('NR_BANCO', viParams);
  gNrAgencia := itemXmlF('NR_AGENCIA', viParams);
  gNrConta := itemXmlF('NR_CONTA', viParams);
  gNrCheque := itemXmlF('NR_CHEQUE', viParams);
  gNrBanda := itemXmlF('NR_BANDA', viParams);
  gDtVencimento := itemXml('DT_VENCIMENTO', viParams);
  gNrTelefone := itemXmlF('NR_TELEFONE', viParams);
  gCpfCnpj := itemXmlF('NR_CPFCNPJ', viParams);
  gNrUltimoBanco := itemXmlF('NR_ULTIMOBANCO', viParams);
  gNrUltimaAgencia := itemXmlF('NR_ULTIMAAGENCIA', viParams);
  gDsUltimaConta := itemXml('DS_ULTIMACONTA', viParams);
  gNrUltimoCheque := itemXmlF('NR_ULTIMOCHEQUE', viParams);
  gCdCliente := itemXmlF('CD_CLIENTE', viParams);

  voParams := valorPadrao(viParams); (* *)
  if (xStatus < 0) then begin
    Result := voParams;
    return(-1); exit;
  end;
  if (itemXml('IN_endOSSO', viParams)=True) then begin
    gprompt := item_f('NR_BANDA', tSIS_DUMMY);
  end;

  return(0); exit;
end;

//-----------------------------------------------------
function T_FGRFM001.posEDIT(pParams : String) : String;
//-----------------------------------------------------
begin
  putitemXml(voParams, 'NR_BANCO', item_f('NR_BANCO', tSIS_DUMMY));
  putitemXml(voParams, 'NR_AGENCIA', item_f('NR_AGENCIA', tSIS_DUMMY));
  putitemXml(voParams, 'NR_CONTA', item_f('NR_CONTA', tSIS_DUMMY));
  putitemXml(voParams, 'NR_CHEQUE', item_f('NR_CHEQUE', tSIS_DUMMY));
  putitemXml(voParams, 'NR_BANDA', item_f('NR_BANDA', tSIS_DUMMY));
  putitemXml(voParams, 'DT_VENCIMENTO', item_a('DT_VENCIMENTO', tSIS_DUMMY));
  putitemXml(voParams, 'NR_CPFCNPJ', item_f('NR_CPFCNPJ', tSIS_DUMMY));
  putitemXml(voParams, 'NR_TELEFONE', item_f('NR_TELEFONE', tSIS_DUMMY));
  putitemXml(voParams, 'CD_CLIENTE', item_f('CD_CLIENTE', tV_PES_CLIENTE));
  putitemXml(voParams, 'IN_TERCEIRO', item_b('IN_CHQTERCEIRO', tSIS_DUMMY));

  return(0); exit;
end;

//--------------------------------------------------
function T_FGRFM001.INIT(pParams : String) : String;
//--------------------------------------------------
begin
  _Caption := '' + FGRFM + '001 - Entrada de Cheque';

  putitem(xParam,  'CLIENTE_PDV');
  xParam := T_ADMSVCO001.GetParametro(xParam); (*xParam,xParam,, *)
  gCdClientePdv := itemXml('CLIENTE_PDV', xParam);

  xParamEmp := '';
  putitem(xParamEmp,  'IN_UTILIZA_APENAS_BANDA');
  putitem(xParamEmp,  'IN_DATAHORA_VERSO_CHEQUE');
  putitem(xParamEmp,  'IN_PDV_OTIMIZADO');
  putitem(xParamEmp,  'DS_NOMINAL_CHQ_ENT');
  putitem(xParamEmp,  'TP_NOMINAL_CHEQUE');
  putitem(xParamEmp,  'IN_RECEB_CHQ_PROPRIO');

  xParamEmp := T_ADMSVCO001.GetParamEmpresa(piCdEmpresa, xParamEmp); (*itemXml('CD_EMPRESA', *)

  gInSomenteBanda := itemXmlB('IN_UTILIZA_APENAS_BANDA', xParamEmp);
  gInPdvOtimizado := itemXmlB('IN_PDV_OTIMIZADO', xParamEmp);
  gDsNominalChqEnt= itemXml('DS_NOMINAL_CHQ_ENT', xParamEmp);

  gTpNominalCheque= itemXmlF('TP_NOMINAL_CHEQUE', xParamEmp);

  gInRecebChqProprio := itemXmlB('IN_RECEB_CHQ_PROPRIO', xParamEmp);

  return(0); exit;
end;

//---------------------------------------------------------
function T_FGRFM001.validaBanco(pParams : String) : String;
//---------------------------------------------------------
begin
  clear_e(tGER_BANCO);
  if (item_f('NR_BANCO', tSIS_DUMMY) > 0) then begin
    putitem_e(tGER_BANCO, 'NR_BANCO', item_f('NR_BANCO', tSIS_DUMMY));
    retrieve_e(tGER_BANCO);
    if (xStatus <0) then begin
      askmess 'Banco não cadastrado!', 'Continua, Cancelar';
      if (xStatus = 2) then begin
        gprompt := item_f('NR_BANCO', tSIS_DUMMY);
      end;
    end else begin
      putitem_e(tSIS_DUMMY, 'DS_BANCO', item_a('NM_BANCO', tGER_BANCO));
    end;
  end;

  return(0); exit;
end;

//----------------------------------------------------------
function T_FGRFM001.validaCampos(pParams : String) : String;
//----------------------------------------------------------

var
  vDtSistema : TDate;
begin
  vDtSistema := itemXml('DT_SISTEMA', PARAM_GLB);
  if (itemXml('IN_RECEBIMENTO', viParams) = True) then begin
    vDtSistema := itemXml('DT_PAGAMENTO', viParams);
  end;
  if (item_f('CD_CLIENTE', tSIS_DUMMY) = 0)  and (itemXml('IN_endOSSO', viParams) <> True) then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', , cDS_METHOD);
    gprompt := item_f('CD_CLIENTE', tSIS_DUMMY);
    return(-1); exit;
  end;
  if (item_f('NR_BANCO', tSIS_DUMMY) = 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', , cDS_METHOD);
    gprompt := item_f('NR_BANCO', tSIS_DUMMY);
    return(-1); exit;
  end;
  if (item_f('NR_AGENCIA', tSIS_DUMMY) = 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', , cDS_METHOD);
    gprompt := item_f('NR_AGENCIA', tSIS_DUMMY);
    return(-1); exit;
  end;
  if (item_f('NR_CONTA', tSIS_DUMMY) = 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', , cDS_METHOD);
    gprompt := item_f('NR_CONTA', tSIS_DUMMY);
    return(-1); exit;
  end;
  if (item_f('NR_CHEQUE', tSIS_DUMMY) = 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', , cDS_METHOD);
    gprompt := item_f('NR_CHEQUE', tSIS_DUMMY);
    return(-1); exit;
  end;
  if (item_a('DT_VENCIMENTO', tSIS_DUMMY) = '') then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', , cDS_METHOD);
    gprompt := item_a('DT_VENCIMENTO', tSIS_DUMMY);
    return(-1); exit;
  end;
  if (item_a('DT_VENCIMENTO', tSIS_DUMMY) < vDtSistema) then begin
    if (itemXml('IN_RECEBIMENTO', viParams) = True) then begin
      Result := SetStatus(STS_AVISO, 'GEN001', , cDS_METHOD);
    end else begin
      Result := SetStatus(STS_ERROR, 'GEN0001', , cDS_METHOD);
    end;
    gprompt := item_a('DT_VENCIMENTO', tSIS_DUMMY);
    return(-1); exit;
  end;
  if (item_b('IN_BLOQUEADO', tV_PES_CLIENTE) = True)  and (itemXml('IN_RECEBIMENTO', viParams) <> True) then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', , cDS_METHOD);
    return(-1); exit;
  end;
  if (item_b('IN_INATIVO', tV_PES_CLIENTE) = True)  and (itemXml('IN_RECEBIMENTO', viParams) <> True) then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', , cDS_METHOD);
    return(-1); exit;
  end;
  if (gInPdvOtimizado = True) then begin
    if (gCdclientePdv = item_f('CD_CLIENTE', tSIS_DUMMY)) then begin
      Result := SetStatus(STS_ERROR, 'GEN0001', , cDS_METHOD);
      gprompt := item_f('CD_CLIENTE', tSIS_DUMMY);
      return(-1); exit;
    end;
  end;

  voParams := validarChequeProprio(viParams); (* *)
  if (xStatus < 0) then begin
    Result := voParams;
    return(-1); exit;
  end;

  return(0); exit;
end;

//---------------------------------------------------------
function T_FGRFM001.validaBanda(pParams : String) : String;
//---------------------------------------------------------

var
  viParams, voParams : String;
begin
  if (item_f('NR_BANDA', tSIS_DUMMY) = '') then begin
    return(0); exit;
  end;

  viParams := '';
  putitemXml(viParams, 'NR_BANDA', item_f('NR_BANDA', tSIS_DUMMY));

  if (itemXml('IN_SOMENTE_CONSULTA', viParams) = True) then begin
    putitemXml(viParams, 'IN_VALIDACADASTRO', False);
  end else begin
    putitemXml(viParams, 'IN_VALIDACADASTRO', True);
  end;
  voParams := activateCmp('FGRSVCO002', 'validaBandaCheque', viParams); (*,viParams,voParams,, *)
  if (xStatus < 0) then begin
    Result := voParams;
    return(-1); exit;
  end;
    return(-1); exit;
  end;

  putitem_e(tSIS_DUMMY, 'NR_BANDA', itemXmlF('NR_BANDA', voParams));
  putitem_e(tSIS_DUMMY, 'NR_BANCO', itemXmlF('NR_BANCO', voParams));
  putitem_e(tSIS_DUMMY, 'NR_AGENCIA', itemXmlF('NR_AGENCIA', voParams));
  putitem_e(tSIS_DUMMY, 'NR_CONTA', itemXmlF('NR_CONTA', voParams));
  putitem_e(tSIS_DUMMY, 'NR_CHEQUE', itemXmlF('NR_CHEQUE', voParams));

  return(0); exit;
end;

//---------------------------------------------------------
function T_FGRFM001.valorPadrao(pParams : String) : String;
//---------------------------------------------------------

var
  vDsLstDocumento : String;
  vNrDocumento : Real;
begin
  if (itemXml('IN_endOSSO', viParams)<>True) then begin
    clear_e(tV_PES_CLIENTE);
    putitem_e(tV_PES_CLIENTE, 'CD_CLIENTE', gCdCliente);
    retrieve_e(tV_PES_CLIENTE);
  end;
  if (gInPdvOtimizado = 1) then begin
    fieldsyntax item_f('CD_CLIENTE', tSIS_DUMMY), '';
    fieldsyntax item_a('BT_LPESSOA', tV_PES_CLIENTE), '';
  end else begin
    fieldsyntax item_f('CD_CLIENTE', tSIS_DUMMY), 'DIM';
    fieldsyntax item_a('BT_LPESSOA', tV_PES_CLIENTE), 'DIM';
  end;
  if (itemXml('IN_endOSSO', viParams)=True) then begin
    fieldsyntax item_f('CD_CLIENTE', tSIS_DUMMY), 'DIM';
    fieldsyntax item_a('BT_LPESSOA', tV_PES_CLIENTE), 'DIM';
  end;

  putitem_e(tSIS_DUMMY, 'CD_CLIENTE', gCdCliente);
  putitem_e(tSIS_DUMMY, 'VL_CHEQUE', gVlCheque);
  putitem_e(tSIS_DUMMY, 'NR_BANDA', gNrBanda);
  putitem_e(tSIS_DUMMY, 'NR_BANCO', gNrBanco);
  putitem_e(tSIS_DUMMY, 'NR_AGENCIA', gNrAgencia);
  putitem_e(tSIS_DUMMY, 'NR_CONTA', gNrConta);
  putitem_e(tSIS_DUMMY, 'NR_CHEQUE', gNrCheque);
  putitem_e(tSIS_DUMMY, 'NR_TELEFONE', gNrTelefone);
  putitem_e(tSIS_DUMMY, 'NR_CPFCNPJ', gCpfCnpj);
  putitem_e(tSIS_DUMMY, 'IN_CHQTERCEIRO', itemXmlB('IN_TERCEIRO', viParams));

  if (gDtVencimento = '') then begin
    putitem_e(tSIS_DUMMY, 'DT_VENCIMENTO', itemXml('DT_SISTEMA', PARAM_GLB));

  end else begin
    putitem_e(tSIS_DUMMY, 'DT_VENCIMENTO', gDtVencimento);

  end;
  if (gInSomenteBanda = True) then begin
    fieldsyntax item_f('NR_BANCO', tSIS_DUMMY), 'DIM';
    fieldsyntax item_f('NR_AGENCIA', tSIS_DUMMY), 'DIM';
    fieldsyntax item_f('NR_CONTA', tSIS_DUMMY), 'DIM';
    fieldsyntax item_f('NR_CHEQUE', tSIS_DUMMY), 'DIM';
  end else begin
    fieldsyntax item_f('NR_BANCO', tSIS_DUMMY), '';
    fieldsyntax item_f('NR_AGENCIA', tSIS_DUMMY), '';
    fieldsyntax item_f('NR_CONTA', tSIS_DUMMY), '';
    fieldsyntax item_f('NR_CHEQUE', tSIS_DUMMY), '';

    if (item_f('NR_BANCO', tSIS_DUMMY) = 0)  and (gNrUltimoBanco > 0) then begin
      putitem_e(tSIS_DUMMY, 'NR_BANCO', gNrUltimoBanco);
    end;
    if (item_f('NR_AGENCIA', tSIS_DUMMY) = 0)  and (gNrUltimaAgencia > 0) then begin
      putitem_e(tSIS_DUMMY, 'NR_AGENCIA', gNrUltimaAgencia);
    end;
    if (item_f('NR_CONTA', tSIS_DUMMY) = '')  and (gDsUltimaConta > 0) then begin
      putitem_e(tSIS_DUMMY, 'NR_CONTA', gDsUltimaConta);
    end;
    if (item_f('NR_CHEQUE', tSIS_DUMMY) = 0)  and (gNrUltimoCheque > 0) then begin
      putitem_e(tSIS_DUMMY, 'NR_CHEQUE', gNrUltimoCheque + 1);
    end;
  end;
  if (gInPdvOtimizado = 1) then begin
    gprompt := item_f('CD_CLIENTE', tSIS_DUMMY);
  end else begin
    gprompt := item_a('DT_VENCIMENTO', tSIS_DUMMY);
  end;
  if (itemXml('IN_NAO_ALTERA', viParams) = True) then begin
    fieldsyntax item_f('CD_CLIENTE', tSIS_DUMMY), 'DIM';
    fieldsyntax item_a('BT_LPESSOA', tV_PES_CLIENTE), 'DIM';
    gprompt := item_a('DT_VENCIMENTO', tSIS_DUMMY);
  end;
  if (itemXml('IN_LOTE_CHEQUE', viParams) = True) then begin
    fieldsyntax item_a('DT_VENCIMENTO', tSIS_DUMMY), 'DIM';
  end else begin
    fieldsyntax item_a('DT_VENCIMENTO', tSIS_DUMMY), '';
  end;

  return(0); exit;
end;

//------------------------------------------------------------
function T_FGRFM001.processaCheque(pParams : String) : String;
//------------------------------------------------------------

var
  viParams, voParams, vDsParamTransacao, vDsParamNF, vDsVerso : String;
  vInDataHora : Real;
  vDtSistema : TDate;
begin
  vInDataHora := itemXmlB('IN_DATAHORA_VERSO_CHEQUE', xParamEmp);

  vDsVerso := '';
  if (vInDataHora = 1) then begin
    vDtSistema := Date;
    vTmSistema := gclock;
    vDsVerso := '' + vDtSistema[D]/' + vDtSistema[M]/' + vDtSistema[Y] + ' + ' + ' ' + vTmSistema[H]:' + vTmSistema[N]:' + vTmSistema[S]' + ' + ' + ';
  end;

  viParams := vDsParamNF;
  putitemXml(viParams, 'VL_CHEQUE', item_f('VL_CHEQUE', tSIS_DUMMY));
  putitemXml(viParams, 'NR_BANCO', item_f('NR_BANCO', tSIS_DUMMY));
  putitemXml(viParams, 'DT_VENCIMENTO', item_a('DT_VENCIMENTO', tSIS_DUMMY));
  putitemXml(viParams, 'NR_CHEQUE', item_f('NR_CHEQUE', tSIS_DUMMY));
  putitemXml(viParams, 'TP_CHEQUE', 'CR');
  putitemXml(viParams, 'DS_VERSO', vDsVerso);

  if (gDsNominalChqEnt <> '' ) and (gCdCliente <> '') then begin
    if (gTpNominalCheque = True) then begin
      putitemXml(viParams, 'DS_NOMINAL', '' + gDsNominalChqEnt') + ';
    end else begin

      putitemXml(viParams, 'DS_NOMINAL', '' + gDsNominalChqEnt + ' - ' + FloatToStr(gCdCliente')) + ';
    end;
  end else begin
    putitemXml(viParams, 'DS_NOMINAL', gDsNominalChqEnt);
  end;

  voParams := activateCmp('FGRSVCO003', 'processaCheque', viParams); (*,viParams,voParams,, *)
  if (xStatus < 0) then begin
    Result := voParams;
    return(-1); exit;
  end;
  if (itemXml('DS_CMC7', voParams) <> '') then begin
    putitem_e(tSIS_DUMMY, 'NR_BANDA', itemXml('DS_CMC7', voParams));
  end;

  voParams := validaBanda(viParams); (* *)

  if (xStatus < 0) then begin
    return(-1); exit;
  end;

  gprompt := item_a('BT_CONFIRMA', tSIS_BOTOES);

  return(0); exit;
end;

//------------------------------------------------------
function T_FGRFM001.leCheque(pParams : String) : String;
//------------------------------------------------------

var
  viParams, voParams, vDsParamTransacao, vDsParamNF : String;
begin
  viParams := '';
  voParams := activateCmp('FGRSVCO003', 'leCheque', viParams); (*,viParams,voParams,, *)
  if (xStatus < 0) then begin
    Result := voParams;
    return(-1); exit;
  end;

  putitem_e(tSIS_DUMMY, 'NR_BANDA', itemXml('DS_CMC7', voParams));

  voParams := validaBanda(viParams); (* *)

  if (xStatus < 0) then begin
    return(-1); exit;
  end;

  gprompt := item_a('BT_CONFIRMA', tSIS_BOTOES);

  return(0); exit;
end;

//------------------------------------------------------------------
function T_FGRFM001.validarChequeProprio(pParams : String) : String;
//------------------------------------------------------------------
begin
  if (gInRecebChqProprio <> True) then begin
    return(0); exit;
  end;

  clear_e(tPES_PESSOACC);
  putitem_e(tPES_PESSOACC, 'CD_PESSOA', item_f('CD_CLIENTE', tSIS_DUMMY));
  putitem_e(tPES_PESSOACC, 'NR_BANCO', item_f('NR_BANCO', tSIS_DUMMY));
  putitem_e(tPES_PESSOACC, 'NR_AGENCIA', item_f('NR_AGENCIA', tSIS_DUMMY));
  putitem_e(tPES_PESSOACC, 'DS_CONTA', item_f('NR_CONTA', tSIS_DUMMY));
  retrieve_e(tPES_PESSOACC);
  if (xStatus < 0) then begin
    Result := SetStatus(STS_AVISO, 'GEN001', , cDS_METHOD);
    gprompt := item_f('NR_BANDA', tSIS_DUMMY);
    return(-1); exit;
  end;

  return(0); exit;
end;

//-----------------------------------------------------------
function T_FGRFM001.validarCheque(pParams : String) : String;
//-----------------------------------------------------------

var
  vCdEmpresa : Real;
begin
  if (itemXml('IN_VALIDACHEQUE', viParams) <> True) then begin
    return(0); exit;
  end;
  if (gModulo.gCdPoolEmpresa > 0) then begin
    clear_e(tGER_POOLGRUPOEMP);
    putitem_e(tGER_POOLGRUPOEMP, 'CD_POOLEMPRESA', gModulo.gCdPoolEmpresa);
    retrieve_e(tGER_POOLGRUPOEMP);
    if (xStatus >= 0) then begin
      setocc(tGER_POOLGRUPOEMP, 1);
      while (xStatus >= 0) do begin

        clear_e(tGER_EMPRESA);
        putitem_e(tGER_EMPRESA, 'CD_GRUPOEMPRESA', item_f('CD_GRUPOEMPRESA', tGER_POOLGRUPOEMP));
        retrieve_e(tGER_EMPRESA);
        if (xStatus >= 0) then begin
          setocc(tGER_EMPRESA, 1);
          while (xStatus >= 0) do begin

            vCdEmpresa := item_f('CD_EMPRESA', tGER_EMPRESA);

            if (gLstEmpresa = '') then begin
              gLstEmpresa := vCdEmpresa;
            end else begin
              gLstEmpresa := '' + gLstEmpresa + ';
            end;

            setocc(tGER_EMPRESA, curocc(tGER_EMPRESA) + 1);
          end;
        end;

        setocc(tGER_POOLGRUPOEMP, curocc(tGER_POOLGRUPOEMP) + 1);
      end;
    end;
  end;
  if (item_f('NR_BANDA', tSIS_DUMMY) <> '') then begin
    clear_e(tF_FCR_CHEQUE);
    putitem_e(tF_FCR_CHEQUE, 'DS_BANDA', item_f('NR_BANDA', tSIS_DUMMY)[1:30]);
    if (gLstEmpresa <> '') then begin
      putitem_e(tF_FCR_CHEQUE, 'CD_EMPRESA', gLstEmpresa);
    end;
    retrieve_e(tF_FCR_CHEQUE);
    if (xStatus >= 0) then begin
      Result := SetStatus(STS_ERROR, 'GEN0001', 'Banda magnética do cheque já foi informada para outro cheque!(Empresa=' + CD_EMPRESA + '.F_FCR_CHEQUE Cliente=' + CD_CLIENTE + '.F_FCR_CHEQUE Fatura=' + NR_FAT + '.F_FCR_CHEQUE Parcela=' + NR_PARCELA + '.F_FCR_CHEQUE)', cDS_METHOD);
      return(-1); exit;
    end;
  end;

  clear_e(tF_FCR_CHEQUE);
  putitem_e(tF_FCR_CHEQUE, 'NR_BANCO', item_f('NR_BANCO', tSIS_DUMMY));
  putitem_e(tF_FCR_CHEQUE, 'NR_AGENCIA', item_f('NR_AGENCIA', tSIS_DUMMY));
  putitem_e(tF_FCR_CHEQUE, 'DS_CONTA', item_f('NR_CONTA', tSIS_DUMMY));
  putitem_e(tF_FCR_CHEQUE, 'NR_CHEQUE', item_f('NR_CHEQUE', tSIS_DUMMY));
  retrieve_e(tF_FCR_CHEQUE);
  if (xStatus >= 0) then begin
    setocc(tF_FCR_CHEQUE, 1);
    while (xStatus >= 0) do begin

      clear_e(tF_FCR_FATURAI);
      putitem_e(tF_FCR_FATURAI, 'CD_EMPRESA', item_f('CD_EMPRESA', tF_FCR_CHEQUE));
      putitem_e(tF_FCR_FATURAI, 'CD_CLIENTE', item_f('CD_CLIENTE', tF_FCR_CHEQUE));
      putitem_e(tF_FCR_FATURAI, 'NR_FAT', item_f('NR_FAT', tF_FCR_CHEQUE));
      putitem_e(tF_FCR_FATURAI, 'NR_PARCELA', item_f('NR_PARCELA', tF_FCR_CHEQUE));
      retrieve_e(tF_FCR_FATURAI);
      if (xStatus >= 0)  and (item_f('TP_SITUACAO', tF_FCR_FATURAI) = 1) then begin
        Result := SetStatus(STS_ERROR, 'GEN0001', , cDS_METHOD);
        return(-1); exit;
      end;

      setocc(tF_FCR_CHEQUE, curocc(tF_FCR_CHEQUE) + 1);
    end;
  end;

  return(0); exit;
end;

end.
