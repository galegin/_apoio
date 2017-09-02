unit cFISSVCO080;

interface

(* COMPONENTES 
  ADMSVCO001 / FCRSVCO057 / FISSVCO035 / FISSVCO069 / PESSVCO005
  PRDSVCO008 / 
*)        

uses
  Classes, SysUtils, DB,
  cServiceUnf, cDataSetUnf;

type
  T_FISSVCO080 = class(TcServiceUnf)
  private
    tCDF_MPTER,
    tFIS_ALIQUOTAICMSUF,
    tFIS_IMPOSTO,
    tFIS_REGRAADIC,
    tFIS_REGRACOND,
    tFIS_REGRAFISCAL,
    tFIS_REGRAIMPCALC,
    tFIS_REGRAIMPOSTO,
    tFIS_REGRAREL,
    tFIS_TIPI,
    tFIS_INFOFISCALPRD,
    tGER_OPERACAO,
    tGLB_ESTADO,
    tGLB_MUNICIPIO,
    tPCP_SERV,
    tPES_CLIENTE,
    tPES_ENDERECO,
    tPES_PESJURIDICA,
    tPES_PESFISICA,
    tPES_PESSOA,
    tPES_PFADIC,
    tPES_PJADIC,
    tPRD_PRDINFOADIC,
    tPRD_PRDREGRAFISCAL,
    tPRD_PRODUTO,
    tPRD_PRODUTOCLAS : TcDatasetUnf;
    function calculaICMS(piImposto : Real) : String;
    function calculaICMSSubst(piImposto : Real) : String;
    function calculaIPI() : String;
    function calculaISS() : String;
    function calculaCOFINS() : String;
    function calculaPIS() : String;
    function calculaPASEP() : String;
    function calculaCSLL() : String;
    function calculaBaseCalc() : String;
  protected
    function getParam(pParams : String = '') : String; override;
    function setEntidade(pParams : String = '') : String; override;
  public
  published
    function validaRegraNova(pParams : String = '') : String;
    function buscaRegraRelacionada(pParams : String = '') : String;
    function calculaImpostoItem(pParams : String = '') : String;
    function buscaAliquotaInterna(pParams : String = '') : String;
  end;

implementation

uses
  cActivate, cStatus, cFuncao, cXml, dModulo;

var
  gCdCST,
  gNaturezaComercialEmp,
  gDsUFDestino,
  gDsUFOrigem : String;

  gDtVigenciaIPI : TDateTime;

  gInContribuinte,
  gInImpostoOffLine,
  gInOptSimples,
  gInPjIsento,
  gInProdPropria : Boolean;

  gCdEmpParam,
  gCdServico,
  gNr02,
  gPrAplicMvaSubTrib,
  gPrIcms,
  gPrIPI,
  gTpModDctoFiscal,
  gTpOrigemEmissao,
  gVlDespAcessor,
  gVldIcms,
  gVlFrete,
  gVlICMS,
  gVlIPI,
  gVlSeguro,
  gVlTotalBruto,
  gVlTotalLiquido,
  gVlTotalLiquidoICMS : Real;

//---------------------------------------------------------------
function T_FISSVCO080.getParam(pParams : String) : String;
//---------------------------------------------------------------
var
  piCdEmpresa : Real;
begin
  piCdEmpresa := itemXmlF('CD_EMPRESA', pParams);
  if (piCdEmpresa = 0) then begin
    piCdEmpresa := itemXmlF('CD_EMPRESA', PARAM_GLB);
  end;

  xParamEmp := '';
  putitem(xParamEmp,  'PR_APLIC_MVA_SUB_TRIB');
  putitem(xParamEmp,  'IN_IMPOSTO_OFFLINE');
  putitem(xParamEmp,  'NATUREZA_COMERCIAL_EMP');
  xParamEmp := activateCmp('ADMSVCO001', 'GetParamEmpresa', piCdEmpresa, xParamEmp);

  gPrAplicMvaSubTrib := itemXmlF('PR_APLIC_MVA_SUB_TRIB', xParamEmp);
  gInImpostoOffLine := itemXmlB('IN_IMPOSTO_OFFLINE', xParamEmp);
  gNaturezaComercialEmp := itemXml('NATUREZA_COMERCIAL_EMP', xParamEmp);
end;

//---------------------------------------------------------------
function T_FISSVCO080.setEntidade(pParams : String) : String;
//---------------------------------------------------------------
begin
  tCDF_MPTER := GetEntidade('CDF_MPTER');
  tFIS_ALIQUOTAICMSUF := GetEntidade('FIS_ALIQUOTAICMSUF');
  tFIS_IMPOSTO := GetEntidade('FIS_IMPOSTO');
  tFIS_REGRAADIC := GetEntidade('FIS_REGRAADIC');
  tFIS_REGRACOND := GetEntidade('FIS_REGRACOND');
  tFIS_REGRAFISCAL := GetEntidade('FIS_REGRAFISCAL');
  tFIS_REGRAIMPCALC := GetEntidade('FIS_REGRAIMPCALC');
  tFIS_REGRAIMPOSTO := GetEntidade('FIS_REGRAIMPOSTO');
  tFIS_REGRAREL := GetEntidade('FIS_REGRAREL');
  tFIS_TIPI := GetEntidade('FIS_TIPI');
  tFIS_INFOFISCALPRD := GetEntidade('FIS_INFOFISCALPRD');
  tGER_OPERACAO := GetEntidade('GER_OPERACAO');
  tGLB_ESTADO := GetEntidade('GLB_ESTADO', '', 'G');
  tGLB_MUNICIPIO := GetEntidade('GLB_MUNICIPIO', '', 'G');
  tPCP_SERV := GetEntidade('PCP_SERV');
  tPES_CLIENTE := GetEntidade('PES_CLIENTE');
  tPES_PESJURIDICA := GetEntidade('PES_PESJURIDICA');
  tPES_PESFISICA := GetEntidade('PES_PESFISICA');
  tPES_ENDERECO := GetEntidade('PES_ENDERECO');
  tPES_PESSOA := GetEntidade('PES_PESSOA');
  tPES_PFADIC := GetEntidade('PES_PFADIC');
  tPES_PJADIC := GetEntidade('PES_PJADIC');
  tPRD_PRDINFOADIC := GetEntidade('PRD_PRDINFOADIC');
  tPRD_PRDREGRAFISCAL := GetEntidade('PRD_PRDREGRAFISCAL');
  tPRD_PRODUTO := GetEntidade('PRD_PRODUTO');
  tPRD_PRODUTOCLAS := GetEntidade('PRD_PRODUTOCLAS');

  // filhas
  tFIS_REGRAFISCAL._LstFilha := 'FIS_REGRAIMPCALC|FIS_REGRAADIC|FIS_REGRAIMPOSTO|';
  tFIS_REGRAREL._LstFilha := 'FIS_REGRACOND|';
  tPES_PESSOA._LstFilha := 'PES_ENDERECO|PES_CLIENTE|PES_PESJURIDICA|PES_PESFISICA|';
    tPES_ENDERECO._LstFilha := 'GLB_MUNICIPIO|';
      tGLB_MUNICIPIO._LstFilha := 'GLB_ESTADO|';
    tPES_PESJURIDICA._LstFilha := 'PES_PJADIC|';
    tPES_PESFISICA._LstFilha := 'PES_PFADIC|';
  tPRD_PRODUTO._LstFilha := 'PRD_PRODUTOCLAS|FIS_TIPI|PRD_PRDREGRAFISCAL|';
  tFIS_TIPI._LstFilha := 'FIS_INFOFISCALPRD|';

  // calculado
  tFIS_REGRAIMPOSTO._LstCalc := 'NR_ORDEM:N(4)|';
  tFIS_IMPOSTO._LstCalc := 'VL_IMPOSTO:N(15)|VL_OUTRO:N(15)|VL_ISENTO:N(15)|VL_BASECALC:N(15)|PR_REDUBASE:N(6)|PR_BASECALC:N(6)|CD_CST:A(3)|';
end;

//-----------------------------------------------------------
function T_FISSVCO080.calculaICMS(piImposto : Real) : String;
//-----------------------------------------------------------
const
  cDS_METHOD = 'T_FISSVCO080.calculaICMS()';
var
  vVlCalc : Real;
begin
  if (gInImpostoOffLine = TRUE) then begin
    discard(tFIS_IMPOSTO);
    return(0); exit;
  end;

  gCdCST := item('CD_CST', tFIS_REGRAIMPOSTO);

  if (item('PR_ALIQUOTA', tFIS_REGRAIMPOSTO) <> '') then begin
    putitem(tFIS_IMPOSTO, 'PR_ALIQUOTA', itemF('PR_ALIQUOTA', tFIS_REGRAIMPOSTO));
    gVldIcms := itemF('PR_ALIQUOTA', tFIS_IMPOSTO);
  end else begin
    clear_e(tFIS_ALIQUOTAICMSUF);
    putitem_o(tFIS_ALIQUOTAICMSUF, 'CD_UFORIGEM', gDsUFOrigem);
    putitem_o(tFIS_ALIQUOTAICMSUF, 'CD_UFDESTINO', gDsUFDestino);
    retrieve_e(tFIS_ALIQUOTAICMSUF);
    if (xStatus < 0) then begin
      Result := SetStatus(STS_ERROR, 'GEN001', 'Nenhuma aliquota cadastada de ' + item('CD_UFORIGEM', tFIS_ALIQUOTAICMSUF) + ' para ' + item('CD_UFDESTINO', tFIS_ALIQUOTAICMSUF) + '!', cDS_METHOD);
      return(-1); exit;
    end;
    putitem(tFIS_IMPOSTO, 'PR_ALIQUOTA', itemF('PR_ALIQICMS', tFIS_ALIQUOTAICMSUF));
  end;

  putitem(tFIS_IMPOSTO, 'VL_OUTRO', 0);
  putitem(tFIS_IMPOSTO, 'VL_ISENTO', 0);
  putitem(tFIS_IMPOSTO, 'PR_REDUBASE', 0);
  putitem(tFIS_IMPOSTO, 'PR_BASECALC', 100);

  calculaBaseCalc();

  if (itemF('PR_REDUBASE', tFIS_REGRAIMPOSTO) > 0) then begin
    putitem(tFIS_IMPOSTO, 'PR_REDUBASE', itemF('PR_REDUBASE', tFIS_REGRAIMPOSTO));
    putitem(tFIS_IMPOSTO, 'PR_BASECALC', 100 - itemF('PR_REDUBASE', tFIS_REGRAIMPOSTO));

    vVlCalc := itemF('VL_BASECALC', tFIS_IMPOSTO) - (itemF('VL_BASECALC', tFIS_IMPOSTO) * itemF('PR_REDUBASE', tFIS_IMPOSTO) / 100);

    putitem(tFIS_IMPOSTO, 'VL_BASECALC', rounded(vVlCalc, 6));
  end;
  if (itemF('PR_REDUIMP', tFIS_REGRAIMPOSTO) > 0) then begin
    vVlCalc := (itemF('VL_BASECALC', tFIS_IMPOSTO) * ((100 - itemF('PR_REDUIMP', tFIS_REGRAIMPOSTO))/100) * itemF('PR_ALIQUOTA', tFIS_IMPOSTO)) / 100;
    putitem(tFIS_IMPOSTO, 'VL_IMPOSTO', rounded(vVlCalc, 6));
    gVlICMS := itemF('VL_IMPOSTO', tFIS_IMPOSTO);
  end else begin
    vVlCalc := itemF('VL_BASECALC', tFIS_IMPOSTO) * itemF('PR_ALIQUOTA', tFIS_IMPOSTO) / 100;
    putitem(tFIS_IMPOSTO, 'VL_IMPOSTO', rounded(vVlCalc, 6));
    gVlICMS := itemF('VL_IMPOSTO', tFIS_IMPOSTO);

    if (itemB('IN_OUTRO', tFIS_REGRAIMPOSTO) = TRUE) then begin
      if (itemF('PR_REDUBASE', tFIS_REGRAIMPOSTO) > 0) then begin
        putitem(tFIS_IMPOSTO, 'VL_OUTRO', gVlTotalLiquidoICMS - itemF('VL_BASECALC', tFIS_IMPOSTO));
      end else begin
        putitem(tFIS_IMPOSTO, 'VL_OUTRO', itemF('VL_BASECALC', tFIS_IMPOSTO));
        putitem(tFIS_IMPOSTO, 'VL_ISENTO', 0);
        putitem(tFIS_IMPOSTO, 'VL_IMPOSTO', 0);
        putitem(tFIS_IMPOSTO, 'VL_BASECALC', 0);
        putitem(tFIS_IMPOSTO, 'PR_BASECALC', 0);
        putitem(tFIS_IMPOSTO, 'PR_REDUBASE', 0);
        putitem(tFIS_IMPOSTO, 'PR_ALIQUOTA', 0);
      end;
    end else if (itemB('IN_ISENTO', tFIS_REGRAIMPOSTO) = TRUE) then begin
      if (itemF('PR_REDUBASE', tFIS_REGRAIMPOSTO) > 0) then begin
        putitem(tFIS_IMPOSTO, 'VL_ISENTO', gVlTotalLiquidoICMS - itemF('VL_BASECALC', tFIS_IMPOSTO));
      end else begin
        putitem(tFIS_IMPOSTO, 'VL_ISENTO', itemF('VL_BASECALC', tFIS_IMPOSTO));
        putitem(tFIS_IMPOSTO, 'VL_OUTRO', 0);
        putitem(tFIS_IMPOSTO, 'VL_IMPOSTO', 0);
        putitem(tFIS_IMPOSTO, 'VL_BASECALC', 0);
        putitem(tFIS_IMPOSTO, 'PR_BASECALC', 0);
        putitem(tFIS_IMPOSTO, 'PR_REDUBASE', 0);
        putitem(tFIS_IMPOSTO, 'PR_ALIQUOTA', 0);
      end;
    end;
  end;

  return(0); exit;
End;

