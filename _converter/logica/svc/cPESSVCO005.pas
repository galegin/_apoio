unit cPESSVCO005;

interface

(* COMPONENTES 
  ADMSVCO001 / 
*)        

uses
  Classes, SysUtils, Math, DB,
  cDataSetUnf;

type
  T_PESSVCO005 = class(TComponent)
  private
    tADF_MUNREG,
    tADF_ROTA,
    tGER_EMPRESA,
    tPES_CLASSIFIC,
    tPES_CLIENTE,
    tPES_CLIENTEES,
    tPES_COMPRADOR,
    tPES_CONTATO,
    tPES_EMAIL,
    tPES_ENDERECO,
    tPES_FORNECEDO,
    tPES_FUNCIONAR,
    tPES_GUIA,
    tPES_GUIACLIEN,
    tPES_IESUBTRIB,
    tPES_PESFISICA,
    tPES_PESJURIDI,
    tPES_PESSOA,
    tPES_PESSOACLA,
    tPES_PFADIC,
    tPES_PREFCLIEN,
    tPES_PREFFORNE,
    tPES_REPRCLIEN,
    tPES_REPRESENT,
    tPES_TELEFONE,
    tV_PES_ENDEREC : TcDatasetUnf;
    function getParam(pParams : String = '') : String;
    function setEntidade(pParams : String = '') : String;
  protected
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;    
  published
    function buscaenderecoFaturamento(pParams : String = '') : String;
    function buscaenderecoCobranca(pParams : String = '') : String;
    function verificaAreaComercio(pParams : String = '') : String;
    function buscarendereco(pParams : String = '') : String;
    function buscarTelefone(pParams : String = '') : String;
    function buscaenderecoEtiqueta(pParams : String = '') : String;
    function buscaDadosPessoa(pParams : String = '') : String;
    function buscaTranspAdmFrete(pParams : String = '') : String;
    function buscaDadosComprador(pParams : String = '') : String;
    function buscaEstatisticaCliente(pParams : String = '') : String;
    function buscaDadosPessoaFisica(pParams : String = '') : String;
  end;

implementation

uses
  cADMSVCO001,
  cActivate, cStatus, cFuncao, cXml, dModulo;

var
  gCdPessoaendPadrao,
  gInConsideraMunZFM,
  gInOptSimples : String;

//---------------------------------------------------------------
constructor T_PESSVCO005.Create(AOwner: TComponent);
//---------------------------------------------------------------
begin
  inherited Create(AOwner);
  setEntidade('');
end;

//--------------------------------
destructor T_PESSVCO005.Destroy;
//--------------------------------
begin
  inherited Destroy;
end;

//---------------------------------------------------------------
function T_PESSVCO005.getParam(pParams : String = '') : String;
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
  putitem(xParamEmp, 'CD_PESSOA_endERECO_PADRAO');
  putitem(xParamEmp, 'IN_CONSIDERA_MUN_ZFM');
  putitem(xParamEmp, 'IN_OPT_SIMPLES');

  xParamEmp := T_ADMSVCO001.GetParamEmpresa(piCdEmpresa, xParamEmp);

  gCdPessoaendPadrao := itemXml('CD_PESSOA_endERECO_PADRAO', xParamEmp);
  gInConsideraMunZFM := itemXml('IN_CONSIDERA_MUN_ZFM', xParamEmp);
  inVendaEcf := itemXml('IN_VendA_ECF', xParamEmp);
  vCdEmpresa := itemXml('CD_EMPRESA', xParamEmp);
  vCdPessoa := itemXml('CD_PESSOA', xParamEmp);
  vInOptSimples := itemXml('IN_OPT_SIMPLES', xParamEmp);
  vInSair := itemXml('IN_SAIR', xParamEmp);

end;

//---------------------------------------------------------------
function T_PESSVCO005.setEntidade(pParams : String = '') : String;
//---------------------------------------------------------------
begin
  tADF_MUNREG := TcDatasetUnf.getEntidade('ADF_MUNREG');
  tADF_ROTA := TcDatasetUnf.getEntidade('ADF_ROTA');
  tGER_EMPRESA := TcDatasetUnf.getEntidade('GER_EMPRESA');
  tPES_CLASSIFIC := TcDatasetUnf.getEntidade('PES_CLASSIFIC');
  tPES_CLIENTE := TcDatasetUnf.getEntidade('PES_CLIENTE');
  tPES_CLIENTEES := TcDatasetUnf.getEntidade('PES_CLIENTEES');
  tPES_COMPRADOR := TcDatasetUnf.getEntidade('PES_COMPRADOR');
  tPES_CONTATO := TcDatasetUnf.getEntidade('PES_CONTATO');
  tPES_EMAIL := TcDatasetUnf.getEntidade('PES_EMAIL');
  tPES_ENDERECO := TcDatasetUnf.getEntidade('PES_ENDERECO');
  tPES_FORNECEDO := TcDatasetUnf.getEntidade('PES_FORNECEDO');
  tPES_FUNCIONAR := TcDatasetUnf.getEntidade('PES_FUNCIONAR');
  tPES_GUIA := TcDatasetUnf.getEntidade('PES_GUIA');
  tPES_GUIACLIEN := TcDatasetUnf.getEntidade('PES_GUIACLIEN');
  tPES_IESUBTRIB := TcDatasetUnf.getEntidade('PES_IESUBTRIB');
  tPES_PESFISICA := TcDatasetUnf.getEntidade('PES_PESFISICA');
  tPES_PESJURIDI := TcDatasetUnf.getEntidade('PES_PESJURIDI');
  tPES_PESSOA := TcDatasetUnf.getEntidade('PES_PESSOA');
  tPES_PESSOACLA := TcDatasetUnf.getEntidade('PES_PESSOACLA');
  tPES_PFADIC := TcDatasetUnf.getEntidade('PES_PFADIC');
  tPES_PREFCLIEN := TcDatasetUnf.getEntidade('PES_PREFCLIEN');
  tPES_PREFFORNE := TcDatasetUnf.getEntidade('PES_PREFFORNE');
  tPES_REPRCLIEN := TcDatasetUnf.getEntidade('PES_REPRCLIEN');
  tPES_REPRESENT := TcDatasetUnf.getEntidade('PES_REPRESENT');
  tPES_TELEFONE := TcDatasetUnf.getEntidade('PES_TELEFONE');
  tV_PES_ENDEREC := TcDatasetUnf.getEntidade('V_PES_ENDEREC');
end;

//------------------------------------------------------------------------
function T_PESSVCO005.buscaenderecoFaturamento(pParams : String) : String;
//------------------------------------------------------------------------
const
  cDS_METHOD = 'ADICONAL=Operação: T_PESSVCO005.buscaenderecoFaturamento()';
var
  (* string piGlobal :IN *)
  vCdPessoa, vNrSeqendereco, vCdEmpresa, vInSair : Real;
  inVendaEcf : Boolean;
