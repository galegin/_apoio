unit fECFFP007;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, fFormTouch, ExtCtrls, cPanel, cDatasetUnf, fDialogTouch;

type
  TF_ECFFP007 = class(T_FormTouch)
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
  private
    tFIS_ECF,
    tFIS_ECFMOD,
    tFIS_ECFSB,
    tFIS_MARCAECF,
    tFIS_MODELOECF,
    tFIS_NF,
    tFIS_NFECF,
    tFIS_NFITEM,
    tFIS_NFITEMIMPOST,
    tFIS_NFREMDES,
    tFIS_REDZA,
    tFIS_REDZM,
    tGER_EMPRESA,
    tPES_ENDERECO,
    tPES_PESJURIDICA,
    tPES_PESSOA,
    tSIS_DUMMY,
    tSIS_TITBOTOES : TcDatasetUnf;
    function getParam(pParams : String = '') : String;
    function setEntidade(pParams : String = '') : String;
    function preEDIT(pParams : String = '') : String;
    function posEDIT(pParams : String = '') : String;
    function preEDIT(pParams : String = '') : String;
    function espacoDireita(pParams : String = '') : String;
    function preencheZero(pParams : String = '') : String;
    function mascaraData(pParams : String = '') : String;
    function convValorstring(pParams : String = '') : String;
    function formataCampoComDecimal(pParams : String = '') : String;
    function preencheZerosEsquerda(pParams : String = '') : String;
    function preencheZerosDireita(pParams : String = '') : String;
    function INIT(pParams : String = '') : String;
    function validaEmpresas(pParams : String = '') : String;
    function filtroNrECF(pParams : String = '') : String;
    function validaIntervaloData(pParams : String = '') : String;
    function consultarECFExportacao(pParams : String = '') : String;
    function selecionarRegistro(pParams : String = '') : String;
    function valorPadrao(pParams : String = '') : String;
    function gerarE00(pParams : String = '') : String;
    function gerarE01(pParams : String = '') : String;
    function gerarE02(pParams : String = '') : String;
    function gerarE12(pParams : String = '') : String;
    function gerarE13(pParams : String = '') : String;
    function gerarE14(pParams : String = '') : String;
    function gerarE15(pParams : String = '') : String;
    function gerarNotaFiscalPaulista(pParams : String = '') : String;
    function geraNomeArquivo(pParams : String = '') : String;
    function geraEAD(pParams : String = '') : String;
  protected
  public
  published
  end;

implementation

{$R *.dfm}

uses
  cADMSVCO001,
  cActivate, cStatus, cFuncao, cXml, dModulo;

var
  gnomeArquivo,
  gvDsConteudo,
  gvDsPath,
  gvHoraCadastro,
  gvHoraCadastroUsu,
  gvHoraGravacaoSoftBasico : String;

procedure TF_ECFFP007.FormCreate(Sender: TObject);
begin
  inherited; //
  setEntidade();
end;

