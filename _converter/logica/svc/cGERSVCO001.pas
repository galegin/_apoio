unit cGERSVCO001;

interface

(* COMPONENTES 
  ADMSVCO001 / FISSVCO019 / 
*)        

uses
  Classes, SysUtils, Math, DB,
  cDataSetUnf;

type
  T_GERSVCO001 = class(TComponent)
  private
    tFIS_NF,
    tFIS_S_NF,
    tGER_EMPRESA,
    tGER_NREMPSEQ,
    tGER_NUMSEQ : TcDatasetUnf;
    function getParam(pParams : String = '') : String;
    function setEntidade(pParams : String = '') : String;
  protected
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;    
  published
    function getNumSeq(pParams : String = '') : String;
    function getNumSeqAnt(pParams : String = '') : String;
    function getNumSeqEmp(pParams : String = '') : String;
    function GetNumNF(pParams : String = '') : String;
    function GetNumSeqNF(pParams : String = '') : String;
    function AlteraNrNF(pParams : String = '') : String;
    function setNumSeqNF(pParams : String = '') : String;
    function getNumSeqComm(pParams : String = '') : String;
    function CLEANUP(pParams : String = '') : String;
    function buscaNrNF(pParams : String = '') : String;
  end;

implementation

uses
  cADMSVCO001,
  cActivate, cStatus, cFuncao, cXml, dModulo;

var
  gInUtilizaNsu,
  gInUtilizaSeloFiscal,
  gNrMaxIntervaloNF : String;

//---------------------------------------------------------------
constructor T_GERSVCO001.Create(AOwner: TComponent);
//---------------------------------------------------------------
begin
  inherited Create(AOwner);
  setEntidade('');
end;

//--------------------------------
destructor T_GERSVCO001.Destroy;
//--------------------------------
begin
  inherited Destroy;
end;

//---------------------------------------------------------------
function T_GERSVCO001.getParam(pParams : String = '') : String;
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
  putitem(xParam, 'IN_UTILIZA_NSU');

  xParam := T_ADMSVCO001.GetParametro(xParam);

  gInUtilizaNsu := itemXml('IN_UTILIZA_NSU', xParam);
  gInUtilizaSeloFiscal := itemXml('IN_UTILIZA_SELO_FISCAL', xParam);
  gNrMaxIntervaloNF := itemXml('NR_MAX_INTERVALO_NF', xParam);

  xParamEmp := '';
  putitem(xParamEmp, 'IN_UTILIZA_NSU');
  putitem(xParamEmp, 'IN_UTILIZA_SELO_FISCAL');
  putitem(xParamEmp, 'NR_MAX_INTERVALO_NF');

  xParamEmp := T_ADMSVCO001.GetParamEmpresa(piCdEmpresa, xParamEmp);

  gInUtilizaSeloFiscal := itemXml('IN_UTILIZA_SELO_FISCAL', xParamEmp);
  gNrMaxIntervaloNF := itemXml('NR_MAX_INTERVALO_NF', xParamEmp);

end;

//---------------------------------------------------------------
function T_GERSVCO001.setEntidade(pParams : String = '') : String;
//---------------------------------------------------------------
begin
  tFIS_NF := TcDatasetUnf.getEntidade('FIS_NF');
  tFIS_S_NF := TcDatasetUnf.getEntidade('FIS_S_NF');
  tGER_EMPRESA := TcDatasetUnf.getEntidade('GER_EMPRESA');
  tGER_NREMPSEQ := TcDatasetUnf.getEntidade('GER_NREMPSEQ');
  tGER_NUMSEQ := TcDatasetUnf.getEntidade('GER_NUMSEQ');
end;

//---------------------------------------------------------
function T_GERSVCO001.getNumSeq(pParams : String) : String;
//---------------------------------------------------------
const
  cDS_METHOD = 'ADICONAL=Operação: T_GERSVCO001.getNumSeq()';
