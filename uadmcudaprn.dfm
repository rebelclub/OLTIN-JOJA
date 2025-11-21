object prnCUDAForm: TprnCUDAForm
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu]
  Caption = #1042#1099#1073#1080#1088#1072#1081#1090#1077' '#1087#1088#1080#1085#1090#1077#1088
  ClientHeight = 136
  ClientWidth = 271
  Color = clBtnFace
  Font.Charset = RUSSIAN_CHARSET
  Font.Color = clWindowText
  Font.Height = -15
  Font.Name = 'Arial'
  Font.Style = []
  OldCreateOrder = False
  Position = poOwnerFormCenter
  OnActivate = FormActivate
  PixelsPerInch = 96
  TextHeight = 17
  object rg: TRadioGroup
    Left = 8
    Top = 52
    Width = 255
    Height = 38
    Columns = 2
    Font.Charset = RUSSIAN_CHARSET
    Font.Color = clWhite
    Font.Height = -15
    Font.Name = 'Arial'
    Font.Style = []
    ItemIndex = 0
    Items.Strings = (
      'X-58'
      'POS-80')
    ParentFont = False
    TabOrder = 0
  end
  object cbPrns: TsComboBox
    Left = 8
    Top = 15
    Width = 255
    Height = 27
    Font.Charset = RUSSIAN_CHARSET
    Font.Color = clWhite
    Font.Height = -17
    Font.Name = 'Arial'
    Font.Style = []
    ParentFont = False
    Style = csDropDownList
    ItemIndex = -1
    TabOrder = 1
  end
  object sBitBtn1: TsBitBtn
    Left = 35
    Top = 100
    Width = 89
    Height = 31
    Kind = bkOK
    NumGlyphs = 2
    TabOrder = 2
  end
  object sBitBtn2: TsBitBtn
    Left = 147
    Top = 100
    Width = 89
    Height = 31
    Kind = bkCancel
    NumGlyphs = 2
    TabOrder = 3
  end
end
