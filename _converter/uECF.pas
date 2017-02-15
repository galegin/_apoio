unit uECF;

interface

uses
  Classes, Dialogs, SysUtils, Math, DateUtils, Types, StrUtils;

  function aberturaDoDia(vModeloEcf : String; ValorCompra : String; FormaPagamento : String) : Integer;
  function abreCupom(vModeloEcf : String; vCnpj : String) : Integer;
  function abreCupomRecebimento(vModeloEcf : String; FormaPagamento : String; Valor : String; NumeroCupom : String) : Integer;
  function abreCupomVinculado(vModeloEcf : String; FormaPagamento : String; Valor : String; NumeroCupom : String) : Integer;
  function abrePorta(vModeloEcf : String) : Integer;
  function abreRelatorioGerencial(vModeloEcf : String; Indice : String) : Integer;
  function acrescimoDescontoCupom(vModeloEcf : String; AcrescimoDesconto : String; TipoAcrescimoDesconto : String; ValorAcrescimoDesconto : String) : Integer; //Inicial Fechamento do Cupom
  function acrescimoDescontoItem(vModeloEcf : String; Item, AcrescimoDesconto, TipoAcrescimoDesconto, ValorAcrescimoDesconto : String) : Integer;
  function arquivoMFD(vModeloEcf, pParams : String) : Integer;
  function autentica(vModeloEcf : String) : Integer;
  function cancelaCupom(vModeloEcf : String) : Integer;
  function cancelaCupomVinculado(vModeloEcf, vNrCupom : String) : Integer;
  function cancelaImpressaoCheque(vModeloEcf : String) : Integer;
  function cancelaItem(vModeloEcf : String; Indice : String) : Integer;
  function configuraCodBarras(vModeloEcf : String; vAltura : Integer; vLargura : Integer; vPosicaoCaracteres : Integer; vFonte : Integer; vMargem : Integer) : Integer;
  function dataHoraGravacaoUsuarioSWBasicoMFAdicional(vModeloEcf : String) : Integer;
  function dataHoraImpressora(vModeloEcf : String) : Integer;
  function dataHoraReducao(vModeloEcf : String) : Integer;
  function dataHoraReducaoMFD(vModeloEcf : String) : Integer;
  function dataImpressora(vModeloEcf : String) : Integer;
  function downloadMFD(vModeloEcf : String; vArquivo : String; vTipoDownload : String; vCOOInicial : String; vCOOFinal : String; vUsuario : String) : Integer;
  function efetuaFormaPagamento(vModeloEcf : String; FormaPagamento : String; ValorFormaPagamento : String) : Integer;
  function espelhoMFD(vModeloEcf : String; pParams : String) : Integer;
  function fechaCupom(vModeloEcf : String; MensagemPromocional : String) : Integer;
  function fechaPorta(vModeloEcf : String) : Integer;
  function fechaRelatorioGerencial(vModeloEcf : String) : Integer;
  function fechaVinculado(vModeloEcf : String) : Integer;
  function finalizaModoTEF(vModeloEcf : String) : Integer;
  function formatoDadosMFD(vModeloEcf : String; ArquivoOrigem : String; ArquivoDestino : String; TipoFormato : String; TipoDownload : String; ParametroInicial : String; ParametroFinal : String; UsuarioECF : String) : Integer;
  function geraArquivoTipoE(vModeloEcf : String; vArqEntr, vArqSai, vTipoLeitura, vTipoPeriodo, vDataIni, vDataFim, vUsuario : string): Integer;
  function geraRegistroCAT52MFD(vModeloEcf : String; vArquivo : String; vData : String) : Integer;
  function geraRegistrosTipoE(vModeloEcf : String; vArqMFD : String; vArqTXT : String; vDataIni : String; vDataFim : String; vRazao : String; vEndereco : String; vCMD : String; vTpDownload : String) : Integer;
  function grandeTotal(vModeloEcf : String) : Integer;
  function imprimeCheque(vModeloEcf : String; Banco : String; Valor : String; Favorecido : String; Cidade : String; Data : String; Mensagem : String) : Integer;
  function imprimeCodBarras(vModeloEcf : String; cCodigo : String) : Integer;
  function iniciaModoTEF(vModeloEcf : String) : Integer;
  function leituraChequeMFD(vModeloEcf : String) : Integer;
  function leituraIndicadores(vModeloEcf : String) : String;
  function leituraMemoriaFiscalPorDatas(vModeloEcf : String; DataIni : String; DataFim : String) : Integer;
  function leituraMemoriaFiscalPorReducoes(vModeloEcf : String; RedIni : String; RedFim : String) : Integer;
  function leituraMemoriaFiscalSerialPorDatas(vModeloEcf : String; DataIni : String; DataFim : String; Tipo : String) : Integer;
  function leituraMemoriaFiscalSerialPorReducoe(vModeloEcf : String; RedIni : String; RedFim : String; Tipo : String) : Integer;
  function leituraX(vModeloEcf : String) : Integer;
  function mapaResumo(vModeloEcf : String) : Integer;
  function modeloImpressoraECF(vModeloEcf : String) : Integer;
  function nomeArqRFD(vModeloEcf : String; DtMov : TDatetime ): String;
  function numeroCupom(vModeloEcf : String) : Integer;
  function numeroIntervencoes(vModeloEcf : String) : Integer;
  function numeroReducoes(vModeloEcf : String) : Integer;
  function numeroSerie(vModeloEcf : String) : Integer;
  function numeroSerieMFD(vModeloEcf : String) : Integer;
  function progAliquota(vModeloEcf : String; Aliquota : String; ICMS_ISS : Integer) : Integer;
  function progFormaPagamento(vModeloEcf : String; vFormaPgto : String; vPermiteTEF : String) : Integer;
  function progHoraVerao(vModeloEcf : String) : Integer;
  function reducaoZ(vModeloEcf : String) : Integer;
  function relatorioTipo60Analitico(vModeloEcf : String) : Integer;
  function relatorioTipo60Mestre(vModeloEcf : String) : Integer;
  function retornaAliquotas(vModeloEcf : String) : Integer;
  function retornaContadores(vModeloEcf : String): Integer;
  function retornoFormasPagamento(vModeloEcf : String) : Integer;
  function retornoImpressora(vModeloEcf : String; Retorno : Integer) : String;
  function sangria(vModeloEcf : String; vValor : String) : Integer;
  function suprimento(vModeloEcf : String; vValor : String) : Integer;
  function usaRelatorioGerencial(vModeloEcf : String; vConteudo : String) : Integer;
  function usaComprovanteNaoFiscalVinculado(vModeloEcf : String; Texto : String) : Integer;
  function vendeItem(vModeloEcf : String; Item : String; Codigo : String; Descricao : String; Aliquota : String; TipoQuantidade : String; Quantidade : String; CasasDecimais : String; ValorUnitario : String; TipoDesconto : String; Desconto : String; Unidade : String) : Integer;
  function vendeItemDepartamento(vModeloEcf : String; Codigo : String; Descricao : String; Aliquota : String; ValorUnitario : String; Quantidade : String; Acrescimo : String; Desconto : String; IndiceDepartamento : String; UnidadeMedida : String) : Integer;
  function verificaDocVinculado(vModeloEcf : String) : Integer;
  function verificaEstadoGaveta(vModeloEcf : String) : Integer;
  function verificaEstadoImpressora(vModeloEcf : String) : Integer;
  function verificaFlagsFiscais(vModeloEcf : String) : Integer;
  function verificaReducaoZ(vModeloEcf : String) : String;
  function verificaStatusCheque(vModeloEcf : String) : Integer;
  function verificaTermica(vModeloEcf : String) : Integer;
  function verificaTotalizadoresNaoFiscais(vModeloEcf : String) : Integer;
  
var
  vDsPorta, vDsPath, vNrSerie, vNrCupom, vDataHora, vDataHoraReducao,
  vTotalizadoresNaoFiscais, vFormaPgto, vAliquotas, vDsCMC7, vStatusCheque,
  vDsResposta, vLstFlagFiscal, vStatusZ, vGrandeTotal, vModeloImpressoraECF,
  vDataUsuario, vDataSWBasico, vMFAdicional, vMensagem, vNrIntervencoes,
  vNrNumeroReducoes  : String;

  vFlagFiscal, iRetorno, iEstadoGaveta, vRetorno, vCont : Integer;
  Handle : Integer;

implementation

uses
  cIniFiles, cFuncaoECF, cStatus, cFuncao, cXml,
  UnitDeclaracoesBematech,                             // ecfBematech / ecfYanco
  UnitBemaMFD,                                         // ecfBematech / ecfYanco
  UnitDeclaracoesDarumaFramework,                      // ecfDaruma
  UnitDeclaracoesElgin,                                // ecfElgin
  UnitDeclaracoesEpson,                                // ecfEpson
  UnitDeclaracoesInterway,                             // ecfInterway / ecfUrano
  UnitDeclaracoesSweda,                                // ecfSweda
  UnitDeclaracoesUrano,                                // ecfUrano
  cConst;

// função correspondente ao $item do Uniface,
//parâmetros :
//Linha : Linha inteira aonde contém a informação
//NomeValor : Nome do valor a ser retornado
//Finalizador : qual caracter que identifica aonde termina o resultado
function fRetornaValor(Linha : String; NomeValor : String; Finalizador : String) : String;
var
  vTamanhoValor, vPosicao, vContador, vTamanhoLinha : Integer;
  vRetorno, vFinalizador, vCaracter, vFim : String;
begin

  vRetorno := ''; 
  vPosicao := pos(NomeValor, Linha); 

  if (Finalizador = '') then
    vTamanhoValor := Length(NomeValor) + 1
  else
    vTamanhoValor := Length(NomeValor) + 2; 

  vContador := vPosicao + vTamanhoValor; 
  vTamanhoLinha := Length(Linha);
  vFim := Finalizador; 

  while vContador <= vTamanhoLinha do begin
    vCaracter := Copy(Linha, vContador, 1);

    if vCaracter <> vFim then
      vRetorno := vRetorno + vCaracter
    else
      Break;

    vContador := vContador + 1;
  end;

  result := vRetorno;
end;

function abreCupom(vModeloEcf : String; vCnpj : String) : Integer;
var
  vResult : String;
  vCodresult :  Integer;
begin
  try
    if (vModeloEcf = 'ecfBematech') or (vModeloEcf = 'ecfYanco') then begin
      result := Bematech_FI_AbreCupom(vCnpj);
    end else if (vModeloEcf = 'ecfElgin') then begin
      result := Elgin_AbreCupomMFD(vCnpj, '','');
    end else if (vModeloEcf = 'ecfInterway') or (vModeloEcf = 'ecfUrano') then begin
      if trim(vCnpj) <> '' then begin
        Result := DLLG2_ExecutaComando(Handle, PChar('AbreCupomFiscal; IdConsumidor=' + '"' + vCnpj + '"'))
      end else begin
        Result := DLLG2_ExecutaComando(Handle, PChar('AbreCupomFiscal'));
      end;
    end else if (vModeloEcf = 'ecfDaruma') then begin
      if (vCnpj = '') then vCnpj := ' ';
      result := iCFAbrir_ECF_Daruma(vCnpj, ' ', ' ');
    end else if (vModeloEcf = 'ecfSweda') then begin
      result := ECF_AbreCupom(PChar(vCnpj));
    end else if (vModeloEcf = 'ecfEpson') then begin
      result := EPSON_Fiscal_Abrir_Cupom(PChar(vCnpj), '', '', '', 2);
    end;
  except
    on E : Exception do ShowMessage(E.Message);
  end;
end;

function abreCupomMFD(vModeloEcf, vCpf, vNome, vEndereco : String) : Integer;
begin
  try
    if (vModeloEcf = 'ecfBematech') or (vModeloEcf = 'ecfYanco') then begin
      vDsResposta := LeituraIndicadores(vModeloEcf);
      if (vDsResposta = 'Impressora Vendendo')
      or (vDsResposta = 'Impressora Pagamento') then begin
        result := Bematech_FI_CancelaCupomMFD(vCpf, vNome, vEndereco);
      end;
      result := Bematech_FI_AbreCupomMFD(vCpf, vNome, vEndereco);
    end else if (vModeloEcf = 'ecfElgin') then begin
      result := Elgin_AbreCupomMFD(vCpf, vNome, vEndereco);
    end else if (vModeloEcf = 'ecfInterway') or (vModeloEcf = 'ecfUrano') then begin
      if trim(vCpf) <> '' then
        result := DLLG2_ExecutaComando(Handle, PChar('AbreCupomFiscal; IdConsumidor=' + '"' + vCpf +'"'))
      else
        result := DLLG2_ExecutaComando(Handle, PChar('AbreCupomFiscal'));
    end else if (vModeloEcf = 'ecfDaruma') then begin
      if (vCpf = '') then vCpf := ' ';
      if (vNome = '') then vNome := ' ';
      if (vEndereco = '') then vEndereco := ' ';
      Result := iCFAbrir_ECF_Daruma(vCpf, vNome, vEndereco);
    end else if (vModeloEcf = 'ecfSweda') then begin
      result := ECF_AbreCupomMFD(PChar(vCpf),PChar(vNome),PChar(vEndereco));
    end else if (vModeloEcf = 'ecfEpson') then begin
      result := EPSON_Fiscal_Abrir_Cupom(PChar(vCpf), PChar(vNome), PChar(vEndereco), '', 2);
    end;
  except
    on E : Exception do ShowMessage(E.Message);
  end;
end;

function cancelaCupom(vModeloEcf : String) : Integer;
var
  i : integer;
  vResult, vDSCOO : string;
begin
  try
    if (vModeloEcf = 'ecfBematech') or (vModeloEcf = 'ecfYanco') then begin
      result := Bematech_FI_CancelaCupom();
    end else if (vModeloEcf = 'ecfElgin') then begin
      result := Elgin_CancelaCupom();
    end else if (vModeloEcf = 'ecfInterway') or (vModeloEcf = 'ecfUrano') then begin
      result := DLLG2_ExecutaComando(Handle, 'CancelaCupom');
    end else if (vModeloEcf = 'ecfDaruma') then begin
      result := iCFCancelar_ECF_Daruma();
    end else if (vModeloEcf = 'ecfSweda') then begin
      result := ECF_CancelaCupom();
    end else if (vModeloEcf = 'ecfEpson') then begin
      result := EPSON_Fiscal_Cancelar_Cupom;
    end;
  except
    on E : Exception do ShowMessage(E.Message);
  end;
end;

function cancelaCupomMFD(vModeloEcf, vCpf, vNome, vEndereco : String ) : Integer;
begin
  try
    if (vModeloEcf = 'ecfBematech') or (vModeloEcf = 'ecfYanco') then begin
      result := Bematech_FI_CancelaCupomMFD(vCpf, vNome, vEndereco);
    end else if (vModeloEcf = 'ecfElgin') then begin
      result := Elgin_CancelaCupomMFD(vCpf, vNome, vEndereco);
    end else if (vModeloEcf = 'ecfInterway') or (vModeloEcf = 'ecfUrano') then begin
      result := DLLG2_ExecutaComando(Handle, 'CancelaCupom');
    end else if (vModeloEcf = 'ecfDaruma') then begin
      result := iCFCancelar_ECF_Daruma();
    end else if (vModeloEcf = 'ecfSweda') then begin
      result := ECF_CancelaCupomMFD(vCpf, vNome, vEndereco);
    end else if (vModeloEcf = 'ecfEpson') then begin
      result := EPSON_Fiscal_Cancelar_Cupom;
    end;
  except
    on E : Exception do ShowMessage(E.Message);
  end;
end;

function cancelaCupomVinculado(vModeloEcf, vNrCupom : String) : Integer;
var
  vResult : string;
begin
  try
    if (vModeloEcf = 'ecfBematech') or (vModeloEcf = 'ecfYanco') then begin
      try
         Result := Bematech_FI_EstornoNaoFiscalVinculadoMFD('','','');
      except
      end;
    end else if (vModeloEcf = 'ecfElgin') then begin
      result  := Elgin_EstornoNaoFiscalVinculadoMFD('','','');
      Result  := Elgin_FechaComprovanteNaoFiscalVinculado();
    end else if (vModeloEcf = 'ecfInterway') or (vModeloEcf = 'ecfUrano') then begin
      result := DLLG2_ExecutaComando(Handle, 'EstornaCreditoDebito;COO=' + vNrCupom);
    end else if (vModeloEcf = 'ecfDaruma') then begin
      result := iCCDEstornar_ECF_Daruma(vNrCupom, '','','');
    end else if (vModeloEcf = 'ecfSweda') then begin
      Result := ECF_EstornoNaoFiscalVinculadoMFD('','','');
      Result := ECF_FechaComprovanteNaoFiscalVinculado;
    end else if (vModeloEcf = 'ecfEpson') then begin
      result := EPSON_NaoFiscal_Cancelar_CCD('','', 0,'', PChar(vNrCupom));
    end;
  except
    on E : Exception do ShowMessage(E.Message);
  end;
end;


function leituraX(vModeloEcf : String) : Integer;
var
  vRetorno, I : Integer;
  vMensagem : String;
begin
  try
    if (vModeloEcf = 'ecfBematech') or (vModeloEcf = 'ecfYanco') then begin
      vRetorno := Bematech_FI_LeituraX();
      if (vRetorno = 0) then vRetorno := 1;
      Result := vRetorno;
    end else if (vModeloEcf = 'ecfElgin') then begin
      result := Elgin_LeituraX();
    end else if (vModeloEcf = 'ecfInterway') or (vModeloEcf = 'ecfUrano') then begin
      result := DLLG2_ExecutaComando(Handle, 'EmiteLeituraX');
    end else if (vModeloEcf = 'ecfDaruma') then begin
      result := iLeituraX_ECF_Daruma();
    end else if (vModeloEcf = 'ecfSweda') then begin
      result := ECF_LeituraX();
    end else if (vModeloEcf = 'ecfEpson') then begin
      result := EPSON_RelatorioFiscal_LeituraX;
    end; 
  except
    on E : Exception do ShowMessage(E.Message); 
  end; 
end; 

function reducaoZ(vModeloEcf : String) : Integer;
var
  szCRZ, vResult : String;
  i : Integer;
begin
  try
    if (vModeloEcf = 'ecfBematech') or (vModeloEcf = 'ecfYanco') then begin
      result := Bematech_FI_ReducaoZ('','');
    end else if (vModeloEcf = 'ecfElgin') then begin
      result := Elgin_ReducaoZ('','');
    end else if (vModeloEcf = 'ecfInterway') or (vModeloEcf = 'ecfUrano') then begin
      result := DLLG2_ExecutaComando(Handle, 'EmiteReducaoZ');
    end else if (vModeloEcf = 'ecfDaruma') then begin
      result := iReducaoZ_ECF_Daruma(' ',' ');
    end else if (vModeloEcf = 'ecfSweda') then begin
      result := ECF_ReducaoZ('','');  
    end else if (vModeloEcf = 'ecfEpson') then begin
      szCRZ := ReplicateStr(' ', 20);
      result := EPSON_RelatorioFiscal_RZ('','', 9, PChar(szCRZ));
    end;
  except
    on E : Exception do ShowMessage(E.Message);
  end;
end;

function vendeItem(vModeloEcf : String; Item : String; Codigo : String; Descricao : String; Aliquota : String; TipoQuantidade : String; Quantidade : String; CasasDecimais : String; ValorUnitario : String; TipoDesconto : String; Desconto : String; Unidade : String) : Integer;
var
  vVlDesconto, vVlUnitario, vVlAliquota : Real;
  vDsCodAliquota, vDsresult,vAliquotaTeste : String;
  vCasasDecimaisQt, vCodresult : Integer;
begin
  try
    if (vModeloEcf = 'ecfBematech') or (vModeloEcf = 'ecfYanco') then begin
      Descricao := copy(Descricao, 1, 29); //Bematech aceita apenas 29 caracteres
      if (StrToFloatDef(Desconto,0) >= 0) then begin
        result := Bematech_FI_VendeItem(PChar(Codigo), PChar(Descricao), PChar(Aliquota),
                  PChar(TipoQuantidade), PChar(Quantidade), StrToIntDef(CasasDecimais, 0), PChar(ValorUnitario),
                  PChar(TipoDesconto), PChar(Desconto));
      end else begin
        result := Bematech_FI_VendeItem(PChar(Codigo), PChar(Descricao), PChar(Aliquota),
                  PChar(TipoQuantidade), PChar(Quantidade), StrToIntDef(CasasDecimais, 0), PChar(ValorUnitario),
                  PChar(TipoDesconto), '0');
        Result  := acrescimoDescontoItem(vModeloEcf, PChar(Item), 'A', TipoDesconto, PChar(Desconto));
      end;
    end else if (vModeloEcf = 'ecfElgin') then begin
      if (StrToFloat(Desconto) >= 0) then begin
        result := Elgin_VendeItem(Codigo,Descricao,Aliquota,TipoQuantidade,Quantidade,StrToIntDef(CasasDecimais, 0),ValorUnitario,TipoDesconto,Desconto);
      end else begin
        result := Elgin_VendeItem(Codigo,Descricao,Aliquota,TipoQuantidade,Quantidade,StrToIntDef(CasasDecimais, 0),ValorUnitario,TipoDesconto,'0');
        Result := acrescimoDescontoItem(vModeloEcf, PChar(Item), 'A', TipoDesconto, PChar(Desconto));
      end;
    end else if (vModeloEcf = 'ecfInterway') then begin
      vVlUnitario := StrToFloatDef(ValorUnitario, 0);
      vVlUnitario := vVlUnitario / 100;
      ValorUnitario := FloatToStr(vVlUnitario);

      vDsCodAliquota := '';
      if trim(Aliquota) = 'NN' then
        vDsCodAliquota := '-4'
      else if trim(Aliquota) = 'II' then
        vDsCodAliquota := '-3'
      else if trim(Aliquota) = 'FF' then
        vDsCodAliquota := '-2'
      else begin
        vVlAliquota := StrToFloatDef(Aliquota, 0);
        if (vVlAliquota > 0) then begin
          vVlAliquota := vVlAliquota / 100;
          Aliquota := FloatToStr(vVlAliquota);
        end;
      end;

      // se a aliquota for :  Não tributado (NN), Isento (II) ou Subst. Tributária (FF), deve ser movido o indice em vez de mover a aliquota
      if (vDsCodAliquota <> '') then
        result := DLLG2_ExecutaComando(Handle, 'VendeItem;CodAliquota=' + vDsCodAliquota + ';CodProduto=' + '"' + Codigo + '"' + ';NomeProduto=' + '"' + Descricao + '"' + ';PrecoUnitario=' + ValorUnitario + ';Quantidade=' + Quantidade)
      else
        result := DLLG2_ExecutaComando(Handle, 'VendeItem;AliquotaICMS=true;CodProduto=' + '"' + Codigo + '"' + ';NomeProduto=' + '"' + Descricao + '"' + ';PercentualAliquota=' + Aliquota + ';PrecoUnitario=' + ValorUnitario + ';Quantidade=' + Quantidade);

      // o desconto por item na Interway é um comando a parte
      if trim(Desconto) <> '' then begin
        Desconto := AnsiReplaceStr(Desconto, '.', ',');
        vVlDesconto := StrToFloatDef(Desconto, 0);
        if (vVlDesconto > 0) then begin
          vVlDesconto := vVlDesconto * -1;
          DLLG2_ExecutaComando(Handle, 'AcresceItemFiscal;Cancelar=false;ValorAcrescimo=' + FloatToStr(vVlDesconto));
        end;
      end;
    end else if (vModeloEcf = 'ecfUrano') then begin
      vVlUnitario := StrToFloatDef(ValorUnitario, 0);
      ValorUnitario := FloatToStr(vVlUnitario);
      vDsCodAliquota := '';
      if trim(Aliquota) = 'NN' then
        vDsCodAliquota := '-4'
      else if trim(Aliquota) = 'II' then
        vDsCodAliquota := '-3'
      else if trim(Aliquota) = 'FF' then
        vDsCodAliquota := '-2'
      else begin
        vVlAliquota := StrToFloatDef(Aliquota, 0);
        if (vVlAliquota > 0) then begin
          vVlAliquota := vVlAliquota / 100;
          Aliquota := FloatToStr(vVlAliquota);
        end;
      end;

      // se a aliquota for :  Não tributado (NN), Isento (II) ou Subst. Tributária (FF), deve ser movido o indice em vez de mover a aliquota
      if (vDsCodAliquota <> '') then begin
        result := DLLG2_ExecutaComando(Handle, 'VendeItem;CodAliquota=' + vDsCodAliquota + ' CodProduto=' + '"' + Codigo + '"' + ' NomeProduto=' + '"' + Copy(Descricao,1,30) + '"' + ' PrecoUnitario=' + ValorUnitario + ' Quantidade=' + Quantidade + ' Unidade=' + '"' + unidade + '";')
      end else begin
        result := DLLG2_ExecutaComando(Handle, 'VendeItem;AliquotaICMS=true CodProduto=' + '"' + Codigo + '"' + ' NomeProduto=' + '"' + Copy(Descricao,1,30) + '"' + ' PercentualAliquota=' + Aliquota + ' PrecoUnitario=' + ValorUnitario + ' Quantidade=' + Quantidade + ' Unidade=' + '"' + unidade + '";');
      end;

      if retornoImpressoraErro(vModeloEcf, result) then Exit;

      // o desconto por item na Interway é um comando a parte
      if trim(Desconto) <> '' then begin
        Desconto := AnsiReplaceStr(Desconto, '.', ',');
        vVlDesconto := StrToFloatDef(Desconto, 0);
        if (vVlDesconto > 0) then begin
          vVlDesconto := vVlDesconto * -1;
          result := DLLG2_ExecutaComando(Handle, 'AcresceItemFiscal;Cancelar=false ValorAcrescimo=' + FloatToStr(vVlDesconto));
        end;
      end;
    end  else if (vModeloEcf = 'ecfDaruma') then begin
      result := iCFVender_ECF_Daruma(Aliquota, Quantidade, PChar(ValorUnitario), 'D' + TipoDesconto, Desconto, Codigo, Unidade, Descricao);
    end else if (vModeloEcf = 'ecfSweda') then begin
      if (StrToFloat(Desconto) >= 0) then begin
        result := ECF_VendeItem(PChar(Codigo), PChar(Descricao), PChar(Aliquota),
                  PChar(TipoQuantidade), PChar(Quantidade), StrToIntDef(CasasDecimais, 0), PChar(ValorUnitario),
                  PChar(TipoDesconto), PChar(Desconto));
      end else begin
        result := ECF_VendeItem(PChar(Codigo), PChar(Descricao), PChar(Aliquota),
                  PChar(TipoQuantidade), PChar(Quantidade), StrToIntDef(CasasDecimais, 0), PChar(ValorUnitario),
                  PChar(TipoDesconto), PChar(0));
        Desconto := FloatToStr(strtofloat(desconto) * (-1));
        Result  := acrescimoDescontoItem(vModeloEcf, PChar(Item), 'A', TipoDesconto, PChar(Desconto));
      end;
    end else if (vModeloEcf = 'ecfEpson') then begin
      ValorUnitario := ReplaceStr(ValorUnitario, ',','');
      Quantidade := FormatFloat(', 0.000', StrToFloatDef(Quantidade, 0));
      Quantidade := ReplaceStr(Quantidade, '.','');
      Quantidade := ReplaceStr(Quantidade, ',','');
      Quantidade := Trim(Quantidade);
      vCasasDecimaisQt := 3;

      vAliquotaTeste  :=  LeIni('ALIQUOTA_TESTE','');
      if vAliquotaTeste <> '' then begin
        aliquota := vAliquotaTeste; //liberar este campo quando em Debug com o Emulador
      end;

      result := EPSON_Fiscal_Vender_Item(PChar(Codigo), PChar(Descricao), PChar(Quantidade), vCasasDecimaisQt, PChar(Unidade), PChar(ValorUnitario), 2, PChar(Aliquota), 1);
      if trim(Desconto) <> '' then begin
        Desconto := ReplaceStr(Desconto, '.','');
        Desconto := ReplaceStr(Desconto, ',','');
        vVlDesconto := StrToFloatDef(Desconto, 0);
        if (vVlDesconto > 0) then begin
          result := EPSON_Fiscal_Desconto_Acrescimo_Item(PChar(Desconto), 2, True, False);
        end else
        if (vVlDesconto < 0) then begin
          Desconto :=  FloatToStr(vVlDesconto * (-1));
          result := EPSON_Fiscal_Desconto_Acrescimo_Item(PChar(Desconto), 2, False, False);
        end;

      end;
    end;
  except
    on E : Exception do ShowMessage(E.Message);
  end;