procedure TF_ECFFP007.FormShow(Sender: TObject);
var voParams : String;
begin
  inherited; //

  getParam(vpiParams);

  voParams := preEDIT(vpiParams);
  if (xStatus < 0) then begin
    MensagemTouch(tpmErro, itemXml('message', voParams) + #13 + itemXml('adic', voParams));
    TimerSair.Enabled := True;
    return(-1); exit;
  end;

  //recalcula();

  return(0); exit;
end;

procedure TF_ECFFP007.FormActivate(Sender: TObject);
begin
  inherited; //
end;

procedure TF_ECFFP007.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  inherited; //
end;

//---------------------------------------------------------------
function TF_ECFFP007.getParam(pParams : String = '') : String;
//---------------------------------------------------------------
var
  piCdEmpresa : Real;
begin
  piCdEmpresa := itemXmlF('CD_EMPRESA', pParams);
  if (piCdEmpresa = 0) then begin
    piCdEmpresa := itemXmlF('CD_EMPRESA', PARAM_GLB);
  end;

  (* colocar o conteudo da operacao INIT aqui *)

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
end;

//---------------------------------------------------------------
function TF_ECFFP007.setEntidade(pParams : String = '') : String;
//---------------------------------------------------------------
begin
  tFIS_ECF := TcDatasetUnf.GetEntidade(Self, 'FIS_ECF');
  tFIS_ECFMOD := TcDatasetUnf.GetEntidade(Self, 'FIS_ECFMOD');
  tFIS_ECFSB := TcDatasetUnf.GetEntidade(Self, 'FIS_ECFSB');
  tFIS_MARCAECF := TcDatasetUnf.GetEntidade(Self, 'FIS_MARCAECF');
  tFIS_MODELOECF := TcDatasetUnf.GetEntidade(Self, 'FIS_MODELOECF');
  tFIS_NF := TcDatasetUnf.GetEntidade(Self, 'FIS_NF');
  tFIS_NFECF := TcDatasetUnf.GetEntidade(Self, 'FIS_NFECF');
  tFIS_NFITEM := TcDatasetUnf.GetEntidade(Self, 'FIS_NFITEM');
  tFIS_NFITEMIMPOST := TcDatasetUnf.GetEntidade(Self, 'FIS_NFITEMIMPOST');
  tFIS_NFREMDES := TcDatasetUnf.GetEntidade(Self, 'FIS_NFREMDES');
  tFIS_REDZA := TcDatasetUnf.GetEntidade(Self, 'FIS_REDZA');
  tFIS_REDZM := TcDatasetUnf.GetEntidade(Self, 'FIS_REDZM');
  tGER_EMPRESA := TcDatasetUnf.GetEntidade(Self, 'GER_EMPRESA');
  tPES_ENDERECO := TcDatasetUnf.GetEntidade(Self, 'PES_ENDERECO');
  tPES_PESJURIDICA := TcDatasetUnf.GetEntidade(Self, 'PES_PESJURIDICA');
  tPES_PESSOA := TcDatasetUnf.GetEntidade(Self, 'PES_PESSOA');
  tSIS_DUMMY := TcDatasetUnf.GetEntidade(Self, 'SIS_DUMMY');
  tSIS_TITBOTOES := TcDatasetUnf.GetEntidade(Self, 'SIS_TITBOTOES');
end;

//---------------------------------------------------------------
function TF_ECFFP007.preEDIT(pParams : String) : String;
//---------------------------------------------------------------
const
  cDS_METHOD = 'ADICIONAL=Operação: TF_ECFFP007.preEDIT()';
begin
  return(0); exit;
end;

//---------------------------------------------------------------
function TF_ECFFP007.posEDIT(pParams : String) : String;
//---------------------------------------------------------------
const
  cDS_METHOD = 'ADICIONAL=Operação: TF_ECFFP007.posEDIT()';
begin
  return(0); exit;
end;

//------------------------------------------------------
function TF_ECFFP007.preEDIT(pParams : String) : String;
//------------------------------------------------------
const
  cDS_METHOD = 'ADICIONAL=Operação: TF_ECFFP007.preEDIT()';
begin
  voParams := valorPadrao(viParams); (* *)
  if (xStatus < 0) then begin
    Result := voParams;
    return(-1); exit;
  end;

  return(0); exit;
end;

//------------------------------------------------------------
function TF_ECFFP007.espacoDireita(pParams : String) : String;
//------------------------------------------------------------
const
  cDS_METHOD = 'ADICIONAL=Operação: TF_ECFFP007.espacoDireita()';
var
  (* string vDsEntrada : IN / numeric vTam : IN / string vDsSaida : OUT *)
  vCont, vTamDsEntrada : Real;
begin
  length vDsEntrada;
  vTamDsEntrada := gresult;
  vCont := 0;
  repeat
    vCont := vCont + 1;
    if (vCont <= vTamDsEntrada) then begin
      vDsSaida := '' + vDsSaida' + vDsEntrada[vCont, + ' + ' vCont]';
    end else begin
      vDsSaida := '' + vDsSaida + ' ';
    end;
  until(vCont := vTam);
  return(0); exit;
end;

//-----------------------------------------------------------
function TF_ECFFP007.preencheZero(pParams : String) : String;
//-----------------------------------------------------------
const
  cDS_METHOD = 'ADICIONAL=Operação: TF_ECFFP007.preencheZero()';
begin
  poNumero := piNumero;
  length(poNumero);
  while (gresult < piTamanho) do begin
    poNumero := '0' + poNumero' + ';
    length(poNumero);
  end;
  if (gresult > piTamanho) then begin
    poNumero := poNumero[gresult - piTamanho + 1];
  end;

  return(0); exit;
end;

//----------------------------------------------------------
function TF_ECFFP007.mascaraData(pParams : String) : String;
//----------------------------------------------------------
const
  cDS_METHOD = 'ADICIONAL=Operação: TF_ECFFP007.mascaraData()';
var
  (* date piData : IN / string poData : IN *)
  vDataAuxiliar : String;
begin
  vDataAuxiliar := piData[Y];
  poData := '' + vDataAuxiliar' + ';
  vDataAuxiliar := piData[M];
  voParams := preencheZero(viParams); (* vDataAuxiliar, 2, vDataAuxiliar *)
  poData := '' + poData' + vDataAuxiliar' + ' + ';
  vDataAuxiliar := piData[D];
  voParams := preencheZero(viParams); (* vDataAuxiliar, 2, vDataAuxiliar *)
  poData := '' + poData' + vDataAuxiliar' + ' + ';

  return(0); exit;
end;

//--------------------------------------------------------------
function TF_ECFFP007.convValorstring(pParams : String) : String;
//--------------------------------------------------------------
const
  cDS_METHOD = 'ADICIONAL=Operação: TF_ECFFP007.convValorstring()';
var
  (* string piCampo :IN / numeric piQtPosicoes :IN / string poCampo :OUT *)
  vAux : String;
begin
  if (piQtPosicoes = 14) then begin
    vstringAux := piCampo[2:11];
    poCampo := vstringAux;
    vstringAux := ', ';
    poCampo := '' + poCampo' + vstringAux' + ' + ';
    vstringAux := piCampo[13:2];
    poCampo := '' + poCampo' + vstringAux' + ' + ';
  end else if (piQtPosicoes = 5) then begin
    vstringAux := piCampo[2:2];
    poCampo := vstringAux;
    vstringAux := '.';
    poCampo := '' + poCampo' + vstringAux' + ' + ';
    vstringAux := piCampo[4:2];
    poCampo := '' + poCampo' + vstringAux' + ' + ';
  end else if (piQtPosicoes = 3) then begin
    vstringAux := piCampo[2:10];
    poCampo := vstringAux;
    vstringAux := ', ';
    poCampo := '' + poCampo' + vstringAux' + ' + ';
    vstringAux := piCampo[12:3];
    poCampo := '' + poCampo' + vstringAux' + ' + ';
  end;

  return(0); exit;
end;

//---------------------------------------------------------------------
function TF_ECFFP007.formataCampoComDecimal(pParams : String) : String;
//---------------------------------------------------------------------
const
  cDS_METHOD = 'ADICIONAL=Operação: TF_ECFFP007.formataCampoComDecimal()';
var
  (* numeric piValorEntra : IN / numeric piTamInt : IN / numeric piTamDec :IN / string poValorSai :OUT *)
  vParteInt, vTamDec : Real;
  vMontado, vParteDec : String;
begin
  vParteInt := int(piValorEntra);
  vParteDec := piValorEntra [fraction];
  if (vParteDec <> '') then begin
    length vParteDec;
    vTamDec := gresult;
    vParteDec := vParteDec[3, vTamDec];
  end;
  voParams := preencheZerosEsquerda(viParams); (* vParteInt, piTamInt, vMontado *)
  poValorSai := vMontado;
  voParams := preencheZerosDireita(viParams); (* vParteDec, piTamDec, vMontado *)
  poValorSai := '' + poValorSai' + vMontado' + ' + ';

  return(0); exit;
end;

//--------------------------------------------------------------------
function TF_ECFFP007.preencheZerosEsquerda(pParams : String) : String;
//--------------------------------------------------------------------
const
  cDS_METHOD = 'ADICIONAL=Operação: TF_ECFFP007.preencheZerosEsquerda()';
var
  (* string piDadoEntra : IN / numeric piTamFinal : IN / string poDadoSai : OUT *)
  vTam : Real;
begin
  length piDadoEntra;
  vTam := gresult;
  if (vTam < piTamFinal) then begin
    poDadoSai := piDadoEntra;
    repeat
      poDadoSai := '0' + poDadoSai' + ';
      vTam := vTam + 1;
    until (vTam := piTamFinal);
  end else begin
    vTam := vTam - piTamFinal + 1;
    poDadoSai := piDadoEntra[vTam:piTamFinal];
  end;

  return(0); exit;
end;

//-------------------------------------------------------------------
function TF_ECFFP007.preencheZerosDireita(pParams : String) : String;
//-------------------------------------------------------------------
const
  cDS_METHOD = 'ADICIONAL=Operação: TF_ECFFP007.preencheZerosDireita()';
var
  (* string piDadoEntra : IN / numeric piTamFinal : IN / string poDadoSai : OUT *)
  vTam : Real;
  vZero : String;
begin
  length piDadoEntra;
  vTam := gresult;
  if (vTam < piTamFinal) then begin
    poDadoSai := piDadoEntra;
    vZero := '0';
    repeat
      poDadoSai := '' + poDadoSai' + vZero' + ' + ';
      vTam := vTam + 1;
    until (vTam := piTamFinal);
  end else begin
    poDadoSai := piDadoEntra[1:piTamFinal];
  end;

  return(0); exit;
end;

//---------------------------------------------------
function TF_ECFFP007.INIT(pParams : String) : String;
//---------------------------------------------------
const
  cDS_METHOD = 'ADICIONAL=Operação: TF_ECFFP007.INIT()';
begin
  _Caption := '' + ECFFP + '007 - Gera Arquivo Digital da Nota Fiscal/ECF Matricial';
end;

//-------------------------------------------------------------
function TF_ECFFP007.validaEmpresas(pParams : String) : String;
//-------------------------------------------------------------
const
  cDS_METHOD = 'ADICIONAL=Operação: TF_ECFFP007.validaEmpresas()';
var
  (* string piNmCampo : IN / boolean piMostramessage : IN *)
  viParams, voParams : String;
begin
  if (@piNmCampo = '') then begin
    message/info 'Informe a empresa.';
    gprompt := item_f('CD_EMPRESA', tSIS_DUMMY);
    return(-1); exit;
  end;

  clear_e(tGER_EMPRESA);
  putitem_o(tGER_EMPRESA, 'CD_EMPRESA', @piNmCampo);
  retrieve_e(tGER_EMPRESA);
  if (xStatus < 0) then begin
    Result := SetStatus(<STS_INFO>, 'GEN001', 'Empresa não existe.', cDS_METHOD);
    gprompt := item_f('CD_EMPRESA', tSIS_DUMMY);
    putitem_e(tSIS_DUMMY, 'NM_EMPRESA', '');
    return(-1); exit;
  end;

  viParams := '';
  putitemXml(viParams, 'CD_EMPRESA', @piNmCampo);
  putitemXml(viParams, 'IN_CCUSTO', False);
  putitemXml(viParams, 'CD_COMPONENTE', ECFFP007);
  voParams := activateCmp('SICSVCO004', 'validaEmpresa', viParams); (*,,,, *)
  if (xStatus < 0) then begin
    Result := voParams;
    return(-1); exit;
  end;
  end;
  @piNmCampo := itemXml('LST_EMPRESA', voParams);
  if (@piNmCampo = '') then begin
    Result := SetStatus(<STS_INFO>, 'GEN001', 'Empresa não pertence ao Pool.', cDS_METHOD);
    gprompt := item_f('CD_EMPRESA', tSIS_DUMMY);
    putitem_e(tSIS_DUMMY, 'CD_EMPRESA', itemXmlF('CD_EMPRESA', PARAM_GLB));
    item_a('NM_EMPRESA', tSIS_DUMMY)= '';
    return(-1); exit;
  end;
  return(0); exit;
end;

//----------------------------------------------------------
function TF_ECFFP007.filtroNrECF(pParams : String) : String;
//----------------------------------------------------------
const
  cDS_METHOD = 'ADICIONAL=Operação: TF_ECFFP007.filtroNrECF()';
begin
  putitem_o(tSIS_DUMMY, 'NR_INTERVALO', '');

  if (item_f('NR_INICIAL', tSIS_DUMMY) > item_f('NR_FINAL', tSIS_DUMMY)) then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Número ECF inicial maior que a final!', cDS_METHOD);
    gprompt := item_f('NR_INICIAL', tSIS_DUMMY);
    return(-1); exit;
  end;
  if (item_f('NR_FINAL', tSIS_DUMMY) <> '') then begin
    putitem_o(tSIS_DUMMY, 'NR_INTERVALO', '>= ' + item_a('NR_INICIAL', tSIS_DUMMY) + ' and<= ' + item_a('NR_FINAL', tSIS_DUMMY) + '');
  end;

  return(0); exit;
end;

//------------------------------------------------------------------
function TF_ECFFP007.validaIntervaloData(pParams : String) : String;
//------------------------------------------------------------------
const
  cDS_METHOD = 'ADICIONAL=Operação: TF_ECFFP007.validaIntervaloData()';
begin
  if (item_a('DT_INICIAL', tSIS_DUMMY) <> ''  ) and (item_a('DT_FINAL', tSIS_DUMMY) <> '') then begin
    if (item_a('DT_INICIAL', tSIS_DUMMY) > item_a('DT_FINAL', tSIS_DUMMY)) then begin
      Result := SetStatus(STS_ERROR, 'GEN0001', 'Data inicial maior que a data final !', cDS_METHOD);
      putitem_e(tSIS_DUMMY, 'DT_INTERVALO', '');
      gprompt := item_a('DT_FINAL', tSIS_DUMMY);
      return(0); exit;
    end else begin
      putitem_o(tSIS_DUMMY, 'DT_INTERVALO', '>= ' + item_a('DT_INICIAL', tSIS_DUMMY) + ' and<= ' + item_a('DT_FINAL', tSIS_DUMMY) + '');
    end;
  end;
  if (item_a('DT_INICIAL', tSIS_DUMMY) = '' ) and (item_a('DT_FINAL', tSIS_DUMMY) = '') then begin
    putitem_o(tSIS_DUMMY, 'DT_INTERVALO', '');
    message/info 'Intervalo de data deve ser informado !';
    gprompt := item_a('DT_INICIAL', tSIS_DUMMY);
    return(-1); exit;
  end;
end;

//---------------------------------------------------------------------
function TF_ECFFP007.consultarECFExportacao(pParams : String) : String;
//---------------------------------------------------------------------
const
  cDS_METHOD = 'ADICIONAL=Operação: TF_ECFFP007.consultarECFExportacao()';
begin
  if (item_f('CD_EMPRESA', tSIS_DUMMY) = '') then begin
    Result := SetStatus(STS_AVISO, 'GEN001', 'Informar empresa para consulta da ECF Matricial.', cDS_METHOD);
    gprompt := item_f('CD_EMPRESA', tSIS_DUMMY);
    return(-1); exit;
  end;
  voParams := validaEmpresas(viParams); (* 'item_f('CD_EMPRESA', tSIS_DUMMY)', True *)
  if (xStatus < 0) then begin
    Result := voParams;
    return(-1); exit;
  end;

  voParams := validaIntervaloData(viParams); (* *)
  if (xStatus < 0) then begin
    Result := voParams;
    return(-1); exit;
  end;

  voParams := filtroNrECF(viParams); (* *)
  if (xStatus < 0) then begin
    Result := voParams;
    return(-1); exit;
  end;

  clear_e(tFIS_REDZM);
  show;
  putitem_o(tFIS_REDZM, 'CD_EMPRESA', item_f('CD_EMPRESA', tSIS_DUMMY));
  putitem_o(tFIS_REDZM, 'NR_ECF', item_f('NR_INTERVALO', tSIS_DUMMY));
  putitem_o(tFIS_REDZM, 'DT_EMISSAO', item_a('DT_INTERVALO', tSIS_DUMMY));
  retrieve_e(tFIS_REDZM);
  if (xStatus < 0) then begin
    Result := SetStatus(STS_AVISO, 'GEN001', 'Nenhuma ECF Matricial encontrada para o filtro informado.', cDS_METHOD);
    clear_e(tFIS_REDZM);
    gprompt := item_f('CD_EMPRESA', tSIS_DUMMY);
    return(-1); exit;
  end else begin
    setocc(tFIS_REDZM, -1);
    setocc(tFIS_REDZM, 1);
  end;

  return(0); exit;
end;

//-----------------------------------------------------------------
function TF_ECFFP007.selecionarRegistro(pParams : String) : String;
//-----------------------------------------------------------------
const
  cDS_METHOD = 'ADICIONAL=Operação: TF_ECFFP007.selecionarRegistro()';
begin
  if (empty(tFIS_REDZM)) then begin
    return(0); exit;
  end;

  setocc(tFIS_REDZM, 1);
  while (xStatus >= 0) do begin

    if (item_a('BT_MARCAR', tSIS_TITBOTOES) = '^U_UNCHECK') then begin
      putitem_e(tFIS_REDZM, 'IN_MARCAR', True);
    end else begin
      putitem_e(tFIS_REDZM, 'IN_MARCAR', False);
    end;

    setocc(tFIS_REDZM, curocc(tFIS_REDZM) + 1);
  end;
  if (item_a('BT_MARCAR', tSIS_TITBOTOES) = '^U_UNCHECK') then begin
    putitem_e(tSIS_TITBOTOES, 'BT_MARCAR', '^U_CHECK');
  end else begin
    putitem_e(tSIS_TITBOTOES, 'BT_MARCAR', '^U_UNCHECK');
  end;
  setocc(tFIS_REDZM, 1);

  return(0); exit;
end;

//----------------------------------------------------------
function TF_ECFFP007.valorPadrao(pParams : String) : String;
//----------------------------------------------------------
const
  cDS_METHOD = 'ADICIONAL=Operação: TF_ECFFP007.valorPadrao()';
begin
  clear_e(tFIS_REDZM);

  putitem_e(tSIS_DUMMY, 'CD_EMPRESA', itemXmlF('CD_EMPRESA', PARAM_GLB));
  clear_e(tGER_EMPRESA);
  putitem_o(tGER_EMPRESA, 'CD_EMPRESA', item_f('CD_EMPRESA', tSIS_DUMMY));
  retrieve_e(tGER_EMPRESA);

  putitem_o(tSIS_DUMMY, 'NM_EMPRESA', item_a('NM_PESSOA', tPES_PESSOA));

  return(0); exit;
end;

//-------------------------------------------------------
function TF_ECFFP007.gerarE00(pParams : String) : String;
//-------------------------------------------------------
const
  cDS_METHOD = 'ADICIONAL=Operação: TF_ECFFP007.gerarE00()';
var
  vDsNumeroSerie, vDsMfAdicional, vNumeroUsuario : String;
  vTipoECF, vMarca, vModelo, vCOO, vNumeroAplicativo : String;
  vImunicipal, vNomeSoftHouse, vNomeAplicativo, vCnpjCpf, vVersaoAplicativo, vInscricaoEstadual, vLinha1, vLinha2 : String;
  vAux : Real;
  vFlag : Boolean;
begin
  voParams := setDisplay(viParams); (* 'Gerando NFP: registro E00', '', '' *)
  if (xStatus < 0) then begin
    Result := voParams;
    return(-1); exit;
  end;

  gvDsPath := item_a('DS_CAMINHO', tSIS_DUMMY);

  gvDsConteudo := '';

  gvDsConteudo := 'E00';

  vDsNumeroSerie := item_f('CD_SERIEFAB', tFIS_ECF);
  voParams := espacoDireita(viParams); (* vDsNumeroSerie, 20, vDsNumeroSerie *)
  gvDsConteudo := '' + gvDsConteudo' + vDsNumeroSerie' + ' + ';

  vDsMfAdicional := '';
  voParams := espacoDireita(viParams); (* vDsMfAdicional, 1, vDsMfAdicional *)
  gvDsConteudo := '' + gvDsConteudo' + vDsMfAdicional' + ' + ';

  vNumeroUsuario := '1';
  voParams := preencheZero(viParams); (* vNumeroUsuario, 2, vNumeroUsuario *)
  gvDsConteudo := '' + gvDsConteudo' + vNumeroUsuario' + ' + ';

  vTipoECF := 'ECF-IF';
  voParams := espacoDireita(viParams); (* vTipoECF, 7, vTipoECF *)
  gvDsConteudo := '' + gvDsConteudo' + vTipoECF' + ' + ';

  clear_e(tFIS_ECFMOD);
  putitem_o(tFIS_ECFMOD, 'CD_EMPRESA', item_f('CD_EMPRESA', tFIS_REDZM));
  putitem_o(tFIS_ECFMOD, 'NR_ECF', item_f('NR_ECF', tFIS_REDZM));
  retrieve_e(tFIS_ECFMOD);
  if (xStatus >= 0) then begin
    clear_e(tFIS_MARCAECF);
    putitem_o(tFIS_MARCAECF, 'CD_MARCA', item_a('DS_MARCA', tFIS_ECFMOD));
    retrieve_e(tFIS_MARCAECF);
  end;
  vMarca := item_a('DS_MARCA', tFIS_MARCAECF)[1:20];
  voParams := espacoDireita(viParams); (* vMarca, 20, vMarca *)
  gvDsConteudo := '' + gvDsConteudo' + vMarca' + ' + ';

  clear_e(tFIS_MODELOECF);
  putitem_o(tFIS_MODELOECF, 'CD_MARCA', item_f('CD_MARCA', tFIS_MARCAECF));
  putitem_o(tFIS_MODELOECF, 'CD_MODELO', item_f('CD_MODELO', tFIS_ECFMOD));
  retrieve_e(tFIS_MODELOECF);

  vModelo := item_a('DS_MODELO', tFIS_MODELOECF)[1:20];
  voParams := espacoDireita(viParams); (* vModelo, 20, vModelo *)
  gvDsConteudo := '' + gvDsConteudo' + vModelo' + ' + ';

  vCOO := item_f('NR_CUPOMINI', tFIS_REDZM);
  voParams := preencheZero(viParams); (* vCOO, 6, vCOO *)
  gvDsConteudo := '' + gvDsConteudo' + vCOO' + ' + ';

  vNumeroAplicativo := '0';
  voParams := preencheZero(viParams); (* vNumeroAplicativo, 2, vNumeroAplicativo *)
  gvDsConteudo := '' + gvDsConteudo' + vNumeroAplicativo' + ' + ';

  vCnpjCpf := '00157585000158';
  voParams := preencheZero(viParams); (* vCnpjCpf, 14, vCnpjCpf *)
  gvDsConteudo := '' + gvDsConteudo' + vCnpjCpf' + ' + ';

  vInscricaoEstadual := '0';
  voParams := preencheZero(viParams); (* vInscricaoEstadual, 14, vInscricaoEstadual *)
  gvDsConteudo := '' + gvDsConteudo' + vInscricaoEstadual' + ' + ';

  vImunicipal := '7070000';
  voParams := preencheZero(viParams); (* vImunicipal, 14, vImunicipal *)
  gvDsConteudo := '' + gvDsConteudo' + vImunicipal' + ' + ';

  vNomeSoftHouse := 'JOSE MARCOS NABHAN';
  voParams := espacoDireita(viParams); (* vNomeSoftHouse, 40, vNomeSoftHouse *)
  gvDsConteudo := '' + gvDsConteudo' + vNomeSoftHouse' + ' + ';

  vNomeAplicativo := 'STORE AGE';
  voParams := espacoDireita(viParams); (* vNomeAplicativo, 40, vNomeAplicativo *)
  gvDsConteudo := '' + gvDsConteudo' + vNomeAplicativo' + ' + ';

  vVersaoAplicativo := '3.0';
  voParams := espacoDireita(viParams); (* vVersaoAplicativo, 10, vVersaoAplicativo *)
  gvDsConteudo := '' + gvDsConteudo' + vVersaoAplicativo' + ' + ';

  vLinha1 := ' ';
  voParams := espacoDireita(viParams); (* vLinha1, 42, vLinha1 *)
  gvDsConteudo := '' + gvDsConteudo' + vLinha + ' + '1';

  vLinha2 := ' ';
  voParams := espacoDireita(viParams); (* vLinha2, 42, vLinha2 *)
  gvDsConteudo := '' + gvDsConteudo' + vLinha + ' + '2';

  voParams := geraNomeArquivo(viParams); (* item_a('DT_EMISSAO', tFIS_REDZM), item_a('DS_MARCA', tFIS_ECFMOD), item_f('CD_MODELO', tFIS_MODELOECF), item_f('CD_SERIEFAB', tFIS_ECF), gnomeArquivo *)
  if (xStatus < 0) then begin
    Result := voParams;
    return(-1); exit;
  end;

  voParams := activateCmp('vbfileman', 'arqexiste', viParams); (*vFlag,'' + gvDsPath' + gnomeArquivo' + ' + ' *)
  if (vFlag) then begin
    voParams := activateCmp('vbfileman', 'apagaarquivo', viParams); (*'' + gvDsPath' + gnomeArquivo' + ' + ' *)
  end;

  return(0); exit;
end;

//-------------------------------------------------------
function TF_ECFFP007.gerarE01(pParams : String) : String;
//-------------------------------------------------------
const
  cDS_METHOD = 'ADICIONAL=Operação: TF_ECFFP007.gerarE01()';
var
  vDsNumeroSerie, vDsMfAdicional, vComandoGeracao, vTipoECF, vVersaoBiblioteca : String;
  vMarca, vModelo, vCOO, vNumeroAplicativo, vContadorReducaoInicial, vContadorReducaoFinal, vDataAuxiliar, vVersaoAtoCotepe : String;
  vCnpjCpf, vVersaoSoftBasico, vHoraGravacaoSoftBasico, vDataGravacaoSoftBasico, vNrSequencialEcf, vDataInicial, vDataFinal : String;
  vAux : Real;
begin
  voParams := setDisplay(viParams); (* 'Gerando NFP: registro E01', '', '' *)
  if (xStatus < 0) then begin
    Result := voParams;
    return(-1); exit;
  end;

  gvDsConteudo := '' + gvDsConteudoE + '01';

  vDsNumeroSerie := item_f('CD_SERIEFAB', tFIS_ECF);
  voParams := espacoDireita(viParams); (* vDsNumeroSerie, 20, vDsNumeroSerie *)
  gvDsConteudo := '' + gvDsConteudo' + vDsNumeroSerie' + ' + ';

  vDsMfAdicional := '';
  voParams := espacoDireita(viParams); (* vDsMfAdicional, 1, vDsMfAdicional *)
  gvDsConteudo := '' + gvDsConteudo' + vDsMfAdicional' + ' + ';

  vTipoECF := 'ECF-IF';
  voParams := espacoDireita(viParams); (* vTipoECF, 7, vTipoECF *)
  gvDsConteudo := '' + gvDsConteudo' + vTipoECF' + ' + ';

  clear_e(tFIS_ECFMOD);
  putitem_o(tFIS_ECFMOD, 'CD_EMPRESA', item_f('CD_EMPRESA', tFIS_REDZM));
  putitem_o(tFIS_ECFMOD, 'NR_ECF', item_f('NR_ECF', tFIS_REDZM));
  retrieve_e(tFIS_ECFMOD);
  if (xStatus>=0) then begin
    clear_e(tFIS_MARCAECF);
    putitem_o(tFIS_MARCAECF, 'CD_MARCA', item_a('DS_MARCA', tFIS_ECFMOD));
    retrieve_e(tFIS_MARCAECF);
  end;
  vMarca := item_a('DS_MARCA', tFIS_MARCAECF)[1:20];
  voParams := espacoDireita(viParams); (* vMarca, 20, vMarca *)
  gvDsConteudo := '' + gvDsConteudo' + vMarca' + ' + ';

  clear_e(tFIS_MODELOECF);
  putitem_o(tFIS_MODELOECF, 'CD_MARCA', item_f('CD_MARCA', tFIS_MARCAECF));
  putitem_o(tFIS_MODELOECF, 'CD_MODELO', item_f('CD_MODELO', tFIS_ECFMOD));
  retrieve_e(tFIS_MODELOECF);
  vModelo := item_a('DS_MODELO', tFIS_MODELOECF)[1:20];
  voParams := espacoDireita(viParams); (* vModelo, 20, vModelo *)
  gvDsConteudo := '' + gvDsConteudo' + vModelo' + ' + ';

  clear_e(tFIS_ECFSB);
  putitem_o(tFIS_ECFSB, 'CD_EMPRESA', item_f('CD_EMPRESA', tFIS_REDZM));
  putitem_o(tFIS_ECFSB, 'NR_ECF', item_f('NR_ECF', tFIS_ECFSB));
  retrieve_e(tFIS_ECFSB);
  vVersaoSoftBasico= item_a('DS_VERSAOSB', tFIS_ECFSB);
  voParams := espacoDireita(viParams); (* vVersaoSoftBasico, 10, vVersaoSoftBasico *)
  gvDsConteudo := '' + gvDsConteudo' + vVersaoSoftBasico' + ' + ';

  vDataGravacaoSoftBasico := item_a('DT_GRAVACAOSB', tFIS_ECFSB);
  voParams := mascaraData(viParams); (* vDataGravacaoSoftBasico, vDataGravacaoSoftBasico *)
  voParams := preencheZero(viParams); (* vDataGravacaoSoftBasico, 8, vDataGravacaoSoftBasico *)
  gvDsConteudo := '' + gvDsConteudo' + vDataGravacaoSoftBasico' + ' + ';

  gvHoraGravacaoSoftBasico := item_a('HR_GRAVACAOSB', tFIS_ECFSB);
  vHoraGravacaoSoftBasico := '' + gvHoraGravacaoSoftBasico' + ';
  voParams := preencheZero(viParams); (* vHoraGravacaoSoftBasico, 6, vHoraGravacaoSoftBasico *)
  gvDsConteudo := '' + gvDsConteudo' + vHoraGravacaoSoftBasico' + ' + ';

  vNrSequencialEcf= item_f('NR_ECF', tFIS_REDZM);
  voParams := preencheZero(viParams); (* vNrSequencialEcf, 3, vNrSequencialEcf *)
  gvDsConteudo := '' + gvDsConteudo' + FloatToStr(vNrSequencialEcf') + ' + ';

  clear_e(tGER_EMPRESA);
  putitem_o(tGER_EMPRESA, 'CD_EMPRESA', item_f('CD_EMPRESA', tFIS_REDZM));
  retrieve_e(tGER_EMPRESA);
  vCnpjCpf := item_f('NR_CNPJ', tPES_PESJURIDICA);
  voParams := preencheZero(viParams); (* vCnpjCpf, 14, vCnpjCpf *)
  gvDsConteudo := '' + gvDsConteudo' + vCnpjCpf' + ' + ';

  vComandoGeracao := 'APL';
  voParams := espacoDireita(viParams); (* vComandoGeracao, 3, vComandoGeracao *)
  gvDsConteudo := '' + gvDsConteudo' + vComandoGeracao' + ' + ';

  vContadorReducaoInicial := item_f('NR_REDUCAOZ', tFIS_REDZM);
  voParams := preencheZero(viParams); (* vContadorReducaoInicial, 6, vContadorReducaoInicial *)
  gvDsConteudo := '' + gvDsConteudo' + vContadorReducaoInicial' + ' + ';

  vContadorReducaoFinal := item_f('NR_REDUCAOZ', tFIS_REDZM);
  voParams := preencheZero(viParams); (* vContadorReducaoFinal, 6, vContadorReducaoFinal *)
  gvDsConteudo := '' + gvDsConteudo' + vContadorReducaoFinal' + ' + ';

  vDataInicial := item_a('DT_INICIAL', tSIS_DUMMY);
  voParams := mascaraData(viParams); (* vDataInicial, vDataInicial *)
  voParams := preencheZero(viParams); (* vDataInicial, 8, vDataInicial *)
  gvDsConteudo := '' + gvDsConteudo' + vDataInicial' + ' + ';

  vDataFinal := item_a('DT_FINAL', tSIS_DUMMY);
  voParams := mascaraData(viParams); (* vDataFinal, vDataFinal *)
  voParams := preencheZero(viParams); (* vDataFinal, 8, vDataFinal *)
  gvDsConteudo := '' + gvDsConteudo' + vDataFinal' + ' + ';

  vVersaoBiblioteca := '01.00.00';
  voParams := espacoDireita(viParams); (* vVersaoBiblioteca, 8, vVersaoBiblioteca *)
  gvDsConteudo := '' + gvDsConteudo' + vVersaoBiblioteca' + ' + ';

  vVersaoAtoCotepe := 'PC5207 01.00.00';
  voParams := espacoDireita(viParams); (* vVersaoAtoCotepe, 15, vVersaoAtoCotepe *)
  gvDsConteudo := '' + gvDsConteudo' + vVersaoAtoCotepe' + ' + ';

  return(0); exit;
