unit uclsPersistentAbstract;

interface

uses
  Classes, SysUtils, StrUtils, DB,
  mContexto;

type
  TTipoBase = (tbBoolean, tbDateTime, tbFloat, tbInteger, tbString);

  RTipoBaseLing = record
    TipoBase : TTipoBase;
    TipoLing : String;
  end;

  RTipoBaseLingArray = Array Of RTipoBaseLing;

  TC_PersistentAbstract = class
  private
  protected
    fTipoBaseLingArray : RTipoBaseLingArray;
    procedure ClrTipoBaseLingArray();
    procedure AddTipoBaseLingArray(ATipoBase : TTipoBase; ATipoLing : String);
    function NomeArquivo(AEntidade: String): String;
    function NomeAtributo(AAtributo: String): String;
    function NomeClasse(AEntidade: String): String;
    function TipoBase(AFieldType : TFieldType) : TTipoBase;
    function TipoAtributo(AFieldType: TFieldType): String;
    procedure ProcessarEntidade(AContexto : TmContexto; AEntidade : String); virtual; abstract;
  public
    constructor Create; virtual;
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

  function TC_PersistentAbstract.TipoBase(AFieldType : TFieldType) : TTipoBase;
  begin
    case AFieldType of
      ftBoolean:
        Result := tbBoolean;
      ftDateTime, ftTimeStamp, ftTime, ftDate:
        Result := tbDateTime;
      ftFloat, ftCurrency, ftBCD, ftFMTBcd:
        Result := tbFloat;
      ftInteger, ftSmallint, ftWord:
        Result := tbInteger;
      ftString:
        Result := tbString;
    else
      Result := tbString;
    end;
  end;

  function TC_PersistentAbstract.TipoAtributo(AFieldType : TFieldType) : String;
  var
    vTipoBase : TTipoBase;
    I : Integer;
  begin
    Result := '';
    vTipoBase := TipoBase(AFieldType);
    for I := 0 to High(fTipoBaseLingArray) do
      if fTipoBaseLingArray[I].TipoBase = vTipoBase then begin
        Result := fTipoBaseLingArray[I].TipoLing;
        Exit;
      end;
  end;

{ TC_PersistentAbstract }

constructor TC_PersistentAbstract.Create;
begin
  ClrTipoBaseLingArray();
end;

procedure TC_PersistentAbstract.ClrTipoBaseLingArray();
begin
  SetLength(fTipoBaseLingArray, 0);
end;

procedure TC_PersistentAbstract.AddTipoBaseLingArray(ATipoBase : TTipoBase; ATipoLing : String);
begin
  SetLength(fTipoBaseLingArray, Length(fTipoBaseLingArray) + 1);
  fTipoBaseLingArray[High(fTipoBaseLingArray)].TipoBase := ATipoBase;
  fTipoBaseLingArray[High(fTipoBaseLingArray)].TipoLing := ATipoLing;
end;

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
        ProcessarEntidade(vContexto, AList[I]);
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
