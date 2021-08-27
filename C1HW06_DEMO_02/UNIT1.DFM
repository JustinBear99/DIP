object Form1: TForm1
  Left = 191
  Top = 107
  Width = 805
  Height = 606
  Caption = 'Form1'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object GroupBox2: TGroupBox
    Left = 592
    Top = 200
    Width = 169
    Height = 369
    Caption = 'ToolBox2'
    TabOrder = 3
    object Label5: TLabel
      Left = 0
      Top = 42
      Width = 77
      Height = 24
      Caption = '(theta)X='
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -20
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object Label6: TLabel
      Left = 8
      Top = 74
      Width = 63
      Height = 24
      Caption = '(rho)Y='
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -20
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object Label7: TLabel
      Left = 16
      Top = 112
      Width = 134
      Height = 13
      Caption = '在Hough graph上面按左鍵'
    end
    object Label8: TLabel
      Left = 16
      Top = 128
      Width = 139
      Height = 13
      Caption = '可得知其A矩陣的值為多少'
    end
    object Label1: TLabel
      Left = 15
      Top = 273
      Width = 126
      Height = 24
      Caption = '搜尋直線的閥值'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -21
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object Label2: TLabel
      Left = 7
      Top = 321
      Width = 112
      Height = 16
      Caption = '得到的直線數目：'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object Label4: TLabel
      Left = 7
      Top = 185
      Width = 90
      Height = 24
      Caption = '二元化閥值'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -21
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object Bevel1: TBevel
      Left = 0
      Top = 104
      Width = 169
      Height = 73
    end
    object Bevel2: TBevel
      Left = 0
      Top = 176
      Width = 169
      Height = 89
    end
    object Edit5: TEdit
      Left = 32
      Top = 24
      Width = 70
      Height = 21
      TabOrder = 0
      Text = 'Edit5'
      Visible = False
    end
    object Edit6: TEdit
      Left = 80
      Top = 16
      Width = 70
      Height = 21
      TabOrder = 1
      Text = 'Edit6'
      Visible = False
    end
    object Edit7: TEdit
      Left = 104
      Top = 16
      Width = 70
      Height = 21
      TabOrder = 2
      Text = 'Edit7'
      Visible = False
    end
    object Edit8: TEdit
      Left = 72
      Top = 144
      Width = 70
      Height = 21
      TabOrder = 3
      Text = 'Edit8'
    end
    object Edit1: TEdit
      Left = 7
      Top = 12
      Width = 73
      Height = 21
      TabOrder = 4
      Text = 'Edit1'
      Visible = False
    end
    object Edit2: TEdit
      Left = 80
      Top = 44
      Width = 70
      Height = 21
      TabOrder = 5
      Text = 'Edit2'
    end
    object Edit3: TEdit
      Left = 80
      Top = 76
      Width = 70
      Height = 21
      TabOrder = 6
      Text = 'Edit3'
    end
    object ScrollBar2: TScrollBar
      Left = 8
      Top = 295
      Width = 145
      Height = 18
      Max = 200
      Min = 50
      PageSize = 0
      Position = 120
      TabOrder = 7
      OnChange = ScrollBar2Change
    end
    object Edit9: TEdit
      Left = 120
      Top = 316
      Width = 41
      Height = 21
      TabOrder = 8
      Text = 'Edit9'
    end
    object Edit4: TEdit
      Left = 104
      Top = 185
      Width = 57
      Height = 21
      TabOrder = 9
    end
    object ScrollBar1: TScrollBar
      Left = 8
      Top = 215
      Width = 153
      Height = 18
      Max = 255
      PageSize = 0
      Position = 150
      TabOrder = 10
      OnChange = ScrollBar1Change
    end
    object Button5: TButton
      Left = 48
      Top = 336
      Width = 89
      Height = 25
      Caption = '畫出找到的直線'
      TabOrder = 11
      OnClick = Button5Click
    end
  end
  object PageControl1: TPageControl
    Left = 16
    Top = 16
    Width = 529
    Height = 545
    ActivePage = TabSheet4
    TabOrder = 0
    object TabSheet1: TTabSheet
      Caption = '原圖'
      object origin: TImage
        Left = 0
        Top = 0
        Width = 512
        Height = 512
      end
    end
    object TabSheet2: TTabSheet
      Caption = '細化'
      ImageIndex = 1
      object Simg: TImage
        Left = 0
        Top = 0
        Width = 512
        Height = 512
      end
    end
    object TabSheet3: TTabSheet
      Caption = '二元化'
      ImageIndex = 2
      object Timg: TImage
        Left = 0
        Top = 0
        Width = 512
        Height = 512
        OnMouseMove = TimgMouseMove
      end
    end
    object TabSheet4: TTabSheet
      Caption = 'Hough graph'
      ImageIndex = 3
      object Himg: TImage
        Left = 0
        Top = 0
        Width = 513
        Height = 513
        OnMouseDown = HimgMouseDown
        OnMouseMove = HimgMouseMove
      end
    end
  end
  object GroupBox1: TGroupBox
    Left = 592
    Top = 24
    Width = 169
    Height = 169
    Caption = 'GroupBox1'
    TabOrder = 1
    object openbtn: TButton
      Left = 47
      Top = 16
      Width = 75
      Height = 25
      Caption = 'OPEN'
      TabOrder = 0
      OnClick = openbtnClick
    end
    object Sbtn: TButton
      Left = 47
      Top = 40
      Width = 75
      Height = 25
      Caption = 'Skeleton'
      TabOrder = 1
      OnClick = SbtnClick
    end
    object Tbtn: TButton
      Left = 47
      Top = 64
      Width = 75
      Height = 25
      Caption = '二元化'
      TabOrder = 2
      OnClick = TbtnClick
    end
    object Button1: TButton
      Left = 47
      Top = 88
      Width = 75
      Height = 25
      Caption = '邊緣檢測'
      TabOrder = 3
      OnClick = Button1Click
    end
    object Button2: TButton
      Left = 47
      Top = 112
      Width = 75
      Height = 25
      Caption = 'Hough'
      TabOrder = 4
      OnClick = Button2Click
    end
    object Button4: TButton
      Left = 47
      Top = 136
      Width = 75
      Height = 25
      Caption = 'Find Line'
      TabOrder = 5
      OnClick = Button4Click
    end
  end
  object Button3: TButton
    Left = 512
    Top = 8
    Width = 75
    Height = 25
    Caption = 'Button3'
    TabOrder = 2
    Visible = False
    OnClick = Button3Click
  end
  object OpenDialog1: TOpenDialog
    Left = 760
    Top = 24
  end
end
