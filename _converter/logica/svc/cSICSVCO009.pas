unit cSICSVCO009;

interface

(* COMPONENTES 
  FCCSVCO002 / GERSVCO001 / 
*)        

uses
  Classes, SysUtils, DB,
  cServiceUnf, cDataSetUnf;

type
  T_SICSVCO009 = class(TcServiceUnf)
  private
    tFCC_CTAPES,
    tFCR_LOGAT,
    tFCR_LOGATI,
    tGER_EMPRESA,
    tGER_S_EMPRESA : TcDatasetUnf;
    function getParam(pParams : String = '') : String;
    function setEntidade(pParams : String = '') : String;
  protected
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;    
  published
    function gravaLogAt(pParams : String = '') : String;
    function validaRecebimento(pParams : String = '') : String;
    function validaVlMaxTroco(pParams : String = '') : String;
    function validaCentroCusto(pParams : String = '') : String;
    function buscaSaldoAdiantCredev(pParams : String = '') : String;
  end;

implementation

uses
  cADMSVCO001,
  cActivate, cStatus, cFuncao, cXml, dModulo;

var


//---------------------------------------------------------------
constructor T_SICSVCO009.Create(AOwner: TComponent);
//---------------------------------------------------------------
begin
  inherited Create(AOwner);
  setEntidade('');
end;

//--------------------------------
destructor T_SICSVCO009.Destroy;
//--------------------------------
begin
  inherited Destroy;
end;

//---------------------------------------------------------------
function T_SICSVCO009.getParam(pParams : String = '') : String;
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
function T_SICSVCO009.setEntidade(pParams : String = '') : String;
//---------------------------------------------------------------
begin
  tFCC_CTAPES := GetEntidade('FCC_CTAPES');
  tFCR_LOGAT := GetEntidade('FCR_LOGAT');
  tFCR_LOGATI := GetEntidade('FCR_LOGATI');
  tGER_EMPRESA := GetEntidade('GER_EMPRESA');
  tGER_S_EMPRESA := GetEntidade('GER_S_EMPRESA');
end;

//----------------------------------------------------------
function T_SICSVCO009.gravaLogAt(pParams : String) : String;
//----------------------------------------------------------
const
  cDS_METHOD = 'ADICIONAL=Operação: T_SICSVCO009.gravaLogAt()';
var
  viParams, voParams, vDsPessoa, vDsLinha : String;
  vNrSeq, vNrSequencia : Real;
begin
  vNrSeq := 0;
  vNrSequencia := 0;

  voParams := activateCmp('GERSVCO001', 'GetNumSeq', viParams); (*,'FCR_LOGAT','FCR_LOGAT',9999999,vNrSequencia,, *)
  if (xStatus < 0) then begin
    Result := voParams;
    return(-1); exit;
  end;

  creocc(tFCR_LOGAT, -1);
  putitem_e(tFCR_LOGAT, 'DT_LOG', itemXml('DT_SISTEMA', PARAM_GLB));
  putitem_e(tFCR_LOGAT, 'NR_SEQLOGAT', vNrSequencia);
  putitem_e(tFCR_LOGAT, 'IN_CONFERIDO', 'N');
  putitem_e(tFCR_LOGAT, 'CD_OPERADOR', itemXmlF('CD_USUARIO', PARAM_GLB));
  putitem_e(tFCR_LOGAT, 'DT_CADASTRO', itemXml('DT_SISTEMA', PARAM_GLB));

  vDsPessoa := itemXml('DS_PESSOA', pParams);
  vNrSeq := 1;
  repeat
    vDsLinha := '';
    getitem(vDsLinha, vDsPessoa, 1);

    creocc(tFCR_LOGATI, -1);
    putitem_e(tFCR_LOGATI, 'DT_LOG', item_a('DT_LOG', tFCR_LOGAT));
    putitem_e(tFCR_LOGATI, 'NR_SEQLOGAT', item_f('NR_SEQLOGAT', tFCR_LOGAT));
    putitem_e(tFCR_LOGATI, 'NR_SEQLOGATI', vNrSeq);
    putitem_e(tFCR_LOGATI, 'NR_CLIENTE', itemXmlF('NR_GERAL', vDsLinha));
    putitem_e(tFCR_LOGATI, 'CD_OPERADOR', itemXmlF('CD_USUARIO', PARAM_GLB));
    putitem_e(tFCR_LOGATI, 'DT_CADASTRO', itemXml('DT_SISTEMA', PARAM_GLB));
    vNrSeq := vNrSeq + 1;

    delitem(vDsPessoa, 1);
  until (vDsPessoa = '');

  validateocc 'FCR_LOGATSVC';
  if (xStatus = 0) then begin
    voParams := tFCR_LOGAT.Salvar();
    if (xStatus < 0) then begin
      Result := voParams;
      return(-1); exit;
    end;
    end;
  end;
  Result := '';
  putitemXml(Result, 'DT_LOG', item_a('DT_LOG', tFCR_LOGAT));
  putitemXml(Result, 'NR_SEQLOGAT', item_f('NR_SEQLOGAT', tFCR_LOGAT));

  return(0); exit;
