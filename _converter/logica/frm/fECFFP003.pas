unit fECFFP003;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, fFormTouch, ExtCtrls, cPanel, cDatasetUnf, fDialogTouch;

type
  TF_ECFFP003 = class(T_FormTouch)
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
  private
    tSIS_FORMAPGTO : TcDatasetUnf;
    function getParam(pParams : String = '') : String;
    function setEntidade(pParams : String = '') : String;
    function preEDIT(pParams : String = '') : String;
    function posEDIT(pParams : String = '') : String;
    function preEDIT(pParams : String = '') : String;
    function carregaLista(pParams : String = '') : String;
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
  gDsLstFormaPgto : String;

procedure TF_ECFFP003.FormCreate(Sender: TObject);
begin
  inherited; //
  setEntidade();
end;

procedure TF_ECFFP003.FormShow(Sender: TObject);
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

procedure TF_ECFFP003.FormActivate(Sender: TObject);
begin
  inherited; //
end;

procedure TF_ECFFP003.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  inherited; //
end;

//---------------------------------------------------------------
function TF_ECFFP003.getParam(pParams : String = '') : String;
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
function TF_ECFFP003.setEntidade(pParams : String = '') : String;
//---------------------------------------------------------------
begin
  tSIS_FORMAPGTO := TcDatasetUnf.GetEntidade(Self, 'SIS_FORMAPGTO');
end;

//---------------------------------------------------------------
function TF_ECFFP003.preEDIT(pParams : String) : String;
//---------------------------------------------------------------
const
  cDS_METHOD = 'ADICIONAL=Operação: TF_ECFFP003.preEDIT()';
begin
  return(0); exit;
end;

//---------------------------------------------------------------
function TF_ECFFP003.posEDIT(pParams : String) : String;
//---------------------------------------------------------------
const
  cDS_METHOD = 'ADICIONAL=Operação: TF_ECFFP003.posEDIT()';
begin
  return(0); exit;
end;

//------------------------------------------------------
function TF_ECFFP003.preEDIT(pParams : String) : String;
//------------------------------------------------------
const
  cDS_METHOD = 'ADICIONAL=Operação: TF_ECFFP003.preEDIT()';
begin
  gDsLstFormaPgto := itemXml('DS_LSTFORMAPGTO', viParams);
  if (gDsLstFormaPgto = '') then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Lista de formas de pagamento não informada!', cDS_METHOD);
    return(-1); exit;
  end;
  voParams := carregaLista(viParams); (* *)
  if (xStatus < 0) then begin
    return(-1); exit;
  end;
  return(0); exit;
end;

//-----------------------------------------------------------
function TF_ECFFP003.carregaLista(pParams : String) : String;
//-----------------------------------------------------------
const
  cDS_METHOD = 'ADICIONAL=Operação: TF_ECFFP003.carregaLista()';
var
  vDsLstFormaPgto, vDsRegistro : String;
begin
  vDsLstFormaPgto := gDsLstFormaPgto;
  repeat
    getitem(vDsRegistro, vDsLstFormaPgto, 1);
    creocc(tSIS_FORMAPGTO, -1);
    putitem_e(tSIS_FORMAPGTO, 'DS_FORMAPGTO', vDsRegistro);
    delitem(vDsLstFormaPgto, 1);
  until (vDsLstFormaPgto = '');
  setocc(tSIS_FORMAPGTO, 1);
  return(0); exit;
end;

end.
