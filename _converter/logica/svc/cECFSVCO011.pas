unit cECFSVCO011;

interface

(* COMPONENTES 
  ADMSVCO001 / ECFSVCO001 / ECFSVCO011 / FISSVCO008 / GERFP008
  KERNEL32 / PESSVCO005 / vbfileman / 
*)        

uses
  Classes, SysUtils, DB,
  cServiceUnf, cDataSetUnf;

type
  T_ECFSVCO011 = class(TcServiceUnf)
  private
    tF_TMP_NR09,
    tFCC_AUTOCHEQ,
    tFCC_AUTORIZAC,
    tFCC_CTAPES,
    tFIS_DNF,
    tFIS_ECF,
    tFIS_ECFADIC,
    tFIS_MPGTO,
    tGER_EMPRESA,
    tGER_TERMINALP,
    tGLB_CHAVE,
    tGLB_PERIFERIC,
    tPES_PESSOA,
    tV_PES_ENDEREC : TcDatasetUnf;
    function getParam(pParams : String = '') : String;
    function setEntidade(pParams : String = '') : String;
  protected
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;    
  published
    function espacoDireita(pParams : String = '') : String;
    function preencheZero(pParams : String = '') : String;
    function achaNumero(pParams : String = '') : String;
    function extraiValor(pParams : String = '') : String;
    function verificaConteudo(pParams : String = '') : String;
    function INIT(pParams : String = '') : String;
    function CLEANUP(pParams : String = '') : String;
    function aberturaDoDia(pParams : String = '') : String;
    function abreCupom(pParams : String = '') : String;
    function vendeItem(pParams : String = '') : String;
    function acrescimoDescontoItem(pParams : String = '') : String;
    function acrescimoDescontoCupom(pParams : String = '') : String;
    function formaPagamento(pParams : String = '') : String;
    function fechaCupom(pParams : String = '') : String;
    function leituraX(pParams : String = '') : String;
    function cancelaCupom(pParams : String = '') : String;
    function verificarEstado(pParams : String = '') : String;
    function leInformacaoImpressora(pParams : String = '') : String;
    function reducaoZ(pParams : String = '') : String;
    function registroTipo60(pParams : String = '') : String;
    function relatorioTipo60Mestre(pParams : String = '') : String;
    function relatorioTipo60Analitico(pParams : String = '') : String;
    function leituraMemoriaFiscalData(pParams : String = '') : String;
    function leituraMemoriaFiscalSerialData(pParams : String = '') : String;
    function leituraMemoriaFiscalReducao(pParams : String = '') : String;
    function leituraMemoriaFiscalSerialRed(pParams : String = '') : String;
    function suprimento(pParams : String = '') : String;
    function sangria(pParams : String = '') : String;
    function abreComprovanteNFNV(pParams : String = '') : String;
    function abreComprovanteNFV(pParams : String = '') : String;
    function imprimeVinculado(pParams : String = '') : String;
    function fechaVinculado(pParams : String = '') : String;
    function imprimirRelatorioGerencial(pParams : String = '') : String;
    function fechaRelatorioGerencial(pParams : String = '') : String;
    function cancelaItem(pParams : String = '') : String;
    function abreGaveta(pParams : String = '') : String;
    function imprimeCheque(pParams : String = '') : String;
    function imprimeTextoViaMonitor(pParams : String = '') : String;
    function trataFocoTEF(pParams : String = '') : String;
    function convnumeric(pParams : String = '') : String;
    function editarNr(pParams : String = '') : String;
    function convValorstring(pParams : String = '') : String;
    function progHoraVerao(pParams : String = '') : String;
    function imprimeEtiqViaMonitor(pParams : String = '') : String;
    function relatorioSintegraMFD(pParams : String = '') : String;
    function downloadMFD(pParams : String = '') : String;
    function formatoDadosMFD(pParams : String = '') : String;
    function dataHoraImpressora(pParams : String = '') : String;
    function modeloImpressora(pParams : String = '') : String;
    function autentica(pParams : String = '') : String;
    function geraRegistrosCAT52MFD(pParams : String = '') : String;
    function abreRelatorioGerencial(pParams : String = '') : String;
    function verificaTermica(pParams : String = '') : String;
    function leCheque(pParams : String = '') : String;
    function geraRelatorioGerencial(pParams : String = '') : String;
    function leituraMemoriaFiscalDataMFD(pParams : String = '') : String;
    function leituraMemoriaFiscalReducaoMFD(pParams : String = '') : String;
    function leMemoriaFiscalSerialDataMFD(pParams : String = '') : String;
    function leMemoriaFiscalSerialReducaoMFD(pParams : String = '') : String;
    function geraEAD(pParams : String = '') : String;
    function extrairCOO(pParams : String = '') : String;
    function efetuaLeituraArqMFD(pParams : String = '') : String;
    function retornaPathECF(pParams : String = '') : String;
    function geraAtoCotep(pParams : String = '') : String;
    function verificaDocVinculado(pParams : String = '') : String;
  end;

implementation

uses
  cADMSVCO001,
  cActivate, cStatus, cFuncao, cXml, dModulo;

var
  gCodItem,
  gDataFIM,
  gDataINI,
  gHrFim,
  gPrAliquota,
  gvCOOFIM,
  gvCOOINI,
  gvDtEmissao,
  gvDtFinalEmissao,
  gvDtInicial,
  gvHrEmissao,
  gvHrFinalEmissao,
  gVl03Dig,
  gVl14DIG,
  gVl14DIGITOS,
  gVl6DIG,
  gVlDescontoUnit,
  gVlUnit,
  gvQtd : String;

//---------------------------------------------------------------
constructor T_ECFSVCO011.Create(AOwner: TComponent);
//---------------------------------------------------------------
begin
  inherited Create(AOwner);
  setEntidade('');
end;

//--------------------------------
destructor T_ECFSVCO011.Destroy;
//--------------------------------
begin
  inherited Destroy;
end;

//---------------------------------------------------------------
function T_ECFSVCO011.getParam(pParams : String) : String;
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

  xParam := T_ADMSVCO001.GetParametro(xParam);


  xParamEmp := '';
  putitem(xParamEmp, 'NR_VIAS_ECF_TERMICA');
  putitem(xParamEmp, 'TEF_COMUNICACAO_GP');
  putitem(xParamEmp, 'TP_TOTALIZADOR_ECF_CANC');
  putitem(xParamEmp, 'TP_TOTALIZADOR_ECF_REC');
  putitem(xParamEmp, 'UF_ORIGEM');

  xParamEmp := T_ADMSVCO001.GetParamEmpresa(piCdEmpresa, xParamEmp);


end;

//---------------------------------------------------------------
function T_ECFSVCO011.setEntidade(pParams : String) : String;
//---------------------------------------------------------------
begin
  tF_TMP_NR09 := GetEntidade('F_TMP_NR09');
  tFCC_AUTOCHEQ := GetEntidade('FCC_AUTOCHEQ');
  tFCC_AUTORIZAC := GetEntidade('FCC_AUTORIZAC');
  tFCC_CTAPES := GetEntidade('FCC_CTAPES');
  tFIS_DNF := GetEntidade('FIS_DNF');
  tFIS_ECF := GetEntidade('FIS_ECF');
  tFIS_ECFADIC := GetEntidade('FIS_ECFADIC');
  tFIS_MPGTO := GetEntidade('FIS_MPGTO');
  tGER_EMPRESA := GetEntidade('GER_EMPRESA');
  tGER_TERMINALP := GetEntidade('GER_TERMINALP');
  tGLB_CHAVE := GetEntidade('GLB_CHAVE');
  tGLB_PERIFERIC := GetEntidade('GLB_PERIFERIC');
  tPES_PESSOA := GetEntidade('PES_PESSOA');
  tV_PES_ENDEREC := GetEntidade('V_PES_ENDEREC');
end;

//-------------------------------------------------------------
function T_ECFSVCO011.espacoDireita(pParams : String) : String;
//-------------------------------------------------------------
const
  cDS_METHOD = 'ADICIONAL=Operação: T_ECFSVCO011.espacoDireita()';
var
  (* string vDsEntrada : IN / numeric vTam : IN / string vDsSaida : OUT *)
  vCont, vTamDsEntrada : Real;
begin
  length vDsEntrada;
  vTamDsEntrada := gresult;
  vCont := 0;
  repeat
    vCont := vCont + 1;
    if (vCont <= vTamDsEntrada) then begin
      vDsSaida := '' + vDsSaida' + vDsEntrada[vCont, + ' + ' vCont]';
    end else begin
      vDsSaida := '' + vDsSaida + ' ';
    end;
  until(vCont := vTam);
  return(0); exit;
end;

//------------------------------------------------------------
function T_ECFSVCO011.preencheZero(pParams : String) : String;
//------------------------------------------------------------
const
  cDS_METHOD = 'ADICIONAL=Operação: T_ECFSVCO011.preencheZero()';
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

//----------------------------------------------------------
function T_ECFSVCO011.achaNumero(pParams : String) : String;
//----------------------------------------------------------
const
  cDS_METHOD = 'ADICIONAL=Operação: T_ECFSVCO011.achaNumero()';
var
  (* string piNumero : IN / string poNumero : OUT *)
  vNumero : String;
begin
  length(piNumero);
  while (gresult > 0) do begin
    if (piNumero[1 : 1] >= 0 ) and (piNumero[1 : 1] <= 9 ) and (piNumero[1 : 1] <> ' ') then begin
      vNumero := '' + vNumero' + piNumero[ + ' + '1 : 1]';
    end;
    piNumero := piNumero[2];
    length(piNumero);
  end;

  poNumero := vNumero;

  return(0); exit;
end;

//-----------------------------------------------------------
function T_ECFSVCO011.extraiValor(pParams : String) : String;
//-----------------------------------------------------------
const
  cDS_METHOD = 'ADICIONAL=Operação: T_ECFSVCO011.extraiValor()';
var
  (* string piNmCampo : IN / string piDsDados : IN / string poDsDados : OUT *)
  vNrPosInicio, vNrPosFim, vNrTamanho, voParamsado : Real;
