unit fECFFP004;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, fFormTouch, ExtCtrls, cPanel, cDatasetUnf, fDialogTouch;

type
  TF_ECFFP004 = class(T_FormTouch)
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
  private
    tGER_EMPRESA,
    tGLB_LOGRADOURO,
    tGLB_MUNICIPIO,
    tPES_CONTATO,
    tPES_ENDERECO,
    tPES_PESSOA,
    tPES_TELEFONE,
    tSIS_ARQUIVOMFD,
    tSIS_TPSINTEGRA : TcDatasetUnf;
    function getParam(pParams : String = '') : String;
    function setEntidade(pParams : String = '') : String;
    function preEDIT(pParams : String = '') : String;
    function posEDIT(pParams : String = '') : String;
    function preEDIT(pParams : String = '') : String;
    function INIT(pParams : String = '') : String;
    function valorPadrao(pParams : String = '') : String;
    function geraRelatorioSintegra(pParams : String = '') : String;
    function downloadMFD(pParams : String = '') : String;
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
  gMES,
  gUFOrigem,
  gVl2Dig,
  gVl4Dig : String;

procedure TF_ECFFP004.FormCreate(Sender: TObject);
begin
  inherited; //
  setEntidade();
end;

procedure TF_ECFFP004.FormShow(Sender: TObject);
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

procedure TF_ECFFP004.FormActivate(Sender: TObject);
begin
  inherited; //
end;

procedure TF_ECFFP004.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  inherited; //
end;

//---------------------------------------------------------------
function TF_ECFFP004.getParam(pParams : String = '') : String;
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
function TF_ECFFP004.setEntidade(pParams : String = '') : String;
//---------------------------------------------------------------
begin
  tGER_EMPRESA := TcDatasetUnf.GetEntidade(Self, 'GER_EMPRESA');
  tGLB_LOGRADOURO := TcDatasetUnf.GetEntidade(Self, 'GLB_LOGRADOURO');
  tGLB_MUNICIPIO := TcDatasetUnf.GetEntidade(Self, 'GLB_MUNICIPIO');
  tPES_CONTATO := TcDatasetUnf.GetEntidade(Self, 'PES_CONTATO');
  tPES_ENDERECO := TcDatasetUnf.GetEntidade(Self, 'PES_ENDERECO');
  tPES_PESSOA := TcDatasetUnf.GetEntidade(Self, 'PES_PESSOA');
  tPES_TELEFONE := TcDatasetUnf.GetEntidade(Self, 'PES_TELEFONE');
  tSIS_ARQUIVOMFD := TcDatasetUnf.GetEntidade(Self, 'SIS_ARQUIVOMFD');
  tSIS_TPSINTEGRA := TcDatasetUnf.GetEntidade(Self, 'SIS_TPSINTEGRA');
end;

//---------------------------------------------------------------
function TF_ECFFP004.preEDIT(pParams : String) : String;
//---------------------------------------------------------------
const
  cDS_METHOD = 'ADICIONAL=Operação: TF_ECFFP004.preEDIT()';
begin
  return(0); exit;
end;

//---------------------------------------------------------------
function TF_ECFFP004.posEDIT(pParams : String) : String;
//---------------------------------------------------------------
const
  cDS_METHOD = 'ADICIONAL=Operação: TF_ECFFP004.posEDIT()';
begin
  return(0); exit;
end;

//------------------------------------------------------
function TF_ECFFP004.preEDIT(pParams : String) : String;
//------------------------------------------------------
const
  cDS_METHOD = 'ADICIONAL=Operação: TF_ECFFP004.preEDIT()';
begin
  voParams := valorPadrao(viParams); (* *)
  if (xStatus < 0) then begin
    Result := voParams;
    return(-1); exit;
  end;
  return(0); exit;
end;

//---------------------------------------------------
function TF_ECFFP004.INIT(pParams : String) : String;
//---------------------------------------------------
const
  cDS_METHOD = 'ADICIONAL=Operação: TF_ECFFP004.INIT()';
var
  viParams, voParams : String;
  vPadraoECF, vCdEmpresa : Real;
begin
  if (itemXml('PADRAO_ECF', PARAM_GLB) <> '') then begin
    return(0); exit;
  end;

  viParams := '';

  vCdEmpresa := itemXmlF('CD_EMPRESA', PARAM_GLB);
    putitem(viParams,  'PADRAO_ECF');
    xParamEmp := T_ADMSVCO001.GetParamEmpresa(piCdEmpresa, xParamEmp); (*vCdEmpresa,,,, *)
  vPadraoECF := itemXml('PADRAO_ECF', voParams);
  putitemXml(PARAM_GLB, 'PADRAO_ECF', vPadraoECF);

