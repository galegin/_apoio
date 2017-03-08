unit cECFSVCO012;

interface

(* COMPONENTES 
  ADMSVCO001 / PESSVCO005 / TRASVCO012 / 
*)        

uses
  Classes, SysUtils, DB,
  cServiceUnf, cDataSetUnf;

type
  T_ECFSVCO012 = class(TcServiceUnf)
  private
    tCTC_TRACARTA,
    tPES_PESSOA,
    tPES_TELEFONE,
    tPES_VENDEDOR,
    tPES_VENDINFO,
    tTRA_REMDES,
    tTRA_TRANSACAO,
    tV_PES_ENDEREC : TcDatasetUnf;
    function getParam(pParams : String = '') : String;
    function setEntidade(pParams : String = '') : String;
    function montaLinhaInicio(piLinhaOrigem : String; var poLinhaDestino : String) : String;
    function achaNumero(piNumero : String; var poNumero : Real) : String;
    function montaLinhaColuna(piLinhaOrigem : String; var poLinhaDestino : String; piQtCopia : Real) : String;
    function preencheZero(piNumero : Real; piTamanho : Real; var poNumero : String) : String;
    function montaCampo(piCodigo : Real; piTamanho : Real; piControle : String; var poCampo : String) : String;
    function alinhaDireita(piNumero : String; piTamanho : Real; var poNumero : String) : String;
  protected
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;    
  published
    function geraObsECF(pParams : String = '') : String;
  end;

implementation

uses
  cActivate, cStatus, cFuncao, cXml, dModulo;

var
  gDsObsLinha1,
  gDsObsLinha2,
  gDsObsLinha3,
  gDsObsLinha4,
  gDsObsLinha5,
  gDsObsLinha6,
  gDsObsLinha7,
  gDsObsLinha8,
  gDtTransacao,
  gInGravaClienteEcf,
  gNrCNPJ,
  gNrCPF,
  gNrTransacao,
  gpr03D2,
  gSeqEndereco,
  gVlBonus,
  gVlDesconto : String;

//---------------------------------------------------------------
constructor T_ECFSVCO012.Create(AOwner: TComponent);
//---------------------------------------------------------------
begin
  inherited Create(AOwner);
  setEntidade('');
end;

//--------------------------------
destructor T_ECFSVCO012.Destroy;
//--------------------------------
begin
  inherited Destroy;
end;

//---------------------------------------------------------------
function T_ECFSVCO012.getParam(pParams : String) : String;
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
  xParam := activateCmp('ADMSVCO001', 'GetParametro', xParam);
  gUsaCondPgtoEspecial := itemXmlB('IN_USA_COND_PGTO_ESPECIAL', xParam);
  
  xParamEmp := '';
  putitem(xParamEmp, 'VL_MINIMO_PARCELA');
  xParamEmp := activateCmp('ADMSVCO001', 'GetParamEmpresa', piCdEmpresa, xParamEmp);
  gVlMinimoParcela := itemXmlF('VL_MINIMO_PARCELA', xParamEmp);  
  *)

  xParam := '';

  xParam := activateCmp('ADMSVCO001', 'GetParametro', xParam);


  xParamEmp := '';
  putitem(xParamEmp, 'IN_GRAVA_CLIENTE_ECF');
  putitem(xParamEmp, 'OBS_ECF_LINHA1');
  putitem(xParamEmp, 'OBS_ECF_LINHA2');
  putitem(xParamEmp, 'OBS_ECF_LINHA3');
  putitem(xParamEmp, 'OBS_ECF_LINHA4');
  putitem(xParamEmp, 'OBS_ECF_LINHA5');
  putitem(xParamEmp, 'OBS_ECF_LINHA6');
  putitem(xParamEmp, 'OBS_ECF_LINHA7');
  putitem(xParamEmp, 'OBS_ECF_LINHA8');

  xParamEmp := activateCmp('ADMSVCO001', 'GetParamEmpresa', piCdEmpresa, xParamEmp);

  gDsObsLinha1 := itemXml('OBS_ECF_LINHA1', xParamEmp);
  gDsObsLinha2 := itemXml('OBS_ECF_LINHA2', xParamEmp);
  gDsObsLinha3 := itemXml('OBS_ECF_LINHA3', xParamEmp);
  gDsObsLinha4 := itemXml('OBS_ECF_LINHA4', xParamEmp);
  gDsObsLinha5 := itemXml('OBS_ECF_LINHA5', xParamEmp);
  gDsObsLinha6 := itemXml('OBS_ECF_LINHA6', xParamEmp);
  gDsObsLinha7 := itemXml('OBS_ECF_LINHA7', xParamEmp);
  gDsObsLinha8 := itemXml('OBS_ECF_LINHA8', xParamEmp);

