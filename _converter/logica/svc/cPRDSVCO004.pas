unit cPRDSVCO004;

interface

(* COMPONENTES 
  ADMSVCO001 / GERSVCO001 / GERSVCO009 / GERSVCO053 / PRDSVCO014
  PRDSVCO020 / 
*)        

uses
  Classes, SysUtils, Math, DB,
  cServiceUnf, cDataSetUnf;

type
  T_PRDSVCO004 = class(TcServiceUnf)
  private
    tF_TMP_NR09,
    tGER_CONTILOTE,
    tGER_EMPRESA,
    tGER_OPERACAO,
    tGER_OPERSALDO,
    tGER_OPERSALDOSVC 0 AND %\ THEN BEGIN,
    tGER_OPERVALOR,
    tGER_OPERVALORSVC 0 AND %\ THEN BEGIN,
    tGTT_PROD,
    tPRD_ALTVALOR,
    tPRD_ALTVALORSVCSALVAR;,
    tPRD_CFGNIVELI,
    tPRD_CODIGOBAR,
    tPRD_CORINFO,
    tPRD_EMBALAGEM,
    tPRD_GRUPO,
    tPRD_KARDEX,
    tPRD_KARDEXSVCSALVAR;,
    tPRD_KARDEXVAL,
    tPRD_KARDEXVALSVCSALVAR;,
    tPRD_KITC,
    tPRD_KITI,
    tPRD_PRDBLOQUE,
    tPRD_PRDGRADE,
    tPRD_PRDINFO,
    tPRD_PRDSALDO,
    tPRD_PRDSALDOSVCSALVAR;,
    tPRD_PRODUTO,
    tPRD_TIPOCLAS,
    tPRD_TIPOSALDO,
    tPRD_TIPOVALOR,
    tPRD_VALOR,
    tPRD_VALORSVCSALVAR;,
    tSIS_NIVEL,
    tSIS_PRDHIST,
    tTMP_NR09 : TcDatasetUnf;
    function getParam(pParams : String = '') : String;
    function setEntidade(pParams : String = '') : String;
  protected
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;    
  published
    function preencheZero(pParams : String = '') : String;
    function ProcImplantacao(pParams : String = '') : String;
    function ProcAltValor(pParams : String = '') : String;
    function ProcCorrecao(pParams : String = '') : String;
    function GetSdoAnterior(pParams : String = '') : String;
    function GetSdoAtual(pParams : String = '') : String;
    function validaProduto(pParams : String = '') : String;
    function GetSdoKardex(pParams : String = '') : String;
    function achaNovoCdProduto(pParams : String = '') : String;
    function achaNovoCdSeqGrupo(pParams : String = '') : String;
    function verificaProduto(pParams : String = '') : String;
    function carregaDadosGrupo(pParams : String = '') : String;
    function formataCodigoGrupo(pParams : String = '') : String;
    function achaNovoCdKit(pParams : String = '') : String;
    function carregaDadosCor(pParams : String = '') : String;
    function buscaNivelGrupo(pParams : String = '') : String;
    function buscaDadosProduto(pParams : String = '') : String;
    function buscaDiasRessupri(pParams : String = '') : String;
    function gravaGttProd(pParams : String = '') : String;
  end;

implementation

uses
  cADMSVCO001,
  cActivate, cStatus, cFuncao, cXml, dModulo;

var
  gCdCfgNivel,
  gCdCorPadrao,
  gCdEmpresaPadrao,
  gCdEmpresaValorEmp,
  gCdEmpresaValorSis,
  gCdGradePadrao,
  gDsLstNivelDescGrupo,
  gDsLstNivelGrupo,
  gDsLstTamGrupo,
  gDsPrefixoKit,
  gDsSeparadorPrefixoBar,
  gDsSepNrSeqBarraPRD,
  gInCadastroFixo,
  gInCdBarraColcci,
  gInPdvOtimizado,
  gInSeqPrdSeparado,
  glength(vCdBarraPrd) >= 28 and,
  gNrPosicaoFim,
  gNrPosicaoIni,
  gTpBarraLote,
  gTpValidaFatPrdBloq : String;

//---------------------------------------------------------------
constructor T_PRDSVCO004.Create(AOwner: TComponent);
//---------------------------------------------------------------
begin
  inherited Create(AOwner);
  setEntidade('');
end;

//--------------------------------
destructor T_PRDSVCO004.Destroy;
//--------------------------------
begin
  inherited Destroy;
end;

//---------------------------------------------------------------
function T_PRDSVCO004.getParam(pParams : String = '') : String;
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
  putitem(xParam, 'CD_COR_PADRAO');
  putitem(xParam, 'CD_EMPVALOR');
  putitem(xParam, 'CD_GRADE_PADRAO');
  putitem(xParam, 'DS_LST_NIVEL_DESC_GRUPO');
  putitem(xParam, 'DS_LST_NIVEL_GRUPO');
  putitem(xParam, 'DS_LST_TAM_numericO_GRUPO');
  putitem(xParam, 'DS_POS_INI_FIM_BARRA_PRD');
  putitem(xParam, 'DS_SEP_NRSEQ_BARRA_PRD');
  putitem(xParam, 'IN_CD_BARRA_COLCCI');
  putitem(xParam, 'IN_SEQPRD_SEPARADO_EMP');
  putitem(xParam, 'PRD_CFGNIVEL_GRUPO');

  xParam := T_ADMSVCO001.GetParametro(xParam);

  gCdCfgNivel := itemXml('PRD_CFGNIVEL_GRUPO', xParam);
  gCdCorPadrao := itemXml('CD_COR_PADRAO', xParam);
  gCdEmpresaValorSis := itemXml('CD_EMPRESA', xParam);
  gCdEmpresaValorSis := itemXml('CD_EMPVALOR', xParam);
  gCdGradePadrao := itemXml('CD_GRADE_PADRAO', xParam);
  gDsLstNivelDescGrupo := itemXml('DS_LST_NIVEL_DESC_GRUPO', xParam);
  gDsLstNivelGrupo := itemXml('DS_LST_NIVEL_GRUPO', xParam);
  gDsLstTamGrupo := itemXml('DS_LST_TAM_numericO_GRUPO', xParam);
  gDsSepNrSeqBarraPRD := itemXml('DS_SEP_NRSEQ_BARRA_PRD', xParam);
  gInCdBarraColcci := itemXml('IN_CD_BARRA_COLCCI', xParam);
  gInSeqPrdSeparado := itemXml('IN_SEQPRD_SEPARADO_EMP', xParam);
  vDsPosIniFim := itemXml('DS_POS_INI_FIM_BARRA_PRD', xParam);

  xParamEmp := '';
  putitem(xParamEmp, 'CD_EMP_PADRAO_PRD');
  putitem(xParamEmp, 'CD_EMPRESA_VALOR');
  putitem(xParamEmp, 'DS_PREFIXO_COD_KIT_PRD');
  putitem(xParamEmp, 'DS_SEPARADOR_PREFIXO_BAR');
  putitem(xParamEmp, 'IN_CADASTRO_FIXO');
  putitem(xParamEmp, 'IN_PDV_OTIMIZADO');
  putitem(xParamEmp, 'TP_LEITURA_BARRA_LOTE');
  putitem(xParamEmp, 'TP_VALIDA_FAT_PRD_BLOQ');

  xParamEmp := T_ADMSVCO001.GetParamEmpresa(piCdEmpresa, xParamEmp);

  gCdEmpresaPadrao := itemXml('CD_EMP_PADRAO_PRD', xParamEmp);
  gCdEmpresaValorEmp := itemXml('CD_EMPRESA_VALOR', xParamEmp);
  gDsPrefixoKit := itemXml('DS_PREFIXO_COD_KIT_PRD', xParamEmp);
  gDsSeparadorPrefixoBar := itemXml('DS_SEPARADOR_PREFIXO_BAR', xParamEmp);
  gInCadastroFixo := itemXml('IN_CADASTRO_FIXO', xParamEmp);
  gInPdvOtimizado := itemXml('IN_PDV_OTIMIZADO', xParamEmp);
  gTpBarraLote := itemXml('TP_LEITURA_BARRA_LOTE', xParamEmp);
  gTpValidaFatPrdBloq := itemXml('TP_VALIDA_FAT_PRD_BLOQ', xParamEmp);

end;

//---------------------------------------------------------------
function T_PRDSVCO004.setEntidade(pParams : String = '') : String;
//---------------------------------------------------------------
begin
  tF_TMP_NR09 := GetEntidade('F_TMP_NR09');
  tGER_CONTILOTE := GetEntidade('GER_CONTILOTE');
  tGER_EMPRESA := GetEntidade('GER_EMPRESA');
  tGER_OPERACAO := GetEntidade('GER_OPERACAO');
  tGER_OPERSALDO := GetEntidade('GER_OPERSALDO');
  tGER_OPERSALDOSVC 0 AND %\ THEN BEGIN := GetEntidade('GER_OPERSALDOSVC 0 AND %\ THEN BEGIN');
  tGER_OPERVALOR := GetEntidade('GER_OPERVALOR');
  tGER_OPERVALORSVC 0 AND %\ THEN BEGIN := GetEntidade('GER_OPERVALORSVC 0 AND %\ THEN BEGIN');
  tGTT_PROD := GetEntidade('GTT_PROD');
  tPRD_ALTVALOR := GetEntidade('PRD_ALTVALOR');
  tPRD_ALTVALORSVCSALVAR; := GetEntidade('PRD_ALTVALORSVCSALVAR;');
  tPRD_CFGNIVELI := GetEntidade('PRD_CFGNIVELI');
  tPRD_CODIGOBAR := GetEntidade('PRD_CODIGOBAR');
  tPRD_CORINFO := GetEntidade('PRD_CORINFO');
  tPRD_EMBALAGEM := GetEntidade('PRD_EMBALAGEM');
  tPRD_GRUPO := GetEntidade('PRD_GRUPO');
  tPRD_KARDEX := GetEntidade('PRD_KARDEX');
  tPRD_KARDEXSVCSALVAR; := GetEntidade('PRD_KARDEXSVCSALVAR;');
  tPRD_KARDEXVAL := GetEntidade('PRD_KARDEXVAL');
  tPRD_KARDEXVALSVCSALVAR; := GetEntidade('PRD_KARDEXVALSVCSALVAR;');
  tPRD_KITC := GetEntidade('PRD_KITC');
  tPRD_KITI := GetEntidade('PRD_KITI');
  tPRD_PRDBLOQUE := GetEntidade('PRD_PRDBLOQUE');
  tPRD_PRDGRADE := GetEntidade('PRD_PRDGRADE');
  tPRD_PRDINFO := GetEntidade('PRD_PRDINFO');
  tPRD_PRDSALDO := GetEntidade('PRD_PRDSALDO');
  tPRD_PRDSALDOSVCSALVAR; := GetEntidade('PRD_PRDSALDOSVCSALVAR;');
  tPRD_PRODUTO := GetEntidade('PRD_PRODUTO');
  tPRD_TIPOCLAS := GetEntidade('PRD_TIPOCLAS');
  tPRD_TIPOSALDO := GetEntidade('PRD_TIPOSALDO');
  tPRD_TIPOVALOR := GetEntidade('PRD_TIPOVALOR');
  tPRD_VALOR := GetEntidade('PRD_VALOR');
  tPRD_VALORSVCSALVAR; := GetEntidade('PRD_VALORSVCSALVAR;');
  tSIS_NIVEL := GetEntidade('SIS_NIVEL');
  tSIS_PRDHIST := GetEntidade('SIS_PRDHIST');
  tTMP_NR09 := GetEntidade('TMP_NR09');