end;

//-----------------------------------------------------------------
function T_SICSVCO009.validaRecebimento(pParams : String) : String;
//-----------------------------------------------------------------
const
  cDS_METHOD = 'ADICIONAL=Operação: T_SICSVCO009.validaRecebimento()';
var
  vDsFaturas, vDsLinha, vConfereFaturas, vConfereJuros : String;
  vVlConfereFaturas, vVlConfereJuros, vVlTrocoMaximo : Real;
begin
  vConfereFaturas := '';
  vConfereJuros := '';
  vVlConfereFaturas := '';
  vVlConfereJuros := '';
  vDsFaturas := '';
  vVlTrocoMaximo := '';
  vDsFaturas := itemXml('DS_FATURAS', pParams);

  repeat

    vDsLinha := '';
    getitem(vDsLinha, vDsFaturas, 1);

    clear_e(tGER_EMPRESA);
    putitem_e(tGER_EMPRESA, 'CD_EMPRESA', itemXmlF('CD_EMPRESA', vDsLinha));
    retrieve_e(tGER_EMPRESA);
    if (xStatus < 0) then begin
      Result := SetStatus(STS_ERROR, 'GEN001', 'Empresa não encontrada no recebimento', '');
      return(-1); exit;
    end;
    if (item_f('CD_CCUSTO', tGER_EMPRESA) = '') then begin
      putitem(vConfereFaturas,  vDsLinha);
      vVlConfereFaturas := vVlConfereFaturas + itemXmlF('VL_ARECEBER', vDsLinha);
    end else begin
      putitem(vConfereJuros,  vDsLinha);
      vVlConfereJuros := vVlConfereJuros + itemXmlF('VL_ARECEBER', vDsLinha);
    end;
    vVlTrocoMaximo := vVlTrocoMaximo + itemXmlF('VL_ARECEBER', vDsLinha);

    delitem(vDsFaturas, 1);
  until(vDsFaturas = '');

  Result := '';
  putitemXml(Result, 'DS_CONFERIDOFATURAS', vConfereFaturas);
  putitemXml(Result, 'VL_CONFERIDOFATURAS', vVlConfereFaturas);
  putitemXml(Result, 'DS_CONFERIDOJUROS', vConfereJuros);
  putitemXml(Result, 'VL_CONFERIDOJUROS', vVlConfereJuros);
  putitemXml(Result, 'VL_TROCOMAXIMO', vVlTrocoMaximo);

  return(0); exit;
end;

//----------------------------------------------------------------
function T_SICSVCO009.validaVlMaxTroco(pParams : String) : String;
//----------------------------------------------------------------
const
  cDS_METHOD = 'ADICIONAL=Operação: T_SICSVCO009.validaVlMaxTroco()';
var
  vVlMaxTroco, vVlRecebido, vVlChequeVista, vVlDinheiro, vVlTroco, vVlDofni, vVlCredev : Real;
