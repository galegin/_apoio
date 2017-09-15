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
  tGER_OPERACAO := TGER_OPERACAO.Create(nil);
  tPES_PESSOA := TPES_PESSOA.Create(nil);
  tPES_PESFISICA := TPES_PESFISICA.Create(nil);
  tPES_PESJURIDICA := TPES_PESJURIDICA.Create(nil);
  tPES_PESSOACLAS := TPES_PESSOACLAS.Create(nil);
  tPES_PFADIC := TPES_PFADIC.Create(nil);
  tPES_CLIENTE := TPES_CLIENTE.Create(nil);
  tPRD_PRODUTO := TPRD_PRODUTO.Create(nil);
  //tCDF_MPTER := TCDF_MPTER.Create(nil);
  tFIS_REGRAFISCAL := TFIS_REGRAFISCAL.Create(nil);
  tFIS_REGRASRV := TFIS_REGRASRV.Create(nil);
  tFIS_REGRAIMPOSTO := TFIS_REGRAIMPOSTO.Create(nil);
  tFIS_TIPI := TFIS_TIPI.Create(nil);
  tFIS_CST := TFIS_CST.Create(nil);
  //tFIS_INFOFISCAL := TFIS_INFOFISCAL.Create(nil);
  tPRD_PRDREGRAFISCAL := TPRD_PRDREGRAFISCAL.Create(nil);
  //tFIS_DECRETOCAPA := TFIS_DECRETOCAPA.Create(nil);
  tFIS_DECRETO := TFIS_DECRETO.Create(nil);
  tFIS_ALIQUOTAICMSUF := TFIS_ALIQUOTAICMSUF.Create(nil);
  tTMP_NR09 := TTMP_NR09.Create(nil);
  tFIS_IMPOSTO := TFIS_IMPOSTO.Create(nil);

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
  pCdEmpresa := pParams.CD_EMPRESA;
  if (pCdEmpresa = 0) then begin
    pCdEmpresa := PARAM_GLB.CD_EMPRESA;
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

  gCdEmpresaValorSis := xParam.CD_EMPVALOR;
  gCdClasRegEspecialSC := xParam.CD_CLAS_REG_ESPECIAL_SC;
  gCdAtividadeVarejista := xParam.CD_ATIVIDADE_VAREJISTA;
  gPrAliqICMSManaus := xParam.PR_ALIQ_ICMS_MANAUS;
  gInProdPropriaDec1643 := xParam.IN_PRODPROPRIA_DEC1643;
  gDsLstCfopIpiBcPisCof := xParam.DS_LST_CFOP_IPI_BC_PISCOF;

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

  gCdEmpresaValorEmp := xParamEmp.CD_EMPRESA_VALOR;
  gInOptSimples := xParamEmp.IN_OPT_SIMPLES;
  gInImpostoOffLine := xParamEmp.IN_IMPOSTO_OFFLINE;
  gInPDVOtimizado  := xParamEmp.IN_PDV_OTIMIZADO;
  gInAtivaDecreto52104 := xParamEmp.IN_ATIVA_DECRETO_52104;
  gNaturezaComercialEmp := xParamEmp.NATUREZA_COMERCIAL_EMP;
  gInSomaFreteBaseICMS := xParamEmp.IN_SOMA_FRETE_BASEICMS;
  gInCalcIpiOutEntSai := xParamEmp.IN_CALC_IPI_OUT_ENT_SAI;
  gInCalculaIcmsEntSimples := xParamEmp.IN_CALC_ICMS_ENT_SIMPLES;
  gPrAplicMvaSubTrib := xParamEmp.PR_APLIC_MVA_SUB_TRIB;
  gInArredondaTruncaIcms := xParamEmp.IN_ARREDONDA_TRUNCA_ICMS;
  gDsLstModDctoFiscalAT := xParamEmp.DS_LST_MODDCTOFISCAL_AT;
  gInDescontaPisCofinsAlc := xParamEmp.IN_DESCONTA_PISCOFINS_ALC;
  gInDescontaPisCofinsZfm := xParamEmp.IN_DESCONTA_PISCOFINS_ZFM;
  gInRedBaseIcms  := xParamEmp.IN_RED_BASE_ICMS;

  fTMP_NR09.Limpar();

  vDsLstCFOP := gDsLstCfopIpiBcPisCof;
  if (vDsLstCFOP <> '') then begin
    repeat
      vNrCFOP := IffNuloF(getitemGld(vDsLstCFOP,1),0);
      delitemGld(vDsLstCFOP,1);
      if (vNrCFOP > 0) then begin
        fTMP_NR09.Append();
        fTMP_NR09.NR_GERAL := vNrCFOP;
        fTMP_NR09.Consultar(nil);
      end;  
    until(vDsLstCFOP = '')
  end;

  return(0);
end;

//-----------------
function T_FISSVCO015.calculaICMS(pParams : String) : String;
//-----------------
const
  cDS_METHOD = 'ADICIONAL=Operação: FISSVCO015.calculaICMS()';
var
  vCdCST : String;
  vVlCalc, vVlBaseCalc, vCdDecreto, vTpProduto : Real;
  vDtSistema : TDateTime;
  vInDecreto, vInPrRedBase, vInPrRedImposto, vInReducao : Boolean;
