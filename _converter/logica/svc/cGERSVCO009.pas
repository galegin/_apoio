unit cGERSVCO009;

interface

        

uses
  Classes, SysUtils, Math, DB,
  cServiceUnf, cDataSetUnf;

type
  T_GERSVCO009 = class(TcServiceUnf)
  private
    tPRD_SEQKARDEX,
    tPRD_SEQVALOR : TcDatasetUnf;
    function getParam(pParams : String = '') : String;
    function setEntidade(pParams : String = '') : String;
  protected
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;    
  published
    function GetSeqKardex(pParams : String = '') : String;
    function GetSeqValor(pParams : String = '') : String;
  end;

implementation

uses
  cADMSVCO001,
  cActivate, cStatus, cFuncao, cXml, dModulo;

var


//---------------------------------------------------------------
constructor T_GERSVCO009.Create(AOwner: TComponent);
//---------------------------------------------------------------
begin
  inherited Create(AOwner);
  setEntidade('');
end;

//--------------------------------
destructor T_GERSVCO009.Destroy;
//--------------------------------
begin
  inherited Destroy;
end;

//---------------------------------------------------------------
function T_GERSVCO009.getParam(pParams : String = '') : String;
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
function T_GERSVCO009.setEntidade(pParams : String = '') : String;
//---------------------------------------------------------------
begin
  tPRD_SEQKARDEX := GetEntidade('PRD_SEQKARDEX');
  tPRD_SEQVALOR := GetEntidade('PRD_SEQVALOR');
end;

//------------------------------------------------------------
function T_GERSVCO009.GetSeqKardex(pParams : String) : String;
//------------------------------------------------------------
const
  cDS_METHOD = 'ADICONAL=Operação: T_GERSVCO009.GetSeqKardex()';
