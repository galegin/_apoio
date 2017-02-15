unit uECF;

interface

uses
  Classes, Dialogs, SysUtils, Math, DateUtils, Types, StrUtils;

public int aberturaDoDia(string vModeloEcf, string ValorCompra, string FormaPagamento)
public int abreCupom(string vModeloEcf, string vCnpj)
public int abreCupomRecebimento(string vModeloEcf, string FormaPagamento, string Valor, string NumeroCupom)
public int abreCupomVinculado(string vModeloEcf, string FormaPagamento, string Valor, string NumeroCupom)
public int abrePorta(string vModeloEcf)
public int abreRelatorioGerencial(string vModeloEcf, string Indice)
public int acrescimoDescontoCupom(string vModeloEcf, string AcrescimoDesconto, string TipoAcrescimoDesconto, string ValorAcrescimoDesconto)
public int acrescimoDescontoItem(string vModeloEcf, string Item, string AcrescimoDesconto, string TipoAcrescimoDesconto, string ValorAcrescimoDesconto)
public int arquivoMFD(string vModeloEcf, string pParams)
public int autentica(string vModeloEcf)
public int cancelaCupom(string vModeloEcf)
public int cancelaCupomVinculado(string vModeloEcf, string vNrCupom)
public int cancelaImpressaoCheque(string vModeloEcf)
public int cancelaItem(string vModeloEcf, string Indice)
public int configuraCodBarras(string vModeloEcf, int vAltura, int vLargura, int vPosicaoCaracteres, int vFonte, int vMargem)
public int dataHoraGravacaoUsuarioSWBasicoMFAdicional(string vModeloEcf)
public int dataHoraImpressora(string vModeloEcf)
public int dataHoraReducao(string vModeloEcf)
public int dataHoraReducaoMFD(string vModeloEcf)
public int dataImpressora(string vModeloEcf)
public int downloadMFD(string vModeloEcf, string vArquivo, string vTipoDownload, string vCOOInicial, string vCOOFinal, string vUsuario)
public int efetuaFormaPagamento(string vModeloEcf, string FormaPagamento, string ValorFormaPagamento)
public int espelhoMFD(string vModeloEcf, string pParams)
public int fechaCupom(string vModeloEcf, string MensagemPromocional)
public int fechaPorta(string vModeloEcf)
public int fechaRelatorioGerencial(string vModeloEcf)
public int fechaVinculado(string vModeloEcf)
public int finalizaModoTEF(string vModeloEcf)
public int formatoDadosMFD(string vModeloEcf, string ArquivoOrigem, string ArquivoDestino, string TipoFormato, string TipoDownload, string ParametroInicial, string ParametroFinal, string UsuarioECF)
public int geraArquivoTipoE(string vModeloEcf, string vArqEntr, string vArqSai, string vTipoLeitura, string vTipoPeriodo, string vDataIni, string vDataFim, string vUsuario)
public int geraRegistroCAT52MFD(string vModeloEcf, string vArquivo, string vData)
public int geraRegistrosTipoE(string vModeloEcf, string vArqMFD, string vArqTXT, string vDataIni, string vDataFim, string vRazao, string vEndereco, string vCMD, string vTpDownload)
public int grandeTotal(string vModeloEcf)
public int imprimeCheque(string vModeloEcf, string Banco, string Valor, string Favorecido, string Cidade, string Data, string Mensagem)
public int imprimeCodBarras(string vModeloEcf, string cCodigo)
public int iniciaModoTEF(string vModeloEcf)
public int leituraChequeMFD(string vModeloEcf)
public string leituraIndicadores(string vModeloEcf)
public int leituraMemoriaFiscalPorDatas(string vModeloEcf, string DataIni, string DataFim)
public int leituraMemoriaFiscalPorReducoes(string vModeloEcf, string RedIni, string RedFim)
public int leituraMemoriaFiscalSerialPorDatas(string vModeloEcf, string DataIni, string DataFim, string Tipo)
public int leituraMemoriaFiscalSerialPorReducoe(string vModeloEcf, string RedIni, string RedFim, string Tipo)
public int leituraX(string vModeloEcf)
public int mapaResumo(string vModeloEcf)
public int modeloImpressoraECF(string vModeloEcf)
public string nomeArqRFD(string vModeloEcf, datetime DtMov)
public int numeroCupom(string vModeloEcf)
public int numeroIntervencoes(string vModeloEcf)
public int numeroReducoes(string vModeloEcf)
public int numeroSerie(string vModeloEcf)
public int numeroSerieMFD(string vModeloEcf)
public int progAliquota(string vModeloEcf, string Aliquota, int ICMS_ISS)
public int progFormaPagamento(string vModeloEcf, string vFormaPgto, string vPermiteTEF)
public int progHoraVerao(string vModeloEcf)
public int reducaoZ(string vModeloEcf)
public int relatorioTipo60Analitico(string vModeloEcf)
public int relatorioTipo60Mestre(string vModeloEcf)
public int retornaAliquotas(string vModeloEcf)
public int retornaContadores(string vModeloEcf)
public int retornoFormasPagamento(string vModeloEcf)
public string retornoImpressora(string vModeloEcf, int Retorno)
public int sangria(string vModeloEcf, string vValor)
public int suprimento(string vModeloEcf, string vValor)
public int usaRelatorioGerencial(string vModeloEcf, string vConteudo)
public int usaComprovanteNaoFiscalVinculado(string vModeloEcf, string Texto)
public int vendeItem(string vModeloEcf, string Item, string Codigo, string Descricao, string Aliquota, string TipoQuantidade, string Quantidade, string CasasDecimais, string ValorUnitario, string TipoDesconto, string Desconto, string Unidade)
public int vendeItemDepartamento(string vModeloEcf, string Codigo, string Descricao, string Aliquota, string ValorUnitario, string Quantidade, string Acrescimo, string Desconto, string IndiceDepartamento, string UnidadeMedida)
public int verificaDocVinculado(string vModeloEcf)
public int verificaEstadoGaveta(string vModeloEcf)
public int verificaEstadoImpressora(string vModeloEcf)
public int verificaFlagsFiscais(string vModeloEcf)
public string verificaReducaoZ(string vModeloEcf)
public int verificaStatusCheque(string vModeloEcf)
public int verificaTermica(string vModeloEcf)
public int verificaTotalizadoresNaoFiscais(string vModeloEcf)
  
{ 
  vDsPorta, vDsPath, vNrSerie, vNrCupom, vDataHora, vDataHoraReducao,
  vTotalizadoresNaoFiscais, vFormaPgto, vAliquotas, vDsCMC7, vStatusCheque,
  vDsResposta, vLstFlagFiscal, vStatusZ, vGrandeTotal, vModeloImpressoraECF,
  vDataUsuario, vDataSWBasico, vMFAdicional, vMensagem, vNrIntervencoes,
  string vNrNumeroReducoes;

  int vFlagFiscal, iRetorno, iEstadoGaveta, vRetorno, vCont;
  int Handle;

implementation

uses
  cIniFiles, cFuncaoECF, cStatus, cFuncao, cXml,
  UnitDeclaracoesBematech, // ecfBematech / ecfYanco
  UnitBemaMFD, // ecfBematech / ecfYanco
  UnitDeclaracoesDarumaFramework, // ecfDaruma
  UnitDeclaracoesElgin, // ecfElgin
  UnitDeclaracoesEpson, // ecfEpson
  UnitDeclaracoesInterway, // ecfInterway / ecfUrano
  UnitDeclaracoesSweda, // ecfSweda
  UnitDeclaracoesUrano, // ecfUrano
  cConst;

// função correspondente ao $item do Uniface,
//parâmetros :
//Linha : Linha inteira aonde contém a informação
//NomeValor : Nome do valor a ser retornado
//Finalizador : qual caracter que identifica aonde termina o resultado
public string fRetornaValor(string Linha, string NomeValor, string Finalizador)
{ 
  int vTamanhoValor, vPosicao, vContador, vTamanhoLinha;
  string vRetorno, vFinalizador, vCaracter, vFim;


  vRetorno = "";
  vPosicao = Linha.IndexOf(NomeValor);

  if ((Finalizador == ""))
    vTamanhoValor = NomeValor.Length() + 1
  else
    vTamanhoValor = NomeValor.Length() + 2;

  vContador = vPosicao + vTamanhoValor;
  vTamanhoLinha = Linha.Length();
  vFim = Finalizador;

  while (vContador <= vTamanhoLinha) {
    vCaracter = Linha.SubString( vContador, 1);

    if (vCaracter <> vFim)
      vRetorno = vRetorno + vCaracter
    else
      Break;

    vContador = vContador + 1;
  }

  return vRetorno;
}

public int abreCupom(string vModeloEcf, string vCnpj)
{ 
  string vResult;
  int vCodresult;

  try {
    if ((vModeloEcf == "ecfBematech") || (vModeloEcf == "ecfYanco")) {
      return Bematech_FI_AbreCupom(vCnpj);
    } else if ((vModeloEcf == "ecfElgin")) {
      return Elgin_AbreCupomMFD(vCnpj, "", "");
    } else if ((vModeloEcf == "ecfInterway") || (vModeloEcf == "ecfUrano")) {
      if (vCnpj.Trim() <> "") {
        return DLLG2_ExecutaComando(Handle, "AbreCupomFiscal; IdConsumidor=" + "\"" + vCnpj + "\"")
      } else {
        return DLLG2_ExecutaComando(Handle, "AbreCupomFiscal");
      }
    } else if ((vModeloEcf == "ecfDaruma")) {
      if ((vCnpj == "")) vCnpj = " ";
      return iCFAbrir_ECF_Daruma(vCnpj, " ", " ");
    } else if ((vModeloEcf == "ecfSweda")) {
      return ECF_AbreCupom(vCnpj);
    } else if ((vModeloEcf == "ecfEpson")) {
      return EPSON_Fiscal_Abrir_Cupom(vCnpj, "", "", "", 2);
    }
  } catch (Exception e) {
    _Logger.e('', E.Message);
  }
}

public int abreCupomMFD(string vModeloEcf, string vCpf, string vNome, string vEndereco)
{
  try {
    if ((vModeloEcf == "ecfBematech") || (vModeloEcf == "ecfYanco")) {
      vDsResposta = LeituraIndicadores(vModeloEcf);
      if (vDsResposta == "Impressora Vendendo")
      || (vDsResposta == "Impressora Pagamento") then {
        return Bematech_FI_CancelaCupomMFD(vCpf, vNome, vEndereco);
      }
      return Bematech_FI_AbreCupomMFD(vCpf, vNome, vEndereco);
    } else if ((vModeloEcf == "ecfElgin")) {
      return Elgin_AbreCupomMFD(vCpf, vNome, vEndereco);
    } else if ((vModeloEcf == "ecfInterway") || (vModeloEcf == "ecfUrano")) {
      if (vCpf.Trim() <> "")
        return DLLG2_ExecutaComando(Handle, "AbreCupomFiscal; IdConsumidor=" + "\"" + vCpf + "\"")
      else
        return DLLG2_ExecutaComando(Handle, "AbreCupomFiscal");
    } else if ((vModeloEcf == "ecfDaruma")) {
      if ((vCpf == "")) vCpf = " ";
      if ((vNome == "")) vNome = " ";
      if ((vEndereco == "")) vEndereco = " ";
      return iCFAbrir_ECF_Daruma(vCpf, vNome, vEndereco);
    } else if ((vModeloEcf == "ecfSweda")) {
      return ECF_AbreCupomMFD(vCpf, vNome, vEndereco);
    } else if ((vModeloEcf == "ecfEpson")) {
      return EPSON_Fiscal_Abrir_Cupom(vCpf, vNome, vEndereco, "", 2);
    }
  } catch (Exception e) {
    _Logger.e('', E.Message);
  }
}

public int cancelaCupom(string vModeloEcf)
{ 
  int i;
  string vResult, vDSCOO;

  try {
    if ((vModeloEcf == "ecfBematech") || (vModeloEcf == "ecfYanco")) {
      return Bematech_FI_CancelaCupom();
    } else if ((vModeloEcf == "ecfElgin")) {
      return Elgin_CancelaCupom();
    } else if ((vModeloEcf == "ecfInterway") || (vModeloEcf == "ecfUrano")) {
      return DLLG2_ExecutaComando(Handle, "CancelaCupom");
    } else if ((vModeloEcf == "ecfDaruma")) {
      return iCFCancelar_ECF_Daruma();
    } else if ((vModeloEcf == "ecfSweda")) {
      return ECF_CancelaCupom();
    } else if ((vModeloEcf == "ecfEpson")) {
      return EPSON_Fiscal_Cancelar_Cupom;
    }
  } catch (Exception e) {
    _Logger.e('', E.Message);
  }
}

public int cancelaCupomMFD(string vModeloEcf, string vCpf, string vNome, string vEndereco)
{
  try {
    if ((vModeloEcf == "ecfBematech") || (vModeloEcf == "ecfYanco")) {
      return Bematech_FI_CancelaCupomMFD(vCpf, vNome, vEndereco);
    } else if ((vModeloEcf == "ecfElgin")) {
      return Elgin_CancelaCupomMFD(vCpf, vNome, vEndereco);
    } else if ((vModeloEcf == "ecfInterway") || (vModeloEcf == "ecfUrano")) {
      return DLLG2_ExecutaComando(Handle, "CancelaCupom");
    } else if ((vModeloEcf == "ecfDaruma")) {
      return iCFCancelar_ECF_Daruma();
    } else if ((vModeloEcf == "ecfSweda")) {
      return ECF_CancelaCupomMFD(vCpf, vNome, vEndereco);
    } else if ((vModeloEcf == "ecfEpson")) {
      return EPSON_Fiscal_Cancelar_Cupom;
    }
  } catch (Exception e) {
    _Logger.e('', E.Message);
  }
}

public int cancelaCupomVinculado(string vModeloEcf, string vNrCupom)
{ 
  string vResult;

  try {
    if ((vModeloEcf == "ecfBematech") || (vModeloEcf == "ecfYanco")) {
      try {
         return Bematech_FI_EstornoNaoFiscalVinculadoMFD("", "", "");
      } catch (Exception e) {
      }
    } else if ((vModeloEcf == "ecfElgin")) {
      return Elgin_EstornoNaoFiscalVinculadoMFD("", "", "");
      return Elgin_FechaComprovanteNaoFiscalVinculado();
    } else if ((vModeloEcf == "ecfInterway") || (vModeloEcf == "ecfUrano")) {
      return DLLG2_ExecutaComando(Handle, "EstornaCreditoDebito;COO=" + vNrCupom);
    } else if ((vModeloEcf == "ecfDaruma")) {
      return iCCDEstornar_ECF_Daruma(vNrCupom, "", "", "");
    } else if ((vModeloEcf == "ecfSweda")) {
      return ECF_EstornoNaoFiscalVinculadoMFD("", "", "");
      return ECF_FechaComprovanteNaoFiscalVinculado;
    } else if ((vModeloEcf == "ecfEpson")) {
      return EPSON_NaoFiscal_Cancelar_CCD("", "", 0, "", vNrCupom);
    }
  } catch (Exception e) {
    _Logger.e('', E.Message);
  }
}


public int leituraX(string vModeloEcf)
{ 
  int vRetorno, I;
  string vMensagem;

  try {
    if ((vModeloEcf == "ecfBematech") || (vModeloEcf == "ecfYanco")) {
      vRetorno = Bematech_FI_LeituraX();
      if ((vRetorno == 0)) vRetorno = 1;
      return vRetorno;
    } else if ((vModeloEcf == "ecfElgin")) {
      return Elgin_LeituraX();
    } else if ((vModeloEcf == "ecfInterway") || (vModeloEcf == "ecfUrano")) {
      return DLLG2_ExecutaComando(Handle, "EmiteLeituraX");
    } else if ((vModeloEcf == "ecfDaruma")) {
      return iLeituraX_ECF_Daruma();
    } else if ((vModeloEcf == "ecfSweda")) {
      return ECF_LeituraX();
    } else if ((vModeloEcf == "ecfEpson")) {
      return EPSON_RelatorioFiscal_LeituraX;
    }
  } catch (Exception e) {
    _Logger.e('', E.Message);
  }
}

public int reducaoZ(string vModeloEcf)
{ 
  string szCRZ, vResult;
  int i;

  try {
    if ((vModeloEcf == "ecfBematech") || (vModeloEcf == "ecfYanco")) {
      return Bematech_FI_ReducaoZ("", "");
    } else if ((vModeloEcf == "ecfElgin")) {
      return Elgin_ReducaoZ("", "");
    } else if ((vModeloEcf == "ecfInterway") || (vModeloEcf == "ecfUrano")) {
      return DLLG2_ExecutaComando(Handle, "EmiteReducaoZ");
    } else if ((vModeloEcf == "ecfDaruma")) {
      return iReducaoZ_ECF_Daruma(" ", " ");
    } else if ((vModeloEcf == "ecfSweda")) {
      return ECF_ReducaoZ("", "");
    } else if ((vModeloEcf == "ecfEpson")) {
      szCRZ = _String.Replicate(" ", 20);
      return EPSON_RelatorioFiscal_RZ("", "", 9, szCRZ);
    }
  } catch (Exception e) {
    _Logger.e('', E.Message);
  }
}

public int vendeItem(string vModeloEcf, string Item, string Codigo, string Descricao, string Aliquota, string TipoQuantidade, string Quantidade, string CasasDecimais, string ValorUnitario, string TipoDesconto, string Desconto, string Unidade)
{ 
  double vVlDesconto, vVlUnitario, vVlAliquota;
  string vDsCodAliquota, vDsresult, vAliquotaTeste;
  int vCasasDecimaisQt, vCodresult;

  try {
    if ((vModeloEcf == "ecfBematech") || (vModeloEcf == "ecfYanco")) {
      Descricao = Descricao.SubString( 1, 29); //Bematech aceita apenas 29 caracteres
      if ((Double.Parse(Desconto, 0) >= 0)) {
        return Bematech_FI_VendeItem(Codigo, Descricao, Aliquota,
                  TipoQuantidade, Quantidade, Int16.Parse(CasasDecimais, 0), ValorUnitario,
                  TipoDesconto, Desconto);
      } else {
        return Bematech_FI_VendeItem(Codigo, Descricao, Aliquota,
                  TipoQuantidade, Quantidade, Int16.Parse(CasasDecimais, 0), ValorUnitario,
                  TipoDesconto, "0");
        return acrescimoDescontoItem(vModeloEcf, Item, "A", TipoDesconto, Desconto);
      }
    } else if ((vModeloEcf == "ecfElgin")) {
      if ((Double.Parse(Desconto) >= 0)) {
        return Elgin_VendeItem(Codigo, Descricao, Aliquota, TipoQuantidade, Quantidade, Int16.Parse(CasasDecimais, 0), ValorUnitario, TipoDesconto, Desconto);
      } else {
        return Elgin_VendeItem(Codigo, Descricao, Aliquota, TipoQuantidade, Quantidade, Int16.Parse(CasasDecimais, 0), ValorUnitario, TipoDesconto, "0");
        return acrescimoDescontoItem(vModeloEcf, Item, "A", TipoDesconto, Desconto);
      }
    } else if ((vModeloEcf == "ecfInterway")) {
      vVlUnitario = Double.Parse(ValorUnitario, 0);
      vVlUnitario = vVlUnitario / 100;
      ValorUnitario = vVlUnitario.ToString();

      vDsCodAliquota = "";
      if (Aliquota.Trim() == "NN")
        vDsCodAliquota = "-4"
      else if (Aliquota.Trim() == "II")
        vDsCodAliquota = "-3"
      else if (Aliquota.Trim() == "FF")
        vDsCodAliquota = "-2"
      else {
        vVlAliquota = Double.Parse(Aliquota, 0);
        if ((vVlAliquota > 0)) {
          vVlAliquota = vVlAliquota / 100;
          Aliquota = vVlAliquota.ToString();
        }
      }

      // se a aliquota for :  Não tributado (NN), Isento (II) ou Subst. Tributária (FF), deve ser movido o indice em vez de mover a aliquota
      if ((vDsCodAliquota <> ""))
        return DLLG2_ExecutaComando(Handle, "VendeItem;CodAliquota=" + vDsCodAliquota + ";CodProduto=" + "\"" + Codigo + "\"" + ";NomeProduto=" + "\"" + Descricao + "\"" + ";PrecoUnitario=" + ValorUnitario + ";Quantidade=" + Quantidade)
      else
        return DLLG2_ExecutaComando(Handle, "VendeItem;AliquotaICMS=true;CodProduto=" + "\"" + Codigo + "\"" + ";NomeProduto=" + "\"" + Descricao + "\"" + ";PercentualAliquota=" + Aliquota + ";PrecoUnitario=" + ValorUnitario + ";Quantidade=" + Quantidade);

      // o desconto por item na Interway é um comando a parte
      if (Desconto.Trim() <> "") {
        Desconto = Desconto.Replace( ".", ",");
        vVlDesconto = Double.Parse(Desconto, 0);
        if ((vVlDesconto > 0)) {
          vVlDesconto = vVlDesconto * - 1;
          DLLG2_ExecutaComando(Handle, "AcresceItemFiscal;Cancelar=false;ValorAcrescimo=" + vVlDesconto.ToString());
        }
      }
    } else if ((vModeloEcf == "ecfUrano")) {
      vVlUnitario = Double.Parse(ValorUnitario, 0);
      ValorUnitario = vVlUnitario.ToString();
      vDsCodAliquota = "";
      if (Aliquota.Trim() == "NN")
        vDsCodAliquota = "-4"
      else if (Aliquota.Trim() == "II")
        vDsCodAliquota = "-3"
      else if (Aliquota.Trim() == "FF")
        vDsCodAliquota = "-2"
      else {
        vVlAliquota = Double.Parse(Aliquota, 0);
        if ((vVlAliquota > 0)) {
          vVlAliquota = vVlAliquota / 100;
          Aliquota = vVlAliquota.ToString();
        }
      }

      // se a aliquota for :  Não tributado (NN), Isento (II) ou Subst. Tributária (FF), deve ser movido o indice em vez de mover a aliquota
      if ((vDsCodAliquota <> "")) {
        return DLLG2_ExecutaComando(Handle, "VendeItem;CodAliquota=" + vDsCodAliquota + " CodProduto=" + "\"" + Codigo + "\"" + " NomeProduto=" + "\"" + Descricao.SubString( 1, 30) + "\"" + " PrecoUnitario=" + ValorUnitario + " Quantidade=" + Quantidade + " Unidade=" + "\"" + unidade + "\";")
      } else {
        return DLLG2_ExecutaComando(Handle, "VendeItem;AliquotaICMS=true CodProduto=" + "\"" + Codigo + "\"" + " NomeProduto=" + "\"" + Descricao.SubString( 1, 30) + "\"" + " PercentualAliquota=" + Aliquota + " PrecoUnitario=" + ValorUnitario + " Quantidade=" + Quantidade + " Unidade=" + "\"" + unidade + "\";");
      }

      if (retornoImpressoraErro(vModeloEcf, result)) return;

      // o desconto por item na Interway é um comando a parte
      if (Desconto.Trim() <> "") {
        Desconto = Desconto.Replace( ".", ",");
        vVlDesconto = Double.Parse(Desconto, 0);
        if ((vVlDesconto > 0)) {
          vVlDesconto = vVlDesconto * - 1;
          return DLLG2_ExecutaComando(Handle, "AcresceItemFiscal;Cancelar=false ValorAcrescimo=" + vVlDesconto.ToString());
        }
      }
    } else if ((vModeloEcf == "ecfDaruma")) {
      return iCFVender_ECF_Daruma(Aliquota, Quantidade, ValorUnitario, "D" + TipoDesconto, Desconto, Codigo, Unidade, Descricao);
    } else if ((vModeloEcf == "ecfSweda")) {
      if ((Double.Parse(Desconto) >= 0)) {
        return ECF_VendeItem(Codigo, Descricao, Aliquota,
                  TipoQuantidade, Quantidade, Int16.Parse(CasasDecimais, 0), ValorUnitario,
                  TipoDesconto, Desconto);
      } else {
        return ECF_VendeItem(Codigo, Descricao, Aliquota,
                  TipoQuantidade, Quantidade, Int16.Parse(CasasDecimais, 0), ValorUnitario,
                  TipoDesconto, 0);
        Desconto = Double.Parse(desconto.ToString() * ( - 1));
        return acrescimoDescontoItem(vModeloEcf, Item, "A", TipoDesconto, Desconto);
      }
    } else if ((vModeloEcf == "ecfEpson")) {
      ValorUnitario = ValorUnitario.Replace( ",", "");
      Quantidade = _Formatar.formatFloat(", 0.000", Double.Parse(Quantidade, 0));
      Quantidade = Quantidade.Replace( ".", "");
      Quantidade = Quantidade.Replace( ",", "");
      Quantidade = Quantidade.Trim();
      vCasasDecimaisQt = 3;

      vAliquotaTeste = _ArquivoIni.pegar("ALIQUOTA_TESTE", "");
      if (vAliquotaTeste <> "") {
        aliquota = vAliquotaTeste; //liberar este campo quando em Debug com o Emulador
      }

      return EPSON_Fiscal_Vender_Item(Codigo, Descricao, Quantidade, vCasasDecimaisQt, Unidade, ValorUnitario, 2, Aliquota, 1);
      if (Desconto.Trim() <> "") {
        Desconto = Desconto.Replace( ".", "");
        Desconto = Desconto.Replace( ",", "");
        vVlDesconto = Double.Parse(Desconto, 0);
        if ((vVlDesconto > 0)) {
          return EPSON_Fiscal_Desconto_Acrescimo_Item(Desconto, 2, True, False);
        } else
        if ((vVlDesconto < 0)) {
          Desconto = vVlDesconto * ( - 1.ToString());
          return EPSON_Fiscal_Desconto_Acrescimo_Item(Desconto, 2, False, False);
        }

      }
    }
  } catch (Exception e) {
    _Logger.e('', E.Message);
  }
}

public int vendeItemDepartamento(string vModeloEcf, string Codigo, string Descricao, string Aliquota, string ValorUnitario, string Quantidade, string Acrescimo, string Desconto, string IndiceDepartamento, string UnidadeMedida)
{
  try {
    if ((vModeloEcf == "ecfBematech")) {
      return Bematech_FI_VendeItemDepartamento(Codigo, Descricao, Aliquota, ValorUnitario, Quantidade, Acrescimo,
                                                  Desconto, IndiceDepartamento, UnidadeMedida);
    } else if ((vModeloEcf == "ecfElgin")) {
      return Elgin_VendeItemDepartamento(Codigo, Descricao, Aliquota, ValorUnitario, Quantidade, Acrescimo,
                                            Desconto, IndiceDepartamento, UnidadeMedida);
    } else if ((vModeloEcf == "ecfInterway") || (vModeloEcf == "ecfUrano")) {

    } else if ((vModeloEcf == "ecfDaruma")) {

    } else if ((vModeloEcf == "ecfSweda")) {
      return ECF_VendeItemDepartamento(Codigo, Descricao, Aliquota, ValorUnitario, Quantidade, Acrescimo,
                                          Desconto, IndiceDepartamento, UnidadeMedida);
    }
  } catch (Exception e) {
    _Logger.e('', E.Message);
  }
}

public int acrescimoDescontoCupom(string vModeloEcf, string AcrescimoDesconto, string TipoAcrescimoDesconto, string ValorAcrescimoDesconto)
{ 
  string vResult, vTpFormatoAcrescDesc;
      double vVlDesconto;

  try {
    if ((vModeloEcf == "ecfBematech") || (vModeloEcf == "ecfYanco")) {
      return Bematech_FI_IniciaFechamentoCupom(AcrescimoDesconto, TipoAcrescimoDesconto, ValorAcrescimoDesconto);
    } else if ((vModeloEcf == "ecfElgin")) {
      if (ValorAcrescimoDesconto.Trim() == "") ValorAcrescimoDesconto = "0";
      // a ECF Elgin, dava erro caso envia-se o acrescimo ou desconto zerado
      if ((Double.Parse(ValorAcrescimoDesconto, 0) > 0))
        return Elgin_AcrescimoDescontoSubtotalMFD(AcrescimoDesconto, TipoAcrescimoDesconto, ValorAcrescimoDesconto)
    } else if ((vModeloEcf == "ecfInterway")) {
      if (ValorAcrescimoDesconto.Trim() == "") ValorAcrescimoDesconto = "0";
      // a ECF Interway, dava erro caso envia-se o acrescimo ou desconto zerado
      if ((Double.Parse(ValorAcrescimoDesconto, 0) > 0))
        return DLLG2_ExecutaComando(Handle, "AcresceSubtotal;Cancelar=false;ValorAcrescimo=" + ValorAcrescimoDesconto);
    } else if ((vModeloEcf == "ecfUrano")) {
      if (ValorAcrescimoDesconto.Trim() <> "") {
        ValorAcrescimoDesconto = ValorAcrescimoDesconto.Replace( ".", ",");
      }

      vVlDesconto = Double.Parse(ValorAcrescimoDesconto, 0);
      if (AcrescimoDesconto == "D") {
        if ((vVlDesconto > 0)) {
          vVlDesconto = vVlDesconto * - 1;
        }
      }

      if ((Double.Parse(ValorAcrescimoDesconto, 0) > 0)) {
        return DLLG2_ExecutaComando(Handle, "AcresceSubtotal;Cancelar=false ValorAcrescimo=" + vVlDesconto.ToString());
      }
    } else if ((vModeloEcf == "ecfDaruma")) {
      return iCFTotalizarCupom_ECF_Daruma(AcrescimoDesconto + TipoAcrescimoDesconto, ValorAcrescimoDesconto)
    } else if ((vModeloEcf == "ecfSweda")) {
      if (Double.Parse(ValorAcrescimoDesconto, 0) < 0) {
        ValorAcrescimoDesconto = Double.Parse(ValorAcrescimoDesconto, 0.ToString() * ( - 1));
        ValorAcrescimoDesconto = Double.Parse(ValorAcrescimoDesconto, 0.ToString() * 100);
      }
      return ECF_AcrescimoDescontoSubtotalMFD(AcrescimoDesconto, TipoAcrescimoDesconto, ValorAcrescimoDesconto);
    } else if ((vModeloEcf == "ecfEpson")) {
      if (ValorAcrescimoDesconto == "") {
        ValorAcrescimoDesconto = "0";
      }

      ValorAcrescimoDesconto = _Formatar.formatFloat("0.000", Double.Parse(ValorAcrescimoDesconto, 0));
      ValorAcrescimoDesconto = ValorAcrescimoDesconto.Replace( ",", "");
      ValorAcrescimoDesconto = ValorAcrescimoDesconto.Replace( ".", "");

      if ((ValorAcrescimoDesconto <> "") && ((Double.Parse(ValorAcrescimoDesconto) <> 0))) {
        if ((AcrescimoDesconto == "A")) // Acréscimo
          return EPSON_Fiscal_Desconto_Acrescimo_Subtotal(PAChar(ValorAcrescimoDesconto), 3, False, False)
        else
          return EPSON_Fiscal_Desconto_Acrescimo_Subtotal(pAChar(ValorAcrescimoDesconto), 3, True, False);
      }

    }
  } catch (Exception e) {
    _Logger.e('', E.Message);
  }
}

public int efetuaFormaPagamento(string vModeloEcf, string FormaPagamento, string ValorFormaPagamento)
{
  try {
    if ((vModeloEcf == "ecfBematech") || (vModeloEcf == "ecfYanco")) {
      return Bematech_FI_EfetuaFormaPagamento(FormaPagamento, ValorFormaPagamento);
    } else if ((vModeloEcf == "ecfElgin")) {
      return Elgin_EfetuaFormaPagamento(FormaPagamento, ValorFormaPagamento);
    } else if ((vModeloEcf == "ecfInterway") || (vModeloEcf == "ecfUrano")) {
      // a ECF Interway, não reconhece a String "Dinheiro" que é pré cadastrada
      // para a condição pré cadastrada, tem que enviar o indice
      if (FormaPagamento.Trim() == "Dinheiro")
        return DLLG2_ExecutaComando(Handle, "PagaCupom;CodMeioPagamento=-2 Valor=" + ValorFormaPagamento)
      else
        return DLLG2_ExecutaComando(Handle, "PagaCupom;NomeMeioPagamento=" + "\"" + FormaPagamento + "\"" + " Valor=" + ValorFormaPagamento);
    } else if ((vModeloEcf == "ecfDaruma")) {
      ValorFormaPagamento = _Formatar.formatFloat("0000000000.00", Double.Parse(ValorFormaPagamento, 0));
      return iCFEfetuarPagamentoFormatado_ECF_Daruma(FormaPagamento, ValorFormaPagamento);
    } else if ((vModeloEcf == "ecfSweda")) {
      return ECF_EfetuaFormaPagamento(FormaPagamento, ValorFormaPagamento);
    } else if ((vModeloEcf == "ecfEpson")) {
      ValorFormaPagamento = ValorFormaPagamento.Replace( ".", "");
      ValorFormaPagamento = ValorFormaPagamento.Replace( ",", "");
      return EPSON_Fiscal_Pagamento(FormaPagamento, ValorFormaPagamento, 2, "", "");
    }
  } catch (Exception e) {
    _Logger.e('', E.Message);
  }
}

public int fechaCupom(string vModeloEcf, string MensagemPromocional)
{ 
  string vLinha1, vLinha2, vLinha3, vLinha4, vLinha5, vLinha6, vLinha7, vLinha8;
  tstringlist vstLista;
  int i;
  string vResult;

  try {
    if ((vModeloEcf == "ecfBematech") || (vModeloEcf == "ecfYanco")) {
      return Bematech_FI_TerminaFechamentoCupom(MensagemPromocional);
    } else if ((vModeloEcf == "ecfElgin")) {
      return Elgin_TerminaFechamentoCupom(MensagemPromocional);
    } else if ((vModeloEcf == "ecfInterway") || (vModeloEcf == "ecfUrano")) {
      if (MensagemPromocional.Trim() == "") {
        return DLLG2_ExecutaComando(Handle, "EncerraDocumento")
      } else {
        return DLLG2_ExecutaComando(Handle, "EncerraDocumento;TextoPromocional=" + "\"" + MensagemPromocional + "\"");
      }
    } else if ((vModeloEcf == "ecfDaruma")) {
      return iCFEncerrar_ECF_Daruma("0", MensagemPromocional);
    } else if ((vModeloEcf == "ecfSweda")) {
      return ECF_TerminaFechamentoCupom(MensagemPromocional);
    } else if ((vModeloEcf == "ecfEpson")) {
      if (MensagemPromocional.Trim() <> "") {
        try {
          vstLista = TStringList.Create;
          vstLista.Text = MensagemPromocional;
          for (i = 0; i <= vstLista.Count - 1; i++) {
            case (i) of
              0: vLinha1 = vstLista[i];
              1: vLinha2 = vstLista[i];
              2: vLinha3 = vstLista[i];
              3: vLinha4 = vstLista[i];
              4: vLinha5 = vstLista[i];
              5: vLinha6 = vstLista[i];
              6: vLinha7 = vstLista[i];
              7: vLinha8 = vstLista[i];
            }
          }
        finally
          vstLista.Free;
        }

        return EPSON_Fiscal_Imprimir_Mensagem(vLinha1, vLinha2, vLinha3, vLinha4, vLinha5, vLinha6, vLinha7, vLinha8);
      }
      return EPSON_Fiscal_Fechar_Cupom(True, False);
    }
  } catch (Exception e) {
    _Logger.e('', E.Message);
  }
}

