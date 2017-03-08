unit cFCCSVCO001;

interface

(* COMPONENTES 
  GERSVCO032 / SICSVCO002 / 
*)        

uses
  Classes, SysUtils, Math, DB,
  cDataSetUnf;

type
  T_FCCSVCO001 = class(TComponent)
  private
    tFCC_AUTOPAG,
    tFCC_CTAPES,
    tFCC_TPMANUT,
    tFCC_TPMANUTUS,
    tGER_TERMINAL,
    tTMP_NR,
    tTMP_NR08 : TcDatasetUnf;
    function getParam(pParams : String = '') : String;
    function setEntidade(pParams : String = '') : String;
  protected
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;    
  published
    function CargaTpManut(pParams : String = '') : String;
    function CargaTpManutUsu(pParams : String = '') : String;
    function gravaAutoPag(pParams : String = '') : String;
    function LstTpManUsu(pParams : String = '') : String;
    function cargaCxUsuario(pParams : String = '') : String;
    function cargaTerminal(pParams : String = '') : String;
  end;

implementation

uses
  cADMSVCO001,
  cActivate, cStatus, cFuncao, cXml, dModulo;

var


//---------------------------------------------------------------
constructor T_FCCSVCO001.Create(AOwner: TComponent);
//---------------------------------------------------------------
begin
  inherited Create(AOwner);
  setEntidade('');
end;

//--------------------------------
destructor T_FCCSVCO001.Destroy;
//--------------------------------
begin
  inherited Destroy;
end;

//---------------------------------------------------------------
function T_FCCSVCO001.getParam(pParams : String = '') : String;
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

  xParamEmp := T_ADMSVCO001.GetParamEmpresa(piCdEmpresa, xParamEmp);


end;

//---------------------------------------------------------------
function T_FCCSVCO001.setEntidade(pParams : String = '') : String;
//---------------------------------------------------------------
begin
  tFCC_AUTOPAG := TcDatasetUnf.getEntidade('FCC_AUTOPAG');
  tFCC_CTAPES := TcDatasetUnf.getEntidade('FCC_CTAPES');
  tFCC_TPMANUT := TcDatasetUnf.getEntidade('FCC_TPMANUT');
  tFCC_TPMANUTUS := TcDatasetUnf.getEntidade('FCC_TPMANUTUS');
  tGER_TERMINAL := TcDatasetUnf.getEntidade('GER_TERMINAL');
  tTMP_NR := TcDatasetUnf.getEntidade('TMP_NR');
  tTMP_NR08 := TcDatasetUnf.getEntidade('TMP_NR08');
end;

//------------------------------------------------------------
function T_FCCSVCO001.CargaTpManut(pParams : String) : String;
//------------------------------------------------------------
const
  cDS_METHOD = 'ADICONAL=Operação: T_FCCSVCO001.CargaTpManut()';
begin
  Result := '';
  clear_e(tFCC_TPMANUT);
  retrieve_e(tFCC_TPMANUT);
  setocc(tFCC_TPMANUT, 1);
  if (empty(FCC_TPMANUT) = False) then begin
    repeat

        if (Result = '') then begin
          Result := '' + item_f('TP_MANUTENCAO', tFCC_TPMANUT)=' + item_a('DS_MANUTENCAO', tFCC_TPMANUT)' + ' + ';
        end else begin
          Result := '' + Result + ';
        end;

      setocc(tFCC_TPMANUT, curocc(tFCC_TPMANUT) + 1);
    until (xStatus < 0);
  end;
  return(0); exit;
end;

//---------------------------------------------------------------
function T_FCCSVCO001.CargaTpManutUsu(pParams : String) : String;
//---------------------------------------------------------------
const
  cDS_METHOD = 'ADICONAL=Operação: T_FCCSVCO001.CargaTpManutUsu()';
var
  vCdEmp, vCdUsu, vTpMan : Real;
