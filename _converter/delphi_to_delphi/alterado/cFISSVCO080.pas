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
  piCdEmpresa := pParams.CD_EMPRESA;
  if (piCdEmpresa = 0) then begin
    piCdEmpresa := PARAM_GLB.CD_EMPRESA;
  end;

  xParamEmp := '';
  putitem(xParamEmp,  'PR_APLIC_MVA_SUB_TRIB');
  putitem(xParamEmp,  'IN_IMPOSTO_OFFLINE');
  putitem(xParamEmp,  'NATUREZA_COMERCIAL_EMP');
  xParamEmp := cADMSVCO001.Instance.GetParamEmpresa(piCdEmpresa, xParamEmp);

  gPrAplicMvaSubTrib := xParamEmp.PR_APLIC_MVA_SUB_TRIB;
  gInImpostoOffLine := xParamEmp.IN_IMPOSTO_OFFLINE;
  gNaturezaComercialEmp := xParamEmp.NATUREZA_COMERCIAL_EMP;
end;

//---------------------------------------------------------------
function T_FISSVCO080.setEntidade(pParams : String) : String;
//---------------------------------------------------------------
begin
  tCDF_MPTER := TCDF_MPTER.Create(nil);
  tFIS_ALIQUOTAICMSUF := TFIS_ALIQUOTAICMSUF.Create(nil);
  tFIS_IMPOSTO := TFIS_IMPOSTO.Create(nil);
  tFIS_REGRAADIC := TFIS_REGRAADIC.Create(nil);
  tFIS_REGRACOND := TFIS_REGRACOND.Create(nil);
  tFIS_REGRAFISCAL := TFIS_REGRAFISCAL.Create(nil);
  tFIS_REGRAIMPCALC := TFIS_REGRAIMPCALC.Create(nil);
  tFIS_REGRAIMPOSTO := TFIS_REGRAIMPOSTO.Create(nil);
  tFIS_REGRAREL := TFIS_REGRAREL.Create(nil);
  tFIS_TIPI := TFIS_TIPI.Create(nil);
  tFIS_INFOFISCALPRD := TFIS_INFOFISCALPRD.Create(nil);
  tGER_OPERACAO := TGER_OPERACAO.Create(nil);
  tGLB_ESTADO := TGLB_ESTADO.Create(nil);
  tGLB_MUNICIPIO := TGLB_MUNICIPIO.Create(nil);
  tPCP_SERV := TPCP_SERV.Create(nil);
  tPES_CLIENTE := TPES_CLIENTE.Create(nil);
  tPES_PESJURIDICA := TPES_PESJURIDICA.Create(nil);
  tPES_PESFISICA := TPES_PESFISICA.Create(nil);
  tPES_ENDERECO := TPES_ENDERECO.Create(nil);
  tPES_PESSOA := TPES_PESSOA.Create(nil);
  tPES_PFADIC := TPES_PFADIC.Create(nil);
  tPES_PJADIC := TPES_PJADIC.Create(nil);
  tPRD_PRDINFOADIC := TPRD_PRDINFOADIC.Create(nil);
  tPRD_PRDREGRAFISCAL := TPRD_PRDREGRAFISCAL.Create(nil);
  tPRD_PRODUTO := TPRD_PRODUTO.Create(nil);
  tPRD_PRODUTOCLAS := TPRD_PRODUTOCLAS.Create(nil);

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
    fFIS_IMPOSTO.Remover();
    return(0); exit;
  end;

  gCdCST := fFIS_REGRAIMPOSTO.CD_CST;

  if (fFIS_REGRAIMPOSTO.PR_ALIQUOTA <> '') then begin
    fFIS_IMPOSTO.PR_ALIQUOTA := fFIS_REGRAIMPOSTO.PR_ALIQUOTA;
    gVldIcms := fFIS_IMPOSTO.PR_ALIQUOTA;
  end else begin
    fFIS_ALIQUOTAICMSUF.Limpar();
    fFIS_ALIQUOTAICMSUF.CD_UFORIGEM := gDsUFOrigem;
    fFIS_ALIQUOTAICMSUF.CD_UFDESTINO := gDsUFDestino;
    fFIS_ALIQUOTAICMSUF.Listar();
    if (itemXmlF('status', voParams) < 0) then begin
      raise Exception.Create('Nenhuma aliquota cadastada de ' + fFIS_ALIQUOTAICMSUF.CD_UFORIGEM + ' para ' + item('CD_UFDESTINO' + ' / ' := tFIS_ALIQUOTAICMSUF) + '!', cDS_METHOD);
      
    end;
    fFIS_IMPOSTO.PR_ALIQUOTA := fFIS_ALIQUOTAICMSUF.PR_ALIQICMS;
  end;

  fFIS_IMPOSTO.VL_OUTRO := 0;
  fFIS_IMPOSTO.VL_ISENTO := 0;
  fFIS_IMPOSTO.PR_REDUBASE := 0;
  fFIS_IMPOSTO.PR_BASECALC := 100;

  calculaBaseCalc();

  if (fFIS_REGRAIMPOSTO.PR_REDUBASE > 0) then begin
    fFIS_IMPOSTO.PR_REDUBASE := fFIS_REGRAIMPOSTO.PR_REDUBASE;
    fFIS_IMPOSTO.PR_BASECALC := 100 - fFIS_REGRAIMPOSTO.PR_REDUBASE;

    vVlCalc := fFIS_IMPOSTO.VL_BASECALC - (fFIS_IMPOSTO.VL_BASECALC * itemF('PR_REDUBASE', tFIS_IMPOSTO) / 100);

    fFIS_IMPOSTO.VL_BASECALC := rounded(vVlCalc, 6);
  end;
  if (fFIS_REGRAIMPOSTO.PR_REDUIMP > 0) then begin
    vVlCalc := (fFIS_IMPOSTO.VL_BASECALC * ((100 - itemF('PR_REDUIMP', tFIS_REGRAIMPOSTO))/100) * itemF('PR_ALIQUOTA', tFIS_IMPOSTO)) / 100;
    fFIS_IMPOSTO.VL_IMPOSTO := rounded(vVlCalc, 6);
    gVlICMS := fFIS_IMPOSTO.VL_IMPOSTO;
  end else begin
    vVlCalc := fFIS_IMPOSTO.VL_BASECALC * itemF('PR_ALIQUOTA', tFIS_IMPOSTO) / 100;
    fFIS_IMPOSTO.VL_IMPOSTO := rounded(vVlCalc, 6);
    gVlICMS := fFIS_IMPOSTO.VL_IMPOSTO;

    if (fFIS_REGRAIMPOSTO.IN_OUTRO = TRUE) then begin
      if (fFIS_REGRAIMPOSTO.PR_REDUBASE > 0) then begin
        fFIS_IMPOSTO.VL_OUTRO := gVlTotalLiquidoICMS - fFIS_IMPOSTO.VL_BASECALC;
      end else begin
        fFIS_IMPOSTO.VL_OUTRO := fFIS_IMPOSTO.VL_BASECALC;
        fFIS_IMPOSTO.VL_ISENTO := 0;
        fFIS_IMPOSTO.VL_IMPOSTO := 0;
        fFIS_IMPOSTO.VL_BASECALC := 0;
        fFIS_IMPOSTO.PR_BASECALC := 0;
        fFIS_IMPOSTO.PR_REDUBASE := 0;
        fFIS_IMPOSTO.PR_ALIQUOTA := 0;
      end;
    end else if (fFIS_REGRAIMPOSTO.IN_ISENTO = TRUE) then begin
      if (fFIS_REGRAIMPOSTO.PR_REDUBASE > 0) then begin
        fFIS_IMPOSTO.VL_ISENTO := gVlTotalLiquidoICMS - fFIS_IMPOSTO.VL_BASECALC;
      end else begin
        fFIS_IMPOSTO.VL_ISENTO := fFIS_IMPOSTO.VL_BASECALC;
        fFIS_IMPOSTO.VL_OUTRO := 0;
        fFIS_IMPOSTO.VL_IMPOSTO := 0;
        fFIS_IMPOSTO.VL_BASECALC := 0;
        fFIS_IMPOSTO.PR_BASECALC := 0;
        fFIS_IMPOSTO.PR_REDUBASE := 0;
        fFIS_IMPOSTO.PR_ALIQUOTA := 0;
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
    fFIS_IMPOSTO.Remover();
    return(0); exit;
  end;

  Length(gCdCST);
  vNrTam := xResult;
  if (vNrTam <= 1) then begin
    gCdCST := fFIS_REGRAIMPOSTO.CD_CST;
  end;

  vInReducaoMVA := FALSE;

  calculaBaseCalc();

  vVlBaseCalc := rounded(fFIS_IMPOSTO.VL_BASECALC, 6);

  if (fFIS_REGRAIMPOSTO.TP_CALCICMSST = '') then begin
    If (fFIS_REGRAIMPOSTO.IN_OUTRO = TRUE) then begin
      fFIS_IMPOSTO.VL_OUTRO := vVlBaseCalc;
      fFIS_IMPOSTO.VL_ISENTO := 0;
      fFIS_IMPOSTO.VL_IMPOSTO := 0;
      fFIS_IMPOSTO.VL_BASECALC := 0;
      fFIS_IMPOSTO.PR_BASECALC := 0;
      fFIS_IMPOSTO.PR_REDUBASE := 0;
      fFIS_IMPOSTO.PR_ALIQUOTA := 0;

    end else if (fFIS_REGRAIMPOSTO.IN_ISENTO = TRUE) then begin
      fFIS_IMPOSTO.VL_ISENTO := vVlBaseCalc;
      fFIS_IMPOSTO.VL_OUTRO := 0;
      fFIS_IMPOSTO.VL_IMPOSTO := 0;
      fFIS_IMPOSTO.VL_BASECALC := 0;
      fFIS_IMPOSTO.PR_BASECALC := 0;
      fFIS_IMPOSTO.PR_REDUBASE := 0;
      fFIS_IMPOSTO.PR_ALIQUOTA := 0;

    end else begin
      if (fFIS_REGRAIMPOSTO.PR_ALIQUOTA <> '') then begin
        fFIS_IMPOSTO.PR_ALIQUOTA := fFIS_REGRAIMPOSTO.PR_ALIQUOTA;
      end else begin
        fFIS_ALIQUOTAICMSUF.Limpar();
        fFIS_ALIQUOTAICMSUF.CD_UFORIGEM := gDsUFOrigem;
        fFIS_ALIQUOTAICMSUF.CD_UFDESTINO := gDsUFDestino;
        fFIS_ALIQUOTAICMSUF.Listar();
        if (itemXmlF('status', voParams) < 0) then begin
          raise Exception.Create('Nenhuma aliquota cadastada de ' + fFIS_ALIQUOTAICMSUF.CD_UFORIGEM + ' para ' + item('CD_UFDESTINO' + ' / ' := tFIS_ALIQUOTAICMSUF) + '!', cDS_METHOD);
          
        end;
        fFIS_IMPOSTO.PR_ALIQUOTA := fFIS_ALIQUOTAICMSUF.PR_ALIQICMS;
      end;

      viParams := '';
      viParams.CD_PRODUTO := fPRD_PRODUTO.CD_PRODUTO;
      viParams.UF_ORIGEM := gDsUFOrigem;
      viParams.UF_DESTINO := gDsUFDestino;
      viParams.TP_OPERACAO := fGER_OPERACAO.TP_OPERACAO;
      voParams := cFISSVCO035.Instance.buscaDadosFiscalProduto(viParams);
      if (itemXmlF('status', voParams) < 0) then begin
        raise Exception.Create(itemXml('message', voParams)); exit;
      end;
      vPrIVA := 0;

      if (fFIS_REGRAIMPOSTO.PR_MVAICMSST <> '') then begin
        vPrIvaPrd := fFIS_REGRAIMPOSTO.PR_MVAICMSST;
      end else begin
        vPrIvaPrd := voParams.PR_SUBSTRIB;
      end;
      vPrAliqIntra := voParams.PR_ICMS;
      vTpIva := voParams.TP_IVA;

      if (vPrIvaPrd > 0) then begin
        vPrIVA := vPrIvaPrd;
      end;
      if (vPrAliqIntra > 0) then begin
        fFIS_IMPOSTO.PR_ALIQUOTA := vPrAliqIntra;
      end;
      if (fFIS_REGRAIMPOSTO.IN_DIFALIQ = TRUE) then begin
        fFIS_ALIQUOTAICMSUF.Limpar();
        fFIS_ALIQUOTAICMSUF.CD_UFORIGEM := gDsUFDestino;
        fFIS_ALIQUOTAICMSUF.CD_UFDESTINO := gDsUFDestino;
        fFIS_ALIQUOTAICMSUF.Listar();
        if (itemXmlF('status', voParams) < 0) then begin
          raise Exception.Create('Nenhuma aliquota cadastrada de ' + fFIS_ALIQUOTAICMSUF.CD_UFORIGEM + ' para ' + item('CD_UFDESTINO' + ' / ' := tFIS_ALIQUOTAICMSUF) + '!', cDS_METHOD);
          
        end;
        vPrAliqDestino := fFIS_ALIQUOTAICMSUF.PR_ALIQICMS;

        fFIS_ALIQUOTAICMSUF.Limpar();
        fFIS_ALIQUOTAICMSUF.CD_UFORIGEM := gDsUFOrigem;
        fFIS_ALIQUOTAICMSUF.CD_UFDESTINO := gDsUFOrigem;
        fFIS_ALIQUOTAICMSUF.Listar();
        if (itemXmlF('status', voParams) < 0) then begin
          raise Exception.Create('Nenhuma aliquota cadastrada de ' + fFIS_ALIQUOTAICMSUF.CD_UFORIGEM + ' para ' + item('CD_UFDESTINO' + ' / ' := tFIS_ALIQUOTAICMSUF) + '!', cDS_METHOD);
          
        end;
        vPrAliqOrigem := fFIS_ALIQUOTAICMSUF.PR_ALIQICMS;

        if (fFIS_REGRAIMPOSTO.PR_ALIQUOTA > 0) then begin
          vPrAliqOrigem := fFIS_REGRAIMPOSTO.PR_ALIQUOTA;
        end;

        vPrIVA := 0;
        fFIS_IMPOSTO.PR_ALIQUOTA := (vPrAliqOrigem - vPrAliqDestino);

      end else begin
        if (vTpIva <> 1) then begin
          if (gVldIcms <> 0) then begin
            vPrAliqInter := gVldIcms;
          end else begin
            fFIS_ALIQUOTAICMSUF.Limpar();
            fFIS_ALIQUOTAICMSUF.CD_UFORIGEM := gDsUFOrigem;
            fFIS_ALIQUOTAICMSUF.CD_UFDESTINO := gDsUFDestino;
            fFIS_ALIQUOTAICMSUF.Listar();
            if (itemXmlF('status', voParams) < 0) then begin
              raise Exception.Create('Nenhuma aliquota cadastrada de ' + fFIS_ALIQUOTAICMSUF.CD_UFORIGEM + ' para ' + item('CD_UFDESTINO' + ' / ' := tFIS_ALIQUOTAICMSUF) + '!', cDS_METHOD);
              
            end;
            vPrAliqInter := fFIS_ALIQUOTAICMSUF.PR_ALIQICMS;
          end;
          if (vPrAliqIntra = 0) then begin
            fFIS_ALIQUOTAICMSUF.Limpar();
            fFIS_ALIQUOTAICMSUF.CD_UFORIGEM := gDsUFDestino;
            fFIS_ALIQUOTAICMSUF.CD_UFDESTINO := gDsUFDestino;
            fFIS_ALIQUOTAICMSUF.Listar();
            if (itemXmlF('status', voParams) < 0) then begin
              raise Exception.Create('Nenhuma aliquota cadastrada de ' + fFIS_ALIQUOTAICMSUF.CD_UFORIGEM + ' para ' + item('CD_UFDESTINO' + ' / ' := tFIS_ALIQUOTAICMSUF) + '!', cDS_METHOD);
              
            end;
            vPrAliqIntra := fFIS_ALIQUOTAICMSUF.PR_ALIQICMS;
          end;
          if (fFIS_REGRAIMPOSTO.IN_AJSIMPLES = TRUE) then begin
            if (vPrIVA = 0) then begin
              vPrIva := vPrIvaPrd;
            end;
            if (fFIS_REGRAIMPOSTO.PR_AJSIMPLES <> '') then begin
              vPrIVA := (vPrIVA * fFIS_REGRAIMPOSTO.PR_AJSIMPLES)/100;
            end else begin
              vPrIVA := (vPrIVA * gPrAplicMvaSubTrib)/100;
            end;
            vInReducaoMVA := TRUE;
          end;

          vPrIVA := ((1 + (vPrIVA/100)) * ((1 - (vPrAliqInter/100)) / (1 - (vPrAliqIntra/100))) -1) * 100;
        end;
      end;
      if (fFIS_REGRAIMPOSTO.IN_AJSIMPLES = TRUE) and (vInReducaoMVA <> TRUE) then begin
        if (vPrIVA = 0) then begin
          vPrIva := vPrIvaPrd;
        end;
        vPrIVA := (vPrIVA * gPrAplicMvaSubTrib)/100;
      end;

      vVlBaseCalc := vVlBaseCalc + ((vVlBaseCalc * vPrIVA) / 100);
      vVlBaseCalc := rounded(vVlBaseCalc, 6);

      fFIS_IMPOSTO.VL_OUTRO := 0;
      fFIS_IMPOSTO.VL_ISENTO := 0;
      fFIS_IMPOSTO.PR_REDUBASE := 0;
      fFIS_IMPOSTO.PR_BASECALC := 100;
      fFIS_IMPOSTO.VL_BASECALC := vVlBaseCalc;

      vVlICMS := fFIS_IMPOSTO.VL_BASECALC * itemF('PR_ALIQUOTA', tFIS_IMPOSTO) / 100;
      vVlICMS := rounded(vVlICMS, 6);

      if (vVlICMS > gVlICMS) then begin
        fFIS_IMPOSTO.VL_IMPOSTO := vVlICMS - gVlICMS;
      end else begin
        fFIS_IMPOSTO.VL_IMPOSTO := vVlICMS;
      end;
    end;
  end else if (fFIS_REGRAIMPOSTO.TP_CALCICMSST = 1) then begin
    if (fFIS_REGRAIMPOSTO.IN_OUTRO = TRUE) or (itemB('IN_ISENTO', tFIS_REGRAIMPOSTO) = TRUE) then begin
      if (fFIS_REGRAIMPOSTO.IN_OUTRO = TRUE) then begin
        fFIS_IMPOSTO.VL_OUTRO := vVlBaseCalc;
        fFIS_IMPOSTO.VL_ISENTO := 0;
      end else if (fFIS_REGRAIMPOSTO.IN_ISENTO = TRUE) then begin
        fFIS_IMPOSTO.VL_ISENTO := vVlBaseCalc;
        fFIS_IMPOSTO.VL_OUTRO := 0;
      end;
      fFIS_IMPOSTO.VL_IMPOSTO := 0;
      fFIS_IMPOSTO.VL_BASECALC := 0;
      fFIS_IMPOSTO.PR_BASECALC := 0;
      fFIS_IMPOSTO.PR_REDUBASE := 0;
      fFIS_IMPOSTO.PR_ALIQUOTA := 0;
    end else begin
      fFIS_ALIQUOTAICMSUF.Limpar();
      fFIS_ALIQUOTAICMSUF.CD_UFORIGEM := gDsUFDestino;
      fFIS_ALIQUOTAICMSUF.CD_UFDESTINO := gDsUFDestino;
      fFIS_ALIQUOTAICMSUF.Listar();
      if (itemXmlF('status', voParams) < 0) then begin
        raise Exception.Create('Nenhuma aliquota cadastrada de ' + fFIS_ALIQUOTAICMSUF.CD_UFORIGEM + ' para ' + item('CD_UFDESTINO' + ' / ' := tFIS_ALIQUOTAICMSUF) + '!', cDS_METHOD);
        
      end;
      vPrAliqIntra := fFIS_ALIQUOTAICMSUF.PR_ALIQICMS;

      fFIS_IMPOSTO.VL_IMPOSTO := vVlBaseCalc * (fFIS_REGRAIMPOSTO.PR_CNAEICMSST/100);
      fFIS_IMPOSTO.VL_BASECALC := (gVlICMS + fFIS_IMPOSTO.VL_IMPOSTO)/(vPrAliqIntra/100);
      fFIS_IMPOSTO.PR_ALIQUOTA := fFIS_REGRAIMPOSTO.PR_CNAEICMSST;
      fFIS_IMPOSTO.PR_BASECALC := 100;
      fFIS_IMPOSTO.VL_ISENTO := 0;
      fFIS_IMPOSTO.VL_OUTRO := 0;
      fFIS_IMPOSTO.PR_REDUBASE := 0;
    end;
  end else if (fFIS_REGRAIMPOSTO.TP_CALCICMSST = 2) then begin
    if (fFIS_REGRAIMPOSTO.IN_OUTRO = TRUE) or (itemB('IN_ISENTO', tFIS_REGRAIMPOSTO) = TRUE) then begin
      If (fFIS_REGRAIMPOSTO.IN_OUTRO = TRUE) then begin
        fFIS_IMPOSTO.VL_OUTRO := vVlBaseCalc;
        fFIS_IMPOSTO.VL_ISENTO := 0;
      end else if (fFIS_REGRAIMPOSTO.IN_ISENTO = TRUE) then begin
        fFIS_IMPOSTO.VL_ISENTO := vVlBaseCalc;
        fFIS_IMPOSTO.VL_OUTRO := 0;
      end;
      fFIS_IMPOSTO.VL_IMPOSTO := 0;
      fFIS_IMPOSTO.VL_BASECALC := 0;
      fFIS_IMPOSTO.PR_BASECALC := 0;
      fFIS_IMPOSTO.PR_REDUBASE := 0;
      fFIS_IMPOSTO.PR_ALIQUOTA := 0;
    end else begin
      fFIS_ALIQUOTAICMSUF.Limpar();
      fFIS_ALIQUOTAICMSUF.CD_UFORIGEM := gDsUFDestino;
      fFIS_ALIQUOTAICMSUF.CD_UFDESTINO := gDsUFDestino;
      fFIS_ALIQUOTAICMSUF.Listar();
      if (itemXmlF('status', voParams) < 0) then begin
        raise Exception.Create('Nenhuma aliquota cadastrada de ' + fFIS_ALIQUOTAICMSUF.CD_UFORIGEM + ' para ' + item('CD_UFDESTINO' + ' / ' := tFIS_ALIQUOTAICMSUF) + '!', cDS_METHOD);
        
      end;
      vPrAliqIntra := fFIS_ALIQUOTAICMSUF.PR_ALIQICMS;

      fFIS_ALIQUOTAICMSUF.Limpar();
      fFIS_ALIQUOTAICMSUF.CD_UFORIGEM := gDsUFOrigem;
      fFIS_ALIQUOTAICMSUF.CD_UFDESTINO := gDsUFDestino;
      fFIS_ALIQUOTAICMSUF.Listar();
      if (itemXmlF('status', voParams) < 0) then begin
        raise Exception.Create('Nenhuma aliquota cadastrada de ' + fFIS_ALIQUOTAICMSUF.CD_UFORIGEM + ' para ' + item('CD_UFDESTINO' + ' / ' := tFIS_ALIQUOTAICMSUF) + '!', cDS_METHOD);
        
      end;
      vPrAliqInter := fFIS_ALIQUOTAICMSUF.PR_ALIQICMS;

      vPrAux := (vPrAliqIntra - vPrAliqInter);
      if (vPrAux < 0) then begin
        vPrAux := vPrAux * -1;
      end;

      fFIS_IMPOSTO.VL_IMPOSTO := vVlBaseCalc * (vPrAux/100);
      fFIS_IMPOSTO.VL_BASECALC := vVlBaseCalc;
      fFIS_IMPOSTO.PR_ALIQUOTA := vPrAux;
      fFIS_IMPOSTO.PR_BASECALC := 100;
      fFIS_IMPOSTO.VL_ISENTO := 0;
      fFIS_IMPOSTO.VL_OUTRO := 0;
      fFIS_IMPOSTO.PR_REDUBASE := 0;
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
  if (fFIS_IMPOSTO.CD_IMPOSTO = 30) then begin
    if (gDtVigenciaIPI = 0) then begin
      gDtVigenciaIPI := fFIS_IMPOSTO.DT_INIVIGENCIA;
    end;

    fFIS_IMPOSTO.Remover();

    if (gPrIPI > 0) then begin
      return(0); exit;
    end;

    fFIS_IMPOSTO.Append();
    fFIS_IMPOSTO.CD_IMPOSTO := 3;
    fFIS_IMPOSTO.DT_INIVIGENCIA := gDtVigenciaIPI;
    fFIS_IMPOSTO.Consultar();
    if (xStatus = -7) then begin
      fFIS_IMPOSTO.Consultar();
    end else if (xStatus = 0) then begin
      raise Exception.Create('Imposto ' + fFIS_IMPOSTO.CD_IMPOSTO + ' nao cadastrado!' + ' / ' := cDS_METHOD);
      
    end;
  end else begin
    gDtVigenciaIPI := fFIS_IMPOSTO.DT_INIVIGENCIA;
  end;

  fFIS_IMPOSTO.CD_CST := fFIS_REGRAIMPOSTO.CD_CST;

  calculaBaseCalc();

  if (fFIS_REGRAIMPOSTO.IN_OUTRO = TRUE) then begin
    fFIS_IMPOSTO.VL_OUTRO := fFIS_IMPOSTO.VL_BASECALC;
    fFIS_IMPOSTO.VL_ISENTO := 0;
    fFIS_IMPOSTO.VL_IMPOSTO := 0;
    fFIS_IMPOSTO.VL_BASECALC := 0;
    fFIS_IMPOSTO.PR_BASECALC := 0;
    fFIS_IMPOSTO.PR_REDUBASE := 0;
    fFIS_IMPOSTO.PR_ALIQUOTA := 0;

  end else if (fFIS_REGRAIMPOSTO.IN_ISENTO = TRUE) then begin
    fFIS_IMPOSTO.VL_ISENTO := fFIS_IMPOSTO.VL_BASECALC;
    fFIS_IMPOSTO.VL_OUTRO := 0;
    fFIS_IMPOSTO.VL_IMPOSTO := 0;
    fFIS_IMPOSTO.VL_BASECALC := 0;
    fFIS_IMPOSTO.PR_BASECALC := 0;
    fFIS_IMPOSTO.PR_REDUBASE := 0;
    fFIS_IMPOSTO.PR_ALIQUOTA := 0;

  end else begin
    fFIS_IMPOSTO.PR_BASECALC := 100;

    if (gTpOrigemEmissao = 1) then begin
      if (fFIS_REGRAIMPOSTO.PR_ALIQUOTA <> '') then begin
        fFIS_IMPOSTO.PR_ALIQUOTA := fFIS_REGRAIMPOSTO.PR_ALIQUOTA;
      end else if (gPrIPI <> 0) then begin
        fFIS_IMPOSTO.PR_ALIQUOTA := gPrIPI;
      end else begin
        fFIS_IMPOSTO.PR_ALIQUOTA := fFIS_TIPI.PR_IPI;
      end;
      vVlCalc := fFIS_IMPOSTO.VL_BASECALC * itemF('PR_ALIQUOTA', tFIS_IMPOSTO) / 100;
      fFIS_IMPOSTO.VL_IMPOSTO := rounded(vVlCalc, 2);

    end else begin
      if (gVlIPI = 0) then begin
        if (gPrIPI <> 0) then begin
          fFIS_IMPOSTO.PR_ALIQUOTA := gPrIPI;
        end;
        vVlCalc := fFIS_IMPOSTO.VL_BASECALC * itemF('PR_ALIQUOTA', tFIS_IMPOSTO) / 100;
        fFIS_IMPOSTO.VL_IMPOSTO := rounded(vVlCalc, 2);
      end else begin
        fFIS_IMPOSTO.PR_ALIQUOTA := gPrIPI;
        fFIS_IMPOSTO.VL_IMPOSTO := gVlIPI;
      end;
    end;
  end;
  if (gInImpostoOffLine = TRUE) then begin
    fFIS_IMPOSTO.VL_BASECALC := 0;
    fFIS_IMPOSTO.VL_IMPOSTO := 0;
  end;

  gPrIPI := fFIS_IMPOSTO.PR_ALIQUOTA;
  gVlIPI := fFIS_IMPOSTO.VL_IMPOSTO;

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
    fFIS_IMPOSTO.Remover();
    return(0); exit;
  end;

  calculaBaseCalc();

  if (fFIS_REGRAIMPOSTO.IN_OUTRO = TRUE) then begin
    fFIS_IMPOSTO.VL_OUTRO := fFIS_IMPOSTO.VL_BASECALC;
    fFIS_IMPOSTO.VL_ISENTO := 0;
    fFIS_IMPOSTO.VL_IMPOSTO := 0;
    fFIS_IMPOSTO.VL_BASECALC := 0;
    fFIS_IMPOSTO.PR_BASECALC := 0;
    fFIS_IMPOSTO.PR_REDUBASE := 0;
    fFIS_IMPOSTO.PR_ALIQUOTA := 0;

  end else if (fFIS_REGRAIMPOSTO.IN_ISENTO = TRUE) then begin
    fFIS_IMPOSTO.VL_ISENTO := fFIS_IMPOSTO.VL_BASECALC;
    fFIS_IMPOSTO.VL_OUTRO := 0;
    fFIS_IMPOSTO.VL_IMPOSTO := 0;
    fFIS_IMPOSTO.VL_BASECALC := 0;
    fFIS_IMPOSTO.PR_BASECALC := 0;
    fFIS_IMPOSTO.PR_REDUBASE := 0;
    fFIS_IMPOSTO.PR_ALIQUOTA := 0;

  end else begin
    if (fFIS_REGRAIMPOSTO.PR_ALIQUOTA <> '') then begin
      fFIS_IMPOSTO.PR_ALIQUOTA := fFIS_REGRAIMPOSTO.PR_ALIQUOTA;
    end;
    fFIS_IMPOSTO.PR_BASECALC := 100;

    vVlCalc := fFIS_IMPOSTO.VL_BASECALC * itemF('PR_ALIQUOTA', tFIS_IMPOSTO) / 100;
    fFIS_IMPOSTO.VL_IMPOSTO := rounded(vVlCalc, 6);
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
    fFIS_IMPOSTO.Remover();
    return(0); exit;
  end;

  fFIS_IMPOSTO.CD_CST := fFIS_REGRAIMPOSTO.CD_CST;

  calculaBaseCalc();

  if (fFIS_REGRAIMPOSTO.IN_OUTRO = TRUE) then begin
    fFIS_IMPOSTO.VL_OUTRO := fFIS_IMPOSTO.VL_BASECALC;
    fFIS_IMPOSTO.VL_ISENTO := 0;
    fFIS_IMPOSTO.VL_IMPOSTO := 0;
    fFIS_IMPOSTO.VL_BASECALC := 0;
    fFIS_IMPOSTO.PR_BASECALC := 0;
    fFIS_IMPOSTO.PR_REDUBASE := 0;
    fFIS_IMPOSTO.PR_ALIQUOTA := 0;

  end else if (fFIS_REGRAIMPOSTO.IN_ISENTO = TRUE) then begin
    fFIS_IMPOSTO.VL_ISENTO := fFIS_IMPOSTO.VL_BASECALC;
    fFIS_IMPOSTO.VL_OUTRO := 0;
    fFIS_IMPOSTO.VL_IMPOSTO := 0;
    fFIS_IMPOSTO.VL_BASECALC := 0;
    fFIS_IMPOSTO.PR_BASECALC := 0;
    fFIS_IMPOSTO.PR_REDUBASE := 0;
    fFIS_IMPOSTO.PR_ALIQUOTA := 0;

  end else begin
    if (fFIS_REGRAIMPOSTO.PR_ALIQUOTA <> '') then begin
      fFIS_IMPOSTO.PR_ALIQUOTA := fFIS_REGRAIMPOSTO.PR_ALIQUOTA;
    end;
    fFIS_IMPOSTO.PR_BASECALC := 100;

    vVlCalc := fFIS_IMPOSTO.VL_BASECALC * itemF('PR_ALIQUOTA', tFIS_IMPOSTO) / 100;
    fFIS_IMPOSTO.VL_IMPOSTO := rounded(vVlCalc, 6);
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
    fFIS_IMPOSTO.Remover();
    return(0); exit;
  end;

  fFIS_IMPOSTO.CD_CST := fFIS_REGRAIMPOSTO.CD_CST;

  calculaBaseCalc();

  if (fFIS_REGRAIMPOSTO.IN_OUTRO = TRUE) then begin
    fFIS_IMPOSTO.VL_OUTRO := fFIS_IMPOSTO.VL_BASECALC;
    fFIS_IMPOSTO.VL_ISENTO := 0;
    fFIS_IMPOSTO.VL_IMPOSTO := 0;
    fFIS_IMPOSTO.VL_BASECALC := 0;
    fFIS_IMPOSTO.PR_BASECALC := 0;
    fFIS_IMPOSTO.PR_REDUBASE := 0;
    fFIS_IMPOSTO.PR_ALIQUOTA := 0;

  end else if (fFIS_REGRAIMPOSTO.IN_ISENTO = TRUE) then begin
    fFIS_IMPOSTO.VL_ISENTO := fFIS_IMPOSTO.VL_BASECALC;
    fFIS_IMPOSTO.VL_OUTRO := 0;
    fFIS_IMPOSTO.VL_IMPOSTO := 0;
    fFIS_IMPOSTO.VL_BASECALC := 0;
    fFIS_IMPOSTO.PR_BASECALC := 0;
    fFIS_IMPOSTO.PR_REDUBASE := 0;
    fFIS_IMPOSTO.PR_ALIQUOTA := 0;

  end else begin
    if (fFIS_REGRAIMPOSTO.PR_ALIQUOTA <> '') then begin
      fFIS_IMPOSTO.PR_ALIQUOTA := fFIS_REGRAIMPOSTO.PR_ALIQUOTA;
    end;
    fFIS_IMPOSTO.PR_BASECALC := 100;

    vVlCalc := fFIS_IMPOSTO.VL_BASECALC * itemF('PR_ALIQUOTA', tFIS_IMPOSTO) / 100;
    fFIS_IMPOSTO.VL_IMPOSTO := rounded(vVlCalc, 6);
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
    fFIS_IMPOSTO.Remover();
    return(0); exit;
  end;

  calculaBaseCalc();

  if (fFIS_REGRAIMPOSTO.IN_OUTRO = TRUE) then begin
    fFIS_IMPOSTO.VL_OUTRO := fFIS_IMPOSTO.VL_BASECALC;
    fFIS_IMPOSTO.VL_ISENTO := 0;
    fFIS_IMPOSTO.VL_IMPOSTO := 0;
    fFIS_IMPOSTO.VL_BASECALC := 0;
    fFIS_IMPOSTO.PR_BASECALC := 0;
    fFIS_IMPOSTO.PR_REDUBASE := 0;
    fFIS_IMPOSTO.PR_ALIQUOTA := 0;

  end else if (fFIS_REGRAIMPOSTO.IN_ISENTO = TRUE) then begin
    fFIS_IMPOSTO.VL_ISENTO := fFIS_IMPOSTO.VL_BASECALC;
    fFIS_IMPOSTO.VL_OUTRO := 0;
    fFIS_IMPOSTO.VL_IMPOSTO := 0;
    fFIS_IMPOSTO.VL_BASECALC := 0;
    fFIS_IMPOSTO.PR_BASECALC := 0;
    fFIS_IMPOSTO.PR_REDUBASE := 0;
    fFIS_IMPOSTO.PR_ALIQUOTA := 0;

  end else begin
    if (fFIS_REGRAIMPOSTO.PR_ALIQUOTA <> '') then begin
      fFIS_IMPOSTO.PR_ALIQUOTA := fFIS_REGRAIMPOSTO.PR_ALIQUOTA;
    end;
    fFIS_IMPOSTO.PR_BASECALC := 100;

    vVlCalc := fFIS_IMPOSTO.VL_BASECALC * itemF('PR_ALIQUOTA', tFIS_IMPOSTO) / 100;
    fFIS_IMPOSTO.VL_IMPOSTO := rounded(vVlCalc, 6);
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
    fFIS_IMPOSTO.Remover();
    return(0); exit;
  end;

  calculaBaseCalc();

  if (fFIS_REGRAIMPOSTO.IN_OUTRO = TRUE) then begin
    fFIS_IMPOSTO.VL_OUTRO := fFIS_IMPOSTO.VL_BASECALC;
    fFIS_IMPOSTO.VL_ISENTO := 0;
    fFIS_IMPOSTO.VL_IMPOSTO := 0;
    fFIS_IMPOSTO.VL_BASECALC := 0;
    fFIS_IMPOSTO.PR_BASECALC := 0;
    fFIS_IMPOSTO.PR_REDUBASE := 0;
    fFIS_IMPOSTO.PR_ALIQUOTA := 0;

  end else if (fFIS_REGRAIMPOSTO.IN_ISENTO = TRUE) then begin
    fFIS_IMPOSTO.VL_ISENTO := fFIS_IMPOSTO.VL_BASECALC;
    fFIS_IMPOSTO.VL_OUTRO := 0;
    fFIS_IMPOSTO.VL_IMPOSTO := 0;
    fFIS_IMPOSTO.VL_BASECALC := 0;
    fFIS_IMPOSTO.PR_BASECALC := 0;
    fFIS_IMPOSTO.PR_REDUBASE := 0;
    fFIS_IMPOSTO.PR_ALIQUOTA := 0;

  end else begin
    if (fFIS_REGRAIMPOSTO.PR_ALIQUOTA <> '') then begin
      fFIS_IMPOSTO.PR_ALIQUOTA := fFIS_REGRAIMPOSTO.PR_ALIQUOTA;
    end;
    fFIS_IMPOSTO.PR_BASECALC := 100;

    vVlCalc := fFIS_IMPOSTO.VL_BASECALC * itemF('PR_ALIQUOTA', tFIS_IMPOSTO) / 100;
    fFIS_IMPOSTO.VL_IMPOSTO := rounded(vVlCalc, 6);
  end;

  return(0); exit;
