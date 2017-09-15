unit uclsConverterConfigurado;

interface

uses
  Classes, SysUtils, StrUtils, Forms,
  uclsConverterAbstract;

type
  TcConverterConfigurado = class(TcConverterAbstract)
  protected
    function GetConverterArray : TrConverterArray; override;
  end;

implementation

uses
  mArquivo, mString;

{ TcConverterConfigurado }

function TcConverterConfigurado.GetConverterArray: TrConverterArray;
var
  vConverter : TrConverter;
  vArquivo, vLinha, vTip, vEnt, vSai : String;
  vLista : TStringList;
  I: Integer;
begin
  vArquivo := Application.ExeName + '.config';
  if not FileExists(vArquivo) then
    raise Exception.Create('Arquivo de configuracao nao encontrado' + sLineBreak +
      'Arquivo: ' + vArquivo);

  ClrConverterArray(Result);

  vLista := TStringList.Create;
  vLista.LoadFromFile(vArquivo);

  for I := 0 to vLista.Count - 1 do begin
    vLinha := vLista[I];

    if (TmString.AllTrim(vLinha) = '')
    or TmString.StartsWiths(vLinha, '#')
    or TmString.StartsWiths(vLinha, '//')
    or TmString.StartsWiths(vLinha, '--') then
      Continue;

    // (Tip: tsPar; Ent: 'getlistitensocc_a({var},{esp}t{ent});'; Sai: 'f{ent}.SetValues({var});'),

    vTip := TmString.RightStr(vLinha, '(Tip: ');
    vTip := TmString.LeftStr(vTip, '; Ent:');
    vConverter.Tip := StrToTipoConverter(vTip);

    vEnt := TmString.RightStr(vLinha, '; Ent: ''');
    vEnt := TmString.LeftStr(vEnt, '''; Sai:');
    vConverter.Ent := vEnt;

    vSai := TmString.RightStr(vLinha, '; Sai: ''');
    vSai := TmString.LeftStr(vSai, '''),');
    vConverter.Sai := vSai;

    AddConverterArray(Result, vConverter);
  end;

  FreeAndNil(vLista);
end;

end.
