unit cFGRSVCO007;

interface

        

uses
  Classes, SysUtils, DB,
  cServiceUnf, cDataSetUnf;

type
  T_FGRSVCO007 = class(TcServiceUnf)
  private
    tGER_FERIADO : TcDatasetUnf;
    function getParam(pParams : String = '') : String;
    function setEntidade(pParams : String = '') : String;
  protected
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;    
  published
    function RetornaProximoDiaUtil(pParams : String = '') : String;
    function ValidaDiaUtil(pParams : String = '') : String;
    function VerificaFeriado(pParams : String = '') : String;
    function RetornaQtDiasUtil(pParams : String = '') : String;
  end;

implementation

uses
  cADMSVCO001,
  cActivate, cStatus, cFuncao, cXml, dModulo;

var


//---------------------------------------------------------------
constructor T_FGRSVCO007.Create(AOwner: TComponent);
//---------------------------------------------------------------
begin
  inherited Create(AOwner);
  setEntidade('');
end;

//--------------------------------
destructor T_FGRSVCO007.Destroy;
//--------------------------------
begin
  inherited Destroy;
end;

//---------------------------------------------------------------
function T_FGRSVCO007.getParam(pParams : String) : String;
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
function T_FGRSVCO007.setEntidade(pParams : String) : String;
//---------------------------------------------------------------
begin
  tGER_FERIADO := GetEntidade('GER_FERIADO');
end;

//---------------------------------------------------------------------
function T_FGRSVCO007.RetornaProximoDiaUtil(pParams : String) : String;
//---------------------------------------------------------------------
const
  cDS_METHOD = 'ADICIONAL=Operação: T_FGRSVCO007.RetornaProximoDiaUtil()';
var
  vCdEmp : Real;
  vSabado : Real;
  vDiaSemana : Real;
  vDiaUtil : String;
  viParams : String;
  voParams : String;
  vInFeriado : String;
  vDtData : TDate;
begin
  vCdEmp := itemXmlF('CD_EMPRESA', pParams);
  vDtData := itemXml('DT_DATA', pParams);
  vSabado := itemXmlB('IN_SABADOUTIL', pParams);

  vDiaUtil := 'NAO';

  while (vDiaUtil := 'NAO') do begin
    vDiaSemana := vDtData[A];

    putitemXml(viParams, 'DT_DATA', vDtData);
    putitemXml(viParams, 'CD_EMPRESA', vCdEmp);

    voParams := VerificaFeriado(viParams); (* PARAM_GLB, viParams, voParams, xCdErro, xCtxErro *)
    if (xStatus < 0) then begin
      Result := voParams;
      return(-1); exit;
    end;
    if (voParams <> '') then begin
      vInFeriado := itemXmlB('IN_FERIADO', voParams);
    end else begin
      if (vInFeriado = '') then begin
        Result := SetStatus(STS_ERROR, 'GEN0001', 'Feriado não cadastrado!', cDS_METHOD);
        return(-1); exit;
      end;
    end;
    if (vInFeriado ='S') then begin
      vDtData := vDtData + 1d;
    end else begin
      if (vDiaSemana = 6) then begin
        if (vSabado = 1) then begin
          vDiaUtil := 'SIM';
        end else begin
          vDtData := vDtData + 2d;
        end;
      end else begin
        if (vDiaSemana = 7) then begin
          vDtData := vDtData + 1d;
        end else begin
          vDiaUtil := 'SIM';
        end;
      end;
    end;
  end;

  Result := 'DT_DIAUTIL=' + vDtData' + ';

  return(0); exit;

end;

//-------------------------------------------------------------
function T_FGRSVCO007.ValidaDiaUtil(pParams : String) : String;
//-------------------------------------------------------------
const
  cDS_METHOD = 'ADICIONAL=Operação: T_FGRSVCO007.ValidaDiaUtil()';
var
  vCdEmp : Real;
  vSabado : Real;
  vDiaSemana : Real;
  viParams : String;
  voParams : String;
  vInFeriado : String;
  vDtData : TDate;
  DsDiaUtil : String;
begin
  vCdEmp := itemXmlF('CD_EMPRESA', pParams);
  vDtData := itemXml('DT_DATABASE', pParams);
  vSabado := itemXmlB('IN_SABADOUTIL', pParams);

  vDiaSemana := vDtData[A];

  putitemXml(viParams, 'DT_DATA', vDtData);
  putitemXml(viParams, 'CD_EMPRESA', vCdEmp);

  voParams := VerificaFeriado(viParams); (* PARAM_GLB, viParams, voParams, xCdErro, xCtxErro *)
  if (xStatus < 0) then begin
    Result := voParams;
    return(-1); exit;
  end;
  if (voParams <> '') then begin
    vInFeriado := itemXmlB('IN_FERIADO', voParams);
  end else begin
    if (vInFeriado = '') then begin
      Result := SetStatus(STS_ERROR, 'GEN0001', 'Feriado não cadastrado!', cDS_METHOD);
      return(-1); exit;
    end;
  end;
  if (vInFeriado = 'S') then begin
    DsDiaUtil := 'NAO';
  end else begin

    if (vDiaSemana = 7) then begin
      DsDiaUtil := 'NAO';
    end else begin

      if (vDiaSemana = 6) then begin
        if (vSabado = 1) then begin
          DsDiaUtil := 'SIM';
        end else begin

          DsDiaUtil := 'NAO';
        end;
      end else begin

        DsDiaUtil := 'SIM';
      end;
    end;
  end;

  Result := 'DS_DIAUTIL=' + DsDiaUtil' + ';

  return(0); exit;

