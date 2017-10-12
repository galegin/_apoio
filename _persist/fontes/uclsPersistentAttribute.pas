unit uclsPersistentAttribute;

interface

uses
  Classes, SysUtils, StrUtils, DB,
  mContexto, 
  uclsPersistentAbstract;

type
  TC_PersistentAttribute = class(TC_PersistentAbstract)
  public
    procedure processarEntidade(AContexto : TmContexto; AEntidade : String); override;
  end;

implementation

{ TC_PersistentAttribute }

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
    '  System.Generics.Collections,' + sLineBreak +
    '  mMapping;' + sLineBreak +
    '' + sLineBreak +

    'type' + sLineBreak +
    '  [Tabela(''{tabela}'')]' + sLineBreak +
    '  T{cls} = class(TmMapping)' + sLineBreak +
    '  private' + sLineBreak +
    '  public' + sLineBreak +
    '    constructor Create(AOwner: TComponent); override;' + sLineBreak +
    '    destructor Destroy; override;' + sLineBreak +
    '  published' + sLineBreak +
    '{properts}' +
    '  end;' + sLineBreak +
    '' + sLineBreak +

    '  T{cls}s = class(TList<{cls}>);' + sLineBreak +
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

    'end.' ;

  cCNT_PROPERT =
    '    [Campo(''{cpo}'', {fld})]' + sLineBreak +
    '    property {atr} : {tip} read f{atr} write f{atr};' + sLineBreak ;

procedure TC_PersistentAttribute.processarEntidade(AContexto : TmContexto; AEntidade : String);
var
  vArquivo, vConteudo, vPath,
  vArq, vCls, vAtr, vTip, vFld,
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

    vPropert := cCNT_PROPERT;
    vPropert := AnsiReplaceStr(vPropert, '{atr}', vAtr);
    vPropert := AnsiReplaceStr(vPropert, '{tip}', vTip);
    vPropert := AnsiReplaceStr(vPropert, '{cpo}', vCampoF.FieldName);
    vPropert := AnsiReplaceStr(vPropert, '{fld}', vFld);
    vProperts := vProperts + vPropert;
  end;

  vConteudo := AnsiReplaceStr(vConteudo, '{tabela}', AEntidade);
  vConteudo := AnsiReplaceStr(vConteudo, '{properts}', vProperts);

  vPath := 'temp\' + AContexto.Database.Conexao.Parametro.Cd_Ambiente + '\attribute\';
  vArquivo := TmPath.Current(vPath) + 'u' + vArq + '.pas';
  TmArquivo.Gravar(vArquivo, vConteudo);
end;

end.