begin
  voParams := ResetErro(viParams); (* *)

  clear_e(tGER_NUMSEQ);
  putitem_e(tGER_NUMSEQ, 'NM_ENTIDADE', piNmEntidade);
  putitem_e(tGER_NUMSEQ, 'NM_ATRIBUTO', piNmAtributo);
  retrieve_e(tGER_NUMSEQ);
  if (xStatus = 0) then begin
    if (item_f('NR_ATUAL', tGER_NUMSEQ) = item_f('NR_FINAL', tGER_NUMSEQ)) then begin
      if (item_b('IN_REINICIAR', tGER_NUMSEQ)) then begin
        putitem_e(tGER_NUMSEQ, 'NR_ATUAL', 1);
      end else begin
        Result := SetStatus(STS_ERROR, 'GER0001', '', '');
        return(-1); exit;
      end;
    end else begin
      putitem_e(tGER_NUMSEQ, 'NR_ATUAL', item_f('NR_ATUAL', tGER_NUMSEQ) + 1);
    end;
  end else if (xStatus = -2) then begin
    creocc(tGER_NUMSEQ, -1);
    putitem_e(tGER_NUMSEQ, 'NM_ENTIDADE', piNmEntidade);
    putitem_e(tGER_NUMSEQ, 'NM_ATRIBUTO', piNmAtributo);
    putitem_e(tGER_NUMSEQ, 'NR_INCREMENTO', 1);
    putitem_e(tGER_NUMSEQ, 'NR_ATUAL', 1);
    putitem_e(tGER_NUMSEQ, 'NR_INICIAL', 1);
    putitem_e(tGER_NUMSEQ, 'NR_FINAL', piNrFinal);
  end else begin
    Result := SetStatus(STS_ERROR, xProcerror, xProcerrorcontext, cDS_METHOD);
    return(-1); exit;
  end;

  putitem_e(tGER_NUMSEQ, 'CD_OPERADOR', itemXmlF('CD_USUARIO', piGlobal));
  putitem_e(tGER_NUMSEQ, 'DT_CADASTRO', Now);

  voParams := tGER_NUMSEQ.Salvar();
  if (xStatus < 0) then begin
    Result := voParams;
    return(-1); exit;
  end;
  return(0); exit;

end;

//------------------------------------------------------------
function T_GERSVCO001.getNumSeqAnt(pParams : String) : String;
//------------------------------------------------------------
const
  cDS_METHOD = 'ADICONAL=Operação: T_GERSVCO001.getNumSeqAnt()';
begin
  voParams := ResetErro(viParams); (* *)

  clear_e(tGER_NUMSEQ);
  putitem_e(tGER_NUMSEQ, 'NM_ENTIDADE', piNmEntidade);
  putitem_e(tGER_NUMSEQ, 'NM_ATRIBUTO', piNmAtributo);
  retrieve_e(tGER_NUMSEQ);
  if (xStatus = 0) then begin
    putitem_e(tGER_NUMSEQ, 'NR_ATUAL', item_f('NR_ATUAL', tGER_NUMSEQ));
  end else if (xStatus = -2) then begin
    creocc(tGER_NUMSEQ, -1);
    putitem_e(tGER_NUMSEQ, 'NM_ENTIDADE', piNmEntidade);
    putitem_e(tGER_NUMSEQ, 'NM_ATRIBUTO', piNmAtributo);
    putitem_e(tGER_NUMSEQ, 'NR_INCREMENTO', 1);
    putitem_e(tGER_NUMSEQ, 'NR_ATUAL', 1);
    putitem_e(tGER_NUMSEQ, 'NR_INICIAL', 1);
    putitem_e(tGER_NUMSEQ, 'NR_FINAL', piNrFinal);
    putitem_e(tGER_NUMSEQ, 'CD_OPERADOR', itemXmlF('CD_USUARIO', piGlobal));
    putitem_e(tGER_NUMSEQ, 'DT_CADASTRO', Now);
    voParams := tGER_NUMSEQ.Salvar();
    if (xStatus < 0) then begin
      Result := voParams;
      return(-1); exit;
    end;
  end else begin
    Result := SetStatus(STS_ERROR, xProcerror, xProcerrorcontext, cDS_METHOD);
    return(-1); exit;
  end;
  poNrSeq := item_f('NR_ATUAL', tGER_NUMSEQ);
  return(0); exit;

end;

//------------------------------------------------------------
function T_GERSVCO001.getNumSeqEmp(pParams : String) : String;
//------------------------------------------------------------
const
  cDS_METHOD = 'ADICONAL=Operação: T_GERSVCO001.getNumSeqEmp()';
var
  (* string piGlobal :IN / numeric piCdEmpresa :IN / string piNmEntidade :IN / string piNmAtributo :IN / numeric piNrFinal :IN / numeric poNrSeq :OUT / string xCdErro :OUT / string xCtxErro :OUT *)
  vVlParam : String;
