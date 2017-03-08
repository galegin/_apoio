unit cPESSVCO011;

interface

(* COMPONENTES 
  ADMSVCO001 / GERSVCO031 / PESSVCO007 / PESSVCO014 / 
*)        

uses
  Classes, SysUtils, Math, DB,
  cDataSetUnf;

type
  T_PESSVCO011 = class(TComponent)
  private
    tF_PES_LIMITE,
    tGER_CONDPGTOC,
    tGER_CONDPGTOI,
    tGER_EMPRESA,
    tPES_CLASSIFIC,
    tPES_CLIENTE,
    tPES_CLIENTEES,
    tPES_FORNECEDO,
    tPES_LIMITE,
    tPES_PESFISICA,
    tPES_PESJURIDI,
    tPES_PESSOA,
    tPES_PESSOACLA,
    tPES_PREFCLIEN,
    tPES_REPRCLIEN,
    tPES_S2_PESSOA : TcDatasetUnf;
    function getParam(pParams : String = '') : String;
    function setEntidade(pParams : String = '') : String;
  protected
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;    
  published
    function VerCondCliente(pParams : String = '') : String;
    function VerFormaPgto(pParams : String = '') : String;
    function VerBloqueioCli(pParams : String = '') : String;
    function VerEstatistica(pParams : String = '') : String;
    function GravaEstatistica(pParams : String = '') : String;
    function SetRepCliente(pParams : String = '') : String;
    function GravaRepCliente(pParams : String = '') : String;
    function BuscaLimite(pParams : String = '') : String;
    function habilitaPessoaFornecedor(pParams : String = '') : String;
    function gravaLimiteCliente(pParams : String = '') : String;
    function gravaLogLimiteCliente(pParams : String = '') : String;
    function gravaPessoa(pParams : String = '') : String;
    function buscaPreferenciaCliente(pParams : String = '') : String;
  end;

implementation

uses
  cADMSVCO001,
  cActivate, cStatus, cFuncao, cXml, dModulo;

var
  gCdClasClientePdv : String;

//---------------------------------------------------------------
constructor T_PESSVCO011.Create(AOwner: TComponent);
//---------------------------------------------------------------
begin
  inherited Create(AOwner);
  setEntidade('');
end;

//--------------------------------
destructor T_PESSVCO011.Destroy;
//--------------------------------
begin
  inherited Destroy;
end;

//---------------------------------------------------------------
function T_PESSVCO011.getParam(pParams : String = '') : String;
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
  putitem(xParamEmp, 'CD_CLAS_GRAVA_CLIENTE_PDV');

  xParamEmp := T_ADMSVCO001.GetParamEmpresa(piCdEmpresa, xParamEmp);

  gCdClasClientePdv := itemXml('CD_CLAS_GRAVA_CLIENTE_PDV', xParamEmp);

end;

//---------------------------------------------------------------
function T_PESSVCO011.setEntidade(pParams : String = '') : String;
//---------------------------------------------------------------
begin
  tF_PES_LIMITE := TcDatasetUnf.getEntidade('F_PES_LIMITE');
  tGER_CONDPGTOC := TcDatasetUnf.getEntidade('GER_CONDPGTOC');
  tGER_CONDPGTOI := TcDatasetUnf.getEntidade('GER_CONDPGTOI');
  tGER_EMPRESA := TcDatasetUnf.getEntidade('GER_EMPRESA');
  tPES_CLASSIFIC := TcDatasetUnf.getEntidade('PES_CLASSIFIC');
  tPES_CLIENTE := TcDatasetUnf.getEntidade('PES_CLIENTE');
  tPES_CLIENTEES := TcDatasetUnf.getEntidade('PES_CLIENTEES');
  tPES_FORNECEDO := TcDatasetUnf.getEntidade('PES_FORNECEDO');
  tPES_LIMITE := TcDatasetUnf.getEntidade('PES_LIMITE');
  tPES_PESFISICA := TcDatasetUnf.getEntidade('PES_PESFISICA');
  tPES_PESJURIDI := TcDatasetUnf.getEntidade('PES_PESJURIDI');
  tPES_PESSOA := TcDatasetUnf.getEntidade('PES_PESSOA');
  tPES_PESSOACLA := TcDatasetUnf.getEntidade('PES_PESSOACLA');
  tPES_PREFCLIEN := TcDatasetUnf.getEntidade('PES_PREFCLIEN');
  tPES_REPRCLIEN := TcDatasetUnf.getEntidade('PES_REPRCLIEN');
  tPES_S2_PESSOA := TcDatasetUnf.getEntidade('PES_S2_PESSOA');
