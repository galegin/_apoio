unit uclsConverterDelphiToDelphi;

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

  TcConverterDelphiToDelphi = class
  public
    class function Converter(AString : String) : String;
  end;

implementation

uses
  mString;

{ TcConverterDelphiToDelphi }

const
  TrConverterArray : Array [0..24] Of TrConverter = (
    (Tip: tsPar; Ent: 'getlistitemsApp({var},{val});'; Sai: '{val}.SetValues({var});'),
    (Tip: tsPar; Ent: 'getlistitemsIns({var},{val});'; Sai: '{val}.SetValues({var});'),
    (Tip: tsPar; Ent: 'getlistitems({var},{val});'; Sai: '{val}.SetValues({var});'),
    (Tip: tsPar; Ent: 'putlistitems({var},{val});'; Sai: '{var} := {val}.GetValues();'),

    (Tip: tsPar; Ent: 'putitemXml({var},{cod},{val});'; Sai: '{var}.{cod} := {val};'),
    (Tip: tsPar; Ent: 'putitem_a({var},{cod},{val});'; Sai: '{var}.{cod} := {val};'),
    (Tip: tsPar; Ent: 'putitem_e({var},{cod},{val});'; Sai: '{var}.{cod} := {val};'),
    (Tip: tsPar; Ent: 'putitem_o({var},{cod},{val});'; Sai: '{var}.{cod} := {val};'),
    (Tip: tsPar; Ent: 'putitem({var},{cod},{val});'; Sai: '{var}.{cod} := {val};'),

    (Tip: tsPar; Ent: 'itemXmlB({cod},{var)'; Sai: '{var}.{cod}'),
    (Tip: tsPar; Ent: 'itemXmlD({cod},{var)'; Sai: '{var}.{cod}'),
    (Tip: tsPar; Ent: 'itemXmlF({cod},{var)'; Sai: '{var}.{cod}'),
    (Tip: tsPar; Ent: 'itemXmlI({cod},{var)'; Sai: '{var}.{cod}'),
    (Tip: tsPar; Ent: 'itemXml({cod},{var)'; Sai: '{var}.{cod}'),

    (Tip: tsPar; Ent: 'item_a({cod},{var)'; Sai: '{var}.{cod}'),
    (Tip: tsPar; Ent: 'item_b({cod},{var)'; Sai: '{var}.{cod}'),
    (Tip: tsPar; Ent: 'item_d({cod},{var)'; Sai: '{var}.{cod}'),
    (Tip: tsPar; Ent: 'item_f({cod},{var)'; Sai: '{var}.{cod}'),
    (Tip: tsPar; Ent: 'item_i({cod},{var)'; Sai: '{var}.{cod}'),
    (Tip: tsPar; Ent: 'item_s({cod},{var)'; Sai: '{var}.{cod}'),

    (Tip: tsPar; Ent: 'itemB({cod},{var)'; Sai: '{var}.{cod}'),
    (Tip: tsPar; Ent: 'itemD({cod},{var)'; Sai: '{var}.{cod}'),
    (Tip: tsPar; Ent: 'itemF({cod},{var)'; Sai: '{var}.{cod}'),
    (Tip: tsPar; Ent: 'itemI({cod},{var)'; Sai: '{var}.{cod}'),
    (Tip: tsPar; Ent: 'item({cod},{var)'; Sai: '{var}.{cod}')
  );

class function TcConverterDelphiToDelphi.Converter(AString: String): String;
var
  vStringPart : TmStringPart;
  vConverter : TrConverter;
  vLista : TStringList;
  vLinha, vEnt, vSai : String;
  I, J : Integer;
begin
  vLista := TStringList.Create;
  vLista.Text := AString;

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
          if TmString.StartsWiths(Trim(vLinha), vConverter.Ent) then
            vLinha := StringReplace(vLinha, vConverter.Ent, vConverter.Sai, [rfReplaceAll, rfIgnoreCase]);
        end;

        tsFin : begin
          if TmString.EndWiths(Trim(vLinha), vConverter.Ent) then
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
