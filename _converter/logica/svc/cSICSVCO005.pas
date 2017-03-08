unit cSICSVCO005;

interface

(* COMPONENTES 
  ADMSVCO001 / GERSVCO031 / PRDSVCO007 / 
*)        

uses
  Classes, SysUtils, DB,
  cServiceUnf, cDataSetUnf;

type
  T_SICSVCO005 = class(TcServiceUnf)
  private
    tFIS_NF,
    tFIS_NFITEMIMP,
    tFIS_NFITEMPRO,
    tFIS_NFITEMVL,
    tFIS_S_NF,
    tGER_EMPRESA,
    tGER_OPERACAO,
    tTRA_S_TRANSAC,
    tTRA_TRANSACAO,
    tTRA_TRANSITEM : TcDatasetUnf;
    function getParam(pParams : String = '') : String;
    function setEntidade(pParams : String = '') : String;
  protected
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;    
  published
    function reservaNumeroNF(pParams : String = '') : String;
    function liberaNumeroNF(pParams : String = '') : String;
    function validaRecebimento(pParams : String = '') : String;
    function validaTransacao(pParams : String = '') : String;
    function buscaTransacaoOrigem(pParams : String = '') : String;
    function buscaMaxTroco(pParams : String = '') : String;
    function validaVlMaxTroco(pParams : String = '') : String;
    function validaTroca(pParams : String = '') : String;
    function buscaVlBrutoLiquido(pParams : String = '') : String;
    function arredondaQtFracionada(pParams : String = '') : String;
    function arredondaCusto(pParams : String = '') : String;
    function buscaSequencia(pParams : String = '') : String;
    function validaNumeroTransacao(pParams : String = '') : String;
    function validaTransacaoDefeito(pParams : String = '') : String;
  end;

implementation

uses
  cADMSVCO001,
  cActivate, cStatus, cFuncao, cXml, dModulo;

var
  gInAgregaIpi,
  gTpTrocoMaximo : String;

//---------------------------------------------------------------
constructor T_SICSVCO005.Create(AOwner: TComponent);
//---------------------------------------------------------------
begin
  inherited Create(AOwner);
  setEntidade('');
end;

//--------------------------------
destructor T_SICSVCO005.Destroy;
//--------------------------------
begin
  inherited Destroy;
end;

//---------------------------------------------------------------
function T_SICSVCO005.getParam(pParams : String = '') : String;
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
  putitem(xParamEmp, 'IN_AGREGA_IPI_CUSTO_PRD');
  putitem(xParamEmp, 'TP_TROCO_MAXIMO');

  xParamEmp := T_ADMSVCO001.GetParamEmpresa(piCdEmpresa, xParamEmp);

  gInAgregaIpi := itemXml('IN_AGREGA_IPI_CUSTO_PRD', xParamEmp);
  gTpTrocoMaximo := itemXml('TP_TROCO_MAXIMO', xParamEmp);

end;

//---------------------------------------------------------------
function T_SICSVCO005.setEntidade(pParams : String = '') : String;
//---------------------------------------------------------------
begin
  tFIS_NF := GetEntidade('FIS_NF');
  tFIS_NFITEMIMP := GetEntidade('FIS_NFITEMIMP');
  tFIS_NFITEMPRO := GetEntidade('FIS_NFITEMPRO');
  tFIS_NFITEMVL := GetEntidade('FIS_NFITEMVL');
  tFIS_S_NF := GetEntidade('FIS_S_NF');
  tGER_EMPRESA := GetEntidade('GER_EMPRESA');
  tGER_OPERACAO := GetEntidade('GER_OPERACAO');
  tTRA_S_TRANSAC := GetEntidade('TRA_S_TRANSAC');
  tTRA_TRANSACAO := GetEntidade('TRA_TRANSACAO');
  tTRA_TRANSITEM := GetEntidade('TRA_TRANSITEM');
end;

//---------------------------------------------------------------
function T_SICSVCO005.reservaNumeroNF(pParams : String) : String;
//---------------------------------------------------------------
const
  cDS_METHOD = 'ADICIONAL=Operação: T_SICSVCO005.reservaNumeroNF()';
var
  vDsLstNF, vDsRegistro : String;
  vCdEmpresa, vNrFatura : Real;
  vDtFatura : TDate;
begin
  vDsLstNF := itemXml('DS_LSTNF', pParams);

  if (vDsLstNF = '') then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Lista não informada!', cDS_METHOD);
    return(-1); exit;
  end;

  clear_e(tFIS_NF);
  clear_e(tFIS_S_NF);

  repeat
    getitem(vDsRegistro, vDsLstNF, 1);
    vCdEmpresa := itemXmlF('CD_EMPRESA', vDsRegistro);
    vNrFatura := itemXmlF('NR_FATURA', vDsRegistro);
    vDtFatura := itemXml('DT_FATURA', vDsRegistro);

    if (vCdEmpresa = 0) then begin
      Result := SetStatus(STS_ERROR, 'GEN0001', 'Empresa não informada!', cDS_METHOD);
      return(-1); exit;
    end;
    if (vNrFatura = 0) then begin
      Result := SetStatus(STS_ERROR, 'GEN0001', 'NF não informada!', cDS_METHOD);
      return(-1); exit;
    end;
    if (vDtFatura = '') then begin
      Result := SetStatus(STS_ERROR, 'GEN0001', 'Data NF não informada!', cDS_METHOD);
      return(-1); exit;
    end;

    creocc(tFIS_NF, -1);
    putitem_e(tFIS_NF, 'CD_EMPRESA', vCdEmpresa);
    putitem_e(tFIS_NF, 'NR_FATURA', vNrFatura);
    putitem_e(tFIS_NF, 'DT_FATURA', vDtFatura);
    retrieve_o(tFIS_NF);
    if (xStatus = -7) then begin
      retrieve_x(tFIS_NF);
    end else if (xStatus = 0) then begin
      Result := SetStatus(STS_ERROR, 'GEN0001', 'NF ' + FloatToStr(vNrFatura) + ' não reservada!', cDS_METHOD);
      return(-1); exit;
    end;

    clear_e(tGER_EMPRESA);
    putitem_e(tGER_EMPRESA, 'CD_CCUSTO', item_f('CD_EMPFAT', tFIS_NF));
    retrieve_e(tGER_EMPRESA);
    if (xStatus >= 0) then begin
      clear_e(tFIS_S_NF);
      putitem_e(tFIS_S_NF, 'CD_EMPRESA', item_f('CD_EMPRESA', tGER_EMPRESA));
      putitem_e(tFIS_S_NF, 'NR_FATURA', vNrFatura);
      putitem_e(tFIS_S_NF, 'DT_FATURA', vDtFatura);
      retrieve_e(tFIS_S_NF);
      if (xStatus >= 0) then begin
        creocc(tFIS_NF, -1);
        putitem_e(tFIS_NF, 'CD_EMPRESA', item_f('CD_EMPRESA', tFIS_S_NF));
        putitem_e(tFIS_NF, 'NR_FATURA', item_f('NR_FATURA', tFIS_S_NF));
        putitem_e(tFIS_NF, 'DT_FATURA', item_a('DT_FATURA', tFIS_S_NF));
        retrieve_o(tFIS_NF);
        if (xStatus = -7) then begin
          retrieve_x(tFIS_NF);
        end else if (xStatus = 0) then begin
          Result := SetStatus(STS_ERROR, 'GEN0001', 'NF ' + FloatToStr(vNrFatura) + ' não reservada!', cDS_METHOD);
          return(-1); exit;
        end;
      end;
    end;

    delitem(vDsLstNF, 1);
  until (vDsLstNF = '');

  Result := '';
  vDsLstNF := '';

  if (empty(tFIS_NF) = False) then begin
    setocc(tFIS_NF, 1);
    while (xStatus >= 0) do begin
      vDsRegistro := '';
      putitemXml(vDsRegistro, 'CD_EMPRESA', item_f('CD_EMPRESA', tFIS_NF));
      putitemXml(vDsRegistro, 'NR_FATURA', item_f('NR_FATURA', tFIS_NF));
      putitemXml(vDsRegistro, 'DT_FATURA', item_a('DT_FATURA', tFIS_NF));
      putitem(vDsLstNF,  vDsRegistro);
      setocc(tFIS_NF, curocc(tFIS_NF) + 1);
    end;
  end;

  putitemXml(Result, 'DS_LSTNF', vDsLstNF);

  return(0); exit;
end;

//--------------------------------------------------------------
function T_SICSVCO005.liberaNumeroNF(pParams : String) : String;
//--------------------------------------------------------------
const
  cDS_METHOD = 'ADICIONAL=Operação: T_SICSVCO005.liberaNumeroNF()';
var
  vDsLstNF, vDsRegistro : String;
  vCdEmpresa, vNrFatura : Real;
  vDtFatura : TDate;
