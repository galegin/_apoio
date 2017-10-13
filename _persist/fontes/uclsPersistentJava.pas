unit uclsPersistentJava;

interface

uses
  Classes, SysUtils, StrUtils, DB,
  mContexto, mValue,
  uclsPersistentAbstract;

type
  TC_PersistentJava = class(TC_PersistentAbstract)
  protected
    procedure ProcessarEntidade(AContexto : TmContexto; AEntidade : String); override;
  public
    constructor Create; override;
  end;

implementation

{ TC_PersistentJava }

uses
  mDatabase, mArquivo, mString, mPath;

const
  cCNT_CLASSE =
    'package MORM.Java.Models;' + sLineBreak +
    '' + sLineBreak +

    'import java.util.Date;' + sLineBreak +
    'import MORM.Java.Classes;' + sLineBreak +
    '' + sLineBreak +

    '@Tabela("{tabela}")' + sLineBreak +
    'public class {cls} extends CollectionItem' + sLineBreak +
    '{' + sLineBreak +
    '{properts}' +
    '}' ;

  cCNT_PROPERT =
    '    @Campo("{cpo}", CampoTipo.{fld})' + sLineBreak +
    '    public {tip} {atr};' + sLineBreak ;

constructor TC_PersistentJava.Create;
begin
  inherited;
  ClrTipoBaseLingArray();
  AddTipoBaseLingArray(tbBoolean, 'Boolean');
  AddTipoBaseLingArray(tbDateTime, 'DateTime');
  AddTipoBaseLingArray(tbFloat, 'Float');
  AddTipoBaseLingArray(tbInteger, 'Integer');
  AddTipoBaseLingArray(tbString, 'String');
end;

procedure TC_PersistentJava.ProcessarEntidade(AContexto : TmContexto; AEntidade : String);
var
  vArquivo, vConteudo, vPath,
  vProperts, vPropert,
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

    vPropert := cCNT_PROPERT;
    vPropert := AnsiReplaceStr(vPropert, '{atr}', vAtr);
    vPropert := AnsiReplaceStr(vPropert, '{tip}', vTip);
    vPropert := AnsiReplaceStr(vPropert, '{cpo}', vCampo.FieldName);
    vPropert := AnsiReplaceStr(vPropert, '{fld}', vFld);
    vProperts := vProperts + vPropert;
  end;

  vConteudo := AnsiReplaceStr(vConteudo, '{tabela}', AEntidade);
  vConteudo := AnsiReplaceStr(vConteudo, '{properts}', vProperts);

  vPath := 'temp\' + AContexto.Database.Conexao.Parametro.Cd_Ambiente + '\Java\';
  vArquivo := TmPath.Current(vPath) + vArq + '.java';
  TmArquivo.Gravar(vArquivo, vConteudo);
end;

end.