begin
  Result := '';
  vCdEmp := itemXmlF('CD_EMPRESA', pParams);
  vCdUsu := itemXmlF('CD_USUARIO', pParams);
  vTpMan := itemXmlF('TP_MANUTENCAO', pParams);

  clear_e(tFCC_TPMANUT);
  if (vTpMan <> '') then begin
    putitem_e(tFCC_TPMANUT, 'TP_MANUTENCAO', vTpMan);
  end;
  retrieve_e(tFCC_TPMANUT);
  setocc(tFCC_TPMANUT, 1);
  if (empty(FCC_TPMANUT) = False) then begin
    repeat
      clear_e(tFCC_TPMANUTUS);
      putitem_e(tFCC_TPMANUTUS, 'CD_EMPRESA', vCdEmp);
      putitem_e(tFCC_TPMANUTUS, 'CD_USULIBERADO', vCdUsu);
      putitem_e(tFCC_TPMANUTUS, 'TP_MANUTENCAO', item_f('TP_MANUTENCAO', tFCC_TPMANUT));
      retrieve_e(tFCC_TPMANUTUS);
      setocc(tFCC_TPMANUTUS, 1);
      if (empty(FCC_TPMANUTUS) = False) then begin
        repeat

            if (Result = '') then begin
              Result := '' + item_f('TP_MANUTENCAO', tFCC_TPMANUT)=' + item_a('DS_MANUTENCAO', tFCC_TPMANUT)' + ' + ';
            end else begin
              Result := '' + Result + ';
            end;

          setocc(tFCC_TPMANUTUS, curocc(tFCC_TPMANUTUS) + 1);
        until (xStatus < 0);
      end;
      xStatus := 0;
      setocc(tFCC_TPMANUT, curocc(tFCC_TPMANUT) + 1);
    until (xStatus < 0);
    xStatus := 0;
  end;
  return(0); exit;
end;

//------------------------------------------------------------
function T_FCCSVCO001.gravaAutoPag(pParams : String) : String;
//------------------------------------------------------------
const
  cDS_METHOD = 'ADICONAL=Operação: T_FCCSVCO001.gravaAutoPag()';
var
  (* string piGlobal : IN *)
  vDtAutorizacao : TDate;
  vNrSeqAuto, vNrSeqCheque, vVlTransferencia, vNrCtaPes : Real;
begin
  vDtAutorizacao := itemXml('DT_AUTORIZACAO', pParams);
  vNrSeqAuto := itemXmlF('NR_SEQAUTO', pParams);
  vNrSeqCheque := itemXmlF('NR_SEQCHEQUE1', pParams);
  vVlTransferencia := itemXmlF('VL_TRANSFERENCIA', pParams);
  vNrCtaPes := itemXmlF('NR_CTAPES', pParams);

  clear_e(tFCC_AUTOPAG);
  putitem_e(tFCC_AUTOPAG, 'DT_AUTORIZACAO', vDtAutorizacao);
  putitem_e(tFCC_AUTOPAG, 'NR_SEQAUTO', vNrSeqAuto);
  putitem_e(tFCC_AUTOPAG, 'NR_SEQCHEQUE', vNrSeqCheque);
  putitem_e(tFCC_AUTOPAG, 'NR_SEQPAG', 1);
  retrieve_o(tFCC_AUTOPAG);
  if (xStatus = -7) then begin
    retrieve_x(tFCC_AUTOPAG);
  end;

  putitem_e(tFCC_AUTOPAG, 'CD_OPERADOR', itemXmlF('CD_USUARIO', PARAM_GLB));
  putitem_e(tFCC_AUTOPAG, 'DT_CADASTRO', Now);
  putitem_e(tFCC_AUTOPAG, 'VL_PAGAMENTO', vVlTransferencia);
  putitem_e(tFCC_AUTOPAG, 'NR_CTAPES', vNrCtaPes);

  tFCC_AUTOPAG.Salvar()
  if (xStatus < 0) then begin
    Result := voParams;
    return(-1); exit;
  end;

  return(0); exit;
end;

//-----------------------------------------------------------
function T_FCCSVCO001.LstTpManUsu(pParams : String) : String;
//-----------------------------------------------------------
const
  cDS_METHOD = 'ADICONAL=Operação: T_FCCSVCO001.LstTpManUsu()';
var
  vCdEmp, vCdUsu : Real;
begin
  Result := '';
  vCdEmp := itemXmlF('CD_EMPRESA', pParams);
  vCdUsu := itemXmlF('CD_USUARIO', pParams);
  clear_e(tFCC_TPMANUT);
  retrieve_e(tFCC_TPMANUT);
  setocc(tFCC_TPMANUT, 1);
  if (empty(FCC_TPMANUT) = False) then begin
    repeat
      clear_e(tFCC_TPMANUTUS);
      putitem_e(tFCC_TPMANUTUS, 'CD_EMPRESA', vCdEmp);
      putitem_e(tFCC_TPMANUTUS, 'CD_USULIBERADO', vCdUsu);
      putitem_e(tFCC_TPMANUTUS, 'TP_MANUTENCAO', item_f('TP_MANUTENCAO', tFCC_TPMANUT));
      retrieve_e(tFCC_TPMANUTUS);
      setocc(tFCC_TPMANUTUS, 1);
      if (empty(FCC_TPMANUTUS) = False) then begin
        repeat

          if (Result = '') then begin
            Result := '' + item_f('TP_MANUTENCAO', tFCC_TPMANUT)' + ';
          end else begin
            Result := '' + Resultor' + item_f('TP_MANUTENCAO', tFCC_TPMANUT)' + ' + ';
          end;

          setocc(tFCC_TPMANUTUS, curocc(tFCC_TPMANUTUS) + 1);
        until (xStatus < 0);
      end;
      xStatus := 0;
      setocc(tFCC_TPMANUT, curocc(tFCC_TPMANUT) + 1);
    until (xStatus < 0);
    xStatus := 0;
  end;
  return(0); exit;
