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
  mArquivo, mString, mDatabase, mPath;

const
  cCNT_CLASSE =
    'unit u{arq};' + sLineBreak +
    '' + sLineBreak +

    'interface' + sLineBreak +
    '' + sLineBreak +

    'uses' + sLineBreak +
    '  Classes, SysUtils,' + sLineBreak +
    '  mMapping;' + sLineBreak +
    '' + sLineBreak +

    'type' + sLineBreak +
    '  T{cls} = class(TmMapping)' + sLineBreak +
    '  private' + sLineBreak +
    '{fields}' +
    '  public' + sLineBreak +
    '    constructor Create(AOwner: TComponent); override;' + sLineBreak +
    '    destructor Destroy; override;' + sLineBreak +
    '    function GetMapping() : PmMapping; override;' + sLineBreak +
    '  published' + sLineBreak +
    '{properts}' +
    '  end;' + sLineBreak +
    '' + sLineBreak +

    '  T{cls}s = class(TList)' + sLineBreak +
    '  public' + sLineBreak +
    '    function Add: T{cls}; overload;' + sLineBreak +
    '  end;' + sLineBreak +
    '' + sLineBreak +

    'implementation' + sLineBreak +
    '' + sLineBreak +

    '{ T{cls} }' + sLineBreak +
    '' + sLineBreak +

    'constructor T{cls}.Create(AOwner: TComponent);' + sLineBreak +
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

    '//--' + sLineBreak +
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
    '' + sLineBreak +

    '  Result.Relacoes := TmRelacoes.Create;' + sLineBreak +
    '  with Result.Relacoes do begin' + sLineBreak +
    '  end;' + sLineBreak +
    'end;' + sLineBreak +
    '' + sLineBreak +

    '//--' + sLineBreak +
    '' + sLineBreak +

    '{ T{cls}s }' + sLineBreak +
    '' + sLineBreak +

    'function T{cls}s.Add: T{cls};' + sLineBreak +
    'begin' + sLineBreak +
    '  Result := T{cls}.Create(nil);' + sLineBreak +
    '  Self.Add(Result);' + sLineBreak +
    'end;' + sLineBreak +
    '' + sLineBreak +

    'end.' ;

  cCNT_FIELD =
    '    f{atr}: {tip};' + sLineBreak ;

  cCNT_CAMPO =
    '    Add(''{atr}'', ''{cpo}'', {tip});' + sLineBreak ;

  cCNT_PROPERT =
    '    property {atr} : {tip} read f{atr} write f{atr};' + sLineBreak ;

procedure TC_PersistentContexto.processarEntidade(AContexto : TmContexto; AEntidade : String);
var
  vArquivo, vConteudo,
  vArq, vCls, vAtr, vTip, vTipCpo,
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
      vTipCpo := 'tfKey'
    else if vCampoF.Required then
      vTipCpo := 'tfReq'
    else
      vTipCpo := 'tfNul';

    vCampo := cCNT_CAMPO;
    vCampo := AnsiReplaceStr(vCampo, '{atr}', vAtr);
    vCampo := AnsiReplaceStr(vCampo, '{cpo}', vCampoF.FieldName);
    vCampo := AnsiReplaceStr(vCampo, '{tip}', vTipCpo);
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

  vArquivo := TmPath.Temp() + 'u' + vArq + '.pas';
  TmArquivo.Gravar(vArquivo, vConteudo);
end;


end.
