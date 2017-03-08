unit cADMSVCO009;

interface

(* COMPONENTES 
  ADMFM020 / ADMSVCO010 / 
*)        

uses
  Classes, SysUtils, DB,
  cServiceUnf, cDataSetUnf;

type
  T_ADMSVCO009 = class(TcServiceUnf)
  private
    tADM_RESTUSU,
    tF_ADM_RESTUSU,
    tF_GLB_RESTRIC,
    tF2_GLB_RESTRI,
    tGER_EMPRESA,
    tGLB_RESTRICAO : TcDatasetUnf;
    function getParam(pParams : String = '') : String;
    function setEntidade(pParams : String = '') : String;
  protected
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;    
  published
    function VerificaRestricao(pParams : String = '') : String;
    function verificaUsuarioRestricao(pParams : String = '') : String;
  end;

implementation

uses
  cADMSVCO001,
  cActivate, cStatus, cFuncao, cXml, dModulo;

var


//---------------------------------------------------------------
constructor T_ADMSVCO009.Create(AOwner: TComponent);
//---------------------------------------------------------------
begin
  inherited Create(AOwner);
  setEntidade('');
end;

//--------------------------------
destructor T_ADMSVCO009.Destroy;
//--------------------------------
begin
  inherited Destroy;
end;

//---------------------------------------------------------------
function T_ADMSVCO009.getParam(pParams : String = '') : String;
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
function T_ADMSVCO009.setEntidade(pParams : String = '') : String;
//---------------------------------------------------------------
begin
  tADM_RESTUSU := GetEntidade('ADM_RESTUSU');
  tF_ADM_RESTUSU := GetEntidade('F_ADM_RESTUSU');
  tF_GLB_RESTRIC := GetEntidade('F_GLB_RESTRIC');
  tF2_GLB_RESTRI := GetEntidade('F2_GLB_RESTRI');
  tGER_EMPRESA := GetEntidade('GER_EMPRESA');
  tGLB_RESTRICAO := GetEntidade('GLB_RESTRICAO');
end;

//-----------------------------------------------------------------
function T_ADMSVCO009.VerificaRestricao(pParams : String) : String;
//-----------------------------------------------------------------
const
  cDS_METHOD = 'ADICIONAL=Operação: T_ADMSVCO009.VerificaRestricao()';
begin
var
  (* string viParams :IN / string voParams :OUT *)
  vCdComponente, viLogparams : String;
  vDsCampo, vDsAux : String;
  vCdEmpresa : String;
  vCdUsuario : String;
  VlValor, vTpRestricaoLog, vInicioOriginal, vFimOriginal : Real;
  vCdUsuarioValidado : String;
  DsPermite : String;
  vInErro, vInValidaSenha, vInValidaCadastro, vInRetornoErro : Boolean;
