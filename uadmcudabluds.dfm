object cudaBludForm: TcudaBludForm
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu]
  Caption = #1048#1079#1084#1077#1085#1077#1085#1080#1077' '#1073#1083#1102#1076
  ClientHeight = 198
  ClientWidth = 255
  Color = clBtnFace
  Font.Charset = RUSSIAN_CHARSET
  Font.Color = clWindowText
  Font.Height = -15
  Font.Name = 'Arial'
  Font.Style = []
  OldCreateOrder = False
  Position = poOwnerFormCenter
  OnActivate = FormActivate
  OnKeyPress = FormKeyPress
  PixelsPerInch = 96
  TextHeight = 17
  object edtNaim: TLabeledEdit
    Left = 8
    Top = 32
    Width = 233
    Height = 25
    EditLabel.Width = 164
    EditLabel.Height = 18
    EditLabel.Caption = #1053#1072#1080#1084#1077#1085#1086#1074#1072#1085#1080#1077' '#1073#1083#1102#1076#1072
    EditLabel.Font.Charset = RUSSIAN_CHARSET
    EditLabel.Font.Color = clWindowText
    EditLabel.Font.Height = -15
    EditLabel.Font.Name = 'Arial'
    EditLabel.Font.Style = [fsBold]
    EditLabel.ParentFont = False
    MaxLength = 29
    TabOrder = 0
  end
  object edtKod: TLabeledEdit
    Left = 26
    Top = 280
    Width = 97
    Height = 25
    EditLabel.Width = 82
    EditLabel.Height = 18
    EditLabel.Caption = #1050#1086#1076' '#1073#1083#1102#1076#1072
    EditLabel.Font.Charset = RUSSIAN_CHARSET
    EditLabel.Font.Color = clWindowText
    EditLabel.Font.Height = -15
    EditLabel.Font.Name = 'Arial'
    EditLabel.Font.Style = [fsBold]
    EditLabel.ParentFont = False
    NumbersOnly = True
    TabOrder = 2
  end
  object edtPrice: TLabeledEdit
    Left = 128
    Top = 80
    Width = 111
    Height = 25
    EditLabel.Width = 91
    EditLabel.Height = 18
    EditLabel.Caption = #1062#1077#1085#1072' '#1073#1083#1102#1076#1072
    EditLabel.Font.Charset = RUSSIAN_CHARSET
    EditLabel.Font.Color = clWindowText
    EditLabel.Font.Height = -15
    EditLabel.Font.Name = 'Arial'
    EditLabel.Font.Style = [fsBold]
    EditLabel.ParentFont = False
    NumbersOnly = True
    TabOrder = 3
  end
  object chkAvail: TCheckBox
    Left = 8
    Top = 124
    Width = 97
    Height = 17
    Caption = #1042' '#1085#1072#1083#1080#1095#1080#1080
    Font.Charset = RUSSIAN_CHARSET
    Font.Color = clWindowText
    Font.Height = -15
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 4
  end
  object btnOk: TButton
    Left = 26
    Top = 162
    Width = 86
    Height = 29
    Caption = #1054#1082
    Default = True
    Font.Charset = RUSSIAN_CHARSET
    Font.Color = clWindowText
    Font.Height = -15
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 6
    OnClick = btnOkClick
  end
  object btnCancel: TButton
    Left = 138
    Top = 162
    Width = 86
    Height = 29
    Cancel = True
    Caption = #1054#1090#1084#1077#1085#1072
    Font.Charset = RUSSIAN_CHARSET
    Font.Color = clWindowText
    Font.Height = -15
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ModalResult = 2
    ParentFont = False
    TabOrder = 7
  end
  object chkIssale: TCheckBox
    Left = 128
    Top = 124
    Width = 111
    Height = 17
    Caption = #1042' '#1087#1088#1086#1076#1072#1078#1077
    Font.Charset = RUSSIAN_CHARSET
    Font.Color = clWindowText
    Font.Height = -15
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 5
  end
  object edtNavbat: TLabeledEdit
    Left = 8
    Top = 80
    Width = 97
    Height = 25
    EditLabel.Width = 49
    EditLabel.Height = 18
    EditLabel.Caption = #1053#1086#1084#1077#1088
    EditLabel.Font.Charset = RUSSIAN_CHARSET
    EditLabel.Font.Color = clWindowText
    EditLabel.Font.Height = -15
    EditLabel.Font.Name = 'Arial'
    EditLabel.Font.Style = [fsBold]
    EditLabel.ParentFont = False
    NumbersOnly = True
    TabOrder = 1
  end
end
