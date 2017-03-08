unit cFISSVCO035;

interface

        

uses
  Classes, SysUtils, Math, DB,
  cDataSetUnf;

type
  T_FISSVCO035 = class(TComponent)
  private
    tFIS_INFOFISCA,
    tPRD_PRODUTO : TcDatasetUnf;
    function getParam(pParams : String = '') : String;
    function setEntidade(pParams : String = '') : String;
  protected
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;    
  published
    function buscaDadosFiscalProduto(pParams : String = '') : String;
  end;

implementation

uses
  cADMSVCO001,
  cActivate, cStatus, cFuncao, cXml, dModulo;

var


//---------------------------------------------------------------
constructor T_FISSVCO035.Create(AOwner: TComponent);
//---------------------------------------------------------------
begin
  inherited Create(AOwner);
  setEntidade('');
end;

//--------------------------------
destructor T_FISSVCO035.Destroy;
//--------------------------------
begin
  inherited Destroy;
end;

//---------------------------------------------------------------
function T_FISSVCO035.getParam(pParams : String = '') : String;
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
function T_FISSVCO035.setEntidade(pParams : String = '') : String;
//---------------------------------------------------------------
begin
  tFIS_INFOFISCA := TcDatasetUnf.getEntidade('FIS_INFOFISCA');
  tPRD_PRODUTO := TcDatasetUnf.getEntidade('PRD_PRODUTO');
end;

//-----------------------------------------------------------------------
function T_FISSVCO035.buscaDadosFiscalProduto(pParams : String) : String;
//-----------------------------------------------------------------------
const
  cDS_METHOD = 'ADICONAL=Operação: T_FISSVCO035.buscaDadosFiscalProduto()';
var
  vCdProduto : Real;
  vCdUfOrigem, vCdUFDestino, vTpOperacao : String;
  vDtSistema : TDate;
begin
  vCdProduto := itemXmlF('CD_PRODUTO', pParams);
  vCdUfOrigem := itemXml('UF_ORIGEM', pParams);
  vCdUFDestino := itemXml('UF_DESTINO', pParams);
  vTpOperacao := itemXmlF('TP_OPERACAO', pParams);
  vDtSistema := itemXml('DT_SISTEMA', PARAM_GLB);

  if (vCdUfOrigem = '') then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'UF origem não informada!', cDS_METHOD);
    return(-1); exit;
  end;
  if (vCdUfDestino = '') then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'UF destino não informada!', cDS_METHOD);
    return(-1); exit;
  end;
  if (vTpOperacao = '') then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Tipo de operação não informada!', cDS_METHOD);
    return(-1); exit;
  end;
  if (vCdProduto <> '') then begin
    clear_e(tPRD_PRODUTO);
    putitem_e(tPRD_PRODUTO, 'CD_PRODUTO', vCdProduto);
    retrieve_e(tPRD_PRODUTO);
    if (xStatus < 0) then begin
      Result := SetStatus(STS_ERROR, 'GEN0001', 'Produto inválido!', cDS_METHOD);
      return(-1); exit;
    end;
    if (item_f('CD_TIPI', tPRD_PRODUTO) <> '') then begin
      clear_e(tFIS_INFOFISCA);
      putitem_e(tFIS_INFOFISCA, 'TP_OPERACAO', vTpOperacao);
      putitem_e(tFIS_INFOFISCA, 'CD_NCM', item_f('CD_TIPI', tPRD_PRODUTO));
      putitem_e(tFIS_INFOFISCA, 'CD_UFORIGEM', vCDUfOrigem);
      putitem_e(tFIS_INFOFISCA, 'CD_UFDESTINO', vCdUfDestino);
      retrieve_e(tFIS_INFOFISCA);
      if (xStatus >= 0) then begin
        if (item_a('DT_INIVIGENCIA', tFIS_INFOFISCA) <> '')  and (vDtSistema < item_a('DT_INIVIGENCIA', tFIS_INFOFISCA))  or %\ then begin
          (item_a('DT_FIMVIGENCIA', tFIS_INFOFISCA) <> '')  and (vDtSistema > item_a('DT_FIMVIGENCIA', tFIS_INFOFISCA));
          return(0); exit;
        end;

        putlistitensocc_e(Result, tFIS_INFOFISCA);
      end;
    end;
  end;

  return(0); exit;
end;

end.