begin
  vDsLstNF := itemXml('DS_LSTNF', pParams);

  if (vDsLstNF = '') then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Lista não informada!', cDS_METHOD);
    return(-1); exit;
  end;

  clear_e(tFIS_NF);

  repeat
    getitem(vDsRegistro, vDsLstNF, 1);
    vCdEmpresa := itemXmlF('CD_EMPRESA', vDsRegistro);
    vNrFatura := itemXmlF('NR_FATURA', vDsRegistro);
    vDtFatura := itemXml('DT_FATURA', vDsRegistro);

    if (vCdEmpresa = 0) then begin
      Result := SetStatus(STS_ERROR, 'GEN0001', 'Empresa não informada!', cDS_METHOD);
      return(-1); exit;
    end;
    if (vNrFatura = 0) then begin
      Result := SetStatus(STS_ERROR, 'GEN0001', 'NF não informada!', cDS_METHOD);
      return(-1); exit;
    end;
    if (vDtFatura = '') then begin
      Result := SetStatus(STS_ERROR, 'GEN0001', 'Data NF não informada!', cDS_METHOD);
      return(-1); exit;
    end;

    creocc(tFIS_NF, -1);
    putitem_e(tFIS_NF, 'CD_EMPRESA', vCdEmpresa);
    putitem_e(tFIS_NF, 'NR_FATURA', vNrFatura);
    putitem_e(tFIS_NF, 'DT_FATURA', vDtFatura);
    retrieve_o(tFIS_NF);
    if (xStatus = -7) then begin
      retrieve_x(tFIS_NF);
    end else if (xStatus = 0) then begin
      Result := SetStatus(STS_ERROR, 'GEN0001', 'NF ' + FloatToStr(vNrFatura) + ' não reservada!', cDS_METHOD);
      return(-1); exit;
    end;

    clear_e(tGER_EMPRESA);
    putitem_e(tGER_EMPRESA, 'CD_EMPRESA', item_f('CD_EMPFAT', tFIS_NF));
    retrieve_e(tGER_EMPRESA);
    if (xStatus >= 0) then begin
      if (item_f('CD_CCUSTO', tGER_EMPRESA) > 0) then begin
        discard(tFIS_NF);
      end;
    end;

    delitem(vDsLstNF, 1);
  until (vDsLstNF = '');

  Result := '';
  vDsLstNF := '';

  if (empty(tFIS_NF) = False) then begin
    setocc(tFIS_NF, 1);
    while (xStatus >= 0) do begin
      vDsRegistro := '';
      putitemXml(vDsRegistro, 'CD_EMPRESA', item_f('CD_EMPRESA', tFIS_NF));
      putitemXml(vDsRegistro, 'NR_FATURA', item_f('NR_FATURA', tFIS_NF));
      putitemXml(vDsRegistro, 'DT_FATURA', item_a('DT_FATURA', tFIS_NF));
      putitem(vDsLstNF,  vDsRegistro);
      setocc(tFIS_NF, curocc(tFIS_NF) + 1);
    end;
  end;

  putitemXml(Result, 'DS_LSTNF', vDsLstNF);

  return(0); exit;
end;

//-----------------------------------------------------------------
function T_SICSVCO005.validaRecebimento(pParams : String) : String;
//-----------------------------------------------------------------
const
  cDS_METHOD = 'ADICIONAL=Operação: T_SICSVCO005.validaRecebimento()';
var
  vDsRegistro, vDsLstTransacao, vDsLstEncargoFin, vDsLstTransacaoRec : String;
  vCdEmpresa, vNrTransacao, vCdEmpresaLogin, vCdEmpresaTra : Real;
  vDtTransacao : TDate;
  vInDinheiro, vInEncargoFin : Boolean;
begin
  vDsLstTransacao := itemXml('DS_LSTTRANSACAO', pParams);

  if (vDsLstTransacao = '') then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Lista de transação não informada!', cDS_METHOD);
    return(-1); exit;
  end;

  vCdEmpresaLogin := itemXmlF('CD_EMPRESA', PARAM_GLB);

  getParams(pParams); (* vCdEmpresaLogin, 'validaRecebimento' *)
  if (xStatus < 0) then begin
    return(-1); exit;
  end;

  clear_e(tTRA_TRANSACAO);

  repeat
    getitem(vDsRegistro, vDsLstTransacao, 1);
    vCdEmpresa := itemXmlF('CD_EMPRESA', vDsRegistro);
    vNrTransacao := itemXmlF('NR_TRANSACAO', vDsRegistro);
    vDtTransacao := itemXml('DT_TRANSACAO', vDsRegistro);

    if (vCdEmpresa = 0) then begin
      Result := SetStatus(STS_ERROR, 'GEN0001', 'Empresa não informada!', cDS_METHOD);
      return(-1); exit;
    end;
    if (vNrTransacao = 0) then begin
      Result := SetStatus(STS_ERROR, 'GEN0001', 'Número da transação não informado!', cDS_METHOD);
      return(-1); exit;
    end;
    if (vDtTransacao = '') then begin
      Result := SetStatus(STS_ERROR, 'GEN0001', 'Data transação não informada!', cDS_METHOD);
      return(-1); exit;
    end;

    creocc(tTRA_TRANSACAO, -1);
    putitem_e(tTRA_TRANSACAO, 'CD_EMPRESA', vCdEmpresa);
    putitem_e(tTRA_TRANSACAO, 'NR_TRANSACAO', vNrTransacao);
    putitem_e(tTRA_TRANSACAO, 'DT_TRANSACAO', vDtTransacao);
    retrieve_o(tTRA_TRANSACAO);
    if (xStatus = -7) then begin
      retrieve_x(tTRA_TRANSACAO);
    end else if (xStatus = 0) then begin
      Result := SetStatus(STS_ERROR, 'GEN0001', 'Transação ' + FloatToStr(vNrTransacao) + ' não cadastrada!', cDS_METHOD);
      return(-1); exit;
    end;

    putitem_e(tTRA_TRANSACAO, 'IN_ENCARGOFIN', False);
    vInEncargoFin := False;
    vCdEmpresaTra := 0;

    clear_e(tGER_EMPRESA);
    putitem_e(tGER_EMPRESA, 'CD_EMPRESA', item_f('CD_EMPFAT', tTRA_TRANSACAO));
    retrieve_e(tGER_EMPRESA);
    if (xStatus < 0) then begin
      Result := SetStatus(STS_ERROR, 'GEN0001', 'Empresa ' + FloatToStr(vCdEmpresa) + ' não cadastrada!', cDS_METHOD);
      return(-1); exit;
    end else begin
      if (item_f('CD_CCUSTO', tGER_EMPRESA) > 0) then begin
        vCdEmpresaTra := item_f('CD_CCUSTO', tGER_EMPRESA);
        vInEncargoFin := True;
      end else begin
        clear_e(tGER_EMPRESA);
        putitem_e(tGER_EMPRESA, 'CD_CCUSTO', item_f('CD_EMPFAT', tTRA_TRANSACAO));
        retrieve_e(tGER_EMPRESA);
        if (xStatus >= 0) then begin
          vCdEmpresaTra := item_f('CD_EMPRESA', tGER_EMPRESA);
        end;
      end;
    end;

    putitem_e(tTRA_TRANSACAO, 'IN_ENCARGOFIN', vInEncargoFin);

    if (vCdEmpresaTra > 0) then begin
      clear_e(tTRA_S_TRANSAC);
      putitem_e(tTRA_S_TRANSAC, 'CD_EMPFAT', vCdEmpresaTra);
      putitem_e(tTRA_S_TRANSAC, 'NR_TRANSACAO', vNrTransacao);
      putitem_e(tTRA_S_TRANSAC, 'DT_TRANSACAO', vDtTransacao);
      retrieve_e(tTRA_S_TRANSAC);
      if (xStatus >= 0) then begin
        creocc(tTRA_TRANSACAO, -1);
        putitem_e(tTRA_TRANSACAO, 'CD_EMPRESA', item_f('CD_EMPRESA', tTRA_S_TRANSAC));
        putitem_e(tTRA_TRANSACAO, 'NR_TRANSACAO', item_f('NR_TRANSACAO', tTRA_S_TRANSAC));
        putitem_e(tTRA_TRANSACAO, 'DT_TRANSACAO', item_a('DT_TRANSACAO', tTRA_S_TRANSAC));
        retrieve_o(tTRA_TRANSACAO);
        if (xStatus = -7) then begin
          retrieve_x(tTRA_TRANSACAO);
        end else if (xStatus = 0) then begin
          Result := SetStatus(STS_ERROR, 'GEN0001', 'Transaçao ' + FloatToStr(vNrTransacao) + ' não validada!', cDS_METHOD);
          return(-1); exit;
        end;
        putitem_e(tTRA_TRANSACAO, 'IN_ENCARGOFIN', !vInEncargoFin);
      end;
    end;

    delitem(vDsLstTransacao, 1);
  until (vDsLstTransacao = '');

  Result := '';
  vDsLstTransacao := '';
  vDsLstEncargoFin := '';
  vDsLstTransacaoRec := '';

  if (empty(tTRA_TRANSACAO) = False) then begin
    setocc(tTRA_TRANSACAO, 1);
    while (xStatus >= 0) do begin
      if (item_f('TP_SITUACAO', tTRA_TRANSACAO) = 5) then begin
        vDsRegistro := '';
        putitemXml(vDsRegistro, 'CD_EMPRESA', item_f('CD_EMPRESA', tTRA_TRANSACAO));
        putitemXml(vDsRegistro, 'NR_TRANSACAO', item_f('NR_TRANSACAO', tTRA_TRANSACAO));
        putitemXml(vDsRegistro, 'DT_TRANSACAO', item_a('DT_TRANSACAO', tTRA_TRANSACAO));
        if (!item_b('IN_ENCARGOFIN', tTRA_TRANSACAO)) then begin
          putitem(vDsLstTransacao,  vDsRegistro);
        end else begin
          putitem(vDsLstEncargoFin,  vDsRegistro);
        end;
        putitem(vDsLstTransacaoRec,  vDsRegistro);
      end;
      setocc(tTRA_TRANSACAO, curocc(tTRA_TRANSACAO) + 1);
    end;
  end;

  putitemXml(Result, 'DS_LSTTRANSACAO', vDsLstTransacao);
  putitemXml(Result, 'DS_LSTENCARGOFIN', vDsLstEncargoFin);
  putitemXml(Result, 'DS_LSTTRANSACAOREC', vDsLstTransacaoRec);

  return(0); exit;
