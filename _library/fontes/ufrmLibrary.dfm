object FrmLibrary: TFrmLibrary
  Left = 324
  Top = 234
  Width = 399
  Height = 435
  Caption = 'FrmLibrary'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnShow = FormShow
  DesignSize = (
    391
    408)
  PixelsPerInch = 96
  TextHeight = 13
  object LabelDelphi: TLabel
    Left = 4
    Top = 4
    Width = 30
    Height = 13
    Caption = 'Delphi'
  end
  object LabelVariavel: TLabel
    Left = 4
    Top = 44
    Width = 38
    Height = 13
    Caption = 'Variable'
  end
  object LabelLibrary: TLabel
    Left = 4
    Top = 84
    Width = 31
    Height = 13
    Caption = 'Library'
  end
  object cbDelphi: TComboBox
    Left = 4
    Top = 20
    Width = 373
    Height = 21
    Style = csDropDownList
    Anchors = [akLeft, akTop, akRight]
    ItemHeight = 13
    TabOrder = 0
  end
  object ButtonGravar: TButton
    Left = 4
    Top = 368
    Width = 373
    Height = 25
    Anchors = [akLeft, akRight, akBottom]
    Caption = 'Gravar'
    TabOrder = 3
    OnClick = ButtonGravarClick
  end
  object cbVariable: TComboBox
    Left = 4
    Top = 60
    Width = 373
    Height = 21
    Style = csDropDownList
    Anchors = [akLeft, akTop, akRight]
    ItemHeight = 13
    TabOrder = 1
  end
  object lbLibrary: TListBox
    Left = 4
    Top = 100
    Width = 373
    Height = 261
    ItemHeight = 13
    TabOrder = 2
  end
end
