unit ufrmConveter;

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
  mArquivo, mString, mControl, mFuncao, mItem, mXml, uclsConverter;

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
  var
    vLstReg, vReg, vExp, vEnt : String;
  begin
    vLstReg := cDOC_DELPHI_TO_CSHARP;
    while vLstReg <> '' do begin
      vReg := getitemX('reg', vLstReg);
      if vReg = '' then Break;
      delitemX('reg', vLstReg);

      vExp := itemA('exp', vReg);
      vEnt := itemA('ent', vReg);

      pLinha := AnsiReplaceStrA(pLinha, vExp, vEnt);
    end;
  end;

  //-- espacamento

  procedure espLinha(var pLinha : String);
  var
    vLstReg, vReg, vExp, vEnt, vSai : String;
  begin
    vLstReg := cESP_DELPHI_TO_CSHARP;
    while vLstReg <> '' do begin
      vReg := getitemX('reg', vLstReg);
      if vReg = '' then Break;
      delitemX('reg', vLstReg);

      vExp := itemA('exp', vReg);
      vEnt := itemA('ent', vReg);
      vSai := itemA('sai', vReg);

      pLinha := AnsiReplaceStrA(pLinha, vExp, vEnt);
      pLinha := AllTrim(pLinha);
      if vSai <> '' then
        pLinha := AnsiReplaceStrA(pLinha, vSai, vExp);
    end;
  end;

  //-- backup / restore

  procedure backupLinha(var pLinha : String; pRes : Boolean = False);
  var
    vLstReg, vReg, vExp, vEnt, vSai : String;
  begin
    vLstReg := cBKP_DELPHI_TO_CSHARP;
    while vLstReg <> '' do begin
      vReg := getitemX('reg', vLstReg);
      if vReg = '' then Break;
      delitemX('reg', vLstReg);

      vExp := XMLToString(itemA('exp', vReg));
      vEnt := XMLToString(itemA('ent', vReg));
      vSai := XMLToString(itemA('sai', vReg));

      if pRes then begin
        if vSai <> '' then
          pLinha := AnsiReplaceStrA(pLinha, vEnt, vSai)
        else
          pLinha := AnsiReplaceStrA(pLinha, vEnt, vExp)
      end else
        pLinha := AnsiReplaceStrA(pLinha, vExp, vEnt);
    end;
  end;

  procedure restoreLinha(var pLinha : String);
  begin
    backupLinha(pLinha, True);
  end;

  //-- substituir

  procedure subLinha(var pLinha : String);
  var
    vLstReg, vReg, vExp, vEnt : String;
  begin
    vLstReg := cSUB_DELPHI_TO_CSHARP;
    while vLstReg <> '' do begin
      vReg := getitemX('reg', vLstReg);
      if vReg = '' then Break;
      delitemX('reg', vLstReg);

      vExp := itemA('exp', vReg);
      vEnt := itemA('ent', vReg);

      pLinha := AnsiReplaceStrA(pLinha, vExp, vEnt);
    end;
  end;

  //-- type

  function isType(pLinha : String) : Boolean;
  var
    vLstCod, vCod : String;
  begin
    Result := False;
    vLstCod := listCdX(cTYP_DELPHI_TO_CSHARP);
    while vLstCod <> '' do begin
      vCod := getitem(vLstCod);
      if vCod = '' then Break;
      delitem(vLstCod);

      if Pos(vCod, LowerCase(pLinha)) > 0 then begin
        Result := True;
        Exit;
      end;
    end;
  end;

  procedure convType(var pLinha : String);
  var
    vLstCod, vCod, vXml, vEnt : String;
  begin
    vLstCod := listCdX(cTYP_DELPHI_TO_CSHARP);
    while vLstCod <> '' do begin
      vCod := getitem(vLstCod);
      if vCod = '' then Break;
      delitem(vLstCod);

      vXml := itemX(vCod, cTYP_DELPHI_TO_CSHARP);
      vEnt := itemA('ent', vXml);

      pLinha := AnsiReplaceStrA(pLinha, vCod, vEnt);
    end;
  end;

  function getTip(pLinha : String) : String;
  begin
    Result := GetRightStr(pLinha, ':');
    Result := AllTrim(Result);
  end;

  //-- parametro

  function getPar(pLinha : String) : String;
  begin
    Result := GetRightStr(pLinha, '(');
    Result := GetLeftStr(Result, ')');
    Result := AllTrim(Result);
  end;

  //-- retorno

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

  //-- codigo

  function getCod(pLinha : String) : String;
  begin
    Result := GetLeftStr(pLinha, ':');
    Result := AllTrim(Result);
  end;

  //-- parametro

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

  //-- metodo

  function isMetodo(pLinha : String) : Boolean;
  var
    vLstCod, vCod : String;
  begin
    Result := False;
    vLstCod := listCdX(cMET_DELPHI_TO_CSHARP);
    while vLstCod <> '' do begin
      vCod := getitem(vLstCod);
      if vCod = '' then Break;
      delitem(vLstCod);

      if Pos(vCod, LowerCase(pLinha)) > 0 then begin
        Result := True;
        Exit;
      end;
    end;
  end;

  function getMtd(pLinha : String) : String;
  begin
    Result := GetRightStr(pLinha, 'function ');
    if Result = '' then
      Result := GetRightStr(Result, 'procedure ');
    Result := GetLeftStr(Result, '(');
    Result := AllTrim(Result);
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
    pLinha := AnsiReplaceStrV(pLinha, '{ret}', vRet);
    pLinha := AnsiReplaceStrV(pLinha, '{mtd}', vMtd);
    pLinha := AnsiReplaceStrV(pLinha, '{lstpar}', vLstPar);
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

  //-- variavel

  procedure corVariavel(var pLinha : String);
  var
    vLstPar, vPar, vCod, vTip : String;
  begin
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
      ('var',';');
  var
    I : Integer;
  begin
    for I:=Low(cLstClr) to High(cLstClr) do
      if AllTrim(pLinha) = cLstClr[I] then
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

      vPre := GetLeftStr(vExp, '{val}');
      pLinha := AnsiReplaceStrA(pLinha, vPre, vPre);
      vSuf := GetRightStr(vExp, '{val}');
      pLinha := AnsiReplaceStrA(pLinha, vSuf, vSuf);

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

      LabelPosicao.Caption := Format('Linha %d de %d', [I+1, Count]);
      if (I mod 100) = 0 then
        Application.ProcessMessages;

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
      // espacamento
      espLinha(vLinha);
      // substituit
      subLinha(vLinha);

      // restore
      restoreLinha(vLinha);

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
