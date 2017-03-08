unit cADMSVCO025;

interface

(* COMPONENTES 
  ADMSVCO001 / FGRSVCO001 / PESSVCO005 / 
*)        

uses
  Classes, SysUtils, Math, DB,
  cServiceUnf, cDataSetUnf;

type
  T_ADMSVCO025 = class(TcServiceUnf)
  private
    tFCC_CTAPES,
    tFCP_TIPOCAMPO,
    tGAR_RELATORIO,
    tGEC_CCUSTO,
    tGER_MODETIQC,
    tGER_MOEDAC,
    tGER_OPERACAO,
    tODS_CICLO,
    tPES_ENDERECO,
    tPES_FORNECEDO,
    tPES_PESSOA,
    tPES_TIPOCAMPO,
    tPES_TIPOCLAS,
    tPES_TIPOEMAIL,
    tPES_TIPOFONE,
    tPES_TIPOVERBA,
    tPRD_TIPOVALOR,
    tSIS_MENU,
    tV_PES_ENDEREC : TcDatasetUnf;
    function getParam(pParams : String = '') : String;
    function setEntidade(pParams : String = '') : String;
  protected
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;    
  published
    function CD_CUSTO(pParams : String = '') : String;
    function CD_MENU(pParams : String = '') : String;
    function CD_CPOADIC_PESSOA(pParams : String = '') : String;
    function CD_ETIQUETA(pParams : String = '') : String;
    function CD_FORNECEDOR(pParams : String = '') : String;
    function CD_MOEDA(pParams : String = '') : String;
    function CD_IMPR_CARTAO(pParams : String = '') : String;
    function TP_AVISA_ANIVERSARIO(pParams : String = '') : String;
    function TP_SAC_ATIVO(pParams : String = '') : String;
    function CD_TIPOFONE(pParams : String = '') : String;
    function CD_TIPOEMAIL(pParams : String = '') : String;
    function CD_TIPOCLASPES_MULT(pParams : String = '') : String;
    function RELAT_CONFIG(pParams : String = '') : String;
    function VALIDA_INTERVALO_NUM(pParams : String = '') : String;
    function OBRIG_CLASS(pParams : String = '') : String;
    function CD_TIPOEMAIL_MULT(pParams : String = '') : String;
    function CD_TIPOVERBA_MULT(pParams : String = '') : String;
    function TAM_IMAGEM_SCANNER(pParams : String = '') : String;
    function FOR_IMAGEM_SCANNER(pParams : String = '') : String;
    function ACEITA_0_1_2(pParams : String = '') : String;
    function PESFL038_EXIBICAO(pParams : String = '') : String;
    function IN_TP_CAD_AUTOM(pParams : String = '') : String;
    function IN_OBRIG_endERECO(pParams : String = '') : String;
    function CD_PESSOA_end_PADRAO(pParams : String = '') : String;
    function CD_OP_FAT_BRINDE(pParams : String = '') : String;
    function CD_CONCEITO_ULT_COMP(pParams : String = '') : String;
    function IN_CADASTRA_PF(pParams : String = '') : String;
    function IN_USA_COND_PGTO_ESP(pParams : String = '') : String;
    function CD_EMAILFOR(pParams : String = '') : String;
    function PERCENTUAIS(pParams : String = '') : String;
    function VALIDADE_SENHA(pParams : String = '') : String;
    function NR_EMPCTAPES(pParams : String = '') : String;
    function VALIDARCTAPES(pParams : String = '') : String;
    function NR_CICLO_ATUAL_OS(pParams : String = '') : String;
    function CD_CAMPO_ADIC_FCP(pParams : String = '') : String;
    function CD_CCUSTO_FIN(pParams : String = '') : String;
    function VALIDA_COB_BANCO_REC(pParams : String = '') : String;
    function CONSISTE_DIA(pParams : String = '') : String;
    function CD_CLIENTE_PDV_EMP(pParams : String = '') : String;
  end;

implementation

uses
  cADMSVCO001,
  cActivate, cStatus, cFuncao, cXml, dModulo;

var
  gufOrigem : String;

//---------------------------------------------------------------
constructor T_ADMSVCO025.Create(AOwner: TComponent);
//---------------------------------------------------------------
begin
  inherited Create(AOwner);
  setEntidade('');
end;

//--------------------------------
destructor T_ADMSVCO025.Destroy;
//--------------------------------
begin
  inherited Destroy;
end;

//---------------------------------------------------------------
function T_ADMSVCO025.getParam(pParams : String = '') : String;
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
  putitem(xParam, 'CD_TPMANUT_CXFILIAL');
  putitem(xParam, 'CD_TPMANUT_CXFUNDO');
  putitem(xParam, 'CD_TPMANUT_CXMATRIZ');
  putitem(xParam, 'CD_TPMANUT_CXTRANSITORIA');
  putitem(xParam, 'CD_TPMANUT_endOSSO');
  putitem(xParam, 'CD_TPMANUT_REDUTORA');
  putitem(xParam, 'NR_CTAPES');
  putitem(xParam, 'TP_MANUTENCAO');

  xParam := T_ADMSVCO001.GetParametro(xParam);

  vNrCtaPes := itemXml('VL_PARAMETRO', xParam);

  xParamEmp := '';
  putitem(xParamEmp, 'UF_ORIGEM');

  xParamEmp := T_ADMSVCO001.GetParamEmpresa(piCdEmpresa, xParamEmp);

  gufOrigem := itemXml('UF_ORIGEM', xParamEmp);

end;

//---------------------------------------------------------------
function T_ADMSVCO025.setEntidade(pParams : String = '') : String;
//---------------------------------------------------------------
begin
  tFCC_CTAPES := GetEntidade('FCC_CTAPES');
  tFCP_TIPOCAMPO := GetEntidade('FCP_TIPOCAMPO');
  tGAR_RELATORIO := GetEntidade('GAR_RELATORIO');
  tGEC_CCUSTO := GetEntidade('GEC_CCUSTO');
  tGER_MODETIQC := GetEntidade('GER_MODETIQC');
  tGER_MOEDAC := GetEntidade('GER_MOEDAC');
  tGER_OPERACAO := GetEntidade('GER_OPERACAO');
  tODS_CICLO := GetEntidade('ODS_CICLO');
  tPES_ENDERECO := GetEntidade('PES_ENDERECO');
  tPES_FORNECEDO := GetEntidade('PES_FORNECEDO');
  tPES_PESSOA := GetEntidade('PES_PESSOA');
  tPES_TIPOCAMPO := GetEntidade('PES_TIPOCAMPO');
  tPES_TIPOCLAS := GetEntidade('PES_TIPOCLAS');
  tPES_TIPOEMAIL := GetEntidade('PES_TIPOEMAIL');
  tPES_TIPOFONE := GetEntidade('PES_TIPOFONE');
  tPES_TIPOVERBA := GetEntidade('PES_TIPOVERBA');
  tPRD_TIPOVALOR := GetEntidade('PRD_TIPOVALOR');
  tSIS_MENU := GetEntidade('SIS_MENU');
  tV_PES_ENDEREC := GetEntidade('V_PES_ENDEREC');
end;

//--------------------------------------------------------
function T_ADMSVCO025.CD_CUSTO(pParams : String) : String;
//--------------------------------------------------------
const
  cDS_METHOD = 'ADICONAL=Operação: T_ADMSVCO025.CD_CUSTO()';