end;

function vendeItemDepartamento(vModeloEcf : String; Codigo : String; Descricao : String; Aliquota : String; ValorUnitario : String; Quantidade : String; Acrescimo : String; Desconto : String; IndiceDepartamento : String; UnidadeMedida : String) : Integer;
begin
  try
    if (vModeloEcf = 'ecfBematech') then begin
      result := Bematech_FI_VendeItemDepartamento(PChar(Codigo), PChar(Descricao), PChar(Aliquota), PChar(ValorUnitario), PChar(Quantidade), PChar(Acrescimo),
                                                  PChar(Desconto), PChar(IndiceDepartamento), PChar(UnidadeMedida));
    end else if (vModeloEcf = 'ecfElgin') then begin
      result := Elgin_VendeItemDepartamento(PChar(Codigo), PChar(Descricao), PChar(Aliquota), PChar(ValorUnitario), PChar(Quantidade), PChar(Acrescimo),
                                            PChar(Desconto), PChar(IndiceDepartamento), PChar(UnidadeMedida));
    end else if (vModeloEcf = 'ecfInterway') or (vModeloEcf = 'ecfUrano') then begin

    end else if (vModeloEcf = 'ecfDaruma') then begin

    end else if (vModeloEcf = 'ecfSweda') then begin
      result := ECF_VendeItemDepartamento(PChar(Codigo), PChar(Descricao), PChar(Aliquota), PChar(ValorUnitario), PChar(Quantidade), PChar(Acrescimo),
                                          PChar(Desconto), PChar(IndiceDepartamento), PChar(UnidadeMedida));
    end;
  except
    on E : Exception do ShowMessage(E.Message);
  end;
end;

function acrescimoDescontoCupom(vModeloEcf : String; AcrescimoDesconto : String; TipoAcrescimoDesconto : String; ValorAcrescimoDesconto : String) : Integer; //Inicial Fechamento do Cupom
var
  vResult, vTpFormatoAcrescDesc : string;
      vVlDesconto : Real;
begin
  try
    if (vModeloEcf = 'ecfBematech') or (vModeloEcf = 'ecfYanco') then begin
      result := Bematech_FI_IniciaFechamentoCupom(AcrescimoDesconto, TipoAcrescimoDesconto, ValorAcrescimoDesconto);
    end else if (vModeloEcf = 'ecfElgin') then begin
      if Trim(ValorAcrescimoDesconto) = '' then ValorAcrescimoDesconto := '0';
      // a ECF Elgin, dava erro caso envia-se o acrescimo ou desconto zerado
      if (StrToFloatDef(ValorAcrescimoDesconto, 0) > 0) then
        result := Elgin_AcrescimoDescontoSubtotalMFD(AcrescimoDesconto, TipoAcrescimoDesconto, ValorAcrescimoDesconto)
    end else if (vModeloEcf = 'ecfInterway') then begin
      if Trim(ValorAcrescimoDesconto) = '' then ValorAcrescimoDesconto := '0';
      // a ECF Interway, dava erro caso envia-se o acrescimo ou desconto zerado
      if (StrToFloatDef(ValorAcrescimoDesconto, 0) > 0) then
        result := DLLG2_ExecutaComando(Handle, 'AcresceSubtotal;Cancelar=false;ValorAcrescimo=' + ValorAcrescimoDesconto);
    end else if (vModeloEcf = 'ecfUrano') then begin
      if trim(ValorAcrescimoDesconto) <> '' then begin
        ValorAcrescimoDesconto := AnsiReplaceStr(ValorAcrescimoDesconto, '.', ',');
      end;

      vVlDesconto := StrToFloatDef(ValorAcrescimoDesconto, 0);
      if AcrescimoDesconto = 'D' then begin
        if (vVlDesconto > 0) then begin
          vVlDesconto := vVlDesconto * -1;
        end;
      end;

      if (StrToFloatDef(ValorAcrescimoDesconto, 0) > 0) then begin
        result := DLLG2_ExecutaComando(Handle, 'AcresceSubtotal;Cancelar=false ValorAcrescimo=' + FloatToStr(vVlDesconto));
      end;
    end else if (vModeloEcf = 'ecfDaruma') then begin
      result := iCFTotalizarCupom_ECF_Daruma(AcrescimoDesconto+TipoAcrescimoDesconto, ValorAcrescimoDesconto)
    end else if (vModeloEcf = 'ecfSweda') then begin
      if StrTofloatDef(ValorAcrescimoDesconto,0) < 0 then begin
        ValorAcrescimoDesconto := FloatToStr(StrTofloatDef(ValorAcrescimoDesconto,0) * (-1));
        ValorAcrescimoDesconto := FloatToStr(StrTofloatDef(ValorAcrescimoDesconto,0) * 100);
      end;
      result := ECF_AcrescimoDescontoSubtotalMFD(PChar(AcrescimoDesconto),PChar(TipoAcrescimoDesconto), PChar(ValorAcrescimoDesconto));
    end else if (vModeloEcf = 'ecfEpson') then begin
      if ValorAcrescimoDesconto = '' then begin
        ValorAcrescimoDesconto := '0';
      end;

      ValorAcrescimoDesconto := FormatFloat('0.000', StrToFloatDef(ValorAcrescimoDesconto, 0));
      ValorAcrescimoDesconto := AnsiReplaceStr(ValorAcrescimoDesconto, ',', '');
      ValorAcrescimoDesconto := AnsiReplaceStr(ValorAcrescimoDesconto, '.', '');

      if (ValorAcrescimoDesconto <> '') and ((StrToFloat(ValorAcrescimoDesconto) <> 0)) then begin
        if (AcrescimoDesconto = 'A') then // Acréscimo
          result := EPSON_Fiscal_Desconto_Acrescimo_Subtotal(PAChar(ValorAcrescimoDesconto),3,False,False)
        else
          result := EPSON_Fiscal_Desconto_Acrescimo_Subtotal(pAChar(ValorAcrescimoDesconto),3,True,False);
      end;

    end;
  except
    on E : Exception do ShowMessage(E.Message);
  end; 
end; 

function efetuaFormaPagamento(vModeloEcf : String; FormaPagamento : String; ValorFormaPagamento : String) : Integer; 
begin
  try
    if (vModeloEcf = 'ecfBematech') or (vModeloEcf = 'ecfYanco') then begin
      result := Bematech_FI_EfetuaFormaPagamento(FormaPagamento, ValorFormaPagamento); 
    end else if (vModeloEcf = 'ecfElgin') then begin
      result := Elgin_EfetuaFormaPagamento(FormaPagamento, ValorFormaPagamento); 
    end else if (vModeloEcf = 'ecfInterway') or (vModeloEcf = 'ecfUrano') then begin
      // a ECF Interway, não reconhece a String "Dinheiro" que é pré cadastrada
      // para a condição pré cadastrada, tem que enviar o indice
      if Trim(FormaPagamento) = 'Dinheiro' then
        result := DLLG2_ExecutaComando(Handle, 'PagaCupom;CodMeioPagamento=-2 Valor=' + ValorFormaPagamento)
      else
        result := DLLG2_ExecutaComando(Handle, 'PagaCupom;NomeMeioPagamento=' + '"' + FormaPagamento + '"' + ' Valor=' + ValorFormaPagamento);
    end else if (vModeloEcf = 'ecfDaruma') then begin
      ValorFormaPagamento := FormatFloat('0000000000.00', StrToFloatDef(ValorFormaPagamento, 0));
      result := iCFEfetuarPagamentoFormatado_ECF_Daruma(FormaPagamento, ValorFormaPagamento);
    end else if (vModeloEcf = 'ecfSweda') then begin
      result := ECF_EfetuaFormaPagamento(PChar(FormaPagamento), PChar(ValorFormaPagamento));
    end else if (vModeloEcf = 'ecfEpson') then begin
      ValorFormaPagamento := ReplaceStr(ValorFormaPagamento, '.','');
      ValorFormaPagamento := ReplaceStr(ValorFormaPagamento, ',','');
      result := EPSON_Fiscal_Pagamento(PChar(FormaPagamento), PChar(ValorFormaPagamento), 2, '','');
    end;
  except
    on E : Exception do ShowMessage(E.Message);
  end;
end;

function fechaCupom(vModeloEcf : String; MensagemPromocional : String) : Integer;
var
  vLinha1, vLinha2, vLinha3, vLinha4, vLinha5, vLinha6, vLinha7, vLinha8 : String;
  vstLista : TStringList;
  i : Integer;
  vResult  : string;
begin
  try
    if (vModeloEcf = 'ecfBematech') or (vModeloEcf = 'ecfYanco') then begin
      result := Bematech_FI_TerminaFechamentoCupom(MensagemPromocional);
    end else if (vModeloEcf = 'ecfElgin') then begin
      result := Elgin_TerminaFechamentoCupom(MensagemPromocional);
    end else if (vModeloEcf = 'ecfInterway') or (vModeloEcf = 'ecfUrano') then begin
      if trim(MensagemPromocional) = '' then begin
        result := DLLG2_ExecutaComando(Handle, 'EncerraDocumento')
      end else begin
        result := DLLG2_ExecutaComando(Handle, 'EncerraDocumento;TextoPromocional=' + '"' + MensagemPromocional + '"');
      end;
    end else if (vModeloEcf = 'ecfDaruma') then begin
      result := iCFEncerrar_ECF_Daruma('0', MensagemPromocional);
    end else if (vModeloEcf = 'ecfSweda') then begin
      result := ECF_TerminaFechamentoCupom(PChar(MensagemPromocional));
    end else if (vModeloEcf = 'ecfEpson') then begin
      if trim(MensagemPromocional) <> '' then begin
        try
          vstLista := TStringList.Create;
          vstLista.Text := MensagemPromocional;
          for i := 0 to vstLista.Count - 1 do begin
            case i of
              0 : vLinha1 := vstLista[i];
              1 : vLinha2 := vstLista[i];
              2 : vLinha3 := vstLista[i];
              3 : vLinha4 := vstLista[i];
              4 : vLinha5 := vstLista[i];
              5 : vLinha6 := vstLista[i];
              6 : vLinha7 := vstLista[i];
              7 : vLinha8 := vstLista[i];
            end;
          end;
        finally
          vstLista.Free;
        end;

        result := EPSON_Fiscal_Imprimir_Mensagem(PChar(vLinha1), PChar(vLinha2), PChar(vLinha3), PChar(vLinha4), PChar(vLinha5), PChar(vLinha6), PChar(vLinha7), PChar(vLinha8));
      end;
      result := EPSON_Fiscal_Fechar_Cupom(True, False);
    end;
  except
    on E : Exception do ShowMessage(E.Message);
  end;
end; 

function cancelaItem(vModeloEcf : String; Indice : String) : Integer; 
begin
  try
    if (vModeloEcf = 'ecfBematech') or (vModeloEcf = 'ecfYanco') then begin
      result := Bematech_FI_CancelaItemGenerico(Indice); 
    end else if (vModeloEcf = 'ecfElgin') then begin
      result := Elgin_CancelaItemGenerico(Indice); 
    end else if (vModeloEcf = 'ecfInterway') or (vModeloEcf = 'ecfUrano') then begin
      result := DLLG2_ExecutaComando(Handle, 'CancelaItemFiscal'); 
    end else if (vModeloEcf = 'ecfDaruma') then begin
      result := iCFCancelarItem_ECF_Daruma(Indice);
    end else if (vModeloEcf = 'ecfSweda') then begin
      result := ECF_CancelaItemGenerico(Indice); 
    end else if (vModeloEcf = 'ecfEpson') then begin
      result := EPSON_Fiscal_Cancelar_Item(PChar(Indice)); 
    end; 
  except
    on E : Exception do ShowMessage(E.Message); 
  end; 
end; 

function leituraMemoriaFiscalPorDatas(vModeloEcf : String; DataIni : String; DataFim : String) : Integer; 
var
  vDados,vResult    : String;
  vTamanhoBuffer, i : Integer;
begin
  try
    if (vModeloEcf = 'ecfBematech') or (vModeloEcf = 'ecfYanco') then begin
      result := Bematech_FI_LeituraMemoriaFiscalData(PChar(DataIni), PChar(DataFim));
    end else if (vModeloEcf = 'ecfElgin') then begin
      result := Elgin_LeituraMemoriaFiscalData(DataIni, DataFim, 's');
    end else if (vModeloEcf = 'ecfInterway')  then begin
      result := DLLG2_ExecutaComando(Handle, 'EmiteLeituraMF;DataFinal=#' + DataFim + '#;DataInicial=#' + DataIni + '#;Destino="I";LeituraSimplificada=true');
    end else if (vModeloEcf = 'ecfUrano') then begin
      result := DLLG2_ExecutaComando(Handle, 'EmiteLeituraMF;DataFinal=#' + DataFim + '# DataInicial=#' + DataIni + '# Destino="I" LeituraSimplificada=false');
    end else if (vModeloEcf = 'ecfDaruma') then begin
      result := regAlterarValor_Daruma('ECF\LMFCOMPLETA','1'); 
      result :=  iMFLer_ECF_Daruma(DataIni, DataFim); 
    end else if (vModeloEcf = 'ecfSweda') then begin
      result := ECF_LeituraMemoriaFiscalData(PChar(DataIni), PChar(DataFim)); 
    end else if (vModeloEcf = 'ecfEpson') then begin
      SetLength(vDados, 10000); 
      vTamanhoBuffer := 0;
      result := EPSON_RelatorioFiscal_Leitura_MF(PChar(DataIni), PChar(DataFim), 5, PChar(vDados), '', @vTamanhoBuffer, 10000); 
    end; 
  except
    on E : Exception do ShowMessage(E.Message); 
  end; 
end; 

function leituraMemoriaFiscalPorDatasMFD(vModeloEcf : String; DataIni : String; DataFim : String; Tipo : String) : Integer; 
var
  vDados, vDsResult : String;
  vTamanhoBuffer, i : Integer;
begin
  try
    if (vModeloEcf = 'ecfBematech') or (vModeloEcf = 'ecfYanco') then begin
      result := Bematech_FI_LeituraMemoriaFiscalDataMFD(PChar(DataIni), PChar(DataFim), PChar(Tipo));
    end else if (vModeloEcf = 'ecfElgin') then begin
      result := Elgin_LeituraMemoriaFiscalData(PChar(DataIni), PChar(DataFim), PChar(Tipo));
    end else if (vModeloEcf = 'ecfInterway') then begin
      if (LowerCase(Tipo) = 's') then
        result := DLLG2_ExecutaComando(Handle, 'EmiteLeituraMF;DataFinal=#' + DataFim + '#;DataInicial=#' + DataIni + '#;Destino="I";LeituraSimplificada=true')
      else
        result := DLLG2_ExecutaComando(Handle, 'EmiteLeituraMF;DataFinal=#' + DataFim + '#;DataInicial=#' + DataIni + '#;Destino="I";LeituraSimplificada=false')
    end else if (vModeloEcf = 'ecfUrano') then begin
      if (LowerCase(Tipo) = 's') then
        result := DLLG2_ExecutaComando(Handle, 'EmiteLeituraMF;DataFinal=#' + DataFim + '# DataInicial=#' + DataIni + '# Destino="I" LeituraSimplificada=true')
      else
        result := DLLG2_ExecutaComando(Handle, 'EmiteLeituraMF;DataFinal=#' + DataFim + '# DataInicial=#' + DataIni + '# Destino="I" LeituraSimplificada=false');
    end else if (vModeloEcf = 'ecfDaruma') then begin
      if (LowerCase(Tipo) = 's') then
        result := regAlterarValor_Daruma('ECF\LMFCOMPLETA','0')
      else
        result := regAlterarValor_Daruma('ECF\LMFCOMPLETA','1');
      result := iMFLer_ECF_Daruma(DataIni, DataFim);
    end else if (vModeloEcf = 'ecfSweda') then begin
      result := ECF_LeituraMemoriaFiscalDataMFD(PChar(DataIni), PChar(DataFim), PChar(Tipo));
    end else if (vModeloEcf = 'ecfEpson') then begin
      SetLength(vDados, 10000);
      vTamanhoBuffer := 0;
      DataIni := AnsiReplaceStr(DataIni, '/', '');
      DataFim := AnsiReplaceStr(DataFim, '/', '');
      result := EPSON_RelatorioFiscal_Leitura_MF(PChar(DataIni), PChar(DataFim), 7, PChar(vDados), '', @vTamanhoBuffer, 10000);
    end; 
  except
    on E : Exception do ShowMessage(E.Message);
  end;
end;

function leituraMemoriaFiscalSerialPorDatasMFD(vModeloEcf : String; DataIni : String; DataFim : String; Tipo : String) : Integer;
var
  F : TextFile;
  vDados, vDsResult, vArquivo, vDsConteudo, vDsLinha : String;
  vTamanhoBuffer, i : Integer;
  //vInVazio : Integer;
begin
  try
    if (vModeloEcf = 'ecfBematech') or (vModeloEcf = 'ecfYanco') then begin
      result := Bematech_FI_LeituraMemoriaFiscalSerialDataMFD(PChar(DataIni), PChar(DataFim), PChar(Tipo));
    end else if (vModeloEcf = 'ecfElgin') then begin
      result := Elgin_LeituraMemoriaFiscalSerialData(PChar(DataIni), PChar(DataFim), PChar(Tipo));
    end else if (vModeloEcf = 'ecfInterway') then begin
      if (LowerCase(Tipo) = 's') then
        result := DLLG2_ExecutaComando(Handle, 'EmiteLeituraMF;DataFinal=#' + DataFim + '#;DataInicial=#' + DataIni + '#;Destino="S";LeituraSimplificada=true')
      else
        result := DLLG2_ExecutaComando(Handle, 'EmiteLeituraMF;DataFinal=#' + DataFim + '#;DataInicial=#' + DataIni + '#;Destino="S";LeituraSimplificada=false');

      // o comando LeImpressao, retorna no máximo 4000 bytes, portanto
      // deve fazer o laço enviando o comando até que seja retornado todas as respostas do comando : EmiteLeituraFitaDetalhe
      repeat
        iRetorno := DLLG2_ExecutaComando(Handle, 'LeImpressao');
        vDsLinha := DLLG2_ObtemRetornos(Handle, vDsLinha, 0);
        vDsLinha := fRetornaValor(vDsLinha, 'TextoImpressao','"');
        vDsConteudo := vDsConteudo + vDsLinha;
      until (vDsLinha = '');
      vArquivo := getPathECF() + 'RETORNO.TXT';
      GravarArqBin(vArquivo, vDsConteudo);
    end else if  (vModeloEcf = 'ecfUrano') then begin
      if (LowerCase(Tipo) = 's') then
        result := DLLG2_ExecutaComando(Handle, 'EmiteLeituraMF;DataFinal=#' + DataFim + '# DataInicial=#' + DataIni + '# Destino="S" LeituraSimplificada=true')
      else
        result := DLLG2_ExecutaComando(Handle, 'EmiteLeituraMF;DataFinal=#' + DataFim + '# DataInicial=#' + DataIni + '# Destino="S" LeituraSimplificada=false');

      if retornoImpressoraErro(vModeloEcf, result) then Exit;

      // o comando LeImpressao, retorna no máximo 4000 bytes, portanto
      // deve fazer o laço enviando o comando até que seja retornado todas as respostas do comando : EmiteLeituraFitaDetalhe
      repeat
        iRetorno := DLLG2_ExecutaComando(Handle, 'LeImpressao');
        vDsLinha := DLLG2_ObtemRetornos(Handle, vDsLinha, 0);
        vDsLinha := fRetornaValor(vDsLinha, 'TextoImpressao','"');
        vDsConteudo := vDsConteudo + vDsLinha;
      until (vDsLinha = '');
      vArquivo := getPathECF() + 'RETORNO.TXT';
      GravarArqBin(vArquivo, vDsConteudo);
    end else if (vModeloEcf = 'ecfDaruma') then begin
      if (LowerCase(Tipo) = 's') then
        regAlterarValor_Daruma('ECF\LMFCOMPLETA','0')
      else
        regAlterarValor_Daruma('ECF\LMFCOMPLETA','1');
      result := iMFLerSerial_ECF_Daruma(DataIni, DataFim);
    end else if (vModeloEcf = 'ecfSweda') then begin
      result := ECF_LeituraMemoriaFiscalSerialDataMFD(PChar(DataIni), PChar(DataFim), PChar(Tipo));
    end else if (vModeloEcf = 'ecfEpson') then begin
      SetLength(vDados, 10000);
      vTamanhoBuffer := 0;
      result := EPSON_RelatorioFiscal_Leitura_MF(PChar(DataIni), PChar(DataFim), 7, PChar(vDados), '', @vTamanhoBuffer, 10000);
    end;
  except
    on E : Exception do ShowMessage(E.Message);
  end;
end;

function leituraMemoriaFiscalPorReducoes(vModeloEcf : String; RedIni : String; RedFim : String) : Integer;
var
  vDados,vDsResult  : String;
  vTamanhoBuffer, i : Integer;
begin
  try
    if (vModeloEcf = 'ecfBematech') or (vModeloEcf = 'ecfYanco') then begin
      result := Bematech_FI_LeituraMemoriaFiscalReducao(PChar(RedIni), PChar(RedFim));
    end else if (vModeloEcf = 'ecfElgin') then begin
      result := Elgin_LeituraMemoriaFiscalReducao(RedIni, RedFim, 's'); // s = simplificada
    end else if (vModeloEcf = 'ecfInterway')then begin
      result := DLLG2_ExecutaComando(Handle, 'EmiteLeituraMF;Destino="I";LeituraSimplificada=true;ReducaoFinal=' + RedFim + ';ReducaoInicial=' + RedIni);
    end else if(vModeloEcf = 'ecfUrano') then begin
      result := DLLG2_ExecutaComando(Handle, 'EmiteLeituraMF;Destino="I" LeituraSimplificada=false ReducaoFinal=' + RedFim + ' ReducaoInicial=' + RedIni);
    end else if (vModeloEcf = 'ecfDaruma') then begin
      regAlterarValor_Daruma('ECF\LMFCompleta','0'); // simplificada
      result := iMFLer_ECF_Daruma(RedIni, RedFim); 
    end else if (vModeloEcf = 'ecfSweda') then begin
      result := ECF_LeituraMemoriaFiscalReducao(PChar(RedIni), PChar(RedFim)); 
    end else if (vModeloEcf = 'ecfEpson') then begin
      SetLength(vDados, 10000);
      vTamanhoBuffer := 0;
      result := EPSON_RelatorioFiscal_Leitura_MF(PChar(RedIni), PChar(RedFim), 4, PChar(vDados), '', @vTamanhoBuffer, 10000);
    end;
  except
    on E : Exception do ShowMessage(E.Message);
  end;
end;

function leituraMemoriaFiscalPorReducoesMFD(vModeloEcf : String; RedIni : String; RedFim : String; Tipo : String) : Integer;
var
  vDados, vDsResult : String;
  vTamanhoBuffer,i  : Integer;
begin
  try
    if (vModeloEcf = 'ecfBematech') or (vModeloEcf = 'ecfYanco') then begin
      result := Bematech_FI_LeituraMemoriaFiscalReducaoMFD(PChar(RedIni), PChar(RedFim), PChar(Tipo));
    end else if (vModeloEcf = 'ecfElgin') then begin

    end else if (vModeloEcf = 'ecfInterway') then begin
      if (LowerCase(Tipo) = 's') then
        result := DLLG2_ExecutaComando(Handle, 'EmiteLeituraMF;Destino="I";LeituraSimplificada=true;ReducaoFinal=' + RedFim + ';ReducaoInicial=' + RedIni)
      else
        result := DLLG2_ExecutaComando(Handle, 'EmiteLeituraMF;Destino="I";LeituraSimplificada=false;ReducaoFinal=' + RedFim + ';ReducaoInicial=' + RedIni);
    end else if (vModeloEcf = 'ecfUrano') then begin
      if (LowerCase(Tipo) = 's') then
        result := DLLG2_ExecutaComando(Handle, 'EmiteLeituraMF;Destino="I" LeituraSimplificada=true ReducaoFinal=' + RedFim + ' ReducaoInicial=' + RedIni)
      else
        result := DLLG2_ExecutaComando(Handle, 'EmiteLeituraMF;Destino="I" LeituraSimplificada=false ReducaoFinal=' + RedFim + ' ReducaoInicial=' + RedIni);
    end else if (vModeloEcf = 'ecfDaruma') then begin
      if (LowerCase(Tipo) = 's') then
        regAlterarValor_Daruma('ECF\LMFCOMPLETA','0')
      else
        regAlterarValor_Daruma('ECF\LMFCOMPLETA','1');
      result := iMFLer_ECF_Daruma(RedIni, RedFim);
    end else if (vModeloEcf = 'ecfSweda') then begin
      result := ECF_LeituraMemoriaFiscalReducaoMFD(PChar(RedIni), PChar(RedFim), PChar(Tipo));
    end else if (vModeloEcf = 'ecfEpson') then begin
      SetLength(vDados, 10000);
      vTamanhoBuffer := 0;
      if (LowerCase(Tipo) = 's') then
        result := EPSON_RelatorioFiscal_Leitura_MF(PChar(RedIni), PChar(RedFim), 6, PChar(vDados), '', @vTamanhoBuffer, 10000)
      else
        result := EPSON_RelatorioFiscal_Leitura_MF(PChar(RedIni), PChar(RedFim), 4, PChar(vDados), '', @vTamanhoBuffer, 10000);
    end;
  except
    on E : Exception do ShowMessage(E.Message);
  end;
end;

function leituraMemoriaFiscalSerialPorReducoesMFD(vModeloEcf : String; RedIni : String; RedFim : String; Tipo : String) : Integer;
var
  F : TextFile;
  vDados, vDsResult, vArquivo, vDsConteudo, vDsLinha : String;
  vTamanhoBuffer, i : Integer;
