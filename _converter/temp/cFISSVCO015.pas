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
  Classes, SysUtils, DBClient, DB,
  cServiceUnf, cDatasetUnf;

type
  T_FISSVCO015 = class(TcServiceUnf)
  private
    tGER_OPERACAO,
    tPES_PESSOA,
    tPES_PESFISICA,
    tPES_PESJURIDICA,
    tPES_PESSOACLAS,
    tPES_PFADIC,
    tPES_CLIENTE,
    tPRD_PRODUTO,
    tCDF_MPTER,
    tFIS_IMPOSTO,
    tFIS_REGRAFISCAL,
    tFIS_REGRASRV,
    tFIS_REGRAIMPOSTO,
    tFIS_TIPI,
    tFIS_CST,
    tFIS_INFOFISCAL,
    tPRD_PRDREGRAFISCAL,
    tFIS_DECRETOCAPA,
    tFIS_DECRETO,
    tFIS_ALIQUOTAICMSUF,
    tTMP_NR09 : TcDatasetUnf;
    function setEntidade(pParams : String = '') : String; override;
    function getParam(pParams : String = '') : String; override;
    function calculaCOFINS(pParams : String = '') : String;
    function calculaICMS(pParams : String = '') : String;
    function calculaICMSSubst(pParams : String = '') : String;
    function calculaIPI(pParams : String = '') : String;
    function calculaISS(pParams : String = '') : String;
    function calculaPASEP(pParams : String = '') : String;
    function calculaPIS(pParams : String = '') : String;
  public
  published
    function buscaCFOP(pParams : String = '') : String;
    function buscaCST(pParams : String = '') : String;
    function calculaImpostoCapa(pParams : String = '') : String;
    function calculaImpostoItem(pParams : String = '') : String;
  end;

implementation

uses
  cActivate, cFuncao, cXml, cStatus, dModulo;

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

//--------------------------------------------------------
function T_FISSVCO015.setEntidade(pParams : String) : String;
//--------------------------------------------------------
begin
  tGER_OPERACAO := TcDataSetUnf.getEntidade(Self, 'GER_OPERACAO');
  tPES_PESSOA := TcDataSetUnf.getEntidade(Self, 'PES_PESSOA');
  tPES_PESFISICA := TcDataSetUnf.getEntidade(Self, 'PES_PESFISICA');
  tPES_PESJURIDICA := TcDataSetUnf.getEntidade(Self, 'PES_PESJURIDICA');
  tPES_PESSOACLAS := TcDataSetUnf.getEntidade(Self, 'PES_PESSOACLAS');
  tPES_PFADIC := TcDataSetUnf.getEntidade(Self, 'PES_PFADIC');
  tPES_CLIENTE := TcDataSetUnf.getEntidade(Self, 'PES_CLIENTE');
  tPRD_PRODUTO := TcDataSetUnf.getEntidade(Self, 'PRD_PRODUTO');
  //tCDF_MPTER := TcDataSetUnf.getEntidade(Self, 'CDF_MPTER');
  tFIS_REGRAFISCAL := TcDataSetUnf.getEntidade(Self, 'FIS_REGRAFISCAL');
  tFIS_REGRASRV := TcDataSetUnf.getEntidade(Self, 'FIS_REGRASRV');
  tFIS_REGRAIMPOSTO := TcDataSetUnf.getEntidade(Self, 'FIS_REGRAIMPOSTO');
  tFIS_TIPI := TcDataSetUnf.getEntidade(Self, 'FIS_TIPI', '', 'G');
  tFIS_CST := TcDataSetUnf.getEntidade(Self, 'FIS_CST', '', 'G');
  //tFIS_INFOFISCAL := TcDataSetUnf.getEntidade(Self, 'FIS_INFOFISCAL');
  tPRD_PRDREGRAFISCAL := TcDataSetUnf.getEntidade(Self, 'PRD_PRDREGRAFISCAL');
  //tFIS_DECRETOCAPA := TcDataSetUnf.getEntidade(Self, 'FIS_DECRETOCAPA');
  tFIS_DECRETO := TcDataSetUnf.getEntidade(Self, 'FIS_DECRETO', '', 'G');
  tFIS_ALIQUOTAICMSUF := TcDataSetUnf.getEntidade(Self, 'FIS_ALIQUOTAICMSUF');
  tTMP_NR09 := TcDataSetUnf.getEntidade(Self, 'TMP_NR09');
  tFIS_IMPOSTO := TcDataSetUnf.getEntidade(Self, 'FIS_IMPOSTO');

  // calculado ???
  tFIS_IMPOSTO._LstCalc := 'VL_IMPOSTO:N(15)|VL_OUTRO:N(15)|VL_ISENTO:N(15)|VL_BASECALC:N(15)|PR_REDUBASE:N(6)|PR_BASECALC:N(6)|CD_CST:A(3)|';

  // filhas ???
  tPES_PESSOA._LstFilha := 'PES_PESSOACLAS|PES_PESJURIDICA|PES_PESFISICA|';
  tPRD_PRODUTO._LstFilha := 'FIS_TIPI|';
  tFIS_REGRAFISCAL._LstFilha := 'FIS_DECRETO|FIS_REGRAIMPOSTO|';
end;

//--------------------------------------------------------
function T_FISSVCO015.getParam(pParams : String) : String;
//--------------------------------------------------------
var
  vDsLstCFOP : String;
  pCdEmpresa : Real;
  vNrCFOP : Real;
begin
  pCdEmpresa := itemXmlF('CD_EMPRESA', pParams);
  if (pCdEmpresa = 0) then begin
    pCdEmpresa := itemXmlF('CD_EMPRESA', PARAM_GLB);
  end;

  (* parametro corporativo *)
  xParam := '';
  putitem(xParam, 'CD_EMPVALOR');
  putitem(xParam, 'CD_CLAS_REG_ESPECIAL_SC');
  putitem(xParam, 'CD_ATIVIDADE_VAREJISTA');
  putitem(xParam, 'PR_ALIQ_ICMS_MANAUS');
  putitem(xParam, 'IN_PRODPROPRIA_DEC1643');
  putitem(xParam, 'DS_LST_CFOP_IPI_BC_PISCOF');
  xParam := activateCmp('ADMSVCO001', 'GetParametro', xParam);

  gCdEmpresaValorSis := itemXmlF('CD_EMPVALOR', xParam);
  gCdClasRegEspecialSC := itemXml('CD_CLAS_REG_ESPECIAL_SC', xParam);
  gCdAtividadeVarejista := itemXmlF('CD_ATIVIDADE_VAREJISTA', xParam);
  gPrAliqICMSManaus := itemXmlF('PR_ALIQ_ICMS_MANAUS', xParam);
  gInProdPropriaDec1643 := itemXmlB('IN_PRODPROPRIA_DEC1643', xParam);
  gDsLstCfopIpiBcPisCof := itemXml('DS_LST_CFOP_IPI_BC_PISCOF', xParam);

  (* parametro empresa *)
  xParamEmp := '';
  putitem(xParamEmp, 'CD_EMPRESA_VALOR');
  putitem(xParamEmp, 'IN_OPT_SIMPLES');
  putitem(xParamEmp, 'IN_IMPOSTO_OFFLINE');
  putitem(xParamEmp, 'IN_PDV_OTIMIZADO');
  putitem(xParamEmp, 'IN_ATIVA_DECRETO_52104');
  putitem(xParamEmp, 'NATUREZA_COMERCIAL_EMP');
  putitem(xParamEmp, 'IN_SOMA_FRETE_BASEICMS');
  putitem(xParamEmp, 'IN_CALC_IPI_OUT_ENT_SAI');
  putitem(xParamEmp, 'IN_CALC_ICMS_ENT_SIMPLES');
  putitem(xParamEmp, 'PR_APLIC_MVA_SUB_TRIB');
  putitem(xParamEmp, 'IN_ARREDONDA_TRUNCA_ICMS');
  putitem(xParamEmp, 'DS_LST_MODDCTOFISCAL_AT');
  putitem(xParamEmp, 'IN_DESCONTA_PISCOFINS_ALC');
  putitem(xParamEmp, 'IN_DESCONTA_PISCOFINS_ZFM');
  putitem(xParamEmp, 'IN_RED_BASE_ICMS');
  xParamEmp := activateCmp('ADMSVCO001', 'GetParamEmpresa', pCdEmpresa, xParamEmp);

  gCdEmpresaValorEmp := itemXmlF('CD_EMPRESA_VALOR' , xParamEmp);
  gInOptSimples := itemXmlB('IN_OPT_SIMPLES', xParamEmp);
  gInImpostoOffLine := itemXmlB('IN_IMPOSTO_OFFLINE', xParamEmp);
  gInPDVOtimizado  := itemXmlB('IN_PDV_OTIMIZADO', xParamEmp);
  gInAtivaDecreto52104 := itemXmlB('IN_ATIVA_DECRETO_52104', xParamEmp);
  gNaturezaComercialEmp := itemXmlF('NATUREZA_COMERCIAL_EMP', xParamEmp);
  gInSomaFreteBaseICMS := itemXmlB('IN_SOMA_FRETE_BASEICMS', xParamEmp);
  gInCalcIpiOutEntSai := itemXmlB('IN_CALC_IPI_OUT_ENT_SAI', xParamEmp);
  gInCalculaIcmsEntSimples := itemXmlB('IN_CALC_ICMS_ENT_SIMPLES' , xParamEmp);
  gPrAplicMvaSubTrib := itemXmlF('PR_APLIC_MVA_SUB_TRIB', xParamEmp);
  gInArredondaTruncaIcms := itemXmlB('IN_ARREDONDA_TRUNCA_ICMS', xParamEmp);
  gDsLstModDctoFiscalAT := itemXml('DS_LST_MODDCTOFISCAL_AT', xParamEmp);
  gInDescontaPisCofinsAlc := itemXmlB('IN_DESCONTA_PISCOFINS_ALC', xParamEmp);
  gInDescontaPisCofinsZfm := itemXmlB('IN_DESCONTA_PISCOFINS_ZFM', xParamEmp);
  gInRedBaseIcms  := itemXmlB('IN_RED_BASE_ICMS', xParamEmp);

  clear_e(tTMP_NR09);

  vDsLstCFOP := gDsLstCfopIpiBcPisCof;
  if (vDsLstCFOP <> '') then begin
    repeat
      vNrCFOP := IffNuloF(getitemGld(vDsLstCFOP,1),0);
      delitemGld(vDsLstCFOP,1);
      if (vNrCFOP > 0) then begin
        creocc(tTMP_NR09, 1);
        putitem_o(tTMP_NR09, 'NR_GERAL', vNrCFOP);
        retrieve_o(tTMP_NR09);
      end;  
    until(vDsLstCFOP = '')
  end;

  return(0);
end;

//-----------------
function T_FISSVCO015.calculaICMS(pParams : String) : String;
//-----------------
const
  cDS_METHOD = 'ADICIONAL=Opera��o: FISSVCO015.calculaICMS()';
var
  vCdCST : String;
  vVlCalc, vVlBaseCalc, vCdDecreto, vTpProduto : Real;
  vDtSistema : TDateTime;
  vInDecreto, vInPrRedBase, vInPrRedImposto, vInReducao : Boolean;
