object F_Substituir: TF_Substituir
  Left = 226
  Top = 128
  Width = 790
  Height = 625
  Caption = 'Substituir'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -21
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  OnCreate = FormCreate
  OnKeyDown = FormKeyDown
  OnKeyPress = FormKeyPress
  OnResize = FormResize
  PixelsPerInch = 96
  TextHeight = 24
  object _PanelFiltro: TmPanel
    Left = 0
    Top = 0
    Width = 774
    Height = 201
    Align = alTop
    BevelOuter = bvNone
    Caption = ' '
    TabOrder = 0
    _TpFundo = tpfNenhum
    DesignSize = (
      774
      201)
    object LabelDir: TmLabel
      Left = 4
      Top = 4
      Width = 105
      Height = 24
      Alignment = taCenter
      AutoSize = False
      Caption = 'Caminho'
      Color = clGray
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -21
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentColor = False
      ParentFont = False
      Layout = tlCenter
      _TpLabel = tplButton
    end
    object LabelAnt: TmLabel
      Left = 4
      Top = 116
      Width = 105
      Height = 24
      Alignment = taCenter
      AutoSize = False
      Caption = 'Anterior'
      Color = clGray
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -21
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentColor = False
      ParentFont = False
      Layout = tlCenter
      _TpLabel = tplButton
    end
    object LabelNov: TmLabel
      Left = 4
      Top = 144
      Width = 105
      Height = 24
      Alignment = taCenter
      AutoSize = False
      Caption = 'Novo'
      Color = clGray
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -21
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentColor = False
      ParentFont = False
      Layout = tlCenter
      _TpLabel = tplButton
    end
    object LabelExt: TmLabel
      Left = 4
      Top = 60
      Width = 105
      Height = 24
      Alignment = taCenter
      AutoSize = False
      Caption = 'Extens'#227'o'
      Color = clGray
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -21
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentColor = False
      ParentFont = False
      Layout = tlCenter
      OnClick = LabelExtClick
      _TpLabel = tplButton
    end
    object LabelFil: TmLabel
      Left = 4
      Top = 88
      Width = 105
      Height = 24
      Alignment = taCenter
      AutoSize = False
      Caption = 'Filtro'
      Color = clGray
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -21
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentColor = False
      ParentFont = False
      Layout = tlCenter
      _TpLabel = tplButton
    end
    object mLabel1: TmLabel
      Left = 392
      Top = 4
      Width = 377
      Height = 24
      Alignment = taCenter
      Anchors = [akLeft, akTop, akRight]
      AutoSize = False
      Caption = 'Caminho'
      Color = clGray
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -21
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentColor = False
      ParentFont = False
      Layout = tlCenter
      OnClick = dsPastaDblClick
      _TpLabel = tplButton
    end
    object mLabel2: TmLabel
      Left = 4
      Top = 32
      Width = 105
      Height = 24
      Alignment = taCenter
      AutoSize = False
      Caption = 'Pasta'
      Color = clGray
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -21
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentColor = False
      ParentFont = False
      Layout = tlCenter
      OnClick = LabelExtClick
      _TpLabel = tplButton
    end
    object EditAnt: TmEdit
      Left = 112
      Top = 116
      Width = 277
      Height = 24
      AutoSize = False
      BorderStyle = bsNone
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -21
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 4
      _FieldType = ftString
      _ColorEnter = clYellow
      _ColorExit = clWhite
      _Tam = 0
      _Dec = 0
      _Mover = False
      _TpEdit = tpeEdit
      _TpFormatar = tfNENHUM
      _Inteiro = 0
    end
    object EditDir: TmEdit
      Left = 112
      Top = 4
      Width = 277
      Height = 24
      AutoSize = False
      BorderStyle = bsNone
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -21
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 0
      Text = 'd:\projeto_miguel\'
      OnExit = EditDirExit
      _FieldType = ftString
      _ColorEnter = clYellow
      _ColorExit = clWhite
      _Tam = 0
      _Dec = 0
      _Value = 'd:\projeto_miguel\'
      _Mover = False
      _TpEdit = tpeEdit
      _TpFormatar = tfNENHUM
      _Inteiro = 0
    end
    object EditNov: TmEdit
      Left = 112
      Top = 144
      Width = 277
      Height = 24
      AutoSize = False
      BorderStyle = bsNone
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -21
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 5
      _FieldType = ftString
      _ColorEnter = clYellow
      _ColorExit = clWhite
      _Tam = 0
      _Dec = 0
      _Mover = False
      _TpEdit = tpeEdit
      _TpFormatar = tfNENHUM
      _Inteiro = 0
    end
    object BtnSubstituir: TmButton
      Left = 436
      Top = 172
      Width = 105
      Height = 24
      Caption = 'Substituir'
      TabOrder = 9
      OnClick = BtnSubstituirClick
    end
    object BtnConsultar: TmButton
      Left = 220
      Top = 172
      Width = 105
      Height = 24
      Caption = 'Consultar'
      TabOrder = 7
      OnClick = BtnConsultarClick
    end
    object BtnSelecionar: TmButton
      Left = 328
      Top = 172
      Width = 105
      Height = 24
      Caption = 'Selecionar'
      TabOrder = 8
      OnClick = BtnSelecionarClick
    end
    object BtnRemover: TmButton
      Left = 544
      Top = 172
      Width = 105
      Height = 24
      Caption = 'Remover'
      TabOrder = 10
      OnClick = BtnRemoverClick
    end
    object EditExt: TmEdit
      Left = 112
      Top = 60
      Width = 277
      Height = 24
      AutoSize = False
      BorderStyle = bsNone
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -21
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 2
      _FieldType = ftString
      _ColorEnter = clYellow
      _ColorExit = clWhite
      _Tam = 0
      _Dec = 0
      _Mover = False
      _TpEdit = tpeEdit
      _TpFormatar = tfNENHUM
      _Inteiro = 0
    end
    object CheckedAgr: TmCheckBox
      Left = 656
      Top = 172
      Width = 97
      Height = 24
      Caption = 'Agrupar'
      TabOrder = 11
      OnClick = CheckedAgrClick
      _Value = 'False'
    end
    object BtnLimpar: TmButton
      Left = 112
      Top = 172
      Width = 105
      Height = 24
      Caption = 'Limpar'
      TabOrder = 6
      OnClick = BtnLimparClick
    end
    object EditFil: TmEdit
      Left = 112
      Top = 88
      Width = 277
      Height = 24
      AutoSize = False
      BorderStyle = bsNone
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -21
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 3
      _FieldType = ftString
      _ColorEnter = clYellow
      _ColorExit = clWhite
      _Tam = 0
      _Dec = 0
      _Mover = False
      _TpEdit = tpeEdit
      _TpFormatar = tfNENHUM
      _Inteiro = 0
    end
    object dsPasta: TmCheckListBox
      Left = 392
      Top = 28
      Width = 377
      Height = 141
      Anchors = [akLeft, akTop, akRight]
      BorderStyle = bsNone
      Columns = 2
      ItemHeight = 24
      TabOrder = 12
      OnDblClick = dsPastaDblClick
      _Check = False
    end
    object EditPasta: TmEdit
      Left = 112
      Top = 32
      Width = 277
      Height = 24
      AutoSize = False
      BorderStyle = bsNone
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -21
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 1
      Text = '*.*'
      _FieldType = ftString
      _ColorEnter = clYellow
      _ColorExit = clWhite
      _Tam = 0
      _Dec = 0
      _Value = '*.*'
      _Mover = False
      _TpEdit = tpeEdit
      _TpFormatar = tfNENHUM
      _Inteiro = 0
    end
  end
  object cdArquivo: TmCheckListBox
    Left = 0
    Top = 201
    Width = 774
    Height = 367
    Align = alClient
    BevelOuter = bvNone
    BorderStyle = bsNone
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Lucida Console'
    Font.Style = []
    ItemHeight = 11
    ParentFont = False
    TabOrder = 1
    OnDblClick = cdArquivoDblClick
    _Check = False
  end
  object _StatusBar: TStatusBar
    Left = 0
    Top = 568
    Width = 774
    Height = 19
    Panels = <
      item
        Width = 50
      end>
  end
end
