unit uclsTipoConv;

interface

uses
  Classes, SysUtils, StrUtils;

type
  TTipoConv =
    (tpcMethod,
     tpcType,
     tpcVariable,
     tpcLoop,
     tpcCondition,
     tpcFunction,
     tpcDocument,
     tpcSubst,
     tpcBack,
     tpcEspace,
     tpcString,
     tpcSimbolo);

  function GetLstTipoConv() : String;
  function StrToTipoConv(const s : String) : TTipoConv;
  function TipoConvToStr(const t : TTipoConv) : String;

implementation

const
  ATipoConv : Array [TTipoConv] of String = (
    'Metodo',
    'Tipo',
    'Variavel',
    'Laco',
    'Condicao',
    'Funcao',
    'Documentacao',
    'Substituicao',
    'Backup',
    'Espacamento',
    'String',
    'Simbolo');

function GetLstTipoConv() : String;
var
  I : Integer;
begin
  Result := '';
  for I := Ord(Low(TTipoConv)) to Ord(High(TTipoConv)) do
    Result := Result + IfThen(Result <> '', '|') +
      ATipoConv[TTipoConv(I)];
end;

function StrToTipoConv(const s : String) : TTipoConv;
var
  I : Integer;
begin
  Result := TTipoConv(-1);
  for I := Ord(Low(TTipoConv)) to Ord(High(TTipoConv)) do
    if s = ATipoConv[TTipoConv(I)] then
      Result := TTipoConv(I);
end;

function TipoConvToStr(const t : TTipoConv) : String;
begin
  Result := ATipoConv[t];
end;

end.