end;

//-------------------------------------------------------
function TF_ECFFP007.gerarE02(pParams : String) : String;
//-------------------------------------------------------
const
  cDS_METHOD = 'ADICIONAL=Operação: TF_ECFFP007.gerarE02()';
var
  vDsNumeroSerie, vDsMfAdicional, vNrUsuario, vGrandeTotal : String;
  vModelo, vDataAuxiliar, vNomeContribuinte, venderecoEstabelecimento, vCroCadastroUsu : String;
  vCnpjCpf, vInscricaoEstadual, vDataCadastroUsu, vHoraCadastroUsu, vAux : String;
begin
  voParams := setDisplay(viParams); (* 'Gerando NFP: registro E02', '', '' *)
  if (xStatus < 0) then begin
    Result := voParams;
    return(-1); exit;
  end;

  gvDsConteudo := '' + gvDsConteudoE + '02';

  vDsNumeroSerie := item_f('CD_SERIEFAB', tFIS_ECF);
  voParams := espacoDireita(viParams); (* vDsNumeroSerie, 20, vDsNumeroSerie *)
  gvDsConteudo := '' + gvDsConteudo' + vDsNumeroSerie' + ' + ';

  vDsMfAdicional := '';
  voParams := espacoDireita(viParams); (* vDsMfAdicional, 1, vDsMfAdicional *)
  gvDsConteudo := '' + gvDsConteudo' + vDsMfAdicional' + ' + ';

  clear_e(tFIS_MODELOECF);
  putitem_o(tFIS_MODELOECF, 'CD_MARCA', item_f('CD_MARCA', tFIS_MARCAECF));
  putitem_o(tFIS_MODELOECF, 'CD_MODELO', item_f('CD_MODELO', tFIS_ECFMOD));
  retrieve_e(tFIS_MODELOECF);
  vModelo := item_a('DS_MODELO', tFIS_MODELOECF)[1:20];
  voParams := espacoDireita(viParams); (* vModelo, 20, vModelo *)
  gvDsConteudo := '' + gvDsConteudo' + vModelo' + ' + ';

  clear_e(tGER_EMPRESA);
  putitem_o(tGER_EMPRESA, 'CD_EMPRESA', item_f('CD_EMPRESA', tFIS_REDZM));
  retrieve_e(tGER_EMPRESA);
  vCnpjCpf := item_f('NR_CNPJ', tPES_PESJURIDICA);
  voParams := preencheZero(viParams); (* vCnpjCpf, 14, vCnpjCpf *)
  gvDsConteudo := '' + gvDsConteudo' + vCnpjCpf' + ' + ';

  vInscricaoEstadual := item_f('NR_INSCESTL', tPES_PESJURIDICA);
  voParams := espacoDireita(viParams); (* vInscricaoEstadual, 14, vInscricaoEstadual *)
  gvDsConteudo := '' + gvDsConteudo' + vInscricaoEstadual' + ' + ';

  vNomeContribuinte := item_a('NM_PESSOA', tPES_PESSOA);
  voParams := espacoDireita(viParams); (* vNomeContribuinte, 40, vNomeContribuinte *)
  gvDsConteudo := '' + gvDsConteudo' + vNomeContribuinte' + ' + ';

  vAux := ' ';
  venderecoEstabelecimento := item_a('DS_SIGLALOGRAD', tPES_ENDERECO);
  venderecoEstabelecimento := '' + venderecoEstabelecimento' + vAux' + NM_LOGRADOURO + ' + ' + '.PES_ENDERECO';
  venderecoEstabelecimento := '' + venderecoEstabelecimento' + vAux' + NR_LOGRADOURO + ' + ' + '.PES_ENDERECO';
  voParams := espacoDireita(viParams); (* venderecoEstabelecimento, 120, venderecoEstabelecimento *)
  gvDsConteudo := '' + gvDsConteudo' + venderecoEstabelecimento' + ' + ';

  clear_e(tFIS_ECFSB);
  putitem_o(tFIS_ECFSB, 'CD_EMPRESA', item_f('CD_EMPRESA', tFIS_REDZM));
  putitem_o(tFIS_ECFSB, 'NR_ECF', item_f('NR_ECF', tFIS_REDZM));
  retrieve_e(tFIS_ECFSB);
  vDataCadastroUsu := item_a('DT_CADUSUECF', tFIS_ECFSB);
  voParams := mascaraData(viParams); (* vDataCadastroUsu, vDataCadastroUsu *)
  voParams := preencheZero(viParams); (* vDataCadastroUsu, 8, vDataCadastroUsu *)
  gvDsConteudo := '' + gvDsConteudo' + vDataCadastroUsu' + ' + ';

  gvHoraCadastroUsu := item_a('HR_CADUSUECF', tFIS_ECFSB);
  vHoraCadastroUsu := '' + gvHoraCadastroUsu' + ';
  voParams := preencheZero(viParams); (* vHoraCadastroUsu, 6, vHoraCadastroUsu *)
  gvDsConteudo := '' + gvDsConteudo' + vHoraCadastroUsu' + ' + ';

  vCroCadastroUsu := item_f('NR_CRO', tFIS_ECFSB);
  voParams := preencheZero(viParams); (* vCroCadastroUsu, 6, vCroCadastroUsu *)
  gvDsConteudo := '' + gvDsConteudo' + vCroCadastroUsu' + ' + ';

  vGrandetotal := item_f('VL_GT', tFIS_ECFSB);
  voParams := formataCampoComDecimal(viParams); (* (viParams); (* vGrandetotal), 16, 2, vGrandetotal *)
  gvDsConteudo := '' + gvDsConteudo' + vGrandetotal' + ' + ';

  vNrUsuario := item_f('NR_USUARIO', tFIS_ECFSB);
  voParams := preencheZero(viParams); (* vNrUsuario, 2, vNrUsuario *)
  gvDsConteudo := '' + gvDsConteudo' + FloatToStr(vNrUsuario') + ' + ';

  return(0); exit;
