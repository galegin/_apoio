unit cTRASVCO004;

interface

(* COMPONENTES
  ADMSVCO001 / ADMSVCO025 / FCRSVCO015 / FISSVCO004 / FISSVCO015
  GERSVCO008 / GERSVCO011 / GERSVCO012 / GERSVCO031 / GERSVCO046
  GERSVCO054 / GERSVCO058 / GERSVCO103 / PCPSVCO020 / PEDSVCO008
  PESSVCO005 / PRDSVCO004 / PRDSVCO007 / PRDSVCO008 / PRDSVCO015
  PRDSVCO020 / SICSVCO005 / TRASVCO012 / TRASVCO016 / TRASVCO024
*)

uses
  Classes, SysUtils, DB,
  cServiceUnf, cDataSetUnf;

type
  T_TRASVCO004 = class(TcServiceUnf)
  private
    tF_TRA_ITEMIMPOSTO,
    tGER_S_OPERACAO,
    tBAL_BALANCOTR,
    tFIS_REGRAIMPOSTO,
    tGER_EMPRESA,
    tGER_OPERACAO,
    tGER_OPERSALDOPRD,
    tOBS_TRANSACAO,
    tPED_PEDIDOTRA,
    tPES_CLIENTE,
    tPES_PESFISICA,
    tPES_PESJURIDICA,
    tPES_PESSOA,
    tPES_TELEFONE,
    //tPRD_LOTEI,
    tTMP_NR09,
    tTRA_ITEMIMPOSTO,
    //tTRA_ITEMLOTE,
    tTRA_ITEMVL,
    tTRA_REMDES,
    tTRA_TRAIMPOSTO,
    tTRA_TRANSACAO,
    tTRA_TRANSACSIT,
    tTRA_TRANSITEM,
    tTRA_TRANSPORT,
    tV_BAL_BALANCO,
    tV_PES_ENDERECO,
    tV_TRA_TOTATRA,
    tV_TRA_TOTITEM,
    tSIS_PARCELAMENTO,
    tPRD_PRDREGRAFISCAL,
    tFIS_REGRAADIC,
    tTRA_ITEMADIC : TcDatasetUnf;
  protected
    function getParam(pParams : String = '') : String; override;
    function setEntidade(pParams : String = '') : String; override;
    procedure tV_PES_ENDERECO_posREAD(DataSet : TDataset);
  public
  published
    function alteraAdicional(pParams : String = '') : String;
    function alteraImpressaoTransacao(pParams : String = '') : String;
    function alteraSituacaoTransacao(pParams : String = '') : String;
    function alteraVendedorTransacaoNF(pParams : String = '') : String;
    function atualizaEstoqueTransacao(pParams : String = '') : String;
    function calculaTotalOtimizado(pParams : String = '') : String;
    function calculaTotalTransacao(pParams : String = '') : String;
    function gravaCapaTransacao(pParams : String = '') : String;
    function gravaEnderecoTransacao(pParams : String = '') : String;
    function gravaImpostoItemTransacao(pParams : String = '') : String;
    function gravaItemTransacao(pParams : String = '') : String;
    function gravaObservacaoTransacao(pParams : String = '') : String;
    function gravaParcelaTransacao(pParams : String = '') : String;
    function gravaTotalTransacao(pParams : String = '') : String;
    function gravaTransportTransacao(pParams : String = '') : String;
    function gravaValorItemTransacao(pParams : String = '') : String;
    function removeItemTransacao(pParams : String = '') : String;
    function validaGuiaRepreCliente(pParams : String = '') : String;
    function validaItemTransacao(pParams : String = '') : String;
    function validaProdutoBalanco(pParams : String = '') : String;
  end;

implementation

uses
  cActivate, cStatus, cFuncao, cXml, dModulo, cDataSet;

const
  debug = false;

var
  gCdClientePdv,
  gCdCustoMedio,
  gCdEmpParam,
  gCdOperacaoOI,
  gInBloqSaldoNeg,
  gCdPessoaEndPadrao : Real;

  gCdOperKardex,
  gCdEspecieServico,
  gDsCustoSubstTributaria,
  gDsCustoValorRetido,
  gDsLstValorVenda,
  gDsSepBarraPrd : String;

  gHrFim,
  gHrInicio,
  gHrTempo : TDateTime;

  gInTransacaoItem,
  gInGravaRepreGuiaTra,
  gInGravaTraBloq,
  gInGuiaReprAuto,
  gInSomaFrete : Boolean;

  gNrDiaVencto,
  gNrItemQuebraNf,
  gTpDataVenctoParcela,
  gTpModDctoFiscal,
  gTpNumeracaoTra,
  gTpTabPrecoPed,
  gTpUtilizaDtBasePgto,
  gTpValidaTransacaoPrd,
  gTpValorBrutoPromocao,
  gVlMinimoParcela : Real;

//---------------------------------------------------------------
function T_TRASVCO004.getParam(pParams : String = '') : String;
//---------------------------------------------------------------
var
  piCdEmpresa : Real;
  vResult : String;
begin
  piCdEmpresa := pParams.CD_EMPRESA;
  if (piCdEmpresa = 0) then begin
    piCdEmpresa := PARAM_GLB.CD_EMPRESA;
  end;

  xParam := '';
  //putitem(xParam, 'CLIENTE_PDV');
  putitem(xParam, 'DS_SEP_NRSEQ_BARRA_PRD');
  xParam := activateCmp('ADMSVCO001', 'GetParametro', xParam);

  //gCdClientePdv := xParam.CLIENTE_PDV;
  gDsSepBarraPrd := xParam.DS_SEP_NRSEQ_BARRA_PRD;
  
  vResult := activateCmp('PESSVCL001', 'getClientePdv', '');
  gCdClientePdv := vResult.CLIENTE_PDV;  

  xParamEmp := '';
  //putitem(xParamEmp, 'CD_CLIENTE_PDV_EMP');
  putitem(xParamEmp, 'CD_CUSTO_MEDIO_CMP');
  putitem(xParamEmp, 'CD_CUSTO_VALIDA_VENDA');
  putitem(xParamEmp, 'CD_OPER_ESTOQ_PROD_OI');
  putitem(xParamEmp, 'CD_OPER_GRAVA_ZERO_KARDEX');
  putitem(xParamEmp, 'CD_PESSOA_ENDERECO_PADRAO');
  //putitem(xParamEmp, 'CLIENTE_PDV');
  putitem(xParamEmp, 'DS_CUSTO_SUBST_TRIBUTARIA');
  putitem(xParamEmp, 'DS_CUSTO_VALOR_RETIDO');
  putitem(xParamEmp, 'DS_LST_VLR_VENDA');
  putitem(xParamEmp, 'DS_SEP_NRSEQ_BARRA_PRD');
  putitem(xParamEmp, 'DT_SISTEMA');
  putitem(xParamEmp, 'IN_BLOQ_SALDO_NEG');
  putitem(xParamEmp, 'IN_FRETE_PRIMEIRA_PARCELA');
  putitem(xParamEmp, 'IN_GRAVA_REPREGUIA_TRA');
  putitem(xParamEmp, 'IN_GRAVA_TRANS_BLOQUEADA');
  putitem(xParamEmp, 'IN_GUIA_REPR_AUTO_TRA_VD');
  putitem(xParamEmp, 'IN_SOMA_FRETE_TOTALNF');
  putitem(xParamEmp, 'NR_DIA_ATRASO_BLOQ_FAT');
  putitem(xParamEmp, 'NR_DIAS_ULTCOMPRA_CLIENTE');
  putitem(xParamEmp, 'NR_ITEM_QUEBRA_NF');
  putitem(xParamEmp, 'TP_DT_VENCIMENTO_PARCELA');
  putitem(xParamEmp, 'TP_NUMERACAO_TRA');
  putitem(xParamEmp, 'TP_TABPRECO_PED');
  putitem(xParamEmp, 'TP_UTIL_DT_BASEPGTO_PED');
  putitem(xParamEmp, 'TP_VALIDA_TRANSACAO_PRD');
  putitem(xParamEmp, 'TP_VALORBRUTO_PROMOCAO');
  putitem(xParamEmp, 'VL_MINIMO_PARCELA');
  xParamEmp := activateCmp('ADMSVCO001', 'GetParamEmpresa', piCdEmpresa, xParamEmp);

  gCdCustoMedio := xParamEmp.CD_CUSTO_MEDIO_CMP;
  gCdOperacaoOI := xParamEmp.CD_OPER_ESTOQ_PROD_OI;
  gCdOperKardex := xParamEmp.CD_OPER_GRAVA_ZERO_KARDEX;
  gCdPessoaEndPadrao := xParamEmp.CD_PESSOA_ENDERECO_PADRAO;
  gDsCustoSubstTributaria := xParamEmp.DS_CUSTO_SUBST_TRIBUTARIA;
  gDsCustoValorRetido := xParamEmp.DS_CUSTO_VALOR_RETIDO;
  gDsLstValorVenda := xParamEmp.DS_LST_VLR_VENDA;
  gInBloqSaldoNeg := xParamEmp.IN_BLOQ_SALDO_NEG;
  gInGravaRepreGuiaTra := xParamEmp.IN_GRAVA_REPREGUIA_TRA;
  gInGravaTraBloq := xParamEmp.IN_GRAVA_TRANS_BLOQUEADA;
  gInGuiaReprAuto := xParamEmp.IN_GUIA_REPR_AUTO_TRA_VD;
  gInSomaFrete := xParamEmp.IN_SOMA_FRETE_TOTALNF;
  gNrDiaVencto := xParamEmp.NR_DIA_ATRASO_BLOQ_FAT;
  gNrItemQuebraNf := xParamEmp.NR_ITEM_QUEBRA_NF;
  gTpDataVenctoParcela := xParamEmp.TP_DT_VENCIMENTO_PARCELA;
  gTpNumeracaoTra := xParamEmp.TP_NUMERACAO_TRA;
  gTpTabPrecoPed := xParamEmp.TP_TABPRECO_PED;
  gTpUtilizaDtBasePgto := xParamEmp.TP_UTIL_DT_BASEPGTO_PED;
  gTpValidaTransacaoPrd := xParamEmp.TP_VALIDA_TRANSACAO_PRD;
  gTpValorBrutoPromocao := xParamEmp.TP_VALORBRUTO_PROMOCAO;
  gVlMinimoParcela := xParamEmp.VL_MINIMO_PARCELA;
end;

//---------------------------------------------------------------
function T_TRASVCO004.setEntidade(pParams : String = '') : String;
//---------------------------------------------------------------
begin
  tF_TRA_ITEMIMPOSTO := TTRA_ITEMIMPOSTO.Create(nil);
  tGER_S_OPERACAO := TGER_OPERACAO.Create(nil);
  //tBAL_BALANCOTR := TBAL_BALANCOTR.Create(nil);
  tFIS_REGRAIMPOSTO := TFIS_REGRAIMPOSTO.Create(nil);
  tGER_EMPRESA := TGER_EMPRESA.Create(nil);
  tGER_OPERACAO := TGER_OPERACAO.Create(nil);
  tGER_OPERSALDOPRD := TGER_OPERSALDOPRD.Create(nil);
  tOBS_TRANSACAO := TOBS_TRANSACAO.Create(nil);
  //tPED_PEDIDOTRA := TPED_PEDIDOTRA.Create(nil);
  tPES_CLIENTE := TPES_CLIENTE.Create(nil);
  tPES_PESFISICA := TPES_PESFISICA.Create(nil);
  tPES_PESJURIDICA := TPES_PESJURIDICA.Create(nil);
  tPES_PESSOA := TPES_PESSOA.Create(nil);
  tPES_TELEFONE := TPES_TELEFONE.Create(nil);
  //tPRD_LOTEI := TPRD_LOTEI.Create(nil);
  tTMP_NR09 := TTMP_NR09.Create(nil);
  tTRA_ITEMIMPOSTO := TTRA_ITEMIMPOSTO.Create(nil);
  //tTRA_ITEMLOTE := TTRA_ITEMLOTE.Create(nil);
  tTRA_ITEMVL := TTRA_ITEMVL.Create(nil);
  tTRA_REMDES := TTRA_REMDES.Create(nil);
  tTRA_TRAIMPOSTO := TTRA_TRAIMPOSTO.Create(nil);
  tTRA_TRANSACAO := TTRA_TRANSACAO.Create(nil);
  tTRA_TRANSACSIT := TTRA_TRANSACSIT.Create(nil);
  tTRA_TRANSITEM := TTRA_TRANSITEM.Create(nil);
  tTRA_TRANSPORT := TTRA_TRANSPORT.Create(nil);
  //tV_BAL_BALANCO := TV_BAL_BALANCO.Create(nil);
  //tV_TRA_TOTATRA := TV_TRA_TOTATRA.Create(nil);
  tV_TRA_TOTITEM := TV_TRA_TOTITEM.Create(nil);
  tPRD_PRDREGRAFISCAL := TPRD_PRDREGRAFISCAL.Create(nil);
  tFIS_REGRAADIC := TFIS_REGRAADIC.Create(nil);
  tTRA_ITEMADIC := TTRA_ITEMADIC.Create(nil);

  // metadata ???
  tSIS_PARCELAMENTO := TcDataSetUnf.Create(Self);
  tSIS_PARCELAMENTO.SetMetadataTmp('VL_PARCELA:N(10)|VL_DOCUMENTO:N(10)|DT_VENCIMENTO:D(10)|TP_DOCUMENTO:N(2)|DS_OBSERVACAO:A(100)|DS_ADICIONAL:A(200)|NR_DOCUMENTO:N(10)|');

  // filhas ???
  tPES_PESSOA._LstFilha := 'PES_CLIENTE|PES_TELEFONE|PES_PESJURIDICA|PES_PESFISICA|';
  tTRA_TRANSACAO._LstFilha := 'GER_EMPRESA|PES_PESSOA|GER_OPERACAO|TRA_REMDES:u|TRA_TRANSPORT:u|TRA_TRANSITEM:u|';
  //tTRA_TRANSITEM._LstFilha := 'TRA_ITEMIMPOSTO:u|';
  tTRA_TRANSITEM._LstFilha := 'TRA_ITEMVL:u|';

  // calculados ???
  tTRA_TRANSITEM._LstCalc := 'PR_IPI|VL_IPI|';

  // endereco ???
  tV_PES_ENDERECO := TPES_ENDERECO.Create(nil);
  tV_PES_ENDERECO._posREAD := tV_PES_ENDERECO_posREAD;
  tV_PES_ENDERECO._LstCalc := 'V_PES_ENDERECO';
end;

//---------------------------------------------------------------------
procedure T_TRASVCO004.tV_PES_ENDERECO_posREAD(DataSet : TDataset);
//---------------------------------------------------------------------
var viParams, voParams : String;
begin
  if (fV_PES_ENDERECO.CD_PESSOA <> 0)
  and (fV_PES_ENDERECO.NR_SEQUENCIA <> 0) then begin
    viParams := '';
    viParams.CD_PESSOA := fV_PES_ENDERECO.CD_PESSOA;
    viParams.NR_SEQUENCIA := fV_PES_ENDERECO.NR_SEQUENCIA;
    voParams := activateCmp('PESSVCO001', 'buscarEndereco', viParams);
    fV_PES_ENDERECO.SetValues(voParams);
  end;
end;

//---------------------------------------------------------------------
function T_TRASVCO004.calculaTotalTransacao(pParams : String) : String;
//---------------------------------------------------------------------
const
  cDS_METHOD = 'ADICIONAL=Operação: T_TRASVCO004.calculaTotalTransacao()';
var
  vNrOccAnt, vQtSolicitada, vVlTransacao, vVlDesconto, vVlTotalBruto, vVlFrete : Real;
  vVlBaseICMS, vVlICMS, vVlBaseICMSSubst, vVlICMSSubst, vVlIPI, vVlCalc : Real;
begin
  if debug then MensagemLog(cDS_METHOD, 'pParams: ' + pParams);

  //-- MFGALEGO - 22/10/2014 ; otimizar totalizacao da transacao
  if IffNuloB(TcIniFiles.Pegar('','','IN_TOTAL_OTIMIZADO', ''), True) then begin
    Result := calculaTotalOtimizado(pParams);
    Exit;
  end;
  //--

  vQtSolicitada := 0;
  vVlTransacao := 0;
  vVlTotalBruto := 0;
  vVlDesconto := 0;
  vVlBaseICMS := 0;
  vVlICMS := 0;
  vVlBaseICMSSubst := 0;
  vVlICMSSubst := 0;
  vVlIPI := 0;

  if debug then MensagemLogTempo('inicio');

  if (pParams.IN_CONSULTAR) then begin
    if (pParams.CD_EMPRESA = 0) then begin
      raise Exception.Create('Empresa não informada!' + ' / ' + cDS_METHOD);
      exit;
    end;
    if (pParams.NR_TRANSACAO = 0) then begin
      raise Exception.Create('Número da transação não informada!' + ' / ' + cDS_METHOD);
      exit;
    end;
    if (pParams.DT_TRANSACAO = '') then begin
      raise Exception.Create('Data transação não informada!' + ' / ' + cDS_METHOD);
      exit;
    end;

    fTRA_TRANSACAO.Limpar();
    fTRA_TRANSACAO.CD_EMPRESA := pParams.CD_EMPRESA;
    fTRA_TRANSACAO.NR_TRANSACAO := pParams.NR_TRANSACAO;
    fTRA_TRANSACAO.DT_TRANSACAO := pParams.DT_TRANSACAO;
    fTRA_TRANSACAO.Listar(nil);
    if (itemXmlF('status', voParams) < 0) then begin
      raise Exception.Create('Transação ' + pParams.NR_TRANSACAO + ' não encontrada!' + ' / ' + cDS_METHOD);
      exit;
    end;
  end else begin
    if (fTRA_TRANSACAO.CD_EMPRESA = 0)
    or (fTRA_TRANSACAO.NR_TRANSACAO = 0)
    or (fTRA_TRANSACAO.DT_TRANSACAO = '') then begin
      exit;
    end;

    fTRA_TRANSITEM.Limpar();
    fTRA_TRANSITEM.CD_EMPRESA := fTRA_TRANSACAO.CD_EMPRESA;
    fTRA_TRANSITEM.NR_TRANSACAO := fTRA_TRANSACAO.NR_TRANSACAO;
    fTRA_TRANSITEM.DT_TRANSACAO := fTRA_TRANSACAO.DT_TRANSACAO;
    fTRA_TRANSITEM.Listar(nil);
  end;

  if debug then MensagemLogTempo('transacao');

  if not (fTRA_TRANSITEM.IsEmpty()) then begin
    fTRA_TRANSITEM.First();
    while not t.EOF do begin
      vQtSolicitada := vQtSolicitada + fTRA_TRANSITEM.QT_SOLICITADA;
      vVlTransacao := vVlTransacao + fTRA_TRANSITEM.VL_TOTALLIQUIDO;
      vVlTotalBruto := vVlTotalBruto + fTRA_TRANSITEM.VL_TOTALBRUTO;
      vVlDesconto := vVlDesconto + (fTRA_TRANSITEM.VL_TOTALDESC + fTRA_TRANSITEM.VL_TOTALDESCCAB);
      if not (fTRA_ITEMIMPOSTO.IsEmpty()) then begin
        fTRA_ITEMIMPOSTO.First();
        while not t.EOF do begin
          if (fTRA_ITEMIMPOSTO.CD_IMPOSTO = 1) then begin
            vVlBaseICMS := vVlBaseICMS + fTRA_ITEMIMPOSTO.VL_BASECALC;
            vVlICMS := vVlICMS + fTRA_ITEMIMPOSTO.VL_IMPOSTO;
          end else if (fTRA_ITEMIMPOSTO.CD_IMPOSTO = 2) then begin
            vVlBaseICMSSubst := vVlBaseICMSSubst + fTRA_ITEMIMPOSTO.VL_BASECALC;
            vVlICMSSubst := vVlICMSSubst + fTRA_ITEMIMPOSTO.VL_IMPOSTO;
          end else if (fTRA_ITEMIMPOSTO.CD_IMPOSTO = 3) then begin
            vVlIPI := vVlIPI + fTRA_ITEMIMPOSTO.VL_IMPOSTO;
          end;
          fTRA_ITEMIMPOSTO.Next();
        end;
      end;
      fTRA_TRANSITEM.Next();
    end;
  end;

  if debug then MensagemLogTempo('totaliza items');

  if not (fTRA_TRAIMPOSTO.IsEmpty()) then begin
    vNrOccAnt := fTRA_TRAIMPOSTO.RecNo;
    fTRA_TRAIMPOSTO.First();
    while not t.EOF do begin
      if (fTRA_TRAIMPOSTO.CD_IMPOSTO = 1) then begin
        vVlBaseICMS := vVlBaseICMS + fTRA_TRAIMPOSTO.VL_BASECALC;
        vVlICMS := vVlICMS + fTRA_TRAIMPOSTO.VL_IMPOSTO;
      end else if (fTRA_TRAIMPOSTO.CD_IMPOSTO = 2) then begin
        vVlBaseICMSSubst := vVlBaseICMSSubst + fTRA_TRAIMPOSTO.VL_BASECALC;
        vVlICMSSubst := vVlICMSSubst + fTRA_TRAIMPOSTO.VL_IMPOSTO;
      end else if (fTRA_TRAIMPOSTO.CD_IMPOSTO = 3) then begin
        vVlIPI := vVlIPI + fTRA_TRAIMPOSTO.VL_IMPOSTO;
      end;
      fTRA_TRAIMPOSTO.Next();
    end;
    fTRA_TRAIMPOSTO.First();
  end;

  if debug then MensagemLogTempo('totaliza imposto');

  //try vVlCalc := (vVlTotalBruto - vVlTransacao) / vVlTotalBruto * 100;
  //if (vVlCalc < 0) then vVlCalc := 0;
  //except vVlCalc := 0;
  //end;
  vVlCalc := (vVlTotalBruto - vVlTransacao) / DivByZero(vVlTotalBruto) * 100;

  if debug then MensagemLogTempo('valor calc');

  fTRA_TRANSACAO.PR_DESCONTO := rounded(vVlCalc, 6);
  fTRA_TRANSACAO.QT_SOLICITADA := vQtSolicitada;
  fTRA_TRANSACAO.VL_TRANSACAO := vVlTransacao;
  fTRA_TRANSACAO.VL_DESCONTO := vVlDesconto;
  fTRA_TRANSACAO.VL_BASEICMS := rounded(vVlBaseICMS, 2);
  fTRA_TRANSACAO.VL_ICMS := rounded(vVlICMS, 2);
  fTRA_TRANSACAO.VL_BASEICMSSUBST := rounded(vVlBaseICMSSubst, 2);
  fTRA_TRANSACAO.VL_ICMSSUBST := rounded(vVlICMSSubst, 2);
  fTRA_TRANSACAO.VL_IPI := rounded(vVlIPI, 2);

  if debug then MensagemLogTempo('valores');

  if (fTRA_TRANSPORT.TP_FRETE = '2') then begin
    vVlFrete := fTRA_TRANSACAO.VL_FRETE;
  end else begin
    if (gInSomaFrete) then begin
      vVlFrete := fTRA_TRANSACAO.VL_FRETE;
    end else begin
      vVlFrete := 0;
    end;
  end;

  if debug then MensagemLogTempo('valor frete');

  {
    corrigir gravacao dos totais da transacao
    - VL_TRANSACAO = gravar valor total bruto
    - VL_DESCONTO  = gravar valor total de desconto
    - VL_TOTAL     = (valor dos produtos) + (acrescimos) - (descontos)
  }

  putitem_e(tTRA_TRANSACAO, 'VL_TOTAL', fTRA_TRANSACAO.VL_TRANSACAO +
                                        fTRA_TRANSACAO.VL_IPI +
                                        vVlFrete +
                                        fTRA_TRANSACAO.VL_SEGURO +
                                        fTRA_TRANSACAO.VL_DESPACESSOR +
                                        fTRA_TRANSACAO.VL_ICMSSUBST);

  if (pParams.IN_CONSULTAR) then begin
    Result := fTRA_TRANSACAO.GetValues();
    if debug then MensagemLogTempo('retorna total da transacao');
  end;

  if debug then MensagemLogTempo('frete');

  if debug then MensagemLog(cDS_METHOD, 'Result: ' + Result);

  exit;
end;

//---------------------------------------------------------------------
function T_TRASVCO004.calculaTotalOtimizado(pParams : String) : String;
//---------------------------------------------------------------------
const
  cDS_METHOD = 'ADICIONAL=Operação: T_TRASVCO004.calculaTotalOtimizado()';
var
  vVlCalc, vVlFrete : Real;
begin
  if debug then MensagemLog(cDS_METHOD, 'pParams: ' + pParams);

  if (pParams.IN_CONSULTAR) then begin
    if (pParams.CD_EMPRESA = 0) then begin
      raise Exception.Create('Empresa não informada!' + ' / ' + cDS_METHOD);
      exit;
    end;
    if (pParams.NR_TRANSACAO = 0) then begin
      raise Exception.Create('Número da transação não informada!' + ' / ' + cDS_METHOD);
      exit;
    end;
    if (pParams.DT_TRANSACAO = '') then begin
      raise Exception.Create('Data transação não informada!' + ' / ' + cDS_METHOD);
      exit;
    end;

    fTRA_TRANSACAO.Limpar();
    fTRA_TRANSACAO.CD_EMPRESA := pParams.CD_EMPRESA;
    fTRA_TRANSACAO.NR_TRANSACAO := pParams.NR_TRANSACAO;
    fTRA_TRANSACAO.DT_TRANSACAO := pParams.DT_TRANSACAO;
    fTRA_TRANSACAO.Listar(nil);
    if (itemXmlF('status', voParams) < 0) then begin
      raise Exception.Create('Transação ' + pParams.NR_TRANSACAO + ' não encontrada!' + ' / ' + cDS_METHOD);
      exit;
    end;
  end else begin
    if (fTRA_TRANSACAO.CD_EMPRESA = 0)
    or (fTRA_TRANSACAO.NR_TRANSACAO = 0)
    or (fTRA_TRANSACAO.DT_TRANSACAO = '') then begin
      exit;
    end;
  end;

  fV_TRA_TOTITEM.Limpar();
  fV_TRA_TOTITEM.CD_EMPRESA := fTRA_TRANSACAO.CD_EMPRESA;
  fV_TRA_TOTITEM.NR_TRANSACAO := fTRA_TRANSACAO.NR_TRANSACAO;
  fV_TRA_TOTITEM.DT_TRANSACAO := fTRA_TRANSACAO.DT_TRANSACAO;
  fV_TRA_TOTITEM.Listar(nil);
  if (xStatus >= 0) then begin
    vVlCalc := (fV_TRA_TOTITEM.VL_TOTALDESC + fV_TRA_TOTITEM.VL_TOTALDESCCAB) / fV_TRA_TOTITEM.VL_TOTALBRUTO * 100;
    fTRA_TRANSACAO.PR_DESCONTO := rounded(vVlCalc, 6);
    fTRA_TRANSACAO.QT_SOLICITADA := fV_TRA_TOTITEM.QT_SOLICITADA;
    fTRA_TRANSACAO.VL_TRANSACAO := fV_TRA_TOTITEM.VL_TOTALLIQUIDO;
    fTRA_TRANSACAO.VL_DESCONTO := fV_TRA_TOTITEM.VL_TOTALDESC + fV_TRA_TOTITEM.VL_TOTALDESCCAB;
    fTRA_TRANSACAO.VL_BASEICMS := fV_TRA_TOTITEM.VL_BASEICMS;
    fTRA_TRANSACAO.VL_ICMS := fV_TRA_TOTITEM.VL_ICMS;
    fTRA_TRANSACAO.VL_BASEICMSSUBST := fV_TRA_TOTITEM.VL_BASEICMSSUBST;
    fTRA_TRANSACAO.VL_ICMSSUBST := fV_TRA_TOTITEM.VL_ICMSSUBST;
    fTRA_TRANSACAO.VL_IPI := fV_TRA_TOTITEM.VL_IPI;
    if (fTRA_TRANSPORT.TP_FRETE = 2) then begin
      vVlFrete := fTRA_TRANSACAO.VL_FRETE;
    end else begin
      if (gInSomaFrete) then begin
        vVlFrete := fTRA_TRANSACAO.VL_FRETE;
      end else begin
        vVlFrete := 0;
      end;
    end;
    putitem_e(tTRA_TRANSACAO, 'VL_TOTAL', fTRA_TRANSACAO.VL_TRANSACAO +
                                          fTRA_TRANSACAO.VL_IPI +
                                          vVlFrete +
                                          fTRA_TRANSACAO.VL_SEGURO +
                                          fTRA_TRANSACAO.VL_DESPACESSOR +
                                          fTRA_TRANSACAO.VL_ICMSSUBST);
  end;

  if (pParams.IN_CONSULTAR) then begin
    Result := fTRA_TRANSACAO.GetValues();
    if debug then MensagemLogTempo('retorna total da transacao');
  end;  

  if debug then MensagemLog(cDS_METHOD, 'Result: ' + Result);

  exit;
end;

