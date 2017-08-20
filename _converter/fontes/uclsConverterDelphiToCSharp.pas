unit uclsConverterDelphiToCSharp;

interface

uses
  Classes, SysUtils, StrUtils;

type
  TpString = (tsAll, tsIni, tsFin, tsPar);

  TrVariavel = record
    Ent : String;
    Sai : String;
  end;

  TrConverter = record
    Tip : TpString;
    Ent : String;
    Sai : String;
  end;

  TcConverterDelphiToCSharp = class
  public
    class function Converter(AString : String) : String;
  end;

implementation

uses
  mString;

{ TcConverterDelphiToCSharp }

const
  TrVariavelArray : Array [0..4] Of TrVariavel = (
    (Ent: 'boolean'; Sai: 'bool'),
    (Ent: 'tdatetime'; Sai: 'DateTime'),
    (Ent: 'integer'; Sai: 'int'),
    (Ent: 'real'; Sai: 'double'),
    (Ent: 'string'; Sai: 'string')
  );

  TrConverterArray : Array [0..79] Of TrConverter = (
    (Tip: tsPar; Ent: 'class function {cls}.{cod}({par}) : {ret};'; Sai: 'public static {ret} {cod}({par})'),
    (Tip: tsPar; Ent: 'function {cls}.{cod}({par}) : {ret};'; Sai: 'public {ret} {cod}({par})'),
    (Tip: tsPar; Ent: 'function {cls}.{cod} : {ret};'; Sai: 'public {ret} {cod}'),
    (Tip: tsPar; Ent: 'function {cls}.{cod};'; Sai: 'public void {cod}'),
    (Tip: tsPar; Ent: 'class function {cod}({par}) : {ret};'; Sai: 'public static {ret} {cod}({par})'),
    (Tip: tsPar; Ent: 'function {cod}({par}) : {ret};'; Sai: 'public {ret} {cod}({par})'),
    (Tip: tsPar; Ent: 'function {cod} : {ret};'; Sai: 'public {ret} {cod}'),
    (Tip: tsPar; Ent: 'function {cod};'; Sai: 'public void {cod}'),

    (Tip: tsPar; Ent: 'class procedure {cls}.{cod}({par});'; Sai: 'public static void {cod}({par})'),
    (Tip: tsPar; Ent: 'procedure {cls}.{cod}({par});'; Sai: 'public void {cod}({par})'),
    (Tip: tsPar; Ent: 'procedure {cls}.{cod};'; Sai: 'public void {cod}'),
    (Tip: tsPar; Ent: 'class procedure {cod}({par});'; Sai: 'public static void {cod}({par})'),
    (Tip: tsPar; Ent: 'procedure {cod}({par});'; Sai: 'public void {cod}({par})'),
    (Tip: tsPar; Ent: 'procedure {cod};'; Sai: 'public void {cod}'),

    (Tip: tsPar; Ent: 'constructor {cls}.Create({par});'; Sai: 'public {cls}({par})'),
    (Tip: tsPar; Ent: 'constructor {cls}.Create;'; Sai: 'public {cls}()'),
    (Tip: tsPar; Ent: 'destructor {cls}.Destroy;'; Sai: 'public ~{cls}()'),

    (Tip: tsAll; Ent: 'boolean'; Sai: 'bool'),
    (Tip: tsAll; Ent: 'tdatetime'; Sai: 'DateTime'),
    (Tip: tsAll; Ent: 'integer'; Sai: 'int'),
    (Tip: tsAll; Ent: 'real'; Sai: 'double'),
    (Tip: tsAll; Ent: 'string'; Sai: 'string'),

    (Tip: tsPar; Ent: 'while ({exp}) do begin'; Sai: 'while ({exp}) {'),
    (Tip: tsPar; Ent: 'while {exp} do begin'; Sai: 'while ({exp}) {'),
    (Tip: tsPar; Ent: 'while ({exp}) do'; Sai: 'while ({exp})'),
    (Tip: tsPar; Ent: 'while {exp} do'; Sai: 'while ({exp})'),

    (Tip: tsPar; Ent: 'for {var} := {fin} downto {ini} do begin'; Sai: 'for (int {var} := {ini}; {ini} > {fin}; {var}--) {'),
    (Tip: tsPar; Ent: 'for {var} := {fin} downto {ini} do'; Sai: 'for (int {var} := {ini}; {ini} > {fin}; {var}--)'),
    (Tip: tsPar; Ent: 'for {var} := {ini} to {fin} do begin'; Sai: 'for (int {var} := {ini}; {ini} < {fin}; {var}++) {'),
    (Tip: tsPar; Ent: 'for {var} := {ini} to {fin} do'; Sai: 'for (int {var} := {ini}; {ini} < {fin}; {var}++)'),

    (Tip: tsPar; Ent: 'case ({exp}) of begin'; Sai: 'swith ({exp}) {'),
    (Tip: tsPar; Ent: 'case {exp} of begin'; Sai: 'swith ({exp}) {'),
    (Tip: tsPar; Ent: 'case ({exp}) of'; Sai: 'swith ({exp})'),
    (Tip: tsPar; Ent: 'case {exp} of'; Sai: 'swith ({exp})'),

    (Tip: tsPar; Ent: 'with {exp} do begin'; Sai: '{exp} := new {exp} {'),
    (Tip: tsPar; Ent: 'with {exp} do'; Sai: '{exp} := new {exp}'),

    (Tip: tsPar; Ent: 'if ({exp}) then begin'; Sai: 'if ({exp}) {'),
    (Tip: tsPar; Ent: 'if {exp} then begin'; Sai: 'if ({exp}) {'),
    (Tip: tsPar; Ent: 'if ({exp}) then'; Sai: 'if ({exp})'),
    (Tip: tsPar; Ent: 'if {exp} then'; Sai: 'if ({exp})'),

    (Tip: tsFin; Ent: 'begin'; Sai: '{'),
    (Tip: tsFin; Ent: 'end;'; Sai: '}'),
    (Tip: tsFin; Ent: 'end.'; Sai: '}'),

    (Tip: tsPar; Ent: 'raise Exception.Create({str});'; Sai: 'throw new Exception({str});'),
    (Tip: tsFin; Ent: 'except'; Sai: '} catch {'),
    (Tip: tsFin; Ent: 'on {str} : Exception do begin'; Sai: '} catch (Exception {str}) {'),

    (Tip: tsPar; Ent: ' := {cls}.Create({par});'; Sai: ' := new {cls}({par});'),
    (Tip: tsPar; Ent: 'FreeAndNil({cls});'; Sai: '{cls} := null;'),

    (Tip: tsAll; Ent: 'inherited;'; Sai: 'base;'),
    (Tip: tsAll; Ent: 'Result '; Sai: 'return '),

    (Tip: tsPar; Ent: 'not Assigned({str})'; Sai: '{str} == null'),
    (Tip: tsPar; Ent: 'Assigned({str})'; Sai: '{str} != null'),

    (Tip: tsPar; Ent: 'Pos({sub},{str})'; Sai: '{str}.IndexOf({sub})'),

    (Tip: tsPar; Ent: 'Copy({var},{ini},{fin})'; Sai: '{var}.Substring({ini}, {fin})'),

    (Tip: tsPar; Ent: 'SetLength({val},{tam})' ; Sai: '{val}.SetLength({tam})'),
    (Tip: tsPar; Ent: 'Trim({val})' ; Sai: '{val}.Trim()'),
    (Tip: tsPar; Ent: 'Length({val})' ; Sai: '{val}.Length()'),
    (Tip: tsPar; Ent: 'LowerCase({val})' ; Sai: '{val}.ToLower()'),
    (Tip: tsPar; Ent: 'UpperCase({val})' ; Sai: '{val}.ToUpper()'),
    (Tip: tsPar; Ent: 'AnsiReplaceStr({val},' ; Sai: '{val}.Replace('),
    (Tip: tsPar; Ent: 'ReplaceStr({val},' ; Sai: '{val}.Replace('),
    (Tip: tsPar; Ent: 'ReplicateStr({val},' ; Sai: '{val}.Replicate(,'),

    (Tip: tsPar; Ent: 'StrToDate({val})' ; Sai: 'DateTime.Parse({val})'),
    (Tip: tsPar; Ent: 'StrToDateDef({val})' ; Sai: 'DateTime.Parse({val} ?? DateTime.Minvalue)'),
    (Tip: tsPar; Ent: 'StrToDateTime({val})' ; Sai: 'DateTime.Parse({val})'),
    (Tip: tsPar; Ent: 'StrToDateTimeDef({val})' ; Sai: 'DateTime.Parse({val} ?? DateTime.Minvalue)'),
    (Tip: tsPar; Ent: 'StrToFloat({val})' ; Sai: 'Double.Parse({val})'),
    (Tip: tsPar; Ent: 'StrToFloatDef({val})' ; Sai: 'Double.Parse({val} ?? 0)'),
    (Tip: tsPar; Ent: 'StrToInt({val})' ; Sai: 'Int16.Parse({val})'),
    (Tip: tsPar; Ent: 'StrToIntDef({val})' ; Sai: 'Int16.Parse({val} ?? 0)'),

    (Tip: tsPar; Ent: 'DateTimeToStr({val})' ; Sai: '{val}.ToString()'),
    (Tip: tsPar; Ent: 'FloatToStr({val})' ; Sai: '{val}.ToString()'),
    (Tip: tsPar; Ent: 'IntToStr({val})' ; Sai: '{val}.ToString()'),

    (Tip: tsPar; Ent: 'FormatDateTime({val})' ; Sai: '{val}.Formatar()'),
    (Tip: tsPar; Ent: 'FormatFloat({val})' ; Sai: '{val}.Formatar()'),

    (Tip: tsAll; Ent: ' <> '; Sai: ' != '),
    (Tip: tsAll; Ent: ' = '; Sai: ' == '),
    (Tip: tsAll; Ent: ' or '; Sai: ' || '),
    (Tip: tsAll; Ent: ' and '; Sai: ' && '),
    (Tip: tsAll; Ent: ' := '; Sai: ' = ')
  );

