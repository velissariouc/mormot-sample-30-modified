object Form2: TForm2
  Left = 0
  Top = 0
  Caption = 'Hash generator for mormot 18i'
  ClientHeight = 278
  ClientWidth = 490
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  PixelsPerInch = 96
  TextHeight = 13
  object Edit1: TEdit
    Left = 0
    Top = 16
    Width = 490
    Height = 21
    Align = alTop
    TabOrder = 0
    ExplicitLeft = 10
    ExplicitTop = 73
    ExplicitWidth = 472
  end
  object Memo1: TMemo
    Left = 0
    Top = 78
    Width = 490
    Height = 159
    Align = alClient
    Lines.Strings = (
      '[Messages]')
    ScrollBars = ssBoth
    TabOrder = 1
  end
  object Panel1: TPanel
    Left = 0
    Top = 237
    Width = 490
    Height = 41
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 2
    ExplicitLeft = 237
    ExplicitTop = 213
    ExplicitWidth = 185
    object Button1: TButton
      Left = 411
      Top = 8
      Width = 75
      Height = 25
      Caption = 'Hash'
      TabOrder = 0
      OnClick = Button1Click
    end
  end
  object Panel2: TPanel
    Left = 0
    Top = 0
    Width = 490
    Height = 16
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 3
    object Label1: TLabel
      Left = 10
      Top = 0
      Width = 42
      Height = 13
      Caption = 'message'
    end
  end
  object Panel3: TPanel
    Left = 0
    Top = 37
    Width = 490
    Height = 41
    Align = alTop
    BevelOuter = bvNone
    Caption = 'Results'
    TabOrder = 4
    ExplicitLeft = 118
    ExplicitTop = 63
    ExplicitWidth = 185
  end
end