end;

//-------------------------------------------------------
function TF_ECFFP007.gerarE12(pParams : String) : String;
//-------------------------------------------------------
const
  cDS_METHOD = 'ADICIONAL=Operação: TF_ECFFP007.gerarE12()';
var
  vDsNumeroSerie, vDsMfAdicional, vHoraEmissao, vVendaBruta, vIncidenciaDesconto : String;
  vModelo, vDataAuxiliar, vNomeContribuinte, venderecoEstabelecimento, vDataMovimento, vDataEmissao : String;
  vCnpjCpf, vInscricaoEstadual, vNumeroUsuario, vContadorReducaoZ, vContadorOperacao, vContadorReinicio : String;
  vAux : Real;
begin
  voParams := setDisplay(viParams); (* 'Gerando NFP: registro E12', '', '' *)
  if (xStatus < 0) then begin
    Result := voParams;
    return(-1); exit;
  end;

  gvDsConteudo := '' + gvDsConteudoE + '12';

  vDsNumeroSerie := item_f('CD_SERIEFAB', tFIS_ECF);
  voParams := espacoDireita(viParams); (* vDsNumeroSerie, 20, vDsNumeroSerie *)
  gvDsConteudo := '' + gvDsConteudo' + vDsNumeroSerie' + ' + ';

  vDsMfAdicional := '';
  voParams := espacoDireita(viParams); (* vDsMfAdicional, 1, vDsMfAdicional *)
  gvDsConteudo := '' + gvDsConteudo' + vDsMfAdicional' + ' + ';

  clear_e(tFIS_MODELOECF);
  putitem_o(tFIS_MODELOECF, 'CD_MARCA', item_f('CD_MARCA', tFIS_MARCAECF));
  putitem_o(tFIS_MODELOECF, 'CD_MODELO', item_f('CD_MODELO', tFIS_ECFMOD));
  retrieve_e(tFIS_MODELOECF);
  vModelo := item_a('DS_MODELO', tFIS_MODELOECF)[1:20];
  voParams := espacoDireita(viParams); (* vModelo, 20, vModelo *)
  gvDsConteudo := '' + gvDsConteudo' + vModelo' + ' + ';

  vNumeroUsuario := '1';
  voParams := preencheZero(viParams); (* vNumeroUsuario, 2, vNumeroUsuario *)
  gvDsConteudo := '' + gvDsConteudo' + vNumeroUsuario' + ' + ';

  vContadorReducaoZ := item_f('NR_REDUCAOZ', tFIS_REDZM);
  voParams := preencheZero(viParams); (* vContadorReducaoZ, 6, vContadorReducaoZ *)
  gvDsConteudo := '' + gvDsConteudo' + vContadorReducaoZ' + ' + ';

  vContadorOperacao := item_f('NR_CUPOMINI', tFIS_REDZM);
  voParams := preencheZero(viParams); (* vContadorOperacao, 6, vContadorOperacao *)
  gvDsConteudo := '' + gvDsConteudo' + vContadorOperacao' + ' + ';

  vContadorReinicio := item_f('NR_REINICIO', tFIS_REDZM);
  voParams := preencheZero(viParams); (* vContadorReinicio, 6, vContadorReinicio *)
  gvDsConteudo := '' + gvDsConteudo' + vContadorReinicio' + ' + ';
  vDataMovimento := item_a('DT_EMISSAO', tFIS_REDZM);
  voParams := mascaraData(viParams); (* vDataMovimento, vDataMovimento *)
  voParams := preencheZero(viParams); (* vDataMovimento, 8, vDataMovimento *)
  gvDsConteudo := '' + gvDsConteudo' + vDataMovimento' + ' + ';

  vDataEmissao := item_a('DT_EMISSAO', tFIS_REDZM);
  voParams := mascaraData(viParams); (* vDataEmissao, vDataEmissao *)
  voParams := preencheZero(viParams); (* vDataEmissao, 8, vDataEmissao *)
  gvDsConteudo := '' + gvDsConteudo' + vDataEmissao' + ' + ';

  gvHoraCadastro := item_a('DT_CADASTRO', tFIS_REDZM);
  vHoraEmissao := '' + gvHoraCadastro' + ';
  voParams := preencheZero(viParams); (* vHoraEmissao, 6, vHoraEmissao *)
  gvDsConteudo := '' + gvDsConteudo' + vHoraEmissao' + ' + ';

  vVendaBruta := item_f('VL_VENDABRUTA', tFIS_REDZM);
  voParams := formataCampoComDecimal(viParams); (* (viParams); (* vVendaBruta), 12, 2, vVendaBruta *)
  gvDsConteudo := '' + gvDsConteudo' + vVendaBruta' + ' + ';

  vIncidenciaDesconto := 'N';
  voParams := espacoDireita(viParams); (* vIncidenciaDesconto, 1, vIncidenciaDesconto *)
  gvDsConteudo := '' + gvDsConteudo' + vIncidenciaDesconto' + ' + ';

  return(0); exit;