begin
  vVlMaxTroco := itemXmlF('VL_MAXTROCO', pParams);
  vVlRecebido := itemXmlF('VL_RECEBIDO', pParams);
  vVlChequeVista := itemXmlF('VL_CHEQUEVISTA', pParams);
  vVlDinheiro := itemXmlF('VL_DINHEIRO', pParams);
  vVlDofni := itemXmlF('VL_DOFNI', pParams);
  vVlCredev := itemXmlF('VL_CREDEV', pParams);

  if (vVlRecebido < vVlMaxTroco) then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Valor recebido menor que o valor a receber!', cDS_METHOD);
    return(-1); exit;
  end;

  vVlTroco := 0;
  if (vVlRecebido > vVlMaxTroco) then begin
    vVlTroco := vVlRecebido - vVlMaxTroco;
  end;
  if (vVlTroco > 0) then begin
    if (vVlDinheiro > 0) then begin
      if (vVlTroco > vVlDinheiro) then begin
        Result := SetStatus(STS_ERROR, 'GEN0001', 'Valor de troco maior que o valor em dinheiro!', cDS_METHOD);
        return(-1); exit;
      end;
    end else if (vVlChequeVista > 0) then begin
      if (vVlTroco > vVlChequeVista) then begin
        Result := SetStatus(STS_ERROR, 'GEN0001', 'Valor de troco maior que o valor em cheque à vista!', cDS_METHOD);
        return(-1); exit;
      end;
    end else if (vVlDofni > 0) then begin
      if (vVlTroco > vVlDofni) then begin
        Result := SetStatus(STS_ERROR, 'GEN0001', 'Valor de troco maior que o valor de dofni!', cDS_METHOD);
        return(-1); exit;
      end;
    end else if (vVlCredev > 0) then begin
      if (vVlTroco > vVlCredev) then begin
        Result := SetStatus(STS_ERROR, 'GEN0001', 'Valor de troco maior que o valor em CREDEV!', cDS_METHOD);
        return(-1); exit;
      end;
    end else begin
      Result := SetStatus(STS_ERROR, 'GEN0001', 'Valor de troco inválido! Não existe valor em dinheiro nem valor em cheque à vista!', cDS_METHOD);
      return(-1); exit;
    end;
  end;

  return(0); exit;
end;

//-----------------------------------------------------------------
function T_SICSVCO009.validaCentroCusto(pParams : String) : String;
//-----------------------------------------------------------------
const
  cDS_METHOD = 'ADICIONAL=Operação: T_SICSVCO009.validaCentroCusto()';
var
  vCdEmpresa, vCdCentroCusto : Real;
  vInPrincipal : Boolean;
