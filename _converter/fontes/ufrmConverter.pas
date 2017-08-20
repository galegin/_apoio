unit ufrmConverter;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls;

type
  TF_Converter = class(TForm)
    Bevel1: TBevel;
    BtnConverter: TButton;
    tpConverter: TComboBox;
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
  uclsConverterDelphiToCSharp;

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
begin
  MemoDes.Text := TcConverterDelphiToCSharp.Converter(MemoOri.Text);
  DesCarregar();
  ShowMessage('Convers�o efetuada com sucesso');
end;

end.