begin
  xCdErro := '';
  xCtxErro := '';
  clear_e(tPRD_SEQKARDEX);
  putitem_e(tPRD_SEQKARDEX, 'CD_EMPRESA', pCdEmpresa);
  putitem_e(tPRD_SEQKARDEX, 'CD_PRODUTO', piCdProduto);
  retrieve_e(tPRD_SEQKARDEX);
  if (xStatus = 0) then begin
    if (piDtLcto < item_a('DT_LANCAMENTO', tPRD_SEQKARDEX)) then begin
      voParams := SetErroApl(viParams); (* 'ERRO=-1;
      return(-1); exit;
    end else if (piDtLcto = item_a('DT_LANCAMENTO', tPRD_SEQKARDEX)) then begin
      putitem_e(tPRD_SEQKARDEX, 'NR_SEQUENCIA', item_f('NR_SEQUENCIA', tPRD_SEQKARDEX) + 1);
      if (item_f('NR_SEQUENCIA', tPRD_SEQKARDEX) > 99998) then begin
        voParams := SetErroApl(viParams); (* 'ERRO=-1;
        return(-1); exit;
      end else begin
        poNrSeq := item_f('NR_SEQUENCIA', tPRD_SEQKARDEX);
      end;
    end else if (piDtLcto > item_a('DT_LANCAMENTO', tPRD_SEQKARDEX)) then begin
      putitem_e(tPRD_SEQKARDEX, 'DT_LANCAMENTO', piDtLcto);
      putitem_e(tPRD_SEQKARDEX, 'NR_SEQUENCIA', 1);
      poNrSeq := 1;
    end else begin
      voParams := SetErroApl(viParams); (* 'ERRO=-1;
      return(-1); exit;
    end;
    xCdErro := '';
    xCtxErro := '';
  end else if (xStatus = -2) then begin
    xCdErro := '';
    xCtxErro := '';
    xStatus := 0;
    creocc(tPRD_SEQKARDEX, -1);
    putitem_e(tPRD_SEQKARDEX, 'CD_EMPRESA', pCdEmpresa);
    putitem_e(tPRD_SEQKARDEX, 'CD_PRODUTO', piCdProduto);
    putitem_e(tPRD_SEQKARDEX, 'NR_SEQUENCIA', 1);
    putitem_e(tPRD_SEQKARDEX, 'CD_GRUPOEMPRESA', itemXmlF('CD_GRUPOEMPRESA', piGlobal));
    putitem_e(tPRD_SEQKARDEX, 'DT_LANCAMENTO', piDtLcto);
    putitem_e(tPRD_SEQKARDEX, 'CD_OPERADOR', itemXmlF('CD_USUARIO', piGlobal));
    putitem_e(tPRD_SEQKARDEX, 'DT_CADASTRO', Now);
    poNrSeq := 1;
  end else begin
    Result := SetStatus(STS_ERROR, xProcerror, xProcerrorcontext, '');
    return(-1); exit;
  end;
  voParams := tPRD_SEQKARDEX.Salvar();
  if (xStatus < 0) then begin
    Result := voParams;
    return(-1); exit;
  end;

  return(0); exit;
end;

//-----------------------------------------------------------
function T_GERSVCO009.GetSeqValor(pParams : String) : String;
//-----------------------------------------------------------
const
  cDS_METHOD = 'ADICONAL=Operação: T_GERSVCO009.GetSeqValor()';
begin
  xCdErro := '';
  xCtxErro := '';
  clear_e(tPRD_SEQVALOR);
  putitem_e(tPRD_SEQVALOR, 'CD_EMPRESA', pCdEmpresa);
  putitem_e(tPRD_SEQVALOR, 'CD_PRODUTO', piCdProduto);
  putitem_e(tPRD_SEQVALOR, 'TP_VALOR', piTpValor);
  putitem_e(tPRD_SEQVALOR, 'CD_VALOR', piCdValor);
  retrieve_e(tPRD_SEQVALOR);
  if (xStatus >= 0) then begin
    if (piDtLcto < item_a('DT_LANCAMENTO', tPRD_SEQVALOR)) then begin
      voParams := SetErroApl(viParams); (* 'ERRO=-1;
      return(-1); exit;
    end else if (piDtLcto = item_a('DT_LANCAMENTO', tPRD_SEQVALOR)) then begin
      putitem_e(tPRD_SEQVALOR, 'NR_SEQUENCIA', item_f('NR_SEQUENCIA', tPRD_SEQVALOR) + 1);
      if (item_f('NR_SEQUENCIA', tPRD_SEQVALOR) > 9998) then begin
        voParams := SetErroApl(viParams); (* 'ERRO=-1;
        return(-1); exit;
      end else begin
        poNrSeq := item_f('NR_SEQUENCIA', tPRD_SEQVALOR);
      end;
    end else if (piDtLcto > item_a('DT_LANCAMENTO', tPRD_SEQVALOR)) then begin
      putitem_e(tPRD_SEQVALOR, 'DT_LANCAMENTO', piDtLcto);
      putitem_e(tPRD_SEQVALOR, 'NR_SEQUENCIA', 1);
      poNrSeq := 1;
    end else begin

      voParams := SetErroApl(viParams); (* 'ERRO=-1;
      return(-1); exit;
    end;
    xCdErro := '';
    xCtxErro := '';
  end else if (xStatus = -2) then begin
    xStatus := 0;
    xCdErro := '';
    xCtxErro := '';
    creocc(tPRD_SEQVALOR, -1);
    putitem_e(tPRD_SEQVALOR, 'CD_EMPRESA', pCdEmpresa);
    putitem_e(tPRD_SEQVALOR, 'CD_PRODUTO', piCdProduto);
    putitem_e(tPRD_SEQVALOR, 'TP_VALOR', piTpValor);
    putitem_e(tPRD_SEQVALOR, 'CD_VALOR', piCdValor);
    putitem_e(tPRD_SEQVALOR, 'NR_SEQUENCIA', 1);
    putitem_e(tPRD_SEQVALOR, 'CD_GRUPOEMPRESA', itemXmlF('CD_GRUPOEMPRESA', piGlobal));
    putitem_e(tPRD_SEQVALOR, 'DT_LANCAMENTO', piDtLcto);
    putitem_e(tPRD_SEQVALOR, 'CD_OPERADOR', itemXmlF('CD_USUARIO', piGlobal));
    putitem_e(tPRD_SEQVALOR, 'DT_CADASTRO', Now);
    poNrSeq := 1;
  end else begin
    Result := SetStatus(STS_ERROR, xProcerror, xProcerrorcontext, '');
    return(-1); exit;
  end;
  voParams := tPRD_SEQVALOR.Salvar();
  if (xStatus < 0) then begin
    Result := voParams;
    return(-1); exit;
  end;

  return(0); exit;
end;

end.