//----------------------------------------------------------------
function T_FISSVCO080.calculaICMSSubst(piImposto : Real) : String;
//----------------------------------------------------------------
const
  cDS_METHOD = 'T_FISSVCO080.calculaICMSSubst()';
var
  vInReducaoMVA : Boolean;
  viParams, voParams : String;
  vVlBaseCalc, vVlICMS, vPrAliqIntra, vPrAliqInter, vPrAliqDestino, vPrAliqOrigem : Real;
  vPrIVA, vPrIvaPrd, vTpIva, vNrTam, vPrAux : Real;
begin
  if (gInImpostoOffLine = TRUE) then begin
    discard(tFIS_IMPOSTO);
    return(0); exit;
  end;

  ulength(gCdCST);
  vNrTam := xResult;
  if (vNrTam <= 1) then begin
    gCdCST := item('CD_CST', tFIS_REGRAIMPOSTO);
  end;

  vInReducaoMVA := FALSE;

  calculaBaseCalc();

  vVlBaseCalc := rounded(itemF('VL_BASECALC', tFIS_IMPOSTO), 6);

  if (item('TP_CALCICMSST', tFIS_REGRAIMPOSTO) = '') then begin
    If (itemB('IN_OUTRO', tFIS_REGRAIMPOSTO) = TRUE) then begin
      putitem(tFIS_IMPOSTO, 'VL_OUTRO', vVlBaseCalc);
      putitem(tFIS_IMPOSTO, 'VL_ISENTO', 0);
      putitem(tFIS_IMPOSTO, 'VL_IMPOSTO', 0);
      putitem(tFIS_IMPOSTO, 'VL_BASECALC', 0);
      putitem(tFIS_IMPOSTO, 'PR_BASECALC', 0);
      putitem(tFIS_IMPOSTO, 'PR_REDUBASE', 0);
      putitem(tFIS_IMPOSTO, 'PR_ALIQUOTA', 0);

    end else if (itemB('IN_ISENTO', tFIS_REGRAIMPOSTO) = TRUE) then begin
      putitem(tFIS_IMPOSTO, 'VL_ISENTO', vVlBaseCalc);
      putitem(tFIS_IMPOSTO, 'VL_OUTRO', 0);
      putitem(tFIS_IMPOSTO, 'VL_IMPOSTO', 0);
      putitem(tFIS_IMPOSTO, 'VL_BASECALC', 0);
      putitem(tFIS_IMPOSTO, 'PR_BASECALC', 0);
      putitem(tFIS_IMPOSTO, 'PR_REDUBASE', 0);
      putitem(tFIS_IMPOSTO, 'PR_ALIQUOTA', 0);

    end else begin
      if (item('PR_ALIQUOTA', tFIS_REGRAIMPOSTO) <> '') then begin
        putitem(tFIS_IMPOSTO, 'PR_ALIQUOTA', itemF('PR_ALIQUOTA', tFIS_REGRAIMPOSTO));
      end else begin
        clear_e(tFIS_ALIQUOTAICMSUF);
        putitem_o(tFIS_ALIQUOTAICMSUF, 'CD_UFORIGEM', gDsUFOrigem);
        putitem_o(tFIS_ALIQUOTAICMSUF, 'CD_UFDESTINO', gDsUFDestino);
        retrieve_e(tFIS_ALIQUOTAICMSUF);
        if (xStatus < 0) then begin
          Result := SetStatus(STS_ERROR, 'GEN001', 'Nenhuma aliquota cadastada de ' + item('CD_UFORIGEM', tFIS_ALIQUOTAICMSUF) + ' para ' + item('CD_UFDESTINO', tFIS_ALIQUOTAICMSUF) + '!', cDS_METHOD);
          return(-1); exit;
        end;
        putitem(tFIS_IMPOSTO, 'PR_ALIQUOTA', itemF('PR_ALIQICMS', tFIS_ALIQUOTAICMSUF));
      end;

      viParams := '';
      putitemXml(viParams, 'CD_PRODUTO', itemF('CD_PRODUTO', tPRD_PRODUTO));
      putitemXml(viParams, 'UF_ORIGEM', gDsUFOrigem);
      putitemXml(viParams, 'UF_DESTINO', gDsUFDestino);
      putitemXml(viParams, 'TP_OPERACAO', itemF('TP_OPERACAO', tGER_OPERACAO));
      voParams := activateCmp('FISSVCO035', 'buscaDadosFiscalProduto', viParams);
      if (xStatus < 0) then begin
        Result := voParams; exit;
      end;
      vPrIVA := 0;

      if (item('PR_MVAICMSST', tFIS_REGRAIMPOSTO) <> '') then begin
        vPrIvaPrd := itemF('PR_MVAICMSST', tFIS_REGRAIMPOSTO);
      end else begin
        vPrIvaPrd := itemXmlF('PR_SUBSTRIB', voParams);
      end;
      vPrAliqIntra := itemXmlF('PR_ICMS', voParams);
      vTpIva := itemXmlF('TP_IVA', voParams);

      if (vPrIvaPrd > 0) then begin
        vPrIVA := vPrIvaPrd;
      end;
      if (vPrAliqIntra > 0) then begin
        putitem(tFIS_IMPOSTO, 'PR_ALIQUOTA', vPrAliqIntra);
      end;
      if (itemB('IN_DIFALIQ', tFIS_REGRAIMPOSTO) = TRUE) then begin
        clear_e(tFIS_ALIQUOTAICMSUF);
        putitem_o(tFIS_ALIQUOTAICMSUF, 'CD_UFORIGEM', gDsUFDestino);
        putitem_o(tFIS_ALIQUOTAICMSUF, 'CD_UFDESTINO', gDsUFDestino);
        retrieve_e(tFIS_ALIQUOTAICMSUF);
        if (xStatus < 0) then begin
          Result := SetStatus(STS_ERROR, 'GEN001', 'Nenhuma aliquota cadastrada de ' + item('CD_UFORIGEM', tFIS_ALIQUOTAICMSUF) + ' para ' + item('CD_UFDESTINO', tFIS_ALIQUOTAICMSUF) + '!', cDS_METHOD);
          return(-1); exit;
        end;
        vPrAliqDestino := itemF('PR_ALIQICMS', tFIS_ALIQUOTAICMSUF);

        clear_e(tFIS_ALIQUOTAICMSUF);
        putitem_o(tFIS_ALIQUOTAICMSUF, 'CD_UFORIGEM', gDsUFOrigem);
        putitem_o(tFIS_ALIQUOTAICMSUF, 'CD_UFDESTINO', gDsUFOrigem);
        retrieve_e(tFIS_ALIQUOTAICMSUF);
        if (xStatus < 0) then begin
          Result := SetStatus(STS_ERROR, 'GEN001', 'Nenhuma aliquota cadastrada de ' + item('CD_UFORIGEM', tFIS_ALIQUOTAICMSUF) + ' para ' + item('CD_UFDESTINO', tFIS_ALIQUOTAICMSUF) + '!', cDS_METHOD);
          return(-1); exit;
        end;
        vPrAliqOrigem := itemF('PR_ALIQICMS', tFIS_ALIQUOTAICMSUF);

        if (itemF('PR_ALIQUOTA', tFIS_REGRAIMPOSTO) > 0) then begin
          vPrAliqOrigem := itemF('PR_ALIQUOTA', tFIS_REGRAIMPOSTO);
        end;

        vPrIVA := 0;
        putitem(tFIS_IMPOSTO, 'PR_ALIQUOTA', (vPrAliqOrigem - vPrAliqDestino));

      end else begin
        if (vTpIva <> 1) then begin
          if (gVldIcms <> 0) then begin
            vPrAliqInter := gVldIcms;
          end else begin
            clear_e(tFIS_ALIQUOTAICMSUF);
            putitem_o(tFIS_ALIQUOTAICMSUF, 'CD_UFORIGEM', gDsUFOrigem);
            putitem_o(tFIS_ALIQUOTAICMSUF, 'CD_UFDESTINO', gDsUFDestino);
            retrieve_e(tFIS_ALIQUOTAICMSUF);
            if (xStatus < 0) then begin
              Result := SetStatus(STS_ERROR, 'GEN001', 'Nenhuma aliquota cadastrada de ' + item('CD_UFORIGEM', tFIS_ALIQUOTAICMSUF) + ' para ' + item('CD_UFDESTINO', tFIS_ALIQUOTAICMSUF) + '!', cDS_METHOD);
              return(-1); exit;
            end;
            vPrAliqInter := itemF('PR_ALIQICMS', tFIS_ALIQUOTAICMSUF);
          end;
          if (vPrAliqIntra = 0) then begin
            clear_e(tFIS_ALIQUOTAICMSUF);
            putitem_o(tFIS_ALIQUOTAICMSUF, 'CD_UFORIGEM', gDsUFDestino);
            putitem_o(tFIS_ALIQUOTAICMSUF, 'CD_UFDESTINO', gDsUFDestino);
            retrieve_e(tFIS_ALIQUOTAICMSUF);
            if (xStatus < 0) then begin
              Result := SetStatus(STS_ERROR, 'GEN001', 'Nenhuma aliquota cadastrada de ' + item('CD_UFORIGEM', tFIS_ALIQUOTAICMSUF) + ' para ' + item('CD_UFDESTINO', tFIS_ALIQUOTAICMSUF) + '!', cDS_METHOD);
              return(-1); exit;
            end;
            vPrAliqIntra := itemF('PR_ALIQICMS', tFIS_ALIQUOTAICMSUF);
          end;
          if (itemB('IN_AJSIMPLES', tFIS_REGRAIMPOSTO) = TRUE) then begin
            if (vPrIVA = 0) then begin
              vPrIva := vPrIvaPrd;
            end;
            if (item('PR_AJSIMPLES', tFIS_REGRAIMPOSTO) <> '') then begin
              vPrIVA := (vPrIVA * itemF('PR_AJSIMPLES', tFIS_REGRAIMPOSTO))/100;
            end else begin
              vPrIVA := (vPrIVA * gPrAplicMvaSubTrib)/100;
            end;
            vInReducaoMVA := TRUE;
          end;

          vPrIVA := ((1 + (vPrIVA/100)) * ((1 - (vPrAliqInter/100)) / (1 - (vPrAliqIntra/100))) -1) * 100;
        end;
      end;
      if (itemB('IN_AJSIMPLES', tFIS_REGRAIMPOSTO) = TRUE) and (vInReducaoMVA <> TRUE) then begin
        if (vPrIVA = 0) then begin
          vPrIva := vPrIvaPrd;
        end;
        vPrIVA := (vPrIVA * gPrAplicMvaSubTrib)/100;
      end;

      vVlBaseCalc := vVlBaseCalc + ((vVlBaseCalc * vPrIVA) / 100);
      vVlBaseCalc := rounded(vVlBaseCalc, 6);

      putitem(tFIS_IMPOSTO, 'VL_OUTRO', 0);
      putitem(tFIS_IMPOSTO, 'VL_ISENTO', 0);
      putitem(tFIS_IMPOSTO, 'PR_REDUBASE', 0);
      putitem(tFIS_IMPOSTO, 'PR_BASECALC', 100);
      putitem(tFIS_IMPOSTO, 'VL_BASECALC', vVlBaseCalc);

      vVlICMS := itemF('VL_BASECALC', tFIS_IMPOSTO) * itemF('PR_ALIQUOTA', tFIS_IMPOSTO) / 100;
      vVlICMS := rounded(vVlICMS, 6);

      if (vVlICMS > gVlICMS) then begin
        putitem(tFIS_IMPOSTO, 'VL_IMPOSTO', vVlICMS - gVlICMS);
      end else begin
        putitem(tFIS_IMPOSTO, 'VL_IMPOSTO', vVlICMS);
      end;
    end;
  end else if (itemF('TP_CALCICMSST', tFIS_REGRAIMPOSTO) = 1) then begin
    if (itemB('IN_OUTRO', tFIS_REGRAIMPOSTO) = TRUE) or (itemB('IN_ISENTO', tFIS_REGRAIMPOSTO) = TRUE) then begin
      if (itemB('IN_OUTRO', tFIS_REGRAIMPOSTO) = TRUE) then begin
        putitem(tFIS_IMPOSTO, 'VL_OUTRO', vVlBaseCalc);
        putitem(tFIS_IMPOSTO, 'VL_ISENTO', 0);
      end else if (itemB('IN_ISENTO', tFIS_REGRAIMPOSTO) = TRUE) then begin
        putitem(tFIS_IMPOSTO, 'VL_ISENTO', vVlBaseCalc);
        putitem(tFIS_IMPOSTO, 'VL_OUTRO', 0);
      end;
      putitem(tFIS_IMPOSTO, 'VL_IMPOSTO', 0);
      putitem(tFIS_IMPOSTO, 'VL_BASECALC', 0);
      putitem(tFIS_IMPOSTO, 'PR_BASECALC', 0);
      putitem(tFIS_IMPOSTO, 'PR_REDUBASE', 0);
      putitem(tFIS_IMPOSTO, 'PR_ALIQUOTA', 0);
    end else begin
      clear_e(tFIS_ALIQUOTAICMSUF);
      putitem_o(tFIS_ALIQUOTAICMSUF, 'CD_UFORIGEM', gDsUFDestino);
      putitem_o(tFIS_ALIQUOTAICMSUF, 'CD_UFDESTINO', gDsUFDestino);
      retrieve_e(tFIS_ALIQUOTAICMSUF);
      if (xStatus < 0) then begin
        Result := SetStatus(STS_ERROR, 'GEN001', 'Nenhuma aliquota cadastrada de ' + item('CD_UFORIGEM', tFIS_ALIQUOTAICMSUF) + ' para ' + item('CD_UFDESTINO', tFIS_ALIQUOTAICMSUF) + '!', cDS_METHOD);
        return(-1); exit;
      end;
      vPrAliqIntra := itemF('PR_ALIQICMS', tFIS_ALIQUOTAICMSUF);

      putitem(tFIS_IMPOSTO, 'VL_IMPOSTO', vVlBaseCalc * (itemF('PR_CNAEICMSST', tFIS_REGRAIMPOSTO)/100));
      putitem(tFIS_IMPOSTO, 'VL_BASECALC', (gVlICMS + itemF('VL_IMPOSTO', tFIS_IMPOSTO))/(vPrAliqIntra/100));
      putitem(tFIS_IMPOSTO, 'PR_ALIQUOTA', itemF('PR_CNAEICMSST', tFIS_REGRAIMPOSTO));
      putitem(tFIS_IMPOSTO, 'PR_BASECALC', 100);
      putitem(tFIS_IMPOSTO, 'VL_ISENTO', 0);
      putitem(tFIS_IMPOSTO, 'VL_OUTRO', 0);
      putitem(tFIS_IMPOSTO, 'PR_REDUBASE', 0);
    end;
  end else if (itemF('TP_CALCICMSST', tFIS_REGRAIMPOSTO) = 2) then begin
    if (itemB('IN_OUTRO', tFIS_REGRAIMPOSTO) = TRUE) or (itemB('IN_ISENTO', tFIS_REGRAIMPOSTO) = TRUE) then begin
      If (itemB('IN_OUTRO', tFIS_REGRAIMPOSTO) = TRUE) then begin
        putitem(tFIS_IMPOSTO, 'VL_OUTRO', vVlBaseCalc);
        putitem(tFIS_IMPOSTO, 'VL_ISENTO', 0);
      end else if (itemB('IN_ISENTO', tFIS_REGRAIMPOSTO) = TRUE) then begin
        putitem(tFIS_IMPOSTO, 'VL_ISENTO', vVlBaseCalc);
        putitem(tFIS_IMPOSTO, 'VL_OUTRO', 0);
      end;
      putitem(tFIS_IMPOSTO, 'VL_IMPOSTO', 0);
      putitem(tFIS_IMPOSTO, 'VL_BASECALC', 0);
      putitem(tFIS_IMPOSTO, 'PR_BASECALC', 0);
      putitem(tFIS_IMPOSTO, 'PR_REDUBASE', 0);
      putitem(tFIS_IMPOSTO, 'PR_ALIQUOTA', 0);
    end else begin
      clear_e(tFIS_ALIQUOTAICMSUF);
      putitem_o(tFIS_ALIQUOTAICMSUF, 'CD_UFORIGEM', gDsUFDestino);
      putitem_o(tFIS_ALIQUOTAICMSUF, 'CD_UFDESTINO', gDsUFDestino);
      retrieve_e(tFIS_ALIQUOTAICMSUF);
      if (xStatus < 0) then begin
        Result := SetStatus(STS_ERROR, 'GEN001', 'Nenhuma aliquota cadastrada de ' + item('CD_UFORIGEM', tFIS_ALIQUOTAICMSUF) + ' para ' + item('CD_UFDESTINO', tFIS_ALIQUOTAICMSUF) + '!', cDS_METHOD);
        return(-1); exit;
      end;
      vPrAliqIntra := itemF('PR_ALIQICMS', tFIS_ALIQUOTAICMSUF);

      clear_e(tFIS_ALIQUOTAICMSUF);
      putitem_o(tFIS_ALIQUOTAICMSUF, 'CD_UFORIGEM', gDsUFOrigem);
      putitem_o(tFIS_ALIQUOTAICMSUF, 'CD_UFDESTINO', gDsUFDestino);
      retrieve_e(tFIS_ALIQUOTAICMSUF);
      if (xStatus < 0) then begin
        Result := SetStatus(STS_ERROR, 'GEN001', 'Nenhuma aliquota cadastrada de ' + item('CD_UFORIGEM', tFIS_ALIQUOTAICMSUF) + ' para ' + item('CD_UFDESTINO', tFIS_ALIQUOTAICMSUF) + '!', cDS_METHOD);
        return(-1); exit;
      end;
      vPrAliqInter := itemF('PR_ALIQICMS', tFIS_ALIQUOTAICMSUF);

      vPrAux := (vPrAliqIntra - vPrAliqInter);
      if (vPrAux < 0) then begin
        vPrAux := vPrAux * -1;
      end;

      putitem(tFIS_IMPOSTO, 'VL_IMPOSTO', vVlBaseCalc * (vPrAux/100));
      putitem(tFIS_IMPOSTO, 'VL_BASECALC', vVlBaseCalc);
      putitem(tFIS_IMPOSTO, 'PR_ALIQUOTA', vPrAux);
      putitem(tFIS_IMPOSTO, 'PR_BASECALC', 100);
      putitem(tFIS_IMPOSTO, 'VL_ISENTO', 0);
      putitem(tFIS_IMPOSTO, 'VL_OUTRO', 0);
      putitem(tFIS_IMPOSTO, 'PR_REDUBASE', 0);
    end;
  end;

  return(0); exit;
