
//--------------------------------------------
public int abreCupom( string vModeloEcf , string  vCnpj ) 
{
 string vresult ;
    vCodresult :  int;
{
    try      if ((vModeloEcf == "ecfBematech") | (vModeloEcf == 'ecfYanco')) {        result = Bematech_FI_AbreCupom(vCnpj); 
      end; else  if ((vModeloEcf == "ecfElgin")) {        result = Elgin_AbreCupomMFD(vCnpj, ','); 
      end; else  if ((vModeloEcf == "ecfInterway") | (vModeloEcf == 'ecfUrano')) {         if ( vCnpj.Trim() != ') {          Result = DLLG2_ExecutaComando(Handle, PChar('AbreCupomFiscal; 
  IdConsumidor=" + "\"' + vCnpj + '\"'))       end; else {          Result = DLLG2_ExecutaComando(Handle, PChar('AbreCupomFiscal')); 
      }
     end; else  if ((vModeloEcf == "ecfDaruma")) {         if ((vCnpj == ')) vCnpj = ' '; 
        result = iCFAbrir_ECF_Daruma(vCnpj, " ", ' '); 
      end; else  if ((vModeloEcf == "ecfSweda")) {        result = ECF_AbreCupom(PChar(vCnpj)); 
      end; else  if ((vModeloEcf == "ecfEpson")) {        result = EPSON_Fiscal_Abrir_Cupom(PChar(vCnpj), ', ', ', 2); 
    }
   except     on E : Exception) ShowMessage(E.Message);
  }
}
}

//--------------------------------------------
 public int abreCupomMFD( string vModeloEcf,  string vCpf,  string vNome,  string vEndereco ) 
{
    try      if ((vModeloEcf == "ecfBematech") | (vModeloEcf == 'ecfYanco')) {        vDsResposta = LeituraIndicadores(vModeloEcf); 
         if ((vDsResposta == "Impressora Vendendo")       | (vDsResposta == 'Impressora Pagamento')) {          result = Bematech_FI_CancelaCupomMFD(vCpf, vNome, vEndereco); 
      }
       result = Bematech_FI_AbreCupomMFD(vCpf, vNome, vEndereco); 
      end; else  if ((vModeloEcf == "ecfElgin")) {        result = Elgin_AbreCupomMFD(vCpf, vNome, vEndereco); 
      end; else  if ((vModeloEcf == "ecfInterway") | (vModeloEcf == 'ecfUrano')) {         if ( vCpf.Trim() != ')         result = DLLG2_ExecutaComando(Handle, PChar('AbreCupomFiscal; 
  IdConsumidor=" + "\"' + vCpf +'\"')) 
      else
         result = DLLG2_ExecutaComando(Handle, PChar("AbreCupomFiscal")); 
      end; else  if ((vModeloEcf == "ecfDaruma")) {         if ((vCpf == ')) vCpf = ' '; 
         if ((vNome == ")) vNome = " '; 
         if ((vEndereco == ")) vEndereco = " '; 
        Result = iCFAbrir_ECF_Daruma(vCpf, vNome, vEndereco); 
      end; else  if ((vModeloEcf == "ecfSweda")) {        result = ECF_AbreCupomMFD(PChar(vCpf),PChar(vNome),PChar(vEndereco)); 
      end; else  if ((vModeloEcf == "ecfEpson")) {        result = EPSON_Fiscal_Abrir_Cupom(PChar(vCpf), PChar(vNome), PChar(vEndereco), ', 2); 
    }
   except     on E : Exception) ShowMessage(E.Message);
  }
}

//--------------------------------------------
public int cancelaCupom( string vModeloEcf ) 
{
 int i ;
    vResult, vDSCOO : string;
{
    try      if ((vModeloEcf == "ecfBematech") | (vModeloEcf == 'ecfYanco')) {        result = Bematech_FI_CancelaCupom(); 
      end; else  if ((vModeloEcf == "ecfElgin")) {        result = Elgin_CancelaCupom(); 
      end; else  if ((vModeloEcf == "ecfInterway") | (vModeloEcf == 'ecfUrano')) {        result = DLLG2_ExecutaComando(Handle, 'CancelaCupom'); 
      end; else  if ((vModeloEcf == "ecfDaruma")) {        result = iCFCancelar_ECF_Daruma(); 
      end; else  if ((vModeloEcf == "ecfSweda")) {        result = ECF_CancelaCupom(); 
      end; else  if ((vModeloEcf == "ecfEpson")) {        result = EPSON_Fiscal_Cancelar_Cupom; 
    }
   except     on E : Exception) ShowMessage(E.Message);
  }
}
}

//--------------------------------------------
 public int cancelaCupomMFD( string vModeloEcf,  string  vCpf,  string  vNome,  string  vEndereco ) 
{
    try      if ((vModeloEcf == "ecfBematech") | (vModeloEcf == 'ecfYanco')) {        result = Bematech_FI_CancelaCupomMFD(vCpf, vNome, vEndereco); 
      end; else  if ((vModeloEcf == "ecfElgin")) {        result = Elgin_CancelaCupomMFD(vCpf, vNome, vEndereco); 
      end; else  if ((vModeloEcf == "ecfInterway") | (vModeloEcf == 'ecfUrano')) {        result = DLLG2_ExecutaComando(Handle, 'CancelaCupom'); 
      end; else  if ((vModeloEcf == "ecfDaruma")) {        result = iCFCancelar_ECF_Daruma(); 
      end; else  if ((vModeloEcf == "ecfSweda")) {        result = ECF_CancelaCupomMFD(vCpf, vNome, vEndereco); 
      end; else  if ((vModeloEcf == "ecfEpson")) {        result = EPSON_Fiscal_Cancelar_Cupom; 
    }
   except     on E : Exception) ShowMessage(E.Message);
  }
}
{
 string vresult ;
{
    try      if ((vModeloEcf == "ecfBematech") | (vModeloEcf == 'ecfYanco')) {        try          Result = Bematech_FI_EstornoNaoFiscalVinculadoMFD(',','); 
        except
      }
     end; else  if ((vModeloEcf == "ecfElgin")) {        result  = Elgin_EstornoNaoFiscalVinculadoMFD(',','); 
        Result  = Elgin_FechaComprovanteNaoFiscalVinculado(); 
      end; else  if ((vModeloEcf == "ecfInterway") | (vModeloEcf == 'ecfUrano')) {        result = DLLG2_ExecutaComando(Handle, 'EstornaCreditoDebito; 
 COO=' + vNrCupom);
      end; else  if ((vModeloEcf == "ecfDaruma")) {        result = iCCDEstornar_ECF_Daruma(vNrCupom, ',','); 
      end; else  if ((vModeloEcf == "ecfSweda")) {        Result = ECF_EstornoNaoFiscalVinculadoMFD(',','); 
        Result = ECF_FechaComprovanteNaoFiscalVinculado; 
      end; else  if ((vModeloEcf == "ecfEpson")) {        result = EPSON_NaoFiscal_Cancelar_CCD(',', 0,', PChar(vNrCupom)); 
    }
   except     on E : Exception) ShowMessage(E.Message);
  }
}
}

//--------------------------------------------
  public int leituraX( string vModeloEcf ) 
{
  int vretorno;
   int  i ;
    vMensagem : string;
{
    try      if ((vModeloEcf == "ecfBematech") | (vModeloEcf == 'ecfYanco')) {        vRetorno = Bematech_FI_LeituraX(); 
         if ((vRetorno == 0)) vRetorno = 1; 
        Result = vRetorno; 
      end; else  if ((vModeloEcf == "ecfElgin")) {        result = Elgin_LeituraX(); 
      end; else  if ((vModeloEcf == "ecfInterway") | (vModeloEcf == 'ecfUrano')) {        result = DLLG2_ExecutaComando(Handle, 'EmiteLeituraX'); 
      end; else  if ((vModeloEcf == "ecfDaruma")) {        result = iLeituraX_ECF_Daruma(); 
      end; else  if ((vModeloEcf == "ecfSweda")) {        result = ECF_LeituraX(); 
      end; else  if ((vModeloEcf == "ecfEpson")) {        result = EPSON_RelatorioFiscal_LeituraX; 
    } 
   except     on E : Exception) ShowMessage(E.Message);
  } 
} 
}

//--------------------------------------------
 public int reducaoZ( string vModeloEcf ) 
{
  string szcrz;
   string  vresult ;
    i : int;
{
    try      if ((vModeloEcf == "ecfBematech") | (vModeloEcf == 'ecfYanco')) {        result = Bematech_FI_ReducaoZ(','); 
      end; else  if ((vModeloEcf == "ecfElgin")) {        result = Elgin_ReducaoZ(','); 
      end; else  if ((vModeloEcf == "ecfInterway") | (vModeloEcf == 'ecfUrano')) {        result = DLLG2_ExecutaComando(Handle, 'EmiteReducaoZ'); 
      end; else  if ((vModeloEcf == "ecfDaruma")) {        result = iReducaoZ_ECF_Daruma(' ',' '); 
      end; else  if ((vModeloEcf == "ecfSweda")) {        result = ECF_ReducaoZ(','); 
      end; else  if ((vModeloEcf == "ecfEpson")) {        szCRZ = ReplicateStr(' ', 20); 
        result = EPSON_RelatorioFiscal_RZ(",", 9, PChar(szCRZ)); 
    }
   except     on E : Exception) ShowMessage(E.Message);
  }
}
}

//--------------------------------------------
 public int vendeItem( string vModeloEcf , string  Item , string  Codigo , string  Descricao , string  Aliquota , string  TipoQuantidade , string  Quantidade , string  CasasDecimais , string  ValorUnitario , string  TipoDesconto , string  Desconto , string  Unidade ) 
{
  real vvldesconto;
   real  vvlunitario;
   real  vvlaliquota ;
    vDsCodAliquota, vDsresult,vAliquotaTeste : string;
    vCasasDecimaisQt, vCodresult : int;
{
    try      if ((vModeloEcf == "ecfBematech") | (vModeloEcf == 'ecfYanco')) {        Descricao =  Descricao.Substring( 1,  29); 
        end; else {          result = Bematech_FI_VendeItem(PChar(Codigo), PChar(Descricao), PChar(Aliquota),                   PChar(TipoQuantidade), PChar(Quantidade), StrToIntDef(CasasDecimais, 0), PChar(ValorUnitario),                   PChar(TipoDesconto), "0"); 
          Result  = acrescimoDescontoItem(vModeloEcf, PChar(Item), "A", TipoDesconto, PChar(Desconto)); 
      }
     end; else  if ((vModeloEcf == "ecfElgin")) {         if ((StrToFloat(Desconto) >= 0)) {          result = Elgin_VendeItem(Codigo,Descricao,Aliquota,TipoQuantidade,Quantidade,StrToIntDef(CasasDecimais, 0),ValorUnitario,TipoDesconto,Desconto); 
        end; else {          result = Elgin_VendeItem(Codigo,Descricao,Aliquota,TipoQuantidade,Quantidade,StrToIntDef(CasasDecimais, 0),ValorUnitario,TipoDesconto,"0"); 
          Result = acrescimoDescontoItem(vModeloEcf, PChar(Item), "A", TipoDesconto, PChar(Desconto)); 
      }
     end; else  if ((vModeloEcf == "ecfInterway")) {        vVlUnitario = StrToFloatDef(ValorUnitario, 0); 
        vVlUnitario = vVlUnitario / 100; 
        ValorUnitario = FloatToStr(vVlUnitario); 
         vDsCodAliquota = '; 
         if ( Aliquota.Trim() == "NN")         vDsCodAliquota = '-4'      ; else  if (trim(Aliquota) == 'II')         vDsCodAliquota = '-3'      ; else  if (trim(Aliquota) == 'FF')         vDsCodAliquota = '-2'      ; else {          vVlAliquota = StrToFloatDef(Aliquota, 0); 
           if ((vVlAliquota > 0)) {            vVlAliquota = vVlAliquota / 100; 
            Aliquota = FloatToStr(vVlAliquota); 
        }
      }
 CodAliquota=" + vDsCodAliquota + "; 
 CodProduto=" + "\"' + Codigo + '\"' + '; 
 NomeProduto=" + "\"' + Descricao + '\"' + '; 
 PrecoUnitario=" + ValorUnitario + "; 
 Quantidade=' + Quantidade)
      else
         result = DLLG2_ExecutaComando(Handle, 'VendeItem; 
 AliquotaICMS=true;
 CodProduto=" + "\"' + Codigo + '\"' + '; 
 NomeProduto=" + "\"' + Descricao + '\"' + '; 
 PercentualAliquota=" + Aliquota + "; 
 PrecoUnitario=" + ValorUnitario + "; 
 Quantidade=' + Quantidade);
          vVlDesconto = StrToFloatDef(Desconto, 0); 
           if ((vVlDesconto > 0)) {            vVlDesconto = vVlDesconto * -1; 
            DLLG2_ExecutaComando(Handle, 'AcresceItemFiscal;
 Cancelar=false;
 ValorAcrescimo=' + FloatToStr(vVlDesconto));
        }
      }
     end; else  if ((vModeloEcf == "ecfUrano")) {  //Zottis 13/03/2014       vVlUnitario = StrToFloatDef(ValorUnitario, 0);
 //Zottis 13/03/2014       vVlUnitario = StrToFloatDef(ValorUnitario, 0);
 //Zottis 13/03/2014       vVlUnitario := StrToFloatDef(ValorUnitario, 0);
        ValorUnitario = FloatToStr(vVlUnitario); 
        vDsCodAliquota = '; 
         if ( Aliquota.Trim() == "NN")         vDsCodAliquota = '-4'      ; else  if (trim(Aliquota) == 'II')         vDsCodAliquota = '-3'      ; else  if (trim(Aliquota) == 'FF')         vDsCodAliquota = '-2'      ; else {          vVlAliquota = StrToFloatDef(Aliquota, 0); 
           if ((vVlAliquota > 0)) {            vVlAliquota = vVlAliquota / 100; 
            Aliquota = FloatToStr(vVlAliquota); 
        }
      }
 CodAliquota=" + vDsCodAliquota + " CodProduto=' + '\"' + Codigo + '\"' + ' NomeProduto=' + '\"' +  Descricao.Substring(1, 30) + '\"' + ' PrecoUnitario=' + ValorUnitario + ' Quantidade=' + Quantidade + ' Unidade=' + '\"' + unidade + '\"; 
 ")       end; else {          result = DLLG2_ExecutaComando(Handle, "VendeItem; 
 AliquotaICMS=true CodProduto=" + "\"' + Codigo + '\"' + ' NomeProduto=' + '\"' +  Descricao.Substring(1, 30) + '\"' + ' PercentualAliquota=' + Aliquota + ' PrecoUnitario=' + ValorUnitario + ' Quantidade=' + Quantidade + ' Unidade=' + '\"' + unidade + '\"; 
 ');
      }
         if (retornoImpressoraErro(vModeloEcf, result)) return;
          vVlDesconto = StrToFloatDef(Desconto, 0); 
           if ((vVlDesconto > 0)) {            vVlDesconto = vVlDesconto * -1; 
            result = DLLG2_ExecutaComando(Handle, 'AcresceItemFiscal; 
 Cancelar=false ValorAcrescimo=' + FloatToStr(vVlDesconto));
        }
      }
     end ; else  if ((vModeloEcf == "ecfDaruma")) {        result = iCFVender_ECF_Daruma(Aliquota, Quantidade, PChar(ValorUnitario), 'D' + TipoDesconto, Desconto, Codigo, Unidade, Descricao); 
      end; else  if ((vModeloEcf == "ecfSweda")) {         if ((StrToFloat(Desconto) >= 0)) {          result = ECF_VendeItem(PChar(Codigo), PChar(Descricao), PChar(Aliquota),                   PChar(TipoQuantidade), PChar(Quantidade), StrToIntDef(CasasDecimais, 0), PChar(ValorUnitario),                   PChar(TipoDesconto), PChar(Desconto)); 
        end; else {          result = ECF_VendeItem(PChar(Codigo), PChar(Descricao), PChar(Aliquota),                   PChar(TipoQuantidade), PChar(Quantidade), StrToIntDef(CasasDecimais, 0), PChar(ValorUnitario),                   PChar(TipoDesconto), PChar(0)); 
          Desconto = FloatToStr(strtofloat(desconto) * (-1)); 
          Result  = acrescimoDescontoItem(vModeloEcf, PChar(Item), "A", TipoDesconto, PChar(Desconto)); 
      }
     end; else  if ((vModeloEcf == "ecfEpson")) {        ValorUnitario = ReplaceStr(ValorUnitario, ',','); 
        Quantidade = FormatFloat(", 0.000", StrToFloatDef(Quantidade, 0)); 
        Quantidade = ReplaceStr(Quantidade, ".",'); 
        Quantidade = ReplaceStr(Quantidade, ",",'); 
        Quantidade =  Quantidade.Trim(); 
        vCasasDecimaisQt = 3; 
         vAliquotaTeste  =  LeIni("ALIQUOTA_TESTE",'); 
         if (vAliquotaTeste != ') {          aliquota = vAliquotaTeste; 
      }
        result = EPSON_Fiscal_Vender_Item(PChar(Codigo), PChar(Descricao), PChar(Quantidade), vCasasDecimaisQt, PChar(Unidade), PChar(ValorUnitario), 2, PChar(Aliquota), 1); 
         if ( Desconto.Trim() != ") {          Desconto = ReplaceStr(Desconto, ".','); 
          Desconto = ReplaceStr(Desconto, ",",'); 
          vVlDesconto = StrToFloatDef(Desconto, 0); 
           if ((vVlDesconto > 0)) {            result = EPSON_Fiscal_Desconto_Acrescimo_Item(PChar(Desconto), 2, true, false); 
          end; else          if ((vVlDesconto < 0)) {            Desconto =  FloatToStr(vVlDesconto * (-1)); 
            result = EPSON_Fiscal_Desconto_Acrescimo_Item(PChar(Desconto), 2, false, false); 
        }
      }
    }
   except     on E : Exception) ShowMessage(E.Message);
  }
}
}

//--------------------------------------------
 public int vendeItemDepartamento( string vModeloEcf , string  Codigo , string  Descricao , string  Aliquota , string  ValorUnitario , string  Quantidade , string  Acrescimo , string  Desconto , string  IndiceDepartamento , string  UnidadeMedida ) 
{
    try      if ((vModeloEcf == "ecfBematech")) {        result = Bematech_FI_VendeItemDepartamento(PChar(Codigo), PChar(Descricao), PChar(Aliquota), PChar(ValorUnitario), PChar(Quantidade), PChar(Acrescimo),                                                   PChar(Desconto), PChar(IndiceDepartamento), PChar(UnidadeMedida)); 
      end; else  if ((vModeloEcf == "ecfElgin")) {        result = Elgin_VendeItemDepartamento(PChar(Codigo), PChar(Descricao), PChar(Aliquota), PChar(ValorUnitario), PChar(Quantidade), PChar(Acrescimo),                                             PChar(Desconto), PChar(IndiceDepartamento), PChar(UnidadeMedida)); 
      end; else  if ((vModeloEcf == "ecfInterway") | (vModeloEcf == 'ecfUrano')) {       end; else  if ((vModeloEcf == 'ecfDaruma')) {       end; else  if ((vModeloEcf == 'ecfSweda')) {        result = ECF_VendeItemDepartamento(PChar(Codigo), PChar(Descricao), PChar(Aliquota), PChar(ValorUnitario), PChar(Quantidade), PChar(Acrescimo),                                           PChar(Desconto), PChar(IndiceDepartamento), PChar(UnidadeMedida)); 
    }
   except     on E : Exception) ShowMessage(E.Message);
  }
}

//--------------------------------------------
public int acrescimoDescontoCupom( string vModeloEcf , string  AcrescimoDesconto , string  TipoAcrescimoDesconto , string  ValorAcrescimoDesconto ) 
        vVlDesconto : Real;
{
    try      if ((vModeloEcf == "ecfBematech") | (vModeloEcf == 'ecfYanco')) {        result = Bematech_FI_IniciaFechamentoCupom(AcrescimoDesconto, TipoAcrescimoDesconto, ValorAcrescimoDesconto); 
      end; else  if ((vModeloEcf == "ecfElgin")) {         if ( ValorAcrescimoDesconto.Trim() == ') ValorAcrescimoDesconto = '0'; 
 Cancelar=false;
 ValorAcrescimo=' + ValorAcrescimoDesconto);
      end; else  if ((vModeloEcf == "ecfUrano")) {   //Zottis 01/04/2014        if (trim(ValorAcrescimoDesconto) != ') {          ValorAcrescimoDesconto = stringReplace(ValorAcrescimoDesconto, '.',',', [rfReplaceAll]);
 //Zottis 01/04/2014        if (trim(ValorAcrescimoDesconto) != ') {          ValorAcrescimoDesconto = stringReplace(ValorAcrescimoDesconto, '.',',', [rfReplaceAll]);
 //Zottis 01/04/2014        if (trim(ValorAcrescimoDesconto) != ') {          ValorAcrescimoDesconto := stringReplace(ValorAcrescimoDesconto, '.',',', [rfReplaceAll]);
      }
        vVlDesconto = StrToFloatDef(ValorAcrescimoDesconto, 0); 
         if (AcrescimoDesconto == "D") {           if ((vVlDesconto > 0)) {            vVlDesconto = vVlDesconto * -1; 
        }
      }
         if ((StrToFloatDef(ValorAcrescimoDesconto, 0) > 0)) {          result = DLLG2_ExecutaComando(Handle, 'AcresceSubtotal; 
 Cancelar=false ValorAcrescimo=' + FloatToStr(vVlDesconto));
      }
     end; else  if ((vModeloEcf == "ecfDaruma")) {        result = iCFTotalizarCupom_ECF_Daruma(AcrescimoDesconto+TipoAcrescimoDesconto, ValorAcrescimoDesconto)     end; else  if ((vModeloEcf == 'ecfSweda')) {         if (StrTofloatDef(ValorAcrescimoDesconto,0) < 0) {          ValorAcrescimoDesconto = FloatToStr(StrTofloatDef(ValorAcrescimoDesconto,0) * (-1)); 
          ValorAcrescimoDesconto = FloatToStr(StrTofloatDef(ValorAcrescimoDesconto,0) * 100); 
      }
       result = ECF_AcrescimoDescontoSubtotalMFD(PChar(AcrescimoDesconto),PChar(TipoAcrescimoDesconto), PChar(ValorAcrescimoDesconto)); 
      end; else  if ((vModeloEcf == "ecfEpson")) {         if (ValorAcrescimoDesconto == ') {          ValorAcrescimoDesconto = '0'; 
      }
        ValorAcrescimoDesconto = FormatFloat("0.000", StrToFloatDef(ValorAcrescimoDesconto, 0)); 
        ValorAcrescimoDesconto = stringReplace(ValorAcrescimoDesconto,",",',[rfReplaceAll]); 
        ValorAcrescimoDesconto = stringReplace(ValorAcrescimoDesconto,".",',[rfReplaceAll]); 
          if ((ValorAcrescimoDesconto != ") & ((StrToFloat(ValorAcrescimoDesconto) != 0))) {           if ((AcrescimoDesconto == "A'))  // Acréscimo           result = EPSON_Fiscal_Desconto_Acrescimo_Subtotal(PAChar(ValorAcrescimoDesconto),3,False,False)
 // Acréscimo           result = EPSON_Fiscal_Desconto_Acrescimo_Subtotal(PAChar(ValorAcrescimoDesconto),3,False,False)
 // Acréscimo           result := EPSON_Fiscal_Desconto_Acrescimo_Subtotal(PAChar(ValorAcrescimoDesconto),3,False,False)
        else
           result = EPSON_Fiscal_Desconto_Acrescimo_Subtotal(pAChar(ValorAcrescimoDesconto),3,True,False); 
      }
    }
   except     on E : Exception) ShowMessage(E.Message);
  } 
} 

//--------------------------------------------
public int efetuaFormaPagamento( string vModeloEcf , string  FormaPagamento , string  ValorFormaPagamento ) 
{
    try      if ((vModeloEcf == "ecfBematech") | (vModeloEcf == 'ecfYanco')) {        result = Bematech_FI_EfetuaFormaPagamento(FormaPagamento, ValorFormaPagamento); 
      end; else  if ((vModeloEcf == "ecfElgin")) {        result = Elgin_EfetuaFormaPagamento(FormaPagamento, ValorFormaPagamento); 
      end; else  if ((vModeloEcf == "ecfInterway") | (vModeloEcf == 'ecfUrano')) {         // a ECF Interway, não reconhece a string \"Dinheiro\" que é pré cadastrada       // para a condição pré cadastrada, tem que enviar o indice        if (Trim(FormaPagamento) == 'Dinheiro')         result = DLLG2_ExecutaComando(Handle, 'PagaCupom;
 // a ECF Interway, não reconhece a string \"Dinheiro\" que é pré cadastrada       // para a condição pré cadastrada, tem que enviar o indice        if (Trim(FormaPagamento) = 'Dinheiro')         result = DLLG2_ExecutaComando(Handle, 'PagaCupom;
 // a ECF Interway, não reconhece a string \"Dinheiro\" que é pré cadastrada       // para a condição pré cadastrada, tem que enviar o indice        if (Trim(FormaPagamento) = 'Dinheiro')         result := DLLG2_ExecutaComando(Handle, 'PagaCupom;
 CodMeioPagamento=-2 Valor=' + ValorFormaPagamento)
      else
         result = DLLG2_ExecutaComando(Handle, 'PagaCupom; 
 NomeMeioPagamento=" + "\"' + FormaPagamento + '\"' + ' Valor=' + ValorFormaPagamento); 
      end; else  if ((vModeloEcf == "ecfDaruma")) {        ValorFormaPagamento = FormatFloat('0000000000.00', StrToFloatDef(ValorFormaPagamento, 0)); 
        result = iCFEfetuarPagamentoFormatado_ECF_Daruma(FormaPagamento, ValorFormaPagamento); 
      end; else  if ((vModeloEcf == "ecfSweda")) {        result = ECF_EfetuaFormaPagamento(PChar(FormaPagamento), PChar(ValorFormaPagamento)); 
      end; else  if ((vModeloEcf == "ecfEpson")) {        ValorFormaPagamento = ReplaceStr(ValorFormaPagamento, '.','); 
        ValorFormaPagamento = ReplaceStr(ValorFormaPagamento, ",",'); 
        result = EPSON_Fiscal_Pagamento(PChar(FormaPagamento), PChar(ValorFormaPagamento), 2, ","); 
    }
   except     on E : Exception) ShowMessage(E.Message);
  }
}

//--------------------------------------------
public int fechaCupom( string vModeloEcf , string  MensagemPromocional ) 
{
  string vlinha1;
   string  vlinha2;
   string  vlinha3;
   string  vlinha4;
   string  vlinha5;
   string  vlinha6;
   string  vlinha7;
   string  vlinha8 ;
    vstLista : string[];
    i : int;
    vResult  : string;
{
    try      if ((vModeloEcf == "ecfBematech") | (vModeloEcf == 'ecfYanco')) {        result = Bematech_FI_TerminaFechamentoCupom(MensagemPromocional); 
      end; else  if ((vModeloEcf == "ecfElgin")) {        result = Elgin_TerminaFechamentoCupom(MensagemPromocional); 
      end; else  if ((vModeloEcf == "ecfInterway") | (vModeloEcf == 'ecfUrano')) {         if ( MensagemPromocional.Trim() == ') {          result = DLLG2_ExecutaComando(Handle, 'EncerraDocumento')       end; else {          result = DLLG2_ExecutaComando(Handle, 'EncerraDocumento; 
 TextoPromocional=" + "\"' + MensagemPromocional + '\"'); 
      }
     end; else  if ((vModeloEcf == "ecfDaruma")) {        result = iCFEncerrar_ECF_Daruma('0', MensagemPromocional); 
      end; else  if ((vModeloEcf == "ecfSweda")) {        result = ECF_TerminaFechamentoCupom(PChar(MensagemPromocional)); 
      end; else  if ((vModeloEcf == "ecfEpson")) {         if ( MensagemPromocional.Trim() != ') {          try           vstLista = new  string[]; 
            vstLista.Text = MensagemPromocional; 
for ( i ==  0;  i <=  vstLista.Count - 1) {              case i of               0 : vLinha1 = vstLista[i];;  i++)
                1 : vLinha2 = vstLista[i]; 
                2 : vLinha3 = vstLista[i]; 
                3 : vLinha4 = vstLista[i]; 
                4 : vLinha5 = vstLista[i]; 
                5 : vLinha6 = vstLista[i]; 
                6 : vLinha7 = vstLista[i]; 
                7 : vLinha8 = vstLista[i]; 
            }
          }
        }
          result = EPSON_Fiscal_Imprimir_Mensagem(PChar(vLinha1), PChar(vLinha2), PChar(vLinha3), PChar(vLinha4), PChar(vLinha5), PChar(vLinha6), PChar(vLinha7), PChar(vLinha8)); 
      }
       result = EPSON_Fiscal_Fechar_Cupom(True, false); 
    }
   except     on E : Exception) ShowMessage(E.Message);
  }
} 
}

//--------------------------------------------
 public int cancelaItem( string vModeloEcf , string  Indice ) 
{
    try      if ((vModeloEcf == "ecfBematech") | (vModeloEcf == 'ecfYanco')) {        result = Bematech_FI_CancelaItemGenerico(Indice); 
      end; else  if ((vModeloEcf == "ecfElgin")) {        result = Elgin_CancelaItemGenerico(Indice); 
      end; else  if ((vModeloEcf == "ecfInterway") | (vModeloEcf == 'ecfUrano')) {        result = DLLG2_ExecutaComando(Handle, 'CancelaItemFiscal'); 
      end; else  if ((vModeloEcf == "ecfDaruma")) {        result = iCFCancelarItem_ECF_Daruma(Indice); 
      end; else  if ((vModeloEcf == "ecfSweda")) {        result = ECF_CancelaItemGenerico(Indice); 
      end; else  if ((vModeloEcf == "ecfEpson")) {        result = EPSON_Fiscal_Cancelar_Item(PChar(Indice)); 
    } 
   except     on E : Exception) ShowMessage(E.Message);
  } 
} 

//--------------------------------------------
public int leituraMemoriaFiscalPorDatas( string vModeloEcf , string  DataIni , string  DataFim ) 
{
  string vdados;
   string vresult    ;
    vTamanhoBuffer, i : int;
{
    try      if ((vModeloEcf == "ecfBematech") | (vModeloEcf == 'ecfYanco')) {        result = Bematech_FI_LeituraMemoriaFiscalData(PChar(DataIni), PChar(DataFim)); 
      end; else  if ((vModeloEcf == "ecfElgin")) {        result = Elgin_LeituraMemoriaFiscalData(DataIni, DataFim, 's'); 
      end; else  if ((vModeloEcf == "ecfInterway") ) {        result = DLLG2_ExecutaComando(Handle, 'EmiteLeituraMF; 
 DataFinal=#" + DataFim + "#; 
 DataInicial=#" + DataIni + "#; 
 Destino=\"I\";
 LeituraSimplificada=true');
      end; else  if ((vModeloEcf == "ecfUrano")) {        result = DLLG2_ExecutaComando(Handle, 'EmiteLeituraMF; 
 DataFinal=#" + DataFim + "# DataInicial=#' + DataIni + '# Destino=\"I\" LeituraSimplificada=false'); 
      end; else  if ((vModeloEcf == "ecfDaruma")) {        result = regAlterarValor_Daruma('ECF\\LMFCOMPLETA','1'); 
        result =  iMFLer_ECF_Daruma(DataIni, DataFim); 
      end; else  if ((vModeloEcf == "ecfSweda")) {        result = ECF_LeituraMemoriaFiscalData(PChar(DataIni), PChar(DataFim)); 
      end; else  if ((vModeloEcf == "ecfEpson")) {        Set  10000.Length ; 
        vTamanhoBuffer = 0; 
        result = EPSON_RelatorioFiscal_Leitura_MF(PChar(DataIni), PChar(DataFim), 5, PChar(vDados), ', @vTamanhoBuffer, 10000); 
    } 
   except     on E : Exception) ShowMessage(E.Message);
  } 
} 
}

//--------------------------------------------
 public int leituraMemoriaFiscalPorDatasMFD( string vModeloEcf , string  DataIni , string  DataFim , string  Tipo ) 
{
  string vdados;
   string  vdsresult ;
    vTamanhoBuffer, i : int;
{
    try      if ((vModeloEcf == "ecfBematech") | (vModeloEcf == 'ecfYanco')) {        result = Bematech_FI_LeituraMemoriaFiscalDataMFD(PChar(DataIni), PChar(DataFim), PChar(Tipo)); 
      end; else  if ((vModeloEcf == "ecfElgin")) {        result = Elgin_LeituraMemoriaFiscalData(PChar(DataIni), PChar(DataFim), PChar(Tipo)); 
      end; else  if ((vModeloEcf == "ecfInterway")) {         if (( Tipo.ToLower() == 's'))         result = DLLG2_ExecutaComando(Handle, 'EmiteLeituraMF; 
 DataFinal=#" + DataFim + "#; 
 DataInicial=#" + DataIni + "#; 
 Destino=\"I\";
 LeituraSimplificada=true')
      else
         result = DLLG2_ExecutaComando(Handle, 'EmiteLeituraMF; 
 DataFinal=#" + DataFim + "#; 
 DataInicial=#" + DataIni + "#; 
 Destino=\"I\";
 LeituraSimplificada=false")     end; else  if ((vModeloEcf == "ecfUrano')) {         if (( Tipo.ToLower() == 's'))         result = DLLG2_ExecutaComando(Handle, 'EmiteLeituraMF; 
 DataFinal=#" + DataFim + "# DataInicial=#' + DataIni + '# Destino=\"I\" LeituraSimplificada=true') 
      else
         result = DLLG2_ExecutaComando(Handle, 'EmiteLeituraMF; 
 DataFinal=#" + DataFim + "# DataInicial=#' + DataIni + '# Destino=\"I\" LeituraSimplificada=false'); 
      end else  if ((vModeloEcf == "ecfDaruma")) {         if (( Tipo.ToLower() == 's'))         result = regAlterarValor_Daruma('ECF\\LMFCOMPLETA','0') 
      else
         result = regAlterarValor_Daruma("ECF\\LMFCOMPLETA",'1'); 
        result = iMFLer_ECF_Daruma(DataIni, DataFim); 
      end; else  if ((vModeloEcf == "ecfSweda")) {        result = ECF_LeituraMemoriaFiscalDataMFD(PChar(DataIni), PChar(DataFim), PChar(Tipo)); 
      end; else  if ((vModeloEcf == "ecfEpson")) {        Set  10000.Length ; 
        vTamanhoBuffer = 0; 
        DataIni = stringReplace(DataIni, "/",', [rfReplaceAll]); 
        DataFim = stringReplace(DataFim, "/",', [rfReplaceAll]); 
        result = EPSON_RelatorioFiscal_Leitura_MF(PChar(DataIni), PChar(DataFim), 7, PChar(vDados), ', @vTamanhoBuffer, 10000); 
    } 
   except     on E : Exception) ShowMessage(E.Message);
  }
}
}

//--------------------------------------------
 public int leituraMemoriaFiscalSerialPorDatasMFD( string vModeloEcf , string  DataIni , string  DataFim , string  Tipo ) 
{
 textfile f ;
    vDados, vDsResult, vArquivo, vDsConteudo, vDsLinha : string;
    vTamanhoBuffer, i : int;
{
    try      if ((vModeloEcf == "ecfBematech") | (vModeloEcf == 'ecfYanco')) {        result = Bematech_FI_LeituraMemoriaFiscalSerialDataMFD(PChar(DataIni), PChar(DataFim), PChar(Tipo)); 
      end; else  if ((vModeloEcf == "ecfElgin")) {        result = Elgin_LeituraMemoriaFiscalSerialData(PChar(DataIni), PChar(DataFim), PChar(Tipo)); 
      end; else  if ((vModeloEcf == "ecfInterway")) {         if (( Tipo.ToLower() == 's'))         result = DLLG2_ExecutaComando(Handle, 'EmiteLeituraMF; 
 DataFinal=#" + DataFim + "#; 
 DataInicial=#" + DataIni + "#; 
 Destino=\"S\";
 LeituraSimplificada=true')
      else
         result = DLLG2_ExecutaComando(Handle, 'EmiteLeituraMF; 
 DataFinal=#" + DataFim + "#; 
 DataInicial=#" + DataIni + "#; 
 Destino=\"S\";
 LeituraSimplificada=false');
          vDsLinha = DLLG2_ObtemRetornos(Handle, vDsLinha, 0); 
          vDsLinha = fRetornaValor(vDsLinha, "TextoImpressao",'\"'); 
          vDsConteudo = vDsConteudo + vDsLinha; 
        until (vDsLinha == '); 
{
 textfile f ;
{
= getpathecf( uivo ;
  + "retorno.txt"
        GravarArqBin(vArquivo, vDsConteudo);
      end; else  if ( (vModeloEcf == "ecfUrano")) {  //Zottis 14/03/2014        if ((LowerCase(Tipo) == 's'))         result = DLLG2_ExecutaComando(Handle, 'EmiteLeituraMF;
 //Zottis 14/03/2014        if ((LowerCase(Tipo) = 's'))         result = DLLG2_ExecutaComando(Handle, 'EmiteLeituraMF;
 //Zottis 14/03/2014        if ((LowerCase(Tipo) = 's'))         result := DLLG2_ExecutaComando(Handle, 'EmiteLeituraMF;
 DataFinal=#" + DataFim + "# DataInicial=#' + DataIni + '# Destino=\"S\" LeituraSimplificada=true') 
      else
         result = DLLG2_ExecutaComando(Handle, 'EmiteLeituraMF; 
 DataFinal=#" + DataFim + "# DataInicial=#' + DataIni + '# Destino=\"S\" LeituraSimplificada=false'); 
          if (retornoImpressoraErro(vModeloEcf, result)) return;
          vDsLinha = DLLG2_ObtemRetornos(Handle, vDsLinha, 0); 
          vDsLinha = fRetornaValor(vDsLinha, "TextoImpressao",'\"'); 
          vDsConteudo = vDsConteudo + vDsLinha; 
        until (vDsLinha == '); 
{
 textfile f ;
{
= getpathecf( uivo ;
  + "retorno.txt"
{
= getpathecf( uivo ;
  + 'retorno.txt'
        GravarArqBin(vArquivo, vDsConteudo);
      end else  if ((vModeloEcf == "ecfDaruma")) {         if (( Tipo.ToLower() == 's'))         regAlterarValor_Daruma('ECF\\LMFCOMPLETA','0') 
      else
         regAlterarValor_Daruma("ECF\\LMFCOMPLETA",'1'); 
        result = iMFLerSerial_ECF_Daruma(DataIni, DataFim); 
      end; else  if ((vModeloEcf == "ecfSweda")) {        result = ECF_LeituraMemoriaFiscalSerialDataMFD(PChar(DataIni), PChar(DataFim), PChar(Tipo)); 
      end; else  if ((vModeloEcf == "ecfEpson")) {        Set  10000.Length ; 
        vTamanhoBuffer = 0; 
        result = EPSON_RelatorioFiscal_Leitura_MF(PChar(DataIni), PChar(DataFim), 7, PChar(vDados), ', @vTamanhoBuffer, 10000); 
    }
   except     on E : Exception) ShowMessage(E.Message);
  }
}
}

//--------------------------------------------
 public int leituraMemoriaFiscalPorReducoes( string vModeloEcf , string  RedIni , string  RedFim ) 
{
  string vdados;
   string vdsresult  ;
    vTamanhoBuffer, i : int;
{
    try      if ((vModeloEcf == "ecfBematech") | (vModeloEcf == 'ecfYanco')) {        result = Bematech_FI_LeituraMemoriaFiscalReducao(PChar(RedIni), PChar(RedFim)); 
      end; else  if ((vModeloEcf == "ecfElgin")) {        result = Elgin_LeituraMemoriaFiscalReducao(RedIni, RedFim, 's'); 
 Destino=\"I\";
 LeituraSimplificada=true;
 ReducaoFinal=" + RedFim + "; 
 ReducaoInicial=' + RedIni);
      end; else if(vModeloEcf == "ecfUrano")) {  //Zottis 14/03/2014       result = DLLG2_ExecutaComando(Handle, 'EmiteLeituraMF;
 //Zottis 14/03/2014       result = DLLG2_ExecutaComando(Handle, 'EmiteLeituraMF;
 //Zottis 14/03/2014       result := DLLG2_ExecutaComando(Handle, 'EmiteLeituraMF;
 Destino=\"I\" LeituraSimplificada=false ReducaoFinal=" + RedFim + " ReducaoInicial=' + RedIni); 
      end; else  if ((vModeloEcf == "ecfDaruma")) {        regAlterarValor_Daruma('ECF\\LMFCompleta','0'); 
      end; else  if ((vModeloEcf == "ecfSweda")) {        result = ECF_LeituraMemoriaFiscalReducao(PChar(RedIni), PChar(RedFim)); 
      end; else  if ((vModeloEcf == "ecfEpson")) {        Set  10000.Length ; 
        vTamanhoBuffer = 0; 
        result = EPSON_RelatorioFiscal_Leitura_MF(PChar(RedIni), PChar(RedFim), 4, PChar(vDados), ', @vTamanhoBuffer, 10000); 
    }
   except     on E : Exception) ShowMessage(E.Message);
  }
}
}

//--------------------------------------------
 public int leituraMemoriaFiscalPorReducoesMFD( string vModeloEcf , string  RedIni , string  RedFim , string  Tipo ) 
{
  string vdados;
   string  vdsresult ;
    vTamanhoBuffer,i  : int;
{
    try      if ((vModeloEcf == "ecfBematech") | (vModeloEcf == 'ecfYanco')) {        result = Bematech_FI_LeituraMemoriaFiscalReducaoMFD(PChar(RedIni), PChar(RedFim), PChar(Tipo)); 
      end; else  if ((vModeloEcf == "ecfElgin")) {       end; else  if ((vModeloEcf == 'ecfInterway')) {         if (( Tipo.ToLower() == 's'))         result = DLLG2_ExecutaComando(Handle, 'EmiteLeituraMF; 
 Destino=\"I\";
 LeituraSimplificada=true;
 ReducaoFinal=" + RedFim + "; 
 ReducaoInicial=' + RedIni)
      else
         result = DLLG2_ExecutaComando(Handle, 'EmiteLeituraMF; 
 Destino=\"I\";
 LeituraSimplificada=false;
 ReducaoFinal=" + RedFim + "; 
 ReducaoInicial=' + RedIni);
      end; else  if ((vModeloEcf == "ecfUrano")) {  //Zottis 14/03/2014        if ((LowerCase(Tipo) == 's'))         result = DLLG2_ExecutaComando(Handle, 'EmiteLeituraMF;
 //Zottis 14/03/2014        if ((LowerCase(Tipo) = 's'))         result = DLLG2_ExecutaComando(Handle, 'EmiteLeituraMF;
 //Zottis 14/03/2014        if ((LowerCase(Tipo) = 's'))         result := DLLG2_ExecutaComando(Handle, 'EmiteLeituraMF;
 Destino=\"I\" LeituraSimplificada=true ReducaoFinal=" + RedFim + " ReducaoInicial=' + RedIni) 
      else
         result = DLLG2_ExecutaComando(Handle, 'EmiteLeituraMF; 
 Destino=\"I\" LeituraSimplificada=false ReducaoFinal=" + RedFim + " ReducaoInicial=' + RedIni); 
      end else  if ((vModeloEcf == "ecfDaruma")) {         if (( Tipo.ToLower() == 's'))         regAlterarValor_Daruma('ECF\\LMFCOMPLETA','0') 
      else
         regAlterarValor_Daruma("ECF\\LMFCOMPLETA",'1'); 
        result = iMFLer_ECF_Daruma(RedIni, RedFim); 
      end; else  if ((vModeloEcf == "ecfSweda")) {        result = ECF_LeituraMemoriaFiscalReducaoMFD(PChar(RedIni), PChar(RedFim), PChar(Tipo)); 
      end; else  if ((vModeloEcf == "ecfEpson")) {        Set  10000.Length ; 
        vTamanhoBuffer = 0; 
         if (( Tipo.ToLower() == "s"))         result = EPSON_RelatorioFiscal_Leitura_MF(PChar(RedIni), PChar(RedFim), 6, PChar(vDados), ', @vTamanhoBuffer, 10000) 
      else
         result = EPSON_RelatorioFiscal_Leitura_MF(PChar(RedIni), PChar(RedFim), 4, PChar(vDados), ', @vTamanhoBuffer, 10000); 
    }
   except     on E : Exception) ShowMessage(E.Message);
  }
}
}

//--------------------------------------------
 public int leituraMemoriaFiscalSerialPorReducoesMFD( string vModeloEcf , string  RedIni , string  RedFim , string  Tipo ) 
{
 textfile f ;
    vDados, vDsResult, vArquivo, vDsConteudo, vDsLinha : string;
    vTamanhoBuffer, i : int;
{
    try      if ((vModeloEcf == "ecfBematech") | (vModeloEcf == 'ecfYanco')) {        result = Bematech_FI_LeituraMemoriaFiscalSerialReducaoMFD(PChar(RedIni), PChar(RedFim), PChar(Tipo)); 
      end; else  if ((vModeloEcf == "ecfElgin")) {       end; else  if ((vModeloEcf == 'ecfInterway')) {         if (( Tipo.ToLower() == 's'))         result = DLLG2_ExecutaComando(Handle, 'EmiteLeituraMF; 
 Destino=\"S\";
 LeituraSimplificada=true;
 ReducaoFinal=" + RedFim + "; 
 ReducaoInicial=' + RedIni)
      else
         result = DLLG2_ExecutaComando(Handle, 'EmiteLeituraMF; 
 Destino=\"S\";
 LeituraSimplificada=false;
 ReducaoFinal=" + RedFim + "; 
 ReducaoInicial=' + RedIni);
          if (retornoImpressoraErro(vModeloEcf, result)) return;
          vDsLinha = DLLG2_ObtemRetornos(Handle, vDsLinha, 0); 
          vDsLinha = fRetornaValor(vDsLinha, "TextoImpressao",'\"'); 
          vDsConteudo = vDsConteudo + vDsLinha; 
        until (vDsLinha == '); 
{
 textfile f ;
{
= getpathecf( uivo ;
  + "retorno.txt"
        GravaIni(vArquivo, vDsConteudo);
      end; else  if ((vModeloEcf == "ecfUrano")) {  //Zottis 14/03/2014        if ((LowerCase(Tipo) == 's'))         result = DLLG2_ExecutaComando(Handle, 'EmiteLeituraMF;
 //Zottis 14/03/2014        if ((LowerCase(Tipo) = 's'))         result = DLLG2_ExecutaComando(Handle, 'EmiteLeituraMF;
 //Zottis 14/03/2014        if ((LowerCase(Tipo) = 's'))         result := DLLG2_ExecutaComando(Handle, 'EmiteLeituraMF;
 Destino=\"S\" LeituraSimplificada=true ReducaoFinal=" + RedFim + " ReducaoInicial=' + RedIni) 
      else
         result = DLLG2_ExecutaComando(Handle, 'EmiteLeituraMF; 
 Destino=\"S\" LeituraSimplificada=false ReducaoFinal=" + RedFim + " ReducaoInicial=' + RedIni); 
          if (retornoImpressoraErro(vModeloEcf, result)) return;
          vDsLinha = DLLG2_ObtemRetornos(Handle, vDsLinha, 0); 
          vDsLinha = fRetornaValor(vDsLinha, "TextoImpressao",'\"'); 
          vDsConteudo = vDsConteudo + vDsLinha; 
        until (vDsLinha == '); 
{
 textfile f ;
{
= getpathecf( uivo ;
  + "retorno.txt"
{
= getpathecf( uivo ;
  + 'retorno.txt'
        GravaIni(vArquivo, vDsConteudo);
      end else  if ((vModeloEcf == "ecfDaruma")) {         if (( Tipo.ToLower() == 's'))         regAlterarValor_Daruma('ECF\\MFDCompleta','0') 
      else
         regAlterarValor_Daruma("ECF\\MFDCompleta",'1'); 
         result = iMFLerSerial_ECF_Daruma(RedIni, RedFim); 
      end; else  if ((vModeloEcf == "ecfSweda")) {        result = ECF_LeituraMemoriaFiscalSerialReducaoMFD(PChar(RedIni), PChar(RedFim), PChar(Tipo)); 
      end; else  if ((vModeloEcf == "ecfEpson")) {        Set  10000.Length ; 
        vTamanhoBuffer = 0; 
         if (( Tipo.ToLower() == "s"))         result = EPSON_RelatorioFiscal_Leitura_MF(PChar(RedIni), PChar(RedFim), 6, PChar(vDados), ', @vTamanhoBuffer, 10000) 
      else
         result = EPSON_RelatorioFiscal_Leitura_MF(PChar(RedIni), PChar(RedFim), 4, PChar(vDados), ', @vTamanhoBuffer, 10000); 
    }
   except     on E : Exception) ShowMessage(E.Message);
  }
}
}

//--------------------------------------------
 public int relatorioTipo60Mestre( string vModeloEcf ) 
{
  string vdsarquivo;
   string  vdsdata;
   string  vdsnumeroserie;
   string  vdsloja ;
    vDsNrUltimaReduz, vDsCOOInicio, vDsCOOReducao, vDsReinicioOperacao : string;
    vDsVlVendaBruta, vDsVlGT, vDadosRZ, vDtUltMovimento, vPathECF, vLastRZData, vDsDadosImpressora : string;
    vVBatual, vVBanterior : string;
    vValor : Currency;
    F : TextFile;
    vDsArq : string[];
    vLinha : string;
    iConta : int;
{
    try      if ((vModeloEcf == "ecfBematech") | (vModeloEcf == 'ecfYanco')) {        result = Bematech_FI_RelatorioTipo60Mestre(); 
      end; else  if ((vModeloEcf == "ecfElgin")) {        result = Elgin_RelatorioTipo60Mestre(); 
      end; else  if ((vModeloEcf == "ecfInterway") | (vModeloEcf == 'ecfUrano')) {        try          // pego a data da ECF         DLLG2_ExecutaComando(Handle, 'LeData;
 // pego a data da ECF         DLLG2_ExecutaComando(Handle, 'LeData;
 NomeData=\"Data\"');
          vDsData = DLLG2_ObtemRetornos(Handle, vDsData, 0); 
          vDsData = fRetornaValor(vDsData, "ValorData",'#'); 
          vDsData = FormatDateTime("DD/MM/YYYY", StrToDate(vDsData)); 
 NomeTexto=\"NumeroSerieECF\"');
          vNrSerie = DLLG2_ObtemRetornos(Handle,vDsNumeroSerie,0 ); 
          vNrSerie = fRetornaValor(vNrSerie, "ValorTexto",'\"'); 
 NomeInteiro=\"Loja\"');
          vDsLoja = DLLG2_ObtemRetornos(Handle, vDsLoja, 0); 
          vDsLoja = fRetornaValor(vDsLoja, "ValorInteiro",'); 
           if ( vDsLoja.Trim() == ") vDsLoja = "0'; 
 NomeInteiro=\"COOInicioDia\"');
          vDsCOOInicio = DLLG2_ObtemRetornos(Handle, vDsCOOInicio, 0); 
          vDsCOOInicio = fRetornaValor(vDsCOOInicio, "ValorInteiro",'); 
           if ( vDsCOOInicio.Trim() == ") vDsCOOInicio = "0'; 
 NomeInteiro=\"CRZ\"');
          vDsNrUltimaReduz = DLLG2_ObtemRetornos(Handle, vDsNrUltimaReduz, 0); 
          vDsNrUltimaReduz = fRetornaValor(vDsNrUltimaReduz, "ValorInteiro",'); 
           if ( vDsNrUltimaReduz.Trim() == ") vDsNrUltimaReduz = "0'; 
 NomeInteiro=\"COOReducao[" + vDsNrUltimaReduz + "]\"'); 
          vDsCOOReducao = DLLG2_ObtemRetornos(Handle, vDsCOOReducao, 0); 
          vDsCOOReducao = fRetornaValor(vDsCOOReducao, "ValorInteiro",'); 
           if ( vDsCOOReducao.Trim() == ") vDsCOOReducao = "0'; 
 NomeInteiro=\"ContadorReinicioReducao[" + vDsNrUltimaReduz + "]\"'); 
          vDsReinicioOperacao = DLLG2_ObtemRetornos(Handle, vDsReinicioOperacao, 0); 
          vDsReinicioOperacao = fRetornaValor(vDsReinicioOperacao, "ValorInteiro",'); 
           if ( vDsReinicioOperacao.Trim() == ") vDsReinicioOperacao = "0'; 
 NomeDadoMonetario=\"VendaBrutaReducao[" + vDsNrUltimaReduz + "]\"'); 
          vDsVlVendaBruta = DLLG2_ObtemRetornos(Handle, vDsVlVendaBruta, 0); 
          vDsVlVendaBruta = fRetornaValor(vDsVlVendaBruta, "ValorMoeda",'); 
          vDsVlVendaBruta = stringReplace(vDsVlVendaBruta, ".",', [rfReplaceAll]); 
           if ( vDsVlVendaBruta.Trim() == ") vDsVlVendaBruta = "0'; 
 NomeDadoMonetario=\"GT\"');
          vDsVlGT = DLLG2_ObtemRetornos(Handle, vDsVlGT, 0); 
          vDsVlGT = fRetornaValor(vDsVlGT, "ValorMoeda",'); 
          vDsVlGT = stringReplace(vDsVlGT, ".",', [rfReplaceAll]); 
           if ( vDsVlGT.Trim() == ") vDsVlGT = "0'; 
           vDsArquivo = '; 
          vDsArquivo =              "Tipo) relatório.........:" + Format('%25s', ['60']) + sLineBreak; 
          vDsArquivo = vDsArquivo + "Subtipo...................:" + Format('%25s', ['M']) + sLineBreak; 
          vDsArquivo = vDsArquivo + "Data de emissão...........:" + Format('%25s', [vDsData]) + sLineBreak; 
          vDsArquivo = vDsArquivo + "Número de série...........:" + Format('%25s', [vNrSerie]) + sLineBreak; 
          vDsArquivo = vDsArquivo + "Número) equipamento.....:" + Format('%25s', [vDsLoja]) + sLineBreak; 
          vDsArquivo = vDsArquivo + "Modelo) documento fiscal:" + Format('%25s', ['2D']) + sLineBreak; 
          vDsArquivo = vDsArquivo + "COO inicial...............:" + Format('%25s', ['0']) + sLineBreak; 
          vDsArquivo = vDsArquivo + "COO final.................:" + Format('%25s', ['0']) + sLineBreak; 
          vDsArquivo = vDsArquivo + "Contador de reduções......:" + Format('%25s', [vDsNrUltimaReduz]) + sLineBreak; 
          vDsArquivo = vDsArquivo + "Reinicio de operações.....:" + Format('%25s', [vDsReinicioOperacao]) + sLineBreak; 
          vDsArquivo = vDsArquivo + "Venda Bruta...............:" + Format('%25s', [FormatFloat(', 0.00', StrToFloatDef(vDsVlVendaBruta, 0))]) + sLineBreak; 
          vDsArquivo = vDsArquivo + "Totalizador geral.........:" + Format('%25s', [FormatFloat(', 0.00', StrToFloatDef(vDsVlGT, 0))]); 
          vDsPath = getPathECF(); 
          AssignFile(F, vDsPath + "\\RETORNO.TXT") ; 
          Rewrite(F);
          Write(F, vDsArquivo);
          CloseFile(F);
        except
      }
     end; else  if ((vModeloEcf == "ecfDaruma")) {        vDadosRZ = '; 
        Set  1210.Length ; 
        result = regAlterarValor_Daruma("START\\LocalArquivosRelatorios",  getPathECF().Substring( 3,   getPathECF().Length )); 
        vDtUltMovimento =  vDadosRZ.Substring( 1,  8); 
         result = rGerarSINTEGRA_ECF_Daruma("DATAM", vDtUltMovimento, vDtUltMovimento); 
          if ((FileExists(getPathECF + "Sintegra.txt"))) {          vPathECF = getPathECF; 
        end; else  if ((FileExists("C:\\Sintegra.txt"))) {          vPathECF =  'C:\\'; 
      }
          vDsArq = new  string[]; 
          vDsArq.LoadFromFile(vPathECF + "Sintegra.txt"); 
          iConta = 1; 
          while (iConta < vDsArq.Count) {            vLinha = vDsArq[iConta]; 
            if( vLinha.Substring( 1,  3) == "60M")) {               //atribuindo valores as variaveis de registro             vDsData = copy(vLinha, 4, 8);
 //atribuindo valores as variaveis de registro             vDsData = copy(vLinha, 4, 8);
 //atribuindo valores as variaveis de registro             vDsData = copy(vLinha, 4, 8);
 //atribuindo valores as variaveis de registro             vDsData := copy(vLinha, 4, 8);
              vDsNumeroSerie =  vLinha.Substring( 12,  20); 
              vDsLoja =  vLinha.Substring( 32,  3); 
              vDsCOOInicio =  vLinha.Substring( 37,  6); 
              vDsCOOReducao =  vLinha.Substring( 43,  6); 
              vDsNrUltimaReduz =  vLinha.Substring( 49,  6); 
              vDsReinicioOperacao =  vLinha.Substring( 55,  3) ; 
              vDsVlVendaBruta =  vLinha.Substring( 58,  16); 
              vDsVlGT =  vLinha.Substring( 74,  16); 
              vDsData =  vDsData.Substring( 7,  2) + "/" +  vDsData.Substring( 5,  2) + '/' +  vDsData.Substring( 3,  2); 
               vDsArquivo = '; 
              vDsArquivo =              "Tipo) relatório.........:" + Format('%25s', ['60']) + sLineBreak; 
              vDsArquivo = vDsArquivo + "Subtipo...................:" + Format('%25s', ['M']) + sLineBreak; 
              vDsArquivo = vDsArquivo + "Data de emissão...........:" + Format('%25s', [vDsData]) + sLineBreak; 
              vDsArquivo = vDsArquivo + "Número de série...........:" + Format('%25s', [vDsNumeroSerie]) + sLineBreak; 
              vDsArquivo = vDsArquivo + "Número) equipamento.....:" + Format('%25s', [vDsLoja]) + sLineBreak; 
              vDsArquivo = vDsArquivo + "Modelo) documento fiscal:" + Format('%25s', ['2D']) + sLineBreak; 
              vDsArquivo = vDsArquivo + "COO inicial...............:" + Format('%25s', [vDsCOOInicio]) + sLineBreak; 
              vDsArquivo = vDsArquivo + "COO final.................:" + Format('%25s', [vDsCOOReducao]) + sLineBreak; 
              vDsArquivo = vDsArquivo + "Contador de reduções......:" + Format('%25s', [vDsNrUltimaReduz]) + sLineBreak; 
              vDsArquivo = vDsArquivo + "Reinicio de operações.....:" + Format('%25s', [vDsReinicioOperacao]) + sLineBreak; 
               vValor = StrToFloatDef(vDsVlVendaBruta, 0); 
              vValor = vValor / 100; 
              vDsArquivo = vDsArquivo + "Venda Bruta...............:" + Format('%25s', [FormatFloat(', 0.00', vValor)]) + sLineBreak; 
              vValor = StrToFloatDef(vDsVlGT, 0); 
              vValor = vValor / 100; 
              vDsArquivo = vDsArquivo + "Totalizador geral.........:" + Format('%25s', [FormatFloat(', 0.00', vValor)]); 
          }
            iConta++; 
        }
          AssignFile(F,  getPathECF() + "RETORNO.TXT") ; 
          Rewrite(F);
          Write(F, vDsArquivo);
          CloseFile(F);
      }
     end; else  if ((vModeloEcf == "ecfSweda")) {        result = ECF_RelatorioTipo60Mestre(); 
      end; else  if ((vModeloEcf == "ecfEpson")) {        vLastRZData = ReplicateStr(' ', 1170); 
        result = EPSON_Obter_Dados_Ultima_RZ(PChar(vLastRZData)); 
         vDsDadosImpressora = ReplicateStr(" ", 110); 
        EPSON_Obter_Dados_Impressora(PChar(vDsDadosImpressora));
        vNrSerie =  vDsDadosImpressora.Substring( 1,  20); 
         vDsDadosImpressora = ReplicateStr(" ", 10); 
        EPSON_Obter_Numero_ECF_Loja(PChar(vDsDadosImpressora));
        vDsLoja =  vDsDadosImpressora.Substring( 1,  3); 
         vVBatual = ReplicateStr(" ", 15); 
         vVBanterior = ReplicateStr(" ", 15); 
         EPSON_Obter_Venda_Bruta(PChar(vVBatual), PChar(vVBanterior));
         vDsData =  vLastRZData.Substring( 1160,  8); 
         if ((vDsData == "????????")) {          vDsData =  vLastRZData.Substring( 1,  8); 
      } 
       vDsData =  vDsData.Substring( 1,  2) + "/" +  vDsData.Substring( 3,  2) + '/' +  vDsData.Substring( 7,  2); 
         vDsNumeroSerie = vNrSerie; 
        vDsCOOInicio =  vLastRZData.Substring( 15,  6); 
        vDsCOOReducao =  vLastRZData.Substring( 21,  6); 
        vDsNrUltimaReduz =  vLastRZData.Substring( 27,  6); 
        vDsReinicioOperacao =  vLastRZData.Substring( 33,  6); 
        vDsVlVendaBruta = vVBanterior; 
        vDsVlGT =  vLastRZData.Substring( 87,  18); 
         vDsArquivo = '; 
        vDsArquivo =              "Tipo) relatório.........:" + Format('%25s', ['60']) + sLineBreak; 
        vDsArquivo = vDsArquivo + "Subtipo...................:" + Format('%25s', ['M']) + sLineBreak; 
        vDsArquivo = vDsArquivo + "Data de emissão...........:" + Format('%25s', [vDsData]) + sLineBreak; 
        vDsArquivo = vDsArquivo + "Número de série...........:" + Format('%25s', [vDsNumeroSerie]) + sLineBreak; 
        vDsArquivo = vDsArquivo + "Número) equipamento.....:" + Format('%25s', [vDsLoja]) + sLineBreak; 
        vDsArquivo = vDsArquivo + "Modelo) documento fiscal : " + Format('%25s', ['2D']) + sLineBreak; 
        vDsArquivo = vDsArquivo + "COO inicial...............:" + Format('%25s', [vDsCOOInicio]) + sLineBreak; 
        vDsArquivo = vDsArquivo + "COO final.................:" + Format('%25s', [vDsCOOReducao]) + sLineBreak; 
        vDsArquivo = vDsArquivo + "Contador de reduções......:" + Format('%25s', [vDsNrUltimaReduz]) + sLineBreak; 
        vDsArquivo = vDsArquivo + "Reinicio de operações.....:" + Format('%25s', [vDsReinicioOperacao]) + sLineBreak; 
        vValor = StrToFloatDef(vDsVlVendaBruta, 0); 
        vValor = vValor / 100; 
        vDsArquivo = vDsArquivo + "Venda Bruta...............:" + Format('%25s', [FormatFloat(', 0.00', vValor)]) + sLineBreak; 
        vValor = StrToFloatDef(vDsVlGT, 0); 
        vValor = vValor / 100; 
        vDsArquivo = vDsArquivo + "Totalizador geral.........:" + Format('%25s', [FormatFloat(', 0.00', vValor)]); 
         AssignFile(F, "C:\\ECF\\RETORNO.TXT") ; 
        Rewrite(F);
        Write(F, vDsArquivo);
        CloseFile(F);
    }
   except     on E : Exception) ShowMessage(E.Message);
  }
}
}

//--------------------------------------------
 public int relatorioTipo60Analitico( string vModeloEcf ) 
{
  string vdsarquivo;
   string  vdsdata;
   string  vdsnumeroserie;
   string  vdsnrultimareduz ;
    vDsVlCancelamentos, vDsVlDescontos : string;
    vDsVlF, vDsVlI, vDsVlN, vDsPercAliquota00, vDsVlAliquota00, vDsPercAliquota01, vDsVlAliquota01 : string;
    vDsPercAliquota02, vDsVlAliquota02, vDsPercAliquota03, vDsVlAliquota03, vDsPercAliquota04, vDsVlAliquota04 : string;
    vDsPercAliquota05, vDsVlAliquota05, vDsPercAliquota06, vDsVlAliquota06, vDsPercAliquota07, vDsVlAliquota07 : string;
    vDsPercAliquota08, vDsVlAliquota08, vDsPercAliquota09, vDsVlAliquota09, vDsPercAliquota10, vDsVlAliquota10 : string;
    vDsPercAliquota11, vDsVlAliquota11, vDsPercAliquota12, vDsVlAliquota12, vDsPercAliquota13, vDsVlAliquota13 : string;
    vDsPercAliquota14, vDsVlAliquota14, vDsPercAliquota15, vDsVlAliquota15 : string;
    vDsTipoAliquota, vDsIndiceAliquota, vDsPercAliquota, vDsVlAliquota, vDadosRZ, vDtUltMovimento, vLinha, vPathECF : string;
    vLastRZData, vDsDadosImpressora : string;
    i, vCont, vPosTributo, vPosVlTributo : int;
    vValor : Currency;
    F, vArqSintegra : TextFile;
{
    try      if ((vModeloEcf == "ecfBematech") | (vModeloEcf == 'ecfYanco')) {        result = Bematech_FI_RelatorioTipo60Analitico(); 
      end; else  if ((vModeloEcf == "ecfElgin")) {        result = Elgin_RelatorioTipo60Analitico; 
      end; else  if ((vModeloEcf == "ecfInterway") | (vModeloEcf == 'ecfUrano')) {        try          // pego a data da ECF         DLLG2_ExecutaComando(Handle, 'LeData;
 // pego a data da ECF         DLLG2_ExecutaComando(Handle, 'LeData;
 NomeData=\"Data\"');
          vDsData = DLLG2_ObtemRetornos(Handle, vDsData, 0); 
          vDsData = fRetornaValor(vDsData, "ValorData",'#'); 
          vDsData = FormatDateTime("DD/MM/YY", StrToDate(vDsData)); 
 NomeTexto=\"NumeroSerieECF\"');
          vDsNumeroSerie = DLLG2_ObtemRetornos(Handle, vDsNumeroSerie, 0); 
          vDsNumeroSerie = fRetornaValor(vDsNumeroSerie, "ValorTexto",'\"'); 
 NomeInteiro=\"CRZ\"');
          vDsNrUltimaReduz = DLLG2_ObtemRetornos(Handle, vDsNrUltimaReduz, 0); 
          vDsNrUltimaReduz = fRetornaValor(vDsNrUltimaReduz, "ValorInteiro",'); 
           if ( vDsNrUltimaReduz.Trim() == ") vDsNrUltimaReduz = "0'; 
 NomeDadoMonetario=\"CancelamentosICMSReducao[" + vDsNrUltimaReduz + "]\"'); 
          vDsVlCancelamentos = DLLG2_ObtemRetornos(Handle, vDsVlCancelamentos, 0); 
          vDsVlCancelamentos = fRetornaValor(vDsVlCancelamentos, "ValorMoeda",'); 
          vDsVlCancelamentos = stringReplace(vDsVlCancelamentos, ".",', [rfReplaceAll]); 
           if ( vDsVlCancelamentos.Trim() == ") vDsVlCancelamentos = "0'; 
 NomeDadoMonetario=\"DescontosReducao[" + vDsNrUltimaReduz + "]\"'); 
          vDsVlDescontos = DLLG2_ObtemRetornos(Handle, vDsVlDescontos, 0); 
          vDsVlDescontos = fRetornaValor(vDsVlDescontos, "ValorMoeda",'); 
          vDsVlDescontos = stringReplace(vDsVlDescontos, ".",', [rfReplaceAll]); 
           if ( vDsVlDescontos.Trim() == ") vDsVlDescontos = "0'; 
 NomeDadoMonetario=\"TotalAliquotaF1Reducao[" + vDsNrUltimaReduz + "]\"'); 
          vDsVlF = DLLG2_ObtemRetornos(Handle, vDsVlF, 0); 
          vDsVlF = fRetornaValor(vDsVlF, "ValorMoeda",'); 
          vDsVlF = stringReplace(vDsVlF, ".",', [rfReplaceAll]); 
           if ( vDsVlF.Trim() == ") vDsVlF = "0'; 
 NomeDadoMonetario=\"TotalAliquotaI1Reducao[" + vDsNrUltimaReduz + "]\"'); 
          vDsVlI = DLLG2_ObtemRetornos(Handle, vDsVlI, 0); 
          vDsVlI = fRetornaValor(vDsVlI, "ValorMoeda",'); 
          vDsVlI = stringReplace(vDsVlI, ".",', [rfReplaceAll]); 
           if ( vDsVlI.Trim() == ") vDsVlI = "0'; 
 NomeDadoMonetario=\"TotalAliquotaN1Reducao[" + vDsNrUltimaReduz + "]\"'); 
          vDsVlN = DLLG2_ObtemRetornos(Handle, vDsVlN, 0); 
          vDsVlN = fRetornaValor(vDsVlN, "ValorMoeda",'); 
          vDsVlN = stringReplace(vDsVlN, ".",', [rfReplaceAll]); 
           if ( vDsVlN.Trim() == ") vDsVlN = "0'; 
           vDsArquivo = '; 
          vDsArquivo =              "Tipo) relatório.........:" + Format('%25s', ['60']) + sLineBreak; 
          vDsArquivo = vDsArquivo + "Subtipo...................:" + Format('%25s', ['A']) + sLineBreak; 
          vDsArquivo = vDsArquivo + "Data de emissão...........:" + Format('%25s', [vDsData]) + sLineBreak; 
          vDsArquivo = vDsArquivo + "Número de série...........:" + Format('%25s', [vDsNumeroSerie]) + sLineBreak; 
          vDsArquivo = vDsArquivo + "Cancelamentos.............:" + Format('%25s', [FormatFloat(', 0.00', StrToFloatDef(vDsVlCancelamentos, 0))]) + sLineBreak; 
          vDsArquivo = vDsArquivo + "Descontos.................:" + Format('%25s', [FormatFloat(', 0.00', StrToFloatDef(vDsVlDescontos, 0))]) + sLineBreak; 
          vDsArquivo = vDsArquivo + "F.........................:" + Format('%25s', [FormatFloat(', 0.00', StrToFloatDef(vDsVlF, 0))]) + sLineBreak; 
          vDsArquivo = vDsArquivo + "I.........................:" + Format('%25s', [FormatFloat(', 0.00', StrToFloatDef(vDsVlI, 0))]) + sLineBreak; 
          vDsArquivo = vDsArquivo + "N.........................:" + Format('%25s', [FormatFloat(', 0.00', StrToFloatDef(vDsVlN, 0))]) + sLineBreak; 
for ( i ==  0;  i <=  15) {;  i++)
 // Verifico se a aliquota i é) tipo ICMS           vDsIndiceAliquota = FormatFloat('00', i);
 // Verifico se a aliquota i é) tipo ICMS           vDsIndiceAliquota = FormatFloat('00', i);
 // Verifico se a aliquota i é) tipo ICMS           vDsIndiceAliquota := FormatFloat('00', i);
            DLLG2_ExecutaComando(Handle, 'LeIndicador;
 NomeIndicador=\"Aliquota" + vDsIndiceAliquota + "ICMSReducao[' + vDsNrUltimaReduz + ']\"'); 
            vDsTipoAliquota = DLLG2_ObtemRetornos(Handle, vDsTipoAliquota, 0); 
            vDsTipoAliquota = fRetornaValor(vDsTipoAliquota, "ValorTextoIndicador",'\"'); 
             if ( vDsTipoAliquota.Trim() == "1") {   // se a aliquota for de ICMS             // Pego o percentual da aliquota atual             DLLG2_ExecutaComando(Handle, 'LeMoeda;
 // se a aliquota for de ICMS             // Pego o percentual da aliquota atual             DLLG2_ExecutaComando(Handle, 'LeMoeda;
 // se a aliquota for de ICMS             // Pego o percentual da aliquota atual             DLLG2_ExecutaComando(Handle, 'LeMoeda;
 NomeDadoMonetario=\"Aliquota" + vDsIndiceAliquota + "Reducao[' + vDsNrUltimaReduz + ']\"'); 
              vDsPercAliquota = DLLG2_ObtemRetornos(Handle, vDsPercAliquota, 0); 
              vDsPercAliquota = fRetornaValor(vDsPercAliquota, "ValorMoeda",'); 
              vDsPercAliquota = FormatFloat(", 00.00", StrToFloatDef(vDsPercAliquota, 0)); 
              vDsPercAliquota = stringReplace(vDsPercAliquota, ",",', [rfReplaceAll]); 
 NomeDadoMonetario=\"TotalAliquota" + vDsIndiceAliquota + "Reducao[' + vDsNrUltimaReduz + ']\"'); 
              vDsVlAliquota = DLLG2_ObtemRetornos(Handle, vDsVlAliquota, 0); 
              vDsVlAliquota = fRetornaValor(vDsVlAliquota, "ValorMoeda",'); 
               vDsArquivo = vDsArquivo + vDsPercAliquota + "......................:" + Format('%25s', [FormatFloat(', 0.00', StrToFloatDef(vDsVlAliquota, 0))]) + sLineBreak; 
          } 
        } 
          DLLG2_ExecutaComando(Handle, 'LeMoeda;
 NomeDadoMonetario=\"TotalAliquotaNS1Reducao[" + vDsNrUltimaReduz + "]\"'); 
          vDsVlAliquota = DLLG2_ObtemRetornos(Handle, vDsVlAliquota, 0); 
          vDsVlAliquota = fRetornaValor(vDsVlAliquota, "ValorMoeda",'); 
           vDsArquivo = vDsArquivo + "ISS.......................:" + Format('%25s', [FormatFloat(', 0.00', StrToFloatDef(vDsVlAliquota, 0))]); 
           AssignFile(F, "C:\\ECF\\RETORNO.TXT") ; 
          Rewrite(F);
          Write(F, vDsArquivo);
          CloseFile(F);
        except
      } 
     end; else  if ((vModeloEcf == "ecfDaruma")) {        vCont = 0; 
         result = regAlterarValor_Daruma("START\\LocalArquivosRelatorios",  getPathECF().Substring( 3,   getPathECF().Length )); 
        rRetornarDadosReducaoZ_ECF_Daruma(vDadosRZ);
        vDtUltMovimento =  vDadosRZ.Substring( 1,  8); 
          if ((FileExists(getPathECF + "Sintegra.txt"))) {          vPathECF = getPathECF; 
        end; else  if ((FileExists("C:\\" + 'Sintegra.txt'))) {          vPathECF =  'C:\\'; 
      } 
        if(FileExists(vPathECF + "Sintegra.txt"))) {          AssignFile(vArqSintegra, vPathECF + 'Sintegra.txt'); 
          Reset(vArqSintegra);
          while (!eof(vArqSintegra)) {            readln(vArqSintegra, vLinha);
            if( vLinha.Substring( 1,  3) == "60A")) {               vCont++; 
              vDsNumeroSerie =  vLinha.Substring( 12,  20); 
              vDsPercAliquota =  vLinha.Substring( 32,  4); 
              vDsVlAliquota =  vLinha.Substring( 36,  12); 
              vDsData =  vDsData.Substring( 7,  2) + "/" +  vDsData.Substring( 5,  2) + '/' +  vDsData.Substring( 3,  2); 
               if ((vCont == 1)) {                vDsArquivo = '; 
                vDsArquivo =              "Tipo) relatório.........:" + Format('%25s', ['60'])           + sLineBreak; 
                vDsArquivo = vDsArquivo + "Subtipo...................:" + Format('%25s', ['A'])            + sLineBreak; 
                vDsArquivo = vDsArquivo + "Data de emissão...........:" + Format('%25s', [vDsData])        + sLineBreak; 
                vDsArquivo = vDsArquivo + "Número de série...........:" + Format('%25s', [vDsNumeroSerie]) + sLineBreak; 
            } 
              vDsVlAliquota =  vDsVlAliquota.Substring( 1,  10) + "," +   vDsVlAliquota.Substring(  vDsVlAliquota.Length  -1,  2); 
              vDsVlAliquota = FormatFloat(", 0.00", StrToFloatDef(PChar(vDsVlAliquota), 0)); 
              vDsArquivo = vDsArquivo + preenchePonto(26, TrimRight(vDsPercAliquota)) + " : " + Format('%25s', [vDsVlAliquota]) + sLineBreak; 
          }
        } 
         AssignFile(F,  getPathECF() + "RETORNO.TXT") ; 
          Rewrite(F);
          Write(F, vDsArquivo);
          CloseFile(F);
           CloseFile(vArqSintegra);
           DeleteFile(vPathECF + "Sintegra.txt"); 
      } 
     end; else  if ((vModeloEcf == "ecfSweda")) {        result = ECF_RelatorioTipo60Analitico(); 
      end; else  if ((vModeloEcf == "ecfEpson")) {        vLastRZData = ReplicateStr(' ', 1170); 
        result = EPSON_Obter_Dados_Ultima_RZ(PChar(vLastRZData)); 
         vDsDadosImpressora = ReplicateStr(" ", 110); 
        EPSON_Obter_Dados_Impressora(PChar(vDsDadosImpressora));
        vNrSerie =  vDsDadosImpressora.Substring( 1,  20); 
         vDsData =  vLastRZData.Substring( 1160,  8); 
         if ((vDsData == "????????"))         vDsData =  vLastRZData.Substring( 1,  8); 
         vDsData =  vDsData.Substring( 1,  2) + "/" +  vDsData.Substring( 3,  2) + '/' +  vDsData.Substring( 7,  2); 
        vDsNumeroSerie = vNrSerie; 
        vDsVlCancelamentos =  vLastRZData.Substring( 105,  17); 
        vDsVlDescontos =  vLastRZData.Substring( 156,  17); 
         vDsArquivo = '; 
        vDsArquivo =              "Tipo) relatório.........:" + Format('%25s', ['60'])           + sLineBreak; 
        vDsArquivo = vDsArquivo + "Subtipo...................:" + Format('%25s', ['A'])            + sLineBreak; 
        vDsArquivo = vDsArquivo + "Data de emissão...........:" + Format('%25s', [vDsData])        + sLineBreak; 
        vDsArquivo = vDsArquivo + "Número de série...........:" + Format('%25s', [vDsNumeroSerie]) + sLineBreak; 
         vPosTributo = 258; 
        vPosVlTributo = 384; 
for ( i ==  1;  i <=  24 ) {          if (( vLastRZData.Substring( vPosTributo,  1) == "T"))          vDsPercAliquota =  vLastRZData.Substring( vPosTributo + 1,  4);  i++)
       else
          vDsPercAliquota =  vLastRZData.Substring( vPosTributo,  5); 
           if ( vDsPercAliquota.Trim() != ') {           vDsVlAliquota =  vLastRZData.Substring( vPosVlTributo,  17); 
           vDsVlAliquota = FloatToStr(StrToCurrDef(vDsVlAliquota, 0) / 100); 
           vDsVlAliquota = FormatFloat(", 0.00", StrToFloatDef(vDsVlAliquota, 0)); 
           vDsArquivo = vDsArquivo + preenchePonto(26, TrimRight(vDsPercAliquota)) + " : " + Format('%25s', [vDsVlAliquota]) + sLineBreak; 
        } 
         vPosTributo = vPosTributo   + 5; 
         vPosVlTributo = vPosVlTributo + 17; 
      } 
        vValor = StrToFloatDef(vDsVlCancelamentos, 0); 
        vValor = vValor / 100; 
        vDsVlCancelamentos = FormatFloat(", 0.00", vValor); 
        vDsArquivo = vDsArquivo + "CANC......................:" + Format('%25s', [vDsVlCancelamentos]) + sLineBreak; 
         vValor = StrToFloatDef(vDsVlDescontos, 0); 
        vValor = vValor / 100; 
        vDsVlDescontos = FormatFloat(", 0.00", vValor); 
        vDsArquivo = vDsArquivo + "DESC......................:" + Format('%25s', [vDsVlDescontos]); 
         AssignFile(F, "C:\\ECF\\RETORNO.TXT") ; 
        Rewrite(F);
        Write(F, vDsArquivo);
        CloseFile(F);
    }
   except     on E : Exception) ShowMessage(E.Message);
  }
}
}

//--------------------------------------------
 public int numeroCupom( string vModeloEcf ) 
{
  string vdsnumerocupom;
   string  vdsretornocf;
   string  vdscontadores ;
    iConta, Tamanho, iNrCupom : int;
{
    try      if ((vModeloEcf == "ecfBematech") | (vModeloEcf == 'ecfYanco')) {        vDsNumeroCupom = ReplicateStr(' ', 6); 
        result = Bematech_FI_NumeroCupom(vDsNumeroCupom); 
        vNrCupom = vDsNumeroCupom; 
      end; else  if ((vModeloEcf == "ecfElgin")) {        vDsNumeroCupom = ReplicateStr(' ', 6); 
        result = Elgin_NumeroCupom(vDsNumeroCupom); 
        vNrCupom = vDsNumeroCupom; 
      end; else  if ((vModeloEcf == "ecfInterway") | (vModeloEcf == 'ecfUrano')) {        Result = DLLG2_ExecutaComando(Handle, 'LeInteiro; 
 NomeInteiro=\"COO\"');
        vNrCupom = DLLG2_ObtemRetornos(Handle, ', 0); 
        vNrCupom = fRetornaValor(vNrCupom, "ValorInteiro",'); 
      end; else  if ((vModeloEcf == "ecfDaruma")) {        Set  6.Length ; 
        result = rRetornarInformacao_ECF_Daruma("26", vDsRetornoCF); 
        vDsNumeroCupom = vDsRetornoCF; 
         if ( vDsNumeroCupom.Trim() != ') {          iNrCupom = StrToIntDef(vDsNumeroCupom, 0); 
          vNrCupom =  iNrCupom.ToString(); 
      }
     end; else  if ((vModeloEcf == "ecfSweda")) {        vDsNumeroCupom = ReplicateStr(' ', 6); 
        result = ECF_NumeroCupom(vDsNumeroCupom); 
        vNrCupom = vDsNumeroCupom; 
      end; else  if ((vModeloEcf == "ecfEpson")) {        vDsContadores = ReplicateStr(' ', 100); 
        Result = EPSON_Obter_Contadores(PChar(vDsContadores)); 
        vDsNumeroCupom =  vDsContadores.Substring( 1,  6); 
        vNrCupom = vDsNumeroCupom; 
    } 
   except     on E : Exception) ShowMessage(E.Message);
  } 
} 
}

//--------------------------------------------
 public int numeroSerie( string vModeloEcf ) 
{
  string vdsnumeroserie;
   string  vdsretorno;
   string  vdsdadosimpressora ;
    iConta : int;
{
     try      if ((vModeloEcf == "ecfBematech") | (vModeloEcf == 'ecfYanco')) {        vDsNumeroSerie = ReplicateStr(' ', 15); 
        result = Bematech_FI_NumeroSerie(vDsNumeroSerie); 
        vNrSerie = vDsNumeroSerie; 
      end; else  if ((vModeloEcf == "ecfElgin")) {        Elgin_FechaPortaSerial; 
        abrePorta(vModeloEcf);
        vDsNumeroSerie = ReplicateStr(" ", 20); 
        result = Elgin_NumeroSerie(vDsNumeroSerie); 
        vNrSerie =  vDsNumeroSerie.Trim(); 
      end; else  if ((vModeloEcf == "ecfInterway") | (vModeloEcf == 'ecfUrano')) {        Result = DLLG2_ExecutaComando(Handle, 'LeTexto; 
 NomeTexto=\"NumeroSerieECF\"');
        vNrSerie = DLLG2_ObtemRetornos(Handle, vDsNumeroSerie, 0); 
        vNrSerie = fRetornaValor(vNrSerie, "ValorTexto",'\"'); 
      end; else  if ((vModeloEcf == "ecfDaruma")) {        Set  20.Length ; 
        Result = rRetornarInformacao_ECF_Daruma("78", vDsRetorno); 
        vNrSerie = vDsRetorno; 
      end; else  if ((vModeloEcf == "ecfSweda")) {        vDsNumeroSerie = ReplicateStr(' ', 15); 
        result = ECF_NumeroSerie(vDsNumeroSerie); 
        vNrSerie = vDsNumeroSerie; 
      end; else  if ((vModeloEcf == "ecfEpson")) {        vDsDadosImpressora = ReplicateStr(' ', 110); 
        Result = EPSON_Obter_Dados_Impressora(PChar(vDsDadosImpressora)); 
        vNrSerie =  vDsDadosImpressora.Substring( 1,  20); 
    }
   except     on E : Exception) ShowMessage(E.Message);
  }
}
}

//--------------------------------------------
 public int numeroSerieMFD( string vModeloEcf ) 
{
  string vdsnumeroserie;
   string  vdsretorno;
   string  vdsdadosimpressora ;
    iConta : int;
{
    try      if ((vModeloEcf == "ecfBematech") | (vModeloEcf == 'ecfYanco')) {        vDsNumeroSerie = ReplicateStr(' ', 20); 
        result = Bematech_FI_NumeroSerieMFD(vDsNumeroSerie); 
        vNrSerie = vDsNumeroSerie; 
      end; else  if ((vModeloEcf == "ecfElgin")) {        vDsNumeroSerie = ReplicateStr(' ', 20); 
        result = Elgin_NumeroSerie(vDsNumeroSerie); 
        vNrSerie = vDsNumeroSerie; 
        vNrSerie =  vDsNumeroSerie.Trim(); 
      end; else  if ((vModeloEcf == "ecfInterway") | (vModeloEcf == 'ecfUrano')) {         if (vNrSerie == ') {          Result = DLLG2_ExecutaComando(Handle, 'LeTexto; 
 NomeTexto=\"NumeroSerieECF\"');
          vNrSerie = DLLG2_ObtemRetornos(Handle, vDsNumeroSerie, 0); 
          vNrSerie = fRetornaValor(vNrSerie, "ValorTexto",'\"'); 
      }
     end; else  if ((vModeloEcf == "ecfDaruma")) {        Set  21.Length ; 
        Result = rRetornarInformacao_ECF_Daruma("78", vDsRetorno); 
        vNrSerie = vDsRetorno; 
      end; else  if ((vModeloEcf == "ecfSweda")) {        vDsNumeroSerie = ReplicateStr(' ', 20); 
        result = ECF_NumeroSerieMFD(vDsNumeroSerie); 
        vNrSerie = vDsNumeroSerie; 
      end; else  if ((vModeloEcf == "ecfEpson")) {        vDsDadosImpressora = ReplicateStr(' ', 110); 
        Result = EPSON_Obter_Dados_Impressora(PChar(vDsDadosImpressora)); 
        vNrSerie =  vDsDadosImpressora.Substring( 1,  20); 
    } 
   except     on E : Exception) ShowMessage(E.Message);
  } 
} 
}

//--------------------------------------------
 public int dataImpressora( string vModeloEcf ) 
{
  string vdsdata;
   string  vdsretorno;
   string  vdsdados ;
    iConta : int;
{
    try      if ((vModeloEcf == "ecfBematech") | (vModeloEcf == 'ecfYanco')) {        vDsData = ReplicateStr(' ', 6); 
        result = Bematech_FI_DataMovimento(vDsData); 
      end; else  if ((vModeloEcf == "ecfElgin")) {        vDsData = ReplicateStr(' ', 6); 
        result = Elgin_DataMovimento(vDsData); 
        vDataHora = vDsData; 
      end; else  if ((vModeloEcf == "ecfInterway") | (vModeloEcf == 'ecfUrano')) {        Result = DLLG2_ExecutaComando(Handle, 'LeData; 
 NomeData=\"Data\"');
        vDataHora = DLLG2_ObtemRetornos(Handle, vDsData, 0); 
        vDataHora = fRetornaValor(vDataHora, "ValorData",'#'); 
      end; else  if ((vModeloEcf == "ecfDaruma")) {        Set  8.Length ; 
        Result = rRetornarInformacao_ECF_Daruma("70", vDsRetorno); 
        vDsData = vDsRetorno; 
      end; else  if ((vModeloEcf == "ecfSweda")) {        vDsData = ReplicateStr(' ', 6); 
        result = ECF_DataMovimento(vDsData); 
      end; else  if ((vModeloEcf == "ecfEpson")) {        Set  15.Length ; 
        Result = EPSON_Obter_Hora_Relogio(PChar(vDsDados)); 
        vDsData =  vDsDados.Substring( 1,  7); 
    } 
   except     on E : Exception) ShowMessage(E.Message);
  }
}
}

//--------------------------------------------
 public int dataHoraGravacaoUsuarioSWBasicoMFAdicional( string vModeloEcf ) 
{
 int iconta ;
    vMFAdicionalAux, Valor : string;
{
    try      if ((vModeloEcf == "ecfBematech") | (vModeloEcf == 'ecfYanco')) {        vDataUsuario = ReplicateStr(' ', 20); 
        vDataSWBasico = ReplicateStr(" ", 20); 
        vMFAdicionalAux = ReplicateStr(" ", 2); 
        result = Bematech_FI_DataHoraGravacaoUsuarioSWBasicoMFAdicional(vDataUsuario, vDataSWBasico, vMFAdicionalAux); 
        vMFAdicional = vMFAdicionalAux; 
      end; else  if ((vModeloEcf == "ecfDaruma")) {        result = -20; 
      end; else  if ((vModeloEcf == "ecfElgin")) {        result = -20; 
      end; else  if ((vModeloEcf == "ecfEpson")) {        result = -20; 
      end; else  if ((vModeloEcf == "ecfInterway") | (vModeloEcf == 'ecfUrano')) {        Result = DLLG2_ExecutaComando(Handle, 'LeTexto; 
 NomeTexto=\"VersaoSW\"');
        vDataSWBasico = DLLG2_ObtemRetornos(Handle, vDataSWBasico, 0); 
        vDataSWBasico = fRetornaValor(vDataSWBasico, "ValorTexto",'\"'); 
      end; else  if ((vModeloEcf == "ecfSweda")) {        result = -20; 
    }
   except     on E : Exception) ShowMessage(E.Message);
  }
}
}

//--------------------------------------------
 public int abreCupomVinculado( string vModeloEcf , string  FormaPagamento , string  Valor , string  NumeroCupom ) 
{
 real vvlvalor ;
    vPosicao : int;
    vCodPagamento,vResult : string;
{
    try     Valor = FormatFloat("0.00", StrToFloatDef(Valor, 0)); 
       if ((vModeloEcf == "ecfBematech") | (vModeloEcf == 'ecfYanco')) {        result = Bematech_FI_abreCupomVinculado(FormaPagamento, Valor, NumeroCupom); 
      end; else  if ((vModeloEcf == "ecfElgin")) {        result = Elgin_abreCupomVinculado(PChar(FormaPagamento), PChar(Valor), PChar(NumeroCupom)); 
      end; else  if ((vModeloEcf == "ecfInterway")) {        vVlValor = StrToFloatDef( Valor.Trim(), 0); 
        vVlValor = vVlValor / 100; 
        Valor = FloatToStr(vVlValor); 
        vCodPagamento = 'AbreCreditoDebito; 
 COO=" + NumeroCupom + " NomeMeioPagamento=\"' + FormaPagamento + '\" Valor=' + Valor; 
        result = DLLG2_ExecutaComando(Handle, 'AbreCreditoDebito; 
 COO=" + NumeroCupom + " NomeMeioPagamento=\"' + FormaPagamento + '\" Valor=' + Valor); 
      end; else  if ((vModeloEcf == "ecfUrano")) {        vVlValor = StrToFloatDef( Valor.Trim(), 0); 
        Valor = FloatToStr(vVlValor); 
        vCodPagamento   = 'AbreCreditoDebito; 
 COO=" + NumeroCupom + " NomeMeioPagamento=\"' + FormaPagamento + '\" Valor=' + Valor; 
        result = DLLG2_ExecutaComando(Handle, 'AbreCreditoDebito; 
 COO=" + NumeroCupom + " NomeMeioPagamento=\"' + FormaPagamento + '\" Valor=' + Valor); 
      end; else  if ((vModeloEcf == "ecfDaruma")) {        result = iCCDAbrirSimplificado_ECF_Daruma(FormaPagamento, '1', NumeroCupom, Valor); 
      end; else  if ((vModeloEcf == "ecfSweda")) {        result = ECF_abreCupomVinculado(FormaPagamento, Valor, NumeroCupom); 
      end; else  if ((vModeloEcf == "ecfEpson")) {        VerificaFormasPagamento('ecfEpson'); 
        vPosicao =    vFormaPGTO.ToLower().IndexOf( FormaPagamento.ToLower()) ; 
        vCodPagamento =  vFormaPGTO.Substring( vPosicao - 2,  2); 
        Valor = ReplaceStr(Valor, ".",'); 
        Valor = ReplaceStr(Valor, ",",'); 
        result = EPSON_NaoFiscal_Abrir_CCD(PChar(vCodPagamento), PChar(Valor), 2, "1"); 
    }
   except     on E : Exception) ShowMessage(E.Message);
  }
}
}

//--------------------------------------------
 public int usaComprovanteNaoFiscalVinculado( string vModeloEcf , string  Texto ) 
{
  int vretorno;
   int  i ;
    vMensagem, vLinha : string;
    vstLista : string[];
{
    try      if ((vModeloEcf == "ecfBematech") | (vModeloEcf == 'ecfYanco')) {        result = Bematech_FI_UsaComprovanteNaoFiscalVinculado(Texto); 
      end; else  if ((vModeloEcf == "ecfElgin")) {        result = Elgin_UsaComprovanteNaoFiscalVinculado(PChar(Texto)); 
      end; else  if ((vModeloEcf == "ecfInterway") | (vModeloEcf == 'ecfUrano')) {        result = DLLG2_ExecutaComando(Handle, 'ImprimeTexto; 
 TextoLivre=\"" + Texto + "\"'); 
      end; else  if ((vModeloEcf == "ecfDaruma")) {        result = iCCDImprimirTexto_ECF_Daruma(Texto); 
      end; else  if ((vModeloEcf == "ecfSweda")) {        result = ECF_UsaComprovanteNaoFiscalVinculado(Texto); 
      end; else  if ((vModeloEcf == "ecfEpson")) {        try         vstLista = new  string[]; 
          vstLista.Text = Texto; 
for ( i ==  0;  i <=  vstLista.Count - 1) {            vLinha = vstLista[i];;  i++)
            result = EPSON_NaoFiscal_Imprimir_Linha(PChar(vLinha)); 
        } 
      } 
    } 
   except     on E : Exception) ShowMessage(E.Message);
  } 
}
}

//--------------------------------------------
 public int fechaRelatorioGerencial( string vModeloEcf ) 
{
 string vdsrespota ;
{
    try      if ((vModeloEcf == "ecfBematech") | (vModeloEcf == 'ecfYanco')) {        result = Bematech_FI_FechaRelatorioGerencial(); 
      end; else  if ((vModeloEcf == "ecfElgin")) {        result = Elgin_FechaRelatorioGerencial(); 
      end; else  if ((vModeloEcf == "ecfInterway") | (vModeloEcf == 'ecfUrano')) {        result = DLLG2_ExecutaComando(Handle,'EncerraDocumento'); 
      end; else  if ((vModeloEcf == "ecfDaruma")) {        result = iRGFechar_ECF_Daruma; 
      end; else  if ((vModeloEcf == "ecfSweda")) {        result = ECF_FechaRelatorioGerencial(); 
      end; else  if ((vModeloEcf == "ecfEpson")) {        result = EPSON_NaoFiscal_Fechar_Relatorio_Gerencial(true); 
    }
   except     on E : Exception) ShowMessage(E.Message);
  }
}
}

//--------------------------------------------
 public int sangria( string vModeloEcf , string  vValor ) 
{
 real vvlvalor ;
    vCodresult : int;
    vResult    : string;
{
    try      if ((vModeloEcf == "ecfBematech") | (vModeloEcf == 'ecfYanco')) {        result = Bematech_FI_Sangria(PChar(vValor)); 
      end; else  if ((vModeloEcf == "ecfElgin")) {        result = Elgin_Sangria(PChar(vValor)); 
      end; else  if ((vModeloEcf == "ecfInterway")) {        vVlValor = StrToFloatDef( vValor.Trim(), 0); 
        vVlValor = vVlValor / 100; 
        vValor = FloatToStr(vVlValor); 
        DLLG2_ExecutaComando(Handle, 'EmiteItemNaoFiscal;
 NomeNaoFiscal=\"Sangria\";
 Valor=' + vValor);
        DLLG2_ExecutaComando(Handle, 'PagaCupom;
 CodMeioPagamento=-2 Valor=' + vValor);
        result = DLLG2_ExecutaComando(Handle, "EncerraDocumento"); 
      end; else  if ((vModeloEcf == "ecfUrano")) {        vVlValor = StrToFloatDef( vValor.Trim(), 0); 
        vValor = FloatToStr(vVlValor); 
        Result = DLLG2_ExecutaComando(Handle, 'EmiteItemNaoFiscal; 
 NomeNaoFiscal=\"Sandria\" Valor=' + vValor);
        result = DLLG2_ExecutaComando(Handle, "EncerraDocumento"); 
      end; else  if ((vModeloEcf == "ecfDaruma")) {        result = iSangria_ECF_Daruma(vValor, '); 
      end; else  if ((vModeloEcf == "ecfSweda")) {        result = ECF_Sangria(PChar(vValor)); 
      end; else  if ((vModeloEcf == "ecfEpson")) {         if ( vValor.Trim()= ')  vValor = '0'; 
        vValor = FormatFloat("0", StrToFloatDef(vValor, 0)); 
        result = EPSON_NaoFiscal_Sangria(PChar(vValor), 2); 
    }
   except     on E : Exception) ShowMessage(E.Message);
  }
}
}

//--------------------------------------------
 public int suprimento( string vModeloEcf , string  vValor ) 
{
 real vvlvalor ;
    vCodresult : int;
    vResult    : string;
{
    try      if ((vModeloEcf == "ecfBematech") | (vModeloEcf == 'ecfYanco')) {        result = Bematech_FI_Suprimento(PChar(vValor), PChar('Dinheiro')); 
      end; else  if ((vModeloEcf == "ecfElgin")) {        result = Elgin_Suprimento(PChar(vValor), PChar('Dinheiro')); 
      end; else  if ((vModeloEcf == "ecfInterway")) {        vVlValor = StrToFloatDef( vValor.Trim(), 0); 
        vVlValor = vVlValor / 100; 
        vValor = FloatToStr(vVlValor); 
        DLLG2_ExecutaComando(Handle, 'EmiteItemNaoFiscal;
 NomeNaoFiscal=\"Suprimento\";
 Valor=' + vValor);
        result = DLLG2_ExecutaComando(Handle, "EncerraDocumento"); 
      end; else  if ((vModeloEcf == "ecfUrano")) {        vVlValor = StrToFloatDef( vValor.Trim(), 0); 
        vValor = FloatToStr(vVlValor); 
        Result = DLLG2_ExecutaComando(Handle, 'EmiteItemNaoFiscal; 
 NomeNaoFiscal=\"Suprimento\" Valor=' + vValor);
        DLLG2_ExecutaComando(Handle, 'PagaCupom;
 CodMeioPagamento=-2 Valor=' + vValor);
        result = DLLG2_ExecutaComando(Handle,"EncerraDocumento"); 
      end; else  if ((vModeloEcf == "ecfDaruma")) {        result = iSuprimento_ECF_Daruma(vValor, '); 
      end; else  if ((vModeloEcf == "ecfSweda")) {        result = ECF_Suprimento(PChar(vValor), PChar('Dinheiro')); 
      end; else  if ((vModeloEcf == "ecfEpson")) {         if ( vValor.Trim()= ') vValor = '0'; 
        vValor = FormatFloat("0", StrToFloatDef(vValor, 0)); 
        result = EPSON_NaoFiscal_Fundo_Troco(PChar(vValor), 2); 
    } 
   except     on E : Exception) ShowMessage(E.Message);
  } 
} 
}

//--------------------------------------------
 public int recebimentoNaoFiscal( string vModeloEcf , string  vIndice , string  vValor , string  vFormaPagamento ) 
{
  string vdscdpagamento;
   string  vdesctotalizador;
   string  vdsinformacao;
   string  vcodpagamento ;
  vVlValor : Real;
    vPosicao : int;
{
    try      if ((vModeloEcf == "ecfBematech") | (vModeloEcf == 'ecfYanco')) {        result = Bematech_FI_RecebimentoNaoFiscal(PChar(vIndice), PChar(vValor), PChar(vFormaPagamento)); 
      end; else  if ((vModeloEcf == "ecfElgin")) {        result = Elgin_RecebimentoNaoFiscal(PChar(vIndice), PChar(vValor), PChar(vFormaPagamento)); 
      end; else  if ((vModeloEcf == "ecfInterway")) {        vDsCdPagamento = '; 
         if (( vFormaPagamento.Trim() == "Dinheiro")) {          vDsCdPagamento = '-2'; 
      }
       vVlValor = StrToFloatDef( vValor.Trim(), 0); 
        vVlValor = vVlValor / 100; 
        vValor = FloatToStr(vVlValor); 
        DLLG2_ExecutaComando(Handle, 'EmiteItemNaoFiscal;
 CodNaoFiscal=" + vIndice + "; 
 Valor=' + vValor);
         if ( vFormaPagamento.Trim()= "Dinheiro")         DLLG2_ExecutaComando(Handle, 'PagaCupom; 
  CodMeioPagamento=-2 Valor=' + vValor)
      else
         DLLG2_ExecutaComando(Handle, 'PagaCupom;
  NomeMeioPagamento=" + "\"' + vFormaPagamento + '\"' + ' Valor=' + vValor); 
        result = DLLG2_ExecutaComando(Handle, "EncerraDocumento"); 
      end; else  if ((vModeloEcf == "ecfUrano")) {        vDsCdPagamento = '; 
         if (( vFormaPagamento.Trim() == "Dinheiro")) {          vDsCdPagamento = '-2'; 
      }
       vVlValor = StrToFloatDef( vValor.Trim(), 0); 
        vValor = FloatToStr(vVlValor); 
        DLLG2_ExecutaComando(Handle, 'EmiteItemNaoFiscal;
 CodNaoFiscal=" + vIndice + " Valor=' + vValor); 
         if ( vFormaPagamento.Trim()= "Dinheiro")         DLLG2_ExecutaComando(Handle, 'PagaCupom; 
 CodMeioPagamento=-2 Valor=' + vValor)
      else
         DLLG2_ExecutaComando(Handle, 'PagaCupom;
 NomeMeioPagamento=" + "\"' + vFormaPagamento + '\"' + ' Valor=' + vValor); 
        result = DLLG2_ExecutaComando(Handle, "EncerraDocumento"); 
      end; else  if ((vModeloEcf == "ecfDaruma")) {        vValor =  vValor.Substring( 4,  11); 
        vIndice =  vIndice.Substring(  vIndice.Length -1,  2); 
        Set  84.Length ; 
         Result = iCNFAbrir_ECF_Daruma(" ",' ',' '); 
        Result = iCNFReceberSemDesc_ECF_Daruma(PChar(vIndice), PChar(vValor)); 
        Result = iCNFTotalizarComprovantePadrao_ECF_Daruma; 
        Result = iCNFEfetuarPagamento_ECF_Daruma(PChar(vFormaPagamento), PChar(vValor), vDsInformacao); 
        Result = iCNFEncerrarPadrao_ECF_Daruma; 
      end; else  if ((vModeloEcf == "ecfSweda")) {        result = ECF_RecebimentoNaoFiscal(PChar(vIndice), PChar(vValor), PChar(vFormaPagamento)); 
      end; else  if ((vModeloEcf == "ecfEpson")) {        VerificaFormasPagamento('ecfEpson'); 
        vPosicao =    vFormaPGTO.ToLower().IndexOf( vFormaPagamento.ToLower()) ; 
        vCodPagamento =  vFormaPGTO.Substring( vPosicao - 2,  2); 
         vValor = ReplaceStr(vValor, ".",'); 
        vValor = ReplaceStr(vValor, ",",'); 
        vValor =  StrToIntDef(vValor 0).ToString(); 
         result = EPSON_NaoFiscal_Abrir_Comprovante(",",',', 0); 
          if ((result == 0)) result = EPSON_NaoFiscal_Vender_Item(PChar(vIndice), PChar(vValor), 2); 
         if ((result == 0)) result = EPSON_NaoFiscal_Pagamento(PChar(vCodPagamento), PChar(vValor), 2, ","); 
         result = EPSON_NaoFiscal_Fechar_Comprovante(True); 
    } 
   except     on E : Exception) ShowMessage(E.Message);
  } 
} 
}

//--------------------------------------------
 public int dataHoraImpressora( string vModeloEcf ) 
{
 int iconta ;
    vData, vHora, vDsDados : string;
{
    try      if ((vModeloEcf == "ecfBematech") | (vModeloEcf == 'ecfYanco')) {        vData = ReplicateStr(' ', 6); 
        vHora = ReplicateStr(" ", 6); 
        result = Bematech_FI_DataHoraImpressora(vData, vHora); 
        vData =  vData.Substring( 1,  2) + "/" +  vData.Substring( 3,  2) + '/' +  vData.Substring( 5,  2); 
        vHora =  vHora.Substring( 1,  2) + ":" +  vHora.Substring( 3,  2) + ':' +  vHora.Substring( 5,  2); 
        vDataHora = vData + " " + vHora; 
      end; else  if ((vModeloEcf == "ecfElgin")) {        vData = ReplicateStr(' ', 6); 
        vHora = ReplicateStr(" ", 6); 
        result = Elgin_DataHoraImpressora(vData, vHora); 
        vData =  vData.Substring( 1,  2) + "/" +  vData.Substring( 3,  2) + '/' +  vData.Substring( 5,  2); 
        vHora =  vHora.Substring( 1,  2) + ":" +  vHora.Substring( 3,  2) + ':' +  vHora.Substring( 5,  2); 
        vDataHora = vData + " " +vHora; 
      end; else  if ((vModeloEcf == "ecfInterway") | (vModeloEcf == 'ecfUrano')) {        DLLG2_ExecutaComando(Handle, 'LeData; 
  NomeData=\"Data\"');
        vData = DLLG2_ObtemRetornos(Handle, vData, 0); 
        vData = fRetornaValor(vData, "ValorData",'#'); 
         result = DLLG2_ExecutaComando(Handle, 'LeHora; 
  NomeHora=\"Hora\"');
        vHora = DLLG2_ObtemRetornos(Handle, vHora, 0); 
        vHora = fRetornaValor(vHora, "ValorHora",'#'); 
         vDataHora = vData + " " + vHora; 
      end; else  if ((vModeloEcf == "ecfDaruma")) {        Set  8.Length ; 
        Set  6.Length ; 
        Result = rDataHoraImpressora_ECF_Daruma(vData, vHora); 
        vData =  vData.Substring( 1,  2) + "/" +  vData.Substring( 3,  2) + '/' +  vData.Substring( 7,  2); 
        vHora =  vHora.Substring( 1,  2) + ":" +  vHora.Substring( 3,  2) + ':' +  vHora.Substring( 5,  2); 
        vDataHora = vData + " " +vHora; 
      end; else  if ((vModeloEcf == "ecfSweda")) {        vData = ReplicateStr(' ', 6); 
        vHora = ReplicateStr(" ", 6); 
        result = ECF_DataHoraImpressora(vData, vHora); 
        vData =  vData.Substring( 1,  2) + "/" +  vData.Substring( 3,  2) + '/' +  vData.Substring( 5,  2); 
        vHora =  vHora.Substring( 1,  2) + ":" +  vHora.Substring( 3,  2) + ':' +  vHora.Substring( 5,  2); 
        vDataHora = vData + " " +vHora; 
      end; else  if ((vModeloEcf == "ecfEpson")) {        Set  15.Length ; 
        Result = EPSON_Obter_Hora_Relogio(PChar(vDsDados)); 
        vData =  vDsDados.Substring( 1,  8); 
        vHora =  vDsDados.Substring( 9,  6); 
        vData =  vData.Substring( 1,  2) + "/" +  vData.Substring( 3,  2) + '/' +  vData.Substring( 5,  4); 
        vHora =  vHora.Substring( 1,  2) + ":" +  vHora.Substring( 3,  2) + ':' +  vHora.Substring( 5,  2); 
        vDataHora = vData + " " + vHora; 
    }
   except     on E : Exception) ShowMessage(E.Message);
  }
    vDataHora = TcFuncaoECF._validaDtImpressora(vDataHora); 
}
}

//--------------------------------------------
 public int autenticacao( string vModeloEcf ) 
{
 string vdstxt ;
{
    try      if ((vModeloEcf == "ecfBematech") | (vModeloEcf == 'ecfYanco')) {        result = Bematech_FI_Autenticacao(); 
      end; else  if ((vModeloEcf == "ecfElgin")) {        result = Elgin_Autenticacao(); 
      end; else  if ((vModeloEcf == "ecfInterway") | (vModeloEcf == 'ecfUrano')) {        result = DLLG2_ExecutaComando(Handle, 'ImprimeAutenticacao; 
 TempoEspera=8');
      end; else  if ((vModeloEcf == "ecfDaruma")) {        Set  48.Length ; 
        Result = iAutenticarDocumento_DUAL_DarumaFramework(vDsTxt, "1",'120'); 
      end; else  if ((vModeloEcf == "ecfSweda")) {        result = ECF_Autenticacao(); 
      end; else  if ((vModeloEcf == "ecfEpson")) {        result = EPSON_Autenticar_Imprimir('); 
    } 
   except     on E : Exception) ShowMessage(E.Message);
  } 
} 
}

//--------------------------------------------
 public int programaHorarioVerao( string vModeloEcf ) 
{
    try      if ((vModeloEcf == "ecfBematech") | (vModeloEcf == 'ecfYanco')) {        result = Bematech_FI_ProgramaHorarioVerao(); 
      end; else  if ((vModeloEcf == "ecfElgin")) {        result = Elgin_ProgramaHorarioVerao(); 
      end; else  if ((vModeloEcf == "ecfInterway") | (vModeloEcf == 'ecfUrano')) {        result = DLLG2_ExecutaComando(Handle, 'AcertaHorarioVerao'); 
      end; else  if ((vModeloEcf == "ecfDaruma")) {        result = confHabilitarHorarioVerao_ECF_Daruma; 
      end; else  if ((vModeloEcf == "ecfSweda")) {        result = ECF_CfgHorarioVerao(PChar('1')); 
      end; else  if ((vModeloEcf == "ecfEpson")) {        result = EPSON_Config_Horario_Verao; 
    } 
   except     on E : Exception) ShowMessage(E.Message);
  } 
} 

//--------------------------------------------
public int dataHoraReducao( string vModeloEcf ) 
{
 int iconta ;
    vData, vHora, vDsIndice, vDsDadosUltZ : string;
{
    try      if ((vModeloEcf == "ecfBematech") | (vModeloEcf == 'ecfYanco')) {        vData = ReplicateStr(' ', 6); 
        vHora = ReplicateStr(" ", 6); 
        result = Bematech_FI_DataHoraReducao(PChar(vData), PChar(vHora)); 
        vDataHoraReducao = vData + " - " +vHora; 
      end; else  if ((vModeloEcf == "ecfElgin")) {        vData = ReplicateStr(' ', 6); 
        vHora = ReplicateStr(" ", 6); 
        result = Elgin_DataHoraReducao(vData, vHora); 
        vDataHoraReducao = vData + " - " +vHora; 
      end; else  if ((vModeloEcf == "ecfInterway") | (vModeloEcf == 'ecfUrano')) {        DLLG2_ExecutaComando(Handle,'LeInteiro; 
 NomeInteiro=\"CRZ\"');
        vDsIndice = DLLG2_ObtemRetornos(Handle,vDsIndice,0 ); 
        DLLG2_ExecutaComando(Handle,'LeData;
 NomeData=\"DataReducao["+vDsIndice+"]\"'); 
        vData  = DLLG2_ObtemRetornos(Handle,vData,0 ); 
        vData  =  vData.Substring(12, 10); 
        result = DLLG2_ExecutaComando(Handle,'LeHora; 
 NomeHora=\"HoraReducao["+vDsIndice+"]\"'); 
        vHora  = DLLG2_ObtemRetornos(Handle,vHora,0 ); 
        vHora  =  vHora.Substring(12, 8); 
        vDataHora = vData + " - " + vHora; 
      end; else  if ((vModeloEcf == "ecfDaruma")) {        Set  14.Length ; 
        result = rRetornarInformacao_ECF_Daruma("154", vDsDadosUltZ); 
        vDataHoraReducao =  vDsDadosUltZ.Substring( 1,  8) + " " +  vDsDadosUltZ.Substring( 9,  6); 
      end; else  if ((vModeloEcf == "ecfSweda")) {        vData = ReplicateStr(' ', 6); 
        vHora = ReplicateStr(" ", 6); 
        result = ECF_DataHoraReducao(PChar(vData), PChar(vHora)); 
        vDataHoraReducao = vData + " - " +vHora; 
      end; else  if ((vModeloEcf == "ecfEpson"))  {         Set  1148.Length ; 
         Result = EPSON_Obter_Dados_Ultima_RZ(PChar(vDsDadosUltZ)); 
         vDataHoraReducao =  vDsDadosUltZ.Substring( 1,  7) + " " +  vDsDadosUltZ.Substring( 8,  6); 
    } 
   except     on E : Exception) ShowMessage(E.Message);
  } 
} 
}

//--------------------------------------------
 public int dataHoraReducaoMFD( string vModeloEcf ) 
{
 int vcont ;
    vDataUltimaReducao : string;
{
    try      if ((vModeloEcf == "ecfBematech") | (vModeloEcf == 'ecfYanco')) {        vDataUltimaReducao = ReplicateStr(' ', 7); 
        result = Bematech_FI_DataMovimentoUltimaReducaoMFD(vDataUltimaReducao); 
        vDataHora =  vDataUltimaReducao.Substring( 1,  2) + "/" +  vDataUltimaReducao.Substring( 3,  2) + '/' +  vDataUltimaReducao.Substring( 5,  2); 
        vDataHora = FormatDateTime("dd/mm/yyyy", StrToDateDef(vDataHora, 0)); 
        vDataHora = vDataHora; 
      end; else  if ((vModeloEcf == "ecfElgin")) {      end; else  if ((vModeloEcf == 'ecfInterway') | (vModeloEcf == 'ecfUrano')) {        Result = dataHoraReducao(vModeloEcf); 
      end else  if ((vModeloEcf == "ecfDaruma")) {      end else  if ((vModeloEcf == 'ecfSweda')) {  
    } 
   except     on E : Exception) ShowMessage(E.Message);
  } 
} 
}

//--------------------------------------------
 public int verificaTotalizadoresNaoFiscais( string vModeloEcf ) 
{
 int iconta ;
    vDsTotalizadorAtual : string;
{
    try      if ((vModeloEcf == "ecfBematech") | (vModeloEcf == 'ecfYanco')) {        vTotalizadoresNaoFiscais = ReplicateStr(' ', 179); 
        result = Bematech_FI_VerificaTotalizadoresNaoFiscais(vTotalizadoresNaoFiscais); 
      end; else  if ((vModeloEcf == "ecfElgin")) {        vTotalizadoresNaoFiscais = ReplicateStr(' ', 179); 
        result = Elgin_VerificaTotalizadoresNaoFiscais(vTotalizadoresNaoFiscais); 
      end; else  if ((vModeloEcf == "ecfInterway") | (vModeloEcf == 'ecfUrano')) {        vTotalizadoresNaoFiscais = '; 
for ( iConta ==  0 ;  iConta <=  15) {;  iConta++)
 // 14 é o limite máximo de totalizadores não fiscais         result = DLLG2_ExecutaComando(Handle, 'LeNaoFiscal;
 // 14 é o limite máximo de totalizadores não fiscais         result = DLLG2_ExecutaComando(Handle, 'LeNaoFiscal;
 // 14 é o limite máximo de totalizadores não fiscais         result := DLLG2_ExecutaComando(Handle, 'LeNaoFiscal;
 CodNaoFiscal=' +  iConta.ToString()); 
          vDsTotalizadorAtual = DLLG2_ObtemRetornos(Handle, vDsTotalizadorAtual, 0); 
           if ((vDsTotalizadorAtual != ")) {            vDsTotalizadorAtual = fRetornaValor(vDsTotalizadorAtual, "NomeNaoFiscal','\"'); 
             if ((vTotalizadoresNaoFiscais == '))             vTotalizadoresNaoFiscais = vDsTotalizadorAtual 
          else
             vTotalizadoresNaoFiscais = vTotalizadoresNaoFiscais + " , " + vDsTotalizadorAtual; 
        }
      }
     end; else  if ((vModeloEcf == "ecfDaruma")) {        Set  300.Length ; 
        result = rLerCNF_ECF_Daruma(vTotalizadoresNaoFiscais); 
      end; else  if ((vModeloEcf == "ecfSweda")) {        result = Captura_Dados_Progamados_Sweda(4, vTotalizadoresNaoFiscais); 
      end; else  if ((vModeloEcf == "ecfEpson")) {        Set  681.Length ; 
        result = EPSON_Obter_Tabela_NaoFiscais(PChar(vTotalizadoresNaoFiscais)); 
    } 
   except     on E : Exception) ShowMessage(E.Message);
  } 
} 
}

//--------------------------------------------
 public int verificaFormasPagamento( string vModeloEcf ) 
{
  int iconta;
   int  vtamanho ;
    vDsPgtoAtual : string;
{
    try      if ((vModeloEcf == "ecfBematech") | (vModeloEcf == 'ecfYanco')) {        vFormaPgto = ReplicateStr(' ', 3016); 
        result = Bematech_FI_VerificaFormasPagamento(vFormaPgto); 
      end; else  if ((vModeloEcf == "ecfElgin")) {        vFormaPgto = ReplicateStr(' ', 3016); 
        result = Elgin_VerificaFormasPagamento(vFormaPgto); 
      end; else  if ((vModeloEcf == "ecfInterway") | (vModeloEcf == 'ecfUrano')) {        vFormaPgto = '; 
        DLLG2_ExecutaComando(Handle, 'LeMeioPagamento;
  CodMeioPagamentoProgram=-2');
        vDsPgtoAtual = DLLG2_ObtemRetornos(Handle, vDsPgtoAtual, 0); 
         if ((vDsPgtoAtual != ")) {          vDsPgtoAtual = fRetornaValor(vDsPgtoAtual, "NomeMeioPagamento','\"'); 
          vFormaPgto = vFormaPgto + "," + vDsPgtoAtual; 
      }
for ( iConta ==  0 ;  iConta <=  15) {;  iConta++)
 // 14 é o limite máximo de totalizadores não fiscais         DLLG2_ExecutaComando(Handle, 'LeMeioPagamento;
 // 14 é o limite máximo de totalizadores não fiscais         DLLG2_ExecutaComando(Handle, 'LeMeioPagamento;
  CodMeioPagamentoProgram=' +  iConta.ToString()); 
          vDsPgtoAtual = DLLG2_ObtemRetornos(Handle, vDsPgtoAtual, 0); 
           if ((vDsPgtoAtual != ")) {            vDsPgtoAtual = fRetornaValor(vDsPgtoAtual, "NomeMeioPagamento','\"'); 
            vFormaPgto = vFormaPgto + "," + vDsPgtoAtual; 
        }
      }
       vFormaPgto = vFormaPgto + ","; 
        result = rLerMeiosPagto_ECF_Daruma(vFormaPGTO); 
        vFormaPGTO =  vFormaPGTO.Trim(); 
        vFormaPGTO = stringReplace(vFormaPGTO, '; 
 ",",', [rfReplaceAll]); 
      end; else  if ((vModeloEcf == "ecfSweda")) {        result = Captura_Dados_Progamados_Sweda(2, vFormaPgto); 
      end; else  if ((vModeloEcf == "ecfEpson")) {        Set  881.Length ; 
        Result = EPSON_Obter_Tabela_Pagamentos(PChar(vFormaPGTO)); 
        vFormaPgto = LimpaFormaPagamento(vModeloEcf, vFormaPgto); 
    } 
   except     on E : Exception) ShowMessage(E.Message);
  } 
} 
}

//--------------------------------------------
 public int retornoAliquotas( string vModeloEcf ) 
{
 int iconta ;
    vDsAliquotaAtual : string;
{
    try      if ((vModeloEcf == "ecfBematech") | (vModeloEcf == 'ecfYanco')) {        vAliquotas = ReplicateStr(' ', 79); 
        result = Bematech_FI_RetornoAliquotas(vAliquotas); 
      end; else  if ((vModeloEcf == "ecfElgin")) {        vAliquotas = ReplicateStr(' ', 79); 
        result = Elgin_RetornoAliquotas(vAliquotas); 
      end; else  if ((vModeloEcf == "ecfInterway") | (vModeloEcf == 'ecfUrano')) {        vAliquotas = '; 
for ( iConta ==  0 ;  iConta <=  16) {          result = DLLG2_ExecutaComando(Handle, 'LeAliquota;;  iConta++)
  CodAliquotaProgramavel=' +  iConta.ToString()); 
          vDsAliquotaAtual = DLLG2_ObtemRetornos(Handle, vDsAliquotaAtual, 0); 
           if ((vDsAliquotaAtual != ")) {            vDsAliquotaAtual = fRetornaValor(vDsAliquotaAtual, "PercentualAliquota','); 
             if ((vAliquotas == '))             vAliquotas = vDsAliquotaAtual 
          else
             vAliquotas = vAliquotas + " , " + vDsAliquotaAtual; 
        }
      }
        result = rLerAliquotas_ECF_Daruma(vAliquotas); 
      end; else  if ((vModeloEcf == "ecfSweda")) {        result = Captura_Dados_Progamados_Sweda(1, vAliquotas); 
      end; else  if ((vModeloEcf == "ecfEpson")) {        vAliquotas = ReplicateStr(' ', 533); 
        Result = EPSON_Obter_Tabela_Aliquotas(PChar(vAliquotas)); 
        vAliquotas = LimpaAliquotas(vModeloEcf, vAliquotas); 
    } 
   except     on E : Exception) ShowMessage(E.Message);
  } 
} 
}

//--------------------------------------------
 public int leituraChequeMFD( string vModeloEcf ) 
{
    try      if ((vModeloEcf == "ecfBematech") | (vModeloEcf == 'ecfYanco')) {        set  36.Length ; 
        result = Bematech_FI_LeituraChequeMFD(vDsCMC7); 
      end; else  if ((vModeloEcf == "ecfElgin")) {        set  36.Length ; 
        result = Elgin_LeituraCheque(vDsCMC7); 
      end; else  if ((vModeloEcf == "ecfInterway") | (vModeloEcf == 'ecfUrano')) {       end; else  if ((vModeloEcf == 'ecfDaruma')) {       end; else  if ((vModeloEcf == 'ecfSweda')) {        set  36.Length ; 
        result = ECF_LeituraChequeMFD(vDsCMC7); 
      end; else  if ((vModeloEcf == "ecfEpson")) {        set  257.Length ; 
        result = EPSON_Cheque_Ler_MICR(PChar(vDsCMC7)); 
    } 
   except     on E : Exception) ShowMessage(E.Message);
  } 
} 

//--------------------------------------------
public int cancelaImpressaoCheque( string vModeloEcf ) 
{
    try      if ((vModeloEcf == "ecfBematech") | (vModeloEcf == 'ecfYanco')) {        result = Bematech_FI_CancelaImpressaoCheque(); 
      end; else  if ((vModeloEcf == "ecfElgin")) {        result = Elgin_CancelaImpressaoCheque(); 
      end; else  if ((vModeloEcf == "ecfInterway") | (vModeloEcf == 'ecfUrano')) {       end; else  if ((vModeloEcf == 'ecfDaruma')) {       end; else  if ((vModeloEcf == 'ecfSweda')) {        result = ECF_CancelaImpressaoCheque(); 
      end; else  if ((vModeloEcf == "ecfEpson")) {        result = EPSON_Cheque_Cancelar_Impressao; 
    } 
   except     on E : Exception) ShowMessage(E.Message);
  } 
} 

//--------------------------------------------
public int verificaStatusCheque( string vModeloEcf ) 
{
 int istatuscheque ;
    vDsStatusCheque : string;
{
    try      if ((vModeloEcf == "ecfBematech") | (vModeloEcf == 'ecfYanco')) {        iStatusCheque = 0; 
        result = Bematech_FI_VerificaStatusCheque(iStatusCheque); 
        vStatusCheque =  iStatusCheque.ToString(); 
      end; else  if ((vModeloEcf == "ecfElgin")) {        iStatusCheque = 0; 
        result = Elgin_VerificaStatusCheque(iStatusCheque); 
        vStatusCheque =  iStatusCheque.ToString(); 
      end; else  if ((vModeloEcf == "ecfInterway") | (vModeloEcf == 'ecfUrano')) {       end; else  if ((vModeloEcf == 'ecfDaruma')) {        Result = rConsultaStatusImpressoraStr_ECF_Daruma(15, vDsStatusCheque); 
        vStatusCheque = vDsStatusCheque; 
      end; else  if ((vModeloEcf == "ecfSweda")) {        iStatusCheque = 0; 
        result = ECF_VerificaStatusCheque(iStatusCheque); 
        vStatusCheque =  iStatusCheque.ToString(); 
    } 
   except     on E : Exception) ShowMessage(E.Message);
  } 
}
}

//--------------------------------------------
 public int imprimeCheque( string vModeloEcf , string  Banco , string  Valor , string  Favorecido , string  Cidade , string  Data , string  Mensagem ) 
{
    try      if ((vModeloEcf == "ecfBematech") | (vModeloEcf == 'ecfYanco')) {        result = Bematech_FI_ImprimeCheque(PChar(Banco), PChar(Valor), PChar(Favorecido), PChar(Cidade), PChar(Data), PChar(Mensagem)); 
      end; else  if ((vModeloEcf == "ecfElgin")) {        result = Elgin_ImprimeCheque(PChar(Banco), PChar(Valor), PChar(Favorecido), PChar(Cidade), PChar(Data), PChar(Mensagem)); 
      end; else  if ((vModeloEcf == "ecfInterway") | (vModeloEcf == 'ecfUrano')) {       end; else  if ((vModeloEcf == 'ecfDaruma')) {        result =  iChequeImprimir_FS2100_Daruma(PChar(Banco), PChar(Cidade), PChar(Data), PChar(Favorecido), ' ', PChar(Valor)); 
      end; else  if ((vModeloEcf == "ecfSweda")) {        result = ECF_ImprimeCheque(PChar(Banco), PChar(Valor), PChar(Favorecido), PChar(Cidade), PChar(Data), PChar(Mensagem)); 
      end; else  if ((vModeloEcf == "ecfEpson")) {        result = EPSON_Cheque_Imprimir('01', PChar(Valor), 2, PChar(Favorecido), PChar(Cidade), PChar(Data), PChar(Mensagem)); 
    } 
   except     on E : Exception) ShowMessage(E.Message);
  } 
}

//--------------------------------------------
public int relatorioGerencial( string vModeloEcf , string  vConteudo ) 
{
 string[] vstlista ;
    i : int;
    vLinha,vResult : string;
{
    try      if ((vModeloEcf == "ecfBematech") | (vModeloEcf == 'ecfYanco')) {        vConteudo = '; 
        vDsResposta = LeituraIndicadores(vModeloEcf); 
         if ((vDsResposta == "Impressora Vendendo") | (vDsResposta == 'Impressora Pagamento')) {          result = Bematech_FI_CancelaCupom(); 
      }
       result = Bematech_FI_RelatorioGerencial(vConteudo); 
      end; else  if ((vModeloEcf == "ecfElgin")) {        result = Elgin_RelatorioGerencial(PChar(vConteudo)); 
      end; else  if ((vModeloEcf == "ecfInterway") | (vModeloEcf == 'ecfUrano')) {         if (( vConteudo.Trim() == 'RELATORIO GERENCIAL'))   // identifica que é para abrir o relatório gerencial         result = DLLG2_ExecutaComando(Handle, 'AbreGerencial;
 // identifica que é para abrir o relatório gerencial         result = DLLG2_ExecutaComando(Handle, 'AbreGerencial;
 // identifica que é para abrir o relatório gerencial         result = DLLG2_ExecutaComando(Handle, 'AbreGerencial;
 // identifica que é para abrir o relatório gerencial         result := DLLG2_ExecutaComando(Handle, 'AbreGerencial;
  NomeGerencial=\"RELATORIO\"")      ; else {          result = DLLG2_ExecutaComando(Handle, "ImprimeTexto; 
 TextoLivre=\"" + vConteudo + "\"'); 
      }
     end; else  if ((vModeloEcf == "ecfDaruma")) {        result = iRGImprimirTexto_ECF_Daruma(vConteudo); 
      end; else  if ((vModeloEcf == "ecfSweda")) {        vConteudo = '; 
        vDsResposta = LeituraIndicadores(vModeloEcf); 
         if ((vDsResposta == "Impressora Vendendo") | (vDsResposta == 'Impressora Pagamento')) {          result = ECF_CancelaCupom(); 
      }
       result = ECF_RelatorioGerencial(vConteudo); 
      end; else  if ((vModeloEcf == "ecfEpson"))  {          if (( vConteudo.Trim()= 'RELATORIO GERENCIAL'))   // identifica que é para abrir o relatório gerencial          result = EPSON_NaoFiscal_Abrir_Relatorio_Gerencial('1')       ; else {           try            vstLista = new  string[]; // identifica que é para abrir o relatório gerencial          result = EPSON_NaoFiscal_Abrir_Relatorio_Gerencial('1')       ; else {           try            vstLista = new  string[] // identifica que é para abrir o relatório gerencial          result = EPSON_NaoFiscal_Abrir_Relatorio_Gerencial('1')       ; else {           try            vstLista = string[].Create;
 // identifica que é para abrir o relatório gerencial          result = EPSON_NaoFiscal_Abrir_Relatorio_Gerencial('1')       ; else {           try            vstLista = string[].Create;
 // identifica que é para abrir o relatório gerencial          result = EPSON_NaoFiscal_Abrir_Relatorio_Gerencial('1')       ; else {           try            vstLista = string[].Create;
 // identifica que é para abrir o relatório gerencial          result := EPSON_NaoFiscal_Abrir_Relatorio_Gerencial('1')       ; else {           try            vstLista := string[].Create;
             vstLista.Text = vConteudo; 
for ( i ==  0;  i <=  vstLista.Count - 1) {               vLinha = vstLista[i];;  i++)
               result = EPSON_NaoFiscal_Imprimir_Linha(PChar(vLinha)); 
           }
         }
       }
    }
   except     on E : Exception) ShowMessage(E.Message);
  }
}
}

//--------------------------------------------
 public int verificaEstadoGaveta( string vModeloEcf ) 
{
    try      if ((vModeloEcf == "ecfBematech") | (vModeloEcf == 'ecfYanco')) {        result = Bematech_FI_VerificaEstadoGaveta(iEstadoGaveta); 
      end; else  if ((vModeloEcf == "ecfElgin")) {        result = Elgin_VerificaEstadoGaveta(iEstadoGaveta); 
      end; else  if ((vModeloEcf == "ecfInterway") | (vModeloEcf == 'ecfUrano')) {        result = DLLG2_ExecutaComando(Handle, 'SensorGaveta'); 
      end; else  if ((vModeloEcf == "ecfDaruma")) {        result = rStatusGaveta_ECF_Daruma(iEstadoGaveta); 
      end; else  if ((vModeloEcf == "ecfSweda")) {        result = ECF_VerificaEstadoGaveta(iEstadoGaveta); 
      end else  if ((vModeloEcf == "ecfEpson")) {         //Result = VERIFICAR AQUI
 //Result = VERIFICAR AQUI
 //Result := VERIFICAR AQUI
    }
   except     on E : Exception) ShowMessage(E.Message);
  } 
} 

//--------------------------------------------
public int abreGaveta( string vModeloEcf ) 
{
    try      if ((vModeloEcf == "ecfBematech") | (vModeloEcf == 'ecfYanco')) {        result = Bematech_FI_AcionaGaveta(); 
      end; else  if ((vModeloEcf == "ecfElgin")) {        result = Elgin_AcionaGaveta(); 
      end; else  if ((vModeloEcf == "ecfInterway") | (vModeloEcf == 'ecfUrano')) {        result = DLLG2_ExecutaComando(Handle, 'AbreGaveta'); 
      end; else  if ((vModeloEcf == "ecfDaruma")) {        result = eAbrirGaveta_ECF_Daruma; 
      end; else  if ((vModeloEcf == "ecfSweda")) {        result = ECF_AcionaGaveta(); 
      end; else  if ((vModeloEcf == "ecfEpson")) {        result = EPSON_Impressora_Abrir_Gaveta; 
    }
   except     on E : Exception) ShowMessage(E.Message);
  }
}

//--------------------------------------------
public int testarPortaSerial( string vModeloEcf , string  vPorta ) 
{
 string vresult ;
{
    try      if ((vModeloEcf == "ecfBematech") | (vModeloEcf == 'ecfYanco')) {        result = Bematech_FI_AbrePortaSerial; 
      end; else  if ((vModeloEcf == "ecfElgin")) {        result = Elgin_AbrePortaSerial(); 
      end; else  if ((vModeloEcf == "ecfInterway") | (vModeloEcf == 'ecfUrano')) {         if (vPorta == ')         vPorta = 'COM1'; 
         Handle = DLLG2_IniciaDriver(PChar(vPorta)); 
        Result = Handle; 
        DLLG2_DefineTimeout(Handle, 50);
      end; else  if ((vModeloEcf == "ecfDaruma")) {        result = eAbrirSerial_Daruma(PChar(vPorta), '9600'); 
      end; else  if ((vModeloEcf == "ecfSweda")) {        result = ECF_AbrePortaSerial; 
      end; else  if ((vModeloEcf == "ecfEpson")) {        result = EPSON_Serial_Abrir_PortaEx; 
    }
   except     on E : Exception) ShowMessage(E.Message);
  }
}
}

//--------------------------------------------
 public int cortarPapel( string vModeloEcf ) 
{
    try      if ((vModeloEcf == "ecfBematech") | (vModeloEcf == 'ecfYanco')) {        result = Bematech_FI_AcionaGuilhotinaMFD(0); 
      end; else  if ((vModeloEcf == "ecfElgin")) {        result = Elgin_AcionaGuilhotinaMFD(1); 
      end; else  if ((vModeloEcf == "ecfInterway") | (vModeloEcf == 'ecfUrano')) {        result = DLLG2_ExecutaComando(Handle, 'CortaPapel; 
  TipoCorte=0');
      end; else  if ((vModeloEcf == "ecfDaruma")) {        result = eAcionarGuilhotina_ECF_Daruma('1'); 
      end; else  if ((vModeloEcf == "ecfSweda")) {        result = ECF_AtivaDesativaCorteProximoMFD(1); 
      end; else  if ((vModeloEcf == "ecfEpson")) {        result = EPSON_Impressora_Cortar_Papel(); 
    }
   except     on E : Exception) ShowMessage(E.Message);
  }
}

//--------------------------------------------
public int avancaLinhaCortarPapel( string vModeloEcf , int  Linhas ) 
{
 int i ;
{
    try      if ((vModeloEcf == "ecfBematech") | (vModeloEcf == 'ecfYanco')) {        result =  Bematech_FI_AvancaPapelAcionaGuilhotinaMFD(Linhas, 0); 
      end; else  if ((vModeloEcf == "ecfElgin")) {       end; else  if ((vModeloEcf == 'ecfInterway') | (vModeloEcf == 'ecfUrano')) {        for I =1 to Linhas) {          result = DLLG2_ExecutaComando(Handle,'AvancaPapel; 
 Avanco=50');
      }
     end; else  if ((vModeloEcf == "ecfDaruma")) {       end; else  if ((vModeloEcf == 'ecfSweda')) {       end; else  if ((vModeloEcf == 'ecfEpson'))  {        EPSON_Impressora_Avancar_Papel(Linhas); 
        result = EPSON_Impressora_Cortar_Papel(); 
    }
   except     on E : Exception) ShowMessage(E.Message);
  }
}
}

//--------------------------------------------
 public int verificaEstadoImpressora( string vModeloEcf ) 
{
  int iack;
   int  ist1;
   int  ist2;
   int  indicadores;
   int  iconta ;
    vDsStatus, Str_Informacao : string;
{
    iAck = 0; 
    iSt1 = 0; 
    iSt2 = 0; 
    try      if ((vModeloEcf == "ecfBematech") | (vModeloEcf == 'ecfYanco')) {        result = Bematech_FI_VerificaEstadoImpressora(iAck, iSt1, iSt2); 
      end; else  if ((vModeloEcf == "ecfElgin")) {        result = Elgin_VerificaEstadoImpressora(iAck, iSt1, iSt2); 
      end; else  if ((vModeloEcf == "ecfInterway") | (vModeloEcf == 'ecfUrano')) {        result = DLLG2_ExecutaComando(0,'LeInteiro; 
 NomeInteiro=\"EstadoGeralECF\"');
         if (retornoImpressoraErro(vModeloEcf, result)) return;
         vDsStatus = DLLG2_ObtemRetornos(Handle, vDsStatus, 0); 
        vDsStatus = fRetornaValor(vDsStatus, "ValorInteiro",'); 
         if ( vDsStatus.Trim() != "0") Begin         Result = STS_ECFCUPOMAB; 
  return;
      }
        Result = 1; 
      end; else  if ((vModeloEcf == "ecfDaruma")) {        set  14.Length ; 
        result = rStatusImpressora_ECF_Daruma(vDsStatus); 
      end; else  if ((vModeloEcf == "ecfSweda")) {        result = ECF_VerificaEstadoImpressora(iAck, iSt1, iSt2); 
      end; else  if ((vModeloEcf == "ecfEpson")) {        Str_Informacao = Str_Informacao + ReplicateStr(' ', 57); 
        EPSON_Obter_Estado_Cupom(PChar(Str_Informacao));
    }
   except     on E : Exception) ShowMessage(E.Message);
  }
}
}

//--------------------------------------------
 public string leituraIndicadores( string vModeloEcf ) 
{
 int indicadores ;
    vNrIndicadores : string;
{
    try      if ((vModeloEcf == "ecfBematech") | (vModeloEcf == 'ecfYanco')) {        Bematech_FI_FlagsFiscais(vFlagFiscal); 
        Result = Descricao_FlagFiscais_Bematech(vFlagFiscal); 
      end; else  if ((vModeloEcf == "ecfElgin")) {        Elgin_LeIndicadores(Indicadores); 
        Result = Elgin_LeIndicadoresDescricao(Indicadores); 
      end; else  if ((vModeloEcf == "ecfInterway") | (vModeloEcf == 'ecfUrano')) {        DLLG2_ExecutaComando(Handle, 'LeInteiro; 
  NomeInteiro=\"Indicadores\"');
        vNrIndicadores = DLLG2_ObtemRetornos(Handle, vNrIndicadores, 10); 
        Indicadores = itemI("ValorInteiro", vNrIndicadores); 
        putitemXml(Result, "NR_INDICADORES", Indicadores); 
      end; else  if ((vModeloEcf == "ecfDaruma")) {       end; else  if ((vModeloEcf == 'ecfSweda')) {        ECF_FlagsFiscais(vFlagFiscal); 
        Result = ECF_FlagsFiscaisDescricao(vFlagFiscal); 
    }
   except     on E : Exception) ShowMessage(E.Message);
  }
}
{
 int indicadores ;
{
t   cds_method == "t_ecfsvco011._retornoimpressora("
{
 int indicadores ;
{
t   cds_method == "t_ecfsvco011._retornoimpressora("
{
  string vretorno;
   string  vdetalhe;
   string  vdsretorno;
   string  vdsaviso;
   string  vmsgnumerro ;
    vNumErro, vNumAviso : int;
    vStatus : Variant;
{
    Result = '; 
     try      if ((vModeloEcf == "ecfBematech") | (vModeloEcf == 'ecfYanco')) {         // retorno igual a UM foi executado com sucesso       // diferente de UM verificar tabela de erro       vRetorno = Analisa_Retorno_Bematech(Retorno);
 // retorno igual a UM foi executado com sucesso       // diferente de UM verificar tabela de erro       vRetorno = Analisa_Retorno_Bematech(Retorno);
 // retorno igual a UM foi executado com sucesso       // diferente de UM verificar tabela de erro       vRetorno := Analisa_Retorno_Bematech(Retorno);
          return(STS_ERROR_ECF);
  exit;
        end; else  if ((vStatus == STS_ERROR)) {          Result = SetStatus(STS_ERROR_ECF, "BEMA(" +  iRetorno.ToString() + ')', vDetalhe, cDS_METHOD); 
          return(STS_ERROR_ECF);
  exit;
        end; else  if ((vStatus == STS_POUCO_PAPEL)) {          MensagemBal("Pouco papel", 25); 
      }
        vNumAviso = 0; 
        vMsgNumErro = stringOFChar(" ", 300); 
        vDsAviso = stringOFChar(" ", 300); 
        vDsRetorno = stringOFChar(" ", 300); 
          if ((  vDsRetorno.IndexOf("Alíquota (Situação tributária) não programada")   > 0)) {          vMsgNumErro =  vDsRetorno.Trim(); 
          vNumErro = -1; 
      }
         if ((vNumErro <= 0) & ( vMsgNumErro.Trim() != "Sem Erro")) {          Result = SetStatus(STS_ERROR_ECF, 'DARUMA(' +  vNumErro.ToString() + ')', Trim(vMsgNumErro), cDS_METHOD); 
          return(STS_ERROR_ECF);
  exit;
      }
         if ((vRetorno != ")) {          Result = SetStatus(STS_ERROR_ECF, "ELGIN(' +  iRetorno.ToString() + ')', vRetorno + iff(vRetorno!=',' / ') + vDetalhe, cDS_METHOD); 
          return(STS_ERROR_ECF);
  exit;
        end; else  if ((vStatus == STS_ERROR)) {          Result = SetStatus(STS_ERROR_ECF, "ELGIN(" +  iRetorno.ToString() + ')', vDetalhe, cDS_METHOD); 
          return(STS_ERROR_ECF);
  exit;
        end; else  if ((vStatus == STS_POUCO_PAPEL)) {          MensagemBal("Pouco papel", 25); 
      }
      end; else  if ((vModeloEcf == "ecfEpson")) {         // retorno igual a ZERO foi executado com sucesso       // diferente de ZERO verificar tabela de erro       result = atualizaRetornoEpson(Retorno);
 // retorno igual a ZERO foi executado com sucesso       // diferente de ZERO verificar tabela de erro       result = atualizaRetornoEpson(Retorno);
 // retorno igual a ZERO foi executado com sucesso       // diferente de ZERO verificar tabela de erro       result := atualizaRetornoEpson(Retorno);
         if ((Retorno != 0) & (Result != ")) {          Result = SetStatus(STS_ERROR_ECF, "EPSON(' +  Retorno.ToString() + ')', Result, cDS_METHOD); 
          return(STS_ERROR_ECF);
  exit;
      }
          return(STS_ERROR_ECF);
  exit;
      }
         if ((retorno != 0) & (retorno != 9999)) {          vNumErro = DLLG2_ObtemCodErro(Handle); 
           if ( (vNumErro != 0)) {            vRetorno = TrataErroUrano(vNumErro); 
             if ((vRetorno != ")) {              Result = SetStatus(STS_ERROR_ECF, "URANO(' +  vNumErro.ToString() + ')', vRetorno, cDS_METHOD); 
              return(STS_ERROR_ECF);
  exit;
            end; else  if ((vStatus == STS_POUCO_PAPEL)) {              MensagemBal("Pouco papel", 25); 
          }
        }
      }
      end; else  if ((vModeloEcf == "ecfSweda")) {         // retorno igual a UM foi executado com sucesso       // diferente de UM verificar tabela de erro       result = Analisa_Retorno_Sweda(Retorno);
 // retorno igual a UM foi executado com sucesso       // diferente de UM verificar tabela de erro       result = Analisa_Retorno_Sweda(Retorno);
 // retorno igual a UM foi executado com sucesso       // diferente de UM verificar tabela de erro       result := Analisa_Retorno_Sweda(Retorno);
         if ((Retorno <= 0) & (Result != ")) {          Result = SetStatus(STS_ERROR_ECF, "SWEDA(' +  Retorno.ToString() + ')', Result, cDS_METHOD); 
          return(STS_ERROR_ECF);
  exit;
      }
    }
    except     on E : Exception) ShowMessage(E.Message);
  }
    Result = SetStatus(STS_EXEC); 
    return(STS_EXEC);
  exit;
}
}

//--------------------------------------------
 public Boolean retornoImpressoraErro( string vModeloEcf , int  Retorno ) 
{
    Result = (retornoImpressora(vModeloEcf, Retorno) != '); 
}

//--------------------------------------------
public int downloadMFD( string vModeloEcf , string  vArquivo , string  vTipoDownload , string  vCOOInicial , string  vCOOFinal , string  vUsuario ) 
{
 textfile f ;
    vInVazio : int;
    vDsLinha, vDsConteudo, vArquivoSaida : string;
{
    try      if ((vModeloEcf == "ecfBematech") | (vModeloEcf == 'ecfYanco')) {        result = Bematech_FI_DownloadMFD(vArquivo, vTipoDownload, vCOOInicial, vCOOFinal, vUsuario); 
      end; else  if ((vModeloEcf == "ecfElgin")) {        result = Elgin_DownloadMFD(vArquivo, vTipoDownload, vCOOInicial, vCOOFinal, vUsuario)     end; else  if ((vModeloEcf == 'ecfInterway')) {        iRetorno =  DLLG2_ExecutaComando(Handle, 'EmiteLeituraFitaDetalhe; 
  DataFinal=#" + vCOOFinal + "# DataInicial=#' + vCOOInicial + '# Destino=\"S\"'); 
          vDsLinha = DLLG2_ObtemRetornos(Handle, vDsLinha, 0); 
          vDsLinha = fRetornaValor(vDsLinha, "TextoImpressao",'\"'); 
          vDsConteudo = vDsConteudo + vDsLinha; 
        until (vDsLinha == '); 
        GravaIni(vArquivo, vDsConteudo);
      end; else  if ((vModeloEcf == "ecfUrano")) {        iRetorno =  DLLG2_ExecutaComando(Handle, 'EmiteLeituraFitaDetalhe; 
  DataFinal=#" + vCOOFinal + "# DataInicial=#' + vCOOInicial + '# Destino=\"S\"'); 
          vDsLinha = DLLG2_ObtemRetornos(Handle, vDsLinha, 0); 
          vDsLinha = fRetornaValor(vDsLinha, "TextoImpressao",'\"'); 
          vDsConteudo = vDsConteudo + vDsLinha; 
        until (vDsLinha == '); 
        GravaIni(vArquivo, vDsConteudo);
      end; else  if ((vModeloEcf == "ecfDaruma")) {         if ((vTipoDownload == '1'))  {          vCOOInicial =  vCOOInicial.Substring( 1,  4) + '20' +  vCOOInicial.Substring( 5,  2); 
          vCOOFinal =  vCOOFinal.Substring( 1,  4) + "20" +  vCOOFinal.Substring( 5,  2); 
           Result = rEfetuarDownloadMFD_ECF_Daruma("DATAM", vCOOInicial, vCOOFinal, 'Daruma.mfd'); 
        end; else  if ((vTipoDownload == "2")) {          Result = rEfetuarDownloadMFD_ECF_Daruma('COO', vCOOInicial, vCOOFinal, 'Daruma.mfd'); 
      }
     end; else  if ((vModeloEcf == "ecfSweda")) {        result = ECF_DownloadMFD(vArquivo, vTipoDownload, vCOOInicial, vCOOFinal, vUsuario); 
      end; else  if ((vModeloEcf == "ecfEpson")) {         if ((vTipoDownload == '1')) {          vCOOInicial =  vCOOInicial.Substring( 1,  4) + '20' +  vCOOInicial.Substring( 5,  2); 
          vCOOFinal =  vCOOFinal.Substring( 1,  4) + "20" +  vCOOFinal.Substring( 5,  2); 
           result = EPSON_Obter_Dados_MF_MFD(PChar(vCOOInicial), PChar(vCOOFinal), 0, 255, 0, 0, "C:\\ECF\\DOWNLOADMFD")       end; else  if ((vTipoDownload == '2')) {          vCOOInicial = zerosstring(6,  vCOOInicial.Trim(), false); 
          vCOOFinal = zerosstring(6,  vCOOFinal.Trim(), false); 
           result = EPSON_Obter_Dados_MF_MFD(PChar(vCOOInicial), PChar(vCOOFinal), 2, 255, 0, 0, "C:\\ECF\\DOWNLOADMFD"); 
      }
    }
   except     on E : Exception) ShowMessage(E.Message);
  }
}
}

//--------------------------------------------
 public int geraRegistroCAT52MFD( string vModeloEcf , string  vArquivo , string  vData ) 
{
 ansistring vfilemf ;
    vDataI, vArqAux, vPorta : string;
{
    try      if ((vModeloEcf == "ecfBematech") | (vModeloEcf == 'ecfYanco')) {        result = Bematech_FI_GeraRegistrosCAT52MFD(vArquivo, vData); 
      end; else  if ((vModeloEcf == "ecfElgin")) {       end; else  if ((vModeloEcf == 'ecfInterway') | (vModeloEcf == 'ecfUrano')) {        vArquivo = getPathECF() + 'URANO.TDM'; 
        vPorta = LeIni("NR_PORTAECF",'COM1'); 
        InterwayGeraArquivoBinario( vPorta, vArquivo ,vNrSerie);
{
 ansistring vfilemf ;
{
 == nomearqrfd(vmodeloecf;
 strtodate(vdata aux;
{
 ansistring vfilemf ;
{
 == nomearqrfd(vmodeloecf;
 strtodate(vdata aux;
{
= getpathecf( aux ;
  + varqaux
        Result = InterwayGeraArquivoAto17(vArquivo, vArqAux, PChar(vData), PChar(vData), "D", ', PChar('TDM')); 
      end; else  if ((vModeloEcf == "ecfDaruma")) {       end; else  if ((vModeloEcf == 'ecfSweda')) {        vFileMF = 'C:\\NoStop.MF'; 
        result = ECF_DownloadMF(vFileMF); 
{
 ansistring vfilemf ;
{
 == nomearqrfd(vmodeloecf;
 strtodate(vdata aux;
{
= getpathecf( aux ;
  + varqaux
{
= vfilemf uivo ;
        result = ECF_GeraRegistrosCAT52MFD(vArquivo, vData); 
      end else  if ((vModeloEcf == "ecfEpson")) {   
    }
   except     on E : Exception) ShowMessage(E.Message);
  }
}
{
 ansistring vfilemf ;
{
 == nomearqrfd(vmodeloecf;
 strtodate(vdata aux;
{
= getpathecf( aux ;
  + varqaux
{
= vfilemf uivo ;
{
  string varqaux;
   string varquivo;
   string  vporta;
   string  vdatai ;
{
    try      if ((vModeloEcf == "ecfBematech") | (vModeloEcf == 'ecfYanco')) {       end; else  if ((vModeloEcf == 'ecfElgin')) {       end; else  if ((vModeloEcf == 'ecfInterway')) {        vArquivo = getPathECF() + 'URANO.TDM'; 
        vPorta = LeIni("NR_PORTAECF",'COM1'); 
        InterwayGeraArquivoBinario(vPorta, vArquivo ,vNrSerie);
{
 ansistring vfilemf ;
{
 == nomearqrfd(vmodeloecf;
 strtodate(vdata aux;
{
= getpathecf( aux ;
  + varqaux
{
= vfilemf uivo ;
{
  string varqaux;
   string varquivo;
   string  vporta;
   string  vdatai ;
{
 == nomearqrfd(vmodeloecf;
 strtodate(vdataini aux;
        Result = InterwayGeraArquivoAto17(vArquivo,vArqAux, PCHAR(vDataIni), PCHAR(vDataIni), "D",', PChar('TDM')); 
      end; else  if ((vModeloEcf == "ecfUrano")) {        vDataI = (FormatDateTime('YYYYMMDD',StrToDateTime(vDataIni))); 
{
 ansistring vfilemf ;
{
 == nomearqrfd(vmodeloecf;
 strtodate(vdata aux;
{
= getpathecf( aux ;
  + varqaux
{
= vfilemf uivo ;
{
  string varqaux;
   string varquivo;
   string  vporta;
   string  vdatai ;
{
 == nomearqrfd(vmodeloecf;
 strtodate(vdataini aux;
{
= getpathecf( uivo ;
  + "urano.tdm"
        vPorta = LeIni("NR_PORTAECF",'COM1'); 
        InterwayGeraArquivoBinario(vPorta, vArquivo ,vNrSerie);
{
 ansistring vfilemf ;
{
 == nomearqrfd(vmodeloecf;
 strtodate(vdata aux;
{
= getpathecf( aux ;
  + varqaux
{
= vfilemf uivo ;
{
  string varqaux;
   string varquivo;
   string  vporta;
   string  vdatai ;
{
 == nomearqrfd(vmodeloecf;
 strtodate(vdataini aux;
{
= getpathecf( uivo ;
  + "urano.tdm"
{
 == nomearqrfd(vmodeloecf;
 strtodate(vdataini aux;
        Result  =  InterwayGeraArquivoAto17(vArquivo,vArqAux, PCHAR(vDataI), PCHAR(vDataI), "D",', PChar('TDM')); 
      end; else  if ((vModeloEcf == "ecfDaruma")) {        result = regAlterarValor_Daruma('START\\LocalArquivosRelatorios',  getPathECF().Substring( 3,   getPathECF().Length )); 
      end else  if ((vModeloEcf == "ecfSweda")) {       end else  if ((vModeloEcf == 'ecfEpson')) {   
    }
   except     on E : Exception) ShowMessage(E.Message);
  }
} 
}

//--------------------------------------------
 public int programaFormaPagamento( string vModeloEcf , string  vFormaPgto , string  vPermiteTEF ) 
{
 string vdsnrpagamento ;
{
    try      if ((vModeloEcf == "ecfBematech") | (vModeloEcf == 'ecfYanco')) {        result = Bematech_FI_ProgramaFormaPagamentoMFD(vFormaPgto, vPermiteTEF); 
      end; else  if ((vModeloEcf == "ecfElgin")) {        result = Elgin_ProgramaFormaPagamentoMFD(vFormaPgto, vPermiteTEF); 
      end else  if ((vModeloEcf == "ecfInterway") | (vModeloEcf == 'ecfUrano')) {         if ((vPermiteTEF == '1'))         vPermiteTEF = 'true' 
      else
         vPermiteTEF = "false"; 
        result = DLLG2_ExecutaComando(Handle, 'DefineMeioPagamento; 
  NomeMeioPagamento=\"" + vFormaPgto + "\" PermiteVinculado=' + vPermiteTEF); 
      end; else  if ((vModeloEcf == "ecfDaruma")) {        Result = confCadastrarPadrao_ECF_Daruma('FPGTO', vFormaPgto); 
      end; else  if ((vModeloEcf == "ecfSweda")) {        result = ECF_ProgramaFormaPagamentoMFD(PChar(vFormaPgto), PChar(vPermiteTEF)); 
      end; else  if ((vModeloEcf == "ecfEpson")) {        vDsNrPagamento = FormatFloat('00', 1); 
         if ((vPermiteTEF == "1"))         result = EPSON_Config_Forma_Pagamento(True, PChar(vDsNrPagamento), PChar(vFormaPgto)) 
      else
         Result = EPSON_Config_Forma_Pagamento(False, PChar(vDsNrPagamento), PChar(vFormaPgto)); 
    } 
   except     on E : Exception) ShowMessage(E.Message);
  } 
} 
}

//--------------------------------------------
 public int formatoDadosMFD( string vModeloEcf , string  ArquivoOrigem , string  ArquivoDestino , string  TipoFormato , string  TipoDownload , string  ParametroInicial , string  ParametroFinal , string  UsuarioECF ) 
{
    try      if ((vModeloEcf == "ecfBematech") | (vModeloEcf == 'ecfYanco')) {        result = Bematech_FI_FormatoDadosMFD(ArquivoOrigem, ArquivoDestino, TipoFormato, TipoDownload, ParametroInicial, ParametroFinal, UsuarioECF); 
      end; else  if ((vModeloEcf == "ecfElgin")) {        result = Elgin_FormatoDadosMFD(ArquivoOrigem, ArquivoDestino, TipoFormato, TipoDownload, ParametroInicial, ParametroFinal, UsuarioECF); 
      end; else  if ((vModeloEcf == "ecfInterway") | (vModeloEcf == 'ecfUrano')) {       end; else  if ((vModeloEcf == 'ecfDaruma')) {       end; else  if ((vModeloEcf == 'ecfSweda')) {        result = ECF_FormatoDadosMFD(ArquivoOrigem, ArquivoDestino, TipoFormato, TipoDownload, ParametroInicial, ParametroFinal, UsuarioECF); 
    }
   except     on E : Exception) ShowMessage(E.Message);
  }
}

//--------------------------------------------
public int geraRegistrosTipoE( string vModeloEcf , string  vArqMFD , string  vArqTXT , string  vDataIni , string  vDataFim , string  vRazao , string  vEndereco , string  vCMD , string  vTpDownload ) 
{
 string vnrserie ;
    vTipoLeitura : Char;
    Tamanho : int;
{
    try      if ((vModeloEcf == "ecfBematech") | (vModeloEcf == 'ecfYanco')) {         result = BemaGeraRegistrosTipoE(PChar(vArqMFD), PChar(vArqTXT), PChar(vDataIni), PChar(vDataFim), PChar(vRazao), PChar(vEndereco), ', PChar(vCMD), ',',',',',',',',',',',','); 
      end; else  if ((vModeloEcf == "ecfElgin")) {       end; else  if ((vModeloEcf == 'ecfInterway') | (vModeloEcf == 'ecfUrano')) {        geraArquivoTipoEAux(vModeloEcf, vArqMFD, vArqTXT, 'MF', PChar(vTpDownload), vDataIni, vDataFim, '); 
      end; else  if ((vModeloEcf == "ecfDaruma")) {        Set  8.Length ; 
        Set  8.Length ; 
         if ((vTpDownload == "1")) {          vDataIni =  vDataIni.Substring( 1,  4) + '20' +  vDataIni.Substring( 5,  2); 
          vDataFim =  vDataFim.Substring( 1,  4) + "20" +  vDataFim.Substring( 5,  2); 
          Result = rGerarMFD_ECF_Daruma("DATAM", vDataIni, vDataFim); 
        end; else  if ((vTpDownload == "2")) {          Result = rGerarMFD_ECF_Daruma('COO', vDataIni, vDataFim); 
      }
     end; else  if ((vModeloEcf == "ecfSweda")) {       end; else  if ((vModeloEcf == 'ecfEpson')) {         if ((vTpDownload == '1')) {          vDataIni =  vDataIni.Substring( 1,  4) + '20' +  vDataIni.Substring( 5,  2); 
          vDataFim =  vDataFim.Substring( 1,  4) + "20" +  vDataFim.Substring( 5,  2); 
           result = EPSON_Obter_Dados_MF_MFD(PChar(vDataIni), PChar(vDataFim), 0, 0, 3, 0, "C:\\ECF\\AC1704")       end; else  if ((vTpDownload == '2')) {          vDataIni = zerosstring(6,  vDataIni.Trim(), false); 
          vDataFim = zerosstring(6,  vDataFim.Trim(), false); 
           result = EPSON_Obter_Dados_MF_MFD(PChar(vDataIni), PChar(vDataFim), 2, 0, 3, 0, "C:\\ECF\\AC1704"); 
      }
    }
   except     on E : Exception) ShowMessage(E.Message);
  }
}
}

//--------------------------------------------
 public int configuraCodBarras( string vModeloEcf , int  vAltura , int  vLargura , int  vPosicaoCaracteres , int  vFonte , int  vMargem ) 
{
    try      if ((vModeloEcf == "ecfBematech") | (vModeloEcf == 'ecfYanco')) {        result = Bematech_FI_ConfiguraCodigoBarrasMFD(vAltura, vLargura, vPosicaoCaracteres, vFonte, vMargem); 
      end; else  if ((vModeloEcf == "ecfElgin")) {        result = Elgin_ConfiguraCodigoBarrasMFD(vAltura, vLargura, vPosicaoCaracteres, vFonte, vMargem); 
      end; else  if ((vModeloEcf == "ecfInterway") | (vModeloEcf == 'ecfUrano')) {       end; else  if ((vModeloEcf == 'ecfDaruma')) {       end; else  if ((vModeloEcf == 'ecfSweda')) {        result = ECF_ConfiguraCodigoBarrasMFD( vAltura.ToString(),  vLargura.ToString(),  vPosicaoCaracteres.ToString(),  vFonte.ToString(),  vMargem.ToString()); 
      end else  if ((vModeloEcf == "ecfEpson")) {   
    } 
   except     on E : Exception) ShowMessage(E.Message);
  } 
} 

//--------------------------------------------
public int imprimeCodBarrasCODE128( string vModeloEcf , string  cCodigo ) 
{
    try      if ((vModeloEcf == "ecfBematech") | (vModeloEcf == 'ecfYanco')) {        result = Bematech_FI_ConfiguraCodigoBarrasMFD(70, 0, 2, 1, 5); 
        result = Bematech_FI_CodigoBarrasCODE128MFD(PChar(cCodigo)); 
      end; else  if ((vModeloEcf == "ecfElgin")) {        result = Elgin_CodigoBarrasCODE128MFD(PChar(cCodigo)); 
      end; else  if ((vModeloEcf == "ecfInterway") | (vModeloEcf == 'ecfUrano')) {       end; else  if ((vModeloEcf == 'ecfDaruma')) {        Result = iImprimirCodigoBarras_ECF_Daruma(PChar('05'), '2','0','1', PChar(cCodigo), 'h','); 
      end; else  if ((vModeloEcf == "ecfSweda")) {        result = ECF_ConfiguraCodigoBarrasMFD('70','0','2','1','5'); 
        result = ECF_CodigoBarrasITFMFD(PChar(cCodigo)); 
      end; else  if ((vModeloEcf == "ecfEpson")) {        result = EPSON_NaoFiscal_Imprimir_Codigo_Barras(70, 50, 2, 0, 0, PChar(cCodigo)); 
    }
   except     on E : Exception) ShowMessage(E.Message);
  }
}

//--------------------------------------------
public int configuraECF( string vModeloEcf ) 
{
    try      if ((vModeloEcf == "ecfBematech") | (vModeloEcf == 'ecfYanco')) {       end; else  if ((vModeloEcf == 'ecfElgin')) {       end; else  if ((vModeloEcf == 'ecfInterway') | (vModeloEcf == 'ecfUrano')) {       end; else  if ((vModeloEcf == 'ecfDaruma')) {        result = regAlterarValor_Daruma('ECF\\MensagemApl1',' '); 
        result = regAlterarValor_Daruma("ECF\\MensagemApl2",' '); 
        result = regAlterarValor_Daruma("ECF\\ControleAutomatico",'1'); 
        result = regAlterarValor_Daruma("ECF\\EncontrarECF",'1'); 
        result = regAlterarValor_Daruma("ECF\\PortaSerial", LeIni('NR_PORTAECF',')); 
        result = regAlterarValor_Daruma("START\\LocalArquivosRelatorios",  getPathECF().Substring( 3,   getPathECF().Length )); 
    }
   except     on E : Exception) ShowMessage(E.Message);
  }
}
{
    try      if ((vModeloEcf == "ecfBematech") | (vModeloEcf == 'ecfYanco')) {        Result = Bematech_FI_FlagsFiscais(vFlagFiscal); 
        vLstFlagFiscal = Analisa_FlagFiscais_Bematech(vFlagFiscal); 
      end; else  if ((vModeloEcf == "ecfElgin")) {        result = Elgin_FlagsFiscais(vFlagFiscal); 
      end; else  if ((vModeloEcf == "ecfInterway") | (vModeloEcf == 'ecfUrano')) {       end; else  if ((vModeloEcf == 'ecfDaruma')) {       end; else  if ((vModeloEcf == 'ecfSweda')) {        result = ECF_FlagsFiscais(vFlagFiscal); 
    } 
   except     on E : Exception) ShowMessage(E.Message);
  }
}

//--------------------------------------------
public int programaAliquota( string vModeloEcf , string  Aliquota , int  ICMS_ISS ) 
{
 string vresult ;
{
    try      if ((vModeloEcf == "ecfBematech") | (vModeloEcf == 'ecfYanco')) {        result = Bematech_FI_ProgramaAliquota(Aliquota, ICMS_ISS); 
 AliquotaICMS=True PercentualAliquota=' +  ICMS_ISS.ToString()); 
      end; else  if ((vModeloEcf == "ecfDaruma")) {        result = confCadastrar_ECF_Daruma(Aliquota,  ICMS_ISS.ToString(), '); 
    }
   except     on E : Exception) ShowMessage(E.Message);
  }
}
}

//--------------------------------------------
 public int mapaResumo( string vModeloEcf ) 
{
    try      if ((vModeloEcf == "ecfBematech") | (vModeloEcf == 'ecfYanco')) {        result = Bematech_FI_MapaResumo(); 
      end; else  if ((vModeloEcf == "ecfElgin")) {        result = Elgin_MapaResumo(); 
      end; else  if ((vModeloEcf == "ecfInterway") | (vModeloEcf == 'ecfUrano')) {       end; else  if ((vModeloEcf == 'ecfDaruma')) {       end; else  if ((vModeloEcf == 'ecfSweda')) {        result = ECF_MapaResumoMFD(); 
    }
   except     on E : Exception) ShowMessage(E.Message);
  }
}

//--------------------------------------------
public int aberturaDoDia( string vModeloEcf , string  ValorCompra , string  FormaPagamento ) 
{
    try      if ((vModeloEcf == "ecfBematech") | (vModeloEcf == 'ecfYanco')) {        result = Bematech_FI_AberturaDoDia(ValorCompra, FormaPagamento); 
      end; else  if ((vModeloEcf == "ecfElgin")) {        result = Elgin_AberturaDoDia(ValorCompra, FormaPagamento); 
      end; else  if ((vModeloEcf == "ecfInterway") | (vModeloEcf == 'ecfUrano')) {       end; else  if ((vModeloEcf == 'ecfDaruma')) {       end; else  if ((vModeloEcf == 'ecfSweda')) {        result = ECF_AberturaDoDia(ValorCompra, FormaPagamento); 
    }
   except     on E : Exception) ShowMessage(E.Message);
  } 
} 

//--------------------------------------------
public int abreCupomRecebimento( string vModeloEcf , string  FormaPagamento , string  Valor , string  NumeroCupom ) 
{
    try      if ((vModeloEcf == "ecfBematech") | (vModeloEcf == 'ecfYanco')) {        result = Bematech_FI_abreCupomVinculado(FormaPagamento, Valor, NumeroCupom); 
      end; else  if ((vModeloEcf == "ecfElgin")) {        result = Elgin_abreCupomVinculado(FormaPagamento, Valor, NumeroCupom); 
      end; else  if ((vModeloEcf == "ecfInterway") | (vModeloEcf == 'ecfUrano')) {       end; else  if ((vModeloEcf == 'ecfDaruma')) {        result = iCCDAbrirSimplificado_ECF_Daruma(FormaPagamento, '1', NumeroCupom, Valor); 
      end; else  if ((vModeloEcf == "ecfSweda")) {        result = ECF_abreCupomVinculado(FormaPagamento, Valor, NumeroCupom); 
    } 
   except     on E : Exception) ShowMessage(E.Message);
  } 
} 

//--------------------------------------------
public int abreRelatorioGerencial( string vModeloEcf , string  Indice ) 
{
 string vresult  ;
{
    try      if ((vModeloEcf == "ecfBematech") | (vModeloEcf == 'ecfYanco')) {        result = Bematech_FI_AbreRelatorioGerencialMFD(Indice); 
      end; else  if ((vModeloEcf == "ecfElgin")) {        result = Elgin_AbreRelatorioGerencialMFD(Indice); 
      end; else  if ((vModeloEcf == "ecfInterway") | (vModeloEcf == 'ecfUrano')) {        result = DLLG2_ExecutaComando(Handle,'AbreGerencial; 
 NomeGerencial=\"RELATORIO\"');
      end; else  if ((vModeloEcf == "ecfSweda")) {        result = ECF_AbreRelatorioGerencialMFD(Indice); 
    }
   except     on E : Exception) ShowMessage(E.Message);
  }
}
}

//--------------------------------------------
 public int acrescimoDescontoItem( string vModeloEcf ,  string Item,  string AcrescimoDesconto,  string TipoAcrescimoDesconto,  string ValorAcrescimoDesconto ) 
{
 string vdsdados ;
    i, vItem, vUltimoItem : int;
    vValorAcrescimoDesconto : Real;
{
    try      if ((vModeloEcf == "ecfBematech") | (vModeloEcf == 'ecfYanco')) {        result = Bematech_FI_AcrescimoDescontoItemMFD(Item, AcrescimoDesconto, TipoAcrescimoDesconto, ValorAcrescimoDesconto); 
      end; else  if ((vModeloEcf == "ecfElgin")) {        result = Elgin_AcrescimoDescontoItemMFD(Item, AcrescimoDesconto, TipoAcrescimoDesconto, ValorAcrescimoDesconto); 
      end; else  if ((vModeloEcf == "ecfInterway") | (vModeloEcf == 'ecfUrano')) {         ///*AcresceItemFiscal;
 ///*AcresceItemFiscal;
 Cancelar=false NumItem=1 ValorPercentual=-10;
 66*/
 66*/        
 Cancelar=" + false + " NumItem=' + Item +' ValorPercentual='-10); 
      end; else  if ((vModeloEcf == "ecfDaruma")) {        result = iCFLancarAcrescimoItem_ECF_Daruma(Item, AcrescimoDesconto + TipoAcrescimoDesconto, ValorAcrescimoDesconto); 
      end; else  if ((vModeloEcf == "ecfSweda")) {        vValorAcrescimoDesconto = Abs(StrToFloatDef(ValorAcrescimoDesconto,0)); 
        ValorAcrescimoDesconto = FormatFloat("0.00", vValorAcrescimoDesconto); 
        result = ECF_AcrescimoDescontoItemMFD(Item, AcrescimoDesconto, TipoAcrescimoDesconto, ValorAcrescimoDesconto); 
      end; else  if ((vModeloEcf == "ecfEpson")) {        ValorAcrescimoDesconto = ReplaceStr(ValorAcrescimoDesconto, ',','); 
        result  = EPSON_Fiscal_Desconto_Acrescimo_ItemEx(pChar(Item), pChar(ValorAcrescimoDesconto),2,True,False); 
          if ((result == 1)) {   // se der erro, vai verificar se é o ultimo item e dar o desconto \"normal\"         vDsDados = ReplicateStr(' ', 3);
 // se der erro, vai verificar se é o ultimo item e dar o desconto \"normal\"         vDsDados := ReplicateStr(' ', 3);
          EPSON_Obter_Numero_Ultimo_Item(pChar(vDsDados));
           vUltimoItem = StrToIntDef( vDsDados.Trim(), 0); 
          vItem = StrToIntDef( Item.Trim(), 999); 
           if ((vItem == vUltimoItem))  // se o desconto for no último item vendido           result  = EPSON_Fiscal_Desconto_Acrescimo_Item(pChar(ValorAcrescimoDesconto),2,True,False)
 // se o desconto for no último item vendido           result  := EPSON_Fiscal_Desconto_Acrescimo_Item(pChar(ValorAcrescimoDesconto),2,True,False)
        else
           result  = EPSON_Fiscal_Desconto_Acrescimo_ItemEx(pChar(Item), pChar(ValorAcrescimoDesconto),2,True,False); 
      }
    }
   except     on E : Exception) ShowMessage(E.Message);
  } 
}
}

//--------------------------------------------
 public int autentica( string vModeloEcf ) 
{
 string vdstxt ;
{
    try      if ((vModeloEcf == "ecfBematech") | (vModeloEcf == 'ecfYanco')) {        result = Bematech_FI_Autenticacao(); 
      end; else  if ((vModeloEcf == "ecfElgin")) {        result = Elgin_Autenticacao(); 
      end; else  if ((vModeloEcf == "ecfInterway") | (vModeloEcf == 'ecfUrano')) {        result = DLLG2_ExecutaComando(Handle, 'ImprimeAutenticacao; 
 TempoEspera=8');
      end; else  if ((vModeloEcf == "ecfDaruma")) {        Set  48.Length ; 
        Result = iAutenticarDocumento_DUAL_DarumaFramework(vDsTxt, "1",'120'); 
      end; else  if ((vModeloEcf == "ecfSweda")) {        result = ECF_Autenticacao(); 
    }
   except     on E : Exception) ShowMessage(E.Message);
  }
}
}

//--------------------------------------------
 public int fechaVinculado( string vModeloEcf ) 
{
    try      if ((vModeloEcf == "ecfBematech") | (vModeloEcf == 'ecfYanco')) {        result = Bematech_FI_FechaComprovanteNaoFiscalVinculado(); 
      end; else  if ((vModeloEcf == "ecfElgin")) {        result = Elgin_FechaComprovanteNaoFiscalVinculado(); 
      end; else  if ((vModeloEcf == "ecfInterway") | (vModeloEcf == 'ecfUrano')) {        result = DLLG2_ExecutaComando(Handle, 'EncerraDocumento'); 
      end; else  if ((vModeloEcf == "ecfDaruma")) {        result = iCCDFechar_ECF_Daruma     end; else  if ((vModeloEcf == 'ecfSweda')) {        result = ECF_FechaComprovanteNaoFiscalVinculado(); 
      end; else  if ((vModeloEcf == "ecfEpson")) {        result = EPSON_NaoFiscal_Fechar_Relatorio_Gerencial(true); 
    }
   except     on E : Exception) ShowMessage(E.Message);
  }
}

//--------------------------------------------
public int imprimeVinculado( string vModeloEcf , string  Texto ) 
{
 string[] vlstlinha ;
    vLinha : string;
    i : int;
{
    try      if ((vModeloEcf == "ecfBematech") | (vModeloEcf == 'ecfYanco')) {        result = Bematech_FI_UsaComprovanteNaoFiscalVinculado(Texto); 
      end; else  if ((vModeloEcf == "ecfElgin")) {        result = Elgin_UsaComprovanteNaoFiscalVinculado(Texto); 
      end; else  if ((vModeloEcf == "ecfInterway") | (vModeloEcf == 'ecfUrano')) {        result = DLLG2_ExecutaComando(Handle, 'ImprimeTexto; 
 TextoLivre=\"" + Texto + "\"'); 
      end; else  if ((vModeloEcf == "ecfSweda")) {        result = ECF_UsaComprovanteNaoFiscalVinculado(Texto); 
      end; else  if ((vModeloEcf == "ecfEpson")) {          if ((vCont == 0)) {   //quando for o primeiro comando abre o vinculado          result = EPSON_NaoFiscal_Abrir_Relatorio_Gerencial('1');
 //quando for o primeiro comando abre o vinculado          result = EPSON_NaoFiscal_Abrir_Relatorio_Gerencial('1');
 //quando for o primeiro comando abre o vinculado          result := EPSON_NaoFiscal_Abrir_Relatorio_Gerencial('1');
            VCont++; 
       }
        try          vLstLinha = new  string[]; 
           vLstLinha.Text = Texto; 
for ( i ==  0;  i <=  vLstLinha.Count - 1) {             vLinha = vLstLinha[i];;  i++)
             result = EPSON_NaoFiscal_Imprimir_Linha(PChar(vLinha)); 
         } 
       } 
    } 
   except     on E : Exception) ShowMessage(E.Message);
  }
}
}

//--------------------------------------------
 public int imprimirRelatorioGerencial( string vModeloEcf , string  Texto ) 
{
 string[] vlstlinha ;
    vLinha : string;
    i : int;
{
    try      if ((vModeloEcf == "ecfBematech") | (vModeloEcf == 'ecfYanco')) {        result = Bematech_FI_RelatorioGerencial(Texto); 
      end; else  if ((vModeloEcf == "ecfElgin")) {        result = ELgin_RelatorioGerencial(Texto); 
      end; else  if ((vModeloEcf == "ecfInterway") | (vModeloEcf == 'ecfUrano')) {  // Zottis 13/03/2014       result = DLLG2_ExecutaComando(Handle,'AbreGerencial;
 // Zottis 13/03/2014       result = DLLG2_ExecutaComando(Handle,'AbreGerencial;
 // Zottis 13/03/2014       result := DLLG2_ExecutaComando(Handle,'AbreGerencial;
 NomeGerencial=\"RELATORIO\"');
        result = DLLG2_ExecutaComando(Handle,'ImprimeTexto; 
 TextoLivre=\"" + Texto + "\"'); 
      end; else  if ((vModeloEcf == "ecfDaruma")) {        result = iRGImprimirTexto_ECF_Daruma(Texto); 
      end; else  if ((vModeloEcf == "ecfSweda")) {        result = ECF_RelatorioGerencial(Texto); 
      end; else  if ((vModeloEcf == "ecfEpson")) {          if ((vCont == 0)) {   //quando for o primeiro comando abre o gerencial          result = EPSON_NaoFiscal_Abrir_Relatorio_Gerencial('1');
 //quando for o primeiro comando abre o gerencial          result = EPSON_NaoFiscal_Abrir_Relatorio_Gerencial('1');
 //quando for o primeiro comando abre o gerencial          result := EPSON_NaoFiscal_Abrir_Relatorio_Gerencial('1');
            VCont++; 
       } 
        try          vLstLinha = new  string[]; 
           vLstLinha.Text = Texto; 
for ( i ==  0;  i <=  vLstLinha.Count - 1) {             vLinha = vLstLinha[i];;  i++)
             result = EPSON_NaoFiscal_Imprimir_Linha(PChar(vLinha)); 
         } 
       } 
    } 
   except     on E : Exception) ShowMessage(E.Message);
  } 
}
}

//--------------------------------------------
 public int progHoraVerao( string vModeloEcf ) 
{
    try      if ((vModeloEcf == "ecfBematech") | (vModeloEcf == 'ecfYanco')) {        result = Bematech_FI_ProgramaHorarioVerao(); 
      end; else  if ((vModeloEcf == "ecfElgin")) {        result = Elgin_ProgramaHorarioVerao(); 
      end; else  if ((vModeloEcf == "ecfInterway") | (vModeloEcf == 'ecfUrano')) {       end; else  if ((vModeloEcf == 'ecfDaruma')) {        result = confHabilitarHorarioVerao_ECF_Daruma; 
      end else  if ((vModeloEcf == "ecfSweda")) {   
    }
   except     on E : Exception) ShowMessage(E.Message);
  }
}

//--------------------------------------------
public string verificaReducaoZ( string vModeloEcf ) 
{
  string vmetodo;
   string  vresult;
   string  vstatusz;
   string  vmodelo ;
    vDataMovimento, vDataImpressora : DateTime;
    vNrIndicadores : string;
    Indicadores : int;
}

//--------------------------------------------
     public string prcVerificaReducaoZ() 
      {
          iRetorno = dataImpressora(vModeloEcf); 
          vDataHora = FormatarDataFmt(vDataHora, "ddmmyy", 'dd/mm/yy'); 
          vDataMovimento = StrToDateDef(vDataHora, 0); 
          vDataMovimento = trunc(vDataMovimento); 
           iRetorno = dataHoraImpressora(vModeloEcf); 
          vDataImpressora = StrToDateTimeDef(vDataHora, 0); 
          vDataImpressora = trunc(vDataImpressora); 
            if ((vDataMovimento > 0) & (vDataMovimento != vDataImpressora)) {            Result = SetStatus(STS_REDZPEND, vModelo, cRED_Z_PENDENTE, vMetodo); 
            return(STS_REDZPEND);
  exit;
        }
      }
{
    Result = '; 
     vMetodo = "uECF.verificaReducaoZ"; 
    vModelo = ReplaceStr(vModeloEcf, "ecf", '); 
     try      if ((vModeloEcf == "ecfBematech") | (vModeloEcf == 'ecfYanco')) {        Result = prcVerificaReducaoZ(); 
      end; else  if ((vModeloEcf == "ecfElgin")) {        Result = prcVerificaReducaoZ(); 
      end; else  if ((vModeloEcf == "ecfInterway") | (vModeloEcf == 'ecfUrano')) {         // LeInteiro;
 // LeInteiro;
  NomeInteiro=\"Indicadores\";
 40       DLLG2_ExecutaComando(Handle, 'LeInteiro;
  NomeInteiro=\"Indicadores\"');
        vNrIndicadores = DLLG2_ObtemRetornos(Handle, vNrIndicadores, 10); 
        Indicadores = itemI("ValorInteiro", vNrIndicadores); 
         vResult = verificaIndicadoresUrano(Indicadores); 
         if (itemXmlB("FLAG_Z_PENDENTE", vResult)) {          Result = SetStatus(STS_REDZPEND, vModelo, cRED_Z_PENDENTE, vMetodo); 
          return(STS_REDZPEND);
  exit;
        end; else  if (itemXmlB("FLAG_DIA_FECHADO", vResult)) {          Result = SetStatus(STS_REDZBLOQ, vModelo, cRED_Z_BLOQUEADA, vMetodo); 
          return(STS_REDZBLOQ);
  exit;
      }
      end; else  if ((vModeloEcf == "ecfDaruma")) {        Set  1.Length ; 
        iRetorno = rVerificarReducaoZ_ECF_Daruma(vStatusZ); 
          if ((vStatusZ == "1")) {          Result = SetStatus(STS_REDZPEND, vModelo, cRED_Z_PENDENTE, vMetodo); 
          return(STS_REDZPEND);
  exit;
      }
      end; else  if ((vModeloEcf == "ecfSweda")) {        Set  2.Length ; 
        vRetorno = ECF_VerificaZPendente(vStatusZ); 
          return(STS_REDZPEND);
  exit;
      }
    }
   except     on E : Exception) ShowMessage(E.Message);
  }
    Result = SetStatus(STS_EXEC); 
    return(STS_EXEC);
  exit;
}

//--------------------------------------------
public int abrePorta( string vModeloEcf ) 
{
 string vporta ;
    CodErro  : int;
    vMsg, Retornos : string;
{
    Result = 1; 
        result = Bematech_FI_HabilitaDesabilitaRetornoEstendidoMFD("1"); 
      end; else  if ((vModeloEcf == "ecfElgin")) {       end; else  if ((vModeloEcf == 'ecfInterway') | (vModeloEcf == 'ecfUrano')) {        vPorta = LeIni('NR_PORTAECF','COM1'); 
        handle = DLLG2_IniciaDriver(vPorta); 
        result = result; 
         CodErro = DLLG2_ObtemCodErro(Handle); 
          vMSG = vMsg + " , " + DLLG2_ObtemCircunstancia(Handle,Retornos,0); 
      }
        DLLG2_DefineTimeout(result, 50);
      end; else  if ((vModeloEcf == "ecfDaruma")) {       end; else  if ((vModeloEcf == 'ecfSweda')) {        Result = ECF_AbrePortaSerial(); 
      end; else  if ((vModeloEcf == "ecfEpson")) {        Result = EPSON_Serial_Abrir_PortaEx; 
    }
   except     on E : Exception) ShowMessage(E.Message);
  }
}
}

//--------------------------------------------
 public int fechaPorta( string vModeloEcf ) 
{
 string vresult ;
{
    Result = 1; 
      end; else  if ((vModeloEcf == "ecfDaruma")) {       end; else  if ((vModeloEcf == 'ecfSweda')) {        Result = ECF_FechaPortaSerial(); 
      end; else  if ((vModeloEcf == "ecfEpson")) {        Result = EPSON_Serial_Fechar_Porta; 
    }
   except     on E : Exception) ShowMessage(E.Message);
  } 
} 
}

//--------------------------------------------
 public int iniciaModoTEF( string vModeloEcf ) 
{
    Result = 1; 
      end; else  if ((vModeloEcf == "ecfElgin")) {       end; else  if ((vModeloEcf == 'ecfInterway') | (vModeloEcf == 'ecfUrano')) {       end; else  if ((vModeloEcf == 'ecfDaruma')) {       end; else  if ((vModeloEcf == 'ecfSweda')) {        Result = ECF_IniciaModoTEF(); 
    } 
   except     on E : Exception) ShowMessage(E.Message);
  }
} 

//--------------------------------------------
public int finalizaModoTEF( string vModeloEcf ) 
{
    Result = 1; 
      end; else  if ((vModeloEcf == "ecfElgin")) {       end; else  if ((vModeloEcf == 'ecfInterway') | (vModeloEcf == 'ecfUrano')) {       end; else  if ((vModeloEcf == 'ecfDaruma')) {       end; else  if ((vModeloEcf == 'ecfSweda')) {        Result = ECF_FinalizaModoTEF(); 
    }
   except     on E : Exception) ShowMessage(E.Message);
  }
}

//--------------------------------------------
public int arquivoMFD( string vModeloEcf,  string pParams ) 
{
  string varquivo;
   string  vdadoinicial;
   string  vdadofinal;
   string  vusuario;
   string    vtpperiodo;
   string  vtparquivo;
   string  varquivosaida;
   string  vrazaosocial;
   string  vendereco;
   string    vcmd;
   string  vlinha;
   string  vmodecf;
   string  vtipo ;
 /*=-=-=-=-=-=-=-=-=-=BEMATECH=-=-=-=-=-=-=-=-=-= TipoGeracao : int indicando a parametrização a ser feita no arquivo, onde : 0 == MF 1 == MFD 2 == TDM 3 == RZ 4 == RFD Tipo Registros Gerados no Arquivo MF == E01, E02, E03, E04, E05, E06, E07, E08, E09, E10, E11, E12 e E13 MFD= E01, E02, E14, E15, E16, E17, E18, E19, E20 e E21 TDM= E01, E02, E03, E04, E05, E06, E07, E08, E09, E10, E11, E12, E13, E14, E15, E16, E17, E18, E19, E20 e E21 RZ == E01, E02, E14, E15 e E16 RFD == E01, E02, E03, E04, E05, E06, E07, E08, E09, E10, E11, E12 e E13*/
 /*=-=-=-=-=-=-=-=-=-=BEMATECH=-=-=-=-=-=-=-=-=-= TipoGeracao : int indicando a parametrização a ser feita no arquivo, onde : 0 = MF 1 = MFD 2 = TDM 3 = RZ 4 = RFD Tipo Registros Gerados no Arquivo MF = E01, E02, E03, E04, E05, E06, E07, E08, E09, E10, E11, E12 e E13 MFD= E01, E02, E14, E15, E16, E17, E18, E19, E20 e E21 TDM= E01, E02, E03, E04, E05, E06, E07, E08, E09, E10, E11, E12, E13, E14, E15, E16, E17, E18, E19, E20 e E21 RZ = E01, E02, E14, E15 e E16 RFD = E01, E02, E03, E04, E05, E06, E07, E08, E09, E10, E11, E12 e E13*/
{
  string varquivo;
   string  vdadoinicial;
   string  vdadofinal;
   string  vusuario;
   string    vtpperiodo;
   string  vtparquivo;
   string  varquivosaida;
   string  vrazaosocial;
   string  vendereco;
   string    vcmd;
   string  vlinha;
   string  vmodecf;
   string  vtipo ;
{
 textfile temp           ;
{
  string varquivo;
   string  vdadoinicial;
   string  vdadofinal;
   string  vusuario;
   string    vtpperiodo;
   string  vtparquivo;
   string  varquivosaida;
   string  vrazaosocial;
   string  vendereco;
   string    vcmd;
   string  vlinha;
   string  vmodecf;
   string  vtipo ;
{
 textfile temp           ;
{
 textfile temptxt        ;
     vTexto : string[];
{
    Result = 0; 
{
  string varquivo;
   string  vdadoinicial;
   string  vdadofinal;
   string  vusuario;
   string    vtpperiodo;
   string  vtparquivo;
   string  varquivosaida;
   string  vrazaosocial;
   string  vendereco;
   string    vcmd;
   string  vlinha;
   string  vmodecf;
   string  vtipo ;
{
 textfile temp           ;
{
 textfile temptxt        ;
{
 == itemxml("ds_arquivo";
 pparams uivo;
    vDadoInicial   = itemXml("DS_DADOINICIAL", pParams); 
    vDadoFinal     = itemXml("DS_DADOFINAL", pParams); 
    vUsuario       = itemXml("NR_USUARIO", pParams); 
    vTpPeriodo     = itemXml("TP_DOWNLOAD", pParams); 
{
  string varquivo;
   string  vdadoinicial;
   string  vdadofinal;
   string  vusuario;
   string    vtpperiodo;
   string  vtparquivo;
   string  varquivosaida;
   string  vrazaosocial;
   string  vendereco;
   string    vcmd;
   string  vlinha;
   string  vmodecf;
   string  vtipo ;
{
 textfile temp           ;
{
 textfile temptxt        ;
{
 == itemxml("ds_arquivo";
 pparams uivo;
{
 == itemxml('ds_arqsaida';
 pparams uivosaida;
    vRazaoSocial   = iffNulo(itemXml("DS_RAZAOSOCIAL", pParams), 'Bematech S/A'); 
    vEndereco      = iffNulo(itemXml("DS_ENDERECO", pParams), 'Rua ABCDEF, 1234'); 
    vCMD           = iffNulo(itemXml("DS_CMD", pParams), '2'); 
    vTpArquivo     = itemXml("TP_ARQUIVO", pParams); 
    vTpPeriodo     = itemXml("TP_DOWNLOAD", pParams); 
     try      if ((vModeloEcf == "ecfBematech") | (vModeloEcf == 'ecfYanco')) {         if ((vTpPeriodo == '1')) {   //por data         vDadoInicial = formatDateTime('DDMMYY', strToDate(vDadoInicial));
 //por data         vDadoInicial = formatDateTime('DDMMYY', strToDate(vDadoInicial));
 //por data         vDadoInicial := formatDateTime('DDMMYY', strToDate(vDadoInicial));
          vDadoFinal = formatDateTime("DDMMYY", strToDate(vDadoFinal)); 
           Result = Bematech_FI_DownloadMFD(vArquivo, vTpPeriodo, vDadoInicial, vDadoFinal, vUsuario); 
          Result = BemaGeraRegistrosTipoE(PChar(vArquivo), PChar(vArquivoSaida), PChar(vDadoInicial), PChar(vDadoFinal), PChar(vRazaoSocial), PChar(vEndereco), ", PChar(vCMD), ",',',',',',',',',',',','); 
           if ((result == 0)) {   //Tratamento de retorno da DLL  BemaMFD2.dll quando a executado corretamente é igual a 0           Result = 1;
 //Tratamento de retorno da DLL  BemaMFD2.dll quando a executado corretamente é igual a 0           Result := 1;
        }
       end; else  if ((vTpPeriodo == "2")) {   //por COO         modeloImpressoraECF(vModeloEcf);
 //por COO         modeloImpressoraECF(vModeloEcf);
           if ((All vModeloImpressoraECF.Trim()!= "MP2000FI") & (AllTrim(vModeloImpressoraECF)!= 'MP6000FI') ) {            BemaDLL.MP2100 = true; 
        }
          Result = Bematech_FI_DownloadMFD(vArquivo, vTpPeriodo, vDadoInicial, vDadoFinal, vUsuario); 
          Result = BemaDLL.BemaGeraTxtPorCOO(PChar(vArquivo),                                              getPathECF() + cARQ_ESPELHO,                                              StrToIntDef(vUsuario, 0),                                              StrToIntDef(vDadoInicial, 0),                                              StrToIntDef(vDadoFinal, 0)); 
          Reset(vArqTemp);
          Rewrite(vArqTempTXT);
           vLinha = '; 
          while (!EOF(vArqTemp)) {            Readln(vArqTemp, vLinha);
             if ((vLinha != ')) {              Writeln(vArqTempTXT, vLinha);
          }
        }
         CloseFile(vArqTemp);
          CloseFile(vArqTempTXT);
          vTexto.LoadFromFile(getPathECF()+cARQ_ESPELHOTMP);
           if ((BemaDLL.MP2100 == true))           vDadoFinal =  vTexto[ vTexto.Count - 2 ].Substring( 20,  10) 
        else
           vDadoFinal =  vTexto[ vTexto.Count - 3 ].Substring( 29,  10); 
           if ((result == 0)) {   //Tratamento de retorno da DLL  BemaMFD2.dll quando a executado corretamente é igual a 0           Result = 1;
 //Tratamento de retorno da DLL  BemaMFD2.dll quando a executado corretamente é igual a 0           Result := 1;
        }
          DeleteFile(getPathECF()+cARQ_MFD);
          DeleteFile(getPathECF()+cARQ_ESPELHO);
          DeleteFile(getPathECF()+cARQ_ESPELHOTMP);
      }
     end; else  if ((vModeloEcf == "ecfElgin")) {       end; else  if ((vModeloEcf == 'ecfInterway') | (vModeloEcf == 'ecfUrano')) {         if ((vTpPeriodo != '2')) {   // 2 == COO         vTpPeriodo = 'M';
 // 2 = COO         vTpPeriodo = 'M';
 // 2 = COO         vTpPeriodo := 'M';
        end; else         vTpPeriodo = "C"; 
         geraArquivoTipoEAux(vModeloEcf, vArquivo, vArquivoSaida, vTpArquivo, vTpPeriodo, vDadoInicial, vDadoFinal, vUsuario) ;
      end; else  if ((vModeloEcf == "ecfDaruma")) {         if ((FileExists(getPathECF() + 'ATO_MFD_DATA.TXT'))) {          DeleteFile(getPathECF() + 'ATO_MFD_DATA.TXT'); 
      }
       result = regAlterarValor_Daruma("ECF\\Atocotepe\\LocalArquivos", vArquivoSaida); 
         if ((vTpPeriodo == "1")) {   //por data         vDadoInicial = formatDateTime('DDMMYYYY', strToDate(vDadoInicial));
 //por data         vDadoInicial = formatDateTime('DDMMYYYY', strToDate(vDadoInicial));
 //por data         vDadoInicial := formatDateTime('DDMMYYYY', strToDate(vDadoInicial));
          vDadoFinal = formatDateTime("DDMMYYYY", strToDate(vDadoFinal)); 
          vTipo = "DATAM"; 
          result = rGerarRelatorio_ECF_Daruma("MFD", vTipo, vDadoInicial, vDadoFinal); 
           if ((FileExists(getPathECF() + "ATO_MFD_DATA.TXT"))) {            RenameFile(getPathECF() + 'ATO_MFD_DATA.TXT', vArquivoSaida); 
        }
       end; else  if ((vTpPeriodo == "2")) {   //por COO         vTipo = 'COO';
 //por COO         vTipo = 'COO';
 //por COO         vTipo := 'COO';
          result = rGerarRelatorio_ECF_Daruma("MFD", vTipo, vDadoInicial, vDadoFinal); 
      }
     end; else  if ((vModeloEcf == "ecfSweda")) {        result = ECF_ReproduzirMemoriaFiscalMFD('2', vDadoInicial, vDadoFinal, vArquivoSaida, '); 
    }
   except     on E : Exception) ShowMessage(E.Message);
  }
}
}

//--------------------------------------------
 public int grandeTotal( string vModeloEcf ) 
{
 int iconta ;
{
    Result = 1; 
     try      if ((vModeloEcf == "ecfBematech") | (vModeloEcf == 'ecfYanco')) {        iRetorno = Bematech_FI_GrandeTotal(vGrandeTotal); 
      end; else  if ((vModeloEcf == "ecfElgin")) {       end; else  if ((vModeloEcf == 'ecfInterway') | (vModeloEcf == 'ecfUrano')) {       end; else  if ((vModeloEcf == 'ecfDaruma')) {        iRetorno = rRetornarInformacao_ECF_Daruma('1', vGrandeTotal); 
      end; else  if ((vModeloEcf == "ecfSweda")) {        iRetorno = ECF_GrandeTotal(vGrandeTotal); 
    } 
   except     on E : Exception) ShowMessage(E.Message);
  } 
} 
}

//--------------------------------------------
 public int espelhoMFD( string vModeloEcf , string  pParams ) 
{
  string vdadoini;
   string  vdadofim;
   string  vtipoespelho;
   string  vlinha;
   string    vdspatharquivo;
   string  vdsusuario;
   string  vdsarqmfd;
   string  vaux ;
    vDsArq : string[];
{
    try     vDadoIni = itemXml("DS_DADOINI", pParams); 
      vDadoFim = itemXml("DS_DADOFIM", pParams); 
      vTipoEspelho = itemXml("TP_DOWNLOAD", pParams); 
       vDsPathArquivo = itemXml("DS_PATHARQUIVO", pParams); 
      vDsUsuario = itemXml("NR_USUARIO", pParams); 
      vDsArqMfd = itemXml("DS_ARQUIVOMFD", pParams); 
        if ((vModeloEcf == "ecfBematech") | (vModeloEcf == 'ecfYanco')) {        iRetorno = downloadMFD(vModeloEcf, vDsArqMfd, vTipoEspelho, vDadoIni, vDadoFim, vDsUsuario); 
        iRetorno = formatoDadosMFD(vModeloEcf, vDsArqMfd, vDsPathArquivo, "0", vTipoEspelho, vDadoIni, vDadoFim, vDsUsuario); 
        Result = iRetorno; 
      end; else  if ((vModeloEcf == "ecfElgin")) {       end; else  if ((vModeloEcf == 'ecfInterway') | (vModeloEcf == 'ecfUrano')) {         //Zottis 17/03/2014        if (FileExists(vDsPathArquivo)) {          DeleteFile(vDsPathArquivo);
 //Zottis 17/03/2014        if (FileExists(vDsPathArquivo)) {          DeleteFile(vDsPathArquivo);
      }
         if ((vTipoEspelho != "2")) Begin // 2 == COO         vTipoEspelho = 'M';
 // 2 = COO         vTipoEspelho = 'M';
 // 2 = COO         vTipoEspelho := 'M';
          vDadoIni   =  vDadoIni.Substring( 1, 2) + "/" +  vDadoIni.Substring( 3, 2) + '/' +  vDadoIni.Substring( 5,  vDadoIni.Length ); 
          vDadoFim   =  vDadoFim.Substring( 1, 2) + "/" +  vDadoFim.Substring( 3, 2) + '/' +  vDadoFim.Substring( 5,  vDadoFim.Length ); 
        end; else {          vTipoEspelho = "C"; 
      }
        geraArquivoTipoEAux(vModeloEcf, vDsArqMfd, vDsPathArquivo, "TDM", vTipoEspelho, vDadoIni, vDadoFim, vDsUsuario) ; 
      end; else  if ((vModeloEcf == "ecfDaruma")) {         if (FileExists(getPathECF + 'Espelho_MFD.txt')) {          DeleteFile(getPathECF + 'Espelho_MFD.txt'); 
      }
        if ((vDsPathArquivo != ")) iRetorno = regAlterarValor_Daruma("START\\LocalArquivos', getPathECF()); 
         iRetorno = rGerarEspelhoMFD_ECF_Daruma(vTipoEspelho, vDadoIni, vDadoFim); 
         if (FileExists(getPathECF + "Espelho_MFD.txt")) {          vDsArq = new  string[]; 
          vDsArq.LoadFromFile(getPathECF + "Espelho_MFD.txt"); 
          vDsArq.SaveToFile(vDsPathArquivo);
      } 
      end; else  if ((vModeloEcf == "ecfSweda")) {         if ((vTipoEspelho == '1')) {          vAux =  vDadoIni.Substring( 1,  2) + '/' +  vDadoIni.Substring( 3,  2) + '/' +  vDadoIni.Substring( 5,  2); 
          vDadoIni = vAux; 
          vAux =  vDadoFim.Substring( 1,  2) + "/" +  vDadoFim.Substring( 3,  2) + '/' +  vDadoFim.Substring( 5,  2); 
          vDadoFim = vAux; 
          vDadoIni = FormatDateTime("dd/mm/yyyy", StrToDateDef(vDadoIni, 0)); 
          vDadoFim = FormatDateTime("dd/mm/yyyy", StrToDateDef(vDadoFim, 0)); 
        end; else  if ((vTipoEspelho == "2")) {          vDadoIni = '0' + vDadoIni; 
          vDadoFim = "0" + vDadoFim; 
      } 
       result = ECF_DownloadMFD(vDsPathArquivo, vTipoEspelho, vDadoIni, vDadoFim, "1"); 
    } 
   except     on E : Exception) ShowMessage(E.Message);
  }
} 
}

//--------------------------------------------
 public int configuraGuilhotina( string vModeloEcf , string  pParams ) 
{
    try      if ((vModeloEcf == "ecfBematech") | (vModeloEcf == 'ecfYanco')) {       end; else  if ((vModeloEcf == 'ecfElgin')) {       end; else  if ((vModeloEcf == 'ecfInterway') | (vModeloEcf == 'ecfUrano')) {       end; else  if ((vModeloEcf == 'ecfDaruma')) {        result = confProgramarAvancoPapel_ECF_Daruma('25','5','6','1','0'); 
        regAlterarValor_Daruma("ECF\\MensagemApl1",' '); 
        regAlterarValor_Daruma("ECF\\MensagemApl2",' '); 
        regAlterarValor_Daruma("ECF\\ControleAutomatico",'1'); 
        regAlterarValor_Daruma("ECF\\EncontrarECF",'1'); 
        regAlterarValor_Daruma("ECF\\PortaSerial", vDsPorta); 
        regAlterarValor_Daruma("START\\LocalArquivosRelatorios", getPathECF()); 
      end else  if ((vModeloEcf == "ecfSweda")) {   
    }
   except     on E : Exception) ShowMessage(E.Message);
  }
}

//--------------------------------------------
public int geraArquivoTipoEAux( string vModeloEcf ,  string vArqEntr,  string vArqSai,  string vTipoLeitura,  string vTipoPeriodo,  string vDataIni,  string vDataFim,  string vUsuario ) 
{
  string varquivotdm;
   string  varquivosaida;
   string  vporta;
   string  vdatai;
   string  vdataf;
   string  vusu ;
{
     try      if ((vModeloEcf == "ecfBematech") | (vModeloEcf == 'ecfYanco')) {       end; else  if ((vModeloEcf == 'ecfElgin')) {       end; else  if ((vModeloEcf == 'ecfInterway') | (vModeloEcf == 'ecfUrano')) {        Result = DLLG2_ExecutaComando(Handle, 'LeTexto; 
  NomeTexto=\"NumeroSerieECF\"');
        vNrSerie = DLLG2_ObtemRetornos(Handle, vNrSerie, 0); 
        vNrSerie = fRetornaValor(vNrSerie, "ValorTexto",'\"'); 
          if (vTipoPeriodo != "C") {          vDataI = FormatDateTime('YYYYMMDD',StrToDateTime(vDataIni)); 
          vDataF = FormatDateTime("YYYYMMDD",StrToDateTime(vDataIni)); 
      }
        vPorta = LeIni("NR_PORTAECF",'COM1'); 
        InterwayGeraArquivoBinario( vPorta, vArqEntr ,vNrSerie);
        Result = InterwayGeraArquivoAto17(vArqEntr,vArqSai , vDataI, vDataF, vTipoPeriodo[1], vUsuario, vTipoLeitura); 
      end else  if ((vModeloEcf == "ecfDaruma")) {       end else  if ((vModeloEcf == 'ecfSweda')) {   
    }
   except     on E : Exception) ShowMessage(E.Message);
  }
}
}

//--------------------------------------------
 public int numeroIntervencoes( string vModeloEcf ) 
{
 string vdsnumerointerverncoes ;
{
    try      if ((vModeloEcf == "ecfBematech") | (vModeloEcf == 'ecfYanco')) {        vDsNumeroInterverncoes = ReplicateStr(' ', 6); 
        Result = Bematech_FI_NumeroIntervencoes(vDsNumeroInterverncoes); 
         if (retornoImpressoraErro(vModeloEcf, result)) return;
          if ( vDsNumeroInterverncoes.Trim()= ") vDsNumeroInterverncoes = "0'; 
        vNrIntervencoes = vDsNumeroInterverncoes; 
      end; else  if ((vModeloEcf == "ecfElgin")) {       end; else  if ((vModeloEcf == 'ecfInterway') | (vModeloEcf == 'ecfUrano')) {       end; else  if ((vModeloEcf == 'ecfDaruma')) {       end; else  if ((vModeloEcf == 'ecfSweda')) {        vDsNumeroInterverncoes = ReplicateStr(' ', 6); 
        result = ECF_NumeroIntervencoes(vDsNumeroInterverncoes); 
        vNrIntervencoes = vDsNumeroInterverncoes; 
      end else  if ((vModeloEcf == "ecfEpson")) {   
    }
   except     on E : Exception) ShowMessage(E.Message);
  }
}
}

//--------------------------------------------
 public int numeroReducoes( string vModeloEcf ) 
{
 string vdsnumeroreducoes ;
{
    try      if ((vModeloEcf == "ecfBematech") | (vModeloEcf == 'ecfYanco')) {        vDsNumeroReducoes  = '; 
        vDsNumeroReducoes = ReplicateStr(" ", 4); 
        Result = Bematech_FI_NumeroReducoes(vDsNumeroReducoes); 
         if (retornoImpressoraErro(vModeloEcf, result)) return;
          if ( vDsNumeroReducoes.Trim()= ") vDsNumeroReducoes = "0'; 
        vNrNumeroReducoes = vDsNumeroReducoes; 
      end; else  if ((vModeloEcf == "ecfElgin")) {       end; else  if ((vModeloEcf == 'ecfInterway') | (vModeloEcf == 'ecfUrano')) {       end; else  if ((vModeloEcf == 'ecfDaruma')) {       end; else  if ((vModeloEcf == 'ecfSweda')) {        vDsNumeroReducoes = ReplicateStr(' ', 6); 
        result = ECF_NumeroReducoes(vDsNumeroReducoes); 
        vNrNumeroReducoes = vDsNumeroReducoes; 
      end else  if ((vModeloEcf == "ecfEpson")) {   
    }
   except     on E : Exception) ShowMessage(E.Message);
  }
}
}

//--------------------------------------------
 public int retornaContadoresECF( string vModeloEcf ) 
{
  string vmensagem;
   string  vmetodo;
   string    sdados;
   string  sdadosaux;
   string  vretorno;
   string  vdetalhe;
   string  vdsarquivo;
   string    vcro;
   string  vcrz;
   string  vcoo;
   string  vccf;
   string  vgnf;
   string  vcdc;
   string  vgrg;
   string  vdtredz;
   string  vhrredz  ;
    vStatus : Variant;
    F : TextFile;
{
     vMetodo = "uECF.retornaContadoresECF()"; 
     try      if ((vModeloEcf == "ecfBematech") | (vModeloEcf == 'ecfYanco')) {         //CRO       vCRO = ReplicateStr(' ', 4);
 //CRO       vCRO = ReplicateStr(' ', 4);
 //CRO       vCRO := ReplicateStr(' ', 4);
        Result = Bematech_FI_NumeroIntervencoes(vCRO); 
         if (retornoImpressoraErro(vModeloEcf, result)) return;
         if ( vCRO.Trim()= ") vCRO = "0'; 
        Result = Bematech_FI_NumeroReducoes(vCRZ); 
         if (retornoImpressoraErro(vModeloEcf, result)) return;
         if ( vCRZ.Trim()= ") vCRZ = "0'; 
        Result = Bematech_FI_NumeroCupom(vCOO); 
         if (retornoImpressoraErro(vModeloEcf, result)) return;
         if ( vCOO.Trim()= ") vCOO = "0'; 
        Result = Bematech_FI_ContadorCupomFiscalMFD(vCCF); 
         if (retornoImpressoraErro(vModeloEcf, result)) return;
         if ( vCCF.Trim()= ") vCCF = "0'; 
        Result = Bematech_FI_NumeroOperacoesNaoFiscais(vGNF); 
         if (retornoImpressoraErro(vModeloEcf, result)) return;
         if ( vGNF.Trim()= ") vGNF = "0'; 
        Result = Bematech_FI_ContadorComprovantesCreditoMFD(vCDC); 
         if (retornoImpressoraErro(vModeloEcf, result)) return;
         if ( vCDC.Trim()= ") vCDC = "0'; 
        Result = Bematech_FI_ContadorRelatoriosGerenciaisMFD(vGRG); 
         if (retornoImpressoraErro(vModeloEcf, result)) return;
         if ( vGRG.Trim()= ") vGRG = "0'; 
        vHrRedZ = ReplicateStr(" ", 6); 
        Result = Bematech_FI_DataHoraReducao(vDtRedZ, vHrRedZ); 
         if (retornoImpressoraErro(vModeloEcf, result)) return;
         vDsArquivo = '; 
        vDsArquivo = vDsArquivo + "CRO...:" + vCRO + sLineBreak; 
        vDsArquivo = vDsArquivo + "CRZ...:" + vCRZ + sLineBreak; 
        vDsArquivo = vDsArquivo + "COO...:" + vCOO + sLineBreak; 
        vDsArquivo = vDsArquivo + "GNF...:" + vGNF + sLineBreak; 
        vDsArquivo = vDsArquivo + "CCF...:" + vCCF + sLineBreak; 
        vDsArquivo = vDsArquivo + "GRG...:" + vGRG + sLineBreak; 
        vDsPath = getPathECF(); 
        AssignFile(F, vDsPath + "\\retornaContadoresECF.TXT") ; 
        Rewrite(F);
        Write(F, vDsArquivo);
        CloseFile(F);
         Result = 1; 
      end; else  if ((vModeloEcf == "ecfElgin")) {        Result = 1; 
      end; else  if ((vModeloEcf == "ecfInterway")then {        Result = 0; 
      end; else  if ((vModeloEcf == "ecfUrano")) {        Result = 0; 
      end; else  if ((vModeloEcf == "ecfDaruma")) {        Result = 1; 
      end; else  if ((vModeloEcf == "ecfSweda")) {        Result = 1; 
    }
   except     on E : Exception) ShowMessage(E.Message);
  }
}