end;

//-------------------------------------------------------
function TF_ECFFP007.gerarE13(pParams : String) : String;
//-------------------------------------------------------
const
  cDS_METHOD = 'ADICIONAL=Operação: TF_ECFFP007.gerarE13()';
var
  vDsNumeroSerie, vDsMfAdicional, vAuxiliar : String;
  vModelo, vDataAuxiliar, vTotalizadorParcial, vNumeroUsuario, vContadorReducaoZ, vValorAcumulado : String;
  vNumeroSeq : Real;
begin
  clear_e(tFIS_REDZA);
  putitem_o(tFIS_REDZA, 'CD_EMPRESA', item_f('CD_EMPRESA', tFIS_REDZM));
  putitem_o(tFIS_REDZA, 'NR_ECF', item_f('NR_ECF', tFIS_REDZM));
  putitem_o(tFIS_REDZA, 'DT_EMISSAO', item_a('DT_EMISSAO', tFIS_REDZM));
  retrieve_e(tFIS_REDZA);
  if (xStatus >= 0) then begin
    setocc(tFIS_REDZA, 1);
    while (xStatus >= 0) do begin

      voParams := setDisplay(viParams); (* 'Gerando NFP: registro E13', '', '' *)
      if (xStatus < 0) then begin
        Result := voParams;
        return(-1); exit;
      end;

      gvDsConteudo := '' + gvDsConteudoE + '13';

      vNumeroSeq := vNumeroSeq + 1;

      vDsNumeroSerie := item_f('CD_SERIEFAB', tFIS_ECF);
      voParams := espacoDireita(viParams); (* vDsNumeroSerie, 20, vDsNumeroSerie *)
      gvDsConteudo := '' + gvDsConteudo' + vDsNumeroSerie' + ' + ';

      vDsMfAdicional := '';
      voParams := espacoDireita(viParams); (* vDsMfAdicional, 1, vDsMfAdicional *)
      gvDsConteudo := '' + gvDsConteudo' + vDsMfAdicional' + ' + ';

      clear_e(tFIS_MODELOECF);
      putitem_o(tFIS_MODELOECF, 'CD_MARCA', item_f('CD_MARCA', tFIS_MARCAECF));
      putitem_o(tFIS_MODELOECF, 'CD_MODELO', item_f('CD_MODELO', tFIS_ECFMOD));
      retrieve_e(tFIS_MODELOECF);
      vModelo := item_a('DS_MODELO', tFIS_MODELOECF)[1:20];
      voParams := espacoDireita(viParams); (* vModelo, 20, vModelo *)
      gvDsConteudo := '' + gvDsConteudo' + vModelo' + ' + ';

      vNumeroUsuario := '1';
      voParams := preencheZero(viParams); (* vNumeroUsuario, 2, vNumeroUsuario *)
      gvDsConteudo := '' + gvDsConteudo' + vNumeroUsuario' + ' + ';

      vContadorReducaoZ := item_f('NR_REDUCAOZ', tFIS_REDZM);
      voParams := preencheZero(viParams); (* vContadorReducaoZ, 6, vContadorReducaoZ *)
      gvDsConteudo := '' + gvDsConteudo' + vContadorReducaoZ' + ' + ';

      if (item_f('CD_SITALIQ', tFIS_REDZA) = 'CANC') then begin
        vTotalizadorParcial := 'Can-T';
        voParams := espacoDireita(viParams); (* vTotalizadorParcial, 7, vTotalizadorParcial *)
        gvDsConteudo := '' + gvDsConteudo' + vTotalizadorParcial' + ' + ';
      end else if (item_f('CD_SITALIQ', tFIS_REDZA) = 'DESC') then begin
        vTotalizadorParcial := 'DT';
        voParams := espacoDireita(viParams); (* vTotalizadorParcial, 7, vTotalizadorParcial *)
        gvDsConteudo := '' + gvDsConteudo' + vTotalizadorParcial' + ' + ';
      end else if (item_f('CD_SITALIQ', tFIS_REDZA) = 'F') then begin
        vTotalizadorParcial := 'F1';
        voParams := espacoDireita(viParams); (* vTotalizadorParcial, 7, vTotalizadorParcial *)
        gvDsConteudo := '' + gvDsConteudo' + vTotalizadorParcial' + ' + ';
        end else if (item_f('CD_SITALIQ', tFIS_REDZA) = 'N') then begin
        vTotalizadorParcial := 'N1';
        voParams := espacoDireita(viParams); (* vTotalizadorParcial, 7, vTotalizadorParcial *)
        gvDsConteudo := '' + gvDsConteudo' + vTotalizadorParcial' + ' + ';
        end else if (item_f('CD_SITALIQ', tFIS_REDZA) = 'I') then begin
        vTotalizadorParcial := 'I1';
        voParams := espacoDireita(viParams); (* vTotalizadorParcial, 7, vTotalizadorParcial *)
        gvDsConteudo := '' + gvDsConteudo' + vTotalizadorParcial' + ' + ';
      end else begin
        vAuxiliar := 'T';
        voParams := preencheZero(viParams); (* vNumeroSeq, 2, vNumeroSeq *)
        vTotalizadorParcial := '' + vNumeroSeq' + vAuxiliar' + CD_SITALIQ + ' + ' + '.FIS_REDZA';
        voParams := espacoDireita(viParams); (* vTotalizadorParcial, 7, vTotalizadorParcial *)
        gvDsConteudo := '' + gvDsConteudo' + vTotalizadorParcial' + ' + ';
      end;

      vValorAcumulado := item_f('VL_TOTALACUM', tFIS_REDZA);
      voParams := formataCampoComDecimal(viParams); (* (viParams); (* vValorAcumulado), 11, 2, vValorAcumulado *)
      gvDsConteudo := '' + gvDsConteudo' + vValorAcumulado' + ' + ';
      setocc(tFIS_REDZA, curocc(tFIS_REDZA) + 1);
    end;
  end;

  return(0); exit;
