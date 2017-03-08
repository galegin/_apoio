unit cFISSVCO024;

interface

(* COMPONENTES 
  ADMSVCO001 / GERSVCO046 / PEDSVCO015 / PESSVCO005 / PRDSVCO018
  PRDSVCO023 / TRASVCO022 / 
*)        

uses
  Classes, SysUtils, DB,
  cServiceUnf, cDataSetUnf;

type
  T_FISSVCO024 = class(TcServiceUnf)
  private
    tF_V_PES_ENDER,
    tFIS_DETALHEIC,
    tFIS_DIFALIQC,
    tFIS_DIFALIQI,
    tFIS_ITEMCONSI,
    tFIS_LOGNF,
    tFIS_NF,
    tFIS_NFIDEVT,
    tFIS_NFIMPOSTO,
    tFIS_NFITEM,
    tFIS_NFITEMAD,
    tFIS_NFITEMDES,
    tFIS_NFITEMIMP,
    tFIS_NFITEMPRO,
    tFIS_NFITEMVL,
    tFIS_NFREMDES,
    tFIS_NFSELOENT,
    tFIS_NFTRANSP,
    tGER_MODNFC,
    tGER_MODNFE,
    tOBS_NF,
    tOBS_NFFISCO,
    tOBS_TRANSFISC,
    tPES_PESSOA,
    tPRD_GRADEI,
    tPRD_GRUPO,
    tPRD_LOTEINF,
    tPRD_PRDGRADE,
    tTRA_ITEMLOTE,
    tTRA_REMDES,
    tTRA_SELOENT,
    tTRA_TRANSACAD,
    tTRA_TRANSACAO,
    tTRA_TRANSACCO : TcDatasetUnf;
    function getParam(pParams : String = '') : String;
    function setEntidade(pParams : String = '') : String;
  protected
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;    
  published
    function montaCampo(pParams : String = '') : String;
    function calculaTotalAliquota(pParams : String = '') : String;
    function gravaLogNF(pParams : String = '') : String;
    function alteraRemDes(pParams : String = '') : String;
    function gravaObsNfFisco(pParams : String = '') : String;
    function gravaItemDevTerceiroNF(pParams : String = '') : String;
    function gravaDespesaItem(pParams : String = '') : String;
    function gravaItemConsignacaoTransacao(pParams : String = '') : String;
    function gravaFisNfItemVl(pParams : String = '') : String;
    function vinculaLoteTransacaoNF(pParams : String = '') : String;
    function gravaObsNfe(pParams : String = '') : String;
    function validaCampoNfe(pParams : String = '') : String;
    function buscaNrDiaCompensacaoNF(pParams : String = '') : String;
    function gravaDiferencialAliqC(pParams : String = '') : String;
    function gravaDiferencialAliqI(pParams : String = '') : String;
    function gravaDetalheIcms(pParams : String = '') : String;
    function gravaSeloFiscalEnt(pParams : String = '') : String;
  end;

implementation

uses
  cADMSVCO001,
  cActivate, cStatus, cFuncao, cXml, dModulo;

var
  gDtAgendamento,
  gDtEncerramento,
  gInConsSubTribCredSimp,
  gInOptSimples,
  gInUtilizaSeloFiscal,
  gprAliqSimplesNacional,
  gprReduBaseSimpNacional,
  gVl12,
  gVl12D1,
  gVl12D2,
  gVl12D3,
  gVl12D4,
  gVl12D5,
  gVl12D6 : String;

//---------------------------------------------------------------
constructor T_FISSVCO024.Create(AOwner: TComponent);
//---------------------------------------------------------------
begin
  inherited Create(AOwner);
  setEntidade('');
end;

//--------------------------------
destructor T_FISSVCO024.Destroy;
//--------------------------------
begin
  inherited Destroy;
end;

//---------------------------------------------------------------
function T_FISSVCO024.getParam(pParams : String) : String;
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
  putitem(xParam, 'IN_CONS_SUBTRIB_CRED_SIMP');

  xParam := T_ADMSVCO001.GetParametro(xParam);

  gDtEncerramento := itemXml('DT_ENCERRAMENTO_FIS', xParam);
  gInConsSubTribCredSimp := itemXml('IN_CONS_SUBTRIB_CRED_SIMP', xParam);
  gInOptSimples := itemXml('IN_OPT_SIMPLES', xParam);
  gInUtilizaSeloFiscal := itemXml('IN_UTILIZA_SELO_FISCAL', xParam);

  xParamEmp := '';
  putitem(xParamEmp, 'DT_ENCERRAMENTO_FIS');
  putitem(xParamEmp, 'IN_CONS_SUBTRIB_CRED_SIMP');
  putitem(xParamEmp, 'IN_OPT_SIMPLES');
  putitem(xParamEmp, 'IN_UTILIZA_SELO_FISCAL');
  putitem(xParamEmp, 'PR_ALIQ_SIMPLES_NACIONAL');
  putitem(xParamEmp, 'PR_REDUBASE_SIMP_NACIONAL');

  xParamEmp := T_ADMSVCO001.GetParamEmpresa(piCdEmpresa, xParamEmp);

  gDtEncerramento := itemXml('DT_ENCERRAMENTO_FIS', xParamEmp);
  gInOptSimples := itemXml('IN_OPT_SIMPLES', xParamEmp);
  gInUtilizaSeloFiscal := itemXml('IN_UTILIZA_SELO_FISCAL', xParamEmp);

end;

//---------------------------------------------------------------
function T_FISSVCO024.setEntidade(pParams : String) : String;
//---------------------------------------------------------------
begin
  tF_V_PES_ENDER := GetEntidade('F_V_PES_ENDER');
  tFIS_DETALHEIC := GetEntidade('FIS_DETALHEIC');
  tFIS_DIFALIQC := GetEntidade('FIS_DIFALIQC');
  tFIS_DIFALIQI := GetEntidade('FIS_DIFALIQI');
  tFIS_ITEMCONSI := GetEntidade('FIS_ITEMCONSI');
  tFIS_LOGNF := GetEntidade('FIS_LOGNF');
  tFIS_NF := GetEntidade('FIS_NF');
  tFIS_NFIDEVT := GetEntidade('FIS_NFIDEVT');
  tFIS_NFIMPOSTO := GetEntidade('FIS_NFIMPOSTO');
  tFIS_NFITEM := GetEntidade('FIS_NFITEM');
  tFIS_NFITEMAD := GetEntidade('FIS_NFITEMAD');
  tFIS_NFITEMDES := GetEntidade('FIS_NFITEMDES');
  tFIS_NFITEMIMP := GetEntidade('FIS_NFITEMIMP');
  tFIS_NFITEMPRO := GetEntidade('FIS_NFITEMPRO');
  tFIS_NFITEMVL := GetEntidade('FIS_NFITEMVL');
  tFIS_NFREMDES := GetEntidade('FIS_NFREMDES');
  tFIS_NFSELOENT := GetEntidade('FIS_NFSELOENT');
  tFIS_NFTRANSP := GetEntidade('FIS_NFTRANSP');
  tGER_MODNFC := GetEntidade('GER_MODNFC');
  tGER_MODNFE := GetEntidade('GER_MODNFE');
  tOBS_NF := GetEntidade('OBS_NF');
  tOBS_NFFISCO := GetEntidade('OBS_NFFISCO');
  tOBS_TRANSFISC := GetEntidade('OBS_TRANSFISC');
  tPES_PESSOA := GetEntidade('PES_PESSOA');
  tPRD_GRADEI := GetEntidade('PRD_GRADEI');
  tPRD_GRUPO := GetEntidade('PRD_GRUPO');
  tPRD_LOTEINF := GetEntidade('PRD_LOTEINF');
  tPRD_PRDGRADE := GetEntidade('PRD_PRDGRADE');
  tTRA_ITEMLOTE := GetEntidade('TRA_ITEMLOTE');
  tTRA_REMDES := GetEntidade('TRA_REMDES');
  tTRA_SELOENT := GetEntidade('TRA_SELOENT');
  tTRA_TRANSACAD := GetEntidade('TRA_TRANSACAD');
  tTRA_TRANSACAO := GetEntidade('TRA_TRANSACAO');
  tTRA_TRANSACCO := GetEntidade('TRA_TRANSACCO');
end;

//----------------------------------------------------------
function T_FISSVCO024.montaCampo(pParams : String) : String;
//----------------------------------------------------------
const
  cDS_METHOD = 'ADICIONAL=Operação: T_FISSVCO024.montaCampo()';
var
  (* numeric piCodigoCampo : IN / numeric piTamanho : IN / string piDsDados : IN / string piValidaCampo : IN / string poCampo : OUT *)
  vInGravar : Boolean;
  vNrSeqend, vPos, vVlSimples : Real;
  viParams, voParams, vValor, vCdTipoClas, vDslinha, vDsRegistro, vCdCST : String;