End;

//---------------------------------------------------------------------------------------
function T_FISSVCO080.calculaIPI() : String;
//---------------------------------------------------------------------------------------
const
  cDS_METHOD = 'T_FISSVCO080.calculaIPI()';
var
  vVlCalc : Real;
begin
  if (itemF('CD_IMPOSTO', tFIS_IMPOSTO) = 30) then begin
    if (gDtVigenciaIPI = 0) then begin
      gDtVigenciaIPI := itemD('DT_INIVIGENCIA', tFIS_IMPOSTO);
    end;

    discard(tFIS_IMPOSTO);

    if (gPrIPI > 0) then begin
      return(0); exit;
    end;

    creocc(tFIS_IMPOSTO, -1);
    putitem_o(tFIS_IMPOSTO, 'CD_IMPOSTO', 3);
    putitem_o(tFIS_IMPOSTO, 'DT_INIVIGENCIA', gDtVigenciaIPI);
    retrieve_o(tFIS_IMPOSTO);
    if (xStatus = -7) then begin
      retrieve_x(tFIS_IMPOSTO);
    end else if (xStatus = 0) then begin
      Result := SetStatus(STS_ERROR, 'GEN001', 'Imposto ' + item('CD_IMPOSTO', tFIS_IMPOSTO) + ' nao cadastrado!', cDS_METHOD);
      return(-1); exit;
    end;
  end else begin
    gDtVigenciaIPI := itemD('DT_INIVIGENCIA', tFIS_IMPOSTO);
  end;

  putitem(tFIS_IMPOSTO, 'CD_CST', itemF('CD_CST', tFIS_REGRAIMPOSTO));

  calculaBaseCalc();

  if (itemB('IN_OUTRO', tFIS_REGRAIMPOSTO) = TRUE) then begin
    putitem(tFIS_IMPOSTO, 'VL_OUTRO', itemF('VL_BASECALC', tFIS_IMPOSTO));
    putitem(tFIS_IMPOSTO, 'VL_ISENTO', 0);
    putitem(tFIS_IMPOSTO, 'VL_IMPOSTO', 0);
    putitem(tFIS_IMPOSTO, 'VL_BASECALC', 0);
    putitem(tFIS_IMPOSTO, 'PR_BASECALC', 0);
    putitem(tFIS_IMPOSTO, 'PR_REDUBASE', 0);
    putitem(tFIS_IMPOSTO, 'PR_ALIQUOTA', 0);

  end else if (itemB('IN_ISENTO', tFIS_REGRAIMPOSTO) = TRUE) then begin
    putitem(tFIS_IMPOSTO, 'VL_ISENTO', itemF('VL_BASECALC', tFIS_IMPOSTO));
    putitem(tFIS_IMPOSTO, 'VL_OUTRO', 0);
    putitem(tFIS_IMPOSTO, 'VL_IMPOSTO', 0);
    putitem(tFIS_IMPOSTO, 'VL_BASECALC', 0);
    putitem(tFIS_IMPOSTO, 'PR_BASECALC', 0);
    putitem(tFIS_IMPOSTO, 'PR_REDUBASE', 0);
    putitem(tFIS_IMPOSTO, 'PR_ALIQUOTA', 0);

  end else begin
    putitem(tFIS_IMPOSTO, 'PR_BASECALC', 100);

    if (gTpOrigemEmissao = 1) then begin
      if (item('PR_ALIQUOTA', tFIS_REGRAIMPOSTO) <> '') then begin
        putitem(tFIS_IMPOSTO, 'PR_ALIQUOTA', itemF('PR_ALIQUOTA', tFIS_REGRAIMPOSTO));
      end else if (gPrIPI <> 0) then begin
        putitem(tFIS_IMPOSTO, 'PR_ALIQUOTA', gPrIPI);
      end else begin
        putitem(tFIS_IMPOSTO, 'PR_ALIQUOTA', itemF('PR_IPI', tFIS_TIPI));
      end;
      vVlCalc := itemF('VL_BASECALC', tFIS_IMPOSTO) * itemF('PR_ALIQUOTA', tFIS_IMPOSTO) / 100;
      putitem(tFIS_IMPOSTO, 'VL_IMPOSTO', rounded(vVlCalc, 2));

    end else begin
      if (gVlIPI = 0) then begin
        if (gPrIPI <> 0) then begin
          putitem(tFIS_IMPOSTO, 'PR_ALIQUOTA', gPrIPI);
        end;
        vVlCalc := itemF('VL_BASECALC', tFIS_IMPOSTO) * itemF('PR_ALIQUOTA', tFIS_IMPOSTO) / 100;
        putitem(tFIS_IMPOSTO, 'VL_IMPOSTO', rounded(vVlCalc, 2));
      end else begin
        putitem(tFIS_IMPOSTO, 'PR_ALIQUOTA', gPrIPI);
        putitem(tFIS_IMPOSTO, 'VL_IMPOSTO', gVlIPI);
      end;
    end;
  end;
  if (gInImpostoOffLine = TRUE) then begin
    putitem(tFIS_IMPOSTO, 'VL_BASECALC', 0);
    putitem(tFIS_IMPOSTO, 'VL_IMPOSTO', 0);
  end;

  gPrIPI := itemF('PR_ALIQUOTA', tFIS_IMPOSTO);
  gVlIPI := itemF('VL_IMPOSTO', tFIS_IMPOSTO);

  return(0); exit;
End;

//---------------------------------------------------------------------------------------
function T_FISSVCO080.calculaISS() : String;
//---------------------------------------------------------------------------------------
const
  cDS_METHOD = 'T_FISSVCO080.calculaISS()';
var
  vVlCalc, vVlBaseCalc : Real;
begin
  if (gInImpostoOffLine = TRUE) then begin
    discard(tFIS_IMPOSTO);
    return(0); exit;
  end;

  calculaBaseCalc();

  if (itemB('IN_OUTRO', tFIS_REGRAIMPOSTO) = TRUE) then begin
    putitem(tFIS_IMPOSTO, 'VL_OUTRO', itemF('VL_BASECALC', tFIS_IMPOSTO));
    putitem(tFIS_IMPOSTO, 'VL_ISENTO', 0);
    putitem(tFIS_IMPOSTO, 'VL_IMPOSTO', 0);
    putitem(tFIS_IMPOSTO, 'VL_BASECALC', 0);
    putitem(tFIS_IMPOSTO, 'PR_BASECALC', 0);
    putitem(tFIS_IMPOSTO, 'PR_REDUBASE', 0);
    putitem(tFIS_IMPOSTO, 'PR_ALIQUOTA', 0);

  end else if (itemB('IN_ISENTO', tFIS_REGRAIMPOSTO) = TRUE) then begin
    putitem(tFIS_IMPOSTO, 'VL_ISENTO', itemF('VL_BASECALC', tFIS_IMPOSTO));
    putitem(tFIS_IMPOSTO, 'VL_OUTRO', 0);
    putitem(tFIS_IMPOSTO, 'VL_IMPOSTO', 0);
    putitem(tFIS_IMPOSTO, 'VL_BASECALC', 0);
    putitem(tFIS_IMPOSTO, 'PR_BASECALC', 0);
    putitem(tFIS_IMPOSTO, 'PR_REDUBASE', 0);
    putitem(tFIS_IMPOSTO, 'PR_ALIQUOTA', 0);

  end else begin
    if (item('PR_ALIQUOTA', tFIS_REGRAIMPOSTO) <> '') then begin
      putitem(tFIS_IMPOSTO, 'PR_ALIQUOTA', itemF('PR_ALIQUOTA', tFIS_REGRAIMPOSTO));
    end;
    putitem(tFIS_IMPOSTO, 'PR_BASECALC', 100);

    vVlCalc := itemF('VL_BASECALC', tFIS_IMPOSTO) * itemF('PR_ALIQUOTA', tFIS_IMPOSTO) / 100;
    putitem(tFIS_IMPOSTO, 'VL_IMPOSTO', rounded(vVlCalc, 6));
  end;

  return(0); exit;
End;

//------------------------------------------------------------------------------------------
function T_FISSVCO080.calculaCOFINS() : String;
//------------------------------------------------------------------------------------------
const
  cDS_METHOD = 'T_FISSVCO080.calculaCOFINS()';
var
  vVlCalc : Real;