//----------------------------------------------------------------------
function T_TRASVCO004.validaGuiaRepreCliente(pParams : String) : String;
//----------------------------------------------------------------------
const
  cDS_METHOD = 'ADICIONAL=Operação: T_TRASVCO004.validaGuiaRepreCliente()';
var
  piCdPessoa, piCdPessoaAnt : Real;
  piInNaoGravaGuiaRepre, vInGuiaInativo, vInGuiaBloqueado, vInRepreInativo, vInRepreBloqueado : Boolean;
  viParams, voParams : String;
begin
  piCdPessoa := pParams.CD_PESSOA;
  piCdPessoaAnt := pParams.CD_PESSOAANT;
  piInNaoGravaGuiaRepre := pParams.IN_NAOGRAVAREPRE;

  if (fGER_OPERACAO.TP_MODALIDADE = 3) then begin
    if (gInGuiaReprAuto) and (piCdPessoa <> piCdPessoaAnt) and (piInNaoGravaGuiaRepre <> True) then begin
      viParams := '';
      viParams.CD_PESSOA := piCdPessoa;
      voParams := activateCmp('PESSVCO005', 'buscaDadosPessoa', viParams);
      if (itemXmlF('status', voParams) < 0) then begin
        raise Exception.Create(itemXml('message', voParams));
        exit;
      end;
      if (fTRA_TRANSACAO.CD_GUIA = 0) and ((fTRA_TRANSACAO.CD_REPRESENTANT = 0) or (gInGravaRepreGuiaTra)) then begin
        fTRA_TRANSACAO.CD_GUIA := voParams.CD_GUIA;
      end;
      if (fTRA_TRANSACAO.CD_REPRESENTANT = 0) and ((fTRA_TRANSACAO.CD_GUIA = 0) or (gInGravaRepreGuiaTra)) then begin
        fTRA_TRANSACAO.CD_REPRESENTANT := voParams.CD_REPRESENTANT;
      end;
    end;
  end else if (fGER_OPERACAO.TP_MODALIDADE = 4) and (fGER_OPERACAO.TP_OPERACAO = 'S') then begin
    if (gInGuiaReprAuto) and (piCdPessoa <> piCdPessoaAnt) and (piInNaoGravaGuiaRepre <> True) then begin
      viParams := '';
      viParams.CD_PESSOA := piCdPessoa;
      voParams := activateCmp('PESSVCO005', 'buscaDadosPessoa', viParams);
      if (itemXmlF('status', voParams) < 0) then begin
        raise Exception.Create(itemXml('message', voParams));
        exit;
      end;
      if (fTRA_TRANSACAO.CD_GUIA = 0) and ((fTRA_TRANSACAO.CD_REPRESENTANT = 0) or (gInGravaRepreGuiaTra)) then begin
        fTRA_TRANSACAO.CD_GUIA := voParams.CD_GUIA;
      end;
      if (fTRA_TRANSACAO.CD_REPRESENTANT = 0) and ((fTRA_TRANSACAO.CD_GUIA = 0) or (gInGravaRepreGuiaTra)) then begin
        fTRA_TRANSACAO.CD_REPRESENTANT := voParams.CD_REPRESENTANT;
      end;
    end;
  end;
  if (fTRA_TRANSACAO.CD_GUIA <> 0) then begin
    viParams := '';
    viParams.CD_PESSOA := fTRA_TRANSACAO.CD_GUIA;
    voParams := activateCmp('PESSVCO005', 'buscaDadosPessoa', viParams);
    if (itemXmlF('status', voParams) < 0) then begin
      raise Exception.Create(itemXml('message', voParams));
      exit;
    end;

    vInGuiaInativo := voParams.IN_GUIAINATIVO;
    if (vInGuiaInativo) then begin
      raise Exception.Create('Guia ' + fTRA_TRANSACAO.CD_GUIA + ' está inativo!' + ' / ' + cDS_METHOD);
      exit;
    end;

    vInGuiaBloqueado := voParams.IN_GUIABLOQUEADO;
    if (vInGuiaBloqueado) then begin
      raise Exception.Create('Guia ' + fTRA_TRANSACAO.CD_GUIA + ' está bloqueado!' + ' / ' + cDS_METHOD);
      exit;
    end;
  end;
  if (fTRA_TRANSACAO.CD_REPRESENTANT <> 0) then begin
    viParams := '';
    viParams.CD_PESSOA := fTRA_TRANSACAO.CD_REPRESENTANT;
    voParams := activateCmp('PESSVCO005', 'buscaDadosPessoa', viParams);
    if (itemXmlF('status', voParams) < 0) then begin
      raise Exception.Create(itemXml('message', voParams));
      exit;
    end;

    vInRepreInativo := voParams.IN_REPREINATIVO;
    if (vInRepreInativo) then begin
      raise Exception.Create('Representante ' + fTRA_TRANSACAO.CD_REPRESENTANT + ' está inativo!' + ' / ' + cDS_METHOD);
      exit;
    end;

    vInRepreBloqueado := voParams.IN_REPREBLOQUEADO;
    if (vInRepreBloqueado) then begin
      raise Exception.Create('Representante ' + fTRA_TRANSACAO.CD_REPRESENTANT + ' está bloqueado!' + ' / ' + cDS_METHOD);
      exit;
    end;
  end;
  if not (fTRA_TRANSACAO.CD_REPRESENTANT <> 0) and (fTRA_TRANSACAO.CD_GUIA <> 0) and (gInGravaRepreGuiaTra) then begin
    raise Exception.Create('Não é permitido lançar guia e representante na mesma transação!' + ' / ' + cDS_METHOD);
    exit;
  end;

  exit;
end;

//--------------------------------------------------------------------
function T_TRASVCO004.validaProdutoBalanco(pParams : String) : String;
//--------------------------------------------------------------------
const
  cDS_METHOD = 'ADICIONAL=Operação: T_TRASVCO004.validaProdutoBalanco()';
var
  vCdProduto, vCdOperacao, vCdSaldoOperacao : Real;
  vInKardex : Boolean;
begin
  vCdProduto := pParams.CD_PRODUTO;
  vCdOperacao := pParams.CD_OPERACAO;
  vInkardex := pParams.IN_KARDEX;

  if (gTpValidaTransacaoPrd = 2) then begin
    exit;
  end else begin
    if (vCdProduto <> 0) then begin
      fV_BAL_BALANCO.Limpar();
      fV_BAL_BALANCO.CD_EMPRESA := PARAM_GLB.CD_EMPRESA;
      fV_BAL_BALANCO.CD_PRODUTO := vCdProduto;
      fV_BAL_BALANCO.TP_SITUACAOC := 1;
      fV_BAL_BALANCO.Listar(nil);
      if (xStatus >= 0) then begin
        fBAL_BALANCOTR.Limpar();
        fBAL_BALANCOTR.CD_EMPBALANCO := PARAM_GLB.CD_EMPRESA;
        fBAL_BALANCOTR.NR_TRANSACAO := fTRA_TRANSACAO.NR_TRANSACAO;
        fBAL_BALANCOTR.Listar(nil);
        if (itemXmlF('status', voParams) < 0) then begin
          if (gTpValidaTransacaoPrd = 1) then begin
            raise Exception.Create('Produto ' + FloatToStr(vCdProduto) + ' não pode ser gravado + ' / ' + o mesmo se encontra em balanço em andamento!', cDS_METHOD);
            exit;

          end else if (gTpValidaTransacaoPrd = 3) and (vInKardex) then begin
            vCdSaldoOperacao := 0;
            if (vCdOperacao > 0) then begin
              fGER_OPERSALDOPRD.Limpar();
              fGER_OPERSALDOPRD.CD_OPERACAO := vCdOperacao;
              fGER_OPERSALDOPRD.IN_PADRAO := True;
              fGER_OPERSALDOPRD.Listar(nil);
              if (xStatus >= 0) then begin
                vCdSaldoOperacao := fGER_OPERSALDOPRD.CD_SALDO;
              end else begin
                fGER_OPERSALDOPRD.Limpar();
                fGER_OPERSALDOPRD.CD_OPERACAO := vCdOperacao;
                fGER_OPERSALDOPRD.Listar(nil);
                if (xStatus >= 0) then begin
                  vCdSaldoOperacao := fGER_OPERSALDOPRD.CD_SALDO;
                end else begin
                  fGER_OPERSALDOPRD.Limpar();
                end;
              end;
            end;
            if (vCdSaldoOperacao = fV_BAL_BALANCO.CD_SALDO) then begin
              raise Exception.Create('Produto ' + FloatToStr(vCdProduto) + ' não pode ser gravado + ' / ' + o mesmo se encontra em balanço em andamento!', cDS_METHOD);
              exit;
            end;
          end;
        end;
      end;
    end;
  end;

  exit;
end;

//------------------------------------------------------------------
function T_TRASVCO004.gravaCapaTransacao(pParams : String) : String;
//------------------------------------------------------------------
const
  cDS_METHOD = 'ADICIONAL=Operação: T_TRASVCO004.gravaCapaTransacao()';
var
  viParams, voParams, vCdCST, vDsRegistro, vNmCheckout, vDsLstTabPreco, vLstGlobal, vDsMensagem : String;
  vInNaoVerifCliBloq, vInValidaClienteAtraso, vInNaoVerificaCliBloq, vInNaoGravaGuiaRepre : Boolean;
  vCdEmpresa, vNrTransacao, vCdPessoa, vCdOperacao, vCdCondPgto, vCdImposto, vVlFrete : Real;
  vCdTabPreco, vCdCompVend, vTpSituacao, vTpOrigemEmissao, vNrSeqendereco, vCdPessoaAnt, vNrDiaSPC : Real;
  vDtTransacao, vDtTransacaoOri, vDtBaseParcela, vDtSistema, vDtSPC, vDtHoraEcf : TDateTime;
  vNrDiaVencto, vCdCCusto, vCdEmpresaOri, vNrTransacaoOri, vNrDiaUltCompra : Real;
  vInImpressao, vInInclusao, vInValidaData, vInHomologacaoPAF, vInVendaEcf : Boolean;
  //vCdClientePdvEmp : Real;
begin
  vCdEmpresa := pParams.CD_EMPRESA;
  vNrTransacao := pParams.NR_TRANSACAO;
  vDtTransacao := pParams.DT_TRANSACAO;
  vCdPessoa := pParams.CD_PESSOA;
  vCdOperacao := pParams.CD_OPERACAO;
  vCdCondpgto := pParams.CD_CONDPGTO;
  vCdCompVend := pParams.CD_COMPVEND;
  vTpSituacao := pParams.TP_SITUACAO;
  vTpOrigemEmissao := pParams.TP_ORIGEMEMISSAO;
  vInNaoVerifCliBloq := pParams.IN_NAO_VERIFICA_CLI_BLOQ;
  vInValidaClienteAtraso := pParams.IN_VALIDA_CLIENTE_ATRASO;
  vInNaoGravaGuiaRepre := pParams.IN_NAOGRAVAGUIAREPRE;
  vCdEmpresaOri := pParams.CD_EMPRESAORI;
  vNrTransacaoOri := pParams.NR_TRANSACAOORI;
  vDtTransacaoOri := pParams.DT_TRANSACAOORI;
  vInImpressao := pParams.IN_IMPRESSAO;
  vInValidaData := pParams.IN_VALIDADATA;
  vInHomologacaoPAF := TcIniFiles.PegarB('','','IN_HOMOLOGACAOPAF');

  if (vTpOrigemEmissao = 0) then begin
    vTpOrigemEmissao := 1;
  end;

  if (vCdEmpresa = 0) then begin
    raise Exception.Create('Empresa não informada!' + ' / ' + cDS_METHOD);
    exit;
  end;
  if (vDtTransacao = 0) then begin
    raise Exception.Create('Data transação não informada!' + ' / ' + cDS_METHOD);
    exit;
  end;
  if (vCdPessoa = 0) then begin
    raise Exception.Create('Pessoa não informada!' + ' / ' + cDS_METHOD);
    exit;
  end;
  if (vCdOperacao = 0) then begin
    raise Exception.Create('Operação não informada!' + ' / ' + cDS_METHOD);
    exit;
  end;
  if (vCdCondPgto = 0) then begin
    raise Exception.Create('Condição de pagamento não informada!' + ' / ' + cDS_METHOD);
    exit;
  end;
  if (vCdCompVend = 0) then begin
    raise Exception.Create('Comprador/Vendedor não informado!' + ' / ' + cDS_METHOD);
    exit;
  end;

  vDtSistema := xParamEmp.DT_SISTEMA;

  viParams := '';
  viParams.CD_PESSOA := vCdPessoa;
  voParams := activateCmp('TRASVCO016', 'validaCapaTransacao', viParams);
  if (itemXmlF('status', voParams) < 0) then begin
    raise Exception.Create(itemXml('message', voParams));
    exit;
  end;

  viParams := '';
  fGER_OPERACAO.Limpar();
  fGER_OPERACAO.CD_OPERACAO := vCdOperacao;
  fGER_OPERACAO.Listar(nil);
  if (xStatus >= 0) then begin
    if ((fGER_OPERACAO.TP_DOCTO = 2) or (fGER_OPERACAO.TP_DOCTO = 3))
    and ((fGER_OPERACAO.TP_MODALIDADE = 4) or (fGER_OPERACAO.TP_MODALIDADE = 8) or (fGER_OPERACAO.TP_MODALIDADE = 3)) then begin
      viParams.IN_VENDA_ECF := True;
      vInVendaEcf := True;
    end;
  end;

  if debug then MensagemLogTempo('operacao');

  viParams.CD_PESSOA := vCdPessoa;
  voParams := activateCmp('PESSVCO005', 'buscaEnderecoFaturamento', viParams);
  if (itemXmlF('status', voParams) < 0) then begin
    raise Exception.Create(itemXml('message', voParams));
    exit;
  end;

  if debug then MensagemLogTempo('endereco de faturamento');

  vNrSeqendereco := voParams.NR_SEQENDERECO;

  viParams := '';
  viParams.CD_OPERACAO := vCdOperacao;
  viParams.CD_CONDPGTO := vCdCondPgto;
  voParams := activateCmp('GERSVCO103', 'validaCondPgtoOperacao', viParams);
  if (itemXmlF('status', voParams) < 0) then begin
    raise Exception.Create(itemXml('message', voParams));
    exit;
  end;

  if debug then MensagemLogTempo('condicao pagamento');

  if (vInValidaClienteAtraso) then begin
    viParams := '';
    viParams.CD_CLIENTE := vCdPessoa;
    viParams.IN_TOTAL := True;
    voParams := activateCmp('FCRSVCO015', 'buscaLimiteCliente', viParams);
    if (itemXmlF('status', voParams) < 0) then begin
      raise Exception.Create(itemXml('message', voParams));
      exit;
    end;
    vNrDiaVencto := voParams.NR_DIAVENCTO;
    if (gNrDiaVencto > 0) then begin
      if (vNrDiaVencto > gNrDiaVencto) then begin
        raise Exception.Create('O cliente ' + FloatToStr(vCdPessoa) + ' possui fatura com ' + FloatToStr(vNrDiaVencto) + ' dia(s) vencida + ' / ' + o que ultrapassa o limite de ' + FloatToStr(gNrDiaVencto) + ' dia(s).', cDS_METHOD);
        return(-2);
      end;
    end;
  end;

  if debug then MensagemLogTempo('limite');

  vCdPessoaAnt := 0;
  fTRA_TRANSACAO.Limpar();

  vInInclusao := True;

  if (vNrTransacao > 0) then begin
    fTRA_TRANSACAO.Append();
    fTRA_TRANSACAO.CD_EMPRESA := vCdEmpresa;
    fTRA_TRANSACAO.NR_TRANSACAO := vNrTransacao;
    fTRA_TRANSACAO.DT_TRANSACAO := vDtTransacao;
    fTRA_TRANSACAO.Consultar(nil);
    if (xStatus = -7) then begin
      fTRA_TRANSACAO.Consultar(nil);
      if (fTRA_TRANSACAO.TP_SITUACAO <> 1) and (fTRA_TRANSACAO.TP_SITUACAO <> 2) and (fTRA_TRANSACAO.TP_SITUACAO <> 8) then begin
        raise Exception.Create('Transação não pode ser alterada pois não está em andamento!' + ' / ' + cDS_METHOD);
        exit;
      end;
      vCdPessoaAnt := fTRA_TRANSACAO.CD_PESSOA;
    end;
    delitem(pParams, 'CD_EMPRESA');
    delitem(pParams, 'NR_TRANSACAO');
    delitem(pParams, 'DT_TRANSACAO');

    if (vCdPessoaAnt <> vCdPessoa) and (vCdPessoaAnt > 0) then begin
      if not (fTRA_REMDES.IsEmpty()) then begin
        voParams := tTRA_REMDES.Excluir();
        if (itemXmlF('status', voParams) < 0) then begin
          raise Exception.Create(itemXml('message', voParams));
          exit;
        end;
      end;
    end;

    vInInclusao := False;
  end;

  if debug then MensagemLogTempo('endereco');

  fTRA_TRANSACAO.SetValues(pParams);
  fTRA_TRANSACAO.NR_SEQENDERECO := vNrSeqendereco;
  if (fTRA_TRANSACAO.CD_EMPFAT = 0) then begin
    fTRA_TRANSACAO.CD_EMPFAT := fTRA_TRANSACAO.CD_EMPRESA;
  end;

  fGER_EMPRESA.Limpar();
  fGER_EMPRESA.CD_EMPRESA := vCdEmpresa;
  fGER_EMPRESA.Listar(nil);
  if (xStatus >= 0) then begin
    fTRA_TRANSACAO.CD_GRUPOEMPRESA := fGER_EMPRESA.CD_GRUPOEMPRESA;
  end else begin
    raise Exception.Create('Empresa ' + FloatToStr(vCdEmpresa) + ' não cadastrada!' + ' / ' + cDS_METHOD);
    exit;
  end;

  if debug then MensagemLogTempo('empresa');

  fGER_OPERACAO.Limpar();
  fGER_OPERACAO.CD_OPERACAO := vCdOperacao;
  fGER_OPERACAO.Listar(nil);
  if (xStatus >= 0) then begin
    fTRA_TRANSACAO.TP_OPERACAO := fGER_OPERACAO.TP_OPERACAO;
  end else begin
    raise Exception.Create('Operação ' + FloatToStr(vCdOperacao) + ' não cadastrada!' + ' / ' + cDS_METHOD);
    exit;
  end;
  if (fGER_OPERACAO.CD_OPERFAT = 0) then begin
    raise Exception.Create('Operação ' + fGER_OPERACAO.CD_OPERACAO + ' não possui operação de movimento!' + ' / ' + cDS_METHOD);
    exit;
  end;

  if debug then MensagemLogTempo('operacao faturamento');

  fPES_PESSOA.Limpar();
  fPES_PESSOA.CD_PESSOA := vCdPessoa;
  fPES_PESSOA.Listar(nil);
  if (itemXmlF('status', voParams) < 0) then begin
    raise Exception.Create('Pessoa ' + FloatToStr(vCdPessoa) + ' não cadastrada!' + ' / ' + cDS_METHOD);
    exit;
  end;
  if (fGER_OPERACAO.TP_MODALIDADE = 4) and (fGER_OPERACAO.TP_OPERACAO = 'S') then begin
    if (fTRA_TRANSACAO.CD_PESSOA = gCdClientePdv) then begin
      viParams := '';
      viParams.CD_PESSOA := fTRA_TRANSACAO.CD_PESSOA;
      voParams := activateCmp('ADMSVCO025', 'CD_CLIENTE_PDV_EMP', viParams);
      if (itemXmlF('status', voParams) < 0) then begin
        raise Exception.Create(itemXml('message', voParams));
        exit;
      end;
    end;
  end;

  if debug then MensagemLogTempo('pessoa');

  vNrDiaUltCompra := xParamEmp.NR_DIAS_ULTCOMPRA_CLIENTE;
  //vCdClientePdvEmp := xParamEmp.CD_CLIENTE_PDV_EMP;

  if (vNrDiaUltCompra > 0) and ((fGER_OPERACAO.TP_MODALIDADE = 4) or (fGER_OPERACAO.TP_MODALIDADE = 7) or (fGER_OPERACAO.TP_MODALIDADE = 'C')) and (fGER_OPERACAO.TP_OPERACAO = 'S') then begin
    if (vCdPessoa <> gCdClientePdv) {and (vCdPessoa <> vCdClientePdvEmp)} and (fPES_PESSOA.TP_PESSOA = 'F') then begin
      viParams := '';
      viParams.CD_PESSOA := vCdPessoa;
      voParams := activateCmp('PESSVCO005', 'buscaDadosPessoaFisica', viParams);
      if (itemXmlF('status', voParams) < 0) then begin
        raise Exception.Create(itemXml('message', voParams));
        exit;
      end;

      vDtSPC := voParams.DT_ATUALIZSPC;
      if (vDtSPC <> 0) then begin
        vNrDiaSPC := vDtSistema - vDtSPC;
        if (vNrDiaSPC > vNrDiaUltCompra) then begin
          raise Exception.Create('O cliente ' + FloatToStr(vCdPessoa) + ' está a ' + FloatToStr(vNrDiaSPC) + ' dia(s) sem efetuar consulta SPC. Verificar o cadastro!' + ' / ' + cDS_METHOD);
          exit;
        end;
      end else begin
        raise Exception.Create('O cliente ' + FloatToStr(vCdPessoa) + ' não possui consulta SPC. Verificar o cadastro!' + ' / ' + cDS_METHOD);
        exit;
      end;
    end;
  end;

  if debug then MensagemLogTempo('pessoa - fisica');

  if (fGER_OPERACAO.TP_OPERACAO = 'S') and ((fGER_OPERACAO.TP_MODALIDADE = 4) or (fGER_OPERACAO.TP_MODALIDADE = 7) or (fGER_OPERACAO.TP_MODALIDADE = 8) or (fGER_OPERACAO.TP_MODALIDADE = 'C')) then begin
    fPES_CLIENTE.Limpar();
    fPES_CLIENTE.CD_CLIENTE := vCdPessoa;
    fPES_CLIENTE.Listar(nil);
    fPES_CLIENTE.First();
    if not (fPES_CLIENTE.IsDatabase()) then begin
      raise Exception.Create('Cliente ' + FloatToStr(vCdPessoa) + ' não cadastrado!' + ' / ' + cDS_METHOD);
      exit;
    end;
    if (fPES_CLIENTE.IN_BLOQUEADO) then begin
      if (vInNaoVerifCliBloq = False) and (vCdPessoaAnt <> fPES_CLIENTE.CD_CLIENTE) then begin
        raise Exception.Create('Cliente ' + FloatToStr(vCdPessoa) + ' bloqueado!' + ' / ' + cDS_METHOD);
        return(-3);
      end;
    end;
    if (fPES_CLIENTE.IN_INATIVO) then begin
      if (vInImpressao) then begin
      end else begin
        raise Exception.Create('Cliente ' + FloatToStr(vCdPessoa) + ' inativo!' + ' / ' + cDS_METHOD);
        exit;
      end;
    end;
  end;

  if debug then MensagemLogTempo('cliente');

  viParams := '';
  viParams.CD_PESSOA := fPES_CLIENTE.CD_CLIENTE;
  viParams.CD_PESSOAANT := vCdPessoaAnt;
  viParams.IN_NAOGRAVARGUIAREPRE := vInNaoGravaGuiaRepre;
  voParams := validaGuiaRepreCliente(viParams);
  if (itemXmlF('status', voParams) < 0) then begin
    raise Exception.Create(itemXml('message', voParams));
    exit;
  end;

  if debug then MensagemLogTempo('guia / representante');

  if (fGER_OPERACAO.TP_MODALIDADE = 2) then begin
    vCdCCusto := fGER_EMPRESA.CD_CCUSTO;
    fGER_EMPRESA.Limpar();
    fGER_EMPRESA.CD_PESSOA := vCdPessoa;
    fGER_EMPRESA.Listar(nil);
    if (itemXmlF('status', voParams) < 0) then begin
      raise Exception.Create('Pessoa ' + FloatToStr(vCdPessoa) + ' não está relacionada a nenhuma empresa para tranferência.' + ' / ' + cDS_METHOD);
      exit;
    end;
    if (fGER_EMPRESA.CD_CCUSTO > 0) and (vCdCCusto = 0) or (fGER_EMPRESA.CD_CCUSTO = 0) and (vCdCCusto > 0) then begin
      raise Exception.Create('Empresa ' + fGER_EMPRESA.CD_EMPRESA + ' incompatível para transferência com ' + FloatToStr(vCdEmpresa) + '!' + ' / ' + cDS_METHOD);
      exit;
    end;
    fGER_EMPRESA.Limpar();
    fGER_EMPRESA.CD_EMPRESA := vCdEmpresa;
    fGER_EMPRESA.Listar(nil);
    if (itemXmlF('status', voParams) < 0) then begin
      raise Exception.Create('Empresa ' + FloatToStr(vCdEmpresa) + ' não cadastrada!' + ' / ' + cDS_METHOD);
      exit;
    end;
    if (vCdPessoa = fGER_EMPRESA.CD_PESSOA) and (fGER_OPERACAO.TP_DOCTO = 1) then begin
      raise Exception.Create('Não é permitido fazer transferência para a mesma empresa!' + ' / ' + cDS_METHOD);
      exit;
    end;
  end;

  if debug then MensagemLogTempo('transferencia');

  if (vNrTransacao = 0) then begin
    vLstGlobal := '';
    vLstGlobal.CD_GRUPOEMPRESA := fTRA_TRANSACAO.CD_GRUPOEMPRESA;
    vLstGlobal.CD_USUARIO := PARAM_GLB.CD_USUARIO;

    if (gTpNumeracaoTra = 01) then begin
      viParams := '';
      viParams.NM_ENTIDADE := 'TRA_TRANSACAO';
      viParams.NM_ATRIBUTO := 'NR_TRANSACAO';
      viParams.DT_SEQUENCIA := vDtTransacao;
      voParams := activateCmp('GERSVCO011', 'getNumSeq', viParams);
      if (itemXmlF('status', voParams) < 0) then begin
        raise Exception.Create(itemXml('message', voParams));
        exit;
      end;
      vNrTransacao := voParams.NR_SEQUENCIA;
    end else if (gTpNumeracaoTra = 02) then begin
      viParams := '';
      viParams.NM_ENTIDADE := 'TRA_TRANSACAO';
      viParams.NM_ATRIBUTO := 'NR_TRANSACAO';
      viParams.DT_SEQUENCIA := '01/01/2001';
      voParams := activateCmp('GERSVCO011', 'getNumSeq', viParams);
      if (itemXmlF('status', voParams) < 0) then begin
        raise Exception.Create(itemXml('message', voParams));
        exit;
      end;
      vNrTransacao := voParams.NR_SEQUENCIA;
    end else begin
      viParams := '';
      viParams.NM_ENTIDADE := 'TRA_TRANSACAO';
      viParams.NM_ATRIBUTO := 'NR_TRANSACAO';
      voParams := activateCmp('GERSVCO031', 'getNumSeq', viParams);
      if (itemXmlF('status', voParams) < 0) then begin
        raise Exception.Create(itemXml('message', voParams));
        exit;
      end;
      vNrTransacao := voParams.NR_SEQUENCIA;
    end;

    fTRA_TRANSACAO.NR_TRANSACAO := vNrTransacao;
  end;

  if debug then MensagemLogTempo('sequencia');

  if (fTRA_TRANSACAO.DT_TRANSACAO <> vDtSistema) and (vInInclusao) and (vInValidaData) then begin
    vDsMensagem := 'DESCRICAO=A transação ' + FloatToStr(vCdEmpresa) + ' / ' + FloatToStr(vNrTransacao) + ' / ' + DateToStr(vDtTransacao) + ' difere da data do sistema';
    vDsMensagem := vDsMensagem + ' ' + DateToStr(vDtSistema) + '!';
    raise Exception.Create(vDsMensagem + ' / ' + cDS_METHOD);
    exit;
  end;
  if (fTRA_TRANSACAO.IN_ACEITADEV = '') then begin
    fTRA_TRANSACAO.IN_ACEITADEV := True;
  end;
  if (fTRA_TRANSACAO.TP_SITUACAO = '') then begin
    fTRA_TRANSACAO.TP_SITUACAO := 1;
    if (gInGravaTraBloq) then begin
      fTRA_TRANSACAO.TP_SITUACAO := 8;
    end;
  end;

  fTRA_TRANSACAO.TP_ORIGEMEMISSAO := vTpOrigemEmissao;

  viParams := '';
  voParams := calculaTotalTransacao(viParams);
  if (itemXmlF('status', voParams) < 0) then begin
    raise Exception.Create(itemXml('message', voParams));
    exit;
  end;

  if debug then MensagemLogTempo('calcula total');

  fTRA_TRANSACAO.CD_OPERADOR := PARAM_GLB.CD_USUARIO;
  if (fTRA_TRANSACAO.CD_USURELAC = '') then begin
    fTRA_TRANSACAO.CD_USURELAC := PARAM_GLB.CD_USUARIO;
  end;

  if (vInHomologacaoPAF) and (vInVendaEcf) then begin
    //Data Hora Impressora
    viParams := '';
    voParams := activateCmp('PAFSVCO003', 'getDataHoraImpressora', viParams);
    if (itemXmlF('status', voParams) < 0) then begin
      raise Exception.Create(itemXml('message', voParams));
      exit;
    end;
    vDtHoraEcf := voParams.DS_DATAHORA;
    fTRA_TRANSACAO.DT_IMPRESSAO := vDtHoraEcf;
  end;

  fTRA_TRANSACAO.DT_CADASTRO := Now;

  if (vCdEmpresaOri > 0) and (vNrTransacaoOri > 0) and (vDtTransacaoOri <> 0) then begin
    fTRA_TRANSACAO.CD_EMPRESAORI := vCdEmpresaOri;
    fTRA_TRANSACAO.NR_TRANSACAOORI := vNrTransacaoOri;
    fTRA_TRANSACAO.DT_TRANSACAOORI := vDtTransacaoOri;
  end;

  voParams := tTRA_TRANSACAO.Salvar();
  if (itemXmlF('status', voParams) < 0) then begin
    raise Exception.Create(itemXml('message', voParams));
    exit;
  end;

  vNmCheckout := PARAM_GLB.NM_CHECKOUT;
  if (vNmCheckout <> '') then begin
    viParams := '';
    viParams.CD_EMPRESA := vCdEmpresa;
    viParams.NR_TRANSACAO := vNrTransacao;
    viParams.DT_TRANSACAO := vDtTransacao;
    viParams.NM_CHECKOUT := vNmCheckout;
    viParams.IN_CHECKOUT := True;
    voParams := activateCmp('TRASVCO016', 'gravaDadosAdicionais', viParams);
    if (itemXmlF('status', voParams) < 0) then begin
      raise Exception.Create(itemXml('message', voParams));
      exit;
    end;
  end;

  vDtBaseParcela := PARAM_GLB.DT_BASE_VENCTO_FAT;
  if (vDtBaseParcela <> 0) then begin
    viParams := '';
    viParams.CD_EMPRESA := vCdEmpresa;
    viParams.NR_TRANSACAO := vNrTransacao;
    viParams.DT_TRANSACAO := vDtTransacao;
    viParams.DT_BASEPARCELA := vDtBaseParcela;
    viParams.IN_BASEPARCELA := True;
    voParams := activateCmp('TRASVCO016', 'gravaDadosAdicionais', viParams);
    if (itemXmlF('status', voParams) < 0) then begin
      raise Exception.Create(itemXml('message', voParams));
      exit;
    end;
  end;

  if ((fGER_OPERACAO.TP_MODALIDADE = 4) or (fGER_OPERACAO.TP_MODALIDADE = 3)) and (gInGuiaReprAuto) and (gTpTabPrecoPed = 2) and (fTRA_TRANSACAO.CD_REPRESENTANT <> 0) then begin
    viParams := '';
    viParams.CD_CLIENTE := fTRA_TRANSACAO.CD_PESSOA;
    viParams.CD_REPRESENTANT := fTRA_TRANSACAO.CD_REPRESENTANT;
    voParams := activateCmp('PEDSVCO008', 'buscaTabelaPreco', viParams);
    if (itemXmlF('status', voParams) < 0) then begin
      raise Exception.Create(itemXml('message', voParams));
      exit;
    end;

    vDsLstTabPreco := voParams.CD_TABPRECO;

    getitem(vCdTabPreco, vDsLstTabPreco, 1);

    viParams := '';
    viParams.CD_EMPRESA := vCdEmpresa;
    viParams.NR_TRANSACAO := vNrTransacao;
    viParams.DT_TRANSACAO := vDtTransacao;
    viParams.CD_TABPRECO := vCdTabPreco;
    viParams.IN_TABPRECO := True;
    viParams.IN_TABPRECOZERO := True;
    voParams := activateCmp('TRASVCO016', 'gravaDadosAdicionais', viParams);
    if (itemXmlF('status', voParams) < 0) then begin
      raise Exception.Create(itemXml('message', voParams));
      exit;
    end;
  end;

  if debug then MensagemLogTempo('adicional transacao');

  gInTransacaoItem := False;

  //if (pParams.IN_GERAREMDES) then begin
    viParams := '';
    viParams.CD_EMPRESA := fTRA_TRANSACAO.CD_EMPRESA;
    viParams.NR_TRANSACAO := fTRA_TRANSACAO.NR_TRANSACAO;
    viParams.DT_TRANSACAO := fTRA_TRANSACAO.DT_TRANSACAO;
    voParams := gravaEnderecoTransacao(viParams);
    if (itemXmlF('status', voParams) < 0) then begin
      raise Exception.Create(itemXml('message', voParams));
      exit;
    end;
  //end;

  Result := '';
  Result.CD_EMPRESA := fTRA_TRANSACAO.CD_EMPRESA;
  Result.NR_TRANSACAO := fTRA_TRANSACAO.NR_TRANSACAO;
  Result.DT_TRANSACAO := fTRA_TRANSACAO.DT_TRANSACAO;
  exit;
