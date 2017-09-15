unit ufrmConverter;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, ComCtrls;

type
  TF_Converter = class(TForm)
    Bevel1: TBevel;
    BtnConverter: TButton;
    ComboBoxTipo: TComboBox;
    LabelCaminho: TLabel;
    EditCaminho: TEdit;
    LabelExtensao: TLabel;
    EditExtensao: TEdit;
    CheckBoxBackup: TCheckBox;
    MemoOri: TMemo;
    Splitter1: TSplitter;
    MemoDes: TMemo;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure BtnConverterClick(Sender: TObject);
  private
    procedure Carregar();
    procedure DesCarregar();
  public
  end;

var
  F_Converter: TF_Converter;

implementation

uses
  mDiretorio, mIniFiles, mPath,
  uclsConverterAbstract,
  uclsConverterConfigurado,
  uclsConverterDelphiToCSharp,
  uclsConverterDelphiToDelphi,
  uclsConverterUnifaceToCSharp;

  procedure TF_Converter.Carregar();
  begin
    if FileExists(Application.ExeName + '.ori') then
      MemoOri.Lines.LoadFromFile(Application.ExeName + '.ori');
    if FileExists(Application.ExeName + '.des') then
      MemoDes.Lines.LoadFromFile(Application.ExeName + '.des');
  end;

  procedure TF_Converter.DesCarregar();
  begin
    MemoOri.Lines.SaveToFile(Application.ExeName + '.ori');
    MemoDes.Lines.SaveToFile(Application.ExeName + '.des');
  end;

{$R *.dfm}

procedure TF_Converter.FormCreate(Sender: TObject);
begin
  with ComboBoxTipo do begin
    Items.Clear;
    Items.AddObject('Configurado', TcConverterConfigurado.Create);
    Items.AddObject('Delphi To CSharp', TcConverterDelphiToCSharp.Create);
    Items.AddObject('Delphi To Delphi', TcConverterDelphiToDelphi.Create);
    Items.AddObject('Uniface To CSharp', TcConverterUnifaceToCSharp.Create);
    ItemIndex := 0;
  end;

  EditCaminho.Text := TmPath.Temp();
  EditExtensao.Text := '.dpr|.pas';

  ComboBoxTipo.ItemIndex := TmIniFiles.PegarI('', '', 'ComboBoxTipo', 0);
  EditCaminho.Text := TmIniFiles.PegarS('', '', 'EditCaminho', EditCaminho.Text);
  EditExtensao.Text := TmIniFiles.PegarS('', '', 'EditExtensao', EditExtensao.Text);
  CheckBoxBackup.Checked := TmIniFiles.PegarB('', '', 'CheckBoxBackup', CheckBoxBackup.Checked);

  Carregar();
end;

procedure TF_Converter.FormShow(Sender: TObject);
begin
  WindowState := wsMaximized;
end;

procedure TF_Converter.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  case (Key) of
    VK_ESCAPE : Close;
  end;
end;

procedure TF_Converter.BtnConverterClick(Sender: TObject);
var
  vList_Arquivo : TrArquivoArray;
  vDirOri, vDirDes : String;
  I : Integer;
begin
  MemoOri.Visible := False;
  MemoDes.Visible := False;

  SetLength(vList_Arquivo, 0);

  TmIniFiles.Setar('', '', 'ComboBoxTipo', ComboBoxTipo.ItemIndex);
  TmIniFiles.Setar('', '', 'EditCaminho', EditCaminho.Text);
  TmIniFiles.Setar('', '', 'EditExtensao', EditExtensao.Text);
  TmIniFiles.Setar('', '', 'CheckBoxBackup', CheckBoxBackup.Checked);

  if EditCaminho.Text <> '' then begin

    vDirOri := EditCaminho.Text;
    if CheckBoxBackup.Checked then begin
      vDirDes := EditCaminho.Text + 'alterado\';
      TmDiretorio.Create(vDirDes);
    end else begin
      vDirDes := EditCaminho.Text;
    end;

    vList_Arquivo := TmDiretorio.Listar(vDirOri, EditExtensao.Text);

    for I := 0 to High(vList_Arquivo) do begin
      MemoOri.Lines.LoadFromFile(vDirOri + vList_Arquivo[I].Arquivo);

      with ComboBoxTipo do
        MemoDes.Text := TcConverterAbstract(Items.Objects[Itemindex]).Converter(MemoOri.Text);

      MemoDes.Lines.SaveToFile(vDirDes + vList_Arquivo[I].Arquivo);
    end;

  end else begin

    with ComboBoxTipo do
      MemoDes.Text := TcConverterAbstract(Items.Objects[Itemindex]).Converter(MemoOri.Text);

    DesCarregar();

  end;

  MemoOri.Visible := True;
  MemoDes.Visible := True;

  ShowMessage('Conversão efetuada com sucesso');
end;

end.