begin

  vDtSistema := itemXmlD('DT_SISTEMA', PARAM_GLB);

  if (gInImpostoOffLine = True) then begin
    discard(tFIS_IMPOSTO);
    return(-1); exit;
  end;

  gVlICMS := 0;
  gCdDecreto := 0;
  vCdDecreto := 0;
  vInDecreto := False;

  if (item_f('CD_DECRETO', tFIS_DECRETO) > 0) then begin
    vCdDecreto := item_f('CD_DECRETO', tFIS_DECRETO);
    if (item_d('DT_INIVIGENCIA', tFIS_DECRETO) > 0) and (vDtSistema < item_d('DT_INIVIGENCIA', tFIS_DECRETO)) then begin
      vCdDecreto := 0;
    end;
    if (item_d('DT_FIMVIGENCIA', tFIS_DECRETO) > 0) and (vDtSistema > item_d('DT_FIMVIGENCIA', tFIS_DECRETO)) then begin
      vCdDecreto := 0;
    end;
  end;

  vCdCST := Copy(gCdCST,2,2);
  vTpProduto := StrToFloat(Copy(gCdCST,1,1));
  
  if (vCdCST = '60') then begin
    discard(tFIS_IMPOSTO);
    gCdDecreto := vCdDecreto;
    return(-1); exit;
  end else if (vCdCST <> '00') and (vCdCST <> '10') and (vCdCST <> '20') and (vCdCST <> '30') and (vCdCST <> '40') and (vCdCST <> '41') and (vCdCST <> '50') and (vCdCST <> '51') and (vCdCST <> '70') and (vCdCST <> '90') then begin
    if (vCdDecreto <> 2155) and (vCdDecreto <> 1020) and (vCdDecreto <> 45471) and (vCdDecreto <> 52364)
    and (vCdDecreto <> 23731) and (vCdDecreto <> 23732) and (vCdDecreto <> 23733) and (vCdDecreto <> 23734)
    and (vCdDecreto <> 23735) and (vCdDecreto <> 10901) and (vCdDecreto <> 10902) and (vCdDecreto <> 10903)
    and (vCdDecreto <> 10904) and (vCdDecreto <> 2559) and (vCdDecreto <> 52804)
    and (vCdDecreto <> 10201) and (vCdDecreto <> 10202) and (vCdDecreto <> 10203) then begin
      discard(tFIS_IMPOSTO);
      gCdDecreto := vCdDecreto;
      return(-1); exit;
    end;
  end;

  if (item_a('TP_ALIQICMS', tFIS_REGRAFISCAL) = '') then begin
    if (item_a('TP_MODALIDADE', tGER_OPERACAO) = 'E') then begin // Conhecimento de Frete
      putitem_e(tFIS_IMPOSTO, 'PR_ALIQUOTA', item_f('PR_ALIQICMS', tFIS_REGRAFISCAL));
    end else begin
      if (gTpAreaComercioOrigem = 2) and (gTpAreaComercioDestino = 2) then begin // 2 - Manaus
        putitem_e(tFIS_IMPOSTO, 'PR_ALIQUOTA', gPrAliqICMSManaus);
      end else begin
        if (gDsUFOrigem = 'MG') and (gDsUFDestino = 'MG')  then begin
          if (item_f('PR_ALIQICMS', tFIS_REGRAFISCAL) > 0) and (gInContribuinte = True) and (gInProdPropria = True) then begin
            putitem_e(tFIS_IMPOSTO, 'PR_ALIQUOTA', item_f('PR_ALIQICMS', tFIS_REGRAFISCAL));
          end else begin
            putitem_e(tFIS_IMPOSTO, 'PR_ALIQUOTA', item_f('PR_ALIQICMS', tFIS_ALIQUOTAICMSUF));
          end;
        end else begin
          //A al�quota diferenciada so pode se aplicada em NF estadual
          //Nas outra � obrigatorio respeitar a aliquota interestadual
          //A observa��o acima somente � valido quando h� somente uma al�quota interna.
          //A l�gica abaixo foi implementada p/ atender o Estado do PR que passou a trabalhar com v�rias al�quotas internas
          //Neste caso ser� obedecido o que est� na regra fiscal tanto dentro do Estado quanto fora,
          //desde que seja venda p/ consumidor final
          if (item_f('PR_ALIQICMS', tFIS_REGRAFISCAL) > 0)  then begin
            if (gDsUFOrigem = gDsUFDestino) or (gInContribuinte = False) then begin
              putitem_e(tFIS_IMPOSTO, 'PR_ALIQUOTA', item_f('PR_ALIQICMS', tFIS_REGRAFISCAL));
            end else begin
              putitem_e(tFIS_IMPOSTO, 'PR_ALIQUOTA', item_f('PR_ALIQICMS', tFIS_ALIQUOTAICMSUF));
            end;
          end else begin
            putitem_e(tFIS_IMPOSTO, 'PR_ALIQUOTA', item_f('PR_ALIQICMS', tFIS_ALIQUOTAICMSUF));
          end;
        end;
      end;
    end;
  end else begin
    if (item_a('TP_ALIQICMS', tFIS_REGRAFISCAL) = 'A')then begin // Para transa��es de opera��o Estadual
      if (item_f('PR_ALIQICMS', tFIS_REGRAFISCAL) > 0)  then begin
        if (gDsUFOrigem = gDsUFDestino) then begin
          putitem_e(tFIS_IMPOSTO, 'PR_ALIQUOTA', item_f('PR_ALIQICMS', tFIS_REGRAFISCAL));
        end else begin
          putitem_e(tFIS_IMPOSTO, 'PR_ALIQUOTA', item_f('PR_ALIQICMS', tFIS_ALIQUOTAICMSUF));
        end;
      end else begin
        putitem_e(tFIS_IMPOSTO, 'PR_ALIQUOTA', item_f('PR_ALIQICMS', tFIS_ALIQUOTAICMSUF));
      end;
    end else if (item_a('TP_ALIQICMS', tFIS_REGRAFISCAL) = 'B')then begin // Para transa��es de opera��o Interestadual
      if (item_f('PR_ALIQICMS', tFIS_REGRAFISCAL) > 0)  then begin
        if (gDsUFOrigem <> gDsUFDestino) then begin
          putitem_e(tFIS_IMPOSTO, 'PR_ALIQUOTA', item_f('PR_ALIQICMS', tFIS_REGRAFISCAL));
        end else begin
          putitem_e(tFIS_IMPOSTO, 'PR_ALIQUOTA', item_f('PR_ALIQICMS', tFIS_ALIQUOTAICMSUF));
        end;
      end else begin 
        putitem_e(tFIS_IMPOSTO, 'PR_ALIQUOTA', item_f('PR_ALIQICMS', tFIS_ALIQUOTAICMSUF));
      end;
    end else if (item_a('TP_ALIQICMS', tFIS_REGRAFISCAL) = 'C')then begin // Para transa��es de ambas as opera��es
      if (item_f('PR_ALIQICMS', tFIS_REGRAFISCAL) > 0)  then begin
        putitem_e(tFIS_IMPOSTO, 'PR_ALIQUOTA', item_f('PR_ALIQICMS', tFIS_REGRAFISCAL));
      end else begin 
        putitem_e(tFIS_IMPOSTO, 'PR_ALIQUOTA', item_f('PR_ALIQICMS', tFIS_ALIQUOTAICMSUF));
      end;
    end;
  end;
  //Emiss�o de terceiro e diferente de devolucao ou devolu��o de compra com emiss�o pr�pria
  if ((gTpOrigemEmissao = 2) and (item_a('TP_MODALIDADE', tGER_OPERACAO) <> '3'))
  or ((gTpOrigemEmissao = 1) and (item_a('TP_MODALIDADE', tGER_OPERACAO) = '3') and (item_a('TP_OPERACAO', tGER_OPERACAO) = 'S')) then begin
    if not (gInCalculaIcmsEntSimples) then begin
      if (gTpRegimeOrigem = 2) or (gTpRegimeOrigem = 3) then begin //2-Simples 3-EPP
        putitem_e(tFIS_IMPOSTO, 'PR_ALIQUOTA', 0);
      end;
    end;
    if (gTpOrigemEmissao = 1) then begin
      if (gInOptSimples = True) then begin
        putitem_e(tFIS_IMPOSTO, 'PR_ALIQUOTA', 0);
      end;
    end;
  end else begin
    if (gInOptSimples = True) then begin
      if (gDsUFOrigem <> 'PR')
      and ((item_f('TP_DOCTO', tGER_OPERACAO) = 2) or (item_f('TP_DOCTO', tGER_OPERACAO) = 3))
      and ((vCdCST = '00') or (vCdCST = '20') or (vCdCST = '51')) then begin // 2 - ECF - Nao concomitante / 3 - ECF - Concomitante;
      end else begin
        putitem_e(tFIS_IMPOSTO, 'PR_ALIQUOTA', 0);
      end;
    end;
  end;
 
  if (item_a('TP_MODALIDADE', tGER_OPERACAO) = '4') and (item_a('TP_OPERACAO', tGER_OPERACAO) = 'S')then begin // Venda
    if (vTpProduto = 1) then begin //Produto Importado
      if (gDsUFOrigem = 'ES') and (gDsUFDestino = 'ES') then begin
        if (gInContribuinte = True) then begin
          if (gInVarejista = True) then begin
            putitem_e(tFIS_IMPOSTO, 'PR_ALIQUOTA', item_f('PR_ALIQICMS', tFIS_ALIQUOTAICMSUF));
          end else begin
            putitem_e(tFIS_IMPOSTO, 'PR_ALIQUOTA', 12);
          end;
        end else begin
          putitem_e(tFIS_IMPOSTO, 'PR_ALIQUOTA', item_f('PR_ALIQICMS', tFIS_ALIQUOTAICMSUF));
        end;
      end;
    end;
  end;

  if (item_f('TP_MODALIDADE', tGER_OPERACAO) = 4) and (item_a('TP_OPERACAO', tGER_OPERACAO) = 'E') then begin // Compra
    if (gDsUFOrigem = 'SC') and (gDsUFDestino = 'SC') then begin
      if (gTpOrigemEmissao = 2) then begin // 2 - Emissao terceiro
        if (gTpRegimeOrigem = 2) or (gTpRegimeOrigem = 3) then begin //2-Simples 3-EPP
          putitem_e(tFIS_IMPOSTO, 'PR_ALIQUOTA', 7);
        end;
      end;
    end;
  end;
  if (vCdDecreto = 949) then begin // Este decreto foi revogado pelo decreto 6142 a partir de fevereiro/2006
    if (gDsUFOrigem = 'PR') then begin
      if (gTpOrigemEmissao = 1) then begin //Emiss�o pr�pria
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
      putitem_e(tFIS_IMPOSTO, 'PR_BASECALC', 66.67);
      vVlCalc := gVlTotalLiquidoICMS * item_f('PR_BASECALC', tFIS_IMPOSTO) / 100;
      putitem_e(tFIS_IMPOSTO, 'VL_BASECALC', rounded(vVlCalc, 6));
      gVlTotalLiquidoICMS := gVlTotalLiquidoICMS - item_f('VL_BASECALC', tFIS_IMPOSTO);
      vCdCST := '20';
      gCdDecreto := vCdDecreto;
    end;
  end else if (vCdDecreto = 6692) then begin // Este decreto � somente para o Estado do Mato Grosso do Sul
    if (gDsUFOrigem = 'MS') then begin
      if (gDsUFDestino = 'MS') and (gInContribuinte = True) then begin
        vInDecreto := True;
      end;
      if (vInDecreto = True) then begin
        putitem_e(tFIS_IMPOSTO, 'PR_BASECALC', 41.176);
        vVlCalc := gVlTotalLiquidoICMS * item_f('PR_BASECALC', tFIS_IMPOSTO) / 100;
        putitem_e(tFIS_IMPOSTO, 'VL_BASECALC', rounded(vVlCalc, 6));
        gVlTotalLiquidoICMS := gVlTotalLiquidoICMS - item_f('VL_BASECALC', tFIS_IMPOSTO);
        vCdCST := '20';
        gCdDecreto := vCdDecreto;
      end;
    end;
  end else if (vCdDecreto = 6142) then begin
    if (gInOptSimples <> True) then begin
      if (gDsUFOrigem = 'PR')   then begin
        if (gTpOrigemEmissao = 1) then begin //Emiss�o pr�pria
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
      if (gTpOrigemEmissao = 1) then begin //Emiss�o pr�pria
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
      Result := SetStatus(STS_ERROR, 'GEN001', 'Decreto(11.589) n�o contemplado na legisla��o tribut�ria do Paran�! Entrar em contato com os Analistas da �rea Fiscal da VirtualAge', cDS_METHOD);
      putitem_e(tFIS_IMPOSTO, 'PR_ALIQUOTA', 12);
      gCdDecreto := vCdDecreto;
      return(-1); exit;
    end;
  end else if (vCdDecreto = 48786) or (vCdDecreto = 48958) or (vCdDecreto = 48959) or (vCdDecreto = 49115) then begin // O decreto 48042 foi substituido pelo 55652
    if (gDsUFOrigem = 'SP') then begin
      if (gTpOrigemEmissao = 1) then begin //Emiss�o pr�pria
        //Venda / Devolu��o de venda
        if ((item_a('TP_OPERACAO', tGER_OPERACAO) = 'S') and (item_f('TP_MODALIDADE', tGER_OPERACAO) = 4))
        or ((item_a('TP_OPERACAO', tGER_OPERACAO) = 'E') and (item_f('TP_MODALIDADE', tGER_OPERACAO) = 3)) then begin
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
      if (item_f('PR_ALIQUOTA', tFIS_IMPOSTO) <> 18) and (item_f('PR_ALIQUOTA', tFIS_IMPOSTO) <> 25) then begin
        vInDecreto := False;
      end;
    end;
    if (vInDecreto = True) then begin
      if (item_f('PR_ALIQUOTA', tFIS_IMPOSTO) = 18) then begin
        putitem_e(tFIS_IMPOSTO, 'PR_BASECALC', 66.67);
      end else begin
        putitem_e(tFIS_IMPOSTO, 'PR_BASECALC', 48);
      end;
      vCdCST := '51';
      vVlCalc := gVlTotalLiquidoICMS * item_f('PR_BASECALC', tFIS_IMPOSTO) / 100;
      putitem_e(tFIS_IMPOSTO, 'VL_BASECALC', rounded(vVlCalc, 6));
      gVlTotalLiquidoICMS := gVlTotalLiquidoICMS - item_f('VL_BASECALC', tFIS_IMPOSTO);
      gCdDecreto := vCdDecreto;
    end;
  end else if (vCdDecreto = 55652) then begin // Este decreto substitui o 48042
    if (gDsUFOrigem = 'SP') then begin
      if (gTpOrigemEmissao = 1) then begin //Emiss�o pr�pria
        //Venda / Devolu��o de venda
        if ((item_a('TP_OPERACAO', tGER_OPERACAO) = 'S') and (item_f('TP_MODALIDADE', tGER_OPERACAO) = 4))
        or ((item_a('TP_OPERACAO', tGER_OPERACAO) = 'E') and (item_f('TP_MODALIDADE', tGER_OPERACAO) = 3)) then begin
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
      if (item_f('PR_ALIQUOTA', tFIS_IMPOSTO) <> 18) and (item_f('PR_ALIQUOTA', tFIS_IMPOSTO) <> 25) then begin
        vInDecreto := False;
      end;
    end;
    if (vInDecreto = True) then begin
      if (item_f('PR_REDUBASE', tFIS_REGRAFISCAL) > 0) then begin
        putitem_e(tFIS_IMPOSTO, 'PR_REDUBASE', item_f('PR_REDUBASE', tFIS_REGRAFISCAL));
        putitem_e(tFIS_IMPOSTO, 'PR_BASECALC', 100 - item_f('PR_REDUBASE', tFIS_REGRAFISCAL));
      end else begin
        if (item_f('PR_ALIQUOTA', tFIS_IMPOSTO) = 18) then begin
          putitem_e(tFIS_IMPOSTO, 'PR_BASECALC', 38.89);
        end else begin
          putitem_e(tFIS_IMPOSTO, 'PR_BASECALC', 28);
        end;
      end;
      vCdCST := '51';
      vVlCalc := gVlTotalLiquidoICMS * item_f('PR_BASECALC', tFIS_IMPOSTO) / 100;
      putitem_e(tFIS_IMPOSTO, 'VL_BASECALC', rounded(vVlCalc, 6));
      gVlTotalLiquidoICMS := gVlTotalLiquidoICMS - item_f('VL_BASECALC', tFIS_IMPOSTO);
      gCdDecreto := vCdDecreto;
    end;
  end else if (vCdDecreto = 2401) then begin
    if (gTpOrigemEmissao = 1) then begin //Emiss�o pr�pria
      //Venda / Devolu��o de venda
      if ((item_a('TP_OPERACAO', tGER_OPERACAO) = 'S') and (item_f('TP_MODALIDADE', tGER_OPERACAO) = 4))
      or ((item_a('TP_OPERACAO', tGER_OPERACAO) = 'E') and (item_f('TP_MODALIDADE', tGER_OPERACAO) = 3)) then begin
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
      if (item_f('PR_ALIQUOTA', tFIS_IMPOSTO) <> 7) and (item_f('PR_ALIQUOTA', tFIS_IMPOSTO) <> 12) then begin
        vInDecreto := False;
      end;
    end;
    if (vInDecreto = True) then begin
      if (item_f('PR_ALIQUOTA', tFIS_IMPOSTO) = 7) then begin
        putitem_e(tFIS_IMPOSTO, 'PR_REDUBASE', 9.9);
      end else if (item_f('PR_ALIQUOTA', tFIS_IMPOSTO) = 12) then begin
        putitem_e(tFIS_IMPOSTO, 'PR_REDUBASE', 10.49);
      end;
      vVlCalc := gVlTotalLiquidoICMS * item_f('PR_REDUBASE', tFIS_IMPOSTO) / 100;
      putitem_e(tFIS_IMPOSTO, 'VL_BASECALC', gVlTotalLiquidoICMS - rounded(vVlCalc, 6));
      gVlTotalLiquidoICMS := rounded(vVlCalc, 6);
       vCdCST := '20';
      gCdDecreto := vCdDecreto;
    end;
  end else if (vCdDecreto = 1643) and ((gInProdPropriaDec1643 = False) or (gInProdPropria = True)) then begin
    if (gDsUFOrigem = 'ES') and (gDsUFDestino = 'ES') then begin
      if (gInContribuinte = True) and ((gTpRegimeOrigem = 2) or (gTpRegimeOrigem = 3))then begin // 2-Simples 3-EPP
        putitem_e(tFIS_IMPOSTO, 'PR_BASECALC', 41.177);
        putitem_e(tFIS_IMPOSTO, 'PR_REDUBASE', 58.823);
        vInDecreto := True;
      end else if (gInContribuinte = True) and (gTpRegimeOrigem <> 2) and (gTpRegimeOrigem <> 3)then begin // Empresa Normal
        if (gDsUFDestino <> gDsUFOrigem) then begin
          // Conforme consulta ao IOB pelo Sr. Deusdete, nao foi confirmado esta reducao para operacao interestadual
        end else begin
          putitem_e(tFIS_IMPOSTO, 'PR_BASECALC', 70.589);
          putitem_e(tFIS_IMPOSTO, 'PR_REDUBASE', 29.411);
          vInDecreto := True;
        end;
      end;

      if (vInDecreto = True) then begin
        vVlCalc := gVlTotalLiquidoICMS * item_f('PR_BASECALC', tFIS_IMPOSTO) / 100;
        putitem_e(tFIS_IMPOSTO, 'VL_BASECALC', rounded(vVlCalc, 6));
        gVlTotalLiquidoICMS := gVlTotalLiquidoICMS - item_f('VL_BASECALC', tFIS_IMPOSTO);
        vCdCST := '20';
        gCdDecreto := vCdDecreto;
      end;
    end;
  end else if (vCdDecreto = 44238) then begin // Decreto valido para o estado do Rio Grande do Sul
    if (gDsUFOrigem = 'RS') and (gDsUFDestino = 'RS') then begin
      if (gInContribuinte = True)
      and ((item_a('TP_MODALIDADE', tGER_OPERACAO) = '3') or (item_f('TP_MODALIDADE', tGER_OPERACAO) = 4)) then begin // 3 - Devolucao / 4 - Venda/Compra
        if (gTpOrigemEmissao = 1) then begin //Emiss�o pr�pria
          if (gInProdPropria = True) then begin
            putitem_e(tFIS_IMPOSTO, 'PR_BASECALC', 70.589);
            putitem_e(tFIS_IMPOSTO, 'PR_REDUBASE', 29.411);
            vInDecreto := True;
          end;
        end else begin
          putitem_e(tFIS_IMPOSTO, 'PR_BASECALC', 70.589);
          putitem_e(tFIS_IMPOSTO, 'PR_REDUBASE', 29.411);
          vInDecreto := True;
        end;
      end;

      if (vInDecreto = True) then begin
        vVlCalc := gVlTotalLiquidoICMS * item_f('PR_BASECALC', tFIS_IMPOSTO) / 100;
        putitem_e(tFIS_IMPOSTO, 'VL_BASECALC', rounded(vVlCalc, 6));
        gVlTotalLiquidoICMS := gVlTotalLiquidoICMS - item_f('VL_BASECALC', tFIS_IMPOSTO);
        vCdCST := '20';
        gCdDecreto := vCdDecreto;
      end;
    end;
  end else if (vCdDecreto = 105) then begin // Decreto valido para o estado de Santa Catarina
    if (gDsUFOrigem = 'SC') then begin
      if (gDsUFDestino = 'SC') and (gInContribuinte = True)
      and (((item_a('TP_OPERACAO', tGER_OPERACAO) = 'E') and (item_f('TP_MODALIDADE', tGER_OPERACAO) = 4))
        or ((item_a('TP_OPERACAO', tGER_OPERACAO) = 'S') and (item_f('TP_MODALIDADE', tGER_OPERACAO) = 4))) then begin //Compra / Venda
        if (gCdClasRegEspecialSC <> '') then begin
          clear_e(tPES_PESSOACLAS);
          putitem_o(tPES_PESSOACLAS, 'CD_PESSOA', '');
          putitem_o(tPES_PESSOACLAS, 'CD_TIPOCLAS', gCdClasRegEspecialSC);
          retrieve_e(tPES_PESSOACLAS);
          if (item_a('CD_CLASSIFICACAO', tPES_PESSOACLAS) = 'S') then begin
            putitem_e(tFIS_IMPOSTO, 'PR_ALIQUOTA', 12);
            vCdCST := '00';
            gCdDecreto := vCdDecreto;
            vInDecreto := True;
          end;
        end;
      end;
    end;
  end else if (vCdDecreto = 13214) then begin // Decreto valido para o estado do Paran�
    if (gDsUFOrigem = 'PR') or (gDsUFDestino = 'PR') then begin
      if (gInContribuinte = True) and (item_f('TP_MODALIDADE', tGER_OPERACAO) = 4) then begin // Venda/Compra
        if (item_f('PR_ALIQUOTA', tFIS_IMPOSTO) = 7) then begin
          putitem_e(tFIS_IMPOSTO, 'PR_BASECALC', 100);
          vInDecreto := True;
        end else if (item_f('PR_ALIQUOTA', tFIS_IMPOSTO) = 12) then begin
          putitem_e(tFIS_IMPOSTO, 'PR_BASECALC', 58.332);
          putitem_e(tFIS_IMPOSTO, 'PR_REDUBASE', 41.668);
          vInDecreto := True;
        end else if (item_f('PR_ALIQUOTA', tFIS_IMPOSTO) = 18) then begin
          putitem_e(tFIS_IMPOSTO, 'PR_BASECALC', 38.887);
          putitem_e(tFIS_IMPOSTO, 'PR_REDUBASE', 61.113);
          vInDecreto := True;
        end;
      end;

      if (vInDecreto = True) then begin
        vVlCalc := gVlTotalLiquidoICMS * item_f('PR_BASECALC', tFIS_IMPOSTO) / 100;
        putitem_e(tFIS_IMPOSTO, 'VL_BASECALC', rounded(vVlCalc, 6));
        gVlTotalLiquidoICMS := gVlTotalLiquidoICMS - item_f('VL_BASECALC', tFIS_IMPOSTO);
        vCdCST := '20';
        gCdDecreto := vCdDecreto;
      end;
    end;
  end else if (vCdDecreto = 12462) then begin // Decreto valido para o estado de Goi�s
    if (gDsUFOrigem = 'GO') and (gDsUFDestino = 'GO') then begin
      if (gInContribuinte = True)
      and ((item_f('TP_MODALIDADE', tGER_OPERACAO) = 2) or (item_f('TP_MODALIDADE', tGER_OPERACAO) = 3) or (item_f('TP_MODALIDADE', tGER_OPERACAO) = 4)) then begin
        //2 - Transferencia / 3 - Devolucao / 4 - Venda/Compra
        putitem_e(tFIS_IMPOSTO, 'PR_BASECALC', 58.82);
        putitem_e(tFIS_IMPOSTO, 'PR_REDUBASE', 41.18);
        vInDecreto := True;
      end;

      if (vInDecreto = True) then begin
        vVlCalc := gVlTotalLiquidoICMS * item_f('PR_BASECALC', tFIS_IMPOSTO) / 100;
        putitem_e(tFIS_IMPOSTO, 'VL_BASECALC', rounded(vVlCalc, 6));
        gVlTotalLiquidoICMS := gVlTotalLiquidoICMS - item_f('VL_BASECALC', tFIS_IMPOSTO);
        vCdCST := '20';
        gCdDecreto := vCdDecreto;
      end;
    end;
  end else begin
    gCdDecreto := vCdDecreto;
  end;

  if (vCdCST = '00') or (vCdCST = '10') then begin
    if (vCdDecreto = 52364)then begin // Decreto do Estado de S�o Paulo
      if (item_f('PR_REDUBASE', tFIS_REGRAFISCAL) > 0) then begin
        putitem_e(tFIS_IMPOSTO, 'PR_REDUBASE', item_f('PR_REDUBASE', tFIS_REGRAFISCAL));
        putitem_e(tFIS_IMPOSTO, 'PR_BASECALC', 100 - item_f('PR_REDUBASE', tFIS_REGRAFISCAL));
        vVlCalc := gVlTotalLiquidoICMS - (gVlTotalLiquidoICMS * item_f('PR_REDUBASE', tFIS_IMPOSTO) / 100);
        putitem_e(tFIS_IMPOSTO, 'VL_BASECALC', rounded(vVlCalc, 6));
      end else begin
        putitem_e(tFIS_IMPOSTO, 'PR_BASECALC', 100);
        putitem_e(tFIS_IMPOSTO, 'VL_BASECALC', gVlTotalLiquidoICMS);
      end;
      putitem_e(tFIS_IMPOSTO, 'VL_OUTRO', gVlTotalLiquidoICMS - item_f('VL_BASECALC', tFIS_IMPOSTO));
    end else if (vCdDecreto = 23731) or (vCdDecreto = 23732) or (vCdDecreto = 23733) or (vCdDecreto = 23734) or (vCdDecreto = 23735)then begin // Decreto do Estado do Paran�
      if (item_f('PR_REDUBASE', tFIS_REGRAFISCAL) > 0) then begin
        putitem_e(tFIS_IMPOSTO, 'PR_REDUBASE', item_f('PR_REDUBASE', tFIS_REGRAFISCAL));
        putitem_e(tFIS_IMPOSTO, 'PR_BASECALC', 100 - item_f('PR_REDUBASE', tFIS_REGRAFISCAL));
        vVlCalc := gVlTotalLiquidoICMS - (gVlTotalLiquidoICMS * item_f('PR_REDUBASE', tFIS_IMPOSTO) / 100);
        putitem_e(tFIS_IMPOSTO, 'VL_BASECALC', rounded(vVlCalc, 6));
      end else begin
        putitem_e(tFIS_IMPOSTO, 'PR_BASECALC', 100);
        putitem_e(tFIS_IMPOSTO, 'VL_BASECALC', gVlTotalLiquidoICMS);
      end;
      putitem_e(tFIS_IMPOSTO, 'VL_OUTRO', gVlTotalLiquidoICMS - item_f('VL_BASECALC', tFIS_IMPOSTO));
      gVlTotalLiquidoICMS := item_f('VL_BASECALC', tFIS_IMPOSTO);
    end else if (vCdDecreto = 10901) or (vCdDecreto = 10902) or (vCdDecreto = 10903) or (vCdDecreto = 10904)then begin // Decreto do Estado de Espirito Santo
      if (item_f('PR_REDUBASE', tFIS_REGRAFISCAL) > 0) then begin
        if (gDsUFOrigem = 'ES') and (gDsUFDestino = 'ES') then begin
          putitem_e(tFIS_IMPOSTO, 'PR_BASECALC', 100);
          putitem_e(tFIS_IMPOSTO, 'VL_BASECALC', gVlTotalLiquidoICMS);
        end else begin
          putitem_e(tFIS_IMPOSTO, 'PR_REDUBASE', item_f('PR_REDUBASE', tFIS_REGRAFISCAL));
          putitem_e(tFIS_IMPOSTO, 'PR_BASECALC', 100 - item_f('PR_REDUBASE', tFIS_REGRAFISCAL));
          vVlCalc := gVlTotalLiquidoICMS - (gVlTotalLiquidoICMS * item_f('PR_REDUBASE', tFIS_IMPOSTO) / 100);
          putitem_e(tFIS_IMPOSTO, 'VL_BASECALC', rounded(vVlCalc, 6));
        end;
      end else begin
        putitem_e(tFIS_IMPOSTO, 'PR_BASECALC', 100);
        putitem_e(tFIS_IMPOSTO, 'VL_BASECALC', gVlTotalLiquidoICMS);
      end;
      putitem_e(tFIS_IMPOSTO, 'VL_OUTRO', gVlTotalLiquidoICMS - item_f('VL_BASECALC', tFIS_IMPOSTO));
      gVlTotalLiquidoICMS := item_f('VL_BASECALC', tFIS_IMPOSTO);
    end else begin
      putitem_e(tFIS_IMPOSTO, 'PR_BASECALC', 100);
      putitem_e(tFIS_IMPOSTO, 'VL_BASECALC', gVlTotalLiquidoICMS);
      if ((gCdDecreto = 1643) and ((gInProdPropriaDec1643 = False) or (gInProdPropria = True))) or (gCdDecreto = 56066)then begin
        gCdDecreto := 0;
        vInDecreto := False;
      end;
    end;
    //Quando for substitui�ao tribut�ria n�o contemplada(CST 00) para n�o contribuinte n�o � aplicado o decreto
    if (vCdCST = '00')
    and ((item_a('CD_CST', tFIS_REGRAFISCAL) = '10') or (item_a('CD_CST', tFIS_REGRAFISCAL) = '60') or (item_a('CD_CST', tFIS_REGRAFISCAL) = '70')) then begin
      gCdDecreto := 0;
    end;
    if (vCdCST = '10')
    and ((item_a('TP_OPERACAO', tGER_OPERACAO) = 'E') and (item_f('TP_MODALIDADE', tGER_OPERACAO) <> 3)) then begin // Entrada e n�o for devolu��o
      if (item_f('VL_BASECALC', tFIS_IMPOSTO) > 0) then begin
        vVlCalc := item_f('VL_BASECALC', tFIS_IMPOSTO) * item_f('PR_ALIQUOTA', tFIS_IMPOSTO) / 100;
        gVlICMS := rounded(vVlCalc, 6);
      end;
      putitem_e(tFIS_IMPOSTO, 'VL_OUTRO', item_f('VL_OUTRO', tFIS_IMPOSTO) + item_f('VL_BASECALC', tFIS_IMPOSTO));
      putitem_e(tFIS_IMPOSTO, 'VL_IMPOSTO', 0);
      putitem_e(tFIS_IMPOSTO, 'VL_BASECALC', 0);
      putitem_e(tFIS_IMPOSTO, 'PR_BASECALC', 0);
      putitem_e(tFIS_IMPOSTO, 'PR_REDUBASE', 0);
    end;
  end else if (vCdCST = '20') or (vCdCST = '70') or (vCdCST = '30') then begin
    if (vInDecreto = True) then begin
      if (vCdDecreto = 12462)
      or ((vCdDecreto = 1643) and ((gInProdPropriaDec1643 = False) or (gInProdPropria = True))) then begin
        putitem_e(tFIS_IMPOSTO, 'VL_ISENTO', gVlTotalLiquidoICMS);
      end else begin
        putitem_e(tFIS_IMPOSTO, 'VL_OUTRO', gVlTotalLiquidoICMS);
      end;
    end else begin
      vInReducao := False;
      if (item_f('PR_REDUBASE', tFIS_REGRAFISCAL) > 0) and (gInContribuinte = True) then begin
        if (item_a('TP_OPERACAO', tGER_OPERACAO) = 'S') then begin
          if ((gInRedBaseIcms = True) and (gInProdPropria = True))
          or (gInRedBaseIcms = False)
          or (item_f('CD_CFOPPROPRIA', tFIS_REGRAFISCAL) = 5551)
          or (item_a('TP_MODALIDADE', tGER_OPERACAO) = '3')
          or ((gTpOrigemEmissao = 1) and (gDsUFOrigem = 'RS')) then begin
            vInReducao := True;
            vCdDecreto := item_f('CD_DECRETO', tFIS_DECRETO);
            vInDecreto := True;
          end else begin
            vCdDecreto := 0;
            vInDecreto := False;
          end;
        end else begin
          if ((item_a('TP_MODALIDADE', tGER_OPERACAO) <> '3') or ((item_a('TP_MODALIDADE', tGER_OPERACAO) = '3') and ((gInRedBaseIcms = True) and (gInProdPropria = True)) or (gInRedBaseIcms = False) ) )
          or ((gTpOrigemEmissao = 2) and (gDsUFDestino = 'RS')) then begin
            vInReducao := True;
            vCdDecreto := item_f('CD_DECRETO', tFIS_DECRETO);
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
          if (item_a('TP_REDUCAO', tFIS_REGRAFISCAL) = 'A') then begin
            if (gDsUFOrigem = gDsUFDestino) then begin
              vInPrRedBase := True;
              gCdDecreto := vCdDecreto;
            end;

          end else if (item_a('TP_REDUCAO', tFIS_REGRAFISCAL) = 'B') then begin
            if (gDsUFOrigem = gDsUFDestino) then begin
              vInPrRedImposto := True;
              gCdDecreto := vCdDecreto;
            end;

          end else if (item_a('TP_REDUCAO', tFIS_REGRAFISCAL) = 'C') then begin
            if (gDsUFOrigem = gDsUFDestino) then begin
              vInPrRedBase := True;
              vInPrRedImposto := True;
              gCdDecreto := vCdDecreto;
            end;

          end else if (item_a('TP_REDUCAO', tFIS_REGRAFISCAL) = 'D') then begin
            if (gDsUFOrigem <> gDsUFDestino) then begin
              vInPrRedBase := True;
              gCdDecreto := vCdDecreto;
            end;

          end else if (item_a('TP_REDUCAO', tFIS_REGRAFISCAL) = 'E') then begin
            if (gDsUFOrigem <> gDsUFDestino) then begin
              vInPrRedImposto := True;
              gCdDecreto := vCdDecreto;
            end;

          end else if (item_a('TP_REDUCAO', tFIS_REGRAFISCAL) = 'F') then begin
            if (gDsUFOrigem <> gDsUFDestino) then begin
              vInPrRedBase := True;
              vInPrRedImposto := True;
              gCdDecreto := vCdDecreto;
            end;

          end else if (item_a('TP_REDUCAO', tFIS_REGRAFISCAL) = 'G') then begin
            vInPrRedBase := True;
            gCdDecreto := vCdDecreto;

          end else if (item_a('TP_REDUCAO', tFIS_REGRAFISCAL) = 'H') then begin
            vInPrRedImposto := True;
            gCdDecreto := vCdDecreto;

          end else if (item_a('TP_REDUCAO', tFIS_REGRAFISCAL) = 'I') then begin
            vInPrRedBase := True;
            vInPrRedImposto := True;
            gCdDecreto := vCdDecreto;
          end;
        end else begin 
          vInPrRedBase := True;
          vInPrRedImposto := True;
        end;

        if (vInPrRedBase <> True) and (gCdDecreto <> 6142) then begin
          putitem_e(tFIS_IMPOSTO, 'PR_REDUBASE', 0);
          putitem_e(tFIS_IMPOSTO, 'PR_BASECALC', 100);
          vVlCalc := gVlTotalLiquidoICMS - (gVlTotalLiquidoICMS * item_f('PR_REDUBASE', tFIS_IMPOSTO) / 100);
          putitem_e(tFIS_IMPOSTO, 'VL_BASECALC', rounded(vVlCalc, 6));
          gCdDecreto := 0;
          vInDecreto := False;
        end else begin
          putitem_e(tFIS_IMPOSTO, 'PR_REDUBASE', item_f('PR_REDUBASE', tFIS_REGRAFISCAL));
          putitem_e(tFIS_IMPOSTO, 'PR_BASECALC', 100 - item_f('PR_REDUBASE', tFIS_REGRAFISCAL));
          vVlCalc := gVlTotalLiquidoICMS - (gVlTotalLiquidoICMS * item_f('PR_REDUBASE', tFIS_IMPOSTO) / 100);
          putitem_e(tFIS_IMPOSTO, 'VL_BASECALC', rounded(vVlCalc, 6));
        end;

      end else begin
        vCdCST := '00';
        putitem_e(tFIS_IMPOSTO, 'PR_BASECALC', 100);
        putitem_e(tFIS_IMPOSTO, 'VL_BASECALC', gVlTotalLiquidoICMS);
        if ((gCdDecreto = 1643)and((gInProdPropriaDec1643 = False)or(gInProdPropria = True))) or (gCdDecreto = 56066) then begin
          gCdDecreto := 0;
          vInDecreto := False;
        end;
      end;
      putitem_e(tFIS_IMPOSTO, 'VL_OUTRO', gVlTotalLiquidoICMS - item_f('VL_BASECALC', tFIS_IMPOSTO));
    end;
    if (vCdCST = '30') or (vCdCST = '70') then begin
      if (item_a('TP_OPERACAO', tGER_OPERACAO) = 'E') or ((item_a('TP_OPERACAO', tGER_OPERACAO) = 'S') and (gInOptSimples = True)) then begin
        if (item_f('VL_BASECALC', tFIS_IMPOSTO) > 0) then begin
          vVlCalc := item_f('VL_BASECALC', tFIS_IMPOSTO) * item_f('PR_ALIQUOTA', tFIS_IMPOSTO) / 100;
          gVlICMS := rounded(vVlCalc, 6);
        end;
        putitem_e(tFIS_IMPOSTO, 'VL_OUTRO', item_f('VL_OUTRO', tFIS_IMPOSTO) + item_f('VL_BASECALC', tFIS_IMPOSTO));
        putitem_e(tFIS_IMPOSTO, 'VL_IMPOSTO', 0);
        putitem_e(tFIS_IMPOSTO, 'VL_BASECALC', 0);
        putitem_e(tFIS_IMPOSTO, 'PR_BASECALC', 0);
        putitem_e(tFIS_IMPOSTO, 'PR_REDUBASE', 0);
      end;
    end;
    if (vCdCST = '30') and (gInOptSimples = False) then begin
      gVlTotalLiquidoICMS := item_f('VL_OUTRO', tFIS_IMPOSTO) + item_f('VL_BASECALC', tFIS_IMPOSTO);
      vVlCalc := gVlTotalLiquidoICMS * item_f('PR_ALIQUOTA', tFIS_IMPOSTO) / 100;
      gVlICMS := rounded(vVlCalc, 6);
      discard(tFIS_IMPOSTO);
      return(-1); exit;
    end;
  end else if (vCdCST = '40') or (vCdCST = '41') then begin
    putitem_e(tFIS_IMPOSTO, 'PR_ALIQUOTA', 0);
    putitem_e(tFIS_IMPOSTO, 'VL_ISENTO', gVlTotalLiquidoICMS);
  end else if (vCdCST = '50') then begin
    putitem_e(tFIS_IMPOSTO, 'PR_ALIQUOTA', 0);
    putitem_e(tFIS_IMPOSTO, 'VL_OUTRO', gVlTotalLiquidoICMS);
  end else if (vCdCST = '51') then begin
    if (vInDecreto = True)  then begin
      putitem_e(tFIS_IMPOSTO, 'VL_OUTRO', gVlTotalLiquidoICMS);
    end else begin
      if (item_f('PR_REDUBASE', tFIS_REGRAFISCAL) > 0) then begin
        putitem_e(tFIS_IMPOSTO, 'PR_REDUBASE', item_f('PR_REDUBASE', tFIS_REGRAFISCAL));
        vVlCalc := gVlTotalLiquidoICMS - (gVlTotalLiquidoICMS * item_f('PR_REDUBASE', tFIS_IMPOSTO) / 100);
        putitem_e(tFIS_IMPOSTO, 'VL_BASECALC', rounded(vVlCalc, 6));
        putitem_e(tFIS_IMPOSTO, 'VL_OUTRO', gVlTotalLiquidoICMS - item_f('VL_BASECALC', tFIS_IMPOSTO));
      end else begin
        putitem_e(tFIS_IMPOSTO, 'VL_OUTRO', gVlTotalLiquidoICMS);
        putitem_e(tFIS_IMPOSTO, 'PR_ALIQUOTA', 0);
        putitem_e(tFIS_IMPOSTO, 'PR_BASECALC', 100);
      end;
    end;
  end else if (vCdCST = '60') then begin
    if (vInDecreto = True) then begin
      putitem_e(tFIS_IMPOSTO, 'PR_BASECALC', 100);
      putitem_e(tFIS_IMPOSTO, 'VL_BASECALC', gVlTotalLiquidoICMS);
    end;
  end else begin
    putitem_e(tFIS_IMPOSTO, 'VL_OUTRO', gVlTotalLiquidoICMS);
  end;
  // Move a base de calculo para outros quando for entrada de fornecedor optante pelo simples
  if (gTpOrigemEmissao = 2) and (item_f('TP_MODALIDADE', tGER_OPERACAO) <> 3) then begin
    if (gDsUFOrigem = 'PR') or (gDsUFOrigem = 'MG') or (gDsUFOrigem = 'SP') or (gDsUFOrigem = 'RJ') or (gDsUFOrigem = 'CE') or (gDsUFOrigem = 'RS') then begin
      if (gTpRegimeOrigem = 2) or (gTpRegimeOrigem = 3) then begin //2-Simples 3-EPP
        putitem_e(tFIS_IMPOSTO, 'VL_OUTRO', item_f('VL_OUTRO', tFIS_IMPOSTO) + item_f('VL_BASECALC', tFIS_IMPOSTO));
        putitem_e(tFIS_IMPOSTO, 'VL_BASECALC', 0);
      end;
    end;
  end;

  //Origem estrangeira - importac�o direta
  if (item_f('VL_BASECALC', tFIS_IMPOSTO) > 0) and (vTpProduto = 1)  then begin
    if ((item_a('TP_OPERACAO', tGER_OPERACAO) = 'S') or (item_a('TP_OPERACAO', tGER_OPERACAO) = 'E'))
    and ((item_f('TP_MODALIDADE', tGER_OPERACAO) = 3) or (item_a('TP_MODALIDADE', tGER_OPERACAO) = 'C')) then begin // Sa�da ou entrada por devolu��o ou C - Consignacao
      if (itemB('IN_CNSRFINAL', tPES_CLIENTE) = True) then begin
        putitem_e(tFIS_IMPOSTO, 'VL_BASECALC', item_f('VL_BASECALC', tFIS_IMPOSTO) + gVlIPI);
      end;
    end else begin
      putitem_e(tFIS_IMPOSTO, 'VL_BASECALC', item_f('VL_BASECALC', tFIS_IMPOSTO) + gVlIPI);
    end;
  end;

  if (item_f('VL_BASECALC', tFIS_IMPOSTO) > 0) then begin
    vVlCalc := item_f('VL_BASECALC', tFIS_IMPOSTO) * item_f('PR_ALIQUOTA', tFIS_IMPOSTO) / 100;
    putitem_e(tFIS_IMPOSTO, 'VL_IMPOSTO', rounded(vVlCalc, 6));
  end else begin
    putitem_e(tFIS_IMPOSTO, 'VL_IMPOSTO', 0);
  end;

  if (gCdDecreto = 6142)  then begin
    vVlCalc := item_f('VL_IMPOSTO', tFIS_IMPOSTO) * 66.67 / 100;
    putitem_e(tFIS_IMPOSTO, 'VL_IMPOSTO', rounded(vVlCalc, 6));
  end else begin 
    if (vInPrRedImposto = True) and (item_f('PR_REDUBASE', tFIS_REGRAFISCAL) > 0) then begin
      if (item_a('TP_REDUCAO', tFIS_REGRAFISCAL) = 'B') or (item_a('TP_REDUCAO', tFIS_REGRAFISCAL) = 'E') or (item_a('TP_REDUCAO', tFIS_REGRAFISCAL) = 'H') then begin
        vVlCalc := (item_f('VL_BASECALC', tFIS_IMPOSTO) * ((100 - item_f('PR_REDUBASE', tFIS_REGRAFISCAL))/100) * item_f('PR_ALIQUOTA', tFIS_IMPOSTO)) / 100;
        putitem_e(tFIS_IMPOSTO, 'VL_IMPOSTO', rounded(vVlCalc, 6));
        gCdDecreto := vCdDecreto;
      end;

      if (item_a('TP_REDUCAO', tFIS_REGRAFISCAL) = 'C') or (item_a('TP_REDUCAO', tFIS_REGRAFISCAL) = 'F') or (item_a('TP_REDUCAO', tFIS_REGRAFISCAL) = 'I') then begin
        vVlCalc := (item_f('VL_IMPOSTO', tFIS_IMPOSTO) * (100 - item_f('PR_REDUBASE', tFIS_REGRAFISCAL))) / 100;
        putitem_e(tFIS_IMPOSTO, 'VL_IMPOSTO', rounded(vVlCalc, 6));
        gCdDecreto := vCdDecreto;
      end;
    end;
  end;

  if (gTpModDctoFiscal = 85) or (gTpModDctoFiscal = 87) then begin
    putitem_e(tFIS_IMPOSTO, 'VL_IMPOSTO', item_F('VL_BASECALC', tFIS_IMPOSTO));
    putitem_e(tFIS_IMPOSTO, 'VL_BASECALC', 0);
    putitem_e(tFIS_IMPOSTO, 'PR_REDUBASE', 0);
    putitem_e(tFIS_IMPOSTO, 'PR_BASECALC', 0);
    putitem_e(tFIS_IMPOSTO, 'PR_ALIQUOTA', 0);
    putitem_e(tFIS_IMPOSTO, 'VL_OUTRO', 0);
    putitem_e(tFIS_IMPOSTO, 'VL_ISENTO', 0);
  end;

  if (gVlICMS = 0) then begin
    gVlICMS := item_f('VL_IMPOSTO', tFIS_IMPOSTO);
  end;

  gCdCST := Copy(gCdCST,1,1) + vCdCST;

  //Zerar a al�quota se o CST=90 e o valor do ICMS for zero. then begin
  if (vCdCST = '90') and (gVlICMS = 0) then begin
    putitem_e(tFIS_IMPOSTO, 'PR_ALIQUOTA', 0);
  end;

  //Se a capa tiver Imposto sobre o Frete/Seguro/Desp.Acessoria ser� zerado o valor da Base de Calculo e jogado para o Vl.Outros.
  if (vCdCST = '90')
  and ((gVlFrete > 0) or (gVlSeguro > 0) or (gVlDespAcessor > 0))
  and (gVlICMS > 0) then begin
    putitem_e(tFIS_IMPOSTO, 'VL_OUTRO', item_f('VL_BASECALC', tFIS_IMPOSTO));
    putitem_e(tFIS_IMPOSTO, 'VL_IMPOSTO', 0);
    putitem_e(tFIS_IMPOSTO, 'PR_BASECALC', 0);
    putitem_e(tFIS_IMPOSTO, 'VL_BASECALC', 0);
    putitem_e(tFIS_IMPOSTO, 'PR_ALIQUOTA', 0);
  end;
  return(0);
