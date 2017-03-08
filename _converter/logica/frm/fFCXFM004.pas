unit fFCXFM004;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, fFormTouch, ExtCtrls, cPanel, cDatasetUnf;

type
  TF_FCXFM004 = class(T_FormTouch)
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
  private
    tF_FCX_CAIXAC,
    tFCC_CTAPES,
    tFCX_CAIXAC,
    tGER_EMPRESA,
    tGER_S_EMPRESA,
    tGER_TERMINAL,
    tSIS_BOTOES : TcDatasetUnf;
    function getParam(pParams : String = '') : String;
    function setEntidade(pParams : String = '') : String;
    function preEDIT(pParams : String = '') : String;
    function posEDIT(pParams : String = '') : String;
    function preEDIT(pParams : String = '') : String;
    function INIT(pParams : String = '') : String;
    function carregaCaixa(pParams : String = '') : String;
    function abreCaixa(pParams : String = '') : String;
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
  gCdEmpresa,
  gCdEmpresaFundo,
  gCdTerminal,
  gCdUsuario,
  gDtAbertura,
  gInCxTerminal,
  gInMostrarCxAberto,
  gInUtilizaVlFundo,
  gNrCtaPesFundo : String;

procedure TF_FCXFM004.FormCreate(Sender: TObject);
begin
  inherited; //
  setEntidade();
end;

procedure TF_FCXFM004.FormShow(Sender: TObject);
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

procedure TF_FCXFM004.FormActivate(Sender: TObject);
begin
  inherited; //
end;

procedure TF_FCXFM004.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  inherited; //
end;

//---------------------------------------------------------------
function TF_FCXFM004.getParam(pParams : String = '') : String;
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
function TF_FCXFM004.setEntidade(pParams : String = '') : String;
//---------------------------------------------------------------
begin
  tF_FCX_CAIXAC := TcDatasetUnf.GetEntidade(Self, 'F_FCX_CAIXAC');
  tFCC_CTAPES := TcDatasetUnf.GetEntidade(Self, 'FCC_CTAPES');
  tFCX_CAIXAC := TcDatasetUnf.GetEntidade(Self, 'FCX_CAIXAC');
  tGER_EMPRESA := TcDatasetUnf.GetEntidade(Self, 'GER_EMPRESA');
  tGER_S_EMPRESA := TcDatasetUnf.GetEntidade(Self, 'GER_S_EMPRESA');
  tGER_TERMINAL := TcDatasetUnf.GetEntidade(Self, 'GER_TERMINAL');
  tSIS_BOTOES := TcDatasetUnf.GetEntidade(Self, 'SIS_BOTOES');
end;

//---------------------------------------------------------------
function TF_FCXFM004.preEDIT(pParams : String) : String;
//---------------------------------------------------------------
const
  cDS_METHOD = 'ADICIONAL=Operação: TF_FCXFM004.preEDIT()';
begin
  return(0); exit;
end;

//---------------------------------------------------------------
function TF_FCXFM004.posEDIT(pParams : String) : String;
//---------------------------------------------------------------
const
  cDS_METHOD = 'ADICIONAL=Operação: TF_FCXFM004.posEDIT()';
begin
  return(0); exit;
end;

//------------------------------------------------------
function TF_FCXFM004.preEDIT(pParams : String) : String;
//------------------------------------------------------
const
  cDS_METHOD = 'ADICIONAL=Operação: TF_FCXFM004.preEDIT()';
