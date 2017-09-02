unit uclsConverterUnifaceToCSharp;

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

  TcConverterUnifaceToCSharp = class
  public
    class function Converter(AString : String) : String;
  end;

implementation

uses
  mString, ufrmProcessando;

{ TcConverterUnifaceToCSharp }

const
  TrVariavelArray : Array [0..4] Of TrVariavel = (
    (Ent: 'boolean'; Sai: 'bool'),
    (Ent: 'date'; Sai: 'DateTime'),
    (Ent: 'datetime'; Sai: 'DateTime'),
    (Ent: 'numeric'; Sai: 'double'),
    (Ent: 'string'; Sai: 'string')
  );

  TrConverterArray : Array [0..92] Of TrConverter = (
    (Tip: tsPar; Ent: 'public operation {cod}'; Sai: 'public void {cod}'),
    (Tip: tsPar; Ent: 'partner operation {cod}'; Sai: 'protected void {cod}'),
    (Tip: tsPar; Ent: 'entry {cod}'; Sai: 'private void {cod}'),

    (Tip: tsIni; Ent: 'endparams'; Sai: ''),
    (Tip: tsIni; Ent: 'params'; Sai: '/* parametros */'),
    (Tip: tsIni; Ent: 'endvariables'; Sai: ''),
    (Tip: tsIni; Ent: 'variables'; Sai: '/* variaveis */'),

    (Tip: tsAll; Ent: 'boolean'; Sai: 'bool'),
    (Tip: tsAll; Ent: 'datetime'; Sai: 'DateTime'),
    (Tip: tsAll; Ent: 'date'; Sai: 'DateTime'),
    (Tip: tsAll; Ent: 'numeric'; Sai: 'double'),
    (Tip: tsAll; Ent: 'string'; Sai: 'string'),

    (Tip: tsPar; Ent: 'call {cod}({par})'; Sai: '{cod}({par});'),
    (Tip: tsPar; Ent: '$instancehandle->{cod}({par})'; Sai: '{cod}({par});'),
    (Tip: tsPar; Ent: '$collhandle({ent})->{cod}({par})'; Sai: '{ent}.{cod}({par});'),
    (Tip: tsPar; Ent: 'activate{cmp}.{mtd}({par})'; Sai: '{cmp}.{mtd}({par});'),

    (Tip: tsPar; Ent: 'repeat'; Sai: 'do {'),
    (Tip: tsPar; Ent: 'until {exp}'; Sai: 'while ({exp});'),

    (Tip: tsPar; Ent: 'while {exp}'; Sai: 'while ({exp})'),
    (Tip: tsAll; Ent: 'endwhile'; Sai: '}'),

    (Tip: tsPar; Ent: 'selectcase {exp}'; Sai: 'switch ({exp})'),
    (Tip: tsAll; Ent: 'endselectcase'; Sai: '}'),

    (Tip: tsPar; Ent: 'if {exp}'; Sai: 'if ({exp}) {'),
    (Tip: tsAll; Ent: 'endif'; Sai: '}'),

    (Tip: tsPar; Ent: 'getlistitems/occ'; Sai: 'getlistitems/occ'),
    (Tip: tsPar; Ent: 'delitem/id'; Sai: 'delitem('),
    (Tip: tsPar; Ent: 'getitem '; Sai: 'getitem('),

    (Tip: tsPar; Ent: 'putlistitems/occ'; Sai: 'putlistitems/occ'),
    (Tip: tsPar; Ent: 'putitem/id'; Sai: 'putitemXml('),
    (Tip: tsPar; Ent: 'putitem'; Sai: 'putitem('),

    (Tip: tsPar; Ent: '$item'; Sai: 'itemXml'),
    (Tip: tsPar; Ent: '$datim'; Sai: 'DateTime.Now'),
    (Tip: tsPar; Ent: '$date'; Sai: 'DateTime.Today'),
    (Tip: tsPar; Ent: '$clock'; Sai: 'DateTime.Now'),
    (Tip: tsPar; Ent: '$time'; Sai: 'DateTime.Time'),
    (Tip: tsPar; Ent: '$totocc'; Sai: 'totocc'),
    (Tip: tsPar; Ent: 'remocc'; Sai: 'remocc'),
    (Tip: tsPar; Ent: '$curocc'; Sai: 'curocc'),
    (Tip: tsPar; Ent: '$dbocc'; Sai: 'dbocc'),
    (Tip: tsPar; Ent: '$empty'; Sai: 'empty'),
    (Tip: tsPar; Ent: '$tometa'; Sai: 'tometa'),

    (Tip: tsPar; Ent: '$result'; Sai: 'xResult'),
    (Tip: tsPar; Ent: '$status'; Sai: 'xStatus'),
    (Tip: tsPar; Ent: '$procerror'; Sai: 'xProcerror'),
    (Tip: tsPar; Ent: '$procerrorcontext'; Sai: 'xProcerrorContext'),
    (Tip: tsPar; Ent: '$xcderro$'; Sai: 'xCdErro'),
    (Tip: tsPar; Ent: '$xctxerro$'; Sai: 'xCtxErro'),
    (Tip: tsPar; Ent: '$valrep'; Sai: 'valrep'),
    (Tip: tsPar; Ent: '$keyboard'; Sai: '//keyboard'),
    (Tip: tsPar; Ent: '$formtitle'; Sai: '_Caption'),
    (Tip: tsPar; Ent: '$componentname'; Sai: 'gCdComponente'),
    (Tip: tsPar; Ent: '$empty'; Sai: '$empty'),

    (Tip: tsPar; Ent: '$$gParamGlb'; Sai: 'PARAM_GLB'),
    (Tip: tsPar; Ent: '$xlpg$'; Sai: 'PARAM_GLB'),
    (Tip: tsPar; Ent: '$xlpi$'; Sai: 'vpiParams'),
    (Tip: tsPar; Ent: '$xlpo$'; Sai: 'vpoParams'),
    (Tip: tsPar; Ent: '$xlpl$'; Sai: 'xParam'),
    (Tip: tsPar; Ent: '$xlplemp$'; Sai: 'xParamEmp'),

    (Tip: tsPar; Ent: '<STS_AVISO>'; Sai: 'STS_AVISO'),
    (Tip: tsPar; Ent: '<STS_DICA>'; Sai: 'STS_DICA'),
    (Tip: tsPar; Ent: '<STS_ERRO>'; Sai: 'STS_ERROR'),
    (Tip: tsPar; Ent: '<STS_INFO>'; Sai: 'STS_INFO'),
    (Tip: tsPar; Ent: '<FALSE>'; Sai: 'false'),
    (Tip: tsPar; Ent: '<TRUE>'; Sai: 'true'),

    (Tip: tsPar; Ent: 'exit({val})'; Sai: 'return {val};'),
    (Tip: tsPar; Ent: 'exit ({val})'; Sai: 'return {val};'),

    (Tip: tsPar; Ent: 'return({val})'; Sai: 'return {val};'),
    (Tip: tsPar; Ent: 'return ({val})'; Sai: 'return {val};'),

    (Tip: tsPar; Ent: 'creocc{ent},{pos}'; Sai: '{ent}.Add({pos});'),
    (Tip: tsPar; Ent: 'clear/e{ent}'; Sai: '{ent}.Clear();'),
    (Tip: tsPar; Ent: 'retrieve/e{ent}'; Sai: '{ent}.Listar();'),
    (Tip: tsPar; Ent: 'retrieve/a{ent}'; Sai: '{ent}.Listar();'),
    (Tip: tsPar; Ent: 'retrieve/o{ent}'; Sai: '{ent}.Consultar();'),
    (Tip: tsPar; Ent: 'retrieve/x{ent}'; Sai: '{ent}.Consultar();'),
    (Tip: tsPar; Ent: 'discard{ent}'; Sai: '{ent}.Delete();'),

    (Tip: tsPar; Ent: 'sort/e{ent},{ord}'; Sai: '{ent}.Sort({ord});'),
    (Tip: tsPar; Ent: 'curocc({ent})'; Sai: '{ent}.RecNo;'),
    (Tip: tsPar; Ent: 'setocc{ent},{pos}'; Sai: '{ent}.RecNo := {pos};'),

    (Tip: tsPar; Ent: '$$'; Sai: 'gModulo.'),
    (Tip: tsPar; Ent: '%%%'; Sai: ''),
    (Tip: tsPar; Ent: '%%^'; Sai: ''),
    (Tip: tsPar; Ent: '%\'; Sai: ''),

    (Tip: tsPar; Ent: 'askmess'; Sai: 'askmess'),
    (Tip: tsPar; Ent: 'message/warning'; Sai: 'Mensage.Aviso('),
    (Tip: tsPar; Ent: 'message/error'; Sai: 'Mensagem.Erro('),
    (Tip: tsPar; Ent: 'message/hint'; Sai: 'Mensagem.Hint('),
    (Tip: tsPar; Ent: 'message/info'; Sai: 'Mensagem.Info('),
    (Tip: tsPar; Ent: 'message'; Sai: 'Mensagem.Show('),

    (Tip: tsPar; Ent: 'poCdErro'; Sai: 'poCdErro'),
    (Tip: tsPar; Ent: 'poCtxErro'; Sai: 'poCtxErro'),

    (Tip: tsPar; Ent: '#include'; Sai: '#include'),

    (Tip: tsPar; Ent: 'selectdb'; Sai: 'select'),
    (Tip: tsPar; Ent: 'u_where'; Sai: 'where')

  );

class function TcConverterUnifaceToCSharp.Converter(AString: String): String;
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

  ufrmProcessando.Instance.Inciar(vLista.Count);

  for I := 0 to vLista.Count - 1 do begin
    vLinha := vLista[I];

    if (I mod 100) = 0 then
      ufrmProcessando.Instance.Posicionar(I + 1);

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

  ufrmProcessando.Destroy;

  Result := vLista.Text;
  vLista.Free;
end;

end.