end;

//----------------------
function T_FISSVCO015.calculaICMSSubst(pParams : String) : String;
//----------------------
const
  cDS_METHOD = 'ADICIONAL=Opera��o: FISSVCO015.calculaICMSSubst()';
var
  vCdCST, viParams, voParams, vTpOperacao : String;
  vPrIVA, vVlCalc, vVlBaseCalc, vVlICMS, vTpProduto, vCdDecreto, vVlAliquotaInter, vVlAliquotaIntra, vCdCFOP : Real;
  vPrIvaPrd, vPrICMS, vVlAliquotaDestino, vVlAliquotaOrigem : Real;
  vInDecreto, vInCalcula : Boolean;
  vDtSistema, vDtIniVigencia, vDtFimVigencia : TDateTime;
begin

  if (gInImpostoOffLine = True) then begin
    discard(tFIS_IMPOSTO);
    return(-1); exit;
  end;

  vDtSistema := itemXmlD('DT_SISTEMA', PARAM_GLB);
  vTpProduto := StrToFloat(Copy(gCdCST,1,1));
  vCdCST := Copy(gCdCST,2,2);
  vTpOperacao := item_a('TP_OPERACAO', tGER_OPERACAO);

  if (vCdCST <> '10') and (vCdCST <> '30') and (vCdCST <> '60') and (vCdCST <> '70') then begin
    if (gCdDecreto = 2155) or (gCdDecreto = 1020) or (gCdDecreto = 45471) or (gCdDecreto = 23731)
    or (gCdDecreto = 23732) or (gCdDecreto = 23733) or (gCdDecreto = 23734) or (gCdDecreto = 23735)
    or (gCdDecreto = 10201) or (gCdDecreto = 10202) or (gCdDecreto = 10203) then begin
      gCdDecreto := 0;
    end;
    discard(tFIS_IMPOSTO);
    return(-1); exit;
  end;
  gCdDecreto := 0;
  vCdDecreto := 0;
  vInDecreto := False;

  if (gCdDecretoItemCapa <> 0) then begin
    clear_e(tFIS_DECRETO);
    putitem_o(tFIS_DECRETO, 'CD_DECRETO', gCdDecretoItemCapa);
    retrieve_e(tFIS_DECRETO);
    if (item_f('CD_DECRETO', tFIS_DECRETO) > 0) then begin
      vCdDecreto := item_f('CD_DECRETO', tFIS_DECRETO);
      vDtIniVigencia := item_d('DT_INIVIGENCIA', tFIS_DECRETO);
      vDtFimVigencia := item_d('DT_FIMVIGENCIA', tFIS_DECRETO);
    end;
  end else begin
    if (item_f('CD_DECRETO', tFIS_DECRETO) > 0) then begin
      vCdDecreto := item_f('CD_DECRETO', tFIS_DECRETO);
      vDtIniVigencia := item_d('DT_INIVIGENCIA', tFIS_DECRETO);
      vDtFimVigencia := item_d('DT_FIMVIGENCIA', tFIS_DECRETO);
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

  //A al�quota diferencia so pode se aplicada em NF estadual
  //Nas outra � obrigatorio respeitar a aliquota interestadual
  if (item_f('PR_ALIQICMS', tFIS_REGRAFISCAL) > 0) and (gDsUFOrigem = gDsUFDestino) then begin
    putitem_e(tFIS_IMPOSTO, 'PR_ALIQUOTA', item_f('PR_ALIQICMS', tFIS_REGRAFISCAL));
  end else if (vCdDecreto > 0) then begin
    clear_e(tFIS_ALIQUOTAICMSUF);
    putitem_o(tFIS_ALIQUOTAICMSUF, 'CD_UFORIGEM', gDsUFDestino);
    putitem_o(tFIS_ALIQUOTAICMSUF, 'CD_UFDESTINO', gDsUFDestino);
    retrieve_e(tFIS_ALIQUOTAICMSUF);
    if (xStatus < 0) then begin
      Result := SetStatus(STS_ERROR, 'GEN001', 'Nenhuma al�quota cadastrada de ' + gDsUFDestino + ' para ' + gDsUFDestino + '!', cDS_METHOD);
      return(-1); exit;
    end;
    putitem_e(tFIS_IMPOSTO, 'PR_ALIQUOTA', item_f('PR_ALIQICMS', tFIS_ALIQUOTAICMSUF));
  end;

  vPrIVA := 30;

  //Emiss�o de terceiro e diferente de devolucao ou devolu��o de compra com emiss�o pr�pria
  if ((gTpOrigemEmissao = 2) and (item_f('TP_MODALIDADE', tGER_OPERACAO) <> 3))
  or ((gTpOrigemEmissao = 1) and (item_f('TP_MODALIDADE', tGER_OPERACAO) = 3) and (item_a('TP_OPERACAO', tGER_OPERACAO) = 'S')) then begin
    if (gDsUFOrigem = 'PR') or (gDsUFOrigem = 'SC') or (gDsUFOrigem = 'MG') or (gDsUFOrigem = 'SP') or (gDsUFOrigem = 'RJ') or (gDsUFOrigem = 'CE') then begin
      if (gTpRegimeOrigem = 2) or (gTpRegimeOrigem = 3) then begin //2-Simples 3-EPP
        putitem_e(tFIS_IMPOSTO, 'PR_ALIQUOTA', 0);
      end;
    end;
    if (gTpOrigemEmissao = 1) then begin
    end;
  end else begin
  end;

  if (vCdDecreto = 2155) then begin // Decreto do Estado do Parana
    if (gDsUFOrigem = 'PR') or (gDsUFOrigem = 'RS') or (gDsUFOrigem = 'SC') then begin
      if (gInContribuinte = True) and (item_f('TP_MODALIDADE', tGER_OPERACAO) = 4) then begin // 4 - Venda/Compra
        if (gDsUFDestino = 'PR') or (gDsUFDestino = 'RS') or (gDsUFDestino = 'SC') then begin
          vPrIVA := 65.86;
          vInDecreto := True;
        end;
      end;
    end;

    if (vInDecreto = True) then begin
      if (item_f('PR_ALIQICMS', tFIS_REGRAFISCAL) > 0) and (gDsUFOrigem = 'PR') and (gDsUFDestino = 'PR') then begin
        putitem_e(tFIS_IMPOSTO, 'PR_ALIQUOTA', item_f('PR_ALIQICMS', tFIS_REGRAFISCAL));
      end else begin
        clear_e(tFIS_ALIQUOTAICMSUF);
        putitem_o(tFIS_ALIQUOTAICMSUF, 'CD_UFORIGEM', gDsUFDestino);
        putitem_o(tFIS_ALIQUOTAICMSUF, 'CD_UFDESTINO', gDsUFDestino);
        retrieve_e(tFIS_ALIQUOTAICMSUF);
        if (xStatus < 0) then begin
          Result := SetStatus(STS_ERROR, 'GEN001', 'Nenhuma al�quota cadastrada de ' + gDsUFDestino + ' para ' + gDsUFDestino + '!', cDS_METHOD);
          return(-1); exit;
        end;
        putitem_e(tFIS_IMPOSTO, 'PR_ALIQUOTA', item_f('PR_ALIQICMS', tFIS_ALIQUOTAICMSUF));
      end;

      vVlCalc := gVlTotalLiquidoICMS + gVlIPI + ((gVlTotalLiquidoICMS + gVlIPI) * vPrIVA) / 100 ;
      putitem_e(tFIS_IMPOSTO, 'VL_BASECALC', rounded(vVlCalc, 6));
      putitem_e(tFIS_IMPOSTO, 'PR_BASECALC', 100);

      vVlCalc := item_f('VL_BASECALC', tFIS_IMPOSTO) * (item_f('PR_ALIQUOTA', tFIS_IMPOSTO) / 100);
      vVlICMS := rounded(vVlCalc, 6) ;
      putitem_e(tFIS_IMPOSTO, 'VL_IMPOSTO', vVlICMS - gVlICMS);
      gCdDecreto := vCdDecreto;
    end;
  end else if (vCdDecreto = 1020) or (vCdDecreto = 10201) or (vCdDecreto = 10202) or (vCdDecreto = 10203) then begin // Decreto do Estado de Santa Catarina
    if (gDsUFOrigem = 'PR') or (gDsUFOrigem = 'SC') or (gDsUFOrigem = 'MG') then begin //Inclu�do o Estado de MG
      if (gInContribuinte = True) and (item_f('TP_MODALIDADE', tGER_OPERACAO) = 4) then begin // 4 - Venda/Compra
        if (gDsUFDestino = 'PR') or (gDsUFDestino = 'SC') or (gDsUFDestino = 'MG') then begin //Inclu�do o Estado de MG
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
      clear_e(tFIS_ALIQUOTAICMSUF);
      putitem_o(tFIS_ALIQUOTAICMSUF, 'CD_UFORIGEM', gDsUFOrigem);
      putitem_o(tFIS_ALIQUOTAICMSUF, 'CD_UFDESTINO', gDsUFDestino);
      retrieve_e(tFIS_ALIQUOTAICMSUF);
      if (xStatus < 0) then begin
        Result := SetStatus(STS_ERROR, 'GEN001', 'Nenhuma al�quota cadastrada de ' + gDsUFOrigem + ' para ' + gDsUFDestino + '!', cDS_METHOD);
        return(-1); exit;
      end;
      vVlAliquotaInter := item_f('PR_ALIQICMS', tFIS_ALIQUOTAICMSUF);

      viParams := '';
      putitemXml(viParams, 'CD_PRODUTO' , item_a('CD_PRODUTO', tPRD_PRODUTO));
      putitemXml(viParams, 'UF_ORIGEM'  , gDsUFOrigem);
      putitemXml(viParams, 'UF_DESTINO' , gDsUFDestino);
      putitemXml(viParams, 'TP_OPERACAO', vTpOperacao);
      voParams := activateCmp('FISSVCO035', 'buscaDadosFiscalProduto', viParams);
      if (xStatus < 0) then begin
        Result := voParams;
        return(-1); exit;
      end;
      vVlAliquotaIntra := itemXmlF('PR_ICMS', voParams);

      if (vVlAliquotaIntra = 0) then begin
        clear_e(tFIS_ALIQUOTAICMSUF);
        putitem_o(tFIS_ALIQUOTAICMSUF, 'CD_UFORIGEM', gDsUFDestino);
        putitem_o(tFIS_ALIQUOTAICMSUF, 'CD_UFDESTINO', gDsUFDestino);
        retrieve_e(tFIS_ALIQUOTAICMSUF);
        if (xStatus < 0) then begin
          Result := SetStatus(STS_ERROR, 'GEN001', 'Nenhuma al�quota cadastrada de ' + gDsUFDestino + ' para ' + gDsUFDestino + '!', cDS_METHOD);
          return(-1); exit;
        end;
        vVlAliquotaIntra := item_f('PR_ALIQICMS', tFIS_ALIQUOTAICMSUF);
      end;
      if (gDsUFDestino <> gDsUFOrigem) then begin
        vPrIVA := ((1 + (vPrIVA/100)) * ((1 - (vVlAliquotaInter/100)) / (1 - (vVlAliquotaIntra/100))) -1) * 100;
      end;
      if (item_f('PR_ALIQICMS', tFIS_REGRAFISCAL) > 0) then begin
        putitem_e(tFIS_IMPOSTO, 'PR_ALIQUOTA', item_f('PR_ALIQICMS', tFIS_REGRAFISCAL));
      end else begin
        putitem_e(tFIS_IMPOSTO, 'PR_ALIQUOTA', item_f('PR_ALIQICMS', tFIS_ALIQUOTAICMSUF));
      end;
      vVlCalc := gVlTotalLiquidoICMS + gVlIPI + ((gVlTotalLiquidoICMS + gVlIPI) * vPrIVA) / 100;
      putitem_e(tFIS_IMPOSTO, 'VL_BASECALC', rounded(vVlCalc, 6));
      putitem_e(tFIS_IMPOSTO, 'PR_BASECALC', 100);
      vVlCalc := item_f('VL_BASECALC', tFIS_IMPOSTO) * (item_f('PR_ALIQUOTA', tFIS_IMPOSTO) / 100);
      vVlICMS := rounded(vVlCalc, 6) ;
      putitem_e(tFIS_IMPOSTO, 'VL_IMPOSTO', vVlICMS - gVlICMS);
      gCdDecreto := vCdDecreto;
    end;
  end else if (vCdDecreto = 45471) then begin // Decreto do Estado do Rio Grande do Sul
    if (gDsUFOrigem = 'RS') or (gDsUFOrigem = 'PR') or (gDsUFOrigem = 'SC') then begin
      if (gInContribuinte = True) and (item_f('TP_MODALIDADE', tGER_OPERACAO) = 4)then begin // 4 - Venda/Compra
        if (gDsUFDestino = 'PR') or (gDsUFDestino = 'RS')  or (gDsUFDestino = 'SC') then begin
          vPrIVA := 65.86;
          vInDecreto := True;
        end;
      end;
    end;

    if (vInDecreto = True) then begin
      clear_e(tFIS_ALIQUOTAICMSUF);
      putitem_o(tFIS_ALIQUOTAICMSUF, 'CD_UFORIGEM', gDsUFDestino);
      putitem_o(tFIS_ALIQUOTAICMSUF, 'CD_UFDESTINO', gDsUFDestino);
      retrieve_e(tFIS_ALIQUOTAICMSUF);
      if (xStatus < 0) then begin
        Result := SetStatus(STS_ERROR, 'GEN001', 'Nenhuma al�quota cadastrada de ' + gDsUFOrigem + ' para ' + gDsUFDestino + '!', cDS_METHOD);
        return(-1); exit;
      end;
      vVlCalc := gVlTotalLiquidoICMS + gVlIPI + ((gVlTotalLiquidoICMS + gVlIPI) * vPrIVA) / 100 ;
      putitem_e(tFIS_IMPOSTO, 'VL_BASECALC', rounded(vVlCalc, 6));
      putitem_e(tFIS_IMPOSTO, 'PR_BASECALC', 100);
      vVlCalc := item_f('VL_BASECALC', tFIS_IMPOSTO) * (item_f('PR_ALIQICMS', tFIS_ALIQUOTAICMSUF) / 100);
      vVlICMS := rounded(vVlCalc, 6) ;
      putitem_e(tFIS_IMPOSTO, 'PR_ALIQUOTA', item_f('PR_ALIQICMS', tFIS_ALIQUOTAICMSUF));
      putitem_e(tFIS_IMPOSTO, 'VL_IMPOSTO', vVlICMS - gVlICMS);
      gCdDecreto := vCdDecreto;
    end;
  end else if (vCdDecreto = 52364)then begin // Decreto do Estado de S�o Paulo
    if (gDsUFOrigem = 'SP') or (gDsUFDestino = 'SP') then begin
      if ((item_a('TP_OPERACAO', tGER_OPERACAO) = 'E') and (item_f('TP_MODALIDADE', tGER_OPERACAO) = 4))
      or ((item_a('TP_OPERACAO', tGER_OPERACAO) = 'S') and (item_f('TP_MODALIDADE', tGER_OPERACAO) = 3)) then begin // 4 - Compra / 3 - Devolu��o
        // Aliquota aplicada pelo Fornecedor
        clear_e(tFIS_ALIQUOTAICMSUF);
        putitem_o(tFIS_ALIQUOTAICMSUF, 'CD_UFORIGEM', gDsUFOrigem);
        putitem_o(tFIS_ALIQUOTAICMSUF, 'CD_UFDESTINO', gDsUFDestino);
        retrieve_e(tFIS_ALIQUOTAICMSUF);
        if (xStatus < 0) then begin
          Result := SetStatus(STS_ERROR, 'GEN001', 'Nenhuma al�quota cadastrada de ' + gDsUFOrigem + ' para ' + gDsUFDestino + '!', cDS_METHOD);
          return(-1); exit;
        end;

        // Aliquota interna de SP
        if (item_f('PR_ALIQICMS', tFIS_REGRAFISCAL) > 0) then begin
          vVlAliquotaIntra := item_f('PR_ALIQICMS', tFIS_REGRAFISCAL) ;
        end else begin 
          vVlAliquotaIntra := item_f('PR_ALIQICMS', tFIS_ALIQUOTAICMSUF);
        end;
        vVlAliquotaInter := item_f('PR_ALIQICMS', tFIS_ALIQUOTAICMSUF); // Aliquota aplicada pelo Fornecedor

        if (item_f('PR_ALIQUOTA', tFIS_IMPOSTO) = 12) or (item_f('PR_ALIQUOTA', tFIS_IMPOSTO) = 18) then begin
          if (gDsUFOrigem = 'SP') and (gDsUFDestino = 'SP') then begin
            vPrIVA := 38.90 ;
          end else begin 
            vPrIVA := ((1 + (38.90/100)) * ((1 - (vVlAliquotaInter/100)) / (1 - (vVlAliquotaIntra/100))) -1) * 100;
          end;
          vInDecreto := True;
        end else if (item_f('PR_ALIQUOTA', tFIS_IMPOSTO) = 25) then begin
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
      putitem_e(tFIS_IMPOSTO, 'VL_BASECALC', rounded(vVlCalc, 6));
      putitem_e(tFIS_IMPOSTO, 'PR_BASECALC', 100);
      vVlCalc := item_f('VL_BASECALC', tFIS_IMPOSTO) * (vVlAliquotaIntra / 100);
      vVlICMS := rounded(vVlCalc, 6) ;
      putitem_e(tFIS_IMPOSTO, 'PR_ALIQUOTA', vVlAliquotaIntra);
      putitem_e(tFIS_IMPOSTO, 'VL_IMPOSTO', (gVlTotalLiquidoICMS + gVlIPI) * (1 + (vPrIVA / 100)) * (vVlAliquotaIntra/100) - gVlICMS);
      gCdDecreto := vCdDecreto;
    end;
  end else if (vCdDecreto = 23731) or (vCdDecreto = 23732) or (vCdDecreto = 23733) or (vCdDecreto = 23734) or (vCdDecreto = 23735)then begin // Decreto do Estado do Paran�
    if (gDsUFOrigem = 'PR') or (gDsUFDestino = 'PR') then begin
      if (gInContribuinte = True) and (item_f('TP_MODALIDADE', tGER_OPERACAO) = 4) then begin // 4 - Venda/Compra
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
      if (item_f('PR_ALIQICMS', tFIS_REGRAFISCAL) > 0) and (gDsUFOrigem = 'PR') and (gDsUFDestino = 'PR') then begin
        putitem_e(tFIS_IMPOSTO, 'PR_ALIQUOTA', item_f('PR_ALIQICMS', tFIS_REGRAFISCAL));
      end else begin
        clear_e(tFIS_ALIQUOTAICMSUF);
        putitem_o(tFIS_ALIQUOTAICMSUF, 'CD_UFORIGEM', gDsUFDestino);
        putitem_o(tFIS_ALIQUOTAICMSUF, 'CD_UFDESTINO', gDsUFDestino);
        retrieve_e(tFIS_ALIQUOTAICMSUF);
        if (xStatus < 0) then begin
          Result := SetStatus(STS_ERROR, 'GEN001', 'Nenhuma al�quota cadastrada de ' + gDsUFOrigem + ' para ' + gDsUFDestino + '!', cDS_METHOD);
          return(-1); exit;
        end;
        putitem_e(tFIS_IMPOSTO, 'PR_ALIQUOTA', item_f('PR_ALIQICMS', tFIS_ALIQUOTAICMSUF));
      end;

      if (item_f('PR_REDUBASE', tFIS_REGRAFISCAL) <> 0) then begin
        vVlCalc := (gVlTotalLiquido + gVlIPI) - ((gVlTotalLiquido + gVlIPI) * item_f('PR_REDUBASE', tFIS_REGRAFISCAL)) / 100;
      end else begin
        vVlCalc := gVlTotalLiquido + gVlIPI;
      end;
      vVlBaseCalc := vVlCalc + (vVlCalc * vPrIVA) / 100 ;
      putitem_e(tFIS_IMPOSTO, 'VL_BASECALC', rounded(vVlBaseCalc, 6));
      putitem_e(tFIS_IMPOSTO, 'PR_BASECALC', 100);
      vVlCalc := item_f('VL_BASECALC', tFIS_IMPOSTO) * (item_f('PR_ALIQUOTA', tFIS_IMPOSTO) / 100);
      vVlICMS := rounded(vVlCalc, 6) ;
      putitem_e(tFIS_IMPOSTO, 'VL_IMPOSTO', vVlICMS - gVlICMS);
      gCdDecreto := vCdDecreto;
    end;
  end else if (vCdDecreto = 2559)then begin // Decreto do Paran�
    if (gDsUFOrigem = 'PR') or (gDsUFDestino = 'PR') then begin
      if (item_f('TP_MODALIDADE', tGER_OPERACAO) = 4)then begin // Venda/Compra
        if (item_a('TP_OPERACAO', tGER_OPERACAO) = 'E') then begin
          // Aliquota interna de PR
          clear_e(tFIS_ALIQUOTAICMSUF);
          putitem_o(tFIS_ALIQUOTAICMSUF, 'CD_UFORIGEM', gDsUFDestino);
          putitem_o(tFIS_ALIQUOTAICMSUF, 'CD_UFDESTINO', gDsUFDestino);
          retrieve_e(tFIS_ALIQUOTAICMSUF);
          if (xStatus < 0) then begin
            Result := SetStatus(STS_ERROR, 'GEN001', 'Nenhuma al�quota cadastrada de ' + gDsUFOrigem + ' para ' + gDsUFDestino + '!', cDS_METHOD);
            return(-1); exit;
          end;
        end else begin
          // Aliquota interna de PR
          clear_e(tFIS_ALIQUOTAICMSUF);
          putitem_o(tFIS_ALIQUOTAICMSUF, 'CD_UFORIGEM', gDsUFOrigem);
          putitem_o(tFIS_ALIQUOTAICMSUF, 'CD_UFDESTINO', gDsUFOrigem);
          retrieve_e(tFIS_ALIQUOTAICMSUF);
          if (xStatus < 0) then begin
            Result := SetStatus(STS_ERROR, 'GEN001', 'Nenhuma al�quota cadastrada de ' + gDsUFOrigem + ' para ' + gDsUFDestino + '!', cDS_METHOD);
            return(-1); exit;
          end;
        end;

        // Aliquota interna de PR
        if (item_f('PR_ALIQICMS', tFIS_REGRAFISCAL) > 0) then begin
          vVlAliquotaIntra := item_f('PR_ALIQICMS', tFIS_REGRAFISCAL);
        end else begin
          vVlAliquotaIntra := item_f('PR_ALIQICMS', tFIS_ALIQUOTAICMSUF);
        end;
        vVlAliquotaInter := item_f('PR_ALIQUOTA', tFIS_IMPOSTO); // Aliquota aplicada pelo Fornecedor
        if (gInProdPropria = True) then begin
          vCdCFOP := item_f('CD_CFOPPROPRIA', tFIS_REGRAFISCAL);
        end else begin
          vCdCFOP := item_f('CD_CFOPTERCEIRO', tFIS_REGRAFISCAL);
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
      putitem_e(tFIS_IMPOSTO, 'VL_BASECALC', rounded(vVlCalc, 6));
      putitem_e(tFIS_IMPOSTO, 'PR_BASECALC', 100);
      vVlCalc := item_f('VL_BASECALC', tFIS_IMPOSTO) * (vVlAliquotaInter / 100);
      vVlICMS := rounded(vVlCalc, 6) ;
      putitem_e(tFIS_IMPOSTO, 'PR_ALIQUOTA', vVlAliquotaInter);
      putitem_e(tFIS_IMPOSTO, 'VL_IMPOSTO', (gVlTotalLiquidoICMS + gVlIPI) * (1 + (vPrIVA / 100)) * (vVlAliquotaInter/100) - gVlICMS);
      gCdDecreto := vCdDecreto;
    end;
  end else if (vCdDecreto = 52804)then begin // Decreto do Estado de S�o Paulo
    if (gDsUFOrigem = 'SP') or (gDsUFDestino = 'SP') then begin
      if (item_f('TP_MODALIDADE', tGER_OPERACAO) = 4)then begin // Compra/Venda
        if (item_a('TP_OPERACAO', tGER_OPERACAO) = 'E') then begin
          // Aliquota interna de SP
          clear_e(tFIS_ALIQUOTAICMSUF);
          putitem_o(tFIS_ALIQUOTAICMSUF, 'CD_UFORIGEM', gDsUFDestino);
          putitem_o(tFIS_ALIQUOTAICMSUF, 'CD_UFDESTINO', gDsUFDestino);
          retrieve_e(tFIS_ALIQUOTAICMSUF);
          if (xStatus < 0) then begin
            Result := SetStatus(STS_ERROR, 'GEN001', 'Nenhuma al�quota cadastrada de ' + gDsUFOrigem + ' para ' + gDsUFDestino + '!', cDS_METHOD);
            return(-1); exit;
          end;
        end else begin
          // Aliquota interna de SP
          clear_e(tFIS_ALIQUOTAICMSUF);
          putitem_o(tFIS_ALIQUOTAICMSUF, 'CD_UFORIGEM', gDsUFOrigem);
          putitem_o(tFIS_ALIQUOTAICMSUF, 'CD_UFDESTINO', gDsUFOrigem);
          retrieve_e(tFIS_ALIQUOTAICMSUF);
          if (xStatus < 0) then begin
            Result := SetStatus(STS_ERROR, 'GEN001', 'Nenhuma al�quota cadastrada de ' + gDsUFOrigem + ' para ' + gDsUFDestino + '!', cDS_METHOD);
            return(-1); exit;
          end;
        end;

        // Aliquota interna de SP
        if (item_f('PR_ALIQICMS', tFIS_REGRAFISCAL) > 0) then begin
          vVlAliquotaIntra := item_f('PR_ALIQICMS', tFIS_REGRAFISCAL) ;
        end else begin 
          vVlAliquotaIntra := item_f('PR_ALIQICMS', tFIS_ALIQUOTAICMSUF);
        end;
        vVlAliquotaInter := item_f('PR_ALIQUOTA', tFIS_IMPOSTO) ; // Aliquota aplicada pelo Fornecedor
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
      putitem_e(tFIS_IMPOSTO, 'VL_BASECALC', rounded(vVlCalc, 6));
      putitem_e(tFIS_IMPOSTO, 'PR_BASECALC', 100);
      vVlCalc := item_f('VL_BASECALC', tFIS_IMPOSTO) * (vVlAliquotaIntra / 100);
      vVlICMS := rounded(vVlCalc, 6) ;
      putitem_e(tFIS_IMPOSTO, 'PR_ALIQUOTA', vVlAliquotaInter);
      putitem_e(tFIS_IMPOSTO, 'VL_IMPOSTO', (gVlTotalLiquidoICMS + gVlIPI) * (1 + (vPrIVA / 100)) * (vVlAliquotaInter/100) - gVlICMS);
      gCdDecreto := vCdDecreto;
    end;
  // Decreto do Espirito Santo
  end else if (vCdDecreto = 10901) or (vCdDecreto = 10902) or (vCdDecreto = 10903) or (vCdDecreto = 10904) then begin // Decreto do Espirito Santo
    if (gDsUFOrigem = 'ES') or (gDsUFDestino = 'ES') then begin
      if (gInContribuinte = True)
      and ((item_f('TP_MODALIDADE', tGER_OPERACAO) = 4) or (item_f('TP_MODALIDADE', tGER_OPERACAO) = 3)) then begin // 4 - Venda/Compra / 3 - Devolucao
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
      clear_e(tFIS_ALIQUOTAICMSUF);
      putitem_o(tFIS_ALIQUOTAICMSUF, 'CD_UFORIGEM', gDsUFDestino);
      putitem_o(tFIS_ALIQUOTAICMSUF, 'CD_UFDESTINO', gDsUFDestino);
      retrieve_e(tFIS_ALIQUOTAICMSUF);
      if (xStatus < 0) then begin
        Result := SetStatus(STS_ERROR, 'GEN001', 'Nenhuma al�quota cadastrada de ' + gDsUFOrigem + ' para ' + gDsUFDestino + '!', cDS_METHOD);
        return(-1); exit;
      end;
      // Aliquota interna do destino
      if (item_f('PR_ALIQICMS', tFIS_REGRAFISCAL) > 0) then begin
        vVlAliquotaIntra := item_f('PR_ALIQICMS', tFIS_REGRAFISCAL) ;
      end else begin
        vVlAliquotaIntra := item_f('PR_ALIQICMS', tFIS_ALIQUOTAICMSUF);
      end;
      vVlCalc := gVlTotalLiquidoICMS + gVlIPI + ((gVlTotalLiquidoICMS + gVlIPI) * vPrIVA) / 100 ;
      putitem_e(tFIS_IMPOSTO, 'VL_BASECALC', rounded(vVlCalc, 6));
      putitem_e(tFIS_IMPOSTO, 'PR_BASECALC', 100);
      vVlCalc := item_f('VL_BASECALC', tFIS_IMPOSTO) * (vVlAliquotaIntra / 100);
      vVlICMS := rounded(vVlCalc, 6) ;
      putitem_e(tFIS_IMPOSTO, 'PR_ALIQUOTA', vVlAliquotaIntra);
      putitem_e(tFIS_IMPOSTO, 'VL_IMPOSTO', (gVlTotalLiquidoICMS + gVlIPI) * (1 + (vPrIVA / 100)) * (vVlAliquotaIntra/100) - gVlICMS);
      gCdDecreto := vCdDecreto;
      if (gDsUFOrigem = 'ES') and (gDsUFDestino = 'ES') then begin
        vCdCST := '10';
      end else begin
        vCdCST := '70';
      end;
    end;
  end else begin
    vTpOperacao := item_a('TP_OPERACAO', tGER_OPERACAO);

    viParams := '';
    putitemXml(viParams, 'CD_PRODUTO', item_a('CD_PRODUTO', tPRD_PRODUTO));
    putitemXml(viParams, 'UF_ORIGEM', gDsUFOrigem);
    putitemXml(viParams, 'UF_DESTINO', gDsUFDestino);
    putitemXml(viParams, 'TP_OPERACAO', vTpOperacao);
    voParams := activateCmp('FISSVCO035', 'buscaDadosFiscalProduto', viParams);
    if (xStatus < 0) then begin
      Result := voParams;
      return(-1); exit;
    end;  
    vPrIvaPrd := itemXmlF('PR_SUBSTRIB', voParams);
    vPrICMS := itemXmlF('PR_ICMS', voParams);

    if (vPrIvaPrd > 0) then begin
      vPrIVA := vPrIvaPrd;
    end;

    if (vPrICMS > 0)  then begin
      putitem_e(tFIS_IMPOSTO, 'PR_ALIQUOTA', vPrICMS);
    end;
    if (item_f('PR_ALIQUOTA', tFIS_IMPOSTO) = 0) then begin
      Result := SetStatus(STS_ERROR, 'GEN001', 'Nenhuma al�quota cadastrada na Tabela de Sub.Trib.do NCM de ' + gDsUFOrigem + ' para ' + gDsUFDestino + '!', cDS_METHOD);
      return(-1); exit;
    end;
    vInCalcula := False;
    if (gDsUFOrigem <> gDsUFDestino) and (item_f('TP_MODALIDADE', tGER_OPERACAO) = 4)then begin // Venda/Compra
      if (item_a('TP_OPERACAO', tGER_OPERACAO) = 'S') then begin
        if (gInContribuinte = True) and (itemB('IN_CNSRFINAL', tPES_CLIENTE) = True) then begin
          vInCalcula := True;
        end;
      end else begin
        if (gInProdPropria = True) then begin
          vCdCFOP := item_f('CD_CFOPPROPRIA', tFIS_REGRAFISCAL);
        end else begin
          vCdCFOP := item_f('CD_CFOPTERCEIRO', tFIS_REGRAFISCAL);
        end;
        vCdCFOP := StrToFloat(Copy(FloatToStr(vCdCFOP),2,4));

        if (vCdCFOP = 407) then begin
          vInCalcula := True;
        end;
      end;

      if (vInCalcula = True) then begin
        // Aliquota interna destino
        clear_e(tFIS_ALIQUOTAICMSUF);
        putitem_o(tFIS_ALIQUOTAICMSUF, 'CD_UFORIGEM', gDsUFDestino);
        putitem_o(tFIS_ALIQUOTAICMSUF, 'CD_UFDESTINO', gDsUFDestino);
        retrieve_e(tFIS_ALIQUOTAICMSUF);
        if (xStatus < 0) then begin
          Result := SetStatus(STS_ERROR, 'GEN001', 'Nenhuma al�quota cadastrada de ' + gDsUFOrigem + ' para ' + gDsUFDestino + '!', cDS_METHOD);
          return(-1); exit;
        end;
        vVlAliquotaDestino := item_f('PR_ALIQICMS', tFIS_ALIQUOTAICMSUF);

        // Aliquota interna origem
        clear_e(tFIS_ALIQUOTAICMSUF);
        putitem_o(tFIS_ALIQUOTAICMSUF, 'CD_UFORIGEM', gDsUFOrigem);
        putitem_o(tFIS_ALIQUOTAICMSUF, 'CD_UFDESTINO', gDsUFOrigem);
        retrieve_e(tFIS_ALIQUOTAICMSUF);
        if (xStatus < 0) then begin
          Result := SetStatus(STS_ERROR, 'GEN001', 'Nenhuma al�quota cadastrada de ' + gDsUFOrigem + ' para ' + gDsUFDestino + '!', cDS_METHOD);
          return(-1); exit;
        end;
        vVlAliquotaOrigem := item_f('PR_ALIQICMS', tFIS_ALIQUOTAICMSUF);

        //Se tiver aliquota na regra fiscal ser� passado para AliquotaOrigem
        if (item_f('PR_ALIQICMS', tFIS_REGRAFISCAL) > 0) then begin
          vVlAliquotaOrigem := item_f('PR_ALIQICMS', tFIS_REGRAFISCAL) ;
        end;

        vPrIVA := 0;
        putitem_e(tFIS_IMPOSTO, 'PR_ALIQUOTA', abs(vVlAliquotaOrigem - vVlAliquotaDestino));

      end else begin

        clear_e(tFIS_ALIQUOTAICMSUF);
        putitem_o(tFIS_ALIQUOTAICMSUF, 'CD_UFORIGEM', gDsUFOrigem);
        putitem_o(tFIS_ALIQUOTAICMSUF, 'CD_UFDESTINO', gDsUFDestino);
        retrieve_e(tFIS_ALIQUOTAICMSUF);
        if (xStatus < 0) then begin
          Result := SetStatus(STS_ERROR, 'GEN001', 'Nenhuma al�quota cadastrada de ' + gDsUFOrigem + ' para ' + gDsUFDestino + '!', cDS_METHOD);
          return(-1); exit;
        end;
        vVlAliquotaInter := item_f('PR_ALIQICMS', tFIS_ALIQUOTAICMSUF);

        viParams := '';
        putitemXml(viParams, 'CD_PRODUTO' , item_a('CD_PRODUTO', tPRD_PRODUTO));
        putitemXml(viParams, 'UF_ORIGEM'  , gDsUFOrigem);
        putitemXml(viParams, 'UF_DESTINO' , gDsUFDestino);
        putitemXml(viParams, 'TP_OPERACAO', vTpOperacao);
        voParams := activateCmp('FISSVCO035', 'buscaDadosFiscalProduto', viParams);
        if (xStatus < 0) then begin
          Result := voParams;
          exit
        end;
        vVlAliquotaIntra := itemXmlF('PR_ICMS', voParams);

        if (vVlAliquotaIntra = 0) then begin
          clear_e(tFIS_ALIQUOTAICMSUF);
          putitem_o(tFIS_ALIQUOTAICMSUF, 'CD_UFORIGEM', gDsUFDestino);
          putitem_o(tFIS_ALIQUOTAICMSUF, 'CD_UFDESTINO', gDsUFDestino);
          retrieve_e(tFIS_ALIQUOTAICMSUF);
          if (xStatus < 0) then begin
            Result := SetStatus(STS_ERROR, 'GEN001', 'Nenhuma al�quota cadastrada de ' + gDsUFOrigem + ' para ' + gDsUFDestino + '!', cDS_METHOD);
            return(-1); exit;
          end;
          vVlAliquotaIntra := item_f('PR_ALIQICMS', tFIS_ALIQUOTAICMSUF);
        end;

        if (gDsUFDestino <> gDsUFOrigem) then begin
           vPrIVA := ((1 + (vPrIVA/100)) * ((1 - (vVlAliquotaInter/100)) / (1 - (vVlAliquotaIntra/100))) -1) * 100;
        end;
      end;
    end;
    if (gPrAplicMvaSubTrib <> 0) then begin
      if ( (vTpOperacao = 'S') and ((gDsUFDestino = 'SC') and (gInContribuinte = True) and ((gTpRegimeOrigem = 2) or (gTpRegimeOrigem = 3))) )
      or ( (vTpOperacao = 'E') and ((item_f('TP_MODALIDADE', tGER_OPERACAO) = 3) and ((gTpRegimeOrigem = 2) or (gTpRegimeOrigem = 3))) ) // 2-Micro Empresa / 3-EPP
      or ( (vTpOperacao = 'E') and (gInOptSimples = True) ) then begin
        if (vPrIVA = 0) then begin
          vPrIva := vPrIvaPrd;
        end;
        vPrIVA := (vPrIVA * gPrAplicMvaSubTrib)/100;
      end;
    end;
    if (vCdCST = '10') then begin
      vVlCalc := (gVlTotalLiquidoICMS + gVlIPI) + ((gVlTotalLiquidoICMS + gVlIPI) * vPrIVA) / 100;
      putitem_e(tFIS_IMPOSTO, 'VL_BASECALC', rounded(vVlCalc, 6));
      putitem_e(tFIS_IMPOSTO, 'PR_BASECALC', 100);
    end else if (vCdCST = '70') then begin //Implementado por Deusdete em car�ter de urg�ncia em 28/04/2009, l�gica revisada c/ Eli�
      vVlCalc := gVlTotalLiquidoICMS + gVlIPI;
      if (gNaturezaComercialEmp <> 3) and (gNaturezaComercialEmp <> 2) then begin //Varejo e Atacado (p/ atender o Loj�o e Brascol)
        if (item_f('PR_REDUBASE', tFIS_REGRAFISCAL) <> 0) then begin
          if (vTpOperacao = 'S') then begin
            vVlCalc := vVlCalc - ((gVlTotalLiquidoICMS + gVlIPI) * item_f('PR_REDUBASE', tFIS_REGRAFISCAL)) / 100;
            putitem_e(tFIS_IMPOSTO, 'PR_BASECALC', 100 - item_f('PR_REDUBASE', tFIS_REGRAFISCAL));
            putitem_e(tFIS_IMPOSTO, 'PR_REDUBASE', item_f('PR_REDUBASE', tFIS_REGRAFISCAL));
          end else if (vTpOperacao = 'E') then begin
            if (gTpRegimeOrigem = 2) or (gTpRegimeOrigem = 3) then begin
              vVlCalc := vVlCalc - ((gVlTotalLiquidoICMS + gVlIPI) * item_f('PR_REDUBASE', tFIS_REGRAFISCAL)) / 100;
              putitem_e(tFIS_IMPOSTO, 'PR_BASECALC', 100 - item_f('PR_REDUBASE', tFIS_REGRAFISCAL));
              putitem_e(tFIS_IMPOSTO, 'PR_REDUBASE', item_f('PR_REDUBASE', tFIS_REGRAFISCAL));
            end;
          end;
        end;
      end;
      vVlBaseCalc := vVlCalc + ((vVlCalc * vPrIVA) / 100);
      putitem_e(tFIS_IMPOSTO, 'VL_BASECALC', rounded(vVlBaseCalc, 6));
      if (item_f('PR_REDUBASE', tFIS_IMPOSTO) = 0) then begin
        putitem_e(tFIS_IMPOSTO, 'PR_BASECALC', 100);
      end;
    end else if (vCdCST = '30') then begin
      vVlCalc := gVlTotalLiquidoICMS + gVlIPI;
      if (gInOptSimples = True) then begin
        if (gNaturezaComercialEmp <> 3) and (gNaturezaComercialEmp <> 2) then begin //Varejo e Atacado (p/ atender o Loj�o e Brascol)
          if (item_f('PR_REDUBASE', tFIS_REGRAFISCAL) <> 0) then begin
            if (vTpOperacao = 'S') then begin
              vVlCalc := vVlCalc - ((gVlTotalLiquidoICMS + gVlIPI) * item_f('PR_REDUBASE', tFIS_REGRAFISCAL)) / 100;
              putitem_e(tFIS_IMPOSTO, 'PR_BASECALC', 100 - item_f('PR_REDUBASE', tFIS_REGRAFISCAL));
              putitem_e(tFIS_IMPOSTO, 'PR_REDUBASE', item_f('PR_REDUBASE', tFIS_REGRAFISCAL));
            end else if (vTpOperacao = 'E') then begin
              if (gTpRegimeOrigem = 2) or (gTpRegimeOrigem = 3) then begin
                vVlCalc := vVlCalc - ((gVlTotalLiquidoICMS + gVlIPI) * item_f('PR_REDUBASE', tFIS_REGRAFISCAL)) / 100;
                putitem_e(tFIS_IMPOSTO, 'PR_BASECALC', 100 - item_f('PR_REDUBASE', tFIS_REGRAFISCAL));
                putitem_e(tFIS_IMPOSTO, 'PR_REDUBASE', item_f('PR_REDUBASE', tFIS_REGRAFISCAL));
              end;
            end;
          end;
        end;
      end;
      vVlBaseCalc := vVlCalc + ((vVlCalc * vPrIVA) / 100 );
      putitem_e(tFIS_IMPOSTO, 'VL_BASECALC', rounded(vVlBaseCalc, 6));
      if (item_f('PR_REDUBASE', tFIS_IMPOSTO) = 0) then begin
        putitem_e(tFIS_IMPOSTO, 'PR_BASECALC', 100);
      end;
    end else begin
      putitem_e(tFIS_IMPOSTO, 'VL_OUTRO', gVlTotalLiquidoICMS);
    end;

    if (vInCalcula = True)  then begin
      vVlCalc := (item_f('VL_BASECALC', tFIS_IMPOSTO) * item_f('PR_ALIQUOTA', tFIS_IMPOSTO)) / 100;
      vVlCalc := rounded(vVlCalc, 6);
      putitem_e(tFIS_IMPOSTO, 'VL_IMPOSTO', vVlCalc);
    end else begin
      if (item_f('VL_BASECALC', tFIS_IMPOSTO) > 0) then begin
        if (gInOptSimples = True) or ((gTpRegimeOrigem = 2) or (gTpRegimeOrigem = 3)
        and ((item_a('TP_OPERACAO', tGER_OPERACAO) = 'E')
        or (((item_f('TP_MODALIDADE', tGER_OPERACAO) = 3) and (item_a('TP_OPERACAO', tGER_OPERACAO) = 'S') )))) then begin //2-Simples 3-EPP / Entrada ou Devolucao de compra
          if (item_f('PR_ALIQUOTA', tFIS_IMPOSTO) <> 0) then begin
            vVlCalc := (item_f('VL_BASECALC', tFIS_IMPOSTO) * item_f('PR_ALIQUOTA', tFIS_IMPOSTO)) / 100;
            vVlICMS := rounded(vVlCalc, 6)    ;
            if (vCdCST = '30') or (vCdCST = '70') then begin
              if (gInOptSimples = True) then begin
                if (item_a('TP_OPERACAO', tGER_OPERACAO) = 'E') then begin
                  if (gTpRegimeOrigem = 2) or (gTpRegimeOrigem = 3) then begin
                    if (item_f('PR_REDUBASE', tFIS_REGRAFISCAL) <> 0) then begin
                      gVlTotalLiquidoICMS := (gVlTotalLiquidoICMS + gVlIPI) - ((gVlTotalLiquidoICMS + gVlIPI) * item_f('PR_REDUBASE', tFIS_REGRAFISCAL)) / 100;
                    end;
                  end;
                end else if (item_a('TP_OPERACAO', tGER_OPERACAO) = 'S') then begin
                  if (item_f('PR_REDUBASE', tFIS_REGRAFISCAL) <> 0) then begin
                    gVlTotalLiquidoICMS := (gVlTotalLiquidoICMS + gVlIPI) - ((gVlTotalLiquidoICMS + gVlIPI) * item_f('PR_REDUBASE', tFIS_REGRAFISCAL)) / 100;
                  end;
                end;
              end else if (gInOptSimples = False) and (vCdCST = '70') then begin
                if (gTpRegimeOrigem = 2) or (gTpRegimeOrigem = 3) then begin
                  if (item_f('PR_REDUBASE', tFIS_REGRAFISCAL) <> 0) then begin
                    gVlTotalLiquidoICMS := (gVlTotalLiquidoICMS + gVlIPI) - ((gVlTotalLiquidoICMS + gVlIPI) * item_f('PR_REDUBASE', tFIS_REGRAFISCAL)) / 100;
                  end;
                end;
              end;
            end;

            if (gDsUFOrigem = gDsUFDestino) then begin
              if (item_f('PR_ALIQICMS', tFIS_REGRAFISCAL) > 0) then begin
                vVlCalc := ((gVlTotalLiquidoICMS + gVlIPI) * item_f('PR_ALIQICMS', tFIS_REGRAFISCAL)) / 100;
              end else begin 
                clear_e(tFIS_ALIQUOTAICMSUF);
                putitem_o(tFIS_ALIQUOTAICMSUF, 'CD_UFORIGEM', gDsUFOrigem);
                putitem_o(tFIS_ALIQUOTAICMSUF, 'CD_UFDESTINO', gDsUFDestino);
                retrieve_e(tFIS_ALIQUOTAICMSUF);
                if (xStatus < 0) then begin
                  Result := SetStatus(STS_ERROR, 'GEN001', 'Nenhuma al�quota cadastrada de ' + gDsUFOrigem + ' para ' + gDsUFDestino + '!', cDS_METHOD);
                  return(-1); exit;
                end;
                vVlCalc := ((gVlTotalLiquidoICMS + gVlIPI) * item_f('PR_ALIQICMS', tFIS_ALIQUOTAICMSUF)) / 100;
              end;
            end else begin
              clear_e(tFIS_ALIQUOTAICMSUF);
              putitem_o(tFIS_ALIQUOTAICMSUF, 'CD_UFORIGEM', gDsUFOrigem);
              putitem_o(tFIS_ALIQUOTAICMSUF, 'CD_UFDESTINO', gDsUFDestino);
              retrieve_e(tFIS_ALIQUOTAICMSUF);
              if (xStatus < 0) then begin
                Result := SetStatus(STS_ERROR, 'GEN001', 'Nenhuma al�quota cadastrada de ' + gDsUFOrigem + ' para ' + gDsUFDestino + '!', cDS_METHOD);
                return(-1); exit;
              end;
              vVlCalc := ((gVlTotalLiquidoICMS + gVlIPI) * item_f('PR_ALIQICMS', tFIS_ALIQUOTAICMSUF)) / 100;
            end;
            vVlCalc := rounded(vVlCalc, 6);
            putitem_e(tFIS_IMPOSTO, 'VL_IMPOSTO', vVlICMS - vVlCalc);
          end;
        end else begin
          vVlCalc := item_f('VL_BASECALC', tFIS_IMPOSTO) * item_f('PR_ALIQUOTA', tFIS_IMPOSTO) / 100;
          vVlICMS := rounded(vVlCalc, 6) ;
          putitem_e(tFIS_IMPOSTO, 'VL_IMPOSTO', vVlICMS - gVlICMS);
        end;
      end else begin
        putitem_e(tFIS_IMPOSTO, 'VL_IMPOSTO', 0);
      end;
    end;
  end;

  if (vCdCST = '60') then begin
    putitem_e(tFIS_IMPOSTO, 'PR_ALIQUOTA', 0);
    putitem_e(tFIS_IMPOSTO, 'VL_OUTRO', gVlTotalLiquidoICMS);
    putitem_e(tFIS_IMPOSTO, 'VL_IMPOSTO', 0);
    putitem_e(tFIS_IMPOSTO, 'VL_BASECALC', 0);
    putitem_e(tFIS_IMPOSTO, 'PR_BASECALC', 0);
    putitem_e(tFIS_IMPOSTO, 'PR_REDUBASE', 0);
  end;

  gCdCST := Copy(gCdCST,1,1) + vCdCST;
  return(0);
