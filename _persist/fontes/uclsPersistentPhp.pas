unit uclsPersistentPhp;

interface

uses
  Classes, SysUtils, StrUtils, DB,
  mContexto, mValue,
  uclsPersistentAbstract;

type
  TC_PersistentPhp = class(TC_PersistentAbstract)
  protected
    procedure ProcessarEntidade(AContexto : TmContexto; AEntidade : String); override;
  public
    constructor Create; override;
  end;

implementation

{ TC_PersistentPhp }

uses
  mDatabase, mArquivo, mString, mPath;

const
  cCNT_CLASSE =
    '<?php' + sLineBreak +
    '' + sLineBreak +

    'require_once("collectionitem.php");' + sLineBreak +
    '' + sLineBreak +

    'class public {cls} extends CollectionItem' + sLineBreak +
    '{' + sLineBreak +
    '{properts}' +
    '}' + sLineBreak +
    '?>' ;

  cCNT_PROPERT =
    '    public ${atr};' + sLineBreak ;

constructor TC_PersistentPhp.Create;
begin
  inherited;
  AddTipoBaseLingArray(tbBoolean, 'boolean');
  AddTipoBaseLingArray(tbDateTime, 'datetime');
  AddTipoBaseLingArray(tbFloat, 'float');
  AddTipoBaseLingArray(tbInteger, 'integer');
  AddTipoBaseLingArray(tbString, 'string');
end;

procedure TC_PersistentPhp.ProcessarEntidade(AContexto : TmContexto; AEntidade : String);
var
  vArquivo, vConteudo, vPath,
  vProperts, vPropert,
  vArq, vCls, vAtr, vTip : String;
  vMetadata : TDataSet;
  vCampo : TField;
  I : Integer;
begin
  vArq := NomeArquivo(AEntidade);
  vCls := NomeClasse(AEntidade);

  vConteudo := cCNT_CLASSE;
  vConteudo := AnsiReplaceStr(vConteudo, '{arq}', vArq);
  vConteudo := AnsiReplaceStr(vConteudo, '{cls}', vCls);

  vMetadata := AContexto.Database.Conexao.GetMetadata(AEntidade);

  vProperts := '';

  for I := 0 to vMetadata.FieldCount - 1 do begin
    vCampo := vMetadata.Fields[I];

    vAtr := NomeAtributo(vCampo.FieldName);
    vTip := TipoAtributo(vCampo.DataType);

    vPropert := cCNT_PROPERT;
    vPropert := AnsiReplaceStr(vPropert, '{atr}', vAtr);
    vPropert := AnsiReplaceStr(vPropert, '{tip}', vTip);
    vProperts := vProperts + vPropert;
  end;

  vConteudo := AnsiReplaceStr(vConteudo, '{properts}', vProperts);

  vPath := 'temp\' + AContexto.Database.Conexao.Parametro.Cd_Ambiente + '\Php\';
  vArquivo := TmPath.Current(vPath) + vArq + '.php';
  TmArquivo.Gravar(vArquivo, vConteudo);
end;

end.