end;

//-------------------------------------------------------
function TF_ECFFP007.gerarE14(pParams : String) : String;
//-------------------------------------------------------
const
  cDS_METHOD = 'ADICIONAL=Operação: TF_ECFFP007.gerarE14()';
var
  vDsNumeroSerie, vDsMfAdicional, vContatorDocumento, vNrCupom, vSubTotal, vTipoDesconto, vTipoAcrescimo, vValorLiquidoTotal : String;
  vModelo, vDataAuxiliar, vTotalizadorParcial, vNumeroUsuario, vContadorReducaoZ, vValorAcumulado, vValorDesconto, vIndicadorCancelamento : String;
  vValorDescontoAcrecimo, vNomeCliente, vNumCupom, vDataEmissao, vAcrescimoSubTotal, vCpfCnpj, vIndicadorDesconto : String;
  vAux : Real;
begin
  clear_e(tFIS_NFECF);

  putitem_o(tFIS_NFECF, 'CD_EMPFAT', item_f('CD_EMPRESA', tFIS_REDZM));
  putitem_o(tFIS_NFECF, 'DT_FATURA', item_a('DT_EMISSAO', tFIS_REDZM));
  putitem_o(tFIS_NFECF, 'CD_EMPECF', item_f('CD_EMPRESA', tFIS_REDZM));
  putitem_o(tFIS_NFECF, 'NR_ECF', item_f('NR_ECF', tFIS_REDZM));
  retrieve_e(tFIS_NFECF);
  if (xStatus >=0) then begin
    setocc(tFIS_NFECF, -1);
    setocc(tFIS_NFECF, 1);
    while (xStatus >=0) do begin

      clear_e(tFIS_NF);
      putitem_o(tFIS_NF, 'CD_EMPRESA', item_f('CD_EMPRESA', tFIS_NFECF));
      putitem_o(tFIS_NF, 'NR_FATURA', item_f('NR_FATURA', tFIS_NFECF));
      putitem_o(tFIS_NF, 'DT_FATURA', item_a('DT_FATURA', tFIS_NFECF));
      retrieve_e(tFIS_NF);
      if (xStatus >=0) then begin
        voParams := setDisplay(viParams); (* 'Gerando NFP: registro E14', '', '' *)
        if (xStatus < 0) then begin
          Result := voParams;
          return(-1); exit;
        end;

        gvDsConteudo := '' + gvDsConteudoE + '14';

        vDsNumeroSerie := item_f('CD_SERIEFAB', tFIS_ECF);
        voParams := espacoDireita(viParams); (* vDsNumeroSerie, 20, vDsNumeroSerie *)
        gvDsConteudo := '' + gvDsConteudo' + vDsNumeroSerie' + ' + ';

        vDsMfAdicional := '';
        voParams := espacoDireita(viParams); (* vDsMfAdicional, 1, vDsMfAdicional *)
        gvDsConteudo := '' + gvDsConteudo' + vDsMfAdicional' + ' + ';

        clear_e(tFIS_MODELOECF);
        putitem_o(tFIS_MODELOECF, 'CD_MARCA', item_f('CD_MARCA', tFIS_MARCAECF));
        putitem_o(tFIS_MODELOECF, 'CD_MODELO', item_f('CD_MODELO', tFIS_ECFMOD));
        retrieve_e(tFIS_MODELOECF);
        vModelo := item_a('DS_MODELO', tFIS_MODELOECF)[1:20];
        voParams := espacoDireita(viParams); (* vModelo, 20, vModelo *)
        gvDsConteudo := '' + gvDsConteudo' + vModelo' + ' + ';

        vNumeroUsuario := '1';
        voParams := preencheZero(viParams); (* vNumeroUsuario, 2, vNumeroUsuario *)
        gvDsConteudo := '' + gvDsConteudo' + vNumeroUsuario' + ' + ';

        vContatorDocumento := '';
        voParams := preencheZero(viParams); (* vContatorDocumento, 6, vContatorDocumento *)
        gvDsConteudo := '' + gvDsConteudo' + vContatorDocumento' + ' + ';

        vNumCupom := item_f('NR_CUPOM', tFIS_NFECF);
        voParams := preencheZero(viParams); (* vNumCupom, 6, vNumCupom *)
        gvDsConteudo := '' + gvDsConteudo' + vNumCupom' + ' + ';

        vDataEmissao := item_a('DT_EMISSAO', tFIS_NF);
        voParams := mascaraData(viParams); (* vDataEmissao, vDataEmissao *)
        voParams := preencheZero(viParams); (* vDataEmissao, 8, vDataEmissao *)
        gvDsConteudo := '' + gvDsConteudo' + vDataEmissao' + ' + ';

        vSubTotal := item_f('VL_TOTALPRODUTO', tFIS_NF);
        voParams := formataCampoComDecimal(viParams); (* (viParams); (* vSubTotal), 12, 2, vSubTotal *)
        gvDsConteudo := '' + gvDsConteudo' + vSubTotal' + ' + ';

        vValorDesconto := '0';

        voParams := preencheZero(viParams); (* vValorDesconto, 13, vValorDesconto *)
        gvDsConteudo := '' + gvDsConteudo' + vValorDesconto' + ' + ';

        vTipoDesconto := 'V';
        voParams := espacoDireita(viParams); (* vTipoDesconto, 1, vTipoDesconto *)
        gvDsConteudo := '' + gvDsConteudo' + vTipoDesconto' + ' + ';

        vAcrescimoSubTotal := '0';
        voParams := preencheZero(viParams); (* vAcrescimoSubTotal, 13, vAcrescimoSubTotal *)
        gvDsConteudo := '' + gvDsConteudo' + vAcrescimoSubTotal' + ' + ';

        vTipoAcrescimo := 'V';
        voParams := espacoDireita(viParams); (* vTipoAcrescimo, 1, vTipoAcrescimo *)
        gvDsConteudo := '' + gvDsConteudo' + vTipoAcrescimo' + ' + ';

        vValorLiquidoTotal := item_f('VL_TOTALNOTA', tFIS_NF);
        voParams := formataCampoComDecimal(viParams); (* (viParams); (* vValorLiquidoTotal), 12, 2, vValorLiquidoTotal *)
        gvDsConteudo := '' + gvDsConteudo' + vValorLiquidoTotal' + ' + ';

        if (item_f('TP_SITUACAO', tFIS_NF) = 'C') then begin
          vIndicadorCancelamento := 'S';
        end else begin
          vIndicadorCancelamento := 'N';
        end;
        voParams := espacoDireita(viParams); (* vIndicadorCancelamento, 1, vIndicadorCancelamento *)
        gvDsConteudo := '' + gvDsConteudo' + vIndicadorCancelamento' + ' + ';

        vValorDescontoAcrecimo := '';
        voParams := preencheZero(viParams); (* vValorDescontoAcrecimo, 13, vValorDescontoAcrecimo *)
        gvDsConteudo := '' + gvDsConteudo' + vValorDescontoAcrecimo' + ' + ';

        vIndicadorDesconto := 'D';
        voParams := espacoDireita(viParams); (* vIndicadorDesconto, 1, vIndicadorDesconto *)
        gvDsConteudo := '' + gvDsConteudo' + vIndicadorDesconto' + ' + ';

        vNomeCliente := item_a('NM_NOME', tFIS_NFREMDES);
        voParams := espacoDireita(viParams); (* vNomeCliente, 40, vNomeCliente *)
        gvDsConteudo := '' + gvDsConteudo' + vNomeCliente' + ' + ';

        vCpfCnpj := item_f('NR_CPFCNPJ', tFIS_NFREMDES);
        voParams := preencheZero(viParams); (* vCpfCnpj, 14, vCpfCnpj *)
        gvDsConteudo := '' + gvDsConteudo' + vCpfCnpj' + ' + ';

      end;
      setocc(tFIS_NFECF, curocc(tFIS_NFECF) + 1);
    end;
  end;
  return(0); exit;
