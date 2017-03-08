unit cFCCSVCO017;

interface

(* COMPONENTES 
  GERSVCO031 / 
*)        

uses
  Classes, SysUtils, DB,
  cServiceUnf, cDataSetUnf;

type
  T_FCCSVCO017 = class(TcServiceUnf)
  private
    tFCC_MOVREL,
    tGER_EMPRESA : TcDatasetUnf;
    function getParam(pParams : String = '') : String;
    function setEntidade(pParams : String = '') : String;
  protected
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;    
  published
    function getNumMovRel(pParams : String = '') : String;
    function gravaMovRel(pParams : String = '') : String;
  end;

implementation

uses
  cADMSVCO001,
  cActivate, cStatus, cFuncao, cXml, dModulo;

var


//---------------------------------------------------------------
constructor T_FCCSVCO017.Create(AOwner: TComponent);
//---------------------------------------------------------------
begin
  inherited Create(AOwner);
  setEntidade('');
end;

//--------------------------------
destructor T_FCCSVCO017.Destroy;
//--------------------------------
begin
  inherited Destroy;
end;

//---------------------------------------------------------------
function T_FCCSVCO017.getParam(pParams : String = '') : String;
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
function T_FCCSVCO017.setEntidade(pParams : String = '') : String;
//---------------------------------------------------------------
begin
  tFCC_MOVREL := GetEntidade('FCC_MOVREL');
  tGER_EMPRESA := GetEntidade('GER_EMPRESA');
end;

//------------------------------------------------------------
function T_FCCSVCO017.getNumMovRel(pParams : String) : String;
//------------------------------------------------------------
const
  cDS_METHOD = 'ADICIONAL=Operação: T_FCCSVCO017.getNumMovRel()';
var
  vNrSeqMovRel : Real;
  viParams, voParams : String;
begin
  vNrSeqMovRel := 0;
  while (vNrSeqMovRel := 0) do begin
    viParams := '';
    putitemXml(viParams, 'NM_ENTIDADE', 'FCC_MOVREL');
    voParams := activateCmp('GERSVCO031', 'getNumSeq', viParams); (*,,,, *)
    if (xStatus < 0) then begin
      Result := voParams;
      return(-1); exit;
    end;

    vNrSeqMovRel := itemXmlF('NR_SEQUENCIA', voParams);
  end;

  putitemXml(Result, 'NR_SEQMOVREL', vNrSeqMovRel);

  return(0); exit;
end;

//-----------------------------------------------------------
function T_FCCSVCO017.gravaMovRel(pParams : String) : String;
//-----------------------------------------------------------
const
  cDS_METHOD = 'ADICIONAL=Operação: T_FCCSVCO017.gravaMovRel()';
var
  vCdEmpMov, vNrSeqMovRel, vNrCtaPesFcc, vNrSeqMovFcc, vTpOrigem : Real;
  viParams, voParams, vTpOperacao : String;
  vDtMov, vDtMovFcc : TDate;
begin
  Result := '';

  vCdEmpMov := itemXmlF('CD_EMPMOV', pParams);
  if (vCdEmpMov = 0) then begin
    vCdEmpMov := itemXmlF('CD_EMPRESA', PARAM_GLB);
  end;
  vDtMov := itemXml('DT_MOV', pParams);
  if (vDtMov    = '') then begin
    vDtMov := itemXml('DT_SISTEMA', PARAM_GLB);
  end;
  vNrSeqMovRel := itemXmlF('NR_SEQMOV', pParams);
  vNrCtaPesFcc := itemXmlF('NR_CTAPESFCC', pParams);
  vDtMovFcc := itemXml('DT_MOV', pParams);
  vNrSeqMovFcc := itemXmlF('NR_SEQMOVFCC', pParams);
  vTpOperacao := itemXmlF('TP_OPERACAO', pParams);
  vTpOrigem := itemXmlF('TP_ORIGEM', pParams);

  clear_e(tGER_EMPRESA);
  putitem_e(tGER_EMPRESA, 'CD_EMPRESA', vCdEmpMov);
  retrieve_e(tGER_EMPRESA);
  if (xStatus < 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Empresa ' + FloatToStr(vCdEmpMov) + ' não cadastrada.', cDS_METHOD);
    return(-1); exit;
  end;
  if (vDtMov = 0)  or (vDtMov = '') then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Data de movimento não informada.', cDS_METHOD);
    return(-1); exit;
  end;
  if (vNrSeqMovRel = 0)  or (vNrSeqMovRel = '') then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Número de sequência de movimento não informado.', cDS_METHOD);
    return(-1); exit;
  end;
  if (vNrCtaPesFcc = 0)  or (vNrCtaPesFcc = '') then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Número da conta de movimento não informado.', cDS_METHOD);
    return(-1); exit;
  end;
  if (vDtMovFcc = 0)  or (vDtMovFcc = '') then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Data do movimento da conta não informada.', cDS_METHOD);
    return(-1); exit;
  end;
  if (vNrSeqMovFcc = 0)  or (vNrSeqMovFcc = '') then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Número de sequência do movimento da conta não informado.', cDS_METHOD);
    return(-1); exit;
  end;
  if (vTpOrigem <> 1)  and (vTpOrigem <> 2) then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Tipo do movimento de origem não informado, ou informado com erro (intervalo aceito >= 1 e <= 2).', cDS_METHOD);
    return(-1); exit;
  end;
  if (vTpOperacao <> 'C')  and (vTpOperacao <> 'D') then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Tipo do operação não informado, ou informado com erro (aceito D ou C).', cDS_METHOD);
    return(-1); exit;
  end;

  clear_e(tFCC_MOVREL);
  creocc(tFCC_MOVREL, -1);
  putitem_e(tFCC_MOVREL, 'CD_EMPMOV', vCdEmpMov);
  putitem_e(tFCC_MOVREL, 'DT_MOV', vDtMov);
  putitem_e(tFCC_MOVREL, 'NR_SEQMOV', vNrSeqMovRel);
  putitem_e(tFCC_MOVREL, 'NR_CTAPESFCC', vNrCtaPesFcc);
  putitem_e(tFCC_MOVREL, 'DT_MOVIMFCC', vDtMovFcc);
  putitem_e(tFCC_MOVREL, 'NR_SEQMOVFCC', vNrSeqMovFcc);
  putitem_e(tFCC_MOVREL, 'TP_OPERACAO', vTpOperacao);
  putitem_e(tFCC_MOVREL, 'TP_ORIGEM', vTpOrigem);
  putitem_e(tFCC_MOVREL, 'CD_OPERADOR', itemXmlF('CD_USUARIO', PARAM_GLB));
  putitem_e(tFCC_MOVREL, 'DT_CADASTRO', Now);
  voParams := tFCC_MOVREL.Salvar();
  if (xStatus < 0) then begin
    Result := voParams;
    return(-1); exit;
  end;

  putitemXml(Result, 'CD_EMPMOV', item_f('CD_EMPMOV', tFCC_MOVREL));
  putitemXml(Result, 'DT_MOV', item_a('DT_MOV', tFCC_MOVREL));
  putitemXml(Result, 'NR_SEQMOV', item_f('NR_SEQMOV', tFCC_MOVREL));

  return(0); exit;
end;


end.