end;

//--------------------------------------------------------------
function T_FCCSVCO001.cargaCxUsuario(pParams : String) : String;
//--------------------------------------------------------------
const
  cDS_METHOD = 'ADICONAL=Operação: T_FCCSVCO001.cargaCxUsuario()';
var
  (* string piGlobal : IN *)
  vTpManutencao : Real;
  vInInativo : Boolean;
begin
  vTpManutencao := itemXmlF('CD_TPMANUT_CXUSUARIO', pParams);
  if (vTpManutencao = 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Não existe parametro com o código de mantenção da conta para usuário', cDS_METHOD);
    return(-1); exit;
  end;

  vInInativo := itemXmlB('IN_INATIVO', pParams);

  clear_e(tTMP_NR08);

  clear_e(tFCC_CTAPES);
  putitem_e(tFCC_CTAPES, 'TP_MANUTENCAO', vTpManutencao);
  if (vInInativo <> True) then begin
    putitem_e(tFCC_CTAPES, 'IN_ATIVO', True);
  end;
  retrieve_e(tFCC_CTAPES);
  if (xStatus >= 0) then begin
    setocc(tFCC_CTAPES, 1);
    while (xStatus >= 0) do begin
      if (item_f('CD_OPERCAIXA', tFCC_CTAPES) > 0) then begin
        creocc(tTMP_NR08, -1);
        putitem_e(tTMP_NR08, 'NR_08', item_f('CD_OPERCAIXA', tFCC_CTAPES));
        retrieve_o(tTMP_NR08);
        if (xStatus = -7) then begin
          retrieve_x(tTMP_NR08);
        end;

        putitem_e(tTMP_NR08, 'DS_TITULAR', item_a('DS_TITULAR', tFCC_CTAPES));
      end;

      setocc(tFCC_CTAPES, curocc(tFCC_CTAPES) + 1);
    end;
  end;

  Result := '';

  if (empty(tTMP_NR08) = False) then begin
    setocc(tTMP_NR08, 1);
    while (xStatus >= 0) do begin
      if (Result = '') then begin
        Result := '' + NR_ + 'item_a('08', tTMP_NR08)=' + item_a('DS_TITULAR', tTMP_NR) + '08SVC';
      end else begin
        Result := '' + Result + ';
      end;

      setocc(tTMP_NR08, curocc(tTMP_NR08) + 1);
    end;
  end;

  return(0); exit;
end;

//-------------------------------------------------------------
function T_FCCSVCO001.cargaTerminal(pParams : String) : String;
//-------------------------------------------------------------
const
  cDS_METHOD = 'ADICONAL=Operação: T_FCCSVCO001.cargaTerminal()';
var
  (* string piGlobal : IN *)
  vDsLstEmpresa, viParams, voParams : String;
begin
  viParams := '';
  putitemXml(viParams, 'CD_GRUPOEMPRESA', itemXmlF('CD_GRUPOEMPRESA', PARAM_GLB));
  voParams := activateCmp('GERSVCO032', 'buscaLstGrupoEmpresa', viParams);
  if (xStatus < 0) then begin
    Result := voParams;
    return(-1); exit;
  end;

  vDsLstEmpresa := itemXmlF('CD_EMPRESA', voParams);

  viParams := '';
  putitemXml(viParams, 'IN_CCUSTO', True);
  putitemXml(viParams, 'CD_EMPRESA', vDsLstEmpresa);
  putitemXml(viParams, 'CD_EMPVALIDACAO', itemXmlF('CD_EMPRESA', PARAM_GLB));
  voParams := activateCmp('SICSVCO002', 'validaLocal', viParams);
  if (xStatus < 0) then begin
    Result := voParams;
    return(-1); exit;
  end;

  vDsLstEmpresa := itemXmlF('CD_EMPRESA', voParams);

  clear_e(tGER_TERMINAL);
  putitem_e(tGER_TERMINAL, 'CD_EMPRESA', vDsLstEmpresa);
  retrieve_e(tGER_TERMINAL);
  if (xStatus >= 0) then begin
    setocc(tGER_TERMINAL, 1);
    while (xStatus >= 0) do begin
      if (Result = '') then begin
        Result := '' + item_f('CD_TERMINAL', tGER_TERMINAL)=' + item_a('DS_TERMINAL', tGER_TERMINAL)' + ' + ';
      end else begin
        Result := '' + Result + ';
      end;

      setocc(tGER_TERMINAL, curocc(tGER_TERMINAL) + 1);
    end;
  end;

  return(0); exit;
end;

end.