begin
  voParams := ResetErro(viParams); (* *)

  clear_e(tGER_NREMPSEQ);
  putitem_e(tGER_NREMPSEQ, 'CD_EMPRESA', piCdEmpresa);
  putitem_e(tGER_NREMPSEQ, 'NM_ENTIDADE', piNmEntidade);
  putitem_e(tGER_NREMPSEQ, 'NM_ATRIBUTO', piNmAtributo);
  retrieve_e(tGER_NREMPSEQ);
  if (xStatus = 0) then begin
    if (item_f('NR_ATUAL', tGER_NREMPSEQ) = item_f('NR_FINAL', tGER_NREMPSEQ)) then begin
      Result := SetStatus(STS_ERROR, 'GER0001', '', '');
      return(-1); exit;
    end else begin
      putitem_e(tGER_NREMPSEQ, 'NR_ATUAL', item_f('NR_ATUAL', tGER_NREMPSEQ) + 1);
    end;
  end else if (xStatus = -2) then begin
    putitem_e(tGER_NREMPSEQ, 'CD_EMPRESA', piCdEmpresa);
    putitem_e(tGER_NREMPSEQ, 'NM_ENTIDADE', piNmEntidade);
    putitem_e(tGER_NREMPSEQ, 'NM_ATRIBUTO', piNmAtributo);
    putitem_e(tGER_NREMPSEQ, 'NR_INCREMENTO', 1);
    putitem_e(tGER_NREMPSEQ, 'NR_ATUAL', 1);
    putitem_e(tGER_NREMPSEQ, 'NR_INICIAL', 1);
    putitem_e(tGER_NREMPSEQ, 'NR_FINAL', piNrFinal);
  end else begin

    Result := SetStatus(STS_ERROR, xProcerror, xProcerrorcontext, cDS_METHOD);
    return(-1); exit;
  end;

  putitem_e(tGER_NREMPSEQ, 'CD_OPERADOR', itemXmlF('CD_USUARIO', piGlobal));
  putitem_e(tGER_NREMPSEQ, 'DT_CADASTRO', Now);

  voParams := tGER_NREMPSEQ.Salvar();
  if (xStatus < 0) then begin
    Result := voParams;
    return(-1); exit;
  end;
    return(-1); exit;
  end else if (xStatus < 0) then begin
    return(-1); exit;
  end else begin
    voParams := ResetErro(viParams); (* *)
  end;

  poNrSeq := item_f('NR_ATUAL', tGER_NREMPSEQ);
  return(0); exit;

end;

//--------------------------------------------------------
function T_GERSVCO001.GetNumNF(pParams : String) : String;
//--------------------------------------------------------
const
  cDS_METHOD = 'ADICONAL=Operação: T_GERSVCO001.GetNumNF()';
begin
  clear_e(tGER_NREMPSEQ);
  putitem_e(tGER_NREMPSEQ, 'CD_EMPRESA', piCdEmpresa);
  putitem_e(tGER_NREMPSEQ, 'NM_ENTIDADE', 'FIS_NF');
  putitem_e(tGER_NREMPSEQ, 'NM_ATRIBUTO', piCdSerie);
  retrieve_e(tGER_NREMPSEQ);
  if (xStatus = 0) then begin
    poNrNF := item_f('NR_ATUAL', tGER_NREMPSEQ);
  end;

  return(0); exit;
end;

//-----------------------------------------------------------
function T_GERSVCO001.GetNumSeqNF(pParams : String) : String;
//-----------------------------------------------------------
const
  cDS_METHOD = 'ADICONAL=Operação: T_GERSVCO001.GetNumSeqNF()';
var
  (* string piGlobal :IN / numeric piCdEmpresa :IN / string piCdSerie :IN / numeric piNrFinal :IN / numeric poNrNF :OUT / string xCdErro :OUT / string xCtxErro :OUT *)
  vNrNF, vCdGrupoEmpresa, vNrMaxNF : Real;
  vVlParam : String;
  vDtSistema : TDate;
