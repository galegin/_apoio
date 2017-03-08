unit uclsTipoParte;

interface

type
  RTipoParte = record
    Cod : String;
    Ini : String;
    Fin : String;
  end;

  LTipoParte = Array Of RTipoParte;

  function GetLstTipoParte(AString : String) : LTipoParte;

implementation

function GetLstTipoParte;
var
  vCod, vIni, vFin : String;
  P : Integer;

  procedure Adicionar(ACod, AIni, AFin : String);
  begin
    SetLength(Result, Length(Result) + 1);
    with Result[High(Result)] do begin
      Cod := '{' + ACod + '}';
      Ini := AIni;
      Fin := AFin;
    end;
  end;

begin
  SetLength(Result, 0);

  //{mtd}({lstpar}) : {ret}
  //{mtd}({lstpar})

  while AString <> '' do begin
    P := Pos('{', AString);
    if P = 0 then Break;
    vIni := Copy(AString, 1, P - 1);
    Delete(AString, 1, P);

    P := Pos('}', AString);
    if P = 0 then Break;
    vCod := Copy(AString, 1, P - 1);
    Delete(AString, 1, P);

    P := Pos('{', AString);
    if P > 0 then
      vFin := Copy(AString, 1, P - 1)
    else
      vFin := AString;

    Adicionar(vCod, vIni, vFin);
  end;
end;

end.