public int cancelaItem(string vModeloEcf, string Indice)
{
  try {
    if ((vModeloEcf == "ecfBematech") || (vModeloEcf == "ecfYanco")) {
      return Bematech_FI_CancelaItemGenerico(Indice);
    } else if ((vModeloEcf == "ecfElgin")) {
      return Elgin_CancelaItemGenerico(Indice);
    } else if ((vModeloEcf == "ecfInterway") || (vModeloEcf == "ecfUrano")) {
      return DLLG2_ExecutaComando(Handle, "CancelaItemFiscal");
    } else if ((vModeloEcf == "ecfDaruma")) {
      return iCFCancelarItem_ECF_Daruma(Indice);
    } else if ((vModeloEcf == "ecfSweda")) {
      return ECF_CancelaItemGenerico(Indice);
    } else if ((vModeloEcf == "ecfEpson")) {
      return EPSON_Fiscal_Cancelar_Item(Indice);
    }
  } catch (Exception e) {
    _Logger.e('', E.Message);
  }
}

public int leituraMemoriaFiscalPorDatas(string vModeloEcf, string DataIni, string DataFim)
{ 
  string vDados, vResult;
  int vTamanhoBuffer, i;

  try {
    if ((vModeloEcf == "ecfBematech") || (vModeloEcf == "ecfYanco")) {
      return Bematech_FI_LeituraMemoriaFiscalData(DataIni, DataFim);
    } else if ((vModeloEcf == "ecfElgin")) {
      return Elgin_LeituraMemoriaFiscalData(DataIni, DataFim, "s");
    } else if ((vModeloEcf == "ecfInterway")) {
      return DLLG2_ExecutaComando(Handle, "EmiteLeituraMF;DataFinal=#" + DataFim + "#;DataInicial=#" + DataIni + "#;Destino=\"I\";LeituraSimplificada=true");
    } else if ((vModeloEcf == "ecfUrano")) {
      return DLLG2_ExecutaComando(Handle, "EmiteLeituraMF;DataFinal=#" + DataFim + "# DataInicial=#" + DataIni + "# Destino=\"I\" LeituraSimplificada=false");
    } else if ((vModeloEcf == "ecfDaruma")) {
      return regAlterarValor_Daruma("ECF\LMFCOMPLETA", "1");
      return iMFLer_ECF_Daruma(DataIni, DataFim);
    } else if ((vModeloEcf == "ecfSweda")) {
      return ECF_LeituraMemoriaFiscalData(DataIni, DataFim);
    } else if ((vModeloEcf == "ecfEpson")) {
      _Array.setar(vDados, 10000);
      vTamanhoBuffer = 0;
      return EPSON_RelatorioFiscal_Leitura_MF(DataIni, DataFim, 5, vDados, "", @vTamanhoBuffer, 10000);
    }
  } catch (Exception e) {
    _Logger.e('', E.Message);
  }
}

public int leituraMemoriaFiscalPorDatasMFD(string vModeloEcf, string DataIni, string DataFim, string Tipo)
{ 
  string vDados, vDsResult;
  int vTamanhoBuffer, i;

  try {
    if ((vModeloEcf == "ecfBematech") || (vModeloEcf == "ecfYanco")) {
      return Bematech_FI_LeituraMemoriaFiscalDataMFD(DataIni, DataFim, Tipo);
    } else if ((vModeloEcf == "ecfElgin")) {
      return Elgin_LeituraMemoriaFiscalData(DataIni, DataFim, Tipo);
    } else if ((vModeloEcf == "ecfInterway")) {
      if ((Tipo.ToLowerCase() == "s"))
        return DLLG2_ExecutaComando(Handle, "EmiteLeituraMF;DataFinal=#" + DataFim + "#;DataInicial=#" + DataIni + "#;Destino=\"I\";LeituraSimplificada=true")
      else
        return DLLG2_ExecutaComando(Handle, "EmiteLeituraMF;DataFinal=#" + DataFim + "#;DataInicial=#" + DataIni + "#;Destino=\"I\";LeituraSimplificada=false")
    } else if ((vModeloEcf == "ecfUrano")) {
      if ((Tipo.ToLowerCase() == "s"))
        return DLLG2_ExecutaComando(Handle, "EmiteLeituraMF;DataFinal=#" + DataFim + "# DataInicial=#" + DataIni + "# Destino=\"I\" LeituraSimplificada=true")
      else
        return DLLG2_ExecutaComando(Handle, "EmiteLeituraMF;DataFinal=#" + DataFim + "# DataInicial=#" + DataIni + "# Destino=\"I\" LeituraSimplificada=false");
    } else if ((vModeloEcf == "ecfDaruma")) {
      if ((Tipo.ToLowerCase() == "s"))
        return regAlterarValor_Daruma("ECF\LMFCOMPLETA", "0")
      else
        return regAlterarValor_Daruma("ECF\LMFCOMPLETA", "1");
      return iMFLer_ECF_Daruma(DataIni, DataFim);
    } else if ((vModeloEcf == "ecfSweda")) {
      return ECF_LeituraMemoriaFiscalDataMFD(DataIni, DataFim, Tipo);
    } else if ((vModeloEcf == "ecfEpson")) {
      _Array.setar(vDados, 10000);
      vTamanhoBuffer = 0;
      DataIni = DataIni.Replace( "/", "");
      DataFim = DataFim.Replace( "/", "");
      return EPSON_RelatorioFiscal_Leitura_MF(DataIni, DataFim, 7, vDados, "", @vTamanhoBuffer, 10000);
    }
  } catch (Exception e) {
    _Logger.e('', E.Message);
  }
}