class function TcConverterDelphiToCSharp.Converter(AString: String): String;
var
  vStringPart : TmStringPart;
  vConverter : TrConverter;
  vLista : TStringList;
  vLinha, vEnt, vSai : String;
  I, J : Integer;
begin
  vLista := TStringList.Create;
  vLista.Text := AString;

  if Pos('implementation', vLista.Text) > 0 then
    while (vLista.Count > 0) and (vLista[0] <> 'implementation') do
      vLista.Delete(0);

  for I := 0 to vLista.Count - 1 do begin
    vLinha := vLista[I];

    for J := 1 to High(TrConverterArray) do begin
      vConverter := TrConverterArray[J];

      case (vConverter.Tip) of
        tsAll : begin
          if Pos(lowerCase(vConverter.Ent), lowerCase(vLinha)) > 0 then
            vLinha := StringReplace(vLinha, vConverter.Ent, vConverter.Sai, [rfReplaceAll, rfIgnoreCase]);
        end;

        tsIni : begin
          if TmString.StartsWiths(vLinha, vConverter.Ent) then
            vLinha := StringReplace(vLinha, vConverter.Ent, vConverter.Sai, [rfReplaceAll, rfIgnoreCase]);
        end;

        tsFin : begin
          if TmString.EndWiths(vLinha, vConverter.Ent) then
            vLinha := StringReplace(vLinha, vConverter.Ent, vConverter.Sai, [rfReplaceAll, rfIgnoreCase]);
        end;

        tsPar : begin // mString
          vStringPart := TmStringPart.Create(vConverter.Ent, vConverter.Sai);
          if Pos(lowerCase(vStringPart._Ini), lowerCase(vLinha)) = 0 then
            Continue;

          vEnt := vStringPart.GetEnt(vLinha);
          if vEnt = '' then
            Continue;

          vSai := vStringPart.GetSai(vLinha);
          if vSai = '' then
            Continue;

          if Pos(lowerCase(vEnt), lowerCase(vLinha)) > 0 then
            vLinha := StringReplace(vLinha, vEnt, vSai, [rfReplaceAll, rfIgnoreCase]);
        end;
      end;
    end;

    vLista[I] := vLinha;
  end;

  Result := vLista.Text;
  vLista.Free;
end;

end.
