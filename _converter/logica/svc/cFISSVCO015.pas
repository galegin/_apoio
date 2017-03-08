unit cFISSVCO015;

interface

(*
FIS_NF / FIS_NFC / FIS_NFCCEXML / FIS_NFCCORR / FIS_NFE / FIS_NFECF / FIS_NFEINUT /
FIS_NFES / FIS_NFEXML / FIS_NFEXP / FIS_NFIMP / FIS_NFIMPOSTO / FIS_NFISELOENT /
FIS_NFITEM / FIS_NFITEMAD / FIS_NFITEMCONSIG / FIS_NFITEMDESP / FIS_NFITEMDEVT /
FIS_NFITEMDEVV / FIS_NFITEMDI / FIS_NFITEMIMPOST / FIS_NFITEMLOTE / FIS_NFITEMPLOTE /
FIS_NFITEMPPRDFIN / FIS_NFITEMPROC / FIS_NFITEMPROD / FIS_NFITEMSERIAL / FIS_NFITEMUN /
FIS_NFITEMVL / FIS_NFNSU / FIS_NFREF / FIS_NFREMDES / FIS_NFSELOENT / FIS_NFSELOFIS /
FIS_NFTRANSP / FIS_NFVENCAD / FIS_NFVENCTO
*)

uses
  Classes, SysUtils, Math, DBClient, DB;

type
  T_FISSVCO015 = class
  published
    function buscaCFOP(pParams : String) : String;
    function buscaCST(pParams : String) : String;
    function calculaImpostoCapa(pParams : String) : String;
    function calculaImpostoItem(pParams : String) : String;
  end;

implementation

uses
  cParametro, cActivate, cDataset, cFuncao, cXml, cStatus, dModulo;