public int leituraMemoriaFiscalSerialPorDatasMFD(string vModeloEcf, string DataIni, string DataFim, string Tipo)
{ 
  textfile F;
  string vDados, vDsResult, vArquivo, vDsConteudo, vDsLinha;
  int vTamanhoBuffer, i;
  //vInVazio : Integer;

  try {
    if ((vModeloEcf == "ecfBematech") || (vModeloEcf == "ecfYanco")) {
      return Bematech_FI_LeituraMemoriaFiscalSerialDataMFD(DataIni, DataFim, Tipo);
    } else if ((vModeloEcf == "ecfElgin")) {
      return Elgin_LeituraMemoriaFiscalSerialData(DataIni, DataFim, Tipo);
    } else if ((vModeloEcf == "ecfInterway")) {
      if ((Tipo.ToLowerCase() == "s"))
        return DLLG2_ExecutaComando(Handle, "EmiteLeituraMF;DataFinal=#" + DataFim + "#;DataInicial=#" + DataIni + "#;Destino=\"S\";LeituraSimplificada=true")
      else
        return DLLG2_ExecutaComando(Handle, "EmiteLeituraMF;DataFinal=#" + DataFim + "#;DataInicial=#" + DataIni + "#;Destino=\"S\";LeituraSimplificada=false");

      // o comando LeImpressao, retorna no máximo 4000 bytes, portanto
      // deve fazer o laço enviando o comando até que seja retornado todas as respostas do comando : EmiteLeituraFitaDetalhe
      do {
        iRetorno = DLLG2_ExecutaComando(Handle, "LeImpressao");
        vDsLinha = DLLG2_ObtemRetornos(Handle, vDsLinha, 0);
        vDsLinha = fRetornaValor(vDsLinha, "TextoImpressao", "\"");
        vDsConteudo = vDsConteudo + vDsLinha;
      while !(vDsLinha == "");
      vArquivo = getPathECF() + "RETORNO.TXT";
      _Arquivo.gravar(vArquivo, vDsConteudo);
    } else if ((vModeloEcf == "ecfUrano")) {
      if ((Tipo.ToLowerCase() == "s"))
        return DLLG2_ExecutaComando(Handle, "EmiteLeituraMF;DataFinal=#" + DataFim + "# DataInicial=#" + DataIni + "# Destino=\"S\" LeituraSimplificada=true")
      else
        return DLLG2_ExecutaComando(Handle, "EmiteLeituraMF;DataFinal=#" + DataFim + "# DataInicial=#" + DataIni + "# Destino=\"S\" LeituraSimplificada=false");

      if (retornoImpressoraErro(vModeloEcf, result)) return;

      // o comando LeImpressao, retorna no máximo 4000 bytes, portanto
      // deve fazer o laço enviando o comando até que seja retornado todas as respostas do comando : EmiteLeituraFitaDetalhe
      do {
        iRetorno = DLLG2_ExecutaComando(Handle, "LeImpressao");
        vDsLinha = DLLG2_ObtemRetornos(Handle, vDsLinha, 0);
        vDsLinha = fRetornaValor(vDsLinha, "TextoImpressao", "\"");
        vDsConteudo = vDsConteudo + vDsLinha;
      while !(vDsLinha == "");
      vArquivo = getPathECF() + "RETORNO.TXT";
      _Arquivo.gravar(vArquivo, vDsConteudo);
    } else if ((vModeloEcf == "ecfDaruma")) {
      if ((Tipo.ToLowerCase() == "s"))
        regAlterarValor_Daruma("ECF\LMFCOMPLETA", "0")
      else
        regAlterarValor_Daruma("ECF\LMFCOMPLETA", "1");
      return iMFLerSerial_ECF_Daruma(DataIni, DataFim);
    } else if ((vModeloEcf == "ecfSweda")) {
      return ECF_LeituraMemoriaFiscalSerialDataMFD(DataIni, DataFim, Tipo);
    } else if ((vModeloEcf == "ecfEpson")) {
      _Array.setar(vDados, 10000);
      vTamanhoBuffer = 0;
      return EPSON_RelatorioFiscal_Leitura_MF(DataIni, DataFim, 7, vDados, "", @vTamanhoBuffer, 10000);
    }
  } catch (Exception e) {
    _Logger.e('', E.Message);
  }
}

public int leituraMemoriaFiscalPorReducoes(string vModeloEcf, string RedIni, string RedFim)
{ 
  string vDados, vDsResult;
  int vTamanhoBuffer, i;

  try {
    if ((vModeloEcf == "ecfBematech") || (vModeloEcf == "ecfYanco")) {
      return Bematech_FI_LeituraMemoriaFiscalReducao(RedIni, RedFim);
    } else if ((vModeloEcf == "ecfElgin")) {
      return Elgin_LeituraMemoriaFiscalReducao(RedIni, RedFim, "s"); // s = simplificada
    } else if (vModeloEcf == "ecfInterway")then {
      return DLLG2_ExecutaComando(Handle, "EmiteLeituraMF;Destino=\"I\";LeituraSimplificada=true;ReducaoFinal=" + RedFim + ";ReducaoInicial=" + RedIni);
    } else if(vModeloEcf == "ecfUrano") then {
      return DLLG2_ExecutaComando(Handle, "EmiteLeituraMF;Destino=\"I\" LeituraSimplificada=false ReducaoFinal=" + RedFim + " ReducaoInicial=" + RedIni);
    } else if ((vModeloEcf == "ecfDaruma")) {
      regAlterarValor_Daruma("ECF\LMFCompleta", "0"); // simplificada
      return iMFLer_ECF_Daruma(RedIni, RedFim);
    } else if ((vModeloEcf == "ecfSweda")) {
      return ECF_LeituraMemoriaFiscalReducao(RedIni, RedFim);
    } else if ((vModeloEcf == "ecfEpson")) {
      _Array.setar(vDados, 10000);
      vTamanhoBuffer = 0;
      return EPSON_RelatorioFiscal_Leitura_MF(RedIni, RedFim, 4, vDados, "", @vTamanhoBuffer, 10000);
    }
  } catch (Exception e) {
    _Logger.e('', E.Message);
  }
}

public int leituraMemoriaFiscalPorReducoesMFD(string vModeloEcf, string RedIni, string RedFim, string Tipo)
{ 
  string vDados, vDsResult;
  int vTamanhoBuffer, i;

  try {
    if ((vModeloEcf == "ecfBematech") || (vModeloEcf == "ecfYanco")) {
      return Bematech_FI_LeituraMemoriaFiscalReducaoMFD(RedIni, RedFim, Tipo);
    } else if ((vModeloEcf == "ecfElgin")) {

    } else if ((vModeloEcf == "ecfInterway")) {
      if ((Tipo.ToLowerCase() == "s"))
        return DLLG2_ExecutaComando(Handle, "EmiteLeituraMF;Destino=\"I\";LeituraSimplificada=true;ReducaoFinal=" + RedFim + ";ReducaoInicial=" + RedIni)
      else
        return DLLG2_ExecutaComando(Handle, "EmiteLeituraMF;Destino=\"I\";LeituraSimplificada=false;ReducaoFinal=" + RedFim + ";ReducaoInicial=" + RedIni);
    } else if ((vModeloEcf == "ecfUrano")) {
      if ((Tipo.ToLowerCase() == "s"))
        return DLLG2_ExecutaComando(Handle, "EmiteLeituraMF;Destino=\"I\" LeituraSimplificada=true ReducaoFinal=" + RedFim + " ReducaoInicial=" + RedIni)
      else
        return DLLG2_ExecutaComando(Handle, "EmiteLeituraMF;Destino=\"I\" LeituraSimplificada=false ReducaoFinal=" + RedFim + " ReducaoInicial=" + RedIni);
    } else if ((vModeloEcf == "ecfDaruma")) {
      if ((Tipo.ToLowerCase() == "s"))
        regAlterarValor_Daruma("ECF\LMFCOMPLETA", "0")
      else
        regAlterarValor_Daruma("ECF\LMFCOMPLETA", "1");
      return iMFLer_ECF_Daruma(RedIni, RedFim);
    } else if ((vModeloEcf == "ecfSweda")) {
      return ECF_LeituraMemoriaFiscalReducaoMFD(RedIni, RedFim, Tipo);
    } else if ((vModeloEcf == "ecfEpson")) {
      _Array.setar(vDados, 10000);
      vTamanhoBuffer = 0;
      if ((Tipo.ToLowerCase() == "s"))
        return EPSON_RelatorioFiscal_Leitura_MF(RedIni, RedFim, 6, vDados, "", @vTamanhoBuffer, 10000)
      else
        return EPSON_RelatorioFiscal_Leitura_MF(RedIni, RedFim, 4, vDados, "", @vTamanhoBuffer, 10000);
    }
  } catch (Exception e) {
    _Logger.e('', E.Message);
  }
}

public int leituraMemoriaFiscalSerialPorReducoesMFD(string vModeloEcf, string RedIni, string RedFim, string Tipo)
{ 
  textfile F;
  string vDados, vDsResult, vArquivo, vDsConteudo, vDsLinha;
  int vTamanhoBuffer, i;

  try {
    if ((vModeloEcf == "ecfBematech") || (vModeloEcf == "ecfYanco")) {
      return Bematech_FI_LeituraMemoriaFiscalSerialReducaoMFD(RedIni, RedFim, Tipo);
    } else if ((vModeloEcf == "ecfElgin")) {

    } else if ((vModeloEcf == "ecfInterway")) {
      if ((Tipo.ToLowerCase() == "s"))
        return DLLG2_ExecutaComando(Handle, "EmiteLeituraMF;Destino=\"S\";LeituraSimplificada=true;ReducaoFinal=" + RedFim + ";ReducaoInicial=" + RedIni)
      else
        return DLLG2_ExecutaComando(Handle, "EmiteLeituraMF;Destino=\"S\";LeituraSimplificada=false;ReducaoFinal=" + RedFim + ";ReducaoInicial=" + RedIni);

      if (retornoImpressoraErro(vModeloEcf, result)) return;

      // o comando LeImpressao, retorna no máximo 4000 bytes, portanto
      // deve fazer o laço enviando o comando até que seja retornado todas as respostas do comando : EmiteLeituraFitaDetalhe
      do {
        iRetorno = DLLG2_ExecutaComando(Handle, "LeImpressao");
        vDsLinha = DLLG2_ObtemRetornos(Handle, vDsLinha, 0);
        vDsLinha = fRetornaValor(vDsLinha, "TextoImpressao", "\"");
        vDsConteudo = vDsConteudo + vDsLinha;
      while !(vDsLinha == "");
      vArquivo = getPathECF() + "RETORNO.TXT";
      _ArquivoIni.setar(vArquivo, vDsConteudo);
    } else if ((vModeloEcf == "ecfUrano")) {
      if ((Tipo.ToLowerCase() == "s"))
        return DLLG2_ExecutaComando(Handle, "EmiteLeituraMF;Destino=\"S\" LeituraSimplificada=true ReducaoFinal=" + RedFim + " ReducaoInicial=" + RedIni)
      else
        return DLLG2_ExecutaComando(Handle, "EmiteLeituraMF;Destino=\"S\" LeituraSimplificada=false ReducaoFinal=" + RedFim + " ReducaoInicial=" + RedIni);

      if (retornoImpressoraErro(vModeloEcf, result)) return;

      // o comando LeImpressao, retorna no máximo 4000 bytes, portanto
      // deve fazer o laço enviando o comando até que seja retornado todas as respostas do comando : EmiteLeituraFitaDetalhe
      do {
        iRetorno = DLLG2_ExecutaComando(Handle, "LeImpressao");
        vDsLinha = DLLG2_ObtemRetornos(Handle, vDsLinha, 0);
        vDsLinha = fRetornaValor(vDsLinha, "TextoImpressao", "\"");
        vDsConteudo = vDsConteudo + vDsLinha;
      while !(vDsLinha == "");
      vArquivo = getPathECF() + "RETORNO.TXT";
      _ArquivoIni.setar(vArquivo, vDsConteudo);
    } else if ((vModeloEcf == "ecfDaruma")) {
      if ((Tipo.ToLowerCase() == "s"))
        regAlterarValor_Daruma("ECF\MFDCompleta", "0")
      else
        regAlterarValor_Daruma("ECF\MFDCompleta", "1");

      return iMFLerSerial_ECF_Daruma(RedIni, RedFim);
    } else if ((vModeloEcf == "ecfSweda")) {
      return ECF_LeituraMemoriaFiscalSerialReducaoMFD(RedIni, RedFim, Tipo);
    } else if ((vModeloEcf == "ecfEpson")) {
      _Array.setar(vDados, 10000);
      vTamanhoBuffer = 0;
      if ((Tipo.ToLowerCase() == "s"))
        return EPSON_RelatorioFiscal_Leitura_MF(RedIni, RedFim, 6, vDados, "", @vTamanhoBuffer, 10000)
      else
        return EPSON_RelatorioFiscal_Leitura_MF(RedIni, RedFim, 4, vDados, "", @vTamanhoBuffer, 10000);
    }
  } catch (Exception e) {
    _Logger.e('', E.Message);
  }
}

public int relatorioTipo60Mestre(string vModeloEcf)
{ 
  string vDsArquivo, vDsData, vDsNumeroSerie, vDsLoja;
  string vDsNrUltimaReduz, vDsCOOInicio, vDsCOOReducao, vDsReinicioOperacao;
  string vDsVlVendaBruta, vDsVlGT, vDadosRZ, vDtUltMovimento, vPathECF, vLastRZData, vDsDadosImpressora;
  string vVBatual, vVBanterior;
  double vValor;
  textfile F;
  tstringlist vDsArq;
  string vLinha;
  int iConta;

  try {
    if ((vModeloEcf == "ecfBematech") || (vModeloEcf == "ecfYanco")) {
      return Bematech_FI_RelatorioTipo60Mestre();
    } else if ((vModeloEcf == "ecfElgin")) {
      return Elgin_RelatorioTipo60Mestre();
    } else if ((vModeloEcf == "ecfInterway") || (vModeloEcf == "ecfUrano")) {
      try {
        // pego a data da ECF
        DLLG2_ExecutaComando(Handle, "LeData;NomeData=\"Data\"");
        vDsData = DLLG2_ObtemRetornos(Handle, vDsData, 0);
        vDsData = fRetornaValor(vDsData, "ValorData", "#");
        vDsData = _DataHora.formatar("DD/MM/YYYY", StrToDate(vDsData));

        // pego o número de série da ECF
        DLLG2_ExecutaComando(Handle, "LeTexto;NomeTexto=\"NumeroSerieECF\"");
        vNrSerie = DLLG2_ObtemRetornos(Handle, vDsNumeroSerie, 0 );
        vNrSerie = fRetornaValor(vNrSerie, "ValorTexto", "\"");

        // pego o número da loja
        DLLG2_ExecutaComando(Handle, "LeInteiro;NomeInteiro=\"Loja\"");
        vDsLoja = DLLG2_ObtemRetornos(Handle, vDsLoja, 0);
        vDsLoja = fRetornaValor(vDsLoja, "ValorInteiro", "");
        if (vDsLoja.Trim() == "") vDsLoja = "0";

        // pego o número do primeiro COO do dia
        DLLG2_ExecutaComando(Handle, "LeInteiro;NomeInteiro=\"COOInicioDia\"");
        vDsCOOInicio = DLLG2_ObtemRetornos(Handle, vDsCOOInicio, 0);
        vDsCOOInicio = fRetornaValor(vDsCOOInicio, "ValorInteiro", "");
        if (vDsCOOInicio.Trim() == "") vDsCOOInicio = "0";

        // pego o número do contador de redução
        DLLG2_ExecutaComando(Handle, "LeInteiro;NomeInteiro=\"CRZ\"");
        vDsNrUltimaReduz = DLLG2_ObtemRetornos(Handle, vDsNrUltimaReduz, 0);
        vDsNrUltimaReduz = fRetornaValor(vDsNrUltimaReduz, "ValorInteiro", "");
        if (vDsNrUltimaReduz.Trim() == "") vDsNrUltimaReduz = "0";

        // pego o COO da ultima redução
        DLLG2_ExecutaComando(Handle, "LeInteiro;NomeInteiro=\"COOReducao[" + vDsNrUltimaReduz + "]\"");
        vDsCOOReducao = DLLG2_ObtemRetornos(Handle, vDsCOOReducao, 0);
        vDsCOOReducao = fRetornaValor(vDsCOOReducao, "ValorInteiro", "");
        if (vDsCOOReducao.Trim() == "") vDsCOOReducao = "0";

        // pego o contador de reinicio de Operação
        DLLG2_ExecutaComando(Handle, "LeInteiro;NomeInteiro=\"ContadorReinicioReducao[" + vDsNrUltimaReduz + "]\"");
        vDsReinicioOperacao = DLLG2_ObtemRetornos(Handle, vDsReinicioOperacao, 0);
        vDsReinicioOperacao = fRetornaValor(vDsReinicioOperacao, "ValorInteiro", "");
        if (vDsReinicioOperacao.Trim() == "") vDsReinicioOperacao = "0";

        // pego o valor da venda bruta da ultima redução
        DLLG2_ExecutaComando(Handle, "LeMoeda;NomeDadoMonetario=\"VendaBrutaReducao[" + vDsNrUltimaReduz + "]\"");
        vDsVlVendaBruta = DLLG2_ObtemRetornos(Handle, vDsVlVendaBruta, 0);
        vDsVlVendaBruta = fRetornaValor(vDsVlVendaBruta, "ValorMoeda", "");
        vDsVlVendaBruta = vDsVlVendaBruta.Replace( ".", "");
        if (vDsVlVendaBruta.Trim() == "") vDsVlVendaBruta = "0";

        // pego o valor do GT (grande total ou totalizador geral).
        DLLG2_ExecutaComando(Handle, "LeMoeda;NomeDadoMonetario=\"GT\"");
        vDsVlGT = DLLG2_ObtemRetornos(Handle, vDsVlGT, 0);
        vDsVlGT = fRetornaValor(vDsVlGT, "ValorMoeda", "");
        vDsVlGT = vDsVlGT.Replace( ".", "");
        if (vDsVlGT.Trim() == "") vDsVlGT = "0";

        vDsArquivo = "";
        vDsArquivo = "Tipo do relatório.........:" + _Formatar.format("%25s", ["60"]) + sLineBreak;
        vDsArquivo = vDsArquivo + "Subtipo...................:" + _Formatar.format("%25s", ["M"]) + sLineBreak;
        vDsArquivo = vDsArquivo + "Data de emissão...........:" + _Formatar.format("%25s", [vDsData]) + sLineBreak;
        vDsArquivo = vDsArquivo + "Número de série...........:" + _Formatar.format("%25s", [vNrSerie]) + sLineBreak;
        vDsArquivo = vDsArquivo + "Número do equipamento.....:" + _Formatar.format("%25s", [vDsLoja]) + sLineBreak;
        vDsArquivo = vDsArquivo + "Modelo do documento fiscal:" + _Formatar.format("%25s", ["2D"]) + sLineBreak;
        // COO Inicial e Final não será enviado, pois ficara o que é armazenado a cada venda no sistema
        //vDsArquivo := vDsArquivo + 'COO inicial...............:' + Format('%25s', [vDsCOOInicio]) + sLineBreak;
        //vDsArquivo := vDsArquivo + 'COO final.................:' + Format('%25s', [vDsCOOReducao]) + sLineBreak;
        vDsArquivo = vDsArquivo + "COO inicial...............:" + _Formatar.format("%25s", ["0"]) + sLineBreak;
        vDsArquivo = vDsArquivo + "COO final.................:" + _Formatar.format("%25s", ["0"]) + sLineBreak;
        vDsArquivo = vDsArquivo + "Contador de reduções......:" + _Formatar.format("%25s", [vDsNrUltimaReduz]) + sLineBreak;
        vDsArquivo = vDsArquivo + "Reinicio de operações.....:" + _Formatar.format("%25s", [vDsReinicioOperacao]) + sLineBreak;
        vDsArquivo = vDsArquivo + "Venda Bruta...............:" + _Formatar.format("%25s", [_Formatar.formatFloat(", 0.00", Double.Parse(vDsVlVendaBruta, 0))]) + sLineBreak;
        vDsArquivo = vDsArquivo + "Totalizador geral.........:" + _Formatar.format("%25s", [_Formatar.formatFloat(", 0.00", Double.Parse(vDsVlGT, 0))]);
        vDsPath = getPathECF();
        AssignFile(F, vDsPath + "\RETORNO.TXT");
        Rewrite(F);
        Write(F, vDsArquivo);
        CloseFile(F);
      } catch (Exception e) {
      }
    } else if ((vModeloEcf == "ecfDaruma")) {
      vDadosRZ = "";
      _Array.setar(vDadosRZ, 1210);

      //result := regAlterarValor_Daruma('ECF\Atocotepe\LocalArquivos', getPathECF());
      return regAlterarValor_Daruma("START\LocalArquivosRelatorios", getPathECF().SubString( 3, getPathECF(.Length()))); //'\Projeto_touch\VirtualLoja\path_ecf\'

      return rRetornarDadosReducaoZ_ECF_Daruma(vDadosRZ);
      vDtUltMovimento = vDadosRZ.SubString( 1, 8);

      return rGerarSINTEGRA_ECF_Daruma("DATAM", vDtUltMovimento, vDtUltMovimento);

      if ((_Arquivo.exists(getPathECF + "Sintegra.txt"))) {
        vPathECF = getPathECF;
      } else if ((_Arquivo.exists("C:\Sintegra.txt"))) {
        vPathECF = "C:\";
      }

      if ((_Arquivo.exists(vPathECF + "Sintegra.txt"))) {
        vDsArq.Free;
        vDsArq = TStringList.Create;
        vDsArq.LoadFromFile(vPathECF + "Sintegra.txt");
        iConta = 1;
        while (iConta < vDsArq.Count) {
          vLinha = vDsArq.Strings[iConta];
          if(vLinha.SubString( 1, 3) == "60M") then {
            //atribuindo valores as variaveis de registro
            vDsData = vLinha.SubString( 4, 8);
            vDsNumeroSerie = vLinha.SubString( 12, 20);
            vDsLoja = vLinha.SubString( 32, 3);
            vDsCOOInicio = vLinha.SubString( 37, 6);
            vDsCOOReducao = vLinha.SubString( 43, 6);
            vDsNrUltimaReduz = vLinha.SubString( 49, 6);
            vDsReinicioOperacao = vLinha.SubString( 55, 3);
            vDsVlVendaBruta = vLinha.SubString( 58, 16);
            vDsVlGT = vLinha.SubString( 74, 16);
            vDsData = vDsData.SubString( 7, 2) + "/" + vDsData.SubString( 5, 2) + "/" + vDsData.SubString( 3, 2);

            vDsArquivo = "";
            vDsArquivo = "Tipo do relatório.........:" + _Formatar.format("%25s", ["60"]) + sLineBreak;
            vDsArquivo = vDsArquivo + "Subtipo...................:" + _Formatar.format("%25s", ["M"]) + sLineBreak;
            vDsArquivo = vDsArquivo + "Data de emissão...........:" + _Formatar.format("%25s", [vDsData]) + sLineBreak;
            vDsArquivo = vDsArquivo + "Número de série...........:" + _Formatar.format("%25s", [vDsNumeroSerie]) + sLineBreak;
            vDsArquivo = vDsArquivo + "Número do equipamento.....:" + _Formatar.format("%25s", [vDsLoja]) + sLineBreak;
            vDsArquivo = vDsArquivo + "Modelo do documento fiscal:" + _Formatar.format("%25s", ["2D"]) + sLineBreak;
            vDsArquivo = vDsArquivo + "COO inicial...............:" + _Formatar.format("%25s", [vDsCOOInicio]) + sLineBreak;
            vDsArquivo = vDsArquivo + "COO final.................:" + _Formatar.format("%25s", [vDsCOOReducao]) + sLineBreak;
            vDsArquivo = vDsArquivo + "Contador de reduções......:" + _Formatar.format("%25s", [vDsNrUltimaReduz]) + sLineBreak;
            vDsArquivo = vDsArquivo + "Reinicio de operações.....:" + _Formatar.format("%25s", [vDsReinicioOperacao]) + sLineBreak;

            vValor = Double.Parse(vDsVlVendaBruta, 0);
            vValor = vValor / 100;
            vDsArquivo = vDsArquivo + "Venda Bruta...............:" + _Formatar.format("%25s", [_Formatar.formatFloat(", 0.00", vValor)]) + sLineBreak;
            vValor = Double.Parse(vDsVlGT, 0);
            vValor = vValor / 100;
            vDsArquivo = vDsArquivo + "Totalizador geral.........:" + _Formatar.format("%25s", [_Formatar.formatFloat(", 0.00", vValor)]);

          }
          inc(iConta);
        }

        AssignFile(F, getPathECF() + "RETORNO.TXT");
        Rewrite(F);
        Write(F, vDsArquivo);
        CloseFile(F);
      }
    } else if ((vModeloEcf == "ecfSweda")) {
      return ECF_RelatorioTipo60Mestre();
    } else if ((vModeloEcf == "ecfEpson")) {
      vLastRZData = _String.Replicate(" ", 1170);
      return EPSON_Obter_Dados_Ultima_RZ(vLastRZData);

      vDsDadosImpressora = _String.Replicate(" ", 110);
      EPSON_Obter_Dados_Impressora(vDsDadosImpressora);
      vNrSerie = vDsDadosImpressora.SubString( 1, 20);

      vDsDadosImpressora = _String.Replicate(" ", 10);
      EPSON_Obter_Numero_ECF_Loja(vDsDadosImpressora);
      vDsLoja = vDsDadosImpressora.SubString( 1, 3);

      vVBatual = _String.Replicate(" ", 15);

      vVBanterior = _String.Replicate(" ", 15);

      EPSON_Obter_Venda_Bruta(vVBatual, vVBanterior);

      vDsData = vLastRZData.SubString( 1160, 8);
      if ((vDsData == "????????")) {
        vDsData = vLastRZData.SubString( 1, 8);
      }
      vDsData = vDsData.SubString( 1, 2) + "/" + vDsData.SubString( 3, 2) + "/" + vDsData.SubString( 7, 2);

      vDsNumeroSerie = vNrSerie;
      vDsCOOInicio = vLastRZData.SubString( 15, 6);
      vDsCOOReducao = vLastRZData.SubString( 21, 6);
      vDsNrUltimaReduz = vLastRZData.SubString( 27, 6);
      vDsReinicioOperacao = vLastRZData.SubString( 33, 6);
      vDsVlVendaBruta = vVBanterior;
      vDsVlGT = vLastRZData.SubString( 87, 18);

      vDsArquivo = "";
      vDsArquivo = "Tipo do relatório.........:" + _Formatar.format("%25s", ["60"]) + sLineBreak;
      vDsArquivo = vDsArquivo + "Subtipo...................:" + _Formatar.format("%25s", ["M"]) + sLineBreak;
      vDsArquivo = vDsArquivo + "Data de emissão...........:" + _Formatar.format("%25s", [vDsData]) + sLineBreak;
      vDsArquivo = vDsArquivo + "Número de série...........:" + _Formatar.format("%25s", [vDsNumeroSerie]) + sLineBreak;
      vDsArquivo = vDsArquivo + "Número do equipamento.....:" + _Formatar.format("%25s", [vDsLoja]) + sLineBreak;
      vDsArquivo = vDsArquivo + "Modelo do documento fiscal : " + _Formatar.format("%25s", ["2D"]) + sLineBreak;
      vDsArquivo = vDsArquivo + "COO inicial...............:" + _Formatar.format("%25s", [vDsCOOInicio]) + sLineBreak;
      vDsArquivo = vDsArquivo + "COO final.................:" + _Formatar.format("%25s", [vDsCOOReducao]) + sLineBreak;
      //vDsArquivo := vDsArquivo + 'COO inicial...............:' + Format('%25s', ['0']) + sLineBreak; 
      //vDsArquivo := vDsArquivo + 'COO final.................:' + Format('%25s', ['0']) + sLineBreak; 
      vDsArquivo = vDsArquivo + "Contador de reduções......:" + _Formatar.format("%25s", [vDsNrUltimaReduz]) + sLineBreak;
      vDsArquivo = vDsArquivo + "Reinicio de operações.....:" + _Formatar.format("%25s", [vDsReinicioOperacao]) + sLineBreak;
      vValor = Double.Parse(vDsVlVendaBruta, 0);
      vValor = vValor / 100;
      vDsArquivo = vDsArquivo + "Venda Bruta...............:" + _Formatar.format("%25s", [_Formatar.formatFloat(", 0.00", vValor)]) + sLineBreak;
      vValor = Double.Parse(vDsVlGT, 0);
      vValor = vValor / 100;
      vDsArquivo = vDsArquivo + "Totalizador geral.........:" + _Formatar.format("%25s", [_Formatar.formatFloat(", 0.00", vValor)]);

      AssignFile(F, "C:\ECF\RETORNO.TXT");
      Rewrite(F);
      Write(F, vDsArquivo);
      CloseFile(F);
    }
  } catch (Exception e) {
    _Logger.e('', E.Message);
  }
}

public int relatorioTipo60Analitico(string vModeloEcf)
{ 
  string vDsArquivo, vDsData, vDsNumeroSerie, vDsNrUltimaReduz;
  string vDsVlCancelamentos, vDsVlDescontos;
  string vDsVlF, vDsVlI, vDsVlN, vDsPercAliquota00, vDsVlAliquota00, vDsPercAliquota01, vDsVlAliquota01;
  string vDsPercAliquota02, vDsVlAliquota02, vDsPercAliquota03, vDsVlAliquota03, vDsPercAliquota04, vDsVlAliquota04;
  string vDsPercAliquota05, vDsVlAliquota05, vDsPercAliquota06, vDsVlAliquota06, vDsPercAliquota07, vDsVlAliquota07;
  string vDsPercAliquota08, vDsVlAliquota08, vDsPercAliquota09, vDsVlAliquota09, vDsPercAliquota10, vDsVlAliquota10;
  string vDsPercAliquota11, vDsVlAliquota11, vDsPercAliquota12, vDsVlAliquota12, vDsPercAliquota13, vDsVlAliquota13;
  string vDsPercAliquota14, vDsVlAliquota14, vDsPercAliquota15, vDsVlAliquota15;
  string vDsTipoAliquota, vDsIndiceAliquota, vDsPercAliquota, vDsVlAliquota, vDadosRZ, vDtUltMovimento, vLinha, vPathECF;
  string vLastRZData, vDsDadosImpressora;
  int i, vCont, vPosTributo, vPosVlTributo;
  double vValor;
  textfile F, vArqSintegra;

  try {
    if ((vModeloEcf == "ecfBematech") || (vModeloEcf == "ecfYanco")) {
      return Bematech_FI_RelatorioTipo60Analitico();
    } else if ((vModeloEcf == "ecfElgin")) {
      return Elgin_RelatorioTipo60Analitico;
    } else if ((vModeloEcf == "ecfInterway") || (vModeloEcf == "ecfUrano")) {
      try {
        // pego a data da ECF
        DLLG2_ExecutaComando(Handle, "LeData;NomeData=\"Data\"");
        vDsData = DLLG2_ObtemRetornos(Handle, vDsData, 0);
        vDsData = fRetornaValor(vDsData, "ValorData", "#");
        vDsData = _DataHora.formatar("DD/MM/YY", StrToDate(vDsData));

        // pego o número de série da ECF
        DLLG2_ExecutaComando(Handle, "LeTexto;NomeTexto=\"NumeroSerieECF\"");
        vDsNumeroSerie = DLLG2_ObtemRetornos(Handle, vDsNumeroSerie, 0);
        vDsNumeroSerie = fRetornaValor(vDsNumeroSerie, "ValorTexto", "\"");

        // pego o número do contador de redução
        DLLG2_ExecutaComando(Handle, "LeInteiro;NomeInteiro=\"CRZ\"");
        vDsNrUltimaReduz = DLLG2_ObtemRetornos(Handle, vDsNrUltimaReduz, 0);
        vDsNrUltimaReduz = fRetornaValor(vDsNrUltimaReduz, "ValorInteiro", "");
        if (vDsNrUltimaReduz.Trim() == "") vDsNrUltimaReduz = "0";

        // pego o valor de Cancelamentos
        DLLG2_ExecutaComando(Handle, "LeMoeda;NomeDadoMonetario=\"CancelamentosICMSReducao[" + vDsNrUltimaReduz + "]\"");
        vDsVlCancelamentos = DLLG2_ObtemRetornos(Handle, vDsVlCancelamentos, 0);
        vDsVlCancelamentos = fRetornaValor(vDsVlCancelamentos, "ValorMoeda", "");
        vDsVlCancelamentos = vDsVlCancelamentos.Replace( ".", "");
        if (vDsVlCancelamentos.Trim() == "") vDsVlCancelamentos = "0";

        // pego o valor de Cancelamentos
        DLLG2_ExecutaComando(Handle, "LeMoeda;NomeDadoMonetario=\"DescontosReducao[" + vDsNrUltimaReduz + "]\"");
        vDsVlDescontos = DLLG2_ObtemRetornos(Handle, vDsVlDescontos, 0);
        vDsVlDescontos = fRetornaValor(vDsVlDescontos, "ValorMoeda", "");
        vDsVlDescontos = vDsVlDescontos.Replace( ".", "");
        if (vDsVlDescontos.Trim() == "") vDsVlDescontos = "0";

        // pego o total da aliquota F
        DLLG2_ExecutaComando(Handle, "LeMoeda;NomeDadoMonetario=\"TotalAliquotaF1Reducao[" + vDsNrUltimaReduz + "]\"");
        vDsVlF = DLLG2_ObtemRetornos(Handle, vDsVlF, 0);
        vDsVlF = fRetornaValor(vDsVlF, "ValorMoeda", "");
        vDsVlF = vDsVlF.Replace( ".", "");
        if (vDsVlF.Trim() == "") vDsVlF = "0";

        // pego o total da aliquota I
        DLLG2_ExecutaComando(Handle, "LeMoeda;NomeDadoMonetario=\"TotalAliquotaI1Reducao[" + vDsNrUltimaReduz + "]\"");
        vDsVlI = DLLG2_ObtemRetornos(Handle, vDsVlI, 0);
        vDsVlI = fRetornaValor(vDsVlI, "ValorMoeda", "");
        vDsVlI = vDsVlI.Replace( ".", "");
        if (vDsVlI.Trim() == "") vDsVlI = "0";

        // pego o total da aliquota N
        DLLG2_ExecutaComando(Handle, "LeMoeda;NomeDadoMonetario=\"TotalAliquotaN1Reducao[" + vDsNrUltimaReduz + "]\"");
        vDsVlN = DLLG2_ObtemRetornos(Handle, vDsVlN, 0);
        vDsVlN = fRetornaValor(vDsVlN, "ValorMoeda", "");
        vDsVlN = vDsVlN.Replace( ".", "");
        if (vDsVlN.Trim() == "") vDsVlN = "0";

        vDsArquivo = "";
        vDsArquivo = "Tipo do relatório.........:" + _Formatar.format("%25s", ["60"]) + sLineBreak;
        vDsArquivo = vDsArquivo + "Subtipo...................:" + _Formatar.format("%25s", ["A"]) + sLineBreak;
        vDsArquivo = vDsArquivo + "Data de emissão...........:" + _Formatar.format("%25s", [vDsData]) + sLineBreak;
        vDsArquivo = vDsArquivo + "Número de série...........:" + _Formatar.format("%25s", [vDsNumeroSerie]) + sLineBreak;
        vDsArquivo = vDsArquivo + "Cancelamentos.............:" + _Formatar.format("%25s", [_Formatar.formatFloat(", 0.00", Double.Parse(vDsVlCancelamentos, 0))]) + sLineBreak;
        vDsArquivo = vDsArquivo + "Descontos.................:" + _Formatar.format("%25s", [_Formatar.formatFloat(", 0.00", Double.Parse(vDsVlDescontos, 0))]) + sLineBreak;
        vDsArquivo = vDsArquivo + "F.........................:" + _Formatar.format("%25s", [_Formatar.formatFloat(", 0.00", Double.Parse(vDsVlF, 0))]) + sLineBreak;
        vDsArquivo = vDsArquivo + "I.........................:" + _Formatar.format("%25s", [_Formatar.formatFloat(", 0.00", Double.Parse(vDsVlI, 0))]) + sLineBreak;
        vDsArquivo = vDsArquivo + "N.........................:" + _Formatar.format("%25s", [_Formatar.formatFloat(", 0.00", Double.Parse(vDsVlN, 0))]) + sLineBreak;

        for (i = 0; i <= 15; i++) {
          // Verifico se a aliquota i é do tipo ICMS
          vDsIndiceAliquota = _Formatar.formatFloat("00", i);
          DLLG2_ExecutaComando(Handle, "LeIndicador;NomeIndicador=\"Aliquota" + vDsIndiceAliquota + "ICMSReducao[" + vDsNrUltimaReduz + "]\"");
          vDsTipoAliquota = DLLG2_ObtemRetornos(Handle, vDsTipoAliquota, 0);
          vDsTipoAliquota = fRetornaValor(vDsTipoAliquota, "ValorTextoIndicador", "\"");
          if (vDsTipoAliquota.Trim() == "1") { // se a aliquota for de ICMS
            // Pego o percentual da aliquota atual
            DLLG2_ExecutaComando(Handle, "LeMoeda;NomeDadoMonetario=\"Aliquota" + vDsIndiceAliquota + "Reducao[" + vDsNrUltimaReduz + "]\"");
            vDsPercAliquota = DLLG2_ObtemRetornos(Handle, vDsPercAliquota, 0);
            vDsPercAliquota = fRetornaValor(vDsPercAliquota, "ValorMoeda", "");
            vDsPercAliquota = _Formatar.formatFloat(", 00.00", Double.Parse(vDsPercAliquota, 0));
            vDsPercAliquota = vDsPercAliquota.Replace( ",", "");

            // pego o valor de venda correspondente a aliquota i
            DLLG2_ExecutaComando(Handle, "LeMoeda;NomeDadoMonetario=\"TotalAliquota" + vDsIndiceAliquota + "Reducao[" + vDsNrUltimaReduz + "]\"");
            vDsVlAliquota = DLLG2_ObtemRetornos(Handle, vDsVlAliquota, 0);
            vDsVlAliquota = fRetornaValor(vDsVlAliquota, "ValorMoeda", "");

            vDsArquivo = vDsArquivo + vDsPercAliquota + "......................:" + _Formatar.format("%25s", [_Formatar.formatFloat(", 0.00", Double.Parse(vDsVlAliquota, 0))]) + sLineBreak;
          }
        }

        DLLG2_ExecutaComando(Handle, "LeMoeda;NomeDadoMonetario=\"TotalAliquotaNS1Reducao[" + vDsNrUltimaReduz + "]\"");
        vDsVlAliquota = DLLG2_ObtemRetornos(Handle, vDsVlAliquota, 0);
        vDsVlAliquota = fRetornaValor(vDsVlAliquota, "ValorMoeda", "");

        vDsArquivo = vDsArquivo + "ISS.......................:" + _Formatar.format("%25s", [_Formatar.formatFloat(", 0.00", Double.Parse(vDsVlAliquota, 0))]);

        AssignFile(F, "C:\ECF\RETORNO.TXT");
        Rewrite(F);
        Write(F, vDsArquivo);
        CloseFile(F);
      } catch (Exception e) {
      }
    } else if ((vModeloEcf == "ecfDaruma")) {
      vCont = 0;

      return regAlterarValor_Daruma("START\LocalArquivosRelatorios", getPathECF().SubString( 3, getPathECF(.Length()))); //'\Projeto_touch\VirtualLoja\path_ecf\'

      _Array.setar(vDadosRZ, 1210);
      rRetornarDadosReducaoZ_ECF_Daruma(vDadosRZ);
      vDtUltMovimento = vDadosRZ.SubString( 1, 8);

      if ((_Arquivo.exists(getPathECF + "Sintegra.txt"))) {
        vPathECF = getPathECF;
      } else if ((_Arquivo.exists("C:\" + "Sintegra.txt"))) {
        vPathECF = "C:\";
      }

     // Result := rGerarSINTEGRA_ECF_Daruma('DATAM', vDtUltMovimento, vDtUltMovimento); 
      if(_Arquivo.exists(vPathECF + "Sintegra.txt")) then {
        AssignFile(vArqSintegra, vPathECF + "Sintegra.txt");
        Reset(vArqSintegra);
        while (not eof(vArqSintegra)) {
          readln(vArqSintegra, vLinha);
          if(vLinha.SubString( 1, 3) == "60A") then {
            inc(vCont);
            //atribuindo valores as variaveis de registro
            vDsData = vLinha.SubString( 4, 8);
            vDsNumeroSerie = vLinha.SubString( 12, 20);
            vDsPercAliquota = vLinha.SubString( 32, 4);
            vDsVlAliquota = vLinha.SubString( 36, 12);
            vDsData = vDsData.SubString( 7, 2) + "/" + vDsData.SubString( 5, 2) + "/" + vDsData.SubString( 3, 2);
            if ((vCont == 1)) {
              vDsArquivo = "";
              vDsArquivo = "Tipo do relatório.........:" + _Formatar.format("%25s", ["60"]) + sLineBreak;
              vDsArquivo = vDsArquivo + "Subtipo...................:" + _Formatar.format("%25s", ["A"]) + sLineBreak;
              vDsArquivo = vDsArquivo + "Data de emissão...........:" + _Formatar.format("%25s", [vDsData]) + sLineBreak;
              vDsArquivo = vDsArquivo + "Número de série...........:" + _Formatar.format("%25s", [vDsNumeroSerie]) + sLineBreak;
            }

            vDsVlAliquota = vDsVlAliquota.SubString( 1, 10) + "," + vDsVlAliquota.SubString( vDsVlAliquota.Length() - 1, 2);
            vDsVlAliquota = _Formatar.formatFloat(", 0.00", Double.Parse(vDsVlAliquota, 0));
            vDsArquivo = vDsArquivo + preenchePonto(26, TrimRight(vDsPercAliquota)) + " : " + _Formatar.format("%25s", [vDsVlAliquota]) + sLineBreak;

          }
        }
        AssignFile(F, getPathECF() + "RETORNO.TXT");
        Rewrite(F);
        Write(F, vDsArquivo);
        CloseFile(F);

        CloseFile(vArqSintegra);

        DeleteFile(vPathECF + "Sintegra.txt");
      }
    } else if ((vModeloEcf == "ecfSweda")) {
      return ECF_RelatorioTipo60Analitico();
    } else if ((vModeloEcf == "ecfEpson")) {
      vLastRZData = _String.Replicate(" ", 1170);
      return EPSON_Obter_Dados_Ultima_RZ(vLastRZData);

      vDsDadosImpressora = _String.Replicate(" ", 110);
      EPSON_Obter_Dados_Impressora(vDsDadosImpressora);
      vNrSerie = vDsDadosImpressora.SubString( 1, 20);

      vDsData = vLastRZData.SubString( 1160, 8);
      if ((vDsData == "????????"))
        vDsData = vLastRZData.SubString( 1, 8);

      vDsData = vDsData.SubString( 1, 2) + "/" + vDsData.SubString( 3, 2) + "/" + vDsData.SubString( 7, 2);
      vDsNumeroSerie = vNrSerie;
      vDsVlCancelamentos = vLastRZData.SubString( 105, 17);
      vDsVlDescontos = vLastRZData.SubString( 156, 17);

      vDsArquivo = "";
      vDsArquivo = "Tipo do relatório.........:" + _Formatar.format("%25s", ["60"]) + sLineBreak;
      vDsArquivo = vDsArquivo + "Subtipo...................:" + _Formatar.format("%25s", ["A"]) + sLineBreak;
      vDsArquivo = vDsArquivo + "Data de emissão...........:" + _Formatar.format("%25s", [vDsData]) + sLineBreak;
      vDsArquivo = vDsArquivo + "Número de série...........:" + _Formatar.format("%25s", [vDsNumeroSerie]) + sLineBreak;

      vPosTributo = 258;
      vPosVlTributo = 384;
      for (i = 1; i <= 24; i++) {
       if ((vLastRZData.SubString( vPosTributo, 1) == "T"))
         vDsPercAliquota = vLastRZData.SubString( vPosTributo + 1, 4)
       else
         vDsPercAliquota = vLastRZData.SubString( vPosTributo, 5);

       if (vDsPercAliquota.Trim() <> "") {
         vDsVlAliquota = vLastRZData.SubString( vPosVlTributo, 17);
         vDsVlAliquota = StrToCurrDef(vDsVlAliquota, 0.ToString() / 100);
         vDsVlAliquota = _Formatar.formatFloat(", 0.00", Double.Parse(vDsVlAliquota, 0));
         vDsArquivo = vDsArquivo + preenchePonto(26, TrimRight(vDsPercAliquota)) + " : " + _Formatar.format("%25s", [vDsVlAliquota]) + sLineBreak;
        }

       vPosTributo = vPosTributo + 5;
       vPosVlTributo = vPosVlTributo + 17;
      }

      vValor = Double.Parse(vDsVlCancelamentos, 0);
      vValor = vValor / 100;
      vDsVlCancelamentos = _Formatar.formatFloat(", 0.00", vValor);
      vDsArquivo = vDsArquivo + "CANC......................:" + _Formatar.format("%25s", [vDsVlCancelamentos]) + sLineBreak;

      vValor = Double.Parse(vDsVlDescontos, 0);
      vValor = vValor / 100;
      vDsVlDescontos = _Formatar.formatFloat(", 0.00", vValor);
      vDsArquivo = vDsArquivo + "DESC......................:" + _Formatar.format("%25s", [vDsVlDescontos]);

      AssignFile(F, "C:\ECF\RETORNO.TXT");
      Rewrite(F);
      Write(F, vDsArquivo);
      CloseFile(F);
    }
  } catch (Exception e) {
    _Logger.e('', E.Message);
  }
}

public int numeroCupom(string vModeloEcf)
{ 
  string vDsNumeroCupom, vDsRetornoCF, vDsContadores;
  int iConta, Tamanho, iNrCupom;

  try {
    if ((vModeloEcf == "ecfBematech") || (vModeloEcf == "ecfYanco")) {
      vDsNumeroCupom = _String.Replicate(" ", 6);
      return Bematech_FI_NumeroCupom(vDsNumeroCupom);
      vNrCupom = vDsNumeroCupom;
    } else if ((vModeloEcf == "ecfElgin")) {
      vDsNumeroCupom = _String.Replicate(" ", 6);
      return Elgin_NumeroCupom(vDsNumeroCupom);
      vNrCupom = vDsNumeroCupom;
    } else if ((vModeloEcf == "ecfInterway") || (vModeloEcf == "ecfUrano")) {
      return DLLG2_ExecutaComando(Handle, "LeInteiro;NomeInteiro=\"COO\"");
      vNrCupom = DLLG2_ObtemRetornos(Handle, "", 0);
      vNrCupom = fRetornaValor(vNrCupom, "ValorInteiro", "");
    } else if ((vModeloEcf == "ecfDaruma")) {
      _Array.setar(vDsRetornoCF, 6);
      return rRetornarInformacao_ECF_Daruma("26", vDsRetornoCF);
      vDsNumeroCupom = vDsRetornoCF;
      if (vDsNumeroCupom.Trim() <> "") {
        iNrCupom = Int16.Parse(vDsNumeroCupom, 0);
        vNrCupom = iNrCupom.ToString();
      }
    } else if ((vModeloEcf == "ecfSweda")) {
      vDsNumeroCupom = _String.Replicate(" ", 6);
      return ECF_NumeroCupom(vDsNumeroCupom);
      vNrCupom = vDsNumeroCupom;
    } else if ((vModeloEcf == "ecfEpson")) {
      vDsContadores = _String.Replicate(" ", 100);
      return EPSON_Obter_Contadores(vDsContadores);
      vDsNumeroCupom = vDsContadores.SubString( 1, 6);
      vNrCupom = vDsNumeroCupom;
    }
  } catch (Exception e) {
    _Logger.e('', E.Message);
  }
}

public int numeroSerie(string vModeloEcf)
{ 
  string vDsNumeroSerie, vDsRetorno, vDsDadosImpressora;
  int iConta;


  try {
    if ((vModeloEcf == "ecfBematech") || (vModeloEcf == "ecfYanco")) {
      vDsNumeroSerie = _String.Replicate(" ", 15);
      return Bematech_FI_NumeroSerie(vDsNumeroSerie);
      vNrSerie = vDsNumeroSerie;
    } else if ((vModeloEcf == "ecfElgin")) {
      Elgin_FechaPortaSerial;
      abrePorta(vModeloEcf);
      vDsNumeroSerie = _String.Replicate(" ", 20);
      return Elgin_NumeroSerie(vDsNumeroSerie);
      vNrSerie = vDsNumeroSerie.Trim();
    } else if ((vModeloEcf == "ecfInterway") || (vModeloEcf == "ecfUrano")) {
      return DLLG2_ExecutaComando(Handle, "LeTexto;NomeTexto=\"NumeroSerieECF\"");
      vNrSerie = DLLG2_ObtemRetornos(Handle, vDsNumeroSerie, 0);
      vNrSerie = fRetornaValor(vNrSerie, "ValorTexto", "\"");
    } else if ((vModeloEcf == "ecfDaruma")) {
      _Array.setar(vDsRetorno, 20);
      return rRetornarInformacao_ECF_Daruma("78", vDsRetorno);
      vNrSerie = vDsRetorno;
    } else if ((vModeloEcf == "ecfSweda")) {
      vDsNumeroSerie = _String.Replicate(" ", 15);
      return ECF_NumeroSerie(vDsNumeroSerie);
      vNrSerie = vDsNumeroSerie;
    } else if ((vModeloEcf == "ecfEpson")) {
      vDsDadosImpressora = _String.Replicate(" ", 110);
      return EPSON_Obter_Dados_Impressora(vDsDadosImpressora);
      vNrSerie = vDsDadosImpressora.SubString( 1, 20);
    }
  } catch (Exception e) {
    _Logger.e('', E.Message);
  }
}

public int numeroSerieMFD(string vModeloEcf)
{ 
  string vDsNumeroSerie, vDsRetorno, vDsDadosImpressora;
  int iConta;

  try {
    if ((vModeloEcf == "ecfBematech") || (vModeloEcf == "ecfYanco")) {
      vDsNumeroSerie = _String.Replicate(" ", 20);
      return Bematech_FI_NumeroSerieMFD(vDsNumeroSerie);
      vNrSerie = vDsNumeroSerie;
    } else if ((vModeloEcf == "ecfElgin")) {
      vDsNumeroSerie = _String.Replicate(" ", 20);
      return Elgin_NumeroSerie(vDsNumeroSerie);
      vNrSerie = vDsNumeroSerie;
      vNrSerie = vDsNumeroSerie.Trim();
    } else if ((vModeloEcf == "ecfInterway") || (vModeloEcf == "ecfUrano")) {
      if (vNrSerie == "") {
        return DLLG2_ExecutaComando(Handle, "LeTexto;NomeTexto=\"NumeroSerieECF\"");
        vNrSerie = DLLG2_ObtemRetornos(Handle, vDsNumeroSerie, 0);
        vNrSerie = fRetornaValor(vNrSerie, "ValorTexto", "\"");
      }
    } else if ((vModeloEcf == "ecfDaruma")) {
      _Array.setar(vDsRetorno, 21);
      return rRetornarInformacao_ECF_Daruma("78", vDsRetorno);
      vNrSerie = vDsRetorno;
    } else if ((vModeloEcf == "ecfSweda")) {
      vDsNumeroSerie = _String.Replicate(" ", 20);
      return ECF_NumeroSerieMFD(vDsNumeroSerie);
      vNrSerie = vDsNumeroSerie;
    } else if ((vModeloEcf == "ecfEpson")) {
      vDsDadosImpressora = _String.Replicate(" ", 110);
      return EPSON_Obter_Dados_Impressora(vDsDadosImpressora);
      vNrSerie = vDsDadosImpressora.SubString( 1, 20);
    }
  } catch (Exception e) {
    _Logger.e('', E.Message);
  }
}

public int dataImpressora(string vModeloEcf)
{ 
  string vDsData, vDsRetorno, vDsDados;
  int iConta;

  try {
    if ((vModeloEcf == "ecfBematech") || (vModeloEcf == "ecfYanco")) {
      vDsData = _String.Replicate(" ", 6);
      return Bematech_FI_DataMovimento(vDsData); // ddmmaa 
      vDataHora = vDsData;
    } else if ((vModeloEcf == "ecfElgin")) {
      vDsData = _String.Replicate(" ", 6);
      return Elgin_DataMovimento(vDsData);
      vDataHora = vDsData;
    } else if ((vModeloEcf == "ecfInterway") || (vModeloEcf == "ecfUrano")) {
      return DLLG2_ExecutaComando(Handle, "LeData;NomeData=\"Data\"");
      vDataHora = DLLG2_ObtemRetornos(Handle, vDsData, 0);
      vDataHora = fRetornaValor(vDataHora, "ValorData", "#");
    } else if ((vModeloEcf == "ecfDaruma")) {
      _Array.setar(vDsRetorno, 8);
      return rRetornarInformacao_ECF_Daruma("70", vDsRetorno);
      vDsData = vDsRetorno;
    } else if ((vModeloEcf == "ecfSweda")) {
      vDsData = _String.Replicate(" ", 6);
      return ECF_DataMovimento(vDsData); // ddmmaa
      vDataHora = vDsData;
    } else if ((vModeloEcf == "ecfEpson")) {
      _Array.setar(vDsDados, 15);
      return EPSON_Obter_Hora_Relogio(vDsDados);
      vDsData = vDsDados.SubString( 1, 7);
    }
  } catch (Exception e) {
    _Logger.e('', E.Message);
  }
}

public int dataHoraGravacaoUsuarioSWBasicoMFAdicional(string vModeloEcf)
{ 
  int iConta;
  string vMFAdicionalAux, Valor;

  try {
    if ((vModeloEcf == "ecfBematech") || (vModeloEcf == "ecfYanco")) {
      vDataUsuario = _String.Replicate(" ", 20);
      vDataSWBasico = _String.Replicate(" ", 20);
      vMFAdicionalAux = _String.Replicate(" ", 2);
      return Bematech_FI_DataHoraGravacaoUsuarioSWBasicoMFAdicional(vDataUsuario, vDataSWBasico, vMFAdicionalAux);
      vMFAdicional = vMFAdicionalAux;
    } else if ((vModeloEcf == "ecfDaruma")) {
      return - 20;
    } else if ((vModeloEcf == "ecfElgin")) {
      return - 20;
    } else if ((vModeloEcf == "ecfEpson")) {
      return - 20;
    } else if ((vModeloEcf == "ecfInterway") || (vModeloEcf == "ecfUrano")) {
      return DLLG2_ExecutaComando(Handle, "LeTexto;NomeTexto=\"VersaoSW\"");
      vDataSWBasico = DLLG2_ObtemRetornos(Handle, vDataSWBasico, 0);
      vDataSWBasico = fRetornaValor(vDataSWBasico, "ValorTexto", "\"");
    } else if ((vModeloEcf == "ecfSweda")) {
      return - 20;
    }
  } catch (Exception e) {
    _Logger.e('', E.Message);
  }
}

public int abreCupomVinculado(string vModeloEcf, string FormaPagamento, string Valor, string NumeroCupom)
{ 
  double vVlValor;
  int vPosicao;
  string vCodPagamento, vResult;

  try {
    Valor = _Formatar.formatFloat("0.00", Double.Parse(Valor, 0));
    if ((vModeloEcf == "ecfBematech") || (vModeloEcf == "ecfYanco")) {
      return Bematech_FI_abreCupomVinculado(FormaPagamento, Valor, NumeroCupom);
    } else if ((vModeloEcf == "ecfElgin")) {
      return Elgin_abreCupomVinculado(FormaPagamento, Valor, NumeroCupom);
    } else if ((vModeloEcf == "ecfInterway")) {
      vVlValor = Double.Parse(Valor.Trim(), 0);
      vVlValor = vVlValor / 100;
      Valor = vVlValor.ToString();
      vCodPagamento = "AbreCreditoDebito;COO=" + NumeroCupom + " NomeMeioPagamento=\"" + FormaPagamento + "\" Valor=" + Valor;
      return DLLG2_ExecutaComando(Handle, "AbreCreditoDebito;COO=" + NumeroCupom + " NomeMeioPagamento=\"" + FormaPagamento + "\" Valor=" + Valor);
    } else if ((vModeloEcf == "ecfUrano")) {
      vVlValor = Double.Parse(Valor.Trim(), 0);
      Valor = vVlValor.ToString();
      vCodPagamento = "AbreCreditoDebito;COO=" + NumeroCupom + " NomeMeioPagamento=\"" + FormaPagamento + "\" Valor=" + Valor;
      return DLLG2_ExecutaComando(Handle, "AbreCreditoDebito;COO=" + NumeroCupom + " NomeMeioPagamento=\"" + FormaPagamento + "\" Valor=" + Valor);
    } else if ((vModeloEcf == "ecfDaruma")) {
      return iCCDAbrirSimplificado_ECF_Daruma(FormaPagamento, "1", NumeroCupom, Valor);
    } else if ((vModeloEcf == "ecfSweda")) {
      return ECF_abreCupomVinculado(FormaPagamento, Valor, NumeroCupom);
    } else if ((vModeloEcf == "ecfEpson")) {
      VerificaFormasPagamento("ecfEpson");
      vPosicao = owerCase(FormaPagamento.IndexOf(), vFormaPGTO.ToLowerCase());
      vCodPagamento = vFormaPGTO.SubString( vPosicao - 2, 2);
      Valor = Valor.Replace( ".", "");
      Valor = Valor.Replace( ",", "");
      return EPSON_NaoFiscal_Abrir_CCD(vCodPagamento, Valor, 2, "1");
    }
  } catch (Exception e) {
    _Logger.e('', E.Message);
  }
}

public int usaComprovanteNaoFiscalVinculado(string vModeloEcf, string Texto)
{ 
  int vRetorno, i;
  string vMensagem, vLinha;
  tstringlist vstLista;

  try {
    if ((vModeloEcf == "ecfBematech") || (vModeloEcf == "ecfYanco")) {
      return Bematech_FI_UsaComprovanteNaoFiscalVinculado(Texto);
    } else if ((vModeloEcf == "ecfElgin")) {
      return Elgin_UsaComprovanteNaoFiscalVinculado(Texto);
    } else if ((vModeloEcf == "ecfInterway") || (vModeloEcf == "ecfUrano")) {
      return DLLG2_ExecutaComando(Handle, "ImprimeTexto;TextoLivre=\"" + Texto + "\"");
    } else if ((vModeloEcf == "ecfDaruma")) {
      return iCCDImprimirTexto_ECF_Daruma(Texto);
    } else if ((vModeloEcf == "ecfSweda")) {
      return ECF_UsaComprovanteNaoFiscalVinculado(Texto);
    } else if ((vModeloEcf == "ecfEpson")) {
      try {
        vstLista = TStringList.Create;
        vstLista.Text = Texto;
        for (i = 0; i <= vstLista.Count - 1; i++) {
          vLinha = vstLista.Strings[i];
          return EPSON_NaoFiscal_Imprimir_Linha(vLinha);
        }
      finally
       vstLista.Free;
      }
    }
  } catch (Exception e) {
    _Logger.e('', E.Message);
  }
}

public int fechaRelatorioGerencial(string vModeloEcf)
{ 
  string vDsRespota;

  try {
    if ((vModeloEcf == "ecfBematech") || (vModeloEcf == "ecfYanco")) {
      return Bematech_FI_FechaRelatorioGerencial();
    } else if ((vModeloEcf == "ecfElgin")) {
      return Elgin_FechaRelatorioGerencial();
    } else if ((vModeloEcf == "ecfInterway") || (vModeloEcf == "ecfUrano")) {
      return DLLG2_ExecutaComando(Handle, "EncerraDocumento");
    } else if ((vModeloEcf == "ecfDaruma")) {
      return iRGFechar_ECF_Daruma;
    } else if ((vModeloEcf == "ecfSweda")) {
      return ECF_FechaRelatorioGerencial();
    } else if ((vModeloEcf == "ecfEpson")) {
      return EPSON_NaoFiscal_Fechar_Relatorio_Gerencial(true);
    }
  } catch (Exception e) {
    _Logger.e('', E.Message);
  }
}

public int sangria(string vModeloEcf, string vValor)
{ 
  double vVlValor;
  int vCodresult;
  string vResult;

  try {
    if ((vModeloEcf == "ecfBematech") || (vModeloEcf == "ecfYanco")) {
      return Bematech_FI_Sangria(vValor);
    } else if ((vModeloEcf == "ecfElgin")) {
      return Elgin_Sangria(vValor);
    } else if ((vModeloEcf == "ecfInterway")) {
      vVlValor = Double.Parse(vValor.Trim(), 0);
      vVlValor = vVlValor / 100;
      vValor = vVlValor.ToString();
      DLLG2_ExecutaComando(Handle, "EmiteItemNaoFiscal;NomeNaoFiscal=\"Sangria\";Valor=" + vValor);
      DLLG2_ExecutaComando(Handle, "PagaCupom;CodMeioPagamento=-2 Valor=" + vValor);
      return DLLG2_ExecutaComando(Handle, "EncerraDocumento");
    } else if ((vModeloEcf == "ecfUrano")) {
      vVlValor = Double.Parse(vValor.Trim(), 0);
      vValor = vVlValor.ToString();
      return DLLG2_ExecutaComando(Handle, "EmiteItemNaoFiscal;NomeNaoFiscal=\"Sandria\" Valor=" + vValor);
      return DLLG2_ExecutaComando(Handle, "EncerraDocumento");
    } else if ((vModeloEcf == "ecfDaruma")) {
      return iSangria_ECF_Daruma(vValor, "");
    } else if ((vModeloEcf == "ecfSweda")) {
      return ECF_Sangria(vValor);
    } else if ((vModeloEcf == "ecfEpson")) {
      if (vValor.Trim()== "") vValor = "0";
      vValor = _Formatar.formatFloat("0", Double.Parse(vValor, 0));
      return EPSON_NaoFiscal_Sangria(vValor, 2);
    }
  } catch (Exception e) {
    _Logger.e('', E.Message);
  }
}

public int suprimento(string vModeloEcf, string vValor)
{ 
  double vVlValor;
  int vCodresult;
  string vResult;

  try {
    if ((vModeloEcf == "ecfBematech") || (vModeloEcf == "ecfYanco")) {
      return Bematech_FI_Suprimento(vValor, "Dinheiro");
    } else if ((vModeloEcf == "ecfElgin")) {
      return Elgin_Suprimento(vValor, "Dinheiro");
    } else if ((vModeloEcf == "ecfInterway")) {
      vVlValor = Double.Parse(vValor.Trim(), 0);
      vVlValor = vVlValor / 100;
      vValor = vVlValor.ToString();
      DLLG2_ExecutaComando(Handle, "EmiteItemNaoFiscal;NomeNaoFiscal=\"Suprimento\";Valor=" + vValor);
      return DLLG2_ExecutaComando(Handle, "EncerraDocumento");
    } else if ((vModeloEcf == "ecfUrano")) {
      vVlValor = Double.Parse(vValor.Trim(), 0);
      vValor = vVlValor.ToString();
      return DLLG2_ExecutaComando(Handle, "EmiteItemNaoFiscal;NomeNaoFiscal=\"Suprimento\" Valor=" + vValor);
      DLLG2_ExecutaComando(Handle, "PagaCupom;CodMeioPagamento=-2 Valor=" + vValor);
      return DLLG2_ExecutaComando(Handle, "EncerraDocumento");
    } else if ((vModeloEcf == "ecfDaruma")) {
      return iSuprimento_ECF_Daruma(vValor, "");
    } else if ((vModeloEcf == "ecfSweda")) {
      return ECF_Suprimento(vValor, "Dinheiro");
    } else if ((vModeloEcf == "ecfEpson")) {
      if (vValor.Trim()== "") vValor = "0";
      vValor = _Formatar.formatFloat("0", Double.Parse(vValor, 0));
      return EPSON_NaoFiscal_Fundo_Troco(vValor, 2);
    }
  } catch (Exception e) {
    _Logger.e('', E.Message);
  }
}

public int recebimentoNaoFiscal(string vModeloEcf, string vIndice, string vValor, string vFormaPagamento)
{ 
  string vDsCdPagamento, vDescTotalizador, vDsInformacao, vCodPagamento double vVlValor;
  int vPosicao;

  try {
    if ((vModeloEcf == "ecfBematech") || (vModeloEcf == "ecfYanco")) {
      return Bematech_FI_RecebimentoNaoFiscal(vIndice, vValor, vFormaPagamento);
    } else if ((vModeloEcf == "ecfElgin")) {
      return Elgin_RecebimentoNaoFiscal(vIndice, vValor, vFormaPagamento);
    } else if ((vModeloEcf == "ecfInterway")) {
      vDsCdPagamento = "";
      if ((vFormaPagamento.Trim() == "Dinheiro")) {
        vDsCdPagamento = "-2";
      }
      vVlValor = Double.Parse(vValor.Trim(), 0);
      vVlValor = vVlValor / 100;
      vValor = vVlValor.ToString();
      DLLG2_ExecutaComando(Handle, "EmiteItemNaoFiscal;CodNaoFiscal=" + vIndice + ";Valor=" + vValor);
      if (vFormaPagamento.Trim()== "Dinheiro")
        DLLG2_ExecutaComando(Handle, "PagaCupom; CodMeioPagamento=-2 Valor=" + vValor)
      else
        DLLG2_ExecutaComando(Handle, "PagaCupom; NomeMeioPagamento=" + "\"" + vFormaPagamento + "\"" + " Valor=" + vValor);
      return DLLG2_ExecutaComando(Handle, "EncerraDocumento");
    } else if ((vModeloEcf == "ecfUrano")) {
      vDsCdPagamento = "";
      if ((vFormaPagamento.Trim() == "Dinheiro")) {
        vDsCdPagamento = "-2";
      }
      vVlValor = Double.Parse(vValor.Trim(), 0);
      vValor = vVlValor.ToString();
      DLLG2_ExecutaComando(Handle, "EmiteItemNaoFiscal;CodNaoFiscal=" + vIndice + " Valor=" + vValor);
      if (vFormaPagamento.Trim()== "Dinheiro")
        DLLG2_ExecutaComando(Handle, "PagaCupom;CodMeioPagamento=-2 Valor=" + vValor)
      else
        DLLG2_ExecutaComando(Handle, "PagaCupom;NomeMeioPagamento=" + "\"" + vFormaPagamento + "\"" + " Valor=" + vValor);
      return DLLG2_ExecutaComando(Handle, "EncerraDocumento");
    } else if ((vModeloEcf == "ecfDaruma")) {
      vValor = vValor.SubString( 4, 11);
      vIndice = vIndice.SubString( vIndice.Length() - 1, 2);
      _Array.setar(vDsInformacao, 84);

      return iCNFAbrir_ECF_Daruma(" ", " ", " ");
      return iCNFReceberSemDesc_ECF_Daruma(vIndice, vValor);
      return iCNFTotalizarComprovantePadrao_ECF_Daruma;
      return iCNFEfetuarPagamento_ECF_Daruma(vFormaPagamento, vValor, vDsInformacao);
      return iCNFEncerrarPadrao_ECF_Daruma;
    } else if ((vModeloEcf == "ecfSweda")) {
      return ECF_RecebimentoNaoFiscal(vIndice, vValor, vFormaPagamento);
    } else if ((vModeloEcf == "ecfEpson")) {
      VerificaFormasPagamento("ecfEpson");
      vPosicao = owerCase(vFormaPagamento.IndexOf(), vFormaPGTO.ToLowerCase());
      vCodPagamento = vFormaPGTO.SubString( vPosicao - 2, 2);

      vValor = vValor.Replace( ".", "");
      vValor = vValor.Replace( ",", "");
      vValor = Int16.Parse(vValor, 0.ToString());

      return EPSON_NaoFiscal_Abrir_Comprovante("", "", "", "", 0);

      if ((result == 0)) return EPSON_NaoFiscal_Vender_Item(vIndice, vValor, 2);
      if ((result == 0)) return EPSON_NaoFiscal_Pagamento(vCodPagamento, vValor, 2, "", "");

      return EPSON_NaoFiscal_Fechar_Comprovante(True);
    }
  } catch (Exception e) {
    _Logger.e('', E.Message);
  }
}

public int dataHoraImpressora(string vModeloEcf)
{ 
  int iConta;
  string vData, vHora, vDsDados;

  try {
    if ((vModeloEcf == "ecfBematech") || (vModeloEcf == "ecfYanco")) {
      vData = _String.Replicate(" ", 6);
      vHora = _String.Replicate(" ", 6);
      return Bematech_FI_DataHoraImpressora(vData, vHora);
      vData = vData.SubString( 1, 2) + "/" + vData.SubString( 3, 2) + "/" + vData.SubString( 5, 2);
      vHora = vHora.SubString( 1, 2) + ":" + vHora.SubString( 3, 2) + ":" + vHora.SubString( 5, 2);
      vDataHora = vData + " " + vHora;
    } else if ((vModeloEcf == "ecfElgin")) {
      vData = _String.Replicate(" ", 6);
      vHora = _String.Replicate(" ", 6);
      return Elgin_DataHoraImpressora(vData, vHora);
      vData = vData.SubString( 1, 2) + "/" + vData.SubString( 3, 2) + "/" + vData.SubString( 5, 2);
      vHora = vHora.SubString( 1, 2) + ":" + vHora.SubString( 3, 2) + ":" + vHora.SubString( 5, 2);
      vDataHora = vData + " " + vHora;
    } else if ((vModeloEcf == "ecfInterway") || (vModeloEcf == "ecfUrano")) {
      DLLG2_ExecutaComando(Handle, "LeData; NomeData=\"Data\"");
      vData = DLLG2_ObtemRetornos(Handle, vData, 0);
      vData = fRetornaValor(vData, "ValorData", "#");

      return DLLG2_ExecutaComando(Handle, "LeHora; NomeHora=\"Hora\"");
      vHora = DLLG2_ObtemRetornos(Handle, vHora, 0);
      vHora = fRetornaValor(vHora, "ValorHora", "#");

      vDataHora = vData + " " + vHora;
    } else if ((vModeloEcf == "ecfDaruma")) {
      _Array.setar(vData, 8);
      _Array.setar(vHora, 6);
      return rDataHoraImpressora_ECF_Daruma(vData, vHora);
      vData = vData.SubString( 1, 2) + "/" + vData.SubString( 3, 2) + "/" + vData.SubString( 7, 2);
      vHora = vHora.SubString( 1, 2) + ":" + vHora.SubString( 3, 2) + ":" + vHora.SubString( 5, 2);
      vDataHora = vData + " " + vHora;
    } else if ((vModeloEcf == "ecfSweda")) {
      vData = _String.Replicate(" ", 6);
      vHora = _String.Replicate(" ", 6);
      return ECF_DataHoraImpressora(vData, vHora);
      vData = vData.SubString( 1, 2) + "/" + vData.SubString( 3, 2) + "/" + vData.SubString( 5, 2);
      vHora = vHora.SubString( 1, 2) + ":" + vHora.SubString( 3, 2) + ":" + vHora.SubString( 5, 2);
      vDataHora = vData + " " + vHora;
    } else if ((vModeloEcf == "ecfEpson")) {
      _Array.setar(vDsDados, 15);
      return EPSON_Obter_Hora_Relogio(vDsDados);
      vData = vDsDados.SubString( 1, 8);
      vHora = vDsDados.SubString( 9, 6);
      vData = vData.SubString( 1, 2) + "/" + vData.SubString( 3, 2) + "/" + vData.SubString( 5, 4);
      vHora = vHora.SubString( 1, 2) + ":" + vHora.SubString( 3, 2) + ":" + vHora.SubString( 5, 2);
      vDataHora = vData + " " + vHora;
    }
  } catch (Exception e) {
    _Logger.e('', E.Message);
  }

  vDataHora = TcFuncaoECF._validaDtImpressora(vDataHora);
}

public int autenticacao(string vModeloEcf)
{ 
  string vDsTxt;

  try {
    if ((vModeloEcf == "ecfBematech") || (vModeloEcf == "ecfYanco")) {
      return Bematech_FI_Autenticacao();
    } else if ((vModeloEcf == "ecfElgin")) {
      return Elgin_Autenticacao();
    } else if ((vModeloEcf == "ecfInterway") || (vModeloEcf == "ecfUrano")) {
      return DLLG2_ExecutaComando(Handle, "ImprimeAutenticacao;TempoEspera=8");
    } else if ((vModeloEcf == "ecfDaruma")) {
      _Array.setar(vDsTxt, 48);
      return iAutenticarDocumento_DUAL_DarumaFramework(vDsTxt, "1", "120");
    } else if ((vModeloEcf == "ecfSweda")) {
      return ECF_Autenticacao();
    } else if ((vModeloEcf == "ecfEpson")) {
      return EPSON_Autenticar_Imprimir("");
    }
  } catch (Exception e) {
    _Logger.e('', E.Message);
  }
}

public int programaHorarioVerao(string vModeloEcf)
{
  try {
    if ((vModeloEcf == "ecfBematech") || (vModeloEcf == "ecfYanco")) {
      return Bematech_FI_ProgramaHorarioVerao();
    } else if ((vModeloEcf == "ecfElgin")) {
      return Elgin_ProgramaHorarioVerao();
    } else if ((vModeloEcf == "ecfInterway") || (vModeloEcf == "ecfUrano")) {
      return DLLG2_ExecutaComando(Handle, "AcertaHorarioVerao");
    } else if ((vModeloEcf == "ecfDaruma")) {
      return confHabilitarHorarioVerao_ECF_Daruma;
    } else if ((vModeloEcf == "ecfSweda")) {
      return ECF_CfgHorarioVerao("1");
    } else if ((vModeloEcf == "ecfEpson")) {
      return EPSON_Config_Horario_Verao;
    }
  } catch (Exception e) {
    _Logger.e('', E.Message);
  }
}

public int dataHoraReducao(string vModeloEcf)
{ 
  int iConta;
  string vData, vHora, vDsIndice, vDsDadosUltZ;

  try {
    if ((vModeloEcf == "ecfBematech") || (vModeloEcf == "ecfYanco")) {
      vData = _String.Replicate(" ", 6);
      vHora = _String.Replicate(" ", 6);
      return Bematech_FI_DataHoraReducao(vData, vHora);
      vDataHoraReducao = vData + " - " + vHora;
    } else if ((vModeloEcf == "ecfElgin")) {
      vData = _String.Replicate(" ", 6);
      vHora = _String.Replicate(" ", 6);
      return Elgin_DataHoraReducao(vData, vHora);
      vDataHoraReducao = vData + " - " + vHora;
    } else if ((vModeloEcf == "ecfInterway") || (vModeloEcf == "ecfUrano")) {
      DLLG2_ExecutaComando(Handle, "LeInteiro;NomeInteiro=\"CRZ\"");
      vDsIndice = DLLG2_ObtemRetornos(Handle, vDsIndice, 0 );
      DLLG2_ExecutaComando(Handle, "LeData;NomeData=\"DataReducao[" + vDsIndice + "]\"");
      vData = DLLG2_ObtemRetornos(Handle, vData, 0 );
      vData = vData.SubString( 12, 10);
      return DLLG2_ExecutaComando(Handle, "LeHora;NomeHora=\"HoraReducao[" + vDsIndice + "]\"");
      vHora = DLLG2_ObtemRetornos(Handle, vHora, 0 );
      vHora = vHora.SubString( 12, 8);
      vDataHora = vData + " - " + vHora;
    } else if ((vModeloEcf == "ecfDaruma")) {
      _Array.setar(vDsDadosUltZ, 14);
      return rRetornarInformacao_ECF_Daruma("154", vDsDadosUltZ);
      vDataHoraReducao = vDsDadosUltZ.SubString( 1, 8) + " " + vDsDadosUltZ.SubString( 9, 6);
    } else if ((vModeloEcf == "ecfSweda")) {
      vData = _String.Replicate(" ", 6);
      vHora = _String.Replicate(" ", 6);
      return ECF_DataHoraReducao(vData, vHora);
      vDataHoraReducao = vData + " - " + vHora;
    } else if ((vModeloEcf == "ecfEpson")) {
       _Array.setar(vDsDadosUltZ, 1148);
       return EPSON_Obter_Dados_Ultima_RZ(vDsDadosUltZ);
       vDataHoraReducao = vDsDadosUltZ.SubString( 1, 7) + " " + vDsDadosUltZ.SubString( 8, 6);
    }
  } catch (Exception e) {
    _Logger.e('', E.Message);
  }
}

public int dataHoraReducaoMFD(string vModeloEcf)
{ 
  int vCont;
  string vDataUltimaReducao;

  try {
    if ((vModeloEcf == "ecfBematech") || (vModeloEcf == "ecfYanco")) {
      vDataUltimaReducao = _String.Replicate(" ", 7);
      return Bematech_FI_DataMovimentoUltimaReducaoMFD(vDataUltimaReducao);
      vDataHora = vDataUltimaReducao.SubString( 1, 2) + "/" + vDataUltimaReducao.SubString( 3, 2) + "/" + vDataUltimaReducao.SubString( 5, 2);
      vDataHora = _DataHora.formatar("dd/mm/yyyy", StrToDateDef(vDataHora, 0));
      vDataHora = vDataHora;
    } else if ((vModeloEcf == "ecfElgin")) {
    } else if ((vModeloEcf == "ecfInterway") || (vModeloEcf == "ecfUrano")) {
      return dataHoraReducao(vModeloEcf);
    } else if ((vModeloEcf == "ecfDaruma")) {
    } else if ((vModeloEcf == "ecfSweda")) {
    }
  } catch (Exception e) {
    _Logger.e('', E.Message);
  }
}

public int verificaTotalizadoresNaoFiscais(string vModeloEcf)
{ 
  int iConta;
  string vDsTotalizadorAtual;

  try {
    if ((vModeloEcf == "ecfBematech") || (vModeloEcf == "ecfYanco")) {
      vTotalizadoresNaoFiscais = _String.Replicate(" ", 179);
      return Bematech_FI_VerificaTotalizadoresNaoFiscais(vTotalizadoresNaoFiscais);
    } else if ((vModeloEcf == "ecfElgin")) {
      vTotalizadoresNaoFiscais = _String.Replicate(" ", 179);
      return Elgin_VerificaTotalizadoresNaoFiscais(vTotalizadoresNaoFiscais);
    } else if ((vModeloEcf == "ecfInterway") || (vModeloEcf == "ecfUrano")) {
      vTotalizadoresNaoFiscais = "";
      for (iConta = 0; iConta <= 15; iConta++) { // 14 é o limite máximo de totalizadores não fiscais
        return DLLG2_ExecutaComando(Handle, "LeNaoFiscal;CodNaoFiscal=" + iConta.ToString());
        vDsTotalizadorAtual = DLLG2_ObtemRetornos(Handle, vDsTotalizadorAtual, 0);
        if ((vDsTotalizadorAtual <> "")) {
          vDsTotalizadorAtual = fRetornaValor(vDsTotalizadorAtual, "NomeNaoFiscal", "\"");
          if ((vTotalizadoresNaoFiscais == ""))
            vTotalizadoresNaoFiscais = vDsTotalizadorAtual
          else
            vTotalizadoresNaoFiscais = vTotalizadoresNaoFiscais + " , " + vDsTotalizadorAtual;
        }
      }
    } else if ((vModeloEcf == "ecfDaruma")) {
      _Array.setar(vTotalizadoresNaoFiscais, 300);
      return rLerCNF_ECF_Daruma(vTotalizadoresNaoFiscais);
    } else if ((vModeloEcf == "ecfSweda")) {
      return Captura_Dados_Progamados_Sweda(4, vTotalizadoresNaoFiscais);
    } else if ((vModeloEcf == "ecfEpson")) {
      _Array.setar(vTotalizadoresNaoFiscais, 681);
      return EPSON_Obter_Tabela_NaoFiscais(vTotalizadoresNaoFiscais);
    }
  } catch (Exception e) {
    _Logger.e('', E.Message);
  }
}

public int verificaFormasPagamento(string vModeloEcf)
{ 
  int iConta, vTamanho;
  string vDsPgtoAtual;

  try {
    if ((vModeloEcf == "ecfBematech") || (vModeloEcf == "ecfYanco")) {
      vFormaPgto = _String.Replicate(" ", 3016);
      return Bematech_FI_VerificaFormasPagamento(vFormaPgto);
    } else if ((vModeloEcf == "ecfElgin")) {
      vFormaPgto = _String.Replicate(" ", 3016);
      return Elgin_VerificaFormasPagamento(vFormaPgto);
    } else if ((vModeloEcf == "ecfInterway") || (vModeloEcf == "ecfUrano")) {
      vFormaPgto = "";
      DLLG2_ExecutaComando(Handle, "LeMeioPagamento; CodMeioPagamentoProgram=-2");
      vDsPgtoAtual = DLLG2_ObtemRetornos(Handle, vDsPgtoAtual, 0);
      if ((vDsPgtoAtual <> "")) {
        vDsPgtoAtual = fRetornaValor(vDsPgtoAtual, "NomeMeioPagamento", "\"");
        vFormaPgto = vFormaPgto + "," + vDsPgtoAtual;
      }
      for (iConta = 0; iConta <= 15; iConta++) { // 14 é o limite máximo de totalizadores não fiscais
        DLLG2_ExecutaComando(Handle, "LeMeioPagamento; CodMeioPagamentoProgram=" + iConta.ToString());
        vDsPgtoAtual = DLLG2_ObtemRetornos(Handle, vDsPgtoAtual, 0);
        if ((vDsPgtoAtual <> "")) {
          vDsPgtoAtual = fRetornaValor(vDsPgtoAtual, "NomeMeioPagamento", "\"");
          vFormaPgto = vFormaPgto + "," + vDsPgtoAtual;
        }
      }
      vFormaPgto = vFormaPgto + ",";

      // como o laço testa todas as opções possível de condições de pagamento, o ultimo retorno provavelmente
      // é de erro, pois o indice da condição de pagamento não foi encontrado, resultando em erro no virtual monitor
      // para não dar erro no comandos, foi movido o valor 9999 que indica para não ser testado o retorno do comando
      return 9999; // para não testar o retorno da impressora.
    } else if ((vModeloEcf == "ecfDaruma")) {
      vFormaPGTO = StringOfChar(#0, 330);
      return rLerMeiosPagto_ECF_Daruma(vFormaPGTO);
      vFormaPGTO = vFormaPGTO.Trim();
      vFormaPGTO = vFormaPGTO.Replace( ";", ",");
    } else if ((vModeloEcf == "ecfSweda")) {
      return Captura_Dados_Progamados_Sweda(2, vFormaPgto);
    } else if ((vModeloEcf == "ecfEpson")) {
      _Array.setar(vFormaPGTO, 881);
      return EPSON_Obter_Tabela_Pagamentos(vFormaPGTO);
      vFormaPgto = LimpaFormaPagamento(vModeloEcf, vFormaPgto);
    }
  } catch (Exception e) {
    _Logger.e('', E.Message);
  }
}

public int retornoAliquotas(string vModeloEcf)
{ 
  int iConta;
  string vDsAliquotaAtual;

  try {
    if ((vModeloEcf == "ecfBematech") || (vModeloEcf == "ecfYanco")) {
      vAliquotas = _String.Replicate(" ", 79);
      return Bematech_FI_RetornoAliquotas(vAliquotas);
    } else if ((vModeloEcf == "ecfElgin")) {
      vAliquotas = _String.Replicate(" ", 79);
      return Elgin_RetornoAliquotas(vAliquotas);
    } else if ((vModeloEcf == "ecfInterway") || (vModeloEcf == "ecfUrano")) {
      vAliquotas = "";
      for (iConta = 0; iConta <= 16; iConta++) {
        return DLLG2_ExecutaComando(Handle, "LeAliquota; CodAliquotaProgramavel=" + iConta.ToString());
        vDsAliquotaAtual = DLLG2_ObtemRetornos(Handle, vDsAliquotaAtual, 0);
        if ((vDsAliquotaAtual <> "")) {
          vDsAliquotaAtual = fRetornaValor(vDsAliquotaAtual, "PercentualAliquota", "");
          if ((vAliquotas == ""))
            vAliquotas = vDsAliquotaAtual
          else
            vAliquotas = vAliquotas + " , " + vDsAliquotaAtual;
        }
      }
      // como o laço testa todas as opções possível de aliquotas, o ultimo retorno provavelmente
      // é de erro, pois o indice da aliquota não foi encontrado, resultando em erro no virtual monitor
      // para não dar erro no comando, foi movido o valor 9999 que indica para não ser testado o retorno do comando
      return 9999; // para não testar o retorno da impressora.
    } else if ((vModeloEcf == "ecfDaruma")) {
      _Array.setar(vAliquotas, 330);
      return rLerAliquotas_ECF_Daruma(vAliquotas);
    } else if ((vModeloEcf == "ecfSweda")) {
      return Captura_Dados_Progamados_Sweda(1, vAliquotas);
    } else if ((vModeloEcf == "ecfEpson")) {
      vAliquotas = _String.Replicate(" ", 533);
      return EPSON_Obter_Tabela_Aliquotas(vAliquotas);
      vAliquotas = LimpaAliquotas(vModeloEcf, vAliquotas);
    }
  } catch (Exception e) {
    _Logger.e('', E.Message);
  }
}

public int leituraChequeMFD(string vModeloEcf)
{
  try {
    if ((vModeloEcf == "ecfBematech") || (vModeloEcf == "ecfYanco")) {
      _Array.setar(vDsCMC7, 36);
      return Bematech_FI_LeituraChequeMFD(vDsCMC7);
    } else if ((vModeloEcf == "ecfElgin")) {
      _Array.setar(vDsCMC7, 36);
      return Elgin_LeituraCheque(vDsCMC7);
    } else if ((vModeloEcf == "ecfInterway") || (vModeloEcf == "ecfUrano")) {

    } else if ((vModeloEcf == "ecfDaruma")) {

    } else if ((vModeloEcf == "ecfSweda")) {
      _Array.setar(vDsCMC7, 36);
      return ECF_LeituraChequeMFD(vDsCMC7);
    } else if ((vModeloEcf == "ecfEpson")) {
      _Array.setar(vDsCMC7, 257);
      return EPSON_Cheque_Ler_MICR(vDsCMC7);
    }
  } catch (Exception e) {
    _Logger.e('', E.Message);
  }
}

public int cancelaImpressaoCheque(string vModeloEcf)
{
  try {
    if ((vModeloEcf == "ecfBematech") || (vModeloEcf == "ecfYanco")) {
      return Bematech_FI_CancelaImpressaoCheque();
    } else if ((vModeloEcf == "ecfElgin")) {
      return Elgin_CancelaImpressaoCheque();
    } else if ((vModeloEcf == "ecfInterway") || (vModeloEcf == "ecfUrano")) {

    } else if ((vModeloEcf == "ecfDaruma")) {

    } else if ((vModeloEcf == "ecfSweda")) {
      return ECF_CancelaImpressaoCheque();
    } else if ((vModeloEcf == "ecfEpson")) {
      return EPSON_Cheque_Cancelar_Impressao;
    }
  } catch (Exception e) {
    _Logger.e('', E.Message);
  }
}

public int verificaStatusCheque(string vModeloEcf)
{ 
  int iStatusCheque;
  string vDsStatusCheque;

  try {
    if ((vModeloEcf == "ecfBematech") || (vModeloEcf == "ecfYanco")) {
      iStatusCheque = 0;
      return Bematech_FI_VerificaStatusCheque(iStatusCheque);
      vStatusCheque = iStatusCheque.ToString();
    } else if ((vModeloEcf == "ecfElgin")) {
      iStatusCheque = 0;
      return Elgin_VerificaStatusCheque(iStatusCheque);
      vStatusCheque = iStatusCheque.ToString();
    } else if ((vModeloEcf == "ecfInterway") || (vModeloEcf == "ecfUrano")) {

    } else if ((vModeloEcf == "ecfDaruma")) {
      return rConsultaStatusImpressoraStr_ECF_Daruma(15, vDsStatusCheque);
      vStatusCheque = vDsStatusCheque;
    } else if ((vModeloEcf == "ecfSweda")) {
      iStatusCheque = 0;
      return ECF_VerificaStatusCheque(iStatusCheque);
      vStatusCheque = iStatusCheque.ToString();
    }
  } catch (Exception e) {
    _Logger.e('', E.Message);
  }
}

public int imprimeCheque(string vModeloEcf, string Banco, string Valor, string Favorecido, string Cidade, string Data, string Mensagem)
{
  try {
    if ((vModeloEcf == "ecfBematech") || (vModeloEcf == "ecfYanco")) {
      return Bematech_FI_ImprimeCheque(Banco, Valor, Favorecido, Cidade, Data, Mensagem);
    } else if ((vModeloEcf == "ecfElgin")) {
      return Elgin_ImprimeCheque(Banco, Valor, Favorecido, Cidade, Data, Mensagem);
    } else if ((vModeloEcf == "ecfInterway") || (vModeloEcf == "ecfUrano")) {

    } else if ((vModeloEcf == "ecfDaruma")) {
      return iChequeImprimir_FS2100_Daruma(Banco, Cidade, Data, Favorecido, " ", Valor);
    } else if ((vModeloEcf == "ecfSweda")) {
      return ECF_ImprimeCheque(Banco, Valor, Favorecido, Cidade, Data, Mensagem);
    } else if ((vModeloEcf == "ecfEpson")) {
      return EPSON_Cheque_Imprimir("01", Valor, 2, Favorecido, Cidade, Data, Mensagem);
    }
  } catch (Exception e) {
    _Logger.e('', E.Message);
  }
}

public int relatorioGerencial(string vModeloEcf, string vConteudo)
{ 
  tstringlist vstLista;
  int i;
  string vLinha, vResult;

  try {
    if ((vModeloEcf == "ecfBematech") || (vModeloEcf == "ecfYanco")) {
      vConteudo = "";
      vDsResposta = LeituraIndicadores(vModeloEcf);
      if ((vDsResposta == "Impressora Vendendo") || (vDsResposta == "Impressora Pagamento")) {
        return Bematech_FI_CancelaCupom();
      }
      return Bematech_FI_RelatorioGerencial(vConteudo);
    } else if ((vModeloEcf == "ecfElgin")) {
      return Elgin_RelatorioGerencial(vConteudo);
    } else if ((vModeloEcf == "ecfInterway") || (vModeloEcf == "ecfUrano")) {
      if ((vConteudo.Trim() == "RELATORIO GERENCIAL")) // identifica que é para abrir o relatório gerencial
        return DLLG2_ExecutaComando(Handle, "AbreGerencial; NomeGerencial=\"RELATORIO\"")
      else {
        return DLLG2_ExecutaComando(Handle, "ImprimeTexto;TextoLivre=\"" + vConteudo + "\"");
      }
    } else if ((vModeloEcf == "ecfDaruma")) {
      return iRGImprimirTexto_ECF_Daruma(vConteudo);
    } else if ((vModeloEcf == "ecfSweda")) {
      vConteudo = "";
      vDsResposta = LeituraIndicadores(vModeloEcf);
      if ((vDsResposta == "Impressora Vendendo") || (vDsResposta == "Impressora Pagamento")) {
        return ECF_CancelaCupom();
      }
      return ECF_RelatorioGerencial(vConteudo);
    } else if ((vModeloEcf == "ecfEpson")) {
       if ((vConteudo.Trim()== "RELATORIO GERENCIAL")) // identifica que é para abrir o relatório gerencial
         return EPSON_NaoFiscal_Abrir_Relatorio_Gerencial("1")
       else {
         try {
           vstLista = TStringList.Create;
           vstLista.Text = vConteudo;
           for (i = 0; i <= vstLista.Count - 1; i++) {
             vLinha = vstLista.Strings[i];
             return EPSON_NaoFiscal_Imprimir_Linha(vLinha);
           }
         finally
           vstLista.Free;
         }
       }
    }
  } catch (Exception e) {
    _Logger.e('', E.Message);
  }
}

public int verificaEstadoGaveta(string vModeloEcf)
{
  try {
    if ((vModeloEcf == "ecfBematech") || (vModeloEcf == "ecfYanco")) {
      return Bematech_FI_VerificaEstadoGaveta(iEstadoGaveta);
    } else if ((vModeloEcf == "ecfElgin")) {
      return Elgin_VerificaEstadoGaveta(iEstadoGaveta);
    } else if ((vModeloEcf == "ecfInterway") || (vModeloEcf == "ecfUrano")) {
      return DLLG2_ExecutaComando(Handle, "SensorGaveta");
    } else if ((vModeloEcf == "ecfDaruma")) {
      return rStatusGaveta_ECF_Daruma(iEstadoGaveta);
    } else if ((vModeloEcf == "ecfSweda")) {
      return ECF_VerificaEstadoGaveta(iEstadoGaveta);
    } else if ((vModeloEcf == "ecfEpson")) {
      //Result := VERIFICAR AQUI
    }
  } catch (Exception e) {
    _Logger.e('', E.Message);
  }
}

public int abreGaveta(string vModeloEcf)
{
  try {
    if ((vModeloEcf == "ecfBematech") || (vModeloEcf == "ecfYanco")) {
      return Bematech_FI_AcionaGaveta();
    } else if ((vModeloEcf == "ecfElgin")) {
      return Elgin_AcionaGaveta();
    } else if ((vModeloEcf == "ecfInterway") || (vModeloEcf == "ecfUrano")) {
      return DLLG2_ExecutaComando(Handle, "AbreGaveta");
    } else if ((vModeloEcf == "ecfDaruma")) {
      return eAbrirGaveta_ECF_Daruma;
    } else if ((vModeloEcf == "ecfSweda")) {
      return ECF_AcionaGaveta();
    } else if ((vModeloEcf == "ecfEpson")) {
      return EPSON_Impressora_Abrir_Gaveta;
    }
  } catch (Exception e) {
    _Logger.e('', E.Message);
  }
}

public int testarPortaSerial(string vModeloEcf, string vPorta)
{ 
  string vResult;

  try {
    if ((vModeloEcf == "ecfBematech") || (vModeloEcf == "ecfYanco")) {
      return Bematech_FI_AbrePortaSerial;
    } else if ((vModeloEcf == "ecfElgin")) {
      return Elgin_AbrePortaSerial();
    } else if ((vModeloEcf == "ecfInterway") || (vModeloEcf == "ecfUrano")) {
      if (vPorta == "")
        vPorta = "COM1";

      Handle = DLLG2_IniciaDriver(vPorta);
      return Handle;
      DLLG2_DefineTimeout(Handle, 50);
    } else if ((vModeloEcf == "ecfDaruma")) {
      return eAbrirSerial_Daruma(vPorta, "9600");
    } else if ((vModeloEcf == "ecfSweda")) {
      return ECF_AbrePortaSerial;
    } else if ((vModeloEcf == "ecfEpson")) {
      return EPSON_Serial_Abrir_PortaEx;
    }
  } catch (Exception e) {
    _Logger.e('', E.Message);
  }
}

public int cortarPapel(string vModeloEcf)
{
  try {
    if ((vModeloEcf == "ecfBematech") || (vModeloEcf == "ecfYanco")) {
      return Bematech_FI_AcionaGuilhotinaMFD(0);
    } else if ((vModeloEcf == "ecfElgin")) {
      return Elgin_AcionaGuilhotinaMFD(1);
    } else if ((vModeloEcf == "ecfInterway") || (vModeloEcf == "ecfUrano")) {
      return DLLG2_ExecutaComando(Handle, "CortaPapel; TipoCorte=0");
    } else if ((vModeloEcf == "ecfDaruma")) {
      return eAcionarGuilhotina_ECF_Daruma("1");
    } else if ((vModeloEcf == "ecfSweda")) {
      return ECF_AtivaDesativaCorteProximoMFD(1);
    } else if ((vModeloEcf == "ecfEpson")) {
      return EPSON_Impressora_Cortar_Papel();
    }
  } catch (Exception e) {
    _Logger.e('', E.Message);
  }
}

public int avancaLinhaCortarPapel(string vModeloEcf, int Linhas)
{ 
  int i;

  try {
    if ((vModeloEcf == "ecfBematech") || (vModeloEcf == "ecfYanco")) {
      return Bematech_FI_AvancaPapelAcionaGuilhotinaMFD(Linhas, 0);
    } else if ((vModeloEcf == "ecfElgin")) {

    } else if ((vModeloEcf == "ecfInterway") || (vModeloEcf == "ecfUrano")) {
      for ( = 1;  <= Linhas; ++) {
        return DLLG2_ExecutaComando(Handle, "AvancaPapel;Avanco=50"); // altura de uma linha aproximadamente
      }
    } else if ((vModeloEcf == "ecfDaruma")) {

    } else if ((vModeloEcf == "ecfSweda")) {

    } else if ((vModeloEcf == "ecfEpson")) {
      EPSON_Impressora_Avancar_Papel(Linhas);
      return EPSON_Impressora_Cortar_Papel();
    }
  } catch (Exception e) {
    _Logger.e('', E.Message);
  }
}

public int verificaEstadoImpressora(string vModeloEcf)
{ 
  int iAck, iSt1, iSt2, Indicadores, iConta;
  string vDsStatus, Str_Informacao;

  iAck = 0;
  iSt1 = 0;
  iSt2 = 0;
  try {
    if ((vModeloEcf == "ecfBematech") || (vModeloEcf == "ecfYanco")) {
      return Bematech_FI_VerificaEstadoImpressora(iAck, iSt1, iSt2);
    } else if ((vModeloEcf == "ecfElgin")) {
      return Elgin_VerificaEstadoImpressora(iAck, iSt1, iSt2);
    } else if ((vModeloEcf == "ecfInterway") || (vModeloEcf == "ecfUrano")) {
      return DLLG2_ExecutaComando(0, "LeInteiro;NomeInteiro=\"EstadoGeralECF\"");
      if (retornoImpressoraErro(vModeloEcf, result)) return;

      vDsStatus = DLLG2_ObtemRetornos(Handle, vDsStatus, 0);
      vDsStatus = fRetornaValor(vDsStatus, "ValorInteiro", "");
      if (vDsStatus.Trim() <> "0") {
        return STS_ECFCUPOMAB; return;
      }

      return 1;
    } else if ((vModeloEcf == "ecfDaruma")) {
      _Array.setar(vDsStatus, 14);
      return rStatusImpressora_ECF_Daruma(vDsStatus);
    } else if ((vModeloEcf == "ecfSweda")) {
      return ECF_VerificaEstadoImpressora(iAck, iSt1, iSt2);
    } else if ((vModeloEcf == "ecfEpson")) {
      Str_Informacao = Str_Informacao + _String.Replicate(" ", 57);
      EPSON_Obter_Estado_Cupom(Str_Informacao);
    }
  } catch (Exception e) {
    _Logger.e('', E.Message);
  }
}

public string leituraIndicadores(string vModeloEcf)
{ 
  int Indicadores;
  string vNrIndicadores;

  try {
    if ((vModeloEcf == "ecfBematech") || (vModeloEcf == "ecfYanco")) {
      Bematech_FI_FlagsFiscais(vFlagFiscal);
      return Descricao_FlagFiscais_Bematech(vFlagFiscal);
    } else if ((vModeloEcf == "ecfElgin")) {
      Elgin_LeIndicadores(Indicadores);
      return Elgin_LeIndicadoresDescricao(Indicadores);
    } else if ((vModeloEcf == "ecfInterway") || (vModeloEcf == "ecfUrano")) {
      DLLG2_ExecutaComando(Handle, "LeInteiro; NomeInteiro=\"Indicadores\"");
      vNrIndicadores = DLLG2_ObtemRetornos(Handle, vNrIndicadores, 10);
      Indicadores = itemI("ValorInteiro", vNrIndicadores);
      putitemXml(Result, "NR_INDICADORES", Indicadores);
    } else if ((vModeloEcf == "ecfDaruma")) {

    } else if ((vModeloEcf == "ecfSweda")) {
      ECF_FlagsFiscais(vFlagFiscal);
      return ECF_FlagsFiscaisDescricao(vFlagFiscal);
    }
  } catch (Exception e) {
    _Logger.e('', E.Message);
  }
}

//-----------------------------------
public string retornoImpressora(string vModeloEcf, int Retorno)
const
  cDS_METHOD == "T_ECFSVCO011._retornoImpressora()";
{ 
  string vRetorno, vDetalhe, vDsRetorno, vDsAviso, vMsgNumErro;
  int vNumErro, vNumAviso;
  vStatus: Variant;

  return "";

  try {
    if ((vModeloEcf == "ecfBematech") || (vModeloEcf == "ecfYanco")) {
      // retorno igual a UM foi executado com sucesso
      // diferente de UM verificar tabela de erro
      vRetorno = Analisa_Retorno_Bematech(Retorno); // descritiva
      vDetalhe = Retorno_Impressora_Bematech(vStatus); // codigo do erro
      if ((vRetorno <> "")) {
        return SetStatus(STS_ERROR_ECF, "BEMA(" + iRetorno.ToString() + ")", vRetorno + iff(vRetorno<>"", " / ") + vDetalhe, cDS_METHOD);
        return(STS_ERROR_ECF); return;
      } else if ((vStatus == STS_ERROR)) {
        return SetStatus(STS_ERROR_ECF, "BEMA(" + iRetorno.ToString() + ")", vDetalhe, cDS_METHOD);
        return(STS_ERROR_ECF); return;
      } else if ((vStatus == STS_POUCO_PAPEL)) {
        MensagemBal("Pouco papel", 25);
      }

    } else if ((vModeloEcf == "ecfDaruma")) {
      //Variaveis devem ser inicializadas
      vNumErro = 0;
      vNumAviso = 0;
      vMsgNumErro = StringOFChar(" ", 300);
      vDsAviso = StringOFChar(" ", 300);
      vDsRetorno = StringOFChar(" ", 300);

      // Retorna a mensagem referente ao erro e aviso do ultimo comando enviado
      vNumErro = eRetornarAvisoErroUltimoCMD_ECF_Daruma(vDsAviso, vMsgNumErro);

      // Retorno do método
      vStatus = eInterpretarRetorno_ECF_Daruma(Retorno, vDsRetorno);

      if ((vDsRetorno.IndexOf("Alíquota (Situação tributária) não programada") > 0)) {
        vMsgNumErro = vDsRetorno.Trim();
        vNumErro = - 1;
      }

      if ((vNumErro <= 0) && (vMsgNumErro.Trim() <> "Sem Erro")) {
        return SetStatus(STS_ERROR_ECF, "DARUMA(" + vNumErro.ToString() + ")", vMsgNumErro.Trim(), cDS_METHOD);
        return(STS_ERROR_ECF); return;
      }

    } else if ((vModeloEcf == "ecfElgin")) {
      // retorno igual a UM foi executado com sucesso
      // diferente de UM verificar tabela de erro
      vRetorno = TrataErroElgin(Retorno);
      if ((vRetorno <> "")) {
        return SetStatus(STS_ERROR_ECF, "ELGIN(" + iRetorno.ToString() + ")", vRetorno + iff(vRetorno<>"", " / ") + vDetalhe, cDS_METHOD);
        return(STS_ERROR_ECF); return;
      } else if ((vStatus == STS_ERROR)) {
        return SetStatus(STS_ERROR_ECF, "ELGIN(" + iRetorno.ToString() + ")", vDetalhe, cDS_METHOD);
        return(STS_ERROR_ECF); return;
      } else if ((vStatus == STS_POUCO_PAPEL)) {
        MensagemBal("Pouco papel", 25);
      }

    } else if ((vModeloEcf == "ecfEpson")) {
      // retorno igual a ZERO foi executado com sucesso
      // diferente de ZERO verificar tabela de erro
      return atualizaRetornoEpson(Retorno);
      if ((Retorno <> 0) && (Result <> "")) {
        return SetStatus(STS_ERROR_ECF, "EPSON(" + Retorno.ToString() + ")", Result, cDS_METHOD);
        return(STS_ERROR_ECF); return;
      }

    } else if ((vModeloEcf == "ecfInterway") || (vModeloEcf == "ecfUrano")) {
      // retorno igual a ZERO foi executado com sucesso
      // diferente de ZERO verificar tabela de erro
      if ((retorno == STS_ECFCUPOMAB)) {
        return SetStatus(STS_ERROR_ECF, "URANO(" + STS_ECFCUPOMAB.ToString() + ")", "Impressora contem cupom aberto", cDS_METHOD);
        return(STS_ERROR_ECF); return;
      }

      if ((retorno <> 0) && (retorno <> 9999)) {
        vNumErro = DLLG2_ObtemCodErro(Handle);
        if ((vNumErro <> 0)) {
          vRetorno = TrataErroUrano(vNumErro);
          if ((vRetorno <> "")) {
            return SetStatus(STS_ERROR_ECF, "URANO(" + vNumErro.ToString() + ")", vRetorno, cDS_METHOD);
            return(STS_ERROR_ECF); return;
          } else if ((vStatus == STS_POUCO_PAPEL)) {
            MensagemBal("Pouco papel", 25);
          }
        }
      }

    } else if ((vModeloEcf == "ecfSweda")) {
      // retorno igual a UM foi executado com sucesso
      // diferente de UM verificar tabela de erro
      return Analisa_Retorno_Sweda(Retorno);
      if ((Retorno <= 0) && (Result <> "")) {
        return SetStatus(STS_ERROR_ECF, "SWEDA(" + Retorno.ToString() + ")", Result, cDS_METHOD);
        return(STS_ERROR_ECF); return;
      }

    }

  } catch (Exception e) {
    _Logger.e('', E.Message);
  }

  return SetStatus(STS_EXEC);
  return(STS_EXEC); return;
}

public boolean retornoImpressoraErro(string vModeloEcf, int Retorno)
{
  return (retornoImpressora(vModeloEcf, Retorno) <> "");
}

public int downloadMFD(string vModeloEcf, string vArquivo, string vTipoDownload, string vCOOInicial, string vCOOFinal, string vUsuario)
{ 
  textfile F;
  int vInVazio;
  string vDsLinha, vDsConteudo, vArquivoSaida;

  try {
    if ((vModeloEcf == "ecfBematech") || (vModeloEcf == "ecfYanco")) {
      return Bematech_FI_DownloadMFD(vArquivo, vTipoDownload, vCOOInicial, vCOOFinal, vUsuario);
    } else if ((vModeloEcf == "ecfElgin")) {
      return Elgin_DownloadMFD(vArquivo, vTipoDownload, vCOOInicial, vCOOFinal, vUsuario)
    } else if ((vModeloEcf == "ecfInterway")) {
      iRetorno = DLLG2_ExecutaComando(Handle, "EmiteLeituraFitaDetalhe; DataFinal=#" + vCOOFinal + "# DataInicial=#" + vCOOInicial + "# Destino=\"S\"");

      // o comando LeImpressao, retorna no máximo 4000 bytes, portanto
      // deve fazer o laço enviando o comando até que seja retornado todas as respostas do comando : EmiteLeituraFitaDetalhe
      do {
        iRetorno = DLLG2_ExecutaComando(Handle, "LeImpressao");
        vDsLinha = DLLG2_ObtemRetornos(Handle, vDsLinha, 0);
        vDsLinha = fRetornaValor(vDsLinha, "TextoImpressao", "\"");
        vDsConteudo = vDsConteudo + vDsLinha;
      while !(vDsLinha == "");
      _ArquivoIni.setar(vArquivo, vDsConteudo);
    } else if ((vModeloEcf == "ecfUrano")) {
      iRetorno = DLLG2_ExecutaComando(Handle, "EmiteLeituraFitaDetalhe; DataFinal=#" + vCOOFinal + "# DataInicial=#" + vCOOInicial + "# Destino=\"S\"");

      // o comando LeImpressao, retorna no máximo 4000 bytes, portanto
      // deve fazer o laço enviando o comando até que seja retornado todas as respostas do comando : EmiteLeituraFitaDetalhe
      do {
        iRetorno = DLLG2_ExecutaComando(Handle, "LeImpressao");
        vDsLinha = DLLG2_ObtemRetornos(Handle, vDsLinha, 0);
        vDsLinha = fRetornaValor(vDsLinha, "TextoImpressao", "\"");
        vDsConteudo = vDsConteudo + vDsLinha;
      while !(vDsLinha == "");
      _ArquivoIni.setar(vArquivo, vDsConteudo);
    } else if ((vModeloEcf == "ecfDaruma")) {
      if ((vTipoDownload == "1")) {
        vCOOInicial = vCOOInicial.SubString( 1, 4) + "20" + vCOOInicial.SubString( 5, 2);
        vCOOFinal = vCOOFinal.SubString( 1, 4) + "20" + vCOOFinal.SubString( 5, 2);

        return rEfetuarDownloadMFD_ECF_Daruma("DATAM", vCOOInicial, vCOOFinal, "Daruma.mfd");
      } else if ((vTipoDownload == "2")) {
        return rEfetuarDownloadMFD_ECF_Daruma("COO", vCOOInicial, vCOOFinal, "Daruma.mfd");
      }
    } else if ((vModeloEcf == "ecfSweda")) {
      return ECF_DownloadMFD(vArquivo, vTipoDownload, vCOOInicial, vCOOFinal, vUsuario);
    } else if ((vModeloEcf == "ecfEpson")) {
      if ((vTipoDownload == "1")) {
        vCOOInicial = vCOOInicial.SubString( 1, 4) + "20" + vCOOInicial.SubString( 5, 2);
        vCOOFinal = vCOOFinal.SubString( 1, 4) + "20" + vCOOFinal.SubString( 5, 2);

        return EPSON_Obter_Dados_MF_MFD(vCOOInicial, vCOOFinal, 0, 255, 0, 0, "C:\ECF\DOWNLOADMFD")
      } else if ((vTipoDownload == "2")) {
        vCOOInicial = zerosString(6, vCOOInicial.Trim(), False);
        vCOOFinal = zerosString(6, vCOOFinal.Trim(), False);

        return EPSON_Obter_Dados_MF_MFD(vCOOInicial, vCOOFinal, 2, 255, 0, 0, "C:\ECF\DOWNLOADMFD");
      }
    }
  } catch (Exception e) {
    _Logger.e('', E.Message);
  }
}

public int geraRegistroCAT52MFD(string vModeloEcf, string vArquivo, string vData)
{ 
  vFileMF: AnsiString;
  string vDataI, vArqAux, vPorta;

  try {
    if ((vModeloEcf == "ecfBematech") || (vModeloEcf == "ecfYanco")) {
      return Bematech_FI_GeraRegistrosCAT52MFD(vArquivo, vData);
    } else if ((vModeloEcf == "ecfElgin")) {

    } else if ((vModeloEcf == "ecfInterway") || (vModeloEcf == "ecfUrano")) {
      vArquivo = getPathECF() + "URANO.TDM";
      vPorta = _ArquivoIni.pegar("NR_PORTAECF", "COM1");
      InterwayGeraArquivoBinario( vPorta, vArquivo, vNrSerie);
      vArqAux = NomeArqRFD(vModeloEcf, StrToDate(vData));
      vArqAux = getPathECF() + vArqAux;
      return InterwayGeraArquivoAto17(vArquivo, vArqAux, vData, vData, "D", "", "TDM");
    } else if ((vModeloEcf == "ecfDaruma")) {

    } else if ((vModeloEcf == "ecfSweda")) {
      vFileMF = "C:\NoStop.MF";
      return ECF_DownloadMF(vFileMF);
      vArquivo = vFileMF;
      return ECF_GeraRegistrosCAT52MFD(vArquivo, vData);
    } else if ((vModeloEcf == "ecfEpson")) {

    }
  } catch (Exception e) {
    _Logger.e('', E.Message);
  }
}

//sobrecarga de metodo utilizado porque a Daruma tem parametro diferentes
public int geraRegistroCAT52MFDInt(string vModeloEcf, string vTipoRelatorio, string vTipoIntervalo, string vDataIni, string vDataFim)
{ 
  string vArqAux, vArquivo, vPorta, vDataI;

  try {
    if ((vModeloEcf == "ecfBematech") || (vModeloEcf == "ecfYanco")) {

    } else if ((vModeloEcf == "ecfElgin")) {

    } else if ((vModeloEcf == "ecfInterway")) {
      vArquivo = getPathECF() + "URANO.TDM";
      vPorta = _ArquivoIni.pegar("NR_PORTAECF", "COM1");
      InterwayGeraArquivoBinario(vPorta, vArquivo, vNrSerie);
      vArqAux = NomeArqRFD(vModeloEcf, StrToDate(vDataIni));
      return InterwayGeraArquivoAto17(vArquivo, vArqAux, vDataIni, vDataIni, "D", "", "TDM");
    } else if ((vModeloEcf == "ecfUrano")) {
      vDataI = (_DataHora.formatar("YYYYMMDD", DateTime.Parse(vDataIni)));
      vArquivo = getPathECF() + "URANO.TDM";
      vPorta = _ArquivoIni.pegar("NR_PORTAECF", "COM1");
      InterwayGeraArquivoBinario(vPorta, vArquivo, vNrSerie);
      vArqAux = NomeArqRFD(vModeloEcf, StrToDate(vDataIni));
      return InterwayGeraArquivoAto17(vArquivo, vArqAux, vDataI, vDataI, "D", "", "TDM");
    } else if ((vModeloEcf == "ecfDaruma")) {
      return regAlterarValor_Daruma("START\LocalArquivosRelatorios", getPathECF().SubString( 3, getPathECF(.Length()))); //'\Projeto_touch\VirtualLoja\path_ecf\'
      return rGerarRelatorio_ECF_Daruma(vTipoRelatorio, vTipoIntervalo, vDataIni, vDataFim);
    } else if ((vModeloEcf == "ecfSweda")) {

    } else if ((vModeloEcf == "ecfEpson")) {

    }
  } catch (Exception e) {
    _Logger.e('', E.Message);
  }
}

public int programaFormaPagamento(string vModeloEcf, string vFormaPgto, string vPermiteTEF)
{ 
  string vDsNrPagamento;

  try {
    if ((vModeloEcf == "ecfBematech") || (vModeloEcf == "ecfYanco")) {
      return Bematech_FI_ProgramaFormaPagamentoMFD(vFormaPgto, vPermiteTEF);
    } else if ((vModeloEcf == "ecfElgin")) {
      return Elgin_ProgramaFormaPagamentoMFD(vFormaPgto, vPermiteTEF);
    } else if ((vModeloEcf == "ecfInterway") || (vModeloEcf == "ecfUrano")) {
      if ((vPermiteTEF == "1"))
        vPermiteTEF = "true"
      else
        vPermiteTEF = "false";
      return DLLG2_ExecutaComando(Handle, "DefineMeioPagamento; NomeMeioPagamento=\"" + vFormaPgto + "\" PermiteVinculado=" + vPermiteTEF);
    } else if ((vModeloEcf == "ecfDaruma")) {
      return confCadastrarPadrao_ECF_Daruma("FPGTO", vFormaPgto);
    } else if ((vModeloEcf == "ecfSweda")) {
      return ECF_ProgramaFormaPagamentoMFD(vFormaPgto, vPermiteTEF);
    } else if ((vModeloEcf == "ecfEpson")) {
      vDsNrPagamento = _Formatar.formatFloat("00", 1);
      if ((vPermiteTEF == "1"))
        return EPSON_Config_Forma_Pagamento(True, vDsNrPagamento, vFormaPgto)
      else
        return EPSON_Config_Forma_Pagamento(False, vDsNrPagamento, vFormaPgto);
    }
  } catch (Exception e) {
    _Logger.e('', E.Message);
  }
}

public int formatoDadosMFD(string vModeloEcf, string ArquivoOrigem, string ArquivoDestino, string TipoFormato, string TipoDownload, string ParametroInicial, string ParametroFinal, string UsuarioECF)
{
  try {
    if ((vModeloEcf == "ecfBematech") || (vModeloEcf == "ecfYanco")) {
      return Bematech_FI_FormatoDadosMFD(ArquivoOrigem, ArquivoDestino, TipoFormato, TipoDownload, ParametroInicial, ParametroFinal, UsuarioECF);
    } else if ((vModeloEcf == "ecfElgin")) {
      return Elgin_FormatoDadosMFD(ArquivoOrigem, ArquivoDestino, TipoFormato, TipoDownload, ParametroInicial, ParametroFinal, UsuarioECF);
    } else if ((vModeloEcf == "ecfInterway") || (vModeloEcf == "ecfUrano")) {

    } else if ((vModeloEcf == "ecfDaruma")) {

    } else if ((vModeloEcf == "ecfSweda")) {
      return ECF_FormatoDadosMFD(ArquivoOrigem, ArquivoDestino, TipoFormato, TipoDownload, ParametroInicial, ParametroFinal, UsuarioECF);
    }
  } catch (Exception e) {
    _Logger.e('', E.Message);
  }
}

public int geraRegistrosTipoE(string vModeloEcf, string vArqMFD, string vArqTXT, string vDataIni, string vDataFim, string vRazao, string vEndereco, string vCMD, string vTpDownload)
{ 
  string vNrSerie;
  vTipoLeitura: Char;
  int Tamanho;

  try {
    if ((vModeloEcf == "ecfBematech") || (vModeloEcf == "ecfYanco")) {
       return BemaGeraRegistrosTipoE(vArqMFD, vArqTXT, vDataIni, vDataFim, vRazao, vEndereco, "", vCMD, "", "", "", "", "", "", "", "", "", "", "", "", "");
    } else if ((vModeloEcf == "ecfElgin")) {

    } else if ((vModeloEcf == "ecfInterway") || (vModeloEcf == "ecfUrano")) {
      geraArquivoTipoEAux(vModeloEcf, vArqMFD, vArqTXT, "MF", vTpDownload, vDataIni, vDataFim, "");
    } else if ((vModeloEcf == "ecfDaruma")) {
      _Array.setar(vDataIni, 8);
      _Array.setar(vDataFim, 8);
      if ((vTpDownload == "1")) {
        vDataIni = vDataIni.SubString( 1, 4) + "20" + vDataIni.SubString( 5, 2);
        vDataFim = vDataFim.SubString( 1, 4) + "20" + vDataFim.SubString( 5, 2);
        return rGerarMFD_ECF_Daruma("DATAM", vDataIni, vDataFim);
      } else if ((vTpDownload == "2")) {
        return rGerarMFD_ECF_Daruma("COO", vDataIni, vDataFim);
      }
    } else if ((vModeloEcf == "ecfSweda")) {

    } else if ((vModeloEcf == "ecfEpson")) {
      if ((vTpDownload == "1")) {
        vDataIni = vDataIni.SubString( 1, 4) + "20" + vDataIni.SubString( 5, 2);
        vDataFim = vDataFim.SubString( 1, 4) + "20" + vDataFim.SubString( 5, 2);

        return EPSON_Obter_Dados_MF_MFD(vDataIni, vDataFim, 0, 0, 3, 0, "C:\ECF\AC1704")
      } else if ((vTpDownload == "2")) {
        vDataIni = zerosString(6, vDataIni.Trim(), False);
        vDataFim = zerosString(6, vDataFim.Trim(), False);

        return EPSON_Obter_Dados_MF_MFD(vDataIni, vDataFim, 2, 0, 3, 0, "C:\ECF\AC1704");
      }
    }
  } catch (Exception e) {
    _Logger.e('', E.Message);
  }
}

public int configuraCodBarras(string vModeloEcf, int vAltura, int vLargura, int vPosicaoCaracteres, int vFonte, int vMargem)
{
  try {
    if ((vModeloEcf == "ecfBematech") || (vModeloEcf == "ecfYanco")) {
      return Bematech_FI_ConfiguraCodigoBarrasMFD(vAltura, vLargura, vPosicaoCaracteres, vFonte, vMargem);
    } else if ((vModeloEcf == "ecfElgin")) {
      return Elgin_ConfiguraCodigoBarrasMFD(vAltura, vLargura, vPosicaoCaracteres, vFonte, vMargem);
    } else if ((vModeloEcf == "ecfInterway") || (vModeloEcf == "ecfUrano")) {

    } else if ((vModeloEcf == "ecfDaruma")) {

    } else if ((vModeloEcf == "ecfSweda")) {
      return ECF_ConfiguraCodigoBarrasMFD(vAltura.ToString(), vLargura.ToString(), vPosicaoCaracteres.ToString(), vFonte.ToString(), vMargem.ToString());
    } else if ((vModeloEcf == "ecfEpson")) {

    }
  } catch (Exception e) {
    _Logger.e('', E.Message);
  }
}

public int imprimeCodBarrasCODE128(string vModeloEcf, string cCodigo)
{
  try {
    if ((vModeloEcf == "ecfBematech") || (vModeloEcf == "ecfYanco")) {
      return Bematech_FI_ConfiguraCodigoBarrasMFD(70, 0, 2, 1, 5);
      return Bematech_FI_CodigoBarrasCODE128MFD(cCodigo);
    } else if ((vModeloEcf == "ecfElgin")) {
      return Elgin_CodigoBarrasCODE128MFD(cCodigo);
    } else if ((vModeloEcf == "ecfInterway") || (vModeloEcf == "ecfUrano")) {

    } else if ((vModeloEcf == "ecfDaruma")) {
      return iImprimirCodigoBarras_ECF_Daruma("05", "2", "0", "1", cCodigo, "h", "");
    } else if ((vModeloEcf == "ecfSweda")) {
      return ECF_ConfiguraCodigoBarrasMFD("70", "0", "2", "1", "5");
      //result := ECF_CodigoBarrasEAN13MFD(PChar(cCodigo)); 
      return ECF_CodigoBarrasITFMFD(cCodigo);
    } else if ((vModeloEcf == "ecfEpson")) {
      return EPSON_NaoFiscal_Imprimir_Codigo_Barras(70, 50, 2, 0, 0, cCodigo);
    }
  } catch (Exception e) {
    _Logger.e('', E.Message);
  }
}

public int configuraECF(string vModeloEcf)
{
  try {
    if ((vModeloEcf == "ecfBematech") || (vModeloEcf == "ecfYanco")) {

    } else if ((vModeloEcf == "ecfElgin")) {

    } else if ((vModeloEcf == "ecfInterway") || (vModeloEcf == "ecfUrano")) {

    } else if ((vModeloEcf == "ecfDaruma")) {
      return regAlterarValor_Daruma("ECF\MensagemApl1", " ");
      return regAlterarValor_Daruma("ECF\MensagemApl2", " ");
      return regAlterarValor_Daruma("ECF\ControleAutomatico", "1");
      return regAlterarValor_Daruma("ECF\EncontrarECF", "1");
      return regAlterarValor_Daruma("ECF\PortaSerial", _ArquivoIni.pegar("NR_PORTAECF", ""));
      return regAlterarValor_Daruma("START\LocalArquivosRelatorios", getPathECF().SubString( 3, getPathECF(.Length()))); //'\Projeto_touch\VirtualLoja\path_ecf\'
    } else if ((vModeloEcf == "ecfSweda")) {

    }
  } catch (Exception e) {
    _Logger.e('', E.Message);
  }
}

//------------------------------------------------------------------------------
//------------------------------------------------------------------------------
//------------------------------------------------------------------------------

public int verificaFlagsFiscais(string vModeloEcf)
{
  try {
    if ((vModeloEcf == "ecfBematech") || (vModeloEcf == "ecfYanco")) {
      return Bematech_FI_FlagsFiscais(vFlagFiscal);
      vLstFlagFiscal = Analisa_FlagFiscais_Bematech(vFlagFiscal);
    } else if ((vModeloEcf == "ecfElgin")) {
      return Elgin_FlagsFiscais(vFlagFiscal);
    } else if ((vModeloEcf == "ecfInterway") || (vModeloEcf == "ecfUrano")) {

    } else if ((vModeloEcf == "ecfDaruma")) {

    } else if ((vModeloEcf == "ecfSweda")) {
      return ECF_FlagsFiscais(vFlagFiscal);
    }
  } catch (Exception e) {
    _Logger.e('', E.Message);
  }
}

public int programaAliquota(string vModeloEcf, string Aliquota, int ICMS_ISS)
{ 
  string vResult;

  try {
    if ((vModeloEcf == "ecfBematech") || (vModeloEcf == "ecfYanco")) {
      return Bematech_FI_ProgramaAliquota(Aliquota, ICMS_ISS); // 0-ICMS / 1-ISS
    } else if ((vModeloEcf == "ecfElgin")) {
      return Elgin_ProgramaAliquota(Aliquota, ICMS_ISS); // 0-ICMS / 1-ISS
    } else if ((vModeloEcf == "ecfInterway") || (vModeloEcf == "ecfUrano")) {
      return DLLG2_ExecutaComando(Handle, "DefineAliquota;AliquotaICMS=True PercentualAliquota=" + ICMS_ISS.ToString());
    } else if ((vModeloEcf == "ecfDaruma")) {
      return confCadastrar_ECF_Daruma(Aliquota, ICMS_ISS.ToString(), ""); // 0-ICMS / 1-ISS
    } else if ((vModeloEcf == "ecfSweda")) {
      return ECF_ProgramaAliquota(Aliquota, ICMS_ISS); // 0-ICMS / 1-ISS
    }
  } catch (Exception e) {
    _Logger.e('', E.Message);
  }
}

public int mapaResumo(string vModeloEcf)
{
  try {
    if ((vModeloEcf == "ecfBematech") || (vModeloEcf == "ecfYanco")) {
      return Bematech_FI_MapaResumo();
    } else if ((vModeloEcf == "ecfElgin")) {
      return Elgin_MapaResumo();
    } else if ((vModeloEcf == "ecfInterway") || (vModeloEcf == "ecfUrano")) {

    } else if ((vModeloEcf == "ecfDaruma")) {

    } else if ((vModeloEcf == "ecfSweda")) {
      return ECF_MapaResumoMFD();
    }
  } catch (Exception e) {
    _Logger.e('', E.Message);
  }
}

public int aberturaDoDia(string vModeloEcf, string ValorCompra, string FormaPagamento)
{
  try {
    if ((vModeloEcf == "ecfBematech") || (vModeloEcf == "ecfYanco")) {
      return Bematech_FI_AberturaDoDia(ValorCompra, FormaPagamento);
    } else if ((vModeloEcf == "ecfElgin")) {
      return Elgin_AberturaDoDia(ValorCompra, FormaPagamento);
    } else if ((vModeloEcf == "ecfInterway") || (vModeloEcf == "ecfUrano")) {

    } else if ((vModeloEcf == "ecfDaruma")) {
 
    } else if ((vModeloEcf == "ecfSweda")) {
      return ECF_AberturaDoDia(ValorCompra, FormaPagamento);
    }
  } catch (Exception e) {
    _Logger.e('', E.Message);
  }
}

public int abreCupomRecebimento(string vModeloEcf, string FormaPagamento, string Valor, string NumeroCupom)
{
  try {
    if ((vModeloEcf == "ecfBematech") || (vModeloEcf == "ecfYanco")) {
      return Bematech_FI_abreCupomVinculado(FormaPagamento, Valor, NumeroCupom);
    } else if ((vModeloEcf == "ecfElgin")) {
      return Elgin_abreCupomVinculado(FormaPagamento, Valor, NumeroCupom);
    } else if ((vModeloEcf == "ecfInterway") || (vModeloEcf == "ecfUrano")) {

    } else if ((vModeloEcf == "ecfDaruma")) {
      return iCCDAbrirSimplificado_ECF_Daruma(FormaPagamento, "1", NumeroCupom, Valor);
    } else if ((vModeloEcf == "ecfSweda")) {
      return ECF_abreCupomVinculado(FormaPagamento, Valor, NumeroCupom);
    }
  } catch (Exception e) {
    _Logger.e('', E.Message);
  }
}

public int abreRelatorioGerencial(string vModeloEcf, string Indice)
{ 
  string vResult;

  try {
    if ((vModeloEcf == "ecfBematech") || (vModeloEcf == "ecfYanco")) {
      return Bematech_FI_AbreRelatorioGerencialMFD(Indice);
    } else if ((vModeloEcf == "ecfElgin")) {
      return Elgin_AbreRelatorioGerencialMFD(Indice);
    } else if ((vModeloEcf == "ecfInterway") || (vModeloEcf == "ecfUrano")) {
      return DLLG2_ExecutaComando(Handle, "AbreGerencial;NomeGerencial=\"RELATORIO\"");
    } else if ((vModeloEcf == "ecfDaruma")) {
      return iRGAbrir_ECF_Daruma("Relatório");
    } else if ((vModeloEcf == "ecfSweda")) {
      return ECF_AbreRelatorioGerencialMFD(Indice);
    }
  } catch (Exception e) {
    _Logger.e('', E.Message);
  }
}

public int acrescimoDescontoItem(string vModeloEcf, string Item, string AcrescimoDesconto, string TipoAcrescimoDesconto, string ValorAcrescimoDesconto)
{ 
  string vDsDados;
  int i, vItem, vUltimoItem;
  double vValorAcrescimoDesconto;

  try {
    if ((vModeloEcf == "ecfBematech") || (vModeloEcf == "ecfYanco")) {
      return Bematech_FI_AcrescimoDescontoItemMFD(Item, AcrescimoDesconto, TipoAcrescimoDesconto, ValorAcrescimoDesconto);
    } else if ((vModeloEcf == "ecfElgin")) {
      return Elgin_AcrescimoDescontoItemMFD(Item, AcrescimoDesconto, TipoAcrescimoDesconto, ValorAcrescimoDesconto);
    } else if ((vModeloEcf == "ecfInterway") || (vModeloEcf == "ecfUrano")) {
      //{AcresceItemFiscal;Cancelar=false NumItem=1 ValorPercentual=-10;66}
      //Result := DLLG2_ExecutaComando(0, 'AcresceItemFiscal;Cancelar=' + false + ' NumItem=' + Item +' ValorPercentual='-10);
    } else if ((vModeloEcf == "ecfDaruma")) {
      return iCFLancarAcrescimoItem_ECF_Daruma(Item, AcrescimoDesconto + TipoAcrescimoDesconto, ValorAcrescimoDesconto);
    } else if ((vModeloEcf == "ecfSweda")) {
      vValorAcrescimoDesconto = Abs(Double.Parse(ValorAcrescimoDesconto, 0));
      ValorAcrescimoDesconto = _Formatar.formatFloat("0.00", vValorAcrescimoDesconto);
      return ECF_AcrescimoDescontoItemMFD(Item, AcrescimoDesconto, TipoAcrescimoDesconto, ValorAcrescimoDesconto);
    } else if ((vModeloEcf == "ecfEpson")) {
      ValorAcrescimoDesconto = ValorAcrescimoDesconto.Replace( ",", "");
      return EPSON_Fiscal_Desconto_Acrescimo_ItemEx(Item, ValorAcrescimoDesconto, 2, True, False);

      if ((result == 1)) { // se der erro, vai verificar se é o ultimo item e dar o desconto "normal"
        vDsDados = _String.Replicate(" ", 3);
        EPSON_Obter_Numero_Ultimo_Item(vDsDados);

        vUltimoItem = Int16.Parse(vDsDados.Trim(), 0);
        vItem = Int16.Parse(Item.Trim(), 999);
        if ((vItem == vUltimoItem)) // se o desconto for no último item vendido
          return EPSON_Fiscal_Desconto_Acrescimo_Item(ValorAcrescimoDesconto, 2, True, False)
        else
          return EPSON_Fiscal_Desconto_Acrescimo_ItemEx(Item, ValorAcrescimoDesconto, 2, True, False);
      }

    }
  } catch (Exception e) {
    _Logger.e('', E.Message);
  }
}

public int autentica(string vModeloEcf)
{ 
  string vDsTxt;

  try {
    if ((vModeloEcf == "ecfBematech") || (vModeloEcf == "ecfYanco")) {
      return Bematech_FI_Autenticacao();
    } else if ((vModeloEcf == "ecfElgin")) {
      return Elgin_Autenticacao();
    } else if ((vModeloEcf == "ecfInterway") || (vModeloEcf == "ecfUrano")) {
      return DLLG2_ExecutaComando(Handle, "ImprimeAutenticacao;TempoEspera=8");
    } else if ((vModeloEcf == "ecfDaruma")) {
      _Array.setar(vDsTxt, 48);
      return iAutenticarDocumento_DUAL_DarumaFramework(vDsTxt, "1", "120");
    } else if ((vModeloEcf == "ecfSweda")) {
      return ECF_Autenticacao();
    }
  } catch (Exception e) {
    _Logger.e('', E.Message);
  }
}

public int fechaVinculado(string vModeloEcf)
{
  try {
    if ((vModeloEcf == "ecfBematech") || (vModeloEcf == "ecfYanco")) {
      return Bematech_FI_FechaComprovanteNaoFiscalVinculado();
    } else if ((vModeloEcf == "ecfElgin")) {
      return Elgin_FechaComprovanteNaoFiscalVinculado();
    } else if ((vModeloEcf == "ecfInterway") || (vModeloEcf == "ecfUrano")) {
      return DLLG2_ExecutaComando(Handle, "EncerraDocumento");
    } else if ((vModeloEcf == "ecfDaruma")) {
      return iCCDFechar_ECF_Daruma
    } else if ((vModeloEcf == "ecfSweda")) {
      return ECF_FechaComprovanteNaoFiscalVinculado();
    } else if ((vModeloEcf == "ecfEpson")) {
      return EPSON_NaoFiscal_Fechar_Relatorio_Gerencial(true);
    }
  } catch (Exception e) {
    _Logger.e('', E.Message);
  }
}

public int imprimeVinculado(string vModeloEcf, string Texto)
{ 
  tstringlist vLstLinha;
  string vLinha;
  int i;

  try {
    if ((vModeloEcf == "ecfBematech") || (vModeloEcf == "ecfYanco")) {
      return Bematech_FI_UsaComprovanteNaoFiscalVinculado(Texto);
    } else if ((vModeloEcf == "ecfElgin")) {
      return Elgin_UsaComprovanteNaoFiscalVinculado(Texto);
    } else if ((vModeloEcf == "ecfInterway") || (vModeloEcf == "ecfUrano")) {
      return DLLG2_ExecutaComando(Handle, "ImprimeTexto;TextoLivre=\"" + Texto + "\"");
    } else if ((vModeloEcf == "ecfDaruma")) {
      return iCCDImprimirTexto_ECF_Daruma(Texto);
    } else if ((vModeloEcf == "ecfSweda")) {
      return ECF_UsaComprovanteNaoFiscalVinculado(Texto);
    } else if ((vModeloEcf == "ecfEpson")) {
       if ((vCont == 0)) { //quando for o primeiro comando abre o vinculado
         return EPSON_NaoFiscal_Abrir_Relatorio_Gerencial("1");
         Inc(VCont);
       }
       try {
         vLstLinha = TStringList.Create;
         vLstLinha.Text = Texto;
         for (i = 0; i <= vLstLinha.Count - 1; i++) {
           vLinha = vLstLinha.Strings[i];
           return EPSON_NaoFiscal_Imprimir_Linha(vLinha);
         }
       finally
         vLstLinha.Free;
       }
    }
  } catch (Exception e) {
    _Logger.e('', E.Message);
  }
}

public int imprimirRelatorioGerencial(string vModeloEcf, string Texto)
{ 
  tstringlist vLstLinha;
  string vLinha;
  int i;

  try {
    if ((vModeloEcf == "ecfBematech") || (vModeloEcf == "ecfYanco")) {
      return Bematech_FI_RelatorioGerencial(Texto);
    } else if ((vModeloEcf == "ecfElgin")) {
      return ELgin_RelatorioGerencial(Texto);
    } else if ((vModeloEcf == "ecfInterway") || (vModeloEcf == "ecfUrano")) {
      return DLLG2_ExecutaComando(Handle, "AbreGerencial;NomeGerencial=\"RELATORIO\"");
      return DLLG2_ExecutaComando(Handle, "ImprimeTexto;TextoLivre=\"" + Texto + "\"");
    } else if ((vModeloEcf == "ecfDaruma")) {
      return iRGImprimirTexto_ECF_Daruma(Texto);
    } else if ((vModeloEcf == "ecfSweda")) {
      return ECF_RelatorioGerencial(Texto);
    } else if ((vModeloEcf == "ecfEpson")) {
       if ((vCont == 0)) { //quando for o primeiro comando abre o gerencial
         return EPSON_NaoFiscal_Abrir_Relatorio_Gerencial("1");
         Inc(VCont);
       }
       try {
         vLstLinha = TStringList.Create;
         vLstLinha.Text = Texto;
         for (i = 0; i <= vLstLinha.Count - 1; i++) {
           vLinha = vLstLinha.Strings[i];
           return EPSON_NaoFiscal_Imprimir_Linha(vLinha);
         }
       finally
         vLstLinha.Free;
       }
    }
  } catch (Exception e) {
    _Logger.e('', E.Message);
  }
}

public int progHoraVerao(string vModeloEcf)
{
  try {
    if ((vModeloEcf == "ecfBematech") || (vModeloEcf == "ecfYanco")) {
      return Bematech_FI_ProgramaHorarioVerao();
    } else if ((vModeloEcf == "ecfElgin")) {
      return Elgin_ProgramaHorarioVerao();
    } else if ((vModeloEcf == "ecfInterway") || (vModeloEcf == "ecfUrano")) {

    } else if ((vModeloEcf == "ecfDaruma")) {
      return confHabilitarHorarioVerao_ECF_Daruma;
    } else if ((vModeloEcf == "ecfSweda")) {

    }
  } catch (Exception e) {
    _Logger.e('', E.Message);
  }
}

public string verificaReducaoZ(string vModeloEcf)
{ 
  string vMetodo, vResult, vStatusZ, vModelo;
  datetime vDataMovimento, vDataImpressora;
  string vNrIndicadores;
  int Indicadores;

public string prcVerificaReducaoZ()

        iRetorno = dataImpressora(vModeloEcf);
        vDataHora = FormatarDataFmt(vDataHora, "ddmmyy", "dd/mm/yy");
        vDataMovimento = StrToDateDef(vDataHora, 0);
        vDataMovimento = trunc(vDataMovimento);

        iRetorno = dataHoraImpressora(vModeloEcf);
        vDataImpressora = _Funcao.IffNullD(vDataHora, 0);
        vDataImpressora = trunc(vDataImpressora);

        if ((vDataMovimento > 0) && (vDataMovimento <> vDataImpressora)) {
          return SetStatus(STS_REDZPEND, vModelo, cRED_Z_PENDENTE, vMetodo);
          return(STS_REDZPEND); return;
        }
      }

{
  return "";

  vMetodo = "uECF.verificaReducaoZ";
  vModelo = vModeloEcf.Replace( "ecf", "");

  try {
    if ((vModeloEcf == "ecfBematech") || (vModeloEcf == "ecfYanco")) {
      return prcVerificaReducaoZ();
    } else if ((vModeloEcf == "ecfElgin")) {
      return prcVerificaReducaoZ();
    } else if ((vModeloEcf == "ecfInterway") || (vModeloEcf == "ecfUrano")) {
      // LeInteiro; NomeInteiro="Indicadores";40
      DLLG2_ExecutaComando(Handle, "LeInteiro; NomeInteiro=\"Indicadores\"");
      vNrIndicadores = DLLG2_ObtemRetornos(Handle, vNrIndicadores, 10);
      Indicadores = itemI("ValorInteiro", vNrIndicadores);

      vreturn verificaIndicadoresUrano(Indicadores);
      if (itemXmlB("FLAG_Z_PENDENTE", vResult)) {
        return SetStatus(STS_REDZPEND, vModelo, cRED_Z_PENDENTE, vMetodo);
        return(STS_REDZPEND); return;
      } else if (itemXmlB("FLAG_DIA_FECHADO", vResult)) {
        return SetStatus(STS_REDZBLOQ, vModelo, cRED_Z_BLOQUEADA, vMetodo);
        return(STS_REDZBLOQ); return;
      }

    } else if ((vModeloEcf == "ecfDaruma")) {
      _Array.setar(vStatusZ, 1);
      iRetorno = rVerificarReducaoZ_ECF_Daruma(vStatusZ);

      if ((vStatusZ == "1")) {
        return SetStatus(STS_REDZPEND, vModelo, cRED_Z_PENDENTE, vMetodo);
        return(STS_REDZPEND); return;
      }

    } else if ((vModeloEcf == "ecfSweda")) {
      _Array.setar(vStatusZ, 2);
      vRetorno = ECF_VerificaZPendente(vStatusZ);

      // vZpendente
      //  "0" = Redução Z já efetuada.
      //  "1" = Z pendente deve ser feito (encerrar o dia!).
      if ((vStatusZ[1] == "1")) {
        return SetStatus(STS_REDZPEND, vModelo, cRED_Z_PENDENTE, vMetodo);
        return(STS_REDZPEND); return;
      }
      //
    }
  } catch (Exception e) {
    _Logger.e('', E.Message);
  }

  return SetStatus(STS_EXEC);
  return(STS_EXEC); return;
}

public int abrePorta(string vModeloEcf)
{ 
  string vPorta;
  int CodErro;
  string vMsg, Retornos;

  return 1; // por motivo de não emitir erro na aplicação
  try {
    if ((vModeloEcf == "ecfBematech") || (vModeloEcf == "ecfYanco")) {
      return Bematech_FI_AbrePortaSerial;
      return Bematech_FI_HabilitaDesabilitaRetornoEstendidoMFD("1");
    } else if ((vModeloEcf == "ecfElgin")) {

    } else if ((vModeloEcf == "ecfInterway") || (vModeloEcf == "ecfUrano")) {
      vPorta = _ArquivoIni.pegar("NR_PORTAECF", "COM1");
      handle = DLLG2_IniciaDriver(vPorta);
      return result;

      CodErro = DLLG2_ObtemCodErro(Handle); // irei retornar somente o código de erro.
      if (CodErro <> 0) {
        vMsg = DLLG2_ObtemNomeErro(Handle, Retornos, 0);
        vMSG = vMsg + " , " + DLLG2_ObtemCircunstancia(Handle, Retornos, 0);
      }

      DLLG2_DefineTimeout(result, 50);
    } else if ((vModeloEcf == "ecfDaruma")) {

    } else if ((vModeloEcf == "ecfSweda")) {
      return ECF_AbrePortaSerial();
    } else if ((vModeloEcf == "ecfEpson")) {
      return EPSON_Serial_Abrir_PortaEx;
    }
  } catch (Exception e) {
    _Logger.e('', E.Message);
  }
}

public int fechaPorta(string vModeloEcf)
{ 
  string vResult;

  return 1; // por motivo de não emitir erro na aplicação
  try {
    if ((vModeloEcf == "ecfBematech") || (vModeloEcf == "ecfYanco")) {

    } else if ((vModeloEcf == "ecfElgin")) {

    } else if ((vModeloEcf == "ecfInterway") || (vModeloEcf == "ecfUrano")) {
      DLLG2_EncerraDriver(Handle);
    } else if ((vModeloEcf == "ecfDaruma")) {

    } else if ((vModeloEcf == "ecfSweda")) {
      return ECF_FechaPortaSerial();
    } else if ((vModeloEcf == "ecfEpson")) {
      return EPSON_Serial_Fechar_Porta;
    }
  } catch (Exception e) {
    _Logger.e('', E.Message);
  }
}

public int iniciaModoTEF(string vModeloEcf)
{
  return 1; // por motivo de não emitir erro na aplicação

  try {
    if ((vModeloEcf == "ecfBematech") || (vModeloEcf == "ecfYanco")) {
      return Bematech_FI_IniciaModoTEF();
    } else if ((vModeloEcf == "ecfElgin")) {

    } else if ((vModeloEcf == "ecfInterway") || (vModeloEcf == "ecfUrano")) {

    } else if ((vModeloEcf == "ecfDaruma")) {

    } else if ((vModeloEcf == "ecfSweda")) {
      return ECF_IniciaModoTEF();
    }
  } catch (Exception e) {
    _Logger.e('', E.Message);
  }
}

public int finalizaModoTEF(string vModeloEcf)
{
  return 1; // por motivo de não emitir erro na aplicação

  try {
    if ((vModeloEcf == "ecfBematech") || (vModeloEcf == "ecfYanco")) {
      return Bematech_FI_FinalizaModoTEF();
    } else if ((vModeloEcf == "ecfElgin")) {

    } else if ((vModeloEcf == "ecfInterway") || (vModeloEcf == "ecfUrano")) {

    } else if ((vModeloEcf == "ecfDaruma")) {

    } else if ((vModeloEcf == "ecfSweda")) {
      return ECF_FinalizaModoTEF();
    }
  } catch (Exception e) {
    _Logger.e('', E.Message);
  }
}

public int arquivoMFD(string vModeloEcf, string pParams)
/*== - == - == - == - == - == - == - == - == - ==BEMATECH== - == - == - == - == - == - == - == - == - ==
int indicando a parametrização a ser feita no arquivo{v}onde: TipoGeracao;
0 == MF
1 == MFD
2 == TDM
3 == RZ
4 == RFD
Tipo Registros Gerados no Arquivo
MF == E01, E02, E03, E04, E05, E06, E07, E08, E09, E10, E11, E12 e E13
MFD== E01, E02, E14, E15, E16, E17, E18, E19, E20 e E21
TDM== E01, E02, E03, E04, E05, E06, E07, E08, E09, E10, E11, E12, E13, E14, E15, E16, E17, E18, E19, E20 e E21
RZ == E01, E02, E14, E15 e E16
RFD == E01, E02, E03, E04, E05, E06, E07, E08, E09, E10, E11, E12 e E13*/
{ 
  vArquivo, vDadoInicial, vDadoFinal, vUsuario,
  vTpPeriodo, vTpArquivo, vArquivoSaida, vRazaoSocial, vEndereco,
  string vCMD, vLinha, vModECF, vTipo;

  textfile vArqTemp;
  textfile vArqTempTXT;

  tstringlist vTexto;

  return 0;
  vArquivo = itemXml("DS_ARQUIVO", pParams);
  vDadoInicial = itemXml("DS_DADOINICIAL", pParams);
  vDadoFinal = itemXml("DS_DADOFINAL", pParams);
  vUsuario = itemXml("NR_USUARIO", pParams);
  vTpPeriodo = itemXml("TP_DOWNLOAD", pParams);
  vArquivoSaida = itemXml("DS_ARQSAIDA", pParams);
  vRazaoSocial = IffNulo(itemXml("DS_RAZAOSOCIAL", pParams), "Bematech S/A");
  vEndereco = IffNulo(itemXml("DS_ENDERECO", pParams), "Rua ABCDEF, 1234");
  vCMD = IffNulo(itemXml("DS_CMD", pParams), "2");
  vTpArquivo = itemXml("TP_ARQUIVO", pParams);
  vTpPeriodo = itemXml("TP_DOWNLOAD", pParams);

  try {
    if ((vModeloEcf == "ecfBematech") || (vModeloEcf == "ecfYanco")) {
      if ((vTpPeriodo == "1")) { //por data
        vDadoInicial = _DataHora.formatar("DDMMYY", strToDate(vDadoInicial));
        vDadoFinal = _DataHora.formatar("DDMMYY", strToDate(vDadoFinal));

        return Bematech_FI_DownloadMFD(vArquivo, vTpPeriodo, vDadoInicial, vDadoFinal, vUsuario);
        return BemaGeraRegistrosTipoE(vArquivo, vArquivoSaida, vDadoInicial, vDadoFinal, vRazaoSocial, vEndereco, "", vCMD, "", "", "", "", "", "", "", "", "", "", "", "", "");
        if ((result == 0)) { //Tratamento de retorno da DLL  BemaMFD2.dll quando a executado corretamente é igual a 0
          return 1;
        }
      } else if ((vTpPeriodo == "2")) { //por COO
        modeloImpressoraECF(vModeloEcf);
        if ((AllvModeloImpressoraECF.Trim()<> "MP2000FI") && (AllvModeloImpressoraECF.Trim()<> "MP6000FI")) {
          BemaDLL.MP2100 = True;
        }

        return Bematech_FI_DownloadMFD(vArquivo, vTpPeriodo, vDadoInicial, vDadoFinal, vUsuario);
        return BemaDLL.BemaGeraTxtPorCOO(vArquivo,
                                             getPathECF() + cARQ_ESPELHO,
                                             Int16.Parse(vUsuario, 0),
                                             Int16.Parse(vDadoInicial, 0),
                                             Int16.Parse(vDadoFinal, 0));

        // Abre o arquivo Espelho.TXT com a imagem dos cupons capturados.
        AssignFile(vArqTemp, getPathECF() + cARQ_ESPELHO);
        Reset(vArqTemp);

        // Cria o arquivo EspelhoTMP.TXT para guardar a imagens dos cupons
        // capturados, retirando as linhas em branco.
        AssignFile(vArqTempTXT, getPathECF() + cARQ_ESPELHOTMP);
        Rewrite(vArqTempTXT);

        vLinha = "";
        while (not EOF(vArqTemp)) {
          Readln(vArqTemp, vLinha);
          if ((vLinha <> "")) {
            Writeln(vArqTempTXT, vLinha);
          }
        }
        CloseFile(vArqTemp);
        CloseFile(vArqTempTXT);

        // Cria um objeto do tipo TStringList.
        vTexto = TStringList.Create;
        vTexto.LoadFromFile(getPathECF() + cARQ_ESPELHOTMP);

        // Copia as informações de data inicial e final, dentro do objeto Texto.
        vDadoInicial = vTexto.Strings[ 6 ].SubString( 1, 10);
        if ((BemaDLL.MP2100 == true))
          vDadoFinal = vTexto.Strings[ vTexto.Count - 2 ].SubString( 20, 10)
        else
          vDadoFinal = vTexto.Strings[ vTexto.Count - 3 ].SubString( 29, 10);

        // Função que executa a geração do arquivo no layout do Ato Cotepe 17/04
        // para o PAF-ECF, por intervalo de datas previamente capturadas.

        iRetorno = BemaDLL.BemaGeraRegistrosTipoE(vArquivo,
                                             vArquivoSaida,
                                             vDadoInicial,
                                             vDadoFinal,
                                             vRazaoSocial,
                                             vEndereco,
                                             "",
                                             vCMD,
                                             "",
                                             "",
                                             "",
                                             "",
                                             "",
                                             "",
                                             "",
                                             "",
                                             "",
                                             "",
                                             "",
                                             "",
                                             "");
        if ((result == 0)) { //Tratamento de retorno da DLL  BemaMFD2.dll quando a executado corretamente é igual a 0
          return 1;
        }

        DeleteFile(getPathECF() + cARQ_MFD);
        DeleteFile(getPathECF() + cARQ_ESPELHO);
        DeleteFile(getPathECF() + cARQ_ESPELHOTMP);
      }
    } else if ((vModeloEcf == "ecfElgin")) {

    } else if ((vModeloEcf == "ecfInterway") || (vModeloEcf == "ecfUrano")) {
      if ((vTpPeriodo <> "2")) { // 2 = COO
        vTpPeriodo = "M";
      } else
        vTpPeriodo = "C";

      geraArquivoTipoEAux(vModeloEcf, vArquivo, vArquivoSaida, vTpArquivo, vTpPeriodo, vDadoInicial, vDadoFinal, vUsuario);
    } else if ((vModeloEcf == "ecfDaruma")) {
      if ((_Arquivo.exists(getPathECF() + "ATO_MFD_DATA.TXT"))) {
        DeleteFile(getPathECF() + "ATO_MFD_DATA.TXT");
      }
      return regAlterarValor_Daruma("ECF\Atocotepe\LocalArquivos", vArquivoSaida);
      if ((vTpPeriodo == "1")) { //por data
        vDadoInicial = _DataHora.formatar("DDMMYYYY", strToDate(vDadoInicial));
        vDadoFinal = _DataHora.formatar("DDMMYYYY", strToDate(vDadoFinal));
        vTipo = "DATAM";
        return rGerarRelatorio_ECF_Daruma("MFD", vTipo, vDadoInicial, vDadoFinal);
        if ((_Arquivo.exists(getPathECF() + "ATO_MFD_DATA.TXT"))) {
          RenameFile(getPathECF() + "ATO_MFD_DATA.TXT", vArquivoSaida);
        }
      } else if ((vTpPeriodo == "2")) { //por COO
        vTipo = "COO";
        return rGerarRelatorio_ECF_Daruma("MFD", vTipo, vDadoInicial, vDadoFinal);
      }
    } else if ((vModeloEcf == "ecfSweda")) {
      return ECF_ReproduzirMemoriaFiscalMFD("2", vDadoInicial, vDadoFinal, vArquivoSaida, "");
    }
  } catch (Exception e) {
    _Logger.e('', E.Message);
  }
}

public int grandeTotal(string vModeloEcf)
{ 
  int iConta;

  return 1; // por motivo de não emitir erro na aplicação

  vGrandeTotal = _String.Replicate(" ", 18);

  try {
    if ((vModeloEcf == "ecfBematech") || (vModeloEcf == "ecfYanco")) {
      iRetorno = Bematech_FI_GrandeTotal(vGrandeTotal);
    } else if ((vModeloEcf == "ecfElgin")) {

    } else if ((vModeloEcf == "ecfInterway") || (vModeloEcf == "ecfUrano")) {

    } else if ((vModeloEcf == "ecfDaruma")) {
      iRetorno = rRetornarInformacao_ECF_Daruma("1", vGrandeTotal);
    } else if ((vModeloEcf == "ecfSweda")) {
      iRetorno = ECF_GrandeTotal(vGrandeTotal);
    }
  } catch (Exception e) {
    _Logger.e('', E.Message);
  }
}

public int espelhoMFD(string vModeloEcf, string pParams)
{ 
  vDadoIni, vDadoFim, vTipoEspelho, vLinha,
  string vDsPathArquivo, vDsUsuario, vDsArqMfd, vAux;
  tstringlist vDsArq;

  try {
    vDadoIni = itemXml("DS_DADOINI", pParams);
    vDadoFim = itemXml("DS_DADOFIM", pParams);
    vTipoEspelho = itemXml("TP_DOWNLOAD", pParams);

    vDsPathArquivo = itemXml("DS_PATHARQUIVO", pParams);
    vDsUsuario = itemXml("NR_USUARIO", pParams);
    vDsArqMfd = itemXml("DS_ARQUIVOMFD", pParams);

    if ((vModeloEcf == "ecfBematech") || (vModeloEcf == "ecfYanco")) {
      iRetorno = downloadMFD(vModeloEcf, vDsArqMfd, vTipoEspelho, vDadoIni, vDadoFim, vDsUsuario);
      iRetorno = formatoDadosMFD(vModeloEcf, vDsArqMfd, vDsPathArquivo, "0", vTipoEspelho, vDadoIni, vDadoFim, vDsUsuario);
      return iRetorno;
    } else if ((vModeloEcf == "ecfElgin")) {

    } else if ((vModeloEcf == "ecfInterway") || (vModeloEcf == "ecfUrano")) {
      if (_Arquivo.exists(vDsPathArquivo)) {
        DeleteFile(vDsPathArquivo);
      }

      if ((vTipoEspelho <> "2")) {// 2 = COO
        vTipoEspelho = "M";
        vDadoIni = vDadoIni.SubString( 1, 2) + "/" + vDadoIni.SubString( 3, 2) + "/" + vDadoIni.SubString( 5, vDadoIni.Length());
        vDadoFim = vDadoFim.SubString( 1, 2) + "/" + vDadoFim.SubString( 3, 2) + "/" + vDadoFim.SubString( 5, vDadoFim.Length());
      } else {
        vTipoEspelho = "C";
      }

      geraArquivoTipoEAux(vModeloEcf, vDsArqMfd, vDsPathArquivo, "TDM", vTipoEspelho, vDadoIni, vDadoFim, vDsUsuario);
    } else if ((vModeloEcf == "ecfDaruma")) {
      if (_Arquivo.exists(getPathECF + "Espelho_MFD.txt")) {
        DeleteFile(getPathECF + "Espelho_MFD.txt");
      }
      if ((vDsPathArquivo <> "")) iRetorno = regAlterarValor_Daruma("START\LocalArquivos", getPathECF());

      iRetorno = rGerarEspelhoMFD_ECF_Daruma(vTipoEspelho, vDadoIni, vDadoFim);
      if (_Arquivo.exists(getPathECF + "Espelho_MFD.txt")) {
        vDsArq = TStringList.Create;
        vDsArq.LoadFromFile(getPathECF + "Espelho_MFD.txt");
        vDsArq.SaveToFile(vDsPathArquivo);
        vDsArq.Free;
      }

    } else if ((vModeloEcf == "ecfSweda")) {
      if ((vTipoEspelho == "1")) {
        vAux = vDadoIni.SubString( 1, 2) + "/" + vDadoIni.SubString( 3, 2) + "/" + vDadoIni.SubString( 5, 2);
        vDadoIni = vAux;
        vAux = vDadoFim.SubString( 1, 2) + "/" + vDadoFim.SubString( 3, 2) + "/" + vDadoFim.SubString( 5, 2);
        vDadoFim = vAux;
        vDadoIni = _DataHora.formatar("dd/mm/yyyy", StrToDateDef(vDadoIni, 0));
        vDadoFim = _DataHora.formatar("dd/mm/yyyy", StrToDateDef(vDadoFim, 0));
      } else if ((vTipoEspelho == "2")) {
        vDadoIni = "0" + vDadoIni;
        vDadoFim = "0" + vDadoFim;
      }
      return ECF_DownloadMFD(vDsPathArquivo, vTipoEspelho, vDadoIni, vDadoFim, "1");
    }
  } catch (Exception e) {
    _Logger.e('', E.Message);
  }
}

public int configuraGuilhotina(string vModeloEcf, string pParams)
{
  try {
    if ((vModeloEcf == "ecfBematech") || (vModeloEcf == "ecfYanco")) {

    } else if ((vModeloEcf == "ecfElgin")) {

    } else if ((vModeloEcf == "ecfInterway") || (vModeloEcf == "ecfUrano")) {

    } else if ((vModeloEcf == "ecfDaruma")) {
      return confProgramarAvancoPapel_ECF_Daruma("25", "5", "6", "1", "0");
      regAlterarValor_Daruma("ECF\MensagemApl1", " ");
      regAlterarValor_Daruma("ECF\MensagemApl2", " ");
      regAlterarValor_Daruma("ECF\ControleAutomatico", "1");
      regAlterarValor_Daruma("ECF\EncontrarECF", "1");
      regAlterarValor_Daruma("ECF\PortaSerial", vDsPorta);
      regAlterarValor_Daruma("START\LocalArquivosRelatorios", getPathECF());
    } else if ((vModeloEcf == "ecfSweda")) {

    }
  } catch (Exception e) {
    _Logger.e('', E.Message);
  }
}

public int geraArquivoTipoEAux(string vModeloEcf, string vArqEntr, string vArqSai, string vTipoLeitura, string vTipoPeriodo, string vDataIni, string vDataFim, string vUsuario)
{ 
  string vArquivoTDM, vArquivosaida, vPorta, vDataI, vDataF, vUsu;


  try {
    if ((vModeloEcf == "ecfBematech") || (vModeloEcf == "ecfYanco")) {

    } else if ((vModeloEcf == "ecfElgin")) {

    } else if ((vModeloEcf == "ecfInterway") || (vModeloEcf == "ecfUrano")) {
      return DLLG2_ExecutaComando(Handle, "LeTexto; NomeTexto=\"NumeroSerieECF\"");
      vNrSerie = DLLG2_ObtemRetornos(Handle, vNrSerie, 0);
      vNrSerie = fRetornaValor(vNrSerie, "ValorTexto", "\"");

      if (vTipoPeriodo <> "C") {
        vDataI = _DataHora.formatar("YYYYMMDD", DateTime.Parse(vDataIni));
        vDataF = _DataHora.formatar("YYYYMMDD", DateTime.Parse(vDataIni));
      }

      vPorta = _ArquivoIni.pegar("NR_PORTAECF", "COM1");
      InterwayGeraArquivoBinario( vPorta, vArqEntr, vNrSerie);
      return InterwayGeraArquivoAto17(vArqEntr, vArqSai, vDataI, vDataF, vTipoPeriodo[1], vUsuario, vTipoLeitura);
    } else if ((vModeloEcf == "ecfDaruma")) {

    } else if ((vModeloEcf == "ecfSweda")) {

    }
  } catch (Exception e) {
    _Logger.e('', E.Message);
  }
}

public int numeroIntervencoes(string vModeloEcf)
{ 
  string vDsNumeroInterverncoes;

  try {
    if ((vModeloEcf == "ecfBematech") || (vModeloEcf == "ecfYanco")) {
      vDsNumeroInterverncoes = _String.Replicate(" ", 6);
      return Bematech_FI_NumeroIntervencoes(vDsNumeroInterverncoes);
      if (retornoImpressoraErro(vModeloEcf, result)) return;

      if (vDsNumeroInterverncoes.Trim()== "") vDsNumeroInterverncoes = "0";
      vNrIntervencoes = vDsNumeroInterverncoes;
    } else if ((vModeloEcf == "ecfElgin")) {

    } else if ((vModeloEcf == "ecfInterway") || (vModeloEcf == "ecfUrano")) {

    } else if ((vModeloEcf == "ecfDaruma")) {

    } else if ((vModeloEcf == "ecfSweda")) {
      vDsNumeroInterverncoes = _String.Replicate(" ", 6);
      return ECF_NumeroIntervencoes(vDsNumeroInterverncoes);
      vNrIntervencoes = vDsNumeroInterverncoes;
    } else if ((vModeloEcf == "ecfEpson")) {

    }
  } catch (Exception e) {
    _Logger.e('', E.Message);
  }
}

public int numeroReducoes(string vModeloEcf)
{ 
  string vDsNumeroReducoes;

  try {
    if ((vModeloEcf == "ecfBematech") || (vModeloEcf == "ecfYanco")) {
      vDsNumeroReducoes = "";
      vDsNumeroReducoes = _String.Replicate(" ", 4);
      return Bematech_FI_NumeroReducoes(vDsNumeroReducoes);
      if (retornoImpressoraErro(vModeloEcf, result)) return;

      if (vDsNumeroReducoes.Trim()== "") vDsNumeroReducoes = "0";
      vNrNumeroReducoes = vDsNumeroReducoes;
    } else if ((vModeloEcf == "ecfElgin")) {

    } else if ((vModeloEcf == "ecfInterway") || (vModeloEcf == "ecfUrano")) {

    } else if ((vModeloEcf == "ecfDaruma")) {

    } else if ((vModeloEcf == "ecfSweda")) {
      vDsNumeroReducoes = _String.Replicate(" ", 6);
      return ECF_NumeroReducoes(vDsNumeroReducoes);
      vNrNumeroReducoes = vDsNumeroReducoes;
    } else if ((vModeloEcf == "ecfEpson")) {

    }
  } catch (Exception e) {
    _Logger.e('', E.Message);
  }
}

public int retornaContadoresECF(string vModeloEcf)
{ 
  vMensagem, vMetodo,
  sDados, sDadosAux, vRetorno, vDetalhe, vDsArquivo,
  string vCRO, vCRZ, vCOO, vCCF, vGNF, vCDC, vGRG, vDtRedZ, vHrRedZ;
  vStatus: Variant;
  textfile F;


  vMetodo = "uECF.retornaContadoresECF()";

  try {
    if ((vModeloEcf == "ecfBematech") || (vModeloEcf == "ecfYanco")) {
      //CRO
      vCRO = _String.Replicate(" ", 4);
      return Bematech_FI_NumeroIntervencoes(vCRO);
      if (retornoImpressoraErro(vModeloEcf, result)) return;
      if (vCRO.Trim()== "") vCRO = "0";

      //CRZ
      vCRZ = _String.Replicate(" ", 4);
      return Bematech_FI_NumeroReducoes(vCRZ);
      if (retornoImpressoraErro(vModeloEcf, result)) return;
      if (vCRZ.Trim()== "") vCRZ = "0";

      //COO
      vCOO = _String.Replicate(" ", 6);
      return Bematech_FI_NumeroCupom(vCOO);
      if (retornoImpressoraErro(vModeloEcf, result)) return;
      if (vCOO.Trim()== "") vCOO = "0";

      //CCF
      vCCF = _String.Replicate(" ", 6);
      return Bematech_FI_ContadorCupomFiscalMFD(vCCF);
      if (retornoImpressoraErro(vModeloEcf, result)) return;
      if (vCCF.Trim()== "") vCCF = "0";

      //GNF
      vGNF = _String.Replicate(" ", 6);
      return Bematech_FI_NumeroOperacoesNaoFiscais(vGNF);
      if (retornoImpressoraErro(vModeloEcf, result)) return;
      if (vGNF.Trim()== "") vGNF = "0";

      //CDC
      vCDC = _String.Replicate(" ", 6);
      return Bematech_FI_ContadorComprovantesCreditoMFD(vCDC);
      if (retornoImpressoraErro(vModeloEcf, result)) return;
      if (vCDC.Trim()== "") vCDC = "0";

      //GRG
      vGRG = _String.Replicate(" ", 6);
      return Bematech_FI_ContadorRelatoriosGerenciaisMFD(vGRG);
      if (retornoImpressoraErro(vModeloEcf, result)) return;
      if (vGRG.Trim()== "") vGRG = "0";

      //vDtRedZ
      vDtRedZ = _String.Replicate(" ", 6);
      vHrRedZ = _String.Replicate(" ", 6);
      return Bematech_FI_DataHoraReducao(vDtRedZ, vHrRedZ);
      if (retornoImpressoraErro(vModeloEcf, result)) return;

      vDsArquivo = "";
      vDsArquivo = vDsArquivo + "CRO...:" + vCRO + sLineBreak;
      vDsArquivo = vDsArquivo + "CRZ...:" + vCRZ + sLineBreak;
      vDsArquivo = vDsArquivo + "COO...:" + vCOO + sLineBreak;
      vDsArquivo = vDsArquivo + "GNF...:" + vGNF + sLineBreak;
      vDsArquivo = vDsArquivo + "CCF...:" + vCCF + sLineBreak;
      vDsArquivo = vDsArquivo + "GRG...:" + vGRG + sLineBreak;
      vDsPath = getPathECF();
      AssignFile(F, vDsPath + "\retornaContadoresECF.TXT");
      Rewrite(F);
      Write(F, vDsArquivo);
      CloseFile(F);

      return 1;
    } else if ((vModeloEcf == "ecfElgin")) {
      return 1;
    } else if (vModeloEcf == "ecfInterway")then {
      return 0;
    } else if ((vModeloEcf == "ecfUrano")) {
      return 0;
    } else if ((vModeloEcf == "ecfDaruma")) {
      return 1;
    } else if ((vModeloEcf == "ecfSweda")) {
      return 1;
    }
  } catch (Exception e) {
    _Logger.e('', E.Message);
  }
}

end.