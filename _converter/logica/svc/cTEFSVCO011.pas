unit cTEFSVCO011;

interface

(* COMPONENTES
  ADMSVCO001 / EDISVCO020 /
*)

uses
  SysUtils, Math;

type
  T_TEFSVCO011 = class
  published
    function gravaTransacao(pParams : String = '') : String;
    function alteraSituacao(pParams : String = '') : String;
  end;

implementation

uses
  cADMSVCO001,
  cActivate, cDataSetUnf, cStatus, cFuncao, cXml, dModulo;

var
  gCdEmpresa,
  gCdRedeTEF : Real;

  gCdArquivo,
  gCdAutorizacao,
  gDsCupom,
  gDsFinalizacao,
  gDsMensagem,
  gDsNmAdministradora,
  gDtMovimento,
  gDtTransacao,
  gHrTransacao,
  gNmRedeTEF : String;

  gNrDocVinc,
  gNrLinhasCupom,
  gNrNSU,
  gNrNSUaux,
  gNrSeq,
  gTpImpTefPAYGO,
  gTpStatus,
  gTpTEF,
  gTpTransacao,
  gVlTransacao : Real;

  gFCR_FATURAI,
  gTEF_REDETEF,
  gTEF_RELFATURA,
  gTEF_RELTRANSA,
  gTEF_TRANSACAO,
  gTRA_TRANSACAO : String;

  tFCR_FATURAI,
  tTEF_REDETEF,
  tTEF_RELFATURA,
  tTEF_RELTRANSA,
  tTEF_TRANSACAO,
  tTRA_TRANSACAO : TcDatasetUnf;

  //--------------------------------------------------------
  function getParam(pParams : String) : String;
  //--------------------------------------------------------
  const
    cDS_METHOD = 'ADICONAL=Operação: T_TEFSVCO011.getParam()';
  var
    vCdEmpresa : Real;
    viParams, voParams : String;
  begin
    vCdEmpresa := itemXmlF('CD_EMPRESA', PARAM_GLB);

    viParams := '';
    putitem(viParams,  'TEF_TIPO');
    putitem(viParams,  'TP_IMPRESSAO_TEF_PAYGO');
    voParams := T_ADMSVCO001.GetParamEmpresa(vCdEmpresa, viParams);

    gTpTEF := itemXmlF('TEF_TIPO', voParams);
    gTpImpTefPAYGO := itemXmlF('TP_IMPRESSAO_TEF_PAYGO', voParams);

    return(0); exit;
  end;

  //----------------------------------------------------------
  function achaNumero(pParams : String) : String;
  //----------------------------------------------------------
  const
    cDS_METHOD = 'ADICONAL=Operação: T_TEFSVCO011.achaNumero()';
  var
    piNumero, poNumero : String;
  begin
    piNumero := pParams;
    poNumero := '';
    while (length(piNumero) > 0) do begin
      if (piNumero[1] in ['0'..'9']) then begin
        poNumero := poNumero + piNumero[1];
      end;
      piNumero := Copy(piNumero,2,Length(piNumero));
    end;
    Result := poNumero;
    return(0); exit;
  end;

  //---------------------------------------------------------------
  function converterString(pParams : String) : String;
  //---------------------------------------------------------------
  const
    cDS_METHOD = 'ADICONAL=Operação: T_TEFSVCO011.converterString()';
  var
    viParams, voParams : String;
  begin
    viParams := '';
    putitemXml(viParams, 'DS_STRING', pParams);
    putitemXml(viParams, 'IN_MAIUSCULA', True);
    putitemXml(viParams, 'IN_NUMERO', True);
    putitemXml(viParams, 'IN_ESPACO', True);
    putitemXml(viParams, 'IN_ESPECIAL', False);
    voParams := activateCmp('EDISVCO020','limparCampo', viParams);
    Result := itemXml('DS_STRING', voParams);
    return(0); exit;
  end;

  //--------------------------------------------------------------
  function alimentaCampos(pParams : String) : String;
  //--------------------------------------------------------------
  const
    cDS_METHOD = 'ADICONAL=Operação: T_TEFSVCO011.alimentaCampos()';
  var
    viParams, voParams, vDsRegistro, vDsLinha, vDsNumero : String;
    vNrLinhas, vNrPos, vNrCont, vVlCalc : Real;
  begin
    gCdEmpresa := itemXmlF('CD_EMPRESA', pParams);
    gDtMovimento := itemXml('DT_SISTEMA', PARAM_GLB);
    gCdArquivo := itemXml('000-000', pParams);
    gNrSeq := itemXmlF('001-000', pParams);
    gNrDocVinc := itemXmlF('002-000', pParams);
    gNrNSUaux := itemXmlF('NR_NSUAUX', pParams);
    vDsNumero := itemXml('003-000', pParams);
    gTpStatus := itemXmlF('009-000', pParams);
    gNmRedeTEF := itemXml('010-000', pParams);
    gCdRedeTEF := itemXmlF('010-001', pParams);
    gTpTransacao := itemXmlF('011-000', pParams);
    gNrNSU := itemXmlF('012-000', pParams);
    gCdAutorizacao := itemXml('013-000', pParams);
    gDtTransacao := itemXml('022-000', pParams);
    gHrTransacao := itemXml('023-000', pParams);
    gDsFinalizacao := itemXml('027-000', pParams);

    if (gCdEmpresa = 0) then begin
      Result := SetStatus(STS_ERROR, 'GEN0001', 'Empresa da transação não informada!',  cDS_METHOD);
      return(-1); exit;
    end;
    if (gDtMovimento = '') then begin
      Result := SetStatus(STS_ERROR, 'GEN0001', 'Data de movimento não informada!',  cDS_METHOD);
      return(-1); exit;
    end;
    if (gCdArquivo = '') then begin
      Result := SetStatus(STS_ERROR, 'GEN0001', 'Campo 000-000 não encontrado no arquivo de resposta!',  cDS_METHOD);
      return(-1); exit;
    end;
    if (gNrSeq = 0) then begin
      Result := SetStatus(STS_ERROR, 'GEN0001', 'Campo 001-000 não encontrado no arquivo de resposta!',  cDS_METHOD);
      return(-1); exit;
    end;

    vVlCalc := SetarValorF(achaNumero(vDsNumero), '0');
    gVlTransacao := vVlCalc / 100;

    if (gTpImpTefPAYGO = 1) then begin
      vDsRegistro := '';
      vNrLinhas := itemXmlF('710-000', pParams);
      if (vNrLinhas > 0) then begin
        repeat
          vNrCont := vNrCont + 1;
          if (vNrCont < 10) then begin
            vDsLinha := itemXml('711-00' + FloatToStr(vNrCont), pParams);
          end else if (vNrCont > 9) and (vNrCont <= 99) then begin
            vDsLinha := itemXml('711-0' + FloatToStr(vNrCont), pParams);
          end else if (vNrCont > 99) then begin
            vDsLinha := itemXml('711-' + FloatToStr(vNrCont), pParams);
          end;

          if (length(vDsLinha) > 3) then begin
            vDsLinha := Copy(vDsLinha, 2, length(vDsLinha) - 2);
          end else begin
            vDsLinha := ' ';
          end;

          vDsRegistro := vDsRegistro + vDsLinha;
        until (vNrCont = vNrLinhas);
      end else begin
        vDsRegistro := '';
        vNrLinhas := itemXmlF('028-000', pParams);
        if (vNrLinhas > 0) then begin
          repeat
            vNrCont := vNrCont + 1;
            if (vNrCont < 10) then begin
              vDsLinha := itemXml('029-00' + FloatToStr(vNrCont), pParams);
            end else if (vNrCont > 9) and (vNrCont <= 99) then begin
              vDsLinha := itemXml('029-0' + FloatToStr(vNrCont), pParams);
            end else if (vNrCont > 99) then begin
              vDsLinha := itemXml('029-' + FloatToStr(vNrCont), pParams);
            end;

            if (length(vDsLinha) > 3) then begin
              vDsLinha := Copy(vDsLinha, 2, length(vDsLinha) - 2);
            end else begin
              vDsLinha := ' ';
            end;

            vDsRegistro := vDsRegistro + vDsLinha;
          until (vNrCont = vNrLinhas);
        end;
      end;
    end else begin
      vDsRegistro := '';
      vNrLinhas := itemXmlF('028-000', pParams);
      if (vNrLinhas > 0) then begin
        repeat
          vNrCont := vNrCont + 1;
          if (vNrCont < 10) then begin
            vDsLinha := itemXml('029-00' + FloatToStr(vNrCont), pParams);
          end else if (vNrCont > 9) and (vNrCont <= 99) then begin
            vDsLinha := itemXml('029-0' + FloatToStr(vNrCont), pParams);
          end else if (vNrCont > 99) then begin
            vDsLinha := itemXml('029-' + FloatToStr(vNrCont), pParams);
          end;

          if (length(vDsLinha) > 3) then begin
            vDsLinha := Copy(vDsLinha, 2, length(vDsLinha) - 2);
          end else begin
            vDsLinha := ' ';
          end;

          vDsRegistro := vDsRegistro + vDsLinha;
        until (vNrCont = vNrLinhas);
      end;
    end;

    gDsCupom := vDsRegistro;
    gDsMensagem := itemXml('030-000', pParams);
    gDsNmAdministradora := itemXml('040-000', pParams);
    gDsMensagem := converterString(gDsMensagem);

    return(0); exit;
  end;