begin
  voParams := ResetErro(viParams); (* *)

  if (piCdEmpresa = '') then begin
    Result := SetStatus(STS_ERROR, 'PAR0001', '', cDS_METHOD);
    return(-1); exit;
  end;
  if (piCdSerie = '') then begin
    Result := SetStatus(STS_ERROR, 'PAR0001', '', cDS_METHOD);
    return(-1); exit;
  end;

  clear_e(tGER_EMPRESA);
  putitem_e(tGER_EMPRESA, 'CD_EMPRESA', piCdEmpresa);
  retrieve_o(tGER_EMPRESA);
  if (xStatus = -7) then begin
    retrieve_x(tGER_EMPRESA);
    vCdGrupoEmpresa := itemXmlF('CD_GRUPOEMPRESA', piGlobal);
  end else begin
    Result := SetStatus(STS_ERROR, 'PAR0002', '', '');
    return(-1); exit;
  end;

  vDtSistema := itemXml('DT_SISTEMA', piGlobal);

  poNrNF := 0;
  while (poNrNF := 0) do begin
    vNrNF := 0;
    clear_e(tGER_NREMPSEQ);
    putitem_e(tGER_NREMPSEQ, 'CD_EMPRESA', piCdEmpresa);
    putitem_e(tGER_NREMPSEQ, 'NM_ENTIDADE', 'FIS_NF');
    putitem_e(tGER_NREMPSEQ, 'NM_ATRIBUTO', piCdSerie);
    retrieve_e(tGER_NREMPSEQ);
    if (xStatus >= 0) then begin
      vNrNF := item_f('NR_ATUAL', tGER_NREMPSEQ);
      if (item_f('NR_ATUAL', tGER_NREMPSEQ) = item_f('NR_FINAL', tGER_NREMPSEQ)) then begin
        Result := SetStatus(STS_ERROR, 'GER0001', '', '');
        return(-1); exit;
      end else begin
        putitem_e(tGER_NREMPSEQ, 'NR_ATUAL', item_f('NR_ATUAL', tGER_NREMPSEQ) + 1);
      end;
    end else if (xStatus = -2) then begin
      creocc(tGER_NREMPSEQ, -1);
      putitem_e(tGER_NREMPSEQ, 'CD_EMPRESA', piCdEmpresa);
      putitem_e(tGER_NREMPSEQ, 'NM_ENTIDADE', 'FIS_NF');
      putitem_e(tGER_NREMPSEQ, 'NM_ATRIBUTO', piCdSerie);
      putitem_e(tGER_NREMPSEQ, 'NR_INCREMENTO', 1);
      putitem_e(tGER_NREMPSEQ, 'NR_ATUAL', 1);
      putitem_e(tGER_NREMPSEQ, 'NR_INICIAL', 1);
      putitem_e(tGER_NREMPSEQ, 'NR_FINAL', piNrFinal);
    end else begin
      Result := SetStatus(STS_ERROR, xProcerror, xProcerrorcontext, cDS_METHOD);
      return(-1); exit;
    end;

    putitem_e(tGER_NREMPSEQ, 'CD_OPERADOR', itemXmlF('CD_USUARIO', piGlobal));
    putitem_e(tGER_NREMPSEQ, 'DT_CADASTRO', Now);

    voParams := tGER_NREMPSEQ.Salvar();
    if (xStatus < 0) then begin
      Result := voParams;
      return(-1); exit;
    end;
    if (vNrNF = 0) then begin
      vNrNF := 1;
    end;

    clear_e(tFIS_NF);
    putitem_e(tFIS_NF, 'CD_EMPFAT', piCdEmpresa);
    putitem_e(tFIS_NF, 'NR_NF', vNrNF);
    putitem_e(tFIS_NF, 'CD_SERIE', piCdSerie);
    item_f('TP_ORIGEMEMISSAO', tFIS_NF)= 1;
    retrieve_e(tFIS_NF);
    if (xStatus = <UIOSERR_OCC_NOT_FOUND>) then begin
      clear_e(tFIS_NF);
      putitem_e(tFIS_NF, 'CD_EMPFAT', piCdEmpresa);
      putitem_e(tFIS_NF, 'NR_NF', '>' + FloatToStr(vNrNF') + ');
      putitem_e(tFIS_NF, 'CD_SERIE', piCdSerie);
      item_f('TP_ORIGEMEMISSAO', tFIS_NF)= 1;
      retrieve_e(tFIS_NF);
      if (xStatus >= 0) then begin
        setocc(tFIS_NF, 1);
        while (xStatus >= 0) do begin
          if (item_f('TP_SITUACAO', tFIS_NF) = 'E') then begin
            if (item_a('DT_SAIDAENTRADA', tFIS_NF) <> vDtSistema) then begin
              Result := SetStatus(STS_ERROR, 'GEN0001', 'Numeração de NF ' + FloatToStr(vNrNF) + ' já encontrada em outros períodos na série ' + piCdSerie!', + ' cDS_METHOD);
              return(-1); exit;
            end;
          end;
          setocc(tFIS_NF, curocc(tFIS_NF) + 1);
        end;
      end;

      poNrNF := vNrNF;
    end;
  end;

  return(0); exit;
end;

//----------------------------------------------------------
function T_GERSVCO001.AlteraNrNF(pParams : String) : String;
//----------------------------------------------------------
const
  cDS_METHOD = 'ADICONAL=Operação: T_GERSVCO001.AlteraNrNF()';
var
  (* string piGlobal :IN / numeric piCdEmpresa :IN / string piCdSerie :IN / numeric piNrFinal :IN / numeric piNrNF :IN / string xCdErro :OUT / string xCtxErro :OUT *)
  vVlParam : String;
begin
  voParams := ResetErro(viParams); (* *)

  clear_e(tGER_NREMPSEQ);
  putitem_e(tGER_NREMPSEQ, 'CD_EMPRESA', piCdEmpresa);
  putitem_e(tGER_NREMPSEQ, 'NM_ENTIDADE', 'FIS_NF');
  putitem_e(tGER_NREMPSEQ, 'NM_ATRIBUTO', piCdSerie);
  retrieve_e(tGER_NREMPSEQ);
  if (xStatus = 0) then begin
    putitem_e(tGER_NREMPSEQ, 'NR_ATUAL', piNrNF);
  end else if (xStatus = -2) then begin
    creocc(tGER_NREMPSEQ, -1);
    putitem_e(tGER_NREMPSEQ, 'CD_EMPRESA', piCdEmpresa);
    putitem_e(tGER_NREMPSEQ, 'NM_ENTIDADE', 'FIS_NF');
    putitem_e(tGER_NREMPSEQ, 'NM_ATRIBUTO', piCdSerie);
    putitem_e(tGER_NREMPSEQ, 'NR_INCREMENTO', 1);
    putitem_e(tGER_NREMPSEQ, 'NR_ATUAL', piNrNF);
    putitem_e(tGER_NREMPSEQ, 'NR_INICIAL', 1);
    putitem_e(tGER_NREMPSEQ, 'NR_FINAL', piNrFinal);
  end else begin

    Result := SetStatus(STS_ERROR, xProcerror, xProcerrorcontext, '');
    return(-1); exit;
  end;

  voParams := tGER_NREMPSEQ.Salvar();
  if (xStatus < 0) then begin
    Result := voParams;
    return(-1); exit;
  end;
    Result := SetStatus(STS_ERROR, xProcerror, xProcerrorcontext, '');
    return(-1); exit;
  end else if (xStatus < 0) then begin
    Result := SetStatus('', xCdErro, xCtxErro, '');
  end else begin
    voParams := ResetErro(viParams); (* *)
  end;

  return(0); exit;
end;

//-----------------------------------------------------------
function T_GERSVCO001.setNumSeqNF(pParams : String) : String;
//-----------------------------------------------------------
const
  cDS_METHOD = 'ADICONAL=Operação: T_GERSVCO001.setNumSeqNF()';
var
  (* string piGlobal :IN / numeric piCdEmpresa :IN / string piCdSerie :IN / numeric piNrFinal :IN / numeric piNrNF :IN / string xCdErro :OUT / string xCtxErro :OUT *)
  vVlParam : String;
begin
  voParams := ResetErro(viParams); (* *)

  clear_e(tGER_NREMPSEQ);
  putitem_e(tGER_NREMPSEQ, 'CD_EMPRESA', piCdEmpresa);
  putitem_e(tGER_NREMPSEQ, 'NM_ENTIDADE', 'FIS_NF');
  putitem_e(tGER_NREMPSEQ, 'NM_ATRIBUTO', piCdSerie);
  retrieve_e(tGER_NREMPSEQ);
  if (xStatus = 0) then begin
    if (item_f('NR_ATUAL', tGER_NREMPSEQ) > piNrNF) then begin
      putitem_e(tGER_NREMPSEQ, 'NR_ATUAL', piNrNF);
    end;
  end else if (xStatus = -2) then begin
    creocc(tGER_NREMPSEQ, -1);
    putitem_e(tGER_NREMPSEQ, 'CD_EMPRESA', piCdEmpresa);
    putitem_e(tGER_NREMPSEQ, 'NM_ENTIDADE', 'FIS_NF');
    putitem_e(tGER_NREMPSEQ, 'NM_ATRIBUTO', piCdSerie);
    putitem_e(tGER_NREMPSEQ, 'NR_INCREMENTO', 1);
    putitem_e(tGER_NREMPSEQ, 'NR_ATUAL', piNrNF);
    putitem_e(tGER_NREMPSEQ, 'NR_INICIAL', 1);
    putitem_e(tGER_NREMPSEQ, 'NR_FINAL', piNrFinal);
  end else begin

    Result := SetStatus(STS_ERROR, xProcerror, xProcerrorcontext, cDS_METHOD);
    return(-1); exit;
  end;

  putitem_e(tGER_NREMPSEQ, 'CD_OPERADOR', itemXmlF('CD_USUARIO', piGlobal));
  putitem_e(tGER_NREMPSEQ, 'DT_CADASTRO', Now);

  voParams := tGER_NREMPSEQ.Salvar();
  if (xStatus < 0) then begin
    Result := voParams;
    return(-1); exit;
  end;
    Result := SetStatus(STS_ERROR, xProcerror, xProcerrorcontext, '');
    return(-1); exit;
  end else if (xStatus < 0) then begin
    Result := SetStatus('', xCdErro, xCtxErro, '');
  end else begin
    voParams := ResetErro(viParams); (* *)
  end;

  return(0); exit;
end;

//-------------------------------------------------------------
function T_GERSVCO001.getNumSeqComm(pParams : String) : String;
//-------------------------------------------------------------
const
  cDS_METHOD = 'ADICONAL=Operação: T_GERSVCO001.getNumSeqComm()';
begin
  voParams := ResetErro(viParams); (* *)

  clear_e(tGER_NUMSEQ);
  putitem_e(tGER_NUMSEQ, 'NM_ENTIDADE', piNmEntidade);
  putitem_e(tGER_NUMSEQ, 'NM_ATRIBUTO', piNmAtributo);
  retrieve_e(tGER_NUMSEQ);
  if (xStatus = 0) then begin
    if (item_f('NR_ATUAL', tGER_NUMSEQ) = item_f('NR_FINAL', tGER_NUMSEQ)) then begin
      if (item_b('IN_REINICIAR', tGER_NUMSEQ)) then begin
        putitem_e(tGER_NUMSEQ, 'NR_ATUAL', 0);
      end else begin

        Result := SetStatus(STS_ERROR, 'GER0001', '', '');
        return(-1); exit;
      end;
    end else begin
      putitem_e(tGER_NUMSEQ, 'NR_ATUAL', item_f('NR_ATUAL', tGER_NUMSEQ) + 1);
    end;
  end else if (xStatus = -2) then begin
    creocc(tGER_NUMSEQ, -1);
    putitem_e(tGER_NUMSEQ, 'NM_ENTIDADE', piNmEntidade);
    putitem_e(tGER_NUMSEQ, 'NM_ATRIBUTO', piNmAtributo);
    putitem_e(tGER_NUMSEQ, 'NR_INCREMENTO', 1);
    putitem_e(tGER_NUMSEQ, 'NR_ATUAL', 1);
    putitem_e(tGER_NUMSEQ, 'NR_INICIAL', 1);
    putitem_e(tGER_NUMSEQ, 'NR_FINAL', piNrFinal);
  end else begin

    Result := SetStatus(STS_ERROR, xProcerror, xProcerrorcontext, cDS_METHOD);
    return(-1); exit;
  end;

  putitem_e(tGER_NUMSEQ, 'CD_OPERADOR', itemXmlF('CD_USUARIO', piGlobal));
  putitem_e(tGER_NUMSEQ, 'DT_CADASTRO', Now);

  voParams := tGER_NUMSEQ.Salvar();
  if (xStatus < 0) then begin
    Result := voParams;
    return(-1); exit;
  end;
    Result := SetStatus(STS_ERROR, xProcerror, xProcerrorcontext, '');
    return(-1); exit;
  end else if (xStatus < 0) then begin
    return(-1); exit;
  end else begin
    voParams := ResetErro(viParams); (* *)
    commit;
  end;

  poNrSeq := item_f('NR_ATUAL', tGER_NUMSEQ);

  return(0); exit;

end;

//-------------------------------------------------------
function T_GERSVCO001.CLEANUP(pParams : String) : String;
//-------------------------------------------------------
const
  cDS_METHOD = 'ADICONAL=Operação: T_GERSVCO001.CLEANUP()';
begin
  rollback;
end;

//---------------------------------------------------------
function T_GERSVCO001.buscaNrNF(pParams : String) : String;
//---------------------------------------------------------
const
  cDS_METHOD = 'ADICONAL=Operação: T_GERSVCO001.buscaNrNF()';
var
  vNrNF, vNrNFDef, vCdEmpresa, vNrFatura, vNrMaxNF, vCdEmpFat : Real;
  voParams := ocal : String;
  vDtFatura, vDtSistema : TDate;
begin
  vCdEmpresa := itemXmlF('CD_EMPRESA', pParams);
  vNrFatura := itemXmlF('NR_FATURA', pParams);
  vDtFatura := itemXml('DT_FATURA', pParams);
  vCdEmpFat := itemXmlF('CD_EMPFAT', pParams);
  vCdSerie := itemXmlF('CD_SERIE', pParams);
  voParams := ocal := itemXml(viParams); (* 'TP_MODDCTOFIScallOCAL', pParams *)
  if (vCdEmpresa = 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Empresa não infomado!', cDS_METHOD);
    return(-1); exit;
  end;
  if (vNrFatura = 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Nr. fatura não infomada!', cDS_METHOD);
    return(-1); exit;
  end;
  if (vDtFatura = '') then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Dt. fatura não infomada!', cDS_METHOD);
    return(-1); exit;
  end;
  if (vCdEmpFat = 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Empresa de faturamento não infomada!', cDS_METHOD);
    return(-1); exit;
  end;
  if (vCdSerie = '') then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Série não infomada!', cDS_METHOD);
    return(-1); exit;
  end;

  clear_e(tGER_EMPRESA);
  putitem_e(tGER_EMPRESA, 'CD_EMPRESA', vCdEmpresa);
  retrieve_e(tGER_EMPRESA);
  if (xStatus < 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Empresa ' + FloatToStr(vCdEmpresa) + ' não cadastrada!', cDS_METHOD);
    return(-1); exit;
  end;

  getParams(pParams); (* vCdEmpresa, 'buscaNrNF' *)
  if (xStatus < 0) then begin
    return(-1); exit;
  end;
  if (vCdSerie = 'ECF') then begin
  end else begin
    clear_e(tFIS_NF);
    putitem_e(tFIS_NF, 'CD_EMPRESA', vCdEmpresa);
    putitem_e(tFIS_NF, 'NR_FATURA', vNrFatura);
    putitem_e(tFIS_NF, 'DT_FATURA', vDtFatura);
    retrieve_e(tFIS_NF);
    if (xStatus < 0) then begin
      Result := SetStatus(STS_ERROR, 'GEN0001', 'NF ' + FloatToStr(vCdEmpresa) + ' / ' + FloatToStr(vNrFatura) + ' não cadastrada!', cDS_METHOD);
      return(-1); exit;
    end;
    if (item_f('TP_SITUACAO', tFIS_NF) <> 'N') then begin
      Result := SetStatus(STS_ERROR, 'GEN0001', 'NF ' + FloatToStr(vCdEmpresa) + ' / ' + FloatToStr(vNrFatura) + ' não está com a situação Normal!', cDS_METHOD);
      return(-1); exit;
    end;
    if (item_f('NR_NF', tFIS_NF) > 0) then begin
      Result := '';
      putitemXml(Result, 'NR_NF', item_f('NR_NF', tFIS_NF));
      clear_e(tFIS_NF);
      return(0); exit;
    end;
  end;

  vDtSistema := itemXml('DT_SISTEMA', PARAM_GLB);

  vNrNFDef := 0;
  while (vNrNFDef := 0) do begin
    vNrNF := 0;
    clear_e(tGER_NREMPSEQ);
    putitem_e(tGER_NREMPSEQ, 'CD_EMPRESA', vCdEmpFat);
    putitem_e(tGER_NREMPSEQ, 'NM_ENTIDADE', 'FIS_NF');
    putitem_e(tGER_NREMPSEQ, 'NM_ATRIBUTO', vCdSerie);
    retrieve_e(tGER_NREMPSEQ);
    if (xStatus >= 0) then begin
      vNrNF := item_f('NR_ATUAL', tGER_NREMPSEQ);
      if (item_f('NR_ATUAL', tGER_NREMPSEQ) = item_f('NR_FINAL', tGER_NREMPSEQ)) then begin
        Result := SetStatus(STS_ERROR, 'GER0001', '', cDS_METHOD);
        return(-1); exit;
      end else begin
        putitem_e(tGER_NREMPSEQ, 'NR_ATUAL', item_f('NR_ATUAL', tGER_NREMPSEQ) + 1);
      end;
    end else if (xStatus = -2) then begin
      creocc(tGER_NREMPSEQ, -1);
      putitem_e(tGER_NREMPSEQ, 'CD_EMPRESA', vCdEmpFat);
      putitem_e(tGER_NREMPSEQ, 'NM_ENTIDADE', 'FIS_NF');
      putitem_e(tGER_NREMPSEQ, 'NM_ATRIBUTO', vCdSerie);
      putitem_e(tGER_NREMPSEQ, 'NR_INCREMENTO', 1);
      putitem_e(tGER_NREMPSEQ, 'NR_ATUAL', 1);
      putitem_e(tGER_NREMPSEQ, 'NR_INICIAL', 1);
      putitem_e(tGER_NREMPSEQ, 'NR_FINAL', 999999999);
          putitem_e(tGER_NREMPSEQ, 'CD_OPERADOR', itemXmlF('CD_USUARIO', PARAM_GLB));
        putitem_e(tGER_NREMPSEQ, 'DT_CADASTRO', Now);
    end else begin
      Result := SetStatus(STS_ERROR, xProcerror, xProcerrorcontext, cDS_METHOD);
      return(-1); exit;
    end;

    voParams := tGER_NREMPSEQ.Salvar();
    if (xStatus < 0) then begin
      Result := voParams;
      return(-1); exit;
    end;
    if (vNrNF = 0) then begin
      vNrNF := 1;
    end;

    clear_e(tFIS_S_NF);
    putitem_e(tFIS_S_NF, 'CD_EMPFAT', vCdEmpFat);
    putitem_e(tFIS_S_NF, 'NR_NF', vNrNF);
    putitem_e(tFIS_S_NF, 'CD_SERIE', vCdSerie);
    putitem_e(tFIS_S_NF, 'TP_SITUACAO', '!=X');
    item_f('TP_ORIGEMEMISSAO', tFIS_S_NF)= 1;
    voParams := ocal;
    retrieve_e(tFIS_S_NF);
    if (xStatus = <UIOSERR_OCC_NOT_FOUND>) then begin
      clear_e(tFIS_S_NF);
      putitem_e(tFIS_S_NF, 'CD_EMPFAT', vCdEmpFat);
      putitem_e(tFIS_S_NF, 'NR_NF', '>' + FloatToStr(vNrNF') + ');
      putitem_e(tFIS_S_NF, 'CD_SERIE', vCdSerie);
      item_f('TP_ORIGEMEMISSAO', tFIS_S_NF)= 1;
      voParams := ocal;
      retrieve_e(tFIS_S_NF);
      if (xStatus >= 0) then begin
        setocc(tFIS_S_NF, 1);
        while (xStatus >= 0) do begin
          if (item_f('TP_SITUACAO', tFIS_S_NF) = 'E') then begin
            if (item_a('DT_SAIDAENTRADA', tFIS_S_NF) <> vDtSistema) then begin
              Result := SetStatus(STS_ERROR, 'GEN0001', 'Numeração de NF ' + FloatToStr(vNrNF) + ' já encontrada em outros períodos na série ' + FloatToStr(vCdSerie) + ' e modelo ' + FloatToStr(vTpModDctoFiscallocal!',) + ' cDS_METHOD);
              return(-1); exit;
            end;
          end;
          setocc(tFIS_S_NF, curocc(tFIS_S_NF) + 1);
        end;
      end;
      if (vCdSerie = 'ECF') then begin
      end else begin

        select max(NR_NF) 
        from 'FIS_S_NFSVC' 
        where (putitem_e(tFIS_S_NF, 'CD_EMPFAT', vCdEmpFat ) and (
        putitem_e(tFIS_S_NF, 'CD_SERIE', vCdSerie ) and (
        putitem_e(tFIS_S_NF, 'TP_ORIGEMEMISSAO', 1 ) and (
        item_f('TP_SITUACAO', tFIS_S_NF) <> 'X' ) and (
        voParams := ocal)
        to vNrMaxNF;
        if (xStatus < 0) then begin
          Result := SetStatus(STS_ERROR, xProcerror, xProcerrorcontext, '');
          return(-1); exit;
        end;
        if (vNrMaxNF > 0) then begin
          if ((vNrNF - vNrMaxNF) > gNrMaxIntervaloNF) then begin
            Result := SetStatus(STS_ERROR, 'GEN0001', 'Numeração de NF ' + FloatToStr(vNrNF) + ' superior a ' + FloatToStr(gNrMaxIntervaloNF) + ' número(s) sobre a última numeração ' + FloatToStr(vNrMaxNF) + ' na série ' + FloatToStr(vCdSerie) + ' e modelo ' + FloatToStr(vTpModDctoFiscallocal!',) + ' cDS_METHOD);
            return(-1); exit;
          end else if ((vNrMaxNF - vNrNF) > gNrMaxIntervaloNF) then begin
            Result := SetStatus(STS_ERROR, 'GEN0001', 'Numeração de NF ' + FloatToStr(vNrNF) + ' inferior a ' + FloatToStr(gNrMaxIntervaloNF) + ' número(s) sobre a última numeração ' + FloatToStr(vNrMaxNF) + ' na série ' + FloatToStr(vCdSerie) + ' e modelo ' + FloatToStr(vTpModDctoFiscallocal!',) + ' cDS_METHOD);
            return(-1); exit;
          end;
        end;
      end;

      vNrNFDef := vNrNF;
    end;
  end;
  if (vCdSerie = 'ECF') then begin
  end else begin

    putitem_e(tFIS_NF, 'NR_NF', vNrNFDef);
    putitem_e(tFIS_NF, 'CD_SERIE', vCdSerie);
    voParams := tFIS_NF.Salvar();
    if (xStatus < 0) then begin
      Result := voParams;
      return(-1); exit;
    end;
    if (gInUtilizaNsu = True) then begin
      viParams := '';
      putitemXml(viParams, 'CD_EMPRESA', vCdEmpresa);
      putitemXml(viParams, 'NR_FATURA', vNrFatura);
      putitemXml(viParams, 'DT_FATURA', vDtFatura);
      voParams := activateCmp('FISSVCO019', 'gravaFisNsu', viParams);

      commit;

      if (xStatus < 0) then begin
        Result := voParams;
        rollback;
        return(-1); exit;
      end;
    end;
    if (gInUtilizaSeloFiscal = True) then begin
      viParams := '';
      putitemXml(viParams, 'CD_EMPRESA', vCdEmpresa);
      putitemXml(viParams, 'NR_FATURA', vNrFatura);
      putitemXml(viParams, 'DT_FATURA', vDtFatura);
      voParams := activateCmp('FISSVCO019', 'gravaSelo', viParams);

      commit;

      if (xStatus < 0) then begin
        Result := voParams;
        rollback;
        return(-1); exit;
      end;
    end;
  end;

  Result := '';
  putitemXml(Result, 'NR_NF', vNrNFDef);

  return(0); exit;
end;

end.
