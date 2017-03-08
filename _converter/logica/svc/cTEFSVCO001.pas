unit cTEFSVCO001;

// NAO EH UTILIZADO MAIS TEFSVCO010 / TEFSVCO011

interface

(* COMPONENTES
  ADMSVCO001 / GERSVCO001 / KERNEL32 / TEFFL001 / winapi
*)

//uses
//  SysUtils, Math;

type
  T_TEFSVCO001 = class
  published
    (*
    function EfetuarTEF(pParams : String = '') : String;
    function FinalizaTEF(pParams : String = '') : String;
    function RecusarTEF(pParams : String = '') : String;
    function VerPendenciaTEF(pParams : String = '') : String;
    function LerPendencias(pParams : String = '') : String;
    function GeraArquivoTef(pParams : String = '') : String;
    function LerArqRespostaTEF(pParams : String = '') : String;
    function ConverterArqTEF(pParams : String = '') : String;
    function AvisoEmissaoCupomTEF(pParams : String = '') : String;
    function BuscaOperador(pParams : String = '') : String;
    function ValidaNumero(pParams : String = '') : String;
    *)
  end;

implementation
(*
uses
  cADMSVCO001,
  cDatasetUnf, cActivate, cStatus, cFuncao, cXml, dModulo;
  
var
  gDsDirReq,
  gLSTPARAM : String;

  gTEF_ARQUIVO,
  gTEF_LANCAMENTO,
  gTEF_REDETEF,
  gTEF_RELOPER,
  gTEF_TIPOTRANS : String;

  tTEF_ARQUIVO,
  tTEF_LANCAMENTO,
  tTEF_REDETEF,
  tTEF_RELOPER,
  tTEF_TIPOTRANS : TcDatasetUnf;

//-------------------------------------------------------------
function T_TEFSVCO001.BuscaOperador(pParams : String) : String;
//-------------------------------------------------------------
const
  cDS_METHOD = 'ADICONAL=Operação: T_TEFSVCO001.BuscaOperador()';

var
  vCdRedeTEF,vTpTransacao : Real;
  vNmRedeTEF,vdsoperacao : String;
begin

  Result := SetStatus(<STS_LOG>,'CFI0002','', cDS_METHOD);

  vCdRedeTEF := itemXml('010-001', pParams);
  vTpTransacao := itemXml('011-000', pParams);
  vNmRedeTEF := itemXml('010-000', pParams);
  if (vTpTransacao='') then begin
    Result := SetStatus(STS_ERROR,'TEF0006','', cDS_METHOD);
  end else begin
    gTEF_TIPOTRANS := '';
    putitemXml(gTEF_TIPOTRANS, 'tp_tef', itemXml('TEF_TIPO', piGlobal));
    putitemXml(gTEF_TIPOTRANS, 'tp_transacao', vTpTransacao);
    gTEF_TIPOTRANS := gModulo.ConsultarXmlUp('TEF_TIPOTRANS', '', gTEF_TIPOTRANS);
    if (xStatus < 0) then begin
      putitemXml(Result, 'TP_OPERCREDITO', 3);
    end else begin
      putitemXml(Result, 'TP_OPERCREDITO', itemXml('tp_opercredito', gTEF_TIPOTRANS));
      putitemXml(Result, 'NR_VIAS', itemXml('nr_vias', gTEF_TIPOTRANS));
    end;

    if (vCdRedeTEF = '') then begin
      gTEF_REDETEF := '';
      putitemXml(gTEF_REDETEF, 'tp_tef', itemXml('TEF_TIPO', piGlobal));
      putitemXml(gTEF_REDETEF, 'nm_redetef', vNmRedeTEF);
      gTEF_REDETEF := gModulo.ConsultarXmlUp('TEF_REDETEFSVC', '', gTEF_REDETEF);
      if (xStatus < 0) then begin
        Result := SetStatus(STS_ERROR,xProcerror,xProcerrorcontext, cDS_METHOD);
        return(xStatus);
      end else begin
        vCdRedeTEF := itemXml('cd_redetef', gTEF_REDETEF);
      end;
    end;
    gTEF_RELOPER := '';
    putitemXml(gTEF_RELOPER, 'tp_tef', itemXml('TEF_TIPO', piGlobal));
    putitemXml(gTEF_RELOPER, 'cd_redetef', vCdRedeTEF);
    putitemXml(gTEF_RELOPER, 'tp_transacao', vTpTransacao);
    gTEF_RELOPER := gModulo.ConsultarXmlUp('TEF_RELOPERSVC', '', gTEF_RELOPER);
    if (xStatus < 0) then begin
      Result := SetStatus(STS_ERROR,xProcerror,xProcerrorcontext, cDS_METHOD);
    end else begin
      putitemXml(Result, 'CD_OPERCREDITO', cd_opercredito.pes_opercredisvc);
      if (tp_opercredito.pes_opercredisvc <> '') then begin
        vDsOperacao := itemXml(tp_opercredito.pes_opercredisvc, valrep(tp_opercredito.pes_opercredisvc));
        putitemXml(Result, 'DS_OPERCREDITO', vDsOperacao);
      end;
    end;
  end;
  return (xStatus);
end;

//----------------------------------------------------------
function T_TEFSVCO001.EfetuarTEF(pParams : String) : String;
//----------------------------------------------------------
const
  cDS_METHOD = 'ADICONAL=Operação: T_TEFSVCO001.EfetuarTEF()';

var
  vDsMensagem,voParams : String;
begin

Result := SetStatus(<STS_LOG>,'CFI0002','', cDS_METHOD);

gTEF_LANCAMENTO := '';
activateCmp('ADMSVCO001','GetParamGrupoEmp',itemXml','CD_EMPRESA', piGlobal), 'TEF', gLSTPARAM, xCdErro, xCtxErro);
if (xProcerror <> '') then begin
    Result := SetStatus(STS_ERROR,xProcerror,xProcerrorcontext, cDS_METHOD);
end else if (xStatus < 0) then begin
    Result := SetStatus('',xCdErro,xCtxErro,'');
end else begin
  GeraArquivoTef(piGlobal, pParams, Result, xCdErro, xCtxErro);
  if (xProcerror <> '') then begin
      Result := SetStatus(STS_ERROR,xProcerror,xProcerrorcontext, cDS_METHOD);
  end else if (xStatus < 0) then begin
      Result := SetStatus('',xCdErro,xCtxErro,'');
  end else begin
    putitemXml(pParams, '000-000', 'RESPOSTA');
    putitemXml(pParams, '001-000', itemXml('001-000', Result));
    LerArqRespostaTEF(piGlobal, pParams, Result, xCdErro, xCtxErro);
    if (xProcerror <> '') then begin
        Result := SetStatus(STS_ERROR,xProcerror,xProcerrorcontext, cDS_METHOD);
    end else if (xStatus < 0) then begin
        Result := SetStatus('',xCdErro,xCtxErro,'');
    end else begin
      putitemXml(Result, 'CD_LANCAMENTO', itemXmlF('CD_LANCAMENTO', pParams));
          vDsMensagem := itemXml('030-000', Result);
          if (itemXml('009-000', Result) = 0) or (itemXml('009-000', Result) = 'P1') then begin
        ('TEF_LANCAMENTO')->Adicionar(piGlobal, Result);
        ('TEF_RESPOSTASVC')->Adicionar(piGlobal, Result);
        ('TEF_LANCAMENTO')->Salvar();
            if (xStatus < 0) then begin
                Result := SetStatus('',xCdErro,xCtxErro, cDS_METHOD);
        end;
        if (itemXml('028-000', Result) = 0) then begin
          message/info '' + vDsMensagem';

              end;
          end else begin
        message/info '' + vDsMensagem';

        if (itemXml('IN_PROCESSATEF', pParams) = 0) then begin
          putitemXml(pParams, 'IN_LANCAMENTO', 1);
          RecusarTEF(piGlobal, pParams, Result, xCdErro, xCtxErro);
          if (xProcerror <> '') then begin
            Result := SetStatus(STS_ERROR,xProcerror,xProcerrorcontext, cDS_METHOD);
          end else if (xStatus < 0) then begin
            Result := SetStatus('',xCdErro,xCtxErro,'');
          end;
        end;
        xStatus := STS_ERROR;
          end;
    end;
  end;
end;
exit(xStatus);
end;

//-----------------------------------------------------------
function T_TEFSVCO001.FinalizaTEF(pParams : String) : String;
//-----------------------------------------------------------
const
  cDS_METHOD = 'ADICONAL=Operação: T_TEFSVCO001.FinalizaTEF()';
var
  vDsMensagem,viParams,voParams,vRede,vNSU,vDsValor,vDsNsu : String;
  vNrCupons, vNrContCupom,vStatus : Real;
begin

  Result := SetStatus(<STS_LOG>,'CFI0002','', cDS_METHOD);

  activateCmp('ADMSVCO001','GetParamGrupoEmp',itemXml','CD_EMPRESA', piGlobal), 'TEF', gLSTPARAM, xCdErro, xCtxErro);
  if (xProcerror <> '') then begin
      Result := SetStatus(STS_ERROR,xProcerror,xProcerrorcontext, cDS_METHOD);
      return(-1); exit;
  end else if (xCdErro <> '') then begin
      Result := SetStatus('',xCdErro,xCtxErro,'');
      return(-1); exit;
  end else begin

      gTEF_LANCAMENTO := '';
      putitemXml(gTEF_LANCAMENTO, 'cd_tefstatus', '<STS_TEF_APROVADO>·);
      gTEF_LANCAMENTO := gModulo.ConsultarXmlUp('TEF_LANCAMENTO', '', gTEF_LANCAMENTO);
      while (dbocc(TEF_LANCAMENTO) > 0) do begin
      if (itemXml('nr_nsu', gTEF_LANCAMENTO) <> '') or then begin
        (((putitemXml(gTEF_LANCAMENTO, 'tp_transacao', 1) or);
        (putitemXml(gTEF_LANCAMENTO, 'tp_transacao', 0)) and (itemXml('TEF_TIPO', gLSTPARAM)= <TEF_Discado>)));
            if(putitemXml(gTEF_LANCAMENTO, 'cd_tefstatus', <STS_TEF_APROVADO>));
               putitemXml(viParams, '000-000', 'CNF');
            end else begin
               putitemXml(viParams, '000-000', 'NCN');
            end;
        putitemXml(viParams, '001-000', itemXml('nr_identificacao', gTEF_LANCAMENTO));
        putitemXml(viParams, '002-000', itemXml('nr_docvinc', gTEF_LANCAMENTO));
        putitemXml(viParams, '010-000', itemXml('nm_redetef', gTEF_LANCAMENTO));
        putitemXml(viParams, '012-000', itemXml('nr_nsu', gTEF_LANCAMENTO));
        putitemXml(viParams, '027-000', itemXml('ds_finalizacao', gTEF_LANCAMENTO));
        if (itemXml('nm_redetef', gTEF_LANCAMENTO) = 'TECBAN') then begin
          putitemXml(viParams, '000-001', 'DISC');
        end else begin
          putitemXml(viParams, '000-001', 'DIAL');
        end;
        GeraArquivoTef(piGlobal, viParams, voParams, xCdErro, xCtxErro);
        if (xProcerror <> '') then begin
          Result := SetStatus(STS_ERROR,xProcerror,xProcerrorcontext, cDS_METHOD);
        end else if (xStatus < 0) then begin
          Result := SetStatus('',xCdErro,xCtxErro,'');
        end else begin
                if  (putitemXml(gTEF_LANCAMENTO, 'cd_tefstatus', <STS_TEF_APROVADO>));
                     putitemXml(gTEF_LANCAMENTO, 'cd_tefstatus', <STS_TEF_SUCESSO>);
                end else begin
                     putitemXml(gTEF_LANCAMENTO, 'cd_tefstatus', <STS_TEF_FALHA>);
                end;
        end;
      end else begin

        if  (putitemXml(gTEF_LANCAMENTO, 'cd_tefstatus', <STS_TEF_APROVADO>));
                    putitemXml(gTEF_LANCAMENTO, 'cd_tefstatus', <STS_TEF_SUCESSO>);
               end else begin
                    putitemXml(gTEF_LANCAMENTO, 'cd_tefstatus', <STS_TEF_FALHA>);
              end;
      end;
      ('TEF_LANCAMENTO')->Salvar();
      discard 'TEF_LANCAMENTO';
    end;

      gTEF_LANCAMENTO := '';
      putitemXml(gTEF_LANCAMENTO, 'cd_tefstatus', <STS_TEF_INICIADO>);
      gTEF_LANCAMENTO := gModulo.ConsultarXmlUp('TEF_LANCAMENTO', '', gTEF_LANCAMENTO);
    if (xStatus < 0) then begin
        Result := SetStatus(<STS_AVISO>,xProcerror,xProcerrorcontext, cDS_METHOD);
    end else begin
      vNrCupons := 0;
      tTEF_LANCAMENTO.setocc(1);
      tTEF_LANCAMENTO.setocc(1);
      repeat
        vNrCupons := vNrCupons + 1;
        tTEF_LANCAMENTO.setocc(tTEF_LANCAMENTO.curocc() + 1);
      until (xStatus < 0);

      vNrContCupom := 0;
      tTEF_LANCAMENTO.setocc(1);
      repeat
        vNrContCupom := vNrContCupom + 1;
        if (vNrCupons > 0) then begin
          putitemXml(viParams, 'NR_CONTCUPOM', vNrContCupom);
          putitemXml(viParams, 'NR_TOTCUPOM', vNrCupons);
        end else begin
          putitemXml(viParams, 'NR_CONTCUPOM', 0);
          putitemXml(viParams, 'NR_TOTCUPOM', 0);
        end;
        putitemXml(viParams, '011-000', itemXml('tp_transacao', gTEF_LANCAMENTO));
        putitemXml(viParams, '010-000', itemXml('nm_redetef', gTEF_LANCAMENTO));
         BuscaOperador(piGlobal, viParams, voParams, xCdErro, xCtxErro);
        if (xStatus < 0) then begin
          putmess 'Erro buscando operador TEF: ' + xCtxErro';
        end;
        if (itemXml('TP_OPERCREDITO', voParams) = 3) or (itemXml('TP_OPERCREDITO', voParams) = '') then begin
          putitemXml(viParams, 'DS_FORMAPGTO', 'Cartao credito');
        end else if (itemXml('TP_OPERCREDITO', voParams) = 4) then begin
          putitemXml(viParams, 'DS_FORMAPGTO', 'Cartao debito');
        end else if (itemXml('TP_OPERCREDITO', voParams) = 2) or (itemXml('TP_OPERCREDITO', voParams) = 7) then begin
          putitemXml(viParams, 'DS_FORMAPGTO', 'Cheque');
        end else begin
          putitemXml(viParams, 'DS_FORMAPGTO', itemXml('DS_OPERCREDITO', voParams));
          putitemXml(viParams, 'NR_VIAS', itemXmlF('NR_VIAS', voParams));
        end;

        putitemXml(viParams, '000-000', itemXml('tp_arquivo', gTEF_LANCAMENTO));
        if (itemXml('nm_redetef', gTEF_LANCAMENTO) = 'TECBAN') then begin
          putitemXml(viParams, '000-001', 'DISC');
        end else begin
          putitemXml(viParams, '000-001', 'DIAL');
        end;
        putitemXml(viParams, '028-000', nr_linhas.tef_respostasvc);
        putitemXml(viParams, '029-000', ds_cupom.tef_respostasvc);
        putitemXml(viParams, '030-000', ds_mensagem.tef_respostasvc);

        AvisoEmissaoCupomTEF(piGlobal, viParams, Result, xCdErro, xCtxErro);
        if (xProcerror <> '')or (xStatus < 0) then begin
          if (itemXml('nr_nsu', gTEF_LANCAMENTO) <> '') or then begin
             (((putitemXml(gTEF_LANCAMENTO, 'tp_transacao', 1) or);
             (putitemXml(gTEF_LANCAMENTO, 'tp_transacao', 0)) and (itemXml('TEF_TIPO', gLSTPARAM)= <TEF_Discado>)));
            RecusarTEF(piGlobal, viParams, Result, xCdErro, xCtxErro);
            if (xProcerror <> '') then begin
              Result := SetStatus(STS_ERROR,xProcerror,xProcerrorcontext, cDS_METHOD);
            end else if (xStatus < 0) then begin
              Result := SetStatus('',xCdErro,xCtxErro,'');
            end else begin
              vStatus := STS_ERROR;
              break;
            end;
          end else begin
            putitemXml(gTEF_LANCAMENTO, 'CD_TEFSTATUS', <STS_TEF_FALHA>);
            message/error 'Transação não efetuada.  Favor reter o cupom.';
            ('TEF_RESPOSTASVC')->Excluir();
            ('TEF_LANCAMENTO')->Salvar();
          end;
          vStatus := STS_ERROR;
        end;
        if (xStatus = 5) then begin
          vNrContCupom := 0;
          putitemXml(viParams, 'IN_PARADA', True);
          tTEF_LANCAMENTO.setocc(1);
        end else begin
          putitemXml(viParams, 'IN_PARADA', False);
          tTEF_LANCAMENTO.setocc(tTEF_LANCAMENTO.curocc() + 1);
        end;
      until (xStatus < 0);
      xStatus := vStatus;
      if (xStatus >= 0) then begin
        tTEF_LANCAMENTO.setocc(1);
        while (xStatus >= 0) do begin
          if (itemXml('nr_nsu', gTEF_LANCAMENTO) <> '') or then begin
            (((putitemXml(gTEF_LANCAMENTO, 'tp_transacao', 1) or);
            (putitemXml(gTEF_LANCAMENTO, 'tp_transacao', 0)) and (itemXml('TEF_TIPO', gLSTPARAM)= <TEF_Discado>)));

            putitemXml(gTEF_LANCAMENTO, 'cd_tefstatus', <STS_TEF_APROVADO>);
            ('TEF_LANCAMENTO')->Salvar();

            putitemXml(viParams, '000-000', 'CNF');
            putitemXml(viParams, '001-000', itemXml('nr_identificacao', gTEF_LANCAMENTO));
            putitemXml(viParams, '002-000', itemXml('nr_docvinc', gTEF_LANCAMENTO));
            putitemXml(viParams, '010-000', itemXml('nm_redetef', gTEF_LANCAMENTO));
            putitemXml(viParams, '012-000', itemXml('nr_nsu', gTEF_LANCAMENTO));
            putitemXml(viParams, '027-000', itemXml('ds_finalizacao', gTEF_LANCAMENTO));
            GeraArquivoTef(piGlobal, viParams, voParams, xCdErro, xCtxErro);
            if (xProcerror <> '') then begin
              Result := SetStatus(STS_ERROR,xProcerror,xProcerrorcontext, cDS_METHOD);
            end else if (xStatus < 0) then begin
              Result := SetStatus('',xCdErro,xCtxErro,'');
            end else begin
              putitemXml(gTEF_LANCAMENTO, 'cd_tefstatus', <STS_TEF_SUCESSO>);
            end;
          end else begin
            putitemXml(gTEF_LANCAMENTO, 'cd_tefstatus', <STS_TEF_SUCESSO>);
          end;
          ('TEF_RESPOSTASVC')->Excluir();
          ('TEF_LANCAMENTO')->Salvar();
          tTEF_LANCAMENTO.setocc(tTEF_LANCAMENTO.curocc() + 1);
        end;
        xStatus := vStatus;
      end;
    end;
  end;
  
  return(xStatus);
end;

//----------------------------------------------------------
function T_TEFSVCO001.RecusarTEF(pParams : String) : String;
//----------------------------------------------------------
const
  cDS_METHOD = 'ADICONAL=Operação: T_TEFSVCO001.RecusarTEF()';
var
  viParams,voParams,vDsValor,vDsNsu : String;
begin

  if (itemXml('IN_LANCAMENTO', pParams) = 1) then begin
    gTEF_LANCAMENTO := '';
    putitemXml(gTEF_LANCAMENTO, 'cd_tefstatus', <STS_TEF_INICIADO>);
    gTEF_LANCAMENTO := gModulo.ConsultarXmlUp('TEF_LANCAMENTO', '', gTEF_LANCAMENTO);
    if (xStatus < 0) then begin
      return(0);
    end;
  end;

  viParams := pParams;
  tTEF_LANCAMENTO.setocc(1);
  while (xStatus >= 0) do begin
      putitemXml(gTEF_LANCAMENTO, 'cd_tefstatus', <STS_TEF_RECUSADO>);
      ('TEF_LANCAMENTO')->Salvar();

      if (itemXml('vl_transacao', gTEF_LANCAMENTO) > 0) then begin
        vDsValor := 'Valor: Rg ' + itemXml('vl_transacao', gTEF_LANCAMENTO)';
      end;
      if (itemXml('nr_nsu', gTEF_LANCAMENTO) > 0) then begin
        vDsNsu := 'NSU:' + itemXml('nr_nsu', gTEF_LANCAMENTO)';
      end;

      putitemXml(viParams, '000-000', 'NCN');
      putitemXml(viParams, '001-000', itemXml('nr_identificacao', gTEF_LANCAMENTO));
      putitemXml(viParams, '002-000', itemXml('nr_docvinc', gTEF_LANCAMENTO));
      putitemXml(viParams, '010-000', itemXml('nm_redetef', gTEF_LANCAMENTO));
      putitemXml(viParams, '012-000', itemXml('nr_nsu', gTEF_LANCAMENTO));
      putitemXml(viParams, '027-000', itemXml('ds_finalizacao', gTEF_LANCAMENTO));
      GeraArquivoTef(piGlobal, viParams, voParams, xCdErro, xCtxErro);
      if (xProcerror <> '') then begin
        Result := SetStatus(STS_ERROR,xProcerror,xProcerrorcontext, cDS_METHOD);
      end else if (xStatus < 0) then begin
        Result := SetStatus('',xCdErro,xCtxErro,'');
      end else begin
        putitemXml(gTEF_LANCAMENTO, 'CD_TEFSTATUS', <STS_TEF_FALHA>);
      end;
      ('TEF_RESPOSTASVC')->Excluir();
      ('TEF_LANCAMENTO')->Salvar();
      tTEF_LANCAMENTO.setocc(tTEF_LANCAMENTO.curocc() + 1);
  end;

  message/error 'Transação não efetuada.  Favor reter o cupom.';

  return(0);
end;

//---------------------------------------------------------------
function T_TEFSVCO001.VerPendenciaTEF(pParams : String) : String;
//---------------------------------------------------------------
const
  cDS_METHOD = 'ADICONAL=Operação: T_TEFSVCO001.VerPendenciaTEF()';
var
  viParams,voParams,vDsValor : String;
begin

  Result := SetStatus(<STS_LOG>,'CFI0002','', cDS_METHOD);
  activateCmp('ADMSVCO001','GetParamGrupoEmp',itemXml','CD_EMPRESA', piGlobal), 'TEF', gLSTPARAM, xCdErro, xCtxErro);
  if (xProcerror <> '') then begin
      Result := SetStatus(STS_ERROR,xProcerror,xProcerrorcontext, cDS_METHOD);
  end else if (xCdErro <> '') then begin
      Result := SetStatus('',xCdErro,xCtxErro,'');
  end else begin
    putitemXml(pParams, '000-000', 'PendENCIA');
    if (itemXml('TEF_TIPO', gLSTPARAM) = 2) then begin
      putitemXml(pParams, '000-001', 'DISC');
      LerPendencias(piGlobal, pParams, Result, xCdErro, xCtxErro);
      putitemXml(pParams, '000-001', 'DIAL');
      LerPendencias(piGlobal, pParams, Result, xCdErro, xCtxErro);
    end else begin
      LerPendencias(piGlobal, pParams, Result, xCdErro, xCtxErro);
       end;

      gTEF_LANCAMENTO := '';
      putitemXml(gTEF_LANCAMENTO, 'cd_tefstatus', '<STS_TEF_INICIADO>·);
      gTEF_LANCAMENTO := gModulo.ConsultarXmlUp('TEF_LANCAMENTO', '', gTEF_LANCAMENTO);
      while (dbocc(TEF_LANCAMENTO) > 0) do begin
          if (itemXml('cd_tefstatus', gTEF_LANCAMENTO) = <STS_TEF_INICIADO>) then begin
        if (itemXml('nr_nsu', gTEF_LANCAMENTO) <> '') or then begin
          (((putitemXml(gTEF_LANCAMENTO, 'tp_transacao', 1) or);
          (putitemXml(gTEF_LANCAMENTO, 'tp_transacao', 0)) and (itemXml('TEF_TIPO', gLSTPARAM)= <TEF_Discado>)));
          putitemXml(gTEF_LANCAMENTO, 'cd_tefstatus', <STS_TEF_RECUSADO>);
          ('TEF_LANCAMENTO')->Salvar();

              if (itemXml('vl_transacao', gTEF_LANCAMENTO) <> '') then begin
                  vDsValor := 'Valor: Rg ' + itemXml('vl_transacao', gTEF_LANCAMENTO)';
              end;
          message/error 'Última transação TEF foi cancelada.Rede:' + itemXml('nm_redetef', gTEF_LANCAMENTO)NSU:' + nr_nsu.TEF_LANCAMENTO' + vDsValor';

              putitemXml(viParams, '000-000', 'NCN');
          putitemXml(viParams, '001-000', itemXml('nr_identificacao', gTEF_LANCAMENTO));
          putitemXml(viParams, '002-000', itemXml('nr_docvinc', gTEF_LANCAMENTO));
          putitemXml(viParams, '010-000', itemXml('nm_redetef', gTEF_LANCAMENTO));
          putitemXml(viParams, '012-000', itemXml('nr_nsu', gTEF_LANCAMENTO));
          putitemXml(viParams, '027-000', itemXml('ds_finalizacao', gTEF_LANCAMENTO));
          if (itemXml('nm_redetef', gTEF_LANCAMENTO) = 'TECBAN') then begin
            putitemXml(viParams, '000-001', 'DISC');
          end else begin
            putitemXml(viParams, '000-001', 'DIAL');
          end;
          GeraArquivoTef(piGlobal, viParams, voParams, xCdErro, xCtxErro);
          if (xProcerror <> '') then begin
            Result := SetStatus(STS_ERROR,xProcerror,xProcerrorcontext, cDS_METHOD);
          end else if (xCdErro <> '') then begin
            Result := SetStatus('',xCdErro,xCtxErro,'');
          end else begin
                 putitemXml(gTEF_LANCAMENTO, 'cd_tefstatus', <STS_TEF_FALHA>);
          end;
        end else begin
          putitemXml(gTEF_LANCAMENTO, 'cd_tefstatus', <STS_TEF_FALHA>);
        end;
        end else begin
        if (itemXml('nr_nsu', gTEF_LANCAMENTO) <> '') or then begin
            (((putitemXml(gTEF_LANCAMENTO, 'tp_transacao', 1) or);
            (putitemXml(gTEF_LANCAMENTO, 'tp_transacao', 0)) and (itemXml('TEF_TIPO', gLSTPARAM)= <TEF_Discado>)));

            putitemXml(gTEF_LANCAMENTO, 'cd_tefstatus', <STS_TEF_APROVADO>);
            ('TEF_LANCAMENTO')->Salvar();

            putitemXml(viParams, '000-000', 'CNF');
            putitemXml(viParams, '001-000', itemXml('nr_identificacao', gTEF_LANCAMENTO));
            putitemXml(viParams, '002-000', itemXml('nr_docvinc', gTEF_LANCAMENTO));
            putitemXml(viParams, '010-000', itemXml('nm_redetef', gTEF_LANCAMENTO));
            putitemXml(viParams, '012-000', itemXml('nr_nsu', gTEF_LANCAMENTO));
            putitemXml(viParams, '027-000', itemXml('ds_finalizacao', gTEF_LANCAMENTO));
            GeraArquivoTef(piGlobal, viParams, voParams, xCdErro, xCtxErro);
            if (xProcerror <> '') then begin
              Result := SetStatus(STS_ERROR,xProcerror,xProcerrorcontext, cDS_METHOD);
            end else if (xStatus < 0) then begin
              Result := SetStatus('',xCdErro,xCtxErro,'');
            end else begin
              putitemXml(gTEF_LANCAMENTO, 'cd_tefstatus', <STS_TEF_SUCESSO>);
            end;
        end else begin
          putitemXml(gTEF_LANCAMENTO, 'cd_tefstatus', <STS_TEF_SUCESSO>);
        end;
      end;
      ('TEF_RESPOSTASVC')->Excluir();
      ('TEF_LANCAMENTO')->Salvar();
          discard 'TEF_LANCAMENTO';
    end;
  end;
  return(0);
end;

//-------------------------------------------------------------
function T_TEFSVCO001.LerPendencias(pParams : String) : String;
//-------------------------------------------------------------
const
  cDS_METHOD = 'ADICONAL=Operação: T_TEFSVCO001.LerPendencias()';
begin
  LerArqRespostaTEF(piGlobal, pParams, Result, xCdErro, xCtxErro);
  if (xProcerror <> '') then begin
    Result := SetStatus(STS_ERROR,xProcerror,xProcerrorcontext, cDS_METHOD);
  end else if (xStatus < 0) then begin
    ResetErro();
  end else begin
    gTEF_LANCAMENTO := '';
    putitemXml(gTEF_LANCAMENTO, 'nr_identificacao', itemXml('001-000', Result));
    gTEF_LANCAMENTO := gModulo.ConsultarXmlUp('TEF_LANCAMENTO', '', gTEF_LANCAMENTO);
    if (xStatus = -2) then begin
      ('TEF_LANCAMENTO')->Adicionar(piGlobal, Result);
      ('TEF_RESPOSTASVC')->Adicionar(piGlobal, Result);
      ('TEF_LANCAMENTO')->Salvar();
    end;
  end;
end;

//-------------------------------;
//--------------------------------------------------------------
function T_TEFSVCO001.GeraArquivoTef(pParams : String) : String;
//--------------------------------------------------------------
const
  cDS_METHOD = 'ADICONAL=Operação: T_TEFSVCO001.GeraArquivoTef()';
var
  vDsLinha,vDsItem,vNmItem,vNmArq,vDirArq,vDsArq : String;
  vNrIdentificacao : Real;
  vStatus : String;
begin
  Result := SetStatus(<STS_LOG>,'CFI0002','', cDS_METHOD);
  activateCmp('ADMSVCO001','GetParamGrupoEmp',itemXml','CD_EMPRESA', piGlobal), 'TEF', gLSTPARAM, xCdErro, xCtxErro);
  if (xProcerror <> '') then begin
      Result := SetStatus(STS_ERROR,xProcerror,xProcerrorcontext, cDS_METHOD);
  end else if (xCdErro < 0) then begin
      Result := SetStatus('',xCdErro,xCtxErro,'');
  end;
    newinstance 'GERSVCO001', 'GERSVCO001', 'TRANSACTION=TRUE';
  activateCmp('GERSVCO001','GetNumSeqComm',piGlobal, 'TEF_TRANSACAO', '001-000', 999999999, vNrIdentificacao, xCdErro, xCtxErro);
  if (xProcerror <> '') then begin
      Result := SetStatus(STS_ERROR,xProcerror,xProcerrorcontext, cDS_METHOD);
  end else if (xStatus < 0) then begin
      Result := SetStatus('',xCdErro,xCtxErro,'');
  end else begin
      putitemXml(pParams, '001-000', vNrIdentificacao);

    gTEF_ARQUIVO := '';
    putitemXml(gTEF_ARQUIVO, 'cd_arquivo', itemXml('000-000', pParams));
    putitemXml(gTEF_ARQUIVO, 'tp_tef', itemXml('TEF_TIPO', gLstparam));
    gTEF_ARQUIVO := gModulo.ConsultarXmlUp('TEF_ARQUIVO', '', gTEF_ARQUIVO);
    if (xStatus < 0) then begin
        Result := SetStatus(STS_ERROR,xProcerror,xProcerrorcontext, cDS_METHOD);
      return(xStatus);
    end else begin
        setocc 'TEF_CAMPOARQSVC', -1;
        setocc 'TEF_CAMPOARQSVC', 1;
        vDsArq := '';
        while (dbocc('TEF_CAMPOARQSVC') > 0) do begin
             vDsLinha := '';

             vDsItem := itemXml(NR_CAMPO.TEF_CAMPOSVC, pParams);

             if (in_obrigatorio.tef_campoarqsvc) and (itemXml('TEF_TIPO', gLSTPARAM) = <TEF_Dedicado>) then begin
           if (vDsItem = '') then begin
            if (vl_padrao.tef_camposvc = '') then begin
              Result := SetStatus(STS_ERROR,'PAR0001','', cDS_METHOD);
                         return(-1); exit;
                    end else begin
              vDsItem := vl_padrao.tef_camposvc;
            end;
          end else begin
            vDsLinha := '' + nr_campo.tef_campoarqsvc := ' + vDsItem';
                end;
             end else begin
                 if (vDsItem <> '') then begin
                     vDsLinha := '' + nr_campo.tef_campoarqsvc := ' + vDsItem';
                 end else if (vl_padrao.tef_camposvc <> '') then begin
                     vDsLinha := '' + nr_campo.tef_campoarqsvc := ' + vl_padrao.tef_camposvc';
                 end;
             end;
             if (vDsLinha <> '') then begin
                 vDsArq := '' + vDsArq' + vDsLinha';
             end;
             discard 'TEF_CAMPOARQSVC';
        end;
        if (itemXml('TEF_TIPO', gLSTPARAM) = 1) then begin
            vDirArq := itemXml('TEF_ARQ_REQ_DEDICADO', gLSTPARAM);
        end else begin
        if (itemXml('000-001', pParams) = 'DISC') then begin
              vDirArq := itemXml('TEF_ARQ_REQ_DISC', gLSTPARAM);
        end else begin
          vDirArq := itemXml('TEF_ARQ_REQ_DIAL', gLSTPARAM);
        end;
        end;
        vNmArq := itemXml('TEF_ARQ_NOME', gLSTPARAM);
        filedump vDsArq, '' + vDirArq' + vNmArq';
        if (xProcerror <> '') then begin
        Result := SetStatus(STS_ERROR,'TEF0001','', cDS_METHOD);
        end;
    end;
    putitemXml(pParams, '000-000', 'STATUS');
    putitemXml(pParams, '001-000', vNrIdentificacao);
    LerArqRespostaTEF(piGlobal, pParams, Result, xCdErro, xCtxErro);
    if (xProcerror <> '') then begin
      Result := SetStatus(STS_ERROR,xProcerror,xProcerrorcontext,'');
    end else if (xStatus < 0) then begin
      vStatus=xStatus;
      activateCmp('winapi','deletefile','' + vDirArq' + vNmArq');
      if (xStatus<0) then begin
        if (itemXml('TEF_TIPO', piGlobal) = 1) then begin
          Result := SetStatus(STS_ERROR,'TEF0011','', cDS_METHOD);
        end else begin
          Result := SetStatus(STS_ERROR,'TEF0002','', cDS_METHOD);
        end;
        end else begin
        if (itemXml('TEF_TIPO', piGlobal) = 1) then begin
          Result := SetStatus(STS_ERROR,'TEF0011','', cDS_METHOD);
        end else begin
          Result := SetStatus(STS_ERROR,'TEF0002','', cDS_METHOD);
        end;
        end;
      xStatus=vStatus;
    end;
  end;

  return(xStatus);
end;

//-----------------------------------------------------------------
function T_TEFSVCO001.LerArqRespostaTEF(pParams : String) : String;
//-----------------------------------------------------------------
const
  cDS_METHOD = 'ADICONAL=Operação: T_TEFSVCO001.LerArqRespostaTEF()';
var
  vDsLinha,vDsItem,vNmItem,vNmArq,vDirArq : String;
  vNrIdentificacao,vQtTentativa,vStatus,vTIMEOUT : Real;
begin
  Result := SetStatus(<STS_LOG>,'CFI0002','', cDS_METHOD);
  if (itemXml('000-000', pParams) = 'STATUS') then begin
      vNmArq := itemXml('TEF_ARQ_NOME_STATUS', gLSTPARAM);
  end else begin
      vNmArq := itemXml('TEF_ARQ_NOME', gLSTPARAM);
  end;
  if (itemXml('TEF_TIPO', gLSTPARAM) = 1) then begin
      vDirArq := itemXml('TEF_ARQ_RES_DEDICADO', gLSTPARAM);
  end else begin
    if (itemXml('000-001', pParams) = 'DISC') then begin
          vDirArq := itemXml('TEF_ARQ_RES_DISC', gLSTPARAM);
    end else begin
      vDirArq := itemXml('TEF_ARQ_RES_DIAL', gLSTPARAM);
    end;
  end;
  if (itemXml('TEF_TIMEOUT', pParams) <> '') then begin
    vTIMEOUT = itemXml('TEF_TIMEOUT', pParams)  if (gDsDirReq = '') then begin
    gDsDirReq := 'C:\CLIENT\REQ\';
  end;

  end else begin
    vTIMEOUT := itemXml('TEF_TIMEOUT', gLSTPARAM);
  end;
  vDirArq := '' + vDirArq' + vNmArq';
  vStatus := 0;
  repeat

    fileload/raw vDirarq, vDsArq;
    if (xProcerror <> '') or (xStatus = 0) then begin
      vStatus := -1;
      activateCmp('KERNEL32','SLEEP',1000);
      if (itemXml('000-000', pParams) = 'STATUS')   or then begin
         (itemXml('000-000', pParams) := 'PendENCIA');
        vQtTentativa := vQtTentativa + 1;
      end;
    end else begin
      ConverterArqTEF(piGlobal, vDsArq, Result, xCdErro, xCtxErro);
        if (xProcerror <> '') then begin
            Result := SetStatus(STS_ERROR,xProcerror,xProcerrorcontext, cDS_METHOD);
        end else if(xStatus < 0);
            Result := SetStatus('',xCdErro,xCtxErro,'');
        end else begin
            activateCmp('winapi','deletefile',vDirArq);
            if (xProcerror <> '') then begin
                Result := SetStatus(STS_ERROR,xProcerror,xProcerrorcontext, cDS_METHOD);
            end else if(xStatus <= 0);
          Result := SetStatus(STS_ERROR,'TEF0004','', cDS_METHOD);
            end;
        end;
          if (itemXml('001-000', pParams) <> itemXml('001-000', Result)) and (itemXml('000-000', Result) <> 'PendENCIA') then begin
              vStatus := -1;
          end else begin
          vStatus := 0;
          end;
     end;
  until (vStatus := 0) or (vQtTentativa > vTIMEOUT);

  if (itemXml('000-000', pParams) = 'PendENCIA') and (vQtTentativa <= vTIMEOUT) then begin
    activateCmp('winapi','deletefile','' + vDirArq' + vNmArq');
  end else begin
    if (vQtTentativa > vTIMEOUT) then begin
      Result := SetStatus(STS_ERROR,'TEF0005','', cDS_METHOD);
    end;
  end;
end;

//---------------------------------------------------------------
function T_TEFSVCO001.ConverterArqTEF(pParams : String) : String;
//---------------------------------------------------------------
const
  cDS_METHOD = 'ADICONAL=Operação: T_TEFSVCO001.ConverterArqTEF()';
var
  vDsLinha,vDsItem,vNmItem,vNmArq,vDirArq,vDsArq : String;
  vNrIdentificacao,vNrLinha : Real;
begin
  Result := SetStatus(<STS_LOG>,'CFI0002','', cDS_METHOD);

  length pParams;
  while(gResult > 0) do begin
    scan pParams, '{.{+';
    if (gResult > 0) then begin
      vDsLinha := pParams[1, gResult - 1];
      pParams := pParams[gResult + 4];
    end else begin
      vDsLinha := pParams;
      pParams := '';
    end;
    putitemXml(Result, vDsLinha[1, 7], vDsLinha[11]);
    vNrLinha := vNrLinha + 1;
    length pParams;
  end;

  return(0);
end;

//--------------------------------------------------------------------
function T_TEFSVCO001.AvisoEmissaoCupomTEF(pParams : String) : String;
//--------------------------------------------------------------------
const
  cDS_METHOD = 'ADICONAL=Operação: T_TEFSVCO001.AvisoEmissaoCupomTEF()';
begin
  Result := activateCmp('TEFFL001','exec', pParams);
  if (xProcerror <> '') then begin
    Result := SetStatus(STS_ERROR,xProcerror,xProcerrorcontext,'');
  end;
  return(xStatus);
end;

//-------------------------------------------------------------
function T_TEFSVCO001.BuscaOperador(pParams : String) : String;
//-------------------------------------------------------------
const
  cDS_METHOD = 'ADICONAL=Operação: T_TEFSVCO001.BuscaOperador()';
begin
  BuscaOperador(piGlobal, pParams, Result, xCdErro, xCtxErro);
  return(xStatus);
end;

//------------------------------------------------------------
function T_TEFSVCO001.ValidaNumero(pParams : String) : String;
//------------------------------------------------------------
const
  cDS_METHOD = 'ADICONAL=Operação: T_TEFSVCO001.ValidaNumero()';

  Result := SetStatus(<STS_LOG>,'CFI0002','', cDS_METHOD);

  length strIN;
  while (gResult > 0) do begin
    if ((strIN[1:1] >= '0') and (strIN[1:1] <= '9')) then begin
      strOUT := '' + strOUT' + strIN[1:1]';
    end;
    strIN := strIN[2];
    length strIN;
  end;
  return(0);
end;
*)
end.