end;

//-------------------------------------------------------------------
function T_TRASVCO004.validaItemTransacao(pParams : String) : String;
//-------------------------------------------------------------------
const
  cDS_METHOD = 'ADICIONAL=Operação: T_TRASVCO004.validaItemTransacao()';
var
  viParams, voParams, vCdCST, vCdBarraPrd, vDsUFOrigem, vDsUFDestino, vDsErro, vCdMPTer, vCdTipi : String;
  vTpItem, vDsServico, vDsMP, vCdEspecieMP, vDsRegProduto, vDsProduto : String;
  vCdEmpresa, vCdCFOP, vNrTransacao, vCdProduto, vCdPromocao, vCdCompVend, vQtProduto : Real;
  vVlUnitBruto, vVlTotalBruto, vVlUnitLiquido, vVlTotalLiquido, vTpAreaComercio, vCdServico : Real;
  vVlUnitDesc, vVlTotalDesc, vPrDesconto, vQtEmbalagem, vVlCalc, vPesTerc, vCdTabPreco : Real;
  {vTpLote,} vTpInspecao, vVlOriginal, vVlBase : Real;
  vDtTransacao, vDtValor : TDateTime;
  vInCodigo, vTpValidaVlZerado, vInValidaVlZerado, vInProdutoBloq : Boolean;
  vInDadosOperacao, vInServico, vInMatPrima, vInProdAcabado, vInValorPadraoTransf : Boolean;
begin
  vCdEmpresa := pParams.CD_EMPRESA;
  vNrTransacao := pParams.NR_TRANSACAO;
  vDtTransacao := pParams.DT_TRANSACAO;
  vCdBarraPrd := pParams.CD_BARRAPRD;
  vCdMPTer := pParams.CD_MPTER;
  vCdServico := pParams.CD_SERVICO;
  vInCodigo := pParams.IN_CODIGO;
  vInValidaVlZerado := pParams.IN_VALIDAVLZERADO;
  vQtEmbalagem := pParams.QT_SOLICITADA;
  vVlUnitBruto := pParams.VL_BRUTO;
  vVlUnitLiquido := pParams.VL_LIQUIDO;
  vVlUnitDesc := pParams.VL_DESCONTO;
  vCdCompVend := pParams.CD_COMPVEND;
  vCdCFOP := pParams.CD_CFOP;
  vCdCST := pParams.CD_CST;
  vDtValor := pParams.DT_VALOR;
  vTpAreaComercio := pParams.TP_AREACOMERCIO;
  vPesTerc := pParams.CD_PESSOATERC;
  vTpItem := pParams.TP_ITEM;
  vCdTabPreco := pParams.CD_TABPRECO;
  gCdEspecieServico := PARAM_GLB.CD_ESPECIE_SERVICO_TRA;
  vDsProduto := pParams.DS_PRODUTO;
  vInValorPadraoTransf := pParams.IN_VALOR_PADRAO_TRANSF;

  vVlTotalBruto := 0;
  vVlTotalLiquido := 0;
  vVlTotalDesc := 0;

  if (vCdEmpresa = 0) then begin
    raise Exception.Create('Empresa não informada!' + ' / ' + cDS_METHOD);
    exit;
  end;
  if (vNrTransacao = 0) then begin
    raise Exception.Create('Número transação não informado!' + ' / ' + cDS_METHOD);
    exit;
  end;
  if (vDtTransacao = 0) then begin
    raise Exception.Create('Data transação não informada!' + ' / ' + cDS_METHOD);
    exit;
  end;

  if debug then MensagemLogTempo('inicio');

  fTRA_TRANSACAO.Limpar();
  fTRA_TRANSACAO.CD_EMPRESA := vCdEmpresa;
  fTRA_TRANSACAO.NR_TRANSACAO := vNrTransacao;
  fTRA_TRANSACAO.DT_TRANSACAO := vDtTransacao;
  fTRA_TRANSACAO.Listar(nil);
  if (itemXmlF('status', voParams) < 0) then begin
    raise Exception.Create('Transação ' + FloatToStr(vNrTransacao) + ' não cadastrada!' + ' / ' + cDS_METHOD);
    exit;
  end;
  if (fTRA_TRANSACAO.TP_SITUACAO <> 1) and (fTRA_TRANSACAO.TP_SITUACAO <> 8) then begin
    raise Exception.Create('Não é possível inserir itens na transação ' + fTRA_TRANSACAO.CD_EMPFAT + ' / ' + fTRA_TRANSACAO.NR_TRANSACAO + ' pois não está em andamento/bloqueada!' + ' / ' + cDS_METHOD);
    exit;
  end;

  if debug then MensagemLogTempo('transacao');

  vDsMP := '';
  vCdEspecieMP := '';
  vDsServico := '';
  vDsRegProduto := '';

  if (vTpItem = 'S') then begin
    if (vCdServico = 0) then begin
      raise Exception.Create('Serviço não informado!' + ' / ' + cDS_METHOD);
      exit;
    end;
    if (vInDadosOperacao) and (vInServico <> True) then begin
      raise Exception.Create('A operação ' + fTRA_TRANSACAO.CD_OPERACAO + ' da transação não é uma operação de serviço!' + ' / ' + cDS_METHOD);
      exit;
    end;

    viParams := '';
    viParams.CD_SERVICO := vCdServico;
    voParams := activateCmp('PCPSVCO020', 'buscaDadosServico', viParams);
    if (itemXmlF('status', voParams) < 0) then begin
      raise Exception.Create(itemXml('message', voParams));
      exit;
    end;
    vDsServico := voParams.DS_SERVICO;
  end else begin
    if (vCdBarraPrd = '') and (vCdMPTer = '') then begin
      raise Exception.Create('Produto não informado!' + ' / ' + cDS_METHOD);
      exit;
    end;
    if (vCdMPTer <> '') then begin
      viParams := '';
      if (vPesTerc <> 0) then begin
        viParams.CD_PESSOA := vPesTerc;
      end else begin
        viParams.CD_PESSOA := fTRA_TRANSACAO.CD_PESSOA;
      end;
      viParams.CD_MPTER := vCdMPTer;
      voParams := activateCmp('GERSVCO046', 'buscaDadosMPTerceito', viParams);
      if (itemXmlF('status', voParams) < 0) then begin
        raise Exception.Create(itemXml('message', voParams));
        exit;
      end;
      vDsMP := voParams.DS_MP;
      vCdEspecieMP := voParams.CD_ESPECIE;
      vCdTipi := voParams.CD_TIPI;
    end else begin
      if (vInDadosOperacao) and (vInProdAcabado <> True) and (vInMatPrima <> True) then begin
        raise Exception.Create('A operação ' + fTRA_TRANSACAO.CD_OPERACAO + ' da transação não é uma operação de produto acabado ou matéria-prima!' + ' / ' + cDS_METHOD);
        exit;
      end;

      viParams := '';
      viParams.CD_EMPRESA := vCdEmpresa;
      viParams.CD_OPERACAO := fTRA_TRANSACAO.CD_OPERACAO;
      //voParams := activateCmp('GERSVCO054', 'dadosAdicionaisOperacao', viParams);
      if (itemXmlF('status', voParams) < 0) then begin
        raise Exception.Create(itemXml('message', voParams));
        exit;
      end;
      vInProdAcabado := voParams.IN_PRODACABADO;
      vInMatPrima := voParams.IN_MATPRIMA;
      //vTpLote := voParams.TP_LOTE;
      vTpInspecao := voParams.TP_INSPECAO;
      vInProdutoBloq := voParams.IN_PRODUTOBLOQ;

      viParams := '';
      viParams.CD_BARRAPRD := vCdBarraPrd;
      viParams.IN_CODIGO := vInCodigo;
      viParams.CD_EMPRESA := vCdEmpresa;
      viParams.IN_PRODACABADO := vInProdAcabado;
      viParams.IN_MATPRIMA := vInMatPrima;
      //viParams.TP_LOTE := vTpLote;
      viParams.TP_INSPECAO := vTpInspecao;
      viParams.IN_PRODUTOBLOQ := vInProdutoBloq;
      voParams := activateCmp('PRDSVCO004', 'verificaProduto', viParams);
      if (itemXmlF('status', voParams) < 0) then begin
        raise Exception.Create(itemXml('message', voParams));
        exit;
      end;
      vCdProduto := voParams.CD_PRODUTO;
      if (vCdProduto = 0) then begin
        raise Exception.Create('Produto ' + vCdBarraPrd + ' inválido' + ' / ' + cDS_METHOD);
        exit;
      end;

      if (vQtEmbalagem = 0) then begin
        vQtEmbalagem := voParams.QT_EMBALAGEM;
        if (vQtEmbalagem = 0) then begin
          vQtEmbalagem := 1;
        end;
      end else begin
        vQtProduto := voParams.QT_EMBALAGEM;
        if (vQtProduto > 0) then begin
          vQtEmbalagem := vQtEmbalagem * vQtProduto;
        end;
      end;

      if (vQtEmbalagem > 99999999) then begin
        raise Exception.Create('A quantidade não pode ser superior a 99.999.999!' + ' / ' + cDS_METHOD);
        exit;
      end;

      viParams := '';
      viParams.CD_PRODUTO := vCdProduto;
      viParams.QT_QUANTIDADE := vQtEmbalagem;
      voParams := activateCmp('PRDSVCO008', 'validaQtdFracionada', viParams);
      if (itemXmlF('status', voParams) < 0) then begin
        raise Exception.Create(itemXml('message', voParams));
        exit;
      end;

      if (gCdEmpParam = 0) or (gCdEmpParam <> vCdEmpresa) then begin
        getParam(pParams);
        gCdEmpParam := vCdEmpresa;
      end;

      viParams := '';
      viParams.CD_PRODUTO := vCdProduto;
      voParams := activateCmp('GERSVCO046', 'buscaDadosProduto', viParams);
      if (itemXmlF('status', voParams) < 0) then begin
        raise Exception.Create(itemXml('message', voParams));
        exit;
      end;

      vDsRegProduto := voParams;

      if (vDsRegProduto.CD_CST = '') then begin
        raise Exception.Create('Produto ' + FloatToStr(vCdProduto) + ' sem CST cadastrado!' + ' / ' + cDS_METHOD);
        exit;
      end;
      if (vDsRegProduto.CD_ESPECIE = '') then begin
        raise Exception.Create('Produto ' + FloatToStr(vCdProduto) + ' sem espécie cadastrada!' + ' / ' + cDS_METHOD);
        exit;
      end;
      if (vInCodigo <> True) and (gDsSepBarraPrd <> '') then begin
        if (Pos(gDsSepBarraPrd, vCdBarraPrd) > 0) then begin
          fTRA_TRANSITEM.Limpar();
          fTRA_TRANSITEM.CD_BARRAPRD := vCdBarraPrd;
          fTRA_TRANSITEM.Listar(nil);
          if (xStatus >= 0) then begin
            raise Exception.Create('Código de barras ' + vCdBarraPrd + ' já cadastrado na transação ' + fTRA_TRANSACAO.CD_EMPFAT + ' / ' + fTRA_TRANSACAO.NR_TRANSACAO + '!' + ' / ' + cDS_METHOD);
            exit;
          end;
        end;
      end;
    end;
  end;

  if debug then MensagemLogTempo('produto');

  if not (gInTransacaoItem) then begin
    fV_PES_ENDERECO.Limpar();
    fV_PES_ENDERECO.CD_PESSOA := fTRA_TRANSACAO.CD_PESSOA;
    fV_PES_ENDERECO.NR_SEQUENCIA := fTRA_TRANSACAO.NR_SEQENDERECO;
    fV_PES_ENDERECO.Listar(nil);
    if (itemXmlF('status', voParams) < 0) then begin
      if ((fGER_OPERACAO.TP_DOCTO = 2) or (fGER_OPERACAO.TP_DOCTO = 3)) and ((fGER_OPERACAO.TP_MODALIDADE = 4) or (fGER_OPERACAO.TP_MODALIDADE = 8) or (fGER_OPERACAO.TP_MODALIDADE = 3)) then begin
        if (gCdPessoaEndPadrao <> 0) then begin
          fV_PES_ENDERECO.Limpar();
          fV_PES_ENDERECO.CD_PESSOA := gCdPessoaEndPadrao;
          fV_PES_ENDERECO.NR_SEQUENCIA := fTRA_TRANSACAO.NR_SEQENDERECO;
          fV_PES_ENDERECO.Listar(nil);
          if (itemXmlF('status', voParams) < 0) then begin
            raise Exception.Create('endereço ' + fTRA_TRANSACAO.NR_SEQENDERECO + ' não cadastrado para a pessoa ' + FloatToStr(gCdPessoaEndPadrao) + '!' + ' / ' + cDS_METHOD);
            exit;
          end;
        end else begin
          raise Exception.Create('endereço ' + fTRA_TRANSACAO.NR_SEQENDERECO + ' não cadastrado para a pessoa ' + fPES_PESSOA.CD_PESSOA + '!' + ' / ' + cDS_METHOD);
          exit;
        end;
      end else begin
        raise Exception.Create('endereço ' + fTRA_TRANSACAO.NR_SEQENDERECO + ' não cadastrado para a pessoa ' + fPES_PESSOA.CD_PESSOA + '!' + ' / ' + cDS_METHOD);
        exit;
      end;
    end;
  end;

  if debug then MensagemLogTempo('endereco');

  if (vCdCFOP = 0) then begin
    viParams := '';
    if (vTpItem   = 'S') then begin
      viParams.CD_SERVICO := vCdServico;
    end else begin
      if (vCdMPTer <> '') then begin
        viParams.CD_MPTER := vCdMPTer;
      end else begin
        viParams.CD_PRODUTO := vCdProduto;
      end;
    end;

    fTRA_REMDES.Limpar();
    fTRA_REMDES.CD_EMPRESA := vCdEmpresa;
    fTRA_REMDES.NR_TRANSACAO := vNrTransacao;
    fTRA_REMDES.DT_TRANSACAO := vDtTransacao;
    fTRA_REMDES.Listar(nil);
    if (xStatus >= 0) then begin
      if (fTRA_REMDES.CD_PESSOA <> '') then begin
        viParams.CD_PESSOA := fTRA_REMDES.CD_PESSOA;
      end else begin
        viParams.CD_PESSOA := fTRA_TRANSACAO.CD_PESSOA;
      end;
      if (fTRA_REMDES.DS_SIGLAESTADO <> '') then begin
        viParams.UF_DESTINO := fTRA_REMDES.DS_SIGLAESTADO;
      end else begin
        viParams.UF_DESTINO := fV_PES_ENDERECO.DS_SIGLAESTADO;
      end;
    end else begin
      viParams.CD_PESSOA := fTRA_TRANSACAO.CD_PESSOA;
      viParams.UF_DESTINO := fV_PES_ENDERECO.DS_SIGLAESTADO;
    end;

    viParams.CD_OPERACAO := fGER_OPERACAO.CD_OPERACAO;
    viParams.TP_AREACOMERCIO := vTpAreaComercio;
    viParams.TP_ORIGEMEMISSAO := fTRA_TRANSACAO.TP_ORIGEMEMISSAO;
    voParams := activateCmp('FISSVCO015', 'buscaCFOP', viParams);
    if (itemXmlF('status', voParams) < 0) then begin
      raise Exception.Create(itemXml('message', voParams));
      exit;
    end;

    vCdCFOP := voParams.CD_CFOP;
  end;

  if (vCdCFOP = 0) then begin
    raise Exception.Create('Nenhum CFOP encontrado para o produto ' + FloatToStr(vCdProduto) + ' da transação ' + FloatToStr(vNrTransacao) + '!' + ' / ' + cDS_METHOD);
    exit;
  end;

  if debug then MensagemLogTempo('CFPO');

  if (vCdCST = '') then begin
    viParams := '';
    if (vTpItem   = 'S') then begin
      viParams.CD_SERVICO := vCdServico;
    end else begin
      if (vCdMPTer <> '') then begin
        viParams.CD_MPTER := vCdMPTer;
      end else begin
        viParams.CD_PRODUTO := vCdProduto;
      end;
    end;
    viParams.CD_OPERACAO := fGER_OPERACAO.CD_OPERACAO;
    viParams.UF_DESTINO := fV_PES_ENDERECO.DS_SIGLAESTADO;
    viParams.CD_PESSOA := fTRA_TRANSACAO.CD_PESSOA;
    viParams.TP_AREACOMERCIO := vTpAreaComercio;
    viParams.TP_ORIGEMEMISSAO := fTRA_TRANSACAO.TP_ORIGEMEMISSAO;
    viParams.CD_CFOP := vCdCFOP;
    voParams := activateCmp('FISSVCO015', 'buscaCST', viParams);
    if (itemXmlF('status', voParams) < 0) then begin
      raise Exception.Create(itemXml('message', voParams));
      exit;
    end;

    vCdCST := voParams.CD_CST;
  end;

  if (vCdCST = '') then begin
    raise Exception.Create('Produto ' + FloatToStr(vCdProduto) + ' sem CST cadastrado!' + ' / ' + cDS_METHOD);
    exit;
  end;

  if debug then MensagemLogTempo('CST');

  if (vCdCompVend = 0) then begin
    vCdCompVend := fTRA_TRANSACAO.CD_COMPVEND;
  end;

  if (vTpItem   = 'S') then begin
  end else begin
    if (vCdMPTer <> '') then begin
    end else begin
      if (vVlUnitBruto = 0) or (vVlUnitLiquido = 0) then begin
        if (fGER_OPERACAO.TP_OPERACAO = 'E') and (fGER_OPERACAO.TP_MODALIDADE = 4) then begin
        end else begin
          if (vCdTabPreco <> 0) then begin
            viParams := '';
            viParams.CD_EMPRESA := vCdEmpresa;
            viParams.CD_PRODUTO := vCdProduto;
            viParams.CD_TABPRECO := vCdTabPreco;
            viParams.CD_CONDPGTO := fTRA_TRANSACAO.CD_CONDPGTO;
            viParams.CD_OPERACAO := fTRA_TRANSACAO.CD_OPERACAO;
            voParams := activateCmp('PEDSVCO008', 'buscaValorProduto', viParams);
            if (itemXmlF('status', voParams) < 0) then begin
              raise Exception.Create(itemXml('message', voParams));
              exit;
            end;
            vVlUnitLiquido := voParams.VL_UNITARIO;
            vVlUnitBruto := voParams.VL_UNITARIO;
          end else begin
            viParams := '';
            viParams.CD_EMPRESA := vCdEmpresa;
            viParams.CD_PRODUTO := vCdProduto;
            viParams.CD_CONDPGTO := fTRA_TRANSACAO.CD_CONDPGTO;
            viParams.CD_OPERACAO := fTRA_TRANSACAO.CD_OPERACAO;
            viParams.DT_VALOR := vDtValor;
            viParams.IN_VALOR_PADRAO_TRANSF := vInValorPadraoTransf;
            voParams := activateCmp('GERSVCO012', 'buscaValorOperacao', viParams);
            if (itemXmlF('status', voParams) < 0) then begin
              raise Exception.Create(itemXml('message', voParams));
              exit;
            end;
            vVlBase := voParams.VL_BASE;
            vVlOriginal := voParams.VL_ORIGINAL;
            vVlUnitBruto := voParams.VL_BRUTO;
            vVlUnitLiquido := voParams.VL_LIQUIDO;
            vVlUnitDesc := voParams.VL_DESCONTO;
            vCdPromocao := voParams.CD_PROMOCAO;
          end;
          if (vCdPromocao > 0) and (gTpValorBrutoPromocao = 1) then begin
            vVlUnitBruto := voParams.VL_ORIGINAL;
            vVlUnitDesc := vVlUnitBruto - vVlUnitLiquido;
          end;
        end;
      end;
      if (vVlUnitLiquido = 0) or (vVlUnitBruto = 0) then begin
        if (fGER_OPERACAO.TP_OPERACAO = 'S') and ((fGER_OPERACAO.TP_MODALIDADE = 4) or (fGER_OPERACAO.TP_MODALIDADE = 2) or (fGER_OPERACAO.TP_MODALIDADE = 3) or (fGER_OPERACAO.TP_MODALIDADE = 7)) then begin
          raise Exception.Create('Produto ' + FloatToStr(vCdProduto) + ' com preço zerado!' + ' / ' + cDS_METHOD);
          exit;
        end;
        if (vInValidaVlZerado) then begin
          raise Exception.Create('Produto ' + FloatToStr(vCdProduto) + ' com valor zerado!' + ' / ' + cDS_METHOD);
          exit;
        end;
      end;
    end;
  end;

  if debug then MensagemLogTempo('busca valor');

  vVlCalc := vVlUnitDesc / vVlUnitBruto * 100;
  vPrDesconto := rounded(vVlCalc, 6);
  vVlCalc := vQtEmbalagem * vVlUnitBruto;
  vVlTotalBruto := rounded(vVlCalc, 2);
  vVlCalc := vQtEmbalagem * vVlUnitLiquido;
  vVlTotalLiquido := rounded(vVlCalc, 2);
  vVlTotalDesc := vVlTotalBruto - vVlTotalLiquido;
  vVlCalc := vVlTotalDesc / vQtEmbalagem;
  vVlUnitDesc := rounded(vVlCalc, 6);

  Result := '';
  if (vTpItem = 'S') then begin
    Result.CD_BARRAPRD := vCdServico;
    Result.CD_SERVICO := vCdServico;
    Result.CD_PRODUTO := vCdServico;
    Result.DS_PRODUTO := vDsServico;
    Result.CD_ESPECIE := gCdEspecieServico;
  end else begin
    if (vCdMPTer <> '') then begin
      Result.CD_BARRAPRD := vCdMPTer;
      Result.CD_MPTER := vCdMPTer;
      Result.DS_PRODUTO := vDsMP;
      Result.CD_ESPECIE := vCdEspecieMP;
      Result.CD_TIPI := vCdTipi;
    end else begin
      Result.CD_PRODUTO := vDsRegProduto.CD_PRODUTO;
      Result.CD_BARRAPRD := vCdBarraPrd;
      Result.DS_PRODUTO := vDsRegProduto.DS_PRODUTO;
      Result.CD_ESPECIE := vDsRegProduto.CD_ESPECIE;
      Result.CD_TIPI := vDsRegProduto.CD_TIPI;
    end;
  end;
  Result.CD_CST := vCdCst;
  Result.CD_CFOP := vCdCFOP;
  Result.CD_COMPVEND := vCdCompVend;
  Result.CD_PROMOCAO := vCdPromocao;
  Result.QT_SOLICITADA := vQtEmbalagem;
  Result.QT_ATENDIDA := 0;
  Result.QT_SALDO := vQtEmbalagem;
  Result.VL_UNITBRUTO := vVlUnitBruto;
  Result.VL_TOTALBRUTO := vVlTotalBruto;
  Result.VL_UNITLIQUIDO := vVlUnitLiquido;
  Result.VL_TOTALLIQUIDO := vVlTotalLiquido;
  Result.VL_UNITDESC := vVlUnitDesc;
  Result.VL_TOTALDESC := vVlTotalDesc;
  Result.VL_UNITDESCCAB := 0;
  Result.VL_TOTALDESCCAB := 0;
  Result.PR_DESCONTO := vPrDesconto;
  Result.VL_ORIGINAL := vVlOriginal;
  Result.VL_BASE := vVlBase;

  if (vPrDesconto <> 0) then begin
    Result.IN_DESCONTO := True;
  end else begin
    Result.IN_DESCONTO := False;
  end;
  if (vDsProduto <> '') then begin
    Result.DS_PRODUTO := vDsProduto;
  end;

  exit;
end;

//------------------------------------------------------------------
function T_TRASVCO004.gravaItemTransacao(pParams : String) : String;
//------------------------------------------------------------------
const
  cDS_METHOD = 'ADICIONAL=Operação: T_TRASVCO004.gravaItemTransacao()';