end;

//------------------------------------------------------------
function T_PRDSVCO004.preencheZero(pParams : String) : String;
//------------------------------------------------------------
const
  cDS_METHOD = 'ADICONAL=Operação: T_PRDSVCO004.preencheZero()';
begin
  poNumero := piNumero;
  length poNumero;
  while (gresult < piTamanho) do begin
    poNumero := '0' + poNumero' + ';
    length poNumero;
  end;
  if (gresult > piTamanho) then begin
    poNumero := poNumero[gresult - piTamanho + 1];
  end;

  return(0); exit;
end;

//---------------------------------------------------------------
function T_PRDSVCO004.ProcImplantacao(pParams : String) : String;
//---------------------------------------------------------------
const
  cDS_METHOD = 'ADICONAL=Operação: T_PRDSVCO004.ProcImplantacao()';
begin
var
  vCdEmpresa, vCdGrupoEmpresa, vCdOperador, vCdProduto, vCdValor, vNrSeq : Real;
  vInEstorno, vVlPreco, vVlCusto, vQtSaldo : Real;
  vListaParam, vGlobal : String;
  vDtSistema : TDate;
begin
  vInEstorno := 0;

  vCdEmpresa := itemXmlF('CD_EMPRESA', PARAM_GLB);
  vCdGrupoEmpresa := itemXmlF('CD_GRUPOEMPRESA', PARAM_GLB);
  vCdOperador := itemXmlF('CD_OPERADOR', pParams);
  vDtSistema := itemXml('DT_SISTEMA', pParams);
  vInEstorno := itemXmlB('IN_ESTORNO', pParams);
  vQtSaldo := itemXmlF('QT_SALDO', pParams);
  vVlPreco := itemXmlF('VL_PRECO', pParams);
  vVlCusto := itemXmlF('VL_CUSTO', pParams);
  if (vQtSaldo = '') then begin
    vQtSaldo := 0;
  end;
  if (vVlPreco = '') then begin
    vVlPreco := 0;
  end;
  if (vVlCusto = '') then begin
    vVlCusto := 0;
  end;

  clear_e(tGER_OPERACAO);
  putitem_e(tGER_OPERACAO, 'CD_OPERACAO', itemXmlF('CD_OPERACAO', pParams));
  retrieve_e(tGER_OPERACAO);
  if (xStatus < 0) then begin
    return(-1); exit;
  end;

  setocc(tGER_OPERSALDO, 1);
  if (gtotdbocc(tger_opersaldosvc) > 0)  and %\ then begin
  (item_b('IN_KARDEX', tGER_OPERACAO));

  clear_e(tSIS_PRDHIST);
  putitem_e(tSIS_PRDHIST, 'CD_HISTORICO', item_f('CD_HISTORICO', tGER_OPERSALDO));
  retrieve_e(tSIS_PRDHIST);
  if (xStatus < 0) then begin
    return(-1); exit;
  end;
  if (vInEstorno) then begin
    vQtSaldo := -1 * vQtSaldo;
  end;
  vCdProduto := itemXmlF('CD_PRODUTO', pParams);
  vCdOperador := itemXmlF('CD_OPERADOR', pParams);
  repeat

    clear_e(tPRD_TIPOSALDO);
    putitem_e(tPRD_TIPOSALDO, 'CD_SALDO', item_f('CD_SALDO', tGER_OPERSALDO));
    retrieve_e(tPRD_TIPOSALDO);
    if (xStatus < 0) then begin
      return(-1); exit;
    end;

    clear_e(tPRD_PRDSALDO);
    creocc(tPRD_PRDSALDO, -1);
    putitem_e(tPRD_PRDSALDO, 'CD_EMPRESA', vCdEmpresa);
    putitem_e(tPRD_PRDSALDO, 'CD_PRODUTO', vCdProduto);
    putitem_e(tPRD_PRDSALDO, 'CD_SALDO', item_f('CD_SALDO', tPRD_TIPOSALDO));
    putitem_e(tPRD_PRDSALDO, 'DT_SALDO', vDtSistema);
    retrieve_o(tPRD_PRDSALDO);
    if (xStatus = -7) then begin
      retrieve_x(tPRD_PRDSALDO);
    end;
    putitem_e(tPRD_PRDSALDO, 'CD_GRUPOEMPRESA', vCdGrupoEmpresa);
    putitem_e(tPRD_PRDSALDO, 'QT_SALDO', vQtSaldo);
    putitem_e(tPRD_PRDSALDO, 'CD_OPERADOR', vCdOperador);
    putitem_e(tPRD_PRDSALDO, 'DT_CADASTRO', Now);
    voParams := tPRD_PRDSALDOSVCSALVAR;.Salvar();
    if (xStatus < 0) then begin
      return(-1); exit;
    end;
    if (item_b('IN_GERAKARDEX', tGER_OPERSALDO) = 1) then begin
      vNrSeq := 0;

      voParams := activateCmp('GERSVCO009', 'GetSeqKardex', viParams);
      if (vNrSeq = 0) then begin
        return(-1); exit;
      end;

      clear_e(tPRD_KARDEX);
      creocc(tPRD_KARDEX, -1);
      putitem_e(tPRD_KARDEX, 'CD_EMPRESA', vCdEmpresa);
      putitem_e(tPRD_KARDEX, 'CD_PRODUTO', vCdProduto);
      putitem_e(tPRD_KARDEX, 'DT_MOVIMENTO', vDtSistema);
      putitem_e(tPRD_KARDEX, 'CD_SALDO', item_f('CD_SALDO', tGER_OPERSALDO));
      putitem_e(tPRD_KARDEX, 'NR_SEQUENCIA', vNrSeq);
      putitem_e(tPRD_KARDEX, 'CD_GRUPOEMPRESA', vCdGrupoEmpresa);
      putitem_e(tPRD_KARDEX, 'CD_HISTORICO', item_f('CD_HISTORICO', tGER_OPERSALDO));
      putitem_e(tPRD_KARDEX, 'IN_ESTORNO', vInEstorno);
      putitem_e(tPRD_KARDEX, 'CD_OPERADOR', vCdOperador);
      putitem_e(tPRD_KARDEX, 'DT_CADASTRO', Now);
      putitem_e(tPRD_KARDEX, 'NR_DCTOORIGEM', 1);
      putitem_e(tPRD_KARDEX, 'QT_MOVIMENTADA', vQtSaldo);
      voParams := tPRD_KARDEXSVCSALVAR;.Salvar();
      if (xStatus < 0) then begin
        return(-1); exit;
      end;
    end;

    setocc(tGER_OPERSALDO, curocc(tGER_OPERSALDO) + 1);
  until (xStatus <= 0);
end;
xStatus := 0;

setocc(tGER_OPERVALOR, 1);
if (gtotdbocc(tger_opervalorsvc) > 0)  and %\ then begin
(vInEstorno := 0);

repeat

  clear_e(tPRD_VALOR);
  creocc(tPRD_VALOR, -1);
  putitem_e(tPRD_VALOR, 'CD_EMPRESA', vCdEmpresa);
  putitem_e(tPRD_VALOR, 'CD_PRODUTO', vCdProduto);
  putitem_e(tPRD_VALOR, 'TP_VALOR', item_f('TP_UNIDVALOR', tGER_OPERVALOR));
  putitem_e(tPRD_VALOR, 'CD_VALOR', item_f('CD_UNIDVALOR', tGER_OPERVALOR));
  retrieve_o(tPRD_VALOR);
  if (xStatus = -7) then begin
    retrieve_x(tPRD_VALOR);
  end;
  putitem_e(tPRD_VALOR, 'CD_EMPRESA', vCdEmpresa);
  putitem_e(tPRD_VALOR, 'CD_PRODUTO', vCdProduto);
  putitem_e(tPRD_VALOR, 'TP_VALOR', item_f('TP_UNIDVALOR', tGER_OPERVALOR));
  putitem_e(tPRD_VALOR, 'CD_VALOR', item_f('CD_UNIDVALOR', tGER_OPERVALOR));
  putitem_e(tPRD_VALOR, 'CD_GRUPOEMPRESA', vCdGrupoEmpresa);
  if (item_f('TP_UNIDVALOR', tGER_OPERVALOR) = 'P') then begin
    putitem_e(tPRD_VALOR, 'VL_PRODUTO', vVlPreco);
  end else begin
    putitem_e(tPRD_VALOR, 'VL_PRODUTO', vVlCusto);
  end;
  putitem_e(tPRD_VALOR, 'CD_OPERADOR', vCdOperador);
  putitem_e(tPRD_VALOR, 'DT_CADASTRO', Now);
  voParams := tPRD_VALORSVCSALVAR;.Salvar();

  if (xStatus < 0) then begin
    return(-1); exit;
  end;
  if (vNrSeq <> '') then begin
  end else begin
    vNrSeq := 0;
    voParams := activateCmp('GERSVCO009', 'GetSeqKardex', viParams);
    if (vNrSeq = 0) then begin
      return(-1); exit;
    end;
  end;
  if (item_f('TP_UNIDVALOR', tGER_OPERVALOR) = 'P') then begin
    clear_e(tPRD_TIPOVALOR);
    putitem_e(tPRD_TIPOVALOR, 'CD_VALOR', item_f('CD_UNIDVALOR', tGER_OPERVALOR));
    putitem_e(tPRD_TIPOVALOR, 'TP_VALOR', 'P');
    retrieve_e(tPRD_TIPOVALOR);
    if (xStatus < 0) then begin
      return(-1); exit;
    end;

    clear_e(tPRD_VALOR);
    putitem_e(tPRD_VALOR, 'CD_EMPRESA', vCdEmpresa);
    putitem_e(tPRD_VALOR, 'CD_PRODUTO', vCdProduto);
    putitem_e(tPRD_VALOR, 'CD_VALOR', item_f('CD_VALOR', tPRD_TIPOVALOR));
    putitem_e(tPRD_VALOR, 'TP_VALOR', 'P');
    retrieve_e(tPRD_VALOR);

    clear_e(tPRD_KARDEXVAL);
    creocc(tPRD_KARDEXVAL, -1);
    putitem_e(tPRD_KARDEXVAL, 'CD_EMPRESA', vCdEmpresa);
    putitem_e(tPRD_KARDEXVAL, 'CD_PRODUTO', vCdProduto);
    putitem_e(tPRD_KARDEXVAL, 'DT_MOVIMENTO', vDtSistema);
    putitem_e(tPRD_KARDEXVAL, 'NR_SEQUENCIA', vNrSeq);
    putitem_e(tPRD_KARDEXVAL, 'TP_VALOR', 'P');
    putitem_e(tPRD_KARDEXVAL, 'CD_VALOR', item_f('CD_VALOR', tPRD_TIPOVALOR));
    putitem_e(tPRD_KARDEXVAL, 'VL_VALOR', vVlPreco);
    putitem_e(tPRD_KARDEXVAL, 'CD_GRUPOEMPRESA', vCdGrupoEmpresa);
    putitem_e(tPRD_KARDEXVAL, 'CD_OPERADOR', vCdOperador);
    putitem_e(tPRD_KARDEXVAL, 'DT_CADASTRO', Now);
    voParams := tPRD_KARDEXVALSVCSALVAR;.Salvar();
    if (xStatus < 0) then begin
      return(-1); exit;
    end;
  end else begin

    clear_e(tPRD_TIPOVALOR);
    putitem_e(tPRD_TIPOVALOR, 'TP_VALOR', 'C');
    putitem_e(tPRD_TIPOVALOR, 'CD_VALOR', item_f('CD_UNIDVALOR', tGER_OPERVALOR));
    retrieve_e(tPRD_TIPOVALOR);
    if (xStatus < 0) then begin
      return(-1); exit;
    end;

    clear_e(tPRD_VALOR);
    putitem_e(tPRD_VALOR, 'CD_EMPRESA', vCdEmpresa);
    putitem_e(tPRD_VALOR, 'CD_PRODUTO', vCdProduto);
    putitem_e(tPRD_VALOR, 'TP_VALOR', 'C');
    putitem_e(tPRD_VALOR, 'CD_VALOR', item_f('CD_VALOR', tPRD_TIPOVALOR));
    retrieve_e(tPRD_VALOR);

    clear_e(tPRD_KARDEXVAL);
    creocc(tPRD_KARDEXVAL, -1);
    putitem_e(tPRD_KARDEXVAL, 'CD_EMPRESA', vCdEmpresa);
    putitem_e(tPRD_KARDEXVAL, 'CD_PRODUTO', vCdProduto);
    putitem_e(tPRD_KARDEXVAL, 'DT_MOVIMENTO', vDtSistema);
    putitem_e(tPRD_KARDEXVAL, 'NR_SEQUENCIA', vNrSeq);
    putitem_e(tPRD_KARDEXVAL, 'TP_VALOR', 'C');
    putitem_e(tPRD_KARDEXVAL, 'CD_VALOR', item_f('CD_VALOR', tPRD_TIPOVALOR));
    putitem_e(tPRD_KARDEXVAL, 'CD_GRUPOEMPRESA', vCdGrupoEmpresa);
    putitem_e(tPRD_KARDEXVAL, 'VL_VALOR', vVlCusto);
    putitem_e(tPRD_KARDEXVAL, 'CD_OPERADOR', vCdOperador);
    putitem_e(tPRD_KARDEXVAL, 'DT_CADASTRO', Now);
    voParams := tPRD_KARDEXVALSVCSALVAR;.Salvar();
    if (xStatus < 0) then begin
      return(-1); exit;
    end;
  end;

  setocc(tGER_OPERVALOR, curocc(tGER_OPERVALOR) + 1);