begin
  viLogparams := viParams;
  vCdComponente := itemXmlF('CD_COMPONENTE', viParams);
  vDsCampo := itemXml('DS_CAMPO', viParams);
  vCdEmpresa := itemXmlF('CD_EMPRESA', viParams);
  vCdUsuario := itemXmlF('CD_USUARIO', viParams);
  VlValor := itemXmlF('VL_VALOR', viParams);
  vInValidaCadastro := itemXmlB('IN_VALIDA_CADASTRO', viParams);
  vInRetornoErro := itemXmlB('IN_RETORNA_ERRO', viParams);

  vDsAux := itemXml('DS_AUX', viParams);
  vDsAux := greplace(vDsAux, 1, ';

  vInValidaSenha := itemXmlB('IN_VALIDASENHA', viParams);
  if (vInValidaSenha = '') then begin
    vInValidaSenha := True;
  end;
  if (vInValidaCadastro = '') then begin
    vInValidaCadastro := True;
  end;

  vTpRestricaoLog := 1;

  if (vCdComponente = '') then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Validação de restrição, Componente não informado.', '');
    return(-1); exit;
  end;
  if (vDsCampo = '') then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Validação de restrição, Campo não iformado.', '');
    return(-1); exit;
  end;
  if (vCdEmpresa = '') then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Validação de restrição, Empresa não iformada.', '');
    return(-1); exit;
  end;
  if (vCdUsuario = '') then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Validação de restrição, Usuário não informado.', '');
    return(-1); exit;
  end;

  clear_e(tF2_GLB_RESTRI);
  putitem_e(tF2_GLB_RESTRI, 'CD_COMPONENTE', vCdComponente);
  putitem_e(tF2_GLB_RESTRI, 'DS_CAMPO', vDsCampo);
  retrieve_e(tF2_GLB_RESTRI);
  if (xStatus < 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Restrição ' + vDsCampo + ' não cadastrada para o componente ' + FloatToStr(vCdComponente) + '. Realizar o cadastro em GLBFM043', '');

    return(-1); exit;
  end;

  DsPermite := 'NAO';

  clear_e(tADM_RESTUSU);
  putitem_e(tADM_RESTUSU, 'CD_COMPONENTE', vCdComponente);
  putitem_e(tADM_RESTUSU, 'DS_CAMPO', vDsCampo);
  putitem_e(tADM_RESTUSU, 'CD_EMPRESA', vCdEmpresa);
  putitem_e(tADM_RESTUSU, 'CD_USUARIO', vCdUsuario);
  retrieve_e(tADM_RESTUSU);
  if (xStatus >= 0) then begin
    vInicioOriginal := item_f('VL_INICIO', tADM_RESTUSU);
    vFimOriginal := item_f('VL_FIM', tADM_RESTUSU);

    if (item_f('TP_RESTRICAO', tGLB_RESTRICAO) = 3) then begin
      if (item_b('IN_PEDESENHA', tADM_RESTUSU) = True)  and (vInValidaSenha = True) then begin
        viParams := '';
        putitemXml(viParams, 'IN_USULOGADO', True);
        putitemXml(viParams, 'CD_USUARIO', 0);
        putitemXml(viParams, 'DS_COMPONENTE', vCdComponente);
        putitemXml(viParams, 'DS_HINT', 'Componente: ' + FloatToStr(vCdComponente) + ' / Restrição: ' + vDsCampo') + ';
        voParams := activateCmp('ADMFM020', 'exec', viParams); (*,,, *)
          vInErro := True;
        end;
        if (xStatus < 0) then begin
        end;
        vCdUsuarioValidado := itemXmlF('CD_USUARIO', voParams);

        if (vCdUsuarioValidado <> '') then begin
          clear_e(tF_ADM_RESTUSU);
          putitem_e(tF_ADM_RESTUSU, 'CD_COMPONENTE', vCdComponente);
          putitem_e(tF_ADM_RESTUSU, 'DS_CAMPO', vDsCampo);
          putitem_e(tF_ADM_RESTUSU, 'CD_EMPRESA', vCdEmpresa);
          putitem_e(tF_ADM_RESTUSU, 'CD_USUARIO', vCdUsuarioValidado);
          retrieve_e(tF_ADM_RESTUSU);
          if (xStatus >= 0) then begin
            if (item_b('IN_SEMRESTRICAO', tF_ADM_RESTUSU) = False ) or (item_b('IN_SEMRESTRICAO', tF_ADM_RESTUSU) = '') then begin
              Result := SetStatus(STS_ERROR, 'GEN0001', 'Usuário com restrição para esta ação. Verificar o cadastro de restrições.Componente: ' + FloatToStr(vCdComponente) + ' Campo: ' + vDsCampo', + ' '');
              vInErro := True;
              vTpRestricaoLog := 3;

            end else begin

              DsPermite := 'SIM';
              putitemXml(voParams, 'TP_RESTRICAO', item_f('TP_RESTRICAO', tF_GLB_RESTRIC));
              putitemXml(voParams, 'VL_INICIO', item_f('VL_INICIO', tF_ADM_RESTUSU));
              putitemXml(voParams, 'VL_FIM', item_f('VL_FIM', tF_ADM_RESTUSU));
              putitemXml(voParams, 'CD_USUARIO', vCdUsuarioValidado);
              vTpRestricaoLog := 2;

            end;
          end else begin

            Result := SetStatus(STS_ERROR, 'GEN0001', 'Restrição não cadastrada para o usuário ' + FloatToStr(vCdUsuarioValidado) + '.Componente: ' + FloatToStr(vCdComponente) + ' Campo: ' + vDsCampo', + ' '');
            vInErro := True;
            vTpRestricaoLog := 1;

          end;

        end else begin
          Result := SetStatus(STS_ERROR, 'GEN0001', 'Validação do usuário não concluída.', '');
          vInErro := True;
          vTpRestricaoLog := 3;

        end;

      end else begin

        if (item_b('IN_SEMRESTRICAO', tADM_RESTUSU) = False ) or (item_b('IN_SEMRESTRICAO', tADM_RESTUSU) = '') then begin
          Result := SetStatus(STS_ERROR, 'GEN0001', 'Usuário com restrição para esta ação. Verificar o cadastro de restrições.Componente: ' + FloatToStr(vCdComponente) + ' Campo: ' + vDsCampo', + ' '');
          vInErro := True;
          vTpRestricaoLog := 3;

        end else begin

          DsPermite := 'SIM';
          putitemXml(voParams, 'TP_RESTRICAO', item_f('TP_RESTRICAO', tGLB_RESTRICAO));
          putitemXml(voParams, 'VL_INICIO', item_f('VL_INICIO', tADM_RESTUSU));
          putitemXml(voParams, 'VL_FIM', item_f('VL_FIM', tADM_RESTUSU));
          putitemXml(voParams, 'CD_USUARIO', vCdUsuario);
          vTpRestricaoLog := 1;

        end;
      end;

    end else begin

      if (item_f('TP_RESTRICAO', tGLB_RESTRICAO) = 1) then begin
        if (VlValor = '') then begin
          Result := SetStatus(STS_ERROR, 'GEN0001', 'Valor não informado.', '');
          vInErro := True;
          vTpRestricaoLog := 3;

        end else begin

          if (VlValor < item_f('VL_INICIO', tADM_RESTUSU) ) or (VlValor > item_f('VL_FIM', tADM_RESTUSU)) then begin
            if (item_b('IN_PEDESENHA', tADM_RESTUSU) = True)  and (vInValidaSenha = True) then begin
              viParams := '';
              putitemXml(viParams, 'IN_USULOGADO', True);
              putitemXml(viParams, 'CD_USUARIO', 0);
              putitemXml(viParams, 'DS_COMPONENTE', vCdComponente);
              putitemXml(viParams, 'DS_HINT', 'Componente: ' + FloatToStr(vCdComponente) + ' / Restrição: ' + vDsCampo') + ';
              voParams := activateCmp('ADMFM020', 'exec', viParams); (*,,, *)
                vInErro := True;
              end;
              if (xStatus < 0) then begin
              end;
              vCdUsuarioValidado := itemXmlF('CD_USUARIO', voParams);

              if (vCdUsuarioValidado <> '') then begin
                clear_e(tF_ADM_RESTUSU);
                putitem_e(tF_ADM_RESTUSU, 'CD_COMPONENTE', vCdComponente);
                putitem_e(tF_ADM_RESTUSU, 'DS_CAMPO', vDsCampo);
                putitem_e(tF_ADM_RESTUSU, 'CD_EMPRESA', vCdEmpresa);
                putitem_e(tF_ADM_RESTUSU, 'CD_USUARIO', vCdUsuarioValidado);
                retrieve_e(tF_ADM_RESTUSU);
                if (xStatus >= 0) then begin
                  if (VlValor < item_f('VL_INICIO', tF_ADM_RESTUSU) ) or (VlValor > item_f('VL_FIM', tF_ADM_RESTUSU)) then begin
                    Result := SetStatus(STS_ERROR, 'GEN0001', 'Valor fora da faixa estabelecida. Verifique o cadastro de restrições.Componente: ' + FloatToStr(vCdComponente) + ' Campo: ' + vDsCampo', + ' '');

                    DsPermite := 'NAO';
                    putitemXml(voParams, 'TP_RESTRICAO', item_f('TP_RESTRICAO', tGLB_RESTRICAO));
                    putitemXml(voParams, 'VL_INICIO', item_f('VL_INICIO', tADM_RESTUSU));
                    putitemXml(voParams, 'VL_FIM', item_f('VL_FIM', tADM_RESTUSU));
                    putitemXml(voParams, 'CD_USUARIO', vCdUsuario);

                    vInErro := True;
                    vTpRestricaoLog := 3;
                  end else begin

                    DsPermite := 'SIM';
                    putitemXml(voParams, 'TP_RESTRICAO', item_f('TP_RESTRICAO', tF_GLB_RESTRIC));
                    putitemXml(voParams, 'VL_INICIO', item_f('VL_INICIO', tF_ADM_RESTUSU));
                    putitemXml(voParams, 'VL_FIM', item_f('VL_FIM', tF_ADM_RESTUSU));
                    putitemXml(voParams, 'CD_USUARIO', vCdUsuarioValidado);
                    vTpRestricaoLog := 2;

                  end;
                end else begin

                  Result := SetStatus(STS_ERROR, 'GEN0001', 'Restrição não cadastrada para o usuário ' + FloatToStr(vCdUsuarioValidado) + '.Componente: ' + FloatToStr(vCdComponente) + ' Campo: ' + vDsCampo', + ' '');
                  vInErro := True;
                  vTpRestricaoLog := 1;

                end;

              end else begin
                Result := SetStatus(STS_ERROR, 'GEN0001', 'Validação do usuário não concluída.', '');
                vInErro := True;
                vTpRestricaoLog := 3;

              end;
            end else begin
                Result := SetStatus(STS_ERROR, 'GEN0001', 'Valor fora da faixa estabelecida. Verifique o cadastro de restrições.Componente: ' + FloatToStr(vCdComponente) + ' Campo: ' + vDsCampo', + ' '');

                DsPermite := 'NAO';
                putitemXml(voParams, 'TP_RESTRICAO', item_f('TP_RESTRICAO', tGLB_RESTRICAO));
                putitemXml(voParams, 'VL_INICIO', item_f('VL_INICIO', tADM_RESTUSU));
                putitemXml(voParams, 'VL_FIM', item_f('VL_FIM', tADM_RESTUSU));
                putitemXml(voParams, 'CD_USUARIO', vCdUsuario);

                vInErro := True;
                vTpRestricaoLog := 3;

            end;
          end else begin

            DsPermite := 'SIM';
            putitemXml(voParams, 'TP_RESTRICAO', item_f('TP_RESTRICAO', tGLB_RESTRICAO));
            putitemXml(voParams, 'VL_INICIO', item_f('VL_INICIO', tADM_RESTUSU));
            putitemXml(voParams, 'VL_FIM', item_f('VL_FIM', tADM_RESTUSU));
            putitemXml(voParams, 'CD_USUARIO', vCdUsuario);
            vTpRestricaoLog := 1;

          end;
        end;
      end;
      if (item_f('TP_RESTRICAO', tGLB_RESTRICAO) = 2) then begin
        if (VlValor = '') then begin
          Result := SetStatus(STS_ERROR, 'GEN0001', 'Percentual não informado.', '');
          vInErro := True;
          vTpRestricaoLog := 3;

        end else begin

          if (VlValor < item_f('VL_INICIO', tADM_RESTUSU) ) or (VlValor > item_f('VL_FIM', tADM_RESTUSU)) then begin
            Result := SetStatus(STS_ERROR, 'GEN0001', 'Percentual fora da faixa estabelecida. Verifique o cadastro de restrições.Componente: ' + FloatToStr(vCdComponente) + ' Campo: ' + vDsCampo', + ' '');

            putitemXml(voParams, 'TP_RESTRICAO', item_f('TP_RESTRICAO', tGLB_RESTRICAO));
            putitemXml(voParams, 'VL_INICIO', item_f('VL_INICIO', tADM_RESTUSU));
            putitemXml(voParams, 'VL_FIM', item_f('VL_FIM', tADM_RESTUSU));
            putitemXml(voParams, 'CD_USUARIO', vCdUsuario);

            vTpRestricaoLog := 3;
            vInErro := True;

          end else begin

            putitemXml(voParams, 'TP_RESTRICAO', item_f('TP_RESTRICAO', tGLB_RESTRICAO));
            putitemXml(voParams, 'VL_INICIO', item_f('VL_INICIO', tADM_RESTUSU));
            putitemXml(voParams, 'VL_FIM', item_f('VL_FIM', tADM_RESTUSU));
            putitemXml(voParams, 'CD_USUARIO', vCdUsuario);
            vTpRestricaoLog := 1;

          end;
        end;
      end;
    end;
  end else begin
    if (vInValidaCadastro <> False) then begin
      Result := SetStatus(STS_ERROR, 'GEN0001', 'Restrição não cadastrada para o usuário ' + FloatToStr(vCdUsuario) + '.Componente: ' + FloatToStr(vCdComponente) + ' Campo: ' + vDsCampo', + ' '');
      vInErro := True;
      vTpRestricaoLog := 3;
    end else begin
      vInErro := False;
      vTpRestricaoLog := 1;
    end;
    if (item_b('IN_EMPRESA', tF2_GLB_RESTRI) = False ) or (item_b('IN_EMPRESA', tF2_GLB_RESTRI) = '')  and (vInValidaSenha = True) then begin
      viParams := '';
      putitemXml(viParams, 'IN_USULOGADO', True);
      putitemXml(viParams, 'CD_USUARIO', 999999);
      putitemXml(viParams, 'DS_COMPONENTE', vCdComponente);
      putitemXml(viParams, 'DS_HINT', 'Componente: ' + FloatToStr(vCdComponente) + ' / Restrição: ' + vDsCampo') + ';
      voParams := activateCmp('ADMFM020', 'exec', viParams); (*,,, *)
      if (xStatus < 0) then begin
        vInErro := True;
      end;
      vCdUsuarioValidado := itemXmlF('CD_USUARIO', voParams);
      if (vCdUsuarioValidado = '') then begin
        Result := SetStatus(STS_ERROR, 'GEN0001', 'Validação do usuário não concluída.', '');
        vInErro := True;
        vTpRestricaoLog := 3;
        putitemXml(voParams, 'TP_RESTRICAO', item_f('TP_RESTRICAO', tGLB_RESTRICAO));
        putitemXml(voParams, 'VL_INICIO', item_f('VL_INICIO', tADM_RESTUSU));
        putitemXml(voParams, 'VL_FIM', item_f('VL_FIM', tADM_RESTUSU));
        putitemXml(voParams, 'CD_USUARIO', vCdUsuario);
      end else begin
        vInErro := False;
        vTpRestricaoLog := 1;
      end;
    end;
    if (vInRetornoErro = True) then begin
      return(-1); exit;
    end;
  end;

  putitemXml(viLogparams, 'TP_RESTRICAOLOG', vTpRestricaoLog);
  putitemXml(viLogparams, 'VL_INICIOORIGNAL', vInicioOriginal);
  putitemXml(viLogparams, 'VL_FIMORIGINAL', vFimOriginal);
  putitemXml(viLogparams, 'CD_USUARIOLIB', vCdUsuarioValidado);
  putitemXml(viLogparams, 'DS_AUX', vDsAux);

  newinstance 'ADMSVCO010', 'ADMSVCO010', 'TRANSACTION=TRUE';
  voParams := activateCmp('ADMSVCO010', 'gravaLogRestricaoCommit', viParams); (*viLogparams,viLogparams,, *)
  if (xStatus < 0) then begin
    Result := voParams;
    return(-1); exit;
  end;
  if (vInErro <> True) then begin
    return(0); exit;
  end else begin
    return(-1); exit;
  end;
end;

//------------------------------------------------------------------------
function T_ADMSVCO009.verificaUsuarioRestricao(pParams : String) : String;
//------------------------------------------------------------------------
const
  cDS_METHOD = 'ADICIONAL=Operação: T_ADMSVCO009.verificaUsuarioRestricao()';
begin
var
  vCdComponente, vDsCampo, vDsLstUsuario : String;
  vCdEmpresa, vCdGrupoEmpresa : Real;
begin
  vCdComponente := itemXmlF('CD_COMPONENTE', pParams);
  vDsCampo := itemXml('DS_CAMPO', pParams);

  vCdGrupoEmpresa := itemXmlF('CD_GRUPOEMPRESA', PARAM_GLB);

  if (vCdComponente = '') then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Validação de restrição, Componente não informado.', cDS_METHOD);
    return(-1); exit;
  end;
  if (vDsCampo = '') then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Validação de restrição, Campo não iformado.', cDS_METHOD);
    return(-1); exit;
  end;

  clear_e(tF2_GLB_RESTRI);
  putitem_e(tF2_GLB_RESTRI, 'CD_COMPONENTE', vCdComponente);
  putitem_e(tF2_GLB_RESTRI, 'DS_CAMPO', vDsCampo);
  retrieve_e(tF2_GLB_RESTRI);
  if (xStatus < 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Restrição ' + vDsCampo + ' não cadastrada para o componente ' + FloatToStr(vCdComponente) + '. Realizar o cadastro em GLBFM043', cDS_METHOD);
    return(-1); exit;
  end;

  clear_e(tGER_EMPRESA);
  putitem_e(tGER_EMPRESA, 'CD_GRUPOEMPRESA', vCdGrupoEmpresa);
  retrieve_e(tGER_EMPRESA);
  if (xStatus < 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Nenhuma empresa encontrada para grupo de empresa informado!.', cDS_METHOD);
    return(-1); exit;
  end;

  setocc(tGER_EMPRESA, 1);
  while(xStatus >= 0) do begin
    putitem(vCdEmpresa,  item_f('CD_EMPRESA', tGER_EMPRESA));
    setocc(tGER_EMPRESA, curocc(tGER_EMPRESA) + 1);
  end;

  vDsLstUsuario := '';

  clear_e(tADM_RESTUSU);
  putitem_e(tADM_RESTUSU, 'CD_COMPONENTE', vCdComponente);
  putitem_e(tADM_RESTUSU, 'DS_CAMPO', vDsCampo);
  putitem_e(tADM_RESTUSU, 'CD_EMPRESA', vCdEmpresa);
  retrieve_e(tADM_RESTUSU);
  if (xStatus >= 0) then begin
    setocc(tADM_RESTUSU, 1);
    while(xStatus >= 0) do begin
      putitem(vDsLstUsuario,  item_f('CD_USUARIO', tADM_RESTUSU));
      setocc(tADM_RESTUSU, curocc(tADM_RESTUSU) + 1);
    end;
  end;

  Result := '';
  putitemXml(Result, 'DS_LSTUSUARIO', vDsLstUsuario);

  return(0); exit;
end;


end.
