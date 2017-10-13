unit uclsPersistentContexto;

interface

uses
  Classes, SysUtils, StrUtils, DB,
  mContexto, 
  uclsPersistentAbstract;

type
  TC_PersistentContexto = class(TC_PersistentAbstract)
  public
    procedure processarEntidade(AContexto : TmContexto; AEntidade : String); override;
  end;

implementation

{ TC_PersistentContexto }

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
    '  mMapping, mCollection, mCollectionItem;' + sLineBreak +
    '' + sLineBreak +

    'type' + sLineBreak +
    '  T{cls} = class(TmCollectionItem)' + sLineBreak +
    '  private' + sLineBreak +
    '{fields}' +
    '  public' + sLineBreak +
    '    constructor Create(ACollection: TCollection); override;' + sLineBreak +
    '    destructor Destroy; override;' + sLineBreak +
    '    function GetMapping() : PmMapping; override;' + sLineBreak +
    '  published' + sLineBreak +
    '{properts}' +
    '  end;' + sLineBreak +
    '' + sLineBreak +

    '  T{cls}List = class(TmCollection)' + sLineBreak +
    '  private' + sLineBreak +
    '    function GetItem(Index: Integer): T{cls};' + sLineBreak +
    '    procedure SetItem(Index: Integer; Value: T{cls});' + sLineBreak +
    '  public' + sLineBreak +
    '    constructor Create(AOwner: TCollection);' + sLineBreak +
    '    function Add: T{cls};' + sLineBreak +
    '    property Items[Index: Integer]: T{cls} read GetItem write SetItem; default;' + sLineBreak +
    '  end;' + sLineBreak +
    '' + sLineBreak +

    'implementation' + sLineBreak +
    '' + sLineBreak +

    '{ T{cls} }' + sLineBreak +
    '' + sLineBreak +

    'constructor T{cls}.Create(AOwner: TCollection);' + sLineBreak +
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

    'function T{cls}.GetMapping: PmMapping;' + sLineBreak +
    'begin' + sLineBreak +
    '  Result := New(PmMapping);' + sLineBreak +
    '' + sLineBreak +

    '  Result.Tabela := New(PmTabela);' + sLineBreak +
    '  with Result.Tabela^ do begin' + sLineBreak +
    '    Nome := ''{tabela}'';' + sLineBreak +
    '  end;' + sLineBreak +
    '' + sLineBreak +

    '  Result.Campos := TmCampos.Create;' + sLineBreak +
    '  with Result.Campos do begin' + sLineBreak +
    '{campos}' +
    '  end;' + sLineBreak +
    'end;' + sLineBreak +
    '' + sLineBreak +

    '{ T{cls}List }' + sLineBreak +
    '' + sLineBreak +

    'constructor T{cls}List.Create(AOwner: TCollection);' + sLineBreak +
    'begin' + sLineBreak +
    '  inherited Create(T{cls});' + sLineBreak +
    'end;' + sLineBreak +
    '' + sLineBreak +

    'function T{cls}List.Add: T{cls};' + sLineBreak +
    'begin' + sLineBreak +
    '  Result := T{cls}(inherited Add);' + sLineBreak +
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

  cCNT_CAMPO =
    '    Add(''{atr}'', ''{cpo}'', {fld});' + sLineBreak ;

  cCNT_PROPERT =
    '    property {atr} : {tip} read f{atr} write f{atr};' + sLineBreak ;

procedure TC_PersistentContexto.processarEntidade(AContexto : TmContexto; AEntidade : String);
var
  vArquivo, vConteudo, vPath,
  vArq, vCls, vAtr, vTip, vFld,
  vCampos, vCampo, vFields, vField,
  vProperts, vPropert : String;
  vMetadata : TDataSet;
  vCampoF : TField;
  vKey : Boolean;
  I : Integer;
begin
  vArq := NomeArquivo(AEntidade);
  vCls := NomeClasse(AEntidade);

  vMetadata := AContexto.Database.Conexao.GetMetadata(AEntidade);

  vConteudo := cCNT_CLASSE;
  vConteudo := AnsiReplaceStr(vConteudo, '{arq}', vArq);
  vConteudo := AnsiReplaceStr(vConteudo, '{cls}', vCls);

  vKey := True;
  vCampos := '';
  vFields := '';
  vProperts := '';

  for I := 0 to vMetadata.FieldCount - 1 do begin
    vCampoF := vMetadata.Fields[I];

    vAtr := NomeAtributo(vCampoF.FieldName);
    vTip := TipoAtributo(vCampoF.DataType);

    if vAtr = 'U_Version' then
      vKey := False;

    if vKey then
      vFld := 'tfKey'
    else if vCampoF.Required then
      vFld := 'tfReq'
    else
      vFld := 'tfNul';

    vCampo := cCNT_CAMPO;
    vCampo := AnsiReplaceStr(vCampo, '{atr}', vAtr);
    vCampo := AnsiReplaceStr(vCampo, '{cpo}', vCampoF.FieldName);
    vCampo := AnsiReplaceStr(vCampo, '{fld}', vFld);
    vCampos := vCampos + vCampo;

    vField := cCNT_FIELD;
    vField := AnsiReplaceStr(vField, '{atr}', vAtr);
    vField := AnsiReplaceStr(vField, '{tip}', vTip);
    vFields := vFields + vField;

    vPropert := cCNT_PROPERT;
    vPropert := AnsiReplaceStr(vPropert, '{atr}', vAtr);
    vPropert := AnsiReplaceStr(vPropert, '{tip}', vTip);
    vProperts := vProperts + vPropert;
  end;

  vConteudo := AnsiReplaceStr(vConteudo, '{tabela}', AEntidade);
  vConteudo := AnsiReplaceStr(vConteudo, '{campos}', vCampos);
  vConteudo := AnsiReplaceStr(vConteudo, '{fields}', vFields);
  vConteudo := AnsiReplaceStr(vConteudo, '{properts}', vProperts);

  vPath := 'temp\' + AContexto.Database.Conexao.Parametro.Cd_Ambiente + '\contexto\';
  vArquivo := TmPath.Current(vPath) + 'u' + vArq + '.pas';
  TmArquivo.Gravar(vArquivo, vConteudo);
end;

end.
