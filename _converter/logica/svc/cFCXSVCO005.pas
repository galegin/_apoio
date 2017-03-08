unit cFCXSVCO005;

interface

        

uses
  Classes, SysUtils, Math, DB,
  cDataSetUnf;

type
  T_FCXSVCO005 = class(TComponent)
  private
    tFCX_HISTRELEM,
    tFCX_HISTRELUS,
    tPES_CLIENTEFP : TcDatasetUnf;
    function getParam(pParams : String = '') : String;
    function setEntidade(pParams : String = '') : String;
  protected
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;    
  published
    function validaHistRel(pParams : String = '') : String;
  end;

implementation

uses
  cADMSVCO001,
  cActivate, cStatus, cFuncao, cXml, dModulo;

var


//---------------------------------------------------------------
constructor T_FCXSVCO005.Create(AOwner: TComponent);
//---------------------------------------------------------------
begin
  inherited Create(AOwner);
  setEntidade('');
end;

//--------------------------------
destructor T_FCXSVCO005.Destroy;
//--------------------------------
begin
  inherited Destroy;
end;

//---------------------------------------------------------------
function T_FCXSVCO005.getParam(pParams : String = '') : String;
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
function T_FCXSVCO005.setEntidade(pParams : String = '') : String;
//---------------------------------------------------------------
begin
  tFCX_HISTRELEM := TcDatasetUnf.getEntidade('FCX_HISTRELEM');
  tFCX_HISTRELUS := TcDatasetUnf.getEntidade('FCX_HISTRELUS');
  tPES_CLIENTEFP := TcDatasetUnf.getEntidade('PES_CLIENTEFP');
end;

//-------------------------------------------------------------
function T_FCXSVCO005.validaHistRel(pParams : String) : String;
//-------------------------------------------------------------
const
  cDS_METHOD = 'ADICONAL=Operação: T_FCXSVCO005.validaHistRel()';
var
  vCdEmpresa, vCdUsuario, vTpDocumento, vCdPessoa : Real;
  inValido, vInTotalizador, vInFaturamento, vInRecebimento : Boolean;
begin
  vInTotalizador := itemXmlB('IN_TOTALIZADOR', pParams);
  vInFaturamento := itemXmlB('IN_FATURAMENTO', pParams);
  vInRecebimento := itemXmlB('IN_RECEBIMENTO', pParams);

  vCdEmpresa := itemXmlF('CD_EMPRESA', pParams);
  if (vCdEmpresa = 0) then begin
    vCdEmpresa := itemXmlF('CD_EMPRESA', PARAM_GLB);
  end;

  vCdUsuario := itemXmlF('CD_USUARIO', pParams);
  if (vCdUsuario = 0) then begin
    vCdUsuario := itemXmlF('CD_USUARIO', PARAM_GLB);
  end;

  vCdPessoa := itemXmlF('CD_PESSOA', pParams);

  vTpDocumento := itemXmlF('TP_DOCUMENTO', pParams);
  if (vTpDocumento = 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Tipo de documento não informado!', cDS_METHOD);
    return(-1); exit;
  end;

  inValido := True;

  if (vCdPessoa <> 0) then begin
    clear_e(tPES_CLIENTEFP);
    putitem_e(tPES_CLIENTEFP, 'CD_CLIENTE', vCdPessoa);
    retrieve_e(tPES_CLIENTEFP);
    if (xStatus >= 0) then begin
      clear_e(tPES_CLIENTEFP);
      putitem_e(tPES_CLIENTEFP, 'CD_CLIENTE', vCdPessoa);
      putitem_e(tPES_CLIENTEFP, 'TP_DOCUMENTO', vTpDocumento);
      retrieve_e(tPES_CLIENTEFP);
      if (xStatus < 0) then begin
        inValido := False;
        putitemXml(Result, 'IN_VALIDO', inValido);
        return(0); exit;
      end;
    end;
  end;

  clear_e(tFCX_HISTRELUS);
  putitem_e(tFCX_HISTRELUS, 'CD_USUARIO', vCdUsuario);
  retrieve_e(tFCX_HISTRELUS);
  if (xStatus >= 0) then begin
    clear_e(tFCX_HISTRELUS);
    putitem_e(tFCX_HISTRELUS, 'CD_USUARIO', vCdUsuario);
    putitem_e(tFCX_HISTRELUS, 'TP_DOCUMENTO', vTpDocumento);
    putitem_e(tFCX_HISTRELUS, 'IN_TOTALIZADOR', vInTotalizador);
    putitem_e(tFCX_HISTRELUS, 'IN_FATURAMENTO', vInFaturamento);
    putitem_e(tFCX_HISTRELUS, 'IN_RECEBIMENTO', vInRecebimento);
    retrieve_e(tFCX_HISTRELUS);
    if (xStatus < 0) then begin
      inValido := False;
      putitemXml(Result, 'IN_VALIDO', inValido);
      return(0); exit;
    end;
  end;

  clear_e(tFCX_HISTRELEM);
  putitem_e(tFCX_HISTRELEM, 'CD_EMPRESA', vCdEmpresa);
  retrieve_e(tFCX_HISTRELEM);
  if (xStatus >= 0) then begin
    clear_e(tFCX_HISTRELEM);
    putitem_e(tFCX_HISTRELEM, 'CD_EMPRESA', vCdEmpresa);
    putitem_e(tFCX_HISTRELEM, 'TP_DOCUMENTO', vTpDocumento);
    putitem_e(tFCX_HISTRELEM, 'IN_TOTALIZADOR', vInTotalizador);
    putitem_e(tFCX_HISTRELEM, 'IN_FATURAMENTO', vInFaturamento);
    putitem_e(tFCX_HISTRELEM, 'IN_RECEBIMENTO', vInRecebimento);
    retrieve_e(tFCX_HISTRELEM);
    if (xStatus < 0) then begin
      inValido := False;
      putitemXml(Result, 'IN_VALIDO', inValido);
      return(0); exit;
    end;
  end;

  putitemXml(Result, 'IN_VALIDO', inValido);

  return(0); exit;

end;

end.
