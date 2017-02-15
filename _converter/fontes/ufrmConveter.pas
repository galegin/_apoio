unit ufrmConveter;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, StrUtils;

type
  TFrmConverter = class(TForm)
    MemoOri: TMemo;
    PnlConverter: TPanel;
    MemoDes: TMemo;
    Splitter1: TSplitter;
    LabelPosicao: TLabel;
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
  mArquivo, mString, mControl, mXml,
  uclsConverter;

procedure TFrmConverter.FormCreate(Sender: TObject);
begin
  MemoOri.Text := TmArquivo.Ler(GetCurrentDir() + '\' + 'uECF.pas');
end;

procedure TFrmConverter.FormActivate(Sender: TObject);
begin
  //mControl.SetPosWorkDiv(Self);
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

  procedure getDoc(var pLinha : String; var pLstDoc : TmStringList);
  var
    vLstReg : TmStringList;
    vReg, vExp, vEnt, vOri, vCod, vAnt, vNov : String;
    I : Integer;
  begin
    vLstReg := TmString.Split(cDOC_DELPHI_TO_CSHARP, '/><');
    for I := 0 to vLstReg.Count - 1 do begin
      vReg := vLstReg.Items[I];

      //vExp := itemA('exp', vReg);
      //vEnt := itemA('ent', vReg);
      //vOri := itemA('ori', vReg);

      if Pos(vExp, pLinha) = 0 then
        Continue;

      vCod := Format('#doc%d', [I+1]);

      if vOri = 'right' then begin
        vAnt := vExp + TmString.RightStr(pLinha, vEnt);
        vNov := vEnt + TmString.RightStr(pLinha, vEnt);
      end else begin
        vAnt := TmString.LeftStr(pLinha, vEnt) + vExp;
        vNov := TmString.LeftStr(pLinha, vEnt) + vEnt;
      end;

      pLinha := AnsiReplaceStr(pLinha, vAnt, vCod);
      pLstDoc.Add(vCod + '=' + vNov);
    end;
  end;

  procedure setDoc(var pLinha : String; pLstDoc : TmStringList);
  var
    vDoc, vCod, vVal : String;
    I : Integer;
  begin
    for I := 0 to pLstDoc.Count - 1 do begin
      vDoc := pLstDoc.Items[I];
      vCod := TmString.LeftStr(vDoc, '=');
      vVal := TmString.RightStr(vDoc, '=');
      pLinha := AnsiReplaceStr(pLinha, vCod, vVal);
    end;
  end;

  //-- espacamento

  procedure espLinha(var pLinha : String);
  var
    vLstReg : TmStringList;
    vReg, vRecuo, vExp, vEnt, vSai : String;
    I : Integer;
  begin
    getRecuo(pLinha, vRecuo);

    vLstReg := TmString.Split(cESP_DELPHI_TO_CSHARP, '/><');
    for I := 0 to vLstReg.Count - 1 do begin
      vReg := vLstReg.Items[I];

      //vExp := itemA('exp', vReg);
      //vEnt := itemA('ent', vReg);
      //vSai := itemA('sai', vReg);

      pLinha := AnsiReplaceStr(pLinha, vExp, vEnt);
      pLinha := TmString.AllTrim(pLinha);
      if vSai <> '' then
        pLinha := AnsiReplaceStr(pLinha, vSai, vExp);
    end;

    pLinha := vRecuo + pLinha;
  end;

  //-- backup / restore

  procedure backupLinha(var pLinha : String; pRes : Boolean = False);
  var
    vLstReg : TmStringList;
    vReg, vExp, vEnt, vSai : String;
    I : Integer;
  begin
    vLstReg := TmString.Split(cBKP_DELPHI_TO_CSHARP, '/><');
    for I := 0 to vLstReg.Count - 1 do begin
      vReg := vLstReg.Items[I];

      //vExp := XMLToString(itemA('exp', vReg));
      //vEnt := XMLToString(itemA('ent', vReg));
      //vSai := XMLToString(itemA('sai', vReg));

      if pRes then begin
        if vSai <> '' then
          pLinha := AnsiReplaceStr(pLinha, vEnt, vSai)
        else
          pLinha := AnsiReplaceStr(pLinha, vEnt, vExp)
      end else
        pLinha := AnsiReplaceStr(pLinha, vExp, vEnt);
    end;
  end;

  procedure restoreLinha(var pLinha : String);
  begin
    backupLinha(pLinha, True);
  end;

  //-- substituir

  procedure subLinha(var pLinha : String);
  var
    vLstReg : TmStringList;
    vReg, vExp, vEnt : String;
    I : Integer;
  begin
    vLstReg := TmString.Split(cSUB_DELPHI_TO_CSHARP, '/><');
    for I := 0 to vLstReg.Count - 1 do begin
      vReg := vLstReg.Items[I];

      //vExp := itemA('exp', vReg);
      //vEnt := itemA('ent', vReg);

      pLinha := AnsiReplaceStr(pLinha, vExp, vEnt);
    end;
  end;

  //-- type

  function isType(pLinha : String) : Boolean;
  var
    vLstCod : TmStringList;
    vCod : String;
    I : Integer;
  begin
    Result := False;

    vLstCod := TmString.Split(cTYP_DELPHI_TO_CSHARP, '/><');
    for I := 0 to vLstCod.Count - 1 do begin
      vCod := vLstCod.Items[I];

      if Pos(': ' + vCod, LowerCase(pLinha)) > 0 then begin
        Result := True;
        Exit;
      end;
    end;
  end;

  procedure convType(var pLinha : String);
  var
    vLstCod : TmStringList;
    vCod, vXml, vEnt : String;
    I : Integer;
  begin
    vLstCod := TmString.Split(cTYP_DELPHI_TO_CSHARP, '/><');
    for I := 0 to vLstCod.Count - 1 do begin
      vCod := vLstCod.Items[I];

      //vXml := itemX(vCod, cTYP_DELPHI_TO_CSHARP);
      //vEnt := itemA('ent', vXml);

      pLinha := AnsiReplaceStr(pLinha, vCod, vEnt);
    end;
  end;

  function getTip(pLinha : String) : String;
  begin
    Result := TmString.RightStr(pLinha, ':');
    Result := TmString.AllTrim(Result);
  end;

  //-- parametro

  function getPar(pLinha : String) : String;
  begin
    Result := TmString.RightStr(pLinha, '(');
    Result := TmString.LeftStr(Result, ')');
    Result := TmString.AllTrim(Result);
  end;

  //-- retorno

  function getRet(pLinha : String) : String;
  begin
    Result := pLinha;
    if Pos(')', Result) > 0 then
      Result := TmString.RightStr(Result, ')');
    if Pos(':', Result) > 0 then
      Result := TmString.RightStr(Result, ':');
    Result := TmString.LeftStr(Result, ';');
    Result := TmString.AllTrim(Result);
  end;

  //-- codigo

  function getCod(pLinha : String) : String;
  begin
    Result := TmString.LeftStr(pLinha, ':');
    Result := TmString.AllTrim(Result);
  end;

  //-- parametro

  function getLstPar(pLinha : String) : String;
  var
    vLstPar : TmStringList;
    vLinha, vPar, vCod, vTip : String;
    I : Integer;
  begin
    Result := '';

    vLinha := getPar(pLinha);
    vLinha := AnsiReplaceStr(vLinha, ';', '|');
    vLinha := AnsiReplaceStr(vLinha, ', ', '{v}');

    vLstPar := TmString.Split(vLinha, '|');
    for I := 0 to vLstPar.Count - 1 do begin
      vCod := getCod(vPar);
      vTip := getTip(vPar);

      if Pos('{v}', vPar) > 0 then
        vCod := AnsiReplaceStr(vCod, '{v}', ', ' + vTip + ' ');

      Result := Result + vTip + ' ' + vCod + ', ';
    end;
  end;

  //-- metodo

  function isMetodo(pLinha : String) : Boolean;
  var
    vLstCod : TmStringList;
    vCod : String;
    I : Integer;
  begin
    Result := False;

    vLstCod := TmString.Split(cMET_DELPHI_TO_CSHARP, '/><');
    for I := 0 to vLstCod.Count - 1 do begin
      vCod := vLstCod.Items[I];

      if Pos(vCod, LowerCase(pLinha)) > 0 then begin
        Result := True;
        Exit;
      end;
    end;
  end;

  function getMtd(pLinha : String) : String;
  begin
    Result := TmString.RightStr(pLinha, 'function ');
    if Result = '' then
      Result := TmString.RightStr(Result, 'procedure ');
    Result := TmString.LeftStr(Result, '(');
    Result := TmString.AllTrim(Result);
  end;

  procedure corMetodo(var pLinha : String; pSai : String);
  var
    vRet, vMtd, vLstPar : String;
  begin
    convType(pLinha);

    vRet := getRet(pLinha);
    vMtd := getMtd(pLinha);
    vLstPar := getLstPar(pLinha);

    pLinha := pSai;
    pLinha := AnsiReplaceStr(pLinha, '{ret}', vRet);
    pLinha := AnsiReplaceStr(pLinha, '{mtd}', vMtd);
    pLinha := AnsiReplaceStr(pLinha, '{lstpar}', vLstPar);
  end;

  //-- string

  procedure getStr(var pLinha : String; var pLstStr : String);
  const
    cLstStr = '''{val}''';
  var
    vSeq : Integer;
    vCod, vStr, vVal : String;
  begin
    pLstStr := '';

    (* vSeq := 0;
    while (true) do begin
      vStr := RegExValue(pLinha, cLstStr);
      if vStr = '' then Break;

      Inc(vSeq);
      vCod := Format('#str%d', [vSeq]);
      vVal := RegExId(pLinha, cLstStr);
      putitemX(pLstStr, vCod, vVal);

      pLinha := AnsiReplaceStr(pLinha, vVal, vCod);
    end; *)
  end;

  procedure setStr(var pLinha : String; pLstStr : String);
  var
    vLstCod : TmStringList;
    vCod, vVal : String;
    I : Integer;
  begin
    vLstCod := TmString.Split(pLstStr, '|');
    for I := 0 to vLstCod.Count - 1 do begin
      vCod := vLstCod.Items[I];

      //vVal := itemX(vCod, pLstStr);
      //vVal := AnsiReplaceStr(vVal, '"', '\"');
      //vVal := AnsiReplaceStr(vVal, '''', '"');
      //pLinha := AnsiReplaceStr(pLinha, vCod, vVal);
    end;
  end;

  //-- variavel

  procedure corVariavel(var pLinha : String);
  var
    vLstPar, vPar, vRecuo, vCod, vTip : String;
  begin
    getRecuo(pLinha, vRecuo);

    convType(pLinha);

    vLstPar := pLinha;
    vLstPar := AnsiReplaceStr(vLstPar, ';', '|');
    vLstPar := AnsiReplaceStr(vLstPar, ', ', '{v}');

    pLinha := '';

    while vLstPar <> '' do begin
      vPar := getitem(vLstPar);
      if vPar = '' then Break;
      delitem(vLstPar);

      vCod := getCod(vPar);
      vTip := getTip(vPar);

      if Pos('{v}', vPar) > 0 then
        vCod := AnsiReplaceStr(vCod, '{v}', ', ');

      putitemD(pLinha, vTip + ' ' + vCod, ' ');
    end;

    if pLinha <> '' then
      pLinha := pLinha + ';';

    pLinha := vRecuo + pLinha;
  end;

  procedure getVar(var pLinha : String; var pVar : String);
  begin
    if pLinha = 'var' then begin
      pLinha := '{ #var';
      pVar := 'var';
    end;
  end;

  procedure setVar(var pLinha : String; var pVar : String);
  begin
    if (TmString.AllTrim(pLinha) = '{') and (pVar <> '') then begin
      pLinha := '';
      pVar := '';
    end;
  end;

  //-- clear

  procedure clrLinha(var pLinha : String);
  const
    cLstClr : array [1..2] of String =
      ('var',';');
  var
    I : Integer;
  begin
    for I:=Low(cLstClr) to High(cLstClr) do
      if TmString.AllTrim(pLinha) = cLstClr[I] then
        pLinha := '';
  end;

  //-- expressao

  procedure corExpressao(var pLinha : String);

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
        vTag := TmString.LeftStr(pEnt, '{');
        Delete(pEnt, 1, Length(vTag));
        putitemX(vLstXml, vCod, vTag);
      end;

      vLstCod := TmString.Split(vLstXml);
      for I := 0 to vLstCod.Count - 1 do begin
        vCod := vLstCod.Items[I];
        if vCod = '' then Break;
        delitem(vLstCod);

        vTag := itemX(vCod, vLstXml);
        if vTag <> '' then begin
          vVal := TmString.LeftStr(pVal, vTag);
          Delete(pVal, 1, Length(vVal));
          Delete(pVal, 1, Length(vTag));
        end else begin
          vVal := pVal;
        end;

        vVal := TmString.AllTrim(vVal);

        putitemX(Result, vCod, vVal);
      end;
    end;

    function getLstSai(pSai, pLstVal : String) : String;
    var
      vLstCod, vCod, vVal : String;
    begin
      Result := pSai;

      vLstCod := TmString.Split(pLstVal);
      for I := 0 to vLstCod.Count - 1 do begin
        vCod := vLstCod.Items[I];
        if vCod = '' then Break;
        delitem(vLstCod);

        vVal := itemX(vCod, pLstVal);
        Result := AnsiReplaceStr(Result, vCod, vVal);
      end;
    end;

  var
    vLstReg, vReg,
    vLinha, vLstVal,
    vTyp, vExp, vEnt, vSai,
    vPre, vSuf, vVal, vAnt, vNov : String;
  begin
    vLstReg := cLST_DELPHI_TO_CSHARP;
    while vLstReg <> '' do begin
      vReg := getitemX('reg', vLstReg);
      if vReg = '' then Break;
      delitemX('reg', vLstReg);

      vTyp := itemA('typ', vReg);
      vExp := itemA('exp', vReg);
      vEnt := itemA('ent', vReg);
      vSai := itemA('sai', vReg);

      if vTyp = 'type' then begin
        if isType(pLinha) then begin
          corVariavel(pLinha);
          exit;
        end;
      end;

      vPre := TmString.LeftStr(vExp, '{val}');
      pLinha := AnsiReplaceStr(pLinha, vPre, vPre);
      vSuf := TmString.RightStr(vExp, '{val}');
      pLinha := AnsiReplaceStr(pLinha, vSuf, vSuf);

      if Pos(vPre, pLinha) = 0 then
        Continue;

      if vTyp = 'meth' then begin
        if isMetodo(pLinha) then begin
          corMetodo(pLinha, vSai);
          exit;
        end;
      end;

      vLinha := pLinha;

      while (true) do begin
        vVal := RegExValue(vLinha, vExp);
        if vVal = '' then Break;

        vAnt := RegExId(vLinha, vExp);

        vLstVal := getLstVal(vVal, vEnt);
        vNov := getLstSai(vSai, vLstVal);

        vLinha := AnsiReplaceStr(vLinha, vAnt, '');
        pLinha := AnsiReplaceStr(pLinha, vAnt, vNov);
      end;
    end;
  end;

  //--

procedure TFrmConverter.PnlConverterClick(Sender: TObject);
var
  vLstVal, vLstStr, vLstDoc, vLstVar, vLinha : String;
  I : Integer;
begin
  vLstVal := '';

  with MemoOri, MemoOri.Lines do begin
    for I:=0 to Count-1 do begin
      vLinha := Lines[I];

      LabelPosicao.Caption := Format('Linha %d de %d', [I+1, Count]);
      if (I mod 100) = 0 then
        Application.ProcessMessages;

      // documentacao
      getDoc(vLinha, vLstDoc);
      // string
      getStr(vLinha, vLstStr);
      // var
      getVar(vLinha, vLstVar);

      // backup
      backupLinha(vLinha);
      // espacamento
      espLinha(vLinha);
      // substituit
      subLinha(vLinha);

      // restore
      restoreLinha(vLinha);

      // expressao
      corExpressao(vLinha);

      // documentacao
      setDoc(vLinha, vLstDoc);
      // string
      setStr(vLinha, vLstStr);
      // var
      setVar(vLinha, vLstVar);

      // clear
      clrLinha(vLinha);

      putitemD(vLstVal, vLinha, sLineBreak);
    end;
  end;

  vLstVal := AnsiReplaceStr(vLstVal, '#var', '');

  MemoDes.Text := vLstVal;
  TmArquivo.Gravar(GetCurrentDir() + '\' + 'uECF.cs', MemoDes.Text);
end;

end.
