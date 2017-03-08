unit cFCRSVCO005;

interface

(* COMPONENTES 
  ADMSVCO001 / FCRSVCO001 / FGRSVCO005 / FGRSVCO006 / PESSVCO022

*)        

uses
  Classes, SysUtils, Math, DB,
  cDataSetUnf;

type
  T_FCRSVCO005 = class(TComponent)
  private
    tCTC_CARTAO,
    tCTC_TPCARPAR,
    tF_FCR_FATURAI,
    tFCR_FATCARTAO,
    tFCR_FATURAI,
    tFGR_LIQ,
    tFGR_PORTEMPRE,
    tNR_PARCELAS : TcDatasetUnf;
    function getParam(pParams : String = '') : String;
    function setEntidade(pParams : String = '') : String;
  protected
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;    
  published
    function geraCartao(pParams : String = '') : String;
    function geraComplCartao(pParams : String = '') : String;
  end;

implementation

uses
  cADMSVCO001,
  cActivate, cStatus, cFuncao, cXml, dModulo;

var
  gCdTipoCampoDiaVenctoCl,
  gInCartaoCreditoPrazo,
  gInCartaoDebitoPrazo : String;

//---------------------------------------------------------------
constructor T_FCRSVCO005.Create(AOwner: TComponent);
//---------------------------------------------------------------
begin
  inherited Create(AOwner);
  setEntidade('');
end;

//--------------------------------
destructor T_FCRSVCO005.Destroy;
//--------------------------------
begin
  inherited Destroy;
end;

//---------------------------------------------------------------
function T_FCRSVCO005.getParam(pParams : String = '') : String;
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
  putitem(xParam, 'CD_TIPOCAMPO_DIAVENCTO_CL');

  xParam := T_ADMSVCO001.GetParametro(xParam);

  gCdTipoCampoDiaVenctoCl := itemXml('CD_TIPOCAMPO_DIAVENCTO_CL', xParam);
  gInCartaoCreditoPrazo := itemXml('IN_CARTAO_CREDITO_PRAZO', xParam);
  gInCartaoDebitoPrazo := itemXml('IN_CARTAO_DEBITO_PRAZO', xParam);

  xParamEmp := '';
  putitem(xParamEmp, 'CD_TIPOCAMPO_DIAVENCTO_CL');
  putitem(xParamEmp, 'IN_CARTAO_CREDITO_PRAZO');
  putitem(xParamEmp, 'IN_CARTAO_DEBITO_PRAZO');

  xParamEmp := T_ADMSVCO001.GetParamEmpresa(piCdEmpresa, xParamEmp);

  gInCartaoCreditoPrazo := itemXml('IN_CARTAO_CREDITO_PRAZO', xParamEmp);
  gInCartaoDebitoPrazo := itemXml('IN_CARTAO_DEBITO_PRAZO', xParamEmp);

end;

//---------------------------------------------------------------
function T_FCRSVCO005.setEntidade(pParams : String = '') : String;
//---------------------------------------------------------------
begin
  tCTC_CARTAO := TcDatasetUnf.getEntidade('CTC_CARTAO');
  tCTC_TPCARPAR := TcDatasetUnf.getEntidade('CTC_TPCARPAR');
  tF_FCR_FATURAI := TcDatasetUnf.getEntidade('F_FCR_FATURAI');
  tFCR_FATCARTAO := TcDatasetUnf.getEntidade('FCR_FATCARTAO');
  tFCR_FATURAI := TcDatasetUnf.getEntidade('FCR_FATURAI');
  tFGR_LIQ := TcDatasetUnf.getEntidade('FGR_LIQ');
  tFGR_PORTEMPRE := TcDatasetUnf.getEntidade('FGR_PORTEMPRE');
  tNR_PARCELAS := TcDatasetUnf.getEntidade('NR_PARCELAS');
end;

//----------------------------------------------------------
function T_FCRSVCO005.geraCartao(pParams : String) : String;
//----------------------------------------------------------
const
  cDS_METHOD = 'ADICONAL=Operação: T_FCRSVCO005.geraCartao()';
