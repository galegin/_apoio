object F_Persistent: TF_Persistent
  Left = 325
  Top = 242
  Width = 379
  Height = 285
  Caption = 'F_Persistent'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object BtnTestar: TButton
    Left = 4
    Top = 4
    Width = 75
    Height = 25
    Caption = 'Testar'
    TabOrder = 0
    OnClick = BtnTestarClick
  end
  object BtnGerar: TButton
    Left = 84
    Top = 4
    Width = 75
    Height = 25
    Caption = 'Gerar'
    TabOrder = 1
    OnClick = BtnGerarClick
  end
end
