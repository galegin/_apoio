object FrmConverter: TFrmConverter
  Left = 213
  Top = 116
  Width = 726
  Height = 685
  Caption = 'FrmConverter'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnActivate = FormActivate
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Splitter1: TSplitter
    Left = 0
    Top = 249
    Width = 710
    Height = 3
    Cursor = crVSplit
    Align = alTop
  end
  object MemoOri: TMemo
    Left = 0
    Top = 0
    Width = 710
    Height = 249
    Align = alTop
    BevelInner = bvNone
    BorderStyle = bsNone
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Lucida Console'
    Font.Style = []
    ParentFont = False
    ScrollBars = ssBoth
    TabOrder = 0
    WordWrap = False
  end
  object PnlConverter: TPanel
    Left = 0
    Top = 252
    Width = 710
    Height = 32
    Cursor = crHandPoint
    Align = alTop
    BevelOuter = bvNone
    Caption = 'Converter'
    TabOrder = 1
    OnClick = PnlConverterClick
    object LabelPosicao: TLabel
      Left = 4
      Top = 8
      Width = 6
      Height = 13
      Caption = '0'
    end
  end
  object MemoDes: TMemo
    Left = 0
    Top = 284
    Width = 710
    Height = 363
    Align = alClient
    BevelInner = bvNone
    BorderStyle = bsNone
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Lucida Console'
    Font.Style = []
    ParentFont = False
    ScrollBars = ssBoth
    TabOrder = 2
    WordWrap = False
  end
end
