unit cFGRSVCO002;

interface

        

uses
  Classes, SysUtils, Math, DB,
  cServiceUnf, cDataSetUnf;

type
  T_FGRSVCO002 = class(TcServiceUnf)
  private

    function getParam(pParams : String = '') : String;
    function setEntidade(pParams : String = '') : String;
  protected
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;    
  published
    function validaBandaCheque(pParams : String = '') : String;
  end;

implementation

uses
  cADMSVCO001,
  cActivate, cStatus, cFuncao, cXml, dModulo;

var


//---------------------------------------------------------------
constructor T_FGRSVCO002.Create(AOwner: TComponent);
//---------------------------------------------------------------
begin
  inherited Create(AOwner);
  setEntidade('');
end;

//--------------------------------
destructor T_FGRSVCO002.Destroy;
//--------------------------------
begin
  inherited Destroy;
end;

//---------------------------------------------------------------
function T_FGRSVCO002.getParam(pParams : String = '') : String;
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
function T_FGRSVCO002.setEntidade(pParams : String = '') : String;
//---------------------------------------------------------------
begin

end;

//-----------------------------------------------------------------
function T_FGRSVCO002.validaBandaCheque(pParams : String) : String;
//-----------------------------------------------------------------
const
  cDS_METHOD = 'ADICONAL=Operação: T_FGRSVCO002.validaBandaCheque()';
var
  vPeso,vBanda,vDsBanda, vNrBanda : String;
  vIndice,voParams : Real;
  vBanco, vAgencia, vConta, vCheque : Real;
  vInValidaCadastro : Boolean;
begin
  vNrBanda := itemXmlF('NR_BANDA', pParams);
  vInValidaCadastro := itemXmlB('IN_VALIDACADASTRO', pParams);

  if (vNrBanda <> '' ) or (vInValidaCadastro = True) then begin
    voParams := achaNumero(viParams); (* vNrBanda, vDsBanda *)
    if (xStatus < 0) then begin
      return(-1); exit;
    end;

    voParams := glength(vDsBanda);
    if (voParams <> 30) then begin
      Result := SetStatus(STS_ERROR, 'GEN0001', 'A banda informada (' + vDsBanda) + ' possui tamanho inválido (' + voParams) + '!', cDS_METHOD);
      Result := '';
      putitemXml(Result, 'NR_BANDA', vDsBanda);
      return(-1); exit;
    end;

    vBanda := vDsBanda [1:7];
    vIndice := 1;
    vPeso := '2121212';
    voParams := 0;
    while (vIndice < 8) do begin
      voParams := voParams + (vBanda[vIndice:1] * vPeso[vIndice:1]);
      if (vBanda[vIndice:1] > 4)  and (vPeso[vIndice:1] = 2) then begin
        voParams := voParams + 1;
      end;
      vIndice := vIndice + 1;
    end;
    voParams := voParams % 10;
    if (voParams > 0) then begin
      voParams := 10 - voParams;
    end;
    if (voParams <> vDsBanda[19:1]) then begin
      Result := SetStatus(STS_ERROR, 'GEN0001', 'A banda informada (' + vDsBanda) + ' não é válida!', cDS_METHOD);
      return(-1); exit;
    end;

    vBanda := vDsBanda [9:10];
    vIndice := 1;
    vPeso := '1212121212';
    voParams := 0;
    while (vIndice < 11) do begin
      voParams := voParams + (vBanda[vIndice:1] * vPeso[vIndice:1]);
      if (vBanda[vIndice:1] > 4)  and (vPeso[vIndice:1] = 2) then begin
        voParams := voParams + 1;
      end;
      vIndice := vIndice + 1;
    end;
    voParams := voParams % 10;
    if (voParams > 0) then begin
      voParams := 10 - voParams;
    end;
    if (voParams <> vDsBanda[8:1]) then begin
      Result := SetStatus(STS_ERROR, 'GEN0001', 'A banda informada (' + vDsBanda) + ' não é válida!', cDS_METHOD);
      return(-1); exit;
    end;

    vBanda := vDsBanda [20:10];
    vIndice := 1;
    vPeso := '1212121212';
    voParams := 0;
    while (vIndice < 11) do begin
      voParams := voParams + (vBanda[vIndice:1] * vPeso[vIndice:1]);
      if (vBanda[vIndice:1] > 4)  and (vPeso[vIndice:1] = 2) then begin
        voParams := voParams + 1;
      end;
      vIndice := vIndice + 1;
    end;
    voParams := voParams % 10;
    if (voParams > 0) then begin
      voParams := 10 - voParams;
    end;
    if (voParams <> vDsBanda[30:1]) then begin
      Result := SetStatus(STS_ERROR, 'GEN0001', 'A banda informada (' + vDsBanda) + ' não é válida!', cDS_METHOD);
      return(-1); exit;
    end;
  end;

  vBanco := vDsBanda [1:3];
  vAgencia := vDsBanda [4:4];
  if (vBanco = 341) then begin
    vConta := vDsBanda [24:6];
  end else begin
    vConta := vDsBanda [20:10];
  end;
  vCheque := vDsBanda [12:6];

  Result := '';
  putitemXml(Result, 'NR_BANDA', vDsBanda);
  putitemXml(Result, 'NR_BANCO', vBanco);
  putitemXml(Result, 'NR_AGENCIA', vAgencia);
  putitemXml(Result, 'NR_CONTA', vConta);
  putitemXml(Result, 'NR_CHEQUE', vCheque);

  return(0); exit;
end;

end.