begin
  clear_e(tPRD_TIPOVALOR);
  putitem_e(tPRD_TIPOVALOR, 'TP_VALOR', 'C');
  putitem_e(tPRD_TIPOVALOR, 'CD_VALOR', itemXmlF('VL_PARAMETRO', pParams));
  retrieve_e(tPRD_TIPOVALOR);
  if (xStatus < 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Custo não cadastrado!', cDS_METHOD);
    return(-1); exit;
  end;

  return(0); exit;
end;

//-------------------------------------------------------
function T_ADMSVCO025.CD_MENU(pParams : String) : String;
//-------------------------------------------------------
const
  cDS_METHOD = 'ADICONAL=Operação: T_ADMSVCO025.CD_MENU()';
begin
  clear_e(tSIS_MENU);
  putitem_e(tSIS_MENU, 'CD_MENU', itemXmlF('VL_PARAMETRO', pParams));
  retrieve_e(tSIS_MENU);
  if (xStatus < 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Menu não cadastrado!', cDS_METHOD);
    return(-1); exit;
  end else begin
    if (item_f('CD_MENU', tSIS_MENU) < 100001 ) or (item_f('CD_MENU', tSIS_MENU) > 999998) then begin
      Result := SetStatus(STS_ERROR, 'GEN0001', 'Intervalo de menu não permitido!', cDS_METHOD);
      return(-1); exit;
    end;
  end;

  return(0); exit;
end;

//-----------------------------------------------------------------
function T_ADMSVCO025.CD_CPOADIC_PESSOA(pParams : String) : String;
//-----------------------------------------------------------------
const
  cDS_METHOD = 'ADICONAL=Operação: T_ADMSVCO025.CD_CPOADIC_PESSOA()';
begin
  clear_e(tPES_TIPOCAMPO);
  putitem_e(tPES_TIPOCAMPO, 'CD_TIPOCAMPO', itemXmlF('VL_PARAMETRO', pParams));
  retrieve_e(tPES_TIPOCAMPO);
  if (xStatus < 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Tipo de campo adicional não cadastrado!', cDS_METHOD);
    return(-1); exit;
  end;

  return(0); exit;
end;

//-----------------------------------------------------------
function T_ADMSVCO025.CD_ETIQUETA(pParams : String) : String;
//-----------------------------------------------------------
const
  cDS_METHOD = 'ADICONAL=Operação: T_ADMSVCO025.CD_ETIQUETA()';
var
  (* string piGlobal :IN *)
  vCdChaveModEtiq : String;
begin
  vCdChaveModEtiq := itemXmlF('VL_PARAMETRO', pParams);

  clear_e(tGER_MODETIQC);
  putitem_e(tGER_MODETIQC, 'CD_MODELO', vCdChaveModEtiq[01, 10]);
  putitem_e(tGER_MODETIQC, 'CD_MODELOETIQ', vCdChaveModEtiq[11, 16]);
  retrieve_e(tGER_MODETIQC);
  if (xStatus < 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Modelo de etiqueta não cadastrado!', cDS_METHOD);
    return(-1); exit;
  end;

  Result := '';
  putitemXml(Result, 'CD_MODELO', item_f('CD_MODELO', tGER_MODETIQC));
  putitemXml(Result, 'CD_MODELOETIQ', item_f('CD_MODELOETIQ', tGER_MODETIQC));

  return(0); exit;
end;

//-------------------------------------------------------------
function T_ADMSVCO025.CD_FORNECEDOR(pParams : String) : String;
//-------------------------------------------------------------
const
  cDS_METHOD = 'ADICONAL=Operação: T_ADMSVCO025.CD_FORNECEDOR()';
begin
  clear_e(tPES_FORNECEDO);
  putitem_e(tPES_FORNECEDO, 'CD_FORNECEDOR', itemXmlF('VL_PARAMETRO', pParams));
  retrieve_e(tPES_FORNECEDO);
  if (xStatus < 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Fornecedor não cadastrado!', cDS_METHOD);
    return(-1); exit;
  end;

  return(0); exit;
end;

//--------------------------------------------------------
function T_ADMSVCO025.CD_MOEDA(pParams : String) : String;
//--------------------------------------------------------
const
  cDS_METHOD = 'ADICONAL=Operação: T_ADMSVCO025.CD_MOEDA()';
begin
  clear_e(tGER_MOEDAC);
  putitem_e(tGER_MOEDAC, 'CD_MOEDA', itemXmlF('VL_PARAMETRO', pParams));
  retrieve_e(tGER_MOEDAC);
  if (xStatus < 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Moeda não cadastrado!', cDS_METHOD);
    return(-1); exit;
  end;

  return(0); exit;
end;

//--------------------------------------------------------------
function T_ADMSVCO025.CD_IMPR_CARTAO(pParams : String) : String;
//--------------------------------------------------------------
const
  cDS_METHOD = 'ADICONAL=Operação: T_ADMSVCO025.CD_IMPR_CARTAO()';
var
  (* string piGlobal :IN *)
  vValorParam2, vAux, vNome, vNumero, vDsConteudo, vDsRegistro, vDsModelo : String;
  vPos, vTam : Real;
begin
  vValorParam2 := itemXmlF('VL_PARAMETRO', pParams);

  vPos := '';
  scan vValorParam2, ';
  vPos := gresult;
  vTam := glength(vValorParam2);
  if (vPos > 0) then begin
    vPos := vPos-1;
    vAux := vValorParam2[1, vPos];
    vPos := vPos + 2;
    vValorParam2 := vValorParam2[vPos, vTam];
  end else begin
    vAux := vValorParam2[1, vTam];
    if (vAux = 2) then begin
      Result := SetStatus(STS_ERROR, 'GEN0001', 'Falta definir os parâmetros para a opção 2.', cDS_METHOD);
      return(-1); exit;
    end;
  end;
  if (vAux <> 1)  and (vAux <> 2)  and (vAux <> 3)  and (vAux <> 4) then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Valor inválido para o parâmetro! Permitido apenas 01, 02 ou 03.', cDS_METHOD);
    return(-1); exit;

  end else if (vAux = 2) then begin
    while (vPos > 0) do begin
      vNome := '';
      vNumero := '';
      scan vValorParam2, ';
      vPos := gresult;
      vTam := glength(vValorParam2);
      if (vPos > 0) then begin
        vPos := vPos-1;
        vNome := vValorParam2[1, vPos];
        vPos := vPos + 2;
        vValorParam2 := vValorParam2[vPos, vTam];
      end;
      scan vValorParam2, ';
      vPos := gresult;
      vTam := glength(vValorParam2);
      if (vPos > 0) then begin
        vPos := vPos-1;
        vNumero := vValorParam2[1, vPos];
        vPos := vPos + 2;
        vValorParam2 := vValorParam2[vPos, vTam];
      end;
      if (vNome = '') then begin
        Result := SetStatus(STS_ERROR, 'GEN0001', 'Falta definir o nome para o cartão.', cDS_METHOD);
        return(-1); exit;
      end;
      if  (vNumero = '');
        Result := SetStatus(STS_ERROR, 'GEN0001', 'Falta definir o número do telefone que será impresso.', cDS_METHOD);
        return(-1); exit;
      end;
      scan vValorParam2, ';
      vPos := gresult;
    end;
  end else if (vAux = 4) then begin
    vDsConteudo := itemXmlF('VL_PARAMETRO', pParams);
    vDsConteudo := greplace(vDsConteudo, 1, ';
    delitem(vDsConteudo, 1);
    getitem(vDsRegistro, vDsConteudo, 1);
    vDsModelo := vDsRegistro;
    if  (vDsModelo = '');
      Result := SetStatus(STS_ERROR, 'GEN0001', 'Falta definir o modelo da cartão configurável', cDS_METHOD);
      return(-1); exit;
    end;
  end;
  return(0); exit;
end;

//--------------------------------------------------------------------
function T_ADMSVCO025.TP_AVISA_ANIVERSARIO(pParams : String) : String;
//--------------------------------------------------------------------
const
  cDS_METHOD = 'ADICONAL=Operação: T_ADMSVCO025.TP_AVISA_ANIVERSARIO()';
begin
  if (itemXml('VL_PARAMETRO', pParams) <> 1)  and (itemXml('VL_PARAMETRO', pParams) <> 2)  and (itemXml('VL_PARAMETRO', pParams) <> 3)  and (itemXml('VL_PARAMETRO', pParams) <> 4) then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Tipo de aviso não permitido!', cDS_METHOD);
    return(-1); exit;
  end;

  return(0); exit;
end;

//------------------------------------------------------------
function T_ADMSVCO025.TP_SAC_ATIVO(pParams : String) : String;
//------------------------------------------------------------
const
  cDS_METHOD = 'ADICONAL=Operação: T_ADMSVCO025.TP_SAC_ATIVO()';
begin
  if (itemXml('VL_PARAMETRO', pParams) <> '00')  and (itemXml('VL_PARAMETRO', pParams) <> '01') then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Valor não permitido!', cDS_METHOD);
    return(-1); exit;
  end;

  return(0); exit;
end;

//-----------------------------------------------------------
function T_ADMSVCO025.CD_TIPOFONE(pParams : String) : String;
//-----------------------------------------------------------
const
  cDS_METHOD = 'ADICONAL=Operação: T_ADMSVCO025.CD_TIPOFONE()';
var
  (* string piGlobal :IN *)
  vCdTipoFone : Real;
begin
  vCdTipoFone := itemXmlF('CD_TIPOFONE', pParams);

  clear_e(tPES_TIPOFONE);
  putitem_e(tPES_TIPOFONE, 'CD_TIPOFONE', vCdTipoFone);
  retrieve_e(tPES_TIPOFONE);
  if (xStatus < 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Tipo de telefone não cadastrado!', cDS_METHOD);
    return(-1); exit;
  end;

  return(0); exit;
end;

//------------------------------------------------------------
function T_ADMSVCO025.CD_TIPOEMAIL(pParams : String) : String;
//------------------------------------------------------------
const
  cDS_METHOD = 'ADICONAL=Operação: T_ADMSVCO025.CD_TIPOEMAIL()';
var
  (* string piGlobal :IN *)
  vCdTipoEmail : Real;
begin
  vCdTipoEmail := itemXmlF('CD_TIPOEMAIL', pParams);

  clear_e(tPES_TIPOEMAIL);
  putitem_e(tPES_TIPOEMAIL, 'CD_TIPOEMAIL', vCdTipoEmail);
  retrieve_e(tPES_TIPOEMAIL);
  if (xStatus < 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Tipo de e-mail não cadastrado!', cDS_METHOD);
    return(-1); exit;
  end;

  return(0); exit;
end;

//-------------------------------------------------------------------
function T_ADMSVCO025.CD_TIPOCLASPES_MULT(pParams : String) : String;
//-------------------------------------------------------------------
const
  cDS_METHOD = 'ADICONAL=Operação: T_ADMSVCO025.CD_TIPOCLASPES_MULT()';
var
  (* string piGlobal :IN *)
  vinTipoClas : Boolean;
  vDsLstTipoClas, vCdTipoClas, vDsLista, vDsParteLstTipoClas, vChar : String;
  vPos, vTam, v : Real;
begin
  vinTipoClas := False;

  vDsLstTipoClas := itemXmlF('VL_PARAMETRO', pParams);

  scan vDsLstTipoClas, '.';
  vPos := gresult;
  if (vPos <= 0) then begin
    scan vDsLstTipoClas, ', ';
    vPos := gresult;
  end;
  if (vPos > 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', , '');
    return(-1); exit;
  end;

  vDsLstTipoClas := greplace(vDsLstTipoClas, 1, ';
  vDsLstTipoClas := greplace(vDsLstTipoClas, 1, ' ', '', -1);

  vPos := 1;
  repeat
    vDsParteLstTipoClas := '';
    vDsParteLstTipoClas := vDsLstTipoClas[vPos:10];
    if (vDsParteLstTipoClas <> '') then begin
      repeat
        vChar := vDsParteLstTipoClas[1:1];
        if (vChar = 0) then begin
          vPos := vPos - 1;
          vDsParteLstTipoClas := vDsLstTipoClas[vPos:10];
        end;
      until (vChar <> 0);

      vTam := glength(vDsParteLstTipoClas);
      vnumeric := vDsParteLstTipoClas;
      vDsParteLstTipoClas := vnumeric;
      if (glength(vDsParteLstTipoClas) <> vTam) then begin
        Result := SetStatus(STS_ERROR, 'GEN0001', , '');
        return(-1); exit;
      end else begin
        vPos := vPos + 10;
      end;
    end;
  until (vDsParteLstTipoClas = '');

  vDsLstTipoClas := itemXmlF('VL_PARAMETRO', pParams);

  vPos := '';
  vDsLista := '';
  if (vDsLstTipoClas <> '') then begin
    scan vDsLstTipoClas, ';
    vPos := gresult;
    vTam := glength(vDsLstTipoClas);

    while (vDsLstTipoClas <> '') do begin
      if (vPos >0) then begin
        vPos := vPos-1;
        vCdTipoClas := vDsLstTipoClas[1, vPos];
        vPos := vPos + 2;
        vDsLstTipoClas := vDsLstTipoClas[vPos, vTam];
      end else begin
        vCdTipoClas := vDsLstTipoClas;
        vDsLstTipoClas := '';
      end;

      clear_e(tPES_TIPOCLAS);
      putitem_e(tPES_TIPOCLAS, 'CD_TIPOCLAS', vCdTipoClas);
      retrieve_e(tPES_TIPOCLAS);
      if (xStatus < 0) then begin
        if (vDsLista = '') then begin
          vDsLista := vCdTipoClas;
        end else begin
          vDsLista := '' + vDsLista/' + FloatToStr(vCdTipoClas') + ' + ';
        end;
      end;

      scan vDsLstTipoClas, ';
      vPos := gresult;
      vTam := glength(vDsLstTipoClas);
    end;
  end;
  if (vDsLista <> '') then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Tipo(s) de classificação ' + vDsLista + ' não cadastrado!', cDS_METHOD);
    return(-1); exit;
  end;

  return(0); exit;
end;

//------------------------------------------------------------
function T_ADMSVCO025.RELAT_CONFIG(pParams : String) : String;
//------------------------------------------------------------
const
  cDS_METHOD = 'ADICONAL=Operação: T_ADMSVCO025.RELAT_CONFIG()';
var
  (* string piGlobal :IN *)
  vCdGrupoModelo, vCdRelatorio, vDsParametro : String;
  vTam, vPos : Real;
begin
  vCdGrupoModelo := '';
  vCdRelatorio := '';
  vDsParametro := '';

  if (itemXml('VL_PARAMETRO', pParams) = '') then begin
    return(0); exit;
  end;

  vDsParametro := itemXmlF('VL_PARAMETRO', pParams);
  vTam := glength(vDsParametro);
  vPos := vTam - 3;
  vCdGrupoModelo := vDsParametro[1, vPos];
  vPos := vPos + 1;
  vCdRelatorio := vDsParametro[vPos, vTam];

  if (vCdGrupoModelo <> '' ) and (vCdRelatorio <> '') then begin
    clear_e(tGAR_RELATORIO);
    putitem_e(tGAR_RELATORIO, 'CD_GRUPOMODELO', vCdGrupoModelo);
    putitem_e(tGAR_RELATORIO, 'CD_RELATORIO', vCdRelatorio);
    retrieve_e(tGAR_RELATORIO);
    if (xStatus < 0) then begin
      Result := SetStatus(STS_ERROR, 'GEN0001', 'Relatório não cadastrado!', cDS_METHOD);
      return(-1); exit;
    end;
  end else begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Relatório não cadastrado!', cDS_METHOD);
    return(-1); exit;
  end;

  return(0); exit;
end;

//--------------------------------------------------------------------
function T_ADMSVCO025.VALIDA_INTERVALO_NUM(pParams : String) : String;
//--------------------------------------------------------------------
const
  cDS_METHOD = 'ADICONAL=Operação: T_ADMSVCO025.VALIDA_INTERVALO_NUM()';
var
  (* string piGlobal :IN *)
  vInAchou : Boolean;
  vNrAux, vNrAux2, vConsulta, vCont, vContAux, vPos : Real;
  vAux, vDsParametro, vChar, vLimpa : String;
begin
  vDsParametro := itemXmlF('VL_PARAMETRO', pParams);
  if (vDsParametro = '') then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Valor não informado (parâmetro DS_LST_CICLO_CUSTO)!', cDS_METHOD);
    return(-1); exit;
  end;

  vDsParametro := itemXmlF('VL_PARAMETRO', pParams);
  vConsulta := gscan(vDsParametro, ', ');
  if (vConsulta <= 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Valores deverão ser separados por vírgula (parâmetro DS_LST_CICLO_CUSTO)!', cDS_METHOD);
    return(-1); exit;
  end;

  vDsParametro := itemXmlF('VL_PARAMETRO', pParams);
  length vDsParametro;
  vPos := gresult;
  vCont := 0;
  vContAux := 0;
  repeat
    vCont := vCont + 1;
    vChar := vDsParametro[vCont:1];
    selectcase vChar;
      case ', ';
        vContAux := vContAux + 1;
    endselectcase;
  until (vCont > vPos);

  if (vContAux > 1) then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Só é permitido dois valores separados por apenas uma vírgula (parâmetro DS_LST_CICLO_CUSTO)!', cDS_METHOD);
    return(-1); exit;
  end;

  vInAchou := False;
  vDsParametro := itemXmlF('VL_PARAMETRO', pParams);
  vConsulta := gscan(vDsParametro, '*');
  if (vConsulta > 0) then begin
    vInAchou := True;
  end;
  vConsulta := gscan(vDsParametro, '=');
  if (vConsulta > 0) then begin
    vInAchou := True;
  end;
  vConsulta := gscan(vDsParametro, '>');
  if (vConsulta > 0) then begin
    vInAchou := True;
  end;
  vConsulta := gscan(vDsParametro, '<');
  if (vConsulta > 0) then begin
    vInAchou := True;
  end;
  vConsulta := gscan(vDsParametro, ';
  if (vConsulta > 0) then begin
    vInAchou := True;
  end;
  vConsulta := gscan(vDsParametro, 'or');
  if (vConsulta > 0) then begin
    vInAchou := True;
  end;
  vConsulta := gscan(vDsParametro, 'and');
  if (vConsulta > 0) then begin
    vInAchou := True;
  end;
  vConsulta := gscan(vDsParametro, '!');
  if (vConsulta > 0) then begin
    vInAchou := True;
  end;
  if (vInAchou = True) then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Não é permitido caracteres especiais (parâmetro DS_LST_CICLO_CUSTO)!', cDS_METHOD);
    return(-1); exit;
  end;

  vDsParametro := greplace(vDsParametro, 1, ', ', '', -1);
  vNrAux := vDsParametro;
  vstringAux := vDsParametro;
  if (vNrAux <> vstringAux) then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Valor deverá ser númerico (parâmetro DS_LST_CICLO_CUSTO)!', cDS_METHOD);
    return(-1); exit;
  end;

  vDsParametro := itemXmlF('VL_PARAMETRO', pParams);
  vConsulta := gscan(vDsParametro, '.');
  if (vConsulta > 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Não é permitido casas decimais (parâmetro DS_LST_CICLO_CUSTO)!', cDS_METHOD);
    return(-1); exit;
  end;

  vNrAux := '';
  vNrAux2 := '';
  vDsParametro := itemXmlF('VL_PARAMETRO', pParams);
  while (vDsParametro <> '') do begin
    if (vNrAux = '') then begin
      vPos := gscan(vDsParametro, ', ');
      vNrAux := vDsParametro[1, vPos - 1];
      vLimpa := gltrim(vDsParametro, vDsParametro[1, vPos]);
      vDsParametro := vLimpa;
    end else begin
      vNrAux2 := vDsParametro;
      vDsParametro := '';
    end;
  end;
  if (vNrAux > vNrAux2) then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Primeiro valor não pode ser maior que o segundo valor (parâmetro DS_LST_CICLO_CUSTO)!', cDS_METHOD);
    return(-1); exit;
  end;

  return(0); exit;

end;

//-----------------------------------------------------------
function T_ADMSVCO025.OBRIG_CLASS(pParams : String) : String;
//-----------------------------------------------------------
const
  cDS_METHOD = 'ADICONAL=Operação: T_ADMSVCO025.OBRIG_CLASS()';
begin
  if (itemXml('VL_PARAMETRO', pParams) <> 0)  and (itemXml('VL_PARAMETRO', pParams) <> 1)  and (itemXml('VL_PARAMETRO', pParams) <> 2) then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Valor informado não permitido!', cDS_METHOD);
    return(-1); exit;
  end;

  return(0); exit;

end;

//-----------------------------------------------------------------
function T_ADMSVCO025.CD_TIPOEMAIL_MULT(pParams : String) : String;
//-----------------------------------------------------------------
const
  cDS_METHOD = 'ADICONAL=Operação: T_ADMSVCO025.CD_TIPOEMAIL_MULT()';
var
  (* string piGlobal :IN *)
  vinTipoEmail : Boolean;
  vDsLstTipoEmail, vCdTipoEmail, vDsLista : String;
  vPos, vTam, v : Real;
begin
  vinTipoEmail := False;

  vDsLstTipoEmail := itemXmlF('VL_PARAMETRO', pParams);

  scan vDsLstTipoEmail, '.';
  vPos := gresult;
  if (vPos <= 0) then begin
    scan vDsLstTipoEmail, ', ';
    vPos := gresult;
  end;
  if (vPos > 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', , '');
    return(-1); exit;
  end;

  vDsLstTipoEmail := greplace(vDsLstTipoEmail, 1, ';
  vDsLstTipoEmail := greplace(vDsLstTipoEmail, 1, ' ', '', -1);
  vTam := glength(vDsLstTipoEmail);
  vnumeric := vDsLstTipoEmail;
  vDsLstTipoEmail := vnumeric;
  if (glength(vDsLstTipoEmail) <> vTam) then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', , '');
    return(-1); exit;
  end;

  vDsLstTipoEmail := itemXmlF('VL_PARAMETRO', pParams);

  vDsLista := '';
  if (vDsLstTipoEmail <> '') then begin
    scan vDsLstTipoEmail, ';
    vPos := gresult;
    vTam := glength(vDsLstTipoEmail);

    while (vDsLstTipoEmail <> '') do begin
      if (vPos >0) then begin
        vPos := vPos-1;
        vCdTipoEmail := vDsLstTipoEmail[1, vPos];
        vPos := vPos + 2;
        vDsLstTipoEmail := vDsLstTipoEmail[vPos, vTam];
      end else begin
        vCdTipoEmail := vDsLstTipoEmail;
        vDsLstTipoEmail := '';
      end;
      if (vCdTipoEmail = '') then begin
        Result := SetStatus(STS_ERROR, 'GEN0001', 'Tipo(s) de e-mail(s) não informado!', cDS_METHOD);
        return(-1); exit;
      end;

      clear_e(tPES_TIPOEMAIL);
      putitem_e(tPES_TIPOEMAIL, 'CD_TIPOEMAIL', vCdTipoEmail);
      retrieve_e(tPES_TIPOEMAIL);
      if (xStatus < 0) then begin
        if (vDsLista = '') then begin
          vDsLista := vCdTipoEmail;
        end else begin
          vDsLista := '' + vDsLista/' + FloatToStr(vCdTipoEmail') + ' + ';
        end;
      end;

      scan vDsLstTipoEmail, ';
      vPos := gresult;
      vTam := glength(vDsLstTipoEmail);
    end;
  end;
  if (vDsLista <> '') then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Tipo(s) de e-mails ' + vDsLista + ' não cadastrado!', cDS_METHOD);
    return(-1); exit;
  end;

  return(0); exit;
end;

//-----------------------------------------------------------------
function T_ADMSVCO025.CD_TIPOVERBA_MULT(pParams : String) : String;
//-----------------------------------------------------------------
const
  cDS_METHOD = 'ADICONAL=Operação: T_ADMSVCO025.CD_TIPOVERBA_MULT()';
var
  (* string piGlobal :IN *)
  vDsRegistro, vDsConteudo : String;
begin
  vDsConteudo := itemXmlF('VL_PARAMETRO', pParams);
  vDsConteudo := greplace(vDsConteudo, 1, ';

  if (vDsConteudo <> '') then begin
    repeat
      getitem(vDsRegistro, vDsConteudo, 1);
      clear_e(tPES_TIPOVERBA);
      putitem_e(tPES_TIPOVERBA, 'CD_TIPOVERBA', vDsRegistro);
      retrieve_e(tPES_TIPOVERBA);
      if (xStatus < 0) then begin
        Result := SetStatus(STS_ERROR, 'GEN0001', 'Tipo de Verba ' + vDsRegistro + ' inválido!', cDS_METHOD);
        return(-1); exit;
      end;
      delitem( vDsConteudo, 1);
    until (vDsConteudo = '');
  end;

  return(0); exit;

end;

//------------------------------------------------------------------
function T_ADMSVCO025.TAM_IMAGEM_SCANNER(pParams : String) : String;
//------------------------------------------------------------------
const
  cDS_METHOD = 'ADICONAL=Operação: T_ADMSVCO025.TAM_IMAGEM_SCANNER()';
var
  (* string piGlobal :IN *)
  vNrTamanho : Real;
begin
  vNrTamanho := greplace(itemXml('VL_PARAMETRO', pParams), 1, ', ', '.', -1);

  if (vNrTamanho[fraction] > 0 ) or (vNrTamanho < 1 ) or (vNrTamanho > 300) then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'O valor digitado precisa ser um numérico inteiro entre 001 e 300!', cDS_METHOD);
    return(-1); exit;
  end;
  if (vNrTamanho > 100) then begin
    askmess 'Tamanho maior do que 100 só deve ser utilizado em servidores externos.  Nos servidores internos pode causar lentidão.  Confirma?', 'Sim, Não';
    if (xStatus = 2) then begin
      Result := SetStatus(STS_AVISO, 'GEN0001', , cDS_METHOD);
      return(-1); exit;
    end;
  end;

  return(0); exit;
end;

//------------------------------------------------------------------
function T_ADMSVCO025.FOR_IMAGEM_SCANNER(pParams : String) : String;
//------------------------------------------------------------------
const
  cDS_METHOD = 'ADICONAL=Operação: T_ADMSVCO025.FOR_IMAGEM_SCANNER()';
var
  (* string piGlobal :IN *)
  vDsParametro, vDsItem : String;
  vNrTamanho : Real;
begin
  vDsParametro := greplace(itemXml('VL_PARAMETRO', pParams), 1, ';

  repeat
    getitem(vDsItem, vDsParametro, 1);
    if (glength(vDsItem) <> 3) then begin
      Result := SetStatus(STS_ERROR, 'GEN0001', 'Extenção inválida!', cDS_METHOD);
      return(-1); exit;
    end;
    delitem(vDsParametro, 1);
  until (vDsParametro = '');

  return(0); exit;
end;

//------------------------------------------------------------
function T_ADMSVCO025.ACEITA_0_1_2(pParams : String) : String;
//------------------------------------------------------------
const
  cDS_METHOD = 'ADICONAL=Operação: T_ADMSVCO025.ACEITA_0_1_2()';
var
  (* string piGlobal :IN *)
  vDsParametro : String;
begin
  vDsParametro := itemXmlF('VL_PARAMETRO', pParams);

  if (vDsParametro <> '0')  and (vDsParametro <> '1')  and (vDsParametro <> '2') then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Valor inválido!', cDS_METHOD);
    return(-1); exit;
  end;

  return(0); exit;
end;

//-----------------------------------------------------------------
function T_ADMSVCO025.PESFL038_EXIBICAO(pParams : String) : String;
//-----------------------------------------------------------------
const
  cDS_METHOD = 'ADICONAL=Operação: T_ADMSVCO025.PESFL038_EXIBICAO()';
var
  (* string piGlobal :IN *)
  vCdParametro : Real;
begin
  vCdParametro := itemXmlF('VL_PARAMETRO', pParams);
  if (vCdParametro = '') then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Valor não informado!', cDS_METHOD);
    return(-1); exit;
  end;
  if (vCdParametro <= 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Valor informado é inválido!', cDS_METHOD);
    return(-1); exit;
  end;
  if (vCdParametro > 4) then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Valor informado não deve ser maior que 4!', cDS_METHOD);
    return(-1); exit;
  end;

  return(0); exit;
end;

//---------------------------------------------------------------
function T_ADMSVCO025.IN_TP_CAD_AUTOM(pParams : String) : String;
//---------------------------------------------------------------
const
  cDS_METHOD = 'ADICONAL=Operação: T_ADMSVCO025.IN_TP_CAD_AUTOM()';
var
  (* string piGlobal :IN *)
  vDsIndicador : String;
begin
  vDsIndicador := itemXmlF('VL_PARAMETRO', pParams);

  if (vDsIndicador <> '3')  and (vDsIndicador <> '9') then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Valor inválido! Os valores válidos são 3(normal) ou 9(em análise)!', cDS_METHOD);
    return(-1); exit;
  end;

  return(0); exit;
end;

//-----------------------------------------------------------------
function T_ADMSVCO025.IN_OBRIG_endERECO(pParams : String) : String;
//-----------------------------------------------------------------
const
  cDS_METHOD = 'ADICONAL=Operação: T_ADMSVCO025.IN_OBRIG_endERECO()';
var
  (* string piGlobal :IN *)
  vInObrigendereco : String;
begin
  vInObrigendereco := itemXmlF('VL_PARAMETRO', pParams);
  if (vInObrigendereco <> 0 ) and (vInObrigendereco <> 1 ) and (vInObrigendereco <> 2 ) and (vInObrigendereco <> 3) then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Parâmetro inválido!', cDS_METHOD);
    return(-1); exit;
  end;

  return(0); exit;
end;

//--------------------------------------------------------------------
function T_ADMSVCO025.CD_PESSOA_end_PADRAO(pParams : String) : String;
//--------------------------------------------------------------------
const
  cDS_METHOD = 'ADICONAL=Operação: T_ADMSVCO025.CD_PESSOA_end_PADRAO()';
var
  (* string piGlobal :IN *)
  viParams, voParams : String;
  vNrSeqendereco : Real;
begin
  clear_e(tPES_PESSOA);
  putitem_e(tPES_PESSOA, 'CD_PESSOA', itemXmlF('VL_PARAMETRO', pParams));
  retrieve_e(tPES_PESSOA);
  if (xStatus < 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Pessoa não cadastrada!', cDS_METHOD);
    return(-1); exit;
  end;

  viParams := '';

  vNrSeqendereco := 0;
  putitemXml(viParams, 'CD_PESSOA', item_f('CD_PESSOA', tPES_PESSOA));
  voParams := activateCmp('PESSVCO005', 'buscaenderecoFaturamento', viParams);
  if (xStatus < 0) then begin
    Result := voParams;
    return(-1); exit;
  end;
  vNrSeqendereco := itemXmlF('NR_SEQendERECO', voParams);

  if (vNrSeqendereco > 0) then begin
    clear_e(tPES_ENDERECO);
    putitem_e(tPES_ENDERECO, 'CD_PESSOA', item_f('CD_PESSOA', tPES_PESSOA));
    putitem_e(tPES_ENDERECO, 'NR_SEQUENCIA', vNrSeqendereco);
    retrieve_e(tPES_ENDERECO);
    if (xStatus < 0) then begin
      Result := SetStatus(STS_ERROR, 'GEN0001', 'Pessoa sem endereço cadastrado!', cDS_METHOD);
      return(-1); exit;
    end;
  end else begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Pessoa sem endereço cadastrado!', cDS_METHOD);
    return(-1); exit;
  end;

  return(0); exit;
end;

//----------------------------------------------------------------
function T_ADMSVCO025.CD_OP_FAT_BRINDE(pParams : String) : String;
//----------------------------------------------------------------
const
  cDS_METHOD = 'ADICONAL=Operação: T_ADMSVCO025.CD_OP_FAT_BRINDE()';
var
  (* string piGlobal :IN *)
  vCdOperacao : Real;
begin
  vCdOperacao := itemXmlF('VL_PARAMETRO', pParams);
  if (vCdOperacao = '') then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Operacao não informada!', cDS_METHOD);
    return(-1); exit;
  end;
  clear 'GER_OPERACAOSVC';
  putitem_e(tGER_OPERACAO, 'CD_OPERACAO', vCdOperacao);
  retrieve_e(tGER_OPERACAO);
  if (xStatus < 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Operacao invalida!', cDS_METHOD);
    return(-1); exit;
  end;
  return(0); exit;
end;

//--------------------------------------------------------------------
function T_ADMSVCO025.CD_CONCEITO_ULT_COMP(pParams : String) : String;
//--------------------------------------------------------------------
const
  cDS_METHOD = 'ADICONAL=Operação: T_ADMSVCO025.CD_CONCEITO_ULT_COMP()';
var
  (* string piGlobal :IN *)
  vCdConceitoUltCompra : Real;
begin
  vCdConceitoUltCompra := itemXmlF('VL_PARAMETRO', pParams);
  if   (vCdConceitoUltCompra <> 1 ) and (vCdConceitoUltCompra <> 2);
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Tipo de conceito de última compra inválido! Valores válidos: 1=Conceito padrão:Compra individuais 2=Soma das compras por dia', cDS_METHOD);
    return(-1); exit;
  end;

  return(0); exit;
end;

//--------------------------------------------------------------
function T_ADMSVCO025.IN_CADASTRA_PF(pParams : String) : String;
//--------------------------------------------------------------
const
  cDS_METHOD = 'ADICONAL=Operação: T_ADMSVCO025.IN_CADASTRA_PF()';
begin
  if ((itemXml('VL_PARAMETRO', pParams) <> 0)  and (itemXml('VL_PARAMETRO', pParams) <> 1)  and (itemXml('VL_PARAMETRO', pParams) <> 2)  and (itemXml('VL_PARAMETRO', pParams) <> 3)) then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Valor do parâmetro não permitido.', cDS_METHOD);
    return(-1); exit;
  end;

  return(0); exit;
end;

//--------------------------------------------------------------------
function T_ADMSVCO025.IN_USA_COND_PGTO_ESP(pParams : String) : String;
//--------------------------------------------------------------------
const
  cDS_METHOD = 'ADICONAL=Operação: T_ADMSVCO025.IN_USA_COND_PGTO_ESP()';
var
  (* string piGlobal :IN *)
  vTpCondPgtoEspecial : Real;
begin
  vTpCondPgtoEspecial= itemXmlF('VL_PARAMETRO', pParams);
  if (vTpCondPgtoEspecial <> 0 ) and (vTpCondPgtoEspecial <> 1) then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Parâmetro inválido!', cDS_METHOD);
    return(-1); exit;
  end;
  return(0); exit;
end;

//-----------------------------------------------------------
function T_ADMSVCO025.CD_EMAILFOR(pParams : String) : String;
//-----------------------------------------------------------
const
  cDS_METHOD = 'ADICONAL=Operação: T_ADMSVCO025.CD_EMAILFOR()';
var
  (* string piGlobal :IN *)
  vCdTipoEmail : Real;
begin
  vCdTipoEmail := itemXmlF('VL_PARAMETRO', pParams);

  clear_e(tPES_TIPOEMAIL);
  putitem_e(tPES_TIPOEMAIL, 'CD_TIPOEMAIL', vCdTipoEmail);
  retrieve_e(tPES_TIPOEMAIL);
  if (xStatus < 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Tipo de e-mail não cadastrado!', cDS_METHOD);
    return(-1); exit;
  end;

  return(0); exit;
end;

//-----------------------------------------------------------
function T_ADMSVCO025.PERCENTUAIS(pParams : String) : String;
//-----------------------------------------------------------
const
  cDS_METHOD = 'ADICONAL=Operação: T_ADMSVCO025.PERCENTUAIS()';
var
  (* string piGlobal :IN *)
  vDsParametro, vDsRegistro, vAux : String;
  vNrContador, vNrAux : Real;
begin
  vDsParametro := itemXmlF('VL_PARAMETRO', pParams);
  if (vDsParametro = '') then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Parâmetro não informado!', cDS_METHOD);
    return(-1); exit;
  end;

  vDsParametro := greplace(vDsParametro, 1, ';

  vNrContador := 0;
  repeat
    getitem(vDsRegistro, vDsParametro, 1);

    vNrAux := vDsRegistro;
    vstringAux := vDsRegistro;
    if (vNrAux <> vstringAux) then begin
      Result := SetStatus(STS_ERROR, 'GEN0001', 'Valor deverá ser númerico!', cDS_METHOD);
      return(-1); exit;
    end;
    if (vNrAux < 000.00)  or (vNrAux > 999.99) then begin
      Result := SetStatus(STS_ERROR, 'GEN0001', 'Valor inválido! Deve ser informado um ou dois percentuais entre 000.00 e 999.99 separados por ponto-e-virgula!', cDS_METHOD);
      return(-1); exit;
    end;

    vNrContador := vNrContador + 1;

    delitem( vDsParametro, 1);
  until (vDsParametro = '');

  if (vNrContador < 1)  or (vNrContador > 2) then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Valor inválido! Deve ser informado um ou dois percentuais entre 000.00 e 999.99 separados por ponto-e-virgula!', cDS_METHOD);
    return(-1); exit;
  end;

  return(0); exit;
end;

//--------------------------------------------------------------
function T_ADMSVCO025.VALIDADE_SENHA(pParams : String) : String;
//--------------------------------------------------------------
const
  cDS_METHOD = 'ADICONAL=Operação: T_ADMSVCO025.VALIDADE_SENHA()';
var
  (* string piGlobal :IN *)
  vNrDiasValSenha : Real;
begin
  vNrDiasValSenha := itemXmlF('VL_PARAMETRO', pParams);

  if (vNrDiasValSenha <> 0 ) and (vNrDiasValSenha <> '') then begin
    if (vNrDiasValSenha < 30 ) or (vNrDiasValSenha > 180) then begin
      Result := SetStatus(STS_ERROR, 'GEN0001', 'Número de dias não esta contido entre 30 a 180 dias, verifique!', cDS_METHOD);
      return(-1); exit;
    end;
  end;

  return(0); exit;
end;

//------------------------------------------------------------
function T_ADMSVCO025.NR_EMPCTAPES(pParams : String) : String;
//------------------------------------------------------------
const
  cDS_METHOD = 'ADICONAL=Operação: T_ADMSVCO025.NR_EMPCTAPES()';
var
  (* string piGlobal :IN *)
  viParams, voParams, voLstparams : String;
  vTpManBco, vTpManForn, vTpManCliente, vTpManCxMatriz, vTpManCxFilial, vTpManCxUsuario, vTpManCxFundo, vTpManCxTransicao : Real;
begin
  voLstparams := '';
  viParams := 'CD_TPMANUT_BANCO;
  xParam := T_ADMSVCO001.GetParametro(xParam);

  clear_e(tFCC_CTAPES);
  putitem_e(tFCC_CTAPES, 'NR_CTAPES', itemXmlF('VL_PARAMETRO', pParams));
  retrieve_e(tFCC_CTAPES);
  if (xStatus < 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Conta Corrente não cadastrada!', cDS_METHOD);
    return(-1); exit;
  end;
  if (item_f('CD_EMPRESA', tFCC_CTAPES) <> itemXmlF('CD_EMPRESA', pParams)) then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Conta Corrente não pertence a empresa!', cDS_METHOD);
    return(-1); exit;
  end;
  if (item_f('TP_MANUTENCAO', tFCC_CTAPES) = vTpManCxMatriz)  or %\ then begin
    (putitem_e(tFCC_CTAPES, 'TP_MANUTENCAO', vTpManCxFilial)  or
    (putitem_e(tFCC_CTAPES, 'TP_MANUTENCAO', vTpManCxUsuario)  or
    (putitem_e(tFCC_CTAPES, 'TP_MANUTENCAO', vTpManCxFundo)  or
    (putitem_e(tFCC_CTAPES, 'TP_MANUTENCAO', vTpManCxTransicao));

    Result := SetStatus(STS_ERROR, 'GEN0001', 'Conta Corrente informada não pode ser do TIPO MANUTENCAO CAIXA!', cDS_METHOD);
    return(-1); exit;
  end;

  return(0); exit;
end;

//-------------------------------------------------------------
function T_ADMSVCO025.VALIDARCTAPES(pParams : String) : String;
//-------------------------------------------------------------
const
  cDS_METHOD = 'ADICONAL=Operação: T_ADMSVCO025.VALIDARCTAPES()';
var
  (* string piGlobal :IN *)
  viParams, voParams : String;
  vTpManendosso, vTpManRedutora, vTpManCxMatriz, vTpManCxFilial : Real;
  vTpManCxFundo, vTpManCxTransicao, vNrCtaPes : Real;
begin
  vNrCtaPes := itemXmlF('VL_PARAMETRO', pParams);

  if (vNrCtaPes = 0 ) and (vNrCtaPes = '') then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Parâmetro não informado.', cDS_METHOD);
    return(-1); exit;
  end;

  clear_e(tFCC_CTAPES);
  putitem_e(tFCC_CTAPES, 'NR_CTAPES', vNrCtaPes);
  retrieve_e(tFCC_CTAPES);
  if (xStatus < 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Conta Corrente não cadastrada!', cDS_METHOD);
    return(-1); exit;
  end;

  viParams := '';
  putitem(viParams,  'CD_TPMANUT_CXMATRIZ');
  putitem(viParams,  'CD_TPMANUT_CXFILIAL');
  putitem(viParams,  'CD_TPMANUT_CXFUNDO');
  putitem(viParams,  'CD_TPMANUT_CXTRANSITORIA');
  putitem(viParams,  'CD_TPMANUT_endOSSO');
  putitem(viParams,  'CD_TPMANUT_REDUTORA');
  xParam := T_ADMSVCO001.GetParametro(xParam);
  end;
  if (item_f('TP_MANUTENCAO', tFCC_CTAPES) <> vTpManCxMatriz)  and %\ then begin
    (item_f('TP_MANUTENCAO', tFCC_CTAPES) <> vTpManCxFilial)  and
    (item_f('TP_MANUTENCAO', tFCC_CTAPES) <> vTpManCxFundo)  and
    (item_f('TP_MANUTENCAO', tFCC_CTAPES) <> vTpManCxTransicao)  and
    (item_f('TP_MANUTENCAO', tFCC_CTAPES) <> vTpManendosso)  and
    (item_f('TP_MANUTENCAO', tFCC_CTAPES) <> vTpManRedutora);
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Conta Corrente informada deve ser do TIPO MANUTENCAO: Caixa Matriz, Caixa Filial, Caixa Fundo, Caixa Transitória, endosso ou Redutora.', cDS_METHOD);
    return(-1); exit;
  end;
  if (itemXml('CD_PARAMETRO', pParams) = 'CD_CTAPES_CXMATRIZ') then begin
    if (vTpManCxMatriz = '')  or (vTpManCxMatriz = 0) then begin
      Result := SetStatus(STS_ERROR, 'GEN001', , cDS_METHOD);
      return(-1); exit;
    end;
    if (item_f('TP_MANUTENCAO', tFCC_CTAPES) <> vTpManCxMatriz) then begin
      Result := SetStatus(STS_ERROR, 'GEN001', , cDS_METHOD);
      return(-1); exit;
    end;
  end else if (itemXml('CD_PARAMETRO', pParams) = 'CD_CTAPES_CXFILIAL') then begin
    if (item_f('TP_MANUTENCAO', tFCC_CTAPES) <> vTpManCxFilial) then begin
      Result := SetStatus(STS_ERROR, 'GEN001', , cDS_METHOD);
      return(-1); exit;
    end;
  end else if (itemXml('CD_PARAMETRO', pParams) = 'CD_CTAPES_CXFUNDO') then begin
    if (item_f('TP_MANUTENCAO', tFCC_CTAPES) <> vTpManCxFundo) then begin
      Result := SetStatus(STS_ERROR, 'GEN001', , cDS_METHOD);
      return(-1); exit;
    end;
  end else if (itemXml('CD_PARAMETRO', pParams) = 'CD_CTAPES_CXTRANSITORIA') then begin
    if (item_f('TP_MANUTENCAO', tFCC_CTAPES) <> vTpManCxTransicao) then begin
      Result := SetStatus(STS_ERROR, 'GEN001', , cDS_METHOD);
      return(-1); exit;
    end;
  end else if (itemXml('CD_PARAMETRO', pParams) = 'CD_CTAPES_endOSSO') then begin
    if (item_f('TP_MANUTENCAO', tFCC_CTAPES) <> vTpManendosso) then begin
      Result := SetStatus(STS_ERROR, 'GEN001', , cDS_METHOD);
      return(-1); exit;
    end;
  end else if (itemXml('CD_PARAMETRO', pParams) = 'CD_CTAPES_REDUTORA') then begin
    if (item_f('TP_MANUTENCAO', tFCC_CTAPES) <> vTpManRedutora) then begin
      Result := SetStatus(STS_ERROR, 'GEN001', , cDS_METHOD);
      return(-1); exit;
    end;
  end;

  viParams := '';
  putitemXml(viParams, 'CD_EMPRESA', item_f('CD_EMPRESA', tFCC_CTAPES));
  putitemXml(viParams, 'IN_CCUSTO', True);
  putitemXml(viParams, 'CD_COMPONENTE', itemXmlF('CD_COMPONENTE', pParams));
  if (itemXml('CD_EMPRESA', pParams) <> '') then begin
    putitemXml(viParams, 'CD_EMPRESALOG', itemXmlF('CD_EMPRESA', pParams));
  end;
  voParams := activateCmp('FGRSVCO001', 'validarEmpresa', viParams);
  if (xStatus < 0) then begin
    Result := voParams;
    return(-1); exit;
  end;
  if (itemXml('LST_EMPRESA', voParams) = '') then begin
    Result := SetStatus(STS_ERROR, 'GEN001', , cDS_METHOD);
    return(-1); exit;
  end;

  return(0); exit;
end;

//-----------------------------------------------------------------
function T_ADMSVCO025.NR_CICLO_ATUAL_OS(pParams : String) : String;
//-----------------------------------------------------------------
const
  cDS_METHOD = 'ADICONAL=Operação: T_ADMSVCO025.NR_CICLO_ATUAL_OS()';
begin
  clear_e(tODS_CICLO);
  putitem_e(tODS_CICLO, 'CD_EMPRESA', itemXmlF('CD_EMPRESA', piGlobal));
  putitem_e(tODS_CICLO, 'NR_CICLO', itemXmlF('VL_PARAMETRO', pParams));
  retrieve_e(tODS_CICLO);
  if (xStatus < 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Ciclo não encontrado!', cDS_METHOD);
    return(-1); exit;
  end;
  if (item_b('IN_FECHADO', tODS_CICLO) = True) then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Ciclo já fechado!', cDS_METHOD);
    return(-1); exit;
  end;

  return(0); exit;
end;

//-----------------------------------------------------------------
function T_ADMSVCO025.CD_CAMPO_ADIC_FCP(pParams : String) : String;
//-----------------------------------------------------------------
const
  cDS_METHOD = 'ADICONAL=Operação: T_ADMSVCO025.CD_CAMPO_ADIC_FCP()';
begin
  clear_e(tFCP_TIPOCAMPO);
  putitem_e(tFCP_TIPOCAMPO, 'CD_TIPOCAMPO', itemXmlF('VL_PARAMETRO', pParams));
  retrieve_e(tFCP_TIPOCAMPO);
  if (xStatus < 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Campo adicional de duplicata não cadastrado!', cDS_METHOD);
    return(-1); exit;
  end;

  return(0); exit;
end;

//-------------------------------------------------------------
function T_ADMSVCO025.CD_CCUSTO_FIN(pParams : String) : String;
//-------------------------------------------------------------
const
  cDS_METHOD = 'ADICONAL=Operação: T_ADMSVCO025.CD_CCUSTO_FIN()';
begin
  clear_e(tGEC_CCUSTO);
  putitem_e(tGEC_CCUSTO, 'CD_CCUSTO', itemXmlF('VL_PARAMETRO', pParams));
  retrieve_e(tGEC_CCUSTO);
  if (xStatus < 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Centro de custo inválido!', cDS_METHOD);
    return(-1); exit;
  end;

  return(0); exit;
end;

//--------------------------------------------------------------------
function T_ADMSVCO025.VALIDA_COB_BANCO_REC(pParams : String) : String;
//--------------------------------------------------------------------
const
  cDS_METHOD = 'ADICONAL=Operação: T_ADMSVCO025.VALIDA_COB_BANCO_REC()';
var
  (* string piGlobal :IN *)
  vDsCobBanco, vDsCobBancoSai : String;
  vTpCobranca : Real;
begin
  vDsCobBanco := itemXmlF('VL_PARAMETRO', pParams);
  vDsCobBancoSai := '*';
  repeat
    getitem(vTpCobranca, vDsCobBanco, 1);
    if (vTpCobranca = 1)  or (vTpCobranca = 2)  or (vTpCobranca = 3)  or (vTpCobranca = 4)  or (vTpCobranca = 6) then begin
      if (vDsCobBancoSai = '*') then begin
        vDsCobBancoSai := '';
      end;
      putitem(vDsCobBancoSai,  vTpCobranca);
    end;
    delitem(vDsCobBanco, 1);
  until (vDsCobBanco = '');

  putitemXml(Result, 'VL_PARAMETRO', vDsCobBancoSai);

  return(0); exit;
end;

//------------------------------------------------------------
function T_ADMSVCO025.CONSISTE_DIA(pParams : String) : String;
//------------------------------------------------------------
const
  cDS_METHOD = 'ADICONAL=Operação: T_ADMSVCO025.CONSISTE_DIA()';
var
  (* string piGlobal :IN *)
  vDiaMes : Real;
begin
  vDiaMes := itemXmlF('VL_PARAMETRO', pParams);
  if (vDiaMes < 1 ) or (vDiaMes > 27) then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Valor inválido! Os valores válidos devem estar entre 01 e 27!', cDS_METHOD);
    return(-1); exit;
  end;

  return(0); exit;
end;

//------------------------------------------------------------------
function T_ADMSVCO025.CD_CLIENTE_PDV_EMP(pParams : String) : String;
//------------------------------------------------------------------
const
  cDS_METHOD = 'ADICONAL=Operação: T_ADMSVCO025.CD_CLIENTE_PDV_EMP()';
var
  (* string piGlobal :IN *)
  vCdPessoa, vNrSeqendereco, vCdEmpresa : Real;
  viParams, voParams : String;
begin
  vCdEmpresa := itemXmlF('CD_EMPRESA', pParams);
  if (vCdEmpresa = 0) then begin
    vCdEmpresa := itemXmlF('CD_EMPRESA', piGlobal);
  end;

  vCdPessoa := itemXmlF('CD_PESSOA', pParams);
  if (vCdPessoa = 0) then begin
    vCdPessoa := itemXmlF('VL_PARAMETRO', pParams);
  end;
  if (vCdPessoa = 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Pessoa não informada!', cDS_METHOD);
    return(-1); exit;
  end;

  clear_e(tPES_PESSOA);
  putitem_e(tPES_PESSOA, 'CD_PESSOA', vCdPessoa);
  retrieve_e(tPES_PESSOA);
  if (xStatus < 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Pessoa ' + FloatToStr(vCdPessoa) + ' não cadastrada!', cDS_METHOD);
    return(-1); exit;
  end;

  getParams(pParams); (* vCdEmpresa *)
  if (xStatus < 0) then begin
    return(-1); exit;
  end;

  putitemXml(viParams, 'CD_PESSOA', vCdPessoa);
  voParams := activateCmp('PESSVCO005', 'buscaenderecoFaturamento', viParams);
  if (xStatus < 0) then begin
    Result := voParams;
    return(-1); exit;
  end;

  vNrSeqendereco := itemXmlF('NR_SEQendERECO', voParams);

  if (vNrSeqendereco = 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Sequência de endereço não encontrada para a pessoa ' + FloatToStr(vCdPessoa) + '!', cDS_METHOD);
    return(-1); exit;
  end;

  clear_e(tV_PES_ENDEREC);
  putitem_e(tV_PES_ENDEREC, 'CD_PESSOA', vCdPessoa);
  putitem_e(tV_PES_ENDEREC, 'NR_SEQUENCIA', vNrSeqendereco);
  retrieve_e(tV_PES_ENDEREC);
  if (xStatus < 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Sequência de endereço ' + FloatToStr(vNrSeqendereco) + ' não encontrada para a pessoa ' + FloatToStr(vCdPessoa) + '!', cDS_METHOD);
    return(-1); exit;
  end;
  if (item_a('DS_SIGLAESTADO', tV_PES_ENDEREC) <> gufOrigem) then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Parâmetro CD_CLIENTE_PDV_EMP não esta configurado corretamente ou UF do cliente consumidor final está incorreta!', cDS_METHOD);
    return(-1); exit;
  end;

  return(0); exit;
end;

end.