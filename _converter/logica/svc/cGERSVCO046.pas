unit cGERSVCO046;

interface

(* COMPONENTES 
  ADMSVCO027 / PESSVCO005 / 
*)        

uses
  Classes, SysUtils, Math, DB,
  cServiceUnf, cDataSetUnf;

type
  T_GERSVCO046 = class(TcServiceUnf)
  private
    tCDF_MPTER,
    tFGR_PORTADOR,
    tFIS_NFSELOFIS,
    tFIS_TIPI,
    tPED_TABPRECOC,
    tPES_VENDEDOR,
    tPRD_CLASSIFIC,
    tPRD_COMPOSI,
    tPRD_COR,
    tPRD_FIBRA,
    tPRD_GRADEI,
    tPRD_GRUPO,
    tPRD_GRUPOCOMP,
    tPRD_PRDGRADE,
    tPRD_PRODUTO,
    tPRD_PRODUTOCL,
    tPRD_PRODUTOFA,
    tPRD_PRODUTOFO,
    tTRA_TRANSACAD : TcDatasetUnf;
    function getParam(pParams : String = '') : String;
    function setEntidade(pParams : String = '') : String;
  protected
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;    
  published
    function buscaDadosProduto(pParams : String = '') : String;
    function buscaDadosUsuario(pParams : String = '') : String;
    function buscaDadosServico(pParams : String = '') : String;
    function buscaDadosMPTerceito(pParams : String = '') : String;
    function buscaDadosVendedor(pParams : String = '') : String;
    function buscaDadosFiscal(pParams : String = '') : String;
    function GetNomePortador(pParams : String = '') : String;
    function buscaDadosTabPreco(pParams : String = '') : String;
    function buscaDadosSeloFiscal(pParams : String = '') : String;
  end;

implementation

uses
  cADMSVCO001,
  cActivate, cStatus, cFuncao, cXml, dModulo;

var


//---------------------------------------------------------------
constructor T_GERSVCO046.Create(AOwner: TComponent);
//---------------------------------------------------------------
begin
  inherited Create(AOwner);
  setEntidade('');
end;

//--------------------------------
destructor T_GERSVCO046.Destroy;
//--------------------------------
begin
  inherited Destroy;
end;

//---------------------------------------------------------------
function T_GERSVCO046.getParam(pParams : String = '') : String;
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

  xParam := T_ADMSVCO001.GetParametro(xParam);


  xParamEmp := '';

  xParamEmp := T_ADMSVCO001.GetParamEmpresa(piCdEmpresa, xParamEmp);


end;

//---------------------------------------------------------------
function T_GERSVCO046.setEntidade(pParams : String = '') : String;
//---------------------------------------------------------------
begin
  tCDF_MPTER := GetEntidade('CDF_MPTER');
  tFGR_PORTADOR := GetEntidade('FGR_PORTADOR');
  tFIS_NFSELOFIS := GetEntidade('FIS_NFSELOFIS');
  tFIS_TIPI := GetEntidade('FIS_TIPI');
  tPED_TABPRECOC := GetEntidade('PED_TABPRECOC');
  tPES_VENDEDOR := GetEntidade('PES_VENDEDOR');
  tPRD_CLASSIFIC := GetEntidade('PRD_CLASSIFIC');
  tPRD_COMPOSI := GetEntidade('PRD_COMPOSI');
  tPRD_COR := GetEntidade('PRD_COR');
  tPRD_FIBRA := GetEntidade('PRD_FIBRA');
  tPRD_GRADEI := GetEntidade('PRD_GRADEI');
  tPRD_GRUPO := GetEntidade('PRD_GRUPO');
  tPRD_GRUPOCOMP := GetEntidade('PRD_GRUPOCOMP');
  tPRD_PRDGRADE := GetEntidade('PRD_PRDGRADE');
  tPRD_PRODUTO := GetEntidade('PRD_PRODUTO');
  tPRD_PRODUTOCL := GetEntidade('PRD_PRODUTOCL');
  tPRD_PRODUTOFA := GetEntidade('PRD_PRODUTOFA');
  tPRD_PRODUTOFO := GetEntidade('PRD_PRODUTOFO');
  tTRA_TRANSACAD := GetEntidade('TRA_TRANSACAD');