//--------------------------------------------------------------
function T_TEFSVCO011.gravaTransacao(pParams : String) : String;
//--------------------------------------------------------------
const
  cDS_METHOD = 'ADICONAL=Operação: T_TEFSVCO011.gravaTransacao()';
var
  voParams,
  vDsRegistro, vDsLstTransacao, vDsLstFaturas, vNmRede : String;
  vCdEmpresa, vNrTransacao, vCdTerminal, vTpSituacao : Real;
  vCdEmpFat, vCdClienteFat, vNrFat, vNrParcelaFat : Real;
  vDtTransacao : String;
begin
  vCdTerminal := itemXmlF('CD_TERMINAL', PARAM_GLB);

  if (vCdTerminal = 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Terminal não informado!',  cDS_METHOD);
    return(-1); exit;
  end;

  vTpSituacao := itemXmlF('TP_SITUACAO', pParams);

  gTRA_TRANSACAO := '';

  vDsLstTransacao := itemXml('DS_LSTTRANSACAO', pParams);

  if (vDsLstTransacao <> '') then begin
    repeat
      getitem(vDsRegistro, vDsLstTransacao, 1);
      vCdEmpresa := itemXmlF('CD_EMPRESA', vDsRegistro);
      vNrTransacao := itemXmlF('NR_TRANSACAO', vDsRegistro);
      vDtTransacao := itemXml('DT_TRANSACAO', vDsRegistro);

      if (vCdEmpresa = 0) then begin
        Result := SetStatus(STS_ERROR, 'GEN0001', 'Empresa não informada!',  cDS_METHOD);
        return(-1); exit;
      end;
      if (vNrTransacao = 0) then begin
        Result := SetStatus(STS_ERROR, 'GEN0001', 'Número da transação não informado!',  cDS_METHOD);
        return(-1); exit;
      end;
      if (vDtTransacao = '') then begin
        Result := SetStatus(STS_ERROR, 'GEN0001', 'Data transação não informada!',  cDS_METHOD);
        return(-1); exit;
      end;

      gTRA_TRANSACAO := '';
      putitemXml(gTRA_TRANSACAO, 'CD_EMPRESA', vCdEmpresa);
      putitemXml(gTRA_TRANSACAO, 'NR_TRANSACAO', vNrTransacao);
      putitemXml(gTRA_TRANSACAO, 'DT_TRANSACAO', vDtTransacao);
      retrieve_o(tTRA_TRANSACAO);
      if (xStatus = -7) then begin
        retrieve_x(tTRA_TRANSACAO);
      end else if (xStatus = 0) then begin
        Result := SetStatus(STS_ERROR, 'GEN0001', 'Transação ' + FloatToStr(vNrTransacao) + ' não cadastrada!',  cDS_METHOD);
        return(-1); exit;
      end;
      delitem(vDsLstTransacao, 1);
    until (vDsLstTransacao = '');
  end;

  gFCR_FATURAI := '';

  vDsLstFaturas := itemXml('DS_FATURAS', pParams);

  if (vDsLstFaturas <> '') then begin
    repeat
      getitem(vDsRegistro, vDsLstFaturas, 1);
      vCdEmpFat := itemXmlF('CD_EMPRESA', vDsRegistro);
      vCdClienteFat := itemXmlF('CD_CLIENTE', vDsRegistro);
      vNrFat := itemXmlF('NR_FAT', vDsRegistro);
      vNrParcelaFat := itemXmlF('NR_PARCELA', vDsRegistro);

      if (vCdEmpFat = 0) then begin
        Result := SetStatus(STS_ERROR, 'GEN0001', 'Empresa fatura não informada!',  cDS_METHOD);
        return(-1); exit;
      end;
      if (vCdClienteFat = 0) then begin
        Result := SetStatus(STS_ERROR, 'GEN0001', 'Cliente da fatura não informado!',  cDS_METHOD);
        return(-1); exit;
      end;
      if (vNrFat = 0) then begin
        Result := SetStatus(STS_ERROR, 'GEN0001', 'Número fatura não informada!',  cDS_METHOD);
        return(-1); exit;
      end;
      if (vNrParcelaFat = 0) then begin
        Result := SetStatus(STS_ERROR, 'GEN0001', 'Número parcela da fatura não informada!',  cDS_METHOD);
        return(-1); exit;
      end;

       gFCR_FATURAI := '';
      putitemXml(gFCR_FATURAI, 'CD_EMPRESA', vCdEmpFat);
      putitemXml(gFCR_FATURAI, 'CD_CLIENTE', vCdClienteFat);
      putitemXml(gFCR_FATURAI, 'NR_FAT', vNrFat);
      putitemXml(gFCR_FATURAI, 'NR_PARCELA', vNrParcelaFat);
      retrieve_o(tFCR_FATURAI);
      if (xStatus = -7) then begin
        retrieve_x(tFCR_FATURAI);
      end else if (xStatus = 0) then begin
        Result := SetStatus(STS_ERROR, 'GEN0001', 'Fatura empresa ' + FloatToStr(vCdEmpFat) + ' cliente ' + FloatToStr(vCdClienteFat) + ' número ' + FloatToStr(vNrFat) + ' parcela ' + FloatToStr(vNrParcelaFat) + ' não cadastrada!',  cDS_METHOD);
        return(-1); exit;
      end;

      delitem(vDsLstFaturas, 1);
    until (vDsLstFaturas = '');
  end;

  getParam(pParams);

  if (gTpTEF <> 1) and (gTpTEF <> 2) then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Parametro p/ empresa TEF_TIPO inválido!',  cDS_METHOD);
    return(-1); exit;
  end;

  alimentaCampos(pParams);

  if (gCdRedeTef = 0) and (gNmRedeTef <> '') then begin
    gTEF_REDETEF := '';
    putitemXml(gTEF_REDETEF, 'NM_REDETEF', gNmRedeTef);
    gTEF_REDETEF := gModulo.ConsultarXmlUp('TEF_REDETEF', '', gTEF_REDETEF);
    if (xStatus >= 0) then begin
      gCdRedeTef := itemXmlF('CD_REDETEF', gTEF_REDETEF);
    end else begin
      if (Pos('VISA', gNmRedeTef) > 0) then begin
        vNmRede := Copy(gNmRedeTef, Pos('VISA', gNmRedeTef), 4);

        gTEF_REDETEF := '';
        putitemXml(gTEF_REDETEF, 'NM_REDETEF', vNmRede);
        gTEF_REDETEF := gModulo.ConsultarXmlUp('TEF_REDETEF', '', gTEF_REDETEF);
        if (xStatus >= 0) then begin
          gCdRedeTef := itemXmlF('CD_REDETEF', gTEF_REDETEF);
        end;
      end;
    end;
  end else if (gCdRedeTef > 0) and (gNmRedeTef = '') then begin
    gTEF_REDETEF := '';
    putitemXml(gTEF_REDETEF, 'CD_REDETEF', gCdRedeTef);
    gTEF_REDETEF := gModulo.ConsultarXmlUp('TEF_REDETEF', '', gTEF_REDETEF);
    gNmRedeTef := itemXml('NM_REDETEF', gTEF_REDETEF);
  end;

   gTEF_TRANSACAO := '';
  putitemXml(gTEF_TRANSACAO, 'CD_EMPRESA', gCdEmpresa);
  putitemXml(gTEF_TRANSACAO, 'DT_MOVIMENTO', gDtMovimento);
  putitemXml(gTEF_TRANSACAO, 'NR_SEQ', gNrSeq);
  retrieve_o(tTEF_TRANSACAO);
  if (xStatus = -7) then begin
    retrieve_x(tTEF_TRANSACAO);
  end;
  putitemXml(gTEF_TRANSACAO, 'TP_TEF', gTpTEF);
  putitemXml(gTEF_TRANSACAO, 'CD_ARQUIVO', gCdArquivo);
  putitemXml(gTEF_TRANSACAO, 'TP_TRANSACAO', gTpTransacao);
  putitemXml(gTEF_TRANSACAO, 'CD_REDETEF', gCdRedeTEF);

  if (vTpSituacao = 0) then begin
    putitemXml(gTEF_TRANSACAO, 'TP_SITUACAO', 1);
  end else begin
    putitemXml(gTEF_TRANSACAO, 'TP_SITUACAO', vTpSituacao);
  end;
  putitemXml(gTEF_TRANSACAO, 'VL_TRANSACAO', gVlTransacao);
  putitemXml(gTEF_TRANSACAO, 'HR_TRANSACAO', gHrTransacao);
  putitemXml(gTEF_TRANSACAO, 'DT_TRANSACAO', gDtTransacao);
  putitemXml(gTEF_TRANSACAO, 'NR_NSU', gNrNSU);
  putitemXml(gTEF_TRANSACAO, 'NR_DOCVINC', gNrDocVinc);
  putitemXml(gTEF_TRANSACAO, 'NR_NSUAUX', gNrNSUaux);
  putitemXml(gTEF_TRANSACAO, 'CD_AUTORIZACAO', gCdAutorizacao);
  putitemXml(gTEF_TRANSACAO, 'CD_TERMINAL', vCdTerminal);
  putitemXml(gTEF_TRANSACAO, 'NM_REDETEF', gNmRedeTEF);
  putitemXml(gTEF_TRANSACAO, 'TP_STATUS', gTpStatus);
  putitemXml(gTEF_TRANSACAO, 'DS_FINALIZACAO', gDsFinalizacao);
  putitemXml(gTEF_TRANSACAO, 'DS_MENSAGEM', gDsMensagem);
  putitemXml(gTEF_TRANSACAO, 'NR_LINHASCUPOM', gNrLinhasCupom);
  putitemXml(gTEF_TRANSACAO, 'DS_CUPOM', gDsCupom);
  putitemXml(gTEF_TRANSACAO, 'CD_OPERADOR', itemXmlF('CD_USUARIO', PARAM_GLB));
  putitemXml(gTEF_TRANSACAO, 'DT_CADASTRO', Now);

  if (empty(tTRA_TRANSACAO) = False) then begin
    tTRA_TRANSACAO.First();
    while (xStatus >=0) do begin
      gTEF_RELTRANSA := '';
      putitemXml(gTEF_RELTRANSA, 'CD_EMPTEF', itemXmlF('CD_EMPRESA', gTEF_TRANSACAO));
      putitemXml(gTEF_RELTRANSA, 'DT_MOVIMENTO', itemXml('DT_MOVIMENTO', gTEF_TRANSACAO));
      putitemXml(gTEF_RELTRANSA, 'NR_SEQ', itemXmlF('NR_SEQ', gTEF_TRANSACAO));
      putitemXml(gTEF_RELTRANSA, 'CD_EMPTRA', itemXmlF('CD_EMPRESA', gTRA_TRANSACAO));
      putitemXml(gTEF_RELTRANSA, 'NR_TRANSACAO', itemXmlF('NR_TRANSACAO', gTRA_TRANSACAO));
      putitemXml(gTEF_RELTRANSA, 'DT_TRANSACAO', itemXml('DT_TRANSACAO', gTRA_TRANSACAO));
      retrieve_o(tTEF_RELTRANSA);
      if (xStatus = -7) then begin
        retrieve_x(tTEF_RELTRANSA);
      end;
      putitemXml(gTEF_RELTRANSA, 'CD_OPERADOR', itemXmlF('CD_USUARIO', PARAM_GLB));
      putitemXml(gTEF_RELTRANSA, 'DT_CADASTRO', Now);
      tTRA_TRANSACAO.Next();
    end;
  end;

  if (empty(tFCR_FATURAI) = False) then begin
    tFCR_FATURAI.First();
    while (xStatus >=0) do begin
       gTEF_RELFATURA := '';
      putitemXml(gTEF_RELFATURA, 'CD_EMPTEF', itemXmlF('CD_EMPRESA', gTEF_TRANSACAO));
      putitemXml(gTEF_RELFATURA, 'DT_MOVIMENTO', itemXml('DT_MOVIMENTO', gTEF_TRANSACAO));
      putitemXml(gTEF_RELFATURA, 'NR_SEQ', itemXmlF('NR_SEQ', gTEF_TRANSACAO));
      putitemXml(gTEF_RELFATURA, 'CD_EMPFATURA', itemXmlF('CD_EMPRESA', gFCR_FATURAI));
      putitemXml(gTEF_RELFATURA, 'CD_CLIENTE', itemXmlF('CD_CLIENTE', gFCR_FATURAI));
      putitemXml(gTEF_RELFATURA, 'NR_FATURA', itemXmlF('NR_FAT', gFCR_FATURAI));
      putitemXml(gTEF_RELFATURA, 'NR_PARCELA', itemXmlF('NR_PARCELA', gFCR_FATURAI));
      retrieve_o(tTEF_RELFATURA);
      if (xStatus = -7) then begin
        retrieve_x(tTEF_RELFATURA);
      end;
      putitemXml(gTEF_RELFATURA, 'CD_OPERADOR', itemXmlF('CD_USUARIO', PARAM_GLB));
      putitemXml(gTEF_RELFATURA, 'DT_CADASTRO', Now);
       tFCR_FATURAI.Next();
    end;
  end;

  voParams := gModulo.GravarXmlUp('TEF_TRANSACAO', gTEF_TRANSACAO);
  if (xStatus < 0) then begin
    Result := voParams;
    return(-1); exit;
  end;

  Result := '';
  putitemXml(Result, 'CD_EMPRESA', itemXmlF('CD_EMPRESA', gTEF_TRANSACAO));
  putitemXml(Result, 'DT_MOVIMENTO', itemXml('DT_MOVIMENTO', gTEF_TRANSACAO));
  putitemXml(Result, 'NR_SEQ', itemXmlF('NR_SEQ', gTEF_TRANSACAO));
  putitemXml(Result, 'DS_CUPOM', gDsCupom);
  putitemXml(Result, 'DS_MENSAGEM', gDsMensagem);

  return(0); exit;
end;

//--------------------------------------------------------------
function T_TEFSVCO011.alteraSituacao(pParams : String) : String;
//--------------------------------------------------------------
const
  cDS_METHOD = 'ADICONAL=Operação: T_TEFSVCO011.alteraSituacao()';
var
  vCdEmpresa, vNrSeq, vTpSituacao : Real;
  voParams, vDtMovimento : String;
begin
  vCdEmpresa := itemXmlF('CD_EMPRESA', pParams);
  vDtMovimento := itemXml('DT_MOVIMENTO', pParams);
  vNrSeq := itemXmlF('NR_SEQ', pParams);
  vTpSituacao := itemXmlF('TP_SITUACAO', pParams);

  if (vCdEmpresa = 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Empresa não informada!',  cDS_METHOD);
    return(-1); exit;
  end;
  if (vDtMovimento = '') then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Dt. movimento não informada!',  cDS_METHOD);
    return(-1); exit;
  end;
  if (vNrSeq = 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Nr. sequência transação TEF não informada!',  cDS_METHOD);
    return(-1); exit;
  end;
  if (vTpSituacao <> -2) and (vTpSituacao <> -1) and (vTpSituacao <> 1) and (vTpSituacao <> 2) and (vTpSituacao <> 3) and (vTpSituacao <> 4) then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Situação ' + FloatToStr(vTpSituacao) + ' inválida!',  cDS_METHOD);
    return(-1); exit;
  end;

  gTEF_TRANSACAO := '';
  putitemXml(gTEF_TRANSACAO, 'CD_EMPRESA', vCdEmpresa);
  putitemXml(gTEF_TRANSACAO, 'DT_MOVIMENTO', vDtMovimento);
  putitemXml(gTEF_TRANSACAO, 'NR_SEQ', vNrSeq);
  gTEF_TRANSACAO := gModulo.ConsultarXmlUp('TEF_TRANSACAO', '', gTEF_TRANSACAO);
  if (xStatus < 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Transação TEF ' + FloatToStr(vNrSeq) + ' não cadastrada!',  cDS_METHOD);
    return(-1); exit;
  end;

  putitemXml(gTEF_TRANSACAO, 'TP_SITUACAO', vTpSituacao);

  if (itemXmlF('TP_SITUACAO', gTEF_TRANSACAO) <> 1)
  and (itemXmlF('TP_SITUACAO', gTEF_TRANSACAO) <> 4) then begin
    putitemXml(gTEF_TRANSACAO, 'DS_CUPOM', '');
  end;
  putitemXml(gTEF_TRANSACAO, 'CD_OPERADOR', itemXmlF('CD_USUARIO', PARAM_GLB));
  putitemXml(gTEF_TRANSACAO, 'DT_CADASTRO', Now);

  voParams := gModulo.GravarXmlUp('TEF_TRANSACAO', gTEF_TRANSACAO);
  if (xStatus < 0) then begin
    Result := voParams;
    return(-1); exit;
  end;

  return(0); exit;
end;

end.