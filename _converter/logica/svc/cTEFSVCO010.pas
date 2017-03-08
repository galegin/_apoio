unit cTEFSVCO010;

interface

(* COMPONENTES 
  ADMSVCO001 / ECFSVCO011 / GERSVCO100 / KERNEL32 / vbfileman
  WINAPI / 
*)

uses
  SysUtils, Math;

type
  T_TEFSVCO010 = class
  published
    function geraArquivoREQ(pParams : String = '') : String;
    function buscaDadoCartao(pParams : String = '') : String;
    function buscaViaCartao(pParams : String = '') : String;
  end;

implementation

uses
  cADMSVCO001,
  cActivate, cDataSetUnf, cStatus, cFuncao, cXml, dModulo;

const
  PADRAO_BEMATECH = 1;
  PADRAO_AFRAC = 2;
  PADRAO_YANCO = 3;
  PADRAO_LOCAL = 99;
  PADRAO_LOCALIMPFIM = 100;

var
  gUnidade,
  gDsArquivo,
  gDsDirReq,
  gDsDirResp : String;

  gHrFim : TDateTime;

  gNrIdentificacao,
  gNrTimeOUT,
  gPadraoECF,
  gTefComunicacaoGP,
  gTpImpressaoTefPaygo,
  gTpTEF : Real;

  gFCX_HISTRELSUB,
  gTEF_ARQUIVO,
  gTEF_CAMPOARQ,
  gTEF_REDETEF,
  gTEF_RELOPER,
  gTEF_TIPOTRANS,
  gTEF_TRANSACAO : String;

  tFCX_HISTRELSUB,
  tTEF_ARQUIVO,
  tTEF_CAMPOARQ,
  tTEF_REDETEF,
  tTEF_RELOPER,
  tTEF_TIPOTRANS,
  tTEF_TRANSACAO : TcDatasetUnf;

  //-------------------------------------------------------------------
  function converteArquivoRESP(pParams : String) : String;
  //-------------------------------------------------------------------
  const
    cDS_METHOD = 'ADICONAL=Operação: T_TEFSVCO010.converteArquivoRESP()';
  var
    piDsConteudo, poDsConteudo,
    vDsLinha, vDsItem, vNmItem, vNmArq, vDirArq, vDsArq : String;
    vNrIdentificacao, vNrLinha : Real;
  begin
    piDsConteudo := pParams;

    if (itemXmlB('IN_LOG_TEMPO_VENDA', PARAM_GLB)) then begin
      gHrFim := Time;
      MensagemLog('TEFSVCO0010.converteArquivoRESP()', 'Inicio converteArquivoRESP: ' + TimeToStr(gHrFim));
    end;

    Result := ''; //SetStatus(<STS_LOG>, 'CFI0002', '',  cDS_METHOD);
    poDsConteudo := '';

    while (piDsConteudo <> '') do begin
      if (Pos(#13, piDsConteudo) > 0) then begin
        vDsLinha := Copy(piDsConteudo, 1, Pos(#13, piDsConteudo) - 1);
        piDsConteudo := Copy(piDsConteudo, Pos(#13, piDsConteudo) + 1, Length(piDsConteudo));
      end else begin
        vDsLinha := piDsConteudo;
        piDsConteudo := '';
      end;
      putitemXml(poDsConteudo, Copy(vDsLinha,1,7), Copy(vDsLinha, 11, Length(vDsLinha)));
      vNrLinha := vNrLinha + 1;
    end;

    if (itemXmlB('IN_LOG_TEMPO_VENDA', PARAM_GLB)) then begin
      gHrFim := Time;
      MensagemLog('TEFSVCO0010.converteArquivoRESP', 'Fim converteArquivoRESP: ' + TimeToStr(gHrFim));
    end;

    Result := poDsConteudo;
    return(0); exit;
  end;

  //-------------------------------------------------------------------
  function recuperaArquivoRESP(pParams : String) : String;
  //-------------------------------------------------------------------
  const
    cDS_METHOD = 'ADICONAL=Operação: T_TEFSVCO010.recuperaArquivoRESP()';
  var
    piDsExtensao, poDsConteudo,
    viParams, voParams, vDsConteudo, vDsArquivo : String;
    vNrIdentificacao, vQtTentativa : Real;
    vInOK, piInTimeOUT : Boolean;
  begin
    piDsExtensao := itemXml('DS_EXTENSAO', pParams);
    piInTimeOUT := itemXmlB('IN_TIMEOUT', pParams);

    if (itemXmlB('IN_LOG_TEMPO_VENDA', PARAM_GLB)) then begin
      gHrFim := Time;
      MensagemLog('TEFSVCO010.recuperaArquivoRESP', 'Inicio recuperaArquivoRESP: ' + TimeToStr(gHrFim));
    end;

    vDsConteudo := '';
    vQtTentativa := 0;
    vDsArquivo := gDsDirResp + gDsArquivo + '.' + piDsExtensao;
    poDsConteudo := '';

    repeat
      vDsConteudo := CarregarArqTxt(vDsArquivo);
      if (vDsConteudo = '') or (xStatus = 0) then begin
        //voParams := activateCmp('KERNEL32', 'SLEEP', '1000');
        Sleep(1000);
        if (piInTimeOUT = True) then begin
          vQtTentativa := vQtTentativa + 1;
          if (vQtTentativa > gNrTimeOUT) then begin
            if (piDsExtensao = 'STS') then begin
              if (gTpTEF = 1) then begin
                Result := SetStatus(STS_ERROR, 'TEF0011', '', '');
              end else begin
                Result := SetStatus(STS_ERROR, 'TEF0002', 'O Gerenciador Padrão não esta ativo.', '');
              end;
            end else begin
              Result := SetStatus(STS_ERROR, 'TEF0005', '',  cDS_METHOD);
            end;
            return(-1); exit;
          end;
        end;
      end else begin
        if (DeleteFile(vDsArquivo)) then begin
          Result := SetStatus(STS_ERROR, 'TEF0004', 'Não foi possível deletar o arquivo ' + vDsArquivo,  cDS_METHOD);
          return(-1); exit;
        end;

        vDsConteudo := converteArquivoRESP(vDsConteudo);
        if (vDsConteudo = '') then begin
          Result := SetStatus(STS_ERROR, 'GEN0001', 'Arquivo de retorno ' + vDsArquivo + 'não possui conteúdo válido!',  cDS_METHOD);
          return(-1); exit;
        end;

        if (piDsExtensao = 'STS') then begin
          vNrIdentificacao := itemXmlF('001-000', vDsConteudo);
          if (vNrIdentificacao <> gNrIdentificacao) then begin
            Result := SetStatus(STS_ERROR, 'GEN0001', 'Identificação do arquivo de retorno diferente do arquivode requisição!',  cDS_METHOD);
            return(-1); exit;
          end;
        end;
        if (gTpTEF = 2) then begin
          if (piDsExtensao = '001') then begin
            vNrIdentificacao := itemXmlF('001-000', vDsConteudo);
            if (vNrIdentificacao <> gNrIdentificacao) then begin
              vDsConteudo := '';
            end;
          end;
        end;
      end;
    until (vDsConteudo <> '');

    poDsConteudo := vDsConteudo;

    if (itemXmlB('IN_LOG_TEMPO_VENDA', PARAM_GLB)) then begin
      gHrFim := Time;
      MensagemLog('TEFSVCO010.recuperaArquivoRESP', 'Fim recuperaArquivoRESP: ' + TimeToStr(gHrFim));
    end;

    return(0); exit;
  end;

  //--------------------------------------------------
  function recuperaUnidade(pParams : String) : String;
  //--------------------------------------------------
  const
    cDS_METHOD = 'ADICONAL=Operação: T_TEFSVCO010.recuperaUnidade()';
  var
    voParams,
    vMapeamento, vUnidade, vDiretorio, vArquivo, vDrive : String;
    vFlag : Boolean;
  begin
    vDrive := pParams;
    if (itemXml('DS_UNIDTERMINAL', PARAM_GLB) <> '') then begin
      vDrive := itemXml('DS_UNIDTERMINAL', PARAM_GLB);
      return(0); exit;
    end;

    if (gTefComunicacaoGP = 1) then begin
      vMapeamento := 'C|D|';
    end else begin
      vMapeamento := 'E|F|G|H|I|J|K|L|M|N|O|P|Q|R|S|T|U|V|X|Z|';
    end;

    repeat
      getitem(vUnidade, vMapeamento, 1);

      vDiretorio := vUnidade + ':\WINDOWS\SYSTEM32';
      vFlag := DirectoryExists(vDiretorio);
      if (vFlag = False) then begin
        vDiretorio := vUnidade + ':\WINNT\SYSTEM32';
        vFlag := DirectoryExists(vDiretorio);
      end;
      if (vFlag = True) then begin
        putitemXml(PARAM_GLB, 'DS_UNIDTERMINAL', vUnidade);
        break;
      end;
      delitem(vMapeamento, 1);
    until (vMapeamento = '');

    vDrive := vUnidade;
    return(0); exit;
  end;

  //------------------------------------------------------------
  function ajustaNmRede(pParams : String) : String;
  //------------------------------------------------------------
  const
    cDS_METHOD = 'ADICONAL=Operação: T_TEFSVCO010.ajustaNmRede()';
  var
    vDsNmRede, vDsByte, vDsResult : String;
    vTam, vNrCont : Integer;
  begin
    vDsNmRede := itemXml('DS_REDE', pParams);

    vTam := length(vDsNmRede);
    vNrCont := vTam;
    repeat
      vDsByte := Copy(vDsNmRede, vNrCont, vNrCont);
      vNrCont := vNrCont - 1;
      if (vDsByte = ' ') then begin
        vDsNmRede := Copy(vDsNmRede, 1, vNrCont);
      end;
    until (vDsByte <> ' ');

    vTam := length(vDsNmRede);
    vNrCont := 1;
    repeat
      vDsByte := Copy(vDsNmRede, vNrCont, vNrCont);
      if (vNrCont = 1) then begin
        vDsResult := '*' + vDsByte;
      end else if (vDsByte = ' ') then begin
        vDsResult := vDsResult + '*|*';
      end else begin
        vDsResult := vDsResult + vDsByte;
      end;
      vNrCont := vNrCont + 1;
    until (vNrCont > vTam);

    vDsNmRede := vDsResult + '*';
    Result := vDsNmRede;
    return(0); exit;
  end;

  //--------------------------------------------------------
  function getParam(pParams : String) : String;
  //--------------------------------------------------------
  const
    cDS_METHOD = 'ADICONAL=Operação: T_TEFSVCO010.getParam()';
  var
    vCdEmpresa : Real;
    viParams, voParams : String;
  begin
    vCdEmpresa := itemXmlF('CD_EMPRESA', PARAM_GLB);

    viParams := '';
    putitem(viParams,  'TEF_TIPO');
    putitem(viParams,  'TEF_ARQ_REQ_DEDICADO');
    putitem(viParams,  'TEF_ARQ_RES_DEDICADO');
    putitem(viParams,  'TEF_ARQ_NOME');
    putitem(viParams,  'TEF_TIMEOUT');
    putitem(viParams,  'PADRAO_ECF');
    putitem(viParams,  'TEF_COMUNICACAO_GP');
    putitem(viParams,  'TP_IMPRESSAO_TEF_PAYGO');
    voParams := T_ADMSVCO001.GetParamEmpresa(vCdEmpresa, viParams);

    gTpImpressaoTefPaygo := itemXmlF('TP_IMPRESSAO_TEF_PAYGO', voParams);
    gPadraoECF := itemXmlF('PADRAO_ECF', voParams);
    gTefComunicacaoGP := itemXmlF('TEF_COMUNICACAO_GP', voParams);
    gTpTEF := itemXmlF('TEF_TIPO', voParams);

    if (gTpTEF = 2) then begin
      gDsDirReq := itemXml('TEF_ARQ_REQ_DIAL', voParams);
      if (gDsDirReq = '') then begin
        recuperaUnidade(gUnidade);
        if (xStatus < 0) then begin
          Result := SetStatus(STS_ERROR, 'GEN0001', 'Não foi possível mapear unidade C:\ !',  cDS_METHOD);
          return(-1); exit;
        end;
        gDsDirReq := gUnidade + ':\TEF_DIAL\REQ\';
      end;
      gDsDirResp := itemXml('TEF_ARQ_RES_DIAL', voParams);
      if (gDsDirResp = '') then begin
         recuperaUnidade(gUnidade);
        if (xStatus < 0) then begin
          Result := SetStatus(STS_ERROR, 'GEN0001', 'Não foi possível mapear unidade C:\ !',  cDS_METHOD);
          return(-1); exit;
        end;
        gDsDirResp := gUnidade + ':\TEF_DIAL\RESP\';
      end;
    end else if (gTpTEF = 1) then begin
      gDsDirReq := itemXml('TEF_ARQ_REQ_DEDICADO', voParams);
      if (gDsDirReq = '') then begin
        recuperaUnidade(gUnidade);
        if (xStatus < 0) then begin
          Result := SetStatus(STS_ERROR, 'GEN0001', 'Não foi possível mapear unidade C:\ !',  cDS_METHOD);
          return(-1); exit;
        end;
        gDsDirReq := gUnidade + ':\CLIENT\REQ\';
      end;
      gDsDirResp := itemXml('TEF_ARQ_RES_DEDICADO', voParams);
      if (gDsDirResp = '') then begin
        recuperaUnidade(gUnidade);
        if (xStatus < 0) then begin
          Result := SetStatus(STS_ERROR, 'GEN0001', 'Não foi possível mapear unidade C:\ !',  cDS_METHOD);
          return(-1); exit;
        end;
        gDsDirResp := gUnidade + ':\CLIENT\RESP\';
      end;
    end;
    gDsArquivo := itemXml('TEF_ARQ_NOME', voParams);
    if (gDsArquivo = '') then begin
      gDsArquivo := 'INTPOS';
    end;
    gNrTimeOUT := itemXmlF('TEF_TIMEOUT', voParams);
    if (gNrTimeOUT = 0) then begin
      gNrTimeOUT := 7;
    end;

    return(0); exit;
  end;

//--------------------------------------------------------------
function T_TEFSVCO010.geraArquivoREQ(pParams : String) : String;
//--------------------------------------------------------------
const
  cDS_METHOD = 'ADICONAL=Operação: T_TEFSVCO010.geraArquivoREQ()';
var
  vCdArquivo, vDsConteudoREQ, vDsConteudoRESP, vDsLinha, vDsValor, vNmRedeTEF : String;
  viParams, voParams, vDsExtensao, vDsArquivo, vDsCampo010, vDsCaminho : String;
  vInP1, vInTimeOUT : Boolean;
  vlValor, vCdEmpresa, vNrSeq : Real;
  vDtMovimento : String;
begin
  if (itemXmlB('IN_LOG_TEMPO_VENDA', PARAM_GLB)) then begin
    gHrFim := Time;
    MensagemLog('TEFSVCO010.geraArquivoREQ', 'Inicio geraArquivoREQ requisição TEF ' + vCdArquivo + ' ' + TimeToStr(gHrFim));
  end;

  getParam(pParams);

  if (gTpTEF <> 1) and (gTpTEF <> 2) then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Parametro p/ empresa TEF_TIPO inválido!',  cDS_METHOD);
    return(-1); exit;
  end;

  if (gTpTEF = 2) then begin
    vDsCaminho := itemXml('DS_CAMINHO', viParams);
    vNmRedeTEF := itemXml('NM_REDETEF', viParams);
    if (itemXml('010-000', viParams) <> '') then begin
      vNmRedeTEF := itemXml('010-000', viParams);
    end;
    if (vDsCaminho = '') then begin
      if (vNmRedeTEF = 'TECBAN') then vDsCaminho := ':\TEF_DISC'
      else if (vNmRedeTEF = 'BANRISUL') then vDsCaminho := ':\TEF_DISC'
      else if (vNmRedeTEF = 'GETNET') then vDsCaminho := ':\TEF_DISC'
      else if (vNmRedeTEF = 'SICREDI') then vDsCaminho := ':\TEF_DISC'
      else if (vNmRedeTEF = 'HCARD') then vDsCaminho := ':\HiperTEF'
      else vDsCaminho := ':\TEF_DIAL';
      gDsDirReq := gUnidade + vDsCaminho + '\REQ\';
      gDsDirResp := gUnidade + vDsCaminho + '\RESP\';
    end else begin
      gDsDirReq := gUnidade + vDsCaminho + '\REQ\';
      gDsDirResp := gUnidade + vDsCaminho + '\RESP\';
    end;
  end;

  if (gDsDirReq = '') then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Diretório de requisição TEF não informado!',  cDS_METHOD);
    return(-1); exit;
  end;
  if (gDsDirResp = '') then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Diretório de resposta TEF não informado!',  cDS_METHOD);
    return(-1); exit;
  end;

  vCdArquivo := itemXml('000-000', viParams);
  if (vCdArquivo = '') then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Campo 000-000 não informado!',  cDS_METHOD);
    return(-1); exit;
  end;

  gNrIdentificacao := itemXmlF('001-000', viParams);
  if (gNrIdentificacao = 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Campo 000-001 não informado!',  cDS_METHOD);
    return(-1); exit;
  end;

  if (gTpTEF = 2) then begin
    vDsValor := itemXml('003-000', viParams);
    vDsValor := ReplaceStr(vDsValor, '.', '');
    vDsValor := ReplaceStr(vDsValor, ', ', '');
    putitemXml(viParams, '003-000', vDsValor);
  end;

  vDsExtensao := itemXml('DS_EXTENSAO', viParams);
  if (vDsExtensao = '') then begin
    vDsExtensao := '001';
  end;

  vInP1 := itemXmlB('IN_P1', viParams);

  vDsArquivo := gDsDirResp + gDsArquivo + '.STS';
  if (FileExists(vDsArquivo)) then DeleteFile(vDsArquivo);

  vDsArquivo := gDsDirResp + gDsArquivo + '.' + vDsExtensao;
  if (FileExists(vDsArquivo)) then DeleteFile(vDsArquivo);

  gTEF_ARQUIVO := '';
  putitemXml(gTEF_ARQUIVO, 'CD_ARQUIVO', vCdArquivo);
  putitemXml(gTEF_ARQUIVO, 'TP_TEF', gTpTEF);
  gTEF_ARQUIVO := gModulo.ConsultarXmlUp('TEF_ARQUIVO', '', gTEF_ARQUIVO);
  if (xStatus < 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Tipo de arquivo ' + vCdArquivo + 'não cadastrado!',  cDS_METHOD);
    return(-1); exit;
  end;

  if (empty(tTEF_CAMPOARQ) <> False) then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Tipo de arquivo ' + vCdArquivo + 'não possuir campos cadastrados!',  cDS_METHOD);
    return(-1); exit;
  end;

  vCdEmpresa := itemXmlF('CD_EMPRESA', viParams);
  vDtMovimento := itemXml('DT_MOVIMENTO', viParams);
  vNrSeq := itemXmlF('NR_SEQ', viParams);
  if (vCdEmpresa > 0) and (vDtMovimento <> '') and (vNrSeq > 0) then begin
    gTEF_TRANSACAO := '';
    putitemXml(gTEF_TRANSACAO, 'CD_EMPRESA', vCdEmpresa);
    putitemXml(gTEF_TRANSACAO, 'DT_MOVIMENTO', vDtMovimento);
    putitemXml(gTEF_TRANSACAO, 'NR_SEQ', vNrSeq);
    gTEF_TRANSACAO := gModulo.ConsultarXmlUp('TEF_TRANSACAO', '', gTEF_TRANSACAO);
  end else begin
    gTEF_TRANSACAO := '';
  end;

  vDsConteudoREQ := '';

  //sort/e 'TEF_CAMPOARQ', 'NR_CAMPO.TEF_CAMPOARQ';
  tTEF_CAMPOARQ.First();
  while (xStatus >= 0) do begin
    putlistitensoccXml(gTEF_CAMPOARQ, tTEF_CAMPOARQ);
    vDsValor := itemXml('NR_CAMPO', gTEF_CAMPOARQ);
    if (vDsValor = '')
    and (itemXmlB('IN_OBRIGATORIO', gTEF_CAMPOARQ) = True)
    and (itemXml('CD_ARQUIVO', gTEF_TRANSACAO) <> 'ADM') then begin
      if (itemXml('NR_CAMPO', gTEF_CAMPOARQ) = '027-000')
      and (itemXml('NM_REDETEF', gTEF_TRANSACAO) = 'HCARD') then begin
      end else begin
        if (itemXml('NR_CAMPO', gTEF_CAMPOARQ) <> '012-000') then begin
          Result := SetStatus(STS_ERROR, 'GEN0001', 'Campo ' + itemXml('NR_CAMPO', gTEF_CAMPOARQ) + ' não informado!',  cDS_METHOD);
          return(-1); exit;
        end;
      end;
    end;
    vDsLinha := itemXml('NR_CAMPO', gTEF_CAMPOARQ) + ' := ' + vDsValor;
    if (itemXml('NR_CAMPO', gTEF_CAMPOARQ) = '012-000')
    and (vDsValor = '') then begin
    end else begin
      vDsConteudoREQ := vDsConteudoREQ + vDsLinha;
    end;
    tTEF_CAMPOARQ.Next();
  end;

  if (itemXmlB('IN_LOG_TEMPO_VENDA', PARAM_GLB)) then begin
    gHrFim := Time;
    MensagemLog('TEFSVCO010.geraArquivoREQ', 'Inicio filedump geraArquivoREQ: ' + TimeToStr(gHrFim));
  end;

  vDsArquivo := gDsDirReq + gDsArquivo + '.TMP';
  vDsConteudoREQ := CarregarArqTxt(vDsArquivo);
  if (xStatus < 0) then begin
    Result := SetStatus(STS_ERROR, 'TEF0001', '',  cDS_METHOD);
    return(-1); exit;
  end;

  if (gTpImpressaoTefPaygo <> 1) then begin
    if (gPadraoECF = PADRAO_LOCALIMPFIM)
    and ((vCdArquivo = 'CNC') or (vCdArquivo = 'ADM') or (vCdArquivo = 'CRT'))
    and (gTefComunicacaoGP = 0) then begin
      viParams := '';
      putitemXml(viParams, 'IN_MINIMIZA', True);
      voParams := activateCmp('ECFSVCO011','trataFocoTEF',viParams);
      if (xStatus < 0) then begin
        Result := voParams;
        return(-1); exit;
      end;
    end;
  end;

  viParams := '';
  putitemXml(viParams, 'PATH_ARQUIVO', vDsArquivo);
  putitemXml(viParams, 'NOME_ARQUIVO', gDsArquivo);
  putitemXml(viParams, 'EXT_ARQUIVO', vDsExtensao);
  voParams := activateCmp('GERSVCO100','RenomeaArquivo',viParams);
  if (xStatus < 0) then begin
    Result := voParams;
    return(-1); exit;
  end;

  if (itemXmlB('IN_LOG_TEMPO_VENDA', PARAM_GLB)) then begin
    gHrFim := Time;
    MensagemLog('TEFSVCO010.geraArquivoREQ', 'Fim filedump geraArquivoREQ: ' + TimeToStr(gHrFim));
  end;

  vInTimeOUT := True;

  viParams := '';
  putitemXml(viParams, 'DS_ESTENSAO', 'STS');
  putitemXml(viParams, 'IN_TIMEOUT', vInTimeOUT);
  vDsConteudoRESP := recuperaArquivoRESP(viParams);
  if (xStatus < 0) then begin
    Result := voParams;
    return(-1); exit;
  end;

  if (vInP1 = True) then begin
    viParams := '';
    putitemXml(viParams, 'DS_ESTENSAO', vDsExtensao);
    putitemXml(viParams, 'IN_TIMEOUT', vInTimeOUT);
    vDsConteudoRESP := recuperaArquivoRESP(viParams);
    if (xStatus < 0) then begin
      Result := voParams;
      return(-1); exit;
    end;
  end;

  if (gTpImpressaoTefPaygo <> 1) then begin
    if (gPadraoECF = PADRAO_LOCALIMPFIM)
    and ((vCdArquivo = 'CNC') or (vCdArquivo = 'ADM') or (vCdArquivo = 'CRT'))
    and (gTefComunicacaoGP = 0) then begin
      viParams := '';
      putitemXml(viParams, 'IN_MINIMIZA', False);
      voParams := activateCmp('ECFSVCO011','trataFocoTEF',viParams);
      if (xStatus < 0) then begin
        Result := voParams;
        return(-1); exit;
      end;
    end;
  end;

  Result := vDsConteudoRESP;

  if (itemXmlB('IN_LOG_TEMPO_VENDA', PARAM_GLB)) then begin
    gHrFim := Time;
    MensagemLog('TEFSVCO010.geraArquivoREQ', 'Fim geraArquivoREQ requisição TEF ' + vCdArquivo + ' ' + TimeToStr(gHrFim));
  end;

  return(0); exit;
end;

//---------------------------------------------------------------
function T_TEFSVCO010.buscaDadoCartao(pParams : String) : String;
//---------------------------------------------------------------
const
  cDS_METHOD = 'ADICONAL=Operação: T_TEFSVCO010.buscaDadoCartao()';
var
  vNrParcela, vCdRede, vCdTransacao, vTpJuros : Real;
  vDsRede, vDsAdministradora : String;
begin
  getParam(pParams);

  vCdRede := itemXmlF('010-001', pParams);
  vDsRede := UpperCase(itemXml('010-000', pParams));
  vCdTransacao := itemXmlF('011-000', pParams);
  vTpJuros := itemXmlF('017-000', pParams);
  vNrParcela := itemXmlF('018-000', pParams);
  vDsAdministradora := itemXml('040-000', pParams);
  vDsAdministradora := Alltrim(UpperCase(vDsAdministradora));

  if (vCdRede = 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Campo 010-000 e campo 010-001 estão nulos no arquivo de resposta!',  cDS_METHOD);
    return(-1); exit;
  end;
  if (vCdTransacao = 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Campo 011-001 não encontrado no arquivo de resposta!',  cDS_METHOD);
    return(-1); exit;
  end;
  if (vNrParcela = 0) then begin
    vNrParcela := 1;
  end;
  vDsRede := ajustaNmRede(vDsRede);

  if (vDsAdministradora <> '') then begin
    vDsAdministradora := ajustaNmRede(vDsAdministradora);
  end;

  gTEF_REDETEF := '';
  putitemXml(gTEF_REDETEF, 'TP_TEF', gTpTEF);
  if (gTpTEF = 1) then begin
    putitemXml(gTEF_REDETEF, 'NM_REDETEF', vDsRede);
    if (vDsAdministradora <> '') then begin
      putitemXml(gTEF_REDETEF, 'NM_REDETEF', vDsAdministradora);
    end;
  end else begin
    putitemXml(gTEF_REDETEF, 'CD_REDETEF', vCdRede);
    putitemXml(gTEF_REDETEF, 'NM_REDETEF', vDsRede);
    if (vDsAdministradora <> '') then begin
      putitemXml(gTEF_REDETEF, 'NM_REDETEF', vDsAdministradora);
    end;
  end;
  gTEF_REDETEF := gModulo.ConsultarXmlUp('TEF_REDETEF', '', gTEF_REDETEF);
  if (xStatus < 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Rede ' + itemXml('CD_REDETEF', gTEF_REDETEF) + ' não cadastrada!',  cDS_METHOD);
    return(-1); exit;
  end;

  gTEF_TIPOTRANS := '';
  putitemXml(gTEF_TIPOTRANS, 'TP_TEF', gTpTEF);
  putitemXml(gTEF_TIPOTRANS, 'TP_TRANSACAO', vCdTransacao);
  gTEF_TIPOTRANS := gModulo.ConsultarXmlUp('TEF_TIPOTRANS', '', gTEF_TIPOTRANS);
  if (xStatus < 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Transação TEF ' + FloatToStr(vCdTransacao) + 'não cadastrada!',  cDS_METHOD);
    return(-1); exit;
  end;

  if (gTpTEF = 1) then begin
    if (itemXmlF('TP_OPERCREDITO', gTEF_TIPOTRANS) <> 1) and (itemXmlF('TP_OPERCREDITO', gTEF_TIPOTRANS) <> 2) then begin
      Result := SetStatus(STS_ERROR, 'GEN0001', 'Transação TEF ' + FloatToStr(vCdTransacao) + ' não esta cadastrada como cartão de crédito/débito!',  cDS_METHOD);
      return(-1); exit;
    end;
  end;

  gTEF_RELOPER := '';
  putitemXml(gTEF_RELOPER, 'TP_TEF', gTpTEF);
  putitemXml(gTEF_RELOPER, 'CD_REDETEF', itemXmlF('CD_REDETEF', gTEF_REDETEF));
  putitemXml(gTEF_RELOPER, 'TP_TRANSACAO', vCdTransacao);
  gTEF_RELOPER := gModulo.ConsultarXmlUp('TEF_RELOPER', '', gTEF_RELOPER);
  if (xStatus < 0)
  or (itemXmlF('NR_PORTADOR', gTEF_RELOPER) < 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Nenhum portador cadastrado para transação TEF ' + FloatToStr(vCdTransacao) + ' na rede ' + itemXml('CD_REDETEF', gTEF_REDETEF) + '!',  cDS_METHOD);
    return(-1); exit;
  end;

  gFCX_HISTRELSUB := '';
  if (itemXmlF('TP_OPERCREDITO', gTEF_TIPOTRANS) = 1) then begin
    putitemXml(gFCX_HISTRELSUB, 'TP_DOCUMENTO', 4);
  end else if (itemXmlF('TP_OPERCREDITO', gTEF_TIPOTRANS) = 2) or (itemXmlF('TP_OPERCREDITO', gTEF_TIPOTRANS) = 4) then begin
    putitemXml(gFCX_HISTRELSUB, 'TP_DOCUMENTO', 5);
  end else if (itemXmlF('TP_OPERCREDITO', gTEF_TIPOTRANS) = 3) then begin
    putitemXml(gFCX_HISTRELSUB, 'TP_DOCUMENTO', 2);
  end;
  if (itemXmlF('TP_OPERCREDITO', gTEF_TIPOTRANS) = 3) then begin
    vNrParcela := 0;
  end else begin
    if (gTpTEF = 1) then begin
      if (vNrParcela = 1) and (itemXmlF('TP_OPERCREDITO', gTEF_TIPOTRANS) = 1) then begin
        gTEF_RELOPER := '';
        putitemXml(gTEF_RELOPER, 'TP_TEF', gTpTEF);
        putitemXml(gTEF_RELOPER, 'CD_REDETEF', itemXmlF('CD_REDETEF', gTEF_REDETEF));
        putitemXml(gTEF_RELOPER, 'TP_TRANSACAO', 48);
        gTEF_RELOPER := gModulo.ConsultarXmlUp('TEF_RELOPER', '', gTEF_RELOPER);
        if (xStatus < 0)
        or (itemXmlF('NR_PORTADOR', gTEF_RELOPER) < 0) then begin
          Result := SetStatus(STS_ERROR, 'GEN0001', 'Nenhum portador cadastrado para transação TEF ' + FloatToStr(vCdTransacao) + ' na rede ' + itemXml('CD_REDETEF', gTEF_REDETEF) + '!',  cDS_METHOD);
          return(-1); exit;
        end;
        putitemXml(gFCX_HISTRELSUB, 'NR_PORTADOR', itemXmlF('NR_PORTADOR', gTEF_RELOPER));
      end else begin
        if (vTpJuros = 1) then begin
          if (itemXmlF('NR_PORTADOROPER', gTEF_RELOPER) > 0) then begin
            putitemXml(gFCX_HISTRELSUB, 'NR_PORTADOR', itemXmlF('NR_PORTADOR', gTEF_RELOPER));
          end else begin
            putitemXml(gFCX_HISTRELSUB, 'NR_PORTADOR', itemXmlF('NR_PORTADOR', gTEF_RELOPER));
          end;
        end else begin
          putitemXml(gFCX_HISTRELSUB, 'NR_PORTADOR', itemXmlF('NR_PORTADOR', gTEF_RELOPER));
        end;
      end;
    end else begin
      putitemXml(gFCX_HISTRELSUB, 'NR_PORTADOR', itemXmlF('NR_PORTADOR', gTEF_RELOPER));
    end;
  end;

  putitemXml(gFCX_HISTRELSUB, 'NR_PARCELAS', vNrParcela);
  gFCX_HISTRELSUB := gModulo.ConsultarXmlUp('FCX_HISTRELSUB', '', gFCX_HISTRELSUB);
  if (xStatus < 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Nenhum histórico auxiliar de parcelamento relacionado à transação ' + FloatToStr(vCdTransacao) + ' na rede ' + itemXml('CD_REDETEF', gTEF_REDETEF) + '!',  cDS_METHOD);
    return(-1); exit;
  end;

  Result := '';
  putitemXml(Result, 'TP_DOCUMENTO', itemXmlF('TP_DOCUMENTO', gFCX_HISTRELSUB));
  putitemXml(Result, 'NR_SEQHISTRELSUB', itemXmlF('NR_SEQHISTRELSUB', gFCX_HISTRELSUB));
  return(0); exit;
end;

//--------------------------------------------------------------
function T_TEFSVCO010.buscaViaCartao(pParams : String) : String;
//--------------------------------------------------------------
const
  cDS_METHOD = 'ADICONAL=Operação: T_TEFSVCO010.buscaViaCartao()';
var
  vDsCupom, vDsLinha, vDs1Via, vDs2Via, vDsConteudo : String;
  vInAchouCorte : Boolean;
  vTpVia : Real;
begin
  vTpVia := itemXmlF('TP_VIA', pParams);
  vDsCupom := itemXml('DS_CUPOM', pParams);

  if (vTpVia = 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Tipo de via de cupom não informada!',  cDS_METHOD);
    return(-1); exit;
  end;
  if (vDsCupom = '') then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Lista de cupom não informada!',  cDS_METHOD);
    return(-1); exit;
  end;

  vInAchouCorte := False;

  while(length(vDsCupom) > 0) do begin
    if (Pos(#13, vDsCupom) > 0) then begin
      vDsLinha := Copy(vDsCupom, 1, Pos(#13, vDsCupom) - 1);
      vDsCupom := Copy(vDsCupom, Pos(#13, vDsCupom) + 1, Length(vDsCupom));
    end else begin
      vDsLinha := vDsCupom;
      vDsCupom := '';
    end;
    if (vDsLinha = '***VIRTUAL***') then begin
      vInAchouCorte := True;
    end;
    if (vDsLinha <> '***VIRTUAL***') then begin
      if not (vInAchouCorte) then begin
        vDs1Via := vDs1Via + vDsLinha;
      end else begin
        vDs2Via := vDs2Via + vDsLinha;
      end;
    end;
  end;

  if (vTpVia = 1) then vDsConteudo := vDs1Via + vDs2Via
  else if (vTpVia = 2) then vDsConteudo := vDs1Via
  else if (vTpVia = 3) then vDsConteudo := vDs2Via;

  Result := '';
  putitemXml(Result, 'DS_CUPOM', vDsConteudo);
  return(0); exit;
end;

end.