var
  vCdProdutoMsg, viParams, voParams, vCdCST, vDsRegistro, vDsLstImposto, vDsMensagem : String;
  vCdMPTer, vDsProduto, {vDsLstItemLote,} vCdEspecie : String;
  vQtArredondada, vCdEmpresa, vNrTransacao, vNrItem, vCdCFOP, vCdProduto, vQtEstoque, vQtSolicitadaAnt, {vTpLote,} vVlBase, vVlOriginal : Real;
  vCdCompVend, vCdDecreto, vVlCalc, vCdImposto, vVlDif, vQtDisponivel, vQtEntrada, vQtSaida, vCdServico, vCdOper : Real;
  vVlDifUnitario, vVlCalcUnitario, vVlInteiro, vVlFracionado, vNrDescItem, vNr, vCdCustoVenda, vVlUnitCustoVenda, vVlDesconto : Real;
  vDtTransacao : TDateTime;
  vInTotal, vInSoDescricao, vInProdAcabado, vInMatPrima, vInSemMovimento, {vInNaoValidaLote,} vInGravaImposto : Boolean;
  vInImpressao, vInVenda, vInBloqSaldoNeg, vInTransacao : Boolean;
  vDsLstValorVenda, vTpDescAcresc : String;
  vCdRegraFiscal : Real;
begin
  gHrInicio := Now;
  vCdEmpresa := pParams.CD_EMPRESA;
  vNrTransacao := pParams.NR_TRANSACAO;
  vDtTransacao := pParams.DT_TRANSACAO;
  vNrItem := pParams.NR_ITEM;
  vCdCST := pParams.CD_CST;
  vCdCFOP := pParams.CD_CFOP;
  vCdEspecie := pParams.CD_ESPECIE;
  vCdProduto := pParams.CD_PRODUTO;
  vDsProduto := pParams.DS_PRODUTO;
  vCdMPTer := pParams.CD_MPTER;
  vCdServico := pParams.CD_SERVICO;
  vCdCompVend := pParams.CD_COMPVEND;
  vInTotal := pParams.IN_TOTAL;
  vDsLstImposto := pParams.DS_LSTIMPOSTO;
  //vDsLstItemLote := pParams.DS_LSTITEMLOTE;
  vInSemMovimento := pParams.IN_SEMMOVIMENTO;
  vVlBase := pParams.VL_BASE;
  vVlOriginal := pParams.VL_ORIGINAL;
  gCdEspecieServico := PARAM_GLB.CD_ESPECIE_SERVICO_TRA;
  vInImpressao := pParams.IN_IMPRESSAO;
  vInTransacao := pParams.IN_TRANSACAO;
  //vInNaoValidaLote := pParams.IN_NAOVALIDALOTE;

  vTpDescAcresc := pParams.TP_DESCACRESC;//Zottis 29/04/2014 Implantação do Acréscimo   

  if (vCdEspecie = gCdEspecieServico) then begin
    vCdServico := vCdProduto;
  end;

  if (vCdServico > 0) then begin
    vCdProdutoMsg := FloatToStr(vCdServico);
  end else if (vCdMPTer <> '') then begin
    vCdProdutoMsg := vCdMPTer;
  end else begin
    vCdProdutoMsg := FloatToStr(vCdProduto);
  end;

  //Zottis 29/04/2014 Implantalção do Acréscimo
  if (vTpDescAcresc = '') then begin
    vTpDescAcresc  := 'A';
  end;//Z-

  if (vCdEmpresa = 0) then begin
    raise Exception.Create('Empresa não informada!' + ' / ' + cDS_METHOD);
    exit;
  end;
  if (vNrTransacao = 0) then begin
    raise Exception.Create('Número transação não informado!' + ' / ' + cDS_METHOD);
    exit;
  end;
  if (vDtTransacao = 0) then begin
    raise Exception.Create('Data transação não informada!' + ' / ' + cDS_METHOD);
    exit;
  end;

  if debug then MensagemLogTempo('inicio');

  fGER_EMPRESA.Limpar();
  fGER_EMPRESA.CD_EMPRESA := vCdEmpresa;
  fGER_EMPRESA.Listar(nil);
  if (itemXmlF('status', voParams) < 0) then begin
    raise Exception.Create('Empresa ' + FloatToStr(vCdEmpresa) + ' não cadastrada!' + ' / ' + cDS_METHOD);
    exit;
  end;

  if debug then MensagemLogTempo('empresa');

  fTRA_TRANSACAO.Limpar();
  fTRA_TRANSACAO.CD_EMPRESA := vCdEmpresa;
  fTRA_TRANSACAO.NR_TRANSACAO := vNrTransacao;
  fTRA_TRANSACAO.DT_TRANSACAO := vDtTransacao;
  fTRA_TRANSACAO.Listar(nil);
  if (itemXmlF('status', voParams) < 0) then begin
    raise Exception.Create('Transação ' + FloatToStr(vNrTransacao) + ' não cadastrada!' + ' / ' + cDS_METHOD);
    exit;
  end;

  if debug then MensagemLogTempo('transacao');

  if (vCdEspecie <> 'SVC') then begin
    viParams.CD_PRODUTO := vCdProduto;
    viParams.CD_OPERACAO := fGER_OPERACAO.CD_OPERACAO;
    viParams.IN_KARDEX := fGER_OPERACAO.IN_KARDEX;
    voParams := validaProdutoBalanco(viParams);
    if (itemXmlF('status', voParams) < 0) then begin
      raise Exception.Create(itemXml('message', voParams));
      exit;
    end;
  end;

  if ((gCdEmpParam = 0) or (gCdEmpParam <> fTRA_TRANSACAO.CD_EMPFAT) or (gInBloqSaldoNeg = 1)) and (gCdOperKardex = '') then begin
    viParams := '';
    viParams.CD_EMPRESA := fTRA_TRANSACAO.CD_EMPFAT;
    getParam(viParams);
    gCdEmpParam := fTRA_TRANSACAO.CD_EMPFAT;
  end;

  if (gCdOperKardex <> '') then begin
    repeat
      vCdOper := IffNuloF(getitem(gCdOperKardex, 1),0);

      fTMP_NR09.Append();
      fTMP_NR09.NR_GERAL := vCdOper;
      fTMP_NR09.Consultar(nil);
      if (xStatus = -7) then begin
        fTMP_NR09.Consultar(nil);
      end;

      delitem(gCdOperKardex, 1);
    until (gCdOperKardex = '');
  end;

  if debug then MensagemLogTempo('produto');

  if not (gInTransacaoItem) then begin
    fV_PES_ENDERECO.Limpar();
    fV_PES_ENDERECO.CD_PESSOA := fPES_PESSOA.CD_PESSOA;
    fV_PES_ENDERECO.NR_SEQUENCIA := fTRA_TRANSACAO.NR_SEQENDERECO;
    fV_PES_ENDERECO.Listar(nil);
    if (itemXmlF('status', voParams) < 0) then begin
      if ((fGER_OPERACAO.TP_DOCTO = 2) or (fGER_OPERACAO.TP_DOCTO = 3)) and ((fGER_OPERACAO.TP_MODALIDADE = 4) or (fGER_OPERACAO.TP_MODALIDADE = 8) or (fGER_OPERACAO.TP_MODALIDADE = 3)) then begin
        if (gCdPessoaEndPadrao <> 0) then begin
          fV_PES_ENDERECO.Limpar();
          fV_PES_ENDERECO.CD_PESSOA := gCdPessoaEndPadrao;
          fV_PES_ENDERECO.NR_SEQUENCIA := fTRA_TRANSACAO.NR_SEQENDERECO;
          fV_PES_ENDERECO.Listar(nil);
          if (itemXmlF('status', voParams) < 0) then begin
            raise Exception.Create('endereço ' + fTRA_TRANSACAO.NR_SEQENDERECO + ' não cadastrado para a pessoa ' + FloatToStr(gCdPessoaEndPadrao) + '!' + ' / ' + cDS_METHOD);
            exit;
          end;
        end else begin
          raise Exception.Create('endereço ' + fTRA_TRANSACAO.NR_SEQENDERECO + ' não cadastrado para a pessoa ' + fPES_PESSOA.CD_PESSOA + '!' + ' / ' + cDS_METHOD);
          exit;
        end;
      end else begin
        raise Exception.Create('endereço ' + fTRA_TRANSACAO.NR_SEQENDERECO + ' não cadastrado para a pessoa ' + fPES_PESSOA.CD_PESSOA + '!' + ' / ' + cDS_METHOD);
        exit;
      end;
    end;
  end;

  if debug then MensagemLogTempo('endereco');

  vInSoDescricao := False;

  if (vCdProduto = 0) and (vCdMPTer = '') and (vCdServico = 0) then begin
    vInSoDescricao := True;
  end else begin
    if (vCdCST = '') then begin
      raise Exception.Create('Item ' + FloatToStr(vNrItem) + ' / Produto ' + vCdProdutoMsg + ' da transação ' + FloatToStr(vNrTransacao) + ' sem CST informado!' + ' / ' + cDS_METHOD);
      exit;
    end;
    if (vCdCFOP = 0) then begin
      raise Exception.Create('Item ' + FloatToStr(vNrItem) + ' / Produto ' + vCdProdutoMsg + ' da transação ' + FloatToStr(vNrTransacao) + ' sem CFOP informado!' + ' / ' + cDS_METHOD);
      exit;
    end;
    if (vCdCompVend = 0) then begin
      raise Exception.Create('Item ' + FloatToStr(vNrItem) + ' / Produto ' + vCdProdutoMsg + ' da transação ' + FloatToStr(vNrTransacao) + ' sem Comprador/Vendedor informado!' + ' / ' + cDS_METHOD);
      exit;
    end;
    if (fGER_OPERACAO.TP_OPERACAO = 'E') then begin
      if (vCdCFOP >= 4000) then begin
        raise Exception.Create('CFOP ' + FloatToStr(vCdCFOP) + ' do produto ' + vCdProdutoMsg + ' da transação ' + FloatToStr(vNrTransacao) + ' incompatível com a operação de entrada!' + ' / ' + cDS_METHOD);
        exit;
      end;
    end else if (fGER_OPERACAO.TP_OPERACAO = 'S') then begin
      if (vCdCFOP < 5000) then begin
        raise Exception.Create('CFOP ' + FloatToStr(vCdCFOP) + ' do produto ' + vCdProdutoMsg + ' da transação ' + FloatToStr(vNrTransacao) + ' incompatível com a operação de saída!' + ' / ' + cDS_METHOD);
        exit;
      end;
    end;
    if ((fGER_OPERACAO.TP_OPERACAO = 'E') and ((fGER_OPERACAO.TP_MODALIDADE = 4) or (fGER_OPERACAO.TP_OPERACAO = 'S')) and (fGER_OPERACAO.TP_MODALIDADE = 3)) and (vCdServico = 0) then begin
      viParams := '';
      viParams.CD_FORNECEDOR := fTRA_TRANSACAO.CD_PESSOA;
      viParams.CD_PRODUTO := vCdProduto;
      voParams := activateCmp('PRDSVCO008', 'validaProdutoFornecedor', viParams);
      if (itemXmlF('status', voParams) < 0) then begin
        raise Exception.Create(itemXml('message', voParams));
        exit;
      end;
    end;
  end;

  if debug then MensagemLogTempo('validacao');

  fTRA_TRANSITEM.Limpar();
  fTRA_TRANSITEM.Append();

  vQtSolicitadaAnt := 0;

  if (vNrItem = 0) then begin
    fTRA_TRANSITEM.Limpar();
    fTRA_TRANSITEM.CD_EMPRESA := vCdEmpresa;
    fTRA_TRANSITEM.NR_TRANSACAO := vNrTransacao;
    fTRA_TRANSITEM.DT_TRANSACAO := vDtTransacao;
    voParams := tTRA_TRANSITEM.selectdb('NR_ITEM=max(NR_ITEM);');
    vNrItem := voParams.NR_ITEM + 1;

    fTRA_TRANSITEM.NR_ITEM := vNrItem;
  end else begin
    fTRA_TRANSITEM.NR_ITEM := vNrItem;
    fTRA_TRANSITEM.Consultar(nil);
    if (xStatus = -7) then begin
      fTRA_TRANSITEM.Consultar(nil);
      vQtSolicitadaAnt := fTRA_TRANSITEM.QT_SOLICITADA;
      if not (fTRA_ITEMIMPOSTO.IsEmpty()) then begin
        voParams := tTRA_ITEMIMPOSTO.Excluir();
        if (itemXmlF('status', voParams) < 0) then begin
          raise Exception.Create(itemXml('message', voParams));
          exit;
        end;
      end;
      if (fTRA_TRANSITEM.QT_SOLICITADA = 0) then begin
        viParams := '';
        viParams.CD_EMPRESA := fTRA_TRANSITEM.CD_EMPRESA;
        viParams.NR_TRANSACAO := fTRA_TRANSITEM.NR_TRANSACAO;
        viParams.DT_TRANSACAO := fTRA_TRANSITEM.DT_TRANSACAO;
        viParams.NR_ITEM := fTRA_TRANSITEM.NR_ITEM;
        voParams := activateCmp('SICSVCO005', 'arredondaQtFracionada', viParams);
        if (itemXmlF('status', voParams) < 0) then begin
          raise Exception.Create(itemXml('message', voParams));
          exit;
        end;
        vQtArredondada := voParams.QT_SOLICITADA;
      end else begin
        vQtArredondada := fTRA_TRANSITEM.QT_SOLICITADA;
      end;
    end;
  end;
  if (fGER_OPERACAO.TP_DOCTO = 2) or (fGER_OPERACAO.TP_DOCTO = 3) then begin
    if (fTRA_TRANSITEM.NR_ITEM > 990) then begin
      raise Exception.Create('Quantidade de itens da transação não pode ser maior que 990!Convênio 57/95 do SINTEGRA.' + ' / ' + cDS_METHOD);
      exit;
    end;
  end else if (gNrItemQuebraNf = 0) then begin
    if (fTRA_TRANSITEM.NR_ITEM > 990) then begin
      raise Exception.Create('Quantidade de itens da transação não pode ser maior que 990!Convênio 57/95 do SINTEGRA.' + ' / ' + cDS_METHOD);
      exit;
    end;
  end;
  if (vInSoDescricao) then begin
    fTRA_TRANSITEM.DS_PRODUTO := vDsProduto;
  end else begin
    delitem(pParams, 'CD_EMPRESA');
    delitem(pParams, 'NR_TRANSACAO');
    delitem(pParams, 'DT_TRANSACAO');
    delitem(pParams, 'NR_ITEM');

    fTRA_TRANSITEM.SetValues(pParams);
    fTRA_TRANSITEM.CD_EMPRESA := vCdEmpresa;
    fTRA_TRANSITEM.NR_TRANSACAO := vNrTransacao;
    fTRA_TRANSITEM.DT_TRANSACAO := vDtTransacao;
    fTRA_TRANSITEM.NR_ITEM := vNrItem;
    if (fTRA_TRANSACAO.TP_SITUACAO = 4) or (fTRA_TRANSACAO.TP_SITUACAO = 5) then begin
      fTRA_TRANSITEM.QT_ATENDIDA := fTRA_TRANSITEM.QT_SOLICITADA;
      fTRA_TRANSITEM.QT_SALDO := 0;
    end else begin
      fTRA_TRANSITEM.QT_SALDO := fTRA_TRANSITEM.QT_SOLICITADA;
      fTRA_TRANSITEM.QT_ATENDIDA := 0;
    end;
    if (vCdMPTer = '') and (vCdServico = 0) then begin
      viParams := '';
      viParams.CD_EMPRESA := fGER_EMPRESA.CD_EMPRESA;
      viParams.CD_PRODUTO := vCdProduto;
      voParams := activateCmp('PRDSVCO008', 'buscaDadosFilial', viParams);
      if (itemXmlF('status', voParams) < 0) then begin
        raise Exception.Create(itemXml('message', voParams));
        exit;
      end;
      vInMatPrima := voParams.IN_MATPRIMA;
      vInProdAcabado := voParams.IN_PRODACABADO;
      //vTpLote := voParams.TP_LOTE;
    end;
    (* if (vTpLote > 0) and (fTRA_TRANSACAO.TP_OPERACAO = 'S') and not (vInNaoValidaLote) and (fGER_OPERACAO.IN_KARDEX) then begin
      if (vDsLstItemLote = '') then begin
        raise Exception.Create('Lista de itens de lote não informada para o produto ' + FloatToStr(vCdProduto) + ' da transação ' + FloatToStr(vNrTransacao) + '' + ' / ' + cDS_METHOD);
        exit;
      end;
    end; *)

    if debug then MensagemLogTempo('dados filial');

    vInBloqSaldoNeg := True;
    if not (fTMP_NR09.IsEmpty()) then begin
      fTMP_NR09.Append();
      fTMP_NR09.NR_GERAL := fTRA_TRANSACAO.CD_OPERACAO;
      fTMP_NR09.Consultar(nil);
      if (xStatus = 4) then begin
        vInBloqSaldoNeg := False;
      end else begin
        fTMP_NR09.Remover();
      end;
    end;
    if (vInBloqSaldoNeg)
    and (((gInBloqSaldoNeg = 1)  or
          ((gInBloqSaldoNeg = 2) and (vInProdAcabado))  or
          ((gInBloqSaldoNeg = 3) and (vInMatPrima))  or
           (gInBloqSaldoNeg = 4)  or
          ((gInBloqSaldoNeg = 5) and (vInProdAcabado))  or
          ((gInBloqSaldoNeg = 6) and (vInMatPrima)))
    and (fTRA_TRANSACAO.TP_OPERACAO = 'S')
    and ((fGER_OPERACAO.IN_KARDEX) or (fGER_S_OPERACAO.IN_KARDEX)) and (vCdMPTer = '') and (vCdServico = 0)) then begin

      if (vInImpressao) then begin
      end else begin

        viParams := '';
        viParams.CD_GRUPOEMPRESA := fGER_EMPRESA.CD_GRUPOEMPRESA;
        viParams.CD_PRODUTO := vCdProduto;
        viParams.CD_OPERACAO := fTRA_TRANSACAO.CD_OPERACAO;
        viParams.IN_VALIDALOCAL := False;
        viParams.IN_TRANSACAO := vInTransacao;
        voParams := activateCmp('PRDSVCO015', 'verificaSaldoProduto', viParams);
        if (itemXmlF('status', voParams) < 0) then begin
          raise Exception.Create(itemXml('message', voParams));
          exit;
        end;

        vQtDisponivel := voParams.QT_DISPONIVEL;
        vQtEntrada := voParams.QT_ENTRADA;
        vQtSaida := voParams.QT_SAIDA;
        vQtEstoque := voParams.QT_ESTOQUE;

        if ((fTRA_TRANSITEM.QT_SOLICITADA - vQtSolicitadaAnt) > vQtDisponivel) then begin
          if (gInBloqSaldoNeg = 1) or (gInBloqSaldoNeg = 2) or (gInBloqSaldoNeg = 3) then begin
            raise Exception.Create('Quantidade ' + fTRA_TRANSITEM.QT_SOLICITADA + ' do produto ' + FloatToStr(vCdProduto) + ' da transação ' + FloatToStr(vNrTransacao) + ' maior que disponível ' + FloatToStr(vQtDisponivel) + '! ' + FloatToStr(vQtEstoque) + ' em estoque / ' + FloatToStr(vQtEntrada) + ' em entrada / ' + FloatToStr(vQtSaida) + ' em saída.' + ' / ' + cDS_METHOD);
            exit;
          end else if (gInBloqSaldoNeg = 4) or (gInBloqSaldoNeg = 5) or (gInBloqSaldoNeg = 6) then begin
            vDsMensagem := 'Quantidade ' + fTRA_TRANSITEM.QT_SOLICITADA + ' do produto ' + FloatToStr(vCdProduto) + ' da transação ' + FloatToStr(vNrTransacao) + ' maior que disponível ' + FloatToStr(vQtDisponivel) + '! ' + FloatToStr(vQtEstoque) + ' em estoque / ' + FloatToStr(vQtEntrada) + ' em entrada / ' + FloatToStr(vQtSaida) + ' em saída.';
          end;
        end;
      end;
    end;

  //aqui

    if (fTRA_TRANSITEM.VL_TOTALDESC > 0) or (fTRA_TRANSITEM.VL_TOTALDESCCAB > 0) then begin
      vVlDif := fTRA_TRANSITEM.VL_TOTALBRUTO - (fTRA_TRANSITEM.VL_TOTALLIQUIDO + fTRA_TRANSITEM.VL_TOTALDESC + fTRA_TRANSITEM.VL_TOTALDESCCAB);

      if (vVlDif <> 0) then begin
        if (vQtArredondada = 0) then begin
          if (fTRA_TRANSITEM.QT_SOLICITADA > 0) then begin
            vQtArredondada := fTRA_TRANSITEM.QT_SOLICITADA;
          end;
        end;
        if (fTRA_TRANSITEM.VL_TOTALDESC > fTRA_TRANSITEM.VL_TOTALDESCCAB) then begin
          fTRA_TRANSITEM.VL_TOTALDESC := fTRA_TRANSITEM.VL_TOTALDESC + vVlDif;
          vVlCalc := fTRA_TRANSITEM.VL_TOTALDESC / vQtArredondada;
          fTRA_TRANSITEM.VL_UNITDESC := rounded(vVlCalc, 6);
        end else begin
          fTRA_TRANSITEM.VL_TOTALDESCCAB := fTRA_TRANSITEM.VL_TOTALDESCCAB + vVlDif;
          vVlCalc := fTRA_TRANSITEM.VL_TOTALDESCCAB / vQtArredondada;
          fTRA_TRANSITEM.VL_UNITDESCCAB := rounded(vVlCalc, 6);
        end;
      end;
    end;
    if (fGER_OPERACAO.TP_OPERACAO = 'S') and (fGER_OPERACAO.TP_MODALIDADE = 4) then begin
      vInVenda := True;
    end else begin
      vInVenda := False;
    end;
    if ((PARAM_GLB.TP_ARREDOND_VL_UNIT_VD = 1) or (PARAM_GLB.TP_ARREDOND_VL_UNIT_VD = 2)) and (vInVenda) then begin
      if (fTRA_TRANSITEM.QT_SOLICITADA > 0) then begin
        if (fTRA_TRANSITEM.VL_UNITDESC > 0) or (fTRA_TRANSITEM.VL_UNITDESCCAB > 0) then begin
          vVlDifUnitario := fTRA_TRANSITEM.VL_UNITBRUTO - (fTRA_TRANSITEM.VL_UNITLIQUIDO + fTRA_TRANSITEM.VL_UNITDESC + fTRA_TRANSITEM.VL_UNITDESCCAB);
          if (vVlDifUnitario <> 0) then begin
            if (fTRA_TRANSITEM.VL_UNITDESC > fTRA_TRANSITEM.VL_UNITDESCCAB) then begin
              fTRA_TRANSITEM.VL_UNITDESC := fTRA_TRANSITEM.VL_UNITDESC + vVlDifUnitario;
            end else begin
              fTRA_TRANSITEM.VL_UNITDESCCAB := fTRA_TRANSITEM.VL_UNITDESCCAB + vVlDifUnitario;
            end;
          end;
        end;
        if (PARAM_GLB.TP_ARREDOND_VL_UNIT_VD = 1) then begin
          vVlCalc := rounded(fTRA_TRANSITEM.VL_UNITBRUTO, 2);
          fTRA_TRANSITEM.VL_UNITBRUTO := vVlCalc;

          vVlCalc := fTRA_TRANSITEM.VL_UNITBRUTO * fTRA_TRANSITEM.QT_SOLICITADA;
          fTRA_TRANSITEM.VL_TOTALBRUTO := rounded(vVlCalc, 2);
          fTRA_TRANSITEM.VL_TOTALLIQUIDO := fTRA_TRANSITEM.VL_TOTALBRUTO - (fTRA_TRANSITEM.VL_TOTALDESCCAB + fTRA_TRANSITEM.VL_TOTALDESC);

          vVlCalc := fTRA_TRANSITEM.VL_TOTALLIQUIDO /  fTRA_TRANSITEM.QT_SOLICITADA;
          fTRA_TRANSITEM.VL_UNITLIQUIDO := rounded(vVlCalc, 6);

        end else if (PARAM_GLB.TP_ARREDOND_VL_UNIT_VD = 2) then begin
          vVlCalc := rounded(fTRA_TRANSITEM.VL_UNITBRUTO, 2);
          fTRA_TRANSITEM.VL_UNITBRUTO := vVlCalc;

          vVlCalc := fTRA_TRANSITEM.VL_UNITBRUTO * fTRA_TRANSITEM.QT_SOLICITADA;
          vVlInteiro := int(vVlCalc);
          vVlFracionado := vVlCalc - vVlInteiro;
          vVlFracionado := int(vVlFracionado * 10000) / 10000;
          vVlCalc := vVlInteiro + vVlFracionado;
          fTRA_TRANSITEM.VL_TOTALBRUTO := vVlCalc;
          fTRA_TRANSITEM.VL_TOTALLIQUIDO := fTRA_TRANSITEM.VL_TOTALBRUTO - (fTRA_TRANSITEM.VL_TOTALDESCCAB + fTRA_TRANSITEM.VL_TOTALDESC);

          vVlCalc := fTRA_TRANSITEM.VL_TOTALLIQUIDO /  fTRA_TRANSITEM.QT_SOLICITADA;
          fTRA_TRANSITEM.VL_UNITLIQUIDO := rounded(vVlCalc, 6);
        end;
      end;
    end;

    if debug then MensagemLogTempo('saldo');

    vCdCustoVenda := xParamEmp.CD_CUSTO_VALIDA_VENDA;
    if (fGER_OPERACAO.TP_OPERACAO = 'S') and (fGER_OPERACAO.TP_MODALIDADE = 4) and (vCdCustoVenda <> 0) then begin
      viParams := '';
      viParams.CD_EMPRESA := fTRA_TRANSACAO.CD_EMPRESA;
      viParams.CD_PRODUTO := vCdProduto;
      viParams.TP_VALOR := 'C';
      viParams.CD_VALOR := vCdCustoVenda;
      voParams := activateCmp('PRDSVCO007', 'buscaValorData', viParams);
      if (itemXmlF('status', voParams) < 0) then begin
        raise Exception.Create(itemXml('message', voParams));
        exit;
      end;

      vVlUnitCustoVenda := voParams.VL_VALOR;

      if (vVlUnitCustoVenda > fTRA_TRANSITEM.VL_UNITLIQUIDO) then begin
        raise Exception.Create('Valor de venda menor que o valor de custo. Parâmetro CD_CUSTO_VALIDA_VENDA!' + ' / ' + cDS_METHOD);
        exit;
      end;
    end;

    if debug then MensagemLogTempo('valor');

    if vTpDescAcresc = 'D' then begin//Zottis 29/04/2014 implantação do acréscimo
      if (fTRA_TRANSITEM.VL_UNITBRUTO < 0) then begin
        raise Exception.Create('VL_UNITBRUTO do item ' + fTRA_TRANSITEM.NR_ITEM + ' não pode ser negativo!' + ' / ' + cDS_METHOD);
        exit;
      {end else if (fTRA_TRANSITEM.VL_UNITDESC < 0) then begin
        raise Exception.Create('VL_UNITDESC do item ' + fTRA_TRANSITEM.NR_ITEM + ' não pode ser negativo!' + ' / ' + cDS_METHOD);
        exit;}
      end else if (fTRA_TRANSITEM.VL_UNITLIQUIDO < 0) then begin
        raise Exception.Create('VL_UNITLIQUIDO do item ' + fTRA_TRANSITEM.NR_ITEM + ' não pode ser negativo!' + ' / ' + cDS_METHOD);
        exit;
      end else if (fTRA_TRANSITEM.VL_TOTALBRUTO < 0) then begin
        raise Exception.Create('VL_TOTALBRUTO do item ' + fTRA_TRANSITEM.NR_ITEM + ' não pode ser negativo!' + ' / ' + cDS_METHOD);
        exit;
      {end else if (fTRA_TRANSITEM.VL_TOTALDESC < 0) then begin
        raise Exception.Create('VL_TOTALDESC do item ' + fTRA_TRANSITEM.NR_ITEM + ' não pode ser negativo!' + ' / ' + cDS_METHOD);
        exit;}
      end else if (fTRA_TRANSITEM.VL_TOTALLIQUIDO < 0) then begin
        raise Exception.Create('VL_TOTALLIQUIDO do item ' + fTRA_TRANSITEM.NR_ITEM + ' não pode ser negativo!' + ' / ' + cDS_METHOD);
        exit;
      end;
    end;

    if (fTRA_TRANSITEM.QT_SOLICITADA > 0) and (fTRA_TRANSITEM.VL_UNITBRUTO > 0) and (fTRA_TRANSITEM.VL_UNITLIQUIDO > 0) then begin
      if (fTRA_TRANSITEM.VL_TOTALBRUTO = 0) then begin
        fTRA_TRANSITEM.VL_TOTALBRUTO := 0.01;
      end;
      if (fTRA_TRANSITEM.VL_TOTALLIQUIDO = 0) then begin
        fTRA_TRANSITEM.VL_TOTALLIQUIDO := 0.01;
      end;
    end;
    if (vDsLstImposto = '') then begin

      //-- nova regra fiscal
      if (vCdRegraFiscal = 0) then begin
        if (vCdServico > 0) or (vCdMPTer <> '') then begin
          vCdRegraFiscal := fGER_OPERACAO.CD_REGRAFISCAL;
        end else begin
          fPRD_PRDREGRAFISCAL.Limpar();
          fPRD_PRDREGRAFISCAL.CD_PRODUTO := fTRA_TRANSITEM.CD_PRODUTO;
          fPRD_PRDREGRAFISCAL.CD_OPERACAO := fGER_OPERACAO.CD_OPERACAO;
          fPRD_PRDREGRAFISCAL.Listar(nil);
          if (xStatus >= 0) then begin
            vCdRegraFiscal := fPRD_PRDREGRAFISCAL.CD_REGRAFISCAL;
          end else begin
            vCdRegraFiscal := fGER_OPERACAO.CD_REGRAFISCAL;
          end;
        end;
      end;
      //--

      //-- nova regra fiscal
      if (vCdRegraFiscal > 0) then begin
        fFIS_REGRAADIC.Limpar();
        fFIS_REGRAADIC.CD_REGRAFISCAL := vCdRegraFiscal;
        fFIS_REGRAADIC.Listar(nil);
        if (itemXmlF('status', voParams) < 0) then begin
          fFIS_REGRAADIC.Limpar();
        end;
      end;
      //--

      viParams := '';
      viParams.CD_EMPRESA := fTRA_TRANSACAO.CD_EMPFAT;
      //viParams.UF_DESTINO := fV_PES_ENDERECO.DS_SIGLAESTADO;
      viParams.TP_ORIGEMEMISSAO := fTRA_TRANSACAO.TP_ORIGEMEMISSAO;
      viParams.CD_PRODUTO := fTRA_TRANSITEM.CD_PRODUTO;
      viParams.CD_MPTER := vCdMPTer;
      viParams.CD_SERVICO := vCdServico;
      viParams.CD_OPERACAO := fGER_OPERACAO.CD_OPERACAO;
      //viParams.CD_PESSOA := fTRA_TRANSACAO.CD_PESSOA;
      viParams.CD_CST := fTRA_TRANSITEM.CD_CST;
      viParams.VL_TOTALBRUTO := fTRA_TRANSITEM.VL_TOTALBRUTO;
      viParams.VL_TOTALLIQUIDO := fTRA_TRANSITEM.VL_TOTALLIQUIDO;
      viParams.PR_IPI := pParams.PR_IPI;
      viParams.VL_IPI := pParams.VL_IPI;
      viParams.DT_INIVIGENCIA := fTRA_TRANSACAO.DT_TRANSACAO;
      viParams.CD_REGRAFISCAL := vCdRegraFiscal;
      viParams.CD_TIPI := fTRA_TRANSITEM.CD_TIPI;

      //-- nova regra fiscal
      if (fTRA_REMDES.DS_SIGLAESTADO = '') then begin
        viParams.UF_DESTINO := fV_PES_ENDERECO.DS_SIGLAESTADO;
      end else begin
        viParams.UF_DESTINO := fTRA_REMDES.DS_SIGLAESTADO;
      end;
      //--

      //-- nova regra fiscal
      if (fTRA_REMDES.CD_PESSOA = '') then begin
        viParams.CD_PESSOA := fTRA_TRANSACAO.CD_PESSOA;
      end else begin
        viParams.CD_PESSOA := fTRA_REMDES.CD_PESSOA;
      end;
      //--

      //-- nova regra fiscal
      if (fFIS_REGRAADIC.IN_NOVAREGRA) then begin
        viParams.CD_REGRAFISCAL := vCdRegraFiscal;
        voParams := activateCmp('FISSVCO080', 'buscaRegraRelacionada', viParams);
        if (itemXmlF('status', voParams) < 0) then begin
          raise Exception.Create(itemXml('message', voParams)); exit;
        end;
        vCdRegraFiscal := voParams.CD_REGRAFISCAL;

        viParams.CD_REGRAFISCAL := vCdRegraFiscal;
        viParams.IN_CONTRIBUINTE := voParams.IN_CONTRIBUINTE;
        voParams := activateCmp('FISSVCO080', 'calculaImpostoItem', viParams);
        if (itemXmlF('status', voParams) < 0) then begin
          raise Exception.Create(itemXml('message', voParams)); exit;
        end;
        vDsLstImposto := voParams.DS_LSTIMPOSTO;
        vCdCST := voParams.CD_CST;
        vCdCFOP := voParams.CD_CFOP;

        fTRA_ITEMADIC.CD_REGRAFISCAL := vCdRegraFiscal;
        fTRA_ITEMADIC.CD_OPERADOR := PARAM_GLB.CD_USUARIO;
        fTRA_ITEMADIC.DT_CADASTRO := Now;
      end else begin
      //--
        voParams := activateCmp('FISSVCO015', 'calculaImpostoItem', viParams);
        if (itemXmlF('status', voParams) < 0) then begin
          raise Exception.Create(itemXml('message', voParams)); exit;
        end;
        vDsLstImposto := voParams.DS_LSTIMPOSTO;
        vCdCST := voParams.CD_CST;
        vCdDecreto := voParams.CD_DECRETO;
      end;
    end;

    if (vDsLstImposto <> '') then begin
      repeat
        getitem(vDsRegistro, vDsLstImposto, 1);

        vCdImposto := vDsRegistro.CD_IMPOSTO;
        if (vCdImposto > 0) then begin
          delitem(vDsRegistro, 'CD_EMPRESA');
          delitem(vDsRegistro, 'NR_TRANSACAO');
          delitem(vDsRegistro, 'DT_TRANSACAO');
          delitem(vDsRegistro, 'NR_ITEM');
          delitem(vDsRegistro, 'U_VERSION');

          fF_TRA_ITEMIMPOSTO.Limpar();
          //fF_TRA_ITEMIMPOSTO.Append();
          //fF_TRA_ITEMIMPOSTO.CD_IMPOSTO := vDsRegistro.CD_IMPOSTO;
          //fF_TRA_ITEMIMPOSTO.Consultar(nil);
          fF_TRA_ITEMIMPOSTO.SetValues(vDsRegistro);
          fF_TRA_ITEMIMPOSTO.CD_EMPRESA := fTRA_TRANSITEM.CD_EMPRESA;
          fF_TRA_ITEMIMPOSTO.NR_TRANSACAO := fTRA_TRANSITEM.NR_TRANSACAO;
          fF_TRA_ITEMIMPOSTO.DT_TRANSACAO := fTRA_TRANSITEM.DT_TRANSACAO;
          fF_TRA_ITEMIMPOSTO.NR_ITEM := fTRA_TRANSITEM.NR_ITEM;
          fF_TRA_ITEMIMPOSTO.CD_EMPFAT := fTRA_TRANSACAO.CD_EMPFAT;
          fF_TRA_ITEMIMPOSTO.CD_GRUPOEMPRESA := fTRA_TRANSACAO.CD_GRUPOEMPRESA;
          fF_TRA_ITEMIMPOSTO.CD_OPERADOR := PARAM_GLB.CD_USUARIO;
          fF_TRA_ITEMIMPOSTO.DT_CADASTRO := Now;
          voParams := tF_TRA_ITEMIMPOSTO.Salvar();
          if (itemXmlF('status', voParams) < 0) then begin
            raise Exception.Create(itemXml('message', voParams));
            exit;
          end;
        end;

        delitemGld(vDsLstImposto, 1);
      until (vDsLstImposto = '');
    end;

    if debug then MensagemLogTempo('imposto');

    if (vCdCST <> '') then begin
      fTRA_TRANSITEM.CD_CST := vCdCST;
    end;
    if (vCdDecreto > 0) then begin
      fTRA_TRANSITEM.CD_DECRETO := vCdDecreto;
    end;

    vVlCalc := (fTRA_TRANSITEM.VL_TOTALDESC + fTRA_TRANSITEM.VL_TOTALDESCCAB) / fTRA_TRANSITEM.VL_TOTALBRUTO * 100;
    fTRA_TRANSITEM.PR_DESCONTO := rounded(vVlCalc, 6);

    if (fTRA_TRANSITEM.PR_DESCONTO <> 0) then begin
      fTRA_TRANSITEM.IN_DESCONTO := True;
    end else begin
      fTRA_TRANSITEM.IN_DESCONTO := False;
    end;
  end;

  fTRA_TRANSITEM.CD_EMPFAT := fTRA_TRANSACAO.CD_EMPFAT;
  fTRA_TRANSITEM.CD_GRUPOEMPRESA := fTRA_TRANSACAO.CD_GRUPOEMPRESA;
  fTRA_TRANSITEM.CD_OPERADOR := PARAM_GLB.CD_USUARIO;
  fTRA_TRANSITEM.DT_CADASTRO := Now;

  voParams := tTRA_TRANSITEM.Salvar();
  if (itemXmlF('status', voParams) < 0) then begin
    raise Exception.Create(itemXml('message', voParams));
    exit;
  end;
  if (fTRA_TRANSITEM.CD_PRODUTO = 0) and (fGER_OPERACAO.TP_DOCTO = 1) then begin
    vNrDescItem := length(fTRA_TRANSITEM.DS_PRODUTO);

    fTRA_TRANSITEM.Limpar();
    fTRA_TRANSITEM.CD_EMPRESA := vCdEmpresa;
    fTRA_TRANSITEM.NR_TRANSACAO := vNrTransacao;
    fTRA_TRANSITEM.DT_TRANSACAO := vDtTransacao;
    fTRA_TRANSITEM.NR_ITEM := '<' + FloatToStr(vNrItem);
    fTRA_TRANSITEM.Listar(nil);
    if (xStatus >= 0) then begin
      tTRA_TRANSITEM.IndexFieldNames := 'NR_ITEM';
      fTRA_TRANSITEM.First();
      while(xStatus >= 0) do begin
        if (fTRA_TRANSITEM.CD_PRODUTO = 0) then begin
          vNr := length(fTRA_TRANSITEM.DS_PRODUTO);
          vNrDescItem := vNrDescItem + vNr;
        end else begin
          break;
        end;
        fTRA_TRANSITEM.Next();
      end;
    end;
    if (vNrDescItem > 500) then begin
      raise Exception.Create('Item ' + fTRA_TRANSITEM.NR_ITEM + ' da transação ' + FloatToStr(vNrTransacao) + ' possui itens descritivos com tamanho superior a 500 caracteres!' + ' / ' + cDS_METHOD);
      exit;
    end;
  end;

  if debug then MensagemLogTempo('tamanho descricao');

  if (vVlBase > 0) and (vVlOriginal > 0) then begin
    viParams := '';
    viParams.CD_EMPRESA := fTRA_TRANSITEM.CD_EMPRESA;
    viParams.NR_TRANSACAO := fTRA_TRANSITEM.NR_TRANSACAO;
    viParams.DT_TRANSACAO := fTRA_TRANSITEM.DT_TRANSACAO;
    viParams.NR_ITEM := fTRA_TRANSITEM.NR_ITEM;
    viParams.VL_BASE := vVlBase;
    viParams.VL_ORIGINAL := vVlOriginal;
    voParams := activateCmp('TRASVCO024', 'gravaTraItemAdic', viParams);
    if (itemXmlF('status', voParams) < 0) then begin
      raise Exception.Create(itemXml('message', voParams));
      exit;
    end;
  end;

  if debug then MensagemLogTempo('adicional item');

  (* if (vTpLote > 0) and (vDsLstItemLote <> '')  and not (vInNaoValidaLote) then begin
    viParams := '';
    viParams.CD_EMPRESA := fTRA_TRANSITEM.CD_EMPRESA;
    viParams.NR_TRANSACAO := fTRA_TRANSITEM.NR_TRANSACAO;
    viParams.DT_TRANSACAO := fTRA_TRANSITEM.DT_TRANSACAO;
    viParams.NR_ITEM := fTRA_TRANSITEM.NR_ITEM;
    viParams.DS_LSTITEMLOTE := vDsLstItemLote;
    viParams.IN_SEMMOVIMENTO := vInSemMovimento;
    voParams := activateCmp('TRASVCO016', 'gravaItemLote', viParams);
    if (itemXmlF('status', voParams) < 0) then begin
      raise Exception.Create(itemXml('message', voParams));
      exit;
    end;
  end; *)

  if debug then MensagemLogTempo('item lote');

  if (vInTotal) then begin
    viParams := '';
    voParams := calculaTotalTransacao(viParams); (* calculaTotalOtimizado(viParams); *)
    if (itemXmlF('status', voParams) < 0) then begin
      raise Exception.Create(itemXml('message', voParams));
      exit;
    end;
    if (gInGravaTraBloq) then begin
      fTRA_TRANSACAO.TP_SITUACAO := 8;
    end;
    voParams := tTRA_TRANSACAO.Salvar();
    if (itemXmlF('status', voParams) < 0) then begin
      raise Exception.Create(itemXml('message', voParams));
      exit;
    end;
  end;

  if debug then MensagemLogTempo('calcula total');

  if ((fGER_OPERACAO.TP_OPERACAO = 'E') and ((fGER_OPERACAO.TP_MODALIDADE = 4) or (fGER_OPERACAO.TP_MODALIDADE = 2)) or (fGER_OPERACAO.CD_OPERACAO = gCdOperacaoOI)) then begin
  end else begin
    if (gDsLstValorVenda <> '') and (fTRA_TRANSITEM.CD_ESPECIE <> gCdEspecieServico) and (fTRA_TRANSITEM.CD_PRODUTO > 0) then begin
      viParams := '';
      viParams.DS_LSTVALOR := gDsLstValorVenda;
      viParams.CD_EMPRESA := fTRA_TRANSACAO.CD_EMPRESA;
      viParams.NR_TRANSACAO := fTRA_TRANSACAO.NR_TRANSACAO;
      viParams.DT_TRANSACAO := fTRA_TRANSACAO.DT_TRANSACAO;
      viParams.NR_ITEM := vNrItem;
      viParams.CD_PRODUTO := fTRA_TRANSITEM.CD_PRODUTO;
      viParams.CD_EMPFAT := fTRA_TRANSACAO.CD_EMPFAT;
      viParams.CD_GRUPOEMPRESA := fTRA_TRANSACAO.CD_GRUPOEMPRESA;
      //voParams := activateCmp('TRASVCO016', 'gravaItemValor', viParams);
      //if (itemXmlF('status', voParams) < 0) then begin
      //  raise Exception.Create(itemXml('message', voParams));
      //  exit;
      //end;
      vDsLstValorVenda := voParams.DS_LSTVALORVENDA;
    end;
  end;

  if debug then MensagemLogTempo('custo do produto');

  gHrFim := Now;
  gHrTempo := gHrFim - gHrInicio;

  Result := '';
  Result.CD_EMPRESA := vCdEmpresa;
  Result.NR_TRANSACAO := vNrTransacao;
  Result.DT_TRANSACAO := vDtTransacao;
  Result.NR_ITEM := vNrItem;
  Result.DS_LSTVALORVENDA := vDsLstValorVenda;
  Result.DS_MENSAGEM := vDsMensagem;

  gInTransacaoItem := True;

  exit;
