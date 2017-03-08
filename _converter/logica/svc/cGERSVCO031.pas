unit cGERSVCO031;

interface

(* COMPONENTES *)

type
  T_GERSVCO031 = class
  published
    function getNumSeq(pParams : String = '') : String;
  end;

implementation

uses
  cStatus, cFuncao, cXml, dModulo, cConexao;

//---------------------------------------------------------
function T_GERSVCO031.getNumSeq(pParams : String) : String;
//---------------------------------------------------------
const
  cDS_METHOD = 'ADICONAL=Operação: T_GERSVCO031.getNumSeq()';
var
  vNmEntidade, vDsComando : String;
  vNrSequencia : Real;
begin
  vNmEntidade := itemXml('NM_ENTIDADE', pParams);

  if (vNmEntidade = '') then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Entidade não informada!',  cDS_METHOD);
    return(-1); exit;
  end;

  (*
  CREATE SEQUENCE GEN_TRA_TRANSACAO_ID

  CREATE TRIGGER TRA_TRANSACAO_BI FOR TRA_TRANSACAO
  ACTIVE BEFORE INSERT POSITION 0
  AS
  BEGIN
    IF (NEW.CD_EMPRESA IS NULL) THEN
      NEW.CD_EMPRESA = GEN_ID(GEN_TRA_TRANSACAO_ID,1);
  END

  CREATE PROCEDURE SP_GEN_TRA_TRANSACAO_ID
  RETURNS (ID INTEGER)
  AS
  BEGIN
    ID = GEN_ID(GEN_TRA_TRANSACAO_ID, 1);
    SUSPEND;
  END
  *)

  with gModulo.GetConexao() do begin
    if (_TpDatabase in [tdbFirebird, tdbInterbase]) then begin
      ExecSql('CREATE SEQUENCE SQ_' + vNmEntidade);
      vDsComando := 'select GEN_ID(SQ_' + vNmEntidade + ', 1) as PROXIMO from RDB$DATABASE';
    end else if (_TpDatabase in [tdbMySql, tdbPostgre]) then begin

    end else if (_TpDatabase in [tdbOracle]) then begin
      //ExecSql('CREATE SEQUENCE SQ_' + vNmEntidade);
      vDsComando := 'select SQ_' + vNmEntidade + '.NEXTVAL as PROXIMO from DUAL';
    end else begin
      Exit;
    end;
  end;

  vNrSequencia := SetarValorF(gModulo.ConsultaSql(vDsComando,'PROXIMO'), '0');
  if (xStatus < 0) then begin
    Result := SetStatus(STS_ERROR, 'GEN0001', 'Não foi possível gerar sequência para a entidade ' + vNmEntidade + '!',  cDS_METHOD);
    return(-1); exit;
  end;

  Result := '';
  putitemXml(Result, 'NR_SEQUENCIA', vNrSequencia);
  return(0);
end;

end.
