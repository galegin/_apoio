unit cFGRSVCO005;

interface

(* COMPONENTES 
  FCRSVCO001 / GERSVCO031 / 
*)        

uses
  Classes, SysUtils, DB,
  cServiceUnf, cDataSetUnf;

type
  T_FGRSVCO005 = class(TcServiceUnf)
  private
    tF_FCR_FATURAI,
    tFCC_CTAPES,
    tFCR_FATURAI,
    tFGR_LIQ,
    tFGR_LIQITEMCC,
    tFGR_LIQITEMCR,
    tGER_EMPRESA : TcDatasetUnf;
    function getParam(pParams : String = '') : String;
    function setEntidade(pParams : String = '') : String;
  protected
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;    
  published
    function geraLiquidacao(pParams : String = '') : String;
    function GeraLiqFatCartao(pParams : String = '') : String;
    function geraLiquidacaoCartao(pParams : String = '') : String;
    function concluiLiquidacaoCartao(pParams : String = '') : String;
  end;

implementation

uses
  cADMSVCO001,
  cActivate, cStatus, cFuncao, cXml, dModulo;

var


//---------------------------------------------------------------
constructor T_FGRSVCO005.Create(AOwner: TComponent);
//---------------------------------------------------------------
begin
  inherited Create(AOwner);
  setEntidade('');
end;

//--------------------------------
destructor T_FGRSVCO005.Destroy;
//--------------------------------
begin
  inherited Destroy;
end;

//---------------------------------------------------------------
function T_FGRSVCO005.getParam(pParams : String) : String;
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
function T_FGRSVCO005.setEntidade(pParams : String) : String;
//---------------------------------------------------------------
begin
  tF_FCR_FATURAI := GetEntidade('F_FCR_FATURAI');
  tFCC_CTAPES := GetEntidade('FCC_CTAPES');
  tFCR_FATURAI := GetEntidade('FCR_FATURAI');
  tFGR_LIQ := GetEntidade('FGR_LIQ');
  tFGR_LIQITEMCC := GetEntidade('FGR_LIQITEMCC');
  tFGR_LIQITEMCR := GetEntidade('FGR_LIQITEMCR');
  tGER_EMPRESA := GetEntidade('GER_EMPRESA');
end;

//--------------------------------------------------------------
function T_FGRSVCO005.geraLiquidacao(pParams : String) : String;
//--------------------------------------------------------------
const
  cDS_METHOD = 'ADICIONAL=Operação: T_FGRSVCO005.geraLiquidacao()';
var
  vNrFatura, vCdEmpresa, vCdCliente, vNrParcela, vNrSeqItem : Real;
  vNrSeqLiq, vVlTotal, vNrCtaPesCx : Real;
  vDsLinha, viParams, voParams, vDsRegFatI, vDsFaturaI : String;
  vDsOrigem, vDsDestino, vDsRegOrigem, vDsRegDestino : String;
  vDtSistema : TDate;
