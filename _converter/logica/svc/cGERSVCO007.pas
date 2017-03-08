unit cGERSVCO007;

interface

(* COMPONENTES 
  ADMSVCO006 / SICSVCO004 / 
*)        

uses
  Classes, SysUtils, Math, DB,
  cServiceUnf, cDataSetUnf;

type
  T_GERSVCO007 = class(TcServiceUnf)
  private
    tADM_USUOPERCMP,
    tCMP_TIPOCLAS,
    tCTC_CARTAO,
    tCTC_TPCARPAR,
    tFCX_HISTRELSU,
    tFGR_PORTADOR,
    tGER_EMPRESA,
    tGER_GRUPOEMPR,
    tGER_MODETIQC,
    tGER_MODETIQMC,
    tGER_MODNFC,
    tGER_MODTRAC,
    tGER_NREMPSEQ,
    tGER_OPERACAO,
    tGER_OPERSALDO,
    tGER_OPERVALOR,
    tGER_POOLGRUPO,
    tGER_SERIE,
    tGLB_ESTADO,
    tGLB_MUNICIPIO,
    tGLB_PAIS,
    tGLB_TPLOGRADO,
    tPED_TIPOCLAS,
    tPES_TIPOCLAS,
    tPRD_CFGNIVELC,
    tPRD_CFGNIVELI,
    tPRD_GRUCOR,
    tPRD_LOCACAO,
    tPRD_TIPOCLAS,
    tPRD_TIPOSALDO,
    tPRD_TIPOVALOR,
    tPRD_USUCDVALO,
    tPRD_USUTIPOSA,
    tPRD_USUTIPOVA,
    tPRD_VALOR,
    tPRF_TIPOPRDFI,
    tTEF_ARQUIVO,
    tTEF_REDETEF,
    tTRA_TIPOCLAS,
    tV_GER_OPERCMP : TcDatasetUnf;
    function getParam(pParams : String = '') : String;
    function setEntidade(pParams : String = '') : String;
  protected
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;    
  published
    function GetOperComponente(pParams : String = '') : String;
    function GetOperFat(pParams : String = '') : String;
    function GetOperacoes(pParams : String = '') : String;
    function ListOperacoes(pParams : String = '') : String;
    function SetEmpresa(pParams : String = '') : String;
    function SetPessoaEmpresa(pParams : String = '') : String;
    function SetTransferencia(pParams : String = '') : String;
    function VldInValor(pParams : String = '') : String;
    function VldInSaldo(pParams : String = '') : String;
    function VldInKardex(pParams : String = '') : String;
    function VldInLocacao(pParams : String = '') : String;
    function VldInMarkup(pParams : String = '') : String;
    function ListModeloNF(pParams : String = '') : String;
    function ListTefArquivo(pParams : String = '') : String;
    function ListRedeTef(pParams : String = '') : String;
    function ListModeloTRA(pParams : String = '') : String;
    function ListTipoSaldo(pParams : String = '') : String;
    function ListTipoValor(pParams : String = '') : String;
    function ListTipoClas(pParams : String = '') : String;
    function ListTipoClasPat(pParams : String = '') : String;
    function ListCfgNivel(pParams : String = '') : String;
    function ListCfgNivelPat(pParams : String = '') : String;
    function ListModeloETIQ(pParams : String = '') : String;
    function ListPais(pParams : String = '') : String;
    function ListEstado(pParams : String = '') : String;
    function ListMunicipio(pParams : String = '') : String;
    function ListTpLogradouro(pParams : String = '') : String;
    function ListGrupoEmpresa(pParams : String = '') : String;
    function ListEmpresa(pParams : String = '') : String;
    function getCdCCusto(pParams : String = '') : String;
    function ListPortador(pParams : String = '') : String;
    function ListHistRelSub(pParams : String = '') : String;
    function listTipoValorProduto(pParams : String = '') : String;
    function listTipoClasPed(pParams : String = '') : String;
    function listTipoClasCmp(pParams : String = '') : String;
    function listaNrNF(pParams : String = '') : String;
    function ListTipoCor(pParams : String = '') : String;
    function ListTipoClasPes(pParams : String = '') : String;
    function ListTipoClasTra(pParams : String = '') : String;
    function ListaProdutoFinanceiro(pParams : String = '') : String;
  end;

implementation

uses
  cADMSVCO001,
  cActivate, cStatus, cFuncao, cXml, dModulo;

var


//---------------------------------------------------------------
constructor T_GERSVCO007.Create(AOwner: TComponent);
//---------------------------------------------------------------
begin
  inherited Create(AOwner);
  setEntidade('');
end;

//--------------------------------
destructor T_GERSVCO007.Destroy;
//--------------------------------
begin
  inherited Destroy;
end;

