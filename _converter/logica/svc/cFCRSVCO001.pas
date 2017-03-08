unit cFCRSVCO001;

interface

(* COMPONENTES 
  ADMSVCO001 / COMSVCO001 / EDISVCO020 / FCRSVCO057 / FCRSVCO087
  FCRSVCO090 / FGRSVCO001 / FGRSVCO002 / 
*)        

uses
  Classes, SysUtils, Math, DB,
  cDataSetUnf;

type
  T_FCRSVCO001 = class(TComponent)
  private
    tCTB_MOVTOD,
    tF_FCR_CHEQUE,
    tF_FCR_COMISSA,
    tF_FCR_FATURAI,
    tFCR_CHEQUE,
    tFCR_COMISSAO,
    tFCR_CONFIN,
    tFCR_FATCARTAO,
    tFCR_FATCLAS,
    tFCR_FATPDD,
    tFCR_FATURAC,
    tFCR_FATURAI,
    tFCR_INDICEFAT,
    tFCR_LOGFAT,
    tFCX_HISTRELSU,
    tFGR_INDICE,
    tGER_EMPRESA,
    tGER_POOLGRUPO,
    tOBS_FATI,
    tPES_CLIENTE,
    tPES_CLIPORTAD,
    tV_FCR_CONHIS : TcDatasetUnf;
    function getParam(pParams : String = '') : String;
    function setEntidade(pParams : String = '') : String;
  protected
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;    
  published
    function formataCampoComDecimal(pParams : String = '') : String;
    function preencheZerosDireita(pParams : String = '') : String;
    function listaEmpresaPool(pParams : String = '') : String;
    function verificarAlteracao(pParams : String = '') : String;
    function Converterstring(pParams : String = '') : String;
    function INIT(pParams : String = '') : String;
    function CLEANUP(pParams : String = '') : String;
    function geraFatura(pParams : String = '') : String;
    function gravaLogFatura(pParams : String = '') : String;
    function seqLogFatura(pParams : String = '') : String;
    function buscaParametro(pParams : String = '') : String;
    function gravaLiquidacaoFatura(pParams : String = '') : String;
    function gravaObsFatura(pParams : String = '') : String;
    function gravaInfCheque(pParams : String = '') : String;
    function gravaParcelaFatura(pParams : String = '') : String;
    function gravaComissaoFatura(pParams : String = '') : String;
    function gravaChequeFatura(pParams : String = '') : String;
    function gravaDesctoAntecipFatura(pParams : String = '') : String;
    function gravaAbatimentoFatura(pParams : String = '') : String;
    function gravaPortadorFatura(pParams : String = '') : String;
    function gravaCobrancaFatura(pParams : String = '') : String;
    function regravaIndiceFatura(pParams : String = '') : String;
    function inativaCliente(pParams : String = '') : String;
    function gravaClassificacao(pParams : String = '') : String;
    function validaClassificacao(pParams : String = '') : String;
    function validaClassificacaoTotal(pParams : String = '') : String;
    function verLanctoCtbFatura(pParams : String = '') : String;
    function gravaDadosBoleto(pParams : String = '') : String;
    function gravaFundoPerdido(pParams : String = '') : String;
    function gravaFatCartao(pParams : String = '') : String;
  end;

implementation

uses
  cADMSVCO001,
  cActivate, cStatus, cFuncao, cXml, dModulo;

var
  gCdEmpresaMatriz,
  gCdTipoClasCliFat,
  gCdTipoClasPedFat,
  gCdTipoClasPrdFat,
  gCdTipoClassPrdFcr,
  gInCalculoJurosPorPar,
  gInUtilizaCxFilial,
  gInVariacaoCambial,
  gLstEmpresa,
  gNrDiasCarenciaAtraso,
  gNrDiasCarenciaMulta,
  gNrDiasDesc1,
  gNrDiasDesc2,
  gNrDiasDescPont,
  gNrTipoCalcDesconto,
  gprDesc1,
  gprDesc2,
  gprDescPont,
  gprJuros,
  gprMulta : String;

//---------------------------------------------------------------
constructor T_FCRSVCO001.Create(AOwner: TComponent);
//---------------------------------------------------------------
begin
  inherited Create(AOwner);
  setEntidade('');
end;

//--------------------------------
destructor T_FCRSVCO001.Destroy;
//--------------------------------
begin
  inherited Destroy;
end;

//---------------------------------------------------------------
function T_FCRSVCO001.getParam(pParams : String = '') : String;
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
  putitem(xParam, 'CD_EMPRESA');
  putitem(xParam, 'IN_CALCULO_JUROS_POR_PAR');
  putitem(xParam, 'IN_VARIACAO_CAMBIAL');
  putitem(xParam, 'NR_FAT');
  putitem(xParam, 'NR_LOGFAT');
  putitem(xParam, 'NR_PARCELA');
  putitem(xParam, 'NR_TIPO_CALC_DESCONTO');

  xParam := T_ADMSVCO001.GetParametro(xParam);

  gCdEmpresaMatriz := itemXml('CD_EMPRESA_MATRIZ', xParam);
  gCdTipoClasCliFat := itemXml('CD_TIPOCLAS_CLI_FAT', xParam);
  gCdTipoClasPedFat := itemXml('CD_TIPOCLAS_PED_FAT', xParam);
  gCdTipoClasPrdFat := itemXml('CD_TIPOCLAS_PRD_FAT', xParam);
  gCdTipoClassPrdFcr := itemXml('CD_TIPOCLASS_PRD_FCR', xParam);
  gInCalculoJurosPorPar := itemXml('IN_CALCULO_JUROS_POR_PAR', xParam);
  gInUtilizaCxFilial := itemXml('IN_UTILIZA_CXFILIAL', xParam);
  gInVariacaoCambial := itemXml('IN_VARIACAO_CAMBIAL', xParam);
  gNrDiasCarenciaAtraso := itemXml('NR_DIAS_CARENCIA_ATRASO', xParam);
  gNrDiasCarenciaMulta := itemXml('NR_DIAS_CARENCIA_MULTA', xParam);
  gNrDiasDesc1 := itemXml('NR_DIAS_DESC_ANTECIP1', xParam);
  gNrDiasDesc2 := itemXml('NR_DIAS_DESC_ANTECIP2', xParam);
  gNrDiasDescPont := itemXml('NR_DIAS_DESC_PONT', xParam);
  gNrTipoCalcDesconto := itemXml('NR_TIPO_CALC_DESCONTO', xParam);
  gprDesc1 := itemXml('PR_DESC_ANTECIP1', xParam);
  gprDesc2 := itemXml('PR_DESC_ANTECIP2', xParam);
  gprDescPont := itemXml('PR_DESC_PONT', xParam);
  gprJuros := itemXml('PR_JUROS_MENSAL_ATRASO', xParam);
  gprMulta := itemXml('PR_MULTA', xParam);

  xParamEmp := '';
  putitem(xParamEmp, 'CD_CLIENTE');
  putitem(xParamEmp, 'CD_EMPRESA');
  putitem(xParamEmp, 'CD_TIPOCLAS_CLI_FAT');
  putitem(xParamEmp, 'CD_TIPOCLAS_PED_FAT');
  putitem(xParamEmp, 'CD_TIPOCLAS_PRD_FAT');
  putitem(xParamEmp, 'CD_TIPOCLASS_PRD_FCR');
  putitem(xParamEmp, 'IN_CALCULO_JUROS_POR_PAR');
  putitem(xParamEmp, 'IN_UTILIZA_CXFILIAL');
  putitem(xParamEmp, 'IN_VARIACAO_CAMBIAL');
  putitem(xParamEmp, 'NR_DIAS_CARENCIA_ATRASO');
  putitem(xParamEmp, 'NR_DIAS_CARENCIA_MULTA');
  putitem(xParamEmp, 'NR_DIAS_DESC_ANTECIP1');
  putitem(xParamEmp, 'NR_DIAS_DESC_ANTECIP2');
  putitem(xParamEmp, 'NR_DIAS_DESC_PONT');
  putitem(xParamEmp, 'NR_FAT');
  putitem(xParamEmp, 'NR_LOGFAT');
  putitem(xParamEmp, 'NR_PARCELA');
  putitem(xParamEmp, 'NR_TIPO_CALC_DESCONTO');
  putitem(xParamEmp, 'PR_DESC_ANTECIP1');
  putitem(xParamEmp, 'PR_DESC_ANTECIP2');
  putitem(xParamEmp, 'PR_DESC_PONT');
  putitem(xParamEmp, 'PR_JUROS_MENSAL_ATRASO');
  putitem(xParamEmp, 'PR_MULTA');

  xParamEmp := T_ADMSVCO001.GetParamEmpresa(piCdEmpresa, xParamEmp);

  gCdEmpresaMatriz := itemXml('CD_EMPRESA_MATRIZ', xParamEmp);
  gCdTipoClasCliFat := itemXml('CD_TIPOCLAS_CLI_FAT', xParamEmp);
  gCdTipoClasPedFat := itemXml('CD_TIPOCLAS_PED_FAT', xParamEmp);
  gCdTipoClasPrdFat := itemXml('CD_TIPOCLAS_PRD_FAT', xParamEmp);
  gCdTipoClassPrdFcr := itemXml('CD_TIPOCLASS_PRD_FCR', xParamEmp);
  gInUtilizaCxFilial := itemXml('IN_UTILIZA_CXFILIAL', xParamEmp);
  gNrDiasCarenciaAtraso := itemXml('NR_DIAS_CARENCIA_ATRASO', xParamEmp);
  gNrDiasCarenciaMulta := itemXml('NR_DIAS_CARENCIA_MULTA', xParamEmp);
  gNrDiasDesc1 := itemXml('NR_DIAS_DESC_ANTECIP1', xParamEmp);
  gNrDiasDesc2 := itemXml('NR_DIAS_DESC_ANTECIP2', xParamEmp);
  gNrDiasDescPont := itemXml('NR_DIAS_DESC_PONT', xParamEmp);
  gprDesc1 := itemXml('PR_DESC_ANTECIP1', xParamEmp);
  gprDesc2 := itemXml('PR_DESC_ANTECIP2', xParamEmp);
  gprDescPont := itemXml('PR_DESC_PONT', xParamEmp);
  gprJuros := itemXml('PR_JUROS_MENSAL_ATRASO', xParamEmp);
  gprMulta := itemXml('PR_MULTA', xParamEmp);
  vCdCliente := itemXml('CD_CLIENTE', xParamEmp);
  vCdEmpLiq := itemXml('CD_EMPLIQ', xParamEmp);
  vCdEmpresa := itemXml('CD_EMPRESA', xParamEmp);
  vNrFat := itemXml('NR_FAT', xParamEmp);
  vNrParcela := itemXml('NR_PARCELA', xParamEmp);
  vNrSeqLiq := itemXml('NR_SEQLIQ', xParamEmp);
  vTpBaixa := itemXml('TP_BAIXA', xParamEmp);

end;

//---------------------------------------------------------------
function T_FCRSVCO001.setEntidade(pParams : String = '') : String;
//---------------------------------------------------------------
begin
  tCTB_MOVTOD := TcDatasetUnf.getEntidade('CTB_MOVTOD');
  tF_FCR_CHEQUE := TcDatasetUnf.getEntidade('F_FCR_CHEQUE');
  tF_FCR_COMISSA := TcDatasetUnf.getEntidade('F_FCR_COMISSA');
  tF_FCR_FATURAI := TcDatasetUnf.getEntidade('F_FCR_FATURAI');
  tFCR_CHEQUE := TcDatasetUnf.getEntidade('FCR_CHEQUE');
  tFCR_COMISSAO := TcDatasetUnf.getEntidade('FCR_COMISSAO');
  tFCR_CONFIN := TcDatasetUnf.getEntidade('FCR_CONFIN');
  tFCR_FATCARTAO := TcDatasetUnf.getEntidade('FCR_FATCARTAO');
  tFCR_FATCLAS := TcDatasetUnf.getEntidade('FCR_FATCLAS');
  tFCR_FATPDD := TcDatasetUnf.getEntidade('FCR_FATPDD');
  tFCR_FATURAC := TcDatasetUnf.getEntidade('FCR_FATURAC');
  tFCR_FATURAI := TcDatasetUnf.getEntidade('FCR_FATURAI');
  tFCR_INDICEFAT := TcDatasetUnf.getEntidade('FCR_INDICEFAT');
  tFCR_LOGFAT := TcDatasetUnf.getEntidade('FCR_LOGFAT');
  tFCX_HISTRELSU := TcDatasetUnf.getEntidade('FCX_HISTRELSU');
  tFGR_INDICE := TcDatasetUnf.getEntidade('FGR_INDICE');
  tGER_EMPRESA := TcDatasetUnf.getEntidade('GER_EMPRESA');
  tGER_POOLGRUPO := TcDatasetUnf.getEntidade('GER_POOLGRUPO');
  tOBS_FATI := TcDatasetUnf.getEntidade('OBS_FATI');
  tPES_CLIENTE := TcDatasetUnf.getEntidade('PES_CLIENTE');
  tPES_CLIPORTAD := TcDatasetUnf.getEntidade('PES_CLIPORTAD');
  tV_FCR_CONHIS := TcDatasetUnf.getEntidade('V_FCR_CONHIS');
end;

//----------------------------------------------------------------------
function T_FCRSVCO001.formataCampoComDecimal(pParams : String) : String;
//----------------------------------------------------------------------
const
  cDS_METHOD = 'ADICONAL=Operação: T_FCRSVCO001.formataCampoComDecimal()';
var
  (* numeric piValorEntra : IN / numeric piTamDec :IN / string poValorSai :OUT *)
  vParteInt, vParteDec, vTamDec : Real;
  vMontado : String;
  vVirgula : String;
begin
  vParteInt := int(piValorEntra);
  length vParteInt;
  if (gresult < 1) then begin
    vParteInt := 0;
  end;
  vVirgula := ', ';

  vParteDec := piValorEntra[fraction];
  if (vParteDec <> 0) then begin
    length vParteDec;
    vTamDec := gresult;
    vParteDec := vParteDec[3, vTamDec];
  end;

  voParams := preencheZerosDireita(viParams); (* vParteDec, piTamDec, vMontado *)
  poValorSai := '' + vParteInt' + vVirgula' + vMontado' + ' + ' + ';

  return(0); exit;
end;

//--------------------------------------------------------------------
function T_FCRSVCO001.preencheZerosDireita(pParams : String) : String;
//--------------------------------------------------------------------
const
  cDS_METHOD = 'ADICONAL=Operação: T_FCRSVCO001.preencheZerosDireita()';
var
  (* string piDadoEntra : IN / numeric piTamFinal : IN / string poDadoSai : OUT *)
  vTam : Real;
  vZero : String;
begin
  length piDadoEntra;
  vTam := gresult;
  if (vTam < piTamFinal) then begin
    poDadoSai := piDadoEntra;
    vZero := '0';
    repeat
      poDadoSai := '' + poDadoSai' + vZero' + ' + ';
      vTam := vTam + 1;
    until (vTam := piTamFinal);
  end else begin
    poDadoSai := piDadoEntra[1:piTamFinal];
  end;

  return(0); exit;
end;

//----------------------------------------------------------------
function T_FCRSVCO001.listaEmpresaPool(pParams : String) : String;
//----------------------------------------------------------------
const
  cDS_METHOD = 'ADICONAL=Operação: T_FCRSVCO001.listaEmpresaPool()';
var
  vCdEmpresa : Real;
begin
  gLstEmpresa := '';

  if (gModulo.gCdPoolEmpresa > 0) then begin
    clear_e(tGER_POOLGRUPO);
    putitem_e(tGER_POOLGRUPO, 'CD_POOLEMPRESA', gModulo.gCdPoolEmpresa);
    retrieve_e(tGER_POOLGRUPO);
    if (xStatus >= 0) then begin
      setocc(tGER_POOLGRUPO, 1);
      while (xStatus >= 0) do begin

        clear_e(tGER_EMPRESA);
        putitem_e(tGER_EMPRESA, 'CD_GRUPOEMPRESA', item_f('CD_GRUPOEMPRESA', tGER_POOLGRUPO));
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

        setocc(tGER_POOLGRUPO, curocc(tGER_POOLGRUPO) + 1);
      end;
    end;
  end;

  return(0); exit;
end;

//------------------------------------------------------------------
function T_FCRSVCO001.verificarAlteracao(pParams : String) : String;
//------------------------------------------------------------------
const
  cDS_METHOD = 'ADICONAL=Operação: T_FCRSVCO001.verificarAlteracao()';
var
  (* string vDsFaturaI : IN / string vDsLstComis : IN / boolean vInAlteracao : INOUT *)
  vDsComissao : String;
begin
  if (!vInAlteracao) then begin
    return(0); exit;
  end;

  vInAlteracao := False;

  clear_e(tF_FCR_FATURAI);
  creocc(tF_FCR_FATURAI, -1);
  putitem_e(tF_FCR_FATURAI, 'CD_EMPRESA', itemXmlF('CD_EMPRESA', vDsFaturaI));
  putitem_e(tF_FCR_FATURAI, 'CD_CLIENTE', itemXmlF('CD_CLIENTE', vDsFaturaI));
  putitem_e(tF_FCR_FATURAI, 'NR_FAT', itemXmlF('NR_FAT', vDsFaturaI));
  putitem_e(tF_FCR_FATURAI, 'NR_PARCELA', itemXmlF('NR_PARCELA', vDsFaturaI));

  retrieve_o(tF_FCR_FATURAI);
  if (xStatus = -7) then begin
    retrieve_x(tF_FCR_FATURAI);
    if (item_a('DT_EMISSAO', tF_FCR_FATURAI) <> itemXml('DT_EMISSAO', vDsFaturaI))  or %\ then begin
      (item_a('DT_VENCIMENTO', tF_FCR_FATURAI) <> itemXml('DT_VENCIMENTO', vDsFaturaI))  or
      (item_f('NR_PORTADOR', tF_FCR_FATURAI) <> itemXmlF('NR_PORTADOR', vDsFaturaI))  or
      (item_f('NR_DOCUMENTO', tF_FCR_FATURAI) <> itemXmlF('NR_DOCUMENTO', vDsFaturaI))  or
      (item_f('CD_EMPLOCAL', tF_FCR_FATURAI) <> itemXmlF('CD_EMPLOCAL', vDsFaturaI))  or
      (item_f('TP_DOCUMENTO', tF_FCR_FATURAI) <> itemXmlF('TP_DOCUMENTO', vDsFaturaI))  or
      (item_f('TP_FATURAMENTO', tF_FCR_FATURAI) <> itemXmlF('TP_FATURAMENTO', vDsFaturaI))  or
      (item_f('TP_COBRANCA', tF_FCR_FATURAI) <> itemXmlF('TP_COBRANCA', vDsFaturaI))  or
      (item_f('VL_FATURA', tF_FCR_FATURAI) <> itemXmlF('VL_FATURA', vDsFaturaI))  or
      (item_f('PR_DESCANTECIP1', tF_FCR_FATURAI) <> itemXmlF('PR_DESCANTECIP1', vDsFaturaI))  or
      (item_a('DT_DESCANTECIP1', tF_FCR_FATURAI) <> itemXml('DT_DESCANTECIP1', vDsFaturaI))  or
      (item_f('PR_DESCPGPRAZO', tF_FCR_FATURAI) <> itemXmlF('PR_DESCPGPRAZO', vDsFaturaI))  or
      (item_f('PR_JUROMES', tF_FCR_FATURAI) <> itemXmlF('PR_JUROMES', vDsFaturaI))  or
      (item_f('PR_MULTA', tF_FCR_FATURAI) <> itemXmlF('PR_MULTA', vDsFaturaI))  or
      (item_f('VL_DESPFIN', tF_FCR_FATURAI) <> itemXmlF('VL_DESPFIN', vDsFaturaI))  or
      (item_f('NR_NOSSONUMERO', tF_FCR_FATURAI) <> itemXmlF('NR_NOSSONUMERO', vDsFaturaI))  or
      (item_a('DS_DACNOSSONR', tF_FCR_FATURAI) <> itemXml('DS_DACNOSSONR', vDsFaturaI));
      vInAlteracao := True;
    end;
    if (vDsLstComis <> '') then begin
      getitem(vDsComissao, vDsLstComis, 1);
      clear_e(tF_FCR_COMISSA);
      creocc(tF_FCR_COMISSA, -1);
      putitem_e(tF_FCR_COMISSA, 'CD_EMPRESA', itemXmlF('CD_EMPRESA', vDsFaturaI));
      putitem_e(tF_FCR_COMISSA, 'CD_CLIENTE', itemXmlF('CD_CLIENTE', vDsFaturaI));
      putitem_e(tF_FCR_COMISSA, 'NR_FATURA', itemXmlF('NR_FAT', vDsFaturaI));
      putitem_e(tF_FCR_COMISSA, 'NR_PARCELA', itemXmlF('NR_PARCELA', vDsFaturaI));
      putitem_e(tF_FCR_COMISSA, 'CD_PESCOMIS', itemXmlF('CD_PESCOMIS', vDsComissao));
      retrieve_o(tF_FCR_COMISSA);
      if (xStatus = -7) then begin
        retrieve_x(tF_FCR_COMISSA);
      end else begin
        vInAlteracao := True;
      end;
      if   (item_f('PR_COMISSAOFAT', tF_FCR_COMISSA) <> itemXmlF('PR_COMISSAOFAT', vDsComissao))  or
        (item_f('PR_COMISSAOREC', tF_FCR_COMISSA) <> itemXmlF('PR_COMISSAOREC', vDsComissao));
        vInAlteracao := True;
      end;
      clear_e(tF_FCR_COMISSA);
    end;
  end;

  clear_e(tF_FCR_FATURAI);
  return(0); exit;
