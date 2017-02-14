unit uclsPersistent;

interface

uses
  Classes, SysUtils, StrUtils;

type
  TC_Persistent = class
  public
    class procedure gerar();
  end;

implementation

{ TC_Persistent }

uses
  mDatabaseFactory, mDatabaseIntf, mProperty, mFilter,
  mArquivo, mString, mPath;

const
  cCNT_CLASSE =
    'unit u{arq};' + sLineBreak +
    '' + sLineBreak +
    'interface' + sLineBreak +
    '' + sLineBreak +
    'uses' + sLineBreak +
    '  Classes, SysUtils,' + sLineBreak +
    '  mCollection, mCollectionItem;' + sLineBreak +
    '' + sLineBreak +
    'type' + sLineBreak +
    '  T{cls} = class;' + sLineBreak +
    '  T{cls}Class = class of T{cls};' + sLineBreak +
    '' + sLineBreak +
    '  T{cls}List = class;' + sLineBreak +
    '  T{cls}ListClass = class of T{cls}List;' + sLineBreak +
    '' + sLineBreak +
    '  T{cls} = class(TmCollectionItem)' + sLineBreak +
    '  private' + sLineBreak +
    '{fields}' +
    '  public' + sLineBreak +
    '    constructor Create(ACollection: TCollection); override;' + sLineBreak +
    '    destructor Destroy; override;' + sLineBreak +
    '  published' + sLineBreak +
    '{properts}' +
    '  end;' + sLineBreak +
    '' + sLineBreak +
    '  T{cls}List = class(TmCollection)' + sLineBreak +
    '  private' + sLineBreak +
    '    function GetItem(Index: Integer): T{cls};' + sLineBreak +
    '    procedure SetItem(Index: Integer; Value: T{cls});' + sLineBreak +
    '  public' + sLineBreak +
    '    constructor Create(AOwner: TPersistent);' + sLineBreak +
    '    function Add: T{cls};' + sLineBreak +
    '    property Items[Index: Integer]: T{cls} read GetItem write SetItem; default;' + sLineBreak +
    '  end;' + sLineBreak +
    '  ' + sLineBreak +
    'implementation' + sLineBreak + 
    '' + sLineBreak + 
    '{ T{cls} }' + sLineBreak + 
    '' + sLineBreak + 
    'constructor T{cls}.Create(ACollection: TCollection);' + sLineBreak +
    'begin' + sLineBreak +
    '  inherited;' + sLineBreak +
    '' + sLineBreak +
    'end;' + sLineBreak +
    '' + sLineBreak +
    'destructor T{cls}.Destroy;' + sLineBreak +
    'begin' + sLineBreak +
    '' + sLineBreak +
    '  inherited;' + sLineBreak +
    'end;' + sLineBreak +
    '' + sLineBreak +
    '{ T{cls}List }' + sLineBreak +
    '' + sLineBreak +
    'constructor T{cls}List.Create(AOwner: TPersistent);' + sLineBreak +
    'begin' + sLineBreak +
    '  inherited Create(T{cls});' + sLineBreak +
    'end;' + sLineBreak +
    '' + sLineBreak +
    'function T{cls}List.Add: T{cls};' + sLineBreak +
    'begin' + sLineBreak +
    '  Result := T{cls}(inherited Add);' + sLineBreak +
    '  Result.create;' + sLineBreak + 
    'end;' + sLineBreak +
    '' + sLineBreak +
    'function T{cls}List.GetItem(Index: Integer): T{cls};' + sLineBreak + 
    'begin' + sLineBreak + 
    '  Result := T{cls}(inherited GetItem(Index));' + sLineBreak + 
    'end;' + sLineBreak + 
    '' + sLineBreak + 
    'procedure T{cls}List.SetItem(Index: Integer; Value: T{cls});' + sLineBreak + 
    'begin' + sLineBreak + 
    '  inherited SetItem(Index, Value);' + sLineBreak + 
    'end;' + sLineBreak + 
    '' + sLineBreak + 
    'end.' ;

  cCNT_FIELD =
    '    f{atr}: {tip};' + sLineBreak ;

  cCNT_PROPERT =
    '    property {atr} : {tip} read f{atr} write f{atr};' + sLineBreak ;

var
  vDatabase : IDatabaseIntf;

  function NomeArquivo(AEntidade : String) : String;
  begin
    Result := TmString.PrimeiraMaiscula(AEntidade);
    Result := AnsiReplaceStr(Result, ' ', '');
  end;

  function NomeClasse(AEntidade : String) : String;
  begin
    Result := TmString.PrimeiraMaiscula(AEntidade);
    Result := AnsiReplaceStr(Result, ' ', '_');
  end;

  function NomeAtributo(AAtributo : String) : String;
  begin
    Result := TmString.PrimeiraMaiscula(AAtributo);
    Result := AnsiReplaceStr(Result, ' ', '_');
  end;

  function TipoAtributo(ATipo : TpProperty) : String;
  begin
    case ATipo of
      tppBoolean: Result := 'Boolean';
      tppDateTime: Result := 'TDateTime';
      tppEnum: Result := 'Enum';
      tppFloat: Result := 'Real';
      tppInteger: Result := 'Integer';
      tppObject: Result := 'Object';
      tppList: Result := 'List';
      tppString: Result := 'String';
      tppVariant: Result := '';
    else
      Result := 'String';
    end;
  end;

  procedure processarEntidade(AEntidade : String);
  var
    vArquivo, vConteudo,
    vFields, vField, vProperts, vPropert, vArq, vCls, vAtr, vTip : String;
    vProperty : TmProperty;
    vValues : TList;
    I : Integer;
  begin
    vArq := NomeArquivo(AEntidade);
    vCls := NomeClasse(AEntidade);

    vConteudo := cCNT_CLASSE;
    vConteudo := AnsiReplaceStr(vConteudo, '{arq}', vArq);
    vConteudo := AnsiReplaceStr(vConteudo, '{cls}', vCls);

    vValues := vDatabase.GetMetadata(AEntidade);

    vFields := '';
    vProperts := '';

    for I := 0 to vValues.Count - 1 do begin
      vProperty := TmProperty(vValues[I]);

      vAtr := NomeAtributo(vProperty.Nome);
      vTip := TipoAtributo(vProperty.Tipo);

      vField := cCNT_FIELD;
      vField := AnsiReplaceStr(vField, '{atr}', vAtr);
      vField := AnsiReplaceStr(vField, '{tip}', vTip);
      vFields := vFields + vField;

      vPropert := cCNT_PROPERT;
      vPropert := AnsiReplaceStr(vPropert, '{atr}', vAtr);
      vPropert := AnsiReplaceStr(vPropert, '{tip}', vTip);
      vProperts := vProperts + vPropert;
    end;

    vConteudo := AnsiReplaceStr(vConteudo, '{fields}', vFields);
    vConteudo := AnsiReplaceStr(vConteudo, '{properts}', vProperts);

    vArquivo := TmPath.Temp() + 'u' + vArq + '.pas';
    TmArquivo.Gravar(vArquivo, vConteudo);
  end;

class procedure TC_Persistent.gerar;
var
  vTables : TStringList;
  vViews : TStringList;
  I : Integer;
begin
  vDatabase := TmDatabaseFactory.getDatabase();

  vTables := vDatabase.GetTables('');
  for I := 0 to vTables.Count - 1 do
    processarEntidade(vTables[I]);

  vViews := vDatabase.GetViews('');
  for I := 0 to vViews.Count - 1 do
    processarEntidade(vViews[I]);
end;

end.
