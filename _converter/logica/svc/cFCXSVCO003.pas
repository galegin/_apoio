unit cFCXSVCO003;

interface

(* COMPONENTES 
  ADMSVCO001 / 
*)        

uses
  Classes, SysUtils, Math, DB,
  cDataSetUnf;

type
  T_FCXSVCO003 = class(TComponent)
  private
    tFCX_TERMINALU,
    tGER_OPERACAO,
    tV_FIS_NF : TcDatasetUnf;
    function getParam(pParams : String = '') : String;
    function setEntidade(pParams : String = '') : String;
  protected
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;    
  published
    function validaEncerramentoCx(pParams : String = '') : String;
  end;

implementation

uses
  cADMSVCO001,
  cActivate, cStatus, cFuncao, cXml, dModulo;

var
  gDtImplantacaoV3,
  gInCaixaTerminal : String;

//---------------------------------------------------------------
constructor T_FCXSVCO003.Create(AOwner: TComponent);
//---------------------------------------------------------------
begin
  inherited Create(AOwner);
  setEntidade('');
end;

//--------------------------------
destructor T_FCXSVCO003.Destroy;
//--------------------------------
begin
  inherited Destroy;
end;

//---------------------------------------------------------------
function T_FCXSVCO003.getParam(pParams : String = '') : String;
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
  putitem(xParam, 'DT_IMPLANTACAO_V3');

  xParam := T_ADMSVCO001.GetParametro(xParam);

  gDtImplantacaoV3 := itemXml('DT_IMPLANTACAO_V3', xParam);
  gInCaixaTerminal := itemXml('IN_CAIXA_TERMINAL', xParam);
  piCdEmpresa := itemXml('CD_EMPRESA', xParam);
  vCdEmpresa := itemXml('CD_EMPRESA', xParam);

  xParamEmp := '';
  putitem(xParamEmp, 'DT_IMPLANTACAO_V3');
  putitem(xParamEmp, 'IN_CAIXA_TERMINAL');

  xParamEmp := T_ADMSVCO001.GetParamEmpresa(piCdEmpresa, xParamEmp);

  gInCaixaTerminal := itemXml('IN_CAIXA_TERMINAL', xParamEmp);
  vCdEmpresa := itemXml('CD_EMPRESA', xParamEmp);
  vCdOperador := itemXml('CD_OPERADOR', xParamEmp);
  vCdOperador := itemXml('CD_USUARIO', xParamEmp);
  vCdTerminal := itemXml('CD_TERMINAL', xParamEmp);

end;

//---------------------------------------------------------------
function T_FCXSVCO003.setEntidade(pParams : String = '') : String;
//---------------------------------------------------------------
begin
  tFCX_TERMINALU := TcDatasetUnf.getEntidade('FCX_TERMINALU');
  tGER_OPERACAO := TcDatasetUnf.getEntidade('GER_OPERACAO');
  tV_FIS_NF := TcDatasetUnf.getEntidade('V_FIS_NF');
end;

//--------------------------------------------------------------------
function T_FCXSVCO003.validaEncerramentoCx(pParams : String) : String;
//--------------------------------------------------------------------
const
  cDS_METHOD = 'ADICONAL=Operação: T_FCXSVCO003.validaEncerramentoCx()';
var
  vCdEmpresa, vDsErro, vCdOperador, vCdTerminal : String;
begin
  vCdEmpresa := itemXmlF('CD_EMPRESA', pParams);
  if (vCdEmpresa = '') then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Empresa não informada!', cDS_METHOD);
    return(-1); exit;
  end;

  getParams(pParams); (* vCdEmpresa *)
  if (xStatus < 0) then begin
    return(-1); exit;
  end;

  vCdOperador := '';

  if (gInCaixaTerminal = True) then begin
    vCdOperador := itemXmlF('CD_OPERADOR', pParams);
  end else begin
    vCdTerminal := itemXmlF('CD_TERMINAL', pParams);

    clear_e(tFCX_TERMINALU);
    putitem_e(tFCX_TERMINALU, 'CD_EMPRESA', vCdEmpresa);
    putitem_e(tFCX_TERMINALU, 'CD_TERMINAL', vCdTerminal);
    retrieve_e(tFCX_TERMINALU);
    if (xStatus >= 0) then begin
      setocc(tFCX_TERMINALU, 1);
      while (xStatus >= 0) do begin
        if (vCdOperador = '') then begin
          vCdOperador := item_f('CD_USUARIO', tFCX_TERMINALU);
        end else begin
          vCdOperador := '' + FloatToStr(vCdOperador) + ';
        end;

        setocc(tFCX_TERMINALU, curocc(tFCX_TERMINALU) + 1);
      end;
    end;
  end;

  vDsErro := '';

  clear_e(tV_FIS_NF);
  if (gDtImplantacaoV3 <> '') then begin
    putitem_e(tV_FIS_NF, 'DT_FATURA', '>=' + gDtImplantacaoV + '3');
  end;
  putitem_e(tV_FIS_NF, 'CD_EMPFAT', vCdEmpresa);
  putitem_e(tV_FIS_NF, 'TP_SITUACAONF', 'N');
  putitem_e(tV_FIS_NF, 'CD_USUNF', vCdOperador);
  putitem_e(tV_FIS_NF, 'TP_MODALIDADE', 4);
  putitem_e(tV_FIS_NF, 'TP_OPERACAO', 'S');
  putitem_e(tV_FIS_NF, 'TP_ORIGEMEMISSAO', 1);
  retrieve_e(tV_FIS_NF);
  if (xStatus >= 0) then begin
    setocc(tV_FIS_NF, 1);
    while (xStatus >=0) do begin

      clear_e(tGER_OPERACAO);
      putitem_e(tGER_OPERACAO, 'CD_OPERACAO', item_f('CD_OPERACAO', tV_FIS_NF));
      retrieve_e(tGER_OPERACAO);
      if (xStatus >= 0)  and (item_f('TP_DOCTO', tGER_OPERACAO) > 0) then begin
        vDsErro := '' + vDsErroEmpresa/Fatura: + ' ' + item_f('CD_EMPFAT', tV_FIS_NF) + ' / ' + item_f('NR_FATURA', tV_FIS_NF) + ' / ' + item_a('DT_FATURA', tV_FIS_NF) + ' ';
      end;

      setocc(tV_FIS_NF, curocc(tV_FIS_NF) + 1);
    end;
  end;

  Result := '';
  if (vDsErro <> '') then begin
    putitemXml(Result, 'DS_LOGERRO', vDsErro);
    return(-1); exit;
  end;

  return(0); exit;
end;

end.