until (xStatus <= 0);
end;

return(0); exit;

end;

//------------------------------------------------------------
function T_PRDSVCO004.ProcAltValor(pParams : String) : String;
//------------------------------------------------------------
const
  cDS_METHOD = 'ADICONAL=Operação: T_PRDSVCO004.ProcAltValor()';
begin
var
  vCdEmpresa,vCdValor,vCdProduto,vNrSeq : Real;
  vTpValor : String;
  vDtSistema : TDate;
begin
  vCdEmpresa := itemXmlF('CD_EMPRESA', PARAM_GLB);
  vDtSistema := itemXml('DT_SISTEMA', pParams);
  vTpValor := itemXmlF('TP_VALOR', pParams);
  vCdValor := itemXmlF('CD_VALOR', pParams);
  vCdProduto := itemXmlF('CD_PRODUTO', pParams);

  clear_e(tPRD_ALTVALOR);
  creocc(tPRD_ALTVALOR, -1);

  vNrSeq := 0;
  voParams := activateCmp('GERSVCO009', 'GetSeqValor', viParams);
  if (vNrSeq = 0) then begin
    return(-1); exit;
  end;
  putitem_e(tPRD_ALTVALOR, 'CD_EMPRESA', vCdEmpresa);
  putitem_e(tPRD_ALTVALOR, 'CD_PRODUTO', vCdProduto);
  putitem_e(tPRD_ALTVALOR, 'TP_VALOR', vTpValor);
  putitem_e(tPRD_ALTVALOR, 'CD_VALOR', vCdValor);
  putitem_e(tPRD_ALTVALOR, 'DT_MOVIMENTO', vDtSistema);
  putitem_e(tPRD_ALTVALOR, 'NR_SEQUENCIA', vNrSeq);
  putitem_e(tPRD_ALTVALOR, 'CD_MOTIVO', itemXmlF('CD_MOTIVOALT', pParams));
  putitem_e(tPRD_ALTVALOR, 'CD_GRUPOEMPRESA', itemXmlF('CD_GRUPOEMPRESA', PARAM_GLB));
  putitem_e(tPRD_ALTVALOR, 'CD_OPERADOR', itemXmlF('CD_OPERADOR', pParams));
  putitem_e(tPRD_ALTVALOR, 'VL_ANTERIOR', itemXmlF('VL_PRECO', pParams));
  putitem_e(tPRD_ALTVALOR, 'DT_CADASTRO', Now);
  voParams := tPRD_ALTVALORSVCSALVAR;.Salvar();
  if (xStatus < 0) then begin
    return(-1); exit;
  end;
  return(0); exit;

end;

//------------------------------------------------------------
function T_PRDSVCO004.ProcCorrecao(pParams : String) : String;
//------------------------------------------------------------
const
  cDS_METHOD = 'ADICONAL=Operação: T_PRDSVCO004.ProcCorrecao()';
begin
var
  vCdEmpresa,vCdGrupoEmpresa,vCdOperador,vCdProduto,vCdValor,vNrSeq,vValor,vCdMotivoAlt : Real;
  vGlobal,vTpValor : String;
  vDtSistema : TDate;
begin
  vCdEmpresa := itemXmlF('CD_EMPRESA', PARAM_GLB);
  vCdGrupoEmpresa := itemXmlF('CD_GRUPOEMPRESA', PARAM_GLB);
  vCdOperador := itemXmlF('CD_OPERADOR', pParams);
  vDtSistema := itemXml('DT_SISTEMA', pParams);
  vTpValor := itemXmlF('TP_VALOR', pParams);
  vCdValor := itemXmlF('CD_VALOR', pParams);
  vValor := itemXmlF('VL_PRECO', pParams);
  vCdMotivoAlt := itemXmlF('CD_MOTIVOALT', pParams);
  vCdProduto := itemXmlF('CD_PRODUTO', pParams);

  clear_e(tPRD_ALTVALOR);
  creocc(tPRD_ALTVALOR, -1);

  vNrSeq := 0;
  voParams := activateCmp('GERSVCO009', 'GetSeqValor', viParams);
  if (vNrSeq = 0) then begin
    return(-1); exit;
  end;
  putitem_e(tPRD_ALTVALOR, 'CD_EMPRESA', vCdEmpresa);
  putitem_e(tPRD_ALTVALOR, 'CD_PRODUTO', vCdProduto);
  putitem_e(tPRD_ALTVALOR, 'TP_VALOR', vTpValor);
  putitem_e(tPRD_ALTVALOR, 'CD_VALOR', vCdValor);
  putitem_e(tPRD_ALTVALOR, 'DT_MOVIMENTO', vDtSistema);
  putitem_e(tPRD_ALTVALOR, 'NR_SEQUENCIA', vNrSeq);
  putitem_e(tPRD_ALTVALOR, 'CD_MOTIVO', vCdMotivoAlt);
  putitem_e(tPRD_ALTVALOR, 'CD_GRUPOEMPRESA', vCdGrupoEmpresa);
  putitem_e(tPRD_ALTVALOR, 'CD_OPERADOR', vCdOperador);
  putitem_e(tPRD_ALTVALOR, 'VL_ANTERIOR', vValor);
  putitem_e(tPRD_ALTVALOR, 'DT_CADASTRO', Now);
  voParams := tPRD_ALTVALORSVCSALVAR;.Salvar();
  if (xStatus < 0) then begin
    return(-1); exit;
  end;
  return(0); exit;

end;

//--------------------------------------------------------------
function T_PRDSVCO004.GetSdoAnterior(pParams : String) : String;
//--------------------------------------------------------------
const
  cDS_METHOD = 'ADICONAL=Operação: T_PRDSVCO004.GetSdoAnterior()';
var
  vCdGrupoEmpresa,vCdProduto,vCdSaldo,vQtSaldo,vCdEmpresa, vNr : Real;
  vDtSaldo,vDtSaldoEstoque,vDtMovimento : TDate;
