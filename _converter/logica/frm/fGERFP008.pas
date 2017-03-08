unit fGERFP008;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, fFormTouch, ExtCtrls, cPanel, cDatasetUnf;

type
  TF_GERFP008 = class(T_FormTouch)
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
  private
    tSIS_DUMMY : TcDatasetUnf;
    function getParam(pParams : String = '') : String;
    function setEntidade(pParams : String = '') : String;
    function preEDIT(pParams : String = '') : String;
    function posEDIT(pParams : String = '') : String;
    function preEDIT(pParams : String = '') : String;
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


procedure TF_GERFP008.FormCreate(Sender: TObject);
begin
  inherited; //
  setEntidade();
end;

procedure TF_GERFP008.FormShow(Sender: TObject);
var voParams : String;
begin
  inherited; //

  getParam(vpiParams);

  voParams := preEDIT(vpiParams);
  if (xStatus < 0) then begin
    MensagemTouchErro(itemXml('message', voParams) + #13 + itemXml('adic', voParams));
    TimerSair.Enabled := True;
    return(-1); exit;
  end;

  //recalcula();

  return(0); exit;
end;

procedure TF_GERFP008.FormActivate(Sender: TObject);
begin
  inherited; //
end;

procedure TF_GERFP008.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  inherited; //
end;

//---------------------------------------------------------------
function TF_GERFP008.getParam(pParams : String = '') : String;
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
function TF_GERFP008.setEntidade(pParams : String = '') : String;
//---------------------------------------------------------------
begin
  tSIS_DUMMY := TcDatasetUnf.GetEntidade(Self, 'SIS_DUMMY');
end;

//---------------------------------------------------------------
function TF_GERFP008.preEDIT(pParams : String) : String;
//---------------------------------------------------------------
const
  cDS_METHOD = 'ADICIONAL=Operação: TF_GERFP008.preEDIT()';
begin
  return(0); exit;
end;

//---------------------------------------------------------------
function TF_GERFP008.posEDIT(pParams : String) : String;
//---------------------------------------------------------------
const
  cDS_METHOD = 'ADICIONAL=Operação: TF_GERFP008.posEDIT()';
begin
  return(0); exit;
end;

//------------------------------------------------------
function TF_GERFP008.preEDIT(pParams : String) : String;
//------------------------------------------------------
const
  cDS_METHOD = 'ADICIONAL=Operação: TF_GERFP008.preEDIT()';
var
  vTitulo : String;
begin
  if (viParams = '') then begin
    message/info 'Componente não pode ser chamado pelo atalho!';
    return(0); exit;
  end;

  putitem_e(tSIS_DUMMY, 'DS_TITULO', itemXml('DS_TITULO', viParams));
  vTitulo := itemXml('TITULO', viParams);
  _Caption := '' + GERFP + '008 - ' + vTitulo' + ';
  putitem_e(tSIS_DUMMY, 'DS_MENSAGEM', itemXml('MENSAGEM', viParams));
  if (gModulo.GNMUSRSO = 'santarita')  and (gModulo.gcdempresa = 7) then begin
    putitem_e(tSIS_DUMMY, 'DS_MENSAGEM', 'Identificação do laudo: IFL0122009Nr. CNPJ              : 00.157.585/0001-58Razão social          : JOSE MARCOS NABHANendereço              : AV. GOIAS, SALA 21 - SOBRELOJANr. endereço          : 810Bairro                : CENTROContato               : MARCELIA FECCHIOTelefone              : 44 3619-4500Nome aplicativo       : STOREAGEVersão                : 3.0Nome executável       : STOREAGE.EXECódigo MD5            : 707499a18b5bb9b8c623633d0fb0ccd6');
  end;

  return(0); exit;
end;

end.