end;

//-------------------------------------------------------
function TF_ECFFP007.gerarE15(pParams : String) : String;
//-------------------------------------------------------
const
  cDS_METHOD = 'ADICIONAL=Operação: TF_ECFFP007.gerarE15()';
var
  vDsNumeroSerie, vDsMfAdicional, vContatorDocumento, vNumItem, vValorDesconto, vIndicadorCancelamento, vValorCancelado : String;
  vModelo, vNumeroUsuario, vCodigoProduto, vDescProduto, vQuantidade, vUnidade, vValorUnitario, vTotalizadoParcial, vQuantidadeCancelada : String;
  vCancelamentoAcrescimoItem, vRegraCalculo, vAcrescimoItem, vTotalLiquido, vContatorDocumentoEmitido, vAuxiliar, vTotalizadorParcial : String;
  vCasaDecimalQuant, vCasaDecimalValor : String;
begin
  setocc(tFIS_NFECF, 1);
  while(xStatus >= 0) do begin
    clear_e(tFIS_NF);
    putitem_o(tFIS_NF, 'CD_EMPRESA', item_f('CD_EMPRESA', tFIS_NFECF));
    putitem_o(tFIS_NF, 'NR_FATURA', item_f('NR_FATURA', tFIS_NFECF));
    putitem_o(tFIS_NF, 'DT_FATURA', item_a('DT_FATURA', tFIS_NFECF));
    retrieve_e(tFIS_NF);
    if (xStatus >=0) then begin
      setocc(tFIS_NFITEM, -1);
      setocc(tFIS_NFITEM, 1);
      while (xStatus >=0) do begin
        voParams := setDisplay(viParams); (* 'Gerando NFP: registro E15', '', '' *)
        if (xStatus < 0) then begin
          Result := voParams;
          return(-1); exit;
        end;

        gvDsConteudo := '' + gvDsConteudoE + '15';

        vDsNumeroSerie := item_f('CD_SERIEFAB', tFIS_ECF);
        voParams := espacoDireita(viParams); (* vDsNumeroSerie, 20, vDsNumeroSerie *)
        gvDsConteudo := '' + gvDsConteudo' + vDsNumeroSerie' + ' + ';

        vDsMfAdicional := '';
        voParams := espacoDireita(viParams); (* vDsMfAdicional, 1, vDsMfAdicional *)
        gvDsConteudo := '' + gvDsConteudo' + vDsMfAdicional' + ' + ';

        clear_e(tFIS_MODELOECF);
        putitem_o(tFIS_MODELOECF, 'CD_MARCA', item_f('CD_MARCA', tFIS_MARCAECF));
        putitem_o(tFIS_MODELOECF, 'CD_MODELO', item_f('CD_MODELO', tFIS_ECFMOD));
        retrieve_e(tFIS_MODELOECF);
        vModelo := item_a('DS_MODELO', tFIS_MODELOECF)[1:20];
        voParams := espacoDireita(viParams); (* vModelo, 20, vModelo *)
        gvDsConteudo := '' + gvDsConteudo' + vModelo' + ' + ';

        vNumeroUsuario := '1';
        voParams := preencheZero(viParams); (* vNumeroUsuario, 2, vNumeroUsuario *)
        gvDsConteudo := '' + gvDsConteudo' + vNumeroUsuario' + ' + ';

        vContatorDocumento := item_f('NR_CUPOM', tFIS_NFECF);
        voParams := preencheZero(viParams); (* vContatorDocumento, 6, vContatorDocumento *)
        gvDsConteudo := '' + gvDsConteudo' + vContatorDocumento' + ' + ';

        vContatorDocumentoEmitido := '';
        voParams := preencheZero(viParams); (* vContatorDocumentoEmitido, 6, vContatorDocumentoEmitido *)
        gvDsConteudo := '' + gvDsConteudo' + vContatorDocumentoEmitido' + ' + ';

        vNumItem := item_f('NR_ITEM', tFIS_NFITEM);
        voParams := preencheZero(viParams); (* vNumItem, 3, vNumItem *)
        gvDsConteudo := '' + gvDsConteudo' + vNumItem' + ' + ';

        vCodigoProduto := item_f('CD_PRODUTO', tFIS_NFITEM);
        voParams := preencheZero(viParams); (* vCodigoProduto, 14, vCodigoProduto *)
        gvDsConteudo := '' + gvDsConteudo' + vCodigoProduto' + ' + ';

        vDescProduto := item_a('DS_PRODUTO', tFIS_NFITEM)[1:100];
        voParams := espacoDireita(viParams); (* vDescProduto, 100, vDescProduto *)
        gvDsConteudo := '' + gvDsConteudo' + vDescProduto' + ' + ';

        vQuantidade := item_f('QT_FATURADO', tFIS_NFITEM);
        voParams := formataCampoComDecimal(viParams); (* (viParams); (* vQuantidade), 5, 2, vQuantidade *)
        gvDsConteudo := '' + gvDsConteudo' + vQuantidade' + ' + ';

        vUnidade := item_f('CD_ESPECIE', tFIS_NFITEM)[1:3];
        voParams := espacoDireita(viParams); (* vUnidade, 3, vUnidade *)
        gvDsConteudo := '' + gvDsConteudo' + vUnidade' + ' + ';

        vValorUnitario := item_f('VL_UNITBRUTO', tFIS_NFITEM);
        voParams := formataCampoComDecimal(viParams); (* (viParams); (* vValorUnitario), 6, 2, vValorUnitario *)
        gvDsConteudo := '' + gvDsConteudo' + vValorUnitario' + ' + ';

        vValorDesconto := item_f('VL_TOTALDESC', tFIS_NFITEM);
        voParams := formataCampoComDecimal(viParams); (* (viParams); (* vValorDesconto), 6, 2, vValorDesconto *)
        gvDsConteudo := '' + gvDsConteudo' + vValorDesconto' + ' + ';

        vAcrescimoItem := '0';
        voParams := preencheZero(viParams); (* vAcrescimoItem, 8, vAcrescimoItem *)
        gvDsConteudo := '' + gvDsConteudo' + vAcrescimoItem' + ' + ';

        vTotalLiquido := item_f('VL_TOTALLIQUIDO', tFIS_NFITEM);
        voParams := formataCampoComDecimal(viParams); (* (viParams); (* vTotalLiquido), 12, 2, vTotalLiquido *)
        gvDsConteudo := '' + gvDsConteudo' + vTotalLiquido' + ' + ';

        if (item_f('TP_SITUACAO', tFIS_NF) = 'C') then begin
          vTotalizadorParcial := 'Can-T';
          voParams := espacoDireita(viParams); (* vTotalizadorParcial, 7, vTotalizadorParcial *)
          gvDsConteudo := '' + gvDsConteudo' + vTotalizadorParcial' + ' + ';
        end else begin
          clear_e(tFIS_NFITEMIMPOST);
          putitem_o(tFIS_NFITEMIMPOST, 'CD_EMPRESA', item_f('CD_EMPRESA', tFIS_NFITEM));
          putitem_o(tFIS_NFITEMIMPOST, 'NR_FATURA', item_f('NR_FATURA', tFIS_NFITEM));
          putitem_o(tFIS_NFITEMIMPOST, 'DT_FATURA', item_a('DT_FATURA', tFIS_NFITEM));
          putitem_o(tFIS_NFITEMIMPOST, 'NR_ITEM', item_f('NR_ITEM', tFIS_NFITEM));
          retrieve_e(tFIS_NFITEMIMPOST);
          if (item_f('CD_IMPOSTO', tFIS_NFITEMIMPOST) = 2) then begin
            vAuxiliar := 'F';
            vTotalizadorParcial := '' + vAuxiliar + '1';
            voParams := espacoDireita(viParams); (* vTotalizadorParcial, 7, vTotalizadorParcial *)
            gvDsConteudo := '' + gvDsConteudo' + vTotalizadorParcial' + ' + ';
          end else if (item_f('CD_CST', tFIS_NFITEM) <> 040 ) or (item_f('CD_CST', tFIS_NFITEM) <> 041) then begin
            vAuxiliar := '01T';
            vTotalizadorParcial := '' + vAuxiliar' + PR_ALIQUOTA + ' + '.FIS_NFITEMIMPOST';
            vTotalizadorParcial= greplace(vTotalizadorParcial, 1, ', ', '', -1);
            voParams := espacoDireita(viParams); (* vTotalizadorParcial, 7, vTotalizadorParcial *)
            gvDsConteudo := '' + gvDsConteudo' + vTotalizadorParcial' + ' + ';
          end else if (item_f('CD_CST', tFIS_NFITEM) = 040) then begin
            vAuxiliar := 'I';
            vTotalizadorParcial := '' + vAuxiliar + '1';
            voParams := espacoDireita(viParams); (* vTotalizadorParcial, 7, vTotalizadorParcial *)
            gvDsConteudo := '' + gvDsConteudo' + vTotalizadorParcial' + ' + ';
          end else if (item_f('CD_CST', tFIS_NFITEM) = 041) then begin
            vAuxiliar := 'N';
            vTotalizadorParcial := '' + vAuxiliar + '1';
            voParams := espacoDireita(viParams); (* vTotalizadorParcial, 7, vTotalizadorParcial *)
            gvDsConteudo := '' + gvDsConteudo' + vTotalizadorParcial' + ' + ';
          end;
        end;

          vIndicadorCancelamento := 'N';
          voParams := espacoDireita(viParams); (* vIndicadorCancelamento, 1, vIndicadorCancelamento *)
          gvDsConteudo := '' + gvDsConteudo' + vIndicadorCancelamento' + ' + ';

          vQuantidadeCancelada := '0';
          voParams := preencheZero(viParams); (* vQuantidadeCancelada, 7, vQuantidadeCancelada *)
          gvDsConteudo := '' + gvDsConteudo' + vQuantidadeCancelada' + ' + ';

          vValorCancelado := '0';
          voParams := preencheZero(viParams); (* vValorCancelado, 13, vValorCancelado *)
          gvDsConteudo := '' + gvDsConteudo' + vValorCancelado' + ' + ';

        vCancelamentoAcrescimoItem := '0';
        voParams := preencheZero(viParams); (* vCancelamentoAcrescimoItem, 13, vCancelamentoAcrescimoItem *)
        gvDsConteudo := '' + gvDsConteudo' + vCancelamentoAcrescimoItem' + ' + ';

        vRegraCalculo := 'A';
        voParams := espacoDireita(viParams); (* vRegraCalculo, 1, vRegraCalculo *)
        gvDsConteudo := '' + gvDsConteudo' + vRegraCalculo' + ' + ';

        vCasaDecimalQuant := '2';
        voParams := preencheZero(viParams); (* vCasaDecimalQuant, 1, vCasaDecimalQuant *)
        gvDsConteudo := '' + gvDsConteudo' + vCasaDecimalQuant' + ' + ';

        vCasaDecimalValor := '2';
        voParams := preencheZero(viParams); (* vCasaDecimalValor, 1, vCasaDecimalValor *)
        gvDsConteudo := '' + gvDsConteudo' + vCasaDecimalValor' + ' + ';

        setocc(tFIS_NFITEM, curocc(tFIS_NFITEM) + 1);
      end;
    end;
    setocc(tFIS_NFECF, curocc(tFIS_NFECF) + 1);
  end;

  return(0); exit;