end;

//---------------------------------------------------------------------
function T_TRASVCO004.gravaParcelaTransacao(pParams : String) : String;
//---------------------------------------------------------------------
const
  cDS_METHOD = 'ADICIONAL=Operação: T_TRASVCO004.gravaParcelaTransacao()';
var
  viParams, voParams : String;
begin
  viParams := pParams;
  voParams := activateCmp('TRASVCO024', 'gravaParcelaTransacao', viParams);
  if (itemXmlF('status', voParams) < 0) then begin
    raise Exception.Create(itemXml('message', voParams));
    exit;
  end;

  exit;
end;

//-------------------------------------------------------------------
function T_TRASVCO004.gravaTotalTransacao(pParams : String) : String;
//-------------------------------------------------------------------
const
  cDS_METHOD = 'ADICIONAL=Operação: T_TRASVCO004.gravaTotalTransacao()';
var
  viParams, voParams, vDsRegistro, vDsLstTransacao : String;
  vCdEmpresa, vNrTransacao : Real;
  vDtTransacao : TDateTime;
begin
  vDsLstTransacao := pParams.DS_LSTTRANSACAO;

  if (vDsLstTransacao = '') then begin
    raise Exception.Create('Lista de transação não informada!' + ' / ' + cDS_METHOD);
    exit;
  end;

  fTRA_TRANSACAO.Limpar();

  repeat
    getitem(vDsRegistro, vDsLstTransacao, 1);

    vCdEmpresa := vDsRegistro.CD_EMPRESA;
    vNrTransacao := vDsRegistro.NR_TRANSACAO;
    vDtTransacao := vDsRegistro.DT_TRANSACAO;

    if (vCdEmpresa = 0) then begin
      raise Exception.Create('Empresa não informada!' + ' / ' + cDS_METHOD);
      exit;
    end;
    if (vNrTransacao = 0) then begin
      raise Exception.Create('Número da transação não informado!' + ' / ' + cDS_METHOD);
      exit;
    end;
    if (vDtTransacao = 0) then begin
      raise Exception.Create('Data transação não informada!' + ' / ' + cDS_METHOD);
      exit;
    end;

    fTRA_TRANSACAO.Append();
    fTRA_TRANSACAO.CD_EMPRESA := vCdEmpresa;
    fTRA_TRANSACAO.NR_TRANSACAO := vNrTransacao;
    fTRA_TRANSACAO.DT_TRANSACAO := vDtTransacao;
    fTRA_TRANSACAO.Consultar(nil);
    if (xStatus = -7) then begin
      fTRA_TRANSACAO.Consultar(nil);
    end else if (xStatus = 0) then begin
      raise Exception.Create('Transação ' + FloatToStr(vNrTransacao) + ' não cadastrada!' + ' / ' + cDS_METHOD);
      exit;
    end;

    viParams := '';
    viParams.CD_EMPFAT := fTRA_TRANSACAO.CD_EMPFAT;
    voParams := calculaTotalTransacao(viParams);
    if (itemXmlF('status', voParams) < 0) then begin
      raise Exception.Create(itemXml('message', voParams));
      exit;
    end;

    fTRA_TRANSACAO.CD_OPERADOR := PARAM_GLB.CD_USUARIO;
    fTRA_TRANSACAO.DT_CADASTRO := Now;

    delitemGld(vDsLstTransacao, 1);
  until (vDsLstTransacao = '');

  voParams := tTRA_TRANSACAO.Salvar();
  if (itemXmlF('status', voParams) < 0) then begin
    raise Exception.Create(itemXml('message', voParams));
    exit;
  end;
  if not (fTRA_TRANSACAO.IsEmpty()) then begin
    fTRA_TRANSACAO.First();
    while (xStatus >=0) do begin
      fV_TRA_TOTATRA.Limpar();
      fV_TRA_TOTATRA.CD_EMPRESA := fTRA_TRANSACAO.CD_EMPRESA;
      fV_TRA_TOTATRA.NR_TRANSACAO := fTRA_TRANSACAO.NR_TRANSACAO;
      fV_TRA_TOTATRA.DT_TRANSACAO := fTRA_TRANSACAO.DT_TRANSACAO;
      fV_TRA_TOTATRA.Listar(nil);
      if (itemXmlF('status', voParams) < 0) then begin
        fV_TRA_TOTATRA.Limpar();
      end;
      if (fV_TRA_TOTATRA.QT_TOTALITEM <> fV_TRA_TOTATRA.QT_SOLICITADA) then begin
        raise Exception.Create('Totalização de valor da transação ' + FloatToStr(vNrTransacao) + ' divergente. Capa: ' + fV_TRA_TOTATRA.QT_SOLICITADA + ' Items: ' + fV_TRA_TOTATRA.QT_TOTALITEM + ' !' + ' / ' + cDS_METHOD);
        exit;
      end;
      if (fV_TRA_TOTATRA.VL_TOTALITEM <> fV_TRA_TOTATRA.VL_TRANSACAO) then begin
        raise Exception.Create('Totalização de valor da transação ' + FloatToStr(vNrTransacao) + ' divergente. Capa: ' + fV_TRA_TOTATRA.VL_TRANSACAO + ' Items: ' + fV_TRA_TOTATRA.VL_TOTALITEM + ' !' + ' / ' + cDS_METHOD);
        exit;
      end;
      fTRA_TRANSACAO.Next();
    end;
  end;

  exit;
end;

//-----------------------------------------------------------------------
function T_TRASVCO004.alteraSituacaoTransacao(pParams : String) : String;
//-----------------------------------------------------------------------
const
  cDS_METHOD = 'ADICIONAL=Operação: T_TRASVCO004.alteraSituacaoTransacao()';
var
  vDsRegistro, vDsLstTransacao, vCdComponente, vDsMotivoAlt, viParams, voParams : String;
  vCdEmpresa, vNrTransacao, vTpSituacao, vTpSituacaoAnt, vNrSequencia, vCdMotivoBloq, vCdMotivoBloqAnt, vNrDiasAtraso : Real;
  vDtTransacao : TDateTime;
  vInValidaNF : Boolean;
begin
  vDsLstTransacao := pParams.DS_LSTTRANSACAO;
  vTpSituacao := pParams.TP_SITUACAO;
  vDsMotivoAlt := pParams.DS_MOTIVOALT;
  vCdComponente := pParams.CD_COMPONENTE;
  vCdMotivoBloq := pParams.CD_MOTIVOBLOQ;
  vInValidaNF := pParams.IN_VALIDANF;

  if (vCdComponente = '') then begin
    vCdComponente := 'TRASVCO004';
  end;

  if (vDsLstTransacao = '') then begin
    raise Exception.Create('Lista de transação não informada!' + ' / ' + cDS_METHOD);
    exit;
  end;
  if (vTpSituacao = 0) then begin
    raise Exception.Create('Situação não informada!' + ' / ' + cDS_METHOD);
    exit;
  end;
  if (vTpSituacao < 0) or (vTpSituacao > 10) then begin
    raise Exception.Create('Situação ' + FloatToStr(vTpSituacao) + ' inválida!' + ' / ' + cDS_METHOD);
    exit;
  end;

  fTRA_TRANSACAO.Limpar();

  repeat
    getitem(vDsRegistro, vDsLstTransacao, 1);
    vCdEmpresa := vDsRegistro.CD_EMPRESA;
    vNrTransacao := vDsRegistro.NR_TRANSACAO;
    vDtTransacao := vDsRegistro.DT_TRANSACAO;

    if (vCdEmpresa = 0) then begin
      raise Exception.Create('Empresa não informada!' + ' / ' + cDS_METHOD);
      exit;
    end;
    if (vNrTransacao = 0) then begin
      raise Exception.Create('Número da transação não informado!' + ' / ' + cDS_METHOD);
      exit;
    end;
    if (vDtTransacao = 0) then begin
      raise Exception.Create('Data transação não informada!' + ' / ' + cDS_METHOD);
      exit;
    end;

    fTRA_TRANSACAO.Append();
    fTRA_TRANSACAO.CD_EMPRESA := vCdEmpresa;
    fTRA_TRANSACAO.NR_TRANSACAO := vNrTransacao;
    fTRA_TRANSACAO.DT_TRANSACAO := vDtTransacao;
    fTRA_TRANSACAO.Consultar(nil);
    if (xStatus = -7) then begin
      fTRA_TRANSACAO.Consultar(nil);
    end else if (xStatus = 0) then begin
      raise Exception.Create('Transação ' + FloatToStr(vNrTransacao) + ' não cadastrada!' + ' / ' + cDS_METHOD);
      exit;
    end;
    if (vTpSituacao = 4) and (vInValidaNF) then begin
      viParams := '';
      viParams.CD_EMPRESA := fTRA_TRANSACAO.CD_EMPRESA;
      viParams.NR_TRANSACAO := fTRA_TRANSACAO.NR_TRANSACAO;
      viParams.DT_TRANSACAO := fTRA_TRANSACAO.DT_TRANSACAO;
      voParams := activateCmp('TRASVCO012', 'validaNFTransacao', viParams);
      if (itemXmlF('status', voParams) < 0) then begin
        raise Exception.Create(itemXml('message', voParams));
        exit;
      end;
    end;

    vTpSituacaoAnt := fTRA_TRANSACAO.TP_SITUACAO;

    if not (fTRA_TRANSACSIT.IsEmpty()) then begin
      fTRA_TRANSACSIT.Next();
      vCdMotivoBloqAnt := fTRA_TRANSACSIT.CD_MOTIVOBLOQ;
    end;

    fTRA_TRANSACAO.TP_SITUACAO := vTpSituacao;
    fTRA_TRANSACAO.DT_ULTATEND := PARAM_GLB.DT_SISTEMA;
    fTRA_TRANSACAO.CD_OPERADOR := PARAM_GLB.CD_USUARIO;
    fTRA_TRANSACAO.DT_CADASTRO := Now;

    viParams := '';
    viParams.NM_ENTIDADE := 'TRA_TRANSACSITT';
    voParams := activateCmp('GERSVCO031', 'getNumSeq', viParams);
    if (itemXmlF('status', voParams) < 0) then begin
      raise Exception.Create(itemXml('message', voParams));
      exit;
    end;

    vNrSequencia := voParams.NR_SEQUENCIA;

    fTRA_TRANSACSIT.Append();
    fTRA_TRANSACSIT.DT_MOVIMENTO := PARAM_GLB.DT_SISTEMA;
    fTRA_TRANSACSIT.NR_SEQUENCIA := vNrSequencia;
    fTRA_TRANSACSIT.TP_SITUACAOANT := vTpSituacaoAnt;
    fTRA_TRANSACSIT.TP_SITUACAO := vTpSituacao;
    fTRA_TRANSACSIT.CD_MOTIVOBLOQ := vCdMotivoBloq;
    fTRA_TRANSACSIT.DS_MOTIVOALT := vDsMotivoAlt;
    fTRA_TRANSACSIT.CD_OPERADOR := PARAM_GLB.CD_USUARIO;
    fTRA_TRANSACSIT.DT_CADASTRO := Now;
    fTRA_TRANSACSIT.CD_COMPONENTE := vCdComponente;

    if (vTpSituacaoAnt = 8) then begin
      if (vCdMotivoBloqAnt = 3) then begin
        viParams := '';
        viParams.CD_EMPRESA := fTRA_TRANSACAO.CD_EMPRESA;
        viParams.NR_TRANSACAO := fTRA_TRANSACAO.NR_TRANSACAO;
        viParams.DT_TRANSACAO := fTRA_TRANSACAO.DT_TRANSACAO;
        viParams.CD_LIBERADOR := PARAM_GLB.CD_USUARIO;
        viParams.TP_LIBERACAO := 1;
        voParams := activateCmp('TRASVCO016', 'gravaLiberacaoTransacao', viParams);
        if (itemXmlF('status', voParams) < 0) then begin
          raise Exception.Create(itemXml('message', voParams));
          exit;
        end;
      end else if (vCdMotivoBloqAnt = 4) then begin
        viParams := '';
        viParams.CD_CLIENTE := fTRA_TRANSACAO.CD_PESSOA;
        viParams.IN_TOTAL := True;
        voParams := activateCmp('FCRSVCO015', 'buscaLimiteCliente', viParams);
        if (itemXmlF('status', voParams) < 0) then begin
          raise Exception.Create(itemXml('message', voParams));
          exit;
        end;

        vNrDiasAtraso := voParams.NR_DIAVENCTO;

        if (vNrDiasAtraso > 0) then begin
          viParams := '';
          viParams.CD_EMPRESA := fTRA_TRANSACAO.CD_EMPRESA;
          viParams.NR_TRANSACAO := fTRA_TRANSACAO.NR_TRANSACAO;
          viParams.DT_TRANSACAO := fTRA_TRANSACAO.DT_TRANSACAO;
          viParams.CD_LIBERADOR := PARAM_GLB.CD_USUARIO;
          viParams.TP_LIBERACAO := 2;
          viParams.NR_DIAATRASO := vNrDiasAtraso;
          voParams := activateCmp('TRASVCO016', 'gravaLiberacaoTransacao', viParams);
          if (itemXmlF('status', voParams) < 0) then begin
            raise Exception.Create(itemXml('message', voParams));
            exit;
          end;
        end;
      end;
    end;

    delitemGld(vDsLstTransacao, 1);
  until (vDsLstTransacao = '');

  voParams := tTRA_TRANSACAO.Salvar();
  if (itemXmlF('status', voParams) < 0) then begin
    raise Exception.Create(itemXml('message', voParams));
    exit;
  end;

  exit;
end;

//------------------------------------------------------------------------
function T_TRASVCO004.atualizaEstoqueTransacao(pParams : String) : String;
//------------------------------------------------------------------------
const
  cDS_METHOD = 'ADICIONAL=Operação: T_TRASVCO004.atualizaEstoqueTransacao()';
var
  viParams, voParams, vDsRegistro, vDsLstTransacao : String;
  vCdEmpresa, vNrTransacao : Real;
  vDtTransacao : TDateTime;
  vInEstorno, vInKardex : Boolean;