End;

//--------------------------------------------------------------------------------------------
function T_FISSVCO080.calculaBaseCalc() : String;
//--------------------------------------------------------------------------------------------
const
  cDS_METHOD = 'T_FISSVCO080.calculaBaseCalc()';
begin
  if (fFIS_REGRAIMPOSTO.TP_COMPOSICAOBC = 1) then begin
    fFIS_IMPOSTO.VL_BASECALC := gVlTotalLiquido + gVlFrete + gVlSeguro + gVlDespAcessor;
  end else if (fFIS_REGRAIMPOSTO.TP_COMPOSICAOBC = 2) then begin
    fFIS_IMPOSTO.VL_BASECALC := gVlTotalLiquido;
  end else if (fFIS_REGRAIMPOSTO.TP_COMPOSICAOBC = 3) then begin
    fFIS_IMPOSTO.VL_BASECALC := gVlTotalLiquido + gVlFrete + gVlSeguro + gVlDespAcessor + gVlIpi;
  end else if (fFIS_REGRAIMPOSTO.TP_COMPOSICAOBC = 4) then begin
    fFIS_IMPOSTO.VL_BASECALC := gVlTotalLiquido + gVlSeguro + gVlDespAcessor + gVlIpi;
  end else if (fFIS_REGRAIMPOSTO.TP_COMPOSICAOBC = 5) then begin
    fFIS_IMPOSTO.VL_BASECALC := gVlTotalLiquido + gVlDespAcessor + gVlIpi;
  end else if (fFIS_REGRAIMPOSTO.TP_COMPOSICAOBC = 6) then begin
    fFIS_IMPOSTO.VL_BASECALC := gVlTotalLiquido + gVlIpi;
  end else if (fFIS_REGRAIMPOSTO.TP_COMPOSICAOBC = 7) then begin
    fFIS_IMPOSTO.VL_BASECALC := gVlTotalLiquido + gVlSeguro + gVlDespAcessor;
  end else if (fFIS_REGRAIMPOSTO.TP_COMPOSICAOBC = 8) then begin
    fFIS_IMPOSTO.VL_BASECALC := gVlTotalLiquido + gVlDespAcessor;
  end else if (fFIS_REGRAIMPOSTO.TP_COMPOSICAOBC = 9) then begin
    fFIS_IMPOSTO.VL_BASECALC := gVlTotalBruto + gVlSeguro + gVlDespAcessor;
  end else if (fFIS_REGRAIMPOSTO.TP_COMPOSICAOBC = 10) then begin
    fFIS_IMPOSTO.VL_BASECALC := gVlTotalBruto;
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
  vCdRegraFiscal := pParams.CD_REGRAFISCAL;
  if (vCdRegraFiscal = 0) then begin
    raise Exception.Create('Regra fiscal nao informada!' + ' / ' := cDS_METHOD);
    
  end;

  fFIS_REGRAFISCAL.Limpar();
  fFIS_REGRAFISCAL.CD_REGRAFISCAL := vCdRegraFiscal;
  fFIS_REGRAFISCAL.Listar();
  if (xStatus >= 0) then begin
    Result.IN_NOVAREGRA := fFIS_REGRAADIC.IN_NOVAREGRA;
  end else begin
    raise Exception.Create('Dados adicionais da regra nao cadastrado!' + ' / ' := cDS_METHOD);
    
  end;

  fFIS_REGRAREL.Limpar();
  fFIS_REGRAREL.CD_REGRAPRINC := vCdRegraFiscal;
  fFIS_REGRAREL.Listar();
  if (xStatus >= 0) then begin
    Result.IN_REGRAPAI := 1;
  end else begin
    Result.IN_REGRAPAI := 0;
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
  if (pParams.UF_ORIGEM <> '') then begin
    gDsUFOrigem := pParams.UF_ORIGEM;
  end else begin
    gDsUFOrigem := PARAM_GLB.UF_ORIGEM;
  end;

  gInOptSimples := PARAM_GLB.IN_OPT_SIMPLES;
  gDsUFDestino := pParams.UF_DESTINO;
  vCdProduto := pParams.CD_PRODUTO;
  vCdMPTer := pParams.CD_MPTER;
  gCdServico := pParams.CD_SERVICO;
  vCdPessoa := pParams.CD_PESSOA;
  vCdOperacao := pParams.CD_OPERACAO;
  vCdCFOP := pParams.CD_CFOP;
  vCdEmpresaParam := pParams.CD_EMPRESA;
  if (vCdEmpresaParam  = 0) then begin
    vCdEmpresaParam := PARAM_GLB.CD_EMPRESA;
  end;
  gTpModDctoFiscal := pParams.TP_MODDCTOFISCAL;
  gTpOrigemEmissao := pParams.TP_ORIGEMEMISSAO;
  vCdRegraFiscal := pParams.CD_REGRAFISCAL;
  vDtEmissao := pParams.DT_INIVIGENCIA;
  vCdTipi := pParams.CD_TIPI;
  vCdCST := pParams.CD_CST;
  gInContribuinte := FALSE;
  vInDecreto := FALSE;

  if (vCdOperacao = 0) then begin
    raise Exception.Create('Operacao nao informada!' + ' / ' := cDS_METHOD);
    
  end;
  if (vCdPessoa = 0) then begin
    raise Exception.Create('Pessoa nao informada!' + ' / ' := cDS_METHOD);
    
  end;
  if (gDsUfOrigem = '') then begin
    raise Exception.Create('Origem nao informada!' + ' / ' := cDS_METHOD);
    
  end;
  if (gDsUfDestino = '') then begin
    raise Exception.Create('Origem nao informada!' + ' / ' := cDS_METHOD);
    
  end;
  if (vDtEmissao = 0) then begin
    raise Exception.Create('Data de emiss√£o nao informada!' + ' / ' := cDS_METHOD);
    
  end;

  fGER_OPERACAO.Limpar();
  fGER_OPERACAO.CD_OPERACAO := vCdOperacao;
  fGER_OPERACAO.Listar();
  if (itemXmlF('status', voParams) < 0) then begin
    raise Exception.Create('Operacao ' + FloatToStr(vCdOperacao) + ' nao cadastrada!' + ' / ' := cDS_METHOD);
    
  end;
  if (fGER_OPERACAO.TP_OPERACAO = 'E') then begin
    vDsAux := gDsUfOrigem;
    gDsUfOrigem := gDsUfDestino;
    gDsUfDestino := vDsAux;
  end;
  if (vCdRegraFiscal > 0) then begin
    fGER_OPERACAO.CD_REGRAFISCAL := vCdRegraFiscal;
  end else begin
    vCdRegraFiscal := fGER_OPERACAO.CD_REGRAFISCAL;
  end;
  if (gCdServico <> 0) or (vCdProduto = 0) then begin
    if (vCdCST <> '') then begin
      gCdCST := SubStr(vCdCST, 1, 1);
    end else begin
      gCdCST := '0';
    end;
  end else begin
    fPRD_PRODUTO.Limpar();
    fPRD_PRODUTO.CD_PRODUTO := vCdProduto;
    fPRD_PRODUTO.Listar();
    if (itemXmlF('status', voParams) < 0) then begin
      raise Exception.Create('Produto ' + FloatToStr(vCdProduto) + ' nao cadastrado!' + ' / ' := cDS_METHOD);
      
    end else begin
      fPRD_PRDREGRAFISCAL.Limpar();
      fPRD_PRDREGRAFISCAL.CD_OPERACAO := fGER_OPERACAO.CD_OPERACAO;
      fPRD_PRDREGRAFISCAL.Listar();
      if (xStatus >= 0) then begin
        vCdRegraFiscal := fPRD_PRDREGRAFISCAL.CD_REGRAFISCAL;
      end;
    end;
    gCdCST := SubStr(fPRD_PRODUTO.CD_CST, 1, 1);
  end;

  fPES_PESSOA.Limpar();
  fPES_PESSOA.CD_PESSOA := vCdPessoa;
  fPES_PESSOA.Listar();
  if (itemXmlF('status', voParams) < 0) then begin
    raise Exception.Create('Pessoa nao informada!' + ' / ' := cDS_METHOD);
    
  end;

  viParams := '';
  viParams.CD_PESSOA := vCdPessoa;
  voParams := cFCRSVCO057.Instance.validaPessoaOrgaopublico(viParams);
  if (itemXmlF('status', voParams) < 0) then begin
    raise Exception.Create(itemXml('message', voParams)); exit;
  end;

  gInPjIsento := FALSE;
  if (PosItem(fPES_PESJURIDICA.NR_INSCESTL, 'ISENTO|ISENTA|ISENTOS|ISENTAS') > 0) then begin
    gInPjIsento := TRUE;
  end;

  vInOrgaopublico := voParams.IN_ORGAOPUBLICO;
  if (vInOrgaopublico = TRUE) and (gDsUFOrigem = 'DF') then begin
    gInContribuinte := TRUE;
  end else begin
    if (fPES_CLIENTE.IN_CNSRFINAL = TRUE) or (fPES_PESSOA.TP_PESSOA = 'F') or (gInPjIsento = TRUE) then begin
      if (fPES_CLIENTE.IN_CNSRFINAL = TRUE) and (fPES_PESSOA.TP_PESSOA = 'J') and (gInPjIsento = FALSE) then begin
        gInContribuinte := TRUE;
      end else begin
        if (fPES_PESSOA.TP_PESSOA = 'F') and (((item('NR_CODIGOFISCAL', tPES_CLIENTE) <> '') and (PosItem(gDsUFOrigem, 'PR|SP|RS') > 0)) or (item('NR_INSCPRODRURAL', tPES_PFADIC) <> '')) then begin
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

  fFIS_REGRAFISCAL.Limpar();
  fFIS_REGRAFISCAL.CD_REGRAFISCAL := vCdRegraFiscal;
  fFIS_REGRAFISCAL.Listar();
  if (xStatus >= 0) then begin
    fFIS_REGRAREL.Limpar();
    fFIS_REGRAREL.CD_REGRAPRINC := fFIS_REGRAFISCAL.CD_REGRAFISCAL;
    fFIS_REGRAREL.DT_VIGINICIAL := '<=' + DateToStr(vDtEmissao);
    fFIS_REGRAREL.DT_VIGFINAL := '>=' + DateToStr(vDtEmissao);
    fFIS_REGRAREL.TP_SITUACAO := 1;
    fFIS_REGRAREL.Listar();
    if (xStatus >= 0) then begin
      sort_e(tFIS_REGRAREL, 'NR_ORDEM');
      fFIS_REGRAREL.First();
      while(xStatus >= 0) do begin
        fFIS_REGRACOND.First();
        while(xStatus >= 0) do begin

          if (fFIS_REGRACOND.DS_VALOR = 'V')
          or (fFIS_REGRACOND.DS_VALOR = 'Verdadeiro')
          or (fFIS_REGRACOND.DS_VALOR = 'T') then begin
            fFIS_REGRACOND.DS_VALOR := 'TRUE';
          end else if (fFIS_REGRACOND.DS_VALOR = 'F')
                   or (fFIS_REGRACOND.DS_VALOR = 'Falso')
                   or (fFIS_REGRACOND.DS_VALOR = 'F') then begin
            fFIS_REGRACOND.DS_VALOR := 'FALSE';
          end;

          vUtilizaRegra := TRUE;
          case round(fFIS_REGRACOND.TP_CAMPO) of
            1 : begin
              if (fFIS_REGRACOND.TP_OPERADOR = 1) then begin
                vInValor := fFIS_REGRACOND.DS_VALOR;
                if (vInValor = TRUE) then begin
                  if (gDsUfOrigem = gDsUfDestino) then begin
                    vUtilizaRegra := FALSE;
                  end;
                end else begin
                  if (gDsUfOrigem <> gDsUfDestino) then begin
                    vUtilizaRegra := FALSE;
                  end;
                end;
              end else if (fFIS_REGRACOND.TP_OPERADOR = 2) then begin
                vInValor := fFIS_REGRACOND.DS_VALOR;
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
              if (fFIS_REGRACOND.TP_OPERADOR = 1) then begin
                vInValor := fFIS_REGRACOND.DS_VALOR;
                if (vInValor <> gInContribuinte) then begin
                  vUtilizaRegra := FALSE;
                end;
              end else if (fFIS_REGRACOND.TP_OPERADOR = 2) then begin
                vInValor := fFIS_REGRACOND.DS_VALOR;
                if (vInValor = gInContribuinte) then begin
                  vUtilizaRegra := FALSE;
                end;
              end;
            end;
            3 : begin
              if (fFIS_REGRACOND.TP_OPERADOR = 1) then begin
                vInValor := fFIS_REGRACOND.DS_VALOR;
                if (vInValor <> fPES_CLIENTE.IN_CNSRFINAL) then begin
                  vUtilizaRegra := FALSE;
                end;
              end else if (fFIS_REGRACOND.TP_OPERADOR = 2) then begin
                vInValor := fFIS_REGRACOND.DS_VALOR;
                if (vInValor = fPES_CLIENTE.IN_CNSRFINAL) then begin
                  vUtilizaRegra := FALSE;
                end;
              end;
            end;
            4 : begin
              if (fFIS_REGRACOND.TP_OPERADOR = 1) then begin
                if (fFIS_REGRACOND.DS_VALOR <> gDsUfOrigem) then begin
                  vUtilizaRegra := FALSE;
                end;
              end else if (fFIS_REGRACOND.TP_OPERADOR = 2) then begin
                if (fFIS_REGRACOND.DS_VALOR = gDsUfOrigem) then begin
                  vUtilizaRegra := FALSE;
                end;
              end else if (fFIS_REGRACOND.TP_OPERADOR = 8) then begin
                vDsLst := fFIS_REGRACOND.DS_VALOR;
                vPos := PosItem(gDsUfOrigem, vDsLst);
                if (vPos = 0) then begin
                  vUtilizaRegra := FALSE;
                end;
              end else if (fFIS_REGRACOND.TP_OPERADOR = 9) then begin
                vDsLst := fFIS_REGRACOND.DS_VALOR;
                vPos := PosItem(gDsUfOrigem, vDsLst);
                if (vPos > 0) then begin
                  vUtilizaRegra := FALSE;
                end;
              end;
            end;
            5 : begin
              if (fFIS_REGRACOND.TP_OPERADOR = 1) then begin
                if (fFIS_REGRACOND.DS_VALOR <> gDsUfDestino) then begin
                  vUtilizaRegra := FALSE;
                end;
              end else if (fFIS_REGRACOND.TP_OPERADOR = 2) then begin
                if (fFIS_REGRACOND.DS_VALOR = gDsUfDestino) then begin
                  vUtilizaRegra := FALSE;
                end;
              end else if (fFIS_REGRACOND.TP_OPERADOR = 8) then begin
                vDsLst := fFIS_REGRACOND.DS_VALOR;
                vPos := PosItem(gDsUfDestino, vDsLst);
                if (vPos = 0) then begin
                  vUtilizaRegra := FALSE;
                end;
              end else if (fFIS_REGRACOND.TP_OPERADOR = 9) then begin
                vDsLst := fFIS_REGRACOND.DS_VALOR;
                vPos := PosItem(gDsUfDestino, vDsLst);
                if (vPos > 0) then begin
                  vUtilizaRegra := FALSE;
                end;
              end;
            end;
            6 : begin
              if (fPES_PFADIC.NR_INSCPRODRURAL <> '') then begin
                vInValor := TRUE;
              end else begin
                vInValor := FALSE;
              end;
              if (fFIS_REGRACOND.TP_OPERADOR = 1) then begin
                if (vInValor <> fFIS_REGRACOND.DS_VALOR) then begin
                  vUtilizaRegra := FALSE;
                end;
              end else if (fFIS_REGRACOND.TP_OPERADOR = 2) then begin
                if (vInValor = fFIS_REGRACOND.DS_VALOR) then begin
                  vUtilizaRegra := FALSE;
                end;
              end;
            end;
            7 : begin
              if (fPES_CLIENTE.NR_SUFRAMA <> '') then begin
                vInValor := TRUE;
              end else begin
                vInValor := FALSE;
              end;
              if (fFIS_REGRACOND.TP_OPERADOR = 1) then begin
                if (vInValor <> fFIS_REGRACOND.DS_VALOR) then begin
                  vUtilizaRegra := FALSE;
                end;
              end else if (fFIS_REGRACOND.TP_OPERADOR = 2) then begin
                if (vInValor = fFIS_REGRACOND.DS_VALOR) then begin
                  vUtilizaRegra := FALSE;
                end;
              end;
            end;
            8 : begin
              if (fFIS_REGRACOND.TP_OPERADOR = 1) then begin
                if (vInOrgaopublico <> fFIS_REGRACOND.DS_VALOR) then begin
                  vUtilizaRegra := FALSE;
                end;
              end else if (fFIS_REGRACOND.TP_OPERADOR = 2) then begin
                if (vInOrgaopublico = fFIS_REGRACOND.DS_VALOR) then begin
                  vUtilizaRegra := FALSE;
                end;
              end;
            end;
            9 : begin
              if (fFIS_REGRACOND.TP_OPERADOR = 1) then begin
                if (gInOptSimples <> fFIS_REGRACOND.DS_VALOR) then begin
                  vUtilizaRegra := FALSE;
                end;
              end else if (fFIS_REGRACOND.TP_OPERADOR = 2) then begin
                if (gInOptSimples = fFIS_REGRACOND.DS_VALOR) then begin
                  vUtilizaRegra := FALSE;
                end;
              end;
            end;
            10 : begin
              if (fPES_PESSOA.TP_PESSOA <> 'F') then begin
                if (fPES_PESJURIDICA.IsEmpty() <> False) then begin
                  raise Exception.Create('Pessoa ' + FloatToStr(vCdPessoa) + ' nao √© jur√≠dica!' + ' / ' := cDS_METHOD);
                  
                end;
                if (fFIS_REGRACOND.TP_OPERADOR = 1) then begin
                  if (fPES_PESJURIDICA.TP_REGIMETRIB <> itemF('DS_VALOR', tFIS_REGRACOND)) then begin
                    vUtilizaRegra := FALSE;
                  end;
                end else if (fFIS_REGRACOND.TP_OPERADOR = 2) then begin
                  if (fPES_PESJURIDICA.TP_REGIMETRIB = itemF('DS_VALOR', tFIS_REGRACOND)) then begin
                    vUtilizaRegra := FALSE;
                  end;
                end else if (fFIS_REGRACOND.TP_OPERADOR = 8) then begin
                  vDsLst := fFIS_REGRACOND.DS_VALOR;
                  vPos := PosItem(fPES_PESJURIDICA.TP_REGIMETRIB, vDsLst);
                  if (vPos = 0) then begin
                    vUtilizaRegra := FALSE;
                  end;
                end else if (fFIS_REGRACOND.TP_OPERADOR = 9) then begin
                  vDsLst := fFIS_REGRACOND.DS_VALOR;
                  vPos := PosItem(fPES_PESJURIDICA.TP_REGIMETRIB, vDsLst);
                  if (vPos > 0) then begin
                    vUtilizaRegra := FALSE;
                  end;
                end;
              end else begin
                vUtilizaRegra := FALSE;
              end;
            end;
            11 : begin
              vTpAreaComercio := PARAM_GLB.TP_AREA_COMERCIO_ORIGEM;
              if (fFIS_REGRACOND.TP_OPERADOR = 1) then begin
                if (vTpAreaComercio <> fFIS_REGRACOND.DS_VALOR) then begin
                  vUtilizaRegra := FALSE;
                end;
              end else if (fFIS_REGRACOND.TP_OPERADOR = 2) then begin
                if (vTpAreaComercio = fFIS_REGRACOND.DS_VALOR) then begin
                  vUtilizaRegra := FALSE;
                end;
              end;
            end;
            12 : begin
              viParams := '';
              viParams.CD_PESSOA := fPES_PESSOA.CD_PESSOA;
              viParams.NM_MUNICIPIO := fGLB_MUNICIPIO.NM_MUNICIPIO;
              viParams.DS_SIGLAESTADO := fGLB_ESTADO.DS_SIGLA;
              voParams := cPESSVCO005.Instance.verificaAreaComercio(viParams);
              if (itemXmlF('status', voParams) < 0) then begin
                raise Exception.Create(itemXml('message', voParams)); exit;
              end;

              vTpAreaComercio := voParams.TP_AREACOMERCIO;
              if (fFIS_REGRACOND.TP_OPERADOR = 1) then begin
                if (vTpAreaComercio <> fFIS_REGRACOND.DS_VALOR) then begin
                  vUtilizaRegra := FALSE;
                end;
              end else if (fFIS_REGRACOND.TP_OPERADOR = 2) then begin
                if (vTpAreaComercio = fFIS_REGRACOND.DS_VALOR) then begin
                  vUtilizaRegra := FALSE;
                end;
              end else if (fFIS_REGRACOND.TP_OPERADOR = 8) then begin
                vDsLst := fFIS_REGRACOND.DS_VALOR;
                vPos := PosItem(FloatToStr(vTpAreaComercio), vDsLst);
                if (vPos = 0) then begin
                  vUtilizaRegra := FALSE;
                end;
            end else if (fFIS_REGRACOND.TP_OPERADOR = 9) then begin
                vDsLst := fFIS_REGRACOND.DS_VALOR;
                vPos := PosItem(FloatToStr(vTpAreaComercio), vDsLst);
                if (vPos > 0) then begin
                  vUtilizaRegra := FALSE;
                end;
              end;
            end;
            13 : begin

              vOrigemPrdCst := StrToFloatDef(gCdCST,0);

              if (fFIS_REGRACOND.TP_OPERADOR = 1) then begin
                if (vOrigemPrdCst <> fFIS_REGRACOND.DS_VALOR) then begin
                  vUtilizaRegra := FALSE;
                end;
              end else if (fFIS_REGRACOND.TP_OPERADOR = 2) then begin
                if (vOrigemPrdCst = fFIS_REGRACOND.DS_VALOR) then begin
                  vUtilizaRegra := FALSE;
                end;
              end else if (fFIS_REGRACOND.TP_OPERADOR = 3) then begin
                if (vOrigemPrdCst <= fFIS_REGRACOND.DS_VALOR) then begin
                  vUtilizaRegra := FALSE;
                end;
              end else if (fFIS_REGRACOND.TP_OPERADOR = 4) then begin
                if (vOrigemPrdCst >= fFIS_REGRACOND.DS_VALOR) then begin
                  vUtilizaRegra := FALSE;
                end;
              end else if (fFIS_REGRACOND.TP_OPERADOR = 5) then begin
                if (vOrigemPrdCst < fFIS_REGRACOND.DS_VALOR) then begin
                  vUtilizaRegra := FALSE;
                end;
              end else if (fFIS_REGRACOND.TP_OPERADOR = 6) then begin
                if (vOrigemPrdCst > fFIS_REGRACOND.DS_VALOR) then begin
                  vUtilizaRegra := FALSE;
                end;
              end else if (fFIS_REGRACOND.TP_OPERADOR = 7) then begin
                if (vOrigemPrdCst <= fFIS_REGRACOND.DS_VALOR) or (vOrigemPrdCst >= itemF('DS_VALOROPCIONAL', tFIS_REGRACOND)) then begin
                  vUtilizaRegra := FALSE;
                end;
              end else if (fFIS_REGRACOND.TP_OPERADOR = 8) then begin
                vDsLst := fFIS_REGRACOND.DS_VALOR;
                vPos := PosItem(FloatToStr(vOrigemPrdCst), vDsLst);
                if (vPos = 0) then begin
                  vUtilizaRegra := FALSE;
                end;
              end else if (fFIS_REGRACOND.TP_OPERADOR = 9) then begin
                vDsLst := fFIS_REGRACOND.DS_VALOR;
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
                  viParams.CD_EMPRESA := vCdEmpresaParam;
                  viParams.CD_PRODUTO := vCdProduto;
                  voParams := cPRDSVCO008.Instance.buscaDadosFilial(viParams);
                  if (itemXmlF('status', voParams) < 0) then begin
                    raise Exception.Create(itemXml('message', voParams)); exit;
                  end;
                  vInProdPropria := voParams.IN_PRODPROPRIA;
                end;
              end;
              if (fFIS_REGRACOND.TP_OPERADOR = 1) then begin
                if (vInProdPropria <> fFIS_REGRACOND.DS_VALOR) then begin
                  vUtilizaRegra := FALSE;
                end;
              end else if (fFIS_REGRACOND.TP_OPERADOR = 2) then begin
                if (vInProdPropria = fFIS_REGRACOND.DS_VALOR) then begin
                  vUtilizaRegra := FALSE;
                end;
              end;
            end;
            15 : begin
              if (fFIS_REGRACOND.TP_OPERADOR = 1) then begin
                if (fPES_PESJURIDICA.CD_ATIVIDADE <> item('DS_VALOR', tFIS_REGRACOND)) then begin
                  vUtilizaRegra := FALSE;
                end;
              end else if (fFIS_REGRACOND.TP_OPERADOR = 2) then begin
                if (fPES_PESJURIDICA.CD_ATIVIDADE = item('DS_VALOR', tFIS_REGRACOND)) then begin
                  vUtilizaRegra := FALSE;
                end;
              end;
            end;
            16 : begin
              fFIS_REGRACOND.DS_VALOR := ReplaceStr(fFIS_REGRACOND.DS_VALOR, '.', '');
              fFIS_REGRACOND.DS_VALOROPCIONAL := ReplaceStr(fFIS_REGRACOND.DS_VALOROPCIONAL, '.', '');
              if (fFIS_REGRACOND.TP_OPERADOR = 1) then begin
                if (vCdTipi <> fFIS_REGRACOND.DS_VALOR) then begin
                  vUtilizaRegra := FALSE;
                end;
              end else if (fFIS_REGRACOND.TP_OPERADOR = 2) then begin
                if (vCdTipi = fFIS_REGRACOND.DS_VALOR) then begin
                  vUtilizaRegra := FALSE;
                end;
              end else if (fFIS_REGRACOND.TP_OPERADOR = 7) then begin
                if (vCdTipi <= fFIS_REGRACOND.DS_VALOR)or(vCdTipi >= item('DS_VALOROPCIONAL', tFIS_REGRACOND)) then begin
                  vUtilizaRegra := FALSE;
                end;
              end else if (fFIS_REGRACOND.TP_OPERADOR = 8) then begin
                vDsLst := fFIS_REGRACOND.DS_VALOR;
                vPos := PosItem(vCdTipi, vDsLst);
                if (vPos = 0) then begin
                  vUtilizaRegra := FALSE;
                end;
              end else if (fFIS_REGRACOND.TP_OPERADOR = 9) then begin
                vDsLst := fFIS_REGRACOND.DS_VALOR;
                vPos := PosItem(vCdTipi, vDsLst);
                if (vPos > 0) then begin
                  vUtilizaRegra := FALSE;
                end;
              end;
            end;
            17 : begin
              gNr02 := 0;
              fPRD_PRDINFOADIC.Limpar();
              fPRD_PRDINFOADIC.CD_EMPRESA := vCdEmpresaParam;
              fPRD_PRDINFOADIC.CD_PRODUTO := vCdProduto;
              fPRD_PRDINFOADIC.Listar();
              if (xStatus >= 0) then begin
                gNr02 := fPRD_PRDINFOADIC.TP_PRDSPED;
              end;
              if (fFIS_REGRACOND.TP_OPERADOR = 1) then begin
                if (gNr02 <> fFIS_REGRACOND.DS_VALOR) or (gNr02 = 0) then begin
                  vUtilizaRegra := FALSE;
                end;
              end else if (fFIS_REGRACOND.TP_OPERADOR = 2) then begin
                if (gNr02 = fFIS_REGRACOND.DS_VALOR) then begin
                  vUtilizaRegra := FALSE;
                end;
              end else if (fFIS_REGRACOND.TP_OPERADOR = 3) then begin
                if (gNr02  <= fFIS_REGRACOND.DS_VALOR) or (gNr02 = 0) then begin
                  vUtilizaRegra := FALSE;
                end;
              end else if (fFIS_REGRACOND.TP_OPERADOR = 4) then begin
                if (gNr02  >= fFIS_REGRACOND.DS_VALOR) or (gNr02 = 0) then begin
                  vUtilizaRegra := FALSE;
                end;
              end else if (fFIS_REGRACOND.TP_OPERADOR = 5) then begin
                if (gNr02  > fFIS_REGRACOND.DS_VALOR) or (gNr02 = 0) then begin
                  vUtilizaRegra := FALSE;
                end;
              end else if (fFIS_REGRACOND.TP_OPERADOR = 6) then begin
                if (gNr02  < fFIS_REGRACOND.DS_VALOR) or (gNr02 = 0) then begin
                  vUtilizaRegra := FALSE;
                end;
              end else if (fFIS_REGRACOND.TP_OPERADOR = 8) then begin
                vDsLst := fFIS_REGRACOND.DS_VALOR;
                vPos := PosItem(FloatToStr(gNr02), vDsLst);
                if (vPos = 0) then begin
                  vUtilizaRegra := FALSE;
                end;
              end else if (fFIS_REGRACOND.TP_OPERADOR = 9) then begin
                vDsLst := fFIS_REGRACOND.DS_VALOR;
                vPos := PosItem(FloatToStr(gNr02), vDsLst);
                if (vPos > 0) then begin
                  vUtilizaRegra := FALSE;
                end;
              end;
            end;
            18 : begin

              vInAchou := TRUE;

              viParams := '';
              viParams.CD_PRODUTO := fPRD_PRODUTO.CD_PRODUTO;
              viParams.UF_ORIGEM := gDsUFOrigem;
              viParams.UF_DESTINO := gDsUFDestino;
              viParams.TP_OPERACAO := fGER_OPERACAO.TP_OPERACAO;
              viParams.CD_PESSOA := vCdPessoa;
              voParams := cFISSVCO035.Instance.buscaDadosFiscalProduto(viParams);
              if (itemXmlF('status', voParams) < 0) then begin
                raise Exception.Create(itemXml('message', voParams)); exit;
              end;
              if (voParams = '') then begin
                vInAchou := FALSE;
              end;
              if (fFIS_REGRACOND.TP_OPERADOR = 1) then begin
                if (vInAchou <> fFIS_REGRACOND.DS_VALOR) then begin
                  vUtilizaRegra := FALSE;
                end;
              end else if (fFIS_REGRACOND.TP_OPERADOR = 2) then begin
                if (vInAchou = fFIS_REGRACOND.DS_VALOR) then begin
                  vUtilizaRegra := FALSE;
                end;
              end;
            end;
            19 : begin

              if (fFIS_REGRACOND.TP_OPERADOR = 1) then begin
                if (gNaturezaComercialEmp <> fFIS_REGRACOND.DS_VALOR) then begin
                  vUtilizaRegra := FALSE;
                end;
              end else if (fFIS_REGRACOND.TP_OPERADOR = 2) then begin
                if (gNaturezaComercialEmp = fFIS_REGRACOND.DS_VALOR) then begin
                  vUtilizaRegra := FALSE;
                end;
              end else if (fFIS_REGRACOND.TP_OPERADOR = 8) then begin
                vDsLst := fFIS_REGRACOND.DS_VALOR;
                vPos := PosItem(vDsLst, gNaturezaComercialEmp);
                if (vPos = 0) then begin
                  vUtilizaRegra := FALSE;
                end;
              end else if (fFIS_REGRACOND.TP_OPERADOR = 9) then begin
                vDsLst := fFIS_REGRACOND.DS_VALOR;
                vPos := PosItem(vDsLst, gNaturezaComercialEmp);
                if (vPos > 0) then begin
                  vUtilizaRegra := FALSE;
                end;
              end;
            end;
            20 : begin
              if (fFIS_REGRACOND.TP_OPERADOR = 1) then begin
                if (fPES_PJADIC.CD_ATIVIDADE <> item('DS_VALOR', tFIS_REGRACOND)) then begin
                  vUtilizaRegra := FALSE;
                end;
              end else if (fFIS_REGRACOND.TP_OPERADOR = 2) then begin
                if (fPES_PJADIC.CD_ATIVIDADE = item('DS_VALOR', tFIS_REGRACOND)) then begin
                  vUtilizaRegra := FALSE;
                end;
              end else if (fFIS_REGRACOND.TP_OPERADOR = 8) then begin
                vDsLst := fFIS_REGRACOND.DS_VALOR;
                vPos := PosItem(fPES_PJADIC.CD_ATIVIDADE, vDsLst);
                if (vPos = 0) then begin
                  vUtilizaRegra := FALSE;
                end;
              end else if (fFIS_REGRACOND.TP_OPERADOR = 9) then begin
                vDsLst := fFIS_REGRACOND.DS_VALOR;
                vPos := PosItem(fPES_PJADIC.CD_ATIVIDADE, vDsLst);
                if (vPos > 0) then begin
                  vUtilizaRegra := FALSE;
                end;
              end;
            end;
            21 : begin
              if (fFIS_REGRACOND.TP_OPERADOR = 1) then begin
                getfFIS_REGRACOND.DS_VALOR, 1);
                vDsLst := fFIS_REGRACOND.DS_VALOR;
                delitemGld(vDsLst, 1);

                fPRD_PRODUTOCLAS.Limpar();
                fPRD_PRODUTOCLAS.CD_PRODUTO := vCdProduto;
                fPRD_PRODUTOCLAS.CD_TIPOCLAS := vTpclas;
                fPRD_PRODUTOCLAS.CD_CLASSIFICACAO := vDsLst;
                fPRD_PRODUTOCLAS.Listar();
                if (itemXmlF('status', voParams) < 0) then begin
                  vUtilizaRegra := FALSE;
                end;
              end else if (fFIS_REGRACOND.TP_OPERADOR = 2) then begin
                getfFIS_REGRACOND.DS_VALOR, 1);
                vDsLst := fFIS_REGRACOND.DS_VALOR;
                delitemGld(vDsLst, 1);

                fPRD_PRODUTOCLAS.Limpar();
                fPRD_PRODUTOCLAS.CD_PRODUTO := vCdProduto;
                fPRD_PRODUTOCLAS.CD_TIPOCLAS := vTpclas;
                fPRD_PRODUTOCLAS.CD_CLASSIFICACAO := vDsLst;
                fPRD_PRODUTOCLAS.Listar();
                if (xStatus >= 0) then begin
                  vUtilizaRegra := FALSE;
                end;
              end else if (fFIS_REGRACOND.TP_OPERADOR = 8) then begin
                vInAchou := FALSE;
                vDsLst := fFIS_REGRACOND.DS_VALOR;
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

                  fPRD_PRODUTOCLAS.Limpar();
                  fPRD_PRODUTOCLAS.CD_PRODUTO := vCdProduto;
                  fPRD_PRODUTOCLAS.CD_TIPOCLAS := vTpclas;
                  fPRD_PRODUTOCLAS.CD_CLASSIFICACAO := vClas;
                  fPRD_PRODUTOCLAS.Listar();
                  if (xStatus >= 0) then begin
                    vInAchou := TRUE;
                  end;
                end;
                if (vInAchou = FALSE) then begin
                  vUtilizaRegra := FALSE;
                end;
              end else if (fFIS_REGRACOND.TP_OPERADOR = 9) then begin
                vInAchou := FALSE;
                vDsLst := fFIS_REGRACOND.DS_VALOR;
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

                  fPRD_PRODUTOCLAS.Limpar();
                  fPRD_PRODUTOCLAS.CD_PRODUTO := vCdProduto;
                  fPRD_PRODUTOCLAS.CD_TIPOCLAS := vTpclas;
                  fPRD_PRODUTOCLAS.CD_CLASSIFICACAO := vClas;
                  fPRD_PRODUTOCLAS.Listar();
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

          fFIS_REGRACOND.Next();
        end;
        if (vUtilizaRegra = TRUE) then begin
          vCdRegraFiscal := fFIS_REGRAREL.CD_REGRAREL;
          break;
        end;

        fFIS_REGRAREL.Next();
      end;
    end;
  end else begin
    raise Exception.Create('Regra fiscal nao cadastrada!' + ' / ' := cDS_METHOD);
    
  end;

  fFIS_REGRAFISCAL.Limpar();
  fFIS_REGRAFISCAL.CD_REGRAFISCAL := vCdRegraFiscal;
  fFIS_REGRAFISCAL.Listar();
  if (itemXmlF('status', voParams) < 0) then begin
    fFIS_REGRAFISCAL.Limpar();
  end;

  Result := '';
  fFIS_REGRAFISCAL.SetValues(Result);
  Result.IN_CONTRIBUINTE := gInContribuinte;

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
  vCdEmpresa := pParams.CD_EMPRESA;
  if (vCdEmpresa = 0) then begin
    vCdEmpresa := PARAM_GLB.CD_EMPRESA;
  end;
  if (pParams.UF_ORIGEM <> '') then begin
    gDsUFOrigem := pParams.UF_ORIGEM;
  end else begin
    gDsUFOrigem := PARAM_GLB.UF_ORIGEM;
  end;

  gDsUFDestino := pParams.UF_DESTINO;
  vCdRegraFiscal := pParams.CD_REGRAFISCAL;
  gTpOrigemEmissao := pParams.TP_ORIGEMEMISSAO;
  vCdProduto := pParams.CD_PRODUTO;
  vCdMPTer := pParams.CD_MPTER;
  gCdServico := pParams.CD_SERVICO;
  vCdOperacao := pParams.CD_OPERACAO;
  vCdPessoa := pParams.CD_PESSOA;
  gVlTotalBruto := pParams.VL_TOTALBRUTO;
  gVlTotalLiquido := pParams.VL_TOTALLIQUIDO;
  gVlTotalLiquidoICMS := pParams.VL_TOTALLIQUIDO;
  gPrIPI := pParams.PR_IPI;
  gVlIPI := pParams.VL_IPI;
  gVlFrete := pParams.VL_FRETE;
  gVlSeguro := pParams.VL_SEGURO;
  gVlDespAcessor := pParams.VL_DESPACESSOR;
  gPrIcms := pParams.PR_ICMS;
  gInContribuinte := pParams.IN_CONTRIBUINTE;
  vCdCST := pParams.CD_CST;
  vDsLstCdImposto := pParams.DS_LST_CD_IMPOSTO;
  gInProdPropria := FALSE;
  gDtVigenciaIPI := 0;

  if (vCdRegraFiscal = 0) then begin
    raise Exception.Create('Regra fiscal nao informada!' + ' / ' := cDS_METHOD);
    
  end;
  if (vCdOperacao = 0) then begin
    raise Exception.Create('Operacao nao informada!' + ' / ' := cDS_METHOD);
    
  end;

  fGER_OPERACAO.Limpar();
  fGER_OPERACAO.CD_OPERACAO := vCdOperacao;
  fGER_OPERACAO.Listar();
  if (itemXmlF('status', voParams) < 0) then begin
    raise Exception.Create('Operacao ' + FloatToStr(vCdOperacao) + ' nao cadastrada!' + ' / ' := cDS_METHOD);
    
  end;
  if (fGER_OPERACAO.IN_CALCIMPOSTO <> TRUE) then begin
    return(0); exit;
  end;

  fFIS_REGRAFISCAL.Limpar();
  fFIS_REGRAFISCAL.CD_REGRAFISCAL := vCdRegraFiscal;
  fFIS_REGRAFISCAL.Listar();
  if (itemXmlF('status', voParams) < 0) then begin
    raise Exception.Create('Regra fiscal ' + FloatToStr(vCdRegraFiscal) + ' nao cadastrada!' + ' / ' := cDS_METHOD);
    
  end;
  if (vDsLstCdImposto <> '') then begin
    fFIS_REGRAIMPOSTO.Limpar();
    fFIS_REGRAIMPOSTO.CD_IMPOSTO := vDsLstCdImposto;
    fFIS_REGRAIMPOSTO.Listar();
    if (itemXmlF('status', voParams) < 0) then begin
      fFIS_REGRAIMPOSTO.Limpar();
    end;
  end;

  if (gCdEmpParam = 0) or (gCdEmpParam <> vCdEmpresa) then begin
    getParam(pParams);
    gCdEmpParam := vCdEmpresa;
  end;

  if not (gInContribuinte) then begin
    fPES_PESSOA.Limpar();
    fPES_PESSOA.CD_PESSOA := vCdPessoa;
    fPES_PESSOA.Listar();
    if (itemXmlF('status', voParams) < 0) then begin
      raise Exception.Create('Pessoa nao informada!' + ' / ' := cDS_METHOD);
      
    end;

    viParams := '';
    viParams.CD_PESSOA := vCdPessoa;
    voParams := cFCRSVCO057.Instance.validaPessoaOrgaopublico(viParams);
    if (itemXmlF('status', voParams) < 0) then begin
      raise Exception.Create(itemXml('message', voParams)); exit;
    end;
    vInOrgaopublico := voParams.IN_ORGAOpublicO;

    gInPjIsento := FALSE;
    if (PosItem(fPES_PESJURIDICA.NR_INSCESTL, 'ISENTO|ISENTA|ISENTOS|ISENTAS') > 0) then begin
      gInPjIsento := TRUE;
    end;
    if (vInOrgaopublico = TRUE) and (gDsUFOrigem = 'DF') then begin
      gInContribuinte := TRUE;
    end else begin
      if (fPES_CLIENTE.IN_CNSRFINAL = TRUE) or (fPES_PESSOA.TP_PESSOA = 'F') or (gInPjIsento = TRUE) then begin
        if (fPES_CLIENTE.IN_CNSRFINAL = TRUE) and (fPES_PESSOA.TP_PESSOA = 'J') and (gInPjIsento = FALSE) then begin
          gInContribuinte := TRUE;
        end else begin
          if (fPES_PESSOA.TP_PESSOA = 'F') and (((item('NR_CODIGOFISCAL', tPES_CLIENTE) <> '') and (PosItem(gDsUFOrigem, 'PR|SP|RS') > 0))  or (item('NR_INSCPRODRURAL', tPES_PFADIC) <> '')) then begin
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
    fCDF_MPTER.Limpar();
    fCDF_MPTER.CD_PESSOA := vCdPessoa;
    fCDF_MPTER.CD_MPTER := vCdMPTer;
    fCDF_MPTER.Listar();
    if (itemXmlF('status', voParams) < 0) then begin
      raise Exception.Create('Materia-prima ' + vCdMPTer + ' nao cadastrada para a pessoa ' + FloatToStr(vCdPessoa) + '!' + ' / ' := cDS_METHOD);
      
    end;
  end else if (gCdServico > 0) then begin
    fPCP_SERV.Limpar();
    fPCP_SERV.CD_SERVICO := gCdServico;
    fPCP_SERV.Listar();
    if (itemXmlF('status', voParams) < 0) then begin
      raise Exception.Create('Servico ' + FloatToStr(gCdServico) + ' nao cadastrado!' + ' / ' := cDS_METHOD);
      
    end;
  end else if (vCdProduto > 0) then begin
    fPRD_PRODUTO.Limpar();
    fPRD_PRODUTO.CD_PRODUTO := vCdProduto;
    fPRD_PRODUTO.Listar();
    if (itemXmlF('status', voParams) < 0) then begin
      raise Exception.Create('Produto ' + FloatToStr(vCdProduto) + ' nao cadastrado!' + ' / ' := cDS_METHOD);
      
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
      gCdCST := SubStr(fCDF_MPTER.CD_CST, 1, 1);
    end else begin
      gCdCST := SubStr(fPRD_PRODUTO.CD_CST, 1, 1);

      viParams := '';
      viParams.CD_EMPRESA := vCdEmpresa;
      viParams.CD_PRODUTO := vCdProduto;
      voParams := cPRDSVCO008.Instance.buscaDadosFilial(viParams);
      if (itemXmlF('status', voParams) < 0) then begin
        raise Exception.Create(itemXml('message', voParams)); exit;
      end;
      gInProdPropria := voParams.IN_PRODPROPRIA;
    end;
  end;
  if (fGER_OPERACAO.TP_OPERACAO = 'S') then begin
    if (fGER_OPERACAO.TP_MODALIDADE = 3) then begin
      vDsUF := gDsUFOrigem;
      gDsUFOrigem := gDsUFDestino;
      gDsUFDestino := vDsUF;
    end;
  end else begin
    if ((gTpOrigemEmissao = 2) and (fGER_OPERACAO.TP_MODALIDADE <> 3))or(gTpOrigemEmissao = 1) then begin
      vDsUF := gDsUFOrigem;
      gDsUFOrigem := gDsUFDestino;
      gDsUFDestino := vDsUF;
    end;
  end;

  gVlICMS := 0;
  fFIS_IMPOSTO.Limpar();

  if not (fFIS_REGRAIMPOSTO.IsEmpty()) then begin
    sort_e(tFIS_REGRAIMPOSTO, 'NR_ORDEM;');
    fFIS_REGRAIMPOSTO.First();
    while not t.EOF do begin

      vCdImposto := fFIS_REGRAIMPOSTO.CD_IMPOSTO;
      vDtIniVigencia := 0;

      viParams := '';
      viParams.CD_IMPOSTO := vCdImposto;
      viParams.DT_INIVIGENCIA := pParams.DT_INIVIGENCIA;
      voParams := cFISSVCO069.Instance.retornaImposto(viParams);
      if (itemXmlF('status', voParams) < 0) then begin
        raise Exception.Create(itemXml('message', voParams)); exit;
      end;
      if (voParams <> '') then begin
        vDtIniVigencia := voParams.DT_INIVIGENCIA;

        fFIS_IMPOSTO.Append();
        fFIS_IMPOSTO.CD_IMPOSTO := vCdImposto;
        fFIS_IMPOSTO.DT_INIVIGENCIA := vDtIniVigencia;
        fFIS_IMPOSTO.Consultar();
        if (xStatus = -7) then begin
          fFIS_IMPOSTO.Consultar();
        end else if (xStatus = 0) then begin
          raise Exception.Create('Imposto ' + FloatToStr(vCdImposto) + ' nao cadastrado!' + ' / ' := cDS_METHOD);
          
        end;

        case round(vCdImposto) of
          1 : begin
            calculaICMS(1);
            if (itemXmlF('status', voParams) < 0) then exit;
          end;
          2 : begin
            calculaICMSSubst(2);
            if (itemXmlF('status', voParams) < 0) then exit;
          end;
          3 : begin
            calculaIPI();
            if (itemXmlF('status', voParams) < 0) then exit;
          end;
          4 : begin
            calculaISS();
            if (itemXmlF('status', voParams) < 0) then exit;
          end;
          5 : begin
            calculaCOFINS();
            if (itemXmlF('status', voParams) < 0) then exit;
          end;
          6 : begin
            calculaPIS();
            if (itemXmlF('status', voParams) < 0) then exit;
          end;
          7 : begin
            calculaPASEP();
            if (itemXmlF('status', voParams) < 0) then exit;
          end;
          10 : begin
            calculaCSLL();
            if (itemXmlF('status', voParams) < 0) then exit;
          end;
          20 : begin
            calculaICMSSubst(20);
            if (itemXmlF('status', voParams) < 0) then exit;
          end;
          30 : begin
            calculaIPI();
            if (itemXmlF('status', voParams) < 0) then exit;
          end;
        end;
      end;
      fFIS_REGRAIMPOSTO.Next();
    end;
  end;

  vDsLstImposto := '';
  if not (fFIS_IMPOSTO.IsEmpty()) then begin
    sort_e(tFIS_IMPOSTO, 'CD_IMPOSTO;');
    fFIS_IMPOSTO.First();
    while not t.EOF do begin
      vDsRegistro := '';
      fFIS_IMPOSTO.SetValues(vDsRegistro);
      putitem(vDsLstImposto,  vDsRegistro);
      fFIS_IMPOSTO.Next();
    end;
  end;

  vDsLstImpCalc := '';
  if (fFIS_REGRAIMPCALC.IsEmpty() = 0) then begin
    sort_e(tFIS_REGRAIMPCALC, 'CD_IMPOSTO');
    fFIS_REGRAIMPCALC.First();
    while not t.EOF do begin
      vDsRegistro := '';
      putlistitensocc(vDsRegistro, tFIS_REGRAIMPCALC);
      putitem(vDsLstImpCalc, vDsRegistro);
      fFIS_REGRAIMPCALC.Next();
    end;
  end;

  Length(gCdCST);
  vNrTam := xResult;
  if (vNrTam <= 1) then begin
    gCdCST := gCdCST + '00';
  end;
  if (gInProdPropria = TRUE) then begin
    vCdCFOP := fFIS_REGRAFISCAL.CD_CFOPPROPRIA;
  end else begin
    vCdCFOP := fFIS_REGRAFISCAL.CD_CFOPTERCEIRO;
  end;

  Result := '';
  Result.CD_CST := gCdCST;
  Result.CD_CFOP := vCdCFOP;
  Result.DS_LSTIMPOSTO := vDsLstImposto;
  Result.DS_LSTIMPCALC := vDsLstImpCalc;

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
	vCdRegra := pParams.CD_REGRAFISCAL;

	if (vCdRegra = 0) then begin
		raise Exception.Create('CÛdigo de regra para busca de alÌquota interna n„o informado!' + ' / ' := cDS_METHOD);
		return(STS_ERROR); exit;
	end;

	newInstanceComponente('FISSVCO080', 'FISSVCO080O', 'TRANSACTION=FALSE');
	voParams := cFISSVCO080O.Instance.buscaRegraRelacionada(pParams);
	if (itemXmlF('status', voParams) < 0) then begin
    raise Exception.Create(itemXml('message', voParams)); Exit;
	end;
	vCdRegraAliq := voParams.CD_REGRAFISCAL;

	if(vCdRegra <> vCdRegraAliq) then begin
		fFIS_REGRAFISCAL.Limpar();
    fFIS_REGRAFISCAL.CD_REGRAFISCAL := vCdRegraAliq;
		fFIS_REGRAFISCAL.Listar();
		if (xStatus >= 0) then begin
			fFIS_REGRAIMPOSTO.Limpar();
      fFIS_REGRAIMPOSTO.CD_IMPOSTO := 1;
			fFIS_REGRAIMPOSTO.Listar();
			if (xStatus >= 0) then begin
				vPrAliquota := fFIS_REGRAIMPOSTO.PR_ALIQUOTA;
			end;
  	end;
 	end;

	Result.PR_ALIQUOTA := vPrAliquota;

	return(0); exit;
End;

initialization
  RegisterClass(T_FISSVCO080);

end.