end;

//-----------------------------------------------------------------
function T_GERSVCO046.buscaDadosProduto(pParams : String) : String;
//-----------------------------------------------------------------
const
  cDS_METHOD = 'ADICONAL=Operação: T_GERSVCO046.buscaDadosProduto()';
var
  vCdProduto, vCdTipoClas : Real;
  vDsComposicao, vNmFabricante, viParams, voParams : String;
begin
  vCdProduto := itemXmlF('CD_PRODUTO', pParams);
  vCdTipoClas := itemXmlF('CD_TIPOCLAS', pParams);

  if (vCdProduto = 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Produto não informado!', cDS_METHOD);
    return(-1); exit;
  end;

  clear_e(tPRD_PRDGRADE);
  putitem_e(tPRD_PRDGRADE, 'CD_PRODUTO', vCdProduto);
  retrieve_e(tPRD_PRDGRADE);
  if (xStatus < 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Produto  vCdProduto não possui cadastro em grade!', cDS_METHOD);
    return(-1); exit;
  end;

  clear_e(tPRD_GRADEI);
  putitem_e(tPRD_GRADEI, 'CD_GRADE', item_f('CD_GRADE', tPRD_GRUPO));
  putitem_e(tPRD_GRADEI, 'CD_TAMANHO', item_f('CD_TAMANHO', tPRD_PRDGRADE));
  retrieve_o(tPRD_GRADEI);
  if (xStatus = -7) then begin
    retrieve_x(tPRD_GRADEI);
  end;

  clear_e(tPRD_GRUPOCOMP);
  putitem_e(tPRD_GRUPOCOMP, 'CD_SEQGRUPO', item_f('CD_SEQGRUPO', tPRD_PRDGRADE));
  retrieve_e(tPRD_GRUPOCOMP);
  if (xStatus >= 0) then begin
    setocc(tPRD_GRUPOCOMP, 1);
    clear_e(tPRD_COMPOSI);
    putitem_e(tPRD_COMPOSI, 'CD_COMPOSICAO', item_f('CD_COMPOSICAO', tPRD_GRUPOCOMP));
    retrieve_e(tPRD_COMPOSI);
    if (xStatus >= 0) then begin
      setocc(tPRD_COMPOSI, 1);
      while (xStatus >= 0) do begin
        if (vDsComposicao = '') then begin
          vDsComposicao := '' + PR_COMPOSICAO + '.PRD_COMPOSI% ' + DS_FIBRA + '.PRD_FIBRA';
        end else begin
          vDsComposicao := '' + vDsComposicao + ' / ' + PR_COMPOSICAO + '.PRD_COMPOSI% ' + DS_FIBRA + '.PRD_FIBRA';
        end;
        setocc(tPRD_COMPOSI, curocc(tPRD_COMPOSI) + 1);
      end;
    end;
  end;

  clear_e(tPRD_PRODUTOCL);
  if (vCdTipoClas > 0) then begin
    putitem_e(tPRD_PRODUTOCL, 'CD_TIPOCLAS', vCdTipoClas);
    retrieve_e(tPRD_PRODUTOCL);
    if (xStatus < 0) then begin
      clear_e(tPRD_PRODUTOCL);
    end;
  end;

  clear_e(tFIS_TIPI);
  if (item_f('CD_TIPI', tPRD_PRODUTO) <> '') then begin
    putitem_e(tFIS_TIPI, 'CD_TIPI', item_f('CD_TIPI', tPRD_PRODUTO));
    retrieve_e(tFIS_TIPI);
    if (xStatus < 0) then begin
      clear_e(tFIS_TIPI);
    end;
  end;

  if not (empty(tPRD_PRODUTOFA)) then begin
    if (item_f('CD_FABRICANTE', tPRD_PRODUTOFA) <> 0) then begin
      viParams := '';
      putitemXml(viParams, 'CD_PESSOA', item_f('CD_FABRICANTE', tPRD_PRODUTOFA));
      voParams := activateCmp('PESSVCO005', 'buscaDadosPessoa', viParams); (*,viParams,voParams,, *)
      if (xStatus < 0) then begin
        Result := voParams;
        return(-1); exit;
      end;
      vNmFabricante := itemXml('NM_PESSOA', voParams);
    end;
  end;

  putitemXml(Result, 'CD_PRODUTO', item_f('CD_PRODUTO', tPRD_PRODUTO));
  putitemXml(Result, 'DS_PRODUTO', item_a('DS_PRODUTO', tPRD_PRODUTO));
  putitemXml(Result, 'CD_ESPECIE', item_f('CD_ESPECIE', tPRD_PRODUTO));
  putitemXml(Result, 'CD_CST', item_f('CD_CST', tPRD_PRODUTO));
  putitemXml(Result, 'QT_PESO', item_f('QT_PESO', tPRD_PRODUTO));
  putitemXml(Result, 'CD_FORNECEDOR', item_f('CD_FORNECEDOR', tPRD_PRODUTOFO));
  putitemXml(Result, 'CD_ORIGINALFOR', item_f('CD_ORIGINAL', tPRD_PRODUTOFO));
  putitemXml(Result, 'CD_FABRICANTE', item_f('CD_FABRICANTE', tPRD_PRODUTOFA));
  putitemXml(Result, 'CD_ORIGINALFAB', item_f('CD_ORIGINAL', tPRD_PRODUTOFA));
  putitemXml(Result, 'NM_FABRICANTE', vNmFabricante);
  putitemXml(Result, 'CD_COR', item_f('CD_COR', tPRD_COR));
  putitemXml(Result, 'DS_COR', item_a('DS_COR', tPRD_COR));
  putitemXml(Result, 'DS_TAMANHO', item_a('DS_TAMANHO', tPRD_GRADEI));
  putitemXml(Result, 'DS_COMPOSICAO1', vDsComposicao);
  putitemXml(Result, 'CD_CLASSIFICACAO', item_f('CD_CLASSIFICACAO', tPRD_CLASSIFIC));
  putitemXml(Result, 'DS_CLASSIFICACAO', item_a('DS_CLASSIFICACAO', tPRD_CLASSIFIC));
  putitemXml(Result, 'CD_TIPI', item_f('CD_TIPI', tFIS_TIPI));
  putitemXml(Result, 'DS_TIPI', item_a('DS_TIPI', tFIS_TIPI));

  return(0); exit;
end;

//-----------------------------------------------------------------
function T_GERSVCO046.buscaDadosUsuario(pParams : String) : String;
//-----------------------------------------------------------------
const
  cDS_METHOD = 'ADICONAL=Operação: T_GERSVCO046.buscaDadosUsuario()';
var
  vCdUsuario : Real;
  viParams, voParams : String;
begin
  vCdUsuario := itemXmlF('CD_USUARIO', pParams);

  viParams := '';

  putitemXml(viParams, 'CD_USUARIO', vCdUsuario);
  voParams := activateCmp('ADMSVCO027', 'validaUsuarioEspecial', viParams); (*,viParams,voParams,, *)
  if (xStatus < 0) then begin
    Result := voParams;
    return(-1); exit;
  end;
  if (voParams <> '') then begin
    putitemXml(Result, 'NM_USUARIO', itemXml('NM_USUARIO', voParams));
  end;

  return(0); exit;
end;

//-----------------------------------------------------------------
function T_GERSVCO046.buscaDadosServico(pParams : String) : String;
//-----------------------------------------------------------------
const
  cDS_METHOD = 'ADICONAL=Operação: T_GERSVCO046.buscaDadosServico()';
var
  vCdServico : Real;
begin
  vCdServico := itemXmlF('CD_SERVICO', pParams);

  if (vCdServico = 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Serviço não informado!', cDS_METHOD);
    return(-1); exit;
  end;
end;

//--------------------------------------------------------------------
function T_GERSVCO046.buscaDadosMPTerceito(pParams : String) : String;
//--------------------------------------------------------------------
const
  cDS_METHOD = 'ADICONAL=Operação: T_GERSVCO046.buscaDadosMPTerceito()';
var
  vCdPessoa : Real;
  vCdMPTer : String;
begin
  vCdPessoa := itemXmlF('CD_PESSOA', pParams);
  vCdMPTer := itemXmlF('CD_MPTER', pParams);

  if (vCdPessoa = 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Pessoa não informada!', cDS_METHOD);
    return(-1); exit;
  end;
  if (vCdMPTer = '') then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Matéria-prima de terceiro não informado!', cDS_METHOD);
    return(-1); exit;
  end;

  clear_e(tCDF_MPTER);
  putitem_e(tCDF_MPTER, 'CD_PESSOA', vCdPessoa);
  putitem_e(tCDF_MPTER, 'CD_MPTER', vCdMPTer);
  retrieve_e(tCDF_MPTER);
  if (xStatus < 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Matéria-prima ' + FloatToStr(vCdMPTer) + ' não cadastrada para a pessoa ' + FloatToStr(vCdPessoa) + '!', cDS_METHOD);
    return(-1); exit;
  end;

  Result := '';
  putitemXml(Result, 'DS_MP', item_a('DS_MP', tCDF_MPTER));
  putitemXml(Result, 'CD_ESPECIE', item_f('CD_ESPECIE', tCDF_MPTER));
  putitemXml(Result, 'CD_TIPI', item_f('CD_TIPI', tCDF_MPTER));

  return(0); exit;
end;

//------------------------------------------------------------------
function T_GERSVCO046.buscaDadosVendedor(pParams : String) : String;
//------------------------------------------------------------------
const
  cDS_METHOD = 'ADICONAL=Operação: T_GERSVCO046.buscaDadosVendedor()';
var
  vCdVendedor : Real;
begin
  vCdVendedor := itemXmlF('CD_VendEDOR', pParams);

  if (vCdVendedor = 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Vendedor não informado!', cDS_METHOD);
    return(-1); exit;
  end;

  clear_e(tPES_VENDEDOR);
  putitem_e(tPES_VENDEDOR, 'CD_VENDEDOR', vCdVendedor);
  retrieve_o(tPES_VENDEDOR);
  if (xStatus = -7) then begin
    retrieve_x(tPES_VENDEDOR);
  end;

  putitemXml(Result, 'NM_VendEDOR', item_a('NM_VENDEDOR', tPES_VENDEDOR));

  return(0); exit;
end;

//----------------------------------------------------------------
function T_GERSVCO046.buscaDadosFiscal(pParams : String) : String;
//----------------------------------------------------------------
const
  cDS_METHOD = 'ADICONAL=Operação: T_GERSVCO046.buscaDadosFiscal()';
var
  vCdTipi : String;
begin
  vCdTipi := itemXmlF('CD_TIPI', pParams);

  if (vCdTipi = '') then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'NCM não informado!', cDS_METHOD);
    return(-1); exit;
  end;

  clear_e(tFIS_TIPI);
  putitem_e(tFIS_TIPI, 'CD_TIPI', vCdTipi);
  retrieve_e(tFIS_TIPI);
  if (xStatus >= 0) then begin
    putitemXml(Result, 'DS_TIPI', item_a('DS_TIPI', tFIS_TIPI));
  end;

  return(0); exit;
end;

//---------------------------------------------------------------
function T_GERSVCO046.GetNomePortador(pParams : String) : String;
//---------------------------------------------------------------
const
  cDS_METHOD = 'ADICONAL=Operação: T_GERSVCO046.GetNomePortador()';
var
  vNrPortador, vDsPortador : String;
begin
  Result := '';
  vNrPortador := itemXmlF('NR_PORTADOR', pParams);
  clear_e(tFGR_PORTADOR);
  putitem_e(tFGR_PORTADOR, 'NR_PORTADOR', vNrPortador);
  retrieve_e(tFGR_PORTADOR);
  if (xStatus >=0) then begin
    putitemXml(Result, 'DS_PORTADOR', item_a('DS_PORTADOR', tFGR_PORTADOR));
  end;
  return(0); exit;
end;

//------------------------------------------------------------------
function T_GERSVCO046.buscaDadosTabPreco(pParams : String) : String;
//------------------------------------------------------------------
const
  cDS_METHOD = 'ADICONAL=Operação: T_GERSVCO046.buscaDadosTabPreco()';
var
  vCdEmpresa, vNrTransacao : Real;
  vDtTransacao : TDate;
begin
  vCdEmpresa := itemXmlF('CD_EMPRESA', pParams);
  vNrTransacao := itemXmlF('NR_TRANSACAO', pParams);
  vDtTransacao := itemXml('DT_TRANSACAO', pParams);

  if (vCdEmpresa = 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Empresa da transação não informado!', cDS_METHOD);
    return(-1); exit;
  end;
  if (vNrTransacao = 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Número da transação não informado!', cDS_METHOD);
    return(-1); exit;
  end;
  if (vDtTransacao = 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Data da transação não informado!', cDS_METHOD);
    return(-1); exit;
  end;

  clear_e(tTRA_TRANSACAD);
  putitem_e(tTRA_TRANSACAD, 'CD_EMPRESA', vCdEmpresa);
  putitem_e(tTRA_TRANSACAD, 'NR_TRANSACAO', vNrTransacao);
  putitem_e(tTRA_TRANSACAD, 'DT_TRANSACAO', vDtTransacao);
  retrieve_e(tTRA_TRANSACAD);
  if (xStatus < 0) then begin
      Result := SetStatus(STS_ERROR, 'GEN0001', 'Dados adicionais da transação ' + FloatToStr(vCdEmpresa/' + FloatToStr(vNrTransacao)) + ' + ' não cadastrada!', cDS_METHOD);
      Result := '';
      return(-1); exit;
  end;

  Result := '';

  if (item_f('CD_TABPRECO', tTRA_TRANSACAD)  <> '') then begin
    clear_e(tPED_TABPRECOC);
    putitem_e(tPED_TABPRECOC, 'CD_TABPRECO', item_f('CD_TABPRECO', tTRA_TRANSACAD));
    retrieve_e(tPED_TABPRECOC);
    if (xStatus < 0) then begin
      Result := SetStatus(STS_ERROR, 'GEN0001', 'Tabela de preço da transação ' + FloatToStr(vCdEmpresa/' + FloatToStr(vNrTransacao)) + ' + ' não encontrada!', cDS_METHOD);
      Result := '';
      return(-1); exit;
    end;

    putitemXml(Result, 'CD_TABPRECO', item_f('CD_TABPRECO', tPED_TABPRECOC));
    putitemXml(Result, 'DS_TABPRECO', item_a('DS_TABPRECO', tPED_TABPRECOC));
    putitemXml(Result, 'PR_VARIACAO', item_f('PR_VARIACAO', tPED_TABPRECOC));
  end;

  return(0); exit;

end;

//--------------------------------------------------------------------
function T_GERSVCO046.buscaDadosSeloFiscal(pParams : String) : String;
//--------------------------------------------------------------------
const
  cDS_METHOD = 'ADICONAL=Operação: T_GERSVCO046.buscaDadosSeloFiscal()';
var
  vCdEmpresa, vNrFatura : Real;
  vDtFatura : TDate;
begin
  vCdEmpresa := itemXmlF('CD_EMPRESA', pParams);
  vNrFatura := itemXmlF('NR_FATURA', pParams);
  vDtFatura := itemXml('DT_FATURA', pParams);

  if (vCdEmpresa = 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Empresa não informada!', cDS_METHOD);
    return(-1); exit;
  end;
  if (vNrFatura = 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Número da fatura não informada!', cDS_METHOD);
    return(-1); exit;
  end;
  if (vDtFatura = 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Data da fatura não informada!', cDS_METHOD);
    return(-1); exit;
  end;

  clear_e(tFIS_NFSELOFIS);
  putitem_e(tFIS_NFSELOFIS, 'CD_EMPRESA', vCdEmpresa);
  putitem_e(tFIS_NFSELOFIS, 'NR_FATURA', vNrFatura);
  putitem_e(tFIS_NFSELOFIS, 'DT_FATURA', vDtFatura);
  retrieve_e(tFIS_NFSELOFIS);
  if (xStatus >= 0) then begin
      putitemXml(Result, 'CD_SERIE', item_f('CD_SERIE', tFIS_NFSELOFIS));
      putitemXml(Result, 'NR_SELOFISCAL', item_f('NR_SELOFISCAL', tFIS_NFSELOFIS));
  end;

  return(0); exit;

end;

end.