end;

//---------------------------------------------------------------
function T_FGRSVCO007.VerificaFeriado(pParams : String) : String;
//---------------------------------------------------------------
const
  cDS_METHOD = 'ADICIONAL=Operação: T_FGRSVCO007.VerificaFeriado()';
var
  vData : TDate;
  vAno : Real;
begin
  vData := itemXml('DT_DATA', pParams);
  if (vData = '') then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Data não informado!', cDS_METHOD);
    return(-1); exit;
  end;
  vAno := vData[Y];
  clear_e(tGER_FERIADO);
  putitem_e(tGER_FERIADO, 'CD_EMPRESA', itemXmlF('CD_EMPRESA', pParams));
  putitem_e(tGER_FERIADO, 'CD_TURNO', 999);
  putitem_e(tGER_FERIADO, 'DT_FERIADO', vData);
  retrieve_e(tGER_FERIADO);
  if (xStatus >= 0) then begin
    Result := 'IN_FERIADO=S';
  end else begin
    Result := 'IN_FERIADO=N';
  end;

  return(0); exit;

end;

//-----------------------------------------------------------------
function T_FGRSVCO007.RetornaQtDiasUtil(pParams : String) : String;
//-----------------------------------------------------------------
const
  cDS_METHOD = 'ADICIONAL=Operação: T_FGRSVCO007.RetornaQtDiasUtil()';
begin
var
  vCdEmpresa : Real;
  vSabadoUtil : Real;
  vDataInicial : TDate;
  vDataFinal : TDate;
  vDtData : TDate;
  vDiaSemana : Real;
  vQtDiasUteis : Real;
  vInFeriado : String;
  DsDiaUtil : String;
  viParams : String;
  voParams : String;
begin
  vSabadoUtil := itemXmlB('IN_SABADOUTIL', pParams);
  vCdEmpresa := itemXmlF('CD_EMPRESA', pParams);

  vDataInicial := itemXml('DT_DATA_INICIAL', pParams);
  vDataFinal := itemXml('DT_DATA_FINAL', pParams);

  if (vSabadoUtil  = '') then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'É necessário informar o parâmetro empresa IN_SABADO_UTIL !', cDS_METHOD);
    return(-1); exit;
  end;
  if (vCdEmpresa = '') then begin
    vCdEmpresa := itemXmlF('CD_EMPRESA', PARAM_GLB);
  end;
  if (vDataInicial = '') then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'É necessário informar a data inicial !', cDS_METHOD);
    return(-1); exit;
  end;
  if (vDataFinal   = '') then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'É necessário informar a data final !', cDS_METHOD);
    return(-1); exit;
  end;

  vInFeriado := '';
  DsDiaUtil := '';
  vQtDiasUteis := 0;
  vDtData := vDataInicial;

  while(vDtData <= vDataFinal) do begin

    putitemXml(viParams, 'DT_DATA', vDtData);
    putitemXml(viParams, 'CD_EMPRESA', vCdEmpresa);

    voParams := VerificaFeriado(viParams); (* PARAM_GLB, viParams, voParams, xCdErro, xCtxErro *)
    if (xStatus < 0) then begin
      Result := voParams;
      return(-1); exit;
    end;
    if (voParams <> '') then begin
      vInFeriado := itemXmlB('IN_FERIADO', voParams);
    end else begin
      Result := SetStatus(STS_ERROR, 'GEN0001', 'Validação do feriado não concluída!', cDS_METHOD);
      return(-1); exit;
    end;
    if (vInFeriado = '') then begin
      Result := SetStatus(STS_ERROR, 'GEN0001', 'Validação do feriado não concluída!', cDS_METHOD);
      return(-1); exit;
    end;

    vDiaSemana := vDtData[A];

    if (vInFeriado = 'S') then begin
      DsDiaUtil := 'NAO';
    end else begin

      if (vDiaSemana = 7) then begin
        DsDiaUtil := 'NAO';
      end else begin

        if (vDiaSemana = 6) then begin
          if (vSabadoUtil = 1) then begin
            DsDiaUtil := 'SIM';
          end else begin

            DsDiaUtil := 'NAO';
          end;
        end else begin

          DsDiaUtil := 'SIM';
        end;
      end;
    end;
    if (DsDiaUtil = 'SIM') then begin
      vQtDiasUteis := vQtDiasUteis + 1;
      DsDiaUtil := '';
    end;

    vDtData := vDtData + 1;

  end;

  Result := 'QT_DIAUTIL=' + vQtDiasUteis' + ';

  return(0); exit;

end;

end.
