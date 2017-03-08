//---------------------
function getParam(pParams : String) : String;
//---------------------

    params
        piCdEmpresa : IN : Real;
        piDsOperacao : IN : String;
    endparams

    if (piCdEmpresa = "") then begin
        piCdEmpresa = $item("CD_EMPRESA", $$gParamGlb)
    end;

    //Parametros corporativo
    $xlpl$ = ""
    putitem $xlpl$, -1, "DS_SIGLA_EXTIPI"
    ADMSVCO001.GetLstParametro($xlpl$, $xlpl$, $xCdErro$, $xCtxerro$);
    if ($procerror) then begin
        SetStatus(<STS_ERRO>, $procerror, $procerrorcontext, "");
        return(-1)
    end else begin
        SetStatus(<STS_ERRO>, "GEN0001", "DESCRICAO=%%$item("DESCRICAO", $xCtxErro$);
        return(-1)
    end else begin
        return(-1)
    end;
    $dsSiglaExTipi$ = $item("DS_SIGLA_EXTIPI", $xlpl$)

    //Parametros por empresa
    $xlplemp$ = ""
    putitem $xlplemp$, -1, "IN_ESCRITURA_CIAP"
    putitem $xlplemp$, -1, "TP_CCUSTO_PAT"
    ADMSVCO001.GetParamEmpresa(piCdEmpresa, $xlplemp$, $xlplemp$, $xcderro$, $xctxerro$);
    if ($procerror) then begin
        SetStatus(<STS_ERRO>, $procerror, $procerrorcontext, "");
        return(-1)
    end else begin
        SetStatus(<STS_ERRO>, "GEN0001", "DESCRICAO=%%$item("DESCRICAO", $xCtxErro$);
        return(-1)
    end;
    $inEscrituraCiap$ = $item("IN_ESCRITURA_CIAP", $xlplemp$)
    $tpCCustoPat$ = $item("TP_CCUSTO_PAT" , $xlplemp$)

    return(0)

End // entry getParam


//-------------------------
function geraRegistro0150(pParams : String) : String;
//-------------------------

    params
        piCaminho :IN : String;
    endparams

    variables
        vCdEstado, vTam, vCont : Real;
        vDsConteudo, vStringConv, vStringAux, vCpfCnpj, vNumericAux, vIE : String;
        viParams, voParams, vGlbMunIBGE, vPesEndereco, vPais : String;
    endvariables

    vCont = 0

    GTT_PESSOAPISSVC.Clear();
    GTT_PESSOAPISSVC.Consultar(nil);
    if ($status >= 0) then begin
        GTT_PESSOAPISSVC.RecNo := -1;
        GTT_PESSOAPISSVC.IndexFieldsNames('CD_PESSOA.GTT_PESSOAPISSVC');
        GTT_PESSOAPISSVC.RecNo := 1;
        while ($status >= 0) do begin

            $nrLinha$ = $nrLinha$ + 1
            vCont = vCont + 1
            vDsConteudo = ""

            setDisplay("Gerando Arquivo EFD: %%DS_REGISTRO.GTT_EFDREGISTSVC - Linha: %%$nrLinha$", "", "");
            if ($procerror) then begin
                SetStatus(<STS_ERRO>, $xCdErro$, $xCtxErro$, "");
            end;

            if (CD_ESTADO.GTT_PESSOAPISSVC = "") then begin
                vPesEndereco = ""
                viParams = ""
                voParams = ""
                putitem/id viParams, "CD_PESSOA", CD_PESSOA.GTT_PESSOAPISSVC
                FISSVCO032.carregaEndereco($$gParamGlb, viParams, voParams, $xCdErro$, $xCtxerro$);
                if ($procerror) then begin
                    SetStatus(<STS_ERRO>, $procerror, $procerrorcontext, "");
                    return(-1)
                end else begin
                    SetStatus(<STS_ERRO>, $xCdErro$, $xCtxErro$, "");
                    return(-1)
                end;
                if (voParams != "") then begin
                    vPesEndereco = voParams
                end;
                    
                if (vPesEndereco != "") then begin
                    vCdEstado = ""
                    vCdEstado = $item("DS_ESTADO",vPesEndereco)
                    CD_MUNICIPIO.GTT_PESSOAPISSVC = $item("CD_MUNICIPIO",vPesEndereco)
                    CD_ESTADO.GTT_PESSOAPISSVC = $item("CD_ESTADO" ,vPesEndereco)
                    DS_ESTADO.GTT_PESSOAPISSVC = vCdEstado
                    DS_SIGLA.GTT_PESSOAPISSVC = $item("DS_SIGLA" ,vPesEndereco)
                end;
            end;

            //Texto fixo.
            vDsConteudo = "|0150"

            //Codigo de identificacao do participante no arquivo.
            convNumeric(CD_PESSOA.GTT_PESSOAPISSVC, 9, vStringConv)
            vDsConteudo = "%%vDsConteudo%%%|%%vStringConv"

            //Nome pessoal do participante.
            length $ltrim(NM_CLIENTE.GTT_PESSOAPISSVC, " ")
            vTam = $result
            substituiCaractereEspecial($ltrim(NM_CLIENTE.GTT_PESSOAPISSVC, "")
            vStringAux = "|%%vStringAux"
            vDsConteudo = "%%vDsConteudo%%vStringAux"

            //Codigo do país do participante.
            vPais = ""
            viParams = ""
            voParams = ""
            putitem/id viParams, "CD_ESTADO", CD_ESTADO.GTT_PESSOAPISSVC
            FISSVCO032.carregaPais($$gParamGlb, viParams, voParams, $xCdErro$, $xCtxerro$);
            if ($procerror) then begin
                SetStatus(<STS_ERRO>, $procerror, $procerrorcontext, "");
                return(-1)
            end else begin
                SetStatus(<STS_ERRO>, $xCdErro$, $xCtxErro$, "");
                return(-1)
            end;
            if (voParams != "") then begin
                vPais = voParams
            end;
            vNumericAux = $item("CD_PAISBCB",vPais)
            convNumeric(vNumericAux, 5, vStringConv)
            vDsConteudo = "%%vDsConteudo%%%|%%vStringConv"

            //CPF/CNPJ
            if (DS_SIGLA.GTT_PESSOAPISSVC != "EX") then begin
                if (TP_PESSOA.GTT_PESSOAPISSVC = "F") then begin

                    //CNPJ do participante.
                    vStringAux = "|"
                    vDsConteudo = "%%vDsConteudo%%vStringAux"

                    //CPF do participante.
                    vCpfCnpj = NR_CPF.GTT_PESSOAPISSVC
                    vCpfCnpj = $replace(vCpfCnpj, 1, ".","",-1)
                    vCpfCnpj = $replace(vCpfCnpj, 1, "/","",-1)
                    vCpfCnpj = $replace(vCpfCnpj, 1, "-","",-1)
                    convNumeric(vCpfCnpj, 11, vStringConv)
                    vDsConteudo = "%%vDsConteudo%%%|%%vStringConv"
                    
                    //Inscricao estadual do participante.
                    vStringAux = "|"
                    vDsConteudo = "%%vDsConteudo%%vStringAux"
                else
                    //CNPJ do participante.
                    vCpfCnpj = NR_CNPJ.GTT_PESSOAPISSVC
                    vCpfCnpj = $replace(vCpfCnpj, 1, ".","",-1)
                    vCpfCnpj = $replace(vCpfCnpj, 1, "/","",-1)
                    vCpfCnpj = $replace(vCpfCnpj, 1, "-","",-1)
                    convNumeric(vCpfCnpj, 14, vStringConv)
                    vDsConteudo = "%%vDsConteudo%%%|%%vStringConv"

                    //CPF do participante.
                    vStringAux = "|"
                    vDsConteudo = "%%vDsConteudo%%vStringAux"

                    //Inscricao estadual do participante.
                    if (NR_RGINSCR.GTT_PESSOAPISSVC = "ISENTO") then begin
                        vStringAux = "|"
                    else
                        vIE = NR_RGINSCR.GTT_PESSOAPISSVC
                        vIE = $replace(vIE, 1, ".","",-1)
                        vIE = $replace(vIE, 1, "/","",-1)
                        vIE = $replace(vIE, 1, "-","",-1)
                        vStringAux = "|%%vIE"
                    end;
                    vDsConteudo = "%%vDsConteudo%%vStringAux"
                end;
            else
                vStringAux = "|||"
                vDsConteudo = "%%vDsConteudo%%vStringAux"
            end;
                    
            //Codigo do municipio.
            vGlbMunIBGE = ""
            viParams = ""
            voParams = ""
            putitem/id viParams, "CD_ESTADO" , CD_ESTADO.GTT_PESSOAPISSVC
            putitem/id viParams, "CD_MUNICIPIO", CD_MUNICIPIO.GTT_PESSOAPISSVC
            FISSVCO032.carregaMunIBGE($$gParamGlb, viParams, voParams, $xCdErro$, $xCtxerro$);
            if ($procerror) then begin
                SetStatus(<STS_ERRO>, $procerror, $procerrorcontext, "");
                return(-1)
            end else begin
                SetStatus(<STS_ERRO>, $xCdErro$, $xCtxErro$, "");
                return(-1)
            end;
            if (voParams != "") then begin
                vGlbMunIBGE = voParams
            end;
                    
            vCdEstado = ""
            if (DS_SIGLA.GTT_PESSOAPISSVC = "RO") then begin
                //Roraima.
                vCdEstado = 11
            end else begin
                //Acre.
                vCdEstado = 12
            end else begin
                //Amazonas.
                vCdEstado = 13
            end else begin
                //Roraima.
                vCdEstado = 14
            end else begin
                //Para.
                vCdEstado = 15
            end else begin
                //Amapa.
                vCdEstado = 16
            end else begin
                //Tocantins.
                vCdEstado = 17
            end else begin
                //Maranhao.
                vCdEstado = 21
            end else begin
                //Piaui.
                vCdEstado = 22
            end else begin
                //Ceara.
                vCdEstado = 23
            end else begin
                //Rio grande do norte.
                vCdEstado = 24
            end else begin
                //Paraiba.
                vCdEstado = 25
            end else begin
                //Pernambuco.
                vCdEstado = 26
            end else begin
                //Alagoas.
                vCdEstado = 27
            end else begin
                //Sergipe.
                vCdEstado = 28
            end else begin
                //Bahia.
                vCdEstado = 29
            end else begin
                //Minas gerais.
                vCdEstado = 31
            end else begin
                //Espirito santo.
                vCdEstado = 32
            end else begin
                //Rio de janeiro.
                vCdEstado = 33
            end else begin
                //Sao paulo.
                vCdEstado = 35
            end else begin
                //Parana.
                vCdEstado = 41
            end else begin
                //Santa catarina.
                vCdEstado = 42
            end else begin
                //Rio grande do sul.
                vCdEstado = 43
            end else begin
                //Mato grosso do sul.
                vCdEstado = 50
            end else begin
                //Mato grosso.
                vCdEstado = 51
            end else begin
                //Goias.
                vCdEstado = 52
            end else begin
                //Distrito federal.
                vCdEstado = 53
            end;
                    
            if (DS_SIGLA.GTT_PESSOAPISSVC = "EX") then begin
                vStringConv = ""
                vDsConteudo = "%%vDsConteudo%%%|%%vStringConv"
            else
                convNumeric($item("CD_MUNICIPIOIBGE",vGlbMunIBGE)
                vStringConv = "%%vCdEstado%%vStringConv"
                vDsConteudo = "%%vDsConteudo%%%|%%vStringConv"
            end;

            //Numero de inscricao do participante no suframa.
            if (NR_SUFRAMA.GTT_PESSOAPISSVC != 0) then begin
                vStringConv = NR_SUFRAMA.GTT_PESSOAPISSVC
            else
                vStringConv = ""
            end;
            vDsConteudo = "%%vDsConteudo%%%|%%vStringConv"

            //Logradouro e endereco do imovel.
            converterString(DS_LOGRADOURO.GTT_PESSOAPISSVC,DS_LOGRADOURO.GTT_PESSOAPISSVC)
            vTam = $length(DS_LOGRADOURO.GTT_PESSOAPISSVC)
            if (vTam > 60) then begin
                vTam = 60
            end;
            if (vTam > 0) then begin
                vStringAux = DS_LOGRADOURO.GTT_PESSOAPISSVC
                convString("DS_LOGRADOURO.GTT_PESSOAPISSVC", vStringAux, vTam, vStringConv)
            else
                vStringConv = ""
            end;
            vDsConteudo = "%%vDsConteudo%%%|%%vStringConv"

            //Numero do imovel.
            vStringAux = "|%%NR_LOGRADOURO.GTT_PESSOAPISSVC"
            vDsConteudo = "%%vDsConteudo%%vStringAux"

            //Dados complementares do endereco.
            vStringAux = "|"
            vDsConteudo = "%%vDsConteudo%%vStringAux"

            //Bairro em que o imovel esta situado.
            vStringAux = "|%%nm_bairro.GTT_PESSOAPISSVC"
            vDsConteudo = "%%vDsConteudo%%vStringAux"

            //Marcador.
            vDsConteudo = "%%vDsConteudo%%%|%%^"

            filedump/append vDsConteudo, piCaminho

            GTT_PESSOAPISSVC.Delete();
            if ($status = 0) then begin
                $status = -1
            end;
        end;
    end;

    if (vCont > 0) then begin
        GTT_PISTOTALSVC.Clear();
        GTT_PISTOTALSVC.Append(-1);
        DS_REGISTRO.GTT_PISTOTALSVC = "0150"
        GTT_PISTOTALSVC.Consultar(nil);
        if ($status = -7) then begin
            GTT_PISTOTALSVC.Consultar(nil);
        end;
        QT_REGISTRO.GTT_PISTOTALSVC = QT_REGISTRO.GTT_PISTOTALSVC + vCont

        GTT_PISTOTALSVC.Salvar();
        if ($procerror) then begin
            SetStatus(<STS_ERRO>, $procerror, $procerrorcontext, "");
            return(-1)
        end else begin
            SetStatus(<STS_ERRO>, $xCdErro$, $xCtxErro$, "");
            return(-1)
        end;
    end;

    GTT_PESSOAPISSVC.Clear();

    return(0)

End // entry geraRegistro0150


//-------------------------
function geraRegistro0190(pParams : String) : String;
//-------------------------

    params
        piCaminho :IN : String;
    endparams

    variables
        vDsConteudo, vStringAux : String;
        vCont : Real;
    endvariables

    vCont = 0

    GTT_K01DS1SVC.Clear();
    GTT_K01DS1SVC.Consultar(nil);
    if ($status >= 0) then begin
        GTT_K01DS1SVC.RecNo := -1;
        GTT_K01DS1SVC.IndexFieldsNames('DS_CHAVE01.GTT_K01DS1SVC');
        GTT_K01DS1SVC.RecNo := 1;
        while ($status >= 0) do begin

            $nrLinha$ = $nrLinha$ + 1
            vCont = vCont + 1
            vDsConteudo = ""

            setDisplay("Gerando Arquivo EFD: %%DS_REGISTRO.GTT_EFDREGISTSVC - Linha: %%$nrLinha$", "", "");
            if ($procerror) then begin
                SetStatus(<STS_ERRO>, $xCdErro$, $xCtxErro$, "");
            end;

            //Texto fixo.
            vDsConteudo = "|0190"
    
            //Código da unidade de medida
            vStringAux = "|%%DS_CHAVE01.GTT_K01DS1SVC"
            vDsConteudo = "%%vDsConteudo%%vStringAux"

            //Descrição da unidade de medida
            PRD_TIPOESPECSVC.Clear();
            CD_ESPECIE.PRD_TIPOESPECSVC/init = DS_CHAVE01.GTT_K01DS1SVC
            PRD_TIPOESPECSVC.Consultar(nil);
            if ($status < 0) then begin
                PRD_TIPOESPECSVC.Clear();
            end;
            vStringAux = "|%%DS_ESPECIE.PRD_TIPOESPECSVC"
            vDsConteudo = "%%vDsConteudo%%vStringAux"

            //Marcador.
            vDsConteudo = "%%vDsConteudo%%%|%%^"

            filedump/append vDsConteudo, piCaminho

            GTT_K01DS1SVC.Delete();
            if ($status = 0) then begin
                $status = -1
            end;
        end;
    end;

    if (vCont > 0) then begin
        GTT_PISTOTALSVC.Clear();
        GTT_PISTOTALSVC.Append(-1);
        DS_REGISTRO.GTT_PISTOTALSVC = "0190"
        GTT_PISTOTALSVC.Consultar(nil);
        if ($status = -7) then begin
            GTT_PISTOTALSVC.Consultar(nil);
        end;
        QT_REGISTRO.GTT_PISTOTALSVC = QT_REGISTRO.GTT_PISTOTALSVC + vCont

        GTT_PISTOTALSVC.Salvar();
        if ($procerror) then begin
            SetStatus(<STS_ERRO>, $procerror, $procerrorcontext, "");
            return(-1)
        end else begin
            SetStatus(<STS_ERRO>, $xCdErro$, $xCtxErro$, "");
            return(-1)
        end;
    end;

    GTT_K01DS1SVC.Clear();

    return(0)

End // entry geraRegistro0190


//-------------------------
function geraRegistro0200(pParams : String) : String;
//-------------------------

    params
        piCaminho :IN : String;
    endparams

    variables
        vDsConteudo, vStringConv, vStringAux, vTipo, viParams, voParams : String;
        vCont : Real;
    endvariables

    vCont = 0
    GTT_PISTOTALSVC.Clear();

    GTT_K02NR1DS1SVC.Clear();
    GTT_K02NR1DS1SVC.Consultar(nil);
    if ($status >= 0) then begin
        GTT_K02NR1DS1SVC.RecNo := -1;
        GTT_K02NR1DS1SVC.IndexFieldsNames('DS_CHAVE02.GTT_K02NR1DS1SVC');
        GTT_K02NR1DS1SVC.RecNo := 1;
        while ($status >= 0) do begin

            $nrLinha$ = $nrLinha$ + 1
            vCont = vCont + 1
            vDsConteudo = ""

            setDisplay("Gerando Arquivo EFD: %%DS_REGISTRO.GTT_EFDREGISTSVC - Linha: %%$nrLinha$", "", "");
            if ($procerror) then begin
                SetStatus(<STS_ERRO>, $xCdErro$, $xCtxErro$, "");
            end;

            //Texto fixo.
            vDsConteudo = "|0200"

            //Codigo do item.
            vStringAux = DS_CHAVE02.GTT_K02NR1DS1SVC
            vDsConteudo = "%%vDsConteudo%%%|%%vStringAux"

            //Descricao do item.
            converterString(DS_GERAL01.GTT_K02NR1DS1SVC,vStringConv)
            vDsConteudo = "%%vDsConteudo%%%|%%vStringConv"

            //Representacao alfanumerico do codigo de barra.
            vStringAux = "|"
            vDsConteudo = "%%vDsConteudo%%vStringAux"

            //Codigo anterior do item.
            vStringAux = "|"
            vDsConteudo = "%%vDsConteudo%%vStringAux"

            //Unidade de medida.
            vStringAux = "|%%DS_GERAL02.GTT_K02NR1DS1SVC"
            vDsConteudo = "%%vDsConteudo%%vStringAux"

            //Tipo do item.
            vTipo = ""
            if (DS_CHAVE02.GTT_K02NR1DS1SVC = "") then begin
                vTipo = "09"
            else
                viParams = ""
                voParams = ""
                putitem/id viParams, "CD_EMPRESA", NR_CHAVE01.GTT_K02NR1DS1SVC
                putitem/id viParams, "CD_PRODUTO", DS_CHAVE02.GTT_K02NR1DS1SVC
                PRDSVCO008.buscaDadosFilial($xlpg$, viParams, voParams, $xCdErro$, $xCtxErro$);
                if ($procerror) then begin
                    SetStatus(<STS_ERRO>, $procerror, $procerrorcontext, "");
                    return(-1)
                end;
                if (voParams != "") then begin
                    if ($item("IN_PRODACABADO",voParams) then begin
                        vTipo = "04"
                    end else begin
                        vTipo = "01"
                    end else begin
                        vTipo = "07"
                    end else begin
                        vTipo = "08"
                    else
                        vTipo = "99"
                    end;
                else
                    vTipo = "99"
                end;
            end;
            vStringAux = "|%%vTipo"
            vDsConteudo = "%%vDsConteudo%%vStringAux"

            //Codigo da nomeclatura comum do mercosul.
            if (DS_GERAL02.GTT_K02NR1DS1SVC = "SVC") then begin
                vStringAux = ""
                vStringConv = ""
            else
                vStringAux = DS_GERAL03.GTT_K02NR1DS1SVC
                vStringAux = $replace(vStringAux, 1, ".","",-1)
                vStringAux = $replace(vStringAux, 1, " ","",-1)
                convNumeric(vStringAux[1:8], 8, vStringConv)
            end;
            vDsConteudo = "%%vDsConteudo%%%|%%vStringConv"

            //Codigo EX, conforme a TIPI.
            if (DS_GERAL03.GTT_K02NR1DS1SVC[9:2] != "") then begin
                vDsConteudo = "%%vDsConteudo%%%|%%vStringAux[9:2]"
            else
                vStringAux = ""
                vDsConteudo = "%%vDsConteudo%%%|%%vStringAux"
            end;

            //Codigo do genero do item.
            convNumeric(DS_GERAL03.GTT_K02NR1DS1SVC[1:2], 2, vStringConv)
            if (vStringConv = "00") then begin
                vStringConv = ""
            end;
            vDsConteudo = "%%vDsConteudo%%%|%%vStringConv"

            //Codigo do servico.
            vStringAux = "|"
            vDsConteudo = "%%vDsConteudo%%vStringAux"

            //Aliquota de ICMS aplicavel ao item.
            vStringAux = "|"
            vDsConteudo = "%%vDsConteudo%%vStringAux"

            //Marcador.
            vDsConteudo = "%%vDsConteudo%%%|%%^"

            filedump/append vDsConteudo, piCaminho

            geraRegistro0220(piCaminho)
            if ($procerror) then begin
                setStatus(<STS_ERRO>, $procerror, $procerrorcontext, "");
                return(-1)
            end else begin
                SetStatus(<STS_ERRO>, $xCdErro$, $xCtxErro$, "");
                return(-1)
            end;

            GTT_K02NR1DS1SVC.Delete();
            if ($status = 0) then begin
                $status = -1
            end;
        end;
    end;

    if (vCont > 0) then begin
        GTT_PISTOTALSVC.Append(-1);
        DS_REGISTRO.GTT_PISTOTALSVC = "0200"
        GTT_PISTOTALSVC.Consultar(nil);
        if ($status = -7) then begin
            GTT_PISTOTALSVC.Consultar(nil);
        end;
        QT_REGISTRO.GTT_PISTOTALSVC = QT_REGISTRO.GTT_PISTOTALSVC + vCont

        GTT_PISTOTALSVC.Salvar();
        if ($procerror) then begin
            SetStatus(<STS_ERRO>, $procerror, $procerrorcontext, "");
            return(-1)
        end else begin
            SetStatus(<STS_ERRO>, $xCdErro$, $xCtxErro$, "");
            return(-1)
        end;
    end;

    GTT_K02NR1DS1SVC.Clear();

    return(0)

End // entry geraRegistro0200


//-------------------------
function geraRegistro0220(pParams : String) : String;
//-------------------------

    params
        piCaminho :IN : String;
    endparams

    variables
        vDsConteudo, vStringConv, vStringAux, vNumericAux : String;
    endvariables

    if (DS_CHAVE02.GTT_K02NR1DS1SVC = "") then begin
        return(0)
    end;

    GTT_DS01SVC.Clear();
    NR_GERAL.GTT_DS01SVC/init = DS_CHAVE02.GTT_K02NR1DS1SVC
    GTT_DS01SVC.Consultar(nil);
    if ($status >= 0) then begin
        GTT_DS01SVC.RecNo := 1;
        while ($status >= 0) do begin

            $nrLinha$ = $nrLinha$ + 1
            vDsConteudo = ""

            setDisplay("Gerando Arquivo EFD: %%DS_REGISTRO.GTT_EFDREGISTSVC - Linha: %%$nrLinha$", "", "");
            if ($procerror) then begin
                SetStatus(<STS_ERRO>, $xCdErro$, $xCtxErro$, "");
            end;

            //Texto fixo.
            vDsConteudo = "|0220"

            //Unidade a ser convertida na unidade de estoque
            converterString(DS_GERAL.GTT_DS01SVC,vStringConv)
            vDsConteudo = "%%vDsConteudo%%%|%%vStringConv"

            //Fator de conversão
            vNumericAux = QT_CONVERSAO.GTT_DS01SVC
            editarNr(8, 6, vNumericAux, vNumericAux)
            convValorString(6,vNumericAux, vStringConv)
            vDsConteudo = "%%vDsConteudo%%%|%%vStringConv"

            //Marcador
            vDsConteudo = "%%vDsConteudo%%%|%%^"

            filedump/append vDsConteudo, piCaminho

            GTT_PISTOTALSVC.Append(-1);
            DS_REGISTRO.GTT_PISTOTALSVC = "0220"
            GTT_PISTOTALSVC.Consultar(nil);
            if ($status = -7) then begin
                GTT_PISTOTALSVC.Consultar(nil);
            end;
            QT_REGISTRO.GTT_PISTOTALSVC = QT_REGISTRO.GTT_PISTOTALSVC + 1
    
            GTT_DS01SVC.RecNo :=  $curocc(GTT_DS01SVC) + 1;.RecNo
        end;
    end;

    return(0)

End // entry geraRegistro0220


//-------------------------
function geraRegistro0300(pParams : String) : String;
//-------------------------

    params
        piCaminho :IN : String;
    endparams

    variables
        vDsConteudo, vStringAux : String;
        vCont : Real;
    endvariables

    if ($inEscrituraCiap$ != 1) then begin
        return(0)
    end;

    vCont = 0
    GTT_PISTOTALSVC.Clear();

    GTT_NR4DS6SVC.Clear();
    GTT_NR4DS6SVC.Consultar(nil);
    if ($status >= 0) then begin
        GTT_NR4DS6SVC.RecNo := -1;
        GTT_NR4DS6SVC.IndexFieldsNames('DS_CHAVE.GTT_NR4DS6SVC');
        GTT_NR4DS6SVC.RecNo := 1;
        while ($status >= 0) do begin

            $nrLinha$ = $nrLinha$ + 1
            vCont = vCont + 1
            vDsConteudo = ""

            setDisplay("Gerando Arquivo EFD: %%DS_REGISTRO.GTT_EFDREGISTSVC - Linha: %%$nrLinha$", "", "");
            if ($procerror) then begin
                SetStatus(<STS_ERRO>, $xCdErro$, $xCtxErro$, "");
            end;

            //Texto fixo.
            vDsConteudo = "|0300"

            //Código individualizado do bem
            vStringAux = "%%DS_CHAVE.GTT_NR4DS6SVC"
            vDsConteudo = "%%vDsConteudo%%%|%%vStringAux"

            //Identificação do tipo de mercadoria (1=bem | 2=componente)
            vStringAux = "%%DS_GERAL02.GTT_NR4DS6SVC"
            vDsConteudo = "%%vDsConteudo%%%|%%vStringAux"

            //Descrição do bem
            converterString(DS_GERAL03.GTT_NR4DS6SVC,vStringAux)
            vDsConteudo = "%%vDsConteudo%%%|%%vStringAux"

            //Código de cadastro do bem principal
            vStringAux = "%%DS_GERAL04.GTT_NR4DS6SVC"
            vDsConteudo = "%%vDsConteudo%%%|%%vStringAux"

            //Código da conta analítica de contabilização do bem
            vStringAux = "%%DS_GERAL05.GTT_NR4DS6SVC"
            vDsConteudo = "%%vDsConteudo%%%|%%vStringAux"

            //Número total de parcelas a serem apropriadas
            vStringAux = "%%NR_GERAL02.GTT_NR4DS6SVC"
            vDsConteudo = "%%vDsConteudo%%%|%%vStringAux"

            //Marcador.
            vDsConteudo = "%%vDsConteudo%%%|%%^"

            filedump/append vDsConteudo, piCaminho

            if (DS_GERAL02.GTT_NR4DS6SVC = "1") then begin
                geraRegistro0305(piCaminho)
                if ($procerror) then begin
                    setStatus(<STS_ERRO>, $procerror, $procerrorcontext, "");
                    return(-1)
                end else begin
                    SetStatus(<STS_ERRO>, $xCdErro$, $xCtxErro$, "");
                    return(-1)
                end;
            end;

            GTT_NR4DS6SVC.Delete();
            if ($status = 0) then begin
                $status = -1
            end;
        end;
    end;

    if (vCont > 0) then begin
        GTT_PISTOTALSVC.Append(-1);
        DS_REGISTRO.GTT_PISTOTALSVC = "0300"
        GTT_PISTOTALSVC.Consultar(nil);
        if ($status = -7) then begin
            GTT_PISTOTALSVC.Consultar(nil);
        end;
        QT_REGISTRO.GTT_PISTOTALSVC = QT_REGISTRO.GTT_PISTOTALSVC + vCont

        GTT_PISTOTALSVC.Salvar();
        if ($procerror) then begin
            SetStatus(<STS_ERRO>, $procerror, $procerrorcontext, "");
            return(-1)
        end else begin
            SetStatus(<STS_ERRO>, $xCdErro$, $xCtxErro$, "");
            return(-1)
        end;
    end;

    GTT_NR4DS6SVC.Clear();

    return(0)

End // entry geraRegistro0300


//-------------------------
function geraRegistro0305(pParams : String) : String;
//-------------------------

    params
        piCaminho :IN : String;
    endparams

    variables
        vNaturezaComercialEmp : Real;
        vDsConteudo, vStringAux, vNumericAux, viParams, voParams : String;
    endvariables

    if (DS_GERAL01.GTT_NR4DS6SVC = "") then begin
        return(0)
    end;
    
    PAT_IMOBINFOSVC.Clear();
    CD_PRODUTO.PAT_IMOBINFOSVC/init = DS_GERAL01.GTT_NR4DS6SVC
    NR_SEQUENCIA.PAT_IMOBINFOSVC/init = NR_GERAL01.GTT_NR4DS6SVC
    PAT_IMOBINFOSVC.Consultar(nil);
    if ($status >= 0) then begin

        $nrLinha$ = $nrLinha$ + 1
        vDsConteudo = ""

        setDisplay("Gerando Arquivo EFD: %%DS_REGISTRO.GTT_EFDREGISTSVC - Linha: %%$nrLinha$", "", "");
        if ($procerror) then begin
            SetStatus(<STS_ERRO>, $xCdErro$, $xCtxErro$, "");
        end;

        PAT_IMOBINFOSVC.IndexFieldsNames('PR_PARTICIPACAO.PAT_IMOBINFOSVC desc');
        PAT_IMOBINFOSVC.RecNo := 1;
    
        //Texto fixo.
        vDsConteudo = "|0305"

        //Código do centro de custo
        if ($tpCCustoPat$ = 2) then begin
            vDsConteudo = "%%vDsConteudo%%%|%%CD_CCUSTO.PAT_IMOBINFOSVC"
        else
            vStringAux = ""
            if (TP_AREA.PAT_IMOBINFOSVC = 2) then begin
                vStringAux = "1"
            end else begin
                vStringAux = "4"
            end else begin
                vStringAux = "3"
            end else begin
        
                viParams = ""
                putitem viParams, -1, "NATUREZA_COMERCIAL_EMP"
                ADMSVCO001.GetParamEmpresa(CD_EMPRESA.PAT_IMOBINFOSVC, viParams, voParams, $xcderro$, $xctxerro$);
                if ($procerror) then begin
                    SetStatus(<STS_ERRO>, $procerror, $procerrorcontext, "");
                    return(-1)
                end else begin
                    SetStatus(<STS_ERRO>, $xCdErro$, $xCtxErro$, "");
                    return(-1)
                end;
                vNaturezaComercialEmp = $item("NATUREZA_COMERCIAL_EMP", voParams)

                if (vNaturezaComercialEmp = 2 | vNaturezaComercialEmp = 3) then begin
                    vStringAux = "2"
                else
                    vStringAux = "5"
                end;
            end;
            vDsConteudo = "%%vDsConteudo%%%|%%vStringAux"
        end;
    
        //Descrição da função do bem
        converterString(DS_FUNCAO.PAT_IMOBINFOSVC,vStringAux)
        vDsConteudo = "%%vDsConteudo%%%|%%vStringAux"

        //Vida útil estimada do bem, em número de meses
        vNumericAux = NR_GERAL03.GTT_NR4DS6SVC * 12
        convNumeric(vNumericAux, 3, vStringAux)
        vDsConteudo = "%%vDsConteudo%%%|%%vStringAux"

        //Marcador.
        vDsConteudo = "%%vDsConteudo%%%|%%^"

        filedump/append vDsConteudo, piCaminho

        GTT_PISTOTALSVC.Append(-1);
        DS_REGISTRO.GTT_PISTOTALSVC = "0305"
        GTT_PISTOTALSVC.Consultar(nil);
        if ($status = -7) then begin
            GTT_PISTOTALSVC.Consultar(nil);
        end;
        QT_REGISTRO.GTT_PISTOTALSVC = QT_REGISTRO.GTT_PISTOTALSVC + 1
    end;

    return(0)

End // entry geraRegistro0305


//-------------------------
function geraRegistro0400(pParams : String) : String;
//-------------------------

    params
        piCaminho :IN : String;
    endparams

    variables
        vDsConteudo, vStringAux : String;
        vCont : Real;
    endvariables

    vCont = 0

    GTT_K02NRSVC.Clear();
    GTT_K02NRSVC.Consultar(nil);
    if ($status >= 0) then begin
        GTT_K02NRSVC.RecNo := -1;
        GTT_K02NRSVC.IndexFieldsNames('NR_CHAVE01.GTT_K02NRSVC');
        GTT_K02NRSVC.RecNo := 1;
        while ($status >= 0) do begin

            $nrLinha$ = $nrLinha$ + 1
            vCont = vCont + 1
            vDsConteudo = ""

            setDisplay("Gerando Arquivo EFD: %%DS_REGISTRO.GTT_EFDREGISTSVC - Linha: %%$nrLinha$", "", "");
            if ($procerror) then begin
                SetStatus(<STS_ERRO>, $xCdErro$, $xCtxErro$, "");
            end;

            //Texto fixo.
            vDsConteudo = "|0400"
    
            //Código da natureza da operação/prestação
            vStringAux = "|%%NR_CHAVE01.GTT_K02NRSVC"
            vDsConteudo = "%%vDsConteudo%%vStringAux"

            //Descrição da natureza da operação/prestação
            FIS_CFOPSVC.Clear();
            CD_CFOP.FIS_CFOPSVC/init = NR_CHAVE01.GTT_K02NRSVC
            FIS_CFOPSVC.Consultar(nil);
            if ($status < 0) then begin
                FIS_CFOPSVC.Clear();
            end;
            vStringAux = DS_CFOP.FIS_CFOPSVC
            vDsConteudo = "%%vDsConteudo%%%|%%vStringAux"

            //Marcador.
            vDsConteudo = "%%vDsConteudo%%%|%%^"

            filedump/append vDsConteudo, piCaminho

            GTT_K02NRSVC.Delete();
            if ($status = 0) then begin
                $status = -1
            end;
        end;
    end;

    if (vCont > 0) then begin
        GTT_PISTOTALSVC.Clear();
        GTT_PISTOTALSVC.Append(-1);
        DS_REGISTRO.GTT_PISTOTALSVC = "0400"
        GTT_PISTOTALSVC.Consultar(nil);
        if ($status = -7) then begin
            GTT_PISTOTALSVC.Consultar(nil);
        end;
        QT_REGISTRO.GTT_PISTOTALSVC = QT_REGISTRO.GTT_PISTOTALSVC + vCont

        GTT_PISTOTALSVC.Salvar();
        if ($procerror) then begin
            SetStatus(<STS_ERRO>, $procerror, $procerrorcontext, "");
            return(-1)
        end else begin
            SetStatus(<STS_ERRO>, $xCdErro$, $xCtxErro$, "");
            return(-1)
        end;
    end;

    GTT_K02NRSVC.Clear();

    return(0)

End // entry geraRegistro0400


//-------------------------
function geraRegistro0450(pParams : String) : String;
//-------------------------

    params
        piCaminho :IN : String;
    endparams

    variables
        vDsConteudo, vStringAux : String;
        vCont : Real;
    endvariables

    vCont = 0

    GTT_OBSNFSVC.Clear();
    TP_OBSNF.GTT_OBSNFSVC/init = 1 // Informação complementar
    GTT_OBSNFSVC.Consultar(nil);
    if ($status >= 0) then begin
        GTT_OBSNFSVC.RecNo := -1;
        GTT_OBSNFSVC", "NR_SEQUENCIA.GTT_OBSNFSVC".IndexFieldsNames('rt/e ');
        GTT_OBSNFSVC.RecNo :=  1;
        while ($status >= 0) do begin

            $nrLinha$ = $nrLinha$ + 1
            vCont = vCont + 1
            vDsConteudo = ""

            setDisplay("Gerando Arquivo EFD: %%DS_REGISTRO.GTT_EFDREGISTSVC - Linha: %%$nrLinha$", "", "");
            if ($procerror) then begin
                SetStatus(<STS_ERRO>, $xCdErro$, $xCtxErro$, "");
            end;

            //Texto fixo.
            vDsConteudo = "|0450"

            //Código da informação complementar do documento fiscal.
            vStringAux = "|%%NR_SEQUENCIA.GTT_OBSNFSVC"
            vDsConteudo = "%%vDsConteudo%%vStringAux"

            //Texto livre da informação complementar existente no documento fiscal.
            vStringAux = "|%%DS_OBSNF.GTT_OBSNFSVC"
            vDsConteudo = "%%vDsConteudo%%vStringAux"

            //Marcador.
            vDsConteudo = "%%vDsConteudo%%%|%%^"

            filedump/append vDsConteudo, piCaminho

            GTT_OBSNFSVC.Delete();
            if ($status = 0) then begin
                $status = -1
            end;
        end;
    end;

    if (vCont > 0) then begin
        GTT_PISTOTALSVC.Clear();
        GTT_PISTOTALSVC.Append(-1);
        DS_REGISTRO.GTT_PISTOTALSVC = "0450"
        GTT_PISTOTALSVC.Consultar(nil);
        if ($status = -7) then begin
            GTT_PISTOTALSVC.Consultar(nil);
        end;
        QT_REGISTRO.GTT_PISTOTALSVC = QT_REGISTRO.GTT_PISTOTALSVC + vCont

        GTT_PISTOTALSVC.Salvar();
        if ($procerror) then begin
            SetStatus(<STS_ERRO>, $procerror, $procerrorcontext, "");
            return(-1)
        end else begin
            SetStatus(<STS_ERRO>, $xCdErro$, $xCtxErro$, "");
            return(-1)
        end;
    end;

    GTT_OBSNFSVC.Clear();

    return(0)

End // entry geraRegistro0450


//-------------------------
function geraRegistro0460(pParams : String) : String;
//-------------------------

    params
        piCaminho :IN : String;
    endparams

    variables
        vDsConteudo, vStringAux : String;
        vCont : Real;
    endvariables

    vCont = 0

    GTT_OBSNFSVC.Clear();
    TP_OBSNF.GTT_OBSNFSVC/init = 2 // Obs. Fisco
    GTT_OBSNFSVC.Consultar(nil);
    if ($status >= 0) then begin
        GTT_OBSNFSVC.RecNo := -1;
        GTT_OBSNFSVC", "NR_SEQUENCIA.GTT_OBSNFSVC".IndexFieldsNames('rt/e ');
        GTT_OBSNFSVC.RecNo :=  1;
        while ($status >= 0) do begin

            $nrLinha$ = $nrLinha$ + 1
            vCont = vCont + 1
            vDsConteudo = ""

            setDisplay("Gerando Arquivo EFD: %%DS_REGISTRO.GTT_EFDREGISTSVC - Linha: %%$nrLinha$", "", "");
            if ($procerror) then begin
                SetStatus(<STS_ERRO>, $xCdErro$, $xCtxErro$, "");
            end;

            //Texto fixo.
            vDsConteudo = "|0460"

            //Código da Observação do lançamento fiscal
            vStringAux = "|%%NR_SEQUENCIA.GTT_OBSNFSVC"
            vDsConteudo = "%%vDsConteudo%%vStringAux"

            //Descrição da observação vinculada ao lançamento fiscal
            vStringAux = "|%%DS_OBSNF.GTT_OBSNFSVC"
            vDsConteudo = "%%vDsConteudo%%vStringAux"

            //Marcador.
            vDsConteudo = "%%vDsConteudo%%%|%%^"

            filedump/append vDsConteudo, piCaminho

            GTT_OBSNFSVC.Delete();
            if ($status = 0) then begin
                $status = -1
            end;
        end;
    end;

    if (vCont > 0) then begin
        GTT_PISTOTALSVC.Clear();
        GTT_PISTOTALSVC.Append(-1);
        DS_REGISTRO.GTT_PISTOTALSVC = "0460"
        GTT_PISTOTALSVC.Consultar(nil);
        if ($status = -7) then begin
            GTT_PISTOTALSVC.Consultar(nil);
        end;
        QT_REGISTRO.GTT_PISTOTALSVC = QT_REGISTRO.GTT_PISTOTALSVC + vCont

        GTT_PISTOTALSVC.Salvar();
        if ($procerror) then begin
            SetStatus(<STS_ERRO>, $procerror, $procerrorcontext, "");
            return(-1)
        end else begin
            SetStatus(<STS_ERRO>, $xCdErro$, $xCtxErro$, "");
            return(-1)
        end;
    end;

    GTT_OBSNFSVC.Clear();

    return(0)

End // entry geraRegistro0460


//-------------------------
function geraRegistro0990(pParams : String) : String;
//-------------------------

    params
        piCaminho: IN : String;
    endparams

    variables
        vTotalReg : Real;
        vDsConteudo : String;
    endvariables

    $nrLinha$ = $nrLinha$ + 1
    vTotalReg = 0
    vDsConteudo = ""

    setDisplay("Gerando Arquivo EFD: %%DS_REGISTRO.GTT_EFDREGISTSVC - Linha: %%$nrLinha$", "", "");
    if ($procerror) then begin
        SetStatus(<STS_ERRO>, $xCdErro$, $xCtxErro$, "");
    end;

    //Texto fixo.
    vDsConteudo = "|0990"

    //Quantidade total de linhas do Bloco 0.
    GTT_PISTOTALSVC.Clear();
    DS_REGISTRO.GTT_PISTOTALSVC/init = "0·*"
    GTT_PISTOTALSVC.Consultar(nil);
    if ($status >= 0) then begin
        GTT_PISTOTALSVC.RecNo :=  1;
        while ($status >= 0) do begin
            vTotalReg = vTotalReg + QT_REGISTRO.GTT_PISTOTALSVC
            GTT_PISTOTALSVC.RecNo
        end;
        GTT_PISTOTALSVC.Clear();
    end;

    vDsConteudo = "%%vDsConteudo|%%vTotalReg"
    vDsConteudo = "%%vDsConteudo%%%|%%^"

    filedump/append vDsConteudo, piCaminho

    return(0)

End // entry geraRegistro0990


//-------------------------------
function gerarEFDBloco9(pParams : String) : String;
//-------------------------------

    params
        poCdErro :OUT : Real;
        poCtxErro :OUT : String;
        piCaminho :IN : String;
    endparams

    //Abertura do bloco 9
    gerarEFDBloco9Reg9001($xCdErro$,$xCtxErro$,piCaminho)
    if ($procerror) then begin
        setStatus(<STS_ERRO>, $procerror, $procerrorcontext, "");
        poCdErro = $xCdErro$
        poCtxErro = $xCtxErro$
        return(-1)
    end else begin
        SetStatus(<STS_ERRO>, $xCdErro$, $xCtxErro$, "");
        poCdErro = $xCdErro$
        poCtxErro = $xCtxErro$
        return(-1)
    end;

    //Registros do arquivo
    gerarEFDBloco9Reg9900($xCdErro$,$xCtxErro$,piCaminho)
    if ($procerror) then begin
        setStatus(<STS_ERRO>, $procerror, $procerrorcontext, "");
        poCdErro = $xCdErro$
        poCtxErro = $xCtxErro$
        return(-1)
    end else begin
        SetStatus(<STS_ERRO>, $xCdErro$, $xCtxErro$, "");
        poCdErro = $xCdErro$
        poCtxErro = $xCtxErro$
        return(-1)
    end;

    //Encerramento do bloco 9
    gerarEFDBloco9Reg9990($xCdErro$,$xCtxErro$,piCaminho)
    if ($procerror) then begin
        setStatus(<STS_ERRO>, $procerror, $procerrorcontext, "");
        poCdErro = $xCdErro$
        poCtxErro = $xCtxErro$
        return(-1)
    end else begin
        SetStatus(<STS_ERRO>, $xCdErro$, $xCtxErro$, "");
        poCdErro = $xCdErro$
        poCtxErro = $xCtxErro$
        return(-1)
    end;

    //Encerramento do Arquivo Digital
    gerarEFDBloco9Reg9999($xCdErro$,$xCtxErro$,piCaminho)
    if ($procerror) then begin
        setStatus(<STS_ERRO>, $procerror, $procerrorcontext, "");
        poCdErro = $xCdErro$
        poCtxErro = $xCtxErro$
        return(-1)
    end else begin
        SetStatus(<STS_ERRO>, $xCdErro$, $xCtxErro$, "");
        poCdErro = $xCdErro$
        poCtxErro = $xCtxErro$
        return(-1)
    end;
    
    return(0)

End // entry gerarEFDBloco9


//-------------------------------
function gerarEFDBloco9Reg9001(pParams : String) : String;
//-------------------------------

    params
        poCdErro :OUT : Real;
        poCtxErro :OUT : String;
        piCaminho :IN : String;
    endparams
    
    variables
        vDsConteudo, vStringAux : String;
    endvariables
    
    setDisplay("Gerando EFD: Bloco 9 - registro 9001", "", "");
    if ($procerror) then begin
        SetStatus(<STS_ERRO>, $xCdErro$, $xCtxErro$, "");
        poCdErro = $xCdErro$
        poCtxErro = $xCtxErro$
    end;
    vDsConteudo = ""

    //Texto fixo.
    vDsConteudo = "|9001"

    //Indicador de movimento.
    vStringAux = "|0"
    vDsConteudo = "%%vDsConteudo%%vStringAux"

    //Marcador.
    vDsConteudo = "%%vDsConteudo%%%|%%^"

    filedump/append vDsConteudo, piCaminho
    
    return(0)

End // entry gerarEFDBloco9Reg9001


//-------------------------------
function gerarEFDBloco9Reg9900(pParams : String) : String;
//-------------------------------

    params
        poCdErro :OUT : Real;
        poCtxErro :OUT : String;
        piCaminho :IN : String;
    endparams
    
    variables
        vCont : Real;
        vDsConteudo, vStringAux, vDsReg1 : String;
    endvariables

    vDsReg1 = ""
    vCont = 0

    GTT_PISTOTALSVC.Clear();
    GTT_PISTOTALSVC.Consultar(nil);
    if ($status >= 0) then begin
        GTT_PISTOTALSVC.RecNo := -1;
        GTT_PISTOTALSVC.IndexFieldsNames('DS_REGISTRO.GTT_PISTOTALSVC');
        GTT_PISTOTALSVC.RecNo := 1;
        while ($status >= 0) do begin

            setDisplay("Gerando EFD: Bloco 9 - registro 9900", "", "");
            if ($procerror) then begin
                SetStatus(<STS_ERRO>, $xCdErro$, $xCtxErro$, "");
                poCdErro = $xCdErro$
                poCtxErro = $xCtxErro$
            end;

            vDsConteudo = ""
            vCont = vCont + 1

            //Texto fixo.
            vDsConteudo = "|9900"

            //Registro que será totalizado
            vStringAux = DS_REGISTRO.GTT_PISTOTALSVC
            vDsConteudo = "%%vDsConteudo%%%|%%vStringAux"

            //Total de registros do tipo informado
            vStringAux = QT_REGISTRO.GTT_PISTOTALSVC
            vDsConteudo = "%%vDsConteudo%%%|%%vStringAux"

            //Marcador.
            vDsConteudo = "%%vDsConteudo%%%|%%^"

            if (DS_REGISTRO.GTT_PISTOTALSVC[1:1] = "1") then begin
                if (vDsReg1 = "") then begin
                    vDsReg1 = vDsConteudo
                else
                    vDsReg1 = "%%vDsReg1%%vDsConteudo"
                end;
            else
                filedump/append vDsConteudo, piCaminho
            end;

            GTT_PISTOTALSVC.RecNo
        end;
    end;

    if (vDsReg1 != "") then begin
        filedump/append vDsReg1, piCaminho
    end;

    GTT_PISTOTALSVC.Clear();
    vCont = vCont + 4

    //Registro 9001
    vDsConteudo = ""
    //Texto fixo.
    vDsConteudo = "|9900"
    //Registro que será totalizado
    vStringAux = "9001"
    vDsConteudo = "%%vDsConteudo%%%|%%vStringAux"
    //Total de registros do tipo informado
    vStringAux = 1
    vDsConteudo = "%%vDsConteudo%%%|%%vStringAux"
    //Marcador.
    vDsConteudo = "%%vDsConteudo%%%|%%^"
    filedump/append vDsConteudo, piCaminho

    GTT_PISTOTALSVC.Append(-1);
    DS_REGISTRO.GTT_PISTOTALSVC = "9001"
    GTT_PISTOTALSVC.Consultar(nil);
    if ($status = -7) then begin
        GTT_PISTOTALSVC.Consultar(nil);
    end;
    QT_REGISTRO.GTT_PISTOTALSVC = 1

    //Registro 9900
    vDsConteudo = ""
    //Texto fixo.
    vDsConteudo = "|9900"
    //Registro que será totalizado
    vStringAux = "9900"
    vDsConteudo = "%%vDsConteudo%%%|%%vStringAux"
    //Total de registros do tipo informado
    vStringAux = vCont
    vDsConteudo = "%%vDsConteudo%%%|%%vStringAux"
    //Marcador.
    vDsConteudo = "%%vDsConteudo%%%|%%^"
    filedump/append vDsConteudo, piCaminho

    GTT_PISTOTALSVC.Append(-1);
    DS_REGISTRO.GTT_PISTOTALSVC = "9900"
    GTT_PISTOTALSVC.Consultar(nil);
    if ($status = -7) then begin
        GTT_PISTOTALSVC.Consultar(nil);
    end;
    QT_REGISTRO.GTT_PISTOTALSVC = vCont

    //Registro 9990
    vDsConteudo = ""
    //Texto fixo.
    vDsConteudo = "|9900"
    //Registro que será totalizado
    vStringAux = "9990"
    vDsConteudo = "%%vDsConteudo%%%|%%vStringAux"
    //Total de registros do tipo informado
    vStringAux = 1
    vDsConteudo = "%%vDsConteudo%%%|%%vStringAux"
    //Marcador.
    vDsConteudo = "%%vDsConteudo%%%|%%^"
    filedump/append vDsConteudo, piCaminho

    GTT_PISTOTALSVC.Append(-1);
    DS_REGISTRO.GTT_PISTOTALSVC = "9990"
    GTT_PISTOTALSVC.Consultar(nil);
    if ($status = -7) then begin
        GTT_PISTOTALSVC.Consultar(nil);
    end;
    QT_REGISTRO.GTT_PISTOTALSVC = 1

    //Registro 9999
    vDsConteudo = ""
    //Texto fixo.
    vDsConteudo = "|9900"
    //Registro que será totalizado
    vStringAux = "9999"
    vDsConteudo = "%%vDsConteudo%%%|%%vStringAux"
    //Total de registros do tipo informado
    vStringAux = 1
    vDsConteudo = "%%vDsConteudo%%%|%%vStringAux"
    //Marcador.
    vDsConteudo = "%%vDsConteudo%%%|%%^"
    filedump/append vDsConteudo, piCaminho

    GTT_PISTOTALSVC.Append(-1);
    DS_REGISTRO.GTT_PISTOTALSVC = "9999"
    GTT_PISTOTALSVC.Consultar(nil);
    if ($status = -7) then begin
        GTT_PISTOTALSVC.Consultar(nil);
    end;
    QT_REGISTRO.GTT_PISTOTALSVC = 1

    GTT_PISTOTALSVC.Salvar();
    if ($procerror) then begin
        SetStatus(<STS_ERRO>, $procerror, $procerrorcontext, "");
        return(-1)
    end else begin
        SetStatus(<STS_ERRO>, $xCdErro$, $xCtxErro$, "");
        return(-1)
    end;

    return(0)

End // entry gerarEFDBloco9Reg9900


//-------------------------------
function gerarEFDBloco9Reg9990(pParams : String) : String;
//-------------------------------

    params
        poCdErro :OUT : Real;
        poCtxErro :OUT : String;
        piCaminho :IN : String;
    endparams
    
    variables
        vTotalReg : Real;
        vDsConteudo : String;
    endvariables
    
    setDisplay("Gerando EFD: Bloco 9 - registro 9990", "", "");
    if ($procerror) then begin
        SetStatus(<STS_ERRO>, $xCdErro$, $xCtxErro$, "");
        poCdErro = $xCdErro$
        poCtxErro = $xCtxErro$
    end;

    vTotalReg = 0
    vDsConteudo = ""
    
    //Texto fixo.
    vDsConteudo = "|9990"

    //Quantidade total de linhas do Bloco 9.
    GTT_PISTOTALSVC.Clear();
    DS_REGISTRO.GTT_PISTOTALSVC/init = "9·*"
    GTT_PISTOTALSVC.Consultar(nil);
    if ($status >= 0) then begin
        GTT_PISTOTALSVC.RecNo :=  1;
        while ($status >= 0) do begin
            vTotalReg = vTotalReg + QT_REGISTRO.GTT_PISTOTALSVC
            GTT_PISTOTALSVC.RecNo
        end;
        GTT_PISTOTALSVC.Clear();
    end;
    vDsConteudo = "%%vDsConteudo|%%vTotalReg"

    //Marcador.
    vDsConteudo = "%%vDsConteudo%%%|%%^"

    filedump/append vDsConteudo, piCaminho
    
    return(0)

End // entry gerarEFDBloco9Reg9990


//-------------------------------
function gerarEFDBloco9Reg9999(pParams : String) : String;
//-------------------------------

    params
        poCdErro :OUT : Real;
        poCtxErro :OUT : String;
        piCaminho :IN : String;
    endparams
    
    variables
        vTotalReg : Real;
        vDsConteudo : String;
    endvariables
    
    setDisplay("Gerando EFD: Bloco 9 - registro 9999", "", "");
    if ($procerror) then begin
        SetStatus(<STS_ERRO>, $xCdErro$, $xCtxErro$, "");
        poCdErro = $xCdErro$
        poCtxErro = $xCtxErro$
    end;

    vTotalReg = 0
    vDsConteudo = ""

    //Texto fixo.
    vDsConteudo = "|9999"

    //Quantidade total de linhas do arquivo digital
    selectdb sum(QT_REGISTRO) from "GTT_PISTOTALSVC" to vTotalReg
    vDsConteudo = "%%vDsConteudo|%%vTotalReg"

    //Marcador.
    vDsConteudo = "%%vDsConteudo%%%|%%^"

    filedump/append vDsConteudo, piCaminho
    
    return(0)

End // entry gerarEFDBloco9Reg9999


//------------------------
function converterString(pParams : String) : String;
//------------------------

    params
        piString :In : String;
        poString :Out : String;
    endparams

    variables
        viParams,voParams, vStringAux : String;
    endvariables

    vStringAux = $ltrim(piString," ") // Tira os espaços em branco a esquerda
    vStringAux = $rtrim(vStringAux," ") // Tira os espaços em branco a direita

    poString = vStringAux
    
    return (0)

End // entry converterString


//--------------------
function convNumeric(pParams : String) : String;
//--------------------

    params
        NumericIn : IN : String;
        Tamanho : IN : Real;
        NumericOut : OUT : String;
    endparams

    variables
        vChar, vString, vStringAux, v1 : String;
        vAux, vPos, vCont, vTamanho, vQtDigitos : Real;
    endvariables

    length NumericIn
    vTamanho = $result
    vCont = 0
    vStringAux = ""
    //1o. verificar quantos caracteres inválidos existem no meio da informação
    repeat
        vCont = vCont + 1
        vChar = NumericIn[vCont:1]
        selectcase vChar
            case " "
                vChar = ""
            case "."
                vChar = ""
            case ","
                vChar = ""
            case "+"
                vChar = ""
            case "-"
                vChar = ""
            case "\"
                vChar = ""
            case "/"
                vChar = ""
            case "|"
                vChar = ""
            case "*"
                vChar = ""
            case "("
                vChar = ""
            case ")"
                vChar = ""
            case "_"
                vChar = ""
        endselectcase
        vString = "%%vString%%vChar"
    until (vCont > vTamanho)

    v1 = "0"
    vAux = 1
    length vString
    vQtDigitos = $result
    vPos = Tamanho - vQtDigitos

    if (vPos < 0) then begin
        vPos = vQtDigitos - Tamanho
        vStringAux = vString[vPos+1,vQtDigitos]
    else
        vCont = 0
        //montar o numero, alinhado à direita com zeros à esquerda
        repeat
            if (vAux > vPos) then begin
                vCont = vCont + 1
                vChar = vString[vCont:1]
                vStringAux = "%%vStringAux%%vChar"
            else
                vStringAux = "%%vStringAux%%v1"
            end;
            vAux = vAux + 1
        until (vAux > Tamanho)
    end;

    NumericOut = vStringAux

    return(0)

End // entry convNumeric


//--------------------
function convString(pParams : String) : String;
//--------------------

    params
        String Campo : IN
        StringIn : IN : String;
        Tamanho : IN : Real;
        StringOut : OUT : String;
    endparams

    variables
        vChar, vString, vStringAux, v1 : String;
        vAux, vPos, vCont : Real;
    endvariables
    v1 = " "
    vStringAux = ""
    length StringIn
    vPos = $result
    if (vPos < 0) then begin
        vPos = 1
    end;
    vCont = 0
    vAux = 1
    repeat
        vCont = vCont + 1
        vChar = StringIn[vCont:1]
        if (Campo = "NR_INSCESTL.FIS_NF") then begin
            (Campo = "NR_INSCESTL.PES_PESJURIDICA") | %\
            (Campo = "NR_RGINSCREST.FIS_NFREMDES")
            selectcase vChar
                case " "
                    vChar = ""
                case "."
                    vChar = ""
                case "-"
                    vChar = ""
                case "_"
                    vChar = ""
                case "\"
                    vChar = ""
                case "/"
                    vChar = ""
                case "|"
                    vChar = ""
                case "*"
                    vChar = ""
                case "("
                    vChar = ""
                case ")"
                    vChar = ""
            endselectcase
        end;
        vString = "%%vString%%vChar"
        vAux = vAux + 1
    until (vAux > vPos)
    if (Campo = "NR_INSCESTL.FIS_NF") then begin
        (Campo = "NR_INSCESTL.PES_PESJURIDICA") | %\
        (Campo = "NR_RGINSCREST.FIS_NFREMDES")
        if (StringIn[1:5] = "ISENT" ) then begin
            StringIn = "ISENTO"
        end;
    end;
    //alinhar a esquerda e completar com espaços em branco à direita
    length vString
    vPos = $result
    if (vPos <= 0) then begin
        vPos = 0
    end;
    vCont = 1
    vAux = 1
    repeat
        if (vAux <= vPos) then begin
            vChar = vString[vCont:1]
            vStringAux = "%%vStringAux%%vChar"
            vCont = vCont + 1
        else
            vStringAux = "%%vStringAux%%v1"
        end;
        vAux = vAux + 1
    until (vAux > Tamanho)

    StringOut = vStringAux

End // entry convString


//------------------
function editarNr(pParams : String) : String;
//------------------

    params
        TamInt :IN : Real;
        TamDec :IN : Real;
        ValorIN :IN : String;
        ValorOUT :OUT : String;
    endparams

    variables
        vTam, vInteiro, vDecimal, vCont, v1 : Real;
        vDec, vInt, vAux : String;
    endvariables

    v1 = "0"
    vAux = ValorIn
    vInteiro = vAux[trunc] //retira a parte inteira
    vDecimal = vAux[fraction] //retira a parte decimal

    //para o caso do valor ser maior que a quantidade de bytes do arq.
    length vInteiro
    vTam = $result
    if (vTam > TamInt) then begin
        vTam = vTam - TamInt
        vInteiro = vInteiro[vTam:TamInt]
        vInt = vInteiro
    else
        vInt = vInteiro
    end;
    vDec = vDecimal
    if (vDec = 0) then begin
        vDec = "0"
        vCont = 1
        repeat
            vDec = "%%vDec%%v1"
            vCont = vCont + 1
        until (vCont >= TamDec)
    else
        vDec = vDec[3:TamDec]
        length vDec
        vCont = $result
        if (vCont < TamDec ) then begin
            repeat
                vDec = "%%vDec%%v1"
                vCont = vCont + 1
            until (vCont >= TamDec)
        end else begin
            message/error "Erro na Decimal"
        end;
    end;

    ValorOUT = "%%vInt%%vDec"

End // entry editarNr


//------------------------
function convValorString(pParams : String) : String;
//------------------------

    params
        pDecimal:IN : Real;
        piCampo :IN : String;
        poCampo :OUT : String;
    endparams

    variables
        vStringAux : String;
        vQtPos : Real;
    endvariables

    vQtPos = $length(piCampo)

    if (vQtPos > pDecimal) then begin
        vStringAux = piCampo[1:vQtPos-pDecimal]
        poCampo = vStringAux
        vStringAux = ","
        poCampo = "%%poCampo%%vStringAux"
        vStringAux = piCampo[(vQtPos-pDecimal)+1:pDecimal]
        poCampo = "%%poCampo%%vStringAux"
    else
        poCampo = "0,%%piCampo"
    end;

    return(0)

End // entry convValorString


//--------------------------
function retirarNaoNumerico(pParams : String) : String;
//--------------------------

    params
        piDadoEntra : IN : String;
        poDadoSai : OUT : String;
    endparams

    variables
        vTamDado, vCta : Real;
    endvariables
    
    if (piDadoEntra = "") then begin
        piDadoEntra = " "
    end;
    
    length piDadoEntra
    vTamDado = $result
    vCta = 0
    poDadoSai= ""
    repeat
        vCta = vCta + 1
        if (piDadoEntra[vCta:1] >= "0") then begin
            poDadoSai= "%%poDadoSai%%piDadoEntra[vCta:1]"
        end;
    until (vCta = vTamDado)
    
    return (0)

End // entry retirarNaoNumerico


//----------------------------------
function substituiCaractereEspecial(pParams : String) : String;
//----------------------------------

    params
        piDadoEntra : IN : String;
        piTamFinal : IN : Real;
        poDadoSai : OUT : String;
    endparams
    
    variables
        vDadoEntra, vDadoSai, vPos : String;
        vTamDado, vCta : Real;
    endvariables
    
    length piDadoEntra
    vTamDado = $result
    uppercase piDadoEntra, vDadoEntra
    vCta = 0
    vDadoSai = ""
    if (vTamDado < 1) then begin
        return (0)
    end;
    repeat
        vCta = vCta + 1
        if ((vDadoEntra [vCta:1] >= "0") then begin
            ((vDadoEntra [vCta:1] >= "A") & (vDadoEntra [vCta:1] <= "Z")) | %\
            (vDadoEntra [vCta:1] >= " ")

            vDadoSai = "%%vDadoSai%%vDadoEntra[vCta:1]"
        else
            selectcase vDadoEntra[vCta:1]
                case "Ã"
                    vPos = "A"
                case "À"
                    vPos = "A"
                case "Á"
                    vPos = "A"
                case "Â"
                    vPos = "A"
                case "Ä"
                    vPos = "A"
                case "È"
                    vPos = "E"
                case "É"
                    vPos = "E"
                case "Ê"
                    vPos = "E"
                case "Ë"
                    vPos = "E"
                case "Ì"
                    vPos = "I"
                case "Í"
                    vPos = "I"
                case "Î"
                    vPos = "I"
                case "Ï"
                    vPos = "I"
                case "Õ"
                    vPos = "O"
                case "Ò"
                    vPos = "O"
                case "Ó"
                    vPos = "O"
                case "Ô"
                    vPos = "O"
                case "Ö"
                    vPos = "O"
                case "Ù"
                    vPos = "U"
                case "Ú"
                    vPos = "U"
                case "Û"
                    vPos = "U"
                case "Ü"
                    vPos = "U"
                case "U"
                    vPos = "U"
                case "U"
                    vPos = "U"
                case "Ñ"
                    vPos = "N"
                case "~"
                    vPos = " "
                case "^"
                    vPos = " "
                case "`"
                    vPos = " "
                case ""
                    vPos = " "
                end else begin
                    vPos = ""
            endselectcase
            vDadoSai = "%%vDadoSai%%vPos"
        end;
    until (vCta = vTamDado)

    preencheEspacosDireita(vDadoSai,piTamFinal,poDadoSai)

    return (0)

End // entry substituiCaractereEspecial


//-----------------------------------------
function preencheEspacosDireita(pParams : String) : String;
//-----------------------------------------

    params
        piDadoEntra : IN : String;
        piTamFinal : IN : Real;
        poDadoSai : OUT : String;
    endparams

    variables
        vTam : Real;
        vEspaco : String;
    endvariables
    
    length piDadoEntra
    vTam = $result
    if (vTam < piTamFinal) then begin
        poDadoSai = piDadoEntra
        vEspaco = " "
        repeat
            poDadoSai = "%%poDadoSai%%vEspaco"
            vTam = vTam + 1
        until (vTam = piTamFinal)
    else
        poDadoSai = piDadoEntra[1:piTamFinal]
    end;
    
    return(0)

End // entry preencheEspacosDireita

//--------------------------------
function gerarEFD(pParams : String) : String;
//--------------------------------

    params
        piGlobal :IN : String;
        piParams :IN : String;
        poParams :OUT : String;
        poCdErro :OUT : Real;
        poCtxErro :OUT : String;
    endparams

    variables
        voParams : String;
    endvariables

    $dsParametro$ = piParams

    GTT_EFDREGISTSVC.Clear();

    //Busca parametros
    getParam($item("CD_EMPRESA",$dsParametro$)
    if ($procerror) then begin
        SetStatus(<STS_ERRO>, $procerror, $procerrorcontext, "");
        poCdErro = $xCdErro$
        poCtxErro = $xCtxErro$
        return(-1)
    end else begin
        SetStatus(<STS_ERRO>, $xCdErro$, $xCtxErro$, "");
        poCdErro = $xCdErro$
        poCtxErro = $xCtxErro$
        return(-1)
    end;

    //Gerar bloco 0
    FISSVCO083.gerarEFDBloco0($$gParamGlb, $dsParametro$, voParams, $xCdErro$, $xCtxErro$);
    if ($procerror) then begin
        setStatus(<STS_ERRO>, $procerror, $procerrorcontext, "");
        poCdErro = $xCdErro$
        poCtxErro = $xCtxErro$
        rollback
        return(-1)
    end else begin
        SetStatus(<STS_ERRO>, $xCdErro$, $xCtxErro$, "");
        poCdErro = $xCdErro$
        poCtxErro = $xCtxErro$
        rollback
        return(-1)
    end;

    //Gerar bloco C
    FISSVCO084.gerarEFDBlocoC($$gParamGlb, $dsParametro$, voParams, $xCdErro$, $xCtxErro$);
    if ($procerror) then begin
        setStatus(<STS_ERRO>, $procerror, $procerrorcontext, "");
        poCdErro = $xCdErro$
        poCtxErro = $xCtxErro$
        rollback
        return(-1)
    end else begin
        SetStatus(<STS_ERRO>, $xCdErro$, $xCtxErro$, "");
        poCdErro = $xCdErro$
        poCtxErro = $xCtxErro$
        rollback
        return(-1)
    end;

    //Gerar bloco D
    FISSVCO085.gerarEFDBlocoD($$gParamGlb, $dsParametro$, voParams, $xCdErro$, $xCtxErro$);
    if ($procerror) then begin
        setStatus(<STS_ERRO>, $procerror, $procerrorcontext, "");
        poCdErro = $xCdErro$
        poCtxErro = $xCtxErro$
        rollback
        return(-1)
    end else begin
        SetStatus(<STS_ERRO>, $xCdErro$, $xCtxErro$, "");
        poCdErro = $xCdErro$
        poCtxErro = $xCtxErro$
        rollback
        return(-1)
    end;

    //Gerar bloco E
    FISSVCO086.gerarEFDBlocoE($$gParamGlb, $dsParametro$, voParams, $xCdErro$, $xCtxErro$);
    if ($procerror) then begin
        setStatus(<STS_ERRO>, $procerror, $procerrorcontext, "");
        poCdErro = $xCdErro$
        poCtxErro = $xCtxErro$
        rollback
        return(-1)
    end else begin
        SetStatus(<STS_ERRO>, $xCdErro$, $xCtxErro$, "");
        poCdErro = $xCdErro$
        poCtxErro = $xCtxErro$
        rollback
        return(-1)
    end;

    //Gerar bloco G
    FISSVCO087.gerarEFDBlocoG($$gParamGlb, $dsParametro$, voParams, $xCdErro$, $xCtxErro$);
    if ($procerror) then begin
        setStatus(<STS_ERRO>, $procerror, $procerrorcontext, "");
        poCdErro = $xCdErro$
        poCtxErro = $xCtxErro$
        rollback
        return(-1)
    end else begin
        SetStatus(<STS_ERRO>, $xCdErro$, $xCtxErro$, "");
        poCdErro = $xCdErro$
        poCtxErro = $xCtxErro$
        rollback
        return(-1)
    end;

    //Gerar bloco H
    FISSVCO088.gerarEFDBlocoH($$gParamGlb, $dsParametro$, voParams, $xCdErro$, $xCtxErro$);
    if ($procerror) then begin
        setStatus(<STS_ERRO>, $procerror, $procerrorcontext, "");
        poCdErro = $xCdErro$
        poCtxErro = $xCtxErro$
        rollback
        return(-1)
    end else begin
        SetStatus(<STS_ERRO>, $xCdErro$, $xCtxErro$, "");
        poCdErro = $xCdErro$
        poCtxErro = $xCtxErro$
        rollback
        return(-1)
    end;

    //Gerar bloco 1
    FISSVCO089.gerarEFDBloco1($$gParamGlb, $dsParametro$, voParams, $xCdErro$, $xCtxErro$);
    if ($procerror) then begin
        setStatus(<STS_ERRO>, $procerror, $procerrorcontext, "");
        poCdErro = $xCdErro$
        poCtxErro = $xCtxErro$
        rollback
        return(-1)
    end else begin
        SetStatus(<STS_ERRO>, $xCdErro$, $xCtxErro$, "");
        poCdErro = $xCdErro$
        poCtxErro = $xCtxErro$
        rollback
        return(-1)
    end;

    //Gerar arquivo
    gerarArquivoTexto($xCdErro$,$xCtxErro$);
    if ($procerror) then begin
        setStatus(<STS_ERRO>, $procerror, $procerrorcontext, "");
        poCdErro = $xCdErro$
        poCtxErro = $xCtxErro$
        rollback
        return(-1)
    end else begin
        SetStatus(<STS_ERRO>, $xCdErro$, $xCtxErro$, "");
        poCdErro = $xCdErro$
        poCtxErro = $xCtxErro$
        rollback
        return(-1)
    end;
    
    GTT_EFDREGISTSVC.Clear();

    rollback
    
    return(0)

End // operation gerarEFD


//-------------------------------------
function gerarArquivoTexto(pParams : String) : String;
//-------------------------------------

    params
        poCdErro :OUT : Real;
        poCtxErro :OUT : String;
    endparams

    variables
        vFlag : Boolean;
        vTam, vPos, vTotDig : Real;
        vDsConteudo, vCaminho, vArquivo, vEOF : String;
    endvariables

    $nrLinha$ = 0
    vDsConteudo = ""
    vCaminho = "D:\VirtualAge\Storeage\temp\"
    vArquivo = $item("DS_PATH", $dsParametro$)
    vPos = $scan(vArquivo, "\")

    while (vPos != 0) do begin
        vPos = $scan(vArquivo, "\")
        vTam = $length(vArquivo)
        vArquivo = vArquivo[vPos+1:vTam-vPos]
    end;

    vCaminho = "%%vCaminho%%vArquivo"
    vPos = ""
    filedump vDsConteudo, vCaminho

    GTT_EFDREGISTSVC.Clear();
    GTT_EFDREGISTSVC.Consultar(nil);
    if ($status >= 0) then begin
        GTT_EFDREGISTSVC.RecNo := -1;
        GTT_EFDREGISTSVC.IndexFieldsNames('NR_SEQUENCIA.GTT_EFDREGISTSVC');
        GTT_EFDREGISTSVC.RecNo := 1;
        while ($status >= 0) do begin

            if (DS_REGISTRO.GTT_EFDREGISTSVC = "0150") then begin
                geraRegistro0150(vCaminho)
                if ($procerror) then begin
                    setStatus(<STS_ERRO>, $procerror, $procerrorcontext, "");
                    poCdErro = $xCdErro$
                    poCtxErro = $xCtxErro$
                    return(-1)
                end else begin
                    SetStatus(<STS_ERRO>, $xCdErro$, $xCtxErro$, "");
                    poCdErro = $xCdErro$
                    poCtxErro = $xCtxErro$
                    return(-1)
                end;

            end else begin
                geraRegistro0190(vCaminho)
                if ($procerror) then begin
                    setStatus(<STS_ERRO>, $procerror, $procerrorcontext, "");
                    poCdErro = $xCdErro$
                    poCtxErro = $xCtxErro$
                    return(-1)
                end else begin
                    SetStatus(<STS_ERRO>, $xCdErro$, $xCtxErro$, "");
                    poCdErro = $xCdErro$
                    poCtxErro = $xCtxErro$
                    return(-1)
                end;

            end else begin
                geraRegistro0200(vCaminho)
                if ($procerror) then begin
                    setStatus(<STS_ERRO>, $procerror, $procerrorcontext, "");
                    poCdErro = $xCdErro$
                    poCtxErro = $xCtxErro$
                    return(-1)
                end else begin
                    SetStatus(<STS_ERRO>, $xCdErro$, $xCtxErro$, "");
                    poCdErro = $xCdErro$
                    poCtxErro = $xCtxErro$
                    return(-1)
                end;

            end else begin
                geraRegistro0300(vCaminho)
                if ($procerror) then begin
                    setStatus(<STS_ERRO>, $procerror, $procerrorcontext, "");
                    poCdErro = $xCdErro$
                    poCtxErro = $xCtxErro$
                    return(-1)
                end else begin
                    SetStatus(<STS_ERRO>, $xCdErro$, $xCtxErro$, "");
                    poCdErro = $xCdErro$
                    poCtxErro = $xCtxErro$
                    return(-1)
                end;

            end else begin
                geraRegistro0400(vCaminho)
                if ($procerror) then begin
                    setStatus(<STS_ERRO>, $procerror, $procerrorcontext, "");
                    poCdErro = $xCdErro$
                    poCtxErro = $xCtxErro$
                    return(-1)
                end else begin
                    SetStatus(<STS_ERRO>, $xCdErro$, $xCtxErro$, "");
                    poCdErro = $xCdErro$
                    poCtxErro = $xCtxErro$
                    return(-1)
                end;

            end else begin
                geraRegistro0450(vCaminho)
                if ($procerror) then begin
                    setStatus(<STS_ERRO>, $procerror, $procerrorcontext, "");
                    poCdErro = $xCdErro$
                    poCtxErro = $xCtxErro$
                    return(-1)
                end else begin
                    SetStatus(<STS_ERRO>, $xCdErro$, $xCtxErro$, "");
                    poCdErro = $xCdErro$
                    poCtxErro = $xCtxErro$
                    return(-1)
                end;

            end else begin
                geraRegistro0460(vCaminho)
                if ($procerror) then begin
                    setStatus(<STS_ERRO>, $procerror, $procerrorcontext, "");
                    poCdErro = $xCdErro$
                    poCtxErro = $xCtxErro$
                    return(-1)
                end else begin
                    SetStatus(<STS_ERRO>, $xCdErro$, $xCtxErro$, "");
                    poCdErro = $xCdErro$
                    poCtxErro = $xCtxErro$
                    return(-1)
                end;

            end else begin
                geraRegistro0990(vCaminho)
                if ($procerror) then begin
                    setStatus(<STS_ERRO>, $procerror, $procerrorcontext, "");
                    poCdErro = $xCdErro$
                    poCtxErro = $xCtxErro$
                    return(-1)
                end else begin
                    SetStatus(<STS_ERRO>, $xCdErro$, $xCtxErro$, "");
                    poCdErro = $xCdErro$
                    poCtxErro = $xCtxErro$
                    return(-1)
                end;

            else
                $nrLinha$ = $nrLinha$ + 1
                setDisplay("Gerando Arquivo EFD: %%DS_REGISTRO.GTT_EFDREGISTSVC - Linha: %%$nrLinha$", "", "");
                if ($procerror) then begin
                    SetStatus(<STS_ERRO>, $xCdErro$, $xCtxErro$, "");
                end;

                filedump/append DS_GERAL.GTT_EFDREGISTSVC, vCaminho
            end;

            GTT_EFDREGISTSVC.Delete();
            if ($status = 0) then begin
                $status = -1
            end;
        end;

        //Gerar bloco 9
        gerarEFDBloco9($xCdErro$,$xCtxErro$,vCaminho)
            if ($procerror) then begin
            setStatus(<STS_ERRO>, $procerror, $procerrorcontext, "");
            poCdErro = $xCdErro$
            poCtxErro = $xCtxErro$
            rollback
            return(-1)
        end else begin
            SetStatus(<STS_ERRO>, $xCdErro$, $xCtxErro$, "");
            poCdErro = $xCdErro$
            poCtxErro = $xCtxErro$
            rollback
            return(-1)
        end;
    end;

    if ($uppercase(vCaminho) then begin
        vFlag = <FALSE>
        vbfileman.arqexiste(vFlag,$item("DS_PATH", $dsParametro$);
        if (vFlag) then begin
            vbfileman.apagaarquivo($item("DS_PATH", $dsParametro$);
        end;
        vbfileman.movearquivo(vEOF,vCaminho,$item("DS_PATH", $dsParametro$);
        vFlag = <FALSE>
        vbfileman.arqexiste(vFlag,vCaminho);
        if (vFlag) then begin
            vbfileman.apagaarquivo(vCaminho);
        end;
    end;

    return(0)

End // operation gerarArquivoTexto
