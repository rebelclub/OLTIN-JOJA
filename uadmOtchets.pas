//Б.Р.Р.
unit uadmOtchets;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.Grids, AdvObj,  ComObj, Printers,
  BaseGrid, AdvGrid, AdvUtil, Vcl.StdCtrls, tmsAdvGridExcel, Vcl.Buttons, ExcelXP,
  Vcl.Menus, sBitBtn;

type
  TotchetForm = class(TForm)
    sg1: TAdvStringGrid;
    pm1: TPopupMenu;
    MenuItem1: TMenuItem;
    pm2: TPopupMenu;
    ExporttoExcel1: TMenuItem;
    sg2: TAdvStringGrid;
    Label1: TLabel;
    procedure FormActivate(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure sg1SelectionChanged(Sender: TObject; ALeft, ATop, ARight,
      ABottom: Integer);
    procedure BtnExpClick(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure reDrawTables1;
    procedure ExporttoExcel1Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
  public
    { Public declarations }
    dBeg:TDateTime;
    dEnd:TDateTime;
  end;

var
  otchetForm: TotchetForm;
  sf,sf2,sBludId,sTable,sOrder:string;

implementation

{$R *.dfm}

uses uadmdb, System.DateUtils, uadmconsts, uadmmain, uadmprnform;

procedure TotchetForm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Label1.Visible:=False;
end;

procedure TotchetForm.FormCreate(Sender: TObject);
begin
  with sg1 do
  begin
    ColCount:=3;RowCount:=14;
    MergeCells(0, 0, 3, 1);
    cells[0,1]:='№';ColWidths[0]:=30;
    cells[1,1]:='Отдел';ColWidths[1]:=130;
    cells[2,1]:='Сумма';ColWidths[2]:=75;
    cells[1,10]:='ВСЕГО:';
    cells[1,11]:='Услуга 5%:';
    cells[1,12]:='Кабина:';
    cells[1,13]:='ИТОГО:';
  end;
  with sg2 do
  begin
    ColCount:=4;RowCount:=2;
    cells[0,0]:='№';ColWidths[0]:=30;
    cells[1,0]:='Блюдо';ColWidths[1]:=200;
    cells[2,0]:='Кол-во';ColWidths[2]:=50;
    cells[3,0]:='Сумма';ColWidths[3]:=70;
  end;
end;

procedure TotchetForm.FormActivate(Sender: TObject);
var i:integer;
begin
  sg1.cells[0,0]:='С      '+DateTimeToStr(dBeg)+#13+'До   '+DateTimeToStr(dEnd);
  sg1.FontSizes[0,0] := 10;
  sg1.FixedRows:=2;
  sg1.Alignments[0,0] :=taCenter;
  sg1.Alignments[1,1] :=taCenter;
  sg2.Alignments[1,0] :=taCenter;
  sg1.Alignments[1,10]:=taCenter;
  sg1.Alignments[1,11]:=taCenter;
  sg1.Alignments[1,12]:=taCenter;
  sg1.Alignments[1,13]:=taCenter;
  for i := 1 to OTDELSCNT do
  begin
    sg1.Cells[1,i+1]:=OTDELSNAIM[i];
  end;
  if currUser=Admin then begin sTable:='TMOVESARCH';  sOrder:='TORDERSARCH'; end
  else                   begin sTable:='TMOVES';      sOrder:='TORDERS'; end;
  sf:=' AND o.OPENED>='+QS(DateTimeToStr(dBeg))+' AND o.OPENED<='+QS(DateTimeToStr(dEnd));
  sf2:=' WHERE OPENED>='+QS(DateTimeToStr(dBeg))+' AND OPENED<='+QS(DateTimeToStr(dEnd));
  reDrawTables1;
  Label1.Visible:=False;
end;

procedure TotchetForm.FormKeyPress(Sender: TObject; var Key: Char);
begin
  if Key=#27 then Close;
end;

procedure TotchetForm.BtnExpClick(Sender: TObject);
var
  ExcelWorkbook,ExcelWorksheet,ExcelApp,Sheet:Variant;
begin
//  if currUser=Admin then Exit;

  ExcelApp := CreateOleObject('Excel.Application');
  ExcelApp.Workbooks.Open(DBDIR+'1.xlsx');
  Sheet := ExcelApp.Worksheets.Item['Sheet1'];
  sg1.CopyToClipboard;
  Sheet.Range['A1'].PasteSpecial;

  ExcelApp.DisplayAlerts:=False;
  Sheet.Range['A1','C1'].Merge;
  Sheet.PrintOut;

  ExcelApp.Quit;
  ExcelApp:=Unassigned;
  Sheet:=Unassigned;
end;

procedure TotchetForm.ExporttoExcel1Click(Sender: TObject);
var
  ExcelWorkbook,ExcelWorksheet,ExcelApp,Sheet:Variant;
begin
//  if currUser=Admin then Exit;

  ExcelApp := CreateOleObject('Excel.Application');
  ExcelApp.Workbooks.Open(DBDIR+'1.xlsx');
  Sheet := ExcelApp.Worksheets.Item['Sheet2'];
  sg2.CopyToClipboard;
  Sheet.Range['A1'].PasteSpecial;

  ExcelApp.DisplayAlerts:=False;

  Sheet.PrintOut;

  ExcelApp.Quit;
  ExcelApp:=Unassigned;
  Sheet:=Unassigned;
end;

procedure TotchetForm.reDrawTables1;
var i,summ,AllWsumm,AllKabina,cRow,Itogo,otdelSumm:Integer;
    s,sBludId:string;
begin
  otdelSumm:=0;
  for i := 1 to OTDELSCNT do
  begin
    summ:=FirstI('SELECT SUM(m.price*m.kolvo) FROM '+sTable+' m JOIN TBLUDS b on b.BLUDID=m.BLUDID'+
      ' JOIN '+sOrder+' o on o.ALLORDERID=m.ALLORDERID WHERE b.OTDELID='+I2S(i)+sf);
    otdelSumm:=otdelSumm+summ;
    sg1.Cells[0,i+1]:=I2S(i);
    sg1.Cells[2,i+1]:=FormatFloat('###,###,##0',summ);
  end;
  AllWsumm:=FirstI('SELECT SUM(wsumm)/2 FROM '+sOrder+sf2);
  AllKabina:=FirstI('SELECT SUM(KABINASUMM) FROM '+sOrder+sf2);
  Itogo:=otdelSumm+AllWsumm+AllKabina;
  sg1.Cells[2,10]:=FormatFloat('###,###,##0',otdelSumm);
  sg1.Cells[2,11]:=FormatFloat('###,###,##0',AllWsumm);
  sg1.Cells[2,12]:=FormatFloat('###,###,##0',AllKabina);
  sg1.Cells[2,13]:=FormatFloat('###,###,##0',Itogo);
  sg2.RowCount:=2;    sg2.Rows[1].Clear;    cRow:=1;
  with dm.qtemp do
  begin
    Active:=False;
    SQL.Text:='SELECT b.NAIM,SUM(m.KOLVO),m.PRICE,SUM(m.KOLVO*m.PRICE) AS SUMM,'+
    ' b.OTDELID FROM TBLUDS B'+
    ' JOIN '+sTable+' m ON b.BLUDID=m.BLUDID'+
    ' JOIN '+sOrder+' o ON m.ALLORDERID=o.ALLORDERID'+sf+
    ' AND b.OTDELID>0 group BY b.NAIM,b.OTDELID,m.PRICE';
    Active:=True;      First;     cRow:=1;
    while not Eof do
    begin
      summ:=FieldByName('SUMM').AsInteger;
      if(summ>0) then
      begin
        sg2.Cells[0,cRow]:=I2S(cRow);
        sg2.Cells[1,cRow]:=FieldByName('NAIM').AsString;
        sg2.Cells[2,cRow]:=FieldByName('SUM').AsString;
        sg2.Cells[3,cRow]:=FormatFloat('###,###,##0',summ);
        cRow:=cRow+1; sg2.RowCount:=cRow; sg2.Rows[cRow].Clear;
      end;
      Next;
    end;
  end;
end;

procedure TotchetForm.sg1SelectionChanged(Sender: TObject; ALeft, ATop, ARight,
ABottom: Integer);
var summ,cRow,cnt,i:Integer;
otdelid,sBludId:string;
begin
  Label1.Visible:=False;
  sg2.RowCount:=2;                    sg2.Rows[1].Clear;          cRow:=1;
  otdelid:=sg1.Cells[0,sg1.Row];      if otdelid='' then Exit;
  with dm.qtemp do
  begin
    Active:=False;
    SQL.Text:='SELECT b.NAIM,SUM(m.KOLVO),m.PRICE,SUM(m.KOLVO*m.PRICE) AS SUMM,'+
    ' b.OTDELID FROM TBLUDS B'+
    ' JOIN '+sTable+' m ON b.BLUDID=m.BLUDID'+
    ' JOIN '+sOrder+' o ON m.ALLORDERID=o.ALLORDERID'+sf+
    ' AND b.OTDELID='+otdelid+
    ' group BY b.NAIM,b.OTDELID,m.PRICE';
    Active:=True;      First;     cRow:=1;
    while not Eof do
    begin
      summ:=FieldByName('SUMM').AsInteger;
      if(summ>0) then
      begin
        sg2.Cells[0,cRow]:=I2S(cRow);
        sg2.Cells[1,cRow]:=FieldByName('NAIM').AsString;
        sg2.Cells[2,cRow]:=FieldByName('SUM').AsString;
        sg2.Cells[3,cRow]:=FormatFloat('###,###,##0',summ);
        cRow:=cRow+1; sg2.RowCount:=cRow; sg2.Rows[cRow].Clear;
      end;
      Next;
    end;
  end;
  if (otdelid='5') and (sg2.RowCount>2) then
  begin
    summ:=0;  cnt:=0;
    for I := 1 to sg2.RowCount-1 do
    begin
      cnt:=StrToInt(sg2.Cells[2,i]);
      summ:=summ+cnt;
    end;
    Label1.Visible:=True;
    Label1.Caption:='Шашлик жами: '+I2S(summ);
  end;

end;

end.