begin
  clear_e(tFCR_FATURAI);
  clear_e(tGER_EMPRESA);
  clear_e(tFGR_LIQ);
  clear_e(tF_FCR_FATURAI);

  clear_e(tFCC_CTAPES);
  putitem_e(tFCC_CTAPES, 'CD_PESSOA', itemXmlF('CD_USUARIO', PARAM_GLB));
  retrieve_e(tFCC_CTAPES);
  if (xStatus >= 0) then begin
    vNrCtaPesCx := item_f('NR_CTAPES', tFCC_CTAPES);
  end else begin
    vNrCtaPesCx := 0;
  end;

  vDsOrigem := itemXml('DS_ORIGEM', pParams);
  if (vDsOrigem <> '') then begin
    repeat
      getitem(vDsRegOrigem, vDsOrigem, 1);
      creocc(tFCR_FATURAI, -1);
      getlistitensocc_e(vDsRegOrigem, tFCR_FATURAI);
      retrieve_o(tFCR_FATURAI);
      if (xStatus = -7) then begin
        retrieve_x(tFCR_FATURAI);
      end;

      delitem(vDsOrigem, 1);
    until (vDsOrigem = '');
  end;

  vDsDestino := itemXml('DS_DESTINO', pParams);
  if (vDsDestino <> '') then begin
    repeat
      getitem(vDsRegDestino, vDsDestino, 1);
      creocc(tF_FCR_FATURAI, -1);
      getlistitensocc_e(vDsRegDestino, tF_FCR_FATURAI);
      retrieve_o(tF_FCR_FATURAI);
      if (xStatus = -7) then begin
        retrieve_x(tF_FCR_FATURAI);
      end;

      delitem(vDsDestino, 1);
    until (vDsDestino = '');
  end;

  vCdEmpresa := itemXmlF('CD_EMPRESA', PARAM_GLB);

  clear_e(tGER_EMPRESA);
  putitem_e(tGER_EMPRESA, 'CD_EMPRESA', vCdEmpresa);
  retrieve_e(tGER_EMPRESA);
  if (xStatus < 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Empresa não cadastrada!', cDS_METHOD);
    return(-1); exit;
  end;

  viParams := '';
  putitemXml(viParams, 'NM_ENTIDADE', 'FGR_LIQ');
  voParams := activateCmp('GERSVCO031', 'getNumSeq', viParams); (*,,,, *)
  if (xStatus < 0) then begin
    Result := voParams;
    return(-1); exit;
  end;
  vNrSeqLiq := itemXmlF('NR_SEQUENCIA', voParams);

  setocc(tFCR_FATURAI, 1);

  vDtSistema := item_a('DT_EMISSAO', tFCR_FATURAI);

  creocc(tFGR_LIQ, -1);
  putitem_e(tFGR_LIQ, 'CD_EMPLIQ', item_f('CD_EMPRESA', tFCR_FATURAI));
  putitem_e(tFGR_LIQ, 'DT_LIQ', vDtSistema);
  putitem_e(tFGR_LIQ, 'NR_SEQLIQ', vNrSeqLiq);
  retrieve_o(tFGR_LIQ);
  if (xStatus = -7) then begin
    retrieve_x(tFGR_LIQ);
  end;
  putitem_e(tFGR_LIQ, 'CD_OPERADOR', itemXmlF('CD_USUARIO', PARAM_GLB));
  putitem_e(tFGR_LIQ, 'DT_CADASTRO', Now);
  putitem_e(tFGR_LIQ, 'TP_LIQUIDACAO', 5);
  putitem_e(tFGR_LIQ, 'CD_GRUPOEMPRESA', item_f('CD_GRUPOEMPRESA', tGER_EMPRESA));

  putmess 'Inicio salvando fatura ' + gclock' + ';

  vNrSeqItem := 1;
  vVlTotal := 0;
  setocc(tFCR_FATURAI, 1);
  while (xStatus >= 0) do begin
    creocc(tFGR_LIQITEMCR, -1);
    putitem_e(tFGR_LIQITEMCR, 'NR_SEQITEM', vNrSeqItem);
    putitem_e(tFGR_LIQITEMCR, 'CD_OPERADOR', itemXmlF('CD_USUARIO', PARAM_GLB));
    putitem_e(tFGR_LIQITEMCR, 'DT_CADASTRO', Now);
    putitem_e(tFGR_LIQITEMCR, 'CD_EMPFAT', item_f('CD_EMPRESA', tFCR_FATURAI));
    putitem_e(tFGR_LIQITEMCR, 'CD_CLIENTE', item_f('CD_CLIENTE', tFCR_FATURAI));
    putitem_e(tFGR_LIQITEMCR, 'NR_FAT', item_f('NR_FAT', tFCR_FATURAI));
    putitem_e(tFGR_LIQITEMCR, 'NR_PARCELA', item_f('NR_PARCELA', tFCR_FATURAI));
    putitem_e(tFGR_LIQITEMCR, 'TP_TIPOREG', 1);
    putitem_e(tFGR_LIQITEMCR, 'TP_DOCUMENTO', item_f('TP_DOCUMENTO', tFCR_FATURAI));
    putitem_e(tFGR_LIQITEMCR, 'NR_CTAPESCX', vNrCtaPesCx);
    vVlTotal := vVlTotal + item_f('VL_FATURA', tFCR_FATURAI);
    vNrSeqItem := vNrSeqItem + 1;

    putitem_e(tFCR_FATURAI, 'CD_EMPLIQ', item_f('CD_EMPLIQ', tFGR_LIQ));

    if (item_a('DT_LIQ', tFCR_FATURAI) <> '') then begin
      Result := SetStatus(STS_ERROR, 'GEN001', 'Fatura já baixada em outro processo.Empresa: ' + item_a('cd_empresa', tFCR_FATURAI) + ' Cliente: ' + item_a('cd_cliente', tFCR_FATURAI) + ' Fatura: ' + item_a('nr_fat', tFCR_FATURAI) + ' Parcela: ' + item_a('nr_parcela', tFCR_FATURAI) + '', cDS_METHOD);
      return(-1); exit;
    end;

    putitem_e(tFCR_FATURAI, 'DT_LIQ', vDtSistema);
    putitem_e(tFCR_FATURAI, 'NR_SEQLIQ', vNrSeqLiq);
    putitem_e(tFCR_FATURAI, 'VL_PAGO', item_f('VL_FATURA', tFCR_FATURAI));

    if (item_f('TP_BAIXA', tFCR_FATURAI) < 1) then begin
      putitem_e(tFCR_FATURAI, 'TP_BAIXA', 1);
    end;

    putitem_e(tFCR_FATURAI, 'CD_OPERBAIXA', itemXmlF('CD_USUARIO', PARAM_GLB));
    putitem_o(tFCR_FATURAI, 'DT_BAIXA', vDtSistema);

    if (xStatus = -11) then begin
      Result := SetStatus(STS_ERROR, 'GEN001', 'Fatura sendo utilizada em outro processo ou manutenção.Empresa: ' + item_a('cd_empresa', tFCR_FATURAI) + ' Cliente: ' + item_a('cd_cliente', tFCR_FATURAI) + ' Fatura: ' + item_a('nr_fat', tFCR_FATURAI) + ' Parcela: ' + item_a('nr_parcela', tFCR_FATURAI) + '', cDS_METHOD);
      return(-1); exit;
    end;

    setocc(tFCR_FATURAI, curocc(tFCR_FATURAI) + 1);
  end;

  putmess 'Final salvando fatura ' + gclock' + ';

  setocc(tF_FCR_FATURAI, 1);
  while (xStatus >= 0) do begin
    creocc(tFGR_LIQITEMCR, -1);
    putitem_e(tFGR_LIQITEMCR, 'NR_SEQITEM', vNrSeqItem);
    putitem_e(tFGR_LIQITEMCR, 'CD_OPERADOR', itemXmlF('CD_USUARIO', PARAM_GLB));
    putitem_e(tFGR_LIQITEMCR, 'DT_CADASTRO', Now);
    putitem_e(tFGR_LIQITEMCR, 'CD_EMPFAT', item_f('CD_EMPRESA', tF_FCR_FATURAI));
    putitem_e(tFGR_LIQITEMCR, 'CD_CLIENTE', item_f('CD_CLIENTE', tF_FCR_FATURAI));
    putitem_e(tFGR_LIQITEMCR, 'NR_FAT', item_f('NR_FAT', tF_FCR_FATURAI));
    putitem_e(tFGR_LIQITEMCR, 'NR_PARCELA', item_f('NR_PARCELA', tF_FCR_FATURAI));
    putitem_e(tFGR_LIQITEMCR, 'TP_TIPOREG', 2);
    putitem_e(tFGR_LIQITEMCR, 'TP_DOCUMENTO', item_f('TP_DOCUMENTO', tF_FCR_FATURAI));
    vNrSeqItem := vNrSeqItem + 1;
    setocc(tF_FCR_FATURAI, curocc(tF_FCR_FATURAI) + 1);
  end;

  putmess 'Inicio salvando liquidacao ' + gclock' + ';

  putitem_e(tFGR_LIQ, 'VL_TOTAL', vVlTotal);
  voParams := tFGR_LIQ.Salvar();
  if (xStatus < 0) then begin
    Result := voParams;
    return(-1); exit;
  end;

  putmess 'Final salvando liquidacao ' + gclock' + ';

  voParams := tFCR_FATURAI.Salvar();
  if (xStatus < 0) then begin
    Result := voParams;
    return(-1); exit;
  end;

  return(0); exit;
end;

//----------------------------------------------------------------
function T_FGRSVCO005.GeraLiqFatCartao(pParams : String) : String;
//----------------------------------------------------------------
const
  cDS_METHOD = 'ADICIONAL=Operação: T_FGRSVCO005.GeraLiqFatCartao()';
var
  vCdEmpresa, vNrSeqItem, vNrSeqLiq, vVlTotal, vNrCtaPes : Real;
  vDsLinha, viParams, voParams, vDsOrigem, vDsRegOrigem : String;
  vDtSistema : TDate;
begin
  clear_e(tFCR_FATURAI);
  clear_e(tGER_EMPRESA);
  clear_e(tFGR_LIQ);
  clear_e(tF_FCR_FATURAI);
  clear_e(tFCC_CTAPES);

  vDsOrigem := itemXml('DS_ORIGEM', pParams);
  if (vDsOrigem <> '') then begin
    repeat
      getitem(vDsRegOrigem, vDsOrigem, 1);
      creocc(tFCR_FATURAI, -1);
      getlistitensocc_e(vDsRegOrigem, tFCR_FATURAI);
      retrieve_o(tFCR_FATURAI);
      if (xStatus = -7) then begin
        retrieve_x(tFCR_FATURAI);
      end;
      delitem(vDsOrigem, 1);
    until (vDsOrigem = '');
  end;
  xStatus := 0;
  vNrCtaPes := itemXmlF('NR_CTAPES', pParams);

  vDtSistema := itemXml('DT_SISTEMA', PARAM_GLB);
  vCdEmpresa := itemXmlF('CD_EMPRESA', PARAM_GLB);
  clear_e(tGER_EMPRESA);
  putitem_e(tGER_EMPRESA, 'CD_EMPRESA', vCdEmpresa);
  retrieve_e(tGER_EMPRESA);
  if (xStatus < 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Empresa não cadastrada!', cDS_METHOD);
    return(-1); exit;
  end;

  viParams := '';
  putitemXml(viParams, 'NM_ENTIDADE', 'FGR_LIQ');
  voParams := activateCmp('GERSVCO031', 'getNumSeq', viParams); (*,,,, *)
  if (xStatus < 0) then begin
    Result := voParams;
    return(-1); exit;
  end;
  vNrSeqLiq := itemXmlF('NR_SEQUENCIA', voParams);

  creocc(tFGR_LIQ, -1);
  putitem_e(tFGR_LIQ, 'CD_EMPLIQ', vCdEmpresa);
  putitem_e(tFGR_LIQ, 'DT_LIQ', vDtSistema);
  putitem_e(tFGR_LIQ, 'NR_SEQLIQ', vNrSeqLiq);
  retrieve_o(tFGR_LIQ);
  if (xStatus = -7) then begin
    Result := SetStatus(STS_ERROR, 'GEN001', 'Liquidacao já existente ' + item_a('CD_EMPLIQ', tFGR_LIQ) + ' ' + item_a('DT_LIQ', tFGR_LIQ) + ' ' + item_a('NR_SEQLIQ', tFGR_LIQ) + '', cDS_METHOD);
    return(-1); exit;
  end;
  putitem_e(tFGR_LIQ, 'CD_OPERADOR', itemXmlF('CD_USUARIO', PARAM_GLB));
  putitem_e(tFGR_LIQ, 'DT_CADASTRO', Now);
  putitem_e(tFGR_LIQ, 'TP_LIQUIDACAO', 12);
  putitem_e(tFGR_LIQ, 'CD_GRUPOEMPRESA', item_f('CD_GRUPOEMPRESA', tGER_EMPRESA));
  vNrSeqItem := 1;
  vVlTotal := 0;

  clear_e(tFGR_LIQITEMCR);
  setocc(tFCR_FATURAI, 1);
  while (xStatus >= 0) do begin

    creocc(tFGR_LIQITEMCR, -1);
    putitem_e(tFGR_LIQITEMCR, 'NR_SEQITEM', vNrSeqItem);
    putitem_e(tFGR_LIQITEMCR, 'CD_OPERADOR', itemXmlF('CD_USUARIO', PARAM_GLB));
    putitem_e(tFGR_LIQITEMCR, 'DT_CADASTRO', Now);
    putitem_e(tFGR_LIQITEMCR, 'CD_EMPFAT', item_f('CD_EMPRESA', tFCR_FATURAI));
    putitem_e(tFGR_LIQITEMCR, 'CD_CLIENTE', item_f('CD_CLIENTE', tFCR_FATURAI));
    putitem_e(tFGR_LIQITEMCR, 'NR_FAT', item_f('NR_FAT', tFCR_FATURAI));
    putitem_e(tFGR_LIQITEMCR, 'NR_PARCELA', item_f('NR_PARCELA', tFCR_FATURAI));
    putitem_e(tFGR_LIQITEMCR, 'TP_TIPOREG', 1);
    vVlTotal := vVlTotal + item_f('VL_FATURA', tFCR_FATURAI);
    vNrSeqItem := vNrSeqItem + 1;
    setocc(tFCR_FATURAI, curocc(tFCR_FATURAI) + 1);
  end;
  xStatus := 0;

  creocc(tFGR_LIQITEMCR, -1);
  putitem_e(tFGR_LIQITEMCR, 'NR_SEQITEM', vNrSeqItem);
  putitem_e(tFGR_LIQITEMCR, 'CD_OPERADOR', itemXmlF('CD_USUARIO', PARAM_GLB));
  putitem_e(tFGR_LIQITEMCR, 'DT_CADASTRO', Now);
  putitem_e(tFGR_LIQITEMCR, 'TP_TIPOREG', 2);
  putitem_e(tFGR_LIQITEMCR, 'NR_CTAPES', vNrCtaPes);
  vVlTotal := vVlTotal + item_f('VL_FATURA', tFCR_FATURAI);

  putitem_e(tFGR_LIQ, 'VL_TOTAL', itemXmlF('VL_PAGO', pParams));
  voParams := tFGR_LIQ.Salvar();
  if (xStatus < 0) then begin
    Result := voParams;
    return(-1); exit;
  end;

  putitemXml(Result, 'CD_EMPLIQ', vCdEmpresa);
  putitemXml(Result, 'DT_LIQ', vDtSistema);
  putitemXml(Result, 'NR_SEQLIQ', vNrSeqLiq);
  return(0); exit;
end;

//--------------------------------------------------------------------
function T_FGRSVCO005.geraLiquidacaoCartao(pParams : String) : String;
//--------------------------------------------------------------------
const
  cDS_METHOD = 'ADICIONAL=Operação: T_FGRSVCO005.geraLiquidacaoCartao()';
var
  vDtLiq, vDtLancto : TDate;
  viParams, voParams, vDsLinha, viParams, voParams, vDsObs : String;
  vNrFat, vCdEmpresa, vCdCliente, vNrParcela : Real;
  vCdEmpLiq, vNrSeqLiq, vNrSeqItem, vVlLiquido, vVlDesconto : Real;
begin
  clear_e(tFCR_FATURAI);
  clear_e(tGER_EMPRESA);
  clear_e(tFGR_LIQ);
  clear_e(tF_FCR_FATURAI);
  clear_e(tFCC_CTAPES);

  vDtLancto := itemXml('DT_LANCTO', pParams);
  vVlLiquido := itemXmlF('VL_LIQUIDO', pParams);

  vCdEmpLiq := itemXmlF('CD_EMPLIQ', pParams);
  vDtLiq := itemXml('DT_LIQ', pParams);
  vNrSeqLiq := itemXmlF('NR_SEQLIQ', pParams);
  vNrSeqItem := itemXmlF('NR_SEQITEM', pParams);

  vCdEmpresa := itemXmlF('CD_EMPRESA', pParams);
  vCdCliente := itemXmlF('CD_CLIENTE', pParams);
  vNrFat := itemXmlF('NR_FAT', pParams);
  vNrParcela := itemXmlF('NR_PARCELA', pParams);

  vDsObs := itemXml('DS_OBSERVACAO', pParams);

  if (vNrSeqLiq > 0) then begin
    clear_e(tFGR_LIQ);
    putitem_e(tFGR_LIQ, 'CD_EMPLIQ', vCdEmpLiq);
    putitem_e(tFGR_LIQ, 'DT_LIQ', vDtLiq);
    putitem_e(tFGR_LIQ, 'NR_SEQLIQ', vNrSeqLiq);
    retrieve_e(tFGR_LIQ);
    if (xStatus < 0) then begin
      Result := SetStatus(STS_ERROR, 'GEN0001', 'Liquidação não encontada!', cDS_METHOD);
      return(-1); exit;
    end;
  end;

  while (vNrSeqLiq := 0) do begin
    viParams := '';
    putitemXml(viParams, 'NM_ENTIDADE', 'FGR_LIQ');
    voParams := activateCmp('GERSVCO031', 'getNumSeq', viParams); (*,,,, *)
    if (xStatus < 0) then begin
      Result := voParams;
      return(-1); exit;
    end;
    vNrSeqLiq := itemXmlF('NR_SEQUENCIA', voParams);

    clear_e(tFGR_LIQ);
    creocc(tFGR_LIQ, -1);

    if (vCdEmpLiq > 0) then begin
      putitem_e(tFGR_LIQ, 'CD_EMPLIQ', vCdEmpLiq);
    end else begin

      putitem_e(tFGR_LIQ, 'CD_EMPLIQ', itemXmlF('CD_EMPRESA', PARAM_GLB));
    end;
    putitem_e(tFGR_LIQ, 'DT_LIQ', vDtLancto);
    putitem_e(tFGR_LIQ, 'NR_SEQLIQ', vNrSeqLiq);
    retrieve_o(tFGR_LIQ);
    if (xStatus = -7) then begin
      vNrSeqLiq := 0;
    end else begin
      putitem_e(tFGR_LIQ, 'CD_OPERADOR', itemXmlF('CD_USUARIO', PARAM_GLB));
      putitem_e(tFGR_LIQ, 'DT_CADASTRO', Now);
      putitem_e(tFGR_LIQ, 'TP_LIQUIDACAO', 12);
      putitem_e(tFGR_LIQ, 'CD_GRUPOEMPRESA', itemXmlF('CD_GRUPOEMPRESA', PARAM_GLB));
    end;
  end;
  if (vNrSeqItem = 0) then begin
    vNrSeqItem := 1;
  end;

  clear_e(tFCR_FATURAI);
  putitem_e(tFCR_FATURAI, 'CD_EMPRESA', vCdEmpresa);
  putitem_e(tFCR_FATURAI, 'CD_CLIENTE', vCdCliente);
  putitem_e(tFCR_FATURAI, 'NR_FAT', vNrFat);
  putitem_e(tFCR_FATURAI, 'NR_PARCELA', vNrParcela);
  retrieve_e(tFCR_FATURAI);
  if (xStatus >= 0) then begin
    creocc(tFGR_LIQITEMCR, -1);
    putitem_e(tFGR_LIQITEMCR, 'NR_SEQITEM', vNrSeqItem);
    putitem_e(tFGR_LIQITEMCR, 'CD_OPERADOR', itemXmlF('CD_USUARIO', PARAM_GLB));
    putitem_e(tFGR_LIQITEMCR, 'DT_CADASTRO', Now);
    putitem_e(tFGR_LIQITEMCR, 'CD_EMPFAT', item_f('CD_EMPRESA', tFCR_FATURAI));
    putitem_e(tFGR_LIQITEMCR, 'CD_CLIENTE', item_f('CD_CLIENTE', tFCR_FATURAI));
    putitem_e(tFGR_LIQITEMCR, 'NR_FAT', item_f('NR_FAT', tFCR_FATURAI));
    putitem_e(tFGR_LIQITEMCR, 'NR_PARCELA', item_f('NR_PARCELA', tFCR_FATURAI));
    putitem_e(tFGR_LIQITEMCR, 'TP_TIPOREG', 1);
    putitem_e(tFGR_LIQITEMCR, 'TP_DOCUMENTO', item_f('TP_DOCUMENTO', tFCR_FATURAI));
    vNrSeqItem := vNrSeqItem + 1;

    vVlDesconto := item_f('VL_FATURA', tFCR_FATURAI) - vVlLiquido;
    putitem_e(tFCR_FATURAI, 'CD_EMPLIQ', item_f('CD_EMPLIQ', tFGR_LIQ));

    if (item_a('DT_LIQ', tFCR_FATURAI) <> '') then begin
      Result := SetStatus(STS_ERROR, 'GEN001', 'Fatura já baixada em outro processo.Empresa: ' + item_a('cd_empresa', tFCR_FATURAI) + ' Cliente: ' + item_a('cd_cliente', tFCR_FATURAI) + ' Fatura: ' + item_a('nr_fat', tFCR_FATURAI) + ' Parcela: ' + item_a('nr_parcela', tFCR_FATURAI) + '', cDS_METHOD);
      return(-1); exit;
    end;

    putitem_e(tFCR_FATURAI, 'DT_LIQ', item_a('DT_LIQ', tFGR_LIQ));
    putitem_e(tFCR_FATURAI, 'NR_SEQLIQ', item_f('NR_SEQLIQ', tFGR_LIQ));
    putitem_e(tFCR_FATURAI, 'VL_PAGO', vVlLiquido);
    putitem_e(tFCR_FATURAI, 'VL_LIQUIDO', vVlLiquido);
    putitem_e(tFCR_FATURAI, 'VL_DESCONTO', vVlDesconto);

    if (item_f('TP_BAIXA', tFCR_FATURAI) < 1) then begin
      putitem_e(tFCR_FATURAI, 'TP_BAIXA', 1);
    end;
    putitem_e(tFCR_FATURAI, 'DT_BAIXA', item_a('DT_LIQ', tFGR_LIQ));
    putitem_e(tFCR_FATURAI, 'CD_OPERBAIXA', itemXmlF('CD_USUARIO', PARAM_GLB));

    if (xStatus = -11) then begin
      Result := SetStatus(STS_ERROR, 'GEN001', 'Fatura sendo utilizada em outro processo ou manutenção.Empresa: ' + item_a('cd_empresa', tFCR_FATURAI) + ' Cliente: ' + item_a('cd_cliente', tFCR_FATURAI) + ' Fatura: ' + item_a('nr_fat', tFCR_FATURAI) + ' Parcela: ' + item_a('nr_parcela', tFCR_FATURAI) + '', cDS_METHOD);
      return(-1); exit;
    end;
    if (vDsObs <> '') then begin
      viParams := '';
      putitemXml(viParams, 'CD_EMPRESA', item_f('CD_EMPRESA', tFCR_FATURAI));
      putitemXml(viParams, 'CD_CLIENTE', item_f('CD_CLIENTE', tFCR_FATURAI));
      putitemXml(viParams, 'NR_FAT', item_f('NR_FAT', tFCR_FATURAI));
      putitemXml(viParams, 'NR_PARCELA', item_f('NR_PARCELA', tFCR_FATURAI));
      putitemXml(viParams, 'DS_OBSERVACAO', vDsObs);
      putitemXml(viParams, 'CD_COMPONENTE', FGRSVCO005);
      voParams := activateCmp('FCRSVCO001', 'gravaObsFatura', viParams); (*,,,, *)
      if (xStatus < 0) then begin
        Result := voParams;
        return(-1); exit;
      end;
    end;

    voParams := tFCR_FATURAI.Salvar();
    if (xStatus < 0) then begin
      Result := voParams;
      return(-1); exit;
    end;
  end;

  voParams := tFGR_LIQ.Salvar();
  if (xStatus < 0) then begin
    Result := voParams;
    return(-1); exit;
  end;

  Result := '';
  putitemXml(Result, 'CD_EMPLIQ', item_f('CD_EMPLIQ', tFGR_LIQ));
  putitemXml(Result, 'DT_LIQ', item_a('DT_LIQ', tFGR_LIQ));
  putitemXml(Result, 'NR_SEQLIQ', item_f('NR_SEQLIQ', tFGR_LIQ));
  putitemXml(Result, 'NR_SEQITEM', vNrSeqItem);

  return(0); exit;
end;

//-----------------------------------------------------------------------
function T_FGRSVCO005.concluiLiquidacaoCartao(pParams : String) : String;
//-----------------------------------------------------------------------
const
  cDS_METHOD = 'ADICIONAL=Operação: T_FGRSVCO005.concluiLiquidacaoCartao()';
var
  vDtLiq : TDate;
  viParams, voParams, vDsLinha, vDsLstMovCC, vDsMovCC : String;
  vDsLstDuplicata, vDsDuplicata : String;
  vCdEmpLiq, vNrSeqLiq, vNrSeqItem, vVlLiquido, vVlDesconto : Real;
begin
  vVlLiquido := itemXmlF('VL_LIQUIDO', pParams);

  vCdEmpLiq := itemXmlF('CD_EMPLIQ', pParams);
  vDtLiq := itemXml('DT_LIQ', pParams);
  vNrSeqLiq := itemXmlF('NR_SEQLIQ', pParams);
  vNrSeqItem := itemXmlF('NR_SEQITEM', pParams);
  vDsLstMovCC := itemXml('DS_LSTMOVCC', pParams);
  vDsLstDuplicata := itemXml('DS_LSTDUPLICATA', pParams);

  clear_e(tFCR_FATURAI);
  clear_e(tGER_EMPRESA);
  clear_e(tF_FCR_FATURAI);
  clear_e(tFCC_CTAPES);

  clear_e(tFGR_LIQ);
  putitem_e(tFGR_LIQ, 'CD_EMPLIQ', vCdEmpLiq);
  putitem_e(tFGR_LIQ, 'DT_LIQ', vDtLiq);
  putitem_e(tFGR_LIQ, 'NR_SEQLIQ', vNrSeqLiq);
  retrieve_e(tFGR_LIQ);
  if (xStatus >= 0) then begin
    repeat
      getitem(vDsMovCC, vDsLstMovCC, 1);

      creocc(tFGR_LIQITEMCR, -1);
      putitem_e(tFGR_LIQITEMCR, 'NR_SEQITEM', vNrSeqItem);
      putitem_e(tFGR_LIQITEMCR, 'CD_OPERADOR', itemXmlF('CD_USUARIO', PARAM_GLB));
      putitem_e(tFGR_LIQITEMCR, 'DT_CADASTRO', Now);
      putitem_e(tFGR_LIQITEMCR, 'TP_TIPOREG', 2);
      putitem_e(tFGR_LIQITEMCR, 'TP_DOCUMENTO', 3);
      putitem_e(tFGR_LIQITEMCR, 'NR_CTAPES', itemXmlF('NR_CTAPES', vDsMovCC));
      putitem_e(tFGR_LIQITEMCR, 'NR_CTAPESFCC', itemXmlF('NR_CTAPES', vDsMovCC));
      putitem_e(tFGR_LIQITEMCR, 'DT_MOVIMFCC', itemXml('DT_MOVIM', vDsMovCC));
      putitem_e(tFGR_LIQITEMCR, 'NR_SEQMOVFCC', itemXmlF('NR_SEQMOV', vDsMovCC));

      vNrSeqItem := vNrSeqItem + 1;
      delitem(vDsLstMovCC, 1);
    until (vDsLstMovCC = '');

    vNrSeqItem := 0;
    if (vDsLstDuplicata <> '') then begin
      repeat
        getitem(vDsDuplicata, vDsLstDuplicata, 1);
        vNrSeqItem := vNrSeqItem + 1;

        creocc(tFGR_LIQITEMCC, -1);
        putitem_e(tFGR_LIQITEMCC, 'NR_SEQITEM', vNrSeqItem);
        putitem_e(tFGR_LIQITEMCC, 'CD_OPERADOR', itemXmlF('CD_USUARIO', PARAM_GLB));
        putitem_e(tFGR_LIQITEMCC, 'DT_CADASTRO', Now);
        putitem_e(tFGR_LIQITEMCC, 'CD_EMPRESADUP', itemXmlF('CD_EMPRESA', vDsDuplicata));
        putitem_e(tFGR_LIQITEMCC, 'CD_FORNECDUP', itemXmlF('CD_FORNECEDOR', vDsDuplicata));
        putitem_e(tFGR_LIQITEMCC, 'NR_DUPLICATADUP', itemXmlF('NR_DUPLICATA', vDsDuplicata));
        putitem_e(tFGR_LIQITEMCC, 'NR_PARCELADUP', itemXmlF('NR_PARCELA', vDsDuplicata));

        delitem(vDsLstDuplicata, 1);
      until (vDsLstDuplicata = '');
    end;
  end;

  putitem_e(tFGR_LIQ, 'VL_TOTAL', vVlLiquido);
  voParams := tFGR_LIQ.Salvar();
  if (xStatus < 0) then begin
    Result := voParams;
    return(-1); exit;
  end;

  return(0); exit;
end;

end.
