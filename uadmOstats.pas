//Б.Р.Р.
unit uadmOstats;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.Grids, AdvObj,
  BaseGrid, AdvGrid, AdvUtil;

type
  TotchetForm = class(TForm)
    Panel1: TPanel;
    sg1: TAdvStringGrid;
    sg2: TAdvStringGrid;
    Splitter1: TSplitter;
    procedure FormActivate(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    dBeg:TDateTime;
    dEnd:TDateTime;
    procedure reDrawTables;
  end;

var
  otchetForm: TotchetForm;

implementation

{$R *.dfm}

uses uadmdb, uadmconsts;

procedure TotchetForm.FormCreate(Sender: TObject);
var i:Integer;
begin
  with sg1 do
  begin
    ColCount:=2;RowCount:=OTDELSCNT+1;
    cells[0,0]:='Отдел';ColWidths[0]:=150;
    cells[1,0]:='Сумма';ColWidths[1]:=100;
  end;
  for i := 1 to OTDELSCNT do
  begin
    sg1.Cells[0,i]:=OTDELSNAIM[i];
  end;
  with sg2 do
  begin
    ColCount:=3;RowCount:=2;
    cells[0,0]:='Блюдо';ColWidths[0]:=150;
    cells[1,0]:='Кол-во';ColWidths[1]:=50;
    cells[2,0]:='Сумма';ColWidths[2]:=100;
  end;
end;

procedure TotchetForm.FormActivate(Sender: TObject);
begin
  Panel1.Caption:='Начало: '+DateTimeToStr(dBeg)+'   Конец: '+DateTimeToStr(dEnd);
  reDrawTables;
end;

procedure TotchetForm.reDrawTables;
var i,summ,cRow,cnt:Integer;
  s,sf,sBludId,sTable,sOrder:string;
begin
  if currUser=Admin
  then begin
    sTable:='TMOVESARCH';
    sOrder:='TORDERSARCH';
  end
  else begin
    sTable:='TMOVES';
    sOrder:='TORDERS';
  end;
  sf:=' AND o.OPENED>='+QS(DateTimeToStr(dBeg))+' AND o.OPENED<='+QS(DateTimeToStr(dEnd));
  for i := 1 to OTDELSCNT do
  begin
    summ:=FirstI('SELECT SUM(m.price*m.kolvo) FROM '+sTable+' m JOIN TBLUDS b on b.BLUDID=m.BLUDID'+
      ' JOIN '+sOrder+' o on o.ALLORDERID=m.ALLORDERID WHERE b.OTDELID='+I2S(i)+sf);
    sg1.Cells[1,i]:=I2S(summ);
  end;
  sg2.RowCount:=2;sg2.Rows[1].Clear;cRow:=1;
  with dm.qtemp do
  begin
    Active:=False;SQL.Text:='SELECT NAIM,BLUDID FROM TBLUDS ORDER BY OTDELID';Active:=True;
    First;while not Eof do
    begin
      sBludId:=FieldByName('BLUDID').AsString;
      summ:=FirstI('SELECT SUM(price*kolvo) FROM '+sTable+' m '+
        'JOIN '+sOrder+' o on o.ALLORDERID=m.ALLORDERID WHERE BLUDID='+sBludId+sf);
      if(summ>0) then
      begin
        cnt:=FirstI('SELECT SUM(kolvo) FROM '+sTable+' m '+
          'JOIN '+sOrder+' o on o.ALLORDERID=m.ALLORDERID WHERE BLUDID='+sBludId+sf);
        //cnt:=FirstI('SELECT COUNT(BLUDID) FROM TMOVESARCH WHERE BLUDID='+sBludId+sf);
        sg2.Cells[0,cRow]:=FieldByName('NAIM').AsString;
        sg2.Cells[1,cRow]:=I2S(cnt);sg2.Cells[2,cRow]:=I2S(summ);
        cRow:=cRow+1;sg2.RowCount:=cRow+1;sg2.Rows[cRow].Clear;
      end;
      Next;
    end;
  end;
end;

end.
