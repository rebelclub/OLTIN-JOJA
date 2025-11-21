unit Ostats;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, AdvUtil, Vcl.Grids, AdvObj, BaseGrid,
  AdvGrid, Vcl.StdCtrls, Vcl.Buttons, sBitBtn, Vcl.Menus, tmsAdvGridExcel,
  sComboBox, Vcl.ExtCtrls;

type
  TFormOstats = class(TForm)
    sg: TAdvStringGrid;
    AdvGridExcelIO1: TAdvGridExcelIO;
    pm1: TPopupMenu;
    MenuItem1: TMenuItem;
    BtnExp1: TsBitBtn;
    procedure FormCreate(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure BtnExp1Click(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }
  public
    { Public declarations }
    dBeg:TDateTime;
    dEnd:TDateTime;
  end;

var
  FormOstats: TFormOstats;

implementation

{$R *.dfm}

uses uadmdb, uadmconsts;

procedure TFormOstats.FormCreate(Sender: TObject);
begin
  with sg do
  begin
    ColCount:=5;RowCount:=2;
    cells[0,0]:='№';ColWidths[0]:=30;
    cells[1,0]:='Блюдо';ColWidths[1]:=170;
    cells[2,0]:='Приход';ColWidths[2]:=60;
    cells[3,0]:='Расход';ColWidths[3]:=60;
    cells[4,0]:='Остатка';ColWidths[4]:=60;
  end;
end;

procedure TFormOstats.FormKeyPress(Sender: TObject; var Key: Char);
begin
  if Key=#27 then Close;
end;

procedure TFormOstats.FormActivate(Sender: TObject);
var i,prixod,rasxod,ostatka,cRow:Integer;
begin
  sg.RowCount:=2; sg.Rows[1].Clear;
  sg.Alignments[0,0]:=taCenter;
  sg.Alignments[1,0]:=taCenter;
  sg.Alignments[2,0]:=taCenter;
  sg.Alignments[3,0]:=taCenter;
  sg.Alignments[4,0]:=taCenter;
  with dm.qwork do
  begin
    SQL.Text:='SELECT b.BLUDID,b.NAIM,b.OSTATKA,SUM(m.KOLVO) AS SUMM,'+
      ' b.OTDELID FROM TBLUDS B'+
      ' JOIN TMOVES m ON b.BLUDID=m.BLUDID'+
      ' AND b.OTDELID=5 and b.OSTATKA>0'+
      ' group BY b.BLUDID,b.NAIM,b.OSTATKA,b.OTDELID';
     Active:=False;  Active:=True;   First;    cRow:=1;
    while not Eof do
    begin
      sg.Cells[0,cRow]:=I2S(cRow);
      sg.Cells[1,cRow]:=FieldByName('NAIM').AsString;
      prixod:=FieldByName('OSTATKA').AsInteger;
      sg.Cells[2,cRow]:=I2S(prixod);
      rasxod:=FieldByName('SUMM').AsInteger;
      sg.Cells[3,cRow]:=I2S(rasxod);
      ostatka:=prixod-rasxod;
      sg.Cells[4,cRow]:=I2S(ostatka);
//      sg.Cells[5,cRow]:=FieldByName('BLUDID').AsString;
      cRow:=cRow+1; sg.RowCount:=cRow; sg.Rows[cRow].Clear;
      Next;
    end;
  end;
end;

procedure TFormOstats.BtnExp1Click(Sender: TObject);
begin
 AdvGridExcelIO1.XLSExport('Остатка.xls');
end;

end.
