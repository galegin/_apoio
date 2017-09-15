unit uclsConverterDelphiToCSharp;

interface

uses
  Classes, SysUtils, StrUtils,
  uclsConverterAbstract;

type
  TcConverterDelphiToCSharp = class(TcConverterAbstract)
  protected
    function GetDsExtensao: String; override;
    function GetConverterArray : TrConverterArray; override;
  end;

implementation

{ TcConverterDelphiToCSharp }

const
  RConverterArray : Array [0..79] Of TrConverter = (
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

    (Tip: tsVar; Ent: 'boolean'; Sai: 'bool'),
    (Tip: tsVar; Ent: 'tdatetime'; Sai: 'DateTime'),
    (Tip: tsVar; Ent: 'integer'; Sai: 'int'),
    (Tip: tsVar; Ent: 'real'; Sai: 'double'),
    (Tip: tsVar; Ent: 'string'; Sai: 'string'),

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

function TcConverterDelphiToCSharp.GetConverterArray;
var
  I: Integer;
begin
  ClrConverterArray(Result);
  for I := 1 to High(RConverterArray) do
    AddConverterArray(Result, RConverterArray[I]);
end;

function TcConverterDelphiToCSharp.GetDsExtensao: String;
begin
  Result := '.pas';
end;

end.