end;

//----------------------
function T_FISSVCO015.calculaIPI(pParams : String) : String;
//----------------------
var
  vVlCalc, vVlBaseCalc, vCdDecreto : Real;
  vInDecreto : Boolean;
  vDtIniVigencia, vDtFimVigencia, vDtSistema : TDateTime;
begin
  if (gTpOrigemEmissao = 1) then begin //Pr�pria
    if (itemB('IN_IPI', tFIS_REGRAFISCAL) <> True) then begin
      discard(tFIS_IMPOSTO);
      return(-1); exit;
    end;
  end else begin
    if (gPrIPI = 0) or (gVlIPI = 0)  then begin
      if (itemB('IN_IPI', tFIS_REGRAFISCAL) <> True) then begin
        discard(tFIS_IMPOSTO);
        return(-1); exit;
      end;
    end;
  end;

  gCdDecreto := 0;
  vCdDecreto := 0;
  vInDecreto := False;
  vDtSistema := itemXmlD('DT_SISTEMA', PARAM_GLB);
  
  if (gCdDecretoItemCapa <> 0) then begin
    clear_e(tFIS_DECRETO);
    putitem_o(tFIS_DECRETO, 'CD_DECRETO', gCdDecretoItemCapa);
    retrieve_e(tFIS_DECRETO);
    if (xStatus >= 0) then begin
      vCdDecreto := item_f('CD_DECRETO', tFIS_DECRETO);
      vDtIniVigencia := item_d('DT_INIVIGENCIA', tFIS_DECRETO);
      vDtFimVigencia := item_d('DT_FIMVIGENCIA', tFIS_DECRETO);
    end;
  end else begin
    if (item_f('CD_DECRETO', tFIS_DECRETO) > 0) then begin
      vCdDecreto := item_f('CD_DECRETO', tFIS_DECRETO);
      vDtIniVigencia := item_d('DT_INIVIGENCIA', tFIS_DECRETO);
      vDtFimVigencia := item_d('DT_FIMVIGENCIA', tFIS_DECRETO);
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
  putitem_e(tFIS_IMPOSTO, 'PR_BASECALC', 100);
  putitem_e(tFIS_IMPOSTO, 'VL_BASECALC', gVlTotalBruto);
  if (gTpOrigemEmissao = 1) then begin //Pr�pria
    if(gPrIPI <> 0) then begin
      putitem_e(tFIS_IMPOSTO, 'PR_ALIQUOTA', gPrIPI);
    end else begin
      putitem_e(tFIS_IMPOSTO, 'PR_ALIQUOTA', item_f('PR_IPI', tFIS_TIPI));
    end;
    vVlCalc := item_f('VL_BASECALC', tFIS_IMPOSTO) * item_f('PR_ALIQUOTA', tFIS_IMPOSTO) / 100;
    putitem_e(tFIS_IMPOSTO, 'VL_IMPOSTO', rounded(vVlCalc, 2));
  end else begin
    if (gVlIPI = 0) then begin
      if (gPrIPI <> 0) then begin
        putitem_e(tFIS_IMPOSTO, 'PR_ALIQUOTA', gPrIPI);
      end;
      vVlCalc := item_f('VL_BASECALC', tFIS_IMPOSTO) * item_f('PR_ALIQUOTA', tFIS_IMPOSTO) / 100;
      putitem_e(tFIS_IMPOSTO, 'VL_IMPOSTO', rounded(vVlCalc, 2));
    end else begin
      putitem_e(tFIS_IMPOSTO, 'PR_ALIQUOTA', gPrIPI);
      putitem_e(tFIS_IMPOSTO, 'VL_IMPOSTO', gVlIPI);
    end;
  end;
  if (vCdDecreto = 8248) then begin // Decreto para reduzir o valor do IPI em 95% para produto de inform�tica
    if (item_f('TP_MODALIDADE', tGER_OPERACAO) = 4) then begin // 4 - Venda/Compra
      vInDecreto := True;
    end;

    if (vInDecreto = True) then begin
      vVlCalc := item_f('VL_IMPOSTO', tFIS_IMPOSTO) * (1 - 0.95);
      putitem_e(tFIS_IMPOSTO, 'VL_IMPOSTO', rounded(vVlCalc, 2));
      gCdDecreto := vCdDecreto;
    end;
  end;
  if ((item_f('TP_MODALIDADE', tGER_OPERACAO) <> 3) or (item_a('TP_OPERACAO', tGER_OPERACAO) <> 'S')) then begin //Devolucao / Saida
    if ((gCdServico > 0) or (item_f('TP_MODALIDADE', tGER_OPERACAO) = 5) or (item_f('TP_MODALIDADE', tGER_OPERACAO) = 6) or (item_a('TP_MODALIDADE', tGER_OPERACAO) = 'F')) then begin // 5-Outras entradas/saidas / 6-Producao / F-Remessa/Retorno;
      if (gInCalcIpiOutEntSai <> True) then begin
        putitem_e(tFIS_IMPOSTO, 'VL_OUTRO', item_f('VL_BASECALC', tFIS_IMPOSTO));
        putitem_e(tFIS_IMPOSTO, 'VL_BASECALC', 0);
        putitem_e(tFIS_IMPOSTO, 'VL_IMPOSTO', 0);
        putitem_e(tFIS_IMPOSTO, 'PR_ALIQUOTA', 0);
        putitem_e(tFIS_IMPOSTO, 'PR_BASECALC', '');
      end;
    end else if (item_f('TP_MODALIDADE', tGER_OPERACAO) = 3) and (item_a('TP_OPERACAO', tGER_OPERACAO) = 'E') then begin // Devolu��o de Venda
      if (gDsUFDestino = 'AC') or (gDsUFDestino = 'AM') or (gDsUFDestino = 'RO') or (gDsUFDestino = 'RR') or (gDsUFOrigem = 'EX') or (gDsUFDestino = 'EX') then begin
        putitem_e(tFIS_IMPOSTO, 'VL_OUTRO', item_f('VL_BASECALC', tFIS_IMPOSTO));
        putitem_e(tFIS_IMPOSTO, 'VL_BASECALC', 0);
        putitem_e(tFIS_IMPOSTO, 'VL_IMPOSTO', 0);
        putitem_e(tFIS_IMPOSTO, 'PR_ALIQUOTA', 0);
        putitem_e(tFIS_IMPOSTO, 'PR_BASECALC', '');
      end;
    end else begin
      if (gNaturezaComercialEmp = 4) then begin // 4 - IPI suspenso
        if (item_f('VL_IMPOSTO', tFIS_IMPOSTO) = 0) then begin
          putitem_e(tFIS_IMPOSTO, 'VL_OUTRO', item_f('VL_BASECALC', tFIS_IMPOSTO));
          putitem_e(tFIS_IMPOSTO, 'VL_BASECALC', 0);
          putitem_e(tFIS_IMPOSTO, 'PR_ALIQUOTA', 0);
          putitem_e(tFIS_IMPOSTO, 'PR_BASECALC', '');
        end;
      end else if (item_f('TP_MODALIDADE', tGER_OPERACAO) = 4) and (item_a('TP_OPERACAO', tGER_OPERACAO) = 'S') then begin // 4 - Venda
        if (gDsUFDestino = 'EX') or (gDsUFDestino = 'AC') or (gDsUFDestino = 'AM') or (gDsUFDestino = 'RO') or (gDsUFDestino = 'RR') then begin
          putitem_e(tFIS_IMPOSTO, 'VL_OUTRO', item_f('VL_BASECALC', tFIS_IMPOSTO));
          putitem_e(tFIS_IMPOSTO, 'VL_BASECALC', 0);
          putitem_e(tFIS_IMPOSTO, 'VL_IMPOSTO', 0);
          putitem_e(tFIS_IMPOSTO, 'PR_ALIQUOTA', 0);
          putitem_e(tFIS_IMPOSTO, 'PR_BASECALC', '');
        end else if (gTpAreaComercioOrigem = 0) and (gTpAreaComercioDestino > 0) then begin
          putitem_e(tFIS_IMPOSTO, 'VL_OUTRO', item_f('VL_BASECALC', tFIS_IMPOSTO));
          putitem_e(tFIS_IMPOSTO, 'VL_BASECALC', 0);
          putitem_e(tFIS_IMPOSTO, 'VL_IMPOSTO', 0);
          putitem_e(tFIS_IMPOSTO, 'PR_ALIQUOTA', 0);
          putitem_e(tFIS_IMPOSTO, 'PR_BASECALC', '');
        end;
      end;
    end;
  end else begin
    if (item_f('PR_ALIQUOTA', tFIS_IMPOSTO) = 0) then begin
      putitem_e(tFIS_IMPOSTO, 'VL_OUTRO', item_f('VL_BASECALC', tFIS_IMPOSTO));
      putitem_e(tFIS_IMPOSTO, 'VL_BASECALC', 0);
      putitem_e(tFIS_IMPOSTO, 'VL_IMPOSTO', 0);
      putitem_e(tFIS_IMPOSTO, 'PR_ALIQUOTA', 0);
      putitem_e(tFIS_IMPOSTO, 'PR_BASECALC', '');
    end;
  end;

  if (gInImpostoOffLine = True) then begin
    putitem_e(tFIS_IMPOSTO, 'VL_BASECALC', 0);
    putitem_e(tFIS_IMPOSTO, 'VL_IMPOSTO', 0);
  end;

  gPrIPI := item_f('PR_ALIQUOTA', tFIS_IMPOSTO);
  gVlIPI := item_f('VL_IMPOSTO', tFIS_IMPOSTO);
  return(0);
