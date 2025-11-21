object Form2: TForm2
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu]
  Caption = #1055#1083#1072#1085#1096#1077#1090#1085#1099#1081' '#1088#1077#1078#1080#1084' '
  ClientHeight = 185
  ClientWidth = 339
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  Position = poMainFormCenter
  OnActivate = FormActivate
  OnCreate = FormCreate
  OnKeyPress = FormKeyPress
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 60
    Top = 3
    Width = 221
    Height = 31
    Caption = #1042#1074#1077#1076#1080#1090#1077' '#8470' C'#1090#1086#1083#1072
    Font.Charset = RUSSIAN_CHARSET
    Font.Color = clBlue
    Font.Height = -27
    Font.Name = 'Times New Roman'
    Font.Style = [fsBold, fsItalic]
    ParentFont = False
  end
  object lbl1: TLabel
    Left = 74
    Top = 82
    Width = 189
    Height = 22
    Caption = #1042#1099#1073#1077#1088#1080#1090#1077' '#1088#1072#1073#1086#1090#1085#1080#1082#1072
    Font.Charset = RUSSIAN_CHARSET
    Font.Color = clGreen
    Font.Height = -19
    Font.Name = 'Times New Roman'
    Font.Style = [fsBold, fsItalic]
    ParentFont = False
  end
  object Edit1: TEdit
    Left = 84
    Top = 40
    Width = 169
    Height = 31
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -19
    Font.Name = 'Tahoma'
    Font.Style = []
    NumbersOnly = True
    ParentFont = False
    TabOrder = 0
  end
  object BtnOk: TButton
    Left = 116
    Top = 150
    Width = 97
    Height = 28
    Caption = 'OK'
    Default = True
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Tahoma'
    Font.Style = [fsBold, fsItalic]
    ParentFont = False
    TabOrder = 2
    OnClick = BtnOkClick
  end
  object workersBox: TsComboBox
    Left = 84
    Top = 110
    Width = 169
    Height = 29
    TabOrder = 1
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWhite
    Font.Height = -17
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    DropDownCount = 30
    Style = csDropDownList
  end
end
