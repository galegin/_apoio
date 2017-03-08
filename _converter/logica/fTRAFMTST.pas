unit fTRAFMTST;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, fFormTouch, ExtCtrls, cPanel, cDatasetUnf;

type
  TF_TRAFMTST = class(T_FormTouch)
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
  private
    tGER_CONDPGTOC,
    tIMB_CONTRATO,
    tSIS_DUMMY : TcDatasetUnf;
    function setEntidade(pParams : String = '') : String;
    function getParam(pParams : String = '') : String;
    function preEDIT(pParams : String = '') : String; override;
    function posEDIT(pParams : String = '') : String; override;


  protected
  public
  published
  end;

implementation

{$R *.dfm}

uses
  cActivate, cStatus, cFuncao, cXml, dModulo;

var
  gInImobiliaria,
  glsParcela : String;

procedure TF_TRAFMTST.FormCreate(Sender: TObject);
begin
  inherited; //
end;

procedure TF_TRAFMTST.FormShow(Sender: TObject);
begin
  inherited; //
end;

procedure TF_TRAFMTST.FormActivate(Sender: TObject);
begin
  inherited; //
end;

procedure TF_TRAFMTST.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  inherited; //
end;

//---------------------------------------------------------------
function TF_TRAFMTST.getParam(pParams : String = '') : String;
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

  (* colocar o conteudo da operacao INIT aqui *)

  return(0); exit;
end;

//---------------------------------------------------------------
function TF_TRAFMTST.setEntidade(pParams : String = '') : String;
//---------------------------------------------------------------
begin
  tGER_CONDPGTOC := TcDatasetUnf.GetEntidade(Self, 'GER_CONDPGTOC');
  tIMB_CONTRATO := TcDatasetUnf.GetEntidade(Self, 'IMB_CONTRATO');
  tSIS_DUMMY := TcDatasetUnf.GetEntidade(Self, 'SIS_DUMMY');
end;

//---------------------------------------------------------------
function TF_TRAFMTST.preEDIT(pParams : String) : String;
//---------------------------------------------------------------
const
  cDS_METHOD = 'ADICIONAL=Operação: TF_TRAFMTST.preEDIT()';
begin
  return(0); exit;
end;

//---------------------------------------------------------------
function TF_TRAFMTST.posEDIT(pParams : String) : String;
//---------------------------------------------------------------
const
  cDS_METHOD = 'ADICIONAL=Operação: TF_TRAFMTST.posEDIT()';
begin
  return(0); exit;
end;

  if (item_f('VL_VALOR', tSIS_DUMMY) = 0) then begin
    SetStatusM(STS_ERROR, 'GEN0001', 'Valor não informado!', '');
    gprompt := item_f('VL_VALOR', tSIS_DUMMY);
    return(-1); exit;
  end;
  if (item_a('DS_FORMAPGTO', tSIS_DUMMY) <> 1) and (item_a('DS_FORMAPGTO', tSIS_DUMMY) <> 2) and (item_a('DS_FORMAPGTO', tSIS_DUMMY) <> 14) then begin
    SetStatusM(STS_ERROR, 'GEN0001', 'Tipo de documento inválido!', '');
    gprompt := item_a('DS_FORMAPGTO', tSIS_DUMMY);
    return(-1); exit;
  end;
  if (gInImobiliaria = uTRUE) and (item_f('NR_PARCELA', tIMB_CONTRATO) > 0) and (item_f('NR_DIABASEVCTO', tIMB_CONTRATO) > 0) then begin
  end else begin
    if (item_f('CD_CONDPGTO', tGER_CONDPGTOC) = 0) then begin
      SetStatusM(STS_ERROR, 'GEN0001', 'Condição de Pagamento não informada!', '');
      gprompt := item_f('CD_CONDPGTO', tGER_CONDPGTOC);
      return(-1); exit;
    end;
  end;
  if (item_a('DS_FORMAPGTO', tSIS_DUMMY) = 1) or (item_a('DS_FORMAPGTO', tSIS_DUMMY) = 14) and (item_f('NR_DOCUMENTO', tSIS_DUMMY) = 0) then begin
    SetStatusM(STS_ERROR, 'GEN0001', 'Documento não informado!', '');
    gprompt := item_a('DS_FORMAPGTO', tSIS_DUMMY);
    return(-1); exit;
  end;

  voParams := geraParcela(viParams); (* *)
  if (xProcerror) then begin
    SetStatusM(STS_ERROR, xProcerror, xProcerrorcontext, '');
  end;
  if (xStatus < 0) then begin
    return(-1); exit;
  end;

  vpoParams := '';
  putitemXml(vpoParams, 'DS_LSTPARCELA', glsParcela);
  putitemXml(vpoParams, 'NR_DOCUMENTO', item_f('NR_DOCUMENTO', tSIS_DUMMY));
  putitemXml(vpoParams, 'IN_COBLOJA', item_b('IN_COBLOJA', tSIS_DUMMY));
  putitemXml(vpoParams, 'TP_DOCUMENTO', item_a('DS_FORMAPGTO', tSIS_DUMMY));
  return(0); exit;

end.