var
  (* string piGlobal :IN *)
  vCdEmpresa, vPortador, vNrVenctoCliente, vCdTipoCampo, vValor, vCdCliente, vPrTaxa : Real;
  vDsLinha, viParams, voParams, vDsRegFatI, vDsFaturaI : String;
  vDsOrigem, vDsDestino, vCliente, vDsCampo, vparams : String;
  vLista, vRegistro, vDsRegistro, vDs : String;
  lstVencto, listaVencimento, vLstCampo, viParams, voParams : String;
  vInNaoGravFat, vInGeraFaturaOperadora, vInProprio, vInGeraFaturaOp : Boolean;
begin
  getParams(pParams); (* itemXmlF('CD_EMPRESA', piGlobal) *)
  if (xStatus < 0) then begin
    Result := voParams;
    return(-1); exit;
  end;

  clear_e(tFCR_FATURAI);
  clear_e(tF_FCR_FATURAI);
  clear_e(tFGR_LIQ);
  clear_e(tFGR_PORTEMPRE);

  vInNaoGravFat := itemXmlB('IN_NAOGRAVAFAT', pParams);
  vPortador := itemXmlF('NR_PORTADOR', pParams);
  vDsRegFatI := itemXml('DS_LSTFATURA', pParams);
  vDsOrigem := vDsRegFatI;

  if (vDsRegFatI <> '') then begin
    repeat
      getitem(vDsFaturaI, vDsRegFatI, 1);

      creocc(tFCR_FATURAI, -1);
      getlistitensocc_e(vDsFaturaI, tFCR_FATURAI);

      vCdEmpresa := item_f('CD_EMPRESA', tFCR_FATURAI);
      clear_e(tFGR_PORTEMPRE);
      putitem_e(tFGR_PORTEMPRE, 'CD_EMPRESA', vCdEmpresa);
      putitem_e(tFGR_PORTEMPRE, 'NR_PORTADOR', vPortador);
      retrieve_e(tFGR_PORTEMPRE);
      if (xStatus < 0) then begin
        Result := SetStatus(STS_ERROR, 'GEN0001', 'Não existe um cliente vinculado ao portador ' + vPortador!', + ' cDS_METHOD);
        return(-1); exit;
      end;

      creocc(tF_FCR_FATURAI, -1);
      getlistitensocc_e(vDsFaturaI, tF_FCR_FATURAI);
      putitem_e(tF_FCR_FATURAI, 'CD_CLIENTE', item_f('CD_PESSOA', tFGR_PORTEMPRE));
      putitem_e(tF_FCR_FATURAI, 'NR_FAT', item_f('NR_FAT', tFCR_FATURAI));
      putitem_e(tF_FCR_FATURAI, 'NR_PARCELA', '');
      putitem_e(tF_FCR_FATURAI, 'TP_BAIXA', 0);

      if (item_f('TP_DOCUMENTO', tF_FCR_FATURAI) = 4)  or (item_f('TP_DOCUMENTO', tF_FCR_FATURAI) = 5) then begin
        if  (putitem_e(tF_FCR_FATURAI, 'TP_DOCUMENTO', 4)  and (gInCartaoCreditoPrazo, True)  or
          (putitem_e(tF_FCR_FATURAI, 'TP_DOCUMENTO', 5)  and (gInCartaoDebitoPrazo, True));

          if (item_f('TP_FATURAMENTO', tF_FCR_FATURAI) = 1) then begin
            putitem_e(tF_FCR_FATURAI, 'TP_FATURAMENTO', 2);
            putitem_e(tFCR_FATURAI, 'TP_FATURAMENTO', 2);
          end;
          if (item_f('TP_FATURAMENTO', tF_FCR_FATURAI) = 3) then begin
            putitem_e(tF_FCR_FATURAI, 'TP_FATURAMENTO', 4);
            putitem_e(tFCR_FATURAI, 'TP_FATURAMENTO', 4);
          end;
        end else begin
        end;
      end;

      delitem(vDsRegFatI, 1);
    until (vDsRegFatI = '');
  end;
  if (vInNaoGravFat <> True) then begin
    vDsOrigem := '';
    if (empty(tFCR_FATURAI) = False) then begin
      setocc(tFCR_FATURAI, 1);
      while (xStatus >= 0) do begin
        viParams := '';
        putlistitensocc_e(vDsLinha, tFCR_FATURAI);
        putitemXml(viParams, 'DS_FATURAI', vDsLinha);
        putitemXml(viParams, 'IN_ALTSOFATURAI', False);
        if (item_a('DS_FATCOMISSAO', tFCR_FATURAI) = '') then begin
          putitemXml(viParams, 'IN_SEMCOMISSAO', True);
        end else begin
          putitemXml(viParams, 'IN_SEMCOMISSAO', False);
        end;
        putitemXml(viParams, 'IN_SEMIMPOSTO', True);
        putitemXml(viParams, 'CD_COMPONENTE', FCRSVCO005);
        voParams := activateCmp('FCRSVCO001', 'geraFatura', viParams);
        if (xStatus < 0) then begin
          Result := voParams;
          return(-1); exit;
        end;
        putitem_e(tFCR_FATURAI, 'NR_PARCELA', itemXmlF('NR_PARCELA', voParams));
        putitem(vDsOrigem,  voParams);

        setocc(tFCR_FATURAI, curocc(tFCR_FATURAI) + 1);
      end;
    end;
  end;

  if not (empty(tF_FCR_FATURAI)) then begin
    setocc(tF_FCR_FATURAI, 1);
    vValor := 0;
    while (xStatus >= 0) do begin
      vValor := vValor + item_f('VL_FATURA', tF_FCR_FATURAI);

      setocc(tF_FCR_FATURAI, curocc(tF_FCR_FATURAI) + 1);
    end;

    setocc(tF_FCR_FATURAI, 1);

    vNrVenctoCliente := 0;

    if (itemXml('CD_CARTAO', pParams) > 0) then begin
      clear_e(tCTC_TPCARPAR);
      putitem_e(tCTC_TPCARPAR, 'TP_DOCUMENTO', item_f('TP_DOCUMENTO', tF_FCR_FATURAI));
      putitem_e(tCTC_TPCARPAR, 'NR_SEQHISTRELSUB', item_f('NR_HISTRELSUB', tF_FCR_FATURAI));
      retrieve_e(tCTC_TPCARPAR);
      if (xStatus >= 0) then begin
        clear_e(tCTC_CARTAO);
        putitem_e(tCTC_CARTAO, 'CD_CARTAO', itemXmlF('CD_CARTAO', pParams));
        retrieve_e(tCTC_CARTAO);
        if (xStatus >= 0) then begin
          vNrVenctoCliente := item_f('NR_DIAVENCTO', tCTC_CARTAO);
        end else begin
          Result := SetStatus(STS_ERROR, 'GEN0001', 'Não existe cartão informado para este processo!', cDS_METHOD);
          return(-1); exit;
        end;
        clear_e(tCTC_CARTAO);
      end;
      clear_e(tCTC_TPCARPAR);
    end;
    if (gCdTipoCampoDiaVenctoCl <> '')  and (vNrVenctoCliente = 0) then begin
      viParams := '';
      putitemXml(viParams, 'CD_PESSOA', item_f('CD_CLIENTE', tF_FCR_FATURAI));
      voParams := activateCmp('PESSVCO022', 'buscaCampoAdicional', viParams);
      if (xStatus < 0) then begin
        Result := voParams;
        return(-1); exit;
      end;
      if (itemXml('DS_LSTCAMPO', voParams) <> '') then begin
        vLstCampo := itemXml('DS_LSTCAMPO', voParams);
        repeat
          getitem(vDsRegistro, vLstCampo, 1);
          vCdTipoCampo := itemXmlF('CD_TIPOCAMPO', vDsRegistro);
          if (vCdTipoCampo = gCdTipoCampoDiaVenctoCl) then begin
            vNrVenctoCliente := itemXml('DS_CAMPO', vDsRegistro);
          end;

          delitem(vLstCampo, 1);
        until(vLstCampo = '');
      end;
    end;

    viParams := '';
    putitemXml(viParams, 'CD_EMPRESA', itemXmlF('CD_EMPRESA', piGlobal));
    putitemXml(viParams, 'CD_PORTADOR', vPortador);
    putitemXml(viParams, 'DT_VendA', item_a('DT_VENCIMENTO', tF_FCR_FATURAI));
    putitemXml(viParams, NR_PARCELAS, totocc(t'F_FCR_FATURAISVC'));
    putitemXml(viParams, 'NR_VECTOCLIENTE', vNrVenctoCliente);
    putitemXml(viParams, 'TP_DOCUMENTO', item_f('TP_DOCUMENTO', tF_FCR_FATURAI));
    putitemXml(viParams, 'NR_SEQHISTRELSUB', item_f('NR_HISTRELSUB', tF_FCR_FATURAI));
    putitemXml(viParams, 'IN_FATURAMENTO', itemXmlB('IN_FATURAMENTO', pParams));

    voParams := activateCmp('FGRSVCO006', 'vencimentoParcelas', viParams);
    if (xStatus < 0) then begin
      Result := voParams;
      return(-1); exit;
    end;
    if (voParams <> '') then begin
      lstVencto := voParams;
      vPrTaxa := itemXmlF('PR_TAXA', voParams);

      getitem(vDs, lstVencto, 1);
      vInProprio := itemXmlB('IN_PROPRIO', vDs);
      vInGeraFaturaOp := itemXmlB('IN_GERAFATOP', vDs);

    end;

    vInGeraFaturaOperadora := True;
    if (vInProprio = True)  and (vInGeraFaturaOp = False) then begin
      vInGeraFaturaOperadora := False;
    end;
    if (vInGeraFaturaOperadora = True) then begin
      while (xStatus >= 0) do begin

        getitem(listaVencimento, lstVencto, 1);

        setocc(tFCR_FATURAI, 1);

        putitem_e(tF_FCR_FATURAI, 'DT_VENCIMENTO', itemXml('DT_VENCIMENTO', listaVencimento));
        putitem_e(tF_FCR_FATURAI, 'TP_COBRANCA', 14);
        if  (putitem_e(tF_FCR_FATURAI, 'TP_DOCUMENTO', 4)  and (gInCartaoCreditoPrazo, True)  or
          (putitem_e(tF_FCR_FATURAI, 'TP_DOCUMENTO', 5)  and (gInCartaoDebitoPrazo, True));

          if (item_f('TP_FATURAMENTO', tF_FCR_FATURAI) = 1) then begin
            putitem_e(tF_FCR_FATURAI, 'TP_FATURAMENTO', 2);
            putitem_e(tFCR_FATURAI, 'TP_FATURAMENTO', 2);
          end;
          if (item_f('TP_FATURAMENTO', tF_FCR_FATURAI) = 3) then begin
            putitem_e(tF_FCR_FATURAI, 'TP_FATURAMENTO', 4);
            putitem_e(tFCR_FATURAI, 'TP_FATURAMENTO', 4);
          end;
        end;

        delitem(lstVencto, 1);

        viParams := '';
        putlistitensocc_e(vDsLinha, tF_FCR_FATURAI);
        putitemXml(viParams, 'DS_FATURAI', vDsLinha);
        putitemXml(viParams, 'IN_ALTSOFATURAI', False);
        putitemXml(viParams, 'IN_SEMCOMISSAO', True);
        putitemXml(viParams, 'IN_SEMIMPOSTO', True);
        putitemXml(viParams, 'CD_COMPONENTE', FCRSVCO005);

        voParams := activateCmp('FCRSVCO001', 'geraFatura', viParams);
        if (xStatus < 0) then begin
          Result := voParams;
          return(-1); exit;
        end;

        putitem(vDsDestino,  voParams);

        viParams := '';
        putitemXml(viParams, 'CD_EMPRESA', item_f('CD_EMPRESA', tF_FCR_FATURAI));
        putitemXml(viParams, 'CD_CLIENTE', item_f('CD_CLIENTE', tF_FCR_FATURAI));
        putitemXml(viParams, 'NR_FAT', item_f('NR_FAT', tF_FCR_FATURAI));
        putitemXml(viParams, 'NR_PARCELA', itemXmlF('NR_PARCELA', voParams));
        putitemXml(viParams, 'TP_CARTAO', 1);
        putitemXml(viParams, 'CD_CARTAO', '');
        putitemXml(viParams, 'NR_SEQCARTAO', '');
        putitemXml(viParams, 'CD_AUTORIZACAO', itemXmlF('CD_AUTORIZACAO', pParams));
        putitemXml(viParams, 'NR_NSU', itemXmlF('NR_NSU', pParams));
        putitemXml(viParams, 'DT_COMPRA', item_a('DT_EMISSAO', tFCR_FATURAI));
        putitemXml(viParams, 'VL_COMPRA', vValor);
        putitemXml(viParams, NR_PARCELAS, totocc(t'F_FCR_FATURAISVC'));
        putitemXml(viParams, 'NR_NF', itemXmlF('NR_NF', pParams));
        putitemXml(viParams, 'CD_EMPORI', item_f('CD_EMPRESA', tFCR_FATURAI));
        putitemXml(viParams, 'CD_CLIORI', item_f('CD_CLIENTE', tFCR_FATURAI));
        putitemXml(viParams, 'NR_FATORI', item_f('NR_FAT', tFCR_FATURAI));
        putitemXml(viParams, 'NR_PARORI', item_f('NR_PARCELA', tFCR_FATURAI));
        putitemXml(viParams, 'PR_TAXA', vPrTaxa);

        voParams := geraComplCartao(viParams); (* piGlobal, viParams, voParams, xCdErro, xCtxErro *)
        if (xStatus < 0) then begin
          Result := voParams;
          return(-1); exit;
        end;

        setocc(tF_FCR_FATURAI, curocc(tF_FCR_FATURAI) + 1);
      end;
    end else begin

      vDsLinha := '';

      clear_e(tF_FCR_FATURAI);

      setocc(tFCR_FATURAI, 1);
        while (xStatus >= 0) do begin

        getitem(listaVencimento, lstVencto, 1);
        putitem_e(tFCR_FATURAI, 'DT_VENCIMENTO', itemXml('DT_VENCIMENTO', listaVencimento));
        putitem_e(tFCR_FATURAI, 'TP_COBRANCA', 0);
        putitem_e(tFCR_FATURAI, 'TP_DOCUMENTO', 1);
        putitem_e(tFCR_FATURAI, 'TP_BAIXA', 0);
        if (itemXml('CD_CARTAO', pParams) > 0) then begin
          putitem_e(tFCR_FATURAI, 'NR_RESUMOCARTAO', itemXmlF('CD_CARTAO', pParams));
          putitem_e(tFCR_FATURAI, 'DS_RESUMOCARTAO', 'PROPRIO');
                  if (item_f('TP_FATURAMENTO', tFCR_FATURAI) = 1) then begin
            putitem_e(tFCR_FATURAI, 'TP_FATURAMENTO', 2);
          end;
          if (item_f('TP_FATURAMENTO', tFCR_FATURAI) = 3) then begin
            putitem_e(tFCR_FATURAI, 'TP_FATURAMENTO', 4);
          end;
        end;
        putlistitensocc_e(vdsLinha, tFCR_FATURAI);

        delitem(lstVencto, 1);

        viParams := '';
        putitemXml(viParams, 'DS_FATURAI', vDsLinha);
        putitemXml(viParams, 'IN_ALTSOFATURAI', True);
        putitemXml(viParams, 'IN_SEMCOMISSAO', True);
        putitemXml(viParams, 'IN_SEMIMPOSTO', True);
        putitemXml(viParams, 'CD_COMPONENTE', FCRSVCO005);
        voParams := activateCmp('FCRSVCO001', 'geraFatura', viParams);
        if (xStatus < 0) then begin
          Result := voParams;
          return(-1); exit;
        end;

        viParams := '';
        putitemXml(viParams, 'CD_EMPRESA', item_f('CD_EMPRESA', tFCR_FATURAI));
        putitemXml(viParams, 'CD_CLIENTE', item_f('CD_CLIENTE', tFCR_FATURAI));
        putitemXml(viParams, 'NR_FAT', item_f('NR_FAT', tFCR_FATURAI));
        putitemXml(viParams, 'NR_PARCELA', item_f('NR_PARCELA', tFCR_FATURAI));

        if (itemXml('CD_CARTAO', pParams) > 0) then begin
          putitemXml(viParams, 'TP_CARTAO', 2);
          putitemXml(viParams, 'CD_CARTAO', itemXmlF('CD_CARTAO', pParams));
          putitemXml(viParams, 'NR_SEQCARTAO', itemXmlF('NR_SEQCARTAO', pParams));
        end else begin
          putitemXml(viParams, 'TP_CARTAO', 1);
          putitemXml(viParams, 'CD_CARTAO', '');
          putitemXml(viParams, 'NR_SEQCARTAO', '');
        end;
        putitemXml(viParams, 'CD_AUTORIZACAO', itemXmlF('CD_AUTORIZACAO', pParams));
        putitemXml(viParams, 'NR_NSU', itemXmlF('NR_NSU', pParams));
        putitemXml(viParams, 'DT_COMPRA', item_a('DT_EMISSAO', tFCR_FATURAI));
        putitemXml(viParams, 'VL_COMPRA', vValor);
        putitemXml(viParams, NR_PARCELAS, totocc(t'FCR_FATURAISVC'));
        putitemXml(viParams, 'NR_NF', itemXmlF('NR_NF', pParams));
        putitemXml(viParams, 'CD_EMPORI', '');
        putitemXml(viParams, 'CD_CLIORI', '');
        putitemXml(viParams, 'NR_FATORI', '');
        putitemXml(viParams, 'NR_PARORI', '');
        putitemXml(viParams, 'PR_TAXA', vPrTaxa);

        voParams := geraComplCartao(viParams); (* piGlobal, viParams, voParams, xCdErro, xCtxErro *)
        if (xStatus < 0) then begin
          Result := voParams;
          return(-1); exit;
        end;

        setocc(tFCR_FATURAI, curocc(tFCR_FATURAI) + 1);

      end;
    end;
  end;
    if (vInGeraFaturaOperadora = True) then begin
        viParams := '';
        putitemXml(viParams, 'DS_ORIGEM', vDsOrigem);
        putitemXml(viParams, 'DS_DESTINO', vDsDestino);
        voParams := activateCmp('FGRSVCO005', 'geraLiquidacao', viParams);
        if (xStatus < 0) then begin
          Result := voParams;
          return(-1); exit;
        end;
    end;

  Result := '';
  putitemXml(Result, 'DS_LSTFATURA', vDsOrigem);

  return(0); exit;
end;

//---------------------------------------------------------------
function T_FCRSVCO005.geraComplCartao(pParams : String) : String;
//---------------------------------------------------------------
const
  cDS_METHOD = 'ADICONAL=Operação: T_FCRSVCO005.geraComplCartao()';
var
  (* string piGlobal :IN *)
  viParams, voParams, vDsFatCartao : String;
  vCdEmpresa, vCdCliente, vNrFatura, vNrParcela, vNrNf : Real;
begin
  vDsFatCartao := itemXml('DS_FATCARTAO', pParams);

  if (vDsFatCartao <> '') then begin
    vCdEmpresa := itemXmlF('CD_EMPRESA', vDsFatCartao);
    vCdCliente := itemXmlF('CD_CLIENTE', vDsFatCartao);
    vNrFatura := itemXmlF('NR_FAT', vDsFatCartao);
    vNrParcela := itemXmlF('NR_PARCELA', vDsFatCartao);
  end else begin
    vCdEmpresa := itemXmlF('CD_EMPRESA', pParams);
    if (itemXml('CD_EMPRESA', pParams) = '') then begin
      Result := SetStatus(STS_ERROR, 'GEN001', , cDS_METHOD);
      return(-1); exit;
    end;
    vCdCliente := itemXmlF('CD_CLIENTE', pParams);
    if (itemXml('CD_CLIENTE', pParams) = '') then begin
      Result := SetStatus(STS_ERROR, 'GEN001', , cDS_METHOD);
      return(-1); exit;
    end;
    vNrFatura := itemXmlF('NR_FAT', pParams);
    if (itemXml('NR_FAT', pParams) = '') then begin
      Result := SetStatus(STS_ERROR, 'GEN001', , cDS_METHOD);
      return(-1); exit;
    end;
    vNrParcela := itemXmlF('NR_PARCELA', pParams);
    if (itemXml('NR_PARCELA', pParams) = '') then begin
      Result := SetStatus(STS_ERROR, 'GEN001', , cDS_METHOD);
      return(-1); exit;
    end;
  end;

  creocc(tFCR_FATCARTAO, -1);
  putitem_e(tFCR_FATCARTAO, 'CD_EMPRESA', vCdEmpresa);
  putitem_e(tFCR_FATCARTAO, 'CD_CLIENTE', vCdCliente);
  putitem_e(tFCR_FATCARTAO, 'NR_FAT', vNrFatura);
  putitem_e(tFCR_FATCARTAO, 'NR_PARCELA', vNrParcela);
  retrieve_o(tFCR_FATCARTAO);
  if (xStatus = 4)  or (xStatus = -7) then begin
    retrieve_x(tFCR_FATCARTAO);
  end;
  if (vDsFatCartao <> '') then begin
    getlistitensocc_e(vDsFatCartao, tFCR_FATCARTAO);
  end else begin
    putitem_e(tFCR_FATCARTAO, 'TP_CARTAO', itemXmlF('TP_CARTAO', pParams));
    if (item_f('TP_CARTAO', tFCR_FATCARTAO) = '') then begin
      putitem_e(tFCR_FATCARTAO, 'TP_CARTAO', 1);
    end;
    putitem_e(tFCR_FATCARTAO, 'CD_CARTAO', itemXmlF('CD_CARTAO', pParams));
    putitem_e(tFCR_FATCARTAO, 'NR_SEQCARTAO', itemXmlF('NR_SEQCARTAO', pParams));
    putitem_e(tFCR_FATCARTAO, 'CD_AUTORIZACAO', itemXmlF('CD_AUTORIZACAO', pParams));
    putitem_e(tFCR_FATCARTAO, 'NR_NSU', itemXmlF('NR_NSU', pParams));
    putitem_e(tFCR_FATCARTAO, 'DT_COMPRA', itemXml('DT_COMPRA', pParams));
    putitem_e(tFCR_FATCARTAO, 'VL_COMPRA', itemXmlF('VL_COMPRA', pParams));
    putitem_e(tFCR_FATCARTAO, 'NR_PARCELAS', itemXmlF('NR_PARCELAS', pParams));
    putitem_e(tFCR_FATCARTAO, 'NR_NF', itemXmlF('NR_NF', pParams));
    putitem_e(tFCR_FATCARTAO, 'CD_EMPORI', itemXmlF('CD_EMPORI', pParams));
    putitem_e(tFCR_FATCARTAO, 'CD_CLIORI', itemXmlF('CD_CLIORI', pParams));
    putitem_e(tFCR_FATCARTAO, 'NR_FATORI', itemXmlF('NR_FATORI', pParams));
    putitem_e(tFCR_FATCARTAO, 'NR_PARORI', itemXmlF('NR_PARORI', pParams));
    putitem_e(tFCR_FATCARTAO, 'PR_TAXAADM', itemXmlF('PR_TAXA', pParams));
  end;
  putitem_e(tFCR_FATCARTAO, 'CD_OPERADOR', itemXmlF('CD_USUARIO', piGlobal));
  putitem_e(tFCR_FATCARTAO, 'DT_CADASTRO', Now);

  voParams := tFCR_FATCARTAO.Salvar();
  if (xStatus < 0) then begin
    Result := voParams;
    return(-1); exit;
  end;

  return(0); exit;
end;

end.
