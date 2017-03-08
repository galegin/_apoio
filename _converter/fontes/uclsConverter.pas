unit uclsConverter;

interface

uses
  Classes, SysUtils;

type
  TTipoAlteracao = (
    taCommentario, // ; /* */
    taConteudo, // '' identificar os conteudos texto
    taEspacamento, // '' identificar espacamento inicial da linha de codigo
    taMetodo, // procedure function
    taVariavel, // boolean datetime float integer string
    taRepeticao, // while for repeat
    taCondicao, // if then begin end else end
    taFuncao, //
    taAlterar,
    taIgnorar); // ;

  RTipoAlteracao = record
    Typ : TTipoAlteracao;
    Exp : String;
    Ent : String;
    Sai : String;
  end;

const
  LTipoAlteracao : Array [0..31] of RTipoAlteracao = (
    (Typ: taMetodo; Exp: 'public operation {val}' ; Ent: '{mtd}'; Sai: 'function {mtd}(pParams : String) : String;' ),
    (Typ: taMetodo; Exp: 'partner operation {val}'; Ent: '{mtd}'; Sai: 'function {mtd}(pParams : String) : String;' ),
    (Typ: taMetodo; Exp: 'entry {val}'            ; Ent: '{mtd}'; Sai: 'function {mtd}(pParams : String) : String;' ),

    (Typ: taVariavel; Exp: 'boolean {val}' ; Ent: '{var}'; Sai: '{var} : Boolean;'  ),
    (Typ: taVariavel; Exp: 'datetime {val}'; Ent: '{var}'; Sai: '{var} : TDateTime;'),
    (Typ: taVariavel; Exp: 'numeric {val}' ; Ent: '{var}'; Sai: '{var} : Real;'     ),
    (Typ: taVariavel; Exp: 'string {val}'  ; Ent: '{var}'; Sai: '{var} : String;'   ),

    (Typ: taAlterar;   Exp: 'endwhile{val}'; Ent: 'endwhile'  ; Sai: 'end;' ),
    (Typ: taRepeticao; Exp: 'while{val}'   ; Ent: '({exp})'; Sai: 'while ({exp}) do begin' ),

    (Typ: taAlterar;  Exp: 'endif{val}';  Ent: 'endif'; Sai: 'end;' ),
    (Typ: taCondicao; Exp: 'else{val}';   Ent: '({exp})'; Sai: 'end else begin' ),
    (Typ: taCondicao; Exp: 'elseif{val}'; Ent: '({exp})'; Sai: 'end else if ({exp}) then begin' ),
    (Typ: taCondicao; Exp: 'if{val}';     Ent: '({exp})'; Sai: 'if ({exp}) then begin' ),

    (Typ: taFuncao; Exp: 'dbocc({val})'          ; Ent: '{ent}'; Sai: '{ent}.IsEmpty();' ),
    (Typ: taFuncao; Exp: 'creocc{val}'           ; Ent: '"{ent}",{pos}'; Sai: '{ent}.Append({pos});' ),
    (Typ: taFuncao; Exp: 'setocc{val}'           ; Ent: '"{ent}",{pos}'; Sai: '{ent}.RecNo := {pos};' ),
    (Typ: taFuncao; Exp: 'curocc({val})'         ; Ent: '"{ent}"'; Sai: '{ent}.RecNo' ),
    (Typ: taFuncao; Exp: 'totocc({val})'         ; Ent: '"{ent}"'; Sai: '{ent}.RecordCount' ),
    (Typ: taFuncao; Exp: 'remocc({val})'         ; Ent: '"{ent}"'; Sai: '{ent}.Delete();' ),

    (Typ: taFuncao; Exp: 'clear/e{val}'          ; Ent: '"{ent}"'; Sai: '{ent}.Clear();' ),
    (Typ: taFuncao; Exp: 'retrieve/a{val}'       ; Ent: '"{ent}"'; Sai: '{ent}.Consultar(nil);' ),
    (Typ: taFuncao; Exp: 'retrieve/e{val}'       ; Ent: '"{ent}"'; Sai: '{ent}.Consultar(nil);' ),
    (Typ: taFuncao; Exp: 'retrieve/o{val}'       ; Ent: '"{ent}"'; Sai: '{ent}.Consultar(nil);' ),
    (Typ: taFuncao; Exp: 'retrieve/x{val}'       ; Ent: '"{ent}"'; Sai: '{ent}.Consultar(nil);' ),

    (Typ: taFuncao; Exp: 'sort/e{val}'           ; Ent: '"{ent}","{cpo}"'; Sai: '{ent}.IndexFieldsNames(''{cpo}'');' ),
    (Typ: taFuncao; Exp: 'discard{val}'          ; Ent: '"{ent}"'; Sai: '{ent}.Delete();' ),

    (Typ: taFuncao; Exp: 'getlistitem/occ{val}'  ; Ent: '{var},{ent}'; Sai: '{var} := TmXml.GetXmlFromObject({ent});' ),
    (Typ: taFuncao; Exp: 'putlistitem/occ{val}'  ; Ent: '{var},{ent}'; Sai: 'TmXml.SetXmlToObject({var}, {ent});' ),

    (Typ: taFuncao; Exp: '$instancehandle{val}'  ; Ent: '->{met}({par})'; Sai: '{met}({par});' ),
    (Typ: taFuncao; Exp: 'collhandle{val}'       ; Ent: '("{ent}")->{met}()'; Sai: '{ent}.{met}();' ),
    (Typ: taFuncao; Exp: 'activate{val}'         ; Ent: '"{cmp}".{met}({par})'; Sai: '{cmp}.{met}({par});' ),
    (Typ: taFuncao; Exp: 'call{val}'             ; Ent: ' {met}({par})'; Sai: '{met}({par})' ));

  procedure BackupLinha(var ALinha : String; out ABackup : TStringList);
  procedure RestoreLinha(var ALinha : String; const ABackup : TStringList);

implementation

uses
  mString, StrUtils;

// comentario
procedure BackupLinha(var ALinha : String; out ABackup : TStringList);
var
  vCod, vVal : String;
begin
  ABackup.Clear();

  // comentario
  if Pos(';', ALinha) > 0 then begin
    vCod := Format('#cmt%d', [ABackup.Count]);
    vVal := TmString.RightStr(ALinha, ';');
    ABackup.Add(vCod + '=' + '//' + vVal);
    ALinha := AnsiReplaceStr(ALinha, ';' + vVal, vCod);
  end;

  // conteudo texto
  (* while Pos('"', ALinha) > 0 do begin
    vCod := Format('#str%d', [ABackup.Count]);
    vVal := TmString.RightStr(ALinha, '"');
    vVal := TmString.LeftStr(vVal, '"');
    ABackup.Add(vCod + '=' + '''' + vVal + '''');
    ALinha := AnsiReplaceStr(ALinha, '"' + vVal + '"', vCod);
  end; *)
end;

procedure RestoreLinha(var ALinha : String; const ABackup : TStringList);
var
  vCod, vVal : String;
  I : Integer;
begin
  for I := 0 to ABackup.Count - 1 do begin
    vCod := TmString.LeftStr(ABackup[I], '=');
    vVal := TmString.RightStr(ABackup[I], '=');
    if Pos(vCod, ALinha) > 0 then
      ALinha := AnsiReplaceStr(ALinha, vCod, vVal);
  end;
end;

end.