end;

//----------------------
function T_FISSVCO015.calculaISS(pParams : String) : String;
//----------------------
var
  vVlCalc, vVlBaseCalc : Real;
  vCdCST : String;
begin
  if (gInImpostoOffLine = True) then begin
    discard(tFIS_IMPOSTO);
    return(-1); exit;
  end;

  vCdCST := Copy(gCdCST,2,2);

  if (vCdCST = '40') or (vCdCST = '41') then begin
    putitem_e(tFIS_IMPOSTO, 'PR_BASECALC', 0);
    putitem_e(tFIS_IMPOSTO, 'VL_BASECALC', 0);
    putitem_e(tFIS_IMPOSTO, 'PR_ALIQUOTA', item_f('PR_ALIQISS', tFIS_REGRAFISCAL));
    vVlCalc := item_f('VL_BASECALC', tFIS_IMPOSTO) * item_f('PR_ALIQUOTA', tFIS_IMPOSTO) / 100;
    putitem_e(tFIS_IMPOSTO, 'VL_IMPOSTO', rounded(vVlCalc, 6));
    putitem_e(tFIS_IMPOSTO, 'VL_ISENTO', gVlTotalLiquido);

  end else if (vCdCST = '90') then begin
    putitem_e(tFIS_IMPOSTO, 'PR_BASECALC', 0);
    putitem_e(tFIS_IMPOSTO, 'VL_BASECALC', 0);
    putitem_e(tFIS_IMPOSTO, 'PR_ALIQUOTA', item_f('PR_ALIQISS', tFIS_REGRAFISCAL));
    vVlCalc := item_f('VL_BASECALC', tFIS_IMPOSTO) * item_f('PR_ALIQUOTA', tFIS_IMPOSTO) / 100;
    putitem_e(tFIS_IMPOSTO, 'VL_IMPOSTO', rounded(vVlCalc, 6));
    putitem_e(tFIS_IMPOSTO, 'VL_OUTRO', gVlTotalLiquido);
  end else begin
    putitem_e(tFIS_IMPOSTO, 'PR_BASECALC', 100);
    putitem_e(tFIS_IMPOSTO, 'VL_BASECALC', gVlTotalLiquido);
    putitem_e(tFIS_IMPOSTO, 'PR_ALIQUOTA', item_f('PR_ALIQISS', tFIS_REGRAFISCAL));
    vVlCalc := item_f('VL_BASECALC', tFIS_IMPOSTO) * item_f('PR_ALIQUOTA', tFIS_IMPOSTO) / 100;
    putitem_e(tFIS_IMPOSTO, 'VL_IMPOSTO', rounded(vVlCalc, 6));
  end;
  return(0);
end;

//-------------------
function T_FISSVCO015.calculaCOFINS(pParams : String) : String;
//-------------------
var
  vVlCalc : Real;
  bStatus : Boolean;
begin
  if (gInImpostoOffLine = True) then begin
    discard(tFIS_IMPOSTO);
    return(-1); exit;
  end;
  if (itemB('IN_COFINS', tFIS_REGRAFISCAL) <> True) then begin
    discard(tFIS_IMPOSTO);
    return(-1); exit;
  end;

  clear_e(tFIS_REGRAIMPOSTO);
  putitem_o(tFIS_REGRAIMPOSTO, 'CD_IMPOSTO', item_a('CD_IMPOSTO', tFIS_IMPOSTO));
  putitem_o(tFIS_REGRAIMPOSTO, 'CD_REGRAFISCAL', item_a('CD_REGRAFISCAL', tFIS_REGRAFISCAL));
  retrieve_e(tFIS_REGRAIMPOSTO);
  if (xStatus < 0) then begin
    putitem_e(tFIS_IMPOSTO, 'CD_CST', item_a('CD_CST', tFIS_REGRAIMPOSTO));
  end;

  if (gTpAreaComercioOrigem = 0)
  and (((gTpAreaComercioDestino = 1) and (gInDescontaPisCofinsAlc = False)) or ((gTpAreaComercioDestino = 2) and (gInDescontaPisCofinsZfm = False))) then begin
    putitem_e(tFIS_REGRAFISCAL, 'PR_ALIQCOFINS', 0);
    putitem_e(tFIS_IMPOSTO, 'CD_CST', '06');
  end;
  putitem_e(tFIS_IMPOSTO, 'PR_BASECALC', 100);
  putitem_e(tFIS_IMPOSTO, 'VL_BASECALC', gVlTotalLiquido);
  if (gDsLstCfopIpiBcPisCof <> '') then begin
    creocc(tTMP_NR09, -1);
    if (gInProdPropria = True) then begin
      putitem_o(tTMP_NR09, 'NR_GERAL', item_a('CD_CFOPPROPRIA', tFIS_REGRAFISCAL));
    end else begin
      putitem_o(tTMP_NR09, 'NR_GERAL', item_a('CD_CFOPTERCEIRO', tFIS_REGRAFISCAL));
    end;
    if (xStatus = 4) then begin
      putitem_e(tFIS_IMPOSTO, 'VL_BASECALC', item_f('VL_BASECALC', tFIS_IMPOSTO) + gVlIPI);
    end else begin
      discard(tTMP_NR09);
    end;
  end;
  putitem_e(tFIS_IMPOSTO, 'PR_ALIQUOTA', item_f('PR_ALIQCOFINS', tFIS_REGRAFISCAL));
  vVlCalc := item_f('VL_BASECALC', tFIS_IMPOSTO) * item_f('PR_ALIQUOTA', tFIS_IMPOSTO) / 100;
  putitem_e(tFIS_IMPOSTO, 'VL_IMPOSTO', rounded(vVlCalc, 6));
  return(0);
end;

//----------------------
function T_FISSVCO015.calculaPIS(pParams : String) : String;
//----------------------
var
  vVlCalc : Real;
  bStatus : Boolean;
begin
  if (gInImpostoOffLine = True) then begin
    discard(tFIS_IMPOSTO);
    return(-1); exit;
  end;
  if (itemB('IN_PIS', tFIS_REGRAFISCAL) <> True) then begin
    discard(tFIS_IMPOSTO);
    return(-1); exit;
  end;

  clear_e(tFIS_REGRAIMPOSTO);
  putitem_o(tFIS_REGRAIMPOSTO, 'CD_IMPOSTO', item_a('CD_IMPOSTO', tFIS_IMPOSTO));
  putitem_o(tFIS_REGRAIMPOSTO, 'CD_REGRAFISCAL', item_a('CD_REGRAFISCAL', tFIS_REGRAFISCAL));
  retrieve_e(tFIS_REGRAIMPOSTO);
  if (xStatus < 0) then begin
    putitem_e(tFIS_IMPOSTO, 'CD_CST', item_a('CD_CST', tFIS_REGRAIMPOSTO));
  end;

  if (gTpAreaComercioOrigem = 0)
  and (((gTpAreaComercioDestino = 1) and (gInDescontaPisCofinsAlc = False)) or ((gTpAreaComercioDestino = 2) and (gInDescontaPisCofinsZfm = False))) then begin
    putitem_e(tFIS_REGRAFISCAL, 'PR_ALIQPIS', 0);
    putitem_e(tFIS_IMPOSTO, 'CD_CST', '06');
  end;
  putitem_e(tFIS_IMPOSTO, 'PR_BASECALC', 100);
  putitem_e(tFIS_IMPOSTO, 'VL_BASECALC', gVlTotalLiquido);
  if (gDsLstCfopIpiBcPisCof <> '') then begin
    creocc(tTMP_NR09, -1);
    if (gInProdPropria = True) then begin
      putitem_o(tTMP_NR09, 'NR_GERAL', item_a('CD_CFOPPROPRIA', tFIS_REGRAFISCAL));
    end else begin
      putitem_o(tTMP_NR09, 'NR_GERAL', item_a('CD_CFOPTERCEIRO', tFIS_REGRAFISCAL));
    end;
    if (xStatus = 4) then begin
      putitem_e(tFIS_IMPOSTO, 'VL_BASECALC', item_f('VL_BASECALC', tFIS_IMPOSTO) + gVlIPI);
    end else begin
      discard(tTMP_NR09);
    end;
  end;
  putitem_e(tFIS_IMPOSTO, 'PR_ALIQUOTA', item_f('PR_ALIQPIS', tFIS_REGRAFISCAL));
  vVlCalc := item_f('VL_BASECALC', tFIS_IMPOSTO) * item_f('PR_ALIQUOTA', tFIS_IMPOSTO) / 100;
  putitem_e(tFIS_IMPOSTO, 'VL_IMPOSTO', rounded(vVlCalc, 6));
  return(0);
