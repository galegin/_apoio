unit cFISSVCO032;

interface

(* COMPONENTES 
  ADMSVCO001 / PESSVCO005 / PRDSVCO004 / PRDSVCO006 / PRDSVCO007

*)        

uses
  Classes, SysUtils, DB,
  cServiceUnf, cDataSetUnf;

type
  T_FISSVCO032 = class(TcServiceUnf)
  private
    tCTB_CONFIGEMP,
    tFCP_DUPLICATI,
    tFCR_FATURAI,
    tFIS_CFOP,
    tFIS_CONTSOCIO,
    tFIS_ECF,
    tFIS_NFE,
    tFIS_NFECF,
    tFIS_NFIMPOSTO,
    tFIS_NFITEMIMP,
    tFIS_SALDOIMPO,
    tFIS_TIPI,
    tGLB_ESTADO,
    tGLB_LOGRADOUR,
    tGLB_MUNIBGE,
    tGLB_PAIS,
    tPES_CLIENTE,
    tPES_CONTATO,
    tPES_EMAIL,
    tPES_ENDERECO,
    tPES_PESFISICA,
    tPES_PESJURIDI,
    tPES_PESSOA,
    tPES_TELEFONE,
    tPES_TIPOCONTA,
    tPRD_PESSALDO,
    tPRD_PRDGRADE,
    tPRD_PRDINFO,
    tV_GLB_MUNICIP,
    tV_PES_ENDEREC,
    tV_PES_INDIC : TcDatasetUnf;
    function getParam(pParams : String = '') : String;
    function setEntidade(pParams : String = '') : String;
  protected
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;    
  published
    function buscaContato(pParams : String = '') : String;
    function INIT(pParams : String = '') : String;
    function CLEANUP(pParams : String = '') : String;
    function achaGrupo(pParams : String = '') : String;
    function buscaQt(pParams : String = '') : String;
    function buscaValorSaldo(pParams : String = '') : String;
    function buscaDadosSocios(pParams : String = '') : String;
    function carregaPesJuridica(pParams : String = '') : String;
    function carregaPesFisica(pParams : String = '') : String;
    function carregaLogradouro(pParams : String = '') : String;
    function carregaContSocio(pParams : String = '') : String;
    function carregaMunIBGE(pParams : String = '') : String;
    function carregaFisNfImposto(pParams : String = '') : String;
    function carregaFisNfItemImposto(pParams : String = '') : String;
    function carregaFisTipi(pParams : String = '') : String;
    function carregaFisEcf(pParams : String = '') : String;
    function carregaVPesIndic(pParams : String = '') : String;
    function carregaFisCfop(pParams : String = '') : String;
    function carregaPesCliente(pParams : String = '') : String;
    function carregaPesTelefone(pParams : String = '') : String;
    function carregaPesEmail(pParams : String = '') : String;
    function carregaPessoa(pParams : String = '') : String;
    function carregaendereco(pParams : String = '') : String;
    function carregaVendereco(pParams : String = '') : String;
    function carregaPais(pParams : String = '') : String;
    function buscaParcelasFCP(pParams : String = '') : String;
    function buscaParcelasFCR(pParams : String = '') : String;
  end;

implementation

uses
  cADMSVCO001,
  cActivate, cStatus, cFuncao, cXml, dModulo;

var
  gCdTipoFax,
  gCdTipoFone : String;

//---------------------------------------------------------------
constructor T_FISSVCO032.Create(AOwner: TComponent);
//---------------------------------------------------------------
begin
  inherited Create(AOwner);
  setEntidade('');
end;

//--------------------------------
destructor T_FISSVCO032.Destroy;
//--------------------------------
begin
  inherited Destroy;
end;

//---------------------------------------------------------------
function T_FISSVCO032.getParam(pParams : String) : String;
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
  putitem(xParam, 'CD_PESSOA');
  putitem(xParam, 'CD_TIPO_FAX');
  putitem(xParam, 'CD_TIPO_FONE');
  putitem(xParam, 'CD_TIPOCONTATO');
  putitem(xParam, 'DS_TIPOCONTATO');

  xParam := T_ADMSVCO001.GetParametro(xParam);

  gCdTipoFax := itemXml('CD_TIPO_FAX', xParam);
  gCdTipoFone := itemXml('CD_TIPO_FONE', xParam);

  xParamEmp := '';

  xParamEmp := T_ADMSVCO001.GetParamEmpresa(piCdEmpresa, xParamEmp);


end;

//---------------------------------------------------------------
function T_FISSVCO032.setEntidade(pParams : String) : String;
//---------------------------------------------------------------
begin
  tCTB_CONFIGEMP := GetEntidade('CTB_CONFIGEMP');
  tFCP_DUPLICATI := GetEntidade('FCP_DUPLICATI');
  tFCR_FATURAI := GetEntidade('FCR_FATURAI');
  tFIS_CFOP := GetEntidade('FIS_CFOP');
  tFIS_CONTSOCIO := GetEntidade('FIS_CONTSOCIO');
  tFIS_ECF := GetEntidade('FIS_ECF');
  tFIS_NFE := GetEntidade('FIS_NFE');
  tFIS_NFECF := GetEntidade('FIS_NFECF');
  tFIS_NFIMPOSTO := GetEntidade('FIS_NFIMPOSTO');
  tFIS_NFITEMIMP := GetEntidade('FIS_NFITEMIMP');
  tFIS_SALDOIMPO := GetEntidade('FIS_SALDOIMPO');
  tFIS_TIPI := GetEntidade('FIS_TIPI');
  tGLB_ESTADO := GetEntidade('GLB_ESTADO');
  tGLB_LOGRADOUR := GetEntidade('GLB_LOGRADOUR');
  tGLB_MUNIBGE := GetEntidade('GLB_MUNIBGE');
  tGLB_PAIS := GetEntidade('GLB_PAIS');
  tPES_CLIENTE := GetEntidade('PES_CLIENTE');
  tPES_CONTATO := GetEntidade('PES_CONTATO');
  tPES_EMAIL := GetEntidade('PES_EMAIL');
  tPES_ENDERECO := GetEntidade('PES_ENDERECO');
  tPES_PESFISICA := GetEntidade('PES_PESFISICA');
  tPES_PESJURIDI := GetEntidade('PES_PESJURIDI');
  tPES_PESSOA := GetEntidade('PES_PESSOA');
  tPES_TELEFONE := GetEntidade('PES_TELEFONE');
  tPES_TIPOCONTA := GetEntidade('PES_TIPOCONTA');
  tPRD_PESSALDO := GetEntidade('PRD_PESSALDO');
  tPRD_PRDGRADE := GetEntidade('PRD_PRDGRADE');
  tPRD_PRDINFO := GetEntidade('PRD_PRDINFO');
  tV_GLB_MUNICIP := GetEntidade('V_GLB_MUNICIP');
  tV_PES_ENDEREC := GetEntidade('V_PES_ENDEREC');
  tV_PES_INDIC := GetEntidade('V_PES_INDIC');