begin
  vDsLstTransacao := pParams.DS_LSTTRANSACAO;
  vInEstorno := pParams.IN_ESTORNO;

  if (vDsLstTransacao = '') then begin
    raise Exception.Create('Lista de transação não informada!' + ' / ' + cDS_METHOD);
    exit;
  end;

  repeat
    getitem(vDsRegistro, vDsLstTransacao, 1);
    vCdEmpresa := vDsRegistro.CD_EMPRESA;
    vNrTransacao := vDsRegistro.NR_TRANSACAO;
    vDtTransacao := vDsRegistro.DT_TRANSACAO;

    if (vCdEmpresa = 0) then begin
      raise Exception.Create('Empresa não informada!' + ' / ' + cDS_METHOD);
      exit;
    end;
    if (vNrTransacao = 0) then begin
      raise Exception.Create('Número da transação não informado!' + ' / ' + cDS_METHOD);
      exit;
    end;
    if (vDtTransacao = 0) then begin
      raise Exception.Create('Data transação não informada!' + ' / ' + cDS_METHOD);
      exit;
    end;

    fTRA_TRANSACAO.Limpar();
    fTRA_TRANSACAO.CD_EMPRESA := vCdEmpresa;
    fTRA_TRANSACAO.NR_TRANSACAO := vNrTransacao;
    fTRA_TRANSACAO.DT_TRANSACAO := vDtTransacao;
    fTRA_TRANSACAO.Listar(nil);
    if (itemXmlF('status', voParams) < 0) then begin
      raise Exception.Create('Transação ' + FloatToStr(vNrTransacao) + ' não cadastrada!' + ' / ' + cDS_METHOD);
      exit;
    end;
    if not (fTRA_TRANSITEM.IsEmpty()) then begin
      fTRA_TRANSITEM.First();
      while not t.EOF do begin
        viParams := '';
        viParams.CD_EMPRESA := fTRA_TRANSITEM.CD_EMPRESA;
        viParams.NR_TRANSACAO := fTRA_TRANSITEM.NR_TRANSACAO;
        viParams.DT_TRANSACAO := fTRA_TRANSITEM.DT_TRANSACAO;
        viParams.NR_ITEM := fTRA_TRANSITEM.NR_ITEM;
        voParams := activateCmp('GERSVCO058', 'buscaDadosGerOperCfopTra', viParams);
        if (itemXmlF('status', voParams) < 0) then begin
          raise Exception.Create(itemXml('message', voParams));
          exit;
        end;
        vInKardex := voParams.IN_KARDEX;

        if (vInKardex) then begin
          //viParams := '';
          //viParams.CD_EMPRESA := fTRA_TRANSACAO.CD_EMPFAT;
          //viParams.CD_PRODUTO := fTRA_TRANSITEM.CD_PRODUTO;
          //viParams.NR_ITEM := fTRA_TRANSITEM.NR_ITEM;
          //viParams.CD_OPERACAO := fTRA_TRANSACAO.CD_OPERACAO;
          //viParams.IN_ESTORNO := vInEstorno;
          //viParams.TP_DCTOORIGEM := 1;
          //viParams.NR_DCTOORIGEM := fTRA_TRANSACAO.NR_TRANSACAO;
          //viParams.DT_DCTOORIGEM := fTRA_TRANSACAO.DT_TRANSACAO;
          //viParams.QT_MOVIMENTO := fTRA_TRANSITEM.QT_SOLICITADA;
          //viParams.VL_UNITLIQUIDO := fTRA_TRANSITEM.VL_UNITLIQUIDO;
          //viParams.VL_UNITSEMIMPOSTO := fTRA_TRANSITEM.VL_UNITLIQUIDO;
          //voParams := activateCmp('GERSVCO008', 'atualizaSaldoOperacao', viParams);
          //if (itemXmlF('status', voParams) < 0) then begin
          //  raise Exception.Create(itemXml('message', voParams));
          //  exit;
          //end;
        end;

        fTRA_TRANSITEM.Next();
      end;
    end;

    delitemGld(vDsLstTransacao, 1);
  until (vDsLstTransacao = '');

  exit;
end;

//-------------------------------------------------------------------------
function T_TRASVCO004.gravaImpostoItemTransacao(pParams : String) : String;
//-------------------------------------------------------------------------
const
  cDS_METHOD = 'ADICIONAL=Operação: T_TRASVCO004.gravaImpostoItemTransacao()';
var
  viParams, voParams, vDsRegistro, vDsLstImposto, vCdCST, vDsUFOrigem, vDsUFDestino : String;
  vCdEmpresa, vNrTransacao, vNrItem, vCdCFOP, vCdDecreto, vTpAreaComercio : Real;
  vDtTransacao : TDateTime;
  vCdRegraFiscal, vCdServico : Real;
  vCdMPTer : String;
begin
  vCdEmpresa := pParams.CD_EMPRESA;
  vNrTransacao := pParams.NR_TRANSACAO;
  vDtTransacao := pParams.DT_TRANSACAO;
  vNrItem := pParams.NR_ITEM;
  vTpAreaComercio := pParams.TP_AREACOMERCIO;
  gCdEspecieServico := PARAM_GLB.CD_ESPECIE_SERVICO_TRA;
  gTpModDctoFiscal := pParams.TP_MODDCTOFISCAL;
  vCdRegraFiscal := pParams.CD_REGRAFISCAL;

  if (pParams.IN_TRANSFERE) then begin
    vDsUFOrigem := pParams.UF_ORIGEM;
    vDsUFDestino := pParams.UF_DESTINO;
  end;

  if (vCdEmpresa = 0) then begin
    raise Exception.Create('Empresa não informada!' + ' / ' + cDS_METHOD);
    exit;
  end;
  if (vNrTransacao = 0) then begin
    raise Exception.Create('Número transação não informado!' + ' / ' + cDS_METHOD);
    exit;
  end;
  if (vDtTransacao = 0) then begin
    raise Exception.Create('Data transação não informada!' + ' / ' + cDS_METHOD);
    exit;
  end;
  if (vNrItem = 0) then begin
    raise Exception.Create('Item da transação não informado!' + ' / ' + cDS_METHOD);
    exit;
  end;

  fTRA_TRANSACAO.Limpar();
  fTRA_TRANSACAO.CD_EMPRESA := vCdEmpresa;
  fTRA_TRANSACAO.NR_TRANSACAO := vNrTransacao;
  fTRA_TRANSACAO.DT_TRANSACAO := vDtTransacao;
  fTRA_TRANSACAO.Listar(nil);
  if (itemXmlF('status', voParams) < 0) then begin
    raise Exception.Create('Transação ' + FloatToStr(vNrTransacao) + ' não cadastrada!' + ' / ' + cDS_METHOD);
    exit;
  end;

  fTRA_TRANSITEM.Limpar();
  fTRA_TRANSITEM.NR_ITEM := vNrItem;
  fTRA_TRANSITEM.Listar(nil);
  if (itemXmlF('status', voParams) < 0) then begin
    raise Exception.Create('Item ' + FloatToStr(vNrItem) + ' da transação ' + FloatToStr(vNrTransacao) + ' não cadastrada!' + ' / ' + cDS_METHOD);
    exit;
  end;
  if (fTRA_REMDES.IsEmpty() <> False) then begin
    raise Exception.Create('Transação ' + FloatToStr(vNrTransacao) + ' não possui endereco cadastrado!' + ' / ' + cDS_METHOD);
    exit;
  end;
  if (fTRA_REMDES.CD_PESSOA = 0) then begin
    raise Exception.Create('endereço da transação ' + FloatToStr(vNrTransacao) + ' não possui pessoa cadastrada!' + ' / ' + cDS_METHOD);
    exit;
  end;

  fTRA_ITEMIMPOSTO.Limpar();
  fTRA_ITEMIMPOSTO.CD_EMPRESA := fTRA_TRANSITEM.CD_EMPRESA; //--
  fTRA_ITEMIMPOSTO.NR_TRANSACAO := fTRA_TRANSITEM.NR_TRANSACAO; //--
  fTRA_ITEMIMPOSTO.DT_TRANSACAO := fTRA_TRANSITEM.DT_TRANSACAO; //--
  fTRA_ITEMIMPOSTO.NR_ITEM := fTRA_TRANSITEM.NR_ITEM; //--
  fTRA_ITEMIMPOSTO.Listar(nil);
  if (xStatus >= 0) then begin
    voParams := tTRA_ITEMIMPOSTO.Excluir();
    if (itemXmlF('status', voParams) < 0) then begin
      raise Exception.Create(itemXml('message', voParams));
      exit;
    end;
  end;

  viParams := '';
  if (fTRA_TRANSITEM.CD_ESPECIE = gCdEspecieServico) then begin
    viParams.CD_SERVICO := fTRA_TRANSITEM.CD_PRODUTO;
  end else if (fGER_OPERACAO.TP_MODALIDADE = 'A') then begin
    viParams.CD_MPTER := fTRA_TRANSITEM.CD_BARRAPRD;//Zottis 26/06/2014 Problema com Zero na Frente do código de Barras (Trocado itemF po item)
  end else begin
    viParams.CD_PRODUTO := fTRA_TRANSITEM.CD_PRODUTO;
  end;
  viParams.CD_OPERACAO := fGER_OPERACAO.CD_OPERACAO;
  if (pParams.IN_TRANSFERE) then begin
    viParams.UF_DESTINO := vDsUFDestino;
    viParams.UF_ORIGEM := vDsUFOrigem;
  end else begin
    viParams.UF_DESTINO := fTRA_REMDES.DS_SIGLAESTADO;
  end;
  viParams.CD_PESSOA := fTRA_REMDES.CD_PESSOA;
  viParams.TP_AREACOMERCIO := vTpAreaComercio;
  viParams.TP_ORIGEMEMISSAO := fTRA_TRANSACAO.TP_ORIGEMEMISSAO;
  viParams.CD_REGRAFISCAL := vCdRegraFiscal;
  voParams := activateCmp('FISSVCO015', 'buscaCFOP', viParams);
  if (itemXmlF('status', voParams) < 0) then begin
    raise Exception.Create(itemXml('message', voParams));
    exit;
  end;

  vCdCFOP := voParams.CD_CFOP;

  if (vCdCFOP > 0) then begin
    fTRA_TRANSITEM.CD_CFOP := vCdCFOP;
  end;

  viParams := '';
  if (fTRA_TRANSITEM.CD_ESPECIE = gCdEspecieServico) then begin
    viParams.CD_SERVICO := fTRA_TRANSITEM.CD_PRODUTO;
  end else if (fGER_OPERACAO.TP_MODALIDADE = 'A') then begin
    viParams.CD_MPTER := fTRA_TRANSITEM.CD_BARRAPRD;//Zottis 26/06/2014 Problema com Zero na Frente do código de Barras (Trocado itemF po item)
  end else begin
    viParams.CD_PRODUTO := fTRA_TRANSITEM.CD_PRODUTO;
  end;
  viParams.CD_OPERACAO := fGER_OPERACAO.CD_OPERACAO;
  viParams.UF_DESTINO := fTRA_REMDES.DS_SIGLAESTADO;
  viParams.CD_PESSOA := fTRA_REMDES.CD_PESSOA;
  viParams.TP_AREACOMERCIO := vTpAreaComercio;
  viParams.TP_ORIGEMEMISSAO := fTRA_TRANSACAO.TP_ORIGEMEMISSAO;
  viParams.CD_CFOP := vCdCFOP;
  viParams.CD_REGRAFISCAL := vCdRegraFiscal;
  voParams := activateCmp('FISSVCO015', 'buscaCST', viParams);
  if (itemXmlF('status', voParams) < 0) then begin
    raise Exception.Create(itemXml('message', voParams));
    exit;
  end;

  vCdCST := voParams.CD_CST;

  if (vCdCST <> '') then begin
    fTRA_TRANSITEM.CD_CST := vCdCST;
  end;

  //-- nova regra fiscal
  if (vCdRegraFiscal = 0) then begin
    if (vCdServico > 0) or (vCdMPTer <> '') then begin
      vCdRegraFiscal := fGER_OPERACAO.CD_REGRAFISCAL;
    end else begin
      fPRD_PRDREGRAFISCAL.Limpar();
      fPRD_PRDREGRAFISCAL.CD_PRODUTO := fTRA_TRANSITEM.CD_PRODUTO;
      fPRD_PRDREGRAFISCAL.CD_OPERACAO := fGER_OPERACAO.CD_OPERACAO;
      fPRD_PRDREGRAFISCAL.Listar(nil);
      if (xStatus >= 0) then begin
        vCdRegraFiscal := fPRD_PRDREGRAFISCAL.CD_REGRAFISCAL;
      end else begin
        vCdRegraFiscal := fGER_OPERACAO.CD_REGRAFISCAL;
      end;
    end;
  end;
  //--

  //-- nova regra fiscal
  if (vCdRegraFiscal > 0) then begin
    fFIS_REGRAADIC.Limpar();
    fFIS_REGRAADIC.CD_REGRAFISCAL := vCdRegraFiscal;
    fFIS_REGRAADIC.Listar(nil);
    if (itemXmlF('status', voParams) < 0) then begin
      fFIS_REGRAADIC.Limpar();
    end;
  end;
  //--

  viParams := '';
  //--
  //viParams.CD_EMPRESA := fTRA_TRANSACAO.CD_EMPFAT;
  //viParams.UF_DESTINO := fTRA_REMDES.DS_SIGLAESTADO;
  if (fTRA_REMDES.DS_SIGLAESTADO = '') then begin
    viParams.UF_DESTINO := fV_PES_ENDERECO.DS_SIGLAESTADO;
  end else begin
    viParams.UF_DESTINO := fTRA_REMDES.DS_SIGLAESTADO;
  end;
  if (fTRA_REMDES.CD_PESSOA = '') then begin
    viParams.CD_PESSOA := fTRA_TRANSACAO.CD_PESSOA;
  end else begin
    viParams.CD_PESSOA := fTRA_REMDES.CD_PESSOA;
  end;
  //--
  viParams.TP_ORIGEMEMISSAO := fTRA_TRANSACAO.TP_ORIGEMEMISSAO;
  if (fTRA_TRANSITEM.CD_ESPECIE = gCdEspecieServico) then begin
    viParams.CD_SERVICO := fTRA_TRANSITEM.CD_PRODUTO;
  end else if (fGER_OPERACAO.TP_MODALIDADE = 'A') then begin
    viParams.CD_MPTER := fTRA_TRANSITEM.CD_BARRAPRD;//Zottis 26/06/2014 Problema com Zero na Frente do código de Barras (Trocado itemF po item)
  end else begin
    viParams.CD_PRODUTO := fTRA_TRANSITEM.CD_PRODUTO;
  end;
  viParams.CD_OPERACAO := fGER_OPERACAO.CD_OPERACAO;
  viParams.CD_PESSOA := fTRA_REMDES.CD_PESSOA;
  viParams.CD_CST := fTRA_TRANSITEM.CD_CST;
  viParams.VL_TOTALBRUTO := fTRA_TRANSITEM.VL_TOTALBRUTO;
  viParams.VL_TOTALLIQUIDO := fTRA_TRANSITEM.VL_TOTALLIQUIDO;
  viParams.PR_IPI := pParams.PR_IPI;
  viParams.VL_IPI := pParams.VL_IPI;
  viParams.TP_AREACOMERCIO := vTpAreaComercio;
  viParams.TP_MODDCTOFISCAL := gTpModDctoFiscal;
  viParams.DT_INIVIGENCIA := fTRA_TRANSACAO.DT_TRANSACAO;
  viParams.CD_REGRAFISCAL := vCdRegraFiscal;
  viParams.CD_TIPI := fTRA_TRANSITEM.CD_TIPI;

  //-- nova regra fiscal
  if (fFIS_REGRAADIC.IN_NOVAREGRA) then begin
    viParams.CD_REGRAFISCAL := vCdRegraFiscal;
    voParams := activateCmp('FISSVCO080', 'buscaRegraRelacionada', viParams);
    if (itemXmlF('status', voParams) < 0) then begin
      raise Exception.Create(itemXml('message', voParams)); exit;
    end;
    vCdRegraFiscal := voParams.CD_REGRAFISCAL;

    viParams.CD_REGRAFISCAL := vCdRegraFiscal;
    viParams.IN_CONTRIBUINTE := voParams.IN_CONTRIBUINTE;
    voParams := activateCmp('FISSVCO080', 'calculaImpostoItem', viParams);
    if (itemXmlF('status', voParams) < 0) then begin
      raise Exception.Create(itemXml('message', voParams)); exit;
    end;
    vDsLstImposto := voParams.DS_LSTIMPOSTO;
    vCdCST := voParams.CD_CST;
    vCdCFOP := voParams.CD_CFOP;
  end else begin
  //--
    voParams := activateCmp('FISSVCO015', 'calculaImpostoItem', viParams);
    if (itemXmlF('status', voParams) < 0) then begin
      raise Exception.Create(itemXml('message', voParams)); exit;
    end;
    vDsLstImposto := voParams.DS_LSTIMPOSTO;
    vCdCST := voParams.CD_CST;
    vCdDecreto := voParams.CD_DECRETO;
  end;

  if (vCdCST <> '') then begin
    fTRA_TRANSITEM.CD_CST := vCdCST;
  end;
  if (vCdDecreto > 0) then begin
    fTRA_TRANSITEM.CD_DECRETO := vCdDecreto;
  end;

  if (vDsLstImposto <> '') then begin
    repeat
      getitem(vDsRegistro, vDsLstImposto, 1);

      delitem(vDsRegistro, 'CD_EMPRESA');
      delitem(vDsRegistro, 'NR_TRANSACAO');
      delitem(vDsRegistro, 'DT_TRANSACAO');
      delitem(vDsRegistro, 'NR_ITEM');

      vDsRegistro.CD_EMPRESA := fTRA_TRANSITEM.CD_EMPRESA; //--
      vDsRegistro.NR_TRANSACAO := fTRA_TRANSITEM.NR_TRANSACAO; //--
      vDsRegistro.DT_TRANSACAO := fTRA_TRANSITEM.DT_TRANSACAO; //--
      vDsRegistro.NR_ITEM := fTRA_TRANSITEM.NR_ITEM; //--

      fTRA_ITEMIMPOSTO.Limpar();
      fTRA_ITEMIMPOSTO.Append();
      fTRA_ITEMIMPOSTO.CD_EMPRESA := fTRA_TRANSITEM.CD_EMPRESA; //--
      fTRA_ITEMIMPOSTO.NR_TRANSACAO := fTRA_TRANSITEM.NR_TRANSACAO; //--
      fTRA_ITEMIMPOSTO.DT_TRANSACAO := fTRA_TRANSITEM.DT_TRANSACAO; //--
      fTRA_ITEMIMPOSTO.NR_ITEM := fTRA_TRANSITEM.NR_ITEM; //--
      fTRA_ITEMIMPOSTO.CD_IMPOSTO := vDsRegistro.CD_IMPOSTO;
      fTRA_ITEMIMPOSTO.Consultar(nil);

      fTRA_ITEMIMPOSTO.SetValues(vDsRegistro);

      fTRA_ITEMIMPOSTO.CD_EMPFAT := fTRA_TRANSACAO.CD_EMPFAT;
      fTRA_ITEMIMPOSTO.CD_GRUPOEMPRESA := fTRA_TRANSACAO.CD_GRUPOEMPRESA;
      fTRA_ITEMIMPOSTO.CD_OPERADOR := PARAM_GLB.CD_USUARIO;
      fTRA_ITEMIMPOSTO.DT_CADASTRO := Now;

      fFIS_REGRAIMPOSTO.Limpar();
      fFIS_REGRAIMPOSTO.CD_IMPOSTO := vDsRegistro.CD_IMPOSTO;
      fFIS_REGRAIMPOSTO.CD_REGRAFISCAL := fGER_OPERACAO.CD_REGRAFISCAL;
      fFIS_REGRAIMPOSTO.Listar(nil);
      if (xStatus >= 0) then begin
        fTRA_ITEMIMPOSTO.CD_CST := fFIS_REGRAIMPOSTO.CD_CST;
      end;

      voParams := tTRA_ITEMIMPOSTO.Salvar();
      if (itemXmlF('status', voParams) < 0) then begin
        raise Exception.Create(itemXml('message', voParams)); exit;
      end;

      delitemGld(vDsLstImposto, 1);
    until (vDsLstImposto = '');
  end;

  voParams := tTRA_TRANSITEM.Salvar();
  if (itemXmlF('status', voParams) < 0) then begin
    raise Exception.Create(itemXml('message', voParams)); exit;
  end;

  if (vCdRegraFiscal > 0) then begin
    Result := '';
    Result.CD_CST := vCdCST;
    Result.CD_CFOP := vCdCFOP;
  end;

  exit;
end;

//-------------------------------------------------------------------------
function T_TRASVCO004.alteraVendedorTransacaoNF(pParams : String) : String;
//-------------------------------------------------------------------------
const
  cDS_METHOD = 'ADICIONAL=Operação: T_TRASVCO004.alteraVendedorTransacaoNF()';
var
  vDsLstNF, vDsRegistro, viParams, voParams : String;
  vCdEmpresa, vNrTransacao, vCdVendedor : Real;
  vDtTransacao : TDateTime;
begin
  vCdEmpresa := pParams.CD_EMPRESA;
  vNrTransacao := pParams.NR_TRANSACAO;
  vDtTransacao := pParams.DT_TRANSACAO;
  vCdVendedor := pParams.CD_COMPVEND;

  if (vCdEmpresa = 0) then begin
    raise Exception.Create('Empresa não informada!' + ' / ' + cDS_METHOD);
    exit;
  end;
  if (vNrTransacao = 0) then begin
    raise Exception.Create('Número da transação não informado!' + ' / ' + cDS_METHOD);
    exit;
  end;
  if (vDtTransacao = 0) then begin
    raise Exception.Create('Data transação não informada!' + ' / ' + cDS_METHOD);
    exit;
  end;
  if (vCdVendedor = 0) then begin
    raise Exception.Create('Vendedor não informado!' + ' / ' + cDS_METHOD);
    exit;
  end;

  fTRA_TRANSACAO.Limpar();
  fTRA_TRANSACAO.CD_EMPRESA := vCdEmpresa;
  fTRA_TRANSACAO.NR_TRANSACAO := vNrTransacao;
  fTRA_TRANSACAO.DT_TRANSACAO := vDtTransacao;
  fTRA_TRANSACAO.Listar(nil);
  if (itemXmlF('status', voParams) < 0) then begin
    raise Exception.Create('Transação ' + FloatToStr(vNrTransacao) + ' não cadastrada!' + ' / ' + cDS_METHOD);
    exit;
  end;

  fTRA_TRANSACAO.CD_COMPVEND := vCdVendedor;
  fTRA_TRANSACAO.CD_OPERADOR := PARAM_GLB.CD_USUARIO;
  fTRA_TRANSACAO.DT_CADASTRO := Now;

  fTRA_TRANSITEM.First();
  while(xStatus >= 0) do begin
    fTRA_TRANSITEM.CD_COMPVEND := vCdVendedor;
    fTRA_TRANSITEM.CD_OPERADOR := PARAM_GLB.CD_USUARIO;
    fTRA_TRANSITEM.DT_CADASTRO := Now;
    fTRA_TRANSITEM.Next();
  end;

  voParams := tTRA_TRANSACAO.Salvar();
  if (itemXmlF('status', voParams) < 0) then begin
    raise Exception.Create(itemXml('message', voParams));
    exit;
  end;

  viParams := '';
  viParams.CD_EMPTRANSACAO := fTRA_TRANSACAO.CD_EMPRESA;
  viParams.NR_TRANSACAO := fTRA_TRANSACAO.NR_TRANSACAO;
  viParams.DT_TRANSACAO := fTRA_TRANSACAO.DT_TRANSACAO;
  viParams.CD_COMPVEND := vCdVendedor;
  voParams := activateCmp('FISSVCO004', 'AlteraVendedorNF', viParams);
  if (itemXmlF('status', voParams) < 0) then begin
    raise Exception.Create(itemXml('message', voParams));
    exit;
  end;

  exit;
end;

//---------------------------------------------------------------
function T_TRASVCO004.alteraAdicional(pParams : String) : String;
//---------------------------------------------------------------
const
  cDS_METHOD = 'ADICIONAL=Operação: T_TRASVCO004.alteraAdicional()';
var
  vCdEmpresa, vNrTransacao, vTpSituacao : Real;
  vCdGuia, vCdRepresentante,vCdVendedor : Real;
  voParams : String;
  vDtTransacao : TDateTime;
begin
  vCdEmpresa := pParams.CD_EMPRESA;
  vNrTransacao := pParams.NR_TRANSACAO;
  vDtTransacao := pParams.DT_TRANSACAO;
  vCdGuia := pParams.CD_GUIA;
  vCdRepresentante := pParams.CD_REPRESENTANT;
  vCdVendedor := pParams.CD_COMPVEND;
  vTpSituacao := pParams.TP_SITUACAO;

  if (vCdEmpresa = 0) then begin
    raise Exception.Create('Empresa não informada!' + ' / ' + cDS_METHOD);
    exit;
  end;
  if (vNrTransacao = 0) then begin
    raise Exception.Create('Número da transação não informado!' + ' / ' + cDS_METHOD);
    exit;
  end;
  if (vDtTransacao = 0) then begin
    raise Exception.Create('Data transação não informada!' + ' / ' + cDS_METHOD);
    exit;
  end;
  if (vTpSituacao = 0) then begin
    raise Exception.Create('Situação não informada!' + ' / ' + cDS_METHOD);
    exit;
  end;
  if (vTpSituacao < 0) or (vTpSituacao > 10) then begin
    raise Exception.Create('Situação ' + FloatToStr(vTpSituacao) + ' inválida!' + ' / ' + cDS_METHOD);
    exit;
  end;

  fTRA_TRANSACAO.Limpar();
  fTRA_TRANSACAO.CD_EMPRESA := vCdEmpresa;
  fTRA_TRANSACAO.NR_TRANSACAO := vNrTransacao;
  fTRA_TRANSACAO.DT_TRANSACAO := vDtTransacao;
  fTRA_TRANSACAO.Listar(nil);
  if (itemXmlF('status', voParams) < 0) then begin
    raise Exception.Create('Transação ' + FloatToStr(vNrTransacao) + ' não cadastrada!' + ' / ' + cDS_METHOD);
    exit;
  end;

  fTRA_TRANSACAO.CD_GUIA := vCdGuia;
  fTRA_TRANSACAO.CD_REPRESENTANT := vCdRepresentante;
  if (vCdVendedor <> 0) then begin
    fTRA_TRANSACAO.CD_COMPVEND := vCdVendedor;
  end;
  fTRA_TRANSACAO.DT_ULTATEND := PARAM_GLB.DT_SISTEMA;
  fTRA_TRANSACAO.CD_OPERADOR := PARAM_GLB.CD_USUARIO;
  fTRA_TRANSACAO.DT_CADASTRO := Now;

  voParams := tTRA_TRANSACAO.Salvar();
  if (itemXmlF('status', voParams) < 0) then begin
    raise Exception.Create(itemXml('message', voParams));
    exit;
  end;

  exit;
end;

//------------------------------------------------------------------------
function T_TRASVCO004.alteraImpressaoTransacao(pParams : String) : String;
//------------------------------------------------------------------------
const
  cDS_METHOD = 'ADICIONAL=Operação: T_TRASVCO004.alteraImpressaoTransacao()';
var
  vDsRegistro, vDsLstTransacao, viParams : String;
  vCdEmpresa, vNrTransacao, vCdModeloTra : Real;
  voParams : String;
  vDtTransacao : TDateTime;
  vInCommitImpTra : Boolean;
begin
  viParams := pParams;
  vDsLstTransacao := pParams.DS_LSTTRANSACAO;
  vCdModeloTra := pParams.CD_MODELOTRA;

  if (vDsLstTransacao = '') then begin
    raise Exception.Create('Lista de transação não informada!' + ' / ' + cDS_METHOD);
    exit;
  end;
  if (vCdModeloTra = 0) then begin
    raise Exception.Create('Modelo de transação não informado!' + ' / ' + cDS_METHOD);
    exit;
  end;

  fTRA_TRANSACAO.Limpar();

  repeat
    getitem(vDsRegistro, vDsLstTransacao, 1);
    vCdEmpresa := vDsRegistro.CD_EMPRESA;
    vNrTransacao := vDsRegistro.NR_TRANSACAO;
    vDtTransacao := vDsRegistro.DT_TRANSACAO;

    if (vCdEmpresa = 0) then begin
      raise Exception.Create('Empresa não informada!' + ' / ' + cDS_METHOD);
      exit;
    end;
    if (vNrTransacao = 0) then begin
      raise Exception.Create('Número da transação não informado!' + ' / ' + cDS_METHOD);
      exit;
    end;
    if (vDtTransacao = 0) then begin
      raise Exception.Create('Data transação não informada!' + ' / ' + cDS_METHOD);
      exit;
    end;

    fTRA_TRANSACAO.Append();
    fTRA_TRANSACAO.CD_EMPRESA := vCdEmpresa;
    fTRA_TRANSACAO.NR_TRANSACAO := vNrTransacao;
    fTRA_TRANSACAO.DT_TRANSACAO := vDtTransacao;
    fTRA_TRANSACAO.Consultar(nil);
    if (xStatus = -7) then begin
      fTRA_TRANSACAO.Consultar(nil);
    end else if (xStatus = 0) then begin
      raise Exception.Create('Transação ' + FloatToStr(vNrTransacao) + ' não cadastrada!' + ' / ' + cDS_METHOD);
      exit;
    end;

    fTRA_TRANSACAO.CD_MODELOTRA := vCdModeloTra;
    if (fTRA_TRANSACAO.NR_IMPRESSAO = 0) then begin
      fTRA_TRANSACAO.NR_IMPRESSAO := 1;
    end else begin
      fTRA_TRANSACAO.NR_IMPRESSAO := fTRA_TRANSACAO.NR_IMPRESSAO + 1;
    end;
    fTRA_TRANSACAO.CD_USUIMPRESSAO := PARAM_GLB.CD_USUARIO;
    fTRA_TRANSACAO.DT_IMPRESSAO := Now;
    fTRA_TRANSACAO.CD_OPERADOR := PARAM_GLB.CD_USUARIO;
    fTRA_TRANSACAO.DT_CADASTRO := Now;

    delitemGld(vDsLstTransacao, 1);
  until (vDsLstTransacao = '');

  voParams := tTRA_TRANSACAO.Salvar();
  if (itemXmlF('status', voParams) < 0) then begin
    raise Exception.Create(itemXml('message', voParams));
    exit;
  end;

  vInCommitImpTra := viParams.IN_COMMIT_IMP_TRA;
  if (vInCommitImpTra) then begin
    commit;
    if (itemXmlF('status', voParams) < 0) then begin
      rollback;
      exit;
    end;
  end;

  exit;