//---------------------------------------------------------------
function T_GERSVCO007.getParam(pParams : String = '') : String;
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
function T_GERSVCO007.setEntidade(pParams : String = '') : String;
//---------------------------------------------------------------
begin
  tADM_USUOPERCMP := GetEntidade('ADM_USUOPERCMP');
  tCMP_TIPOCLAS := GetEntidade('CMP_TIPOCLAS');
  tCTC_CARTAO := GetEntidade('CTC_CARTAO');
  tCTC_TPCARPAR := GetEntidade('CTC_TPCARPAR');
  tFCX_HISTRELSU := GetEntidade('FCX_HISTRELSU');
  tFGR_PORTADOR := GetEntidade('FGR_PORTADOR');
  tGER_EMPRESA := GetEntidade('GER_EMPRESA');
  tGER_GRUPOEMPR := GetEntidade('GER_GRUPOEMPR');
  tGER_MODETIQC := GetEntidade('GER_MODETIQC');
  tGER_MODETIQMC := GetEntidade('GER_MODETIQMC');
  tGER_MODNFC := GetEntidade('GER_MODNFC');
  tGER_MODTRAC := GetEntidade('GER_MODTRAC');
  tGER_NREMPSEQ := GetEntidade('GER_NREMPSEQ');
  tGER_OPERACAO := GetEntidade('GER_OPERACAO');
  tGER_OPERSALDO := GetEntidade('GER_OPERSALDO');
  tGER_OPERVALOR := GetEntidade('GER_OPERVALOR');
  tGER_POOLGRUPO := GetEntidade('GER_POOLGRUPO');
  tGER_SERIE := GetEntidade('GER_SERIE');
  tGLB_ESTADO := GetEntidade('GLB_ESTADO');
  tGLB_MUNICIPIO := GetEntidade('GLB_MUNICIPIO');
  tGLB_PAIS := GetEntidade('GLB_PAIS');
  tGLB_TPLOGRADO := GetEntidade('GLB_TPLOGRADO');
  tPED_TIPOCLAS := GetEntidade('PED_TIPOCLAS');
  tPES_TIPOCLAS := GetEntidade('PES_TIPOCLAS');
  tPRD_CFGNIVELC := GetEntidade('PRD_CFGNIVELC');
  tPRD_CFGNIVELI := GetEntidade('PRD_CFGNIVELI');
  tPRD_GRUCOR := GetEntidade('PRD_GRUCOR');
  tPRD_LOCACAO := GetEntidade('PRD_LOCACAO');
  tPRD_TIPOCLAS := GetEntidade('PRD_TIPOCLAS');
  tPRD_TIPOSALDO := GetEntidade('PRD_TIPOSALDO');
  tPRD_TIPOVALOR := GetEntidade('PRD_TIPOVALOR');
  tPRD_USUCDVALO := GetEntidade('PRD_USUCDVALO');
  tPRD_USUTIPOSA := GetEntidade('PRD_USUTIPOSA');
  tPRD_USUTIPOVA := GetEntidade('PRD_USUTIPOVA');
  tPRD_VALOR := GetEntidade('PRD_VALOR');
  tPRF_TIPOPRDFI := GetEntidade('PRF_TIPOPRDFI');
  tTEF_ARQUIVO := GetEntidade('TEF_ARQUIVO');
  tTEF_REDETEF := GetEntidade('TEF_REDETEF');
  tTRA_TIPOCLAS := GetEntidade('TRA_TIPOCLAS');
  tV_GER_OPERCMP := GetEntidade('V_GER_OPERCMP');
end;

//-----------------------------------------------------------------
function T_GERSVCO007.GetOperComponente(pParams : String) : String;
//-----------------------------------------------------------------
const
  cDS_METHOD = 'ADICONAL=Operação: T_GERSVCO007.GetOperComponente()';
var
  vN : Real;
begin
  Result := '';

  clear_e(tV_GER_OPERCMP);
  putitem_e(tV_GER_OPERCMP, 'CD_COMPONENTE', itemXmlF('CD_COMPONENTE', pParams));

  retrieve_e(tV_GER_OPERCMP);
  if (!xProcerror) then begin
    setocc(tV_GER_OPERCMP, 1);
    while (xStatus >=0) do begin
      clear_e(tGER_OPERACAO);
      putitem_e(tGER_OPERACAO, 'CD_OPERACAO', item_f('CD_OPERACAO', tV_GER_OPERCMP));
      retrieve_e(tGER_OPERACAO);
      if (!xProcerror) then begin
        vN := vN + 1;

        putitem(Result, vN, item_f('CD_OPERACAO', tGER_OPERACAO));
      end;
      setocc(tV_GER_OPERCMP, curocc(tV_GER_OPERCMP) + 1);
    end;
  end;
  return(0); exit;

end;

//----------------------------------------------------------
function T_GERSVCO007.GetOperFat(pParams : String) : String;
//----------------------------------------------------------
const
  cDS_METHOD = 'ADICONAL=Operação: T_GERSVCO007.GetOperFat()';
var
  vN : Real;
begin
  Result := '';

  clear_e(tGER_OPERACAO);
  putitem_e(tGER_OPERACAO, 'CD_OPERACAO', itemXmlF('CD_OPERACAO', pParams));

  retrieve_e(tGER_OPERACAO);
  if (!xProcerror) then begin
    Result := item_f('CD_OPERFAT', tGER_OPERACAO);
  end;
  return(0); exit;

end;

//------------------------------------------------------------
function T_GERSVCO007.GetOperacoes(pParams : String) : String;
//------------------------------------------------------------
const
  cDS_METHOD = 'ADICONAL=Operação: T_GERSVCO007.GetOperacoes()';
var
  vN : Real;
begin
  Result := '';

  clear_e(tV_GER_OPERCMP);
  putitem_e(tV_GER_OPERCMP, 'CD_COMPONENTE', itemXmlF('CD_COMPONENTE', pParams));

  retrieve_e(tV_GER_OPERCMP);
  if (!xProcerror) then begin
    setocc(tV_GER_OPERCMP, 1);
    while (xStatus >=0) do begin
      clear_e(tGER_OPERACAO);
      putitem_e(tGER_OPERACAO, 'CD_OPERACAO', item_f('CD_OPERACAO', tV_GER_OPERCMP));
      retrieve_e(tGER_OPERACAO);
      if (!xProcerror) then begin
        vN := vN + 1;
        putitem(Result, vN, item_f('CD_OPERACAO', tGER_OPERACAO));
        setocc(tV_GER_OPERCMP, curocc(tV_GER_OPERCMP) + 1);
      end;
    end;
  end;
  return(0); exit;

end;

//-------------------------------------------------------------
function T_GERSVCO007.ListOperacoes(pParams : String) : String;
//-------------------------------------------------------------
const
  cDS_METHOD = 'ADICONAL=Operação: T_GERSVCO007.ListOperacoes()';
var
  vDsLstOperacao, vCdComponente, vTpOperacao : String;
  vCdUsuario, vCdEmpresa, vTpOrdem : Real;
