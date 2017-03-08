unit cFCRSVCO057;

interface

(* COMPONENTES 
  ADMSVCO001 / 
*)        

uses
  Classes, SysUtils, Math, DB,
  cDataSetUnf;

type
  T_FCRSVCO057 = class(TComponent)
  private
    tFCR_FATIMPOST,
    tFCR_FATURAI,
    tFIS_IMPRETENC,
    tPES_CLIIMPOST,
    tPES_PESSOACLA : TcDatasetUnf;
    function getParam(pParams : String = '') : String;
    function setEntidade(pParams : String = '') : String;
  protected
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;    
  published
    function validaPessoaOrgaoo(pParams : String = '') : String;
    function gravaImpostoFatura(pParams : String = '') : String;
  end;

implementation

uses
  cADMSVCO001,
  cActivate, cStatus, cFuncao, cXml, dModulo;

var
  gCdClassificacaoOrgaopublico,
  gCdTipoClasOrgaopublico : String;

//---------------------------------------------------------------
constructor T_FCRSVCO057.Create(AOwner: TComponent);
//---------------------------------------------------------------
begin
  inherited Create(AOwner);
  setEntidade('');
end;

//--------------------------------
destructor T_FCRSVCO057.Destroy;
//--------------------------------
begin
  inherited Destroy;
end;

//---------------------------------------------------------------
function T_FCRSVCO057.getParam(pParams : String = '') : String;
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
  putitem(xParamEmp, 'CD_CLASS_IMPOSTO_FCR');
  putitem(xParamEmp, 'CD_TPCLASS_IMPOSTO_FCR');

  xParamEmp := T_ADMSVCO001.GetParamEmpresa(piCdEmpresa, xParamEmp);

  gCdClassificacaoOrgaopublico := itemXml('CD_CLASS_IMPOSTO_FCR', xParamEmp);
  gCdTipoClasOrgaopublico := itemXml('CD_TPCLASS_IMPOSTO_FCR', xParamEmp);
  vCdEmpresa := itemXml('CD_EMPRESA', xParamEmp);
  vCdPessoa := itemXml('CD_PESSOA', xParamEmp);

end;

//---------------------------------------------------------------
function T_FCRSVCO057.setEntidade(pParams : String = '') : String;
//---------------------------------------------------------------
begin
  tFCR_FATIMPOST := TcDatasetUnf.getEntidade('FCR_FATIMPOST');
  tFCR_FATURAI := TcDatasetUnf.getEntidade('FCR_FATURAI');
  tFIS_IMPRETENC := TcDatasetUnf.getEntidade('FIS_IMPRETENC');
  tPES_CLIIMPOST := TcDatasetUnf.getEntidade('PES_CLIIMPOST');
  tPES_PESSOACLA := TcDatasetUnf.getEntidade('PES_PESSOACLA');
end;

//------------------------------------------------------------------
function T_FCRSVCO057.validaPessoaOrgaoo(pParams : String) : String;
//------------------------------------------------------------------
const
  cDS_METHOD = 'ADICONAL=Operação: T_FCRSVCO057.validaPessoaOrgaoo()';
var
  vCdPessoa, vCdEmpresa : Real;
  vInOrgaopublico : Boolean;
