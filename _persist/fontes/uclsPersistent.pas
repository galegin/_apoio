unit uclsPersistent;

interface

uses
  Classes, SysUtils, StrUtils, DB;

type
  TC_Persistent = class
  public
    class procedure gerar(AFiltro : String);
  end;

implementation

{ TC_Persistent }

uses
  //mDatabaseFactory, mDatabaseIntf, mProperty, mFilter,
  mContexto, mArquivo, mString, mDatabase, mPath;

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
    '{proc_ints}' +
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

    '  Result.Chaves := TmChaves.Create;' + sLineBreak +
    '  with Result.Chaves do begin' + sLineBreak +
    '{chaves}' +
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

    '{proc_imps}' +

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
    '    Add(''{atr}'', ''{cpo}'');' + sLineBreak ;

  cCNT_CHAVE =
    '    Add(''{atr}'', ''{cpo}'');' + sLineBreak ;

  cCNT_PROPERT =
    '    property {atr} : {tip} read f{atr} write Set{atr};' + sLineBreak ;

  cCNT_PROC_INT =
    '    procedure Set{atr}(const Value : {tip});' + sLineBreak ;

  cCNT_PROC_IMP =
    'procedure T{cls}.Set{atr}(const Value : {tip});' + sLineBreak +
    'begin' + sLineBreak +
    '  f{atr} := Value;' + sLineBreak +
    'end;' + sLineBreak +
    '' + sLineBreak ;

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

  function TipoAtributo(AFieldType : TFieldType) : String;
  begin
    case AFieldType of
      ftBoolean: Result := 'Boolean';
      ftDate, ftDateTime, ftTime, ftTimeStamp: Result := 'TDateTime';
      ftFloat, ftFMTBcd, ftBCD: Result := 'Real';
      ftInteger, ftWord: Result := 'Integer';
      ftString: Result := 'String';
    else
      Result := 'String';
    end;
  end;

  procedure processarEntidade(AContexto : TmContexto; AEntidade : String);
  var
    vArquivo, vConteudo,
    vArq, vCls, vAtr, vTip,
    vCampos, vCampo, vChaves, vChave,
    vFields, vField,
    vProperts, vPropert,
    vProcInts, vProcInt, vProcImps, vProcImp : String;
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
    vChaves := '';
    vFields := '';
    vProperts := '';
    vProcInts := '';
    vProcImps := '';

    for I := 0 to vMetadata.FieldCount - 1 do begin
      vCampoF := vMetadata.Fields[I];

      vAtr := NomeAtributo(vCampoF.FieldName);
      vTip := TipoAtributo(vCampoF.DataType);

      if vAtr = 'U_Version' then
        vKey := False;

      if vKey then begin
        vChave := cCNT_CHAVE;
        vChave := AnsiReplaceStr(vChave, '{atr}', vAtr);
        vChave := AnsiReplaceStr(vChave, '{cpo}', vCampoF.FieldName);
        vChaves := vChaves + vChave;
      end;

      vCampo := cCNT_CAMPO;
      vCampo := AnsiReplaceStr(vCampo, '{atr}', vAtr);
      vCampo := AnsiReplaceStr(vCampo, '{cpo}', vCampoF.FieldName);
      vCampos := vCampos + vCampo;

      vField := cCNT_FIELD;
      vField := AnsiReplaceStr(vField, '{atr}', vAtr);
      vField := AnsiReplaceStr(vField, '{tip}', vTip);
      vFields := vFields + vField;

      vPropert := cCNT_PROPERT;
      vPropert := AnsiReplaceStr(vPropert, '{atr}', vAtr);
      vPropert := AnsiReplaceStr(vPropert, '{tip}', vTip);
      vProperts := vProperts + vPropert;

      vProcInt := cCNT_PROC_INT;
      vProcInt := AnsiReplaceStr(vProcInt, '{atr}', vAtr);
      vProcInt := AnsiReplaceStr(vProcInt, '{tip}', vTip);
      vProcInts := vProcInts + vProcInt;

      vProcImp := cCNT_PROC_IMP;
      vProcImp := AnsiReplaceStr(vProcImp, '{cls}', vCls);
      vProcImp := AnsiReplaceStr(vProcImp, '{atr}', vAtr);
      vProcImp := AnsiReplaceStr(vProcImp, '{tip}', vTip);
      vProcImps := vProcImps + vProcImp;
    end;

    vConteudo := AnsiReplaceStr(vConteudo, '{tabela}', AEntidade);
    vConteudo := AnsiReplaceStr(vConteudo, '{campos}', vCampos);
    vConteudo := AnsiReplaceStr(vConteudo, '{chaves}', vChaves);
    vConteudo := AnsiReplaceStr(vConteudo, '{fields}', vFields);
    vConteudo := AnsiReplaceStr(vConteudo, '{properts}', vProperts);
    vConteudo := AnsiReplaceStr(vConteudo, '{proc_ints}', vProcInts);
    vConteudo := AnsiReplaceStr(vConteudo, '{proc_imps}', vProcImps);

    vArquivo := TmPath.Temp() + 'u' + vArq + '.pas';
    TmArquivo.Gravar(vArquivo, vConteudo);
  end;

class procedure TC_Persistent.gerar;
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

end.
