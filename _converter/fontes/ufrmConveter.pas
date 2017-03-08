unit ufrmConveter;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, StrUtils, mString,
  uclsConverter, uclsTipoParte;

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
    procedure ExecAlteracao(
      ATipoAlteracao : RTipoAlteracao; var ALinha : String);
  public
  end;

var
  FrmConverter: TFrmConverter;

implementation

{$R *.dfm}

uses
  mArquivo, mControl, mRegXml, mXml;

procedure TFrmConverter.FormCreate(Sender: TObject);
begin
  MemoOri.Text := TmArquivo.Ler(GetCurrentDir() + '\' + 'ufonte.unf');
  MemoOri.Text := AnsiReplaceStr(MemoOri.Text, #9, '    ');
end;

procedure TFrmConverter.FormActivate(Sender: TObject);
begin
  //mControl.SetPosWorkDiv(Self);
end;

//--

function GetRecuoLinha(ALinha : String) : String;
var
  I : Integer;
begin
  Result := '';
  for I := 1 to Length(ALinha) do
    if ALinha[I] = ' ' then
      Result := Result + ALinha[I]
    else
      Exit;  
end;

procedure TFrmConverter.ExecAlteracao;
var
  vLstParte : LTipoParte;
  vLinha, vExp, vVal, vStr : String;
  I : Integer;
begin
  if ATipoAlteracao.Typ in [taIgnorar] then
    Exit;

  if ATipoAlteracao.Typ in [taAlterar] then begin
    ALinha := AnsiReplaceStr(ALinha, ATipoAlteracao.Ent, ATipoAlteracao.Sai);
    Exit;
  end;

  // function {val};
  // procedure {val};
  vExp := mRegXml.Instance.Exec(tpvId, ALinha, ATipoAlteracao.Exp);
  if vExp = '' then
    Exit;

  //{mtd}({lstpar}) : {ret}
  //{mtd}({lstpar})
  vVal := mRegXml.Instance.Exec(tpvValue, ALinha, ATipoAlteracao.Exp);
  if vVal = '' then
    Exit;

  vLinha := ATipoAlteracao.Sai;
  vLstParte := GetLstTipoParte(ATipoAlteracao.Ent);

  for I := Low(vLstParte) to High(vLstParte) do begin
    with vLstParte[I] do begin
      vStr := ALinha;

      if (Ini = '') and (Fin = '') then begin
        vLinha := AnsiReplaceStr(vLinha, Cod, vVal);

      end else begin
        if Ini <> '' then
          Delete(vStr, 1, Pos(Ini, vStr) + Length(Ini) - 1);
        if Fin <> '' then
          Delete(vStr, Pos(Fin, vStr), Length(vStr));

        vLinha := AnsiReplaceStr(vLinha, Cod, vStr);
      end;
    end;
  end;

  ALinha := vLinha;
end;

procedure TFrmConverter.PnlConverterClick(Sender: TObject);
var
  vLstLinha, vLinha, vRecuo, vExp : String;
  vBackup : TStringList;
  I, J : Integer;
begin
  vLstLinha := '';
  vBackup := TStringList.Create;

  with MemoOri, MemoOri.Lines do begin
    for I:=0 to Count-1 do begin
      vLinha := TmString.AllTrim(Lines[I]);
      vRecuo := GetRecuoLinha(Lines[I]);

      LabelPosicao.Caption := Format('Linha %d de %d', [I+1, Count]);
      if (I mod 100) = 0 then
        Application.ProcessMessages;

      BackupLinha(vLinha, vBackup);

      for J := Low(LTipoAlteracao) to High(LTipoAlteracao) do
        with LTipoAlteracao[J] do begin
          vExp := TmString.LeftStr(Exp, '{val}');
          if Pos(vExp, vLinha) > 0 then begin
            ExecAlteracao(LTipoAlteracao[J], vLinha);
            if Typ in [taRepeticao, taCondicao] then
              Break;
          end;
        end;

      RestoreLinha(vLinha, vBackup);

      vLstLinha := vLstLinha + IfThen(vLstLinha <> '', sLineBreak) +
        vRecuo + vLinha;
    end;
  end;

  MemoDes.Text := vLstLinha;
  TmArquivo.Gravar(GetCurrentDir() + '\' + 'ufonte.pas', MemoDes.Text);
end;

end.