begin

  vDtSistema := PARAM_GLB.DT_SISTEMA;

  if (gInImpostoOffLine) then begin
    fFIS_IMPOSTO.Remover();
    exit;
  end;

  gVlICMS := 0;
  gCdDecreto := 0;
  vCdDecreto := 0;
  vInDecreto := False;

  if (fFIS_DECRETO.CD_DECRETO > 0) then begin
    vCdDecreto := fFIS_DECRETO.CD_DECRETO;
    if (fFIS_DECRETO.DT_INIVIGENCIA > 0) and (vDtSistema < fFIS_DECRETO.DT_INIVIGENCIA) then begin
      vCdDecreto := 0;
    end;
    if (fFIS_DECRETO.DT_FIMVIGENCIA > 0) and (vDtSistema > fFIS_DECRETO.DT_FIMVIGENCIA) then begin
      vCdDecreto := 0;
    end;
  end;

  vCdCST := Copy(gCdCST,2,2);
  vTpProduto := StrToFloat(Copy(gCdCST,1,1));
  
  if (vCdCST = '60') then begin
    fFIS_IMPOSTO.Remover();
    gCdDecreto := vCdDecreto;
    exit;
  end else if (vCdCST <> '00') and (vCdCST <> '10') and (vCdCST <> '20') and (vCdCST <> '30') and (vCdCST <> '40') and (vCdCST <> '41') and (vCdCST <> '50') and (vCdCST <> '51') and (vCdCST <> '70') and (vCdCST <> '90') then begin
    if (vCdDecreto <> 2155) and (vCdDecreto <> 1020) and (vCdDecreto <> 45471) and (vCdDecreto <> 52364)
    and (vCdDecreto <> 23731) and (vCdDecreto <> 23732) and (vCdDecreto <> 23733) and (vCdDecreto <> 23734)
    and (vCdDecreto <> 23735) and (vCdDecreto <> 10901) and (vCdDecreto <> 10902) and (vCdDecreto <> 10903)
    and (vCdDecreto <> 10904) and (vCdDecreto <> 2559) and (vCdDecreto <> 52804)
    and (vCdDecreto <> 10201) and (vCdDecreto <> 10202) and (vCdDecreto <> 10203) then begin
      fFIS_IMPOSTO.Remover();
      gCdDecreto := vCdDecreto;
      exit;
    end;
  end;

  if (fFIS_REGRAFISCAL.TP_ALIQICMS = '') then begin
    if (fGER_OPERACAO.TP_MODALIDADE = 'E') then begin // Conhecimento de Frete
      fFIS_IMPOSTO.PR_ALIQUOTA := fFIS_REGRAFISCAL.PR_ALIQICMS;
    end else begin
      if (gTpAreaComercioOrigem = 2) and (gTpAreaComercioDestino = 2) then begin // 2 - Manaus
        fFIS_IMPOSTO.PR_ALIQUOTA := gPrAliqICMSManaus;
      end else begin
        if (gDsUFOrigem = 'MG') and (gDsUFDestino = 'MG')  then begin
          if (fFIS_REGRAFISCAL.PR_ALIQICMS > 0) and (gInContribuinte) and (gInProdPropria) then begin
            fFIS_IMPOSTO.PR_ALIQUOTA := fFIS_REGRAFISCAL.PR_ALIQICMS;
          end else begin
            fFIS_IMPOSTO.PR_ALIQUOTA := fFIS_ALIQUOTAICMSUF.PR_ALIQICMS;
          end;
        end else begin
          //A alíquota diferenciada so pode se aplicada em NF estadual
          //Nas outra é obrigatorio respeitar a aliquota interestadual
          //A observação acima somente é valido quando há somente uma alíquota interna.
          //A lógica abaixo foi implementada p/ atender o Estado do PR que passou a trabalhar com várias alíquotas internas
          //Neste caso será obedecido o que está na regra fiscal tanto dentro do Estado quanto fora,
          //desde que seja venda p/ consumidor final
          if (fFIS_REGRAFISCAL.PR_ALIQICMS > 0)  then begin
            if not (gDsUFOrigem = gDsUFDestino) or (gInContribuinte) then begin
              fFIS_IMPOSTO.PR_ALIQUOTA := fFIS_REGRAFISCAL.PR_ALIQICMS;
            end else begin
              fFIS_IMPOSTO.PR_ALIQUOTA := fFIS_ALIQUOTAICMSUF.PR_ALIQICMS;
            end;
          end else begin
            fFIS_IMPOSTO.PR_ALIQUOTA := fFIS_ALIQUOTAICMSUF.PR_ALIQICMS;
          end;
        end;
      end;
    end;
  end else begin
    if (fFIS_REGRAFISCAL.TP_ALIQICMS = 'A')then begin // Para transações de operação Estadual
      if (fFIS_REGRAFISCAL.PR_ALIQICMS > 0)  then begin
        if (gDsUFOrigem = gDsUFDestino) then begin
          fFIS_IMPOSTO.PR_ALIQUOTA := fFIS_REGRAFISCAL.PR_ALIQICMS;
        end else begin
          fFIS_IMPOSTO.PR_ALIQUOTA := fFIS_ALIQUOTAICMSUF.PR_ALIQICMS;
        end;
      end else begin
        fFIS_IMPOSTO.PR_ALIQUOTA := fFIS_ALIQUOTAICMSUF.PR_ALIQICMS;
      end;
    end else if (fFIS_REGRAFISCAL.TP_ALIQICMS = 'B')then begin // Para transações de operação Interestadual
      if (fFIS_REGRAFISCAL.PR_ALIQICMS > 0)  then begin
        if (gDsUFOrigem <> gDsUFDestino) then begin
          fFIS_IMPOSTO.PR_ALIQUOTA := fFIS_REGRAFISCAL.PR_ALIQICMS;
        end else begin
          fFIS_IMPOSTO.PR_ALIQUOTA := fFIS_ALIQUOTAICMSUF.PR_ALIQICMS;
        end;
      end else begin 
        fFIS_IMPOSTO.PR_ALIQUOTA := fFIS_ALIQUOTAICMSUF.PR_ALIQICMS;
      end;
    end else if (fFIS_REGRAFISCAL.TP_ALIQICMS = 'C')then begin // Para transações de ambas as operações
      if (fFIS_REGRAFISCAL.PR_ALIQICMS > 0)  then begin
        fFIS_IMPOSTO.PR_ALIQUOTA := fFIS_REGRAFISCAL.PR_ALIQICMS;
      end else begin 
        fFIS_IMPOSTO.PR_ALIQUOTA := fFIS_ALIQUOTAICMSUF.PR_ALIQICMS;
      end;
    end;
  end;
  //Emissão de terceiro e diferente de devolucao ou devolução de compra com emissão própria
  if ((gTpOrigemEmissao = 2) and (fGER_OPERACAO.TP_MODALIDADE <> '3'))
  or ((gTpOrigemEmissao = 1) and (fGER_OPERACAO.TP_MODALIDADE = '3') and (fGER_OPERACAO.TP_OPERACAO = 'S')) then begin
    if not (gInCalculaIcmsEntSimples) then begin
      if (gTpRegimeOrigem = 2) or (gTpRegimeOrigem = 3) then begin //2-Simples 3-EPP
        fFIS_IMPOSTO.PR_ALIQUOTA := 0;
      end;
    end;
    if (gTpOrigemEmissao = 1) then begin
      if (gInOptSimples) then begin
        fFIS_IMPOSTO.PR_ALIQUOTA := 0;
      end;
    end;
  end else begin
    if (gInOptSimples) then begin
      if (gDsUFOrigem <> 'PR')
      and ((fGER_OPERACAO.TP_DOCTO = 2) or (fGER_OPERACAO.TP_DOCTO = 3))
      and ((vCdCST = '00') or (vCdCST = '20') or (vCdCST = '51')) then begin // 2 - ECF - Nao concomitante / 3 - ECF - Concomitante;
      end else begin
        fFIS_IMPOSTO.PR_ALIQUOTA := 0;
      end;
    end;
  end;
 
  if (fGER_OPERACAO.TP_MODALIDADE = '4') and (fGER_OPERACAO.TP_OPERACAO = 'S')then begin // Venda
    if (vTpProduto = 1) then begin //Produto Importado
      if (gDsUFOrigem = 'ES') and (gDsUFDestino = 'ES') then begin
        if (gInContribuinte) then begin
          if (gInVarejista) then begin
            fFIS_IMPOSTO.PR_ALIQUOTA := fFIS_ALIQUOTAICMSUF.PR_ALIQICMS;
          end else begin
            fFIS_IMPOSTO.PR_ALIQUOTA := 12;
          end;
        end else begin
          fFIS_IMPOSTO.PR_ALIQUOTA := fFIS_ALIQUOTAICMSUF.PR_ALIQICMS;
        end;
      end;
    end;
  end;

  if (fGER_OPERACAO.TP_MODALIDADE = 4) and (fGER_OPERACAO.TP_OPERACAO = 'E') then begin // Compra
    if (gDsUFOrigem = 'SC') and (gDsUFDestino = 'SC') then begin
      if (gTpOrigemEmissao = 2) then begin // 2 - Emissao terceiro
        if (gTpRegimeOrigem = 2) or (gTpRegimeOrigem = 3) then begin //2-Simples 3-EPP
          fFIS_IMPOSTO.PR_ALIQUOTA := 7;
        end;
      end;
    end;
  end;
  if (vCdDecreto = 949) then begin // Este decreto foi revogado pelo decreto 6142 a partir de fevereiro/2006
    if (gDsUFOrigem = 'PR') then begin
      if (gTpOrigemEmissao = 1) then begin //Emissão própria
        if (gDsUFDestino = 'PR') and (gInContribuinte) then begin
          vInDecreto := True;
        end;
      end else begin 
        if (gDsUFDestino = 'PR') and (gInContribuinte) then begin
          vInDecreto := True;
        end;
      end;
    end;
    if (vInDecreto) then begin
      fFIS_IMPOSTO.PR_BASECALC := 66.67;
      vVlCalc := gVlTotalLiquidoICMS * fFIS_IMPOSTO.PR_BASECALC / 100;
      fFIS_IMPOSTO.VL_BASECALC := rounded(vVlCalc, 6);
      gVlTotalLiquidoICMS := gVlTotalLiquidoICMS - fFIS_IMPOSTO.VL_BASECALC;
      vCdCST := '20';
      gCdDecreto := vCdDecreto;
    end;
  end else if (vCdDecreto = 6692) then begin // Este decreto é somente para o Estado do Mato Grosso do Sul
    if (gDsUFOrigem = 'MS') then begin
      if (gDsUFDestino = 'MS') and (gInContribuinte) then begin
        vInDecreto := True;
      end;
      if (vInDecreto) then begin
        fFIS_IMPOSTO.PR_BASECALC := 41.176;
        vVlCalc := gVlTotalLiquidoICMS * fFIS_IMPOSTO.PR_BASECALC / 100;
        fFIS_IMPOSTO.VL_BASECALC := rounded(vVlCalc, 6);
        gVlTotalLiquidoICMS := gVlTotalLiquidoICMS - fFIS_IMPOSTO.VL_BASECALC;
        vCdCST := '20';
        gCdDecreto := vCdDecreto;
      end;
    end;
  end else if (vCdDecreto = 6142) then begin
    if (gInOptSimples <> True) then begin
      if (gDsUFOrigem = 'PR')   then begin
        if (gTpOrigemEmissao = 1) then begin //Emissão própria
          if (gDsUFDestino = 'PR') and (gInContribuinte) then begin
            vInDecreto := True;
          end;
        end else begin 
          if (gDsUFDestino = 'PR') and (gInContribuinte) then begin
            vInDecreto := True;
          end;
        end;
      end;
    end;
    if (vInDecreto) then begin
      gCdDecreto := vCdDecreto;
    end;
  end else if (vCdDecreto = 11589)  then begin
    if (gDsUFOrigem = 'PR') then begin
      if (gTpOrigemEmissao = 1) then begin //Emissão própria
        if (gDsUFDestino = 'PR') and (gInContribuinte) then begin
          vInDecreto := True;
        end;
      end else begin
        if (gDsUFDestino = 'PR') and (gInContribuinte) then begin
          vInDecreto := True;
        end;
      end;
    end;
    if (vInDecreto) then begin
      raise Exception.Create('Decreto(11.589) não contemplado na legislação tributária do Paraná! Entrar em contato com os Analistas da área Fiscal da VirtualAge' + ' / ' + cDS_METHOD);
      fFIS_IMPOSTO.PR_ALIQUOTA := 12;
      gCdDecreto := vCdDecreto;
      exit;
    end;
  end else if (vCdDecreto = 48786) or (vCdDecreto = 48958) or (vCdDecreto = 48959) or (vCdDecreto = 49115) then begin // O decreto 48042 foi substituido pelo 55652
    if (gDsUFOrigem = 'SP') then begin
      if (gTpOrigemEmissao = 1) then begin //Emissão própria
        //Venda / Devolução de venda
        if ((fGER_OPERACAO.TP_OPERACAO = 'S') and (fGER_OPERACAO.TP_MODALIDADE = 4))
        or ((fGER_OPERACAO.TP_OPERACAO = 'E') and (fGER_OPERACAO.TP_MODALIDADE = 3)) then begin
          if (gDsUFDestino = 'SP') and (gInContribuinte) then begin
            if (gInAtivaDecreto52104) then begin
              vInDecreto := True;
            end else begin
              if (gTpRegimeOrigem <> 2) and (gTpRegimeOrigem <> 3) then begin //2-Simples 3-EPP
                vInDecreto := True;
              end;
            end;
          end;
          if (gInProdPropria) then begin
          end else begin
            vInDecreto := False;
          end;
        end else begin
          if (gDsUFDestino = 'SP') and (gInContribuinte) then begin
            if (gInAtivaDecreto52104) then begin
              vInDecreto := True;
            end else begin
              if (gTpRegimeOrigem <> 2) and (gTpRegimeOrigem <> 3) then begin //2-Simples 3-EPP
                vInDecreto := True;
              end;
            end;
          end;
        end;
      end else begin
        if (gDsUFDestino = 'SP') and (gInContribuinte) then begin
          if (gInAtivaDecreto52104) then begin
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
    if (vInDecreto) then begin
      if (fFIS_IMPOSTO.PR_ALIQUOTA <> 18) and (fFIS_IMPOSTO.PR_ALIQUOTA <> 25) then begin
        vInDecreto := False;
      end;
    end;
    if (vInDecreto) then begin
      if (fFIS_IMPOSTO.PR_ALIQUOTA = 18) then begin
        fFIS_IMPOSTO.PR_BASECALC := 66.67;
      end else begin
        fFIS_IMPOSTO.PR_BASECALC := 48;
      end;
      vCdCST := '51';
      vVlCalc := gVlTotalLiquidoICMS * fFIS_IMPOSTO.PR_BASECALC / 100;
      fFIS_IMPOSTO.VL_BASECALC := rounded(vVlCalc, 6);
      gVlTotalLiquidoICMS := gVlTotalLiquidoICMS - fFIS_IMPOSTO.VL_BASECALC;
      gCdDecreto := vCdDecreto;
    end;
  end else if (vCdDecreto = 55652) then begin // Este decreto substitui o 48042
    if (gDsUFOrigem = 'SP') then begin
      if (gTpOrigemEmissao = 1) then begin //Emissão própria
        //Venda / Devolução de venda
        if ((fGER_OPERACAO.TP_OPERACAO = 'S') and (fGER_OPERACAO.TP_MODALIDADE = 4))
        or ((fGER_OPERACAO.TP_OPERACAO = 'E') and (fGER_OPERACAO.TP_MODALIDADE = 3)) then begin
          if (gDsUFDestino = 'SP') and (gInContribuinte) then begin
            if (gInAtivaDecreto52104) then begin
              vInDecreto := True;
            end else begin
              if (gTpRegimeOrigem <> 2) and (gTpRegimeOrigem <> 3) then begin //2-Simples 3-EPP
                vInDecreto := True;
              end;
            end;
          end;
          if (gInProdPropria) then begin
          end else begin
            vInDecreto := False;
          end;
        end else begin
          if (gDsUFDestino = 'SP') and (gInContribuinte) then begin
            if (gInAtivaDecreto52104) then begin
              vInDecreto := True;
            end else begin
              if (gTpRegimeOrigem <> 2) and (gTpRegimeOrigem <> 3) then begin //2-Simples 3-EPP
                vInDecreto := True;
              end;
            end;
          end;
        end;
      end else begin
        if (gDsUFDestino = 'SP') and (gInContribuinte) then begin
          if (gInAtivaDecreto52104) then begin
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
    if (vInDecreto) then begin
      if (fFIS_IMPOSTO.PR_ALIQUOTA <> 18) and (fFIS_IMPOSTO.PR_ALIQUOTA <> 25) then begin
        vInDecreto := False;
      end;
    end;
    if (vInDecreto) then begin
      if (fFIS_REGRAFISCAL.PR_REDUBASE > 0) then begin
        fFIS_IMPOSTO.PR_REDUBASE := fFIS_REGRAFISCAL.PR_REDUBASE;
        fFIS_IMPOSTO.PR_BASECALC := 100 - fFIS_REGRAFISCAL.PR_REDUBASE;
      end else begin
        if (fFIS_IMPOSTO.PR_ALIQUOTA = 18) then begin
          fFIS_IMPOSTO.PR_BASECALC := 38.89;
        end else begin
          fFIS_IMPOSTO.PR_BASECALC := 28;
        end;
      end;
      vCdCST := '51';
      vVlCalc := gVlTotalLiquidoICMS * fFIS_IMPOSTO.PR_BASECALC / 100;
      fFIS_IMPOSTO.VL_BASECALC := rounded(vVlCalc, 6);
      gVlTotalLiquidoICMS := gVlTotalLiquidoICMS - fFIS_IMPOSTO.VL_BASECALC;
      gCdDecreto := vCdDecreto;
    end;
  end else if (vCdDecreto = 2401) then begin
    if (gTpOrigemEmissao = 1) then begin //Emissão própria
      //Venda / Devolução de venda
      if ((fGER_OPERACAO.TP_OPERACAO = 'S') and (fGER_OPERACAO.TP_MODALIDADE = 4))
      or ((fGER_OPERACAO.TP_OPERACAO = 'E') and (fGER_OPERACAO.TP_MODALIDADE = 3)) then begin
        if (gDsUFDestino <> gDsUFOrigem) and (gInContribuinte) then begin
          vInDecreto := True;
        end;
      end else begin 
        if (gDsUFDestino <> gDsUFOrigem) and (gInContribuinte) then begin
          vInDecreto := True;
        end;
      end;
    end else begin
      if (gDsUFDestino <> gDsUFOrigem) and (gInContribuinte) then begin
        vInDecreto := True;
      end;
    end;
    if (vInDecreto) then begin
      if (fFIS_IMPOSTO.PR_ALIQUOTA <> 7) and (fFIS_IMPOSTO.PR_ALIQUOTA <> 12) then begin
        vInDecreto := False;
      end;
    end;
    if (vInDecreto) then begin
      if (fFIS_IMPOSTO.PR_ALIQUOTA = 7) then begin
        fFIS_IMPOSTO.PR_REDUBASE := 9.9;
      end else if (fFIS_IMPOSTO.PR_ALIQUOTA = 12) then begin
        fFIS_IMPOSTO.PR_REDUBASE := 10.49;
      end;
      vVlCalc := gVlTotalLiquidoICMS * fFIS_IMPOSTO.PR_REDUBASE / 100;
      fFIS_IMPOSTO.VL_BASECALC := gVlTotalLiquidoICMS - rounded(vVlCalc, 6);
      gVlTotalLiquidoICMS := rounded(vVlCalc, 6);
       vCdCST := '20';
      gCdDecreto := vCdDecreto;
    end;
  end else if (vCdDecreto = 1643) and ((gInProdPropriaDec1643 = False) or (gInProdPropria)) then begin
    if (gDsUFOrigem = 'ES') and (gDsUFDestino = 'ES') then begin
      if (gInContribuinte) and ((gTpRegimeOrigem = 2) or (gTpRegimeOrigem = 3))then begin // 2-Simples 3-EPP
        fFIS_IMPOSTO.PR_BASECALC := 41.177;
        fFIS_IMPOSTO.PR_REDUBASE := 58.823;
        vInDecreto := True;
      end else if (gInContribuinte) and (gTpRegimeOrigem <> 2) and (gTpRegimeOrigem <> 3)then begin // Empresa Normal
        if (gDsUFDestino <> gDsUFOrigem) then begin
          // Conforme consulta ao IOB pelo Sr. Deusdete, nao foi confirmado esta reducao para operacao interestadual
        end else begin
          fFIS_IMPOSTO.PR_BASECALC := 70.589;
          fFIS_IMPOSTO.PR_REDUBASE := 29.411;
          vInDecreto := True;
        end;
      end;

      if (vInDecreto) then begin
        vVlCalc := gVlTotalLiquidoICMS * fFIS_IMPOSTO.PR_BASECALC / 100;
        fFIS_IMPOSTO.VL_BASECALC := rounded(vVlCalc, 6);
        gVlTotalLiquidoICMS := gVlTotalLiquidoICMS - fFIS_IMPOSTO.VL_BASECALC;
        vCdCST := '20';
        gCdDecreto := vCdDecreto;
      end;
    end;
  end else if (vCdDecreto = 44238) then begin // Decreto valido para o estado do Rio Grande do Sul
    if (gDsUFOrigem = 'RS') and (gDsUFDestino = 'RS') then begin
      if (gInContribuinte)
      and ((fGER_OPERACAO.TP_MODALIDADE = '3') or (fGER_OPERACAO.TP_MODALIDADE = 4)) then begin // 3 - Devolucao / 4 - Venda/Compra
        if (gTpOrigemEmissao = 1) then begin //Emissão própria
          if (gInProdPropria) then begin
            fFIS_IMPOSTO.PR_BASECALC := 70.589;
            fFIS_IMPOSTO.PR_REDUBASE := 29.411;
            vInDecreto := True;
          end;
        end else begin
          fFIS_IMPOSTO.PR_BASECALC := 70.589;
          fFIS_IMPOSTO.PR_REDUBASE := 29.411;
          vInDecreto := True;
        end;
      end;

      if (vInDecreto) then begin
        vVlCalc := gVlTotalLiquidoICMS * fFIS_IMPOSTO.PR_BASECALC / 100;
        fFIS_IMPOSTO.VL_BASECALC := rounded(vVlCalc, 6);
        gVlTotalLiquidoICMS := gVlTotalLiquidoICMS - fFIS_IMPOSTO.VL_BASECALC;
        vCdCST := '20';
        gCdDecreto := vCdDecreto;
      end;
    end;
  end else if (vCdDecreto = 105) then begin // Decreto valido para o estado de Santa Catarina
    if (gDsUFOrigem = 'SC') then begin
      if (gDsUFDestino = 'SC') and (gInContribuinte)
      and (((fGER_OPERACAO.TP_OPERACAO = 'E') and (fGER_OPERACAO.TP_MODALIDADE = 4))
        or ((fGER_OPERACAO.TP_OPERACAO = 'S') and (fGER_OPERACAO.TP_MODALIDADE = 4))) then begin //Compra / Venda
        if (gCdClasRegEspecialSC <> '') then begin
          fPES_PESSOACLAS.Limpar();
          fPES_PESSOACLAS.CD_PESSOA := '';
          fPES_PESSOACLAS.CD_TIPOCLAS := gCdClasRegEspecialSC;
          fPES_PESSOACLAS.Listar(nil);
          if (fPES_PESSOACLAS.CD_CLASSIFICACAO = 'S') then begin
            fFIS_IMPOSTO.PR_ALIQUOTA := 12;
            vCdCST := '00';
            gCdDecreto := vCdDecreto;
            vInDecreto := True;
          end;
        end;
      end;
    end;
  end else if (vCdDecreto = 13214) then begin // Decreto valido para o estado do Paraná
    if (gDsUFOrigem = 'PR') or (gDsUFDestino = 'PR') then begin
      if (gInContribuinte) and (fGER_OPERACAO.TP_MODALIDADE = 4) then begin // Venda/Compra
        if (fFIS_IMPOSTO.PR_ALIQUOTA = 7) then begin
          fFIS_IMPOSTO.PR_BASECALC := 100;
          vInDecreto := True;
        end else if (fFIS_IMPOSTO.PR_ALIQUOTA = 12) then begin
          fFIS_IMPOSTO.PR_BASECALC := 58.332;
          fFIS_IMPOSTO.PR_REDUBASE := 41.668;
          vInDecreto := True;
        end else if (fFIS_IMPOSTO.PR_ALIQUOTA = 18) then begin
          fFIS_IMPOSTO.PR_BASECALC := 38.887;
          fFIS_IMPOSTO.PR_REDUBASE := 61.113;
          vInDecreto := True;
        end;
      end;

      if (vInDecreto) then begin
        vVlCalc := gVlTotalLiquidoICMS * fFIS_IMPOSTO.PR_BASECALC / 100;
        fFIS_IMPOSTO.VL_BASECALC := rounded(vVlCalc, 6);
        gVlTotalLiquidoICMS := gVlTotalLiquidoICMS - fFIS_IMPOSTO.VL_BASECALC;
        vCdCST := '20';
        gCdDecreto := vCdDecreto;
      end;
    end;
  end else if (vCdDecreto = 12462) then begin // Decreto valido para o estado de Goiás
    if (gDsUFOrigem = 'GO') and (gDsUFDestino = 'GO') then begin
      if (gInContribuinte)
      and ((fGER_OPERACAO.TP_MODALIDADE = 2) or (fGER_OPERACAO.TP_MODALIDADE = 3) or (fGER_OPERACAO.TP_MODALIDADE = 4)) then begin
        //2 - Transferencia / 3 - Devolucao / 4 - Venda/Compra
        fFIS_IMPOSTO.PR_BASECALC := 58.82;
        fFIS_IMPOSTO.PR_REDUBASE := 41.18;
        vInDecreto := True;
      end;

      if (vInDecreto) then begin
        vVlCalc := gVlTotalLiquidoICMS * fFIS_IMPOSTO.PR_BASECALC / 100;
        fFIS_IMPOSTO.VL_BASECALC := rounded(vVlCalc, 6);
        gVlTotalLiquidoICMS := gVlTotalLiquidoICMS - fFIS_IMPOSTO.VL_BASECALC;
        vCdCST := '20';
        gCdDecreto := vCdDecreto;
      end;
    end;
  end else begin
    gCdDecreto := vCdDecreto;
  end;

  if (vCdCST = '00') or (vCdCST = '10') then begin
    if (vCdDecreto = 52364)then begin // Decreto do Estado de São Paulo
      if (fFIS_REGRAFISCAL.PR_REDUBASE > 0) then begin
        fFIS_IMPOSTO.PR_REDUBASE := fFIS_REGRAFISCAL.PR_REDUBASE;
        fFIS_IMPOSTO.PR_BASECALC := 100 - fFIS_REGRAFISCAL.PR_REDUBASE;
        vVlCalc := gVlTotalLiquidoICMS - (gVlTotalLiquidoICMS * fFIS_IMPOSTO.PR_REDUBASE / 100);
        fFIS_IMPOSTO.VL_BASECALC := rounded(vVlCalc, 6);
      end else begin
        fFIS_IMPOSTO.PR_BASECALC := 100;
        fFIS_IMPOSTO.VL_BASECALC := gVlTotalLiquidoICMS;
      end;
      fFIS_IMPOSTO.VL_OUTRO := gVlTotalLiquidoICMS - fFIS_IMPOSTO.VL_BASECALC;
    end else if (vCdDecreto = 23731) or (vCdDecreto = 23732) or (vCdDecreto = 23733) or (vCdDecreto = 23734) or (vCdDecreto = 23735)then begin // Decreto do Estado do Paraná
      if (fFIS_REGRAFISCAL.PR_REDUBASE > 0) then begin
        fFIS_IMPOSTO.PR_REDUBASE := fFIS_REGRAFISCAL.PR_REDUBASE;
        fFIS_IMPOSTO.PR_BASECALC := 100 - fFIS_REGRAFISCAL.PR_REDUBASE;
        vVlCalc := gVlTotalLiquidoICMS - (gVlTotalLiquidoICMS * fFIS_IMPOSTO.PR_REDUBASE / 100);
        fFIS_IMPOSTO.VL_BASECALC := rounded(vVlCalc, 6);
      end else begin
        fFIS_IMPOSTO.PR_BASECALC := 100;
        fFIS_IMPOSTO.VL_BASECALC := gVlTotalLiquidoICMS;
      end;
      fFIS_IMPOSTO.VL_OUTRO := gVlTotalLiquidoICMS - fFIS_IMPOSTO.VL_BASECALC;
      gVlTotalLiquidoICMS := fFIS_IMPOSTO.VL_BASECALC;
    end else if (vCdDecreto = 10901) or (vCdDecreto = 10902) or (vCdDecreto = 10903) or (vCdDecreto = 10904)then begin // Decreto do Estado de Espirito Santo
      if (fFIS_REGRAFISCAL.PR_REDUBASE > 0) then begin
        if (gDsUFOrigem = 'ES') and (gDsUFDestino = 'ES') then begin
          fFIS_IMPOSTO.PR_BASECALC := 100;
          fFIS_IMPOSTO.VL_BASECALC := gVlTotalLiquidoICMS;
        end else begin
          fFIS_IMPOSTO.PR_REDUBASE := fFIS_REGRAFISCAL.PR_REDUBASE;
          fFIS_IMPOSTO.PR_BASECALC := 100 - fFIS_REGRAFISCAL.PR_REDUBASE;
          vVlCalc := gVlTotalLiquidoICMS - (gVlTotalLiquidoICMS * fFIS_IMPOSTO.PR_REDUBASE / 100);
          fFIS_IMPOSTO.VL_BASECALC := rounded(vVlCalc, 6);
        end;
      end else begin
        fFIS_IMPOSTO.PR_BASECALC := 100;
        fFIS_IMPOSTO.VL_BASECALC := gVlTotalLiquidoICMS;
      end;
      fFIS_IMPOSTO.VL_OUTRO := gVlTotalLiquidoICMS - fFIS_IMPOSTO.VL_BASECALC;
      gVlTotalLiquidoICMS := fFIS_IMPOSTO.VL_BASECALC;
    end else begin
      fFIS_IMPOSTO.PR_BASECALC := 100;
      fFIS_IMPOSTO.VL_BASECALC := gVlTotalLiquidoICMS;
      if ((gCdDecreto = 1643) and ((gInProdPropriaDec1643 = False) or (gInProdPropria))) or (gCdDecreto = 56066)then begin
        gCdDecreto := 0;
        vInDecreto := False;
      end;
    end;
    //Quando for substituiçao tributária não contemplada(CST 00) para não contribuinte não é aplicado o decreto
    if (vCdCST = '00')
    and ((fFIS_REGRAFISCAL.CD_CST = '10') or (fFIS_REGRAFISCAL.CD_CST = '60') or (fFIS_REGRAFISCAL.CD_CST = '70')) then begin
      gCdDecreto := 0;
    end;
    if (vCdCST = '10')
    and ((fGER_OPERACAO.TP_OPERACAO = 'E') and (fGER_OPERACAO.TP_MODALIDADE <> 3)) then begin // Entrada e não for devolução
      if (fFIS_IMPOSTO.VL_BASECALC > 0) then begin
        vVlCalc := fFIS_IMPOSTO.VL_BASECALC * fFIS_IMPOSTO.PR_ALIQUOTA / 100;
        gVlICMS := rounded(vVlCalc, 6);
      end;
      fFIS_IMPOSTO.VL_OUTRO := fFIS_IMPOSTO.VL_OUTRO + fFIS_IMPOSTO.VL_BASECALC;
      fFIS_IMPOSTO.VL_IMPOSTO := 0;
      fFIS_IMPOSTO.VL_BASECALC := 0;
      fFIS_IMPOSTO.PR_BASECALC := 0;
      fFIS_IMPOSTO.PR_REDUBASE := 0;
    end;
  end else if (vCdCST = '20') or (vCdCST = '70') or (vCdCST = '30') then begin
    if (vInDecreto) then begin
      if (vCdDecreto = 12462)
      or ((vCdDecreto = 1643) and ((gInProdPropriaDec1643 = False) or (gInProdPropria))) then begin
        fFIS_IMPOSTO.VL_ISENTO := gVlTotalLiquidoICMS;
      end else begin
        fFIS_IMPOSTO.VL_OUTRO := gVlTotalLiquidoICMS;
      end;
    end else begin
      vInReducao := False;
      if (fFIS_REGRAFISCAL.PR_REDUBASE > 0) and (gInContribuinte) then begin
        if (fGER_OPERACAO.TP_OPERACAO = 'S') then begin
          if ((gInRedBaseIcms) and (gInProdPropria))
          or (gInRedBaseIcms = False)
          or (fFIS_REGRAFISCAL.CD_CFOPPROPRIA = 5551)
          or (fGER_OPERACAO.TP_MODALIDADE = '3')
          or ((gTpOrigemEmissao = 1) and (gDsUFOrigem = 'RS')) then begin
            vInReducao := True;
            vCdDecreto := fFIS_DECRETO.CD_DECRETO;
            vInDecreto := True;
          end else begin
            vCdDecreto := 0;
            vInDecreto := False;
          end;
        end else begin
          if ((fGER_OPERACAO.TP_MODALIDADE <> '3') or ((fGER_OPERACAO.TP_MODALIDADE = '3') and ((gInRedBaseIcms) and (gInProdPropria)) or (gInRedBaseIcms = False)
          or ((gTpOrigemEmissao = 2) and (gDsUFDestino = 'RS')) then begin
            vInReducao := True;
            vCdDecreto := fFIS_DECRETO.CD_DECRETO;
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

      if (vInReducao) then begin
        vInPrRedBase := False;
        vInPrRedImposto := False;

        if (gInContribuinte) then begin
          if (fFIS_REGRAFISCAL.TP_REDUCAO = 'A') then begin
            if (gDsUFOrigem = gDsUFDestino) then begin
              vInPrRedBase := True;
              gCdDecreto := vCdDecreto;
            end;

          end else if (fFIS_REGRAFISCAL.TP_REDUCAO = 'B') then begin
            if (gDsUFOrigem = gDsUFDestino) then begin
              vInPrRedImposto := True;
              gCdDecreto := vCdDecreto;
            end;

          end else if (fFIS_REGRAFISCAL.TP_REDUCAO = 'C') then begin
            if (gDsUFOrigem = gDsUFDestino) then begin
              vInPrRedBase := True;
              vInPrRedImposto := True;
              gCdDecreto := vCdDecreto;
            end;

          end else if (fFIS_REGRAFISCAL.TP_REDUCAO = 'D') then begin
            if (gDsUFOrigem <> gDsUFDestino) then begin
              vInPrRedBase := True;
              gCdDecreto := vCdDecreto;
            end;

          end else if (fFIS_REGRAFISCAL.TP_REDUCAO = 'E') then begin
            if (gDsUFOrigem <> gDsUFDestino) then begin
              vInPrRedImposto := True;
              gCdDecreto := vCdDecreto;
            end;

          end else if (fFIS_REGRAFISCAL.TP_REDUCAO = 'F') then begin
            if (gDsUFOrigem <> gDsUFDestino) then begin
              vInPrRedBase := True;
              vInPrRedImposto := True;
              gCdDecreto := vCdDecreto;
            end;

          end else if (fFIS_REGRAFISCAL.TP_REDUCAO = 'G') then begin
            vInPrRedBase := True;
            gCdDecreto := vCdDecreto;

          end else if (fFIS_REGRAFISCAL.TP_REDUCAO = 'H') then begin
            vInPrRedImposto := True;
            gCdDecreto := vCdDecreto;

          end else if (fFIS_REGRAFISCAL.TP_REDUCAO = 'I') then begin
            vInPrRedBase := True;
            vInPrRedImposto := True;
            gCdDecreto := vCdDecreto;
          end;
        end else begin 
          vInPrRedBase := True;
          vInPrRedImposto := True;
        end;

        if (vInPrRedBase <> True) and (gCdDecreto <> 6142) then begin
          fFIS_IMPOSTO.PR_REDUBASE := 0;
          fFIS_IMPOSTO.PR_BASECALC := 100;
          vVlCalc := gVlTotalLiquidoICMS - (gVlTotalLiquidoICMS * fFIS_IMPOSTO.PR_REDUBASE / 100);
          fFIS_IMPOSTO.VL_BASECALC := rounded(vVlCalc, 6);
          gCdDecreto := 0;
          vInDecreto := False;
        end else begin
          fFIS_IMPOSTO.PR_REDUBASE := fFIS_REGRAFISCAL.PR_REDUBASE;
          fFIS_IMPOSTO.PR_BASECALC := 100 - fFIS_REGRAFISCAL.PR_REDUBASE;
          vVlCalc := gVlTotalLiquidoICMS - (gVlTotalLiquidoICMS * fFIS_IMPOSTO.PR_REDUBASE / 100);
          fFIS_IMPOSTO.VL_BASECALC := rounded(vVlCalc, 6);
        end;

      end else begin
        vCdCST := '00';
        fFIS_IMPOSTO.PR_BASECALC := 100;
        fFIS_IMPOSTO.VL_BASECALC := gVlTotalLiquidoICMS;
        if ((gCdDecreto = 1643)and((gInProdPropriaDec1643 = False)or(gInProdPropria))) or (gCdDecreto = 56066) then begin
          gCdDecreto := 0;
          vInDecreto := False;
        end;
      end;
      fFIS_IMPOSTO.VL_OUTRO := gVlTotalLiquidoICMS - fFIS_IMPOSTO.VL_BASECALC;
    end;
    if (vCdCST = '30') or (vCdCST = '70') then begin
      if (fGER_OPERACAO.TP_OPERACAO = 'E') or ((fGER_OPERACAO.TP_OPERACAO = 'S') and (gInOptSimples)) then begin
        if (fFIS_IMPOSTO.VL_BASECALC > 0) then begin
          vVlCalc := fFIS_IMPOSTO.VL_BASECALC * fFIS_IMPOSTO.PR_ALIQUOTA / 100;
          gVlICMS := rounded(vVlCalc, 6);
        end;
        fFIS_IMPOSTO.VL_OUTRO := fFIS_IMPOSTO.VL_OUTRO + fFIS_IMPOSTO.VL_BASECALC;
        fFIS_IMPOSTO.VL_IMPOSTO := 0;
        fFIS_IMPOSTO.VL_BASECALC := 0;
        fFIS_IMPOSTO.PR_BASECALC := 0;
        fFIS_IMPOSTO.PR_REDUBASE := 0;
      end;
    end;
    if not (vCdCST = '30') and (gInOptSimples) then begin
      gVlTotalLiquidoICMS := fFIS_IMPOSTO.VL_OUTRO + fFIS_IMPOSTO.VL_BASECALC;
      vVlCalc := gVlTotalLiquidoICMS * fFIS_IMPOSTO.PR_ALIQUOTA / 100;
      gVlICMS := rounded(vVlCalc, 6);
      fFIS_IMPOSTO.Remover();
      exit;
    end;
  end else if (vCdCST = '40') or (vCdCST = '41') then begin
    fFIS_IMPOSTO.PR_ALIQUOTA := 0;
    fFIS_IMPOSTO.VL_ISENTO := gVlTotalLiquidoICMS;
  end else if (vCdCST = '50') then begin
    fFIS_IMPOSTO.PR_ALIQUOTA := 0;
    fFIS_IMPOSTO.VL_OUTRO := gVlTotalLiquidoICMS;
  end else if (vCdCST = '51') then begin
    if (vInDecreto)  then begin
      fFIS_IMPOSTO.VL_OUTRO := gVlTotalLiquidoICMS;
    end else begin
      if (fFIS_REGRAFISCAL.PR_REDUBASE > 0) then begin
        fFIS_IMPOSTO.PR_REDUBASE := fFIS_REGRAFISCAL.PR_REDUBASE;
        vVlCalc := gVlTotalLiquidoICMS - (gVlTotalLiquidoICMS * fFIS_IMPOSTO.PR_REDUBASE / 100);
        fFIS_IMPOSTO.VL_BASECALC := rounded(vVlCalc, 6);
        fFIS_IMPOSTO.VL_OUTRO := gVlTotalLiquidoICMS - fFIS_IMPOSTO.VL_BASECALC;
      end else begin
        fFIS_IMPOSTO.VL_OUTRO := gVlTotalLiquidoICMS;
        fFIS_IMPOSTO.PR_ALIQUOTA := 0;
        fFIS_IMPOSTO.PR_BASECALC := 100;
      end;
    end;
  end else if (vCdCST = '60') then begin
    if (vInDecreto) then begin
      fFIS_IMPOSTO.PR_BASECALC := 100;
      fFIS_IMPOSTO.VL_BASECALC := gVlTotalLiquidoICMS;
    end;
  end else begin
    fFIS_IMPOSTO.VL_OUTRO := gVlTotalLiquidoICMS;
  end;
  // Move a base de calculo para outros quando for entrada de fornecedor optante pelo simples
  if (gTpOrigemEmissao = 2) and (fGER_OPERACAO.TP_MODALIDADE <> 3) then begin
    if (gDsUFOrigem = 'PR') or (gDsUFOrigem = 'MG') or (gDsUFOrigem = 'SP') or (gDsUFOrigem = 'RJ') or (gDsUFOrigem = 'CE') or (gDsUFOrigem = 'RS') then begin
      if (gTpRegimeOrigem = 2) or (gTpRegimeOrigem = 3) then begin //2-Simples 3-EPP
        fFIS_IMPOSTO.VL_OUTRO := fFIS_IMPOSTO.VL_OUTRO + fFIS_IMPOSTO.VL_BASECALC;
        fFIS_IMPOSTO.VL_BASECALC := 0;
      end;
    end;
  end;

  //Origem estrangeira - importacão direta
  if (fFIS_IMPOSTO.VL_BASECALC > 0) and (vTpProduto = 1)  then begin
    if ((fGER_OPERACAO.TP_OPERACAO = 'S') or (fGER_OPERACAO.TP_OPERACAO = 'E'))
    and ((fGER_OPERACAO.TP_MODALIDADE = 3) or (fGER_OPERACAO.TP_MODALIDADE = 'C')) then begin // Saída ou entrada por devolução ou C - Consignacao
      if (fPES_CLIENTE.IN_CNSRFINAL) then begin
        fFIS_IMPOSTO.VL_BASECALC := fFIS_IMPOSTO.VL_BASECALC + gVlIPI;
      end;
    end else begin
      fFIS_IMPOSTO.VL_BASECALC := fFIS_IMPOSTO.VL_BASECALC + gVlIPI;
    end;
  end;

  if (fFIS_IMPOSTO.VL_BASECALC > 0) then begin
    vVlCalc := fFIS_IMPOSTO.VL_BASECALC * fFIS_IMPOSTO.PR_ALIQUOTA / 100;
    fFIS_IMPOSTO.VL_IMPOSTO := rounded(vVlCalc, 6);
  end else begin
    fFIS_IMPOSTO.VL_IMPOSTO := 0;
  end;

  if (gCdDecreto = 6142)  then begin
    vVlCalc := fFIS_IMPOSTO.VL_IMPOSTO * 66.67 / 100;
    fFIS_IMPOSTO.VL_IMPOSTO := rounded(vVlCalc, 6);
  end else begin 
    if (vInPrRedImposto) and (fFIS_REGRAFISCAL.PR_REDUBASE > 0) then begin
      if (fFIS_REGRAFISCAL.TP_REDUCAO = 'B') or (fFIS_REGRAFISCAL.TP_REDUCAO = 'E') or (fFIS_REGRAFISCAL.TP_REDUCAO = 'H') then begin
        vVlCalc := (fFIS_IMPOSTO.VL_BASECALC * ((100 - fFIS_REGRAFISCAL.PR_REDUBASE)/100) * fFIS_IMPOSTO.PR_ALIQUOTA) / 100;
        fFIS_IMPOSTO.VL_IMPOSTO := rounded(vVlCalc, 6);
        gCdDecreto := vCdDecreto;
      end;

      if (fFIS_REGRAFISCAL.TP_REDUCAO = 'C') or (fFIS_REGRAFISCAL.TP_REDUCAO = 'F') or (fFIS_REGRAFISCAL.TP_REDUCAO = 'I') then begin
        vVlCalc := (fFIS_IMPOSTO.VL_IMPOSTO * (100 - fFIS_REGRAFISCAL.PR_REDUBASE)) / 100;
        fFIS_IMPOSTO.VL_IMPOSTO := rounded(vVlCalc, 6);
        gCdDecreto := vCdDecreto;
      end;
    end;
  end;

  if (gTpModDctoFiscal = 85) or (gTpModDctoFiscal = 87) then begin
    fFIS_IMPOSTO.VL_IMPOSTO := item_F('VL_BASECALC', tFIS_IMPOSTO);
    fFIS_IMPOSTO.VL_BASECALC := 0;
    fFIS_IMPOSTO.PR_REDUBASE := 0;
    fFIS_IMPOSTO.PR_BASECALC := 0;
    fFIS_IMPOSTO.PR_ALIQUOTA := 0;
    fFIS_IMPOSTO.VL_OUTRO := 0;
    fFIS_IMPOSTO.VL_ISENTO := 0;
  end;

  if (gVlICMS = 0) then begin
    gVlICMS := fFIS_IMPOSTO.VL_IMPOSTO;
  end;

  gCdCST := Copy(gCdCST,1,1) + vCdCST;

  //Zerar a alíquota se o CST=90 e o valor do ICMS for zero. then begin
  if (vCdCST = '90') and (gVlICMS = 0) then begin
    fFIS_IMPOSTO.PR_ALIQUOTA := 0;
  end;

  //Se a capa tiver Imposto sobre o Frete/Seguro/Desp.Acessoria será zerado o valor da Base de Calculo e jogado para o Vl.Outros.
  if (vCdCST = '90')
  and ((gVlFrete > 0) or (gVlSeguro > 0) or (gVlDespAcessor > 0))
  and (gVlICMS > 0) then begin
    fFIS_IMPOSTO.VL_OUTRO := fFIS_IMPOSTO.VL_BASECALC;
    fFIS_IMPOSTO.VL_IMPOSTO := 0;
    fFIS_IMPOSTO.PR_BASECALC := 0;
    fFIS_IMPOSTO.VL_BASECALC := 0;
    fFIS_IMPOSTO.PR_ALIQUOTA := 0;
  end;
  return(0);
end;

//----------------------
function T_FISSVCO015.calculaICMSSubst(pParams : String) : String;
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

  if (gInImpostoOffLine) then begin
    fFIS_IMPOSTO.Remover();
    exit;
  end;

  vDtSistema := PARAM_GLB.DT_SISTEMA;
  vTpProduto := StrToFloat(Copy(gCdCST,1,1));
  vCdCST := Copy(gCdCST,2,2);
  vTpOperacao := fGER_OPERACAO.TP_OPERACAO;

  if (vCdCST <> '10') and (vCdCST <> '30') and (vCdCST <> '60') and (vCdCST <> '70') then begin
    if (gCdDecreto = 2155) or (gCdDecreto = 1020) or (gCdDecreto = 45471) or (gCdDecreto = 23731)
    or (gCdDecreto = 23732) or (gCdDecreto = 23733) or (gCdDecreto = 23734) or (gCdDecreto = 23735)
    or (gCdDecreto = 10201) or (gCdDecreto = 10202) or (gCdDecreto = 10203) then begin
      gCdDecreto := 0;
    end;
    fFIS_IMPOSTO.Remover();
    exit;
  end;
  gCdDecreto := 0;
  vCdDecreto := 0;
  vInDecreto := False;

  if (gCdDecretoItemCapa <> 0) then begin
    fFIS_DECRETO.Limpar();
    fFIS_DECRETO.CD_DECRETO := gCdDecretoItemCapa;
    fFIS_DECRETO.Listar(nil);
    if (fFIS_DECRETO.CD_DECRETO > 0) then begin
      vCdDecreto := fFIS_DECRETO.CD_DECRETO;
      vDtIniVigencia := fFIS_DECRETO.DT_INIVIGENCIA;
      vDtFimVigencia := fFIS_DECRETO.DT_FIMVIGENCIA;
    end;
  end else begin
    if (fFIS_DECRETO.CD_DECRETO > 0) then begin
      vCdDecreto := fFIS_DECRETO.CD_DECRETO;
      vDtIniVigencia := fFIS_DECRETO.DT_INIVIGENCIA;
      vDtFimVigencia := fFIS_DECRETO.DT_FIMVIGENCIA;
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
  if (fFIS_REGRAFISCAL.PR_ALIQICMS > 0) and (gDsUFOrigem = gDsUFDestino) then begin
    fFIS_IMPOSTO.PR_ALIQUOTA := fFIS_REGRAFISCAL.PR_ALIQICMS;
  end else if (vCdDecreto > 0) then begin
    fFIS_ALIQUOTAICMSUF.Limpar();
    fFIS_ALIQUOTAICMSUF.CD_UFORIGEM := gDsUFDestino;
    fFIS_ALIQUOTAICMSUF.CD_UFDESTINO := gDsUFDestino;
    fFIS_ALIQUOTAICMSUF.Listar(nil);
    if (itemXmlF('status', voParams) < 0) then begin
      raise Exception.Create('Nenhuma alíquota cadastrada de ' + gDsUFDestino + ' para ' + gDsUFDestino + '!' + ' / ' + cDS_METHOD);
      exit;
    end;
    fFIS_IMPOSTO.PR_ALIQUOTA := fFIS_ALIQUOTAICMSUF.PR_ALIQICMS;
  end;

  vPrIVA := 30;

  //Emissão de terceiro e diferente de devolucao ou devolução de compra com emissão própria
  if ((gTpOrigemEmissao = 2) and (fGER_OPERACAO.TP_MODALIDADE <> 3))
  or ((gTpOrigemEmissao = 1) and (fGER_OPERACAO.TP_MODALIDADE = 3) and (fGER_OPERACAO.TP_OPERACAO = 'S')) then begin
    if (gDsUFOrigem = 'PR') or (gDsUFOrigem = 'SC') or (gDsUFOrigem = 'MG') or (gDsUFOrigem = 'SP') or (gDsUFOrigem = 'RJ') or (gDsUFOrigem = 'CE') then begin
      if (gTpRegimeOrigem = 2) or (gTpRegimeOrigem = 3) then begin //2-Simples 3-EPP
        fFIS_IMPOSTO.PR_ALIQUOTA := 0;
      end;
    end;
    if (gTpOrigemEmissao = 1) then begin
    end;
  end else begin
  end;

  if (vCdDecreto = 2155) then begin // Decreto do Estado do Parana
    if (gDsUFOrigem = 'PR') or (gDsUFOrigem = 'RS') or (gDsUFOrigem = 'SC') then begin
      if (gInContribuinte) and (fGER_OPERACAO.TP_MODALIDADE = 4) then begin // 4 - Venda/Compra
        if (gDsUFDestino = 'PR') or (gDsUFDestino = 'RS') or (gDsUFDestino = 'SC') then begin
          vPrIVA := 65.86;
          vInDecreto := True;
        end;
      end;
    end;

    if (vInDecreto) then begin
      if (fFIS_REGRAFISCAL.PR_ALIQICMS > 0) and (gDsUFOrigem = 'PR') and (gDsUFDestino = 'PR') then begin
        fFIS_IMPOSTO.PR_ALIQUOTA := fFIS_REGRAFISCAL.PR_ALIQICMS;
      end else begin
        fFIS_ALIQUOTAICMSUF.Limpar();
        fFIS_ALIQUOTAICMSUF.CD_UFORIGEM := gDsUFDestino;
        fFIS_ALIQUOTAICMSUF.CD_UFDESTINO := gDsUFDestino;
        fFIS_ALIQUOTAICMSUF.Listar(nil);
        if (itemXmlF('status', voParams) < 0) then begin
          raise Exception.Create('Nenhuma alíquota cadastrada de ' + gDsUFDestino + ' para ' + gDsUFDestino + '!' + ' / ' + cDS_METHOD);
          exit;
        end;
        fFIS_IMPOSTO.PR_ALIQUOTA := fFIS_ALIQUOTAICMSUF.PR_ALIQICMS;
      end;

      vVlCalc := gVlTotalLiquidoICMS + gVlIPI + ((gVlTotalLiquidoICMS + gVlIPI) * vPrIVA) / 100 ;
      fFIS_IMPOSTO.VL_BASECALC := rounded(vVlCalc, 6);
      fFIS_IMPOSTO.PR_BASECALC := 100;

      vVlCalc := fFIS_IMPOSTO.VL_BASECALC * (fFIS_IMPOSTO.PR_ALIQUOTA / 100);
      vVlICMS := rounded(vVlCalc, 6) ;
      fFIS_IMPOSTO.VL_IMPOSTO := vVlICMS - gVlICMS;
      gCdDecreto := vCdDecreto;
    end;
  end else if (vCdDecreto = 1020) or (vCdDecreto = 10201) or (vCdDecreto = 10202) or (vCdDecreto = 10203) then begin // Decreto do Estado de Santa Catarina
    if (gDsUFOrigem = 'PR') or (gDsUFOrigem = 'SC') or (gDsUFOrigem = 'MG') then begin //Incluído o Estado de MG
      if (gInContribuinte) and (fGER_OPERACAO.TP_MODALIDADE = 4) then begin // 4 - Venda/Compra
        if (gDsUFDestino = 'PR') or (gDsUFDestino = 'SC') or (gDsUFDestino = 'MG') then begin //Incluído o Estado de MG
          if (vCdDecreto = 1020 then begin
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

    if (vInDecreto) then begin
      fFIS_ALIQUOTAICMSUF.Limpar();
      fFIS_ALIQUOTAICMSUF.CD_UFORIGEM := gDsUFOrigem;
      fFIS_ALIQUOTAICMSUF.CD_UFDESTINO := gDsUFDestino;
      fFIS_ALIQUOTAICMSUF.Listar(nil);
      if (itemXmlF('status', voParams) < 0) then begin
        raise Exception.Create('Nenhuma alíquota cadastrada de ' + gDsUFOrigem + ' para ' + gDsUFDestino + '!' + ' / ' + cDS_METHOD);
        exit;
      end;
      vVlAliquotaInter := fFIS_ALIQUOTAICMSUF.PR_ALIQICMS;

      viParams := '';
      viParams.CD_PRODUTO := fPRD_PRODUTO.CD_PRODUTO;
      viParams.UF_ORIGEM := gDsUFOrigem;
      viParams.UF_DESTINO := gDsUFDestino;
      viParams.TP_OPERACAO := vTpOperacao;
      voParams := activateCmp('FISSVCO035', 'buscaDadosFiscalProduto', viParams);
      if (itemXmlF('status', voParams) < 0) then begin
        raise Exception.Create(itemXml('message', voParams));
        exit;
      end;
      vVlAliquotaIntra := voParams.PR_ICMS;

      if (vVlAliquotaIntra = 0) then begin
        fFIS_ALIQUOTAICMSUF.Limpar();
        fFIS_ALIQUOTAICMSUF.CD_UFORIGEM := gDsUFDestino;
        fFIS_ALIQUOTAICMSUF.CD_UFDESTINO := gDsUFDestino;
        fFIS_ALIQUOTAICMSUF.Listar(nil);
        if (itemXmlF('status', voParams) < 0) then begin
          raise Exception.Create('Nenhuma alíquota cadastrada de ' + gDsUFDestino + ' para ' + gDsUFDestino + '!' + ' / ' + cDS_METHOD);
          exit;
        end;
        vVlAliquotaIntra := fFIS_ALIQUOTAICMSUF.PR_ALIQICMS;
      end;
      if (gDsUFDestino <> gDsUFOrigem) then begin
        vPrIVA := ((1 + (vPrIVA/100)) * ((1 - (vVlAliquotaInter/100)) / (1 - (vVlAliquotaIntra/100))) -1) * 100;
      end;
      if (fFIS_REGRAFISCAL.PR_ALIQICMS > 0) then begin
        fFIS_IMPOSTO.PR_ALIQUOTA := fFIS_REGRAFISCAL.PR_ALIQICMS;
      end else begin
        fFIS_IMPOSTO.PR_ALIQUOTA := fFIS_ALIQUOTAICMSUF.PR_ALIQICMS;
      end;
      vVlCalc := gVlTotalLiquidoICMS + gVlIPI + ((gVlTotalLiquidoICMS + gVlIPI) * vPrIVA) / 100;
      fFIS_IMPOSTO.VL_BASECALC := rounded(vVlCalc, 6);
      fFIS_IMPOSTO.PR_BASECALC := 100;
      vVlCalc := fFIS_IMPOSTO.VL_BASECALC * (fFIS_IMPOSTO.PR_ALIQUOTA / 100);
      vVlICMS := rounded(vVlCalc, 6) ;
      fFIS_IMPOSTO.VL_IMPOSTO := vVlICMS - gVlICMS;
      gCdDecreto := vCdDecreto;
    end;
  end else if (vCdDecreto = 45471) then begin // Decreto do Estado do Rio Grande do Sul
    if (gDsUFOrigem = 'RS') or (gDsUFOrigem = 'PR') or (gDsUFOrigem = 'SC') then begin
      if (gInContribuinte) and (fGER_OPERACAO.TP_MODALIDADE = 4)then begin // 4 - Venda/Compra
        if (gDsUFDestino = 'PR') or (gDsUFDestino = 'RS')  or (gDsUFDestino = 'SC') then begin
          vPrIVA := 65.86;
          vInDecreto := True;
        end;
      end;
    end;

    if (vInDecreto) then begin
      fFIS_ALIQUOTAICMSUF.Limpar();
      fFIS_ALIQUOTAICMSUF.CD_UFORIGEM := gDsUFDestino;
      fFIS_ALIQUOTAICMSUF.CD_UFDESTINO := gDsUFDestino;
      fFIS_ALIQUOTAICMSUF.Listar(nil);
      if (itemXmlF('status', voParams) < 0) then begin
        raise Exception.Create('Nenhuma alíquota cadastrada de ' + gDsUFOrigem + ' para ' + gDsUFDestino + '!' + ' / ' + cDS_METHOD);
        exit;
      end;
      vVlCalc := gVlTotalLiquidoICMS + gVlIPI + ((gVlTotalLiquidoICMS + gVlIPI) * vPrIVA) / 100 ;
      fFIS_IMPOSTO.VL_BASECALC := rounded(vVlCalc, 6);
      fFIS_IMPOSTO.PR_BASECALC := 100;
      vVlCalc := fFIS_IMPOSTO.VL_BASECALC * (fFIS_ALIQUOTAICMSUF.PR_ALIQICMS / 100);
      vVlICMS := rounded(vVlCalc, 6) ;
      fFIS_IMPOSTO.PR_ALIQUOTA := fFIS_ALIQUOTAICMSUF.PR_ALIQICMS;
      fFIS_IMPOSTO.VL_IMPOSTO := vVlICMS - gVlICMS;
      gCdDecreto := vCdDecreto;
    end;
  end else if (vCdDecreto = 52364)then begin // Decreto do Estado de São Paulo
    if (gDsUFOrigem = 'SP') or (gDsUFDestino = 'SP') then begin
      if ((fGER_OPERACAO.TP_OPERACAO = 'E') and (fGER_OPERACAO.TP_MODALIDADE = 4))
      or ((fGER_OPERACAO.TP_OPERACAO = 'S') and (fGER_OPERACAO.TP_MODALIDADE = 3)) then begin // 4 - Compra / 3 - Devolução
        // Aliquota aplicada pelo Fornecedor
        fFIS_ALIQUOTAICMSUF.Limpar();
        fFIS_ALIQUOTAICMSUF.CD_UFORIGEM := gDsUFOrigem;
        fFIS_ALIQUOTAICMSUF.CD_UFDESTINO := gDsUFDestino;
        fFIS_ALIQUOTAICMSUF.Listar(nil);
        if (itemXmlF('status', voParams) < 0) then begin
          raise Exception.Create('Nenhuma alíquota cadastrada de ' + gDsUFOrigem + ' para ' + gDsUFDestino + '!' + ' / ' + cDS_METHOD);
          exit;
        end;

        // Aliquota interna de SP
        if (fFIS_REGRAFISCAL.PR_ALIQICMS > 0) then begin
          vVlAliquotaIntra := fFIS_REGRAFISCAL.PR_ALIQICMS ;
        end else begin 
          vVlAliquotaIntra := fFIS_ALIQUOTAICMSUF.PR_ALIQICMS;
        end;
        vVlAliquotaInter := fFIS_ALIQUOTAICMSUF.PR_ALIQICMS; // Aliquota aplicada pelo Fornecedor

        if (fFIS_IMPOSTO.PR_ALIQUOTA = 12) or (fFIS_IMPOSTO.PR_ALIQUOTA = 18) then begin
          if (gDsUFOrigem = 'SP') and (gDsUFDestino = 'SP') then begin
            vPrIVA := 38.90 ;
          end else begin 
            vPrIVA := ((1 + (38.90/100)) * ((1 - (vVlAliquotaInter/100)) / (1 - (vVlAliquotaIntra/100))) -1) * 100;
          end;
          vInDecreto := True;
        end else if (fFIS_IMPOSTO.PR_ALIQUOTA = 25) then begin
          if (gDsUFOrigem = 'SP') and (gDsUFDestino = 'SP') then begin
            vPrIVA := 71.60 ;
          end else begin 
            vPrIVA := ((1 + (71.60/100)) * ((1 - (vVlAliquotaInter/100)) / (1 - (vVlAliquotaIntra/100))) -1) * 100;
          end;
          vInDecreto := True;
        end;
      end;
    end;

    if (vInDecreto) then begin
      vVlCalc := gVlTotalLiquidoICMS + gVlIPI + ((gVlTotalLiquidoICMS + gVlIPI) * vPrIVA) / 100 ;
      fFIS_IMPOSTO.VL_BASECALC := rounded(vVlCalc, 6);
      fFIS_IMPOSTO.PR_BASECALC := 100;
      vVlCalc := fFIS_IMPOSTO.VL_BASECALC * (vVlAliquotaIntra / 100);
      vVlICMS := rounded(vVlCalc, 6) ;
      fFIS_IMPOSTO.PR_ALIQUOTA := vVlAliquotaIntra;
      fFIS_IMPOSTO.VL_IMPOSTO := (gVlTotalLiquidoICMS + gVlIPI) * (1 + (vPrIVA / 100)) * (vVlAliquotaIntra/100) - gVlICMS;
      gCdDecreto := vCdDecreto;
    end;
  end else if (vCdDecreto = 23731) or (vCdDecreto = 23732) or (vCdDecreto = 23733) or (vCdDecreto = 23734) or (vCdDecreto = 23735)then begin // Decreto do Estado do Paraná
    if (gDsUFOrigem = 'PR') or (gDsUFDestino = 'PR') then begin
      if (gInContribuinte) and (fGER_OPERACAO.TP_MODALIDADE = 4) then begin // 4 - Venda/Compra
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

    if (vInDecreto) then begin
      if (fFIS_REGRAFISCAL.PR_ALIQICMS > 0) and (gDsUFOrigem = 'PR') and (gDsUFDestino = 'PR') then begin
        fFIS_IMPOSTO.PR_ALIQUOTA := fFIS_REGRAFISCAL.PR_ALIQICMS;
      end else begin
        fFIS_ALIQUOTAICMSUF.Limpar();
        fFIS_ALIQUOTAICMSUF.CD_UFORIGEM := gDsUFDestino;
        fFIS_ALIQUOTAICMSUF.CD_UFDESTINO := gDsUFDestino;
        fFIS_ALIQUOTAICMSUF.Listar(nil);
        if (itemXmlF('status', voParams) < 0) then begin
          raise Exception.Create('Nenhuma alíquota cadastrada de ' + gDsUFOrigem + ' para ' + gDsUFDestino + '!' + ' / ' + cDS_METHOD);
          exit;
        end;
        fFIS_IMPOSTO.PR_ALIQUOTA := fFIS_ALIQUOTAICMSUF.PR_ALIQICMS;
      end;

      if (fFIS_REGRAFISCAL.PR_REDUBASE <> 0) then begin
        vVlCalc := (gVlTotalLiquido + gVlIPI) - ((gVlTotalLiquido + gVlIPI) * fFIS_REGRAFISCAL.PR_REDUBASE) / 100;
      end else begin
        vVlCalc := gVlTotalLiquido + gVlIPI;
      end;
      vVlBaseCalc := vVlCalc + (vVlCalc * vPrIVA) / 100 ;
      fFIS_IMPOSTO.VL_BASECALC := rounded(vVlBaseCalc, 6);
      fFIS_IMPOSTO.PR_BASECALC := 100;
      vVlCalc := fFIS_IMPOSTO.VL_BASECALC * (fFIS_IMPOSTO.PR_ALIQUOTA / 100);
      vVlICMS := rounded(vVlCalc, 6) ;
      fFIS_IMPOSTO.VL_IMPOSTO := vVlICMS - gVlICMS;
      gCdDecreto := vCdDecreto;
    end;
  end else if (vCdDecreto = 2559)then begin // Decreto do Paraná
    if (gDsUFOrigem = 'PR') or (gDsUFDestino = 'PR') then begin
      if (fGER_OPERACAO.TP_MODALIDADE = 4)then begin // Venda/Compra
        if (fGER_OPERACAO.TP_OPERACAO = 'E') then begin
          // Aliquota interna de PR
          fFIS_ALIQUOTAICMSUF.Limpar();
          fFIS_ALIQUOTAICMSUF.CD_UFORIGEM := gDsUFDestino;
          fFIS_ALIQUOTAICMSUF.CD_UFDESTINO := gDsUFDestino;
          fFIS_ALIQUOTAICMSUF.Listar(nil);
          if (itemXmlF('status', voParams) < 0) then begin
            raise Exception.Create('Nenhuma alíquota cadastrada de ' + gDsUFOrigem + ' para ' + gDsUFDestino + '!' + ' / ' + cDS_METHOD);
            exit;
          end;
        end else begin
          // Aliquota interna de PR
          fFIS_ALIQUOTAICMSUF.Limpar();
          fFIS_ALIQUOTAICMSUF.CD_UFORIGEM := gDsUFOrigem;
          fFIS_ALIQUOTAICMSUF.CD_UFDESTINO := gDsUFOrigem;
          fFIS_ALIQUOTAICMSUF.Listar(nil);
          if (itemXmlF('status', voParams) < 0) then begin
            raise Exception.Create('Nenhuma alíquota cadastrada de ' + gDsUFOrigem + ' para ' + gDsUFDestino + '!' + ' / ' + cDS_METHOD);
            exit;
          end;
        end;

        // Aliquota interna de PR
        if (fFIS_REGRAFISCAL.PR_ALIQICMS > 0) then begin
          vVlAliquotaIntra := fFIS_REGRAFISCAL.PR_ALIQICMS;
        end else begin
          vVlAliquotaIntra := fFIS_ALIQUOTAICMSUF.PR_ALIQICMS;
        end;
        vVlAliquotaInter := fFIS_IMPOSTO.PR_ALIQUOTA; // Aliquota aplicada pelo Fornecedor
        if (gInProdPropria) then begin
          vCdCFOP := fFIS_REGRAFISCAL.CD_CFOPPROPRIA;
        end else begin
          vCdCFOP := fFIS_REGRAFISCAL.CD_CFOPTERCEIRO;
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

    if (vInDecreto) then begin
      vVlCalc := gVlTotalLiquidoICMS + gVlIPI + ((gVlTotalLiquidoICMS + gVlIPI) * vPrIVA) / 100 ;
      fFIS_IMPOSTO.VL_BASECALC := rounded(vVlCalc, 6);
      fFIS_IMPOSTO.PR_BASECALC := 100;
      vVlCalc := fFIS_IMPOSTO.VL_BASECALC * (vVlAliquotaInter / 100);
      vVlICMS := rounded(vVlCalc, 6) ;
      fFIS_IMPOSTO.PR_ALIQUOTA := vVlAliquotaInter;
      fFIS_IMPOSTO.VL_IMPOSTO := (gVlTotalLiquidoICMS + gVlIPI) * (1 + (vPrIVA / 100)) * (vVlAliquotaInter/100) - gVlICMS;
      gCdDecreto := vCdDecreto;
    end;
  end else if (vCdDecreto = 52804)then begin // Decreto do Estado de São Paulo
    if (gDsUFOrigem = 'SP') or (gDsUFDestino = 'SP') then begin
      if (fGER_OPERACAO.TP_MODALIDADE = 4)then begin // Compra/Venda
        if (fGER_OPERACAO.TP_OPERACAO = 'E') then begin
          // Aliquota interna de SP
          fFIS_ALIQUOTAICMSUF.Limpar();
          fFIS_ALIQUOTAICMSUF.CD_UFORIGEM := gDsUFDestino;
          fFIS_ALIQUOTAICMSUF.CD_UFDESTINO := gDsUFDestino;
          fFIS_ALIQUOTAICMSUF.Listar(nil);
          if (itemXmlF('status', voParams) < 0) then begin
            raise Exception.Create('Nenhuma alíquota cadastrada de ' + gDsUFOrigem + ' para ' + gDsUFDestino + '!' + ' / ' + cDS_METHOD);
            exit;
          end;
        end else begin
          // Aliquota interna de SP
          fFIS_ALIQUOTAICMSUF.Limpar();
          fFIS_ALIQUOTAICMSUF.CD_UFORIGEM := gDsUFOrigem;
          fFIS_ALIQUOTAICMSUF.CD_UFDESTINO := gDsUFOrigem;
          fFIS_ALIQUOTAICMSUF.Listar(nil);
          if (itemXmlF('status', voParams) < 0) then begin
            raise Exception.Create('Nenhuma alíquota cadastrada de ' + gDsUFOrigem + ' para ' + gDsUFDestino + '!' + ' / ' + cDS_METHOD);
            exit;
          end;
        end;

        // Aliquota interna de SP
        if (fFIS_REGRAFISCAL.PR_ALIQICMS > 0) then begin
          vVlAliquotaIntra := fFIS_REGRAFISCAL.PR_ALIQICMS ;
        end else begin 
          vVlAliquotaIntra := fFIS_ALIQUOTAICMSUF.PR_ALIQICMS;
        end;
        vVlAliquotaInter := fFIS_IMPOSTO.PR_ALIQUOTA ; // Aliquota aplicada pelo Fornecedor
        if (gDsUFOrigem = 'SP') and (gDsUFDestino = 'SP') then begin
          vPrIVA := 17.32;
        end else begin
          vPrIVA := ((1 + (17.32/100)) * ((1 - (vVlAliquotaInter/100)) / (1 - (vVlAliquotaIntra/100))) -1) * 100;
        end;
        vInDecreto := True;
      end;
    end;

    if (vInDecreto) then begin
      vVlCalc := gVlTotalLiquidoICMS + gVlIPI + ((gVlTotalLiquidoICMS + gVlIPI) * vPrIVA) / 100 ;
      fFIS_IMPOSTO.VL_BASECALC := rounded(vVlCalc, 6);
      fFIS_IMPOSTO.PR_BASECALC := 100;
      vVlCalc := fFIS_IMPOSTO.VL_BASECALC * (vVlAliquotaIntra / 100);
      vVlICMS := rounded(vVlCalc, 6) ;
      fFIS_IMPOSTO.PR_ALIQUOTA := vVlAliquotaInter;
      fFIS_IMPOSTO.VL_IMPOSTO := (gVlTotalLiquidoICMS + gVlIPI) * (1 + (vPrIVA / 100)) * (vVlAliquotaInter/100) - gVlICMS;
      gCdDecreto := vCdDecreto;
    end;
  // Decreto do Espirito Santo
  end else if (vCdDecreto = 10901) or (vCdDecreto = 10902) or (vCdDecreto = 10903) or (vCdDecreto = 10904) then begin // Decreto do Espirito Santo
    if (gDsUFOrigem = 'ES') or (gDsUFDestino = 'ES') then begin
      if (gInContribuinte)
      and ((fGER_OPERACAO.TP_MODALIDADE = 4) or (fGER_OPERACAO.TP_MODALIDADE = 3)) then begin // 4 - Venda/Compra / 3 - Devolucao
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

    if (vInDecreto) then begin
      // Aliquota aplicada no destino
      fFIS_ALIQUOTAICMSUF.Limpar();
      fFIS_ALIQUOTAICMSUF.CD_UFORIGEM := gDsUFDestino;
      fFIS_ALIQUOTAICMSUF.CD_UFDESTINO := gDsUFDestino;
      fFIS_ALIQUOTAICMSUF.Listar(nil);
      if (itemXmlF('status', voParams) < 0) then begin
        raise Exception.Create('Nenhuma alíquota cadastrada de ' + gDsUFOrigem + ' para ' + gDsUFDestino + '!' + ' / ' + cDS_METHOD);
        exit;
      end;
      // Aliquota interna do destino
      if (fFIS_REGRAFISCAL.PR_ALIQICMS > 0) then begin
        vVlAliquotaIntra := fFIS_REGRAFISCAL.PR_ALIQICMS ;
      end else begin
        vVlAliquotaIntra := fFIS_ALIQUOTAICMSUF.PR_ALIQICMS;
      end;
      vVlCalc := gVlTotalLiquidoICMS + gVlIPI + ((gVlTotalLiquidoICMS + gVlIPI) * vPrIVA) / 100 ;
      fFIS_IMPOSTO.VL_BASECALC := rounded(vVlCalc, 6);
      fFIS_IMPOSTO.PR_BASECALC := 100;
      vVlCalc := fFIS_IMPOSTO.VL_BASECALC * (vVlAliquotaIntra / 100);
      vVlICMS := rounded(vVlCalc, 6) ;
      fFIS_IMPOSTO.PR_ALIQUOTA := vVlAliquotaIntra;
      fFIS_IMPOSTO.VL_IMPOSTO := (gVlTotalLiquidoICMS + gVlIPI) * (1 + (vPrIVA / 100)) * (vVlAliquotaIntra/100) - gVlICMS;
      gCdDecreto := vCdDecreto;
      if (gDsUFOrigem = 'ES') and (gDsUFDestino = 'ES') then begin
        vCdCST := '10';
      end else begin
        vCdCST := '70';
      end;
    end;
  end else begin
    vTpOperacao := fGER_OPERACAO.TP_OPERACAO;

    viParams := '';
    viParams.CD_PRODUTO := fPRD_PRODUTO.CD_PRODUTO;
    viParams.UF_ORIGEM := gDsUFOrigem;
    viParams.UF_DESTINO := gDsUFDestino;
    viParams.TP_OPERACAO := vTpOperacao;
    voParams := activateCmp('FISSVCO035', 'buscaDadosFiscalProduto', viParams);
    if (itemXmlF('status', voParams) < 0) then begin
      raise Exception.Create(itemXml('message', voParams));
      exit;
    end;  
    vPrIvaPrd := voParams.PR_SUBSTRIB;
    vPrICMS := voParams.PR_ICMS;

    if (vPrIvaPrd > 0) then begin
      vPrIVA := vPrIvaPrd;
    end;

    if (vPrICMS > 0)  then begin
      fFIS_IMPOSTO.PR_ALIQUOTA := vPrICMS;
    end;
    if (fFIS_IMPOSTO.PR_ALIQUOTA = 0) then begin
      raise Exception.Create('Nenhuma alíquota cadastrada na Tabela de Sub.Trib.do NCM de ' + gDsUFOrigem + ' para ' + gDsUFDestino + '!' + ' / ' + cDS_METHOD);
      exit;
    end;
    vInCalcula := False;
    if (gDsUFOrigem <> gDsUFDestino) and (fGER_OPERACAO.TP_MODALIDADE = 4)then begin // Venda/Compra
      if (fGER_OPERACAO.TP_OPERACAO = 'S') then begin
        if (gInContribuinte) and (fPES_CLIENTE.IN_CNSRFINAL) then begin
          vInCalcula := True;
        end;
      end else begin
        if (gInProdPropria) then begin
          vCdCFOP := fFIS_REGRAFISCAL.CD_CFOPPROPRIA;
        end else begin
          vCdCFOP := fFIS_REGRAFISCAL.CD_CFOPTERCEIRO;
        end;
        vCdCFOP := StrToFloat(Copy(FloatToStr(vCdCFOP),2,4));

        if (vCdCFOP = 407) then begin
          vInCalcula := True;
        end;
      end;

      if (vInCalcula) then begin
        // Aliquota interna destino
        fFIS_ALIQUOTAICMSUF.Limpar();
        fFIS_ALIQUOTAICMSUF.CD_UFORIGEM := gDsUFDestino;
        fFIS_ALIQUOTAICMSUF.CD_UFDESTINO := gDsUFDestino;
        fFIS_ALIQUOTAICMSUF.Listar(nil);
        if (itemXmlF('status', voParams) < 0) then begin
          raise Exception.Create('Nenhuma alíquota cadastrada de ' + gDsUFOrigem + ' para ' + gDsUFDestino + '!' + ' / ' + cDS_METHOD);
          exit;
        end;
        vVlAliquotaDestino := fFIS_ALIQUOTAICMSUF.PR_ALIQICMS;

        // Aliquota interna origem
        fFIS_ALIQUOTAICMSUF.Limpar();
        fFIS_ALIQUOTAICMSUF.CD_UFORIGEM := gDsUFOrigem;
        fFIS_ALIQUOTAICMSUF.CD_UFDESTINO := gDsUFOrigem;
        fFIS_ALIQUOTAICMSUF.Listar(nil);
        if (itemXmlF('status', voParams) < 0) then begin
          raise Exception.Create('Nenhuma alíquota cadastrada de ' + gDsUFOrigem + ' para ' + gDsUFDestino + '!' + ' / ' + cDS_METHOD);
          exit;
        end;
        vVlAliquotaOrigem := fFIS_ALIQUOTAICMSUF.PR_ALIQICMS;

        //Se tiver aliquota na regra fiscal será passado para AliquotaOrigem
        if (fFIS_REGRAFISCAL.PR_ALIQICMS > 0) then begin
          vVlAliquotaOrigem := fFIS_REGRAFISCAL.PR_ALIQICMS ;
        end;

        vPrIVA := 0;
        fFIS_IMPOSTO.PR_ALIQUOTA := abs(vVlAliquotaOrigem - vVlAliquotaDestino);

      end else begin

        fFIS_ALIQUOTAICMSUF.Limpar();
        fFIS_ALIQUOTAICMSUF.CD_UFORIGEM := gDsUFOrigem;
        fFIS_ALIQUOTAICMSUF.CD_UFDESTINO := gDsUFDestino;
        fFIS_ALIQUOTAICMSUF.Listar(nil);
        if (itemXmlF('status', voParams) < 0) then begin
          raise Exception.Create('Nenhuma alíquota cadastrada de ' + gDsUFOrigem + ' para ' + gDsUFDestino + '!' + ' / ' + cDS_METHOD);
          exit;
        end;
        vVlAliquotaInter := fFIS_ALIQUOTAICMSUF.PR_ALIQICMS;

        viParams := '';
        viParams.CD_PRODUTO := fPRD_PRODUTO.CD_PRODUTO;
        viParams.UF_ORIGEM := gDsUFOrigem;
        viParams.UF_DESTINO := gDsUFDestino;
        viParams.TP_OPERACAO := vTpOperacao;
        voParams := activateCmp('FISSVCO035', 'buscaDadosFiscalProduto', viParams);
        if (itemXmlF('status', voParams) < 0) then begin
          raise Exception.Create(itemXml('message', voParams));
          exit
        end;
        vVlAliquotaIntra := voParams.PR_ICMS;

        if (vVlAliquotaIntra = 0) then begin
          fFIS_ALIQUOTAICMSUF.Limpar();
          fFIS_ALIQUOTAICMSUF.CD_UFORIGEM := gDsUFDestino;
          fFIS_ALIQUOTAICMSUF.CD_UFDESTINO := gDsUFDestino;
          fFIS_ALIQUOTAICMSUF.Listar(nil);
          if (itemXmlF('status', voParams) < 0) then begin
            raise Exception.Create('Nenhuma alíquota cadastrada de ' + gDsUFOrigem + ' para ' + gDsUFDestino + '!' + ' / ' + cDS_METHOD);
            exit;
          end;
          vVlAliquotaIntra := fFIS_ALIQUOTAICMSUF.PR_ALIQICMS;
        end;

        if (gDsUFDestino <> gDsUFOrigem) then begin
           vPrIVA := ((1 + (vPrIVA/100)) * ((1 - (vVlAliquotaInter/100)) / (1 - (vVlAliquotaIntra/100))) -1) * 100;
        end;
      end;
    end;
    if (gPrAplicMvaSubTrib <> 0) then begin
      if ((vTpOperacao = 'S') and ((gDsUFDestino = 'SC') and (gInContribuinte) and ((gTpRegimeOrigem = 2) or (gTpRegimeOrigem = 3)))
      or ((vTpOperacao = 'E') and ((fGER_OPERACAO.TP_MODALIDADE = 3) and ((gTpRegimeOrigem = 2) or (gTpRegimeOrigem = 3))) // 2-Micro Empresa / 3-EPP
      or ((vTpOperacao = 'E') and (gInOptSimples) then begin
        if (vPrIVA = 0) then begin
          vPrIva := vPrIvaPrd;
        end;
        vPrIVA := (vPrIVA * gPrAplicMvaSubTrib)/100;
      end;
    end;
    if (vCdCST = '10') then begin
      vVlCalc := (gVlTotalLiquidoICMS + gVlIPI) + ((gVlTotalLiquidoICMS + gVlIPI) * vPrIVA) / 100;
      fFIS_IMPOSTO.VL_BASECALC := rounded(vVlCalc, 6);
      fFIS_IMPOSTO.PR_BASECALC := 100;
    end else if (vCdCST = '70') then begin //Implementado por Deusdete em caráter de urgência em 28/04/2009, lógica revisada c/ Eliã
      vVlCalc := gVlTotalLiquidoICMS + gVlIPI;
      if (gNaturezaComercialEmp <> 3) and (gNaturezaComercialEmp <> 2) then begin //Varejo e Atacado (p/ atender o Lojão e Brascol)
        if (fFIS_REGRAFISCAL.PR_REDUBASE <> 0) then begin
          if (vTpOperacao = 'S') then begin
            vVlCalc := vVlCalc - ((gVlTotalLiquidoICMS + gVlIPI) * fFIS_REGRAFISCAL.PR_REDUBASE) / 100;
            fFIS_IMPOSTO.PR_BASECALC := 100 - fFIS_REGRAFISCAL.PR_REDUBASE;
            fFIS_IMPOSTO.PR_REDUBASE := fFIS_REGRAFISCAL.PR_REDUBASE;
          end else if (vTpOperacao = 'E') then begin
            if (gTpRegimeOrigem = 2) or (gTpRegimeOrigem = 3) then begin
              vVlCalc := vVlCalc - ((gVlTotalLiquidoICMS + gVlIPI) * fFIS_REGRAFISCAL.PR_REDUBASE) / 100;
              fFIS_IMPOSTO.PR_BASECALC := 100 - fFIS_REGRAFISCAL.PR_REDUBASE;
              fFIS_IMPOSTO.PR_REDUBASE := fFIS_REGRAFISCAL.PR_REDUBASE;
            end;
          end;
        end;
      end;
      vVlBaseCalc := vVlCalc + ((vVlCalc * vPrIVA) / 100);
      fFIS_IMPOSTO.VL_BASECALC := rounded(vVlBaseCalc, 6);
      if (fFIS_IMPOSTO.PR_REDUBASE = 0) then begin
        fFIS_IMPOSTO.PR_BASECALC := 100;
      end;
    end else if (vCdCST = '30') then begin
      vVlCalc := gVlTotalLiquidoICMS + gVlIPI;
      if (gInOptSimples) then begin
        if (gNaturezaComercialEmp <> 3) and (gNaturezaComercialEmp <> 2) then begin //Varejo e Atacado (p/ atender o Lojão e Brascol)
          if (fFIS_REGRAFISCAL.PR_REDUBASE <> 0) then begin
            if (vTpOperacao = 'S') then begin
              vVlCalc := vVlCalc - ((gVlTotalLiquidoICMS + gVlIPI) * fFIS_REGRAFISCAL.PR_REDUBASE) / 100;
              fFIS_IMPOSTO.PR_BASECALC := 100 - fFIS_REGRAFISCAL.PR_REDUBASE;
              fFIS_IMPOSTO.PR_REDUBASE := fFIS_REGRAFISCAL.PR_REDUBASE;
            end else if (vTpOperacao = 'E') then begin
              if (gTpRegimeOrigem = 2) or (gTpRegimeOrigem = 3) then begin
                vVlCalc := vVlCalc - ((gVlTotalLiquidoICMS + gVlIPI) * fFIS_REGRAFISCAL.PR_REDUBASE) / 100;
                fFIS_IMPOSTO.PR_BASECALC := 100 - fFIS_REGRAFISCAL.PR_REDUBASE;
                fFIS_IMPOSTO.PR_REDUBASE := fFIS_REGRAFISCAL.PR_REDUBASE;
              end;
            end;
          end;
        end;
      end;
      vVlBaseCalc := vVlCalc + ((vVlCalc * vPrIVA) / 100;
      fFIS_IMPOSTO.VL_BASECALC := rounded(vVlBaseCalc, 6);
      if (fFIS_IMPOSTO.PR_REDUBASE = 0) then begin
        fFIS_IMPOSTO.PR_BASECALC := 100;
      end;
    end else begin
      fFIS_IMPOSTO.VL_OUTRO := gVlTotalLiquidoICMS;
    end;

    if (vInCalcula)  then begin
      vVlCalc := (fFIS_IMPOSTO.VL_BASECALC * fFIS_IMPOSTO.PR_ALIQUOTA) / 100;
      vVlCalc := rounded(vVlCalc, 6);
      fFIS_IMPOSTO.VL_IMPOSTO := vVlCalc;
    end else begin
      if (fFIS_IMPOSTO.VL_BASECALC > 0) then begin
        if (gInOptSimples) or ((gTpRegimeOrigem = 2) or (gTpRegimeOrigem = 3)
        and ((fGER_OPERACAO.TP_OPERACAO = 'E')
        or (((fGER_OPERACAO.TP_MODALIDADE = 3) and (fGER_OPERACAO.TP_OPERACAO = 'S')))) then begin //2-Simples 3-EPP / Entrada ou Devolucao de compra
          if (fFIS_IMPOSTO.PR_ALIQUOTA <> 0) then begin
            vVlCalc := (fFIS_IMPOSTO.VL_BASECALC * fFIS_IMPOSTO.PR_ALIQUOTA) / 100;
            vVlICMS := rounded(vVlCalc, 6)    ;
            if (vCdCST = '30') or (vCdCST = '70') then begin
              if (gInOptSimples) then begin
                if (fGER_OPERACAO.TP_OPERACAO = 'E') then begin
                  if (gTpRegimeOrigem = 2) or (gTpRegimeOrigem = 3) then begin
                    if (fFIS_REGRAFISCAL.PR_REDUBASE <> 0) then begin
                      gVlTotalLiquidoICMS := (gVlTotalLiquidoICMS + gVlIPI) - ((gVlTotalLiquidoICMS + gVlIPI) * fFIS_REGRAFISCAL.PR_REDUBASE) / 100;
                    end;
                  end;
                end else if (fGER_OPERACAO.TP_OPERACAO = 'S') then begin
                  if (fFIS_REGRAFISCAL.PR_REDUBASE <> 0) then begin
                    gVlTotalLiquidoICMS := (gVlTotalLiquidoICMS + gVlIPI) - ((gVlTotalLiquidoICMS + gVlIPI) * fFIS_REGRAFISCAL.PR_REDUBASE) / 100;
                  end;
                end;
              end else if (gInOptSimples = False) and (vCdCST = '70') then begin
                if (gTpRegimeOrigem = 2) or (gTpRegimeOrigem = 3) then begin
                  if (fFIS_REGRAFISCAL.PR_REDUBASE <> 0) then begin
                    gVlTotalLiquidoICMS := (gVlTotalLiquidoICMS + gVlIPI) - ((gVlTotalLiquidoICMS + gVlIPI) * fFIS_REGRAFISCAL.PR_REDUBASE) / 100;
                  end;
                end;
              end;
            end;

            if (gDsUFOrigem = gDsUFDestino) then begin
              if (fFIS_REGRAFISCAL.PR_ALIQICMS > 0) then begin
                vVlCalc := ((gVlTotalLiquidoICMS + gVlIPI) * fFIS_REGRAFISCAL.PR_ALIQICMS) / 100;
              end else begin 
                fFIS_ALIQUOTAICMSUF.Limpar();
                fFIS_ALIQUOTAICMSUF.CD_UFORIGEM := gDsUFOrigem;
                fFIS_ALIQUOTAICMSUF.CD_UFDESTINO := gDsUFDestino;
                fFIS_ALIQUOTAICMSUF.Listar(nil);
                if (itemXmlF('status', voParams) < 0) then begin
                  raise Exception.Create('Nenhuma alíquota cadastrada de ' + gDsUFOrigem + ' para ' + gDsUFDestino + '!' + ' / ' + cDS_METHOD);
                  exit;
                end;
                vVlCalc := ((gVlTotalLiquidoICMS + gVlIPI) * fFIS_ALIQUOTAICMSUF.PR_ALIQICMS) / 100;
              end;
            end else begin
              fFIS_ALIQUOTAICMSUF.Limpar();
              fFIS_ALIQUOTAICMSUF.CD_UFORIGEM := gDsUFOrigem;
              fFIS_ALIQUOTAICMSUF.CD_UFDESTINO := gDsUFDestino;
              fFIS_ALIQUOTAICMSUF.Listar(nil);
              if (itemXmlF('status', voParams) < 0) then begin
                raise Exception.Create('Nenhuma alíquota cadastrada de ' + gDsUFOrigem + ' para ' + gDsUFDestino + '!' + ' / ' + cDS_METHOD);
                exit;
              end;
              vVlCalc := ((gVlTotalLiquidoICMS + gVlIPI) * fFIS_ALIQUOTAICMSUF.PR_ALIQICMS) / 100;
            end;
            vVlCalc := rounded(vVlCalc, 6);
            fFIS_IMPOSTO.VL_IMPOSTO := vVlICMS - vVlCalc;
          end;
        end else begin
          vVlCalc := fFIS_IMPOSTO.VL_BASECALC * fFIS_IMPOSTO.PR_ALIQUOTA / 100;
          vVlICMS := rounded(vVlCalc, 6) ;
          fFIS_IMPOSTO.VL_IMPOSTO := vVlICMS - gVlICMS;
        end;
      end else begin
        fFIS_IMPOSTO.VL_IMPOSTO := 0;
      end;
    end;
  end;

  if (vCdCST = '60') then begin
    fFIS_IMPOSTO.PR_ALIQUOTA := 0;
    fFIS_IMPOSTO.VL_OUTRO := gVlTotalLiquidoICMS;
    fFIS_IMPOSTO.VL_IMPOSTO := 0;
    fFIS_IMPOSTO.VL_BASECALC := 0;
    fFIS_IMPOSTO.PR_BASECALC := 0;
    fFIS_IMPOSTO.PR_REDUBASE := 0;
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
  if (gTpOrigemEmissao = 1) then begin //Própria
    if (fFIS_REGRAFISCAL.IN_IPI <> True) then begin
      fFIS_IMPOSTO.Remover();
      exit;
    end;
  end else begin
    if (gPrIPI = 0) or (gVlIPI = 0)  then begin
      if (fFIS_REGRAFISCAL.IN_IPI <> True) then begin
        fFIS_IMPOSTO.Remover();
        exit;
      end;
    end;
  end;

  gCdDecreto := 0;
  vCdDecreto := 0;
  vInDecreto := False;
  vDtSistema := PARAM_GLB.DT_SISTEMA;
  
  if (gCdDecretoItemCapa <> 0) then begin
    fFIS_DECRETO.Limpar();
    fFIS_DECRETO.CD_DECRETO := gCdDecretoItemCapa;
    fFIS_DECRETO.Listar(nil);
    if (xStatus >= 0) then begin
      vCdDecreto := fFIS_DECRETO.CD_DECRETO;
      vDtIniVigencia := fFIS_DECRETO.DT_INIVIGENCIA;
      vDtFimVigencia := fFIS_DECRETO.DT_FIMVIGENCIA;
    end;
  end else begin
    if (fFIS_DECRETO.CD_DECRETO > 0) then begin
      vCdDecreto := fFIS_DECRETO.CD_DECRETO;
      vDtIniVigencia := fFIS_DECRETO.DT_INIVIGENCIA;
      vDtFimVigencia := fFIS_DECRETO.DT_FIMVIGENCIA;
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
  fFIS_IMPOSTO.PR_BASECALC := 100;
  fFIS_IMPOSTO.VL_BASECALC := gVlTotalBruto;
  if (gTpOrigemEmissao = 1) then begin //Própria
    if(gPrIPI <> 0) then begin
      fFIS_IMPOSTO.PR_ALIQUOTA := gPrIPI;
    end else begin
      fFIS_IMPOSTO.PR_ALIQUOTA := fFIS_TIPI.PR_IPI;
    end;
    vVlCalc := fFIS_IMPOSTO.VL_BASECALC * fFIS_IMPOSTO.PR_ALIQUOTA / 100;
    fFIS_IMPOSTO.VL_IMPOSTO := rounded(vVlCalc, 2);
  end else begin
    if (gVlIPI = 0) then begin
      if (gPrIPI <> 0) then begin
        fFIS_IMPOSTO.PR_ALIQUOTA := gPrIPI;
      end;
      vVlCalc := fFIS_IMPOSTO.VL_BASECALC * fFIS_IMPOSTO.PR_ALIQUOTA / 100;
      fFIS_IMPOSTO.VL_IMPOSTO := rounded(vVlCalc, 2);
    end else begin
      fFIS_IMPOSTO.PR_ALIQUOTA := gPrIPI;
      fFIS_IMPOSTO.VL_IMPOSTO := gVlIPI;
    end;
  end;
  if (vCdDecreto = 8248) then begin // Decreto para reduzir o valor do IPI em 95% para produto de informática
    if (fGER_OPERACAO.TP_MODALIDADE = 4) then begin // 4 - Venda/Compra
      vInDecreto := True;
    end;

    if (vInDecreto) then begin
      vVlCalc := fFIS_IMPOSTO.VL_IMPOSTO * (1 - 0.95);
      fFIS_IMPOSTO.VL_IMPOSTO := rounded(vVlCalc, 2);
      gCdDecreto := vCdDecreto;
    end;
  end;
  if ((fGER_OPERACAO.TP_MODALIDADE <> 3) or (fGER_OPERACAO.TP_OPERACAO <> 'S')) then begin //Devolucao / Saida
    if ((gCdServico > 0) or (fGER_OPERACAO.TP_MODALIDADE = 5) or (fGER_OPERACAO.TP_MODALIDADE = 6) or (fGER_OPERACAO.TP_MODALIDADE = 'F')) then begin // 5-Outras entradas/saidas / 6-Producao / F-Remessa/Retorno;
      if (gInCalcIpiOutEntSai <> True) then begin
        fFIS_IMPOSTO.VL_OUTRO := fFIS_IMPOSTO.VL_BASECALC;
        fFIS_IMPOSTO.VL_BASECALC := 0;
        fFIS_IMPOSTO.VL_IMPOSTO := 0;
        fFIS_IMPOSTO.PR_ALIQUOTA := 0;
        fFIS_IMPOSTO.PR_BASECALC := '';
      end;
    end else if (fGER_OPERACAO.TP_MODALIDADE = 3) and (fGER_OPERACAO.TP_OPERACAO = 'E') then begin // Devolução de Venda
      if (gDsUFDestino = 'AC') or (gDsUFDestino = 'AM') or (gDsUFDestino = 'RO') or (gDsUFDestino = 'RR') or (gDsUFOrigem = 'EX') or (gDsUFDestino = 'EX') then begin
        fFIS_IMPOSTO.VL_OUTRO := fFIS_IMPOSTO.VL_BASECALC;
        fFIS_IMPOSTO.VL_BASECALC := 0;
        fFIS_IMPOSTO.VL_IMPOSTO := 0;
        fFIS_IMPOSTO.PR_ALIQUOTA := 0;
        fFIS_IMPOSTO.PR_BASECALC := '';
      end;
    end else begin
      if (gNaturezaComercialEmp = 4) then begin // 4 - IPI suspenso
        if (fFIS_IMPOSTO.VL_IMPOSTO = 0) then begin
          fFIS_IMPOSTO.VL_OUTRO := fFIS_IMPOSTO.VL_BASECALC;
          fFIS_IMPOSTO.VL_BASECALC := 0;
          fFIS_IMPOSTO.PR_ALIQUOTA := 0;
          fFIS_IMPOSTO.PR_BASECALC := '';
        end;
      end else if (fGER_OPERACAO.TP_MODALIDADE = 4) and (fGER_OPERACAO.TP_OPERACAO = 'S') then begin // 4 - Venda
        if (gDsUFDestino = 'EX') or (gDsUFDestino = 'AC') or (gDsUFDestino = 'AM') or (gDsUFDestino = 'RO') or (gDsUFDestino = 'RR') then begin
          fFIS_IMPOSTO.VL_OUTRO := fFIS_IMPOSTO.VL_BASECALC;
          fFIS_IMPOSTO.VL_BASECALC := 0;
          fFIS_IMPOSTO.VL_IMPOSTO := 0;
          fFIS_IMPOSTO.PR_ALIQUOTA := 0;
          fFIS_IMPOSTO.PR_BASECALC := '';
        end else if (gTpAreaComercioOrigem = 0) and (gTpAreaComercioDestino > 0) then begin
          fFIS_IMPOSTO.VL_OUTRO := fFIS_IMPOSTO.VL_BASECALC;
          fFIS_IMPOSTO.VL_BASECALC := 0;
          fFIS_IMPOSTO.VL_IMPOSTO := 0;
          fFIS_IMPOSTO.PR_ALIQUOTA := 0;
          fFIS_IMPOSTO.PR_BASECALC := '';
        end;
      end;
    end;
  end else begin
    if (fFIS_IMPOSTO.PR_ALIQUOTA = 0) then begin
      fFIS_IMPOSTO.VL_OUTRO := fFIS_IMPOSTO.VL_BASECALC;
      fFIS_IMPOSTO.VL_BASECALC := 0;
      fFIS_IMPOSTO.VL_IMPOSTO := 0;
      fFIS_IMPOSTO.PR_ALIQUOTA := 0;
      fFIS_IMPOSTO.PR_BASECALC := '';
    end;
  end;

  if (gInImpostoOffLine) then begin
    fFIS_IMPOSTO.VL_BASECALC := 0;
    fFIS_IMPOSTO.VL_IMPOSTO := 0;
  end;

  gPrIPI := fFIS_IMPOSTO.PR_ALIQUOTA;
  gVlIPI := fFIS_IMPOSTO.VL_IMPOSTO;
  return(0);
end;

//----------------------
function T_FISSVCO015.calculaISS(pParams : String) : String;
//----------------------
var
  vVlCalc, vVlBaseCalc : Real;
  vCdCST : String;
begin
  if (gInImpostoOffLine) then begin
    fFIS_IMPOSTO.Remover();
    exit;
  end;

  vCdCST := Copy(gCdCST,2,2);

  if (vCdCST = '40') or (vCdCST = '41') then begin
    fFIS_IMPOSTO.PR_BASECALC := 0;
    fFIS_IMPOSTO.VL_BASECALC := 0;
    fFIS_IMPOSTO.PR_ALIQUOTA := fFIS_REGRAFISCAL.PR_ALIQISS;
    vVlCalc := fFIS_IMPOSTO.VL_BASECALC * fFIS_IMPOSTO.PR_ALIQUOTA / 100;
    fFIS_IMPOSTO.VL_IMPOSTO := rounded(vVlCalc, 6);
    fFIS_IMPOSTO.VL_ISENTO := gVlTotalLiquido;

  end else if (vCdCST = '90') then begin
    fFIS_IMPOSTO.PR_BASECALC := 0;
    fFIS_IMPOSTO.VL_BASECALC := 0;
    fFIS_IMPOSTO.PR_ALIQUOTA := fFIS_REGRAFISCAL.PR_ALIQISS;
    vVlCalc := fFIS_IMPOSTO.VL_BASECALC * fFIS_IMPOSTO.PR_ALIQUOTA / 100;
    fFIS_IMPOSTO.VL_IMPOSTO := rounded(vVlCalc, 6);
    fFIS_IMPOSTO.VL_OUTRO := gVlTotalLiquido;
  end else begin
    fFIS_IMPOSTO.PR_BASECALC := 100;
    fFIS_IMPOSTO.VL_BASECALC := gVlTotalLiquido;
    fFIS_IMPOSTO.PR_ALIQUOTA := fFIS_REGRAFISCAL.PR_ALIQISS;
    vVlCalc := fFIS_IMPOSTO.VL_BASECALC * fFIS_IMPOSTO.PR_ALIQUOTA / 100;
    fFIS_IMPOSTO.VL_IMPOSTO := rounded(vVlCalc, 6);
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
  if (gInImpostoOffLine) then begin
    fFIS_IMPOSTO.Remover();
    exit;
  end;
  if (fFIS_REGRAFISCAL.IN_COFINS <> True) then begin
    fFIS_IMPOSTO.Remover();
    exit;
  end;

  fFIS_REGRAIMPOSTO.Limpar();
  fFIS_REGRAIMPOSTO.CD_IMPOSTO := fFIS_IMPOSTO.CD_IMPOSTO;
  fFIS_REGRAIMPOSTO.CD_REGRAFISCAL := fFIS_REGRAFISCAL.CD_REGRAFISCAL;
  fFIS_REGRAIMPOSTO.Listar(nil);
  if (itemXmlF('status', voParams) < 0) then begin
    fFIS_IMPOSTO.CD_CST := fFIS_REGRAIMPOSTO.CD_CST;
  end;

  if (gTpAreaComercioOrigem = 0)
  and (((gTpAreaComercioDestino = 1) and (gInDescontaPisCofinsAlc = False)) or ((gTpAreaComercioDestino = 2) and (gInDescontaPisCofinsZfm = False))) then begin
    fFIS_REGRAFISCAL.PR_ALIQCOFINS := 0;
    fFIS_IMPOSTO.CD_CST := '06';
  end;
  fFIS_IMPOSTO.PR_BASECALC := 100;
  fFIS_IMPOSTO.VL_BASECALC := gVlTotalLiquido;
  if (gDsLstCfopIpiBcPisCof <> '') then begin
    fTMP_NR09.Append();
    if (gInProdPropria) then begin
      fTMP_NR09.NR_GERAL := fFIS_REGRAFISCAL.CD_CFOPPROPRIA;
    end else begin
      fTMP_NR09.NR_GERAL := fFIS_REGRAFISCAL.CD_CFOPTERCEIRO;
    end;
    if (xStatus = 4) then begin
      fFIS_IMPOSTO.VL_BASECALC := fFIS_IMPOSTO.VL_BASECALC + gVlIPI;
    end else begin
      fTMP_NR09.Remover();
    end;
  end;
  fFIS_IMPOSTO.PR_ALIQUOTA := fFIS_REGRAFISCAL.PR_ALIQCOFINS;
  vVlCalc := fFIS_IMPOSTO.VL_BASECALC * fFIS_IMPOSTO.PR_ALIQUOTA / 100;
  fFIS_IMPOSTO.VL_IMPOSTO := rounded(vVlCalc, 6);
  return(0);
end;

//----------------------
function T_FISSVCO015.calculaPIS(pParams : String) : String;
//----------------------
var
  vVlCalc : Real;
  bStatus : Boolean;
begin
  if (gInImpostoOffLine) then begin
    fFIS_IMPOSTO.Remover();
    exit;
  end;
  if (fFIS_REGRAFISCAL.IN_PIS <> True) then begin
    fFIS_IMPOSTO.Remover();
    exit;
  end;

  fFIS_REGRAIMPOSTO.Limpar();
  fFIS_REGRAIMPOSTO.CD_IMPOSTO := fFIS_IMPOSTO.CD_IMPOSTO;
  fFIS_REGRAIMPOSTO.CD_REGRAFISCAL := fFIS_REGRAFISCAL.CD_REGRAFISCAL;
  fFIS_REGRAIMPOSTO.Listar(nil);
  if (itemXmlF('status', voParams) < 0) then begin
    fFIS_IMPOSTO.CD_CST := fFIS_REGRAIMPOSTO.CD_CST;
  end;

  if (gTpAreaComercioOrigem = 0)
  and (((gTpAreaComercioDestino = 1) and (gInDescontaPisCofinsAlc = False)) or ((gTpAreaComercioDestino = 2) and (gInDescontaPisCofinsZfm = False))) then begin
    fFIS_REGRAFISCAL.PR_ALIQPIS := 0;
    fFIS_IMPOSTO.CD_CST := '06';
  end;
  fFIS_IMPOSTO.PR_BASECALC := 100;
  fFIS_IMPOSTO.VL_BASECALC := gVlTotalLiquido;
  if (gDsLstCfopIpiBcPisCof <> '') then begin
    fTMP_NR09.Append();
    if (gInProdPropria) then begin
      fTMP_NR09.NR_GERAL := fFIS_REGRAFISCAL.CD_CFOPPROPRIA;
    end else begin
      fTMP_NR09.NR_GERAL := fFIS_REGRAFISCAL.CD_CFOPTERCEIRO;
    end;
    if (xStatus = 4) then begin
      fFIS_IMPOSTO.VL_BASECALC := fFIS_IMPOSTO.VL_BASECALC + gVlIPI;
    end else begin
      fTMP_NR09.Remover();
    end;
  end;
  fFIS_IMPOSTO.PR_ALIQUOTA := fFIS_REGRAFISCAL.PR_ALIQPIS;
  vVlCalc := fFIS_IMPOSTO.VL_BASECALC * fFIS_IMPOSTO.PR_ALIQUOTA / 100;
  fFIS_IMPOSTO.VL_IMPOSTO := rounded(vVlCalc, 6);
  return(0);
end;

//----------------------
function T_FISSVCO015.calculaPASEP(pParams : String) : String;
//----------------------
var
  vVlCalc : Real;
begin
  if (gInImpostoOffLine) then begin
    fFIS_IMPOSTO.Remover();
    exit;
  end;

  if (fFIS_REGRAFISCAL.IN_PASEP <> True)
  or (fFIS_REGRAFISCAL.PR_ALIQPASEP = 0) then begin
    fFIS_IMPOSTO.Remover();
    exit;
  end;

  fFIS_IMPOSTO.PR_BASECALC := 100;
  fFIS_IMPOSTO.VL_BASECALC := gVlTotalLiquido;
  fFIS_IMPOSTO.PR_ALIQUOTA := fFIS_REGRAFISCAL.PR_ALIQPASEP;
  vVlCalc := fFIS_IMPOSTO.VL_BASECALC * fFIS_IMPOSTO.PR_ALIQUOTA / 100;
  fFIS_IMPOSTO.VL_IMPOSTO := rounded(vVlCalc, 6);
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
  vCdRegraFiscalParam : Real;
begin
  Result := '';

  if (pParams.UF_ORIGEM <> '') then begin
    gDsUFOrigem := pParams.UF_ORIGEM;
    gDsUFDestino := pParams.UF_DESTINO;
  end else begin
    gDsUFOrigem := PARAM_GLB.UF_ORIGEM;
    gDsUFDestino := pParams.UF_DESTINO;
  end;
  vCdProduto := pParams.CD_PRODUTO;
  vCdMPTer := pParams.CD_MPTER;
  gCdServico := pParams.CD_SERVICO;
  vCdOperacao := pParams.CD_OPERACAO;
  vCdPessoa := pParams.CD_PESSOA;
  vTpAreaComercio := pParams.TP_AREACOMERCIO;
  vTpAreaComercioOrigem  := PARAM_GLB.TP_AREA_COMERCIO_ORIGEM;
  vCdEmpresaParam := pParams.CD_EMPRESA;
  if (vCdEmpresaParam = 0) then begin
    vCdEmpresaParam := PARAM_GLB.CD_EMPRESA;
  end;
  gTpModDctoFiscal := pParams.TP_MODDCTOFISCAL;
  gTpOrigemEmissao := pParams.TP_ORIGEMEMISSAO; //1 - Própria / 2 - Terceiros;
  vCdRegraFiscalParam := pParams.CD_REGRAFISCAL;
  gInContribuinte := pParams.IN_CONTRIBUINTE;
  vCdCFOP := 0;
  vInDecreto := False;
  gCdDecreto := 0;

  if (gDsUFDestino = '') then begin
    raise Exception.Create('UF destino não informada!' + ' / ' + cDS_METHOD);
    exit;
  end;
  if (vCdOperacao = 0) then begin
    raise Exception.Create('Operação não informada!' + ' / ' + cDS_METHOD);
    exit;
  end;
  if (vCdPessoa = 0) then begin
    raise Exception.Create('Pessoa não informada!' + ' / ' + cDS_METHOD);
    exit;
  end;

  fGER_OPERACAO.Limpar();
  fGER_OPERACAO.CD_OPERACAO := vCdOperacao;
  fGER_OPERACAO.Listar(nil);
  if (itemXmlF('status', voParams) < 0) then begin
    raise Exception.Create('Operação ' + FloatToStr(vCdOperacao) + ' não cadastrada!' + ' / ' + cDS_METHOD);
    exit;
  end;

  if (vCdRegraFiscalParam > 0) then begin
    fGER_OPERACAO.CD_REGRAFISCAL := vCdRegraFiscalParam;
  end;

  if (vCdProduto = 0)
  and (vCdMPTer = '')
  and (gCdServico = 0) then begin
    exit;
  end;

  if (vCdMPTer <> '') then begin
    fCDF_MPTER.Limpar();
    fCDF_MPTER.CD_PESSOA := vCdPessoa;
    fCDF_MPTER.CD_MPTER := vCdMPTer;
    fCDF_MPTER.Listar(nil);
    if (itemXmlF('status', voParams) < 0) then begin
      raise Exception.Create('Matéria-prima ' + vCdMPTer + ' não cadastrada para a pessoa ' + FloatToStr(vCdPessoa) + '!' + ' / ' + cDS_METHOD);
      exit;
    end;
  end else begin
    fPRD_PRODUTO.Limpar();
    fPRD_PRODUTO.CD_PRODUTO := vCdProduto;
    fPRD_PRODUTO.Listar(nil);
    if (itemXmlF('status', voParams) < 0) then begin
      raise Exception.Create('Produto ' + FloatToStr(vCdProduto) + ' não cadastrado!' + ' / ' + cDS_METHOD);
      exit;
    end;
  end;

  fPES_PESSOA.Limpar();
  fPES_PESSOA.CD_PESSOA := vCdPessoa;
  fPES_PESSOA.Listar(nil);
  if (itemXmlF('status', voParams) < 0) then begin
    raise Exception.Create('Pessoa ' + FloatToStr(vCdPessoa) + ' não cadastrada!' + ' / ' + cDS_METHOD);
    exit;
  end;

  //Venda / Devolução de venda
  if ((fGER_OPERACAO.TP_OPERACAO = 'S') and (fGER_OPERACAO.TP_MODALIDADE = '4'))
  or ((fGER_OPERACAO.TP_OPERACAO = 'E') and (fGER_OPERACAO.TP_MODALIDADE = '3')) then begin
    fPES_CLIENTE.Limpar();
    fPES_CLIENTE.CD_CLIENTE := vCdPessoa;
    fPES_CLIENTE.Listar(nil);
    if (itemXmlF('status', voParams) < 0) then begin
      raise Exception.Create('Cliente ' + FloatToStr(vCdPessoa) + ' não cadastrado!' + ' / ' + cDS_METHOD);
      exit;
    end;
  end;

  // Implementado por Deusdete em 22/03/2007, situação emergencial na Krindges;
  // Se for pessoa Jurídica e não tiver inscrição estadual, isto é, Isento, deverá ser tratado para fazer o cálculo do imposto
  // com a alíquota interna.;
  gInPjIsento := False;
  if (fPES_PESJURIDICA.NR_INSCESTL = 'ISENTO')
  or (fPES_PESJURIDICA.NR_INSCESTL = 'ISENTA')
  or (fPES_PESJURIDICA.NR_INSCESTL = 'ISENTOS')
  or (fPES_PESJURIDICA.NR_INSCESTL = 'ISENTAS') then begin
    if (fPES_PESJURIDICA.TP_REGIMETRIB <> '6') then begin // MEI (Micro Empresário Individual)
      gInPjIsento := True;
    end;
  end;

  if (gTpOrigemEmissao = 2) then begin //Terceiros
    if (fGER_OPERACAO.TP_MODALIDADE <> '3') then begin //Devolução
      vDsUF := gDsUFOrigem;
      gDsUFOrigem := gDsUFDestino;
      gDsUFDestino := vDsUF;
    end;
  end else begin
    if ((fGER_OPERACAO.TP_MODALIDADE = '3') and (fGER_OPERACAO.TP_OPERACAO = 'S')) then begin //Devolução compra
      vDsUF := gDsUFOrigem;
      gDsUFOrigem := gDsUFDestino;
      gDsUFDestino := vDsUF;
    end;
  end;

  viParams := '';
  viParams.CD_PESSOA := vCdPessoa;
  voParams := activateCmp('FCRSVCO057', 'validaPessoaOrgaoPublico', viParams);
  if (itemXmlF('status', voParams) < 0) then begin
    raise Exception.Create(itemXml('message', voParams));
    exit;
  end;
  vInOrgaoPublico := voParams.IN_ORGAOPUBLICO;

  if (vInOrgaoPublico) and (gDsUFOrigem = 'DF') then begin
    gInContribuinte := True;
  end else begin
    if (fPES_CLIENTE.IN_CNSRFINAL) or (fPES_PESSOA.TP_PESSOA = 'F') or (gInPjIsento) then begin
      if not (fPES_CLIENTE.IN_CNSRFINAL) and (fPES_PESSOA.TP_PESSOA = 'J') and (gInPjIsento) then begin
        gInContribuinte := True;
      end else begin
        if (fPES_PESSOA.TP_PESSOA = 'F')
        and (fPES_CLIENTE.NR_CODIGOFISCAL <> '')
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
    vCdRegraFiscal := fGER_OPERACAO.CD_REGRAFISCAL;
    if (vCdRegraFiscal = 0) then begin
      raise Exception.Create('Nenhuma regra fiscal cadastrada p/ a operação ' + FloatToStr(vCdOperacao) + '!' + ' / ' + cDS_METHOD);
      exit;
    end;
  end else if (vCdMPTer <> '') then begin
    vInProdPropria := False;
    vCdRegraFiscal := fGER_OPERACAO.CD_REGRAFISCAL;
    if (vCdRegraFiscal = 0) then begin
      raise Exception.Create('Nenhuma regra fiscal cadastrada p/ a operação ' + FloatToStr(vCdOperacao) + '!' + ' / ' + cDS_METHOD);
      exit;
    end;
  end else begin
    viParams := '';
    viParams.CD_EMPRESA := vCdEmpresaParam;
    viParams.CD_PRODUTO := vCdProduto;
    voParams := activateCmp('PRDSVCO007', 'buscaDadosFilial', viParams); // PRDSVCO008
    if (itemXmlF('status', voParams) < 0) then begin
      raise Exception.Create(itemXml('message', voParams));
      exit;
    end;
    vInProdPropria := voParams.IN_PRODPROPRIA;

    fPRD_PRDREGRAFISCAL.Limpar();
    fPRD_PRDREGRAFISCAL.CD_PRODUTO := vCdProduto;
    fPRD_PRDREGRAFISCAL.CD_OPERACAO := vCdOperacao;
    fPRD_PRDREGRAFISCAL.Listar(nil);
    if (xStatus >= 0) then begin
      fFIS_REGRAFISCAL.Limpar();
      fFIS_REGRAFISCAL.CD_REGRAFISCAL := fPRD_PRDREGRAFISCAL.CD_REGRAFISCAL;
      fFIS_REGRAFISCAL.Listar(nil);
      if (itemXmlF('status', voParams) < 0) then begin
        raise Exception.Create('Regra fiscal ' + fPRD_PRDREGRAFISCAL.CD_REGRAFISCAL + ' não cadastrada!' + ' / ' + cDS_METHOD);
        exit;
      end else begin
        if (fFIS_REGRAFISCAL.CD_DECRETO = 2155)
        or (fFIS_REGRAFISCAL.CD_DECRETO = 1020)
        or (fFIS_REGRAFISCAL.CD_DECRETO = 45471)
        or (fFIS_REGRAFISCAL.CD_DECRETO = 23731)
        or (fFIS_REGRAFISCAL.CD_DECRETO = 23732)
        or (fFIS_REGRAFISCAL.CD_DECRETO = 23733)
        or (fFIS_REGRAFISCAL.CD_DECRETO = 23734)
        or (fFIS_REGRAFISCAL.CD_DECRETO = 23735)
        or (fFIS_REGRAFISCAL.CD_DECRETO = 10201)
        or (fFIS_REGRAFISCAL.CD_DECRETO = 10202)
        or (fFIS_REGRAFISCAL.CD_DECRETO = 10203) then begin
          if (gInContribuinte) then begin
            vCdRegraFiscal := fPRD_PRDREGRAFISCAL.CD_REGRAFISCAL;
          end else begin
            vCdRegraFiscal := fGER_OPERACAO.CD_REGRAFISCAL;
          end;
        end else begin
          vCdRegraFiscal := fPRD_PRDREGRAFISCAL.CD_REGRAFISCAL;
        end;
      end;
    end else begin
      vCdRegraFiscal := fGER_OPERACAO.CD_REGRAFISCAL;
    end;

    if (vCdRegraFiscal = 0) then begin
      raise Exception.Create('Nenhuma regra fiscal cadastrada p/ o produto ' + FloatToStr(vCdProduto) + ' e a operação ' + FloatToStr(vCdOperacao) + '!' + ' / ' + cDS_METHOD);
      exit;
    end;
    vCdCST := Copy(fPRD_PRODUTO.CD_CST, 1, 1);
  end;

  if (vCdRegraFiscalParam > 0) then begin
    vCdRegraFiscal := vCdRegraFiscalParam;
  end;

  fFIS_REGRAFISCAL.Limpar();
  fFIS_REGRAFISCAL.CD_REGRAFISCAL := fGER_OPERACAO.CD_REGRAFISCAL;
  fFIS_REGRAFISCAL.Listar(nil);
  if (itemXmlF('status', voParams) < 0) then begin
    raise Exception.Create('Regra fiscal ' + fGER_OPERACAO.CD_REGRAFISCAL + '!' + ' / ' + cDS_METHOD);
    exit;
  end;
  if (vInProdPropria) then begin
    vCdCFOPOperacao := fFIS_REGRAFISCAL.CD_CFOPPROPRIA;
  end else begin
    vCdCFOPOperacao := fFIS_REGRAFISCAL.CD_CFOPTERCEIRO;
  end;
  vCdCSTOperacao := Copy(fFIS_REGRAFISCAL.CD_CST, 1, 2);

  fFIS_REGRAFISCAL.Limpar();
  fFIS_REGRAFISCAL.CD_REGRAFISCAL := vCdRegraFiscal;
  fFIS_REGRAFISCAL.Listar(nil);
  if (fFIS_REGRAFISCAL.CD_REGRAFISCAL = '') then begin
    raise Exception.Create('Regra fiscal ' + FloatToStr(vCdRegraFiscal) + ' não cadastrada!' + ' / ' + cDS_METHOD);
    exit;
  end else begin
    if (fFIS_REGRAFISCAL.CD_DECRETO = 2155) then begin
      if (gDsUFOrigem = 'PR') or (gDsUFOrigem = 'RS') or (gDsUFOrigem = 'SC') then begin
        if (gInContribuinte) and (fGER_OPERACAO.TP_MODALIDADE = 4) then begin // 4 - Venda/Compra
          if (gDsUFDestino = 'PR') or (gDsUFDestino = 'RS') or (gDsUFDestino = 'SC') then begin
            if (fGER_OPERACAO.TP_OPERACAO = 'S') then begin // S - Saida
              if (vInProdPropria) then begin
                vCdCFOP := 5401;
              end else begin
                vCdCFOP := 5403;
              end;
            end else begin
              if (vInProdPropria) then begin
                vCdCFOP := 1401;
              end else begin
                vCdCFOP := 1403;
              end;
            end;
            vInDecreto := True;
          end;
        end;
      end;
    end else if (fFIS_REGRAFISCAL.CD_DECRETO = 1020)
             or (fFIS_REGRAFISCAL.CD_DECRETO = 10201)
             or (fFIS_REGRAFISCAL.CD_DECRETO = 10202)
             or (fFIS_REGRAFISCAL.CD_DECRETO = 10203) then begin
      if (gDsUFOrigem = 'PR') or (gDsUFOrigem = 'SC') or (gDsUFOrigem = 'MG') then begin
        if (gInContribuinte) and (fGER_OPERACAO.TP_MODALIDADE = 4) then begin // 4 - Venda/Compra
          if (gDsUFDestino = 'PR') or (gDsUFDestino = 'SC') or (gDsUFDestino = 'MG') then begin
            if (fGER_OPERACAO.TP_OPERACAO = 'S') then begin // S - Saida
              if (vInProdPropria) then begin
                vCdCFOP := 5401;
              end else begin
                vCdCFOP := 5403;
              end;
            end else begin
              if (vInProdPropria) then begin
                vCdCFOP := 1401;
              end else begin
                vCdCFOP := 1403;
              end;
            end;
            vInDecreto := True;
          end;
        end;
      end;
    end else if (fFIS_REGRAFISCAL.CD_DECRETO = 45471) then begin
      if (gDsUFOrigem = 'RS') or (gDsUFOrigem = 'PR') or (gDsUFOrigem = 'SC') then begin
        if (gInContribuinte) and (fGER_OPERACAO.TP_MODALIDADE = 4) then begin // 4 - Venda/Compra
          if (gDsUFDestino = 'PR') or (gDsUFDestino = 'RS') or (gDsUFDestino = 'SC') then begin
            if (fGER_OPERACAO.TP_OPERACAO = 'S') then begin // S - Saida
              if (vInProdPropria) then begin
                vCdCFOP := 5401;
              end else begin
                vCdCFOP := 5403;
              end;
            end else begin
              if (vInProdPropria) then begin
                vCdCFOP := 1401;
              end else begin
                vCdCFOP := 1403;
              end;
            end;
            vInDecreto := True;
          end;
        end;
      end;
    end else if (fFIS_REGRAFISCAL.CD_DECRETO = 23731)
             or (fFIS_REGRAFISCAL.CD_DECRETO = 23732)
             or (fFIS_REGRAFISCAL.CD_DECRETO = 23733)
             or (fFIS_REGRAFISCAL.CD_DECRETO = 23734)
             or (fFIS_REGRAFISCAL.CD_DECRETO = 23735) then begin

      if (gDsUFOrigem = 'PR') or (gDsUFDestino = 'PR') then begin
        if (gInContribuinte) and (fGER_OPERACAO.TP_MODALIDADE = 4) then begin // 4 - Venda/Compra
          if (fGER_OPERACAO.TP_OPERACAO = 'S') then begin // S - Saida
            if (vInProdPropria) then begin
              vCdCFOP := 5401;
            end else begin
              vCdCFOP := 5403;
            end;
          end else begin
            if (vInProdPropria) then begin
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

  if not (vInDecreto) then begin
    if (vInProdPropria) then begin
      vCdCFOP := fFIS_REGRAFISCAL.CD_CFOPPROPRIA;
    end else begin
      vCdCFOP := fFIS_REGRAFISCAL.CD_CFOPTERCEIRO;
    end;

    if (vTpAreaComercio > 0) then begin
      if (vTpAreaComercio = 2) and (vTpAreaComercioOrigem = 2) then begin // 2 - Manaus
      end else begin
        if (fGER_OPERACAO.TP_OPERACAO = 'S') and (fGER_OPERACAO.TP_MODALIDADE = 4) then begin //Venda
          vCdCST := Copy(fPRD_PRODUTO.CD_CST, 1, 1);
          if (vCdCST = '1') then begin
            if (vInProdPropria) then begin
              vCdCFOP := 5101;
            end else begin
              vCdCFOP := 5102;
            end;
          end else begin
            if (vInProdPropria) then begin
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
    viParams.CD_REGRAFISCAL := vCdRegraFiscal;
    voParams := activateCmp('FISSVCO033', 'buscaDadosRegraFiscal', viParams);
    if (itemXmlF('status', voParams) < 0) then begin
      raise Exception.Create(itemXml('message', voParams));
      exit;
    end;

    vCdCFOPServico := voParams.CD_CFOPSERVICO;
    if (vCdCFOPServico <> 0) then begin
      vCdCFOP := vCdCFOPServico;
    end;
  end else begin
    if (Copy(fFIS_REGRAFISCAL.CD_CST, 1, 2) = '60')   then begin
      vCdCST := Copy(fFIS_REGRAFISCAL.CD_CST, 1, 1);
      if (gDsUFOrigem <> gDsUFDestino)  then begin
        if (gInContribuinte) then begin
          vCdCST := vCdCST + '10';
        end else begin
          vCdCST := vCdCST + FloatToStr(vCdCFOPOperacao);
          vCdCFOP := vCdCFOPOperacao;
        end;
      end else begin
        vCdCST := vCdCST + '60';
      end;
    end;

    if not (vInDecreto) then begin // Só chamar este serviço se não tiver decreto na regra
      if (Copy(fFIS_REGRAFISCAL.CD_CST, 1, 2) = '10') or (Copy(vCdCST,1,2) = '10') then begin
        vTpOperacao := fGER_OPERACAO.TP_OPERACAO;

        viParams := '';
        viParams.CD_PRODUTO := fPRD_PRODUTO.CD_PRODUTO;
        viParams.UF_ORIGEM := gDsUFOrigem;
        viParams.UF_DESTINO := gDsUFDestino;
        viParams.TP_OPERACAO := vTpOperacao;
        voParams := activateCmp('FISSVCO035', 'buscaDadosFiscalProduto', viParams);
        if (itemXmlF('status', voParams) < 0) then begin
          raise Exception.Create(itemXml('message', voParams));
          exit;
        end;
        vPrIvaPrd := voParams.PR_SUBSTRIB;

        if (vPrIvaPrd = 0) then begin
          vCdCFOP := vCdCFOPOperacao;
        end;
      end;
    end;
  end;

  if (fGER_OPERACAO.TP_OPERACAO = 'E') then begin //Entrada
    if (vCdCFOP >= 4000) then begin
      raise Exception.Create('CFOP ' + FloatToStr(vCdCFOP) + ' do produto ' + FloatToStr(vCdProduto) + ' incompatível com a operação de entrada ' + FloatToStr(vCdOperacao) + '!' + ' / ' + cDS_METHOD);
      exit;
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
      raise Exception.Create('CFOP ' + FloatToStr(vCdCFOP) + ' do produto ' + FloatToStr(vCdProduto) + ' incompatível com a operação de saída ' + FloatToStr(vCdOperacao) + '!' + ' / ' + cDS_METHOD);
      exit;
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

  if not (vCdCFOP = 6101) and (gInContribuinte) then begin
    vCdCFOP := 6107;
  end;

  if not (vCdCFOP = 6102) and (gInContribuinte) then begin
    vCdCFOP := 6108;
  end  ;

  if (Copy(fFIS_REGRAFISCAL.CD_CST, 1, 2) = '70') then begin
    if (gDsUFOrigem = 'GO') then begin
      if (gDsUFOrigem <> gDsUFDestino) or (vInProdPropria <> True) or (gInContribuinte <> True) then begin
        if (vCdCFOP = 5405) then begin          // Como a regra fiscal esta como a CFOP generica 06, pois toda venda p/
          if (vInProdPropria) then begin // não contribuinte deverá sair com o CFOP interno de venda
             vCdCFOP := 5101;
          end else begin
            vCdCFOP := 5102;
          end;
        end;
        if (vCdCFOP = 6401) then begin
          if (gInContribuinte) then begin
             vCdCFOP := 6101;
          end else begin
            vCdCFOP := 6107;
          end;
        end;
      end;
    end;
  end;

  if (Copy(fFIS_REGRAFISCAL.CD_CST, 1, 2) = '60') then begin
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
  Result.CD_CFOP := vCdCFOP;
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
  vCdRegraFiscalParam : Real;
begin
  Result := '';

  gDsUFOrigem := PARAM_GLB.UF_ORIGEM;
  vInOptSimples := PARAM_GLB.IN_OPT_SIMPLES;

  gDsUFDestino   := pParams.UF_DESTINO;
  vCdProduto  := pParams.CD_PRODUTO;
  vCdMPTer   := pParams.CD_MPTER;
  gCdServico := pParams.CD_SERVICO;
  vCdPessoa := pParams.CD_PESSOA;
  vCdOperacao := pParams.CD_OPERACAO;
  vTpAreaComercio := pParams.TP_AREACOMERCIO;
  vTpAreaComercioOrigem  := PARAM_GLB.TP_AREA_COMERCIO_ORIGEM;
  vCdCFOP := pParams.CD_CFOP;
  vCdEmpresaParam  := pParams.CD_EMPRESA;
  if (vCdEmpresaParam = 0) then begin
    vCdEmpresaParam := PARAM_GLB.CD_EMPRESA;
  end;
  gTpModDctoFiscal := pParams.TP_MODDCTOFISCAL;
  gTpOrigemEmissao := pParams.TP_ORIGEMEMISSAO; //1 - Própria / 2 - Terceiros
  vCdRegraFiscalParam := pParams.CD_REGRAFISCAL;
  gInContribuinte := False;
  vInDecreto := False;

  if (vCdOperacao = 0) then begin
    raise Exception.Create('Operação não informada!' + ' / ' + cDS_METHOD);
    exit;
  end;
  if (vCdPessoa = 0) then begin
    raise Exception.Create('Pessoa não informada!' + ' / ' + cDS_METHOD);
    exit;
  end;

  fGER_OPERACAO.Limpar();
  fGER_OPERACAO.CD_OPERACAO := vCdOperacao;
  fGER_OPERACAO.Listar(nil);
  if (itemXmlF('status', voParams) < 0) then begin
    raise Exception.Create('Operação ' + FloatToStr(vCdOperacao) + ' não cadastrada!' + ' / ' + cDS_METHOD);
    exit;
  end;

  if (vCdProduto = 0)
  and (vCdMPTer = '')
  and (gCdServico = 0) then begin
    exit;
  end;

  if (vCdCFOP = 0) then begin
    raise Exception.Create('CFOP não informada!' + ' / ' + cDS_METHOD);
    exit;
  end;

  if (vCdMPTer <> '') then begin
    fCDF_MPTER.Limpar();
    fCDF_MPTER.CD_PESSOA := vCdPessoa;
    fCDF_MPTER.CD_MPTER := vCdMPTer;
    fCDF_MPTER.Listar(nil);
    if (itemXmlF('status', voParams) < 0) then begin
      raise Exception.Create('Matéria-prima ' + vCdMPTer + ' não cadastrada para a pessoa ' + FloatToStr(vCdPessoa) + '!' + ' / ' + cDS_METHOD);
      exit;
    end;
  end else begin
    fPRD_PRODUTO.Limpar();
    fPRD_PRODUTO.CD_PRODUTO := vCdProduto;
    fPRD_PRODUTO.Listar(nil);
    if (itemXmlF('status', voParams) < 0) then begin
      raise Exception.Create('Produto ' + FloatToStr(vCdProduto) + ' não cadastrado!' + ' / ' + cDS_METHOD);
      exit;
    end;
  end;

  fGER_OPERACAO.Limpar();
  fGER_OPERACAO.CD_OPERACAO := vCdOperacao;
  fGER_OPERACAO.Listar(nil);
  if (itemXmlF('status', voParams) < 0) then begin
    raise Exception.Create('Operação ' + FloatToStr(vCdOperacao) + ' não cadastrada!' + ' / ' + cDS_METHOD);
    exit;
  end;

  if (vCdRegraFiscalParam > 0) then begin
    fGER_OPERACAO.CD_REGRAFISCAL := vCdRegraFiscalParam;
  end;

  fFIS_REGRAFISCAL.Limpar();
  fFIS_REGRAFISCAL.CD_REGRAFISCAL := fGER_OPERACAO.CD_REGRAFISCAL;
  fFIS_REGRAFISCAL.Listar(nil);
  if (itemXmlF('status', voParams) < 0) then begin
    raise Exception.Create('Regra fiscal ' + FloatToStr(vCdRegraFiscal) + ' não cadastrada!' + ' / ' + cDS_METHOD);
    exit;
  end;
  vCdCSTOperacao := Copy(fFIS_REGRAFISCAL.CD_CST, 1, 2);

  fPES_PESSOA.Limpar();
  fPES_PESSOA.CD_PESSOA := vCdPessoa;
  fPES_PESSOA.Listar(nil);
  if (itemXmlF('status', voParams) < 0) then begin
    raise Exception.Create('Pessoa ' + FloatToStr(vCdPessoa) + ' não cadastrada!' + ' / ' + cDS_METHOD);
    exit;
  end;

  fPES_PFADIC.Limpar();
  fPES_PFADIC.CD_PESSOA := vCdPessoa;
  fPES_PFADIC.Listar(nil);
  if (itemXmlF('status', voParams) < 0) then begin
    fPES_PFADIC.Limpar();
  end;

  if ((fGER_OPERACAO.TP_OPERACAO = 'S') and (fGER_OPERACAO.TP_MODALIDADE = 4))
  or ((fGER_OPERACAO.TP_OPERACAO = 'E') and (fGER_OPERACAO.TP_MODALIDADE = 3)) then begin //Venda / Devolução de venda
    fPES_CLIENTE.Limpar();
    fPES_CLIENTE.CD_CLIENTE := vCdPessoa;
    fPES_CLIENTE.Listar(nil);
    if (itemXmlF('status', voParams) < 0) then begin
      raise Exception.Create('Cliente ' + FloatToStr(vCdPessoa) + ' não cadastrado!' + ' / ' + cDS_METHOD);
      exit;
    end;
  end;

  // Implementado por Deusdete em 22/03/2007, situação emergencial na Krindges;
  // Se for pessoa Jurídica e não tiver inscrição estadual, isto é, Isento, deverá ser tratado para fazer o cálculo do imposto then begin
  // com a alíquota interna.;
  gInPjIsento := False;
  if (fPES_PESJURIDICA.NR_INSCESTL = 'ISENTO')
  or (fPES_PESJURIDICA.NR_INSCESTL = 'ISENTA')
  or (fPES_PESJURIDICA.NR_INSCESTL = 'ISENTOS')
  or (fPES_PESJURIDICA.NR_INSCESTL = 'ISENTAS') then begin
    gInPjIsento := True;
  end;

  if (gTpOrigemEmissao = 2) then begin //Terceiros
    if (fGER_OPERACAO.TP_MODALIDADE <> 3) then begin //Devolução
      vDsUF := gDsUFOrigem;
      gDsUFOrigem := gDsUFDestino;
      gDsUFDestino := vDsUF;
    end;
  end else begin
    if (fGER_OPERACAO.TP_MODALIDADE = 3) and (fGER_OPERACAO.TP_OPERACAO = 'S') then begin //Devolução compra
      vDsUF := gDsUFOrigem;
      gDsUFOrigem := gDsUFDestino;
      gDsUFDestino := vDsUF;
    end;
  end;

  viParams := '';
  viParams.CD_PESSOA := vCdPessoa;
  voParams := activateCmp('FCRSVCO057', 'validaPessoaOrgaoPublico', viParams);
  if (itemXmlF('status', voParams) < 0) then begin
    raise Exception.Create(itemXml('message', voParams));
    exit;
  end;
  vInOrgaoPublico := voParams.IN_ORGAOPUBLICO;

  if (vInOrgaoPublico) and (gDsUFOrigem = 'DF') then begin
    gInContribuinte := True;
  end else begin
    if (fPES_CLIENTE.IN_CNSRFINAL) or (fPES_PESSOA.TP_PESSOA = 'F') or (gInPjIsento) then begin
      if not (fPES_CLIENTE.IN_CNSRFINAL) and (fPES_PESSOA.TP_PESSOA = 'J') and (gInPjIsento) then begin
        gInContribuinte := True;
      end else begin
        if (fPES_PESSOA.TP_PESSOA = 'F')
        and (fPES_CLIENTE.NR_CODIGOFISCAL <> '')
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
    vCdRegraFiscal := fGER_OPERACAO.CD_REGRAFISCAL;
    if (vCdRegraFiscal = 0) then begin
      raise Exception.Create('Nenhuma regra fiscal cadastrada p/ a operação ' + FloatToStr(vCdOperacao) + '!' + ' / ' + cDS_METHOD);
      exit;
    end;
    vCdCST := '0';
  end else if (vCdMPTer <> '') then begin
    vInProdPropria := False;
    vCdRegraFiscal := fGER_OPERACAO.CD_REGRAFISCAL;
    if (vCdRegraFiscal = 0) then begin
      raise Exception.Create('Nenhuma regra fiscal cadastrada p/ a operação ' + FloatToStr(vCdOperacao) + '!' + ' / ' + cDS_METHOD);
      exit;
    end;
    vCdCST := Copy(fCDF_MPTER.CD_CST, 1, 1);
  end else begin
    viParams := '';
    viParams.CD_EMPRESA := vCdEmpresaParam;
    viParams.CD_PRODUTO := vCdProduto;
    voParams := activateCmp('PRDSVCO007', 'buscaDadosFilial', viParams);
    if (itemXmlF('status', voParams) < 0) then begin
      raise Exception.Create(itemXml('message', voParams));
      exit;
    end;
    vInProdPropria := voParams.IN_PRODPROPRIA;

    fPRD_PRDREGRAFISCAL.Limpar();
    fPRD_PRDREGRAFISCAL.CD_PRODUTO := vCdProduto;
    fPRD_PRDREGRAFISCAL.CD_OPERACAO := vCdOperacao;
    fPRD_PRDREGRAFISCAL.Listar(nil);
    if (xStatus >= 0) then begin
      fFIS_REGRAFISCAL.Limpar();
      fFIS_REGRAFISCAL.CD_REGRAFISCAL := fPRD_PRDREGRAFISCAL.CD_REGRAFISCAL;
      fFIS_REGRAFISCAL.Listar(nil);
      if (itemXmlF('status', voParams) < 0) then begin
        raise Exception.Create('Regra fiscal ' + fPRD_PRDREGRAFISCAL.CD_REGRAFISCAL + ' não cadastrada!' + ' / ' + cDS_METHOD);
        exit;
      end else begin
        if (fFIS_REGRAFISCAL.CD_DECRETO = 2155)
        or (fFIS_REGRAFISCAL.CD_DECRETO = 1020)
        or (fFIS_REGRAFISCAL.CD_DECRETO = 45471)
        or (fFIS_REGRAFISCAL.CD_DECRETO = 23731)
        or (fFIS_REGRAFISCAL.CD_DECRETO = 23732)
        or (fFIS_REGRAFISCAL.CD_DECRETO = 23733)
        or (fFIS_REGRAFISCAL.CD_DECRETO = 23734)
        or (fFIS_REGRAFISCAL.CD_DECRETO = 23735)
        or (fFIS_REGRAFISCAL.CD_DECRETO = 10201)
        or (fFIS_REGRAFISCAL.CD_DECRETO = 10202)
        or (fFIS_REGRAFISCAL.CD_DECRETO = 10203) then begin
          if (gInContribuinte) then begin
            vCdRegraFiscal := fPRD_PRDREGRAFISCAL.CD_REGRAFISCAL;
          end else begin
            vCdRegraFiscal := fGER_OPERACAO.CD_REGRAFISCAL;
          end;
        end else begin
          vCdRegraFiscal := fPRD_PRDREGRAFISCAL.CD_REGRAFISCAL;
        end;
      end;
    end else begin
      vCdRegraFiscal := fGER_OPERACAO.CD_REGRAFISCAL;
    end  ;

    if (vCdRegraFiscal = 0) then begin
      raise Exception.Create('Nenhuma regra fiscal cadastrada p/ o produto ' + FloatToStr(vCdProduto) + ' e a operação ' + FloatToStr(vCdOperacao) + '!' + ' / ' + cDS_METHOD);
      exit;
    end;

    vCdCST := Copy(fPRD_PRODUTO.CD_CST, 1, 1);
  end;

  if (vCdRegraFiscalParam > 0) then begin
    vCdRegraFiscal := vCdRegraFiscalParam;
  end;

  fFIS_REGRAFISCAL.Limpar();
  fFIS_REGRAFISCAL.CD_REGRAFISCAL := vCdRegraFiscal;
  fFIS_REGRAFISCAL.Listar(nil);
  if (itemXmlF('status', voParams) < 0) then begin
    raise Exception.Create('Regra fiscal ' + FloatToStr(vCdRegraFiscal) + ' não cadastrada!' + ' / ' + cDS_METHOD);
    exit;
  end else begin
    if (fFIS_REGRAFISCAL.CD_DECRETO = 2155) then begin
      if (gDsUFOrigem = 'PR') or (gDsUFOrigem = 'RS') or (gDsUFOrigem = 'SC') then begin
        if (gInContribuinte) and (fGER_OPERACAO.TP_MODALIDADE = 4) then begin // 4 - Venda/Compra
          if (gDsUFDestino = 'PR') or (gDsUFDestino = 'RS') or (gDsUFDestino = 'SC') then begin
            vCdCST := Copy(fPRD_PRODUTO.CD_CST, 1, 1);
            vCdCST := vCdCST + '10';
            vInDecreto := True;
          end;
        end;
      end;
    end else if (fFIS_REGRAFISCAL.CD_DECRETO = 1020)
             or (fFIS_REGRAFISCAL.CD_DECRETO = 10201)
             or (fFIS_REGRAFISCAL.CD_DECRETO = 10202)
             or (fFIS_REGRAFISCAL.CD_DECRETO = 10203) then begin
      if (gDsUFOrigem = 'PR') or (gDsUFOrigem = 'SC') or (gDsUFOrigem = 'MG') then begin
        if (gInContribuinte) and (fGER_OPERACAO.TP_MODALIDADE = 4) then begin // 4 - Venda/Compra
          if (gDsUFDestino = 'PR') or (gDsUFDestino = 'SC') or (gDsUFDestino = 'MG') then begin
            vCdCST := Copy(fPRD_PRODUTO.CD_CST, 1, 1);
            vCdCST := vCdCST + '10';
            vInDecreto := True;
          end;
        end;
      end;
    end else if (fFIS_REGRAFISCAL.CD_DECRETO = 45471) then begin
      if (gDsUFOrigem = 'RS') or (gDsUFOrigem = 'PR') or (gDsUFOrigem = 'SC') then begin
        if (gInContribuinte) and (fGER_OPERACAO.TP_MODALIDADE = 4) then begin // 4 - Venda/Compra
          if (gDsUFDestino = 'PR') or (gDsUFDestino = 'RS') or (gDsUFDestino = 'SC') then begin
            vCdCST := Copy(fPRD_PRODUTO.CD_CST, 1, 1);
            vCdCST := vCdCST + '10';
            vInDecreto := True;
          end;
        end;
      end;
    end else if (fFIS_REGRAFISCAL.CD_DECRETO = 23731)
             or (fFIS_REGRAFISCAL.CD_DECRETO = 23732)
             or (fFIS_REGRAFISCAL.CD_DECRETO = 23733)
             or (fFIS_REGRAFISCAL.CD_DECRETO = 23734)
             or (fFIS_REGRAFISCAL.CD_DECRETO = 23735) then begin
      if (gDsUFOrigem = 'PR') or (gDsUFDestino = 'PR') then begin
        if (gInContribuinte) and (fGER_OPERACAO.TP_MODALIDADE = 4) then begin // 4 - Venda/Compra
          vCdCST := Copy(fPRD_PRODUTO.CD_CST, 1, 1);
          vCdCST := vCdCST + '10';
          vInDecreto := True;
        end;
      end;
    end;
  end;

  if not (vInDecreto) then begin
    vCdCST := vCdCST + Copy(fFIS_REGRAFISCAL.CD_CST, 1, 2);
    if (vTpAreaComercio > 0) then begin
      if (vTpAreaComercio = 2) and (vTpAreaComercioOrigem = 2) then begin // 2 - Manaus
      end else begin
        if (fGER_OPERACAO.TP_OPERACAO = 'S') and (fGER_OPERACAO.TP_MODALIDADE = 4) then begin //Venda
          vCdCST := Copy(fFIS_REGRAFISCAL.CD_CST, 1, 1);
          if (vCdCST = '1') or (vCdCST = '2') then begin // Produto inportado
            vCdCST := vCdCST + '00';
          end else begin
            vCdCST := vCdCST + '40';
          end;
        end;
      end;
    end;

    if (Copy(fFIS_REGRAFISCAL.CD_CST, 1, 2) = '70') then begin
      if (gDsUFOrigem = 'GO') then begin
        if (gDsUFOrigem <> gDsUFDestino) or (vInProdPropria <> True) or (gInContribuinte <> True) then begin
          vCdCST := Copy(fPRD_PRODUTO.CD_CST, 1, 1);
          vCdCST := vCdCST + '00';
        end;
      end;
    end;

    if (Copy(fFIS_REGRAFISCAL.CD_CST, 1, 2) = '60')   then begin
      vCdCST := Copy(fPRD_PRODUTO.CD_CST, 1, 1);
      if (gDsUFOrigem <> gDsUFDestino)  then begin
        if (gInContribuinte) then begin
          vCdCST := vCdCST + '10';
        end else begin
          vCdCST := vCdCST + vCdCSTOperacao;
        end;
      end else begin
        vCdCST := vCdCST + '60';
      end;
    end;

    if (Copy(fFIS_REGRAFISCAL.CD_CST, 1, 2) = '10') or (Copy(vCdCST,2,2) = '10') then begin
      vTpOperacao := fGER_OPERACAO.TP_OPERACAO;

      viParams := '';
      viParams.CD_PRODUTO := fPRD_PRODUTO.CD_PRODUTO;
      viParams.UF_ORIGEM := gDsUFOrigem;
      viParams.UF_DESTINO := gDsUFDestino;
      viParams.TP_OPERACAO := vTpOperacao;
      voParams := activateCmp('FISSVCO035', 'buscaDadosFiscalProduto', viParams);
      if (itemXmlF('status', voParams) < 0) then begin
        raise Exception.Create(itemXml('message', voParams));
        exit;
      end;
      vPrIvaPrd := voParams.PR_SUBSTRIB;

      if (vPrIvaPrd = 0) then begin
        vCdCST := Copy(fPRD_PRODUTO.CD_CST, 1, 1);
        vCdCST := vCdCST + vCdCSTOperacao;
      end else if (Copy(vCdCST,2,2) <> '10') then begin
        vCdCST := Copy(fPRD_PRODUTO.CD_CST, 1, 1);
        vCdCST := vCdCST + Copy(fFIS_REGRAFISCAL.CD_CST, 1, 2);
      end;
    end;

    if (gInContribuinte) and (Copy(vCdCST,2,2) = '20') then begin
      vInPrReducao := False;

      if (fFIS_REGRAFISCAL.TP_REDUCAO = 'A') then begin
        if (gDsUFOrigem = gDsUFDestino) then begin
          vInPrReducao := True;
        end;

      end else if (fFIS_REGRAFISCAL.TP_REDUCAO = 'B') then begin
        if (gDsUFOrigem = gDsUFDestino) then begin
          vInPrReducao := True;
        end;

      end else if (fFIS_REGRAFISCAL.TP_REDUCAO = 'C') then begin
        if (gDsUFOrigem = gDsUFDestino) then begin
          vInPrReducao := True;
        end;

      end else if (fFIS_REGRAFISCAL.TP_REDUCAO = 'D') then begin
        if (gDsUFOrigem <> gDsUFDestino) then begin
          vInPrReducao := True;
        end;

      end else if (fFIS_REGRAFISCAL.TP_REDUCAO = 'E') then begin
        if (gDsUFOrigem <> gDsUFDestino) then begin
          vInPrReducao := True;
        end;

      end else if (fFIS_REGRAFISCAL.TP_REDUCAO = 'F') then begin
        if (gDsUFOrigem <> gDsUFDestino) then begin
          vInPrReducao := True;
        end;

      end else if (fFIS_REGRAFISCAL.TP_REDUCAO = 'G') then begin
        vInPrReducao := True;

      end else if (fFIS_REGRAFISCAL.TP_REDUCAO = 'H') then begin
        vInPrReducao := True;

      end else if (fFIS_REGRAFISCAL.TP_REDUCAO = 'I') then begin
        vInPrReducao := True;
      end;

      if not (vInPrReducao) then begin
        vCdCST := Copy(fPRD_PRODUTO.CD_CST, 1, 1);
        vCdCST := vCdCST + '00';
      end;
    end;
  end;

  if (vCdCFOP = 5912) or (vCdCFOP = 1912) then begin
    vCdCST := Copy(fPRD_PRODUTO.CD_CST, 1, 1);
    if (gInOptSimples) then begin
      vCdCST := vCdCST + '41';
    end else begin
      vCdCST := vCdCST + '50';
    end;
  end else if (vCdCFOP = 6912) or (vCdCFOP = 2912) then begin
    vCdCST := Copy(fPRD_PRODUTO.CD_CST, 1, 1);
    if (gInOptSimples) then begin
      vCdCST := vCdCST + '41';
    end else begin
      vCdCST := vCdCST + '00';
    end;
  end;
  if ((fPES_CLIENTE.IN_CNSRFINAL) or (gInContribuinte = False)) and (Copy(vCdCST,2,2) = '10') then begin
    if ((fPES_CLIENTE.IN_CNSRFINAL) and (gInContribuinte))
    or (fPES_PFADIC.IN_AMBULANTE) then begin
    end else begin
      vCdCST := Copy(fPRD_PRODUTO.CD_CST, 1, 1);
      vCdCST := vCdCST + '60';
    end;
  end;
  if (gCdServico > 0) and (fFIS_REGRAFISCAL.IN_ISS) then begin
    vCdCST := '090';
  end;

  fFIS_CST.Limpar();
  fFIS_CST.CD_CST := vCdCST;
  fFIS_CST.Listar(nil);
  if (itemXmlF('status', voParams) < 0) then begin
    raise Exception.Create('CST ' + vCdCST + ' não cadastrado!' + ' / ' + cDS_METHOD);
    exit;
  end;

  Result := '';
  Result.CD_CST := vCdCST;
  return(0);
end;

//----------------------------------
function T_FISSVCO015.calculaImpostoCapa(pParams : String) : String;
//----------------------------------
const
  cDS_METHOD = 'ADICIONAL=Operação: T_FISSVCO015.calculaImpostoCapa()';
var
  viParams, voParams, vDsUF, vDsRegistro, vDsLstImposto, vDsLstCdImposto, vCdCST, vNmMunicipio : String;
  vCdEmpresa, vCdEmpresaParam, vCdOperacao, vCdPessoa, vCdRegraFiscal, vNrSeqEnd, vCdProduto : Real;
  vVlCalc, vVlBaseCalc, vCdImposto, vCdImpRetorno, vVlFrete, vVlSeguro, vVlDespAcessor, vCdDecreto : Real;
  vInIPI, vInSomaFrete, vInOrgaoPublico, vInSubstituicao : Boolean;
  vDtIniVigencia, vDtFimVigencia, vDtSistema : TDateTime;
begin
  Result := '';

  vCdEmpresa := pParams.CD_EMPRESA;
  if (vCdEmpresa = 0) then begin
    vCdEmpresa := PARAM_GLB.CD_EMPRESA;
  end;

  gDsUFOrigem := PARAM_GLB.UF_ORIGEM;
  gDsUFDestino := pParams.UF_DESTINO;
  gTpOrigemEmissao := pParams.TP_ORIGEMEMISSAO; //1 - Própria / 2 - Terceiros
  vCdOperacao := pParams.CD_OPERACAO;
  vCdPessoa := pParams.CD_PESSOA;
  vCdProduto := pParams.CD_PRODUTO;
  vVlFrete := pParams.VL_FRETE;
  vVlSeguro := pParams.VL_SEGURO;
  vVlDespAcessor := pParams.VL_DESPACESSOR;
  vCdCst := pParams.CD_CST;
  vInIPI := pParams.IN_IPI;
  gPrIPI := pParams.PR_IPI;
  gCdDecretoItemCapa := pParams.CD_DECRETO;
  vDtSistema := StrToDate(PARAM_GLB.DT_SISTEMA);
  gTpAreaComercioOrigem  := PARAM_GLB.TP_AREA_COMERCIO_ORIGEM;
  gTpAreaComercioDestino := 0;
  gInContribuinte := False;
  vInSubstituicao := False;

  gVlFrete := pParams.VL_FRETE;
  gVlSeguro := pParams.VL_SEGURO;
  gVlDespAcessor := pParams.VL_DESPACESSOR;

  if (vVlFrete = 0)
  and (vVlSeguro = 0)
  and (vVlDespAcessor = 0)  then begin
    exit;
  end;

  if (gTpOrigemEmissao = 0) then begin
    raise Exception.Create('Tipo emissão não informado!' + ' / ' + cDS_METHOD);
    exit;
  end;
  if (gDsUFDestino = '') then begin
    raise Exception.Create('UF destino não informada!' + ' / ' + cDS_METHOD);
    exit;
  end;
  if (vCdOperacao = 0) then begin
    raise Exception.Create('Operação não informada!' + ' / ' + cDS_METHOD);
    exit;
  end;

  fPRD_PRODUTO.Limpar();

  fGER_OPERACAO.Limpar();
  fGER_OPERACAO.CD_OPERACAO := vCdOperacao;
  fGER_OPERACAO.Listar(nil);
  if (itemXmlF('status', voParams) < 0) then begin
    raise Exception.Create('Operação ' + FloatToStr(vCdOperacao) + ' não cadastrada!' + ' / ' + cDS_METHOD);
    exit;
  end;

  if (fGER_OPERACAO.IN_CALCIMPOSTO <> True) then begin
    exit;
  end;

  // Carrega o codigo do primeiro produto da nota fiscal para a nova logica de Subst. tributaria.
  if (vCdProduto <> 0) then begin
    fPRD_PRODUTO.Limpar();
    fPRD_PRODUTO.CD_PRODUTO := vCdProduto;
    fPRD_PRODUTO.Listar(nil);
    if (itemXmlF('status', voParams) < 0) then begin
      raise Exception.Create('Produto ' + FloatToStr(vCdProduto) + ' não cadastrado!' + ' / ' + cDS_METHOD);
      exit;
    end;

    //Incluído para calcular corretamente o imposto sobre os valores da capa
    viParams := '';
    viParams.CD_EMPRESA := vCdEmpresa;
    viParams.CD_PRODUTO := vCdProduto;
    voParams := activateCmp('PRDSVCO007', 'buscaDadosFilial', viParams); // PRDSVCO008
    if (itemXmlF('status', voParams) < 0) then begin
      raise Exception.Create(itemXml('message', voParams));
      exit;
    end;
    gInProdPropria := voParams.IN_PRODPROPRIA;
  end ;

  fPES_PESSOA.Limpar();
  fPES_PESSOA.CD_PESSOA := vCdPessoa;
  fPES_PESSOA.Listar(nil);
  if (itemXmlF('status', voParams) < 0) then begin
    raise Exception.Create('Pessoa ' + FloatToStr(vCdPessoa) + ' não cadastrada!' + ' / ' + cDS_METHOD);
    exit;
  end;

  if ((fGER_OPERACAO.TP_OPERACAO = 'S') and (fGER_OPERACAO.TP_MODALIDADE = 4))
  or ((fGER_OPERACAO.TP_OPERACAO = 'E') and (fGER_OPERACAO.TP_MODALIDADE = 3)) then begin //Venda / Devolução de venda
    fPES_CLIENTE.Limpar();
    fPES_CLIENTE.CD_CLIENTE := vCdPessoa;
    fPES_CLIENTE.Listar(nil);
    if (itemXmlF('status', voParams) < 0) then begin
      raise Exception.Create('Cliente ' + FloatToStr(vCdPessoa) + ' não cadastrado!' + ' / ' + cDS_METHOD);
      exit;
    end;
  end;

  gInPjIsento := False;
  if (fPES_PESJURIDICA.NR_INSCESTL = 'ISENTO')
  or (fPES_PESJURIDICA.NR_INSCESTL = 'ISENTA')
  or (fPES_PESJURIDICA.NR_INSCESTL = 'ISENTOS')
  or (fPES_PESJURIDICA.NR_INSCESTL = 'ISENTAS') then begin
    gInPjIsento := True;
  end;

  gInVarejista := False;
  if (fPES_PESJURIDICA.CD_ATIVIDADE = gCdAtividadeVarejista) and (gCdAtividadeVarejista <> 0) then begin
    gInVarejista := True;
  end;

  if (gTpOrigemEmissao = 2) then begin //Terceiros
    if (fGER_OPERACAO.TP_MODALIDADE <> 3) then begin //Devolução
      vDsUF := gDsUFOrigem;
      gDsUFOrigem := gDsUFDestino;
      gDsUFDestino := vDsUF;
    end;
  end else begin
    if (fGER_OPERACAO.TP_MODALIDADE = 3) and (fGER_OPERACAO.TP_OPERACAO = 'S') then begin //Devolução compra
      vDsUF := gDsUFOrigem;
      gDsUFOrigem := gDsUFDestino;
      gDsUFDestino := vDsUF;
    end;
  end;

  viParams := '';
  viParams.CD_PESSOA := vCdPessoa;
  voParams := activateCmp('FCRSVCO057', 'validaPessoaOrgaoPublico', viParams);
  if (itemXmlF('status', voParams) < 0) then begin
    raise Exception.Create(itemXml('message', voParams));
    exit;
  end;
  vInOrgaoPublico := voParams.IN_ORGAOPUBLICO;

  if (vInOrgaoPublico) and (gDsUFOrigem = 'DF') then begin
    gInContribuinte := True;
  end else begin
     if (fPES_CLIENTE.IN_CNSRFINAL) or (fPES_PESSOA.TP_PESSOA = 'F') or (gInPjIsento) then begin
      if not (fPES_CLIENTE.IN_CNSRFINAL) and (fPES_PESSOA.TP_PESSOA = 'J') and (gInPjIsento) then begin
        gInContribuinte := True;
      end else begin
        if (fPES_PESSOA.TP_PESSOA = 'F')
        and (fPES_CLIENTE.NR_CODIGOFISCAL <> '')
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
  if (gInOptSimples) then begin
    gTpAreaComercioDestino := 0;
  end else begin
    viParams := '';
    viParams.CD_PESSOA := vCdPessoa;
    voParams := activateCmp('PESSVCO001', 'buscarEnderecoFat', viParams);
    if (voParams.CD_PESSOA <> '') then begin
      gTpAreaComercioDestino := voParams.TP_AREA_COMERCIO;
    end;
  end;

  //A verificação de pessoa jurídica foi comentado dentro do if e colocado aki, pois estava carregando a variável gTpRegimeOrigem somente then begin
  //quando era emissão de terceiros. Esta variável está sendo usado tbm para emissão própria no cálculo do ICMS.
  if (fPES_PESSOA.TP_PESSOA <> 'F') then begin
    if (fPES_PESJURIDICA.IsEmpty()) then begin
      raise Exception.Create('Pessoa ' + FloatToStr(vCdPessoa) + ' não é jurídica!' + ' / ' + cDS_METHOD);
      exit;
    end;
    gTpRegimeOrigem := fPES_PESJURIDICA.TP_REGIMETRIB;
  end;

  if (gInContribuinte = False) and (gDsUFDestino <> 'EX') then begin
    gDsUFDestino := gDsUFOrigem;
  end;

  if (gDsUFDestino = gDsUFOrigem) then begin
    if (gInSomaFreteBaseICMS) then begin
      vInSomaFrete := True;
    end else begin
      if not (gTpOrigemEmissao = 1) and (gInContribuinte) then begin // 1 -Emissão própria
        vInSomaFrete := True;
      end else begin
        vInSomaFrete := False;
      end;
    end;
  end else begin
    vInSomaFrete := True;
  end;

  vVlBaseCalc := vVlSeguro + vVlDespAcessor;
  if (vInSomaFrete) then begin
    vVlBaseCalc := vVlBaseCalc + vVlFrete;
  end;

  gVlTotalLiquido := vVlBaseCalc;
  gVlTotalLiquidoICMS := vVlBaseCalc;
  gVlTotalBruto := vVlSeguro + vVlDespAcessor + vVlFrete;

  if (gTpOrigemEmissao = 2) then begin //Terceiros
    vVlCalc := gVlTotalBruto * gPrIPI / 100;
    gVlIPI := Rounded(vVlCalc, 2);
  end;

  vCdRegraFiscal := fGER_OPERACAO.CD_REGRAFISCAL;

  fPRD_PRDREGRAFISCAL.Limpar();
  fPRD_PRDREGRAFISCAL.CD_PRODUTO := vCdProduto;
  fPRD_PRDREGRAFISCAL.CD_OPERACAO := vCdOperacao;
  fPRD_PRDREGRAFISCAL.Listar(nil);
  if (xStatus >= 0) then begin
    vCdRegraFiscal := fPRD_PRDREGRAFISCAL.CD_REGRAFISCAL;
  end;

  if (vCdRegraFiscal = 0) then begin
    raise Exception.Create('Nenhuma regra fiscal cadastrada p/ a operação ' + FloatToStr(vCdOperacao) + '!' + ' / ' + cDS_METHOD);
    exit;
  end;

  fFIS_REGRAFISCAL.Limpar();
  fFIS_REGRAFISCAL.CD_REGRAFISCAL := vCdRegraFiscal;
  fFIS_REGRAFISCAL.Listar(nil);
  if (itemXmlF('status', voParams) < 0) then begin
    raise Exception.Create('Regra fiscal ' + FloatToStr(vCdRegraFiscal) + ' não cadastrada!' + ' / ' + cDS_METHOD);
    exit;
  end;

  if (vCdCST <> '') then begin
    gCdCST := vCdCST;
  end else begin
    gCdCST := '0' + fFIS_REGRAFISCAL.CD_CST;
  end;
  vCdCST := Copy(gCdCST,2,2);
  if (vCdCST = '10') or (vCdCST = '30') or (vCdCST = '60') or (vCdCST = '70') then begin
    vInSubstituicao := True;
  end;
  if (gCdDecretoItemCapa <> 0) then begin
    fFIS_DECRETOCAPA.Limpar();
    fFIS_DECRETOCAPA.CD_DECRETO := gCdDecretoItemCapa;
    fFIS_DECRETOCAPA.Listar(nil);
    if (xStatus >= 0) then begin
      vCdDecreto := fFIS_DECRETOCAPA.CD_DECRETO;
      vDtIniVigencia := fFIS_DECRETOCAPA.DT_INIVIGENCIA;
      vDtFimVigencia := fFIS_DECRETOCAPA.DT_FIMVIGENCIA;
    end;
  end else begin
    if (fFIS_DECRETO.CD_DECRETO <> '') then begin
      vCdDecreto := fFIS_DECRETO.CD_DECRETO;
      vDtIniVigencia := fFIS_DECRETO.DT_INIVIGENCIA;
      vDtFimVigencia := fFIS_DECRETO.DT_FIMVIGENCIA;
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

  fFIS_ALIQUOTAICMSUF.Limpar();
  fFIS_ALIQUOTAICMSUF.CD_UFORIGEM := gDsUFOrigem;
  fFIS_ALIQUOTAICMSUF.CD_UFDESTINO := gDsUFDestino;
  fFIS_ALIQUOTAICMSUF.Listar(nil);
  if (itemXmlF('status', voParams) < 0) then begin
    raise Exception.Create('Nenhuma alíquota cadastada de ' + gDsUfOrigem + ' para ' + gDsUFDestino + '!' + ' / ' + cDS_METHOD);
    exit;
  end;

  fFIS_IMPOSTO.Limpar();

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
  or (vInSubstituicao) then begin
    putitem(vDsLstCdImposto, '2');
  end;
  putitem(vDsLstCdImposto, '5');
  putitem(vDsLstCdImposto, '6');

  repeat
    vCdImposto := StrToFloat(getitemGld(vDsLstCdImposto, 1));

    vDtIniVigencia := 0;

    viParams := '';
    viParams.CD_IMPOSTO := vCdImposto;
    viParams.DT_INIVIGENCIA := pParams.DT_INIVIGENCIA;
    voParams := activateCmp('FISSVCO069', 'retornaImposto', viParams);
    if (itemXmlF('status', voParams) < 0) then begin
      raise Exception.Create(itemXml('message', voParams));
      exit;
    end;

    if (voParams <> '') then begin
      vDtIniVigencia := voParams.DT_INIVIGENCIA;
      vCdImpRetorno := voParams.CD_IMPOSTO;

      fFIS_IMPOSTO.Append();
      fFIS_IMPOSTO.CD_IMPOSTO := vCdImpRetorno;
      fFIS_IMPOSTO.DT_INIVIGENCIA := vDtIniVigencia;
      fFIS_IMPOSTO.Consultar(nil);
      if (xStatus = -7) then begin
        fFIS_IMPOSTO.Consultar(nil);
      end else if (itemXmlF('status', voParams) < 0) then begin
        raise Exception.Create('Imposto ' + FloatToStr(vCdImposto) + ' não cadastrado!' + ' / ' + cDS_METHOD);
        exit;
      end;

      if (vCdImposto = 1) then begin //ICMS;
        calculaICMS();
      end else if (vCdImposto = 2) then begin //ICMSSubst;
        calculaICMSSubst();
      end else if (vCdImposto = 3) then begin //IPI - Saída é calculado / Entrada é digitado na tela;
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

  if (fFIS_IMPOSTO.IsEmpty() = 0) then begin
    sort_e(tFIS_IMPOSTO, 'CD_IMPOSTO');
    fFIS_IMPOSTO.First();
    while (xStatus >=0) do begin
      if (fFIS_IMPOSTO.CD_IMPOSTO > 0) then begin
        vDsRegistro := '';
        vDsRegistro := fFIS_IMPOSTO.GetValues();
        putitem(vDsLstImposto, vDsRegistro);
      end;  
      fFIS_IMPOSTO.Next();
    end;
  end;

  fFIS_CST.Limpar();
  fFIS_CST.CD_CST := gCdCST;
  fFIS_CST.Listar(nil);
  if (itemXmlF('status', voParams) < 0) then begin
    raise Exception.Create('CST ' + gCdCST + ' não cadastrado!' + ' / ' + cDS_METHOD);
    exit;
  end;

  Result := '';
  Result.CD_CST := gCdCST;
  Result.CD_DECRETO := gCdDecreto;
  Result.DS_LSTIMPOSTO := vDsLstImposto;
  return(0);
end;

//----------------------------------
function T_FISSVCO015.calculaImpostoItem(pParams : String) : String;
//----------------------------------
const
  cDS_METHOD = 'ADICIONAL=Operação: T_FISSVCO015.calculaImpostoItem()';
var
  viParams, voParams,
  vCdCST, vDsUF, vDsRegistro, vDsLstImposto, vDsLstCdImposto, vCdMPTer, vNmMunicipio : String;
  vCdEmpresa, vCdEmpresaParam, vCdProduto, vCdOperacao, vCdPessoa, vNrSeqEnd : Real;
  vCdImpRetorno, vCdImposto, vCdRegraFiscal : Real;
  vInOrgaoPublico, vInSubstituicao : Boolean;
  vDtIniVigencia : TDateTime;
begin
  Result := '';

  vCdEmpresa := pParams.CD_EMPRESA;
  if (vCdEmpresa = 0) then begin
    vCdEmpresa := PARAM_GLB.CD_EMPRESA;
  end;
  gDsUFOrigem := PARAM_GLB.UF_ORIGEM;
  gDsUFDestino := pParams.UF_DESTINO;
  gTpOrigemEmissao := pParams.TP_ORIGEMEMISSAO;
  vCdProduto := pParams.CD_PRODUTO;
  vCdMPTer := pParams.CD_MPTER;
  gCdServico := pParams.CD_SERVICO;
  vCdOperacao := pParams.CD_OPERACAO;
  vCdPessoa := pParams.CD_PESSOA;
  gCdCST := pParams.CD_CST;
  gVlTotalBruto := pParams.VL_TOTALBRUTO;
  gVlTotalLiquido := pParams.VL_TOTALLIQUIDO;
  gVlTotalLiquidoICMS := pParams.VL_TOTALLIQUIDO;
  gPrIPI := pParams.PR_IPI;
  gVlIPI := pParams.VL_IPI;
  gTpModDctoFiscal := pParams.TP_MODDCTOFISCAL;
  vDsLstCdImposto := pParams.DS_LST_CD_IMPOSTO;
  gTpAreaComercioOrigem := PARAM_GLB.TP_AREA_COMERCIO_ORIGEM;
  gTpAreaComercioDestino := 0;
  gInContribuinte := False;
  gCdDecretoItemCapa := 0;

  if (gTpOrigemEmissao = 0) then begin
    raise Exception.Create('Tipo emissão não informado!' + ' / ' + cDS_METHOD);
    exit;
  end;
  if (gDsUFDestino = '') then begin
    raise Exception.Create('UF destino não informada!' + ' / ' + cDS_METHOD);
    exit;
  end ;
  if (vCdOperacao = 0) then begin
    raise Exception.Create('Operação não informada!' + ' / ' + cDS_METHOD);
    exit;
  end;

  fPRD_PRODUTO.Limpar();

  fGER_OPERACAO.Limpar();
  fGER_OPERACAO.CD_OPERACAO := vCdOperacao;
  fGER_OPERACAO.Listar(nil);
  if (itemXmlF('status', voParams) < 0) then begin
    raise Exception.Create('Operação ' + FloatToStr(vCdOperacao) + ' não cadastrada!' + ' / ' + cDS_METHOD);
    exit;
  end;

  if (vCdProduto = 0)
  and (vCdMPTer = '')
  and (gCdServico = 0) then begin
    exit;
  end;

  if (fGER_OPERACAO.IN_CALCIMPOSTO <> True) then begin
    exit;
  end;

  if (gCdCST = '') then begin
    raise Exception.Create('CST não informado!' + ' / ' + cDS_METHOD);
    exit;
  end;

  if (gInPDVOtimizado <> True) then begin
    if (gVlTotalBruto = 0) then begin
      raise Exception.Create('Valor total bruto não informado p/ o produto ' + FloatToStr(vCdProduto) + '!' + ' / ' + cDS_METHOD);
      exit;
    end;

    if (gVlTotalLiquido = 0) then begin
      raise Exception.Create('Valor total líquido não informado p/ oproduto ' + FloatToStr(vCdProduto) + '!' + ' / ' + cDS_METHOD);
      exit;
    end;
  end;

  fPES_PESSOA.Limpar();
  fPES_PESSOA.CD_PESSOA := vCdPessoa;
  fPES_PESSOA.Listar(nil);
  if (itemXmlF('status', voParams) < 0) then begin
    raise Exception.Create('Pessoa ' + FloatToStr(vCdPessoa) + ' não cadastrada!' + ' / ' + cDS_METHOD);
    exit;
  end;

  //Venda / Devolução de venda
  if ((fGER_OPERACAO.TP_OPERACAO = 'S') and (fGER_OPERACAO.TP_MODALIDADE = '4'))
  or ((fGER_OPERACAO.TP_OPERACAO = 'E') and (fGER_OPERACAO.TP_MODALIDADE = '3')) then begin
    fPES_CLIENTE.Limpar();
    fPES_CLIENTE.CD_CLIENTE := vCdPessoa;
    fPES_CLIENTE.Listar(nil);
    if (itemXmlF('status', voParams) < 0) then begin
      raise Exception.Create('Cliente ' + FloatToStr(vCdPessoa) + ' não cadastrado!' + ' / ' + cDS_METHOD);
      exit;
    end;
  end;

  gInPjIsento := False;
  if (fPES_PESJURIDICA.NR_INSCESTL = 'ISENTO')
  or (fPES_PESJURIDICA.NR_INSCESTL = 'ISENTA')
  or (fPES_PESJURIDICA.NR_INSCESTL = 'ISENTOS')
  or (fPES_PESJURIDICA.NR_INSCESTL = 'ISENTAS') then begin
    gInPjIsento := True;
  end;

  gInVarejista := False;
  if (fPES_PESJURIDICA.CD_ATIVIDADE = gCdAtividadeVarejista) and (gCdAtividadeVarejista > 0) then begin
    gInVarejista := True;
  end;
  if (gTpOrigemEmissao = 2) then begin //Terceiros
    if (fGER_OPERACAO.TP_MODALIDADE <> '3') then begin //Devolução
      vDsUF := gDsUFOrigem;
      gDsUFOrigem := gDsUFDestino;
      gDsUFDestino := vDsUF;
    end;
  end else begin
    if ((fGER_OPERACAO.TP_MODALIDADE = '3') and (fGER_OPERACAO.TP_OPERACAO = 'S')) then begin //Devolução compra
      vDsUF  := gDsUFOrigem;
      gDsUFOrigem := gDsUFDestino;
      gDsUFDestino := vDsUF;
    end;
  end;

  viParams := '';
  viParams.CD_PESSOA := vCdPessoa;
  voParams := activateCmp('FCRSVCO057', 'validaPessoaOrgaoPublico', viParams);
  if (itemXmlF('status', voParams) < 0) then begin
    raise Exception.Create(itemXml('message', voParams));
    exit;
  end;
  vInOrgaoPublico := voParams.IN_ORGAOPUBLICO;

  if (vInOrgaoPublico) and (gDsUFOrigem = 'DF') then begin
    gInContribuinte := True;
  end else begin
    if (fPES_CLIENTE.IN_CNSRFINAL) or (fPES_PESSOA.TP_PESSOA = 'F') or (gInPjIsento) then begin
      if not (fPES_CLIENTE.IN_CNSRFINAL) and (fPES_PESSOA.TP_PESSOA = 'J') and (gInPjIsento) then begin
        gInContribuinte := True;
      end else begin
        if (fPES_PESSOA.TP_PESSOA = 'F')
        and (fPES_CLIENTE.NR_CODIGOFISCAL <> '')
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

  if (gInOptSimples) then begin
    gTpAreaComercioDestino := 0;
  end else begin
    viParams := '';
    viParams.CD_PESSOA := vCdPessoa;
    voParams := activateCmp('PESSVCO001', 'buscarEnderecoFat', viParams);
    if (voParams.CD_PESSOA <> '') then begin
      gTpAreaComercioDestino := voParams.TP_AREACOMERCIO;
    end;
  end;
  //Este retrieve foi comentado dentro do if e colocado aki, pois estava carregando a variável gTpRegimeOrigem somente
  //quando era emissão de terceiros. Esta variável está sendo usado tbm para emissão própria no cálculo do ICMS.
  if (fPES_PESSOA.TP_PESSOA <> 'F') then begin
    if (fPES_PESJURIDICA.IsEmpty()) then begin
      raise Exception.Create('Pessoa ' + FloatToStr(vCdPessoa) + ' não é jurídica!' + ' / ' + cDS_METHOD);
      exit;
    end;
    gTpRegimeOrigem := fPES_PESJURIDICA.TP_REGIMETRIB;
  end;

  if (gInContribuinte = False) and (gDsUFDestino <> 'EX') then begin
    gDsUFDestino := gDsUFOrigem;
  end;

  if (fGER_OPERACAO.TP_MODALIDADE = 'D') and (gTpModDctoFiscal = 0) then begin // Condição implementada para o CIAP
    gTpModDctoFiscal := 85;
  end else if (fGER_OPERACAO.TP_MODALIDADE = 'G') and (gTpModDctoFiscal = 0)  then begin
    gTpModDctoFiscal := 87 // Nota Fiscal CIAP;
  end;

  vCdRegraFiscal := 0;

  if (gCdServico > 0) then begin
    gInProdPropria := False;
    vCdRegraFiscal := fGER_OPERACAO.CD_REGRAFISCAL;
    if (vCdRegraFiscal = 0) then begin
      raise Exception.Create('Nenhuma regra fiscal cadastrada p/ a operação ' + FloatToStr(vCdOperacao) + '!' + ' / ' + cDS_METHOD);
      exit;
    end;
  end else if (vCdMPTer <> '') then begin
    gInProdPropria := False;
    vCdRegraFiscal := fGER_OPERACAO.CD_REGRAFISCAL;
    if (vCdRegraFiscal = 0) then begin
      raise Exception.Create('Nenhuma regra fiscal cadastrada p/ a operação ' + FloatToStr(vCdOperacao) + '!' + ' / ' + cDS_METHOD);
      exit;
    end;
  end else begin
    fPRD_PRODUTO.Limpar();
    fPRD_PRODUTO.CD_PRODUTO := vCdProduto;
    fPRD_PRODUTO.Listar(nil);
    if (itemXmlF('status', voParams) < 0) then begin
      raise Exception.Create('Produto ' + FloatToStr(vCdProduto) + ' não cadastrado!' + ' / ' + cDS_METHOD);
      exit;
    end;

    viParams := '';
    viParams.CD_EMPRESA := vCdEmpresa;
    viParams.CD_PRODUTO := vCdProduto;
    voParams := activateCmp('PRDSVCO007', 'buscaDadosFilial', viParams); // PRDSVCO008
    if (itemXmlF('status', voParams) < 0) then begin
      raise Exception.Create(itemXml('message', voParams));
      exit;
    end;
    gInProdPropria := voParams.IN_PRODPROPRIA;

    fPRD_PRDREGRAFISCAL.Limpar();
    fPRD_PRDREGRAFISCAL.CD_PRODUTO := vCdProduto;
    fPRD_PRDREGRAFISCAL.CD_OPERACAO := vCdOperacao;
    fPRD_PRDREGRAFISCAL.Listar(nil);
    if (xStatus >= 0) then begin
      vCdRegraFiscal := fPRD_PRDREGRAFISCAL.CD_REGRAFISCAL;
    end else begin
      vCdRegraFiscal := fGER_OPERACAO.CD_REGRAFISCAL;
    end;

    if (vCdRegraFiscal = 0) then begin
      raise Exception.Create('Nenhuma regra fiscal cadastrada p/ o produto ' + FloatToStr(vCdProduto) + ' e a operação ' + FloatToStr(vCdOperacao) + '!' + ' / ' + cDS_METHOD);
      exit;
    end;
  end;

  fFIS_REGRAFISCAL.Limpar();
  fFIS_REGRAFISCAL.CD_REGRAFISCAL := vCdRegraFiscal;
  fFIS_REGRAFISCAL.Listar(nil);
  if (itemXmlF('status', voParams) < 0) then begin
    raise Exception.Create('Regra fiscal ' + FloatToStr(vCdRegraFiscal) + ' não cadastrada!' + ' / ' + cDS_METHOD);
    exit;
  end;

  fFIS_ALIQUOTAICMSUF.Limpar();
  fFIS_ALIQUOTAICMSUF.CD_UFORIGEM := gDsUFOrigem;
  fFIS_ALIQUOTAICMSUF.CD_UFDESTINO := gDsUFDestino;
  fFIS_ALIQUOTAICMSUF.Listar(nil);
  if (itemXmlF('status', voParams) < 0) then begin
    raise Exception.Create('Nenhuma alíquota cadastada de ' + gDsUfOrigem + ' para ' + gDsUFDestino + '!' + ' / ' + cDS_METHOD);
    exit;
  end;

  fFIS_IMPOSTO.Limpar();

  gVlICMS := 0;

  if (vDsLstCdImposto = '') then begin
    if (gCdServico > 0) then begin
      if (fFIS_REGRAFISCAL.IN_ISS) then begin
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
    if (fFIS_REGRAFISCAL.IN_IR) then begin  //27/02/2012 - Não calcular IMPOSTO DE RENDA caso não esteja na regra
      putitem(vDsLstCdImposto, '7');
    end;
  end;

  vDsLstCdImposto := vDsLstCdImposto;

  repeat
    vCdImposto := StrToFloat(getitemGld(vDsLstCdImposto, 1));

    vDtIniVigencia := 0;

    viParams := '';
    viParams.CD_IMPOSTO := vCdImposto;
    viParams.DT_INIVIGENCIA := pParams.DT_INIVIGENCIA;
    voParams := activateCmp('FISSVCO069', 'retornaImposto', viParams);
    if (itemXmlF('status', voParams) < 0) then begin
      raise Exception.Create(itemXml('message', voParams));
      exit;
    end;

    if (voParams <> '') then begin
      vDtIniVigencia := voParams.DT_INIVIGENCIA;
      vCdImpRetorno := voParams.CD_IMPOSTO;

      fFIS_IMPOSTO.Append();
      fFIS_IMPOSTO.CD_IMPOSTO := vCdImpRetorno;
      fFIS_IMPOSTO.DT_INIVIGENCIA := vDtIniVigencia;
      fFIS_IMPOSTO.Consultar(nil);
      if (xStatus = -7) then begin
        fFIS_IMPOSTO.Consultar(nil);
      end else if (itemXmlF('status', voParams) < 0) then begin
        raise Exception.Create('Imposto ' + FloatToStr(vCdImposto) + ' não cadastrado!' + ' / ' + cDS_METHOD);
        exit;
      end;

      if (vCdImposto = 1) then begin //ICMS;
        calculaICMS();
      end else if (vCdImposto = 2) then begin //ICMSSubst;
        calculaICMSSubst();
      end else if (vCdImposto = 3) then begin //IPI - Saída é calculado / Entrada é digitado na tela;
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

  if (fFIS_IMPOSTO.IsEmpty() = 0) then begin
    sort_e(tFIS_IMPOSTO, 'CD_IMPOSTO');
    fFIS_IMPOSTO.First();
    while (xStatus >=0) do begin
      if (fFIS_IMPOSTO.CD_IMPOSTO > 0) then begin
        vDsRegistro := '';
        vDsRegistro := fFIS_IMPOSTO.GetValues();
        putitem(vDsLstImposto, vDsRegistro);
      end;
      fFIS_IMPOSTO.Next();
    end;
  end;

  fFIS_IMPOSTO.Limpar();

  fFIS_CST.Limpar();
  fFIS_CST.CD_CST := gCdCST;
  fFIS_CST.Listar(nil);
  if (itemXmlF('status', voParams) < 0) then begin
    raise Exception.Create('CST ' + gCdCST + ' não cadastrado!' + ' / ' + cDS_METHOD);
    exit;
  end;

  Result := '';
  Result.CD_CST := gCdCST;
  Result.CD_DECRETO := gCdDecreto;
  Result.DS_LSTIMPOSTO := vDsLstImposto;
  return(0);
end;

initialization
  RegisterClass(T_FISSVCO015);

end.