begin
  vNrSeqendereco := 0;
  vCdPessoa := itemXmlF('CD_PESSOA', pParams);
  inVendaEcf := itemXmlB('IN_VendA_ECF', pParams);
  vInSair := itemXmlB('IN_SAIR', pParams);
  vCdEmpresa := itemXmlF('CD_EMPRESA', PARAM_GLB);

  getParams(pParams); (* vCdEmpresa *)
  if (xStatus < 0) then begin
    return(-1); exit;
  end;
  if (vCdPessoa = 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Código da pessoa não infomado!', cDS_METHOD);
    return(-1); exit;
  end;

  clear_e(tPES_PESSOA);
  putitem_e(tPES_PESSOA, 'CD_PESSOA', vCdPessoa);
  retrieve_e(tPES_PESSOA);
  if (xStatus < 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Pessoa ' + FloatToStr(vCdPessoa) + ' não cadastrada!', cDS_METHOD);
    return(-1); exit;
  end;
  if (item_f('TP_PESSOA', tPES_PESSOA) = 'J') then begin
    if (vNrSeqendereco = 0) then begin
      clear_e(tPES_ENDERECO);
      putitem_e(tPES_ENDERECO, 'CD_TIPOENDERECO', 1);
      retrieve_e(tPES_ENDERECO);
      if (xStatus >= 0) then begin
        vNrSeqendereco= item_f('NR_SEQUENCIA', tPES_ENDERECO);
      end;
    end;
    if (vNrSeqendereco = 0) then begin
      clear_e(tPES_ENDERECO);
      putitem_e(tPES_ENDERECO, 'CD_TIPOENDERECO', 3);
      retrieve_e(tPES_ENDERECO);
      if (xStatus >= 0) then begin
        vNrSeqendereco= item_f('NR_SEQUENCIA', tPES_ENDERECO);
      end;
    end;
    if (vNrSeqendereco = 0) then begin
      clear_e(tPES_ENDERECO);
      putitem_e(tPES_ENDERECO, 'CD_TIPOENDERECO', 4);
      retrieve_e(tPES_ENDERECO);
      if (xStatus >= 0) then begin
        vNrSeqendereco= item_f('NR_SEQUENCIA', tPES_ENDERECO);
      end;
    end;
    if (vNrSeqendereco = 0) then begin
      clear_e(tPES_ENDERECO);
      putitem_e(tPES_ENDERECO, 'CD_TIPOENDERECO', 2);
      retrieve_e(tPES_ENDERECO);
      if (xStatus >= 0) then begin
        vNrSeqendereco= item_f('NR_SEQUENCIA', tPES_ENDERECO);
      end;
    end;
    if (vNrSeqendereco = 0) then begin
      clear_e(tPES_ENDERECO);
      putitem_e(tPES_ENDERECO, 'CD_TIPOENDERECO', 5);
      retrieve_e(tPES_ENDERECO);
      if (xStatus >= 0) then begin
        vNrSeqendereco= item_f('NR_SEQUENCIA', tPES_ENDERECO);
      end;
    end;

  end else begin

    if (vNrSeqendereco = 0) then begin
      clear_e(tPES_ENDERECO);
      putitem_e(tPES_ENDERECO, 'CD_TIPOENDERECO', 2);
      retrieve_e(tPES_ENDERECO);
      if (xStatus >= 0) then begin
        vNrSeqendereco= item_f('NR_SEQUENCIA', tPES_ENDERECO);
      end;
    end;
    if (vNrSeqendereco = 0) then begin
      clear_e(tPES_ENDERECO);
      putitem_e(tPES_ENDERECO, 'CD_TIPOENDERECO', 1);
      retrieve_e(tPES_ENDERECO);
      if (xStatus >= 0) then begin
        vNrSeqendereco= item_f('NR_SEQUENCIA', tPES_ENDERECO);
      end;
    end;
    if (vNrSeqendereco = 0) then begin
      clear_e(tPES_ENDERECO);
      putitem_e(tPES_ENDERECO, 'CD_TIPOENDERECO', 3);
      retrieve_e(tPES_ENDERECO);
      if (xStatus >= 0) then begin
        vNrSeqendereco= item_f('NR_SEQUENCIA', tPES_ENDERECO);
      end;
    end;
    if (vNrSeqendereco = 0) then begin
      clear_e(tPES_ENDERECO);
      putitem_e(tPES_ENDERECO, 'CD_TIPOENDERECO', 4);
      retrieve_e(tPES_ENDERECO);
      if (xStatus >= 0) then begin
        vNrSeqendereco= item_f('NR_SEQUENCIA', tPES_ENDERECO);
      end;
    end;
    if (vNrSeqendereco = 0) then begin
      clear_e(tPES_ENDERECO);
      putitem_e(tPES_ENDERECO, 'CD_TIPOENDERECO', 5);
      retrieve_e(tPES_ENDERECO);
      if (xStatus >= 0) then begin
        vNrSeqendereco= item_f('NR_SEQUENCIA', tPES_ENDERECO);
      end;
    end;
  end;
  if (vNrSeqendereco = 0) then begin
    if (gCdPessoaendPadrao <> '' ) and (inVendaEcf = True) then begin
      vNrSeqendereco := 0;
      vCdPessoa := gCdPessoaendPadrao;

      if (vCdPessoa = 0) then begin
        Result := SetStatus(STS_ERROR, 'GEN0001', 'Código da pessoa não infomado!', cDS_METHOD);
        return(-1); exit;
      end;

      clear_e(tPES_PESSOA);
      putitem_e(tPES_PESSOA, 'CD_PESSOA', vCdPessoa);
      retrieve_e(tPES_PESSOA);
      if (xStatus < 0) then begin
        Result := SetStatus(STS_ERROR, 'GEN0001', 'Pessoa ' + FloatToStr(vCdPessoa) + ' não cadastrada!', cDS_METHOD);
        return(-1); exit;
      end;
      if (item_f('TP_PESSOA', tPES_PESSOA) = 'J') then begin
        if (vNrSeqendereco = 0) then begin
          clear_e(tPES_ENDERECO);
          putitem_e(tPES_ENDERECO, 'CD_TIPOENDERECO', 1);
          retrieve_e(tPES_ENDERECO);
          if (xStatus >= 0) then begin
            vNrSeqendereco= item_f('NR_SEQUENCIA', tPES_ENDERECO);
          end;
        end;
        if (vNrSeqendereco = 0) then begin
          clear_e(tPES_ENDERECO);
          putitem_e(tPES_ENDERECO, 'CD_TIPOENDERECO', 3);
          retrieve_e(tPES_ENDERECO);
          if (xStatus >= 0) then begin
            vNrSeqendereco= item_f('NR_SEQUENCIA', tPES_ENDERECO);
          end;
        end;
        if (vNrSeqendereco = 0) then begin
          clear_e(tPES_ENDERECO);
          putitem_e(tPES_ENDERECO, 'CD_TIPOENDERECO', 4);
          retrieve_e(tPES_ENDERECO);
          if (xStatus >= 0) then begin
            vNrSeqendereco= item_f('NR_SEQUENCIA', tPES_ENDERECO);
          end;
        end;
        if (vNrSeqendereco = 0) then begin
          clear_e(tPES_ENDERECO);
          putitem_e(tPES_ENDERECO, 'CD_TIPOENDERECO', 2);
          retrieve_e(tPES_ENDERECO);
          if (xStatus >= 0) then begin
            vNrSeqendereco= item_f('NR_SEQUENCIA', tPES_ENDERECO);
          end;
        end;
        if (vNrSeqendereco = 0) then begin
          clear_e(tPES_ENDERECO);
          putitem_e(tPES_ENDERECO, 'CD_TIPOENDERECO', 5);
          retrieve_e(tPES_ENDERECO);
          if (xStatus >= 0) then begin
            vNrSeqendereco= item_f('NR_SEQUENCIA', tPES_ENDERECO);
          end;
        end;

      end else begin
        if (vNrSeqendereco = 0) then begin
          clear_e(tPES_ENDERECO);
          putitem_e(tPES_ENDERECO, 'CD_TIPOENDERECO', 2);
          retrieve_e(tPES_ENDERECO);
          if (xStatus >= 0) then begin
            vNrSeqendereco= item_f('NR_SEQUENCIA', tPES_ENDERECO);
          end;
        end;
        if (vNrSeqendereco = 0) then begin
          clear_e(tPES_ENDERECO);
          putitem_e(tPES_ENDERECO, 'CD_TIPOENDERECO', 1);
          retrieve_e(tPES_ENDERECO);
          if (xStatus >= 0) then begin
            vNrSeqendereco= item_f('NR_SEQUENCIA', tPES_ENDERECO);
          end;
        end;
        if (vNrSeqendereco = 0) then begin
          clear_e(tPES_ENDERECO);
          putitem_e(tPES_ENDERECO, 'CD_TIPOENDERECO', 3);
          retrieve_e(tPES_ENDERECO);
          if (xStatus >= 0) then begin
            vNrSeqendereco= item_f('NR_SEQUENCIA', tPES_ENDERECO);
          end;
        end;
        if (vNrSeqendereco = 0) then begin
          clear_e(tPES_ENDERECO);
          putitem_e(tPES_ENDERECO, 'CD_TIPOENDERECO', 4);
          retrieve_e(tPES_ENDERECO);
          if (xStatus >= 0) then begin
            vNrSeqendereco= item_f('NR_SEQUENCIA', tPES_ENDERECO);
          end;
        end;
        if (vNrSeqendereco = 0) then begin
          clear_e(tPES_ENDERECO);
          putitem_e(tPES_ENDERECO, 'CD_TIPOENDERECO', 5);
          retrieve_e(tPES_ENDERECO);
          if (xStatus >= 0) then begin
            vNrSeqendereco= item_f('NR_SEQUENCIA', tPES_ENDERECO);
          end;
        end;
      end;
      if (vNrSeqendereco = 0) then begin
        Result := SetStatus(STS_ERROR, 'GEN0001', 'Nenhum endereço cadastrado p/ a pessoa ' + FloatToStr(vCdPessoa!',) + ' cDS_METHOD);
        return(-1); exit;
      end;
    end else begin
      Result := SetStatus(STS_ERROR, 'GEN0001', 'Nenhum endereço cadastrado p/ a pessoa ' + FloatToStr(vCdPessoa!',) + ' cDS_METHOD);
      return(-1); exit;
    end;
  end;

  Result := '';
  putitemXml(Result, 'NR_SEQendERECO', vNrSeqendereco);
  if (vInSair = 0) then begin
    return(0); exit;
  end;
end;

//---------------------------------------------------------------------
function T_PESSVCO005.buscaenderecoCobranca(pParams : String) : String;
//---------------------------------------------------------------------
const
  cDS_METHOD = 'ADICONAL=Operação: T_PESSVCO005.buscaenderecoCobranca()';
var
  (* string piGlobal :IN *)
  vCdPessoa, vNrSeqendereco : Real;
begin
  Result := '';

  vNrSeqendereco := 0;
  vCdPessoa := itemXmlF('CD_PESSOA', pParams);

  if (vCdPessoa = 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Código da pessoa não infomado!', cDS_METHOD);
    return(-1); exit;
  end;

  clear_e(tPES_PESSOA);
  putitem_e(tPES_PESSOA, 'CD_PESSOA', vCdPessoa);
  retrieve_e(tPES_PESSOA);
  if (xStatus < 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Pessoa ' + FloatToStr(vCdPessoa) + ' não cadastrada!', cDS_METHOD);
    return(-1); exit;
  end;

  clear_e(tPES_ENDERECO);
  putitem_e(tPES_ENDERECO, 'CD_TIPOENDERECO', 3);
  retrieve_e(tPES_ENDERECO);
  if (xStatus >= 0) then begin
    vNrSeqendereco= item_f('NR_SEQUENCIA', tPES_ENDERECO);
  end;
  if (vNrSeqendereco = 0) then begin
    clear_e(tPES_ENDERECO);
    putitem_e(tPES_ENDERECO, 'CD_TIPOENDERECO', 6);
    retrieve_e(tPES_ENDERECO);
    if (xStatus >= 0) then begin
      vNrSeqendereco= item_f('NR_SEQUENCIA', tPES_ENDERECO);
    end;
  end;
  if (item_f('TP_PESSOA', tPES_PESSOA) = 'J') then begin
    if (vNrSeqendereco = 0) then begin
      clear_e(tPES_ENDERECO);
      putitem_e(tPES_ENDERECO, 'CD_TIPOENDERECO', 1);
      retrieve_e(tPES_ENDERECO);
      if (xStatus >= 0) then begin
        vNrSeqendereco= item_f('NR_SEQUENCIA', tPES_ENDERECO);
      end;
    end;
    if (vNrSeqendereco = 0) then begin
      clear_e(tPES_ENDERECO);
      putitem_e(tPES_ENDERECO, 'CD_TIPOENDERECO', 4);
      retrieve_e(tPES_ENDERECO);
      if (xStatus >= 0) then begin
        vNrSeqendereco= item_f('NR_SEQUENCIA', tPES_ENDERECO);
      end;
    end;
    if (vNrSeqendereco = 0) then begin
      clear_e(tPES_ENDERECO);
      putitem_e(tPES_ENDERECO, 'CD_TIPOENDERECO', 5);
      retrieve_e(tPES_ENDERECO);
      if (xStatus >= 0) then begin
        vNrSeqendereco= item_f('NR_SEQUENCIA', tPES_ENDERECO);
      end;
    end;
    if (vNrSeqendereco = 0) then begin
      clear_e(tPES_ENDERECO);
      putitem_e(tPES_ENDERECO, 'CD_TIPOENDERECO', 2);
      retrieve_e(tPES_ENDERECO);
      if (xStatus >= 0) then begin
        vNrSeqendereco= item_f('NR_SEQUENCIA', tPES_ENDERECO);
      end;
    end;
  end else begin
    if (vNrSeqendereco = 0) then begin
      clear_e(tPES_ENDERECO);
      putitem_e(tPES_ENDERECO, 'CD_TIPOENDERECO', 2);
      retrieve_e(tPES_ENDERECO);
      if (xStatus >= 0) then begin
        vNrSeqendereco= item_f('NR_SEQUENCIA', tPES_ENDERECO);
      end;
    end;
    if (vNrSeqendereco = 0) then begin
      clear_e(tPES_ENDERECO);
      putitem_e(tPES_ENDERECO, 'CD_TIPOENDERECO', 4);
      retrieve_e(tPES_ENDERECO);
      if (xStatus >= 0) then begin
        vNrSeqendereco= item_f('NR_SEQUENCIA', tPES_ENDERECO);
      end;
    end;
    if (vNrSeqendereco = 0) then begin
      clear_e(tPES_ENDERECO);
      putitem_e(tPES_ENDERECO, 'CD_TIPOENDERECO', 5);
      retrieve_e(tPES_ENDERECO);
      if (xStatus >= 0) then begin
        vNrSeqendereco= item_f('NR_SEQUENCIA', tPES_ENDERECO);
      end;
    end;
    if (vNrSeqendereco = 0) then begin
      clear_e(tPES_ENDERECO);
      putitem_e(tPES_ENDERECO, 'CD_TIPOENDERECO', 1);
      retrieve_e(tPES_ENDERECO);
      if (xStatus >= 0) then begin
        vNrSeqendereco= item_f('NR_SEQUENCIA', tPES_ENDERECO);
      end;
    end;
  end;
  if (vNrSeqendereco = 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Nenhum endereço cadastrado p/ a pessoa ' + FloatToStr(vCdPessoa!',) + ' cDS_METHOD);
    return(-1); exit;
  end;

  putitemXml(Result, 'NR_SEQendERECO', vNrSeqendereco);

  return(0); exit;
end;

//--------------------------------------------------------------------
function T_PESSVCO005.verificaAreaComercio(pParams : String) : String;
//--------------------------------------------------------------------
const
  cDS_METHOD = 'ADICONAL=Operação: T_PESSVCO005.verificaAreaComercio()';
var
  vNmMunicipio, vDsSiglaEstado : String;
  vCdPessoa, vTpAreaComercio, vCdEmpresa : Real;
begin
  vCdPessoa := itemXmlF('CD_PESSOA', pParams);
  vNmMunicipio := itemXml('NM_MUNICIPIO', pParams);
  vDsSiglaEstado := itemXml('DS_SIGLAESTADO', pParams);
  vCdEmpresa := itemXmlF('CD_EMPRESA', PARAM_GLB);

  if (vCdPessoa = 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Pessoa não infomada!', cDS_METHOD);
    return(-1); exit;
  end;
  if (vNmMunicipio = '') then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Município não infomado!', cDS_METHOD);
    return(-1); exit;
  end;
  if (vDsSiglaEstado = '') then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'UF não infomado!', cDS_METHOD);
    return(-1); exit;
  end;

  getParams(pParams); (* vCdEmpresa *)
  if (xStatus < 0) then begin
    return(-1); exit;
  end;

  clear_e(tPES_PESSOA);
  putitem_e(tPES_PESSOA, 'CD_PESSOA', vCdPessoa);
  retrieve_e(tPES_PESSOA);
  if (xStatus < 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Pessoa ' + FloatToStr(vCdPessoa) + ' não cadastrada!', cDS_METHOD);
    return(-1); exit;
  end;

  vTpAreaComercio := 0;

  if (gInOptSimples = True) then begin
  end else begin
    if (vNmMunicipio = 'MACAPA')  and (vDsSiglaEstado = 'AP') then begin
      vTpAreaComercio := 1;
    end else if (vNmMunicipio = 'SANTANA')  and (vDsSiglaEstado = 'AP') then begin
      vTpAreaComercio := 1;
    end else if (vNmMunicipio = 'BONFIM')  and (vDsSiglaEstado = 'RR') then begin
      vTpAreaComercio := 1;
    end else if (vNmMunicipio = 'BOA VISTA')  and (vDsSiglaEstado = 'RR') then begin
      vTpAreaComercio := 1;
    end else if (vNmMunicipio = 'TABATINGA')  and (vDsSiglaEstado = 'AM') then begin
      vTpAreaComercio := 1;
    end else if (vNmMunicipio = 'MANAUS')  and (vDsSiglaEstado = 'AM') then begin
      vTpAreaComercio := 2;
    end else if (vNmMunicipio = 'GUAJARA-MIRIM')  and (vDsSiglaEstado = 'RO') then begin
      vTpAreaComercio := 1;
    end else if (vNmMunicipio = 'GUAJARAMIRIM')  and (vDsSiglaEstado = 'RO') then begin
      vTpAreaComercio := 1;
    end else if (vNmMunicipio = 'GUAJARA MIRIM')  and (vDsSiglaEstado = 'RO') then begin
      vTpAreaComercio := 1;
    end else if (vNmMunicipio = 'BRASILEIA')  and (vDsSiglaEstado = 'AC') then begin
      vTpAreaComercio := 1;
    end else if (vNmMunicipio = 'EPITACIOLANDIA')  and (vDsSiglaEstado = 'AC') then begin
      vTpAreaComercio := 1;
    end else if (vNmMunicipio = 'CRUZEIRO DO SUL')  and (vDsSiglaEstado = 'AC') then begin
      vTpAreaComercio := 1;

    end else if (vNmMunicipio = 'RIO PRETO DA EVA')  and (vDsSiglaEstado = 'AM')  and (gInConsideraMunZFM = True) then begin
      vTpAreaComercio := 2;
    end else if (vNmMunicipio = 'PRESIDENTE FIGUEIREDO')  and (vDsSiglaEstado = 'AM')  and (gInConsideraMunZFM = True) then begin
      vTpAreaComercio := 2;

    end;
  end;
  if (vTpAreaComercio > 0) then begin
    clear_e(tPES_CLIENTE);
    retrieve_e(tPES_CLIENTE);
    if (xStatus >= 0) then begin
      if (item_f('NR_SUFRAMA', tPES_CLIENTE) = 0) then begin
        vTpAreaComercio := 0;
      end;
    end else begin
      vTpAreaComercio := 0;
    end;
  end;

  Result := '';
  putitemXml(Result, 'TP_AREACOMERCIO', vTpAreaComercio);

  return(0); exit;
end;

//--------------------------------------------------------------
function T_PESSVCO005.buscarendereco(pParams : String) : String;
//--------------------------------------------------------------
const
  cDS_METHOD = 'ADICONAL=Operação: T_PESSVCO005.buscarendereco()';
var
  vCdPessoa, vCdTipoendereco, vNrSequencia, vCdEmpresa : Real;
  vDsendereco, vDsMunicipio : String;
  vInVerificaendPadrao, vInQualquerend : Boolean;
begin
  vInQualquerend := itemXml('ÏN_QUALQUERend', pParams);
  vInVerificaendPadrao := itemXmlB('IN_VERIFICAendPADRAO', pParams);
  vCdTipoendereco := itemXmlF('CD_TIPOendERECO', pParams);
  vNrSequencia := itemXmlF('NR_SEQUENCIA', pParams);
  vCdPessoa := itemXmlF('CD_PESSOA', pParams);
  vCdEmpresa := itemXmlF('CD_EMPRESA', PARAM_GLB);

  if (vCdPessoa = '') then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Pessoa não infomada!', cDS_METHOD);
    return(-1); exit;
  end;

  getParams(pParams); (* vCdEmpresa *)
  if (xStatus < 0) then begin
    Result := voParams;
    return(-1); exit;
  end;

  clear_e(tV_PES_ENDEREC);
  putitem_e(tV_PES_ENDEREC, 'CD_PESSOA', vCdPessoa);
  if (vCdTipoendereco <> '') then begin
    putitem_e(tV_PES_ENDEREC, 'CD_TIPOENDERECO', vCdTipoendereco);
  end;
  if (vNrSequencia <> '') then begin
    putitem_e(tV_PES_ENDEREC, 'NR_SEQUENCIA', vNrSequencia);
  end;
  retrieve_e(tV_PES_ENDEREC);
  if (xStatus < 0) then begin
    if (vInVerificaendPadrao = True)  and (gCdPessoaendPadrao <> '') then begin
      clear_e(tV_PES_ENDEREC);
      putitem_e(tV_PES_ENDEREC, 'CD_PESSOA', gCdPessoaendPadrao);
      if (vCdTipoendereco <> '') then begin
        putitem_e(tV_PES_ENDEREC, 'CD_TIPOENDERECO', vCdTipoendereco);
      end;
      if (vNrSequencia <> '') then begin
        putitem_e(tV_PES_ENDEREC, 'NR_SEQUENCIA', vCdTipoendereco);
      end;
      retrieve_e(tV_PES_ENDEREC);
      if (xStatus < 0) then begin
        Result := SetStatus(STS_ERROR, 'GEN0001', 'Tipo de endereco (' + FloatToStr(vCdTipoendereco)) + ' não cadastrada para a pessoa (' + FloatToStr(gCdPessoaendPadrao)!',) + ' cDS_METHOD);
        return(-1); exit;
      end;
    end else if (vInQualquerend = True) then begin
      clear_e(tV_PES_ENDEREC);
      putitem_e(tV_PES_ENDEREC, 'CD_PESSOA', vCdPEssoa);
      retrieve_e(tV_PES_ENDEREC);
    end else begin
      Result := SetStatus(STS_ERROR, 'GEN0001', 'Tipo de endereco (' + FloatToStr(vCdTipoendereco)) + ' não cadastrada para a pessoa (' + FloatToStr(vCdPessoa)!',) + ' cDS_METHOD);
      return(-1); exit;
    end;
  end;

  clear_e(tPES_ENDERECO);
  putitem_e(tPES_ENDERECO, 'CD_PESSOA', vCdPessoa);
  putitem_e(tPES_ENDERECO, 'NR_SEQUENCIA', vNrSequencia);
  retrieve_e(tPES_ENDERECO);

  vDsendereco := '' + item_a('DS_SIGLALOGRAD', tV_PES_ENDEREC) + ' ' + item_a('NM_LOGRADOURO', tV_PES_ENDEREC) + ' ' + item_f('NR_LOGRADOURO', tV_PES_ENDEREC)' + ';
  vDsendereco := '' + vDsendereco + ' ' + item_a('DS_COMPLEMENTO', tV_PES_ENDEREC) + ' - ' + item_a('DS_BAIRRO', tV_PES_ENDEREC)' + ';
  vDsendereco := '' + vDsendereco + ' - ' + item_a('NM_MUNICIPIO', tV_PES_ENDEREC) + ' - ' + item_a('DS_SIGLAESTADO', tV_PES_ENDEREC) + ' cep:' + item_f('CD_CEP', tV_PES_ENDEREC)' + ';
  vDsMunicipio := '' + item_a('NM_MUNICIPIO', tV_PES_ENDEREC) + ' - ' + item_a('DS_SIGLAESTADO', tV_PES_ENDEREC)' + ';

  Result := '';
  putitemXml(Result, 'CD_PESSOA', item_f('CD_PESSOA', tV_PES_ENDEREC));
  putitemXml(Result, 'NM_PESSOA', item_a('NM_PESSOA', tV_PES_ENDEREC));
  putitemXml(Result, 'TP_PESSOA', item_f('TP_PESSOA', tV_PES_ENDEREC));
  putitemXml(Result, 'IN_INATIVO', item_b('IN_INATIVO', tV_PES_ENDEREC));
  putitemXml(Result, 'NR_CPFCNPJ', item_f('NR_CPFCNPJ', tV_PES_ENDEREC));
  putitemXml(Result, 'NR_SEQUENCIA', item_f('NR_SEQUENCIA', tV_PES_ENDEREC));
  putitemXml(Result, 'CD_TIPOendERECO', item_f('CD_TIPOENDERECO', tV_PES_ENDEREC));
  putitemXml(Result, 'NM_PAIS', item_a('NM_PAIS', tV_PES_ENDEREC));
  putitemXml(Result, 'DS_SIGLAESTADO', item_a('DS_SIGLAESTADO', tV_PES_ENDEREC));
  putitemXml(Result, 'CD_MUNICIPIO', item_f('CD_MUNICIPIO', tPES_ENDERECO));
  putitemXml(Result, 'NM_MUNICIPIO', item_a('NM_MUNICIPIO', tV_PES_ENDEREC));
  putitemXml(Result, 'CD_CEP', '' + item_f('CD_CEP', tV_PES_ENDEREC)') + ';
  putitemXml(Result, 'DS_SIGLALOGRAD', item_a('DS_SIGLALOGRAD', tV_PES_ENDEREC));
  putitemXml(Result, 'NM_LOGRADOURO', item_a('NM_LOGRADOURO', tV_PES_ENDEREC));
  putitemXml(Result, 'NR_LOGRADOURO', item_f('NR_LOGRADOURO', tV_PES_ENDEREC));
  putitemXml(Result, 'DS_COMPLEMENTO', item_a('DS_COMPLEMENTO', tV_PES_ENDEREC));
  putitemXml(Result, 'DS_REFERENCIA', item_a('DS_REFERENCIA', tV_PES_ENDEREC));
  putitemXml(Result, 'NR_CAIXAPOSTAL', item_f('NR_CAIXAPOSTAL', tV_PES_ENDEREC));
  putitemXml(Result, 'DS_BAIRRO', item_a('DS_BAIRRO', tV_PES_ENDEREC));
  putitemXml(Result, 'DS_endERECO', vDsendereco);
  putitemXml(Result, 'DS_MUNICIPIO', vDsMunicipio);
  return(0); exit;
end;

//--------------------------------------------------------------
function T_PESSVCO005.buscarTelefone(pParams : String) : String;
//--------------------------------------------------------------
const
  cDS_METHOD = 'ADICONAL=Operação: T_PESSVCO005.buscarTelefone()';
var
  vCdPessoa,vCdTipoFone, vNrSeq : Real;
  vInRetornaTodos : Boolean;
begin
  vInRetornaTodos := itemXmlB('IN_RETORNATODOS', pParams);
  vCdPessoa := itemXmlF('CD_PESSOA', pParams);
  if (vCdPessoa = '') then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Pessoa não infomada!', cDS_METHOD);
    return(-1); exit;
  end;

  vCdTipoFone := itemXmlF('CD_TIPOFONE', pParams);

  clear_e(tPES_PESSOA);
  putitem_e(tPES_PESSOA, 'CD_PESSOA', vCdPessoa);
  retrieve_e(tPES_PESSOA);
  if (xStatus >= 0) then begin
    if (vInRetornaTodos = True) then begin
      vNrseq := 1;
      clear_e(tPES_TELEFONE);
      retrieve_e(tPES_TELEFONE);
      if (xStatus >= 0) then begin
        setocc(tPES_TELEFONE, 1);
        while(xStatus >= 0) do begin
          if (item_f('NR_TELEFONE', tPES_TELEFONE) <> '') then begin
            putitemXml(Result, 'NR_TELEFONE' + FloatToStr(vNrSeq',) + ' item_f('NR_TELEFONE', tPES_TELEFONE));
            vNrseq := vNrSeq + 1;
          end;
          setocc(tPES_TELEFONE, curocc(tPES_TELEFONE) + 1);
        end;
      end;
    end else if (vCdTipoFone <> '') then begin
      clear_e(tPES_TELEFONE);
      putitem_e(tPES_TELEFONE, 'CD_TIPOFONE', vCdTipoFone);
      retrieve_e(tPES_TELEFONE);
    end else begin
      clear_e(tPES_TELEFONE);
      putitem_e(tPES_TELEFONE, 'IN_PADRAO', True);
      retrieve_e(tPES_TELEFONE);
      if (xStatus < 0) then begin
        clear_e(tPES_TELEFONE);
        retrieve_e(tPES_TELEFONE);
      end;
    end;
  end;
  if (vInRetornaTodos <> True) then begin
    putitemXml(Result, 'NR_TELEFONE', item_f('NR_TELEFONE', tPES_TELEFONE));
    putitemXml(Result, 'NR_RAMAL', item_f('NR_RAMAL', tPES_TELEFONE));
  end;

  return(0); exit;
end;

//---------------------------------------------------------------------
function T_PESSVCO005.buscaenderecoEtiqueta(pParams : String) : String;
//---------------------------------------------------------------------
const
  cDS_METHOD = 'ADICONAL=Operação: T_PESSVCO005.buscaenderecoEtiqueta()';
var
  (* string piGlobal :IN *)
  vCdPessoa, vNrSeqendereco : Real;
begin
  Result := '';

  vNrSeqendereco := 0;
  vCdPessoa := itemXmlF('CD_PESSOA', pParams);

  if (vCdPessoa = 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Código da pessoa não infomado!', cDS_METHOD);
    return(-1); exit;
  end;

  clear_e(tPES_PESSOA);
  putitem_e(tPES_PESSOA, 'CD_PESSOA', vCdPessoa);
  retrieve_e(tPES_PESSOA);
  if (xStatus < 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Pessoa ' + FloatToStr(vCdPessoa) + ' não cadastrada!', cDS_METHOD);
    return(-1); exit;
  end;
  if (item_f('TP_PESSOA', tPES_PESSOA) = 'J') then begin
    if (vNrSeqendereco = 0) then begin
      clear_e(tPES_ENDERECO);
      putitem_e(tPES_ENDERECO, 'CD_TIPOENDERECO', 1);
      retrieve_e(tPES_ENDERECO);
      if (xStatus >= 0) then begin
        vNrSeqendereco= item_f('NR_SEQUENCIA', tPES_ENDERECO);
      end;
    end;
    if (vNrSeqendereco = 0) then begin
      clear_e(tPES_ENDERECO);
      putitem_e(tPES_ENDERECO, 'CD_TIPOENDERECO', 3);
      retrieve_e(tPES_ENDERECO);
      if (xStatus >= 0) then begin
        vNrSeqendereco= item_f('NR_SEQUENCIA', tPES_ENDERECO);
      end;
    end;
    if (vNrSeqendereco = 0) then begin
      clear_e(tPES_ENDERECO);
      putitem_e(tPES_ENDERECO, 'CD_TIPOENDERECO', 4);
      retrieve_e(tPES_ENDERECO);
      if (xStatus >= 0) then begin
        vNrSeqendereco= item_f('NR_SEQUENCIA', tPES_ENDERECO);
      end;
    end;
    if (vNrSeqendereco = 0) then begin
      clear_e(tPES_ENDERECO);
      putitem_e(tPES_ENDERECO, 'CD_TIPOENDERECO', 5);
      retrieve_e(tPES_ENDERECO);
      if (xStatus >= 0) then begin
        vNrSeqendereco= item_f('NR_SEQUENCIA', tPES_ENDERECO);
      end;
    end;
    if (vNrSeqendereco = 0) then begin
      clear_e(tPES_ENDERECO);
      putitem_e(tPES_ENDERECO, 'CD_TIPOENDERECO', 6);
      retrieve_e(tPES_ENDERECO);
      if (xStatus >= 0) then begin
        vNrSeqendereco= item_f('NR_SEQUENCIA', tPES_ENDERECO);
      end;
    end;
    if (vNrSeqendereco = 0) then begin
      clear_e(tPES_ENDERECO);
      putitem_e(tPES_ENDERECO, 'CD_TIPOENDERECO', 2);
      retrieve_e(tPES_ENDERECO);
      if (xStatus >= 0) then begin
        vNrSeqendereco= item_f('NR_SEQUENCIA', tPES_ENDERECO);
      end;
    end;
  end else begin
    if (vNrSeqendereco = 0) then begin
      clear_e(tPES_ENDERECO);
      putitem_e(tPES_ENDERECO, 'CD_TIPOENDERECO', 2);
      retrieve_e(tPES_ENDERECO);
      if (xStatus >= 0) then begin
        vNrSeqendereco= item_f('NR_SEQUENCIA', tPES_ENDERECO);
      end;
    end;
    if (vNrSeqendereco = 0) then begin
      clear_e(tPES_ENDERECO);
      putitem_e(tPES_ENDERECO, 'CD_TIPOENDERECO', 3);
      retrieve_e(tPES_ENDERECO);
      if (xStatus >= 0) then begin
        vNrSeqendereco= item_f('NR_SEQUENCIA', tPES_ENDERECO);
      end;
    end;
    if (vNrSeqendereco = 0) then begin
      clear_e(tPES_ENDERECO);
      putitem_e(tPES_ENDERECO, 'CD_TIPOENDERECO', 4);
      retrieve_e(tPES_ENDERECO);
      if (xStatus >= 0) then begin
        vNrSeqendereco= item_f('NR_SEQUENCIA', tPES_ENDERECO);
      end;
    end;
    if (vNrSeqendereco = 0) then begin
      clear_e(tPES_ENDERECO);
      putitem_e(tPES_ENDERECO, 'CD_TIPOENDERECO', 5);
      retrieve_e(tPES_ENDERECO);
      if (xStatus >= 0) then begin
        vNrSeqendereco= item_f('NR_SEQUENCIA', tPES_ENDERECO);
      end;
    end;
    if (vNrSeqendereco = 0) then begin
      clear_e(tPES_ENDERECO);
      putitem_e(tPES_ENDERECO, 'CD_TIPOENDERECO', 6);
      retrieve_e(tPES_ENDERECO);
      if (xStatus >= 0) then begin
        vNrSeqendereco= item_f('NR_SEQUENCIA', tPES_ENDERECO);
      end;
    end;
    if (vNrSeqendereco = 0) then begin
      clear_e(tPES_ENDERECO);
      putitem_e(tPES_ENDERECO, 'CD_TIPOENDERECO', 1);
      retrieve_e(tPES_ENDERECO);
      if (xStatus >= 0) then begin
        vNrSeqendereco= item_f('NR_SEQUENCIA', tPES_ENDERECO);
      end;
    end;
  end;

  putitemXml(Result, 'NR_SEQendERECO', vNrSeqendereco);

  return(0); exit;
end;

//----------------------------------------------------------------
function T_PESSVCO005.buscaDadosPessoa(pParams : String) : String;
//----------------------------------------------------------------
const
  cDS_METHOD = 'ADICONAL=Operação: T_PESSVCO005.buscaDadosPessoa()';
var
  vCdEmpresa, vCdPessoa, vCdTipoClas : Real;
  vNmEmpresa : String;
  vDsSiglaUf : String;
begin
  vCdEmpresa := itemXmlF('CD_EMPRESA', pParams);
  vCdPessoa := itemXmlF('CD_PESSOA', pParams);
  vDsSiglaUf := itemXml('DS_SIGLAUF', pParams);
  vCdTipoClas := itemXmlF('CD_TIPOCLAS', pParams);

  if (vCdPessoa = 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Pessoa não informado!', cDS_METHOD);
    return(-1); exit;
  end;
  if (vCdEmpresa = 0) then begin
    vCdEmpresa := itemXmlF('CD_EMPRESA', PARAM_GLB);
  end else begin
    clear_e(tGER_EMPRESA);
    putitem_e(tGER_EMPRESA, 'CD_EMPRESA', vCdEmpresa);
    retrieve_e(tGER_EMPRESA);
    if (xStatus >= 0) then begin
      clear_e(tPES_PESSOA);
      putitem_e(tPES_PESSOA, 'CD_PESSOA', item_f('CD_PESSOA', tGER_EMPRESA));
      retrieve_e(tPES_PESSOA);
      if (xStatus >= 0) then begin
        vNmEmpresa := item_a('NM_PESSOA', tPES_PESSOA);
      end;
    end;
  end;

  clear_e(tPES_PESSOA);
  putitem_e(tPES_PESSOA, 'CD_PESSOA', vCdPessoa);
  retrieve_e(tPES_PESSOA);
  if (xStatus < 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Pessoa ' + FloatToStr(vCdPessoa) + ' não cadastrada!', cDS_METHOD);
    return(-1); exit;
  end;

  clear_e(tPES_CLIENTE);
  putitem_e(tPES_CLIENTE, 'CD_CLIENTE', vCdPessoa);
  retrieve_e(tPES_CLIENTE);
  if (xStatus < 0) then begin
    clear_e(tPES_CLIENTE);
  end;

  clear_e(tPES_CLIENTEES);
  putitem_e(tPES_CLIENTEES, 'CD_EMPRESA', vCdEmpresa);
  putitem_e(tPES_CLIENTEES, 'CD_CLIENTE', vCdPessoa);
  retrieve_e(tPES_CLIENTEES);
  if (xStatus < 0) then begin
    clear_e(tPES_CLIENTEES);
  end;

  clear_e(tPES_GUIACLIEN);
  putitem_e(tPES_GUIACLIEN, 'CD_CLIENTE', vCdPessoa);
  retrieve_e(tPES_GUIACLIEN);
  if (xStatus < 0) then begin
    clear_e(tPES_GUIACLIEN);
  end;

  clear_e(tPES_REPRCLIEN);
  putitem_e(tPES_REPRCLIEN, 'CD_CLIENTE', vCdPessoa);
  retrieve_e(tPES_REPRCLIEN);
  if (xStatus < 0) then begin
    clear_e(tPES_REPRCLIEN);
  end;

  clear_e(tPES_IESUBTRIB);
  putitem_e(tPES_IESUBTRIB, 'CD_PESSOA', vCdPessoa);
  putitem_e(tPES_IESUBTRIB, 'DS_SIGLAUF', vDsSiglaUf);
  retrieve_e(tPES_IESUBTRIB);
  if (xStatus < 0) then begin
    clear_e(tPES_IESUBTRIB);
  end;

  clear_e(tPES_PESSOACLA);
  putitem_e(tPES_PESSOACLA, 'CD_PESSOA', vCdPessoa);
  putitem_e(tPES_PESSOACLA, 'CD_TIPOCLAS', vCdTipoClas);
  retrieve_e(tPES_PESSOACLA);
  if (xStatus < 0) then begin
    clear_e(tPES_PESSOACLA);
  end;

  clear_e(tPES_EMAIL);
  putitem_e(tPES_EMAIL, 'CD_PESSOA', vCdPessoa);
  putitem_e(tPES_EMAIL, 'IN_PADRAO', True);
  retrieve_e(tPES_EMAIL);
  if (xStatus >= 0) then begin
  end else begin
    clear_e(tPES_EMAIL);
    putitem_e(tPES_EMAIL, 'CD_PESSOA', vCdPessoa);
    retrieve_e(tPES_EMAIL);
    if (xStatus < 0) then begin
      clear_e(tPES_EMAIL);
    end;
  end;

  Result := '';
  putitemXml(Result, 'TP_PESSOA', item_f('TP_PESSOA', tPES_PESSOA));
  putitemXml(Result, 'DT_PRIMCOMPRA', item_a('DT_PRIMCOMPRA', tPES_CLIENTEES));
  putitemXml(Result, 'DT_ULTCOMPRA', item_a('DT_ULTCOMPRA', tPES_CLIENTEES));
  putitemXml(Result, 'QT_COMPRAS', item_f('QT_COMPRAS', tPES_CLIENTEES));
  putitemXml(Result, 'CD_GUIA', item_f('CD_GUIA', tPES_GUIACLIEN));
  putitemXml(Result, 'CD_REPRESENTANT', item_f('CD_REPRESENTANT', tPES_REPRCLIEN));
  putitemXml(Result, 'NM_PESSOA', item_a('NM_PESSOA', tPES_PESSOA));
  putitemXml(Result, 'NR_CPFCNPJ', item_f('NR_CPFCNPJ', tPES_PESSOA));
  putitemXml(Result, 'NM_FANTASIA', item_a('NM_FANTASIA', tPES_PESJURIDI));
  putitemXml(Result, 'NR_INSCESTL', item_f('NR_INSCESTL', tPES_PESJURIDI));
  putitemXml(Result, 'TP_REGIMETRIB', item_f('TP_REGIMETRIB', tPES_PESJURIDI));
  putitemXml(Result, 'NR_RG', item_f('NR_RG', tPES_PESFISICA));
  putitemXml(Result, 'NR_SUFRAMA', item_f('NR_SUFRAMA', tPES_CLIENTE));
  putitemXml(Result, 'CD_IESUBTRIB', item_f('CD_IESUBTRIB', tPES_IESUBTRIB));
  putitemXml(Result, 'NR_PRZMEDIOMAX', item_f('NR_PRZMEDIOMAX', tPES_PREFCLIEN));
  putitemXml(Result, 'CD_CLASSIFICACAO', item_f('CD_CLASSIFICACAO', tPES_PESSOACLA));
  putitemXml(Result, 'DS_CLASSIFICACAO', item_a('DS_CLASSIFICACAO', tPES_CLASSIFIC));
  putitemXml(Result, 'NM_EMPRESA', vNmEmpresa);
  putitemXml(Result, 'NM_CONTATO', item_a('NM_CONTATO', tPES_CONTATO));
  putitemXml(Result, 'NR_FONECONTATO', item_f('NR_TELEFONE', tPES_CONTATO));
  putitemXml(Result, 'IN_INATIVOPES', item_b('IN_INATIVO', tPES_PESSOA));
  putitemXml(Result, 'IN_BLOQUEADOCLI', item_b('IN_BLOQUEADO', tPES_CLIENTE));
  putitemXml(Result, 'IN_INATIVOCLI', item_b('IN_INATIVO', tPES_CLIENTE));
  if (empty(tPES_FORNECEDO) = False) then begin
    putitemXml(Result, 'IN_INATIVOFOR', item_b('IN_INATIVO', tPES_FORNECEDO));
    putitemXml(Result, 'PR_MARKUPFOR', item_f('PR_MARKUP', tPES_PREFFORNE));
  end else begin
    putitemXml(Result, 'IN_INATIVOFOR', False);
  end;

  putitemXml(Result, 'IN_GUIAINATIVO', item_b('IN_INATIVO', tPES_GUIA));
  putitemXml(Result, 'IN_GUIABLOQUEADO', item_b('IN_BLOQUEADO', tPES_GUIA));
  putitemXml(Result, 'IN_REPREINATIVO', item_b('IN_INATIVO', tPES_REPRESENT));
  putitemXml(Result, 'IN_REPREBLOQUEADO', item_b('IN_BLOQUEADO', tPES_REPRESENT));
  putitemXml(Result, 'DS_EMAIL', item_a('DS_EMAIL', tPES_EMAIL));
  putitemXml(Result, 'DS_HOMEPAGE', item_a('DS_HOMEPAGE', tPES_PESSOA));
  putitemXml(Result, 'DT_NASCIMENTO', item_a('DT_NASCIMENTO', tPES_PESFISICA));
  putitemXml(Result, 'IN_CNSRFINAL', item_b('IN_CNSRFINAL', tPES_CLIENTE));
  putitemXml(Result, 'NR_CODIGOFISCAL', item_f('NR_CODIGOFISCAL', tPES_CLIENTE));

  if (empty(tPES_PREFFORNE) = False) then begin
    if (item_b('IN_FRETEPAGO', tPES_PREFFORNE) = True) then begin
      putitemXml(Result, 'TP_FRETE', 1);
    end else begin
      putitemXml(Result, 'TP_FRETE', 2);
    end;

    putitemXml(Result, 'CD_CONDPGTO', item_f('CD_CONDPGTO', tPES_PREFFORNE));
    putitemXml(Result, 'CD_TRANSPORT', item_f('CD_TRANSPORT', tPES_PREFFORNE));
    putitemXml(Result, 'TP_FORMAPGTO', item_f('TP_FORMAPGTO', tPES_PREFFORNE));
    putitemXml(Result, 'TP_FORMAPGTOPADRAO', item_f('TP_FORMAPGTOPADRAO', tPES_PREFFORNE));
  end;

  if not (empty(tPES_FUNCIONAR)) then begin
    putitemXml(Result, 'CD_AUXILIAR', item_f('CD_AUXILIAR', tPES_FUNCIONAR));
  end;

  return(0); exit;
end;

//-------------------------------------------------------------------
function T_PESSVCO005.buscaTranspAdmFrete(pParams : String) : String;
//-------------------------------------------------------------------
const
  cDS_METHOD = 'ADICONAL=Operação: T_PESSVCO005.buscaTranspAdmFrete()';
var
  vCdCliente, vNrSeqendereco, vCdMunicipio, vCdEmpresa, vCdPessoa, vCdMunicipioOr, vCdMunicipioEmp : Real;
  vCdTranspR, vCdRotaREDESPACHO : Real;
  vDsUf, vDsUfOr, vDsUfOrR : String;
  vCdTransport, vCdTransRedespac : Real;
  viParams, voParams : String;
begin
  vCdCliente := itemXmlF('CD_CLIENTE', pParams);

  if (vCdCliente= 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Cliente não informado!', cDS_METHOD);
    return(-1); exit;
  end;

  viParams := '';
  putitemXml(viParams, 'CD_PESSOA', vCdCliente);
  putitemXml(viParams, 'IN_SAIR', 1);

  if (xStatus < 0) then begin
    Result := voParams;
    return(-1); exit;
  end;
  if (xStatus >= 0) then begin
    vNrSeqendereco := itemXmlF('NR_SEQendERECO', voParams);
    viParams := '';
    putitemXml(viParams, 'CD_PESSOA', vCdCliente);
    putitemXml(viParams, 'NR_SEQUENCIA', vNrSeqendereco);

    if (xStatus < 0) then begin
      Result := voParams;
      return(-1); exit;
    end;

    vDsUf := itemXml('DS_SIGLAESTADO', voParams);
    vCdMunicipio := itemXmlF('CD_MUNICIPIO', voParams);
  end;

  vCdEmpresa := itemXmlF('CD_EMPRESA', PARAM_GLB);
  clear_e(tGER_EMPRESA);
  putitem_e(tGER_EMPRESA, 'CD_EMPRESA', vCdEmpresa);
  retrieve_e(tGER_EMPRESA);
  vCdPessoa := item_f('CD_PESSOA', tGER_EMPRESA);
  viParams := '';
  putitemXml(viParams, 'CD_PESSOA', vCdPessoa);
  putitemXml(viParams, 'CD_TIPOendERECO', 1);
  if (xStatus < 0) then begin
    Result := voParams;
    return(-1); exit;
  end;

  vDsUfOr := itemXml('DS_SIGLAESTADO', voParams);
  vCdMunicipioOr := itemXmlF('CD_MUNICIPIO', voParams);
  vCdMunicipioEmp := itemXmlF('CD_MUNICIPIO', voParams);

  vCdTransport := '';
  vCdTransRedespac := '';

  clear_e(tADF_ROTA);
  putitem_e(tADF_ROTA, 'CD_UFORIGEM', vDsUfOr);
  putitem_e(tADF_ROTA, 'CD_CIDADEORIGEM', vCdMunicipioOr);
  putitem_e(tADF_ROTA, 'CD_UFDESTINO', vDsUf);
  putitem_e(tADF_ROTA, 'CD_CIDADESTINO', vCdMunicipio);
  retrieve_e(tADF_ROTA);
  if (xStatus >= 0) then begin
    vCdTransport := item_f('CD_TRANSPATIVA', tADF_ROTA);
  end else begin

    clear_e(tADF_ROTA);
    putitem_e(tADF_ROTA, 'CD_UFDESTINO', vDsUf);
    putitem_e(tADF_ROTA, 'CD_CIDADESTINO', vCdMunicipio);
    retrieve_e(tADF_ROTA);
    if (xStatus >=0) then begin
      vCdTranspR := item_f('CD_TRANSPATIVA', tADF_ROTA);
      vCdRotaREDESPACHO := item_f('CD_ROTA', tADF_ROTA);
      vCdMunicipioOr := item_f('CD_CIDADEORIGEM', tADF_ROTA);
      vDsUfOrR := item_f('CD_UFORIGEM', tADF_ROTA);
      clear_e(tADF_ROTA);
      putitem_e(tADF_ROTA, 'CD_UFORIGEM', vDsUfOr);
      putitem_e(tADF_ROTA, 'CD_CIDADEORIGEM', vCdMunicipioEmp);
      putitem_e(tADF_ROTA, 'CD_UFDESTINO', vDsUfOrR);
      putitem_e(tADF_ROTA, 'CD_CIDADESTINO', vCdMunicipioOr);
      retrieve_e(tADF_ROTA);
      if (xStatus >= 0) then begin
        vCdTransport := item_f('CD_TRANSPATIVA', tADF_ROTA);
        vCdTransRedespac := vCdTranspR;
      end;
    end;
  end;
  if (vCdTransport = 0) then begin
    clear_e(tADF_MUNREG);
    putitem_e(tADF_MUNREG, 'CD_UFDESTINO', vDsUf);
    putitem_e(tADF_MUNREG, 'CD_CIDADESTINO', vCdMunicipio);
    retrieve_e(tADF_MUNREG);
    if (xStatus >= 0) then begin
      clear_e(tADF_ROTA);
      putitem_e(tADF_ROTA, 'CD_UFORIGEM', vDsUfOr);
      putitem_e(tADF_ROTA, 'CD_CIDADEORIGEM', vCdMunicipioEmp);
      putitem_e(tADF_ROTA, 'CD_REGIAO', item_f('CD_REGIAO', tADF_MUNREG));
      retrieve_e(tADF_ROTA);
      if (xStatus >= 0) then begin
        setocc(tADF_ROTA, 1);
        vCdTransport := item_f('CD_TRANSPATIVA', tADF_ROTA);
      end;
    end;
  end;
  if (vCdTransport = 0) then begin
    clear_e(tADF_ROTA);
    putitem_e(tADF_ROTA, 'CD_UFORIGEM', vDsUfOr);
    putitem_e(tADF_ROTA, 'CD_CIDADEORIGEM', vCdMunicipioEmp);
    putitem_e(tADF_ROTA, 'CD_UFDESTINO', vDsUf);
    retrieve_e(tADF_ROTA);
    if (xStatus >= 0) then begin
      setocc(tADF_ROTA, 1);
      vCdTransport := item_f('CD_TRANSPATIVA', tADF_ROTA);
    end;
  end;

  putitemXml(Result, 'CD_TRANSPORT', vCdTransport);
  putitemXml(Result, 'CD_TRANSREDESPAC', vCdTransRedespac);

  return(0); exit;
end;

//-------------------------------------------------------------------
function T_PESSVCO005.buscaDadosComprador(pParams : String) : String;
//-------------------------------------------------------------------
const
  cDS_METHOD = 'ADICONAL=Operação: T_PESSVCO005.buscaDadosComprador()';
var
  vCdComprador : Real;
begin
  vCdComprador := itemXmlF('CD_COMPRADOR', pParams);

  if (vCdComprador = 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Comprador não informado!', cDS_METHOD);
    return(-1); exit;
  end;

  clear_e(tPES_COMPRADOR);
  putitem_e(tPES_COMPRADOR, 'CD_COMPRADOR', vCdComprador);
  retrieve_e(tPES_COMPRADOR);
  if (xStatus < 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Comprador ' + FloatToStr(vCdComprador) + ' não cadastrado!', cDS_METHOD);
    return(-1); exit;
  end;

  Result := '';
  putlistitensocc_e(Result, tPES_COMPRADOR);

  return(0); exit;
end;

//-----------------------------------------------------------------------
function T_PESSVCO005.buscaEstatisticaCliente(pParams : String) : String;
//-----------------------------------------------------------------------
const
  cDS_METHOD = 'ADICONAL=Operação: T_PESSVCO005.buscaEstatisticaCliente()';
var
  vCdEmpresa, vCdCliente : Real;
begin
  vCdEmpresa := itemXmlF('CD_EMPRESA', pParams);
  vCdCliente := itemXmlF('CD_CLIENTE', pParams);

  if (vCdEmpresa = 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Empresa não informada!', cDS_METHOD);
    return(-1); exit;
  end;
  if (vCdCliente = 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Cliente não informado!', cDS_METHOD);
    return(-1); exit;
  end;

  clear_e(tPES_CLIENTEES);
  putitem_e(tPES_CLIENTEES, 'CD_EMPRESA', vCdEmpresa);
  putitem_e(tPES_CLIENTEES, 'CD_CLIENTE', vCdCliente);
  retrieve_e(tPES_CLIENTEES);
  if (xStatus < 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Estatística para cliente ' + FloatToStr(vCdEmpresa) + ' / ' + FloatToStr(vCdCliente) + ' não encontrado!', cDS_METHOD);
    return(-1); exit;
  end;

  Result := '';
  putlistitensocc_e(Result, tPES_CLIENTEES);

  return(0); exit;
end;

//----------------------------------------------------------------------
function T_PESSVCO005.buscaDadosPessoaFisica(pParams : String) : String;
//----------------------------------------------------------------------
const
  cDS_METHOD = 'ADICONAL=Operação: T_PESSVCO005.buscaDadosPessoaFisica()';
var
  vCdPessoa : Real;
begin
  vCdPessoa := itemXmlF('CD_PESSOA', pParams);

  if (vCdPessoa = 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Pessoa não informado!', cDS_METHOD);
    return(-1); exit;
  end;

  clear_e(tPES_PESSOA);
  putitem_e(tPES_PESSOA, 'CD_PESSOA', vCdPessoa);
  retrieve_e(tPES_PESSOA);
  if (xStatus < 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Pessoa ' + FloatToStr(vCdPessoa) + ' não cadastrada!', cDS_METHOD);
    return(-1); exit;
  end;

  Result := '';
  putitemXml(Result, 'IN_INATIVO', item_b('IN_INATIVO', tPES_PESFISICA));
  putitemXml(Result, 'TP_ESTCIVIL', item_f('TP_ESTCIVIL', tPES_PESFISICA));
  putitemXml(Result, 'TP_SEXO', item_f('TP_SEXO', tPES_PESFISICA));
  putitemXml(Result, 'CD_SERIECTPS', item_f('CD_SERIECTPS', tPES_PESFISICA));
  putitemXml(Result, 'DS_ORGEXPEDIDOR', item_a('DS_ORGEXPEDIDOR', tPES_PESFISICA));
  putitemXml(Result, 'NR_CTPS', item_f('NR_CTPS', tPES_PESFISICA));
  putitemXml(Result, 'NR_CPF', item_f('NR_CPF', tPES_PESFISICA));
  putitemXml(Result, 'NR_RG', item_f('NR_RG', tPES_PESFISICA));
  putitemXml(Result, 'VL_RendAMENSAL', item_f('VL_RENDAMENSAL', tPES_PESFISICA));
  putitemXml(Result, 'DS_CARGO', item_a('DS_CARGO', tPES_PESFISICA));
  putitemXml(Result, 'DT_ADMISSAO', item_a('DT_ADMISSAO', tPES_PESFISICA));
  putitemXml(Result, 'DT_NASCIMENTO', item_a('DT_NASCIMENTO', tPES_PESFISICA));
  putitemXml(Result, 'DS_LOCALTRAB', item_a('DS_LOCALTRAB', tPES_PESFISICA));
  putitemXml(Result, 'DS_LOCALNASC', item_a('DS_LOCALNASC', tPES_PESFISICA));
  putitemXml(Result, 'DS_NACIONALIDADE', item_a('DS_NACIONALIDADE', tPES_PESFISICA));
  putitemXml(Result, 'NM_MAE', item_a('NM_MAE', tPES_PESFISICA));
  putitemXml(Result, 'NM_PAI', item_a('NM_PAI', tPES_PESFISICA));
  putitemXml(Result, 'TP_ESCOLARIDADE', item_f('TP_ESCOLARIDADE', tPES_PFADIC));
  putitemXml(Result, 'QT_FILHOS', item_f('QT_FILHOS', tPES_PFADIC));
  putitemXml(Result, 'QT_DEPendENTES', item_f('QT_DEPENDENTES', tPES_PFADIC));
  putitemXml(Result, 'QT_RESANTMESES', item_f('QT_RESANTMESES', tPES_PFADIC));
  putitemXml(Result, 'QT_TRAANTMESES', item_f('QT_TRAANTMESES', tPES_PFADIC));
  putitemXml(Result, 'DS_TRAANTLOCAL', item_a('DS_TRAANTLOCAL', tPES_PFADIC));
  putitemXml(Result, 'DT_RESIDEDESDE', item_a('DT_RESIDEDESDE', tPES_PFADIC));
  putitemXml(Result, 'TP_CASA', item_f('TP_CASA', tPES_PFADIC));
  putitemXml(Result, 'TP_CARRO', item_f('TP_CARRO', tPES_PFADIC));
  putitemXml(Result, 'NR_ESCORE', item_f('NR_ESCORE', tPES_PFADIC));
  putitemXml(Result, 'NR_RISCO', item_f('NR_RISCO', tPES_PFADIC));
  putitemXml(Result, 'DT_ATUALIZSPC', item_a('DT_ATUALIZSPC', tPES_PFADIC));

  return(0); exit;
end;

end.