end;

//---------------------------------------------------------------
function T_ECFSVCO012.setEntidade(pParams : String) : String;
//---------------------------------------------------------------
begin
  tCTC_TRACARTA := GetEntidade('CTC_TRACARTA');
  tPES_PESSOA := GetEntidade('PES_PESSOA');
  tPES_TELEFONE := GetEntidade('PES_TELEFONE');
  tPES_VENDEDOR := GetEntidade('PES_VENDEDOR');
  tPES_VENDINFO := GetEntidade('PES_VENDINFO');
  tTRA_REMDES := GetEntidade('TRA_REMDES');
  tTRA_TRANSACAO := GetEntidade('TRA_TRANSACAO');
  tV_PES_ENDEREC := GetEntidade('V_PES_ENDEREC');
end;

//---------------------------------------------------------------------------------------------------
function T_ECFSVCO012.montaLinhaInicio(piLinhaOrigem : String; var poLinhaDestino : String) : String;
//---------------------------------------------------------------------------------------------------
const
  cDS_METHOD = 'ADICIONAL=Operação: T_ECFSVCO012.montaLinhaInicio()';
var
  vNrCodigoASCII : Real;
  vDsNumero : String;
begin
        CD_COMPVEND := 0;

  poLinhaDestino := '';
  ulength(piLinhaOrigem);
  while (xResult > 0) do begin
    scan(piLinhaOrigem, '{*}');
    if (xResult > 0) then begin
      poLinhaDestino := poLinhaDestino + SubStr(piLinhaOrigem, 1, xResult - 1);
      piLinhaOrigem := SubStr(piLinhaOrigem, xResult + 1);
      scan(piLinhaOrigem, '}');
      if (xResult > 0) then begin
        vDsNumero := SubStr(piLinhaOrigem, 1, xResult - 1);
        piLinhaOrigem := SubStr(piLinhaOrigem, xResult + 1);
        achaNumero(vDsNumero, vNrCodigoASCII);
        if (xProcerror) then begin
          Result := SetStatus(STS_ERROR, xProcerror, xProcerrorcontext, cDS_METHOD);
        end;
        if (xStatus < 0) then begin
          return(-1); exit;
        end;
        vDsNumero := tometa(vNrCodigoASCII);
        poLinhaDestino := poLinhaDestino' + vDsNumero;
      end;
    end else begin
      poLinhaDestino := poLinhaDestino' + piLinhaOrigem;
      piLinhaOrigem := '';
    end;

    ulength(piLinhaOrigem);
  end;

  return(0); exit;
end;

//--------------------------------------------------------------------------------
function T_ECFSVCO012.achaNumero(piNumero : String; var poNumero : Real) : String;
//--------------------------------------------------------------------------------
const
  cDS_METHOD = 'ADICIONAL=Operação: T_ECFSVCO012.achaNumero()';
begin
  length(piNumero);
  while (xResult > 0) do begin
    if (SubStr(piNumero, 1, 1) >= 0) and (SubStr(piNumero, 1, 1) <= 9) and (SubStr(piNumero, 1, 1) <> ' ') then begin
      poNumero := poNumero + SubStr(piNumero, 1, 1);
    end;
    piNumero := SubStr(piNumero, 2);
    length(piNumero);
  end;

  return(0); exit;