begin
  if (gInImpostoOffLine = TRUE) then begin
    discard(tFIS_IMPOSTO);
    return(0); exit;
  end;

  putitem(tFIS_IMPOSTO, 'CD_CST', itemF('CD_CST', tFIS_REGRAIMPOSTO));

  calculaBaseCalc();

  if (itemB('IN_OUTRO', tFIS_REGRAIMPOSTO) = TRUE) then begin
    putitem(tFIS_IMPOSTO, 'VL_OUTRO', itemF('VL_BASECALC', tFIS_IMPOSTO));
    putitem(tFIS_IMPOSTO, 'VL_ISENTO', 0);
    putitem(tFIS_IMPOSTO, 'VL_IMPOSTO', 0);
    putitem(tFIS_IMPOSTO, 'VL_BASECALC', 0);
    putitem(tFIS_IMPOSTO, 'PR_BASECALC', 0);
    putitem(tFIS_IMPOSTO, 'PR_REDUBASE', 0);
    putitem(tFIS_IMPOSTO, 'PR_ALIQUOTA', 0);

  end else if (itemB('IN_ISENTO', tFIS_REGRAIMPOSTO) = TRUE) then begin
    putitem(tFIS_IMPOSTO, 'VL_ISENTO', itemF('VL_BASECALC', tFIS_IMPOSTO));
    putitem(tFIS_IMPOSTO, 'VL_OUTRO', 0);
    putitem(tFIS_IMPOSTO, 'VL_IMPOSTO', 0);
    putitem(tFIS_IMPOSTO, 'VL_BASECALC', 0);
    putitem(tFIS_IMPOSTO, 'PR_BASECALC', 0);
    putitem(tFIS_IMPOSTO, 'PR_REDUBASE', 0);
    putitem(tFIS_IMPOSTO, 'PR_ALIQUOTA', 0);

  end else begin
    if (item('PR_ALIQUOTA', tFIS_REGRAIMPOSTO) <> '') then begin
      putitem(tFIS_IMPOSTO, 'PR_ALIQUOTA', itemF('PR_ALIQUOTA', tFIS_REGRAIMPOSTO));
    end;
    putitem(tFIS_IMPOSTO, 'PR_BASECALC', 100);

    vVlCalc := itemF('VL_BASECALC', tFIS_IMPOSTO) * itemF('PR_ALIQUOTA', tFIS_IMPOSTO) / 100;
    putitem(tFIS_IMPOSTO, 'VL_IMPOSTO', rounded(vVlCalc, 6));
  end;

  return(0); exit;
End;

//---------------------------------------------------------------------------------------
function T_FISSVCO080.calculaPIS() : String;
//---------------------------------------------------------------------------------------
const
  cDS_METHOD = 'T_FISSVCO080.calculaPIS()';
var
  vVlCalc : Real;
begin
  if (gInImpostoOffLine = TRUE) then begin
    discard(tFIS_IMPOSTO);
    return(0); exit;
  end;

  putitem(tFIS_IMPOSTO, 'CD_CST', itemF('CD_CST', tFIS_REGRAIMPOSTO));

  calculaBaseCalc();

  if (itemB('IN_OUTRO', tFIS_REGRAIMPOSTO) = TRUE) then begin
    putitem(tFIS_IMPOSTO, 'VL_OUTRO', itemF('VL_BASECALC', tFIS_IMPOSTO));
    putitem(tFIS_IMPOSTO, 'VL_ISENTO', 0);
    putitem(tFIS_IMPOSTO, 'VL_IMPOSTO', 0);
    putitem(tFIS_IMPOSTO, 'VL_BASECALC', 0);
    putitem(tFIS_IMPOSTO, 'PR_BASECALC', 0);
    putitem(tFIS_IMPOSTO, 'PR_REDUBASE', 0);
    putitem(tFIS_IMPOSTO, 'PR_ALIQUOTA', 0);

  end else if (itemB('IN_ISENTO', tFIS_REGRAIMPOSTO) = TRUE) then begin
    putitem(tFIS_IMPOSTO, 'VL_ISENTO', itemF('VL_BASECALC', tFIS_IMPOSTO));
    putitem(tFIS_IMPOSTO, 'VL_OUTRO', 0);
    putitem(tFIS_IMPOSTO, 'VL_IMPOSTO', 0);
    putitem(tFIS_IMPOSTO, 'VL_BASECALC', 0);
    putitem(tFIS_IMPOSTO, 'PR_BASECALC', 0);
    putitem(tFIS_IMPOSTO, 'PR_REDUBASE', 0);
    putitem(tFIS_IMPOSTO, 'PR_ALIQUOTA', 0);

  end else begin
    if (item('PR_ALIQUOTA', tFIS_REGRAIMPOSTO) <> '') then begin
      putitem(tFIS_IMPOSTO, 'PR_ALIQUOTA', itemF('PR_ALIQUOTA', tFIS_REGRAIMPOSTO));
    end;
    putitem(tFIS_IMPOSTO, 'PR_BASECALC', 100);

    vVlCalc := itemF('VL_BASECALC', tFIS_IMPOSTO) * itemF('PR_ALIQUOTA', tFIS_IMPOSTO) / 100;
    putitem(tFIS_IMPOSTO, 'VL_IMPOSTO', rounded(vVlCalc, 6));
  end;

  return(0); exit;
End;

//-----------------------------------------------------------------------------------------
function T_FISSVCO080.calculaPASEP() : String;
//-----------------------------------------------------------------------------------------
const
  cDS_METHOD = 'T_FISSVCO080.calculaPASEP()';
var
  vVlCalc : Real;
begin
  if (gInImpostoOffLine = TRUE) then begin
    discard(tFIS_IMPOSTO);
    return(0); exit;
  end;

  calculaBaseCalc();

  if (itemB('IN_OUTRO', tFIS_REGRAIMPOSTO) = TRUE) then begin
    putitem(tFIS_IMPOSTO, 'VL_OUTRO', itemF('VL_BASECALC', tFIS_IMPOSTO));
    putitem(tFIS_IMPOSTO, 'VL_ISENTO', 0);
    putitem(tFIS_IMPOSTO, 'VL_IMPOSTO', 0);
    putitem(tFIS_IMPOSTO, 'VL_BASECALC', 0);
    putitem(tFIS_IMPOSTO, 'PR_BASECALC', 0);
    putitem(tFIS_IMPOSTO, 'PR_REDUBASE', 0);
    putitem(tFIS_IMPOSTO, 'PR_ALIQUOTA', 0);

  end else if (itemB('IN_ISENTO', tFIS_REGRAIMPOSTO) = TRUE) then begin
    putitem(tFIS_IMPOSTO, 'VL_ISENTO', itemF('VL_BASECALC', tFIS_IMPOSTO));
    putitem(tFIS_IMPOSTO, 'VL_OUTRO', 0);
    putitem(tFIS_IMPOSTO, 'VL_IMPOSTO', 0);
    putitem(tFIS_IMPOSTO, 'VL_BASECALC', 0);
    putitem(tFIS_IMPOSTO, 'PR_BASECALC', 0);
    putitem(tFIS_IMPOSTO, 'PR_REDUBASE', 0);
    putitem(tFIS_IMPOSTO, 'PR_ALIQUOTA', 0);

  end else begin
    if (item('PR_ALIQUOTA', tFIS_REGRAIMPOSTO) <> '') then begin
      putitem(tFIS_IMPOSTO, 'PR_ALIQUOTA', itemF('PR_ALIQUOTA', tFIS_REGRAIMPOSTO));
    end;
    putitem(tFIS_IMPOSTO, 'PR_BASECALC', 100);

    vVlCalc := itemF('VL_BASECALC', tFIS_IMPOSTO) * itemF('PR_ALIQUOTA', tFIS_IMPOSTO) / 100;
    putitem(tFIS_IMPOSTO, 'VL_IMPOSTO', rounded(vVlCalc, 6));
  end;

  return(0); exit;
End;

//----------------------------------------------------------------------------------------
function T_FISSVCO080.calculaCSLL() : String;
//----------------------------------------------------------------------------------------
const
  cDS_METHOD = 'T_FISSVCO080.calculaCSLL()';
var
  vVlCalc : Real;
begin
  if (gInImpostoOffLine = TRUE) then begin
    discard(tFIS_IMPOSTO);
    return(0); exit;
  end;

  calculaBaseCalc();

  if (itemB('IN_OUTRO', tFIS_REGRAIMPOSTO) = TRUE) then begin
    putitem(tFIS_IMPOSTO, 'VL_OUTRO', itemF('VL_BASECALC', tFIS_IMPOSTO));
    putitem(tFIS_IMPOSTO, 'VL_ISENTO', 0);
    putitem(tFIS_IMPOSTO, 'VL_IMPOSTO', 0);
    putitem(tFIS_IMPOSTO, 'VL_BASECALC', 0);
    putitem(tFIS_IMPOSTO, 'PR_BASECALC', 0);
    putitem(tFIS_IMPOSTO, 'PR_REDUBASE', 0);
    putitem(tFIS_IMPOSTO, 'PR_ALIQUOTA', 0);

  end else if (itemB('IN_ISENTO', tFIS_REGRAIMPOSTO) = TRUE) then begin
    putitem(tFIS_IMPOSTO, 'VL_ISENTO', itemF('VL_BASECALC', tFIS_IMPOSTO));
    putitem(tFIS_IMPOSTO, 'VL_OUTRO', 0);
    putitem(tFIS_IMPOSTO, 'VL_IMPOSTO', 0);
    putitem(tFIS_IMPOSTO, 'VL_BASECALC', 0);
    putitem(tFIS_IMPOSTO, 'PR_BASECALC', 0);
    putitem(tFIS_IMPOSTO, 'PR_REDUBASE', 0);
    putitem(tFIS_IMPOSTO, 'PR_ALIQUOTA', 0);

  end else begin
    if (item('PR_ALIQUOTA', tFIS_REGRAIMPOSTO) <> '') then begin
      putitem(tFIS_IMPOSTO, 'PR_ALIQUOTA', itemF('PR_ALIQUOTA', tFIS_REGRAIMPOSTO));
    end;
    putitem(tFIS_IMPOSTO, 'PR_BASECALC', 100);

    vVlCalc := itemF('VL_BASECALC', tFIS_IMPOSTO) * itemF('PR_ALIQUOTA', tFIS_IMPOSTO) / 100;
    putitem(tFIS_IMPOSTO, 'VL_IMPOSTO', rounded(vVlCalc, 6));
  end;

  return(0); exit;
End;

//--------------------------------------------------------------------------------------------
function T_FISSVCO080.calculaBaseCalc() : String;
//--------------------------------------------------------------------------------------------
const
  cDS_METHOD = 'T_FISSVCO080.calculaBaseCalc()';
begin
  if (itemF('TP_COMPOSICAOBC', tFIS_REGRAIMPOSTO) = 1) then begin
    putitem(tFIS_IMPOSTO, 'VL_BASECALC', gVlTotalLiquido + gVlFrete + gVlSeguro + gVlDespAcessor);
  end else if (itemF('TP_COMPOSICAOBC', tFIS_REGRAIMPOSTO) = 2) then begin
    putitem(tFIS_IMPOSTO, 'VL_BASECALC', gVlTotalLiquido);
  end else if (itemF('TP_COMPOSICAOBC', tFIS_REGRAIMPOSTO) = 3) then begin
    putitem(tFIS_IMPOSTO, 'VL_BASECALC', gVlTotalLiquido + gVlFrete + gVlSeguro + gVlDespAcessor + gVlIpi);
  end else if (itemF('TP_COMPOSICAOBC', tFIS_REGRAIMPOSTO) = 4) then begin
    putitem(tFIS_IMPOSTO, 'VL_BASECALC', gVlTotalLiquido + gVlSeguro + gVlDespAcessor + gVlIpi);
  end else if (itemF('TP_COMPOSICAOBC', tFIS_REGRAIMPOSTO) = 5) then begin
    putitem(tFIS_IMPOSTO, 'VL_BASECALC', gVlTotalLiquido + gVlDespAcessor + gVlIpi);
  end else if (itemF('TP_COMPOSICAOBC', tFIS_REGRAIMPOSTO) = 6) then begin
    putitem(tFIS_IMPOSTO, 'VL_BASECALC', gVlTotalLiquido + gVlIpi);
  end else if (itemF('TP_COMPOSICAOBC', tFIS_REGRAIMPOSTO) = 7) then begin
    putitem(tFIS_IMPOSTO, 'VL_BASECALC', gVlTotalLiquido + gVlSeguro + gVlDespAcessor);
  end else if (itemF('TP_COMPOSICAOBC', tFIS_REGRAIMPOSTO) = 8) then begin
    putitem(tFIS_IMPOSTO, 'VL_BASECALC', gVlTotalLiquido + gVlDespAcessor);
  end else if (itemF('TP_COMPOSICAOBC', tFIS_REGRAIMPOSTO) = 9) then begin
    putitem(tFIS_IMPOSTO, 'VL_BASECALC', gVlTotalBruto + gVlSeguro + gVlDespAcessor);
  end else if (itemF('TP_COMPOSICAOBC', tFIS_REGRAIMPOSTO) = 10) then begin
    putitem(tFIS_IMPOSTO, 'VL_BASECALC', gVlTotalBruto);
  end;

  return(0); exit;
end;

//---------------------------------------------------------------
function T_FISSVCO080.validaRegraNova(pParams : String) : String;
//---------------------------------------------------------------
const
  cDS_METHOD = 'T_FISSVCO080.validaRegraNova()';
var
  vCdRegraFiscal : Real;
