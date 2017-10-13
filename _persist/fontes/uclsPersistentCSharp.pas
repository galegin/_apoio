unit uclsPersistentCSharp;

interface

uses
  Classes, SysUtils, StrUtils, DB,
  mContexto, mValue,
  uclsPersistentAbstract;

type
  TC_PersistentCSharp = class(TC_PersistentAbstract)
  protected
    procedure ProcessarEntidade(AContexto : TmContexto; AEntidade : String); override;
  public
    constructor Create; override;
  end;

implementation

{ TC_PersistentCSharp }

uses
  mDatabase, mArquivo, mString, mPath;

const
  cCNT_CLASSE =
    'using MORM.CSharp.Classes;' + sLineBreak +
    'using System;' + sLineBreak +
    '' + sLineBreak +

    'namespace MORM.CSharp.Models' + sLineBreak +
    '{' + sLineBreak +
    '    [Tabela("{tabela}")]' + sLineBreak +
    '    public class {cls} : CollectionItem' + sLineBreak +
    '    {' + sLineBreak +
    '{properts}' +
    '    }' + sLineBreak +
    '}' ;

  cCNT_PROPERT =
    '        [Campo("{cpo}", CampoTipo.{fld})]' + sLineBreak +
    '        public {tip} {atr} { get; set; }' + sLineBreak ;

constructor TC_PersistentCSharp.Create;
begin
  inherited;
  AddTipoBaseLingArray(tbBoolean, 'bool');
  AddTipoBaseLingArray(tbDateTime, 'DateTime');
  AddTipoBaseLingArray(tbFloat, 'double');
  AddTipoBaseLingArray(tbInteger, 'int');
  AddTipoBaseLingArray(tbString, 'string');
end;

procedure TC_PersistentCSharp.ProcessarEntidade(AContexto : TmContexto; AEntidade : String);
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

  vPath := 'temp\' + AContexto.Database.Conexao.Parametro.Cd_Ambiente + '\CSharp\';
  vArquivo := TmPath.Current(vPath) + vArq + '.cs';
  TmArquivo.Gravar(vArquivo, vConteudo);
end;

end.