end;

//----------------------
function T_FISSVCO015.calculaPASEP(pParams : String) : String;
//----------------------
var
  vVlCalc : Real;
begin
  if (gInImpostoOffLine = True) then begin
    discard(tFIS_IMPOSTO);
    return(-1); exit;
  end;

  if (itemB('IN_PASEP', tFIS_REGRAFISCAL) <> True)
  or (item_f('PR_ALIQPASEP', tFIS_REGRAFISCAL) = 0) then begin
    discard(tFIS_IMPOSTO);
    return(-1); exit;
  end;

  putitem_e(tFIS_IMPOSTO, 'PR_BASECALC', 100);
  putitem_e(tFIS_IMPOSTO, 'VL_BASECALC', gVlTotalLiquido);
  putitem_e(tFIS_IMPOSTO, 'PR_ALIQUOTA', item_f('PR_ALIQPASEP', tFIS_REGRAFISCAL));
  vVlCalc := item_f('VL_BASECALC', tFIS_IMPOSTO) * item_f('PR_ALIQUOTA', tFIS_IMPOSTO) / 100;
  putitem_e(tFIS_IMPOSTO, 'VL_IMPOSTO', rounded(vVlCalc, 6));
  return(0);
end;

{ T_FISSVCO015 }

//-------------------------
function T_FISSVCO015.buscaCFOP(pParams : String) : String;
//-------------------------
const
  cDS_METHOD = 'ADICIONAL=Opera��o: T_FISSVCO015.buscaCFOP()';
