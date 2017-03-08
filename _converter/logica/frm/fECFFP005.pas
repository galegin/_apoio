unit fECFFP005;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, fFormTouch, ExtCtrls, cPanel, cDatasetUnf, fDialogTouch;

type
  TF_ECFFP005 = class(T_FormTouch)
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
  private
    tSIS_FILTRO : TcDatasetUnf;
    function getParam(pParams : String = '') : String;
    function setEntidade(pParams : String = '') : String;
    function preEDIT(pParams : String = '') : String;
    function posEDIT(pParams : String = '') : String;
    function preEDIT(pParams : String = '') : String;
    function INIT(pParams : String = '') : String;
    function valorPadrao(pParams : String = '') : String;
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
  gDataFIM,
  gDataINI : String;

procedure TF_ECFFP005.FormCreate(Sender: TObject);
begin
  inherited; //
  setEntidade();
end;

procedure TF_ECFFP005.FormShow(Sender: TObject);
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

procedure TF_ECFFP005.FormActivate(Sender: TObject);
begin
  inherited; //
end;

procedure TF_ECFFP005.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  inherited; //
end;

//---------------------------------------------------------------
function TF_ECFFP005.getParam(pParams : String = '') : String;
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
function TF_ECFFP005.setEntidade(pParams : String = '') : String;
//---------------------------------------------------------------
begin
  tSIS_FILTRO := TcDatasetUnf.GetEntidade(Self, 'SIS_FILTRO');
end;

//---------------------------------------------------------------
function TF_ECFFP005.preEDIT(pParams : String) : String;
//---------------------------------------------------------------
const
  cDS_METHOD = 'ADICIONAL=Operação: TF_ECFFP005.preEDIT()';
begin
  return(0); exit;
end;

//---------------------------------------------------------------
function TF_ECFFP005.posEDIT(pParams : String) : String;
//---------------------------------------------------------------
const
  cDS_METHOD = 'ADICIONAL=Operação: TF_ECFFP005.posEDIT()';
begin
  return(0); exit;
end;

//------------------------------------------------------
function TF_ECFFP005.preEDIT(pParams : String) : String;
//------------------------------------------------------
const
  cDS_METHOD = 'ADICIONAL=Operação: TF_ECFFP005.preEDIT()';
begin
  voParams := valorPadrao(viParams); (* *)
  if (xStatus < 0) then begin
    Result := voParams;
    return(-1); exit;
  end;
  return(0); exit;
end;

//---------------------------------------------------
function TF_ECFFP005.INIT(pParams : String) : String;
//---------------------------------------------------
const
  cDS_METHOD = 'ADICIONAL=Operação: TF_ECFFP005.INIT()';
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
function TF_ECFFP005.valorPadrao(pParams : String) : String;
//----------------------------------------------------------
const
  cDS_METHOD = 'ADICIONAL=Operação: TF_ECFFP005.valorPadrao()';
var
  viParams, voParams, vDsPath : String;
begin
  _Caption := '' + ECFFP + '005 - Atualiza Memória da Fita - ECF';

  if (itemXml('PADRAO_ECF', PARAM_GLB) = <PADRAO_LOCALIMPFIM>) then begin
    viParams := '';
    voParams := activateCmp('ECFSVCO011', 'retornaPathECF', viParams); (*,,,, *)
    if (xStatus < 0) then begin
      Result := voParams;
      return(-1); exit;
    end;

    putitem_o(tSIS_FILTRO, 'DS_DIRETORIODESTINO', itemXml('DS_PATH', voParams));
    fieldsyntax 'item_a('BT_LISTADIR', tSIS_FILTRO)', 'DIM';
    fieldsyntax 'item_a('DS_DIRETORIODESTINO', tSIS_FILTRO)', 'DIM';
  end else begin
    putitem_o(tSIS_FILTRO, 'DS_DIRETORIODESTINO', 'C:\');
    fieldsyntax 'item_a('BT_LISTADIR', tSIS_FILTRO)', '';
    fieldsyntax 'item_a('DS_DIRETORIODESTINO', tSIS_FILTRO)', '';
  end;
  putitem_o(tSIS_FILTRO, 'DS_ARQUIVODESTINO', 'DOWNLOAD.MFD');
  putitem_o(tSIS_FILTRO, 'RD_TPDOWNLOAD', 1);
  putitem_o(tSIS_FILTRO, 'NR_COOINI', 1);
  putitem_o(tSIS_FILTRO, 'NR_COOFIM', 1);
  putitem_o(tSIS_FILTRO, 'NR_USUARIO', 1);
  fieldsyntax 'item_f('NR_COOINI', tSIS_FILTRO)', 'DIM';
  fieldsyntax 'item_f('NR_COOFIM', tSIS_FILTRO)', 'DIM';
  fieldsyntax 'item_f('NR_USUARIO', tSIS_FILTRO)', 'DIM';
  fieldsyntax 'item_a('DT_DATAINI', tSIS_FILTRO)', '';
  fieldsyntax 'item_a('DT_DATAFIM', tSIS_FILTRO)', '';
  putitem_o(tSIS_FILTRO, 'RD_TPFORMATO', 3);
  return(0); exit;
end;

//----------------------------------------------------------
function TF_ECFFP005.downloadMFD(pParams : String) : String;
//----------------------------------------------------------
const
  cDS_METHOD = 'ADICIONAL=Operação: TF_ECFFP005.downloadMFD()';
var
  viParams, voParams : String;
  vTpRelatorio : Real;
begin
  message/hint 'Efetuando download da MFD...';
  viParams := '';

  putitemXml(viParams, 'DS_ARQUIVO', '' + item_a('DS_DIRETORIODESTINO', tSIS_FILTRO) + '' + item_a('DS_ARQUIVODESTINO', tSIS_FILTRO) + '');
  if (item_a('RD_TPDOWNLOAD', tSIS_FILTRO) = 1) then begin
    gDataINI := item_a('DT_DATAINI', tSIS_FILTRO);
    gDataFIM := item_a('DT_DATAFIM', tSIS_FILTRO);
    putitemXml(viParams, 'TP_DOWNLOAD', '1');
    putitemXml(viParams, 'DS_DADOINI', '' + gDataINI') + ';
    putitemXml(viParams, 'DS_DADOFIM', '' + gDataFIM') + ';
  end else if (item_a('RD_TPDOWNLOAD', tSIS_FILTRO) = 2) then begin
    putitemXml(viParams, 'TP_DOWNLOAD', '2');
    putitemXml(viParams, 'DS_DADOINI', item_f('NR_COOINI', tSIS_FILTRO));
    putitemXml(viParams, 'DS_DADOFIM', item_f('NR_COOFIM', tSIS_FILTRO));
    putitemXml(viParams, 'NR_USUARIO', item_f('NR_USUARIO', tSIS_FILTRO));

  end else begin
    putitemXml(viParams, 'TP_DOWNLOAD', '0');
  end;
  putitemXml(viParams, 'TP_FORMATO', item_a('RD_TPFORMATO', tSIS_FILTRO));

  voParams := activateCmp('ECFSVCO001', 'downloadMFD', viParams); (*,,, *)
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

end.
