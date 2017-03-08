unit cSISVCO001;

interface

(* COMPONENTES 
  ADMSVCO001 / TRASVCO004 / TRASVCO010 / TRASVCO016 / 
*)        

uses
  Classes, SysUtils, DB,
  cServiceUnf, cDataSetUnf;

type
  T_SISVCO001 = class(TcServiceUnf)
  private
    tF_PED_PEDIDOT,
    tF_TRA_REMDES,
    tF_TRA_VENCIME,
    tFIS_NF,
    tFIS_NFCCORR,
    tFIS_NFECF,
    tFIS_NFIMPOSTO,
    tFIS_NFITEM,
    tFIS_NFITEMDEV,
    tFIS_NFITEMIMP,
    tFIS_NFITEMPRO,
    tFIS_NFITEMVL,
    tFIS_NFREMDES,
    tFIS_NFTRANSP,
    tFIS_NFVENCTO,
    tGER_EMPRESA,
    tPED_PEDIDOCAD,
    tPED_PEDIDOTRA,
    tPES_PREFFORNE,
    tPRD_PRDINFO,
    tPRD_PRODUTOFO,
    tTRA_ITEMCC,
    tTRA_ITEMIMPOS,
    tTRA_ITEMVL,
    tTRA_LIBERACAO,
    tTRA_REMDES,
    tTRA_S_TRANSAC,
    tTRA_S_TRANSIT,
    tTRA_TRAIMPOST,
    tTRA_TRANSACAO,
    tTRA_TRANSACEC,
    tTRA_TRANSAGRU,
    tTRA_TRANSITEM,
    tTRA_TRANSPORT,
    tTRA_TROCA,
    tTRA_VENCIMENT : TcDatasetUnf;
    function getParam(pParams : String = '') : String;
    function setEntidade(pParams : String = '') : String;
  protected
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;    
  published
    function validaDesconto(pParams : String = '') : String;
    function descontoPromocional(pParams : String = '') : String;
    function validaParcelamento(pParams : String = '') : String;
    function validaAgrupamento(pParams : String = '') : String;
    function validaItemAgrupamento(pParams : String = '') : String;
  end;

implementation

uses
  cADMSVCO001,
  cActivate, cStatus, cFuncao, cXml, dModulo;

