unit uclsConverterAbstract;

interface

uses
  Classes, SysUtils, StrUtils;

type
  TpConverter = (tsAll, tsIni, tsFin, tsPar, tsVar);

  TrConverter = record
    Tip : TpConverter;
    Ent : String;
    Sai : String;
  end;

  TrConverterArray = Array Of TrConverter;

  TcConverterAbstract = class
  protected
    function GetConverterArray : TrConverterArray; virtual; abstract;
  public
    function Converter(AString : String) : String;
  end;

  procedure ClrConverterArray(var pConverterArray : TrConverterArray);
  procedure AddConverterArray(var pConverterArray : TrConverterArray; pConverter : TrConverter);

  function StrToTipoConverter(pStr : String) : TpConverter;
  function TipoConverterToStr(pTip : TpConverter) : String;

implementation

uses
  mString, ufrmProcessando;

const
  TpConverterArray : Array [TpConverter] Of String =
    ('tsAll', 'tsIni', 'tsFin', 'tsPar', 'tsVar');

  function StrToTipoConverter(pStr : String) : TpConverter;
  var
    I: Integer;
  begin
    Result := TpConverter(-1);
    for I := 0 to Ord(High(TpConverterArray)) do
      if TpConverterArray[TpConverter(I)] = pStr then
        Result := TpConverter(I);
  end;

  function TipoConverterToStr(pTip : TpConverter) : String;
  begin
    Result := TpConverterArray[pTip];
  end;

  procedure ClrConverterArray(var pConverterArray : TrConverterArray);
  begin
    SetLength(pConverterArray, 0);
  end;

  procedure AddConverterArray(var pConverterArray : TrConverterArray; pConverter : TrConverter);
  begin
    SetLength(pConverterArray, Length(pConverterArray) + 1);
    pConverterArray[High(pConverterArray)].Tip := pConverter.Tip;
    pConverterArray[High(pConverterArray)].Ent := pConverter.Ent;
    pConverterArray[High(pConverterArray)].Sai := pConverter.Sai;
  end;

function TcConverterAbstract.Converter;
var
  vStringPart : TmStringPart;
  vConverter : TrConverter;
  vLista : TStringList;
  vConverterArray : TrConverterArray;
  vLinha, vEnt, vSai : String;
  I, J : Integer;
begin
  vLista := TStringList.Create;
  vLista.Text := AString;

  ufrmProcessando.Instance.Inciar(vLista.Count);

  vConverterArray := GetConverterArray();

  for I := 0 to vLista.Count - 1 do begin
    vLinha := vLista[I];

    if (I mod 100) = 0 then
      ufrmProcessando.Instance.Posicionar(I + 1);

    for J := 1 to High(vConverterArray) do begin
      vConverter := vConverterArray[J];

      case (vConverter.Tip) of
        tsAll, tsVar : begin
          while Pos(lowerCase(vConverter.Ent), lowerCase(vLinha)) > 0 do
            vLinha := StringReplace(vLinha, vConverter.Ent, vConverter.Sai, [rfReplaceAll, rfIgnoreCase]);
        end;

        tsIni : begin
          if TmString.StartsWiths(Trim(vLinha), vConverter.Ent) then
            vLinha := StringReplace(vLinha, vConverter.Ent, vConverter.Sai, [rfReplaceAll, rfIgnoreCase]);
        end;

        tsFin : begin
          if TmString.EndWiths(Trim(vLinha), vConverter.Ent) then
            vLinha := StringReplace(vLinha, vConverter.Ent, vConverter.Sai, [rfReplaceAll, rfIgnoreCase]);
        end;

        tsPar : begin // mString
          vStringPart := TmStringPart.Create(vConverter.Ent, vConverter.Sai);
          while Pos(lowerCase(vStringPart._Ini), lowerCase(vLinha)) > 0 do begin
            vEnt := vStringPart.GetEnt(vLinha);
            vSai := vStringPart.GetSai(vLinha);
            if (vEnt = '') or (vSai = '') then
              Break;

            if Pos(lowerCase(vEnt), lowerCase(vLinha)) > 0 then
              vLinha := StringReplace(vLinha, vEnt, vSai, [rfReplaceAll, rfIgnoreCase]);
          end;
        end;
      end;
    end;

    vLista[I] := vLinha;
  end;

  ufrmProcessando.Destroy;

  Result := vLista.Text;
  vLista.Free;
end;

end.