unit uclsPersistentDelphi;

interface

uses
  Classes, SysUtils, StrUtils, DB,
  mContexto, mValue,
  uclsPersistentAbstract;

type
  TC_PersistentDelphi = class(TC_PersistentAbstract)
  protected
    procedure ProcessarEntidade(AContexto : TmContexto; AEntidade : String); override;
  public
    constructor Create; override;
  end;

implementation

{ TC_PersistentDelphi }

uses
  mDatabase, mArquivo, mString, mPath;

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

    '  T{cls}s = class(TmCollection)' + sLineBreak +
    '  private' + sLineBreak +
    '    function GetItem(Index: Integer): T{cls};' + sLineBreak +
    '    procedure SetItem(Index: Integer; Value: T{cls});' + sLineBreak +
    '  public' + sLineBreak +
    '    constructor Create(AItemClass: TCollectionItemClass); override;' + sLineBreak +
    '    function Add: T{cls};' + sLineBreak +
    '    property Items[Index: Integer]: T{cls} read GetItem write SetItem; default;' + sLineBreak +
    '  end;' + sLineBreak +
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

    '{ T{cls}s }' + sLineBreak +
    '' + sLineBreak +

    'constructor T{cls}s.Create(AItemClass: TCollectionItemClass);' + sLineBreak +
    'begin' + sLineBreak +
    '  inherited Create(T{cls});' + sLineBreak +
    'end;' + sLineBreak +
    '' + sLineBreak +

    'function T{cls}s.Add: T{cls};' + sLineBreak +
    'begin' + sLineBreak +
    '  Result := T{cls}(inherited Add);' + sLineBreak +
    'end;' + sLineBreak +
    '' + sLineBreak +

    'function T{cls}s.GetItem(Index: Integer): T{cls};' + sLineBreak +
    'begin' + sLineBreak +
    '  Result := T{cls}(inherited GetItem(Index));' + sLineBreak +
    'end;' + sLineBreak +
    '' + sLineBreak +

    'procedure T{cls}s.SetItem(Index: Integer; Value: T{cls});' + sLineBreak +
    'begin' + sLineBreak +
    '  inherited SetItem(Index, Value);' + sLineBreak +
    'end;' + sLineBreak +
    '' + sLineBreak +

    'end.' ;

  cCNT_FIELD =
    '    f{atr}: {tip};' + sLineBreak ;

  cCNT_PROPERT =
    '    property {atr} : {tip} read f{atr} write f{atr};' + sLineBreak ;

constructor TC_PersistentDelphi.Create;
begin
  inherited;
  AddTipoBaseLingArray(tbBoolean, 'Boolean');
  AddTipoBaseLingArray(tbDateTime, 'TDateTime');
  AddTipoBaseLingArray(tbFloat, 'Real');
  AddTipoBaseLingArray(tbInteger, 'Integer');
  AddTipoBaseLingArray(tbString, 'String');
end;

procedure TC_PersistentDelphi.ProcessarEntidade(AContexto : TmContexto; AEntidade : String);
var
  vArquivo, vConteudo, vPath,
  vFields, vField, vProperts, vPropert,
  vArq, vCls, vAtr, vTip, vFld : String;
  vMetadata : TDataSet;
  vCampo : TField;
  vTipoField : TTipoField;
  I : Integer;
begin
  vArq := NomeArquivo(AEntidade);
  vCls := NomeClasse(AEntidade);

  vConteudo := cCNT_CLASSE;
  vConteudo := AnsiReplaceStr(vConteudo, '{arq}', vArq);
  vConteudo := AnsiReplaceStr(vConteudo, '{cls}', vCls);

  vMetadata := AContexto.Database.Conexao.GetMetadata(AEntidade);

  vTipoField := tfKey;
  vFields := '';
  vProperts := '';

  for I := 0 to vMetadata.FieldCount - 1 do begin
    vCampo := vMetadata.Fields[I];

    vAtr := NomeAtributo(vCampo.FieldName);
    vTip := TipoAtributo(vCampo.DataType);

    if vAtr = 'U_Version' then
      vTipoField := tfNul;

    vFld :=
      IfThen(vTipoField in [tfKey], 'tfKey',
      IfThen(vCampo.Required, 'tfReq', 'tfNul'));

    vField := cCNT_FIELD;
    vField := AnsiReplaceStr(vField, '{atr}', vAtr);
    vField := AnsiReplaceStr(vField, '{tip}', vTip);
    vFields := vFields + vField;

    vPropert := cCNT_PROPERT;
    vPropert := AnsiReplaceStr(vPropert, '{atr}', vAtr);
    vPropert := AnsiReplaceStr(vPropert, '{tip}', vTip);
    vPropert := AnsiReplaceStr(vPropert, '{cpo}', vCampo.FieldName);
    vPropert := AnsiReplaceStr(vPropert, '{fld}', vFld);
    vProperts := vProperts + vPropert;
  end;

  vConteudo := AnsiReplaceStr(vConteudo, '{tabela}', AEntidade);
  vConteudo := AnsiReplaceStr(vConteudo, '{fields}', vFields);
  vConteudo := AnsiReplaceStr(vConteudo, '{properts}', vProperts);

  vPath := 'temp\' + AContexto.Database.Conexao.Parametro.Cd_Ambiente + '\Delphi\';
  vArquivo := TmPath.Current(vPath) + 'u' + vArq + '.pas';
  TmArquivo.Gravar(vArquivo, vConteudo);
end;

end.