begin
  vCdRegraFiscal := itemXmlF('CD_REGRAFISCAL', pParams);
  if (vCdRegraFiscal = 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN001', 'Regra fiscal nao informada!', cDS_METHOD);
    return(-1); exit;
  end;

  clear_e(tFIS_REGRAFISCAL);
  putitem_o(tFIS_REGRAFISCAL, 'CD_REGRAFISCAL', vCdRegraFiscal);
  retrieve_e(tFIS_REGRAFISCAL);
  if (xStatus >= 0) then begin
    putitemXml(Result, 'IN_NOVAREGRA', itemB('IN_NOVAREGRA', tFIS_REGRAADIC));
  end else begin
    Result := SetStatus(STS_ERROR, 'GEN001', 'Dados adicionais da regra nao cadastrado!', cDS_METHOD);
    return(-1); exit;
  end;

  clear_e(tFIS_REGRAREL);
  putitem_o(tFIS_REGRAREL, 'CD_REGRAPRINC', vCdRegraFiscal);
  retrieve_e(tFIS_REGRAREL);
  if (xStatus >= 0) then begin
    putitemXml(Result, 'IN_REGRAPAI', 1);
  end else begin
    putitemXml(Result, 'IN_REGRAPAI', 0);
  end;

  return(0); exit;
end;

//---------------------------------------------------------------------
function T_FISSVCO080.buscaRegraRelacionada(pParams : String) : String;
//---------------------------------------------------------------------
const
  cDS_METHOD = 'T_FISSVCO080.buscaRegraRelacionada()';
var
  viParams, voParams, vCdMPTer, vTpOperacao, vDsUF, vDsLst, vCdTipi, vCdCST, vDsAux, vClas : String;
  vCdEmpresaParam, vCdProduto, vCdOperacao, vCdPessoa, vCdCFOP, vTpClas, vCount : Real;
  vCdRegraFiscal, vTpAreaComercio, vOrigemPrdCst, vPos, vAux : Real;
  vInProdPropria, vInDecreto, vInOrgaopublico, vInPrReducao, vInValor, vUtilizaRegra, vInAchou : Boolean;
  vDtEmissao : TDateTime;
begin
  if (itemXml('UF_ORIGEM', pParams) <> '') then begin
    gDsUFOrigem := itemXml('UF_ORIGEM', pParams);
  end else begin
    gDsUFOrigem := itemXml('UF_ORIGEM', PARAM_GLB);
  end;

  gInOptSimples := itemXmlB('IN_OPT_SIMPLES', PARAM_GLB);
  gDsUFDestino := itemXml('UF_DESTINO', pParams);
  vCdProduto := itemXmlF('CD_PRODUTO', pParams);
  vCdMPTer := itemXml('CD_MPTER', pParams);
  gCdServico := itemXmlF('CD_SERVICO', pParams);
  vCdPessoa := itemXmlF('CD_PESSOA', pParams);
  vCdOperacao := itemXmlF('CD_OPERACAO', pParams);
  vCdCFOP := itemXmlF('CD_CFOP', pParams);
  vCdEmpresaParam := itemXmlF('CD_EMPRESA', pParams);
  if (vCdEmpresaParam  = 0) then begin
    vCdEmpresaParam := itemXmlF('CD_EMPRESA', PARAM_GLB);
  end;
  gTpModDctoFiscal := itemXmlF('TP_MODDCTOFISCAL', pParams);
  gTpOrigemEmissao := itemXmlF('TP_ORIGEMEMISSAO', pParams);
  vCdRegraFiscal := itemXmlF('CD_REGRAFISCAL', pParams);
  vDtEmissao := itemXmlD('DT_INIVIGENCIA', pParams);
  vCdTipi := itemXml('CD_TIPI', pParams);
  vCdCST := itemXml('CD_CST', pParams);
  gInContribuinte := FALSE;
  vInDecreto := FALSE;

  if (vCdOperacao = 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN001', 'Operacao nao informada!', cDS_METHOD);
    return(-1); exit;
  end;
  if (vCdPessoa = 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN001', 'Pessoa nao informada!', cDS_METHOD);
    return(-1); exit;
  end;
  if (gDsUfOrigem = '') then begin
    Result := SetStatus(STS_ERROR, 'GEN001', 'Origem nao informada!', cDS_METHOD);
    return(-1); exit;
  end;
  if (gDsUfDestino = '') then begin
    Result := SetStatus(STS_ERROR, 'GEN001', 'Origem nao informada!', cDS_METHOD);
    return(-1); exit;
  end;
  if (vDtEmissao = 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN001', 'Data de emiss√£o nao informada!', cDS_METHOD);
    return(-1); exit;
  end;

  clear_e(tGER_OPERACAO);
  putitem_o(tGER_OPERACAO, 'CD_OPERACAO', vCdOperacao);
  retrieve_e(tGER_OPERACAO);
  if (xStatus < 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN001', 'Operacao ' + FloatToStr(vCdOperacao) + ' nao cadastrada!', cDS_METHOD);
    return(-1); exit;
  end;
  if (item('TP_OPERACAO', tGER_OPERACAO) = 'E') then begin
    vDsAux := gDsUfOrigem;
    gDsUfOrigem := gDsUfDestino;
    gDsUfDestino := vDsAux;
  end;
  if (vCdRegraFiscal > 0) then begin
    putitem(tGER_OPERACAO, 'CD_REGRAFISCAL', vCdRegraFiscal);
  end else begin
    vCdRegraFiscal := itemF('CD_REGRAFISCAL', tGER_OPERACAO);
  end;
  if (gCdServico <> 0) or (vCdProduto = 0) then begin
    if (vCdCST <> '') then begin
      gCdCST := SubStr(vCdCST, 1, 1);
    end else begin
      gCdCST := '0';
    end;
  end else begin
    clear_e(tPRD_PRODUTO);
    putitem_o(tPRD_PRODUTO, 'CD_PRODUTO', vCdProduto);
    retrieve_e(tPRD_PRODUTO);
    if (xStatus < 0) then begin
      Result := SetStatus(STS_ERROR, 'GEN001', 'Produto ' + FloatToStr(vCdProduto) + ' nao cadastrado!', cDS_METHOD);
      return(-1); exit;
    end else begin
      clear_e(tPRD_PRDREGRAFISCAL);
      putitem_o(tPRD_PRDREGRAFISCAL, 'CD_OPERACAO', itemF('CD_OPERACAO', tGER_OPERACAO));
      retrieve_e(tPRD_PRDREGRAFISCAL);
      if (xStatus >= 0) then begin
        vCdRegraFiscal := itemF('CD_REGRAFISCAL', tPRD_PRDREGRAFISCAL);
      end;
    end;
    gCdCST := SubStr(item('CD_CST', tPRD_PRODUTO), 1, 1);
  end;

  clear_e(tPES_PESSOA);
  putitem_o(tPES_PESSOA, 'CD_PESSOA', vCdPessoa);
  retrieve_e(tPES_PESSOA);
  if (xStatus < 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN001', 'Pessoa nao informada!', cDS_METHOD);
    return(-1); exit;
  end;

  viParams := '';
  putitemXml(viParams, 'CD_PESSOA', vCdPessoa);
  voParams := activateCmp('FCRSVCO057', 'validaPessoaOrgaopublico', viParams);
  if (xStatus < 0) then begin
    Result := voParams; exit;
  end;

  gInPjIsento := FALSE;
  if (PosItem(item('NR_INSCESTL', tPES_PESJURIDICA), 'ISENTO|ISENTA|ISENTOS|ISENTAS') > 0) then begin
    gInPjIsento := TRUE;
  end;

  vInOrgaopublico := itemXmlB('IN_ORGAOPUBLICO', voParams);
  if (vInOrgaopublico = TRUE) and (gDsUFOrigem = 'DF') then begin
    gInContribuinte := TRUE;
  end else begin
    if (itemB('IN_CNSRFINAL', tPES_CLIENTE) = TRUE) or (item('TP_PESSOA', tPES_PESSOA) = 'F') or (gInPjIsento = TRUE) then begin
      if (itemB('IN_CNSRFINAL', tPES_CLIENTE) = TRUE) and (item('TP_PESSOA', tPES_PESSOA) = 'J') and (gInPjIsento = FALSE) then begin
        gInContribuinte := TRUE;
      end else begin
        if (item('TP_PESSOA', tPES_PESSOA) = 'F') and (((item('NR_CODIGOFISCAL', tPES_CLIENTE) <> '') and (PosItem(gDsUFOrigem, 'PR|SP|RS') > 0)) or (item('NR_INSCPRODRURAL', tPES_PFADIC) <> '')) then begin
          gInContribuinte := TRUE;
        end else begin
          gInContribuinte := FALSE;
        end;
      end;
    end else begin
      gInContribuinte := TRUE;
    end;
  end;

  if (gCdEmpParam = 0) or (gCdEmpParam <> vCdEmpresaParam) then begin
    getParam(pParams);
    gCdEmpParam := vCdEmpresaParam;
  end;

  clear_e(tFIS_REGRAFISCAL);
  putitem_o(tFIS_REGRAFISCAL, 'CD_REGRAFISCAL', vCdRegraFiscal);
  retrieve_e(tFIS_REGRAFISCAL);
  if (xStatus >= 0) then begin
    clear_e(tFIS_REGRAREL);
    putitem_o(tFIS_REGRAREL, 'CD_REGRAPRINC', item('CD_REGRAFISCAL', tFIS_REGRAFISCAL));
    putitem_o(tFIS_REGRAREL, 'DT_VIGINICIAL', '<=' + DateToStr(vDtEmissao));
    putitem_o(tFIS_REGRAREL, 'DT_VIGFINAL', '>=' + DateToStr(vDtEmissao));
    putitem_o(tFIS_REGRAREL, 'TP_SITUACAO', 1);
    retrieve_e(tFIS_REGRAREL);
    if (xStatus >= 0) then begin
      sort_e(tFIS_REGRAREL, 'NR_ORDEM');
      setocc(tFIS_REGRAREL, 1);
      while(xStatus >= 0) do begin
        setocc(tFIS_REGRACOND, 1);
        while(xStatus >= 0) do begin

          if (item('DS_VALOR', tFIS_REGRACOND) = 'V')
          or (item('DS_VALOR', tFIS_REGRACOND) = 'Verdadeiro')
          or (item('DS_VALOR', tFIS_REGRACOND) = 'T') then begin
            putitem(tFIS_REGRACOND, 'DS_VALOR', 'TRUE');
          end else if (item('DS_VALOR', tFIS_REGRACOND) = 'F')
                   or (item('DS_VALOR', tFIS_REGRACOND) = 'Falso')
                   or (item('DS_VALOR', tFIS_REGRACOND) = 'F') then begin
            putitem(tFIS_REGRACOND, 'DS_VALOR', 'FALSE');
          end;

          vUtilizaRegra := TRUE;
          case round(itemF('TP_CAMPO', tFIS_REGRACOND)) of
            1 : begin
              if (itemF('TP_OPERADOR', tFIS_REGRACOND) = 1) then begin
                vInValor := itemB('DS_VALOR', tFIS_REGRACOND);
                if (vInValor = TRUE) then begin
                  if (gDsUfOrigem = gDsUfDestino) then begin
                    vUtilizaRegra := FALSE;
                  end;
                end else begin
                  if (gDsUfOrigem <> gDsUfDestino) then begin
                    vUtilizaRegra := FALSE;
                  end;
                end;
              end else if (itemF('TP_OPERADOR', tFIS_REGRACOND) = 2) then begin
                vInValor := itemB('DS_VALOR', tFIS_REGRACOND);
                if (vInValor = TRUE) then begin
                  if (gDsUfOrigem <> gDsUfDestino) then begin
                    vUtilizaRegra := FALSE;
                  end;
                end else begin
                  if (gDsUfOrigem = gDsUfDestino) then begin
                    vUtilizaRegra := FALSE;
                  end;
                end;
              end;
            end;
            2 : begin
              if (itemF('TP_OPERADOR', tFIS_REGRACOND) = 1) then begin
                vInValor := itemB('DS_VALOR', tFIS_REGRACOND);
                if (vInValor <> gInContribuinte) then begin
                  vUtilizaRegra := FALSE;
                end;
              end else if (itemF('TP_OPERADOR', tFIS_REGRACOND) = 2) then begin
                vInValor := itemB('DS_VALOR', tFIS_REGRACOND);
                if (vInValor = gInContribuinte) then begin
                  vUtilizaRegra := FALSE;
                end;
              end;
            end;
            3 : begin
              if (itemF('TP_OPERADOR', tFIS_REGRACOND) = 1) then begin
                vInValor := itemB('DS_VALOR', tFIS_REGRACOND);
                if (vInValor <> itemB('IN_CNSRFINAL', tPES_CLIENTE)) then begin
                  vUtilizaRegra := FALSE;
                end;
              end else if (itemF('TP_OPERADOR', tFIS_REGRACOND) = 2) then begin
                vInValor := itemB('DS_VALOR', tFIS_REGRACOND);
                if (vInValor = itemB('IN_CNSRFINAL', tPES_CLIENTE)) then begin
                  vUtilizaRegra := FALSE;
                end;
              end;
            end;
            4 : begin
              if (itemF('TP_OPERADOR', tFIS_REGRACOND) = 1) then begin
                if (item('DS_VALOR', tFIS_REGRACOND) <> gDsUfOrigem) then begin
                  vUtilizaRegra := FALSE;
                end;
              end else if (itemF('TP_OPERADOR', tFIS_REGRACOND) = 2) then begin
                if (item('DS_VALOR', tFIS_REGRACOND) = gDsUfOrigem) then begin
                  vUtilizaRegra := FALSE;
                end;
              end else if (itemF('TP_OPERADOR', tFIS_REGRACOND) = 8) then begin
                vDsLst := item('DS_VALOR', tFIS_REGRACOND);
                vPos := PosItem(gDsUfOrigem, vDsLst);
                if (vPos = 0) then begin
                  vUtilizaRegra := FALSE;
                end;
              end else if (itemF('TP_OPERADOR', tFIS_REGRACOND) = 9) then begin
                vDsLst := item('DS_VALOR', tFIS_REGRACOND);
                vPos := PosItem(gDsUfOrigem, vDsLst);
                if (vPos > 0) then begin
                  vUtilizaRegra := FALSE;
                end;
              end;
            end;
            5 : begin
              if (itemF('TP_OPERADOR', tFIS_REGRACOND) = 1) then begin
                if (item('DS_VALOR', tFIS_REGRACOND) <> gDsUfDestino) then begin
                  vUtilizaRegra := FALSE;
                end;
              end else if (itemF('TP_OPERADOR', tFIS_REGRACOND) = 2) then begin
                if (item('DS_VALOR', tFIS_REGRACOND) = gDsUfDestino) then begin
                  vUtilizaRegra := FALSE;
                end;
              end else if (itemF('TP_OPERADOR', tFIS_REGRACOND) = 8) then begin
                vDsLst := item('DS_VALOR', tFIS_REGRACOND);
                vPos := PosItem(gDsUfDestino, vDsLst);
                if (vPos = 0) then begin
                  vUtilizaRegra := FALSE;
                end;
              end else if (itemF('TP_OPERADOR', tFIS_REGRACOND) = 9) then begin
                vDsLst := item('DS_VALOR', tFIS_REGRACOND);
                vPos := PosItem(gDsUfDestino, vDsLst);
                if (vPos > 0) then begin
                  vUtilizaRegra := FALSE;
                end;
              end;
            end;
            6 : begin
              if (item('NR_INSCPRODRURAL', tPES_PFADIC) <> '') then begin
                vInValor := TRUE;
              end else begin
                vInValor := FALSE;
              end;
              if (itemF('TP_OPERADOR', tFIS_REGRACOND) = 1) then begin
                if (vInValor <> itemB('DS_VALOR', tFIS_REGRACOND)) then begin
                  vUtilizaRegra := FALSE;
                end;
              end else if (itemF('TP_OPERADOR', tFIS_REGRACOND) = 2) then begin
                if (vInValor = itemB('DS_VALOR', tFIS_REGRACOND)) then begin
                  vUtilizaRegra := FALSE;
                end;
              end;
            end;
            7 : begin
              if (item('NR_SUFRAMA', tPES_CLIENTE) <> '') then begin
                vInValor := TRUE;
              end else begin
                vInValor := FALSE;
              end;
              if (itemF('TP_OPERADOR', tFIS_REGRACOND) = 1) then begin
                if (vInValor <> itemB('DS_VALOR', tFIS_REGRACOND)) then begin
                  vUtilizaRegra := FALSE;
                end;
              end else if (itemF('TP_OPERADOR', tFIS_REGRACOND) = 2) then begin
                if (vInValor = itemB('DS_VALOR', tFIS_REGRACOND)) then begin
                  vUtilizaRegra := FALSE;
                end;
              end;
            end;
            8 : begin
              if (itemF('TP_OPERADOR', tFIS_REGRACOND) = 1) then begin
                if (vInOrgaopublico <> itemB('DS_VALOR', tFIS_REGRACOND)) then begin
                  vUtilizaRegra := FALSE;
                end;
              end else if (itemF('TP_OPERADOR', tFIS_REGRACOND) = 2) then begin
                if (vInOrgaopublico = itemB('DS_VALOR', tFIS_REGRACOND)) then begin
                  vUtilizaRegra := FALSE;
                end;
              end;
            end;
            9 : begin
              if (itemF('TP_OPERADOR', tFIS_REGRACOND) = 1) then begin
                if (gInOptSimples <> itemB('DS_VALOR', tFIS_REGRACOND)) then begin
                  vUtilizaRegra := FALSE;
                end;
              end else if (itemF('TP_OPERADOR', tFIS_REGRACOND) = 2) then begin
                if (gInOptSimples = itemB('DS_VALOR', tFIS_REGRACOND)) then begin
                  vUtilizaRegra := FALSE;
                end;
              end;
            end;
            10 : begin
              if (item('TP_PESSOA', tPES_PESSOA) <> 'F') then begin
                if (empty(tPES_PESJURIDICA) <> False) then begin
                  Result := SetStatus(STS_ERROR, 'GEN001', 'Pessoa ' + FloatToStr(vCdPessoa) + ' nao √© jur√≠dica!', cDS_METHOD);
                  return(-1); exit;
                end;
                if (itemF('TP_OPERADOR', tFIS_REGRACOND) = 1) then begin
                  if (itemF('TP_REGIMETRIB', tPES_PESJURIDICA) <> itemF('DS_VALOR', tFIS_REGRACOND)) then begin
                    vUtilizaRegra := FALSE;
                  end;
                end else if (itemF('TP_OPERADOR', tFIS_REGRACOND) = 2) then begin
                  if (itemF('TP_REGIMETRIB', tPES_PESJURIDICA) = itemF('DS_VALOR', tFIS_REGRACOND)) then begin
                    vUtilizaRegra := FALSE;
                  end;
                end else if (itemF('TP_OPERADOR', tFIS_REGRACOND) = 8) then begin
                  vDsLst := item('DS_VALOR', tFIS_REGRACOND);
                  vPos := PosItem(item('TP_REGIMETRIB', tPES_PESJURIDICA), vDsLst);
                  if (vPos = 0) then begin
                    vUtilizaRegra := FALSE;
                  end;
                end else if (itemF('TP_OPERADOR', tFIS_REGRACOND) = 9) then begin
                  vDsLst := item('DS_VALOR', tFIS_REGRACOND);
                  vPos := PosItem(item('TP_REGIMETRIB', tPES_PESJURIDICA), vDsLst);
                  if (vPos > 0) then begin
                    vUtilizaRegra := FALSE;
                  end;
                end;
              end else begin
                vUtilizaRegra := FALSE;
              end;
            end;
            11 : begin
              vTpAreaComercio := itemXmlF('TP_AREA_COMERCIO_ORIGEM', PARAM_GLB);
              if (itemF('TP_OPERADOR', tFIS_REGRACOND) = 1) then begin
                if (vTpAreaComercio <> itemF('DS_VALOR', tFIS_REGRACOND)) then begin
                  vUtilizaRegra := FALSE;
                end;
              end else if (itemF('TP_OPERADOR', tFIS_REGRACOND) = 2) then begin
                if (vTpAreaComercio = itemF('DS_VALOR', tFIS_REGRACOND)) then begin
                  vUtilizaRegra := FALSE;
                end;
              end;
            end;
            12 : begin
              viParams := '';
              putitemXml(viParams, 'CD_PESSOA', itemF('CD_PESSOA', tPES_PESSOA));
              putitemXml(viParams, 'NM_MUNICIPIO', item('NM_MUNICIPIO', tGLB_MUNICIPIO));
              putitemXml(viParams, 'DS_SIGLAESTADO', item('DS_SIGLA', tGLB_ESTADO));
              voParams := activateCmp('PESSVCO005', 'verificaAreaComercio', viParams);
              if (xStatus < 0) then begin
                Result := voParams; exit;
              end;

              vTpAreaComercio := itemXmlF('TP_AREACOMERCIO', voParams);
              if (itemF('TP_OPERADOR', tFIS_REGRACOND) = 1) then begin
                if (vTpAreaComercio <> itemF('DS_VALOR', tFIS_REGRACOND)) then begin
                  vUtilizaRegra := FALSE;
                end;
              end else if (itemF('TP_OPERADOR', tFIS_REGRACOND) = 2) then begin
                if (vTpAreaComercio = itemF('DS_VALOR', tFIS_REGRACOND)) then begin
                  vUtilizaRegra := FALSE;
                end;
              end else if (itemF('TP_OPERADOR', tFIS_REGRACOND) = 8) then begin
                vDsLst := item('DS_VALOR', tFIS_REGRACOND);
                vPos := PosItem(FloatToStr(vTpAreaComercio), vDsLst);
                if (vPos = 0) then begin
                  vUtilizaRegra := FALSE;
                end;
            end else if (itemF('TP_OPERADOR', tFIS_REGRACOND) = 9) then begin
                vDsLst := item('DS_VALOR', tFIS_REGRACOND);
                vPos := PosItem(FloatToStr(vTpAreaComercio), vDsLst);
                if (vPos > 0) then begin
                  vUtilizaRegra := FALSE;
                end;
              end;
            end;
            13 : begin

              vOrigemPrdCst := StrToFloatDef(gCdCST,0);

              if (itemF('TP_OPERADOR', tFIS_REGRACOND) = 1) then begin
                if (vOrigemPrdCst <> itemF('DS_VALOR', tFIS_REGRACOND)) then begin
                  vUtilizaRegra := FALSE;
                end;
              end else if (itemF('TP_OPERADOR', tFIS_REGRACOND) = 2) then begin
                if (vOrigemPrdCst = itemF('DS_VALOR', tFIS_REGRACOND)) then begin
                  vUtilizaRegra := FALSE;
                end;
              end else if (itemF('TP_OPERADOR', tFIS_REGRACOND) = 3) then begin
                if (vOrigemPrdCst <= itemF('DS_VALOR', tFIS_REGRACOND)) then begin
                  vUtilizaRegra := FALSE;
                end;
              end else if (itemF('TP_OPERADOR', tFIS_REGRACOND) = 4) then begin
                if (vOrigemPrdCst >= itemF('DS_VALOR', tFIS_REGRACOND)) then begin
                  vUtilizaRegra := FALSE;
                end;
              end else if (itemF('TP_OPERADOR', tFIS_REGRACOND) = 5) then begin
                if (vOrigemPrdCst < itemF('DS_VALOR', tFIS_REGRACOND)) then begin
                  vUtilizaRegra := FALSE;
                end;
              end else if (itemF('TP_OPERADOR', tFIS_REGRACOND) = 6) then begin
                if (vOrigemPrdCst > itemF('DS_VALOR', tFIS_REGRACOND)) then begin
                  vUtilizaRegra := FALSE;
                end;
              end else if (itemF('TP_OPERADOR', tFIS_REGRACOND) = 7) then begin
                if (vOrigemPrdCst <= itemF('DS_VALOR', tFIS_REGRACOND)) or (vOrigemPrdCst >= itemF('DS_VALOROPCIONAL', tFIS_REGRACOND)) then begin
                  vUtilizaRegra := FALSE;
                end;
              end else if (itemF('TP_OPERADOR', tFIS_REGRACOND) = 8) then begin
                vDsLst := item('DS_VALOR', tFIS_REGRACOND);
                vPos := PosItem(FloatToStr(vOrigemPrdCst), vDsLst);
                if (vPos = 0) then begin
                  vUtilizaRegra := FALSE;
                end;
              end else if (itemF('TP_OPERADOR', tFIS_REGRACOND) = 9) then begin
                vDsLst := item('DS_VALOR', tFIS_REGRACOND);
                vPos := PosItem(FloatToStr(vOrigemPrdCst), vDsLst);
                if (vPos > 0) then begin
                  vUtilizaRegra := FALSE;
                end;
              end;
            end;
            14 : begin
              if (gCdServico > 0) then begin
                vInProdPropria := FALSE;
              end else if (vCdMPTer <> '') then begin
                vInProdPropria := FALSE;
              end else begin
                if (vCdProduto = 0) then begin
                  vInProdPropria := FALSE;
                end else begin
                  viParams := '';
                  putitemXml(viParams, 'CD_EMPRESA', vCdEmpresaParam);
                  putitemXml(viParams, 'CD_PRODUTO', vCdProduto);
                  voParams := activateCmp('PRDSVCO008', 'buscaDadosFilial', viParams);
                  if (xStatus < 0) then begin
                    Result := voParams; exit;
                  end;
                  vInProdPropria := itemXmlB('IN_PRODPROPRIA', voParams);
                end;
              end;
              if (itemF('TP_OPERADOR', tFIS_REGRACOND) = 1) then begin
                if (vInProdPropria <> itemB('DS_VALOR', tFIS_REGRACOND)) then begin
                  vUtilizaRegra := FALSE;
                end;
              end else if (itemF('TP_OPERADOR', tFIS_REGRACOND) = 2) then begin
                if (vInProdPropria = itemB('DS_VALOR', tFIS_REGRACOND)) then begin
                  vUtilizaRegra := FALSE;
                end;
              end;
            end;
            15 : begin
              if (itemF('TP_OPERADOR', tFIS_REGRACOND) = 1) then begin
                if (item('CD_ATIVIDADE', tPES_PESJURIDICA) <> item('DS_VALOR', tFIS_REGRACOND)) then begin
                  vUtilizaRegra := FALSE;
                end;
              end else if (itemF('TP_OPERADOR', tFIS_REGRACOND) = 2) then begin
                if (item('CD_ATIVIDADE', tPES_PESJURIDICA) = item('DS_VALOR', tFIS_REGRACOND)) then begin
                  vUtilizaRegra := FALSE;
                end;
              end;
            end;
            16 : begin
              putitem(tFIS_REGRACOND, 'DS_VALOR', ReplaceStr(item('DS_VALOR', tFIS_REGRACOND), '.', ''));
              putitem(tFIS_REGRACOND, 'DS_VALOROPCIONAL', ReplaceStr(item('DS_VALOROPCIONAL', tFIS_REGRACOND), '.', ''));
              if (itemF('TP_OPERADOR', tFIS_REGRACOND) = 1) then begin
                if (vCdTipi <> item('DS_VALOR', tFIS_REGRACOND)) then begin
                  vUtilizaRegra := FALSE;
                end;
              end else if (itemF('TP_OPERADOR', tFIS_REGRACOND) = 2) then begin
                if (vCdTipi = item('DS_VALOR', tFIS_REGRACOND)) then begin
                  vUtilizaRegra := FALSE;
                end;
              end else if (itemF('TP_OPERADOR', tFIS_REGRACOND) = 7) then begin
                if (vCdTipi <= item('DS_VALOR', tFIS_REGRACOND))or(vCdTipi >= item('DS_VALOROPCIONAL', tFIS_REGRACOND)) then begin
                  vUtilizaRegra := FALSE;
                end;
              end else if (itemF('TP_OPERADOR', tFIS_REGRACOND) = 8) then begin
                vDsLst := item('DS_VALOR', tFIS_REGRACOND);
                vPos := PosItem(vCdTipi, vDsLst);
                if (vPos = 0) then begin
                  vUtilizaRegra := FALSE;
                end;
              end else if (itemF('TP_OPERADOR', tFIS_REGRACOND) = 9) then begin
                vDsLst := item('DS_VALOR', tFIS_REGRACOND);
                vPos := PosItem(vCdTipi, vDsLst);
                if (vPos > 0) then begin
                  vUtilizaRegra := FALSE;
                end;
              end;
            end;
            17 : begin
              gNr02 := 0;
              clear_e(tPRD_PRDINFOADIC);
              putitem_o(tPRD_PRDINFOADIC, 'CD_EMPRESA', vCdEmpresaParam);
              putitem_o(tPRD_PRDINFOADIC, 'CD_PRODUTO', vCdProduto);
              retrieve_e(tPRD_PRDINFOADIC);
              if (xStatus >= 0) then begin
                gNr02 := itemF('TP_PRDSPED', tPRD_PRDINFOADIC);
              end;
              if (itemF('TP_OPERADOR', tFIS_REGRACOND) = 1) then begin
                if (gNr02 <> itemF('DS_VALOR', tFIS_REGRACOND)) or (gNr02 = 0) then begin
                  vUtilizaRegra := FALSE;
                end;
              end else if (itemF('TP_OPERADOR', tFIS_REGRACOND) = 2) then begin
                if (gNr02 = itemF('DS_VALOR', tFIS_REGRACOND)) then begin
                  vUtilizaRegra := FALSE;
                end;
              end else if (itemF('TP_OPERADOR', tFIS_REGRACOND) = 3) then begin
                if (gNr02  <= itemF('DS_VALOR', tFIS_REGRACOND)) or (gNr02 = 0) then begin
                  vUtilizaRegra := FALSE;
                end;
              end else if (itemF('TP_OPERADOR', tFIS_REGRACOND) = 4) then begin
                if (gNr02  >= itemF('DS_VALOR', tFIS_REGRACOND)) or (gNr02 = 0) then begin
                  vUtilizaRegra := FALSE;
                end;
              end else if (itemF('TP_OPERADOR', tFIS_REGRACOND) = 5) then begin
                if (gNr02  > itemF('DS_VALOR', tFIS_REGRACOND)) or (gNr02 = 0) then begin
                  vUtilizaRegra := FALSE;
                end;
              end else if (itemF('TP_OPERADOR', tFIS_REGRACOND) = 6) then begin
                if (gNr02  < itemF('DS_VALOR', tFIS_REGRACOND)) or (gNr02 = 0) then begin
                  vUtilizaRegra := FALSE;
                end;
              end else if (itemF('TP_OPERADOR', tFIS_REGRACOND) = 8) then begin
                vDsLst := item('DS_VALOR', tFIS_REGRACOND);
                vPos := PosItem(FloatToStr(gNr02), vDsLst);
                if (vPos = 0) then begin
                  vUtilizaRegra := FALSE;
                end;
              end else if (itemF('TP_OPERADOR', tFIS_REGRACOND) = 9) then begin
                vDsLst := item('DS_VALOR', tFIS_REGRACOND);
                vPos := PosItem(FloatToStr(gNr02), vDsLst);
                if (vPos > 0) then begin
                  vUtilizaRegra := FALSE;
                end;
              end;
            end;
            18 : begin

              vInAchou := TRUE;

              viParams := '';
              putitemXml(viParams, 'CD_PRODUTO', itemF('CD_PRODUTO', tPRD_PRODUTO));
              putitemXml(viParams, 'UF_ORIGEM', gDsUFOrigem);
              putitemXml(viParams, 'UF_DESTINO', gDsUFDestino);
              putitemXml(viParams, 'TP_OPERACAO', itemF('TP_OPERACAO', tGER_OPERACAO));
              putitemXml(viParams, 'CD_PESSOA', vCdPessoa);
              voParams := activateCmp('FISSVCO035', 'buscaDadosFiscalProduto', viParams);
              if (xStatus < 0) then begin
                Result := voParams; exit;
              end;
              if (voParams = '') then begin
                vInAchou := FALSE;
              end;
              if (itemF('TP_OPERADOR', tFIS_REGRACOND) = 1) then begin
                if (vInAchou <> itemB('DS_VALOR', tFIS_REGRACOND)) then begin
                  vUtilizaRegra := FALSE;
                end;
              end else if (itemF('TP_OPERADOR', tFIS_REGRACOND) = 2) then begin
                if (vInAchou = itemB('DS_VALOR', tFIS_REGRACOND)) then begin
                  vUtilizaRegra := FALSE;
                end;
              end;
            end;
            19 : begin

              if (itemF('TP_OPERADOR', tFIS_REGRACOND) = 1) then begin
                if (gNaturezaComercialEmp <> item('DS_VALOR', tFIS_REGRACOND)) then begin
                  vUtilizaRegra := FALSE;
                end;
              end else if (itemF('TP_OPERADOR', tFIS_REGRACOND) = 2) then begin
                if (gNaturezaComercialEmp = item('DS_VALOR', tFIS_REGRACOND)) then begin
                  vUtilizaRegra := FALSE;
                end;
              end else if (itemF('TP_OPERADOR', tFIS_REGRACOND) = 8) then begin
                vDsLst := item('DS_VALOR', tFIS_REGRACOND);
                vPos := PosItem(vDsLst, gNaturezaComercialEmp);
                if (vPos = 0) then begin
                  vUtilizaRegra := FALSE;
                end;
              end else if (itemF('TP_OPERADOR', tFIS_REGRACOND) = 9) then begin
                vDsLst := item('DS_VALOR', tFIS_REGRACOND);
                vPos := PosItem(vDsLst, gNaturezaComercialEmp);
                if (vPos > 0) then begin
                  vUtilizaRegra := FALSE;
                end;
              end;
            end;
            20 : begin
              if (itemF('TP_OPERADOR', tFIS_REGRACOND) = 1) then begin
                if (item('CD_ATIVIDADE', tPES_PJADIC) <> item('DS_VALOR', tFIS_REGRACOND)) then begin
                  vUtilizaRegra := FALSE;
                end;
              end else if (itemF('TP_OPERADOR', tFIS_REGRACOND) = 2) then begin
                if (item('CD_ATIVIDADE', tPES_PJADIC) = item('DS_VALOR', tFIS_REGRACOND)) then begin
                  vUtilizaRegra := FALSE;
                end;
              end else if (itemF('TP_OPERADOR', tFIS_REGRACOND) = 8) then begin
                vDsLst := item('DS_VALOR', tFIS_REGRACOND);
                vPos := PosItem(item('CD_ATIVIDADE', tPES_PJADIC), vDsLst);
                if (vPos = 0) then begin
                  vUtilizaRegra := FALSE;
                end;
              end else if (itemF('TP_OPERADOR', tFIS_REGRACOND) = 9) then begin
                vDsLst := item('DS_VALOR', tFIS_REGRACOND);
                vPos := PosItem(item('CD_ATIVIDADE', tPES_PJADIC), vDsLst);
                if (vPos > 0) then begin
                  vUtilizaRegra := FALSE;
                end;
              end;
            end;
            21 : begin
              if (itemF('TP_OPERADOR', tFIS_REGRACOND) = 1) then begin
                getitem(vTpclas, item('DS_VALOR', tFIS_REGRACOND), 1);
                vDsLst := item('DS_VALOR', tFIS_REGRACOND);
                delitemGld(vDsLst, 1);

                clear_e(tPRD_PRODUTOCLAS);
                putitem_o(tPRD_PRODUTOCLAS, 'CD_PRODUTO', vCdProduto);
                putitem_o(tPRD_PRODUTOCLAS, 'CD_TIPOCLAS', vTpclas);
                putitem_o(tPRD_PRODUTOCLAS, 'CD_CLASSIFICACAO', vDsLst);
                retrieve_e(tPRD_PRODUTOCLAS);
                if (xStatus < 0) then begin
                  vUtilizaRegra := FALSE;
                end;
              end else if (itemF('TP_OPERADOR', tFIS_REGRACOND) = 2) then begin
                getitem(vTpclas, item('DS_VALOR', tFIS_REGRACOND), 1);
                vDsLst := item('DS_VALOR', tFIS_REGRACOND);
                delitemGld(vDsLst, 1);

                clear_e(tPRD_PRODUTOCLAS);
                putitem_o(tPRD_PRODUTOCLAS, 'CD_PRODUTO', vCdProduto);
                putitem_o(tPRD_PRODUTOCLAS, 'CD_TIPOCLAS', vTpclas);
                putitem_o(tPRD_PRODUTOCLAS, 'CD_CLASSIFICACAO', vDsLst);
                retrieve_e(tPRD_PRODUTOCLAS);
                if (xStatus >= 0) then begin
                  vUtilizaRegra := FALSE;
                end;
              end else if (itemF('TP_OPERADOR', tFIS_REGRACOND) = 8) then begin
                vInAchou := FALSE;
                vDsLst := item('DS_VALOR', tFIS_REGRACOND);
                while (vDsLst <> '') do begin
                  vCount := 0;
                  repeat
                    vCount := vCount + 1;
                    if (vCount = 1) then begin
                      getitem(vTpclas, vDsLst, 1);
                    end else begin
                      getitem(vClas, vDsLst, 1);
                    end;
                    delitemGld(vDsLst, 1);
                  until (vCount = 2);

                  clear_e(tPRD_PRODUTOCLAS);
                  putitem_o(tPRD_PRODUTOCLAS, 'CD_PRODUTO', vCdProduto);
                  putitem_o(tPRD_PRODUTOCLAS, 'CD_TIPOCLAS', vTpclas);
                  putitem_o(tPRD_PRODUTOCLAS, 'CD_CLASSIFICACAO', vClas);
                  retrieve_e(tPRD_PRODUTOCLAS);
                  if (xStatus >= 0) then begin
                    vInAchou := TRUE;
                  end;
                end;
                if (vInAchou = FALSE) then begin
                  vUtilizaRegra := FALSE;
                end;
              end else if (itemF('TP_OPERADOR', tFIS_REGRACOND) = 9) then begin
                vInAchou := FALSE;
                vDsLst := item('DS_VALOR', tFIS_REGRACOND);
                while (vDsLst <> '') do begin
                  vCount := 0;
                  repeat
                    vCount := vCount + 1;
                    if (vCount = 1) then begin
                      getitem(vTpclas, vDsLst, 1);
                    end else begin
                      getitem(vClas, vDsLst, 1);
                    end;
                    delitemGld(vDsLst, 1);
                  until (vCount = 2);

                  clear_e(tPRD_PRODUTOCLAS);
                  putitem_o(tPRD_PRODUTOCLAS, 'CD_PRODUTO', vCdProduto);
                  putitem_o(tPRD_PRODUTOCLAS, 'CD_TIPOCLAS', vTpclas);
                  putitem_o(tPRD_PRODUTOCLAS, 'CD_CLASSIFICACAO', vClas);
                  retrieve_e(tPRD_PRODUTOCLAS);
                  if (xStatus >= 0) then begin
                    vInAchou := TRUE;
                  end;
                end;
                if (vInAchou = TRUE) then begin
                  vUtilizaRegra := FALSE;
                end;
              end;
            end;
          end;

          if (vUtilizaRegra = FALSE) then begin
            break;
          end;

          setocc(tFIS_REGRACOND, curocc(tFIS_REGRACOND) + 1);
        end;
        if (vUtilizaRegra = TRUE) then begin
          vCdRegraFiscal := itemF('CD_REGRAREL', tFIS_REGRAREL);
          break;
        end;

        setocc(tFIS_REGRAREL, curocc(tFIS_REGRAREL) + 1);
      end;
    end;
  end else begin
    Result := SetStatus(STS_ERROR, 'GEN001', 'Regra fiscal nao cadastrada!', cDS_METHOD);
    return(-1); exit;
  end;

  clear_e(tFIS_REGRAFISCAL);
  putitem_o(tFIS_REGRAFISCAL, 'CD_REGRAFISCAL', vCdRegraFiscal);
  retrieve_e(tFIS_REGRAFISCAL);
  if (xStatus < 0) then begin
    clear_e(tFIS_REGRAFISCAL);
  end;

  Result := '';
  putlistitensocc_e(Result, tFIS_REGRAFISCAL);
  putitemXml(Result, 'IN_CONTRIBUINTE', gInContribuinte);

  return(0); exit;
End;

//------------------------------------------------------------------
function T_FISSVCO080.calculaImpostoItem(pParams : String) : String;
//------------------------------------------------------------------
const
  cDS_METHOD = 'T_FISSVCO080.calculaImpostoItem()';
var
  vInOrgaopublico : Boolean;
  vDtIniVigencia : TDateTime;
  vCdEmpresa, vCdProduto, vCdOperacao, vCdPessoa, vCdImposto, vCdRegraFiscal : Real;
  vCdCFOP, vNrTam : Real;
  viParams, voParams, vDsUF, vDsRegistro, vDsLstImposto, vDsLstImpCalc : String;
  vCdMPTer, vNmMunicipio, vCdCST, vDsLstCdImposto : String;
begin
  vCdEmpresa := itemXmlF('CD_EMPRESA', pParams);
  if (vCdEmpresa = 0) then begin
    vCdEmpresa := itemXmlF('CD_EMPRESA', PARAM_GLB);
  end;
  if (itemXml('UF_ORIGEM', pParams) <> '') then begin
    gDsUFOrigem := itemXml('UF_ORIGEM', pParams);
  end else begin
    gDsUFOrigem := itemXml('UF_ORIGEM', PARAM_GLB);
  end;

  gDsUFDestino := itemXml('UF_DESTINO', pParams);
  vCdRegraFiscal := itemXmlF('CD_REGRAFISCAL', pParams);
  gTpOrigemEmissao := itemXmlF('TP_ORIGEMEMISSAO', pParams);
  vCdProduto := itemXmlF('CD_PRODUTO', pParams);
  vCdMPTer := itemXml('CD_MPTER', pParams);
  gCdServico := itemXmlF('CD_SERVICO', pParams);
  vCdOperacao := itemXmlF('CD_OPERACAO', pParams);
  vCdPessoa := itemXmlF('CD_PESSOA', pParams);
  gVlTotalBruto := itemXmlF('VL_TOTALBRUTO', pParams);
  gVlTotalLiquido := itemXmlF('VL_TOTALLIQUIDO', pParams);
  gVlTotalLiquidoICMS := itemXmlF('VL_TOTALLIQUIDO', pParams);
  gPrIPI := itemXmlF('PR_IPI', pParams);
  gVlIPI := itemXmlF('VL_IPI', pParams);
  gVlFrete := itemXmlF('VL_FRETE', pParams);
  gVlSeguro := itemXmlF('VL_SEGURO', pParams);
  gVlDespAcessor := itemXmlF('VL_DESPACESSOR', pParams);
  gPrIcms := itemXmlF('PR_ICMS', pParams);
  gInContribuinte := itemXmlB('IN_CONTRIBUINTE', pParams);
  vCdCST := itemXml('CD_CST', pParams);
  vDsLstCdImposto := itemXml('DS_LST_CD_IMPOSTO', pParams);
  gInProdPropria := FALSE;
  gDtVigenciaIPI := 0;

  if (vCdRegraFiscal = 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN001', 'Regra fiscal nao informada!', cDS_METHOD);
    return(-1); exit;
  end;
  if (vCdOperacao = 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN001', 'Operacao nao informada!', cDS_METHOD);
    return(-1); exit;
  end;

  clear_e(tGER_OPERACAO);
  putitem_o(tGER_OPERACAO, 'CD_OPERACAO', vCdOperacao);
  retrieve_e(tGER_OPERACAO);
  if (xStatus < 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN001', 'Operacao ' + FloatToStr(vCdOperacao) + ' nao cadastrada!', cDS_METHOD);
    return(-1); exit;
  end;
  if (itemB('IN_CALCIMPOSTO', tGER_OPERACAO) <> TRUE) then begin
    return(0); exit;
  end;

  clear_e(tFIS_REGRAFISCAL);
  putitem_o(tFIS_REGRAFISCAL, 'CD_REGRAFISCAL', vCdRegraFiscal);
  retrieve_e(tFIS_REGRAFISCAL);
  if (xStatus < 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN001', 'Regra fiscal ' + FloatToStr(vCdRegraFiscal) + ' nao cadastrada!', cDS_METHOD);
    return(-1); exit;
  end;
  if (vDsLstCdImposto <> '') then begin
    clear_e(tFIS_REGRAIMPOSTO);
    putitem_o(tFIS_REGRAIMPOSTO, 'CD_IMPOSTO', vDsLstCdImposto);
    retrieve_e(tFIS_REGRAIMPOSTO);
    if (xStatus < 0) then begin
      clear_e(tFIS_REGRAIMPOSTO);
    end;
  end;

  if (gCdEmpParam = 0) or (gCdEmpParam <> vCdEmpresa) then begin
    getParam(pParams);
    gCdEmpParam := vCdEmpresa;
  end;

  if (gInContribuinte = False) then begin
    clear_e(tPES_PESSOA);
    putitem_o(tPES_PESSOA, 'CD_PESSOA', vCdPessoa);
    retrieve_e(tPES_PESSOA);
    if (xStatus < 0) then begin
      Result := SetStatus(STS_ERROR, 'GEN001', 'Pessoa nao informada!', cDS_METHOD);
      return(-1); exit;
    end;

    viParams := '';
    putitemXml(viParams, 'CD_PESSOA', vCdPessoa);
    voParams := activateCmp('FCRSVCO057', 'validaPessoaOrgaopublico', viParams);
    if (xStatus < 0) then begin
      Result := voParams; exit;
    end;
    vInOrgaopublico := itemXmlB('IN_ORGAOpublicO', voParams);

    gInPjIsento := FALSE;
    if (PosItem(item('NR_INSCESTL', tPES_PESJURIDICA), 'ISENTO|ISENTA|ISENTOS|ISENTAS') > 0) then begin
      gInPjIsento := TRUE;
    end;
    if (vInOrgaopublico = TRUE) and (gDsUFOrigem = 'DF') then begin
      gInContribuinte := TRUE;
    end else begin
      if (itemB('IN_CNSRFINAL', tPES_CLIENTE) = TRUE) or (item('TP_PESSOA', tPES_PESSOA) = 'F') or (gInPjIsento = TRUE) then begin
        if (itemB('IN_CNSRFINAL', tPES_CLIENTE) = TRUE) and (item('TP_PESSOA', tPES_PESSOA) = 'J') and (gInPjIsento = FALSE) then begin
          gInContribuinte := TRUE;
        end else begin
          if (item('TP_PESSOA', tPES_PESSOA) = 'F') and (((item('NR_CODIGOFISCAL', tPES_CLIENTE) <> '') and (PosItem(gDsUFOrigem, 'PR|SP|RS') > 0))  or (item('NR_INSCPRODRURAL', tPES_PFADIC) <> '')) then begin
            gInContribuinte := TRUE;
          end else begin
            gInContribuinte := FALSE;
          end;
        end;
      end else begin
        gInContribuinte := TRUE;
      end;
    end;
  end;
  if (vCdMPTer <> '') then begin
    clear_e(tCDF_MPTER);
    putitem_o(tCDF_MPTER, 'CD_PESSOA', vCdPessoa);
    putitem_o(tCDF_MPTER, 'CD_MPTER', vCdMPTer);
    retrieve_e(tCDF_MPTER);
    if (xStatus < 0) then begin
      Result := SetStatus(STS_ERROR, 'GEN001', 'Materia-prima ' + vCdMPTer + ' nao cadastrada para a pessoa ' + FloatToStr(vCdPessoa) + '!', cDS_METHOD);
      return(-1); exit;
    end;
  end else if (gCdServico > 0) then begin
    clear_e(tPCP_SERV);
    putitem_o(tPCP_SERV, 'CD_SERVICO', gCdServico);
    retrieve_e(tPCP_SERV);
    if (xStatus < 0) then begin
      Result := SetStatus(STS_ERROR, 'GEN001', 'Servico ' + FloatToStr(gCdServico) + ' nao cadastrado!', cDS_METHOD);
      return(-1); exit;
    end;
  end else if (vCdProduto > 0) then begin
    clear_e(tPRD_PRODUTO);
    putitem_o(tPRD_PRODUTO, 'CD_PRODUTO', vCdProduto);
    retrieve_e(tPRD_PRODUTO);
    if (xStatus < 0) then begin
      Result := SetStatus(STS_ERROR, 'GEN001', 'Produto ' + FloatToStr(vCdProduto) + ' nao cadastrado!', cDS_METHOD);
      return(-1); exit;
    end;
  end;
  if (vCdProduto = 0) and (vCdMPTer = '') and (gCdServico = 0) then begin
    if (gTpOrigemEmissao = 2) then begin
      if (vCdCST <> '') then begin
        gCdCST := SubStr(vCdCST, 1, 1);
      end else begin
        gCdCST := '0';
      end;

    end else begin
      return(0); exit;
    end;

  end else begin

    if (gCdServico > 0) then begin
      gCdCST := '0';
    end else if (vCdMPTer <> '') then begin
      gCdCST := SubStr(item('CD_CST', tCDF_MPTER), 1, 1);
    end else begin
      gCdCST := SubStr(item('CD_CST', tPRD_PRODUTO), 1, 1);

      viParams := '';
      putitemXml(viParams, 'CD_EMPRESA', vCdEmpresa);
      putitemXml(viParams, 'CD_PRODUTO', vCdProduto);
      voParams := activateCmp('PRDSVCO008', 'buscaDadosFilial', viParams);
      if (xStatus < 0) then begin
        Result := voParams; exit;
      end;
      gInProdPropria := itemXmlB('IN_PRODPROPRIA', voParams);
    end;
  end;
  if (item('TP_OPERACAO', tGER_OPERACAO) = 'S') then begin
    if (itemF('TP_MODALIDADE', tGER_OPERACAO) = 3) then begin
      vDsUF := gDsUFOrigem;
      gDsUFOrigem := gDsUFDestino;
      gDsUFDestino := vDsUF;
    end;
  end else begin
    if ((gTpOrigemEmissao = 2) and (itemF('TP_MODALIDADE', tGER_OPERACAO) <> 3))or(gTpOrigemEmissao = 1) then begin
      vDsUF := gDsUFOrigem;
      gDsUFOrigem := gDsUFDestino;
      gDsUFDestino := vDsUF;
    end;
  end;

  gVlICMS := 0;
  clear_e(tFIS_IMPOSTO);

  if (empty(tFIS_REGRAIMPOSTO) = False) then begin
    sort_e(tFIS_REGRAIMPOSTO, 'NR_ORDEM;');
    setocc(tFIS_REGRAIMPOSTO, 1);
    while (xStatus >= 0) do begin

      vCdImposto := itemF('CD_IMPOSTO', tFIS_REGRAIMPOSTO);
      vDtIniVigencia := 0;

      viParams := '';
      putitemXml(viParams, 'CD_IMPOSTO', vCdImposto);
      putitemXml(viParams, 'DT_INIVIGENCIA', itemXml('DT_INIVIGENCIA', pParams));
      voParams := activateCmp('FISSVCO069', 'retornaImposto', viParams);
      if (xStatus < 0) then begin
        Result := voParams; exit;
      end;
      if (voParams <> '') then begin
        vDtIniVigencia := itemXmlD('DT_INIVIGENCIA', voParams);

        creocc(tFIS_IMPOSTO, -1);
        putitem_o(tFIS_IMPOSTO, 'CD_IMPOSTO', vCdImposto);
        putitem_o(tFIS_IMPOSTO, 'DT_INIVIGENCIA', vDtIniVigencia);
        retrieve_o(tFIS_IMPOSTO);
        if (xStatus = -7) then begin
          retrieve_x(tFIS_IMPOSTO);
        end else if (xStatus = 0) then begin
          Result := SetStatus(STS_ERROR, 'GEN001', 'Imposto ' + FloatToStr(vCdImposto) + ' nao cadastrado!', cDS_METHOD);
          return(-1); exit;
        end;

        case round(vCdImposto) of
          1 : begin
            calculaICMS(1);
            if (xStatus < 0) then exit;
          end;
          2 : begin
            calculaICMSSubst(2);
            if (xStatus < 0) then exit;
          end;
          3 : begin
            calculaIPI();
            if (xStatus < 0) then exit;
          end;
          4 : begin
            calculaISS();
            if (xStatus < 0) then exit;
          end;
          5 : begin
            calculaCOFINS();
            if (xStatus < 0) then exit;
          end;
          6 : begin
            calculaPIS();
            if (xStatus < 0) then exit;
          end;
          7 : begin
            calculaPASEP();
            if (xStatus < 0) then exit;
          end;
          10 : begin
            calculaCSLL();
            if (xStatus < 0) then exit;
          end;
          20 : begin
            calculaICMSSubst(20);
            if (xStatus < 0) then exit;
          end;
          30 : begin
            calculaIPI();
            if (xStatus < 0) then exit;
          end;
        end;
      end;
      setocc(tFIS_REGRAIMPOSTO, curocc(tFIS_REGRAIMPOSTO) + 1);
    end;
  end;

  vDsLstImposto := '';
  if (empty(tFIS_IMPOSTO) = False) then begin
    sort_e(tFIS_IMPOSTO, 'CD_IMPOSTO;');
    setocc(tFIS_IMPOSTO, 1);
    while (xStatus >= 0) do begin
      vDsRegistro := '';
      putlistitensocc_e(vDsRegistro, tFIS_IMPOSTO);
      putitem(vDsLstImposto,  vDsRegistro);
      setocc(tFIS_IMPOSTO, curocc(tFIS_IMPOSTO) + 1);
    end;
  end;

  vDsLstImpCalc := '';
  if (empty_e(tFIS_REGRAIMPCALC) = 0) then begin
    sort_e(tFIS_REGRAIMPCALC, 'CD_IMPOSTO');
    setocc(tFIS_REGRAIMPCALC, 1);
    while (xStatus >= 0) do begin
      vDsRegistro := '';
      putlistitensocc(vDsRegistro, tFIS_REGRAIMPCALC);
      putitem(vDsLstImpCalc, vDsRegistro);
      setocc(tFIS_REGRAIMPCALC, curocc(tFIS_REGRAIMPCALC) + 1);
    end;
  end;

  ulength(gCdCST);
  vNrTam := xResult;
  if (vNrTam <= 1) then begin
    gCdCST := gCdCST + '00';
  end;
  if (gInProdPropria = TRUE) then begin
    vCdCFOP := itemF('CD_CFOPPROPRIA', tFIS_REGRAFISCAL);
  end else begin
    vCdCFOP := itemF('CD_CFOPTERCEIRO', tFIS_REGRAFISCAL);
  end;

  Result := '';
  putitemXml(Result, 'CD_CST', gCdCST);
  putitemXml(Result, 'CD_CFOP', vCdCFOP);
  putitemXml(Result, 'DS_LSTIMPOSTO', vDsLstImposto);
  putitemXml(Result, 'DS_LSTIMPCALC', vDsLstImpCalc);

  return(0); exit;
End;

//------------------------------------------------------------------
function T_FISSVCO080.buscaAliquotaInterna(pParams : String) : String;
//------------------------------------------------------------------
const
  cDS_METHOD = 'T_FISSVCO080.buscaAliquotaInterna()';
var
	vCdRegra, vCdRegraAliq, vPrAliquota : Real;
  voParams : String;
begin
  Result := '';

	vPrAliquota := 0;
	vCdRegra := itemXmlF('CD_REGRAFISCAL', pParams);

	if (vCdRegra = 0) then begin
		Result := SetStatus(STS_ERROR, '', 'CÛdigo de regra para busca de alÌquota interna n„o informado!', cDS_METHOD);
		return(STS_ERROR); exit;
	end;

	newInstanceComponente('FISSVCO080', 'FISSVCO080O', 'TRANSACTION=FALSE');
	voParams := activateCmp('FISSVCO080O', 'buscaRegraRelacionada', pParams);
	if (xStatus < 0) then begin
    Result := voParams; Exit;
	end;
	vCdRegraAliq := itemXmlF('CD_REGRAFISCAL', voParams);

	if(vCdRegra <> vCdRegraAliq) then begin
		clear_e(tFIS_REGRAFISCAL);
    putitem_o(tFIS_REGRAFISCAL, 'CD_REGRAFISCAL', vCdRegraAliq);
		retrieve_e(tFIS_REGRAFISCAL);
		if (xStatus >= 0) then begin
			clear_e(tFIS_REGRAIMPOSTO);
      putitem_o(tFIS_REGRAIMPOSTO, 'CD_IMPOSTO', 1);
			retrieve_e(tFIS_REGRAIMPOSTO);
			if (xStatus >= 0) then begin
				vPrAliquota := itemF('PR_ALIQUOTA', tFIS_REGRAIMPOSTO);
			end;
  	end;
 	end;

	putitemXml(Result, 'PR_ALIQUOTA', vPrAliquota);

	return(0); exit;
End;

initialization
  RegisterClass(T_FISSVCO080);

end.
