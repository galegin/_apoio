object F_Converter: TF_Converter
  Left = 192
  Top = 124
  Width = 783
  Height = 540
  Caption = 'F_Converter'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  OnCreate = FormCreate
  OnKeyDown = FormKeyDown
  OnShow = FormShow
  DesignSize = (
    767
    502)
  PixelsPerInch = 96
  TextHeight = 13
  object Bevel1: TBevel
    Left = 0
    Top = 0
    Width = 767
    Height = 29
    Align = alTop
    Shape = bsSpacer
  end
  object Splitter1: TSplitter
    Left = 0
    Top = 189
    Width = 767
    Height = 4
    Cursor = crVSplit
    Align = alTop
  end
  object tpConverter: TComboBox
    Left = 96
    Top = 4
    Width = 665
    Height = 21
    BevelKind = bkFlat
    Style = csDropDownList
    Anchors = [akLeft, akTop, akRight]
    ItemHeight = 13
    ItemIndex = 0
    TabOrder = 1
    Text = 'Delphi To CSharp'
    Items.Strings = (
      'Delphi To CSharp')
  end
  object MemoOri: TMemo
    Left = 0
    Top = 29
    Width = 767
    Height = 160
    Align = alTop
    BorderStyle = bsNone
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Courier New'
    Font.Style = []
    ParentFont = False
    ScrollBars = ssBoth
    TabOrder = 2
  end
  object MemoDes: TMemo
    Left = 0
    Top = 193
    Width = 767
    Height = 309
    Align = alClient
    BorderStyle = bsNone
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Courier New'
    Font.Style = []
    ParentFont = False
    ScrollBars = ssBoth
    TabOrder = 3
  end
  object BtnConverter: TButton
    Left = 4
    Top = 4
    Width = 89
    Height = 21
    Caption = 'Converter'
    TabOrder = 0
    OnClick = BtnConverterClick
  end
end