begin
  try
    if (vModeloEcf = 'ecfBematech') or (vModeloEcf = 'ecfYanco') then begin
      result := Bematech_FI_LeituraMemoriaFiscalSerialReducaoMFD(PChar(RedIni), PChar(RedFim), PChar(Tipo));
    end else if (vModeloEcf = 'ecfElgin') then begin

    end else if (vModeloEcf = 'ecfInterway') then begin
      if (LowerCase(Tipo) = 's') then
        result := DLLG2_ExecutaComando(Handle, 'EmiteLeituraMF;Destino="S";LeituraSimplificada=true;ReducaoFinal=' + RedFim + ';ReducaoInicial=' + RedIni)
      else
        result := DLLG2_ExecutaComando(Handle, 'EmiteLeituraMF;Destino="S";LeituraSimplificada=false;ReducaoFinal=' + RedFim + ';ReducaoInicial=' + RedIni);

      if retornoImpressoraErro(vModeloEcf, result) then Exit;

      // o comando LeImpressao, retorna no máximo 4000 bytes, portanto
      // deve fazer o laço enviando o comando até que seja retornado todas as respostas do comando : EmiteLeituraFitaDetalhe
      repeat
        iRetorno := DLLG2_ExecutaComando(Handle, 'LeImpressao');
        vDsLinha := DLLG2_ObtemRetornos(Handle, vDsLinha, 0);
        vDsLinha := fRetornaValor(vDsLinha, 'TextoImpressao','"');
        vDsConteudo := vDsConteudo + vDsLinha;
      until (vDsLinha = '');
      vArquivo := getPathECF() + 'RETORNO.TXT';
      GravaIni(vArquivo, vDsConteudo);
    end else if (vModeloEcf = 'ecfUrano') then begin
      if (LowerCase(Tipo) = 's') then
        result := DLLG2_ExecutaComando(Handle, 'EmiteLeituraMF;Destino="S" LeituraSimplificada=true ReducaoFinal=' + RedFim + ' ReducaoInicial=' + RedIni)
      else
        result := DLLG2_ExecutaComando(Handle, 'EmiteLeituraMF;Destino="S" LeituraSimplificada=false ReducaoFinal=' + RedFim + ' ReducaoInicial=' + RedIni);

      if retornoImpressoraErro(vModeloEcf, result) then Exit;

      // o comando LeImpressao, retorna no máximo 4000 bytes, portanto
      // deve fazer o laço enviando o comando até que seja retornado todas as respostas do comando : EmiteLeituraFitaDetalhe
      repeat
        iRetorno := DLLG2_ExecutaComando(Handle, 'LeImpressao');
        vDsLinha := DLLG2_ObtemRetornos(Handle, vDsLinha, 0);
        vDsLinha := fRetornaValor(vDsLinha, 'TextoImpressao','"');
        vDsConteudo := vDsConteudo + vDsLinha;
      until (vDsLinha = '');
      vArquivo := getPathECF() + 'RETORNO.TXT';
      GravaIni(vArquivo, vDsConteudo);
    end else if (vModeloEcf = 'ecfDaruma') then begin
      if (LowerCase(Tipo) = 's') then
        regAlterarValor_Daruma('ECF\MFDCompleta','0')
      else
        regAlterarValor_Daruma('ECF\MFDCompleta','1');

      result := iMFLerSerial_ECF_Daruma(RedIni, RedFim);
    end else if (vModeloEcf = 'ecfSweda') then begin
      result := ECF_LeituraMemoriaFiscalSerialReducaoMFD(PChar(RedIni), PChar(RedFim), PChar(Tipo));
    end else if (vModeloEcf = 'ecfEpson') then begin
      SetLength(vDados, 10000);
      vTamanhoBuffer := 0;
      if (LowerCase(Tipo) = 's') then
        result := EPSON_RelatorioFiscal_Leitura_MF(PChar(RedIni), PChar(RedFim), 6, PChar(vDados), '', @vTamanhoBuffer, 10000)
      else
        result := EPSON_RelatorioFiscal_Leitura_MF(PChar(RedIni), PChar(RedFim), 4, PChar(vDados), '', @vTamanhoBuffer, 10000);
    end;
  except
    on E : Exception do ShowMessage(E.Message);
  end;
end;

function relatorioTipo60Mestre(vModeloEcf : String) : Integer;
var
  vDsArquivo, vDsData, vDsNumeroSerie, vDsLoja : String;
  vDsNrUltimaReduz, vDsCOOInicio, vDsCOOReducao, vDsReinicioOperacao : String;
  vDsVlVendaBruta, vDsVlGT, vDadosRZ, vDtUltMovimento, vPathECF, vLastRZData, vDsDadosImpressora : String;
  vVBatual, vVBanterior : String;
  vValor : Currency;
  F : TextFile;
  vDsArq : TStringList;
  vLinha : String;
  iConta : Integer;
begin
  try
    if (vModeloEcf = 'ecfBematech') or (vModeloEcf = 'ecfYanco') then begin
      result := Bematech_FI_RelatorioTipo60Mestre();
    end else if (vModeloEcf = 'ecfElgin') then begin
      result := Elgin_RelatorioTipo60Mestre();
    end else if (vModeloEcf = 'ecfInterway') or (vModeloEcf = 'ecfUrano') then begin
      try
        // pego a data da ECF
        DLLG2_ExecutaComando(Handle, 'LeData;NomeData="Data"');
        vDsData := DLLG2_ObtemRetornos(Handle, vDsData, 0);
        vDsData := fRetornaValor(vDsData, 'ValorData','#');
        vDsData := FormatDateTime('DD/MM/YYYY', StrToDate(vDsData));

        // pego o número de série da ECF
        DLLG2_ExecutaComando(Handle, 'LeTexto;NomeTexto="NumeroSerieECF"');
        vNrSerie := DLLG2_ObtemRetornos(Handle,vDsNumeroSerie,0 );
        vNrSerie := fRetornaValor(vNrSerie, 'ValorTexto','"');

        // pego o número da loja
        DLLG2_ExecutaComando(Handle, 'LeInteiro;NomeInteiro="Loja"');
        vDsLoja := DLLG2_ObtemRetornos(Handle, vDsLoja, 0);
        vDsLoja := fRetornaValor(vDsLoja, 'ValorInteiro','');
        if trim(vDsLoja) = '' then vDsLoja := '0';

        // pego o número do primeiro COO do dia
        DLLG2_ExecutaComando(Handle, 'LeInteiro;NomeInteiro="COOInicioDia"');
        vDsCOOInicio := DLLG2_ObtemRetornos(Handle, vDsCOOInicio, 0);
        vDsCOOInicio := fRetornaValor(vDsCOOInicio, 'ValorInteiro','');
        if trim(vDsCOOInicio) = '' then vDsCOOInicio := '0';

        // pego o número do contador de redução
        DLLG2_ExecutaComando(Handle, 'LeInteiro;NomeInteiro="CRZ"');
        vDsNrUltimaReduz := DLLG2_ObtemRetornos(Handle, vDsNrUltimaReduz, 0);
        vDsNrUltimaReduz := fRetornaValor(vDsNrUltimaReduz, 'ValorInteiro','');
        if trim(vDsNrUltimaReduz) = '' then vDsNrUltimaReduz := '0';

        // pego o COO da ultima redução
        DLLG2_ExecutaComando(Handle, 'LeInteiro;NomeInteiro="COOReducao[' + vDsNrUltimaReduz + ']"');
        vDsCOOReducao := DLLG2_ObtemRetornos(Handle, vDsCOOReducao, 0);
        vDsCOOReducao := fRetornaValor(vDsCOOReducao, 'ValorInteiro','');
        if trim(vDsCOOReducao) = '' then vDsCOOReducao := '0';

        // pego o contador de reinicio de Operação
        DLLG2_ExecutaComando(Handle, 'LeInteiro;NomeInteiro="ContadorReinicioReducao[' + vDsNrUltimaReduz + ']"');
        vDsReinicioOperacao := DLLG2_ObtemRetornos(Handle, vDsReinicioOperacao, 0);
        vDsReinicioOperacao := fRetornaValor(vDsReinicioOperacao, 'ValorInteiro','');
        if trim(vDsReinicioOperacao) = '' then vDsReinicioOperacao := '0';

        // pego o valor da venda bruta da ultima redução
        DLLG2_ExecutaComando(Handle, 'LeMoeda;NomeDadoMonetario="VendaBrutaReducao[' + vDsNrUltimaReduz + ']"');
        vDsVlVendaBruta := DLLG2_ObtemRetornos(Handle, vDsVlVendaBruta, 0);
        vDsVlVendaBruta := fRetornaValor(vDsVlVendaBruta, 'ValorMoeda','');
        vDsVlVendaBruta := AnsiReplaceStr(vDsVlVendaBruta, '.', '');
        if trim(vDsVlVendaBruta) = '' then vDsVlVendaBruta := '0';

        // pego o valor do GT (grande total ou totalizador geral).
        DLLG2_ExecutaComando(Handle, 'LeMoeda;NomeDadoMonetario="GT"');
        vDsVlGT := DLLG2_ObtemRetornos(Handle, vDsVlGT, 0);
        vDsVlGT := fRetornaValor(vDsVlGT, 'ValorMoeda','');
        vDsVlGT := AnsiReplaceStr(vDsVlGT, '.', '');
        if trim(vDsVlGT) = '' then vDsVlGT := '0';

        vDsArquivo := '';
        vDsArquivo :=              'Tipo do relatório.........:' + Format('%25s', ['60']) + sLineBreak;
        vDsArquivo := vDsArquivo + 'Subtipo...................:' + Format('%25s', ['M']) + sLineBreak;
        vDsArquivo := vDsArquivo + 'Data de emissão...........:' + Format('%25s', [vDsData]) + sLineBreak;
        vDsArquivo := vDsArquivo + 'Número de série...........:' + Format('%25s', [vNrSerie]) + sLineBreak;
        vDsArquivo := vDsArquivo + 'Número do equipamento.....:' + Format('%25s', [vDsLoja]) + sLineBreak;
        vDsArquivo := vDsArquivo + 'Modelo do documento fiscal:' + Format('%25s', ['2D']) + sLineBreak;
        // COO Inicial e Final não será enviado, pois ficara o que é armazenado a cada venda no sistema
        //vDsArquivo := vDsArquivo + 'COO inicial...............:' + Format('%25s', [vDsCOOInicio]) + sLineBreak;
        //vDsArquivo := vDsArquivo + 'COO final.................:' + Format('%25s', [vDsCOOReducao]) + sLineBreak;
        vDsArquivo := vDsArquivo + 'COO inicial...............:' + Format('%25s', ['0']) + sLineBreak;
        vDsArquivo := vDsArquivo + 'COO final.................:' + Format('%25s', ['0']) + sLineBreak;
        vDsArquivo := vDsArquivo + 'Contador de reduções......:' + Format('%25s', [vDsNrUltimaReduz]) + sLineBreak;
        vDsArquivo := vDsArquivo + 'Reinicio de operações.....:' + Format('%25s', [vDsReinicioOperacao]) + sLineBreak;
        vDsArquivo := vDsArquivo + 'Venda Bruta...............:' + Format('%25s', [FormatFloat(', 0.00', StrToFloatDef(vDsVlVendaBruta, 0))]) + sLineBreak;
        vDsArquivo := vDsArquivo + 'Totalizador geral.........:' + Format('%25s', [FormatFloat(', 0.00', StrToFloatDef(vDsVlGT, 0))]);
        vDsPath := getPathECF();
        AssignFile(F, vDsPath + '\RETORNO.TXT') ;
        Rewrite(F);
        Write(F, vDsArquivo);
        CloseFile(F);
      except
      end;
    end else if (vModeloEcf = 'ecfDaruma') then begin
      vDadosRZ := '';
      SetLength(vDadosRZ, 1210);

      //result := regAlterarValor_Daruma('ECF\Atocotepe\LocalArquivos', getPathECF());
      result := regAlterarValor_Daruma('START\LocalArquivosRelatorios', copy(getPathECF(), 3, length(getPathECF()))); //'\Projeto_touch\VirtualLoja\path_ecf\'

      result := rRetornarDadosReducaoZ_ECF_Daruma(vDadosRZ);
      vDtUltMovimento := copy(vDadosRZ, 1, 8);

      result := rGerarSINTEGRA_ECF_Daruma('DATAM', vDtUltMovimento, vDtUltMovimento);

      if (FileExists(getPathECF + 'Sintegra.txt')) then begin
        vPathECF := getPathECF;
      end else if (FileExists('C:\Sintegra.txt')) then begin
        vPathECF :=  'C:\';
      end;

      if (FileExists(vPathECF + 'Sintegra.txt'))  then begin
        vDsArq.Free;
        vDsArq := TStringList.Create;
        vDsArq.LoadFromFile(vPathECF + 'Sintegra.txt');
        iConta := 1;
        while iConta < vDsArq.Count do begin
          vLinha := vDsArq.Strings[iConta];
          if(Copy(vLinha, 1, 3) = '60M') then begin
            //atribuindo valores as variaveis de registro
            vDsData := copy(vLinha, 4, 8);
            vDsNumeroSerie := copy(vLinha, 12, 20);
            vDsLoja := copy(vLinha, 32, 3);
            vDsCOOInicio := copy(vLinha, 37, 6);
            vDsCOOReducao := copy(vLinha, 43, 6);
            vDsNrUltimaReduz := copy(vLinha, 49, 6);
            vDsReinicioOperacao := copy(vLinha, 55, 3) ;
            vDsVlVendaBruta := copy(vLinha, 58, 16);
            vDsVlGT := copy(vLinha, 74, 16);
            vDsData := copy(vDsData, 7, 2) + '/' + copy(vDsData, 5, 2) + '/' + copy(vDsData, 3, 2);

            vDsArquivo := '';
            vDsArquivo :=              'Tipo do relatório.........:' + Format('%25s', ['60']) + sLineBreak;
            vDsArquivo := vDsArquivo + 'Subtipo...................:' + Format('%25s', ['M']) + sLineBreak;
            vDsArquivo := vDsArquivo + 'Data de emissão...........:' + Format('%25s', [vDsData]) + sLineBreak;
            vDsArquivo := vDsArquivo + 'Número de série...........:' + Format('%25s', [vDsNumeroSerie]) + sLineBreak;
            vDsArquivo := vDsArquivo + 'Número do equipamento.....:' + Format('%25s', [vDsLoja]) + sLineBreak;
            vDsArquivo := vDsArquivo + 'Modelo do documento fiscal:' + Format('%25s', ['2D']) + sLineBreak;
            vDsArquivo := vDsArquivo + 'COO inicial...............:' + Format('%25s', [vDsCOOInicio]) + sLineBreak;
            vDsArquivo := vDsArquivo + 'COO final.................:' + Format('%25s', [vDsCOOReducao]) + sLineBreak;
            vDsArquivo := vDsArquivo + 'Contador de reduções......:' + Format('%25s', [vDsNrUltimaReduz]) + sLineBreak;
            vDsArquivo := vDsArquivo + 'Reinicio de operações.....:' + Format('%25s', [vDsReinicioOperacao]) + sLineBreak;

            vValor := StrToFloatDef(vDsVlVendaBruta, 0);
            vValor := vValor / 100;
            vDsArquivo := vDsArquivo + 'Venda Bruta...............:' + Format('%25s', [FormatFloat(', 0.00', vValor)]) + sLineBreak;
            vValor := StrToFloatDef(vDsVlGT, 0);
            vValor := vValor / 100;
            vDsArquivo := vDsArquivo + 'Totalizador geral.........:' + Format('%25s', [FormatFloat(', 0.00', vValor)]);

          end;
          inc(iConta);
        end;

        AssignFile(F,  getPathECF() + 'RETORNO.TXT') ;
        Rewrite(F);
        Write(F, vDsArquivo);
        CloseFile(F);
      end;
    end else if (vModeloEcf = 'ecfSweda') then begin
      result := ECF_RelatorioTipo60Mestre();
    end else if (vModeloEcf = 'ecfEpson') then begin
      vLastRZData := ReplicateStr(' ', 1170);
      result := EPSON_Obter_Dados_Ultima_RZ(PChar(vLastRZData));

      vDsDadosImpressora := ReplicateStr(' ', 110);
      EPSON_Obter_Dados_Impressora(PChar(vDsDadosImpressora));
      vNrSerie := Copy(vDsDadosImpressora, 1, 20);

      vDsDadosImpressora := ReplicateStr(' ', 10);
      EPSON_Obter_Numero_ECF_Loja(PChar(vDsDadosImpressora));
      vDsLoja := Copy(vDsDadosImpressora, 1, 3);

      vVBatual := ReplicateStr(' ', 15);

      vVBanterior := ReplicateStr(' ', 15);

      EPSON_Obter_Venda_Bruta(PChar(vVBatual), PChar(vVBanterior));

      vDsData := Copy(vLastRZData, 1160, 8);
      if (vDsData = '????????') then begin
        vDsData := Copy(vLastRZData, 1, 8); 
      end; 
      vDsData := Copy(vDsData, 1, 2) + '/' + Copy(vDsData, 3, 2) + '/' + Copy(vDsData, 7, 2); 

      vDsNumeroSerie := vNrSerie;
      vDsCOOInicio := Copy(vLastRZData, 15, 6); 
      vDsCOOReducao := Copy(vLastRZData, 21, 6); 
      vDsNrUltimaReduz := Copy(vLastRZData, 27, 6); 
      vDsReinicioOperacao := Copy(vLastRZData, 33, 6); 
      vDsVlVendaBruta := vVBanterior; 
      vDsVlGT := Copy(vLastRZData, 87, 18); 

      vDsArquivo := ''; 
      vDsArquivo :=              'Tipo do relatório.........:' + Format('%25s', ['60']) + sLineBreak; 
      vDsArquivo := vDsArquivo + 'Subtipo...................:' + Format('%25s', ['M']) + sLineBreak; 
      vDsArquivo := vDsArquivo + 'Data de emissão...........:' + Format('%25s', [vDsData]) + sLineBreak; 
      vDsArquivo := vDsArquivo + 'Número de série...........:' + Format('%25s', [vDsNumeroSerie]) + sLineBreak; 
      vDsArquivo := vDsArquivo + 'Número do equipamento.....:' + Format('%25s', [vDsLoja]) + sLineBreak; 
      vDsArquivo := vDsArquivo + 'Modelo do documento fiscal : ' + Format('%25s', ['2D']) + sLineBreak; 
      vDsArquivo := vDsArquivo + 'COO inicial...............:' + Format('%25s', [vDsCOOInicio]) + sLineBreak; 
      vDsArquivo := vDsArquivo + 'COO final.................:' + Format('%25s', [vDsCOOReducao]) + sLineBreak; 
      //vDsArquivo := vDsArquivo + 'COO inicial...............:' + Format('%25s', ['0']) + sLineBreak; 
      //vDsArquivo := vDsArquivo + 'COO final.................:' + Format('%25s', ['0']) + sLineBreak; 
      vDsArquivo := vDsArquivo + 'Contador de reduções......:' + Format('%25s', [vDsNrUltimaReduz]) + sLineBreak; 
      vDsArquivo := vDsArquivo + 'Reinicio de operações.....:' + Format('%25s', [vDsReinicioOperacao]) + sLineBreak; 
      vValor := StrToFloatDef(vDsVlVendaBruta, 0); 
      vValor := vValor / 100;
      vDsArquivo := vDsArquivo + 'Venda Bruta...............:' + Format('%25s', [FormatFloat(', 0.00', vValor)]) + sLineBreak;
      vValor := StrToFloatDef(vDsVlGT, 0);
      vValor := vValor / 100;
      vDsArquivo := vDsArquivo + 'Totalizador geral.........:' + Format('%25s', [FormatFloat(', 0.00', vValor)]);

      AssignFile(F, 'C:\ECF\RETORNO.TXT') ;
      Rewrite(F);
      Write(F, vDsArquivo);
      CloseFile(F);
    end;
  except
    on E : Exception do ShowMessage(E.Message);
  end;
end;

function relatorioTipo60Analitico(vModeloEcf : String) : Integer;
var
  vDsArquivo, vDsData, vDsNumeroSerie, vDsNrUltimaReduz : String; 
  vDsVlCancelamentos, vDsVlDescontos : String; 
  vDsVlF, vDsVlI, vDsVlN, vDsPercAliquota00, vDsVlAliquota00, vDsPercAliquota01, vDsVlAliquota01 : String; 
  vDsPercAliquota02, vDsVlAliquota02, vDsPercAliquota03, vDsVlAliquota03, vDsPercAliquota04, vDsVlAliquota04 : String;
  vDsPercAliquota05, vDsVlAliquota05, vDsPercAliquota06, vDsVlAliquota06, vDsPercAliquota07, vDsVlAliquota07 : String;
  vDsPercAliquota08, vDsVlAliquota08, vDsPercAliquota09, vDsVlAliquota09, vDsPercAliquota10, vDsVlAliquota10 : String; 
  vDsPercAliquota11, vDsVlAliquota11, vDsPercAliquota12, vDsVlAliquota12, vDsPercAliquota13, vDsVlAliquota13 : String; 
  vDsPercAliquota14, vDsVlAliquota14, vDsPercAliquota15, vDsVlAliquota15 : String; 
  vDsTipoAliquota, vDsIndiceAliquota, vDsPercAliquota, vDsVlAliquota, vDadosRZ, vDtUltMovimento, vLinha, vPathECF : String; 
  vLastRZData, vDsDadosImpressora : String; 
  i, vCont, vPosTributo, vPosVlTributo : Integer; 
  vValor : Currency; 
  F, vArqSintegra : TextFile; 