end;

//--------------------------------------------------------------
function T_PESSVCO011.VerCondCliente(pParams : String) : String;
//--------------------------------------------------------------
const
  cDS_METHOD = 'ADICONAL=Operação: T_PESSVCO011.VerCondCliente()';
var
  vTpFormaPgto : String;
begin
  clear_e(tPES_CLIENTE);
  putitem_e(tPES_CLIENTE, 'CD_CLIENTE', itemXmlF('CD_PESSOA', pParams));
  retrieve_e(tPES_CLIENTE);
  if (xStatus < 0) then begin
    Result := voParams;
    return(-1); exit;
  end;
    if (xStatus < 0) then begin
      Result := voParams;
      return(-1); exit;
    end;
      setocc(tGER_CONDPGTOI, 1);
      if (item_f('TP_FORMAPGTO', tPES_CLIENTE) = 1) then begin
        if (item_f('NR_PARCELAS', tGER_CONDPGTOC) > 1)  or %\ then begin
        (item_f('QT_DIA', tGER_CONDPGTOI) > 0);
        voParams := SetErroApl(viParams); (* 'ERRO=-1;
        return(0); exit;
      end;
    end;
  end;
end;

return(0); exit;
end;

//------------------------------------------------------------
function T_PESSVCO011.VerFormaPgto(pParams : String) : String;
//------------------------------------------------------------
const
  cDS_METHOD = 'ADICONAL=Operação: T_PESSVCO011.VerFormaPgto()';
var
  vTpFormaPgto : String;
begin
  vTpFormaPgto := itemXmlF('TP_FORMAPGTO', pParams);

  clear_e(tPES_CLIENTE);
  putitem_e(tPES_CLIENTE, 'CD_CLIENTE', itemXmlF('CD_PESSOA', pParams));
  retrieve_e(tPES_CLIENTE);
  if (xStatus < 0) then begin
    Result := voParams;
    return(-1); exit;
  end;
    end else begin
      if (item_f('TP_FORMAPGTO', tPES_CLIENTE) = 2) then begin
        if (vTpFormaPgto = 0) then begin
          voParams := SetErroApl(viParams); (* 'ERRO=-1;
        end;
      end;
    end;
  end;

  return(0); exit;
end;

//--------------------------------------------------------------
function T_PESSVCO011.VerBloqueioCli(pParams : String) : String;
//--------------------------------------------------------------
const
  cDS_METHOD = 'ADICONAL=Operação: T_PESSVCO011.VerBloqueioCli()';
  clear_e(tPES_CLIENTE);
  putitem_e(tPES_CLIENTE, 'CD_CLIENTE', itemXmlF('CD_PESSOA', pParams));
  retrieve_e(tPES_CLIENTE);
  if (xStatus < 0) then begin
    Result := voParams;
    return(-1); exit;
  end;
    end;
  end;

  return(0); exit;
end;

//--------------------------------------------------------------
function T_PESSVCO011.VerEstatistica(pParams : String) : String;
//--------------------------------------------------------------
const
  cDS_METHOD = 'ADICONAL=Operação: T_PESSVCO011.VerEstatistica()';
var
  vLimite,vSN : String;
begin
  vLimite := 0;

  clear_e(tPES_CLIENTEES);
  putitem_e(tPES_CLIENTEES, 'CD_CLIENTE', itemXmlF('CD_PESSOA', pParams));
  retrieve_e(tPES_CLIENTEES);
  if (!xProcerror) then begin
    vLimite := item_f('VL_FATORLIMITE', tPES_CLIENTEES);
  end;

  Result := 'VL_LIMITE=' + vLimite' + ';
  return(0); exit;

end;

//----------------------------------------------------------------
function T_PESSVCO011.GravaEstatistica(pParams : String) : String;
//----------------------------------------------------------------
const
  cDS_METHOD = 'ADICONAL=Operação: T_PESSVCO011.GravaEstatistica()';
  clear_e(tPES_CLIENTEES);
  putitem_e(tPES_CLIENTEES, 'CD_CLIENTE', itemXmlF('CD_PESSOA', pParams));
  retrieve_e(tPES_CLIENTEES);
  if (!xProcerror) then begin
    putitem_e(tPES_CLIENTEES, 'VL_ULTCOMPRA', itemXmlF('VL_TOTALNOTA', pParams));
    putitem_e(tPES_CLIENTEES, 'DT_ULTCOMPRA', itemXml('DT_EMISSAO', pParams));
    if (item_f('VL_ULTCOMPRA', tPES_CLIENTEES)   > item_f('VL_MAIORCOMPRA', tPES_CLIENTEES)) then begin
      putitem_e(tPES_CLIENTEES, 'VL_MAIORCOMPRA', itemXmlF('VL_TOTALNOTA', pParams));
      putitem_e(tPES_CLIENTEES, 'DT_MAIORCOMPRA', itemXml('DT_EMISSAO', pParams));
    end;
    voParams := tPES_CLIENTEES.Salvar();
    if (xStatus < 0) then begin
      Result := voParams;
      return(-1); exit;
    end;
  end;

  return(0); exit;
end;

//-------------------------------------------------------------
function T_PESSVCO011.SetRepCliente(pParams : String) : String;
//-------------------------------------------------------------
const
  cDS_METHOD = 'ADICONAL=Operação: T_PESSVCO011.SetRepCliente()';
var
  (* string piGlobal :IN *)
  vInDisponivel : String;
begin
  vInDisponivel := False;

  clear_e(tPES_REPRCLIEN);
  putitem_e(tPES_REPRCLIEN, 'CD_REPRESENTANT', itemXmlF('CD_PESSOA', piGlobal));
  putitem_e(tPES_REPRCLIEN, 'CD_CLIENTE', itemXmlF('CD_PESSOA', pParams));
  if (item_f('CD_REPRESENTANT', tPES_REPRCLIEN)  = item_f('CD_CLIENTE', tPES_REPRCLIEN)) then begin
    vInDisponivel := True;
  end else begin
    retrieve_o(tPES_REPRCLIEN);
    if (xStatus = -7) then begin
      retrieve_x(tPES_REPRCLIEN);
      if (!xProcerror) then begin
        vInDisponivel := True;
      end;
    end;
  end;
  Result := 'IN_DISPONIVEL=' + vInDisponivel' + ';
  return(0); exit;
end;

//---------------------------------------------------------------
function T_PESSVCO011.GravaRepCliente(pParams : String) : String;
//---------------------------------------------------------------
const
  cDS_METHOD = 'ADICONAL=Operação: T_PESSVCO011.GravaRepCliente()';
  creocc(tPES_REPRCLIEN, -1);
  putitem_e(tPES_REPRCLIEN, 'CD_REPRESENTANT', itemXmlF('CD_PESSOA', piGlobal));
  putitem_e(tPES_REPRCLIEN, 'CD_CLIENTE', itemXmlF('CD_PESSOA', pParams));
  if (item_f('CD_REPRESENTANT', tPES_REPRCLIEN) <> item_f('CD_CLIENTE', tPES_REPRCLIEN)) then begin
    retrieve_e(tPES_REPRCLIEN);
    if (xStatus = -2) then begin
      putitem_e(tPES_REPRCLIEN, 'CD_OPERADOR', itemXmlF('CD_USUARIO', piglobal));
      putitem_e(tPES_REPRCLIEN, 'DT_CADASTRO', Now);
      voParams := tPES_REPRCLIEN.Salvar();
      if (xStatus < 0) then begin
        return (xStatus);
      end;
    end;
  end;
  return(0); exit;
end;

//-----------------------------------------------------------
function T_PESSVCO011.BuscaLimite(pParams : String) : String;
//-----------------------------------------------------------
const
  cDS_METHOD = 'ADICONAL=Operação: T_PESSVCO011.BuscaLimite()';
var
  (* string piGlobal :IN *)
  vCdCliente, vCdGrupoEmpresa, vLimite : Real;
begin
  vCdCliente := itemXmlF('CD_CLIENTE', pParams);
  if (vCdCliente = 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Cliente não informado!', cDS_METHOD);
    return(-1); exit;
  end;

  vCdGrupoEmpresa := itemXmlF('CD_GRUPOEMPRESA', pParams);
  if (vCdGrupoEmpresa = 0) then begin
    vCdGrupoEmpresa := itemXmlF('CD_GRUPOEMPRESA', piGlobal);
  end;

  clear_e(tGER_EMPRESA);
  putitem_e(tGER_EMPRESA, 'CD_GRUPOEMPRESA', vCdGrupoEmpresa);
  retrieve_e(tGER_EMPRESA);
  if (xStatus >=0) then begin
    setocc(tGER_EMPRESA, 1);
    while (xStatus >= 0) do begin
      clear_e(tPES_CLIENTEES);
      putitem_e(tPES_CLIENTEES, 'CD_CLIENTE', vCdCliente);
      putitem_e(tPES_CLIENTEES, 'CD_EMPRESA', item_f('CD_EMPRESA', tGER_EMPRESA));
      retrieve_e(tPES_CLIENTEES);
      if (xStatus >= 0) then begin
        vLimite := vLimite + item_f('VL_FATORLIMITE', tPES_CLIENTEES);
      end;
      setocc(tGER_EMPRESA, curocc(tGER_EMPRESA) + 1);
    end;
  end;

  putitemXml(Result, 'VL_LIMITE', vLimite);

  return(0); exit;
  end;

//------------------------------------------------------------------------
function T_PESSVCO011.habilitaPessoaFornecedor(pParams : String) : String;
//------------------------------------------------------------------------
const
  cDS_METHOD = 'ADICONAL=Operação: T_PESSVCO011.habilitaPessoaFornecedor()';
var
  (* string piGlobal :IN *)
  vCdPessoa : Real;
begin
  vCdPessoa := itemXmlF('CD_PESSOA', pParams);
  if (vCdPessoa = '')  or (vCdPessoa = 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN001', , cDS_METHOD);
    return(-1); exit;
  end;

  clear_e(tPES_FORNECEDO);
  putitem_e(tPES_FORNECEDO, 'CD_FORNECEDOR', vCdPessoa);
  retrieve_e(tPES_FORNECEDO);
  if (xStatus < 0) then begin
    creocc(tPES_FORNECEDO, -1);
    putitem_e(tPES_FORNECEDO, 'CD_FORNECEDOR', vCdPessoa);
    putitem_e(tPES_FORNECEDO, 'IN_ICMSRECUP', False);
    putitem_e(tPES_FORNECEDO, 'IN_ISO', False);
    putitem_e(tPES_FORNECEDO, 'IN_INATIVO', False);
    putitem_e(tPES_FORNECEDO, 'CD_OPERADOR', itemXmlF('CD_USUARIO', piGlobal));
    putitem_e(tPES_FORNECEDO, 'DT_CADASTRO', Now);

    voParams := tPES_FORNECEDO.Salvar();
    if (xStatus < 0) then begin
      Result := voParams;
      return(-1); exit;
    end;
  end;

  return(0); exit;
end;

//------------------------------------------------------------------
function T_PESSVCO011.gravaLimiteCliente(pParams : String) : String;
//------------------------------------------------------------------
const
  cDS_METHOD = 'ADICONAL=Operação: T_PESSVCO011.gravaLimiteCliente()';
var
  (* string piGlobal :IN *)
  vDsObs, vDsLstCliente, viParams, voParams : String;
  vCdCliente, vCdEmpresa, vVlLimite, vCdGrupoEmpresa : Real;
begin
  vCdEmpresa := itemXmlF('CD_EMPRESA', pParams);
  vCdCliente := itemXmlF('CD_CLIENTE', pParams);
  vVlLimite := itemXmlF('VL_LIMITE', pParams);
  vDsObs := itemXml('DS_OBS', pParams);

  if (vCdEmpresa = '') then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Empresa não informada!', cDS_METHOD);
    return(-1); exit;
  end;
  if (vCdCliente = '') then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Cliente não informado!', cDS_METHOD);
    return(-1); exit;
  end;
  if (vDsObs = '') then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Observação (motivo) não informado!', cDS_METHOD);
    return(-1); exit;
  end;

  clear_e(tGER_EMPRESA);
  putitem_e(tGER_EMPRESA, 'CD_EMPRESA', vCdEmpresa);
  retrieve_e(tGER_EMPRESA);
  if (xStatus >= 0) then begin
    vCdGrupoEmpresa := item_f('CD_GRUPOEMPRESA', tGER_EMPRESA);
  end;

  clear_e(tPES_CLIENTE);
  putitem_e(tPES_CLIENTE, 'CD_CLIENTE', vCdCliente);
  retrieve_e(tPES_CLIENTE);
  if (xStatus < 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Cliente ' + FloatToStr(vCdCliente) + ' não encontrado!', cDS_METHOD);
    return(-1); exit;
  end;

  clear_e(tPES_CLIENTEES);
  creocc(tPES_CLIENTEES, -1);
  putitem_e(tPES_CLIENTEES, 'CD_EMPRESA', vCdEmpresa);
  retrieve_o(tPES_CLIENTEES);
  if (xStatus = -7) then begin
    retrieve_x(tPES_CLIENTEES);
  end;

  putitem_e(tPES_CLIENTEES, 'VL_FATORLIMITE', vVlLimite);
  putitem_e(tPES_CLIENTEES, 'CD_GRUPOEMPRESA', vCdGrupoEmpresa);
  putitem_e(tPES_CLIENTEES, 'DT_CADASTRO', Now);
  putitem_e(tPES_CLIENTEES, 'CD_OPERADOR', itemXmlF('CD_USUARIO', piGlobal));

  voParams := tPES_CLIENTEES.Salvar();
  if (xStatus < 0) then begin
    Result := voParams;
    return(-1); exit;
  end;

  vDsLstCliente := '';
  putitem(vDsLstCliente,  vCdCliente);
  viParams := '';
  putitemXml(viParams, 'DS_LSTCLIENTE', vDsLstCliente);
  putitemXml(viParams, 'CD_COMPONENTE', PESSVCO011);
  putitemXml(viParams, 'DS_OBSERVACAO', vDsObs);
  voParams := activateCmp('PESSVCO014', 'gravaObsCliente', viParams);
  if (xStatus < 0) then begin
    Result := voParams;
    return(-1); exit;
  end;

  return(0); exit;
end;

//---------------------------------------------------------------------
function T_PESSVCO011.gravaLogLimiteCliente(pParams : String) : String;
//---------------------------------------------------------------------
const
  cDS_METHOD = 'ADICONAL=Operação: T_PESSVCO011.gravaLogLimiteCliente()';
var
  (* string piGlobal :IN *)
  vCdCliente, vCdEmpresa, vNrSequencia, vTpOperacao, vCdEmpOper, vCdAutorizador : Real;
  vVlLimAntes, vVlSalAntes, vVlOperacao, vVlLimApos, vVlSalApos : Real;
  viParams, voParams, vCdComponente, vDsOperacao, vCdSitAntes, vCdSitApos : String;
begin
  vCdEmpresa := itemXmlF('CD_EMPRESA', piGlobal);
  vCdCliente := itemXmlF('CD_CLIENTE', pParams);
  vCdSitAntes := itemXmlF('CD_SITANTES', pParams);
  vVlLimAntes := itemXmlF('VL_LIMANTES', pParams);
  vVlSalAntes := itemXmlF('VL_SALANTES', pParams);
  vTpOperacao := itemXmlF('TP_OPERACAO', pParams);
  vDsOperacao := itemXml('DS_OPERACAO', pParams);
  vCdEmpOper := itemXmlF('CD_EMPOPER', pParams);
  vVlOperacao := itemXmlF('VL_OPERACAO', pParams);
  vCdSitApos := itemXmlF('CD_SITAPOS', pParams);
  vVlLimApos := itemXmlF('VL_LIMAPOS', pParams);
  vVlSalApos := itemXmlF('VL_SALAPOS', pParams);
  vCdAutorizador := itemXmlF('CD_AUTORIZADOR', pParams);
  vCdComponente := itemXmlF('CD_COMPONENTE', pParams);

  if (vCdEmpOper = '') then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Empresa de operação não informada!', cDS_METHOD);
    return(-1); exit;
  end;
  if (vCdCliente = '') then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Cliente não informado!', cDS_METHOD);
    return(-1); exit;
  end;
  if (vTpOperacao = '') then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Operação não informada!', cDS_METHOD);
    return(-1); exit;
  end;
  if (vCdComponente = '') then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Componente não informado!', cDS_METHOD);
    return(-1); exit;
  end;

  clear_e(tPES_CLIENTE);
  putitem_e(tPES_CLIENTE, 'CD_CLIENTE', vCdCliente);
  retrieve_e(tPES_CLIENTE);
  if (xStatus < 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Cliente ' + FloatToStr(vCdCliente) + ' não encontrado!', cDS_METHOD);
    return(-1); exit;
  end;

  while (vNrSequencia := '') do begin
    viParams := '';
    putitemXml(viParams, 'NM_ENTIDADE', 'PES_LIMITE');
    voParams := activateCmp('GERSVCO031', 'getNumSeq', viParams);
    if (xStatus < 0) then begin
      Result := voParams;
      return(-1); exit;
    end;

    vNrSequencia := itemXmlF('NR_SEQUENCIA', voParams);

    clear_e(tF_PES_LIMITE);
    putitem_e(tF_PES_LIMITE, 'NR_SEQUENCIAL', vNrSequencia);
    retrieve_e(tF_PES_LIMITE);
    if (xStatus >= 0) then begin
      vNrSequencia := '';
    end;
  end;
  if ((vVlLimAntes <> '')  or (vVlLimApos <> ''))  and (vVlOperacao = 0) then begin
    vVlOperacao := vVlLimApos - vVlLimAntes;
  end;
  if ((vVlSalAntes <> '')  or (vVlSalApos <> ''))  and (vVlOperacao = 0) then begin
    vVlOperacao := vVlSalApos - vVlSalAntes;
  end;

  creocc(tPES_LIMITE, -1);
  putitem_e(tPES_LIMITE, 'CD_PESSOA', vCdCliente);
  putitem_e(tPES_LIMITE, 'NR_SEQUENCIAL', vNrSequencia);
  putitem_e(tPES_LIMITE, 'CD_OPERADOR', itemXmlF('CD_USUARIO', piGlobal));
  putitem_e(tPES_LIMITE, 'DT_CADASTRO', Now);
  putitem_e(tPES_LIMITE, 'CD_EMPRESA', vCdEmpresa);
  putitem_e(tPES_LIMITE, 'CD_SITANTES', vCdSitAntes);
  putitem_e(tPES_LIMITE, 'VL_LIMANTES', vVlLimAntes);
  putitem_e(tPES_LIMITE, 'VL_SALANTES', vVlSalAntes);
  putitem_e(tPES_LIMITE, 'TP_OPERACAO', vTpOperacao);
  putitem_e(tPES_LIMITE, 'DS_OPERACAO', vDsOperacao);
  putitem_e(tPES_LIMITE, 'CD_EMPOPER', vCdEmpOper);
  putitem_e(tPES_LIMITE, 'VL_OPERACAO', vVlOperacao);
  putitem_e(tPES_LIMITE, 'CD_SITAPOS', vCdSitApos);
  putitem_e(tPES_LIMITE, 'VL_LIMAPOS', vVlLimApos);
  putitem_e(tPES_LIMITE, 'VL_SALAPOS', vVlSalApos);
  putitem_e(tPES_LIMITE, 'CD_AUTORIZADOR', vCdAutorizador);
  putitem_e(tPES_LIMITE, 'CD_COMPONENTE', vCdComponente);

  voParams := tPES_LIMITE.Salvar();
  if (xStatus < 0) then begin
    Result := voParams;
    return(-1); exit;
  end;

  return(0); exit;

end;

//-----------------------------------------------------------
function T_PESSVCO011.gravaPessoa(pParams : String) : String;
//-----------------------------------------------------------
const
  cDS_METHOD = 'ADICONAL=Operação: T_PESSVCO011.gravaPessoa()';
var
  (* string piGlobal :IN *)
  vCdPessoa, vTpFormaPgto, vPosInicio, vPosFim, vTamParam, vCdTipoClas, vPosVirgula : Real;
  vTpPessoa, vNmPessoa, vNrCpfCnpj, viParams, voParams, vDsLstValor, vCdClas : String;
begin
  PARAM_GLB := piGlobal;

  vTpPessoa := itemXmlF('TP_PESSOA', pParams);
  vNmPessoa := itemXml('NM_PESSOA', pParams);
  vNrCpfCnpj := itemXmlF('NR_CPFCNPJ', pParams);
  vTpFormaPgto := itemXmlF('TP_FORMAPGTO', pParams);

  if (vTpPessoa = '') then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Tipo pessoa não informada!', cDS_METHOD);
    return(-1); exit;
  end;
  if (vNmPessoa = '') then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Nome da pessoa não informada!', cDS_METHOD);
    return(-1); exit;
  end;
  if (vTpFormaPgto = '')  and (vTpPessoa = 'F') then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Parâmetro empresa PES_CLIENTE_FORMA_PGTO não cadastrado!', cDS_METHOD);
    return(-1); exit;
  end;
  if (vNrCpfCnpj = '') then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Número do CPF/CNPJ não informado!', cDS_METHOD);
    return(-1); exit;
  end;

  clear_e(tPES_S2_PESSOA);
  putitem_e(tPES_S2_PESSOA, 'NR_CPFCNPJ', vNrCpfCnpj);
  retrieve_e(tPES_S2_PESSOA);
  if (xStatus >= 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Número do CPF/CNPJ já cadastrado para a pessoa ' + CD_PESSOA.PES_S + '2_PESSOASVC!', cDS_METHOD);
    return(-1); exit;
  end;

  getParams(pParams); (* itemXmlF('CD_EMPRESA', piGlobal) *)
  if (xStatus < 0) then begin
    return(-1); exit;
  end;

  viParams := '';
  voParams := activateCmp('PESSVCO007', 'getSeqPessoa', viParams);
  if (xStatus < 0) then begin
    Result := voParams;
    return(-1); exit;
  end;
  vCdPessoa := itemXmlF('CD_PESSOA', voParams);
  creocc(tPES_PESSOA, -1);
  putitem_e(tPES_PESSOA, 'CD_PESSOA', vCdPessoa);
  putitem_e(tPES_PESSOA, 'TP_PESSOA', vTpPessoa);
  putitem_e(tPES_PESSOA, 'CD_EMPRESACAD', itemXmlF('CD_EMPRESA', piGlobal));
  putitem_e(tPES_PESSOA, 'CD_OPERADORCAD', itemXmlF('CD_USUARIO', piGlobal));
  putitem_e(tPES_PESSOA, 'CD_OPERADOR', itemXmlF('CD_USUARIO', piGlobal));
  putitem_e(tPES_PESSOA, 'DT_CADASTRO', Now);
  putitem_e(tPES_PESSOA, 'DT_INCLUSAO', Now);
  putitem_e(tPES_PESSOA, 'NM_PESSOA', vNmPessoa);
  putitem_e(tPES_PESSOA, 'NR_CPFCNPJ', vNrCpfCnpj);

  if (gCdClasClientePdv <> '') then begin
    vDsLstValor := gCdClasClientePdv;
    vPosInicio := 1;
    vPosFim := 1;
    length vDsLstValor;
    vTamParam := gresult;
    repeat

      scan vDsLstValor[vPosInicio, vTamParam], ';
      vPosVirgula := gresult;
      if (vPosVirgula > 0) then begin
        vCdTipoClas := vDsLstValor[vPosInicio, vPosVirgula - 1];
        vDsLstValor := vDsLstValor[vPosVirgula + 1, vTamParam];
        length vDsLstValor;
        vTamParam := gresult;

        scan vDsLstValor[vPosInicio, vTamParam], ';
        vPosVirgula := gresult;
        if (vPosVirgula > 0) then begin
          vCdClas := vDsLstValor[vPosInicio, vPosVirgula - 1];
          vDsLstValor := vDsLstValor[vPosVirgula + 1, vTamParam];
          length vDsLstValor;
          vTamParam := gresult;
        end else begin
          vCdClas := vDsLstValor;
          vDsLstValor := vDsLstValor[vPosVirgula + 1, vTamParam];
        end;

        clear_e(tPES_CLASSIFIC);
        putitem_e(tPES_CLASSIFIC, 'CD_TIPOCLAS', vCdTipoClas);
        putitem_e(tPES_CLASSIFIC, 'CD_CLASSIFICACAO', vCdClas);
        retrieve_e(tPES_CLASSIFIC);
        if (xStatus >= 0) then begin
          creocc(tPES_PESSOACLA, -1);
          putitem_e(tPES_PESSOACLA, 'CD_TIPOCLAS', vCdTipoClas);
          putitem_e(tPES_PESSOACLA, 'CD_CLASSIFICACAO', vCdClas);
          retrieve_o(tPES_PESSOACLA);
          if (xStatus = -7) then begin
            retrieve_x(tPES_PESSOACLA);
          end;
          putitem_e(tPES_PESSOACLA, 'CD_OPERADOR', itemXmlF('CD_USUARIO', piGlobal));
          putitem_e(tPES_PESSOACLA, 'DT_CADASTRO', Now);
        end;
      end else begin
        break;
      end;
    until (vDsLstValor = '');
  end;

  voParams := tPES_PESSOA.Salvar();
  if (xStatus < 0) then begin
    Result := voParams;
    return(-1); exit;
  end;

  clear_e(tPES_CLIENTE);

  creocc(tPES_CLIENTE, -1);
  putitem_e(tPES_CLIENTE, 'CD_CLIENTE', vCdPessoa);
  putitem_e(tPES_CLIENTE, 'TP_FORMAPGTO', vTpFormaPgto);
  putitem_e(tPES_CLIENTE, 'CD_OPERADOR', itemXmlF('CD_USUARIO', piGlobal));
  putitem_e(tPES_CLIENTE, 'DT_CADASTRO', itemXml('DT_CADASTRO', piGlobal));
  putitem_e(tPES_CLIENTE, 'IN_BLOQUEADO', False);
  putitem_e(tPES_CLIENTE, 'IN_INATIVO', False);

  voParams := tPES_CLIENTE.Salvar();
  if (xStatus < 0) then begin
    Result := voParams;
    return(-1); exit;
  end;
  if (vTpPessoa = 'J') then begin
    clear_e(tPES_PESJURIDI);

    creocc(tPES_PESJURIDI, -1);
    putitem_e(tPES_PESJURIDI, 'CD_PESSOA', vCdPessoa);
    putitem_e(tPES_PESJURIDI, 'CD_OPERADOR', itemXmlF('CD_USUARIO', piGlobal));
    putitem_e(tPES_PESJURIDI, 'DT_CADASTRO', itemXml('DT_CADASTRO', piGlobal));
    putitem_e(tPES_PESJURIDI, 'IN_INATIVO', False);
    putitem_e(tPES_PESJURIDI, 'NR_CNPJ', vNrCpfCnpj);

    voParams := tPES_PESJURIDI.Salvar();
    if (xStatus < 0) then begin
      Result := voParams;
      return(-1); exit;
    end;

  end else begin
    clear_e(tPES_PESFISICA);
    creocc(tPES_PESFISICA, -1);
    putitem_e(tPES_PESFISICA, 'CD_PESSOA', vCdPessoa);
    putitem_e(tPES_PESFISICA, 'CD_OPERADOR', itemXmlF('CD_USUARIO', piGlobal));
    putitem_e(tPES_PESFISICA, 'DT_CADASTRO', itemXml('DT_CADASTRO', piGlobal));
    putitem_e(tPES_PESFISICA, 'IN_INATIVO', False);
    putitem_e(tPES_PESFISICA, 'NR_CPF', vNrCpfCnpj);

    voParams := tPES_PESFISICA.Salvar();
    if (xStatus < 0) then begin
      Result := voParams;
      return(-1); exit;
    end;
  end;

  Result := '';
  putitemXml(Result, 'CD_PESSOA', vCdPessoa);

  return(0); exit;
end;

//-----------------------------------------------------------------------
function T_PESSVCO011.buscaPreferenciaCliente(pParams : String) : String;
//-----------------------------------------------------------------------
const
  cDS_METHOD = 'ADICONAL=Operação: T_PESSVCO011.buscaPreferenciaCliente()';
var
  vCdCliente : Real;
begin
  vCdCliente := itemXmlF('CD_CLIENTE', pParams);

  if (vCdCliente = '') then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Cliente não informado!', cDS_METHOD);
    return(-1); exit;
  end;

  Result := '';

  clear_e(tPES_PREFCLIEN);
  putitem_e(tPES_PREFCLIEN, 'CD_CLIENTE', vCdCliente);
  retrieve_e(tPES_PREFCLIEN);
  if (xStatus >= 0) then begin
    putlistitensocc_e(Result, tPES_PREFCLIEN);
  end;

  return(0); exit;
end;

end.
