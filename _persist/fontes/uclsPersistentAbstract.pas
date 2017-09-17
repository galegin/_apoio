unit uclsPersistentAbstract;

interface

uses
  Classes, SysUtils, StrUtils, DB,
  mContexto;

type
  TC_PersistentAbstract = class
  private
  protected
    function NomeArquivo(AEntidade: String): String;
    function NomeAtributo(AAtributo: String): String;
    function NomeClasse(AEntidade: String): String;
    function TipoAtributo(AFieldType: TFieldType): String;
    function GetListaField(AEntidade: String): TDataSet;
    function GetListaPrimary(AEntidade: String): TDataSet;
    function GetListaConstraint(AEntidade: String): TDataSet;
    function GetListaConstraintRef(AEntidade: String): TDataSet;
    procedure processarEntidade(AContexto : TmContexto; AEntidade : String); virtual; abstract;
  public
    procedure gerar(AFiltro : String);
  end;

implementation

uses
  mArquivo, mString, mDatabase, mPath;

  function TC_PersistentAbstract.NomeArquivo(AEntidade : String) : String;
  begin
    Result := TmString.PrimeiraMaiscula(AEntidade);
    Result := AnsiReplaceStr(Result, ' ', '');
  end;

  function TC_PersistentAbstract.NomeClasse(AEntidade : String) : String;
  begin
    Result := TmString.PrimeiraMaiscula(AEntidade);
    Result := AnsiReplaceStr(Result, ' ', '_');
  end;

  function TC_PersistentAbstract.NomeAtributo(AAtributo : String) : String;
  begin
    Result := TmString.PrimeiraMaiscula(AAtributo);
    Result := AnsiReplaceStr(Result, ' ', '_');
  end;

  function TC_PersistentAbstract.TipoAtributo(AFieldType : TFieldType) : String;
  begin
    case AFieldType of
      ftBoolean: Result := 'Boolean';
      ftDateTime: Result := 'TDateTime';
      ftFloat: Result := 'Real';
      ftInteger: Result := 'Integer';
      ftString: Result := 'String';
    else
      Result := 'String';
    end;
  end;

{ TC_PersistentAbstract }

procedure TC_PersistentAbstract.gerar;
var
  vTables, vViews : TStringList;
  vContexto : TmContexto;
  I : Integer;
begin
  vContexto := mContexto.Instance;

  AFiltro := TmString.AllTrim(AFiltro, sLineBreak);

  vTables := vContexto.Database.Conexao.GetTables('');
  for I := 0 to vTables.Count - 1 do
    if (AFiltro = '') or (Pos(vTables[I], AFiltro) > 0) then
      processarEntidade(vContexto, vTables[I]);

  vViews := vContexto.Database.Conexao.GetViews('');
  for I := 0 to vViews.Count - 1 do
    if (AFiltro = '') or (Pos(vTables[I], AFiltro) > 0) then
      processarEntidade(vContexto, vViews[I]);
end;

function TC_PersistentAbstract.GetListaField(AEntidade: String): TDataSet;
begin
  //-- sp_field
  //p_relation_name    varchar(100),
  //p_field_name       varchar(4000)
  Result := mContexto.Instance.Database.Conexao.GetConsulta(
    'select * from sq_field where p_relation_name = ''' + AEntidade + '''')
end;

function TC_PersistentAbstract.GetListaPrimary(
  AEntidade: String): TDataSet;
begin
  //-- sp_primary
  //p_constraint_name  varchar(100),
  //p_relation_name    varchar(100),
  //p_field_name       varchar(1000)
  Result := mContexto.Instance.Database.Conexao.GetConsulta(
    'select * from sq_primary where p_relation_name = ''' + AEntidade + '''')
end;

function TC_PersistentAbstract.GetListaConstraint(
  AEntidade: String): TDataSet;
begin
  //-- sp_constraint
  //p_constraint_name  varchar(100),
  //p_constraint_corr  varchar(100),
  //p_relation_name    varchar(100),
  //p_field_name       varchar(1000),
  //p_references_table varchar(100),
  //p_references_field varchar(1000)
  Result := mContexto.Instance.Database.Conexao.GetConsulta(
    'select * from sq_constraint where p_relation_name = ''' + AEntidade + '''')
end;

function TC_PersistentAbstract.GetListaConstraintRef(
  AEntidade: String): TDataSet;
begin
  //-- sp_constraint
  //p_constraint_name  varchar(100),
  //p_constraint_corr  varchar(100),
  //p_relation_name    varchar(100),
  //p_field_name       varchar(1000),
  //p_references_table varchar(100),
  //p_references_field varchar(1000)
  Result := mContexto.Instance.Database.Conexao.GetConsulta(
    'select * from sq_constraint where p_references_table = ''' + AEntidade + '''')
end;

end.