var
  gCdEmpresaValorEmp,
  gCdEmpresaValorSis,
  gNaturezaComercialEmp,
  gCdAtividadeVarejista,
  gPrAliqICMSManaus,
  gPrAplicMvaSubTrib,
  gCdServico,
  gTpModDctoFiscal,
  gTpOrigemEmissao,
  gCdDecreto,
  gCdDecretoItemCapa,
  gPrIPI,
  gTpAreaComercioOrigem,
  gTpAreaComercioDestino,
  gVlFrete,
  gVlSeguro,
  gVlDespAcessor,
  gTpRegimeOrigem,
  gVlTotalLiquido,
  gVlTotalLiquidoICMS,
  gVlTotalBruto,
  gVlIPI,
  gVlICMS : Real;

  gCdCST,
  gDsUFOrigem,
  gDsUFDestino,
  gCdClasRegEspecialSC,
  gDsLstModDctoFiscalAT,
  gDsLstCfopIpiBcPisCof : String;

  gInImpostoOffLine,
  gInPDVOtimizado,
  gInAtivaDecreto52104,
  gInSomaFreteBaseICMS,
  gInCalcIpiOutEntSai,
  gInCalculaIcmsEntSimples,
  gInArredondaTruncaIcms,
  gInDescontaPisCofinsAlc,
  gInDescontaPisCofinsZfm,
  gInRedBaseIcms,
  gInProdPropria,
  gInVarejista,
  gInPjIsento,
  gInOptSimples,
  gInContribuinte,
  gInProdPropriaDec1643 : Boolean;

  vParams, vResult : String;

  gGER_OPERACAO,
  gPES_PESSOA,
  gPES_PESFISICA,
  gPES_PESJURIDICA,
  gPES_PESSOACLAS,  
  gPES_PFADIC,
  gPES_CLIENTE,
  gPRD_PRODUTO,
  gCDF_MPTER,
  gFIS_IMPOSTO,
  gFIS_REGRAFISCAL,
  gFIS_REGRASRV,
  gFIS_REGRAIMPOSTO,
  gFIS_TIPI,
  gFIS_CST,
  gFIS_INFOFISCAL,
  gPRD_PRDREGRAFISCAL,
  gFIS_DECRETOCAPA,
  gFIS_DECRETO,
  gFIS_ALIQUOTAICMSUF : String;

  tFIS_IMPOSTO,
  tTMP_NR09 : TcDataset;

  procedure SetEntidadeTemp();
  begin
    if (tFIS_IMPOSTO = nil) then begin
      tFIS_IMPOSTO := gModulo.GetDataSet('tFIS_IMPOSTO');
      with tFIS_IMPOSTO do begin
        AdicionarField('CD_IMPOSTO', cNUMERO, '2');
        AdicionarField('DT_INIVIGENCIA', cDATA, '10');
        AdicionarField('PR_ALIQUOTA', cNUMERO, '10');
        AdicionarField('TP_SITUACAO', cNUMERO, '2');
        AdicionarField('VL_IMPOSTO', cNUMERO, '15');
        AdicionarField('VL_OUTRO', cNUMERO, '15');
        AdicionarField('VL_ISENTO', cNUMERO, '15');
        AdicionarField('VL_BASECALC', cNUMERO, '15');
        AdicionarField('PR_REDUBASE', cNUMERO, '6');
        AdicionarField('PR_BASECALC', cNUMERO, '6');
        AdicionarField('CD_CST', cALFA, '3');
        CreateDataSet();
        IndexFieldNames := 'CD_IMPOSTO';
      end;
    end else begin
      tFIS_IMPOSTO.EmptyDataSet();
    end;

    if (tTMP_NR09 = nil) then begin
      tTMP_NR09 := gModulo.GetDataSet('tTMP_NR09');
      with tTMP_NR09 do begin
        AdicionarField('NR_GERAL', cNUMERO, '9');
        CreateDataSet();
        IndexFieldNames := 'NR_GERAL';
      end;
    end else begin
      tTMP_NR09.EmptyDataSet();
    end;
  end;

  procedure GetParam(pCdEmpresa : Real);
  var
    viParams, voParams, vDsLstCFOP : String;
    vInOptSimples : Boolean;
    vNrCFOP : Real;
  begin
    if (pCdEmpresa = 0) then begin
      pCdEmpresa := itemXmlF('CD_EMPRESA', PARAM_GLB);
    end;

    (* parametro corporativo *)
    viParams := '';
    putitem(viParams, 'CD_EMPVALOR');
    putitem(viParams, 'CD_CLAS_REG_ESPECIAL_SC');
    putitem(viParams, 'CD_ATIVIDADE_VAREJISTA');
    putitem(viParams, 'PR_ALIQ_ICMS_MANAUS');
    putitem(viParams, 'IN_PRODPROPRIA_DEC1643');
    putitem(viParams, 'DS_LST_CFOP_IPI_BC_PISCOF');
    voParams := TC_Parametro.GetParametro(viParams);

    gCdEmpresaValorSis := itemXmlF('CD_EMPVALOR', voParams);
    gCdClasRegEspecialSC := itemXml('CD_CLAS_REG_ESPECIAL_SC', voParams);
    gCdAtividadeVarejista := itemXmlF('CD_ATIVIDADE_VAREJISTA', voParams);
    gPrAliqICMSManaus := itemXmlF('PR_ALIQ_ICMS_MANAUS', voParams);
    gInProdPropriaDec1643 := itemXmlB('IN_PRODPROPRIA_DEC1643', voParams);
    gDsLstCfopIpiBcPisCof := itemXml('DS_LST_CFOP_IPI_BC_PISCOF', voParams);

    (* parametro empresa *)
    viParams := '';
    putitem(viParams, 'CD_EMPRESA_VALOR');
    putitem(viParams, 'IN_OPT_SIMPLES');
    putitem(viParams, 'IN_IMPOSTO_OFFLINE');
    putitem(viParams, 'IN_PDV_OTIMIZADO');
    putitem(viParams, 'IN_ATIVA_DECRETO_52104');
    putitem(viParams, 'NATUREZA_COMERCIAL_EMP');
    putitem(viParams, 'IN_SOMA_FRETE_BASEICMS');
    putitem(viParams, 'IN_CALC_IPI_OUT_ENT_SAI');
    putitem(viParams, 'IN_CALC_ICMS_ENT_SIMPLES');
    putitem(viParams, 'PR_APLIC_MVA_SUB_TRIB');
    putitem(viParams, 'IN_ARREDONDA_TRUNCA_ICMS');
    putitem(viParams, 'DS_LST_MODDCTOFISCAL_AT');
    putitem(viParams, 'IN_DESCONTA_PISCOFINS_ALC');
    putitem(viParams, 'IN_DESCONTA_PISCOFINS_ZFM');
    putitem(viParams, 'IN_RED_BASE_ICMS');
    voParams := TC_Parametro.GetParamEmpresa(pCdEmpresa, viParams);

    gCdEmpresaValorEmp := itemXmlF('CD_EMPRESA_VALOR' , voParams);
    vInOptSimples := itemXmlB('IN_OPT_SIMPLES', voParams);

    gInImpostoOffLine := itemXmlB('IN_IMPOSTO_OFFLINE', voParams);
    gInPDVOtimizado  := itemXmlB('IN_PDV_OTIMIZADO', voParams);
    gInAtivaDecreto52104 := itemXmlB('IN_ATIVA_DECRETO_52104', voParams);
    gNaturezaComercialEmp := itemXmlF('NATUREZA_COMERCIAL_EMP', voParams);
    gInSomaFreteBaseICMS := itemXmlB('IN_SOMA_FRETE_BASEICMS', voParams);
    gInCalcIpiOutEntSai := itemXmlB('IN_CALC_IPI_OUT_ENT_SAI', voParams);
    gInCalculaIcmsEntSimples := itemXmlB('IN_CALC_ICMS_ENT_SIMPLES' , voParams);
    gPrAplicMvaSubTrib := itemXmlF('PR_APLIC_MVA_SUB_TRIB', voParams);
    gInArredondaTruncaIcms := itemXmlB('IN_ARREDONDA_TRUNCA_ICMS', voParams);
    gDsLstModDctoFiscalAT := itemXml('DS_LST_MODDCTOFISCAL_AT', voParams);
    gInDescontaPisCofinsAlc := itemXmlB('IN_DESCONTA_PISCOFINS_ALC', voParams);
    gInDescontaPisCofinsZfm := itemXmlB('IN_DESCONTA_PISCOFINS_ZFM', voParams);
    gInRedBaseIcms  := itemXmlB('IN_RED_BASE_ICMS', voParams);

    SetEntidadeTemp();

    tTMP_NR09.EmptyDataSet();

    vDsLstCFOP := gDsLstCfopIpiBcPisCof;
    if (vDsLstCFOP <> '') then begin
      repeat
        vNrCFOP := SetarValorF(getitemGld(vDsLstCFOP,1),'0');
        delitemGld(vDsLstCFOP,1);
        if (vNrCFOP > 0) then begin
          if (tTMP_NR09.Locate('NR_GERAL', vNrCFOP, []) = False) then begin
            tTMP_NR09.Append();
            tTMP_NR09.FieldByName('NR_GERAL').AsFloat := vNrCFOP;
            tTMP_NR09.Post();
          end;
        end;  
      until(vDsLstCFOP = '')
    end;

    return(0);
  end;

  //-----------------
  function calculaICMS(pParams : String) : String;
  //-----------------
  const
    cDS_METHOD = 'ADICIONAL=Operação: FISSVCO015.calculaICMS()';
  var
    vCdCST : String;
    vVlCalc, vVlBaseCalc, vCdDecreto, vTpProduto : Real;
    vDtSistema : TDateTime;
    vInDecreto, vInPrRedBase, vInPrRedImposto, vInReducao : Boolean;
  begin
 
    vDtSistema := itemXmlD('DT_SISTEMA', PARAM_GLB);

    if (gInImpostoOffLine = True) then begin
      tFIS_IMPOSTO.Cancel;
      return(-1); exit;
    end;

    gVlICMS := 0;
    gCdDecreto := 0;
    vCdDecreto := 0;
    vInDecreto := False;

    if (itemXmlF('CD_DECRETO', gFIS_DECRETO) > 0) then begin
      vCdDecreto := itemXmlF('CD_DECRETO', gFIS_DECRETO);
      if (itemXmlD('DT_INIVIGENCIA', gFIS_DECRETO) > 0) and (vDtSistema < itemXmlD('DT_INIVIGENCIA', gFIS_DECRETO)) then begin
        vCdDecreto := 0;
      end;
      if (itemXmlD('DT_FIMVIGENCIA', gFIS_DECRETO) > 0) and (vDtSistema > itemXmlD('DT_FIMVIGENCIA', gFIS_DECRETO)) then begin
        vCdDecreto := 0;
      end;
    end;

    vCdCST := Copy(gCdCST,2,2);
    vTpProduto := StrToFloat(Copy(gCdCST,1,1));
  
    if (vCdCST = '60') then begin
      tFIS_IMPOSTO.Cancel;
      gCdDecreto := vCdDecreto;
      return(-1); exit;
    end else if (vCdCST <> '00') and (vCdCST <> '10') and (vCdCST <> '20') and (vCdCST <> '30') and (vCdCST <> '40') and (vCdCST <> '41') and (vCdCST <> '50') and (vCdCST <> '51') and (vCdCST <> '70') and (vCdCST <> '90') then begin
      if (vCdDecreto <> 2155) and (vCdDecreto <> 1020) and (vCdDecreto <> 45471) and (vCdDecreto <> 52364)
      and (vCdDecreto <> 23731) and (vCdDecreto <> 23732) and (vCdDecreto <> 23733) and (vCdDecreto <> 23734)
      and (vCdDecreto <> 23735) and (vCdDecreto <> 10901) and (vCdDecreto <> 10902) and (vCdDecreto <> 10903)
      and (vCdDecreto <> 10904) and (vCdDecreto <> 2559) and (vCdDecreto <> 52804)
      and (vCdDecreto <> 10201) and (vCdDecreto <> 10202) and (vCdDecreto <> 10203) then begin
        tFIS_IMPOSTO.Cancel;
        gCdDecreto := vCdDecreto;
        return(-1); exit;
      end;
    end;

    if (itemXml('TP_ALIQICMS', gFIS_REGRAFISCAL) = '') then begin
      if (itemXml('TP_MODALIDADE', gGER_OPERACAO) = 'E') then begin // Conhecimento de Frete
        tFIS_IMPOSTO.FieldByName('PR_ALIQUOTA').asFloat := itemXmlF('PR_ALIQICMS', gFIS_REGRAFISCAL);
      end else begin
        if (gTpAreaComercioOrigem = 2) and (gTpAreaComercioDestino = 2) then begin // 2 - Manaus
          tFIS_IMPOSTO.FieldByName('PR_ALIQUOTA').asFloat := gPrAliqICMSManaus;
        end else begin
          if (gDsUFOrigem = 'MG') and (gDsUFDestino = 'MG')  then begin
            if (itemXmlF('PR_ALIQICMS', gFIS_REGRAFISCAL) > 0) and (gInContribuinte = True) and (gInProdPropria = True) then begin
              tFIS_IMPOSTO.FieldByName('PR_ALIQUOTA').asFloat := itemXmlF('PR_ALIQICMS', gFIS_REGRAFISCAL);
            end else begin
              tFIS_IMPOSTO.FieldByName('PR_ALIQUOTA').asFloat := itemXmlF('PR_ALIQICMS', gFIS_ALIQUOTAICMSUF);
            end;
          end else begin
            //A alíquota diferenciada so pode se aplicada em NF estadual
            //Nas outra é obrigatorio respeitar a aliquota interestadual
            //A observação acima somente é valido quando há somente uma alíquota interna.
            //A lógica abaixo foi implementada p/ atender o Estado do PR que passou a trabalhar com várias alíquotas internas
            //Neste caso será obedecido o que está na regra fiscal tanto dentro do Estado quanto fora,
            //desde que seja venda p/ consumidor final
            if (itemXmlF('PR_ALIQICMS', gFIS_REGRAFISCAL) > 0)  then begin
              if (gDsUFOrigem = gDsUFDestino) or (gInContribuinte = False) then begin
                tFIS_IMPOSTO.FieldByName('PR_ALIQUOTA').asFloat := itemXmlF('PR_ALIQICMS', gFIS_REGRAFISCAL);
              end else begin
                tFIS_IMPOSTO.FieldByName('PR_ALIQUOTA').asFloat := itemXmlF('PR_ALIQICMS', gFIS_ALIQUOTAICMSUF);
              end;
            end else begin
              tFIS_IMPOSTO.FieldByName('PR_ALIQUOTA').asFloat := itemXmlF('PR_ALIQICMS', gFIS_ALIQUOTAICMSUF);
            end;
          end;
        end;
      end;
    end else begin
      if (itemXml('TP_ALIQICMS', gFIS_REGRAFISCAL) = 'A')then begin // Para transações de operação Estadual
        if (itemXmlF('PR_ALIQICMS', gFIS_REGRAFISCAL) > 0)  then begin
          if (gDsUFOrigem = gDsUFDestino) then begin
            tFIS_IMPOSTO.FieldByName('PR_ALIQUOTA').asFloat := itemXmlF('PR_ALIQICMS', gFIS_REGRAFISCAL);
          end else begin
            tFIS_IMPOSTO.FieldByName('PR_ALIQUOTA').asFloat := itemXmlF('PR_ALIQICMS', gFIS_ALIQUOTAICMSUF);
          end;
        end else begin
          tFIS_IMPOSTO.FieldByName('PR_ALIQUOTA').asFloat := itemXmlF('PR_ALIQICMS', gFIS_ALIQUOTAICMSUF);
        end;
      end else if (itemXml('TP_ALIQICMS', gFIS_REGRAFISCAL) = 'B')then begin // Para transações de operação Interestadual
        if (itemXmlF('PR_ALIQICMS', gFIS_REGRAFISCAL) > 0)  then begin
          if (gDsUFOrigem <> gDsUFDestino) then begin
            tFIS_IMPOSTO.FieldByName('PR_ALIQUOTA').asFloat := itemXmlF('PR_ALIQICMS', gFIS_REGRAFISCAL);
          end else begin
            tFIS_IMPOSTO.FieldByName('PR_ALIQUOTA').asFloat := itemXmlF('PR_ALIQICMS', gFIS_ALIQUOTAICMSUF);
          end;
        end else begin 
          tFIS_IMPOSTO.FieldByName('PR_ALIQUOTA').asFloat := itemXmlF('PR_ALIQICMS', gFIS_ALIQUOTAICMSUF);
        end;
      end else if (itemXml('TP_ALIQICMS', gFIS_REGRAFISCAL) = 'C')then begin // Para transações de ambas as operações
        if (itemXmlF('PR_ALIQICMS', gFIS_REGRAFISCAL) > 0)  then begin
          tFIS_IMPOSTO.FieldByName('PR_ALIQUOTA').asFloat := itemXmlF('PR_ALIQICMS', gFIS_REGRAFISCAL);
        end else begin 
          tFIS_IMPOSTO.FieldByName('PR_ALIQUOTA').asFloat := itemXmlF('PR_ALIQICMS', gFIS_ALIQUOTAICMSUF);
        end;
      end;
    end;
    //Emissão de terceiro e diferente de devolucao ou devolução de compra com emissão própria
    if (((gTpOrigemEmissao = 2) and (itemXml('TP_MODALIDADE', gGER_OPERACAO) <> '3'))
     or ((gTpOrigemEmissao = 1) and (itemXml('TP_MODALIDADE', gGER_OPERACAO) = '3')))
    and (itemXml('TP_OPERACAO', gGER_OPERACAO) = 'S') then begin
      if not (gInCalculaIcmsEntSimples) then begin
        if (gTpRegimeOrigem = 2) or (gTpRegimeOrigem = 3) then begin //2-Simples 3-EPP
          tFIS_IMPOSTO.FieldByName('PR_ALIQUOTA').asFloat := 0;
        end;
      end;
      if (gTpOrigemEmissao = 1) then begin
        if (gInOptSimples = True) then begin
          tFIS_IMPOSTO.FieldByName('PR_ALIQUOTA').asFloat := 0;
        end;
      end;
    end else begin
      if (gInOptSimples = True) then begin
        if (gDsUFOrigem <> 'PR')
        and ((itemXmlF('TP_DOCTO', gGER_OPERACAO) = 2) or (itemXmlF('TP_DOCTO', gGER_OPERACAO) = 3))
        and ((vCdCST = '00') or (vCdCST = '20') or (vCdCST = '51')) then begin // 2 - ECF - Nao concomitante / 3 - ECF - Concomitante;
        end else begin
          tFIS_IMPOSTO.FieldByName('PR_ALIQUOTA').asFloat := 0;
        end;
      end;
    end;
 
    if (itemXml('TP_MODALIDADE', gGER_OPERACAO) = '4') and (itemXml('TP_OPERACAO', gGER_OPERACAO) = 'S')then begin // Venda
      if (vTpProduto = 1) then begin //Produto Importado
        if (gDsUFOrigem = 'ES') and (gDsUFDestino = 'ES') then begin
          if (gInContribuinte = True) then begin
            if (gInVarejista = True) then begin
              tFIS_IMPOSTO.FieldByName('PR_ALIQUOTA').asFloat := itemXmlF('PR_ALIQICMS', gFIS_ALIQUOTAICMSUF);
            end else begin
              tFIS_IMPOSTO.FieldByName('PR_ALIQUOTA').asFloat := 12;
            end;
          end else begin
            tFIS_IMPOSTO.FieldByName('PR_ALIQUOTA').asFloat := itemXmlF('PR_ALIQICMS', gFIS_ALIQUOTAICMSUF);
          end;
        end;
      end;
    end;
    if (itemXmlF('TP_MODALIDADE', gGER_OPERACAO) = 4) and (itemXml('TP_OPERACAO', gGER_OPERACAO) = 'E') then begin // Compra
      if (gDsUFOrigem = 'SC') and (gDsUFDestino = 'SC') then begin
        if (gTpOrigemEmissao = 2) then begin // 2 - Emissao terceiro
          if (gTpRegimeOrigem = 2) or (gTpRegimeOrigem = 3) then begin //2-Simples 3-EPP
            tFIS_IMPOSTO.FieldByName('PR_ALIQUOTA').asFloat := 7;
          end;
        end;
      end;
    end;
    if (vCdDecreto = 949) then begin // Este decreto foi revogado pelo decreto 6142 a partir de fevereiro/2006
      if (gDsUFOrigem = 'PR') then begin
        if (gTpOrigemEmissao = 1) then begin //Emissão própria
          if (gDsUFDestino = 'PR') and (gInContribuinte = True) then begin
            vInDecreto := True;
          end;
        end else begin 
          if (gDsUFDestino = 'PR') and (gInContribuinte = True) then begin
            vInDecreto := True;
          end;
        end;
      end;
      if (vInDecreto = True) then begin
        tFIS_IMPOSTO.FieldByName('PR_BASECALC').asFloat := 66.67;
        vVlCalc := gVlTotalLiquidoICMS * tFIS_IMPOSTO.FieldByName('PR_BASECALC').asFloat / 100;
        tFIS_IMPOSTO.FieldByName('VL_BASECALC').asFloat := roundto(vVlCalc, 6);
        gVlTotalLiquidoICMS := gVlTotalLiquidoICMS - tFIS_IMPOSTO.FieldByName('VL_BASECALC').asFloat;
        vCdCST := '20';
        gCdDecreto := vCdDecreto;
      end;
    end else if (vCdDecreto = 6692) then begin // Este decreto é somente para o Estado do Mato Grosso do Sul
      if (gDsUFOrigem = 'MS') then begin
        if (gDsUFDestino = 'MS') and (gInContribuinte = True) then begin
          vInDecreto := True;
        end;
        if (vInDecreto = True) then begin
          tFIS_IMPOSTO.FieldByName('PR_BASECALC').asFloat := 41.176;
          vVlCalc := gVlTotalLiquidoICMS * tFIS_IMPOSTO.FieldByName('PR_BASECALC').asFloat / 100;
          tFIS_IMPOSTO.FieldByName('VL_BASECALC').asFloat := roundto(vVlCalc, 6);
          gVlTotalLiquidoICMS := gVlTotalLiquidoICMS - tFIS_IMPOSTO.FieldByName('VL_BASECALC').asFloat;
          vCdCST := '20';
          gCdDecreto := vCdDecreto;
        end;
      end;
    end else if (vCdDecreto = 6142) then begin
      if (gInOptSimples <> True) then begin
        if (gDsUFOrigem = 'PR')   then begin
          if (gTpOrigemEmissao = 1) then begin //Emissão própria
            if (gDsUFDestino = 'PR') and (gInContribuinte = True) then begin
              vInDecreto := True;
            end;
          end else begin 
            if (gDsUFDestino = 'PR') and (gInContribuinte = True) then begin
              vInDecreto := True;
            end;
          end;
        end;
      end;
      if (vInDecreto = True) then begin
        gCdDecreto := vCdDecreto;
      end;
    end else if (vCdDecreto = 11589)  then begin
      if (gDsUFOrigem = 'PR') then begin
        if (gTpOrigemEmissao = 1) then begin //Emissão própria
          if (gDsUFDestino = 'PR') and (gInContribuinte = True) then begin
            vInDecreto := True;
          end;
        end else begin
          if (gDsUFDestino = 'PR') and (gInContribuinte = True) then begin
            vInDecreto := True;
          end;
        end;
      end;
      if (vInDecreto = True) then begin
        Result := SetStatus(STS_ERROR, 'GEN0001', 'Decreto(11.589) não contemplado na legislação tributária do Paraná! Entrar em contato com os Analistas da área Fiscal da VirtualAge', cDS_METHOD);
        tFIS_IMPOSTO.FieldByName('PR_ALIQUOTA').asFloat := 12;
        gCdDecreto := vCdDecreto;
        return(-1); exit;
      end;
    end else if (vCdDecreto = 48786) or (vCdDecreto = 48958) or (vCdDecreto = 48959) or (vCdDecreto = 49115) then begin // O decreto 48042 foi substituido pelo 55652
      if (gDsUFOrigem = 'SP') then begin
        if (gTpOrigemEmissao = 1) then begin //Emissão própria
          //Venda / Devolução de venda
          if ((itemXml('TP_OPERACAO', gGER_OPERACAO) = 'S') and (itemXmlF('TP_MODALIDADE', gGER_OPERACAO) = 4))
          or ((itemXml('TP_OPERACAO', gGER_OPERACAO) = 'E') and (itemXmlF('TP_MODALIDADE', gGER_OPERACAO) = 3)) then begin
            if (gDsUFDestino = 'SP') and (gInContribuinte = True) then begin
              if (gInAtivaDecreto52104 = True) then begin
                vInDecreto := True;
              end else begin
                if (gTpRegimeOrigem <> 2) and (gTpRegimeOrigem <> 3) then begin //2-Simples 3-EPP
                  vInDecreto := True;
                end;
              end;
            end;
            if (gInProdPropria = True) then begin
            end else begin
              vInDecreto := False;
            end;
          end else begin
            if (gDsUFDestino = 'SP') and (gInContribuinte = True) then begin
              if (gInAtivaDecreto52104 = True) then begin
                vInDecreto := True;
              end else begin
                if (gTpRegimeOrigem <> 2) and (gTpRegimeOrigem <> 3) then begin //2-Simples 3-EPP
                  vInDecreto := True;
                end;
              end;
            end;
          end;
        end else begin
          if (gDsUFDestino = 'SP') and (gInContribuinte = True) then begin
            if (gInAtivaDecreto52104 = True) then begin
              if (vTpProduto = 0) then begin //Nacional
                vInDecreto := True;
              end;
            end else begin
              if (gTpRegimeOrigem <> 2) and (gTpRegimeOrigem <> 3) then begin //2-Simples 3-EPP
                if (vTpProduto = 0) then begin //Nacional
                  vInDecreto := True;
                end;
              end;
            end;
          end;
        end;
      end;
      if (vInDecreto = True) then begin
        if (tFIS_IMPOSTO.FieldByName('PR_ALIQUOTA').asFloat <> 18) and (tFIS_IMPOSTO.FieldByName('PR_ALIQUOTA').asFloat <> 25) then begin
          vInDecreto := False;
        end;
      end;
      if (vInDecreto = True) then begin
        if (tFIS_IMPOSTO.FieldByName('PR_ALIQUOTA').asFloat = 18) then begin
          tFIS_IMPOSTO.FieldByName('PR_BASECALC').asFloat := 66.67;
        end else begin 
          tFIS_IMPOSTO.FieldByName('PR_BASECALC').asFloat := 48;
        end;
        vCdCST := '51';
        vVlCalc := gVlTotalLiquidoICMS * tFIS_IMPOSTO.FieldByName('PR_BASECALC').asFloat / 100;
        tFIS_IMPOSTO.FieldByName('VL_BASECALC').asFloat := roundto(vVlCalc, 6);
        gVlTotalLiquidoICMS := gVlTotalLiquidoICMS - tFIS_IMPOSTO.FieldByName('VL_BASECALC').asFloat;
        gCdDecreto := vCdDecreto;
      end;
    end else if (vCdDecreto = 55652) then begin // Este decreto substitui o 48042
      if (gDsUFOrigem = 'SP') then begin
        if (gTpOrigemEmissao = 1) then begin //Emissão própria
          //Venda / Devolução de venda
          if ((itemXml('TP_OPERACAO', gGER_OPERACAO) = 'S') and (itemXmlF('TP_MODALIDADE', gGER_OPERACAO) = 4))
          or ((itemXml('TP_OPERACAO', gGER_OPERACAO) = 'E') and (itemXmlF('TP_MODALIDADE', gGER_OPERACAO) = 3)) then begin
            if (gDsUFDestino = 'SP') and (gInContribuinte = True) then begin
              if (gInAtivaDecreto52104 = True) then begin
                vInDecreto := True;
              end else begin
                if (gTpRegimeOrigem <> 2) and (gTpRegimeOrigem <> 3) then begin //2-Simples 3-EPP
                  vInDecreto := True;
                end;
              end;
            end;
            if (gInProdPropria = True) then begin
            end else begin
              vInDecreto := False;
            end;
          end else begin
            if (gDsUFDestino = 'SP') and (gInContribuinte = True) then begin
              if (gInAtivaDecreto52104 = True) then begin
                vInDecreto := True;
              end else begin
                if (gTpRegimeOrigem <> 2) and (gTpRegimeOrigem <> 3) then begin //2-Simples 3-EPP
                  vInDecreto := True;
                end;
              end;
            end;
          end;
        end else begin
          if (gDsUFDestino = 'SP') and (gInContribuinte = True) then begin
            if (gInAtivaDecreto52104 = True) then begin
              if (vTpProduto = 0) then begin //Nacional
                vInDecreto := True;
              end;
            end else begin
              if (gTpRegimeOrigem <> 2) and (gTpRegimeOrigem <> 3) then begin //2-Simples 3-EPP
                if (vTpProduto = 0) then begin //Nacional
                  vInDecreto := True;
                end;
              end;
            end;
          end;
        end;
      end;
      if (vInDecreto = True) then begin
        if (tFIS_IMPOSTO.FieldByName('PR_ALIQUOTA').asFloat <> 18) and (tFIS_IMPOSTO.FieldByName('PR_ALIQUOTA').asFloat <> 25) then begin
          vInDecreto := False;
        end;
      end;
      if (vInDecreto = True) then begin
        if (itemXmlF('PR_REDUBASE', gFIS_REGRAFISCAL) > 0) then begin
          tFIS_IMPOSTO.FieldByName('PR_REDUBASE').asFloat := itemXmlF('PR_REDUBASE', gFIS_REGRAFISCAL);
          tFIS_IMPOSTO.FieldByName('PR_BASECALC').asFloat := 100 - itemXmlF('PR_REDUBASE', gFIS_REGRAFISCAL);
        end else begin
          if (tFIS_IMPOSTO.FieldByName('PR_ALIQUOTA').asFloat = 18) then begin
            tFIS_IMPOSTO.FieldByName('PR_BASECALC').asFloat := 38.89;
          end else begin
            tFIS_IMPOSTO.FieldByName('PR_BASECALC').asFloat := 28;
          end;
        end;
        vCdCST := '51';
        vVlCalc := gVlTotalLiquidoICMS * tFIS_IMPOSTO.FieldByName('PR_BASECALC').asFloat / 100;
        tFIS_IMPOSTO.FieldByName('VL_BASECALC').asFloat := roundto(vVlCalc, 6);
        gVlTotalLiquidoICMS := gVlTotalLiquidoICMS - tFIS_IMPOSTO.FieldByName('VL_BASECALC').asFloat;
        gCdDecreto := vCdDecreto;
      end;
    end else if (vCdDecreto = 2401) then begin
      if (gTpOrigemEmissao = 1) then begin //Emissão própria
        //Venda / Devolução de venda
        if ((itemXml('TP_OPERACAO', gGER_OPERACAO) = 'S') and (itemXmlF('TP_MODALIDADE', gGER_OPERACAO) = 4))
        or ((itemXml('TP_OPERACAO', gGER_OPERACAO) = 'E') and (itemXmlF('TP_MODALIDADE', gGER_OPERACAO) = 3)) then begin
          if (gDsUFDestino <> gDsUFOrigem) and (gInContribuinte = True) then begin
            vInDecreto := True;
          end;
        end else begin 
          if (gDsUFDestino <> gDsUFOrigem) and (gInContribuinte = True) then begin
            vInDecreto := True;
          end;
        end;
      end else begin
        if (gDsUFDestino <> gDsUFOrigem) and (gInContribuinte = True) then begin
          vInDecreto := True;
        end;
      end;
      if (vInDecreto = True) then begin
        if (tFIS_IMPOSTO.FieldByName('PR_ALIQUOTA').asFloat <> 7) and (tFIS_IMPOSTO.FieldByName('PR_ALIQUOTA').asFloat <> 12) then begin
          vInDecreto := False;
        end;
      end;
      if (vInDecreto = True) then begin
        if (tFIS_IMPOSTO.FieldByName('PR_ALIQUOTA').asFloat = 7) then begin
          tFIS_IMPOSTO.FieldByName('PR_REDUBASE').asFloat := 9.9;
        end else if (tFIS_IMPOSTO.FieldByName('PR_ALIQUOTA').asFloat = 12) then begin
          tFIS_IMPOSTO.FieldByName('PR_REDUBASE').asFloat := 10.49;
        end;
        vVlCalc := gVlTotalLiquidoICMS * tFIS_IMPOSTO.FieldByName('PR_REDUBASE').asFloat / 100;
        tFIS_IMPOSTO.FieldByName('VL_BASECALC').asFloat := gVlTotalLiquidoICMS - roundto(vVlCalc, 6);
        gVlTotalLiquidoICMS := roundto(vVlCalc, 6);
         vCdCST := '20';
        gCdDecreto := vCdDecreto;
      end;
    end else if (vCdDecreto = 1643) and ((gInProdPropriaDec1643 = False) or (gInProdPropria = True)) then begin
      if (gDsUFOrigem = 'ES') and (gDsUFDestino = 'ES') then begin
        if (gInContribuinte = True) and ((gTpRegimeOrigem = 2) or (gTpRegimeOrigem = 3))then begin // 2-Simples 3-EPP
          tFIS_IMPOSTO.FieldByName('PR_BASECALC').asFloat := 41.177;
          tFIS_IMPOSTO.FieldByName('PR_REDUBASE').asFloat := 58.823;
          vInDecreto := True;
        end else if (gInContribuinte = True) and (gTpRegimeOrigem <> 2) and (gTpRegimeOrigem <> 3)then begin // Empresa Normal
          if (gDsUFDestino <> gDsUFOrigem) then begin
            // Conforme consulta ao IOB pelo Sr. Deusdete, nao foi confirmado esta reducao para operacao interestadual
          end else begin
            tFIS_IMPOSTO.FieldByName('PR_BASECALC').asFloat := 70.589;
            tFIS_IMPOSTO.FieldByName('PR_REDUBASE').asFloat := 29.411;
            vInDecreto := True;
          end;
        end;

        if (vInDecreto = True) then begin
          vVlCalc := gVlTotalLiquidoICMS * tFIS_IMPOSTO.FieldByName('PR_BASECALC').asFloat / 100;
          tFIS_IMPOSTO.FieldByName('VL_BASECALC').asFloat := roundto(vVlCalc, 6);
          gVlTotalLiquidoICMS := gVlTotalLiquidoICMS - tFIS_IMPOSTO.FieldByName('VL_BASECALC').asFloat;
          vCdCST := '20';
          gCdDecreto := vCdDecreto;
        end;
      end;
    end else if (vCdDecreto = 44238) then begin // Decreto valido para o estado do Rio Grande do Sul
      if (gDsUFOrigem = 'RS') and (gDsUFDestino = 'RS') then begin
        if (gInContribuinte = True)
        and ((itemXml('TP_MODALIDADE', gGER_OPERACAO) = '3') or (itemXmlF('TP_MODALIDADE', gGER_OPERACAO) = 4)) then begin // 3 - Devolucao / 4 - Venda/Compra
          if (gTpOrigemEmissao = 1) then begin //Emissão própria
            if (gInProdPropria = True) then begin
              tFIS_IMPOSTO.FieldByName('PR_BASECALC').asFloat := 70.589;
              tFIS_IMPOSTO.FieldByName('PR_REDUBASE').asFloat := 29.411;
              vInDecreto := True;
            end;
          end else begin
            tFIS_IMPOSTO.FieldByName('PR_BASECALC').asFloat := 70.589;
            tFIS_IMPOSTO.FieldByName('PR_REDUBASE').asFloat := 29.411;
            vInDecreto := True;
          end;
        end;

        if (vInDecreto = True) then begin
          vVlCalc := gVlTotalLiquidoICMS * tFIS_IMPOSTO.FieldByName('PR_BASECALC').asFloat / 100;
          tFIS_IMPOSTO.FieldByName('VL_BASECALC').asFloat := roundto(vVlCalc, 6);
          gVlTotalLiquidoICMS := gVlTotalLiquidoICMS - tFIS_IMPOSTO.FieldByName('VL_BASECALC').asFloat;
          vCdCST := '20';
          gCdDecreto := vCdDecreto;
        end;
      end;
    end else if (vCdDecreto = 105) then begin // Decreto valido para o estado de Santa Catarina
      if (gDsUFOrigem = 'SC') then begin
        if (gDsUFDestino = 'SC') and (gInContribuinte = True)
        and (((itemXml('TP_OPERACAO', gGER_OPERACAO) = 'E') and (itemXmlF('TP_MODALIDADE', gGER_OPERACAO) = 4))
          or ((itemXml('TP_OPERACAO', gGER_OPERACAO) = 'S') and (itemXmlF('TP_MODALIDADE', gGER_OPERACAO) = 4))) then begin //Compra / Venda
          if (gCdClasRegEspecialSC <> '') then begin
            vParams := '';
            putitemXml(vParams, 'CD_PESSOA', '');
            putitemXml(vParams, 'CD_TIPOCLAS', gCdClasRegEspecialSC);
            gPES_PESSOACLAS := gModulo.ConsultarXmlUp('PES_PESSOACLAS', 'CD_PESSOA|CD_TIPOCLAS|', vParams);
            if (itemXMl('CD_CLASSIFICACAO', gPES_PESSOACLAS) = 'S') then begin
              tFIS_IMPOSTO.FieldByName('PR_ALIQUOTA').asFloat := 12;
              vCdCST := '00';
              gCdDecreto := vCdDecreto;
              vInDecreto := True;
            end;
          end;
        end;
      end;
    end else if (vCdDecreto = 13214) then begin // Decreto valido para o estado do Paraná
      if (gDsUFOrigem = 'PR') or (gDsUFDestino = 'PR') then begin
        if (gInContribuinte = True) and (itemXmlF('TP_MODALIDADE', gGER_OPERACAO) = 4) then begin // Venda/Compra
          if (tFIS_IMPOSTO.FieldByName('PR_ALIQUOTA').asFloat = 7) then begin
            tFIS_IMPOSTO.FieldByName('PR_BASECALC').asFloat := 100;
            vInDecreto := True;
          end else if (tFIS_IMPOSTO.FieldByName('PR_ALIQUOTA').asFloat = 12) then begin
            tFIS_IMPOSTO.FieldByName('PR_BASECALC').asFloat := 58.332;
            tFIS_IMPOSTO.FieldByName('PR_REDUBASE').asFloat := 41.668;
            vInDecreto := True;
          end else if (tFIS_IMPOSTO.FieldByName('PR_ALIQUOTA').asFloat = 18) then begin
            tFIS_IMPOSTO.FieldByName('PR_BASECALC').asFloat := 38.887;
            tFIS_IMPOSTO.FieldByName('PR_REDUBASE').asFloat := 61.113;
            vInDecreto := True;
          end;
        end;

        if (vInDecreto = True) then begin
          vVlCalc := gVlTotalLiquidoICMS * tFIS_IMPOSTO.FieldByName('PR_BASECALC').asFloat / 100;
          tFIS_IMPOSTO.FieldByName('VL_BASECALC').asFloat := roundto(vVlCalc, 6);
          gVlTotalLiquidoICMS := gVlTotalLiquidoICMS - tFIS_IMPOSTO.FieldByName('VL_BASECALC').asFloat;
          vCdCST := '20';
          gCdDecreto := vCdDecreto;
        end;
      end;
    end else if (vCdDecreto = 12462) then begin // Decreto valido para o estado de Goiás
      if (gDsUFOrigem = 'GO') and (gDsUFDestino = 'GO') then begin
        if (gInContribuinte = True)
        and ((itemXmlF('TP_MODALIDADE', gGER_OPERACAO) = 2) or (itemXmlF('TP_MODALIDADE', gGER_OPERACAO) = 3) or (itemXmlF('TP_MODALIDADE', gGER_OPERACAO) = 4)) then begin
          //2 - Transferencia / 3 - Devolucao / 4 - Venda/Compra
          tFIS_IMPOSTO.FieldByName('PR_BASECALC').asFloat := 58.82;
          tFIS_IMPOSTO.FieldByName('PR_REDUBASE').asFloat := 41.18;
          vInDecreto := True;
        end;

        if (vInDecreto = True) then begin
          vVlCalc := gVlTotalLiquidoICMS * tFIS_IMPOSTO.FieldByName('PR_BASECALC').asFloat / 100;
          tFIS_IMPOSTO.FieldByName('VL_BASECALC').asFloat := roundto(vVlCalc, 6);
          gVlTotalLiquidoICMS := gVlTotalLiquidoICMS - tFIS_IMPOSTO.FieldByName('VL_BASECALC').asFloat;
          vCdCST := '20';
          gCdDecreto := vCdDecreto;
        end;
      end;
    end else begin
      gCdDecreto := vCdDecreto;
    end;

    if (vCdCST = '00') or (vCdCST = '10') then begin
      if (vCdDecreto = 52364)then begin // Decreto do Estado de São Paulo
        if (itemXmlF('PR_REDUBASE', gFIS_REGRAFISCAL) > 0) then begin
          tFIS_IMPOSTO.FieldByName('PR_REDUBASE').asFloat := itemXmlF('PR_REDUBASE', gFIS_REGRAFISCAL);
          tFIS_IMPOSTO.FieldByName('PR_BASECALC').asFloat := 100 - itemXmlF('PR_REDUBASE', gFIS_REGRAFISCAL) ;
          vVlCalc := gVlTotalLiquidoICMS - (gVlTotalLiquidoICMS * tFIS_IMPOSTO.FieldByName('PR_REDUBASE').asFloat / 100);
          tFIS_IMPOSTO.FieldByName('VL_BASECALC').asFloat := roundto(vVlCalc, 6) ;
        end else begin
          tFIS_IMPOSTO.FieldByName('PR_BASECALC').asFloat := 100;
          tFIS_IMPOSTO.FieldByName('VL_BASECALC').asFloat := gVlTotalLiquidoICMS;
        end;
        tFIS_IMPOSTO.FieldByName('VL_OUTRO').asFloat := gVlTotalLiquidoICMS - tFIS_IMPOSTO.FieldByName('VL_BASECALC').asFloat;
      end else if (vCdDecreto = 23731) or (vCdDecreto = 23732) or (vCdDecreto = 23733) or (vCdDecreto = 23734) or (vCdDecreto = 23735)then begin // Decreto do Estado do Paraná
        if (itemXmlF('PR_REDUBASE', gFIS_REGRAFISCAL) > 0) then begin
          tFIS_IMPOSTO.FieldByName('PR_REDUBASE').asFloat := itemXmlF('PR_REDUBASE', gFIS_REGRAFISCAL);
          tFIS_IMPOSTO.FieldByName('PR_BASECALC').asFloat := 100 - itemXmlF('PR_REDUBASE', gFIS_REGRAFISCAL) ;
          vVlCalc := gVlTotalLiquidoICMS - (gVlTotalLiquidoICMS * tFIS_IMPOSTO.FieldByName('PR_REDUBASE').asFloat / 100);
          tFIS_IMPOSTO.FieldByName('VL_BASECALC').asFloat := roundto(vVlCalc, 6) ;
        end else begin
          tFIS_IMPOSTO.FieldByName('PR_BASECALC').asFloat := 100;
          tFIS_IMPOSTO.FieldByName('VL_BASECALC').asFloat := gVlTotalLiquidoICMS;
        end;
        tFIS_IMPOSTO.FieldByName('VL_OUTRO').asFloat := gVlTotalLiquidoICMS - tFIS_IMPOSTO.FieldByName('VL_BASECALC').asFloat;
        gVlTotalLiquidoICMS := tFIS_IMPOSTO.FieldByName('VL_BASECALC').asFloat;
      end else if (vCdDecreto = 10901) or (vCdDecreto = 10902) or (vCdDecreto = 10903) or (vCdDecreto = 10904)then begin // Decreto do Estado de Espirito Santo
        if (itemXmlF('PR_REDUBASE', gFIS_REGRAFISCAL) > 0) then begin
          if (gDsUFOrigem = 'ES') and (gDsUFDestino = 'ES') then begin
            tFIS_IMPOSTO.FieldByName('PR_BASECALC').asFloat := 100;
            tFIS_IMPOSTO.FieldByName('VL_BASECALC').asFloat := gVlTotalLiquidoICMS;
          end else begin
            tFIS_IMPOSTO.FieldByName('PR_REDUBASE').asFloat := itemXmlF('PR_REDUBASE', gFIS_REGRAFISCAL);
            tFIS_IMPOSTO.FieldByName('PR_BASECALC').asFloat := 100 - itemXmlF('PR_REDUBASE', gFIS_REGRAFISCAL) ;
            vVlCalc := gVlTotalLiquidoICMS - (gVlTotalLiquidoICMS * tFIS_IMPOSTO.FieldByName('PR_REDUBASE').asFloat / 100);
            tFIS_IMPOSTO.FieldByName('VL_BASECALC').asFloat := roundto(vVlCalc, 6) ;
          end;
        end else begin
          tFIS_IMPOSTO.FieldByName('PR_BASECALC').asFloat := 100;
          tFIS_IMPOSTO.FieldByName('VL_BASECALC').asFloat := gVlTotalLiquidoICMS;
        end;
        tFIS_IMPOSTO.FieldByName('VL_OUTRO').asFloat := gVlTotalLiquidoICMS - tFIS_IMPOSTO.FieldByName('VL_BASECALC').asFloat;
        gVlTotalLiquidoICMS := tFIS_IMPOSTO.FieldByName('VL_BASECALC').asFloat;
      end else begin
        tFIS_IMPOSTO.FieldByName('PR_BASECALC').asFloat := 100;
        tFIS_IMPOSTO.FieldByName('VL_BASECALC').asFloat := gVlTotalLiquidoICMS;
        if ((gCdDecreto = 1643)and((gInProdPropriaDec1643 = False)or(gInProdPropria = True))) or (gCdDecreto = 56066)then begin
          gCdDecreto := 0;
          vInDecreto := False;
        end;
      end;
      //Quando for substituiçao tributária não contemplada(CST 00) para não contribuinte não é aplicado o decreto
      if (vCdCST = '00')
      and ((itemXml('CD_CST', gFIS_REGRAFISCAL) = '10') or (itemXml('CD_CST', gFIS_REGRAFISCAL) = '60') or (itemXml('CD_CST', gFIS_REGRAFISCAL) = '70')) then begin
        gCdDecreto := 0;
      end;
      if (vCdCST = '10')
      and ((itemXml('TP_OPERACAO', gGER_OPERACAO) = 'E') and (itemXmlF('TP_MODALIDADE', gGER_OPERACAO) <> 3)) then begin // Entrada e não for devolução
        if (tFIS_IMPOSTO.FieldByName('VL_BASECALC').asFloat > 0) then begin
          vVlCalc := tFIS_IMPOSTO.FieldByName('VL_BASECALC').asFloat * tFIS_IMPOSTO.FieldByName('PR_ALIQUOTA').asFloat / 100;
          gVlICMS := roundto(vVlCalc, 6);
        end;
        tFIS_IMPOSTO.FieldByName('VL_OUTRO').asFloat := tFIS_IMPOSTO.FieldByName('VL_OUTRO').asFloat + tFIS_IMPOSTO.FieldByName('VL_BASECALC').asFloat;
        tFIS_IMPOSTO.FieldByName('VL_IMPOSTO').asFloat := 0;
        tFIS_IMPOSTO.FieldByName('VL_BASECALC').asFloat := 0;
        tFIS_IMPOSTO.FieldByName('PR_BASECALC').asFloat := 0;
        tFIS_IMPOSTO.FieldByName('PR_REDUBASE').asFloat := 0;
      end;
    end else if (vCdCST = '20') or (vCdCST = '70') or (vCdCST = '30') then begin
      if (vInDecreto = True) then begin
        if (vCdDecreto = 12462)
        or ((vCdDecreto = 1643) and ((gInProdPropriaDec1643 = False) or (gInProdPropria = True))) then begin
          tFIS_IMPOSTO.FieldByName('VL_ISENTO').asFloat := gVlTotalLiquidoICMS;
        end else begin
          tFIS_IMPOSTO.FieldByName('VL_OUTRO').asFloat := gVlTotalLiquidoICMS;
        end;
      end else begin
        vInReducao := False;
        if (itemXmlF('PR_REDUBASE', gFIS_REGRAFISCAL) > 0) and (gInContribuinte = True) then begin
          if (itemXml('TP_OPERACAO', gGER_OPERACAO) = 'S') then begin
            if ((gInRedBaseIcms = True) and (gInProdPropria = True))
            or (gInRedBaseIcms = False)
            or (itemXmlF('CD_CFOPPROPRIA', gFIS_REGRAFISCAL) = 5551)
            or (itemXml('TP_MODALIDADE', gGER_OPERACAO) = '3')
            or ((gTpOrigemEmissao = 1) and (gDsUFOrigem = 'RS')) then begin
              vInReducao := True;
              vCdDecreto := itemXmlF('CD_DECRETO', gFIS_DECRETO);
              vInDecreto := True;
            end else begin
              vCdDecreto := 0;
              vInDecreto := False;
            end;
          end else begin
            if ((itemXml('TP_MODALIDADE', gGER_OPERACAO) <> '3') or ((itemXml('TP_MODALIDADE', gGER_OPERACAO) = '3') and ((gInRedBaseIcms = True) and (gInProdPropria = True)) or (gInRedBaseIcms = False) ) )
            or ((gTpOrigemEmissao = 2) and (gDsUFDestino = 'RS')) then begin
              vInReducao := True;
              vCdDecreto := itemXmlF('CD_DECRETO', gFIS_DECRETO);
              vInDecreto := True;
            end else begin
              vCdDecreto := 0;
              vInDecreto := False;
            end;
          end;
        end else begin 
          vCdDecreto := 0;
          vInDecreto := False;
        end;

        if (vInReducao = True) then begin
          vInPrRedBase := False;
          vInPrRedImposto := False;

          if (gInContribuinte = True) then begin
            if (itemXml('TP_REDUCAO', gFIS_REGRAFISCAL) = 'A') then begin
              if (gDsUFOrigem = gDsUFDestino) then begin
                vInPrRedBase := True;
                gCdDecreto := vCdDecreto;
              end;

            end else if (itemXml('TP_REDUCAO', gFIS_REGRAFISCAL) = 'B') then begin
              if (gDsUFOrigem = gDsUFDestino) then begin
                vInPrRedImposto := True;
                gCdDecreto := vCdDecreto;
              end;

            end else if (itemXml('TP_REDUCAO', gFIS_REGRAFISCAL) = 'C') then begin
              if (gDsUFOrigem = gDsUFDestino) then begin
                vInPrRedBase := True;
                vInPrRedImposto := True;
                gCdDecreto := vCdDecreto;
              end;

            end else if (itemXml('TP_REDUCAO', gFIS_REGRAFISCAL) = 'D') then begin
              if (gDsUFOrigem <> gDsUFDestino) then begin
                vInPrRedBase := True;
                gCdDecreto := vCdDecreto;
              end;

            end else if (itemXml('TP_REDUCAO', gFIS_REGRAFISCAL) = 'E') then begin
              if (gDsUFOrigem <> gDsUFDestino) then begin
                vInPrRedImposto := True;
                gCdDecreto := vCdDecreto;
              end;

            end else if (itemXml('TP_REDUCAO', gFIS_REGRAFISCAL) = 'F') then begin
              if (gDsUFOrigem <> gDsUFDestino) then begin
                vInPrRedBase := True;
                vInPrRedImposto := True;
                gCdDecreto := vCdDecreto;
              end;

            end else if (itemXml('TP_REDUCAO', gFIS_REGRAFISCAL) = 'G') then begin
              vInPrRedBase := True;
              gCdDecreto := vCdDecreto;

            end else if (itemXml('TP_REDUCAO', gFIS_REGRAFISCAL) = 'H') then begin
              vInPrRedImposto := True;
              gCdDecreto := vCdDecreto;

            end else if (itemXml('TP_REDUCAO', gFIS_REGRAFISCAL) = 'I') then begin
              vInPrRedBase := True;
              vInPrRedImposto := True;
              gCdDecreto := vCdDecreto;
            end;
          end else begin 
            vInPrRedBase := True;
            vInPrRedImposto := True;
          end;

          if (vInPrRedBase <> True) and (gCdDecreto <> 6142) then begin
            tFIS_IMPOSTO.FieldByName('PR_REDUBASE').asFloat := 0;
            tFIS_IMPOSTO.FieldByName('PR_BASECALC').asFloat := 100;
            vVlCalc := gVlTotalLiquidoICMS - (gVlTotalLiquidoICMS * tFIS_IMPOSTO.FieldByName('PR_REDUBASE').asFloat / 100);
            tFIS_IMPOSTO.FieldByName('VL_BASECALC').asFloat := roundto(vVlCalc, 6);
            gCdDecreto := 0;
            vInDecreto := False;
          end else begin
            tFIS_IMPOSTO.FieldByName('PR_REDUBASE').asFloat := itemXmlF('PR_REDUBASE', gFIS_REGRAFISCAL);
            tFIS_IMPOSTO.FieldByName('PR_BASECALC').asFloat := 100 - itemXmlF('PR_REDUBASE', gFIS_REGRAFISCAL);
            vVlCalc := gVlTotalLiquidoICMS - (gVlTotalLiquidoICMS * tFIS_IMPOSTO.FieldByName('PR_REDUBASE').asFloat / 100);
            tFIS_IMPOSTO.FieldByName('VL_BASECALC').asFloat := roundto(vVlCalc, 6);
          end;

        end else begin
          vCdCST := '00';
          tFIS_IMPOSTO.FieldByName('PR_BASECALC').asFloat := 100;
          tFIS_IMPOSTO.FieldByName('VL_BASECALC').asFloat := gVlTotalLiquidoICMS;
          if ((gCdDecreto = 1643)and((gInProdPropriaDec1643 = False)or(gInProdPropria = True))) or (gCdDecreto = 56066) then begin
            gCdDecreto := 0;
            vInDecreto := False;
          end;
        end;
        tFIS_IMPOSTO.FieldByName('VL_OUTRO').asFloat := gVlTotalLiquidoICMS - tFIS_IMPOSTO.FieldByName('VL_BASECALC').asFloat;
      end;
      if (vCdCST = '30') or (vCdCST = '70') then begin
        if (itemXml('TP_OPERACAO', gGER_OPERACAO) = 'E') or ((itemXml('TP_OPERACAO', gGER_OPERACAO) = 'S') and (gInOptSimples = True)) then begin
          if (tFIS_IMPOSTO.FieldByName('VL_BASECALC').asFloat > 0) then begin
            vVlCalc := tFIS_IMPOSTO.FieldByName('VL_BASECALC').asFloat * tFIS_IMPOSTO.FieldByName('PR_ALIQUOTA').asFloat / 100;
            gVlICMS := roundto(vVlCalc, 6);
          end;
          tFIS_IMPOSTO.FieldByName('VL_OUTRO').asFloat := tFIS_IMPOSTO.FieldByName('VL_OUTRO').asFloat + tFIS_IMPOSTO.FieldByName('VL_BASECALC').asFloat;
          tFIS_IMPOSTO.FieldByName('VL_IMPOSTO').asFloat := 0;
          tFIS_IMPOSTO.FieldByName('VL_BASECALC').asFloat := 0;
          tFIS_IMPOSTO.FieldByName('PR_BASECALC').asFloat := 0;
          tFIS_IMPOSTO.FieldByName('PR_REDUBASE').asFloat := 0;
        end;
      end;
      if (vCdCST = '30') and (gInOptSimples = False) then begin
        gVlTotalLiquidoICMS := tFIS_IMPOSTO.FieldByName('VL_OUTRO').asFloat + tFIS_IMPOSTO.FieldByName('VL_BASECALC').asFloat;
        vVlCalc := gVlTotalLiquidoICMS * tFIS_IMPOSTO.FieldByName('PR_ALIQUOTA').asFloat / 100;
        gVlICMS := roundto(vVlCalc, 6);
        tFIS_IMPOSTO.Cancel;
        return(-1); exit;
      end;
    end else if (vCdCST = '40') or (vCdCST = '41') then begin
      tFIS_IMPOSTO.FieldByName('PR_ALIQUOTA').asFloat := 0;
      tFIS_IMPOSTO.FieldByName('VL_ISENTO').asFloat := gVlTotalLiquidoICMS;
    end else if (vCdCST = '50') then begin
      tFIS_IMPOSTO.FieldByName('PR_ALIQUOTA').asFloat := 0;
      tFIS_IMPOSTO.FieldByName('VL_OUTRO').asFloat := gVlTotalLiquidoICMS;
    end else if (vCdCST = '51') then begin
      if (vInDecreto = True)  then begin
        tFIS_IMPOSTO.FieldByName('VL_OUTRO').asFloat := gVlTotalLiquidoICMS;
      end else begin
        if (itemXmlF('PR_REDUBASE', gFIS_REGRAFISCAL) > 0) then begin
          tFIS_IMPOSTO.FieldByName('PR_REDUBASE').asFloat := itemXmlF('PR_REDUBASE', gFIS_REGRAFISCAL);
          vVlCalc := gVlTotalLiquidoICMS - (gVlTotalLiquidoICMS * tFIS_IMPOSTO.FieldByName('PR_REDUBASE').asFloat / 100);
          tFIS_IMPOSTO.FieldByName('VL_BASECALC').asFloat := roundto(vVlCalc, 6);
          tFIS_IMPOSTO.FieldByName('VL_OUTRO').asFloat := gVlTotalLiquidoICMS - tFIS_IMPOSTO.FieldByName('VL_BASECALC').asFloat          ;
        end else begin
          tFIS_IMPOSTO.FieldByName('VL_OUTRO').asFloat := gVlTotalLiquidoICMS;
          tFIS_IMPOSTO.FieldByName('PR_ALIQUOTA').asFloat := 0;
          tFIS_IMPOSTO.FieldByName('PR_BASECALC').asFloat := 100;
        end;
      end;
    end else if (vCdCST = '60') then begin
      if (vInDecreto = True) then begin
        tFIS_IMPOSTO.FieldByName('PR_BASECALC').asFloat := 100;
        tFIS_IMPOSTO.FieldByName('VL_BASECALC').asFloat := gVlTotalLiquidoICMS;
      end;
    end else begin
      tFIS_IMPOSTO.FieldByName('VL_OUTRO').asFloat := gVlTotalLiquidoICMS;
    end;
    // Move a base de calculo para outros quando for entrada de fornecedor optante pelo simples
    if (gTpOrigemEmissao = 2) and (itemXmlF('TP_MODALIDADE', gGER_OPERACAO) <> 3) then begin
      if (gDsUFOrigem = 'PR') or (gDsUFOrigem = 'MG') or (gDsUFOrigem = 'SP') or (gDsUFOrigem = 'RJ') or (gDsUFOrigem = 'CE') or (gDsUFOrigem = 'RS') then begin
        if (gTpRegimeOrigem = 2) or (gTpRegimeOrigem = 3) then begin //2-Simples 3-EPP
          tFIS_IMPOSTO.FieldByName('VL_OUTRO').asFloat := tFIS_IMPOSTO.FieldByName('VL_OUTRO').asFloat + tFIS_IMPOSTO.FieldByName('VL_BASECALC').asFloat;
          tFIS_IMPOSTO.FieldByName('VL_BASECALC').asFloat := 0 ;
        end;
      end;
    end;

    //Origem estrangeira - importacão direta
    if (tFIS_IMPOSTO.FieldByName('VL_BASECALC').asFloat > 0) and (vTpProduto = 1)  then begin
      if ((itemXml('TP_OPERACAO', gGER_OPERACAO) = 'S') or (itemXml('TP_OPERACAO', gGER_OPERACAO) = 'E'))
      and ((itemXmlF('TP_MODALIDADE', gGER_OPERACAO) = 3) or (itemXml('TP_MODALIDADE', gGER_OPERACAO) = 'C')) then begin // Saída ou entrada por devolução ou C - Consignacao
        if (itemXmlB('IN_CNSRFINAL', gPES_CLIENTE) = True) then begin
          tFIS_IMPOSTO.FieldByName('VL_BASECALC').asFloat := tFIS_IMPOSTO.FieldByName('VL_BASECALC').asFloat + gVlIPI;
        end;
      end else begin
        tFIS_IMPOSTO.FieldByName('VL_BASECALC').asFloat := tFIS_IMPOSTO.FieldByName('VL_BASECALC').asFloat + gVlIPI;
      end;
    end;

    if (tFIS_IMPOSTO.FieldByName('VL_BASECALC').asFloat > 0) then begin
      vVlCalc := tFIS_IMPOSTO.FieldByName('VL_BASECALC').asFloat * tFIS_IMPOSTO.FieldByName('PR_ALIQUOTA').asFloat / 100;
      tFIS_IMPOSTO.FieldByName('VL_IMPOSTO').asFloat := roundto(vVlCalc, 6);
    end else begin 
      tFIS_IMPOSTO.FieldByName('VL_IMPOSTO').asFloat := 0;
    end;

    if (gCdDecreto = 6142)  then begin
      vVlCalc := tFIS_IMPOSTO.FieldByName('VL_IMPOSTO').asFloat * 66.67 / 100;
      tFIS_IMPOSTO.FieldByName('VL_IMPOSTO').asFloat := roundto(vVlCalc, 6);
    end else begin 
      if (vInPrRedImposto = True) and (itemXmlF('PR_REDUBASE', gFIS_REGRAFISCAL) > 0) then begin
        if (itemXml('TP_REDUCAO', gFIS_REGRAFISCAL) = 'B') or (itemXml('TP_REDUCAO', gFIS_REGRAFISCAL) = 'E') or (itemXml('TP_REDUCAO', gFIS_REGRAFISCAL) = 'H') then begin
          vVlCalc := (tFIS_IMPOSTO.FieldByName('VL_BASECALC').asFloat * ((100 - itemXmlF('PR_REDUBASE', gFIS_REGRAFISCAL))/100) * tFIS_IMPOSTO.FieldByName('PR_ALIQUOTA').asFloat) / 100;
          tFIS_IMPOSTO.FieldByName('VL_IMPOSTO').asFloat := roundto(vVlCalc, 6);
          gCdDecreto := vCdDecreto;
        end;

        if (itemXml('TP_REDUCAO', gFIS_REGRAFISCAL) = 'C') or (itemXml('TP_REDUCAO', gFIS_REGRAFISCAL) = 'F') or (itemXml('TP_REDUCAO', gFIS_REGRAFISCAL) = 'I') then begin
          vVlCalc := (tFIS_IMPOSTO.FieldByName('VL_IMPOSTO').asFloat * (100 - itemXmlF('PR_REDUBASE', gFIS_REGRAFISCAL))) / 100;
          tFIS_IMPOSTO.FieldByName('VL_IMPOSTO').asFloat := roundto(vVlCalc, 6);
          gCdDecreto := vCdDecreto;
        end;
      end;
    end;

    if (gTpModDctoFiscal = 85) or (gTpModDctoFiscal = 87) then begin
      tFIS_IMPOSTO.FieldByName('VL_IMPOSTO').asFloat := tFIS_IMPOSTO.FieldByName('VL_BASECALC').asFloat;
      tFIS_IMPOSTO.FieldByName('VL_BASECALC').asFloat := 0;
      tFIS_IMPOSTO.FieldByName('PR_REDUBASE').asFloat := 0;
      tFIS_IMPOSTO.FieldByName('PR_BASECALC').asFloat := 0;
      tFIS_IMPOSTO.FieldByName('PR_ALIQUOTA').asFloat := 0  ;
      tFIS_IMPOSTO.FieldByName('VL_OUTRO').asFloat := 0;
      tFIS_IMPOSTO.FieldByName('VL_ISENTO').asFloat := 0;
    end;

    if (gVlICMS = 0) then begin
      gVlICMS := tFIS_IMPOSTO.FieldByName('VL_IMPOSTO').asFloat;
    end;

    gCdCST := Copy(gCdCST,1,1) + vCdCST;

    //Zerar a alíquota se o CST=90 e o valor do ICMS for zero. then begin
    if (vCdCST = '90') and (gVlICMS = 0) then begin
      tFIS_IMPOSTO.FieldByName('PR_ALIQUOTA').asFloat := 0;
    end;

    //Se a capa tiver Imposto sobre o Frete/Seguro/Desp.Acessoria será zerado o valor da Base de Calculo e jogado para o Vl.Outros.
    if (vCdCST = '90')
    and ((gVlFrete > 0) or (gVlSeguro > 0) or (gVlDespAcessor > 0))
    and (gVlICMS > 0) then begin
      tFIS_IMPOSTO.FieldByName('VL_OUTRO').asFloat := tFIS_IMPOSTO.FieldByName('VL_BASECALC').asFloat;
      tFIS_IMPOSTO.FieldByName('VL_IMPOSTO').asFloat := 0;
      tFIS_IMPOSTO.FieldByName('PR_BASECALC').asFloat := 0;
      tFIS_IMPOSTO.FieldByName('VL_BASECALC').asFloat := 0;
      tFIS_IMPOSTO.FieldByName('PR_ALIQUOTA').asFloat := 0;
    end;
    return(0);
  end;

  //----------------------
  function calculaICMSSubst(pParams : String) : String;
  //----------------------
  const
    cDS_METHOD = 'ADICIONAL=Operação: FISSVCO015.calculaICMSSubst()';
  var
    vCdCST, viParams, voParams, vTpOperacao : String;
    vPrIVA, vVlCalc, vVlBaseCalc, vVlICMS, vTpProduto, vCdDecreto, vVlAliquotaInter, vVlAliquotaIntra, vCdCFOP : Real;
    vPrIvaPrd, vPrICMS, vVlAliquotaDestino, vVlAliquotaOrigem : Real;
    vInDecreto, vInCalcula : Boolean;
    vDtSistema, vDtIniVigencia, vDtFimVigencia : TDateTime;
  begin

    if (gInImpostoOffLine = True) then begin
      tFIS_IMPOSTO.Cancel;
      return(-1); exit;
    end;

    vDtSistema := itemXmlD('DT_SISTEMA', PARAM_GLB);
    vTpProduto := StrToFloat(Copy(gCdCST,1,1));
    vCdCST := Copy(gCdCST,2,2);
    vTpOperacao := itemXml('TP_OPERACAO', gGER_OPERACAO);

    if (vCdCST <> '10') and (vCdCST <> '30') and (vCdCST <> '60') and (vCdCST <> '70') then begin
      if (gCdDecreto = 2155) or (gCdDecreto = 1020) or (gCdDecreto = 45471) or (gCdDecreto = 23731)
      or (gCdDecreto = 23732) or (gCdDecreto = 23733) or (gCdDecreto = 23734) or (gCdDecreto = 23735)
      or (gCdDecreto = 10201) or (gCdDecreto = 10202) or (gCdDecreto = 10203) then begin
        gCdDecreto := 0;
      end;
      tFIS_IMPOSTO.Cancel;
      return(-1); exit;
    end;
    gCdDecreto := 0;
    vCdDecreto := 0;
    vInDecreto := False;

    if (gCdDecretoItemCapa <> 0) then begin
      vParams := '';
      putitemXml(vParams, 'CD_DECRETO', gCdDecretoItemCapa);
      vResult := gModulo.ConsultarXmlUp('FIS_DECRETO', 'CD_DECRETO|', vParams);
      if (itemXmlF('CD_DECRETO', vResult) > 0) then begin
        vCdDecreto := itemXmlF('CD_DECRETO', vResult);
        vDtIniVigencia := itemXmlD('DT_INIVIGENCIA', vResult);
        vDtFimVigencia := itemXmlD('DT_FIMVIGENCIA', vResult);
      end;
    end else begin
      if (itemXmlF('CD_DECRETO', gFIS_DECRETO) > 0) then begin
        vCdDecreto := itemXmlF('CD_DECRETO', gFIS_DECRETO);
        vDtIniVigencia := itemXmlD('DT_INIVIGENCIA', gFIS_DECRETO);
        vDtFimVigencia := itemXmlD('DT_FIMVIGENCIA', gFIS_DECRETO);
      end;
    end;

    if (vCdDecreto > 0) then begin
      if (vDtIniVigencia > 0) and (vDtSistema < vDtIniVigencia) then begin
        vCdDecreto := 0;
      end;
      if (vDtFimVigencia > 0) and (vDtSistema > vDtFimVigencia) then begin
        vCdDecreto := 0;
      end;
    end;
    //A alíquota diferencia so pode se aplicada em NF estadual
    //Nas outra é obrigatorio respeitar a aliquota interestadual
    if (itemXmlF('PR_ALIQICMS', gFIS_REGRAFISCAL) > 0) and (gDsUFOrigem = gDsUFDestino) then begin
      tFIS_IMPOSTO.FieldByName('PR_ALIQUOTA').asFloat := itemXmlF('PR_ALIQICMS', gFIS_REGRAFISCAL);
    end else if (vCdDecreto > 0) then begin
      viParams := '';
      putitemXml(viParams, 'CD_UFORIGEM', gDsUFDestino);
      putitemXml(viParams, 'CD_UFDESTINO', gDsUFDestino);
      gFIS_ALIQUOTAICMSUF := gModulo.ConsultarXmlUp('FIS_ALIQUOTAICMSUF', 'CD_UFORIGEM|CD_UFDESTINO|', viParams);
      if (itemXml('CD_UFORIGEM', gFIS_REGRAFISCAL) = '') then begin
        Result := SetStatus(STS_ERROR, 'GEN0001', 'Nenhuma alíquota cadastrada de ' + gDsUFDestino + ' para ' + gDsUFDestino + '!', cDS_METHOD);
        return(-1); exit;
      end;
      tFIS_IMPOSTO.FieldByName('PR_ALIQUOTA').asFloat := itemXmlF('PR_ALIQICMS', gFIS_ALIQUOTAICMSUF);
    end;

    vPrIVA := 30;

    //Emissão de terceiro e diferente de devolucao ou devolução de compra com emissão própria
    if ((gTpOrigemEmissao = 2) and (itemXmlF('TP_MODALIDADE', gGER_OPERACAO) <> 3))
    or ((gTpOrigemEmissao = 1) and (itemXmlF('TP_MODALIDADE', gGER_OPERACAO) = 3) and (itemXml('TP_OPERACAO', gGER_OPERACAO) = 'S')) then begin
      if (gDsUFOrigem = 'PR') or (gDsUFOrigem = 'SC') or (gDsUFOrigem = 'MG') or (gDsUFOrigem = 'SP') or (gDsUFOrigem = 'RJ') or (gDsUFOrigem = 'CE') then begin
        if (gTpRegimeOrigem = 2) or (gTpRegimeOrigem = 3) then begin //2-Simples 3-EPP
          tFIS_IMPOSTO.FieldByName('PR_ALIQUOTA').asFloat := 0;
        end;
      end;
      if (gTpOrigemEmissao = 1) then begin
      end;
    end else begin
    end;

    if (vCdDecreto = 2155) then begin // Decreto do Estado do Parana
      if (gDsUFOrigem = 'PR') or (gDsUFOrigem = 'RS') or (gDsUFOrigem = 'SC') then begin
        if (gInContribuinte = True) and (itemXmlF('TP_MODALIDADE', gGER_OPERACAO) = 4) then begin // 4 - Venda/Compra
          if (gDsUFDestino = 'PR') or (gDsUFDestino = 'RS') or (gDsUFDestino = 'SC') then begin
            vPrIVA := 65.86;
            vInDecreto := True;
          end;
        end;
      end;

      if (vInDecreto = True) then begin
        if (itemXmlF('PR_ALIQICMS', gFIS_REGRAFISCAL) > 0) and (gDsUFOrigem = 'PR') and (gDsUFDestino = 'PR') then begin
          tFIS_IMPOSTO.FieldByName('PR_ALIQUOTA').asFloat := itemXmlF('PR_ALIQICMS', gFIS_REGRAFISCAL);
        end else begin
          viParams := '';
          putitemXml(viParams, 'CD_UFORIGEM', gDsUFDestino);
          putitemXml(viParams, 'CD_UFDESTINO', gDsUFDestino);
          gFIS_ALIQUOTAICMSUF := gModulo.ConsultarXmlUp('FIS_ALIQUOTAICMSUF', 'CD_UFORIGEM|CD_UFDESTINO|', viParams);
          if (itemXml('CD_UFORIGEM', gFIS_REGRAFISCAL) = '') then begin
            Result := SetStatus(STS_ERROR, 'GEN0001', 'Nenhuma alíquota cadastrada de ' + gDsUFDestino + ' para ' + gDsUFDestino + '!', cDS_METHOD);
            return(-1); exit;
          end;
          tFIS_IMPOSTO.FieldByName('PR_ALIQUOTA').asFloat := itemXmlF('PR_ALIQICMS', gFIS_ALIQUOTAICMSUF);
        end;

        vVlCalc := gVlTotalLiquidoICMS + gVlIPI + ((gVlTotalLiquidoICMS + gVlIPI) * vPrIVA) / 100 ;
        tFIS_IMPOSTO.FieldByName('VL_BASECALC').asFloat := roundto(vVlCalc, 6);
        tFIS_IMPOSTO.FieldByName('PR_BASECALC').asFloat := 100;

        vVlCalc := tFIS_IMPOSTO.FieldByName('VL_BASECALC').asFloat * (tFIS_IMPOSTO.FieldByName('PR_ALIQUOTA').asFloat / 100);
        vVlICMS := roundto(vVlCalc, 6) ;
        tFIS_IMPOSTO.FieldByName('VL_IMPOSTO').asFloat := vVlICMS - gVlICMS;
        gCdDecreto := vCdDecreto;
      end;
    end else if (vCdDecreto = 1020) or (vCdDecreto = 10201) or (vCdDecreto = 10202) or (vCdDecreto = 10203) then begin // Decreto do Estado de Santa Catarina
      if (gDsUFOrigem = 'PR') or (gDsUFOrigem = 'SC') or (gDsUFOrigem = 'MG') then begin //Incluído o Estado de MG
        if (gInContribuinte = True) and (itemXmlF('TP_MODALIDADE', gGER_OPERACAO) = 4) then begin // 4 - Venda/Compra
          if (gDsUFDestino = 'PR') or (gDsUFDestino = 'SC') or (gDsUFDestino = 'MG') then begin //Incluído o Estado de MG
            if (vCdDecreto = 1020 ) then begin
              vPrIVA := 65.86;
              if (gDsUFDestino = 'SC') and ((gTpRegimeOrigem = 2) or (gTpRegimeOrigem = 3)) then begin //2-Simples 3-EPP
                vPrIVA := 19.758;
              end;
            end else if (vCdDecreto = 10201) then begin
              vPrIVA := 62.99;
              if (gDsUFDestino = 'SC') and ((gTpRegimeOrigem = 2) or (gTpRegimeOrigem = 3)) then begin
                vPrIVA := 18.897;
              end;
            end else if (vCdDecreto = 10202) then begin
              vPrIVA := 37.78;
              if (gDsUFDestino = 'SC') and ((gTpRegimeOrigem = 2) or (gTpRegimeOrigem = 3)) then begin
                vPrIVA := 11.334;
              end;
            end else if (vCdDecreto = 10203) then begin
              if (gDsUFOrigem = gDsUFDestino) then begin
                vPrIVA := 41.34  ;
                if (gDsUFDestino = 'SC') and ((gTpRegimeOrigem = 2) or (gTpRegimeOrigem = 3)) then begin
                  vPrIVA := 12.402  ;
                end;
              end else begin
                vPrIVA := 49.86  ;
                if (gDsUFDestino = 'SC') and ((gTpRegimeOrigem = 2) or (gTpRegimeOrigem = 3)) then begin
                  vPrIVA := 14.958;
                end;
              end;
            end;
            vInDecreto := True;
          end;
        end;
      end;

      if (vInDecreto = True) then begin
        viParams := '';
        putitemXml(viParams, 'CD_UFORIGEM', gDsUFOrigem);
        putitemXml(viParams, 'CD_UFDESTINO', gDsUFDestino);
        gFIS_ALIQUOTAICMSUF := gModulo.ConsultarXmlUp('FIS_ALIQUOTAICMSUF', 'CD_UFORIGEM|CD_UFDESTINO|', viParams);
        if (itemXml('CD_UFORIGEM', gFIS_REGRAFISCAL) = '') then begin
          Result := SetStatus(STS_ERROR, 'GEN0001', 'Nenhuma alíquota cadastrada de ' + gDsUFOrigem + ' para ' + gDsUFDestino + '!', cDS_METHOD);
          return(-1); exit;
        end;
        vVlAliquotaInter := itemXmlF('PR_ALIQICMS', gFIS_ALIQUOTAICMSUF);
        viParams := '';
        putitemXml(viParams, 'CD_PRODUTO' , itemXml('CD_PRODUTO', gPRD_PRODUTO));
        putitemXml(viParams, 'UF_ORIGEM'  , gDsUFOrigem);
        putitemXml(viParams, 'UF_DESTINO' , gDsUFDestino);
        putitemXml(viParams, 'TP_OPERACAO', vTpOperacao);
        voParams := activateCmp('FISSVCO035', 'buscaDadosFiscalProduto', viParams);
        if (itemXmlF('status', voParams) < 0) then begin
          Result := vResult;
          return(-1); exit;
        end;
        vVlAliquotaIntra := itemXmlF('PR_ICMS', voParams);

        if (vVlAliquotaIntra = 0) then begin
          viParams := '';
          putitemXml(viParams, 'CD_UFORIGEM', gDsUFDestino);
          putitemXml(viParams, 'CD_UFDESTINO', gDsUFDestino);
          gFIS_ALIQUOTAICMSUF := gModulo.ConsultarXmlUp('FIS_ALIQUOTAICMSUF', 'CD_UFORIGEM|CD_UFDESTINO|', viParams);
          if (itemXml('CD_UFORIGEM', gFIS_REGRAFISCAL) = '') then begin
            Result := SetStatus(STS_ERROR, 'GEN0001', 'Nenhuma alíquota cadastrada de ' + gDsUFDestino + ' para ' + gDsUFDestino + '!', cDS_METHOD);
            return(-1); exit;
          end;
          vVlAliquotaIntra := itemXmlF('PR_ALIQICMS', gFIS_ALIQUOTAICMSUF);
        end;
        if (gDsUFDestino <> gDsUFOrigem) then begin
          vPrIVA := ((1 + (vPrIVA/100)) * ((1 - (vVlAliquotaInter/100)) / (1 - (vVlAliquotaIntra/100))) -1) * 100;
        end;
        if (itemXmlF('PR_ALIQICMS', gFIS_REGRAFISCAL) > 0) then begin
          tFIS_IMPOSTO.FieldByName('PR_ALIQUOTA').asFloat := itemXmlF('PR_ALIQICMS', gFIS_REGRAFISCAL);
        end else begin
          tFIS_IMPOSTO.FieldByName('PR_ALIQUOTA').asFloat := itemXmlF('PR_ALIQICMS', gFIS_ALIQUOTAICMSUF);
        end;
        vVlCalc := gVlTotalLiquidoICMS + gVlIPI + ((gVlTotalLiquidoICMS + gVlIPI) * vPrIVA) / 100;
        tFIS_IMPOSTO.FieldByName('VL_BASECALC').asFloat := roundto(vVlCalc, 6);
        tFIS_IMPOSTO.FieldByName('PR_BASECALC').asFloat := 100;
        vVlCalc := tFIS_IMPOSTO.FieldByName('VL_BASECALC').asFloat * (tFIS_IMPOSTO.FieldByName('PR_ALIQUOTA').asFloat / 100);
        vVlICMS := roundto(vVlCalc, 6) ;
        tFIS_IMPOSTO.FieldByName('VL_IMPOSTO').asFloat := vVlICMS - gVlICMS;
        gCdDecreto := vCdDecreto;
      end;
    end else if (vCdDecreto = 45471) then begin // Decreto do Estado do Rio Grande do Sul
      if (gDsUFOrigem = 'RS') or (gDsUFOrigem = 'PR') or (gDsUFOrigem = 'SC') then begin
        if (gInContribuinte = True) and (itemXmlF('TP_MODALIDADE', gGER_OPERACAO) = 4)then begin // 4 - Venda/Compra
          if (gDsUFDestino = 'PR') or (gDsUFDestino = 'RS')  or (gDsUFDestino = 'SC') then begin
            vPrIVA := 65.86;
            vInDecreto := True;
          end;
        end;
      end;

      if (vInDecreto = True) then begin
        viParams := '';
        putitemXml(viParams, 'CD_UFORIGEM', gDsUFDestino);
        putitemXml(viParams, 'CD_UFDESTINO', gDsUFDestino);
        gFIS_ALIQUOTAICMSUF := gModulo.ConsultarXmlUp('FIS_ALIQUOTAICMSUF', 'CD_UFORIGEM|CD_UFDESTINO|', viParams);
        if (itemXml('CD_UFORIGEM', gFIS_REGRAFISCAL) = '') then begin
          Result := SetStatus(STS_ERROR, 'GEN0001', 'Nenhuma alíquota cadastrada de ' + gDsUFOrigem + ' para ' + gDsUFDestino + '!', cDS_METHOD);
          return(-1); exit;
        end;
        vVlCalc := gVlTotalLiquidoICMS + gVlIPI + ((gVlTotalLiquidoICMS + gVlIPI) * vPrIVA) / 100 ;
        tFIS_IMPOSTO.FieldByName('VL_BASECALC').asFloat := roundto(vVlCalc, 6);
        tFIS_IMPOSTO.FieldByName('PR_BASECALC').asFloat := 100;
        vVlCalc := tFIS_IMPOSTO.FieldByName('VL_BASECALC').asFloat * (itemXmlF('PR_ALIQICMS', gFIS_ALIQUOTAICMSUF) / 100);
        vVlICMS := roundto(vVlCalc, 6) ;
        tFIS_IMPOSTO.FieldByName('PR_ALIQUOTA').asFloat := itemXmlF('PR_ALIQICMS', gFIS_ALIQUOTAICMSUF);
        tFIS_IMPOSTO.FieldByName('VL_IMPOSTO').asFloat := vVlICMS - gVlICMS;
        gCdDecreto := vCdDecreto;
      end;
    end else if (vCdDecreto = 52364)then begin // Decreto do Estado de São Paulo
      if (gDsUFOrigem = 'SP') or (gDsUFDestino = 'SP') then begin
        if ((itemXml('TP_OPERACAO', gGER_OPERACAO) = 'E') and (itemXmlF('TP_MODALIDADE', gGER_OPERACAO) = 4))
        or ((itemXml('TP_OPERACAO', gGER_OPERACAO) = 'S') and (itemXmlF('TP_MODALIDADE', gGER_OPERACAO) = 3)) then begin // 4 - Compra / 3 - Devolução
          // Aliquota aplicada pelo Fornecedor
          viParams := '';
          putitemXml(viParams, 'CD_UFORIGEM', gDsUFOrigem);
          putitemXml(viParams, 'CD_UFDESTINO', gDsUFDestino);
          gFIS_ALIQUOTAICMSUF := gModulo.ConsultarXmlUp('FIS_ALIQUOTAICMSUF', 'CD_UFORIGEM|CD_UFDESTINO|', viParams);
          if (itemXml('CD_UFORIGEM', gFIS_REGRAFISCAL) = '') then begin
            Result := SetStatus(STS_ERROR, 'GEN0001', 'Nenhuma alíquota cadastrada de ' + gDsUFOrigem + ' para ' + gDsUFDestino + '!', cDS_METHOD);
            return(-1); exit;
          end;

          // Aliquota interna de SP
          if (itemXmlF('PR_ALIQICMS', gFIS_REGRAFISCAL) > 0) then begin
            vVlAliquotaIntra := itemXmlF('PR_ALIQICMS', gFIS_REGRAFISCAL) ;
          end else begin 
            vVlAliquotaIntra := itemXmlF('PR_ALIQICMS', gFIS_ALIQUOTAICMSUF);
          end;
          vVlAliquotaInter := itemXmlF('PR_ALIQICMS', gFIS_ALIQUOTAICMSUF); // Aliquota aplicada pelo Fornecedor

          if (tFIS_IMPOSTO.FieldByName('PR_ALIQUOTA').asFloat = 12) or (tFIS_IMPOSTO.FieldByName('PR_ALIQUOTA').asFloat = 18) then begin
            if (gDsUFOrigem = 'SP') and (gDsUFDestino = 'SP') then begin
              vPrIVA := 38.90 ;
            end else begin 
              vPrIVA := ((1 + (38.90/100)) * ((1 - (vVlAliquotaInter/100)) / (1 - (vVlAliquotaIntra/100))) -1) * 100;
            end;
            vInDecreto := True;
          end else if (tFIS_IMPOSTO.FieldByName('PR_ALIQUOTA').asFloat = 25) then begin
            if (gDsUFOrigem = 'SP') and (gDsUFDestino = 'SP') then begin
              vPrIVA := 71.60 ;
            end else begin 
              vPrIVA := ((1 + (71.60/100)) * ((1 - (vVlAliquotaInter/100)) / (1 - (vVlAliquotaIntra/100))) -1) * 100;
            end;
            vInDecreto := True;
          end;
        end;
      end;

      if (vInDecreto = True) then begin
        vVlCalc := gVlTotalLiquidoICMS + gVlIPI + ((gVlTotalLiquidoICMS + gVlIPI) * vPrIVA) / 100 ;
        tFIS_IMPOSTO.FieldByName('VL_BASECALC').asFloat := roundto(vVlCalc, 6);
        tFIS_IMPOSTO.FieldByName('PR_BASECALC').asFloat := 100    ;
        vVlCalc := tFIS_IMPOSTO.FieldByName('VL_BASECALC').asFloat * (vVlAliquotaIntra / 100);
        vVlICMS := roundto(vVlCalc, 6) ;
        tFIS_IMPOSTO.FieldByName('PR_ALIQUOTA').asFloat := vVlAliquotaIntra;
        tFIS_IMPOSTO.FieldByName('VL_IMPOSTO').asFloat := (gVlTotalLiquidoICMS + gVlIPI) * (1 + (vPrIVA / 100)) * (vVlAliquotaIntra/100) - gVlICMS  ;
        gCdDecreto := vCdDecreto;
      end;
    end else if (vCdDecreto = 23731) or (vCdDecreto = 23732) or (vCdDecreto = 23733) or (vCdDecreto = 23734) or (vCdDecreto = 23735)then begin // Decreto do Estado do Paraná
      if (gDsUFOrigem = 'PR') or (gDsUFDestino = 'PR') then begin
        if (gInContribuinte = True) and (itemXmlF('TP_MODALIDADE', gGER_OPERACAO) = 4) then begin // 4 - Venda/Compra
          if (vCdDecreto = 23731) then begin
            vPrIVA := 59.26;
            vInDecreto := True;
          end else if (vCdDecreto = 23732) then begin
            vPrIVA := 37.78;
            vInDecreto := True;
          end else if (vCdDecreto = 23733) then begin
            if (gDsUFOrigem = gDsUFDestino) then begin
              vPrIVA := 41.34;
            end else begin
              vPrIVA := 49.86;
            end;
            vInDecreto := True;
          end else if (vCdDecreto = 23734) then begin
            if (gDsUFOrigem = gDsUFDestino) then begin
              vPrIVA := 33.05;
            end else begin 
              vPrIVA := 41.06;
            end;
            vInDecreto := True;
          end else if (vCdDecreto = 23735) then begin
            if (gDsUFOrigem = gDsUFDestino) then begin
              vPrIVA := 38.24;
            end else begin
              vPrIVA := 46.56;
            end;
            vInDecreto := True;
          end;
        end;
      end;

      if (vInDecreto = True) then begin
        if (itemXmlF('PR_ALIQICMS', gFIS_REGRAFISCAL) > 0) and (gDsUFOrigem = 'PR') and (gDsUFDestino = 'PR') then begin
          tFIS_IMPOSTO.FieldByName('PR_ALIQUOTA').asFloat := itemXmlF('PR_ALIQICMS', gFIS_REGRAFISCAL);
        end else begin
          viParams := '';
          putitemXml(viParams, 'CD_UFORIGEM', gDsUFDestino);
          putitemXml(viParams, 'CD_UFDESTINO', gDsUFDestino);
          gFIS_ALIQUOTAICMSUF := gModulo.ConsultarXmlUp('FIS_ALIQUOTAICMSUF', 'CD_UFORIGEM|CD_UFDESTINO|', viParams);
          if (itemXml('CD_UFORIGEM', gFIS_REGRAFISCAL) = '') then begin
            Result := SetStatus(STS_ERROR, 'GEN0001', 'Nenhuma alíquota cadastrada de ' + gDsUFOrigem + ' para ' + gDsUFDestino + '!', cDS_METHOD);
            return(-1); exit;
          end;
          tFIS_IMPOSTO.FieldByName('PR_ALIQUOTA').asFloat := itemXmlF('PR_ALIQICMS', gFIS_ALIQUOTAICMSUF);
        end;

        if (itemXmlF('PR_REDUBASE', gFIS_REGRAFISCAL) <> 0) then begin
          vVlCalc := (gVlTotalLiquido + gVlIPI) - ((gVlTotalLiquido + gVlIPI) * itemXmlF('PR_REDUBASE', gFIS_REGRAFISCAL)) / 100;
        end else begin
          vVlCalc := gVlTotalLiquido + gVlIPI;
        end;
        vVlBaseCalc := vVlCalc + (vVlCalc * vPrIVA) / 100 ;
        tFIS_IMPOSTO.FieldByName('VL_BASECALC').asFloat := roundto(vVlBaseCalc, 6);
        tFIS_IMPOSTO.FieldByName('PR_BASECALC').asFloat := 100;
        vVlCalc := tFIS_IMPOSTO.FieldByName('VL_BASECALC').asFloat * (tFIS_IMPOSTO.FieldByName('PR_ALIQUOTA').asFloat / 100);
        vVlICMS := roundto(vVlCalc, 6) ;
        tFIS_IMPOSTO.FieldByName('VL_IMPOSTO').asFloat := vVlICMS - gVlICMS;
        gCdDecreto := vCdDecreto;
      end;
    end else if (vCdDecreto = 2559)then begin // Decreto do Paraná
      if (gDsUFOrigem = 'PR') or (gDsUFDestino = 'PR') then begin
        if (itemXmlF('TP_MODALIDADE', gGER_OPERACAO) = 4)then begin // Venda/Compra
          if (itemXml('TP_OPERACAO', gGER_OPERACAO) = 'E') then begin
            // Aliquota interna de PR
            viParams := '';
            putitemXml(viParams, 'CD_UFORIGEM', gDsUFDestino);
            putitemXml(viParams, 'CD_UFDESTINO', gDsUFDestino);
            gFIS_ALIQUOTAICMSUF := gModulo.ConsultarXmlUp('FIS_ALIQUOTAICMSUF', 'CD_UFORIGEM|CD_UFDESTINO|', viParams);
            if (itemXml('CD_UFORIGEM', gFIS_REGRAFISCAL) = '') then begin
              Result := SetStatus(STS_ERROR, 'GEN0001', 'Nenhuma alíquota cadastrada de ' + gDsUFOrigem + ' para ' + gDsUFDestino + '!', cDS_METHOD);
              return(-1); exit;
            end;
          end else begin
            // Aliquota interna de PR
            viParams := '';
            putitemXml(viParams, 'CD_UFORIGEM', gDsUFOrigem);
            putitemXml(viParams, 'CD_UFDESTINO', gDsUFOrigem);
            gFIS_ALIQUOTAICMSUF := gModulo.ConsultarXmlUp('FIS_ALIQUOTAICMSUF', 'CD_UFORIGEM|CD_UFDESTINO|', viParams);
            if (itemXml('CD_UFORIGEM', gFIS_REGRAFISCAL) = '') then begin
              Result := SetStatus(STS_ERROR, 'GEN0001', 'Nenhuma alíquota cadastrada de ' + gDsUFOrigem + ' para ' + gDsUFDestino + '!', cDS_METHOD);
              return(-1); exit;
            end;
          end;

          // Aliquota interna de PR
          if (itemXmlF('PR_ALIQICMS', gFIS_REGRAFISCAL) > 0) then begin
            vVlAliquotaIntra := itemXmlF('PR_ALIQICMS', gFIS_REGRAFISCAL);
          end else begin
            vVlAliquotaIntra := itemXmlF('PR_ALIQICMS', gFIS_ALIQUOTAICMSUF);
          end;
          vVlAliquotaInter := tFIS_IMPOSTO.FieldByName('PR_ALIQUOTA').asFloat; // Aliquota aplicada pelo Fornecedor
          if (gInProdPropria = True) then begin
            vCdCFOP := itemXmlF('CD_CFOPPROPRIA', gFIS_REGRAFISCAL);
          end else begin
            vCdCFOP := itemXmlF('CD_CFOPTERCEIRO', gFIS_REGRAFISCAL);
          end;
          vCdCFOP := StrToFloat(Copy(FloatToStr(vCdCFOP),2,4));
          if (vCdCFOP = 407) then begin
            vPrIVA := abs(vVlAliquotaInter - vVlAliquotaIntra);
          end else begin
            if (gDsUFOrigem = 'PR') and (gDsUFDestino = 'PR') then begin
              vPrIVA := 40;
            end else begin
              vPrIVA := ((1 + (40/100)) * ((1 - (vVlAliquotaInter/100)) / (1 - (vVlAliquotaIntra/100))) -1) * 100;
            end;
          end;
          vInDecreto := True;
        end;
      end;

      if (vInDecreto = True) then begin
        vVlCalc := gVlTotalLiquidoICMS + gVlIPI + ((gVlTotalLiquidoICMS + gVlIPI) * vPrIVA) / 100 ;
        tFIS_IMPOSTO.FieldByName('VL_BASECALC').asFloat := roundto(vVlCalc, 6);
        tFIS_IMPOSTO.FieldByName('PR_BASECALC').asFloat := 100    ;
        vVlCalc := tFIS_IMPOSTO.FieldByName('VL_BASECALC').asFloat * (vVlAliquotaInter / 100);
        vVlICMS := roundto(vVlCalc, 6) ;
        tFIS_IMPOSTO.FieldByName('PR_ALIQUOTA').asFloat := vVlAliquotaInter;
        tFIS_IMPOSTO.FieldByName('VL_IMPOSTO').asFloat := (gVlTotalLiquidoICMS + gVlIPI) * (1 + (vPrIVA / 100)) * (vVlAliquotaInter/100) - gVlICMS  ;
        gCdDecreto := vCdDecreto;
      end;
    end else if (vCdDecreto = 52804)then begin // Decreto do Estado de São Paulo
      if (gDsUFOrigem = 'SP') or (gDsUFDestino = 'SP') then begin
        if (itemXmlF('TP_MODALIDADE', gGER_OPERACAO) = 4)then begin // Compra/Venda
          if (itemXml('TP_OPERACAO', gGER_OPERACAO) = 'E') then begin
            // Aliquota interna de SP
            viParams := '';
            putitemXml(viParams, 'CD_UFORIGEM', gDsUFDestino);
            putitemXml(viParams, 'CD_UFDESTINO', gDsUFDestino);
            gFIS_ALIQUOTAICMSUF := gModulo.ConsultarXmlUp('FIS_ALIQUOTAICMSUF', 'CD_UFORIGEM|CD_UFDESTINO|', viParams);
            if (itemXml('CD_UFORIGEM', gFIS_REGRAFISCAL) = '') then begin
              Result := SetStatus(STS_ERROR, 'GEN0001', 'Nenhuma alíquota cadastrada de ' + gDsUFOrigem + ' para ' + gDsUFDestino + '!', cDS_METHOD);
              return(-1); exit;
            end;
          end else begin
            // Aliquota interna de SP
            viParams := '';
            putitemXml(viParams, 'CD_UFORIGEM', gDsUFOrigem);
            putitemXml(viParams, 'CD_UFDESTINO', gDsUFOrigem);
            gFIS_ALIQUOTAICMSUF := gModulo.ConsultarXmlUp('FIS_ALIQUOTAICMSUF', 'CD_UFORIGEM|CD_UFDESTINO|', viParams);
            if (itemXml('CD_UFORIGEM', gFIS_REGRAFISCAL) = '') then begin
              Result := SetStatus(STS_ERROR, 'GEN0001', 'Nenhuma alíquota cadastrada de ' + gDsUFOrigem + ' para ' + gDsUFDestino + '!', cDS_METHOD);
              return(-1); exit;
            end;
          end;

          // Aliquota interna de SP
          if (itemXmlF('PR_ALIQICMS', gFIS_REGRAFISCAL) > 0) then begin
            vVlAliquotaIntra := itemXmlF('PR_ALIQICMS', gFIS_REGRAFISCAL) ;
          end else begin 
            vVlAliquotaIntra := itemXmlF('PR_ALIQICMS', gFIS_ALIQUOTAICMSUF);
          end;
          vVlAliquotaInter := tFIS_IMPOSTO.FieldByName('PR_ALIQUOTA').asFloat ; // Aliquota aplicada pelo Fornecedor
          if (gDsUFOrigem = 'SP') and (gDsUFDestino = 'SP') then begin
            vPrIVA := 17.32;
          end else begin
            vPrIVA := ((1 + (17.32/100)) * ((1 - (vVlAliquotaInter/100)) / (1 - (vVlAliquotaIntra/100))) -1) * 100;
          end;
          vInDecreto := True;
        end;
      end;

      if (vInDecreto = True) then begin
        vVlCalc := gVlTotalLiquidoICMS + gVlIPI + ((gVlTotalLiquidoICMS + gVlIPI) * vPrIVA) / 100 ;
        tFIS_IMPOSTO.FieldByName('VL_BASECALC').asFloat := roundto(vVlCalc, 6);
        tFIS_IMPOSTO.FieldByName('PR_BASECALC').asFloat := 100;
        vVlCalc := tFIS_IMPOSTO.FieldByName('VL_BASECALC').asFloat * (vVlAliquotaIntra / 100);
        vVlICMS := roundto(vVlCalc, 6) ;
        tFIS_IMPOSTO.FieldByName('PR_ALIQUOTA').asFloat := vVlAliquotaInter;
        tFIS_IMPOSTO.FieldByName('VL_IMPOSTO').asFloat := (gVlTotalLiquidoICMS + gVlIPI) * (1 + (vPrIVA / 100)) * (vVlAliquotaInter/100) - gVlICMS;
        gCdDecreto := vCdDecreto;
      end;
    // Decreto do Espirito Santo
    end else if (vCdDecreto = 10901) or (vCdDecreto = 10902) or (vCdDecreto = 10903) or (vCdDecreto = 10904) then begin // Decreto do Espirito Santo
      if (gDsUFOrigem = 'ES') or (gDsUFDestino = 'ES') then begin
        if (gInContribuinte = True)
        and ((itemXmlF('TP_MODALIDADE', gGER_OPERACAO) = 4) or (itemXmlF('TP_MODALIDADE', gGER_OPERACAO) = 3)) then begin // 4 - Venda/Compra / 3 - Devolucao
          if (vCdDecreto = 10901) then begin
            vPrIVA := 42;
            vInDecreto := True;
          end else if (vCdDecreto = 10902) then begin
            vPrIVA := 32;
            vInDecreto := True;
          end else if (vCdDecreto = 10903) then begin
            vPrIVA := 60;
            vInDecreto := True;
          end else if (vCdDecreto = 10904) then begin
            vPrIVA := 45;
            vInDecreto := True;
          end;
        end;
      end;

      if (vInDecreto = True) then begin
        // Aliquota aplicada no destino
        viParams := '';
        putitemXml(viParams, 'CD_UFORIGEM', gDsUFDestino);
        putitemXml(viParams, 'CD_UFDESTINO', gDsUFDestino);
        gFIS_ALIQUOTAICMSUF := gModulo.ConsultarXmlUp('FIS_ALIQUOTAICMSUF', 'CD_UFORIGEM|CD_UFDESTINO|', viParams);
        if (itemXml('CD_UFORIGEM', gFIS_REGRAFISCAL) = '') then begin
          Result := SetStatus(STS_ERROR, 'GEN0001', 'Nenhuma alíquota cadastrada de ' + gDsUFOrigem + ' para ' + gDsUFDestino + '!', cDS_METHOD);
          return(-1); exit;
        end;
        // Aliquota interna do destino
        if (itemXmlF('PR_ALIQICMS', gFIS_REGRAFISCAL) > 0) then begin
          vVlAliquotaIntra := itemXmlF('PR_ALIQICMS', gFIS_REGRAFISCAL) ;
        end else begin
          vVlAliquotaIntra := itemXmlF('PR_ALIQICMS', gFIS_ALIQUOTAICMSUF);
        end;
        vVlCalc := gVlTotalLiquidoICMS + gVlIPI + ((gVlTotalLiquidoICMS + gVlIPI) * vPrIVA) / 100 ;
        tFIS_IMPOSTO.FieldByName('VL_BASECALC').asFloat := roundto(vVlCalc, 6);
        tFIS_IMPOSTO.FieldByName('PR_BASECALC').asFloat := 100    ;
        vVlCalc := tFIS_IMPOSTO.FieldByName('VL_BASECALC').asFloat * (vVlAliquotaIntra / 100);
        vVlICMS := roundto(vVlCalc, 6) ;
        tFIS_IMPOSTO.FieldByName('PR_ALIQUOTA').asFloat := vVlAliquotaIntra;
        tFIS_IMPOSTO.FieldByName('VL_IMPOSTO').asFloat := (gVlTotalLiquidoICMS + gVlIPI) * (1 + (vPrIVA / 100)) * (vVlAliquotaIntra/100) - gVlICMS;
        gCdDecreto := vCdDecreto;
        if (gDsUFOrigem = 'ES') and (gDsUFDestino = 'ES') then begin
          vCdCST := '10';
        end else begin
          vCdCST := '70';
        end;
      end;
    end else begin
      vTpOperacao := itemXml('TP_OPERACAO', gGER_OPERACAO);

      viParams := '';
      putitemXml(viParams, 'CD_PRODUTO', itemXml('CD_PRODUTO', gPRD_PRODUTO));
      putitemXml(viParams, 'UF_ORIGEM', gDsUFOrigem);
      putitemXml(viParams, 'UF_DESTINO', gDsUFDestino);
      putitemXml(viParams, 'TP_OPERACAO', vTpOperacao);
      voParams := activateCmp('FISSVCO035', 'buscaDadosFiscalProduto', viParams);
      if (itemXmlF('status', voParams) < 0) then begin
        Result := vResult;
        return(-1); exit;
      end;  
      vPrIvaPrd := itemXmlF('PR_SUBSTRIB', voParams);
      vPrICMS := itemXmlF('PR_ICMS', voParams);

      if (vPrIvaPrd > 0) then begin
        vPrIVA := vPrIvaPrd;
      end;

      if (vPrICMS > 0)  then begin
        tFIS_IMPOSTO.FieldByName('PR_ALIQUOTA').asFloat := vPrICMS;
      end;
      if (tFIS_IMPOSTO.FieldByName('PR_ALIQUOTA').asFloat = 0) then begin
        Result := SetStatus(STS_ERROR, 'GEN0001', 'Nenhuma alíquota cadastrada na Tabela de Sub.Trib.do NCM de ' + gDsUFOrigem + ' para ' + gDsUFDestino + '!', cDS_METHOD);
        return(-1); exit;
      end;
      vInCalcula := False;
      if (gDsUFOrigem <> gDsUFDestino) and (itemXmlF('TP_MODALIDADE', gGER_OPERACAO) = 4)then begin // Venda/Compra
        if (itemXml('TP_OPERACAO', gGER_OPERACAO) = 'S') then begin
          if (gInContribuinte = True) and (itemXmlB('IN_CNSRFINAL', gPES_CLIENTE) = True) then begin
            vInCalcula := True;
          end;
        end else begin
          if (gInProdPropria = True) then begin
            vCdCFOP := itemXmlF('CD_CFOPPROPRIA', gFIS_REGRAFISCAL);
          end else begin
            vCdCFOP := itemXmlF('CD_CFOPTERCEIRO', gFIS_REGRAFISCAL);
          end;
          vCdCFOP := StrToFloat(Copy(FloatToStr(vCdCFOP),2,4));

          if (vCdCFOP = 407) then begin
            vInCalcula := True;
          end;
        end;

        if (vInCalcula = True) then begin
          // Aliquota interna destino
          viParams := '';
          putitemXml(viParams, 'CD_UFORIGEM', gDsUFDestino);
          putitemXml(viParams, 'CD_UFDESTINO', gDsUFDestino);
          gFIS_ALIQUOTAICMSUF := gModulo.ConsultarXmlUp('FIS_ALIQUOTAICMSUF', 'CD_UFORIGEM|CD_UFDESTINO|', viParams);
          if (itemXml('CD_UFORIGEM', gFIS_REGRAFISCAL) = '') then begin
            Result := SetStatus(STS_ERROR, 'GEN0001', 'Nenhuma alíquota cadastrada de ' + gDsUFOrigem + ' para ' + gDsUFDestino + '!', cDS_METHOD);
            return(-1); exit;
          end;
          vVlAliquotaDestino := itemXmlF('PR_ALIQICMS', gFIS_ALIQUOTAICMSUF);

          // Aliquota interna origem
          viParams := '';
          putitemXml(viParams, 'CD_UFORIGEM', gDsUFOrigem);
          putitemXml(viParams, 'CD_UFDESTINO', gDsUFOrigem);
          gFIS_ALIQUOTAICMSUF := gModulo.ConsultarXmlUp('FIS_ALIQUOTAICMSUF', 'CD_UFORIGEM|CD_UFDESTINO|', viParams);
          if (itemXml('CD_UFORIGEM', gFIS_REGRAFISCAL) = '') then begin
            Result := SetStatus(STS_ERROR, 'GEN0001', 'Nenhuma alíquota cadastrada de ' + gDsUFOrigem + ' para ' + gDsUFDestino + '!', cDS_METHOD);
            return(-1); exit;
          end;
          vVlAliquotaOrigem := itemXmlF('PR_ALIQICMS', gFIS_ALIQUOTAICMSUF);

          //Se tiver aliquota na regra fiscal será passado para AliquotaOrigem
          if (itemXmlF('PR_ALIQICMS', gFIS_REGRAFISCAL) > 0) then begin
            vVlAliquotaOrigem := itemXmlF('PR_ALIQICMS', gFIS_REGRAFISCAL) ;
          end;

          vPrIVA := 0;
          tFIS_IMPOSTO.FieldByName('PR_ALIQUOTA').asFloat := abs(vVlAliquotaOrigem - vVlAliquotaDestino);

        end else begin

          viParams := '';
          putitemXml(viParams, 'CD_UFORIGEM', gDsUFOrigem);
          putitemXml(viParams, 'CD_UFDESTINO', gDsUFDestino);
          gFIS_ALIQUOTAICMSUF := gModulo.ConsultarXmlUp('FIS_ALIQUOTAICMSUF', 'CD_UFORIGEM|CD_UFDESTINO|', viParams);
          if (itemXml('CD_UFORIGEM', gFIS_REGRAFISCAL) = '') then begin
            Result := SetStatus(STS_ERROR, 'GEN0001', 'Nenhuma alíquota cadastrada de ' + gDsUFOrigem + ' para ' + gDsUFDestino + '!', cDS_METHOD);
            return(-1); exit;
          end;
          vVlAliquotaInter := itemXmlF('PR_ALIQICMS', gFIS_ALIQUOTAICMSUF);

          viParams := '';
          putitemXml(viParams, 'CD_PRODUTO' , itemXml('CD_PRODUTO', gPRD_PRODUTO));
          putitemXml(viParams, 'UF_ORIGEM'  , gDsUFOrigem);
          putitemXml(viParams, 'UF_DESTINO' , gDsUFDestino);
          putitemXml(viParams, 'TP_OPERACAO', vTpOperacao);
          voParams := activateCmp('FISSVCO035', 'buscaDadosFiscalProduto', viParams);
          if (itemXmlF('status', voParams) < 0) then begin
            Result := vResult;
            exit
          end;
          vVlAliquotaIntra := itemXmlF('PR_ICMS', voParams);

          if (vVlAliquotaIntra = 0) then begin
            viParams := '';
            putitemXml(viParams, 'CD_UFORIGEM', gDsUFDestino);
            putitemXml(viParams, 'CD_UFDESTINO', gDsUFDestino);
            gFIS_ALIQUOTAICMSUF := gModulo.ConsultarXmlUp('FIS_ALIQUOTAICMSUF', 'CD_UFORIGEM|CD_UFDESTINO|', viParams);
            if (itemXml('CD_UFORIGEM', gFIS_REGRAFISCAL) = '') then begin
              Result := SetStatus(STS_ERROR, 'GEN0001', 'Nenhuma alíquota cadastrada de ' + gDsUFOrigem + ' para ' + gDsUFDestino + '!', cDS_METHOD);
              return(-1); exit;
            end;
            vVlAliquotaIntra := itemXmlF('PR_ALIQICMS', gFIS_ALIQUOTAICMSUF);
          end;

          if (gDsUFDestino <> gDsUFOrigem) then begin
             vPrIVA := ((1 + (vPrIVA/100)) * ((1 - (vVlAliquotaInter/100)) / (1 - (vVlAliquotaIntra/100))) -1) * 100;
          end;
        end;
      end;
      if (gPrAplicMvaSubTrib <> 0) then begin
        if ( (vTpOperacao = 'S') and ((gDsUFDestino = 'SC') and (gInContribuinte = True) and ((gTpRegimeOrigem = 2) or (gTpRegimeOrigem = 3))) )
        or ( (vTpOperacao = 'E') and ((itemXmlF('TP_MODALIDADE', gGER_OPERACAO) = 3) and ((gTpRegimeOrigem = 2) or (gTpRegimeOrigem = 3))) ) // 2-Micro Empresa / 3-EPP
        or ( (vTpOperacao = 'E') and (gInOptSimples = True) ) then begin
          if (vPrIVA = 0) then begin
            vPrIva := vPrIvaPrd;
          end;
          vPrIVA := (vPrIVA * gPrAplicMvaSubTrib)/100;
        end;
      end;
      if (vCdCST = '10') then begin
        vVlCalc := (gVlTotalLiquidoICMS + gVlIPI) + ((gVlTotalLiquidoICMS + gVlIPI) * vPrIVA) / 100;
        tFIS_IMPOSTO.FieldByName('VL_BASECALC').asFloat := roundto(vVlCalc, 6);
        tFIS_IMPOSTO.FieldByName('PR_BASECALC').asFloat := 100;
      end else if (vCdCST = '70') then begin //Implementado por Deusdete em caráter de urgência em 28/04/2009, lógica revisada c/ Eliã
        vVlCalc := gVlTotalLiquidoICMS + gVlIPI;
        if (gNaturezaComercialEmp <> 3) and (gNaturezaComercialEmp <> 2) then begin //Varejo e Atacado (p/ atender o Lojão e Brascol)
          if (itemXmlF('PR_REDUBASE', gFIS_REGRAFISCAL) <> 0) then begin
            if (vTpOperacao = 'S') then begin
              vVlCalc := vVlCalc - ((gVlTotalLiquidoICMS + gVlIPI) * itemXmlF('PR_REDUBASE', gFIS_REGRAFISCAL)) / 100;
              tFIS_IMPOSTO.FieldByName('PR_BASECALC').asFloat := 100 - itemXmlF('PR_REDUBASE', gFIS_REGRAFISCAL);
              tFIS_IMPOSTO.FieldByName('PR_REDUBASE').asFloat := itemXmlF('PR_REDUBASE', gFIS_REGRAFISCAL);
            end else if (vTpOperacao = 'E') then begin
              if (gTpRegimeOrigem = 2) or (gTpRegimeOrigem = 3) then begin
                vVlCalc := vVlCalc - ((gVlTotalLiquidoICMS + gVlIPI) * itemXmlF('PR_REDUBASE', gFIS_REGRAFISCAL)) / 100;
                tFIS_IMPOSTO.FieldByName('PR_BASECALC').asFloat := 100 - itemXmlF('PR_REDUBASE', gFIS_REGRAFISCAL);
                tFIS_IMPOSTO.FieldByName('PR_REDUBASE').asFloat := itemXmlF('PR_REDUBASE', gFIS_REGRAFISCAL);
              end;
            end;
          end;
        end;
        vVlBaseCalc := vVlCalc + ((vVlCalc * vPrIVA) / 100);
        tFIS_IMPOSTO.FieldByName('VL_BASECALC').asFloat := roundto(vVlBaseCalc, 6);
        if (tFIS_IMPOSTO.FieldByName('PR_REDUBASE').asFloat = 0) then begin
          tFIS_IMPOSTO.FieldByName('PR_BASECALC').asFloat := 100;
        end;
      end else if (vCdCST = '30') then begin
        vVlCalc := gVlTotalLiquidoICMS + gVlIPI;
        if (gInOptSimples = True) then begin
          if (gNaturezaComercialEmp <> 3) and (gNaturezaComercialEmp <> 2) then begin //Varejo e Atacado (p/ atender o Lojão e Brascol)
            if (itemXmlF('PR_REDUBASE', gFIS_REGRAFISCAL) <> 0) then begin
              if (vTpOperacao = 'S') then begin
                vVlCalc := vVlCalc - ((gVlTotalLiquidoICMS + gVlIPI) * itemXmlF('PR_REDUBASE', gFIS_REGRAFISCAL)) / 100;
                tFIS_IMPOSTO.FieldByName('PR_BASECALC').asFloat := 100 - itemXmlF('PR_REDUBASE', gFIS_REGRAFISCAL);
                tFIS_IMPOSTO.FieldByName('PR_REDUBASE').asFloat := itemXmlF('PR_REDUBASE', gFIS_REGRAFISCAL);
              end else if (vTpOperacao = 'E') then begin
                if (gTpRegimeOrigem = 2) or (gTpRegimeOrigem = 3) then begin
                  vVlCalc := vVlCalc - ((gVlTotalLiquidoICMS + gVlIPI) * itemXmlF('PR_REDUBASE', gFIS_REGRAFISCAL)) / 100;
                  tFIS_IMPOSTO.FieldByName('PR_BASECALC').asFloat := 100 - itemXmlF('PR_REDUBASE', gFIS_REGRAFISCAL);
                  tFIS_IMPOSTO.FieldByName('PR_REDUBASE').asFloat := itemXmlF('PR_REDUBASE', gFIS_REGRAFISCAL);
                end;
              end;
            end;
          end;
        end;
        vVlBaseCalc := vVlCalc + ((vVlCalc * vPrIVA) / 100 );
        tFIS_IMPOSTO.FieldByName('VL_BASECALC').asFloat := roundto(vVlBaseCalc, 6);
        if (tFIS_IMPOSTO.FieldByName('PR_REDUBASE').asFloat = 0) then begin
          tFIS_IMPOSTO.FieldByName('PR_BASECALC').asFloat := 100;
        end;
      end else begin
        tFIS_IMPOSTO.FieldByName('VL_OUTRO').asFloat := gVlTotalLiquidoICMS;
      end;

      if (vInCalcula = True)  then begin
        vVlCalc := (tFIS_IMPOSTO.FieldByName('VL_BASECALC').asFloat * tFIS_IMPOSTO.FieldByName('PR_ALIQUOTA').asFloat) / 100;
        vVlCalc := roundto(vVlCalc, 6);
        tFIS_IMPOSTO.FieldByName('VL_IMPOSTO').asFloat := vVlCalc;
      end else begin
        if (tFIS_IMPOSTO.FieldByName('VL_BASECALC').asFloat > 0) then begin
          if (gInOptSimples = True) or ((gTpRegimeOrigem = 2) or (gTpRegimeOrigem = 3)
          and ((itemXml('TP_OPERACAO', gGER_OPERACAO) = 'E')
          or (((itemXmlF('TP_MODALIDADE', gGER_OPERACAO) = 3) and (itemXml('TP_OPERACAO', gGER_OPERACAO) = 'S') )))) then begin //2-Simples 3-EPP / Entrada ou Devolucao de compra
            if (tFIS_IMPOSTO.FieldByName('PR_ALIQUOTA').asFloat <> 0) then begin
              vVlCalc := (tFIS_IMPOSTO.FieldByName('VL_BASECALC').asFloat * tFIS_IMPOSTO.FieldByName('PR_ALIQUOTA').asFloat) / 100;
              vVlICMS := roundto(vVlCalc, 6)    ;
              if (vCdCST = '30') or (vCdCST = '70') then begin
                if (gInOptSimples = True) then begin
                  if (itemXml('TP_OPERACAO', gGER_OPERACAO) = 'E') then begin
                    if (gTpRegimeOrigem = 2) or (gTpRegimeOrigem = 3) then begin
                      if (itemXmlF('PR_REDUBASE', gFIS_REGRAFISCAL) <> 0) then begin
                        gVlTotalLiquidoICMS := (gVlTotalLiquidoICMS + gVlIPI) - ((gVlTotalLiquidoICMS + gVlIPI) * itemXmlF('PR_REDUBASE', gFIS_REGRAFISCAL)) / 100;
                      end;
                    end;
                  end else if (itemXml('TP_OPERACAO', gGER_OPERACAO) = 'S') then begin
                    if (itemXmlF('PR_REDUBASE', gFIS_REGRAFISCAL) <> 0) then begin
                      gVlTotalLiquidoICMS := (gVlTotalLiquidoICMS + gVlIPI) - ((gVlTotalLiquidoICMS + gVlIPI) * itemXmlF('PR_REDUBASE', gFIS_REGRAFISCAL)) / 100;
                    end;
                  end;
                end else if (gInOptSimples = False) and (vCdCST = '70') then begin
                  if (gTpRegimeOrigem = 2) or (gTpRegimeOrigem = 3) then begin
                    if (itemXmlF('PR_REDUBASE', gFIS_REGRAFISCAL) <> 0) then begin
                      gVlTotalLiquidoICMS := (gVlTotalLiquidoICMS + gVlIPI) - ((gVlTotalLiquidoICMS + gVlIPI) * itemXmlF('PR_REDUBASE', gFIS_REGRAFISCAL)) / 100;
                    end;
                  end;
                end;
              end;

              if (gDsUFOrigem = gDsUFDestino) then begin
                if (itemXmlF('PR_ALIQICMS', gFIS_REGRAFISCAL) > 0) then begin
                  vVlCalc := ((gVlTotalLiquidoICMS + gVlIPI) * itemXmlF('PR_ALIQICMS', gFIS_REGRAFISCAL)) / 100;
                end else begin 
                  viParams := '';
                  putitemXml(viParams, 'CD_UFORIGEM', gDsUFOrigem);
                  putitemXml(viParams, 'CD_UFDESTINO', gDsUFDestino);
                  gFIS_ALIQUOTAICMSUF := gModulo.ConsultarXmlUp('FIS_ALIQUOTAICMSUF', 'CD_UFORIGEM|CD_UFDESTINO|', viParams);
                  if (itemXml('CD_UFORIGEM', gFIS_REGRAFISCAL) = '') then begin
                    Result := SetStatus(STS_ERROR, 'GEN0001', 'Nenhuma alíquota cadastrada de ' + gDsUFOrigem + ' para ' + gDsUFDestino + '!', cDS_METHOD);
                    return(-1); exit;
                  end;
                  vVlCalc := ((gVlTotalLiquidoICMS + gVlIPI) * itemXmlF('PR_ALIQICMS', gFIS_ALIQUOTAICMSUF)) / 100;
                end;
              end else begin
                viParams := '';
                putitemXml(viParams, 'CD_UFORIGEM', gDsUFOrigem);
                putitemXml(viParams, 'CD_UFDESTINO', gDsUFDestino);
                gFIS_ALIQUOTAICMSUF := gModulo.ConsultarXmlUp('FIS_ALIQUOTAICMSUF', 'CD_UFORIGEM|CD_UFDESTINO|', viParams);
                if (itemXml('CD_UFORIGEM', gFIS_REGRAFISCAL) = '') then begin
                  Result := SetStatus(STS_ERROR, 'GEN0001', 'Nenhuma alíquota cadastrada de ' + gDsUFOrigem + ' para ' + gDsUFDestino + '!', cDS_METHOD);
                  return(-1); exit;
                end;
                vVlCalc := ((gVlTotalLiquidoICMS + gVlIPI) * itemXmlF('PR_ALIQICMS', gFIS_ALIQUOTAICMSUF)) / 100;
              end;
              vVlCalc := roundto(vVlCalc, 6);
              tFIS_IMPOSTO.FieldByName('VL_IMPOSTO').asFloat := vVlICMS - vVlCalc;
            end;
          end else begin
            vVlCalc := tFIS_IMPOSTO.FieldByName('VL_BASECALC').asFloat * tFIS_IMPOSTO.FieldByName('PR_ALIQUOTA').asFloat / 100;
            vVlICMS := roundto(vVlCalc, 6) ;
            tFIS_IMPOSTO.FieldByName('VL_IMPOSTO').asFloat := vVlICMS - gVlICMS;
          end;
        end else begin
          tFIS_IMPOSTO.FieldByName('VL_IMPOSTO').asFloat := 0;
        end;
      end;
    end;

    if (vCdCST = '60') then begin
      tFIS_IMPOSTO.FieldByName('PR_ALIQUOTA').asFloat := 0;
      tFIS_IMPOSTO.FieldByName('VL_OUTRO').asFloat := gVlTotalLiquidoICMS;
      tFIS_IMPOSTO.FieldByName('VL_IMPOSTO').asFloat := 0;
      tFIS_IMPOSTO.FieldByName('VL_BASECALC').asFloat := 0;
      tFIS_IMPOSTO.FieldByName('PR_BASECALC').asFloat := 0;
      tFIS_IMPOSTO.FieldByName('PR_REDUBASE').asFloat := 0;
    end;

    gCdCST := Copy(gCdCST,1,1) + vCdCST;
    return(0);
  end;

  //----------------------
  function calculaIPI(pParams : String) : String;
  //----------------------
  var
    vVlCalc, vVlBaseCalc, vCdDecreto : Real;
    vInDecreto : Boolean;
    vDtIniVigencia, vDtFimVigencia, vDtSistema : TDateTime;
  begin
    if (gTpOrigemEmissao = 1) then begin //Própria
      if (itemXmlB('IN_IPI', gFIS_REGRAFISCAL) <> True) then begin
        tFIS_IMPOSTO.Cancel;
        return(-1); exit;
      end;
    end else begin
      if (gPrIPI = 0) or (gVlIPI = 0)  then begin
        if (itemXmlB('IN_IPI', gFIS_REGRAFISCAL) <> True) then begin
          tFIS_IMPOSTO.Cancel;
          return(-1); exit;
        end;
      end;
    end;

    gCdDecreto := 0;
    vCdDecreto := 0;
    vInDecreto := False;
    vDtSistema := itemXmlD('DT_SISTEMA', PARAM_GLB);
  
    if (gCdDecretoItemCapa <> 0) then begin
      vParams := '';
      putitemXml(vParams, 'CD_DECRETO', gCdDecretoItemCapa);
      vResult := gModulo.ConsultarXmlUp('FIS_DECRETO', 'CD_DECRETO|', vParams);
      if (itemXmlF('CD_DECRETO', vResult) > 0) then begin
        vCdDecreto := itemXmlF('CD_DECRETO', vResult);
        vDtIniVigencia := itemXmlD('DT_INIVIGENCIA', vResult);
        vDtFimVigencia := itemXmlD('DT_FIMVIGENCIA', vResult);
      end;
    end else begin 
      if (itemXmlF('CD_DECRETO', gFIS_DECRETO) > 0) then begin
        vCdDecreto := itemXmlF('CD_DECRETO', gFIS_DECRETO);
        vDtIniVigencia := itemXmlD('DT_INIVIGENCIA', gFIS_DECRETO);
        vDtFimVigencia := itemXmlD('DT_FIMVIGENCIA', gFIS_DECRETO);
      end;
    end;

    if (vCdDecreto > 0) then begin
      if (vDtIniVigencia <> 0) and (vDtSistema < vDtIniVigencia) then begin
        vCdDecreto := 0;
      end;
      if (vDtFimVigencia <> 0) and (vDtSistema > vDtFimVigencia) then begin
        vCdDecreto := 0;
      end;
    end;
    tFIS_IMPOSTO.FieldByName('PR_BASECALC').asFloat := 100;
    tFIS_IMPOSTO.FieldByName('VL_BASECALC').asFloat := gVlTotalBruto;
    if (gTpOrigemEmissao = 1) then begin //Própria
      if(gPrIPI <> 0) then begin
        tFIS_IMPOSTO.FieldByName('PR_ALIQUOTA').asFloat := gPrIPI;
      end else begin 
        tFIS_IMPOSTO.FieldByName('PR_ALIQUOTA').asFloat := itemXmlF('PR_IPI', gFIS_TIPI);
      end;
      vVlCalc := tFIS_IMPOSTO.FieldByName('VL_BASECALC').asFloat * tFIS_IMPOSTO.FieldByName('PR_ALIQUOTA').asFloat / 100;
      tFIS_IMPOSTO.FieldByName('VL_IMPOSTO').asFloat := roundto(vVlCalc, 2);
    end else begin
      if (gVlIPI = 0) then begin
        if (gPrIPI <> 0) then begin
          tFIS_IMPOSTO.FieldByName('PR_ALIQUOTA').asFloat := gPrIPI;
        end;
        vVlCalc := tFIS_IMPOSTO.FieldByName('VL_BASECALC').asFloat * tFIS_IMPOSTO.FieldByName('PR_ALIQUOTA').asFloat / 100;
        tFIS_IMPOSTO.FieldByName('VL_IMPOSTO').asFloat := roundto(vVlCalc, 2);
      end else begin
        tFIS_IMPOSTO.FieldByName('PR_ALIQUOTA').asFloat := gPrIPI;
        tFIS_IMPOSTO.FieldByName('VL_IMPOSTO').asFloat := gVlIPI;
      end;
    end;
    if (vCdDecreto = 8248) then begin // Decreto para reduzir o valor do IPI em 95% para produto de informática
      if (itemXmlF('TP_MODALIDADE', gGER_OPERACAO) = 4) then begin // 4 - Venda/Compra
        vInDecreto := True;
      end;

      if (vInDecreto = True) then begin
        vVlCalc := tFIS_IMPOSTO.FieldByName('VL_IMPOSTO').asFloat * (1 - 0.95);
        tFIS_IMPOSTO.FieldByName('VL_IMPOSTO').asFloat := roundto(vVlCalc, 2);
        gCdDecreto := vCdDecreto;
      end;
    end;
    if ((itemXmlF('TP_MODALIDADE', gGER_OPERACAO) <> 3) or (itemXml('TP_OPERACAO', gGER_OPERACAO) <> 'S')) then begin //Devolucao / Saida
      if ((gCdServico > 0) or (itemXmlF('TP_MODALIDADE', gGER_OPERACAO) = 5) or (itemXmlF('TP_MODALIDADE', gGER_OPERACAO) = 6) or (itemXml('TP_MODALIDADE', gGER_OPERACAO) = 'F')) then begin // 5-Outras entradas/saidas / 6-Producao / F-Remessa/Retorno;
        if (gInCalcIpiOutEntSai <> True) then begin
          tFIS_IMPOSTO.FieldByName('VL_OUTRO').asFloat := tFIS_IMPOSTO.FieldByName('VL_BASECALC').asFloat;
          tFIS_IMPOSTO.FieldByName('VL_BASECALC').asFloat := 0;
          tFIS_IMPOSTO.FieldByName('VL_IMPOSTO').asFloat := 0;
          tFIS_IMPOSTO.FieldByName('PR_ALIQUOTA').asFloat := 0;
          tFIS_IMPOSTO.FieldByName('PR_BASECALC').asString := '';
        end;
      end else if (itemXmlF('TP_MODALIDADE', gGER_OPERACAO) = 3) and (itemXml('TP_OPERACAO', gGER_OPERACAO) = 'E') then begin // Devolução de Venda
        if (gDsUFDestino = 'AC') or (gDsUFDestino = 'AM') or (gDsUFDestino = 'RO') or (gDsUFDestino = 'RR') or (gDsUFOrigem = 'EX') or (gDsUFDestino = 'EX') then begin
          tFIS_IMPOSTO.FieldByName('VL_OUTRO').asFloat := tFIS_IMPOSTO.FieldByName('VL_BASECALC').asFloat;
          tFIS_IMPOSTO.FieldByName('VL_BASECALC').asFloat := 0;
          tFIS_IMPOSTO.FieldByName('VL_IMPOSTO').asFloat := 0;
          tFIS_IMPOSTO.FieldByName('PR_ALIQUOTA').asFloat := 0;
          tFIS_IMPOSTO.FieldByName('PR_BASECALC').asString := '';
        end;
      end else begin 
        if (gNaturezaComercialEmp = 4) then begin // 4 - IPI suspenso
          if (tFIS_IMPOSTO.FieldByName('VL_IMPOSTO').asFloat = 0) then begin
            tFIS_IMPOSTO.FieldByName('VL_OUTRO').asFloat := tFIS_IMPOSTO.FieldByName('VL_BASECALC').asFloat;
            tFIS_IMPOSTO.FieldByName('VL_BASECALC').asFloat := 0;
            tFIS_IMPOSTO.FieldByName('PR_ALIQUOTA').asFloat := 0;
            tFIS_IMPOSTO.FieldByName('PR_BASECALC').asString := '';
          end;
        end else if (itemXmlF('TP_MODALIDADE', gGER_OPERACAO) = 4) and (itemXml('TP_OPERACAO', gGER_OPERACAO) = 'S') then begin // 4 - Venda
          if (gDsUFDestino = 'EX') or (gDsUFDestino = 'AC') or (gDsUFDestino = 'AM') or (gDsUFDestino = 'RO') or (gDsUFDestino = 'RR') then begin
            tFIS_IMPOSTO.FieldByName('VL_OUTRO').asFloat := tFIS_IMPOSTO.FieldByName('VL_BASECALC').asFloat;
            tFIS_IMPOSTO.FieldByName('VL_BASECALC').asFloat := 0;
            tFIS_IMPOSTO.FieldByName('VL_IMPOSTO').asFloat := 0;
            tFIS_IMPOSTO.FieldByName('PR_ALIQUOTA').asFloat := 0;
            tFIS_IMPOSTO.FieldByName('PR_BASECALC').asString := '';
          end else if (gTpAreaComercioOrigem = 0) and (gTpAreaComercioDestino > 0) then begin
            tFIS_IMPOSTO.FieldByName('VL_OUTRO').asFloat := tFIS_IMPOSTO.FieldByName('VL_BASECALC').asFloat;
            tFIS_IMPOSTO.FieldByName('VL_BASECALC').asFloat := 0;
            tFIS_IMPOSTO.FieldByName('VL_IMPOSTO').asFloat := 0;
            tFIS_IMPOSTO.FieldByName('PR_ALIQUOTA').asFloat := 0;
            tFIS_IMPOSTO.FieldByName('PR_BASECALC').asString := '';
          end;
        end;
      end;
    end else begin
      if (tFIS_IMPOSTO.FieldByName('PR_ALIQUOTA').asFloat = 0) then begin
        tFIS_IMPOSTO.FieldByName('VL_OUTRO').asFloat := tFIS_IMPOSTO.FieldByName('VL_BASECALC').asFloat;
        tFIS_IMPOSTO.FieldByName('VL_BASECALC').asFloat := 0;
        tFIS_IMPOSTO.FieldByName('VL_IMPOSTO').asFloat := 0;
        tFIS_IMPOSTO.FieldByName('PR_ALIQUOTA').asFloat := 0;
        tFIS_IMPOSTO.FieldByName('PR_BASECALC').asString := '';
      end;
    end;
    if (gInImpostoOffLine = True) then begin
      tFIS_IMPOSTO.FieldByName('VL_BASECALC').asFloat := 0;
      tFIS_IMPOSTO.FieldByName('VL_IMPOSTO').asFloat := 0;
    end;

    gPrIPI := tFIS_IMPOSTO.FieldByName('PR_ALIQUOTA').asFloat;
    gVlIPI := tFIS_IMPOSTO.FieldByName('VL_IMPOSTO').asFloat;
    return(0);
  end;

  //----------------------
  function calculaISS(pParams : String) : String;
  //----------------------
  var
    vVlCalc, vVlBaseCalc : Real;
    vCdCST : String;
  begin

    if (gInImpostoOffLine = True) then begin
      tFIS_IMPOSTO.Cancel;
      return(-1); exit;
    end;
    vCdCST := Copy(gCdCST,2,2);

    if (vCdCST = '40') or (vCdCST = '41') then begin
      tFIS_IMPOSTO.FieldByName('PR_BASECALC').asFloat := 0;
      tFIS_IMPOSTO.FieldByName('VL_BASECALC').asFloat := 0;
      tFIS_IMPOSTO.FieldByName('PR_ALIQUOTA').asFloat := itemXmlF('PR_ALIQISS', gFIS_REGRAFISCAL);
      vVlCalc := tFIS_IMPOSTO.FieldByName('VL_BASECALC').asFloat * tFIS_IMPOSTO.FieldByName('PR_ALIQUOTA').asFloat / 100;
      tFIS_IMPOSTO.FieldByName('VL_IMPOSTO').asFloat := roundto(vVlCalc, 6);
      tFIS_IMPOSTO.FieldByName('VL_ISENTO').asFloat := gVlTotalLiquido;
  
    end else if (vCdCST = '90') then begin
      tFIS_IMPOSTO.FieldByName('PR_BASECALC').asFloat := 0;
      tFIS_IMPOSTO.FieldByName('VL_BASECALC').asFloat := 0;
      tFIS_IMPOSTO.FieldByName('PR_ALIQUOTA').asFloat := itemXmlF('PR_ALIQISS', gFIS_REGRAFISCAL);
      vVlCalc := tFIS_IMPOSTO.FieldByName('VL_BASECALC').asFloat * tFIS_IMPOSTO.FieldByName('PR_ALIQUOTA').asFloat / 100;
      tFIS_IMPOSTO.FieldByName('VL_IMPOSTO').asFloat := roundto(vVlCalc, 6);
      tFIS_IMPOSTO.FieldByName('VL_OUTRO').asFloat := gVlTotalLiquido;
    end else begin 
      tFIS_IMPOSTO.FieldByName('PR_BASECALC').asFloat := 100;
      tFIS_IMPOSTO.FieldByName('VL_BASECALC').asFloat := gVlTotalLiquido;
      tFIS_IMPOSTO.FieldByName('PR_ALIQUOTA').asFloat := itemXmlF('PR_ALIQISS', gFIS_REGRAFISCAL);
      vVlCalc := tFIS_IMPOSTO.FieldByName('VL_BASECALC').asFloat * tFIS_IMPOSTO.FieldByName('PR_ALIQUOTA').asFloat / 100;
      tFIS_IMPOSTO.FieldByName('VL_IMPOSTO').asFloat := roundto(vVlCalc, 6);
    end;
    return(0);
  end;

  //-------------------
  function calculaCOFINS(pParams : String) : String;
  //-------------------
  var
    vVlCalc : Real;
    bStatus : Boolean;
  begin

    if (gInImpostoOffLine = True) then begin
      tFIS_IMPOSTO.Cancel;
      return(-1); exit;
    end;
    if (itemXmlB('IN_CONFINS', gFIS_REGRAFISCAL) <> True) then begin
      tFIS_IMPOSTO.Cancel;
      return(-1); exit;
    end;
    vParams := '';
    putitemXml(vParams, 'CD_IMPOSTO', itemXml('CD_IMPOSTO', gFIS_IMPOSTO));
    putitemXml(vParams, 'CD_REGRAFISCAL', itemXml('CD_REGRAFISCAL', gFIS_REGRAFISCAL));
    gFIS_REGRAIMPOSTO := gModulo.ConsultarXmlUp('FIS_REGRAIMPOSTO', 'CD_IMPOSTO|CD_REGRAFISCAL|', vParams);
    if (itemXml('CD_REGRAFISCAL', gFIS_REGRAIMPOSTO) = '') then begin
      tFIS_IMPOSTO.FieldByName('CD_CST').AsString := itemXml('CD_CST', gFIS_REGRAIMPOSTO);
    end;

    if (gTpAreaComercioOrigem = 0)
    and (((gTpAreaComercioDestino = 1) and (gInDescontaPisCofinsAlc = False)) or ((gTpAreaComercioDestino = 2) and (gInDescontaPisCofinsZfm = False))) then begin
      putitemXml(gFIS_REGRAFISCAL, 'PR_ALIQCOFINS', 0);
      tFIS_IMPOSTO.FieldByName('CD_CST').AsString := '06';
    end;
    tFIS_IMPOSTO.FieldByName('PR_BASECALC').asFloat := 100;
    tFIS_IMPOSTO.FieldByName('VL_BASECALC').asFloat := gVlTotalLiquido;
    if (gDsLstCfopIpiBcPisCof <> '') then begin
      if (gInProdPropria = True) then begin
        bStatus := (tTMP_NR09.Locate('NR_GERAL', itemXmlF('CD_CFOPPROPRIA', gFIS_REGRAFISCAL), []));
      end else begin
        bStatus := (tTMP_NR09.Locate('NR_GERAL', itemXmlF('CD_CFOPTERCEIRO', gFIS_REGRAFISCAL), []));
      end;
      if (bStatus) then begin
        tFIS_IMPOSTO.FieldByName('VL_BASECALC').asFloat := tFIS_IMPOSTO.FieldByName('VL_BASECALC').asFloat + gVlIPI;
      end;
    end;
    tFIS_IMPOSTO.FieldByName('PR_ALIQUOTA').asFloat := itemXmlF('PR_ALIQCOFINS', gFIS_REGRAFISCAL);
    vVlCalc := tFIS_IMPOSTO.FieldByName('VL_BASECALC').asFloat * tFIS_IMPOSTO.FieldByName('PR_ALIQUOTA').asFloat / 100;
    tFIS_IMPOSTO.FieldByName('VL_IMPOSTO').asFloat := roundto(vVlCalc, 6);
    return(0);
  end;

  //----------------------
  function calculaPIS(pParams : String) : String;
  //----------------------
  var
    vVlCalc : Real;
    bStatus : Boolean;
  begin
    if (gInImpostoOffLine = True) then begin
      tFIS_IMPOSTO.Cancel;
      return(-1); exit;
    end;
    if (itemXmlB('IN_PIS', gFIS_REGRAFISCAL) <> True) then begin
      tFIS_IMPOSTO.Cancel;
      return(-1); exit;
    end;

    vParams := '';
    putitemXml(vParams, 'CD_IMPOSTO', itemXml('CD_IMPOSTO', gFIS_IMPOSTO));
    putitemXml(vParams, 'CD_REGRAFISCAL', itemXml('CD_REGRAFISCAL', gFIS_REGRAFISCAL));
    gFIS_REGRAIMPOSTO := gModulo.ConsultarXmlUp('FIS_REGRAIMPOSTO', 'CD_IMPOSTO|CD_REGRAFISCAL|', vParams);
    if (itemXml('CD_REGRAFISCAL', gFIS_REGRAIMPOSTO) = '') then begin
      tFIS_IMPOSTO.FieldByName('CD_CST').AsString := itemXml('CD_CST', gFIS_REGRAIMPOSTO);
    end;

    if (gTpAreaComercioOrigem = 0)
    and (((gTpAreaComercioDestino = 1) and (gInDescontaPisCofinsAlc = False)) or ((gTpAreaComercioDestino = 2) and (gInDescontaPisCofinsZfm = False))) then begin
      putitemXml(gFIS_REGRAFISCAL, 'PR_ALIQPIS', 0);
      tFIS_IMPOSTO.FieldByName('CD_CST').AsString := '06';
    end;
    tFIS_IMPOSTO.FieldByName('PR_BASECALC').asFloat := 100;
    tFIS_IMPOSTO.FieldByName('VL_BASECALC').asFloat := gVlTotalLiquido;
    if (gDsLstCfopIpiBcPisCof <> '') then begin
      if (gInProdPropria = True) then begin
        bStatus := (tTMP_NR09.Locate('NR_GERAL', itemXmlF('CD_CFOPPROPRIA', gFIS_REGRAFISCAL), []));
      end else begin
        bStatus := (tTMP_NR09.Locate('NR_GERAL', itemXmlF('CD_CFOPTERCEIRO', gFIS_REGRAFISCAL), []));
      end;
      if (bStatus) then begin
        tFIS_IMPOSTO.FieldByName('VL_BASECALC').asFloat := tFIS_IMPOSTO.FieldByName('VL_BASECALC').asFloat + gVlIPI;
      end;
    end;
    tFIS_IMPOSTO.FieldByName('PR_ALIQUOTA').asFloat := itemXmlF('PR_ALIQPIS', gFIS_REGRAFISCAL);
    vVlCalc := tFIS_IMPOSTO.FieldByName('VL_BASECALC').asFloat * tFIS_IMPOSTO.FieldByName('PR_ALIQUOTA').asFloat / 100;
    tFIS_IMPOSTO.FieldByName('VL_IMPOSTO').asFloat := roundto(vVlCalc, 6);
    return(0);
  end;

  //----------------------
  function calculaPASEP(pParams : String) : String;
  //----------------------
  var
    vVlCalc : Real;
  begin
    if (gInImpostoOffLine = True) then begin
      tFIS_IMPOSTO.Cancel;
      return(-1); exit;
    end;

    if (itemXmlB('IN_PASEP', gFIS_REGRAFISCAL) <> True)
    or (itemXmlF('PR_ALIQPASEP', gFIS_REGRAFISCAL) = 0) then begin
      tFIS_IMPOSTO.Cancel;
      return(-1); exit;
    end;

    tFIS_IMPOSTO.FieldByName('PR_BASECALC').asFloat := 100;
    tFIS_IMPOSTO.FieldByName('VL_BASECALC').asFloat := gVlTotalLiquido;
    tFIS_IMPOSTO.FieldByName('PR_ALIQUOTA').asFloat := itemXmlF('PR_ALIQPASEP', gFIS_REGRAFISCAL);
    vVlCalc := tFIS_IMPOSTO.FieldByName('VL_BASECALC').asFloat * tFIS_IMPOSTO.FieldByName('PR_ALIQUOTA').asFloat / 100;
    tFIS_IMPOSTO.FieldByName('VL_IMPOSTO').asFloat := roundto(vVlCalc, 6);
    return(0);
  end;