end;

//---------------------------------------------------------------------------------------------------------------------
function T_ECFSVCO012.montaLinhaColuna(piLinhaOrigem : String; var poLinhaDestino : String; piQtCopia : Real) : String;
//---------------------------------------------------------------------------------------------------------------------
const
  cDS_METHOD = 'ADICIONAL=Operação: T_ECFSVCO012.montaLinhaColuna()';
var
  vCdCampo, vNrTamanhoCampo, vNrCodigoASCII : Real;
  vDsControleCampo, vDsCampo, vDsConteudo, vDsNumero : String;
begin
  ulength(piLinhaOrigem);
  while (xResult > 0) do begin
    scan(piLinhaOrigem, '@');
    if (xResult > 0) then begin
      vCdCampo := 0;
      vNrTamanhoCampo := 0;
      poLinhaDestino := poLinhaDestino + SubStr(piLinhaOrigem, 1, xResult - 1);
      piLinhaOrigem := SubStr(piLinhaOrigem, xResult + 1);
      scan(piLinhaOrigem, '@');
      if (xResult > 0) then begin
        vDsConteudo := SubStr(piLinhaOrigem, 1, xResult - 1);
        piLinhaOrigem := SubStr(piLinhaOrigem, xResult + 1);
        scan(vDsConteudo, '#');
        if (xResult > 0) then begin
          vCdCampo := SubStr(vDsConteudo, 1, xResult - 1);
          vDsConteudo := SubStr(vDsConteudo, xResult + 1);
          scan(vDsConteudo, '#');
          if (xResult > 0) then begin
            vNrTamanhoCampo := SubStr(vDsConteudo, 1, xResult - 1);
            vDsConteudo := SubStr(vDsConteudo, xResult + 1);
            vDsControleCampo := vDsConteudo;
          end else begin
            vNrTamanhoCampo := vDsConteudo;
          end;
        end;
      end;
      if (vCdCampo > 0) then begin
        vDsCampo := '';
        case round(vCdCampo) of
          end;
          1 : begin
            if (vNrTamanhoCampo = 0) then begin
              vDsCampo := piQtCopia;
            end else begin
              preencheZero(piQtCopia, vNrTamanhoCampo, vDsCampo);
              if (xProcerror) then begin
                Result := SetStatus(STS_ERROR, xProcerror, xProcerrorcontext, cDS_METHOD);
              end;
              if (xStatus < 0) then begin
                return(-1); exit;
              end;
            end;
          else
            montaCampo(vCdCampo, vNrTamanhoCampo, vDsControleCampo, vDsCampo);
            if (xProcerror) then begin
              Result := SetStatus(STS_ERROR, xProcerror, xProcerrorcontext, cDS_METHOD);
            end;
            if (xStatus < 0) then begin
              return(-1); exit;
            end;
        end;
        poLinhaDestino := poLinhaDestino' + vDsCampo;
        poLinhaDestino := SubStr(poLinhaDestino, 1, 40);
      end;
    end else begin
      poLinhaDestino := poLinhaDestino' + piLinhaOrigem;
      poLinhaDestino := SubStr(poLinhaDestino, 1, 40);
      piLinhaOrigem := '';
    end;

    ulength(piLinhaOrigem);
  end;

  return(0); exit;
end;

//----------------------------------------------------------------------------------------------------
function T_ECFSVCO012.preencheZero(piNumero : Real; piTamanho : Real; var poNumero : String) : String;
//----------------------------------------------------------------------------------------------------
const
  cDS_METHOD = 'ADICIONAL=Operação: T_ECFSVCO012.preencheZero()';