end;

//-----------------------------------------------------------------------
function T_TRASVCO004.gravaTransportTransacao(pParams : String) : String;
//-----------------------------------------------------------------------
const
  cDS_METHOD = 'ADICIONAL=Operação: T_TRASVCO004.gravaTransportTransacao()';
var
  viParams, voParams, vDsRegistro, vDsLstImposto, vDsUFDestino, vCdCST : String;
  vTpFrete, vCdEmpresa, vNrTransacao, vCdTransport, vNrSeqendereco, vVlFreteTot, vCdTranspConhec : Real;
  vVlFrete, vVlSeguro, vVlDespAcessor, vCdImposto, vVlBaseCalc, vVlImposto, vPrIPI, vVlConhecimento : Real;
  vDtTransacao : TDateTime;
  vInDecreto, vInProduto, vInSubstituicao : Boolean;
begin
  vCdEmpresa := pParams.CD_EMPRESA;
  vNrTransacao := pParams.NR_TRANSACAO;
  vDtTransacao := pParams.DT_TRANSACAO;
  vCdTransport := pParams.CD_TRANSPORT;
  vVlFrete := pParams.VL_FRETE;
  vVlSeguro := pParams.VL_SEGURO;
  vVlDespAcessor := pParams.VL_DESPACESSOR;
  vTpFrete := pParams.TP_FRETE;
  vDsLstImposto := pParams.DS_LSTIMPOSTO;
  vCdTranspConhec := pParams.CD_TRANSPCONHEC;
  vVlConhecimento := pParams.VL_CONHECIMENTO;

  if (vCdTranspConhec <> 0) and (vCdTransport = 0) then begin
    vCdTransport := vCdTranspConhec;
    vTpFrete := 2;
  end;

  if (vCdEmpresa = 0) then begin
    raise Exception.Create('Empresa não informada!' + ' / ' + cDS_METHOD);
    exit;
  end;
  if (vNrTransacao = 0) then begin
    raise Exception.Create('Número transação não informado!' + ' / ' + cDS_METHOD);
    exit;
  end;
  if (vDtTransacao = 0) then begin
    raise Exception.Create('Data transação não informada!' + ' / ' + cDS_METHOD);
    exit;
  end;

  fTRA_TRANSACAO.Limpar();
  fTRA_TRANSACAO.CD_EMPRESA := vCdEmpresa;
  fTRA_TRANSACAO.NR_TRANSACAO := vNrTransacao;
  fTRA_TRANSACAO.DT_TRANSACAO := vDtTransacao;
  fTRA_TRANSACAO.Listar(nil);
  if (itemXmlF('status', voParams) < 0) then begin
    raise Exception.Create('Transação ' + FloatToStr(vNrTransacao) + ' não cadastrada!' + ' / ' + cDS_METHOD);
    exit;
  end;
  if not (fTRA_REMDES.IsEmpty()) then begin
    vDsUFDestino := fTRA_REMDES.DS_SIGLAESTADO;
  end else begin
    fV_PES_ENDERECO.Limpar();
    viParams := '';
    viParams.CD_PESSOA := fTRA_TRANSACAO.CD_PESSOA;
    voParams := activateCmp('PESSVCO005', 'buscaEnderecoFaturamento', viParams);
    if (xStatus >= 0) then begin
      vNrSeqendereco := voParams.NR_SEQENDERECO;
      fV_PES_ENDERECO.CD_PESSOA := fTRA_TRANSACAO.CD_PESSOA;
      fV_PES_ENDERECO.NR_SEQUENCIA := vNrSeqendereco;
      fV_PES_ENDERECO.Listar(nil);
      if (itemXmlF('status', voParams) < 0) then begin
        raise Exception.Create('endereço ' + FloatToStr(vNrSeqendereco) + ' não cadastrado para a transportadora ' + FloatToStr(vCdTransport) + '!' + ' / ' + cDS_METHOD);
        exit;
      end;
    end;
    vDsUFDestino := fV_PES_ENDERECO.DS_SIGLAESTADO;
    fV_PES_ENDERECO.Limpar();
  end;

  if (fTRA_TRANSACAO.CD_EMPFAT <> fTRA_TRANSACAO.CD_EMPRESA) then begin 
    viParams := '';
    viParams.CD_EMPRESA := fTRA_TRANSACAO.CD_EMPFAT;
    getParam(pParams);
  end;

  fTRA_TRANSACAO.VL_FRETE := vVlFrete;
  fTRA_TRANSACAO.VL_SEGURO := vVlSeguro;
  fTRA_TRANSACAO.VL_DESPACESSOR := vVlDespAcessor;

  fTRA_TRANSPORT.Limpar();
  fTRA_TRANSPORT.Listar(nil);
  if (xStatus >= 0) then begin
    if (vCdTransport = 0) then begin
      fPED_PEDIDOTRA.Limpar();
      fPED_PEDIDOTRA.CD_EMPTRANSACAO := fTRA_TRANSACAO.CD_EMPRESA;
      fPED_PEDIDOTRA.NR_TRANSACAO := fTRA_TRANSACAO.NR_TRANSACAO;
      fPED_PEDIDOTRA.DT_TRANSACAO := fTRA_TRANSACAO.DT_TRANSACAO;
      fPED_PEDIDOTRA.Listar(nil);
      if (itemXmlF('status', voParams) < 0) then begin
        fTRA_TRANSPORT.First();
        vCdTransport := fTRA_TRANSPORT.CD_TRANSPORT;
        vTpFrete := fTRA_TRANSPORT.TP_FRETE;
        pParams := fTRA_TRANSPORT.GetValues();
      end;
    end;

    voParams := tTRA_TRANSPORT.Excluir();
    if (itemXmlF('status', voParams) < 0) then begin
      raise Exception.Create(itemXml('message', voParams));
      exit;
    end;
  end else begin
    fTRA_TRANSPORT.Limpar();
  end;

  fTRA_TRAIMPOSTO.Limpar();
  fTRA_TRAIMPOSTO.Listar(nil);
  if (xStatus >= 0) then begin
    voParams := tTRA_TRAIMPOSTO.Excluir();
    if (itemXmlF('status', voParams) < 0) then begin
      raise Exception.Create(itemXml('message', voParams));
      exit;
    end;
  end else begin
    fTRA_TRAIMPOSTO.Limpar();
  end;
  if (vCdTransport > 0) then begin
    if (vTpFrete = 0) then begin
      raise Exception.Create('Tipo frete não informado!' + ' / ' + cDS_METHOD);
      exit;
    end;

    fV_PES_ENDERECO.Limpar();

    viParams := '';
    viParams.CD_PESSOA := vCdTransport;
    voParams := activateCmp('PESSVCO005', 'buscaenderecoFaturamento', viParams);
    if (xStatus >= 0) then begin
      vNrSeqendereco := voParams.NR_SEQENDERECO;
      fV_PES_ENDERECO.CD_PESSOA := vCdTransport;
      fV_PES_ENDERECO.NR_SEQUENCIA := vNrSeqendereco;
      fV_PES_ENDERECO.Listar(nil);
      if (itemXmlF('status', voParams) < 0) then begin
        raise Exception.Create('endereço ' + FloatToStr(vNrSeqendereco) + ' não cadastrado para a transportadora ' + FloatToStr(vCdTransport) + '!' + ' / ' + cDS_METHOD);
        exit;
      end;
    end;

    fTRA_TRANSPORT.Append();
    delitem(pParams, 'CD_EMPRESA');
    delitem(pParams, 'NR_TRANSACAO');
    delitem(pParams, 'DT_TRANSACAO');
    fTRA_TRANSPORT.SetValues(pParams);

    viParams := '';
    viParams.CD_PESSOA := vCdTransport;
    voParams := activateCmp('PESSVCO005', 'buscaDadosPessoa', viParams);
    if (itemXmlF('status', voParams) < 0) then begin
      raise Exception.Create(itemXml('message', voParams));
      exit;
    end;
    if (voParams.TP_PESSOA = 'F') then begin
      fTRA_TRANSPORT.NR_RGINSCREST := voParams.NR_RG;
    end else begin
      fTRA_TRANSPORT.NR_RGINSCREST := voParams.NR_INSCESTL;
    end;
    fTRA_TRANSPORT.NR_CPFCNPJ := voParams.NR_CPFCNPJ;
    if (fTRA_TRANSPORT.NM_TRANSPORT = '') then begin
      fTRA_TRANSPORT.NM_TRANSPORT := voParams.NM_PESSOA;
    end;

    fV_PES_ENDERECO.First();
    if (fV_PES_ENDERECO.IsDatabase()) then begin
      fTRA_TRANSPORT.NM_LOGRADOURO := fV_PES_ENDERECO.NM_LOGRADOURO;
      fTRA_TRANSPORT.DS_TPLOGRADOURO := fV_PES_ENDERECO.DS_SIGLALOGRAD;
      fTRA_TRANSPORT.NR_LOGRADOURO := fV_PES_ENDERECO.NR_LOGRADOURO;
      fTRA_TRANSPORT.NR_CAIXAPOSTAL := fV_PES_ENDERECO.NR_CAIXAPOSTAL;
      fTRA_TRANSPORT.NM_BAIRRO := fV_PES_ENDERECO.DS_BAIRRO;
      fTRA_TRANSPORT.CD_CEP := fV_PES_ENDERECO.CD_CEP;
      fTRA_TRANSPORT.NM_MUNICIPIO := fV_PES_ENDERECO.NM_MUNICIPIO;
      fTRA_TRANSPORT.DS_SIGLAESTADO := fV_PES_ENDERECO.DS_SIGLAESTADO;
    end;
    if (fTRA_TRANSPORT.CD_TRANSREDESPAC > 0) and (fTRA_TRANSPORT.NM_TRANSREDESPAC = '') then begin
      viParams := '';
      viParams.CD_PESSOA := fTRA_TRANSPORT.CD_TRANSREDESPAC;
      voParams := activateCmp('PESSVCO005', 'buscaDadosPessoa', viParams);
      if (itemXmlF('status', voParams) < 0) then begin
        raise Exception.Create(itemXml('message', voParams));
        exit;
      end;
      fTRA_TRANSPORT.NM_TRANSREDESPAC := voParams.NM_PESSOA;
    end;
    fTRA_TRANSPORT.CD_EMPFAT := fTRA_TRANSACAO.CD_EMPFAT;
    fTRA_TRANSPORT.CD_GRUPOEMPRESA := fTRA_TRANSACAO.CD_GRUPOEMPRESA;
    fTRA_TRANSPORT.CD_OPERADOR := PARAM_GLB.CD_USUARIO;
    fTRA_TRANSPORT.DT_CADASTRO := Now;
  end else begin

    if (fGER_OPERACAO.TP_DOCTO = 1) then begin
      if (vTpFrete <> 0) then begin
        raise Exception.Create('Transportadora não informada!' + ' / ' + cDS_METHOD);
        exit;
      end;
      fTRA_TRANSPORT.Append();
      delitem(pParams, 'CD_EMPRESA');
      delitem(pParams, 'NR_TRANSACAO');
      delitem(pParams, 'DT_TRANSACAO');
      fTRA_TRANSPORT.SetValues(pParams);
      fTRA_TRANSPORT.CD_EMPFAT := fTRA_TRANSACAO.CD_EMPFAT;
      fTRA_TRANSPORT.CD_GRUPOEMPRESA := fTRA_TRANSACAO.CD_GRUPOEMPRESA;
      fTRA_TRANSPORT.CD_OPERADOR := PARAM_GLB.CD_USUARIO;
      fTRA_TRANSPORT.DT_CADASTRO := Now;
    end;
  end;
  if (vDsLstImposto = '') then begin
    viParams := '';
    viParams.CD_EMPRESA := fTRA_TRANSACAO.CD_EMPFAT;
    viParams.UF_DESTINO := vDsUFDestino;
    viParams.TP_ORIGEMEMISSAO := fTRA_TRANSACAO.TP_ORIGEMEMISSAO;
    viParams.CD_OPERACAO := fGER_OPERACAO.CD_OPERACAO;
    viParams.CD_PESSOA := fTRA_TRANSACAO.CD_PESSOA;
    viParams.VL_FRETE := fTRA_TRANSACAO.VL_FRETE;
    viParams.VL_SEGURO := fTRA_TRANSACAO.VL_SEGURO;
    viParams.VL_DESPACESSOR := fTRA_TRANSACAO.VL_DESPACESSOR;

    fF_TRA_ITEMIMPOSTO.Limpar();
    fF_TRA_ITEMIMPOSTO.CD_EMPRESA := fTRA_TRANSACAO.CD_EMPRESA;
    fF_TRA_ITEMIMPOSTO.NR_TRANSACAO := fTRA_TRANSACAO.NR_TRANSACAO;
    fF_TRA_ITEMIMPOSTO.DT_TRANSACAO := fTRA_TRANSACAO.DT_TRANSACAO;
    fF_TRA_ITEMIMPOSTO.CD_IMPOSTO := 3;
    fF_TRA_ITEMIMPOSTO.Listar(nil);
    if (xStatus >= 0) then begin
      vVlBaseCalc := 0;
      vVlImposto := 0;

      fF_TRA_ITEMIMPOSTO.First();
      while not t.EOF do begin
        if (fF_TRA_ITEMIMPOSTO.VL_IMPOSTO > 0) then begin
          vVlBaseCalc := vVlBaseCalc + fF_TRA_ITEMIMPOSTO.VL_BASECALC;
          vVlImposto := vVlImposto + fF_TRA_ITEMIMPOSTO.VL_IMPOSTO;
        end;
        fF_TRA_ITEMIMPOSTO.Next();
      end;

      vPrIPI := (vVlImposto / vVlBaseCalc) * 100;
      vPrIPI := rounded(vPrIPI, 2);

      viParams.PR_IPI := vPrIPI;
      viParams.IN_IPI := True;
    end else begin
      viParams.IN_IPI := False;
    end;

    if not (fTRA_TRANSITEM.IsEmpty()) then begin
      tTRA_TRANSITEM.IndexFieldNames := 'CD_DECRETO';

      vInDecreto := False;
      vInProduto := False;
      vInSubstituicao := False;

      fTRA_TRANSITEM.First();
      while not t.EOF do begin
        if not (fTRA_TRANSITEM.CD_DECRETO <> 0) and (vInDecreto) then begin
          viParams.CD_DECRETO := fTRA_TRANSITEM.CD_DECRETO;
          viParams.CD_CST := fTRA_TRANSITEM.CD_CST;
          viParams.CD_PRODUTO := fTRA_TRANSITEM.CD_PRODUTO;
          vInDecreto := True;
          break;
        end;

        vCdCST := Copy(fTRA_TRANSITEM.CD_CST,2,2);
        if not ((vCdCST = '10') or (vCdCST = '30') or (vCdCST = '60') or (vCdCST = '70')) and (vInSubstituicao) then begin
          viParams.CD_CST := fTRA_TRANSITEM.CD_CST;
          viParams.CD_PRODUTO := fTRA_TRANSITEM.CD_PRODUTO;
          vInSubstituicao := True;
          break;
        end;
        if not (fTRA_TRANSITEM.CD_ESPECIE <> gCdEspecieServico) and (vInProduto) then begin
          viParams.CD_PRODUTO := fTRA_TRANSITEM.CD_PRODUTO;
          vInProduto := True;
        end;

        fTRA_TRANSITEM.Next();
      end;
      if not (vInDecreto = False) and (vInSubstituicao) then begin
        fTRA_TRANSITEM.First();
        viParams.CD_CST := fTRA_TRANSITEM.CD_CST;
      end;
    end;

    voParams := activateCmp('FISSVCO015', 'calculaImpostoCapa', viParams);
    if (itemXmlF('status', voParams) < 0) then begin
      raise Exception.Create(itemXml('message', voParams));
      exit;
    end;

    vDsLstImposto := voParams.DS_LSTIMPOSTO;
  end;
  if (vDsLstImposto <> '') then begin
    repeat
      getitem(vDsRegistro, vDsLstImposto, 1);

      vCdImposto := vDsRegistro.CD_IMPOSTO;
      if (vCdImposto > 0) then begin
        delitem(vDsRegistro, 'CD_EMPRESA');
        delitem(vDsRegistro, 'NR_TRANSACAO');
        delitem(vDsRegistro, 'DT_TRANSACAO');
        delitem(vDsRegistro, 'NR_ITEM');

        fTRA_TRAIMPOSTO.Append();
        fTRA_TRAIMPOSTO.SetValues(vDsRegistro);
        fTRA_TRAIMPOSTO.CD_EMPFAT := fTRA_TRANSACAO.CD_EMPFAT;
        fTRA_TRAIMPOSTO.CD_GRUPOEMPRESA := fTRA_TRANSACAO.CD_GRUPOEMPRESA;
        fTRA_TRAIMPOSTO.CD_OPERADOR := PARAM_GLB.CD_USUARIO;
        fTRA_TRAIMPOSTO.DT_CADASTRO := Now;
      end;

      delitemGld(vDsLstImposto, 1);
    until (vDsLstImposto = '');
  end;

  viParams := '';
  voParams := calculaTotalTransacao(viParams);
  if (itemXmlF('status', voParams) < 0) then begin
    raise Exception.Create(itemXml('message', voParams));
    exit;
  end;

  fTRA_TRANSACAO.CD_OPERADOR := PARAM_GLB.CD_USUARIO;
  fTRA_TRANSACAO.DT_CADASTRO := Now;

  if (vCdTranspConhec <> 0) then begin
    fTRA_TRANSPORT.CD_TRANSPCONHEC := vCdTranspConhec;
    fTRA_TRANSPORT.VL_CONHECIMENTO := vVlConhecimento;
  end;
  if (fTRA_TRANSPORT.CD_EMPFAT = '') and (fTRA_TRANSPORT.CD_TRANSPORT > 0) then begin
    fTRA_TRANSPORT.CD_EMPFAT := fTRA_TRANSACAO.CD_EMPFAT;
    fTRA_TRANSPORT.CD_GRUPOEMPRESA := fTRA_TRANSACAO.CD_GRUPOEMPRESA;
    fTRA_TRANSPORT.CD_OPERADOR := PARAM_GLB.CD_USUARIO;
    fTRA_TRANSPORT.DT_CADASTRO := Now;
  end;

  voParams := tTRA_TRANSACAO.Salvar();
  if (itemXmlF('status', voParams) < 0) then begin
    raise Exception.Create(itemXml('message', voParams));
    exit;
  end;

  exit;
end;

//-----------------------------------------------------------------------
function T_TRASVCO004.gravaValorItemTransacao(pParams : String) : String;
//-----------------------------------------------------------------------
const
  cDS_METHOD = 'ADICIONAL=Operação: T_TRASVCO004.gravaValorItemTransacao()';
var
  vDsTransacao, vDsTransItem,
  viParams, voParams, vDsRegistro, vDsLstValor, vDsLstVl, vTpValor : String;
  vCdEmpresa, vCdCusto, vNrTransacao, vNrItem, vPrDescPadrao, vPrDescCabPadrao : Real;
  vVlPadrao, vPrImposto, vVlImposto, vVlOriginal, vVlCalc, vTpAtualizacaoPadrao, vTpAtualizacao : Real;
  vVlCustoValorRetido, vVlSubstTributaria : Real;
  vInPadrao, vInNaoExclui : Boolean;
  vDtTransacao : TDateTime;
  vPos : Integer;
begin
  vCdEmpresa := pParams.CD_EMPRESA;
  vNrTransacao := pParams.NR_TRANSACAO;
  vDtTransacao := pParams.DT_TRANSACAO;
  vNrItem := pParams.NR_ITEM;
  vDsLstValor := pParams.DS_LSTVALOR;
  vInNaoExclui := pParams.IN_NAOEXCLUI;

  if (vCdEmpresa = 0) then begin
    raise Exception.Create('Empresa não informada!' + ' / ' + cDS_METHOD);
    exit;
  end;
  if (vNrTransacao = 0) then begin
    raise Exception.Create('Número transação não informado!' + ' / ' + cDS_METHOD);
    exit;
  end;
  if (vDtTransacao = 0) then begin
    raise Exception.Create('Data transação não informada!' + ' / ' + cDS_METHOD);
    exit;
  end;
  if (vNrItem = 0) then begin
    raise Exception.Create('Item da transação não informado!' + ' / ' + cDS_METHOD);
    exit;
  end;

  vDsTransacao := pParams.DS_TRANSACAO;

  fTRA_TRANSACAO.Limpar();
  if (vDsTransacao <> '') then begin
    TmXml.SetXmlToObjeto(vDsTransacao,TRA_TRANSACAO);
  end else begin
    fTRA_TRANSACAO.CD_EMPRESA := vCdEmpresa;
    fTRA_TRANSACAO.NR_TRANSACAO := vNrTransacao;
    fTRA_TRANSACAO.DT_TRANSACAO := vDtTransacao;
    fTRA_TRANSACAO.Listar(nil);
    if (itemXmlF('status', voParams) < 0) then begin
      raise Exception.Create('Transação ' + FloatToStr(vNrTransacao) + ' não cadastrada!' + ' / ' + cDS_METHOD);
      exit;
    end;
  end;

  if (fTRA_TRANSACAO.CD_EMPFAT <> fTRA_TRANSACAO.CD_EMPRESA) then begin
    viParams := '';
    viParams.CD_EMPRESA := fTRA_TRANSACAO.CD_EMPFAT;
    getParam(pParams);
  end;

  vDsTransItem := pParams.DS_TRANSITEM;

  fTRA_TRANSITEM.Limpar();
  if (vDsTransItem <> '') then begin
    TmXml.SetXmlToObjeto(vDsTransItem,TRA_TRANSITEM);
  end else begin
    fTRA_TRANSITEM.NR_ITEM := vNrItem;
    fTRA_TRANSITEM.Listar(nil);
    if (itemXmlF('status', voParams) < 0) then begin
      raise Exception.Create('Item ' + FloatToStr(vNrItem) + ' da transação ' + FloatToStr(vNrTransacao) + ' não cadastrada!' + ' / ' + cDS_METHOD);
      exit;
    end;
  end;  

  fTRA_ITEMVL.Limpar();
  fTRA_ITEMVL.Listar(nil);
  if (xStatus >= 0) then begin
    if (vInNaoExclui <> True) then begin
      voParams := tTRA_ITEMVL.Excluir();
      if (itemXmlF('status', voParams) < 0) then begin
        raise Exception.Create(itemXml('message', voParams));
        exit;
      end;
    end;
  end;

  if (vDsLstValor <> '') then begin
    vVlPadrao := 0;
    vPrDescPadrao := 0;
    vPrDescCabPadrao := 0;
    vTpAtualizacaoPadrao := 1;

    repeat
      getitem(vDsRegistro, vDsLstValor, 1);

      vTpValor := vDsRegistro.TP_VALOR;
      vCdCusto := vDsRegistro.CD_VALOR;
      vInPadrao := vDsRegistro.IN_PADRAO;

      if (vTpValor = 'C') and (vCdCusto = gCdCustoMedio) and (fGER_OPERACAO.TP_OPERACAO = 'E') and (fGER_OPERACAO.TP_MODALIDADE = 4) then begin
        if (vInPadrao) then begin
          raise Exception.Create('Custo padrão médio (CD_CUSTO_MEDIO_CMP) ' + FloatToStr(vCdCusto) + ' não pode ser o custo padrão!' + ' / ' + cDS_METHOD);
          exit;
        end;
      end else begin
        fTRA_ITEMVL.Append();
        fTRA_ITEMVL.SetValues(vDsRegistro);
        fTRA_ITEMVL.CD_EMPFAT := fTRA_TRANSITEM.CD_EMPFAT;
        fTRA_ITEMVL.CD_GRUPOEMPRESA := fTRA_TRANSITEM.CD_GRUPOEMPRESA;
        fTRA_ITEMVL.CD_OPERADOR := PARAM_GLB.CD_USUARIO;
        fTRA_ITEMVL.DT_CADASTRO := Now;

        if (fTRA_ITEMVL.IN_PADRAO) then begin
          vVlPadrao := fTRA_ITEMVL.VL_UNITARIO;
          vPrDescPadrao := fTRA_ITEMVL.PR_DESCONTO;
          vPrDescCabPadrao := fTRA_ITEMVL.PR_DESCONTOCAB;
          vTpAtualizacaoPadrao := fTRA_ITEMVL.TP_ATUALIZACAO;
        end;
      end;

      delitemGld(vDsLstValor, 1);
    until (vDsLstValor = '');

    if (fGER_OPERACAO.TP_OPERACAO = 'E') and ((fGER_OPERACAO.TP_MODALIDADE = 4) or (fGER_OPERACAO.TP_MODALIDADE = 2)) then begin
      if (vVlPadrao = 0) then begin
        raise Exception.Create('Nenhum valor padrão encontrado na lista de valores!' + ' / ' + cDS_METHOD);
        exit;
      end;
    end;

    if (fGER_OPERACAO.TP_OPERACAO = 'E') and (fGER_OPERACAO.TP_MODALIDADE = 4) then begin
      if (gCdCustoMedio > 0) then begin
        viParams := '';
        viParams.CD_EMPRESA := fTRA_TRANSITEM.CD_EMPFAT;
        viParams.CD_PRODUTO := fTRA_TRANSITEM.CD_PRODUTO;
        viParams.TP_VALOR := 'C';
        viParams.CD_VALOR := gCdCustoMedio;
        voParams := activateCmp('PRDSVCO007', 'buscaValorData', viParams);
        if (itemXmlF('status', voParams) < 0) then begin
          raise Exception.Create(itemXml('message', voParams));
          exit;
        end;

        vVlOriginal := voParams.VL_VALOR;

        fTRA_ITEMVL.Append();
        fTRA_ITEMVL.TP_VALOR := 'C';
        fTRA_ITEMVL.CD_VALOR := gCdCustoMedio;
        fTRA_ITEMVL.TP_ATUALIZACAO := 02;
        fTRA_ITEMVL.VL_UNITARIOORIG := vVlOriginal;
        fTRA_ITEMVL.VL_UNITARIO := vVlPadrao;
        fTRA_ITEMVL.PR_DESCONTO := vPrDescPadrao;
        fTRA_ITEMVL.PR_DESCONTOCAB := vPrDescCabPadrao;
        fTRA_ITEMVL.CD_EMPFAT := fTRA_TRANSITEM.CD_EMPFAT;
        fTRA_ITEMVL.CD_GRUPOEMPRESA := fTRA_TRANSITEM.CD_GRUPOEMPRESA;
        fTRA_ITEMVL.CD_OPERADOR := PARAM_GLB.CD_USUARIO;
        fTRA_ITEMVL.DT_CADASTRO := Now;
      end;

      if (gDsCustoSubstTributaria <> '') then begin
        fF_TRA_ITEMIMPOSTO.Limpar();
        fF_TRA_ITEMIMPOSTO.CD_EMPRESA := fTRA_TRANSITEM.CD_EMPRESA;
        fF_TRA_ITEMIMPOSTO.NR_TRANSACAO := fTRA_TRANSITEM.NR_TRANSACAO;
        fF_TRA_ITEMIMPOSTO.DT_TRANSACAO := fTRA_TRANSITEM.DT_TRANSACAO;
        fF_TRA_ITEMIMPOSTO.NR_ITEM := fTRA_TRANSITEM.NR_ITEM;
        fF_TRA_ITEMIMPOSTO.CD_IMPOSTO := 2;
        fF_TRA_ITEMIMPOSTO.Listar(nil);
        if (xStatus >= 0) then begin
          vVlSubstTributaria := fF_TRA_ITEMIMPOSTO.VL_BASECALC / fTRA_TRANSITEM.QT_SOLICITADA;
          vVlSubstTributaria := rounded(vVlSubstTributaria, 2);

          vPos := Pos(';', gDsCustoSubstTributaria);
          vCdCusto := IffNuloF(Copy(gDsCustoSubstTributaria, 1, vPos-1), 0);
          vTpAtualizacao := IffNuloF(Copy(gDsCustoSubstTributaria, vPos + 1, Length(gDsCustoSubstTributaria)), 0);

          viParams := '';
          viParams.CD_EMPRESA := fTRA_TRANSITEM.CD_EMPFAT;
          viParams.CD_PRODUTO := fTRA_TRANSITEM.CD_PRODUTO;
          viParams.TP_VALOR := 'C';
          viParams.CD_VALOR := vCdCusto;
          voParams := activateCmp('PRDSVCO007', 'buscaValorData', viParams);
          if (itemXmlF('status', voParams) < 0) then begin
            raise Exception.Create(itemXml('message', voParams));
            exit;
          end;
          vVlOriginal := voParams.VL_VALOR;

          fTRA_ITEMVL.Append();
          fTRA_ITEMVL.TP_VALOR := 'C';
          fTRA_ITEMVL.CD_VALOR := vCdCusto;
          fTRA_ITEMVL.Consultar(nil);
          if (xStatus = -7) then begin
            fTRA_ITEMVL.Consultar(nil);
          end;
          fTRA_ITEMVL.TP_ATUALIZACAO := vTpAtualizacao;
          fTRA_ITEMVL.VL_UNITARIOORIG := vVlOriginal;
          fTRA_ITEMVL.VL_UNITARIO := vVlSubstTributaria;
          fTRA_ITEMVL.PR_DESCONTO := vPrDescPadrao;
          fTRA_ITEMVL.PR_DESCONTOCAB := vPrDescCabPadrao;
          fTRA_ITEMVL.CD_EMPFAT := fTRA_TRANSITEM.CD_EMPFAT;
          fTRA_ITEMVL.CD_GRUPOEMPRESA := fTRA_TRANSITEM.CD_GRUPOEMPRESA;
          fTRA_ITEMVL.CD_OPERADOR := PARAM_GLB.CD_USUARIO;
          fTRA_ITEMVL.DT_CADASTRO := Now;
        end;
      end;

      if (gDsCustoValorRetido <> '') then begin
        fF_TRA_ITEMIMPOSTO.Limpar();
        fF_TRA_ITEMIMPOSTO.CD_EMPRESA := fTRA_TRANSITEM.CD_EMPRESA;
        fF_TRA_ITEMIMPOSTO.NR_TRANSACAO := fTRA_TRANSITEM.NR_TRANSACAO;
        fF_TRA_ITEMIMPOSTO.DT_TRANSACAO := fTRA_TRANSITEM.DT_TRANSACAO;
        fF_TRA_ITEMIMPOSTO.NR_ITEM := fTRA_TRANSITEM.NR_ITEM;
        fF_TRA_ITEMIMPOSTO.CD_IMPOSTO := 2;
        fF_TRA_ITEMIMPOSTO.Listar(nil);
        if (xStatus >= 0) then begin
          vVlCustoValorRetido := fF_TRA_ITEMIMPOSTO.VL_IMPOSTO / fTRA_TRANSITEM.QT_SOLICITADA;
          vVlCustoValorRetido := rounded(vVlCustoValorRetido, 2);

          vPos := Pos(';', gDsCustoValorRetido);
          vCdCusto := IffNuloF(Copy(gDsCustoValorRetido, 1, vPos-1), 0);
          vTpAtualizacao := IffNuloF(Copy(gDsCustoValorRetido, vPos + 1, Length(gDsCustoValorRetido)), 0);

          viParams := '';
          viParams.CD_EMPRESA := fTRA_TRANSITEM.CD_EMPFAT;
          viParams.CD_PRODUTO := fTRA_TRANSITEM.CD_PRODUTO;
          viParams.TP_VALOR := 'C';
          viParams.CD_VALOR := vCdCusto;
          voParams := activateCmp('PRDSVCO007', 'buscaValorData', viParams);
          if (itemXmlF('status', voParams) < 0) then begin
            raise Exception.Create(itemXml('message', voParams));
            exit;
          end;
          vVlOriginal := voParams.VL_VALOR;

          fTRA_ITEMVL.Append();
          fTRA_ITEMVL.TP_VALOR := 'C';
          fTRA_ITEMVL.CD_VALOR := vCdCusto;
          fTRA_ITEMVL.Consultar(nil);
          if (xStatus = -7) then begin
            fTRA_ITEMVL.Consultar(nil);
          end;

          fTRA_ITEMVL.TP_ATUALIZACAO := vTpAtualizacao;
          fTRA_ITEMVL.VL_UNITARIOORIG := vVlOriginal;
          fTRA_ITEMVL.VL_UNITARIO := vVlCustoValorRetido;
          fTRA_ITEMVL.PR_DESCONTO := vPrDescPadrao;
          fTRA_ITEMVL.PR_DESCONTOCAB := vPrDescCabPadrao;
          fTRA_ITEMVL.CD_EMPFAT := fTRA_TRANSITEM.CD_EMPFAT;
          fTRA_ITEMVL.CD_GRUPOEMPRESA := fTRA_TRANSITEM.CD_GRUPOEMPRESA;
          fTRA_ITEMVL.CD_OPERADOR := PARAM_GLB.CD_USUARIO;
          fTRA_ITEMVL.DT_CADASTRO := Now;
        end;
      end;
    end;

    voParams := tTRA_ITEMVL.Salvar();
    if (itemXmlF('status', voParams) < 0) then begin
      raise Exception.Create(itemXml('message', voParams));
      exit;
    end;
  end;

  exit;
