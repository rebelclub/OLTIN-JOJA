object FormOstats: TFormOstats
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = #1054#1089#1090#1072#1090#1082#1080
  ClientHeight = 398
  ClientWidth = 420
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  Position = poOwnerFormCenter
  OnActivate = FormActivate
  OnCreate = FormCreate
  OnKeyPress = FormKeyPress
  PixelsPerInch = 96
  TextHeight = 13
  object sg: TAdvStringGrid
    Left = 0
    Top = 0
    Width = 420
    Height = 398
    Cursor = crDefault
    Align = alClient
    DrawingStyle = gdsClassic
    FixedCols = 2
    RowCount = 12
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    PopupMenu = pm1
    ScrollBars = ssBoth
    TabOrder = 0
    HoverRowCells = [hcNormal, hcSelected]
    ActiveCellFont.Charset = DEFAULT_CHARSET
    ActiveCellFont.Color = clWindowText
    ActiveCellFont.Height = -11
    ActiveCellFont.Name = 'Tahoma'
    ActiveCellFont.Style = [fsBold]
    ControlLook.FixedGradientHoverFrom = clGray
    ControlLook.FixedGradientHoverTo = clWhite
    ControlLook.FixedGradientDownFrom = clGray
    ControlLook.FixedGradientDownTo = clSilver
    ControlLook.DropDownHeader.Font.Charset = DEFAULT_CHARSET
    ControlLook.DropDownHeader.Font.Color = clWindowText
    ControlLook.DropDownHeader.Font.Height = -11
    ControlLook.DropDownHeader.Font.Name = 'Tahoma'
    ControlLook.DropDownHeader.Font.Style = []
    ControlLook.DropDownHeader.Visible = True
    ControlLook.DropDownHeader.Buttons = <>
    ControlLook.DropDownFooter.Font.Charset = DEFAULT_CHARSET
    ControlLook.DropDownFooter.Font.Color = clWindowText
    ControlLook.DropDownFooter.Font.Height = -11
    ControlLook.DropDownFooter.Font.Name = 'Tahoma'
    ControlLook.DropDownFooter.Font.Style = []
    ControlLook.DropDownFooter.Visible = True
    ControlLook.DropDownFooter.Buttons = <>
    Filter = <>
    FilterDropDown.Font.Charset = DEFAULT_CHARSET
    FilterDropDown.Font.Color = clWindowText
    FilterDropDown.Font.Height = -11
    FilterDropDown.Font.Name = 'Tahoma'
    FilterDropDown.Font.Style = []
    FilterDropDown.TextChecked = 'Checked'
    FilterDropDown.TextUnChecked = 'Unchecked'
    FilterDropDownClear = '(All)'
    FilterEdit.TypeNames.Strings = (
      'Starts with'
      'Ends with'
      'Contains'
      'Not contains'
      'Equal'
      'Not equal'
      'Clear')
    FixedAsButtons = True
    FixedRowHeight = 22
    FixedFont.Charset = DEFAULT_CHARSET
    FixedFont.Color = clWindowText
    FixedFont.Height = -11
    FixedFont.Name = 'Tahoma'
    FixedFont.Style = [fsBold]
    FloatFormat = '%.2f'
    HoverButtons.Buttons = <>
    HoverButtons.Position = hbLeftFromColumnLeft
    HTMLSettings.ImageFolder = 'images'
    HTMLSettings.ImageBaseName = 'img'
    PrintSettings.DateFormat = 'dd/mm/yyyy'
    PrintSettings.Font.Charset = DEFAULT_CHARSET
    PrintSettings.Font.Color = clWindowText
    PrintSettings.Font.Height = -11
    PrintSettings.Font.Name = 'Tahoma'
    PrintSettings.Font.Style = []
    PrintSettings.FixedFont.Charset = DEFAULT_CHARSET
    PrintSettings.FixedFont.Color = clWindowText
    PrintSettings.FixedFont.Height = -11
    PrintSettings.FixedFont.Name = 'Tahoma'
    PrintSettings.FixedFont.Style = []
    PrintSettings.HeaderFont.Charset = DEFAULT_CHARSET
    PrintSettings.HeaderFont.Color = clWindowText
    PrintSettings.HeaderFont.Height = -11
    PrintSettings.HeaderFont.Name = 'Tahoma'
    PrintSettings.HeaderFont.Style = []
    PrintSettings.FooterFont.Charset = DEFAULT_CHARSET
    PrintSettings.FooterFont.Color = clWindowText
    PrintSettings.FooterFont.Height = -11
    PrintSettings.FooterFont.Name = 'Tahoma'
    PrintSettings.FooterFont.Style = []
    PrintSettings.PageNumSep = '/'
    ScrollWidth = 19
    SearchFooter.FindNextCaption = 'Find &next'
    SearchFooter.FindPrevCaption = 'Find &previous'
    SearchFooter.Font.Charset = DEFAULT_CHARSET
    SearchFooter.Font.Color = clWindowText
    SearchFooter.Font.Height = -11
    SearchFooter.Font.Name = 'Tahoma'
    SearchFooter.Font.Style = []
    SearchFooter.HighLightCaption = 'Highlight'
    SearchFooter.HintClose = 'Close'
    SearchFooter.HintFindNext = 'Find next occurrence'
    SearchFooter.HintFindPrev = 'Find previous occurrence'
    SearchFooter.HintHighlight = 'Highlight occurrences'
    SearchFooter.MatchCaseCaption = 'Match case'
    ShowDesignHelper = False
    SortSettings.DefaultFormat = ssAutomatic
    Version = '8.1.3.0'
    ColWidths = (
      64
      64
      30
      29
      32)
    RowHeights = (
      26
      24
      22
      22
      22
      22
      22
      22
      22
      22
      22
      22)
    object BtnExp1: TsBitBtn
      Left = 324
      Top = 17
      Width = 89
      Height = 28
      Caption = #1069#1082#1089#1087#1086#1088#1090' 1'
      Glyph.Data = {
        CE070000424DCE07000000000000360000002800000024000000120000000100
        1800000000009807000000000000000000000000000000000000FFFFFF8FD2A6
        58B97353BB7653BB7653BB7659BC7A61C0816AC3886FC68C72C68E73C78F71C6
        8D6DC48A66C2855EBF7D52BA7554BB778FD2A658B97353BB7653BB7653BB7659
        BC7A61C0816AC3886FC68C72C68E73C78F71C68D6DC48A66C2855EBF7D52BA75
        54BB77FFFFFFFFFFFF38AE604AAC6CB8E3C6C2E7CEC1E6CDC3E7CFC9E9D3CEEB
        D7D1EDDAD4EEDCD6EEDED7EFDED6EFDED5EEDDD3EEDCC5E8D083CD9C38AE604A
        AC6CB8E3C6C2E7CEC1E6CDC3E7CFC9E9D3CEEBD7D1EDDAD4EEDCD6EEDED7EFDE
        D6EFDED5EEDDD3EEDCC5E8D083CD9CFFFFFFFFFFFF3FB1667FBF99EAF7EE98D4
        A99AD7AF99D7AE98D6AD98D6AD97D6AC97D6AC96D6AC96D6AC96D5AC97D5AC95
        D4AAF5FBF7BDE5CA3FB1667FBF99EAF7EE98D4A99AD7AF99D7AE98D6AD98D6AD
        97D6AC97D6AC96D6AC96D6AC96D5AC97D5AC95D4AAF5FBF7BDE5CAFFFFFFFFFF
        FF40B16781C09AAFE0BE69C993A7E6CC9FE3C59FE2C59DE2C59CE2C499E1C29B
        E4C69FE7CC9CE7CB9EE8CE5AC68CCBE9D4C1E6CD40B16781C09AAFE0BE69C993
        A7E6CC9FE3C59FE2C59DE2C59CE2C499E1C29BE4C69FE7CC9CE7CB9EE8CE5AC6
        8CCBE9D4C1E6CDFFFFFFFFFFFF49B56D87C39FB1E0C091DBB7DCFBF8D9F9F5D6
        F9F4D3F8F2D1F7F1D3FAF5B1E4D478C09A75BE9782C7A67CD4AACDEBD6C4E7D0
        49B56D87C39FB1E0C091DBB7DCFBF8D9F9F5D6F9F4D3F8F2D1F7F1D3FAF5B1E4
        D478C09A75BE9782C7A67CD4AACDEBD6C4E7D0FFFFFFFFFFFF5ABB7A92C9A8B0
        E0BF97DCBA9CD5B949AF7158B77E61BB8663BC8757B17C228A3C007711037611
        77C09382D8B0CCEAD5C4E8D15ABB7A92C9A8B0E0BF97DCBA9CD5B949AF7158B7
        7E61BB8663BC8757B17C228A3C00771103761177C09382D8B0CCEAD5C4E8D1FF
        FFFFFFFFFF67C1859ACCAEAEDFBE98DCB8DAF7EF49B66F27A95146B76B43B269
        1A8E390E8424047C17218B38C0F0E682D8AECBEAD5C5E8D167C1859ACCAEAEDF
        BE98DCB8DAF7EF49B66F27A95146B76B43B2691A8E390E8424047C17218B38C0
        F0E682D8AECBEAD5C5E8D1FFFFFFFFFFFF70C48D9FCFB2ADDFBD98DCB7EDFFFF
        D0F1E656BA7A45B56B28994C148C2F0E8826369B4E46A36287C9A987D9B1CBEA
        D5C4E8D170C48D9FCFB2ADDFBD98DCB7EDFFFFD0F1E656BA7A45B56B28994C14
        8C2F0E8826369B4E46A36287C9A987D9B1CBEAD5C4E8D1FFFFFFFFFFFF77C792
        A1D0B4ADDFBD9DDCB9ECFDFCE9FEFBC6EBDC3FA662179337118E2F48A861CEF5
        EBD8FDF9D2FAF482D6ABCCEAD5C3E7CF77C792A1D0B4ADDFBD9DDCB9ECFDFCE9
        FEFBC6EBDC3FA662179337118E2F48A861CEF5EBD8FDF9D2FAF482D6ABCCEAD5
        C3E7CFFFFFFFFFFFFF7BC996A1D0B4ADDFBDA0DDBAF1FFFEEFFFFEB0DCC643AA
        621E9B400C8C2A4DA86AD8F9F5D0F8EED1F8F184D6ADCCEAD5BFE6CC7BC996A1
        D0B4ADDFBDA0DDBAF1FFFEEFFFFEB0DCC643AA621E9B400C8C2A4DA86AD8F9F5
        D0F8EED1F8F184D6ADCCEAD5BFE6CCFFFFFFFFFFFF7CC9969DCEB1ADDFBDA3DD
        BBFFFFFFC7E6D946AF6943B0642B9E4B098625007D1662B07DDBFDF9D4FAF385
        D6ADCDEAD6BAE3C87CC9969DCEB1ADDFBDA3DDBBFFFFFFC7E6D946AF6943B064
        2B9E4B098625007D1662B07DDBFDF9D4FAF385D6ADCDEAD6BAE3C8FFFFFFFFFF
        FF7AC99597CBACAEDFBEACE0C1DBEDE539A95F16A04248B067B9E2CC68B48100
        7309006B006AB383DAFCF987D6AECEEBD7B5E1C47AC99597CBACAEDFBEACE0C1
        DBEDE539A95F16A04248B067B9E2CC68B481007309006B006AB383DAFCF987D6
        AECEEBD7B5E1C4FFFFFFFFFFFF75C7918EC7A4AFE0BFAEE0C1C5E3D083CC9B86
        CD9FB6E2C8F2FFFFDFF8F36BB48151A16053A368C6EEE48AD9B1CEEBD7AFDFBF
        75C7918EC7A4AFE0BFAEE0C1C5E3D083CC9B86CD9FB6E2C8F2FFFFDFF8F36BB4
        8151A16053A368C6EEE48AD9B1CEEBD7AFDFBFFFFFFFFFFFFF6DC48B82C19BAE
        E0BEB6E2C6FFFFFFFFFFFFFFFFFFFDFFFFF0FFFEEEFFFFF3FFFFEEFFFFE7FFFF
        E1FFFE8CDAB3CEEBD6AEDEBE6DC48B82C19BAEE0BEB6E2C6FFFFFFFFFFFFFFFF
        FFFDFFFFF0FFFEEEFFFFF3FFFFEEFFFFE7FFFFE1FFFE8CDAB3CEEBD6AEDEBEFF
        FFFFFFFFFF6AC3897DBF96B5E2C46EC3889DD8B198D7AF95D6AD92D6AD8FD6AB
        8CD4AA89D4A985D4A883D3A785D5AA56C080D3EDDBAEDEBE6AC3897DBF96B5E2
        C46EC3889DD8B198D7AF95D6AD92D6AD8FD6AB8CD4AA89D4A985D4A883D3A785
        D5AA56C080D3EDDBAEDEBEFFFFFFFFFFFF6AC38878BD94FFFFFFE2F2E6DCF1E3
        DCF0E2DBF0E2DBF0E2DBF0E1DBF0E2DCF0E2DDF0E2DEF1E3DFF1E4E4F3E8FFFF
        FFAEDEBF6AC38878BD94FFFFFFE2F2E6DCF1E3DCF0E2DBF0E2DBF0E2DBF0E1DB
        F0E2DCF0E2DDF0E2DEF1E3DFF1E4E4F3E8FFFFFFAEDEBFFFFFFFFFFFFF68C285
        1D954357B2795CB57C63B88270BE8D7AC29581C59A85C79D84C79D80C59A7AC2
        946FBD8C61B7815BB47B55B17735A85E68C2851D954357B2795CB57C63B88270
        BE8D7AC29581C59A85C79D84C79D80C59A7AC2946FBD8C61B7815BB47B55B177
        35A85EFFFFFFFFFFFFD1ECDAA0D7AE99D7AD99D6AD9CD8B0A1D9B4A5DBB7A6DC
        B8A6DCB8A4DAB59ED9B298D6AD90D3A585CE9D80CD9980CD998ED2A4D1ECDAA0
        D7AE99D7AD99D6AD9CD8B0A1D9B4A5DBB7A6DCB8A6DCB8A4DAB59ED9B298D6AD
        90D3A585CE9D80CD9980CD998ED2A4FFFFFF}
      NumGlyphs = 2
      TabOrder = 4
      Visible = False
      OnClick = BtnExp1Click
    end
  end
  object AdvGridExcelIO1: TAdvGridExcelIO
    AdvStringGrid = sg
    Options.ExportOverwrite = omAlways
    Options.ExportOverwriteMessage = 'File %s already exists'#13'Ok to overwrite ?'
    Options.ExportWordWrapped = True
    Options.ExportRawRTF = False
    Options.ExportShowInExcel = True
    Options.ExportHardBorders = True
    Options.ExportCellMargins = True
    UseUnicode = False
    GridStartRow = 0
    GridStartCol = 0
    Version = '3.13'
    Left = 357
    Top = 65
  end
  object pm1: TPopupMenu
    Left = 352
    Top = 126
    object MenuItem1: TMenuItem
      Caption = 'Export to Excel'
      OnClick = BtnExp1Click
    end
  end
end