end;

//------------------------------------------------------------
function T_FISSVCO032.buscaContato(pParams : String) : String;
//------------------------------------------------------------
const
  cDS_METHOD = 'ADICIONAL=Operação: T_FISSVCO032.buscaContato()';
var
  viParams, voParams : String;
begin
  clear_e(tPES_TIPOCONTA);
  putitem_e(tPES_TIPOCONTA, 'DS_TIPOCONTATO', itemXml('DS_TIPOCONTATO', pParams));
  retrieve_e(tPES_TIPOCONTA);
  clear_e(tPES_CONTATO);
  putitem_o(tPES_CONTATO, 'CD_PESSOA', itemXmlF('CD_PESSOA', pParams));
  putitem_o(tPES_CONTATO, 'CD_TIPOCONTATO', item_f('CD_TIPOCONTATO', tPES_TIPOCONTA));
  retrieve_e(tPES_CONTATO);
  if (xStatus >= 0) then begin
    putlistitensocc_e(Result, tPES_CONTATO);
  end;

  return(0); exit;
end;

//----------------------------------------------------
function T_FISSVCO032.INIT(pParams : String) : String;
//----------------------------------------------------
const
  cDS_METHOD = 'ADICIONAL=Operação: T_FISSVCO032.INIT()';
var
  viParams, voParams : String;
begin
  viParams := '';
  putitem(viParams,  'CD_TIPO_FONE');
  putitem(viParams,  'CD_TIPO_FAX');
  xParam := T_ADMSVCO001.GetParametro(xParam); (*,,, *)

  gCdTipoFone := itemXmlF('CD_TIPO_FONE', voParams);
  gCdTipoFax := itemXmlF('CD_TIPO_FAX', voParams);

end;

//-------------------------------------------------------
function T_FISSVCO032.CLEANUP(pParams : String) : String;
//-------------------------------------------------------
const
  cDS_METHOD = 'ADICIONAL=Operação: T_FISSVCO032.CLEANUP()';
begin
end;

//---------------------------------------------------------
function T_FISSVCO032.achaGrupo(pParams : String) : String;
//---------------------------------------------------------
const
  cDS_METHOD = 'ADICIONAL=Operação: T_FISSVCO032.achaGrupo()';
var
  viParams, voParams, vDsLstNivel, vDsGrupo, vDsLstCdGrupo, vCdGrupo : String;
  vCdProduto, vCdSeq : Real;
