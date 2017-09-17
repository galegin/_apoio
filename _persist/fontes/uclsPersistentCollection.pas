unit uclsPersistentCollection;

interface

uses
  Classes, SysUtils, StrUtils, DB,
  mContexto,
  uclsPersistentAbstract;

type
  TC_PersistentCollection = class(TC_PersistentAbstract)
  public
    procedure processarEntidade(AContexto : TmContexto; AEntidade : String); override;
  end;

implementation

{ TC_PersistentCollection }

uses
  mDatabase, mArquivo, mString, mDataSet, mPath;

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
    '    constructor Create(AOwner: TPersistentCollection);' + sLineBreak +
    '    function Add: T{cls};' + sLineBreak +
    '    property Items[Index: Integer]: T{cls} read GetItem write SetItem; default;' + sLineBreak +
    '  end;' + sLineBreak +
    '' + sLineBreak +

    '{objects}' +
    '' + sLineBreak +

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

    'constructor T{cls}List.Create(AOwner: TPersistentCollection);' + sLineBreak +
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
    '    property {atr} : {tip} read f{atr} write Set{atr};' + sLineBreak ;

  cCNT_PROC_INT =
    '    procedure Set{atr}(const value : {tip});' + sLineBreak ;

  cCNT_PROC_IMP =
    '    procedure T{cls}.Set{atr}(const value : {tip});' + sLineBreak +
    '    begin' + sLineBreak +
    '      f{atr} := value;' + sLineBreak +
    '    end;' + sLineBreak +
    '' + sLineBreak ;

procedure TC_PersistentCollection.processarEntidade(AContexto : TmContexto; AEntidade : String);
var
  vArquivo, vConteudo,
  vFields, vField, vProperts, vPropert,
  vArq, vCls, vAtr, vTip : String;
  vObjects : TStringList;
  vMetadata,
  vListField,
  vListPrimary,
  vListConstraint,
  vListConstraintKey : TDataSet;
  vFieldName,
  vFieldPrimary,
  vFieldConstraintTable,
  vFieldConstraintKey : String;
  vStringPrimary, vStringConstraint : TmStringArray;
  vCampo : TField;
  I : Integer;
begin
  vArq := NomeArquivo(AEntidade);
  vCls := NomeClasse(AEntidade);

  vConteudo := cCNT_CLASSE;
  vConteudo := AnsiReplaceStr(vConteudo, '{arq}', vArq);
  vConteudo := AnsiReplaceStr(vConteudo, '{cls}', vCls);

  vMetadata := AContexto.Database.Conexao.GetMetadata(AEntidade);

  vFields := '';
  vProperts := '';
  vObjects := TStringList.Create;

  for I := 0 to vMetadata.FieldCount - 1 do begin
    vCampo := vMetadata.Fields[I];

    vAtr := NomeAtributo(vCampo.FieldName);
    vTip := TipoAtributo(vCampo.DataType);

    vField := cCNT_FIELD;
    vField := AnsiReplaceStr(vField, '{atr}', vAtr);
    vField := AnsiReplaceStr(vField, '{tip}', vTip);
    vFields := vFields + vField;

    vPropert := cCNT_PROPERT;
    vPropert := AnsiReplaceStr(vPropert, '{atr}', vAtr);
    vPropert := AnsiReplaceStr(vPropert, '{tip}', vTip);
    vProperts := vProperts + vPropert;
  end;

  vListField := GetListaField(AEntidade);
  vFieldName := TmDataSet(vListField).PegarS('p_field_name');
  vListPrimary := GetListaPrimary(AEntidade);
  vFieldPrimary := TmDataSet(vListPrimary).PegarS('p_field_name');

  //-- depende

  vListConstraint := GetListaConstraint(AEntidade);
  vListConstraint.First;
  while not vListConstraint.EOF do begin
    vFieldConstraintTable := Trim(TmDataSet(vListConstraint).PegarS('p_references_table'));
    vListConstraintKey := GetListaPrimary(vFieldConstraintTable);
    vFieldConstraintKey := TmDataSet(vListConstraintKey).PegarS('p_references_field');

    // depende
    vObjects.Add(vFieldConstraintTable + '=Depende');

    vListConstraint.Next;
  end;

  //-- complemento / lista

  SetLength(vStringPrimary, 0);
  SetLength(vStringConstraint, 0);

  vListConstraint := GetListaConstraintRef(AEntidade);
  vListConstraint.First;
  while not vListConstraint.EOF do begin
    vFieldConstraintTable := Trim(TmDataSet(vListConstraint).PegarS('p_relation_name'));
    vListConstraintKey := GetListaPrimary(vFieldConstraintTable);
    vFieldConstraintKey := TmDataSet(vListConstraintKey).PegarS('p_field_name');

    vStringPrimary := TmString.Split(vFieldPrimary, ',');
    vStringConstraint := TmString.Split(vFieldConstraintKey, ',');

    // complemento / lista
    if Length(vStringPrimary) = Length(vStringConstraint) then
      vObjects.Add(vFieldConstraintTable + '=Complemento')
    else
      vObjects.Add(vFieldConstraintTable + '=Lista');

    vListConstraint.Next;
  end;

  //--

  vConteudo := AnsiReplaceStr(vConteudo, '{fields}', vFields);
  vConteudo := AnsiReplaceStr(vConteudo, '{properts}', vProperts);
  vConteudo := AnsiReplaceStr(vConteudo, '{objects}', vObjects.Text);

  vArquivo := TmPath.Temp() + 'u' + vArq + '.pas';
  TmArquivo.Gravar(vArquivo, vConteudo);
end;

end.