begin
  vCdEmpresa := Result;
  vCdGrupoEmpresa := itemXmlF('CD_GRUPOEMPRESA', pParams);
  vCdProduto := itemXmlF('CD_PRODUTO', pParams);
  vCdSaldo := itemXmlF('CD_SALDO', pParams);
  vDtSaldo := itemXml('DT_SALDO', pParams);
  if (vDtSaldo = '') then begin
    vDtSaldo := itemXml('DT_SISTEMA', PARAM_GLB);
  end;
  vNr := itemXmlF('NR_USUARIOS', PARAM_GLB);
  vDtSaldoEstoque := 0;
  vDtMovimento := 0;
  vQtSaldo := 0;

  clear_e(tGER_EMPRESA);
  if (vCdEmpresa = '') then begin
    putitem_e(tGER_EMPRESA, 'CD_GRUPOEMPRESA', vCdGrupoEmpresa);
  end else begin
    putitem_e(tGER_EMPRESA, 'CD_EMPRESA', vCdEmpresa);
  end;
  retrieve_e(tGER_EMPRESA);
  if (!xProcerror) then begin
    setocc(tGER_EMPRESA, 1);
    repeat
      select max(dt_saldo) 
      from 'PRD_PRDSALDOSVC' 
      where (putitem_e(tPRD_PRDSALDO, 'CD_EMPRESA', item_f('CD_EMPRESA', tGER_EMPRESA) ) and (
      putitem_e(tPRD_PRDSALDO, 'CD_PRODUTO', vCdProduto ) and (
      putitem_e(tPRD_PRDSALDO, 'CD_SALDO', vCdSaldo   ) and (
      item_a('DT_SALDO', tPRD_PRDSALDO)   < vDtSaldo)
      to vDtSaldoEstoque;
      clear_e(tPRD_PRDSALDO);
      if (vDtSaldoEstoque <> 0) then begin
        putitem_e(tPRD_PRDSALDO, 'CD_EMPRESA', item_f('CD_EMPRESA', tGER_EMPRESA));
        putitem_e(tPRD_PRDSALDO, 'CD_PRODUTO', vCdProduto);
        putitem_e(tPRD_PRDSALDO, 'CD_SALDO', vCdSaldo);
        putitem_e(tPRD_PRDSALDO, 'DT_SALDO', vDtSaldoEstoque);
        retrieve_e(tPRD_PRDSALDO);
        if (xStatus = 0) then begin
          vQtSaldo := vQtSaldo + item_f('QT_SALDO', tPRD_PRDSALDO);
        end;
      end;
      setocc(tGER_EMPRESA, curocc(tGER_EMPRESA) + 1);
    until (xStatus <=0);
  end;
  Result := '';
  putitemXml(Result, 'DT_SALDO', vDtSaldoEstoque);
  putitemXml(Result, 'QT_SALDO', vQtSaldo);

  return(0); exit;

end;

//-----------------------------------------------------------
function T_PRDSVCO004.GetSdoAtual(pParams : String) : String;
//-----------------------------------------------------------
const
  cDS_METHOD = 'ADICONAL=Operação: T_PRDSVCO004.GetSdoAtual()';
var
  vCdGrupoEmpresa,vCdProduto,vCdSaldo,vQtSaldo,vCdEmpresa, vNr : Real;
  vDtSaldo,vDtSaldoEstoque,vDtMovimento : TDate;
begin
  vCdEmpresa := Result;
  vCdGrupoEmpresa := itemXmlF('CD_GRUPOEMPRESA', pParams);
  vCdProduto := itemXmlF('CD_PRODUTO', pParams);
  vCdSaldo := itemXmlF('CD_SALDO', pParams);
  vDtSaldo := itemXml('DT_SALDO', pParams);
  if (vDtSaldo = '') then begin
    vDtSaldo := itemXml('DT_SISTEMA', PARAM_GLB);
  end;
  vNr := itemXmlF('NR_USUARIOS', PARAM_GLB);
  vDtSaldoEstoque := 0;
  vDtMovimento := 0;
  vQtSaldo := 0;

  clear_e(tGER_EMPRESA);
  if (vCdEmpresa = '') then begin
    putitem_e(tGER_EMPRESA, 'CD_GRUPOEMPRESA', vCdGrupoEmpresa);
  end else begin
    putitem_e(tGER_EMPRESA, 'CD_EMPRESA', vCdEmpresa);
  end;
  retrieve_e(tGER_EMPRESA);
  if (!xProcerror) then begin
    setocc(tGER_EMPRESA, 1);
    repeat
      select max(dt_saldo) 
      from 'PRD_PRDSALDOSVC' 
      where (putitem_e(tPRD_PRDSALDO, 'CD_EMPRESA', item_f('CD_EMPRESA', tGER_EMPRESA) ) and (
      putitem_e(tPRD_PRDSALDO, 'CD_PRODUTO', vCdProduto ) and (
      putitem_e(tPRD_PRDSALDO, 'CD_SALDO', vCdSaldo   ) and (
      item_a('DT_SALDO', tPRD_PRDSALDO)  <= vDtSaldo)
      to vDtSaldoEstoque;
      clear_e(tPRD_PRDSALDO);
      if (vDtSaldoEstoque <> 0) then begin
        putitem_e(tPRD_PRDSALDO, 'CD_EMPRESA', item_f('CD_EMPRESA', tGER_EMPRESA));
        putitem_e(tPRD_PRDSALDO, 'CD_PRODUTO', vCdProduto);
        putitem_e(tPRD_PRDSALDO, 'CD_SALDO', vCdSaldo);
        putitem_e(tPRD_PRDSALDO, 'DT_SALDO', vDtSaldoEstoque);
        retrieve_e(tPRD_PRDSALDO);
        if (xStatus = 0) then begin
          vQtSaldo := vQtSaldo + item_f('QT_SALDO', tPRD_PRDSALDO);
        end;
      end;
      setocc(tGER_EMPRESA, curocc(tGER_EMPRESA) + 1);
    until (xStatus <=0);
  end;
  Result := '';
  putitemXml(Result, 'DT_SALDO', vDtSaldoEstoque);
  putitemXml(Result, 'QT_SALDO', vQtSaldo);

  return(0); exit;

end;

//-------------------------------------------------------------
function T_PRDSVCO004.validaProduto(pParams : String) : String;
//-------------------------------------------------------------
const
  cDS_METHOD = 'ADICONAL=Operação: T_PRDSVCO004.validaProduto()';
begin
  clear_e(tPRD_PRODUTO);
  clear_e(tPRD_CODIGOBAR);
  poCdProduto := '';

  if (piInCodigo = True) then begin
    putitem_e(tPRD_PRODUTO, 'CD_PRODUTO', piCdBarra);
  end else begin
    putitem_e(tPRD_CODIGOBAR, 'CD_BARRAPRD', piCdBarra);
    retrieve_o(tPRD_CODIGOBAR);
    if (xStatus = -7) then begin
      retrieve_x(tPRD_CODIGOBAR);
    end else begin
      voParams := SetErroApl(viParams); (* 'ERRO=-1;
      return(0); exit;
    end;
    putitem_e(tPRD_PRODUTO, 'CD_PRODUTO', item_f('CD_PRODUTO', tPRD_CODIGOBAR));
  end;

  retrieve_o(tPRD_PRODUTO);
  if (xStatus = -7) then begin
    retrieve_x(tPRD_PRODUTO);
  end else begin
    voParams := SetErroApl(viParams); (* 'ERRO=-1;
    return(0); exit;
  end;

  poCdProduto := item_f('CD_PRODUTO', tPRD_PRODUTO);

  return(0); exit;
end;

//------------------------------------------------------------
function T_PRDSVCO004.GetSdoKardex(pParams : String) : String;
//------------------------------------------------------------
const
  cDS_METHOD = 'ADICONAL=Operação: T_PRDSVCO004.GetSdoKardex()';
var
  (* string piLstEmp :IN *)
  vCdGrupoEmpresa,vCdProduto,vCdSaldo,vQtSaldo,vCdEmpresa : Real;
  vDtSaldo,vDtSaldoEstoque : TDate;
begin
  vCdEmpresa := piLstEmp;
  vCdGrupoEmpresa := itemXmlF('CD_GRUPOEMPRESA', pParams);
  vCdProduto := itemXmlF('CD_PRODUTO', pParams);
  vCdSaldo := itemXmlF('CD_SALDO', pParams);
  vDtSaldo := itemXml('DT_SALDO', pParams);
  vDtSaldoEstoque := 0;
  vQtSaldo := 0;

  clear_e(tGER_EMPRESA);
  putitem_e(tGER_EMPRESA, 'CD_EMPRESA', vCdEmpresa);
  putitem_e(tGER_EMPRESA, 'CD_GRUPOEMPRESA', vCdGrupoEmpresa);
  retrieve_e(tGER_EMPRESA);
  if (!xProcerror) then begin
    setocc(tGER_EMPRESA, 1);
    repeat
      select max(dt_saldo) 
      from 'PRD_PRDSALDOSVC' 
      where (putitem_e(tPRD_PRDSALDO, 'CD_EMPRESA', item_f('CD_EMPRESA', tGER_EMPRESA) ) and (
      putitem_e(tPRD_PRDSALDO, 'CD_PRODUTO', vCdProduto ) and (
      putitem_e(tPRD_PRDSALDO, 'CD_SALDO', vCdSaldo   ) and (
      item_a('DT_SALDO', tPRD_PRDSALDO)   < vDtSaldo)
      to vDtSaldoEstoque;
      clear_e(tPRD_PRDSALDO);
      if (vDtSaldoEstoque <> 0) then begin
        putitem_e(tPRD_PRDSALDO, 'CD_EMPRESA', item_f('CD_EMPRESA', tGER_EMPRESA));
        putitem_e(tPRD_PRDSALDO, 'CD_PRODUTO', vCdProduto);
        putitem_e(tPRD_PRDSALDO, 'CD_SALDO', vCdSaldo);
        putitem_e(tPRD_PRDSALDO, 'DT_SALDO', vDtSaldoEstoque);
        retrieve_e(tPRD_PRDSALDO);
        if (xStatus = 0) then begin
          vQtSaldo := vQtSaldo + item_f('QT_SALDO', tPRD_PRDSALDO);
        end;
      end;
      setocc(tGER_EMPRESA, curocc(tGER_EMPRESA) + 1);
    until (xStatus <=0);
  end;

  Result='DT_SALDO=' + vDtSaldoEstoque + ';

  return(0); exit;
end;

//-----------------------------------------------------------------
function T_PRDSVCO004.achaNovoCdProduto(pParams : String) : String;
//-----------------------------------------------------------------
const
  cDS_METHOD = 'ADICONAL=Operação: T_PRDSVCO004.achaNovoCdProduto()';
var
  vCdProduto, vCdEmpresaParam : Real;
  vInSeqMP, vInSeqMc : Boolean;
  vTpSeq : String;
begin
  vInSeqMP := itemXmlB('IN_SEQMP', pParams);

  vInSeqMc := itemXmlB('IN_SEQMC', pParams);

  vCdEmpresaParam := itemXmlF('CD_EMPRESA', pParams);
  if (vCdEmpresaParam = 0) then begin
    vCdEmpresaParam := itemXmlF('CD_EMPRESA', PARAM_GLB);
  end;
  gInSeqPrdSeparado := itemXmlB('IN_SEQPRD_SEPARADO_EMP', pParams);

  if (gInSeqPrdSeparado = '') then begin
    getParams(pParams); (* vCdEmpresaParam *)
    if (xStatus < 0) then begin
      Result := voParams;
      return(-1); exit;
    end;
  end;
  if (vInSeqMP = True) then begin
    vTpSeq := 'PRD_PRODUTOMP';
  end else if (vInSeqMc = True) then begin
    vTpSeq := 'PRD_PRODUTOMC';
  end else begin
    vTpSeq := 'PRD_PRODUTO';
  end;

  vCdProduto := '';
  while (vCdProduto := '') do begin
    if (gInSeqPrdSeparado <> True) then begin
      newinstance 'GERSVCO001', 'GERSVCO001', 'TRANSACTION=TRUE';
      voParams := activateCmp('GERSVCO001', 'GetNumSeqComm', viParams);
      if (xStatus < 0) then begin
        Result := voParams;
        return(-1); exit;
      end;
    end else begin
      newinstance 'GERSVCO001', 'GERSVCO001', 'TRANSACTION=TRUE';
      voParams := activateCmp('GERSVCO001', 'GetNumSeqEmp', viParams);
      if (xStatus < 0) then begin
        Result := voParams;
        return(-1); exit;
      end;
    end;

    clear_e(tPRD_PRODUTO);
    putitem_e(tPRD_PRODUTO, 'CD_PRODUTO', vCdProduto);
    retrieve_e(tPRD_PRODUTO);
    if (xStatus >= 0) then begin
      vCdProduto := '';
    end;
  end;

  Result := '';
  putitemXml(Result, 'CD_PRODUTO', vCdProduto);

  return(0); exit;
end;

//------------------------------------------------------------------
function T_PRDSVCO004.achaNovoCdSeqGrupo(pParams : String) : String;
//------------------------------------------------------------------
const
  cDS_METHOD = 'ADICONAL=Operação: T_PRDSVCO004.achaNovoCdSeqGrupo()';
var
  vCdSeqGrupo : Real;
  vInSeqMP : Boolean;
  vTpSeq : String;
begin
  vInSeqMP := itemXmlB('IN_SEQMP', pParams);

  if (vInSeqMP = True) then begin
    vTpSeq := 'PRD_GRUPOMP';
  end else begin
    vTpSeq := 'PRD_GRUPO';
  end;

  vCdSeqGrupo := '';
  while (vCdSeqGrupo := '') do begin
    newinstance 'GERSVCO001', 'GERSVCO001', 'TRANSACTION=TRUE';
    voParams := activateCmp('GERSVCO001', 'GetNumSeqComm', viParams);
    if (xStatus < 0) then begin
      Result := voParams;
      return(-1); exit;
    end;
    clear_e(tPRD_GRUPO);
    putitem_e(tPRD_GRUPO, 'CD_SEQ', vCdSeqGrupo);
    retrieve_e(tPRD_GRUPO);
    if (xStatus >= 0) then begin
      vCdSeqGrupo := '';
    end;
  end;

  Result := '';
  putitemXml(Result, 'CD_SEQGRUPO', vCdSeqGrupo);

  return(0); exit;
end;

//---------------------------------------------------------------
function T_PRDSVCO004.verificaProduto(pParams : String) : String;
//---------------------------------------------------------------
const
  cDS_METHOD = 'ADICONAL=Operação: T_PRDSVCO004.verificaProduto()';
var
  vCdBarraPrd, vDsLstEmpresa, vDsLstEmp, vDsLinha, vDsLstProduto, viParams, voParams : String;
  vCdEmpresa, vCdEmpresaParam, vQtEmbalagem, vTpLote, vTpInspecao : Real;
  vInCodigo, vInProdAcabado, vInMatPrima, vInInativo, vInAchou : Boolean;
  vInBarraSeq, vInMatConsumo, vInProdutoBloq, vInPrdBloqueado, vInConsulta, vInQtLote : Boolean;
  vCdEmpLote, vNrLote, vNrItem, vQtLote, vCdProduto : Real;
  vPos : Real;
  vDsPrefixo, vCdBarraCont : String;
begin
  clear_e(tPRD_PRODUTO);
  clear_e(tPRD_CODIGOBAR);
  vQtEmbalagem := 1;

  vCdBarraPrd := itemXmlF('CD_BARRAPRD', pParams);
  vInCodigo := itemXmlB('IN_CODIGO', pParams);
  vInProdAcabado := itemXmlB('IN_PRODACABADO', pParams);
  vInMatPrima := itemXmlB('IN_MATPRIMA', pParams);
  vInMatConsumo := itemXmlB('IN_MATCONSUMO', pParams);
  vInInativo := itemXmlB('IN_INATIVO', pParams);

  vTpLote := itemXmlF('TP_LOTE', pParams);
  vTpInspecao := itemXmlF('TP_INSPECAO', pParams);

  vInProdutoBloq := itemXmlB('IN_PRODUTOBLOQ', pParams);

  vInConsulta := itemXmlB('IN_CONSULTA', pParams);

  vInQtLote := itemXmlB('IN_QTLOTE', pParams);
  if (vInQtLote = '') then begin
    vInQtLote := True;
  end;

  vCdEmpresaParam := itemXmlF('CD_EMPRESA', pParams);
  if (vCdEmpresaParam = 0) then begin
    vCdEmpresaParam := itemXmlF('CD_EMPRESA', PARAM_GLB);
  end;
  vInBarraSeq := False;

  getParams(pParams); (* vCdEmpresaParam *)
  if (xStatus < 0) then begin
    Result := voParams;
    return(-1); exit;
  end;
  if (vInCodigo = True) then begin
    length vCdBarraPrd;
    if (gresult > 9) then begin
      Result := SetStatus(STS_ERROR, 'GEN0001', , cDS_METHOD);
      return(-1); exit;
    end;
    putitem_e(tPRD_PRODUTO, 'CD_PRODUTO', vCdBarraPrd);
  end else begin

    vPos := 0;
    vDsPrefixo := '';
    vCdBarraCont := '';

    if (gDsSeparadorPrefixoBar <> '') then begin
      scan vCdBarraPrd, gDsSeparadorPrefixoBar;
      if (gresult > 0) then begin
        vPos := gresult;
        vDsPrefixo := vCdBarraPrd[1, (vPos-1)];
        vCdBarraCont := vCdBarraPrd[vPos+1];
      end;
    end;
    if (vDsPrefixo = 01) then begin
      viParams := '';
      putitemXml(viParams, 'DS_string', vCdBarraCont);
      voParams := activateCmp('GERSVCO053', 'validaContagem', viParams);
      if (xStatus < 0) then begin
        Result := voParams;
        return(-1); exit;
      end;

      Result := '';
      putitemXml(Result, 'CD_EMPCONTAGEM', itemXmlF('CD_EMPRESA', voParams));
      putitemXml(Result, 'NR_CONTAGEM', itemXmlF('NR_CONTAGEM', voParams));

      if (gTpBarraLote = 1) then begin
        clear_e(tGER_CONTILOTE);
        putitem_e(tGER_CONTILOTE, 'CD_EMPCONTAGEM', itemXmlF('CD_EMPRESA', voParams));
        putitem_e(tGER_CONTILOTE, 'NR_CONTAGEM', itemXmlF('NR_CONTAGEM', voParams));
        retrieve_e(tGER_CONTILOTE);
        if (xStatus >= 0) then begin
          setocc(tGER_CONTILOTE, -1);
          setocc(tGER_CONTILOTE, 1);
          while (xStatus >= 0) do begin
            viParams := '';
            putitemXml(viParams, 'CD_BARRA', item_f('CD_BARRALOTE', tGER_CONTILOTE));
            voParams := activateCmp('PRDSVCO020', 'validaLote', viParams);
            if (xStatus < 0) then begin
              Result := voParams;
              return(-1); exit;
            end;

            vCdProduto := itemXmlF('CD_PRODUTO', voParams);
            vQtLote := itemXmlF('QT_LOTE', voParams);
            vNrLote := itemXmlF('NR_LOTE', voParams);
            vNrItem := itemXmlF('NR_ITEM', voParams);

            if (vCdProduto > 0)  and (vQtLote = 0) then begin
              Result := SetStatus(STS_ERROR, 'GEN0001', , cDS_METHOD);
              return(-1); exit;
            end;
            setocc(tGER_CONTILOTE, curocc(tGER_CONTILOTE) + 1);
          end;
        end;
      end;

      return(0); exit;

    end else begin
      if (gInCdBarraColcci = True) then begin
        if (glength(vCdBarraPrd) = 10) then begin
          putitem_e(tPRD_CODIGOBAR, 'CD_BARRAPRD', vCdBarraPrd[1 : 10]);
        end else if (glength(vCdBarraPrd) = 20) then begin
          putitem_e(tPRD_CODIGOBAR, 'CD_BARRAPRD', vCdBarraPrd[3 : 10]);
        end else if (glength(vCdBarraPrd) = 15) then begin
          putitem_e(tPRD_CODIGOBAR, 'CD_BARRAPRD', vCdBarraPrd[1 : 15]);
        end else if (glength(vCdBarraPrd) = 13) then begin
          putitem_e(tPRD_CODIGOBAR, 'CD_BARRAPRD', vCdBarraPrd);
        end else if (glength(vCdBarraPrd) = 16) then begin
          putitem_e(tPRD_CODIGOBAR, 'CD_BARRAPRD', vCdBarraPrd[1 : 16]);
          retrieve_e(tPRD_CODIGOBAR);
          if (xStatus < 0) then begin
            clear_e(tPRD_CODIGOBAR);
            putitem_e(tPRD_CODIGOBAR, 'CD_BARRAPRD', vCdBarraPrd[1 : 7]);
          end else begin
            clear_e(tPRD_CODIGOBAR);
            putitem_e(tPRD_CODIGOBAR, 'CD_BARRAPRD', vCdBarraPrd[1 : 16]);
          end;
        end else if (glength(vCdBarraPrd) = 14) then begin
          putitem_e(tPRD_CODIGOBAR, 'CD_BARRAPRD', vCdBarraPrd);
          retrieve_e(tPRD_CODIGOBAR);
          if (xStatus < 0) then begin
            clear_e(tPRD_CODIGOBAR);
            putitem_e(tPRD_CODIGOBAR, 'CD_BARRAPRD', vCdBarraPrd[1 : 7]);
          end else begin
            clear_e(tPRD_CODIGOBAR);
            putitem_e(tPRD_CODIGOBAR, 'CD_BARRAPRD', vCdBarraPrd[1 : 14]);
          end;
        end else begin
          putitem_e(tPRD_CODIGOBAR, 'CD_BARRAPRD', vCdBarraPrd[1 : 7]);
        end;
      end else if (gTpBarraLote = 1 ) and (vInConsulta = True  and (glength(vCdBarraPrd) >= 28 ) and (length(vCdBarraPrd) <= 30)) then begin
        clear_e(tPRD_CODIGOBAR);
        putitem_e(tPRD_CODIGOBAR, 'CD_BARRAPRD', vCdBarraPrd[1 : 13]);

      end else if (gDsSepNrSeqBarraPRD <> '') then begin
        scan vCdBarraPrd, gDsSepNrSeqBarraPRD;
        if (gresult > 0) then begin
          vCdBarraPrd := vCdBarraPrd[1 : gresult - 1];
          vInBarraSeq := True;
        end;
        putitem_e(tPRD_CODIGOBAR, 'CD_BARRAPRD', vCdBarraPrd);
      end else begin
        putitem_e(tPRD_CODIGOBAR, 'CD_BARRAPRD', vCdBarraPrd);
      end;
      retrieve_e(tPRD_CODIGOBAR);
      if (xStatus < 0) then begin
        if (gNrPosicaoIni > 0 ) and (gNrPosicaoFim > 0)  and (vInBarraSeq = False)  and (vCdBarraPrd[gNrPosicaoIni, gNrPosicaoFim] <> '') then begin
          putitem_e(tPRD_CODIGOBAR, 'CD_BARRAPRD', vCdBarraPrd[gNrPosicaoIni, gNrPosicaoFim]);
          retrieve_e(tPRD_CODIGOBAR);
          if (xStatus < 0) then begin
            clear_e(tPRD_KITC);
            putitem_e(tPRD_KITC, 'CD_KIT', vCdBarraPrd);
            retrieve_e(tPRD_KITC);
            if (xStatus < 0) then begin
                viParams := '';
                putitemXml(viParams, 'CD_BARRA', vCdBarraPrd);
                voParams := activateCmp('PRDSVCO020', 'validaLote', viParams);
                if (xStatus < 0) then begin
                  Result := voParams;
                  return(-1); exit;
                end;

                vCdEmpLote := itemXmlF('CD_EMPRESA', voParams);
                vNrLote := itemXmlF('NR_LOTE', voParams);
                vNrItem := itemXmlF('NR_ITEM', voParams);
                vQtLote := itemXmlF('QT_LOTE', voParams);
                vCdProduto := itemXmlF('CD_PRODUTO', voParams);

                vDsLinha := '';
                putitemXml(vDsLinha, 'CD_PRODUTO', vCdProduto);
                putitemXml(vDsLinha, 'QT_PRODUTO', vQtLote);
                putitemXml(vDsLinha, 'CD_EMPLOTE', vCdEmpLote);
                putitemXml(vDsLinha, 'NR_LOTE', vNrLote);
                putitemXml(vDsLinha, 'NR_ITEM', vNrItem);
                putitem(vDsLstProduto,  vDsLinha);
                if (vCdProduto > 0)  and (vQtLote > 0 ) or (vInQtLote = False) then begin
                  putitem_e(tPRD_PRODUTO, 'CD_PRODUTO', vCdProduto);
                  vQtEmbalagem := vQtLote;
                end else begin
                  Result := SetStatus(STS_ERROR, 'GEN0001', , cDS_METHOD);
                  return(-1); exit;
                end;

            end else begin
              setocc(tPRD_KITI, 1);
              putitem_e(tPRD_PRODUTO, 'CD_PRODUTO', item_f('CD_PRODUTO', tPRD_KITI));
              vQtEmbalagem := item_f('QT_PRODUTO', tPRD_KITI);
              setocc(tPRD_KITI, 1);
              while (xStatus >= 0) do begin
                vDsLinha := '';
                putitemXml(vDsLinha, 'CD_PRODUTO', item_f('CD_PRODUTO', tPRD_KITI));
                putitemXml(vDsLinha, 'QT_PRODUTO', item_f('QT_PRODUTO', tPRD_KITI));
                putitem(vDsLstProduto,  vDsLinha);

                setocc(tPRD_KITI, curocc(tPRD_KITI) + 1);
              end;
            end;
          end else begin
            putitem_e(tPRD_PRODUTO, 'CD_PRODUTO', item_f('CD_PRODUTO', tPRD_CODIGOBAR));
            vQtEmbalagem := item_f('QT_EMBALAGEM', tPRD_CODIGOBAR);
          end;
        end else begin
          clear_e(tPRD_KITC);
          putitem_e(tPRD_KITC, 'CD_KIT', vCdBarraPrd);
          retrieve_e(tPRD_KITC);
          if (xStatus < 0) then begin
            if (gTpBarraLote = 1) then begin
              viParams := '';
              putitemXml(viParams, 'CD_BARRA', vCdBarraPrd);
              voParams := activateCmp('PRDSVCO020', 'validaLote', viParams);
              if (xStatus < 0) then begin
                Result := voParams;
                return(-1); exit;
              end;

              vCdEmpLote := itemXmlF('CD_EMPRESA', voParams);
              vNrLote := itemXmlF('NR_LOTE', voParams);
              vNrItem := itemXmlF('NR_ITEM', voParams);
              vQtLote := itemXmlF('QT_LOTE', voParams);
              vCdProduto := itemXmlF('CD_PRODUTO', voParams);

              vDsLinha := '';
              putitemXml(vDsLinha, 'CD_PRODUTO', vCdProduto);
              putitemXml(vDsLinha, 'QT_PRODUTO', vQtLote);
              putitemXml(vDsLinha, 'CD_EMPLOTE', vCdEmpLote);
              putitemXml(vDsLinha, 'NR_LOTE', vNrLote);
              putitemXml(vDsLinha, 'NR_ITEM', vNrItem);
              putitem(vDsLstProduto,  vDsLinha);
              if (vCdProduto > 0)  and (vQtLote > 0 ) or (vInQtLote = False) then begin
                putitem_e(tPRD_PRODUTO, 'CD_PRODUTO', vCdProduto);
                vQtEmbalagem := vQtLote;
              end else begin
                Result := SetStatus(STS_ERROR, 'GEN0001', , cDS_METHOD);
                return(-1); exit;
              end;

            end else begin
              Result := SetStatus(STS_ERROR, 'GEN0001', , cDS_METHOD);
              return(-1); exit;
            end;
          end else begin
            setocc(tPRD_KITI, 1);
            putitem_e(tPRD_PRODUTO, 'CD_PRODUTO', item_f('CD_PRODUTO', tPRD_KITI));
            vQtEmbalagem := item_f('QT_PRODUTO', tPRD_KITI);
            setocc(tPRD_KITI, 1);
            while (xStatus >= 0) do begin
              vDsLinha := '';
              putitemXml(vDsLinha, 'CD_PRODUTO', item_f('CD_PRODUTO', tPRD_KITI));
              putitemXml(vDsLinha, 'QT_PRODUTO', item_f('QT_PRODUTO', tPRD_KITI));
              putitem(vDsLstProduto,  vDsLinha);

              setocc(tPRD_KITI, curocc(tPRD_KITI) + 1);
            end;
          end;
        end;
      end else begin

        if (item_f('TP_BARRA', tPRD_CODIGOBAR) = 1) then begin
          viParams := '';
          putitemXml(viParams, 'CD_BARRA', vCdBarraPrd);
          voParams := activateCmp('PRDSVCO020', 'validaLote', viParams);
          if (xStatus < 0) then begin
            Result := voParams;
            return(-1); exit;
          end;

          vCdEmpLote := itemXmlF('CD_EMPRESA', voParams);
          vNrLote := itemXmlF('NR_LOTE', voParams);
          vNrItem := itemXmlF('NR_ITEM', voParams);
          vQtLote := itemXmlF('QT_LOTE', voParams);
          vCdProduto := itemXmlF('CD_PRODUTO', voParams);

          vDsLinha := '';
          putitemXml(vDsLinha, 'CD_PRODUTO', vCdProduto);
          putitemXml(vDsLinha, 'QT_PRODUTO', vQtLote);
          putitemXml(vDsLinha, 'CD_EMPLOTE', vCdEmpLote);
          putitemXml(vDsLinha, 'NR_LOTE', vNrLote);
          putitemXml(vDsLinha, 'NR_ITEM', vNrItem);
          putitem(vDsLstProduto,  vDsLinha);
          if (vCdProduto > 0)  and (vQtLote > 0 ) or (vInQtLote = False) then begin
            putitem_e(tPRD_PRODUTO, 'CD_PRODUTO', vCdProduto);
            vQtEmbalagem := vQtLote;
          end else begin
            Result := SetStatus(STS_ERROR, 'GEN0001', , cDS_METHOD);
            return(-1); exit;
          end;

        end else begin
          putitem_e(tPRD_PRODUTO, 'CD_PRODUTO', item_f('CD_PRODUTO', tPRD_CODIGOBAR));
          vQtEmbalagem := item_f('QT_EMBALAGEM', tPRD_CODIGOBAR);
        end;
      end;
    end;
  end;

  retrieve_e(tPRD_PRODUTO);
  if (xStatus < 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', , cDS_METHOD);
    return(-1); exit;
  end else begin
    vDsLstEmpresa := '';
    vDsLstEmp := '';
    putitem(vDsLstEmp,  vCdEmpresaParam);
    vDsLstEmpresa := '' + vDsLstEmpresa + ' - ' + FloatToStr(vCdEmpresaParam') + ';
    if (gCdEmpresaPadrao > 0) then begin
      putitem(vDsLstEmp,  gCdEmpresaPadrao);
      vDsLstEmpresa := '' + vDsLstEmpresa + ' - ' + FloatToStr(gCdEmpresaPadrao') + ';
    end else begin
      if (gCdEmpresaValorEmp > 0)  or (gCdEmpresaValorEmp <> vCdEmpresaParam) then begin
        putitem(vDsLstEmp,  gCdEmpresaValorEmp);
        vDsLstEmpresa := '' + vDsLstEmpresa + ' - ' + FloatToStr(gCdEmpresaValorEmp') + ';
      end;
      if (gCdEmpresaValorSis > 0)  or (gCdEmpresaValorSis <> vCdEmpresaParam) then begin
        putitem(vDsLstEmp,  gCdEmpresaValorSis);
        vDsLstEmpresa := '' + vDsLstEmpresa + ' - ' + FloatToStr(gCdEmpresaValorSis') + ';
      end;
    end;
    vInAchou := False;
    while (vDsLstEmp <> '')  and (vInAchou := False) do begin
      getitem(vCdEmpresa, vDsLstEmp, 1);
      clear_e(tPRD_PRDINFO);
      putitem_e(tPRD_PRDINFO, 'CD_EMPRESA', vCdEmpresa);
      putitem_e(tPRD_PRDINFO, 'CD_PRODUTO', item_f('CD_PRODUTO', tPRD_PRODUTO));
      retrieve_e(tPRD_PRDINFO);
      if (xStatus >= 0) then begin
        vInAchou := True;
      end;
      delitem(vDsLstEmp, 1);
    end;
    if (vInAchou = False) then begin
      Result := SetStatus(STS_ERROR, 'GEN0001', , cDS_METHOD);
      return(-1); exit;
    end else begin
      if (vInInativo <> True) then begin
        if (item_b('IN_INATIVO', tPRD_PRDINFO) = True) then begin
          Result := SetStatus(STS_ERROR, 'GEN0001', , cDS_METHOD);
          return(-1); exit;
        end;
      end;
    end;
    if (vInProdutoBloq = True) then begin
      viParams := '';
      putitemXml(viParams, 'CD_EMPRESA', vCdEmpresaParam);
      putitemXml(viParams, 'CD_PRODUTO', item_f('CD_PRODUTO', tPRD_PRODUTO));
      voParams := activateCmp('PRDSVCO014', 'buscaDadosBloqueio', viParams);
      if (xStatus < 0) then begin
        Result := voParams;
        return(-1); exit;
      end;

      vInPrdBloqueado := itemXmlB('IN_BLOQUEADO', voParams);

      if (vInPrdBloqueado = True) then begin
        Result := SetStatus(STS_ERROR, 'GEN0001', , cDS_METHOD);
        return(-1); exit;
      end;
    end;
    if (vInProdAcabado = True) then begin
      if (item_b('IN_PRODACABADO', tPRD_PRDINFO) <> vInProdAcabado) then begin
        Result := SetStatus(STS_ERROR, 'GEN0001', , cDS_METHOD);
        return(-1); exit;
      end;
    end else if (vInMatPrima = True) then begin
      if (item_b('IN_MATPRIMA', tPRD_PRDINFO) <> vInMatPrima) then begin
        Result := SetStatus(STS_ERROR, 'GEN0001', , cDS_METHOD);
        return(-1); exit;
      end;
    end else if (vInMatConsumo = True) then begin
      if (item_b('IN_MATCONSUMO', tPRD_PRDINFO) <> vInMatConsumo) then begin
        Result := SetStatus(STS_ERROR, 'GEN0001', , cDS_METHOD);
        return(-1); exit;
      end;
    end else if (vTpLote <> '') then begin
      if (item_f('TP_LOTE', tPRD_PRDINFO) <> vTpLote) then begin
        Result := SetStatus(STS_ERROR, 'GEN0001', , cDS_METHOD);
        return(-1); exit;
      end;
    end else if (vTpInspecao <> '') then begin
      if (item_f('TP_INSPECAO', tPRD_PRDINFO) <> vTpInspecao) then begin
        Result := SetStatus(STS_ERROR, 'GEN0001', , cDS_METHOD);
        return(-1); exit;
      end;
    end;
  end;
  if (gInPdvOtimizado = True) then begin
    clear_e(tPRD_EMBALAGEM);
    putitem_e(tPRD_EMBALAGEM, 'CD_PRODUTO', item_f('CD_PRODUTO', tPRD_PRODUTO));
    retrieve_e(tPRD_EMBALAGEM);
    if (xStatus >= 0) then begin
      setocc(tPRD_EMBALAGEM, 1);
      vQtEmbalagem := item_f('QT_EMBALAGEM', tPRD_EMBALAGEM);
    end;
  end;
  if (gTpValidaFatPrdBloq = 01) then begin
    clear_e(tPRD_PRDBLOQUE);
    putitem_e(tPRD_PRDBLOQUE, 'CD_PRODUTO', item_f('CD_PRODUTO', tPRD_PRODUTO));
    retrieve_e(tPRD_PRDBLOQUE);
    if (xStatus >= 0) then begin
      if (item_b('IN_BLOQUEIO', tPRD_PRDBLOQUE) = True) then begin
        Result := SetStatus(STS_ERROR, 'GEN0001', , cDS_METHOD);
        return(-1); exit;
      end;
    end;
  end;

  Result := '';
  putitemXml(Result, 'CD_PRODUTO', item_f('CD_PRODUTO', tPRD_PRODUTO));
  putitemXml(Result, 'QT_EMBALAGEM', vQtEmbalagem);
  putitemXml(Result, 'IN_PRODPROPRIA', item_b('IN_PRODPROPRIA', tPRD_PRDINFO));
  putitemXml(Result, 'IN_FRACIONADO', item_b('IN_FRACIONADO', tPRD_PRDINFO));
  putitemXml(Result, 'IN_COFINS', item_b('IN_COFINS', tPRD_PRDINFO));
  putitemXml(Result, 'IN_PIS', item_b('IN_PIS', tPRD_PRDINFO));
  putitemXml(Result, 'QT_ESTOQUEMIN', item_f('QT_ESTOQUEMIN', tPRD_PRDINFO));
  putitemXml(Result, 'QT_ESTOQUEMAX', item_f('QT_ESTOQUEMAX', tPRD_PRDINFO));
  putitemXml(Result, 'DS_PRODUTO', item_a('DS_PRODUTO', tPRD_PRODUTO));
  putitemXml(Result, 'IN_BARRASEQ', vInBarraSeq);
  putitemXml(Result, 'DS_LSTPRODUTO', vDsLstProduto);
  putitemXml(Result, 'TP_LOTE', item_f('TP_LOTE', tPRD_PRDINFO));
  putitemXml(Result, 'TP_INSPECAO', item_f('TP_INSPECAO', tPRD_PRDINFO));
  return(0); exit;
end;

//-----------------------------------------------------------------
function T_PRDSVCO004.carregaDadosGrupo(pParams : String) : String;
//-----------------------------------------------------------------
const
  cDS_METHOD = 'ADICONAL=Operação: T_PRDSVCO004.carregaDadosGrupo()';
var
  vDsLista : String;
  vCdSeq, vCdSeqGrupo, vCdCfgNivel, vCdEmpresaParam, vNrGeral : Real;
  vInFim, vInCompleto, vInCodigo, vInDescricao : Boolean;
  vDsGrupoComp : String;
  vDsGrupoParam : String;
  vCdGrupoComp : String;
  vCdGrupoParam : String;
  vDsTipoClasComp, vDsTipoClasParam : String;
  vDsLstNivelGrupo, vDsLstNivelDescGrupo : String;
begin
  vDsLstNivelGrupo := itemXml('DS_LST_NIVEL_GRUPO_NF', pParams);
  vDsLstNivelDescGrupo := itemXml('DS_LST_NIVEL_DES_GRUPO_NF', pParams);
  vCdSeqGrupo := itemXmlF('CD_SEQGRUPO', pParams);
  vCdCfgNivel := itemXmlF('CD_CFGNIVEL', pParams);
  vCdEmpresaParam := itemXmlF('CD_EMPRESA', pParams);
  if (vCdEmpresaParam = 0) then begin
    vCdEmpresaParam := itemXmlF('CD_EMPRESA', PARAM_GLB);
  end;
  vInCompleto := itemXmlB('IN_COMPLETO', pParams);

  if (vCdSeqGrupo = 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', , cDS_METHOD);
    return(-1); exit;
  end;

  clear_e(tPRD_GRUPO);
  putitem_e(tPRD_GRUPO, 'CD_SEQ', vCdSeqGrupo);
  retrieve_o(tPRD_GRUPO);

  gDsLstNivelGrupo := '';
  gDsLstNivelDescGrupo := '';
  if (vInCompleto = True) then begin
  end else begin
    getParams(pParams); (* vCdEmpresaParam *)
    if (xStatus < 0) then begin
      Result := voParams;
      return(-1); exit;
    end;
  end;

  clear_e(tTMP_NR09);

  if (vDsLstNivelGrupo <> '') then begin
    gDsLstNivelGrupo := vDsLstNivelGrupo;
  end;
  if (vDsLstNivelDescGrupo <> '') then begin
    gDsLstNivelDescGrupo := vDsLstNivelDescGrupo;
  end;
  if (gDsLstNivelGrupo <> '') then begin
    vDsLista := gDsLstNivelGrupo;
    length vDsLista;
    while (gresult > 0) do begin
      scan vDsLista, ';
      if (gresult > 0) then begin
        vNrGeral := vDsLista[1 : (gresult - 1)];
        vDsLista := vDsLista[(gresult + 1)];
      end else begin
        vNrGeral := vDsLista;
        vDsLista := '';
      end;
      creocc(tTMP_NR09, -1);
      putitem_e(tTMP_NR09, 'NR_GERAL', vNrGeral);
      retrieve_o(tTMP_NR09);
      if (xStatus = -7) then begin
        retrieve_x(tTMP_NR09);
      end;
      length vDsLista;
    end;
  end;

  clear_e(tF_TMP_NR09);

  if (gDsLstNivelDescGrupo <> '') then begin
    vDsLista := gDsLstNivelDescGrupo;
    length vDsLista;
    while (gresult > 0) do begin
      scan vDsLista, ';
      if (gresult > 0) then begin
        vNrGeral := vDsLista[1 : (gresult - 1)];
        vDsLista := vDsLista[(gresult + 1)];
      end else begin
        vNrGeral := vDsLista;
        vDsLista := '';
      end;
      creocc(tF_TMP_NR09, -1);
      putitem_e(tF_TMP_NR09, 'NR_GERAL', vNrGeral);
      retrieve_o(tF_TMP_NR09);
      if (xStatus = -7) then begin
        retrieve_x(tF_TMP_NR09);
      end;
      length vDsLista;
    end;
  end;

  vInFim := False;

  vDsGrupoComp := '';
  vDsGrupoParam := '';

  vCdGrupoComp := '';
  vCdGrupoParam := '';

  vDsTipoClasComp := '';
  vDsTipoClasParam := '';

  clear_e(tPRD_GRUPO);
  vCdSeq := vCdSeqGrupo;
  while(vInFim := False) do begin
    clear_e(tPRD_GRUPO);
    putitem_e(tPRD_GRUPO, 'CD_SEQ', vCdSeq);

    retrieve_o(tPRD_GRUPO);
    if (xStatus >= 0) then begin
      clear_e(tPRD_GRUPO);
      putitem_e(tPRD_GRUPO, 'CD_SEQ', vCdSeq);
      retrieve_e(tPRD_GRUPO);
      if (xStatus < 0) then begin
        Result := SetStatus(STS_ERROR, 'GEN0001', , cDS_METHOD);
        return(-1); exit;
      end;
    end else if (xStatus = -7) then begin
      retrieve_x(tPRD_GRUPO);
    end;
    if (vCdGrupoComp = '') then begin
      vCdGrupoComp := item_f('CD_GRUPO', tPRD_GRUPO);
    end else begin
      vCdGrupoComp := '' + item_f('CD_GRUPO', tPRD_GRUPO) + ';
    end;
    if (vDsGrupoComp = '') then begin
      vDsGrupoComp := item_a('DS_GRUPO', tPRD_GRUPO);
    end else begin
      vDsGrupoComp := '' + item_a('DS_GRUPO', tPRD_GRUPO) + ' ' + vDsGrupoComp' + ';
    end;
    if (vDsTipoClasComp = '') then begin
      vDsTipoClasComp := item_a('DS_TIPOCLAS', tPRD_TIPOCLAS);
    end else begin
      vDsTipoClasComp := '' + item_a('DS_TIPOCLAS', tPRD_TIPOCLAS) + ';
    end;

    vInCodigo := True;
    vInDescricao := True;

    if (vCdCfgNivel > 0) then begin
      clear_e(tPRD_CFGNIVELI);
      putitem_e(tPRD_CFGNIVELI, 'CD_CFGNIVEL', vCdCfgNivel);
      putitem_e(tPRD_CFGNIVELI, 'CD_TIPOCLAS', item_f('CD_TIPOCLAS', tPRD_GRUPO));
      retrieve_e(tPRD_CFGNIVELI);
      if (xStatus >= 0) then begin
        if (item_b('IN_CODIGO', tPRD_CFGNIVELI) <> True) then begin
          vInCodigo := False;
        end;
        if (item_b('IN_DESCRICAO', tPRD_CFGNIVELI) <> True) then begin
          vInDescricao := False;
        end;
      end else begin
        vInCodigo := False;
        vInDescricao := False;
      end;
    end else begin
      if not (empty(tTMP_NR09)) then begin
        creocc(tTMP_NR09, -1);
        putitem_e(tTMP_NR09, 'NR_GERAL', item_f('CD_TIPOCLAS', tPRD_GRUPO));
        retrieve_o(tTMP_NR09);
        if (xStatus <> 4) then begin
          vInCodigo := False;
          discard 'TMP_NR09SVC';
        end;
      end;

      if not (empty(tF_TMP_NR09)) then begin
        creocc(tF_TMP_NR09, -1);
        putitem_e(tF_TMP_NR09, 'NR_GERAL', item_f('CD_TIPOCLAS', tPRD_GRUPO));
        retrieve_o(tF_TMP_NR09);
        if (xStatus <> 4) then begin
          vInDescricao := False;
          discard 'F_TMP_NR09SVC';
        end;
      end;
    end;
    if (vInCodigo = True) then begin
      if (vCdGrupoParam = '') then begin
        vCdGrupoParam := item_f('CD_GRUPO', tPRD_GRUPO);
      end else begin
        vCdGrupoParam := '' + item_f('CD_GRUPO', tPRD_GRUPO) + ';
      end;
    end;
    if (vInDescricao = True) then begin
      if (vDsGrupoParam = '') then begin
        vDsGrupoParam := item_a('DS_GRUPO', tPRD_GRUPO);
      end else begin
        vDsGrupoParam := '' + item_a('DS_GRUPO', tPRD_GRUPO) + ' ' + vDsGrupoParam' + ';
      end;
    end;
    if (vInCodigo = True)  or (vInDescricao = True) then begin
      if (vDsTipoClasParam = '') then begin
        vDsTipoClasParam := item_a('DS_TIPOCLAS', tPRD_TIPOCLAS);
      end else begin
        vDsTipoClasParam := '' + item_a('DS_TIPOCLAS', tPRD_TIPOCLAS) + ';
      end;
    end;
    if (item_f('CD_SEQ', tPRD_GRUPO) = item_f('CD_SEQPAI', tPRD_GRUPO) ) or (item_f('CD_SEQPAI', tPRD_GRUPO) = '') then begin
      vInFim := True;
    end else begin
      vCdSeq := item_f('CD_SEQPAI', tPRD_GRUPO);
    end;
  end;
  if (vDsGrupoParam = '') then begin
    vDsGrupoParam := vDsGrupoComp;
  end;
  if (vCdGrupoParam = '') then begin
    vCdGrupoParam := vCdGrupoComp;
  end;

  Result := '';
  putitemXml(Result, 'DS_GRUPOCOMP', vDsGrupoComp);
  putitemXml(Result, 'CD_GRUPOCOMP', vCdGrupoComp);
  putitemXml(Result, 'DS_GRUPOPARAM', vDsGrupoParam);
  putitemXml(Result, 'CD_GRUPOPARAM', vCdGrupoParam);
  putitemXml(Result, 'DS_TIPOCLASCOMP', vDsTipoClasComp);
  putitemXml(Result, 'DS_TIPOCLASPARAM', vDsTipoClasParam);

  return(0); exit;
end;

//------------------------------------------------------------------
function T_PRDSVCO004.formataCodigoGrupo(pParams : String) : String;
//------------------------------------------------------------------
const
  cDS_METHOD = 'ADICONAL=Operação: T_PRDSVCO004.formataCodigoGrupo()';
var
  vCdGrupo, vDsLista : String;
  vNrTamanho, vNrNivel, vNrIndice, vNrGeral, vCdGrupoNr, vCdEmpresaParam : Real;
begin
  Result := '';

  vCdGrupo := itemXmlF('CD_GRUPO', pParams);
  if (vCdGrupo = '') then begin
    putitemXml(Result, 'CD_GRUPO', vCdGrupo);
    return(0); exit;
  end;

  vNrNivel := itemXmlF('NR_NIVEL', pParams);
  if (vNrNivel = 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Número do nível não infomado!', cDS_METHOD);
    return(-1); exit;
  end;

  vCdGrupoNr := vCdGrupo;
  if (vCdGrupoNr <> vCdGrupo) then begin
    putitemXml(Result, 'CD_GRUPO', vCdGrupo);
    return(0); exit;
  end;

  vCdEmpresaParam := itemXmlF('CD_EMPRESA', pParams);
  if (vCdEmpresaParam = 0) then begin
    vCdEmpresaParam := itemXmlF('CD_EMPRESA', PARAM_GLB);
  end;

  getParams(pParams); (* vCdEmpresaParam *)
  if (xStatus < 0) then begin
    Result := voParams;
    return(-1); exit;
  end;
  if (gDsLstTamGrupo = '') then begin
    putitemXml(Result, 'CD_GRUPO', vCdGrupo);
    return(0); exit;
  end;

  vNrTamanho := 0;
  vNrIndice := 0;
  vDsLista := gDsLstTamGrupo;
  length vDsLista;
  while (gresult > 0)  and (vNrTamanho := 0) do begin
    scan vDsLista, ';
    if (gresult > 0) then begin
      vNrGeral := vDsLista[1 : (gresult - 1)];
      vDsLista := vDsLista[(gresult + 1)];
    end else begin
      vNrGeral := vDsLista;
      vDsLista := '';
    end;
    vNrIndice := vNrIndice + 1;
    if (vNrIndice = vNrNivel) then begin
      vNrTamanho := vNrGeral;
    end;
    length vDsLista;
  end;

  length vCdGrupo;
  while (gresult < vNrTamanho) do begin
    vCdGrupo := '0' + FloatToStr(vCdGrupo') + ';
    length vCdGrupo;
  end;

  putitemXml(Result, 'CD_GRUPO', vCdGrupo);

  return(0); exit;
end;

//-------------------------------------------------------------
function T_PRDSVCO004.achaNovoCdKit(pParams : String) : String;
//-------------------------------------------------------------
const
  cDS_METHOD = 'ADICONAL=Operação: T_PRDSVCO004.achaNovoCdKit()';
var
  vCdSequencia : Real;
  vCdKit : String;
begin
  getParams(pParams); (* itemXmlF('CD_EMPRESA', PARAM_GLB) *)
  if (xStatus < 0) then begin
    Result := voParams;
    return(-1); exit;
  end;

  gDsPrefixoKit := gDsPrefixoKit[1:11];

  vCdKit := '';
  while (vCdKit := '') do begin
    newinstance 'GERSVCO001', 'GERSVCO001', 'TRANSACTION=TRUE';
    voParams := activateCmp('GERSVCO001', 'GetNumSeqComm', viParams);
    if (xStatus < 0) then begin
      Result := voParams;
      return(-1); exit;
    end;

    voParams := preencheZero(viParams); (* vCdSequencia, 9, vCdKit *)
    if (xStatus < 0) then begin
      Result := voParams;
      return(-1); exit;
    end;

    vCdKit := '' + gDsPrefixoKit' + FloatToStr(vCdKit') + ' + ';
    clear_e(tPRD_KITC);
    putitem_e(tPRD_KITC, 'CD_KIT', vCdKit);
    retrieve_e(tPRD_KITC);
    if (xStatus >= 0) then begin
      vCdKit := '';
    end;
  end;

  Result := '';
  putitemXml(Result, 'CD_KIT', vCdKit);

  return(0); exit;
end;

//---------------------------------------------------------------
function T_PRDSVCO004.carregaDadosCor(pParams : String) : String;
//---------------------------------------------------------------
const
  cDS_METHOD = 'ADICONAL=Operação: T_PRDSVCO004.carregaDadosCor()';
var
  vCdCor : String;
  vCdEmpresa : Real;
begin
  vCdEmpresa := itemXmlF('CD_EMPRESA', PARAM_GLB);
  vCdCor := itemXmlF('CD_COR', PARAM_GLB);

  Result := '';

  clear_e(tPRD_CORINFO);
  putitem_e(tPRD_CORINFO, 'CD_EMPRESA', vCdEmpresa);
  putitem_e(tPRD_CORINFO, 'CD_COR', vCdCor);
  retrieve_e(tPRD_CORINFO);
  if (xStatus >= 0) then begin
    putlistitensocc_e(Result, tPRD_CORINFO);
  end;

  return(0); exit;
end;

//---------------------------------------------------------------
function T_PRDSVCO004.buscaNivelGrupo(pParams : String) : String;
//---------------------------------------------------------------
const
  cDS_METHOD = 'ADICONAL=Operação: T_PRDSVCO004.buscaNivelGrupo()';
var
  vNrNivel, vCdProduto, vCdSeq : Real;
  vInFim : Boolean;
begin
  vNrNivel := itemXmlF('NR_NIVEL', pParams);
  vCdProduto := itemXmlF('CD_PRODUTO', pParams);

  if (vNrNivel = 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Número do nível não infomado!', cDS_METHOD);
    return(-1); exit;
  end;
  if (vCdProduto = 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Produto não infomado!', cDS_METHOD);
    return(-1); exit;
  end;

  clear_e(tSIS_NIVEL);
  vInFim := False;

  clear_e(tPRD_PRDGRADE);
  putitem_e(tPRD_PRDGRADE, 'CD_PRODUTO', vCdProduto);
  retrieve_e(tPRD_PRDGRADE);
  if (xStatus >= 0) then begin
    clear_e(tPRD_GRUPO);
    vCdSeq := item_f('CD_SEQGRUPO', tPRD_PRDGRADE);
    while(vInFim := False) do begin
      clear_e(tPRD_GRUPO);
      putitem_e(tPRD_GRUPO, 'CD_SEQ', vCdSeq);
      retrieve_o(tPRD_GRUPO);
      if (xStatus >= 0) then begin
        Result := SetStatus(STS_ERROR, 'GEN0001', , cDS_METHOD);
        return(-1); exit;
      end else if (xStatus = -7) then begin
        retrieve_x(tPRD_GRUPO);
      end;
      creocc(tSIS_NIVEL, 1);
      putitem_e(tSIS_NIVEL, 'CD_GRUPO', item_f('CD_GRUPO', tPRD_GRUPO));
      putitem_e(tSIS_NIVEL, 'DS_GRUPO', item_a('DS_GRUPO', tPRD_GRUPO));
      if (item_f('CD_SEQ', tPRD_GRUPO) = item_f('CD_SEQPAI', tPRD_GRUPO) ) or (item_f('CD_SEQPAI', tPRD_GRUPO) = '') then begin
        vInFim := True;
      end else begin
        vCdSeq := item_f('CD_SEQPAI', tPRD_GRUPO);
      end;
    end;

    setocc(tSIS_NIVEL, 1);
    if (xStatus >= 0) then begin
      putitemXml(Result, 'CD_NIVEL', item_f('CD_GRUPO', tSIS_NIVEL));
      putitemXml(Result, 'DS_NIVEL', item_a('DS_GRUPO', tSIS_NIVEL));
    end;
  end;

  return(0); exit;

end;

//-----------------------------------------------------------------
function T_PRDSVCO004.buscaDadosProduto(pParams : String) : String;
//-----------------------------------------------------------------
const
  cDS_METHOD = 'ADICONAL=Operação: T_PRDSVCO004.buscaDadosProduto()';
var
  vCdProduto : Real;
begin
  vCdProduto := itemXmlF('CD_PRODUTO', pParams);

  if (vCdProduto = '') then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Produto não infomado!', cDS_METHOD);
    return(-1); exit;
  end;

  clear_e(tPRD_PRODUTO);
  putitem_e(tPRD_PRODUTO, 'CD_PRODUTO', vCdProduto);
  retrieve_e(tPRD_PRODUTO);
  if (xStatus < 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Produto não infomado!', cDS_METHOD);
    return(-1); exit;
  end;

  Result := '';
  putlistitensocc_e(Result, tPRD_PRODUTO);

  return(0); exit;
end;

//-----------------------------------------------------------------
function T_PRDSVCO004.buscaDiasRessupri(pParams : String) : String;
//-----------------------------------------------------------------
const
  cDS_METHOD = 'ADICONAL=Operação: T_PRDSVCO004.buscaDiasRessupri()';
var
  vCdSeqGrupo, vCdTamanho, vCdEmpresa : Real;
begin
  vCdSeqGrupo := itemXmlF('CD_SEQGRUPO', pParams);
  vCdTamanho := itemXmlF('CD_TAMANHO', pParams);
  vCdEmpresa := itemXmlF('CD_EMPRESA', pParams);

  if (vCdSeqGrupo = '' ) or (vCdTamanho = '' ) or (vCdEmpresa = '') then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Empresa, Grupo e/ou Tamanho não infomado!', cDS_METHOD);
    return(-1); exit;
  end;

  clear_e(tPRD_PRDGRADE);
  putitem_e(tPRD_PRDGRADE, 'CD_SEQGRUPO', vCdSeqGrupo);
  putitem_e(tPRD_PRDGRADE, 'CD_TAMANHO', vCdTamanho);
  retrieve_e(tPRD_PRDGRADE);
  while (xStatus >= 0) do begin
    clear_e(tPRD_PRDINFO);
    putitem_e(tPRD_PRDINFO, 'CD_EMPRESA', vCdEmpresa);
    putitem_e(tPRD_PRDINFO, 'CD_PRODUTO', item_f('CD_PRODUTO', tPRD_PRDGRADE));
    retrieve_e(tPRD_PRDINFO);
    if (xStatus >= 0) then begin
      if (item_f('NR_DIARESSUPRI', tPRD_PRDINFO) > 0) then begin
        Result := item_f('NR_DIARESSUPRI', tPRD_PRDINFO);
        clear_e(tPRD_PRDINFO);
        clear_e(tPRD_PRDGRADE);
        return(0); exit;
      end;
    end;
    clear_e(tPRD_PRDINFO);
    setocc(tPRD_PRDGRADE, curocc(tPRD_PRDGRADE) + 1);
  end;
  clear_e(tPRD_PRDGRADE);

  return(0); exit;
end;

//------------------------------------------------------------
function T_PRDSVCO004.gravaGttProd(pParams : String) : String;
//------------------------------------------------------------
const
  cDS_METHOD = 'ADICONAL=Operação: T_PRDSVCO004.gravaGttProd()';
var
  vCdProduto, vDsLstProduto : String;
begin
  vDsLstProduto := itemXml('DS_LSTPRODUTO', pParams);

  clear_e(tGTT_PROD);
  repeat
    getitem(vCdProduto, vDsLstProduto, 1);
    creocc(tGTT_PROD, -1);
    putitem_e(tGTT_PROD, 'CD_PRODUTO', vCdProduto);
    retrieve_o(tGTT_PROD);
    if (xStatus = -7) then begin
      retrieve_x(tGTT_PROD);
    end;
    voParams := tGTT_PROD.Salvar();
    if (xStatus < 0) then begin
      Result := voParams;
      return(-1); exit;
    end;
    delitem(vDsLstProduto, 1);
  until (vDsLstProduto = '');

  return(0); exit;
end;


end.
