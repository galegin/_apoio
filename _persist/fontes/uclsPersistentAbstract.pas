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
    procedure ProcessarEntidade(AContexto : TmContexto; AEntidade : String); virtual; abstract;
  public
    procedure Gerar(AFiltro : String);
  end;

implementation

uses
  mProgressBar, mDatabase, mArquivo, mString, mPath;

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
      ftDateTime, ftTimeStamp, ftTime, ftDate: Result := 'TDateTime';
      ftFloat, ftCurrency, ftBCD, ftFMTBcd: Result := 'Real';
      ftInteger, ftSmallint, ftWord: Result := 'Integer';
      ftString: Result := 'String';
    else
      Result := 'String';
    end;
  end;

{ TC_PersistentAbstract }

procedure TC_PersistentAbstract.Gerar;
var
  vTables, vViews : TStringList;
  vContexto : TmContexto;

  procedure prcGerar(AList : TStringList);
  var
    I : Integer;
  begin
    mProgressBar.Instance.MessageInicio('Processando...', AList.Count);

    for I := 0 to AList.Count - 1 do begin
      mProgressBar.Instance.MessagePosiciona;
      if (AFiltro = '') or (Pos(AList[I], AFiltro) > 0) then
        processarEntidade(vContexto, AList[I]);
    end;

    mProgressBar.Instance.MessageTermino;
  end;

begin
  vContexto := mContexto.Instance;

  AFiltro := TmString.AllTrim(AFiltro, sLineBreak);

  vTables := vContexto.Database.Conexao.GetTables('');
  prcGerar(vTables);

  vViews := vContexto.Database.Conexao.GetViews('');
  prcGerar(vViews);
end;

end.