begin
  poNumero := piNumero;
  ulength(poNumero);
  while (xResult < piTamanho) do begin
    poNumero := '0' + poNumero;
    ulength(poNumero);
  end;
  if (xResult > piTamanho) then begin
    poNumero := SubStr(poNumero, xResult - piTamanho + 1);
  end;

  return 0;
end;

//----------------------------------------------------------------------------------------------------------------------
function T_ECFSVCO012.montaCampo(piCodigo : Real; piTamanho : Real; piControle : String; var poCampo : String) : String;
//----------------------------------------------------------------------------------------------------------------------
const
  cDS_METHOD = 'ADICIONAL=Operação: T_ECFSVCO012.montaCampo()';
var
  vDsLstUsu, vDsLstNF : String;
  viParams,voParams : String;
  vNrEndereco : Real;
begin
  poCampo := '';

  case round(piCodigo) of
    end;
    10 : begin
      poCampo := item_a('CD_PESSOA', tPES_PESSOA);
    end;
    11 : begin
      if (gInGravaClienteEcf = uTRUE) then begin
        poCampo := item_a('NM_PESSOA', tPES_PESSOA);
      end else begin
        poCampo := item_a('NM_NOME', tTRA_REMDES);
      end;
    end;
    15 : begin

      if (gInGravaClienteEcf = uTRUE) then begin
        if (item_f('TP_PESSOA', tPES_PESSOA) = 'F') then begin
          gNrCPF := item_f('NR_CPFCNPJ', tPES_PESSOA);
          poCampo := FloatToStr(gNrCPF);
        end else begin
          gNrCNPJ := item_f('NR_CPFCNPJ', tPES_PESSOA);
          poCampo := FloatToStr(gNrCNPJ);
        end;
      end else begin
        if (item_f('TP_PESSOA', tPES_PESSOA) = 'F') then begin
          gNrCPF := item_f('NR_CPFCNPJ', tTRA_REMDES);
          poCampo := FloatToStr(gNrCPF);
        end else begin
          gNrCNPJ := item_f('NR_CPFCNPJ', tTRA_REMDES);
          poCampo := FloatToStr(gNrCNPJ);
        end;
      end;
    end;
    16 : begin
      poCampo := item_a('DS_SIGLALOGRAD', tV_PES_ENDEREC) + ' ' + item_a('NM_LOGRADOURO', tV_PES_ENDEREC) + ' ' + item_a('NR_LOGRADOURO', tV_PES_ENDEREC);
    end;
    17 : begin
      poCampo := item_a('DS_BAIRRO', tV_PES_ENDEREC);
    end;
    19 : begin
      poCampo := item_a('NM_MUNICIPIO', tV_PES_ENDEREC);
    end;
    20 : begin
      poCampo := item_a('NR_TELEFONE', tPES_TELEFONE);
    end;
    21 : begin
      poCampo := item_a('DS_SIGLAESTADO', tV_PES_ENDEREC);
    end;
    38 : begin
      poCampo := item_a('VL_ICMS', tTRA_TRANSACAO);
    end;
    84 : begin
      poCampo := FloatToStr(gNrTransacao);
    end;
    65 : begin
      poCampo := item_a('CD_VENDEDOR', tPES_VENDEDOR);
    end;
    98 : begin
      if (item_f('VL_DESCONTO', tTRA_TRANSACAO) <> 0) then begin
        gVlBonus := '';
        if not (empty(tCTC_TRACARTA)) then begin
          setocc(tCTC_TRACARTA, 1);
          while (xStatus >= 0) do begin
            gVlBonus := gVlBonus + item_f('VL_BONUSUTIL', tCTC_TRACARTA);
            setocc(tCTC_TRACARTA, curocc(tCTC_TRACARTA) + 1);
          end;
        end;
        gVlDesconto := item_f('VL_DESCONTO', tTRA_TRANSACAO) - gVlBonus;
        poCampo := FloatToStr(gVlDesconto);
      end else begin
        poCampo := '';
      end;
    end;
    101 : begin
      poCampo := item_a('NM_VENDEDOR', tPES_VENDEDOR);

    end;
    249 : begin
      poCampo := item_a('CD_AUXILIAR', tPES_VENDINFO);

    end;
    466 : begin
      putitemXml(viParams, 'CD_EMPRESA', item_f('CD_EMPRESA', tTRA_TRANSACAO));
      putitemXml(viParams, 'NR_TRANSACAO', item_f('NR_TRANSACAO', tTRA_TRANSACAO));
      putitemXml(viParams, 'DT_TRANSACAO', item_a('DT_TRANSACAO', tTRA_TRANSACAO));
      voParams := activateCmp('TRASVCO012', 'buscaDadosSimulador', viParams);
      if (xProcerror) then begin
        Result := SetStatus(STS_ERROR, xProcerror, xProcerrorcontext, cDS_METHOD);
        return(-1); exit;
      end else if (xStatus < 0)
        Result := SetStatus(STS_ERROR, xCdErro, xCtxErro, cDS_METHOD);
        return(-1); exit;
      end;

      gpr03D2 := itemXmlF('PR_VARIACAO', voParams);
      if (gpr03D2 <> '') then begin
        alinhaDireita('' + gpr + '03D2', piTamanho, poCampo);
        if (xProcerror) then begin
          Result := SetStatus(STS_ERROR, xProcerror, xProcerrorcontext, cDS_METHOD);
        end;
        poCampo := poCampo;
      end else begin
        gpr03D2 := '';
        poCampo := '';
      end;
    end;
    467 : begin
      putitemXml(viParams, 'CD_EMPRESA', item_f('CD_EMPRESA', tTRA_TRANSACAO));
      putitemXml(viParams, 'NR_TRANSACAO', item_f('NR_TRANSACAO', tTRA_TRANSACAO));
      putitemXml(viParams, 'DT_TRANSACAO', item_a('DT_TRANSACAO', tTRA_TRANSACAO));
      voParams := activateCmp('TRASVCO012', 'buscaDadosSimulador', viParams);
      if (xProcerror) then begin
        Result := SetStatus(STS_ERROR, xProcerror, xProcerrorcontext, cDS_METHOD);
        return(-1); exit;
      end else if (xStatus < 0)
        Result := SetStatus(STS_ERROR, xCdErro, xCtxErro, cDS_METHOD);
        return(-1); exit;
      end;
      poCampo := itemXml('DS_RESUMIDA', voParams)SubStr(, 1, piTamanho);

    end;
    631 : begin
      gVlBonus := '';
      if not (empty(tCTC_TRACARTA)) then begin
        setocc(tCTC_TRACARTA, 1);
        while (xStatus >= 0) do begin
          gVlBonus := gVlBonus + item_f('VL_BONUSUTIL', tCTC_TRACARTA);
          setocc(tCTC_TRACARTA, curocc(tCTC_TRACARTA) + 1);
        end;
      end;
      poCampo := FloatToStr(gVlBonus);
    else
      poCampo := '';
  end;

  return(0); exit;