begin
  poCampo := '';
  selectcase piCodigoCampo;

    case 000115;
      if (piValidaCampo = True) then begin
        return(0); exit;
      end;
      if (empty(tFIS_NFITEMPRO) = False) then begin
        vCdTipoClas := piDsDados;
        if (vCdTipoClas > 0) then begin
          viParams := '';

          putitemXml(viParams, 'CD_PRODUTO', item_f('CD_PRODUTO', tFIS_NFITEMPRO));
          putitemXml(viParams, 'CD_TIPOCLAS', vCdTipoClas);
          voParams := activateCmp('GERSVCO046', 'buscaDadosProduto', viParams); (*,,,, *)
          if (xStatus < 0) then begin
            Result := voParams;
            return(-1); exit;
          end;
          poCampo := itemXml('DS_CLASSIFICACAO', voParams);
          if (piDsDados <> '')  and (poCampo <> '') then begin
            poCampo := '' + piDsDados + ' ' + poCampo' + ';
          end;
        end else begin
          poCampo := '';
        end;
      end else begin
        poCampo := '';
      end;

    case 000346;
      if (piValidaCampo = True) then begin
        return(0); exit;
      end;
      selectcase (item_f('NR_QTUNITDEC', tGER_MODNFC));
        case 0;
          gVl12 := item_f('QT_FATURADO', tFIS_NF);
          vValor := '' + FloatToStr(gVl) + '12';
        case 1;
          gVl12D1 := item_f('QT_FATURADO', tFIS_NF);
          vValor := '' + FloatToStr(gVl) + '12D1';
        case 2;
          gVl12D2 := item_f('QT_FATURADO', tFIS_NF);
          vValor := '' + FloatToStr(gVl) + '12D2';
        case 3;
          gVl12D3 := item_f('QT_FATURADO', tFIS_NF);
          vValor := '' + FloatToStr(gVl) + '12D3';
        case 4;
          gVl12D4 := item_f('QT_FATURADO', tFIS_NF);
          vValor := '' + FloatToStr(gVl) + '12D4';
        case 5;
          gVl12D5 := item_f('QT_FATURADO', tFIS_NF);
          vValor := '' + FloatToStr(gVl) + '12D5';
        case 6;
          gVl12D6 := item_f('QT_FATURADO', tFIS_NF);
          vValor := '' + FloatToStr(gVl) + '12D6';
        end else begincase
          gVl12D1 := item_f('QT_FATURADO', tFIS_NF);
          vValor := '' + FloatToStr(gVl) + '12D1';
      endselectcase;
      poCampo := vValor;
      if (piDsDados <> '')  and (poCampo <> '') then begin
        poCampo := '' + piDsDados + ' ' + poCampo' + ';
      end;

    case 000357;
      if (piValidaCampo = True) then begin
        return(0); exit;
      end;
      viParams := '';

      putitemXml(viParams, 'CD_EMPRESA', item_f('CD_EMPRESAORI', tFIS_NF));
      putitemXml(viParams, 'NR_TRANSACAO', item_f('NR_TRANSACAOORI', tFIS_NF));
      putitemXml(viParams, 'DT_TRANSACAO', item_a('DT_TRANSACAOORI', tFIS_NF));
      voParams := activateCmp('PEDSVCO015', 'retornaDadosPedido', viParams); (*,,,, *)
      if (xStatus < 0) then begin
        Result := voParams;
        return(-1); exit;
      end;
      poCampo := itemXml('DS_PEDIDOTRA', voParams);
      if (piDsDados <> '')  and (poCampo <> '') then begin
        poCampo := '' + piDsDados + ' ' + poCampo' + ';
      end;

    case 000170;
      if (piValidaCampo = True) then begin
        return(0); exit;
      end;
      if (item_f('VL_DESCONTO', tFIS_NF) > 0) then begin
        poCampo := item_f('VL_DESCONTO', tFIS_NF);
        if (piDsDados <> '')  and (poCampo <> '') then begin
          poCampo := '' + piDsDados + ' ' + poCampo' + ';
        end;
      end else begin
        poCampo := '';
      end;

    case 000245;
      if (piValidaCampo = True) then begin
        return(0); exit;
      end;
      viParams := '';

      putitemXml(viParams, 'CD_EMPRESA', item_f('CD_EMPRESAORI', tFIS_NF));
      putitemXml(viParams, 'NR_TRANSACAO', item_f('NR_TRANSACAOORI', tFIS_NF));
      putitemXml(viParams, 'DT_TRANSACAO', item_a('DT_TRANSACAOORI', tFIS_NF));
      voParams := activateCmp('PEDSVCO015', 'retornaDadosPedido', viParams); (*,,,, *)
      if (xStatus < 0) then begin
        Result := voParams;
        return(-1); exit;
      end;
      poCampo := itemXml('DS_CLIENTE', voParams);
      if (piDsDados <> '')  and (poCampo <> '') then begin
        poCampo := '' + piDsDados + ' ' + poCampo' + ';
      end;

    case 000252;
      if (piValidaCampo = True) then begin
        return(0); exit;
      end;
      if (item_a('NM_TRANSREDESPAC', tFIS_NFTRANSP) <> '') then begin
        poCampo := item_a('NM_TRANSREDESPAC', tFIS_NFTRANSP);
        if (piDsDados <> '')  and (poCampo <> '') then begin
          poCampo := '' + piDsDados + ' ' + poCampo' + ';
        end;
      end else begin
        poCampo := '';
      end;

    case 000253;
      if (piValidaCampo = True) then begin
        return(0); exit;
      end;
      if (item_f('CD_TRANSREDESPAC', tFIS_NFTRANSP) <> '') then begin
        vNrSeqend := 1;
        viParams := '';

        putitemXml(viParams, 'CD_PESSOA', item_f('CD_TRANSREDESPAC', tFIS_NFTRANSP));
        voParams := activateCmp('PESSVCO005', 'buscaenderecoFaturamento', viParams); (*,,,, *)
        if (xStatus < 0) then begin
          Result := voParams;
          return(-1); exit;
        end;
        clear_e(tF_V_PES_ENDER);
        putitem_o(tF_V_PES_ENDER, 'CD_PESSOA', item_f('CD_TRANSREDESPAC', tFIS_NFTRANSP));
        putitem_o(tF_V_PES_ENDER, 'NR_SEQUENCIA', vNrSeqend);
        retrieve_e(tF_V_PES_ENDER);
        if (xStatus >= 0) then begin
          poCampo := '' + item_a('DS_SIGLALOGRAD', tF_V_PES_ENDER) + ' ' + item_a('NM_LOGRADOURO', tF_V_PES_ENDER) + ' ' + item_a('NR_LOGRADOURO', tF_V_PES_ENDER) + ';
          if (piDsDados <> '')  and (poCampo <> '') then begin
            poCampo := '' + piDsDados + ' ' + poCampo' + ';
          end;
        end else begin
          poCampo := '';
        end;
      end else begin
        poCampo := '';
      end;

    case 000254;
      if (piValidaCampo = True) then begin
        return(0); exit;
      end;
      if (item_f('CD_TRANSREDESPAC', tFIS_NFTRANSP) <> '') then begin
        vNrSeqend := 1;
        viParams := '';

        putitemXml(viParams, 'CD_PESSOA', item_f('CD_TRANSREDESPAC', tFIS_NFTRANSP));
        voParams := activateCmp('PESSVCO005', 'buscaenderecoFaturamento', viParams); (*,,,, *)
        if (xStatus < 0) then begin
          Result := voParams;
          return(-1); exit;
        end;
        clear_e(tF_V_PES_ENDER);
        putitem_o(tF_V_PES_ENDER, 'CD_PESSOA', item_f('CD_TRANSREDESPAC', tFIS_NFTRANSP));
        putitem_o(tF_V_PES_ENDER, 'NR_SEQUENCIA', vNrSeqend);
        retrieve_e(tF_V_PES_ENDER);
        if (xStatus >= 0) then begin
          poCampo := item_a('NM_MUNICIPIO', tF_V_PES_ENDER);
          if (piDsDados <> '')  and (poCampo <> '') then begin
            poCampo := '' + piDsDados + ' ' + poCampo' + ';
          end;
        end else begin
          poCampo := '';
        end;
      end else begin
        poCampo := '';
      end;

    case 000255;
      if (piValidaCampo = True) then begin
        return(0); exit;
      end;
      if (item_f('CD_TRANSREDESPAC', tFIS_NFTRANSP) <> '') then begin
        vNrSeqend := 1;
        viParams := '';

        putitemXml(viParams, 'CD_PESSOA', item_f('CD_TRANSREDESPAC', tFIS_NFTRANSP));
        voParams := activateCmp('PESSVCO005', 'buscaenderecoFaturamento', viParams); (*,,,, *)
        if (xStatus < 0) then begin
          Result := voParams;
          return(-1); exit;
        end;
        clear_e(tF_V_PES_ENDER);
        putitem_o(tF_V_PES_ENDER, 'CD_PESSOA', item_f('CD_TRANSREDESPAC', tFIS_NFTRANSP));
        putitem_o(tF_V_PES_ENDER, 'NR_SEQUENCIA', vNrSeqend);
        retrieve_e(tF_V_PES_ENDER);
        if (xStatus >= 0) then begin
          poCampo := item_a('DS_SIGLAESTADO', tF_V_PES_ENDER);
          if (piDsDados <> '')  and (poCampo <> '') then begin
            poCampo := '' + piDsDados + ' ' + poCampo' + ';
          end;
        end else begin
          poCampo := '';
        end;
      end else begin
        poCampo := '';
      end;

    case 000366;
      if (piValidaCampo = True) then begin
        return(0); exit;
      end;
      viParams := '';

      putitemXml(viParams, 'CD_EMPRESA', item_f('CD_EMPRESAORI', tFIS_NF));
      putitemXml(viParams, 'NR_TRANSACAO', item_f('NR_TRANSACAOORI', tFIS_NF));
      putitemXml(viParams, 'DT_TRANSACAO', item_a('DT_TRANSACAOORI', tFIS_NF));
      voParams := activateCmp('PEDSVCO015', 'retornaDadosPedido', viParams); (*,,,, *)
      if (xStatus < 0) then begin
        Result := voParams;
        return(-1); exit;
      end;
      poCampo := itemXmlF('NR_PEDIDOCLIENTE', voParams);
      if (piDsDados <> '')  and (poCampo <> '') then begin
        poCampo := '' + piDsDados + ' ' + poCampo' + ';
      end;

    case 000319;
      if (piValidaCampo = True) then begin
        return(0); exit;
      end;
      clear_e(tTRA_TRANSACAO);
      putitem_o(tTRA_TRANSACAO, 'CD_EMPRESA', item_f('CD_EMPRESAORI', tFIS_NF));
      putitem_o(tTRA_TRANSACAO, 'NR_TRANSACAO', item_f('NR_TRANSACAOORI', tFIS_NF));
      putitem_o(tTRA_TRANSACAO, 'DT_TRANSACAO', item_a('DT_TRANSACAOORI', tFIS_NF));
      retrieve_e(tTRA_TRANSACAO);
      if (xStatus >= 0) then begin
        if (item_f('CD_REPRESENTANT', tTRA_TRANSACAO) <> '') then begin
          viParams := '';

          putitemXml(viParams, 'CD_PESSOA', item_f('CD_REPRESENTANT', tTRA_TRANSACAO));
          voParams := activateCmp('PESSVCO005', 'buscaDadosPessoa', viParams); (*,,,, *)
          if (xStatus < 0) then begin
            Result := voParams;
            return(-1); exit;
          end;
          poCampo := itemXml('NM_PESSOA', voParams);
          if (piDsDados <> '')  and (poCampo <> '') then begin
            poCampo := '' + piDsDados + ' ' + poCampo' + ';
          end;
        end else begin
          poCampo := '';
        end;
      end else begin
        poCampo := '';
      end;

    case 000425;
      vDsLinha := '';
      setocc(tTRA_TRANSACCO, 1);
      if (xStatus >= 0) then begin
        while(xStatus >= 0) do begin
          if (item_f('TP_SITUACAO', tTRA_TRANSACCO) = 4) then begin
            if (vDsLinha = '') then begin
              vDsLinha := 'NR. CONTAGEM ' + item_a('NR_CONTAGEM', tTRA_TRANSACCO) + ';
            end else begin
              vDsLinha := '' + vDsLinha + ' / ' + item_a('NR_CONTAGEM', tTRA_TRANSACCO) + ';
            end;
          end;
          setocc(tTRA_TRANSACCO, curocc(tTRA_TRANSACCO) + 1);
        end;
        pocampo := vDslinha;
      end;

    case 000433;
      if (piValidaCampo = True) then begin
        return(0); exit;
      end;
      clear_e(tTRA_TRANSACAO);
      putitem_o(tTRA_TRANSACAO, 'CD_EMPRESA', item_f('CD_EMPRESAORI', tFIS_NF));
      putitem_o(tTRA_TRANSACAO, 'NR_TRANSACAO', item_f('NR_TRANSACAOORI', tFIS_NF));
      putitem_o(tTRA_TRANSACAO, 'DT_TRANSACAO', item_a('DT_TRANSACAOORI', tFIS_NF));
      retrieve_e(tTRA_TRANSACAO);
      if (xStatus >= 0) then begin
        if (item_f('CD_REPRESENTANT', tTRA_TRANSACAO) <> '') then begin
          viParams := '';

          putitemXml(viParams, 'CD_PESSOA', item_f('CD_REPRESENTANT', tTRA_TRANSACAO));
          voParams := activateCmp('PESSVCO005', 'buscarTelefone', viParams); (*,,, *)
          if (xStatus < 0) then begin
            Result := voParams;
            return(-1); exit;
          end;
          poCampo := itemXmlF('NR_TELEFONE', voParams);
          if (piDsDados <> '')  and (poCampo <> '') then begin
            poCampo := '' + piDsDados + ' ' + poCampo' + ';
          end;
        end else begin
          poCampo := '';
        end;
      end else begin
        poCampo := '';
      end;

    case 000636;
      if (piValidaCampo = True) then begin
        return(0); exit;
      end;
      if (item_f('CD_PRODUTO', tFIS_NFITEMPRO) > 0) then begin
        viParams := '';

        putitemXml(viParams, 'CD_EMPRESA', item_f('CD_EMPRESAORI', tFIS_NF));
        putitemXml(viParams, 'NR_TRANSACAO', item_f('NR_TRANSACAOORI', tFIS_NF));
        putitemXml(viParams, 'DT_TRANSACAO', item_a('DT_TRANSACAOORI', tFIS_NF));
        putitemXml(viParams, 'CD_PRODUTO', item_f('CD_PRODUTO', tFIS_NFITEMPRO));
        putitemXml(viParams, 'NR_ITEM', item_f('NR_ITEM', tFIS_NFITEMPRO));
        voParams := activateCmp('TRASVCO022', 'buscaDadosCartela', viParams); (*,,,, *)
        if (xStatus < 0) then begin
          Result := voParams;
          return(-1); exit;
        end;
        poCampo := itemXmlF('NR_CARTELA', voParams);
        if (piDsDados <> '')  and (poCampo <> '') then begin
          poCampo := '' + piDsDados + ' ' + poCampo' + ';
        end;
      end else begin
        poCampo := '';
      end;

    case 000108;
      if (piValidaCampo = True) then begin
        return(0); exit;
      end;
      setocc(tFIS_NFITEMPRO, -1);
      setocc(tFIS_NFITEMPRO, 1);
      if (totocc(tFIS_NFITEMPRO) = 1 ) and (item_f('CD_PRODUTO', tFIS_NFITEMPRO) > 0)  or (item_b('IN_AGRUPA_GRUPO', tGER_MODNFC) = 'C') then begin
        clear_e(tPRD_PRDGRADE);
        putitem_o(tPRD_PRDGRADE, 'CD_PRODUTO', item_f('CD_PRODUTO', tFIS_NFITEMPRO));
        retrieve_e(tPRD_PRDGRADE);
        if (xStatus >= 0) then begin
          poCampo := '' + item_a('CD_COR', tPRD_PRDGRADE) + ';
          if (piDsDados <> '')  and (poCampo <> '') then begin
            poCampo := '' + piDsDados + ' ' + poCampo' + ';
          end;
        end else begin
          poCampo := '';
        end;
      end else begin
        poCampo := '';
      end;

    case 000110;
      if (piValidaCampo = True) then begin
        return(0); exit;
      end;
      poCampo := '';
      setocc(tFIS_NFITEMPRO, -1);
      setocc(tFIS_NFITEMPRO, 1);
      if (totocc(tFIS_NFITEMPRO) = 1 ) and (item_f('CD_PRODUTO', tFIS_NFITEMPRO) > 0)  or (item_b('IN_AGRUPA_GRUPO', tGER_MODNFC) = 'A') then begin
        clear_e(tPRD_PRDGRADE);
        putitem_o(tPRD_PRDGRADE, 'CD_PRODUTO', item_f('CD_PRODUTO', tFIS_NFITEMPRO));
        retrieve_e(tPRD_PRDGRADE);
        if (xStatus >= 0) then begin
          if (item_f('CD_GRADE', tPRD_GRUPO) > 0) then begin
            clear_e(tPRD_GRADEI);
            putitem_o(tPRD_GRADEI, 'CD_GRADE', item_f('CD_GRADE', tPRD_GRUPO));
            putitem_o(tPRD_GRADEI, 'CD_TAMANHO', item_f('CD_TAMANHO', tPRD_PRDGRADE));
            retrieve_e(tPRD_GRADEI);
            if (xStatus >= 0) then begin
              poCampo := item_a('DS_TAMANHO', tPRD_GRADEI);
              if (piDsDados <> '')  and (poCampo <> '') then begin
                poCampo := '' + piDsDados + ' ' + poCampo' + ';
              end;
            end;
          end;
        end;
      end;

    case 000171;
      if (piValidaCampo = True) then begin
        return(0); exit;
      end;
      if (item_f('PR_DESCONTO', tFIS_NF) > 0) then begin
        poCampo := item_f('PR_DESCONTO', tFIS_NF);
        if (piDsDados <> '')  and (poCampo <> '') then begin
          poCampo := '' + piDsDados + ' ' + poCampo' + ';
        end;
      end else begin
        poCampo := '';
      end;

    case 000567;
      if (piValidaCampo = True) then begin
        return(0); exit;
      end;
      poCampo := '';
      viParams := '';

      putitemXml(viParams, 'CD_EMPRESA', item_f('CD_EMPRESAORI', tFIS_NF));
      putitemXml(viParams, 'NR_TRANSACAO', item_f('NR_TRANSACAOORI', tFIS_NF));
      putitemXml(viParams, 'DT_TRANSACAO', item_a('DT_TRANSACAOORI', tFIS_NF));
      putitemXml(viParams, 'CD_INDICE', 1);
      voParams := activateCmp('PEDSVCO015', 'retornaDadosPedido', viParams); (*,,,, *)
      if (xStatus < 0) then begin
        Result := voParams;
        return(-1); exit;
      end;
      gDtAgendamento := itemXml('DT_AGendAMENTO', voParams);
      poCampo := '' + gDtAgendamento' + ';
      if (piDsDados <> '')  and (poCampo <> '') then begin
        poCampo := '' + piDsDados + ' ' + poCampo' + ';
      end;

    case 000568;
      if (piValidaCampo = True) then begin
        return(0); exit;
      end;
      poCampo := '';
      viParams := '';

      putitemXml(viParams, 'CD_EMPRESA', item_f('CD_EMPRESAORI', tFIS_NF));
      putitemXml(viParams, 'NR_TRANSACAO', item_f('NR_TRANSACAOORI', tFIS_NF));
      putitemXml(viParams, 'DT_TRANSACAO', item_a('DT_TRANSACAOORI', tFIS_NF));
      putitemXml(viParams, 'CD_INDICE', 1);
      voParams := activateCmp('PEDSVCO015', 'retornaDadosPedido', viParams); (*,,,, *)
      if (xStatus < 0) then begin
        Result := voParams;
        return(-1); exit;
      end;
      poCampo := itemXml('HR_AGendAMENTO', voParams);
      if (piDsDados <> '')  and (poCampo <> '') then begin
        poCampo := '' + piDsDados + ' ' + poCampo' + ';
      end;

    case 000569;
      if (piValidaCampo = True) then begin
        return(0); exit;
      end;
      poCampo := '';
      viParams := '';

      putitemXml(viParams, 'CD_EMPRESA', item_f('CD_EMPRESAORI', tFIS_NF));
      putitemXml(viParams, 'NR_TRANSACAO', item_f('NR_TRANSACAOORI', tFIS_NF));
      putitemXml(viParams, 'DT_TRANSACAO', item_a('DT_TRANSACAOORI', tFIS_NF));
      putitemXml(viParams, 'CD_INDICE', 1);
      voParams := activateCmp('PEDSVCO015', 'retornaDadosPedido', viParams); (*,,,, *)
      if (xStatus < 0) then begin
        Result := voParams;
        return(-1); exit;
      end;
      poCampo := itemXml('DS_SENHA', voParams);
      if (piDsDados <> '')  and (poCampo <> '') then begin
        poCampo := '' + piDsDados + ' ' + poCampo' + ';
      end;

    case 000570;
      if (piValidaCampo = True) then begin
        return(0); exit;
      end;
      poCampo := '';
      viParams := '';

      putitemXml(viParams, 'CD_EMPRESA', item_f('CD_EMPRESAORI', tFIS_NF));
      putitemXml(viParams, 'NR_TRANSACAO', item_f('NR_TRANSACAOORI', tFIS_NF));
      putitemXml(viParams, 'DT_TRANSACAO', item_a('DT_TRANSACAOORI', tFIS_NF));
      putitemXml(viParams, 'CD_INDICE', 1);
      voParams := activateCmp('PEDSVCO015', 'retornaDadosPedido', viParams); (*,,,, *)
      if (xStatus < 0) then begin
        Result := voParams;
        return(-1); exit;
      end;
      poCampo := itemXml('DS_CHAVE', voParams);
      if (piDsDados <> '')  and (poCampo <> '') then begin
        poCampo := '' + piDsDados + ' ' + poCampo' + ';
      end;

    case 000571;
      if (piValidaCampo = True) then begin
        return(0); exit;
      end;
      poCampo := '';
      viParams := '';

      putitemXml(viParams, 'CD_EMPRESA', item_f('CD_EMPRESAORI', tFIS_NF));
      putitemXml(viParams, 'NR_TRANSACAO', item_f('NR_TRANSACAOORI', tFIS_NF));
      putitemXml(viParams, 'DT_TRANSACAO', item_a('DT_TRANSACAOORI', tFIS_NF));
      putitemXml(viParams, 'CD_INDICE', 1);
      voParams := activateCmp('PEDSVCO015', 'retornaDadosPedido', viParams); (*,,,, *)
      if (xStatus < 0) then begin
        Result := voParams;
        return(-1); exit;
      end;
      poCampo := itemXml('DS_PORTAO', voParams);
      if (piDsDados <> '')  and (poCampo <> '') then begin
        poCampo := '' + piDsDados + ' ' + poCampo' + ';
      end;

    case 000572;
      if (piValidaCampo = True) then begin
        return(0); exit;
      end;
      poCampo := '';
      viParams := '';

      putitemXml(viParams, 'CD_EMPRESA', item_f('CD_EMPRESAORI', tFIS_NF));
      putitemXml(viParams, 'NR_TRANSACAO', item_f('NR_TRANSACAOORI', tFIS_NF));
      putitemXml(viParams, 'DT_TRANSACAO', item_a('DT_TRANSACAOORI', tFIS_NF));
      putitemXml(viParams, 'CD_INDICE', 1);
      voParams := activateCmp('PEDSVCO015', 'retornaDadosPedido', viParams); (*,,,, *)
      if (xStatus < 0) then begin
        Result := voParams;
        return(-1); exit;
      end;
      poCampo := itemXml('DS_CARGA', voParams);
      if (piDsDados <> '')  and (poCampo <> '') then begin
        poCampo := '' + piDsDados + ' ' + poCampo' + ';
      end;

    case 000618;
      if (piValidaCampo = True) then begin
        return(0); exit;
      end;
      poCampo := '';
      setocc(tFIS_NFITEMPRO, -1);
      setocc(tFIS_NFITEMPRO, 1);
      if (totocc(tFIS_NFITEMPRO) = 1 ) and (item_f('CD_PRODUTO', tFIS_NFITEMPRO) > 0)  or (item_b('IN_AGRUPA_GRUPO', tGER_MODNFC) = 'A')  or (item_b('IN_AGRUPA_GRUPO', tGER_MODNFC) = 'C') then begin
        viParams := '';
        putitemXml(viParams, 'CD_PRODUTO', item_f('CD_PRODUTO', tFIS_NFITEMPRO));
        putitemXml(viParams, 'CD_PESSOA', item_f('CD_PESSOA', tFIS_NF));
        voParams := activateCmp('PRDSVCO023', 'buscaDadosProduto', viParams); (*,,,, *)
        if (xStatus < 0) then begin
          Result := voParams;
          return(-1); exit;
        end;
        poCampo := itemXmlF('CD_ORIGEM', voParams);
        if (piDsDados <> '')  and (poCampo <> '') then begin
          poCampo := '' + piDsDados + ' ' + poCampo' + ';
        end;
      end;

    case 000619;
      if (piValidaCampo = True) then begin
        return(0); exit;
      end;
      poCampo := '';
      setocc(tFIS_NFITEMPRO, -1);
      setocc(tFIS_NFITEMPRO, 1);
      if (totocc(tFIS_NFITEMPRO) = 1 ) and (item_f('CD_PRODUTO', tFIS_NFITEMPRO) > 0)  or (item_b('IN_AGRUPA_GRUPO', tGER_MODNFC) = 'A')  or (item_b('IN_AGRUPA_GRUPO', tGER_MODNFC) = 'C') then begin
        viParams := '';
        putitemXml(viParams, 'CD_PRODUTO', item_f('CD_PRODUTO', tFIS_NFITEMPRO));
        putitemXml(viParams, 'CD_PESSOA', item_f('CD_PESSOA', tFIS_NF));
        voParams := activateCmp('PRDSVCO023', 'buscaDadosProduto', viParams); (*,,,, *)
        if (xStatus < 0) then begin
          Result := voParams;
          return(-1); exit;
        end;
        poCampo := itemXml('DS_ORIGEM', voParams);
        if (piDsDados <> '')  and (poCampo <> '') then begin
          poCampo := '' + piDsDados + ' ' + poCampo' + ';
        end;
      end;

    case 000332;
      if (piValidaCampo = True) then begin
        return(0); exit;
      end;
      poCampo := '';
      viParams := '';

      putitemXml(viParams, 'CD_PESSOA', item_f('CD_PESSOA', tFIS_NFREMDES));
      putitemXml(viParams, 'CD_TIPOendERECO', 5);
      voParams := activateCmp('PESSVCO005', 'buscarendereco', viParams); (*,,, *)
      if (xStatus < 0) then begin
        Result := voParams;
        return(-1); exit;
      end;

      poCampo := '' + itemXml('DS_SIGLALOGRAD', + ' voParams) ' + itemXml('NM_LOGRADOURO', + ' voParams) ' + itemXml('NR_LOGRADOURO', + ' voParams)';
      if (piDsDados <> '')  and (poCampo <> '') then begin
        poCampo := '' + piDsDados + ' ' + poCampo' + ';
      end;

    case 000349;
      if (piValidaCampo = True) then begin
        return(0); exit;
      end;
      poCampo := '';
      viParams := '';

      putitemXml(viParams, 'CD_PESSOA', item_f('CD_PESSOA', tFIS_NFREMDES));
      putitemXml(viParams, 'CD_TIPOendERECO', 5);
      voParams := activateCmp('PESSVCO005', 'buscarendereco', viParams); (*,,, *)
      if (xStatus < 0) then begin
        Result := voParams;
        return(-1); exit;
      end;

      poCampo := '' + itemXml('NM_MUNICIPIO', + ' voParams) ' + itemXml('DS_SIGLAESTADO', + ' voParams)';
      if (piDsDados <> '')  and (poCampo <> '') then begin
        poCampo := '' + piDsDados + ' ' + poCampo' + ';
      end;

    case 000350;
      if (piValidaCampo = True) then begin
        return(0); exit;
      end;
      poCampo := '';
      viParams := '';

      putitemXml(viParams, 'CD_PESSOA', item_f('CD_PESSOA', tFIS_NFREMDES));
      putitemXml(viParams, 'CD_TIPOendERECO', 5);
      voParams := activateCmp('PESSVCO005', 'buscarendereco', viParams); (*,,, *)
      if (xStatus < 0) then begin
        Result := voParams;
        return(-1); exit;
      end;

      poCampo := itemXmlF('CD_CEP', voParams);
      if (piDsDados <> '')  and (poCampo <> '') then begin
        poCampo := '' + piDsDados + ' ' + poCampo' + ';
      end;

    case 000358;
      if (piValidaCampo = True) then begin
        return(0); exit;
      end;
      poCampo := '';
      viParams := '';

      putitemXml(viParams, 'CD_PESSOA', item_f('CD_PESSOA', tFIS_NFREMDES));
      putitemXml(viParams, 'CD_TIPOendERECO', 5);
      voParams := activateCmp('PESSVCO005', 'buscarendereco', viParams); (*,,, *)
      if (xStatus < 0) then begin
        Result := voParams;
        return(-1); exit;
      end;

      poCampo := itemXml('DS_REFERENCIA', voParams);
      if (piDsDados <> '')  and (poCampo <> '') then begin
        poCampo := '' + piDsDados + ' ' + poCampo' + ';
      end;

    case 000604;
      if (piValidaCampo = True) then begin
        return(0); exit;
      end;
      poCampo := '';
      viParams := '';

      putitemXml(viParams, 'CD_PESSOA', item_f('CD_PESSOA', tFIS_NFREMDES));
      putitemXml(viParams, 'CD_TIPOendERECO', 5);
      voParams := activateCmp('PESSVCO005', 'buscarendereco', viParams); (*,,, *)
      if (xStatus < 0) then begin
        Result := voParams;
        return(-1); exit;
      end;

      poCampo := itemXml('DS_BAIRRO', voParams);
      if (piDsDados <> '')  and (poCampo <> '') then begin
        poCampo := '' + piDsDados + ' ' + poCampo' + ';
      end;

    case 000605;
      if (piValidaCampo = True) then begin
        return(0); exit;
      end;
      poCampo := '';
      viParams := '';

      putitemXml(viParams, 'CD_PESSOA', item_f('CD_PESSOA', tFIS_NFREMDES));
      putitemXml(viParams, 'CD_TIPOendERECO', 5);
      voParams := activateCmp('PESSVCO005', 'buscarendereco', viParams); (*,,, *)
      if (xStatus < 0) then begin
        Result := voParams;
        return(-1); exit;
      end;

      poCampo := itemXml('DS_SIGLAESTADO', voParams);
      if (piDsDados <> '')  and (poCampo <> '') then begin
        poCampo := '' + piDsDados + ' ' + poCampo' + ';
      end;

    case 000694;
      if (piValidaCampo = True) then begin
        return(0); exit;
      end;
      poCampo := '';
      viParams := '';

      putitemXml(viParams, 'CD_PESSOA', item_f('CD_PESSOA', tFIS_NFREMDES));
      putitemXml(viParams, 'CD_TIPOendERECO', 5);
      voParams := activateCmp('PESSVCO005', 'buscarendereco', viParams); (*,,, *)
      if (xStatus < 0) then begin
        Result := voParams;
        return(-1); exit;
      end;

      poCampo := itemXml('DS_COMPLEMENTO', voParams);
      if (piDsDados <> '')  and (poCampo <> '') then begin
        poCampo := '' + piDsDados + ' ' + poCampo' + ';
      end;

    case 000417;
      if (piValidaCampo = True) then begin
        return(0); exit;
      end;
      poCampo := '';
      if (empty(tFIS_NFITEMPRO) = False) then begin
        viParams := '';

        putitemXml(viParams, 'CD_PRODUTO', item_f('CD_PRODUTO', tFIS_NFITEMPRO));
        putitemXml(viParams, 'CD_TIPOCAMPO', piDsDados);
        voParams := activateCmp('PRDSVCO018', 'buscaCampoAdicional', viParams); (*,,,, *)
        if (xStatus < 0) then begin
          Result := voParams;
          return(-1); exit;
        end;
        vDslinha := '';
        vDsRegistro := '';
        vDsLinha := itemXml('DS_LSTCAMPO', voParams);
        getitem(vDsRegistro, vDslinha, 1);
        poCampo := itemXml('DS_CAMPO', vDsRegistro);
      end;

    case 000669;
      if (piValidaCampo = True) then begin
        return(0); exit;
      end;
      if (gInOptSimples <> 'S') then begin
        return(0); exit;
      end;

      vVlSimples := 0;
      vInGravar := False;
      vPos := curocc(tFIS_NFITEM);
      setocc(tFIS_NFITEM, 1);
      while (xStatus >= 0) do begin
        vCdCST := item_f('CD_CST', tFIS_NFITEM)[2 : 2];
        if (vCdCST = '00' ) or (vCdCST = '10' ) or (vCdCST = '20' ) or (vCdCST = '30' ) or (vCdCST = '41' ) or (vCdCST = '51' ) or (vCdCST = '70') then begin
          vInGravar := True;

          if (vCdCST = '00' ) or (vCdCST = '20' ) or (vCdCST = '41' ) or (vCdCST = '51') then begin
            clear_e(tFIS_NFITEMIMP);
            putitem_o(tFIS_NFITEMIMP, 'CD_IMPOSTO', 1);
            retrieve_e(tFIS_NFITEMIMP);
            if (xStatus >= 0) then begin
              if (vCdCST = '41') then begin
                vVlSimples := vVlSimples + item_f('VL_ISENTO', tFIS_NFITEMIMP);
              end else begin
                vVlSimples := vVlSimples + item_f('VL_BASECALC', tFIS_NFITEMIMP);
              end;
            end;
          end else begin

            if (gInConsSubTribCredSimp = True) then begin
              clear_e(tFIS_NFITEMIMP);
              putitem_o(tFIS_NFITEMIMP, 'CD_IMPOSTO', 2);
              retrieve_e(tFIS_NFITEMIMP);
              if (xStatus >= 0) then begin
                vVlSimples := vVlSimples + item_f('VL_BASECALC', tFIS_NFITEMIMP);
              end;
            end;
          end;
        end;
        setocc(tFIS_NFITEM, curocc(tFIS_NFITEM) + 1);
      end;
      setocc(tFIS_NFITEM, 1);

      if (vInGravar = True) then begin
        if (vCdCST = '00' ) or (vCdCST = '20' ) or (vCdCST = '41' ) or (vCdCST = '51') then begin
          clear_e(tFIS_NFIMPOSTO);
          putitem_o(tFIS_NFIMPOSTO, 'CD_IMPOSTO', 1);
          retrieve_e(tFIS_NFIMPOSTO);
          if (xStatus >= 0) then begin
            if (vCdCST = '41') then begin
              vVlSimples := vVlSimples + item_f('VL_ISENTO', tFIS_NFIMPOSTO);
            end else begin
              vVlSimples := vVlSimples + item_f('VL_BASECALC', tFIS_NFIMPOSTO);
            end;
          end else begin
            clear_e(tFIS_NFIMPOSTO);
            putitem_o(tFIS_NFIMPOSTO, 'CD_IMPOSTO', 2);
            retrieve_e(tFIS_NFIMPOSTO);
            if (xStatus >= 0) then begin
              if (vCdCST = '41') then begin
                vVlSimples := vVlSimples + item_f('VL_ISENTO', tFIS_NFIMPOSTO);
              end else begin
                vVlSimples := vVlSimples + item_f('VL_BASECALC', tFIS_NFIMPOSTO);
              end;
            end;
          end;
        end else begin
          clear_e(tFIS_NFIMPOSTO);
          putitem_o(tFIS_NFIMPOSTO, 'CD_IMPOSTO', 2);
          retrieve_e(tFIS_NFIMPOSTO);
          if (xStatus >= 0) then begin
            vVlSimples := vVlSimples + item_f('VL_BASECALC', tFIS_NFIMPOSTO);
          end else begin
            clear_e(tFIS_NFIMPOSTO);
            putitem_o(tFIS_NFIMPOSTO, 'CD_IMPOSTO', 1);
            retrieve_e(tFIS_NFIMPOSTO);
            if (xStatus >= 0) then begin
              vVlSimples := vVlSimples + item_f('VL_BASECALC', tFIS_NFIMPOSTO);
            end;
          end;
        end;
      end else begin
        return(0); exit;
      end;

      poCampo := '';
      if (gInOptSimples = 'S') then begin
        gVl12d2 := (vVlSimples - ((vVlSimples * gprReduBaseSimpNacional) / 100)) * gprAliqSimplesNacional / 100;

      end else begin
        gVl12d2 := 0;
      end;
      poCampo := '' + FloatToStr(gVl) + '12d2';

      if (piDsDados <> '')  and (poCampo <> '') then begin
        poCampo := '' + piDsDados + ' ' + poCampo' + ';
      end;

    case 000670;
      if (piValidaCampo = True) then begin
        return(0); exit;
      end;

      vInGravar := False;
      if (gInOptSimples <> 'S') then begin
        return(0); exit;
      end;

      vPos := curocc(tFIS_NFITEM);
      setocc(tFIS_NFITEM, 1);
      while (xStatus >= 0) do begin
        vCdCST := item_f('CD_CST', tFIS_NFITEM)[2 : 2];
        if (vCdCST = '00' ) or (vCdCST = '10' ) or (vCdCST = '20' orvCdCST = '30' ) or (vCdCST = '41' ) or (vCdCST = '51' ) or (vCdCST = '70') then begin
          vInGravar := True;
          break;
        end;
        setocc(tFIS_NFITEM, curocc(tFIS_NFITEM) + 1);
      end;
      setocc(tFIS_NFITEM, 1);

      if (vInGravar = False) then begin
        return(0); exit;
      end;

      poCampo := '';
      if (gInOptSimples = 'S') then begin
        poCampo := '' + gprAliqSimplesNacional' + ';
      end else begin
        gprAliqSimplesNacional := 0;
        poCampo := '' + gprAliqSimplesNacional' + ';
      end;
      if (piDsDados <> '')  and (poCampo <> '') then begin
        poCampo := '' + piDsDados + ' ' + poCampo' + ';
      end;

    case 000099;
      if (piValidaCampo = True) then begin
        return(0); exit;
      end;

      poCampo := '' + item_a('NR_TRANSACAOORI', tFIS_NF) + ';

      if (piDsDados <> '')  and (poCampo <> '') then begin
        poCampo := '' + piDsDados + ' ' + poCampo' + ';
      end;

    end else begincase
      poCampo := '';
      Result := SetStatus(STS_ERROR, 'GEN0001', 'Campo ' + piCodigoCampo + ' não preparado para gravar observação na nota fiscal eletrônica!', cDS_METHOD);
      return(-1); exit;
  endselectcase;

  return(0); exit;

end;

//--------------------------------------------------------------------
function T_FISSVCO024.calculaTotalAliquota(pParams : String) : String;
//--------------------------------------------------------------------
const
  cDS_METHOD = 'ADICIONAL=Operação: T_FISSVCO024.calculaTotalAliquota()';
begin
  putitem_e(tFIS_DIFALIQC, 'VL_DIFALIQ', 0);

  if not (empty(tFIS_DIFALIQI)) then begin
    setocc(tFIS_DIFALIQI, 1);
    while (xStatus >= 0) do begin
      putitem_e(tFIS_DIFALIQC, 'VL_DIFALIQ', item_f('VL_DIFALIQ', tFIS_DIFALIQC) + item_f('VL_DIFALIQ', tFIS_DIFALIQI));
      setocc(tFIS_DIFALIQI, curocc(tFIS_DIFALIQI) + 1);
    end;
  end;

  return(0); exit;
end;

//----------------------------------------------------------
function T_FISSVCO024.gravaLogNF(pParams : String) : String;
//----------------------------------------------------------
const
  cDS_METHOD = 'ADICIONAL=Operação: T_FISSVCO024.gravaLogNF()';
var
  vDsLinhaLog, vDsLstNF, vDsRegistro : String;
  vCdEmpresa, vNrFatura, vNrLinha : Real;
  vDtFatura : TDate;
begin
  vDsLstNF := itemXml('DS_LSTNF', pParams);
  vDsLinhaLog := itemXml('DS_LOG', pParams);

  if (vDsLstNF = '') then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Lista de nota não informada!', cDS_METHOD);
    return(-1); exit;
  end;
  if (vDsLinhaLog = '') then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Logs não informado!', cDS_METHOD);
    return(-1); exit;
  end;

  repeat
    getitem(vDsRegistro, vDsLstNF, 1);
    vCdEmpresa := itemXmlF('CD_EMPRESA', vDsRegistro);
    vNrFatura := itemXmlF('NR_FATURA', vDsRegistro);
    vDtFatura := itemXml('DT_FATURA', vDsRegistro);
    if (vDtFatura = '') then begin
      Result := SetStatus(STS_ERROR, 'GEN0001', 'Data da fatura não informada!', cDS_METHOD);
      return(-1); exit;
    end;
    if (vNrFatura = 0) then begin
      Result := SetStatus(STS_ERROR, 'GEN0001', 'Número da fatura não informada!', cDS_METHOD);
      return(-1); exit;
    end;

    clear_e(tFIS_NF);
    putitem_o(tFIS_NF, 'CD_EMPRESA', vCdEmpresa);
    putitem_o(tFIS_NF, 'NR_FATURA', vNrFatura);
    putitem_o(tFIS_NF, 'DT_FATURA', vDtFatura);
    retrieve_e(tFIS_NF);
    if (xStatus < 0) then begin
      Result := SetStatus(STS_ERROR, 'GEN0001', 'NF ' + FloatToStr(vNrFatura) + ' não cadastrada!', cDS_METHOD);
      return(-1); exit;
    end else begin
      if (empty(tFIS_LOGNF) = False) then begin
        setocc(tFIS_LOGNF, -1);
        vNrLinha := item_f('NR_LINHA', tFIS_LOGNF) + 1;
      end else begin
        vNrLinha := 1;
      end;

      creocc(tFIS_LOGNF, -1);
      putitem_e(tFIS_LOGNF, 'NR_LINHA', vNrLinha);
      putitem_e(tFIS_LOGNF, 'CD_EMPFAT', item_f('CD_EMPFAT', tFIS_NF));
      putitem_e(tFIS_LOGNF, 'CD_OPERADOR', itemXmlF('CD_USUARIO', PARAM_GLB));
      putitem_e(tFIS_LOGNF, 'DT_CADASTRO', Now);
      putitem_e(tFIS_LOGNF, 'DS_LOG', vDsLinhaLog);

      voParams := tFIS_LOGNF.Salvar();
      if (xStatus < 0) then begin
        Result := voParams;
        return(-1); exit;
      end;
    end;

    delitem(vDsLstNF, 1);
  until (vDsLstNF = '');

  return(0); exit;
  end;

//------------------------------------------------------------
function T_FISSVCO024.alteraRemDes(pParams : String) : String;
//------------------------------------------------------------
const
  cDS_METHOD = 'ADICIONAL=Operação: T_FISSVCO024.alteraRemDes()';
var
  vCdEmpresa, vNrFatura, vCdEmpTra, vNrTransacao, vCdPessoa : Real;
  vDtFatura, vDtTransacao : TDate;
  vNrCpfCnpj, vDsNome : String;
  inMantemTransacao : Boolean;
begin
  vCdPessoa := itemXmlF('CD_PESSOA', pParams);

  if (vCdPessoa = 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Cliente novo não informado!', cDS_METHOD);
    return(-1); exit;
  end;

  vNrCpfCnpj := itemXmlF('NR_CPFCNPJ', pParams);
  vDsNome := itemXml('NM_NOME', pParams);
  inMantemTransacao := itemXmlB('IN_MANTEMTRANSACAO', pParams);

  if (vDsNome = '')  and (vNrCpfCnpj = '') then begin
    clear_e(tPES_PESSOA);
    putitem_o(tPES_PESSOA, 'CD_PESSOA', vCdPessoa);
    retrieve_e(tPES_PESSOA);
    if (xStatus >= 0) then begin
      vNrCpfCnpj := item_f('NR_CPFCNPJ', tPES_PESSOA);
      vDsNome := item_a('NM_PESSOA', tPES_PESSOA);
    end else begin
      Result := SetStatus(STS_ERROR, 'GEN0001', 'Cliente ' + FloatToStr(vCdPessoa) + ' não encontrada!', cDS_METHOD);
      return(-1); exit;
    end;
  end;

  vCdEmpresa := itemXmlF('CD_EMPRESA', pParams);
  vNrFatura := itemXmlF('NR_FATURA', pParams);
  vDtFatura := itemXml('DT_FATURA', pParams);

  if (vCdEmpresa = 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Empresa da nota não informada!', cDS_METHOD);
    return(-1); exit;
  end;
  if (vNrFatura = 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Fatura da nota não informada!', cDS_METHOD);
    return(-1); exit;
  end;
  if (vDtFatura = '') then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Data da nota não informada!', cDS_METHOD);
    return(-1); exit;
  end;

  clear_e(tFIS_NF);
  putitem_o(tFIS_NF, 'CD_EMPRESA', vCdEmpresa);
  putitem_o(tFIS_NF, 'NR_FATURA', vNrFatura);
  putitem_o(tFIS_NF, 'DT_FATURA', vDtFatura);
  retrieve_e(tFIS_NF);
  if (xStatus < 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'NF ' + FloatToStr(vNrFatura) + ' não cadastrada!', cDS_METHOD);
    return(-1); exit;
  end;
  putitem_o(tFIS_NF, 'CD_PESSOA', vCdPessoa);
  voParams := tFIS_NF.Salvar();
  if (xStatus < 0) then begin
    Result := voParams;
    return(-1); exit;
  end;
  if (inMantemTransacao = False) then begin
    vCdEmpTra := itemXmlF('CD_EMPTRA', pParams);
    vNrTransacao := itemXmlF('NR_TRANSACAO', pParams);
    vDtTransacao := itemXml('DT_TRANSACAO', pParams);

    if (vCdEmpTra = 0) then begin
      Result := SetStatus(STS_ERROR, 'GEN0001', 'Empresa da transação não informada!', cDS_METHOD);
      return(-1); exit;
    end;
    if (vNrTransacao = 0) then begin
      Result := SetStatus(STS_ERROR, 'GEN0001', 'Nr. da transação não informado!', cDS_METHOD);
      return(-1); exit;
    end;
    if (vDtTransacao = '') then begin
      Result := SetStatus(STS_ERROR, 'GEN0001', 'Data da transação não informada!', cDS_METHOD);
      return(-1); exit;
    end;

    clear_e(tTRA_TRANSACAO);
    putitem_o(tTRA_TRANSACAO, 'CD_EMPRESA', vCdEmpTra);
    putitem_o(tTRA_TRANSACAO, 'NR_TRANSACAO', vNrTransacao);
    putitem_o(tTRA_TRANSACAO, 'DT_TRANSACAO', vDtTransacao);
    retrieve_e(tTRA_TRANSACAO);
    if (xStatus < 0) then begin
      Result := SetStatus(STS_ERROR, 'GEN0001', 'Transação ' + FloatToStr(vNrTransacao) + ' não encontrada na empresa ' + FloatToStr(vCdEmpTra) + '!', cDS_METHOD);
      return(-1); exit;
    end else begin
      putitem_o(tTRA_TRANSACAO, 'CD_PESSOA', vCdPessoa);
      voParams := tTRA_TRANSACAO.Salvar();
      if (xStatus < 0) then begin
        Result := voParams;
        return(-1); exit;
      end;
    end;
  end else if (inMantemTransacao = True) then begin
    clear_e(tTRA_TRANSACAO);
    putitem_o(tTRA_TRANSACAO, 'CD_EMPRESA', item_f('CD_EMPRESAORI', tFIS_NF));
    putitem_o(tTRA_TRANSACAO, 'NR_TRANSACAO', item_f('NR_TRANSACAOORI', tFIS_NF));
    putitem_o(tTRA_TRANSACAO, 'DT_TRANSACAO', item_a('DT_TRANSACAOORI', tFIS_NF));
    retrieve_e(tTRA_TRANSACAO);
    if (xStatus < 0) then begin
      Result := SetStatus(STS_ERROR, 'GEN0001', 'Transação ' + item_a('NR_TRANSACAOORI', tFIS_NF) + ' não encontrada na empresa ' + item_a('CD_EMPRESAORI', tFIS_NF) + '!', cDS_METHOD);
      return(-1); exit;
    end;
  end;
  if (empty(tTRA_REMDES) = False) then begin
    putitem_o(tTRA_REMDES, 'CD_PESSOA', vCdPessoa);
    putitem_o(tTRA_REMDES, 'NM_NOME', vDsNome);
    putitem_o(tTRA_REMDES, 'NR_CPFCNPJ', vNrCpfCnpj);
    voParams := tTRA_REMDES.Salvar();
    if (xStatus < 0) then begin
      Result := voParams;
      return(-1); exit;
    end;
  end;
  if (empty(tFIS_NFREMDES) = False) then begin
    putitem_o(tFIS_NFREMDES, 'CD_PESSOA', vCdPessoa);
    putitem_o(tFIS_NFREMDES, 'NM_NOME', vDsNome);
    putitem_o(tFIS_NFREMDES, 'NR_CPFCNPJ', vNrCpfCnpj);
    voParams := tFIS_NFREMDES.Salvar();
    if (xStatus < 0) then begin
      Result := voParams;
      return(-1); exit;
    end;
  end;

  return(0); exit;
end;

//---------------------------------------------------------------
function T_FISSVCO024.gravaObsNfFisco(pParams : String) : String;
//---------------------------------------------------------------
const
  cDS_METHOD = 'ADICIONAL=Operação: T_FISSVCO024.gravaObsNfFisco()';
var
  vDsLstTransacao, vDsRegistro : String;
  vCdEmpresa, vNrTransacao, vNrLinha : Real;
  vDtTransacao : TDate;
begin
  vDsLstTransacao := itemXml('DS_LSTTRANSACAO', pParams);

  if (vDsLstTransacao = '') then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Lista de transação não informada!', cDS_METHOD);
    return(-1); exit;
  end;

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
      Result := SetStatus(STS_ERROR, 'GEN0001', 'Número da transação não informado!', cDS_METHOD);
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

    if not (empty(tOBS_TRANSFISC)) then begin
      clear_e(tFIS_NF);
      putitem_o(tFIS_NF, 'CD_EMPRESAORI', item_f('CD_EMPRESA', tTRA_TRANSACAO));
      putitem_o(tFIS_NF, 'NR_TRANSACAOORI', item_f('NR_TRANSACAO', tTRA_TRANSACAO));
      putitem_o(tFIS_NF, 'DT_TRANSACAOORI', item_a('DT_TRANSACAO', tTRA_TRANSACAO));
      retrieve_e(tFIS_NF);
      if (xStatus >= 0) then begin
        setocc(tFIS_NF, 1);
        while (xStatus >= 0) do begin
          setocc(tOBS_NFFISCO, -1);
          vNrLinha := item_f('NR_LINHA', tOBS_NFFISCO);
          setocc(tOBS_TRANSFISC, 1);
          while (xStatus >= 0) do begin
            creocc(tOBS_NFFISCO, -1);
            vNrLinha := vNrLinha + 1;
            putitem_e(tOBS_NFFISCO, 'NR_LINHA', vNrLinha);
            putitem_e(tOBS_NFFISCO, 'CD_EMPFAT', item_f('CD_EMPFAT', tTRA_TRANSACAO));
            putitem_e(tOBS_NFFISCO, 'CD_GRUPOEMPRESA', item_f('CD_GRUPOEMPRESA', tFIS_NF));
            putitem_e(tOBS_NFFISCO, 'CD_OPERADOR', itemXmlF('CD_USUARIO', PARAM_GLB));
            item_a('DT_CADASTRO', tOBS_NFFISCO)= Now;
            putitem_e(tOBS_NFFISCO, 'DS_OBSERVACAO', item_a('DS_OBSERVACAO', tOBS_TRANSFISC)[1 : 80]);
            setocc(tOBS_TRANSFISC, curocc(tOBS_TRANSFISC) + 1);
          end;
          setocc(tFIS_NF, curocc(tFIS_NF) + 1);
        end;
      end;
    end;

    delitem(vDsLstTransacao, 1);
  until (vDsLstTransacao = '');

  voParams := tOBS_NFFISCO.Salvar();
  if (xStatus < 0) then begin
    Result := voParams;
    return(-1); exit;
  end;

  return(0); exit;

end;

//----------------------------------------------------------------------
function T_FISSVCO024.gravaItemDevTerceiroNF(pParams : String) : String;
//----------------------------------------------------------------------
const
  cDS_METHOD = 'ADICIONAL=Operação: T_FISSVCO024.gravaItemDevTerceiroNF()';
var
  vCdEmpresa, vNrFatura, vNrItem, vCdProduto, vTpDcto, vCdEmpDcto, vNrDcto : Real;
  vNrSequencia, vTpDevolucao, vTpSituacao, vQtDevolucao, vQtTotal : Real;
  vDtFatura, vDtDcto, vDtDevolucao : TDate;
  vDsLstDev, vDsItemDev : String;
begin
  PARAM_GLB := PARAM_GLB;

  vCdEmpresa := itemXmlF('CD_EMPRESA', pParams);
  vNrFatura := itemXmlF('NR_FATURA', pParams);
  vDtFatura := itemXml('DT_FATURA', pParams);
  vNrItem := itemXmlF('NR_ITEM', pParams);
  vCdProduto := itemXmlF('CD_PRODUTO', pParams);
  vDsLstDev := itemXml('DS_LSTDEVOLUCAO', pParams);

  if (vCdEmpresa = 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Empresa não informada!', cDS_METHOD);
    return(-1); exit;
  end;
  if (vNrFatura = 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Fatura não informado!', cDS_METHOD);
    return(-1); exit;
  end;
  if (vDtFatura = '') then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Data N.F. não informada!', cDS_METHOD);
    return(-1); exit;
  end;
  if (vNrItem = '') then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Número do item na nota ' + FloatToStr(vCdEmpresa) + ' / ' + FloatToStr(vNrFatura) + ' / ' + vDtFatura + ' não informado!', cDS_METHOD);
    return(-1); exit;
  end;
  if (vCdProduto = '') then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Produto na nota ' + FloatToStr(vCdEmpresa) + ' / ' + FloatToStr(vNrFatura) + ' / ' + vDtFatura + ' não informado!', cDS_METHOD);
    return(-1); exit;
  end;
  if (vDsLstDev = '') then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Lista de itens a devolver para a nota ' + FloatToStr(vCdEmpresa) + ' / ' + FloatToStr(vNrFatura) + ' / ' + vDtFatura + ' não informada!', cDS_METHOD);
    return(-1); exit;
  end;

  clear_e(tFIS_NF);
  putitem_o(tFIS_NF, 'CD_EMPRESA', vCdEmpresa);
  putitem_o(tFIS_NF, 'NR_FATURA', vNrFatura);
  putitem_o(tFIS_NF, 'DT_FATURA', vDtFatura);
  retrieve_e(tFIS_NF);
  if (xStatus < 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Nota Fiscal ' + FloatToStr(vCdEmpresa) + ' / ' + FloatToStr(vNrFatura) + ' / ' + vDtFatura + ' não encotrada!', cDS_METHOD);
    return(-1); exit;
  end;

  clear_e(tFIS_NFITEM);
  putitem_o(tFIS_NFITEM, 'NR_ITEM', vNrItem);
  retrieve_e(tFIS_NFITEM);
  if (xStatus < 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Item ' + FloatToStr(vNrItem) + ' da Nota Fiscal ' + FloatToStr(vCdEmpresa) + ' / ' + FloatToStr(vNrFatura) + ' / ' + vDtFatura + ' não encotrada!', cDS_METHOD);
    return(-1); exit;
  end;

  clear_e(tFIS_NFITEMPRO);
  putitem_o(tFIS_NFITEMPRO, 'CD_PRODUTO', vCdProduto);
  retrieve_e(tFIS_NFITEMPRO);
  if (xStatus < 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Produto ' + FloatToStr(vCdProduto) + ' na nota ' + FloatToStr(vCdEmpresa) + ' / ' + FloatToStr(vNrFatura) + ' / ' + vDtFatura + ' não encotrado!', cDS_METHOD);
    return(-1); exit;
  end;

  clear_e(tFIS_NFIDEVT);
  retrieve_e(tFIS_NFIDEVT);
  if (xStatus >= 0) then begin
    voParams := tFIS_NFIDEVT.Excluir();
    if (xStatus < 0) then begin
      Result := voParams;
      return(-1); exit;
    end;
  end else begin
    clear_e(tFIS_NFIDEVT);
  end;

  vQtTotal := 0;
  while (vDsLstDev <> '') do begin
    getitem(vDsItemDev, vDsLstDev, 1);

    vTpDcto := itemXmlF('TP_DCTO', vDsItemDev);
    vCdEmpDcto := itemXmlF('CD_EMPDCTO', vDsItemDev);
    vNrDcto := itemXmlF('NR_DCTO', vDsItemDev);
    vDtDcto := itemXml('DT_DCTO', vDsItemDev);
    vNrSequencia := itemXmlF('NR_SEQUENCIA', vDsItemDev);
    vDtDevolucao := itemXml('DT_DEVOLUCAO', vDsItemDev);
    vTpDevolucao := itemXmlF('TP_DEVOLUCAO', vDsItemDev);
    vTpSituacao := itemXmlF('TP_SITUACAO', vDsItemDev);
    vQtDevolucao := itemXmlF('QT_DEVOLUCAO', vDsItemDev);

      if (vDtDevolucao = '') then begin
        Result := SetStatus(STS_ERROR, 'GEN0001', 'Data de devolução não informada para o produto ' + FloatToStr(vCdProduto) + ' na nota ' + FloatToStr(vCdEmpresa) + ' / ' + FloatToStr(vNrFatura) + ' / ' + vDtFatura + '!', cDS_METHOD);
        return(-1); exit;
      end;
      if (vDtDevolucao > itemXml('DT_SISTEMA', PARAM_GLB)) then begin
        Result := SetStatus(STS_ERROR, 'GEN0001', 'Data de devolução não pode ser maior que a data atual para o produto ' + FloatToStr(vCdProduto) + ' na nota ' + FloatToStr(vCdEmpresa) + ' / ' + FloatToStr(vNrFatura) + ' / ' + vDtFatura + '!', cDS_METHOD);
        return(-1); exit;
      end;
      if (vTpDevolucao = '') then begin
        Result := SetStatus(STS_ERROR, 'GEN0001', 'Tipo de devolução não informado para o produto ' + FloatToStr(vCdProduto) + ' na nota ' + FloatToStr(vCdEmpresa) + ' / ' + FloatToStr(vNrFatura) + ' / ' + vDtFatura + '!', cDS_METHOD);
        return(-1); exit;
      end;
      if (vTpSituacao = '') then begin
        Result := SetStatus(STS_ERROR, 'GEN0001', 'Situação não informada para o produto ' + FloatToStr(vCdProduto) + ' na nota ' + FloatToStr(vCdEmpresa) + ' / ' + FloatToStr(vNrFatura) + ' / ' + vDtFatura + '!!', cDS_METHOD);
        return(-1); exit;
      end;
      if (vNrSequencia = 0) then begin
        Result := SetStatus(STS_ERROR, 'GEN0001', 'Sequência não informada para o produto ' + FloatToStr(vCdProduto) + ' na nota ' + FloatToStr(vCdEmpresa) + ' / ' + FloatToStr(vNrFatura) + ' / ' + vDtFatura + '!!', cDS_METHOD);
        return(-1); exit;
      end;
      if (vTpDcto = 1 ) or (vCdEmpDcto <> '' ) or (vNrDcto <> '' ) or (vDtDcto <> '') then begin
        if (vCdEmpDcto = '') then begin
          Result := SetStatus(STS_ERROR, 'GEN0001', 'Empresa do documento não informada para o produto ' + FloatToStr(vCdProduto) + ' na nota ' + FloatToStr(vCdEmpresa) + ' / ' + FloatToStr(vNrFatura) + ' / ' + vDtFatura + '!', cDS_METHOD);
          return(-1); exit;
        end;
        if (vNrDcto = '') then begin
          Result := SetStatus(STS_ERROR, 'GEN0001', 'Número do documento não informado para o produto ' + FloatToStr(vCdProduto) + ' na nota ' + FloatToStr(vCdEmpresa) + ' / ' + FloatToStr(vNrFatura) + ' / ' + vDtFatura + '!', cDS_METHOD);
          return(-1); exit;
        end;
        if (vDtDcto = '') then begin
          Result := SetStatus(STS_ERROR, 'GEN0001', 'Data do documento não informada para o produto ' + FloatToStr(vCdProduto) + ' na nota ' + FloatToStr(vCdEmpresa) + ' / ' + FloatToStr(vNrFatura) + ' / ' + vDtFatura + '!', cDS_METHOD);
          return(-1); exit;
        end;
        if (vDtDcto > itemXml('DT_SISTEMA', PARAM_GLB)) then begin
          Result := SetStatus(STS_ERROR, 'GEN0001', 'Data do documento não pode ser maior que a data atual para o produto ' + FloatToStr(vCdProduto) + ' na nota ' + FloatToStr(vCdEmpresa) + ' / ' + FloatToStr(vNrFatura) + ' / ' + vDtFatura + '!', cDS_METHOD);
          return(-1); exit;
        end;

        clear_e(tTRA_TRANSACAO);
        putitem_e(tTRA_TRANSACAO, 'CD_EMPRESA', vCdEmpDcto);
        putitem_e(tTRA_TRANSACAO, 'NR_TRANSACAO', vNrDcto);
        putitem_e(tTRA_TRANSACAO, 'DT_TRANSACAO', vDtDcto);
        retrieve_e(tTRA_TRANSACAO);
        if (xStatus < 0) then begin
          Result := SetStatus(STS_ERROR, 'GEN0001', 'Documento não encontrado para o produto ' + FloatToStr(vCdProduto) + ' na nota ' + FloatToStr(vCdEmpresa) + ' / ' + FloatToStr(vNrFatura) + ' / ' + vDtFatura + '!', cDS_METHOD);
          return(-1); exit;
        end;
      end;

      delitem(vDsItemDev, 'CD_EMPRESA');
      delitem(vDsItemDev, 'NR_FATURA');
      delitem(vDsItemDev, 'DT_FATURA');
      delitem(vDsItemDev, 'NR_ITEM');
      delitem(vDsItemDev, 'CD_PRODUTO');
      delitem(vDsItemDev, 'NR_SEQUENCIA');

      creocc(tFIS_NFIDEVT, -1);
      getlistitensocc_e(vDsItemDev, tFIS_NFIDEVT);

      putitem_e(tFIS_NFIDEVT, 'NR_SEQUENCIA', vNrSequencia);
      putitem_e(tFIS_NFIDEVT, 'CD_EMPFAT', item_f('CD_EMPFAT', tFIS_NF));
      putitem_e(tFIS_NFIDEVT, 'CD_GRUPOEMPRESA', item_f('CD_GRUPOEMPRESA', tFIS_NF));
      putitem_e(tFIS_NFIDEVT, 'QT_DEVOLUCAO', vQtDevolucao);
      putitem_e(tFIS_NFIDEVT, 'CD_OPERADOR', itemXmlF('CD_USUARIO', PARAM_GLB));
      putitem_e(tFIS_NFIDEVT, 'DT_CADASTRO', Now);

      if (vTpSituacao = 1) then begin
        vQtTotal := vQtTotal + vQtDevolucao;
        if (vQtTotal > item_f('QT_FATURADO', tFIS_NFITEMPRO)) then begin
          Result := SetStatus(STS_ERROR, 'GEN0001', 'Quantidade máxima de devolução atingida para o produto ' + FloatToStr(vCdProduto) + ' na nota ' + FloatToStr(vCdEmpresa) + ' / ' + FloatToStr(vNrFatura) + ' / ' + vDtFatura + '!', cDS_METHOD);
          return(-1); exit;
        end;
      end;

    delitem(vDsLstDev, 1);
  end;

  if not (empty(tFIS_NFIDEVT)) then begin
    voParams := tFIS_NFIDEVT.Salvar();
    if (xStatus < 0) then begin
      Result := voParams;
      return(-1); exit;
    end;
  end;

  return(0); exit;
end;

//----------------------------------------------------------------
function T_FISSVCO024.gravaDespesaItem(pParams : String) : String;
//----------------------------------------------------------------
const
  cDS_METHOD = 'ADICIONAL=Operação: T_FISSVCO024.gravaDespesaItem()';
var
  vCdEmpresa, vNrFatura, vNrItem, vCdProduto, vCdDespesaItem, vCdCCusto, vPrRateio : Real;
  vDtFatura : TDate;
  vDsLstDespesa, vDsRegistro : String;
begin
  vCdEmpresa := itemXmlF('CD_EMPRESA', pParams);
  vNrFatura := itemXmlF('NR_FATURA', pParams);
  vDtFatura := itemXml('DT_FATURA', pParams);
  vNrItem := itemXmlF('NR_ITEM', pParams);
  vCdProduto := itemXmlF('CD_PRODUTO', pParams);
  vDsLstDespesa := itemXml('DS_LSTDEDESPESA', pParams);
  vCdDespesaItem := '';
  vCdCCusto := '';

  if (vCdEmpresa = 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Empresa não informada!', cDS_METHOD);
    return(-1); exit;
  end;
  if (vNrFatura = 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Fatura não informado!', cDS_METHOD);
    return(-1); exit;
  end;
  if (vDtFatura = '') then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Data N.F. não informada!', cDS_METHOD);
    return(-1); exit;
  end;
  if (vNrItem = '') then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Número do item na nota ' + FloatToStr(vCdEmpresa) + ' / ' + FloatToStr(vNrFatura) + ' / ' + vDtFatura + ' não informado!', cDS_METHOD);
    return(-1); exit;
  end;
  if (vCdProduto = '') then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Produto na nota ' + FloatToStr(vCdEmpresa) + ' / ' + FloatToStr(vNrFatura) + ' / ' + vDtFatura + ' não informado!', cDS_METHOD);
    return(-1); exit;
  end;

  clear_e(tFIS_NF);
  putitem_o(tFIS_NF, 'CD_EMPRESA', vCdEmpresa);
  putitem_o(tFIS_NF, 'NR_FATURA', vNrFatura);
  putitem_o(tFIS_NF, 'DT_FATURA', vDtFatura);
  retrieve_e(tFIS_NF);
  if (xStatus < 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Nota Fiscal ' + FloatToStr(vCdEmpresa) + ' / ' + FloatToStr(vNrFatura) + ' / ' + vDtFatura + ' não encotrada!', cDS_METHOD);
    return(-1); exit;
  end;

  clear_e(tFIS_NFITEM);
  putitem_o(tFIS_NFITEM, 'NR_ITEM', vNrItem);
  retrieve_e(tFIS_NFITEM);
  if (xStatus < 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Item ' + FloatToStr(vNrItem) + ' da Nota Fiscal ' + FloatToStr(vCdEmpresa) + ' / ' + FloatToStr(vNrFatura) + ' / ' + vDtFatura + ' não encotrada!', cDS_METHOD);
    return(-1); exit;
  end;

  clear_e(tFIS_NFITEMPRO);
  putitem_o(tFIS_NFITEMPRO, 'CD_PRODUTO', vCdProduto);
  retrieve_e(tFIS_NFITEMPRO);
  if (xStatus < 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Produto ' + FloatToStr(vCdProduto) + ' na nota ' + FloatToStr(vCdEmpresa) + ' / ' + FloatToStr(vNrFatura) + ' / ' + vDtFatura + ' não encotrado!', cDS_METHOD);
    return(-1); exit;
  end;

  if not (empty(tFIS_NFITEMDES)) then begin
    voParams := tFIS_NFITEMDES.Excluir();
    if (xStatus < 0) then begin
      Result := voParams;
      return(-1); exit;
    end;
  end;
  if (vDsLstDespesa <> '') then begin
    repeat
      getitem(vDsRegistro, vDsLstDespesa, 1);

      vCdDespesaItem := itemXmlF('CD_DESPESAITEM', vDsRegistro);
      if (vCdDespesaItem = '') then begin
        Result := SetStatus(STS_ERROR, 'GEN0001', 'Despesa inválida!', cDS_METHOD);
        return(-1); exit;
      end;

      vCdCCusto := itemXmlF('CD_CCUSTO', vDsRegistro);
      if (vCdCCusto = '') then begin
        Result := SetStatus(STS_ERROR, 'GEN0001', 'Centro de custo inválido!', cDS_METHOD);
        return(-1); exit;
      end;

      vPrRateio := itemXmlF('PR_RATEIO', vDsRegistro);
      if (vPrRateio > 0) then begin
        creocc(tFIS_NFITEMDES, -1);
        putitem_e(tFIS_NFITEMDES, 'CD_EMPRESA', vCdEmpresa);
        putitem_e(tFIS_NFITEMDES, 'NR_FATURA', vNrFatura);
        putitem_e(tFIS_NFITEMDES, 'DT_FATURA', vDtFatura);
        putitem_e(tFIS_NFITEMDES, 'NR_ITEM', vNrItem);
        putitem_e(tFIS_NFITEMDES, 'CD_PRODUTO', vCdProduto);
        putitem_e(tFIS_NFITEMDES, 'CD_DESPESAITEM', vCdDespesaItem);
        putitem_e(tFIS_NFITEMDES, 'CD_CCUSTO', vCdCCusto);
        retrieve_o(tFIS_NFITEMDES);
        if (xStatus = -7) then begin
          retrieve_x(tFIS_NFITEMDES);
        end;

        putitem_e(tFIS_NFITEMDES, 'CD_OPERADOR', itemXmlF('CD_USUARIO', PARAM_GLB));
        putitem_e(tFIS_NFITEMDES, 'DT_CADASTRO', Now);
        putitem_e(tFIS_NFITEMDES, 'PR_RATEIO', item_f('PR_RATEIO', tFIS_NFITEMDES) + vPrRateio);
      end;
      delitem(vDsLstDespesa, 1);
    until (vDsLstDespesa = '');

    voParams := tFIS_NFITEMDES.Salvar();
    if (xStatus < 0) then begin
      Result := voParams;
      return(-1); exit;
    end;
  end;

  return(0); exit;
end;

//-----------------------------------------------------------------------------
function T_FISSVCO024.gravaItemConsignacaoTransacao(pParams : String) : String;
//-----------------------------------------------------------------------------
const
  cDS_METHOD = 'ADICIONAL=Operação: T_FISSVCO024.gravaItemConsignacaoTransacao()';
var
  vCdEmpresa, vNrFatura, vNrItem, vCdProduto, vCdEmpTra, vNrTransacao : Real;
  vDtFatura, vDtTransacao : TDate;
begin
  vCdEmpresa := itemXmlF('CD_EMPRESA', pParams);
  vNrFatura := itemXmlF('NR_FATURA', pParams);
  vDtFatura := itemXml('DT_FATURA', pParams);
  vNrItem := itemXmlF('NR_ITEM', pParams);
  vCdProduto := itemXmlF('CD_PRODUTO', pParams);
  vCdEmpTra := itemXmlF('CD_EMPTRA', pParams);
  vNrTransacao := itemXmlF('NR_TRANSACAO', pParams);
  vDtTransacao := itemXml('DT_TRANSACAO', pParams);

  if (vCdEmpresa = 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Empresa da nota não informada!', cDS_METHOD);
    return(-1); exit;
  end;
  if (vNrFatura = 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Fatura não informado!', cDS_METHOD);
    return(-1); exit;
  end;
  if (vDtFatura = '') then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Data N.F. não informada!', cDS_METHOD);
    return(-1); exit;
  end;
  if (vNrItem = '') then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Número do item na nota ' + FloatToStr(vCdEmpresa) + ' / ' + FloatToStr(vNrFatura) + ' / ' + vDtFatura + ' não informado!', cDS_METHOD);
    return(-1); exit;
  end;
  if (vCdProduto = '') then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Produto na nota ' + FloatToStr(vCdEmpresa) + ' / ' + FloatToStr(vNrFatura) + ' / ' + vDtFatura + ' não informado!', cDS_METHOD);
    return(-1); exit;
  end;
  if (vCdEmpTra = 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Empresa da transação não informada!', cDS_METHOD);
    return(-1); exit;
  end;
  if (vNrTransacao = 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Número da transação não informada!', cDS_METHOD);
    return(-1); exit;
  end;
  if (vDtTransacao = '') then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Data da transação não informada!', cDS_METHOD);
    return(-1); exit;
  end;

  clear_e(tFIS_ITEMCONSI);
  creocc(tFIS_ITEMCONSI, -1);
  putitem_e(tFIS_ITEMCONSI, 'CD_EMPRESA', vCdEmpresa);
  putitem_e(tFIS_ITEMCONSI, 'NR_FATURA', vNrFatura);
  putitem_e(tFIS_ITEMCONSI, 'DT_FATURA', vDtFatura);
  putitem_e(tFIS_ITEMCONSI, 'NR_ITEM', vNrItem);
  putitem_e(tFIS_ITEMCONSI, 'CD_PRODUTO', vCdProduto);
  putitem_e(tFIS_ITEMCONSI, 'CD_EMPTRA', vCdEmpTra);
  putitem_e(tFIS_ITEMCONSI, 'NR_TRANSACAO', vNrTransacao);
  putitem_e(tFIS_ITEMCONSI, 'DT_TRANSACAO', vDtTransacao);
  retrieve_o(tFIS_ITEMCONSI);
  if (xStatus = -7) then begin
    retrieve_x(tFIS_ITEMCONSI);
  end;

  putitem_e(tFIS_ITEMCONSI, 'CD_OPERADOR', itemXmlF('CD_USUARIO', PARAM_GLB));
  putitem_e(tFIS_ITEMCONSI, 'DT_CADASTRO', Now);

  voParams := tFIS_ITEMCONSI.Salvar();
  if (xStatus < 0) then begin
    Result := voParams;
    return(-1); exit;
  end;

  return(0); exit;
end;

//----------------------------------------------------------------
function T_FISSVCO024.gravaFisNfItemVl(pParams : String) : String;
//----------------------------------------------------------------
const
  cDS_METHOD = 'ADICIONAL=Operação: T_FISSVCO024.gravaFisNfItemVl()';
var
  vCdEmpresa, vNrFatura, vNrItem, vCdProduto : Real;
  vDtFatura : TDate;
  vDsLstValor, vDsRegistro : String;
begin
  vCdEmpresa := itemXmlF('CD_EMPRESA', pParams);
  vNrFatura := itemXmlF('NR_FATURA', pParams);
  vDtFatura := itemXml('DT_FATURA', pParams);
  vNrItem := itemXmlF('NR_ITEM', pParams);
  vCdProduto := itemXmlF('CD_PRODUTO', pParams);
  vDsLstValor := itemXml('DS_LSTVALOR', pParams);

  if (vCdEmpresa = 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Empresa da nota não informada!', cDS_METHOD);
    return(-1); exit;
  end;
  if (vNrFatura = 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Fatura da nota não informada!', cDS_METHOD);
    return(-1); exit;
  end;
  if (vDtFatura = '') then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Data da nota não informada!', cDS_METHOD);
    return(-1); exit;
  end;

  clear_e(tFIS_NF);
  putitem_o(tFIS_NF, 'CD_EMPRESA', vCdEmpresa);
  putitem_o(tFIS_NF, 'NR_FATURA', vNrFatura);
  putitem_o(tFIS_NF, 'DT_FATURA', vDtFatura);
  retrieve_e(tFIS_NF);
  if (xStatus < 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'NF ' + FloatToStr(vNrFatura) + ' não cadastrada!', cDS_METHOD);
    return(-1); exit;
  end;

  clear_e(tFIS_NFITEM);
  putitem_o(tFIS_NFITEM, 'CD_EMPRESA', vCdEmpresa);
  putitem_o(tFIS_NFITEM, 'NR_FATURA', vNrFatura);
  putitem_o(tFIS_NFITEM, 'DT_FATURA', vDtFatura);
  putitem_o(tFIS_NFITEM, 'NR_ITEM', vNrItem);
  retrieve_e(tFIS_NFITEM);
  if (xStatus < 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Item ' + FloatToStr(vNrItem) + ' da NF ' + FloatToStr(vNrFatura) + ' não cadastrado!', cDS_METHOD);
    return(-1); exit;
  end;

  clear_e(tFIS_NFITEMPRO);
  putitem_o(tFIS_NFITEMPRO, 'CD_EMPRESA', vCdEmpresa);
  putitem_o(tFIS_NFITEMPRO, 'NR_FATURA', vNrFatura);
  putitem_o(tFIS_NFITEMPRO, 'DT_FATURA', vDtFatura);
  putitem_o(tFIS_NFITEMPRO, 'NR_ITEM', vNrItem);
  putitem_o(tFIS_NFITEMPRO, 'CD_PRODUTO', vCdProduto);
  retrieve_e(tFIS_NFITEMPRO);
  if (xStatus < 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Produto para item ' + FloatToStr(vNrItem) + ' NF ' + FloatToStr(vNrFatura) + ' não cadastrada!', cDS_METHOD);
    return(-1); exit;
  end;

  voParams := tFIS_NFITEMVL.Excluir();
  if (xStatus < 0) then begin
    Result := voParams;
    return(-1); exit;
  end;
  if (vDsLstValor <> '') then begin
    repeat
      getitem(vDsRegistro, vDsLstValor, 1);

      creocc(tFIS_NFITEMVL, -1);
      getlistitensocc_e(vDsRegistro, tFIS_NFITEMVL);
      putitem_e(tFIS_NFITEMVL, 'CD_OPERADOR', itemXmlF('CD_USUARIO', PARAM_GLB));
      putitem_e(tFIS_NFITEMVL, 'DT_CADASTRO', Now);

      delitem(vDsLstValor, 1);
    until(vDsLstValor = '');
  end;

  voParams := tFIS_NFITEMVL.Salvar();
  if (xStatus < 0) then begin
    Result := voParams;
    return(-1); exit;
  end;

  return(0); exit;
end;

//----------------------------------------------------------------------
function T_FISSVCO024.vinculaLoteTransacaoNF(pParams : String) : String;
//----------------------------------------------------------------------
const
  cDS_METHOD = 'ADICIONAL=Operação: T_FISSVCO024.vinculaLoteTransacaoNF()';
var
  vCdEmpresa, vNrFatura, vNrNsu : Real;
  vDtFatura : TDate;
begin
  vCdEmpresa := itemXmlF('CD_EMPRESA', pParams);
  vNrFatura := itemXmlF('NR_FATURA', pParams);
  vDtFatura := itemXml('DT_FATURA', pParams);

  if (vCdEmpresa = 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Empresa da nota não informada!', cDS_METHOD);
    return(-1); exit;
  end;
  if (vNrFatura = 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Fatura da nota não informada!', cDS_METHOD);
    return(-1); exit;
  end;
  if (vDtFatura = '') then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Data da nota não informada!', cDS_METHOD);
    return(-1); exit;
  end;

  clear_e(tPRD_LOTEINF);

  clear_e(tFIS_NF);
  putitem_o(tFIS_NF, 'CD_EMPRESA', vCdEmpresa);
  putitem_o(tFIS_NF, 'NR_FATURA', vNrFatura);
  putitem_o(tFIS_NF, 'DT_FATURA', vDtFatura);
  retrieve_e(tFIS_NF);
  if (xStatus < 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'NF ' + FloatToStr(vNrFatura) + ' não cadastrada!', cDS_METHOD);
    return(-1); exit;
  end else if (item_f('CD_EMPRESAORI', tFIS_NF) <> 0 ) and (item_f('NR_TRANSACAOORI', tFIS_NF) <> 0 ) and (item_a('DT_TRANSACAOORI', tFIS_NF) <> '') then begin
    clear_e(tTRA_ITEMLOTE);
    putitem_o(tTRA_ITEMLOTE, 'CD_EMPRESA', item_f('CD_EMPRESAORI', tFIS_NF));
    putitem_o(tTRA_ITEMLOTE, 'NR_TRANSACAO', item_f('NR_TRANSACAOORI', tFIS_NF));
    putitem_o(tTRA_ITEMLOTE, 'DT_TRANSACAO', item_a('DT_TRANSACAOORI', tFIS_NF));
    retrieve_e(tTRA_ITEMLOTE);
    if (xStatus >= 0) then begin
      setocc(tTRA_ITEMLOTE, 1);
      while (xStatus >= 0) do begin
        creocc(tPRD_LOTEINF, -1);
        putitem_e(tPRD_LOTEINF, 'CD_EMPRESA', item_f('CD_EMPLOTE', tTRA_ITEMLOTE));
        putitem_e(tPRD_LOTEINF, 'NR_LOTE', item_f('NR_LOTE', tTRA_ITEMLOTE));
        putitem_e(tPRD_LOTEINF, 'NR_ITEM', item_f('NR_ITEMLOTE', tTRA_ITEMLOTE));
        putitem_e(tPRD_LOTEINF, 'CD_EMPRESANF', vCdEmpresa);
        putitem_e(tPRD_LOTEINF, 'DT_FATURA', vDtFatura);
        putitem_e(tPRD_LOTEINF, 'NR_FATURA', vNrFatura);
        retrieve_o(tPRD_LOTEINF);
        if (xStatus = -7) then begin
          retrieve_x(tPRD_LOTEINF);
        end;

        putitem_e(tPRD_LOTEINF, 'CD_OPERADOR', itemXmlF('CD_USUARIO', PARAM_GLB));
        putitem_e(tPRD_LOTEINF, 'DT_CADASTRO', Now);

        setocc(tTRA_ITEMLOTE, curocc(tTRA_ITEMLOTE) + 1);
      end;

      voParams := tPRD_LOTEINF.Salvar();
      if (xStatus < 0) then begin
        Result := voParams;
        return(-1); exit;
      end;
    end;
  end;

  return(0); exit;
end;

//-----------------------------------------------------------
function T_FISSVCO024.gravaObsNfe(pParams : String) : String;
//-----------------------------------------------------------
const
  cDS_METHOD = 'ADICIONAL=Operação: T_FISSVCO024.gravaObsNfe()';
var
  vInValidaCampo : Boolean;
  vDtFatura : TDate;
  vCdEmpresa, vNrFatura, vCdModeloNf, vNrLinha : Real;
  vDsDadosItem, vDsCampo : String;
begin
  vCdEmpresa := itemXmlF('CD_EMPRESA', pParams);
  vNrFatura := itemXmlF('NR_FATURA', pParams);
  vDtFatura := itemXml('DT_FATURA', pParams);
  vCdModeloNf := itemXmlF('CD_MODELONF', pParams);
  vInValidaCampo := False;

  if (vCdEmpresa = 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Empresa da nota fiscal não informada!', cDS_METHOD);
    return(-1); exit;
  end;
  if (vNrFatura = 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Fatura da nota fiscal não informada!', cDS_METHOD);
    return(-1); exit;
  end;
  if (vDtFatura = '') then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Data da nota fiscal não informada!', cDS_METHOD);
    return(-1); exit;
  end;
  if (vCdModeloNf = '') then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Modelo da nota fiscal não informado!', cDS_METHOD);
    return(-1); exit;
  end;

  voParams := getParam(viParams); (* pParams *) (viParams); (* * vCdEmpresa, 'gravaObsNfe' *)
  if (xStatus < 0) then begin
    Result := voParams;
    return(-1); exit;
  end;

  clear_e(tFIS_NF);
  putitem_o(tFIS_NF, 'CD_EMPRESA', vCdEmpresa);
  putitem_o(tFIS_NF, 'NR_FATURA', vNrFatura);
  putitem_o(tFIS_NF, 'DT_FATURA', vDtFatura);
  retrieve_e(tFIS_NF);
  if (xStatus >= 0) then begin
    sort_e(tOBS_NF, '    sort/e , NR_LINHA;');
    setocc(tOBS_NF, -1);
    vNrLinha := item_f('NR_LINHA', tOBS_NF);

    clear_e(tGER_MODNFC);
    putitem_o(tGER_MODNFC, 'CD_MODELONF', vCdModeloNf);
    retrieve_e(tGER_MODNFC);
    if (xStatus >= 0) then begin
      clear_e(tGER_MODNFE);
      putitem_o(tGER_MODNFE, 'TP_CAMPO', 1);
      retrieve_e(tGER_MODNFE);
      if (xStatus >= 0) then begin
        setocc(tGER_MODNFE, 1);
        while (xStatus >= 0) do begin
          voParams := montaCampo(viParams); (* item_f('CD_CAMPO', tGER_MODNFE), item_f('NR_TAMANHO', tGER_MODNFE), item_a('DS_DADOS', tGER_MODNFE), vInValidaCampo, vDsCampo *)
          if (xStatus < 0) then begin
            Result := voParams;
            return(-1); exit;
          end;
          if (vDsCampo <> '') then begin
            vNrLinha := vNrLinha + 1;
            creocc(tOBS_NF, -1);
            putitem_e(tOBS_NF, 'NR_LINHA', vNrLinha);
            putitem_e(tOBS_NF, 'CD_EMPFAT', item_f('CD_EMPFAT', tFIS_NF));
            putitem_e(tOBS_NF, 'CD_GRUPOEMPRESA', item_f('CD_GRUPOEMPRESA', tFIS_NF));
            putitem_e(tOBS_NF, 'CD_OPERADOR', itemXmlF('CD_USUARIO', PARAM_GLB));
            putitem_e(tOBS_NF, 'DT_CADASTRO', Now);
            putitem_e(tOBS_NF, 'DS_OBSERVACAO', vDsCampo[1:80]);
          end;
          setocc(tGER_MODNFE, curocc(tGER_MODNFE) + 1);
        end;

        if not (empty(tOBS_NF)) then begin
          voParams := tOBS_NF.Salvar();
          if (xStatus < 0) then begin
            Result := voParams;
            return(-1); exit;
          end;
        end;
      end;
    end;
  end;

  clear_e(tFIS_NFITEMAD);
  setocc(tFIS_NFITEM, 1);
  while (xStatus >= 0) do begin
    vDsDadosItem := '';
    clear_e(tGER_MODNFC);
    putitem_o(tGER_MODNFC, 'CD_MODELONF', vCdModeloNf);
    retrieve_e(tGER_MODNFC);
    if (xStatus >= 0) then begin
      clear_e(tGER_MODNFE);
      putitem_o(tGER_MODNFE, 'TP_CAMPO', 2);
      retrieve_e(tGER_MODNFE);
      if (xStatus >= 0) then begin
        setocc(tGER_MODNFE, 1);
        while (xStatus >= 0) do begin
          voParams := montaCampo(viParams); (* item_f('CD_CAMPO', tGER_MODNFE), item_f('NR_TAMANHO', tGER_MODNFE), item_a('DS_DADOS', tGER_MODNFE), vInValidaCampo, vDsCampo *)
          if (xStatus < 0) then begin
            Result := voParams;
            return(-1); exit;
          end;
          if (vDsCampo <> '') then begin
            if (vDsDadosItem = '') then begin
              vDsDadosItem := vDsCampo;
            end else begin
              vDsDadosItem := '' + vDsDadosItem + ' - ' + vDsCampo' + ';
            end;
          end;
          setocc(tGER_MODNFE, curocc(tGER_MODNFE) + 1);
        end;
        if (vDsDadosItem <> '') then begin
          creocc(tFIS_NFITEMAD, -1);
          putitem_e(tFIS_NFITEMAD, 'CD_EMPRESA', item_f('CD_EMPRESA', tFIS_NFITEM));
          putitem_e(tFIS_NFITEMAD, 'NR_FATURA', item_f('NR_FATURA', tFIS_NFITEM));
          putitem_e(tFIS_NFITEMAD, 'DT_FATURA', item_a('DT_FATURA', tFIS_NFITEM));
          putitem_e(tFIS_NFITEMAD, 'NR_ITEM', item_f('NR_ITEM', tFIS_NFITEM));
          retrieve_o(tFIS_NFITEMAD);
          if (xStatus = -7) then begin
            retrieve_x(tFIS_NFITEMAD);
          end;
          putitem_e(tFIS_NFITEMAD, 'CD_OPERADOR', itemXmlF('CD_USUARIO', PARAM_GLB));
          putitem_e(tFIS_NFITEMAD, 'DT_CADASTRO', Now);
          putitem_e(tFIS_NFITEMAD, 'DS_DADOSADIC', vDsDadosItem[1:2000]);
        end;
      end;
    end;
    setocc(tFIS_NFITEM, curocc(tFIS_NFITEM) + 1);
  end;

  if not (empty(tFIS_NFITEMAD)) then begin
    voParams := tFIS_NFITEMAD.Salvar();
    if (xStatus < 0) then begin
      Result := voParams;
      return(-1); exit;
    end;
  end;

  return(0); exit;

end;

//--------------------------------------------------------------
function T_FISSVCO024.validaCampoNfe(pParams : String) : String;
//--------------------------------------------------------------
const
  cDS_METHOD = 'ADICIONAL=Operação: T_FISSVCO024.validaCampoNfe()';
var
  vInValidaCampo : Boolean;
  vCdCampo : Real;
  vDsCampo : String;
begin
  vCdCampo := itemXmlF('CD_CAMPO', pParams);
  vInValidaCampo := True;

  if (vCdCampo = '') then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Código do campo não informado!', cDS_METHOD);
    return(-1); exit;
  end;

  voParams := montaCampo(viParams); (* vCdCampo, '', '', vInValidaCampo, vDsCampo *)
  if (xStatus < 0) then begin
    Result := voParams;
    return(-1); exit;
  end;

  return(0); exit;

end;

//-----------------------------------------------------------------------
function T_FISSVCO024.buscaNrDiaCompensacaoNF(pParams : String) : String;
//-----------------------------------------------------------------------
const
  cDS_METHOD = 'ADICIONAL=Operação: T_FISSVCO024.buscaNrDiaCompensacaoNF()';
var
  vCdEmpresa, vNrFatura, vNrDia : Real;
  vDtFatura : TDate;
  vInDia : Boolean;
begin
  vCdEmpresa := itemXmlF('CD_EMPRESA', pParams);
  vNrFatura := itemXmlF('NR_FATURA', pParams);
  vDtFatura := itemXml('DT_FATURA', pParams);

  if (vCdEmpresa = 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Empresa da nota não informada!', cDS_METHOD);
    return(-1); exit;
  end;
  if (vNrFatura = 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Fatura da nota não informada!', cDS_METHOD);
    return(-1); exit;
  end;
  if (vDtFatura = '') then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Data da nota não informada!', cDS_METHOD);
    return(-1); exit;
  end;

  clear_e(tFIS_NF);
  putitem_o(tFIS_NF, 'CD_EMPRESA', vCdEmpresa);
  putitem_o(tFIS_NF, 'NR_FATURA', vNrFatura);
  putitem_o(tFIS_NF, 'DT_FATURA', vDtFatura);
  retrieve_e(tFIS_NF);
  if (xStatus < 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'NF ' + FloatToStr(vNrFatura) + ' não cadastrada!', cDS_METHOD);
    return(-1); exit;
  end;

  clear_e(tTRA_TRANSACAD);
  putitem_o(tTRA_TRANSACAD, 'CD_EMPRESA', item_f('CD_EMPRESAORI', tFIS_NF));
  putitem_o(tTRA_TRANSACAD, 'NR_TRANSACAO', item_f('NR_TRANSACAOORI', tFIS_NF));
  putitem_o(tTRA_TRANSACAD, 'DT_TRANSACAO', item_a('DT_TRANSACAOORI', tFIS_NF));
  retrieve_e(tTRA_TRANSACAD);
  if (xStatus >= 0) then begin
    if (item_a('DT_BASEPARCELA', tTRA_TRANSACAD) <> '') then begin
      vNrDia := item_a('DT_BASEPARCELA', tTRA_TRANSACAD) - item_a('DT_EMISSAO', tFIS_NF);
      vInDia := True;
    end;
  end;

  Result := '';
  putitemXml(Result, 'NR_DIA', vNrDia);

  return(0); exit;
end;

//---------------------------------------------------------------------
function T_FISSVCO024.gravaDiferencialAliqC(pParams : String) : String;
//---------------------------------------------------------------------
const
  cDS_METHOD = 'ADICIONAL=Operação: T_FISSVCO024.gravaDiferencialAliqC()';
var
  vCdEmpresa, vNrFatura, vCdDetalhamento : Real;
  vDtFatura : TDate;
begin
  vCdEmpresa := itemXmlF('CD_EMPRESA', pParams);
  vNrFatura := itemXmlF('NR_FATURA', pParams);
  vDtFatura := itemXml('DT_FATURA', pParams);
  vCdDetalhamento := itemXmlF('CD_DETALHAMENTO', pParams);

  if (vCdEmpresa = 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Empresa da nota não informada!', cDS_METHOD);
    return(-1); exit;
  end;
  if (vNrFatura = 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Fatura da nota não informada!', cDS_METHOD);
    return(-1); exit;
  end;
  if (vDtFatura = '') then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Data da nota não informada!', cDS_METHOD);
    return(-1); exit;
  end;
  if (vCdDetalhamento = 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Detalhamento não informado!', cDS_METHOD);
    return(-1); exit;
  end;

  clear_e(tFIS_NF);
  putitem_o(tFIS_NF, 'CD_EMPRESA', vCdEmpresa);
  putitem_o(tFIS_NF, 'NR_FATURA', vNrFatura);
  putitem_o(tFIS_NF, 'DT_FATURA', vDtFatura);
  retrieve_e(tFIS_NF);
  if (xStatus < 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Nota Fiscal ' + FloatToStr(vCdEmpresa) + ' / ' + FloatToStr(vNrFatura) + ' / ' + vDtFatura + ' não encontrada!', cDS_METHOD);
    return(-1); exit;
  end;

  clear_e(tFIS_DIFALIQC);
  putitem_o(tFIS_DIFALIQC, 'CD_DETALHAMENTO', vCdDetalhamento);
  retrieve_e(tFIS_DIFALIQC);
  if (xStatus >= 0) then begin
    voParams := tFIS_DIFALIQC.Excluir();
    if (xStatus < 0) then begin
      Result := voParams;
      return(-1); exit;
    end;
  end;

  getlistitensocc_e(pParams, tFIS_DIFALIQC);
  item_f('CD_OPERADOR', tFIS_DIFALIQC)= itemXmlF('CD_USUARIO', PARAM_GLB);
  item_a('DT_CADASTRO', tFIS_DIFALIQC)= Now;

  voParams := tFIS_NF.Salvar();
  if (xStatus < 0) then begin
    Result := voParams;
    return(-1); exit;
  end;

  return(0); exit;
end;

//---------------------------------------------------------------------
function T_FISSVCO024.gravaDiferencialAliqI(pParams : String) : String;
//---------------------------------------------------------------------
const
  cDS_METHOD = 'ADICIONAL=Operação: T_FISSVCO024.gravaDiferencialAliqI()';
var
  vCdEmpresa, vNrFatura, vCdDetalhamento, vNrItem : Real;
  vDsLstAliquota, vDsRegistro : String;
  vDtFatura : TDate;
begin
  vCdEmpresa := itemXmlF('CD_EMPRESA', pParams);
  vNrFatura := itemXmlF('NR_FATURA', pParams);
  vDtFatura := itemXml('DT_FATURA', pParams);
  vCdDetalhamento := itemXmlF('CD_DETALHAMENTO', pParams);
  vDsLstAliquota := itemXml('DS_LSTALIQUOTA', pParams);

  if (vCdEmpresa = 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Empresa da nota não informada!', cDS_METHOD);
    return(-1); exit;
  end;
  if (vNrFatura = 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Fatura da nota não informada!', cDS_METHOD);
    return(-1); exit;
  end;
  if (vDtFatura = '') then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Data da nota não informada!', cDS_METHOD);
    return(-1); exit;
  end;
  if (vCdDetalhamento = '') then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Detalhamento não informado!', cDS_METHOD);
    return(-1); exit;
  end;
  if (vDsLstAliquota  = '') then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'LIsta de item de alíquota não informada!', cDS_METHOD);
    return(-1); exit;
  end;

  clear_e(tFIS_NF);
  putitem_o(tFIS_NF, 'CD_EMPRESA', vCdEmpresa);
  putitem_o(tFIS_NF, 'NR_FATURA', vNrFatura);
  putitem_o(tFIS_NF, 'DT_FATURA', vDtFatura);
  retrieve_e(tFIS_NF);
  if (xStatus < 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Nota Fiscal ' + FloatToStr(vCdEmpresa) + ' / ' + FloatToStr(vNrFatura) + ' / ' + vDtFatura + ' não encontrada!', cDS_METHOD);
    return(-1); exit;
  end;

  clear_e(tFIS_DIFALIQC);
  putitem_o(tFIS_DIFALIQC, 'CD_DETALHAMENTO', vCdDetalhamento);
  retrieve_e(tFIS_DIFALIQC);
  if (xStatus < 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Nota Fiscal ' + FloatToStr(vCdEmpresa) + ' / ' + FloatToStr(vNrFatura) + ' / ' + vDtFatura + ' não encontrada!', cDS_METHOD);
    return(-1); exit;
  end;

  voParams := tFIS_DIFALIQI.Excluir();
  if (xStatus < 0) then begin
    Result := voParams;
    return(-1); exit;
  end;
  if (vDsLstAliquota  <> '') then begin
    repeat
      getitem(vDsRegistro, vDsLstAliquota, 1);

      if (itemXml('NR_ITEM', vDsRegistro) = 0) then begin
        Result := SetStatus(STS_ERROR, 'GEN0001', 'Item não informado!', cDS_METHOD);
        return(-1); exit;
      end;

      creocc(tFIS_DIFALIQI, -1);
      getlistitensocc_e(vDsRegistro, tFIS_DIFALIQI);
      putitem_e(tFIS_DIFALIQI, 'CD_OPERADOR', itemXmlF('CD_USUARIO', PARAM_GLB));
      putitem_e(tFIS_DIFALIQI, 'DT_CADASTRO', Now);

      delitem(vDsLstAliquota, 1);
    until(vDsLstAliquota = '');
  end;

  voParams := calculaTotalAliquota(viParams); (* *)
  if (xStatus < 0) then begin
    Result := voParams;
    return(-1); exit;
  end;

  voParams := tFIS_NF.Salvar();
  if (xStatus < 0) then begin
    Result := voParams;
    return(-1); exit;
  end;

  return(0); exit;
end;

//----------------------------------------------------------------
function T_FISSVCO024.gravaDetalheIcms(pParams : String) : String;
//----------------------------------------------------------------
const
  cDS_METHOD = 'ADICIONAL=Operação: T_FISSVCO024.gravaDetalheIcms()';
var
  vCdEmpresa, vCdImposto, vNrSequencia, vCdDetalhamento : Real;
  vDtMesAno : String;
begin
  vCdEmpresa := itemXmlF('CD_EMPRESA', pParams);
  vDtMesAno := itemXml('DT_MESANO', pParams);
  vCdImposto := itemXmlF('CD_IMPOSTO', pParams);
  vNrSequencia := itemXmlF('NR_SEQUENCIA', pParams);
  vCdDetalhamento := itemXmlF('CD_DETALHAMENTO', pParams);

  if (vCdEmpresa = 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Empresa da nota não informada!', cDS_METHOD);
    return(-1); exit;
  end;
  if (vDtMesAno = '') then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Mês/ano não informado!', cDS_METHOD);
    return(-1); exit;
  end;
  if (vCdImposto = 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Imposto não informado!', cDS_METHOD);
    return(-1); exit;
  end;
  if (vCdDetalhamento = 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Código do detalhamento não informado!', cDS_METHOD);
    return(-1); exit;
  end;
  if (vNrSequencia = 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Sequência não informado!', cDS_METHOD);
    return(-1); exit;
  end;

  creocc(tFIS_DETALHEIC, -1);
  putitem_e(tFIS_DETALHEIC, 'CD_EMPRESA', vCdEmpresa);
  putitem_e(tFIS_DETALHEIC, 'DT_MESANO', vDtMesAno);
  putitem_e(tFIS_DETALHEIC, 'CD_IMPOSTO', vCdImposto);
  putitem_e(tFIS_DETALHEIC, 'CD_DETALHAMENTO', vCdDetalhamento);
  putitem_e(tFIS_DETALHEIC, 'NR_SEQUENCIA', vNrSequencia);
  retrieve_o(tFIS_DETALHEIC);
  if (xStatus = -7) then begin
    retrieve_x(tFIS_DETALHEIC);
  end;

  delitem(pParams, 'CD_EMPRESA');
  delitem(pParams, 'DT_MESANO');
  delitem(pParams, 'CD_IMPOSTO');
  delitem(pParams, 'CD_DETALHAMENTO');
  delitem(pParams, 'NR_SEQUENCIA');

  getlistitensocc_e(pParams, tFIS_DETALHEIC);
  putitem_e(tFIS_DETALHEIC, 'CD_OPERADOR', itemXmlF('CD_USUARIO', PARAM_GLB));
  putitem_e(tFIS_DETALHEIC, 'DT_CADASTRO', Now);

  voParams := tFIS_DETALHEIC.Salvar();
  if (xStatus < 0) then begin
    Result := voParams;
    return(-1); exit;
  end;

  return(0); exit;
end;

//------------------------------------------------------------------
function T_FISSVCO024.gravaSeloFiscalEnt(pParams : String) : String;
//------------------------------------------------------------------
const
  cDS_METHOD = 'ADICIONAL=Operação: T_FISSVCO024.gravaSeloFiscalEnt()';
var
  vCdEmpresaTra, vNrTransacao, vCdEmpresaNf, vNrFatura : Real;
  vDtTransacao, vDtFatura : TDate;
begin
  vCdEmpresaTra := itemXmlF('CD_EMPRESATRA', pParams);
  vNrTransacao := itemXmlF('NR_TRANSACAO', pParams);
  vDtTransacao := itemXml('DT_TRANSACAO', pParams);
  vCdEmpresaNf := itemXmlF('CD_EMPRESANF', pParams);
  vNrFatura := itemXmlF('NR_FATURA', pParams);
  vDtFatura := itemXml('DT_FATURA', pParams);

  if (vCdEmpresaTra = '') then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Empresa da transação não informada!', cDS_METHOD);
    return(-1); exit;
  end;
  if (vNrTransacao = '') then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Número da transação não informado!', cDS_METHOD);
    return(-1); exit;
  end;
  if (vDtTransacao = '') then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Data da transação não informada!', cDS_METHOD);
    return(-1); exit;
  end;
  if (vCdEmpresaNf = '') then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Empresa da nota fiscal não informada!', cDS_METHOD);
    return(-1); exit;
  end;
  if (vNrFatura = '') then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Número da fatura não informado!', cDS_METHOD);
    return(-1); exit;
  end;
  if (vDtFatura = '') then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Data da fatura não informada!', cDS_METHOD);
    return(-1); exit;
  end;

  clear_e(tTRA_SELOENT);
  putitem_o(tTRA_SELOENT, 'CD_EMPRESA', vCdEmpresaTra);
  putitem_o(tTRA_SELOENT, 'NR_TRANSACAO', vNrTransacao);
  putitem_o(tTRA_SELOENT, 'DT_TRANSACAO', vDtTransacao);
  retrieve_e(tTRA_SELOENT);
  if (xStatus >= 0) then begin
    clear_e(tFIS_NFSELOENT);
    creocc(tFIS_NFSELOENT, -1);
    putitem_e(tFIS_NFSELOENT, 'CD_EMPRESA', vCdEmpresaNf);
    putitem_e(tFIS_NFSELOENT, 'NR_FATURA', vNrFatura);
    putitem_e(tFIS_NFSELOENT, 'DT_FATURA', vDtFatura);
    retrieve_o(tFIS_NFSELOENT);
    if (xStatus = -7) then begin
      retrieve_x(tFIS_NFSELOENT);
    end;
    putitem_e(tFIS_NFSELOENT, 'VL_ANTECIPADO', item_f('VL_ANTECIPADO', tTRA_SELOENT));
    putitem_e(tFIS_NFSELOENT, 'VL_SUBSTITUIDO', item_f('VL_SUBSTITUIDO', tTRA_SELOENT));
    putitem_e(tFIS_NFSELOENT, 'VL_DIFERENCIAL', item_f('VL_DIFERENCIAL', tTRA_SELOENT));
    putitem_e(tFIS_NFSELOENT, 'CD_OPERADOR', itemXmlF('CD_USUARIO', PARAM_GLB));
    putitem_e(tFIS_NFSELOENT, 'DT_CADASTRO', Now);

    voParams := tFIS_NFSELOENT.Salvar();
    if (xStatus < 0) then begin
      Result := voParams;
      return(-1); exit;
    end;
  end;

  return(0); exit;

end;


end.