var
  viParams, voParams, vDsLstEmpresa, vCdMPTer, vTpOperacao, vDsUF, vCdCSTOperacao, vCdCST : String;
  vCdEmpresa, vCdEmpresaParam, vCdProduto, vCdOperacao, vCdPessoa, vCdCFOPOperacao : Real;
  vCdRegraFiscal, vCdCFOP, vTpAreaComercio, vTpAreaComercioOrigem, vCdCFOPServico, vPrIvaPrd : Real;
  vInProdPropria, vInDecreto, vInOrgaoPublico : Boolean;
  vCdRegraFiscalParam : Real;
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
  gTpOrigemEmissao := itemXmlF('TP_ORIGEMEMISSAO', pParams); //1 - Pr�pria / 2 - Terceiros;
  vCdRegraFiscalParam := itemXmlF('CD_REGRAFISCAL', pParams);
  gInContribuinte := itemXmlB('IN_CONTRIBUINTE', pParams);
  vCdCFOP := 0;
  vInDecreto := False;
  gCdDecreto := 0;

  if (gDsUFDestino = '') then begin
    Result := SetStatus(STS_ERROR, 'GEN001', 'UF destino n�o informada!', cDS_METHOD);
    return(-1); exit;
  end;
  if (vCdOperacao = 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN001', 'Opera��o n�o informada!', cDS_METHOD);
    return(-1); exit;
  end;
  if (vCdPessoa = 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN001', 'Pessoa n�o informada!', cDS_METHOD);
    return(-1); exit;
  end;

  clear_e(tGER_OPERACAO);
  putitem_o(tGER_OPERACAO, 'CD_OPERACAO', vCdOperacao);
  retrieve_e(tGER_OPERACAO);
  if (xStatus < 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN001', 'Opera��o ' + FloatToStr(vCdOperacao) + ' n�o cadastrada!', cDS_METHOD);
    return(-1); exit;
  end;

  if (vCdRegraFiscalParam > 0) then begin
    putitem(tGER_OPERACAO, 'CD_REGRAFISCAL', vCdRegraFiscalParam);
  end;

  if (vCdProduto = 0)
  and (vCdMPTer = '')
  and (gCdServico = 0) then begin
    return(0); exit;
  end;

  if (vCdMPTer <> '') then begin
    clear_e(tCDF_MPTER);
    putitem_o(tCDF_MPTER, 'CD_PESSOA', vCdPessoa);
    putitem_o(tCDF_MPTER, 'CD_MPTER', vCdMPTer);
    retrieve_e(tCDF_MPTER);
    if (xStatus < 0) then begin
      Result := SetStatus(STS_ERROR, 'GEN001', 'Mat�ria-prima ' + vCdMPTer + ' n�o cadastrada para a pessoa ' + FloatToStr(vCdPessoa) + '!', cDS_METHOD);
      return(-1); exit;
    end;
  end else begin
    clear_e(tPRD_PRODUTO);
    putitem_o(tPRD_PRODUTO, 'CD_PRODUTO', vCdProduto);
    retrieve_e(tPRD_PRODUTO);
    if (xStatus < 0) then begin
      Result := SetStatus(STS_ERROR, 'GEN001', 'Produto ' + FloatToStr(vCdProduto) + ' n�o cadastrado!', cDS_METHOD);
      return(-1); exit;
    end;
  end;

  clear_e(tPES_PESSOA);
  putitem_o(tPES_PESSOA, 'CD_PESSOA', vCdPessoa);
  retrieve_e(tPES_PESSOA);
  if (xStatus < 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN001', 'Pessoa ' + FloatToStr(vCdPessoa) + ' n�o cadastrada!', cDS_METHOD);
    return(-1); exit;
  end;

  //Venda / Devolu��o de venda
  if ((item_a('TP_OPERACAO', tGER_OPERACAO) = 'S') and (item_a('TP_MODALIDADE', tGER_OPERACAO) = '4'))
  or ((item_a('TP_OPERACAO', tGER_OPERACAO) = 'E') and (item_a('TP_MODALIDADE', tGER_OPERACAO) = '3')) then begin
    clear_e(tPES_CLIENTE);
    putitem_o(tPES_CLIENTE, 'CD_CLIENTE', vCdPessoa);
    retrieve_e(tPES_CLIENTE);
    if (xStatus < 0) then begin
      Result := SetStatus(STS_ERROR, 'GEN001', 'Cliente ' + FloatToStr(vCdPessoa) + ' n�o cadastrado!', cDS_METHOD);
      return(-1); exit;
    end;
  end;

  // Implementado por Deusdete em 22/03/2007, situa��o emergencial na Krindges;
  // Se for pessoa Jur�dica e n�o tiver inscri��o estadual, isto �, Isento, dever� ser tratado para fazer o c�lculo do imposto
  // com a al�quota interna.;
  gInPjIsento := False;
  if (item_a('NR_INSCESTL', tPES_PESJURIDICA) = 'ISENTO')
  or (item_a('NR_INSCESTL', tPES_PESJURIDICA) = 'ISENTA')
  or (item_a('NR_INSCESTL', tPES_PESJURIDICA) = 'ISENTOS')
  or (item_a('NR_INSCESTL', tPES_PESJURIDICA) = 'ISENTAS') then begin
    if (item_a('TP_REGIMETRIB', tPES_PESJURIDICA) <> '6') then begin // MEI (Micro Empres�rio Individual)
      gInPjIsento := True;
    end;
  end;

  if (gTpOrigemEmissao = 2) then begin //Terceiros
    if (item_a('TP_MODALIDADE', tGER_OPERACAO) <> '3') then begin //Devolu��o
      vDsUF := gDsUFOrigem;
      gDsUFOrigem := gDsUFDestino;
      gDsUFDestino := vDsUF;
    end;
  end else begin
    if ((item_a('TP_MODALIDADE', tGER_OPERACAO) = '3') and (item_a('TP_OPERACAO', tGER_OPERACAO) = 'S')) then begin //Devolu��o compra
      vDsUF := gDsUFOrigem;
      gDsUFOrigem := gDsUFDestino;
      gDsUFDestino := vDsUF;
    end;
  end;

  viParams := '';
  putitemXml(viParams, 'CD_PESSOA', vCdPessoa);
  voParams := activateCmp('FCRSVCO057', 'validaPessoaOrgaoPublico', viParams);
  if (xStatus < 0) then begin
    Result := voParams;
    return(-1); exit;
  end;
  vInOrgaoPublico := itemXmlB('IN_ORGAOPUBLICO', voParams);

  if (vInOrgaoPublico = True) and (gDsUFOrigem = 'DF') then begin
    gInContribuinte := True;
  end else begin
    if (itemB('IN_CNSRFINAL', tPES_CLIENTE) = True) or (item_a('TP_PESSOA', tPES_PESSOA) = 'F') or (gInPjIsento = True) then begin
      if (itemB('IN_CNSRFINAL', tPES_CLIENTE) = True) and (item_a('TP_PESSOA', tPES_PESSOA) = 'J') and (gInPjIsento = False) then begin
        gInContribuinte := True;
      end else begin
        if (item_a('TP_PESSOA', tPES_PESSOA) = 'F')
        and (item_a('NR_CODIGOFISCAL', tPES_CLIENTE) <> '')
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
    vCdRegraFiscal := item_f('CD_REGRAFISCAL', tGER_OPERACAO);
    if (vCdRegraFiscal = 0) then begin
      Result := SetStatus(STS_ERROR, 'GEN001', 'Nenhuma regra fiscal cadastrada p/ a opera��o ' + FloatToStr(vCdOperacao) + '!', cDS_METHOD);
      return(-1); exit;
    end;
  end else if (vCdMPTer <> '') then begin
    vInProdPropria := False;
    vCdRegraFiscal := item_f('CD_REGRAFISCAL', tGER_OPERACAO);
    if (vCdRegraFiscal = 0) then begin
      Result := SetStatus(STS_ERROR, 'GEN001', 'Nenhuma regra fiscal cadastrada p/ a opera��o ' + FloatToStr(vCdOperacao) + '!', cDS_METHOD);
      return(-1); exit;
    end;
  end else begin
    viParams := '';
    putitemXml(viParams, 'CD_EMPRESA', vCdEmpresaParam);
    putitemXml(viParams, 'CD_PRODUTO', vCdProduto);
    voParams := activateCmp('PRDSVCO007', 'buscaDadosFilial', viParams); // PRDSVCO008
    if (xStatus < 0) then begin
      Result := voParams;
      return(-1); exit;
    end;
    vInProdPropria := itemXmlB('IN_PRODPROPRIA', voParams);

    clear_e(tPRD_PRDREGRAFISCAL);
    putitem_o(tPRD_PRDREGRAFISCAL, 'CD_PRODUTO', vCdProduto);
    putitem_o(tPRD_PRDREGRAFISCAL, 'CD_OPERACAO', vCdOperacao);
    retrieve_e(tPRD_PRDREGRAFISCAL);
    if (xStatus >= 0) then begin
      clear_e(tFIS_REGRAFISCAL);
      putitem_o(tFIS_REGRAFISCAL, 'CD_REGRAFISCAL', item_f('CD_REGRAFISCAL', tPRD_PRDREGRAFISCAL));
      retrieve_e(tFIS_REGRAFISCAL);
      if (xStatus < 0) then begin
        Result := SetStatus(STS_ERROR, 'GEN001', 'Regra fiscal ' + item_a('CD_REGRAFISCAL', tPRD_PRDREGRAFISCAL) + ' n�o cadastrada!', cDS_METHOD);
        return(-1); exit;
      end else begin
        if (item_f('CD_DECRETO', tFIS_REGRAFISCAL) = 2155)
        or (item_f('CD_DECRETO', tFIS_REGRAFISCAL) = 1020)
        or (item_f('CD_DECRETO', tFIS_REGRAFISCAL) = 45471)
        or (item_f('CD_DECRETO', tFIS_REGRAFISCAL) = 23731)
        or (item_f('CD_DECRETO', tFIS_REGRAFISCAL) = 23732)
        or (item_f('CD_DECRETO', tFIS_REGRAFISCAL) = 23733)
        or (item_f('CD_DECRETO', tFIS_REGRAFISCAL) = 23734)
        or (item_f('CD_DECRETO', tFIS_REGRAFISCAL) = 23735)
        or (item_f('CD_DECRETO', tFIS_REGRAFISCAL) = 10201)
        or (item_f('CD_DECRETO', tFIS_REGRAFISCAL) = 10202)
        or (item_f('CD_DECRETO', tFIS_REGRAFISCAL) = 10203) then begin
          if (gInContribuinte = True) then begin
            vCdRegraFiscal := item_f('CD_REGRAFISCAL', tPRD_PRDREGRAFISCAL);
          end else begin
            vCdRegraFiscal := item_f('CD_REGRAFISCAL', tGER_OPERACAO);
          end;
        end else begin
          vCdRegraFiscal := item_f('CD_REGRAFISCAL', tPRD_PRDREGRAFISCAL);
        end;
      end;
    end else begin
      vCdRegraFiscal := item_f('CD_REGRAFISCAL', tGER_OPERACAO);
    end;

    if (vCdRegraFiscal = 0) then begin
      Result := SetStatus(STS_ERROR, 'GEN001', 'Nenhuma regra fiscal cadastrada p/ o produto ' + FloatToStr(vCdProduto) + ' e a opera��o ' + FloatToStr(vCdOperacao) + '!', cDS_METHOD);
      return(-1); exit;
    end;
    vCdCST := Copy(item_a('CD_CST', tPRD_PRODUTO), 1, 1);
  end;

  if (vCdRegraFiscalParam > 0) then begin
    vCdRegraFiscal := vCdRegraFiscalParam;
  end;

  clear_e(tFIS_REGRAFISCAL);
  putitem_o(tFIS_REGRAFISCAL, 'CD_REGRAFISCAL', item_a('CD_REGRAFISCAL', tGER_OPERACAO));
  retrieve_e(tFIS_REGRAFISCAL);
  if (xStatus < 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN001', 'Regra fiscal ' + item_a('CD_REGRAFISCAL', tGER_OPERACAO) + '!', cDS_METHOD);
    return(-1); exit;
  end;
  if (vInProdPropria = True) then begin
    vCdCFOPOperacao := item_f('CD_CFOPPROPRIA', tFIS_REGRAFISCAL);
  end else begin
    vCdCFOPOperacao := item_f('CD_CFOPTERCEIRO', tFIS_REGRAFISCAL);
  end;
  vCdCSTOperacao := Copy(item_a('CD_CST', tFIS_REGRAFISCAL), 1, 2);

  clear_e(tFIS_REGRAFISCAL);
  putitem_o(tFIS_REGRAFISCAL, 'CD_REGRAFISCAL', vCdRegraFiscal);
  retrieve_e(tFIS_REGRAFISCAL);
  if (item_a('CD_REGRAFISCAL', tFIS_REGRAFISCAL) = '') then begin
    Result := SetStatus(STS_ERROR, 'GEN001', 'Regra fiscal ' + FloatToStr(vCdRegraFiscal) + ' n�o cadastrada!', cDS_METHOD);
    return(-1); exit;
  end else begin
    if (item_f('CD_DECRETO', tFIS_REGRAFISCAL) = 2155) then begin
      if (gDsUFOrigem = 'PR') or (gDsUFOrigem = 'RS') or (gDsUFOrigem = 'SC') then begin
        if (gInContribuinte = True) and (item_f('TP_MODALIDADE', tGER_OPERACAO) = 4) then begin // 4 - Venda/Compra
          if (gDsUFDestino = 'PR') or (gDsUFDestino = 'RS') or (gDsUFDestino = 'SC') then begin
            if (item_a('TP_OPERACAO', tGER_OPERACAO) = 'S') then begin // S - Saida
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
    end else if (item_f('CD_DECRETO', tFIS_REGRAFISCAL) = 1020)
             or (item_f('CD_DECRETO', tFIS_REGRAFISCAL) = 10201)
             or (item_f('CD_DECRETO', tFIS_REGRAFISCAL) = 10202)
             or (item_f('CD_DECRETO', tFIS_REGRAFISCAL) = 10203) then begin
      if (gDsUFOrigem = 'PR') or (gDsUFOrigem = 'SC') or (gDsUFOrigem = 'MG') then begin
        if (gInContribuinte = True) and (item_f('TP_MODALIDADE', tGER_OPERACAO) = 4) then begin // 4 - Venda/Compra
          if (gDsUFDestino = 'PR') or (gDsUFDestino = 'SC') or (gDsUFDestino = 'MG') then begin
            if (item_a('TP_OPERACAO', tGER_OPERACAO) = 'S') then begin // S - Saida
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
    end else if (item_f('CD_DECRETO', tFIS_REGRAFISCAL) = 45471) then begin
      if (gDsUFOrigem = 'RS') or (gDsUFOrigem = 'PR') or (gDsUFOrigem = 'SC') then begin
        if (gInContribuinte = True) and (item_f('TP_MODALIDADE', tGER_OPERACAO) = 4) then begin // 4 - Venda/Compra
          if (gDsUFDestino = 'PR') or (gDsUFDestino = 'RS') or (gDsUFDestino = 'SC') then begin
            if (item_a('TP_OPERACAO', tGER_OPERACAO) = 'S') then begin // S - Saida
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
    end else if (item_f('CD_DECRETO', tFIS_REGRAFISCAL) = 23731)
             or (item_f('CD_DECRETO', tFIS_REGRAFISCAL) = 23732)
             or (item_f('CD_DECRETO', tFIS_REGRAFISCAL) = 23733)
             or (item_f('CD_DECRETO', tFIS_REGRAFISCAL) = 23734)
             or (item_f('CD_DECRETO', tFIS_REGRAFISCAL) = 23735) then begin

      if (gDsUFOrigem = 'PR') or (gDsUFDestino = 'PR') then begin
        if (gInContribuinte = True) and (item_f('TP_MODALIDADE', tGER_OPERACAO) = 4) then begin // 4 - Venda/Compra
          if (item_a('TP_OPERACAO', tGER_OPERACAO) = 'S') then begin // S - Saida
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
      vCdCFOP := item_f('CD_CFOPPROPRIA', tFIS_REGRAFISCAL);
    end else begin
      vCdCFOP := item_f('CD_CFOPTERCEIRO', tFIS_REGRAFISCAL);
    end;

    if (vTpAreaComercio > 0) then begin
      if (vTpAreaComercio = 2) and (vTpAreaComercioOrigem = 2) then begin // 2 - Manaus
      end else begin
        if (item_a('TP_OPERACAO', tGER_OPERACAO) = 'S') and (item_f('TP_MODALIDADE', tGER_OPERACAO) = 4) then begin //Venda
          vCdCST := Copy(item_a('CD_CST', tPRD_PRODUTO), 1, 1);
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
    if (xStatus < 0) then begin
      Result := voParams;
      return(-1); exit;
    end;

    vCdCFOPServico := itemXmlF('CD_CFOPSERVICO', voParams);
    if (vCdCFOPServico <> 0) then begin
      vCdCFOP := vCdCFOPServico;
    end;
  end else begin
    if (Copy(item_a('CD_CST', tFIS_REGRAFISCAL), 1, 2) = '60')   then begin
      vCdCST := Copy(item_a('CD_CST', tFIS_REGRAFISCAL), 1, 1);
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

    if (vInDecreto = False) then begin // S� chamar este servi�o se n�o tiver decreto na regra
      if (Copy(item_a('CD_CST', tFIS_REGRAFISCAL), 1, 2) = '10') or (Copy(vCdCST,1,2) = '10') then begin
        vTpOperacao := item_a('TP_OPERACAO', tGER_OPERACAO);

        viParams := '';
        putitemXml(viParams, 'CD_PRODUTO', item_a('CD_PRODUTO', tPRD_PRODUTO));
        putitemXml(viParams, 'UF_ORIGEM', gDsUFOrigem);
        putitemXml(viParams, 'UF_DESTINO', gDsUFDestino);
        putitemXml(viParams, 'TP_OPERACAO', vTpOperacao);
        voParams := activateCmp('FISSVCO035', 'buscaDadosFiscalProduto', viParams);
        if (xStatus < 0) then begin
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

  if (item_a('TP_OPERACAO', tGER_OPERACAO) = 'E') then begin //Entrada
    if (vCdCFOP >= 4000) then begin
      Result := SetStatus(STS_ERROR, 'GEN001', 'CFOP ' + FloatToStr(vCdCFOP) + ' do produto ' + FloatToStr(vCdProduto) + ' incompat�vel com a opera��o de entrada ' + FloatToStr(vCdOperacao) + '!', cDS_METHOD);
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
      Result := SetStatus(STS_ERROR, 'GEN001', 'CFOP ' + FloatToStr(vCdCFOP) + ' do produto ' + FloatToStr(vCdProduto) + ' incompat�vel com a opera��o de sa�da ' + FloatToStr(vCdOperacao) + '!', cDS_METHOD);
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

  if (Copy(item_a('CD_CST', tFIS_REGRAFISCAL), 1, 2) = '70') then begin
    if (gDsUFOrigem = 'GO') then begin
      if (gDsUFOrigem <> gDsUFDestino) or (vInProdPropria <> True) or (gInContribuinte <> True) then begin
        if (vCdCFOP = 5405) then begin          // Como a regra fiscal esta como a CFOP generica 06, pois toda venda p/
          if (vInProdPropria = True) then begin // n�o contribuinte dever� sair com o CFOP interno de venda
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

  if (Copy(item_a('CD_CST', tFIS_REGRAFISCAL), 1, 2) = '60') then begin
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
  cDS_METHOD = 'ADICIONAL=Opera��o: T_FISSVCO015.buscaCST()';
var
  viParams, voParams, vDsLstEmpresa, vCdCST, vCdMPTer, vTpOperacao, vCdCSTOperacao, vDsUF : String;
  vInProdPropria, vInDecreto, vInOrgaoPublico, vInPrReducao, vInOptSimples : Boolean;
  vCdEmpresa, vCdEmpresaParam, vCdProduto, vCdOperacao, vCdPessoa, vCdCFOP : Real;
  vCdRegraFiscal, vTpAreaComercio, vTpAreaComercioOrigem, vPrIvaPrd : Real;
  vCdRegraFiscalParam : Real;
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
  gTpOrigemEmissao := itemXmlF('TP_ORIGEMEMISSAO', pParams); //1 - Pr�pria / 2 - Terceiros
  vCdRegraFiscalParam := itemXmlF('CD_REGRAFISCAL', pParams);
  gInContribuinte := False;
  vInDecreto := False;

  if (vCdOperacao = 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN001', 'Opera��o n�o informada!', cDS_METHOD);
    return(-1); exit;
  end;
  if (vCdPessoa = 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN001', 'Pessoa n�o informada!', cDS_METHOD);
    return(-1); exit;
  end;

  clear_e(tGER_OPERACAO);
  putitem_o(tGER_OPERACAO, 'CD_OPERACAO', vCdOperacao);
  retrieve_e(tGER_OPERACAO);
  if (xStatus < 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN001', 'Opera��o ' + FloatToStr(vCdOperacao) + ' n�o cadastrada!', cDS_METHOD);
    return(-1); exit;
  end;

  if (vCdProduto = 0)
  and (vCdMPTer = '')
  and (gCdServico = 0) then begin
    return(0); exit;
  end;

  if (vCdCFOP = 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN001', 'CFOP n�o informada!', cDS_METHOD);
    return(-1); exit;
  end;

  if (vCdMPTer <> '') then begin
    clear_e(tCDF_MPTER);
    putitem_o(tCDF_MPTER, 'CD_PESSOA', vCdPessoa);
    putitem_o(tCDF_MPTER, 'CD_MPTER', vCdMPTer);
    retrieve_e(tCDF_MPTER);
    if (xStatus < 0) then begin
      Result := SetStatus(STS_ERROR, 'GEN001', 'Mat�ria-prima ' + vCdMPTer + ' n�o cadastrada para a pessoa ' + FloatToStr(vCdPessoa) + '!', cDS_METHOD);
      return(-1); exit;
    end;
  end else begin
    clear_e(tPRD_PRODUTO);
    putitem_o(tPRD_PRODUTO, 'CD_PRODUTO', vCdProduto);
    retrieve_e(tPRD_PRODUTO);
    if (xStatus < 0) then begin
      Result := SetStatus(STS_ERROR, 'GEN001', 'Produto ' + FloatToStr(vCdProduto) + ' n�o cadastrado!', cDS_METHOD);
      return(-1); exit;
    end;
  end;

  clear_e(tGER_OPERACAO);
  putitem_o(tGER_OPERACAO, 'CD_OPERACAO', vCdOperacao);
  retrieve_e(tGER_OPERACAO);
  if (xStatus < 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN001', 'Opera��o ' + FloatToStr(vCdOperacao) + ' n�o cadastrada!', cDS_METHOD);
    return(-1); exit;
  end;

  if (vCdRegraFiscalParam > 0) then begin
    putitem(tGER_OPERACAO, 'CD_REGRAFISCAL', vCdRegraFiscalParam);
  end;

  clear_e(tFIS_REGRAFISCAL);
  putitem_o(tFIS_REGRAFISCAL, 'CD_REGRAFISCAL', item_f('CD_REGRAFISCAL', tGER_OPERACAO));
  retrieve_e(tFIS_REGRAFISCAL);
  if (xStatus < 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN001', 'Regra fiscal ' + FloatToStr(vCdRegraFiscal) + ' n�o cadastrada!', cDS_METHOD);
    return(-1); exit;
  end;
  vCdCSTOperacao := Copy(item_a('CD_CST', tFIS_REGRAFISCAL), 1, 2);

  clear_e(tPES_PESSOA);
  putitem_o(tPES_PESSOA, 'CD_PESSOA', vCdPessoa);
  retrieve_e(tPES_PESSOA);
  if (xStatus < 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN001', 'Pessoa ' + FloatToStr(vCdPessoa) + ' n�o cadastrada!', cDS_METHOD);
    return(-1); exit;
  end;

  clear_e(tPES_PFADIC);
  putitem_o(tPES_PFADIC, 'CD_PESSOA', vCdPessoa);
  retrieve_e(tPES_PFADIC);
  if (xStatus < 0) then begin
    clear_e(tPES_PFADIC);
  end;

  if ((item_a('TP_OPERACAO', tGER_OPERACAO) = 'S') and (item_f('TP_MODALIDADE', tGER_OPERACAO) = 4))
  or ((item_a('TP_OPERACAO', tGER_OPERACAO) = 'E') and (item_f('TP_MODALIDADE', tGER_OPERACAO) = 3)) then begin //Venda / Devolu��o de venda
    clear_e(tPES_CLIENTE);
    putitem_o(tPES_CLIENTE, 'CD_CLIENTE', vCdPessoa);
    retrieve_e(tPES_CLIENTE);
    if (xStatus < 0) then begin
      Result := SetStatus(STS_ERROR, 'GEN001', 'Cliente ' + FloatToStr(vCdPessoa) + ' n�o cadastrado!', cDS_METHOD);
      return(-1); exit;
    end;
  end;

  // Implementado por Deusdete em 22/03/2007, situa��o emergencial na Krindges;
  // Se for pessoa Jur�dica e n�o tiver inscri��o estadual, isto �, Isento, dever� ser tratado para fazer o c�lculo do imposto then begin
  // com a al�quota interna.;
  gInPjIsento := False;
  if (item_a('NR_INSCESTL', tPES_PESJURIDICA) = 'ISENTO')
  or (item_a('NR_INSCESTL', tPES_PESJURIDICA) = 'ISENTA')
  or (item_a('NR_INSCESTL', tPES_PESJURIDICA) = 'ISENTOS')
  or (item_a('NR_INSCESTL', tPES_PESJURIDICA) = 'ISENTAS') then begin
    gInPjIsento := True;
  end;

  if (gTpOrigemEmissao = 2) then begin //Terceiros
    if (item_f('TP_MODALIDADE', tGER_OPERACAO) <> 3) then begin //Devolu��o
      vDsUF := gDsUFOrigem;
      gDsUFOrigem := gDsUFDestino;
      gDsUFDestino := vDsUF;
    end;
  end else begin
    if (item_f('TP_MODALIDADE', tGER_OPERACAO) = 3) and (item_a('TP_OPERACAO', tGER_OPERACAO) = 'S') then begin //Devolu��o compra
      vDsUF := gDsUFOrigem;
      gDsUFOrigem := gDsUFDestino;
      gDsUFDestino := vDsUF;
    end;
  end;

  viParams := '';
  putitemXml(viParams, 'CD_PESSOA', vCdPessoa);
  voParams := activateCmp('FCRSVCO057', 'validaPessoaOrgaoPublico', viParams);
  if (xStatus < 0) then begin
    Result := voParams;
    return(-1); exit;
  end;
  vInOrgaoPublico := itemXmlB('IN_ORGAOPUBLICO', voParams);

  if (vInOrgaoPublico = True) and (gDsUFOrigem = 'DF') then begin
    gInContribuinte := True;
  end else begin
    if (itemB('IN_CNSRFINAL', tPES_CLIENTE) = True) or (item_a('TP_PESSOA', tPES_PESSOA) = 'F') or (gInPjIsento = True) then begin
      if (itemB('IN_CNSRFINAL', tPES_CLIENTE) = True) and (item_a('TP_PESSOA', tPES_PESSOA) = 'J') and (gInPjIsento = False) then begin
        gInContribuinte := True;
      end else begin
        if (item_a('TP_PESSOA', tPES_PESSOA) = 'F')
        and (item_a('NR_CODIGOFISCAL', tPES_CLIENTE) <> '')
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
    vCdRegraFiscal := item_f('CD_REGRAFISCAL', tGER_OPERACAO);
    if (vCdRegraFiscal = 0) then begin
      Result := SetStatus(STS_ERROR, 'GEN001', 'Nenhuma regra fiscal cadastrada p/ a opera��o ' + FloatToStr(vCdOperacao) + '!', cDS_METHOD);
      return(-1); exit;
    end;
    vCdCST := '0';
  end else if (vCdMPTer <> '') then begin
    vInProdPropria := False;
    vCdRegraFiscal := item_f('CD_REGRAFISCAL', tGER_OPERACAO);
    if (vCdRegraFiscal = 0) then begin
      Result := SetStatus(STS_ERROR, 'GEN001', 'Nenhuma regra fiscal cadastrada p/ a opera��o ' + FloatToStr(vCdOperacao) + '!', cDS_METHOD);
      return(-1); exit;
    end;
    vCdCST := Copy(item_a('CD_CST', tCDF_MPTER), 1, 1);
  end else begin
    viParams := '';
    putitemXml(viParams, 'CD_EMPRESA', vCdEmpresaParam);
    putitemXml(viParams, 'CD_PRODUTO', vCdProduto);
    voParams := activateCmp('PRDSVCO007', 'buscaDadosFilial', viParams);
    if (xStatus < 0) then begin
      Result := voParams;
      return(-1); exit;
    end;
    vInProdPropria := itemXmlB('IN_PRODPROPRIA', voParams);

    clear_e(tPRD_PRDREGRAFISCAL);
    putitem_o(tPRD_PRDREGRAFISCAL, 'CD_PRODUTO', vCdProduto);
    putitem_o(tPRD_PRDREGRAFISCAL, 'CD_OPERACAO', vCdOperacao);
    retrieve_e(tPRD_PRDREGRAFISCAL);
    if (xStatus >= 0) then begin
      clear_e(tFIS_REGRAFISCAL);
      putitem_o(tFIS_REGRAFISCAL, 'CD_REGRAFISCAL', item_f('CD_REGRAFISCAL', tPRD_PRDREGRAFISCAL));
      retrieve_e(tFIS_REGRAFISCAL);
      if (xStatus < 0) then begin
        Result := SetStatus(STS_ERROR, 'GEN001', 'Regra fiscal ' + item_a('CD_REGRAFISCAL', tPRD_PRDREGRAFISCAL) + ' n�o cadastrada!', cDS_METHOD);
        return(-1); exit;
      end else begin
        if (item_f('CD_DECRETO', tFIS_REGRAFISCAL) = 2155)
        or (item_f('CD_DECRETO', tFIS_REGRAFISCAL) = 1020)
        or (item_f('CD_DECRETO', tFIS_REGRAFISCAL) = 45471)
        or (item_f('CD_DECRETO', tFIS_REGRAFISCAL) = 23731)
        or (item_f('CD_DECRETO', tFIS_REGRAFISCAL) = 23732)
        or (item_f('CD_DECRETO', tFIS_REGRAFISCAL) = 23733)
        or (item_f('CD_DECRETO', tFIS_REGRAFISCAL) = 23734)
        or (item_f('CD_DECRETO', tFIS_REGRAFISCAL) = 23735)
        or (item_f('CD_DECRETO', tFIS_REGRAFISCAL) = 10201)
        or (item_f('CD_DECRETO', tFIS_REGRAFISCAL) = 10202)
        or (item_f('CD_DECRETO', tFIS_REGRAFISCAL) = 10203) then begin
          if (gInContribuinte = True) then begin
            vCdRegraFiscal := item_f('CD_REGRAFISCAL', tPRD_PRDREGRAFISCAL);
          end else begin
            vCdRegraFiscal := item_f('CD_REGRAFISCAL', tGER_OPERACAO);
          end;
        end else begin
          vCdRegraFiscal := item_f('CD_REGRAFISCAL', tPRD_PRDREGRAFISCAL);
        end;
      end;
    end else begin
      vCdRegraFiscal := item_f('CD_REGRAFISCAL', tGER_OPERACAO);
    end  ;

    if (vCdRegraFiscal = 0) then begin
      Result := SetStatus(STS_ERROR, 'GEN001', 'Nenhuma regra fiscal cadastrada p/ o produto ' + FloatToStr(vCdProduto) + ' e a opera��o ' + FloatToStr(vCdOperacao) + '!', cDS_METHOD);
      return(-1); exit;
    end;

    vCdCST := Copy(item_a('CD_CST', tPRD_PRODUTO), 1, 1);
  end;

  if (vCdRegraFiscalParam > 0) then begin
    vCdRegraFiscal := vCdRegraFiscalParam;
  end;

  clear_e(tFIS_REGRAFISCAL);
  putitem_o(tFIS_REGRAFISCAL, 'CD_REGRAFISCAL', vCdRegraFiscal);
  retrieve_e(tFIS_REGRAFISCAL);
  if (xStatus < 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN001', 'Regra fiscal ' + FloatToStr(vCdRegraFiscal) + ' n�o cadastrada!', cDS_METHOD);
    return(-1); exit;
  end else begin
    if (item_f('CD_DECRETO', tFIS_REGRAFISCAL) = 2155) then begin
      if (gDsUFOrigem = 'PR') or (gDsUFOrigem = 'RS') or (gDsUFOrigem = 'SC') then begin
        if (gInContribuinte = True) and (item_f('TP_MODALIDADE', tGER_OPERACAO) = 4) then begin // 4 - Venda/Compra
          if (gDsUFDestino = 'PR') or (gDsUFDestino = 'RS') or (gDsUFDestino = 'SC') then begin
            vCdCST := Copy(item_a('CD_CST', tPRD_PRODUTO), 1, 1);
            vCdCST := vCdCST + '10';
            vInDecreto := True;
          end;
        end;
      end;
    end else if (item_f('CD_DECRETO', tFIS_REGRAFISCAL) = 1020)
             or (item_f('CD_DECRETO', tFIS_REGRAFISCAL) = 10201)
             or (item_f('CD_DECRETO', tFIS_REGRAFISCAL) = 10202)
             or (item_f('CD_DECRETO', tFIS_REGRAFISCAL) = 10203) then begin
      if (gDsUFOrigem = 'PR') or (gDsUFOrigem = 'SC') or (gDsUFOrigem = 'MG') then begin
        if (gInContribuinte = True) and (item_f('TP_MODALIDADE', tGER_OPERACAO) = 4) then begin // 4 - Venda/Compra
          if (gDsUFDestino = 'PR') or (gDsUFDestino = 'SC') or (gDsUFDestino = 'MG') then begin
            vCdCST := Copy(item_a('CD_CST', tPRD_PRODUTO), 1, 1);
            vCdCST := vCdCST + '10';
            vInDecreto := True;
          end;
        end;
      end;
    end else if (item_f('CD_DECRETO', tFIS_REGRAFISCAL) = 45471) then begin
      if (gDsUFOrigem = 'RS') or (gDsUFOrigem = 'PR') or (gDsUFOrigem = 'SC') then begin
        if (gInContribuinte = True) and (item_f('TP_MODALIDADE', tGER_OPERACAO) = 4) then begin // 4 - Venda/Compra
          if (gDsUFDestino = 'PR') or (gDsUFDestino = 'RS') or (gDsUFDestino = 'SC') then begin
            vCdCST := Copy(item_a('CD_CST', tPRD_PRODUTO), 1, 1);
            vCdCST := vCdCST + '10';
            vInDecreto := True;
          end;
        end;
      end;
    end else if (item_f('CD_DECRETO', tFIS_REGRAFISCAL) = 23731)
             or (item_f('CD_DECRETO', tFIS_REGRAFISCAL) = 23732)
             or (item_f('CD_DECRETO', tFIS_REGRAFISCAL) = 23733)
             or (item_f('CD_DECRETO', tFIS_REGRAFISCAL) = 23734)
             or (item_f('CD_DECRETO', tFIS_REGRAFISCAL) = 23735) then begin
      if (gDsUFOrigem = 'PR') or (gDsUFDestino = 'PR') then begin
        if (gInContribuinte = True) and (item_f('TP_MODALIDADE', tGER_OPERACAO) = 4) then begin // 4 - Venda/Compra
          vCdCST := Copy(item_a('CD_CST', tPRD_PRODUTO), 1, 1);
          vCdCST := vCdCST + '10';
          vInDecreto := True;
        end;
      end;
    end;
  end;

  if (vInDecreto = False) then begin
    vCdCST := vCdCST + Copy(item_a('CD_CST', tFIS_REGRAFISCAL), 1, 2);
    if (vTpAreaComercio > 0) then begin
      if (vTpAreaComercio = 2) and (vTpAreaComercioOrigem = 2) then begin // 2 - Manaus
      end else begin
        if (item_a('TP_OPERACAO', tGER_OPERACAO) = 'S') and (item_f('TP_MODALIDADE', tGER_OPERACAO) = 4) then begin //Venda
          vCdCST := Copy(item_a('CD_CST', tFIS_REGRAFISCAL), 1, 1);
          if (vCdCST = '1') or (vCdCST = '2') then begin // Produto inportado
            vCdCST := vCdCST + '00';
          end else begin
            vCdCST := vCdCST + '40';
          end;
        end;
      end;
    end;

    if (Copy(item_a('CD_CST', tFIS_REGRAFISCAL), 1, 2) = '70') then begin
      if (gDsUFOrigem = 'GO') then begin
        if (gDsUFOrigem <> gDsUFDestino) or (vInProdPropria <> True) or (gInContribuinte <> True) then begin
          vCdCST := Copy(item_a('CD_CST', tPRD_PRODUTO), 1, 1);
          vCdCST := vCdCST + '00';
        end;
      end;
    end;

    if (Copy(item_a('CD_CST', tFIS_REGRAFISCAL), 1, 2) = '60')   then begin
      vCdCST := Copy(item_a('CD_CST', tPRD_PRODUTO), 1, 1);
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

    if (Copy(item_a('CD_CST', tFIS_REGRAFISCAL), 1, 2) = '10') or (Copy(vCdCST,2,2) = '10') then begin
      vTpOperacao := item_a('TP_OPERACAO', tGER_OPERACAO);

      viParams := '';
      putitemXml(viParams, 'CD_PRODUTO', item_a('CD_PRODUTO', tPRD_PRODUTO));
      putitemXml(viParams, 'UF_ORIGEM', gDsUFOrigem);
      putitemXml(viParams, 'UF_DESTINO', gDsUFDestino);
      putitemXml(viParams, 'TP_OPERACAO', vTpOperacao);
      voParams := activateCmp('FISSVCO035', 'buscaDadosFiscalProduto', viParams);
      if (xStatus < 0) then begin
        Result := voParams;
        return(-1); exit;
      end;
      vPrIvaPrd := itemXmlF('PR_SUBSTRIB', voParams);

      if (vPrIvaPrd = 0) then begin
        vCdCST := Copy(item_a('CD_CST', tPRD_PRODUTO), 1, 1);
        vCdCST := vCdCST + vCdCSTOperacao;
      end else if (Copy(vCdCST,2,2) <> '10') then begin
        vCdCST := Copy(item_a('CD_CST', tPRD_PRODUTO), 1, 1);
        vCdCST := vCdCST + Copy(item_a('CD_CST', tFIS_REGRAFISCAL), 1, 2);
      end;
    end;

    if (gInContribuinte = True) and (Copy(vCdCST,2,2) = '20') then begin
      vInPrReducao := False;

      if (item_a('TP_REDUCAO', tFIS_REGRAFISCAL) = 'A') then begin
        if (gDsUFOrigem = gDsUFDestino) then begin
          vInPrReducao := True;
        end;

      end else if (item_a('TP_REDUCAO', tFIS_REGRAFISCAL) = 'B') then begin
        if (gDsUFOrigem = gDsUFDestino) then begin
          vInPrReducao := True;
        end;

      end else if (item_a('TP_REDUCAO', tFIS_REGRAFISCAL) = 'C') then begin
        if (gDsUFOrigem = gDsUFDestino) then begin
          vInPrReducao := True;
        end;

      end else if (item_a('TP_REDUCAO', tFIS_REGRAFISCAL) = 'D') then begin
        if (gDsUFOrigem <> gDsUFDestino) then begin
          vInPrReducao := True;
        end;

      end else if (item_a('TP_REDUCAO', tFIS_REGRAFISCAL) = 'E') then begin
        if (gDsUFOrigem <> gDsUFDestino) then begin
          vInPrReducao := True;
        end;

      end else if (item_a('TP_REDUCAO', tFIS_REGRAFISCAL) = 'F') then begin
        if (gDsUFOrigem <> gDsUFDestino) then begin
          vInPrReducao := True;
        end;

      end else if (item_a('TP_REDUCAO', tFIS_REGRAFISCAL) = 'G') then begin
        vInPrReducao := True;

      end else if (item_a('TP_REDUCAO', tFIS_REGRAFISCAL) = 'H') then begin
        vInPrReducao := True;

      end else if (item_a('TP_REDUCAO', tFIS_REGRAFISCAL) = 'I') then begin
        vInPrReducao := True;
      end;

      if (vInPrReducao = False) then begin
        vCdCST := Copy(item_a('CD_CST', tPRD_PRODUTO), 1, 1);
        vCdCST := vCdCST + '00';
      end;
    end;
  end;

  if (vCdCFOP = 5912) or (vCdCFOP = 1912) then begin
    vCdCST := Copy(item_a('CD_CST', tPRD_PRODUTO), 1, 1);
    if (gInOptSimples = True) then begin
      vCdCST := vCdCST + '41';
    end else begin
      vCdCST := vCdCST + '50';
    end;
  end else if (vCdCFOP = 6912) or (vCdCFOP = 2912) then begin
    vCdCST := Copy(item_a('CD_CST', tPRD_PRODUTO), 1, 1);
    if (gInOptSimples = True) then begin
      vCdCST := vCdCST + '41';
    end else begin
      vCdCST := vCdCST + '00';
    end;
  end;
  if ((itemB('IN_CNSRFINAL', tPES_CLIENTE) = True) or (gInContribuinte = False)) and (Copy(vCdCST,2,2) = '10') then begin
    if ((itemB('IN_CNSRFINAL', tPES_CLIENTE) = True) and (gInContribuinte = True))
    or (itemB('IN_AMBULANTE', tPES_PFADIC) = True) then begin
    end else begin
      vCdCST := Copy(item_a('CD_CST', tPRD_PRODUTO), 1, 1);
      vCdCST := vCdCST + '60';
    end;
  end;
  if (gCdServico > 0) and (itemB('IN_ISS', tFIS_REGRAFISCAL) = True) then begin
    vCdCST := '090';
  end;

  clear_e(tFIS_CST);
  putitem_o(tFIS_CST, 'CD_CST', vCdCST);
  retrieve_e(tFIS_CST);
  if (xStatus < 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN001', 'CST ' + vCdCST + ' n�o cadastrado!', cDS_METHOD);
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
  cDS_METHOD = 'ADICIONAL=Opera��o: T_FISSVCO015.calculaImpostoCapa()';
var
  viParams, voParams, vDsUF, vDsRegistro, vDsLstImposto, vDsLstCdImposto, vCdCST, vNmMunicipio : String;
  vCdEmpresa, vCdEmpresaParam, vCdOperacao, vCdPessoa, vCdRegraFiscal, vNrSeqEnd, vCdProduto : Real;
  vVlCalc, vVlBaseCalc, vCdImposto, vCdImpRetorno, vVlFrete, vVlSeguro, vVlDespAcessor, vCdDecreto : Real;
  vInIPI, vInSomaFrete, vInOrgaoPublico, vInSubstituicao : Boolean;
  vDtIniVigencia, vDtFimVigencia, vDtSistema : TDateTime;
begin
  Result := '';

  vCdEmpresa := itemXmlF('CD_EMPRESA', pParams);
  if (vCdEmpresa = 0) then begin
    vCdEmpresa := itemXmlF('CD_EMPRESA', PARAM_GLB);
  end;

  gDsUFOrigem := itemXml('UF_ORIGEM', PARAM_GLB);
  gDsUFDestino := itemXml('UF_DESTINO', pParams);
  gTpOrigemEmissao := itemXmlF('TP_ORIGEMEMISSAO', pParams); //1 - Pr�pria / 2 - Terceiros
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
    Result := SetStatus(STS_ERROR, 'GEN001', 'Tipo emiss�o n�o informado!', cDS_METHOD);
    return(-1); exit;
  end;
  if (gDsUFDestino = '') then begin
    Result := SetStatus(STS_ERROR, 'GEN001', 'UF destino n�o informada!', cDS_METHOD);
    return(-1); exit;
  end;
  if (vCdOperacao = 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN001', 'Opera��o n�o informada!', cDS_METHOD);
    return(-1); exit;
  end;

  clear_e(tPRD_PRODUTO);

  clear_e(tGER_OPERACAO);
  putitem_o(tGER_OPERACAO, 'CD_OPERACAO', vCdOperacao);
  retrieve_e(tGER_OPERACAO);
  if (xStatus < 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN001', 'Opera��o ' + FloatToStr(vCdOperacao) + ' n�o cadastrada!', cDS_METHOD);
    return(-1); exit;
  end;

  if (itemB('IN_CALCIMPOSTO', tGER_OPERACAO) <> True) then begin
    return(-1); exit;
  end;

  // Carrega o codigo do primeiro produto da nota fiscal para a nova logica de Subst. tributaria.
  if (vCdProduto <> 0) then begin
    clear_e(tPRD_PRODUTO);
    putitem_o(tPRD_PRODUTO, 'CD_PRODUTO', vCdProduto);
    retrieve_e(tPRD_PRODUTO);
    if (xStatus < 0) then begin
      Result := SetStatus(STS_ERROR, 'GEN001', 'Produto ' + FloatToStr(vCdProduto) + ' n�o cadastrado!', cDS_METHOD);
      return(-1); exit;
    end;

    //Inclu�do para calcular corretamente o imposto sobre os valores da capa
    viParams := '';
    putitemXml(viParams, 'CD_EMPRESA', vCdEmpresa);
    putitemXml(viParams, 'CD_PRODUTO', vCdProduto);
    voParams := activateCmp('PRDSVCO007', 'buscaDadosFilial', viParams); // PRDSVCO008
    if (xStatus < 0) then begin
      Result := voParams;
      return(-1); exit;
    end;
    gInProdPropria := itemXmlB('IN_PRODPROPRIA', voParams);
  end ;

  clear_e(tPES_PESSOA);
  putitem_o(tPES_PESSOA, 'CD_PESSOA', vCdPessoa);
  retrieve_e(tPES_PESSOA);
  if (xStatus < 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN001', 'Pessoa ' + FloatToStr(vCdPessoa) + ' n�o cadastrada!', cDS_METHOD);
    return(-1); exit;
  end;

  if ((item_a('TP_OPERACAO', tGER_OPERACAO) = 'S') and (item_f('TP_MODALIDADE', tGER_OPERACAO) = 4))
  or ((item_a('TP_OPERACAO', tGER_OPERACAO) = 'E') and (item_f('TP_MODALIDADE', tGER_OPERACAO) = 3)) then begin //Venda / Devolu��o de venda
    clear_e(tPES_CLIENTE);
    putitem_o(tPES_CLIENTE, 'CD_CLIENTE', vCdPessoa);
    retrieve_e(tPES_CLIENTE);
    if (xStatus < 0) then begin
      Result := SetStatus(STS_ERROR, 'GEN001', 'Cliente ' + FloatToStr(vCdPessoa) + ' n�o cadastrado!', cDS_METHOD);
      return(-1); exit;
    end;
  end;

  gInPjIsento := False;
  if (item_a('NR_INSCESTL', tPES_PESJURIDICA) = 'ISENTO')
  or (item_a('NR_INSCESTL', tPES_PESJURIDICA) = 'ISENTA')
  or (item_a('NR_INSCESTL', tPES_PESJURIDICA) = 'ISENTOS')
  or (item_a('NR_INSCESTL', tPES_PESJURIDICA) = 'ISENTAS') then begin
    gInPjIsento := True;
  end;

  gInVarejista := False;
  if (item_f('CD_ATIVIDADE', tPES_PESJURIDICA) = gCdAtividadeVarejista) and (gCdAtividadeVarejista <> 0) then begin
    gInVarejista := True;
  end;

  if (gTpOrigemEmissao = 2) then begin //Terceiros
    if (item_f('TP_MODALIDADE', tGER_OPERACAO) <> 3) then begin //Devolu��o
      vDsUF := gDsUFOrigem;
      gDsUFOrigem := gDsUFDestino;
      gDsUFDestino := vDsUF;
    end;
  end else begin
    if (item_f('TP_MODALIDADE', tGER_OPERACAO) = 3) and (item_a('TP_OPERACAO', tGER_OPERACAO) = 'S') then begin //Devolu��o compra
      vDsUF := gDsUFOrigem;
      gDsUFOrigem := gDsUFDestino;
      gDsUFDestino := vDsUF;
    end;
  end;

  viParams := '';
  putitemXml(viParams, 'CD_PESSOA', vCdPessoa);
  voParams := activateCmp('FCRSVCO057', 'validaPessoaOrgaoPublico', viParams);
  if (xStatus < 0) then begin
    Result := voParams;
    return(-1); exit;
  end;
  vInOrgaoPublico := itemXmlB('IN_ORGAOPUBLICO', voParams);

  if (vInOrgaoPublico = True) and (gDsUFOrigem = 'DF') then begin
    gInContribuinte := True;
  end else begin
     if (itemB('IN_CNSRFINAL', tPES_CLIENTE) = True) or (item_a('TP_PESSOA', tPES_PESSOA) = 'F') or (gInPjIsento = True) then begin
      if (itemB('IN_CNSRFINAL', tPES_CLIENTE) = True) and (item_a('TP_PESSOA', tPES_PESSOA) = 'J') and (gInPjIsento = False) then begin
        gInContribuinte := True;
      end else begin
        if (item_a('TP_PESSOA', tPES_PESSOA) = 'F')
        and (item_a('NR_CODIGOFISCAL', tPES_CLIENTE) <> '')
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
    viParams := '';
    putitemXml(viParams, 'CD_PESSOA', vCdPessoa);
    voParams := activateCmp('PESSVCO001', 'buscarEnderecoFat', viParams);
    if (itemXml('CD_PESSOA', voParams) <> '') then begin
      gTpAreaComercioDestino := itemXmlF('TP_AREA_COMERCIO', voParams);
    end;
  end;

  //A verifica��o de pessoa jur�dica foi comentado dentro do if e colocado aki, pois estava carregando a vari�vel gTpRegimeOrigem somente then begin
  //quando era emiss�o de terceiros. Esta vari�vel est� sendo usado tbm para emiss�o pr�pria no c�lculo do ICMS.
  if (item_a('TP_PESSOA', tPES_PESSOA) <> 'F') then begin
    if (empty(tPES_PESJURIDICA)) then begin
      Result := SetStatus(STS_ERROR, 'GEN001', 'Pessoa ' + FloatToStr(vCdPessoa) + ' n�o � jur�dica!', cDS_METHOD);
      return(-1); exit;
    end;
    gTpRegimeOrigem := item_f('TP_REGIMETRIB', tPES_PESJURIDICA);
  end;

  if (gInContribuinte = False) and (gDsUFDestino <> 'EX') then begin
    gDsUFDestino := gDsUFOrigem;
  end;

  if (gDsUFDestino = gDsUFOrigem) then begin
    if (gInSomaFreteBaseICMS = True) then begin
      vInSomaFrete := True;
    end else begin
      if (gTpOrigemEmissao = 1) and (gInContribuinte = False) then begin // 1 -Emiss�o pr�pria
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
    gVlIPI := Rounded(vVlCalc, 2);
  end;

  vCdRegraFiscal := item_f('CD_REGRAFISCAL', tGER_OPERACAO);

  clear_e(tPRD_PRDREGRAFISCAL);
  putitem_o(tPRD_PRDREGRAFISCAL, 'CD_PRODUTO', vCdProduto);
  putitem_o(tPRD_PRDREGRAFISCAL, 'CD_OPERACAO', vCdOperacao);
  retrieve_e(tPRD_PRDREGRAFISCAL);
  if (xStatus >= 0) then begin
    vCdRegraFiscal := item_f('CD_REGRAFISCAL', tPRD_PRDREGRAFISCAL);
  end;

  if (vCdRegraFiscal = 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN001', 'Nenhuma regra fiscal cadastrada p/ a opera��o ' + FloatToStr(vCdOperacao) + '!', cDS_METHOD);
    return(-1); exit;
  end;

  clear_e(tFIS_REGRAFISCAL);
  putitem_o(tFIS_REGRAFISCAL, 'CD_REGRAFISCAL', vCdRegraFiscal);
  retrieve_e(tFIS_REGRAFISCAL);
  if (xStatus < 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN001', 'Regra fiscal ' + FloatToStr(vCdRegraFiscal) + ' n�o cadastrada!', cDS_METHOD);
    return(-1); exit;
  end;

  if (vCdCST <> '') then begin
    gCdCST := vCdCST;
  end else begin
    gCdCST := '0' + item_a('CD_CST', tFIS_REGRAFISCAL);
  end;
  vCdCST := Copy(gCdCST,2,2);
  if (vCdCST = '10') or (vCdCST = '30') or (vCdCST = '60') or (vCdCST = '70') then begin
    vInSubstituicao := True;
  end;
  if (gCdDecretoItemCapa <> 0) then begin
    clear_e(tFIS_DECRETOCAPA);
    putitem_o(tFIS_DECRETOCAPA, 'CD_DECRETO', gCdDecretoItemCapa);
    retrieve_e(tFIS_DECRETOCAPA);
    if (xStatus >= 0) then begin
      vCdDecreto := item_f('CD_DECRETO', tFIS_DECRETOCAPA);
      vDtIniVigencia := item_d('DT_INIVIGENCIA', tFIS_DECRETOCAPA);
      vDtFimVigencia := item_d('DT_FIMVIGENCIA', tFIS_DECRETOCAPA);
    end;
  end else begin
    if (item_a('CD_DECRETO', tFIS_DECRETO) <> '') then begin
      vCdDecreto := item_f('CD_DECRETO', tFIS_DECRETO);
      vDtIniVigencia := item_d('DT_INIVIGENCIA', tFIS_DECRETO);
      vDtFimVigencia := item_d('DT_FIMVIGENCIA', tFIS_DECRETO);
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

  clear_e(tFIS_ALIQUOTAICMSUF);
  putitem_o(tFIS_ALIQUOTAICMSUF, 'CD_UFORIGEM', gDsUFOrigem);
  putitem_o(tFIS_ALIQUOTAICMSUF, 'CD_UFDESTINO', gDsUFDestino);
  retrieve_e(tFIS_ALIQUOTAICMSUF);
  if (xStatus < 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN001', 'Nenhuma al�quota cadastada de ' + gDsUfOrigem + ' para ' + gDsUFDestino + '!', cDS_METHOD);
    return(-1); exit;
  end;

  clear_e(tFIS_IMPOSTO);

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

  repeat
    vCdImposto := StrToFloat(getitemGld(vDsLstCdImposto, 1));

    vDtIniVigencia := 0;

    viParams := '';
    putitemXml(viParams, 'CD_IMPOSTO', vCdImposto);
    putitemXml(viParams, 'DT_INIVIGENCIA', itemXmlD('DT_INIVIGENCIA', pParams));
    voParams := activateCmp('FISSVCO069', 'retornaImposto', viParams);
    if (xStatus < 0) then begin
      Result := voParams;
      return(-1); exit;
    end;

    if (voParams <> '') then begin
      vDtIniVigencia := itemXmlD('DT_INIVIGENCIA', voParams);
      vCdImpRetorno := itemXmlF('CD_IMPOSTO', voParams);

      creocc(tFIS_IMPOSTO, -1);
      putitem_o(tFIS_IMPOSTO, 'CD_IMPOSTO', vCdImpRetorno);
      putitem_o(tFIS_IMPOSTO, 'DT_INIVIGENCIA', vDtIniVigencia);
      retrieve_o(tFIS_IMPOSTO);
      if (xStatus = -7) then begin
        retrieve_x(tFIS_IMPOSTO);
      end else if (xStatus < 0) then begin
        Result := SetStatus(STS_ERROR, 'GEN001', 'Imposto ' + FloatToStr(vCdImposto) + ' n�o cadastrado!', cDS_METHOD);
        return(-1); exit;
      end;

      if (vCdImposto = 1) then begin //ICMS;
        calculaICMS();
      end else if (vCdImposto = 2) then begin //ICMSSubst;
        calculaICMSSubst();
      end else if (vCdImposto = 3) then begin //IPI - Sa�da � calculado / Entrada � digitado na tela;
        calculaIPI();
      end else if (vCdImposto = 5) then begin //COFINS;
        calculaCOFINS();
      end else if (vCdImposto = 6) then begin //PIS/PASEP;
        calculaPIS();
      end;
    end;

    delitemGld(vDsLstCdImposto, 1);
  until (vDsLstCdImposto = '');

  vDsLstImposto := '';

  if (empty_e(tFIS_IMPOSTO) = 0) then begin
    sort_e(tFIS_IMPOSTO, 'CD_IMPOSTO');
    setocc(tFIS_IMPOSTO, 1);
    while (xStatus >=0) do begin
      if (item_f('CD_IMPOSTO', tFIS_IMPOSTO) > 0) then begin
        vDsRegistro := '';
        putlistitensocc_e(vDsRegistro, tFIS_IMPOSTO);
        putitem(vDsLstImposto, vDsRegistro);
      end;  
      setocc(tFIS_IMPOSTO, curocc(tFIS_IMPOSTO) + 1);
    end;
  end;

  clear_e(tFIS_CST);
  putitem_o(tFIS_CST, 'CD_CST', gCdCST);
  retrieve_e(tFIS_CST);
  if (xStatus < 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN001', 'CST ' + gCdCST + ' n�o cadastrado!', cDS_METHOD);
    return(-1); exit;
  end;

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
  cDS_METHOD = 'ADICIONAL=Opera��o: T_FISSVCO015.calculaImpostoItem()';
var
  viParams, voParams,
  vCdCST, vDsUF, vDsRegistro, vDsLstImposto, vDsLstCdImposto, vCdMPTer, vNmMunicipio : String;
  vCdEmpresa, vCdEmpresaParam, vCdProduto, vCdOperacao, vCdPessoa, vNrSeqEnd : Real;
  vCdImpRetorno, vCdImposto, vCdRegraFiscal : Real;
  vInOrgaoPublico, vInSubstituicao : Boolean;
  vDtIniVigencia : TDateTime;
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
    Result := SetStatus(STS_ERROR, 'GEN001', 'Tipo emiss�o n�o informado!', cDS_METHOD);
    return(-1); exit;
  end;
  if (gDsUFDestino = '') then begin
    Result := SetStatus(STS_ERROR, 'GEN001', 'UF destino n�o informada!', cDS_METHOD);
    return(-1); exit;
  end ;
  if (vCdOperacao = 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN001', 'Opera��o n�o informada!', cDS_METHOD);
    return(-1); exit;
  end;

  clear_e(tPRD_PRODUTO);

  clear_e(tGER_OPERACAO);
  putitem_o(tGER_OPERACAO, 'CD_OPERACAO', vCdOperacao);
  retrieve_e(tGER_OPERACAO);
  if (xStatus < 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN001', 'Opera��o ' + FloatToStr(vCdOperacao) + ' n�o cadastrada!', cDS_METHOD);
    return(-1); exit;
  end;

  if (vCdProduto = 0)
  and (vCdMPTer = '')
  and (gCdServico = 0) then begin
    return(0); exit;
  end;

  if (itemB('IN_CALCIMPOSTO', tGER_OPERACAO) <> True) then begin
    return(0); exit;
  end;

  if (gCdCST = '') then begin
    Result := SetStatus(STS_ERROR, 'GEN001', 'CST n�o informado!', cDS_METHOD);
    return(-1); exit;
  end;

  if (gInPDVOtimizado <> True) then begin
    if (gVlTotalBruto = 0) then begin
      Result := SetStatus(STS_ERROR, 'GEN001', 'Valor total bruto n�o informado p/ o produto ' + FloatToStr(vCdProduto) + '!', cDS_METHOD);
      return(-1); exit;
    end;

    if (gVlTotalLiquido = 0) then begin
      Result := SetStatus(STS_ERROR, 'GEN001', 'Valor total l�quido n�o informado p/ oproduto ' + FloatToStr(vCdProduto) + '!', cDS_METHOD);
      return(-1); exit;
    end;
  end;

  clear_e(tPES_PESSOA);
  putitem_o(tPES_PESSOA, 'CD_PESSOA', vCdPessoa);
  retrieve_e(tPES_PESSOA);
  if (xStatus < 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN001', 'Pessoa ' + FloatToStr(vCdPessoa) + ' n�o cadastrada!', cDS_METHOD);
    return(-1); exit;
  end;

  //Venda / Devolu��o de venda
  if ((item_a('TP_OPERACAO', tGER_OPERACAO) = 'S') and (item_a('TP_MODALIDADE', tGER_OPERACAO) = '4'))
  or ((item_a('TP_OPERACAO', tGER_OPERACAO) = 'E') and (item_a('TP_MODALIDADE', tGER_OPERACAO) = '3')) then begin
    clear_e(tPES_CLIENTE);
    putitem_o(tPES_CLIENTE, 'CD_CLIENTE', vCdPessoa);
    retrieve_e(tPES_CLIENTE);
    if (xStatus < 0) then begin
      Result := SetStatus(STS_ERROR, 'GEN001', 'Cliente ' + FloatToStr(vCdPessoa) + ' n�o cadastrado!', cDS_METHOD);
      return(-1); exit;
    end;
  end;

  gInPjIsento := False;
  if (item_a('NR_INSCESTL', tPES_PESJURIDICA) = 'ISENTO')
  or (item_a('NR_INSCESTL', tPES_PESJURIDICA) = 'ISENTA')
  or (item_a('NR_INSCESTL', tPES_PESJURIDICA) = 'ISENTOS')
  or (item_a('NR_INSCESTL', tPES_PESJURIDICA) = 'ISENTAS') then begin
    gInPjIsento := True;
  end;

  gInVarejista := False;
  if (item_f('CD_ATIVIDADE', tPES_PESJURIDICA) = gCdAtividadeVarejista) and (gCdAtividadeVarejista > 0) then begin
    gInVarejista := True;
  end;
  if (gTpOrigemEmissao = 2) then begin //Terceiros
    if (item_a('TP_MODALIDADE', tGER_OPERACAO) <> '3') then begin //Devolu��o
      vDsUF := gDsUFOrigem;
      gDsUFOrigem := gDsUFDestino;
      gDsUFDestino := vDsUF;
    end;
  end else begin
    if ((item_a('TP_MODALIDADE', tGER_OPERACAO) = '3') and (item_a('TP_OPERACAO', tGER_OPERACAO) = 'S')) then begin //Devolu��o compra
      vDsUF  := gDsUFOrigem;
      gDsUFOrigem := gDsUFDestino;
      gDsUFDestino := vDsUF;
    end;
  end;

  viParams := '';
  putitemXml(viParams, 'CD_PESSOA', vCdPessoa);
  voParams := activateCmp('FCRSVCO057', 'validaPessoaOrgaoPublico', viParams);
  if (xStatus < 0) then begin
    Result := voParams;
    return(-1); exit;
  end;
  vInOrgaoPublico := itemXmlB('IN_ORGAOPUBLICO', voParams);

  if (vInOrgaoPublico = True) and (gDsUFOrigem = 'DF') then begin
    gInContribuinte := True;
  end else begin
    if (itemB('IN_CNSRFINAL', tPES_CLIENTE) = True) or (item_a('TP_PESSOA', tPES_PESSOA) = 'F') or (gInPjIsento = True) then begin
      if (itemB('IN_CNSRFINAL', tPES_CLIENTE) = True) and (item_a('TP_PESSOA', tPES_PESSOA) = 'J') and (gInPjIsento = False) then begin
        gInContribuinte := True;
      end else begin
        if (item_a('TP_PESSOA', tPES_PESSOA) = 'F')
        and (item_a('NR_CODIGOFISCAL', tPES_CLIENTE) <> '')
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
    viParams := '';
    putitemXml(viParams, 'CD_PESSOA', vCdPessoa);
    voParams := activateCmp('PESSVCO001', 'buscarEnderecoFat', viParams);
    if (itemXml('CD_PESSOA', voParams) <> '') then begin
      gTpAreaComercioDestino := itemXmlF('TP_AREACOMERCIO', voParams);
    end;
  end;
  //Este retrieve foi comentado dentro do if e colocado aki, pois estava carregando a vari�vel gTpRegimeOrigem somente
  //quando era emiss�o de terceiros. Esta vari�vel est� sendo usado tbm para emiss�o pr�pria no c�lculo do ICMS.
  if (item_a('TP_PESSOA', tPES_PESSOA) <> 'F') then begin
    if (empty(tPES_PESJURIDICA)) then begin
      Result := SetStatus(STS_ERROR, 'GEN001', 'Pessoa ' + FloatToStr(vCdPessoa) + ' n�o � jur�dica!', cDS_METHOD);
      return(-1); exit;
    end;
    gTpRegimeOrigem := item_f('TP_REGIMETRIB', tPES_PESJURIDICA);
  end;

  if (gInContribuinte = False) and (gDsUFDestino <> 'EX') then begin
    gDsUFDestino := gDsUFOrigem;
  end;

  if (item_a('TP_MODALIDADE', tGER_OPERACAO) = 'D') and (gTpModDctoFiscal = 0) then begin // Condi��o implementada para o CIAP
    gTpModDctoFiscal := 85;
  end else if (item_a('TP_MODALIDADE', tGER_OPERACAO) = 'G') and (gTpModDctoFiscal = 0)  then begin
    gTpModDctoFiscal := 87 // Nota Fiscal CIAP;
  end;

  vCdRegraFiscal := 0;

  if (gCdServico > 0) then begin
    gInProdPropria := False;
    vCdRegraFiscal := item_f('CD_REGRAFISCAL', tGER_OPERACAO);
    if (vCdRegraFiscal = 0) then begin
      Result := SetStatus(STS_ERROR, 'GEN001', 'Nenhuma regra fiscal cadastrada p/ a opera��o ' + FloatToStr(vCdOperacao) + '!', cDS_METHOD);
      return(-1); exit;
    end;
  end else if (vCdMPTer <> '') then begin
    gInProdPropria := False;
    vCdRegraFiscal := item_f('CD_REGRAFISCAL', tGER_OPERACAO);
    if (vCdRegraFiscal = 0) then begin
      Result := SetStatus(STS_ERROR, 'GEN001', 'Nenhuma regra fiscal cadastrada p/ a opera��o ' + FloatToStr(vCdOperacao) + '!', cDS_METHOD);
      return(-1); exit;
    end;
  end else begin
    clear_e(tPRD_PRODUTO);
    putitem_o(tPRD_PRODUTO, 'CD_PRODUTO', vCdProduto);
    retrieve_e(tPRD_PRODUTO);
    if (xStatus < 0) then begin
      Result := SetStatus(STS_ERROR, 'GEN001', 'Produto ' + FloatToStr(vCdProduto) + ' n�o cadastrado!', cDS_METHOD);
      return(-1); exit;
    end;

    viParams := '';
    putitemXml(viParams, 'CD_EMPRESA', vCdEmpresa);
    putitemXml(viParams, 'CD_PRODUTO', vCdProduto);
    voParams := activateCmp('PRDSVCO007', 'buscaDadosFilial', viParams); // PRDSVCO008
    if (xStatus < 0) then begin
      Result := voParams;
      return(-1); exit;
    end;
    gInProdPropria := itemXmlB('IN_PRODPROPRIA', voParams);

    clear_e(tPRD_PRDREGRAFISCAL);
    putitem_o(tPRD_PRDREGRAFISCAL, 'CD_PRODUTO', vCdProduto);
    putitem_o(tPRD_PRDREGRAFISCAL, 'CD_OPERACAO', vCdOperacao);
    retrieve_e(tPRD_PRDREGRAFISCAL);
    if (xStatus >= 0) then begin
      vCdRegraFiscal := item_f('CD_REGRAFISCAL', tPRD_PRDREGRAFISCAL);
    end else begin
      vCdRegraFiscal := item_f('CD_REGRAFISCAL', tGER_OPERACAO);
    end;

    if (vCdRegraFiscal = 0) then begin
      Result := SetStatus(STS_ERROR, 'GEN001', 'Nenhuma regra fiscal cadastrada p/ o produto ' + FloatToStr(vCdProduto) + ' e a opera��o ' + FloatToStr(vCdOperacao) + '!', cDS_METHOD);
      return(-1); exit;
    end;
  end;

  clear_e(tFIS_REGRAFISCAL);
  putitem_o(tFIS_REGRAFISCAL, 'CD_REGRAFISCAL', vCdRegraFiscal);
  retrieve_e(tFIS_REGRAFISCAL);
  if (xStatus < 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN001', 'Regra fiscal ' + FloatToStr(vCdRegraFiscal) + ' n�o cadastrada!', cDS_METHOD);
    return(-1); exit;
  end;

  clear_e(tFIS_ALIQUOTAICMSUF);
  putitem_o(tFIS_ALIQUOTAICMSUF, 'CD_UFORIGEM', gDsUFOrigem);
  putitem_o(tFIS_ALIQUOTAICMSUF, 'CD_UFDESTINO', gDsUFDestino);
  retrieve_e(tFIS_ALIQUOTAICMSUF);
  if (xStatus < 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN001', 'Nenhuma al�quota cadastada de ' + gDsUfOrigem + ' para ' + gDsUFDestino + '!', cDS_METHOD);
    return(-1); exit;
  end;

  clear_e(tFIS_IMPOSTO);

  gVlICMS := 0;

  if (vDsLstCdImposto = '') then begin
    if (gCdServico > 0) then begin
      if (itemB('IN_ISS', tFIS_REGRAFISCAL) = True) then begin
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
    if (itemB('IN_IR', tFIS_REGRAFISCAL) = True) then begin  //27/02/2012 - N�o calcular IMPOSTO DE RENDA caso n�o esteja na regra
      putitem(vDsLstCdImposto, '7');
    end;
  end;

  vDsLstCdImposto := vDsLstCdImposto;

  repeat
    vCdImposto := StrToFloat(getitemGld(vDsLstCdImposto, 1));

    vDtIniVigencia := 0;

    viParams := '';
    putitemXml(viParams, 'CD_IMPOSTO', vCdImposto);
    putitemXml(viParams, 'DT_INIVIGENCIA', itemXmlD('DT_INIVIGENCIA', pParams));
    voParams := activateCmp('FISSVCO069', 'retornaImposto', viParams);
    if (xStatus < 0) then begin
      Result := voParams;
      return(-1); exit;
    end;

    if (voParams <> '') then begin
      vDtIniVigencia := itemXmlD('DT_INIVIGENCIA', voParams);
      vCdImpRetorno := itemXmlF('CD_IMPOSTO', voParams);

      creocc(tFIS_IMPOSTO, -1);
      putitem_o(tFIS_IMPOSTO, 'CD_IMPOSTO', vCdImpRetorno);
      putitem_o(tFIS_IMPOSTO, 'DT_INIVIGENCIA', vDtIniVigencia);
      retrieve_o(tFIS_IMPOSTO);
      if (xStatus = -7) then begin
        retrieve_x(tFIS_IMPOSTO);
      end else if (xStatus < 0) then begin
        Result := SetStatus(STS_ERROR, 'GEN001', 'Imposto ' + FloatToStr(vCdImposto) + ' n�o cadastrado!', cDS_METHOD);
        return(-1); exit;
      end;

      if (vCdImposto = 1) then begin //ICMS;
        calculaICMS();
      end else if (vCdImposto = 2) then begin //ICMSSubst;
        calculaICMSSubst();
      end else if (vCdImposto = 3) then begin //IPI - Sa�da � calculado / Entrada � digitado na tela;
        calculaIPI();
      end else if (vCdImposto = 5) then begin //COFINS;
        calculaCOFINS();
      end else if (vCdImposto = 6) then begin //PIS/PASEP;
        calculaPIS();
      end;
    end;

    delitemGld(vDsLstCdImposto, 1);
  until (vDsLstCdImposto = '');

  vDsLstImposto := '';

  if (empty_e(tFIS_IMPOSTO) = 0) then begin
    sort_e(tFIS_IMPOSTO, 'CD_IMPOSTO');
    setocc(tFIS_IMPOSTO, 1);
    while (xStatus >=0) do begin
      if (item_f('CD_IMPOSTO', tFIS_IMPOSTO) > 0) then begin
        vDsRegistro := '';
        putlistitensocc_e(vDsRegistro, tFIS_IMPOSTO);
        putitem(vDsLstImposto, vDsRegistro);
      end;
      setocc(tFIS_IMPOSTO, curocc(tFIS_IMPOSTO) + 1);
    end;
  end;

  clear_e(tFIS_IMPOSTO);

  clear_e(tFIS_CST);
  putitem_o(tFIS_CST, 'CD_CST', gCdCST);
  retrieve_e(tFIS_CST);
  if (xStatus < 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN001', 'CST ' + gCdCST + ' n�o cadastrado!', cDS_METHOD);
    return(-1); exit;
  end;

  Result := '';
  putitemXml(Result, 'CD_CST', gCdCST);
  putitemXml(Result, 'CD_DECRETO', gCdDecreto);
  putitemXml(Result, 'DS_LSTIMPOSTO', vDsLstImposto);
  return(0);
end;

initialization
  RegisterClass(T_FISSVCO015);

end.