begin
  poDsDados := '';

  length(piNmCampo);
  vNrTamanho := gresult;

  vNrPosInicio := 0;
  vNrPosFim := 0;
  voParamsado := 0;

  voParamsado := gscan(piDsDados, '' + piNmCampo') + ';
  if (voParamsado > 0) then begin
    vNrPosInicio := voParamsado + vNrTamanho;
    vNrPosFim := vNrPosInicio + 6;
  end;
  if (vNrPosFim >= vNrPosInicio)  and (vNrPosInicio > 0) then begin
    poDsDados := piDsDados[vNrPosInicio, vNrPosFim];
  end;
  if (piNmCampo= 'COO:')  and (voParamsado > 0) then begin
    if (gvDtEmissao = '') then begin
      gvDtInicial := piDsDados[1:10];
      gvCOOINI := poDsDados;
    end;
    gvDtEmissao := piDsDados[1:10];
    gvHrEmissao := piDsDados[13:8];
    gvCOOFIM := poDsDados;
  end;

  return(0); exit;

end;

//----------------------------------------------------------------
function T_ECFSVCO011.verificaConteudo(pParams : String) : String;
//----------------------------------------------------------------
const
  cDS_METHOD = 'ADICIONAL=Operação: T_ECFSVCO011.verificaConteudo()';
var
  (* string piChave : IN / string piParam : IN / string poParam : OUT *)
  vDsConteudo : String;
begin
  fileload piParam, vDsConteudo;

  voParams := extraiValor(viParams); (* piChave, vDsConteudo, poParam *)
  if (xStatus < 0) then begin
    Result := voParams;
    return(-1); exit;
  end;

  return(0); exit;
end;

//----------------------------------------------------
function T_ECFSVCO011.INIT(pParams : String) : String;
//----------------------------------------------------
const
  cDS_METHOD = 'ADICIONAL=Operação: T_ECFSVCO011.INIT()';
var
  viParams, voParams, vDsLista, vDsPath, vUFOrigem : String;
  vCdEmpresa, vTam, vCdTerminal,vCdTotalizadorEcfRec, vCTotalizadorEcfCanc, nrViasEcfTermica : Real;
  vFlag, vInComunicacaoEcf : Boolean;
  vMapeamento, vUnidade, vDiretorio : String;
begin
  if (itemXml('DS_UNIDTERMINAL', PARAM_GLB) <> '') then begin
    vDsPath := itemXml('DS_UNIDTERMINAL', PARAM_GLB);
    vDsPath := '' + vDsPath:\ECF\' + ';
    vFlag := False;
    voParams := activateCmp('vbfileman', 'arqexiste', viParams); (*vFlag,'' + vDsPathRETORNOECF + '.TXT' *)
    if (vFlag) then begin
      voParams := activateCmp('vbfileman', 'apagaarquivo', viParams); (*'' + vDsPathRETORNOECF + '.TXT' *)
    end;
    vFlag := False;
    voParams := activateCmp('vbfileman', 'arqexiste', viParams); (*vFlag,'' + vDsPathECF + '.TMP' *)
    if (vFlag) then begin
      voParams := activateCmp('vbfileman', 'apagaarquivo', viParams); (*'' + vDsPathECF + '.TMP' *)
    end;
    return(0); exit;
  end;
  if (itemXml('TEF_COMUNICACAO_GP', PARAM_GLB) = '')  or (itemXml('TP_TOTALIZADOR_ECF_REC', PARAM_GLB) = '')  or (itemXml('TP_TOTALIZADOR_ECF_CANC', PARAM_GLB) = '')  or %\ then begin
    (itemXml('UF_ORIGEM', PARAM_GLB) := '')  or (itemXml('NR_VIAS_ECF_TERMICA', PARAM_GLB) = '');
    viParams := '';

    vCdEmpresa := itemXmlF('CD_EMPRESA', PARAM_GLB);
    putitem(viParams,  'TEF_COMUNICACAO_GP');
    putitem(viParams,  'TP_TOTALIZADOR_ECF_REC');
    putitem(viParams,  'TP_TOTALIZADOR_ECF_CANC');
    putitem(viParams,  'UF_ORIGEM');
    putitem(viParams,  'NR_VIAS_ECF_TERMICA');
    xParamEmp := T_ADMSVCO001.GetParamEmpresa(piCdEmpresa, xParamEmp); (*vCdEmpresa,,,, *)
    vInComunicacaoECF := itemXml('TEF_COMUNICACAO_GP', voParams);

    vCdTotalizadorEcfRec := itemXmlF('TP_TOTALIZADOR_ECF_REC', voParams);
    vCTotalizadorEcfCanc := itemXmlF('TP_TOTALIZADOR_ECF_CANC', voParams);
    vUFOrigem := itemXml('UF_ORIGEM', voParams);
    nrViasEcfTermica := itemXmlF('NR_VIAS_ECF_TERMICA', voParams);

    putitemXml(PARAM_GLB, 'TEF_COMUNICACAO_GP', vInComunicacaoECF);
    putitemXml(PARAM_GLB, 'TP_TOTALIZADOR_ECF_REC', vCdTotalizadorEcfRec);
    putitemXml(PARAM_GLB, 'TP_TOTALIZADOR_ECF_CANC', vCTotalizadorEcfCanc);
    putitemXml(PARAM_GLB, 'UF_ORIGEM', vUFOrigem);
    putitemXml(PARAM_GLB, 'NR_VIAS_ECF_TERMICA', nrViasEcfTermica);

  end else begin
    vInComunicacaoECF := itemXml('TEF_COMUNICACAO_GP', PARAM_GLB);
  end;
  if (vInComunicacaoECF = 1) then begin
    vMapeamento := 'C;
  end else begin
    vMapeamento := 'E;
  end;

  repeat
    getitem(vUnidade, vMapeamento, 1);
    vDiretorio := '' + vUnidade:\WINDOWS\SYSTEM + '32';
    voParams := activateCmp('vbfileman', 'direxiste', viParams); (*vFlag,vDiretorio *)
    if (xStatus < 0) then begin
      Result := voParams;
      return(-1); exit;
    end;
    if (vFlag = False) then begin
      vDiretorio := '' + vUnidade:\WINNT\SYSTEM + '32';
      voParams := activateCmp('vbfileman', 'direxiste', viParams); (*vFlag,vDiretorio *)
      if (xStatus < 0) then begin
        Result := voParams;
        return(-1); exit;
      end;
    end;
    if (vFlag = True) then begin
      putitemXml(PARAM_GLB, 'DS_UNIDTERMINAL', vUnidade);
      break;
    end;
    delitem(vMapeamento, 1);
  until (vMapeamento = '');
  return(0); exit;

end;

//-------------------------------------------------------
function T_ECFSVCO011.CLEANUP(pParams : String) : String;
//-------------------------------------------------------
const
  cDS_METHOD = 'ADICIONAL=Operação: T_ECFSVCO011.CLEANUP()';
begin
end;

//-------------------------------------------------------------
function T_ECFSVCO011.aberturaDoDia(pParams : String) : String;
//-------------------------------------------------------------
const
  cDS_METHOD = 'ADICIONAL=Operação: T_ECFSVCO011.aberturaDoDia()';
var
  vEOF, vDsPath, vDsConteudo : String;
  vQtTentativa, Status : Real;
begin
  vDsPath := itemXml('DS_UNIDTERMINAL', PARAM_GLB);
  vDsPath := '' + vDsPath:\ECF\' + ';
  xStatus := 0;

  gVl14DIG := itemXmlF('VL_ABERTURADIA', pParams);

  filedump '020' + FloatToStr(gVl) + '14DIG', '' + vDsPathECF + '.TMP';
  if (xStatus < 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Falha na gravação de arquivos na máquina check in!', cDS_METHOD);
    return(-1); exit;
  end;

  voParams := activateCmp('vbfileman', 'movearquivo', viParams); (*vEOF,'' + vDsPathECF + '.TMP','' + vDsPathECF + '.TXT' *)
  if (xStatus < 0) then begin
    Result := voParams;
    return(-1); exit;
  end;

  vDsConteudo := '';
  vQtTentativa := 0;
  repeat

    fileload '' + vDsPathRETORNOECF + '.TXT', vDsConteudo;
    if (xStatus < 0) then begin
      Result := voParams;
      return(-1); exit;
    end;
        if (xStatus < 0) then begin
          Result := voParams;
          return(-1); exit;
        end;
        return(-1); exit;
      end;
    end;

  until (vDsConteudo <> '');

  length vDsConteudo;
  Status := vDsConteudo[1, 4];
  if (Status = -1) then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', '' + vDsConteudo[ + '5, gresult]', cDS_METHOD);
    voParams := activateCmp('vbfileman', 'apagaarquivo', viParams); (*'' + vDsPathRETORNOECF + '.TXT' *)
    if (xStatus < 0) then begin
      Result := voParams;
      return(-1); exit;
    end;

    return(-1); exit;
  end else begin
    voParams := setDisplay(viParams); (* '' + vDsConteudo[ + '5, gresult]', '', '' *)
    if (xStatus < 0) then begin
      Result := voParams;
      return(-1); exit;
    end;
  end;

  voParams := activateCmp('vbfileman', 'apagaarquivo', viParams); (*'' + vDsPathRETORNOECF + '.TXT' *)
  if (xStatus < 0) then begin
    Result := voParams;
    return(-1); exit;
  end;

  return(0); exit;
end;

//---------------------------------------------------------
function T_ECFSVCO011.abreCupom(pParams : String) : String;
//---------------------------------------------------------
const
  cDS_METHOD = 'ADICIONAL=Operação: T_ECFSVCO011.abreCupom()';
var
  vEOF, vDsPath, vDsConteudo, vDsLinha, vDsRetorno, vCPF_CNPJ : String;
  vQtTentativa, Status : Real;
  vInConcomitante : Boolean;
begin
  if (itemXml('IN_LOG_TEMPO_VendA', PARAM_GLB) = 1) then begin
    gHrFim := gclock;
    putmess 'ECFSVCO011: abreCupom - Inicio abreCupom: ' + gHrFim' + ';
  end;

  vInConcomitante := itemXmlB('IN_CONCOMITANTE', pParams);
  if (vInConcomitante = '') then begin
    vInConcomitante := False;
  end;

  vCPF_CNPJ := itemXmlF('NR_CPFCNPJ', pParams);

  vDsPath := itemXml('DS_UNIDTERMINAL', PARAM_GLB);
  vDsPath := '' + vDsPath:\ECF\' + ';
  xStatus := 0;
  if (vInConcomitante = False) then begin
    if (itemXml('PADRAO_ECF', PARAM_GLB) = <PADRAO_LOCALIMPFINAL> ) or (itemXml('PADRAO_ECF', PARAM_GLB) = <PADRAO_LOCAL>) then begin
      putitemXml(Result, 'DS_CUPOM', '031001' + vCPF_CNPJ') + ';
      return(0); exit;
    end;
  end;
  if (itemXml('IN_LOG_TEMPO_VendA', PARAM_GLB) = 1) then begin
    gHrFim := gclock;
    putmess 'ECFSVCO011: abreCupom - Inicio filedump ECF.TMP: ' + gHrFim' + ';
  end;

  filedump '001' + vCPF_CNPJ', + ' '' + vDsPathECF + '.TMP';
  if (xStatus < 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Falha na gravação de arquivos na máquina check in!', cDS_METHOD);
    return(-1); exit;
  end;
  if (itemXml('IN_LOG_TEMPO_VendA', PARAM_GLB) = 1) then begin
    gHrFim := gclock;
    putmess 'ECFSVCO011: abreCupom - Termino filedump ECF.TMP: ' + gHrFim' + ';
  end;

  voParams := activateCmp('vbfileman', 'movearquivo', viParams); (*vEOF,'' + vDsPathECF + '.TMP','' + vDsPathECF + '.TXT' *)
  if (xStatus < 0) then begin
    Result := voParams;
    return(-1); exit;
  end;
  if (itemXml('IN_LOG_TEMPO_VendA', PARAM_GLB) = 1) then begin
    gHrFim := gclock;
    putmess 'ECFSVCO011: abreCupom - Efetuando leitura RETORNOECF.TXT: ' + gHrFim' + ';
  end;

  vDsConteudo := '';
  vQtTentativa := 0;
  repeat

    fileload '' + vDsPathRETORNOECF + '.TXT', vDsConteudo;
    if (xStatus < 0) then begin
      Result := voParams;
      return(-1); exit;
    end;
        if (xStatus < 0) then begin
          Result := voParams;
          return(-1); exit;
        end;
        return(-1); exit;
      end;
    end;

  until (vDsConteudo <> '');

  if (itemXml('IN_LOG_TEMPO_VendA', PARAM_GLB) = 1) then begin
    gHrFim := gclock;
    putmess 'ECFSVCO011: abreCupom - Leitura concluída RETORNOECF.TXT: ' + gHrFim' + ';
  end;
  if (itemXml('IN_LOG_TEMPO_VendA', PARAM_GLB) = 1) then begin
    gHrFim := gclock;
    putmess 'ECFSVCO011: abreCupom - Inicio apaga RETORNOECF.TXT: ' + gHrFim' + ';
  end;

  length vDsConteudo;
  Status := vDsConteudo[1, 4];
  if (Status = -1) then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', '' + vDsConteudo[ + '5, gresult]', cDS_METHOD);
    voParams := activateCmp('vbfileman', 'apagaarquivo', viParams); (*'' + vDsPathRETORNOECF + '.TXT' *)
    if (xStatus < 0) then begin
      Result := voParams;
      return(-1); exit;
    end;

    return(-1); exit;
  end else begin
    voParams := setDisplay(viParams); (* '' + vDsConteudo[ + '5, gresult]', '', '' *)
    if (xStatus < 0) then begin
      Result := voParams;
      return(-1); exit;
    end;
  end;
  if (vInConcomitante = True) then begin
    voParams := activateCmp('vbfileman', 'filename', viParams); (*'' + vDsPathRETORNOECF + '.TXT' *)
    if (xStatus < 0) then begin
      Result := voParams;
      return(-1); exit;
    end;

    repeat

      voParams := activateCmp('vbfileman', 'learquivo', viParams); (*vDsLinha *)
      if (xStatus < 0) then begin
        Result := voParams;
        return(-1); exit;
      end;
      if (gidpart(vDsLinha) = 'NR_CUPOM') then begin
        putitemXml(Result, 'NR_CUPOM', itemXmlF('NR_CUPOM', vDsLinha));
      end else if (gidpart(vDsLinha) = 'NR_SERIE') then begin
        putitemXml(Result, 'NR_SERIE', itemXmlF('NR_SERIE', vDsLinha));
        putitemXml(PARAM_GLB, 'CD_SERIEECF', itemXmlF('NR_SERIE', vDsLinha));
      end;

      voParams := activateCmp('vbfileman', 'eof', viParams); (*vEOF *)
      if (xStatus < 0) then begin
        Result := voParams;
        return(-1); exit;
      end;

    until (vEOF := -1);

  end;

  voParams := activateCmp('vbfileman', 'apagaarquivo', viParams); (*'' + vDsPathRETORNOECF + '.TXT' *)
  if (xStatus < 0) then begin
    Result := voParams;
    return(-1); exit;
  end;
  if (itemXml('IN_LOG_TEMPO_VendA', PARAM_GLB) = 1) then begin
    gHrFim := gclock;
    putmess 'ECFSVCO011: abreCupom - Fim apaga RETORNOECF.TXT: ' + gHrFim' + ';
  end;
  if (itemXml('IN_LOG_TEMPO_VendA', PARAM_GLB) = 1) then begin
    gHrFim := gclock;
    putmess 'ECFSVCO011: abreCupom - Fim abreCupom: ' + gHrFim' + ';
  end;

  return(0); exit;
end;

//---------------------------------------------------------
function T_ECFSVCO011.vendeItem(pParams : String) : String;
//---------------------------------------------------------
const
  cDS_METHOD = 'ADICIONAL=Operação: T_ECFSVCO011.vendeItem()';
var
  vEOF, vDsPath, vDsConteudo, vDsRetorno, vDsLinha : String;
  vInImprimeaoFinal : Boolean;
  vDsProduto, vPrAliquota, vlUnit, Status, vDsCupom, vCdEspecie : String;
  vQtTentativa, vVlDesconto, vVlCalc, vVlInteiro, vVlFracionado : Real;
  vInConcomitante, vInTEF : Boolean;
begin
  if (itemXml('IN_LOG_TEMPO_VendA', PARAM_GLB) = 1) then begin
    gHrFim := gclock;
    putmess 'ECFSVCO011: vendeItem - Inicio vendeItem: ' + gHrFim' + ';
  end;

  putitemXml(pParams, 'IN_OPT_SIMPLES', itemXmlB('IN_OPT_SIMPLES', PARAM_GLB));
  vInConcomitante := itemXmlB('IN_CONCOMITANTE', pParams);
  if (vInConcomitante = '') then begin
    vInConcomitante := False;
  end;
  vInTEF := itemXmlB('IN_TEF', pParams);
  if (vInTEF = '') then begin
    vInTEF := False;
  end;
  vDsCupom := '';
  vDsPath := itemXml('DS_UNIDTERMINAL', PARAM_GLB);
  vDsPath := '' + vDsPath:\ECF\' + ';

  vInImprimeaoFinal := False;
  vInImprimeaoFinal := itemXmlB('IN_IMPRIMEAOFINAL', pParams);
  gCodItem := itemXmlF('CD_PRODUTO', pParams);
  vDsProduto := itemXml('DS_PRODUTO', pParams);
  voParams := espacoDireita(viParams); (* vDsProduto, 29, vDsProduto *)
  if (xStatus < 0) then begin
    Result := voParams;
    return(-1); exit;
  end;
  if (itemXml('TP_REGIMESUB', pParams) = <CST_ISENTO>) then begin
    vPrAliquota := 'II  ';
  end else if (itemXml('TP_REGIMESUB', pParams) = <CST_ISENTO_SUBSTITUICAO>) then begin
    vPrAliquota := 'FF  ';
  end else if (itemXml('TP_REGIMESUB', pParams) = <CST_NAO_TRIBUTADO>)  or ((itemXml('IN_OPT_SIMPLES', pParams) = 'S')  and itemXml('UF_ORIGEM', PARAM_GLB) = 'PR') then begin
    vPrAliquota := 'NN  ';
  end else if (itemXml('TP_REGIMESUB', pParams) = <CST_SUBSTITUICAO>) then begin
    if (gnumber(itemXml('PR_ALIQICMS', pParams)) <= 0) then begin
        voParams := SetErroApl(viParams); (* 'ID=PAR0001;
        return(-1); exit;
    end;
  end else if (itemXml('TP_REGIMESUB', pParams) = <CST_INTEGRAL>)  or (itemXml('TP_REGIMESUB', pParams) = <CST_OUTRO>) then begin
    if (gnumber(itemXml('PR_ALIQICMS', pParams)) <= 0) then begin
        voParams := SetErroApl(viParams); (* 'ID=PAR0001;
        return(-1); exit;
    end else begin
      gPrAliquota := gnumber(itemXml('PR_ALIQICMS', pParams)) * 100;
      vPrAliquota := '' + gPrAliquota' + ';
    end;
  end else if (itemXml('TP_REGIMESUB', pParams) = '') then begin
    if (gnumber(itemXml('PR_ALIQICMS', pParams)) <= 0) then begin
      vPrAliquota := 'NN  ';
    end else begin
      gPrAliquota := gnumber(itemXml('PR_ALIQICMS', pParams)) * 100;
      vPrAliquota := '' + gPrAliquota' + ';
    end;
  end;

  vCdEspecie= itemXmlF('CD_ESPECIE', pParams)[1:2];

  gvQtd := itemXmlF('QT_SOLICITADA', pParams);
  gVlUnit := gnumber(itemXml('VL_UNITARIO', pParams)) * 100;
  gVlUnit := int(gVlUnit);

  gVlDescontoUnit := gnumber(itemXml('VL_DESCONTO', pParams));

  if (vInConcomitante = True) then begin
    gVlDescontoUnit := 0;
  end;
  if (vInConcomitante = False) then begin
    if (itemXml('PADRAO_ECF', PARAM_GLB) = <PADRAO_LOCALIMPFINAL>) then begin
      if (vInImprimeaoFinal = True ) and (vInTEF = True) then begin
        vDsCupom := itemXml('DS_CUPOM', pParams);
      end else begin

        putitemXml(Result, 'DS_CUPOM', '002' + gCodItem' + vDsProduto' + vPrAliquotaI' + gvQtd + ' + ' + ' + '2' + FloatToStr(gVlUnitV' + FloatToStr(gVlDescontoUnit' + FloatToStr(vCdEspecie')))) + ' + ' + ';

        return(0); exit;
      end;
    end;
  end;

  xStatus := 0;

  if (itemXml('IN_LOG_TEMPO_VendA', PARAM_GLB) = 1) then begin
    gHrFim := gclock;
    putmess 'ECFSVCO011: vendeItem - filedump vendeItem: ' + gHrFim' + ';
  end;

  filedump '' + vDsCupom + '002' + gCodItem' + vDsProduto' + vPrAliquotaI' + gvQtd + ' + ' + ' + '2' + FloatToStr(gVlUnitV' + FloatToStr(gVlDescontoUnit' + FloatToStr(vCdEspecie',))) + ' + ' + ' '' + vDsPathECF + '.TMP';

  if (xStatus < 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Falha na gravação de arquivos na máquina check in!', cDS_METHOD);
    return(-1); exit;
  end;
  if (vInConcomitante = False) then begin
    if (vInImprimeaoFinal = False) then begin
      return(0); exit;
    end;
  end;
  if (itemXml('IN_LOG_TEMPO_VendA', PARAM_GLB) = 1) then begin
    gHrFim := gclock;
    putmess 'ECFSVCO011: vendeItem - Termino filedump ECF.TMP: ' + gHrFim' + ';
  end;

  voParams := activateCmp('vbfileman', 'movearquivo', viParams); (*vEOF,'' + vDsPathECF + '.TMP','' + vDsPathECF + '.TXT' *)
  if (xStatus < 0) then begin
    Result := voParams;
    return(-1); exit;
  end;
  if (itemXml('IN_LOG_TEMPO_VendA', PARAM_GLB) = 1) then begin
    gHrFim := gclock;
    putmess 'ECFSVCO011: abreCupom - Efetuando leitura RETORNOECF.TXT: ' + gHrFim' + ';
  end;

  vDsConteudo := '';
  vQtTentativa := 0;
  repeat

    fileload '' + vDsPathRETORNOECF + '.TXT', vDsConteudo;
    if (xStatus < 0) then begin
      Result := voParams;
      return(-1); exit;
    end;
        if (xStatus < 0) then begin
          Result := voParams;
          return(-1); exit;
        end;
        return(-1); exit;
      end;
    end;

  until (vDsConteudo <> '');

  length vDsConteudo;
  Status := vDsConteudo[1, 4];
  if (Status = -1) then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', '' + vDsConteudo[ + '5, gresult]', cDS_METHOD);
    voParams := activateCmp('vbfileman', 'apagaarquivo', viParams); (*'' + vDsPathRETORNOECF + '.TXT' *)
    if (xStatus < 0) then begin
      Result := voParams;
      return(-1); exit;
    end;

    return(-1); exit;
  end else begin
    voParams := setDisplay(viParams); (* '' + vDsConteudo[ + '5, gresult]', '', '' *)
    if (xStatus < 0) then begin
      Result := voParams;
      return(-1); exit;
    end;
  end;
  if (itemXml('IN_LOG_TEMPO_VendA', PARAM_GLB) = 1) then begin
    gHrFim := gclock;
    putmess 'ECFSVCO011: vendeItem - Leitura concluída RETORNOECF.TXT: ' + gHrFim' + ';
  end;
  if (vInTEF = True) then begin
    if (itemXml('IN_LOG_TEMPO_VendA', PARAM_GLB) = 1) then begin
      gHrFim := gclock;
      putmess 'ECFSVCO011: vendeItem - vInTEF efetuando leitura RETORNOECF.TXT: ' + gHrFim' + ';
    end;

    voParams := activateCmp('vbfileman', 'filename', viParams); (*'' + vDsPathRETORNOECF + '.TXT' *)
    if (xStatus < 0) then begin
      Result := voParams;
      return(-1); exit;
    end;

    repeat
      voParams := activateCmp('vbfileman', 'learquivo', viParams); (*vDsLinha *)
      if (xStatus < 0) then begin
        Result := voParams;
        return(-1); exit;
      end;
      if (gidpart(vDsLinha) = 'NR_CUPOM') then begin
        putitemXml(Result, 'NR_CUPOM', itemXmlF('NR_CUPOM', vDsLinha));
      end else if (gidpart(vDsLinha) = 'NR_SERIE') then begin
        putitemXml(Result, 'NR_SERIE', itemXmlF('NR_SERIE', vDsLinha));
        putitemXml(PARAM_GLB, 'CD_SERIEECF', itemXmlF('NR_SERIE', vDsLinha));
      end;

      voParams := activateCmp('vbfileman', 'eof', viParams); (*vEOF *)
      if (xStatus < 0) then begin
        Result := voParams;
        return(-1); exit;
      end;

    until (vEOF := -1);

    if (itemXml('IN_LOG_TEMPO_VendA', PARAM_GLB) = 1) then begin
      gHrFim := gclock;
      putmess 'ECFSVCO011: vendeItem - vInTEF leitura  concluída RETORNOECF.TXT: ' + gHrFim' + ';
    end;
  end;

  voParams := activateCmp('vbfileman', 'apagaarquivo', viParams); (*'' + vDsPathRETORNOECF + '.TXT' *)
  if (xStatus < 0) then begin
    Result := voParams;
    return(-1); exit;
  end;
  if (itemXml('IN_LOG_TEMPO_VendA', PARAM_GLB) = 1) then begin
    gHrFim := gclock;
    putmess 'ECFSVCO011: vendeItem - Fim vendeItem: ' + gHrFim' + ';
  end;

  return(0); exit;
end;

//---------------------------------------------------------------------
function T_ECFSVCO011.acrescimoDescontoItem(pParams : String) : String;
//---------------------------------------------------------------------
const
  cDS_METHOD = 'ADICIONAL=Operação: T_ECFSVCO011.acrescimoDescontoItem()';
var
  vNrItem, vlDesconto : String;
  vEOF, vDsAcresDesc, vDsAux, vlValor, vDsPath, vDsConteudo, vTpAcresDesc : String;
  vQtTentativa, Status : Real;
  vInConcomitante : Boolean;
begin
  vDsPath := itemXml('DS_UNIDTERMINAL', PARAM_GLB);
  vDsPath := '' + vDsPath:\ECF\' + ';
  xStatus := 0;

  vNrItem := itemXmlF('NR_ITEM', pParams);
  voParams := preencheZero(viParams); (* vNrItem, 3, vNrItem *)
  if (xStatus < 0) then begin
    Result := voParams;
    return(-1); exit;
  end;

  vDsAcresDesc := itemXml('DS_ACRESDESC', pParams);
  if (vDsAcresDesc = '') then begin
      vDsAcresDesc := 'D';
  end;

  vTpAcresDesc := itemXmlF('TP_ACRESDESC', pParams);
  if (vTpAcresDesc = '') then begin
    vTpAcresDesc := 'g';
  end;

  vlValor := gnumber(itemXml('VL_DESCONTO', pParams)) * 100;
  voParams := preencheZero(viParams); (* vlValor, 14, vlValor *)

  filedump '003' + FloatToStr(vNrItem' + vDsAcresDesc' + FloatToStr(vTpAcresDesc' + vlValor',)) + ' + ' + ' + ' '' + vDsPathECF + '.TMP';
  if (xStatus < 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Falha na gravação de arquivos na máquina check in!', cDS_METHOD);
    return(-1); exit;
  end;

  voParams := activateCmp('vbfileman', 'movearquivo', viParams); (*vEOF,'' + vDsPathECF + '.TMP','' + vDsPath\ECF + '.TXT' *)
  if (xStatus < 0) then begin
    Result := voParams;
    return(-1); exit;
  end;

  vDsConteudo := '';
  vQtTentativa := 0;
  repeat

    fileload '' + vDsPathRETORNOECF + '.TXT', vDsConteudo;
    if (xStatus < 0) then begin
      Result := voParams;
      return(-1); exit;
    end;
        if (xStatus < 0) then begin
          Result := voParams;
          return(-1); exit;
        end;
        return(-1); exit;
      end;
    end;

  until (vDsConteudo <> '');

  length vDsConteudo;
  Status := vDsConteudo[1, 4];
  if (Status = -1) then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', '' + vDsConteudo[ + '5, gresult]', cDS_METHOD);
    voParams := activateCmp('vbfileman', 'apagaarquivo', viParams); (*'' + vDsPathRETORNOECF + '.TXT' *)
    if (xStatus < 0) then begin
      Result := voParams;
      return(-1); exit;
    end;

    return(-1); exit;
  end else begin
    voParams := setDisplay(viParams); (* '' + vDsConteudo[ + '5, gresult]', '', '' *)
    if (xStatus < 0) then begin
      Result := voParams;
      return(-1); exit;
    end;
  end;

  voParams := activateCmp('vbfileman', 'apagaarquivo', viParams); (*'' + vDsPathRETORNOECF + '.TXT' *)
  if (xStatus < 0) then begin
    Result := voParams;
    return(-1); exit;
  end;

  return(0); exit;

end;

//----------------------------------------------------------------------
function T_ECFSVCO011.acrescimoDescontoCupom(pParams : String) : String;
//----------------------------------------------------------------------
const
  cDS_METHOD = 'ADICIONAL=Operação: T_ECFSVCO011.acrescimoDescontoCupom()';
var
  vEOF, vDsAcresDesc, vDsAux, vlValor, vDsPath, vDsConteudo : String;
  vQtTentativa, Status : Real;
  vInConcomitante : Boolean;
begin
  if (itemXml('IN_LOG_TEMPO_VendA', PARAM_GLB) = 1) then begin
    gHrFim := gclock;
    putmess 'ECFSVCO011: acrescimoDescontoCupom - Inicio acrescimoDescontoCupom: ' + gHrFim' + ';
  end;

  vDsPath := itemXml('DS_UNIDTERMINAL', PARAM_GLB);
  vDsPath := '' + vDsPath:\ECF\' + ';
  xStatus := 0;

  vInConcomitante := itemXmlB('IN_CONCOMITANTE', pParams);

  vDsAcresDesc := '';
  if (itemXml('IN_ACRESDESC', pParams) = '') then begin
      vDsAcresDesc := 'D';
  end else begin
    vDsAcresDesc := itemXmlB('IN_ACRESDESC', pParams);
  end;
  if (vInConcomitante = True) then begin
    vlValor := gnumber(itemXml('VL_ACRESDESC', pParams)) * 100;
  end else begin

    if (vDsAcresDesc = 'D') then begin
      vlValor := gnumber(0) * 100;
    end else begin
      vlValor := gnumber(itemXml('VL_ACRESDESC', pParams)) * 100;
    end;
  end;
  if (itemXml('TP_ACRESDESC', pParams) = '') then begin
      vDsAcresDesc := '' + vDsAcresDescg' + ';
  end else begin
    vDsAux := itemXmlF('TP_ACRESDESC', pParams);
    vDsAcresDesc := '' + vDsAcresDesc' + vDsAux' + ' + ';
  end;
  if (itemXml('PADRAO_ECF', PARAM_GLB) = <PADRAO_LOCALIMPFINAL>) then begin
    putitemXml(Result, 'DS_CUPOM', '004' + vDsAcresDesc' + vlValor') + ' + ';
    return(0); exit;
  end;
  if (itemXml('IN_LOG_TEMPO_VendA', PARAM_GLB) = 1) then begin
    gHrFim := gclock;
    putmess 'ECFSVCO011: acrescimoDescontoCupom - Inicio filedump: ' + gHrFim' + ';
  end;

  filedump '004' + vDsAcresDesc' + vlValor', + ' + ' '' + vDsPathECF + '.TMP';
  if (xStatus < 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Falha na gravação de arquivos na máquina check in!', cDS_METHOD);
    return(-1); exit;
  end;
  if (itemXml('IN_LOG_TEMPO_VendA', PARAM_GLB) = 1) then begin
    gHrFim := gclock;
    putmess 'ECFSVCO011: acrescimoDescontoCupom - Termino acrescimoDescontoCupom: ' + gHrFim' + ';
  end;

  voParams := activateCmp('vbfileman', 'movearquivo', viParams); (*vEOF,'' + vDsPathECF + '.TMP','' + vDsPath\ECF + '.TXT' *)
  if (xStatus < 0) then begin
    Result := voParams;
    return(-1); exit;
  end;
  if (itemXml('IN_LOG_TEMPO_VendA', PARAM_GLB) = 1) then begin
    gHrFim := gclock;
    putmess 'ECFSVCO011: acrescimoDescontoCupom - Aguardando RETORNOECF.TXT acrescimoDescontoCupom: ' + gHrFim' + ';
  end;

  vDsConteudo := '';
  vQtTentativa := 0;
  repeat

    fileload '' + vDsPathRETORNOECF + '.TXT', vDsConteudo;
    if (xStatus < 0) then begin
      Result := voParams;
      return(-1); exit;
    end;
        if (xStatus < 0) then begin
          Result := voParams;
          return(-1); exit;
        end;
        return(-1); exit;
      end;
    end;

  until (vDsConteudo <> '');

  length vDsConteudo;
  Status := vDsConteudo[1, 4];
  if (Status = -1) then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', '' + vDsConteudo[ + '5, gresult]', cDS_METHOD);
    voParams := activateCmp('vbfileman', 'apagaarquivo', viParams); (*'' + vDsPathRETORNOECF + '.TXT' *)
    if (xStatus < 0) then begin
      Result := voParams;
      return(-1); exit;
    end;

    return(-1); exit;
  end else begin
    voParams := setDisplay(viParams); (* '' + vDsConteudo[ + '5, gresult]', '', '' *)
    if (xStatus < 0) then begin
      Result := voParams;
      return(-1); exit;
    end;
  end;
  if (itemXml('IN_LOG_TEMPO_VendA', PARAM_GLB) = 1) then begin
    gHrFim := gclock;
    putmess 'ECFSVCO011: acrescimoDescontoCupom - Leitura concluída RETORNOECF.TXT acrescimoDescontoCupom: ' + gHrFim' + ';
  end;

  voParams := activateCmp('vbfileman', 'apagaarquivo', viParams); (*'' + vDsPathRETORNOECF + '.TXT' *)
  if (xStatus < 0) then begin
    Result := voParams;
    return(-1); exit;
  end;
  if (itemXml('IN_LOG_TEMPO_VendA', PARAM_GLB) = 1) then begin
    gHrFim := gclock;
    putmess 'ECFSVCO011: acrescimoDescontoCupom - Fim acrescimoDescontoCupom: ' + gHrFim' + ';
  end;

  return(0); exit;
end;

//--------------------------------------------------------------
function T_ECFSVCO011.formaPagamento(pParams : String) : String;
//--------------------------------------------------------------
const
  cDS_METHOD = 'ADICIONAL=Operação: T_ECFSVCO011.formaPagamento()';
var
  vEOF, vDsPgto, vDsPgtoAux, vDsPath, vDsConteudo : String;
  vQtTentativa, Status : Real;
begin
  if (itemXml('IN_LOG_TEMPO_VendA', PARAM_GLB) = 1) then begin
    gHrFim := gclock;
    putmess 'ECFSVCO011: formaPagamento - Inicio formaPagamento: ' + gHrFim' + ';
  end;

  vDsPath := itemXml('DS_UNIDTERMINAL', PARAM_GLB);
  vDsPath := '' + vDsPath:\ECF\' + ';

  gVl14DIG := itemXmlF('VL_FORMAPGTO', pParams);
  vDsPgto := itemXml('DS_FORMAPGTO', pParams);
  voParams := espacoDireita(viParams); (* vDsPgto, 16, vDsPgto *)
  if (xStatus < 0) then begin
    Result := voParams;
    return(-1); exit;
  end;
  if (itemXml('PADRAO_ECF', PARAM_GLB) = <PADRAO_LOCALIMPFINAL>) then begin
    putitemXml(Result, 'DS_CUPOM', '005' + vDsPgto' + FloatToStr(gVl) + ' + '14DIG');
    return(0); exit;
  end;
  if (itemXml('IN_LOG_TEMPO_VendA', PARAM_GLB) = 1) then begin
    gHrFim := gclock;
    putmess 'ECFSVCO011: formaPagamento - Inicio filedump formaPagamento: ' + gHrFim' + ';
  end;

  xStatus := 0;
  filedump '005' + vDsPgto' + FloatToStr(gVl) + ' + '14DIG', '' + vDsPathECF + '.TMP';
  if (xStatus < 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Falha na gravação de arquivos na máquina check in!', cDS_METHOD);
    return(-1); exit;
  end;

  voParams := activateCmp('vbfileman', 'movearquivo', viParams); (*vEOF,'' + vDsPathECF + '.TMP','' + vDsPathECF + '.TXT' *)
  if (xStatus < 0) then begin
    Result := voParams;
    return(-1); exit;
  end;
  if (itemXml('IN_LOG_TEMPO_VendA', PARAM_GLB) = 1) then begin
    gHrFim := gclock;
    putmess 'ECFSVCO011: formaPagamento - Fim filedump formaPagamento: ' + gHrFim' + ';
  end;
  if (itemXml('IN_LOG_TEMPO_VendA', PARAM_GLB) = 1) then begin
    gHrFim := gclock;
    putmess 'ECFSVCO011: formaPagamento - Aguardando leitura RETORNOECF.TXT formaPagamento: ' + gHrFim' + ';
  end;

  vDsConteudo := '';
  vQtTentativa := 0;
  repeat

    fileload '' + vDsPathRETORNOECF + '.TXT', vDsConteudo;
    if (xStatus < 0) then begin
      Result := voParams;
      return(-1); exit;
    end;
        if (xStatus < 0) then begin
          Result := voParams;
          return(-1); exit;
        end;
        return(-1); exit;
      end;
    end;

  until (vDsConteudo <> '');

  if (itemXml('IN_LOG_TEMPO_VendA', PARAM_GLB) = 1) then begin
    gHrFim := gclock;
    putmess 'ECFSVCO011: formaPagamento - Fim leitura RETORNOECF.TXT formaPagamento: ' + gHrFim' + ';
  end;

  length vDsConteudo;
  Status := vDsConteudo[1, 4];
  if (Status = -1) then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', '' + vDsConteudo[ + '5, gresult]', cDS_METHOD);
    voParams := activateCmp('vbfileman', 'apagaarquivo', viParams); (*'' + vDsPathRETORNOECF + '.TXT' *)
    if (xStatus < 0) then begin
      Result := voParams;
      return(-1); exit;
    end;

    return(-1); exit;
  end else begin
    voParams := setDisplay(viParams); (* '' + vDsConteudo[ + '5, gresult]', '', '' *)
    if (xStatus < 0) then begin
      Result := voParams;
      return(-1); exit;
    end;
  end;

  voParams := activateCmp('vbfileman', 'apagaarquivo', viParams); (*'' + vDsPathRETORNOECF + '.TXT' *)
  if (xStatus < 0) then begin
    Result := voParams;
    return(-1); exit;
  end;
  if (itemXml('IN_LOG_TEMPO_VendA', PARAM_GLB) = 1) then begin
    gHrFim := gclock;
    putmess 'ECFSVCO011: formaPagamento - Fim formaPagamento: ' + gHrFim' + ';
  end;

  return(0); exit;
end;

//----------------------------------------------------------
function T_ECFSVCO011.fechaCupom(pParams : String) : String;
//----------------------------------------------------------
const
  cDS_METHOD = 'ADICIONAL=Operação: T_ECFSVCO011.fechaCupom()';
var
  vEOF, vDsPath, vDsConteudo, vDsCupom : String;
  vQtTentativa, Status, vQtContador : Real;
  vDsLinha, vDsLinhaObs, vDsRetorno, viParams, voParams, vDsMensagem : String;
  vFlag : Boolean;
begin
  if (itemXml('IN_LOG_TEMPO_VendA', PARAM_GLB) = 1) then begin
    gHrFim := gclock;
    putmess 'ECFSVCO011: fechaCupom - Inicio fechaCupom: ' + gHrFim' + ';
  end;

  vDsMensagem := itemXml('DS_MENSAGEM', pParams);

  vDsPath := itemXml('DS_UNIDTERMINAL', PARAM_GLB);
  vDsPath := '' + vDsPath:\ECF\' + ';

  vDsCupom := itemXml('DS_CUPOM', pParams);
  xStatus := 0;

  if (vDsMensagem<>'') then begin
    repeat
      scan vDsMensagem, '';
      if (gresult > 0) then begin
        putitem(vDsLinhaObs,  vDsMensagem[1 : gresult - 1]);
        vDsCupom := '' + vDsCupom + '066' + vDsMensagem[ + '1 : gresult - 1]';
        vDsMensagem := vDsMensagem[gresult + 1];
      end;
    until (gresult := 0);
  end;
  if (itemXml('IN_LOG_TEMPO_VendA', PARAM_GLB) = 1) then begin
    gHrFim := gclock;
    putmess 'ECFSVCO011: fechaCupom - Inicio filedump fechaCupom: ' + gHrFim' + ';
  end;
  if (itemXml('PADRAO_ECF', PARAM_GLB) = <PADRAO_LOCALIMPFINAL>) then begin
    vDsCupom := '' + vDsCupom + '006016';
    filedump '' + vDsCupom', + ' '' + vDsPathECF + '.TMP';

  end else begin
    filedump '006', '' + vDsPathECF + '.TMP';

  end;
  if (xStatus < 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Falha na gravação de arquivos na máquina check in!', cDS_METHOD);
    return(-1); exit;
  end;
  if (itemXml('IN_LOG_TEMPO_VendA', PARAM_GLB) = 1) then begin
    gHrFim := gclock;
    putmess 'ECFSVCO011: fechaCupom - Fim filedump fechaCupom: ' + gHrFim' + ';
  end;

  voParams := activateCmp('vbfileman', 'movearquivo', viParams); (*vEOF,'' + vDsPathECF + '.TMP','' + vDsPathECF + '.TXT' *)
  if (xStatus < 0) then begin
    Result := voParams;
    return(-1); exit;
  end;
  if (itemXml('IN_LOG_TEMPO_VendA', PARAM_GLB) = 1) then begin
    gHrFim := gclock;
    putmess 'ECFSVCO011: fechaCupom - Aguardando leitura RETORNOECF.TXT fechaCupom: ' + gHrFim' + ';
  end;

  vDsConteudo := '';
  vQtTentativa := 0;
  vQtContador := 200000;

  repeat
    voParams := activateCmp('vbfileman', 'arqexiste', viParams); (*vFlag,'' + vDsPathRETORNOECF + '.TXT' *)
    if (vFlag = True) then begin
      break;
    end;
    if (itemXml('TEF_COMUNICACAO_GP', PARAM_GLB) = True) then begin
      voParams := activateCmp('KERNEL32', 'SLEEP', viParams); (*1000 *)
      vQtContador := 180;
    end;
    vQtTentativa := vQtTentativa + 1;

    if (vQtTentativa > vQtContador) then begin
      Result := SetStatus(STS_ERROR, 'GEN0001', 'Falha na comunicação tempo de resposta esgotado para máquina check in!', cDS_METHOD);
      voParams := activateCmp('vbfileman', 'apagaarquivo', viParams); (*'' + vDsPathECF + '.TXT' *)
      if (xStatus < 0) then begin
        Result := voParams;
        return(-1); exit;
      end;
      return(-1); exit;
    end;

  until (vDsConteudo <> '');

  fileload '' + vDsPathRETORNOECF + '.TXT', vDsConteudo;
  length vDsConteudo;
  Status := vDsConteudo[1, 4];
  if (Status = -1) then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', '' + vDsConteudo[ + '5, gresult]', cDS_METHOD);
    voParams := activateCmp('vbfileman', 'apagaarquivo', viParams); (*'' + vDsPathRETORNOECF + '.TXT' *)
    if (xStatus < 0) then begin
      Result := voParams;
      return(-1); exit;
    end;

    return(-1); exit;
  end else begin
    if (itemXml('PADRAO_ECF', PARAM_GLB) = <PADRAO_LOCAL>) then begin
      if (itemXml('IN_LOG_TEMPO_VendA', PARAM_GLB) = 1) then begin
        gHrFim := gclock;
        putmess 'ECFSVCO011: fechaCupom - Inicio gravaCupomINIFIM fechaCupom: ' + gHrFim' + ';
      end;

      putitemXml(viParams, 'NR_CUPOM', itemXmlF('NR_CUPOM', pParams));
      putitemXml(viParams, 'NR_SERIE', itemXmlF('CD_SERIEECF', PARAM_GLB));
      putitemXml(viParams, 'DT_EMISSAO', itemXml('DT_SISTEMA', PARAM_GLB));
      voParams := activateCmp('FISSVCO008', 'gravaCupomINIFIM', viParams); (*,,,, *)
      if (xStatus < 0) then begin
        Result := voParams;
        return(-1); exit;
      end;
      if (itemXml('IN_LOG_TEMPO_VendA', PARAM_GLB) = 1) then begin
        gHrFim := gclock;
        putmess 'ECFSVCO011: fechaCupom - Fim gravaCupomINIFIM fechaCupom: ' + gHrFim' + ';
      end;
    end else begin
      voParams := activateCmp('vbfileman', 'filename', viParams); (*'' + vDsPathRETORNOECF + '.TXT' *)
      if (xStatus < 0) then begin
        Result := voParams;
        return(-1); exit;
      end;

      repeat
        voParams := activateCmp('vbfileman', 'learquivo', viParams); (*vDsLinha *)
        if (xStatus < 0) then begin
          Result := voParams;
          return(-1); exit;
        end;

        vDsRetorno := itemXmlF('NR_CUPOM', vDsLinha);
        length(vDsRetorno);
        if (gresult > 0) then begin
          putitemXml(Result, 'NR_CUPOM', vDsRetorno);

          viParams := '';
          putitemXml(viParams, 'NR_CUPOM', vDsRetorno);
          putitemXml(viParams, 'NR_SERIE', itemXmlF('CD_SERIEECF', PARAM_GLB));
          putitemXml(viParams, 'DT_EMISSAO', itemXml('DT_SISTEMA', PARAM_GLB));
          voParams := activateCmp('FISSVCO008', 'gravaCupomINIFIM', viParams); (*,,,, *)
          if (xStatus < 0) then begin
            Result := voParams;
            return(-1); exit;
          end;
        end;

        voParams := activateCmp('vbfileman', 'eof', viParams); (*vEOF *)
        if (xStatus < 0) then begin
          Result := voParams;
          return(-1); exit;
        end;

      until (vEOF := -1);
    end;
  end;
  if (itemXml('IN_LOG_TEMPO_VendA', PARAM_GLB) = 1) then begin
    gHrFim := gclock;
    putmess 'ECFSVCO011: fechaCupom - Fim leitura RETORNOECF.TXT fechaCupom: ' + gHrFim' + ';
  end;

  voParams := activateCmp('vbfileman', 'apagaarquivo', viParams); (*'' + vDsPathRETORNOECF + '.TXT' *)
  if (xStatus < 0) then begin
    Result := voParams;
    return(-1); exit;
  end;
  if (itemXml('IN_LOG_TEMPO_VendA', PARAM_GLB) = 1) then begin
    gHrFim := gclock;
    putmess 'ECFSVCO011: fechaCupom - Fim fechaCupom: ' + gHrFim' + ';
  end;

  return(0); exit;
end;

//--------------------------------------------------------
function T_ECFSVCO011.leituraX(pParams : String) : String;
//--------------------------------------------------------
const
  cDS_METHOD = 'ADICIONAL=Operação: T_ECFSVCO011.leituraX()';
var
  vEOF, vDsPath, vDsConteudo : String;
  vQtTentativa, Status : Real;
  vFlag : Boolean;
begin
  vDsPath := itemXml('DS_UNIDTERMINAL', PARAM_GLB);
  vDsPath := '' + vDsPath:\ECF\' + ';
  xStatus := 0;

  filedump '009', '' + vDsPathECF + '.TMP';
  if (xStatus < 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Falha na gravação de arquivos na máquina check in!', cDS_METHOD);
    return(-1); exit;
  end;

  voParams := activateCmp('vbfileman', 'movearquivo', viParams); (*vEOF,'' + vDsPathECF + '.TMP','' + vDsPathECF + '.TXT' *)
  if (xStatus < 0) then begin
    Result := voParams;
    return(-1); exit;
  end;

  vDsConteudo := '';
  vQtTentativa := 0;
  repeat
    voParams := activateCmp('vbfileman', 'arqexiste', viParams); (*vFlag,'' + vDsPathRETORNOECF + '.TXT' *)
    if (vFlag = True) then begin
      break;
    end;
    voParams := activateCmp('KERNEL32', 'SLEEP', viParams); (*2000 *)
    vQtTentativa := vQtTentativa + 1;
    if (vQtTentativa > 50000) then begin
      Result := SetStatus(STS_ERROR, 'GEN0001', 'Falha na comunicação tempo de resposta esgotado para máquina check in!', cDS_METHOD);
      voParams := activateCmp('vbfileman', 'apagaarquivo', viParams); (*'' + vDsPathECF + '.TXT' *)
      if (xStatus < 0) then begin
        Result := voParams;
        return(-1); exit;
      end;
      return(-1); exit;
    end;

  until (vDsConteudo <> '');

  length vDsConteudo;
  Status := vDsConteudo[1, 4];
  if (Status = -1) then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', '' + vDsConteudo[ + '5, gresult]', cDS_METHOD);
    voParams := activateCmp('vbfileman', 'apagaarquivo', viParams); (*'' + vDsPathRETORNOECF + '.TXT' *)
    if (xStatus < 0) then begin
      Result := voParams;
      return(-1); exit;
    end;
    return(-1); exit;
  end else begin
    voParams := setDisplay(viParams); (* '' + vDsConteudo[ + '5, gresult]', '', '' *)
    if (xStatus < 0) then begin
      Result := voParams;
      return(-1); exit;
    end;
  end;

  voParams := activateCmp('vbfileman', 'apagaarquivo', viParams); (*'' + vDsPathRETORNOECF + '.TXT' *)
  if (xStatus < 0) then begin
    Result := voParams;
    return(-1); exit;
  end;

  return(0); exit;
end;

//------------------------------------------------------------
function T_ECFSVCO011.cancelaCupom(pParams : String) : String;
//------------------------------------------------------------
const
  cDS_METHOD = 'ADICIONAL=Operação: T_ECFSVCO011.cancelaCupom()';
var
  vEOF, vDsPath, vDsConteudo : String;
  vQtTentativa, Status : Real;
begin
  vDsPath := itemXml('DS_UNIDTERMINAL', PARAM_GLB);
  vDsPath := '' + vDsPath:\ECF\' + ';
  xStatus := 0;

  filedump '008', '' + vDsPathECF + '.TMP';
  if (xStatus < 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Falha na gravação de arquivos na máquina check in!', cDS_METHOD);
    return(-1); exit;
  end;

  voParams := activateCmp('vbfileman', 'movearquivo', viParams); (*vEOF,'' + vDsPathECF + '.TMP','' + vDsPathECF + '.TXT' *)
  if (xStatus < 0) then begin
    Result := voParams;
    return(-1); exit;
  end;

  vDsConteudo := '';
  vQtTentativa := 0;
  repeat

    fileload '' + vDsPathRETORNOECF + '.TXT', vDsConteudo;
    if (xStatus < 0) then begin
      Result := voParams;
      return(-1); exit;
    end;
        if (xStatus < 0) then begin
          Result := voParams;
          return(-1); exit;
        end;
        return(-1); exit;
      end;
    end;

  until (vDsConteudo <> '');

  length vDsConteudo;
  Status := vDsConteudo[1, 4];
  if (Status = -1) then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', '' + vDsConteudo[ + '5, gresult]', cDS_METHOD);
    voParams := activateCmp('vbfileman', 'apagaarquivo', viParams); (*'' + vDsPathRETORNOECF + '.TXT' *)
    if (xStatus < 0) then begin
      Result := voParams;
      return(-1); exit;
    end;

    return(-1); exit;
  end else begin
    voParams := setDisplay(viParams); (* '' + vDsConteudo[ + '5, gresult]', '', '' *)
    if (xStatus < 0) then begin
      Result := voParams;
      return(-1); exit;
    end;
  end;

  voParams := activateCmp('vbfileman', 'apagaarquivo', viParams); (*'' + vDsPathRETORNOECF + '.TXT' *)
  if (xStatus < 0) then begin
    Result := voParams;
    return(-1); exit;
  end;

  return(0); exit;
end;

//---------------------------------------------------------------
function T_ECFSVCO011.verificarEstado(pParams : String) : String;
//---------------------------------------------------------------
const
  cDS_METHOD = 'ADICIONAL=Operação: T_ECFSVCO011.verificarEstado()';
var
  vCdComponente, vDsRetorno, vEOF, vDsLinha, vDsPath, vDsConteudo : String;
  vQtTentativa, Status : Real;
  vInConcomitante : Boolean;
begin
  vInConcomitante := itemXmlB('IN_CONCOMITANTE', pParams);
  if (vInConcomitante = '') then begin
    vInConcomitante := False;
  end;
  vDsPath := itemXml('DS_UNIDTERMINAL', PARAM_GLB);
  vDsPath := '' + vDsPath:\ECF\' + ';
  xStatus := 0;

  if (vInConcomitante = False) then begin
    if (itemXml('PADRAO_ECF', PARAM_GLB) = <PADRAO_LOCALIMPFINAL>) then begin
      putitemXml(Result, 'DS_CUPOM', '015');
      return(0); exit;
    end;
  end;

  filedump '015', '' + vDsPathECF + '.TMP';
  if (xStatus < 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Falha na gravação de arquivos na máquina check in!', cDS_METHOD);
    return(-1); exit;
  end;

  voParams := activateCmp('vbfileman', 'movearquivo', viParams); (*vEOF,'' + vDsPathECF + '.TMP','' + vDsPathECF + '.TXT' *)
  if (xStatus < 0) then begin
    Result := voParams;
    return(-1); exit;
  end;

  vDsConteudo := '';
  vQtTentativa := 0;
  repeat
    fileload '' + vDsPathRETORNOECF + '.TXT', vDsConteudo;
    if (xStatus < 0) then begin
      Result := voParams;
      return(-1); exit;
    end;
        if (xStatus < 0) then begin
          Result := voParams;
          return(-1); exit;
        end;
        return(-1); exit;
      end;
    end;

  until (vDsConteudo <> '');

  length vDsConteudo;
  Status := vDsConteudo[1, 4];
  if (Status = -1) then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', '' + vDsConteudo[ + '5, gresult]', cDS_METHOD);
    voParams := activateCmp('vbfileman', 'apagaarquivo', viParams); (*'' + vDsPathRETORNOECF + '.TXT' *)
    if (xStatus < 0) then begin
      Result := voParams;
      return(-1); exit;
    end;

    return(-1); exit;
  end else begin
    voParams := setDisplay(viParams); (* '' + vDsConteudo[ + '5, gresult]', '', '' *)
    if (xStatus < 0) then begin
      Result := voParams;
      return(-1); exit;
    end;
  end;

  voParams := activateCmp('vbfileman', 'filename', viParams); (*'' + vDsPathRETORNOECF + '.TXT' *)
  if (xStatus < 0) then begin
    Result := voParams;
    return(-1); exit;
  end;

  repeat

    voParams := activateCmp('vbfileman', 'learquivo', viParams); (*vDsLinha *)
    if (xStatus < 0) then begin
      Result := voParams;
      return(-1); exit;
    end;

    vDsRetorno := itemXml('INABERTO', vDsLinha);
    length(vDsRetorno);
    if (gresult > 0) then begin
      putitemXml(Result, 'INABERTO', vDsRetorno);

    end;

    voParams := activateCmp('vbfileman', 'eof', viParams); (*vEOF *)
    if (xStatus < 0) then begin
      Result := voParams;
      return(-1); exit;
    end;

  until (vEOF := -1);

  voParams := activateCmp('vbfileman', 'apagaarquivo', viParams); (*'' + vDsPathRETORNOECF + '.TXT' *)
  if (xStatus < 0) then begin
    Result := voParams;
    return(-1); exit;
  end;

  return(0); exit;
end;

//----------------------------------------------------------------------
function T_ECFSVCO011.leInformacaoImpressora(pParams : String) : String;
//----------------------------------------------------------------------
const
  cDS_METHOD = 'ADICIONAL=Operação: T_ECFSVCO011.leInformacaoImpressora()';
var
  vEOF, vDsLinha, vDsRetorno, vDsPath, vDsConteudo, viParams, voParams, vDsLista, vDsRegistro : String;
  vQtTentativa, Status : Real;
  vFlag : Boolean;
begin
  vDsPath := itemXml('DS_UNIDTERMINAL', PARAM_GLB);
  vDsPath := '' + vDsPath:\ECF\' + ';
  xStatus := 0;

  if (itemXml('NM_FUNCAO', pParams) = '<ECF_NUMERO_CUPOM>') then begin
    if (itemXml('IN_IMPCUPOMFISCAL', pParams) = True) then begin
      if (itemXml('PADRAO_ECF', PARAM_GLB) = <PADRAO_LOCAL>) then begin
        filedump '016', '' + vDsPathECF + '.TMP';
      end else begin
        putitemXml(Result, 'DS_CUPOM', '016');
        return(0); exit;
      end;
    end else begin
      filedump '016', '' + vDsPathECF + '.TMP';
    end;
  end else if (itemXml('NM_FUNCAO', pParams) = '<ECF_NUMERO_SERIE>') then begin
    filedump '017', '' + vDsPathECF + '.TMP';
  end else if (itemXml('NM_FUNCAO', pParams) = '<ECF_ALIQUOTA>') then begin
    filedump '028', '' + vDsPathECF + '.TMP';
  end else if (itemXml('NM_FUNCAO', pParams) = '<ECF_FORMAPGTO>') then begin
    filedump '027', '' + vDsPathECF + '.TMP';
  end;
  if (xStatus < 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Falha na gravação de arquivos na máquina check in!', cDS_METHOD);
    return(-1); exit;
  end;

  voParams := activateCmp('vbfileman', 'movearquivo', viParams); (*vEOF,'' + vDsPathECF + '.TMP','' + vDsPathECF + '.TXT' *)
  if (xStatus < 0) then begin
    Result := voParams;
    return(-1); exit;
  end;

  vDsConteudo := '';
  vQtTentativa := 0;
  repeat

    fileload '' + vDsPathRETORNOECF + '.TXT', vDsConteudo;
    if (xStatus < 0) then begin
      Result := voParams;
      return(-1); exit;
    end;
        if (xStatus < 0) then begin
          Result := voParams;
          return(-1); exit;
        end;
        return(-1); exit;
      end;
    end;

  until (vDsConteudo <> '');

  length vDsConteudo;
  Status := vDsConteudo[1, 4];
  if (Status = -1) then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', '' + vDsConteudo[ + '5, gresult]', cDS_METHOD);
    voParams := activateCmp('vbfileman', 'apagaarquivo', viParams); (*'' + vDsPathRETORNOECF + '.TXT' *)
    if (xStatus < 0) then begin
      Result := voParams;
      return(-1); exit;
    end;

    return(-1); exit;
  end else begin
    voParams := setDisplay(viParams); (* '' + vDsConteudo[ + '5, gresult]', '', '' *)
    if (xStatus < 0) then begin
      Result := voParams;
      return(-1); exit;
    end;
  end;

  voParams := activateCmp('vbfileman', 'filename', viParams); (*'' + vDsPathRETORNOECF + '.TXT' *)
  if (xStatus < 0) then begin
    Result := voParams;
    return(-1); exit;
  end;

  repeat

    voParams := activateCmp('vbfileman', 'learquivo', viParams); (*vDsLinha *)
    if (xStatus < 0) then begin
      Result := voParams;
      return(-1); exit;
    end;
    if (itemXml('NM_FUNCAO', pParams) = '<ECF_NUMERO_CUPOM>') then begin
      vDsRetorno := itemXmlF('NR_CUPOM', vDsLinha);
    end else if (itemXml('NM_FUNCAO', pParams) = '<ECF_NUMERO_SERIE>') then begin
      vDsRetorno := itemXmlF('NR_SERIE', vDsLinha);
    end else if (itemXml('NM_FUNCAO', pParams) = '<ECF_ALIQUOTA>') then begin
      vDsRetorno := itemXml('DS_RETORNO', vDsLinha);
    end else if (itemXml('NM_FUNCAO', pParams) = '<ECF_FORMAPGTO>') then begin
      vDsRetorno := itemXml('DS_RETORNO', vDsLinha);
    end;
    length(vDsRetorno);
    if (gresult > 0) then begin
      if (itemXml('NM_FUNCAO', pParams) = '<ECF_NUMERO_CUPOM>') then begin
        putitemXml(Result, 'NR_CUPOM', vDsRetorno);
      end else if (itemXml('NM_FUNCAO', pParams) = '<ECF_NUMERO_SERIE>') then begin
        putitemXml(Result, 'NR_SERIE', vDsRetorno);
        putitemXml(PARAM_GLB, 'CD_SERIEECF', vDsRetorno);
      end else if (itemXml('NM_FUNCAO', pParams) = '<ECF_ALIQUOTA>') then begin
        putitemXml(Result, 'DS_ALIQUOTA', vDsRetorno);
      end else if (itemXml('NM_FUNCAO', pParams) = '<ECF_FORMAPGTO>') then begin
        vDsRegistro := vDsRetorno;
        repeat
          scan vDsRegistro, ', ';
          if (gresult > 0) then begin
            putitem(vDsLista,  vDsRegistro[1 : gresult - 1]);
            vDsRegistro := vDsRegistro[gresult + 1];
          end;
        until (gresult := 0);
        putitemXml(Result, 'DS_FORMAPGTO', vDsLista);
      end;
    end;

    voParams := activateCmp('vbfileman', 'eof', viParams); (*vEOF *)
    if (xStatus < 0) then begin
      Result := voParams;
      return(-1); exit;
    end;

  until (vEOF := -1);

  voParams := activateCmp('vbfileman', 'apagaarquivo', viParams); (*'' + vDsPathRETORNOECF + '.TXT' *)
  if (xStatus < 0) then begin
    Result := voParams;
    return(-1); exit;
  end;

  return(0); exit;
end;

//--------------------------------------------------------
function T_ECFSVCO011.reducaoZ(pParams : String) : String;
//--------------------------------------------------------
const
  cDS_METHOD = 'ADICIONAL=Operação: T_ECFSVCO011.reducaoZ()';
var
  vEOF, vDsPath, vDsConteudo : String;
  vQtTentativa, Status : Real;
  vFlag : Boolean;
begin
  vDsPath := itemXml('DS_UNIDTERMINAL', PARAM_GLB);
  vDsPath := '' + vDsPath:\ECF\' + ';
  xStatus := 0;

  voParams := activateCmp('vbfileman', 'arqexiste', viParams); (*vFlag,'' + vDsPathRETORNOECF + '.TXT' *)
  if (vFlag = True) then begin
    voParams := activateCmp('vbfileman', 'apagaarquivo', viParams); (*'' + vDsPathRETORNOECF + '.TXT' *)
  end;

  filedump '010', '' + vDsPathECF + '.TMP';
  if (xStatus < 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Falha na gravação de arquivos na máquina check in!', cDS_METHOD);
    return(-1); exit;
  end;

  voParams := activateCmp('vbfileman', 'movearquivo', viParams); (*vEOF,'' + vDsPathECF + '.TMP','' + vDsPathECF + '.TXT' *)
  if (xStatus < 0) then begin
    Result := voParams;
    return(-1); exit;
  end;

  vDsConteudo := '';
  vQtTentativa := 0;
  repeat
    voParams := activateCmp('vbfileman', 'arqexiste', viParams); (*vFlag,'' + vDsPathRETORNOECF + '.TXT' *)
    if (vFlag = True) then begin
      break;
    end;
    voParams := activateCmp('KERNEL32', 'SLEEP', viParams); (*1000 *)
    vQtTentativa := vQtTentativa + 1;
    if (vQtTentativa > 10000) then begin
      Result := SetStatus(STS_ERROR, 'GEN0001', 'Falha na comunicação tempo de resposta esgotado para máquina check in!', cDS_METHOD);
      voParams := activateCmp('vbfileman', 'apagaarquivo', viParams); (*'' + vDsPathECF + '.TXT' *)
      if (xStatus < 0) then begin
        Result := voParams;
        return(-1); exit;
      end;
      return(-1); exit;
    end;
  until (vDsConteudo <> '');

  length vDsConteudo;
  Status := vDsConteudo[1, 4];
  if (Status = -1) then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', '' + vDsConteudo[ + '5, gresult]', cDS_METHOD);
    voParams := activateCmp('vbfileman', 'apagaarquivo', viParams); (*'' + vDsPathRETORNOECF + '.TXT' *)
    if (xStatus < 0) then begin
      Result := voParams;
      return(-1); exit;
    end;

    return(-1); exit;
  end else begin
    voParams := setDisplay(viParams); (* '' + vDsConteudo[ + '5, gresult]', '', '' *)
    if (xStatus < 0) then begin
      Result := voParams;
      return(-1); exit;
    end;
  end;

  voParams := activateCmp('vbfileman', 'apagaarquivo', viParams); (*'' + vDsPathRETORNOECF + '.TXT' *)
  if (xStatus < 0) then begin
    Result := voParams;
    return(-1); exit;
  end;

  return(0); exit;
end;

//--------------------------------------------------------------
function T_ECFSVCO011.registroTipo60(pParams : String) : String;
//--------------------------------------------------------------
const
  cDS_METHOD = 'ADICIONAL=Operação: T_ECFSVCO011.registroTipo60()';
var
  vEOF, vDsPath, vDsConteudo, vFlag, vNrSerie, viParams, voParams : String;
  vQtTentativa, Status : Real;
begin
  vNrSerie := itemXmlF('CD_SERIEECF', PARAM_GLB);
  if (vNrSerie = '') then begin
    viParams := '';

    putitemXml(viParams, 'NM_FUNCAO', <ECF_NUMERO_SERIE>);
    putitemXml(viParams, 'IN_IMPCUPOMFISCAL', False);
    voParams := leinformacaoImpressora(viParams); (* viParams, voParams, xCdErro, xCtxErro *)
    if (xStatus < 0) then begin
      Result := voParams;
      return(-1); exit;
    end;
    vNrSerie := itemXmlF('NR_SERIE', voParams);
    if (vNrSerie = '') then begin
      Result := SetStatus(STS_ERROR, 'GEN0001', 'Erro ao obter número de série da impressora!', cDS_METHOD);
      return(-1); exit;
    end;
  end;
  vDsPath := itemXml('DS_UNIDTERMINAL', PARAM_GLB);
  vDsPath := '' + vDsPath:\ECF\' + ';
  xStatus := 0;

  voParams := RelatorioTipo60Mestre(viParams); (* viParams, voParams, xCdErro, xCtxErro *)
  if (xStatus < 0) then begin
    Result := voParams;
    return(-1); exit;
  end;
    if (xStatus < 0) then begin
      Result := voParams;
      return(-1); exit;
    end;
    viParams := '';
    putitemXml(viParams, 'NR_SERIE', vNrSerie);
    putitemXml(viParams, 'DS_PATHREDZ', '' + vDsPath\' + FloatToStr(vNrSerie) + ' + '.TXT');
    voParams := activateCmp('FISSVCO008', 'geraMapaFiscal', viParams); (*,,,, *)
    if (xStatus < 0) then begin
      Result := voParams;
      return(-1); exit;
    end;
      voParams := RelatorioTipo60Analitico(viParams); (* viParams, voParams, xCdErro, xCtxErro *)
      if (xStatus < 0) then begin
        Result := voParams;
        return(-1); exit;
      end;
        if (xStatus < 0) then begin
          Result := voParams;
          return(-1); exit;
        end;
        viParams := '';
        putitemXml(viParams, 'NR_SERIE', vNrSerie);
        putitemXml(viParams, 'DS_PATHREDZ', '' + vDsPath\' + FloatToStr(vNrSerie) + ' + '.TXT');
        voParams := activateCmp('FISSVCO008', 'geraMapaFiscal', viParams); (*,,,, *)
        if (xStatus < 0) then begin
          Result := voParams;
          return(-1); exit;
        end;
      end;
    end;
  end;

  return(0); exit;
end;

//---------------------------------------------------------------------
function T_ECFSVCO011.relatorioTipo60Mestre(pParams : String) : String;
//---------------------------------------------------------------------
const
  cDS_METHOD = 'ADICIONAL=Operação: T_ECFSVCO011.relatorioTipo60Mestre()';
var
  vEOF, vDsPath, vDsConteudo : String;
  vQtTentativa, Status : Real;
begin
  vDsPath := itemXml('DS_UNIDTERMINAL', PARAM_GLB);
  vDsPath := '' + vDsPath:\ECF\' + ';
  xStatus := 0;

  filedump '013', '' + vDsPathECF + '.TMP';
  if (xStatus < 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Falha na gravação de arquivos na máquina check in!', cDS_METHOD);
    return(-1); exit;
  end;

  voParams := activateCmp('vbfileman', 'movearquivo', viParams); (*vEOF,'' + vDsPathECF + '.TMP','' + vDsPathECF + '.TXT' *)
  if (xStatus < 0) then begin
    Result := voParams;
    return(-1); exit;
  end;

  vDsConteudo := '';
  vQtTentativa := 0;
  repeat

    fileload '' + vDsPathRETORNOECF + '.TXT', vDsConteudo;
    if (xStatus < 0) then begin
      Result := voParams;
      return(-1); exit;
    end;
        if (xStatus < 0) then begin
          Result := voParams;
          return(-1); exit;
        end;
        return(-1); exit;
      end;
    end;

  until (vDsConteudo <> '');

  length vDsConteudo;
  Status := vDsConteudo[1, 4];
  if (Status = -1) then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', '' + vDsConteudo[ + '5, gresult]', cDS_METHOD);
    voParams := activateCmp('vbfileman', 'apagaarquivo', viParams); (*'' + vDsPathRETORNOECF + '.TXT' *)
    if (xStatus < 0) then begin
      Result := voParams;
      return(-1); exit;
    end;

    return(-1); exit;
  end else begin
    voParams := setDisplay(viParams); (* '' + vDsConteudo[ + '5, gresult]', '', '' *)
    if (xStatus < 0) then begin
      Result := voParams;
      return(-1); exit;
    end;
  end;

  voParams := activateCmp('vbfileman', 'apagaarquivo', viParams); (*'' + vDsPathRETORNOECF + '.TXT' *)
  if (xStatus < 0) then begin
    Result := voParams;
    return(-1); exit;
  end;

  return(0); exit;
end;

//------------------------------------------------------------------------
function T_ECFSVCO011.relatorioTipo60Analitico(pParams : String) : String;
//------------------------------------------------------------------------
const
  cDS_METHOD = 'ADICIONAL=Operação: T_ECFSVCO011.relatorioTipo60Analitico()';
var
  vEOF, vDsPath, vDsConteudo : String;
  vQtTentativa, Status : Real;
begin
  vDsPath := itemXml('DS_UNIDTERMINAL', PARAM_GLB);
  vDsPath := '' + vDsPath:\ECF\' + ';
  xStatus := 0;

  filedump '014', '' + vDsPathECF + '.TMP';
  if (xStatus < 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Falha na gravação de arquivos na máquina check in!', cDS_METHOD);
    return(-1); exit;
  end;

  voParams := activateCmp('vbfileman', 'movearquivo', viParams); (*vEOF,'' + vDsPathECF + '.TMP','' + vDsPathECF + '.TXT' *)
  if (xStatus < 0) then begin
    Result := voParams;
    return(-1); exit;
  end;

  vDsConteudo := '';
  vQtTentativa := 0;
  repeat

    fileload '' + vDsPathRETORNOECF + '.TXT', vDsConteudo;
    if (xStatus < 0) then begin
      Result := voParams;
      return(-1); exit;
    end;
        if (xStatus < 0) then begin
          Result := voParams;
          return(-1); exit;
        end;
        return(-1); exit;
      end;
    end;

  until (vDsConteudo <> '');

  length vDsConteudo;
  Status := vDsConteudo[1, 4];
  if (Status = -1) then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', '' + vDsConteudo[ + '5, gresult]', cDS_METHOD);
    voParams := activateCmp('vbfileman', 'apagaarquivo', viParams); (*'' + vDsPathRETORNOECF + '.TXT' *)
    if (xStatus < 0) then begin
      Result := voParams;
      return(-1); exit;
    end;

    return(-1); exit;
  end else begin
    voParams := setDisplay(viParams); (* '' + vDsConteudo[ + '5, gresult]', '', '' *)
    if (xStatus < 0) then begin
      Result := voParams;
      return(-1); exit;
    end;
  end;

  voParams := activateCmp('vbfileman', 'apagaarquivo', viParams); (*'' + vDsPathRETORNOECF + '.TXT' *)
  if (xStatus < 0) then begin
    Result := voParams;
    return(-1); exit;
  end;

  return(0); exit;
end;

//------------------------------------------------------------------------
function T_ECFSVCO011.leituraMemoriaFiscalData(pParams : String) : String;
//------------------------------------------------------------------------
const
  cDS_METHOD = 'ADICIONAL=Operação: T_ECFSVCO011.leituraMemoriaFiscalData()';
var
  vEOF, vDsPath, vDsConteudo, vDataINI, vDataFIM : String;
  vQtTentativa, Status : Real;
begin
  vDsPath := itemXml('DS_UNIDTERMINAL', PARAM_GLB);
  vDsPath := '' + vDsPath:\ECF\' + ';
  xStatus := 0;
  vDataINI := itemXml('DT_INICIO', pParams);
  if (vDataINI = '') then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Data inicial não informada!', cDS_METHOD);
    return(-1); exit;
  end;
  vDataFIM := itemXml('DT_FIM', pParams);
  if (vDataFIM = '') then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Data final não informada!', cDS_METHOD);
    return(-1); exit;
  end;
  filedump '011' + vDataINI' + vDataFIM', + ' + ' '' + vDsPathECF + '.TMP';
  if (xStatus < 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Falha na gravação de arquivos na máquina check in!', cDS_METHOD);
    return(-1); exit;
  end;

  voParams := activateCmp('vbfileman', 'movearquivo', viParams); (*vEOF,'' + vDsPathECF + '.TMP','' + vDsPathECF + '.TXT' *)
  if (xStatus < 0) then begin
    Result := voParams;
    return(-1); exit;
  end;

  vDsConteudo := '';
  vQtTentativa := 0;
  repeat

    fileload '' + vDsPathRETORNOECF + '.TXT', vDsConteudo;
    if (xStatus < 0) then begin
      Result := voParams;
      return(-1); exit;
    end;
        if (xStatus < 0) then begin
          Result := voParams;
          return(-1); exit;
        end;
        return(-1); exit;
      end;
    end;

  until (vDsConteudo <> '');

  length vDsConteudo;
  Status := vDsConteudo[1, 4];
  if (Status = -1) then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', '' + vDsConteudo[ + '5, gresult]', cDS_METHOD);
    voParams := activateCmp('vbfileman', 'apagaarquivo', viParams); (*'' + vDsPathRETORNOECF + '.TXT' *)
    if (xStatus < 0) then begin
      Result := voParams;
      return(-1); exit;
    end;

    return(-1); exit;
  end else begin
    voParams := setDisplay(viParams); (* '' + vDsConteudo[ + '5, gresult]', '', '' *)
    if (xStatus < 0) then begin
      Result := voParams;
      return(-1); exit;
    end;
  end;

  voParams := activateCmp('vbfileman', 'apagaarquivo', viParams); (*'' + vDsPathRETORNOECF + '.TXT' *)
  if (xStatus < 0) then begin
    Result := voParams;
    return(-1); exit;
  end;

  putitemXml(Result, 'DS_PATH', vDsPath);

  return(0); exit;
end;

//------------------------------------------------------------------------------
function T_ECFSVCO011.leituraMemoriaFiscalSerialData(pParams : String) : String;
//------------------------------------------------------------------------------
const
  cDS_METHOD = 'ADICIONAL=Operação: T_ECFSVCO011.leituraMemoriaFiscalSerialData()';
var
  vEOF, vDsPath, vDsConteudo, vDataINI, vDataFIM : String;
  vQtTentativa, Status : Real;
begin
  vDsPath := itemXml('DS_UNIDTERMINAL', PARAM_GLB);
  vDsPath := '' + vDsPath:\ECF\' + ';
  xStatus := 0;
  vDataINI := itemXml('DT_INICIO', pParams);
  if (vDataINI = '') then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Data inicial não informada!', cDS_METHOD);
    return(-1); exit;
  end;
  vDataFIM := itemXml('DT_FIM', pParams);
  if (vDataFIM = '') then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Data final não informada!', cDS_METHOD);
    return(-1); exit;
  end;
  filedump '033' + vDataINI' + vDataFIM', + ' + ' '' + vDsPathECF + '.TMP';
  if (xStatus < 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Falha na gravação de arquivos na máquina check in!', cDS_METHOD);
    return(-1); exit;
  end;

  voParams := activateCmp('vbfileman', 'movearquivo', viParams); (*vEOF,'' + vDsPathECF + '.TMP','' + vDsPathECF + '.TXT' *)
  if (xStatus < 0) then begin
    Result := voParams;
    return(-1); exit;
  end;

  vDsConteudo := '';
  vQtTentativa := 0;
  repeat

    fileload '' + vDsPathRETORNOECF + '.TXT', vDsConteudo;
    if (xStatus < 0) then begin
      Result := voParams;
      return(-1); exit;
    end;
        if (xStatus < 0) then begin
          Result := voParams;
          return(-1); exit;
        end;
        return(-1); exit;
      end;
    end;

  until (vDsConteudo <> '');

  length vDsConteudo;
  Status := vDsConteudo[1, 4];
  if (Status = -1) then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', '' + vDsConteudo[ + '5, gresult]', cDS_METHOD);
    voParams := activateCmp('vbfileman', 'apagaarquivo', viParams); (*'' + vDsPathRETORNOECF + '.TXT' *)
    if (xStatus < 0) then begin
      Result := voParams;
      return(-1); exit;
    end;

    return(-1); exit;
  end else begin
    voParams := setDisplay(viParams); (* '' + vDsConteudo[ + '5, gresult]', '', '' *)
    if (xStatus < 0) then begin
      Result := voParams;
      return(-1); exit;
    end;
  end;

  voParams := activateCmp('vbfileman', 'apagaarquivo', viParams); (*'' + vDsPathRETORNOECF + '.TXT' *)
  if (xStatus < 0) then begin
    Result := voParams;
    return(-1); exit;
  end;

  return(0); exit;

  putitemXml(Result, 'DS_PATH', vDsPath);

end;

//---------------------------------------------------------------------------
function T_ECFSVCO011.leituraMemoriaFiscalReducao(pParams : String) : String;
//---------------------------------------------------------------------------
const
  cDS_METHOD = 'ADICIONAL=Operação: T_ECFSVCO011.leituraMemoriaFiscalReducao()';
var
  vEOF, vDsPath, vDsConteudo, vRedINI, vRedFIM : String;
  vQtTentativa, Status : Real;
begin
  vDsPath := itemXml('DS_UNIDTERMINAL', PARAM_GLB);
  vDsPath := '' + vDsPath:\ECF\' + ';
  xStatus := 0;
  vRedINI := itemXmlF('NR_REDINI', pParams);
  if (vRedINI = '') then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Redução inicial não informada!', cDS_METHOD);
    return(-1); exit;
  end;
  voParams := preencheZero(viParams); (* vRedINI, 5, vRedINI *)
  if (xStatus < 0) then begin
    Result := voParams;
    return(-1); exit;
  end;
  vRedFIM := itemXmlF('NR_REDFIM', pParams);
  if (vRedFIM = '') then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Redução final não informada!', cDS_METHOD);
    return(-1); exit;
  end;
  voParams := preencheZero(viParams); (* vRedFIM, 5, vRedFIM *)
  filedump '012' + vRedINI' + vRedFIM', + ' + ' '' + vDsPathECF + '.TMP';
  if (xStatus < 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Falha na gravação de arquivos na máquina check in!', cDS_METHOD);
    return(-1); exit;
  end;

  voParams := activateCmp('vbfileman', 'movearquivo', viParams); (*vEOF,'' + vDsPathECF + '.TMP','' + vDsPathECF + '.TXT' *)
  if (xStatus < 0) then begin
    Result := voParams;
    return(-1); exit;
  end;

  vDsConteudo := '';
  vQtTentativa := 0;
  repeat

    fileload '' + vDsPathRETORNOECF + '.TXT', vDsConteudo;
    if (xStatus < 0) then begin
      Result := voParams;
      return(-1); exit;
    end;
        if (xStatus < 0) then begin
          Result := voParams;
          return(-1); exit;
        end;
        return(-1); exit;
      end;
    end;

  until (vDsConteudo <> '');

  length vDsConteudo;
  Status := vDsConteudo[1, 4];
  if (Status = -1) then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', '' + vDsConteudo[ + '5, gresult]', cDS_METHOD);
    voParams := activateCmp('vbfileman', 'apagaarquivo', viParams); (*'' + vDsPathRETORNOECF + '.TXT' *)
    if (xStatus < 0) then begin
      Result := voParams;
      return(-1); exit;
    end;

    return(-1); exit;
  end else begin
    voParams := setDisplay(viParams); (* '' + vDsConteudo[ + '5, gresult]', '', '' *)
    if (xStatus < 0) then begin
      Result := voParams;
      return(-1); exit;
    end;
  end;

  voParams := activateCmp('vbfileman', 'apagaarquivo', viParams); (*'' + vDsPathRETORNOECF + '.TXT' *)
  if (xStatus < 0) then begin
    Result := voParams;
    return(-1); exit;
  end;

  putitemXml(Result, 'DS_PATH', vDsPath);

  return(0); exit;
end;

//-----------------------------------------------------------------------------
function T_ECFSVCO011.leituraMemoriaFiscalSerialRed(pParams : String) : String;
//-----------------------------------------------------------------------------
const
  cDS_METHOD = 'ADICIONAL=Operação: T_ECFSVCO011.leituraMemoriaFiscalSerialRed()';
var
  vEOF, vDsPath, vDsConteudo, vRedINI, vRedFIM : String;
  vQtTentativa, Status : Real;
begin
  vDsPath := itemXml('DS_UNIDTERMINAL', PARAM_GLB);
  vDsPath := '' + vDsPath:\ECF\' + ';
  xStatus := 0;
  vRedINI := itemXmlF('NR_REDINI', pParams);
  if (vRedINI = '') then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Redução inicial não informada!', cDS_METHOD);
    return(-1); exit;
  end;
  voParams := preencheZero(viParams); (* vRedINI, 5, vRedINI *)
  if (xStatus < 0) then begin
    Result := voParams;
    return(-1); exit;
  end;
  vRedFIM := itemXmlF('NR_REDFIM', pParams);
  if (vRedFIM = '') then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Redução final não informada!', cDS_METHOD);
    return(-1); exit;
  end;
  voParams := preencheZero(viParams); (* vRedFIM, 5, vRedFIM *)
  filedump '032' + vRedINI' + vRedFIM', + ' + ' '' + vDsPathECF + '.TMP';
  if (xStatus < 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Falha na gravação de arquivos na máquina check in!', cDS_METHOD);
    return(-1); exit;
  end;

  voParams := activateCmp('vbfileman', 'movearquivo', viParams); (*vEOF,'' + vDsPathECF + '.TMP','' + vDsPathECF + '.TXT' *)
  if (xStatus < 0) then begin
    Result := voParams;
    return(-1); exit;
  end;

  vDsConteudo := '';
  vQtTentativa := 0;
  repeat

    fileload '' + vDsPathRETORNOECF + '.TXT', vDsConteudo;
    if (xStatus < 0) then begin
      Result := voParams;
      return(-1); exit;
    end;
        if (xStatus < 0) then begin
          Result := voParams;
          return(-1); exit;
        end;
        return(-1); exit;
      end;
    end;

  until (vDsConteudo <> '');

  length vDsConteudo;
  Status := vDsConteudo[1, 4];
  if (Status = -1) then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', '' + vDsConteudo[ + '5, gresult]', cDS_METHOD);
    voParams := activateCmp('vbfileman', 'apagaarquivo', viParams); (*'' + vDsPathRETORNOECF + '.TXT' *)
    if (xStatus < 0) then begin
      Result := voParams;
      return(-1); exit;
    end;

    return(-1); exit;
  end else begin
    voParams := setDisplay(viParams); (* '' + vDsConteudo[ + '5, gresult]', '', '' *)
    if (xStatus < 0) then begin
      Result := voParams;
      return(-1); exit;
    end;
  end;

  voParams := activateCmp('vbfileman', 'apagaarquivo', viParams); (*'' + vDsPathRETORNOECF + '.TXT' *)
  if (xStatus < 0) then begin
    Result := voParams;
    return(-1); exit;
  end;

  putitemXml(Result, 'DS_PATH', vDsPath);

  return(0); exit;
end;

//----------------------------------------------------------
function T_ECFSVCO011.suprimento(pParams : String) : String;
//----------------------------------------------------------
const
  cDS_METHOD = 'ADICIONAL=Operação: T_ECFSVCO011.suprimento()';
var
  vEOF, vDsPath, vDsConteudo, vCodTotNaoFiscal, vConv : String;
  vQtTentativa, Status, vlSuprimento, vAux : Real;
begin
  vDsPath := itemXml('DS_UNIDTERMINAL', PARAM_GLB);
  vDsPath := '' + vDsPath:\ECF\' + ';
  xStatus := 0;

  vCodTotNaoFiscal := 'SU';

  vnumericAux := itemXmlF('VL_SUPRIMENTO', pParams);
  voParams := editarNr(viParams); (* 12, 2, vnumericAux, vnumericAux *)
  voParams := convnumeric(viParams); (* vnumericAux, 14, vstringConv *)

  filedump '050' + vCodTotNaoFiscal' + vstringConv', + ' + ' '' + vDsPathECF + '.TMP';
  if (xStatus < 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Falha na gravação de arquivos na máquina check in!', cDS_METHOD);
    return(-1); exit;
  end;

  voParams := activateCmp('vbfileman', 'movearquivo', viParams); (*vEOF,'' + vDsPathECF + '.TMP','' + vDsPathECF + '.TXT' *)
  if (xStatus < 0) then begin
    Result := voParams;
    return(-1); exit;
  end;

  vDsConteudo := '';
  vQtTentativa := 0;
  repeat

    fileload '' + vDsPathRETORNOECF + '.TXT', vDsConteudo;
    if (xStatus < 0) then begin
      Result := voParams;
      return(-1); exit;
    end;
        if (xStatus < 0) then begin
          Result := voParams;
          return(-1); exit;
        end;
        return(-1); exit;
      end;
    end;

  until (vDsConteudo <> '');

  length vDsConteudo;
  Status := vDsConteudo[1, 4];
  if (Status = -1) then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', '' + vDsConteudo[ + '5, gresult]', cDS_METHOD);
    voParams := activateCmp('vbfileman', 'apagaarquivo', viParams); (*'' + vDsPathRETORNOECF + '.TXT' *)
    if (xStatus < 0) then begin
      Result := voParams;
      return(-1); exit;
    end;

    return(-1); exit;
  end else begin
    voParams := setDisplay(viParams); (* '' + vDsConteudo[ + '5, gresult]', '', '' *)
    if (xStatus < 0) then begin
      Result := voParams;
      return(-1); exit;
    end;
  end;

  voParams := activateCmp('vbfileman', 'apagaarquivo', viParams); (*'' + vDsPathRETORNOECF + '.TXT' *)
  if (xStatus < 0) then begin
    Result := voParams;
    return(-1); exit;
  end;

  return(0); exit;
end;

//-------------------------------------------------------
function T_ECFSVCO011.sangria(pParams : String) : String;
//-------------------------------------------------------
const
  cDS_METHOD = 'ADICIONAL=Operação: T_ECFSVCO011.sangria()';
var
  vEOF, vDsPath, vDsConteudo, vCodTotNaoFiscal, vConv : String;
  vQtTentativa, Status, vAux : Real;
begin
  vDsPath := itemXml('DS_UNIDTERMINAL', PARAM_GLB);
  vDsPath := '' + vDsPath:\ECF\' + ';
  xStatus := 0;

  vCodTotNaoFiscal := 'SA';
  vnumericAux := itemXmlF('VL_SANGRIA', pParams);
  voParams := editarNr(viParams); (* 12, 2, vnumericAux, vnumericAux *)
  voParams := convnumeric(viParams); (* vnumericAux, 14, vstringConv *)

  filedump '050' + vCodTotNaoFiscal' + vstringConv', + ' + ' '' + vDsPathECF + '.TMP';
  if (xStatus < 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Falha na gravação de arquivos na máquina check in!', cDS_METHOD);
    return(-1); exit;
  end;

  voParams := activateCmp('vbfileman', 'movearquivo', viParams); (*vEOF,'' + vDsPathECF + '.TMP','' + vDsPathECF + '.TXT' *)
  if (xStatus < 0) then begin
    Result := voParams;
    return(-1); exit;
  end;

  vDsConteudo := '';
  vQtTentativa := 0;
  repeat

    fileload '' + vDsPathRETORNOECF + '.TXT', vDsConteudo;
    if (xStatus < 0) then begin
      Result := voParams;
      return(-1); exit;
    end;
        if (xStatus < 0) then begin
          Result := voParams;
          return(-1); exit;
        end;
        return(-1); exit;
      end;
    end;

  until (vDsConteudo <> '');

  length vDsConteudo;
  Status := vDsConteudo[1, 4];
  if (Status = -1) then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', '' + vDsConteudo[ + '5, gresult]', cDS_METHOD);
    voParams := activateCmp('vbfileman', 'apagaarquivo', viParams); (*'' + vDsPathRETORNOECF + '.TXT' *)
    if (xStatus < 0) then begin
      Result := voParams;
      return(-1); exit;
    end;

    return(-1); exit;
  end else begin
    voParams := setDisplay(viParams); (* '' + vDsConteudo[ + '5, gresult]', '', '' *)
    if (xStatus < 0) then begin
      Result := voParams;
      return(-1); exit;
    end;
  end;

  voParams := activateCmp('vbfileman', 'apagaarquivo', viParams); (*'' + vDsPathRETORNOECF + '.TXT' *)
  if (xStatus < 0) then begin
    Result := voParams;
    return(-1); exit;
  end;

  return(0); exit;
end;

//-------------------------------------------------------------------
function T_ECFSVCO011.abreComprovanteNFNV(pParams : String) : String;
//-------------------------------------------------------------------
const
  cDS_METHOD = 'ADICIONAL=Operação: T_ECFSVCO011.abreComprovanteNFNV()';
var
  vEOF, vDsPath, vDsConteudo, vDsPgto, vCodTotNaoFiscal, vDsLinha, vDsCupom, vNrSerie, viParams, voParams : String;
  vDsLinhaObs, vDsRetorno, vDsFatura, vDsRegistro, vDsLista, vDsFaturaVin, vConv, vNrCupom : String;
  vQtTentativa, Status, vVlTotal, vVlFatura, vAux, vCondicao, vCdTerminal, vNrCopia, nrViasEcfTermica : Real;
  vNrLinhasCorte, vTamanho, voParams, vContador : Real;
  inLocalizou, vFlag, vInCorteVia : Boolean;
begin
  if (itemXml('IN_LOG_TEMPO_VendA', PARAM_GLB) = 1) then begin
    gHrFim := gclock;
    putmess 'ECFSVCO011: abreComprovanteNFNV - Inicio abreComprovanteNFNV: ' + gHrFim' + ';
  end;

  vDsPath := itemXml('DS_UNIDTERMINAL', PARAM_GLB);
  vDsPath := '' + vDsPath:\ECF\' + ';
  xStatus := 0;

  vDsPgto := itemXml('DS_FORMAPGTO', pParams);
  nrViasEcfTermica := itemXmlF('NR_VIAS_ECF_TERMICA', PARAM_GLB);

  vCondicao := itemXmlF('NR_CONDICAO', pParams);

  gVl14DIGITOS := itemXmlF('VL_VALOR', pParams);

  if (vDsPgto='Receb. de Fatura')  or (vDsPgto='Receb. de fatura') then begin
    vDsPgto='Receb. de Fatura';

    vCdTerminal := itemXmlF('CD_TERMINAL', PARAM_GLB);
    if (vCdTerminal <> '') then begin
      inLocalizou := False;

      clear_e(tGLB_PERIFERIC);
      putitem_o(tGLB_PERIFERIC, 'DS_PERIFERICO', 'BEMATECH MP 3000');
      retrieve_e(tGLB_PERIFERIC);
      if (xStatus >=0) then begin
        clear_e(tGER_TERMINALP);
        putitem_o(tGER_TERMINALP, 'CD_EMPRESA', itemXmlF('CD_EMPRESA', PARAM_GLB));
        putitem_o(tGER_TERMINALP, 'CD_TERMINAL', vCdTerminal);
        putitem_o(tGER_TERMINALP, 'CD_PERIFERICO', item_f('CD_PERIFERICO', tGLB_PERIFERIC));
        retrieve_e(tGER_TERMINALP);
        if (xStatus >= 0) then begin
          inLocalizou := True;
        end;
      end;
      if (inLocalizou = False) then begin
        clear_e(tGLB_PERIFERIC);
        putitem_o(tGLB_PERIFERIC, 'DS_PERIFERICO', 'SWEDA ST120');
        retrieve_e(tGLB_PERIFERIC);
        if (xStatus >=0) then begin
          clear_e(tGER_TERMINALP);
          putitem_o(tGER_TERMINALP, 'CD_EMPRESA', itemXmlF('CD_EMPRESA', PARAM_GLB));
          putitem_o(tGER_TERMINALP, 'CD_TERMINAL', vCdTerminal);
          putitem_o(tGER_TERMINALP, 'CD_PERIFERICO', item_f('CD_PERIFERICO', tGLB_PERIFERIC));
          retrieve_e(tGER_TERMINALP);
          if (xStatus >= 0) then begin
            inLocalizou := True;
          end;
        end;
      end;
      if (inLocalizou = False) then begin
        clear_e(tGLB_PERIFERIC);
        putitem_o(tGLB_PERIFERIC, 'DS_PERIFERICO', 'BEMATECH MP 4000');
        retrieve_e(tGLB_PERIFERIC);
        if (xStatus >=0) then begin
          clear_e(tGER_TERMINALP);
          putitem_o(tGER_TERMINALP, 'CD_EMPRESA', itemXmlF('CD_EMPRESA', PARAM_GLB));
          putitem_o(tGER_TERMINALP, 'CD_TERMINAL', vCdTerminal);
          putitem_o(tGER_TERMINALP, 'CD_PERIFERICO', item_f('CD_PERIFERICO', tGLB_PERIFERIC));
          retrieve_e(tGER_TERMINALP);
          if (xStatus >= 0) then begin
            inLocalizou := True;
          end;
        end;
      end;
      if (inLocalizou = True) then begin
        vDsPgto='Receb. de Fatur';
      end;
    end;

    vCodTotNaoFiscal := itemXmlF('TP_TOTALIZADOR_ECF_REC', PARAM_GLB);

    viParams := '';

    putitemXml(viParams, 'NM_FUNCAO', <ECF_NUMERO_SERIE>);
    putitemXml(viParams, 'IN_IMPCUPOMFISCAL', False);
    voParams := leinformacaoImpressora(viParams); (* viParams, voParams, xCdErro, xCtxErro *)
    if (xStatus < 0) then begin
      Result := voParams;
      return(-1); exit;
    end;
    vNrSerie := itemXmlF('NR_SERIE', voParams);
    if (vNrSerie = '') then begin
      Result := SetStatus(STS_ERROR, 'GEN0001', 'Erro ao obter número de série da impressora!', cDS_METHOD);
      return(-1); exit;
    end;

    clear_e(tFIS_ECF);
    putitem_o(tFIS_ECF, 'CD_EMPRESA', itemXmlF('CD_EMPRESA', PARAM_GLB));
    putitem_o(tFIS_ECF, 'CD_SERIEFAB', vNrSerie);
    retrieve_e(tFIS_ECF);
    if (xStatus >= 0) then begin
      clear_e(tFIS_ECFADIC);
      putitem_o(tFIS_ECFADIC, 'CD_EMPRESA', item_f('CD_EMPRESA', tFIS_ECF));
      putitem_o(tFIS_ECFADIC, 'NR_ECF', item_f('NR_ECF', tFIS_ECF));
      retrieve_e(tFIS_ECFADIC);
      if (xStatus >= 0) then begin
        if (item_f('NR_VIARECIBOTRA', tFIS_ECFADIC) > 0) then begin
          nrViasEcfTermica := item_f('NR_VIARECIBOTRA', tFIS_ECFADIC);
        end;
        vInCorteVia := item_b('IN_CORTEVIA', tFIS_ECFADIC);

        if (item_f('NR_TOTREC', tFIS_ECFADIC) > 0) then begin
          vCodTotNaoFiscal := item_f('NR_TOTREC', tFIS_ECFADIC);
        end;
        if (item_f('NR_LINHACORTE', tFIS_ECFADIC) > 0) then begin
          vNrLinhasCorte := item_f('NR_LINHACORTE', tFIS_ECFADIC);
        end;
      end;
    end;

    voParams := preencheZero(viParams); (* vCodTotNaoFiscal, 2, vCodTotNaoFiscal *)
    if (xStatus < 0) then begin
      Result := voParams;
      return(-1); exit;
    end;

    voParams := espacoDireita(viParams); (* vDsPgto, 16, vDsPgto *)
    if (xStatus < 0) then begin
      Result := voParams;
      return(-1); exit;
    end;

    vDsFatura := itemXml('DS_FATURA', pParams);
    if (vDsFatura = '') then begin
      Result := SetStatus(STS_ERROR, 'GEN0001', 'Lista de fatura nao informada!', cDS_METHOD);
      return(-1); exit;
    end;

    clear_e(tF_TMP_NR09);
    repeat
      getitem(vDsRegistro, vDsFatura, 1);

      creocc(tF_TMP_NR09, -1);
      putitem_o(tF_TMP_NR09, 'NR_GERAL', 1);
      retrieve_o(tF_TMP_NR09);
      putitem_o(tF_TMP_NR09, 'VL_FATURA', item_f('VL_FATURA', tF_TMP_NR09) + itemXmlF('VL_ARECEBER', vDsRegistro));

      vDsLista := item_a('DS_FATURA', tF_TMP_NR09);
      putitem(vDsLista,  vDsRegistro);
      putitem_o(tF_TMP_NR09, 'DS_FATURA', vDsLista);

      delitem(vDsFatura, 1);
    until (vDsFatura = '');

    if (empty(tF_TMP_NR09)=1) then begin
      Result := SetStatus(STS_ERROR, 'GEN0001', 'Lista de fatura nao informada!', cDS_METHOD);
      return(-1); exit;
    end;

    setocc(tF_TMP_NR09, 1);
    while (xStatus >= 0) do begin

      vVlFatura := item_f('VL_FATURA', tF_TMP_NR09);

      vnumericAux := item_f('VL_FATURA', tF_TMP_NR09);
      voParams := editarNr(viParams); (* 12, 2, vnumericAux, vnumericAux *)
      voParams := convnumeric(viParams); (* vnumericAux, 14, vstringConv *)

      if (vCondicao = 1)  or (vCondicao = 9) then begin
        filedump '050' + vCodTotNaoFiscal' + vstringConv' + vDsPgto + ' + ' + '016', '' + vDsPathECF + '.TMP';
        if (xStatus < 0) then begin
          Result := SetStatus(STS_ERROR, 'GEN0001', 'Falha na gravação de arquivos na máquina check in!', cDS_METHOD);
          return(-1); exit;
        end;

        voParams := activateCmp('vbfileman', 'movearquivo', viParams); (*vEOF,'' + vDsPathECF + '.TMP','' + vDsPathECF + '.TXT' *)
        if (xStatus < 0) then begin
          Result := voParams;
          return(-1); exit;
        end;

        vDsConteudo := '';
        vQtTentativa := 0;

        repeat
          voParams := activateCmp('vbfileman', 'arqexiste', viParams); (*vFlag,'' + vDsPathRETORNOECF + '.TXT' *)
          if (vFlag = True) then begin
            break;
          end;
          voParams := activateCmp('KERNEL32', 'SLEEP', viParams); (*2000 *)
          vQtTentativa := vQtTentativa + 1;
          if (vQtTentativa > 1000) then begin
            Result := SetStatus(STS_ERROR, 'GEN0001', 'Falha na comunicação tempo de resposta esgotado para máquina check in!', cDS_METHOD);
            voParams := activateCmp('vbfileman', 'apagaarquivo', viParams); (*'' + vDsPathECF + '.TXT' *)
            if (xStatus < 0) then begin
              Result := voParams;
              return(-1); exit;
            end;
            return(-1); exit;
          end;
        until (vDsConteudo <> '');

        length vDsConteudo;
        Status := vDsConteudo[1, 4];
        if (Status = -1) then begin
          Result := SetStatus(STS_ERROR, 'GEN0001', '' + vDsConteudo[ + '5, gresult]', cDS_METHOD);
          voParams := activateCmp('vbfileman', 'apagaarquivo', viParams); (*'' + vDsPathRETORNOECF + '.TXT' *)
          if (xStatus < 0) then begin
            Result := voParams;
            return(-1); exit;
          end;
          return(-1); exit;
        end else begin
          voParams := setDisplay(viParams); (* '' + vDsConteudo[ + '5, gresult]', '', '' *)
          if (xStatus < 0) then begin
            Result := voParams;
            return(-1); exit;
          end;
        end;

        voParams := activateCmp('vbfileman', 'filename', viParams); (*'' + vDsPathRETORNOECF + '.TXT' *)
        if (xStatus < 0) then begin
          Result := voParams;
          return(-1); exit;
        end;

        repeat
          voParams := activateCmp('vbfileman', 'learquivo', viParams); (*vDsLinha *)
          if (xStatus < 0) then begin
            Result := voParams;
            return(-1); exit;
          end;

          vDsRetorno := itemXmlF('NR_CUPOM', vDsLinha);
          length(vDsRetorno);
          if (gresult > 0) then begin
            putitemXml(Result, 'NR_CUPOM', vDsRetorno);
            vNrCupom := vDsRetorno;
          end;
          voParams := activateCmp('vbfileman', 'eof', viParams); (*vEOF *)
          if (xStatus < 0) then begin
            Result := voParams;
            return(-1); exit;
          end;

        until (vEOF := -1);

        voParams := activateCmp('vbfileman', 'apagaarquivo', viParams); (*'' + vDsPathRETORNOECF + '.TXT' *)
        if (xStatus < 0) then begin
          Result := voParams;
          return(-1); exit;
        end;
      end;
      if (vCondicao = 2)  or (vCondicao = 9) then begin
        putitemXml(pParams, vDsLinha);
        putitemXml(pParams, 'VL_VALOR', vVlFatura);
        putitemXml(pParams, 'DS_FORMAPGTO', vDsPgto);
        putitemXml(pParams, 'NR_CUPOM', vNrCupom);
            if (xStatus < 0) then begin
              Result := voParams;
              return(-1); exit;
            end;

        vDsCupom := itemXml('DS_CUPOM', Result);

        vNrCopia := 1;

        repeat
          vDsFaturaVin := itemXml('DS_CONTEUDO', pParams);
          if (vDsFaturaVin<>'') then begin
            repeat
              scan vDsFaturaVin, '';
              if (gresult > 0) then begin
                voParams := gresult;

                putitem(vDsLinhaObs,  vDsFaturaVin[1 : gresult - 1]);

                scan vDsLinhaObs, '[BARRA]';
                if (gresult > 0) then begin
                  vTamanho := glength(vDsLinhaObs);
                  vDsCupom := '' + vDsCupom + '135' + vDsFaturaVin[ + '8, gresult - 1]';
                end else begin
                  scan vDsLinhaObs, '[CORTE]';
                    if (gresult > 0) then begin
                      vContador := 1;
                      while (vContador <= vNrLinhasCorte) do begin
                        vDsCupom := '' + vDsCupom + '022';
                        vContador := vContador + 1;
                      end;
                      vDsCupom := '' + vDsCupom + '131';
                      vDsCupom := '' + vDsCupom + '022';
                    end else begin
                      gresult := voParams;
                      vDsCupom := '' + vDsCupom + '022' + vDsFaturaVin[ + '1 : gresult - 1]';
                    end;
                end;

                vDsFaturaVin := vDsFaturaVin[gresult + 1];
              end;
            until (gresult := 0);
          end;
          if (vNrCopia >= nrViasEcfTermica) then begin
          end else begin
            vDsCupom := '' + vDsCupom + '080';

            if (vInCorteVia = True) then begin
              if (item_f('NR_LINHACORTE', tFIS_ECFADIC) > 0) then begin
                vNrLinhasCorte := item_f('NR_LINHACORTE', tFIS_ECFADIC);
                vContador := 1;
                while (vContador <= vNrLinhasCorte) do begin
                  vDsCupom := '' + vDsCupom + '022';
                  vContador := vContador + 1;
                end;
              end;

              vDsCupom := '' + vDsCupom + '131';
            end;
          end;
          vNrCopia := vNrCopia + 1;

        until (vNrCopia > nrViasEcfTermica);

        putitemXml(pParams, 'DS_CUPOM', vDsCupom);

        if (xStatus < 0) then begin
          Result := voParams;
          return(-1); exit;
        end;
      end;
      setocc(tF_TMP_NR09, curocc(tF_TMP_NR09) + 1);
    end;
    xStatus := 0;

  end else if (vDsPgto='Cancel.Recebim.') then begin
    vCodTotNaoFiscal := itemXmlF('TP_TOTALIZADOR_ECF_CANC', PARAM_GLB);

    viParams := '';

    putitemXml(viParams, 'NM_FUNCAO', <ECF_NUMERO_SERIE>);
    putitemXml(viParams, 'IN_IMPCUPOMFISCAL', False);
    voParams := leinformacaoImpressora(viParams); (* viParams, voParams, xCdErro, xCtxErro *)
    if (xStatus < 0) then begin
      Result := voParams;
      return(-1); exit;
    end;
    vNrSerie := itemXmlF('NR_SERIE', voParams);
    if (vNrSerie = '') then begin
      Result := SetStatus(STS_ERROR, 'GEN0001', 'Erro ao obter número de série da impressora!', cDS_METHOD);
      return(-1); exit;
    end;

    clear_e(tFIS_ECF);
    putitem_o(tFIS_ECF, 'CD_EMPRESA', itemXmlF('CD_EMPRESA', PARAM_GLB));
    putitem_o(tFIS_ECF, 'CD_SERIEFAB', vNrSerie);
    retrieve_e(tFIS_ECF);
    if (xStatus >= 0) then begin
      clear_e(tFIS_ECFADIC);
      putitem_o(tFIS_ECFADIC, 'CD_EMPRESA', item_f('CD_EMPRESA', tFIS_ECF));
      putitem_o(tFIS_ECFADIC, 'NR_ECF', item_f('NR_ECF', tFIS_ECF));
      retrieve_e(tFIS_ECFADIC);
      if (xStatus >= 0) then begin
        if (item_f('NR_TOTCANCEL', tFIS_ECFADIC) > 0) then begin
          vCodTotNaoFiscal := item_f('NR_TOTCANCEL', tFIS_ECFADIC);
        end;
      end;
    end;

    voParams := preencheZero(viParams); (* vCodTotNaoFiscal, 2, vCodTotNaoFiscal *)
    if (xStatus < 0) then begin
      Result := voParams;
      return(-1); exit;
    end;

    voParams := espacoDireita(viParams); (* vDsPgto, 16, vDsPgto *)
    if (xStatus < 0) then begin
      Result := voParams;
      return(-1); exit;
    end;

    vnumericAux := gVl14DIGITOS;
    voParams := editarNr(viParams); (* 12, 2, vnumericAux, vnumericAux *)
    if (xStatus < 0) then begin
      Result := voParams;
      return(-1); exit;
    end;

    voParams := convnumeric(viParams); (* vnumericAux, 14, vstringConv *)

    filedump '050' + vCodTotNaoFiscal' + vstringConv' + vDsPgto + ' + ' + '016', '' + vDsPathECF + '.TMP';
    if (xStatus < 0) then begin
      Result := SetStatus(STS_ERROR, 'GEN0001', 'Falha na gravação de arquivos na máquina check in!', cDS_METHOD);
      return(-1); exit;
    end;

    voParams := activateCmp('vbfileman', 'movearquivo', viParams); (*vEOF,'' + vDsPathECF + '.TMP','' + vDsPathECF + '.TXT' *)
    if (xStatus < 0) then begin
      Result := voParams;
      return(-1); exit;
    end;

    repeat
      voParams := activateCmp('vbfileman', 'arqexiste', viParams); (*vFlag,'' + vDsPathRETORNOECF + '.TXT' *)
      if (vFlag = True) then begin
        break;
      end;
      vQtTentativa := vQtTentativa + 1;
      voParams := activateCmp('KERNEL32', 'SLEEP', viParams); (*2000 *)
      if (vQtTentativa > 120) then begin
        Result := SetStatus(STS_ERROR, 'GEN0001', 'Falha na comunicação tempo de resposta esgotado para máquina check in!', cDS_METHOD);
        voParams := activateCmp('vbfileman', 'apagaarquivo', viParams); (*'' + vDsPathECF + '.TXT' *)
        if (xStatus < 0) then begin
          Result := voParams;
          return(-1); exit;
        end;
        return(-1); exit;
      end;
    until (vDsConteudo <> '');
  end;
  putitemXml(Result, 'NR_CUPOM', vNrCupom);
  putitemXml(Result, 'DS_FORMAPGTO', vDsPgto);

  if (itemXml('IN_LOG_TEMPO_VendA', PARAM_GLB) = 1) then begin
    gHrFim := gclock;
    putmess 'ECFSVCO011: abreComprovanteNFNV - Fim abreComprovanteNFNV: ' + gHrFim' + ';
  end;

  xStatus := 0;
  return(0); exit;
end;

//------------------------------------------------------------------
function T_ECFSVCO011.abreComprovanteNFV(pParams : String) : String;
//------------------------------------------------------------------
const
  cDS_METHOD = 'ADICIONAL=Operação: T_ECFSVCO011.abreComprovanteNFV()';
var
  vEOF, vDsPath, vDsConteudo, vDsPgto : String;
  vQtTentativa, Status, vNrParcelas : Real;
begin
  if (itemXml('IN_LOG_TEMPO_VendA', PARAM_GLB) = 1) then begin
    gHrFim := gclock;
    putmess 'ECFSVCO011: abreComprovanteNFV - Inicio abreComprovanteNFV: ' + gHrFim' + ';
  end;

  vDsPath := itemXml('DS_UNIDTERMINAL', PARAM_GLB);
  vDsPath := '' + vDsPath:\ECF\' + ';
  xStatus := 0;

  vDsPgto := itemXml('DS_FORMAPGTO', pParams);
  voParams := espacoDireita(viParams); (* vDsPgto, 16, vDsPgto *)
  if (xStatus < 0) then begin
    Result := voParams;
    return(-1); exit;
  end;

  gVl14DIG := itemXmlF('VL_VALOR', pParams);
  gVl6DIG := itemXmlF('NR_CUPOM', pParams);
  vNrParcelas := itemXmlF('NR_PARCELAS', pParams);

  if (itemXml('PADRAO_ECF', PARAM_GLB) = <PADRAO_LOCALIMPFINAL>) then begin
    putitemXml(Result, 'DS_CUPOM', '021' + vDsPgto' + FloatToStr(gVl) + ' + '14DIG' + FloatToStr(gVl) + '6DIG' + FloatToStr(vNrParcelas')) + ';
    return(0); exit;
  end;
  if (itemXml('IN_LOG_TEMPO_VendA', PARAM_GLB) = 1) then begin
    gHrFim := gclock;
    putmess 'ECFSVCO011: abreComprovanteNFV - Inicio filedump abreComprovanteNFV: ' + gHrFim' + ';
  end;

  filedump '021' + vDsPgto' + FloatToStr(gVl) + ' + '14DIG' + FloatToStr(gVl) + '6DIG' + FloatToStr(vNrParcelas',) + ' '' + vDsPathECF + '.TMP';
  if (xStatus < 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Falha na gravação de arquivos na máquina check in!', cDS_METHOD);
    return(-1); exit;
  end;
  if (itemXml('IN_LOG_TEMPO_VendA', PARAM_GLB) = 1) then begin
    gHrFim := gclock;
    putmess 'ECFSVCO011: abreComprovanteNFV - Fim filedump abreComprovanteNFV: ' + gHrFim' + ';
  end;

  voParams := activateCmp('vbfileman', 'movearquivo', viParams); (*vEOF,'' + vDsPathECF + '.TMP','' + vDsPathECF + '.TXT' *)
  if (xStatus < 0) then begin
    Result := voParams;
    return(-1); exit;
  end;
  if (itemXml('IN_LOG_TEMPO_VendA', PARAM_GLB) = 1) then begin
    gHrFim := gclock;
    putmess 'ECFSVCO011: abreComprovanteNFV - Aguardando RETORNOECF.TXT abreComprovanteNFV: ' + gHrFim' + ';
  end;

  vDsConteudo := '';
  vQtTentativa := 0;
  repeat

    fileload '' + vDsPathRETORNOECF + '.TXT', vDsConteudo;
    if (xStatus < 0) then begin
      Result := voParams;
      return(-1); exit;
    end;
        if (xStatus < 0) then begin
          Result := voParams;
          return(-1); exit;
        end;
        return(-1); exit;
      end;
    end;

  until (vDsConteudo <> '');

  length vDsConteudo;
  Status := vDsConteudo[1, 4];
  if (Status = -1) then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', '' + vDsConteudo[ + '5, gresult]', cDS_METHOD);
    voParams := activateCmp('vbfileman', 'apagaarquivo', viParams); (*'' + vDsPathRETORNOECF + '.TXT' *)
    if (xStatus < 0) then begin
      Result := voParams;
      return(-1); exit;
    end;

    return(-1); exit;
  end else begin
    voParams := setDisplay(viParams); (* '' + vDsConteudo[ + '5, gresult]', '', '' *)
    if (xStatus < 0) then begin
      Result := voParams;
      return(-1); exit;
    end;
  end;
  if (itemXml('IN_LOG_TEMPO_VendA', PARAM_GLB) = 1) then begin
    gHrFim := gclock;
    putmess 'ECFSVCO011: abreComprovanteNFV - Fim leitura RETORNOECF.TXT abreComprovanteNFV: ' + gHrFim' + ';
  end;

  voParams := activateCmp('vbfileman', 'apagaarquivo', viParams); (*'' + vDsPathRETORNOECF + '.TXT' *)
  if (xStatus < 0) then begin
    Result := voParams;
    return(-1); exit;
  end;
  if (itemXml('IN_LOG_TEMPO_VendA', PARAM_GLB) = 1) then begin
    gHrFim := gclock;
    putmess 'ECFSVCO011: abreComprovanteNFV - Fim abreComprovanteNFV: ' + gHrFim' + ';
  end;

  return(0); exit;
end;

//----------------------------------------------------------------
function T_ECFSVCO011.imprimeVinculado(pParams : String) : String;
//----------------------------------------------------------------
const
  cDS_METHOD = 'ADICIONAL=Operação: T_ECFSVCO011.imprimeVinculado()';
var
  vEOF, vDsPath, vDsConteudo, vDsTexto : String;
  vQtTentativa, Status : Real;
  vInImprimeVia : Boolean;
begin
  if (itemXml('IN_LOG_TEMPO_VendA', PARAM_GLB) = 1) then begin
    gHrFim := gclock;
    putmess 'ECFSVCO011: imprimeVinculado - Inicio imprimeVinculado: ' + gHrFim' + ';
  end;

  vInImprimeVia := itemXmlB('IN_IMPRIMEVIA', pParams);
  if (vInImprimeVia = '') then begin
    vInImprimeVia := False;
  end;
  vDsPath := itemXml('DS_UNIDTERMINAL', PARAM_GLB);
  vDsPath := '' + vDsPath:\ECF\' + ';
  xStatus := 0;

  vDsTexto := itemXml('DS_TEXTO', pParams);

  if (itemXml('PADRAO_ECF', PARAM_GLB) = <PADRAO_LOCALIMPFINAL>) then begin
    putitemXml(Result, 'DS_CUPOM', '022' + vDsTexto') + ';
    if (vInImprimeVia = False) then begin
      return(0); exit;
    end;
  end;
  if (itemXml('IN_LOG_TEMPO_VendA', PARAM_GLB) = 1) then begin
    gHrFim := gclock;
    putmess 'ECFSVCO011: imprimeVinculado - Inicio filedump imprimeVinculado: ' + gHrFim' + ';
  end;
  filedump '' + vDsTexto', + ' '' + vDsPathECF + '.TMP';

  if (xStatus < 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Falha na gravaçco de arquivos na máquina check in!', cDS_METHOD);
    return(-1); exit;
  end;

  voParams := activateCmp('vbfileman', 'movearquivo', viParams); (*vEOF,'' + vDsPathECF + '.TMP','' + vDsPathECF + '.TXT' *)
  if (xStatus < 0) then begin
    Result := voParams;
    return(-1); exit;
  end;
  if (itemXml('IN_LOG_TEMPO_VendA', PARAM_GLB) = 1) then begin
    gHrFim := gclock;
    putmess 'ECFSVCO011: imprimeVinculado - Fim filedump imprimeVinculado: ' + gHrFim' + ';
  end;
  if (itemXml('IN_LOG_TEMPO_VendA', PARAM_GLB) = 1) then begin
    gHrFim := gclock;
    putmess 'ECFSVCO011: imprimeVinculado - Aguardando leitura RETORNOECF.TXT imprimeVinculado: ' + gHrFim' + ';
  end;

  vDsConteudo := '';
  vQtTentativa := 0;
  repeat

    fileload '' + vDsPathRETORNOECF + '.TXT', vDsConteudo;
    if (xStatus < 0) then begin
      Result := voParams;
      return(-1); exit;
    end;
        if (xStatus < 0) then begin
          Result := voParams;
          return(-1); exit;
        end;
        return(-1); exit;
      end;
    end;

  until (vDsConteudo <> '');

  length vDsConteudo;
  Status := vDsConteudo[1, 4];
  if (Status = -1) then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', '' + vDsConteudo[ + '5, gresult]', cDS_METHOD);
    voParams := activateCmp('vbfileman', 'apagaarquivo', viParams); (*'' + vDsPathRETORNOECF + '.TXT' *)
    if (xStatus < 0) then begin
      Result := voParams;
      return(-1); exit;
    end;

    return(-1); exit;
  end else begin
    voParams := setDisplay(viParams); (* '' + vDsConteudo[ + '5, gresult]', '', '' *)
    if (xStatus < 0) then begin
      Result := voParams;
      return(-1); exit;
    end;
  end;
  if (itemXml('IN_LOG_TEMPO_VendA', PARAM_GLB) = 1) then begin
    gHrFim := gclock;
    putmess 'ECFSVCO011: imprimeVinculado - Fim leitura RETORNOECF.TXT imprimeVinculado: ' + gHrFim' + ';
  end;

  voParams := activateCmp('vbfileman', 'apagaarquivo', viParams); (*'' + vDsPathRETORNOECF + '.TXT' *)
  if (xStatus < 0) then begin
    Result := voParams;
    return(-1); exit;
  end;
  if (itemXml('IN_LOG_TEMPO_VendA', PARAM_GLB) = 1) then begin
    gHrFim := gclock;
    putmess 'ECFSVCO011: imprimeVinculado - Fim imprimeVinculado: ' + gHrFim' + ';
  end;

  return(0); exit;
end;

//--------------------------------------------------------------
function T_ECFSVCO011.fechaVinculado(pParams : String) : String;
//--------------------------------------------------------------
const
  cDS_METHOD = 'ADICIONAL=Operação: T_ECFSVCO011.fechaVinculado()';
var
  vEOF, vDsPath, vDsConteudo, vDsCupom : String;
  vQtTentativa, Status : Real;
  vFlag : Boolean;
begin
  if (itemXml('IN_LOG_TEMPO_VendA', PARAM_GLB) = 1) then begin
    gHrFim := gclock;
    putmess 'ECFSVCO011: fechaVinculado - Inicio fechaVinculado: ' + gHrFim' + ';
  end;

  vDsPath := itemXml('DS_UNIDTERMINAL', PARAM_GLB);
  vDsPath := '' + vDsPath:\ECF\' + ';
  xStatus := 0;

  if (itemXml('IN_LOG_TEMPO_VendA', PARAM_GLB) = 1) then begin
    gHrFim := gclock;
    putmess 'ECFSVCO011: fechaVinculado - Inicio filedump fechaVinculado: ' + gHrFim' + ';
  end;
  if (itemXml('PADRAO_ECF', PARAM_GLB) = <PADRAO_LOCALIMPFINAL>) then begin
    vDsCupom := itemXml('DS_CUPOM', pParams);
    vDsCupom := '' + vDsCupom + '023';
    filedump '' + vDsCupom', + ' '' + vDsPathECF + '.TMP';
  end else begin
    filedump '023', '' + vDsPathECF + '.TMP';
  end;
  if (xStatus < 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Falha na gravação de arquivos na máquina check in!', cDS_METHOD);
    return(-1); exit;
  end;

  voParams := activateCmp('vbfileman', 'movearquivo', viParams); (*vEOF,'' + vDsPathECF + '.TMP','' + vDsPathECF + '.TXT' *)
  if (xStatus < 0) then begin
    Result := voParams;
    return(-1); exit;
  end;
  if (itemXml('IN_LOG_TEMPO_VendA', PARAM_GLB) = 1) then begin
    gHrFim := gclock;
    putmess 'ECFSVCO011: fechaVinculado - Fim filedump fechaVinculado: ' + gHrFim' + ';
  end;
  if (itemXml('IN_LOG_TEMPO_VendA', PARAM_GLB) = 1) then begin
    gHrFim := gclock;
    putmess 'ECFSVCO011: fechaVinculado - Aguardando leitura RETORNOECF.TXT fechaVinculado: ' + gHrFim' + ';
  end;

  vDsConteudo := '';
  vQtTentativa := 0;
  repeat
    voParams := activateCmp('vbfileman', 'arqexiste', viParams); (*vFlag,'' + vDsPathRETORNOECF + '.TXT' *)
    if (vFlag = True) then begin
      break;
    end;
    voParams := activateCmp('KERNEL32', 'SLEEP', viParams); (*2000 *)
    vQtTentativa := vQtTentativa + 1;
    if (vQtTentativa > 120) then begin
      Result := SetStatus(STS_ERROR, 'GEN0001', 'Falha na comunicação tempo de resposta esgotado para máquina check in!', cDS_METHOD);
      voParams := activateCmp('vbfileman', 'apagaarquivo', viParams); (*'' + vDsPathECF + '.TXT' *)
      if (xStatus < 0) then begin
        Result := voParams;
        return(-1); exit;
      end;
      return(-1); exit;
    end;
  until (vDsConteudo <> '');

  length vDsConteudo;
  Status := vDsConteudo[1, 4];
  if (Status = -1) then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', '' + vDsConteudo[ + '5, gresult]', cDS_METHOD);
    voParams := activateCmp('vbfileman', 'apagaarquivo', viParams); (*'' + vDsPathRETORNOECF + '.TXT' *)
    if (xStatus < 0) then begin
      Result := voParams;
      return(-1); exit;
    end;

    return(-1); exit;
  end else begin
    voParams := setDisplay(viParams); (* '' + vDsConteudo[ + '5, gresult]', '', '' *)
    if (xStatus < 0) then begin
      Result := voParams;
      return(-1); exit;
    end;
  end;
  if (itemXml('IN_LOG_TEMPO_VendA', PARAM_GLB) = 1) then begin
    gHrFim := gclock;
    putmess 'ECFSVCO011: fechaVinculado - Fim leitura RETORNOECF.TXT fechaVinculado: ' + gHrFim' + ';
  end;

  voParams := activateCmp('vbfileman', 'apagaarquivo', viParams); (*'' + vDsPathRETORNOECF + '.TXT' *)
  if (xStatus < 0) then begin
    Result := voParams;
    return(-1); exit;
  end;
  if (itemXml('IN_LOG_TEMPO_VendA', PARAM_GLB) = 1) then begin
    gHrFim := gclock;
    putmess 'ECFSVCO011: fechaVinculado - Fim fechaVinculado: ' + gHrFim' + ';
  end;

  return(0); exit;
end;

//--------------------------------------------------------------------------
function T_ECFSVCO011.imprimirRelatorioGerencial(pParams : String) : String;
//--------------------------------------------------------------------------
const
  cDS_METHOD = 'ADICIONAL=Operação: T_ECFSVCO011.imprimirRelatorioGerencial()';
var
  viParams, voParams, vEOF, vDsPath, vDsConteudo, vDsTexto, vDsLinha, vDsCupom : String;
  vDsArquivo, vNrSerie : String;
  vQtTentativa, Status, vTamanho, vNrLinhasCorte, vContador : Real;
  vInImprimeVia : Boolean;
begin
  if (itemXml('IN_LOG_TEMPO_VendA', PARAM_GLB) = 1) then begin
    gHrFim := gclock;
    putmess 'ECFSVCO011: imprimirRelatorioGerencial - Inicio imprimirRelatorioGerencial: ' + gHrFim' + ';
  end;

  vInImprimeVia := itemXmlB('IN_IMPRIMEVIA', pParams);
  if (vInImprimeVia = '') then begin
    vInImprimeVia := False;
  end;
  vDsPath := itemXml('DS_UNIDTERMINAL', PARAM_GLB);
  vDsPath := '' + vDsPath:\ECF\' + ';
  xStatus := 0;

  vDsTexto := itemXml('DS_TEXTO', pParams);
  if (itemXml('PADRAO_ECF', PARAM_GLB) = <PADRAO_LOCALIMPFINAL>) then begin
    putitemXml(Result, 'DS_CUPOM', '025' + vDsTexto') + ';
    if (vInImprimeVia = False) then begin
      return(0); exit;
    end;
  end;

  viParams := '';

  putitemXml(viParams, 'NM_FUNCAO', <ECF_NUMERO_SERIE>);
  putitemXml(viParams, 'IN_IMPCUPOMFISCAL', False);
  voParams := leinformacaoImpressora(viParams); (* viParams, voParams, xCdErro, xCtxErro *)
  if (xStatus < 0) then begin
    Result := voParams;
    return(-1); exit;
  end;
  vNrSerie := itemXmlF('NR_SERIE', voParams);
  if (vNrSerie = '') then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Erro ao obter número de série da impressora!', cDS_METHOD);
    return(-1); exit;
  end;

  clear_e(tFIS_ECF);
  putitem_o(tFIS_ECF, 'CD_EMPRESA', itemXmlF('CD_EMPRESA', PARAM_GLB));
  putitem_o(tFIS_ECF, 'CD_SERIEFAB', vNrSerie);
  retrieve_e(tFIS_ECF);
  if (xStatus >= 0) then begin
    clear_e(tFIS_ECFADIC);
    putitem_o(tFIS_ECFADIC, 'CD_EMPRESA', item_f('CD_EMPRESA', tFIS_ECF));
    putitem_o(tFIS_ECFADIC, 'NR_ECF', item_f('NR_ECF', tFIS_ECF));
    retrieve_e(tFIS_ECFADIC);
    if (xStatus >= 0) then begin
      if (item_f('NR_LINHACORTE', tFIS_ECFADIC) > 0) then begin
        vNrLinhasCorte := item_f('NR_LINHACORTE', tFIS_ECFADIC);
      end;
    end;
  end;
  if (itemXml('IN_FORMATARTEXTO', pParams) = True) then begin
    vDsCupom := '';
    vDsArquivo := vDsTexto;
    length vDsArquivo;

    while(gresult > 0) do begin
      scan vDsArquivo, '';
      if (gresult > 0) then begin
        vDsLinha := vDsArquivo[1, gresult - 1];
        vDsArquivo := vDsArquivo[gresult + 1];
      end else begin
        vDsLinha := vDsArquivo;
        vDsArquivo := '';
      end;

      scan vDsLinha, '[BARRA]';
      if (gresult > 0) then begin
        vTamanho := glength(vDsLinha);
        vDsCupom := '' + vDsCupom + '135' + vDsLinha[ + '8, vTamanho]';
      end else begin
        scan vDsLinha, '[CORTE]';
        if (gresult > 0) then begin
          vContador := 0;
          while (vContador <= vNrLinhasCorte) do begin
            vDsCupom := '' + vDsCupom + '025';
            vContador := vContador + 1;
          end;
          vDsCupom := '' + vDsCupom + '131';
          vDsCupom := '' + vDsCupom + '025';
        end else begin
          vDsCupom := '' + vDsCupom + '025' + vDsLinha' + ';
        end;
      end;

      length vDsArquivo;
    end;

    vDsTexto := vDsCupom;

    if (itemXml('IN_FORMATARTEXTO', pParams) = True) then begin
      vDsTexto := '' + vDsTexto + '026';
    end;
  end;
  if (itemXml('IN_LOG_TEMPO_VendA', PARAM_GLB) = 1) then begin
    gHrFim := gclock;
    putmess 'ECFSVCO011: imprimirRelatorioGerencial - Inicio filedump imprimirRelatorioGerencial: ' + gHrFim' + ';
  end;

  filedump '' + vDsTexto', + ' '' + vDsPathECF + '.TMP';
  if (xStatus < 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Falha na gravação de arquivos na máquina check in!', cDS_METHOD);
    return(-1); exit;
  end;

  voParams := activateCmp('vbfileman', 'movearquivo', viParams); (*vEOF,'' + vDsPathECF + '.TMP','' + vDsPathECF + '.TXT' *)
  if (xStatus < 0) then begin
    Result := voParams;
    return(-1); exit;
  end;
  if (itemXml('IN_LOG_TEMPO_VendA', PARAM_GLB) = 1) then begin
    gHrFim := gclock;
    putmess 'ECFSVCO011: imprimirRelatorioGerencial - Fim filedump imprimirRelatorioGerencial: ' + gHrFim' + ';
  end;
  if (itemXml('IN_LOG_TEMPO_VendA', PARAM_GLB) = 1) then begin
    gHrFim := gclock;
    putmess 'ECFSVCO011: imprimirRelatorioGerencial - Aguardando RETORNOECF.TXT imprimirRelatorioGerencial: ' + gHrFim' + ';
  end;

  vDsConteudo := '';
  vQtTentativa := 0;
  repeat

    fileload '' + vDsPathRETORNOECF + '.TXT', vDsConteudo;
    if (xStatus < 0) then begin
      Result := voParams;
      return(-1); exit;
    end;
        if (xStatus < 0) then begin
          Result := voParams;
          return(-1); exit;
        end;
        return(-1); exit;
      end;
    end;

  until (vDsConteudo <> '');

  length vDsConteudo;
  Status := vDsConteudo[1, 4];
  if (Status = -1) then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', '' + vDsConteudo[ + '5, gresult]', cDS_METHOD);
    voParams := activateCmp('vbfileman', 'apagaarquivo', viParams); (*'' + vDsPathRETORNOECF + '.TXT' *)
    if (xStatus < 0) then begin
      Result := voParams;
      return(-1); exit;
    end;

    return(-1); exit;
  end else begin
    voParams := setDisplay(viParams); (* '' + vDsConteudo[ + '5, gresult]', '', '' *)
    if (xStatus < 0) then begin
      Result := voParams;
      return(-1); exit;
    end;
  end;
  if (itemXml('IN_LOG_TEMPO_VendA', PARAM_GLB) = 1) then begin
    gHrFim := gclock;
    putmess 'ECFSVCO011: imprimirRelatorioGerencial - Fim RETORNOECF.TXT imprimirRelatorioGerencial: ' + gHrFim' + ';
  end;

  voParams := activateCmp('vbfileman', 'apagaarquivo', viParams); (*'' + vDsPathRETORNOECF + '.TXT' *)
  if (xStatus < 0) then begin
    Result := voParams;
    return(-1); exit;
  end;
  if (itemXml('IN_LOG_TEMPO_VendA', PARAM_GLB) = 1) then begin
    gHrFim := gclock;
    putmess 'ECFSVCO011: imprimirRelatorioGerencial - Fim imprimirRelatorioGerencial: ' + gHrFim' + ';
  end;

  return(0); exit;
end;

//-----------------------------------------------------------------------
function T_ECFSVCO011.fechaRelatorioGerencial(pParams : String) : String;
//-----------------------------------------------------------------------
const
  cDS_METHOD = 'ADICIONAL=Operação: T_ECFSVCO011.fechaRelatorioGerencial()';
var
  vEOF, vDsPath, vDsConteudo, vDsCupom : String;
  vQtTentativa, Status : Real;
begin
  if (itemXml('IN_LOG_TEMPO_VendA', PARAM_GLB) = 1) then begin
    gHrFim := gclock;
    putmess 'ECFSVCO011: fechaRelatorioGerencial - Inicio fechaRelatorioGerencial: ' + gHrFim' + ';
  end;

  vDsPath := itemXml('DS_UNIDTERMINAL', PARAM_GLB);
  vDsPath := '' + vDsPath:\ECF\' + ';
  xStatus := 0;

  if (itemXml('IN_LOG_TEMPO_VendA', PARAM_GLB) = 1) then begin
    gHrFim := gclock;
    putmess 'ECFSVCO011: fechaRelatorioGerencial - Inicio filedump fechaRelatorioGerencial: ' + gHrFim' + ';
  end;

  filedump '026', '' + vDsPathECF + '.TMP';
  if (xStatus < 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Falha na gravação de arquivos na máquina check in!', cDS_METHOD);
    return(-1); exit;
  end;

  voParams := activateCmp('vbfileman', 'movearquivo', viParams); (*vEOF,'' + vDsPathECF + '.TMP','' + vDsPathECF + '.TXT' *)
  if (xStatus < 0) then begin
    Result := voParams;
    return(-1); exit;
  end;
  if (itemXml('IN_LOG_TEMPO_VendA', PARAM_GLB) = 1) then begin
    gHrFim := gclock;
    putmess 'ECFSVCO011: fechaRelatorioGerencial - Fim filedump fechaRelatorioGerencial: ' + gHrFim' + ';
  end;
  if (itemXml('IN_LOG_TEMPO_VendA', PARAM_GLB) = 1) then begin
    gHrFim := gclock;
    putmess 'ECFSVCO011: fechaRelatorioGerencial - Aguardando RETORNOECF.TXT fechaRelatorioGerencial: ' + gHrFim' + ';
  end;

  vDsConteudo := '';
  vQtTentativa := 0;
  repeat

    fileload '' + vDsPathRETORNOECF + '.TXT', vDsConteudo;
    if (xStatus < 0) then begin
      Result := voParams;
      return(-1); exit;
    end;
        if (xStatus < 0) then begin
          Result := voParams;
          return(-1); exit;
        end;
        return(-1); exit;
      end;
    end;

  until (vDsConteudo <> '');

  length vDsConteudo;
  Status := vDsConteudo[1, 4];
  if (Status = -1) then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', '' + vDsConteudo[ + '5, gresult]', cDS_METHOD);
    voParams := activateCmp('vbfileman', 'apagaarquivo', viParams); (*'' + vDsPathRETORNOECF + '.TXT' *)
    if (xStatus < 0) then begin
      Result := voParams;
      return(-1); exit;
    end;

    return(-1); exit;
  end else begin
    voParams := setDisplay(viParams); (* '' + vDsConteudo[ + '5, gresult]', '', '' *)
    if (xStatus < 0) then begin
      Result := voParams;
      return(-1); exit;
    end;
  end;
  if (itemXml('IN_LOG_TEMPO_VendA', PARAM_GLB) = 1) then begin
    gHrFim := gclock;
    putmess 'ECFSVCO011: fechaRelatorioGerencial - Fim RETORNOECF.TXT fechaRelatorioGerencial: ' + gHrFim' + ';
  end;

  voParams := activateCmp('vbfileman', 'apagaarquivo', viParams); (*'' + vDsPathRETORNOECF + '.TXT' *)
  if (xStatus < 0) then begin
    Result := voParams;
    return(-1); exit;
  end;
  if (itemXml('IN_LOG_TEMPO_VendA', PARAM_GLB) = 1) then begin
    gHrFim := gclock;
    putmess 'ECFSVCO011: fechaRelatorioGerencial - Fim fechaRelatorioGerencial: ' + gHrFim' + ';
  end;

  return(0); exit;
end;

//-----------------------------------------------------------
function T_ECFSVCO011.cancelaItem(pParams : String) : String;
//-----------------------------------------------------------
const
  cDS_METHOD = 'ADICIONAL=Operação: T_ECFSVCO011.cancelaItem()';
var
  vEOF, vDsPath, vDsConteudo : String;
  vQtTentativa, Status : Real;
begin
  gVl03Dig := itemXmlF('NR_ITEM', pParams);
  vDsPath := itemXml('DS_UNIDTERMINAL', PARAM_GLB);
  vDsPath := '' + vDsPath:\ECF\' + ';
  xStatus := 0;

  filedump '007' + FloatToStr(gVl) + '03Dig', '' + vDsPathECF + '.TMP';
  if (xStatus < 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Falha na gravação de arquivos na máquina check in!', cDS_METHOD);
    return(-1); exit;
  end;

  voParams := activateCmp('vbfileman', 'movearquivo', viParams); (*vEOF,'' + vDsPathECF + '.TMP','' + vDsPathECF + '.TXT' *)
  if (xStatus < 0) then begin
    Result := voParams;
    return(-1); exit;
  end;

  vDsConteudo := '';
  vQtTentativa := 0;
  repeat

    fileload '' + vDsPathRETORNOECF + '.TXT', vDsConteudo;
    if (xStatus < 0) then begin
      Result := voParams;
      return(-1); exit;
    end;
        if (xStatus < 0) then begin
          Result := voParams;
          return(-1); exit;
        end;
        return(-1); exit;
      end;
    end;

  until (vDsConteudo <> '');

  length vDsConteudo;
  Status := vDsConteudo[1, 4];
  if (Status = -1) then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', '' + vDsConteudo[ + '5, gresult]', cDS_METHOD);
    voParams := activateCmp('vbfileman', 'apagaarquivo', viParams); (*'' + vDsPathRETORNOECF + '.TXT' *)
    if (xStatus < 0) then begin
      Result := voParams;
      return(-1); exit;
    end;

    return(-1); exit;
  end else begin
    voParams := setDisplay(viParams); (* '' + vDsConteudo[ + '5, gresult]', '', '' *)
    if (xStatus < 0) then begin
      Result := voParams;
      return(-1); exit;
    end;
  end;

  voParams := activateCmp('vbfileman', 'apagaarquivo', viParams); (*'' + vDsPathRETORNOECF + '.TXT' *)
  if (xStatus < 0) then begin
    Result := voParams;
    return(-1); exit;
  end;

  return(0); exit;
end;

//----------------------------------------------------------
function T_ECFSVCO011.abreGaveta(pParams : String) : String;
//----------------------------------------------------------
const
  cDS_METHOD = 'ADICIONAL=Operação: T_ECFSVCO011.abreGaveta()';
var
  vEOF, vDsPath, vDsConteudo : String;
  vQtTentativa, Status : Real;
begin
  vDsPath := itemXml('DS_UNIDTERMINAL', PARAM_GLB);
  vDsPath := '' + vDsPath:\ECF\' + ';
  xStatus := 0;

  if (itemXml('IN_LOG_TEMPO_VendA', PARAM_GLB) = 1) then begin
    gHrFim := gclock;
    putmess 'ECFSVCO011: abreGaveta- Inicio abreGaveta: ' + gHrFim' + ';
  end;

  filedump '031', '' + vDsPathECF + '.TMP';
  if (xStatus < 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Falha na gravação de arquivos na máquina check in!', cDS_METHOD);
    return(-1); exit;
  end;

  voParams := activateCmp('vbfileman', 'movearquivo', viParams); (*vEOF,'' + vDsPathECF + '.TMP','' + vDsPathECF + '.TXT' *)
  if (xStatus < 0) then begin
    Result := voParams;
    return(-1); exit;
  end;

  vDsConteudo := '';
  vQtTentativa := 0;
  repeat

    fileload '' + vDsPathRETORNOECF + '.TXT', vDsConteudo;
    if (xStatus < 0) then begin
      Result := voParams;
      return(-1); exit;
    end;
        if (xStatus < 0) then begin
          Result := voParams;
          return(-1); exit;
        end;
        return(-1); exit;
      end;
    end;

  until (vDsConteudo <> '');

  length vDsConteudo;
  Status := vDsConteudo[1, 4];
  if (Status = -1) then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', '' + vDsConteudo[ + '5, gresult]', cDS_METHOD);
    voParams := activateCmp('vbfileman', 'apagaarquivo', viParams); (*'' + vDsPathRETORNOECF + '.TXT' *)
    if (xStatus < 0) then begin
      Result := voParams;
      return(-1); exit;
    end;

    return(-1); exit;
  end else begin
    voParams := setDisplay(viParams); (* '' + vDsConteudo[ + '5, gresult]', '', '' *)
    if (xStatus < 0) then begin
      Result := voParams;
      return(-1); exit;
    end;
  end;

  voParams := activateCmp('vbfileman', 'apagaarquivo', viParams); (*'' + vDsPathRETORNOECF + '.TXT' *)
  if (xStatus < 0) then begin
    Result := voParams;
    return(-1); exit;
  end;
  if (itemXml('IN_LOG_TEMPO_VendA', PARAM_GLB) = 1) then begin
    gHrFim := gclock;
    putmess 'ECFSVCO011: abreGaveta- Fim abreGaveta: ' + gHrFim' + ';
  end;

  return(0); exit;
end;

//-------------------------------------------------------------
function T_ECFSVCO011.imprimeCheque(pParams : String) : String;
//-------------------------------------------------------------
const
  cDS_METHOD = 'ADICIONAL=Operação: T_ECFSVCO011.imprimeCheque()';
var
  vEOF, vDsPath, vDsConteudo, Status, vDsNominal, vDsCidade, vTpCheque, vDsData, vDsAux : String;
  vQtTentativa, vCdEmpresa, vNrSeqend, vNrSeqAuto : Real;
  vVlCheque, vNrSeqCheque, vNrBanco : Real;
  vDtEmissao, vDtAutorizacao, vDtVencimento : TDate;
begin
  vTpCheque := itemXmlF('TP_CHEQUE', pParams);
  vCdEmpresa := itemXmlF('CD_EMPRESA', PARAM_GLB);

  gVl03Dig := itemXmlF('NR_BANCO', pParams);
  gVl14DIG := itemXmlF('VL_CHEQUE', pParams);
  vDsNominal := itemXml('DS_NOMINAL', pParams);

  clear_e(tV_PES_ENDEREC);
  clear_e(tGER_EMPRESA);
  putitem_e(tGER_EMPRESA, 'CD_EMPRESA', vCdEmpresa);
  retrieve_e(tGER_EMPRESA);
  if (xStatus >= 0) then begin
    clear_e(tPES_PESSOA);
    putitem_e(tPES_PESSOA, 'CD_PESSOA', item_f('CD_PESSOA', tGER_EMPRESA));
    retrieve_e(tPES_PESSOA);

    vNrSeqend := 1;

    putitemXml(pParams, 'CD_PESSOA', item_f('CD_PESSOA', tGER_EMPRESA));
    voParams := activateCmp('PESSVCO005', 'buscaenderecoFaturamento', viParams); (*,pParams,Result,, *)
    if (xStatus < 0) then begin
      Result := voParams;
      return(-1); exit;
    end;

    putitem_e(tV_PES_ENDEREC, 'CD_PESSOA', item_f('CD_PESSOA', tGER_EMPRESA));
    putitem_e(tV_PES_ENDEREC, 'NR_SEQUENCIA', vNrSeqend);
    retrieve_e(tV_PES_ENDEREC);
  end;

  vDsCidade := item_a('NM_MUNICIPIO', tV_PES_ENDEREC);
  voParams := espacoDireita(viParams); (* vDsCidade, 20, vDsCidade *)
  if (xStatus < 0) then begin
    Result := voParams;
    return(-1); exit;
  end;
  if (vTpCheque = 'CP') then begin
    vDtAutorizacao := itemXml('DT_AUTORIZACAO', pParams);
    vNrSeqAuto := itemXmlF('NR_SEQAUTO', pParams);
    vNrSeqCheque := itemXmlF('NR_SEQCHEQUE', pParams);

    clear_e(tFCC_AUTORIZAC);
    putitem_e(tFCC_AUTORIZAC, 'DT_AUTORIZACAO', vDtAutorizacao);
    putitem_e(tFCC_AUTORIZAC, 'NR_SEQAUTO', vNrSeqAuto);
    retrieve_e(tFCC_AUTORIZAC);
    if (xStatus < 0) then begin
      Result := SetStatus(STS_ERROR, 'GEN0001', 'Cheque não autorizado!', cDS_METHOD);
      return(-1); exit;
    end;

    clear_e(tFCC_AUTOCHEQ);
    putitem_e(tFCC_AUTOCHEQ, 'DT_AUTORIZACAO', vDtAutorizacao);
    putitem_e(tFCC_AUTOCHEQ, 'NR_SEQAUTO', vNrSeqAuto);
    putitem_e(tFCC_AUTOCHEQ, 'NR_SEQCHEQUE', vNrSeqCheque);
    retrieve_e(tFCC_AUTOCHEQ);
    if (xStatus < 0) then begin
      Result := SetStatus(STS_ERROR, 'GEN0001', 'Cheque não autorizado!', cDS_METHOD);
      return(-1); exit;
    end;
    vDtEmissao := item_a('DT_EMISSAO', tFCC_AUTOCHEQ);

    vDtVencimento := item_a('DT_VENCIMENTO', tFCC_AUTOCHEQ);
    vNrBanco := item_f('NR_BANCO', tFCC_CTAPES);
    vVlCheque := item_f('VL_CHEQUE', tFCC_AUTOCHEQ);
  end else begin
    vNrBanco := itemXmlF('NR_BANCO', pParams);
    vDsNominal := itemXml('DS_NOMINAL', pParams);
    vDtVencimento := itemXml('DT_VENCIMENTO', pParams);
    vVlCheque := itemXmlF('VL_CHEQUE', pParams);

    if (vVlCheque = 0) then begin
      Result := SetStatus(STS_ERROR, 'GEN0001', 'Valor do cheque não informado!', cDS_METHOD);
      return(-1); exit;
    end;
  end;

  voParams := espacoDireita(viParams); (* vDsNominal, 49, vDsNominal *)
  if (xStatus < 0) then begin
    Result := voParams;
    return(-1); exit;
  end;
  if (vDtEmissao = '') then begin
    vDtEmissao := itemXml('DT_SISTEMA', PARAM_GLB);
  end;

  voParams := preencheZero(viParams); (* vDtEmissao[D], 2, vDsAux *)
  if (xStatus < 0) then begin
    Result := voParams;
    return(-1); exit;
  end;
  vDsData := vDsAux;

  voParams := preencheZero(viParams); (* vDtEmissao[M], 2, vDsAux *)
  if (xStatus < 0) then begin
    Result := voParams;
    return(-1); exit;
  end;

  vDsData := '' + vDsData + '/' + vDsAux' + ';
  vDsData := '' + vDsData + '/' + vDtEmissao[Y]' + ';

  vDsPath := itemXml('DS_UNIDTERMINAL', PARAM_GLB);
  vDsPath := '' + vDsPath:\ECF\' + ';
  xStatus := 0;

  filedump '041' + FloatToStr(gVl) + '03Dig' + FloatToStr(gVl) + '14DIG' + vDsNominal' + vDsCidade' + vDsData', + ' + ' + ' '' + vDsPathECF + '.TMP';
  if (xStatus < 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Falha na gravação de arquivos na máquina check in!', cDS_METHOD);
    return(-1); exit;
  end;

  voParams := activateCmp('vbfileman', 'movearquivo', viParams); (*vEOF,'' + vDsPathECF + '.TMP','' + vDsPathECF + '.TXT' *)
  if (xStatus < 0) then begin
    Result := voParams;
    return(-1); exit;
  end;

  vDsConteudo := '';
  vQtTentativa := 0;
  repeat

    fileload '' + vDsPathRETORNOECF + '.TXT', vDsConteudo;
    if (xStatus < 0) then begin
      Result := voParams;
      return(-1); exit;
    end;
        if (xStatus < 0) then begin
          Result := voParams;
          return(-1); exit;
        end;
        return(-1); exit;
      end;
    end;

  until (vDsConteudo <> '');

  length vDsConteudo;
  Status := vDsConteudo[1, 4];
  if (Status = -1) then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', '' + vDsConteudo[ + '5, gresult]', cDS_METHOD);
    voParams := activateCmp('vbfileman', 'apagaarquivo', viParams); (*'' + vDsPathRETORNOECF + '.TXT' *)
    if (xStatus < 0) then begin
      Result := voParams;
      return(-1); exit;
    end;

    return(-1); exit;
  end else begin
    voParams := setDisplay(viParams); (* '' + vDsConteudo[ + '5, gresult]', '', '' *)
    if (xStatus < 0) then begin
      Result := voParams;
      return(-1); exit;
    end;
  end;

  voParams := activateCmp('vbfileman', 'apagaarquivo', viParams); (*'' + vDsPathRETORNOECF + '.TXT' *)
  if (xStatus < 0) then begin
    Result := voParams;
    return(-1); exit;
  end;

  return(0); exit;
end;

//----------------------------------------------------------------------
function T_ECFSVCO011.imprimeTextoViaMonitor(pParams : String) : String;
//----------------------------------------------------------------------
const
  cDS_METHOD = 'ADICIONAL=Operação: T_ECFSVCO011.imprimeTextoViaMonitor()';
var
  vEOF, vDsPath, vDsConteudo : String;
  vQtTentativa, Status : Real;
begin
  vDsPath := itemXml('DS_UNIDTERMINAL', PARAM_GLB);
  vDsPath := '' + vDsPath:\ECF\' + ';
  xStatus := 0;

  vDsConteudo := itemXml('DS_TEXTO', pParams);

  filedump '' + vDsConteudo', + ' '' + vDsPathTEF + '.TMP';
  if (xStatus < 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Falha na gravação de arquivos na máquina check in!', cDS_METHOD);
    return(-1); exit;
  end;

  voParams := activateCmp('vbfileman', 'movearquivo', viParams); (*vEOF,'' + vDsPathTEF + '.TMP','' + vDsPathTEF + '.TXT' *)
  if (xStatus < 0) then begin
    Result := voParams;
    return(-1); exit;
  end;

  vDsConteudo := '';
  vQtTentativa := 0;
  repeat

    fileload '' + vDsPathRETORNOECF + '.TXT', vDsConteudo;
    if (xStatus < 0) then begin
      Result := voParams;
      return(-1); exit;
    end;
        if (xStatus < 0) then begin
          Result := voParams;
          return(-1); exit;
        end;
        return(-1); exit;
      end;
    end;

  until (vDsConteudo <> '');

  length vDsConteudo;
  Status := vDsConteudo[1, 4];
  if (Status = -1) then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', '' + vDsConteudo[ + '5, gresult]', cDS_METHOD);
    voParams := activateCmp('vbfileman', 'apagaarquivo', viParams); (*'' + vDsPathRETORNOECF + '.TXT' *)
    if (xStatus < 0) then begin
      Result := voParams;
      return(-1); exit;
    end;

    return(-1); exit;
  end else begin
    voParams := setDisplay(viParams); (* '' + vDsConteudo[ + '5, gresult]', '', '' *)
    if (xStatus < 0) then begin
      Result := voParams;
      return(-1); exit;
    end;
  end;

  voParams := activateCmp('vbfileman', 'apagaarquivo', viParams); (*'' + vDsPathRETORNOECF + '.TXT' *)
  if (xStatus < 0) then begin
    Result := voParams;
    return(-1); exit;
  end;

  return(0); exit;
end;

//------------------------------------------------------------
function T_ECFSVCO011.trataFocoTEF(pParams : String) : String;
//------------------------------------------------------------
const
  cDS_METHOD = 'ADICIONAL=Operação: T_ECFSVCO011.trataFocoTEF()';
var
  vEOF, vDsPath, vDsConteudo, vDsQuebra1, vDsQuebra2 : String;
  vQtTentativa, Status, vMod, vNrQuebra1, vNrQuebra2 : Real;
  vInMinimiza : Boolean;
begin
  vDsPath := itemXml('DS_UNIDTERMINAL', PARAM_GLB);
  vDsPath := '' + vDsPath:\ECF\' + ';
  xStatus := 0;

  vInMinimiza := itemXmlB('IN_MINIMIZA', pParams);
  if (vInMinimiza = '') then begin
    vInMinimiza := False;
  end;
  if (vInMinimiza = True) then begin
    filedump '095' + gappltitle', + ' '' + vDsPathECF + '.TMP';
  end else begin

    filedump '096' + gappltitle', + ' '' + vDsPathECF + '.TMP';
  end;
  if (xStatus < 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Falha na gravação de arquivos na máquina check in!', cDS_METHOD);
    return(-1); exit;
  end;

  voParams := activateCmp('vbfileman', 'movearquivo', viParams); (*vEOF,'' + vDsPathECF + '.TMP','' + vDsPathECF + '.TXT' *)
  if (xStatus < 0) then begin
    Result := voParams;
    return(-1); exit;
  end;

  vDsConteudo := '';
  vQtTentativa := 0;
  repeat

    fileload '' + vDsPathRETORNOECF + '.TXT', vDsConteudo;
    if (xStatus < 0) then begin
      Result := voParams;
      return(-1); exit;
    end;
        if (xStatus < 0) then begin
          Result := voParams;
          return(-1); exit;
        end;
        return(-1); exit;
      end;
    end;

  until (vDsConteudo <> '');

  length vDsConteudo;
  Status := vDsConteudo[1, 4];
  if (Status = -1) then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', '' + vDsConteudo[ + '5, gresult]', cDS_METHOD);
    voParams := activateCmp('vbfileman', 'apagaarquivo', viParams); (*'' + vDsPathRETORNOECF + '.TXT' *)
    if (xStatus < 0) then begin
      Result := voParams;
      return(-1); exit;
    end;

    return(-1); exit;
  end else begin
    voParams := setDisplay(viParams); (* '' + vDsConteudo[ + '5, gresult]', '', '' *)
    if (xStatus < 0) then begin
      Result := voParams;
      return(-1); exit;
    end;
  end;

  voParams := activateCmp('vbfileman', 'apagaarquivo', viParams); (*'' + vDsPathRETORNOECF + '.TXT' *)
  if (xStatus < 0) then begin
    Result := voParams;
    return(-1); exit;
  end;

  return(0); exit;
end;

//-----------------------------------------------------------
function T_ECFSVCO011.convnumeric(pParams : String) : String;
//-----------------------------------------------------------
const
  cDS_METHOD = 'ADICIONAL=Operação: T_ECFSVCO011.convnumeric()';
var
  (* string numericIn : IN / numeric Tamanho : IN / string numericOut : OUT *)
  vChar, v, vAux, v1 : String;
  vAux, vPos, vCont : Real;
begin
  vCont := 0;
  vstringAux := '';

  repeat
    vCont := vCont + 1;
    vChar := numericIn[vCont:1];
    selectcase vChar;
      case ' ';
        vChar := '';
      case '.';
        vChar := '';
      case ', ';
        vChar := '';
      case '+';
        vChar := '';
      case '-';
        vChar := '';
      case '\';
        vChar := '';
      case '/';
        vChar := '';
      case 'or';
        vChar := '';
      case '*';
        vChar := '';
        case '(';
        vChar := '';
      case ')';
        vChar := '';
      case '_';
        vChar := '';
    endselectcase;

    vstring := '' + vstring' + vChar' + ' + ';
  until (vCont > Tamanho);

  v1 := '0';
  vAux := 1;
  length vstring;
  vPos := Tamanho - gresult;
  if (vPos < 0) then begin
    vPos := 1;
  end;

  vCont := 0;

  repeat
    if (vAux > vPos) then begin
      vCont := vCont + 1;
      vChar := vstring[vCont:1];
      vstringAux := '' + vstringAux' + vChar' + ' + ';
    end else begin
      vstringAux := '' + vstringAux' + v + ' + '1';
    end;
    vAux := vAux + 1;

  until (vAux > Tamanho);
  numericOut := vstringAux;

  return(0); exit;
end;

//--------------------------------------------------------
function T_ECFSVCO011.editarNr(pParams : String) : String;
//--------------------------------------------------------
const
  cDS_METHOD = 'ADICIONAL=Operação: T_ECFSVCO011.editarNr()';
var
  (* numeric TamInt :IN / numeric TamDec :IN / string ValorIN :IN / string ValorOUT :OUT *)
  vTam, vInteiro, vDecimal, vCont, v1 : Real;
  vDec, vInt, vAux : String;
begin
  v1 := '0';
  vAux := ValorIn;
  vInteiro := int(vAux);
  vDecimal := vAux[fraction];

  length vInteiro;
  vTam := gresult;
  if (vTam > TamInt) then begin
    vTam := vTam - TamInt;
    vInteiro := vInteiro[vTam:TamInt];
    vInt := vInteiro;
  end else begin
    vInt := vInteiro;
  end;
  vDec := vDecimal;
  if (vDec  = 0) then begin
    vDec := '0';
    vCont := 1;
    repeat
      vDec := '' + vDec' + v + ' + '1';
      vCont := vCont + 1;
    until (vCont >= TamDec);
  end else begin
    vDec := vDec[3:TamDec];
    length vDec;
    vCont := gresult;
    if (vCont < TamDec) then begin
      repeat
        vDec := '' + vDec' + v + ' + '1';
        vCont := vCont + 1;
      until (vCont >= TamDec);
    end else if (vCont > TamDec) then begin
        message/error 'Erro na Decimal';
    end;
  end;
  ValorOUT := '' + vInt' + vDec' + ' + ';

  return(0); exit;
end;

//---------------------------------------------------------------
function T_ECFSVCO011.convValorstring(pParams : String) : String;
//---------------------------------------------------------------
const
  cDS_METHOD = 'ADICIONAL=Operação: T_ECFSVCO011.convValorstring()';
var
  (* string piCampo :IN / numeric piQtPosicoes :IN / string poCampo :OUT *)
  vAux : String;
begin
  if (piQtPosicoes = 14) then begin
    vstringAux := piCampo[2:11];
    poCampo := vstringAux;
    vstringAux := '.';
    poCampo := '' + poCampo' + vstringAux' + ' + ';
    vstringAux := piCampo[13:2];
    poCampo := '' + poCampo' + vstringAux' + ' + ';
  end else if (piQtPosicoes = 5) then begin
    vstringAux := piCampo[2:2];
    poCampo := vstringAux;
    vstringAux := '.';
    poCampo := '' + poCampo' + vstringAux' + ' + ';
    vstringAux := piCampo[4:2];
    poCampo := '' + poCampo' + vstringAux' + ' + ';
  end else if (piQtPosicoes = 3) then begin
    vstringAux := piCampo[2:10];
    poCampo := vstringAux;
    vstringAux := '.';
    poCampo := '' + poCampo' + vstringAux' + ' + ';
    vstringAux := piCampo[12:3];
    poCampo := '' + poCampo' + vstringAux' + ' + ';
  end;

  return(0); exit;
end;

//-------------------------------------------------------------
function T_ECFSVCO011.progHoraVerao(pParams : String) : String;
//-------------------------------------------------------------
const
  cDS_METHOD = 'ADICIONAL=Operação: T_ECFSVCO011.progHoraVerao()';
var
  vEOF, vDsPath, vDsConteudo : String;
  vQtTentativa, Status : Real;
begin
  vDsPath := itemXml('DS_UNIDTERMINAL', PARAM_GLB);
  vDsPath := '' + vDsPath:\ECF\' + ';
  xStatus := 0;

  filedump '060', '' + vDsPathECF + '.TMP';
  if (xStatus < 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Falha na gravação de arquivos na máquina check in!', cDS_METHOD);
    return(-1); exit;
  end;

  voParams := activateCmp('vbfileman', 'movearquivo', viParams); (*vEOF,'' + vDsPathECF + '.TMP','' + vDsPathECF + '.TXT' *)
  if (xStatus < 0) then begin
    Result := voParams;
    return(-1); exit;
  end;

  vDsConteudo := '';
  vQtTentativa := 0;
  repeat

    fileload '' + vDsPathRETORNOECF + '.TXT', vDsConteudo;
    if (xStatus < 0) then begin
      Result := voParams;
      return(-1); exit;
    end;
        if (xStatus < 0) then begin
          Result := voParams;
          return(-1); exit;
        end;
        return(-1); exit;
      end;
    end;

  until (vDsConteudo <> '');

  length vDsConteudo;
  Status := vDsConteudo[1, 4];
  if (Status = -1) then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', '' + vDsConteudo[ + '5, gresult]', cDS_METHOD);
    voParams := activateCmp('vbfileman', 'apagaarquivo', viParams); (*'' + vDsPathRETORNOECF + '.TXT' *)
    if (xStatus < 0) then begin
      Result := voParams;
      return(-1); exit;
    end;

    return(-1); exit;
  end else begin
    voParams := setDisplay(viParams); (* '' + vDsConteudo[ + '5, gresult]', '', '' *)
    if (xStatus < 0) then begin
      Result := voParams;
      return(-1); exit;
    end;
  end;

  voParams := activateCmp('vbfileman', 'apagaarquivo', viParams); (*'' + vDsPathRETORNOECF + '.TXT' *)
  if (xStatus < 0) then begin
    Result := voParams;
    return(-1); exit;
  end;

  return(0); exit;
end;

//---------------------------------------------------------------------
function T_ECFSVCO011.imprimeEtiqViaMonitor(pParams : String) : String;
//---------------------------------------------------------------------
const
  cDS_METHOD = 'ADICIONAL=Operação: T_ECFSVCO011.imprimeEtiqViaMonitor()';
var
  vEOF, vDsPath, vDsConteudo, vDsMeio : String;
  vQtTentativa, Status : Real;
begin
  vDsPath := itemXml('DS_UNIDTERMINAL', PARAM_GLB);
  vDsPath := '' + vDsPath:\ECF\' + ';
  xStatus := 0;

  vDsConteudo := itemXml('DS_TEXTO', pParams);
  vDsMeio := itemXml('DS_MEIO', pParams);

  filedump '001' + vDsMeio' + vDsConteudo', + ' + ' '' + vDsPathETIQ + '.TMP';

  if (xStatus < 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Falha na gravação de arquivos na máquina check in!', cDS_METHOD);
    return(-1); exit;
  end;

  voParams := activateCmp('vbfileman', 'movearquivo', viParams); (*vEOF,'' + vDsPathETIQ + '.TMP','' + vDsPathETIQ + '.TXT' *)
  if (xStatus < 0) then begin
    Result := voParams;
    return(-1); exit;
  end;

  vDsConteudo := '';
  vQtTentativa := 0;
  repeat

    fileload '' + vDsPathRETORNOECF + '.TXT', vDsConteudo;
    if (xStatus < 0) then begin
      Result := voParams;
      return(-1); exit;
    end;
        if (xStatus < 0) then begin
          Result := voParams;
          return(-1); exit;
        end;
        return(-1); exit;
      end;
    end;

  until (vDsConteudo <> '');

  length vDsConteudo;
  Status := vDsConteudo[1, 4];
  if (Status = -1) then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', '' + vDsConteudo[ + '5, gresult]', cDS_METHOD);
    voParams := activateCmp('vbfileman', 'apagaarquivo', viParams); (*'' + vDsPathRETORNOECF + '.TXT' *)
    if (xStatus < 0) then begin
      Result := voParams;
      return(-1); exit;
    end;

    return(-1); exit;
  end else begin
    voParams := setDisplay(viParams); (* '' + vDsConteudo[ + '5, gresult]', '', '' *)
    if (xStatus < 0) then begin
      Result := voParams;
      return(-1); exit;
    end;
  end;

  voParams := activateCmp('vbfileman', 'apagaarquivo', viParams); (*'' + vDsPathRETORNOECF + '.TXT' *)
  if (xStatus < 0) then begin
    Result := voParams;
    return(-1); exit;
  end;

  return(0); exit;
end;

//--------------------------------------------------------------------
function T_ECFSVCO011.relatorioSintegraMFD(pParams : String) : String;
//--------------------------------------------------------------------
const
  cDS_METHOD = 'ADICIONAL=Operação: T_ECFSVCO011.relatorioSintegraMFD()';
var
  vDsArquivo, vNrMes, vNrAno, vDsRazaoSocial, vDsendereco, vDsComplemento, vDsBairro, vDsCidade, viParams, voParams : String;
  vDsCEP, vNrTelefone, vDsContato, vNrendereco, vNrFax, vEOF, vDsPath, vDsConteudo, vDsAux, vNrSerie : String;
  vTpRelatorio, vQtTentativa, Status : Real;
  vFlag : Boolean;
begin
  vNrSerie := itemXmlF('CD_SERIEECF', PARAM_GLB);
  if (vNrSerie = '') then begin
    viParams := '';

    putitemXml(viParams, 'NM_FUNCAO', <ECF_NUMERO_SERIE>);
    putitemXml(viParams, 'IN_IMPCUPOMFISCAL', False);
    voParams := leinformacaoImpressora(viParams); (* viParams, voParams, xCdErro, xCtxErro *)
    if (xStatus < 0) then begin
      Result := voParams;
      return(-1); exit;
    end;
    vNrSerie := itemXmlF('NR_SERIE', voParams);
    if (vNrSerie = '') then begin
      Result := SetStatus(STS_ERROR, 'GEN0001', 'Erro ao obter número de série da impressora!', cDS_METHOD);
      return(-1); exit;
    end;
  end;
  vDsPath := itemXml('DS_UNIDTERMINAL', PARAM_GLB);
  vDsPath := '' + vDsPath:\ECF\' + ';
  xStatus := 0;

  vTpRelatorio := itemXmlF('TP_RELATORIO', pParams);
  vDsArquivo := itemXml('DS_ARQUIVO', pParams);
  vNrMes := itemXmlF('NR_MES', pParams);
  vNrAno := itemXmlF('NR_ANO', pParams);
  vDsRazaoSocial := itemXml('DS_RAZAOSOCIAL', pParams);
  vDsendereco := itemXml('DS_endERECO', pParams);
  vNrendereco := itemXmlF('NR_endERECO', pParams);
  vDsComplemento := itemXml('DS_COMPLEMENTO', pParams);
  vDsBairro := itemXml('DS_BAIRRO', pParams);
  vDsCidade := itemXml('DS_CIDADE', pParams);
  vDsCEP := itemXml('DS_CEP', pParams);
  vNrTelefone := itemXmlF('NR_TELEFONE', pParams);
  vNrFax := itemXmlF('NR_FAX', pParams);
  vDsContato := itemXml('DS_CONTATO', pParams);

  voParams := espacoDireita(viParams); (* vDsArquivo, 19, vDsArquivo *)
  if (xStatus < 0) then begin
    Result := voParams;
    return(-1); exit;
  end;

  voParams := preencheZero(viParams); (* vNrMes, 2, vNrMes *)
  if (xStatus < 0) then begin
    Result := voParams;
    return(-1); exit;
  end;

  voParams := espacoDireita(viParams); (* vDsRazaoSocial, 35, vDsRazaoSocial *)
  if (xStatus < 0) then begin
    Result := voParams;
    return(-1); exit;
  end;

  voParams := espacoDireita(viParams); (* vDsendereco, 35, vDsendereco *)
  if (xStatus < 0) then begin
    Result := voParams;
    return(-1); exit;
  end;

  voParams := preencheZero(viParams); (* vNrendereco, 5, vNrendereco *)
  if (xStatus < 0) then begin
    Result := voParams;
    return(-1); exit;
  end;

  voParams := espacoDireita(viParams); (* vDsComplemento, 22, vDsComplemento *)
  if (xStatus < 0) then begin
    Result := voParams;
    return(-1); exit;
  end;

  voParams := espacoDireita(viParams); (* vDsBairro, 15, vDsBairro *)
  if (xStatus < 0) then begin
    Result := voParams;
    return(-1); exit;
  end;

  voParams := espacoDireita(viParams); (* vDsCidade, 30, vDsCidade *)
  if (xStatus < 0) then begin
    Result := voParams;
    return(-1); exit;
  end;

  voParams := espacoDireita(viParams); (* vDsCEP, 8, vDsCEP *)
  if (xStatus < 0) then begin
    Result := voParams;
    return(-1); exit;
  end;

  voParams := espacoDireita(viParams); (* vNrTelefone, 12, vNrTelefone *)
  if (xStatus < 0) then begin
    Result := voParams;
    return(-1); exit;
  end;

  voParams := espacoDireita(viParams); (* vNrFax, 10, vNrFax *)
  if (xStatus < 0) then begin
    Result := voParams;
    return(-1); exit;
  end;

  voParams := espacoDireita(viParams); (* vDsContato, 10, vDsContato *)

  filedump '018' + FloatToStr(vTpRelatorio' + vDsArquivo' + FloatToStr(vNrMes' + FloatToStr(vNrAno' + vDsRazaoSocial' + vDsendereco' + FloatToStr(vNrendereco' + vDsComplemento' + vDsBairro' + vDsCidade' + vDsCEP' + FloatToStr(vNrTelefone' + FloatToStr(vNrFax' + vDsContato',)))))) + ' + ' + ' + ' + ' + ' + ' + ' + ' + ' + ' + ' + ' + ' '' + vDsPathMFD + '.TMP';
  if (xStatus < 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Falha na gravação de arquivos na máquina check in!', cDS_METHOD);
    return(-1); exit;
  end;

  voParams := activateCmp('vbfileman', 'movearquivo', viParams); (*vEOF,'' + vDsPathMFD + '.TMP','' + vDsPathMFD + '.TXT' *)
  if (xStatus < 0) then begin
    Result := voParams;
    return(-1); exit;
  end;

  vDsConteudo := '';
  vQtTentativa := 0;
  voParams := activateCmp('KERNEL32', 'SLEEP', viParams); (*40000 *)
  repeat
    if (vNrSerie[1, 2] = 'EP') then begin
      voParams := activateCmp('vbfileman', 'arqexiste', viParams); (*vFlag,'' + vDsPathRETORNOECF + '.TXT' *)
      if (vFlag = True) then begin
        break;
      end;
    end else if (vNrSerie[1, 2] = 'ZP') then begin
      voParams := activateCmp('vbfileman', 'arqexiste', viParams); (*vFlag,'' + vDsPathSINTEGRA + '.TXT' *)
      if (vFlag = True) then begin
        break;
      end;
    end else if (vNrSerie[1, 2] = 'DR') then begin
      voParams := activateCmp('vbfileman', 'arqexiste', viParams); (*vFlag,'' + vDsPathRETORNOECF + '.TXT' *)
      if (vFlag = True) then begin
        break;
      end;
    end else begin
      voParams := activateCmp('vbfileman', 'arqexiste', viParams); (*vFlag,'' + vDsPathDOWNLOAD + '.MFD' *)
      if (vFlag = False) then begin
        break;
      end;
      voParams := activateCmp('vbfileman', 'arqexiste', viParams); (*vFlag,'' + vDsPathRETORNOECF + '.TXT' *)
      if (vFlag = True) then begin
        voParams := activateCmp('vbfileman', 'arqexiste', viParams); (*vFlag,'' + vDsPathDOWNLOAD + '.MFD' *)
        if (vFlag = True) then begin
          voParams := activateCmp('vbfileman', 'apagaarquivo', viParams); (*'' + vDsPathDOWNLOAD + '.MFD' *)
          if (xStatus < 0) then begin
            Result := voParams;
            return(-1); exit;
          end;
        end;
        break;
      end;
    end;

    vQtTentativa := vQtTentativa + 1;
    if (vQtTentativa > 50000) then begin
      Result := SetStatus(STS_ERROR, 'GEN0001', 'Falha na comunicação tempo de resposta esgotado para máquina check in!', cDS_METHOD);
      voParams := activateCmp('vbfileman', 'apagaarquivo', viParams); (*'' + vDsPathMFD + '.TXT' *)
      if (xStatus < 0) then begin
        Result := voParams;
        return(-1); exit;
      end;
      return(-1); exit;
    end;

  until (vDsConteudo <> '');

  voParams := activateCmp('KERNEL32', 'SLEEP', viParams); (*10000 *)

  length vDsConteudo;
  Status := vDsConteudo[1, 4];
  if (Status = -1) then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', '' + vDsConteudo[ + '5, gresult]', cDS_METHOD);
    voParams := activateCmp('vbfileman', 'apagaarquivo', viParams); (*'' + vDsPathRETORNOECF + '.TXT' *)
    if (xStatus < 0) then begin
      Result := voParams;
      return(-1); exit;
    end;

    return(-1); exit;
  end else begin
    voParams := setDisplay(viParams); (* '' + vDsConteudo[ + '5, gresult]', '', '' *)
    if (xStatus < 0) then begin
      Result := voParams;
      return(-1); exit;
    end;
  end;

  voParams := activateCmp('vbfileman', 'apagaarquivo', viParams); (*'' + vDsPathRETORNOECF + '.TXT' *)
  if (xStatus < 0) then begin
    Result := voParams;
    return(-1); exit;
  end;

  return(0); exit;
end;

//-----------------------------------------------------------
function T_ECFSVCO011.downloadMFD(pParams : String) : String;
//-----------------------------------------------------------
const
  cDS_METHOD = 'ADICIONAL=Operação: T_ECFSVCO011.downloadMFD()';
var
  vDsArquivo, vTpDownload, vDadoINI, vDadoFIM, vNrUsuario, vDsPath, vEOF, vDsConteudo : String;
  vTpFormato, status, vQtTentativa : Real;
  vFlag : Boolean;
begin
  vDsPath := itemXml('DS_UNIDTERMINAL', PARAM_GLB);
  vDsPath := '' + vDsPath:\ECF\' + ';
  xStatus := 0;

  vDsArquivo := itemXml('DS_ARQUIVO', pParams);
  vTpDownload := itemXmlF('TP_DOWNLOAD', pParams);
  vDadoINI := itemXml('DS_DADOINI', pParams);
  vDadoFIM := itemXml('DS_DADOFIM', pParams);
  vNrUsuario := itemXmlF('NR_USUARIO', pParams);
  vTpFormato := itemXmlF('TP_FORMATO', pParams);

  voParams := espacoDireita(viParams); (* vDsArquivo, 19, vDsArquivo *)
  if (xStatus < 0) then begin
    Result := voParams;
    return(-1); exit;
  end;

  voParams := espacoDireita(viParams); (* vTpDownload, 1, vTpDownload *)
  if (xStatus < 0) then begin
    Result := voParams;
    return(-1); exit;
  end;

  voParams := espacoDireita(viParams); (* vDadoINI, 6, vDadoINI *)
  if (xStatus < 0) then begin
    Result := voParams;
    return(-1); exit;
  end;

  voParams := espacoDireita(viParams); (* vDadoFIM, 6, vDadoFIM *)
  if (xStatus < 0) then begin
    Result := voParams;
    return(-1); exit;
  end;

  voParams := espacoDireita(viParams); (* vNrUsuario, 1, vNrUsuario *)
  if (xStatus < 0) then begin
    Result := voParams;
    return(-1); exit;
  end;

  voParams := activateCmp('vbfileman', 'arqexiste', viParams); (*vFlag,'' + vDsPathRETORNOECF + '.TXT' *)
  if (vFlag = True) then begin
    voParams := activateCmp('vbfileman', 'apagaarquivo', viParams); (*'' + vDsPathRETORNOECF + '.TXT' *)
  end;

  filedump '019' + vDsArquivo' + FloatToStr(vTpDownload' + vDadoINI' + vDadoFIM' + FloatToStr(vNrUsuario',)) + ' + ' + ' + ' + ' '' + vDsPathMFD + '.TMP';
  if (xStatus < 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Falha na gravação de arquivos na máquina check in!', cDS_METHOD);
    return(-1); exit;
  end;

  voParams := activateCmp('vbfileman', 'movearquivo', viParams); (*vEOF,'' + vDsPathMFD + '.TMP','' + vDsPathMFD + '.TXT' *)
  if (xStatus < 0) then begin
    Result := voParams;
    return(-1); exit;
  end;

  voParams := activateCmp('KERNEL32', 'SLEEP', viParams); (*40000 *)
  vDsConteudo := '';
  vQtTentativa := 0;
  repeat
    voParams := activateCmp('KERNEL32', 'SLEEP', viParams); (*1000 *)
    voParams := activateCmp('vbfileman', 'arqexiste', viParams); (*vFlag,'' + vDsPathDOWNLOAD + '.MFD' *)
    if (vFlag = False) then begin
      break;
    end;

    voParams := activateCmp('vbfileman', 'arqexiste', viParams); (*vFlag,'' + vDsPathRETORNOECF + '.TXT' *)
    if (vFlag = True) then begin
      break;
    end;

    vQtTentativa := vQtTentativa + 1;
    if (vQtTentativa > 50000) then begin
      Result := SetStatus(STS_ERROR, 'GEN0001', 'Falha na comunicação tempo de resposta esgotado para máquina check in!', cDS_METHOD);
      voParams := activateCmp('vbfileman', 'apagaarquivo', viParams); (*'' + vDsPathMFD + '.TXT' *)
      if (xStatus < 0) then begin
        Result := voParams;
        return(-1); exit;
      end;
      return(-1); exit;
    end;
  until (vDsConteudo <> '');

  voParams := activateCmp('vbfileman', 'arqexiste', viParams); (*vFlag,'' + vDsPathDOWNLOAD + '.MFD' *)
  if (vFlag = True) then begin
    if (vTpFormato <> 3) then begin
      voParams := setDisplay(viParams); (* 'Gerando arquivo a partir do download...', '', '' *)
      if (xStatus < 0) then begin
        Result := voParams;
        return(-1); exit;
      end;
      length vDsArquivo;
      putitemXml(pParams, 'DS_ARQUIVOMFD', vDsArquivo);
      vDsArquivo := vDsArquivo[1:gresult - 4];
      if (vTpFormato = 0) then begin
        vDsArquivo := '' + vDsArquivo + '.TXT';
      end else if (vTpFormato = 1) then begin
        vDsArquivo := '' + vDsArquivo + '.RTF';
      end else begin
        vDsArquivo := '' + vDsArquivo + '.MDB';
      end;
      putitemXml(pParams, 'DS_ARQUIVO', vDsArquivo);
      if (xStatus < 0) then begin
        Result := voParams;
        return(-1); exit;
      end;
      voParams := setDisplay(viParams); (* '', '', '' *)
      if (xStatus < 0) then begin
        Result := voParams;
        return(-1); exit;
      end;
    end;
  end;

  voParams := activateCmp('KERNEL32', 'SLEEP', viParams); (*10000 *)

  voParams := activateCmp('vbfileman', 'arqexiste', viParams); (*vFlag,'' + vDsPathRETORNOECF + '.TXT' *)
  if (vFlag = True) then begin
    voParams := activateCmp('vbfileman', 'apagaarquivo', viParams); (*'' + vDsPathRETORNOECF + '.TXT' *)
    if (xStatus < 0) then begin
      Result := voParams;
      return(-1); exit;
    end;
  end;

  length vDsConteudo;
  Status := vDsConteudo[1, 4];
  if (Status = -1) then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', '' + vDsConteudo[ + '5, gresult]', cDS_METHOD);
    voParams := activateCmp('vbfileman', 'apagaarquivo', viParams); (*'' + vDsPathRETORNOECF + '.TXT' *)
    if (xStatus < 0) then begin
      Result := voParams;
      return(-1); exit;
    end;

    return(-1); exit;
  end else begin
    voParams := setDisplay(viParams); (* '' + vDsConteudo[ + '5, gresult]', '', '' *)
    if (xStatus < 0) then begin
      Result := voParams;
      return(-1); exit;
    end;
  end;

  voParams := activateCmp('vbfileman', 'arqexiste', viParams); (*vFlag,'' + vDsPathRETORNOECF + '.TXT' *)
  if (vFlag) then begin
    voParams := activateCmp('vbfileman', 'apagaarquivo', viParams); (*'' + vDsPathRETORNOECF + '.TXT' *)
    if (xStatus < 0) then begin
      Result := voParams;
      return(-1); exit;
    end;
  end;

  putitemXml(Result, 'DS_PATH', vDsPath);

  return(0); exit;

end;

//---------------------------------------------------------------
function T_ECFSVCO011.formatoDadosMFD(pParams : String) : String;
//---------------------------------------------------------------
const
  cDS_METHOD = 'ADICIONAL=Operação: T_ECFSVCO011.formatoDadosMFD()';
var
  vDsArquivoMFD, vDsArquivo, vTpFormato, vTpDownload, vDadoINI, vDadoFIM, vNrUsuario, vDsPath, vDsConteudo, vEOF : String;
  vQtTentativa, status : Real;
  vFlag : Boolean;
begin
  vDsPath := itemXml('DS_UNIDTERMINAL', PARAM_GLB);
  vDsPath := '' + vDsPath:\ECF\' + ';
  xStatus := 0;

  vDsArquivoMFD := itemXml('DS_ARQUIVOMFD', pParams);
  vDsArquivo := itemXml('DS_ARQUIVO', pParams);
  vTpFormato := itemXmlF('TP_FORMATO', pParams);
  vTpDownload := itemXmlF('TP_DOWNLOAD', pParams);
  vDadoINI := itemXml('DS_DADOINI', pParams);
  vDadoFIM := itemXml('DS_DADOFIM', pParams);
  vNrUsuario := itemXmlF('NR_USUARIO', pParams);

  voParams := espacoDireita(viParams); (* vDsArquivoMFD, 19, vDsArquivoMFD *)
  if (xStatus < 0) then begin
    Result := voParams;
    return(-1); exit;
  end;

  voParams := espacoDireita(viParams); (* vDsArquivo, 19, vDsArquivo *)
  if (xStatus < 0) then begin
    Result := voParams;
    return(-1); exit;
  end;

  voParams := espacoDireita(viParams); (* vTpDownload, 1, vTpDownload *)
  if (xStatus < 0) then begin
    Result := voParams;
    return(-1); exit;
  end;

  voParams := espacoDireita(viParams); (* vDadoINI, 6, vDadoINI *)
  if (xStatus < 0) then begin
    Result := voParams;
    return(-1); exit;
  end;

  voParams := espacoDireita(viParams); (* vDadoFIM, 6, vDadoFIM *)
  if (xStatus < 0) then begin
    Result := voParams;
    return(-1); exit;
  end;

  voParams := espacoDireita(viParams); (* vNrUsuario, 1, vNrUsuario *)

  filedump '020' + vDsArquivoMFD' + vDsArquivo' + FloatToStr(vTpFormato' + FloatToStr(vTpDownload' + vDadoINI' + vDadoFIM' + FloatToStr(vNrUsuario',))) + ' + ' + ' + ' + ' + ' + ' '' + vDsPathMFD + '.TMP';
  if (xStatus < 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Falha na gravação de arquivos na máquina check in!', cDS_METHOD);
    return(-1); exit;
  end;

  voParams := activateCmp('vbfileman', 'movearquivo', viParams); (*vEOF,'' + vDsPathMFD + '.TMP','' + vDsPathMFD + '.TXT' *)
  if (xStatus < 0) then begin
    Result := voParams;
    return(-1); exit;
  end;

  voParams := activateCmp('KERNEL32', 'SLEEP', viParams); (*1000 *)
  vDsConteudo := '';
  vQtTentativa := 0;
  repeat

    fileload '' + vDsPathRETORNOECF + '.TXT', vDsConteudo;
    if (xStatus < 0) then begin
      Result := voParams;
      return(-1); exit;
    end;
        if (xStatus < 0) then begin
          Result := voParams;
          return(-1); exit;
        end;
        return(-1); exit;
      end;
    end;

  until (vDsConteudo <> '');

  length vDsConteudo;
  Status := vDsConteudo[1, 4];
  if (Status = -1) then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', '' + vDsConteudo[ + '5, gresult]', cDS_METHOD);
    voParams := activateCmp('vbfileman', 'apagaarquivo', viParams); (*'' + vDsPathRETORNOECF + '.TXT' *)
    if (xStatus < 0) then begin
      Result := voParams;
      return(-1); exit;
    end;

    return(-1); exit;
  end else begin
    voParams := setDisplay(viParams); (* '' + vDsConteudo[ + '5, gresult]', '', '' *)
    if (xStatus < 0) then begin
      Result := voParams;
      return(-1); exit;
    end;
  end;

  voParams := activateCmp('vbfileman', 'apagaarquivo', viParams); (*'' + vDsPathRETORNOECF + '.TXT' *)
  if (xStatus < 0) then begin
    Result := voParams;
    return(-1); exit;
  end;

  return(0); exit;
end;

//------------------------------------------------------------------
function T_ECFSVCO011.dataHoraImpressora(pParams : String) : String;
//------------------------------------------------------------------
const
  cDS_METHOD = 'ADICIONAL=Operação: T_ECFSVCO011.dataHoraImpressora()';
var
  vEOF, vDsLinha, vDsRetorno, vDsPath, vDsConteudo, viParams, voParams, vDsLista, vDsRegistro : String;
  vQtTentativa, Status : Real;
begin
  vDsPath := itemXml('DS_UNIDTERMINAL', PARAM_GLB);
  vDsPath := '' + vDsPath:\ECF\' + ';
  xStatus := 0;

  filedump '034', '' + vDsPathECF + '.TMP';
  if (xStatus < 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Falha na gravação de arquivos na máquina check in!', cDS_METHOD);
    return(-1); exit;
  end;

  voParams := activateCmp('vbfileman', 'movearquivo', viParams); (*vEOF,'' + vDsPathECF + '.TMP','' + vDsPathECF + '.TXT' *)
  if (xStatus < 0) then begin
    Result := voParams;
    return(-1); exit;
  end;

  vDsConteudo := '';
  vQtTentativa := 0;
  repeat

    fileload '' + vDsPathRETORNOECF + '.TXT', vDsConteudo;
    if (xStatus < 0) then begin
      Result := voParams;
      return(-1); exit;
    end;
        if (xStatus < 0) then begin
          Result := voParams;
          return(-1); exit;
        end;
        return(-1); exit;
      end;
    end;

  until (vDsConteudo <> '');

  length vDsConteudo;
  Status := vDsConteudo[1, 4];
  if (Status = -1) then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', '' + vDsConteudo[ + '5, gresult]', cDS_METHOD);
    voParams := activateCmp('vbfileman', 'apagaarquivo', viParams); (*'' + vDsPathRETORNOECF + '.TXT' *)
    if (xStatus < 0) then begin
      Result := voParams;
      return(-1); exit;
    end;

    return(-1); exit;
  end else begin
    voParams := setDisplay(viParams); (* '' + vDsConteudo[ + '5, gresult]', '', '' *)
    if (xStatus < 0) then begin
      Result := voParams;
      return(-1); exit;
    end;
  end;

  voParams := activateCmp('vbfileman', 'filename', viParams); (*'' + vDsPathRETORNOECF + '.TXT' *)
  if (xStatus < 0) then begin
    Result := voParams;
    return(-1); exit;
  end;

  repeat

    voParams := activateCmp('vbfileman', 'learquivo', viParams); (*vDsLinha *)
    if (xStatus < 0) then begin
      Result := voParams;
      return(-1); exit;
    end;

    vDsRetorno := itemXml('DS_DATAHORA', vDsLinha);
    length(vDsRetorno);
    if (gresult > 0) then begin
      putitemXml(Result, 'DS_DATAHORA', vDsRetorno);
    end;

    voParams := activateCmp('vbfileman', 'eof', viParams); (*vEOF *)
    if (xStatus < 0) then begin
      Result := voParams;
      return(-1); exit;
    end;

  until (vEOF := -1);

  voParams := activateCmp('vbfileman', 'apagaarquivo', viParams); (*'' + vDsPathRETORNOECF + '.TXT' *)
  if (xStatus < 0) then begin
    Result := voParams;
    return(-1); exit;
  end;

  return(0); exit;
end;

//----------------------------------------------------------------
function T_ECFSVCO011.modeloImpressora(pParams : String) : String;
//----------------------------------------------------------------
const
  cDS_METHOD = 'ADICIONAL=Operação: T_ECFSVCO011.modeloImpressora()';
var
  vEOF, vDsLinha, vDsRetorno, vDsPath, vDsConteudo, viParams, voParams, vDsLista, vDsRegistro : String;
  vQtTentativa, Status : Real;
begin
  vDsPath := itemXml('DS_UNIDTERMINAL', PARAM_GLB);
  vDsPath := '' + vDsPath:\ECF\' + ';
  xStatus := 0;

  filedump '099', '' + vDsPathECF + '.TMP';
  if (xStatus < 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Falha na gravação de arquivos na máquina check in!', cDS_METHOD);
    return(-1); exit;
  end;

  voParams := activateCmp('vbfileman', 'movearquivo', viParams); (*vEOF,'' + vDsPathECF + '.TMP','' + vDsPathECF + '.TXT' *)
  if (xStatus < 0) then begin
    Result := voParams;
    return(-1); exit;
  end;

  vDsConteudo := '';
  vQtTentativa := 0;
  repeat

    fileload '' + vDsPathRETORNOECF + '.TXT', vDsConteudo;
    if (xStatus < 0) then begin
      Result := voParams;
      return(-1); exit;
    end;
        if (xStatus < 0) then begin
          Result := voParams;
          return(-1); exit;
        end;
        return(-1); exit;
      end;
    end;

  until (vDsConteudo <> '');

  length vDsConteudo;
  Status := vDsConteudo[1, 4];
  if (Status = -1) then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', '' + vDsConteudo[ + '5, gresult]', cDS_METHOD);
    voParams := activateCmp('vbfileman', 'apagaarquivo', viParams); (*'' + vDsPathRETORNOECF + '.TXT' *)
    if (xStatus < 0) then begin
      Result := voParams;
      return(-1); exit;
    end;

    return(-1); exit;
  end else begin
    voParams := setDisplay(viParams); (* '' + vDsConteudo[ + '5, gresult]', '', '' *)
    if (xStatus < 0) then begin
      Result := voParams;
      return(-1); exit;
    end;
  end;

  voParams := activateCmp('vbfileman', 'filename', viParams); (*'' + vDsPathRETORNOECF + '.TXT' *)
  if (xStatus < 0) then begin
    Result := voParams;
    return(-1); exit;
  end;

  repeat

    voParams := activateCmp('vbfileman', 'learquivo', viParams); (*vDsLinha *)
    if (xStatus < 0) then begin
      Result := voParams;
      return(-1); exit;
    end;

    vDsRetorno := itemXml('DS_MODELOECF', vDsLinha);
    length(vDsRetorno);
    if (gresult > 0) then begin
      putitemXml(Result, 'DS_MODELOECF', vDsRetorno);
    end;

    voParams := activateCmp('vbfileman', 'eof', viParams); (*vEOF *)
    if (xStatus < 0) then begin
      Result := voParams;
      return(-1); exit;
    end;

  until (vEOF := -1);

  voParams := activateCmp('vbfileman', 'apagaarquivo', viParams); (*'' + vDsPathRETORNOECF + '.TXT' *)
  if (xStatus < 0) then begin
    Result := voParams;
    return(-1); exit;
  end;

  return(0); exit;
end;

//---------------------------------------------------------
function T_ECFSVCO011.autentica(pParams : String) : String;
//---------------------------------------------------------
const
  cDS_METHOD = 'ADICIONAL=Operação: T_ECFSVCO011.autentica()';
var
  vEOF, vDsPath, vDsConteudo : String;
  vQtTentativa, Status : Real;
begin
  vDsPath := itemXml('DS_UNIDTERMINAL', PARAM_GLB);
  vDsPath := '' + vDsPath:\ECF\' + ';
  xStatus := 0;

  filedump '070', '' + vDsPathECF + '.TMP';
  if (xStatus < 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Falha na gravação de arquivos na máquina check in!', cDS_METHOD);
    return(-1); exit;
  end;

  voParams := activateCmp('vbfileman', 'movearquivo', viParams); (*vEOF,'' + vDsPathECF + '.TMP','' + vDsPathECF + '.TXT' *)
  if (xStatus < 0) then begin
    Result := voParams;
    return(-1); exit;
  end;

  vDsConteudo := '';
  vQtTentativa := 0;
  repeat

    fileload '' + vDsPathRETORNOECF + '.TXT', vDsConteudo;
    if (xStatus < 0) then begin
      Result := voParams;
      return(-1); exit;
    end;
        if (xStatus < 0) then begin
          Result := voParams;
          return(-1); exit;
        end;
        return(-1); exit;
      end;
    end;

  until (vDsConteudo <> '');

  length vDsConteudo;
  Status := vDsConteudo[1, 4];
  if (Status = -1) then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', '' + vDsConteudo[ + '5, gresult]', cDS_METHOD);
    voParams := activateCmp('vbfileman', 'apagaarquivo', viParams); (*'' + vDsPathRETORNOECF + '.TXT' *)
    if (xStatus < 0) then begin
      Result := voParams;
      return(-1); exit;
    end;

    return(-1); exit;
  end else begin
    voParams := setDisplay(viParams); (* '' + vDsConteudo[ + '5, gresult]', '', '' *)
    if (xStatus < 0) then begin
      Result := voParams;
      return(-1); exit;
    end;
  end;

  voParams := activateCmp('vbfileman', 'apagaarquivo', viParams); (*'' + vDsPathRETORNOECF + '.TXT' *)
  if (xStatus < 0) then begin
    Result := voParams;
    return(-1); exit;
  end;

  return(0); exit;
end;

//---------------------------------------------------------------------
function T_ECFSVCO011.geraRegistrosCAT52MFD(pParams : String) : String;
//---------------------------------------------------------------------
const
  cDS_METHOD = 'ADICIONAL=Operação: T_ECFSVCO011.geraRegistrosCAT52MFD()';
var
  vDsArquivo, vData, vDataFim, viParams, voParams : String;
  vEOF, vDsPath, vDsConteudo, vDsAux, vNrSerie : String;
  vTpRelatorio, vQtTentativa, Status : Real;
  vFlag : Boolean;
begin
  vNrSerie := itemXmlF('CD_SERIEECF', PARAM_GLB);
  if (vNrSerie = '') then begin
    viParams := '';

    putitemXml(viParams, 'NM_FUNCAO', <ECF_NUMERO_SERIE>);
    putitemXml(viParams, 'IN_IMPCUPOMFISCAL', False);
    voParams := leinformacaoImpressora(viParams); (* viParams, voParams, xCdErro, xCtxErro *)
    if (xStatus < 0) then begin
      Result := voParams;
      return(-1); exit;
    end;
    vNrSerie := itemXmlF('NR_SERIE', voParams);
    if (vNrSerie = '') then begin
      Result := SetStatus(STS_ERROR, 'GEN0001', 'Erro ao obter número de série da impressora!', cDS_METHOD);
      return(-1); exit;
    end;
  end;
  vDsPath := itemXml('DS_UNIDTERMINAL', PARAM_GLB);
  vDsPath := '' + vDsPath:\ECF\' + ';
  xStatus := 0;

  vDsArquivo := itemXml('DS_ARQUIVO', pParams);
  vData := itemXml('DS_DATA', pParams);
  vDataFim := itemXml('DS_DATAFIM', pParams);

  voParams := espacoDireita(viParams); (* vDsArquivo, 20, vDsArquivo *)

  filedump '043' + FloatToStr(vTpRelatorio' + vDsArquivo' + vData' + vDataFim',) + ' + ' + ' + ' '' + vDsPathMFD + '.TMP';
  if (xStatus < 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Falha na gravação de arquivos na máquina check in!', cDS_METHOD);
    return(-1); exit;
  end;

  voParams := activateCmp('vbfileman', 'movearquivo', viParams); (*vEOF,'' + vDsPathMFD + '.TMP','' + vDsPathMFD + '.TXT' *)
  if (xStatus < 0) then begin
    Result := voParams;
    return(-1); exit;
  end;

  vDsConteudo := '';
  vQtTentativa := 0;
  repeat
    voParams := activateCmp('KERNEL32', 'SLEEP', viParams); (*1000 *)
    voParams := activateCmp('vbfileman', 'arqexiste', viParams); (*vFlag,'' + vDsPathRETORNOECF + '.TXT' *)
    if (vFlag = True) then begin
      break;
    end;
    vQtTentativa := vQtTentativa + 1;
    if (vQtTentativa > 300) then begin
      Result := SetStatus(STS_ERROR, 'GEN0001', 'Falha na comunicação tempo de resposta esgotado para máquina check in!', cDS_METHOD);
      voParams := activateCmp('vbfileman', 'arqexiste', viParams); (*vFlag,'' + vDsPathECF + '.TXT' *)
      if (vFlag = True) then begin
        voParams := activateCmp('vbfileman', 'apagaarquivo', viParams); (*'' + vDsPathECF + '.TXT' *)
        if (xStatus < 0) then begin
          Result := voParams;
          return(-1); exit;
        end;
      end;
      return(-1); exit;
    end;

  until (vDsConteudo <> '');

  length vDsConteudo;
  Status := vDsConteudo[1, 4];
  if (Status = -1) then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', '' + vDsConteudo[ + '5, gresult]', cDS_METHOD);
    voParams := activateCmp('vbfileman', 'apagaarquivo', viParams); (*'' + vDsPathRETORNOECF + '.TXT' *)
    if (xStatus < 0) then begin
      Result := voParams;
      return(-1); exit;
    end;
    return(-1); exit;
  end else begin
    voParams := setDisplay(viParams); (* '' + vDsConteudo[ + '5, gresult]', '', '' *)
    if (xStatus < 0) then begin
      Result := voParams;
      return(-1); exit;
    end;
  end;

  voParams := activateCmp('vbfileman', 'apagaarquivo', viParams); (*'' + vDsPathRETORNOECF + '.TXT' *)
  if (xStatus < 0) then begin
    Result := voParams;
    return(-1); exit;
  end;

  return(0); exit;
end;

//----------------------------------------------------------------------
function T_ECFSVCO011.abreRelatorioGerencial(pParams : String) : String;
//----------------------------------------------------------------------
const
  cDS_METHOD = 'ADICIONAL=Operação: T_ECFSVCO011.abreRelatorioGerencial()';
var
  vEOF, vDsPath, vDsConteudo, vDsPgto : String;
  vQtTentativa, Status : Real;
begin
  vDsPath := itemXml('DS_UNIDTERMINAL', PARAM_GLB);
  vDsPath := '' + vDsPath:\ECF\' + ';
  xStatus := 0;

  vDsPgto := itemXml('DS_FORMAPGTO', pParams);
  voParams := espacoDireita(viParams); (* vDsPgto, 16, vDsPgto *)
  if (xStatus < 0) then begin
    Result := voParams;
    return(-1); exit;
  end;

  gVl14DIG := itemXmlF('VL_VALOR', pParams);
  gVl6DIG := itemXmlF('NR_CUPOM', pParams);

  if (itemXml('PADRAO_ECF', PARAM_GLB) = <PADRAO_LOCALIMPFINAL>) then begin
    putitemXml(Result, 'DS_CUPOM', '024' + vDsPgto' + FloatToStr(gVl) + ' + '14DIG' + FloatToStr(gVl) + '6DIG');
    return(0); exit;
  end;

  filedump '024' + vDsPgto' + FloatToStr(gVl) + ' + '14DIG' + FloatToStr(gVl) + '6DIG', '' + vDsPathECF + '.TMP';
  if (xStatus < 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Falha na gravação de arquivos na máquina check in!', cDS_METHOD);
    return(-1); exit;
  end;

  voParams := activateCmp('vbfileman', 'movearquivo', viParams); (*vEOF,'' + vDsPathECF + '.TMP','' + vDsPathECF + '.TXT' *)
  if (xStatus < 0) then begin
    Result := voParams;
    return(-1); exit;
  end;

  vDsConteudo := '';
  vQtTentativa := 0;
  repeat

    fileload '' + vDsPathRETORNOECF + '.TXT', vDsConteudo;
    if (xStatus < 0) then begin
      Result := voParams;
      return(-1); exit;
    end;
        if (xStatus < 0) then begin
          Result := voParams;
          return(-1); exit;
        end;
        return(-1); exit;
      end;
    end;

  until (vDsConteudo <> '');

  length vDsConteudo;
  Status := vDsConteudo[1, 4];
  if (Status = -1) then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', '' + vDsConteudo[ + '5, gresult]', cDS_METHOD);
    voParams := activateCmp('vbfileman', 'apagaarquivo', viParams); (*'' + vDsPathRETORNOECF + '.TXT' *)
    if (xStatus < 0) then begin
      Result := voParams;
      return(-1); exit;
    end;

    return(-1); exit;
  end else begin
    voParams := setDisplay(viParams); (* '' + vDsConteudo[ + '5, gresult]', '', '' *)
    if (xStatus < 0) then begin
      Result := voParams;
      return(-1); exit;
    end;
  end;

  voParams := activateCmp('vbfileman', 'apagaarquivo', viParams); (*'' + vDsPathRETORNOECF + '.TXT' *)
  if (xStatus < 0) then begin
    Result := voParams;
    return(-1); exit;
  end;

  return(0); exit;
end;

//---------------------------------------------------------------
function T_ECFSVCO011.verificaTermica(pParams : String) : String;
//---------------------------------------------------------------
const
  cDS_METHOD = 'ADICIONAL=Operação: T_ECFSVCO011.verificaTermica()';
var
  vCdComponente, vDsRetorno, vEOF, vDsLinha, vDsPath, vDsConteudo : String;
  vQtTentativa, Status : Real;
  vInConcomitante : Boolean;
begin
  vDsPath := itemXml('DS_UNIDTERMINAL', PARAM_GLB);
  vDsPath := '' + vDsPath:\ECF\' + ';
  xStatus := 0;

  filedump '035', '' + vDsPathECF + '.TMP';
  if (xStatus < 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Falha na gravação de arquivos na máquina check in!', cDS_METHOD);
    return(-1); exit;
  end;

  voParams := activateCmp('vbfileman', 'movearquivo', viParams); (*vEOF,'' + vDsPathECF + '.TMP','' + vDsPathECF + '.TXT' *)
  if (xStatus < 0) then begin
    Result := voParams;
    return(-1); exit;
  end;

  vDsConteudo := '';
  vQtTentativa := 0;
  repeat
    fileload '' + vDsPathRETORNOECF + '.TXT', vDsConteudo;
    if (xStatus < 0) then begin
      Result := voParams;
      return(-1); exit;
    end;
        if (xStatus < 0) then begin
          Result := voParams;
          return(-1); exit;
        end;
        return(-1); exit;
      end;
    end;

  until (vDsConteudo <> '');

  length vDsConteudo;
  Status := vDsConteudo[1, 4];
  if (Status = -1) then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', '' + vDsConteudo[ + '5, gresult]', cDS_METHOD);
    voParams := activateCmp('vbfileman', 'apagaarquivo', viParams); (*'' + vDsPathRETORNOECF + '.TXT' *)
    if (xStatus < 0) then begin
      Result := voParams;
      return(-1); exit;
    end;

    return(-1); exit;
  end else begin
    voParams := setDisplay(viParams); (* '' + vDsConteudo[ + '5, gresult]', '', '' *)
    if (xStatus < 0) then begin
      Result := voParams;
      return(-1); exit;
    end;
  end;

  voParams := activateCmp('vbfileman', 'filename', viParams); (*'' + vDsPathRETORNOECF + '.TXT' *)
  if (xStatus < 0) then begin
    Result := voParams;
    return(-1); exit;
  end;

  repeat

    voParams := activateCmp('vbfileman', 'learquivo', viParams); (*vDsLinha *)
    if (xStatus < 0) then begin
      Result := voParams;
      return(-1); exit;
    end;

    vDsRetorno := itemXmlB('IN_TERMICA', vDsLinha);
    length(vDsRetorno);
    if (gresult > 0) then begin
      putitemXml(Result, 'IN_TERMICA', vDsRetorno);
    end;

    voParams := activateCmp('vbfileman', 'eof', viParams); (*vEOF *)
    if (xStatus < 0) then begin
      Result := voParams;
      return(-1); exit;
    end;

  until (vEOF := -1);

  voParams := activateCmp('vbfileman', 'apagaarquivo', viParams); (*'' + vDsPathRETORNOECF + '.TXT' *)
  if (xStatus < 0) then begin
    Result := voParams;
    return(-1); exit;
  end;

  return(0); exit;
end;

//--------------------------------------------------------
function T_ECFSVCO011.leCheque(pParams : String) : String;
//--------------------------------------------------------
const
  cDS_METHOD = 'ADICIONAL=Operação: T_ECFSVCO011.leCheque()';
var
  vEOF, vDsPath, vDsConteudo,vDsRetorno, vDsLinha : String;
  vQtTentativa, Status : Real;
  vFlag : Boolean;
begin
  vDsPath := itemXml('DS_UNIDTERMINAL', PARAM_GLB);
  vDsPath := '' + vDsPath:\ECF\' + ';
  xStatus := 0;

  filedump '132', '' + vDsPathECF + '.TMP';
  if (xStatus < 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Falha na gravação de arquivos na máquina check in!', cDS_METHOD);
    return(-1); exit;
  end;

  voParams := activateCmp('vbfileman', 'movearquivo', viParams); (*vEOF,'' + vDsPathECF + '.TMP','' + vDsPathECF + '.TXT' *)
  if (xStatus < 0) then begin
    Result := voParams;
    return(-1); exit;
  end;

  vDsConteudo := '';
  vQtTentativa := 0;
  repeat
    fileload '' + vDsPathRETORNOECF + '.TXT', vDsConteudo;
    if (xStatus < 0) then begin
      Result := voParams;
      return(-1); exit;
    end;
        if (xStatus < 0) then begin
          Result := voParams;
          return(-1); exit;
        end;
        return(-1); exit;
      end;
    end;
  until (vDsConteudo <> '');

  length vDsConteudo;
  Status := vDsConteudo[1, 4];
  if (Status = -1) then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', '' + vDsConteudo[ + '5, gresult]', cDS_METHOD);
    voParams := activateCmp('vbfileman', 'apagaarquivo', viParams); (*'' + vDsPathRETORNOECF + '.TXT' *)
    if (xStatus < 0) then begin
      Result := voParams;
      return(-1); exit;
    end;
    return(-1); exit;
  end else begin
    voParams := setDisplay(viParams); (* '' + vDsConteudo[ + '5, gresult]', '', '' *)
    if (xStatus < 0) then begin
      Result := voParams;
      return(-1); exit;
    end;
  end;

  voParams := activateCmp('vbfileman', 'filename', viParams); (*'' + vDsPathRETORNOECF + '.TXT' *)
  if (xStatus < 0) then begin
    Result := voParams;
    return(-1); exit;
  end;

  repeat
    voParams := activateCmp('vbfileman', 'learquivo', viParams); (*vDsLinha *)
    if (xStatus < 0) then begin
      Result := voParams;
      return(-1); exit;
    end;

    vDsRetorno := vDsLinha;

    voParams := activateCmp('vbfileman', 'eof', viParams); (*vEOF *)
    if (xStatus < 0) then begin
      Result := voParams;
      return(-1); exit;
    end;
  until (vEOF := -1);

  voParams := activateCmp('vbfileman', 'apagaarquivo', viParams); (*'' + vDsPathRETORNOECF + '.TXT' *)
  if (xStatus < 0) then begin
    Result := voParams;
    return(-1); exit;
  end;

  Result := vDsRetorno;

  return(0); exit;
end;

//----------------------------------------------------------------------
function T_ECFSVCO011.geraRelatorioGerencial(pParams : String) : String;
//----------------------------------------------------------------------
const
  cDS_METHOD = 'ADICIONAL=Operação: T_ECFSVCO011.geraRelatorioGerencial()';
var
  viParams, voParams, vDsLinha, vDsTexto, vDsRegistro : String;
  vDsCupom, vDsConteudo, vDsImpressao, DsLstCupom : String;
  vNrCopia, vNrLinha, vPadraoECF, vNrViasCupom : Real;
begin
  DsLstCupom := itemXml('DS_LSTCUPOM', pParams);
  if (DsLstCupom = '') then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Texto a ser impresso não informado!', cDS_METHOD);
    return(-1); exit;
  end;

  vNrViasCupom= itemXmlF('NR_VIASCUPOM', pParams);
  if (vNrViasCupom = '') then begin
    vNrViasCupom := 1;
  end;

  vPadraoECF := itemXml('PADRAO_ECF', PARAM_GLB);

  if (vPadraoECF = 100) then begin
    vDsImpressao := '024';

    getitem(vDsRegistro, DsLstCupom, 1);
    vDsCupom := '';
    vDsConteudo := itemXml('DS_CUPOM', vDsRegistro);
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
      vDsImpressao := '' + vDsImpressao + '025' + vDsLinha' + ';
      vDsCupom := '' + vDsCupom + '025' + vDsLinha' + ';
      length vDsConteudo;
    end;

    vNrCopia := 1;
    repeat

      if (vNrCopia <> vNrViasCupom) then begin
        vDsImpressao := '' + vDsImpressao + '025025';
      end else begin
        vDsImpressao := '' + vDsImpressao + '026';
      end;

      viParams := '';
      putitemXml(viParams, 'IN_IMPRIMEVIA', True);
      putitemXml(viParams, 'DS_TEXTO', vDsImpressao);
      voParams := activateCmp('ECFSVCO001', 'ImprimirRelatorioGerencial', viParams); (*,,, *)
      if (xStatus < 0) then begin
        Result := voParams;
        return(-1); exit;
      end;
      if (vNrCopia = vNrViasCupom) then begin
        vDsImpressao := '';
        vDsImpressao := '' + vDsCupom + '026';
      end else begin
        vDsImpressao := '';
        vDsImpressao := '' + vDsCupom' + ';
      end;

      vNrCopia := vNrCopia + 1;
    until (vNrCopia > vNrViasCupom);
  end;

  return(0); exit;
end;

//---------------------------------------------------------------------------
function T_ECFSVCO011.leituraMemoriaFiscalDataMFD(pParams : String) : String;
//---------------------------------------------------------------------------
const
  cDS_METHOD = 'ADICIONAL=Operação: T_ECFSVCO011.leituraMemoriaFiscalDataMFD()';
var
  vEOF, vDsPath, vDsConteudo, vDataINI, vDataFIM, vTipo : String;
  vQtTentativa, Status : Real;
begin
  vDsPath := itemXml('DS_UNIDTERMINAL', PARAM_GLB);
  vDsPath := '' + vDsPath:\ECF\' + ';
  xStatus := 0;

  vDataINI := itemXml('DT_INICIO', pParams);
  if (vDataINI = '') then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Data inicial não informada!', cDS_METHOD);
    return(-1); exit;
  end;

  vDataFIM := itemXml('DT_FIM', pParams);
  if (vDataFIM = '') then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Data final não informada!', cDS_METHOD);
    return(-1); exit;
  end;

  vTipo := itemXmlF('TP_TIPO', pParams);
  if (vTipo = '') then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Tipo de leitura não informado!', cDS_METHOD);
    return(-1); exit;
  end;

  filedump '018' + vDataINI' + vDataFIM' + vTipo', + ' + ' + ' '' + vDsPathECF + '.TMP';
  if (xStatus < 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Falha na gravação de arquivos na máquina check in!', cDS_METHOD);
    return(-1); exit;
  end;

  voParams := activateCmp('vbfileman', 'movearquivo', viParams); (*vEOF,'' + vDsPathECF + '.TMP','' + vDsPathECF + '.TXT' *)
  if (xStatus < 0) then begin
    Result := voParams;
    return(-1); exit;
  end;

  vDsConteudo := '';
  vQtTentativa := 0;
  repeat

    fileload '' + vDsPathRETORNOECF + '.TXT', vDsConteudo;
    if (xStatus < 0) then begin
      Result := voParams;
      return(-1); exit;
    end;
        if (xStatus < 0) then begin
          Result := voParams;
          return(-1); exit;
        end;
        return(-1); exit;
      end;
    end;

  until (vDsConteudo <> '');

  length vDsConteudo;
  Status := vDsConteudo[1, 4];
  if (Status = -1) then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', '' + vDsConteudo[ + '5, gresult]', cDS_METHOD);
    voParams := activateCmp('vbfileman', 'apagaarquivo', viParams); (*'' + vDsPathRETORNOECF + '.TXT' *)
    if (xStatus < 0) then begin
      Result := voParams;
      return(-1); exit;
    end;

    return(-1); exit;
  end else begin
    voParams := setDisplay(viParams); (* '' + vDsConteudo[ + '5, gresult]', '', '' *)
    if (xStatus < 0) then begin
      Result := voParams;
      return(-1); exit;
    end;
  end;

  voParams := activateCmp('vbfileman', 'apagaarquivo', viParams); (*'' + vDsPathRETORNOECF + '.TXT' *)
  if (xStatus < 0) then begin
    Result := voParams;
    return(-1); exit;
  end;

  putitemXml(Result, 'DS_PATH', vDsPath);

  return(0); exit;
end;

//------------------------------------------------------------------------------
function T_ECFSVCO011.leituraMemoriaFiscalReducaoMFD(pParams : String) : String;
//------------------------------------------------------------------------------
const
  cDS_METHOD = 'ADICIONAL=Operação: T_ECFSVCO011.leituraMemoriaFiscalReducaoMFD()';
var
  vEOF, vDsPath, vDsConteudo, vRedINI, vRedFIM, vTipo : String;
  vQtTentativa, Status : Real;
begin
  vDsPath := itemXml('DS_UNIDTERMINAL', PARAM_GLB);
  vDsPath := '' + vDsPath:\ECF\' + ';
  xStatus := 0;

  vRedINI := itemXmlF('NR_REDINI', pParams);
  if (vRedINI = '') then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Redução inicial não informada!', cDS_METHOD);
    return(-1); exit;
  end;

  voParams := preencheZero(viParams); (* vRedINI, 5, vRedINI *)
  if (xStatus < 0) then begin
    Result := voParams;
    return(-1); exit;
  end;

  vRedFIM := itemXmlF('NR_REDFIM', pParams);
  if (vRedFIM = '') then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Redução final não informada!', cDS_METHOD);
    return(-1); exit;
  end;

  voParams := preencheZero(viParams); (* vRedFIM, 5, vRedFIM *)
  if (xStatus < 0) then begin
    Result := voParams;
    return(-1); exit;
  end;

  vTipo := itemXmlF('TP_TIPO', pParams);
  if (vTipo = '') then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Tipo de leitura não informado!', cDS_METHOD);
    return(-1); exit;
  end;

  filedump '019' + vRedINI' + vRedFIM' + vTipo', + ' + ' + ' '' + vDsPathECF + '.TMP';
  if (xStatus < 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Falha na gravação de arquivos na máquina check in!', cDS_METHOD);
    return(-1); exit;
  end;

  voParams := activateCmp('vbfileman', 'movearquivo', viParams); (*vEOF,'' + vDsPathECF + '.TMP','' + vDsPathECF + '.TXT' *)
  if (xStatus < 0) then begin
    Result := voParams;
    return(-1); exit;
  end;

  vDsConteudo := '';
  vQtTentativa := 0;
  repeat

    fileload '' + vDsPathRETORNOECF + '.TXT', vDsConteudo;
    if (xStatus < 0) then begin
      Result := voParams;
      return(-1); exit;
    end;
        if (xStatus < 0) then begin
          Result := voParams;
          return(-1); exit;
        end;
        return(-1); exit;
      end;
    end;

  until (vDsConteudo <> '');

  length vDsConteudo;
  Status := vDsConteudo[1, 4];
  if (Status = -1) then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', '' + vDsConteudo[ + '5, gresult]', cDS_METHOD);
    voParams := activateCmp('vbfileman', 'apagaarquivo', viParams); (*'' + vDsPathRETORNOECF + '.TXT' *)
    if (xStatus < 0) then begin
      Result := voParams;
      return(-1); exit;
    end;

    return(-1); exit;
  end else begin
    voParams := setDisplay(viParams); (* '' + vDsConteudo[ + '5, gresult]', '', '' *)
    if (xStatus < 0) then begin
      Result := voParams;
      return(-1); exit;
    end;
  end;

  voParams := activateCmp('vbfileman', 'apagaarquivo', viParams); (*'' + vDsPathRETORNOECF + '.TXT' *)
  if (xStatus < 0) then begin
    Result := voParams;
    return(-1); exit;
  end;

  putitemXml(Result, 'DS_PATH', vDsPath);

  return(0); exit;
end;

//----------------------------------------------------------------------------
function T_ECFSVCO011.leMemoriaFiscalSerialDataMFD(pParams : String) : String;
//----------------------------------------------------------------------------
const
  cDS_METHOD = 'ADICIONAL=Operação: T_ECFSVCO011.leMemoriaFiscalSerialDataMFD()';
var
  vEOF, vDsPath, vDsConteudo, vDataINI, vDataFIM, vTipo : String;
  vQtTentativa, Status : Real;
begin
  vDsPath := itemXml('DS_UNIDTERMINAL', PARAM_GLB);
  vDsPath := '' + vDsPath:\ECF\' + ';
  xStatus := 0;

  vDataINI := itemXml('DT_INICIO', pParams);
  if (vDataINI = '') then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Data inicial não informada!', cDS_METHOD);
    return(-1); exit;
  end;

  vDataFIM := itemXml('DT_FIM', pParams);
  if (vDataFIM = '') then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Data final não informada!', cDS_METHOD);
    return(-1); exit;
  end;

  vTipo := itemXmlF('TP_TIPO', pParams);
  if (vTipo = '') then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Tipo de leitura não informado!', cDS_METHOD);
    return(-1); exit;
  end;

  filedump '020' + vDataINI' + vDataFIM' + vTipo', + ' + ' + ' '' + vDsPathECF + '.TMP';
  if (xStatus < 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Falha na gravação de arquivos na máquina check in!', cDS_METHOD);
    return(-1); exit;
  end;

  voParams := activateCmp('vbfileman', 'movearquivo', viParams); (*vEOF,'' + vDsPathECF + '.TMP','' + vDsPathECF + '.TXT' *)
  if (xStatus < 0) then begin
    Result := voParams;
    return(-1); exit;
  end;

  vDsConteudo := '';
  vQtTentativa := 0;
  repeat

    fileload '' + vDsPathRETORNOECF + '.TXT', vDsConteudo;
    if (xStatus < 0) then begin
      Result := voParams;
      return(-1); exit;
    end;
        if (xStatus < 0) then begin
          Result := voParams;
          return(-1); exit;
        end;
        return(-1); exit;
      end;
    end;

  until (vDsConteudo <> '');

  length vDsConteudo;
  Status := vDsConteudo[1, 4];
  if (Status = -1) then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', '' + vDsConteudo[ + '5, gresult]', cDS_METHOD);
    voParams := activateCmp('vbfileman', 'apagaarquivo', viParams); (*'' + vDsPathRETORNOECF + '.TXT' *)
    if (xStatus < 0) then begin
      Result := voParams;
      return(-1); exit;
    end;

    return(-1); exit;
  end else begin
    voParams := setDisplay(viParams); (* '' + vDsConteudo[ + '5, gresult]', '', '' *)
    if (xStatus < 0) then begin
      Result := voParams;
      return(-1); exit;
    end;
  end;

  voParams := activateCmp('vbfileman', 'apagaarquivo', viParams); (*'' + vDsPathRETORNOECF + '.TXT' *)
  if (xStatus < 0) then begin
    Result := voParams;
    return(-1); exit;
  end;

  putitemXml(Result, 'DS_PATH', vDsPath);

  return(0); exit;
end;

//-------------------------------------------------------------------------------
function T_ECFSVCO011.leMemoriaFiscalSerialReducaoMFD(pParams : String) : String;
//-------------------------------------------------------------------------------
const
  cDS_METHOD = 'ADICIONAL=Operação: T_ECFSVCO011.leMemoriaFiscalSerialReducaoMFD()';
var
  vEOF, vDsPath, vDsConteudo, vRedINI, vRedFIM, vTipo : String;
  vQtTentativa, Status : Real;
begin
  vDsPath := itemXml('DS_UNIDTERMINAL', PARAM_GLB);
  vDsPath := '' + vDsPath:\ECF\' + ';
  xStatus := 0;
  vRedINI := itemXmlF('NR_REDINI', pParams);
  if (vRedINI = '') then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Redução inicial não informada!', cDS_METHOD);
    return(-1); exit;
  end;

  voParams := preencheZero(viParams); (* vRedINI, 5, vRedINI *)
  if (xStatus < 0) then begin
    Result := voParams;
    return(-1); exit;
  end;

  vRedFIM := itemXmlF('NR_REDFIM', pParams);
  if (vRedFIM = '') then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Redução final não informada!', cDS_METHOD);
    return(-1); exit;
  end;

  voParams := preencheZero(viParams); (* vRedFIM, 5, vRedFIM *)
  if (xStatus < 0) then begin
    Result := voParams;
    return(-1); exit;
  end;

  vTipo := itemXmlF('TP_TIPO', pParams);
  if (vTipo = '') then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Tipo de leitura não informado!', cDS_METHOD);
    return(-1); exit;
  end;

  filedump '036' + vRedINI' + vRedFIM' + vTipo', + ' + ' + ' '' + vDsPathECF + '.TMP';
  if (xStatus < 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Falha na gravação de arquivos na máquina check in!', cDS_METHOD);
    return(-1); exit;
  end;

  voParams := activateCmp('vbfileman', 'movearquivo', viParams); (*vEOF,'' + vDsPathECF + '.TMP','' + vDsPathECF + '.TXT' *)
  if (xStatus < 0) then begin
    Result := voParams;
    return(-1); exit;
  end;

  vDsConteudo := '';
  vQtTentativa := 0;
  repeat

    fileload '' + vDsPathRETORNOECF + '.TXT', vDsConteudo;
    if (xStatus < 0) then begin
      Result := voParams;
      return(-1); exit;
    end;
        if (xStatus < 0) then begin
          Result := voParams;
          return(-1); exit;
        end;
        return(-1); exit;
      end;
    end;

  until (vDsConteudo <> '');

  length vDsConteudo;
  Status := vDsConteudo[1, 4];
  if (Status = -1) then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', '' + vDsConteudo[ + '5, gresult]', cDS_METHOD);
    voParams := activateCmp('vbfileman', 'apagaarquivo', viParams); (*'' + vDsPathRETORNOECF + '.TXT' *)
    if (xStatus < 0) then begin
      Result := voParams;
      return(-1); exit;
    end;

    return(-1); exit;
  end else begin
    voParams := setDisplay(viParams); (* '' + vDsConteudo[ + '5, gresult]', '', '' *)
    if (xStatus < 0) then begin
      Result := voParams;
      return(-1); exit;
    end;
  end;

  voParams := activateCmp('vbfileman', 'apagaarquivo', viParams); (*'' + vDsPathRETORNOECF + '.TXT' *)
  if (xStatus < 0) then begin
    Result := voParams;
    return(-1); exit;
  end;

  putitemXml(Result, 'DS_PATH', vDsPath);

  return(0); exit;
end;

//-------------------------------------------------------
function T_ECFSVCO011.geraEAD(pParams : String) : String;
//-------------------------------------------------------
const
  cDS_METHOD = 'ADICIONAL=Operação: T_ECFSVCO011.geraEAD()';
var
  viParams, voParams, vEOF, vDsMensagem, vDsArquivo, vDsNomeArquivo : String;
  vDsChavePrivada, vDsChavepublica, vDsPath : String;
  vFlag : Boolean;
begin
  vDsArquivo := itemXml('DS_PATH', pParams);

  if (vDsArquivo = '') then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Arquivo não informado!', cDS_METHOD);
    return(-1); exit;
  end;

  vDsPath := 'D:\Virtualage\Storeage\temp\';

  vDsNomeArquivo := itemXml('DS_NOMEARQ', pParams);

  vDsChavepublica := itemXml('DS_CHAVEpublicA', pParams);

  vDsChavePrivada := itemXml('DS_CHAVEPRIVADA', pParams);

  if (vDsChavePrivada = '' ) and (vDsChavePrivada = '') then begin
    clear_e(tGLB_CHAVE);
    retrieve_e(tGLB_CHAVE);
    if (xStatus >=0) then begin
      setocc(tGLB_CHAVE, 1);
      while (xStatus >= 0) do begin
        if (item_f('CD_CHAVE', tGLB_CHAVE) = 1) then begin
          vDsChavepublica := item_f('VL_CHAVE', tGLB_CHAVE);
          filedump '' + vDsChavepublica + ' ', '' + vDsPathChavepublicaStoreage + '.txt';
          if (xStatus < 0) then begin
            Result := SetStatus(STS_ERROR, 'GEN0001', 'Não foi possivel gravar chave pública!', cDS_METHOD);
            return(-1); exit;
          end;
        end;
        if (item_f('CD_CHAVE', tGLB_CHAVE) = 2) then begin
          vDsChavePrivada := item_f('VL_CHAVE', tGLB_CHAVE);
          filedump '' + vDsChavePrivada', + ' '' + vDsPathChavePrivadaStoreage + '.txt';
          if (xStatus < 0) then begin
            Result := SetStatus(STS_ERROR, 'GEN0001', 'Não foi possivel gravar chave privada!', cDS_METHOD);
            return(-1); exit;
          end;
        end;
        setocc(tGLB_CHAVE, curocc(tGLB_CHAVE) + 1);
      end;
    end;
  end;

  spawn '#EAD.exe ' + vDsArquivo + ' ' + vDsPathChavepublicaStoreage + '.txt ' + vDsPathChavePrivadaStoreage + '.txt';
  refresh;

  voParams := activateCmp('vbfileman', 'arqexiste', viParams); (*vFlag,'' + vDsNomeArquivo' + ' *)
  if (vFlag) then begin
    voParams := activateCmp('vbfileman', 'apagaarquivo', viParams); (*'' + vDsNomeArquivo' + ' *)
  end;

  voParams := activateCmp('vbfileman', 'arqexiste', viParams); (*vFlag,'' + vDsPathChavepublicaStoreage + '.txt' *)
  if (vFlag) then begin
    voParams := activateCmp('vbfileman', 'apagaarquivo', viParams); (*'' + vDsPathChavepublicaStoreage + '.txt' *)
  end;

  voParams := activateCmp('vbfileman', 'arqexiste', viParams); (*vFlag,'' + vDsPathChavePrivadaStoreage + '.txt' *)
  if (vFlag) then begin
    voParams := activateCmp('vbfileman', 'apagaarquivo', viParams); (*'' + vDsPathChavePrivadaStoreage + '.txt' *)
  end;
  if (vDsNomeArquivo <> '') then begin
    voParams := activateCmp('vbfileman', 'movearquivo', viParams); (*vEOF,'' + vDsArquivo','' + vDsNomeArquivo' + ' + ' *)
    if (xStatus < 0) then begin
      Result := voParams;
      return(-1); exit;
    end;
  end;

  vDsMensagem := '';
  vDsMensagem := 'Processo concluído com sucesso.';
  if (vDsNomeArquivo <> '') then begin
    vDsMensagem := '' + vDsMensagemArquivo + ' digital salvo em ' + vDsNomeArquivo' + ';
  end else begin
    vDsMensagem := '' + vDsMensagemArquivo + ' digital salvo em ' + vDsArquivo' + ';
  end;
  putitemXml(Result, 'DS_MENSAGEM', vDsMensagem);

  return(0); exit;
end;

//----------------------------------------------------------
function T_ECFSVCO011.extrairCOO(pParams : String) : String;
//----------------------------------------------------------
const
  cDS_METHOD = 'ADICIONAL=Operação: T_ECFSVCO011.extrairCOO()';
var
  viParams, voParams, vDsArquivo, vCOO, poDsLogErro, vDsLinha, vEOF : String;
  vFlag : Boolean;
begin
  vDsArquivo := itemXml('DS_ARQUIVO', pParams);

  message/hint 'Efetuando leitura da MFD...';

  voParams := activateCmp('vbfileman', 'arqexiste', viParams); (*vFlag,vDsArquivo *)
  if (vFlag = True) then begin
    voParams := activateCmp('vbfileman', 'filename', viParams); (*vDsArquivo *)
    if (xStatus < 0) then begin
      Result := SetStatus(STS_ERROR, 'GEN0001', 'Problema ao abrir arquivo ' + vDsArquivo + '!', cDS_METHOD);
      poDsLogErro := '' + poDsLogErro' + xCtxErro' + ' + ';
      return(-1); exit;
    end;

    repeat
      voParams := activateCmp('vbfileman', 'learquivo', viParams); (*vDsLinha *)
      if (xStatus < 0) then begin
        Result := SetStatus(STS_ERROR, 'GEN0001', 'Problema ao ler arquivo ' + vDsArquivo + '!', cDS_METHOD);
        poDsLogErro := '' + poDsLogErro' + xCtxErro' + ' + ';
        return(-1); exit;
      end;

      voParams := extraiValor(viParams); (* 'COO:', vDsLinha, vCOO *)

      voParams := activateCmp('vbfileman', 'eof', viParams); (*vEOF *)
      if (xStatus < 0) then begin
        Result := SetStatus(STS_ERROR, 'GEN0001', 'Problema ao ler status arquivo ' + vDsArquivo + '!', cDS_METHOD);
        poDsLogErro := '' + poDsLogErro' + xCtxErro' + ' + ';
        return(-1); exit;
      end;
    until (vEOF := -1);
  end;

  putitemXml(Result, 'DS_COOINI', gvCOOINI);
  putitemXml(Result, 'DS_COOFIM', gvCOOFIM);
  putitemXml(Result, 'DS_DATAINI', gvDtInicial);
  putitemXml(Result, 'DS_DATAFIM', gvDtEmissao);

  return(0); exit;
end;

//-------------------------------------------------------------------
function T_ECFSVCO011.efetuaLeituraArqMFD(pParams : String) : String;
//-------------------------------------------------------------------
const
  cDS_METHOD = 'ADICIONAL=Operação: T_ECFSVCO011.efetuaLeituraArqMFD()';
var
  viParams, voParams, vDsDadoINI, vDsDadoFIM, vDsConteudo, vDsArquivo, poDsLogErro, vEOF, vDsLinha, vDsMeioPagto, vVlFormaPagto : String;
  vDsPagamento, vDsLstPagamento, vDsRegistro, vSimbDoc, vDsPath : String;
  vCOO, vCCF, vCDC, vGRG, vGNF, vDsValor, vNrContadorRed, vQtTentativa : Real;
  vNrTpDownload : Real;
  vFlag : Boolean;
begin
  vDsDadoIni := itemXml('DS_DADOINI', pParams);
  vDsDadoFIM := itemXml('DS_DADOFIM', pParams);
  vNrTpDownload := itemXmlF('NR_TPDOWNLOAD', pParams);

  vDsPath := itemXml('DS_UNIDTERMINAL', PARAM_GLB);
  vDsPath := '' + vDsPath:\ECF\' + ';

  message/hint 'Efetuando download da MFD...';
  viParams := '';

  putitemXml(viParams, 'DS_ARQUIVO', 'C:\ECF\DOWNLOAD.MFD');

  if (vNrTpDownload = 1) then begin
    gDataINI := vDsDadoIni;
    gDataFIM := vDsDadoFIM;
    putitemXml(viParams, 'TP_DOWNLOAD', '1');
    putitemXml(viParams, 'DS_DADOINI', '' + gDataINI') + ';
    putitemXml(viParams, 'DS_DADOFIM', '' + gDataFIM') + ';
  end else if (vNrTpDownload = 2) then begin
    putitemXml(viParams, 'TP_DOWNLOAD', '2');
    putitemXml(viParams, 'DS_DADOINI', vDsDadoIni);
    putitemXml(viParams, 'DS_DADOFIM', vDsDadoFIM);
    putitemXml(viParams, 'NR_USUARIO', '1');
  end else begin
    putitemXml(viParams, 'TP_DOWNLOAD', '0');
  end;
  putitemXml(viParams, 'TP_FORMATO', '0');

  voParams := activateCmp('ECFSVCO011', 'downloadMFD', viParams); (*,,, *)
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
    return(-1); exit;
  end else if (xStatus < 0) then begin
    Result := voParams;
    return(-1); exit;
  end;

  vDsConteudo := '';
  vQtTentativa := 0;

  vDsArquivo := '' + vDsPathDOWNLOAD + '.TXT';

  voParams := activateCmp('vbfileman', 'arqexiste', viParams); (*vFlag,vDsArquivo *)
  if (vFlag = True) then begin
    voParams := activateCmp('KERNEL32', 'SLEEP', viParams); (*2000 *)

    voParams := activateCmp('vbfileman', 'filename', viParams); (*vDsArquivo *)
    if (xStatus < 0) then begin
      Result := SetStatus(STS_ERROR, 'GEN0001', 'Problema ao abrir arquivo ' + vDsArquivo + '!', cDS_METHOD);
      poDsLogErro := '' + poDsLogErro' + xCtxErro' + ' + ';
      return(-1); exit;
    end;

    vCOO := 0;
    vCCF := 0;
    VCOO := 0;
    vCDC := 0;
      vGRG := 0;
    vGNF := 0;
    vNrContadorRed := 0;
    vDsPagamento := '';
    vDsLstPagamento := '';
    vDsRegistro := '';
    vSimbDoc := '';
    repeat
      voParams := activateCmp('vbfileman', 'learquivo', viParams); (*vDsLinha *)
      if (xStatus < 0) then begin
        Result := SetStatus(STS_ERROR, 'GEN0001', 'Problema ao ler arquivo ' + vDsArquivo + '!', cDS_METHOD);
        poDsLogErro := '' + poDsLogErro' + xCtxErro' + ' + ';
        return(-1); exit;
      end;

      voParams := extraiValor(viParams); (* 'COO:', vDsLinha, vDsValor *)
      if (xStatus < 0) then begin
        Result := voParams;
        return(-1); exit;
      end;
      if (vDsValor <> 0) then begin
        vCOO := vDsValor;
      end;

      voParams := extraiValor(viParams); (* 'CCF:', vDsLinha, vDsValor *)
      if (xStatus < 0) then begin
        Result := voParams;
        return(-1); exit;
      end;
      if (vDsValor <> 0) then begin
        vCCF := vDsValor;
      end;

      voParams := extraiValor(viParams); (* 'CDC:', vDsLinha, vDsValor *)
      if (xStatus < 0) then begin
        Result := voParams;
        return(-1); exit;
      end;
      if (vDsValor <> 0) then begin
        vCDC := vDsValor;
      end;

      voParams := extraiValor(viParams); (* 'GRG:', vDsLinha, vDsValor *)
      if (xStatus < 0) then begin
        Result := voParams;
        return(-1); exit;
      end;
      if (vDsValor <> 0) then begin
        vGRG := vDsValor;
      end;

      voParams := extraiValor(viParams); (* 'GNF:', vDsLinha, vDsValor *)
      if (xStatus < 0) then begin
        Result := voParams;
        return(-1); exit;
      end;
      if (vDsValor <> 0) then begin
        vGNF := vDsValor;
      end;
      if (vDsLinha[1:10] = 'QQQQQQQQQQ') then begin
        gvDtFinalEmissao := vDsLinha[20:10];
        gvHrFinalEmissao := vDsLinha[31:8];
      end;
      if (vDsLinha[1:8] = 'Dinheiro') then begin
        vDsMeioPagto := 'Dinheiro';
        vVlFormaPagto := vDsLinha[20:50];
        vVlFormaPagto := greplace(vVlFormaPagto, 1, ' ', '', -1);
        vVlFormaPagto := greplace(vVlFormaPagto, 1, '.', '', -1);
        vVlFormaPagto := greplace(vVlFormaPagto, 1, ', ', '.', -1);

        putitemXml(vDsPagamento, 'DS_MEIOPAGTO', vDsMeioPagto);
        putitemXml(vDsPagamento, 'VL_FORMAPAGTO', vVlFormaPagto);
        putitem(vDsLstPagamento,  vDsPagamento);
      end;
      if (vDsLinha[1:6] = 'Cheque') then begin
        vDsMeioPagto := 'Cheque';
        vVlFormaPagto := vDsLinha[20:50];
        vVlFormaPagto := greplace(vVlFormaPagto, 1, ' ', '', -1);
        vVlFormaPagto := greplace(vVlFormaPagto, 1, '.', '', -1);
        vVlFormaPagto := greplace(vVlFormaPagto, 1, ', ', '.', -1);

        putitemXml(vDsPagamento, 'DS_MEIOPAGTO', vDsMeioPagto);
        putitemXml(vDsPagamento, 'VL_FORMAPAGTO', vVlFormaPagto);
        putitem(vDsLstPagamento,  vDsPagamento);
      end;
      if (vDsLinha[1:6] = 'Cartao') then begin
        vDsMeioPagto := 'Cartao';
        vVlFormaPagto := vDsLinha[20:50];
        vVlFormaPagto := greplace(vVlFormaPagto, 1, ' ', '', -1);
        vVlFormaPagto := greplace(vVlFormaPagto, 1, '.', '', -1);
        vVlFormaPagto := greplace(vVlFormaPagto, 1, ', ', '.', -1);

        putitemXml(vDsPagamento, 'DS_MEIOPAGTO', vDsMeioPagto);
        putitemXml(vDsPagamento, 'VL_FORMAPAGTO', vVlFormaPagto);
        putitem(vDsLstPagamento,  vDsPagamento);
      end;
      if (vDsLinha[1:14] = 'Cartao credito') then begin
        vDsMeioPagto := 'Cartao credito';
        vVlFormaPagto := vDsLinha[20:50];
        vVlFormaPagto := greplace(vVlFormaPagto, 1, ' ', '', -1);
        vVlFormaPagto := greplace(vVlFormaPagto, 1, '.', '', -1);
        vVlFormaPagto := greplace(vVlFormaPagto, 1, ', ', '.', -1);

        putitemXml(vDsPagamento, 'DS_MEIOPAGTO', vDsMeioPagto);
        putitemXml(vDsPagamento, 'VL_FORMAPAGTO', vVlFormaPagto);
        putitem(vDsLstPagamento,  vDsPagamento);
      end;
      if (vDsLinha[1:13] = 'Cartao debito') then begin
        vDsMeioPagto := 'Cartao debito';
        vVlFormaPagto := vDsLinha[20:50];
        vVlFormaPagto := greplace(vVlFormaPagto, 1, ' ', '', -1);
        vVlFormaPagto := greplace(vVlFormaPagto, 1, '.', '', -1);
        vVlFormaPagto := greplace(vVlFormaPagto, 1, ', ', '.', -1);

        putitemXml(vDsPagamento, 'DS_MEIOPAGTO', vDsMeioPagto);
        putitemXml(vDsPagamento, 'VL_FORMAPAGTO', vVlFormaPagto);
        putitem(vDsLstPagamento,  vDsPagamento);
      end;
      if (vDsLinha[1:6] = 'Fatura') then begin
        vDsMeioPagto := 'Fatura';
        vVlFormaPagto := vDsLinha[20:50];
        vVlFormaPagto := greplace(vVlFormaPagto, 1, ' ', '', -1);
        vVlFormaPagto := greplace(vVlFormaPagto, 1, '.', '', -1);
        vVlFormaPagto := greplace(vVlFormaPagto, 1, ', ', '.', -1);

        putitemXml(vDsPagamento, 'DS_MEIOPAGTO', vDsMeioPagto);
        putitemXml(vDsPagamento, 'VL_FORMAPAGTO', vVlFormaPagto);
        putitem(vDsLstPagamento,  vDsPagamento);
      end;
      if (vDsLinha[1:12] = 'Adiantamento') then begin
        vDsMeioPagto := 'Adiantamento';
        vVlFormaPagto := vDsLinha[20:50];
        vVlFormaPagto := greplace(vVlFormaPagto, 1, ' ', '', -1);
        vVlFormaPagto := greplace(vVlFormaPagto, 1, '.', '', -1);
        vVlFormaPagto := greplace(vVlFormaPagto, 1, ', ', '.', -1);

        putitemXml(vDsPagamento, 'DS_MEIOPAGTO', vDsMeioPagto);
        putitemXml(vDsPagamento, 'VL_FORMAPAGTO', vVlFormaPagto);
        putitem(vDsLstPagamento,  vDsPagamento);
      end;
      if (vDsLinha[1:15] = 'Cartao de debit') then begin
        vDsMeioPagto := 'Cartao de debit';
        vVlFormaPagto := vDsLinha[20:50];
        vVlFormaPagto := greplace(vVlFormaPagto, 1, ' ', '', -1);
        vVlFormaPagto := greplace(vVlFormaPagto, 1, '.', '', -1);
        vVlFormaPagto := greplace(vVlFormaPagto, 1, ', ', '.', -1);

        putitemXml(vDsPagamento, 'DS_MEIOPAGTO', vDsMeioPagto);
        putitemXml(vDsPagamento, 'VL_FORMAPAGTO', vVlFormaPagto);
        putitem(vDsLstPagamento,  vDsPagamento);
      end;
      if (vDsLinha[1:12] = 'Cartao teste') then begin
        vDsMeioPagto := 'Cartao teste';
        vVlFormaPagto := vDsLinha[20:50];
        vVlFormaPagto := greplace(vVlFormaPagto, 1, ' ', '', -1);
        vVlFormaPagto := greplace(vVlFormaPagto, 1, '.', '', -1);
        vVlFormaPagto := greplace(vVlFormaPagto, 1, ', ', '.', -1);

        putitemXml(vDsPagamento, 'DS_MEIOPAGTO', vDsMeioPagto);
        putitemXml(vDsPagamento, 'VL_FORMAPAGTO', vVlFormaPagto);
        putitem(vDsLstPagamento,  vDsPagamento);
      end;
      if (vDsLinha[1:6] = 'T.E.F.') then begin
        vDsMeioPagto := 'T.E.F.';
        vVlFormaPagto := vDsLinha[20:50];
        vVlFormaPagto := greplace(vVlFormaPagto, 1, ' ', '', -1);
        vVlFormaPagto := greplace(vVlFormaPagto, 1, '.', '', -1);
        vVlFormaPagto := greplace(vVlFormaPagto, 1, ', ', '.', -1);

        putitemXml(vDsPagamento, 'DS_MEIOPAGTO', vDsMeioPagto);
        putitemXml(vDsPagamento, 'VL_FORMAPAGTO', vVlFormaPagto);
        putitem(vDsLstPagamento,  vDsPagamento);
      end;
      if (vDsLinha[1:15] = 'Receb. de Fatur') then begin
        vDsMeioPagto := 'Receb. de Fatur';
        vVlFormaPagto := vDsLinha[20:50];
        vVlFormaPagto := greplace(vVlFormaPagto, 1, ' ', '', -1);
        vVlFormaPagto := greplace(vVlFormaPagto, 1, '.', '', -1);
        vVlFormaPagto := greplace(vVlFormaPagto, 1, ', ', '.', -1);

        putitemXml(vDsPagamento, 'DS_MEIOPAGTO', vDsMeioPagto);
        putitemXml(vDsPagamento, 'VL_FORMAPAGTO', vVlFormaPagto);
        putitem(vDsLstPagamento,  vDsPagamento);
      end;
      if (vDsLinha[1:15] = 'Cancel. Recebim') then begin
        vDsMeioPagto := 'Cancel. Recebim';
        vVlFormaPagto := vDsLinha[20:50];
        vVlFormaPagto := greplace(vVlFormaPagto, 1, ' ', '', -1);
        vVlFormaPagto := greplace(vVlFormaPagto, 1, '.', '', -1);
        vVlFormaPagto := greplace(vVlFormaPagto, 1, ', ', '.', -1);

        putitemXml(vDsPagamento, 'DS_MEIOPAGTO', vDsMeioPagto);
        putitemXml(vDsPagamento, 'VL_FORMAPAGTO', vVlFormaPagto);
        putitem(vDsLstPagamento,  vDsPagamento);
      end;
      if (vDsLinha[1:6] = 'CREDEV') then begin
        vDsMeioPagto := 'CREDEV';
        vVlFormaPagto := vDsLinha[20:50];
        vVlFormaPagto := greplace(vVlFormaPagto, 1, ' ', '', -1);
        vVlFormaPagto := greplace(vVlFormaPagto, 1, '.', '', -1);
        vVlFormaPagto := greplace(vVlFormaPagto, 1, ', ', '.', -1);

        putitemXml(vDsPagamento, 'DS_MEIOPAGTO', vDsMeioPagto);
        putitemXml(vDsPagamento, 'VL_FORMAPAGTO', vVlFormaPagto);
        putitem(vDsLstPagamento,  vDsPagamento);
      end;
      if (vDsLinha[3:19] = 'RELATÓRIO GERENCIAL') then begin
        vSimbDoc := 'RG';
      end;
      if (vDsLinha[8:9] = 'LEITURA X') then begin
        vSimbDoc := 'RG';
      end;
      if (vDsLinha[10:39] = 'COMPROVANTE CRÉDITO OU DÉBITO') then begin
        vSimbDoc := 'CC';
      end;
      if (vDsLinha[2:22] = 'COMPROVANTE NÃO-FISCAL') then begin
        vSimbDoc := 'CN';
      end;
      if (vDsLinha[1:23] = 'Contador de Reduções Z:') then begin
        vNrContadorRed := vDslinha[43:6];
      end;
      if (vDsLinha = 'FAB:BE050769200004007241                     BR') then begin
        clear_e(tFIS_ECF);
        putitem_o(tFIS_ECF, 'CD_EMPRESA', itemXmlF('CD_EMPRESA', PARAM_GLB));
        putitem_o(tFIS_ECF, 'CD_SERIEFAB', itemXmlF('CD_SERIEECF', PARAM_GLB));
        retrieve_e(tFIS_ECF);

        creocc(tFIS_DNF, -1);
        putitem_e(tFIS_DNF, 'CD_EMPRESA', itemXmlF('CD_EMPRESA', PARAM_GLB));
        putitem_e(tFIS_DNF, 'NR_ECF', item_f('NR_ECF', tFIS_ECF));
        putitem_e(tFIS_DNF, 'DT_EMISSAO', gvDtEmissao);
        putitem_e(tFIS_DNF, 'NR_COO', vCOO);
        retrieve_o(tFIS_DNF);
        if (xStatus = -7) then begin
          retrieve_x(tFIS_DNF);
        end;
        putitem_e(tFIS_DNF, 'CD_OPERADOR', itemXmlF('CD_USUARIO', PARAM_GLB));
        putitem_e(tFIS_DNF, 'DT_CADASTRO', Now);
        putitem_e(tFIS_DNF, 'TP_SIMBDOC', vSimbDoc);
        putitem_e(tFIS_DNF, 'NR_GNF', vGNF);
        putitem_e(tFIS_DNF, 'NR_GRG', vGRG);
        putitem_e(tFIS_DNF, 'NR_CDC', vCDC);
        putitem_e(tFIS_DNF, 'NR_REDUCAOZ', vNrContadorRed);
        putitem_e(tFIS_DNF, 'DT_FINALEMISSAO', gvDtFinalEmissao);
        putitem_e(tFIS_DNF, 'HR_FINALEMISSAO', gvHrFinalEmissao);

        if (vDsLstPagamento<> '') then begin
        repeat
          getitem(vDsRegistro, vDsLstPagamento, 1);
          creocc(tFIS_MPGTO, -1);
          putitem_e(tFIS_MPGTO, 'CD_EMPRESA', itemXmlF('CD_EMPRESA', PARAM_GLB));
          putitem_e(tFIS_MPGTO, 'NR_ECF', item_f('NR_ECF', tFIS_ECF));
          putitem_e(tFIS_MPGTO, 'DT_EMISSAO', gvDtEmissao);
          putitem_e(tFIS_MPGTO, 'NR_COO', vCOO);
          putitem_e(tFIS_MPGTO, 'DS_MPGTO', itemXml('DS_MEIOPAGTO', vDsRegistro));
          retrieve_o(tFIS_MPGTO);
          if (xStatus = -7) then begin
            retrieve_x(tFIS_MPGTO);
          end;
          putitem_e(tFIS_MPGTO, 'CD_OPERADOR', itemXmlF('CD_USUARIO', PARAM_GLB));
          putitem_e(tFIS_MPGTO, 'DT_CADASTRO', Now);
          putitem_e(tFIS_MPGTO, 'NR_CCF', vCCF);
          putitem_e(tFIS_MPGTO, 'NR_GNF', vGNF);
          putitem_e(tFIS_MPGTO, 'VL_PAGO', itemXmlF('VL_FORMAPAGTO', vDsRegistro));
          putitem_e(tFIS_MPGTO, 'TP_ESTORNO', 'N');
          putitem_e(tFIS_MPGTO, 'VL_ESTORNADO', 0);

          delitem(vDsLstPagamento, 1);
          until (vDsLstPagamento= '');
        end;

        vCOO := 0;
        vCCF := 0;
        VCOO := 0;
        vCDC := 0;
            vGRG := 0;
        vGNF := 0;
        vNrContadorRed := 0;
        vDsPagamento := '';
        vDsLstPagamento := '';
        vDsRegistro := '';
        vSimbDoc := '';
          end;

      voParams := activateCmp('vbfileman', 'eof', viParams); (*vEOF *)
      if (xStatus < 0) then begin
        Result := SetStatus(STS_ERROR, 'GEN0001', 'Problema ao ler status arquivo ' + vDsArquivo + '!', cDS_METHOD);
        poDsLogErro := '' + poDsLogErro' + xCtxErro' + ' + ';
        return(-1); exit;
      end;
    until (vEOF := -1);

  end;

  voParams := tFIS_DNF.Salvar();
  if (xStatus < 0) then begin
    Result := voParams;
    return(-1); exit;
  end;

  putitemXml(Result, 'DS_PATH', vDsPath);

  return(0); exit;
end;

//--------------------------------------------------------------
function T_ECFSVCO011.retornaPathECF(pParams : String) : String;
//--------------------------------------------------------------
const
  cDS_METHOD = 'ADICIONAL=Operação: T_ECFSVCO011.retornaPathECF()';
var
  vDsPath : String;
begin
  vDsPath := itemXml('DS_UNIDTERMINAL', PARAM_GLB);
  vDsPath := '' + vDsPath:\ECF\' + ';

  putitemXml(Result, 'DS_PATH', vDsPath);

  return(0); exit;
end;

//------------------------------------------------------------
function T_ECFSVCO011.geraAtoCotep(pParams : String) : String;
//------------------------------------------------------------
const
  cDS_METHOD = 'ADICIONAL=Operação: T_ECFSVCO011.geraAtoCotep()';
var
  vDsArquivoMFD, vDsArquivoTXT, vTpDownload, vDadoINI, vDadoFIM, vDsRazao, vDsendereco, vDsPath, vEOF, vDsConteudo : String;
  status, vQtTentativa : Real;
  vFlag : Boolean;
begin
  vDsPath := itemXml('DS_UNIDTERMINAL', PARAM_GLB);
  vDsPath := '' + vDsPath:\ECF\' + ';
  xStatus := 0;

  vDsArquivoMFD := itemXml('DS_ARQMFD', pParams);
  vDsArquivoTXT := itemXml('DS_ARQTXT', pParams);
  vDadoINI := itemXml('DS_DADOINI', pParams);
  vDadoFIM := itemXml('DS_DADOFIM', pParams);
  vDsRazao := itemXml('DS_RAZAO', pParams);
  vDsendereco := itemXml('DS_endERECO', pParams);
  vTpDownload := itemXmlF('TP_DOWNLOAD', pParams);

  vDsArquivoMFD := '' + vDsPath' + vDsArquivoMFD' + ' + ';

  vDsArquivoTXT := '' + vDsPath' + vDsArquivoTXT' + ' + ';

  voParams := espacoDireita(viParams); (* vDsArquivoMFD, 35, vDsArquivoMFD *)
  if (xStatus < 0) then begin
    Result := voParams;
    return(-1); exit;
  end;

  voParams := espacoDireita(viParams); (* vDsArquivoTXT, 35, vDsArquivoTXT *)
  if (xStatus < 0) then begin
    Result := voParams;
    return(-1); exit;
  end;

  voParams := espacoDireita(viParams); (* vDadoINI, 6, vDadoINI *)
  if (xStatus < 0) then begin
    Result := voParams;
    return(-1); exit;
  end;

  voParams := espacoDireita(viParams); (* vDadoFIM, 6, vDadoFIM *)
  if (xStatus < 0) then begin
    Result := voParams;
    return(-1); exit;
  end;

  voParams := espacoDireita(viParams); (* vDsRazao, 30, vDsRazao *)
  if (xStatus < 0) then begin
    Result := voParams;
    return(-1); exit;
  end;

  voParams := espacoDireita(viParams); (* vDsendereco, 30, vDsendereco *)
  if (xStatus < 0) then begin
    Result := voParams;
    return(-1); exit;
  end;

  voParams := activateCmp('vbfileman', 'arqexiste', viParams); (*vFlag,'' + vDsPathRETORNOECF + '.TXT' *)
  if (vFlag = True) then begin
    voParams := activateCmp('vbfileman', 'apagaarquivo', viParams); (*'' + vDsPathRETORNOECF + '.TXT' *)
  end;

  filedump '044' + vDsArquivoMFD' + vDsArquivoTXT' + vDadoINI' + vDadoFIM' + vDsRazao' + vDsendereco' + FloatToStr(vTpDownload',) + ' + ' + ' + ' + ' + ' + ' '' + vDsPathMFD + '.TMP';

  if (xStatus < 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Falha na gravação de arquivos na máquina check in!', cDS_METHOD);
    return(-1); exit;
  end;

  voParams := activateCmp('vbfileman', 'movearquivo', viParams); (*vEOF,'' + vDsPathMFD + '.TMP','' + vDsPathMFD + '.TXT' *)
  if (xStatus < 0) then begin
    Result := voParams;
    return(-1); exit;
  end;

  voParams := activateCmp('KERNEL32', 'SLEEP', viParams); (*40000 *)
  vDsConteudo := '';
  vQtTentativa := 0;
  repeat
    voParams := activateCmp('KERNEL32', 'SLEEP', viParams); (*1000 *)
    voParams := activateCmp('vbfileman', 'arqexiste', viParams); (*vFlag,'' + vDsPathDOWNLOAD + '.MFD' *)
    if (vFlag = False) then begin
      break;
    end;

    voParams := activateCmp('vbfileman', 'arqexiste', viParams); (*vFlag,'' + vDsPathRETORNOECF + '.TXT' *)
    if (vFlag = True) then begin
      break;
    end;

    vQtTentativa := vQtTentativa + 1;
    if (vQtTentativa > 50000) then begin
      Result := SetStatus(STS_ERROR, 'GEN0001', 'Falha na comunicação tempo de resposta esgotado para máquina check in!', cDS_METHOD);
      voParams := activateCmp('vbfileman', 'apagaarquivo', viParams); (*'' + vDsPathMFD + '.TXT' *)
      if (xStatus < 0) then begin
        Result := voParams;
        return(-1); exit;
      end;
      return(-1); exit;
    end;
  until (vDsConteudo <> '');

  voParams := activateCmp('vbfileman', 'arqexiste', viParams); (*vFlag,'' + vDsPathRETORNOECF + '.TXT' *)
  if (vFlag = True) then begin
    voParams := activateCmp('vbfileman', 'apagaarquivo', viParams); (*'' + vDsPathRETORNOECF + '.TXT' *)
    if (xStatus < 0) then begin
      Result := voParams;
      return(-1); exit;
    end;
  end;

  length vDsConteudo;
  Status := vDsConteudo[1, 4];
  if (Status = -1) then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', '' + vDsConteudo[ + '5, gresult]', cDS_METHOD);
    voParams := activateCmp('vbfileman', 'apagaarquivo', viParams); (*'' + vDsPathRETORNOECF + '.TXT' *)
    if (xStatus < 0) then begin
      Result := voParams;
      return(-1); exit;
    end;

    return(-1); exit;
  end else begin
    voParams := setDisplay(viParams); (* '' + vDsConteudo[ + '5, gresult]', '', '' *)
    if (xStatus < 0) then begin
      Result := voParams;
      return(-1); exit;
    end;
  end;

  voParams := activateCmp('vbfileman', 'apagaarquivo', viParams); (*'' + vDsPathRETORNOECF + '.TXT' *)
  if (xStatus < 0) then begin
    Result := voParams;
    return(-1); exit;
  end;

  putitemXml(Result, 'DS_PATH', vDsPath);

  return(0); exit;

end;

//--------------------------------------------------------------------
function T_ECFSVCO011.verificaDocVinculado(pParams : String) : String;
//--------------------------------------------------------------------
const
  cDS_METHOD = 'ADICIONAL=Operação: T_ECFSVCO011.verificaDocVinculado()';
var
  vEOF, vDsLinha, vDsRetorno, vDsPath, vDsConteudo, viParams, voParams : String;
  vDsLista, vDsRegistro, vNrCupom, vNrSerieEcf : String;
  vQtTentativa, Status : Real;
  vFlag : Boolean;
begin
  vDsPath := itemXml('DS_UNIDTERMINAL', PARAM_GLB);
  vDsPath := '' + vDsPath:\ECF\' + ';
  xStatus := 0;

  vNrCupom := itemXmlF('NR_CUPOM', pParams);
  vNrSerieEcf := itemXmlF('NR_SERIE', pParams);

  if (vNrCupom = '') then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Número do COO do cupom não informado!', cDS_METHOD);
    return(-1); exit;
  end;
  if (vNrSerieEcf = '') then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Número de série da ECF não informado!', cDS_METHOD);
    return(-1); exit;
  end;

  voParams := preencheZero(viParams); (* vNrCupom, 6, vNrCupom *)

  voParams := espacoDireita(viParams); (* vNrSerieEcf, 20, vNrSerieEcf *)

  filedump '136' + FloatToStr(vNrCupom' + FloatToStr(vNrSerieEcf',)) + ' + ' '' + vDsPathECF + '.TMP';
  if (xStatus < 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Falha na gravação de arquivos na máquina check in!', cDS_METHOD);
    return(-1); exit;
  end;

  voParams := activateCmp('vbfileman', 'movearquivo', viParams); (*vEOF,'' + vDsPathECF + '.TMP','' + vDsPathECF + '.TXT' *)
  if (xStatus < 0) then begin
    Result := voParams;
    return(-1); exit;
  end;

  vDsConteudo := '';
  vQtTentativa := 0;
  repeat

    fileload '' + vDsPathRETORNOECF + '.TXT', vDsConteudo;
    if (xStatus < 0) then begin
      Result := voParams;
      return(-1); exit;
    end;
        if (xStatus < 0) then begin
          Result := voParams;
          return(-1); exit;
        end;
        return(-1); exit;
      end;
    end;

  until (vDsConteudo <> '');

  length vDsConteudo;
  Status := vDsConteudo[1, 4];
  if (Status = -1) then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', '' + vDsConteudo[ + '5, gresult]', cDS_METHOD);
    voParams := activateCmp('vbfileman', 'apagaarquivo', viParams); (*'' + vDsPathRETORNOECF + '.TXT' *)
    if (xStatus < 0) then begin
      Result := voParams;
      return(-1); exit;
    end;

    return(-1); exit;
  end else begin
    voParams := setDisplay(viParams); (* '' + vDsConteudo[ + '5, gresult]', '', '' *)
    if (xStatus < 0) then begin
      Result := voParams;
      return(-1); exit;
    end;
  end;

  voParams := activateCmp('vbfileman', 'filename', viParams); (*'' + vDsPathRETORNOECF + '.TXT' *)
  if (xStatus < 0) then begin
    Result := voParams;
    return(-1); exit;
  end;

  repeat

    voParams := activateCmp('vbfileman', 'learquivo', viParams); (*vDsLinha *)
    if (xStatus < 0) then begin
      Result := voParams;
      return(-1); exit;
    end;

    vDsRetorno := itemXmlF('NR_COOVINCULADO', vDsLinha);
    length(vDsRetorno);
    if (gresult > 0) then begin
      putitemXml(Result, 'NR_COOVINCULADO', vDsRetorno);
    end;

    voParams := activateCmp('vbfileman', 'eof', viParams); (*vEOF *)
    if (xStatus < 0) then begin
      Result := voParams;
      return(-1); exit;
    end;

  until (vEOF := -1);

  voParams := activateCmp('vbfileman', 'apagaarquivo', viParams); (*'' + vDsPathRETORNOECF + '.TXT' *)
  if (xStatus < 0) then begin
    Result := voParams;
    return(-1); exit;
  end;

  return(0); exit;
end;

end.
