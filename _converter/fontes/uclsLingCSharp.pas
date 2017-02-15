unit uclsLingCSharp;

interface

uses
  Classes, SysUtils,
  uclsTipoConv, uclsLing;

type
  TLingCSharp = class(TLing)
  public
  end;

implementation

const
  cDOCU_CSHARP =
    '<reg exp="(*" ent="/*" />' +
    '<reg exp="*)" ent="*/" />' +
    '<reg exp="{"  ent="/*" />' +
    '<reg exp="}"  ent="*/" />' ;

  cSUBS_CSHARP =
    '<reg exp="begin"       ent="{"        />' +
    '<reg exp=" end "       ent=" } "      />' +
    '<reg exp="end "        ent="} "       />' +
    '<reg exp="end;"        ent="}"        />' +
    '<reg exp=" or "        ent=" || "     />' +
    '<reg exp=" and "       ent=" && "     />' +
    '<reg exp="except"      ent="} catch (Exception e) {" />' +
    '<reg exp="try"         ent="try {"    />' +
    '<reg exp="repeat"      ent="do {"     />' +
    '<reg exp="until ("     ent="while !(" />' +
    '<reg exp="result {pi}" ent="return"   />' +
    '<reg exp="exit;"       ent="return;"  />' +
    '<reg exp="class "      ent="static "  />' ;

  cBACK_CSHARP =
    '<reg exp="&lt;&gt;" ent="{mame}" sai=""        />' + // <>
    '<reg exp="&gt;="    ent="{maig}" sai=""        />' + // >=
    '<reg exp="&lt;="    ent="{meig}" sai=""        />' + // <=
    '<reg exp="&gt;"     ent="{ma}"   sai=""        />' + // >
    '<reg exp="&lt;"     ent="{me}"   sai=""        />' + // <
    '<reg exp=":="       ent="{pi}"   sai="="       />' + // :=
    '<reg exp="="        ent="{ig}"   sai="=="      />' + // =
    '<reg exp="''"       ent="{apos}" sai="&quot;"  />' + // '
    '<reg exp="&quot;"   ent="{quot}" sai="\&quot;" />' ; // "

  cESPA_CSHARP =
    '<reg exp=";" ent=" ; " sai=" ;" />' +
    '<reg exp=":" ent=" : " sai=" :" />' +
    '<reg exp="," ent=" , " sai=" ," />' +
    '<reg exp="*" ent=" * " sai=""   />' +
    '<reg exp="/" ent=" / " sai=""   />' +
    '<reg exp="+" ent=" + " sai=""   />' +
    '<reg exp="-" ent=" - " sai=""   />' +
    '<reg exp="%" ent=" % " sai=""   />' ;

  cTYPE_CSHARP =
    '<boolean     ent="boolean"     />' +
    '<currency    ent="double"      />' +
    '<integer     ent="int"         />' +
    '<real        ent="double"      />' +
    '<string      ent="string"      />' +
    '<tdatetime   ent="datetime"    />' +
    '<textfile    ent="textfile"    />' +
    '<tstringlist ent="tstringlist" />' ;

  cMETH_CSHARP =
    '<reg typ="meth" exp="function {val};"         ent="{mtd}({lstpar}) : {ret}" sai="public {ret} {mtd}({lstpar})" />' +
    '<reg typ="meth" exp="procedure {val};"        ent="{mtd}({lstpar})"         sai="public void {mtd}({lstpar})" />' ;

  cVARS_CSHARP =
    '<reg typ="type" exp="{val};"                  ent="{lstpar}" sai="{lstpar}" />' ;

  cLOOP_CSHARP =
    '<reg typ="loop" exp="for {val} do begin"      ent="{var} = {ini} to {tot}" sai="for ({var} = {ini}; {var} <= {tot}; {var}++) {" />' +
    '<reg typ="loop" exp="for {val} do"            ent="{var} = {ini} to {tot}" sai="for ({var} = {ini}; {var} <= {tot}; {var}++)" />' +
    '<reg typ="loop" exp="while {val} do begin"    ent="{exp}"                  sai="while ({exp}) {" />' +
    '<reg typ="loop" exp="while {val} do"          ent="{exp}"                  sai="while ({exp})" />' ;

  cCOND_CSHARP =
    '<reg typ="cond" exp="if {val} then begin"     ent="{exp}" sai="if ({exp}) {" />' +
    '<reg typ="cond" exp="if {val} then"           ent="{exp}" sai="if ({exp})" />' +
    '<reg typ="cond" exp="case {val} of begin"     ent="{exp}" sai="case ({exp}) of {" />' +
    '<reg typ="cond" exp="case {val} of"           ent="{exp}" sai="case ({exp}) of" />' ;

  cFUNC_CSHARP =
    '<reg typ="func" exp="Pos({val})"              ent="{sub},{str}"                    sai="{str}.IndexOf({sub})" />' +
    '<reg typ="func" exp="on {val});"              ent="{var}: {tip} {fun}({var}.{mtd}" sai="_Logger.e('''', {var}.{mtd});" />' +

    '<reg typ="func" exp="PChar({val})"            ent="{exp}" sai="{exp}" />' +

    '<reg typ="func" exp="SetLength({val})"        ent="{exp}" sai="_Array.setar({exp})" />' +
    '<reg typ="func" exp="Trim({val})"             ent="{exp}" sai="{exp}.Trim()" />' +
    '<reg typ="func" exp="Length({val})"           ent="{exp}" sai="{exp}.Length()" />' +
    '<reg typ="func" exp="LowerCase({val})"        ent="{exp}" sai="{exp}.ToLowerCase()" />' +
    '<reg typ="func" exp="UpperCase({val})"        ent="{exp}" sai="{exp}.ToUpperCase()" />' +
    '<reg typ="func" exp="AnsiReplaceStr({val},"   ent="{exp}" sai="{exp}.Replace(" />' +
    '<reg typ="func" exp="ReplaceStr({val},"       ent="{exp}" sai="{exp}.Replace(" />' +
    '<reg typ="func" exp="ReplicateStr({val},"     ent="{exp}" sai="_String.Replicate({exp}," />' +

    '<reg typ="func" exp="DateTimeToStr({val})"    ent="{exp}" sai="{exp}.ToString()" />' +
    '<reg typ="func" exp="FloatToStr({val})"       ent="{exp}" sai="{exp}.ToString()" />' +
    '<reg typ="func" exp="IntToStr({val})"         ent="{exp}" sai="{exp}.ToString()" />' +

    '<reg typ="func" exp="StrToDateTime({val})"    ent="{exp}" sai="DateTime.Parse({exp})" />' +
    '<reg typ="func" exp="StrToDateTimeDef({val})" ent="{exp}" sai="_Funcao.IffNullD({exp})" />' +
    '<reg typ="func" exp="StrToFloat({val})"       ent="{exp}" sai="Double.Parse({exp})" />' +
    '<reg typ="func" exp="StrToFloatDef({val})"    ent="{exp}" sai="Double.Parse({exp})" />' +
    '<reg typ="func" exp="StrToInt({val})"         ent="{exp}" sai="Int16.Parse({exp})" />' +
    '<reg typ="func" exp="StrToIntDef({val})"      ent="{exp}" sai="Int16.Parse({exp})" />' +

    '<reg typ="func" exp="FormatDateTime({val})"   ent="{exp}" sai="_DataHora.formatar({exp})" />' +

    '<reg typ="func" exp="Copy({val},"             ent="{exp}" sai="{exp}.SubString(" />' +

    '<reg typ="func" exp="CarregarArqBin({val})"   ent="{exp}" sai="_Arquivo.carregar({exp})" />' +
    '<reg typ="func" exp="GravarArqBin({val})"     ent="{exp}" sai="_Arquivo.gravar({exp})" />' +
    '<reg typ="func" exp="FileExists({val})"       ent="{exp}" sai="_Arquivo.exists({exp})" />' +

    '<reg typ="func" exp="FormatFloat({val})"      ent="{exp}" sai="_Formatar.formatFloat({exp})" />' +
    '<reg typ="func" exp="Format({val})"           ent="{exp}" sai="_Formatar.format({exp})" />' +

    '<reg typ="func" exp="LeIni({val})"            ent="{exp}" sai="_ArquivoIni.pegar({exp})" />' +
    '<reg typ="func" exp="GravaIni({val})"         ent="{exp}" sai="_ArquivoIni.setar({exp})" />' ;

  cSTRI_CSHARP =
    '';

  cSIMB_CSHARP =
    '';

  TTipoConvCSharp : array [TTipoConv] of string =
    (cMETH_CSHARP,
     cTYPE_CSHARP,
     cVARS_CSHARP,
     cLOOP_CSHARP,
     cCOND_CSHARP,
     cFUNC_CSHARP,
     cDOCU_CSHARP,
     cSUBS_CSHARP,
     cBACK_CSHARP,
     cESPA_CSHARP,
     cSTRI_CSHARP,
     cSIMB_CSHARP);

end.