var
  gInDescontoPromocional,
  gInSimuladorCondPgto,
  gInSimuladorProduto,
  gprEncFinAbatImpPed,
  greplace(,
  gTpAgrupamento,
  gTpDesconto,
  gTpSimuladorFat,
  gVlDiferenca : String;

//---------------------------------------------------------------
constructor T_SISVCO001.Create(AOwner: TComponent);
//---------------------------------------------------------------
begin
  inherited Create(AOwner);
  setEntidade('');
end;

//--------------------------------
destructor T_SISVCO001.Destroy;
//--------------------------------
begin
  inherited Destroy;
end;

//---------------------------------------------------------------
function T_SISVCO001.getParam(pParams : String = '') : String;
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
  putitem(xParamEmp, 'IN_SIMULADOR_COND_PGTO');
  putitem(xParamEmp, 'IN_SIMULADOR_FAT_PRODUTO');
  putitem(xParamEmp, 'IN_VALOR_PROMOCIONAL');
  putitem(xParamEmp, 'PR_ENC_FIN_ABAT_IMP_PED');
  putitem(xParamEmp, 'TP_AGRUPAMENTO_ITEM_VD');
  putitem(xParamEmp, 'TP_SIMULADOR_FAT');

  xParamEmp := T_ADMSVCO001.GetParamEmpresa(piCdEmpresa, xParamEmp);

  gInDescontoPromocional := itemXml('IN_VALOR_PROMOCIONAL', xParamEmp);
  gInSimuladorCondPgto := itemXml('IN_SIMULADOR_COND_PGTO', xParamEmp);
  gInSimuladorProduto := itemXml('IN_SIMULADOR_FAT_PRODUTO', xParamEmp);
  gprEncFinAbatImpPed := itemXml('PR_ENC_FIN_ABAT_IMP_PED', xParamEmp);
  gTpAgrupamento := itemXml('TP_AGRUPAMENTO_ITEM_VD', xParamEmp);
  gTpSimuladorFat := itemXml('TP_SIMULADOR_FAT', xParamEmp);

end;

//---------------------------------------------------------------
function T_SISVCO001.setEntidade(pParams : String = '') : String;
//---------------------------------------------------------------
begin
  tF_PED_PEDIDOT := GetEntidade('F_PED_PEDIDOT');
  tF_TRA_REMDES := GetEntidade('F_TRA_REMDES');
  tF_TRA_VENCIME := GetEntidade('F_TRA_VENCIME');
  tFIS_NF := GetEntidade('FIS_NF');
  tFIS_NFCCORR := GetEntidade('FIS_NFCCORR');
  tFIS_NFECF := GetEntidade('FIS_NFECF');
  tFIS_NFIMPOSTO := GetEntidade('FIS_NFIMPOSTO');
  tFIS_NFITEM := GetEntidade('FIS_NFITEM');
  tFIS_NFITEMDEV := GetEntidade('FIS_NFITEMDEV');
  tFIS_NFITEMIMP := GetEntidade('FIS_NFITEMIMP');
  tFIS_NFITEMPRO := GetEntidade('FIS_NFITEMPRO');
  tFIS_NFITEMVL := GetEntidade('FIS_NFITEMVL');
  tFIS_NFREMDES := GetEntidade('FIS_NFREMDES');
  tFIS_NFTRANSP := GetEntidade('FIS_NFTRANSP');
  tFIS_NFVENCTO := GetEntidade('FIS_NFVENCTO');
  tGER_EMPRESA := GetEntidade('GER_EMPRESA');
  tPED_PEDIDOCAD := GetEntidade('PED_PEDIDOCAD');
  tPED_PEDIDOTRA := GetEntidade('PED_PEDIDOTRA');
  tPES_PREFFORNE := GetEntidade('PES_PREFFORNE');
  tPRD_PRDINFO := GetEntidade('PRD_PRDINFO');
  tPRD_PRODUTOFO := GetEntidade('PRD_PRODUTOFO');
  tTRA_ITEMCC := GetEntidade('TRA_ITEMCC');
  tTRA_ITEMIMPOS := GetEntidade('TRA_ITEMIMPOS');
  tTRA_ITEMVL := GetEntidade('TRA_ITEMVL');
  tTRA_LIBERACAO := GetEntidade('TRA_LIBERACAO');
  tTRA_REMDES := GetEntidade('TRA_REMDES');
  tTRA_S_TRANSAC := GetEntidade('TRA_S_TRANSAC');
  tTRA_S_TRANSIT := GetEntidade('TRA_S_TRANSIT');
  tTRA_TRAIMPOST := GetEntidade('TRA_TRAIMPOST');
  tTRA_TRANSACAO := GetEntidade('TRA_TRANSACAO');
  tTRA_TRANSACEC := GetEntidade('TRA_TRANSACEC');
  tTRA_TRANSAGRU := GetEntidade('TRA_TRANSAGRU');
  tTRA_TRANSITEM := GetEntidade('TRA_TRANSITEM');
  tTRA_TRANSPORT := GetEntidade('TRA_TRANSPORT');
  tTRA_TROCA := GetEntidade('TRA_TROCA');
  tTRA_VENCIMENT := GetEntidade('TRA_VENCIMENT');
end;

//-------------------------------------------------------------
function T_SISVCO001.validaDesconto(pParams : String) : String;
//-------------------------------------------------------------
const
  cDS_METHOD = 'ADICIONAL=Operação: T_SISVCO001.validaDesconto()';
var
  vCdEmpresa, vNrTransacao, vNrDias, vVlValor, vQtCalc : Real;
  vNrDivisor, vVlRestoEmp, vVlRestoCC, vNrFator, vVlTotalAnt, vCdEmpresaAux : Real;
  vVlMaior, vNrItemMaior, vNrItem : Real;
  vDsRegistro, vDsLstTransacao, vDsLstTra, vDsLstVencimento, vDsObservacao : String;
  viParams, voParams, vDsSalvaRegistro : String;
  vDtTransacao : TDate;
  vInFracionado, vInDesconto : Boolean;
  vVlDespAcessor : Real;
begin
  vInDesconto := False;

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
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Data da transação não informado!', cDS_METHOD);
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

  getParams(pParams); (* item_f('CD_EMPFAT', tTRA_TRANSACAO) *)
  if (xStatus < 0) then begin
    return(-1); exit;
  end;
  if (empty(tPED_PEDIDOTRA) = False) then begin
    vCdEmpresaAux := 0;
    vDsLstTransacao := '';
    vDsRegistro := '';
    putitemXml(vDsRegistro, 'CD_EMPRESA', item_f('CD_EMPRESA', tTRA_TRANSACAO));
    putitemXml(vDsRegistro, 'NR_TRANSACAO', item_f('NR_TRANSACAO', tTRA_TRANSACAO));
    putitemXml(vDsRegistro, 'DT_TRANSACAO', item_a('DT_TRANSACAO', tTRA_TRANSACAO));
    putitem(vDsLstTransacao,  vDsRegistro);

    clear_e(tGER_EMPRESA);
    putitem_e(tGER_EMPRESA, 'CD_EMPRESA', vCdEmpresa);
    retrieve_e(tGER_EMPRESA);
    if (xStatus >= 0) then begin
      if (item_f('CD_CCUSTO', tGER_EMPRESA) > 0) then begin
        vCdEmpresaAux := item_f('CD_CCUSTO', tGER_EMPRESA);
      end else begin
        clear_e(tGER_EMPRESA);
        putitem_e(tGER_EMPRESA, 'CD_CCUSTO', vCdEmpresa);
        retrieve_e(tGER_EMPRESA);
        if (xStatus >= 0) then begin
          vCdEmpresaAux := item_f('CD_EMPRESA', tGER_EMPRESA);
        end;
      end;
    end;
    if (vCdEmpresaAux > 0) then begin
      clear_e(tTRA_S_TRANSAC);
      putitem_e(tTRA_S_TRANSAC, 'CD_EMPRESA', vCdEmpresaAux);
      putitem_e(tTRA_S_TRANSAC, 'NR_TRANSACAO', item_f('NR_TRANSACAO', tTRA_TRANSACAO));
      putitem_e(tTRA_S_TRANSAC, 'DT_TRANSACAO', item_a('DT_TRANSACAO', tTRA_TRANSACAO));
      retrieve_e(tTRA_S_TRANSAC);
      if (xStatus >= 0) then begin
        if (gTpAgrupamento = 1) then begin
          viParams := '';
          putitemXml(viParams, 'CD_EMPRESA', item_f('CD_EMPRESA', tTRA_S_TRANSAC));
          putitemXml(viParams, 'NR_TRANSACAO', item_f('NR_TRANSACAO', tTRA_S_TRANSAC));
          putitemXml(viParams, 'DT_TRANSACAO', item_a('DT_TRANSACAO', tTRA_S_TRANSAC));
          putitemXml(viParams, 'IN_AGRUPA', False);
          voParams := activateCmp('TRASVCO010', 'agrupaItemTransacao', viParams); (*,,,, *)
          if (xStatus < 0) then begin
            Result := voParams;
            return(-1); exit;
          end;
        end;
        viParams := '';
        putitemXml(viParams, 'CD_EMPRESA', item_f('CD_EMPRESA', tTRA_S_TRANSAC));
        putitemXml(viParams, 'NR_TRANSACAO', item_f('NR_TRANSACAO', tTRA_S_TRANSAC));
        putitemXml(viParams, 'DT_TRANSACAO', item_a('DT_TRANSACAO', tTRA_S_TRANSAC));
        voParams := activateCmp('TRASVCO004', 'gravaenderecoTransacao', viParams); (*,,,, *)
        if (xStatus < 0) then begin
          Result := voParams;
          return(-1); exit;
        end;
        viParams := '';
        putitemXml(viParams, 'CD_EMPRESA', item_f('CD_EMPRESA', tTRA_S_TRANSAC));
        putitemXml(viParams, 'NR_TRANSACAO', item_f('NR_TRANSACAO', tTRA_S_TRANSAC));
        putitemXml(viParams, 'DT_TRANSACAO', item_a('DT_TRANSACAO', tTRA_S_TRANSAC));

        voParams := activateCmp('TRASVCO004', 'gravaParcelaTransacao', viParams); (*,,,, *)
        if (xStatus < 0) then begin
          Result := voParams;
          return(-1); exit;
        end;

        vDsRegistro := '';
        putitemXml(vDsRegistro, 'CD_EMPRESA', item_f('CD_EMPRESA', tTRA_S_TRANSAC));
        putitemXml(vDsRegistro, 'NR_TRANSACAO', item_f('NR_TRANSACAO', tTRA_S_TRANSAC));
        putitemXml(vDsRegistro, 'DT_TRANSACAO', item_a('DT_TRANSACAO', tTRA_S_TRANSAC));
          putitem(vDsLstTransacao,  vDsRegistro);

        vInDesconto := True;
      end;
    end;

    clear_e(tPED_PEDIDOCAD);
    putitem_e(tPED_PEDIDOCAD, 'CD_EMPRESA', item_f('CD_EMPPEDIDO', tPED_PEDIDOTRA));
    putitem_e(tPED_PEDIDOCAD, 'CD_PEDIDO', item_f('CD_PEDIDO', tPED_PEDIDOTRA));
    retrieve_e(tPED_PEDIDOCAD);
    if (xStatus >= 0) then begin
      if (item_f('NR_DIAPREVENTREGA', tPED_PEDIDOCAD) = 0) then begin
        Result := '';
        putitemXml(Result, 'DS_LSTTRANSACAO', vDsLstTransacao);
        putitemXml(Result, 'IN_DESCONTO', vInDesconto);

        return(0); exit;
      end;
    end;
  end;

  vVlTotalAnt := item_f('VL_TRANSACAO', tTRA_TRANSACAO);

  if (item_b('IN_ACEITADEV', tTRA_TRANSACAO) = False) then begin
    gTpDesconto := 'Q';
  end else begin
    gTpDesconto := 'V';
  end;

  Result := '';
  vDsLstTransacao := '';
  vDsRegistro := '';
  putitemXml(vDsRegistro, 'CD_EMPRESA', item_f('CD_EMPRESA', tTRA_TRANSACAO));
  putitemXml(vDsRegistro, 'NR_TRANSACAO', item_f('NR_TRANSACAO', tTRA_TRANSACAO));
  putitemXml(vDsRegistro, 'DT_TRANSACAO', item_a('DT_TRANSACAO', tTRA_TRANSACAO));
  putitem(vDsLstTransacao,  vDsRegistro);
  putitemXml(Result, 'DS_LSTTRANSACAO', vDsLstTransacao);
  putitemXml(Result, 'IN_DESCONTO', vInDesconto);

  if (item_a('DT_PREVENTREGA', tTRA_TRANSACAO) = '') then begin
    return(0); exit;
  end;

  vNrDias := item_a('DT_PREVENTREGA', tTRA_TRANSACAO) - item_a('DT_TRANSACAO', tTRA_TRANSACAO);
  if (vNrDias <= 0)  or (vNrDias > 100) then begin
    return(0); exit;
  end;
  if (empty(tFIS_NF) = False)  and (vNrDias <> 100) then begin
    return(0); exit;
  end;

  clear_e(tGER_EMPRESA);
  putitem_e(tGER_EMPRESA, 'CD_CCUSTO', vCdEmpresa);
  retrieve_e(tGER_EMPRESA);
  if (xStatus < 0) then begin
    return(0); exit;
  end;

  clear_e(tTRA_S_TRANSAC);
  putitem_e(tTRA_S_TRANSAC, 'CD_EMPRESAORI', item_f('CD_EMPRESA', tTRA_TRANSACAO));
  putitem_e(tTRA_S_TRANSAC, 'NR_TRANSACAOORI', item_f('NR_TRANSACAO', tTRA_TRANSACAO));
  putitem_e(tTRA_S_TRANSAC, 'DT_TRANSACAOORI', item_a('DT_TRANSACAO', tTRA_TRANSACAO));
  retrieve_e(tTRA_S_TRANSAC);
  if (xStatus >= 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Transação ' + CD_EMPRESA + '.TRA_TRANSACAO / ' + NR_TRANSACAO + '.TRA_TRANSACAO / ' + DT_TRANSACAO + '.TRA_TRANSACAO não pode ter valores de encargos financeiros, pois foi duplicado!', cDS_METHOD);
    return(-1); exit;
  end;

  clear_e(tTRA_S_TRANSAC);

  if (!empty('TRA_TRANSCONDSVC')) then begin
    if (vNrDias <> 100) then begin
      Result := SetStatus(STS_ERROR, 'GEN0001', 'Erro na validação de desconto para a simulação!', cDS_METHOD);
      return(-1); exit;
    end;
  end;
  if (vNrDias = 100) then begin
    if (empty(tTRA_TRANSITEM) = False) then begin
      setocc(tTRA_TRANSITEM, 1);
      while (xStatus >= 0) do begin
        clear_e(tPRD_PRODUTOFO);
        putitem_e(tPRD_PRODUTOFO, 'CD_PRODUTO', item_f('CD_PRODUTO', tTRA_TRANSITEM));
        retrieve_e(tPRD_PRODUTOFO);
        if (xStatus >= 0) then begin
          setocc(tPRD_PRODUTOFO, 1);
          setocc(tPES_PREFFORNE, 1);
          if (dbocc(t'PES_PREFFORNE')) then begin
            if (item_f('PR_QTCANCELAMENTO', tPES_PREFFORNE) <> '')  and (item_f('PR_QTCANCELAMENTO', tPES_PREFFORNE) < 100) then begin
              Result := SetStatus(STS_ERROR, 'GEN0001', 'Opção de desconto inválida para o produto/fornecedor ' + CD_PRODUTO + '.TRA_TRANSITEM / ' + CD_FORNECEDOR + '.PES_PREFFORNE da transação ' + FloatToStr(vNrTransacao) + '!', cDS_METHOD);
              return(-1); exit;
            end;
            if (item_f('PR_MARKUP', tPES_PREFFORNE) <> '')  and (item_f('PR_MARKUP', tPES_PREFFORNE) < 100) then begin
              Result := SetStatus(STS_ERROR, 'GEN0001', 'Opção de desconto inválida para o produto/fornecedor ' + CD_PRODUTO + '.TRA_TRANSITEM / ' + CD_FORNECEDOR + '.PES_PREFFORNE da transação ' + FloatToStr(vNrTransacao) + '!', cDS_METHOD);
              return(-1); exit;
            end;
          end;
        end;
        setocc(tTRA_TRANSITEM, curocc(tTRA_TRANSITEM) + 1);
      end;
    end;

    putitem_e(tTRA_TRANSACAO, 'CD_EMPFAT', item_f('CD_EMPRESA', tGER_EMPRESA));

    if (empty(tFIS_NF) = False) then begin
      setocc(tFIS_NF, 1);
      while (xStatus >= 0) do begin
        putitem_e(tFIS_NF, 'CD_EMPFAT', item_f('CD_EMPRESA', tGER_EMPRESA));

        if (empty(tFIS_NFITEM) = False) then begin
          setocc(tFIS_NFITEM, 1);
          while (xStatus >= 0) do begin
            putitem_e(tFIS_NFITEM, 'CD_EMPFAT', item_f('CD_EMPRESA', tGER_EMPRESA));

            if (empty(tFIS_NFITEMIMP) = False) then begin
              setocc(tFIS_NFITEMIMP, 1);
              while (xStatus >= 0) do begin
                putitem_e(tFIS_NFITEMIMP, 'CD_EMPFAT', item_f('CD_EMPRESA', tGER_EMPRESA));
                setocc(tFIS_NFITEMIMP, curocc(tFIS_NFITEMIMP) + 1);
              end;
            end;
            if (empty(tFIS_NFITEMPRO) = False) then begin
              setocc(tFIS_NFITEMPRO, 1);
              while (xStatus >= 0) do begin
                putitem_e(tFIS_NFITEMPRO, 'CD_EMPFAT', item_f('CD_EMPRESA', tGER_EMPRESA));

                if (empty(tFIS_NFITEMVL) = False) then begin
                  setocc(tFIS_NFITEMVL, 1);
                  while (xStatus >= 0) do begin
                    putitem_e(tFIS_NFITEMVL, 'CD_EMPFAT', item_f('CD_EMPRESA', tGER_EMPRESA));

                    setocc(tFIS_NFITEMVL, curocc(tFIS_NFITEMVL) + 1);
                  end;
                end;

                setocc(tFIS_NFITEMPRO, curocc(tFIS_NFITEMPRO) + 1);
              end;
            end;
            if (empty(tFIS_NFITEMDEV) = False) then begin
              setocc(tFIS_NFITEMDEV, 1);
              while (xStatus >= 0) do begin
                putitem_e(tFIS_NFITEMDEV, 'CD_EMPFAT', item_f('CD_EMPRESA', tGER_EMPRESA));
                setocc(tFIS_NFITEMDEV, curocc(tFIS_NFITEMDEV) + 1);
              end;
            end;

            setocc(tFIS_NFITEM, curocc(tFIS_NFITEM) + 1);
          end;
        end;
        if (empty(tFIS_NFECF) = False) then begin
          setocc(tFIS_NFECF, 1);
          while (xStatus >= 0) do begin
            putitem_e(tFIS_NFECF, 'CD_EMPFAT', item_f('CD_EMPRESA', tGER_EMPRESA));
            setocc(tFIS_NFECF, curocc(tFIS_NFECF) + 1);
          end;
        end;
        if (empty(tFIS_NFCCORR) = False) then begin
          setocc(tFIS_NFCCORR, 1);
          while (xStatus >= 0) do begin
            putitem_e(tFIS_NFCCORR, 'CD_EMPFAT', item_f('CD_EMPRESA', tGER_EMPRESA));
            setocc(tFIS_NFCCORR, curocc(tFIS_NFCCORR) + 1);
          end;
        end;
        if (empty(tFIS_NFIMPOSTO) = False) then begin
          setocc(tFIS_NFIMPOSTO, 1);
          while (xStatus >= 0) do begin
            putitem_e(tFIS_NFIMPOSTO, 'CD_EMPFAT', item_f('CD_EMPRESA', tGER_EMPRESA));
            setocc(tFIS_NFIMPOSTO, curocc(tFIS_NFIMPOSTO) + 1);
          end;
        end;
        if (empty(tFIS_NFVENCTO) = False) then begin
          setocc(tFIS_NFVENCTO, 1);
          while (xStatus >= 0) do begin
            putitem_e(tFIS_NFVENCTO, 'CD_EMPFAT', item_f('CD_EMPRESA', tGER_EMPRESA));
            setocc(tFIS_NFVENCTO, curocc(tFIS_NFVENCTO) + 1);
          end;
        end;
        if (empty(tFIS_NFTRANSP) = False) then begin
          setocc(tFIS_NFTRANSP, 1);
          while (xStatus >= 0) do begin
            putitem_e(tFIS_NFTRANSP, 'CD_EMPFAT', item_f('CD_EMPRESA', tGER_EMPRESA));
            setocc(tFIS_NFTRANSP, curocc(tFIS_NFTRANSP) + 1);
          end;
        end;
        if (empty(tFIS_NFREMDES) = False) then begin
          setocc(tFIS_NFREMDES, 1);
          while (xStatus >= 0) do begin
            putitem_e(tFIS_NFREMDES, 'CD_EMPFAT', item_f('CD_EMPRESA', tGER_EMPRESA));
            setocc(tFIS_NFREMDES, curocc(tFIS_NFREMDES) + 1);
          end;
        end;

        setocc(tFIS_NF, curocc(tFIS_NF) + 1);
      end;
    end;
    if (empty(tTRA_TRANSAGRU) = False) then begin
      setocc(tTRA_TRANSAGRU, 1);
      while (xStatus >= 0) do begin
        putitem_e(tTRA_TRANSAGRU, 'CD_EMPFAT', item_f('CD_EMPRESA', tGER_EMPRESA));
        setocc(tTRA_TRANSAGRU, curocc(tTRA_TRANSAGRU) + 1);
      end;
    end;
    if (empty(tTRA_TRANSACEC) = False) then begin
      setocc(tTRA_TRANSACEC, 1);
      while (xStatus >= 0) do begin
        putitem_e(tTRA_TRANSACEC, 'CD_EMPFAT', item_f('CD_EMPRESA', tGER_EMPRESA));
        setocc(tTRA_TRANSACEC, curocc(tTRA_TRANSACEC) + 1);
      end;
    end;
    if (empty(tTRA_LIBERACAO) = False) then begin
      setocc(tTRA_LIBERACAO, 1);
      while (xStatus >= 0) do begin
        putitem_e(tTRA_LIBERACAO, 'CD_EMPFAT', item_f('CD_EMPRESA', tGER_EMPRESA));
        setocc(tTRA_LIBERACAO, curocc(tTRA_LIBERACAO) + 1);
      end;
    end;
    if (empty(tTRA_TRAIMPOST) = False) then begin
      setocc(tTRA_TRAIMPOST, 1);
      while (xStatus >= 0) do begin
        putitem_e(tTRA_TRAIMPOST, 'CD_EMPFAT', item_f('CD_EMPRESA', tGER_EMPRESA));
        setocc(tTRA_TRAIMPOST, curocc(tTRA_TRAIMPOST) + 1);
      end;
    end;
    if (empty(tTRA_REMDES) = False) then begin
      setocc(tTRA_REMDES, 1);
      while (xStatus >= 0) do begin
        putitem_e(tTRA_REMDES, 'CD_EMPFAT', item_f('CD_EMPRESA', tGER_EMPRESA));
        setocc(tTRA_REMDES, curocc(tTRA_REMDES) + 1);
      end;
    end;
    if (empty(tTRA_TRANSPORT) = False) then begin
      setocc(tTRA_TRANSPORT, 1);
      while (xStatus >= 0) do begin
        putitem_e(tTRA_TRANSPORT, 'CD_EMPFAT', item_f('CD_EMPRESA', tGER_EMPRESA));
        setocc(tTRA_TRANSPORT, curocc(tTRA_TRANSPORT) + 1);
      end;
    end;
    if (empty(tTRA_VENCIMENT) = False) then begin
      setocc(tTRA_VENCIMENT, 1);
      while (xStatus >= 0) do begin
        putitem_e(tTRA_VENCIMENT, 'CD_EMPFAT', item_f('CD_EMPRESA', tGER_EMPRESA));
        setocc(tTRA_VENCIMENT, curocc(tTRA_VENCIMENT) + 1);
      end;
    end;
    if (empty(tTRA_TRANSITEM) = False) then begin
      setocc(tTRA_TRANSITEM, 1);
      while (xStatus >= 0) do begin
        putitem_e(tTRA_TRANSITEM, 'CD_EMPFAT', item_f('CD_EMPRESA', tGER_EMPRESA));

        if (empty(tTRA_ITEMCC) = False) then begin
          setocc(tTRA_ITEMCC, 1);
          while (xStatus >= 0) do begin
            putitem_e(tTRA_ITEMCC, 'CD_EMPFAT', item_f('CD_EMPRESA', tGER_EMPRESA));
            setocc(tTRA_ITEMCC, curocc(tTRA_ITEMCC) + 1);
          end;
        end;
        if (empty(tTRA_ITEMIMPOS) = False) then begin
          setocc(tTRA_ITEMIMPOS, 1);
          while (xStatus >= 0) do begin
            putitem_e(tTRA_ITEMIMPOS, 'CD_EMPFAT', item_f('CD_EMPRESA', tGER_EMPRESA));
            setocc(tTRA_ITEMIMPOS, curocc(tTRA_ITEMIMPOS) + 1);
          end;
        end;
        if (empty(tTRA_ITEMVL) = False) then begin
          setocc(tTRA_ITEMVL, 1);
          while (xStatus >= 0) do begin
            putitem_e(tTRA_ITEMVL, 'CD_EMPFAT', item_f('CD_EMPRESA', tGER_EMPRESA));
            setocc(tTRA_ITEMVL, curocc(tTRA_ITEMVL) + 1);
          end;
        end;

        setocc(tTRA_TRANSITEM, curocc(tTRA_TRANSITEM) + 1);
      end;
    end;

    voParams := tTRA_TRANSACAO.Salvar();
    if (xStatus < 0) then begin
      Result := voParams;
      return(-1); exit;
    end;
    if (empty(tPED_PEDIDOTRA) = False) then begin
      Result := SetStatus(STS_ERROR, 'GEN0001', 'Para esse tipo de transação não é permitido faturar em outro centro de custo!', cDS_METHOD);
      return(-1); exit;

    end;

    clear_e(tTRA_TROCA);
    putitem_e(tTRA_TROCA, 'CD_EMPVEN', item_f('CD_EMPRESA', tTRA_TRANSACAO));
    putitem_e(tTRA_TROCA, 'NR_TRAVEN', item_f('NR_TRANSACAO', tTRA_TRANSACAO));
    putitem_e(tTRA_TROCA, 'DT_TRAVEN', item_a('DT_TRANSACAO', tTRA_TRANSACAO));
    retrieve_e(tTRA_TROCA);
    if (xStatus >= 0) then begin
      setocc(tTRA_TROCA, 1);
      while (xStatus >= 0) do begin
        putitem_e(tTRA_TROCA, 'CD_EMPFATVEN', item_f('CD_EMPRESA', tGER_EMPRESA));
        setocc(tTRA_TROCA, curocc(tTRA_TROCA) + 1);
      end;
      voParams := tTRA_TROCA.Salvar();
      if (xStatus < 0) then begin
        Result := voParams;
        return(-1); exit;
      end;
    end;

    clear_e(tTRA_TROCA);
  end else begin
    vDsRegistro := '';
    putlistitensocc_e(vDsRegistro, tTRA_TRANSACAO);
    delitem(vDsRegistro, 'CD_EMPRESA');
    delitem(vDsRegistro, 'NR_TRANSACAO');
    delitem(vDsRegistro, 'DT_TRANSACAO');
    getlistitensocc_e(vDsRegistro, tTRA_S_TRANSAC);

    putitem_e(tTRA_S_TRANSAC, 'CD_EMPRESA', item_f('CD_EMPRESA', tGER_EMPRESA));
    putitem_e(tTRA_S_TRANSAC, 'NR_TRANSACAO', item_f('NR_TRANSACAO', tTRA_TRANSACAO));
    putitem_e(tTRA_S_TRANSAC, 'DT_TRANSACAO', item_a('DT_TRANSACAO', tTRA_TRANSACAO));
    putitem_e(tTRA_S_TRANSAC, 'CD_EMPFAT', item_f('CD_EMPRESA', tGER_EMPRESA));
    putitem_e(tTRA_S_TRANSAC, 'CD_EMPRESAORI', item_f('CD_EMPRESA', tTRA_TRANSACAO));
    putitem_e(tTRA_S_TRANSAC, 'NR_TRANSACAOORI', item_f('NR_TRANSACAO', tTRA_TRANSACAO));
    putitem_e(tTRA_S_TRANSAC, 'DT_TRANSACAOORI', item_a('DT_TRANSACAO', tTRA_TRANSACAO));
    putitem_e(tTRA_S_TRANSAC, 'VL_TRANSACAO', 0);
    putitem_e(tTRA_S_TRANSAC, 'VL_DESCONTO', 0);
    putitem_e(tTRA_S_TRANSAC, 'VL_TOTAL', 0);
    putitem_e(tTRA_S_TRANSAC, 'VL_FRETE', 0);
    putitem_e(tTRA_S_TRANSAC, 'VL_DESPACESSOR', 0);
    putitem_e(tTRA_S_TRANSAC, 'VL_SEGURO', 0);
    putitem_e(tTRA_S_TRANSAC, 'IN_FRETE', False);
    putitem_e(tTRA_S_TRANSAC, 'VL_IPI', 0);
    putitem_e(tTRA_S_TRANSAC, 'VL_TOTAL', 0);
    putitem_e(tTRA_S_TRANSAC, 'QT_SOLICITADA', 0);

    if (gprEncFinAbatImpPed <> '')  and (item_f('PR_ENCFINANCEIRO', tPED_PEDIDOCAD) > 0) then begin
      if (item_f('VL_DESPACESSOR', tTRA_TRANSACAO) > 0) then begin
        vVlDespAcessor := item_f('VL_DESPACESSOR', tTRA_TRANSACAO) * vNrDias / 100;
        putitem_e(tTRA_S_TRANSAC, 'VL_DESPACESSOR', vVlDespAcessor);
        putitem_e(tTRA_TRANSACAO, 'VL_DESPACESSOR', item_f('VL_DESPACESSOR', tTRA_TRANSACAO) - vVlDespAcessor);
        viParams := '';
        putlistitensocc_e(viParams, tTRA_TRANSPORT);
        putitemXml(viParams, 'VL_FRETE', item_f('VL_FRETE', tTRA_TRANSACAO));
        putitemXml(viParams, 'VL_SEGURO', item_f('VL_SEGURO', tTRA_TRANSACAO));
        putitemXml(viParams, 'VL_DESPACESSOR', item_f('VL_DESPACESSOR', tTRA_TRANSACAO));
        voParams := activateCmp('TRASVCO004', 'gravaTransportTransacao', viParams); (*,,,, *)
        if (xStatus < 0) then begin
          Result := voParams;
          return(-1); exit;
        end;
      end;
    end;

    viParams := '';
    putlistitensocc_e(viParams, tTRA_S_TRANSAC);
    putitemXml(viParams, 'IN_NAOGRAVAGUIAREPRE', True);
    voParams := activateCmp('TRASVCO004', 'gravaCapaTransacao', viParams); (*,,,, *)
    if (xStatus < 0) then begin
      Result := voParams;
      return(-1); exit;
    end;
    if (empty(tPED_PEDIDOTRA) = False) then begin
      clear_e(tF_PED_PEDIDOT);
      creocc(tF_PED_PEDIDOT, -1);
      putitem_e(tF_PED_PEDIDOT, 'CD_EMPPEDIDO', item_f('CD_EMPPEDIDO', tPED_PEDIDOTRA));
      putitem_e(tF_PED_PEDIDOT, 'CD_PEDIDO', item_f('CD_PEDIDO', tPED_PEDIDOTRA));
      putitem_e(tF_PED_PEDIDOT, 'CD_EMPTRANSACAO', vCdEmpresaAux);
      putitem_e(tF_PED_PEDIDOT, 'NR_TRANSACAO', item_f('NR_TRANSACAO', tTRA_TRANSACAO));
      putitem_e(tF_PED_PEDIDOT, 'DT_TRANSACAO', item_a('DT_TRANSACAO', tTRA_TRANSACAO));
      retrieve_o(tF_PED_PEDIDOT);
      if (xStatus = -7) then begin
        retrieve_x(tF_PED_PEDIDOT);
      end;

      putitem_e(tF_PED_PEDIDOT, 'CD_OPERADOR', itemXmlF('CD_USUARIO', PARAM_GLB));
      putitem_e(tF_PED_PEDIDOT, 'DT_CADASTRO', Now);

      voParams := tF_PED_PEDIDOT.Salvar();
      if (xStatus < 0) then begin
        Result := voParams;
        return(-1); exit;
      end;
    end;

    vDsRegistro := '';
    putlistitensocc_e(vDsRegistro, tTRA_REMDES);
    delitem(vDsRegistro, 'CD_EMPRESA');
    delitem(vDsRegistro, 'NR_TRANSACAO');
    delitem(vDsRegistro, 'DT_TRANSACAO');
    getlistitensocc_e(vDsRegistro, tF_TRA_REMDES);
    viParams := '';
    putlistitensocc_e(viParams, tF_TRA_REMDES);
    voParams := activateCmp('TRASVCO004', 'gravaenderecoTransacao', viParams); (*,,,, *)
    if (xStatus < 0) then begin
      Result := voParams;
      return(-1); exit;
    end;

    vVlMaior := 0;
    vNrItemMaior := 0;

    if (empty(tTRA_TRANSITEM) = False) then begin
      setocc(tTRA_TRANSITEM, 1);
      while (xStatus >= 0) do begin
        creocc(tTRA_S_TRANSIT, -1);
        vDsRegistro := '';
        putlistitensocc_e(vDsRegistro, tTRA_TRANSITEM);
        delitem(vDsRegistro, 'CD_EMPRESA');
        delitem(vDsRegistro, 'NR_TRANSACAO');
        delitem(vDsRegistro, 'DT_TRANSACAO');
        delitem(vDsRegistro, 'NR_ITEM');
        getlistitensocc_e(vDsRegistro, tTRA_S_TRANSIT);

        vNrDivisor := vNrDias;

        if (vNrDivisor > 0) then begin
          clear_e(tPRD_PRODUTOFO);
          putitem_e(tPRD_PRODUTOFO, 'CD_PRODUTO', item_f('CD_PRODUTO', tTRA_TRANSITEM));
          retrieve_e(tPRD_PRODUTOFO);
          if (xStatus >= 0) then begin
            setocc(tPRD_PRODUTOFO, 1);
            setocc(tPES_PREFFORNE, 1);
            if (dbocc(t'PES_PREFFORNE')) then begin
              if (gTpDesconto = 'Q') then begin
                if (vNrDivisor > item_f('PR_QTCANCELAMENTO', tPES_PREFFORNE))  and (item_f('PR_QTCANCELAMENTO', tPES_PREFFORNE) <> '') then begin
                  vNrDivisor := item_f('PR_QTCANCELAMENTO', tPES_PREFFORNE);
                end;
              end else begin
                if (vNrDivisor > item_f('PR_MARKUP', tPES_PREFFORNE))  and (item_f('PR_MARKUP', tPES_PREFFORNE) <> '') then begin
                  vNrDivisor := item_f('PR_MARKUP', tPES_PREFFORNE);
                end;
              end;
            end;
          end;
        end;

        putitem_e(tTRA_S_TRANSIT, 'CD_EMPFAT', item_f('CD_EMPRESA', tGER_EMPRESA));

        if (gTpDesconto = 'Q') then begin
          vInFracionado := False;
          clear_e(tPRD_PRDINFO);
          putitem_e(tPRD_PRDINFO, 'CD_EMPRESA', item_f('CD_EMPRESA', tTRA_TRANSACAO));
          putitem_e(tPRD_PRDINFO, 'CD_PRODUTO', item_f('CD_PRODUTO', tTRA_TRANSITEM));
          retrieve_e(tPRD_PRDINFO);
          if (xStatus >= 0) then begin
            vInFracionado := item_b('IN_FRACIONADO', tPRD_PRDINFO);
          end;

          vQtCalc := item_f('QT_SOLICITADA', tTRA_TRANSITEM) * vNrDivisor / 100;
          if (vInFracionado = True) then begin
            putitem_e(tTRA_S_TRANSIT, 'QT_SOLICITADA', rounded(vQtCalc, 3));
          end else begin
            putitem_e(tTRA_S_TRANSIT, 'QT_SOLICITADA', rounded(vQtCalc, 0));
          end;
          putitem_e(tTRA_S_TRANSIT, 'QT_ATENDIDA', 0);
          putitem_e(tTRA_S_TRANSIT, 'QT_SALDO', item_f('QT_SOLICITADA', tTRA_S_TRANSIT));
          vVlValor := item_f('VL_UNITBRUTO', tTRA_S_TRANSIT) * item_f('QT_SOLICITADA', tTRA_S_TRANSIT);
          putitem_e(tTRA_S_TRANSIT, 'VL_TOTALBRUTO', rounded(vVlValor, 2));
          vVlValor := item_f('VL_UNITLIQUIDO', tTRA_S_TRANSIT) * item_f('QT_SOLICITADA', tTRA_S_TRANSIT);
          putitem_e(tTRA_S_TRANSIT, 'VL_TOTALLIQUIDO', rounded(vVlValor, 2));
          vVlValor := item_f('VL_UNITDESC', tTRA_S_TRANSIT) * item_f('QT_SOLICITADA', tTRA_S_TRANSIT);
          putitem_e(tTRA_S_TRANSIT, 'VL_TOTALDESC', rounded(vVlValor, 2));
          vVlValor := item_f('VL_UNITDESCCAB', tTRA_S_TRANSIT) * item_f('QT_SOLICITADA', tTRA_S_TRANSIT);
          putitem_e(tTRA_S_TRANSIT, 'VL_TOTALDESCCAB', rounded(vVlValor, 2));
        end else begin
          putitem_e(tTRA_S_TRANSIT, 'QT_SOLICITADA', 0);
          putitem_e(tTRA_S_TRANSIT, 'QT_ATENDIDA', 0);
          putitem_e(tTRA_S_TRANSIT, 'QT_SALDO', 0);
          putitem_e(tTRA_S_TRANSIT, 'QT_ANTERIOR', 0);
          vVlValor := item_f('VL_TOTALBRUTO', tTRA_TRANSITEM) * vNrDivisor / 100;
          putitem_e(tTRA_S_TRANSIT, 'VL_TOTALBRUTO', rounded(vVlValor, 2));
          vVlValor := item_f('VL_TOTALLIQUIDO', tTRA_TRANSITEM) * vNrDivisor / 100;
          putitem_e(tTRA_S_TRANSIT, 'VL_TOTALLIQUIDO', rounded(vVlValor, 2));
          vVlValor := item_f('VL_TOTALDESC', tTRA_TRANSITEM) * vNrDivisor / 100;
          putitem_e(tTRA_S_TRANSIT, 'VL_TOTALDESC', rounded(vVlValor, 2));
          vVlValor := item_f('VL_TOTALDESCCAB', tTRA_TRANSITEM) * vNrDivisor / 100;
          putitem_e(tTRA_S_TRANSIT, 'VL_TOTALDESCCAB', rounded(vVlValor, 2));
          vVlValor := item_f('VL_TOTALBRUTO', tTRA_S_TRANSIT) / item_f('QT_SOLICITADA', tTRA_TRANSITEM);
          putitem_e(tTRA_S_TRANSIT, 'VL_UNITBRUTO', rounded(vVlValor, 6));
          vVlValor := item_f('VL_TOTALLIQUIDO', tTRA_S_TRANSIT) / item_f('QT_SOLICITADA', tTRA_TRANSITEM);
          putitem_e(tTRA_S_TRANSIT, 'VL_UNITLIQUIDO', rounded(vVlValor, 6));
          vVlValor := item_f('VL_TOTALDESC', tTRA_S_TRANSIT) / item_f('QT_SOLICITADA', tTRA_TRANSITEM);
          putitem_e(tTRA_S_TRANSIT, 'VL_UNITDESC', rounded(vVlValor, 6));
          vVlValor := item_f('VL_TOTALDESCCAB', tTRA_S_TRANSIT) / item_f('QT_SOLICITADA', tTRA_TRANSITEM);
          putitem_e(tTRA_S_TRANSIT, 'VL_UNITDESCCAB', rounded(vVlValor, 6));
        end;
        if (gTpDesconto = 'Q') then begin
          putitem_e(tTRA_TRANSITEM, 'QT_SOLICITADA', item_f('QT_SOLICITADA', tTRA_TRANSITEM) - item_f('QT_SOLICITADA', tTRA_S_TRANSIT));
          putitem_e(tTRA_TRANSITEM, 'QT_ATENDIDA', 0);
          putitem_e(tTRA_TRANSITEM, 'QT_SALDO', item_f('QT_SOLICITADA', tTRA_TRANSITEM));
          vVlValor := item_f('VL_UNITBRUTO', tTRA_TRANSITEM) * item_f('QT_SOLICITADA', tTRA_TRANSITEM);
          putitem_e(tTRA_TRANSITEM, 'VL_TOTALBRUTO', rounded(vVlValor, 2));
          vVlValor := item_f('VL_UNITLIQUIDO', tTRA_TRANSITEM) * item_f('QT_SOLICITADA', tTRA_TRANSITEM);
          putitem_e(tTRA_TRANSITEM, 'VL_TOTALLIQUIDO', rounded(vVlValor, 2));
          vVlValor := item_f('VL_UNITDESC', tTRA_TRANSITEM) * item_f('QT_SOLICITADA', tTRA_TRANSITEM);
          putitem_e(tTRA_TRANSITEM, 'VL_TOTALDESC', rounded(vVlValor, 2));
          vVlValor := item_f('VL_UNITDESCCAB', tTRA_TRANSITEM) * item_f('QT_SOLICITADA', tTRA_TRANSITEM);
          putitem_e(tTRA_TRANSITEM, 'VL_TOTALDESCCAB', rounded(vVlValor, 2));
        end else begin
          if (gInDescontoPromocional = True) then begin
            putitem_e(tTRA_TRANSITEM, 'VL_TOTALLIQUIDO', item_f('VL_TOTALLIQUIDO', tTRA_TRANSITEM) - item_f('VL_TOTALLIQUIDO', tTRA_S_TRANSIT));
            putitem_e(tTRA_TRANSITEM, 'VL_TOTALDESC', item_f('VL_TOTALDESC', tTRA_TRANSITEM) - item_f('VL_TOTALDESC', tTRA_S_TRANSIT));
            putitem_e(tTRA_TRANSITEM, 'VL_TOTALDESCCAB', item_f('VL_TOTALDESCCAB', tTRA_TRANSITEM) - item_f('VL_TOTALDESCCAB', tTRA_S_TRANSIT));
            putitem_e(tTRA_TRANSITEM, 'VL_TOTALDESCCAB', item_f('VL_TOTALDESCCAB', tTRA_TRANSITEM) + (item_f('VL_TOTALBRUTO', tTRA_TRANSITEM) - item_f('VL_TOTALBRUTO', tTRA_S_TRANSIT)));
          end else begin
            putitem_e(tTRA_TRANSITEM, 'VL_TOTALBRUTO', item_f('VL_TOTALBRUTO', tTRA_TRANSITEM) - item_f('VL_TOTALBRUTO', tTRA_S_TRANSIT));
            putitem_e(tTRA_TRANSITEM, 'VL_TOTALLIQUIDO', item_f('VL_TOTALLIQUIDO', tTRA_TRANSITEM) - item_f('VL_TOTALLIQUIDO', tTRA_S_TRANSIT));
            putitem_e(tTRA_TRANSITEM, 'VL_TOTALDESC', item_f('VL_TOTALDESC', tTRA_TRANSITEM) - item_f('VL_TOTALDESC', tTRA_S_TRANSIT));
            putitem_e(tTRA_TRANSITEM, 'VL_TOTALDESCCAB', item_f('VL_TOTALDESCCAB', tTRA_TRANSITEM) - item_f('VL_TOTALDESCCAB', tTRA_S_TRANSIT));
          end;
          vVlValor := item_f('VL_TOTALBRUTO', tTRA_TRANSITEM) / item_f('QT_SOLICITADA', tTRA_TRANSITEM);
          putitem_e(tTRA_TRANSITEM, 'VL_UNITBRUTO', rounded(vVlValor, 6));
          vVlValor := item_f('VL_TOTALLIQUIDO', tTRA_TRANSITEM) / item_f('QT_SOLICITADA', tTRA_TRANSITEM);
          putitem_e(tTRA_TRANSITEM, 'VL_UNITLIQUIDO', rounded(vVlValor, 6));
          vVlValor := item_f('VL_TOTALDESC', tTRA_TRANSITEM) / item_f('QT_SOLICITADA', tTRA_TRANSITEM);
          putitem_e(tTRA_TRANSITEM, 'VL_UNITDESC', rounded(vVlValor, 6));
          vVlValor := item_f('VL_TOTALDESCCAB', tTRA_TRANSITEM) / item_f('QT_SOLICITADA', tTRA_TRANSITEM);
          putitem_e(tTRA_TRANSITEM, 'VL_UNITDESCCAB', rounded(vVlValor, 6));

          if (item_f('VL_TOTALLIQUIDO', tTRA_TRANSITEM) = 0) then begin
            Result := SetStatus(STS_ERROR, 'GEN0001', 'Não foi possível validar desconto para o produto - ' + CD_PRODUTO + '.TRA_TRANSITEM!', cDS_METHOD);
            return(-1); exit;
          end;
        end;
        if (item_f('QT_SOLICITADA', tTRA_TRANSITEM) > 0)  and (item_f('VL_TOTALLIQUIDO', tTRA_S_TRANSIT) > 0) then begin
          viParams := '';
          putlistitensocc_e(viParams, tTRA_S_TRANSIT);
          putitemXml(viParams, 'IN_TOTAL', False);
          voParams := activateCmp('TRASVCO004', 'gravaItemTransacao', viParams); (*,,,, *)
          if (xStatus < 0) then begin
            Result := voParams;
            return(-1); exit;
          end;

          viParams := '';
          putlistitensocc_e(viParams, tTRA_TRANSITEM);
          putitemXml(viParams, 'IN_TOTAL', False);
          voParams := activateCmp('TRASVCO004', 'gravaItemTransacao', viParams); (*,,,, *)
          if (xStatus < 0) then begin
            Result := voParams;
            return(-1); exit;
          end;

          vNrItem := itemXmlF('NR_ITEM', voParams);

          if (item_f('VL_TOTALLIQUIDO', tTRA_TRANSITEM) > vVlMaior) then begin
            vNrItemMaior := vNrItem;
            vVlMaior := item_f('VL_TOTALLIQUIDO', tTRA_TRANSITEM);
          end;
        end;

        setocc(tTRA_TRANSITEM, curocc(tTRA_TRANSITEM) + 1);
      end;
    end;

    viParams := '';
    vDsLstTransacao := '';
    vDsRegistro := '';
    putitemXml(vDsRegistro, 'CD_EMPRESA', item_f('CD_EMPRESA', tTRA_TRANSACAO));
    putitemXml(vDsRegistro, 'NR_TRANSACAO', item_f('NR_TRANSACAO', tTRA_TRANSACAO));
    putitemXml(vDsRegistro, 'DT_TRANSACAO', item_a('DT_TRANSACAO', tTRA_TRANSACAO));
    putitem(vDsLstTransacao,  vDsRegistro);
    putitemXml(viParams, 'DS_LSTTRANSACAO', vDsLstTransacao);
    voParams := activateCmp('TRASVCO004', 'gravaTotalTransacao', viParams); (*,,,, *)
    if (xStatus < 0) then begin
      Result := voParams;
      return(-1); exit;
    end;

    viParams := '';
    vDsLstTransacao := '';
    vDsRegistro := '';
    putitemXml(vDsRegistro, 'CD_EMPRESA', item_f('CD_EMPRESA', tTRA_S_TRANSAC));
    putitemXml(vDsRegistro, 'NR_TRANSACAO', item_f('NR_TRANSACAO', tTRA_S_TRANSAC));
    putitemXml(vDsRegistro, 'DT_TRANSACAO', item_a('DT_TRANSACAO', tTRA_S_TRANSAC));
    putitem(vDsLstTransacao,  vDsRegistro);
    putitemXml(viParams, 'DS_LSTTRANSACAO', vDsLstTransacao);
    voParams := activateCmp('TRASVCO004', 'gravaTotalTransacao', viParams); (*,,,, *)
    if (xStatus < 0) then begin
      Result := voParams;
      return(-1); exit;
    end;

    vCdEmpresa := item_f('CD_EMPRESA', tTRA_TRANSACAO);
    vNrTransacao := item_f('NR_TRANSACAO', tTRA_TRANSACAO);
    vDtTransacao := item_a('DT_TRANSACAO', tTRA_TRANSACAO);
    clear_e(tTRA_TRANSACAO);
    putitem_e(tTRA_TRANSACAO, 'CD_EMPRESA', vCdEmpresa);
    putitem_e(tTRA_TRANSACAO, 'NR_TRANSACAO', vNrTransacao);
    putitem_e(tTRA_TRANSACAO, 'DT_TRANSACAO', vDtTransacao);
    retrieve_e(tTRA_TRANSACAO);

    vCdEmpresa := item_f('CD_EMPRESA', tTRA_S_TRANSAC);
    vNrTransacao := item_f('NR_TRANSACAO', tTRA_S_TRANSAC);
    vDtTransacao := item_a('DT_TRANSACAO', tTRA_S_TRANSAC);
    clear_e(tTRA_S_TRANSAC);
    putitem_e(tTRA_S_TRANSAC, 'CD_EMPRESA', vCdEmpresa);
    putitem_e(tTRA_S_TRANSAC, 'NR_TRANSACAO', vNrTransacao);
    putitem_e(tTRA_S_TRANSAC, 'DT_TRANSACAO', vDtTransacao);
    retrieve_e(tTRA_S_TRANSAC);

    gVlDiferenca := vVlTotalAnt - (item_f('VL_TRANSACAO', tTRA_TRANSACAO) + item_f('VL_TRANSACAO', tTRA_S_TRANSAC));

    if (gVlDiferenca <> 0) then begin
      clear_e(tTRA_TRANSITEM);
      putitem_e(tTRA_TRANSITEM, 'NR_ITEM', vNrItemMaior);
      retrieve_e(tTRA_TRANSITEM);
      if (xStatus < 0) then begin
        Result := SetStatus(STS_ERROR, 'GEN0001', 'Item ' + FloatToStr(vNrItemMaior) + ' para arredondamento não encontrado!', cDS_METHOD);
        return(-1); exit;
      end;
      putitem_e(tTRA_TRANSITEM, 'VL_TOTALBRUTO', item_f('VL_TOTALBRUTO', tTRA_TRANSITEM) + gVlDiferenca);
      putitem_e(tTRA_TRANSITEM, 'VL_TOTALLIQUIDO', item_f('VL_TOTALLIQUIDO', tTRA_TRANSITEM) + gVlDiferenca);
      vVlValor := item_f('VL_TOTALBRUTO', tTRA_TRANSITEM) / item_f('QT_SOLICITADA', tTRA_TRANSITEM);
      putitem_e(tTRA_TRANSITEM, 'VL_UNITBRUTO', rounded(vVlValor, 6));
      vVlValor := item_f('VL_TOTALLIQUIDO', tTRA_TRANSITEM) / item_f('QT_SOLICITADA', tTRA_TRANSITEM);
      putitem_e(tTRA_TRANSITEM, 'VL_UNITLIQUIDO', rounded(vVlValor, 6));
      viParams := '';
      putlistitensocc_e(viParams, tTRA_TRANSITEM);
      putitemXml(viParams, 'IN_TOTAL', False);
      voParams := activateCmp('TRASVCO004', 'gravaItemTransacao', viParams); (*,,,, *)
      if (xStatus < 0) then begin
        Result := voParams;
        return(-1); exit;
      end;

      vDsLstTransacao := '';
      vDsRegistro := '';
      putitemXml(vDsRegistro, 'CD_EMPRESA', item_f('CD_EMPRESA', tTRA_TRANSACAO));
      putitemXml(vDsRegistro, 'NR_TRANSACAO', item_f('NR_TRANSACAO', tTRA_TRANSACAO));
      putitemXml(vDsRegistro, 'DT_TRANSACAO', item_a('DT_TRANSACAO', tTRA_TRANSACAO));
      putitem(vDsLstTransacao,  vDsRegistro);
      viParams := '';
      putitemXml(viParams, 'DS_LSTTRANSACAO', vDsLstTransacao);
      vDsObservacao := 'Arredondamento de ' + FloatToStr(gVlDiferenca) + ' aplicado sobre o item ' + FloatToStr(vNrItemMaior') + ';
      putitemXml(viParams, 'DS_OBSERVACAO', vDsObservacao);
      voParams := activateCmp('TRASVCO016', 'gravaObsTransacao', viParams); (*,,,, *)
      if (xStatus < 0) then begin
        Result := voParams;
        return(-1); exit;
      end;

      viParams := '';
      vDsLstTransacao := '';
      vDsRegistro := '';
      putitemXml(vDsRegistro, 'CD_EMPRESA', item_f('CD_EMPRESA', tTRA_TRANSACAO));
      putitemXml(vDsRegistro, 'NR_TRANSACAO', item_f('NR_TRANSACAO', tTRA_TRANSACAO));
      putitemXml(vDsRegistro, 'DT_TRANSACAO', item_a('DT_TRANSACAO', tTRA_TRANSACAO));
      putitem(vDsLstTransacao,  vDsRegistro);
      putitemXml(viParams, 'DS_LSTTRANSACAO', vDsLstTransacao);
      voParams := activateCmp('TRASVCO004', 'gravaTotalTransacao', viParams); (*,,,, *)
      if (xStatus < 0) then begin
        Result := voParams;
        return(-1); exit;
      end;

      viParams := '';
      vDsLstTransacao := '';
      vDsRegistro := '';
      putitemXml(vDsRegistro, 'CD_EMPRESA', item_f('CD_EMPRESA', tTRA_S_TRANSAC));
      putitemXml(vDsRegistro, 'NR_TRANSACAO', item_f('NR_TRANSACAO', tTRA_S_TRANSAC));
      putitemXml(vDsRegistro, 'DT_TRANSACAO', item_a('DT_TRANSACAO', tTRA_S_TRANSAC));
      putitem(vDsLstTransacao,  vDsRegistro);
      putitemXml(viParams, 'DS_LSTTRANSACAO', vDsLstTransacao);
      voParams := activateCmp('TRASVCO004', 'gravaTotalTransacao', viParams); (*,,,, *)
      if (xStatus < 0) then begin
        Result := voParams;
        return(-1); exit;
      end;

      vCdEmpresa := item_f('CD_EMPRESA', tTRA_TRANSACAO);
      vNrTransacao := item_f('NR_TRANSACAO', tTRA_TRANSACAO);
      vDtTransacao := item_a('DT_TRANSACAO', tTRA_TRANSACAO);
      clear_e(tTRA_TRANSACAO);
      putitem_e(tTRA_TRANSACAO, 'CD_EMPRESA', vCdEmpresa);
      putitem_e(tTRA_TRANSACAO, 'NR_TRANSACAO', vNrTransacao);
      putitem_e(tTRA_TRANSACAO, 'DT_TRANSACAO', vDtTransacao);
      retrieve_e(tTRA_TRANSACAO);
    end;
    if (empty(tTRA_VENCIMENT) = False) then begin
      vVlRestoEmp := item_f('VL_TOTAL', tTRA_TRANSACAO);
      vVlRestoCC := item_f('VL_TOTAL', tTRA_S_TRANSAC);

      vNrFator := vVlRestoCC / (vVlRestoEmp + vVlRestoCC);

      setocc(tTRA_VENCIMENT, 1);
      while (xStatus >= 0) do begin
        creocc(tF_TRA_VENCIME, -1);
        vDsRegistro := '';
        putlistitensocc_e(vDsRegistro, tTRA_VENCIMENT);
        delitem(vDsRegistro, 'CD_EMPRESA');
        delitem(vDsRegistro, 'NR_TRANSACAO');
        delitem(vDsRegistro, 'DT_TRANSACAO');
        getlistitensocc_e(vDsRegistro, tF_TRA_VENCIME);

        putitem_e(tF_TRA_VENCIME, 'CD_EMPFAT', item_f('CD_EMPRESA', tGER_EMPRESA));
        vVlValor := item_f('VL_PARCELA', tTRA_VENCIMENT) * vNrFator;
        putitem_e(tF_TRA_VENCIME, 'VL_PARCELA', rounded(vVlValor, 2));
        vVlRestoCC := vVlRestoCC - item_f('VL_PARCELA', tF_TRA_VENCIME);
        putitem_e(tTRA_VENCIMENT, 'VL_PARCELA', item_f('VL_PARCELA', tTRA_VENCIMENT) - item_f('VL_PARCELA', tF_TRA_VENCIME));
        vVlRestoEmp := vVlRestoEmp - item_f('VL_PARCELA', tTRA_VENCIMENT);

        setocc(tTRA_VENCIMENT, curocc(tTRA_VENCIMENT) + 1);
      end;
      if (vVlRestoEmp <> 0) then begin
        setocc(tTRA_VENCIMENT, 1);
        putitem_e(tTRA_VENCIMENT, 'VL_PARCELA', item_f('VL_PARCELA', tTRA_VENCIMENT) + vVlRestoEmp);
      end;
      if (vVlRestoCC <> 0) then begin
        setocc(tF_TRA_VENCIME, 1);
        putitem_e(tF_TRA_VENCIME, 'VL_PARCELA', item_f('VL_PARCELA', tF_TRA_VENCIME) + vVlRestoCC);
      end;

      voParams := tTRA_VENCIMENT.Salvar();
      if (xStatus < 0) then begin
        Result := voParams;
        return(-1); exit;
      end;

      vDsLstVencimento := '';
      setocc(tF_TRA_VENCIME, 1);
      while (xStatus >= 0) do begin
        if (item_f('VL_PARCELA', tF_TRA_VENCIME) > 0) then begin
          putlistitensocc_e(vDsRegistro, tF_TRA_VENCIME);
          putitem(vDsLstVencimento,  vDsRegistro);
        end;
        setocc(tF_TRA_VENCIME, curocc(tF_TRA_VENCIME) + 1);
      end;

      viParams := '';
      putitemXml(viParams, 'CD_EMPRESA', item_f('CD_EMPRESA', tTRA_S_TRANSAC));
      putitemXml(viParams, 'NR_TRANSACAO', item_f('NR_TRANSACAO', tTRA_S_TRANSAC));
      putitemXml(viParams, 'DT_TRANSACAO', item_a('DT_TRANSACAO', tTRA_S_TRANSAC));
      putitemXml(viParams, 'DS_LSTVENCIMENTO', vDsLstVencimento);
      voParams := activateCmp('TRASVCO004', 'gravaParcelaTransacao', viParams); (*,,,, *)
      if (xStatus < 0) then begin
        Result := voParams;
        return(-1); exit;
      end;
    end;
  end;

  Result := '';
  vDsLstTransacao := '';
  if (empty(tTRA_TRANSACAO) = False) then begin
    vDsRegistro := '';
    putitemXml(vDsRegistro, 'CD_EMPRESA', item_f('CD_EMPRESA', tTRA_TRANSACAO));
    putitemXml(vDsRegistro, 'NR_TRANSACAO', item_f('NR_TRANSACAO', tTRA_TRANSACAO));
    putitemXml(vDsRegistro, 'DT_TRANSACAO', item_a('DT_TRANSACAO', tTRA_TRANSACAO));
    putitem(vDsLstTransacao,  vDsRegistro);
  end;
  if (empty(tTRA_S_TRANSAC) = False) then begin
    if (item_f('VL_TOTAL', tTRA_S_TRANSAC) = 0) then begin
      vDsLstTra := '';
      vDsRegistro := '';
      putitemXml(vDsRegistro, 'CD_EMPRESA', item_f('CD_EMPRESA', tTRA_S_TRANSAC));
      putitemXml(vDsRegistro, 'NR_TRANSACAO', item_f('NR_TRANSACAO', tTRA_S_TRANSAC));
      putitemXml(vDsRegistro, 'DT_TRANSACAO', item_a('DT_TRANSACAO', tTRA_S_TRANSAC));
      putitem(vDsLstTra,  vDsRegistro);
      viParams := '';
      putitemXml(viParams, 'DS_LSTTRANSACAO', vDsLstTra);
      putitemXml(viParams, 'TP_SITUACAO', 6);
      voParams := activateCmp('TRASVCO004', 'alteraSituacaoTransacao', viParams); (*,,,, *)
      if (xStatus < 0) then begin
        Result := voParams;
        return(-1); exit;
      end;
    end else begin
      vDsRegistro := '';
      putitemXml(vDsRegistro, 'CD_EMPRESA', item_f('CD_EMPRESA', tTRA_S_TRANSAC));
      putitemXml(vDsRegistro, 'NR_TRANSACAO', item_f('NR_TRANSACAO', tTRA_S_TRANSAC));
      putitemXml(vDsRegistro, 'DT_TRANSACAO', item_a('DT_TRANSACAO', tTRA_S_TRANSAC));
        putitem(vDsLstTransacao,  vDsRegistro);

    end;
  end;
  putitemXml(Result, 'DS_LSTTRANSACAO', vDsLstTransacao);
  putitemXml(Result, 'IN_DESCONTO', vInDesconto);

  return(0); exit;
end;

//------------------------------------------------------------------
function T_SISVCO001.descontoPromocional(pParams : String) : String;
//------------------------------------------------------------------
const
  cDS_METHOD = 'ADICIONAL=Operação: T_SISVCO001.descontoPromocional()';
var
  vCdEmpresa, vNrTransacao : Real;
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
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Data da transação não informado!', cDS_METHOD);
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

  putitem_e(tTRA_TRANSACAO, 'DT_PREVENTREGA', item_a('DT_TRANSACAO', tTRA_TRANSACAO) + 100);
  putitem_e(tTRA_TRANSACAO, 'IN_ACEITADEV', True);

  voParams := tTRA_TRANSACAO.Salvar();
  if (xStatus < 0) then begin
    Result := voParams;
    return(-1); exit;
  end;

  return(0); exit;
end;

//-----------------------------------------------------------------
function T_SISVCO001.validaParcelamento(pParams : String) : String;
//-----------------------------------------------------------------
const
  cDS_METHOD = 'ADICIONAL=Operação: T_SISVCO001.validaParcelamento()';
var
  vCdEmpresa, vNrTransacao, vCdEmpresaAux, vPrParcela, vVlParcela, vVlResto : Real;
  vDtTransacao, vDtBase : TDate;
  vInValidacao : Boolean;
  viParams, voParams : String;
begin
  vCdEmpresa := itemXmlF('CD_EMPRESA', pParams);
  vNrTransacao := itemXmlF('NR_TRANSACAO', pParams);
  vDtTransacao := itemXml('DT_TRANSACAO', pParams);

  vInValidacao := itemXmlB('IN_VALIDACAO', pParams);
  vDtBase := itemXml('DT_BASE', pParams);

  if (vCdEmpresa = 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Empresa não informada!', cDS_METHOD);
    return(-1); exit;
  end;
  if (vNrTransacao = 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Número transação não informado!', cDS_METHOD);
    return(-1); exit;
  end;
  if (vDtTransacao = '') then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Data da transação não informado!', cDS_METHOD);
    return(-1); exit;
  end;

  clear_e(tTRA_S_TRANSAC);
  putitem_e(tTRA_S_TRANSAC, 'CD_EMPRESA', vCdEmpresa);
  putitem_e(tTRA_S_TRANSAC, 'NR_TRANSACAO', vNrTransacao);
  putitem_e(tTRA_S_TRANSAC, 'DT_TRANSACAO', vDtTransacao);
  retrieve_e(tTRA_S_TRANSAC);
  if (xStatus < 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Transação ' + FloatToStr(vNrTransacao) + ' não cadastrada!', cDS_METHOD);
    return(-1); exit;
  end;

  vCdEmpresaAux := 0;

  clear_e(tGER_EMPRESA);
  putitem_e(tGER_EMPRESA, 'CD_EMPRESA', vCdEmpresa);
  retrieve_e(tGER_EMPRESA);
  if (xStatus >= 0) then begin
    if (item_f('CD_CCUSTO', tGER_EMPRESA) > 0) then begin
      vCdEmpresaAux := item_f('CD_CCUSTO', tGER_EMPRESA);
    end else begin
      clear_e(tGER_EMPRESA);
      putitem_e(tGER_EMPRESA, 'CD_CCUSTO', vCdEmpresa);
      retrieve_e(tGER_EMPRESA);
      if (xStatus >= 0) then begin
        vCdEmpresaAux := item_f('CD_EMPRESA', tGER_EMPRESA);
      end;
    end;
  end;
  if (vCdEmpresaAux > 0) then begin
    clear_e(tTRA_TRANSACAO);
    putitem_e(tTRA_TRANSACAO, 'CD_EMPRESA', vCdEmpresaAux);
    putitem_e(tTRA_TRANSACAO, 'NR_TRANSACAO', vNrTransacao);
    putitem_e(tTRA_TRANSACAO, 'DT_TRANSACAO', vDtTransacao);
    retrieve_e(tTRA_TRANSACAO);
    if (xStatus >= 0) then begin
      if (vInValidacao) then begin
        voParams := tTRA_VENCIMENT.Excluir();
        if (xStatus < 0) then begin
          Result := voParams;
          return(-1); exit;
        end;
        if (empty(tF_TRA_VENCIME) = False) then begin
          vVlResto := item_f('VL_TOTAL', tTRA_TRANSACAO);

          setocc(tF_TRA_VENCIME, 1);
          while (xStatus >= 0) do begin
            vPrParcela := item_f('VL_PARCELA', tF_TRA_VENCIME) / item_f('VL_TOTAL', tTRA_S_TRANSAC);
            vVlParcela := item_f('VL_TOTAL', tTRA_TRANSACAO) * vPrParcela;

            creocc(tTRA_VENCIMENT, -1);
            putitem_e(tTRA_VENCIMENT, 'NR_PARCELA', item_f('NR_PARCELA', tF_TRA_VENCIME));
            putitem_e(tTRA_VENCIMENT, 'DT_VENCIMENTO', item_a('DT_VENCIMENTO', tF_TRA_VENCIME));
            putitem_e(tTRA_VENCIMENT, 'NR_DCTOORIGEM', item_f('NR_DCTOORIGEM', tF_TRA_VENCIME));
            putitem_e(tTRA_VENCIMENT, 'VL_PARCELA', vVlParcela);
            putitem_e(tTRA_VENCIMENT, 'TP_FORMAPGTO', item_f('TP_FORMAPGTO', tF_TRA_VENCIME));
            putitem_e(tTRA_VENCIMENT, 'CD_EMPFAT', item_f('CD_EMPFAT', tTRA_TRANSACAO));
            putitem_e(tTRA_VENCIMENT, 'CD_GRUPOEMPRESA', item_f('CD_GRUPOEMPRESA', tTRA_TRANSACAO));
            putitem_e(tTRA_VENCIMENT, 'CD_OPERADOR', itemXmlF('CD_USUARIO', PARAM_GLB));
            putitem_e(tTRA_VENCIMENT, 'DT_CADASTRO', Now);
            vVlResto := vVlResto - vVlParcela;

            setocc(tF_TRA_VENCIME, curocc(tF_TRA_VENCIME) + 1);
          end;
          if (vVlResto <> 0) then begin
            if (vVlResto > 0) then begin
              setocc(tTRA_VENCIMENT, 1);
            end else begin
              setocc(tTRA_VENCIMENT, -1);
            end;

            putitem_e(tTRA_VENCIMENT, 'VL_PARCELA', item_f('VL_PARCELA', tTRA_VENCIMENT) + vVlResto);
          end;
        end;
      end else begin

        if (vDtBase <> '') then begin
          viParams := '';
          putitemXml(viParams, 'CD_EMPRESA', item_f('CD_EMPRESA', tTRA_TRANSACAO));
          putitemXml(viParams, 'NR_TRANSACAO', item_f('NR_TRANSACAO', tTRA_TRANSACAO));
          putitemXml(viParams, 'DT_TRANSACAO', item_a('DT_TRANSACAO', tTRA_TRANSACAO));
          putitemXml( viParams, 'DT_BASE', vDtBase);
          putitemXml( viParams, 'IN_VALIDAPARCELAMENTO', False);
          putitemXml( viParams, 'IN_SOBREPOR', True);
          newinstance 'TRASVCO024', 'TRASVCO024A', 'TRANSACTION=FALSE';
          voParams := activateCmp('TRASVCO024A', 'gravaParcelaTransacao', viParams); (*,,,, *)
          if (xStatus < 0) then begin
            Result := voParams;
            return(-1); exit;
          end;
          deleteinstance 'TRASVCO024A';
        end;
      end;

      voParams := tTRA_VENCIMENT.Salvar();
      if (xStatus < 0) then begin
        Result := voParams;
        return(-1); exit;
      end;
    end;
  end;

  return(0); exit;
end;

//----------------------------------------------------------------
function T_SISVCO001.validaAgrupamento(pParams : String) : String;
//----------------------------------------------------------------
const
  cDS_METHOD = 'ADICIONAL=Operação: T_SISVCO001.validaAgrupamento()';
var
  vCdEmpresa, vNrTransacao, vCdEmpresaAux, vCdPessoa, vCdOperacao, vCdCondPgto, vNrTransacaoAgrup : Real;
  vDsRegistro, vDsLstTransacao, vLstTransacao : String;
  viParams, voParams : String;
  vDtTransacao : TDate;
  vInPadrao, vInTraPadrao : Boolean;
begin
  vDsLstTransacao := itemXml('DS_LSTTRANSACAO', pParams);
  vNrTransacaoAgrup := itemXmlF('NR_TRANSACAO', pParams);
  vInTraPadrao := False;
  vCdOperacao := itemXmlF('CD_OPERACAO', pParams);

  repeat
    getitem(vDsRegistro, vDsLstTransacao, 1);
    vCdEmpresa := itemXmlF('CD_EMPRESA', vDsRegistro);
    vNrTransacao := itemXmlF('NR_TRANSACAO', vDsRegistro);
    vDtTransacao := itemXml('DT_TRANSACAO', vDsRegistro);
    vInPadrao := itemXmlB('IN_PADRAO', vDsRegistro);

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

    vCdEmpresaAux := 0;

    clear_e(tGER_EMPRESA);
    putitem_e(tGER_EMPRESA, 'CD_EMPRESA', vCdEmpresa);
    retrieve_e(tGER_EMPRESA);
    if (xStatus >= 0) then begin
      if (item_f('CD_CCUSTO', tGER_EMPRESA) > 0) then begin
        vCdEmpresaAux := item_f('CD_CCUSTO', tGER_EMPRESA);
      end else begin
        clear_e(tGER_EMPRESA);
        putitem_e(tGER_EMPRESA, 'CD_CCUSTO', vCdEmpresa);
        retrieve_e(tGER_EMPRESA);
        if (xStatus >= 0) then begin
          vCdEmpresaAux := item_f('CD_EMPRESA', tGER_EMPRESA);
        end;
      end;
    end;

    clear_e(tTRA_S_TRANSAC);
    putitem_e(tTRA_S_TRANSAC, 'CD_EMPRESA', vCdEmpresaAux);
    putitem_e(tTRA_S_TRANSAC, 'NR_TRANSACAO', vNrTransacao);
    putitem_e(tTRA_S_TRANSAC, 'DT_TRANSACAO', vDtTransacao);
    retrieve_e(tTRA_S_TRANSAC);
    if (xStatus >= 0)  and (vInPadrao = True) then begin
      vInTraPadrao := True;
    end;

    delitem(vDsLstTransacao, 1);
  until (vDsLstTransacao = '');

  vDsLstTransacao := itemXml('DS_LSTTRANSACAO', pParams);
  vLstTransacao := '';

  repeat
    getitem(vDsRegistro, vDsLstTransacao, 1);
    vCdEmpresa := itemXmlF('CD_EMPRESA', vDsRegistro);
    vNrTransacao := itemXmlF('NR_TRANSACAO', vDsRegistro);
    vDtTransacao := itemXml('DT_TRANSACAO', vDsRegistro);
    vInPadrao := itemXmlB('IN_PADRAO', vDsRegistro);

    vCdEmpresaAux := 0;

    clear_e(tGER_EMPRESA);
    putitem_e(tGER_EMPRESA, 'CD_EMPRESA', vCdEmpresa);
    retrieve_e(tGER_EMPRESA);
    if (xStatus >= 0) then begin
      if (item_f('CD_CCUSTO', tGER_EMPRESA) > 0) then begin
        vCdEmpresaAux := item_f('CD_CCUSTO', tGER_EMPRESA);
      end else begin
        clear_e(tGER_EMPRESA);
        putitem_e(tGER_EMPRESA, 'CD_CCUSTO', vCdEmpresa);
        retrieve_e(tGER_EMPRESA);
        if (xStatus >= 0) then begin
          vCdEmpresaAux := item_f('CD_EMPRESA', tGER_EMPRESA);
        end;
      end;
    end;

    clear_e(tTRA_S_TRANSAC);
    putitem_e(tTRA_S_TRANSAC, 'CD_EMPRESA', vCdEmpresaAux);
    putitem_e(tTRA_S_TRANSAC, 'NR_TRANSACAO', vNrTransacao);
    putitem_e(tTRA_S_TRANSAC, 'DT_TRANSACAO', vDtTransacao);
    retrieve_e(tTRA_S_TRANSAC);
    if (xStatus >= 0) then begin
      vDsRegistro := '';
      putitemXml(vDsRegistro, 'CD_EMPRESA', item_f('CD_EMPRESA', tTRA_S_TRANSAC));
      putitemXml(vDsRegistro, 'NR_TRANSACAO', item_f('NR_TRANSACAO', tTRA_S_TRANSAC));
      putitemXml(vDsRegistro, 'DT_TRANSACAO', item_a('DT_TRANSACAO', tTRA_S_TRANSAC));
      if (vInPadrao = True)  or (vInTraPadrao = False) then begin
        putitemXml(vDsRegistro, 'IN_PADRAO', True);
        vCdPessoa := item_f('CD_PESSOA', tTRA_S_TRANSAC);
        if (vCdOperacao = '') then begin
          vCdOperacao := item_f('CD_OPERACAO', tTRA_S_TRANSAC);
        end;
        vCdCondPgto := item_f('CD_CONDPGTO', tTRA_S_TRANSAC);
        vInTraPadrao := True;
      end;
      putitem(vLstTransacao,  vDsRegistro);
    end;

    delitem(vDsLstTransacao, 1);
  until (vDsLstTransacao = '');

  if (vLstTransacao <> '') then begin
    viParams := '';
    putitemXml(viParams, 'CD_EMPTRANSACAO', vCdEmpresaAux);
    putitemXml(viParams, 'NR_TRANSACAO', vNrTransacaoAgrup);
    putitemXml(viParams, 'CD_PESSOA', vCdPessoa);
    putitemXml(viParams, 'CD_OPERACAO', vCdOperacao);
    putitemXml(viParams, 'CD_CONDPGTO', vCdCondPgto);
    putitemXml(viParams, 'IN_PEDIDO', True);
    putitemXml(viParams, 'IN_AGRUPA', False);
    putitemXml(viParams, 'CD_OPERACAO', vCdOperacao);
    putitemXml(viParams, 'TP_SITUACAO', itemXmlF('TP_SITUACAO', pParams));
    newinstance 'TRASVCO010', 'TRASVCO010A', 'TRANSACTION=FALSE';
    voParams := activateCmp('TRASVCO010A', 'agrupaTransacao', viParams); (*,,vLstTransacao,,, *)
    if (xStatus < 0) then begin
      Result := voParams;
      return(-1); exit;
    end;
  end;

  return(0); exit;
end;

//--------------------------------------------------------------------
function T_SISVCO001.validaItemAgrupamento(pParams : String) : String;
//--------------------------------------------------------------------
const
  cDS_METHOD = 'ADICIONAL=Operação: T_SISVCO001.validaItemAgrupamento()';
var
  viParams, voParams : String;
  vCdEmpresa, vNrTransacao, vCdEmpresaAux : Real;
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
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Data da transação não informado!', cDS_METHOD);
    return(-1); exit;
  end;

  clear_e(tTRA_S_TRANSAC);
  putitem_e(tTRA_S_TRANSAC, 'CD_EMPRESA', vCdEmpresa);
  putitem_e(tTRA_S_TRANSAC, 'NR_TRANSACAO', vNrTransacao);
  putitem_e(tTRA_S_TRANSAC, 'DT_TRANSACAO', vDtTransacao);
  retrieve_e(tTRA_S_TRANSAC);
  if (xStatus < 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Transação ' + FloatToStr(vNrTransacao) + ' não cadastrada!', cDS_METHOD);
    return(-1); exit;
  end;

  vCdEmpresaAux := 0;

  clear_e(tGER_EMPRESA);
  putitem_e(tGER_EMPRESA, 'CD_EMPRESA', vCdEmpresa);
  retrieve_e(tGER_EMPRESA);
  if (xStatus >= 0) then begin
    if (item_f('CD_CCUSTO', tGER_EMPRESA) > 0) then begin
      vCdEmpresaAux := item_f('CD_CCUSTO', tGER_EMPRESA);
    end else begin
      clear_e(tGER_EMPRESA);
      putitem_e(tGER_EMPRESA, 'CD_CCUSTO', vCdEmpresa);
      retrieve_e(tGER_EMPRESA);
      if (xStatus >= 0) then begin
        vCdEmpresaAux := item_f('CD_EMPRESA', tGER_EMPRESA);
      end;
    end;
  end;
  if (vCdEmpresaAux > 0) then begin
    clear_e(tTRA_TRANSACAO);
    putitem_e(tTRA_TRANSACAO, 'CD_EMPRESA', vCdEmpresaAux);
    putitem_e(tTRA_TRANSACAO, 'NR_TRANSACAO', vNrTransacao);
    putitem_e(tTRA_TRANSACAO, 'DT_TRANSACAO', vDtTransacao);
    retrieve_e(tTRA_TRANSACAO);
    if (xStatus >= 0) then begin
      viParams := '';
      putitemXml(viParams, 'CD_EMPRESA', vCdEmpresaAux);
      putitemXml(viParams, 'NR_TRANSACAO', vNrTransacao);
      putitemXml(viParams, 'DT_TRANSACAO', vDtTransacao);
      putitemXml(viParams, 'IN_AGRUPA', False);
      newinstance 'TRASVCO010', 'TRASVCO010A', 'TRANSACTION=FALSE';
      voParams := activateCmp('TRASVCO010A', 'agrupaItemTransacao', viParams); (*,,,, *)
      if (xStatus < 0) then begin
        Result := voParams;
        return(-1); exit;
      end;
    end;
  end;

  return(0); exit;
end;


end.
