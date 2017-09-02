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
  mString, ufrmProcessando;

{ TcConverterDelphiToDelphi }

const
  TrConverterArray : Array [0..70] Of TrConverter = (

    //-- cDataSetUnf

    (Tip: tsPar; Ent: 'getlistitens_a({var},{ent});'; Sai: '{var} := {ent}.GetValues();'),
    (Tip: tsPar; Ent: 'getlistitens_e({var},{ent});'; Sai: '{var} := {ent}.GetValues();'),
    (Tip: tsPar; Ent: 'getlistitens_i({var},{ent});'; Sai: '{var} := {ent}.GetValues();'),
    (Tip: tsPar; Ent: 'getlistitens_o({var},{ent});'; Sai: '{var} := {ent}.GetValues();'),

    (Tip: tsPar; Ent: 'putlistitens_e({var},{ent});'; Sai: '{ent}.SetValues({var});'),
    (Tip: tsPar; Ent: 'putlistitens_o({var},{ent});'; Sai: '{ent}.SetValues({var});'),

    (Tip: tsPar; Ent: 'putitem_e({ent},{cod},{val});'; Sai: '{ent}.{cod} := {val};'),
    (Tip: tsPar; Ent: 'putitem_o({ent},{cod},{val});'; Sai: '{ent}.{cod} := {val};'),

    (Tip: tsPar; Ent: 'item_a({cod},{ent})'; Sai: '{ent}.{cod}'),
    (Tip: tsPar; Ent: 'item_b({cod},{ent})'; Sai: '{ent}.{cod}'),
    (Tip: tsPar; Ent: 'item_d({cod},{ent})'; Sai: '{ent}.{cod}'),
    (Tip: tsPar; Ent: 'item_f({cod},{ent})'; Sai: '{ent}.{cod}'),
    (Tip: tsPar; Ent: 'item_o({cod},{ent})'; Sai: '{ent}.{cod}'),
    (Tip: tsPar; Ent: 'item_i({cod},{ent})'; Sai: '{ent}.{cod}'),
    (Tip: tsPar; Ent: 'item_s({cod},{ent})'; Sai: '{ent}.{cod}'),

    (Tip: tsPar; Ent: 'empty_e({ent})'; Sai: '{ent}.IsEmpty()'),
    (Tip: tsPar; Ent: 'empty({ent})'; Sai: '{ent}.IsEmpty()'),

    (Tip: tsPar; Ent: 'dbocc({ent})'; Sai: '{ent}.IsDatabase()'),
    (Tip: tsPar; Ent: 'curocc({ent})'; Sai: '{ent}.RecNo'),
    (Tip: tsPar; Ent: 'curoccM({ent})'; Sai: '{ent}.RecNo'),
    (Tip: tsPar; Ent: 'totocc({ent})'; Sai: '{ent}.RecordCount()'),
    (Tip: tsPar; Ent: 'creocc({ent})'; Sai: '{ent}.Append()'),
    (Tip: tsPar; Ent: 'remocc({ent})'; Sai: '{ent}.Remove()'),

    (Tip: tsPar; Ent: 'clear_e({ent});'; Sai: '{ent}.Limpar();'),
    (Tip: tsPar; Ent: 'retrieve_a({ent});'; Sai: '{ent}.Consultar();'),
    (Tip: tsPar; Ent: 'retrieve_e({ent});'; Sai: '{ent}.Consultar();'),
    (Tip: tsPar; Ent: 'retrieve_l({ent});'; Sai: '{ent}.Consultar();'),
    (Tip: tsPar; Ent: 'retrieve_o({ent});'; Sai: '{ent}.Consultar();'),
    (Tip: tsPar; Ent: 'retrieve_x({ent});'; Sai: '{ent}.Consultar();'),
    (Tip: tsPar; Ent: 'discard({ent});'; Sai: '{ent}.Remover();'),

    (Tip: tsPar; Ent: 'askmess({msg},{opc});'; Sai: 'Mensagem.Dialog({msg},{opc});'),
    (Tip: tsPar; Ent: 'askmess_aviso({msg},{opc});'; Sai: 'Mensagem.Dialog({msg},{opc});'),
    (Tip: tsPar; Ent: 'askmess_erro({msg},{opc});'; Sai: 'Mensagem.Dialog({msg},{opc});'),
    (Tip: tsPar; Ent: 'askmess_info({msg},{opc});'; Sai: 'Mensagem.Dialog({msg},{opc});'),
    (Tip: tsPar; Ent: 'askmess_question({msg},{opc});'; Sai: 'Mensagem.Dialog({msg},{opc});'),
    (Tip: tsPar; Ent: 'askmess_status({msg},{opc});'; Sai: 'Mensagem.Dialog({msg},{opc});'),

    (Tip: tsPar; Ent: 'fieldsyntax({cmp},{ent},{opc});'; Sai: '{cmp}.Enabled := ''{opc}'';'),

    (Tip: tsPar; Ent: 'filedump({cnt},{arq});'; Sai: '_Arquivo.Gravar({arq},{cnt});'),
    (Tip: tsPar; Ent: 'filedump_append({cnt},{arq});'; Sai: '_Arquivo.Adicionar({arq},{cnt});'),

    (Tip: tsPar; Ent: 'prompt({cpo},{ent});'; Sai: '{cpo}.SetFocus();'),
    (Tip: tsPar; Ent: 'scan({str},{sub})'; Sai: 'Pos({sub},{str})'),
    (Tip: tsPar; Ent: 'ulength({str})'; Sai: 'Length({str})'),

    //-- cServiceUnf

    //TcDataSetUnf.getEntidade(
    (Tip: tsPar; Ent: 'TcDataSetUnf.getEntidade({cmp},{ent},{cod},{con})'; Sai: '{ent}.Create(nil)'),
    (Tip: tsPar; Ent: 'TcDataSetUnf.getEntidade({cmp},{ent},{cod})'; Sai: '{ent}.Create(nil)'),
    (Tip: tsPar; Ent: 'TcDataSetUnf.getEntidade({cmp},{ent})'; Sai: '{ent}.Create(nil)'),
    (Tip: tsPar; Ent: 'getEntidade({ent},{cod},{con})'; Sai: '{ent}.Create(nil)'),
    (Tip: tsPar; Ent: 'getEntidade({ent},{cod})'; Sai: '{ent}.Create(nil)'),
    (Tip: tsPar; Ent: 'getEntidade({ent})'; Sai: '{ent}.Create(nil)'),

    //-- cActivate

    (Tip: tsPar; Ent: 'activateCmp({cmp},{mtd},{par});'; Sai: '{cmp}.{mtp}({par});'),    

    //-- cFuncao

    (Tip: tsPar; Ent: 'getlistitemsApp({str},{ent});'; Sai: '{ent}.SetValues({str});'),
    (Tip: tsPar; Ent: 'getlistitemsIns({str},{ent});'; Sai: '{ent}.SetValues({str});'),
    (Tip: tsPar; Ent: 'getlistitemsocc({str},{ent});'; Sai: '{ent}.SetValues({str});'),
    (Tip: tsPar; Ent: 'putlistitemsocc({str},{ent});'; Sai: '{str} := {ent}.GetValues();'),

    (Tip: tsPar; Ent: 'putitemXml({var},{cod},{val});'; Sai: '{var}.{cod} := {val};'),
    (Tip: tsPar; Ent: 'putitem({var},{cod},{val});'; Sai: '{var}.{cod} := {val};'),

    (Tip: tsPar; Ent: 'itemXmlB({cod},{var})'; Sai: '{var}.{cod}'),
    (Tip: tsPar; Ent: 'itemXmlD({cod},{var})'; Sai: '{var}.{cod}'),
    (Tip: tsPar; Ent: 'itemXmlF({cod},{var})'; Sai: '{var}.{cod}'),
    (Tip: tsPar; Ent: 'itemXmlI({cod},{var})'; Sai: '{var}.{cod}'),
    (Tip: tsPar; Ent: 'itemXml({cod},{var})'; Sai: '{var}.{cod}'),

    (Tip: tsPar; Ent: 'itemB({cod},{var})'; Sai: '{var}.{cod}'),
    (Tip: tsPar; Ent: 'itemD({cod},{var})'; Sai: '{var}.{cod}'),
    (Tip: tsPar; Ent: 'itemF({cod},{var})'; Sai: '{var}.{cod}'),
    (Tip: tsPar; Ent: 'itemI({cod},{var})'; Sai: '{var}.{cod}'),
    (Tip: tsPar; Ent: 'item({cod},{var})'; Sai: '{var}.{cod}'),

    (Tip: tsPar; Ent: 'GravaIni({cpo},{var})'; Sai: 'TcIniFiles.Setar('''','''',{cpo},{var})'),
    (Tip: tsPar; Ent: 'LeIniB({cpo})'; Sai: 'TcIniFiles.PegarB('''','''',{cpo})'),
    (Tip: tsPar; Ent: 'LeIniD({cpo})'; Sai: 'TcIniFiles.PegarD('''','''',{cpo})'),
    (Tip: tsPar; Ent: 'LeIniF({cpo})'; Sai: 'TcIniFiles.PegarF('''','''',{cpo})'),
    (Tip: tsPar; Ent: 'LeIniI({cpo})'; Sai: 'TcIniFiles.PegarI('''','''',{cpo})'),
    (Tip: tsPar; Ent: 'LeIni({cpo})'; Sai: 'TcIniFiles.Pegar('''','''',{cpo})')

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
