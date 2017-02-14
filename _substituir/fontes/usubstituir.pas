unit usubstituir;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, StrUtils, Grids, DBGrids, ExtCtrls, CheckLst,
  mCombo, ComCtrls, mEdit, Buttons, mCheckListBox, mCheckBox, mButton,
  mSpeedButton, mLabel, mPanel;

type
  TF_Substituir = class(TForm)
    _PanelFiltro: TmPanel;
    LabelDir: TmLabel;
    EditDir: TmEdit;
    LabelExt: TmLabel;
    EditExt: TmEdit;
    LabelFil: TmLabel;
    EditFil: TmEdit;
    LabelAnt: TmLabel;
    EditAnt: TmEdit;
    LabelNov: TmLabel;
    EditNov: TmEdit;
    BtnLimpar: TmButton;
    BtnConsultar: TmButton;
    BtnSelecionar: TmButton;
    BtnSubstituir: TmButton;
    BtnRemover: TmButton;
    CheckedAgr: TmCheckBox;
    cdArquivo: TmCheckListBox;
    _StatusBar: TStatusBar;
    dsPasta: TmCheckListBox;
    mLabel1: TmLabel;
    mLabel2: TmLabel;
    EditPasta: TmEdit;

    procedure FormCreate(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure FormResize(Sender: TObject);

    procedure CheckedAgrClick(Sender: TObject);
    procedure BtnPadraoClick(Sender: TObject);

    procedure cdArquivoDblClick(Sender: TObject);

    procedure BtnLimparClick(Sender: TObject);
    procedure BtnConsultarClick(Sender: TObject);
    procedure BtnSubstituirClick(Sender: TObject);
    procedure BtnSelecionarClick(Sender: TObject);
    procedure BtnRemoverClick(Sender: TObject);
    procedure LabelExtClick(Sender: TObject);
    procedure EditDirExit(Sender: TObject);
    procedure dsPastaDblClick(Sender: TObject);
  private
    MyStringList : TStringList;
  protected
    procedure Mensagem(Msg : String);
    procedure MensagemBar(Msg : String);
  public
  end;

var
  F_Substituir : TF_Substituir;

implementation

{$R *.dfm}

uses
  mDiretorio, mArquivo, 
  mMensagem, mParamIni, mStatus, mFuncao, mItem, mXml;

const
  cLST_EXT = '.DPR|.DFM|.INI|.PAS|';

  //--
  function GetLinha(S : String) : Integer;
  begin
    Result := 0;
    if (Pos('(', S) > 0) and (Pos(')', S) > 0) then begin
      Delete(S, 1, Pos('(', S));
      Delete(S, Pos(')', S), Length(S));
      Result := StrToIntDef(S, 0);
    end;
  end;

  //--

  procedure TF_Substituir.Mensagem(Msg : String);
  begin
    ShowMessage(Msg);
  end;

  procedure TF_Substituir.MensagemBar(Msg : String);
  begin
    _StatusBar.Panels[0].Text := Msg;
    Application.ProcessMessages;
  end;

//--

procedure TF_Substituir.FormCreate(Sender: TObject);
begin
  MyStringList := TStringList.Create();

  Top := TmParamIni.PegarI('TOP');
  Left := TmParamIni.PegarI('LEFT');
  if (TmParamIni.PegarI('HEIGHT') > 0) then Height := TmParamIni.PegarI('HEIGHT');
  if (TmParamIni.PegarI('WIDTH') > 0) then Width := TmParamIni.PegarI('WIDTH');

  EditDir.Text := IfNull(TmParamIni.Pegar('DS_DIR'), EditDir.Text);
  EditExt.Text := IfNull(TmParamIni.Pegar('DS_EXT'), cLST_EXT);
  EditFil.Text := TmParamIni.Pegar('DS_FIL');
  EditNov.Text := TmParamIni.Pegar('DS_NOV');
  EditAnt.Text := TmParamIni.Pegar('DS_ANT');
  CheckedAgr.Checked := TmParamIni.PegarB('IN_AGR');
  dsPasta._ListaCheck := TmParamIni.Pegar('LST_SEL');

  EditDirExit(nil);
end;

procedure TF_Substituir.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if (Key = VK_ESCAPE) then Close
  else if (Key = VK_F2) then BtnLimpar.Click
  else if (Key = VK_F4) then BtnConsultar.Click;
end;

procedure TF_Substituir.FormKeyPress(Sender: TObject; var Key: Char);
begin
  if (Key = #13) then begin
    if not (ActiveControl is TDBGrid) then begin
      Key := #0; Perform(WM_NEXTDLGCTL, 0, 0);
    end else if (ActiveControl is TDBGrid) then begin
      with TDBGrid(ActiveControl) do begin
        if (SelectedIndex < (FieldCount-1)) then SelectedIndex := SelectedIndex + 1
        else SelectedIndex := 0;
      end;
    end;
  end;
end;

procedure TF_Substituir.FormResize(Sender: TObject);
begin
  TmParamIni.Setar('TOP', Top);
  TmParamIni.Setar('LEFT', Left);
  TmParamIni.Setar('HEIGHT', Height);
  TmParamIni.Setar('WIDTH', Width);
end;

//--

procedure TF_Substituir.LabelExtClick(Sender: TObject);
begin
  EditExt.Text := cLST_EXT;
end;

procedure TF_Substituir.EditDirExit(Sender: TObject);
var
  vLstArq, vArq, vPar, vRes : String;
begin
  dsPasta.Limpar();

  vPar := '';
  putitemX(vPar, 'DIR_ORIGEM', EditDir.Text);
  putitemX(vPar, 'DS_FILTRO', EditPasta.Text);
  putitemX(vPar, 'IN_ARQUIVO', False);
  putitemX(vPar, 'IN_DIRETORIO', True);
  vRes := TmArquivo.listar(vPar);
  vLstArq := itemX('LST_ARQUIVO', vRes);
  while vLstArq <> '' do begin
    vArq := getitem(vLstArq);
    if vArq = '' then Break;
    delitem(vLstArq);

    if Pos('ACBR', UpperCase(vArq)) > 0 then
      Continue;

    dsPasta.Adicionar(EditDir.Text + vArq + '\', vArq);
  end;
end;

//--

procedure TF_Substituir.CheckedAgrClick(Sender: TObject);
begin
  btnRemover.Enabled := not (CheckedAgr.Checked);
end;

procedure TF_Substituir.BtnPadraoClick(Sender: TObject);
begin
  EditExt.Text := cLST_EXT;
end;

//--
procedure TF_Substituir.cdArquivoDblClick(Sender: TObject);
const
  cNOTEPAD =
    'C:\Program Files (x86)\Notepad++\notepad++.exe|' +
    'C:\Program Files\Notepad++\notepad++.exe|' +
    'C:\Windows\notepad.exe' ;
var
  vLstPrg, vPrg : String;
begin
  with cdArquivo do begin
    if (_Value = '') then
      Exit;

    vLstPrg := cNOTEPAD;
    while (vLstPrg <> '') do begin
      vPrg := getitem(vLstPrg);
      if vPrg = '' then Break;
      delitem(vLstPrg);

      if FileExists(vPrg) then begin
        WinExec(PChar('"' + vPrg + '" ' + _Value), 1);
        Break;
      end;
    end;
  end;
end;

//--

procedure TF_Substituir.BtnLimparClick(Sender: TObject);
begin
 cdArquivo.Limpar;
end;

procedure TF_Substituir.BtnConsultarClick(Sender: TObject);
var
  vParams, vResult,
  vLstDir, vDir,
  vLstArq, vArq, vLin : String;
  vArrayString : TArrayString;
  I : Integer;
begin
  if (EditDir.Text = '') then
    raise Exception.Create('Caminho deve ser informado');
  if (EditAnt.Text = '') then
    raise Exception.Create('Expressão DE deve ser informada!');

  TmParamIni.Setar('DS_DIR', EditDir.Text);
  TmParamIni.Setar('DS_EXT', EditExt.Text);
  TmParamIni.Setar('DS_FIL', EditFil.Text);
  TmParamIni.Setar('DS_ANT', EditAnt.Text);
  TmParamIni.Setar('DS_NOV', EditNov.Text);
  TmParamIni.Setar('IN_AGR', CheckedAgr.Checked);
  TmParamIni.Setar('LST_SEL', dsPasta._ListaCheck);

  cdArquivo.Limpar();

  EditDir.Text := AllTrim(EditDir.Text, '\');
  EditDir.Text := PathWithDelim(EditDir.Text);

  vLstDir := listcd(dsPasta._ListaCheck);
  while vLstDir <> '' do begin
    vDir := getitem(vLstDir);
    if vDir = '' then Break;
    delitem(vLstDir);

    vParams := '';
    putitemX(vParams, 'DIR_ORIGEM', {EditDir.Text} vDir);
    putitemX(vParams, 'EXT_ARQUIVO', EditExt.Text);
    putitemX(vParams, 'IN_SUBPASTA', True);
    vResult := TmArquivo.listar(vParams);
    vLstArq := itemX('LST_ARQUIVODIR', vResult);
    if vLstArq = '' then
      Continue;

    vLstArq := AnsiReplaceStrV(vLstArq, sLineBreak, ';');
    vLstArq := AnsiReplaceStrV(vLstArq, '{br}', ';');

    vArrayString := GetArrayString(EditFil.Text);

    while vLstArq <> '' do begin
      vArq := getitem(vLstArq);
      if vArq = '' then Break;
      delitem(vLstArq);

      MensagemBar('Verificando... ' + vArq);

      MyStringList.LoadFromFile(vArq);
      for I := 0 to MyStringList.Count - 1 do begin
        if ContemAnd(vArrayString, MyStringList[I]) then begin
          vLin := ExtractFileName(vArq) + ' (' + IntToStr(I) + ') ' + MyStringList[I];
          cdArquivo.Adicionar(vArq, vLin);
          if (CheckedAgr.Checked) then
            Break;
        end;
      end;
    end;
  end;

  MensagemBar('Identificacao efetuada com sucesso!');
end;

procedure TF_Substituir.BtnSelecionarClick(Sender: TObject);
var
  I : Integer;
begin
  with cdArquivo do
    for I:=0 to Count-1 do
      Checked[I] := not Checked[I];
end;

procedure TF_Substituir.BtnSubstituirClick(Sender: TObject);
var
  vArrayString : TArrayString;
  I : Integer;

  procedure Substituir(pArquivo : String);
  var
    I : Integer;
  begin
    if not FileExists(pArquivo) then
      Exit;

    MyStringList.LoadFromFile(pArquivo);

    for I := 0 to MyStringList.Count - 1 do
      if ContemAnd(vArrayString, MyStringList[I]) then
        MyStringList[I] := AnsiReplaceStrV(MyStringList[I], EditAnt.Text, EditNov.Text);

    MyStringList.SaveToFile(pArquivo);
  end;

begin
  if EditNov.Text = '' then
    raise Exception.create('Expressão PARA deve ser informada!');
  if cdArquivo._ListaCheck = '' then
    raise Exception.create('Nenhum arquivo selecionado!');

  if TmMensagem.pergunta('Substituir?', [mbNo, mbYes]) = ID_NO then
    Exit;

  vArrayString := GetArrayString(EditFil.Text);

  with cdArquivo do
    for I:=0 to Items.Count-1 do
      if (Checked[I]) then
        Substituir(Values[I]);

  MensagemBar('Substituicao efetuada com sucesso!');
end;

procedure TF_Substituir.BtnRemoverClick(Sender: TObject);
var
  I, L : Integer;
  S : String;

  procedure Remover(pArquivo : String; pLinha : Integer);
  begin
    if (pLinha <= 0) then
      Exit;

    if not FileExists(pArquivo) then
      Exit;

    MyStringList.LoadFromFile(pArquivo);
    MyStringList.Delete(pLinha);
    MyStringList.SaveToFile(pArquivo);
  end;

begin
  if (cdArquivo._ListaCheck = '') then
    raise Exception.create('Nenhum arquivo selecionado!');

  if TmMensagem.pergunta('Remover?', [mbNo, mbYes]) = ID_NO then
    Exit;

  with cdArquivo do
    for I:=Items.Count-1 downto 0 do
      if (Checked[I]) then begin
        S := Items[I];
        L := GetLinha(S);
        if (L > 0) then
          Remover(Values[I], L);
      end;

  MensagemBar('Remocao efetuada com sucesso!');
end;

//--

procedure TF_Substituir.dsPastaDblClick(Sender: TObject);
begin
  dsPasta.ChecarTodos();
end;

end.
