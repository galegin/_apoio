unit cPESSVCO001;

interface     

uses
  Classes, SysUtils, Math, DB,
  cDataSetUnf;

type
  T_PESSVCO001 = class(TComponent)
  private
    tOBS_REFERENCI,
    tPES_EMAIL,
    tPES_FORNECEDO,
    tPES_REFERENCI,
    tPES_TELEFONE : TcDatasetUnf;
    function getParam(pParams : String = '') : String;
    function setEntidade(pParams : String = '') : String;
  protected
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;    
  published
    function GravaConsultaSci(pParams : String = '') : String;
    function VldInEmail(pParams : String = '') : String;
    function VldInTelefone(pParams : String = '') : String;
    function validaGravaFornecedor(pParams : String = '') : String;
  end;

implementation

uses
  cADMSVCO001,
  cActivate, cStatus, cFuncao, cXml, dModulo;

var


//---------------------------------------------------------------
constructor T_PESSVCO001.Create(AOwner: TComponent);
//---------------------------------------------------------------
begin
  inherited Create(AOwner);
  setEntidade('');
end;

//--------------------------------
destructor T_PESSVCO001.Destroy;
//--------------------------------
begin
  inherited Destroy;
end;

//---------------------------------------------------------------
function T_PESSVCO001.getParam(pParams : String = '') : String;
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
function T_PESSVCO001.setEntidade(pParams : String = '') : String;
//---------------------------------------------------------------
begin
  tOBS_REFERENCI := TcDatasetUnf.getEntidade('OBS_REFERENCI');
  tPES_EMAIL := TcDatasetUnf.getEntidade('PES_EMAIL');
  tPES_FORNECEDO := TcDatasetUnf.getEntidade('PES_FORNECEDO');
  tPES_REFERENCI := TcDatasetUnf.getEntidade('PES_REFERENCI');
  tPES_TELEFONE := TcDatasetUnf.getEntidade('PES_TELEFONE');
end;

//----------------------------------------------------------------
function T_PESSVCO001.GravaConsultaSci(pParams : String) : String;
//----------------------------------------------------------------
const
  cDS_METHOD = 'ADICONAL=Operação: T_PESSVCO001.GravaConsultaSci()';
var
  (* numeric piCdPessoa :IN / string piDsConsulta :IN *)
  vNrSequencia : Real;
begin
  clear_e(tPES_REFERENCI);
  select max(nr_sequencia) from 'PES_REFERENCISVC' where                
                  (putitem_e(tPES_REFERENCI, 'CD_PESSOA', piCdPessoa)
                  to (vNrSequencia);

  creocc(tPES_REFERENCI, -1);
  putitem_e(tPES_REFERENCI, 'CD_PESSOA', piCdPessoa);
  putitem_e(tPES_REFERENCI, 'NR_SEQUENCIA', vNrSequencia + 1);
  putitem_e(tPES_REFERENCI, 'TP_REFERENCIA', 'S');
  putitem_e(tPES_REFERENCI, 'CD_OPERADOR', itemXmlF('CD_USUARIO', PARAM_GLB));
  putitem_e(tPES_REFERENCI, 'DT_CADASTRO', itemXml('DT_SISTEMA', PARAM_GLB));

  validateocc 'PES_REFERENCISVC';
  if (xStatus = 0) then begin
    voParams := tPES_REFERENCI.Salvar();
  end;

  clear_e(tOBS_REFERENCI);
  creocc(tOBS_REFERENCI, -1);
  putitem_e(tOBS_REFERENCI, 'CD_PESSOA', piCdPessoa);
  putitem_e(tOBS_REFERENCI, 'NR_SEQUENCIA', vNrSequencia + 1);
  putitem_e(tOBS_REFERENCI, 'DT_OBSERVACAO', Date);
  putitem_e(tOBS_REFERENCI, 'HR_OBSERVACAO', gclock);
  putitem_e(tOBS_REFERENCI, 'DS_OBSERVACAO', piDsConsulta);
  putitem_e(tOBS_REFERENCI, 'CD_OPERADOR', itemXmlF('CD_USUARIO', PARAM_GLB));
  putitem_e(tOBS_REFERENCI, 'DT_CADASTRO', itemXml('DT_SISTEMA', PARAM_GLB));

  validateocc 'OBS_REFERENCISVC';
  if (xStatus = 0) then begin
    voParams := tOBS_REFERENCI.Salvar();
  end;

  return(0); exit;
end;

//----------------------------------------------------------
function T_PESSVCO001.VldInEmail(pParams : String) : String;
//----------------------------------------------------------
const
  cDS_METHOD = 'ADICONAL=Operação: T_PESSVCO001.VldInEmail()';
begin
clear_e(tPES_EMAIL);
item_f('CD_PESSOA', tPES_EMAIL)=poCdPessoa;
item_b('IN_PADRAO', tPES_EMAIL)=True;
retrieve_e(tPES_EMAIL);
if (xStatus = -2) then begin
  poInPadrao=False;
end else if (xStatus = 0) then begin
  poInPadrao=True;
end else begin
end;
return(0); exit;

end;

//-------------------------------------------------------------
function T_PESSVCO001.VldInTelefone(pParams : String) : String;
//-------------------------------------------------------------
const
  cDS_METHOD = 'ADICONAL=Operação: T_PESSVCO001.VldInTelefone()';
begin
clear_e(tPES_TELEFONE);
item_f('CD_PESSOA', tPES_TELEFONE)=poCdPessoa;
item_b('IN_PADRAO', tPES_TELEFONE)=True;
retrieve_e(tPES_TELEFONE);
if (xStatus = -2) then begin
  poInPadrao=False;
end else if (xStatus = 0) then begin
  poInPadrao=True;
end else begin
end;
return(0); exit;

end;

//---------------------------------------------------------------------
function T_PESSVCO001.validaGravaFornecedor(pParams : String) : String;
//---------------------------------------------------------------------
const
  cDS_METHOD = 'ADICONAL=Operação: T_PESSVCO001.validaGravaFornecedor()';
var
  (* string piGlobal :IN *)
  vCdFornecedor : Real;
begin
  vCdFornecedor := itemXmlF('CD_FORNECEDOR', pParams);
  if (vCdFornecedor = '') then begin
    Result := SetStatus(STS_ERROR, 'GEN001', , cDS_METHOD);
    return(-1); exit;
  end;

  clear_e(tPES_FORNECEDO);
  putitem_e(tPES_FORNECEDO, 'CD_FORNECEDOR', vCdFornecedor);
  retrieve_e(tPES_FORNECEDO);
  if (xStatus < 0) then begin
    clear_e(tPES_FORNECEDO);
    creocc(tPES_FORNECEDO, -1);
    putitem_e(tPES_FORNECEDO, 'CD_FORNECEDOR', vCdFornecedor);
    putitem_e(tPES_FORNECEDO, 'CD_OPERADOR', itemXmlF('CD_USUARIO', piGlobal));
    putitem_e(tPES_FORNECEDO, 'DT_CADASTRO', Now);

    voParams := tPES_FORNECEDO.Salvar();
    if (xStatus < 0) then begin
      Result := voParams;
      return(-1); exit;
    end;
  end;

  return(0); exit;
end;

end.