end;

//----------------------------------------------------------
function TF_ECFFP004.valorPadrao(pParams : String) : String;
//----------------------------------------------------------
const
  cDS_METHOD = 'ADICIONAL=Operação: TF_ECFFP004.valorPadrao()';
begin
  _Caption := '' + ECFFP + '004 - Gera Relatório Sintegra/MFD';

  clear_e(tGER_EMPRESA);
  putitem_o(tGER_EMPRESA, 'CD_EMPRESA', itemXmlF('CD_EMPRESA', PARAM_GLB));
  retrieve_e(tGER_EMPRESA);
  if (xStatus >= 0) then begin
    clear_e(tPES_PESSOA);
    putitem_o(tPES_PESSOA, 'CD_PESSOA', item_f('CD_PESSOA', tGER_EMPRESA));
    retrieve_e(tPES_PESSOA);
  end;

  putitem_o(tPES_PESSOA, 'TP_LEITURAMFD', 1);

    gMES := Date[M] - 1;
  putitem_o(tPES_PESSOA, 'NR_MESANO', '01/' + gMES + '/' + Date[Y]' + ');

  if (itemXml('PADRAO_ECF', PARAM_GLB) = <PADRAO_LOCALIMPFIM>) then begin
    putitem_o(tPES_PESSOA, 'DS_DIRETORIO', 'C:\ECF\');
    fieldsyntax 'item_a('BT_LISTADIR', tPES_PESSOA)', 'DIM';
    fieldsyntax 'item_a('DS_DIRETORIO', tPES_PESSOA)', 'DIM';
    fieldsyntax 'item_f('TP_LEITURAMFD', tPES_PESSOA)', 'DIM';
  end else begin
    putitem_o(tPES_PESSOA, 'DS_DIRETORIO', 'C:\');
    fieldsyntax 'item_a('BT_LISTADIR', tPES_PESSOA)', '';
    fieldsyntax 'item_a('DS_DIRETORIO', tPES_PESSOA)', '';
    fieldsyntax 'item_f('TP_LEITURAMFD', tPES_PESSOA)', '';
  end;

  putitem_o(tPES_PESSOA, 'DS_ARQUIVO', 'SINTEGRA.TXT');
  putitem_e(tSIS_TPSINTEGRA, 'IN_TIPO60M', True);
  putitem_e(tSIS_TPSINTEGRA, 'IN_TIPO60A', True);
  putitem_e(tSIS_TPSINTEGRA, 'IN_TIPO60D', True);
  putitem_e(tSIS_TPSINTEGRA, 'IN_TIPO60I', True);
  putitem_e(tSIS_TPSINTEGRA, 'IN_TIPO60R', True);
  putitem_e(tSIS_TPSINTEGRA, 'IN_TIPO75', True);
  fieldsyntax 'item_a('DS_ARQUIVO', tSIS_ARQUIVOMFD)', 'DIM';
  fieldsyntax 'item_a('BT_LISTAMFD', tSIS_ARQUIVOMFD)', 'DIM';
  gUFOrigem := itemXml('UF_ORIGEM', PARAM_GLB);
  if (gUFOrigem = 'AM') then begin
    fieldsyntax 'item_b('IN_TIPO60M', tSIS_TPSINTEGRA)', 'DIM';
    fieldsyntax 'item_b('IN_TIPO60A', tSIS_TPSINTEGRA)', 'DIM';
    fieldsyntax 'item_b('IN_TIPO60D', tSIS_TPSINTEGRA)', 'DIM';
    fieldsyntax 'item_b('IN_TIPO60I', tSIS_TPSINTEGRA)', 'DIM';
    fieldsyntax 'item_b('IN_TIPO60R', tSIS_TPSINTEGRA)', 'DIM';
  end;
  return(0); exit;
end;

//--------------------------------------------------------------------
function TF_ECFFP004.geraRelatorioSintegra(pParams : String) : String;
//--------------------------------------------------------------------
const
  cDS_METHOD = 'ADICIONAL=Operação: TF_ECFFP004.geraRelatorioSintegra()';
var
  viParams, voParams : String;
  vTpRelatorio : Real;
begin
  vTpRelatorio := 0;
  if (item_b('IN_TIPO60M', tSIS_TPSINTEGRA) = True) then begin
    vTpRelatorio := vTpRelatorio + 1;
  end;
  if (item_b('IN_TIPO60A', tSIS_TPSINTEGRA) = True) then begin
    vTpRelatorio := vTpRelatorio + 2;
  end;
  if (item_b('IN_TIPO60D', tSIS_TPSINTEGRA) = True) then begin
    vTpRelatorio := vTpRelatorio + 4;
  end;
  if (item_b('IN_TIPO60I', tSIS_TPSINTEGRA) = True) then begin
    vTpRelatorio := vTpRelatorio + 8;
  end;
  if (item_b('IN_TIPO60R', tSIS_TPSINTEGRA) = True) then begin
    vTpRelatorio := vTpRelatorio + 16;
  end;
  if (item_b('IN_TIPO75', tSIS_TPSINTEGRA) = True) then begin
    vTpRelatorio := vTpRelatorio + 32;
  end;

  gVl2Dig := item_f('NR_MESANO', tPES_PESSOA)[M];
    gVl4Dig := item_f('NR_MESANO', tPES_PESSOA)[Y];

  message/hint 'Processando dados sintegra...';
  viParams := '';

  putitemXml(viParams, 'DS_ARQUIVOMFD', item_a('DS_ARQUIVO', tSIS_ARQUIVOMFD));
  putitemXml(viParams, 'TP_RELATORIO', vTpRelatorio);
  putitemXml(viParams, 'DS_ARQUIVO', '' + item_a('DS_DIRETORIO', tPES_PESSOA) + '' + item_a('DS_ARQUIVO', tPES_PESSOA) + '');
  putitemXml(viParams, 'NR_MES', '' + FloatToStr(gVl) + '2Dig');
  putitemXml(viParams, 'NR_ANO', '' + FloatToStr(gVl) + '4Dig');
  putitemXml(viParams, 'DS_RAZAOSOCIAL', item_a('NM_PESSOA', tPES_PESSOA));
  putitemXml(viParams, 'DS_endERECO', item_a('NM_LOGRADOURO', tPES_ENDERECO));
  putitemXml(viParams, 'NR_endERECO', item_f('NR_LOGRADOURO', tPES_ENDERECO));
  putitemXml(viParams, 'DS_COMPLEMENTO', item_a('DS_COMPLEMENTO', tPES_ENDERECO));
  putitemXml(viParams, 'DS_BAIRRO', item_a('DS_BAIRRO', tPES_ENDERECO));
  putitemXml(viParams, 'DS_CIDADE', item_a('NM_MUNICIPIO', tGLB_MUNICIPIO));
  putitemXml(viParams, 'DS_CEP', item_f('CD_CEP', tGLB_LOGRADOURO));
  putitemXml(viParams, 'NR_TELEFONE', item_f('NR_TELEFONE', tPES_TELEFONE));
  putitemXml(viParams, 'NR_FAX', item_f('NR_TELEFONE', tPES_TELEFONE));
  putitemXml(viParams, 'DS_CONTATO', item_a('NM_CONTATO', tPES_CONTATO));
  if (item_f('TP_LEITURAMFD', tPES_PESSOA) = 1) then begin
    voParams := activateCmp('ECFSVCO001', 'relatorioSintegraMFD', viParams); (*,,, *)
  end else begin
    voParams := activateCmp('ECFSVCO001', 'geraRelatorioSintegraMFD', viParams); (*,,, *)
  end;
  if (xStatus < 0) then begin
    Result := voParams;
    return(-1); exit;
  end;
    putitemXml(viParams, 'TITULO', 'Erro de comunicação com a ECF');
    putitemXml(viParams, 'MENSAGEM', itemXml('DESCRICAO', xCtxErro));
    voParams := activateCmp('GERFP008', 'EXEC', viParams); (*,,, *)
    if (xStatus < 0) then begin
      Result := voParams;
      return(-1); exit;
    end;
    return(-1); exit;
  end else if (xStatus < 0) then begin
    Result := voParams;
    return(-1); exit;
  end;

  Result := SetStatus(<STS_INFO>, 'GEN0001', 'Processo concluído com sucesso.', cDS_METHOD);
  message/hint ' ';

  return(0); exit;
end;

//----------------------------------------------------------
function TF_ECFFP004.downloadMFD(pParams : String) : String;
//----------------------------------------------------------
const
  cDS_METHOD = 'ADICIONAL=Operação: TF_ECFFP004.downloadMFD()';
var
  viParams, voParams : String;
begin
  viParams := '';
  voParams := activateCmp('ECFFP005', 'EXEC', viParams); (*,,, *)
  if (xStatus < 0) then begin
    Result := voParams;
    return(-1); exit;
  end;

  return(0); exit;
end;

end.
