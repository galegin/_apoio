unit uFrmConveter;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls;

type
  TFrmConverter = class(TForm)
    MemoOri: TMemo;
    PnlConverter: TPanel;
    MemoDes: TMemo;
    Splitter1: TSplitter;
    procedure FormCreate(Sender: TObject);
    procedure PnlConverterClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
  private
  public
  end;

var
  FrmConverter: TFrmConverter;

implementation

{$R *.dfm}

uses
  mArquivo, mString, mControl, mFuncao, mItem, mXml;

procedure TFrmConverter.FormCreate(Sender: TObject);
begin
  MemoOri.Text := mArquivo.carregar(GetCurrentDir() + '\' + 'uECF.pas');
end;

procedure TFrmConverter.FormActivate(Sender: TObject);
begin
  mControl.SetPosWorkDiv(Self);
end;

  //-- recuo

  procedure getRecuo(pLinha : String; var pRecuo : String);
  var
    I : Integer;
  begin
    pRecuo := '';

    for I:=1 to Length(pLinha) do
      if pLinha[I] = ' ' then
        pRecuo := pRecuo + pLinha[I]
      else
        Exit;
  end;

  //-- comentario

  procedure getComent(var pLinha : String; var pComent : String);
  begin
    pComent := GetRightStr(pLinha, '//');
    if pComent <> '' then begin
      pComent := '//' + pComent;
      pLinha := AnsiReplaceStrV(pLinha, pComent, '');
    end;
  end;

  procedure setComent(var pLinha : String);
  const
    cLstDoc : Array [1..4,1..2] of String =
      (('(*','/*'),
       ('*)','*/'),
       ('{','/*'),
       ('}','*/'));
  var
    I : Integer;
  begin
    for I:=Low(cLstDoc) to High(cLstDoc) do
      pLinha := AnsiReplaceStrA(pLinha, cLstDoc[I][1], cLstDoc[I][2]);
  end;

  //-- corrigir

  const
    cLstTyp : Array [1..8,1..2] of String =
      (('boolean','boolean'),
       ('currency','double'),
       ('integer','int'),
       ('real','double'),
       ('string','string'),
       ('tdatetime','datetime'),
       ('textfile','textfile'),
       ('tstringlist','tstringlist'));

  procedure corLinha(var pLinha : String);
  const
    cLstCor : array [1..27] of string =
     ('unit',

      'interface',
      'implementation',

      'uses',

      'type',
      'const',
      'var',

      'procedure',
      'function',

      'class',
      'interface',
      'overload',
      'virtual',
      'override',
      'private',
      'protected',
      'public',
      'published',
      'property',

      'if',
      'begin',
      'else',
      'end',
      'for',
      'while',
      'repeat',

      'result');
  var
    I : Integer;
  begin
    for I:=Low(cLstCor) to High(cLstCor) do
      pLinha := AnsiReplaceStrA(pLinha, cLstCor[I], cLstCor[I]);
    for I:=Low(cLstTyp) to High(cLstTyp) do
      pLinha := AnsiReplaceStrA(pLinha, cLstTyp[I][1], cLstTyp[I][1]);
  end;

  //-- espacamento

  procedure espLinha(var pLinha : String);
  const
    cLstEsp : array [1..8,1..3] of string =
      ((';',' ; ',' ;'),
       (':',' : ',' :'),
       (',',' , ',' ,'),
       ('*',' * ',''),
       ('/',' / ',''),
       ('+',' + ',''),
       ('-',' - ',''),
       ('%',' % ','')
      );
  var
    I : Integer;
  begin
    for I:=Low(cLstEsp) to High(cLstEsp) do begin
      pLinha := AnsiReplaceStrA(pLinha, cLstEsp[I][1], cLstEsp[I][2]);
      pLinha := AllTrim(pLinha);
      if cLstEsp[I][3] <> '' then
        pLinha := AnsiReplaceStrA(pLinha, cLstEsp[I][3], cLstEsp[I][1]);
    end;
  end;

  //-- backup / restore

  procedure backupLinha(var pLinha : String; pRes : Boolean = False);
  const
    cLstBkp : Array [1..10,1..3] of String =
     (('exception', '{excecao}', ''),
      ('<>', '{mame}', ''),
      ('>=', '{maig}', ''),
      ('<=', '{meig}', ''),
      ('>', '{ma}', ''),
      ('<', '{me}', ''),
      (':=', '{pi}', '='),
      ('=', '{ig}', '=='),
      ('''', '{apos}', '"'),
      ('"', '{apas}', '\"'));
  var
    I : Integer;
  begin
    for I:=Low(cLstBkp) to High(cLstBkp) do
      if pRes then begin
        if cLstBkp[I][3] <> '' then
          pLinha := AnsiReplaceStrA(pLinha, cLstBkp[I][2], cLstBkp[I][3])
        else
          pLinha := AnsiReplaceStrA(pLinha, cLstBkp[I][2], cLstBkp[I][1])
      end else
        pLinha := AnsiReplaceStrA(pLinha, cLstBkp[I][1], cLstBkp[I][2]);
  end;

  procedure restoreLinha(var pLinha : String);
  begin
    backupLinha(pLinha, True);
  end;

  //-- substituir

  procedure subLinha(var pLinha : String);
  const
    cLstSub : Array [1..13,1..2] of String =
     (('begin', '{'),
      (' end ', ' } '),
      ('end ', '} '),
      ('end;', '}'),
      (' or ', ' || '),
      (' and ', ' && '),
      ('except', '} catch (Exception e) {'),
      ('try', 'try {'),
      ('repeat', 'do {'),
      ('until (', 'while !('),
      ('result {pi}', 'return'),
      ('exit;', 'return;'),
      ('class ', 'static ')
     );
  var
    I : Integer;
  begin
    for I:=Low(cLstSub) to High(cLstSub) do
      pLinha := AnsiReplaceStrA(pLinha, cLstSub[I][1], cLstSub[I][2]);
  end;

  //-- metodo

  function isMetodo(pLinha : String) : Boolean;
  const
    cLstMet : Array [1..4] of String =
      ('function ',
       'procedure ',
       'public ',
       'private ');
  var
    I : Integer;
  begin
    Result := False;
    for I:=Low(cLstMet) to High(cLstMet) do
      if Pos(cLstMet[I], pLinha) > 0 then begin
        Result := True;
        Exit;
      end;
  end;

  //-- type

  function isType(pLinha : String) : Boolean;
  var
    I : Integer;
  begin
    Result := False;
    for I:=Low(cLstTyp) to High(cLstTyp) do
      if Pos(cLstTyp[I][1], pLinha) > 0 then begin
        Result := True;
        Exit;
      end;
  end;

  procedure convType(var pLinha : String);
  var
    I : Integer;
  begin
    for I:=Low(cLstTyp) to High(cLstTyp) do
      pLinha := AnsiReplaceStrA(pLinha, cLstTyp[I][1], cLstTyp[I][2]);
  end;

  //--

  function getMtd(pLinha : String) : String;
  begin
    Result := GetRightStr(pLinha, 'function ');
    if Result = '' then
      Result := GetRightStr(Result, 'procedure ');
    Result := GetLeftStr(Result, '(');
    Result := AllTrim(Result);
  end;

  function getPar(pLinha : String) : String;
  begin
    Result := GetRightStr(pLinha, '(');
    Result := GetLeftStr(Result, ')');
    Result := AllTrim(Result);
  end;

  function getRet(pLinha : String) : String;
  begin
    Result := pLinha;
    if Pos(')', Result) > 0 then
      Result := GetRightStr(Result, ')');
    if Pos(':', Result) > 0 then
      Result := GetRightStr(Result, ':');
    Result := GetLeftStr(Result, ';');
    Result := AllTrim(Result);
  end;

  function getCod(pLinha : String) : String;
  begin
    Result := GetLeftStr(pLinha, ':');
    Result := AllTrim(Result);
  end;

  function getTip(pLinha : String) : String;
  begin
    Result := GetRightStr(pLinha, ':');
    Result := AllTrim(Result);
  end;

  //--

  function getLstPar(pLinha : String) : String;
  var
    vLstPar, vPar, vCod, vTip : String;
  begin
    Result := '';

    vLstPar := getPar(pLinha);
    vLstPar := AnsiReplaceStrV(vLstPar, ';', '|');
    vLstPar := AnsiReplaceStrV(vLstPar, ', ', '{v}');
    while vLstPar <> '' do begin
      vPar := getitem(vLstPar);
      if vPar = '' then Break;
      delitem(vLstPar);

      vCod := getCod(vPar);
      vTip := getTip(vPar);

      if Pos('{v}', vPar) > 0 then
        vCod := AnsiReplaceStrV(vCod, '{v}', ', ' + vTip + ' ');

      putitemD(Result, vTip + ' ' + vCod, ', ');
    end;
  end;

  function getLstArg(pLinha : String) : String;
  var
    vLstPar, vPar, vCod, vTip : String;
  begin
    Result := '';

    vLstPar := getPar(pLinha);
    vLstPar := AnsiReplaceStrV(vLstPar, ';', '|');
    vLstPar := AnsiReplaceStrV(vLstPar, ', ', '{v}');
    while vLstPar <> '' do begin
      vPar := getitem(vLstPar);
      if vPar = '' then Break;
      delitem(vLstPar);

      vCod := getCod(vPar);
      vTip := getTip(vPar);

      putitemD(Result, vCod, ', ');
    end;
  end;

  //--

  procedure corMetodo(var pLinha : String);
  const
    cMETODO = 'public {ret} {mtd}({lstpar})';
  var
    vRet, vMtd, vLstPar : String;
  begin
    if not isMetodo(pLinha) then
      Exit;

    convType(pLinha);

    vRet := IfNull(getRet(pLinha), 'void');
    vMtd := getMtd(pLinha);
    vLstPar := getLstPar(pLinha);

    pLinha := cMETODO;
    pLinha := AnsiReplaceStrV(pLinha, '{ret}', vRet);
    pLinha := AnsiReplaceStrV(pLinha, '{mtd}', vMtd);
    pLinha := AnsiReplaceStrV(pLinha, '{lstpar}', vLstPar);
  end;

  procedure corVariavel(var pLinha : String);
  var
    vLstPar, vPar, vCod, vTip : String;
  begin
    if isMetodo(pLinha) then
      Exit;
    if not isType(pLinha) then
      Exit;

    convType(pLinha);

    vLstPar := pLinha;
    vLstPar := AnsiReplaceStrV(vLstPar, ';', '|');
    vLstPar := AnsiReplaceStrV(vLstPar, ', ', '{v}');

    pLinha := '';

    while vLstPar <> '' do begin
      vPar := getitem(vLstPar);
      if vPar = '' then Break;
      delitem(vLstPar);

      vCod := getCod(vPar);
      vTip := getTip(vPar);

      if Pos('{v}', vPar) > 0 then
        vCod := AnsiReplaceStrV(vCod, '{v}', ', ');

      putitemD(pLinha, vTip + ' ' + vCod, ' ');
    end;

    if pLinha <> '' then
      pLinha := pLinha + ';';
  end;

  //-- string

  procedure getString(var pLinha : String; var pLstStr : String);
  const
    cLstStr = '''{val}''';
  var
    vSeq : Integer;
    vCod, vStr, vVal : String;
  begin
    pLstStr := '';

    vSeq := 0;
    while (true) do begin
      vStr := RegExValue(pLinha, cLstStr);
      if vStr = '' then Break;

      Inc(vSeq);
      vCod := '{' + Format('str%d', [vSeq]) + '}';
      vVal := RegExId(pLinha, cLstStr);
      putitemX(pLstStr, vCod, vVal);

      pLinha := AnsiReplaceStrA(pLinha, vVal, vCod);
    end;
  end;

  procedure setString(var pLinha : String; pLstStr : String);
  var
    vLstCod, vCod, vVal : String;
  begin
    vLstCod := listCdX(pLstStr);
    while vLstCod <> '' do begin
      vCod := getitem(vLstCod);
      if vCod = '' then Break;
      delitem(vLstCod);

      vVal := itemX(vCod, pLstStr);
      vVal := AnsiReplaceStrV(vVal, '"', '\"');
      vVal := AnsiReplaceStrV(vVal, '''', '"');
      pLinha := AnsiReplaceStrA(pLinha, vCod, vVal);
    end;
  end;

  //-- var

  procedure getVar(var pLinha : String; var pVar : String);
  begin
    if pLinha = 'var' then begin
      pLinha := '{';
      pVar := 'var';
    end;
  end;

  procedure setVar(var pLinha : String; var pVar : String);
  begin
    if (AllTrim(pLinha) = '{') and (pVar <> '') then begin
      pLinha := '';
      pVar := '';
    end;
  end;

  //-- clear

  procedure clrLinha(var pLinha : String);
  const
    cLstClr : array [1..2] of String =
      ('var',
       ';');
  var
    I : Integer;
  begin
    for I:=Low(cLstClr) to High(cLstClr) do
      if AllTrim(pLinha) = cLstClr[I] then
        pLinha := '';
  end;

  //-- expressao

  // for {val} do
  // while {val} do
  // if {val} then
  // case {val} of
  // repeat {val} until();
  // do {val} while();

  procedure corExpressao(var pLinha : String);
  const
    cLstCpl : array [1..37,1..3] of string =
      (('for {val} do begin', '{var} = {ini} to {tot}', 'for ({var} = {ini}; {var} <= {tot}; {var}++) {'),
       ('for {val} do', '{var} = {ini} to {tot}', 'for ({var} = {ini}; {var} <= {tot}; {var}++)'),
       ('while {val} do begin', '{exp}', 'while ({exp}) {'),
       ('while {val} do', '{exp}', 'while ({exp})'),
       ('if {val} then begin', '{exp}', 'if ({exp}) {'),
       ('if {val} then', '{exp}', 'if ({exp})'),
       ('case {val} of begin', '{exp}', 'case ({exp}) of {'),
       ('case {val} of', '{exp}', 'case ({exp}) of'),

       ('Pos({val})', '{sub},{str}', '{str}.IndexOf({sub})'),
       ('on {val});', '{var}: {tip} {fun}({var}.{mtd}', '_Logger.e('''', {var}.{mtd});'),

       ('PChar({val})','{exp}','{exp}'),

       ('SetLength({val})','{exp}','_Array.setar({exp})'),
       ('Trim({val})','{exp}','{exp}.Trim()'),
       ('Length({val})','{exp}','{exp}.Length()'),
       ('LowerCase({val})','{exp}','{exp}.ToLowerCase()'),
       ('UpperCase({val})','{exp}','{exp}.ToUpperCase()'),
       ('AnsiReplaceStr({val},','{exp}','{exp}.Replace('),
       ('ReplaceStr({val},','{exp}','{exp}.Replace('),
       ('ReplicateStr({val},','{exp}','_String.Replicate({exp},'),

       ('DateTimeToStr({val})','{exp}','{exp}.ToString()'),
       ('FloatToStr({val})','{exp}','{exp}.ToString()'),
       ('IntToStr({val})','{exp}','{exp}.ToString()'),

       ('StrToDateTime({val})','{exp}','DateTime.Parse({exp})'),
       ('StrToDateTimeDef({val})','{exp}','_Funcao.IffNullD({exp})'),
       ('StrToFloat({val})','{exp}','Double.Parse({exp})'),
       ('StrToFloatDef({val})','{exp}','Double.Parse({exp})'),
       ('StrToInt({val})','{exp}','Int16.Parse({exp})'),
       ('StrToIntDef({val})','{exp}','Int16.Parse({exp})'),

       ('FormatDateTime({val})','{exp}','_DataHora.formatar({exp})'),

       ('Copy({val},','{exp}','{exp}.SubString('),

       ('CarregarArqBin({val})','{exp}','_Arquivo.carregar({exp})'),
       ('GravarArqBin({val})','{exp}','_Arquivo.gravar({exp})'),
       ('FileExists({val})','{exp}','_Arquivo.exists({exp})'),

       ('FormatFloat({val})','{exp}','_Formatar.formatFloat({exp})'),
       ('Format({val})','{exp}','_Formatar.format({exp})'),

       ('LeIni({val})','{exp}','_ArquivoIni.pegar({exp})'),
       ('GravaIni({val})','{exp}','_ArquivoIni.setar({exp})')

      );

    function getLstVal(pVal, pEnt : String) : String;
    var
      vLstCod, vCod,
      vLstXml, vTag, vVal : String;
    begin
      Result := '';

      vLstXml := '';
      while pEnt <> '' do begin
        vCod := RegExId(pEnt, '{(.*?)}');
        if vCod = '' then Break;
        Delete(pEnt, 1, Length(vCod));
        vTag := GetLeftStr(pEnt, '{');
        Delete(pEnt, 1, Length(vTag));
        putitemX(vLstXml, vCod, vTag);
      end;

      vLstCod := listCdX(vLstXml);
      while vLstCod <> '' do begin
        vCod := getitem(vLstCod);
        if vCod = '' then Break;
        delitem(vLstCod);

        vTag := itemX(vCod, vLstXml);
        if vTag <> '' then begin
          vVal := GetLeftStr(pVal, vTag);
          Delete(pVal, 1, Length(vVal));
          Delete(pVal, 1, Length(vTag));
        end else begin
          vVal := pVal;
        end;

        vVal := AllTrim(vVal);

        putitemX(Result, vCod, vVal);
      end;
    end;

    function getLstSai(pSai, pLstVal : String) : String;
    var
      vLstCod, vCod, vVal : String;
    begin
      Result := pSai;

      vLstCod := listCdX(pLstVal);
      while vLstCod <> '' do begin
        vCod := getitem(vLstCod);
        if vCod = '' then Break;
        delitem(vLstCod);

        vVal := itemX(vCod, pLstVal);
        Result := AnsiReplaceStrV(Result, vCod, vVal);
      end;
    end;

  var
    vLinha, vLstVal,
    vReg, vEnt, vSai, vPre, vVal, vAnt, vNov : String;
    I : Integer;
  begin
    for I:=Low(cLstCpl) to High(cLstCpl) do begin
      vReg := cLstCpl[I][1];
      vEnt := cLstCpl[I][2];
      vSai := cLstCpl[I][3];

      vPre := GetLeftStr(vReg, '{val}');
      pLinha := AnsiReplaceStrA(pLinha, vPre, vPre);

      if Pos(vPre, pLinha) = 0 then
        Continue;

      vLinha := pLinha;

      while (true) do begin
        vVal := RegExValue(vLinha, vReg);
        if vVal = '' then Break;

        vAnt := RegExId(vLinha, vReg);

        vLstVal := getLstVal(vVal, vEnt);
        vNov := getLstSai(vSai, vLstVal);

        vLinha := AnsiReplaceStrA(vLinha, vAnt, '');
        pLinha := AnsiReplaceStrA(pLinha, vAnt, vNov);
      end;
    end;
  end;

  //--

procedure TFrmConverter.PnlConverterClick(Sender: TObject);
var
  vLstVal, vLstStr, vVar,
  vLinha, vRecuo, vComent : String;
  I : Integer;
begin
  vLstVal := '';

  with MemoOri, MemoOri.Lines do begin
    for I:=0 to Count-1 do begin
      vLinha := Lines[I];

      // recuo
      getRecuo(vLinha, vRecuo);
      // comentario
      getComent(vLinha, vComent);
      // documentacao
      setComent(vLinha);
      // string
      getString(vLinha, vLstStr);
      // var
      getVar(vLinha, vVar);

      // backup
      backupLinha(vLinha);

      espLinha(vLinha);
      subLinha(vLinha);
      corLinha(vLinha);

      // restore
      restoreLinha(vLinha);

      // function / procedure
      corMetodo(vLinha);
      // variavel
      corVariavel(vLinha);
      // expressao
      corExpressao(vLinha);

      // string
      setString(vLinha, vLstStr);
      // var
      setVar(vLinha, vVar);

      // clear
      clrLinha(vLinha);

      putitemD(vLstVal, vRecuo + vLinha + vComent, sLineBreak);
    end;
  end;

  MemoDes.Text := vLstVal;
  mArquivo.descarregar(GetCurrentDir() + '\' + 'uECF.cs', MemoDes.Text);
end;

end.