end;

//----------------------------------------------------------------------
function TF_ECFFP007.gerarNotaFiscalPaulista(pParams : String) : String;
//----------------------------------------------------------------------
const
  cDS_METHOD = 'ADICIONAL=Operação: TF_ECFFP007.gerarNotaFiscalPaulista()';
var
  vDsPath, vDsTipoArquivo, vDsAux : String;
  vInErro, vGerarArq : Boolean;
begin
  if (item_f('CD_EMPRESA', tSIS_DUMMY) = '') then begin
    Result := SetStatus(STS_AVISO, 'GEN001', 'Informar empresa para gerar Nota Fiscal Paulista.', cDS_METHOD);
    gprompt := item_f('CD_EMPRESA', tSIS_DUMMY);
    return(-1); exit;
  end;
  if (item_a('DT_INICIAL', tSIS_DUMMY) = '') then begin
    Result := SetStatus(STS_AVISO, 'GEN001', 'Informar intervalo de período.', cDS_METHOD);
    gprompt := item_a('DT_INICIAL', tSIS_DUMMY);
    return(-1); exit;
  end;
  voParams := validaIntervaloData(viParams); (* *)
  if (xStatus < 0) then begin
    Result := voParams;
    return(-1); exit;
  end;
  if (item_a('DS_CAMINHO', tSIS_DUMMY) = '') then begin
    Result := SetStatus(STS_AVISO, 'GEN001', 'Informar o arquivo para gerar Nota Fiscal Paulista.', cDS_METHOD);
    gprompt := item_a('DS_CAMINHO', tSIS_DUMMY);
    return(-1); exit;
  end;

  vDsTipoArquivo := '';

  setocc(tFIS_REDZM, 1);
  while (xStatus>=0) do begin
    vInErro := False;

    if (item_b('IN_MARCAR', tFIS_REDZM) = True) then begin
      vGerarArq := True;
      voParams := gerarE00(viParams); (* *)
      if (xStatus < 0) then begin
        Result := voParams;
        return(-1); exit;
      end;

      voParams := gerarE01(viParams); (* *)
      if (xStatus < 0) then begin
        Result := voParams;
        return(-1); exit;
      end;

      voParams := gerarE02(viParams); (* *)
      if (xStatus < 0) then begin
        Result := voParams;
        return(-1); exit;
      end;

      voParams := gerarE12(viParams); (* *)
      if (xStatus < 0) then begin
        Result := voParams;
        return(-1); exit;
      end;

      voParams := gerarE13(viParams); (* *)
      if (xStatus < 0) then begin
        Result := voParams;
        return(-1); exit;
      end;

      voParams := gerarE14(viParams); (* *)
      if (xStatus < 0) then begin
        Result := voParams;
        return(-1); exit;
      end;

      voParams := gerarE15(viParams); (* *)
      if (xStatus < 0) then begin
        Result := voParams;
        return(-1); exit;
      end;

      vDsAux := gvDsConteudo[1:2000];
      voParams := geraEAD(viParams); (* vDsAux *)
      if (xStatus < 0) then begin
        Result := voParams;
        return(-1); exit;
      end;
    end;
    setocc(tFIS_REDZM, curocc(tFIS_REDZM) + 1);
  end;
  if (vGerarArq = True) then begin
    if (vInErro = False) then begin
      Result := SetStatus(<STS_INFO>, 'GEN001', 'Arquivo de nota fiscal paulista gerado com sucesso.', cDS_METHOD);
    end else begin
      Result := SetStatus(STS_ERROR, 'GEN001', 'Erro na geração do arquivo de nota fiscal Paulista. ' + vDsTipoArquivo', + ' cDS_METHOD);
    end;
  end;

  voParams := valorPadrao(viParams); (* *)
  if (xStatus < 0) then begin
    Result := voParams;
    return(-1); exit;
  end;

  gprompt := item_f('CD_EMPRESA', tSIS_DUMMY);

  return(0); exit;
end;

//--------------------------------------------------------------
function TF_ECFFP007.geraNomeArquivo(pParams : String) : String;
//--------------------------------------------------------------
const
  cDS_METHOD = 'ADICIONAL=Operação: TF_ECFFP007.geraNomeArquivo()';
var
  (* string piDtEmissao : IN / string piDsMarca : IN / string piDsModelo : IN / string piNrSerie : IN / string poDsArquivo : OUT *)
  viParams, voParams : String;
begin
  viParams := '';

  putitemXml(viParams, 'DT_EMISSAO', piDtEmissao);
  putitemXml(viParams, 'DS_MARCA', piDsMarca);
  putitemXml(viParams, 'DS_MODELO', piDsModelo);
  putitemXml(viParams, 'NR_SERIE', piNrSerie);
  voParams := activateCmp('SISSVCO012', 'Execute', viParams); (*,,,, *)
  if (xStatus < 0) then begin
    Result := voParams;
    return(-1); exit;
  end;

  poDsArquivo := itemXml('DS_ARQUIVO', voParams);

  return(0); exit;
end;

//------------------------------------------------------
function TF_ECFFP007.geraEAD(pParams : String) : String;
//------------------------------------------------------
const
  cDS_METHOD = 'ADICIONAL=Operação: TF_ECFFP007.geraEAD()';
var
  (* string piDsArquivo : IN *)
  viParams, voParams, vCodRSA, vEOF : String;
  vFlag : Boolean;
begin
  viParams := '';

  putitemXml(viParams, 'DS_ARQUIVO', piDsArquivo);
  voParams := activateCmp('SISSVCO012', 'Execute', viParams); (*,,,, *)
  if (xStatus < 0) then begin
    Result := voParams;
    return(-1); exit;
  end;

  vCodRSA := itemXml('DS_ARQUIVO', voParams);

  gvDsConteudo := '' + gvDsConteudoEAD' + vCodRSA' + ' + ';

  voParams := activateCmp('vbfileman', 'arqexiste', viParams); (*vFlag,'' + gvDsPath' + gnomeArquivo' + ' + ' *)
  if (vFlag = True) then begin
    voParams := activateCmp('vbfileman', 'apagaarquivo', viParams); (*'' + gvDsConteudo','' + gvDsPath' + gnomeArquivo' + ' + ' + ' *)
  end;

  filedump/append '' + gvDsConteudo', + ' '' + gvDsPath' + gnomeArquivo + ' + '.TMP';

  voParams := activateCmp('vbfileman', 'movearquivo', viParams); (*vEOF,'' + gvDsPath' + gnomeArquivo + ' + '.TMP','' + gvDsPath' + gnomeArquivo' + ' + ' *)
  if (xStatus < 0) then begin
    Result := voParams;
    return(-1); exit;
  end;

  return(0); exit;
end;

end.
