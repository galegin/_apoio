unit fFISFP017;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, fFormTouch, ExtCtrls, cPanel, cDatasetUnf;

type
  TF_FISFP017 = class(T_FormTouch)
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
  private
    tCTB_GRUPOCTA,
    tCTB_PLANO,
    tGER_EMPRESA,
    tPES_CONTATO,
    tPES_TIPOCONTATO,
    tSIS_FILTRO,
    tSIS_FILTROAND< : TcDatasetUnf;
    function setEntidade(pParams : String = '') : String; override;
    function getParam(pParams : String = '') : String; override;
    function preEDIT(pParams : String = '') : String; override;
    function posEDIT(pParams : String = '') : String; override;

    function valorPadrao(pParams : String = '') : String;
    function consultarEmpresa(pParams : String = '') : String;
    function validarEmpresa(pParams : String = '') : String;
    function validarIntervaloPeriodo(pParams : String = '') : String;
    function GetTipoValor(pParams : String = '') : String;
    function gerarSuperSintegra(pParams : String = '') : String;
    function validaConta(pParams : String = '') : String;
    function consultaInventario(pParams : String = '') : String;
  protected
  public
  published
  end;

implementation

{$R *.dfm}

uses
  cActivate, cStatus, cFuncao, cXml, dModulo;

var
  gCdEmpresaValorEmp,
  gCdEmpresaValorSis,
  gCdTipoClasItemNF,
  gCdUf,
  gnaturezaComercialEmp : String;

procedure TF_FISFP017.FormCreate(Sender: TObject);
begin
  inherited; //
end;

procedure TF_FISFP017.FormShow(Sender: TObject);
begin
  inherited; //
end;

procedure TF_FISFP017.FormActivate(Sender: TObject);
begin
  inherited; //
end;

procedure TF_FISFP017.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  inherited; //
end;

//---------------------------------------------------------------
function TF_FISFP017.getParam(pParams : String = '') : String;
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
function TF_FISFP017.setEntidade(pParams : String = '') : String;
//---------------------------------------------------------------
begin
  tCTB_GRUPOCTA := TcDatasetUnf.GetEntidade(Self, 'CTB_GRUPOCTA');
  tCTB_PLANO := TcDatasetUnf.GetEntidade(Self, 'CTB_PLANO');
  tGER_EMPRESA := TcDatasetUnf.GetEntidade(Self, 'GER_EMPRESA');
  tPES_CONTATO := TcDatasetUnf.GetEntidade(Self, 'PES_CONTATO');
  tPES_TIPOCONTATO := TcDatasetUnf.GetEntidade(Self, 'PES_TIPOCONTATO');
  tSIS_FILTRO := TcDatasetUnf.GetEntidade(Self, 'SIS_FILTRO');
  tSIS_FILTROAND< := TcDatasetUnf.GetEntidade(Self, 'SIS_FILTROAND<');
end;

//---------------------------------------------------------------
function TF_FISFP017.preEDIT(pParams : String) : String;
//---------------------------------------------------------------
const
  cDS_METHOD = 'ADICIONAL=Operação: TF_FISFP017.preEDIT()';
begin
  return(0); exit;
end;

//---------------------------------------------------------------
function TF_FISFP017.posEDIT(pParams : String) : String;
//---------------------------------------------------------------
const
  cDS_METHOD = 'ADICIONAL=Operação: TF_FISFP017.posEDIT()';
begin
  return(0); exit;
end;

preEDIT
const
  cDS_METHOD = 'ADICIONAL=Operação: TF_FISFP017.preEDIT()';
var
  viParams, voParams : String;
begin
  voParams := valorPadrao(viParams); (* *)
  if (xProcerror) then begin
    SetStatusM(STS_ERROR, xProcerror, xProcerrorcontext, '');
    return(0); exit;
  end else if (xStatus < 0)
    return(0); exit;
  end;
  voParams := GetTipoValor(viParams); (* *)
  if (xProcerror) then begin
    SetStatusM(STS_ERROR, xProcerror, xProcerrorcontext, '');
  end;
  viParams := '';
  voParams := activateCmp('GERSVCO007', 'ListTipoSaldo', viParams);
  if (xProcerror) then begin
    SetStatusM(STS_ERROR, xProcerror, xProcerrorcontext, '');
    return(-1); exit;
  end else if (xCdErro)
    voParams := SetErroApl(viParams); (* xCtxErro, xCdErro, xCtxErro *)
    return(-1); exit;
  end;
  valrep(putitem_e(tSIS_FILTRO, 'TP_SALDO'), voParams);

  return(0); exit;