begin
  vCdEmpresa := itemXmlF('CD_EMPRESA', pParams);
  vInPrincipal := False;

  if (vCdEmpresa = 0) then begin
    vCdEmpresa := itemXmlF('CD_EMPRESA', PARAM_GLB);
  end;
  if (vCdEmpresa = 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Empresa não informada!', cDS_METHOD);
    return(-1); exit;
  end;

  clear_e(tGER_EMPRESA);
  putitem_e(tGER_EMPRESA, 'CD_EMPRESA', vCdEmpresa);
  retrieve_e(tGER_EMPRESA);
  if (xStatus < 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN001', '', cDS_METHOD);
    return(-1); exit;
  end;
  if (item_f('CD_CCUSTO', tGER_EMPRESA) = '') then begin
    vCdEmpresa := item_f('CD_EMPRESA', tGER_EMPRESA);
    vInPrincipal := True;

    clear_e(tGER_S_EMPRESA);
    putitem_e(tGER_S_EMPRESA, 'CD_CCUSTO', item_f('CD_EMPRESA', tGER_EMPRESA));
    retrieve_e(tGER_S_EMPRESA);
    if (xStatus < 0) then begin
      vCdCentroCusto := '';
    end else begin
      setocc(tGER_S_EMPRESA, -1);
      setocc(tGER_S_EMPRESA, 1);
      if (totocc(tGER_S_EMPRESA) > 1) then begin
        Result := SetStatus(STS_ERROR, 'GEN001', 'Existe mais de uma empresa p/ este centro de custo ' + FloatToStr(vCdEmpresa) + '!', '');
        return(-1); exit;
      end else begin
        vCdCentroCusto := item_f('CD_EMPRESA', tGER_S_EMPRESA);
      end;
    end;
  end else begin

    vCdEmpresa := item_f('CD_CCUSTO', tGER_EMPRESA);
    vCdCentroCusto := item_f('CD_EMPRESA', tGER_EMPRESA);
  end;

  Result := '';
  putitemXml(Result, 'CD_EMPRESA', vCdEmpresa);
  putitemXml(Result, 'CD_CENTROCUSTO', vCdCentroCusto);
  putitemXml(Result, 'IN_MATRIZ', vInPrincipal);

  return(0); exit;
end;

//----------------------------------------------------------------------
function T_SICSVCO009.buscaSaldoAdiantCredev(pParams : String) : String;
//----------------------------------------------------------------------
const
  cDS_METHOD = 'ADICIONAL=Operação: T_SICSVCO009.buscaSaldoAdiantCredev()';
var
  viParams, voParams, vLstCdEmpresa, vLstTpDocumento, vpiValores : String;
  vCdEmpresa, vVlSaldoAdiantCredev, vTpDocumento, vCdCentroCusto : Real;
begin
  if (itemXml('CD_PESSOA', pParams) = '') then begin
    Result := SetStatus(STS_ERROR, 'GEN001', 'Informar o código da pessoa!', '');
    return(-1); exit;
  end;
  if (itemXml('CD_TPMANUT_CLIENTE', pParams) = '') then begin
    Result := SetStatus(STS_ERROR, 'GEN001', 'Informar o CD_TPMANUT_CLIENTE p/ consultar o saldo de adiantamento e Credev!', '');
    return(-1); exit;
  end;

  putitemXml(viParams, 'CD_EMPRESA', itemXmlF('CD_EMPRESA', PARAM_GLB));
  voParams := validaCentroCusto(viParams); (* PARAM_GLB, viParams, voParams, xCdErro, xCtxErro *)
  if (xStatus < 0) then begin
    Result := voParams;
    return(-1); exit;
  end;

  vLstCdEmpresa := '';
  vCdCentroCusto := '';
  vLstCdEmpresa := itemXmlF('CD_EMPRESA', voParams);
  if (itemXml('IN_MATRIZ', voParams) = False) then begin
    vCdCentroCusto := itemXmlF('CD_CENTROCUSTO', voParams);
  end;
  vLstCdEmpresa := '' + vLstCdEmpresa + ';

  repeat
    getitem(vCdEmpresa, vLstCdEmpresa, 1);

    if (vCdEmpresa > 0) then begin
      clear_e(tFCC_CTAPES);
      putitem_e(tFCC_CTAPES, 'CD_PESSOA', itemXmlF('CD_PESSOA', pParams));
      putitem_e(tFCC_CTAPES, 'CD_EMPRESA', vCdEmpresa);
      putitem_e(tFCC_CTAPES, 'TP_MANUTENCAO', itemXmlF('CD_TPMANUT_CLIENTE', pParams));
      retrieve_e(tFCC_CTAPES);
      if (xStatus >= 0) then begin
        vLstTpDocumento := '';
        vLstTpDocumento := '10;

        repeat
          vTpDocumento := '';
          getitem(vTpDocumento, vLstTpDocumento, 1);

          viParams := '';
          putitemXml(viParams, 'NR_CTAPES', item_f('NR_CTAPES', tFCC_CTAPES));
          putitemXml(viParams, 'TP_DOCUMENTO', vTpDocumento);
          putitemXml(viParams, 'NR_SEQHISTRELSUB', 1);
          putitemXml(viParams, 'DT_SALDO', itemXml('DT_SISTEMA', PARAM_GLB));
          voParams := activateCmp('FCCSVCO002', 'buscaSaldoCtaTp', viParams); (*,,vpiValores,,, *)
          if (xStatus < 0) then begin
            Result := voParams;
            return(-1); exit;
          end;

          vVlSaldoAdiantCredev := vVlSaldoAdiantCredev + itemXmlF('VL_SALDO', voParams);

          delitem(vLstTpDocumento, 1);
        until(vLstTpDocumento = '');
      end;
    end;

    delitem(vLstCdEmpresa, 1);
  until(vLstCdEmpresa = '');

  Result := '';
  putitemXml(Result, 'VL_SALDO', vVlSaldoAdiantCredev);

  return(0); exit;
end;

end.