begin
  vCdProduto := itemXmlF('CD_PRODUTO', pParams);
  vCdSeq := itemXmlF('CD_SEQ', pParams);
  vDsLstCdGrupo := '';
  vDsGrupo := '';
  if (vCdSeq = '') then begin
    clear_e(tPRD_PRDGRADE);
    putitem_o(tPRD_PRDGRADE, 'CD_PRODUTO', vCdProduto);
    retrieve_e(tPRD_PRDGRADE);
  end;
  if (xStatus >=0)  or (vCdSeq <> '') then begin
    viParams := '';
    if (vCdSeq = '') then begin
      putitemXml(viParams, 'CD_SEQGRUPO', item_f('CD_SEQGRUPO', tPRD_PRDGRADE));
    end else begin
      putitemXml(viParams, 'CD_SEQGRUPO', vCdSeq);
    end;
    voParams := activateCmp('PRDSVCO004', 'carregaDadosGrupo', viParams); (*,,,, *)
    if (xStatus < 0) then begin
      Result := voParams;
      return(-1); exit;
    end;
    vDsGrupo := itemXml('DS_GRUPOPARAM', voParams);
    vDsLstNivel := itemXmlF('CD_GRUPOCOMP', voParams);
    if (vDsLstNivel <> '') then begin
      repeat
        getitem(vCdGrupo, vDsLstNivel, 1);
        if (vDsLstCdGrupo = '') then begin
          vDsLstCdGrupo := vCdGrupo;
        end else begin
          vDsLstCdGrupo := '' + vDsLstCdGrupo + ' ' + FloatToStr(vCdGrupo') + ';
        end;
        delitem(vDsLstNivel, 1);
      until (vDsLstNivel = '');
    end;
  end;
  putitemXml(Result, 'CD_PRODUTO', vDsLstCdGrupo);
  putitemXml(Result, 'DS_PRODUTO', vDsGrupo);

  return(0); exit;
end;

//-------------------------------------------------------
function T_FISSVCO032.buscaQt(pParams : String) : String;
//-------------------------------------------------------
const
  cDS_METHOD = 'ADICIONAL=Operação: T_FISSVCO032.buscaQt()';
var
  vCdEmpresa, vCdProduto : String;
  vqtde : Real;
begin
  vCdEmpresa := itemXmlF('CD_EMPRESA', pParams);
  vCdProduto := itemXmlF('CD_PRODUTO', pParams);
  clear_e(tPRD_PESSALDO);
  putitem_o(tPRD_PESSALDO, 'CD_EMPRESA', vCdEmpresa);
  putitem_o(tPRD_PESSALDO, 'CD_PRODUTO', vCdProduto);
  vqtde := 0;
  retrieve_e(tPRD_PESSALDO);
  if (xStatus>0) then begin
    setocc(tPRD_PESSALDO, 1);
    while (xStatus>0) do begin
      vqtde := vqtde + item_f('QT_SALDO', tPRD_PESSALDO);
      setocc(tPRD_PESSALDO, curocc(tPRD_PESSALDO) + 1);
    end;
  end;
  putitemXml(Result, 'VL_QTDE', vqtde);
  return(0); exit;
end;

//---------------------------------------------------------------
function T_FISSVCO032.buscaValorSaldo(pParams : String) : String;
//---------------------------------------------------------------
const
  cDS_METHOD = 'ADICIONAL=Operação: T_FISSVCO032.buscaValorSaldo()';
var
  viParams, viListas, voParams : String;
  vQtSaldo, vTotQtSaldo : Real;
  vCdEmpresa, vCdSeq, vTpCusto, vCdEmpresaValorEmp, vCdEmpresaValorSis, vCdProdutoGrade, vTpSaldo : Real;
  vDtSaldo : TDate;
begin
  vCdEmpresa := itemXmlF('CD_EMPRESA', pParams);
  vCdSeq := itemXmlF('CD_SEQ', pParams);
  vTpCusto := itemXmlF('TP_CUSTO', pParams);
  vTpSaldo := itemXmlF('TP_SALDO', pParams);
  vCdEmpresaValorEmp := itemXmlF('CD_EMPRESAVALOREMP', pParams);
  vCdEmpresaValorSis := itemXmlF('CD_EMPRESAVALORSIS', pParams);
  vDtSaldo := itemXml('DT_SALDO', pParams);
  vCdProdutoGrade := itemXmlF('CD_PRODUTOGRADE', pParams);

  vTotQtSaldo := 0;
  if (vCdProdutoGrade <> 0) then begin
    viParams := '';
    putitemXml(viParams, 'CD_EMPRESA', vCdEmpresa);
    putitemXml(viParams, 'CD_SEQGRUPO', vCdSeq);
    putitemXml(viParams, 'TP_VALOR', 'C');
    putitemXml(viParams, 'CD_VALOR', vTpCusto);
    putitemXml(viParams, 'DT_VALOR', vDtSaldo);
    putitemXml(viParams, 'CD_EMPRESA_VALOR', vCdEmpresaValorEmp);
    putitemXml(viParams, 'CD_EMPVALOR', vCdEmpresaValorSis);
    putitemXml(viParams, 'IN_PROMOCAO', True);
    viListas := '';
    voParams := activateCmp('PRDSVCO007', 'buscaValorData', viParams); (*,,viListas,,, *)
    if (xStatus < 0) then begin
      Result := voParams;
      return(-1); exit;
    end;
    putitemXml(Result, 'VL_VALOR', itemXmlF('VL_VALOR', voParams));

    clear_e(tPRD_PRDGRADE);
    putitem_o(tPRD_PRDGRADE, 'CD_SEQGRUPO', vCdSeq);
    retrieve_e(tPRD_PRDGRADE);
    if (xStatus >= 0) then begin
      setocc(tPRD_PRDGRADE, 1);
      while (xStatus >= 0) do begin
        viParams := '';
        putitemXml(viParams, 'CD_GRUPOEMPRESA', '');
        putitemXml(viParams, 'CD_PRODUTO', item_f('CD_PRODUTO', tPRD_PRDGRADE));
        putitemXml(viParams, 'CD_SALDO', vTpSaldo);
        putitemXml(viParams, 'DT_SALDO', vDtSaldo);
        viListas := vCdEmpresa;
        voParams := activateCmp('PRDSVCO006', 'buscaSaldoData', viParams); (*,,viListas,,, *)
        if (xStatus < 0) then begin
          Result := voParams;
          return(-1); exit;
        end;
        vQtSaldo := itemXmlF('QT_SALDO', voParams);
        vTotQtSaldo := vTotQtSaldo + vQtSaldo;
        setocc(tPRD_PRDGRADE, curocc(tPRD_PRDGRADE) + 1);
      end;
      putitemXml(Result, 'VL_QTSALDO', vTotQtSaldo);
    end;
  end else begin
    clear_e(tPRD_PRDGRADE);
    putitem_o(tPRD_PRDGRADE, 'CD_SEQGRUPO', vCdSeq);
    retrieve_e(tPRD_PRDGRADE);
    if (xStatus >= 0) then begin
      setocc(tPRD_PRDGRADE, 1);
      while (xStatus >= 0) do begin

        viParams := '';
        putitemXml(viParams, 'CD_GRUPOEMPRESA', '');
        putitemXml(viParams, 'CD_PRODUTO', item_f('CD_PRODUTO', tPRD_PRDGRADE));
        putitemXml(viParams, 'CD_SALDO', vTpCusto);
        putitemXml(viParams, 'DT_SALDO', vDtSaldo);
        viListas := vCdEmpresa;
        voParams := activateCmp('PRDSVCO006', 'buscaSaldoData', viParams); (*,,viListas,,, *)
        if (xStatus < 0) then begin
          Result := voParams;
          return(-1); exit;
        end;
        vQtSaldo := itemXmlF('QT_SALDO', voParams);
        vTotQtSaldo := vTotQtSaldo + vQtSaldo;
        setocc(tPRD_PRDGRADE, curocc(tPRD_PRDGRADE) + 1);
      end;
      putitemXml(Result, 'VL_QTSALDO', vTotQtSaldo);
      viParams := '';
      putitemXml(viParams, 'CD_EMPRESA', vCdEmpresa);
      putitemXml(viParams, 'CD_SEQGRUPO', vCdSeq);
      putitemXml(viParams, 'TP_VALOR', 'C');
      putitemXml(viParams, 'CD_VALOR', vTpCusto);
      putitemXml(viParams, 'DT_VALOR', vDtSaldo);
      putitemXml(viParams, 'CD_EMPRESA_VALOR', vcdEmpresaValorEmp);
      putitemXml(viParams, 'CD_EMPVALOR', vcdEmpresaValorSis);
      putitemXml(viParams, 'IN_PROMOCAO', True);
      viListas := '';
      voParams := activateCmp('PRDSVCO007', 'buscaValorData', viParams); (*,,viListas,,, *)
      if (xStatus < 0) then begin
        Result := voParams;
        return(-1); exit;
      end;
      putitemXml(Result, 'VL_VALOR', itemXmlF('VL_VALOR', voParams));
    end;
  end;
  return(0); exit;
end;

//----------------------------------------------------------------
function T_FISSVCO032.buscaDadosSocios(pParams : String) : String;
//----------------------------------------------------------------
const
  cDS_METHOD = 'ADICIONAL=Operação: T_FISSVCO032.buscaDadosSocios()';
var
  viParams, voParams, viParams, voParams : String;
begin
  clear_e(tCTB_CONFIGEMP);
  putitem_o(tCTB_CONFIGEMP, 'CD_POOLEMPRESA', itemXmlF('CD_POOLEMPRESA', PARAM_GLB));
  putitem_o(tCTB_CONFIGEMP, 'CD_EMPRESA', itemXmlF('CD_EMPRESA', pParams));
  putitem_o(tCTB_CONFIGEMP, 'DT_EXERCONTABIL', itemXmlF('CD_ANOEXERCONTABIL', PARAM_GLB));
  retrieve_e(tCTB_CONFIGEMP);

  clear_e(tFIS_CONTSOCIO);
  putitem_o(tFIS_CONTSOCIO, 'CD_PESSOA', item_f('CD_CONTADOR', tCTB_CONFIGEMP));
  putitem_o(tFIS_CONTSOCIO, 'CD_EMPRESA', itemXmlF('CD_EMPRESA', pParams));
  putitem_o(tFIS_CONTSOCIO, 'TP_IDENTIFICACAO', 'C');
  retrieve_e(tFIS_CONTSOCIO);

  viParams := '';
  putitemXml(viParams, 'CD_EMPRESA', itemXmlF('CD_EMPRESA', pParams));
  putitemXml(viParams, 'CD_PESSOA', item_f('CD_CONTADOR', tCTB_CONFIGEMP));
  voParams := activateCmp('PESSVCO005', 'buscaDadosPessoa', viParams); (*,,,, *)
  if (xStatus < 0) then begin
    Result := voParams;
    return(-1); exit;
  end;

  viParams := '';
  putitemXml(viParams, 'CD_PESSOA', item_f('CD_CONTADOR', tCTB_CONFIGEMP));
  putitemXml(viParams, 'CD_TIPOFONE', gCdTipoFone);
  voParams := activateCmp('PESSVCO005', 'buscarTelefone', viParams); (*,,, *)
  if (xStatus < 0) then begin
    Result := voParams;
    return(-1); exit;
  end;

  Result := '';
  putitemXml(Result, 'NM_PESSOA', itemXml('NM_PESSOA', voParams));
  putitemXml(Result, 'NR_CPFCNPJ', itemXmlF('NR_CPFCNPJ', voParams));
  putitemXml(Result, 'NR_FONECONTATO', itemXmlF('NR_FONECONTATO', voParams));
  putitemXml(Result, 'DS_EMAIL', itemXml('DS_EMAIL', voParams));
  putitemXml(Result, 'DS_CRC', item_a('DS_CRC', tFIS_CONTSOCIO));
  putitemXml(Result, 'NR_TELEFONE', itemXmlF('NR_TELEFONE', voParams));

  return(0); exit;

end;

//------------------------------------------------------------------
function T_FISSVCO032.carregaPesJuridica(pParams : String) : String;
//------------------------------------------------------------------
const
  cDS_METHOD = 'ADICIONAL=Operação: T_FISSVCO032.carregaPesJuridica()';
var
  viParams, voParams : String;
begin
  Result := '';

  if (itemXml('CD_PESSOA', pParams) = '') then begin
    return(0); exit;
  end;

  clear_e(tPES_PESJURIDI);
  putitem_o(tPES_PESJURIDI, 'CD_PESSOA', itemXmlF('CD_PESSOA', pParams));
  retrieve_e(tPES_PESJURIDI);
  if (xStatus >= 0) then begin
    putlistitensocc_e(Result, tPES_PESJURIDI);
  end;
  return(0); exit;
end;

//----------------------------------------------------------------
function T_FISSVCO032.carregaPesFisica(pParams : String) : String;
//----------------------------------------------------------------
const
  cDS_METHOD = 'ADICIONAL=Operação: T_FISSVCO032.carregaPesFisica()';
var
  viParams, voParams : String;
begin
  Result := '';

  if (itemXml('CD_PESSOA', pParams) = '') then begin
    return(0); exit;
  end;

  clear_e(tPES_PESFISICA);
  putitem_o(tPES_PESFISICA, 'CD_PESSOA', itemXmlF('CD_PESSOA', pParams));
  retrieve_e(tPES_PESFISICA);
  if (xStatus >= 0) then begin
    putlistitensocc_e(Result, tPES_PESFISICA);
  end;
  return(0); exit;
end;

//-----------------------------------------------------------------
function T_FISSVCO032.carregaLogradouro(pParams : String) : String;
//-----------------------------------------------------------------
const
  cDS_METHOD = 'ADICIONAL=Operação: T_FISSVCO032.carregaLogradouro()';
var
  vCdEstado : String;
begin
  Result := '';

  if (itemXml('CD_CEP', pParams) = '') then begin
    return(0); exit;
  end;

  clear_e(tGLB_LOGRADOUR);
  putitem_o(tGLB_LOGRADOUR, 'CD_CEP', itemXmlF('CD_CEP', pParams));
  retrieve_e(tGLB_LOGRADOUR);
  if (xStatus >= 0) then begin
    clear_e(tV_GLB_MUNICIP);
    putitem_o(tV_GLB_MUNICIP, 'CD_MUNICIPIO', item_f('CD_MUNICIPIO', tGLB_LOGRADOUR));
    retrieve_e(tV_GLB_MUNICIP);
    if (xStatus < 0) then begin
      clear_e(tV_GLB_MUNICIP);
    end;

  vCdEstado := '';
  if (item_a('DS_SIGLA', tV_GLB_MUNICIP) = 'RO') then begin
    vCdEstado := 11;
  end else if (item_a('DS_SIGLA', tV_GLB_MUNICIP) = 'AC') then begin
    vCdEstado := 12;
  end else if (item_a('DS_SIGLA', tV_GLB_MUNICIP) = 'AM') then begin
    vCdEstado := 13;
  end else if (item_a('DS_SIGLA', tV_GLB_MUNICIP) = 'RR') then begin
    vCdEstado := 14;
  end else if (item_a('DS_SIGLA', tV_GLB_MUNICIP) = 'PA') then begin
    vCdEstado := 15;
  end else if (item_a('DS_SIGLA', tV_GLB_MUNICIP) = 'AP') then begin
    vCdEstado := 16;
  end else if (item_a('DS_SIGLA', tV_GLB_MUNICIP) = 'TO') then begin
    vCdEstado := 17;
  end else if (item_a('DS_SIGLA', tV_GLB_MUNICIP) = 'MA') then begin
    vCdEstado := 21;
  end else if (item_a('DS_SIGLA', tV_GLB_MUNICIP) = 'PI') then begin
    vCdEstado := 22;
  end else if (item_a('DS_SIGLA', tV_GLB_MUNICIP) = 'CE') then begin
    vCdEstado := 23;
  end else if (item_a('DS_SIGLA', tV_GLB_MUNICIP) = 'RN') then begin
    vCdEstado := 24;
  end else if (item_a('DS_SIGLA', tV_GLB_MUNICIP) = 'PB') then begin
    vCdEstado := 25;
  end else if (item_a('DS_SIGLA', tV_GLB_MUNICIP) = 'PE') then begin
    vCdEstado := 26;
  end else if (item_a('DS_SIGLA', tV_GLB_MUNICIP) = 'AL') then begin
    vCdEstado := 27;
  end else if (item_a('DS_SIGLA', tV_GLB_MUNICIP) = 'SE') then begin
    vCdEstado := 28;
  end else if (item_a('DS_SIGLA', tV_GLB_MUNICIP) = 'BA') then begin
    vCdEstado := 29;
  end else if (item_a('DS_SIGLA', tV_GLB_MUNICIP) = 'MG') then begin
    vCdEstado := 31;
  end else if (item_a('DS_SIGLA', tV_GLB_MUNICIP) = 'ES') then begin
    vCdEstado := 32;
  end else if (item_a('DS_SIGLA', tV_GLB_MUNICIP) = 'RJ') then begin
    vCdEstado := 33;
  end else if (item_a('DS_SIGLA', tV_GLB_MUNICIP) = 'SP') then begin
    vCdEstado := 35;
  end else if (item_a('DS_SIGLA', tV_GLB_MUNICIP) = 'PR') then begin
    vCdEstado := 41;
  end else if (item_a('DS_SIGLA', tV_GLB_MUNICIP) = 'SC') then begin
    vCdEstado := 42;
  end else if (item_a('DS_SIGLA', tV_GLB_MUNICIP) = 'RS') then begin
    vCdEstado := 43;
  end else if (item_a('DS_SIGLA', tV_GLB_MUNICIP) = 'MS') then begin
    vCdEstado := 50;
  end else if (item_a('DS_SIGLA', tV_GLB_MUNICIP) = 'MT') then begin
    vCdEstado := 51;
  end else if (item_a('DS_SIGLA', tV_GLB_MUNICIP) = 'GO') then begin
    vCdEstado := 52;
  end else if (item_a('DS_SIGLA', tV_GLB_MUNICIP) = 'DF') then begin
    vCdEstado := 53;
  end;

    putlistitensocc_e(Result, tV_GLB_MUNICIP);
    putitemXml(Result, 'DS_ESTADO', vCdEstado);

  end;
  return(0); exit;
end;

//----------------------------------------------------------------
function T_FISSVCO032.carregaContSocio(pParams : String) : String;
//----------------------------------------------------------------
const
  cDS_METHOD = 'ADICIONAL=Operação: T_FISSVCO032.carregaContSocio()';
var
  viParams, voParams : String;
  vDtPeriodo : TDate;
begin
  Result := '';

  if (itemXml('DS_TIPOCONTATO', pParams) <> '') then begin
    voParams := buscaContato(viParams); (* PARAM_GLB, pParams, Result, xCdErro, xCtxErro *)
  end else begin
    if (itemXml('CD_EMPRESA', pParams) = '') then begin
      return(0); exit;
    end;

    vDtPeriodo := itemXml('DT_PERIODO', pParams);
    clear_e(tFIS_CONTSOCIO);
    putitem_o(tFIS_CONTSOCIO, 'CD_EMPRESA', itemXmlF('CD_EMPRESA', pParams));

    if (vDtPeriodo <> '') then begin
      putitem_o(tFIS_CONTSOCIO, 'DT_ADMISSAO', '<=' + vDtPeriodo' + ');
      putitem_o(tFIS_CONTSOCIO, 'DT_DEMISSAO', '>=' + vDtPeriodo' + ');
      putitem_o(tFIS_CONTSOCIO, 'TP_IDENTIFICACAO', itemXml('CONT_SOCIO', pParams));
    end;

    retrieve_e(tFIS_CONTSOCIO);
    if (xStatus >= 0) then begin
      putlistitensocc_e(Result, tFIS_CONTSOCIO);
    end;

    viParams := pParams;
    putitemXml(viParams, 'CD_TIPOFONE', gCdTipoFone);
    voParams := carregaPesTelefone(viParams); (* PARAM_GLB, viParams, voParams, xCdErro, xCtxErro *)
    if (xStatus < 0) then begin
      Result := voParams;
      return(-1); exit;
    end;

    putitemXml(Result, 'NR_TELEFONE', itemXmlF('NR_TELEFONE', voParams));

  end;
  return(0); exit;
end;

//--------------------------------------------------------------
function T_FISSVCO032.carregaMunIBGE(pParams : String) : String;
//--------------------------------------------------------------
const
  cDS_METHOD = 'ADICIONAL=Operação: T_FISSVCO032.carregaMunIBGE()';
var
  viParams, voParams : String;
begin
  Result := '';

  if (itemXml('CD_ESTADO', pParams) = '') then begin
    return(0); exit;
  end;
  if (itemXml('CD_MUNICIPIO', pParams) = '') then begin
    return(0); exit;
  end;

  clear_e(tGLB_MUNIBGE);
  putitem_o(tGLB_MUNIBGE, 'CD_ESTADO', itemXmlF('CD_ESTADO', pParams));
  putitem_o(tGLB_MUNIBGE, 'CD_MUNICIPIO', itemXmlF('CD_MUNICIPIO', pParams));
  retrieve_e(tGLB_MUNIBGE);
  if (xStatus >= 0) then begin
    putlistitensocc_e(Result, tGLB_MUNIBGE);
  end;
  return(0); exit;
end;

//-------------------------------------------------------------------
function T_FISSVCO032.carregaFisNfImposto(pParams : String) : String;
//-------------------------------------------------------------------
const
  cDS_METHOD = 'ADICIONAL=Operação: T_FISSVCO032.carregaFisNfImposto()';
var
  viParams, voParams : String;
begin
  Result := '';
  clear_e(tFIS_NFIMPOSTO);
  putitem_o(tFIS_NFIMPOSTO, 'CD_EMPRESA', itemXmlF('CD_EMPRESA', pParams));
  putitem_o(tFIS_NFIMPOSTO, 'CD_IMPOSTO', itemXmlF('CD_IMPOSTO', pParams));
  putitem_o(tFIS_NFIMPOSTO, 'DT_FATURA', itemXml('DT_FATURA', pParams));
  putitem_o(tFIS_NFIMPOSTO, 'NR_FATURA', itemXmlF('NR_FATURA', pParams));

  retrieve_e(tFIS_NFIMPOSTO);
  if (xStatus >= 0) then begin
    putlistitensocc_e(Result, tFIS_NFIMPOSTO);
  end;
  return(0); exit;
end;

//-----------------------------------------------------------------------
function T_FISSVCO032.carregaFisNfItemImposto(pParams : String) : String;
//-----------------------------------------------------------------------
const
  cDS_METHOD = 'ADICIONAL=Operação: T_FISSVCO032.carregaFisNfItemImposto()';
var
  viParams, voParams : String;
begin
  Result := '';
  clear_e(tFIS_NFITEMIMP);
  putitem_o(tFIS_NFITEMIMP, 'CD_EMPRESA', itemXmlF('CD_EMPRESA', pParams));
  putitem_o(tFIS_NFITEMIMP, 'CD_IMPOSTO', itemXmlF('CD_IMPOSTO', pParams));
  putitem_o(tFIS_NFITEMIMP, 'DT_FATURA', itemXml('DT_FATURA', pParams));
  putitem_o(tFIS_NFITEMIMP, 'NR_FATURA', itemXmlF('NR_FATURA', pParams));
  putitem_o(tFIS_NFITEMIMP, 'NR_ITEM', itemXmlF('NR_ITEM', pParams));

  retrieve_e(tFIS_NFITEMIMP);
  if (xStatus >= 0) then begin
    putlistitensocc_e(Result, tFIS_NFITEMIMP);
  end;
  return(0); exit;
end;

//--------------------------------------------------------------
function T_FISSVCO032.carregaFisTipi(pParams : String) : String;
//--------------------------------------------------------------
const
  cDS_METHOD = 'ADICIONAL=Operação: T_FISSVCO032.carregaFisTipi()';
var
  viParams, voParams : String;
begin
  Result := '';
  clear_e(tFIS_TIPI);
  putitem_o(tFIS_TIPI, 'CD_TIPI', itemXmlF('CD_TIPI', pParams));
  retrieve_e(tFIS_TIPI);
  if (xStatus >= 0) then begin
    putlistitensocc_e(Result, tFIS_TIPI);
  end;
  return(0); exit;
end;

//-------------------------------------------------------------
function T_FISSVCO032.carregaFisEcf(pParams : String) : String;
//-------------------------------------------------------------
const
  cDS_METHOD = 'ADICIONAL=Operação: T_FISSVCO032.carregaFisEcf()';
var
  viParams, voParams : String;
begin
  Result := '';
  clear_e(tFIS_ECF);
  putitem_o(tFIS_ECF, 'CD_EMPRESA', itemXmlF('CD_EMPRESA', pParams));
  putitem_o(tFIS_ECF, 'NR_ECF', itemXmlF('NR_ECF', pParams));
  retrieve_e(tFIS_ECF);
  if (xStatus >= 0) then begin
    putlistitensocc_e(Result, tFIS_ECF);
  end;
  return(0); exit;
end;

//----------------------------------------------------------------
function T_FISSVCO032.carregaVPesIndic(pParams : String) : String;
//----------------------------------------------------------------
const
  cDS_METHOD = 'ADICIONAL=Operação: T_FISSVCO032.carregaVPesIndic()';
var
  viParams, voParams : String;
begin
  Result := '';
  clear_e(tV_PES_INDIC);
  putitem_o(tV_PES_INDIC, 'CD_PESSOA', itemXmlF('CD_PESSOA', pParams));
  retrieve_e(tV_PES_INDIC);
  if (xStatus >= 0) then begin
    putlistitensocc_e(Result, tV_PES_INDIC);
  end;
  return(0); exit;
end;

//--------------------------------------------------------------
function T_FISSVCO032.carregaFisCfop(pParams : String) : String;
//--------------------------------------------------------------
const
  cDS_METHOD = 'ADICIONAL=Operação: T_FISSVCO032.carregaFisCfop()';
begin
  Result := '';

  if (itemXml('CD_CFOP', pParams) = '') then begin
    return(0); exit;
  end;

  clear_e(tFIS_CFOP);
  putitem_o(tFIS_CFOP, 'CD_CFOP', itemXmlF('CD_CFOP', pParams));
  retrieve_e(tFIS_CFOP);
  if (xStatus >= 0) then begin
    putlistitensocc_e(Result, tFIS_CFOP);
  end;

  return(0); exit;

end;

//-----------------------------------------------------------------
function T_FISSVCO032.carregaPesCliente(pParams : String) : String;
//-----------------------------------------------------------------
const
  cDS_METHOD = 'ADICIONAL=Operação: T_FISSVCO032.carregaPesCliente()';
begin
  Result := '';

  if (itemXml('CD_CLIENTE', pParams) = '') then begin
    return(0); exit;
  end;

  clear_e(tPES_CLIENTE);
  putitem_o(tPES_CLIENTE, 'CD_CLIENTE', itemXmlF('CD_CLIENTE', pParams));
  retrieve_e(tPES_CLIENTE);
  if (xStatus >= 0) then begin
    putlistitensocc_e(Result, tPES_CLIENTE);
  end;

  return(0); exit;

end;

//------------------------------------------------------------------
function T_FISSVCO032.carregaPesTelefone(pParams : String) : String;
//------------------------------------------------------------------
const
  cDS_METHOD = 'ADICIONAL=Operação: T_FISSVCO032.carregaPesTelefone()';
begin
  Result := '';

  if (itemXml('CD_PESSOA', pParams) = '') then begin
    return(0); exit;
  end;

  clear_e(tPES_TELEFONE);
  putitem_o(tPES_TELEFONE, 'CD_PESSOA', itemXmlF('CD_PESSOA', pParams));

  if (itemXml('NR_SEQUENCIA', pParams) <> '') then begin
    putitem_o(tPES_TELEFONE, 'NR_SEQUENCIA', itemXmlF('NR_SEQUENCIA', pParams));
  end;
  if (itemXml('CD_TIPOFONE', pParams) <> '') then begin
    putitem_o(tPES_TELEFONE, 'CD_TIPOFONE', itemXmlF('CD_TIPOFONE', pParams));
  end;

  retrieve_e(tPES_TELEFONE);
  if (xStatus >= 0) then begin
    setocc(tPES_TELEFONE, 1);
    putlistitensocc_e(Result, tPES_TELEFONE);
  end;

  return(0); exit;

end;

//---------------------------------------------------------------
function T_FISSVCO032.carregaPesEmail(pParams : String) : String;
//---------------------------------------------------------------
const
  cDS_METHOD = 'ADICIONAL=Operação: T_FISSVCO032.carregaPesEmail()';
begin
  Result := '';

  if (itemXml('CD_PESSOA', pParams) = '') then begin
    return(0); exit;
  end;
  if (itemXml('NR_SEQUENCIA', pParams) <> '') then begin
    clear_e(tPES_EMAIL);
    putitem_o(tPES_EMAIL, 'CD_PESSOA', itemXmlF('CD_PESSOA', pParams));
    putitem_o(tPES_EMAIL, 'NR_SEQUENCIA', itemXmlF('NR_SEQUENCIA', pParams));
    retrieve_e(tPES_EMAIL);
    if (xStatus < 0) then begin
      clear_e(tPES_EMAIL);
    end;

  end else begin
    clear_e(tPES_EMAIL);
    putitem_o(tPES_EMAIL, 'CD_PESSOA', itemXmlF('CD_PESSOA', pParams));
    putitem_o(tPES_EMAIL, 'IN_PADRAO', True);
    retrieve_e(tPES_EMAIL);
    if (xStatus < 0) then begin
      clear_e(tPES_EMAIL);
      putitem_o(tPES_EMAIL, 'CD_PESSOA', itemXmlF('CD_PESSOA', pParams));
      retrieve_e(tPES_EMAIL);
      if (xStatus < 0) then begin
        clear_e(tPES_EMAIL);
      end else begin
        setocc(tPES_EMAIL, 1);
      end;
    end;
  end;

  if not (empty(tPES_EMAIL)) then begin
    putlistitensocc_e(Result, tPES_EMAIL);
  end;

  return(0); exit;

end;

//-------------------------------------------------------------
function T_FISSVCO032.carregaPessoa(pParams : String) : String;
//-------------------------------------------------------------
const
  cDS_METHOD = 'ADICIONAL=Operação: T_FISSVCO032.carregaPessoa()';
var
  viParams, voParams : String;
begin
  Result := '';

  if (itemXml('CD_PESSOA', pParams) = '') then begin
    return(0); exit;
  end;

  clear_e(tPES_PESSOA);
  putitem_o(tPES_PESSOA, 'CD_PESSOA', itemXmlF('CD_PESSOA', pParams));
  retrieve_e(tPES_PESSOA);
  if (xStatus >= 0) then begin
    putlistitensocc_e(Result, tPES_PESSOA);
  end;
  return(0); exit;
end;

//---------------------------------------------------------------
function T_FISSVCO032.carregaendereco(pParams : String) : String;
//---------------------------------------------------------------
const
  cDS_METHOD = 'ADICIONAL=Operação: T_FISSVCO032.carregaendereco()';
var
  viParams, voParams, vCdEstado : String;
begin
  Result := '';

  if (itemXml('CD_PESSOA', pParams) = '') then begin
    return(0); exit;
  end;

  clear_e(tPES_ENDERECO);
  putitem_o(tPES_ENDERECO, 'CD_PESSOA', itemXmlF('CD_PESSOA', pParams));
  retrieve_e(tPES_ENDERECO);
  if (xStatus >= 0) then begin
    putlistitensocc_e(Result, tPES_ENDERECO);
    vCdEstado := '';
    if (item_a('DS_SIGLA', tGLB_ESTADO) = 'RO') then begin
      vCdEstado := 11;
    end else if (item_a('DS_SIGLA', tGLB_ESTADO) = 'AC') then begin
      vCdEstado := 12;
    end else if (item_a('DS_SIGLA', tGLB_ESTADO) = 'AM') then begin
      vCdEstado := 13;
    end else if (item_a('DS_SIGLA', tGLB_ESTADO) = 'RR') then begin
      vCdEstado := 14;
    end else if (item_a('DS_SIGLA', tGLB_ESTADO) = 'PA') then begin
      vCdEstado := 15;
    end else if (item_a('DS_SIGLA', tGLB_ESTADO) = 'AP') then begin
      vCdEstado := 16;
    end else if (item_a('DS_SIGLA', tGLB_ESTADO) = 'TO') then begin
      vCdEstado := 17;
    end else if (item_a('DS_SIGLA', tGLB_ESTADO) = 'MA') then begin
      vCdEstado := 21;
    end else if (item_a('DS_SIGLA', tGLB_ESTADO) = 'PI') then begin
      vCdEstado := 22;
    end else if (item_a('DS_SIGLA', tGLB_ESTADO) = 'CE') then begin
      vCdEstado := 23;
    end else if (item_a('DS_SIGLA', tGLB_ESTADO) = 'RN') then begin
      vCdEstado := 24;
    end else if (item_a('DS_SIGLA', tGLB_ESTADO) = 'PB') then begin
      vCdEstado := 25;
    end else if (item_a('DS_SIGLA', tGLB_ESTADO) = 'PE') then begin
      vCdEstado := 26;
    end else if (item_a('DS_SIGLA', tGLB_ESTADO) = 'AL') then begin
      vCdEstado := 27;
    end else if (item_a('DS_SIGLA', tGLB_ESTADO) = 'SE') then begin
      vCdEstado := 28;
    end else if (item_a('DS_SIGLA', tGLB_ESTADO) = 'BA') then begin
      vCdEstado := 29;
    end else if (item_a('DS_SIGLA', tGLB_ESTADO) = 'MG') then begin
      vCdEstado := 31;
    end else if (item_a('DS_SIGLA', tGLB_ESTADO) = 'ES') then begin
      vCdEstado := 32;
    end else if (item_a('DS_SIGLA', tGLB_ESTADO) = 'RJ') then begin
      vCdEstado := 33;
    end else if (item_a('DS_SIGLA', tGLB_ESTADO) = 'SP') then begin
      vCdEstado := 35;
    end else if (item_a('DS_SIGLA', tGLB_ESTADO) = 'PR') then begin
      vCdEstado := 41;
    end else if (item_a('DS_SIGLA', tGLB_ESTADO) = 'SC') then begin
      vCdEstado := 42;
    end else if (item_a('DS_SIGLA', tGLB_ESTADO) = 'RS') then begin
      vCdEstado := 43;
    end else if (item_a('DS_SIGLA', tGLB_ESTADO) = 'MS') then begin
      vCdEstado := 50;
    end else if (item_a('DS_SIGLA', tGLB_ESTADO) = 'MT') then begin
      vCdEstado := 51;
    end else if (item_a('DS_SIGLA', tGLB_ESTADO) = 'GO') then begin
      vCdEstado := 52;
    end else if (item_a('DS_SIGLA', tGLB_ESTADO) = 'DF') then begin
      vCdEstado := 53;
    end;
    putitemXml(Result, 'DS_ESTADO', vCdEstado);
    putitemXml(Result, 'DS_SIGLA', item_a('DS_SIGLA', tGLB_ESTADO));
    putitemXml(Result, 'CD_PAIS', item_f('CD_PAIS', tGLB_ESTADO));
    putitemXml(Result, 'CD_ESTADO', item_f('CD_ESTADO', tGLB_ESTADO));
  end;
  return(0); exit;
end;

//----------------------------------------------------------------
function T_FISSVCO032.carregaVendereco(pParams : String) : String;
//----------------------------------------------------------------
const
  cDS_METHOD = 'ADICIONAL=Operação: T_FISSVCO032.carregaVendereco()';
var
  viParams, voParams, vDsRegistro, vDsLstNf : String;
begin
  if (itemXml('NM_CARREGATABELA', pParams) = '') then begin
    Result := '';
    if (itemXml('CD_PESSOA', pParams) = '') then begin
      return(0); exit;
    end;
    clear_e(tV_PES_ENDEREC);
    putitem_o(tV_PES_ENDEREC, 'CD_PESSOA', itemXmlF('CD_PESSOA', pParams));
    retrieve_e(tV_PES_ENDEREC);
    if (xStatus >= 0) then begin
      putlistitensocc_e(Result, tV_PES_ENDEREC);
    end;
  end else if (itemXml('NM_CARREGATABELA', pParams) = 'PRD_PRDINFO') then begin
    Result := '';
    clear_e(tPRD_PRDINFO);
    putitem_o(tPRD_PRDINFO, 'CD_EMPRESA', itemXmlF('CD_EMPRESA', pParams));
    putitem_o(tPRD_PRDINFO, 'CD_PRODUTO', itemXmlF('CD_PRODUTO', pParams));
    retrieve_e(tPRD_PRDINFO);
    if (xStatus >= 0) then begin
      putlistitensocc_e(Result, tPRD_PRDINFO);
    end;
    return(0); exit;
  end else if (itemXml('NM_CARREGATABELA', pParams) = 'FIS_SALDOIMPOSTO') then begin
    Result := '';
    clear_e(tFIS_SALDOIMPO);
    putitem_o(tFIS_SALDOIMPO, 'CD_EMPRESA', itemXmlF('CD_EMPRESA', pParams));
    putitem_o(tFIS_SALDOIMPO, 'DT_MESANO', itemXml('DT_MESANO', pParams));
    putitem_o(tFIS_SALDOIMPO, 'TP_IMPOSTO', itemXmlF('TP_IMPOSTO', pParams));
    retrieve_e(tFIS_SALDOIMPO);
    if (xStatus >= 0) then begin
      putlistitensocc_e(Result, tFIS_SALDOIMPO);
    end;
    return(0); exit;
  end else if (itemXml('NM_CARREGATABELA', pParams) = 'FIS_NFE') then begin
    Result := '';
    clear_e(tFIS_NFE);
    putitem_o(tFIS_NFE, 'CD_EMPRESA', itemXmlF('CD_EMPRESA', pParams));
    putitem_o(tFIS_NFE, 'NR_FATURA', itemXmlF('NR_FATURA', pParams));
    putitem_o(tFIS_NFE, 'DT_FATURA', itemXml('DT_FATURA', pParams));
    retrieve_e(tFIS_NFE);
    if (xStatus >= 0) then begin
      putlistitensocc_e(Result, tFIS_NFE);
    end;
    return(0); exit;
  end else if (itemXml('NM_CARREGATABELA', pParams) = 'FIS_NFECF') then begin
    Result := '';
    clear_e(tFIS_NFECF);
    putitem_o(tFIS_NFECF, 'CD_EMPECF', itemXmlF('CD_EMPECF', pParams));
    if (itemXml('CD_EMPRESA', pParams) <> '') then begin
      putitem_o(tFIS_NFECF, 'CD_EMPRESA', itemXmlF('CD_EMPRESA', pParams));
    end;
    if (itemXml('DT_FATURA', pParams) <> '') then begin
      putitem_o(tFIS_NFECF, 'DT_FATURA', itemXml('DT_FATURA', pParams));
    end;
    if (itemXml('NR_FATURA', pParams) <> '') then begin
      putitem_o(tFIS_NFECF, 'NR_FATURA', itemXmlF('NR_FATURA', pParams));
    end;
    if (itemXml('NR_ECF', pParams) <> '') then begin
      putitem_o(tFIS_NFECF, 'NR_ECF', itemXmlF('NR_ECF', pParams));
    end;
    retrieve_e(tFIS_NFECF);
    if (xStatus >= 0) then begin
      putlistitensocc_e(Result, tFIS_NFECF);

      setocc(tFIS_NFECF, 1);
      while (xStatus >= 0) do begin
        vDsRegistro := '';
        putitemXml(vDsRegistro, 'CD_EMPRESA' item_f('CD_EMPRESA', tFIS_NFECF));
        putitemXml(vDsRegistro, 'CD_EMPFAT'  item_f('CD_EMPFAT', tFIS_NFECF));
        putitemXml(vDsRegistro, 'NR_FATURA'  item_f('NR_FATURA', tFIS_NFECF));
        putitemXml(vDsRegistro, 'DT_FATURA'  item_a('DT_FATURA', tFIS_NFECF));
        putitem(vDsLstNf,  vDsRegistro);
        setocc(tFIS_NFECF, curocc(tFIS_NFECF) + 1);
      end;
      putitemXml(Result, 'LST_NF', vDsLstNf);

    end;
    return(0); exit;
  end;
  return(0); exit;
end;

//-----------------------------------------------------------
function T_FISSVCO032.carregaPais(pParams : String) : String;
//-----------------------------------------------------------
const
  cDS_METHOD = 'ADICIONAL=Operação: T_FISSVCO032.carregaPais()';
var
  viParams, voParams : String;
  vCdEstado, vPais : Real;
begin
  Result := '';

  if (itemXml('CD_ESTADO', pParams) = '') then begin
    return(0); exit;
  end;

  vCdEstado := itemXmlF('CD_ESTADO', pParams);

  select (CD_PAIS) from 'GLB_ESTADOSVC' 
  where (putitem_e(tGLB_ESTADO, 'CD_ESTADO', vCdEstado)
  to (vPais);

  clear_e(tGLB_PAIS);
  putitem_o(tGLB_PAIS, 'CD_PAIS', vPais);
  retrieve_e(tGLB_PAIS);
  if (xStatus >= 0) then begin
    putlistitensocc_e(Result, tGLB_PAIS);
  end;
  return(0); exit;
end;

//----------------------------------------------------------------
function T_FISSVCO032.buscaParcelasFCP(pParams : String) : String;
//----------------------------------------------------------------
const
  cDS_METHOD = 'ADICIONAL=Operação: T_FISSVCO032.buscaParcelasFCP()';
var
  vQtParcela, vVlDoc : Real;
begin
  vQtParcela := 0;
  vVlDoc := 0;

  clear_e(tFCP_DUPLICATI);
  putitem_o(tFCP_DUPLICATI, 'CD_EMPRESA', itemXmlF('CD_EMPRESA', pParams));
  putitem_o(tFCP_DUPLICATI, 'CD_FORNECEDOR', itemXmlF('CD_FORNECEDOR', pParams));
  putitem_o(tFCP_DUPLICATI, 'NR_DUPLICATA', itemXmlF('NR_DUPLICATA', pParams));
  retrieve_e(tFCP_DUPLICATI);
  if (xStatus >= 0) then begin
    setocc(tFCP_DUPLICATI, 1);
    while (xStatus >= 0) do begin
      vQtParcela := vQtParcela + 1;
      vVlDoc := vVlDoc + item_f('VL_DUPLICATA', tFCP_DUPLICATI);

      setocc(tFCP_DUPLICATI, curocc(tFCP_DUPLICATI) + 1);
    end;
  end;

  putitemXml(Result, 'QT_PARCELA', vQtParcela);
  putitemXml(Result, 'VL_DOC', vVlDoc);

  return(0); exit;
end;

//----------------------------------------------------------------
function T_FISSVCO032.buscaParcelasFCR(pParams : String) : String;
//----------------------------------------------------------------
const
  cDS_METHOD = 'ADICIONAL=Operação: T_FISSVCO032.buscaParcelasFCR()';
var
  vQtParcela, vVlDoc : Real;
begin
  vQtParcela := 0;
  vVlDoc := 0;

  clear_e(tFCR_FATURAI);
  putitem_o(tFCR_FATURAI, 'CD_EMPRESA', itemXmlF('CD_EMPRESA', pParams));
  putitem_o(tFCR_FATURAI, 'CD_CLIENTE', itemXmlF('CD_CLIENTE', pParams));
  putitem_o(tFCR_FATURAI, 'NR_FAT', itemXmlF('NR_FAT', pParams));
  retrieve_e(tFCR_FATURAI);
  if (xStatus >= 0) then begin
    setocc(tFCR_FATURAI, 1);
    while (xStatus >= 0) do begin
      vQtParcela := vQtParcela + 1;
      vVlDoc := vVlDoc + item_f('VL_FATURA', tFCR_FATURAI);

      setocc(tFCR_FATURAI, curocc(tFCR_FATURAI) + 1);
    end;
  end;

  putitemXml(Result, 'QT_PARCELA', vQtParcela);
  putitemXml(Result, 'VL_DOC', vVlDoc);

  return(0); exit;
end;


end.