end;

//-------------------------------------------------------------------
function T_TRASVCO004.removeItemTransacao(pParams : String) : String;
//-------------------------------------------------------------------
const
  cDS_METHOD = 'ADICIONAL=Operação: T_TRASVCO004.removeItemTransacao()';
var
  viParams, voParams, vCdCST : String;
  vCdEmpresa, vNrTransacao, vNrItem, {vTpContrInspSaldoLote,} vCdOperSaldo : Real;
  vDtTransacao : TDateTime;
  vInTotal, vInSemMovimento : Boolean;
begin
  vCdEmpresa := pParams.CD_EMPRESA;
  vNrTransacao := pParams.NR_TRANSACAO;
  vDtTransacao := pParams.DT_TRANSACAO;
  vNrItem := pParams.NR_ITEM;
  vInTotal := pParams.IN_TOTAL;
  vInSemMovimento := pParams.IN_SEMMOVIMENTO;

  //vTpContrInspSaldoLote := PARAM_GLB.TP_CONTR_INSP_SALDO_LOTE;

  if (vCdEmpresa = 0) then begin
    raise Exception.Create('Empresa não informada!' + ' / ' + cDS_METHOD);
    exit;
  end;
  if (vNrTransacao = 0) then begin
    raise Exception.Create('Número transação não informado!' + ' / ' + cDS_METHOD);
    exit;
  end;
  if (vDtTransacao = 0) then begin
    raise Exception.Create('Data transação não informada!' + ' / ' + cDS_METHOD);
    exit;
  end;
  if (vInTotal) then begin
    vNrItem := 0;
  end else begin
    if (vNrItem = 0) then begin
      raise Exception.Create('Item da transação não informado!' + ' / ' + cDS_METHOD);
      exit;
    end;
  end;

  fTRA_TRANSACAO.Limpar();
  fTRA_TRANSACAO.CD_EMPRESA := vCdEmpresa;
  fTRA_TRANSACAO.NR_TRANSACAO := vNrTransacao;
  fTRA_TRANSACAO.DT_TRANSACAO := vDtTransacao;
  fTRA_TRANSACAO.Listar(nil);
  if (itemXmlF('status', voParams) < 0) then begin
    raise Exception.Create('Transação ' + FloatToStr(vNrTransacao) + ' não cadastrada!' + ' / ' + cDS_METHOD);
    exit;
  end;
  if (fTRA_TRANSACAO.TP_SITUACAO <> 1) and (fTRA_TRANSACAO.TP_SITUACAO <> 2) then begin
    raise Exception.Create('Transação ' + FloatToStr(vNrTransacao) + ' não esta em andamento!' + ' / ' + cDS_METHOD);
    exit;
  end;

  if (fTRA_TRANSACAO.CD_EMPFAT <> fTRA_TRANSACAO.CD_EMPRESA) then begin 
    viParams := '';
    viParams.CD_EMPRESA := fTRA_TRANSACAO.CD_EMPFAT;
    getParam(pParams);
  end;

  if (vNrItem < 0) then begin
    fTRA_TRANSITEM.Next();
    vNrItem := fTRA_TRANSITEM.NR_ITEM;
  end;

  //-- MFGALEGO - 09/12/2014 ; erro exclusao imposto
  (* fGER_OPERSALDOPRD.Limpar();
  fGER_OPERSALDOPRD.CD_OPERACAO := fTRA_TRANSACAO.CD_OPERACAO;
  fGER_OPERSALDOPRD.IN_PADRAO := True;
  fGER_OPERSALDOPRD.Listar(nil);
  if (xStatus >= 0) then begin
    vCdOperSaldo := fGER_OPERSALDOPRD.CD_SALDO;
  end; *)
  //--

  fTRA_TRANSITEM.Limpar();
  fTRA_TRANSITEM.NR_ITEM := vNrItem;
  fTRA_TRANSITEM.Listar(nil);
  if (xStatus >= 0) then begin
    //-- MFGALEGO - 09/12/2014 ; erro exclusao imposto
    (* if (vTpContrInspSaldoLote <> 1) then begin
      if not (fTRA_ITEMLOTE.IsEmpty()) and (vInSemMovimento <> True) and (fGER_OPERACAO.IN_KARDEX) and (fTRA_TRANSACAO.TP_OPERACAO = 'S') then begin
        fTRA_ITEMLOTE.First();
        while not t.EOF do begin

          fPRD_LOTEI.Limpar();
          fPRD_LOTEI.CD_EMPRESA := fTRA_ITEMLOTE.CD_EMPLOTE;
          fPRD_LOTEI.NR_LOTE := fTRA_ITEMLOTE.NR_LOTE;
          fPRD_LOTEI.NR_ITEM := fTRA_ITEMLOTE.NR_ITEMLOTE;
          fPRD_LOTEI.Listar(nil);
          if (xStatus >= 0) then begin
            if (vCdOperSaldo <> 0) and (vCdOperSaldo <> fPRD_LOTEI.CD_SALDO) then begin
              raise Exception.Create('Saldo ' + fPRD_LOTEI.CD_SALDO + ' do item de lote ' + fPRD_LOTEI.CD_EMPRESA + ' / ' + fPRD_LOTEI.NR_LOTE + ' / ' + fPRD_LOTEI.NR_ITEM + ' diferente do saldo ' + FloatToStr(vCdOperSaldo) + ' que é padrão da operação ' + fTRA_TRANSACAO.CD_OPERACAO + '!' + ' / ' + cDS_METHOD);
              exit;
            end;
          end;

          viParams := '';
          viParams.CD_EMPRESA := fTRA_ITEMLOTE.CD_EMPLOTE;
          viParams.NR_LOTE := fTRA_ITEMLOTE.NR_LOTE;
          viParams.NR_ITEM := fTRA_ITEMLOTE.NR_ITEMLOTE;
          viParams.QT_MOVIMENTO := fTRA_ITEMLOTE.QT_LOTE;
          viParams.TP_MOVIMENTO := 'B';
          viParams.IN_ESTORNO := True;
          if (fGER_OPERACAO.TP_MODALIDADE = 3) then begin
            viParams.IN_VALIDASITUACAO := False;
          end;
          voParams := activateCmp('PRDSVCO020', 'movimentaQtLoteI', viParams);
          if (itemXmlF('status', voParams) < 0) then begin
            raise Exception.Create(itemXml('message', voParams));
            exit;
          end;
          fTRA_ITEMLOTE.Next();
        end;
      end;
    end; *)
    //--

    //-- MFGALEGO - 09/12/2014 ; erro exclusao imposto
    (* viParams := '';
    viParams.CD_EMPRESA := fTRA_TRANSITEM.CD_EMPRESA;
    viParams.DT_TRANSACAO := fTRA_TRANSITEM.DT_TRANSACAO;
    viParams.NR_TRANSACAO := fTRA_TRANSITEM.NR_TRANSACAO;
    viParams.NR_ITEM := fTRA_TRANSITEM.NR_ITEM;
    voParams := activateCmp('TRASVCO016', 'removeSerialTransacao', viParams);
    if (itemXmlF('status', voParams) < 0) then begin
      raise Exception.Create(itemXml('message', voParams));
      exit;
    end; *)
    //--

    //-- MFGALEGO - 09/12/2014 ; erro exclusao imposto
    viParams := '';
    viParams.CD_EMPRESA := fTRA_TRANSITEM.CD_EMPRESA;
    viParams.DT_TRANSACAO := fTRA_TRANSITEM.DT_TRANSACAO;
    viParams.NR_TRANSACAO := fTRA_TRANSITEM.NR_TRANSACAO;
    viParams.NR_ITEM := fTRA_TRANSITEM.NR_ITEM;
    voParams := gModulo.ExcluirXmlUp('TRA_ITEMIMPOSTO', 'CD_EMPRESA|DT_TRANSACAO|NR_TRANSACAO|NR_ITEM|', viParams);
    if (itemXmlF('status', voParams) < 0) then begin
      raise Exception.Create(itemXml('message', voParams));
      exit;
    end;
    //--

    voParams := tTRA_TRANSITEM.Excluir();
    if (itemXmlF('status', voParams) < 0) then begin
      raise Exception.Create(itemXml('message', voParams));
      exit;
    end;

    viParams := '';
    voParams := calculaTotalTransacao(viParams);
    if (itemXmlF('status', voParams) < 0) then begin
      raise Exception.Create(itemXml('message', voParams));
      exit;
    end;

    fTRA_TRANSACAO.CD_OPERADOR := PARAM_GLB.CD_USUARIO;
    fTRA_TRANSACAO.DT_CADASTRO := Now;

    voParams := tTRA_TRANSACAO.Salvar();
    if (itemXmlF('status', voParams) < 0) then begin
      raise Exception.Create(itemXml('message', voParams));
      exit;
    end;
  end;

  exit;
end;

//----------------------------------------------------------------------
function T_TRASVCO004.gravaEnderecoTransacao(pParams : String) : String;
//----------------------------------------------------------------------
const
  cDS_METHOD = 'ADICIONAL=Operação: T_TRASVCO004.gravaEnderecoTransacao()';
var
  vInSobrepor, vInPjIsento, vInContribuinte, inCFPesJuridica, vInAltEnderecoCli : Boolean;
  voParams, vDsNome, vTpPessoa, vUfOrigem : String;
  vCdEmpresa, vNrTransacao : Real;
  vDtTransacao : TDateTime;
begin
  vCdEmpresa := pParams.CD_EMPRESA;
  vNrTransacao := pParams.NR_TRANSACAO;
  vDtTransacao := pParams.DT_TRANSACAO;
  vDsNome := pParams.NM_NOME;
  vTpPessoa := pParams.TP_PESSOA;
  vInSobrepor := pParams.IN_SOBREPOR;
  inCFPesJuridica := pParams.IN_CF_PESJURIDICA;
  vInAltEnderecoCli := pParams.IN_ALT_ENDERECO_CLI;

  if (vCdEmpresa = 0) then begin
    raise Exception.Create('Empresa não informada!' + ' / ' + cDS_METHOD);
    exit;
  end;
  if (vNrTransacao = 0) then begin
    raise Exception.Create('Número transação não informado!' + ' / ' + cDS_METHOD);
    exit;
  end;
  if (vDtTransacao = 0) then begin
    raise Exception.Create('Data transação não informada!' + ' / ' + cDS_METHOD);
    exit;
  end;

  fTRA_TRANSACAO.Limpar();
  fTRA_TRANSACAO.CD_EMPRESA := vCdEmpresa;
  fTRA_TRANSACAO.NR_TRANSACAO := vNrTransacao;
  fTRA_TRANSACAO.DT_TRANSACAO := vDtTransacao;
  fTRA_TRANSACAO.Listar(nil);
  if (itemXmlF('status', voParams) < 0) then begin
    raise Exception.Create('Transação ' + FloatToStr(vNrTransacao) + ' não cadastrada!' + ' / ' + cDS_METHOD);
    exit;
  end;

  fTRA_REMDES.Limpar();
  fTRA_REMDES.Listar(nil);
  if (xStatus >= 0) then begin
    if (vInSobrepor) or (vDsNome <> '') then begin
      voParams := tTRA_REMDES.Excluir();
      if (itemXmlF('status', voParams) < 0) then begin
        raise Exception.Create(itemXml('message', voParams));
        exit;
      end;
    end else begin
      exit;
    end;
  end else begin
    fTRA_REMDES.Limpar();
  end;
  if ((fGER_OPERACAO.TP_DOCTO = 2) or (fGER_OPERACAO.TP_DOCTO = 3)) and (inCFPesJuridica) and (fPES_PESSOA.TP_PESSOA = 'J') then begin
    if (gCdClientePdv <> 0) then begin
      fPES_PESSOA.Limpar();
      fPES_PESSOA.CD_PESSOA := gCdClientePdv;
      fPES_PESSOA.Listar(nil);
    end;
  end;

  fTRA_REMDES.Append();
  if (vDsNome = '') then begin
    fV_PES_ENDERECO.Limpar();
    fV_PES_ENDERECO.CD_PESSOA := fPES_PESSOA.CD_PESSOA;
    fV_PES_ENDERECO.NR_SEQUENCIA := fTRA_TRANSACAO.NR_SEQENDERECO;
    fV_PES_ENDERECO.Listar(nil);
    if (itemXmlF('status', voParams) < 0) then begin
      if ((fGER_OPERACAO.TP_DOCTO = 2) or (fGER_OPERACAO.TP_DOCTO = 3)) and ((fGER_OPERACAO.TP_MODALIDADE = 4) or (fGER_OPERACAO.TP_MODALIDADE = 8) or (fGER_OPERACAO.TP_MODALIDADE = 3)) then begin
        if (gCdPessoaEndPadrao <> 0) then begin
          fV_PES_ENDERECO.Limpar();
          fV_PES_ENDERECO.CD_PESSOA := gCdPessoaEndPadrao;
          fV_PES_ENDERECO.NR_SEQUENCIA := fTRA_TRANSACAO.NR_SEQENDERECO;
          fV_PES_ENDERECO.Listar(nil);
          if (itemXmlF('status', voParams) < 0) then begin
            raise Exception.Create('endereço ' + fTRA_TRANSACAO.NR_SEQENDERECO + ' não cadastrado para a pessoa ' + FloatToStr(gCdPessoaEndPadrao) + '!' + ' / ' + cDS_METHOD);
            exit;
          end;
        end else begin
          raise Exception.Create('endereço ' + fTRA_TRANSACAO.NR_SEQENDERECO + ' não cadastrado para a pessoa ' + fPES_PESSOA.CD_PESSOA + '!' + ' / ' + cDS_METHOD);
          exit;
        end;
      end else begin
        raise Exception.Create('endereço ' + fTRA_TRANSACAO.NR_SEQENDERECO + ' não cadastrado para a pessoa ' + fPES_PESSOA.CD_PESSOA + '!' + ' / ' + cDS_METHOD);
        exit;
      end;

    end else begin

      if (fGER_OPERACAO.TP_DOCTO = 2) or (fGER_OPERACAO.TP_DOCTO = 3) and (fGER_OPERACAO.TP_MODALIDADE = 4) or (fGER_OPERACAO.TP_MODALIDADE = 8) or (fGER_OPERACAO.TP_MODALIDADE = 3) and (fGER_OPERACAO.TP_OPERACAO = 'E') and (vInAltEnderecoCli) then begin
        vUfOrigem := PARAM_GLB.UF_ORIGEM;
        if (vUfOrigem <> fV_PES_ENDERECO.DS_SIGLAESTADO) then begin
          if (gCdPessoaEndPadrao <> 0) then begin
            fV_PES_ENDERECO.Limpar();
            fV_PES_ENDERECO.CD_PESSOA := gCdPessoaEndPadrao;
            fV_PES_ENDERECO.NR_SEQUENCIA := fTRA_TRANSACAO.NR_SEQENDERECO;
            fV_PES_ENDERECO.Listar(nil);
            if (itemXmlF('status', voParams) < 0) then begin
              raise Exception.Create('endereço ' + fTRA_TRANSACAO.NR_SEQENDERECO + ' não cadastrado para a pessoa ' + FloatToStr(gCdPessoaEndPadrao) + '!' + ' / ' + cDS_METHOD);
              exit;
            end;
          end else begin
            raise Exception.Create('endereço ' + fTRA_TRANSACAO.NR_SEQENDERECO + ' não cadastrado para a pessoa ' + fPES_PESSOA.CD_PESSOA + '!' + ' / ' + cDS_METHOD);
            exit;
          end;
        end;
      end;
    end;

    vUfOrigem := PARAM_GLB.UF_ORIGEM;

    vInPjIsento := False;
    if (fPES_PESJURIDICA.NR_INSCESTL = 'ISENTO') or (fPES_PESJURIDICA.NR_INSCESTL = 'ISENTA')
    or (fPES_PESJURIDICA.NR_INSCESTL = 'ISENTOS') or (fPES_PESJURIDICA.NR_INSCESTL = 'ISENTAS') then begin
      vInPjIsento := True;
    end;
    if (fPES_CLIENTE.IN_CNSRFINAL) or (fPES_PESSOA.TP_PESSOA = 'F') or (vInPjIsento) then begin
      if (fPES_PESSOA.TP_PESSOA = 'F') and (fPES_CLIENTE.NR_CODIGOFISCAL <> '') and ((vUfOrigem = 'PR') or (vUfOrigem = 'SP')) then begin
        vInContribuinte := True;
      end else begin
        vInContribuinte := False;
      end;
    end else begin
      vInContribuinte := True;
    end;
    if not (inCFPesJuridica) then begin
      if (fGER_OPERACAO.TP_DOCTO = 2) or (fGER_OPERACAO.TP_DOCTO = 3) then begin
        if (vInContribuinte) and (fPES_CLIENTE.IN_CNSRFINAL <> True) then begin
          raise Exception.Create('Emissão de cupom fiscal para contribuinte não é permitido. Favor emitir Nota Fiscal!' + ' / ' + cDS_METHOD);
          exit;
        end;
      end;
    end;

    fTRA_REMDES.NM_NOME := fPES_PESSOA.NM_PESSOA;
    fTRA_REMDES.TP_PESSOA := fPES_PESSOA.TP_PESSOA;
    fTRA_REMDES.CD_PESSOA := fPES_PESSOA.CD_PESSOA;
    fTRA_REMDES.IN_CONTRIBUINTE := vInContribuinte;
    fTRA_REMDES.NR_LOGRADOURO := fV_PES_ENDERECO.NR_LOGRADOURO;
    fTRA_REMDES.NR_CAIXAPOSTAL := fV_PES_ENDERECO.NR_CAIXAPOSTAL;
    fTRA_REMDES.CD_CEP := fV_PES_ENDERECO.CD_CEP;
    fTRA_REMDES.DS_SIGLAESTADO := fV_PES_ENDERECO.DS_SIGLAESTADO;
    fTRA_REMDES.DS_TPLOGRADOURO := fV_PES_ENDERECO.DS_SIGLALOGRAD;
    if (fPES_PESSOA.TP_PESSOA = 'F') then begin
      if (fPES_CLIENTE.NR_CODIGOFISCAL = '') then begin
        fTRA_REMDES.NR_RGINSCREST := fPES_PESFISICA.NR_RG;
      end else begin
        fTRA_REMDES.NR_RGINSCREST := fPES_CLIENTE.NR_CODIGOFISCAL;
      end;
    end else begin
      fTRA_REMDES.NR_RGINSCREST := fPES_PESJURIDICA.NR_INSCESTL;
    end;
    fTRA_REMDES.NR_CPFCNPJ := fPES_PESSOA.NR_CPFCNPJ;
    fPES_TELEFONE.Limpar();
    fPES_TELEFONE.IN_PADRAO := True;
    fPES_TELEFONE.Listar(nil);
    if (xStatus >= 0) then begin
      fTRA_REMDES.NR_TELEFONE := fPES_TELEFONE.NR_TELEFONE;
    end else begin
      fPES_TELEFONE.Limpar();
      fPES_TELEFONE.Listar(nil);
      if (xStatus >= 0) then begin
        fTRA_REMDES.NR_TELEFONE := fPES_TELEFONE.NR_TELEFONE;
      end;
    end;
    fTRA_REMDES.NM_BAIRRO := fV_PES_ENDERECO.DS_BAIRRO;
    fTRA_REMDES.NM_LOGRADOURO := fV_PES_ENDERECO.NM_LOGRADOURO;
    fTRA_REMDES.NM_COMPLEMENTO := Copy(fV_PES_ENDERECO.DS_COMPLEMENTO,1,60);
    fTRA_REMDES.NM_MUNICIPIO := fV_PES_ENDERECO.NM_MUNICIPIO;
    if (fTRA_REMDES.CD_PESSOA = 0) then begin
      fTRA_REMDES.CD_PESSOA := fPES_PESSOA.CD_PESSOA;
    end;
  end else begin
    if (vTpPessoa = '') then begin
      raise Exception.Create('Tipo de pessoa não informado!' + ' / ' + cDS_METHOD);
      exit;
    end;
    delitem(pParams, 'CD_EMPRESA');
    delitem(pParams, 'NR_TRANSACAO');
    delitem(pParams, 'DT_TRANSACAO');
    fTRA_REMDES.SetValues(pParams);
  end;

  fTRA_REMDES.CD_EMPFAT := fTRA_TRANSACAO.CD_EMPFAT;
  fTRA_REMDES.CD_GRUPOEMPRESA := fTRA_TRANSACAO.CD_GRUPOEMPRESA;
  fTRA_REMDES.CD_OPERADOR := PARAM_GLB.CD_USUARIO;
  fTRA_REMDES.DT_CADASTRO := Now;

  voParams := tTRA_REMDES.Salvar();
  if (itemXmlF('status', voParams) < 0) then begin
    raise Exception.Create(itemXml('message', voParams));
    exit;
  end;

  exit;
end;

//------------------------------------------------------------------------
function T_TRASVCO004.gravaObservacaoTransacao(pParams : String) : String;
//------------------------------------------------------------------------
const
  cDS_METHOD = 'ADICIONAL=Operação: T_TRASVCO004.gravaObservacaoTransacao()';
var
  voParams, vDsObservacao, vCdComponente : String;
  vCdEmpresa, vNrTransacao, vNrLinha : Real;
  vInManutencao : Boolean;
  vDtTransacao : TDateTime;
begin
  vCdEmpresa := pParams.CD_EMPRESA;
  vNrTransacao := pParams.NR_TRANSACAO;
  vDtTransacao := pParams.DT_TRANSACAO;
  vInManutencao := pParams.IN_MANUTENCAO;
  vCdComponente := pParams.CD_COMPONENTE;
  vDsObservacao := pParams.DS_OBSERVACAO;

  if (vCdEmpresa = 0) then begin
    raise Exception.Create('Empresa não informada!' + ' / ' + cDS_METHOD);
    exit;
  end;
  if (vNrTransacao = 0) then begin
    raise Exception.Create('Número transação não informado!' + ' / ' + cDS_METHOD);
    exit;
  end;
  if (vDtTransacao = 0) then begin
    raise Exception.Create('Data transação não informada!' + ' / ' + cDS_METHOD);
    exit;
  end;
  if (vCdComponente = '') then begin
    raise Exception.Create('Nome do componente não informado!' + ' / ' + cDS_METHOD);
    exit;
  end;
  if (vDsObservacao = '') then begin
    raise Exception.Create('Observação não informada!' + ' / ' + cDS_METHOD);
    exit;
  end;

  fTRA_TRANSACAO.Limpar();
  fTRA_TRANSACAO.CD_EMPRESA := vCdEmpresa;
  fTRA_TRANSACAO.NR_TRANSACAO := vNrTransacao;
  fTRA_TRANSACAO.DT_TRANSACAO := vDtTransacao;
  fTRA_TRANSACAO.Listar(nil);
  if (itemXmlF('status', voParams) < 0) then begin
    raise Exception.Create('Transação ' + FloatToStr(vNrTransacao) + ' não cadastrada!' + ' / ' + cDS_METHOD);
    exit;
  end;

  if not (fOBS_TRANSACAO.IsEmpty()) then begin
    tOBS_TRANSACAO.IndexFieldNames := 'NR_LINHA';
    fOBS_TRANSACAO.Next();
    vNrLinha := fOBS_TRANSACAO.NR_LINHA;
  end;
  vNrLinha := vNrLinha + 1;

  fOBS_TRANSACAO.Limpar();
  fOBS_TRANSACAO.NR_LINHA := vNrLinha;
  fOBS_TRANSACAO.IN_MANUTENCAO := vInManutencao;
  fOBS_TRANSACAO.CD_COMPONENTE := vCdComponente;
  fOBS_TRANSACAO.DS_OBSERVACAO := Copy(vDsObservacao,1,80);
  fOBS_TRANSACAO.CD_OPERADOR := gModulo.GCDUSUARIO;
  fOBS_TRANSACAO.DT_CADASTRO := Now;
  voParams := tOBS_TRANSACAO.Salvar();
  if (itemXmlF('status', voParams) < 0) then begin
    raise Exception.Create(itemXml('message', voParams));
    exit;
  end;

  exit;
end;

initialization
  RegisterClass(T_TRASVCO004);

end.