begin
  Result := '';
  vCdPessoa := itemXmlF('CD_PESSOA', pParams);
  vCdEmpresa := itemXmlF('CD_EMPRESA', PARAM_GLB);
  vInOrgaopublico := False;

  if (vCdPessoa = 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Pessoa não informada!', cDS_METHOD);
    return(-1); exit;
  end;

  getParams(pParams); (* vCdEmpresa, 'validaPessoaOrgaopublico' *)
  if (xStatus < 0) then begin
    return(-1); exit;
  end;
  if (gCdTipoClasOrgaopublico <> '')  and (gCdClassificacaoOrgaopublico <> '') then begin
    clear_e(tPES_PESSOACLA);
    putitem_e(tPES_PESSOACLA, 'CD_PESSOA', vCdPessoa);
    putitem_e(tPES_PESSOACLA, 'CD_TIPOCLAS', gCdTipoClasOrgaopublico);
    putitem_e(tPES_PESSOACLA, 'CD_CLASSIFICACAO', gCdClassificacaoOrgaopublico);
    retrieve_e(tPES_PESSOACLA);
    if (xStatus >= 0) then begin
      vInOrgaopublico := True;
    end;
  end;

  putitemXml(Result, 'IN_ORGAOpublicO', vInOrgaopublico);

  return(0); exit;
end;

//------------------------------------------------------------------
function T_FCRSVCO057.gravaImpostoFatura(pParams : String) : String;
//------------------------------------------------------------------
const
  cDS_METHOD = 'ADICONAL=Operação: T_FCRSVCO057.gravaImpostoFatura()';
var
  vCdEmpresa, vCdCliente, vNrFatura, vNrParcela, vVlImposto, vVlTotImposto : Real;
begin
  Result := '';
  vCdEmpresa := itemXmlF('CD_EMPRESA', pParams);
  vCdCliente := itemXmlF('CD_CLIENTE', pParams);
  vNrFatura := itemXmlF('NR_FAT', pParams);
  vNrParcela := itemXmlF('NR_PARCELA', pParams);

  if (vCdEmpresa = 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Empresa não informada!', cDS_METHOD);
    return(-1); exit;
  end;
  if (vCdCliente = 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Cliente não informado!', cDS_METHOD);
    return(-1); exit;
  end;
  if (vNrFatura = 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Número da fatura não informada!', cDS_METHOD);
    return(-1); exit;
  end;
  if (vNrParcela = 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Parcela da fatura não informada!', cDS_METHOD);
    return(-1); exit;
  end;

  clear_e(tFCR_FATURAI);
  putitem_e(tFCR_FATURAI, 'CD_EMPRESA', vCdEmpresa);
  putitem_e(tFCR_FATURAI, 'CD_CLIENTE', vCdCliente);
  putitem_e(tFCR_FATURAI, 'NR_FAT', vNrFatura);
  putitem_e(tFCR_FATURAI, 'NR_PARCELA', vNrParcela);
  retrieve_e(tFCR_FATURAI);
  if (xStatus < 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Fatura: ' + FloatToStr(vCdEmpresa/' + FloatToStr(vCdCliente/' + FloatToStr(vNrFatura/' + FloatToStr(vNrParcela)))) + ' + ' + ' + ' não encontrada!', cDS_METHOD);
    return(-1); exit;
  end;
  if (item_f('TP_DOCUMENTO', tFCR_FATURAI) <> 1) then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'A fatura informada: ' + FloatToStr(vCdEmpresa/' + FloatToStr(vCdCliente/' + FloatToStr(vNrFatura/' + FloatToStr(vNrParcela)))) + ' + ' + ' + ' não é um documento do tipo fatura!', cDS_METHOD);
    return(-1); exit;
  end;

  clear_e(tPES_CLIIMPOST);
  putitem_e(tPES_CLIIMPOST, 'CD_CLIENTE', vCdCliente);
  retrieve_e(tPES_CLIIMPOST);
  if (xStatus < 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'O cliente informado não possui alíquota de imposto cadastrado!', cDS_METHOD);
    return(-1); exit;
  end;

  vVlTotImposto := 0;
  clear_e(tFIS_IMPRETENC);
  putitem_e(tFIS_IMPRETENC, 'CD_EMPRESA', vCdEmpresa);
  retrieve_e(tFIS_IMPRETENC);
  if (xStatus >= 0) then begin
    setocc(tFIS_IMPRETENC, 1);
    while (xStatus >= 0) do begin

      clear_e(tPES_CLIIMPOST);
      putitem_e(tPES_CLIIMPOST, 'CD_CLIENTE', vCdCliente);
      putitem_e(tPES_CLIIMPOST, 'CD_IMPOSTO', item_f('CD_IMPOSTO', tFIS_IMPRETENC));
      retrieve_e(tPES_CLIIMPOST);
      if (xStatus >=0) then begin
        creocc(tFCR_FATIMPOST, -1);
        putitem_e(tFCR_FATIMPOST, 'CD_IMPOSTO', item_f('CD_IMPOSTO', tFIS_IMPRETENC));
        retrieve_o(tFCR_FATIMPOST);
        if (xStatus = -7) then begin
          retrieve_x(tFCR_FATIMPOST);
        end;
        if (item_f('PR_ALIQUOTA', tPES_CLIIMPOST) > 0) then begin
          vVlImposto := item_f('VL_FATURA', tFCR_FATURAI) * item_f('PR_ALIQUOTA', tPES_CLIIMPOST) / 100;
          vVlImposto := roundto(vVlImposto, 2);
          vVlTotImposto := vVlTotImposto + vVlImposto;

          putitem_e(tFCR_FATIMPOST, 'VL_IMPOSTO', vVlImposto);
          putitem_e(tFCR_FATIMPOST, 'PR_ALIQUOTA', item_f('PR_ALIQUOTA', tPES_CLIIMPOST));
        end else begin
          vVlImposto := item_f('VL_FATURA', tFCR_FATURAI) * item_f('PR_ALIQUOTA', tFIS_IMPRETENC) / 100;
          vVlImposto := roundto(vVlImposto, 2);
          vVlTotImposto := vVlTotImposto + vVlImposto;

          putitem_e(tFCR_FATIMPOST, 'VL_IMPOSTO', vVlImposto);
          putitem_e(tFCR_FATIMPOST, 'PR_ALIQUOTA', item_f('PR_ALIQUOTA', tFIS_IMPRETENC));
        end;
      putitem_e(tFCR_FATIMPOST, 'CD_OPERADOR', itemXmlF('CD_USUARIO', PARAM_GLB));
      putitem_e(tFCR_FATIMPOST, 'DT_CADASTRO', Now);
      end;
      setocc(tFIS_IMPRETENC, curocc(tFIS_IMPRETENC) + 1);
    end;

    putitem_e(tFCR_FATURAI, 'VL_IMPOSTO', vVlTotImposto);
    voParams := tFCR_FATURAI.Salvar();
    if (xStatus < 0) then begin
      Result := voParams;
      return(-1); exit;
    end;
  end;

  return(0); exit;
end;

end.