End;

  INIT
const
  cDS_METHOD = 'ADICIONAL=Operação: TF_FISFP017.INIT()';
var
  viParams, voParams : String;
begin
  viParams := '';
  putitem(viParams,  'CD_EMPVALOR');
  xParam := activateCmp('ADMSVCO001', 'GetParametro', xParam);
  if (xProcerror) then begin
    SetStatusM(STS_ERROR, xProcerror, xProcerrorcontext, '');
    return(-1); exit;
  end else if (xCdErro)
    SetStatusM(STS_ERROR, 'GEN0001', '' + itemXml(DESCRICAO, + ' xCtxErro)', '');
    return(-1); exit;
  end else if (xStatus < 0)
    return(-1); exit;
  end;
  gCdEmpresaValorSis := itemXmlF('CD_EMPVALOR', voParams);

  viParams := '';
  putitem(viParams,  'NATUREZA_COMERCIAL_EMP');
  putitem(viParams,  'CD_EMPRESA_VALOR');
  putitem(viParams,  'CD_TIPOCLAS_ITEM_NF');
  xParamEmp := activateCmp('ADMSVCO001', 'GetParamEmpresa', piCdEmpresa, xParamEmp); (*itemXml('CD_EMPRESA' *)
  if (xProcerror) then begin
    SetStatusM(STS_ERROR, xProcerror, xProcerrorcontext, '');
  end else if (xStatus < 0)
    SetStatusM(STS_ERROR, xCdErro, xCtxErro, '');
  end;
  gnaturezaComercialEmp := itemXml('NATUREZA_COMERCIAL_EMP', voParams);
  gCdEmpresaValorEmp := itemXmlF('CD_EMPRESA_VALOR', voParams);
  gCdTipoClasItemNF := itemXmlF('CD_TIPOCLAS_ITEM_NF', voParams);

  _Caption := FISFP + '017 - Geração da Escrita Fiscal Digital/Livro Eletrônico';
End;

//----------------------------------------------------------
function TF_FISFP017.valorPadrao(pParams : String) : String;
//----------------------------------------------------------
const
  cDS_METHOD = 'ADICIONAL=Operação: TF_FISFP017.valorPadrao()';
begin
  clear_e(tSIS_FILTRO);

  fieldsyntax item_f('TP_SALDO', tSIS_FILTRO), 'DIM';
  fieldsyntax item_f('TP_CUSTO', tSIS_FILTRO), 'DIM';
  fieldsyntax item_a('DT_SALDO', tSIS_FILTRO), 'DIM';
  fieldsyntax item_f('TP_CODPRODUTO', tSIS_FILTRO), 'DIM';
  fieldsyntax item_f('TP_TIPOSALDO', tSIS_FILTRO), 'DIM';
  fieldsyntax item_f('CD_CONTACONTABIL', tSIS_FILTRO), 'DIM';
  fieldsyntax item_a('BT_LSTCC', tSIS_FILTRO), 'DIM';
  fieldsyntax item_b('IN_SALDOTERCEIRO', tSIS_FILTRO), 'DIM';
  fieldsyntax item_f('TP_INVENTARIO', tSIS_FILTRO), 'DIM';
  fieldsyntax item_a('BT_INVENTARIO', tSIS_FILTRO), 'DIM';
  fieldsyntax item_a('DS_LSTINVENTARIO', tSIS_FILTRO), 'DIM';
  fieldsyntax item_a('BT_LIMPAR', tSIS_FILTRO), 'DIM';
  fieldsyntax item_f('TP_MOTIVOINVENTARIO', tSIS_FILTRO), 'DIM';
  fieldsyntax item_f('CD_OPERACAO', tSIS_FILTRO), 'DIM';
  fieldsyntax item_a('DS_OPERACAO', tSIS_FILTRO), 'DIM';
  fieldsyntax item_a('BT_LSTOP', tSIS_FILTRO), 'DIM';

  putitem_o(tSIS_FILTRO, 'TP_INVENTARIO', '');
  putitem_o(tSIS_FILTRO, 'TP_SALDO', '');
  putitem_o(tSIS_FILTRO, 'TP_CUSTO', '');
  putitem_o(tSIS_FILTRO, 'DT_SALDO', '');
  putitem_o(tSIS_FILTRO, 'TP_CODPRODUTO', '');
  putitem_o(tSIS_FILTRO, 'TP_TIPOSALDO', '');
  putitem_o(tSIS_FILTRO, 'IN_SALDOTERCEIRO', '');
  putitem_o(tSIS_FILTRO, 'DS_LSTINVENTARIO', '');
  putitem_o(tSIS_FILTRO, 'TP_MOTIVOINVENTARIO', '');
  putitem_o(tSIS_FILTRO, 'CD_OPERACAO', '');
  putitem_o(tSIS_FILTRO, 'DS_OPERACAO', '');
  putitem_e(tSIS_FILTRO, 'CD_EMPRESA', itemXmlF('CD_EMPRESA', PARAM_GLB));
  clear_e(tGER_EMPRESA);
  putitem_o(tGER_EMPRESA, 'CD_EMPRESA', item_f('CD_EMPRESA', tSIS_FILTRO));
  retrieve_e(tGER_EMPRESA);

  clear_e(tPES_TIPOCONTATO);
    putitem_o(tPES_TIPOCONTATO, 'DS_TIPOCONTATO', 'FISCAL');
  retrieve_e(tPES_TIPOCONTATO);
  if (xStatus < 0) then begin
    SetStatusM(STS_ERROR, 'GEN001', 'Falta definir tipo de contato Fiscal. Verifique.', '');
    return(-1); exit;
  end;

  voParams := validarEmpresa(viParams); (* *)
  if (xProcerror) then begin
    SetStatusM(STS_ERROR, xProcerror, xProcerrorcontext, '');
    return(-1); exit;
  end else if (xStatus < 0)
    return(-1); exit;
  end;

  return(0); exit;
End;

//---------------------------------------------------------------
function TF_FISFP017.consultarEmpresa(pParams : String) : String;
//---------------------------------------------------------------
const
  cDS_METHOD = 'ADICIONAL=Operação: TF_FISFP017.consultarEmpresa()';
var
  viParams, voParams : String;
begin
  voParams := activateCmp('GERFL009', 'exec', viParams);
  if (xProcerror) then begin
    SetStatusM(STS_ERROR, xProcerror, xProcerrorcontext, '');
    return(-1); exit;
  end else if (itemXml('CD_EMPRESA', voParams) <> '')
    putitem_e(tSIS_FILTRO, 'CD_EMPRESA', itemXmlF('CD_EMPRESA', voParams));

    voParams := validarEmpresa(viParams); (* *)
    if (xProcerror) then begin
      SetStatusM(STS_ERROR, xProcerror, xProcerrorcontext, '');
      return(-1); exit;
    end else if (xStatus < 0)
      return(-1); exit;
    end;
  end;

  return(0); exit;
End;

//-------------------------------------------------------------
function TF_FISFP017.validarEmpresa(pParams : String) : String;
//-------------------------------------------------------------
const
  cDS_METHOD = 'ADICIONAL=Operação: TF_FISFP017.validarEmpresa()';
var
  viParams, voParams : String;
begin
  if (item_f('CD_EMPRESA', tSIS_FILTRO) = '') then begin
    clear_e(tGER_EMPRESA);
    return(0); exit;
  end;

  clear_e(tGER_EMPRESA);
  putitem_o(tGER_EMPRESA, 'CD_EMPRESA', item_f('CD_EMPRESA', tSIS_FILTRO));
  retrieve_e(tGER_EMPRESA);
  if (xStatus < 0) then begin
    SetStatusM(STS_ERROR, 'GEN001', 'Empresa informada inválida.', '');
    putitem_e(tSIS_FILTRO, 'CD_EMPRESA', '');
    clear_e(tGER_EMPRESA);
    gprompt := item_f('CD_EMPRESA', tSIS_FILTRO);
    return(-1); exit;
  end else begin
    viParams := '';
    putitemXml(viParams, 'CD_EMPRESA', item_f('CD_EMPRESA', tSIS_FILTRO));
    putitemXml(viParams, 'IN_CCUSTO', uFALSE);
    putitemXml(viParams, 'CD_COMPONENTE', FISFP017);
    voParams := activateCmp('FGRSVCO001', 'validarEmpresa', viParams);
    if (xProcerror) then begin
      SetStatusM(STS_ERROR, xProcerror, xProcerrorcontext, '');
      return(-1); exit;
    end else if (xStatus < 0)
      SetStatusM(STS_ERROR, xCdErro, xCtxErro, '');
      putitem_e(tSIS_FILTRO, 'CD_EMPRESA', '');
      clear_e(tGER_EMPRESA);
      gprompt := item_f('CD_EMPRESA', tSIS_FILTRO);
      return(-1); exit;
    end;
  end;

  clear_e(tPES_CONTATO);
  putitem_o(tPES_CONTATO, 'CD_PESSOA', item_f('CD_PESSOA', tGER_EMPRESA));
  putitem_o(tPES_CONTATO, 'CD_TIPOCONTATO', item_f('CD_TIPOCONTATO', tPES_TIPOCONTATO));
  retrieve_e(tPES_CONTATO);
  if (xStatus >= 0) then begin
    putitem_e(tSIS_FILTRO, 'NM_CONTATO', item_a('NM_CONTATO', tPES_CONTATO));
  end else begin
    SetStatusM(STS_AVISO, 'GEN001', 'Falta definir contato para essa empresa. Verifique.', '');

    putitem_e(tSIS_FILTRO, 'NM_CONTATO', 'Informar contato');
  end;

  return(0); exit;
End;

//----------------------------------------------------------------------
function TF_FISFP017.validarIntervaloPeriodo(pParams : String) : String;
//----------------------------------------------------------------------
const
  cDS_METHOD = 'ADICIONAL=Operação: TF_FISFP017.validarIntervaloPeriodo()';
var
  vNrMesIni, vNrMesFin : Real;
  vDtAux : TDateTime;
begin
  if (item_a('DT_PERIODOINI', tSIS_FILTRO) = '') and (item_a('DT_PERIODOFIN', tSIS_FILTRO) = '') then begin
    putitem_e(tSIS_FILTRO, 'DT_PERIODO', '');
  end else begin
    if (item_a('DT_PERIODOINI', tSIS_FILTRO) > item_a('DT_PERIODOFIN', tSIS_FILTRO)) then begin
      SetStatusM(STS_AVISO, 'GEN001', 'Data inicial maior que a final.', '');
      gprompt := item_a('DT_PERIODOINI', tSIS_FILTRO);
      return(-1); exit;
    end;
    if (item_a('DT_PERIODOINI', tSIS_FILTRO) = '') or (item_a('DT_PERIODOFIN', tSIS_FILTRO) = '') then begin
      putitem_e(tSIS_FILTRO, 'DT_PERIODOINI', '');
      putitem_e(tSIS_FILTRO, 'DT_PERIODOFIN', '');
      putitem_e(tSIS_FILTRO, 'DT_PERIODO', '');
    end else begin
      vDtAux := item_a('DT_PERIODOINI', tSIS_FILTRO);
      vNrMesIni := SubStr(vDtAux, 5, 2);
      vDtAux := item_a('DT_PERIODOFIN', tSIS_FILTRO);
      vNrMesFin := SubStr(vDtAux, 5, 2);
      if (vNrMesIni <> vNrMesFin) then begin
        SetStatusM(STS_AVISO, 'GEN001', 'Data inicial e data final devem corresponder ao mesmo mês.', '');
        gprompt := item_a('DT_PERIODOINI', tSIS_FILTRO);
        return(-1); exit;
      end;
      putitem_e(tSIS_FILTRO, 'DT_PERIODO', '>=' + item_a('dt_periodoini', tSIS_FILTROAND<) + '=' + item_a('dt_periodofin', tSIS_FILTRO) + '');
    end;
  end;

  return(0); exit;
End;

//-----------------------------------------------------------
function TF_FISFP017.GetTipoValor(pParams : String) : String;
//-----------------------------------------------------------
const
  cDS_METHOD = 'ADICIONAL=Operação: TF_FISFP017.GetTipoValor()';
var
  viParams,voParams : String;
begin
  putitemXml(viParams, 'TP_VALOR', 'C');
  voParams := activateCmp('GERSVCO007', 'ListTipoValor', viParams);
  if (xProcerror) then begin
    SetStatusM(STS_ERROR, xProcerror, xProcerrorcontext, '');
    return(-1); exit;
  end else if (xCdErro)
    voParams := SetErroApl(viParams); (* xCtxErro, xCdErro, xCtxErro *)
    return(-1); exit;
  end else if (xStatus < 0)
    return(-1); exit;
  end;
  valrep(putitem_e(tSIS_FILTRO, 'TP_CUSTO'), voParams);
  return(0); exit;
end;

//-----------------------------------------------------------------
function TF_FISFP017.gerarSuperSintegra(pParams : String) : String;
//-----------------------------------------------------------------
const
  cDS_METHOD = 'ADICIONAL=Operação: TF_FISFP017.gerarSuperSintegra()';
var
  viParams, voParams, vDsProcesso, vDsConteudo, vDsMensagem : String;
  vInErro, vInNovoSpedFiscal : Boolean;
begin
  vDsProcesso := '';
  if (item_f('TP_OPCAO', tSIS_FILTRO) = 1) then begin
    vDsProcesso := 'Livro Eletrônico';
  end else begin
    vDsProcesso := 'Escrituração Fiscal Digital';
  end;
  if (item_f('CD_EMPRESA', tSIS_FILTRO) = '') then begin
    SetStatusM(STS_AVISO, 'GEN001', 'Informar empresa para gerar sintegra.', '');
    gprompt := item_f('CD_EMPRESA', tSIS_FILTRO);
    return(-1); exit;
  end;
  voParams := validarEmpresa(viParams); (* *)
  if (xProcerror) then begin
    SetStatusM(STS_ERROR, xProcerror, xProcerrorcontext, '');
    return(-1); exit;
  end else if (xStatus < 0)
    return(-1); exit;
  end;
  if (item_a('DT_PERIODO', tSIS_FILTRO) = '') then begin
    SetStatusM(STS_AVISO, 'GEN001', 'Informar intervalo de período.', '');
    gprompt := item_a('DT_PERIODOINI', tSIS_FILTRO);
    return(-1); exit;
  end;
  voParams := validarIntervaloPeriodo(viParams); (* *)
  if (xProcerror) then begin
    SetStatusM(STS_ERROR, xProcerror, xProcerrorcontext, '');
    return(-1); exit;
  end else if (xStatus < 0)
    return(-1); exit;
  end;
  if (item_a('DT_VENCTOIMP', tSIS_FILTRO) = '') then begin
    SetStatusM(STS_AVISO, 'GEN001', 'Informar vencimento do imposto a recolher.', '');
    gprompt := item_a('DT_VENCTOIMP', tSIS_FILTRO);
    return(-1); exit;
  end;
  if (item_f('TP_OPCAO', tSIS_FILTRO) = 2) and (item_a('DT_VENCTOIMP', tSIS_FILTRO) < item_a('DT_PERIODOINI', tSIS_FILTRO)) then begin
    SetStatusM(STS_AVISO, 'GEN001', 'Data de vencimento do imposto não pode ser menor que a data inicial do período.', '');

    putitem_e(tSIS_FILTRO, 'DT_VENCTOIMP', '');
    gprompt := item_a('DT_VENCTOIMP', tSIS_FILTRO);
    return(-1); exit;
  end;
  gCdUf := '';
  if (item_f('CD_UF', tSIS_FILTRO) <> '00') then begin
    gCduf := item_f('CD_UF', tSIS_FILTRO);
  end;
  if (item_f('TP_OPCAO', tSIS_FILTRO) = 1) then begin
    if (item_f('TP_NATUREZA', tSIS_FILTRO) = '') then begin
      SetStatusM(STS_AVISO, 'GEN001', 'Informar natureza da operação para gerar ' + vDsProcesso + '.', '');
      gprompt := item_f('TP_NATUREZA', tSIS_FILTRO);
      return(-1); exit;
    end;
    if (item_f('TP_FINALIDADE', tSIS_FILTRO) = '') then begin
      SetStatusM(STS_AVISO, 'GEN001', 'Informar a finalidade do arquivo para gerar ' + vDsProcesso + '.', '');
      gprompt := item_f('TP_FINALIDADE', tSIS_FILTRO);
      return(-1); exit;
    end;
  end;
  if (item_a('DS_PATH', tSIS_FILTRO) = '') then begin
    SetStatusM(STS_AVISO, 'GEN001', 'Informar o arquivo para gerar ' + vDsProcesso + '.', '');
    gprompt := item_a('BT_PATH', tSIS_FILTRO);
    return(-1); exit;
  end;
  if (item_f('TP_OPCAO', tSIS_FILTRO) <> 1) and (item_f('TP_MOTIVOINVENTARIO', tSIS_FILTRO) > 1) and (item_f('CD_OPERACAO', tSIS_FILTRO) = '') then begin
    SetStatusM(STS_AVISO, 'GEN001', 'Para o motivo do inventário selecionado é obrigatório o preenchimento do campo Operação reg. H020.', '');
    gprompt := item_f('CD_OPERACAO', tSIS_FILTRO);
    return(-1); exit;
  end;

  viParams := '';
  putitem(viParams,  'IN_NOVO_SPED_FISCAL');
  xParamEmp := activateCmp('ADMSVCO001', 'GetParamEmpresa', piCdEmpresa, xParamEmp); (*item_f('CD_EMPRESA', tSIS_FILTRO),* *)
  if (xProcerror) then begin
    SetStatusM(STS_ERROR, xProcerror, xProcerrorcontext, '');
  end else if (xStatus < 0)
    SetStatusM(STS_ERROR, xCdErro, xCtxErro, '');
  end;
  vInNovoSpedFiscal := itemXmlB('IN_NOVO_SPED_FISCAL', voParams);

  vInErro := uFALSE;
  vDsProcesso := '';

  viParams := '';

  putitemXml(viParams, 'DT_PERIODOINI', item_a('DT_PERIODOINI', tSIS_FILTRO));
  putitemXml(viParams, 'DT_PERIODOFIM', item_a('DT_PERIODOFIN', tSIS_FILTRO));
  putitemXml(viParams, 'TP_FINALIDADE', item_f('TP_FINALIDADE', tSIS_FILTRO));
  putitemXml(viParams, 'CD_PESSOA', item_f('CD_PESSOA', tGER_EMPRESA));
  putitemXml(viParams, 'IN_BLOCOC', item_b('IN_BLOCOC', tSIS_FILTRO));
  putitemXml(viParams, 'CD_EMPRESA', item_f('CD_EMPRESA', tSIS_FILTRO));
  putitemXml(viParams, 'DT_PERIODO', item_a('DT_PERIODO', tSIS_FILTRO));
  putitemXml(viParams, 'TP_PERFIL', item_f('TP_PERFIL', tSIS_FILTRO));
  putitemXml(viParams, 'IN_BLOCOD', item_b('IN_BLOCOD', tSIS_FILTRO));
  putitemXml(viParams, 'DT_VENCTOIMP', item_a('DT_VENCTOIMP', tSIS_FILTRO));
  putitemXml(viParams, 'IN_BLOCOH', item_b('IN_BLOCOH', tSIS_FILTRO));
  putitemXml(viParams, 'TP_CODPRODUTO', item_f('TP_CODPRODUTO', tSIS_FILTRO));
  putitemXml(viParams, 'IN_BLOCOE', item_b('IN_BLOCOE', tSIS_FILTRO));
  putitemXml(viParams, 'DT_SALDO', item_a('DT_SALDO', tSIS_FILTRO));
  putitemXml(viParams, 'TP_TIPOSALDO', item_f('TP_TIPOSALDO', tSIS_FILTRO));
  putitemXml(viParams, 'TP_CUSTO', item_f('TP_CUSTO', tSIS_FILTRO));
  putitemXml(viParams, 'TP_SALDO', item_f('TP_SALDO', tSIS_FILTRO));
  putitemXml(viParams, 'DS_PATH', item_a('DS_PATH', tSIS_FILTRO));
  putitemXml(viParams, 'CD_CONTACONTABIL', item_f('CD_CONTACONTABIL', tSIS_FILTRO));
  putitemXml(viParams, 'IN_SALDOTERCEIRO', item_b('IN_SALDOTERCEIRO', tSIS_FILTRO));
  putitemXml(viParams, 'TP_INVENTARIO', item_f('TP_INVENTARIO', tSIS_FILTRO));
  putitemXml(viParams, 'DS_LSTINVENTARIO', item_a('DS_LSTINVENTARIO', tSIS_FILTRO));
  putitemXml(viParams, 'TP_MOTIVOINVENTARIO', item_f('TP_MOTIVOINVENTARIO', tSIS_FILTRO));
  putitemXml(viParams, 'CD_OPERACAO', item_f('CD_OPERACAO', tSIS_FILTRO));

  if (item_f('TP_OPCAO', tSIS_FILTRO) = 1) then begin
    voParams := activateCmp('FISSVCO040', 'gerarSUP', viParams);
    if (xProcerror) then begin
      SetStatusM(STS_ERROR, xProcerror, xProcerrorcontext, '');
      vInErro := uTRUE;
    end else if (xStatus < 0)
      SetStatusM(STS_ERROR, xCdErro, xCtxErro, '');
      vInErro := uTRUE;
    end;
    vDsProcesso := 'Livro Eletrônico';
  end else begin

    if (vInNovoSpedFiscal = uTRUE) then begin
      vDsMensagem := 'O arquivo gerado a seguir é resultado de uma nova versão da implementação, ';
      vDsMensagem := vDsMensagemcriada + ' para melhor atender as exigências do conteúdo e agilizar a geração em menor tempo. ';
      vDsMensagem := vDsMensagemFavor + ' conferir o arquivo gerado, informando ao suporte eventuais problemas. ';
      vDsMensagem := vDsMensagemA + ' versão anterior ainda estará disponível sendo configurada por meio do parâmetro IN_NOVO_SPED_FISCAL.';
      mensagemInfo( vDsMensagem;

      voParams := activateCmp('FISSVCO082', 'gerarEFD', viParams);
    end else begin

      voParams := activateCmp('FISSVCO039', 'gerarEFD', viParams);
    end;
    if (xProcerror) then begin
      SetStatusM(STS_ERROR, xProcerror, xProcerrorcontext, '');
      vInErro := uTRUE;
    end else if (xStatus < 0)
      SetStatusM(STS_ERROR, xCdErro, xCtxErro, '');
      vInErro := uTRUE;
    end;
    vDsProcesso := 'Escrituração Fiscal Digital';
  end;
  if (vInErro = uFALSE) then begin
    SetStatusM(STS_INFO, 'GEN001', 'Arquivo de ' + vDsProcesso + ' gerado com sucesso.', '');
  end else begin
    SetStatusM(STS_ERROR, 'GEN001', 'Erro na geração do arquivo de ' + vDsProcesso + '.', '');
  end;
  voParams := valorPadrao(viParams); (* *)
  if (xProcerror) then begin
    SetStatusM(STS_ERROR, xProcerror, xProcerrorcontext, '');
    return(-1); exit;
  end;
  gprompt := item_f('CD_EMPRESA', tSIS_FILTRO);

  return(0); exit;
End;

//----------------------------------------------------------
function TF_FISFP017.validaConta(pParams : String) : String;
//----------------------------------------------------------
const
  cDS_METHOD = 'ADICIONAL=Operação: TF_FISFP017.validaConta()';
var
  viParams, voParams : String;
begin
  if (item_f('CD_CONTACONTABIL', tSIS_FILTRO) > 0) then begin
    ulength(item_f('CD_CONTACONTABIL', tSIS_FILTRO));
    if (xResult <= 7) then begin
      scan(item_f('CD_CONTACONTABIL', tSIS_FILTRO), '.');
      if (xResult = 0) then begin
        clear_e(tCTB_PLANO);
        putitem_o(tCTB_PLANO, 'CD_POOLEMPRESA', itemXmlF('CD_POOLEMPRESA', PARAM_GLB));
        putitem_o(tCTB_PLANO, 'CD_REDUZIDO', item_f('CD_CONTACONTABIL', tSIS_FILTRO));
        retrieve_e(tCTB_PLANO);
        if (xStatus >= 0) then begin
          putitem_o(tSIS_FILTRO, 'CD_CONTACONTABIL', item_f('CD_CONTA', tCTB_PLANO));
          return(0); exit;
        end;
      end;
    end;
  end;

  clear_e(tCTB_GRUPOCTA);
  putitem_o(tCTB_GRUPOCTA, 'CD_GRUPOCTA', CD_CONTACONTABIL.SIS_SubStr(FILTRO, 1, 1));
  if (item_f('CD_GRUPOCTA', tCTB_GRUPOCTA) = '') then begin
    return(0); exit;
  end;
  retrieve_e(tCTB_GRUPOCTA);
  if (xStatus < 0) then begin
    mensagemInfo( 'Grupo de conta não encontrado!';
    putitem_o(tCTB_GRUPOCTA, 'CD_GRUPOCTA', 0);
    putitem_o(tSIS_FILTRO, 'CD_CONTACONTABIL', '');
    return(-1); exit;
  end;

  viParams := '';
  putitemXml(viParams, 'NR_DIGITADO', item_f('CD_CONTACONTABIL', tSIS_FILTRO));
  putitemXml(viParams, 'CD_MASCARA', item_f('CD_MASCARA', tCTB_GRUPOCTA));
  putitemXml(viParams, 'QT_GRAU', item_f('QT_GRAU', tCTB_GRUPOCTA));
  putitemXml(viParams, 'CD_GRUPOCONTA', item_f('CD_GRUPOCTA', tCTB_GRUPOCTA));
  voParams := activateCmp('CTBSVCO005', 'validaMascara', viParams);
  if (xProcerror) then begin
    SetStatusM(STS_ERROR, xProcerror, xProcerrorcontext, '');
    return(-1); exit;
  end else begin
    if (xCdErro) then begin
      voParams := SetErroApl(viParams); (* xCtxErro, xCdErro, xCtxErro *)
      return(-1); exit;
    end else if (xStatus < 0)
      return(-1); exit;
    end;
  end;
  putitem_e(tSIS_FILTRO, 'CD_CONTACONTABIL', itemXml('DS_CONTA', voParams));

  return(0); exit;
End;

//-----------------------------------------------------------------
function TF_FISFP017.consultaInventario(pParams : String) : String;
//-----------------------------------------------------------------
const
  cDS_METHOD = 'ADICIONAL=Operação: TF_FISFP017.consultaInventario()';
var
  viParams, voParams : String;
begin
  viParams := '';
  putitemXml(viParams, 'CD_EMPRESA', item_f('CD_EMPRESA', tSIS_FILTRO));
  putitemXml(viParams, 'DT_INVENTARIO', item_a('DT_PERIODOINI', tSIS_FILTRO));
  voParams := activateCmp('FISFF013', 'EXEC', viParams);
  if (xProcerror) then begin
    SetStatusM(STS_ERROR, xProcerror, xProcerrorcontext, '');
  end else if (xCdErro)
    voParams := SetErroApl(viParams); (* xCtxErro, xCdErro, xCtxErro *)
  end;
  if (itemXml('DS_LSTINVENTARIO', voParams) <> '') then begin
    putitem_e(tSIS_FILTRO, 'DS_LSTINVENTARIO', itemXml('DS_LSTINVENTARIO', voParams));
  end;

  return(0); exit;

End;

end.
