unit uclsTipoLing;

interface

uses
  Classes, SysUtils, StrUtils;

type
  TTipoLing = (
     tplCSharp,
     tplDelphi,
     tplJava,
     tplUniface);

  function GetLstTipoLing() : String;
  function StrToTipoLing(const s : String) : TTipoLing;
  function TipoLingToStr(const t : TTipoLing) : String;
  function TipoLingToExt(const t : TTipoLing) : String;

implementation

const
  ATipoLing : Array [TTipoLing] of String = (
    'CSharp',
    'Delphi',
    'Java',
    'Uniface');

  ATipoLing_Ext : Array [TTipoLing] of String = (
    '.cs',
    '.pas',
    '.java',
    '.unf');

function GetLstTipoLing() : String;
var
  I : Integer;
begin
  Result := '';
  for I := Ord(Low(TTipoLing)) to Ord(High(TTipoLing)) do
    Result := Result + IfThen(Result <> '', '|') +
      ATipoLing[TTipoLing(I)];
end;

function StrToTipoLing(const s : String) : TTipoLing;
var
  I : Integer;
begin
  Result := TTipoLing(-1);
  for I := Ord(Low(TTipoLing)) to Ord(High(TTipoLing)) do
    if s = ATipoLing[TTipoLing(I)] then
      Result := TTipoLing(I);
end;

function TipoLingToStr(const t : TTipoLing) : String;
begin
  Result := ATipoLing[t];
end;

function TipoLingToExt(const t : TTipoLing) : String;
begin
  Result := ATipoLing_Ext[t];
end;

end.
