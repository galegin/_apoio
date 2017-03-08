unit uclsConverter;

interface

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
    taAtribuicao, // :=
    taComparacao, // = < > <> <= >= !=
    taOperacao, // * / - +
    taExpressao,
    taFinalizacao,
    taIgnorar); // ;

  RTipoAlteracao = record
    Typ : TTipoAlteracao;
    Exp : String;
    Ent : String;
    Sai : String;
  end;

const
  LTipoAlteracao : Array [0..44] of RTipoAlteracao = (
    (Typ: taMetodo; Exp: 'function {val};' ; Ent: '{mtd}({lstpar}) : {ret}'; Sai: 'public {ret} {mtd}({lstpar})' ),
    (Typ: taMetodo; Exp: 'procedure {val};'; Ent: '{mtd}({lstpar})'        ; Sai: 'public void {mtd}({lstpar})'  ),

    (Typ: taVariavel; Exp: 'boolean';  Ent: 'boolean' ; Sai: 'boolean' ),
    (Typ: taVariavel; Exp: 'currency'; Ent: 'currency'; Sai: 'double'  ),
    (Typ: taVariavel; Exp: 'datetime'; Ent: 'datetime'; Sai: 'datetime'),
    (Typ: taVariavel; Exp: 'integer';  Ent: 'integer' ; Sai: 'int'     ),
    (Typ: taVariavel; Exp: 'real';     Ent: 'real'    ; Sai: 'double'  ),
    (Typ: taVariavel; Exp: 'string';   Ent: 'string'  ; Sai: 'string'  ),

    (Typ: taRepeticao; Exp: 'for {val} do begin'  ; Ent: '{var} = {ini} to {tot}'; Sai: 'for ({var} = {ini}; {var} <= {tot}; {var}++) {' ),
    (Typ: taRepeticao; Exp: 'for {val} do'        ; Ent: '{var} = {ini} to {tot}'; Sai: 'for ({var} = {ini}; {var} <= {tot}; {var}++)' ),
    (Typ: taRepeticao; Exp: 'while {val} do begin'; Ent: '{exp}'                 ; Sai: 'while ({exp}) {' ),
    (Typ: taRepeticao; Exp: 'while {val} do'      ; Ent: '{exp}'                 ; Sai: 'while ({exp})' ),

    (Typ: taCondicao; Exp: 'if {val} then begin'; Ent: '{exp}'; Sai: 'if ({exp}) {' ),
    (Typ: taCondicao; Exp: 'if {val} then'      ; Ent: '{exp}'; Sai: 'if ({exp})' ),
    (Typ: taCondicao; Exp: 'case {val} of begin'; Ent: '{exp}'; Sai: 'case ({exp}) of {' ),
    (Typ: taCondicao; Exp: 'case {val} of'      ; Ent: '{exp}'; Sai: 'case ({exp}) of' ),

    (Typ: taFuncao; Exp: 'on {val});'             ; Ent: '{var} : {tip} do {fun}({var}.{mtd}'; sai:'_Logger.e('''', {var}.{mtd});' ),

    (Typ: taFuncao; Exp: 'Pos({val})'             ; Ent: '{sub},{str}'; Sai: '{str}.IndexOf({sub})' ),
    (Typ: taFuncao; Exp: 'Copy({val},'            ; Ent: '{exp}'; Sai: '{exp}.SubString(' ),
    (Typ: taFuncao; Exp: 'PChar({val})'           ; Ent: '{exp}'; Sai: '{exp}' ),
    (Typ: taFuncao; Exp: 'SetLength({val})'       ; Ent: '{exp}'; Sai: '_Array.setar({exp})' ),
    (Typ: taFuncao; Exp: 'Trim({val})'            ; Ent: '{exp}'; Sai: '{exp}.Trim()' ),
    (Typ: taFuncao; Exp: 'Length({val})'          ; Ent: '{exp}'; Sai: '{exp}.Length()' ),
    (Typ: taFuncao; Exp: 'LowerCase({val})'       ; Ent: '{exp}'; Sai: '{exp}.ToLowerCase()' ),
    (Typ: taFuncao; Exp: 'UpperCase({val})'       ; Ent: '{exp}'; Sai: '{exp}.ToUpperCase()' ),
    (Typ: taFuncao; Exp: 'AnsiReplaceStr({val},'  ; Ent: '{exp}'; Sai: '{exp}.Replace(' ),
    (Typ: taFuncao; Exp: 'ReplaceStr({val},'      ; Ent: '{exp}'; Sai: '{exp}.Replace(' ),
    (Typ: taFuncao; Exp: 'ReplicateStr({val},'    ; Ent: '{exp}'; Sai: '_String.Replicate({exp},' ),

    (Typ: taFuncao; Exp: 'DateTimeToStr({val})'   ; Ent: '{exp}'; Sai: '{exp}.ToString()' ),
    (Typ: taFuncao; Exp: 'FloatToStr({val})'      ; Ent: '{exp}'; Sai: '{exp}.ToString()' ),
    (Typ: taFuncao; Exp: 'IntToStr({val})'        ; Ent: '{exp}'; Sai: '{exp}.ToString()' ),

    (Typ: taFuncao; Exp: 'StrToDateTime({val})'   ; Ent: '{exp}'; Sai: 'DateTime.Parse({exp})' ),
    (Typ: taFuncao; Exp: 'StrToDateTimeDef({val})'; Ent: '{exp}'; Sai: '_Funcao.IffNullD({exp})' ),
    (Typ: taFuncao; Exp: 'StrToFloat({val})'      ; Ent: '{exp}'; Sai: 'Double.Parse({exp})' ),
    (Typ: taFuncao; Exp: 'StrToFloatDef({val})'   ; Ent: '{exp}'; Sai: 'Double.Parse({exp})' ),
    (Typ: taFuncao; Exp: 'StrToInt({val})'        ; Ent: '{exp}'; Sai: 'Int16.Parse({exp})' ),
    (Typ: taFuncao; Exp: 'StrToIntDef({val})'     ; Ent: '{exp}'; Sai: 'Int16.Parse({exp})' ),

    (Typ: taFuncao; Exp: 'FormatDateTime({val})'  ; Ent: '{exp}'; Sai: '_DataHora.formatar({exp})' ),
    (Typ: taFuncao; Exp: 'FormatFloat({val})'     ; Ent: '{exp}'; Sai: '_Formatar.formatFloat({exp})' ),
    (Typ: taFuncao; Exp: 'Format({val})'          ; Ent: '{exp}'; Sai: '_Formatar.format({exp})' ),

    (Typ: taFuncao; Exp: 'CarregarArqBin({val})'  ; Ent: '{exp}'; Sai: '_Arquivo.carregar({exp})' ),
    (Typ: taFuncao; Exp: 'GravarArqBin({val})'    ; Ent: '{exp}'; Sai: '_Arquivo.gravar({exp})' ),
    (Typ: taFuncao; Exp: 'FileExists({val})'      ; Ent: '{exp}'; Sai: '_Arquivo.exists({exp})' ),

    (Typ: taFuncao; Exp: 'LeIni({val})'           ; Ent: '{exp}'; Sai: '_ArquivoIni.pegar({exp})' ),
    (Typ: taFuncao; Exp: 'GravaIni({val})'        ; Ent: '{exp}'; Sai: '_ArquivoIni.setar({exp})' ));

implementation

end.