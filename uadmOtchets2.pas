unit uadmOtchets2;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, AdvUtil, Vcl.StdCtrls, Vcl.Buttons,System.DateUtils,
  Vcl.Grids, AdvObj, BaseGrid, AdvGrid, tmsAdvGridExcel, Vcl.ExtCtrls, Vcl.Menus, Printers,
  sCheckBox, ExcelXP, ComObj, ShellApi, sBitBtn, sEdit;

type
  TotchetForm2 = class(TForm)
    sg1: TAdvStringGrid;
    Splitter1: TSplitter;
    sg2: TAdvStringGrid;
    chkAll: TsCheckBox;
    chkOtkazInf: TsCheckBox;
    edit1: TsEdit;
    pm1: TPopupMenu;
    MenuItem1: TMenuItem;
    E1: TMenuItem;
    AdvGridExcelIO1: TAdvGridExcelIO;
    pm2: TPopupMenu;
    ExporttoExcel1: TMenuItem;
    Excel1: TMenuItem;
    AdvGridExcelIO2: TAdvGridExcelIO;
    procedure FormActivate(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure Redaraw1;
    procedure RedrawAll;
    procedure RedrawWithUser;
    procedure CorrectCol;
    procedure chkAllClick(Sender: TObject);
    procedure sg1SelectionChanged(Sender: TObject; ALeft, ATop, ARight,
      ABottom: Integer);
    procedure chkOtkazInfClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure MenuItem1Click(Sender: TObject);
    procedure ExporttoExcel1Click(Sender: TObject);
    procedure edit1KeyPress(Sender: TObject; var Key: Char);
    procedure PrintGrid1(Grid: TStringGrid);
    procedure E1Click(Sender: TObject);
    procedure Excel1Click(Sender: TObject);
  private
    a:Integer;
    { Private declarations }
  public
    dBeg:TDateTime;
    dEnd:TDateTime;
    { Public declarations }
  end;

var
  otchetForm2: TotchetForm2;
  sBeg,sEnd,userid,sf,sOrder,sTable:string;

implementation

{$R *.dfm}

uses uadmdb, uadmconsts, uadmmain;

procedure TotchetForm2.FormActivate(Sender: TObject);
begin
  sg1.cells[0,0]:='—   '+DateTimeToStr(dBeg)+'     ƒÓ  '+DateTimeToStr(dEnd);
  sg1.FontSizes[0,0] := 10;
  sg1.Alignments[0,0]:=taCenter;
  sg1.Alignments[1,1]:=taCenter;
  sg1.Alignments[2,1]:=taCenter;
  sg1.Alignments[3,1]:=taCenter;
  sg1.Alignments[4,1]:=taCenter;
  sg2.Alignments[0,0]:=taCenter;
  if currUser=Admin then begin sTable:='TMOVESARCH';  sOrder:='TORDERSARCH'; end
  else                   begin sTable:='TMOVES';      sOrder:='TORDERS'; end;
  sBeg:=QS(DateTimeToStr(dBeg));  sEnd:=QS(DateTimeToStr(dEnd));
  sf:=' AND o.OPENED>='+sBeg+' AND o.OPENED<='+sEnd;

 sg1.cells[4,1]:='”ÒÎÛ„‡ 7%';  edit1.Text:='';
  Redaraw1;  RedrawAll;
end;

procedure TotchetForm2.FormCreate(Sender: TObject);
begin
  with sg1 do
  begin
    ColCount:=5;RowCount:=3;
    MergeCells(0, 0, 5, 1);
    cells[0,1]:='id';ColWidths[0]:=0;
    cells[1,1]:='π';ColWidths[1]:=30;
    cells[2,1]:='ŒÙËˆË‡ÌÚ';ColWidths[2]:=190;
    cells[3,1]:='”ÒÎÛ„‡ 10%';ColWidths[3]:=85;
    cells[4,1]:='”ÒÎÛ„‡ 7%';ColWidths[4]:=85;
  end;
  with sg2 do
  begin
    ColCount:=6; RowCount:=3;
    sg2.MergeCells(0, 0, 6, 1);
    cells[0,1]:='π';ColWidths[0]:=40;
    cells[1,1]:='¡Î˛‰Ó';ColWidths[1]:=130;
    cells[2,1]:=' ÓÎ-‚Ó';ColWidths[2]:=50;
    cells[3,1]:='÷ÂÌ‡';ColWidths[3]:=50;
    cells[4,1]:='—ÛÏÏ‡';ColWidths[4]:=50;
    cells[5,1]:='»Ïˇ';ColWidths[5]:=70;
  end;
end;

procedure TotchetForm2.Redaraw1;
var cRow,userid:Integer;
    allWsumm,wsumm:Double;
begin
  sg1.RowCount:=3;    sg1.Rows[2].Clear;    cRow:=1;
  with dm.qtemp do
  begin
    SQL.Text:='select u.userid,u.usernaim,sum(o.WSUMM) as SUMMA from tusers u '+
        'join '+sOrder+' o on o.userid=u.userid '+sf+' group by u.userid,u.usernaim';
    Active:=False;    Active:=True;    First;     cRow:=1;
    while not Eof do
    begin
      wsumm:=FieldByName('SUMMA').AsFloat;
      userid:=FieldByName('USERID').AsInteger;
//      if userid>1 then
      begin
        sg1.Cells[0,cRow+1]:=I2S(userid);
        sg1.Cells[1,cRow+1]:=I2S(cRow);
        sg1.Cells[2,cRow+1]:=FieldByName('USERNAIM').AsString;
        sg1.Cells[3,cRow+1]:=FormatFloat('###,###,##0.##',wsumm);
        sg1.Cells[4,cRow+1]:=FormatFloat('###,###,##0.##',Round(wsumm*0.7));
        allWsumm:=allWsumm+wsumm;
        cRow:=cRow+1; sg1.RowCount:=cRow+2;
      end;
       Next;
    end;
  end;
  sg1.Cells[2,sg1.RowCount-1]:='∆¿Ã»:'; sg1.Alignments[2,sg1.RowCount-1]:=taRightJustify;
  sg1.Cells[3,sg1.RowCount-1]:=FormatFloat('###,###,##0.##',allWsumm);
  sg1.Cells[4,sg1.RowCount-1]:=FormatFloat('###,###,##0.##',Round(allWsumm*0.7));
end;

procedure TotchetForm2.RedrawAll;
var
  price, cRow, otdelid: Integer;
  currOtdelName, lastOtdelName, s: string;
  summ: Double;

  procedure EnsureRow(ARow: Integer);
  begin
    if sg2.RowCount <= ARow then
      sg2.RowCount := ARow + 1;
  end;

begin
  sg2.RowCount := 3;
  sg2.Rows[2].Clear;

  cRow := 1; // yozish boshlanadigan indeks uchun baza
  sg2.Cells[0,0] := '¬ÒÂ ‡·ÓÚÌËÍË';
  lastOtdelName := '';

  if chkAll.Checked then
  begin
    chkOtkazInf.Checked := False;
    s := 'SELECT b.NAIM, sum(m.kolvo) as KOLVO, m.price, '+
         'sum(m.kolvo*m.price) as SUMM, t.userid, t.usernaim, b.OTDELID '+
         ' FROM TBLUDS b '+
         ' JOIN ' + sTable + ' m ON b.bludid = m.bludid '+
         ' JOIN tusers t ON m.suserid = t.userid '+
         ' JOIN ' + sOrder + ' o ON m.ALLORDERID = o.ALLORDERID '+
         ' WHERE m.suserid > 0 ' + sf +
         ' GROUP BY b.NAIM, m.price, t.userid, t.usernaim, b.OTDELID '+
         ' ORDER BY b.OTDELID, b.NAIM';
  end
  else if chkOtkazInf.Checked then
  begin
    chkAll.Checked := False;
    s := 'SELECT b.NAIM, sum(m.kolvo) as KOLVO, m.price, '+
         'sum(m.kolvo*m.price) as SUMM, t.userid, t.usernaim, b.OTDELID '+
         ' FROM TBLUDS b '+
         ' JOIN ' + sTable + ' m ON b.bludid = m.bludid AND m.kolvo < 0 '+
         ' JOIN tusers t ON m.suserid = t.userid '+
         ' JOIN ' + sOrder + ' o ON m.ALLORDERID = o.ALLORDERID '+
         ' WHERE m.suserid > 0 ' + sf +
         ' GROUP BY b.NAIM, m.price, t.userid, t.usernaim, b.OTDELID '+
         ' ORDER BY b.OTDELID, b.NAIM';
  end
  else Exit;

  with dm.qtemp do
  begin
    Active := False;
    SQL.Text := s;
    Active := True;
    First;

    while not Eof do
    begin
      otdelid := FieldByName('OTDELID').AsInteger;
      currOtdelName := OTDELSNAIM[otdelid];

      // Otdel sarlavhasi
      if currOtdelName <> lastOtdelName then
      begin
        EnsureRow(cRow+1);
        sg2.Cells[1, cRow+1] := currOtdelName;
        sg2.Alignments[1, cRow+1] := taCenter;
        sg2.MergeCells(1, cRow+1, 5, 1);
        sg2.FontStyles[1, cRow+1] := [fsBold];
        Inc(cRow);
        lastOtdelName := currOtdelName;
      end;

      // Taom qatori
      price := FieldByName('PRICE').AsInteger;
      summ  := FieldByName('SUMM').AsFloat;

      EnsureRow(cRow+1);
      sg2.Cells[0, cRow+1] := I2S(cRow);
      sg2.Cells[1, cRow+1] := FieldByName('NAIM').AsString;
      sg2.Cells[2, cRow+1] := FieldByName('KOLVO').AsString;
      sg2.Cells[3, cRow+1] := FormatFloat('###,###,##0.##', price);
      sg2.Cells[4, cRow+1] := FormatFloat('###,###,##0.##', summ);
      sg2.Cells[5, cRow+1] := FieldByName('USERNAIM').AsString; // bu funksiyada koërsatiladi

      Inc(cRow);
      Next;
    end;
  end;

  // Yakuniy qator sonini kesish: ortiqcha boësh satr boëlmasin
  sg2.RowCount := cRow + 1;
end;

procedure ResetSg2(g: TAdvStringGrid);
begin
  g.BeginUpdate;
  try
    g.Clear;              // barcha kontent/format/merge-larni tozalaydi
    g.ColCount := 6;
    g.RowCount := 3;

    // sarlavha va oëlchamlar (FormCreate dagidek)
    g.MergeCells(0, 0, 6, 1);
    g.Cells[0,1] := 'π';     g.ColWidths[0] := 40;
    g.Cells[1,1] := '¡Î˛‰Ó'; g.ColWidths[1] := 130;
    g.Cells[2,1] := ' ÓÎ-‚Ó';g.ColWidths[2] := 50;
    g.Cells[3,1] := '÷ÂÌ‡';  g.ColWidths[3] := 50;
    g.Cells[4,1] := '—ÛÏÏ‡'; g.ColWidths[4] := 50;
    g.Cells[5,1] := '»Ïˇ';   g.ColWidths[5] := 70;

    g.Alignments[0,0] := taCenter;
  finally
    g.EndUpdate;
  end;
end;

procedure TotchetForm2.RedrawWithUser;
var
  price, cRow, otdelid: Integer;
  sUserId, s, currOtdelName, lastOtdelName, bludName: string;
  summ, totalSumm, deptSumm: Double;

  procedure EnsureRow(ARow: Integer);
  begin
    if sg2.RowCount <= ARow then
      sg2.RowCount := ARow + 1;
  end;

  procedure ClearRow(ARow: Integer);
  var cc: Integer;
  begin
    for cc := 0 to sg2.ColCount-1 do
      sg2.Cells[cc, ARow] := '';
  end;

  // Bo'lim (otdel) bo'yicha SUBTOTAL chiqarish: oxirgi 2 ustunni mergelaymiz (4 va 5)
  procedure PrintDeptSubtotal;
  begin
    EnsureRow(cRow+1);
    ClearRow(cRow+1);
    sg2.Cells[3, cRow+1] := '∆¿Ã»:';
    sg2.Alignments[3, cRow+1] := taRightJustify;

    // qiymatni oxirgi ikki ustunni birlashtirib chiqaramiz
    sg2.Cells[4, cRow+1] := FormatFloat('###,###,##0.##', deptSumm);
    sg2.MergeCells(4, cRow+1, 2, 1);     // 4-ustundan boshlab, 2 ta ustun (—ÛÏÏ‡ + »Ïˇ)
    sg2.Alignments[4, cRow+1] := taRightJustify;

    // ajratish uchun qalin shrift
    sg2.FontStyles[3, cRow+1] := [fsBold];
    sg2.FontStyles[4, cRow+1] := [fsBold];

    Inc(cRow);
    deptSumm := 0; // keyingi boëlim uchun nolga
  end;

begin
  sUserId := sg1.Cells[0, sg1.Row];
  if sUserId = '' then Exit;

  ResetSg2(sg2);  // gridni toza holatga keltirish (sizda mavjud yordamchi)

  sg2.BeginUpdate;
  try
    cRow := 1;
    lastOtdelName := '';
    totalSumm := 0;
    deptSumm := 0;

    // Ofitsant nomi faqat yuqorida bitta marta
    sg2.Cells[0, 0] := sg1.Cells[2, sg1.Row];

    if chkOtkazInf.Checked then
      s := 'SELECT b.NAIM, sum(m.kolvo) as KOLVO, m.price, ' +
           'sum(m.kolvo*m.price) as SUMM, m.suserid, b.OTDELID ' +
           ' FROM TBLUDS b ' +
           ' JOIN ' + sTable + ' m ON b.bludid = m.bludid AND m.kolvo < 0 ' +
           ' JOIN ' + sOrder + ' o ON m.ALLORDERID = o.ALLORDERID ' + sf +
           ' AND m.suserid = ' + sUserId +
           ' GROUP BY b.NAIM, m.price, m.suserid, b.OTDELID ' +
           ' ORDER BY b.OTDELID, b.NAIM'
    else if chkAll.Checked then
      s := 'SELECT b.NAIM, sum(m.kolvo) as KOLVO, m.price, ' +
           'sum(m.kolvo*m.price) as SUMM, m.suserid, b.OTDELID ' +
           ' FROM TBLUDS b ' +
           ' JOIN ' + sTable + ' m ON b.bludid = m.bludid ' +
           ' JOIN ' + sOrder + ' o ON m.ALLORDERID = o.ALLORDERID ' + sf +
           ' AND m.suserid = ' + sUserId +
           ' GROUP BY b.NAIM, m.price, m.suserid, b.OTDELID ' +
           ' ORDER BY b.OTDELID, b.NAIM'
    else
      Exit;

    with dm.qtemp do
    begin
      Active := False;
      SQL.Text := s;
      Active := True;
      First;

      while not Eof do
      begin
        bludName := Trim(FieldByName('NAIM').AsString);
        if bludName = '' then
        begin
          Next;
          Continue; // nomi bo'sh bo'lsa ó oëtkazib yuboramiz
        end;

        otdelid := FieldByName('OTDELID').AsInteger;
        currOtdelName := OTDELSNAIM[otdelid];

        // Yangi bo'lim boshlandi ó oldingi bo'lim uchun SUBTOTAL chiqaramiz
        if (lastOtdelName <> '') and (currOtdelName <> lastOtdelName) then
          PrintDeptSubtotal;

        // Bo'lim sarlavhasi (agar yangisi bo'lsa)
        if currOtdelName <> lastOtdelName then
        begin
          EnsureRow(cRow+1);
          ClearRow(cRow+1);
          sg2.Cells[1, cRow+1] := currOtdelName;
          sg2.MergeCells(1, cRow+1, 5, 1);
          sg2.FontStyles[1, cRow+1] := [fsBold];
          sg2.Alignments[1, cRow+1] := taCenter;
          Inc(cRow);
          lastOtdelName := currOtdelName;
        end;

        // Taom qatori
        price := FieldByName('PRICE').AsInteger;
        summ  := FieldByName('SUMM').AsFloat;

        EnsureRow(cRow+1);
        ClearRow(cRow+1);
        sg2.Cells[0, cRow+1] := I2S(cRow);
        sg2.Cells[1, cRow+1] := bludName;
        sg2.Cells[2, cRow+1] := FieldByName('KOLVO').AsString;
        sg2.Cells[3, cRow+1] := FormatFloat('###,###,##0.##', price);
        sg2.Cells[4, cRow+1] := FormatFloat('###,###,##0.##', summ);
        sg2.Cells[5, cRow+1] := '';  // ofitsant ismi takrorlanmasin

        totalSumm := totalSumm + summ; // umumiy jami
        deptSumm  := deptSumm  + summ; // bo'lim boëyicha jami

        Inc(cRow);
        Next;
      end;
    end;

    // Oxirgi bo'lim uchun SUBTOTAL (agar boëlsa)
    if lastOtdelName <> '' then
      PrintDeptSubtotal;

    // === Umumiy yakuniy jami ===
    EnsureRow(cRow+1);
    ClearRow(cRow+1);
    sg2.Cells[3, cRow+1] := '∆¿Ã»:';
    sg2.Alignments[3, cRow+1] := taRightJustify;

    sg2.Cells[4, cRow+1] := FormatFloat('###,###,##0.##', totalSumm);
    sg2.MergeCells(4, cRow+1, 2, 1);
    sg2.Alignments[4, cRow+1] := taRightJustify;
    sg2.FontStyles[3, cRow+1] := [fsBold];
    sg2.FontStyles[4, cRow+1] := [fsBold];
    Inc(cRow);

    // Yakuniy kesish ó ortiqcha boësh qatordan qutulish
    if cRow + 1 < 3 then
      sg2.RowCount := 3
    else
      sg2.RowCount := cRow + 1;

  finally
    sg2.EndUpdate;
  end;
end;

procedure TotchetForm2.sg1SelectionChanged(Sender: TObject; ALeft, ATop, ARight,
  ABottom: Integer);
begin
  RedrawWithUser;
end;

procedure TotchetForm2.chkAllClick(Sender: TObject);
begin
  if chkAll.Checked then
  begin chkOtkazInf.Checked:=False; RedrawAll; end
  else RedrawWithUser;
end;

procedure TotchetForm2.chkOtkazInfClick(Sender: TObject);
begin
  if chkOtkazInf.Checked then
  begin chkAll.Checked:=False; RedrawAll; end
  else RedrawWithUser;
end;

procedure TotchetForm2.CorrectCol;
var i:Integer;
begin
  for I := 2 to sg1.RowCount-2 do
  begin
    sg1.Alignments[2,i]:=taLeftJustify;
  end;
end;

procedure TotchetForm2.E1Click(Sender: TObject);
begin
  AdvGridExcelIO1.XLSExport('”ÒÎÛ„‡ Ò '+DateToStr(formMain.dtBeg.Date)+' ‰Ó '+DateToStr(formMain.dtEnd.Date)+'.xls');
end;

procedure TotchetForm2.edit1KeyPress(Sender: TObject; var Key: Char);
var cRow,a:Integer;
userid:string;
allWsumm,wsumm:Double;
begin
  if Key=#13 then
  begin
    a:=StrToInt(edit1.Text);
    sg1.cells[4,1]:='”ÒÎÛ„‡ '+I2S(a)+'%';

    sg1.RowCount:=3;    sg1.Rows[2].Clear;    cRow:=1;
    with dm.qtemp do
    begin
      SQL.Text:='select u.userid,u.usernaim,sum(o.wsumm) from tusers u '+
          'join '+sOrder+' o on o.userid=u.userid '+sf+' group by u.userid,u.usernaim';
      Active:=False;    Active:=True;    First;     cRow:=1;
      while not Eof do
      begin
        wsumm:=FieldByName('SUM').AsFloat;
        userid:=FieldByName('USERID').AsString;
  //      if wsumm>=0 then
        begin
          sg1.Cells[0,cRow+1]:=userid;
          sg1.Cells[1,cRow+1]:=I2S(cRow);
          sg1.Cells[2,cRow+1]:=FieldByName('USERNAIM').AsString;
          sg1.Cells[3,cRow+1]:=FormatFloat('###,###,##0.##',wsumm);
          sg1.Cells[4,cRow+1]:=FormatFloat('###,###,##0.##',Round(wsumm*a/10));
          allWsumm:=allWsumm+wsumm;
          cRow:=cRow+1; sg1.RowCount:=cRow+2; Next;
        end;
      end;
      CorrectCol;
    end;
    sg1.Cells[2,sg1.RowCount-1]:='∆¿Ã»:'; sg1.Alignments[2,sg1.RowCount-1]:=taRightJustify;
    sg1.Cells[3,sg1.RowCount-1]:=FormatFloat('###,###,##0.##',allWsumm);
    sg1.Cells[4,sg1.RowCount-1]:=FormatFloat('###,###,##0.##',Round(allWsumm*a/10));
  end;
end;

procedure TotchetForm2.MenuItem1Click(Sender: TObject);
begin
  PrintGrid1(sg1);
end;

procedure TotchetForm2.PrintGrid1(Grid: TStringGrid);
const
  CellHeight = 40; // Har bir hujayraning balandligi
  HeaderHeight = 100; // 0-qator (sarlavha) uchun balandlik
  PageWidth = 560; // Qogëoz kengligi (80 mm)
var
  Row, Col, X, Y, StartX, TotalWidth: Integer;
  ColWidths: array of Integer; // Har bir ustun kengligi
  HeaderText1, HeaderText2, s: string;
begin
  Printer.PrinterIndex:=FirstI('SELECT PRR FROM TOTDELS WHERE OTDELID='+I2S(FULLSCHETPRR));
  Printer.BeginDoc; // Chop jarayonini boshlash
  try
    Printer.Canvas.Font.Name := 'Tahoma'; // Matn shriftini belgilash

    // Har bir ustun kengligini aniqlash
    SetLength(ColWidths, Grid.ColCount);
    ColWidths[0] := 0;   // Birinchi ustun kengligi (chop etilmaydi)
    ColWidths[1] := 50;  // Ikkinchi ustun kengligi
    ColWidths[2] := 240; // Uchinchi ustun kengligi
    ColWidths[3] := 130; // Toërtinchi ustun kengligi
    ColWidths[4] := 130; // Beshinchi ustun kengligi

    // Umumiy jadval kengligini hisoblash
    TotalWidth := 0;
    for Col := 0 to High(ColWidths) do
      TotalWidth := TotalWidth + ColWidths[Col];

    // Jadvalni chap tomondan boshlash
    StartX := (PageWidth - TotalWidth) div 2;
    X := StartX;
    Y := 0;

    // 0-qator (sarlavha) matnlarini chop etish
    HeaderText1 := 'C      ' + DateTimeToStr(dBeg); // Boshlanish vaqti
    HeaderText2 := 'ƒÓ   ' + DateTimeToStr(dEnd);  // Tugash vaqti

    // Sarlavha uchun fon va shriftni sozlash
    Printer.Canvas.Brush.Color := clGray; // To'q rang fon
    Printer.Canvas.Font.Style := [fsBold]; // Qalin shrift
    Printer.Canvas.Font.Size := 12;

    // 0-qator uchun fon yaratish
    Printer.Canvas.Rectangle(StartX, Y, StartX + TotalWidth, Y + HeaderHeight);

    // "C ..." matnini markazda joylashtirish
    Y := Y + 2;
    Printer.Canvas.TextOut((PageWidth div 2) - (Printer.Canvas.TextWidth(HeaderText1) div 2), Y, HeaderText1);

    // "ƒÓ ..." matnini markazda joylashtirish
    Y := Y + 40;
    Printer.Canvas.TextOut((PageWidth div 2) - (Printer.Canvas.TextWidth(HeaderText2) div 2), Y, HeaderText2);

    // Keyingi qator uchun Y ni oshirish
    Y := Y + 45;

    Printer.Canvas.Font.Size := 7 ; // Jadval uchun matn shriftini oërnatish

    // Jadvalni chop etish
    for Row := 1 to Grid.RowCount - 1 do
    begin
      // Oxirgi qator uchun bold shrift
      if Row = Grid.RowCount - 1 then
        Printer.Canvas.Font.Style := [fsBold]
      else
        Printer.Canvas.Font.Style := [];

      for Col := 1 to Grid.ColCount - 1 do
      begin
        // Ikkinchi ustun uchun doimiy kulrang fon, faqat oxirgi qator uchun oq fon
        if (Col = 1) then
        begin
          if Row = Grid.RowCount - 1 then
            Printer.Canvas.Brush.Color := clWhite
          else
            Printer.Canvas.Brush.Color := clGray;
        end
        else
        begin
          Printer.Canvas.Brush.Color := clWhite;
        end;

        // Hujayra chegaralarini chizish
        Printer.Canvas.Rectangle(X, Y, X + ColWidths[Col], Y + CellHeight);

        // Matnni hizalash va chop etish
        if (Col = 1) or (Row = 1) then
        begin
          // Markazlash
          Printer.Canvas.TextOut(
            X + (ColWidths[Col] div 2) - (Printer.Canvas.TextWidth(Grid.Cells[Col, Row]) div 2), // Markaziy X
            Y + (CellHeight div 2) - (Printer.Canvas.TextHeight(Grid.Cells[Col, Row]) div 2),    // Markaziy Y
            Grid.Cells[Col, Row]
          );
        end
        else if (Row = Grid.RowCount - 1) and (Col = 2) then
        begin
          // Oxirgi qator ikkinchi ustun uchun o'ngga hizalash
          Printer.Canvas.TextOut(
            X + ColWidths[Col] - Printer.Canvas.TextWidth(Grid.Cells[Col, Row]) - 5, // O'ngga hizalash
            Y + (CellHeight div 2) - (Printer.Canvas.TextHeight(Grid.Cells[Col, Row]) div 2),
            Grid.Cells[Col, Row]
          );
        end
        else
        begin
          // Chapga hizalash
          Printer.Canvas.TextOut(
            X + 5, // Chapdan 5 birlik boësh joy
            Y + (CellHeight div 2) - (Printer.Canvas.TextHeight(Grid.Cells[Col, Row]) div 2), // Vertikal markazlash
            Grid.Cells[Col, Row]
          );
        end;

        // Keyingi ustunga oëtish
        Inc(X, ColWidths[Col]);
      end;

      // Yangi qatorga oëtish
      X := StartX;
      Inc(Y, CellHeight);
    end;

  finally
    Printer.EndDoc; // Chop jarayonini tugatish
  end;
end;

procedure TotchetForm2.Excel1Click(Sender: TObject);
begin
  AdvGridExcelIO2.XLSExport('”ÒÎÛ„‡_2 Ò '+DateToStr(formMain.dtBeg.Date)+' ‰Ó '+DateToStr(formMain.dtEnd.Date)+'.xls');
end;

procedure TotchetForm2.ExporttoExcel1Click(Sender: TObject);
var
  ExcelApp, Sheet: Variant;
begin
  ExcelApp := CreateOleObject('Excel.Application');
  try
    ExcelApp.Workbooks.Open(DBDIR + '1.xlsx');
    Sheet := ExcelApp.Worksheets['Sheet4'];

    sg2.CopyToClipboard;
    Sheet.Range['A1'].PasteSpecial;

    ExcelApp.DisplayAlerts := False;

    Sheet.Range['A1:F1'].Merge;
    Sheet.PrintOut;
  finally
    ExcelApp.Quit;
    ExcelApp := Unassigned;
    Sheet := Unassigned;
  end;
end;

procedure TotchetForm2.FormKeyPress(Sender: TObject; var Key: Char);
begin
  if key=#27 then Close;
end;

end.