{ T_FISSVCO015 }

//-------------------------
function T_FISSVCO015.buscaCFOP(pParams : String) : String;
//-------------------------
const
  cDS_METHOD = 'ADICIONAL=Operação: T_FISSVCO015.buscaCFOP()';
var
  viParams, voParams, vDsLstEmpresa, vCdMPTer, vTpOperacao, vDsUF, vCdCSTOperacao, vCdCST : String;
  vCdEmpresa, vCdEmpresaParam, vCdProduto, vCdOperacao, vCdPessoa, vCdCFOPOperacao : Real;
  vCdRegraFiscal, vCdCFOP, vTpAreaComercio, vTpAreaComercioOrigem, vCdCFOPServico, vPrIvaPrd : Real;
  vInProdPropria, vInDecreto, vInOrgaoPublico : Boolean;
begin
  Result := '';

  if (itemXml('UF_ORIGEM', pParams) <> '') then begin
    gDsUFOrigem := itemXml('UF_ORIGEM', pParams);
    gDsUFDestino := itemXml('UF_DESTINO', pParams);
  end else begin
    gDsUFOrigem := itemXml('UF_ORIGEM', PARAM_GLB);
    gDsUFDestino := itemXml('UF_DESTINO', pParams);
  end;
  vCdProduto := itemXmlF('CD_PRODUTO', pParams);
  vCdMPTer := itemXml('CD_MPTER', pParams);
  gCdServico := itemXmlF('CD_SERVICO', pParams);
  vCdOperacao := itemXmlF('CD_OPERACAO', pParams);
  vCdPessoa := itemXmlF('CD_PESSOA', pParams);
  vTpAreaComercio := itemXmlF('TP_AREACOMERCIO', pParams);
  vTpAreaComercioOrigem  := itemXmlF('TP_AREA_COMERCIO_ORIGEM', PARAM_GLB);
  vCdEmpresaParam := itemXmlF('CD_EMPRESA', pParams);
  if (vCdEmpresaParam = 0) then begin
    vCdEmpresaParam := itemXmlF('CD_EMPRESA', PARAM_GLB);
  end;
  gTpModDctoFiscal := itemXmlF('TP_MODDCTOFISCAL', pParams);
  gTpOrigemEmissao := itemXmlF('TP_ORIGEMEMISSAO', pParams); //1 - Própria / 2 - Terceiros;
  gInContribuinte := itemXmlB('IN_CONTRIBUINTE', pParams);
  vCdCFOP := 0;
  vInDecreto := False;
  gCdDecreto := 0;

  if (gDsUFDestino = '') then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'UF destino não informada!', cDS_METHOD);
    return(-1); exit;
  end;
  if (vCdOperacao = 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Operação não informada!', cDS_METHOD);
    return(-1); exit;
  end;
  if (vCdPessoa = 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Pessoa não informada!', cDS_METHOD);
    return(-1); exit;
  end;

  vParams := '';
  putitemXml(vParams, 'CD_OPERACAO', vCdOperacao);
  gGER_OPERACAO := gModulo.ConsultarXmlUp('GER_OPERACAO', 'CD_OPERACAO|', vParams);
  if (itemXml('CD_OPERACAO', gGER_OPERACAO) = '') then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Operação ' + FloatToStr(vCdOperacao) + ' não cadastrada!', cDS_METHOD);
    return(-1); exit;
  end;

  if (vCdProduto = 0)
  and (vCdMPTer = '')
  and (gCdServico = 0) then begin
    return(-1); exit;
  end;

  if (vCdMPTer <> '') then begin
    vParams := '';
    putitemXml(vParams, 'CD_PESSOA', vCdPessoa);
    putitemXml(vParams, 'CD_MPTER', vCdMPTer);
    gCDF_MPTER := gModulo.ConsultarXmlUp('CDF_MPTER', 'CD_PESSOA|CD_MPTER|', vParams);
    if (itemXml('CDF_MPTER', gCDF_MPTER) = '') then begin
      Result := SetStatus(STS_ERROR, 'GEN0001', 'Matéria-prima ' + vCdMPTer + ' não cadastrada para a pessoa ' + FloatToStr(vCdPessoa) + '!', cDS_METHOD);
      return(-1); exit;
    end;
  end else begin
    vParams := '';
    putitemXml(vParams, 'CD_PRODUTO', vCdProduto);
    gPRD_PRODUTO := gModulo.ConsultarXmlUp('PRD_PRODUTO', 'CD_PRODUTO|', vParams);
    if (itemXml('CD_PRODUTO', gPRD_PRODUTO) = '') then begin
      Result := SetStatus(STS_ERROR, 'GEN0001', 'Produto ' + FloatToStr(vCdProduto) + ' não cadastrado!', cDS_METHOD);
      return(-1); exit;
    end;
  end;

  vParams := '';
  putitemXml(vParams, 'CD_PESSOA', vCdPessoa);
  gPES_PESSOA := gModulo.ConsultarXmlUp('PES_PESSOA', 'CD_PESSOA|', vParams);
  if (itemXml('CD_PESSOA', gPES_PESSOA) = '') then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Pessoa ' + FloatToStr(vCdPessoa) + ' não cadastrada!', cDS_METHOD);
    return(-1); exit;
  end;
  gPES_PESJURIDICA := '';
  gPES_PESFISICA := '';
  if (itemXml('TP_PESSOA', gPES_PESSOA) = 'J') then begin
    vParams := '';
    putitemXml(vParams, 'CD_PESSOA', vCdPessoa);
    gPES_PESJURIDICA := gModulo.ConsultarXmlUp('PES_PESJURIDICA', 'CD_PESSOA|', vParams);
    if (itemXml('CD_PESSOA', gPES_PESJURIDICA) = '') then begin
      Result := SetStatus(STS_ERROR, 'GEN0001', 'Pessoa juridica ' + FloatToStr(vCdPessoa) + ' não cadastrada!', cDS_METHOD);
      return(-1); exit;
    end;
  end else begin
    vParams := '';
    putitemXml(vParams, 'CD_PESSOA', vCdPessoa);
    gPES_PESFISICA := gModulo.ConsultarXmlUp('PES_PESFISICA', 'CD_PESSOA|', vParams);
    if (itemXml('CD_PESSOA', gPES_PESFISICA) = '') then begin
      Result := SetStatus(STS_ERROR, 'GEN0001', 'Pessoa fisica ' + FloatToStr(vCdPessoa) + ' não cadastrada!', cDS_METHOD);
      return(-1); exit;
    end;
  end;

  //Venda / Devolução de venda
  if ((itemXml('TP_OPERACAO', gGER_OPERACAO) = 'S') and (itemXml('TP_MODALIDADE', gGER_OPERACAO) = '4'))
  or ((itemXml('TP_OPERACAO', gGER_OPERACAO) = 'E') and (itemXml('TP_MODALIDADE', gGER_OPERACAO) = '3')) then begin
    vParams := '';
    putitemXml(vParams, 'CD_CLIENTE', vCdPessoa);
    gPES_CLIENTE := gModulo.ConsultarXmlUp('PES_CLIENTE', 'CD_CLIENTE|', vParams);
    if (itemXml('CD_CLIENTE', gPES_CLIENTE) = '') then begin
      Result := SetStatus(STS_ERROR, 'GEN0001', 'Cliente ' + FloatToStr(vCdPessoa) + ' não cadastrado!', cDS_METHOD);
      return(-1); exit;
    end;
  end;

  // Implementado por Deusdete em 22/03/2007, situação emergencial na Krindges;
  // Se for pessoa Jurídica e não tiver inscrição estadual, isto é, Isento, deverá ser tratado para fazer o cálculo do imposto
  // com a alíquota interna.;
  gInPjIsento := False;
  if (itemXml('NR_INSCESTL', gPES_PESJURIDICA) = 'ISENTO')
  or (itemXml('NR_INSCESTL', gPES_PESJURIDICA) = 'ISENTA')
  or (itemXml('NR_INSCESTL', gPES_PESJURIDICA) = 'ISENTOS')
  or (itemXml('NR_INSCESTL', gPES_PESJURIDICA) = 'ISENTAS') then begin
    if (itemXml('TP_REGIMETRIB', gPES_PESJURIDICA) <> '6') then begin // MEI (Micro Empresário Individual)
      gInPjIsento := True;
    end;
  end;

  if (gTpOrigemEmissao = 2) then begin //Terceiros
    if (itemXml('TP_MODALIDADE', gGER_OPERACAO) <> '3') then begin //Devolução
      vDsUF := gDsUFOrigem;
      gDsUFOrigem := gDsUFDestino;
      gDsUFDestino := vDsUF;
    end;
  end else begin
    if ((itemXml('TP_MODALIDADE', gGER_OPERACAO) = '3') and (itemXml('TP_OPERACAO', gGER_OPERACAO) = 'S')) then begin //Devolução compra
      vDsUF := gDsUFOrigem;
      gDsUFOrigem := gDsUFDestino;
      gDsUFDestino := vDsUF;
    end;
  end;

  viParams := '';
  putitemXml(viParams, 'CD_PESSOA', vCdPessoa);
  voParams := activateCmp('FCRSVCO057', 'validaPessoaOrgaoPublico', viParams);
  if (itemXmlF('status', voParams) < 0) then begin
    Result := voParams;
    return(-1); exit;
  end;
  vInOrgaoPublico := itemXmlB('IN_ORGAOPUBLICO', voParams);

  if (vInOrgaoPublico = True) and (gDsUFOrigem = 'DF') then begin
    gInContribuinte := True;
  end else begin
    if (itemXmlB('IN_CNSRFINAL', gPES_CLIENTE) = True) or (itemXml('TP_PESSOA', gPES_PESSOA) = 'F') or (gInPjIsento = True) then begin
      if (itemXmlB('IN_CNSRFINAL', gPES_CLIENTE) = True) and (itemXml('TP_PESSOA', gPES_PESSOA) = 'J') and (gInPjIsento = False) then begin
        gInContribuinte := True;
      end else begin
        if (itemXml('TP_PESSOA', gPES_PESSOA) = 'F')
        and (itemXml('NR_CODIGOFISCAL', gPES_CLIENTE) <> '')
        and ((gDsUFOrigem = 'PR') or (gDsUFOrigem = 'SP') or (gDsUFOrigem = 'RS')) then begin
          gInContribuinte := True;
        end else begin
          gInContribuinte := False;
        end;
      end;
    end else begin
      gInContribuinte := True;
    end;
  end;

  vCdRegraFiscal := 0;

  if (gCdServico > 0) then begin
    vInProdPropria := False;
    vCdRegraFiscal := itemXmlF('CD_REGRAFISCAL', gGER_OPERACAO);
    if (vCdRegraFiscal = 0) then begin
      Result := SetStatus(STS_ERROR, 'GEN0001', 'Nenhuma regra fiscal cadastrada p/ a operação ' + FloatToStr(vCdOperacao) + '!', cDS_METHOD);
      return(-1); exit;
    end;
  end else if (vCdMPTer <> '') then begin
    vInProdPropria := False;
    vCdRegraFiscal := itemXmlF('CD_REGRAFISCAL', gGER_OPERACAO);
    if (vCdRegraFiscal = 0) then begin
      Result := SetStatus(STS_ERROR, 'GEN0001', 'Nenhuma regra fiscal cadastrada p/ a operação ' + FloatToStr(vCdOperacao) + '!', cDS_METHOD);
      return(-1); exit;
    end;
  end else begin
    viParams := '';
    putitemXml(viParams, 'CD_EMPRESA', vCdEmpresaParam);
    putitemXml(viParams, 'CD_PRODUTO', vCdProduto);
    voParams := activateCmp('PRDSVCO007', 'buscaDadosFilial', viParams); // PRDSVCO008
    if (itemXmlF('status', voParams) < 0) then begin
      Result := voParams;
      return(-1); exit;
    end;
    vInProdPropria := itemXmlB('IN_PRODPROPRIA', voParams);

    viParams := '';
    putitemXml(viParams, 'CD_PRODUTO', vCdProduto);
    putitemXml(viParams, 'CD_OPERACAO', vCdOperacao);
    gPRD_PRDREGRAFISCAL := gModulo.ConsultarXmlUp('PRD_PRDREGRAFISCAL', 'CD_PRODUTO|CD_OPERACAO|', vParams);
    if (itemXml('CD_REGRAFISCAL', gPRD_PRDREGRAFISCAL) <> '') then begin
      viParams := '';
      putitemXml(viParams, 'CD_REGRAFISCAL', itemXmlF('CD_REGRAFISCAL', gPRD_PRDREGRAFISCAL));
      gFIS_REGRAFISCAL := gModulo.ConsultarXmlUp('FIS_REGRAFISCAL', 'CD_REGRAFISCAL|', viParams);
      if (itemXml('CD_REGRAFISCAL', gFIS_REGRAFISCAL) = '') then begin
        Result := SetStatus(STS_ERROR, 'GEN0001', 'Regra fiscal ' + itemXml('CD_REGRAFISCAL', gPRD_PRDREGRAFISCAL) + ' não cadastrada!', cDS_METHOD);
        return(-1); exit;
      end else begin
        if (itemXmlF('CD_DECRETO', gFIS_REGRAFISCAL) = 2155)
        or (itemXmlF('CD_DECRETO', gFIS_REGRAFISCAL) = 1020)
        or (itemXmlF('CD_DECRETO', gFIS_REGRAFISCAL) = 45471)
        or (itemXmlF('CD_DECRETO', gFIS_REGRAFISCAL) = 23731)
        or (itemXmlF('CD_DECRETO', gFIS_REGRAFISCAL) = 23732)
        or (itemXmlF('CD_DECRETO', gFIS_REGRAFISCAL) = 23733)
        or (itemXmlF('CD_DECRETO', gFIS_REGRAFISCAL) = 23734)
        or (itemXmlF('CD_DECRETO', gFIS_REGRAFISCAL) = 23735)
        or (itemXmlF('CD_DECRETO', gFIS_REGRAFISCAL) = 10201)
        or (itemXmlF('CD_DECRETO', gFIS_REGRAFISCAL) = 10202)
        or (itemXmlF('CD_DECRETO', gFIS_REGRAFISCAL) = 10203) then begin
          if (gInContribuinte = True) then begin
            vCdRegraFiscal := itemXmlF('CD_REGRAFISCAL', gPRD_PRDREGRAFISCAL);
          end else begin
            vCdRegraFiscal := itemXmlF('CD_REGRAFISCAL', gGER_OPERACAO);
          end;
        end else begin
          vCdRegraFiscal := itemXmlF('CD_REGRAFISCAL', gPRD_PRDREGRAFISCAL);
        end;
      end;
    end else begin
      vCdRegraFiscal := itemXmlF('CD_REGRAFISCAL', gGER_OPERACAO);
    end;

    if (vCdRegraFiscal = 0) then begin
      Result := SetStatus(STS_ERROR, 'GEN0001', 'Nenhuma regra fiscal cadastrada p/ o produto ' + FloatToStr(vCdProduto) + ' e a operação ' + FloatToStr(vCdOperacao) + '!', cDS_METHOD);
      return(-1); exit;
    end;
    vCdCST := Copy(itemXml('CD_CST', gPRD_PRODUTO), 1, 1);
  end;

  viParams := '';
  putitemXml(viParams, 'CD_REGRAFISCAL', itemXml('CD_REGRAFISCAL', gGER_OPERACAO));
  gFIS_REGRAFISCAL := gModulo.ConsultarXmlUp('FIS_REGRAFISCAL', 'CD_REGRAFISCAL|', viParams);
  if (itemXml('CD_REGRAFISCAL', gFIS_REGRAFISCAL) = '') then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Regra fiscal ' + itemXml('CD_REGRAFISCAL', gGER_OPERACAO) + '!', cDS_METHOD);
    return(-1); exit;
  end;
  if (vInProdPropria = True) then begin
    vCdCFOPOperacao := itemXmlF('CD_CFOPPROPRIA', gFIS_REGRAFISCAL);
  end else begin
    vCdCFOPOperacao := itemXmlF('CD_CFOPTERCEIRO', gFIS_REGRAFISCAL);
  end;
  vCdCSTOperacao := Copy(itemXml('CD_CST', gFIS_REGRAFISCAL), 1, 2);

  viParams := '';
  putitemXml(viParams, 'CD_REGRAFISCAL', vCdRegraFiscal);
  gFIS_REGRAFISCAL := gModulo.ConsultarXmlUp('FIS_REGRAFISCAL', 'CD_REGRAFISCAL|', viParams);
  if (itemXml('CD_REGRAFISCAL', gFIS_REGRAFISCAL) = '') then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Regra fiscal ' + FloatToStr(vCdRegraFiscal) + ' não cadastrada!', cDS_METHOD);
    return(-1); exit;
  end else begin
    if (itemXmlF('CD_DECRETO', gFIS_REGRAFISCAL) = 2155) then begin
      if (gDsUFOrigem = 'PR') or (gDsUFOrigem = 'RS') or (gDsUFOrigem = 'SC') then begin
        if (gInContribuinte = True) and (itemXmlF('TP_MODALIDADE', gGER_OPERACAO) = 4) then begin // 4 - Venda/Compra
          if (gDsUFDestino = 'PR') or (gDsUFDestino = 'RS') or (gDsUFDestino = 'SC') then begin
            if (itemXml('TP_OPERACAO', gGER_OPERACAO) = 'S') then begin // S - Saida
              if (vInProdPropria = True) then begin
                vCdCFOP := 5401;
              end else begin
                vCdCFOP := 5403;
              end;
            end else begin
              if (vInProdPropria = True) then begin
                vCdCFOP := 1401;
              end else begin
                vCdCFOP := 1403;
              end;
            end;
            vInDecreto := True;
          end;
        end;
      end;
    end else if (itemXmlF('CD_DECRETO', gFIS_REGRAFISCAL) = 1020)
             or (itemXmlF('CD_DECRETO', gFIS_REGRAFISCAL) = 10201)
             or (itemXmlF('CD_DECRETO', gFIS_REGRAFISCAL) = 10202)
             or (itemXmlF('CD_DECRETO', gFIS_REGRAFISCAL) = 10203) then begin
      if (gDsUFOrigem = 'PR') or (gDsUFOrigem = 'SC') or (gDsUFOrigem = 'MG') then begin
        if (gInContribuinte = True) and (itemXmlF('TP_MODALIDADE', gGER_OPERACAO) = 4) then begin // 4 - Venda/Compra
          if (gDsUFDestino = 'PR') or (gDsUFDestino = 'SC') or (gDsUFDestino = 'MG') then begin
            if (itemXml('TP_OPERACAO', gGER_OPERACAO) = 'S') then begin // S - Saida
              if (vInProdPropria = True) then begin
                vCdCFOP := 5401;
              end else begin
                vCdCFOP := 5403;
              end;
            end else begin
              if (vInProdPropria = True) then begin
                vCdCFOP := 1401;
              end else begin
                vCdCFOP := 1403;
              end;
            end;
            vInDecreto := True;
          end;
        end;
      end;
    end else if (itemXmlF('CD_DECRETO', gFIS_REGRAFISCAL) = 45471) then begin
      if (gDsUFOrigem = 'RS') or (gDsUFOrigem = 'PR') or (gDsUFOrigem = 'SC') then begin
        if (gInContribuinte = True) and (itemXmlF('TP_MODALIDADE', gGER_OPERACAO) = 4) then begin // 4 - Venda/Compra
          if (gDsUFDestino = 'PR') or (gDsUFDestino = 'RS') or (gDsUFDestino = 'SC') then begin
            if (itemXml('TP_OPERACAO', gGER_OPERACAO) = 'S') then begin // S - Saida
              if (vInProdPropria = True) then begin
                vCdCFOP := 5401;
              end else begin
                vCdCFOP := 5403;
              end;
            end else begin
              if (vInProdPropria = True) then begin
                vCdCFOP := 1401;
              end else begin
                vCdCFOP := 1403;
              end;
            end;
            vInDecreto := True;
          end;
        end;
      end;
    end else if (itemXmlF('CD_DECRETO', gFIS_REGRAFISCAL) = 23731)
             or (itemXmlF('CD_DECRETO', gFIS_REGRAFISCAL) = 23732)
             or (itemXmlF('CD_DECRETO', gFIS_REGRAFISCAL) = 23733)
             or (itemXmlF('CD_DECRETO', gFIS_REGRAFISCAL) = 23734)
             or (itemXmlF('CD_DECRETO', gFIS_REGRAFISCAL) = 23735) then begin

      if (gDsUFOrigem = 'PR') or (gDsUFDestino = 'PR') then begin
        if (gInContribuinte = True) and (itemXmlF('TP_MODALIDADE', gGER_OPERACAO) = 4) then begin // 4 - Venda/Compra
          if (itemXml('TP_OPERACAO', gGER_OPERACAO) = 'S') then begin // S - Saida
            if (vInProdPropria = True) then begin
              vCdCFOP := 5401;
            end else begin
              vCdCFOP := 5403;
            end;
          end else begin
            if (vInProdPropria = True) then begin
              vCdCFOP := 1401;
            end else begin
              vCdCFOP := 1403;
            end;
          end;
          vInDecreto := True;
        end;
      end;
    end;
  end  ;

  if (vInDecreto = False) then begin
    if (vInProdPropria = True) then begin
      vCdCFOP := itemXmlF('CD_CFOPPROPRIA', gFIS_REGRAFISCAL);
    end else begin
      vCdCFOP := itemXmlF('CD_CFOPTERCEIRO', gFIS_REGRAFISCAL);
    end;

    if (vTpAreaComercio > 0) then begin
      if (vTpAreaComercio = 2) and (vTpAreaComercioOrigem = 2) then begin // 2 - Manaus
      end else begin
        if (itemXml('TP_OPERACAO', gGER_OPERACAO) = 'S') and (itemXmlF('TP_MODALIDADE', gGER_OPERACAO) = 4) then begin //Venda
          vCdCST := Copy(itemXml('CD_CST', gPRD_PRODUTO), 1, 1);
          if (vCdCST = '1') then begin
            if (vInProdPropria = True) then begin
              vCdCFOP := 5101;
            end else begin
              vCdCFOP := 5102;
            end;
          end else begin
            if (vInProdPropria = True) then begin
              vCdCFOP := 5109;
            end else begin
              vCdCFOP := 5110;
            end;
          end;
        end;
      end;
    end;
  end;

  if (gCdServico > 0) then begin
    viParams := '';
    putitemXml(viParams, 'CD_REGRAFISCAL', vCdRegraFiscal);
    voParams := activateCmp('FISSVCO033', 'buscaDadosRegraFiscal', viParams);
    if (itemXmlF('status', voParams) < 0) then begin
      Result := voParams;
      return(-1); exit;
    end;

    vCdCFOPServico := itemXmlF('CD_CFOPSERVICO', voParams);
    if (vCdCFOPServico <> 0) then begin
      vCdCFOP := vCdCFOPServico;
    end;
  end else begin
    if (Copy(itemXml('CD_CST', gFIS_REGRAFISCAL), 1, 2) = '60')   then begin
      vCdCST := Copy(itemXml('CD_CST', gFIS_REGRAFISCAL), 1, 1);
      if (gDsUFOrigem <> gDsUFDestino)  then begin
        if (gInContribuinte = True) then begin
          vCdCST := vCdCST + '10';
        end else begin
          vCdCST := vCdCST + FloatToStr(vCdCFOPOperacao);
          vCdCFOP := vCdCFOPOperacao;
        end;
      end else begin
        vCdCST := vCdCST + '60';
      end;
    end;

    if (vInDecreto = False) then begin // Só chamar este serviço se não tiver decreto na regra
      if (Copy(itemXml('CD_CST', gFIS_REGRAFISCAL), 1, 2) = '10') or (Copy(vCdCST,1,2) = '10') then begin
        vTpOperacao := itemXml('TP_OPERACAO', gGER_OPERACAO);

        viParams := '';
        putitemXml(viParams, 'CD_PRODUTO', itemXml('CD_PRODUTO', gPRD_PRODUTO));
        putitemXml(viParams, 'UF_ORIGEM', gDsUFOrigem);
        putitemXml(viParams, 'UF_DESTINO', gDsUFDestino);
        putitemXml(viParams, 'TP_OPERACAO', vTpOperacao);
        voParams := activateCmp('FISSVCO035', 'buscaDadosFiscalProduto', viParams);
        if (itemXmlF('status', voParams) < 0) then begin
          Result := voParams;
          return(-1); exit;
        end;
        vPrIvaPrd := itemXmlF('PR_SUBSTRIB', voParams);

        if (vPrIvaPrd = 0) then begin
          vCdCFOP := vCdCFOPOperacao;
        end;
      end;
    end;
  end;

  if (itemXml('TP_OPERACAO', gGER_OPERACAO) = 'E') then begin //Entrada
    if (vCdCFOP >= 4000) then begin
      Result := SetStatus(STS_ERROR, 'GEN0001', 'CFOP ' + FloatToStr(vCdCFOP) + ' do produto ' + FloatToStr(vCdProduto) + ' incompatível com a operação de entrada ' + FloatToStr(vCdOperacao) + '!', cDS_METHOD);
      return(-1); exit;
    end;

    if (vCdCFOP < 3000) then begin //Somente CFOP nacionais
      if (gDsUFOrigem = gDsUFDestino) then begin
        if (vCdCFOP >= 2000) then begin
          vCdCFOP := vCdCFOP - 1000;
        end;
      end else begin
        if (vCdCFOP < 2000) then begin
          vCdCFOP := vCdCFOP + 1000;
        end;
      end;
    end;
  end else begin
    if (vCdCFOP < 5000) then begin
      Result := SetStatus(STS_ERROR, 'GEN0001', 'CFOP ' + FloatToStr(vCdCFOP) + ' do produto ' + FloatToStr(vCdProduto) + ' incompatível com a operação de saída ' + FloatToStr(vCdOperacao) + '!', cDS_METHOD);
      return(-1); exit;
    end;

    if (vCdCFOP < 7000) then begin //Somente CFOP nacionais
      if (gDsUFOrigem = gDsUFDestino) then begin
        if (vCdCFOP >= 6000) then begin
          vCdCFOP := vCdCFOP - 1000;
        end;
      end else if (gDsUFOrigem <> gDsUFDestino) and (gDsUFDestino <> 'EX') then begin
        if (vCdCFOP < 6000) then begin
          vCdCFOP := vCdCFOP + 1000;
        end;
      end;
    end;
  end;

  if (vCdCFOP = 6101) and (gInContribuinte = False) then begin
    vCdCFOP := 6107;
  end;

  if (vCdCFOP = 6102) and (gInContribuinte = False) then begin
    vCdCFOP := 6108;
  end  ;

  if (Copy(itemXml('CD_CST', gFIS_REGRAFISCAL), 1, 2) = '70') then begin
    if (gDsUFOrigem = 'GO') then begin
      if (gDsUFOrigem <> gDsUFDestino) or (vInProdPropria <> True) or (gInContribuinte <> True) then begin
        if (vCdCFOP = 5405) then begin          // Como a regra fiscal esta como a CFOP generica 06, pois toda venda p/
          if (vInProdPropria = True) then begin // não contribuinte deverá sair com o CFOP interno de venda
             vCdCFOP := 5101;
          end else begin
            vCdCFOP := 5102;
          end;
        end;
        if (vCdCFOP = 6401) then begin
          if (gInContribuinte = True) then begin
             vCdCFOP := 6101;
          end else begin
            vCdCFOP := 6107;
          end;
        end;
      end;
    end;
  end;

  if (Copy(itemXml('CD_CST', gFIS_REGRAFISCAL), 1, 2) = '60') then begin
    if (gDsUFOrigem = 'GO') then begin
      if (gDsUFOrigem <> gDsUFDestino) or (vInProdPropria <> True) then begin
        if (vCdCFOP = 6405) then begin
          vCdCFOP := 6404;
        end;
      end;
    end;
  end;

  if (vCdCFOP = 6405) then begin
    vCdCFOP := 6403;
  end;

  Result := '';
  putitemXml(Result, 'CD_CFOP', vCdCFOP);
  return(0);
end;

//-------------------------
function T_FISSVCO015.buscaCST(pParams : String) : String;
//-------------------------
const
  cDS_METHOD = 'ADICIONAL=Operação: T_FISSVCO015.buscaCST()';
var
  viParams, voParams, vDsLstEmpresa, vCdCST, vCdMPTer, vTpOperacao, vCdCSTOperacao, vDsUF : String;
  vInProdPropria, vInDecreto, vInOrgaoPublico, vInPrReducao, vInOptSimples : Boolean;
  vCdEmpresa, vCdEmpresaParam, vCdProduto, vCdOperacao, vCdPessoa, vCdCFOP : Real;
  vCdRegraFiscal, vTpAreaComercio, vTpAreaComercioOrigem, vPrIvaPrd : Real;
begin
  Result := '';

  gDsUFOrigem := itemXml('UF_ORIGEM', PARAM_GLB);
  vInOptSimples := itemXmlB('IN_OPT_SIMPLES', PARAM_GLB);

  gDsUFDestino   := itemXml('UF_DESTINO', pParams);
  vCdProduto  := itemXmlF('CD_PRODUTO', pParams);
  vCdMPTer   := itemXml('CD_MPTER', pParams);
  gCdServico := itemXmlF('CD_SERVICO', pParams);
  vCdPessoa := itemXmlF('CD_PESSOA', pParams);
  vCdOperacao := itemXmlF('CD_OPERACAO', pParams);
  vTpAreaComercio := itemXmlF('TP_AREACOMERCIO', pParams);
  vTpAreaComercioOrigem  := itemXmlF('TP_AREA_COMERCIO_ORIGEM', PARAM_GLB);
  vCdCFOP := itemXmlF('CD_CFOP', pParams);
  vCdEmpresaParam  := itemXmlF('CD_EMPRESA', pParams);
  if (vCdEmpresaParam = 0) then begin
    vCdEmpresaParam := itemXmlF('CD_EMPRESA', PARAM_GLB);
  end;
  gTpModDctoFiscal := itemXmlF('TP_MODDCTOFISCAL', pParams);
  gTpOrigemEmissao := itemXmlF('TP_ORIGEMEMISSAO', pParams); //1 - Própria / 2 - Terceiros
  gInContribuinte := False;
  vInDecreto := False;

  if (vCdOperacao = 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Operação não informada!', cDS_METHOD);
    return(-1); exit;
  end;
  if (vCdPessoa = 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Pessoa não informada!', cDS_METHOD);
    return(-1); exit;
  end;

  vParams := '';
  putitemXml(vParams, 'CD_OPERACAO', vCdOperacao);
  gGER_OPERACAO := gModulo.ConsultarXmlUp('GER_OPERACAO', 'CD_OPERACAO|', vParams);
  if (itemXml('CD_OPERACAO', gGER_OPERACAO) = '') then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Operação ' + FloatToStr(vCdOperacao) + ' não cadastrada!', cDS_METHOD);
    return(-1); exit;
  end;

  if (vCdProduto = 0)
  and (vCdMPTer = '')
  and (gCdServico = 0) then begin
    return(-1); exit;
  end;

  if (vCdCFOP = 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'CFOP não informada!', cDS_METHOD);
    return(-1); exit;
  end;

  if (vCdMPTer <> '') then begin
    vParams := '';
    putitemXml(vParams, 'CD_PESSOA', vCdPessoa);
    putitemXml(vParams, 'CD_MPTER', vCdMPTer);
    gCDF_MPTER := gModulo.ConsultarXmlUp('CDF_MPTER', 'CD_PESSOA|CD_MPTER|', vParams);
    if (itemXml('CDF_MPTER', gCDF_MPTER) = '') then begin
      Result := SetStatus(STS_ERROR, 'GEN0001', 'Matéria-prima ' + vCdMPTer + ' não cadastrada para a pessoa ' + FloatToStr(vCdPessoa) + '!', cDS_METHOD);
      return(-1); exit;
    end;
  end else begin
    vParams := '';
    putitemXml(vParams, 'CD_PRODUTO', vCdProduto);
    gPRD_PRODUTO := gModulo.ConsultarXmlUp('PRD_PRODUTO', 'CD_PRODUTO|', vParams);
    if (itemXml('CD_PRODUTO', gPRD_PRODUTO) = '') then begin
      Result := SetStatus(STS_ERROR, 'GEN0001', 'Produto ' + FloatToStr(vCdProduto) + ' não cadastrado!', cDS_METHOD);
      return(-1); exit;
    end;
  end;

  vParams := '';
  putitemXml(vParams, 'CD_OPERACAO', vCdOperacao);
  gGER_OPERACAO := gModulo.ConsultarXmlUp('GER_OPERACAO', 'CD_OPERACAO|', vParams);
  if (itemXml('CD_OPERACAO', gGER_OPERACAO) = '') then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Operação ' + FloatToStr(vCdOperacao) + ' não cadastrada!', cDS_METHOD);
    return(-1); exit;
  end;

  viParams := '';
  putitemXml(viParams, 'CD_REGRAFISCAL', itemXmlF('CD_REGRAFISCAL', gGER_OPERACAO));
  gFIS_REGRAFISCAL := gModulo.ConsultarXmlUp('FIS_REGRAFISCAL', 'CD_REGRAFISCAL|', viParams);
  if (itemXml('CD_REGRAFISCAL', gFIS_REGRAFISCAL) = '') then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Regra fiscal ' + FloatToStr(vCdRegraFiscal) + ' não cadastrada!', cDS_METHOD);
    return(-1); exit;
  end;
  vCdCSTOperacao := Copy(itemXml('CD_CST', gFIS_REGRAFISCAL), 1, 2);

  vParams := '';
  putitemXml(vParams, 'CD_PESSOA', vCdPessoa);
  gPES_PESSOA := gModulo.ConsultarXmlUp('PES_PESSOA', 'CD_PESSOA|', vParams);
  if (itemXml('CD_PESSOA', gPES_PESSOA) = '') then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Pessoa ' + FloatToStr(vCdPessoa) + ' não cadastrada!', cDS_METHOD);
    return(-1); exit;
  end;
  gPES_PESJURIDICA := '';
  gPES_PESFISICA := '';
  if (itemXml('TP_PESSOA', gPES_PESSOA) = 'J') then begin
    vParams := '';
    putitemXml(vParams, 'CD_PESSOA', vCdPessoa);
    gPES_PESJURIDICA := gModulo.ConsultarXmlUp('PES_PESJURIDICA', 'CD_PESSOA|', vParams);
    if (itemXml('CD_PESSOA', gPES_PESJURIDICA) = '') then begin
      Result := SetStatus(STS_ERROR, 'GEN0001', 'Pessoa juridica ' + FloatToStr(vCdPessoa) + ' não cadastrada!', cDS_METHOD);
      return(-1); exit;
    end;
  end else begin
    vParams := '';
    putitemXml(vParams, 'CD_PESSOA', vCdPessoa);
    gPES_PESFISICA := gModulo.ConsultarXmlUp('PES_PESFISICA', 'CD_PESSOA|', vParams);
    if (itemXml('CD_PESSOA', gPES_PESFISICA) = '') then begin
      Result := SetStatus(STS_ERROR, 'GEN0001', 'Pessoa fisica ' + FloatToStr(vCdPessoa) + ' não cadastrada!', cDS_METHOD);
      return(-1); exit;
    end;
  end;

  vParams := '';
  putitemXml(vParams, 'CD_PESSOA', vCdPessoa);
  gPES_PFADIC := gModulo.ConsultarXmlUp('PES_PFADIC', 'CD_PESSOA|', vParams);
  if ((itemXml('TP_OPERACAO', gGER_OPERACAO) = 'S') and (itemXmlF('TP_MODALIDADE', gGER_OPERACAO) = 4))
  or ((itemXml('TP_OPERACAO', gGER_OPERACAO) = 'E') and (itemXmlF('TP_MODALIDADE', gGER_OPERACAO) = 3)) then begin //Venda / Devolução de venda
    vParams := '';
    putitemXml(vParams, 'CD_CLIENTE', vCdPessoa);
    gPES_CLIENTE := gModulo.ConsultarXmlUp('PES_CLIENTE', 'CD_CLIENTE|', vParams);
    if (itemXml('CD_CLIENTE', gPES_CLIENTE) = '') then begin
      Result := SetStatus(STS_ERROR, 'GEN0001', 'Cliente ' + FloatToStr(vCdPessoa) + ' não cadastrado!', cDS_METHOD);
      return(-1); exit;
    end;
  end;

  // Implementado por Deusdete em 22/03/2007, situação emergencial na Krindges;
  // Se for pessoa Jurídica e não tiver inscrição estadual, isto é, Isento, deverá ser tratado para fazer o cálculo do imposto then begin
  // com a alíquota interna.;
  gInPjIsento := False;
  if (itemXml('NR_INSCESTL', gPES_PESJURIDICA) = 'ISENTO')
  or (itemXml('NR_INSCESTL', gPES_PESJURIDICA) = 'ISENTA')
  or (itemXml('NR_INSCESTL', gPES_PESJURIDICA) = 'ISENTOS')
  or (itemXml('NR_INSCESTL', gPES_PESJURIDICA) = 'ISENTAS') then begin
    gInPjIsento := True;
  end;

  if (gTpOrigemEmissao = 2) then begin //Terceiros
    if (itemXmlF('TP_MODALIDADE', gGER_OPERACAO) <> 3) then begin //Devolução
      vDsUF := gDsUFOrigem;
      gDsUFOrigem := gDsUFDestino;
      gDsUFDestino := vDsUF;
    end;
  end else begin
    if (itemXmlF('TP_MODALIDADE', gGER_OPERACAO) = 3) and (itemXml('TP_OPERACAO', gGER_OPERACAO) = 'S') then begin //Devolução compra
      vDsUF := gDsUFOrigem;
      gDsUFOrigem := gDsUFDestino;
      gDsUFDestino := vDsUF;
    end;
  end;

  viParams := '';
  putitemXml(viParams, 'CD_PESSOA', vCdPessoa);
  voParams := activateCmp('FCRSVCO057', 'validaPessoaOrgaoPublico', viParams);
  if (itemXmlF('status', voParams) < 0) then begin
    Result := voParams;
    return(-1); exit;
  end;
  vInOrgaoPublico := itemXmlB('IN_ORGAOPUBLICO', voParams);

  if (vInOrgaoPublico = True) and (gDsUFOrigem = 'DF') then begin
    gInContribuinte := True;
  end else begin
    if (itemXmlB('IN_CNSRFINAL', gPES_CLIENTE) = True) or (itemXml('TP_PESSOA', gPES_PESSOA) = 'F') or (gInPjIsento = True) then begin
      if (itemXmlB('IN_CNSRFINAL', gPES_CLIENTE) = True) and (itemXml('TP_PESSOA', gPES_PESSOA) = 'J') and (gInPjIsento = False) then begin
        gInContribuinte := True;
      end else begin
        if (itemXml('TP_PESSOA', gPES_PESSOA) = 'F')
        and (itemXml('NR_CODIGOFISCAL', gPES_CLIENTE) <> '')
        and ((gDsUFOrigem = 'PR') or (gDsUFOrigem = 'SP') or (gDsUFOrigem = 'RS')) then begin
          gInContribuinte := True;
        end else begin
          gInContribuinte := False;
        end;
      end;
    end else begin
      gInContribuinte := True;
    end;
  end;

  vCdRegraFiscal := 0;

  if (gCdServico > 0) then begin
    vInProdPropria := False;
    vCdRegraFiscal := itemXmlF('CD_REGRAFISCAL', gGER_OPERACAO);
    if (vCdRegraFiscal = 0) then begin
      Result := SetStatus(STS_ERROR, 'GEN0001', 'Nenhuma regra fiscal cadastrada p/ a operação ' + FloatToStr(vCdOperacao) + '!', cDS_METHOD);
      return(-1); exit;
    end;
    vCdCST := '0';
  end else if (vCdMPTer <> '') then begin
    vInProdPropria := False;
    vCdRegraFiscal := itemXmlF('CD_REGRAFISCAL', gGER_OPERACAO);
    if (vCdRegraFiscal = 0) then begin
      Result := SetStatus(STS_ERROR, 'GEN0001', 'Nenhuma regra fiscal cadastrada p/ a operação ' + FloatToStr(vCdOperacao) + '!', cDS_METHOD);
      return(-1); exit;
    end;
    vCdCST := Copy(itemXml('CD_CST', gCDF_MPTER), 1, 1);
  end else begin
    viParams := '';
    putitemXml(viParams, 'CD_EMPRESA', vCdEmpresaParam);
    putitemXml(viParams, 'CD_PRODUTO', vCdProduto);
    voParams := activateCmp('PRDSVCO007', 'buscaDadosFilial', viParams);
    if (itemXmlF('status', voParams) < 0) then begin
      Result := voParams;
      return(-1); exit;
    end;
    vInProdPropria := itemXmlB('IN_PRODPROPRIA', voParams);

    viParams := '';
    putitemXml(viParams, 'CD_PRODUTO', vCdProduto);
    putitemXml(viParams, 'CD_OPERACAO', vCdOperacao);
    gPRD_PRDREGRAFISCAL := gModulo.ConsultarXmlUp('PRD_PRDREGRAFISCAL', 'CD_PRODUTO|CD_OPERACAO|', viParams);
    if (itemXml('CD_REGRAFISCAL', gPRD_PRDREGRAFISCAL) <> '') then begin
      viParams := '';
      putitemXml(viParams, 'CD_REGRAFISCAL', itemXmlF('CD_REGRAFISCAL', gPRD_PRDREGRAFISCAL));
      gFIS_REGRAFISCAL := gModulo.ConsultarXmlUp('FIS_REGRAFISCAL', 'CD_REGRAFISCAL|', viParams);
      if (itemXml('CD_REGRAFISCAL', gFIS_REGRAFISCAL) = '') then begin
        Result := SetStatus(STS_ERROR, 'GEN0001', 'Regra fiscal ' + itemXml('CD_REGRAFISCAL', gPRD_PRDREGRAFISCAL) + ' não cadastrada!', cDS_METHOD);
        return(-1); exit;
      end else begin
        if (itemXmlF('CD_DECRETO', gFIS_REGRAFISCAL) = 2155)
        or (itemXmlF('CD_DECRETO', gFIS_REGRAFISCAL) = 1020)
        or (itemXmlF('CD_DECRETO', gFIS_REGRAFISCAL) = 45471)
        or (itemXmlF('CD_DECRETO', gFIS_REGRAFISCAL) = 23731)
        or (itemXmlF('CD_DECRETO', gFIS_REGRAFISCAL) = 23732)
        or (itemXmlF('CD_DECRETO', gFIS_REGRAFISCAL) = 23733)
        or (itemXmlF('CD_DECRETO', gFIS_REGRAFISCAL) = 23734)
        or (itemXmlF('CD_DECRETO', gFIS_REGRAFISCAL) = 23735)
        or (itemXmlF('CD_DECRETO', gFIS_REGRAFISCAL) = 10201)
        or (itemXmlF('CD_DECRETO', gFIS_REGRAFISCAL) = 10202)
        or (itemXmlF('CD_DECRETO', gFIS_REGRAFISCAL) = 10203) then begin
          if (gInContribuinte = True) then begin
            vCdRegraFiscal := itemXmlF('CD_REGRAFISCAL', gPRD_PRDREGRAFISCAL);
          end else begin
            vCdRegraFiscal := itemXmlF('CD_REGRAFISCAL', gGER_OPERACAO);
          end;
        end else begin
          vCdRegraFiscal := itemXmlF('CD_REGRAFISCAL', gPRD_PRDREGRAFISCAL);
        end;
      end;
    end else begin
      vCdRegraFiscal := itemXmlF('CD_REGRAFISCAL', gGER_OPERACAO);
    end  ;

    if (vCdRegraFiscal = 0) then begin
      Result := SetStatus(STS_ERROR, 'GEN0001', 'Nenhuma regra fiscal cadastrada p/ o produto ' + FloatToStr(vCdProduto) + ' e a operação ' + FloatToStr(vCdOperacao) + '!', cDS_METHOD);
      return(-1); exit;
    end;

    vCdCST := Copy(itemXml('CD_CST', gPRD_PRODUTO), 1, 1);
  end;

  viParams := '';
  putitemXml(viParams, 'CD_REGRAFISCAL', vCdRegraFiscal);
  gFIS_REGRAFISCAL := gModulo.ConsultarXmlUp('FIS_REGRAFISCAL', 'CD_REGRAFISCAL|', viParams);
  if (itemXml('CD_REGRAFISCAL', gFIS_REGRAFISCAL) = '') then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Regra fiscal ' + FloatToStr(vCdRegraFiscal) + ' não cadastrada!', cDS_METHOD);
    return(-1); exit;
  end else begin
    if (itemXmlF('CD_DECRETO', gFIS_REGRAFISCAL) = 2155) then begin
      if (gDsUFOrigem = 'PR') or (gDsUFOrigem = 'RS') or (gDsUFOrigem = 'SC') then begin
        if (gInContribuinte = True) and (itemXmlF('TP_MODALIDADE', gGER_OPERACAO) = 4) then begin // 4 - Venda/Compra
          if (gDsUFDestino = 'PR') or (gDsUFDestino = 'RS') or (gDsUFDestino = 'SC') then begin
            vCdCST := Copy(itemXml('CD_CST', gPRD_PRODUTO), 1, 1);
            vCdCST := vCdCST + '10';
            vInDecreto := True;
          end;
        end;
      end;
    end else if (itemXmlF('CD_DECRETO', gFIS_REGRAFISCAL) = 1020)
             or (itemXmlF('CD_DECRETO', gFIS_REGRAFISCAL) = 10201)
             or (itemXmlF('CD_DECRETO', gFIS_REGRAFISCAL) = 10202)
             or (itemXmlF('CD_DECRETO', gFIS_REGRAFISCAL) = 10203) then begin
      if (gDsUFOrigem = 'PR') or (gDsUFOrigem = 'SC') or (gDsUFOrigem = 'MG') then begin
        if (gInContribuinte = True) and (itemXmlF('TP_MODALIDADE', gGER_OPERACAO) = 4) then begin // 4 - Venda/Compra
          if (gDsUFDestino = 'PR') or (gDsUFDestino = 'SC') or (gDsUFDestino = 'MG') then begin
            vCdCST := Copy(itemXml('CD_CST', gPRD_PRODUTO), 1, 1);
            vCdCST := vCdCST + '10';
            vInDecreto := True;
          end;
        end;
      end;
    end else if (itemXmlF('CD_DECRETO', gFIS_REGRAFISCAL) = 45471) then begin
      if (gDsUFOrigem = 'RS') or (gDsUFOrigem = 'PR') or (gDsUFOrigem = 'SC') then begin
        if (gInContribuinte = True) and (itemXmlF('TP_MODALIDADE', gGER_OPERACAO) = 4) then begin // 4 - Venda/Compra
          if (gDsUFDestino = 'PR') or (gDsUFDestino = 'RS') or (gDsUFDestino = 'SC') then begin
            vCdCST := Copy(itemXml('CD_CST', gPRD_PRODUTO), 1, 1);
            vCdCST := vCdCST + '10';
            vInDecreto := True;
          end;
        end;
      end;
    end else if (itemXmlF('CD_DECRETO', gFIS_REGRAFISCAL) = 23731)
             or (itemXmlF('CD_DECRETO', gFIS_REGRAFISCAL) = 23732)
             or (itemXmlF('CD_DECRETO', gFIS_REGRAFISCAL) = 23733)
             or (itemXmlF('CD_DECRETO', gFIS_REGRAFISCAL) = 23734)
             or (itemXmlF('CD_DECRETO', gFIS_REGRAFISCAL) = 23735) then begin
      if (gDsUFOrigem = 'PR') or (gDsUFDestino = 'PR') then begin
        if (gInContribuinte = True) and (itemXmlF('TP_MODALIDADE', gGER_OPERACAO) = 4) then begin // 4 - Venda/Compra
            vCdCST := Copy(itemXml('CD_CST', gPRD_PRODUTO), 1, 1);
            vCdCST := vCdCST + '10';
          vInDecreto := True;
        end;
      end;
    end;
  end;

  if (vInDecreto = False) then begin
    vCdCST := vCdCST + Copy(itemXml('CD_CST', gFIS_REGRAFISCAL), 1, 2);
    if (vTpAreaComercio > 0) then begin
      if (vTpAreaComercio = 2) and (vTpAreaComercioOrigem = 2) then begin // 2 - Manaus
      end else begin
        if (itemXml('TP_OPERACAO', gGER_OPERACAO) = 'S') and (itemXmlF('TP_MODALIDADE', gGER_OPERACAO) = 4) then begin //Venda
          vCdCST := Copy(itemXml('CD_CST', gFIS_REGRAFISCAL), 1, 1);
          if (vCdCST = '1') or (vCdCST = '2') then begin // Produto inportado
            vCdCST := vCdCST + '00';
          end else begin
            vCdCST := vCdCST + '40';
          end;
        end;
      end;
    end;

    if (Copy(itemXml('CD_CST', gFIS_REGRAFISCAL), 1, 2) = '70') then begin
      if (gDsUFOrigem = 'GO') then begin
        if (gDsUFOrigem <> gDsUFDestino) or (vInProdPropria <> True) or (gInContribuinte <> True) then begin
          vCdCST := Copy(itemXml('CD_CST', gPRD_PRODUTO), 1, 1);
          vCdCST := vCdCST + '00';
        end;
      end;
    end;

    if (Copy(itemXml('CD_CST', gFIS_REGRAFISCAL), 1, 2) = '60')   then begin
      vCdCST := Copy(itemXml('CD_CST', gPRD_PRODUTO), 1, 1);
      if (gDsUFOrigem <> gDsUFDestino)  then begin
        if (gInContribuinte = True) then begin
          vCdCST := vCdCST + '10';
        end else begin
          vCdCST := vCdCST + vCdCSTOperacao;
        end;
      end else begin
        vCdCST := vCdCST + '60';
      end;
    end;

    if (Copy(itemXml('CD_CST', gFIS_REGRAFISCAL), 1, 2) = '10') or (Copy(vCdCST,2,2) = '10') then begin
      vTpOperacao := itemXml('TP_OPERACAO', gGER_OPERACAO);

      viParams := '';
      putitemXml(viParams, 'CD_PRODUTO', itemXml('CD_PRODUTO', gPRD_PRODUTO));
      putitemXml(viParams, 'UF_ORIGEM', gDsUFOrigem);
      putitemXml(viParams, 'UF_DESTINO', gDsUFDestino);
      putitemXml(viParams, 'TP_OPERACAO', vTpOperacao);
      voParams := activateCmp('FISSVCO035', 'buscaDadosFiscalProduto', viParams);
      if (itemXmlF('status', voParams) < 0) then begin
        Result := voParams;
        return(-1); exit;
      end;
      vPrIvaPrd := itemXmlF('PR_SUBSTRIB', voParams);

      if (vPrIvaPrd = 0) then begin
        vCdCST := Copy(itemXml('CD_CST', gPRD_PRODUTO), 1, 1);
        vCdCST := vCdCST + vCdCSTOperacao;
      end else if (Copy(vCdCST,2,2) <> '10') then begin
        vCdCST := Copy(itemXml('CD_CST', gPRD_PRODUTO), 1, 1);
        vCdCST := vCdCST + Copy(itemXml('CD_CST', gFIS_REGRAFISCAL), 1, 2);
      end;
    end;

    if (gInContribuinte = True) and (Copy(vCdCST,2,2) = '20') then begin
      vInPrReducao := False;

      if (itemXml('TP_REDUCAO', gFIS_REGRAFISCAL) = 'A') then begin
        if (gDsUFOrigem = gDsUFDestino) then begin
          vInPrReducao := True;
        end;

      end else if (itemXml('TP_REDUCAO', gFIS_REGRAFISCAL) = 'B') then begin
        if (gDsUFOrigem = gDsUFDestino) then begin
          vInPrReducao := True;
        end;

      end else if (itemXml('TP_REDUCAO', gFIS_REGRAFISCAL) = 'C') then begin
        if (gDsUFOrigem = gDsUFDestino) then begin
          vInPrReducao := True;
        end;

      end else if (itemXml('TP_REDUCAO', gFIS_REGRAFISCAL) = 'D') then begin
        if (gDsUFOrigem <> gDsUFDestino) then begin
          vInPrReducao := True;
        end;

      end else if (itemXml('TP_REDUCAO', gFIS_REGRAFISCAL) = 'E') then begin
        if (gDsUFOrigem <> gDsUFDestino) then begin
          vInPrReducao := True;
        end;

      end else if (itemXml('TP_REDUCAO', gFIS_REGRAFISCAL) = 'F') then begin
        if (gDsUFOrigem <> gDsUFDestino) then begin
          vInPrReducao := True;
        end;

      end else if (itemXml('TP_REDUCAO', gFIS_REGRAFISCAL) = 'G') then begin
        vInPrReducao := True;

      end else if (itemXml('TP_REDUCAO', gFIS_REGRAFISCAL) = 'H') then begin
        vInPrReducao := True;

      end else if (itemXml('TP_REDUCAO', gFIS_REGRAFISCAL) = 'I') then begin
        vInPrReducao := True;
      end;

      if (vInPrReducao = False) then begin
        vCdCST := Copy(itemXml('CD_CST', gPRD_PRODUTO), 1, 1);
        vCdCST := vCdCST + '00';
      end;
    end;
  end;

  if (vCdCFOP = 5912) or (vCdCFOP = 1912) then begin
    vCdCST := Copy(itemXml('CD_CST', gPRD_PRODUTO), 1, 1);
    if (gInOptSimples = True) then begin
      vCdCST := vCdCST + '41';
    end else begin
      vCdCST := vCdCST + '50';
    end;
  end else if (vCdCFOP = 6912) or (vCdCFOP = 2912) then begin
    vCdCST := Copy(itemXml('CD_CST', gPRD_PRODUTO), 1, 1);
    if (gInOptSimples = True) then begin
      vCdCST := vCdCST + '41';
    end else begin
      vCdCST := vCdCST + '00';
    end;
  end;
  if (itemXmlB('IN_CNSRFINAL', gPES_CLIENTE) = True)
  or ((gInContribuinte = False) and (Copy(vCdCST,2,2) = '10')) then begin
    if ((itemXmlB('IN_CNSRFINAL', gPES_CLIENTE) = True) and (gInContribuinte = True))
    or (itemXmlB('IN_AMBULANTE', gPES_PFADIC) = True) then begin
    end else begin
      vCdCST := Copy(itemXml('CD_CST', gPRD_PRODUTO), 1, 1);
      vCdCST := vCdCST + '60';
    end;
  end;
  if (gCdServico > 0) and (itemXmlB('IN_ISS', gFIS_REGRAFISCAL) = True) then begin
    vCdCST := '090';
  end;

  viParams := '';
  putitemXml(viParams, 'CD_CST', vCdCST);
  gFIS_CST := gModulo.ConsultarXmlUp('FIS_CST', 'CD_CST|', viParams);
  if (itemXml('CD_CST', gFIS_CST) = '') then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'CST ' + vCdCST + ' não cadastrado!', cDS_METHOD);
    return(-1); exit;
  end;

  Result := '';
  putitemXml(Result, 'CD_CST', vCdCST);
  return(0);
end;

//----------------------------------
function T_FISSVCO015.calculaImpostoCapa(pParams : String) : String;
//----------------------------------
const
  cDS_METHOD = 'ADICIONAL=Operação: T_FISSVCO015.calculaImpostoCapa()';
var
  vDtIniVigencia, vDtFimVigencia,
  viParams, voParams, vDsUF, vDsRegistro, vDsLstImposto, vDsLstCdImposto, vCdCST, vNmMunicipio : String;
  vCdEmpresa, vCdEmpresaParam, vCdOperacao, vCdPessoa, vCdRegraFiscal, vNrSeqEnd, vCdProduto : Real;
  vVlCalc, vVlBaseCalc, vCdImposto, vVlFrete, vVlSeguro, vVlDespAcessor, vCdDecreto : Real;
  vInIPI, vInSomaFrete, vInOrgaoPublico, vInSubstituicao : Boolean;
  vDtSistema : TDateTime;
begin
  Result := '';

  vCdEmpresa := itemXmlF('CD_EMPRESA', pParams);
  if (vCdEmpresa = 0) then begin
    vCdEmpresa := itemXmlF('CD_EMPRESA', PARAM_GLB);
  end;

  gDsUFOrigem := itemXml('UF_ORIGEM', PARAM_GLB);
  gDsUFDestino := itemXml('UF_DESTINO', pParams);
  gTpOrigemEmissao := itemXmlF('TP_ORIGEMEMISSAO', pParams); //1 - Própria / 2 - Terceiros
  vCdOperacao := itemXmlF('CD_OPERACAO', pParams);
  vCdPessoa := itemXmlF('CD_PESSOA', pParams);
  vCdProduto := itemXmlF('CD_PRODUTO', pParams);
  vVlFrete := itemXmlF('VL_FRETE', pParams);
  vVlSeguro := itemXmlF('VL_SEGURO', pParams);
  vVlDespAcessor := itemXmlF('VL_DESPACESSOR', pParams);
  vCdCst := itemXml('CD_CST', pParams);
  vInIPI := itemXmlB('IN_IPI', pParams);
  gPrIPI := itemXmlF('PR_IPI', pParams);
  gCdDecretoItemCapa := itemXmlF('CD_DECRETO', pParams);
  vDtSistema := StrToDate(itemXml('DT_SISTEMA', PARAM_GLB));
  gTpAreaComercioOrigem  := itemXmlF('TP_AREA_COMERCIO_ORIGEM', PARAM_GLB);
  gTpAreaComercioDestino := 0;
  gInContribuinte := False;
  vInSubstituicao := False;

  gVlFrete := itemXmlF('VL_FRETE', pParams);
  gVlSeguro := itemXmlF('VL_SEGURO', pParams);
  gVlDespAcessor := itemXmlF('VL_DESPACESSOR', pParams);

  if (vVlFrete = 0)
  and (vVlSeguro = 0)
  and (vVlDespAcessor = 0)  then begin
    return(-1); exit;
  end;

  if (gTpOrigemEmissao = 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Tipo emissão não informado!', cDS_METHOD);
    return(-1); exit;
  end;
  if (gDsUFDestino = '') then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'UF destino não informada!', cDS_METHOD);
    return(-1); exit;
  end;
  if (vCdOperacao = 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Operação não informada!', cDS_METHOD);
    return(-1); exit;
  end;

  gPRD_PRODUTO := '';

  vParams := '';
  putitemXml(vParams, 'CD_OPERACAO', vCdOperacao);
  gGER_OPERACAO := gModulo.ConsultarXmlUp('GER_OPERACAO', 'CD_OPERACAO|', vParams);
  if (itemXml('CD_OPERACAO', gGER_OPERACAO) = '') then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Operação ' + FloatToStr(vCdOperacao) + ' não cadastrada!', cDS_METHOD);
    return(-1); exit;
  end;

  if (itemXmlB('IN_CALCIMPOSTO', gGER_OPERACAO) <> True) then begin
    return(-1); exit;
  end;

  // Carrega o codigo do primeiro produto da nota fiscal para a nova logica de Subst. tributaria.
  if (vCdProduto <> 0) then begin
    vParams := '';
    putitemXml(vParams, 'CD_PRODUTO', vCdProduto);
    gPRD_PRODUTO := gModulo.ConsultarXmlUp('PRD_PRODUTO', 'CD_PRODUTO|', vParams);
    if (itemXml('CD_PRODUTO', gPRD_PRODUTO) = '') then begin
      Result := SetStatus(STS_ERROR, 'GEN0001', 'Produto ' + FloatToStr(vCdProduto) + ' não cadastrado!', cDS_METHOD);
      return(-1); exit;
    end;

    //Incluído para calcular corretamente o imposto sobre os valores da capa
    viParams := '';
    putitemXml(viParams, 'CD_EMPRESA', vCdEmpresa);
    putitemXml(viParams, 'CD_PRODUTO', vCdProduto);
    voParams := activateCmp('PRDSVCO007', 'buscaDadosFilial', viParams); // PRDSVCO008
    if (itemXmlF('status', voParams) < 0) then begin
      Result := voParams;
      return(-1); exit;
    end;
    gInProdPropria := itemXmlB('IN_PRODPROPRIA', voParams);
  end ;

  getParam(vCdEmpresa);

  vParams := '';
  putitemXml(vParams, 'CD_PESSOA', vCdPessoa);
  gPES_PESSOA := gModulo.ConsultarXmlUp('PES_PESSOA', 'CD_PESSOA|', vParams);
  if (itemXml('CD_PESSOA', gPES_PESSOA) = '') then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Pessoa ' + FloatToStr(vCdPessoa) + ' não cadastrada!', cDS_METHOD);
    return(-1); exit;
  end;
  gPES_PESJURIDICA := '';
  gPES_PESFISICA := '';
  if (itemXml('TP_PESSOA', gPES_PESSOA) = 'J') then begin
    vParams := '';
    putitemXml(vParams, 'CD_PESSOA', vCdPessoa);
    gPES_PESJURIDICA := gModulo.ConsultarXmlUp('PES_PESJURIDICA', 'CD_PESSOA|', vParams);
    if (itemXml('CD_PESSOA', gPES_PESJURIDICA) = '') then begin
      Result := SetStatus(STS_ERROR, 'GEN0001', 'Pessoa juridica ' + FloatToStr(vCdPessoa) + ' não cadastrada!', cDS_METHOD);
      return(-1); exit;
    end;
  end else begin
    vParams := '';
    putitemXml(vParams, 'CD_PESSOA', vCdPessoa);
    gPES_PESFISICA := gModulo.ConsultarXmlUp('PES_PESFISICA', 'CD_PESSOA|', vParams);
    if (itemXml('CD_PESSOA', gPES_PESFISICA) = '') then begin
      Result := SetStatus(STS_ERROR, 'GEN0001', 'Pessoa fisica ' + FloatToStr(vCdPessoa) + ' não cadastrada!', cDS_METHOD);
      return(-1); exit;
    end;
  end;

  if ((itemXml('TP_OPERACAO', gGER_OPERACAO) = 'S') and (itemXmlF('TP_MODALIDADE', gGER_OPERACAO) = 4))
  or ((itemXml('TP_OPERACAO', gGER_OPERACAO) = 'E') and (itemXmlF('TP_MODALIDADE', gGER_OPERACAO) = 3)) then begin //Venda / Devolução de venda
    vParams := '';
    putitemXml(vParams, 'CD_CLIENTE', vCdPessoa);
    gPES_CLIENTE := gModulo.ConsultarXmlUp('PES_CLIENTE', 'CD_CLIENTE|', vParams);
    if (itemXml('CD_CLIENTE', gPES_CLIENTE) = '') then begin
      Result := SetStatus(STS_ERROR, 'GEN0001', 'Cliente ' + FloatToStr(vCdPessoa) + ' não cadastrado!', cDS_METHOD);
      return(-1); exit;
    end;
  end;

  gInPjIsento := False;
  if (itemXml('NR_INSCESTL', gPES_PESJURIDICA) = 'ISENTO')
  or (itemXml('NR_INSCESTL', gPES_PESJURIDICA) = 'ISENTA')
  or (itemXml('NR_INSCESTL', gPES_PESJURIDICA) = 'ISENTOS')
  or (itemXml('NR_INSCESTL', gPES_PESJURIDICA) = 'ISENTAS') then begin
    gInPjIsento := True;
  end;

  gInVarejista := False;
  if (itemXmlF('CD_ATIVIDADE', gPES_PESJURIDICA) = gCdAtividadeVarejista) and (gCdAtividadeVarejista <> 0) then begin
    gInVarejista := True;
  end;

  if (gTpOrigemEmissao = 2) then begin //Terceiros
    if (itemXmlF('TP_MODALIDADE', gGER_OPERACAO) <> 3) then begin //Devolução
      vDsUF := gDsUFOrigem;
      gDsUFOrigem := gDsUFDestino;
      gDsUFDestino := vDsUF;
    end;
  end else begin
    if (itemXmlF('TP_MODALIDADE', gGER_OPERACAO) = 3) and (itemXml('TP_OPERACAO', gGER_OPERACAO) = 'S') then begin //Devolução compra
      vDsUF := gDsUFOrigem;
      gDsUFOrigem := gDsUFDestino;
      gDsUFDestino := vDsUF;
    end;
  end;

  viParams := '';
  putitemXml(viParams, 'CD_PESSOA', vCdPessoa);
  voParams := activateCmp('FCRSVCO057', 'validaPessoaOrgaoPublico', viParams);
  if (itemXmlF('status', voParams) < 0) then begin
    Result := voParams;
    return(-1); exit;
  end;
  vInOrgaoPublico := itemXmlB('IN_ORGAOPUBLICO', voParams);

  if (vInOrgaoPublico = True) and (gDsUFOrigem = 'DF') then begin
    gInContribuinte := True;
  end else begin
     if (itemXmlB('IN_CNSRFINAL', gPES_CLIENTE) = True) or (itemXml('TP_PESSOA', gPES_PESSOA) = 'F') or (gInPjIsento = True) then begin
      if (itemXmlB('IN_CNSRFINAL', gPES_CLIENTE) = True) and (itemXml('TP_PESSOA', gPES_PESSOA) = 'J') and (gInPjIsento = False) then begin
        gInContribuinte := True;
      end else begin
        if (itemXml('TP_PESSOA', gPES_PESSOA) = 'F')
        and (itemXml('NR_CODIGOFISCAL', gPES_CLIENTE) <> '')
        and ((gDsUFOrigem = 'PR') or (gDsUFOrigem = 'SP') or (gDsUFOrigem = 'RS'))  then begin
          gInContribuinte := True;
        end else begin
          gInContribuinte := False;
        end;
      end;
    end else begin
      gInContribuinte := True;
    end;
  end;
  if (gInOptSimples = True) then begin
    gTpAreaComercioDestino := 0;
  end else begin
    vParams := '';
    putitemXml(vParams, 'CD_PESSOA', vCdPessoa);
    //vResult := gModulo.ConsultarXmlUp('V_PES_ENDFAT', 'CD_PESSOA|', vParams);
    vResult := activateCmp('PESSVCO001', 'buscarEnderecoFat', vParams);
    if (itemXml('CD_PESSOA', vResult) <> '') then begin
      gTpAreaComercioDestino := itemXmlF('TP_AREA_COMERCIO', vResult);
    end;
  end;
  //A verificação de pessoa jurídica foi comentado dentro do if e colocado aki, pois estava carregando a variável gTpRegimeOrigem somente then begin
  //quando era emissão de terceiros. Esta variável está sendo usado tbm para emissão própria no cálculo do ICMS.
  if (itemXml('TP_PESSOA', gPES_PESSOA) <> 'F') then begin
    if (gPES_PESJURIDICA <> '') then begin
      Result := SetStatus(STS_ERROR, 'GEN0001', 'Pessoa ' + FloatToStr(vCdPessoa) + ' não é jurídica!', cDS_METHOD);
      return(-1); exit;
    end;
    gTpRegimeOrigem := itemXmlF('TP_REGIMETRIB', gPES_PESJURIDICA);
  end;

  if (gInContribuinte = False) and (gDsUFDestino <> 'EX') then begin
    gDsUFDestino := gDsUFOrigem;
  end;

  if (gDsUFDestino = gDsUFOrigem) then begin
    if (gInSomaFreteBaseICMS = True) then begin
      vInSomaFrete := True;
    end else begin
      if (gTpOrigemEmissao = 1) and (gInContribuinte = False) then begin // 1 -Emissão própria
        vInSomaFrete := True;
      end else begin
        vInSomaFrete := False;
      end;
    end;
  end else begin
    vInSomaFrete := True;
  end;

  vVlBaseCalc := vVlSeguro + vVlDespAcessor;
  if (vInSomaFrete = True) then begin
    vVlBaseCalc := vVlBaseCalc + vVlFrete;
  end;

  gVlTotalLiquido := vVlBaseCalc;
  gVlTotalLiquidoICMS := vVlBaseCalc;
  gVlTotalBruto := vVlSeguro + vVlDespAcessor + vVlFrete;

  if (gTpOrigemEmissao = 2) then begin //Terceiros
    vVlCalc := gVlTotalBruto * gPrIPI / 100;
    gVlIPI := RoundTo(vVlCalc, 2);
  end;

  vCdRegraFiscal := itemXmlF('CD_REGRAFISCAL', gGER_OPERACAO);

  viParams := '';
  putitemXml(viParams, 'CD_PRODUTO', vCdProduto);
  putitemXml(viParams, 'CD_OPERACAO', vCdOperacao);
  gPRD_PRDREGRAFISCAL := gModulo.ConsultarXmlUp('PRD_PRDREGRAFISCAL', 'CD_PRODUTO|CD_OPERACAO|', viParams);
  if (itemXml('CD_REGRAFISCAL', gPRD_PRDREGRAFISCAL) <> '') then begin
    vCdRegraFiscal := itemXmlF('CD_REGRAFISCAL', gPRD_PRDREGRAFISCAL);
  end;

  if (vCdRegraFiscal = 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Nenhuma regra fiscal cadastrada p/ a operação ' + FloatToStr(vCdOperacao) + '!', cDS_METHOD);
    return(-1); exit;
  end;

  viParams := '';
  putitemXml(viParams, 'CD_REGRAFISCAL', vCdRegraFiscal);
  gFIS_REGRAFISCAL := gModulo.ConsultarXmlUp('FIS_REGRAFISCAL', 'CD_REGRAFISCAL|', viParams);
  if (itemXml('CD_REGRAFISCAL', gFIS_REGRAFISCAL) = '') then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Regra fiscal ' + FloatToStr(vCdRegraFiscal) + ' não cadastrada!', cDS_METHOD);
    return(-1); exit;
  end  ;

  if (vCdCST <> '') then begin
    gCdCST := vCdCST;
  end else begin
    gCdCST := '0' + itemXml('CD_CST', gFIS_REGRAFISCAL);
  end;
  vCdCST := Copy(gCdCST,2,2);
  if (vCdCST = '10') or (vCdCST = '30') or (vCdCST = '60') or (vCdCST = '70') then begin
    vInSubstituicao := True;
  end;
  if (gCdDecretoItemCapa <> 0) then begin
    viParams := '';
    putitemXml(viParams, 'CD_DECRETO', gCdDecretoItemCapa);
    gFIS_DECRETOCAPA := gModulo.ConsultarXmlUp('FIS_DECRETO', 'CD_DECRETO|', viParams);
    if (itemXml('CD_DECRETO', gFIS_DECRETOCAPA) <> '') then begin
      vCdDecreto := itemXmlF('CD_DECRETO', gFIS_DECRETOCAPA);
      vDtIniVigencia := itemXml('DT_INIVIGENCIA', gFIS_DECRETOCAPA);
      vDtFimVigencia := itemXml('DT_FIMVIGENCIA', gFIS_DECRETOCAPA);
    end;
  end else begin
    if (itemXml('CD_DECRETO', gFIS_DECRETO) <> '') then begin
      vCdDecreto := itemXmlF('CD_DECRETO', gFIS_DECRETO);
      vDtIniVigencia := itemXml('DT_INIVIGENCIA', gFIS_DECRETO);
      vDtFimVigencia := itemXml('DT_FIMVIGENCIA', gFIS_DECRETO);
    end;
  end;

  if (vCdDecreto > 0) then begin
    if (vDtIniVigencia <> '') and (vDtSistema < StrToDate(vDtIniVigencia)) then begin
      vCdDecreto := 0;
    end;
    if (vDtFimVigencia <> '') and (vDtSistema > StrToDate(vDtFimVigencia)) then begin
      vCdDecreto := 0;
    end;
  end;

  viParams := '';
  putitemXml(viParams, 'CD_UFORIGEM', gDsUFOrigem);
  putitemXml(viParams, 'CD_UFDESTINO', gDsUFDestino);
  gFIS_ALIQUOTAICMSUF := gModulo.ConsultarXmlUp('FIS_ALIQUOTAICMSUF', 'CD_UFORIGEM|CD_UFDESTINO|', viParams);
  if (itemXml('CD_UFORIGEM', gFIS_REGRAFISCAL) = '') then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Nenhuma alíquota cadastada de ' + gDsUfOrigem + ' para ' + gDsUFDestino + '!', cDS_METHOD);
    return(-1); exit;
  end;

  gFIS_IMPOSTO := '';
  gVlICMS := 0;

  vDsLstCdImposto := '';
  //Para nao calcular o IPI, ganho de Performance
  if (vInIPI <> False) then begin
    putitem(vDsLstCdImposto, '3');
  end;
  putitem(vDsLstCdImposto, '1');

  if (vCdDecreto = 2155)
  or (vCdDecreto = 1020)
  or (vCdDecreto = 45471)
  or (vCdDecreto = 23731)
  or (vCdDecreto = 23732)
  or (vCdDecreto = 23733)
  or (vCdDecreto = 23734)
  or (vCdDecreto = 23735)
  or (vCdDecreto = 10201)
  or (vCdDecreto = 10202)
  or (vCdDecreto = 10203)
  or (vInSubstituicao = True) then begin
    putitem(vDsLstCdImposto, '2');
  end;
  putitem(vDsLstCdImposto, '5');
  putitem(vDsLstCdImposto, '6');

  SetEntidadeTemp();

  repeat
    vCdImposto := StrToFloat(getitemGld(vDsLstCdImposto, 1));
    delitemGld(vDsLstCdImposto, 1);

    vParams := '';
    putitemXml(vParams, 'CD_IMPOSTO', vCdImposto);
    gFIS_IMPOSTO := gModulo.ConsultarXmlUp('FIS_IMPOSTO', 'CD_IMPOSTO|', vParams);
    if (itemXml('CD_IMPOSTO', gFIS_IMPOSTO) = '') then begin
      Result := SetStatus(STS_ERROR, 'GEN0001', 'Imposto ' + FloatToStr(vCdImposto) + ' não cadastrado!', cDS_METHOD);
      return(-1); exit;
    end;

    if (tFIS_IMPOSTO.Locate('CD_IMPOSTO', vCdImposto, []) = False) then tFIS_IMPOSTO.Append
    else tFIS_IMPOSTO.Edit;

    getlistitensoccXml(gFIS_IMPOSTO, tFIS_IMPOSTO);

    if (vCdImposto = 1) then begin //ICMS;
      Result := calculaICMS('');
    end else if (vCdImposto = 2) then begin //ICMSSubst;
      Result := calculaICMSSubst('');
    end else if (vCdImposto = 3) then begin //IPI - Saída é calculado / Entrada é digitado na tela;
      Result := calculaIPI('');
    end else if (vCdImposto = 5) then begin //COFINS;
      Result := calculaCOFINS('');
    end else if (vCdImposto = 6) then begin //PIS/PASEP;
      Result := calculaPIS('');
    end;
    if (Result <> '') then begin
      if (tFIS_IMPOSTO.State in [dsInsert, dsEdit]) then tFIS_IMPOSTO.Cancel;
      return(-1); exit;
    end;
    if (tFIS_IMPOSTO.State in [dsInsert, dsEdit]) then tFIS_IMPOSTO.Post;
  until (vDsLstCdImposto = '');

  vDsLstImposto := '';

  with tFIS_IMPOSTO do begin
    if not (IsEmpty) then begin
      First;
      while not EOF do begin
        vDsRegistro := '';
        putlistitensoccAtr(vDsRegistro, 'imposto', tFIS_IMPOSTO, tcLwr);
        putitemXml(vDsLstImposto, vDsRegistro);
        Next;
      end;
    end;
  end;

  viParams := '';
  putitemXml(viParams, 'CD_CST', gCdCST);
  gFIS_CST := gModulo.ConsultarXmlUp('FIS_CST', 'CD_CST|', viParams);
  if (itemXml('CD_CST', gFIS_CST) = '') then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'CST ' + gCdCST + ' não cadastrado!', cDS_METHOD);
    return(-1); exit;
  end;

  vDsLstImposto := ReplaceStr(vDsLstImposto, DXML, '');

  Result := '';
  putitemXml(Result, 'CD_CST', gCdCST);
  putitemXml(Result, 'CD_DECRETO', gCdDecreto);
  putitemXml(Result, 'DS_LSTIMPOSTO', vDsLstImposto);
  return(0);
end;

//----------------------------------
function T_FISSVCO015.calculaImpostoItem(pParams : String) : String;
//----------------------------------
const
  cDS_METHOD = 'ADICIONAL=Operação: T_FISSVCO015.calculaImpostoItem()';
var
  viParams, voParams, vDsUF, vDsRegistro, vDsLstImposto, vDsLstCdImposto, vCdMPTer, vNmMunicipio : String;
  vCdEmpresa, vCdEmpresaParam, vCdProduto, vCdOperacao, vCdPessoa, vNrSeqEnd : Real;
  vCdImposto, vCdRegraFiscal : Real;
  vInOrgaoPublico : Boolean;
begin
  Result := '';

  vCdEmpresa := itemXmlF('CD_EMPRESA', pParams);
  if (vCdEmpresa = 0) then begin
    vCdEmpresa := itemXmlF('CD_EMPRESA', PARAM_GLB);
  end;
  gDsUFOrigem := itemXml('UF_ORIGEM', PARAM_GLB);
  gDsUFDestino := itemXml('UF_DESTINO', pParams);
  gTpOrigemEmissao := itemXmlF('TP_ORIGEMEMISSAO', pParams);
  vCdProduto := itemXmlF('CD_PRODUTO', pParams);
  vCdMPTer := itemXml('CD_MPTER', pParams);
  gCdServico := itemXmlF('CD_SERVICO', pParams);
  vCdOperacao := itemXmlF('CD_OPERACAO', pParams);
  vCdPessoa := itemXmlF('CD_PESSOA', pParams);
  gCdCST := itemXml('CD_CST', pParams);
  gVlTotalBruto := itemXmlF('VL_TOTALBRUTO', pParams);
  gVlTotalLiquido := itemXmlF('VL_TOTALLIQUIDO', pParams);
  gVlTotalLiquidoICMS := itemXmlF('VL_TOTALLIQUIDO', pParams);
  gPrIPI := itemXmlF('PR_IPI', pParams);
  gVlIPI := itemXmlF('VL_IPI', pParams);
  gTpModDctoFiscal := itemXmlF('TP_MODDCTOFISCAL', pParams);
  vDsLstCdImposto := itemXml('DS_LST_CD_IMPOSTO', pParams);
  gTpAreaComercioOrigem := itemXmlF('TP_AREA_COMERCIO_ORIGEM', PARAM_GLB);
  gTpAreaComercioDestino := 0;
  gInContribuinte := False;
  gCdDecretoItemCapa := 0;

  if (gTpOrigemEmissao = 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Tipo emissão não informado!', cDS_METHOD);
    return(-1); exit;
  end;
  if (gDsUFDestino = '') then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'UF destino não informada!', cDS_METHOD);
    return(-1); exit;
  end ;
  if (vCdOperacao = 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Operação não informada!', cDS_METHOD);
    return(-1); exit;
  end;

  gPRD_PRODUTO := '';

  vParams := '';
  putitemXml(vParams, 'CD_OPERACAO', vCdOperacao);
  gGER_OPERACAO := gModulo.ConsultarXmlUp('GER_OPERACAO', 'CD_OPERACAO|', vParams);
  if (itemXml('CD_OPERACAO', gGER_OPERACAO) = '') then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Operação ' + FloatToStr(vCdOperacao) + ' não cadastrada!', cDS_METHOD);
    return(-1); exit;
  end;

  if (vCdProduto = 0)
  and (vCdMPTer = '')
  and (gCdServico = 0) then begin
    return(-1); exit;
  end;

  if (itemXmlB('IN_CALCIMPOSTO', gGER_OPERACAO) <> True) then begin
    return(-1); exit;
  end;

  if (gCdCST = '') then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'CST não informado!', cDS_METHOD);
    return(-1); exit;
  end;

  getParam(vCdEmpresa);

  if (gInPDVOtimizado <> True) then begin
    if (gVlTotalBruto = 0) then begin
      Result := SetStatus(STS_ERROR, 'GEN0001', 'Valor total bruto não informado p/ o produto ' + FloatToStr(vCdProduto) + '!', cDS_METHOD);
      return(-1); exit;
    end;

    if (gVlTotalLiquido = 0) then begin
      Result := SetStatus(STS_ERROR, 'GEN0001', 'Valor total líquido não informado p/ oproduto ' + FloatToStr(vCdProduto) + '!', cDS_METHOD);
      return(-1); exit;
    end;
  end;

  vParams := '';
  putitemXml(vParams, 'CD_PESSOA', vCdPessoa);
  gPES_PESSOA := gModulo.ConsultarXmlUp('PES_PESSOA', 'CD_PESSOA|', vParams);
  if (itemXml('CD_PESSOA', gPES_PESSOA) = '') then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Pessoa ' + FloatToStr(vCdPessoa) + ' não cadastrada!', cDS_METHOD);
    return(-1); exit;
  end;
  gPES_PESJURIDICA := '';
  gPES_PESFISICA := '';
  if (itemXml('TP_PESSOA', gPES_PESSOA) = 'J') then begin
    vParams := '';
    putitemXml(vParams, 'CD_PESSOA', vCdPessoa);
    gPES_PESJURIDICA := gModulo.ConsultarXmlUp('PES_PESJURIDICA', 'CD_PESSOA|', vParams);
    if (itemXml('CD_PESSOA', gPES_PESJURIDICA) = '') then begin
      Result := SetStatus(STS_ERROR, 'GEN0001', 'Pessoa juridica ' + FloatToStr(vCdPessoa) + ' não cadastrada!', cDS_METHOD);
      return(-1); exit;
    end;
  end else begin
    vParams := '';
    putitemXml(vParams, 'CD_PESSOA', vCdPessoa);
    gPES_PESFISICA := gModulo.ConsultarXmlUp('PES_PESFISICA', 'CD_PESSOA|', vParams);
    if (itemXml('CD_PESSOA', gPES_PESFISICA) = '') then begin
      Result := SetStatus(STS_ERROR, 'GEN0001', 'Pessoa fisica ' + FloatToStr(vCdPessoa) + ' não cadastrada!', cDS_METHOD);
      return(-1); exit;
    end;
  end;

  //Venda / Devolução de venda
  if ((itemXml('TP_OPERACAO', gGER_OPERACAO) = 'S') and (itemXml('TP_MODALIDADE', gGER_OPERACAO) = '4'))
  or ((itemXml('TP_OPERACAO', gGER_OPERACAO) = 'E') and (itemXml('TP_MODALIDADE', gGER_OPERACAO) = '3')) then begin
    vParams := '';
    putitemXml(vParams, 'CD_CLIENTE', vCdPessoa);
    gPES_CLIENTE := gModulo.ConsultarXmlUp('PES_CLIENTE', 'CD_CLIENTE|', vParams);
    if (itemXml('CD_CLIENTE', gPES_CLIENTE) = '') then begin
      Result := SetStatus(STS_ERROR, 'GEN0001', 'Cliente ' + FloatToStr(vCdPessoa) + ' não cadastrado!', cDS_METHOD);
      return(-1); exit;
    end;
  end;

  gInPjIsento := False;
  if (itemXml('NR_INSCESTL', gPES_PESJURIDICA) = 'ISENTO')
  or (itemXml('NR_INSCESTL', gPES_PESJURIDICA) = 'ISENTA')
  or (itemXml('NR_INSCESTL', gPES_PESJURIDICA) = 'ISENTOS')
  or (itemXml('NR_INSCESTL', gPES_PESJURIDICA) = 'ISENTAS') then begin
    gInPjIsento := True;
  end;

  gInVarejista := False;
  if (itemXmlF('CD_ATIVIDADE', gPES_PESJURIDICA) = gCdAtividadeVarejista) and (gCdAtividadeVarejista > 0) then begin
    gInVarejista := True;
  end;
  if (gTpOrigemEmissao = 2) then begin //Terceiros
    if (itemXml('TP_MODALIDADE', gGER_OPERACAO) <> '3') then begin //Devolução
      vDsUF := gDsUFOrigem;
      gDsUFOrigem := gDsUFDestino;
      gDsUFDestino := vDsUF;
    end;
  end else begin
    if ((itemXml('TP_MODALIDADE', gGER_OPERACAO) = '3') and (itemXml('TP_OPERACAO', gGER_OPERACAO) = 'S')) then begin //Devolução compra
      vDsUF  := gDsUFOrigem;
      gDsUFOrigem := gDsUFDestino;
      gDsUFDestino := vDsUF;
    end;
  end;

  viParams := '';
  putitemXml(viParams, 'CD_PESSOA', vCdPessoa);
  voParams := activateCmp('FCRSVCO057', 'validaPessoaOrgaoPublico', viParams);
  if (itemXmlF('status', voParams) < 0) then begin
    Result := voParams;
    return(-1); exit;
  end;
  vInOrgaoPublico := itemXmlB('IN_ORGAOPUBLICO', voParams);

  if (vInOrgaoPublico = True) and (gDsUFOrigem = 'DF') then begin
    gInContribuinte := True;
  end else begin
    if (itemXmlB('IN_CNSRFINAL', gPES_CLIENTE) = True) or (itemXml('TP_PESSOA', gPES_PESSOA) = 'F') or (gInPjIsento = True) then begin
      if (itemXmlB('IN_CNSRFINAL', gPES_CLIENTE) = True) and (itemXml('TP_PESSOA', gPES_PESSOA) = 'J') and (gInPjIsento = False) then begin
        gInContribuinte := True;
      end else begin
        if (itemXml('TP_PESSOA', gPES_PESSOA) = 'F')
        and (itemXml('NR_CODIGOFISCAL', gPES_CLIENTE) <> '')
        and ((gDsUFOrigem = 'PR') or (gDsUFOrigem = 'SP') or (gDsUFOrigem = 'RS')) then begin
          gInContribuinte := True;
        end else begin
          gInContribuinte := False;
        end;
      end;
    end else begin
      gInContribuinte := True;
    end;
  end;

  if (gInOptSimples = True) then begin
    gTpAreaComercioDestino := 0;
  end else begin
    vParams := '';
    putitemXml(vParams, 'CD_PESSOA', vCdPessoa);
    //vResult := gModulo.ConsultarXmlUp('V_PES_ENDFAT', 'CD_PESSOA|', vParams);
    vResult := activateCmp('PESSVCO001', 'buscarEnderecoFat', vParams);
    if (itemXml('CD_PESSOA', vResult) <> '') then begin
      gTpAreaComercioDestino := itemXmlF('TP_AREA_COMERCIO', vResult);
    end;
  end;
  //Este retrieve foi comentado dentro do if e colocado aki, pois estava carregando a variável gTpRegimeOrigem somente
  //quando era emissão de terceiros. Esta variável está sendo usado tbm para emissão própria no cálculo do ICMS.
  if (itemXml('TP_PESSOA', gPES_PESSOA) <> 'F') then begin
    if (gPES_PESJURIDICA <> '') then begin
      Result := SetStatus(STS_ERROR, 'GEN0001', 'Pessoa ' + FloatToStr(vCdPessoa) + ' não é jurídica!', cDS_METHOD);
      return(-1); exit;
    end;
    gTpRegimeOrigem := itemXmlF('TP_REGIMETRIB', gPES_PESJURIDICA);
  end;

  if (gInContribuinte = False) and (gDsUFDestino <> 'EX') then begin
    gDsUFDestino := gDsUFOrigem;
  end;

  if (itemXml('TP_MODALIDADE', gGER_OPERACAO) = 'D') and (gTpModDctoFiscal = 0) then begin // Condição implementada para o CIAP
    gTpModDctoFiscal := 85;
  end else if (itemXml('TP_MODALIDADE', gGER_OPERACAO) = 'G') and (gTpModDctoFiscal = 0)  then begin
    gTpModDctoFiscal := 87 // Nota Fiscal CIAP;
  end;

  vCdRegraFiscal := 0;

  if (gCdServico > 0) then begin
    gInProdPropria := False;
    vCdRegraFiscal := itemXmlF('CD_REGRAFISCAL', gGER_OPERACAO);
    if (vCdRegraFiscal = 0) then begin
      Result := SetStatus(STS_ERROR, 'GEN0001', 'Nenhuma regra fiscal cadastrada p/ a operação ' + FloatToStr(vCdOperacao) + '!', cDS_METHOD);
      return(-1); exit;
    end;
  end else if (vCdMPTer <> '') then begin
    gInProdPropria := False;
    vCdRegraFiscal := itemXmlF('CD_REGRAFISCAL', gGER_OPERACAO);
    if (vCdRegraFiscal = 0) then begin
      Result := SetStatus(STS_ERROR, 'GEN0001', 'Nenhuma regra fiscal cadastrada p/ a operação ' + FloatToStr(vCdOperacao) + '!', cDS_METHOD);
      return(-1); exit;
    end;
  end else begin
    vParams := '';
    putitemXml(vParams, 'CD_PRODUTO', vCdProduto);
    gPRD_PRODUTO := gModulo.ConsultarXmlUp('PRD_PRODUTO', 'CD_PRODUTO|', vParams);
    if (itemXml('CD_PRODUTO', gPRD_PRODUTO) = '') then begin
      Result := SetStatus(STS_ERROR, 'GEN0001', 'Produto ' + FloatToStr(vCdProduto) + ' não cadastrado!', cDS_METHOD);
      return(-1); exit;
    end;

    viParams := '';
    putitemXml(viParams, 'CD_EMPRESA', vCdEmpresa);
    putitemXml(viParams, 'CD_PRODUTO', vCdProduto);
    voParams := activateCmp('PRDSVCO007', 'buscaDadosFilial', viParams); // PRDSVCO008
    if (itemXmlF('status', voParams) < 0) then begin
      Result := voParams;
      return(-1); exit;
    end;
    gInProdPropria := itemXmlB('IN_PRODPROPRIA', voParams);

    viParams := '';
    putitemXml(viParams, 'CD_PRODUTO', vCdProduto);
    putitemXml(viParams, 'CD_OPERACAO', vCdOperacao);
    gPRD_PRDREGRAFISCAL := gModulo.ConsultarXmlUp('PRD_PRDREGRAFISCAL', 'CD_PRODUTO|CD_OPERACAO|', viParams);
    if (itemXml('CD_REGRAFISCAL', gPRD_PRDREGRAFISCAL) <> '') then begin
      vCdRegraFiscal := itemXmlF('CD_REGRAFISCAL', gPRD_PRDREGRAFISCAL);
    end else begin
      vCdRegraFiscal := itemXmlF('CD_REGRAFISCAL', gGER_OPERACAO);
    end;
    
    if (vCdRegraFiscal = 0) then begin
      Result := SetStatus(STS_ERROR, 'GEN0001', 'Nenhuma regra fiscal cadastrada p/ o produto ' + FloatToStr(vCdProduto) + ' e a operação ' + FloatToStr(vCdOperacao) + '!', cDS_METHOD);
      return(-1); exit;
    end;
  end;

  viParams := '';
  putitemXml(viParams, 'CD_REGRAFISCAL', vCdRegraFiscal);
  gFIS_REGRAFISCAL := gModulo.ConsultarXmlUp('FIS_REGRAFISCAL', 'CD_REGRAFISCAL|', viParams);
  if (itemXml('CD_REGRAFISCAL', gFIS_REGRAFISCAL) = '') then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Regra fiscal ' + FloatToStr(vCdRegraFiscal) + ' não cadastrada!', cDS_METHOD);
    return(-1); exit;
  end;

  viParams := '';
  putitemXml(viParams, 'CD_UFORIGEM', gDsUFOrigem);
  putitemXml(viParams, 'CD_UFDESTINO', gDsUFDestino);
  gFIS_ALIQUOTAICMSUF := gModulo.ConsultarXmlUp('FIS_ALIQUOTAICMSUF', 'CD_UFORIGEM|CD_UFDESTINO|', viParams);
  if (itemXml('CD_UFORIGEM', gFIS_ALIQUOTAICMSUF) = '') then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Nenhuma alíquota cadastada de ' + gDsUfOrigem + ' para ' + gDsUFDestino + '!', cDS_METHOD);
    return(-1); exit;
  end;

  gFIS_IMPOSTO := '';
  gVlICMS := 0;

  if (vDsLstCdImposto = '') then begin
    if (gCdServico > 0) then begin
      if (itemXmlB('IN_ISS', gFIS_REGRAFISCAL) = True) then begin
        putitem(vDsLstCdImposto, '4');
      end else begin
        putitem(vDsLstCdImposto, '1');
        putitem(vDsLstCdImposto, '2');
      end;
    end else begin
      putitem(vDsLstCdImposto, '3');
      putitem(vDsLstCdImposto, '1');
      putitem(vDsLstCdImposto, '2');
    end;
    putitem(vDsLstCdImposto, '5');
    putitem(vDsLstCdImposto, '6');
    putitem(vDsLstCdImposto, '7');
  end;

  SetEntidadeTemp();

  repeat
    vCdImposto := StrToFloat(getitemGld(vDsLstCdImposto, 1));
    delitemGld(vDsLstCdImposto, 1);

    vParams := '';
    putitemXml(vParams, 'CD_IMPOSTO', vCdImposto);
    gFIS_IMPOSTO := gModulo.ConsultarXmlUp('FIS_IMPOSTO', 'CD_IMPOSTO|', vParams);
    if (itemXml('CD_IMPOSTO', gFIS_IMPOSTO) = '') then begin
      Result := SetStatus(STS_ERROR, 'GEN0001', 'Imposto ' + FloatToStr(vCdImposto) + ' não cadastrado!', cDS_METHOD);
      return(-1); exit;
    end;

    if (tFIS_IMPOSTO.Locate('CD_IMPOSTO', vCdImposto, []) = False) then tFIS_IMPOSTO.Append
    else tFIS_IMPOSTO.Edit;

    getlistitensoccXml(gFIS_IMPOSTO, tFIS_IMPOSTO);

    if (vCdImposto = 1) then begin //ICMS;
      Result := calculaICMS('');
    end else if (vCdImposto = 2) then begin //ICMSSubst;
      Result := calculaICMSSubst('');
    end else if (vCdImposto = 3) then begin //IPI - Saída é calculado / Entrada é digitado na tela;
      Result := calculaIPI('');
    end else if (vCdImposto = 4) then begin //ISS;
      Result := calculaISS('');
    end else if (vCdImposto = 5) then begin //COFINS;
      Result := calculaCOFINS('');
    end else if (vCdImposto = 6 ) then begin//PIS;
      Result := calculaPIS('');
    end else if (vCdImposto = 7) then begin //PASEP;
      Result := calculaPASEP('');
    end;
    if (Result <> '') then begin
      if (tFIS_IMPOSTO.State in [dsInsert, dsEdit]) then tFIS_IMPOSTO.Cancel;
      return(-1); exit;
    end;
    if (tFIS_IMPOSTO.State in [dsInsert, dsEdit]) then tFIS_IMPOSTO.Post;
  until (vDsLstCdImposto = '');

  vDsLstImposto := '';

  with tFIS_IMPOSTO do begin
    if not (IsEmpty) then begin
      First;
      while not EOF do begin
        vDsRegistro := '';
        putlistitensoccAtr(vDsRegistro, 'imposto', tFIS_IMPOSTO, tcLwr);
        putitemXml(vDsLstImposto, vDsRegistro);
        Next;
      end;
    end;
  end;

  viParams := '';
  putitemXml(viParams, 'CD_CST', gCdCST);
  gFIS_CST := gModulo.ConsultarXmlUp('FIS_CST', 'CD_CST|', viParams);
  if (itemXml('CD_CST', gFIS_CST) = '') then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'CST ' + gCdCST + ' não cadastrado!', cDS_METHOD);
    return(-1); exit;
  end;

  vDsLstImposto := ReplaceStr(vDsLstImposto, DXML, '');

  Result := '';
  putitemXml(Result, 'CD_CST', gCdCST);
  putitemXml(Result, 'CD_DECRETO', gCdDecreto);
  putitemXml(Result, 'DS_LSTIMPOSTO', vDsLstImposto);
  return(0);
end;

end.
