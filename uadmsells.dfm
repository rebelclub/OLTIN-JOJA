object sellForm: TsellForm
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu]
  Caption = #1055#1088#1086#1076#1072#1078#1080' '#1089' '#1089#1086#1073#1086#1081
  ClientHeight = 662
  ClientWidth = 1080
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
  OnKeyDown = FormKeyDown
  OnKeyPress = FormKeyPress
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 673
    Height = 662
    Align = alLeft
    Caption = 'Panel1'
    ShowCaption = False
    TabOrder = 0
    object rgOtdels: TAdvOfficeRadioGroup
      Left = 1
      Top = 1
      Width = 671
      Height = 87
      CaptionPosition = cpTopCenter
      Version = '1.4.1.1'
      Align = alTop
      Caption = #1054#1090#1076#1077#1083#1099
      Font.Charset = RUSSIAN_CHARSET
      Font.Color = clWindowText
      Font.Height = -15
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentBackground = False
      ParentFont = False
      TabOrder = 1
      OnClick = rgOtdelsClick
      Columns = 4
      ItemIndex = 0
      Items.Strings = (
        #1063#1086#1081'-'#1053#1086#1085' (F1)'
        #1052#1080#1083#1083#1080#1081' (F2)'
        #1050#1072#1083#1100#1103#1085' (F3)'
        #1059#1081#1075#1091#1088' (F4)'
        #1064#1072#1096#1083#1080#1082' (F5)'
        #1041#1072#1088' (F6)'
        #1057#1072#1083#1072#1090' (F7)'
        #1052#1072#1075#1072#1079#1080#1085' (F8)')
      ButtonVertAlign = tlCenter
      Ellipsis = False
    end
    object Panel3: TPanel
      Left = 1
      Top = 609
      Width = 671
      Height = 52
      Align = alBottom
      Caption = 'Panel3'
      ShowCaption = False
      TabOrder = 2
      object BtnCancel: TsButton
        Left = 568
        Top = 6
        Width = 94
        Height = 40
        Cancel = True
        Caption = #1054#1090#1084#1077#1085#1072
        Font.Charset = RUSSIAN_CHARSET
        Font.Color = clBlack
        Font.Height = -16
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ModalResult = 2
        ParentFont = False
        TabOrder = 0
        SkinData.CustomFont = True
        SkinData.ColorTone = clWindow
      end
      object addBtn: TsButton
        Left = 26
        Top = 6
        Width = 75
        Height = 40
        Caption = '+'
        Font.Charset = RUSSIAN_CHARSET
        Font.Color = clWhite
        Font.Height = -32
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 1
        OnClick = addBtnClick
        SkinData.CustomFont = True
        SkinData.ColorTone = clLime
      end
      object decBtn: TsButton
        Left = 128
        Top = 6
        Width = 75
        Height = 40
        Caption = '-'
        Font.Charset = RUSSIAN_CHARSET
        Font.Color = clWhite
        Font.Height = -32
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 2
        OnClick = decBtnClick
        SkinData.CustomFont = True
        SkinData.ColorTone = clYellow
      end
    end
    object sg: TAdvStringGrid
      Left = 1
      Top = 129
      Width = 671
      Height = 480
      Cursor = crDefault
      Align = alClient
      DrawingStyle = gdsClassic
      Font.Charset = RUSSIAN_CHARSET
      Font.Color = clWindowText
      Font.Height = -15
      Font.Name = 'Arial'
      Font.Style = []
      Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goRowSelect]
      ParentFont = False
      PopupMenu = pm1
      ScrollBars = ssBoth
      TabOrder = 0
      HoverRowCells = [hcNormal, hcSelected]
      OnGetCellColor = sgGetCellColor
      OnDblClickCell = sgDblClickCell
      ActiveCellFont.Charset = RUSSIAN_CHARSET
      ActiveCellFont.Color = clWindowText
      ActiveCellFont.Height = -15
      ActiveCellFont.Name = 'Arial'
      ActiveCellFont.Style = []
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
      FixedRowHeight = 22
      FixedFont.Charset = RUSSIAN_CHARSET
      FixedFont.Color = clWindowText
      FixedFont.Height = -15
      FixedFont.Name = 'Arial'
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
      SortSettings.DefaultFormat = ssAutomatic
      SortSettings.Show = True
      Version = '8.1.3.0'
    end
    object Panel7: TPanel
      Left = 1
      Top = 88
      Width = 671
      Height = 41
      Align = alTop
      TabOrder = 3
      object edit1: TsEdit
        Left = 11
        Top = 5
        Width = 462
        Height = 31
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -19
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
        TabOrder = 0
        OnChange = edit1Change
        OnClick = edit1Click
      end
      object btnSearch: TsBitBtn
        Left = 490
        Top = 3
        Width = 60
        Height = 33
        Font.Charset = RUSSIAN_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Arial'
        Font.Style = []
        Glyph.Data = {
          96090000424D9609000000000000360000002800000018000000190000000100
          2000000000006009000000000000000000000000000000000000FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF007A7C
          80007B7C80007A7C7F00797B7F00797B7F00797B7F00797B7F00797B7F00797B
          7F00797B7F00797B7F00797B7F00797B7F00797B7F007A7C80007A7C80007476
          7B007273790067696F40636263807480813D68D3E49452E0F358FFFFFF007A7C
          80007B7C80007A7C7F00797B7F00797B7F00797B7F00797B7F00797B7F00797B
          7F00797B7F00797B7F00797B7F00797B7F00797B7F007A7C80007B7D80007577
          7C0562646A77686A65E2666581BC3A46CCD3479CDFFF43C3E7A0FFFFFF007A7C
          80007B7C80007A7C7F00797B7F00797B7F00797B7F00797B7F00797B7F00797B
          7F00797B7F00797B7F00797B7F00797B7F00797B7F007B7D8100787A7F116061
          68A0646661FF646580DE3F41D6EF130FCEFF0A34ADA543A7DE0BFFFFFF007A7C
          80007B7C80007A7C7F00797B7F00797B7F00797B7F00797B7F00797B7F00797B
          7F00797B7F00797B7F00797B7F00797B7F007A7C8000797C7F185F6167B76467
          62FF616383D45E61D9EC393CCDFF00008DBE081A9E0E1D62BD00FFFFFF007A7C
          80007B7C80007A7C7F00797B7F00797B7F00797B7F007A7C80007A7D80007B7D
          81007B7D81007B7D81007A7C7F00797B7F00787A7F145F6268BF676965FF6567
          83BE6265D9E44345CDFF000088C7000087140A179C002366BE00FFFFFF007A7C
          80007B7C80007A7C7F00797B7F007C7C80007F7B7C1C7B74744A736B6C716A66
          6A86716E70887473777A797B7F477A7C802062646BAB696B67F9686982A44F52
          D3D94B4ED1FF000088CB0022A119003BB000064DBE001781D400FFFFFF007A7C
          80007B7C80007B7C80007E7577396C6D729F456A81E1236D98FE268CADFF5492
          A6FF204962FF31424EFF53585EEC696568D86D6B6AF86D6C81972E30CECB2628
          D3FF000086CC0020A11D00AEF80000C8FF0000C2FF0000BEFF00FFFFFF007A7C
          80007E7C7F0079737770428597F10E98CFFF0E99E3FF2EB2F0FF4BDFFFFF5EC8
          E5FF126A93FF134F6AFF0E3346FF26546EFF637D81E8313DCDDB0B09DCFF0000
          8ECD0024A41C00A8F30000CAFF0500C3FF0000C4FF0000C4FF00FFFFFF007C7B
          7F007676796C3DAEB6FF03C6E8FF0BC8F0FF3FE3F8FF98FBFCFFA9FBF9FE65CD
          E0FF1D90B5FF1298C7FF189CC4FF2CA2C4FF1B84B9FF197DDBFF2431A0BD372C
          7D1A0C57BE0000C7FF0000C2FF0000C4FF0000C4FF0000C4FF00FFFFFF007873
          77385BB2B4F31BD6EAFF06D2F3FF4BDEF3FAA5DCE1EFDFD9D3E5F0CCC4DCF3CF
          C6E1DBC8C6EAA5B8C3F24BB8DFFD17CFFBFF38C2EAFF2884AFFE6C7675627E7B
          7D00737B84000CB2F00000C7FF0000C7FF0000C7FF0000C7FF00FFFFFF008297
          98AB3DB8D0FF03B4EAFF7CD7E6F2F1E0D4E8FFE1D4DBFFD0C8C6FFC9C1BDFFCB
          C3C4FFCAC5CEFFC7C5D4FEC4C3DE9BC4DAF316C7F5FF35CDF5FF47738DBA7F7A
          7A05817C7C00628A9B001FB2E1001EB5E2001EB4E2001EB4E200FFFFFF0064AC
          BCEF019BCFFF74BFD1F2FFE7D7E8FFE2D9D2FFCFC7A9FFDCCD98FFE7D398FFE9
          D6A3FFE2D5B2FFD0CFBDFFC8CCCBFFC9C8DA94C3D4F00CADE1FF2C98CCEE7172
          77217D7979007E7675007F7574007F7574007F7574007F757400FFFFFF0014A2
          D3FF28AFD4FCEEDFCEEBFFE8DED6FFD4CA9CFFF1DA85FFFDE27CFFFFE481FFFF
          E491FFFEE3A0FFF2DDACFFDAD5B8FFE8E4DCF6C8CCDD50B8CFF90F8FBFFF4E71
          875357697600556A7800556A7800556A7800556A7800556A7800FFFFFF000098
          CDFF86BDC9F9FFEFDDEBFFDBCFACFFF4DC84FFFFE676FFFFE774FFFFE77CFFFF
          E78DFFFFE79CFFFFE6A4FFF6DEA8FFE0D4BAFFBCBFD8A3C3CBF532B4CCFF3579
          977F30698B00306C8D00306C8D00306C8D00306C8D00306C8D00FFFFFF0018B9
          D4FFB9CDC6FEFFEBDADDFFE7D195FFFFE67EFFFFE772FFFFE770FFFFE779FFFF
          E788FFFFE797FFFFE69CFFFFE7A5FFF7EDD2FFB8B8E2C5A8B3F597FFFFFF659E
          B28F195E81002165860021658600216586002165860021658600FFFFFF0046B2
          C0FFBCCAC0FFFFE8D4DDFFF2D490FFFFE87CFFFFE771FFFFE76EFFFFE775FFFF
          E782FFFFE78CFFFFE690FFFFF5BFFFFFFFF4FFE9DFFAD4ABB8F19AFFFFFF81AC
          B28F285D6A003165720031657200316572003165720031657200FFFFFF0045B4
          CDFFB9B9B5FFFEDBC6F6FCEAC6A7FFFFE679FFFFE973FFFFE871FFFFE875FFFF
          E979FFFFE979FFFFEA86FFFFFADDFFFFF8FBFFF9EBF9CFA0B3EC40D4E9FF2AA4
          B87D1B7C92001D8197001D8197001D8197001D8197001D819700FFFFFF001CB0
          D1FD80A1B4FFFFD3BCFFDEBFA1EDEDE7C0B2F9F7D68FFDFDDF82FEFDE180FBF9
          DC80F0EDCE88DBD7B7A8D8C9AEDDF8E3D0F0FFE0DBE87B6A89ED09ADD2FF0693
          B8470684AB000686AC000686AC000686AC000686AC000686AC00FFFFFF0008B4
          DAC113587BFFDBBDB1F5F2BFA6FDD0B498FACDC3A2E9D1CAA9DDD3CCACD3CDC5
          A4D0D7D4BCE0DFDDCAECE7C9ABD2FFBBAAC1E193A4D01E5B8CFF09A6D0D51189
          AC0B108AAF00108AAF00108AAF00108AAF00108AAF00108AAF00FFFFFF0003B1
          E43E007A9BFB3C566AFDECBAA9F0FEBAA0E8F5CCA9CFF0DEB2BAEEE6B6B5F0EF
          D3D3FEFFFAECFFFFFFE9FFFFF8E1F0B8BBCC43486AF10072A3FF1789AC511B82
          A1001A83A3001A83A2001A83A2001A83A2001A83A2001A83A200FFFFFF00009C
          D000009DC96C00688BFF3C677AFFEDB0A6F0FFBBAAE5FFE0C6D0FFF3D1B1FFF1
          E0BAFFFBF7D6FFF1EFDDE5CBD1E1384059F9005B83FF128EB380197D9D00187F
          A000187EA000187EA000187EA000187EA000187EA000187EA000FFFFFF00009E
          D100008DBC00008AB85C127A9AE6C9DEE5FFFFE9E6FFC8A8ABFBA68182F0A86A
          66DA7F5055E1C3AFB3F7788B98FF086380F132B9D96B1A7F9D00187E9F00187F
          A000187FA000187FA000187FA000187FA000187FA000187FA000FFFFFF00009E
          D100008DBB000083AF000087B51E1489B18462B9D2D44294A9F5003848FF0C26
          2BFF244048F970A7B2DA5BB5C98C56C7DF2548BAD500177D9B00187F9F00187F
          A000187FA000187FA000187FA000187FA000187FA000187FA000FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00}
        ParentFont = False
        TabOrder = 1
        OnClick = btnSearchClick
        SkinData.ColorTone = clFuchsia
      end
      object btnSMS: TsBitBtn
        Left = 558
        Top = 3
        Width = 60
        Height = 33
        Font.Charset = RUSSIAN_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Arial'
        Font.Style = []
        Glyph.Data = {
          96090000424D9609000000000000360000002800000018000000190000000100
          2000000000006009000000000000000000000000000000000000FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF003880D8740773
          E69A0074E99D0274E89C0374E89C0374E89C0374E89C0374E89C0374E89C0374
          E89C0374E89C0374E89C0374E89C0374E89C0374E89C0374E89C0374E89C0374
          E89C0374E89C0374E89C0374E89C0374E89C0375E99C0675E790036DE0E60477
          E4FF028FF3FF0195F8FF0093F6FF0092F6FF0092F6FF0092F6FF0092F6FF0092
          F6FF0092F6FF0092F6FF0092F6FF0092F6FF0092F6FF0092F6FF0092F6FF0092
          F6FF0092F6FF0092F6FF0093F6FF0195F7FF0390F2FF0476E4FC0279EBDB027C
          EEFD0485E4FF04ADF2FF02BCFBFF00B8FAFF00B7F9FF00B7F9FF00B7F9FF00B7
          F9FF00B7F9FF00B7F9FF00B7F9FF00B7F9FF00B7F9FF00B7F9FF00B7F9FF00B7
          F9FF00B7F9FF00B8FAFF01BBFAFF04ABF1FF0481E3FF017BEDED037EEADB008C
          F5FD0087F1FF048BE4FF0CB3EDFF10CDFBFF0ECBFCFF0DC8FAFF0EC8FAFF0EC8
          FAFF0EC8FAFF0EC8FAFF0EC8FAFF0EC8FAFF0EC8FAFF0EC8FAFF0EC8FAFF0DC7
          FAFF0ECBFCFF0FCDFAFF0CB3EEFF0488E4FF0186F1FF0088F4ED0283EADB0090
          F6FD0197F8FF0095F6FF0691E7FF1FB2EBFF30D4FBFF2DD5FEFF2BD1FCFF2BD1
          FCFF2BD1FCFF2CD1FCFF2CD2FCFF2BD1FCFF2BD1FCFF2BD1FCFF2BD1FCFF2ED5
          FEFF2FD2FAFF1DB1EBFF0490E7FF0094F6FF0093F6FF008EF4ED028AEBDB0098
          F7FD009DF7FF00A4F8FF00A5F8FF059DEBFF2EB3E9FF54DAF9FF52DFFFFF4ED9
          FCFF52DDFDFF52DDFDFF4AD5FBFF51DCFDFF52DDFDFF4ED9FCFF54DFFFFF52D7
          F8FF2BB1E9FF039BEBFF00A5F8FF01A1F8FF009AF6FF0195F5ED0291ECDB00A0
          F7FD00A5F8FF01AAF7FF00AFF8FF00B3FAFF03AAEFFF33B3E8FF77DDF6FF81EC
          FFFF5FCCF5FF2C9CE7FF2395E8FF2B9BE7FF60CDF5FF83EDFFFF74DBF6FF30B3
          E7FF00AAEEFF00B4FBFF01AEF8FF00A7F7FF00A2F7FF019DF6ED0298EDDB00A9
          F8FD01AEF8FF00B2F9FF00B6F9FF00BBFAFF00BFFBFF06BDF6FF37BAEAFF65B6
          E3FF34A0E2FF41C4F4FF4BD4FAFF40C4F3FF37A1E1FF63B6E2FF3ABCEAFF05BD
          F5FF00C0FBFF00BAF9FF00B5F8FF01AFF8FF01AAF8FF00A5F7ED029FEEDB01B1
          F9FD01B5F9FF00B8F9FF00BCF9FF00BFF9FF0ECDFEFF1CCEFAFF20A7E0FF3D9B
          D7FF7CE4FCFF7CE6FFFF79E2FDFF7DE8FFFF7AE2FAFF3C9CD7FF25A9E2FF22D0
          FCFF0DCCFEFF00BFF9FF00BCF9FF00B7F9FF01B2F9FF01ACF8ED02A6EEDB00B8
          F9FD00BCF9FF00BEFAFF04C2FAFF19D2FFFF2ACDF6FF33A6D8FF63ADD7FFAAF3
          FEFFA8F0FFFFA5ECFEFFA5EDFEFFA5ECFEFFAAF2FFFFA7EEFDFF61ACD8FF32A5
          DAFF2BCFF9FF16D1FFFF01C1F9FF00BDFAFF00B9F9FF00B4F9ED02ADEEDB00BF
          FBFD02C3FBFF0DC8FAFF2AD9FFFF3BCDF3FF41A2D1FF74B6D9FFB4F7FFFFADF2
          FFFFA9EFFEFFAAEFFEFFAAEFFEFFAAEFFEFFA9EFFEFFAFF4FFFFB1F4FEFF73B5
          D9FF3EA1D2FF38D0F6FF21D5FFFF06C3FAFF00BFFAFF00BBF9ED02B3EEDB08C6
          FCFD19CDFBFF3CDEFFFF4FCEF0FF48A5D2FF62BEE1FF87F0FFFF80E8FFFF7EE6
          FDFF7EE6FDFF7EE6FDFF7EE6FDFF7EE6FDFF7EE6FDFF7EE5FDFF81EAFFFF85EC
          FFFF60BCE0FF40A1D1FF48D0F4FF2DD8FFFF0DC7FBFF01C2FAED13BBEFDB2AD2
          FCFD51E3FFFF68D2EFFF43A9D6FF36BFE9FF41DFFFFF3FD9FDFF3ED8FCFF3ED8
          FCFF3ED8FCFF3ED8FCFF3ED8FCFF3ED8FCFF3ED8FCFF3ED8FCFF3ED8FCFF3FDB
          FEFF40DEFFFF37C0E9FF3CA6D5FF58D2F2FF39DCFFFF19CCFBED3AC6F1DA6AE9
          FFFD77D4EDFF30AADCFF09BAF1FF09CCFEFF0BC8FAFF0BC7FAFF0BC7FAFF0BC7
          FAFF0BC7FAFF0BC7FAFF0BC7FAFF0BC7FAFF0BC7FAFF0BC7FAFF0BC7FAFF0BC7
          FAFF0CC8FBFF0ACBFEFF0BBCF0FF2DA8DAFF66D4F0FF4DDFFFED75DAF3DC85D6
          ECFE2AA1E2FF01A5F4FF00AEFAFF00ABF8FF00ABF8FF00ABF8FF00ABF8FF00AB
          F8FF00ABF8FF00ABF8FF00ABF8FF00ABF8FF00ABF8FF00ABF8FF00ABF8FF00AB
          F8FF00ABF8FF00ACF8FF00ADFAFF03A6F4FF259FE1FF6CD2EEED83C2E4DE218B
          E4FE0184F1FF0087F4FF0187F2FF0187F2FF0187F2FF0187F2FF0187F2FF0187
          F2FF0187F2FF0187F2FF0187F2FF0187F2FF0187F2FF0187F2FF0187F2FF0187
          F2FF0187F2FF0187F2FF0187F2FF0087F4FF0386F2FF1987E4F7FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00}
        ParentFont = False
        TabOrder = 2
        OnClick = btnSMSClick
        SkinData.ColorTone = clFuchsia
      end
      object chkAvail: TsCheckBox
        Left = 633
        Top = 12
        Width = 15
        Height = 15
        Checked = True
        State = cbChecked
        TabOrder = 3
        OnClick = chkAvailClick
      end
    end
  end
  object Panel2: TPanel
    Left = 673
    Top = 0
    Width = 407
    Height = 662
    Align = alClient
    Caption = 'Panel2'
    ShowCaption = False
    TabOrder = 1
    object Panel4: TPanel
      Left = 1
      Top = 1
      Width = 405
      Height = 40
      Align = alTop
      Caption = 'Panel4'
      ShowCaption = False
      TabOrder = 0
      object lblTime: TStaticText
        AlignWithMargins = True
        Left = 243
        Top = 9
        Width = 158
        Height = 27
        Margins.Top = 8
        Align = alRight
        Alignment = taCenter
        Anchors = [akLeft, akTop, akRight, akBottom]
        Caption = '13.12.2016 15:21'
        Font.Charset = RUSSIAN_CHARSET
        Font.Color = clWindowText
        Font.Height = -19
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 0
      end
      object lblSchet: TStaticText
        AlignWithMargins = True
        Left = 4
        Top = 9
        Width = 155
        Height = 27
        Margins.Top = 8
        Margins.Right = 5
        Align = alLeft
        Alignment = taCenter
        Caption = #1057#1095#1077#1090' "'#1057'  '#1089#1086#1073#1086#1081'"'
        Color = clYellow
        Font.Charset = RUSSIAN_CHARSET
        Font.Color = clYellow
        Font.Height = -19
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentColor = False
        ParentFont = False
        TabOrder = 1
      end
    end
    object Panel5: TPanel
      Left = 1
      Top = 609
      Width = 405
      Height = 52
      Align = alBottom
      Caption = 'Panel5'
      ShowCaption = False
      TabOrder = 1
      object summLbl: TGradientLabel
        Left = 86
        Top = 14
        Width = 187
        Height = 27
        Alignment = taRightJustify
        AutoSize = False
        Caption = '250 000 '#1089#1091#1084
        Color = clWhite
        Font.Charset = RUSSIAN_CHARSET
        Font.Color = clBlack
        Font.Height = -24
        Font.Name = 'Arial'
        Font.Style = [fsItalic]
        ParentColor = False
        ParentFont = False
        Layout = tlCenter
        EllipsType = etNone
        GradientType = gtFullHorizontal
        GradientDirection = gdLeftToRight
        Indent = 10
        Orientation = goHorizontal
        TransparentText = False
        VAlignment = vaTop
        Version = '1.2.0.1'
      end
      object StaticText2: TStaticText
        Left = 13
        Top = 18
        Width = 67
        Height = 26
        Caption = #1042#1089#1077#1075#1086':'
        Font.Charset = RUSSIAN_CHARSET
        Font.Color = clWindowText
        Font.Height = -19
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 0
      end
      object okBtn: TsButton
        Left = 296
        Top = 4
        Width = 93
        Height = 44
        Caption = 'OK'
        Default = True
        Font.Charset = RUSSIAN_CHARSET
        Font.Color = clWhite
        Font.Height = -19
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 1
        OnClick = okBtnClick
        SkinData.CustomFont = True
        SkinData.ColorTone = clAqua
      end
    end
    object sgOrder: TAdvStringGrid
      Left = 1
      Top = 41
      Width = 405
      Height = 522
      Cursor = crDefault
      Align = alClient
      DrawingStyle = gdsClassic
      Font.Charset = RUSSIAN_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'Tahoma'
      Font.Style = []
      Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goRowSelect]
      ParentFont = False
      ScrollBars = ssBoth
      TabOrder = 2
      OnKeyDown = sgOrderKeyDown
      HoverRowCells = [hcNormal, hcSelected]
      OnGetCellColor = sgOrderGetCellColor
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
      SortSettings.Column = 1
      SortSettings.Show = True
      Version = '8.1.3.0'
      RowHeights = (
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
    end
    object Panel6: TPanel
      Left = 1
      Top = 563
      Width = 405
      Height = 46
      Align = alBottom
      Caption = 'Panel6'
      ShowCaption = False
      TabOrder = 3
      object lblSumm2: TLabel
        Left = 264
        Top = 11
        Width = 7
        Height = 25
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -21
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
      end
      object addBtn2: TsButton
        Left = 15
        Top = 2
        Width = 75
        Height = 40
        Caption = '+'
        Font.Charset = RUSSIAN_CHARSET
        Font.Color = clWhite
        Font.Height = -32
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 0
        OnClick = addBtn2Click
        SkinData.CustomFont = True
        SkinData.ColorTone = clLime
      end
      object decBtn2: TsButton
        Left = 119
        Top = 2
        Width = 75
        Height = 40
        Caption = '-'
        Font.Charset = RUSSIAN_CHARSET
        Font.Color = clWhite
        Font.Height = -32
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 1
        OnClick = decBtn2Click
        SkinData.CustomFont = True
        SkinData.ColorTone = clYellow
      end
    end
  end
  object pm1: TPopupMenu
    Left = 457
    Top = 305
    object N1: TMenuItem
      Caption = #1055#1088#1080#1093#1086#1076
      OnClick = N1Click
    end
  end
end