end;

//---------------------------------------------------------------
function T_FCRSVCO001.Converterstring(pParams : String) : String;
//---------------------------------------------------------------
const
  cDS_METHOD = 'ADICONAL=Operação: T_FCRSVCO001.Converterstring()';
var
  (* string pistring :In / string postring :Out *)
  viParams,voParams : String;
begin
    putitemXml(viParams, 'DS_string', pistring);
    putitemXml(viParams, 'IN_MAIUSCULA', True);
    putitemXml(viParams, 'IN_NUMERO', True);
    putitemXml(viParams, 'IN_ESPACO', True);
    putitemXml(viParams, 'IN_ESPECIAL', False);
    putitemXml(viParams, 'IN_MANTERPONTO', True);
    voParams := activateCmp('EDISVCO020', 'limparCampo', viParams);
    postring := itemXml('DS_string', voParams);
    return(0); exit;
end;

//----------------------------------------------------
function T_FCRSVCO001.INIT(pParams : String) : String;
//----------------------------------------------------
const
  cDS_METHOD = 'ADICONAL=Operação: T_FCRSVCO001.INIT()';
begin
end;

//-------------------------------------------------------
function T_FCRSVCO001.CLEANUP(pParams : String) : String;
//-------------------------------------------------------
const
  cDS_METHOD = 'ADICONAL=Operação: T_FCRSVCO001.CLEANUP()';
begin
end;

//----------------------------------------------------------
function T_FCRSVCO001.geraFatura(pParams : String) : String;
//----------------------------------------------------------
const
  cDS_METHOD = 'ADICONAL=Operação: T_FCRSVCO001.geraFatura()';
var
  vDtSistema, vVenctoAnt, vDtDescAnt, vDtCorrecaoIndice , vDtTransacao : TDate;
  viParams, voParams, vCdComponente, vDsLstClassificacao, vDsLstFatura, vDsFaturaI, vDsCheque : String;
  vDsLstComis, vDsLstImposto, vDsConta, vListaEmpresa, vDsRegistro, vDsLstComisAux, vDsComissao, vDsIndice : String;
  vInAlteracao, vInAltSoFaturaI, vInSemComissao, vInSemImposto, vIncluido, vInOrgaopublico, vInDescarta : Boolean;
  vInNaoGrvJuro, vInNaoGrvMulta, vInNaoGrvDescAnt, vInNaoGrvDesc1, vInNaoGrvDesc2, vIndicaEmpresaOK : Boolean;
  vNrParcela, vPortadorAnt, vVlFaturaAnt, vTpCobrancaAnt, vCdEmpLocalAnt : Real;
  vVlDescPrazo, vVlTotalDesc1, vVlTotalDesc2, vCdIndice, vCdEmpTransacao, vNrTransacao : Real;
  vCdEmp,vCdCli,vNrF, vCdMotivoProrr, vPrComissaoTotal, vPrComissaoFat, vPrComissaoRec : Real;