begin
  Result := '';

  vCdComponente := itemXmlF('CD_COMPONENTE', pParams);
  if (vCdComponente = '') then begin
    voParams := SetErroApl(viParams); (* 'ERRO=-1;
    return(-1); exit;
  end;

  vTpOperacao := itemXmlF('TP_OPERACAO', pParams);

  clear_e(tGER_OPERACAO);

  vDsLstOperacao := itemXml('DS_LSTOPERACAO', pParams);

  if (vDsLstOperacao <> '') then begin
    putitem_e(tGER_OPERACAO, 'CD_OPERACAO', vDsLstOperacao);
    retrieve_e(tGER_OPERACAO);
    if (xStatus < 0) then begin
      clear_e(tGER_OPERACAO);
    end;
  end;

  vCdEmpresa := itemXmlF('CD_EMPRESA', pParams);
  vCdUsuario := itemXmlF('CD_USUARIO', pParams);
  clear_e(tADM_USUOPERCMP);
  if (vCdusuario > 0) then begin
    if (vCdEmpresa = 0) then begin
      voParams := SetErroApl(viParams); (* 'ERRO=-1;
      return(-1); exit;
    end;
    putitem_e(tADM_USUOPERCMP, 'CD_EMPRESA', vCdEmpresa);
    putitem_e(tADM_USUOPERCMP, 'CD_USUARIO', vCdUsuario);
    putitem_e(tADM_USUOPERCMP, 'CD_COMPONENTE', vCdComponente);
    retrieve_e(tADM_USUOPERCMP);
    if (xStatus >= 0) then begin
      setocc(tADM_USUOPERCMP, 1);
      while (xStatus >=0) do begin
        creocc(tGER_OPERACAO, -1);
        putitem_e(tGER_OPERACAO, 'CD_OPERACAO', item_f('CD_OPERACAO', tADM_USUOPERCMP));
        retrieve_o(tGER_OPERACAO);
        if (xStatus = -7) then begin
          retrieve_x(tGER_OPERACAO);
          if (item_f('TP_OPERACAO', tGER_OPERACAO) <> vTpOperacao ) and (vTpOperacao <> '') then begin
            discard 'GER_OPERACAOSVC';
          end;
        end else if (xStatus = 0) then begin
          discard 'GER_OPERACAOSVC';
        end;
        setocc(tADM_USUOPERCMP, curocc(tADM_USUOPERCMP) + 1);
      end;
    end else begin
      clear_e(tADM_USUOPERCMP);
    end;
  end;
  if (empty(tADM_USUOPERCMP) <> False) then begin
    clear_e(tV_GER_OPERCMP);
    putitem_e(tV_GER_OPERCMP, 'CD_COMPONENTE', vCdComponente);
    retrieve_e(tV_GER_OPERCMP);
    if (xStatus >= 0) then begin
      setocc(tV_GER_OPERCMP, 1);
      while (xStatus >=0) do begin
        creocc(tGER_OPERACAO, -1);
        putitem_e(tGER_OPERACAO, 'CD_OPERACAO', item_f('CD_OPERACAO', tV_GER_OPERCMP));
        retrieve_o(tGER_OPERACAO);
        if (xStatus = -7) then begin
          retrieve_x(tGER_OPERACAO);
          if (item_f('TP_OPERACAO', tGER_OPERACAO) <> vTpOperacao ) and (vTpOperacao <> '') then begin
            discard 'GER_OPERACAOSVC';
          end;
        end else if (xStatus = 0) then begin
          discard 'GER_OPERACAOSVC';
        end;
        setocc(tV_GER_OPERCMP, curocc(tV_GER_OPERCMP) + 1);
      end;
    end;
  end;
  if (empty(tGER_OPERACAO) = False) then begin
    vTpOrdem := itemXmlF('TP_ORDEM', pParams);
    if (vTpOrdem = 1) then begin
      sort/e(t GER_OPERACAO, 'DS_OPERACAO';);
    end;

    setocc(tGER_OPERACAO, 1);
    putlistitems/id Result, item_f('CD_OPERACAO', tGER_OPERACAO), item_a('DS_OPERACAO', tGER_OPERACAO);
  end;

  return(0); exit;
end;

//----------------------------------------------------------
function T_GERSVCO007.SetEmpresa(pParams : String) : String;
//----------------------------------------------------------
const
  cDS_METHOD = 'ADICONAL=Operação: T_GERSVCO007.SetEmpresa()';
begin
  Result := '';

  clear_e(tGER_EMPRESA);
  putitem_e(tGER_EMPRESA, 'CD_EMPRESA', itemXmlF('CD_EMPRESA', pParams));

  retrieve_e(tGER_EMPRESA);
  if (!xProcerror) then begin
    Result := 'CD_PESSOA=' + cd_pessoa + '.GER_EMPRESA';
  end;
  return(0); exit;

end;

//----------------------------------------------------------------
function T_GERSVCO007.SetPessoaEmpresa(pParams : String) : String;
//----------------------------------------------------------------
const
  cDS_METHOD = 'ADICONAL=Operação: T_GERSVCO007.SetPessoaEmpresa()';
begin
  clear_e(tGER_EMPRESA);
  putitem_e(tGER_EMPRESA, 'CD_PESSOA', itemXmlF('CD_PESSOA', pParams));

  retrieve_e(tGER_EMPRESA);
  if (!xProcerror) then begin
    poInEmpresa := True;
  end else begin
    poInEmpresa := False;
  end;
  return(0); exit;

end;

//----------------------------------------------------------------
function T_GERSVCO007.SetTransferencia(pParams : String) : String;
//----------------------------------------------------------------
const
  cDS_METHOD = 'ADICONAL=Operação: T_GERSVCO007.SetTransferencia()';
begin
  poInTransferencia := False;

  clear_e(tGER_OPERACAO);
  putitem_e(tGER_OPERACAO, 'CD_OPERACAO', piCdOperacao);

  retrieve_e(tGER_OPERACAO);
  if (!xProcerror) then begin
    if (item_f('TP_MODALIDADE', tGER_OPERACAO) = 2) then begin
      poInTransferencia := True;
    end;
  end;
  return(0); exit;

end;

//----------------------------------------------------------
function T_GERSVCO007.VldInValor(pParams : String) : String;
//----------------------------------------------------------
const
  cDS_METHOD = 'ADICONAL=Operação: T_GERSVCO007.VldInValor()';
begin
  clear_e(tGER_OPERVALOR);
  putitem_e(tGER_OPERVALOR, 'CD_OPERACAO', piCdOperacao);
  putitem_e(tGER_OPERVALOR, 'IN_PRECOBASE', True);

  retrieve_e(tGER_OPERVALOR);
  if (xStatus < 0) then begin
    poInPadrao=False;
  end else if (xStatus = 0) then begin
    poInPadrao=True;
  end else begin
  end;
  return(0); exit;

end;

//----------------------------------------------------------
function T_GERSVCO007.VldInSaldo(pParams : String) : String;
//----------------------------------------------------------
const
  cDS_METHOD = 'ADICONAL=Operação: T_GERSVCO007.VldInSaldo()';
begin
  clear_e(tGER_OPERSALDO);
  putitem_e(tGER_OPERSALDO, 'CD_OPERACAO', piCdOperacao);
  putitem_e(tGER_OPERSALDO, 'IN_PADRAO', True);
  retrieve_e(tGER_OPERSALDO);
  if (xStatus < 0) then begin
    poInPadrao=False;
  end else if (xStatus = 0) then begin
    poInPadrao=True;
  end else begin
  end;
  return(0); exit;

end;

//-----------------------------------------------------------
function T_GERSVCO007.VldInKardex(pParams : String) : String;
//-----------------------------------------------------------
const
  cDS_METHOD = 'ADICONAL=Operação: T_GERSVCO007.VldInKardex()';
begin
  clear_e(tGER_OPERSALDO);
  putitem_e(tGER_OPERSALDO, 'CD_OPERACAO', piCdOperacao);
  putitem_e(tGER_OPERSALDO, 'IN_GERAKARDEX', True);
  retrieve_e(tGER_OPERSALDO);
  if (xStatus < 0) then begin
    poInPadrao=False;
  end else if (xStatus = 0) then begin
    poInPadrao=True;
  end else begin
  end;
  return(0); exit;

end;

//------------------------------------------------------------
function T_GERSVCO007.VldInLocacao(pParams : String) : String;
//------------------------------------------------------------
const
  cDS_METHOD = 'ADICONAL=Operação: T_GERSVCO007.VldInLocacao()';
begin
  clear_e(tPRD_LOCACAO);
  putitem_e(tPRD_LOCACAO, 'CD_EMPRESA', itemXmlF('CD_EMPRESA', PARAM_GLB));
  putitem_e(tPRD_LOCACAO, 'CD_PRODUTO', piCdProduto);
  putitem_e(tPRD_LOCACAO, 'IN_PADRAO', True);

  retrieve_e(tPRD_LOCACAO);
  if (xStatus = -2) then begin
    poInPadrao=False;
  end else if (xStatus = 0) then begin
    poInPadrao=True;
  end else begin
  end;

  return(0); exit;

end;

//-----------------------------------------------------------
function T_GERSVCO007.VldInMarkup(pParams : String) : String;
//-----------------------------------------------------------
const
  cDS_METHOD = 'ADICONAL=Operação: T_GERSVCO007.VldInMarkup()';
  clear_e(tPRD_VALOR);
  putitem_e(tPRD_VALOR, 'CD_EMPRESA', itemXmlF('CD_EMPRESA', PARAM_GLB));
  putitem_e(tPRD_VALOR, 'CD_PRODUTO', piCdProduto);
  putitem_e(tPRD_VALOR, 'IN_BASEMARKUP', True);

  retrieve_e(tPRD_VALOR);
  if (xStatus = -2) then begin
    poInPadrao=False;
  end else if (xStatus = 0) then begin
    poInPadrao=True;
  end else begin
  end;

  return(0); exit;

end;

//------------------------------------------------------------
function T_GERSVCO007.ListModeloNF(pParams : String) : String;
//------------------------------------------------------------
const
  cDS_METHOD = 'ADICONAL=Operação: T_GERSVCO007.ListModeloNF()';
  clear_e(tGER_MODNFC);
  retrieve_e(tGER_MODNFC);

  if (xStatus < 0) then begin
    Result := voParams;
    return(-1); exit;
  end;

  exit;
end;

//--------------------------------------------------------------
function T_GERSVCO007.ListTefArquivo(pParams : String) : String;
//--------------------------------------------------------------
const
  cDS_METHOD = 'ADICONAL=Operação: T_GERSVCO007.ListTefArquivo()';
  clear_e(tTEF_ARQUIVO);
  retrieve_e(tTEF_ARQUIVO);
  if (xStatus < 0) then begin
    Result := voParams;
    return(-1); exit;
  end;

  exit;
end;

//-----------------------------------------------------------
function T_GERSVCO007.ListRedeTef(pParams : String) : String;
//-----------------------------------------------------------
const
  cDS_METHOD = 'ADICONAL=Operação: T_GERSVCO007.ListRedeTef()';
  clear_e(tTEF_REDETEF);
  retrieve_e(tTEF_REDETEF);
  if (xStatus < 0) then begin
    Result := voParams;
    return(-1); exit;
  end;

  exit;
end;

//-------------------------------------------------------------
function T_GERSVCO007.ListModeloTRA(pParams : String) : String;
//-------------------------------------------------------------
const
  cDS_METHOD = 'ADICONAL=Operação: T_GERSVCO007.ListModeloTRA()';
  clear_e(tGER_MODTRAC);
  retrieve_e(tGER_MODTRAC);

  if (xStatus < 0) then begin
    Result := voParams;
    return(-1); exit;
  end;

  return(0); exit;
end;

//-------------------------------------------------------------
function T_GERSVCO007.ListTipoSaldo(pParams : String) : String;
//-------------------------------------------------------------
const
  cDS_METHOD = 'ADICONAL=Operação: T_GERSVCO007.ListTipoSaldo()';
  clear_e(tPRD_USUTIPOSA);
  putitem_e(tPRD_USUTIPOSA, 'CD_EMPRESA', itemXmlF('CD_EMPRESA', PARAM_GLB));
  putitem_e(tPRD_USUTIPOSA, 'CD_USUARIO', itemXmlF('CD_USUARIO', PARAM_GLB));
  retrieve_e(tPRD_USUTIPOSA);
  if (xStatus >= 0) then begin
    setocc(tPRD_USUTIPOSA, 1);
    while (xStatus >= 0) do begin
      clear_e(tPRD_TIPOSALDO);
      putitem_e(tPRD_TIPOSALDO, 'CD_SALDO', item_f('CD_SALDO', tPRD_USUTIPOSA));
      retrieve_e(tPRD_TIPOSALDO);
      if (xStatus < 0) then begin
        Result := voParams;
        return(-1); exit;
      end;

      setocc(tPRD_USUTIPOSA, curocc(tPRD_USUTIPOSA) + 1);
    end;

  end else begin
    clear_e(tPRD_TIPOSALDO);
    retrieve_e(tPRD_TIPOSALDO);

    if (xStatus < 0) then begin
      Result := voParams;
      return(-1); exit;
    end;
  end;

  return(0); exit;
end;

//-------------------------------------------------------------
function T_GERSVCO007.ListTipoValor(pParams : String) : String;
//-------------------------------------------------------------
const
  cDS_METHOD = 'ADICONAL=Operação: T_GERSVCO007.ListTipoValor()';
var
  vCdUsuario, vCdEmpresa : Real;
begin
  vCdUsuario := itemXmlF('CD_USUARIO', PARAM_GLB);
  vCdEmpresa := itemXmlF('CD_EMPRESA', PARAM_GLB);

  clear_e(tPRD_TIPOVALOR);
  putitem_e(tPRD_TIPOVALOR, 'TP_VALOR', itemXmlF('TP_VALOR', pParams));
  retrieve_e(tPRD_TIPOVALOR);
  if (xStatus >= 0) then begin
    setocc(tPRD_TIPOVALOR, 1);
    while (xStatus >= 0) do begin
      clear_e(tPRD_USUCDVALO);
      putitem_e(tPRD_USUCDVALO, 'CD_EMPRESA', vCdEmpresa);
      putitem_e(tPRD_USUCDVALO, 'CD_USUARIO', vCdUsuario);
      putitem_e(tPRD_USUCDVALO, 'TP_VALOR', item_f('TP_VALOR', tPRD_TIPOVALOR));
      putitem_e(tPRD_USUCDVALO, 'CD_VALOR', item_f('CD_VALOR', tPRD_TIPOVALOR));
      retrieve_e(tPRD_USUCDVALO);
      if (xStatus < 0)  or (item_f('TP_VALIDACAO', tPRD_USUCDVALO) <> 2) then begin
        putitemXml(Result, item_f('CD_VALOR', tPRD_TIPOVALOR), item_a('DS_VALOR', tPRD_TIPOVALOR));
      end;

      setocc(tPRD_TIPOVALOR, curocc(tPRD_TIPOVALOR) + 1);
    end;
  end;

  return(0); exit;
end;

//------------------------------------------------------------
function T_GERSVCO007.ListTipoClas(pParams : String) : String;
//------------------------------------------------------------
const
  cDS_METHOD = 'ADICONAL=Operação: T_GERSVCO007.ListTipoClas()';
  clear_e(tPRD_TIPOCLAS);
  putitem_e(tPRD_TIPOCLAS, 'IN_GRUPO', itemXmlB('IN_GRUPO', pParams));
  retrieve_e(tPRD_TIPOCLAS);

  if (xStatus < 0) then begin
    Result := voParams;
    return(-1); exit;
  end;

  return(0); exit;
end;

//---------------------------------------------------------------
function T_GERSVCO007.ListTipoClasPat(pParams : String) : String;
//---------------------------------------------------------------
const
  cDS_METHOD = 'ADICONAL=Operação: T_GERSVCO007.ListTipoClasPat()';
  clear_e(tPRD_TIPOCLAS);
  clear_e(tPRD_CFGNIVELC);
  putitem_e(tPRD_CFGNIVELC, 'IN_PATRIMONIO', True);
  retrieve_e(tPRD_CFGNIVELC);
  if (xStatus >= 0) then begin
    setocc(tPRD_CFGNIVELI, 1);
    while (xStatus >= 0) do begin
      creocc(tPRD_TIPOCLAS, -1);
      putitem_e(tPRD_TIPOCLAS, 'CD_TIPOCLAS', item_f('CD_TIPOCLAS', tPRD_CFGNIVELI));
      retrieve_o(tPRD_TIPOCLAS);
      if (xStatus = -7) then begin
        retrieve_x(tPRD_TIPOCLAS);
      end;

      setocc(tPRD_CFGNIVELI, curocc(tPRD_CFGNIVELI) + 1);
    end;
    putlistitems/id Result, item_f('CD_TIPOCLAS', tPRD_TIPOCLAS), item_a('DS_TIPOCLAS', tPRD_TIPOCLAS);
  end;

  return(0); exit;
end;

//------------------------------------------------------------
function T_GERSVCO007.ListCfgNivel(pParams : String) : String;
//------------------------------------------------------------
const
  cDS_METHOD = 'ADICONAL=Operação: T_GERSVCO007.ListCfgNivel()';
  clear_e(tPRD_CFGNIVELC);
  putitem_e(tPRD_CFGNIVELC, 'IN_GRUPO', itemXmlB('IN_GRUPO', pParams));
  retrieve_e(tPRD_CFGNIVELC);

  if (xStatus < 0) then begin
    Result := voParams;
    return(-1); exit;
  end;
    sort/e(t PRD_CFGNIVELC, 'DS_CFGNIVEL';);

    putlistitems/id Result, item_f('CD_CFGNIVEL', tPRD_CFGNIVELC), item_a('DS_CFGNIVEL', tPRD_CFGNIVELC);
  end;

  return(0); exit;
end;

//---------------------------------------------------------------
function T_GERSVCO007.ListCfgNivelPat(pParams : String) : String;
//---------------------------------------------------------------
const
  cDS_METHOD = 'ADICONAL=Operação: T_GERSVCO007.ListCfgNivelPat()';
  clear_e(tPRD_CFGNIVELC);
  putitem_e(tPRD_CFGNIVELC, 'IN_GRUPO', itemXmlB('IN_GRUPO', pParams));
  putitem_e(tPRD_CFGNIVELC, 'IN_PATRIMONIO', True);
  retrieve_e(tPRD_CFGNIVELC);

  if (xStatus < 0) then begin
    Result := voParams;
    return(-1); exit;
  end;
    sort/e(t PRD_CFGNIVELC, 'DS_CFGNIVEL';);

    putlistitems/id Result, item_f('CD_CFGNIVEL', tPRD_CFGNIVELC), item_a('DS_CFGNIVEL', tPRD_CFGNIVELC);
  end;

  return(0); exit;
end;

//--------------------------------------------------------------
function T_GERSVCO007.ListModeloETIQ(pParams : String) : String;
//--------------------------------------------------------------
const
  cDS_METHOD = 'ADICONAL=Operação: T_GERSVCO007.ListModeloETIQ()';
var
  vTpImpressora : String;
begin
  vTpImpressora := itemXmlF('TP_IMPRESSORA', pParams);

  if (vTpImpressora = 'M') then begin
    clear_e(tGER_MODETIQMC);
    putitem_e(tGER_MODETIQMC, 'CD_MODELO', itemXmlF('CD_MODELO', pParams));
    retrieve_e(tGER_MODETIQMC);
    if (xStatus < 0) then begin
      Result := voParams;
      return(-1); exit;
    end;
  end else begin
    clear_e(tGER_MODETIQC);
    putitem_e(tGER_MODETIQC, 'CD_MODELO', itemXmlF('CD_MODELO', pParams));
    retrieve_e(tGER_MODETIQC);
    if (xStatus < 0) then begin
      Result := voParams;
      return(-1); exit;
    end;
  end;

  return(0); exit;
end;

//--------------------------------------------------------
function T_GERSVCO007.ListPais(pParams : String) : String;
//--------------------------------------------------------
const
  cDS_METHOD = 'ADICONAL=Operação: T_GERSVCO007.ListPais()';
  clear_e(tGLB_PAIS);
  retrieve_e(tGLB_PAIS);

  if (xStatus < 0) then begin
    Result := voParams;
    return(-1); exit;
  end;

  return(0); exit;
end;

//----------------------------------------------------------
function T_GERSVCO007.ListEstado(pParams : String) : String;
//----------------------------------------------------------
const
  cDS_METHOD = 'ADICONAL=Operação: T_GERSVCO007.ListEstado()';
  clear_e(tGLB_ESTADO);
  putitem_e(tGLB_ESTADO, 'CD_PAIS', itemXmlF('CD_PAIS', pParams));
  retrieve_e(tGLB_ESTADO);

  if (xStatus < 0) then begin
    Result := voParams;
    return(-1); exit;
  end;

  return(0); exit;
end;

//-------------------------------------------------------------
function T_GERSVCO007.ListMunicipio(pParams : String) : String;
//-------------------------------------------------------------
const
  cDS_METHOD = 'ADICONAL=Operação: T_GERSVCO007.ListMunicipio()';
  clear_e(tGLB_MUNICIPIO);
  putitem_e(tGLB_MUNICIPIO, 'CD_ESTADO', itemXmlF('CD_ESTADO', pParams));
  retrieve_e(tGLB_MUNICIPIO);
  if (xStatus < 0) then begin
    Result := voParams;
    return(-1); exit;
  end;

  return(0); exit;
end;

//----------------------------------------------------------------
function T_GERSVCO007.ListTpLogradouro(pParams : String) : String;
//----------------------------------------------------------------
const
  cDS_METHOD = 'ADICONAL=Operação: T_GERSVCO007.ListTpLogradouro()';
  clear_e(tGLB_TPLOGRADO);
  retrieve_e(tGLB_TPLOGRADO);

  if (xStatus < 0) then begin
    Result := voParams;
    return(-1); exit;
  end;

  return(0); exit;
end;

//----------------------------------------------------------------
function T_GERSVCO007.ListGrupoEmpresa(pParams : String) : String;
//----------------------------------------------------------------
const
  cDS_METHOD = 'ADICONAL=Operação: T_GERSVCO007.ListGrupoEmpresa()';
var
  vCdPoolEmpresa : Real;
begin
  vCdPoolEmpresa := itemXmlF('CD_POOLEMPRESA', PARAM_GLB);

  if (vCdPoolEmpresa > 0) then begin
    clear_e(tGER_POOLGRUPO);
    putitem_e(tGER_POOLGRUPO, 'CD_POOLEMPRESA', vCdPoolEmpresa);
    retrieve_e(tGER_POOLGRUPO);
    if (xStatus < 0) then begin
      Result := voParams;
      return(-1); exit;
    end;
  end else begin
    clear_e(tGER_GRUPOEMPR);
    retrieve_e(tGER_GRUPOEMPR);
    if (xStatus < 0) then begin
      Result := voParams;
      return(-1); exit;
    end;
  end;

  return(0); exit;
end;

//-----------------------------------------------------------
function T_GERSVCO007.ListEmpresa(pParams : String) : String;
//-----------------------------------------------------------
const
  cDS_METHOD = 'ADICONAL=Operação: T_GERSVCO007.ListEmpresa()';
var
  vCdGrupoEmpresa, vCdUsuario, vCdPoolEmpresa : Real;
  vDsComponente, vDsEmpresa, vDsGrupoEmpresa, vLstEmpresa, viParams, voParams : String;
  vInPoolEmpresa : Boolean;
begin
  vCdGrupoEmpresa := itemXmlF('CD_GRUPOEMPRESA', PARAM_GLB);
  vCdUsuario := itemXmlF('CD_USUARIO', PARAM_GLB);
  vDsComponente := itemXml('DS_COMPONENTE', pParams);
  vInPoolEmpresa := itemXmlB('IN_POOLEMPRESA', pParams);

  clear_e(tGER_EMPRESA);

  voParams := activateCmp('ADMSVCO006', 'GetPerfil', viParams); (*,vCdUsuario,vDsComponente,'',vDsEmpresa,vDsGrupoEmpresa,, *)
  if (xStatus < 0) then begin
    Result := voParams;
    return(-1); exit;
  end;
  if (vInPoolEmpresa = True) then begin
    vCdPoolEmpresa := itemXmlF('CD_POOLEMPRESA', PARAM_GLB);
    if (vCdPoolEmpresa > 0) then begin
      vDsEmpresa := '';
      clear_e(tGER_POOLGRUPO);
      putitem_e(tGER_POOLGRUPO, 'CD_POOLEMPRESA', vCdPoolEmpresa);
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
              vDsEmpresa := '' + vDsEmpresa' + CD_EMPRESA + ' + '.GER_EMPRESA;
              setocc(tGER_EMPRESA, curocc(tGER_EMPRESA) + 1);
            end;
          end;
          setocc(tGER_POOLGRUPO, curocc(tGER_POOLGRUPO) + 1);
        end;
      end;
      viParams := '';
      putitemXml(viParams, 'CD_EMPRESA', vDsEmpresa);
      putitemXml(viParams, 'IN_CCUSTO', False);
      voParams := activateCmp('SICSVCO004', 'validaEmpresa', viParams); (*,viParams,voParams,, *)
      if (xStatus < 0) then begin
        Result := voParams;
        return(-1); exit;
      end;
      vDsEmpresa := itemXml('LST_EMPRESA', voParams);

      clear_e(tGER_EMPRESA);
    end;
  end;

  putitem_e(tGER_EMPRESA, 'CD_EMPRESA', vDsEmpresa);
  retrieve_e(tGER_EMPRESA);
  if (xStatus < 0) then begin
    Result := voParams;
    return(-1); exit;
  end;

  return(0); exit;
end;

//-----------------------------------------------------------
function T_GERSVCO007.getCdCCusto(pParams : String) : String;
//-----------------------------------------------------------
const
  cDS_METHOD = 'ADICONAL=Operação: T_GERSVCO007.getCdCCusto()';
var
  vCdEmpresa, vCdCCusto : Real;
begin
  vCdEmpresa := itemXmlF('CD_EMPRESA', pParams);
  vCdCCusto := 0;

  if (vCdEmpresa <> 0) then begin
    clear_e(tGER_EMPRESA);
    putitem_e(tGER_EMPRESA, 'CD_EMPRESA', vCdEmpresa);
    retrieve_e(tGER_EMPRESA);
    if (xStatus >= 0) then begin
      vCdCCusto := item_f('CD_CCUSTO', tGER_EMPRESA);
    end;
  end;

  Result := '';
  putitemXml(Result, 'CD_CCUSTO', vCdCCusto);

  return(0); exit;
end;

//------------------------------------------------------------
function T_GERSVCO007.ListPortador(pParams : String) : String;
//------------------------------------------------------------
const
  cDS_METHOD = 'ADICONAL=Operação: T_GERSVCO007.ListPortador()';
var
  vTpPortador : Real;
begin
  vTpPortador := itemXmlF('TP_PORTADOR', pParams);

  clear_e(tFGR_PORTADOR);
  putitem_e(tFGR_PORTADOR, 'TP_PORTADOR', vTpPortador);
  retrieve_e(tFGR_PORTADOR);
    if (xStatus >= 0) then begin
    putlistitems/id Result, item_f('NR_PORTADOR', tFGR_PORTADOR), item_a('DS_PORTADOR', tFGR_PORTADOR);
  end;

  return(0); exit;
end;

//--------------------------------------------------------------
function T_GERSVCO007.ListHistRelSub(pParams : String) : String;
//--------------------------------------------------------------
const
  cDS_METHOD = 'ADICONAL=Operação: T_GERSVCO007.ListHistRelSub()';
var
  vTpDocumento, vNrPortador, vCdCartao : Real;
begin
  Result := '';
  vTpDocumento := itemXmlF('TP_DOCUMENTO', pParams);
  vNrPortador := itemXmlF('NR_PORTADOR', pParams);
  vCdCartao := itemXmlF('CD_CARTAO', pParams);

  if (vTpDocumento = 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Tipo documento não informado!', cDS_METHOD);
    return(-1); exit;
  end;
  if (vCdCartao <> 0) then begin
    clear_e(tCTC_CARTAO);
    putitem_e(tCTC_CARTAO, 'CD_CARTAO', vCdCartao);
    retrieve_e(tCTC_CARTAO);
    if (xStatus < 0) then begin
      Result := SetStatus(STS_ERROR, 'GEN0001', 'Cartão ' + FloatToStr(vCdCartao) + ' inválido!', cDS_METHOD);
      return(-1); exit;
    end;
  end;

  clear_e(tFCX_HISTRELSU);
  putitem_e(tFCX_HISTRELSU, 'TP_DOCUMENTO', vTpDocumento);
  putitem_e(tFCX_HISTRELSU, 'NR_PORTADOR', vNrPortador);
  retrieve_e(tFCX_HISTRELSU);
  if (xStatus >= 0) then begin
    setocc(tFCX_HISTRELSU, 1);
    while (xStatus >= 0) do begin
      if (vCdCartao <> 0) then begin
        clear_e(tCTC_TPCARPAR);
        putitem_e(tCTC_TPCARPAR, 'TP_DOCUMENTO', vTpDocumento);
        putitem_e(tCTC_TPCARPAR, 'NR_SEQHISTRELSUB', item_f('NR_SEQHISTRELSUB', tFCX_HISTRELSU));
        retrieve_e(tCTC_TPCARPAR);
        if (xStatus >= 0) then begin
          if (item_f('CD_TPCARTAO', tCTC_CARTAO) = item_f('CD_TPCARTAO', tCTC_TPCARPAR)) then begin
            putitemXml(Result, item_f('NR_SEQHISTRELSUB', tFCX_HISTRELSU), item_a('DS_HISTRELSUB', tFCX_HISTRELSU));
          end;
        end else begin
          putitemXml(Result, item_f('NR_SEQHISTRELSUB', tFCX_HISTRELSU), item_a('DS_HISTRELSUB', tFCX_HISTRELSU));
        end;
      end else begin

        putitemXml(Result, item_f('NR_SEQHISTRELSUB', tFCX_HISTRELSU), item_a('DS_HISTRELSUB', tFCX_HISTRELSU));
      end;
      setocc(tFCX_HISTRELSU, curocc(tFCX_HISTRELSU) + 1);
    end;
  end;

  return(0); exit;
end;

//--------------------------------------------------------------------
function T_GERSVCO007.listTipoValorProduto(pParams : String) : String;
//--------------------------------------------------------------------
const
  cDS_METHOD = 'ADICONAL=Operação: T_GERSVCO007.listTipoValorProduto()';
var
  vCdUsuario : Real;
begin
  vCdUsuario := itemXmlF('CD_USUARIO', pParams);
  if (vCdUsuario = 0) then begin
    vCdUsuario := itemXmlF('CD_USUARIO', PARAM_GLB);
  end;

  Result := '';

  clear_e(tPRD_USUTIPOVA);
  putitem_e(tPRD_USUTIPOVA, 'CD_USUARIO', vCdUsuario);
  retrieve_e(tPRD_USUTIPOVA);
  if (xStatus < 0) then begin
    putitemXml(Result, 'C', 'Custo');
    putitemXml(Result, 'P', 'Preço');
  end else begin
    if (item_b('IN_CUSTO', tPRD_USUTIPOVA) = True) then begin
      putitemXml(Result, 'C', 'Custo');
    end;
    if (item_b('IN_PRECO', tPRD_USUTIPOVA) = True) then begin
      putitemXml(Result, 'P', 'Preço');
    end;
  end;

  return(0); exit;
end;

//---------------------------------------------------------------
function T_GERSVCO007.listTipoClasPed(pParams : String) : String;
//---------------------------------------------------------------
const
  cDS_METHOD = 'ADICONAL=Operação: T_GERSVCO007.listTipoClasPed()';
var
  vTpTipoClas : Real;
begin
  vTpTipoclas := itemXmlF('TP_TIPOCLAS', pParams);

  clear_e(tPED_TIPOCLAS);

  if (vTpTipoClas <> '') then begin
    putitem_e(tPED_TIPOCLAS, 'TP_TIPOCLAS', vTpTipoClas);
  end;

  retrieve_e(tPED_TIPOCLAS);
  if (xStatus < 0) then begin
    Result := voParams;
    return(-1); exit;
  end;

  return(0); exit;
end;

//---------------------------------------------------------------
function T_GERSVCO007.listTipoClasCmp(pParams : String) : String;
//---------------------------------------------------------------
const
  cDS_METHOD = 'ADICONAL=Operação: T_GERSVCO007.listTipoClasCmp()';
begin
  clear_e(tCMP_TIPOCLAS);
  retrieve_e(tCMP_TIPOCLAS);
  if (xStatus < 0) then begin
    Result := voParams;
    return(-1); exit;
  end;

  return(0); exit;
end;

//---------------------------------------------------------
function T_GERSVCO007.listaNrNF(pParams : String) : String;
//---------------------------------------------------------
const
  cDS_METHOD = 'ADICONAL=Operação: T_GERSVCO007.listaNrNF()';
var
  vCdSerie : String;
  vCdEmpresa, vNrNF : Real;
begin
  vCdEmpresa := itemXmlF('CD_EMPRESA', pParams);
  vCdSerie := itemXmlF('CD_SERIE', pParams);

  vNrNf := '';

  if (vCdEmpresa = 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Empresa não informada!', cDS_METHOD);
    return(-1); exit;
  end;
  if (vCdSerie = '') then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Série não informada!', cDS_METHOD);
    return(-1); exit;
  end;

  clear_e(tGER_SERIE);
  putitem_e(tGER_SERIE, 'CD_SERIE', vCdSerie);
  retrieve_e(tGER_SERIE);
  if (xStatus >= 0) then begin
    clear_e(tGER_NREMPSEQ);
    putitem_e(tGER_NREMPSEQ, 'CD_EMPRESA', vCdEmpresa);
    putitem_e(tGER_NREMPSEQ, 'NM_ENTIDADE', 'FIS_NF');
    putitem_e(tGER_NREMPSEQ, 'NM_ATRIBUTO', item_a('DS_SIGLA', tGER_SERIE));
    retrieve_e(tGER_NREMPSEQ);
    if (xStatus >= 0) then begin
      vNrNf := item_f('NR_ATUAL', tGER_NREMPSEQ);
    end;
  end else begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Série ' + FloatToStr(vCdSerie) + ' inválida!', cDS_METHOD);
    return(-1); exit;
  end;

  putitemXml(Result, 'NR_NF', vNrNf);

  return(0); exit;

end;

//-----------------------------------------------------------
function T_GERSVCO007.ListTipoCor(pParams : String) : String;
//-----------------------------------------------------------
const
  cDS_METHOD = 'ADICONAL=Operação: T_GERSVCO007.ListTipoCor()';
begin
  clear_e(tPRD_GRUCOR);
  retrieve_e(tPRD_GRUCOR);

  if (xStatus < 0) then begin
    Result := voParams;
    return(-1); exit;
  end;

  return(0); exit;

end;

//---------------------------------------------------------------
function T_GERSVCO007.ListTipoClasPes(pParams : String) : String;
//---------------------------------------------------------------
const
  cDS_METHOD = 'ADICONAL=Operação: T_GERSVCO007.ListTipoClasPes()';
begin
  clear_e(tPES_TIPOCLAS);
  retrieve_e(tPES_TIPOCLAS);

  if (xStatus < 0) then begin
    Result := voParams;
    return(-1); exit;
  end;

  return(0); exit;
end;

//---------------------------------------------------------------
function T_GERSVCO007.ListTipoClasTra(pParams : String) : String;
//---------------------------------------------------------------
const
  cDS_METHOD = 'ADICONAL=Operação: T_GERSVCO007.ListTipoClasTra()';
begin
  clear_e(tTRA_TIPOCLAS);
  putitem_e(tTRA_TIPOCLAS, 'TP_TIPOCLAS', itemXmlF('TP_TIPOCLAS', pParams));
  retrieve_e(tTRA_TIPOCLAS);

  if (xStatus < 0) then begin
    Result := voParams;
    return(-1); exit;
  end;

  return(0); exit;
end;

//----------------------------------------------------------------------
function T_GERSVCO007.ListaProdutoFinanceiro(pParams : String) : String;
//----------------------------------------------------------------------
const
  cDS_METHOD = 'ADICONAL=Operação: T_GERSVCO007.ListaProdutoFinanceiro()';
begin
  clear_e(tPRF_TIPOPRDFI);
  retrieve_e(tPRF_TIPOPRDFI);
  if (xStatus < 0) then begin
    Result := voParams;
    return(-1); exit;
  end;

  return(0); exit;
end;

end.
