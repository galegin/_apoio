unit ufrmConverter;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, ComCtrls;

type
  TF_Converter = class(TForm)
    Bevel1: TBevel;
    BtnConverter: TButton;
    tpConverter: TComboBox;
    MemoOri: TMemo;
    Splitter1: TSplitter;
    MemoDes: TMemo;
    Label1: TLabel;
    EditCaminho: TEdit;
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
  mDiretorio,
  uclsConverterDelphiToCSharp,
  uclsConverterDelphiToDelphi,
  uclsConverterUnifaceToCSharp;

const
  cLstConverter =
    'Delphi To CSharp' + sLineBreak +
    'Delphi To Delphi' + sLineBreak +
    'Uniface To CSharp' ;

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
  tpConverter.Items.Text := cLstConverter;
  tpConverter.ItemIndex := 1;
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

  function PrcConverter(pString : String) : String;
  begin
    case tpConverter.ItemIndex of
      0 : Result := TcConverterDelphiToCSharp.Converter(pString);
      1 : Result := TcConverterDelphiToDelphi.Converter(pString);
      2 : Result := TcConverterUnifaceToCSharp.Converter(pString);
    end;
  end;

var
  vList_Arquivo : TrArquivoArray;
  vDirOri, vDirDes : String;
  I : Integer;
begin
  MemoOri.Visible := False;
  MemoDes.Visible := False;

  if EditCaminho.Text <> '' then begin

    vDirOri := EditCaminho.Text;
    vDirDes := EditCaminho.Text + 'alterado\';
    TmDiretorio.Create(vDirDes);

    vList_Arquivo := TmDiretorio.Listar(vDirOri);

    for I := 0 to High(vList_Arquivo) do begin
      MemoOri.Lines.LoadFromFile(vDirOri + vList_Arquivo[I].Arquivo);
      MemoDes.Text := PrcConverter(MemoOri.Text);
      MemoDes.Lines.SaveToFile(vDirDes + vList_Arquivo[I].Arquivo);
    end;

  end else begin

    MemoDes.Text := PrcConverter(MemoOri.Text);

    DesCarregar();

  end;

  MemoOri.Visible := True;
  MemoDes.Visible := True;

  ShowMessage('Conversão efetuada com sucesso');
end;

end.