begin
  vCdComponente := itemXmlF('CD_COMPONENTE', pParams);
  if (vCdComponente = '') then begin
    Result := SetStatus(STS_ERROR, 'GEN001', 'Não existe nome do componente chamador da rotina de gravação de fatura!', cDS_METHOD);
    return(-1); exit;
  end;

  vInAlteracao := False;
  vPortadorAnt := '';
  vCdEmpLocalAnt := '';
  vVenctoAnt := '';
  vVlFaturaAnt := '';
  vTpCobrancaAnt := '';
  vCdMotivoProrr := itemXmlF('CD_MOTIVOPRORR', pParams);
  vDsFaturaI := itemXml('DS_FATURAI', pParams);
  vDsCheque := itemXml('DS_CHEQUE', pParams);
  vDsIndice := itemXml('DS_INDICE', pParams);
  vInAltSoFaturaI := itemXmlB('IN_ALTSOFATURAI', pParams);
  vInSemComissao := itemXmlB('IN_SEMCOMISSAO', pParams);
  vInSemImposto := itemXmlB('IN_SEMIMPOSTO', pParams);
  vInNaoGrvJuro := itemXmlB('IN_NAOGRVJURO', pParams);
  vInNaoGrvMulta := itemXmlB('IN_NAOGRVMULTA', pParams);
  vInNaoGrvDescAnt := itemXmlB('IN_NAOGRVDESCANT', pParams);
  vInNaoGrvDesc1 := itemXmlB('IN_NAOGRVDESC1', pParams);
  vInNaoGrvDesc2 := True;

  vCdEmpTransacao := itemXmlF('CD_EMPTRANSACAO', pParams);
  vDtTransacao := itemXml('DT_TRANSACAO', pParams);
  vNrTransacao := itemXmlF('NR_TRANSACAO', pParams);

  vDsLstClassificacao := itemXml('DS_LSTCLASSIFICACAO', pParams);

  clear_e(tFCR_FATURAC);
  if (vDsFaturaI <> '') then begin
    vCdEmp := itemXmlF('CD_EMPRESA', vDsFaturaI);
    vCdCli := itemXmlF('CD_CLIENTE', vDsFaturaI);
    vNrF := itemXmlF('NR_FAT', vDsFaturaI);

    if (vCdEmp = 0) then begin
      Result := SetStatus(STS_ERROR, 'GEN001', 'Empresa não informada!', cDS_METHOD);
      return(-1); exit;
    end;
    if (vCdCli = 0) then begin
      Result := SetStatus(STS_ERROR, 'GEN001', 'Cliente da fatura não informada!', cDS_METHOD);
      return(-1); exit;
    end;

    clear_e(tPES_CLIENTE);
    putitem_e(tPES_CLIENTE, 'CD_CLIENTE', vCdCli);
    retrieve_e(tPES_CLIENTE);
    if (xStatus < 0) then begin
      Result := SetStatus(STS_ERROR, 'GEN001', 'Código da pessoa ' + FloatToStr(vCdCli) + ' informada não está cadastrada como cliente !', cDS_METHOD);
      return(-1); exit;
    end;
    if (vNrF = 0) then begin
      Result := SetStatus(STS_ERROR, 'GEN001', 'Número da fatura não informada!', cDS_METHOD);
      return(-1); exit;
    end;

    putitem_e(tFCR_FATURAC, 'CD_EMPRESA', vCdEmp);
    putitem_e(tFCR_FATURAC, 'CD_CLIENTE', vCdCli);
    putitem_e(tFCR_FATURAC, 'NR_FAT', vNrF);
    retrieve_o(tFCR_FATURAC);
    if (xStatus = -7) then begin
      retrieve_x(tFCR_FATURAC);
    end;

    putitem_e(tFCR_FATURAC, 'CD_CONDPAGTO', itemXmlF('CD_CONDPAGTO', pParams));

    vNrParcela := itemXmlF('NR_PARCELA', vDsFaturaI);

    if (vNrParcela = 0) then begin
      if (vInAltSoFaturaI = True) then begin
        Result := SetStatus(STS_ERROR, 'GEN001', 'Faltou a parcela da fatura alterada!', cDS_METHOD);
        return(-1); exit;
      end;

      clear_e(tFCR_FATURAI);
      creocc(tFCR_FATURAI, -1);

    end else begin
      clear_e(tFCR_FATURAI);
      putitem_e(tFCR_FATURAI, 'NR_PARCELA', vNrParcela);
      retrieve_e(tFCR_FATURAI);

      if (xStatus < 0) then begin
        if (vInAltSoFaturaI = True) then begin
          Result := SetStatus(STS_ERROR, 'GEN001', 'Fatura não encontrada!', cDS_METHOD);
          return(-1); exit;
        end;
      end else begin
        if (vInAltSoFaturaI <> True)  and %\ then begin
          (putitem_e(tFCR_FATURAI, 'TP_DOCUMENTO', 2)  and
          (putitem_e(tFCR_FATURAI, 'NR_PARCELAORIGEM', '')  and
          (item_f('TP_INCLUSAO', tFCR_FATURAI) <> 9)  and
          (vDsCheque = '');
          Result := SetStatus(STS_ERROR, 'GEN001', 'Fatura do tipo cheque, mas sem cheque para gravação!', cDS_METHOD);
          return(-1); exit;
        end;
        vInAlteracao := True;
        vPortadorAnt := item_f('NR_PORTADOR', tFCR_FATURAI);
        vCdEmpLocalAnt := item_f('CD_EMPLOCAL', tFCR_FATURAI);
        vVenctoAnt := item_a('DT_VENCIMENTO', tFCR_FATURAI);
        vVlFaturaAnt := item_f('VL_FATURA', tFCR_FATURAI);
        vTpCobrancaAnt := item_f('TP_COBRANCA', tFCR_FATURAI);
        if (vInAltSoFaturaI <> True) then begin
        end;

        delitem(vDsFaturaI, 'CD_EMPRESA');
        delitem(vDsFaturaI, 'CD_CLIENTE');
        delitem(vDsFaturaI, 'NR_FAT');
        delitem(vDsFaturaI, 'NR_PARCELA');

      end;
    end;

    getlistitensocc_e(vDsFaturaI, tFCR_FATURAI);
    if (vInAltSoFaturaI <> True) then begin
      vDsLstComis := itemXml('DS_FATCOMISSAO', vDsFaturaI);
      if (vDsLstComis = '') then begin
        if (vInSemComissao <> True) then begin
          Result := SetStatus(STS_ERROR, 'GEN001', 'Faltou a comissão para fatura!', cDS_METHOD);
          return(-1); exit;
        end;
      end else begin
        if (vInSemComissao = True) then begin
          Result := SetStatus(STS_ERROR, 'GEN001', 'Comissão foi informada com indicador apontando sem comissão!', cDS_METHOD);
          return(-1); exit;
        end;

        if not (empty(FCR_COMISSAO)) then begin
          setocc(tFCR_COMISSAO, 1);
          while (xStatus >= 0) do begin
            vInDescarta := False;
            vDsLstComisAux := vDsLstComis;
            repeat
              getitem(vDsComissao, vDsLstComisAux, 1);
              if (item_f('CD_PESCOMIS', tFCR_COMISSAO) = itemXmlF('CD_PESCOMIS', vDsComissao)) then begin
                vInDescarta := True;
              end;
              delitem(vDsLstComisAux, 1);
            until (vDsLstComisAux = '');
            if (vInDescarta = True) then begin
              discard 'FCR_COMISSAOSVC';
              if (xStatus = 0) then begin
                xStatus := -1;
              end;
            end else begin
              setocc(tFCR_COMISSAO, curocc(tFCR_COMISSAO) + 1);
            end;
          end;
          if not (empty(FCR_COMISSAO)) then begin
            voParams := tFCR_COMISSAO.Excluir();
            if (xStatus < 0) then begin
              Result := voParams;
              return(-1); exit;
            end;
          end;
        end;

        repeat
          getitem(vDsComissao, vDsLstComis, 1);
          creocc(tFCR_COMISSAO, -1);
          getlistitensocc_e(vDsComissao, tFCR_COMISSAO);

          retrieve_o(tFCR_COMISSAO);
          if (xStatus = -7) then begin
            retrieve_x(tFCR_COMISSAO);
          end;
          getlistitensocc_e(vDsComissao, tFCR_COMISSAO);

          if (item_f('PR_FATURA', tFCR_COMISSAO) = '')  or (item_f('PR_FATURA', tFCR_COMISSAO) = 0) then begin
            putitem_e(tFCR_COMISSAO, 'PR_FATURA', 100);
          end;
          if (item_f('TP_SITUACAO', tFCR_COMISSAO) = '') then begin
            putitem_e(tFCR_COMISSAO, 'TP_SITUACAO', 0);
          end;
          if (item_b('IN_FATPAGO', tFCR_COMISSAO) = '') then begin
            putitem_e(tFCR_COMISSAO, 'IN_FATPAGO', False);
          end;
          if (item_b('IN_RECPAGO', tFCR_COMISSAO) = '') then begin
            putitem_e(tFCR_COMISSAO, 'IN_RECPAGO', False);
          end;
          if (item_f('TP_DOCUMENTO', tFCR_FATURAI)   = 1)  and %\ then begin
            (putitem_e(tFCR_FATURAI, 'TP_SITUACAO', 1)  and
            (putitem_e(tFCR_FATURAI, 'TP_FATURAMENTO', 1 ) or (item_f('TP_FATURAMENTO', tFCR_FATURAI), 2));
            clear_e(tV_FCR_CONHIS);
            putitem_e(tV_FCR_CONHIS, 'CD_CLIENTE', item_f('CD_CLIENTE', tFCR_FATURAI));
            retrieve_e(tV_FCR_CONHIS);
            if (xStatus >= 0) then begin
              if (item_f('CD_CONCEITONOVO', tV_FCR_CONHIS) <> 0) then begin
                clear_e(tFCR_CONFIN);
                putitem_e(tFCR_CONFIN, 'CD_CONCEITO', item_f('CD_CONCEITONOVO', tV_FCR_CONHIS));
                retrieve_e(tFCR_CONFIN);
                if (xStatus >= 0) then begin
                  if (item_f('PR_COMISSAOFAT', tFCR_CONFIN) > 0) then begin
                    vPrComissaoTotal := item_f('PR_COMISSAOFAT', tFCR_COMISSAO) + item_f('PR_COMISSAOREC', tFCR_COMISSAO);

                    vPrComissaoFat := vPrComissaoTotal * item_f('PR_COMISSAOFAT', tFCR_CONFIN) / 100;
                    vPrComissaoFat := roundto(vPrComissaoFat, 2);
                    vPrComissaoRec := vPrComissaoTotal - vPrComissaoFat;

                    putitem_e(tFCR_COMISSAO, 'PR_COMISSAOFAT', vPrComissaoFat);
                    putitem_e(tFCR_COMISSAO, 'PR_COMISSAOREC', vPrComissaoRec);
                    putitem_e(tFCR_COMISSAO, 'VL_COMISSAOFAT', (item_f('VL_FATURA', tFCR_FATURAI) - item_f('VL_ABATIMENTO', tFCR_FATURAI)) * item_f('PR_COMISSAOFAT', tFCR_COMISSAO) / 100);
                    putitem_e(tFCR_COMISSAO, 'VL_COMISSAOFAT', roundto(item_f('VL_COMISSAOFAT', tFCR_COMISSAO), 2));
                    putitem_e(tFCR_COMISSAO, 'VL_COMISSAOREC', (item_f('VL_FATURA', tFCR_FATURAI) - item_f('VL_ABATIMENTO', tFCR_FATURAI)) * item_f('PR_COMISSAOREC', tFCR_COMISSAO) / 100);
                    putitem_e(tFCR_COMISSAO, 'VL_COMISSAOREC', roundto(item_f('VL_COMISSAOREC', tFCR_COMISSAO), 2));
                  end;
                end;
              end;
            end;
          end;
          if (item_f('PR_COMISSAOFAT', tFCR_COMISSAO) > 0)  or (item_f('PR_COMISSAOREC', tFCR_COMISSAO) > 0) then begin
            viParams := '';
            putitemXml(viParams, 'CD_EMPRESA', item_f('CD_EMPRESA', tFCR_COMISSAO));
            putitemXml(viParams, 'CD_TIPOCOMIS', item_f('CD_TIPOCOMIS', tFCR_COMISSAO));
            putitemXml(viParams, 'PR_BASEFAT', item_f('PR_COMISSAOFAT', tFCR_COMISSAO));
            putitemXml(viParams, 'PR_BASEREC', item_f('PR_COMISSAOREC', tFCR_COMISSAO));
            voParams := activateCmp('COMSVCO001', 'buscaComissaoAdicional', viParams);
            if (xStatus < 0) then begin
              Result := voParams;
              return(-1); exit;
            end;
            if (voParams <> '') then begin
              if (itemXml('PR_COMISADICFAT', voParams) > 0) then begin
                putitem_e(tFCR_COMISSAO, 'PR_COMISADICFAT', itemXmlF('PR_COMISADICFAT', voParams));
                putitem_e(tFCR_COMISSAO, 'VL_COMISADICFAT', ((item_f('VL_FATURA', tFCR_FATURAI) - item_f('VL_ABATIMENTO', tFCR_FATURAI)) * item_f('PR_COMISADICFAT', tFCR_COMISSAO)) / 100);
                putitem_e(tFCR_COMISSAO, 'VL_COMISADICFAT', roundto(item_f('VL_COMISADICFAT', tFCR_COMISSAO), 2));
                putitem_e(tFCR_COMISSAO, 'IN_ADICFATPAGO', False);
              end;
              if (itemXml('PR_COMISADICREC', voParams) > 0) then begin
                putitem_e(tFCR_COMISSAO, 'PR_COMISADICREC', itemXmlF('PR_COMISADICREC', voParams));
                putitem_e(tFCR_COMISSAO, 'VL_COMISADICREC', ((item_f('VL_FATURA', tFCR_FATURAI) - item_f('VL_ABATIMENTO', tFCR_FATURAI)) * item_f('PR_COMISADICREC', tFCR_COMISSAO)) / 100);
                putitem_e(tFCR_COMISSAO, 'VL_COMISADICREC', roundto(item_f('VL_COMISADICREC', tFCR_COMISSAO), 2));
                putitem_e(tFCR_COMISSAO, 'IN_ADICRECPAGO', False);
              end;
            end;
          end;

          delitem(vDsLstComis, 1);
        until (vDsLstComis = '');
      end;

      vDsLstImposto := itemXml('DS_FATIMPOSTO', vDsFaturaI);
      if (vDsLstImposto = '') then begin
        if (vInSemImposto <> True) then begin
          Result := SetStatus(STS_ERROR, 'GEN001', 'Faltou o imposto para fatura!', cDS_METHOD);
          return(-1); exit;
        end;
      end;
    end;
  end;

  voParams := listaEmpresaPool(viParams); (* *)

  setocc(tFCR_FATURAI, 1);
  setocc(tFCR_COMISSAO, 1);

  Result := '';

  if (empty(tFCR_FATURAI)) then begin
    Result := SetStatus(STS_ERROR, 'GEN001', 'Não existe parcela da fatura para serem salvas!', cDS_METHOD);
    return(-1); exit;
  end;
  if (item_a('DT_EMISSAO', tFCR_FATURAI) = 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN001', 'Data emissão não encontrada!', cDS_METHOD);
    return(-1); exit;
  end;

  vDtSistema := itemXml('DT_SISTEMA', PARAM_GLB);
  if (item_a('DT_EMISSAO', tFCR_FATURAI) > vDtSistema) then begin
    Result := SetStatus(STS_ERROR, 'GEN001', 'Data emissão não pode ser maior que a data do sistema!', cDS_METHOD);
    return(-1); exit;
  end;
  if (item_a('DT_VENCIMENTO', tFCR_FATURAI) = 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN001', 'Data vencimento não encontrada!', cDS_METHOD);
    return(-1); exit;
  end;
  if (item_a('DT_EMISSAO', tFCR_FATURAI) > item_a('DT_VENCIMENTO', tFCR_FATURAI)) then begin
    Result := SetStatus(STS_ERROR, 'GEN001', 'Parcela com data emissao maior que data vencimento!', cDS_METHOD);
    return(-1); exit;
  end;
  if (item_f('VL_FATURA', tFCR_FATURAI) <= 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN001', 'Parcela ' + item_a('NR_PARCELA', tFCR_FATURAI) + ' com valor incorreto!', cDS_METHOD);
    return(-1); exit;
  end;
  if (item_f('NR_PORTADOR', tFCR_FATURAI) = 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN001', 'Parcela sem portador!', cDS_METHOD);
    return(-1); exit;
  end;
  if (item_f('TP_SITUACAO', tFCR_FATURAI) = '') then begin
    Result := SetStatus(STS_ERROR, 'GEN001', 'Parcela sem tipo de situação!', cDS_METHOD);
    return(-1); exit;
  end;
  if (item_f('TP_FATURAMENTO', tFCR_FATURAI) = '') then begin
    Result := SetStatus(STS_ERROR, 'GEN001', 'Parcela sem tipo de faturamento!', cDS_METHOD);
    return(-1); exit;
  end;
  if (item_f('TP_DOCUMENTO', tFCR_FATURAI) = 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN001', 'Parcela sem tipo documento!', cDS_METHOD);
    return(-1); exit;
  end;
  if (item_f('TP_DOCUMENTO', tFCR_FATURAI) = 15) then begin
    putitem_e(tFCR_FATURAI, 'TP_DOCUMENTO', 2);
  end;
  if (item_f('CD_EMPLOCAL', tFCR_FATURAI) <> '')  and (vCdComponente = 'FCRFM001') then begin
    viParams := '';

    putitemXml(viParams, 'CD_EMPRESA', item_f('CD_EMPLOCAL', tFCR_FATURAI));
    putitemXml(viParams, 'IN_CCUSTO', True);
    putitemXml(viParams, 'CD_GRUPOEMPRESA', '>=01and<=99');
    voParams := activateCmp('FGRSVCO001', 'validarEmpresa', viParams);
    if (xStatus < 0) then begin
      Result := voParams;
      return(-1); exit;
    end;
    if (itemXml('LST_EMPRESA', voParams) = '') then begin
      Result := SetStatus(STS_ERROR, 'GEN001', 'Empresa local inválida!', cDS_METHOD);
      return(-1); exit;
    end else begin
      vIndicaEmpresaOK := False;
      vListaEmpresa := itemXml('LST_EMPRESA', voParams);
      repeat
        getitem(vDsRegistro, vListaEmpresa, 1);

        if (vDsRegistro = item_f('CD_EMPLOCAL', tFCR_FATURAI)) then begin
          vIndicaEmpresaOK := True;
        end;

        delitem(vListaEmpresa, 1);

      until (vListaEmpresa = '');

      if (vIndicaEmpresaOK = False) then begin
        Result := SetStatus(STS_ERROR, 'GEN001', 'Empresa local inválida!', cDS_METHOD);
        return(-1); exit;
      end;
    end;
  end;
  if (!dbocc(t'FCR_FATURAI'))  and %\ then begin
    (putitem_e(tFCR_FATURAI, 'TP_DOCUMENTO', 1)  and
    (putitem_e(tFCR_FATURAI, 'TP_FATURAMENTO', 1 ) or (item_f('TP_FATURAMENTO', tFCR_FATURAI), 2));
    clear_e(tPES_CLIPORTAD);
    creocc(tPES_CLIPORTAD, -1);
    putitem_e(tPES_CLIPORTAD, 'CD_CLIENTE', item_f('CD_CLIENTE', tFCR_FATURAI));
    retrieve_o(tPES_CLIPORTAD);
    if (xStatus = -7) then begin
      retrieve_x(tPES_CLIPORTAD);
      if (item_f('NR_PORTADOR', tPES_CLIPORTAD) > 0) then begin
        putitem_e(tFCR_FATURAI, 'NR_PORTADOR', item_f('NR_PORTADOR', tPES_CLIPORTAD));
      end;
    end;
    clear_e(tPES_CLIPORTAD);
  end;
  if (item_f('TP_DOCUMENTO', tFCR_FATURAI) = 4)  or (item_f('TP_DOCUMENTO', tFCR_FATURAI) = 5) then begin
    if (item_f('TP_DOCUMENTO', tFCR_FATURAI) = 4)  and (item_f('NR_HISTRELSUB', tFCR_FATURAI) = '') then begin
      Result := SetStatus(STS_ERROR, 'GEN001', 'Parcela de cartão de crédito sem informação de NR_HISTRELSUB.', cDS_METHOD);
      return(-1); exit;
    end;
    if (item_f('TP_DOCUMENTO', tFCR_FATURAI) = 5)  and (item_f('NR_HISTRELSUB', tFCR_FATURAI) = '') then begin
      Result := SetStatus(STS_ERROR, 'GEN001', 'Parcela de cartão de débito sem informação de NR_HISTRELSUB.', cDS_METHOD);
      return(-1); exit;
    end;
    clear_e(tFCX_HISTRELSU);
    putitem_e(tFCX_HISTRELSU, 'TP_DOCUMENTO', item_f('TP_DOCUMENTO', tFCR_FATURAI));
    putitem_e(tFCX_HISTRELSU, 'NR_SEQHISTRELSUB', item_f('NR_HISTRELSUB', tFCR_FATURAI));
    retrieve_e(tFCX_HISTRELSU);
    if (xStatus >= 0) then begin
      putitem_e(tFCR_FATURAI, 'NR_PARCELAS', item_f('NR_PARCELAS', tFCX_HISTRELSU));
    end;
  end else begin
    putitem_e(tFCR_FATURAI, 'NR_HISTRELSUB', 1);
    putitem_e(tFCR_FATURAI, 'NR_PARCELAS', 1);
  end;
  if (item_f('TP_INCLUSAO', tFCR_FATURAI) = 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN001', 'Parcela sem tipo de inclusão!', cDS_METHOD);
    return(-1); exit;
  end;

  voParams := buscaParametro(viParams); (* *)
  if (xStatus < 0) then begin
    Result := voParams;
    return(-1); exit;
  end;
  if (!vInAlteracao)  and (item_f('TP_BAIXA', tFCR_FATURAI) = 0)  and (item_f('TP_DOCUMENTO', tFCR_FATURAI) = 1) then begin
    if (vInNaoGrvJuro <> True)  and (item_f('PR_JUROMES', tFCR_FATURAI) = 0) then begin
      putitem_e(tFCR_FATURAI, 'NR_CARENCIAATRASO', gNrDiasCarenciaAtraso);
      putitem_e(tFCR_FATURAI, 'PR_JUROMES', gprJuros);
    end;
    if (vInNaoGrvMulta <> True)  and (item_f('PR_MULTA', tFCR_FATURAI) = 0) then begin
      putitem_e(tFCR_FATURAI, 'NR_CARENCIAMULTA', gNrDiasCarenciaMulta);
      putitem_e(tFCR_FATURAI, 'PR_MULTA', gprMulta);
    end;
    if (vInNaoGrvDescAnt <> True)  and (gNrTipoCalcDesconto = 1)  and (item_f('PR_DESCPGPRAZO', tFCR_FATURAI) = 0)  and (gprDescPont <> 0) then begin
      vDtDescAnt := item_a('DT_VENCIMENTO', tFCR_FATURAI) - gNrDiasDescPont;
      if (vDtDescAnt >= item_a('DT_EMISSAO', tFCR_FATURAI)) then begin
        putitem_e(tFCR_FATURAI, 'NR_DESCPONT', gNrDiasDescPont);
        putitem_e(tFCR_FATURAI, 'PR_DESCPGPRAZO', gprDescPont);
      end;
    end else if (item_f('PR_DESCPGPRAZO', tFCR_FATURAI) > 0) then begin
      putitem_e(tFCR_FATURAI, 'NR_DESCPONT', gNrDiasDescPont);
    end;
    if (vInNaoGrvDesc1 <> True)  and (gNrTipoCalcDesconto <> 1)  and (item_f('PR_DESCANTECIP1', tFCR_FATURAI) = 0)  and (gprDesc1 <> 0) then begin
      vDtDescAnt := item_a('DT_VENCIMENTO', tFCR_FATURAI) - gNrDiasDesc1;
      if (vDtDescAnt >= item_a('DT_EMISSAO', tFCR_FATURAI)) then begin
        putitem_e(tFCR_FATURAI, 'PR_DESCANTECIP1', gprDesc1);
        putitem_e(tFCR_FATURAI, 'DT_DESCANTECIP1', vDtDescAnt);
      end;
    end;
  end;
  if (item_f('PR_DESCPGPRAZO', tFCR_FATURAI) > 0)  and (item_f('PR_DESCANTECIP1', tFCR_FATURAI) > 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN001', 'Não é permitido desconto no prazo e desconto por dia de antecipação na mesma fatura!', cDS_METHOD);
    return(-1); exit;
  end;
  if (item_f('PR_DESCPGPRAZO', tFCR_FATURAI) >= 100) then begin
    Result := SetStatus(STS_ERROR, 'GEN001', 'Percentual de desconto no prazo nao pode ser igual ou maior que o valor da fatura!', cDS_METHOD);
    return(-1); exit;
  end;
  if (item_f('PR_DESCANTECIP1', tFCR_FATURAI) >= 100) then begin
    Result := SetStatus(STS_ERROR, 'GEN001', 'Percentual de desconto por dia de antecipação não pode ser maior que 100 porcento!', cDS_METHOD);
    return(-1); exit;
  end;
  if (item_a('DT_DESCANTECIP1', tFCR_FATURAI) <> 0) then begin
    if (item_f('PR_DESCPGPRAZO', tFCR_FATURAI) > 0) then begin
      Result := SetStatus(STS_ERROR, 'GEN001', 'Data limite do desconto por dia de antecipação informada indevidamente!', cDS_METHOD);
      return(-1); exit;
    end else if (item_f('PR_DESCANTECIP1', tFCR_FATURAI) = 0) then begin
      Result := SetStatus(STS_ERROR, 'GEN001', 'Ao informar data limite do desconto por dia antecipação, informar também o percentual para desconto por dia de antecipação!', cDS_METHOD);
      return(-1); exit;
    end;
  end;
  if (item_f('PR_DESCANTECIP1', tFCR_FATURAI) <> 0) then begin
    if (item_a('DT_DESCANTECIP1', tFCR_FATURAI) = 0) then begin
      Result := SetStatus(STS_ERROR, 'GEN001', 'Informe a data limite do desconto por dia de antecipação!', cDS_METHOD);
      return(-1); exit;
    end else if (item_a('DT_DESCANTECIP1', tFCR_FATURAI) > item_a('DT_VENCIMENTO', tFCR_FATURAI)) then begin
      Result := SetStatus(STS_ERROR, 'GEN001', 'Data limite do desconto por antecipação 1 não pode ser maior que data de vencimento!', cDS_METHOD);
      return(-1); exit;
    end;
  end;

  putitem_e(tFCR_FATURAI, 'DT_DESCANTECIP2', '');
  putitem_e(tFCR_FATURAI, 'PR_DESCANTECIP2', '');

  if (item_f('VL_OUTDESC', tFCR_FATURAI) > item_f('VL_FATURA', tFCR_FATURAI)) then begin
    Result := SetStatus(STS_ERROR, 'GEN001', 'Valor de outro desconto não pode ser maior que o valor da fatura!', cDS_METHOD);
    return(-1); exit;
  end;
  if (item_f('VL_ABATIMENTO', tFCR_FATURAI) > item_f('VL_FATURA', tFCR_FATURAI)) then begin
    Result := SetStatus(STS_ERROR, 'GEN001', 'Valor do abatimento não pode ser maior que o valor da fatura!', cDS_METHOD);
    return(-1); exit;
  end;
    if (vInAltSoFaturaI <> True) then begin
    if (empty(tFCR_COMISSAO) = False) then begin
      setocc(tFCR_COMISSAO, 1);
      while (xStatus >= 0) do begin
        putitem_e(tFCR_COMISSAO, 'CD_OPERADOR', itemXmlF('CD_USUARIO', PARAM_GLB));
        putitem_e(tFCR_COMISSAO, 'DT_CADASTRO', Now);

        if (item_f('CD_TIPOCOMIS', tFCR_COMISSAO) = 0) then begin
          Result := SetStatus(STS_ERROR, 'GEN001', 'Tipo de comissionado não informado!', cDS_METHOD);
          return(-1); exit;
        end;

        setocc(tFCR_COMISSAO, curocc(tFCR_COMISSAO) + 1);
      end;
    end;
  end;
  if (item_a('DT_VENCTOORIGEM', tFCR_FATURAI) = '') then begin
    putitem_e(tFCR_FATURAI, 'DT_VENCTOORIGEM', item_a('DT_VENCIMENTO', tFCR_FATURAI));
  end;
  if (item_f('VL_ORIGINAL', tFCR_FATURAI) = '') then begin
    putitem_e(tFCR_FATURAI, 'VL_ORIGINAL', item_f('VL_FATURA', tFCR_FATURAI));
  end;
  if (item_f('TP_COBRANCA', tFCR_FATURAI) = '') then begin
    putitem_e(tFCR_FATURAI, 'TP_COBRANCA', 0);
  end;
  if (item_f('TP_BAIXA', tFCR_FATURAI) = '') then begin
    putitem_e(tFCR_FATURAI, 'TP_BAIXA', 0);
  end;
  if (item_f('VL_PAGO', tFCR_FATURAI) = '') then begin
    putitem_e(tFCR_FATURAI, 'VL_PAGO', 0);
  end;

    putitem_e(tFCR_FATURAI, 'CD_COMPONENTE', vCdComponente);

  if (item_f('CD_MOEDA', tFCR_FATURAI) = 0) then begin
    putitem_e(tFCR_FATURAI, 'CD_MOEDA', itemXmlF('CD_MOEDA', PARAM_GLB));
  end;

  putitem_e(tFCR_FATURAI, 'CD_OPERADOR', itemXmlF('CD_USUARIO', PARAM_GLB));
  putitem_e(tFCR_FATURAI, 'DT_CADASTRO', Now);

  if (item_b('IN_ACEITE', tFCR_FATURAI) = '') then begin
    putitem_e(tFCR_FATURAI, 'IN_ACEITE', False);
  end;
  if (item_f('CD_OPERCAD', tFCR_FATURAI) = '') then begin
    putitem_e(tFCR_FATURAI, 'CD_OPERCAD', itemXmlF('CD_USUARIO', PARAM_GLB));
    putitem_e(tFCR_FATURAI, 'DT_OPERCAD', Now);
    putitem_e(tFCR_FATURAI, 'HR_OPERCAD', gclock);
  end;
  if (itemXml('IN_MANUTENCAO', pParams) = True) then begin
    viParams := vDsFaturaI;
    putitemXml(viParams, 'CD_EMPRESA', item_f('CD_EMPRESA', tFCR_FATURAI));
    putitemXml(viParams, 'CD_CLIENTE', item_f('CD_CLIENTE', tFCR_FATURAI));
    putitemXml(viParams, 'NR_FAT', item_f('NR_FAT', tFCR_FATURAI));
    putitemXml(viParams, 'NR_PARCELA', item_f('NR_PARCELA', tFCR_FATURAI));

    vDsLstComis := itemXml('DS_FATCOMISSAO', vDsFaturaI);

    voParams := verificarAlteracao(viParams); (* viParams, vDsLstComis, vInAlteracao *)
  end;
  if (vInAlteracao) then begin
    putitem_e(tFCR_FATURAI, 'CD_OPERALTERACAO', itemXmlF('CD_USUARIO', PARAM_GLB));
    putitem_e(tFCR_FATURAI, 'DT_ALTERACAO', Now);
  end;
  if (item_f('CD_EMPLOCAL', tFCR_FATURAI) = '') then begin
    putitem_e(tFCR_FATURAI, 'CD_EMPLOCAL', item_f('CD_EMPRESA', tFCR_FATURAI));

    if (gInUtilizaCxFilial = False)  and (gCdEmpresaMatriz > 0) then begin
      putitem_e(tFCR_FATURAI, 'CD_EMPLOCAL', gCdEmpresaMatriz);
    end;
  end;
  if ( vCdMotivoProrr > 0) then begin
    putitem_e(tFCR_FATURAI, 'CD_MOTIVOPRORR', vCdMotivoProrr);
  end;
  if (item_f('NR_PARCELA', tFCR_FATURAI) = 0) then begin
    vNrParcela := '';
    select max(NR_PARCELA) 
    from 'FCR_FATURAISVC' 
    where (putitem_e(tFCR_FATURAI, 'CD_EMPRESA', item_f('CD_EMPRESA', tFCR_FATURAC) ) and (
            putitem_e(tFCR_FATURAI, 'CD_CLIENTE', item_f('CD_CLIENTE', tFCR_FATURAC) ) and (
            putitem_e(tFCR_FATURAI, 'NR_FAT', item_f('NR_FAT', tFCR_FATURAC)     ) and (
                item_f('NR_PARCELA', tFCR_FATURAI) < 200)
    to vNrParcela;
    if (xStatus < 0) then begin
      Result := SetStatus(STS_ERROR, xProcerror, xProcerrorcontext, '');
      return(-1); exit;
    end else begin
      if (vNrParcela = 0) then begin
        select max(NR_PARCELA) 
        from 'FCR_FATURAISVC'    
        where (putitem_e(tFCR_FATURAI, 'CD_EMPRESA', item_f('CD_EMPRESA', tFCR_FATURAC) ) and (
                putitem_e(tFCR_FATURAI, 'CD_CLIENTE', item_f('CD_CLIENTE', tFCR_FATURAC) ) and (
                putitem_e(tFCR_FATURAI, 'NR_FAT', item_f('NR_FAT', tFCR_FATURAC))
        to vNrParcela;

      end;

      vNrParcela := vNrParcela + 1;

    end;
    putitem_e(tFCR_FATURAI, 'NR_PARCELA', vNrParcela);
  end;
  if (vDsCheque <> '') then begin
    if (item_f('TP_DOCUMENTO', tFCR_FATURAI) <> 2) then begin
      Result := SetStatus(STS_ERROR, 'GEN0001', 'Informação de cheque para fatura diferente de cheque!', cDS_METHOD);
      return(-1); exit;
    end;
    clear_e(tFCR_CHEQUE);
    putitem_e(tFCR_CHEQUE, 'CD_EMPRESA', item_f('CD_EMPRESA', tFCR_FATURAI));
    putitem_e(tFCR_CHEQUE, 'CD_CLIENTE', item_f('CD_CLIENTE', tFCR_FATURAI));
    putitem_e(tFCR_CHEQUE, 'NR_FAT', item_f('NR_FAT', tFCR_FATURAI));
    putitem_e(tFCR_CHEQUE, 'NR_PARCELA', item_f('NR_PARCELA', tFCR_FATURAI));
    retrieve_e(tFCR_CHEQUE);
    if (xStatus < 0) then begin
      clear_e(tFCR_CHEQUE);
      creocc(tFCR_CHEQUE, -1);
      getlistitensocc_e(vDsCheque, tFCR_CHEQUE);
    end else begin
      delitem(vDsCheque, 'CD_EMPRESA');
      delitem(vDsCheque, 'CD_CLIENTE');
      delitem(vDsCheque, 'NR_FAT');
      delitem(vDsCheque, 'NR_PARCELA');
      getlistitensocc_e(vDsCheque, tFCR_CHEQUE);
    end;

    vDsConta := itemXmlF('NR_CONTA', vDsCheque);
    if (item_a('DS_CONTA', tFCR_CHEQUE) = '')  and (vDsConta <> '') then begin
      putitem_e(tFCR_CHEQUE, 'DS_CONTA', vDsConta);
    end;

    putitem_e(tFCR_CHEQUE, 'IN_TERCEIRO', itemXmlB('IN_TERCEIRO', vDsCheque));

    if (item_a('DS_BANDA', tFCR_CHEQUE) <> '') then begin
      clear_e(tF_FCR_CHEQUE);
      putitem_e(tF_FCR_CHEQUE, 'DS_BANDA', item_a('DS_BANDA', tFCR_CHEQUE)[1:30]);
      if (gLstEmpresa <> '') then begin
        putitem_e(tF_FCR_CHEQUE, 'CD_EMPRESA', gLstEmpresa);
      end;
      retrieve_e(tF_FCR_CHEQUE);
      if (xStatus >= 0)  and %\ then begin
        ((item_f('CD_EMPRESA', tF_FCR_CHEQUE) <> item_f('CD_EMPRESA', tFCR_CHEQUE))  or
          (item_f('CD_CLIENTE', tF_FCR_CHEQUE) <> item_f('CD_CLIENTE', tFCR_CHEQUE))  or
          (item_f('NR_FAT', tF_FCR_CHEQUE) <> item_f('NR_FAT', tFCR_CHEQUE))  or
          (item_f('NR_PARCELA', tF_FCR_CHEQUE) <> item_f('NR_PARCELA', tFCR_CHEQUE)));
        Result := SetStatus(STS_ERROR, 'GEN0001', 'Banda magnética do cheque já foi informada para outro cheque!(Empresa=' + item_a('CD_EMPRESA', tF_FCR_CHEQUE) + ' Cliente=' + item_a('CD_CLIENTE', tF_FCR_CHEQUE) + ' Fatura=' + item_a('NR_FAT', tF_FCR_CHEQUE) + ' Parcela=' + item_a('NR_PARCELA', tF_FCR_CHEQUE))', + ' cDS_METHOD);
        return(-1); exit;
      end;

    end else begin
      if (item_f('NR_BANCO', tFCR_CHEQUE) <> '')  or %\ then begin
        (item_f('NR_AGENCIA', tFCR_CHEQUE) <> '')  or
            (item_a('DS_CONTA', tFCR_CHEQUE) <> '')  or
        (item_f('NR_CHEQUE', tFCR_CHEQUE) <> '');
        vIncluido := False;
        clear_e(tF_FCR_CHEQUE);
        putitem_e(tF_FCR_CHEQUE, 'NR_BANCO', item_f('NR_BANCO', tFCR_CHEQUE));
        putitem_e(tF_FCR_CHEQUE, 'NR_AGENCIA', item_f('NR_AGENCIA', tFCR_CHEQUE));
        putitem_e(tF_FCR_CHEQUE, 'DS_CONTA', item_a('DS_CONTA', tFCR_CHEQUE));
        putitem_e(tF_FCR_CHEQUE, 'NR_CHEQUE', item_f('NR_CHEQUE', tFCR_CHEQUE));
        retrieve_e(tF_FCR_CHEQUE);
        if (xStatus >= 0) then begin
          setocc(tF_FCR_CHEQUE, 1);
          while (xStatus >= 0) do begin
            if (item_f('CD_EMPRESA', tF_FCR_CHEQUE) <> item_f('CD_EMPRESA', tFCR_CHEQUE))  or %\ then begin
                    (item_f('CD_CLIENTE', tF_FCR_CHEQUE) <> item_f('CD_CLIENTE', tFCR_CHEQUE))  or
                (item_f('NR_FAT', tF_FCR_CHEQUE) <> item_f('NR_FAT', tFCR_CHEQUE))  or
              (item_f('NR_PARCELA', tF_FCR_CHEQUE) <> item_f('NR_PARCELA', tFCR_CHEQUE));

              clear_e(tF_FCR_FATURAI);
              putitem_e(tF_FCR_FATURAI, 'CD_EMPRESA', item_f('CD_EMPRESA', tF_FCR_CHEQUE));
              putitem_e(tF_FCR_FATURAI, 'CD_CLIENTE', item_f('CD_CLIENTE', tF_FCR_CHEQUE));
              putitem_e(tF_FCR_FATURAI, 'NR_FAT', item_f('NR_FAT', tF_FCR_CHEQUE));
              putitem_e(tF_FCR_FATURAI, 'NR_PARCELA', item_f('NR_PARCELA', tF_FCR_CHEQUE));
              retrieve_e(tF_FCR_FATURAI);
              if (xStatus >= 0) then begin
                if (item_f('TP_SITUACAO', tF_FCR_FATURAI) = 1) then begin
                  vIncluido := True;
                end;
              end;
            end;
            setocc(tF_FCR_CHEQUE, curocc(tF_FCR_CHEQUE) + 1);
          end;
        end;
        if (vIncluido = True) then begin
          Result := SetStatus(STS_ERROR, 'GEN001', , cDS_METHOD);
          return(-1); exit;
        end;
      end;
    end;
    putitem_e(tFCR_CHEQUE, 'CD_OPERADOR', itemXmlF('CD_USUARIO', PARAM_GLB));
    putitem_e(tFCR_CHEQUE, 'DT_CADASTRO', Now);
  end else begin
    if (vInAltSoFaturaI <> True)  and %\ then begin
      (putitem_e(tFCR_FATURAI, 'NR_PARCELAORIGEM', '')  and
      (putitem_e(tFCR_FATURAI, 'TP_DOCUMENTO', 2)      ) and (
      (putitem_e(tFCR_FATURAI, 'TP_INCLUSAO', '!=9'));
      Result := SetStatus(STS_ERROR, 'GEN0001', 'Fatura do tipo cheque, mas sem cheque para gravação!', cDS_METHOD);
      return(-1); exit;
    end;
  end;
  if (vDsIndice <> '') then begin
    vCdIndice := itemXmlF('CD_INDICE', vDsIndice);
    if (vCdIndice = 0) then begin
      Result := SetStatus(STS_ERROR, 'GEN001', 'Código do índice não informado!', cDS_METHOD);
      return(-1); exit;
    end;
    vDtCorrecaoIndice := itemXml('DT_CORRECAO', vDsIndice);
    if (vDtCorrecaoIndice = '') then begin
      Result := SetStatus(STS_ERROR, 'GEN001', 'Data de correção do índice não informada!', cDS_METHOD);
      return(-1); exit;
    end;
    creocc(tFCR_INDICEFAT, -1);
    putitem_e(tFCR_INDICEFAT, 'CD_INDICE', vCdIndice);
    retrieve_o(tFCR_INDICEFAT);
    if (xStatus = -7) then begin
      retrieve_x(tFCR_INDICEFAT);
    end;
    putitem_e(tFCR_INDICEFAT, 'DT_BASECORRECAO', vDtCorrecaoIndice);
    putitem_e(tFCR_INDICEFAT, 'CD_OPERADOR', itemXmlF('CD_USUARIO', PARAM_GLB));
    putitem_e(tFCR_INDICEFAT, 'DT_CADASTRO', Now);
  end;
  if (item_f('NR_PORTADOR', tFCR_FATURAI) <> vPortadorAnt)  and (vPortadorAnt <> '') then begin
    viParams := '';
    putitemXml(viParams, 'CD_EMPRESA', item_f('CD_EMPRESA', tFCR_FATURAI));
    putitemXml(viParams, 'CD_CLIENTE', item_f('CD_CLIENTE', tFCR_FATURAI));
    putitemXml(viParams, 'NR_FAT', item_f('NR_FAT', tFCR_FATURAI));
    putitemXml(viParams, 'NR_PARCELA', item_f('NR_PARCELA', tFCR_FATURAI));
    putitemXml(viParams, 'TP_LOGFAT', 1);
    putitemXml(viParams, 'NR_ORIGEM', vPortadorAnt);
    putitemXml(viParams, 'NR_DESTINO', item_f('NR_PORTADOR', tFCR_FATURAI));
    putitemXml(viParams, 'DS_COMPONENTE', vCdComponente);
    voParams := gravaLogFatura(viParams); (* PARAM_GLB, viParams, voParams, xCdErro, xCtxErro *)
    if (xStatus < 0) then begin
      Result := SetStatus(STS_ERROR, xProcerror, xProcerrorcontext, '');
      return(-1); exit;
    end;
  end;
  if (item_f('CD_EMPLOCAL', tFCR_FATURAI) <> vCdEmpLocalAnt)  and (vCdEmpLocalAnt <> '') then begin
    viParams := '';
    putitemXml(viParams, 'CD_EMPRESA', item_f('CD_EMPRESA', tFCR_FATURAI));
    putitemXml(viParams, 'CD_CLIENTE', item_f('CD_CLIENTE', tFCR_FATURAI));
    putitemXml(viParams, 'NR_FAT', item_f('NR_FAT', tFCR_FATURAI));
    putitemXml(viParams, 'NR_PARCELA', item_f('NR_PARCELA', tFCR_FATURAI));
    putitemXml(viParams, 'TP_LOGFAT', 14);
    putitemXml(viParams, 'NR_ORIGEM', vCdEmpLocalAnt);
    putitemXml(viParams, 'NR_DESTINO', item_f('CD_EMPLOCAL', tFCR_FATURAI));
    putitemXml(viParams, 'DS_COMPONENTE', vCdComponente);
    putitemXml(viParams, 'DS_OBS', 'TROCA EMP. LOCAL');
    voParams := gravaLogFatura(viParams); (* PARAM_GLB, viParams, voParams, xCdErro, xCtxErro *)
    if (xStatus < 0) then begin
      Result := SetStatus(STS_ERROR, xProcerror, xProcerrorcontext, '');
      return(-1); exit;
    end;
  end;
  if (item_a('DT_VENCIMENTO', tFCR_FATURAI) <> vVenctoAnt)  and (vVenctoAnt <> '') then begin
    viParams := '';
    putitemXml(viParams, 'CD_EMPRESA', item_f('CD_EMPRESA', tFCR_FATURAI));
    putitemXml(viParams, 'CD_CLIENTE', item_f('CD_CLIENTE', tFCR_FATURAI));
    putitemXml(viParams, 'NR_FAT', item_f('NR_FAT', tFCR_FATURAI));
    putitemXml(viParams, 'NR_PARCELA', item_f('NR_PARCELA', tFCR_FATURAI));
    putitemXml(viParams, 'TP_LOGFAT', 2);
    putitemXml(viParams, 'DT_ORIGEM', vVenctoAnt);
    putitemXml(viParams, 'DT_DESTINO', item_a('DT_VENCIMENTO', tFCR_FATURAI));
    putitemXml(viParams, 'DS_COMPONENTE', vCdComponente);
    voParams := gravaLogFatura(viParams); (* PARAM_GLB, viParams, voParams, xCdErro, xCtxErro *)
    if (xStatus < 0) then begin
      Result := SetStatus(STS_ERROR, xProcerror, xProcerrorcontext, '');
      return(-1); exit;
    end;
  end;
  if (item_f('VL_FATURA', tFCR_FATURAI) <> vVlFaturaAnt)  and (vVlFaturaAnt <> '') then begin
    viParams := '';
    putitemXml(viParams, 'CD_EMPRESA', item_f('CD_EMPRESA', tFCR_FATURAI));
    putitemXml(viParams, 'CD_CLIENTE', item_f('CD_CLIENTE', tFCR_FATURAI));
    putitemXml(viParams, 'NR_FAT', item_f('NR_FAT', tFCR_FATURAI));
    putitemXml(viParams, 'NR_PARCELA', item_f('NR_PARCELA', tFCR_FATURAI));
    putitemXml(viParams, 'TP_LOGFAT', 3);
    putitemXml(viParams, 'VL_ORIGEM', vVlFaturaAnt);
    putitemXml(viParams, 'VL_DESTINO', item_f('VL_FATURA', tFCR_FATURAI));
    putitemXml(viParams, 'DS_COMPONENTE', vCdComponente);
    voParams := gravaLogFatura(viParams); (* PARAM_GLB, viParams, voParams, xCdErro, xCtxErro *)
    if (xStatus < 0) then begin
      Result := SetStatus(STS_ERROR, xProcerror, xProcerrorcontext, '');
      return(-1); exit;
    end;
  end;
  if (item_f('TP_COBRANCA', tFCR_FATURAI) <> vTpCobrancaAnt)  and (vTpCobrancaAnt <> '') then begin
    viParams := '';
    putitemXml(viParams, 'CD_EMPRESA', item_f('CD_EMPRESA', tFCR_FATURAI));
    putitemXml(viParams, 'CD_CLIENTE', item_f('CD_CLIENTE', tFCR_FATURAI));
    putitemXml(viParams, 'NR_FAT', item_f('NR_FAT', tFCR_FATURAI));
    putitemXml(viParams, 'NR_PARCELA', item_f('NR_PARCELA', tFCR_FATURAI));
    putitemXml(viParams, 'TP_LOGFAT', 8);
    putitemXml(viParams, 'NR_ORIGEM', vTpCobrancaAnt);
    putitemXml(viParams, 'NR_DESTINO', item_f('TP_COBRANCA', tFCR_FATURAI));
    putitemXml(viParams, 'DS_COMPONENTE', vCdComponente);
    voParams := gravaLogFatura(viParams); (* PARAM_GLB, viParams, voParams, xCdErro, xCtxErro *)
    if (xStatus < 0) then begin
      Result := SetStatus(STS_ERROR, xProcerror, xProcerrorcontext, '');
      return(-1); exit;
    end;
  end;

  putitem_e(tFCR_FATURAC, 'CD_OPERADOR', itemXmlF('CD_USUARIO', PARAM_GLB));
  putitem_e(tFCR_FATURAC, 'DT_CADASTRO', Now);

  if (item_f('TP_DOCUMENTO', tFCR_FATURAI) = 3) then begin
    if (item_a('DT_LIQ', tFCR_FATURAI)= '') then begin
      Result := SetStatus(STS_ERROR, 'GEN001', 'Tipo de documento dinheiro sem liquidação!', cDS_METHOD);
      return(-1); exit;
    end;
    if (item_f('CD_OPERBAIXA', tFCR_FATURAI)='') then begin
      putitem_e(tFCR_FATURAI, 'CD_OPERBAIXA', itemXmlF('CD_USUARIO', PARAM_GLB));
    end;
    if (item_f('VL_PAGO', tFCR_FATURAI)='') then begin
      putitem_e(tFCR_FATURAI, 'VL_PAGO', item_f('VL_FATURA', tFCR_FATURAI));
    end;
    if (item_f('TP_BAIXA', tFCR_FATURAI) < 1) then begin
      putitem_e(tFCR_FATURAI, 'TP_BAIXA', 1);
    end;
    if (item_a('DT_BAIXA', tFCR_FATURAI) = '') then begin
      putitem_e(tFCR_FATURAI, 'DT_BAIXA', item_a('DT_LIQ', tFCR_FATURAI));
    end;
  end;

  putitem_e(tFCR_FATURAC, 'CD_OPERADOR', itemXmlF('CD_USUARIO', PARAM_GLB));
  putitem_e(tFCR_FATURAC, 'DT_CADASTRO', Now);
  voParams := tFCR_FATURAC.Salvar();
  if (xStatus < 0) then begin
    Result := voParams;
    return(-1); exit;
  end;
  if (item_f('TP_DOCUMENTO', tFCR_FATURAI) = 1) then begin
    viParams := '';
    putitemXml(viParams, 'CD_PESSOA', item_f('CD_CLIENTE', tFCR_FATURAI));
    voParams := activateCmp('FCRSVCO057', 'validaPessoaOrgaopublico', viParams);
    if (xStatus < 0) then begin
      Result := voParams;
      return(-1); exit;
    end;

    vInOrgaopublico := itemXmlB('IN_ORGAOpublicO', voParams);

    if (vInOrgaopublico = True) then begin
      viParams := '';
      putitemXml(viParams, 'CD_EMPRESA', item_f('CD_EMPRESA', tFCR_FATURAI));
      putitemXml(viParams, 'CD_CLIENTE', item_f('CD_CLIENTE', tFCR_FATURAI));
      putitemXml(viParams, 'NR_FAT', item_f('NR_FAT', tFCR_FATURAI));
      putitemXml(viParams, 'NR_PARCELA', item_f('NR_PARCELA', tFCR_FATURAI));
      voParams := activateCmp('FCRSVCO057', 'gravaImpostoFatura', viParams);
      if (xStatus < 0) then begin
        Result := voParams;
        return(-1); exit;
      end;
    end;
  end;
  if (vInAlteracao <> True) then begin
    if (vDsLstClassificacao <> '') then begin
      vDsLstFatura := '';
      vDsRegistro := '';
      putitemXml(vDsRegistro, 'CD_EMPRESA', item_f('CD_EMPRESA', tFCR_FATURAI));
      putitemXml(vDsRegistro, 'CD_CLIENTE', item_f('CD_CLIENTE', tFCR_FATURAI));
      putitemXml(vDsRegistro, 'NR_FAT', item_f('NR_FAT', tFCR_FATURAI));
      putitemXml(vDsRegistro, 'NR_PARCELA', item_f('NR_PARCELA', tFCR_FATURAI));
      putitem(   vDsLstFatura,  vDsRegistro);
      viParams := '';
      putitemXml(viParams, 'DS_LSTFATURA', vDsLstFatura);
      putitemXml(viParams, 'DS_LSTCLASSIFICACAO', vDsLstClassificacao);
      putitemXml(viParams, 'IN_NOVAFATURA', True);
      voParams := gravaClassificacao(viParams); (* PARAM_GLB, viParams, voParams, xCdErro, xCtxErro *)
      if (xStatus < 0) then begin
        Result := voParams;
        return(-1); exit;
      end;
      gCdTipoClasCliFat := '';
      gCdTipoClasPedFat := '';
      gCdTipoClasPrdFat := '';
    end;
    if (gCdTipoClasCliFat <> '') then begin
      viParams := '';
      putitemXml(viParams, 'CD_EMPRESA', item_f('CD_EMPRESA', tFCR_FATURAI));
      putitemXml(viParams, 'CD_CLIENTE', item_f('CD_CLIENTE', tFCR_FATURAI));
      putitemXml(viParams, 'NR_FAT', item_f('NR_FAT', tFCR_FATURAI));
      putitemXml(viParams, 'NR_PARCELA', item_f('NR_PARCELA', tFCR_FATURAI));
      putitemXml(viParams, 'LST_TPCLAS', gCdTipoClasCliFat);
      putitemXml(viParams, 'IN_NOVAFATURA', True);
      voParams := activateCmp('FCRSVCO090', 'gravarClassificacaoCliFatura', viParams);
      if (xStatus < 0) then begin
        Result := voParams;
        return(-1); exit;
      end;
    end;
    if (gCdTipoClasPedFat <> '') then begin
      viParams := '';
      putitemXml(viParams, 'CD_EMPRESA', item_f('CD_EMPRESA', tFCR_FATURAI));
      putitemXml(viParams, 'CD_CLIENTE', item_f('CD_CLIENTE', tFCR_FATURAI));
      putitemXml(viParams, 'NR_FAT', item_f('NR_FAT', tFCR_FATURAI));
      putitemXml(viParams, 'NR_PARCELA', item_f('NR_PARCELA', tFCR_FATURAI));
      putitemXml(viParams, 'LST_TPCLAS', gCdTipoClasPedFat);
      putitemXml(viParams, 'LST_TRANSACAO', itemXml('LST_TRANSACAO', pParams));
      putitemXml(viParams, 'IN_NOVAFATURA', True);
      voParams := activateCmp('FCRSVCO090', 'gravarClassificacaoPedFatura', viParams);
      if (xStatus < 0) then begin
        Result := voParams;
        return(-1); exit;
      end;
    end;
    if (gCdTipoClasPrdFat <> '') then begin
      viParams := '';
      putitemXml(viParams, 'CD_EMPRESA', item_f('CD_EMPRESA', tFCR_FATURAI));
      putitemXml(viParams, 'CD_CLIENTE', item_f('CD_CLIENTE', tFCR_FATURAI));
      putitemXml(viParams, 'NR_FAT', item_f('NR_FAT', tFCR_FATURAI));
      putitemXml(viParams, 'NR_PARCELA', item_f('NR_PARCELA', tFCR_FATURAI));
      putitemXml(viParams, 'LST_TPCLAS', gCdTipoClasPrdFat);
      putitemXml(viParams, 'LST_TRANSACAO', itemXml('LST_TRANSACAO', pParams));
      putitemXml(viParams, 'IN_NOVAFATURA', True);
      voParams := activateCmp('FCRSVCO090', 'gravarClassificacaoPrdFatura', viParams);
      if (xStatus < 0) then begin
        Result := voParams;
        return(-1); exit;
      end;
    end;
  end;
  if (vInAlteracao <> True)  and (gInVariacaoCambial = True) then begin
    viParams := '';
    putitemXml(viParams, 'CD_EMPFAT', item_f('CD_EMPRESA', tFCR_FATURAI));
    putitemXml(viParams, 'CD_CLIENTE', item_f('CD_CLIENTE', tFCR_FATURAI));
    putitemXml(viParams, 'NR_FAT', item_f('NR_FAT', tFCR_FATURAI));
    putitemXml(viParams, 'NR_PARCELA', item_f('NR_PARCELA', tFCR_FATURAI));
    putitemXml(viParams, 'LST_TRANSACAO', itemXml('LST_TRANSACAO', pParams));
    voParams := activateCmp('FCRSVCO087', 'gravaFatVariacaoVenda', viParams);
    if (xStatus < 0) then begin
      Result := voParams;
      return(-1); exit;
    end;
  end;

  Result := '';
  putitemXml(Result, 'CD_EMPRESA', item_f('CD_EMPRESA', tFCR_FATURAI));
  putitemXml(Result, 'CD_CLIENTE', item_f('CD_CLIENTE', tFCR_FATURAI));
  putitemXml(Result, 'NR_FAT', item_f('NR_FAT', tFCR_FATURAI));
  putitemXml(Result, 'NR_PARCELA', item_f('NR_PARCELA', tFCR_FATURAI));
  putitemXml(Result, 'VL_FATURA', item_f('VL_FATURA', tFCR_FATURAI));
  putitemXml(Result, 'TP_DOCUMENTO', item_f('TP_DOCUMENTO', tFCR_FATURAI));

  return(0); exit;
end;

//--------------------------------------------------------------
function T_FCRSVCO001.gravaLogFatura(pParams : String) : String;
//--------------------------------------------------------------
const
  cDS_METHOD = 'ADICONAL=Operação: T_FCRSVCO001.gravaLogFatura()';
var
  vCdEmpresa, vCdCliente, vNrFat, vNrParcela, vTpLogFat, vNrOrigem, vNrDestino, vSeqLogFat : Real;
  vVlOrigem, vVlDestino : Real;
  viParams, voParams, vDtOrigem, vDtDestino, vDsComponente, vDsObs, vDsOrigem, vDsDestino : String;
  vDsVlFaturaO, vDsVlFaturaD : String;
begin
  vCdEmpresa := itemXmlF('CD_EMPRESA', pParams);
  vCdCliente := itemXmlF('CD_CLIENTE', pParams);
  vNrFat := itemXmlF('NR_FAT', pParams);
  vNrParcela := itemXmlF('NR_PARCELA', pParams);
  vTpLogFat := itemXmlF('TP_LOGFAT', pParams);
  vNrOrigem := itemXmlF('NR_ORIGEM', pParams);
  vNrDestino := itemXmlF('NR_DESTINO', pParams);
  vDtOrigem := itemXml('DT_ORIGEM', pParams);
  vDtDestino := itemXml('DT_DESTINO', pParams);
  vVlOrigem := itemXmlF('VL_ORIGEM', pParams);
  vVlDestino := itemXmlF('VL_DESTINO', pParams);
  vDsOrigem := itemXml('DS_ORIGEM', pParams);
  vDsDestino := itemXml('DS_DESTINO', pParams);
  vDsComponente := itemXml('DS_COMPONENTE', pParams);
  vDsObs := itemXml('DS_OBS', pParams);

  viParams := '';
  putitemXml(viParams, 'CD_EMPRESA', vCdEmpresa);
  putitemXml(viParams, 'CD_CLIENTE', vCdCliente);
  putitemXml(viParams, 'NR_FAT', vNrFat);
  putitemXml(viParams, 'NR_PARCELA', vNrParcela);
  voParams := seqLogFatura(viParams); (* viParams, voParams *)
  if (xStatus < 0) then begin
    Result := voParams;
    return(-1); exit;
  end;
  vSeqLogFat := itemXmlF('NR_LOGFAT', voParams);
  if (vSeqLogFat = 0) then begin
    vSeqLogFat := 1;
  end;
  if (vTpLogFat = 1) then begin
    if (vNrOrigem = 0)  or (vNrDestino = 0) then begin
      Result := SetStatus(STS_ERROR, 'GEN001', 'Portador informado incorreto!', cDS_METHOD);
      return(-1); exit;
    end;
    if (vNrOrigem = vNrDestino) then begin
      Result := SetStatus(STS_ERROR, 'GEN001', 'Não foi trocado o portador!', cDS_METHOD);
      return(-1); exit;
    end;
    if (vDsObs <> '') then begin
      vDsObs := 'TROCA DE PORTADOR - ' + vDsObs' + ';
    end else begin
      vDsObs := 'TROCA DE PORTADOR';
    end;
  end;
  if (vTpLogFat = 2) then begin
    if (vDtOrigem = '')  or (vDtDestino = '') then begin
      Result := SetStatus(STS_ERROR, 'GEN001', 'Data de vencimento informado incorreto!', cDS_METHOD);
      return(-1); exit;
    end;
    if (vDtOrigem = vDtDestino) then begin
      Result := SetStatus(STS_ERROR, 'GEN001', 'Não foi trocada a data de vencimento!', cDS_METHOD);
      return(-1); exit;
    end;
    if (vDsObs <> '') then begin
      vDsObs := 'TROCA DA DATA DE VENCIMENTO - ' + vDsObs' + ';
    end else begin
      vDsObs := 'TROCA DA DATA DE VENCIMENTO';
    end;
  end;
  if (vTpLogFat = 3) then begin
    if (vVlOrigem = '')  or (vVlDestino = '') then begin
      Result := SetStatus(STS_ERROR, 'GEN001', 'Valor da fatura informado incorreto!', cDS_METHOD);
      return(-1); exit;
    end;
    if (vVlOrigem = vVlDestino) then begin
      Result := SetStatus(STS_ERROR, 'GEN001', 'Não foi trocado o valor da fatura!', cDS_METHOD);
      return(-1); exit;
    end;
    if (vDsObs <> '') then begin
      vDsObs := 'TROCA DO VALOR DA FATURA - ' + vDsObs' + ';
    end else begin
      vDsObs := 'TROCA DO VALOR DA FATURA';
    end;
  end;
  if (vTpLogFat = 8) then begin
    if (vNrOrigem = '')  or (vNrDestino = '') then begin
      Result := SetStatus(STS_ERROR, 'GEN001', 'Tipo de Cobrança informado incorreto!', cDS_METHOD);
      return(-1); exit;
    end;
    if (vNrOrigem = vNrDestino) then begin
      Result := SetStatus(STS_ERROR, 'GEN001', 'Não foi trocado o tipo de cobrança!', cDS_METHOD);
      return(-1); exit;
    end;
    if (vDsObs <> '') then begin
      vDsObs := 'TROCA DO TIPO DE COBRANCA - ' + vDsObs' + ';
    end else begin
      vDsObs := 'TROCA DO TIPO DE COBRANCA';
    end;
  end;

  voParams := Converterstring(viParams); (* vDsObs, vDsObs *)
  if (xStatus < 0) then begin
    Result := voParams;
    return(-1); exit;
  end;

  clear_e(tFCR_LOGFAT);
  putitem_e(tFCR_LOGFAT, 'CD_EMPRESA', vCdEmpresa);
  putitem_e(tFCR_LOGFAT, 'CD_CLIENTE', vCdCliente);
  putitem_e(tFCR_LOGFAT, 'NR_FAT', vNrFat);
  putitem_e(tFCR_LOGFAT, 'NR_PARCELA', vNrParcela);
  putitem_e(tFCR_LOGFAT, 'NR_LOGFAT', vSeqLogFat);
  putitem_e(tFCR_LOGFAT, 'CD_OPERADOR', itemXmlF('CD_USUARIO', PARAM_GLB));
  putitem_e(tFCR_LOGFAT, 'DT_CADASTRO', Now);
  putitem_e(tFCR_LOGFAT, 'TP_LOGFAT', vTpLogFat);
  putitem_e(tFCR_LOGFAT, 'DT_OPERACAO', itemXml('DT_SISTEMA', PARAM_GLB));
  putitem_e(tFCR_LOGFAT, 'NR_ORIGEM', vNrOrigem);
  putitem_e(tFCR_LOGFAT, 'NR_DESTINO', vNrDestino);
  putitem_e(tFCR_LOGFAT, 'DT_ORIGEM', vDtOrigem);
  putitem_e(tFCR_LOGFAT, 'DT_DESTINO', vDtDestino);
  putitem_e(tFCR_LOGFAT, 'VL_ORIGEM', vVlOrigem);
  putitem_e(tFCR_LOGFAT, 'VL_DESTINO', vVlDestino);
  putitem_e(tFCR_LOGFAT, 'DS_ORIGEM', vDsOrigem);
  putitem_e(tFCR_LOGFAT, 'DS_DESTINO', vDsDestino);
  putitem_e(tFCR_LOGFAT, 'DS_COMPONENTE', vDsComponente);
  putitem_e(tFCR_LOGFAT, 'DS_OBS', vDsObs[1:100]);

  voParams := tFCR_LOGFAT.Salvar();
  if (xStatus < 0) then begin
    Result := voParams;
    return(-1); exit;
  end;
end;

//------------------------------------------------------------
function T_FCRSVCO001.seqLogFatura(pParams : String) : String;
//------------------------------------------------------------
const
  cDS_METHOD = 'ADICONAL=Operação: T_FCRSVCO001.seqLogFatura()';
var
  vCdEmpresa, vCdCliente, vNrFat, vNrParcela, vSeqLogFat : Real;
begin
  vSeqLogFat := 0;
  vCdEmpresa := itemXmlF('CD_EMPRESA', pParams);
  vCdCliente := itemXmlF('CD_CLIENTE', pParams);
  vNrFat := itemXmlF('NR_FAT', pParams);
  vNrParcela := itemXmlF('NR_PARCELA', pParams);
  select max(NR_LOGFAT) 
    from 'FCR_LOGFATSVC' 
    where (putitem_e(tFCR_LOGFAT, 'CD_EMPRESA', vCdEmpresa ) and (
    putitem_e(tFCR_LOGFAT, 'CD_CLIENTE', vCdCliente ) and (
    putitem_e(tFCR_LOGFAT, 'NR_FAT', vNrFat ) and (
    putitem_e(tFCR_LOGFAT, 'NR_PARCELA', vNrParcela)
    to vSeqLogFat;

  vSeqLogFat := vSeqLogFat + 1;
  Result := '';
  putitemXml(Result, 'NR_LOGFAT', vSeqLogFat);

  return(0); exit;
end;

//--------------------------------------------------------------
function T_FCRSVCO001.buscaParametro(pParams : String) : String;
//--------------------------------------------------------------
const
  cDS_METHOD = 'ADICONAL=Operação: T_FCRSVCO001.buscaParametro()';
begin
  viParams := '';
  putitem(viParams,  'IN_CALCULO_JUROS_POR_PAR');
  putitem(viParams,  'NR_TIPO_CALC_DESCONTO');
  putitem(viParams,  'IN_VARIACAO_CAMBIAL');
  xParam := T_ADMSVCO001.GetParametro(xParam);
  gInCalculoJurosPorPar := itemXmlB('IN_CALCULO_JUROS_POR_PAR', voParams);
  gNrTipoCalcDesconto := itemXmlF('NR_TIPO_CALC_DESCONTO', voParams);
  gInVariacaoCambial := itemXmlB('IN_VARIACAO_CAMBIAL', voParams);

  xParamEmp := '';
  putitem(xParamEmp,  'NR_DIAS_CARENCIA_ATRASO');
  putitem(xParamEmp,  'NR_DIAS_CARENCIA_MULTA');
  putitem(xParamEmp,  'PR_JUROS_MENSAL_ATRASO');
  putitem(xParamEmp,  'PR_MULTA');
  putitem(xParamEmp,  'NR_DIAS_DESC_PONT');
  putitem(xParamEmp,  'PR_DESC_PONT');
  putitem(xParamEmp,  'NR_DIAS_DESC_ANTECIP1');
  putitem(xParamEmp,  'PR_DESC_ANTECIP1');
  putitem(xParamEmp,  'NR_DIAS_DESC_ANTECIP2');
  putitem(xParamEmp,  'PR_DESC_ANTECIP2');
  putitem(xParamEmp,  'IN_UTILIZA_CXFILIAL');
  putitem(xParamEmp,  'CD_TIPOCLAS_CLI_FAT');
  putitem(xParamEmp,  'CD_TIPOCLASS_PRD_FCR');
  putitem(xParamEmp,  'CD_TIPOCLAS_PED_FAT');
  putitem(xParamEmp,  'CD_TIPOCLAS_PRD_FAT');

  xParamEmp := T_ADMSVCO001.GetParamEmpresa(piCdEmpresa, xParamEmp);

  gNrDiasCarenciaAtraso := itemXmlF('NR_DIAS_CARENCIA_ATRASO', xParamEmp);
  gNrDiasCarenciaMulta := itemXmlF('NR_DIAS_CARENCIA_MULTA', xParamEmp);
  gprJuros := itemXmlF('PR_JUROS_MENSAL_ATRASO', xParamEmp);
  gprMulta := itemXmlF('PR_MULTA', xParamEmp);
  gNrDiasDescPont := itemXmlF('NR_DIAS_DESC_PONT', xParamEmp);
  gprDescPont := itemXmlF('PR_DESC_PONT', xParamEmp);
  gNrDiasDesc1 := itemXmlF('NR_DIAS_DESC_ANTECIP1', xParamEmp);
  gprDesc1 := itemXmlF('PR_DESC_ANTECIP1', xParamEmp);
  gNrDiasDesc2 := itemXmlF('NR_DIAS_DESC_ANTECIP2', xParamEmp);
  gprDesc2 := itemXmlF('PR_DESC_ANTECIP2', xParamEmp);
  gInUtilizaCxFilial := itemXmlB('IN_UTILIZA_CXFILIAL', xParamEmp);
  gCdEmpresaMatriz := itemXmlF('CD_EMPRESA_MATRIZ', xParamEmp);
  gCdTipoClasCliFat := itemXmlF('CD_TIPOCLAS_CLI_FAT', xParamEmp);
  gCdTipoClassPrdFcr := itemXmlF('CD_TIPOCLASS_PRD_FCR', xParamEmp);

  gCdTipoClasPedFat := itemXmlF('CD_TIPOCLAS_PED_FAT', xParamEmp);
  gCdTipoClasPrdFat := itemXmlF('CD_TIPOCLAS_PRD_FAT', xParamEmp);

  return(0); exit;
end;

//---------------------------------------------------------------------
function T_FCRSVCO001.gravaLiquidacaoFatura(pParams : String) : String;
//---------------------------------------------------------------------
const
  cDS_METHOD = 'ADICONAL=Operação: T_FCRSVCO001.gravaLiquidacaoFatura()';
var
  vCdEmpresa, vCdCliente, vNrFat, vNrParcela, vCdEmpLiq, vNrSeqLiq, vTpBaixa : Real;
  vDtLiq : TDate;
begin
  vCdEmpresa := itemXmlF('CD_EMPRESA', pParams);
  vCdCliente := itemXmlF('CD_CLIENTE', pParams);
  vNrFat := itemXmlF('NR_FAT', pParams);
  vNrParcela := itemXmlF('NR_PARCELA', pParams);
  vCdEmpLiq := itemXmlF('CD_EMPLIQ', pParams);
  vNrSeqLiq := itemXmlF('NR_SEQLIQ', pParams);
  vTpBaixa := itemXmlF('TP_BAIXA', pParams);

  clear_e(tFCR_FATURAC);
  putitem_e(tFCR_FATURAC, 'CD_EMPRESA', vCdEmpresa);
  putitem_e(tFCR_FATURAC, 'CD_CLIENTE', vCdCliente);
  putitem_e(tFCR_FATURAC, 'NR_FAT', vNrFat);
  retrieve_e(tFCR_FATURAC);
  if (xStatus < 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN001', 'Fatura ' + FloatToStr(vCdCliente) + ' / ' + FloatToStr(vNrFat) + ' não cadastada!', cDS_METHOD);
    return(-1); exit;
  end;

  clear_e(tFCR_FATURAI);
  putitem_e(tFCR_FATURAI, 'NR_PARCELA', vNrParcela);
  retrieve_e(tFCR_FATURAI);
  if (xStatus < 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN001', 'Parcela ' + FloatToStr(vNrParcela) + ' da fatura ' + FloatToStr(vCdCliente) + ' / ' + FloatToStr(vNrFat) + ' não cadastada!', cDS_METHOD);
    return(-1); exit;
  end;

  putitem_e(tFCR_FATURAI, 'CD_EMPLIQ', vCdEmpLiq);
  putitem_e(tFCR_FATURAI, 'DT_LIQ', vDtLiq);
  putitem_e(tFCR_FATURAI, 'NR_SEQLIQ', vNrSeqLiq);
  putitem_e(tFCR_FATURAI, 'VL_PAGO', item_f('VL_FATURA', tFCR_FATURAI));
  putitem_e(tFCR_FATURAI, 'TP_BAIXA', 1);
  putitem_e(tFCR_FATURAI, 'CD_OPERBAIXA', itemXmlF('CD_USUARIO', PARAM_GLB));

  voParams := tFCR_FATURAI.Salvar();
  if (xStatus < 0) then begin
    Result := voParams;
    return(-1); exit;
  end;

  return(0); exit;
end;

//--------------------------------------------------------------
function T_FCRSVCO001.gravaObsFatura(pParams : String) : String;
//--------------------------------------------------------------
const
  cDS_METHOD = 'ADICONAL=Operação: T_FCRSVCO001.gravaObsFatura()';
var
  (* string piGlobal :IN *)
  vDsObs, vCdComponente : String;
  vCdEmpFat, vCdCliente, vNrFat, vNrParcela, vNrLinhaObs : Real;
begin
  vCdEmpFat := itemXmlF('CD_EMPRESA', pParams);
  if (vCdEmpFat = 0)  or (vCdEmpFat = '') then begin
    Result := SetStatus(STS_ERROR, 'GEN001', , cDS_METHOD);
    return(-1); exit;
  end;
  vCdCliente := itemXmlF('CD_CLIENTE', pParams);
  if (vCdCliente = 0)  or (vCdCliente = '') then begin
    Result := SetStatus(STS_ERROR, 'GEN001', , cDS_METHOD);
    return(-1); exit;
  end;
  vNrFat := itemXmlF('NR_FAT', pParams);
  if (vNrFat = 0)  or (vNrFat = '') then begin
    Result := SetStatus(STS_ERROR, 'GEN001', , cDS_METHOD);
    return(-1); exit;
  end;
  vNrParcela := itemXmlF('NR_PARCELA', pParams);
  if (vNrParcela = 0)  or (vNrParcela = '') then begin
    Result := SetStatus(STS_ERROR, 'GEN001', , cDS_METHOD);
    return(-1); exit;
  end;
  vDsObs := itemXml('DS_OBSERVACAO', pParams);
  vCdComponente := itemXmlF('CD_COMPONENTE', pParams);

  select max(nr_linha) from 'OBS_FATI' where  (putitem_e(tOBS_FATI, 'CD_EMPRESA', vCdEmpFat   ) and (
                          putitem_e(tOBS_FATI, 'CD_CLIENTE', vCdCliente  ) and (
                          putitem_e(tOBS_FATI, 'NR_FAT', vNrFat      ) and (
                          putitem_e(tOBS_FATI, 'NR_PARCELA', vNrParcela) to vNrLinhaObs);
  if (xStatus < 0) then begin
    Result := SetStatus(STS_ERROR, xProcerror, xProcerrorcontext, '');
    return(-1); exit;
  end else begin
    if (vNrLinhaObs > 0) then begin
      vNrLinhaObs := vNrLinhaObs + 1;
    end else begin
      vNrLinhaObs := 1;
    end;
  end;

  voParams := Converterstring(viParams); (* vDsObs, vDsObs *)
  if (xStatus < 0) then begin
    Result := voParams;
    return(-1); exit;
  end;

  clear_e(tOBS_FATI);
  creocc(tOBS_FATI, -1);
  putitem_e(tOBS_FATI, 'CD_EMPRESA', vCdEmpFat);
  putitem_e(tOBS_FATI, 'CD_CLIENTE', vCdCliente);
  putitem_e(tOBS_FATI, 'NR_FAT', vNrFat);
  putitem_e(tOBS_FATI, 'NR_PARCELA', vNrParcela);
  putitem_e(tOBS_FATI, 'NR_LINHA', vNrLinhaObs);
  putitem_e(tOBS_FATI, 'CD_COMPONENTE', vCdComponente);
  putitem_e(tOBS_FATI, 'DS_OBSERVACAO', vDsObs[1:80]);
  putitem_e(tOBS_FATI, 'CD_OPERADOR', itemXmlF('CD_USUARIO', piGlobal));
  putitem_e(tOBS_FATI, 'DT_CADASTRO', Now);
  voParams := tOBS_FATI.Salvar();
  if (xStatus < 0) then begin
    Result := voParams;
    return(-1); exit;
  end;

  return(0); exit;
end;

//--------------------------------------------------------------
function T_FCRSVCO001.gravaInfCheque(pParams : String) : String;
//--------------------------------------------------------------
const
  cDS_METHOD = 'ADICONAL=Operação: T_FCRSVCO001.gravaInfCheque()';
var
  (* string piGlobal :IN *)
  vCdEmpresa, vCdCliente, vNrFatura, vNrParcela : Real;
  vDsBanda, viParams, voParams : String;
begin
  vCdEmpresa := itemXmlF('CD_EMPRESA', pParams);
  vCdCliente := itemXmlF('CD_CLIENTE', pParams);
  vNrFatura := itemXmlF('NR_FAT', pParams);
  vNrParcela := itemXmlF('NR_PARCELA', pParams);
  vDsBanda := itemXml('DS_BANDA', pParams);

  if (vCdEmpresa = '') then begin
    Result := SetStatus(STS_ERROR, 'GEN001', 'Código da empresa não informado.', cDS_METHOD);
    return(-1); exit;
  end;
  if (vCdCliente = '') then begin
    Result := SetStatus(STS_ERROR, 'GEN001', 'Código do cliente não informado.', cDS_METHOD);
    return(-1); exit;
  end;
  if (vNrFatura = '') then begin
    Result := SetStatus(STS_ERROR, 'GEN001', 'Número da fatura não informado.', cDS_METHOD);
    return(-1); exit;
  end;
  if (vNrParcela = '') then begin
    Result := SetStatus(STS_ERROR, 'GEN001', 'Número da parcela não informado.', cDS_METHOD);
    return(-1); exit;
  end;

  clear_e(tF_FCR_CHEQUE);
  putitem_e(tF_FCR_CHEQUE, 'DS_BANDA', vDsBanda);
  retrieve_e(tF_FCR_CHEQUE);
  if (xStatus >= 0) then begin
    setocc(tF_FCR_CHEQUE, 1);
    while (xStatus >= 0) do begin

      if   (item_f('CD_EMPRESA', tF_FCR_CHEQUE) <> vCdEmpresa)  or
        (item_f('CD_CLIENTE', tF_FCR_CHEQUE) <> vCdCliente)  or
        (item_f('NR_FAT', tF_FCR_CHEQUE)     <> vNrFatura)  ) or (
        (item_f('NR_PARCELA', tF_FCR_CHEQUE) <> vNrParcela);
        Result := SetStatus(STS_ERROR, 'GEN001', 'Banda magnética já lançada em outro cheque.Emp. ' + item_a('CD_EMPRESA', tF_FCR_CHEQUE) + ' Cliente ' + item_a('CD_CLIENTE', tF_FCR_CHEQUE) + ' Título ' + item_a('NR_FAT', tF_FCR_CHEQUE) + ' Parcela ' + item_a('NR_PARCELA', tF_FCR_CHEQUE).', + ' cDS_METHOD);
        return(-1); exit;
      end;

      setocc(tF_FCR_CHEQUE, curocc(tF_FCR_CHEQUE) + 1);
    end;
  end;

  viParams := '';
  putitemXml(viParams, 'NR_BANDA', vDsBanda);
  voParams := activateCmp('FGRSVCO002', 'validaBandaCheque', viParams);
  if (xStatus < 0) then begin
    Result := voParams;
    return(-1); exit;
  end;

  clear_e(tF_FCR_CHEQUE);
  putitem_e(tF_FCR_CHEQUE, 'CD_EMPRESA', vCdEmpresa);
  putitem_e(tF_FCR_CHEQUE, 'CD_CLIENTE', vCdCliente);
  putitem_e(tF_FCR_CHEQUE, 'NR_FAT', vNrFatura);
  putitem_e(tF_FCR_CHEQUE, 'NR_PARCELA', vNrParcela);
  retrieve_e(tF_FCR_CHEQUE);
  if (xStatus >= 0) then begin
    putitem_e(tF_FCR_CHEQUE, 'DS_BANDA', vDsBanda[1:30]);
    putitem_e(tF_FCR_CHEQUE, 'NR_BANCO', itemXmlF('NR_BANCO', voParams));
    putitem_e(tF_FCR_CHEQUE, 'NR_AGENCIA', itemXmlF('NR_AGENCIA', voParams));
    putitem_e(tF_FCR_CHEQUE, 'NR_CHEQUE', itemXmlF('NR_CHEQUE', voParams));
    putitem_e(tF_FCR_CHEQUE, 'DS_CONTA', itemXmlF('NR_CONTA', voParams));
    putitem_e(tF_FCR_CHEQUE, 'DS_CONTA', item_a('DS_CONTA', tF_FCR_CHEQUE)[1:20]);
    voParams := tF_FCR_CHEQUE.Salvar();
    if (xStatus < 0) then begin
      Result := voParams;
      return(-1); exit;
    end;
  end else begin
    Result := SetStatus(STS_ERROR, 'GEN001', 'Chave não encontrada.', cDS_METHOD);
    return(-1); exit;
  end;
  return(0); exit;
end;

//------------------------------------------------------------------
function T_FCRSVCO001.gravaParcelaFatura(pParams : String) : String;
//------------------------------------------------------------------
const
  cDS_METHOD = 'ADICONAL=Operação: T_FCRSVCO001.gravaParcelaFatura()';
begin
  return(0); exit;
end;

//-------------------------------------------------------------------
function T_FCRSVCO001.gravaComissaoFatura(pParams : String) : String;
//-------------------------------------------------------------------
const
  cDS_METHOD = 'ADICONAL=Operação: T_FCRSVCO001.gravaComissaoFatura()';
var
  (* string piGlobal :IN *)
  vCdEmpresa, vCdCliente, vNrFatura, vNrParcela, vCdPesComis : Real;
  viParams, voParams : String;
begin
  vCdEmpresa := itemXmlF('CD_EMPRESA', pParams);
  vCdCliente := itemXmlF('CD_CLIENTE', pParams);
  vNrFatura := itemXmlF('NR_FATURA', pParams);
  vNrParcela := itemXmlF('NR_PARCELA', pParams);
  vCdPesComis := itemXmlF('CD_PESCOMIS', pParams);

  if (vCdEmpresa = '') then begin
    Result := SetStatus(STS_ERROR, 'GEN001', 'Código da empresa não informado.', cDS_METHOD);
    return(-1); exit;
  end;
  if (vCdCliente = '') then begin
    Result := SetStatus(STS_ERROR, 'GEN001', 'Código do cliente não informado.', cDS_METHOD);
    return(-1); exit;
  end;
  if (vNrFatura = '') then begin
    Result := SetStatus(STS_ERROR, 'GEN001', 'Número da fatura não informado.', cDS_METHOD);
    return(-1); exit;
  end;
  if (vNrParcela = '') then begin
    Result := SetStatus(STS_ERROR, 'GEN001', 'Número da parcela não informado.', cDS_METHOD);
    return(-1); exit;
  end;
  if (vCdPesComis = '') then begin
    Result := SetStatus(STS_ERROR, 'GEN001', 'Código do Comissionado não informado.', cDS_METHOD);
    return(-1); exit;
  end;

  clear_e(tF_FCR_COMISSA);
  creocc(tF_FCR_COMISSA, -1);
  putitem_e(tF_FCR_COMISSA, 'CD_EMPRESA', vCdEmpresa);
  putitem_e(tF_FCR_COMISSA, 'CD_CLIENTE', vCdCliente);
  putitem_e(tF_FCR_COMISSA, 'NR_FATURA', vNrFatura);
  putitem_e(tF_FCR_COMISSA, 'NR_PARCELA', vNrParcela);
  putitem_e(tF_FCR_COMISSA, 'CD_PESCOMIS', vCdPesComis);
  retrieve_o(tF_FCR_COMISSA);
  if (xStatus = -7) then begin
    retrieve_x(tF_FCR_COMISSA);
  end;

  clear_e(tF_FCR_FATURAI);
  creocc(tF_FCR_FATURAI, -1);
  putitem_e(tF_FCR_FATURAI, 'CD_EMPRESA', vCdEmpresa);
  putitem_e(tF_FCR_FATURAI, 'CD_CLIENTE', vCdCliente);
  putitem_e(tF_FCR_FATURAI, 'NR_FAT', vNrFatura);
  putitem_e(tF_FCR_FATURAI, 'NR_PARCELA', vNrParcela);
  retrieve_o(tF_FCR_FATURAI);
  if (xStatus = -7) then begin
    retrieve_x(tF_FCR_FATURAI);
  end;

  getlistitensocc_e(pParams, tF_FCR_COMISSA);

  if (item_f('PR_COMISSAOFAT', tF_FCR_COMISSA) > 0) then begin
    putitem_e(tF_FCR_COMISSA, 'VL_COMISSAOFAT', (item_f('VL_FATURA', tF_FCR_FATURAI) - item_f('VL_ABATIMENTO', tF_FCR_FATURAI)) * item_f('PR_COMISSAOFAT', tF_FCR_COMISSA) / 100);
  end else begin
    putitem_e(tF_FCR_COMISSA, 'PR_COMISSAOFAT', '');
    putitem_e(tF_FCR_COMISSA, 'VL_COMISSAOFAT', '');
  end;
  if (item_f('PR_COMISSAOREC', tF_FCR_COMISSA) > 0) then begin
    putitem_e(tF_FCR_COMISSA, 'VL_COMISSAOREC', (item_f('VL_FATURA', tF_FCR_FATURAI) - item_f('VL_ABATIMENTO', tF_FCR_FATURAI)) * item_f('PR_COMISSAOREC', tF_FCR_COMISSA) / 100);

  end else begin
    putitem_e(tF_FCR_COMISSA, 'PR_COMISSAOREC', '');
    putitem_e(tF_FCR_COMISSA, 'VL_COMISSAOREC', '');
  end;
  if (item_f('TP_SITUACAO', tF_FCR_COMISSA) = '') then begin
    putitem_e(tF_FCR_COMISSA, 'TP_SITUACAO', 0);
  end;
  if (item_f('PR_FATURA', tF_FCR_COMISSA) = '') then begin
    putitem_e(tF_FCR_COMISSA, 'PR_FATURA', 100);
  end;
  if (item_b('IN_FATPAGO', tF_FCR_COMISSA) = '') then begin
    putitem_e(tF_FCR_COMISSA, 'IN_FATPAGO', False);
  end;
  if (item_b('IN_RECPAGO', tF_FCR_COMISSA) = '') then begin
    putitem_e(tF_FCR_COMISSA, 'IN_RECPAGO', False);
  end;

  putitem_e(tF_FCR_COMISSA, 'CD_OPERADOR', gModulo.gCdUsuario);
  putitem_e(tF_FCR_COMISSA, 'DT_CADASTRO', Now);

  voParams := tF_FCR_COMISSA.Salvar();
  if (xStatus < 0) then begin
    Result := voParams;
    return(-1); exit;
  end;
  clear_e(tF_FCR_FATURAI);
  clear_e(tF_FCR_COMISSA);

  return(0); exit;
end;

//-----------------------------------------------------------------
function T_FCRSVCO001.gravaChequeFatura(pParams : String) : String;
//-----------------------------------------------------------------
const
  cDS_METHOD = 'ADICONAL=Operação: T_FCRSVCO001.gravaChequeFatura()';
var
  (* string piGlobal :IN *)
  vCdEmpresa, vCdCliente, vNrFatura, vNrParcela : Real;
  viParams, voParams : String;
begin
  vCdEmpresa := itemXmlF('CD_EMPRESA', pParams);
  vCdCliente := itemXmlF('CD_CLIENTE', pParams);
  vNrFatura := itemXmlF('NR_FAT', pParams);
  vNrParcela := itemXmlF('NR_PARCELA', pParams);

  if (vCdEmpresa = '') then begin
    Result := SetStatus(STS_ERROR, 'GEN001', 'Código da empresa não informado.', cDS_METHOD);
    return(-1); exit;
  end;
  if (vCdCliente = '') then begin
    Result := SetStatus(STS_ERROR, 'GEN001', 'Código do cliente não informado.', cDS_METHOD);
    return(-1); exit;
  end;
  if (vNrFatura = '') then begin
    Result := SetStatus(STS_ERROR, 'GEN001', 'Número da fatura não informado.', cDS_METHOD);
    return(-1); exit;
  end;
  if (vNrParcela = '') then begin
    Result := SetStatus(STS_ERROR, 'GEN001', 'Número da parcela não informado.', cDS_METHOD);
    return(-1); exit;
  end;

  clear_e(tF_FCR_CHEQUE);
  creocc(tF_FCR_CHEQUE, -1);
  putitem_e(tF_FCR_CHEQUE, 'CD_EMPRESA', vCdEmpresa);
  putitem_e(tF_FCR_CHEQUE, 'CD_CLIENTE', vCdCliente);
  putitem_e(tF_FCR_CHEQUE, 'NR_FAT', vNrFatura);
  putitem_e(tF_FCR_CHEQUE, 'NR_PARCELA', vNrParcela);
  retrieve_o(tF_FCR_CHEQUE);
  if (xStatus = -7) then begin
    retrieve_x(tF_FCR_CHEQUE);
  end;

  getlistitensocc_e(pParams, tF_FCR_CHEQUE);

  putitem_e(tF_FCR_CHEQUE, 'CD_OPERADOR', gModulo.gCdUsuario);
  putitem_e(tF_FCR_CHEQUE, 'DT_CADASTRO', Now);

  voParams := tF_FCR_CHEQUE.Salvar();
  if (xStatus < 0) then begin
    Result := voParams;
    return(-1); exit;
  end;
  clear_e(tF_FCR_CHEQUE);

  return(0); exit;
end;

//------------------------------------------------------------------------
function T_FCRSVCO001.gravaDesctoAntecipFatura(pParams : String) : String;
//------------------------------------------------------------------------
const
  cDS_METHOD = 'ADICONAL=Operação: T_FCRSVCO001.gravaDesctoAntecipFatura()';
var
  (* string piGlobal :IN *)
  vCdEmpresa, vCdCliente, vNrFatura, vNrParcela, vPrDescAntecip1 : Real;
  viParams, voParams : String;
  vDtDescAntecip1 : TDate;
begin
  vCdEmpresa := itemXmlF('CD_EMPRESA', pParams);
  vCdCliente := itemXmlF('CD_CLIENTE', pParams);
  vNrFatura := itemXmlF('NR_FAT', pParams);
  vNrParcela := itemXmlF('NR_PARCELA', pParams);
  vPrDescAntecip1 := itemXmlF('PR_DESCANTECIP1', pParams);
  vDtDescAntecip1 := itemXml('DT_DESCANTECIP1', pParams);
  if (vCdEmpresa = '') then begin
    Result := SetStatus(STS_ERROR, 'GEN001', 'Código da empresa não informado.', cDS_METHOD);
    return(-1); exit;
  end;
  if (vCdCliente = '') then begin
    Result := SetStatus(STS_ERROR, 'GEN001', 'Código do cliente não informado.', cDS_METHOD);
    return(-1); exit;
  end;
  if (vNrFatura = '') then begin
    Result := SetStatus(STS_ERROR, 'GEN001', 'Número da fatura não informado.', cDS_METHOD);
    return(-1); exit;
  end;
  if (vNrParcela = '') then begin
    Result := SetStatus(STS_ERROR, 'GEN001', 'Número da parcela não informado.', cDS_METHOD);
    return(-1); exit;
  end;

  clear_e(tF_FCR_FATURAI);
  creocc(tF_FCR_FATURAI, -1);
  putitem_e(tF_FCR_FATURAI, 'CD_EMPRESA', vCdEmpresa);
  putitem_e(tF_FCR_FATURAI, 'CD_CLIENTE', vCdCliente);
  putitem_e(tF_FCR_FATURAI, 'NR_FAT', vNrFatura);
  putitem_e(tF_FCR_FATURAI, 'NR_PARCELA', vNrParcela);
  retrieve_o(tF_FCR_FATURAI);
  if (xStatus = -7) then begin
    retrieve_x(tF_FCR_FATURAI);
  end;

  putitem_e(tF_FCR_FATURAI, 'DT_DESCANTECIP1', vDtDescAntecip1);
  putitem_e(tF_FCR_FATURAI, 'PR_DESCANTECIP1', vPrDescAntecip1);
  putitem_e(tF_FCR_FATURAI, 'CD_OPERADOR', gModulo.gCdUsuario);
  putitem_e(tF_FCR_FATURAI, 'DT_CADASTRO', Now);
  voParams := tF_FCR_FATURAI.Salvar();
  if (xStatus < 0) then begin
    Result := voParams;
    return(-1); exit;
  end;
  clear_e(tF_FCR_FATURAI);

  return(0); exit;
end;

//---------------------------------------------------------------------
function T_FCRSVCO001.gravaAbatimentoFatura(pParams : String) : String;
//---------------------------------------------------------------------
const
  cDS_METHOD = 'ADICONAL=Operação: T_FCRSVCO001.gravaAbatimentoFatura()';
var
  (* string piGlobal :IN *)
  vCdEmpresa, vCdCliente, vNrFatura, vNrParcela, vVlAbatimento : Real;
  viParams, voParams : String;
begin
  vCdEmpresa := itemXmlF('CD_EMPRESA', pParams);
  vCdCliente := itemXmlF('CD_CLIENTE', pParams);
  vNrFatura := itemXmlF('NR_FAT', pParams);
  vNrParcela := itemXmlF('NR_PARCELA', pParams);
  vVlAbatimento := itemXmlF('VL_ABATIMENTO', pParams);

  if (vCdEmpresa = '') then begin
    Result := SetStatus(STS_ERROR, 'GEN001', 'Código da empresa não informado.', cDS_METHOD);
    return(-1); exit;
  end;
  if (vCdCliente = '') then begin
    Result := SetStatus(STS_ERROR, 'GEN001', 'Código do cliente não informado.', cDS_METHOD);
    return(-1); exit;
  end;
  if (vNrFatura = '') then begin
    Result := SetStatus(STS_ERROR, 'GEN001', 'Número da fatura não informado.', cDS_METHOD);
    return(-1); exit;
  end;
  if (vNrParcela = '') then begin
    Result := SetStatus(STS_ERROR, 'GEN001', 'Número da parcela não informado.', cDS_METHOD);
    return(-1); exit;
  end;

  clear_e(tF_FCR_FATURAI);
  creocc(tF_FCR_FATURAI, -1);
  putitem_e(tF_FCR_FATURAI, 'CD_EMPRESA', vCdEmpresa);
  putitem_e(tF_FCR_FATURAI, 'CD_CLIENTE', vCdCliente);
  putitem_e(tF_FCR_FATURAI, 'NR_FAT', vNrFatura);
  putitem_e(tF_FCR_FATURAI, 'NR_PARCELA', vNrParcela);
  retrieve_o(tF_FCR_FATURAI);
  if (xStatus = -7) then begin
    retrieve_x(tF_FCR_FATURAI);
  end;
  putitem_e(tF_FCR_FATURAI, 'VL_ABATIMENTO', vVlAbatimento);
  putitem_e(tF_FCR_FATURAI, 'CD_OPERADOR', gModulo.gCdUsuario);
  putitem_e(tF_FCR_FATURAI, 'DT_CADASTRO', Now);
  voParams := tF_FCR_FATURAI.Salvar();
  if (xStatus < 0) then begin
    Result := voParams;
    return(-1); exit;
  end;
  clear_e(tF_FCR_FATURAI);

  return(0); exit;
end;

//-------------------------------------------------------------------
function T_FCRSVCO001.gravaPortadorFatura(pParams : String) : String;
//-------------------------------------------------------------------
const
  cDS_METHOD = 'ADICONAL=Operação: T_FCRSVCO001.gravaPortadorFatura()';
var
  (* string piGlobal :IN *)
  vCdEmpresa, vCdCliente, vNrFatura, vNrParcela, vNrPortador : Real;
  viParams, voParams : String;
begin
  vCdEmpresa := itemXmlF('CD_EMPRESA', pParams);
  vCdCliente := itemXmlF('CD_CLIENTE', pParams);
  vNrFatura := itemXmlF('NR_FAT', pParams);
  vNrParcela := itemXmlF('NR_PARCELA', pParams);
  vNrPortador := itemXmlF('NR_PORTADOR', pParams);

  if (vCdEmpresa = '') then begin
    Result := SetStatus(STS_ERROR, 'GEN001', 'Código da empresa não informado.', cDS_METHOD);
    return(-1); exit;
  end;
  if (vCdCliente = '') then begin
    Result := SetStatus(STS_ERROR, 'GEN001', 'Código do cliente não informado.', cDS_METHOD);
    return(-1); exit;
  end;
  if (vNrFatura = '') then begin
    Result := SetStatus(STS_ERROR, 'GEN001', 'Número da fatura não informado.', cDS_METHOD);
    return(-1); exit;
  end;
  if (vNrParcela = '') then begin
    Result := SetStatus(STS_ERROR, 'GEN001', 'Número da parcela não informado.', cDS_METHOD);
    return(-1); exit;
  end;
  if (vNrPortador = '') then begin
    Result := SetStatus(STS_ERROR, 'GEN001', 'Número do portador não informado.', cDS_METHOD);
    return(-1); exit;
  end;

  clear_e(tF_FCR_FATURAI);
  creocc(tF_FCR_FATURAI, -1);
  putitem_e(tF_FCR_FATURAI, 'CD_EMPRESA', vCdEmpresa);
  putitem_e(tF_FCR_FATURAI, 'CD_CLIENTE', vCdCliente);
  putitem_e(tF_FCR_FATURAI, 'NR_FAT', vNrFatura);
  putitem_e(tF_FCR_FATURAI, 'NR_PARCELA', vNrParcela);
  retrieve_o(tF_FCR_FATURAI);
  if (xStatus = -7) then begin
    retrieve_x(tF_FCR_FATURAI);
  end;
  putitem_e(tF_FCR_FATURAI, 'NR_PORTADOR', vNrPortador);
  putitem_e(tF_FCR_FATURAI, 'CD_OPERADOR', gModulo.gCdUsuario);
  putitem_e(tF_FCR_FATURAI, 'DT_CADASTRO', Now);
  voParams := tF_FCR_FATURAI.Salvar();
  if (xStatus < 0) then begin
    Result := voParams;
    return(-1); exit;
  end;
  clear_e(tF_FCR_FATURAI);

  return(0); exit;
end;

//-------------------------------------------------------------------
function T_FCRSVCO001.gravaCobrancaFatura(pParams : String) : String;
//-------------------------------------------------------------------
const
  cDS_METHOD = 'ADICONAL=Operação: T_FCRSVCO001.gravaCobrancaFatura()';
var
  (* string piGlobal :IN *)
  vCdEmpresa, vCdCliente, vNrFatura, vNrParcela, vTpCobranca : Real;
  viParams, voParams : String;
begin
  vCdEmpresa := itemXmlF('CD_EMPRESA', pParams);
  vCdCliente := itemXmlF('CD_CLIENTE', pParams);
  vNrFatura := itemXmlF('NR_FAT', pParams);
  vNrParcela := itemXmlF('NR_PARCELA', pParams);
  vTpCobranca := itemXmlF('TP_COBRANCA', pParams);

  if (vCdEmpresa = '') then begin
    Result := SetStatus(STS_ERROR, 'GEN001', 'Código da empresa não informado.', cDS_METHOD);
    return(-1); exit;
  end;
  if (vCdCliente = '') then begin
    Result := SetStatus(STS_ERROR, 'GEN001', 'Código do cliente não informado.', cDS_METHOD);
    return(-1); exit;
  end;
  if (vNrFatura = '') then begin
    Result := SetStatus(STS_ERROR, 'GEN001', 'Número da fatura não informado.', cDS_METHOD);
    return(-1); exit;
  end;
  if (vNrParcela = '') then begin
    Result := SetStatus(STS_ERROR, 'GEN001', 'Número da parcela não informado.', cDS_METHOD);
    return(-1); exit;
  end;
  if (vTpCobranca = '') then begin
    Result := SetStatus(STS_ERROR, 'GEN001', 'Número do tipo de cobranca não informado.', cDS_METHOD);
    return(-1); exit;
  end;

  clear_e(tF_FCR_FATURAI);
  creocc(tF_FCR_FATURAI, -1);
  putitem_e(tF_FCR_FATURAI, 'CD_EMPRESA', vCdEmpresa);
  putitem_e(tF_FCR_FATURAI, 'CD_CLIENTE', vCdCliente);
  putitem_e(tF_FCR_FATURAI, 'NR_FAT', vNrFatura);
  putitem_e(tF_FCR_FATURAI, 'NR_PARCELA', vNrParcela);
  retrieve_o(tF_FCR_FATURAI);
  if (xStatus = -7) then begin
    retrieve_x(tF_FCR_FATURAI);
  end;
  putitem_e(tF_FCR_FATURAI, 'TP_COBRANCA', vTpCobranca);
  putitem_e(tF_FCR_FATURAI, 'CD_OPERADOR', gModulo.gCdUsuario);
  putitem_e(tF_FCR_FATURAI, 'DT_CADASTRO', Now);
  voParams := tF_FCR_FATURAI.Salvar();
  if (xStatus < 0) then begin
    Result := voParams;
    return(-1); exit;
  end;
  clear_e(tF_FCR_FATURAI);

  return(0); exit;
end;

//-------------------------------------------------------------------
function T_FCRSVCO001.regravaIndiceFatura(pParams : String) : String;
//-------------------------------------------------------------------
const
  cDS_METHOD = 'ADICONAL=Operação: T_FCRSVCO001.regravaIndiceFatura()';
var
  vDtCorrecaoIndice, vDtGerouCorrecao : TDate;
  vDsLstFatura, vDsRegistro, vCdComponente, viParams, voParams : String;
  vCdEmpresa, vNrFatura, vNrParcela, vCdCliente, vCdIndice, vCdIndiceAnt, vCdOperCorrecao : Real;
begin
  vDsLstFatura := itemXml('DS_LSTFATURA', pParams);
  vCdComponente := itemXmlF('CD_COMPONENTE', pParams);

  if (vDsLstFatura = '') then begin
    Result := SetStatus(STS_ERROR, 'GEN001', 'Lista de fatura não informada!', cDS_METHOD);
    return(-1); exit;
  end;
  if (vCdComponente = '') then begin
    Result := SetStatus(STS_ERROR, 'GEN001', 'Componente não informado!', cDS_METHOD);
    return(-1); exit;
  end;

  repeat
    getitem(vDsRegistro, vDsLstFatura, 1);

    vCdEmpresa := itemXmlF('CD_EMPRESA', vDsRegistro);
    if (vCdEmpresa = 0) then begin
      Result := SetStatus(STS_ERROR, 'GEN001', 'Código da empresa da fatura não informado.', cDS_METHOD);
      return(-1); exit;
    end;
    vNrFatura := itemXmlF('NR_FAT', vDsRegistro);
    if (vNrFatura = 0) then begin
      Result := SetStatus(STS_ERROR, 'GEN001', 'Número da fatura não informado!', cDS_METHOD);
      return(-1); exit;
    end;
    vNrParcela := itemXmlF('NR_PARCELA', vDsRegistro);
    if (vNrParcela = 0) then begin
      Result := SetStatus(STS_ERROR, 'GEN001', 'Parcela da fatura não informada!', cDS_METHOD);
      return(-1); exit;
    end;
    vCdCliente := itemXmlF('CD_CLIENTE', vDsRegistro);
    if (vCdCliente = 0) then begin
      Result := SetStatus(STS_ERROR, 'GEN001', 'Cliente da fatura não informado!', cDS_METHOD);
      return(-1); exit;
    end;
    vCdIndice := itemXmlF('CD_INDICE', vDsRegistro);
    if (vCdIndice = 0) then begin
      Result := SetStatus(STS_ERROR, 'GEN001', 'Índice da fatura não informado!', cDS_METHOD);
      return(-1); exit;
    end;
    vCdOperCorrecao := itemXmlF('CD_OPERCORRECAO', vDsRegistro);
    vDtGerouCorrecao := itemXml('DT_GEROUCORRECAO', vDsRegistro);

    creocc(tFCR_FATURAC, -1);
    putitem_e(tFCR_FATURAC, 'CD_EMPRESA', vCdEmpresa);
    putitem_e(tFCR_FATURAC, 'CD_CLIENTE', vCdCliente);
    putitem_e(tFCR_FATURAC, 'NR_FAT', vNrFatura);
    retrieve_o(tFCR_FATURAC);
    if (xStatus = -7) then begin
      retrieve_x(tFCR_FATURAC);
    end;

    creocc(tFCR_FATURAI, -1);
    putitem_e(tFCR_FATURAI, 'NR_PARCELA', vNrParcela);
    retrieve_o(tFCR_FATURAI);
    if (xStatus = -7) then begin
      retrieve_x(tFCR_FATURAI);
    end;
    if (empty(tFCR_INDICEFAT) = False) then begin
      vCdIndiceAnt := item_f('CD_INDICE', tFCR_INDICEFAT);
      vDtCorrecaoIndice := item_a('DT_BASECORRECAO', tFCR_INDICEFAT);
      if (item_f('CD_INDICE', tFCR_INDICEFAT) <> vCdIndice) then begin
        voParams := tFCR_INDICEFAT.Excluir();
        if (xStatus < 0) then begin
          Result := voParams;
          return(-1); exit;
        end;
      end else if (vCdOperCorrecao > 0)  and (vDtGerouCorrecao <> '') then begin
        creocc(tFCR_INDICEFAT, -1);
        putitem_e(tFCR_INDICEFAT, 'CD_INDICE', vCdIndice);
        retrieve_o(tFCR_INDICEFAT);
        if (xStatus = -7) then begin
          retrieve_x(tFCR_INDICEFAT);
        end;
        putitem_e(tFCR_INDICEFAT, 'CD_OPERCORRECAO', vCdOperCorrecao);
        putitem_e(tFCR_INDICEFAT, 'DT_GEROUCORRECAO', vDtGerouCorrecao);

        viParams := '';

        putitemXml(viParams, 'CD_EMPRESA', vCdEmpresa);
        putitemXml(viParams, 'CD_CLIENTE', vCdCliente);
        putitemXml(viParams, 'NR_FAT', vNrFatura);
        putitemXml(viParams, 'NR_PARCELA', vNrParcela);
        putitemXml(viParams, 'DS_OBSERVACAO', 'Correcao de indice de fatura');
        putitemXml(viParams, 'CD_COMPONENTE', vCdComponente);
        if (xStatus < 0) then begin
          Result := voParams;
          return(-1); exit;
        end;
      end;
      if (vCdIndice <> vCdIndiceAnt) then begin
        creocc(tFCR_INDICEFAT, -1);
        putitem_e(tFCR_INDICEFAT, 'CD_INDICE', vCdIndice);
        retrieve_o(tFCR_INDICEFAT);
        if (xStatus = -7) then begin
          retrieve_x(tFCR_INDICEFAT);
        end;
        putitem_e(tFCR_INDICEFAT, 'DT_BASECORRECAO', vDtCorrecaoIndice);
        putitem_e(tFCR_INDICEFAT, 'CD_OPERADOR', itemXmlF('CD_USUARIO', PARAM_GLB));
        putitem_e(tFCR_INDICEFAT, 'DT_CADASTRO', Now);

        viParams := '';

        putitemXml(viParams, 'CD_EMPRESA', vCdEmpresa);
        putitemXml(viParams, 'CD_CLIENTE', vCdCliente);
        putitemXml(viParams, 'NR_FAT', vNrFatura);
        putitemXml(viParams, 'NR_PARCELA', vNrParcela);
        putitemXml(viParams, 'DS_OBSERVACAO', 'Indice alterado de ' + FloatToStr(vCdIndiceAnt) + ' para ' + FloatToStr(vCdIndice')) + ';
        putitemXml(viParams, 'CD_COMPONENTE', vCdComponente);
        if (xStatus < 0) then begin
          Result := voParams;
          return(-1); exit;
        end;
      end;
    end else begin
      creocc(tFCR_INDICEFAT, -1);
      putitem_e(tFCR_INDICEFAT, 'CD_INDICE', vCdIndice);
      retrieve_o(tFCR_INDICEFAT);
      if (xStatus = -7) then begin
        retrieve_x(tFCR_INDICEFAT);
      end;
      putitem_e(tFCR_INDICEFAT, 'CD_OPERADOR', itemXmlF('CD_USUARIO', PARAM_GLB));
      putitem_e(tFCR_INDICEFAT, 'DT_CADASTRO', Now);

      clear_e(tFGR_INDICE);
      putitem_e(tFGR_INDICE, 'CD_INDICE', vCdIndice);
      retrieve_e(tFGR_INDICE);
      if (xStatus >= 0) then begin
        if (item_f('TP_VARIACAO', tFGR_INDICE) = 8) then begin
          addmonths -12, item_a('DT_VENCIMENTO', tFCR_FATURAI);
          putitem_e(tFCR_INDICEFAT, 'DT_BASECORRECAO', gresult);
        end;
      end;
      viParams := '';

      putitemXml(viParams, 'CD_EMPRESA', vCdEmpresa);
      putitemXml(viParams, 'CD_CLIENTE', vCdCliente);
      putitemXml(viParams, 'NR_FAT', vNrFatura);
      putitemXml(viParams, 'NR_PARCELA', vNrParcela);
      putitemXml(viParams, 'DS_OBSERVACAO', 'Correcao de indice de fatura');
      putitemXml(viParams, 'CD_COMPONENTE', vCdComponente);
      if (xStatus < 0) then begin
        Result := voParams;
        return(-1); exit;
      end;
    end;

    delitem(vDsLstFatura, 1);
  until (vDsLstFatura = '');

  voParams := tFCR_FATURAC.Salvar();
  if (xStatus < 0) then begin
    Result := voParams;
    return(-1); exit;
  end;

  return(0); exit;
end;

//--------------------------------------------------------------
function T_FCRSVCO001.inativaCliente(pParams : String) : String;
//--------------------------------------------------------------
const
  cDS_METHOD = 'ADICONAL=Operação: T_FCRSVCO001.inativaCliente()';
var
  (* string piGlobal :IN *)
  vCdCliente : Real;
  viParams, voParams : String;
begin
  vCdCliente := itemXmlF('CD_CLIENTE', pParams);
  if (vCdCliente = '') then begin
    Result := SetStatus(STS_ERROR, 'GEN001', 'Código do cliente não informado.', cDS_METHOD);
    return(-1); exit;
  end;

  clear_e(tPES_CLIENTE);
  creocc(tPES_CLIENTE, -1);
  putitem_e(tPES_CLIENTE, 'CD_CLIENTE', vCdCliente);
  retrieve_o(tPES_CLIENTE);
  if (xStatus = -7) then begin
    retrieve_x(tPES_CLIENTE);
  end;
  putitem_e(tPES_CLIENTE, 'IN_BLOQUEADO', True);
  putitem_e(tPES_CLIENTE, 'CD_OPERADOR', gModulo.gCdUsuario);
  putitem_e(tPES_CLIENTE, 'DT_CADASTRO', Now);
  voParams := tPES_CLIENTE.Salvar();
  if (xStatus < 0) then begin
    Result := voParams;
    return(-1); exit;
  end;

  return(0); exit;
end;

//------------------------------------------------------------------
function T_FCRSVCO001.gravaClassificacao(pParams : String) : String;
//------------------------------------------------------------------
const
  cDS_METHOD = 'ADICONAL=Operação: T_FCRSVCO001.gravaClassificacao()';
var
  (* string piGlobal :IN *)
  vCdEmpresa, vCdCliente, vNrFat, vNrParcela, vCdTipoClas : Real;
  vDsLstFatura, vDsLstClassificacao, vLstClassificacao, vDsRegistro, vCdClassificacao : String;
begin
  vDsLstFatura := itemXml('DS_LSTFATURA', pParams);
  vDsLstClassificacao := itemXml('DS_LSTCLASSIFICACAO', pParams);

  if (vDsLstFatura = '') then begin
    Result := SetStatus(STS_ERROR, 'GEN001', 'Lista de fatura não informada!', cDS_METHOD);
    return(-1); exit;
  end;

  repeat
    getitem(vDsRegistro, vDsLstFatura, 1);

    vCdEmpresa := itemXmlF('CD_EMPRESA', vDsRegistro);
    vCdCliente := itemXmlF('CD_CLIENTE', vDsRegistro);
    vNrFat := itemXmlF('NR_FAT', vDsRegistro);
    vNrParcela := itemXmlF('NR_PARCELA', vDsRegistro);

    if (vCdEmpresa = 0) then begin
      Result := SetStatus(STS_ERROR, 'GEN001', 'Empresa da fatura não informada!', cDS_METHOD);
      return(-1); exit;
    end;
    if (vCdCliente = 0) then begin
      Result := SetStatus(STS_ERROR, 'GEN001', 'Cliente da fatura não informada!', cDS_METHOD);
      return(-1); exit;
    end;
    if (vNrFat = 0) then begin
      Result := SetStatus(STS_ERROR, 'GEN001', 'Número da fatura não informada!', cDS_METHOD);
      return(-1); exit;
    end;
    if (vNrParcela = 0) then begin
      Result := SetStatus(STS_ERROR, 'GEN001', 'Parcela da fatura não informada!', cDS_METHOD);
      return(-1); exit;
    end;
    if (vDsLstClassificacao = '') then begin
      vLstClassificacao := itemXml('DS_LSTCLASSIFICACAO', vDsRegistro);
    end else begin
      vLstClassificacao := vDsLstClassificacao;
    end;
    if (itemXml('IN_NOVAFATURA', pParams) <> True) then begin
      clear_e(tFCR_FATCLAS);
      putitem_e(tFCR_FATCLAS, 'CD_EMPRESA', vCdEmpresa);
      putitem_e(tFCR_FATCLAS, 'CD_CLIENTE', vCdCliente);
      putitem_e(tFCR_FATCLAS, 'NR_FAT', vNrFat);
      putitem_e(tFCR_FATCLAS, 'NR_PARCELA', vNrParcela);
      retrieve_e(tFCR_FATCLAS);
      if (xStatus >= 0) then begin
        voParams := tFCR_FATCLAS.Excluir();
        if (xStatus < 0) then begin
          Result := voParams;
          return(-1); exit;
        end;
      end;
    end;
    if (vLstClassificacao <> '') then begin
      clear_e(tFCR_FATCLAS);

      repeat
        getitem(vDsRegistro, vLstClassificacao, 1);

        vCdTipoClas := itemXmlF('CD_TIPOCLAS', vDsRegistro);
        vCdClassificacao := itemXmlF('CD_CLASSIFICACAO', vDsRegistro);
        clear_e(tFCR_FATCLAS);
        creocc(tFCR_FATCLAS, -1);
        putitem_e(tFCR_FATCLAS, 'CD_EMPRESA', vCdEmpresa);
        putitem_e(tFCR_FATCLAS, 'CD_CLIENTE', vCdCliente);
        putitem_e(tFCR_FATCLAS, 'NR_FAT', vNrFat);
        putitem_e(tFCR_FATCLAS, 'NR_PARCELA', vNrParcela);
        putitem_e(tFCR_FATCLAS, 'CD_TIPOCLAS', vCdTipoClas);
        putitem_e(tFCR_FATCLAS, 'CD_CLASSIFICACAO', vCdClassificacao);
        retrieve_o(tFCR_FATCLAS);
        if (xStatus = -7) then begin
          retrieve_x(tFCR_FATCLAS);
        end;

        putitem_e(tFCR_FATCLAS, 'CD_OPERADOR', itemXmlF('CD_USUARIO', piGlobal));
        putitem_e(tFCR_FATCLAS, 'DT_CADASTRO', Now);
        voParams := tFCR_FATCLAS.Salvar();
        if (xStatus < 0) then begin
          Result := voParams;
          return(-1); exit;
        end;

        delitem(vLstClassificacao, 1);
      until (vLstClassificacao = '');
    end;

    delitem(vDsLstFatura, 1);
  until (vDsLstFatura = '');

  return(0); exit;
end;

//-------------------------------------------------------------------
function T_FCRSVCO001.validaClassificacao(pParams : String) : String;
//-------------------------------------------------------------------
const
  cDS_METHOD = 'ADICONAL=Operação: T_FCRSVCO001.validaClassificacao()';
var
  (* string piGlobal :IN *)
  vCdEmpresa, vCdCliente, vNrFat, vNrParcela, vCdTipoClas : Real;
  vDsLstClassificacao, vDsRegistro, vCdClassificacao : String;
  vInNaoAchou : Boolean;
begin
  vCdEmpresa := itemXmlF('CD_EMPRESA', pParams);
  vCdCliente := itemXmlF('CD_CLIENTE', pParams);
  vNrFat := itemXmlF('NR_FAT', pParams);
  vNrParcela := itemXmlF('NR_PARCELA', pParams);
  vDsLstClassificacao := itemXml('DS_LSTCLASSIFICACAO', pParams);

  if (vCdEmpresa = 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN001', 'Empresa da fatura não informada!', cDS_METHOD);
    return(-1); exit;
  end;
  if (vCdCliente = 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN001', 'Cliente da fatura não informado!', cDS_METHOD);
    return(-1); exit;
  end;
  if (vNrFat = 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN001', 'Número da fatura não informado!', cDS_METHOD);
    return(-1); exit;
  end;
  if (vNrParcela = 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN001', 'Parcela da fatura não informada!', cDS_METHOD);
    return(-1); exit;
  end;
  if (vDsLstClassificacao = '') then begin
    Result := SetStatus(STS_ERROR, 'GEN001', 'Lista de classificação da fatura não informada!', cDS_METHOD);
    return(-1); exit;
  end;

  vInNaoAchou := False;

  if (vDsLstClassificacao <> '') then begin
    repeat
      getitem(vDsRegistro, vDsLstClassificacao, 1);

      vCdTipoClas := itemXmlF('CD_TIPOCLAS', vDsRegistro);
      vCdClassificacao := itemXmlF('CD_CLASSIFICACAO', vDsRegistro);

      clear_e(tFCR_FATCLAS);
      putitem_e(tFCR_FATCLAS, 'CD_EMPRESA', vCdEmpresa);
      putitem_e(tFCR_FATCLAS, 'CD_CLIENTE', vCdCliente);
      putitem_e(tFCR_FATCLAS, 'NR_FAT', vNrFat);
      putitem_e(tFCR_FATCLAS, 'NR_PARCELA', vNrParcela);
      putitem_e(tFCR_FATCLAS, 'CD_TIPOCLAS', vCdTipoClas);
      putitem_e(tFCR_FATCLAS, 'CD_CLASSIFICACAO', vCdClassificacao);
      retrieve_e(tFCR_FATCLAS);
      if (xStatus < 0) then begin
        vInNaoAchou := True;
      end;

      delitem(vDsLstClassificacao, 1);
    until (vDsLstClassificacao := '')  or (vInNaoAchou := True);
  end;

  Result := '';
  putitemXml(Result, 'IN_DESCARTA', vInNaoAchou);

  return(0); exit;
end;

//------------------------------------------------------------------------
function T_FCRSVCO001.validaClassificacaoTotal(pParams : String) : String;
//------------------------------------------------------------------------
const
  cDS_METHOD = 'ADICONAL=Operação: T_FCRSVCO001.validaClassificacaoTotal()';
var
  (* string piGlobal :IN *)
  vCdEmpresa, vCdCliente, vNrFat, vNrParcela, vCdTipoClas : Real;
  vDsLstClassificacao, vDsRegistro, vCdClassificacao : String;
  vInNaoAchou : Boolean;
begin
  vCdEmpresa := itemXmlF('CD_EMPRESA', pParams);
  vCdCliente := itemXmlF('CD_CLIENTE', pParams);
  vNrFat := itemXmlF('NR_FAT', pParams);
  vNrParcela := itemXmlF('NR_PARCELA', pParams);
  vDsLstClassificacao := itemXml('DS_LSTCLASSIFICACAO', pParams);

  if (vCdEmpresa = 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN001', 'Empresa da fatura não informada!', cDS_METHOD);
    return(-1); exit;
  end;
  if (vCdCliente = 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN001', 'Cliente da fatura não informado!', cDS_METHOD);
    return(-1); exit;
  end;
  if (vNrFat = 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN001', 'Número da fatura não informado!', cDS_METHOD);
    return(-1); exit;
  end;
  if (vNrParcela = 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN001', 'Parcela da fatura não informada!', cDS_METHOD);
    return(-1); exit;
  end;
  if (vDsLstClassificacao = '') then begin
    Result := SetStatus(STS_ERROR, 'GEN001', 'Lista de classificação da fatura não informada!', cDS_METHOD);
    return(-1); exit;
  end;

  vInNaoAchou := False;

  if (vDsLstClassificacao <> '') then begin
    repeat
      getitem(vDsRegistro, vDsLstClassificacao, 1);

      vCdTipoClas := itemXmlF('CD_TIPOCLAS', vDsRegistro);
      vCdClassificacao := itemXmlF('CD_CLASSIFICACAO', vDsRegistro);

      clear_e(tFCR_FATCLAS);
      putitem_e(tFCR_FATCLAS, 'CD_EMPRESA', vCdEmpresa);
      putitem_e(tFCR_FATCLAS, 'CD_CLIENTE', vCdCliente);
      putitem_e(tFCR_FATCLAS, 'NR_FAT', vNrFat);
      putitem_e(tFCR_FATCLAS, 'NR_PARCELA', vNrParcela);
      putitem_e(tFCR_FATCLAS, 'CD_TIPOCLAS', vCdTipoClas);
      putitem_e(tFCR_FATCLAS, 'CD_CLASSIFICACAO', vCdClassificacao);
      retrieve_e(tFCR_FATCLAS);
      if (xStatus < 0) then begin
        vInNaoAchou := True;
      end;

      delitem(vDsLstClassificacao, 1);
    until (vDsLstClassificacao := '')  or (vInNaoAchou := True);
  end;

  Result := '';
  putitemXml(Result, 'IN_DESCARTA', vInNaoAchou);

  return(0); exit;
end;

//------------------------------------------------------------------
function T_FCRSVCO001.verLanctoCtbFatura(pParams : String) : String;
//------------------------------------------------------------------
const
  cDS_METHOD = 'ADICONAL=Operação: T_FCRSVCO001.verLanctoCtbFatura()';
var
  (* string piGlobal :IN *)
  vCdEmpresa, vCdCliente, vNrFat, vNrParcela : Real;
begin
  vCdEmpresa := itemXmlF('CD_EMPRESA', pParams);
  if (vCdEmpresa = '') then begin
    Result := SetStatus(STS_ERROR, 'GEN001', , cDS_METHOD);
    return(-1); exit;
  end;
  vCdCliente := itemXmlF('CD_CLIENTE', pParams);
  if (vCdCliente = '') then begin
    Result := SetStatus(STS_ERROR, 'GEN001', , cDS_METHOD);
    return(-1); exit;
  end;
  vNrFat := itemXmlF('NR_FAT', pParams);
  if (vNrFat = '') then begin
    Result := SetStatus(STS_ERROR, 'GEN001', , cDS_METHOD);
    return(-1); exit;
  end;
  vNrParcela := itemXmlF('NR_PARCELA', pParams);
  if (vNrParcela = '') then begin
    Result := SetStatus(STS_ERROR, 'GEN001', , cDS_METHOD);
    return(-1); exit;
  end;

  clear_e(tCTB_MOVTOD);
  putitem_e(tCTB_MOVTOD, 'CD_EMPRESA', vCdEmpresa);
  putitem_e(tCTB_MOVTOD, 'CD_PESSOA', vCdCliente);
  putitem_e(tCTB_MOVTOD, 'NR_FAT', vNrFat);
  putitem_e(tCTB_MOVTOD, 'NR_PARCELA', vNrParcela);
  retrieve_e(tCTB_MOVTOD);
  if (xStatus < 0) then begin
    putitemXml(Result, 'IN_CONTABILIZADO', False);
    return(0); exit;
  end;

  putitemXml(Result, 'IN_CONTABILIZADO', True);
  putitemXml(Result, 'CD_POOLEMPRESA', item_f('CD_POOLEMPRESA', tCTB_MOVTOD));
  putitemXml(Result, 'DT_EXERCONTABIL', item_a('DT_EXERCONTABIL', tCTB_MOVTOD));
  putitemXml(Result, 'NR_LOTE', item_f('NR_LOTE', tCTB_MOVTOD));
  putitemXml(Result, 'NR_ORDEM', item_f('NR_ORDEM', tCTB_MOVTOD));

  return(0); exit;

end;

//----------------------------------------------------------------
function T_FCRSVCO001.gravaDadosBoleto(pParams : String) : String;
//----------------------------------------------------------------
const
  cDS_METHOD = 'ADICONAL=Operação: T_FCRSVCO001.gravaDadosBoleto()';
var
  (* string piGlobal :IN *)
  vCdEmpresa, vCdCliente, vNrFatura, vNrParcela : Real;
  viParams, voParams, vNrNossoNumero, vDsDacNossoNr : String;
begin
  vCdEmpresa := itemXmlF('CD_EMPRESA', pParams);
  vCdCliente := itemXmlF('CD_CLIENTE', pParams);
  vNrFatura := itemXmlF('NR_FAT', pParams);
  vNrParcela := itemXmlF('NR_PARCELA', pParams);
  vNrNossoNumero := itemXmlF('NR_NOSSONUMERO', pParams);
  vDsDacNossoNr := itemXml('DS_DACNOSSONR', pParams);

  if (vCdEmpresa = '') then begin
    Result := SetStatus(STS_ERROR, 'GEN001', 'Código da empresa não informado.', cDS_METHOD);
    return(-1); exit;
  end;
  if (vCdCliente = '') then begin
    Result := SetStatus(STS_ERROR, 'GEN001', 'Código do cliente não informado.', cDS_METHOD);
    return(-1); exit;
  end;
  if (vNrFatura = '') then begin
    Result := SetStatus(STS_ERROR, 'GEN001', 'Número da fatura não informado.', cDS_METHOD);
    return(-1); exit;
  end;
  if (vNrParcela = '') then begin
    Result := SetStatus(STS_ERROR, 'GEN001', 'Número da parcela não informado.', cDS_METHOD);
    return(-1); exit;
  end;

  clear_e(tF_FCR_FATURAI);
  creocc(tF_FCR_FATURAI, -1);
  putitem_e(tF_FCR_FATURAI, 'CD_EMPRESA', vCdEmpresa);
  putitem_e(tF_FCR_FATURAI, 'CD_CLIENTE', vCdCliente);
  putitem_e(tF_FCR_FATURAI, 'NR_FAT', vNrFatura);
  putitem_e(tF_FCR_FATURAI, 'NR_PARCELA', vNrParcela);
  retrieve_o(tF_FCR_FATURAI);
  if (xStatus = -7) then begin
    retrieve_x(tF_FCR_FATURAI);
  end;
  putitem_e(tF_FCR_FATURAI, 'NR_NOSSONUMERO', vNrNossoNumero);
  putitem_e(tF_FCR_FATURAI, 'DS_DACNOSSONR', vDsDacNossoNr);
  putitem_e(tF_FCR_FATURAI, 'CD_OPERIMPFAT', gModulo.gCdUsuario);
  putitem_e(tF_FCR_FATURAI, 'DT_IMPFAT', Now);
  voParams := tF_FCR_FATURAI.Salvar();
  if (xStatus < 0) then begin
    Result := voParams;
    return(-1); exit;
  end;
  clear_e(tF_FCR_FATURAI);

  return(0); exit;
end;

//-----------------------------------------------------------------
function T_FCRSVCO001.gravaFundoPerdido(pParams : String) : String;
//-----------------------------------------------------------------
const
  cDS_METHOD = 'ADICONAL=Operação: T_FCRSVCO001.gravaFundoPerdido()';
var
  (* string piGlobal :IN *)
  vCdEmpresa, vCdCliente, vNrFatura, vNrParcela, vNrSequencia, vNrPDD, vNrDiasAtraso, vVlTotalNota : Real;
  viParams, voParams : String;
begin
  vCdEmpresa := itemXmlF('CD_EMPRESA', pParams);
  vCdCliente := itemXmlF('CD_CLIENTE', pParams);
  vNrFatura := itemXmlF('NR_FAT', pParams);
  vNrParcela := itemXmlF('NR_PARCELA', pParams);
  vNrSequencia := itemXmlF('NR_SEQUENCIA', pParams);
  vNrPDD := itemXmlF('NR_PDD', pParams);
  vNrDiasAtraso := itemXmlF('NR_DIASATRASO', pParams);
  vVlTotalNota := itemXmlF('VL_TOTALNOTA', pParams);

  if (vCdEmpresa = '') then begin
    Result := SetStatus(STS_ERROR, 'GEN001', 'Código da empresa não informado.', cDS_METHOD);
    return(-1); exit;
  end;
  if (vCdCliente = '') then begin
    Result := SetStatus(STS_ERROR, 'GEN001', 'Código do cliente não informado.', cDS_METHOD);
    return(-1); exit;
  end;
  if (vNrFatura = '') then begin
    Result := SetStatus(STS_ERROR, 'GEN001', 'Número da fatura não informado.', cDS_METHOD);
    return(-1); exit;
  end;
  if (vNrParcela = '') then begin
    Result := SetStatus(STS_ERROR, 'GEN001', 'Número da parcela não informado.', cDS_METHOD);
    return(-1); exit;
  end;
  if (vNrSequencia = '') then begin
    Result := SetStatus(STS_ERROR, 'GEN001', 'Número de sequência não informado.', cDS_METHOD);
    return(-1); exit;
  end;
  if (vNrPDD = '') then begin
    Result := SetStatus(STS_ERROR, 'GEN001', 'Número de PDD não informado.', cDS_METHOD);
    return(-1); exit;
  end;
  if (vNrDiasAtraso = '') then begin
    Result := SetStatus(STS_ERROR, 'GEN001', 'Número de dias atraso não informado.', cDS_METHOD);
    return(-1); exit;
  end;
  if (vVlTotalNota = '') then begin
    Result := SetStatus(STS_ERROR, 'GEN001', 'Valor total da nota não informado.', cDS_METHOD);
    return(-1); exit;
  end;

  clear_e(tF_FCR_FATURAI);
  putitem_e(tF_FCR_FATURAI, 'CD_EMPRESA', vCdEmpresa);
  putitem_e(tF_FCR_FATURAI, 'CD_CLIENTE', vCdCliente);
  putitem_e(tF_FCR_FATURAI, 'NR_FAT', vNrFatura);
  putitem_e(tF_FCR_FATURAI, 'NR_PARCELA', vNrParcela);
  retrieve_e(tF_FCR_FATURAI);
  if (xStatus < 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN001', 'Título Cli:' + FloatToStr(vCdCliente/) + ' Fat:' + FloatToStr(vNrFatura/) + ' Par:' + FloatToStr(vNrParcela) + ' não encontrado.', cDS_METHOD);
    return(-1); exit;
  end;

  putitem_e(tF_FCR_FATURAI, 'TP_COBRANCA', 99);
  putitem_e(tF_FCR_FATURAI, 'CD_OPERADOR', itemXmlF('CD_USUARIO', piGlobal));
  putitem_e(tF_FCR_FATURAI, 'DT_CADASTRO', Now);
  voParams := tF_FCR_FATURAI.Salvar();
  if (xStatus < 0) then begin
    Result := voParams;
    return(-1); exit;
  end;

  creocc(tFCR_FATPDD, -1);
  putitem_e(tFCR_FATPDD, 'CD_EMPPDD', itemXmlF('CD_EMPRESA', piGlobal));
  putitem_e(tFCR_FATPDD, 'DT_PDD', itemXml('DT_SISTEMA', piGlobal));
  putitem_e(tFCR_FATPDD, 'NR_PDD', vNrPDD);
  putitem_e(tFCR_FATPDD, 'NR_SEQ', vNrSequencia);
  putitem_e(tFCR_FATPDD, 'CD_OPERADOR', itemXmlF('CD_USUARIO', piGlobal));
  putitem_e(tFCR_FATPDD, 'DT_CADASTRO', Now);
  putitem_e(tFCR_FATPDD, 'CD_EMPFAT', item_f('CD_EMPRESA', tF_FCR_FATURAI));
  putitem_e(tFCR_FATPDD, 'CD_CLIENTE', item_f('CD_CLIENTE', tF_FCR_FATURAI));
  putitem_e(tFCR_FATPDD, 'NR_FAT', item_f('NR_FAT', tF_FCR_FATURAI));
  putitem_e(tFCR_FATPDD, 'NR_PARCELA', item_f('NR_PARCELA', tF_FCR_FATURAI));
  putitem_e(tFCR_FATPDD, 'DT_EMISSAO', item_a('DT_EMISSAO', tF_FCR_FATURAI));
  putitem_e(tFCR_FATPDD, 'DT_VENCIMENTO', item_a('DT_VENCIMENTO', tF_FCR_FATURAI));
  putitem_e(tFCR_FATPDD, 'NR_PORTANT', item_f('NR_PORTADOR', tF_FCR_FATURAI));
  putitem_e(tFCR_FATPDD, 'TP_COBANT', item_f('TP_COBRANCA', tF_FCR_FATURAI));
  putitem_e(tFCR_FATPDD, 'VL_FATURA', item_f('VL_FATURA', tF_FCR_FATURAI));
  putitem_e(tFCR_FATPDD, 'VL_ABATIMENTO', item_f('VL_ABATIMENTO', tF_FCR_FATURAI));
  putitem_e(tFCR_FATPDD, 'VL_NF', vVlTotalNota);
  putitem_e(tFCR_FATPDD, 'NR_ATRASO', vNrDiasAtraso);
  voParams := tFCR_FATPDD.Salvar();
  if (xStatus < 0) then begin
    Result := voParams;
    return(-1); exit;
  end;

  clear_e(tF_FCR_FATURAI);
  clear_e(tFCR_FATPDD);

  return(0); exit;
end;

//--------------------------------------------------------------
function T_FCRSVCO001.gravaFatCartao(pParams : String) : String;
//--------------------------------------------------------------
const
  cDS_METHOD = 'ADICONAL=Operação: T_FCRSVCO001.gravaFatCartao()';
var
  (* string piGlobal :IN *)
  vCdEmpresa, vCdCliente, vNrFatura, vNrParcela,vTpCartao, vCdCartao, vNrSeqCartao, vPrTaxaAdm : Real;
  vCdAutorizacao, vNrNsu, vVlCompra, vNrParcelas, vNrNf, vCdEmpOri, vCdCliOri, vNrFatOri : Real;
  vNrRv, vNrPv, vTpRegoOper, vNrParOri : Real;
  vDtCredito, vDtCompra, vDtRv : TDate;
  viParams, voParams : String;
begin
  vCdEmpresa := itemXmlF('CD_EMPRESA', pParams);
  vCdCliente := itemXmlF('CD_CLIENTE', pParams);
  vNrFatura := itemXmlF('NR_FAT', pParams);
  vNrParcela := itemXmlF('NR_PARCELA', pParams);
  vTpCartao := itemXmlF('TP_CARTAO', pParams);
  vCdCartao := itemXmlF('CD_CARTAO', pParams);
  vNrSeqCartao := itemXmlF('NR_SEQCARTAO', pParams);
  vCdAutorizacao := itemXmlF('CD_AUTORIZACAO', pParams);
  vNrNsu := itemXmlF('NR_NSU', pParams);
  vDtCompra := itemXml('DT_COMPRA', pParams);
  vVlCompra := itemXmlF('VL_COMPRA', pParams);
  vNrParcelas := itemXmlF('NR_PARCELAS', pParams);
  vNrNf := itemXmlF('NR_NF', pParams);
  vCdEmpOri := itemXmlF('CD_EMPORI', pParams);
  vCdCliOri := itemXmlF('CD_CLIORI', pParams);
  vNrFatOri := itemXmlF('NR_FATORI', pParams);
  vNrParOri := itemXmlF('NR_PARORI', pParams);
  vPrTaxaAdm := itemXmlF('PR_TAXAADM', pParams);
  vNrRv := itemXmlF('NR_RV', pParams);
  vDtRv := itemXml('DT_RV', pParams);
  vNrPv := itemXmlF('NR_PV', pParams);
  vTpRegoOper := itemXmlF('TP_REGOOPER', pParams);
  vDtCredito := itemXml('DT_CREDITO', pParams);

  if (vCdEmpresa = '') then begin
    Result := SetStatus(STS_ERROR, 'GEN001', 'Empresa da fatura não informada.', cDS_METHOD);
    return(-1); exit;
  end;
  if (vCdCliente = '') then begin
    Result := SetStatus(STS_ERROR, 'GEN001', 'Cliente da fatura não informado.', cDS_METHOD);
    return(-1); exit;
  end;
  if (vNrFatura = '') then begin
    Result := SetStatus(STS_ERROR, 'GEN001', 'Número da fatura não informado.', cDS_METHOD);
    return(-1); exit;
  end;
  if (vNrParcela = '') then begin
    Result := SetStatus(STS_ERROR, 'GEN001', 'Número da parcela não informado.', cDS_METHOD);
    return(-1); exit;
  end;

  creocc(tFCR_FATCARTAO, -1);
  putitem_e(tFCR_FATCARTAO, 'CD_EMPRESA', vCdEmpresa);
  putitem_e(tFCR_FATCARTAO, 'CD_CLIENTE', vCdCliente);
  putitem_e(tFCR_FATCARTAO, 'NR_FAT', vNrFatura);
  putitem_e(tFCR_FATCARTAO, 'NR_PARCELA', vNrParcela);
  retrieve_o(tFCR_FATCARTAO);
  if (xStatus = 4)  or (xStatus = -7) then begin
    retrieve_x(tFCR_FATCARTAO);
  end;

  putitem_e(tFCR_FATCARTAO, 'CD_OPERADOR', itemXmlF('CD_USUARIO', piGlobal));
  putitem_e(tFCR_FATCARTAO, 'DT_CADASTRO', Now);
  putitem_e(tFCR_FATCARTAO, 'TP_CARTAO', vTpCartao);
  putitem_e(tFCR_FATCARTAO, 'NR_RV', vNrRv);
  putitem_e(tFCR_FATCARTAO, 'DT_RV', vDtRv);
  putitem_e(tFCR_FATCARTAO, 'NR_PV', vNrPv);
  putitem_e(tFCR_FATCARTAO, 'TP_REGOOPER', vTpRegoOper);
  putitem_e(tFCR_FATCARTAO, 'DT_CREDITO', vDtCredito);
  voParams := tFCR_FATCARTAO.Salvar();
  if (xStatus < 0) then begin
    Result := voParams;
    return(-1); exit;
  end;

  return(0); exit;
end;


end.