begin
  gCdTerminal := itemXmlF('CD_TERMINAL', PARAM_GLB);
  if (gCdTerminal = 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Terminal não informado!', '');
    return(-1); exit;
  end;

  gCdEmpresa := itemXmlF('CD_EMPRESA', PARAM_GLB);
  gDtAbertura := itemXml('DT_SISTEMA', PARAM_GLB);
  gCdUsuario := itemXmlF('CD_USUARIO', PARAM_GLB);

  voParams := carregaCaixa(viParams); (* *)
  if (xStatus < 0) then begin
    Result := voParams;
    return(-1); exit;
  end;

  return(0); exit;
end;

//---------------------------------------------------
function TF_FCXFM004.INIT(pParams : String) : String;
//---------------------------------------------------
const
  cDS_METHOD = 'ADICIONAL=Operação: TF_FCXFM004.INIT()';
begin
  xParamEmp := '';
  putitem(xParamEmp,  'IN_UTILIZA_VLFUNDO');
  putitem(xParamEmp,  'IN_CAIXA_TERMINAL');
  putitem(xParamEmp,  'IN_UTILIZA_VLFUNDO');
  putitem(xParamEmp,  'IN_MOSTRAR_CXABERTO');

  xParamEmp := T_ADMSVCO001.GetParamEmpresa(piCdEmpresa, xParamEmp); (*itemXml('CD_EMPRESA', *)

  gInUtilizaVlFundo := itemXmlB('IN_UTILIZA_VLFUNDO', xParamEmp);

  gInMostrarCxAberto := itemXmlB('IN_MOSTRAR_CXABERTO', xParamEmp);
  if (gInMostrarCxAberto = '') then begin
    gInMostrarCxAberto := True;
  end;

  _Caption := '' + FCXFM + '004 - Abertura de Caixa';
end;

//-----------------------------------------------------------
function TF_FCXFM004.carregaCaixa(pParams : String) : String;
//-----------------------------------------------------------
const
  cDS_METHOD = 'ADICIONAL=Operação: TF_FCXFM004.carregaCaixa()';
var
  viParams, voParams, vDsLstEmpresa : String;
  vNrCtaPes, vCdEmpresa : Real;
  vInVlFundo, vInCxTerminal : Boolean;
begin
  vInCxTerminal := itemXmlB('IN_CAIXA_TERMINAL', xParamEmp);
  gInCxTerminal := itemXmlB('IN_CAIXA_TERMINAL', xParamEmp);

  if (gInMostrarCxAberto <> True) then begin
    clear_e(tFCX_CAIXAC);
    putitem_e(tGER_EMPRESA, 'CD_EMPRESA', gCdEmpresa);
    putitem_e(tGER_TERMINAL, 'CD_TERMINAL', gCdTerminal);
    putitem_e(tFCX_CAIXAC, 'IN_FECHADO', False);
    retrieve_e(tFCX_CAIXAC);
    if (xStatus >= 0) then begin
      Result := SetStatus(STS_AVISO, 'GEN001', 'Terminal contém caixa em aberto.', '');
      return(-1); exit;
    end;
  end;

  clear_e(tFCX_CAIXAC);
  putitem_e(tGER_EMPRESA, 'CD_EMPRESA', gCdEmpresa);
  putitem_e(tGER_TERMINAL, 'CD_TERMINAL', gCdTerminal);
  putitem_e(tFCX_CAIXAC, 'DT_ABERTURA', gDtAbertura);
  putitem_e(tFCX_CAIXAC, 'IN_FECHADO', False);
  putitem_e(tFCX_CAIXAC, 'CD_OPERCX', gCdUsuario);
  retrieve_e(tFCX_CAIXAC);
  if (xStatus < 0)  and (vInCxTerminal <> True) then begin
    retrieve_e(tGER_TERMINAL);
  end else begin
    if (xStatus >= 0) then begin
      fieldsyntax item_a('BT_CONFIRMAR', tSIS_BOTOES), 'DIM';
    end;
  end;

  putitem_e(tFCX_CAIXAC, 'VL_ABERTURA', 0);
  vInVlFundo := itemXmlB('IN_UTILIZA_VLFUNDO', xParamEmp);

  if (vInVlFundo = True) then begin
    vDsLstEmpresa := '';
    clear_e(tGER_S_EMPRESA);
    putitem_e(tGER_S_EMPRESA, 'CD_GRUPOEMPRESA', itemXmlF('CD_GRUPOEMPRESA', PARAM_GLB));
    retrieve_e(tGER_S_EMPRESA);
    if (xStatus >= 0) then begin
      setocc(tGER_S_EMPRESA, 1);
      while (xStatus >= 0) do begin
        putitem(vDsLstEmpresa,  item_f('CD_EMPRESA', tGER_S_EMPRESA));

        setocc(tGER_S_EMPRESA, curocc(tGER_S_EMPRESA) + 1);
      end;
    end;
    if (vDsLstEmpresa <> '') then begin
      repeat
        getitem(vCdEmpresa, vDsLstEmpresa, 1);

        viParams := '';
        putitemXml(viParams, 'CD_EMPRESA', vCdEmpresa);
        putitemXml(viParams, 'CD_OPERADOR', gCdUsuario);
        voParams := activateCmp('FCCSVCO002', 'buscaContaOperador', viParams); (*,,,, *)
        if (xStatus < 0) then begin
          Result := voParams;
          return(-1); exit;
        end;

        vNrCtaPes := itemXmlF('NR_CTAPES', voParams);

        clear_e(tFCC_CTAPES);
        putitem_e(tFCC_CTAPES, 'NR_CTAPES', vNrCtaPes);
        retrieve_e(tFCC_CTAPES);
        if (xStatus >= 0) then begin
          putitem_e(tFCX_CAIXAC, 'VL_ABERTURA', item_f('VL_ABERTURA', tFCX_CAIXAC) + item_f('VL_LIMITE', tFCC_CTAPES));

          if (item_f('VL_LIMITE', tFCC_CTAPES) > 0) then begin
            gCdEmpresaFundo := vCdEmpresa;
            gNrCtaPesFundo := vNrCtaPes;
          end;
        end;

        delitem(vDsLstEmpresa, 1);
      until (vDsLstEmpresa = '');
    end;
  end;

  clear_e(tF_FCX_CAIXAC);
  putitem_e(tF_FCX_CAIXAC, 'CD_EMPRESA', gCdEmpresa);
  putitem_e(tF_FCX_CAIXAC, 'CD_TERMINAL', gCdTerminal);
  putitem_e(tF_FCX_CAIXAC, 'IN_FECHADO', False);
  retrieve_e(tF_FCX_CAIXAC);
  if (xStatus >= 0) then begin
    fieldsyntax item_a('BT_CONFIRMAR', tSIS_BOTOES), 'DIM';
  end;
  clear_e(tF_FCX_CAIXAC);

  if (gInCxTerminal <> True) then begin
    clear_e(tF_FCX_CAIXAC);
    putitem_e(tF_FCX_CAIXAC, 'CD_EMPRESA', gCdEmpresa);
    putitem_e(tF_FCX_CAIXAC, 'CD_OPERCX', gCdUsuario);
    putitem_e(tF_FCX_CAIXAC, 'IN_FECHADO', False);
    retrieve_e(tF_FCX_CAIXAC);
    if (xStatus >= 0) then begin
      fieldsyntax item_a('BT_CONFIRMAR', tSIS_BOTOES), 'DIM';
    end;
    clear_e(tF_FCX_CAIXAC);
  end;

  return(0); exit;
end;

//--------------------------------------------------------
function TF_FCXFM004.abreCaixa(pParams : String) : String;
//--------------------------------------------------------
const
  cDS_METHOD = 'ADICIONAL=Operação: TF_FCXFM004.abreCaixa()';
var
  viParams, voParams : String;
begin
  askmess 'Deseja realmente abrir o caixa?', 'Sim, Não';
  if (xStatus = 2) then begin
    return(-1); exit;
  end;

  viParams := '';
  putlistitensocc_e(viParams, tFCX_CAIXAC);
  putitemXml(viParams, 'VL_ABERTURA', item_f('VL_ABERTURA', tFCX_CAIXAC));
  putitemXml(viParams, 'IN_CXTERMINAL', itemXmlB('IN_CAIXA_TERMINAL', xParamEmp));
  putitemXml(viParams, 'CD_EMPRESAFUNDO', gCdEmpresaFundo);
  putitemXml(viParams, 'NR_CTAPESFUNDO', gNrCtaPesFundo);

  voParams := activateCmp('FCXSVCO002', 'abreCaixa', viParams); (*,,,, *)
  if (xStatus < 0) then begin
    Result := voParams;
    return(-1); exit;
  end;

  commit;
  if (xStatus < 0) then begin
    rollback;
    Result := SetStatus(STS_ERROR, 'GEN001', 'Erro na abertura de caixa.', '');
    return(-1); exit;
  end else begin
    clear_e(tFCX_CAIXAC);
    putitem_e(tGER_EMPRESA, 'CD_EMPRESA', gCdEmpresa);
    putitem_e(tGER_TERMINAL, 'CD_TERMINAL', gCdTerminal);
    putitem_e(tFCX_CAIXAC, 'DT_ABERTURA', gDtAbertura);
    putitem_e(tFCX_CAIXAC, 'IN_FECHADO', False);
    retrieve_e(tFCX_CAIXAC);
    if (xStatus < 0) then begin
      Result := SetStatus(STS_ERROR, 'GEN001', 'Erro na abertura de caixa.', '');
    end else begin
      fieldsyntax item_a('BT_CONFIRMAR', tSIS_BOTOES), 'DIM';
    end;

    Result := SetStatus(<STS_INFO>, 'GEN001', 'Abertura de caixa efetuado com sucesso.', '');
  end;

  return(0); exit;
end;

end.