end;

//---------------------------------------------------------------
function T_SICSVCO005.validaTransacao(pParams : String) : String;
//---------------------------------------------------------------
const
  cDS_METHOD = 'ADICIONAL=Operação: T_SICSVCO005.validaTransacao()';
var
  vDsRegistro, vDsLstTransacao : String;
  vCdEmpresa, vNrTransacao, vCdEmpresaLogin, vCdEmpresaTra : Real;
  vDtTransacao : TDate;
  vInDinheiro, vInEncargoFin, vInCCusto : Boolean;
begin
  vDsLstTransacao := itemXml('DS_LSTTRANSACAO', pParams);

  if (vDsLstTransacao = '') then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Lista de transação não informada!', cDS_METHOD);
    return(-1); exit;
  end;

  vCdEmpresaLogin := itemXmlF('CD_EMPRESA', PARAM_GLB);

  getParams(pParams); (* vCdEmpresaLogin, 'validaTransacao' *)
  if (xStatus < 0) then begin
    return(-1); exit;
  end;

  vInCCusto := False;
  clear_e(tGER_EMPRESA);
  putitem_e(tGER_EMPRESA, 'CD_EMPRESA', vCdEmpresaLogin);
  retrieve_e(tGER_EMPRESA);
  if (xStatus < 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Empresa ' + FloatToStr(vCdEmpresaLogin) + ' não cadastrada!', cDS_METHOD);
    return(-1); exit;
  end else begin
    if (item_f('CD_CCUSTO', tGER_EMPRESA) > 0) then begin
      vInCCusto := True;
    end;
  end;

  clear_e(tTRA_TRANSACAO);

  repeat
    getitem(vDsRegistro, vDsLstTransacao, 1);
    vCdEmpresa := itemXmlF('CD_EMPRESA', vDsRegistro);
    vNrTransacao := itemXmlF('NR_TRANSACAO', vDsRegistro);
    vDtTransacao := itemXml('DT_TRANSACAO', vDsRegistro);

    if (vCdEmpresa = 0) then begin
      Result := SetStatus(STS_ERROR, 'GEN0001', 'Empresa não informada!', cDS_METHOD);
      return(-1); exit;
    end;
    if (vNrTransacao = 0) then begin
      Result := SetStatus(STS_ERROR, 'GEN0001', 'Número da transação não informado!', cDS_METHOD);
      return(-1); exit;
    end;
    if (vDtTransacao = '') then begin
      Result := SetStatus(STS_ERROR, 'GEN0001', 'Data transação não informada!', cDS_METHOD);
      return(-1); exit;
    end;

    creocc(tTRA_TRANSACAO, -1);
    putitem_e(tTRA_TRANSACAO, 'CD_EMPRESA', vCdEmpresa);
    putitem_e(tTRA_TRANSACAO, 'NR_TRANSACAO', vNrTransacao);
    putitem_e(tTRA_TRANSACAO, 'DT_TRANSACAO', vDtTransacao);
    retrieve_o(tTRA_TRANSACAO);
    if (xStatus = -7) then begin
      retrieve_x(tTRA_TRANSACAO);
    end else if (xStatus = 0) then begin
      Result := SetStatus(STS_ERROR, 'GEN0001', 'Transação ' + FloatToStr(vNrTransacao) + ' não cadastrada!', cDS_METHOD);
      return(-1); exit;
    end;

    putitem_e(tTRA_TRANSACAO, 'IN_ENCARGOFIN', False);
    vInEncargoFin := False;
    vCdEmpresaTra := 0;

    clear_e(tGER_EMPRESA);
    putitem_e(tGER_EMPRESA, 'CD_EMPRESA', item_f('CD_EMPFAT', tTRA_TRANSACAO));
    retrieve_e(tGER_EMPRESA);
    if (xStatus < 0) then begin
      Result := SetStatus(STS_ERROR, 'GEN0001', 'Empresa ' + CD_EMPFAT + '.TRA_TRANSACAO não cadastrada!', cDS_METHOD);
      return(-1); exit;
    end else begin
      if (item_f('CD_CCUSTO', tGER_EMPRESA) > 0) then begin
        vCdEmpresaTra := item_f('CD_CCUSTO', tGER_EMPRESA);
        vInEncargoFin := True;
      end else begin
        clear_e(tGER_EMPRESA);
        putitem_e(tGER_EMPRESA, 'CD_CCUSTO', item_f('CD_EMPFAT', tTRA_TRANSACAO));
        retrieve_e(tGER_EMPRESA);
        if (xStatus >= 0) then begin
          vCdEmpresaTra := item_f('CD_EMPRESA', tGER_EMPRESA);
        end;
      end;
    end;

    putitem_e(tTRA_TRANSACAO, 'IN_ENCARGOFIN', vInEncargoFin);

    if (vCdEmpresaTra > 0) then begin
      clear_e(tTRA_S_TRANSAC);
      putitem_e(tTRA_S_TRANSAC, 'CD_EMPFAT', vCdEmpresaTra);
      putitem_e(tTRA_S_TRANSAC, 'NR_TRANSACAO', vNrTransacao);
      putitem_e(tTRA_S_TRANSAC, 'DT_TRANSACAO', vDtTransacao);
      retrieve_e(tTRA_S_TRANSAC);
      if (xStatus >= 0) then begin
        creocc(tTRA_TRANSACAO, -1);
        putitem_e(tTRA_TRANSACAO, 'CD_EMPRESA', item_f('CD_EMPRESA', tTRA_S_TRANSAC));
        putitem_e(tTRA_TRANSACAO, 'NR_TRANSACAO', item_f('NR_TRANSACAO', tTRA_S_TRANSAC));
        putitem_e(tTRA_TRANSACAO, 'DT_TRANSACAO', item_a('DT_TRANSACAO', tTRA_S_TRANSAC));
        retrieve_o(tTRA_TRANSACAO);
        if (xStatus = -7) then begin
          retrieve_x(tTRA_TRANSACAO);
        end else if (xStatus = 0) then begin
          Result := SetStatus(STS_ERROR, 'GEN0001', 'Transaçao ' + FloatToStr(vNrTransacao) + ' não validada!', cDS_METHOD);
          return(-1); exit;
        end;
        putitem_e(tTRA_TRANSACAO, 'IN_ENCARGOFIN', !vInEncargoFin);
      end;
    end;

    delitem(vDsLstTransacao, 1);
  until (vDsLstTransacao = '');

  Result := '';
  vDsLstTransacao := '';

  if (empty(tTRA_TRANSACAO) = False) then begin
    setocc(tTRA_TRANSACAO, 1);
    while (xStatus >= 0) do begin
      if (item_b('IN_ENCARGOFIN', tTRA_TRANSACAO) = True) then begin
        if (vInCCusto = True) then begin
          vDsRegistro := '';
          putitemXml(vDsRegistro, 'CD_EMPRESA', item_f('CD_EMPRESA', tTRA_TRANSACAO));
          putitemXml(vDsRegistro, 'NR_TRANSACAO', item_f('NR_TRANSACAO', tTRA_TRANSACAO));
          putitemXml(vDsRegistro, 'DT_TRANSACAO', item_a('DT_TRANSACAO', tTRA_TRANSACAO));
          putitem(vDsLstTransacao,  vDsRegistro);
        end;
      end else begin
        vDsRegistro := '';
        putitemXml(vDsRegistro, 'CD_EMPRESA', item_f('CD_EMPRESA', tTRA_TRANSACAO));
        putitemXml(vDsRegistro, 'NR_TRANSACAO', item_f('NR_TRANSACAO', tTRA_TRANSACAO));
        putitemXml(vDsRegistro, 'DT_TRANSACAO', item_a('DT_TRANSACAO', tTRA_TRANSACAO));
        putitem(vDsLstTransacao,  vDsRegistro);
      end;
      setocc(tTRA_TRANSACAO, curocc(tTRA_TRANSACAO) + 1);
    end;
  end;

  putitemXml(Result, 'DS_LSTTRANSACAO', vDsLstTransacao);

  return(0); exit;
end;

//--------------------------------------------------------------------
function T_SICSVCO005.buscaTransacaoOrigem(pParams : String) : String;
//--------------------------------------------------------------------
const
  cDS_METHOD = 'ADICIONAL=Operação: T_SICSVCO005.buscaTransacaoOrigem()';
var
  vCdEmpresa, vNrTransacao, vCdEmpresaTra : Real;
  vDtTransacao : TDate;
  vInDinheiro, vInEncargoFin, vInCCusto : Boolean;
begin
  vCdEmpresa := itemXmlF('CD_EMPRESA', pParams);
  vNrTransacao := itemXmlF('NR_TRANSACAO', pParams);
  vDtTransacao := itemXml('DT_TRANSACAO', pParams);

  if (vCdEmpresa = 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Empresa origem não informada!', cDS_METHOD);
    return(-1); exit;
  end;
  if (vNrTransacao = 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Número transação origem não informado', cDS_METHOD);
    return(-1); exit;
  end;
  if (vDtTransacao = '') then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Data transação origem não informada', cDS_METHOD);
    return(-1); exit;
  end;

  clear_e(tTRA_TRANSACAO);
  putitem_e(tTRA_TRANSACAO, 'CD_EMPRESA', vCdEmpresa);
  putitem_e(tTRA_TRANSACAO, 'NR_TRANSACAO', vNrTransacao);
  putitem_e(tTRA_TRANSACAO, 'DT_TRANSACAO', vDtTransacao);
  retrieve_e(tTRA_TRANSACAO);
  if (xStatus < 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Transação ' + FloatToStr(vNrTransacao) + ' não cadastrada!', cDS_METHOD);
    return(-1); exit;
  end;

  vCdEmpresaTra := '';

  clear_e(tGER_EMPRESA);
  putitem_e(tGER_EMPRESA, 'CD_EMPRESA', item_f('CD_EMPFAT', tTRA_TRANSACAO));
  retrieve_e(tGER_EMPRESA);
  if (xStatus < 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Empresa ' + CD_EMPFAT + '.TRA_TRANSACAO não cadastrada!', cDS_METHOD);
    return(-1); exit;
  end else begin
    if (item_f('CD_CCUSTO', tGER_EMPRESA) > 0) then begin
      vCdEmpresaTra := item_f('CD_CCUSTO', tGER_EMPRESA);
    end else begin
      clear_e(tGER_EMPRESA);
      putitem_e(tGER_EMPRESA, 'CD_CCUSTO', item_f('CD_EMPFAT', tTRA_TRANSACAO));
      retrieve_e(tGER_EMPRESA);
      if (xStatus >= 0) then begin
        vCdEmpresaTra := item_f('CD_EMPRESA', tGER_EMPRESA);
      end;
    end;
  end;

  Result := '';

  if (vCdEmpresaTra > 0) then begin
    clear_e(tTRA_TRANSACAO);
    putitem_e(tTRA_TRANSACAO, 'CD_EMPFAT', vCdEmpresaTra);
    putitem_e(tTRA_TRANSACAO, 'NR_TRANSACAO', vNrTransacao);
    putitem_e(tTRA_TRANSACAO, 'DT_TRANSACAO', vDtTransacao);
    retrieve_e(tTRA_TRANSACAO);
    if (xStatus >= 0) then begin
      putitemXml(Result, 'CD_EMPRESA', item_f('CD_EMPRESA', tTRA_TRANSACAO));
      putitemXml(Result, 'NR_TRANSACAO', item_f('NR_TRANSACAO', tTRA_TRANSACAO));
      putitemXml(Result, 'DT_TRANSACAO', item_a('DT_TRANSACAO', tTRA_TRANSACAO));
    end;
  end;

  return(0); exit;
end;

//-------------------------------------------------------------
function T_SICSVCO005.buscaMaxTroco(pParams : String) : String;
//-------------------------------------------------------------
const
  cDS_METHOD = 'ADICIONAL=Operação: T_SICSVCO005.buscaMaxTroco()';
var
  vDsRegistro, vDsLstTransacao, vDsLstEncargoFin, vDsLstTra : String;
  vCdEmpresa, vNrTransacao, vVlMaxTroco, vCdEmpresaLogin : Real;
  vDtTransacao : TDate;
begin
  vDsLstTransacao := itemXml('DS_LSTTRANSACAO', pParams);
  vDsLstEncargoFin := itemXml('DS_LSTENCARGOFIN', pParams);
  vCdEmpresaLogin := itemXmlF('CD_EMPRESA', PARAM_GLB);

  if (vDsLstTransacao = '')  and (vDsLstEncargoFin = '') then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Lista de transação não informada!', cDS_METHOD);
    return(-1); exit;
  end;

  getParams(pParams); (* vCdEmpresaLogin, 'buscaMaxTroco' *)
  if (xStatus < 0) then begin
    return(-1); exit;
  end;

  vVlMaxTroco := 0;

  if (gTpTrocoMaximo > 0) then begin
    if (vDsLstTransacao <> '')  and (vDsLstEncargoFin <> '') then begin
      vDsLstTra := vDsLstTransacao;
      repeat
        getitem(vDsRegistro, vDsLstTra, 1);
        vCdEmpresa := itemXmlF('CD_EMPRESA', vDsRegistro);
        vNrTransacao := itemXmlF('NR_TRANSACAO', vDsRegistro);
        vDtTransacao := itemXml('DT_TRANSACAO', vDsRegistro);
        if (vCdEmpresa = 0) then begin
          Result := SetStatus(STS_ERROR, 'GEN0001', 'Empresa não informada!', cDS_METHOD);
          return(-1); exit;
        end;
        if (vNrTransacao = 0) then begin
          Result := SetStatus(STS_ERROR, 'GEN0001', 'Número da transação não informado!', cDS_METHOD);
          return(-1); exit;
        end;
        if (vDtTransacao = '') then begin
          Result := SetStatus(STS_ERROR, 'GEN0001', 'Data transação não informada!', cDS_METHOD);
          return(-1); exit;
        end;
        clear_e(tTRA_TRANSACAO);
        putitem_e(tTRA_TRANSACAO, 'CD_EMPRESA', vCdEmpresa);
        putitem_e(tTRA_TRANSACAO, 'NR_TRANSACAO', vNrTransacao);
        putitem_e(tTRA_TRANSACAO, 'DT_TRANSACAO', vDtTransacao);
        retrieve_e(tTRA_TRANSACAO);
        if (xStatus < 0) then begin
          Result := SetStatus(STS_ERROR, 'GEN0001', 'Transação ' + FloatToStr(vNrTransacao) + ' não cadastrada!', cDS_METHOD);
          return(-1); exit;
        end;
        vVlMaxTroco := vVlMaxTroco + item_f('VL_TOTAL', tTRA_TRANSACAO);
        delitem(vDsLstTra, 1);
      until (vDsLstTra = '');

      vDsLstTra := vDsLstEncargoFin;
      repeat
        getitem(vDsRegistro, vDsLstTra, 1);
        vCdEmpresa := itemXmlF('CD_EMPRESA', vDsRegistro);
        vNrTransacao := itemXmlF('NR_TRANSACAO', vDsRegistro);
        vDtTransacao := itemXml('DT_TRANSACAO', vDsRegistro);
        if (vCdEmpresa = 0) then begin
          Result := SetStatus(STS_ERROR, 'GEN0001', 'Empresa não informada!', cDS_METHOD);
          return(-1); exit;
        end;
        if (vNrTransacao = 0) then begin
          Result := SetStatus(STS_ERROR, 'GEN0001', 'Número da transação não informado!', cDS_METHOD);
          return(-1); exit;
        end;
        if (vDtTransacao = '') then begin
          Result := SetStatus(STS_ERROR, 'GEN0001', 'Data transação não informada!', cDS_METHOD);
          return(-1); exit;
        end;
        clear_e(tTRA_TRANSACAO);
        putitem_e(tTRA_TRANSACAO, 'CD_EMPRESA', vCdEmpresa);
        putitem_e(tTRA_TRANSACAO, 'NR_TRANSACAO', vNrTransacao);
        putitem_e(tTRA_TRANSACAO, 'DT_TRANSACAO', vDtTransacao);
        retrieve_e(tTRA_TRANSACAO);
        if (xStatus < 0) then begin
          Result := SetStatus(STS_ERROR, 'GEN0001', 'Transação ' + FloatToStr(vNrTransacao) + ' não cadastrada!', cDS_METHOD);
          return(-1); exit;
        end;
        vVlMaxTroco := vVlMaxTroco + item_f('VL_TOTAL', tTRA_TRANSACAO);
        delitem(vDsLstTra, 1);
      until (vDsLstTra = '');
    end else begin
      gTpTrocoMaximo := 0;
    end;
  end;

  Result := '';
  putitemXml(Result, 'TP_TROCOMAXIMO', gTpTrocoMaximo);
  putitemXml(Result, 'VL_TROCOMAXIMOTRA', 0);
  putitemXml(Result, 'VL_TROCOMAXIMOENC', vVlMaxTroco);

  return(0); exit;
end;

//----------------------------------------------------------------
function T_SICSVCO005.validaVlMaxTroco(pParams : String) : String;
//----------------------------------------------------------------
const
  cDS_METHOD = 'ADICIONAL=Operação: T_SICSVCO005.validaVlMaxTroco()';
var
  vVlMaxTroco, vVlReceber, vVlRecebido, vVlChequeVista, vVlDinheiro, vVlTroco : Real;
begin
  vVlMaxTroco := itemXmlF('VL_MAXTROCO', pParams);
  vVlReceber := itemXmlF('VL_RECEBER', pParams);
  vVlRecebido := itemXmlF('VL_RECEBIDO', pParams);
  vVlChequeVista := itemXmlF('VL_CHEQUEVISTA', pParams);
  vVlDinheiro := itemXmlF('VL_DINHEIRO', pParams);

  if (vVlMaxTroco = 0) then begin
    if (vVlRecebido <> vVlReceber) then begin
      Result := SetStatus(STS_ERROR, 'GEN0001', 'Valor recebido diferente do valor a receber!', cDS_METHOD);
      return(-1); exit;
    end;
    if (vVlDinheiro <> vVlRecebido) then begin
      Result := SetStatus(STS_ERROR, 'GEN0001', 'Valor recebido deve ser somente em dinheiro!', cDS_METHOD);
      return(-1); exit;
    end;
    return(0); exit;
  end;
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
    end else begin
      Result := SetStatus(STS_ERROR, 'GEN0001', 'Valor de troco inválido! Não existe valor em dinheiro nem valor em cheque à vista!', cDS_METHOD);
      return(-1); exit;
    end;
  end;

  return(0); exit;
end;

//-----------------------------------------------------------
function T_SICSVCO005.validaTroca(pParams : String) : String;
//-----------------------------------------------------------
const
  cDS_METHOD = 'ADICIONAL=Operação: T_SICSVCO005.validaTroca()';
var
  vCdEmpresa, vNrTransacao, vNrDias : Real;
  vDtTransacao, vDtPrevEntrega : TDate;
begin
  vCdEmpresa := itemXmlF('CD_EMPRESA', pParams);
  vNrTransacao := itemXmlF('NR_TRANSACAO', pParams);
  vDtTransacao := itemXml('DT_TRANSACAO', pParams);
  vDtPrevEntrega := itemXml('DT_PREVENTREGA', pParams);

  if (vCdEmpresa = 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Empresa não informada!', cDS_METHOD);
    return(-1); exit;
  end;
  if (vNrTransacao = 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Número da transação não informado!', cDS_METHOD);
    return(-1); exit;
  end;
  if (vDtTransacao = '') then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Data da transação não informada!', cDS_METHOD);
    return(-1); exit;
  end;

  clear_e(tTRA_TRANSACAO);
  putitem_e(tTRA_TRANSACAO, 'CD_EMPRESA', vCdEmpresa);
  putitem_e(tTRA_TRANSACAO, 'NR_TRANSACAO', vNrTransacao);
  putitem_e(tTRA_TRANSACAO, 'DT_TRANSACAO', vDtTransacao);
  retrieve_e(tTRA_TRANSACAO);
  if (xStatus < 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Transação ' + FloatToStr(vNrTransacao) + ' não cadastrada!', cDS_METHOD);
    return(-1); exit;
  end;
  if (item_f('TP_MODALIDADE', tGER_OPERACAO) <> 4 ) and (item_f('TP_MODALIDADE', tGER_OPERACAO) <> 8)  or (item_f('TP_OPERACAO', tTRA_TRANSACAO) <> 'S') then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Transação ' + FloatToStr(vNrTransacao) + ' não é de troca!', cDS_METHOD);
    return(-1); exit;
  end;
  if (vDtPrevEntrega <> '') then begin
    vNrDias := vDtPrevEntrega - vDtTransacao;
    if (vNrDias <> 100)  and (vNrDias <> 0) then begin
      Result := SetStatus(STS_ERROR, 'GEN0001', 'Transação de troca ' + FloatToStr(vNrTransacao) + ' não pode ter previsão de entrega!', cDS_METHOD);
      return(-1); exit;
    end;
  end;

  return(0); exit;
end;

//-------------------------------------------------------------------
function T_SICSVCO005.buscaVlBrutoLiquido(pParams : String) : String;
//-------------------------------------------------------------------
const
  cDS_METHOD = 'ADICIONAL=Operação: T_SICSVCO005.buscaVlBrutoLiquido()';
var
  vDsRegistro, vDsLstTransacao, vDsLstTra : String;
  vCdEmpresa, vNrTransacao, vVlTrocoMaximo, vVlTotalBruto, vVlTotalLiquido : Real;
  vDtTransacao : TDate;
  vInTrocoMaximo : Boolean;
begin
  vDsLstTransacao := itemXml('DS_LSTTRANSACAO', pParams);
  vInTrocoMaximo := itemXmlB('IN_TROCOMAXIMO', pParams);
  vVlTrocoMaximo := itemXmlF('VL_TROCOMAXIMO', pParams);

  if (vDsLstTransacao = '') then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Lista de transação não informada!', cDS_METHOD);
    return(-1); exit;
  end;

  vVlTotalBruto := 0;
  vVlTotalLiquido := 0;

  vDsLstTra := vDsLstTransacao;
  repeat
    getitem(vDsRegistro, vDsLstTra, 1);
    vCdEmpresa := itemXmlF('CD_EMPRESA', vDsRegistro);
    vNrTransacao := itemXmlF('NR_TRANSACAO', vDsRegistro);
    vDtTransacao := itemXml('DT_TRANSACAO', vDsRegistro);
    if (vCdEmpresa = 0) then begin
      Result := SetStatus(STS_ERROR, 'GEN0001', 'Empresa não informada!', cDS_METHOD);
      return(-1); exit;
    end;
    if (vNrTransacao = 0) then begin
      Result := SetStatus(STS_ERROR, 'GEN0001', 'Número da transação não informado!', cDS_METHOD);
      return(-1); exit;
    end;
    if (vDtTransacao = '') then begin
      Result := SetStatus(STS_ERROR, 'GEN0001', 'Data transação não informada!', cDS_METHOD);
      return(-1); exit;
    end;
    clear_e(tTRA_TRANSACAO);
    putitem_e(tTRA_TRANSACAO, 'CD_EMPRESA', vCdEmpresa);
    putitem_e(tTRA_TRANSACAO, 'NR_TRANSACAO', vNrTransacao);
    putitem_e(tTRA_TRANSACAO, 'DT_TRANSACAO', vDtTransacao);
    retrieve_e(tTRA_TRANSACAO);
    if (xStatus < 0) then begin
      Result := SetStatus(STS_ERROR, 'GEN0001', 'Transação ' + FloatToStr(vNrTransacao) + ' não cadastrada!', cDS_METHOD);
      return(-1); exit;
    end;
    vVlTotalBruto := vVlTotalBruto + (item_f('VL_TOTAL', tTRA_TRANSACAO) + item_f('VL_DESCONTO', tTRA_TRANSACAO));
    vVlTotalLiquido := vVlTotalLiquido + item_f('VL_TOTAL', tTRA_TRANSACAO);

    if (vInTrocoMaximo = True)  and (vVlTrocoMaximo > 0) then begin
      clear_e(tGER_EMPRESA);
      putitem_e(tGER_EMPRESA, 'CD_EMPRESA', item_f('CD_EMPRESA', tTRA_TRANSACAO));
      retrieve_e(tGER_EMPRESA);
      if (xStatus >= 0) then begin
        if (item_f('CD_CCUSTO', tGER_EMPRESA) > 0) then begin
          clear_e(tTRA_TRANSACAO);
          putitem_e(tTRA_TRANSACAO, 'CD_EMPRESA', item_f('CD_CCUSTO', tGER_EMPRESA));
          putitem_e(tTRA_TRANSACAO, 'NR_TRANSACAO', vNrTransacao);
          putitem_e(tTRA_TRANSACAO, 'DT_TRANSACAO', vDtTransacao);
          retrieve_e(tTRA_TRANSACAO);
          if (xStatus >= 0) then begin
            vVlTotalBruto := vVlTotalBruto + (item_f('VL_TOTAL', tTRA_TRANSACAO) + item_f('VL_DESCONTO', tTRA_TRANSACAO));
            vVlTotalLiquido := vVlTotalLiquido + item_f('VL_TOTAL', tTRA_TRANSACAO);
          end;
        end;
      end;
    end;

    delitem(vDsLstTra, 1);
  until (vDsLstTra = '');

  Result := '';
  putitemXml(Result, 'VL_TOTALBRUTO', vVlTotalBruto);
  putitemXml(Result, 'VL_TOTALLIQUIDO', vVlTotalLiquido);

  return(0); exit;
end;

//---------------------------------------------------------------------
function T_SICSVCO005.arredondaQtFracionada(pParams : String) : String;
//---------------------------------------------------------------------
const
  cDS_METHOD = 'ADICIONAL=Operação: T_SICSVCO005.arredondaQtFracionada()';
var
  viParams, voParams : String;
  vCdEmpresa, vNrTransacao, vNrItem, vQtSolicitada : Real;
  vDtTransacao : TDate;
begin
  vCdEmpresa := itemXmlF('CD_EMPRESA', pParams);
  vNrTransacao := itemXmlF('NR_TRANSACAO', pParams);
  vDtTransacao := itemXml('DT_TRANSACAO', pParams);
  vNrItem := itemXmlF('NR_ITEM', pParams);

  if (vCdEmpresa = 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Empresa não informada!', cDS_METHOD);
    return(-1); exit;
  end;
  if (vNrTransacao = 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Número transação não informado!', cDS_METHOD);
    return(-1); exit;
  end;
  if (vDtTransacao = '') then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Data transação não informada!', cDS_METHOD);
    return(-1); exit;
  end;
  if (vNrItem = 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Item da transação não informado!', cDS_METHOD);
    return(-1); exit;
  end;

  clear_e(tTRA_TRANSITEM);
  putitem_e(tTRA_TRANSITEM, 'CD_EMPRESA', vCdEmpresa);
  putitem_e(tTRA_TRANSITEM, 'NR_TRANSACAO', vNrTransacao);
  putitem_e(tTRA_TRANSITEM, 'DT_TRANSACAO', vDtTransacao);
  putitem_e(tTRA_TRANSITEM, 'NR_ITEM', vNrItem);
  retrieve_e(tTRA_TRANSITEM);
  if (xStatus < 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Item ' + FloatToStr(vNrItem) + ' da transação ' + FloatToStr(vNrTransacao) + ' não cadastrado!', cDS_METHOD);
    return(-1); exit;
  end;

  vQtSolicitada := 0;

  if (item_f('QT_SOLICITADA', tTRA_TRANSITEM) > 0) then begin
    vQtSolicitada := item_f('QT_SOLICITADA', tTRA_TRANSITEM);
  end else begin
    clear_e(tGER_EMPRESA);
    putitem_e(tGER_EMPRESA, 'CD_EMPRESA', item_f('CD_EMPFAT', tTRA_TRANSITEM));
    retrieve_e(tGER_EMPRESA);
    if (xStatus >= 0) then begin
      if (item_f('CD_CCUSTO', tGER_EMPRESA) > 0) then begin
        clear_e(tTRA_TRANSITEM);
        putitem_e(tTRA_TRANSITEM, 'CD_EMPRESA', item_f('CD_CCUSTO', tGER_EMPRESA));
        putitem_e(tTRA_TRANSITEM, 'NR_TRANSACAO', vNrTransacao);
        putitem_e(tTRA_TRANSITEM, 'DT_TRANSACAO', vDtTransacao);
        putitem_e(tTRA_TRANSITEM, 'NR_ITEM', vNrItem);
        retrieve_e(tTRA_TRANSITEM);
        if (xStatus >= 0) then begin
          vQtSolicitada := item_f('QT_SOLICITADA', tTRA_TRANSITEM);
        end;
      end;
    end;
  end;

  Result := '';
  putitemXml(Result, 'QT_SOLICITADA', vQtSolicitada);

  return(0); exit;
end;

//--------------------------------------------------------------
function T_SICSVCO005.arredondaCusto(pParams : String) : String;
//--------------------------------------------------------------
const
  cDS_METHOD = 'ADICIONAL=Operação: T_SICSVCO005.arredondaCusto()';
var
  viParams, voParams, vTpValor, vDsCustoSubstTributario, vDsCustoValorRetido : String;
  vCdEmpresa, vNrFatura, vNrItem, vCdProduto, vCdValor, vVlUnitario : Real;
  vVlCalc, vCdMotivo, vVlIPI, vCdCustoSemImp, vQtFaturado, vCdCustoMedioSemImp : Real;
  vDtFatura : TDate;
  vInPDVOtimizado, vInSoConsulta : Boolean;
begin
  vCdEmpresa := itemXmlF('CD_EMPRESA', pParams);
  vNrFatura := itemXmlF('NR_FATURA', pParams);
  vDtFatura := itemXml('DT_FATURA', pParams);
  vNrItem := itemXmlF('NR_ITEM', pParams);
  vCdProduto := itemXmlF('CD_PRODUTO', pParams);
  vTpValor := itemXmlF('TP_VALOR', pParams);
  vCdValor := itemXmlF('CD_VALOR', pParams);
  vCdMotivo := itemXmlF('CD_MOTIVO', pParams);
  vCdCustoSemImp := itemXmlF('CD_CUSTO_S_IMPOSTO', pParams);
  vCdCustoMedioSemImp := itemXmlF('CD_CUSTO_MEDIO_S_IMPOSTO', pParams);
  vInPDVOtimizado := itemXmlB('IN_PDV_OTIMIZADO', pParams);
  vInSoConsulta := itemXmlB('IN_SO_CONSULTA', pParams);

  vDsCustoSubstTributario := itemXml('DS_CUSTO_SUBST_TRIBUTARIA', pParams);
  scan(vDsCustoSubstTributario, ';
  vDsCustoSubstTributario := vDsCustoSubstTributario[1, gresult - 1];

  vDsCustoValorRetido := itemXml('DS_CUSTO_VALOR_RETIDO', pParams);
  scan(vDsCustoValorRetido, ';
  vDsCustoValorRetido := vDsCustoValorRetido[1, gresult - 1];

  if (vCdEmpresa = 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Empresa não informada!', cDS_METHOD);
    return(-1); exit;
  end;
  if (vNrFatura = 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Número sequencial da NF não informado!', cDS_METHOD);
    return(-1); exit;
  end;
  if (vDtFatura = '') then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Data da NF não informada!', cDS_METHOD);
    return(-1); exit;
  end;
  if (vNrItem = 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Número do item da NF não informado!', cDS_METHOD);
    return(-1); exit;
  end;
  if (vCdProduto = 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Produto não informado!', cDS_METHOD);
    return(-1); exit;
  end;
  if (vTpValor = '') then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Tipo de valor não informado!', cDS_METHOD);
    return(-1); exit;
  end;
  if (vCdValor = 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Código do valor não informado!', cDS_METHOD);
    return(-1); exit;
  end;

  getParams(pParams); (* itemXmlF('CD_EMPRESA', PARAM_GLB), 'arredondaCusto' *)
  if (xStatus < 0) then begin
    return(-1); exit;
  end;

  clear_e(tFIS_NFITEMPRO);
  putitem_e(tFIS_NFITEMPRO, 'CD_EMPRESA', vCdEmpresa);
  putitem_e(tFIS_NFITEMPRO, 'NR_FATURA', vNrFatura);
  putitem_e(tFIS_NFITEMPRO, 'DT_FATURA', vDtFatura);
  putitem_e(tFIS_NFITEMPRO, 'NR_ITEM', vNrItem);
  putitem_e(tFIS_NFITEMPRO, 'CD_PRODUTO', vCdProduto);
  retrieve_e(tFIS_NFITEMPRO);
  if (xStatus < 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Item/Produto ' + FloatToStr(vNrItem) + '/' + FloatToStr(vCdProduto) + ' da NF ' + FloatToStr(vNrFatura) + ' não cadastrado!', cDS_METHOD);
    return(-1); exit;
  end;

  clear_e(tFIS_NF);
  putitem_e(tFIS_NF, 'CD_EMPRESA', vCdEmpresa);
  putitem_e(tFIS_NF, 'NR_FATURA', vNrFatura);
  putitem_e(tFIS_NF, 'DT_FATURA', vDtFatura);
  retrieve_e(tFIS_NF);
  if (xStatus < 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'NF ' + FloatToStr(vNrFatura) + ' não cadastrado!', cDS_METHOD);
    return(-1); exit;
  end;

  vQtFaturado := item_f('QT_FATURADO', tFIS_NFITEMPRO);

  clear_e(tFIS_NFITEMVL);
  putitem_e(tFIS_NFITEMVL, 'CD_EMPRESA', vCdEmpresa);
  putitem_e(tFIS_NFITEMVL, 'NR_FATURA', vNrFatura);
  putitem_e(tFIS_NFITEMVL, 'DT_FATURA', vDtFatura);
  putitem_e(tFIS_NFITEMVL, 'NR_ITEM', vNrItem);
  putitem_e(tFIS_NFITEMVL, 'CD_PRODUTO', vCdProduto);
  putitem_e(tFIS_NFITEMVL, 'TP_VALOR', vTpValor);
  putitem_e(tFIS_NFITEMVL, 'CD_VALOR', vCdValor);
  retrieve_e(tFIS_NFITEMVL);
  if (xStatus < 0) then begin
    if (vTpValor = 'C') then begin
      Result := SetStatus(STS_ERROR, 'GEN0001', 'Custo ' + FloatToStr(vCdProduto) + ' do item ' + FloatToStr(vNrItem) + ' da NF ' + FloatToStr(vNrFatura) + ' não cadastrado!', cDS_METHOD);
    end else begin
      Result := SetStatus(STS_ERROR, 'GEN0001', 'Preco ' + FloatToStr(vCdProduto) + ' do item ' + FloatToStr(vNrItem) + ' da NF ' + FloatToStr(vNrFatura) + ' não cadastrado!', cDS_METHOD);
    end;
    return(-1); exit;
  end;

  vVlUnitario := item_f('VL_UNITARIO', tFIS_NFITEMVL);

  vVlIPI := 0;

  if (item_f('TP_VALOR', tFIS_NFITEMVL) = 'C')  and (item_f('CD_VALOR', tFIS_NFITEMVL) = vCdCustoSemImp ) or (item_f('CD_VALOR', tFIS_NFITEMVL) = vCdCustoMedioSemImp ) or (item_f('CD_VALOR', tFIS_NFITEMVL) = vDsCustoSubstTributario ) or (item_f('CD_VALOR', tFIS_NFITEMVL) = vDsCustoValorRetido) then begin
    if (gInAgregaIpi = 3)  or (gInAgregaIpi = 4) then begin
      clear_e(tFIS_NFITEMIMP);
      putitem_e(tFIS_NFITEMIMP, 'CD_EMPRESA', vCdEmpresa);
      putitem_e(tFIS_NFITEMIMP, 'NR_FATURA', vNrFatura);
      putitem_e(tFIS_NFITEMIMP, 'DT_FATURA', vDtFatura);
      putitem_e(tFIS_NFITEMIMP, 'NR_ITEM', vNrItem);
      putitem_e(tFIS_NFITEMIMP, 'CD_IMPOSTO', 3);
      retrieve_e(tFIS_NFITEMIMP);
      if (xStatus >= 0) then begin
        vVlCalc := item_f('VL_IMPOSTO', tFIS_NFITEMIMP) / vQtFaturado;
        vVLIPI := rounded(vVlCalc, 6);
      end;
    end;
  end else begin
    if (gInAgregaIpi = 1)  or (gInAgregaIpi = 4) then begin
      clear_e(tFIS_NFITEMIMP);
      putitem_e(tFIS_NFITEMIMP, 'CD_EMPRESA', vCdEmpresa);
      putitem_e(tFIS_NFITEMIMP, 'NR_FATURA', vNrFatura);
      putitem_e(tFIS_NFITEMIMP, 'DT_FATURA', vDtFatura);
      putitem_e(tFIS_NFITEMIMP, 'NR_ITEM', vNrItem);
      putitem_e(tFIS_NFITEMIMP, 'CD_IMPOSTO', 3);
      retrieve_e(tFIS_NFITEMIMP);
      if (xStatus >= 0) then begin
        vVlCalc := item_f('VL_IMPOSTO', tFIS_NFITEMIMP) / vQtFaturado;
        vVLIPI := rounded(vVlCalc, 6);
      end;
    end;
  end;
  if (item_f('QT_FATURADO', tFIS_NFITEMPRO) = 0) then begin
    clear_e(tGER_EMPRESA);
    putitem_e(tGER_EMPRESA, 'CD_EMPRESA', item_f('CD_EMPFAT', tFIS_NFITEMPRO));
    retrieve_e(tGER_EMPRESA);
    if (xStatus >= 0) then begin
      if (item_f('CD_CCUSTO', tGER_EMPRESA) > 0) then begin
        clear_e(tFIS_NFITEMPRO);
        putitem_e(tFIS_NFITEMPRO, 'CD_EMPRESA', item_f('CD_CCUSTO', tGER_EMPRESA));
        putitem_e(tFIS_NFITEMPRO, 'NR_FATURA', vNrFatura);
        putitem_e(tFIS_NFITEMPRO, 'DT_FATURA', vDtFatura);
        putitem_e(tFIS_NFITEMPRO, 'NR_ITEM', vNrItem);
        putitem_e(tFIS_NFITEMPRO, 'CD_PRODUTO', vCdProduto);
        retrieve_e(tFIS_NFITEMPRO);
        if (xStatus >= 0) then begin
          vQtFaturado := item_f('QT_FATURADO', tFIS_NFITEMPRO);
        end;
        clear_e(tFIS_NFITEMVL);
        putitem_e(tFIS_NFITEMVL, 'CD_EMPRESA', item_f('CD_CCUSTO', tGER_EMPRESA));
        putitem_e(tFIS_NFITEMVL, 'NR_FATURA', vNrFatura);
        putitem_e(tFIS_NFITEMVL, 'DT_FATURA', vDtFatura);
        putitem_e(tFIS_NFITEMVL, 'CD_PRODUTO', vCdProduto);
        putitem_e(tFIS_NFITEMVL, 'TP_VALOR', vTpValor);
        putitem_e(tFIS_NFITEMVL, 'CD_VALOR', vCdValor);
        retrieve_e(tFIS_NFITEMVL);
        if (xStatus >= 0) then begin
          vVlUnitario := vVlUnitario + item_f('VL_UNITARIO', tFIS_NFITEMVL);
          if (item_f('TP_VALOR', tFIS_NFITEMVL) = 'C')  and (item_f('CD_VALOR', tFIS_NFITEMVL) = vCdCustoSemImp ) or (item_f('CD_VALOR', tFIS_NFITEMVL) = vCdCustoMedioSemImp) then begin
            if (gInAgregaIpi = 3)  or (gInAgregaIpi = 4) then begin
              clear_e(tFIS_NFITEMIMP);
              putitem_e(tFIS_NFITEMIMP, 'CD_EMPRESA', vCdEmpresa);
              putitem_e(tFIS_NFITEMIMP, 'NR_FATURA', vNrFatura);
              putitem_e(tFIS_NFITEMIMP, 'DT_FATURA', vDtFatura);
              putitem_e(tFIS_NFITEMIMP, 'NR_ITEM', vNrItem);
              putitem_e(tFIS_NFITEMIMP, 'CD_IMPOSTO', 3);
              retrieve_e(tFIS_NFITEMIMP);
              if (xStatus >= 0) then begin
                vVlCalc := item_f('VL_IMPOSTO', tFIS_NFITEMIMP) / vQtFaturado;
                vVLIPI := rounded(vVlCalc, 6);
              end;
            end;
          end else begin
            if (gInAgregaIpi = 1)  or (gInAgregaIpi = 4) then begin
              clear_e(tFIS_NFITEMIMP);
              putitem_e(tFIS_NFITEMIMP, 'CD_EMPRESA', item_f('CD_CCUSTO', tGER_EMPRESA));
              putitem_e(tFIS_NFITEMIMP, 'NR_FATURA', vNrFatura);
              putitem_e(tFIS_NFITEMIMP, 'DT_FATURA', vDtFatura);
              putitem_e(tFIS_NFITEMIMP, 'NR_ITEM', item_f('NR_ITEM', tFIS_NFITEMVL));
              putitem_e(tFIS_NFITEMIMP, 'CD_IMPOSTO', 3);
              retrieve_e(tFIS_NFITEMIMP);
              if (xStatus >= 0) then begin
                vVlCalc := item_f('VL_IMPOSTO', tFIS_NFITEMIMP) / vQtFaturado;
                vVlIPI := vVlIPI + rounded(vVlCalc, 6);
              end;
            end;
          end;
        end;
      end;
    end;
  end else begin
    if (vInsoConsulta <> True) then begin
      clear_e(tGER_EMPRESA);
      putitem_e(tGER_EMPRESA, 'CD_CCUSTO', item_f('CD_EMPFAT', tFIS_NFITEMPRO));
      retrieve_e(tGER_EMPRESA);
      if (xStatus >= 0) then begin
        if (item_f('NR_TRANSACAOORI', tFIS_NF) > 0) then begin
          clear_e(tTRA_TRANSACAO);
          putitem_e(tTRA_TRANSACAO, 'CD_EMPRESA', item_f('CD_EMPRESA', tGER_EMPRESA));
          putitem_e(tTRA_TRANSACAO, 'NR_TRANSACAO', item_f('NR_TRANSACAOORI', tFIS_NF));
          putitem_e(tTRA_TRANSACAO, 'DT_TRANSACAO', item_a('DT_TRANSACAOORI', tFIS_NF));
          retrieve_e(tTRA_TRANSACAO);

          if (xStatus < 0)  or (vInPDVOtimizado) then begin
            viParams := '';
            vVlCalc := vVlUnitario - (vVlUnitario * item_f('PR_DESCONTO', tFIS_NFITEMVL) / 100);
            vVlCalc := rounded(vVlCalc, 6);
            vVlCalc := vVlCalc - (vVlCalc * item_f('PR_DESCONTOCAB', tFIS_NFITEMVL) / 100);
            vVlCalc := rounded(vVlCalc, 6);
            vVlCalc := vVlCalc + vVlIPI;
            putitemXml(viParams, 'CD_EMPRESA', item_f('CD_EMPRESA', tGER_EMPRESA));
            putitemXml(viParams, 'CD_PRODUTO', item_f('CD_PRODUTO', tFIS_NFITEMPRO));
            putitemXml(viParams, 'TP_VALOR', item_f('TP_VALOR', tFIS_NFITEMVL));
            putitemXml(viParams, 'CD_VALOR', item_f('CD_VALOR', tFIS_NFITEMVL));
            putitemXml(viParams, 'VL_PRODUTOATU', vVlCalc);
            putitemXml(viParams, 'CD_MOTIVO', vCdMotivo);
            voParams := activateCmp('PRDSVCO007', 'atualizaValor', viParams); (*,,,, *)
            if (xStatus < 0) then begin
              Result := voParams;
              return(-1); exit;
            end;
          end;
        end;
      end;
    end;
  end;

  Result := '';
  putitemXml(Result, 'VL_UNITARIO', vVlUnitario);
  putitemXml(Result, 'VL_IPI', vVlIPI);
  putitemXml(Result, 'QT_FATURADO', vQtFaturado);

  return(0); exit;
end;

//--------------------------------------------------------------
function T_SICSVCO005.buscaSequencia(pParams : String) : String;
//--------------------------------------------------------------
const
  cDS_METHOD = 'ADICIONAL=Operação: T_SICSVCO005.buscaSequencia()';
var
  viParams, voParams : String;
  vCdEmpresa, vNrTransacao, vNrFatura : Real;
  vDtTransacao : TDate;
begin
  vCdEmpresa := itemXmlF('CD_EMPRESA', pParams);
  vNrTransacao := itemXmlF('NR_TRANSACAO', pParams);
  vDtTransacao := itemXml('DT_TRANSACAO', pParams);

  if (vCdEmpresa = 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Empresa não informada!', cDS_METHOD);
    return(-1); exit;
  end;
  if (vNrTransacao = 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Número transação não informado!', cDS_METHOD);
    return(-1); exit;
  end;
  if (vDtTransacao = '') then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Data transação não informada!', cDS_METHOD);
    return(-1); exit;
  end;

  clear_e(tTRA_TRANSACAO);
  putitem_e(tTRA_TRANSACAO, 'CD_EMPRESA', vCdEmpresa);
  putitem_e(tTRA_TRANSACAO, 'NR_TRANSACAO', vNrTransacao);
  putitem_e(tTRA_TRANSACAO, 'DT_TRANSACAO', vDtTransacao);
  retrieve_e(tTRA_TRANSACAO);
  if (xStatus < 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Transação ' + FloatToStr(vNrTransacao) + ' não cadastrada!', cDS_METHOD);
    return(-1); exit;
  end;

  vNrFatura := 0;

  if (item_f('TP_ORIGEMEMISSAO', tTRA_TRANSACAO) = 2) then begin
    vCdEmpresa := 0;
    clear_e(tGER_EMPRESA);
    putitem_e(tGER_EMPRESA, 'CD_CCUSTO', item_f('CD_EMPFAT', tTRA_TRANSACAO));
    retrieve_e(tGER_EMPRESA);
    if (xStatus >= 0) then begin
      vCdEmpresa := item_f('CD_EMPRESA', tGER_EMPRESA);
    end else begin
      clear_e(tGER_EMPRESA);
      putitem_e(tGER_EMPRESA, 'CD_EMPRESA', item_f('CD_EMPFAT', tTRA_TRANSACAO));
      retrieve_e(tGER_EMPRESA);
      if (xStatus >= 0) then begin
        if (item_f('CD_CCUSTO', tGER_EMPRESA) > 0) then begin
          vCdEmpresa := item_f('CD_CCUSTO', tGER_EMPRESA);
        end;
      end;
    end;
    if (vCdEmpresa > 0) then begin
      clear_e(tTRA_TRANSACAO);
      putitem_e(tTRA_TRANSACAO, 'CD_EMPRESA', vCdEmpresa);
      putitem_e(tTRA_TRANSACAO, 'NR_TRANSACAO', vNrTransacao);
      putitem_e(tTRA_TRANSACAO, 'DT_TRANSACAO', vDtTransacao);
      retrieve_e(tTRA_TRANSACAO);
      if (xStatus >= 0) then begin
        clear_e(tFIS_NF);
        putitem_e(tFIS_NF, 'CD_EMPRESAORI', item_f('CD_EMPRESA', tTRA_TRANSACAO));
        putitem_e(tFIS_NF, 'NR_TRANSACAOORI', item_f('NR_TRANSACAO', tTRA_TRANSACAO));
        putitem_e(tFIS_NF, 'DT_TRANSACAOORI', item_a('DT_TRANSACAO', tTRA_TRANSACAO));
        retrieve_e(tFIS_NF);
        if (xStatus >= 0) then begin
          vNrFatura := item_f('NR_FATURA', tFIS_NF);
        end;
      end;
    end;
  end;
  if (vNrFatura = 0) then begin
    viParams := '';
    putitemXml(viParams, 'NM_ENTIDADE', 'FIS_NF');
    voParams := activateCmp('GERSVCO031', 'getNumSeq', viParams); (*,,,, *)
    if (xStatus < 0) then begin
      Result := voParams;
      return(-1); exit;
    end;
    vNrFatura := itemXmlF('NR_SEQUENCIA', voParams);
  end;

  Result := '';
  putitemXml(Result, 'NR_FATURA', vNrFatura);

  return(0); exit;
end;

//---------------------------------------------------------------------
function T_SICSVCO005.validaNumeroTransacao(pParams : String) : String;
//---------------------------------------------------------------------
const
  cDS_METHOD = 'ADICIONAL=Operação: T_SICSVCO005.validaNumeroTransacao()';
var
  viParams, voParams : String;
  vCdEmpresa, vNrTransacao, vNrFatura : Real;
  vDtTransacao : TDate;
  vInDuplicado : Boolean;
begin
  vCdEmpresa := itemXmlF('CD_EMPRESA', pParams);
  vNrTransacao := itemXmlF('NR_TRANSACAO', pParams);
  vDtTransacao := itemXml('DT_TRANSACAO', pParams);
  vInDuplicado := False;

  if (vCdEmpresa = 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Empresa não informada!', cDS_METHOD);
    return(-1); exit;
  end;
  if (vNrTransacao = 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Número transação não informado!', cDS_METHOD);
    return(-1); exit;
  end;
  if (vDtTransacao = '') then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Data transação não informada!', cDS_METHOD);
    return(-1); exit;
  end;

  clear_e(tTRA_TRANSACAO);
  putitem_e(tTRA_TRANSACAO, 'CD_EMPRESA', vCdEmpresa);
  putitem_e(tTRA_TRANSACAO, 'NR_TRANSACAO', vNrTransacao);
  putitem_e(tTRA_TRANSACAO, 'DT_TRANSACAO', vDtTransacao);
  retrieve_e(tTRA_TRANSACAO);
  if (xStatus < 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Transação ' + FloatToStr(vNrTransacao) + ' não cadastrada!', cDS_METHOD);
    return(-1); exit;
  end;
  if (item_f('TP_ORIGEMEMISSAO', tTRA_TRANSACAO) = 2) then begin
    vCdEmpresa := 0;
    clear_e(tGER_EMPRESA);
    putitem_e(tGER_EMPRESA, 'CD_CCUSTO', item_f('CD_EMPFAT', tTRA_TRANSACAO));
    retrieve_e(tGER_EMPRESA);
    if (xStatus >= 0) then begin
      vInDuplicado := False;
    end else begin
      clear_e(tGER_EMPRESA);
      putitem_e(tGER_EMPRESA, 'CD_EMPRESA', item_f('CD_EMPFAT', tTRA_TRANSACAO));
      retrieve_e(tGER_EMPRESA);
      if (xStatus >= 0) then begin
        if (item_f('CD_CCUSTO', tGER_EMPRESA) > 0) then begin
          vCdEmpresa := item_f('CD_CCUSTO', tGER_EMPRESA);
        end;
      end;
    end;
    if (vCdEmpresa > 0) then begin
      clear_e(tTRA_TRANSACAO);
      putitem_e(tTRA_TRANSACAO, 'CD_EMPRESA', vCdEmpresa);
      putitem_e(tTRA_TRANSACAO, 'NR_TRANSACAO', vNrTransacao);
      putitem_e(tTRA_TRANSACAO, 'DT_TRANSACAO', vDtTransacao);
      retrieve_e(tTRA_TRANSACAO);
      if (xStatus >= 0) then begin
        if (item_f('TP_SITUACAO', tTRA_TRANSACAO) = 1) then begin
          vInDuplicado := True;
        end;
      end;
    end;
  end;

  Result := '';
  putitemXml(Result, 'IN_DUPLICADO', vInDuplicado);

  return(0); exit;

end;

//----------------------------------------------------------------------
function T_SICSVCO005.validaTransacaoDefeito(pParams : String) : String;
//----------------------------------------------------------------------
const
  cDS_METHOD = 'ADICIONAL=Operação: T_SICSVCO005.validaTransacaoDefeito()';
var
  vCdEmpresa, vNrTransacao, vCdEmpresaLogin, vCdEmpresaTra : Real;
  vDtTransacao : TDate;
  vInCCusto, vInTransacao, vInValido : Boolean;
begin
  vCdEmpresa := itemXmlF('CD_EMPRESA', pParams);
  vNrTransacao := itemXmlF('NR_TRANSACAO', pParams);
  vDtTransacao := itemXml('DT_TRANSACAO', pParams);

  if (vCdEmpresa = 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Empresa não informada!', cDS_METHOD);
    return(-1); exit;
  end;
  if (vNrTransacao = 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Número da transação não informado!', cDS_METHOD);
    return(-1); exit;
  end;
  if (vDtTransacao = '') then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Data transação não informada!', cDS_METHOD);
    return(-1); exit;
  end;

  vCdEmpresaLogin := itemXmlF('CD_EMPRESA', PARAM_GLB);
  vInCCusto := False;
  vInTransacao := False;
  vInValido := True;

  clear_e(tTRA_TRANSACAO);
  putitem_e(tTRA_TRANSACAO, 'CD_EMPRESA', vCdEmpresa);
  putitem_e(tTRA_TRANSACAO, 'NR_TRANSACAO', vNrTransacao);
  putitem_e(tTRA_TRANSACAO, 'DT_TRANSACAO', vDtTransacao);
  retrieve_e(tTRA_TRANSACAO);
  if (xStatus < 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Transação ' + FloatToStr(vNrTransacao) + ' não cadastrada!', cDS_METHOD);
    return(-1); exit;
  end;

  vCdEmpresaTra := 0;

  clear_e(tGER_EMPRESA);
  putitem_e(tGER_EMPRESA, 'CD_EMPRESA', vCdEmpresaLogin);
  retrieve_e(tGER_EMPRESA);
  if (xStatus < 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Empresa ' + CD_EMPFAT + '.TRA_TRANSACAO não cadastrada!', cDS_METHOD);
    return(-1); exit;
  end else begin
    if (item_f('CD_CCUSTO', tGER_EMPRESA) > 0) then begin
      vCdEmpresaTra := item_f('CD_CCUSTO', tGER_EMPRESA);
      vInCCusto := True;
    end else begin
      if (item_f('CD_EMPFAT', tTRA_TRANSACAO) = vCdEmpresaLogin) then begin
        vCdEmpresaTra := item_f('CD_EMPFAT', tTRA_TRANSACAO);
      end;
    end;
  end;
  if (vCdEmpresaTra > 0) then begin
    clear_e(tTRA_TRANSACAO);
    putitem_e(tTRA_TRANSACAO, 'CD_EMPRESA', vCdEmpresaTra);
    putitem_e(tTRA_TRANSACAO, 'NR_TRANSACAO', vNrTransacao);
    putitem_e(tTRA_TRANSACAO, 'DT_TRANSACAO', vDtTransacao);
    retrieve_e(tTRA_TRANSACAO);
    if (xStatus >= 0) then begin
      vInTransacao := True;
    end else begin
      vCdEmpresaTra := 0;
    end;
  end;
  if (vInCCusto = False)  and (vInTransacao = True) then begin
    vInValido := False;
  end;

  Result := '';
  putitemXml(Result, 'IN_CCUSTO', vInCCusto);
  putitemXml(Result, 'IN_TRANSACAO', vInTransacao);
  putitemXml(Result, 'CD_EMPRESA', vCdEmpresaTra);
  putitemXml(Result, 'IN_VALIDO', vInValido);

  return(0); exit;
end;

end.