end;

//-------------------------------------------------------------------------------------------------------
function T_ECFSVCO012.alinhaDireita(piNumero : String; piTamanho : Real; var poNumero : String) : String;
//-------------------------------------------------------------------------------------------------------
const
  cDS_METHOD = 'ADICIONAL=Operação: T_ECFSVCO012.alinhaDireita()';
var
  vIndice : Real;
begin
  vIndice := 1;
  ulength(piNumero);
  while (vIndice <= piTamanho - xResult) do begin
    poNumero := poNumero + ' ';
    vIndice := vIndice + 1;
  end;
  if (piTamanho < xResult) then begin
    poNumero := poNumero + SubStr(piNumero, xResult - piTamanho + 1);
  end else begin
    poNumero := poNumero' + piNumero;
  end;

  return 0;
end;

getParam
const
  cDS_METHOD = 'ADICIONAL=Operação: T_ECFSVCO012.getParam(pParams); (* )';
var
  vCdEmpresa : Real;
  viParams, voParams : String;
begin
  vCdEmpresa := itemXmlF('CD_EMPRESA', PARAM_GLB);
  viParams := '';
  putitem(viParams,  'OBS_ECF_LINHA1');
  putitem(viParams,  'OBS_ECF_LINHA2');
  putitem(viParams,  'OBS_ECF_LINHA3');
  putitem(viParams,  'OBS_ECF_LINHA4');
  putitem(viParams,  'OBS_ECF_LINHA5');
  putitem(viParams,  'OBS_ECF_LINHA6');
  putitem(viParams,  'OBS_ECF_LINHA7');
  putitem(viParams,  'OBS_ECF_LINHA8');
  putitem(viParams,  'IN_GRAVA_CLIENTE_ECF');
  xParamEmp := activateCmp('ADMSVCO001', 'GetParamEmpresa', piCdEmpresa, xParamEmp); (*vCdEmpresa *)
  if (xProcerror) then begin
    Result := SetStatus(STS_ERROR, xProcerror, xProcerrorcontext, cDS_METHOD);
    return(-1); exit;
  end else if (xCdErro)
    Result := SetStatus(STS_ERROR, 'GEN0001', '' + itemXml(DESCRICAO, + ' xCtxErro)', cDS_METHOD);
    return(-1); exit;
  end else if (xStatus < 0)
    return(-1); exit;
  end;
  gDsObsLinha1 := itemXml('OBS_ECF_LINHA1', voParams);
  gDsObsLinha2 := itemXml('OBS_ECF_LINHA2', voParams);
  gDsObsLinha3 := itemXml('OBS_ECF_LINHA3', voParams);
  gDsObsLinha4 := itemXml('OBS_ECF_LINHA4', voParams);
  gDsObsLinha5 := itemXml('OBS_ECF_LINHA5', voParams);
  gDsObsLinha6 := itemXml('OBS_ECF_LINHA6', voParams);
  gDsObsLinha7 := itemXml('OBS_ECF_LINHA7', voParams);
  gDsObsLinha8 := itemXml('OBS_ECF_LINHA8', voParams);
  if (itemXml('IN_GRAVA_CLIENTE_ECF', xParamEmp) <> 1) then begin
    gInGravaClienteEcf := uFALSE;
  end else begin
    gInGravaClienteEcf := uTRUE;
  end;

  return(0); exit;
end;

  INIT
const
  cDS_METHOD = 'ADICIONAL=Operação: T_ECFSVCO012.INIT()';
begin
end;

  CLEANUP
const
  cDS_METHOD = 'ADICIONAL=Operação: T_ECFSVCO012.CLEANUP()';
begin
end;

//----------------------------------------------------------
function T_ECFSVCO012.geraObsECF(pParams : String) : String;
//----------------------------------------------------------
const
  cDS_METHOD = 'ADICIONAL=Operação: T_ECFSVCO012.geraObsECF()';
var
  vDsLinhaDestino, vDsLinha : String;
  vQtCopia, vCdCliente, vCdVendedor, vCdEmpresa : Real;
begin
  vCdCliente := itemXmlF('CD_CLIENTE', pParams);
  if (vCdCliente = 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Cliente não encontrado!', cDS_METHOD);
    return(-1); exit;
  end;

  vCdVendedor := itemXmlF('CD_COMPVEND', pParams);
  vCdEmpresa := itemXmlF('CD_EMPRESA', pParams);
  gNrTransacao := itemXmlF('NR_TRANSACAO', pParams);
  gDtTransacao := itemXml('DT_TRANSACAO', pParams);

  getParam(pParams); (* *)
  if (xProcerror) then begin
    Result := SetStatus(STS_ERROR, xProcerror, xProcerrorcontext, cDS_METHOD);
    return(-1); exit;
  end;
  if (xStatus < 0) then begin
    return(-1); exit;
  end;
  if ((gDsObsLinha1 = '') and (gDsObsLinha2 = '') and (gDsObsLinha3 = '') and (gDsObsLinha4 = '') and (gDsObsLinha5 = '') and (gDsObsLinha6 = '') and (gDsObsLinha7 = '') and (gDsObsLinha8 = '')) then begin
    return(0); exit;
  end;
  if (gDsObsLinha1 = '') then begin
    gDsObsLinha1 := gDsObsLinha + '1';
  end;
  if (gDsObsLinha2 = '') then begin
    gDsObsLinha2 := gDsObsLinha + '2';
  end;
  if (gDsObsLinha3 = '') then begin
    gDsObsLinha3 := gDsObsLinha + '3';
  end;
  if (gDsObsLinha4 = '') then begin
    gDsObsLinha4 := gDsObsLinha + '4';
  end;
  if (gDsObsLinha5 = '') then begin
    gDsObsLinha5 := gDsObsLinha + '5';
  end;
  if (gDsObsLinha6 = '') then begin
    gDsObsLinha6 := gDsObsLinha + '6';
  end;
  if (gDsObsLinha7 = '') then begin
    gDsObsLinha7 := gDsObsLinha + '7';
  end;
  if (gDsObsLinha8 = '') then begin
    gDsObsLinha8 := gDsObsLinha + '8';
  end;

  clear_e(tPES_PESSOA);
  putitem_e(tPES_PESSOA, 'CD_PESSOA', vCdCliente);
  retrieve_e(tPES_PESSOA);
  if (xStatus < 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Cliente não encontrado!', cDS_METHOD);
    return(-1); exit;
  end;

  clear_e(tPES_VENDEDOR);
  putitem_o(tPES_VENDEDOR, 'CD_VENDEDOR', vCdVendedor);
  retrieve_e(tPES_VENDEDOR);
  if (xStatus < 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Vendedor não encontrado!', cDS_METHOD);
    return(-1); exit;
  end;

  clear_e(tPES_VENDINFO);
  putitem_o(tPES_VENDINFO, 'CD_EMPRESA', vCdEmpresa);
  putitem_o(tPES_VENDINFO, 'CD_VENDEDOR', vCdVendedor);
  retrieve_e(tPES_VENDINFO);
  if (xStatus < 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Vendedor auxiliar não encontrado!', cDS_METHOD);
    return(-1); exit;
  end;

  putitemXml(pParams, 'CD_PESSOA', item_f('CD_PESSOA', tPES_PESSOA));
  putitemXml(pParams, 'IN_VENDA_ECF', uTRUE);
  voParams := activateCmp('PESSVCO005', 'buscaEnderecoFaturamento', viParams); (*v,pParams,Result *)
  if (xProcerror) then begin
    Result := SetStatus(STS_ERROR, xProcerror, xProcerrorcontext, cDS_METHOD);
    return(-1); exit;
  end else if (xStatus < 0)
    Result := SetStatus(STS_ERROR, xCdErro, xCtxErro, cDS_METHOD);
    return(-1); exit;
  end;
  gSeqEndereco := itemXmlF('NR_SEQENDERECO', Result);

  clear_e(tV_PES_ENDEREC);
  putitem_e(tV_PES_ENDEREC, 'CD_PESSOA', item_f('CD_PESSOA', tPES_PESSOA));
  putitem_e(tV_PES_ENDEREC, 'NR_SEQUENCIA', gSeqEndereco);
  retrieve_e(tV_PES_ENDEREC);

  clear_e(tPES_TELEFONE);
  putitem_e(tPES_TELEFONE, 'CD_PESSOA', vCdCliente);
  retrieve_e(tPES_TELEFONE);

  if (vCdEmpresa <> 0) and (gNrTransacao <> 0) and (gDtTransacao <> '') then begin
    clear_e(tTRA_TRANSACAO);
    putitem_o(tTRA_TRANSACAO, 'CD_EMPRESA', vCdEmpresa);
    putitem_o(tTRA_TRANSACAO, 'NR_TRANSACAO', gNrTransacao);
    putitem_o(tTRA_TRANSACAO, 'DT_TRANSACAO', gDtTransacao);
    retrieve_e(tTRA_TRANSACAO);
    if (xStatus < 0) then begin
      Result := SetStatus(STS_ERROR, 'GEN0001', 'Transação ' + FloatToStr(vCdEmpresa) + ' / ' + FloatToStr(gNrTransacao) + ' / ' + gDtTransacao + ' inválida!', cDS_METHOD);
      return(-1); exit;
    end;
  end;

  montaLinhaColuna(gDsObsLinha1, vDsLinhaDestino, vQtCopia);
  if (xProcerror) then begin
    Result := SetStatus(STS_ERROR, xProcerror, xProcerrorcontext, cDS_METHOD);
  end;
  if (xStatus < 0) then begin
    return(-1); exit;
  end;
  vDsLinha := vDsLinhaDestino;

  montaLinhaColuna(gDsObsLinha2, vDsLinhaDestino, vQtCopia);
  if (xProcerror) then begin
    Result := SetStatus(STS_ERROR, xProcerror, xProcerrorcontext, cDS_METHOD);
  end;
  if (xStatus < 0) then begin
    return(-1); exit;
  end;
  vDsLinha := vDsLinha' + vDsLinhaDestino;

  montaLinhaColuna(gDsObsLinha3, vDsLinhaDestino, vQtCopia);
  if (xProcerror) then begin
    Result := SetStatus(STS_ERROR, xProcerror, xProcerrorcontext, cDS_METHOD);
  end;
  if (xStatus < 0) then begin
    return(-1); exit;
  end;
  vDsLinha := vDsLinha' + vDsLinhaDestino;

  montaLinhaColuna(gDsObsLinha4, vDsLinhaDestino, vQtCopia);
  if (xProcerror) then begin
    Result := SetStatus(STS_ERROR, xProcerror, xProcerrorcontext, cDS_METHOD);
  end;
  if (xStatus < 0) then begin
    return(-1); exit;
  end;
  vDsLinha := vDsLinha' + vDsLinhaDestino;

  montaLinhaColuna(gDsObsLinha5, vDsLinhaDestino, vQtCopia);
  if (xProcerror) then begin
    Result := SetStatus(STS_ERROR, xProcerror, xProcerrorcontext, cDS_METHOD);
  end;
  if (xStatus < 0) then begin
    return(-1); exit;
  end;
  vDsLinha := vDsLinha' + vDsLinhaDestino;

  montaLinhaColuna(gDsObsLinha6, vDsLinhaDestino, vQtCopia);
  if (xProcerror) then begin
    Result := SetStatus(STS_ERROR, xProcerror, xProcerrorcontext, cDS_METHOD);
  end;
  if (xStatus < 0) then begin
    return(-1); exit;
  end;
  vDsLinha := vDsLinha' + vDsLinhaDestino;

  montaLinhaColuna(gDsObsLinha7, vDsLinhaDestino, vQtCopia);
  if (xProcerror) then begin
    Result := SetStatus(STS_ERROR, xProcerror, xProcerrorcontext, cDS_METHOD);
  end;
  if (xStatus < 0) then begin
    return(-1); exit;
  end;
  vDsLinha := '%%vDsLinha%%vDsLinhaDestino';

  call montaLinhaColuna($DsObsLinha8$, vDsLinhaDestino, vQtCopia);
  if (xProcerror) then begin
    instancehandle->SetStatus(STS_ERROR, xProcerror, xProcerrorcontext, '')
  end;
  if (xStatus < 0) then begin
    return(-1); exit;
  end;
  vDsLinha := '%%vDsLinha%%vDsLinhaDestino';

  putitemXml(Result, 'DS_MENSAGEM', vDsLinha);
  return(0); exit;
end;

end.