begin
  try
    if (vModeloEcf = 'ecfBematech') or (vModeloEcf = 'ecfYanco') then begin
      result := Bematech_FI_RelatorioTipo60Analitico(); 
    end else if (vModeloEcf = 'ecfElgin') then begin
      result := Elgin_RelatorioTipo60Analitico; 
    end else if (vModeloEcf = 'ecfInterway') or (vModeloEcf = 'ecfUrano') then begin
      try
        // pego a data da ECF
        DLLG2_ExecutaComando(Handle, 'LeData;NomeData="Data"');
        vDsData := DLLG2_ObtemRetornos(Handle, vDsData, 0);
        vDsData := fRetornaValor(vDsData, 'ValorData','#');
        vDsData := FormatDateTime('DD/MM/YY', StrToDate(vDsData));

        // pego o número de série da ECF
        DLLG2_ExecutaComando(Handle, 'LeTexto;NomeTexto="NumeroSerieECF"');
        vDsNumeroSerie := DLLG2_ObtemRetornos(Handle, vDsNumeroSerie, 0);
        vDsNumeroSerie := fRetornaValor(vDsNumeroSerie, 'ValorTexto','"');

        // pego o número do contador de redução
        DLLG2_ExecutaComando(Handle, 'LeInteiro;NomeInteiro="CRZ"');
        vDsNrUltimaReduz := DLLG2_ObtemRetornos(Handle, vDsNrUltimaReduz, 0);
        vDsNrUltimaReduz := fRetornaValor(vDsNrUltimaReduz, 'ValorInteiro','');
        if trim(vDsNrUltimaReduz) = '' then vDsNrUltimaReduz := '0';

        // pego o valor de Cancelamentos
        DLLG2_ExecutaComando(Handle, 'LeMoeda;NomeDadoMonetario="CancelamentosICMSReducao[' + vDsNrUltimaReduz + ']"');
        vDsVlCancelamentos := DLLG2_ObtemRetornos(Handle, vDsVlCancelamentos, 0);
        vDsVlCancelamentos := fRetornaValor(vDsVlCancelamentos, 'ValorMoeda','');
        vDsVlCancelamentos := AnsiReplaceStr(vDsVlCancelamentos, '.', '');
        if trim(vDsVlCancelamentos) = '' then vDsVlCancelamentos := '0';

        // pego o valor de Cancelamentos
        DLLG2_ExecutaComando(Handle, 'LeMoeda;NomeDadoMonetario="DescontosReducao[' + vDsNrUltimaReduz + ']"');
        vDsVlDescontos := DLLG2_ObtemRetornos(Handle, vDsVlDescontos, 0);
        vDsVlDescontos := fRetornaValor(vDsVlDescontos, 'ValorMoeda','');
        vDsVlDescontos := AnsiReplaceStr(vDsVlDescontos, '.', '');
        if trim(vDsVlDescontos) = '' then vDsVlDescontos := '0';

        // pego o total da aliquota F
        DLLG2_ExecutaComando(Handle, 'LeMoeda;NomeDadoMonetario="TotalAliquotaF1Reducao[' + vDsNrUltimaReduz + ']"');
        vDsVlF := DLLG2_ObtemRetornos(Handle, vDsVlF, 0);
        vDsVlF := fRetornaValor(vDsVlF, 'ValorMoeda','');
        vDsVlF := AnsiReplaceStr(vDsVlF, '.', '');
        if trim(vDsVlF) = '' then vDsVlF := '0';

        // pego o total da aliquota I
        DLLG2_ExecutaComando(Handle, 'LeMoeda;NomeDadoMonetario="TotalAliquotaI1Reducao[' + vDsNrUltimaReduz + ']"');
        vDsVlI := DLLG2_ObtemRetornos(Handle, vDsVlI, 0);
        vDsVlI := fRetornaValor(vDsVlI, 'ValorMoeda','');
        vDsVlI := AnsiReplaceStr(vDsVlI, '.', '');
        if trim(vDsVlI) = '' then vDsVlI := '0';

        // pego o total da aliquota N
        DLLG2_ExecutaComando(Handle, 'LeMoeda;NomeDadoMonetario="TotalAliquotaN1Reducao[' + vDsNrUltimaReduz + ']"');
        vDsVlN := DLLG2_ObtemRetornos(Handle, vDsVlN, 0);
        vDsVlN := fRetornaValor(vDsVlN, 'ValorMoeda','');
        vDsVlN := AnsiReplaceStr(vDsVlN, '.', '');
        if trim(vDsVlN) = '' then vDsVlN := '0';

        vDsArquivo := '';
        vDsArquivo :=              'Tipo do relatório.........:' + Format('%25s', ['60']) + sLineBreak;
        vDsArquivo := vDsArquivo + 'Subtipo...................:' + Format('%25s', ['A']) + sLineBreak;
        vDsArquivo := vDsArquivo + 'Data de emissão...........:' + Format('%25s', [vDsData]) + sLineBreak;
        vDsArquivo := vDsArquivo + 'Número de série...........:' + Format('%25s', [vDsNumeroSerie]) + sLineBreak;
        vDsArquivo := vDsArquivo + 'Cancelamentos.............:' + Format('%25s', [FormatFloat(', 0.00', StrToFloatDef(vDsVlCancelamentos, 0))]) + sLineBreak;
        vDsArquivo := vDsArquivo + 'Descontos.................:' + Format('%25s', [FormatFloat(', 0.00', StrToFloatDef(vDsVlDescontos, 0))]) + sLineBreak;
        vDsArquivo := vDsArquivo + 'F.........................:' + Format('%25s', [FormatFloat(', 0.00', StrToFloatDef(vDsVlF, 0))]) + sLineBreak;
        vDsArquivo := vDsArquivo + 'I.........................:' + Format('%25s', [FormatFloat(', 0.00', StrToFloatDef(vDsVlI, 0))]) + sLineBreak;
        vDsArquivo := vDsArquivo + 'N.........................:' + Format('%25s', [FormatFloat(', 0.00', StrToFloatDef(vDsVlN, 0))]) + sLineBreak;

        for i := 0 to 15 do begin
          // Verifico se a aliquota i é do tipo ICMS
          vDsIndiceAliquota := FormatFloat('00', i);
          DLLG2_ExecutaComando(Handle, 'LeIndicador;NomeIndicador="Aliquota' + vDsIndiceAliquota + 'ICMSReducao[' + vDsNrUltimaReduz + ']"');
          vDsTipoAliquota := DLLG2_ObtemRetornos(Handle, vDsTipoAliquota, 0);
          vDsTipoAliquota := fRetornaValor(vDsTipoAliquota, 'ValorTextoIndicador','"');
          if trim(vDsTipoAliquota) = '1' then begin // se a aliquota for de ICMS
            // Pego o percentual da aliquota atual
            DLLG2_ExecutaComando(Handle, 'LeMoeda;NomeDadoMonetario="Aliquota' + vDsIndiceAliquota + 'Reducao[' + vDsNrUltimaReduz + ']"');
            vDsPercAliquota := DLLG2_ObtemRetornos(Handle, vDsPercAliquota, 0);
            vDsPercAliquota := fRetornaValor(vDsPercAliquota, 'ValorMoeda','');
            vDsPercAliquota := FormatFloat(', 00.00', StrToFloatDef(vDsPercAliquota, 0));
            vDsPercAliquota := AnsiReplaceStr(vDsPercAliquota, ',', '');

            // pego o valor de venda correspondente a aliquota i
            DLLG2_ExecutaComando(Handle, 'LeMoeda;NomeDadoMonetario="TotalAliquota' + vDsIndiceAliquota + 'Reducao[' + vDsNrUltimaReduz + ']"');
            vDsVlAliquota := DLLG2_ObtemRetornos(Handle, vDsVlAliquota, 0);
            vDsVlAliquota := fRetornaValor(vDsVlAliquota, 'ValorMoeda','');

            vDsArquivo := vDsArquivo + vDsPercAliquota + '......................:' + Format('%25s', [FormatFloat(', 0.00', StrToFloatDef(vDsVlAliquota, 0))]) + sLineBreak; 
          end; 
        end; 

        DLLG2_ExecutaComando(Handle, 'LeMoeda;NomeDadoMonetario="TotalAliquotaNS1Reducao[' + vDsNrUltimaReduz + ']"'); 
        vDsVlAliquota := DLLG2_ObtemRetornos(Handle, vDsVlAliquota, 0); 
        vDsVlAliquota := fRetornaValor(vDsVlAliquota, 'ValorMoeda',''); 

        vDsArquivo := vDsArquivo + 'ISS.......................:' + Format('%25s', [FormatFloat(', 0.00', StrToFloatDef(vDsVlAliquota, 0))]);

        AssignFile(F, 'C:\ECF\RETORNO.TXT') ; 
        Rewrite(F); 
        Write(F, vDsArquivo); 
        CloseFile(F);
      except
      end; 
    end else if (vModeloEcf = 'ecfDaruma') then begin
      vCont := 0; 

      result := regAlterarValor_Daruma('START\LocalArquivosRelatorios', copy(getPathECF(), 3, length(getPathECF()))); //'\Projeto_touch\VirtualLoja\path_ecf\'

      SetLength(vDadosRZ, 1210); 
      rRetornarDadosReducaoZ_ECF_Daruma(vDadosRZ); 
      vDtUltMovimento := copy(vDadosRZ, 1, 8); 

      if (FileExists(getPathECF + 'Sintegra.txt')) then begin
        vPathECF := getPathECF; 
      end else if (FileExists('C:\' + 'Sintegra.txt')) then begin
        vPathECF :=  'C:\'; 
      end; 

     // Result := rGerarSINTEGRA_ECF_Daruma('DATAM', vDtUltMovimento, vDtUltMovimento); 
      if(FileExists(vPathECF + 'Sintegra.txt')) then begin
        AssignFile(vArqSintegra, vPathECF + 'Sintegra.txt'); 
        Reset(vArqSintegra); 
        while not eof(vArqSintegra) do begin
          readln(vArqSintegra, vLinha); 
          if(Copy(vLinha, 1, 3) = '60A') then begin
            inc(vCont); 
            //atribuindo valores as variaveis de registro
            vDsData := copy(vLinha, 4, 8); 
            vDsNumeroSerie := copy(vLinha, 12, 20); 
            vDsPercAliquota := copy(vLinha, 32, 4); 
            vDsVlAliquota := copy(vLinha, 36, 12); 
            vDsData := copy(vDsData, 7, 2) + '/' + copy(vDsData, 5, 2) + '/' + copy(vDsData, 3, 2); 
            if (vCont = 1) then begin
              vDsArquivo := '';
              vDsArquivo :=              'Tipo do relatório.........:' + Format('%25s', ['60'])           + sLineBreak; 
              vDsArquivo := vDsArquivo + 'Subtipo...................:' + Format('%25s', ['A'])            + sLineBreak; 
              vDsArquivo := vDsArquivo + 'Data de emissão...........:' + Format('%25s', [vDsData])        + sLineBreak; 
              vDsArquivo := vDsArquivo + 'Número de série...........:' + Format('%25s', [vDsNumeroSerie]) + sLineBreak; 
            end; 

            vDsVlAliquota := Copy(vDsVlAliquota, 1, 10) + ',' +  Copy(vDsVlAliquota, length(vDsVlAliquota) -1, 2); 
            vDsVlAliquota := FormatFloat(', 0.00', StrToFloatDef(PChar(vDsVlAliquota), 0)); 
            vDsArquivo := vDsArquivo + preenchePonto(26, TrimRight(vDsPercAliquota)) + ' : ' + Format('%25s', [vDsVlAliquota]) + sLineBreak; 

          end;
        end; 
        AssignFile(F,  getPathECF() + 'RETORNO.TXT') ;
        Rewrite(F); 
        Write(F, vDsArquivo); 
        CloseFile(F); 

        CloseFile(vArqSintegra); 

        DeleteFile(vPathECF + 'Sintegra.txt'); 
      end; 
    end else if (vModeloEcf = 'ecfSweda') then begin
      result := ECF_RelatorioTipo60Analitico(); 
    end else if (vModeloEcf = 'ecfEpson') then begin
      vLastRZData := ReplicateStr(' ', 1170); 
      result := EPSON_Obter_Dados_Ultima_RZ(PChar(vLastRZData)); 

      vDsDadosImpressora := ReplicateStr(' ', 110); 
      EPSON_Obter_Dados_Impressora(PChar(vDsDadosImpressora)); 
      vNrSerie := Copy(vDsDadosImpressora, 1, 20); 

      vDsData := Copy(vLastRZData, 1160, 8);
      if (vDsData = '????????') then
        vDsData := Copy(vLastRZData, 1, 8);

      vDsData := Copy(vDsData, 1, 2) + '/' + Copy(vDsData, 3, 2) + '/' + Copy(vDsData, 7, 2);
      vDsNumeroSerie := vNrSerie;
      vDsVlCancelamentos := Copy(vLastRZData, 105, 17);
      vDsVlDescontos := Copy(vLastRZData, 156, 17); 

      vDsArquivo := ''; 
      vDsArquivo :=              'Tipo do relatório.........:' + Format('%25s', ['60'])           + sLineBreak; 
      vDsArquivo := vDsArquivo + 'Subtipo...................:' + Format('%25s', ['A'])            + sLineBreak; 
      vDsArquivo := vDsArquivo + 'Data de emissão...........:' + Format('%25s', [vDsData])        + sLineBreak; 
      vDsArquivo := vDsArquivo + 'Número de série...........:' + Format('%25s', [vDsNumeroSerie]) + sLineBreak; 

      vPosTributo := 258; 
      vPosVlTributo := 384; 
      for i := 1 to 24  do begin
       if (Copy(vLastRZData, vPosTributo, 1) = 'T') then
         vDsPercAliquota := Copy(vLastRZData, vPosTributo + 1, 4)
       else
         vDsPercAliquota := Copy(vLastRZData, vPosTributo, 5); 

       if trim(vDsPercAliquota) <> '' then begin
         vDsVlAliquota := Copy(vLastRZData, vPosVlTributo, 17); 
         vDsVlAliquota := FloatToStr(StrToCurrDef(vDsVlAliquota, 0) / 100); 
         vDsVlAliquota := FormatFloat(', 0.00', StrToFloatDef(vDsVlAliquota, 0));
         vDsArquivo := vDsArquivo + preenchePonto(26, TrimRight(vDsPercAliquota)) + ' : ' + Format('%25s', [vDsVlAliquota]) + sLineBreak;
        end; 

       vPosTributo := vPosTributo   + 5; 
       vPosVlTributo := vPosVlTributo + 17; 
      end; 

      vValor := StrToFloatDef(vDsVlCancelamentos, 0); 
      vValor := vValor / 100; 
      vDsVlCancelamentos := FormatFloat(', 0.00', vValor); 
      vDsArquivo := vDsArquivo + 'CANC......................:' + Format('%25s', [vDsVlCancelamentos]) + sLineBreak; 

      vValor := StrToFloatDef(vDsVlDescontos, 0);
      vValor := vValor / 100; 
      vDsVlDescontos := FormatFloat(', 0.00', vValor); 
      vDsArquivo := vDsArquivo + 'DESC......................:' + Format('%25s', [vDsVlDescontos]); 

      AssignFile(F, 'C:\ECF\RETORNO.TXT') ;
      Rewrite(F);
      Write(F, vDsArquivo);
      CloseFile(F);
    end;
  except
    on E : Exception do ShowMessage(E.Message);
  end;
end;

function numeroCupom(vModeloEcf : String) : Integer;
var
  vDsNumeroCupom, vDsRetornoCF, vDsContadores : String;
  iConta, Tamanho, iNrCupom : Integer;
begin
  try
    if (vModeloEcf = 'ecfBematech') or (vModeloEcf = 'ecfYanco') then begin
      vDsNumeroCupom := ReplicateStr(' ', 6);
      result := Bematech_FI_NumeroCupom(vDsNumeroCupom);
      vNrCupom := vDsNumeroCupom;
    end else if (vModeloEcf = 'ecfElgin') then begin
      vDsNumeroCupom := ReplicateStr(' ', 6);
      result := Elgin_NumeroCupom(vDsNumeroCupom);
      vNrCupom := vDsNumeroCupom;
    end else if (vModeloEcf = 'ecfInterway') or (vModeloEcf = 'ecfUrano') then begin
      Result := DLLG2_ExecutaComando(Handle, 'LeInteiro;NomeInteiro="COO"');
      vNrCupom := DLLG2_ObtemRetornos(Handle, '', 0);
      vNrCupom := fRetornaValor(vNrCupom, 'ValorInteiro','');
    end else if (vModeloEcf = 'ecfDaruma') then begin
      SetLength(vDsRetornoCF, 6);
      result := rRetornarInformacao_ECF_Daruma('26', vDsRetornoCF);
      vDsNumeroCupom := vDsRetornoCF;
      if Trim(vDsNumeroCupom) <> '' then begin
        iNrCupom := StrToIntDef(vDsNumeroCupom, 0); 
        vNrCupom := IntToStr(iNrCupom);
      end;
    end else if (vModeloEcf = 'ecfSweda') then begin
      vDsNumeroCupom := ReplicateStr(' ', 6);
      result := ECF_NumeroCupom(vDsNumeroCupom);
      vNrCupom := vDsNumeroCupom;
    end else if (vModeloEcf = 'ecfEpson') then begin
      vDsContadores := ReplicateStr(' ', 100); 
      Result := EPSON_Obter_Contadores(PChar(vDsContadores));
      vDsNumeroCupom := Copy(vDsContadores, 1, 6); 
      vNrCupom := vDsNumeroCupom; 
    end; 
  except
    on E : Exception do ShowMessage(E.Message); 
  end; 
end; 

function numeroSerie(vModeloEcf : String) : Integer;
var
  vDsNumeroSerie, vDsRetorno, vDsDadosImpressora : String;
  iConta : Integer;
begin

  try
    if (vModeloEcf = 'ecfBematech') or (vModeloEcf = 'ecfYanco') then begin
      vDsNumeroSerie := ReplicateStr(' ', 15);
      result := Bematech_FI_NumeroSerie(vDsNumeroSerie);
      vNrSerie := vDsNumeroSerie;
    end else if (vModeloEcf = 'ecfElgin') then begin
      Elgin_FechaPortaSerial;
      abrePorta(vModeloEcf);
      vDsNumeroSerie := ReplicateStr(' ', 20);
      result := Elgin_NumeroSerie(vDsNumeroSerie);
      vNrSerie := Trim(vDsNumeroSerie);
    end else if (vModeloEcf = 'ecfInterway') or (vModeloEcf = 'ecfUrano') then begin
      Result := DLLG2_ExecutaComando(Handle, 'LeTexto;NomeTexto="NumeroSerieECF"');
      vNrSerie := DLLG2_ObtemRetornos(Handle, vDsNumeroSerie, 0);
      vNrSerie := fRetornaValor(vNrSerie, 'ValorTexto','"');
    end else if (vModeloEcf = 'ecfDaruma') then begin
      SetLength(vDsRetorno, 20);
      Result := rRetornarInformacao_ECF_Daruma('78', vDsRetorno);
      vNrSerie := vDsRetorno;
    end else if (vModeloEcf = 'ecfSweda') then begin
      vDsNumeroSerie := ReplicateStr(' ', 15);
      result := ECF_NumeroSerie(vDsNumeroSerie);
      vNrSerie := vDsNumeroSerie;
    end else if (vModeloEcf = 'ecfEpson') then begin
      vDsDadosImpressora := ReplicateStr(' ', 110);
      Result := EPSON_Obter_Dados_Impressora(PChar(vDsDadosImpressora));
      vNrSerie := Copy(vDsDadosImpressora, 1, 20);
    end;
  except
    on E : Exception do ShowMessage(E.Message);
  end;
end;

function numeroSerieMFD(vModeloEcf : String) : Integer;
var
  vDsNumeroSerie, vDsRetorno, vDsDadosImpressora : String;
  iConta : Integer;
begin
  try
    if (vModeloEcf = 'ecfBematech') or (vModeloEcf = 'ecfYanco') then begin
      vDsNumeroSerie := ReplicateStr(' ', 20);
      result := Bematech_FI_NumeroSerieMFD(vDsNumeroSerie);
      vNrSerie := vDsNumeroSerie;
    end else if (vModeloEcf = 'ecfElgin') then begin
      vDsNumeroSerie := ReplicateStr(' ', 20);
      result := Elgin_NumeroSerie(vDsNumeroSerie);
      vNrSerie := vDsNumeroSerie;
      vNrSerie := Trim(vDsNumeroSerie);
    end else if (vModeloEcf = 'ecfInterway') or (vModeloEcf = 'ecfUrano') then begin
      if vNrSerie = '' then begin
        Result := DLLG2_ExecutaComando(Handle, 'LeTexto;NomeTexto="NumeroSerieECF"');
        vNrSerie := DLLG2_ObtemRetornos(Handle, vDsNumeroSerie, 0);
        vNrSerie := fRetornaValor(vNrSerie, 'ValorTexto','"');
      end;
    end else if (vModeloEcf = 'ecfDaruma') then begin
      SetLength(vDsRetorno, 21);
      Result := rRetornarInformacao_ECF_Daruma('78', vDsRetorno);
      vNrSerie := vDsRetorno;
    end else if (vModeloEcf = 'ecfSweda') then begin
      vDsNumeroSerie := ReplicateStr(' ', 20);
      result := ECF_NumeroSerieMFD(vDsNumeroSerie);
      vNrSerie := vDsNumeroSerie; 
    end else if (vModeloEcf = 'ecfEpson') then begin
      vDsDadosImpressora := ReplicateStr(' ', 110); 
      Result := EPSON_Obter_Dados_Impressora(PChar(vDsDadosImpressora)); 
      vNrSerie := Copy(vDsDadosImpressora, 1, 20); 
    end; 
  except
    on E : Exception do ShowMessage(E.Message); 
  end; 
end; 

function dataImpressora(vModeloEcf : String) : Integer;
var
  vDsData, vDsRetorno, vDsDados : String; 
  iConta : Integer; 
begin
  try
    if (vModeloEcf = 'ecfBematech') or (vModeloEcf = 'ecfYanco') then begin
      vDsData := ReplicateStr(' ', 6); 
      result := Bematech_FI_DataMovimento(vDsData); // ddmmaa 
      vDataHora := vDsData; 
    end else if (vModeloEcf = 'ecfElgin') then begin
      vDsData := ReplicateStr(' ', 6); 
      result := Elgin_DataMovimento(vDsData); 
      vDataHora := vDsData; 
    end else if (vModeloEcf = 'ecfInterway') or (vModeloEcf = 'ecfUrano') then begin
      Result := DLLG2_ExecutaComando(Handle, 'LeData;NomeData="Data"');
      vDataHora := DLLG2_ObtemRetornos(Handle, vDsData, 0);
      vDataHora := fRetornaValor(vDataHora, 'ValorData','#'); 
    end else if (vModeloEcf = 'ecfDaruma') then begin
      SetLength(vDsRetorno, 8); 
      Result := rRetornarInformacao_ECF_Daruma('70', vDsRetorno); 
      vDsData := vDsRetorno;
    end else if (vModeloEcf = 'ecfSweda') then begin
      vDsData := ReplicateStr(' ', 6); 
      result := ECF_DataMovimento(vDsData); // ddmmaa
      vDataHora := vDsData; 
    end else if (vModeloEcf = 'ecfEpson') then begin
      SetLength(vDsDados, 15); 
      Result := EPSON_Obter_Hora_Relogio(PChar(vDsDados)); 
      vDsData := Copy(vDsDados, 1, 7); 
    end; 
  except
    on E : Exception do ShowMessage(E.Message);
  end;
end;

function dataHoraGravacaoUsuarioSWBasicoMFAdicional(vModeloEcf : String) : Integer;
var
  iConta : Integer;
  vMFAdicionalAux, Valor : String;
begin
  try
    if (vModeloEcf = 'ecfBematech') or (vModeloEcf = 'ecfYanco') then begin
      vDataUsuario := ReplicateStr(' ', 20);
      vDataSWBasico := ReplicateStr(' ', 20);
      vMFAdicionalAux := ReplicateStr(' ', 2);
      result := Bematech_FI_DataHoraGravacaoUsuarioSWBasicoMFAdicional(vDataUsuario, vDataSWBasico, vMFAdicionalAux);
      vMFAdicional := vMFAdicionalAux;
    end else if (vModeloEcf = 'ecfDaruma') then begin
      result := -20;
    end else if (vModeloEcf = 'ecfElgin') then begin
      result := -20;
    end else if (vModeloEcf = 'ecfEpson') then begin
      result := -20;
    end else if (vModeloEcf = 'ecfInterway') or (vModeloEcf = 'ecfUrano') then begin
      Result := DLLG2_ExecutaComando(Handle, 'LeTexto;NomeTexto="VersaoSW"');
      vDataSWBasico := DLLG2_ObtemRetornos(Handle, vDataSWBasico, 0);
      vDataSWBasico := fRetornaValor(vDataSWBasico, 'ValorTexto','"');
    end else if (vModeloEcf = 'ecfSweda') then begin
      result := -20;
    end;
  except
    on E : Exception do ShowMessage(E.Message);
  end;
end;

function abreCupomVinculado(vModeloEcf : String; FormaPagamento : String; Valor : String; NumeroCupom : String) : Integer;
var
  vVlValor : Real;
  vPosicao : Integer;
  vCodPagamento,vResult : String;
begin
  try
    Valor := FormatFloat('0.00', StrToFloatDef(Valor, 0));
    if (vModeloEcf = 'ecfBematech') or (vModeloEcf = 'ecfYanco') then begin
      result := Bematech_FI_abreCupomVinculado(FormaPagamento, Valor, NumeroCupom);
    end else if (vModeloEcf = 'ecfElgin') then begin
      result := Elgin_abreCupomVinculado(PChar(FormaPagamento), PChar(Valor), PChar(NumeroCupom));
    end else if (vModeloEcf = 'ecfInterway') then begin
      vVlValor := StrToFloatDef(trim(Valor), 0);
      vVlValor := vVlValor / 100;
      Valor := FloatToStr(vVlValor);
      vCodPagamento := 'AbreCreditoDebito;COO=' + NumeroCupom + ' NomeMeioPagamento="' + FormaPagamento + '" Valor=' + Valor;
      result := DLLG2_ExecutaComando(Handle, 'AbreCreditoDebito;COO=' + NumeroCupom + ' NomeMeioPagamento="' + FormaPagamento + '" Valor=' + Valor);
    end else if (vModeloEcf = 'ecfUrano') then begin
      vVlValor := StrToFloatDef(trim(Valor), 0);
      Valor := FloatToStr(vVlValor);
      vCodPagamento   := 'AbreCreditoDebito;COO=' + NumeroCupom + ' NomeMeioPagamento="' + FormaPagamento + '" Valor=' + Valor;
      result := DLLG2_ExecutaComando(Handle, 'AbreCreditoDebito;COO=' + NumeroCupom + ' NomeMeioPagamento="' + FormaPagamento + '" Valor=' + Valor);
    end else if (vModeloEcf = 'ecfDaruma') then begin
      result := iCCDAbrirSimplificado_ECF_Daruma(FormaPagamento, '1', NumeroCupom, Valor);
    end else if (vModeloEcf = 'ecfSweda') then begin
      result := ECF_abreCupomVinculado(FormaPagamento, Valor, NumeroCupom);
    end else if (vModeloEcf = 'ecfEpson') then begin
      VerificaFormasPagamento('ecfEpson');
      vPosicao := Pos(LowerCase(FormaPagamento), LowerCase(vFormaPGTO));
      vCodPagamento := Copy(vFormaPGTO, vPosicao - 2, 2);
      Valor := ReplaceStr(Valor, '.','');
      Valor := ReplaceStr(Valor, ',','');
      result := EPSON_NaoFiscal_Abrir_CCD(PChar(vCodPagamento), PChar(Valor), 2, '1');
    end;
  except
    on E : Exception do ShowMessage(E.Message); 
  end;
end;

function usaComprovanteNaoFiscalVinculado(vModeloEcf : String; Texto : String) : Integer;
var
  vRetorno, i : Integer;
  vMensagem, vLinha : String;
  vstLista : TStringList;
begin
  try
    if (vModeloEcf = 'ecfBematech') or (vModeloEcf = 'ecfYanco') then begin
      result := Bematech_FI_UsaComprovanteNaoFiscalVinculado(Texto);
    end else if (vModeloEcf = 'ecfElgin') then begin
      result := Elgin_UsaComprovanteNaoFiscalVinculado(PChar(Texto));
    end else if (vModeloEcf = 'ecfInterway') or (vModeloEcf = 'ecfUrano') then begin
      result := DLLG2_ExecutaComando(Handle, 'ImprimeTexto;TextoLivre="' + Texto + '"');
    end else if (vModeloEcf = 'ecfDaruma') then begin
      result := iCCDImprimirTexto_ECF_Daruma(Texto);
    end else if (vModeloEcf = 'ecfSweda') then begin
      result := ECF_UsaComprovanteNaoFiscalVinculado(Texto);
    end else if (vModeloEcf = 'ecfEpson') then begin
      try
        vstLista := TStringList.Create;
        vstLista.Text := Texto;
        for i := 0 to vstLista.Count - 1 do begin
          vLinha := vstLista.Strings[i];
          result := EPSON_NaoFiscal_Imprimir_Linha(PChar(vLinha)); 
        end; 
      finally
       vstLista.Free; 
      end; 
    end; 
  except
    on E : Exception do ShowMessage(E.Message);
  end; 
end;

function fechaRelatorioGerencial(vModeloEcf : String) : Integer; 
var
  vDsRespota : String; 
begin
  try
    if (vModeloEcf = 'ecfBematech') or (vModeloEcf = 'ecfYanco') then begin
      result := Bematech_FI_FechaRelatorioGerencial();
    end else if (vModeloEcf = 'ecfElgin') then begin
      result := Elgin_FechaRelatorioGerencial();
    end else if (vModeloEcf = 'ecfInterway') or (vModeloEcf = 'ecfUrano') then begin
      result := DLLG2_ExecutaComando(Handle,'EncerraDocumento');
    end else if (vModeloEcf = 'ecfDaruma') then begin
      result := iRGFechar_ECF_Daruma;
    end else if (vModeloEcf = 'ecfSweda') then begin
      result := ECF_FechaRelatorioGerencial();
    end else if (vModeloEcf = 'ecfEpson') then begin
      result := EPSON_NaoFiscal_Fechar_Relatorio_Gerencial(true);
    end;
  except
    on E : Exception do ShowMessage(E.Message);
  end;
end;

function sangria(vModeloEcf : String; vValor : String) : Integer;
var
  vVlValor : Real;
  vCodresult : integer;
  vResult    : string;
begin
  try
    if (vModeloEcf = 'ecfBematech') or (vModeloEcf = 'ecfYanco') then begin
      result := Bematech_FI_Sangria(PChar(vValor));
    end else if (vModeloEcf = 'ecfElgin') then begin
      result := Elgin_Sangria(PChar(vValor));
    end else if (vModeloEcf = 'ecfInterway') then begin
      vVlValor := StrToFloatDef(trim(vValor), 0);
      vVlValor := vVlValor / 100;
      vValor := FloatToStr(vVlValor);
      DLLG2_ExecutaComando(Handle, 'EmiteItemNaoFiscal;NomeNaoFiscal="Sangria";Valor=' + vValor);
      DLLG2_ExecutaComando(Handle, 'PagaCupom;CodMeioPagamento=-2 Valor=' + vValor);
      result := DLLG2_ExecutaComando(Handle, 'EncerraDocumento');
    end else if (vModeloEcf = 'ecfUrano') then begin
      vVlValor := StrToFloatDef(trim(vValor), 0);
      vValor := FloatToStr(vVlValor);
      Result := DLLG2_ExecutaComando(Handle, 'EmiteItemNaoFiscal;NomeNaoFiscal="Sandria" Valor=' + vValor);
      result := DLLG2_ExecutaComando(Handle, 'EncerraDocumento');
    end else if (vModeloEcf = 'ecfDaruma') then begin
      result := iSangria_ECF_Daruma(vValor, '');
    end else if (vModeloEcf = 'ecfSweda') then begin
      result := ECF_Sangria(PChar(vValor));
    end else if (vModeloEcf = 'ecfEpson') then begin
      if trim(vValor)= '' then  vValor := '0';
      vValor := FormatFloat('0', StrToFloatDef(vValor, 0));
      result := EPSON_NaoFiscal_Sangria(PChar(vValor), 2);
    end;
  except
    on E : Exception do ShowMessage(E.Message);
  end;
end;

function suprimento(vModeloEcf : String; vValor : String) : Integer;
var
  vVlValor : Real;
  vCodresult : integer;
  vResult    : string;
begin
  try
    if (vModeloEcf = 'ecfBematech') or (vModeloEcf = 'ecfYanco') then begin
      result := Bematech_FI_Suprimento(PChar(vValor), PChar('Dinheiro'));
    end else if (vModeloEcf = 'ecfElgin') then begin
      result := Elgin_Suprimento(PChar(vValor), PChar('Dinheiro'));
    end else if (vModeloEcf = 'ecfInterway') then begin
      vVlValor := StrToFloatDef(trim(vValor), 0);
      vVlValor := vVlValor / 100;
      vValor := FloatToStr(vVlValor);
      DLLG2_ExecutaComando(Handle, 'EmiteItemNaoFiscal;NomeNaoFiscal="Suprimento";Valor=' + vValor);
      result := DLLG2_ExecutaComando(Handle, 'EncerraDocumento');
    end else if (vModeloEcf = 'ecfUrano') then begin
      vVlValor := StrToFloatDef(trim(vValor), 0);
      vValor := FloatToStr(vVlValor);
      Result := DLLG2_ExecutaComando(Handle, 'EmiteItemNaoFiscal;NomeNaoFiscal="Suprimento" Valor=' + vValor);
      DLLG2_ExecutaComando(Handle, 'PagaCupom;CodMeioPagamento=-2 Valor=' + vValor);
      result := DLLG2_ExecutaComando(Handle,'EncerraDocumento');
    end else if (vModeloEcf = 'ecfDaruma') then begin
      result := iSuprimento_ECF_Daruma(vValor, '');
    end else if (vModeloEcf = 'ecfSweda') then begin
      result := ECF_Suprimento(PChar(vValor), PChar('Dinheiro'));
    end else if (vModeloEcf = 'ecfEpson') then begin
      if trim(vValor)= '' then vValor := '0';
      vValor := FormatFloat('0', StrToFloatDef(vValor, 0));
      result := EPSON_NaoFiscal_Fundo_Troco(PChar(vValor), 2); 
    end; 
  except
    on E : Exception do ShowMessage(E.Message); 
  end; 
end; 

function recebimentoNaoFiscal(vModeloEcf : String; vIndice : String; vValor : String; vFormaPagamento : String) : Integer;
var
  vDsCdPagamento, vDescTotalizador, vDsInformacao, vCodPagamento : String; vVlValor : Real;
  vPosicao : Integer;
begin
  try
    if (vModeloEcf = 'ecfBematech') or (vModeloEcf = 'ecfYanco') then begin
      result := Bematech_FI_RecebimentoNaoFiscal(PChar(vIndice), PChar(vValor), PChar(vFormaPagamento));
    end else if (vModeloEcf = 'ecfElgin') then begin
      result := Elgin_RecebimentoNaoFiscal(PChar(vIndice), PChar(vValor), PChar(vFormaPagamento));
    end else if (vModeloEcf = 'ecfInterway') then begin
      vDsCdPagamento := '';
      if (trim(vFormaPagamento) = 'Dinheiro') then begin
        vDsCdPagamento := '-2';
      end;
      vVlValor := StrToFloatDef(trim(vValor), 0);
      vVlValor := vVlValor / 100;
      vValor := FloatToStr(vVlValor);
      DLLG2_ExecutaComando(Handle, 'EmiteItemNaoFiscal;CodNaoFiscal=' + vIndice + ';Valor=' + vValor);
      if Trim(vFormaPagamento)= 'Dinheiro' then
        DLLG2_ExecutaComando(Handle, 'PagaCupom; CodMeioPagamento=-2 Valor=' + vValor)
      else
        DLLG2_ExecutaComando(Handle, 'PagaCupom; NomeMeioPagamento=' + '"' + vFormaPagamento + '"' + ' Valor=' + vValor);
      result := DLLG2_ExecutaComando(Handle, 'EncerraDocumento');
    end else if (vModeloEcf = 'ecfUrano') then begin
      vDsCdPagamento := '';
      if (trim(vFormaPagamento) = 'Dinheiro') then begin
        vDsCdPagamento := '-2';
      end;
      vVlValor := StrToFloatDef(trim(vValor), 0);
      vValor := FloatToStr(vVlValor);
      DLLG2_ExecutaComando(Handle, 'EmiteItemNaoFiscal;CodNaoFiscal=' + vIndice + ' Valor=' + vValor);
      if Trim(vFormaPagamento)= 'Dinheiro' then
        DLLG2_ExecutaComando(Handle, 'PagaCupom;CodMeioPagamento=-2 Valor=' + vValor)
      else
        DLLG2_ExecutaComando(Handle, 'PagaCupom;NomeMeioPagamento=' + '"' + vFormaPagamento + '"' + ' Valor=' + vValor);
      result := DLLG2_ExecutaComando(Handle, 'EncerraDocumento');
    end else if (vModeloEcf = 'ecfDaruma') then begin
      vValor := Copy(vValor, 4, 11);
      vIndice := Copy(vIndice, length(vIndice)-1, 2);
      SetLength(vDsInformacao, 84);

      Result := iCNFAbrir_ECF_Daruma(' ',' ',' ');
      Result := iCNFReceberSemDesc_ECF_Daruma(PChar(vIndice), PChar(vValor)); 
      Result := iCNFTotalizarComprovantePadrao_ECF_Daruma; 
      Result := iCNFEfetuarPagamento_ECF_Daruma(PChar(vFormaPagamento), PChar(vValor), vDsInformacao); 
      Result := iCNFEncerrarPadrao_ECF_Daruma; 
    end else if (vModeloEcf = 'ecfSweda') then begin
      result := ECF_RecebimentoNaoFiscal(PChar(vIndice), PChar(vValor), PChar(vFormaPagamento)); 
    end else if (vModeloEcf = 'ecfEpson') then begin
      VerificaFormasPagamento('ecfEpson'); 
      vPosicao := Pos(LowerCase(vFormaPagamento), LowerCase(vFormaPGTO)); 
      vCodPagamento := Copy(vFormaPGTO, vPosicao - 2, 2); 

      vValor := ReplaceStr(vValor, '.',''); 
      vValor := ReplaceStr(vValor, ',','');
      vValor := IntToStr(StrToIntDef(vValor, 0)); 

      result := EPSON_NaoFiscal_Abrir_Comprovante('','','','', 0); 

      if (result = 0) then result := EPSON_NaoFiscal_Vender_Item(PChar(vIndice), PChar(vValor), 2);
      if (result = 0) then result := EPSON_NaoFiscal_Pagamento(PChar(vCodPagamento), PChar(vValor), 2, '',''); 

      result := EPSON_NaoFiscal_Fechar_Comprovante(True); 
    end; 
  except
    on E : Exception do ShowMessage(E.Message);
  end; 
end; 

function dataHoraImpressora(vModeloEcf : String) : Integer; 
var
  iConta : Integer; 
  vData, vHora, vDsDados : String; 
begin
  try
    if (vModeloEcf = 'ecfBematech') or (vModeloEcf = 'ecfYanco') then begin
      vData := ReplicateStr(' ', 6); 
      vHora := ReplicateStr(' ', 6); 
      result := Bematech_FI_DataHoraImpressora(vData, vHora); 
      vData := Copy(vData, 1, 2) + '/' + Copy(vData, 3, 2) + '/' + Copy(vData, 5, 2); 
      vHora := Copy(vHora, 1, 2) + ':' + Copy(vHora, 3, 2) + ':' + Copy(vHora, 5, 2);
      vDataHora := vData + ' ' + vHora;
    end else if (vModeloEcf = 'ecfElgin') then begin
      vData := ReplicateStr(' ', 6);
      vHora := ReplicateStr(' ', 6);
      result := Elgin_DataHoraImpressora(vData, vHora);
      vData := Copy(vData, 1, 2) + '/' + Copy(vData, 3, 2) + '/' + Copy(vData, 5, 2);
      vHora := Copy(vHora, 1, 2) + ':' + Copy(vHora, 3, 2) + ':' + Copy(vHora, 5, 2);
      vDataHora := vData + ' ' +vHora;
    end else if (vModeloEcf = 'ecfInterway') or (vModeloEcf = 'ecfUrano') then begin
      DLLG2_ExecutaComando(Handle, 'LeData; NomeData="Data"');
      vData := DLLG2_ObtemRetornos(Handle, vData, 0);
      vData := fRetornaValor(vData, 'ValorData','#');

      result := DLLG2_ExecutaComando(Handle, 'LeHora; NomeHora="Hora"');
      vHora := DLLG2_ObtemRetornos(Handle, vHora, 0);
      vHora := fRetornaValor(vHora, 'ValorHora','#');

      vDataHora := vData + ' ' + vHora;
    end else if (vModeloEcf = 'ecfDaruma') then begin
      SetLength(vData, 8);
      SetLength(vHora, 6);
      Result := rDataHoraImpressora_ECF_Daruma(vData, vHora);
      vData := Copy(vData, 1, 2) + '/' + Copy(vData, 3, 2) + '/' + Copy(vData, 7, 2);
      vHora := Copy(vHora, 1, 2) + ':' + Copy(vHora, 3, 2) + ':' + Copy(vHora, 5, 2);
      vDataHora := vData + ' ' +vHora;
    end else if (vModeloEcf = 'ecfSweda') then begin
      vData := ReplicateStr(' ', 6);
      vHora := ReplicateStr(' ', 6);
      result := ECF_DataHoraImpressora(vData, vHora);
      vData := Copy(vData, 1, 2) + '/' + Copy(vData, 3, 2) + '/' + Copy(vData, 5, 2);
      vHora := Copy(vHora, 1, 2) + ':' + Copy(vHora, 3, 2) + ':' + Copy(vHora, 5, 2);
      vDataHora := vData + ' ' +vHora;
    end else if (vModeloEcf = 'ecfEpson') then begin
      SetLength(vDsDados, 15);
      Result := EPSON_Obter_Hora_Relogio(PChar(vDsDados));
      vData := Copy(vDsDados, 1, 8);
      vHora := Copy(vDsDados, 9, 6);
      vData := Copy(vData, 1, 2) + '/' + Copy(vData, 3, 2) + '/' + Copy(vData, 5, 4);
      vHora := Copy(vHora, 1, 2) + ':' + Copy(vHora, 3, 2) + ':' + Copy(vHora, 5, 2);
      vDataHora := vData + ' ' + vHora;
    end;
  except
    on E : Exception do ShowMessage(E.Message);
  end;

  vDataHora := TcFuncaoECF._validaDtImpressora(vDataHora);
end;

function autenticacao(vModeloEcf : String) : Integer;
var
  vDsTxt : String;
begin
  try
    if (vModeloEcf = 'ecfBematech') or (vModeloEcf = 'ecfYanco') then begin
      result := Bematech_FI_Autenticacao();
    end else if (vModeloEcf = 'ecfElgin') then begin
      result := Elgin_Autenticacao();
    end else if (vModeloEcf = 'ecfInterway') or (vModeloEcf = 'ecfUrano') then begin
      result := DLLG2_ExecutaComando(Handle, 'ImprimeAutenticacao;TempoEspera=8');
    end else if (vModeloEcf = 'ecfDaruma') then begin
      SetLength(vDsTxt, 48);
      Result := iAutenticarDocumento_DUAL_DarumaFramework(vDsTxt, '1','120');
    end else if (vModeloEcf = 'ecfSweda') then begin
      result := ECF_Autenticacao();
    end else if (vModeloEcf = 'ecfEpson') then begin
      result := EPSON_Autenticar_Imprimir(''); 
    end; 
  except
    on E : Exception do ShowMessage(E.Message); 
  end; 
end; 

function programaHorarioVerao(vModeloEcf : String) : Integer; 
begin
  try
    if (vModeloEcf = 'ecfBematech') or (vModeloEcf = 'ecfYanco') then begin
      result := Bematech_FI_ProgramaHorarioVerao(); 
    end else if (vModeloEcf = 'ecfElgin') then begin
      result := Elgin_ProgramaHorarioVerao(); 
    end else if (vModeloEcf = 'ecfInterway') or (vModeloEcf = 'ecfUrano') then begin
      result := DLLG2_ExecutaComando(Handle, 'AcertaHorarioVerao'); 
    end else if (vModeloEcf = 'ecfDaruma') then begin
      result := confHabilitarHorarioVerao_ECF_Daruma; 
    end else if (vModeloEcf = 'ecfSweda') then begin
      result := ECF_CfgHorarioVerao(PChar('1')); 
    end else if (vModeloEcf = 'ecfEpson') then begin
      result := EPSON_Config_Horario_Verao; 
    end; 
  except
    on E : Exception do ShowMessage(E.Message); 
  end; 
end; 

function dataHoraReducao(vModeloEcf : String) : Integer; 
var
  iConta : Integer;
  vData, vHora, vDsIndice, vDsDadosUltZ : String; 
begin
  try
    if (vModeloEcf = 'ecfBematech') or (vModeloEcf = 'ecfYanco') then begin
      vData := ReplicateStr(' ', 6); 
      vHora := ReplicateStr(' ', 6); 
      result := Bematech_FI_DataHoraReducao(PChar(vData), PChar(vHora)); 
      vDataHoraReducao := vData + ' - ' +vHora; 
    end else if (vModeloEcf = 'ecfElgin') then begin
      vData := ReplicateStr(' ', 6);
      vHora := ReplicateStr(' ', 6); 
      result := Elgin_DataHoraReducao(vData, vHora); 
      vDataHoraReducao := vData + ' - ' +vHora;
    end else if (vModeloEcf = 'ecfInterway') or (vModeloEcf = 'ecfUrano') then begin
      DLLG2_ExecutaComando(Handle,'LeInteiro;NomeInteiro="CRZ"');
      vDsIndice := DLLG2_ObtemRetornos(Handle,vDsIndice,0 );
      DLLG2_ExecutaComando(Handle,'LeData;NomeData="DataReducao['+vDsIndice+']"');
      vData  := DLLG2_ObtemRetornos(Handle,vData,0 );
      vData  := Copy(vData,12,10);
      result := DLLG2_ExecutaComando(Handle,'LeHora;NomeHora="HoraReducao['+vDsIndice+']"');
      vHora  := DLLG2_ObtemRetornos(Handle,vHora,0 );
      vHora  := Copy(vHora,12,8);
      vDataHora := vData + ' - ' + vHora;
    end else if (vModeloEcf = 'ecfDaruma') then begin
      SetLength(vDsDadosUltZ, 14); 
      result := rRetornarInformacao_ECF_Daruma('154', vDsDadosUltZ); 
      vDataHoraReducao := copy(vDsDadosUltZ, 1, 8) + ' ' + copy(vDsDadosUltZ, 9, 6); 
    end else if (vModeloEcf = 'ecfSweda') then begin
      vData := ReplicateStr(' ', 6); 
      vHora := ReplicateStr(' ', 6); 
      result := ECF_DataHoraReducao(PChar(vData), PChar(vHora)); 
      vDataHoraReducao := vData + ' - ' +vHora; 
    end else if (vModeloEcf = 'ecfEpson') then  begin
       SetLength(vDsDadosUltZ, 1148); 
       Result := EPSON_Obter_Dados_Ultima_RZ(PChar(vDsDadosUltZ)); 
       vDataHoraReducao := Copy(vDsDadosUltZ, 1, 7) + ' ' + Copy(vDsDadosUltZ, 8, 6); 
    end; 
  except
    on E : Exception do ShowMessage(E.Message);
  end; 
end; 

function dataHoraReducaoMFD(vModeloEcf : String) : Integer; 
var
  vCont : Integer; 
  vDataUltimaReducao : String; 
begin
  try
    if (vModeloEcf = 'ecfBematech') or (vModeloEcf = 'ecfYanco') then begin
      vDataUltimaReducao := ReplicateStr(' ', 7); 
      result := Bematech_FI_DataMovimentoUltimaReducaoMFD(vDataUltimaReducao); 
      vDataHora := Copy(vDataUltimaReducao, 1, 2) + '/' + Copy(vDataUltimaReducao, 3, 2) + '/' + Copy(vDataUltimaReducao, 5, 2); 
      vDataHora := FormatDateTime('dd/mm/yyyy', StrToDateDef(vDataHora, 0)); 
      vDataHora := vDataHora;
    end else if (vModeloEcf = 'ecfElgin') then begin
    end else if (vModeloEcf = 'ecfInterway') or (vModeloEcf = 'ecfUrano') then begin
      Result := dataHoraReducao(vModeloEcf);
    end else if (vModeloEcf = 'ecfDaruma') then begin
    end else if (vModeloEcf = 'ecfSweda') then begin
    end; 
  except
    on E : Exception do ShowMessage(E.Message); 
  end; 
end; 

function verificaTotalizadoresNaoFiscais(vModeloEcf : String) : Integer; 
var
  iConta : Integer; 
  vDsTotalizadorAtual : String;
begin
  try
    if (vModeloEcf = 'ecfBematech') or (vModeloEcf = 'ecfYanco') then begin
      vTotalizadoresNaoFiscais := ReplicateStr(' ', 179); 
      result := Bematech_FI_VerificaTotalizadoresNaoFiscais(vTotalizadoresNaoFiscais); 
    end else if (vModeloEcf = 'ecfElgin') then begin
      vTotalizadoresNaoFiscais := ReplicateStr(' ', 179); 
      result := Elgin_VerificaTotalizadoresNaoFiscais(vTotalizadoresNaoFiscais); 
    end else if (vModeloEcf = 'ecfInterway') or (vModeloEcf = 'ecfUrano') then begin
      vTotalizadoresNaoFiscais := '';
      for iConta := 0  to 15 do begin // 14 é o limite máximo de totalizadores não fiscais
        result := DLLG2_ExecutaComando(Handle, 'LeNaoFiscal;CodNaoFiscal=' + IntToSTr(iConta));
        vDsTotalizadorAtual := DLLG2_ObtemRetornos(Handle, vDsTotalizadorAtual, 0);
        if (vDsTotalizadorAtual <> '') then begin
          vDsTotalizadorAtual := fRetornaValor(vDsTotalizadorAtual, 'NomeNaoFiscal','"');
          if (vTotalizadoresNaoFiscais = '') then
            vTotalizadoresNaoFiscais := vDsTotalizadorAtual
          else
            vTotalizadoresNaoFiscais := vTotalizadoresNaoFiscais + ' , ' + vDsTotalizadorAtual;
        end;
      end;
    end else if (vModeloEcf = 'ecfDaruma') then begin
      SetLength(vTotalizadoresNaoFiscais, 300); 
      result := rLerCNF_ECF_Daruma(vTotalizadoresNaoFiscais); 
    end else if (vModeloEcf = 'ecfSweda') then begin
      result := Captura_Dados_Progamados_Sweda(4, vTotalizadoresNaoFiscais); 
    end else if (vModeloEcf = 'ecfEpson') then begin
      SetLength(vTotalizadoresNaoFiscais, 681); 
      result := EPSON_Obter_Tabela_NaoFiscais(PChar(vTotalizadoresNaoFiscais));
    end; 
  except
    on E : Exception do ShowMessage(E.Message); 
  end; 
end; 

function verificaFormasPagamento(vModeloEcf : String) : Integer; 
var
  iConta, vTamanho : Integer; 
  vDsPgtoAtual : String; 
begin
  try
    if (vModeloEcf = 'ecfBematech') or (vModeloEcf = 'ecfYanco') then begin
      vFormaPgto := ReplicateStr(' ', 3016);
      result := Bematech_FI_VerificaFormasPagamento(vFormaPgto);
    end else if (vModeloEcf = 'ecfElgin') then begin
      vFormaPgto := ReplicateStr(' ', 3016);
      result := Elgin_VerificaFormasPagamento(vFormaPgto);
    end else if (vModeloEcf = 'ecfInterway') or (vModeloEcf = 'ecfUrano') then begin
      vFormaPgto := '';
      DLLG2_ExecutaComando(Handle, 'LeMeioPagamento; CodMeioPagamentoProgram=-2');
      vDsPgtoAtual := DLLG2_ObtemRetornos(Handle, vDsPgtoAtual, 0);
      if (vDsPgtoAtual <> '') then begin
        vDsPgtoAtual := fRetornaValor(vDsPgtoAtual, 'NomeMeioPagamento','"');
        vFormaPgto := vFormaPgto + ',' + vDsPgtoAtual;
      end;
      for iConta := 0  to 15 do begin // 14 é o limite máximo de totalizadores não fiscais
        DLLG2_ExecutaComando(Handle, 'LeMeioPagamento; CodMeioPagamentoProgram=' + IntToSTr(iConta));
        vDsPgtoAtual := DLLG2_ObtemRetornos(Handle, vDsPgtoAtual, 0);
        if (vDsPgtoAtual <> '') then begin
          vDsPgtoAtual := fRetornaValor(vDsPgtoAtual, 'NomeMeioPagamento','"');
          vFormaPgto := vFormaPgto + ',' + vDsPgtoAtual;
        end;
      end;
      vFormaPgto := vFormaPgto + ',';

      // como o laço testa todas as opções possível de condições de pagamento, o ultimo retorno provavelmente
      // é de erro, pois o indice da condição de pagamento não foi encontrado, resultando em erro no virtual monitor
      // para não dar erro no comandos, foi movido o valor 9999 que indica para não ser testado o retorno do comando
      result := 9999; // para não testar o retorno da impressora.
    end else if (vModeloEcf = 'ecfDaruma') then begin
      vFormaPGTO := StringOfChar(#0, 330); 
      result := rLerMeiosPagto_ECF_Daruma(vFormaPGTO); 
      vFormaPGTO := Trim(vFormaPGTO);
      vFormaPGTO := AnsiReplaceStr(vFormaPGTO, ';', ',');
    end else if (vModeloEcf = 'ecfSweda') then begin
      result := Captura_Dados_Progamados_Sweda(2, vFormaPgto); 
    end else if (vModeloEcf = 'ecfEpson') then begin
      SetLength(vFormaPGTO, 881); 
      Result := EPSON_Obter_Tabela_Pagamentos(PChar(vFormaPGTO)); 
      vFormaPgto := LimpaFormaPagamento(vModeloEcf, vFormaPgto); 
    end; 
  except
    on E : Exception do ShowMessage(E.Message); 
  end; 
end; 

function retornoAliquotas(vModeloEcf : String) : Integer;
var
  iConta : Integer; 
  vDsAliquotaAtual : String;
begin
  try
    if (vModeloEcf = 'ecfBematech') or (vModeloEcf = 'ecfYanco') then begin
      vAliquotas := ReplicateStr(' ', 79); 
      result := Bematech_FI_RetornoAliquotas(vAliquotas); 
    end else if (vModeloEcf = 'ecfElgin') then begin
      vAliquotas := ReplicateStr(' ', 79); 
      result := Elgin_RetornoAliquotas(vAliquotas);
    end else if (vModeloEcf = 'ecfInterway') or (vModeloEcf = 'ecfUrano') then begin
      vAliquotas := '';
      for iConta := 0  to 16 do begin
        result := DLLG2_ExecutaComando(Handle, 'LeAliquota; CodAliquotaProgramavel=' + IntToSTr(iConta));
        vDsAliquotaAtual := DLLG2_ObtemRetornos(Handle, vDsAliquotaAtual, 0);
        if (vDsAliquotaAtual <> '') then begin
          vDsAliquotaAtual := fRetornaValor(vDsAliquotaAtual, 'PercentualAliquota','');
          if (vAliquotas = '') then
            vAliquotas := vDsAliquotaAtual
          else
            vAliquotas := vAliquotas + ' , ' + vDsAliquotaAtual;
        end;
      end;
      // como o laço testa todas as opções possível de aliquotas, o ultimo retorno provavelmente
      // é de erro, pois o indice da aliquota não foi encontrado, resultando em erro no virtual monitor
      // para não dar erro no comando, foi movido o valor 9999 que indica para não ser testado o retorno do comando
      result := 9999; // para não testar o retorno da impressora.
    end else if (vModeloEcf = 'ecfDaruma') then begin
      SetLength(vAliquotas, 330);
      result := rLerAliquotas_ECF_Daruma(vAliquotas); 
    end else if (vModeloEcf = 'ecfSweda') then begin
      result := Captura_Dados_Progamados_Sweda(1, vAliquotas); 
    end else if (vModeloEcf = 'ecfEpson') then begin
      vAliquotas := ReplicateStr(' ', 533); 
      Result := EPSON_Obter_Tabela_Aliquotas(PChar(vAliquotas)); 
      vAliquotas := LimpaAliquotas(vModeloEcf, vAliquotas); 
    end; 
  except
    on E : Exception do ShowMessage(E.Message); 
  end; 
end; 

function leituraChequeMFD(vModeloEcf : String) : Integer; 
begin
  try
    if (vModeloEcf = 'ecfBematech') or (vModeloEcf = 'ecfYanco') then begin
      setlength(vDsCMC7, 36);
      result := Bematech_FI_LeituraChequeMFD(vDsCMC7); 
    end else if (vModeloEcf = 'ecfElgin') then begin
      setlength(vDsCMC7, 36); 
      result := Elgin_LeituraCheque(vDsCMC7); 
    end else if (vModeloEcf = 'ecfInterway') or (vModeloEcf = 'ecfUrano') then begin

    end else if (vModeloEcf = 'ecfDaruma') then begin

    end else if (vModeloEcf = 'ecfSweda') then begin
      setlength(vDsCMC7, 36); 
      result := ECF_LeituraChequeMFD(vDsCMC7); 
    end else if (vModeloEcf = 'ecfEpson') then begin
      setLength(vDsCMC7, 257); 
      result := EPSON_Cheque_Ler_MICR(PChar(vDsCMC7)); 
    end; 
  except
    on E : Exception do ShowMessage(E.Message); 
  end; 
end; 

function cancelaImpressaoCheque(vModeloEcf : String) : Integer; 
begin
  try
    if (vModeloEcf = 'ecfBematech') or (vModeloEcf = 'ecfYanco') then begin
      result := Bematech_FI_CancelaImpressaoCheque(); 
    end else if (vModeloEcf = 'ecfElgin') then begin
      result := Elgin_CancelaImpressaoCheque(); 
    end else if (vModeloEcf = 'ecfInterway') or (vModeloEcf = 'ecfUrano') then begin

    end else if (vModeloEcf = 'ecfDaruma') then begin

    end else if (vModeloEcf = 'ecfSweda') then begin
      result := ECF_CancelaImpressaoCheque(); 
    end else if (vModeloEcf = 'ecfEpson') then begin
      result := EPSON_Cheque_Cancelar_Impressao; 
    end; 
  except
    on E : Exception do ShowMessage(E.Message); 
  end; 
end; 

function verificaStatusCheque(vModeloEcf : String) : Integer;
var
  iStatusCheque : Integer;
  vDsStatusCheque : String;
begin
  try
    if (vModeloEcf = 'ecfBematech') or (vModeloEcf = 'ecfYanco') then begin
      iStatusCheque := 0;
      result := Bematech_FI_VerificaStatusCheque(iStatusCheque);
      vStatusCheque := IntToStr(iStatusCheque);
    end else if (vModeloEcf = 'ecfElgin') then begin
      iStatusCheque := 0;
      result := Elgin_VerificaStatusCheque(iStatusCheque);
      vStatusCheque := IntToStr(iStatusCheque);
    end else if (vModeloEcf = 'ecfInterway') or (vModeloEcf = 'ecfUrano') then begin

    end else if (vModeloEcf = 'ecfDaruma') then begin
      Result := rConsultaStatusImpressoraStr_ECF_Daruma(15, vDsStatusCheque); 
      vStatusCheque := vDsStatusCheque; 
    end else if (vModeloEcf = 'ecfSweda') then begin
      iStatusCheque := 0; 
      result := ECF_VerificaStatusCheque(iStatusCheque); 
      vStatusCheque := IntToStr(iStatusCheque); 
    end; 
  except
    on E : Exception do ShowMessage(E.Message); 
  end; 
end;

function imprimeCheque(vModeloEcf : String; Banco : String; Valor : String; Favorecido : String; Cidade : String; Data : String; Mensagem : String) : Integer; 
begin
  try
    if (vModeloEcf = 'ecfBematech') or (vModeloEcf = 'ecfYanco') then begin
      result := Bematech_FI_ImprimeCheque(PChar(Banco), PChar(Valor), PChar(Favorecido), PChar(Cidade), PChar(Data), PChar(Mensagem)); 
    end else if (vModeloEcf = 'ecfElgin') then begin
      result := Elgin_ImprimeCheque(PChar(Banco), PChar(Valor), PChar(Favorecido), PChar(Cidade), PChar(Data), PChar(Mensagem)); 
    end else if (vModeloEcf = 'ecfInterway') or (vModeloEcf = 'ecfUrano') then begin

    end else if (vModeloEcf = 'ecfDaruma') then begin
      result :=  iChequeImprimir_FS2100_Daruma(PChar(Banco), PChar(Cidade), PChar(Data), PChar(Favorecido), ' ', PChar(Valor)); 
    end else if (vModeloEcf = 'ecfSweda') then begin
      result := ECF_ImprimeCheque(PChar(Banco), PChar(Valor), PChar(Favorecido), PChar(Cidade), PChar(Data), PChar(Mensagem)); 
    end else if (vModeloEcf = 'ecfEpson') then begin
      result := EPSON_Cheque_Imprimir('01', PChar(Valor), 2, PChar(Favorecido), PChar(Cidade), PChar(Data), PChar(Mensagem)); 
    end; 
  except
    on E : Exception do ShowMessage(E.Message); 
  end; 
end;

function relatorioGerencial(vModeloEcf : String; vConteudo : String) : Integer;
var
  vstLista : TStringList;
  i : Integer;
  vLinha,vResult : String;
begin
  try
    if (vModeloEcf = 'ecfBematech') or (vModeloEcf = 'ecfYanco') then begin
      vConteudo := '';
      vDsResposta := LeituraIndicadores(vModeloEcf);
      if (vDsResposta = 'Impressora Vendendo') or (vDsResposta = 'Impressora Pagamento') then begin
        result := Bematech_FI_CancelaCupom();
      end;
      result := Bematech_FI_RelatorioGerencial(vConteudo);
    end else if (vModeloEcf = 'ecfElgin') then begin
      result := Elgin_RelatorioGerencial(PChar(vConteudo));
    end else if (vModeloEcf = 'ecfInterway') or (vModeloEcf = 'ecfUrano') then begin
      if (trim(vConteudo) = 'RELATORIO GERENCIAL') then  // identifica que é para abrir o relatório gerencial
        result := DLLG2_ExecutaComando(Handle, 'AbreGerencial; NomeGerencial="RELATORIO"')
      else begin
        result := DLLG2_ExecutaComando(Handle, 'ImprimeTexto;TextoLivre="' + vConteudo + '"');
      end;
    end else if (vModeloEcf = 'ecfDaruma') then begin
      result := iRGImprimirTexto_ECF_Daruma(vConteudo);
    end else if (vModeloEcf = 'ecfSweda') then begin
      vConteudo := '';
      vDsResposta := LeituraIndicadores(vModeloEcf);
      if (vDsResposta = 'Impressora Vendendo') or (vDsResposta = 'Impressora Pagamento') then begin
        result := ECF_CancelaCupom();
      end;
      result := ECF_RelatorioGerencial(vConteudo);
    end else if (vModeloEcf = 'ecfEpson') then  begin
       if (trim(vConteudo)= 'RELATORIO GERENCIAL') then  // identifica que é para abrir o relatório gerencial
         result := EPSON_NaoFiscal_Abrir_Relatorio_Gerencial('1')
       else begin
         try
           vstLista := TStringList.Create;
           vstLista.Text := vConteudo;
           for i := 0 to vstLista.Count - 1 do begin
             vLinha := vstLista.Strings[i];
             result := EPSON_NaoFiscal_Imprimir_Linha(PChar(vLinha));
           end;
         finally
           vstLista.Free;
         end;
       end;
    end;
  except
    on E : Exception do ShowMessage(E.Message);
  end;
end;

function verificaEstadoGaveta(vModeloEcf : String) : Integer;
begin
  try
    if (vModeloEcf = 'ecfBematech') or (vModeloEcf = 'ecfYanco') then begin
      result := Bematech_FI_VerificaEstadoGaveta(iEstadoGaveta);
    end else if (vModeloEcf = 'ecfElgin') then begin
      result := Elgin_VerificaEstadoGaveta(iEstadoGaveta);
    end else if (vModeloEcf = 'ecfInterway') or (vModeloEcf = 'ecfUrano') then begin
      result := DLLG2_ExecutaComando(Handle, 'SensorGaveta');
    end else if (vModeloEcf = 'ecfDaruma') then begin
      result := rStatusGaveta_ECF_Daruma(iEstadoGaveta);
    end else if (vModeloEcf = 'ecfSweda') then begin
      result := ECF_VerificaEstadoGaveta(iEstadoGaveta); 
    end else if (vModeloEcf = 'ecfEpson') then begin
      //Result := VERIFICAR AQUI
    end;
  except
    on E : Exception do ShowMessage(E.Message); 
  end; 
end; 

function abreGaveta(vModeloEcf : String) : Integer; 
begin
  try
    if (vModeloEcf = 'ecfBematech') or (vModeloEcf = 'ecfYanco') then begin
      result := Bematech_FI_AcionaGaveta(); 
    end else if (vModeloEcf = 'ecfElgin') then begin
      result := Elgin_AcionaGaveta(); 
    end else if (vModeloEcf = 'ecfInterway') or (vModeloEcf = 'ecfUrano') then begin
      result := DLLG2_ExecutaComando(Handle, 'AbreGaveta');
    end else if (vModeloEcf = 'ecfDaruma') then begin
      result := eAbrirGaveta_ECF_Daruma;
    end else if (vModeloEcf = 'ecfSweda') then begin
      result := ECF_AcionaGaveta();
    end else if (vModeloEcf = 'ecfEpson') then begin
      result := EPSON_Impressora_Abrir_Gaveta;
    end;
  except
    on E : Exception do ShowMessage(E.Message);
  end;
end;

function testarPortaSerial(vModeloEcf : String; vPorta : String) : Integer;
var
  vResult : string;
begin
  try
    if (vModeloEcf = 'ecfBematech') or (vModeloEcf = 'ecfYanco') then begin
      result := Bematech_FI_AbrePortaSerial;
    end else if (vModeloEcf = 'ecfElgin') then begin
      result := Elgin_AbrePortaSerial();
    end else if (vModeloEcf = 'ecfInterway') or (vModeloEcf = 'ecfUrano') then begin
      if vPorta = '' then
        vPorta := 'COM1';

      Handle := DLLG2_IniciaDriver(PChar(vPorta));
      Result := Handle;
      DLLG2_DefineTimeout(Handle, 50);
    end else if (vModeloEcf = 'ecfDaruma') then begin
      result := eAbrirSerial_Daruma(PChar(vPorta), '9600');
    end else if (vModeloEcf = 'ecfSweda') then begin
      result := ECF_AbrePortaSerial;
    end else if (vModeloEcf = 'ecfEpson') then begin
      result := EPSON_Serial_Abrir_PortaEx;
    end;
  except
    on E : Exception do ShowMessage(E.Message);
  end;
end;

function cortarPapel(vModeloEcf : String) : Integer;
begin
  try
    if (vModeloEcf = 'ecfBematech') or (vModeloEcf = 'ecfYanco') then begin
      result := Bematech_FI_AcionaGuilhotinaMFD(0);
    end else if (vModeloEcf = 'ecfElgin') then begin
      result := Elgin_AcionaGuilhotinaMFD(1);
    end else if (vModeloEcf = 'ecfInterway') or (vModeloEcf = 'ecfUrano') then begin
      result := DLLG2_ExecutaComando(Handle, 'CortaPapel; TipoCorte=0');
    end else if (vModeloEcf = 'ecfDaruma') then begin
      result := eAcionarGuilhotina_ECF_Daruma('1');
    end else if (vModeloEcf = 'ecfSweda') then begin
      result := ECF_AtivaDesativaCorteProximoMFD(1);
    end else if (vModeloEcf = 'ecfEpson') then begin
      result := EPSON_Impressora_Cortar_Papel();
    end;
  except
    on E : Exception do ShowMessage(E.Message);
  end;
end;

function avancaLinhaCortarPapel(vModeloEcf : String; Linhas : Integer) : Integer;
var
  i : Integer;
begin
  try
    if (vModeloEcf = 'ecfBematech') or (vModeloEcf = 'ecfYanco') then begin
      result :=  Bematech_FI_AvancaPapelAcionaGuilhotinaMFD(Linhas, 0);
    end else if (vModeloEcf = 'ecfElgin') then begin

    end else if (vModeloEcf = 'ecfInterway') or (vModeloEcf = 'ecfUrano') then begin
      for I :=1 to Linhas do begin
        result := DLLG2_ExecutaComando(Handle,'AvancaPapel;Avanco=50'); // altura de uma linha aproximadamente
      end;
    end else if (vModeloEcf = 'ecfDaruma') then begin

    end else if (vModeloEcf = 'ecfSweda') then begin

    end else if (vModeloEcf = 'ecfEpson') then  begin
      EPSON_Impressora_Avancar_Papel(Linhas);
      result := EPSON_Impressora_Cortar_Papel();
    end;
  except
    on E : Exception do ShowMessage(E.Message);
  end;
end;

function verificaEstadoImpressora(vModeloEcf : String) : Integer;
var
  iAck, iSt1, iSt2, Indicadores, iConta : Integer;
  vDsStatus, Str_Informacao : String;
begin
  iAck := 0;
  iSt1 := 0;
  iSt2 := 0;
  try
    if (vModeloEcf = 'ecfBematech') or (vModeloEcf = 'ecfYanco') then begin
      result := Bematech_FI_VerificaEstadoImpressora(iAck, iSt1, iSt2);
    end else if (vModeloEcf = 'ecfElgin') then begin
      result := Elgin_VerificaEstadoImpressora(iAck, iSt1, iSt2);
    end else if (vModeloEcf = 'ecfInterway') or (vModeloEcf = 'ecfUrano') then begin
      result := DLLG2_ExecutaComando(0,'LeInteiro;NomeInteiro="EstadoGeralECF"');
      if retornoImpressoraErro(vModeloEcf, result) then Exit;

      vDsStatus := DLLG2_ObtemRetornos(Handle, vDsStatus, 0);
      vDsStatus := fRetornaValor(vDsStatus, 'ValorInteiro','');
      if trim(vDsStatus) <> '0' then Begin
        Result := STS_ECFCUPOMAB; Exit;
      end;

      Result := 1;
    end else if (vModeloEcf = 'ecfDaruma') then begin
      setLength(vDsStatus, 14);
      result := rStatusImpressora_ECF_Daruma(vDsStatus);
    end else if (vModeloEcf = 'ecfSweda') then begin
      result := ECF_VerificaEstadoImpressora(iAck, iSt1, iSt2);
    end else if (vModeloEcf = 'ecfEpson') then begin
      Str_Informacao := Str_Informacao + ReplicateStr(' ', 57);
      EPSON_Obter_Estado_Cupom(PChar(Str_Informacao));
    end;
  except
    on E : Exception do ShowMessage(E.Message);
  end;
end;

function leituraIndicadores(vModeloEcf : String) : String;
var
  Indicadores : Integer;
  vNrIndicadores : String;
begin
  try
    if (vModeloEcf = 'ecfBematech') or (vModeloEcf = 'ecfYanco') then begin
      Bematech_FI_FlagsFiscais(vFlagFiscal);
      Result := Descricao_FlagFiscais_Bematech(vFlagFiscal);
    end else if (vModeloEcf = 'ecfElgin') then begin
      Elgin_LeIndicadores(Indicadores);
      Result := Elgin_LeIndicadoresDescricao(Indicadores);
    end else if (vModeloEcf = 'ecfInterway') or (vModeloEcf = 'ecfUrano') then begin
      DLLG2_ExecutaComando(Handle, 'LeInteiro; NomeInteiro="Indicadores"');
      vNrIndicadores := DLLG2_ObtemRetornos(Handle, vNrIndicadores, 10);
      Indicadores := itemI('ValorInteiro', vNrIndicadores);
      putitemXml(Result, 'NR_INDICADORES', Indicadores);
    end else if (vModeloEcf = 'ecfDaruma') then begin

    end else if (vModeloEcf = 'ecfSweda') then begin
      ECF_FlagsFiscais(vFlagFiscal);
      Result := ECF_FlagsFiscaisDescricao(vFlagFiscal);
    end;
  except
    on E : Exception do ShowMessage(E.Message);
  end;
end;

//-----------------------------------
function retornoImpressora(vModeloEcf : String; Retorno : Integer) : String;
const
  cDS_METHOD = 'T_ECFSVCO011._retornoImpressora()';
var
  vRetorno, vDetalhe, vDsRetorno, vDsAviso, vMsgNumErro : String;
  vNumErro, vNumAviso : Integer;
  vStatus : Variant;
begin
  Result := '';

  try
    if (vModeloEcf = 'ecfBematech') or (vModeloEcf = 'ecfYanco') then begin
      // retorno igual a UM foi executado com sucesso
      // diferente de UM verificar tabela de erro
      vRetorno := Analisa_Retorno_Bematech(Retorno); // descritiva
      vDetalhe := Retorno_Impressora_Bematech(vStatus); // codigo do erro
      if (vRetorno <> '') then begin
        Result := SetStatus(STS_ERROR_ECF, 'BEMA(' + IntToStr(iRetorno) + ')', vRetorno + iff(vRetorno<>'',' / ') + vDetalhe, cDS_METHOD);
        return(STS_ERROR_ECF); exit;
      end else if (vStatus = STS_ERROR) then begin
        Result := SetStatus(STS_ERROR_ECF, 'BEMA(' + IntToStr(iRetorno) + ')', vDetalhe, cDS_METHOD);
        return(STS_ERROR_ECF); exit;
      end else if (vStatus = STS_POUCO_PAPEL) then begin
        MensagemBal('Pouco papel', 25);
      end;

    end else if (vModeloEcf = 'ecfDaruma') then begin
      //Variaveis devem ser inicializadas
      vNumErro := 0;
      vNumAviso := 0;
      vMsgNumErro := StringOFChar(' ', 300);
      vDsAviso := StringOFChar(' ', 300);
      vDsRetorno := StringOFChar(' ', 300);

      // Retorna a mensagem referente ao erro e aviso do ultimo comando enviado
      vNumErro := eRetornarAvisoErroUltimoCMD_ECF_Daruma(vDsAviso, vMsgNumErro);

      // Retorno do método
      vStatus := eInterpretarRetorno_ECF_Daruma(Retorno, vDsRetorno);

      if (Pos('Alíquota (Situação tributária) não programada', vDsRetorno)  > 0) then begin
        vMsgNumErro := Trim(vDsRetorno);
        vNumErro := -1;
      end;

      if (vNumErro <= 0) and (Trim(vMsgNumErro) <> 'Sem Erro') then begin
        Result := SetStatus(STS_ERROR_ECF, 'DARUMA(' + IntToStr(vNumErro) + ')', Trim(vMsgNumErro), cDS_METHOD);
        return(STS_ERROR_ECF); exit;
      end;

    end else if (vModeloEcf = 'ecfElgin') then begin
      // retorno igual a UM foi executado com sucesso
      // diferente de UM verificar tabela de erro
      vRetorno := TrataErroElgin(Retorno);
      if (vRetorno <> '') then begin
        Result := SetStatus(STS_ERROR_ECF, 'ELGIN(' + IntToStr(iRetorno) + ')', vRetorno + iff(vRetorno<>'',' / ') + vDetalhe, cDS_METHOD);
        return(STS_ERROR_ECF); exit;
      end else if (vStatus = STS_ERROR) then begin
        Result := SetStatus(STS_ERROR_ECF, 'ELGIN(' + IntToStr(iRetorno) + ')', vDetalhe, cDS_METHOD);
        return(STS_ERROR_ECF); exit;
      end else if (vStatus = STS_POUCO_PAPEL) then begin
        MensagemBal('Pouco papel', 25);
      end;

    end else if (vModeloEcf = 'ecfEpson') then begin
      // retorno igual a ZERO foi executado com sucesso
      // diferente de ZERO verificar tabela de erro
      result := atualizaRetornoEpson(Retorno);
      if (Retorno <> 0) and (Result <> '') then begin
        Result := SetStatus(STS_ERROR_ECF, 'EPSON(' + IntToStr(Retorno) + ')', Result, cDS_METHOD);
        return(STS_ERROR_ECF); exit;
      end;

    end else if (vModeloEcf = 'ecfInterway') or (vModeloEcf = 'ecfUrano') then begin
      // retorno igual a ZERO foi executado com sucesso
      // diferente de ZERO verificar tabela de erro
      if (retorno = STS_ECFCUPOMAB) then begin
        Result := SetStatus(STS_ERROR_ECF, 'URANO(' + IntToStr(STS_ECFCUPOMAB) + ')','Impressora contem cupom aberto', cDS_METHOD);
        return(STS_ERROR_ECF); exit;
      end;

      if (retorno <> 0) and (retorno <> 9999) then begin
        vNumErro := DLLG2_ObtemCodErro(Handle);
        if  (vNumErro <> 0) then begin
          vRetorno := TrataErroUrano(vNumErro);
          if (vRetorno <> '') then begin
            Result := SetStatus(STS_ERROR_ECF, 'URANO(' + IntToStr(vNumErro) + ')', vRetorno, cDS_METHOD);
            return(STS_ERROR_ECF); exit;
          end else if (vStatus = STS_POUCO_PAPEL) then begin
            MensagemBal('Pouco papel', 25);
          end;
        end;
      end;

    end else if (vModeloEcf = 'ecfSweda') then begin
      // retorno igual a UM foi executado com sucesso
      // diferente de UM verificar tabela de erro
      result := Analisa_Retorno_Sweda(Retorno);
      if (Retorno <= 0) and (Result <> '') then begin
        Result := SetStatus(STS_ERROR_ECF, 'SWEDA(' + IntToStr(Retorno) + ')', Result, cDS_METHOD);
        return(STS_ERROR_ECF); exit;
      end;

    end;

  except
    on E : Exception do ShowMessage(E.Message);
  end;

  Result := SetStatus(STS_EXEC);
  return(STS_EXEC); exit;
end;

function retornoImpressoraErro(vModeloEcf : String; Retorno : Integer) : Boolean;
begin
  Result := (retornoImpressora(vModeloEcf, Retorno) <> '');
end;

function downloadMFD(vModeloEcf : String; vArquivo : String; vTipoDownload : String; vCOOInicial : String; vCOOFinal : String; vUsuario : String) : Integer;
var
  F : TextFile;
  vInVazio : Integer;
  vDsLinha, vDsConteudo, vArquivoSaida : String;
begin
  try
    if (vModeloEcf = 'ecfBematech') or (vModeloEcf = 'ecfYanco') then begin
      result := Bematech_FI_DownloadMFD(vArquivo, vTipoDownload, vCOOInicial, vCOOFinal, vUsuario);
    end else if (vModeloEcf = 'ecfElgin') then begin
      result := Elgin_DownloadMFD(vArquivo, vTipoDownload, vCOOInicial, vCOOFinal, vUsuario)
    end else if (vModeloEcf = 'ecfInterway') then begin
      iRetorno :=  DLLG2_ExecutaComando(Handle, 'EmiteLeituraFitaDetalhe; DataFinal=#' + vCOOFinal + '# DataInicial=#' + vCOOInicial + '# Destino="S"');

      // o comando LeImpressao, retorna no máximo 4000 bytes, portanto
      // deve fazer o laço enviando o comando até que seja retornado todas as respostas do comando : EmiteLeituraFitaDetalhe
      repeat
        iRetorno := DLLG2_ExecutaComando(Handle, 'LeImpressao');
        vDsLinha := DLLG2_ObtemRetornos(Handle, vDsLinha, 0);
        vDsLinha := fRetornaValor(vDsLinha, 'TextoImpressao','"');
        vDsConteudo := vDsConteudo + vDsLinha;
      until (vDsLinha = '');
      GravaIni(vArquivo, vDsConteudo);
    end else if (vModeloEcf = 'ecfUrano') then begin
      iRetorno :=  DLLG2_ExecutaComando(Handle, 'EmiteLeituraFitaDetalhe; DataFinal=#' + vCOOFinal + '# DataInicial=#' + vCOOInicial + '# Destino="S"');

      // o comando LeImpressao, retorna no máximo 4000 bytes, portanto
      // deve fazer o laço enviando o comando até que seja retornado todas as respostas do comando : EmiteLeituraFitaDetalhe
      repeat
        iRetorno := DLLG2_ExecutaComando(Handle, 'LeImpressao');
        vDsLinha := DLLG2_ObtemRetornos(Handle, vDsLinha, 0);
        vDsLinha := fRetornaValor(vDsLinha, 'TextoImpressao','"');
        vDsConteudo := vDsConteudo + vDsLinha;
      until (vDsLinha = '');
      GravaIni(vArquivo, vDsConteudo);
    end else if (vModeloEcf = 'ecfDaruma') then begin
      if (vTipoDownload = '1') then  begin
        vCOOInicial := Copy(vCOOInicial, 1, 4) + '20' + Copy(vCOOInicial, 5, 2);
        vCOOFinal := Copy(vCOOFinal, 1, 4) + '20' + Copy(vCOOFinal, 5, 2);

        Result := rEfetuarDownloadMFD_ECF_Daruma('DATAM', vCOOInicial, vCOOFinal, 'Daruma.mfd');
      end else if (vTipoDownload = '2') then begin
        Result := rEfetuarDownloadMFD_ECF_Daruma('COO', vCOOInicial, vCOOFinal, 'Daruma.mfd');
      end;
    end else if (vModeloEcf = 'ecfSweda') then begin
      result := ECF_DownloadMFD(vArquivo, vTipoDownload, vCOOInicial, vCOOFinal, vUsuario);
    end else if (vModeloEcf = 'ecfEpson') then begin
      if (vTipoDownload = '1') then begin
        vCOOInicial := Copy(vCOOInicial, 1, 4) + '20' + Copy(vCOOInicial, 5, 2);
        vCOOFinal := Copy(vCOOFinal, 1, 4) + '20' + Copy(vCOOFinal, 5, 2);

        result := EPSON_Obter_Dados_MF_MFD(PChar(vCOOInicial), PChar(vCOOFinal), 0, 255, 0, 0, 'C:\ECF\DOWNLOADMFD')
      end else if (vTipoDownload = '2') then begin
        vCOOInicial := zerosString(6, Trim(vCOOInicial), False);
        vCOOFinal := zerosString(6, trim(vCOOFinal), False);

        result := EPSON_Obter_Dados_MF_MFD(PChar(vCOOInicial), PChar(vCOOFinal), 2, 255, 0, 0, 'C:\ECF\DOWNLOADMFD');
      end;
    end;
  except
    on E : Exception do ShowMessage(E.Message);
  end;
end;

function geraRegistroCAT52MFD(vModeloEcf : String; vArquivo : String; vData : String) : Integer;
var
  vFileMF : AnsiString;
  vDataI, vArqAux, vPorta : String;
begin
  try
    if (vModeloEcf = 'ecfBematech') or (vModeloEcf = 'ecfYanco') then begin
      result := Bematech_FI_GeraRegistrosCAT52MFD(vArquivo, vData);
    end else if (vModeloEcf = 'ecfElgin') then begin

    end else if (vModeloEcf = 'ecfInterway') or (vModeloEcf = 'ecfUrano') then begin
      vArquivo := getPathECF() + 'URANO.TDM';
      vPorta := LeIni('NR_PORTAECF','COM1');
      InterwayGeraArquivoBinario( vPorta, vArquivo ,vNrSerie);
      vArqAux := NomeArqRFD(vModeloEcf, StrToDate(vData));
      vArqAux := getPathECF() + vArqAux;
      Result := InterwayGeraArquivoAto17(vArquivo, vArqAux, PChar(vData), PChar(vData), 'D', '', PChar('TDM'));
    end else if (vModeloEcf = 'ecfDaruma') then begin

    end else if (vModeloEcf = 'ecfSweda') then begin
      vFileMF := 'C:\NoStop.MF';
      result := ECF_DownloadMF(vFileMF);
      vArquivo := vFileMF;
      result := ECF_GeraRegistrosCAT52MFD(vArquivo, vData);
    end else if (vModeloEcf = 'ecfEpson') then begin

    end;
  except
    on E : Exception do ShowMessage(E.Message);
  end;
end;

//sobrecarga de metodo utilizado porque a Daruma tem parametro diferentes
function geraRegistroCAT52MFDInt(vModeloEcf : String; vTipoRelatorio : String; vTipoIntervalo : String; vDataIni : String; vDataFim : String) : Integer;
var
  vArqAux,vArquivo, vPorta, vDataI : String;
begin
  try
    if (vModeloEcf = 'ecfBematech') or (vModeloEcf = 'ecfYanco') then begin

    end else if (vModeloEcf = 'ecfElgin') then begin

    end else if (vModeloEcf = 'ecfInterway') then begin
      vArquivo := getPathECF() + 'URANO.TDM';
      vPorta := LeIni('NR_PORTAECF','COM1');
      InterwayGeraArquivoBinario(vPorta, vArquivo ,vNrSerie);
      vArqAux := NomeArqRFD(vModeloEcf, StrToDate(vDataIni));
      Result := InterwayGeraArquivoAto17(vArquivo,vArqAux, PCHAR(vDataIni), PCHAR(vDataIni), 'D','', PChar('TDM'));
    end else if (vModeloEcf = 'ecfUrano') then begin
      vDataI := (FormatDateTime('YYYYMMDD',StrToDateTime(vDataIni)));
      vArquivo := getPathECF() + 'URANO.TDM';
      vPorta := LeIni('NR_PORTAECF','COM1');
      InterwayGeraArquivoBinario(vPorta, vArquivo ,vNrSerie);
      vArqAux := NomeArqRFD(vModeloEcf, StrToDate(vDataIni));
      Result  :=  InterwayGeraArquivoAto17(vArquivo,vArqAux, PCHAR(vDataI), PCHAR(vDataI), 'D','', PChar('TDM'));
    end else if (vModeloEcf = 'ecfDaruma') then begin
      result := regAlterarValor_Daruma('START\LocalArquivosRelatorios', copy(getPathECF(), 3, length(getPathECF()))); //'\Projeto_touch\VirtualLoja\path_ecf\'
      result := rGerarRelatorio_ECF_Daruma(vTipoRelatorio, vTipoIntervalo, vDataIni, vDataFim);
    end else if (vModeloEcf = 'ecfSweda') then begin

    end else if (vModeloEcf = 'ecfEpson') then begin

    end;
  except
    on E : Exception do ShowMessage(E.Message);
  end;
end; 

function programaFormaPagamento(vModeloEcf : String; vFormaPgto : String; vPermiteTEF : String) : Integer; 
var
  vDsNrPagamento : String; 
begin
  try
    if (vModeloEcf = 'ecfBematech') or (vModeloEcf = 'ecfYanco') then begin
      result := Bematech_FI_ProgramaFormaPagamentoMFD(vFormaPgto, vPermiteTEF); 
    end else if (vModeloEcf = 'ecfElgin') then begin
      result := Elgin_ProgramaFormaPagamentoMFD(vFormaPgto, vPermiteTEF); 
    end else if (vModeloEcf = 'ecfInterway') or (vModeloEcf = 'ecfUrano') then begin
      if (vPermiteTEF = '1') then
        vPermiteTEF := 'true'
      else
        vPermiteTEF := 'false';
      result := DLLG2_ExecutaComando(Handle, 'DefineMeioPagamento; NomeMeioPagamento="' + vFormaPgto + '" PermiteVinculado=' + vPermiteTEF);
    end else if (vModeloEcf = 'ecfDaruma') then begin
      Result := confCadastrarPadrao_ECF_Daruma('FPGTO', vFormaPgto); 
    end else if (vModeloEcf = 'ecfSweda') then begin
      result := ECF_ProgramaFormaPagamentoMFD(PChar(vFormaPgto), PChar(vPermiteTEF)); 
    end else if (vModeloEcf = 'ecfEpson') then begin
      vDsNrPagamento := FormatFloat('00', 1); 
      if (vPermiteTEF = '1') then
        result := EPSON_Config_Forma_Pagamento(True, PChar(vDsNrPagamento), PChar(vFormaPgto))
      else
        Result := EPSON_Config_Forma_Pagamento(False, PChar(vDsNrPagamento), PChar(vFormaPgto));
    end; 
  except
    on E : Exception do ShowMessage(E.Message); 
  end; 
end; 

function formatoDadosMFD(vModeloEcf : String; ArquivoOrigem : String; ArquivoDestino : String; TipoFormato : String; TipoDownload : String; ParametroInicial : String; ParametroFinal : String; UsuarioECF : String) : Integer; 
begin
  try
    if (vModeloEcf = 'ecfBematech') or (vModeloEcf = 'ecfYanco') then begin
      result := Bematech_FI_FormatoDadosMFD(ArquivoOrigem, ArquivoDestino, TipoFormato, TipoDownload, ParametroInicial, ParametroFinal, UsuarioECF);
    end else if (vModeloEcf = 'ecfElgin') then begin
      result := Elgin_FormatoDadosMFD(ArquivoOrigem, ArquivoDestino, TipoFormato, TipoDownload, ParametroInicial, ParametroFinal, UsuarioECF);
    end else if (vModeloEcf = 'ecfInterway') or (vModeloEcf = 'ecfUrano') then begin

    end else if (vModeloEcf = 'ecfDaruma') then begin

    end else if (vModeloEcf = 'ecfSweda') then begin
      result := ECF_FormatoDadosMFD(ArquivoOrigem, ArquivoDestino, TipoFormato, TipoDownload, ParametroInicial, ParametroFinal, UsuarioECF);
    end;
  except
    on E : Exception do ShowMessage(E.Message);
  end;
end;

function geraRegistrosTipoE(vModeloEcf : String; vArqMFD : String; vArqTXT : String; vDataIni : String; vDataFim : String; vRazao : String; vEndereco : String; vCMD : String; vTpDownload : String) : Integer;
var
  vNrSerie : String;
  vTipoLeitura : Char;
  Tamanho : Integer;
begin
  try
    if (vModeloEcf = 'ecfBematech') or (vModeloEcf = 'ecfYanco') then begin
       result := BemaGeraRegistrosTipoE(PChar(vArqMFD), PChar(vArqTXT), PChar(vDataIni), PChar(vDataFim), PChar(vRazao), PChar(vEndereco), '', PChar(vCMD), '','','','','','','','','','','','','');
    end else if (vModeloEcf = 'ecfElgin') then begin

    end else if (vModeloEcf = 'ecfInterway') or (vModeloEcf = 'ecfUrano') then begin
      geraArquivoTipoEAux(vModeloEcf, vArqMFD, vArqTXT, 'MF', PChar(vTpDownload), vDataIni, vDataFim, '');
    end else if (vModeloEcf = 'ecfDaruma') then begin
      SetLength(vDataIni, 8);
      SetLength(vDataFim, 8);
      if (vTpDownload = '1') then begin
        vDataIni := Copy(vDataIni, 1, 4) + '20' + Copy(vDataIni, 5, 2);
        vDataFim := Copy(vDataFim, 1, 4) + '20' + Copy(vDataFim, 5, 2);
        Result := rGerarMFD_ECF_Daruma('DATAM', vDataIni, vDataFim);
      end else if (vTpDownload = '2') then begin
        Result := rGerarMFD_ECF_Daruma('COO', vDataIni, vDataFim);
      end;
    end else if (vModeloEcf = 'ecfSweda') then begin

    end else if (vModeloEcf = 'ecfEpson') then begin
      if (vTpDownload = '1') then begin
        vDataIni := Copy(vDataIni, 1, 4) + '20' + Copy(vDataIni, 5, 2);
        vDataFim := Copy(vDataFim, 1, 4) + '20' + Copy(vDataFim, 5, 2);

        result := EPSON_Obter_Dados_MF_MFD(PChar(vDataIni), PChar(vDataFim), 0, 0, 3, 0, 'C:\ECF\AC1704')
      end else if (vTpDownload = '2') then begin
        vDataIni := zerosString(6, Trim(vDataIni), False);
        vDataFim := zerosString(6, trim(vDataFim), False);

        result := EPSON_Obter_Dados_MF_MFD(PChar(vDataIni), PChar(vDataFim), 2, 0, 3, 0, 'C:\ECF\AC1704');
      end;
    end;
  except
    on E : Exception do ShowMessage(E.Message);
  end;
end;

function configuraCodBarras(vModeloEcf : String; vAltura : Integer; vLargura : Integer; vPosicaoCaracteres : Integer; vFonte : Integer; vMargem : Integer) : Integer;
begin
  try
    if (vModeloEcf = 'ecfBematech') or (vModeloEcf = 'ecfYanco') then begin
      result := Bematech_FI_ConfiguraCodigoBarrasMFD(vAltura, vLargura, vPosicaoCaracteres, vFonte, vMargem);
    end else if (vModeloEcf = 'ecfElgin') then begin
      result := Elgin_ConfiguraCodigoBarrasMFD(vAltura, vLargura, vPosicaoCaracteres, vFonte, vMargem);
    end else if (vModeloEcf = 'ecfInterway') or (vModeloEcf = 'ecfUrano') then begin

    end else if (vModeloEcf = 'ecfDaruma') then begin

    end else if (vModeloEcf = 'ecfSweda') then begin
      result := ECF_ConfiguraCodigoBarrasMFD(IntToStr(vAltura), IntToStr(vLargura), IntToStr(vPosicaoCaracteres), IntToStr(vFonte), IntToStr(vMargem));
    end else if (vModeloEcf = 'ecfEpson') then begin

    end; 
  except
    on E : Exception do ShowMessage(E.Message); 
  end; 
end; 

function imprimeCodBarrasCODE128(vModeloEcf : String; cCodigo : String) : Integer; 
begin
  try
    if (vModeloEcf = 'ecfBematech') or (vModeloEcf = 'ecfYanco') then begin
      result := Bematech_FI_ConfiguraCodigoBarrasMFD(70, 0, 2, 1, 5); 
      result := Bematech_FI_CodigoBarrasCODE128MFD(PChar(cCodigo)); 
    end else if (vModeloEcf = 'ecfElgin') then begin
      result := Elgin_CodigoBarrasCODE128MFD(PChar(cCodigo)); 
    end else if (vModeloEcf = 'ecfInterway') or (vModeloEcf = 'ecfUrano') then begin

    end else if (vModeloEcf = 'ecfDaruma') then begin
      Result := iImprimirCodigoBarras_ECF_Daruma(PChar('05'), '2','0','1', PChar(cCodigo), 'h',''); 
    end else if (vModeloEcf = 'ecfSweda') then begin
      result := ECF_ConfiguraCodigoBarrasMFD('70','0','2','1','5'); 
      //result := ECF_CodigoBarrasEAN13MFD(PChar(cCodigo)); 
      result := ECF_CodigoBarrasITFMFD(PChar(cCodigo));
    end else if (vModeloEcf = 'ecfEpson') then begin
      result := EPSON_NaoFiscal_Imprimir_Codigo_Barras(70, 50, 2, 0, 0, PChar(cCodigo));
    end;
  except
    on E : Exception do ShowMessage(E.Message);
  end;
end;

function configuraECF(vModeloEcf : String) : Integer;
begin
  try
    if (vModeloEcf = 'ecfBematech') or (vModeloEcf = 'ecfYanco') then begin

    end else if (vModeloEcf = 'ecfElgin') then begin

    end else if (vModeloEcf = 'ecfInterway') or (vModeloEcf = 'ecfUrano') then begin

    end else if (vModeloEcf = 'ecfDaruma') then begin
      result := regAlterarValor_Daruma('ECF\MensagemApl1',' ');
      result := regAlterarValor_Daruma('ECF\MensagemApl2',' ');
      result := regAlterarValor_Daruma('ECF\ControleAutomatico','1');
      result := regAlterarValor_Daruma('ECF\EncontrarECF','1');
      result := regAlterarValor_Daruma('ECF\PortaSerial', LeIni('NR_PORTAECF',''));
      result := regAlterarValor_Daruma('START\LocalArquivosRelatorios', copy(getPathECF(), 3, length(getPathECF()))); //'\Projeto_touch\VirtualLoja\path_ecf\'
    end else if (vModeloEcf = 'ecfSweda') then begin

    end;
  except
    on E : Exception do ShowMessage(E.Message);
  end;
end;

//------------------------------------------------------------------------------
//------------------------------------------------------------------------------
//------------------------------------------------------------------------------

function verificaFlagsFiscais(vModeloEcf : String) : Integer; 
begin
  try
    if (vModeloEcf = 'ecfBematech') or (vModeloEcf = 'ecfYanco') then begin
      Result := Bematech_FI_FlagsFiscais(vFlagFiscal); 
      vLstFlagFiscal := Analisa_FlagFiscais_Bematech(vFlagFiscal); 
    end else if (vModeloEcf = 'ecfElgin') then begin
      result := Elgin_FlagsFiscais(vFlagFiscal); 
    end else if (vModeloEcf = 'ecfInterway') or (vModeloEcf = 'ecfUrano') then begin

    end else if (vModeloEcf = 'ecfDaruma') then begin

    end else if (vModeloEcf = 'ecfSweda') then begin
      result := ECF_FlagsFiscais(vFlagFiscal); 
    end; 
  except
    on E : Exception do ShowMessage(E.Message); 
  end;
end;

function programaAliquota(vModeloEcf : String; Aliquota : String; ICMS_ISS : Integer) : Integer;
var
  vResult : string;
begin
  try
    if (vModeloEcf = 'ecfBematech') or (vModeloEcf = 'ecfYanco') then begin
      result := Bematech_FI_ProgramaAliquota(Aliquota, ICMS_ISS);   // 0-ICMS / 1-ISS
    end else if (vModeloEcf = 'ecfElgin') then begin
      result := Elgin_ProgramaAliquota(Aliquota, ICMS_ISS);         // 0-ICMS / 1-ISS
    end else if (vModeloEcf = 'ecfInterway') or (vModeloEcf = 'ecfUrano') then begin
      Result := DLLG2_ExecutaComando(Handle,'DefineAliquota;AliquotaICMS=True PercentualAliquota=' + IntToStr(ICMS_ISS));
    end else if (vModeloEcf = 'ecfDaruma') then begin
      result := confCadastrar_ECF_Daruma(Aliquota, IntToStr(ICMS_ISS), '');         // 0-ICMS / 1-ISS
    end else if (vModeloEcf = 'ecfSweda') then begin
      result := ECF_ProgramaAliquota(Aliquota, ICMS_ISS);       // 0-ICMS / 1-ISS
    end;
  except
    on E : Exception do ShowMessage(E.Message);
  end;
end;

function mapaResumo(vModeloEcf : String) : Integer;
begin
  try
    if (vModeloEcf = 'ecfBematech') or (vModeloEcf = 'ecfYanco') then begin
      result := Bematech_FI_MapaResumo();
    end else if (vModeloEcf = 'ecfElgin') then begin
      result := Elgin_MapaResumo();
    end else if (vModeloEcf = 'ecfInterway') or (vModeloEcf = 'ecfUrano') then begin

    end else if (vModeloEcf = 'ecfDaruma') then begin

    end else if (vModeloEcf = 'ecfSweda') then begin
      result := ECF_MapaResumoMFD();
    end;
  except
    on E : Exception do ShowMessage(E.Message);
  end;
end;

function aberturaDoDia(vModeloEcf : String; ValorCompra : String; FormaPagamento : String) : Integer;
begin
  try
    if (vModeloEcf = 'ecfBematech') or (vModeloEcf = 'ecfYanco') then begin
      result := Bematech_FI_AberturaDoDia(ValorCompra, FormaPagamento);
    end else if (vModeloEcf = 'ecfElgin') then begin
      result := Elgin_AberturaDoDia(ValorCompra, FormaPagamento);
    end else if (vModeloEcf = 'ecfInterway') or (vModeloEcf = 'ecfUrano') then begin

    end else if (vModeloEcf = 'ecfDaruma') then begin
 
    end else if (vModeloEcf = 'ecfSweda') then begin
      result := ECF_AberturaDoDia(ValorCompra, FormaPagamento); 
    end;
  except
    on E : Exception do ShowMessage(E.Message); 
  end; 
end; 

function abreCupomRecebimento(vModeloEcf : String; FormaPagamento : String; Valor : String; NumeroCupom : String) : Integer;
begin
  try
    if (vModeloEcf = 'ecfBematech') or (vModeloEcf = 'ecfYanco') then begin
      result := Bematech_FI_abreCupomVinculado(FormaPagamento, Valor, NumeroCupom); 
    end else if (vModeloEcf = 'ecfElgin') then begin
      result := Elgin_abreCupomVinculado(FormaPagamento, Valor, NumeroCupom);
    end else if (vModeloEcf = 'ecfInterway') or (vModeloEcf = 'ecfUrano') then begin

    end else if (vModeloEcf = 'ecfDaruma') then begin
      result := iCCDAbrirSimplificado_ECF_Daruma(FormaPagamento, '1', NumeroCupom, Valor);
    end else if (vModeloEcf = 'ecfSweda') then begin
      result := ECF_abreCupomVinculado(FormaPagamento, Valor, NumeroCupom); 
    end; 
  except
    on E : Exception do ShowMessage(E.Message); 
  end; 
end; 

function abreRelatorioGerencial(vModeloEcf : String; Indice : String) : Integer;
var
  vResult  : string;
begin
  try
    if (vModeloEcf = 'ecfBematech') or (vModeloEcf = 'ecfYanco') then begin
      result := Bematech_FI_AbreRelatorioGerencialMFD(Indice);
    end else if (vModeloEcf = 'ecfElgin') then begin
      result := Elgin_AbreRelatorioGerencialMFD(Indice);
    end else if (vModeloEcf = 'ecfInterway') or (vModeloEcf = 'ecfUrano') then begin
      result := DLLG2_ExecutaComando(Handle,'AbreGerencial;NomeGerencial="RELATORIO"');
    end else if (vModeloEcf = 'ecfDaruma') then begin
      result := iRGAbrir_ECF_Daruma('Relatório');
    end else if (vModeloEcf = 'ecfSweda') then begin
      result := ECF_AbreRelatorioGerencialMFD(Indice);
    end;
  except
    on E : Exception do ShowMessage(E.Message);
  end;
end;

function acrescimoDescontoItem(vModeloEcf : String; Item, AcrescimoDesconto, TipoAcrescimoDesconto, ValorAcrescimoDesconto : String) : Integer;
var
  vDsDados : String;
  i, vItem, vUltimoItem : Integer;
  vValorAcrescimoDesconto : Real;
begin
  try
    if (vModeloEcf = 'ecfBematech') or (vModeloEcf = 'ecfYanco') then begin
      result := Bematech_FI_AcrescimoDescontoItemMFD(Item, AcrescimoDesconto, TipoAcrescimoDesconto, ValorAcrescimoDesconto);
    end else if (vModeloEcf = 'ecfElgin') then begin
      result := Elgin_AcrescimoDescontoItemMFD(Item, AcrescimoDesconto, TipoAcrescimoDesconto, ValorAcrescimoDesconto);
    end else if (vModeloEcf = 'ecfInterway') or (vModeloEcf = 'ecfUrano') then begin
      //{AcresceItemFiscal;Cancelar=false NumItem=1 ValorPercentual=-10;66}
      //Result := DLLG2_ExecutaComando(0, 'AcresceItemFiscal;Cancelar=' + false + ' NumItem=' + Item +' ValorPercentual='-10);
    end else if (vModeloEcf = 'ecfDaruma') then begin
      result := iCFLancarAcrescimoItem_ECF_Daruma(Item, AcrescimoDesconto + TipoAcrescimoDesconto, ValorAcrescimoDesconto);
    end else if (vModeloEcf = 'ecfSweda') then begin
      vValorAcrescimoDesconto := Abs(StrToFloatDef(ValorAcrescimoDesconto,0));
      ValorAcrescimoDesconto := FormatFloat('0.00', vValorAcrescimoDesconto);
      result := ECF_AcrescimoDescontoItemMFD(Item, AcrescimoDesconto, TipoAcrescimoDesconto, ValorAcrescimoDesconto);
    end else if (vModeloEcf = 'ecfEpson') then begin
      ValorAcrescimoDesconto := ReplaceStr(ValorAcrescimoDesconto, ',','');
      result  := EPSON_Fiscal_Desconto_Acrescimo_ItemEx(pChar(Item), pChar(ValorAcrescimoDesconto),2,True,False);

      if (result = 1) then begin // se der erro, vai verificar se é o ultimo item e dar o desconto "normal"
        vDsDados := ReplicateStr(' ', 3);
        EPSON_Obter_Numero_Ultimo_Item(pChar(vDsDados));

        vUltimoItem := StrToIntDef(trim(vDsDados), 0);
        vItem := StrToIntDef(trim(Item), 999);
        if (vItem = vUltimoItem) then // se o desconto for no último item vendido
          result  := EPSON_Fiscal_Desconto_Acrescimo_Item(pChar(ValorAcrescimoDesconto),2,True,False)
        else
          result  := EPSON_Fiscal_Desconto_Acrescimo_ItemEx(pChar(Item), pChar(ValorAcrescimoDesconto),2,True,False);
      end;

    end;
  except
    on E : Exception do ShowMessage(E.Message);
  end; 
end;

function autentica(vModeloEcf : String) : Integer;
var
  vDsTxt : String;
begin
  try
    if (vModeloEcf = 'ecfBematech') or (vModeloEcf = 'ecfYanco') then begin
      result := Bematech_FI_Autenticacao();
    end else if (vModeloEcf = 'ecfElgin') then begin
      result := Elgin_Autenticacao();
    end else if (vModeloEcf = 'ecfInterway') or (vModeloEcf = 'ecfUrano') then begin
      result := DLLG2_ExecutaComando(Handle, 'ImprimeAutenticacao;TempoEspera=8');
    end else if (vModeloEcf = 'ecfDaruma') then begin
      SetLength(vDsTxt, 48);
      Result := iAutenticarDocumento_DUAL_DarumaFramework(vDsTxt, '1','120');
    end else if (vModeloEcf = 'ecfSweda') then begin
      result := ECF_Autenticacao();
    end;
  except
    on E : Exception do ShowMessage(E.Message);
  end;
end;

function fechaVinculado(vModeloEcf : String) : Integer;
begin
  try
    if (vModeloEcf = 'ecfBematech') or (vModeloEcf = 'ecfYanco') then begin
      result := Bematech_FI_FechaComprovanteNaoFiscalVinculado();
    end else if (vModeloEcf = 'ecfElgin') then begin
      result := Elgin_FechaComprovanteNaoFiscalVinculado();
    end else if (vModeloEcf = 'ecfInterway') or (vModeloEcf = 'ecfUrano') then begin
      result := DLLG2_ExecutaComando(Handle, 'EncerraDocumento');
    end else if (vModeloEcf = 'ecfDaruma') then begin
      result := iCCDFechar_ECF_Daruma
    end else if (vModeloEcf = 'ecfSweda') then begin
      result := ECF_FechaComprovanteNaoFiscalVinculado();
    end else if (vModeloEcf = 'ecfEpson') then begin
      result := EPSON_NaoFiscal_Fechar_Relatorio_Gerencial(true);
    end;
  except
    on E : Exception do ShowMessage(E.Message);
  end;
end;

function imprimeVinculado(vModeloEcf : String; Texto : String) : Integer;
var
  vLstLinha : TStringList;
  vLinha : String;
  i : Integer;
begin
  try
    if (vModeloEcf = 'ecfBematech') or (vModeloEcf = 'ecfYanco') then begin
      result := Bematech_FI_UsaComprovanteNaoFiscalVinculado(Texto);
    end else if (vModeloEcf = 'ecfElgin') then begin
      result := Elgin_UsaComprovanteNaoFiscalVinculado(Texto);
    end else if (vModeloEcf = 'ecfInterway') or (vModeloEcf = 'ecfUrano') then begin
      result := DLLG2_ExecutaComando(Handle, 'ImprimeTexto;TextoLivre="' + Texto + '"');
    end else if (vModeloEcf = 'ecfDaruma') then begin
      result := iCCDImprimirTexto_ECF_Daruma(Texto);
    end else if (vModeloEcf = 'ecfSweda') then begin
      result := ECF_UsaComprovanteNaoFiscalVinculado(Texto);
    end else if (vModeloEcf = 'ecfEpson') then begin
       if (vCont = 0) then begin //quando for o primeiro comando abre o vinculado
         result := EPSON_NaoFiscal_Abrir_Relatorio_Gerencial('1');
         Inc(VCont);
       end;
       try
         vLstLinha := TStringList.Create;
         vLstLinha.Text := Texto; 
         for i := 0 to vLstLinha.Count - 1 do begin
           vLinha := vLstLinha.Strings[i]; 
           result := EPSON_NaoFiscal_Imprimir_Linha(PChar(vLinha)); 
         end; 
       finally
         vLstLinha.Free; 
       end; 
    end; 
  except
    on E : Exception do ShowMessage(E.Message);
  end;
end;

function imprimirRelatorioGerencial(vModeloEcf : String; Texto : String) : Integer;
var
  vLstLinha : TStringList;
  vLinha : String;
  i : Integer;
begin
  try
    if (vModeloEcf = 'ecfBematech') or (vModeloEcf = 'ecfYanco') then begin
      result := Bematech_FI_RelatorioGerencial(Texto);
    end else if (vModeloEcf = 'ecfElgin') then begin
      result := ELgin_RelatorioGerencial(Texto);
    end else if (vModeloEcf = 'ecfInterway') or (vModeloEcf = 'ecfUrano') then begin
      result := DLLG2_ExecutaComando(Handle,'AbreGerencial;NomeGerencial="RELATORIO"');
      result := DLLG2_ExecutaComando(Handle,'ImprimeTexto;TextoLivre="' + Texto + '"');
    end else if (vModeloEcf = 'ecfDaruma') then begin
      result := iRGImprimirTexto_ECF_Daruma(Texto);
    end else if (vModeloEcf = 'ecfSweda') then begin
      result := ECF_RelatorioGerencial(Texto); 
    end else if (vModeloEcf = 'ecfEpson') then begin
       if (vCont = 0) then begin //quando for o primeiro comando abre o gerencial
         result := EPSON_NaoFiscal_Abrir_Relatorio_Gerencial('1');
         Inc(VCont); 
       end; 
       try
         vLstLinha := TStringList.Create; 
         vLstLinha.Text := Texto; 
         for i := 0 to vLstLinha.Count - 1 do begin
           vLinha := vLstLinha.Strings[i]; 
           result := EPSON_NaoFiscal_Imprimir_Linha(PChar(vLinha)); 
         end; 
       finally
         vLstLinha.Free; 
       end; 
    end; 
  except
    on E : Exception do ShowMessage(E.Message);
  end; 
end;

function progHoraVerao(vModeloEcf : String) : Integer; 
begin
  try
    if (vModeloEcf = 'ecfBematech') or (vModeloEcf = 'ecfYanco') then begin
      result := Bematech_FI_ProgramaHorarioVerao(); 
    end else if (vModeloEcf = 'ecfElgin') then begin
      result := Elgin_ProgramaHorarioVerao(); 
    end else if (vModeloEcf = 'ecfInterway') or (vModeloEcf = 'ecfUrano') then begin

    end else if (vModeloEcf = 'ecfDaruma') then begin
      result := confHabilitarHorarioVerao_ECF_Daruma; 
    end else if (vModeloEcf = 'ecfSweda') then begin

    end;
  except
    on E : Exception do ShowMessage(E.Message);
  end;
end;

function verificaReducaoZ(vModeloEcf : String) : String;
var
  vMetodo, vResult, vStatusZ, vModelo : String;
  vDataMovimento, vDataImpressora : TDateTime;
  vNrIndicadores : String;
  Indicadores : Integer;

      function prcVerificaReducaoZ() : String;
      begin
        iRetorno := dataImpressora(vModeloEcf);
        vDataHora := FormatarDataFmt(vDataHora, 'ddmmyy', 'dd/mm/yy');
        vDataMovimento := StrToDateDef(vDataHora, 0);
        vDataMovimento := trunc(vDataMovimento);

        iRetorno := dataHoraImpressora(vModeloEcf);
        vDataImpressora := StrToDateTimeDef(vDataHora, 0);
        vDataImpressora := trunc(vDataImpressora);

        if (vDataMovimento > 0) and (vDataMovimento <> vDataImpressora) then begin
          Result := SetStatus(STS_REDZPEND, vModelo, cRED_Z_PENDENTE, vMetodo);
          return(STS_REDZPEND); exit;
        end;
      end;

begin
  Result := '';

  vMetodo := 'uECF.verificaReducaoZ';
  vModelo := ReplaceStr(vModeloEcf, 'ecf', '');

  try
    if (vModeloEcf = 'ecfBematech') or (vModeloEcf = 'ecfYanco') then begin
      Result := prcVerificaReducaoZ();
    end else if (vModeloEcf = 'ecfElgin') then begin
      Result := prcVerificaReducaoZ();
    end else if (vModeloEcf = 'ecfInterway') or (vModeloEcf = 'ecfUrano') then begin
      // LeInteiro; NomeInteiro="Indicadores";40
      DLLG2_ExecutaComando(Handle, 'LeInteiro; NomeInteiro="Indicadores"');
      vNrIndicadores := DLLG2_ObtemRetornos(Handle, vNrIndicadores, 10);
      Indicadores := itemI('ValorInteiro', vNrIndicadores);

      vResult := verificaIndicadoresUrano(Indicadores);
      if itemXmlB('FLAG_Z_PENDENTE', vResult) then begin
        Result := SetStatus(STS_REDZPEND, vModelo, cRED_Z_PENDENTE, vMetodo);
        return(STS_REDZPEND); exit;
      end else if itemXmlB('FLAG_DIA_FECHADO', vResult) then begin
        Result := SetStatus(STS_REDZBLOQ, vModelo, cRED_Z_BLOQUEADA, vMetodo);
        return(STS_REDZBLOQ); exit;
      end;

    end else if (vModeloEcf = 'ecfDaruma') then begin
      SetLength(vStatusZ, 1);
      iRetorno := rVerificarReducaoZ_ECF_Daruma(vStatusZ);

      if (vStatusZ = '1') then begin
        Result := SetStatus(STS_REDZPEND, vModelo, cRED_Z_PENDENTE, vMetodo);
        return(STS_REDZPEND); exit;
      end;

    end else if (vModeloEcf = 'ecfSweda') then begin
      SetLength(vStatusZ, 2);
      vRetorno := ECF_VerificaZPendente(vStatusZ);

      // vZpendente
      //  "0" = Redução Z já efetuada.
      //  "1" = Z pendente deve ser feito (encerrar o dia!).
      if (vStatusZ[1] = '1') then begin
        Result := SetStatus(STS_REDZPEND, vModelo, cRED_Z_PENDENTE, vMetodo);
        return(STS_REDZPEND); exit;
      end;
      //
    end;
  except
    on E : Exception do ShowMessage(E.Message);
  end;

  Result := SetStatus(STS_EXEC);
  return(STS_EXEC); exit;
end;

function abrePorta(vModeloEcf : String) : Integer;
var
  vPorta : String;
  CodErro  : integer;
  vMsg, Retornos : string;
begin
  Result := 1; // por motivo de não emitir erro na aplicação
  try
    if (vModeloEcf = 'ecfBematech') or (vModeloEcf = 'ecfYanco') then begin
      result := Bematech_FI_AbrePortaSerial;
      result := Bematech_FI_HabilitaDesabilitaRetornoEstendidoMFD('1');
    end else if (vModeloEcf = 'ecfElgin') then begin

    end else if (vModeloEcf = 'ecfInterway') or (vModeloEcf = 'ecfUrano') then begin
      vPorta := LeIni('NR_PORTAECF','COM1');
      handle := DLLG2_IniciaDriver(vPorta);
      result := result;

      CodErro := DLLG2_ObtemCodErro(Handle);      // irei retornar somente o código de erro.
      if CodErro <> 0 then begin
        vMsg := DLLG2_ObtemNomeErro(Handle,Retornos,0);
        vMSG := vMsg + ' , ' + DLLG2_ObtemCircunstancia(Handle,Retornos,0);
      end;

      DLLG2_DefineTimeout(result, 50);
    end else if (vModeloEcf = 'ecfDaruma') then begin

    end else if (vModeloEcf = 'ecfSweda') then begin
      Result := ECF_AbrePortaSerial();
    end else if (vModeloEcf = 'ecfEpson') then begin
      Result := EPSON_Serial_Abrir_PortaEx;
    end;
  except
    on E : Exception do ShowMessage(E.Message);
  end;
end;

function fechaPorta(vModeloEcf : String) : Integer;
var
  vResult : string;
begin
  Result := 1; // por motivo de não emitir erro na aplicação
  try
    if (vModeloEcf = 'ecfBematech') or (vModeloEcf = 'ecfYanco') then begin

    end else if (vModeloEcf = 'ecfElgin') then begin

    end else if (vModeloEcf = 'ecfInterway') or (vModeloEcf = 'ecfUrano') then begin
      DLLG2_EncerraDriver(Handle);
    end else if (vModeloEcf = 'ecfDaruma') then begin

    end else if (vModeloEcf = 'ecfSweda') then begin
      Result := ECF_FechaPortaSerial();
    end else if (vModeloEcf = 'ecfEpson') then begin
      Result := EPSON_Serial_Fechar_Porta;
    end;
  except
    on E : Exception do ShowMessage(E.Message); 
  end; 
end; 

function iniciaModoTEF(vModeloEcf : String) : Integer; 
begin
  Result := 1; // por motivo de não emitir erro na aplicação

  try
    if (vModeloEcf = 'ecfBematech') or (vModeloEcf = 'ecfYanco') then begin
      Result := Bematech_FI_IniciaModoTEF(); 
    end else if (vModeloEcf = 'ecfElgin') then begin

    end else if (vModeloEcf = 'ecfInterway') or (vModeloEcf = 'ecfUrano') then begin

    end else if (vModeloEcf = 'ecfDaruma') then begin

    end else if (vModeloEcf = 'ecfSweda') then begin
      Result := ECF_IniciaModoTEF();
    end; 
  except
    on E : Exception do ShowMessage(E.Message); 
  end;
end; 

function finalizaModoTEF(vModeloEcf : String) : Integer; 
begin
  Result := 1; // por motivo de não emitir erro na aplicação

  try
    if (vModeloEcf = 'ecfBematech') or (vModeloEcf = 'ecfYanco') then begin
      Result := Bematech_FI_FinalizaModoTEF(); 
    end else if (vModeloEcf = 'ecfElgin') then begin

    end else if (vModeloEcf = 'ecfInterway') or (vModeloEcf = 'ecfUrano') then begin

    end else if (vModeloEcf = 'ecfDaruma') then begin

    end else if (vModeloEcf = 'ecfSweda') then begin
      Result := ECF_FinalizaModoTEF();
    end;
  except
    on E : Exception do ShowMessage(E.Message);
  end;
end;

function arquivoMFD(vModeloEcf, pParams : String) : Integer;
{=-=-=-=-=-=-=-=-=-=BEMATECH=-=-=-=-=-=-=-=-=-=
TipoGeracao : Integer indicando a parametrização a ser feita no arquivo, onde :
0 = MF
1 = MFD
2 = TDM
3 = RZ
4 = RFD
Tipo Registros Gerados no Arquivo
MF = E01, E02, E03, E04, E05, E06, E07, E08, E09, E10, E11, E12 e E13
MFD= E01, E02, E14, E15, E16, E17, E18, E19, E20 e E21
TDM= E01, E02, E03, E04, E05, E06, E07, E08, E09, E10, E11, E12, E13, E14, E15, E16, E17, E18, E19, E20 e E21
RZ = E01, E02, E14, E15 e E16
RFD = E01, E02, E03, E04, E05, E06, E07, E08, E09, E10, E11, E12 e E13}
var
  vArquivo, vDadoInicial, vDadoFinal, vUsuario,
  vTpPeriodo, vTpArquivo, vArquivoSaida, vRazaoSocial, vEndereco,
  vCMD, vLinha, vModECF, vTipo : String;

  vArqTemp           : TextFile;
  vArqTempTXT        : TextFile;

  vTexto : TStringList;
begin
  Result := 0;
  vArquivo       := itemXml('DS_ARQUIVO', pParams);
  vDadoInicial   := itemXml('DS_DADOINICIAL', pParams);
  vDadoFinal     := itemXml('DS_DADOFINAL', pParams);
  vUsuario       := itemXml('NR_USUARIO', pParams);
  vTpPeriodo     := itemXml('TP_DOWNLOAD', pParams);
  vArquivoSaida  := itemXml('DS_ARQSAIDA', pParams);
  vRazaoSocial   := IffNulo(itemXml('DS_RAZAOSOCIAL', pParams), 'Bematech S/A');
  vEndereco      := IffNulo(itemXml('DS_ENDERECO', pParams), 'Rua ABCDEF, 1234');
  vCMD           := IffNulo(itemXml('DS_CMD', pParams), '2');
  vTpArquivo     := itemXml('TP_ARQUIVO', pParams);
  vTpPeriodo     := itemXml('TP_DOWNLOAD', pParams);

  try
    if (vModeloEcf = 'ecfBematech') or (vModeloEcf = 'ecfYanco') then begin
      if (vTpPeriodo = '1') then begin //por data
        vDadoInicial := formatDateTime('DDMMYY', strToDate(vDadoInicial));
        vDadoFinal := formatDateTime('DDMMYY', strToDate(vDadoFinal));

        Result := Bematech_FI_DownloadMFD(vArquivo, vTpPeriodo, vDadoInicial, vDadoFinal, vUsuario);
        Result := BemaGeraRegistrosTipoE(PChar(vArquivo), PChar(vArquivoSaida), PChar(vDadoInicial), PChar(vDadoFinal), PChar(vRazaoSocial), PChar(vEndereco), '', PChar(vCMD), '','','','','','','','','','','','','');
        if (result = 0) then begin //Tratamento de retorno da DLL  BemaMFD2.dll quando a executado corretamente é igual a 0
          Result := 1;
        end;
      end else if (vTpPeriodo = '2') then begin //por COO
        modeloImpressoraECF(vModeloEcf);
        if (AllTrim(vModeloImpressoraECF)<> 'MP2000FI') and (AllTrim(vModeloImpressoraECF)<> 'MP6000FI')  then begin
          BemaDLL.MP2100 := True;
        end;

        Result := Bematech_FI_DownloadMFD(vArquivo, vTpPeriodo, vDadoInicial, vDadoFinal, vUsuario);
        Result := BemaDLL.BemaGeraTxtPorCOO(PChar(vArquivo),
                                             getPathECF() + cARQ_ESPELHO,
                                             StrToIntDef(vUsuario, 0),
                                             StrToIntDef(vDadoInicial, 0),
                                             StrToIntDef(vDadoFinal, 0));

        // Abre o arquivo Espelho.TXT com a imagem dos cupons capturados.
        AssignFile(vArqTemp, getPathECF() + cARQ_ESPELHO);
        Reset(vArqTemp);

        // Cria o arquivo EspelhoTMP.TXT para guardar a imagens dos cupons
        // capturados, retirando as linhas em branco.
        AssignFile(vArqTempTXT, getPathECF() + cARQ_ESPELHOTMP);
        Rewrite(vArqTempTXT);

        vLinha := '';
        while not EOF(vArqTemp) do begin
          Readln(vArqTemp, vLinha);
          if (vLinha <> '') then begin
            Writeln(vArqTempTXT, vLinha);
          end;
        end;
        CloseFile(vArqTemp);
        CloseFile(vArqTempTXT);

        // Cria um objeto do tipo TStringList.
        vTexto := TStringList.Create;
        vTexto.LoadFromFile(getPathECF()+cARQ_ESPELHOTMP);

        // Copia as informações de data inicial e final, dentro do objeto Texto.
        vDadoInicial := copy(vTexto.Strings[ 6 ], 1, 10);
        if (BemaDLL.MP2100 = true) then
          vDadoFinal := copy(vTexto.Strings[ vTexto.Count - 2 ], 20, 10)
        else
          vDadoFinal := copy(vTexto.Strings[ vTexto.Count - 3 ], 29, 10);

        // Função que executa a geração do arquivo no layout do Ato Cotepe 17/04
        // para o PAF-ECF, por intervalo de datas previamente capturadas.

        iRetorno := BemaDLL.BemaGeraRegistrosTipoE(PChar(vArquivo),
                                             PChar(vArquivoSaida),
                                             PChar(vDadoInicial),
                                             PChar(vDadoFinal),
                                             vRazaoSocial,
                                             vEndereco,
                                             '',
                                             PChar(vCMD),
                                             '',
                                             '',
                                             '',
                                             '',
                                             '',
                                             '',
                                             '',
                                             '',
                                             '',
                                             '',
                                             '',
                                             '',
                                             '');
        if (result = 0) then begin //Tratamento de retorno da DLL  BemaMFD2.dll quando a executado corretamente é igual a 0
          Result := 1;
        end;

        DeleteFile(getPathECF()+cARQ_MFD);
        DeleteFile(getPathECF()+cARQ_ESPELHO);
        DeleteFile(getPathECF()+cARQ_ESPELHOTMP);
      end;
    end else if (vModeloEcf = 'ecfElgin') then begin

    end else if (vModeloEcf = 'ecfInterway') or (vModeloEcf = 'ecfUrano') then begin
      if (vTpPeriodo <> '2') then begin // 2 = COO
        vTpPeriodo := 'M';
      end else
        vTpPeriodo := 'C';

      geraArquivoTipoEAux(vModeloEcf, vArquivo, vArquivoSaida, vTpArquivo, vTpPeriodo, vDadoInicial, vDadoFinal, vUsuario) ;
    end else if (vModeloEcf = 'ecfDaruma') then begin
      if (FileExists(getPathECF() + 'ATO_MFD_DATA.TXT')) then begin
        DeleteFile(getPathECF() + 'ATO_MFD_DATA.TXT');
      end;
      result := regAlterarValor_Daruma('ECF\Atocotepe\LocalArquivos', vArquivoSaida);
      if (vTpPeriodo = '1') then begin //por data
        vDadoInicial := formatDateTime('DDMMYYYY', strToDate(vDadoInicial));
        vDadoFinal := formatDateTime('DDMMYYYY', strToDate(vDadoFinal));
        vTipo := 'DATAM';
        result := rGerarRelatorio_ECF_Daruma('MFD', vTipo, vDadoInicial, vDadoFinal);
        if (FileExists(getPathECF() + 'ATO_MFD_DATA.TXT')) then begin
          RenameFile(getPathECF() + 'ATO_MFD_DATA.TXT', vArquivoSaida);
        end;
      end else if (vTpPeriodo = '2') then begin //por COO
        vTipo := 'COO';
        result := rGerarRelatorio_ECF_Daruma('MFD', vTipo, vDadoInicial, vDadoFinal);
      end;
    end else if (vModeloEcf = 'ecfSweda') then begin
      result := ECF_ReproduzirMemoriaFiscalMFD('2', vDadoInicial, vDadoFinal, vArquivoSaida, '');
    end;
  except
    on E : Exception do ShowMessage(E.Message);
  end;
end;

function grandeTotal(vModeloEcf : String) : Integer;
var
  iConta : Integer;
begin
  Result := 1; // por motivo de não emitir erro na aplicação

  vGrandeTotal := ReplicateStr(' ', 18);

  try
    if (vModeloEcf = 'ecfBematech') or (vModeloEcf = 'ecfYanco') then begin
      iRetorno := Bematech_FI_GrandeTotal(vGrandeTotal); 
    end else if (vModeloEcf = 'ecfElgin') then begin

    end else if (vModeloEcf = 'ecfInterway') or (vModeloEcf = 'ecfUrano') then begin

    end else if (vModeloEcf = 'ecfDaruma') then begin
      iRetorno := rRetornarInformacao_ECF_Daruma('1', vGrandeTotal); 
    end else if (vModeloEcf = 'ecfSweda') then begin
      iRetorno := ECF_GrandeTotal(vGrandeTotal);
    end; 
  except
    on E : Exception do ShowMessage(E.Message); 
  end; 
end; 

function espelhoMFD(vModeloEcf : String; pParams : String) : Integer;
var
  vDadoIni, vDadoFim, vTipoEspelho, vLinha,
  vDsPathArquivo, vDsUsuario, vDsArqMfd, vAux : String;
  vDsArq : TStringList;
begin
  try
    vDadoIni := itemXml('DS_DADOINI', pParams);
    vDadoFim := itemXml('DS_DADOFIM', pParams);
    vTipoEspelho := itemXml('TP_DOWNLOAD', pParams);

    vDsPathArquivo := itemXml('DS_PATHARQUIVO', pParams);
    vDsUsuario := itemXml('NR_USUARIO', pParams);
    vDsArqMfd := itemXml('DS_ARQUIVOMFD', pParams);

    if (vModeloEcf = 'ecfBematech') or (vModeloEcf = 'ecfYanco') then begin
      iRetorno := downloadMFD(vModeloEcf, vDsArqMfd, vTipoEspelho, vDadoIni, vDadoFim, vDsUsuario);
      iRetorno := formatoDadosMFD(vModeloEcf, vDsArqMfd, vDsPathArquivo, '0', vTipoEspelho, vDadoIni, vDadoFim, vDsUsuario);
      Result := iRetorno;
    end else if (vModeloEcf = 'ecfElgin') then begin

    end else if (vModeloEcf = 'ecfInterway') or (vModeloEcf = 'ecfUrano') then begin
      if FileExists(vDsPathArquivo) then begin
        DeleteFile(vDsPathArquivo);
      end;

      if (vTipoEspelho <> '2') then Begin// 2 = COO
        vTipoEspelho := 'M';
        vDadoIni   := Copy(vDadoIni, 1,2) + '/' + Copy(vDadoIni, 3,2) + '/' + Copy(vDadoIni, 5,Length(vDadoIni));
        vDadoFim   := Copy(vDadoFim, 1,2) + '/' + Copy(vDadoFim, 3,2) + '/' + Copy(vDadoFim, 5,Length(vDadoFim));
      end else begin
        vTipoEspelho := 'C';
      end;

      geraArquivoTipoEAux(vModeloEcf, vDsArqMfd, vDsPathArquivo, 'TDM', vTipoEspelho, vDadoIni, vDadoFim, vDsUsuario) ;
    end else if (vModeloEcf = 'ecfDaruma') then begin
      if FileExists(getPathECF + 'Espelho_MFD.txt') then begin
        DeleteFile(getPathECF + 'Espelho_MFD.txt');
      end;
      if (vDsPathArquivo <> '') then iRetorno := regAlterarValor_Daruma('START\LocalArquivos', getPathECF());

      iRetorno := rGerarEspelhoMFD_ECF_Daruma(vTipoEspelho, vDadoIni, vDadoFim);
      if FileExists(getPathECF + 'Espelho_MFD.txt') then begin
        vDsArq := TStringList.Create; 
        vDsArq.LoadFromFile(getPathECF + 'Espelho_MFD.txt'); 
        vDsArq.SaveToFile(vDsPathArquivo); 
        vDsArq.Free; 
      end; 

    end else if (vModeloEcf = 'ecfSweda') then begin
      if (vTipoEspelho = '1') then begin
        vAux := copy(vDadoIni, 1, 2) + '/' + copy(vDadoIni, 3, 2) + '/' + copy(vDadoIni, 5, 2); 
        vDadoIni := vAux; 
        vAux := copy(vDadoFim, 1, 2) + '/' + copy(vDadoFim, 3, 2) + '/' + copy(vDadoFim, 5, 2);
        vDadoFim := vAux; 
        vDadoIni := FormatDateTime('dd/mm/yyyy', StrToDateDef(vDadoIni, 0));
        vDadoFim := FormatDateTime('dd/mm/yyyy', StrToDateDef(vDadoFim, 0)); 
      end else if (vTipoEspelho = '2') then begin
        vDadoIni := '0' + vDadoIni; 
        vDadoFim := '0' + vDadoFim; 
      end; 
      result := ECF_DownloadMFD(vDsPathArquivo, vTipoEspelho, vDadoIni, vDadoFim, '1'); 
    end; 
  except
    on E : Exception do ShowMessage(E.Message); 
  end;
end; 

function configuraGuilhotina(vModeloEcf : String; pParams : String) : Integer;
begin
  try
    if (vModeloEcf = 'ecfBematech') or (vModeloEcf = 'ecfYanco') then begin

    end else if (vModeloEcf = 'ecfElgin') then begin

    end else if (vModeloEcf = 'ecfInterway') or (vModeloEcf = 'ecfUrano') then begin

    end else if (vModeloEcf = 'ecfDaruma') then begin
      result := confProgramarAvancoPapel_ECF_Daruma('25','5','6','1','0');
      regAlterarValor_Daruma('ECF\MensagemApl1',' ');
      regAlterarValor_Daruma('ECF\MensagemApl2',' ');
      regAlterarValor_Daruma('ECF\ControleAutomatico','1');
      regAlterarValor_Daruma('ECF\EncontrarECF','1');
      regAlterarValor_Daruma('ECF\PortaSerial', vDsPorta);
      regAlterarValor_Daruma('START\LocalArquivosRelatorios', getPathECF());
    end else if (vModeloEcf = 'ecfSweda') then begin

    end;
  except
    on E : Exception do ShowMessage(E.Message);
  end;
end;

function geraArquivoTipoEAux(vModeloEcf : String; vArqEntr, vArqSai, vTipoLeitura, vTipoPeriodo, vDataIni, vDataFim, vUsuario : string): Integer;
var
  vArquivoTDM, vArquivosaida, vPorta, vDataI, vDataF, vUsu : string;
begin

  try
    if (vModeloEcf = 'ecfBematech') or (vModeloEcf = 'ecfYanco') then begin

    end else if (vModeloEcf = 'ecfElgin') then begin

    end else if (vModeloEcf = 'ecfInterway') or (vModeloEcf = 'ecfUrano') then begin
      Result := DLLG2_ExecutaComando(Handle, 'LeTexto; NomeTexto="NumeroSerieECF"');
      vNrSerie := DLLG2_ObtemRetornos(Handle, vNrSerie, 0);
      vNrSerie := fRetornaValor(vNrSerie, 'ValorTexto','"');

      if vTipoPeriodo <> 'C' then begin
        vDataI := FormatDateTime('YYYYMMDD',StrToDateTime(vDataIni));
        vDataF := FormatDateTime('YYYYMMDD',StrToDateTime(vDataIni));
      end;

      vPorta := LeIni('NR_PORTAECF','COM1');
      InterwayGeraArquivoBinario( vPorta, vArqEntr ,vNrSerie);
      Result := InterwayGeraArquivoAto17(vArqEntr,vArqSai , vDataI, vDataF, vTipoPeriodo[1], vUsuario, vTipoLeitura);
    end else if (vModeloEcf = 'ecfDaruma') then begin

    end else if (vModeloEcf = 'ecfSweda') then begin

    end;
  except
    on E : Exception do ShowMessage(E.Message);
  end;
end;

function numeroIntervencoes(vModeloEcf : String) : Integer;
var
  vDsNumeroInterverncoes : String;
begin
  try
    if (vModeloEcf = 'ecfBematech') or (vModeloEcf = 'ecfYanco') then begin
      vDsNumeroInterverncoes := ReplicateStr(' ', 6);
      Result := Bematech_FI_NumeroIntervencoes(vDsNumeroInterverncoes);
      if retornoImpressoraErro(vModeloEcf, result) then Exit;

      If Trim(vDsNumeroInterverncoes)= '' then vDsNumeroInterverncoes := '0';
      vNrIntervencoes := vDsNumeroInterverncoes;
    end else if (vModeloEcf = 'ecfElgin') then begin

    end else if (vModeloEcf = 'ecfInterway') or (vModeloEcf = 'ecfUrano') then begin

    end else if (vModeloEcf = 'ecfDaruma') then begin

    end else if (vModeloEcf = 'ecfSweda') then begin
      vDsNumeroInterverncoes := ReplicateStr(' ', 6);
      result := ECF_NumeroIntervencoes(vDsNumeroInterverncoes);
      vNrIntervencoes := vDsNumeroInterverncoes;
    end else if (vModeloEcf = 'ecfEpson') then begin

    end;
  except
    on E : Exception do ShowMessage(E.Message); 
  end;
end;

function numeroReducoes(vModeloEcf : String) : Integer;
var
  vDsNumeroReducoes : String;
begin
  try
    if (vModeloEcf = 'ecfBematech') or (vModeloEcf = 'ecfYanco') then begin
      vDsNumeroReducoes  := '';
      vDsNumeroReducoes := ReplicateStr(' ', 4);
      Result := Bematech_FI_NumeroReducoes(vDsNumeroReducoes);
      if retornoImpressoraErro(vModeloEcf, result) then Exit;

      If Trim(vDsNumeroReducoes)= '' then vDsNumeroReducoes := '0';
      vNrNumeroReducoes := vDsNumeroReducoes;
    end else if (vModeloEcf = 'ecfElgin') then begin

    end else if (vModeloEcf = 'ecfInterway') or (vModeloEcf = 'ecfUrano') then begin

    end else if (vModeloEcf = 'ecfDaruma') then begin

    end else if (vModeloEcf = 'ecfSweda') then begin
      vDsNumeroReducoes := ReplicateStr(' ', 6);
      result := ECF_NumeroReducoes(vDsNumeroReducoes);
      vNrNumeroReducoes := vDsNumeroReducoes;
    end else if (vModeloEcf = 'ecfEpson') then begin

    end;
  except
    on E : Exception do ShowMessage(E.Message);
  end;
end;

function retornaContadoresECF(vModeloEcf : String): Integer;
var
  vMensagem, vMetodo,
  sDados, sDadosAux, vRetorno, vDetalhe, vDsArquivo,
  vCRO, vCRZ, vCOO, vCCF, vGNF, vCDC, vGRG, vDtRedZ, vHrRedZ  : String;
  vStatus : Variant;
  F : TextFile;
begin

  vMetodo := 'uECF.retornaContadoresECF()';

  try
    if (vModeloEcf = 'ecfBematech') or (vModeloEcf = 'ecfYanco') then begin
      //CRO
      vCRO := ReplicateStr(' ', 4);
      Result := Bematech_FI_NumeroIntervencoes(vCRO);
      if retornoImpressoraErro(vModeloEcf, result) then Exit;
      If Trim(vCRO)= '' then vCRO := '0';

      //CRZ
      vCRZ  := ReplicateStr(' ', 4);
      Result := Bematech_FI_NumeroReducoes(vCRZ);
      if retornoImpressoraErro(vModeloEcf, result) then Exit;
      If Trim(vCRZ)= '' then vCRZ := '0';

      //COO
      vCOO  := ReplicateStr(' ', 6);
      Result := Bematech_FI_NumeroCupom(vCOO);
      if retornoImpressoraErro(vModeloEcf, result) then Exit;
      If Trim(vCOO)= '' then vCOO := '0';

      //CCF
      vCCF := ReplicateStr(' ', 6);
      Result := Bematech_FI_ContadorCupomFiscalMFD(vCCF);
      if retornoImpressoraErro(vModeloEcf, result) then Exit;
      If Trim(vCCF)= '' then vCCF := '0';

      //GNF
      vGNF := ReplicateStr(' ', 6);
      Result := Bematech_FI_NumeroOperacoesNaoFiscais(vGNF);
      if retornoImpressoraErro(vModeloEcf, result) then Exit;
      If Trim(vGNF)= '' then vGNF := '0';

      //CDC
      vCDC  := ReplicateStr(' ', 6);
      Result := Bematech_FI_ContadorComprovantesCreditoMFD(vCDC);
      if retornoImpressoraErro(vModeloEcf, result) then Exit;
      If Trim(vCDC)= '' then vCDC := '0';

      //GRG
      vGRG  := ReplicateStr(' ', 6);
      Result := Bematech_FI_ContadorRelatoriosGerenciaisMFD(vGRG);
      if retornoImpressoraErro(vModeloEcf, result) then Exit;
      If Trim(vGRG)= '' then vGRG := '0';

      //vDtRedZ
      vDtRedZ := ReplicateStr(' ', 6);
      vHrRedZ := ReplicateStr(' ', 6);
      Result := Bematech_FI_DataHoraReducao(vDtRedZ, vHrRedZ);
      if retornoImpressoraErro(vModeloEcf, result) then Exit;

      vDsArquivo := '';
      vDsArquivo := vDsArquivo + 'CRO...:' + vCRO + sLineBreak;
      vDsArquivo := vDsArquivo + 'CRZ...:' + vCRZ + sLineBreak;
      vDsArquivo := vDsArquivo + 'COO...:' + vCOO + sLineBreak;
      vDsArquivo := vDsArquivo + 'GNF...:' + vGNF + sLineBreak;
      vDsArquivo := vDsArquivo + 'CCF...:' + vCCF + sLineBreak;
      vDsArquivo := vDsArquivo + 'GRG...:' + vGRG + sLineBreak;
      vDsPath := getPathECF();
      AssignFile(F, vDsPath + '\retornaContadoresECF.TXT') ;
      Rewrite(F);
      Write(F, vDsArquivo);
      CloseFile(F);

      Result := 1;
    end else if (vModeloEcf = 'ecfElgin') then begin
      Result := 1;
    end else if (vModeloEcf = 'ecfInterway')then begin
      Result := 0;
    end else if (vModeloEcf = 'ecfUrano') then begin
      Result := 0;
    end else if (vModeloEcf = 'ecfDaruma') then begin
      Result := 1;
    end else if (vModeloEcf = 'ecfSweda') then begin
      Result := 1;
    end;
  except
    on E : Exception do ShowMessage(E.Message);
  end;
end;

end.