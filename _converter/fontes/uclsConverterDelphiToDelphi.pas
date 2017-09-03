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
  TrConverterArray : Array [0..98] Of TrConverter = (

    //-- cDataSetUnf

    (Tip: tsPar; Ent: 'getlistitensocc_a({var},{esp}t{ent});'; Sai: '{var} := f{ent}.GetValues();'),
    (Tip: tsPar; Ent: 'getlistitensocc_e({var},{esp}t{ent});'; Sai: '{var} := f{ent}.GetValues();'),
    (Tip: tsPar; Ent: 'getlistitensocc_i({var},{esp}t{ent});'; Sai: '{var} := f{ent}.GetValues();'),
    (Tip: tsPar; Ent: 'getlistitensocc_o({var},{esp}t{ent});'; Sai: '{var} := f{ent}.GetValues();'),

    (Tip: tsPar; Ent: 'putlistitensocc_e({var},{esp}t{ent});'; Sai: 'f{ent}.SetValues({var});'),
    (Tip: tsPar; Ent: 'putlistitensocc_o({var},{esp}t{ent});'; Sai: 'f{ent}.SetValues({var});'),

    (Tip: tsPar; Ent: 'putitem_e({esp}t{ent},{es1}''{cod}''{es2},{val});'; Sai: 'f{ent}.{cod} := {val};'),
    (Tip: tsPar; Ent: 'putitem_o({esp}t{ent},{es1}''{cod}''{es2},{val});'; Sai: 'f{ent}.{cod} := {val};'),

    (Tip: tsPar; Ent: 'item_a({es1}''{cod}''{es2},{esp}t{ent})'; Sai: 'f{ent}.{cod}'),
    (Tip: tsPar; Ent: 'item_b({es1}''{cod}''{es2},{esp}t{ent})'; Sai: 'f{ent}.{cod}'),
    (Tip: tsPar; Ent: 'item_d({es1}''{cod}''{es2},{esp}t{ent})'; Sai: 'f{ent}.{cod}'),
    (Tip: tsPar; Ent: 'item_f({es1}''{cod}''{es2},{esp}t{ent})'; Sai: 'f{ent}.{cod}'),
    (Tip: tsPar; Ent: 'item_o({es1}''{cod}''{es2},{esp}t{ent})'; Sai: 'f{ent}.{cod}'),
    (Tip: tsPar; Ent: 'item_i({es1}''{cod}''{es2},{esp}t{ent})'; Sai: 'f{ent}.{cod}'),
    (Tip: tsPar; Ent: 'item_s({es1}''{cod}''{es2},{esp}t{ent})'; Sai: 'f{ent}.{cod}'),

    (Tip: tsPar; Ent: 'empty_e({esp}t{ent})'; Sai: 'f{ent}.IsEmpty()'),
    (Tip: tsPar; Ent: 'empty({esp}t{ent})'; Sai: 'f{ent}.IsEmpty()'),

    (Tip: tsPar; Ent: 'dbocc({esp}t{ent})'; Sai: 'f{ent}.IsDatabase()'),
    (Tip: tsPar; Ent: 'curocc({esp}t{ent})'; Sai: 'f{ent}.RecNo'),
    (Tip: tsPar; Ent: 'curoccM({esp}t{ent})'; Sai: 'f{ent}.RecNo'),
    (Tip: tsPar; Ent: 'totocc({esp}t{ent})'; Sai: 'f{ent}.RecordCount()'),
    (Tip: tsPar; Ent: 'creocc({esp}t{ent},{pos})'; Sai: 'f{ent}.Append()'),
    (Tip: tsPar; Ent: 'remocc({esp}t{ent})'; Sai: 'f{ent}.Remove()'),

    (Tip: tsPar; Ent: 'setocc({esp}t{ent}, 1)'; Sai: 'f{ent}.First()'),
    (Tip: tsPar; Ent: 'setocc({esp}t{ent},{pos})'; Sai: 'f{ent}.Next()'),

    (Tip: tsPar; Ent: 'clear_e({esp}t{ent});'; Sai: 'f{ent}.Limpar();'),
    (Tip: tsPar; Ent: 'retrieve_a({esp}t{ent});'; Sai: 'f{ent}.Listar();'),
    (Tip: tsPar; Ent: 'retrieve_e({esp}t{ent});'; Sai: 'f{ent}.Listar();'),
    (Tip: tsPar; Ent: 'retrieve_l({esp}t{ent});'; Sai: 'f{ent}.Consultar();'),
    (Tip: tsPar; Ent: 'retrieve_o({esp}t{ent});'; Sai: 'f{ent}.Consultar();'),
    (Tip: tsPar; Ent: 'retrieve_x({esp}t{ent});'; Sai: 'f{ent}.Consultar();'),
    (Tip: tsPar; Ent: 'discard({esp}t{ent});'; Sai: 'f{ent}.Remover();'),

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
    (Tip: tsPar; Ent: 'TcDataSetUnf.getEntidade({cmp},{es1}''{ent}''{es2},{cod},{con})'; Sai: 'T{ent}.Create(nil)'),
    (Tip: tsPar; Ent: 'TcDataSetUnf.getEntidade({cmp},{es1}''{ent}''{es2},{cod})'; Sai: 'T{ent}.Create(nil)'),
    (Tip: tsPar; Ent: 'TcDataSetUnf.getEntidade({cmp},{es1}''{ent}''{es2})'; Sai: 'T{ent}.Create(nil)'),
    (Tip: tsPar; Ent: 'GetEntidade({es1}''{ent}''{es2},{cod},{con})'; Sai: 'T{ent}.Create(nil)'),
    (Tip: tsPar; Ent: 'GetEntidade({es1}''{ent}''{es2},{cod})'; Sai: 'T{ent}.Create(nil)'),
    (Tip: tsPar; Ent: 'GetEntidade({es1}''{ent}''{es2})'; Sai: 'T{ent}.Create(nil)'),

    //-- cActivate

    (Tip: tsPar; Ent: 'activateCmp({es1}''{cmp}''{es2},{es3}''{mtd}''{es4},{par});'; Sai: 'c{cmp}.Instance.{mtd}({par});'),
    (Tip: tsPar; Ent: 'execClasse({es1}''{cmp}''{es2},{es3}''{mtd}''{es4},{par});'; Sai: 'c{cmp}.Instance.{mtd}({par});'),
    (Tip: tsPar; Ent: 'exceObjeto({cmp},{es3}''{mtd}''{es4},{par});'; Sai: 'c{cmp}.Instance.{mtd}({par});'),

    //-- cFuncao

    (Tip: tsPar; Ent: 'getlistitemsoccApp({str},{esp}t{ent});'; Sai: 'f{ent}.SetValues({str});'),
    (Tip: tsPar; Ent: 'getlistitemsoccIns({str},{esp}t{ent});'; Sai: 'f{ent}.SetValues({str});'),
    (Tip: tsPar; Ent: 'getlistitemsocc({str},{esp}t{ent});'; Sai: 'f{ent}.SetValues({str});'),
    (Tip: tsPar; Ent: 'putlistitemsocc({str},{esp}t{ent});'; Sai: '{str} := f{ent}.GetValues();'),

    (Tip: tsPar; Ent: 'putitemXml({var},{es1}''{cod}''{es2},{val});'; Sai: '{var}.{cod} := {val};'),
    (Tip: tsPar; Ent: 'putitem({esp}t{ent},{es1}''{cod}''{es2},{val});'; Sai: 'f{ent}.{cod} := {val};'),

    (Tip: tsPar; Ent: 'itemXmlB({es1}''{cod}''{es2},{var})'; Sai: '{var}.{cod}'),
    (Tip: tsPar; Ent: 'itemXmlD({es1}''{cod}''{es2},{var})'; Sai: '{var}.{cod}'),
    (Tip: tsPar; Ent: 'itemXmlF({es1}''{cod}''{es2},{var})'; Sai: '{var}.{cod}'),
    (Tip: tsPar; Ent: 'itemXmlI({es1}''{cod}''{es2},{var})'; Sai: '{var}.{cod}'),
    (Tip: tsPar; Ent: 'itemXml({es1}''{cod}''{es2},{var})'; Sai: '{var}.{cod}'),

    (Tip: tsPar; Ent: 'itemB({es1}''{cod}''{es2},{esp}t{ent})'; Sai: 'f{ent}.{cod}'),
    (Tip: tsPar; Ent: 'itemD({es1}''{cod}''{es2},{esp}t{ent})'; Sai: 'f{ent}.{cod}'),
    (Tip: tsPar; Ent: 'itemF({es1}''{cod}''{es2},{esp}t{ent})'; Sai: 'f{ent}.{cod}'),
    (Tip: tsPar; Ent: 'itemI({es1}''{cod}''{es2},{esp}t{ent})'; Sai: 'f{ent}.{cod}'),
    (Tip: tsPar; Ent: 'item({es1}''{cod}''{es2},{esp}t{ent})'; Sai: 'f{ent}.{cod}'),

    (Tip: tsPar; Ent: 'GravaIni({cpo},{var})'; Sai: 'TcIniFiles.Setar('''','''',{cpo},{var})'),
    (Tip: tsPar; Ent: 'LeIniB({cpo})'; Sai: 'TcIniFiles.PegarB('''','''',{cpo})'),
    (Tip: tsPar; Ent: 'LeIniD({cpo})'; Sai: 'TcIniFiles.PegarD('''','''',{cpo})'),
    (Tip: tsPar; Ent: 'LeIniF({cpo})'; Sai: 'TcIniFiles.PegarF('''','''',{cpo})'),
    (Tip: tsPar; Ent: 'LeIniI({cpo})'; Sai: 'TcIniFiles.PegarI('''','''',{cpo})'),
    (Tip: tsPar; Ent: 'LeIni({cpo})'; Sai: 'TcIniFiles.Pegar('''','''',{cpo})'),

    //-- cStatus

    (Tip: tsPar; Ent: 'Result := SetStatus({sts},{tip},{msg},{mtd});'; Sai: 'raise Exception.Create({msg} + '' / '' + {mtd});'),
    (Tip: tsAll; Ent: 'if (xStatus < 0) then'; Sai: 'if (itemXmlF(''status'', voParams) < 0) then'),
    (Tip: tsAll; Ent: 'Result := voParams;'; Sai: 'raise Exception.Create(itemXml(''message'', voParams));'),
    (Tip: tsAll; Ent: 'return(-1); exit;'; Sai: 'exit;'),
    (Tip: tsAll; Ent: 'return(0); exit;'; Sai: 'exit;'),

    (Tip: tsAll; Ent: 'while (xStatus >= 0) do'; Sai: 'while not t.EOF do'),

    (Tip: tsAll; Ent: ' = True)'; Sai: ')'),
    (Tip: tsPar; Ent: 'if ({exp} = True) then'; Sai: 'if ({exp}) then'),
    (Tip: tsPar; Ent: 'if ({exp} = False) then'; Sai: 'if not ({exp}) then'),

    //-- cString

    (Tip: tsAll; Ent: ' :=    '; Sai: ' := '),
    (Tip: tsAll; Ent: ' :=   '; Sai: ' := '),
    (Tip: tsAll; Ent: ' :=  '; Sai: ' := '),
    (Tip: tsAll; Ent: ' -    '; Sai: ' := '),
    (Tip: tsAll; Ent: ' -   '; Sai: ' := '),
    (Tip: tsAll; Ent: ' -  '; Sai: ' := '),
    (Tip: tsAll; Ent: ' +    '; Sai: ' := '),
    (Tip: tsAll; Ent: ' +   '; Sai: ' := '),
    (Tip: tsAll; Ent: ' +  '; Sai: ' := '),

    (Tip: tsAll; Ent: '(   '; Sai: '('),
    (Tip: tsAll; Ent: '(  '; Sai: '('),
    (Tip: tsAll; Ent: '( '; Sai: '('),
    (Tip: tsAll; Ent: '   )'; Sai: ')'),
    (Tip: tsAll; Ent: '  )'; Sai: ')'),
    (Tip: tsAll; Ent: ' )'; Sai: ')')

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
