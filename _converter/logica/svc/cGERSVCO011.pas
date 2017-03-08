unit cGERSVCO011;

interface

        

uses
  Classes, SysUtils, Math, DB,
  cDataSetUnf;

type
  T_GERSVCO011 = class(TComponent)
  private
    tGER_NRDTSEQ : TcDatasetUnf;
    function getParam(pParams : String = '') : String;
    function setEntidade(pParams : String = '') : String;
  protected
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;    
  published
    function getNumSeq(pParams : String = '') : String;
  end;

implementation

uses
  cADMSVCO001,
  cActivate, cStatus, cFuncao, cXml, dModulo;

var


//---------------------------------------------------------------
constructor T_GERSVCO011.Create(AOwner: TComponent);
//---------------------------------------------------------------
begin
  inherited Create(AOwner);
  setEntidade('');
end;

//--------------------------------
destructor T_GERSVCO011.Destroy;
//--------------------------------
begin
  inherited Destroy;
end;

//---------------------------------------------------------------
function T_GERSVCO011.getParam(pParams : String = '') : String;
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
function T_GERSVCO011.setEntidade(pParams : String = '') : String;
//---------------------------------------------------------------
begin
  tGER_NRDTSEQ := TcDatasetUnf.getEntidade('GER_NRDTSEQ');
end;

//---------------------------------------------------------
function T_GERSVCO011.getNumSeq(pParams : String) : String;
//---------------------------------------------------------
const
  cDS_METHOD = 'ADICONAL=Operação: T_GERSVCO011.getNumSeq()';
begin
    clear_e(tGER_NRDTSEQ);
    putitem_e(tGER_NRDTSEQ, 'CD_EMPRESA', itemXmlF('CD_GRUPOEMPRESA', piGlobal));
    putitem_e(tGER_NRDTSEQ, 'NM_ENTIDADE', piNmEntidade);
    putitem_e(tGER_NRDTSEQ, 'NM_ATRIBUTO', piNmAtributo);
    putitem_e(tGER_NRDTSEQ, 'DT_SEQUENCIA', piData);
    retrieve_e(tGER_NRDTSEQ);
    if (xStatus = 0) then begin
        if (piData = '') then begin
            piData := Date;
        end;
        if (item_a('DT_SEQUENCIA', tGER_NRDTSEQ) = piData) then begin
            if (item_f('NR_ATUAL', tGER_NRDTSEQ) = item_f('NR_FINAL', tGER_NRDTSEQ)) then begin
                if (item_b('IN_REINICIAR', tGER_NRDTSEQ)) then begin
                    putitem_e(tGER_NRDTSEQ, 'NR_ATUAL', 0);
                end;
            end;
            putitem_e(tGER_NRDTSEQ, 'NR_ATUAL', item_f('NR_ATUAL', tGER_NRDTSEQ) + 1);
        end else begin
          putitem_e(tGER_NRDTSEQ, 'DT_SEQUENCIA', piData);
          putitem_e(tGER_NRDTSEQ, 'NR_ATUAL', 1);
        end;
    end else if (xStatus = -2) then begin
          xStatus := 0;
          xCdErro := '';
          xCtxErro := '';

          creocc(tGER_NRDTSEQ, -1);
          putitem_e(tGER_NRDTSEQ, 'CD_EMPRESA', itemXmlF('CD_GRUPOEMPRESA', piGlobal));
          putitem_e(tGER_NRDTSEQ, 'NM_ENTIDADE', piNmEntidade);
          putitem_e(tGER_NRDTSEQ, 'NM_ATRIBUTO', piNmAtributo);
          putitem_e(tGER_NRDTSEQ, 'DT_SEQUENCIA', piData);
          putitem_e(tGER_NRDTSEQ, 'NR_INCREMENTO', 1);
          putitem_e(tGER_NRDTSEQ, 'NR_ATUAL', 1);
          putitem_e(tGER_NRDTSEQ, 'NR_INICIAL', 1);
          putitem_e(tGER_NRDTSEQ, 'NR_FINAL', piNrFinal);
          putitem_e(tGER_NRDTSEQ, 'IN_REINICIAR', True);
          putitem_e(tGER_NRDTSEQ, 'CD_GRUPOEMPRESA', itemXmlF('CD_GRUPOEMPRESA', piGlobal));
          putitem_e(tGER_NRDTSEQ, 'CD_OPERADOR', itemXmlF('CD_USUARIO', piGlobal));
          putitem_e(tGER_NRDTSEQ, 'DT_CADASTRO', Now);
    end else begin
      return(-1); exit;
    end;
    if (xStatus >=0) then begin
        voParams := tGER_NRDTSEQ.Salvar();
        if (xStatus < 0) then begin
          Result := voParams;
          return(-1); exit;
        end;
    end else begin
        return(-1); exit;
    end;
    return(0); exit;

end;

end.
