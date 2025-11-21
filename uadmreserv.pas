//Б.Р.Р.
unit uadmreserv;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Grids, AdvObj, BaseGrid, AdvGrid,
  Vcl.ExtCtrls, AdvUtil, Vcl.StdCtrls;

type
  TreservForm = class(TForm)
    btn1: TButton;
    sg: TAdvStringGrid;
    procedure FormCreate(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure sgGetCellColor(Sender: TObject; ARow, ACol: Integer;
      AState: TGridDrawState; ABrush: TBrush; AFont: TFont);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure sgDblClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure RedrawTable;
    procedure Checking;
  end;

var
  reservForm: TreservForm;

implementation

{$R *.dfm}

uses uadmconsts, uadmdb, uadmcudareserv;

procedure TreservForm.FormCreate(Sender: TObject);
begin
  with sg do
  begin
    ColCount:=11;RowCount:=2;
    cells[0,0]:='';ColWidths[0]:=0;//idCabin
    cells[1,0]:='Кабина';ColWidths[1]:=150;
    cells[2,0]:='Заказчик';ColWidths[2]:=100;
    cells[3,0]:='Телефон';ColWidths[3]:=100;
    cells[4,0]:='Время';colWidths[4]:=50;
    cells[5,0]:='Заказ';colWidths[5]:=100;
    Cells[6,0]:='Аванс';colWidths[6]:=50;
    Cells[7,0]:='Гость';colWidths[7]:=40;
    Cells[8,0]:='Резерв';colWidths[8]:=60;
    Cells[9,0]:='Свободно';colWidths[9]:=70;
    Cells[10,0]:='Местимость';colWidths[10]:=80;
  end;
end;

procedure TreservForm.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  case Key  of
    VK_Return: if ((ssAlt in Shift)
      or(ssCtrl in Shift))
        or(ssShift in Shift) then btn1.Click;
  end;
end;

procedure TreservForm.FormKeyPress(Sender: TObject; var Key: Char);
begin
 if Key=#27 then Close;
end;

procedure TreservForm.FormActivate(Sender: TObject);
begin
  Caption:='Резервирование кабинок';
  reservForm.Caption:=Caption+' на '+DateToStr(Now);
  Checking;
  RedrawTable;
end;

procedure TreservForm.RedrawTable;
var i,cRow:Integer;
  s,sp:string;
begin
  sg.RowCount:=2;sg.Rows[1].Clear;
  with dm.qtemp do
  begin
    Active:=False;
    SQL.Text:='SELECT s.SUMM,k.IDKABIN,k.BUYURT,k.TEL,k.FORTIME,k.ZAKAZ,k.ZAKOLAT,k.BAND,'+
      ' k.ISREZERV,k.MESTIMOST,k.GOST FROM TKABINS k JOIN TSTOLS s on k.IDKABIN=s.STOLID'+
      ' where s.stolid>100 and s.stolid<132 ORDER BY k.IDKABIN';
    Active:=True;
    First;cRow:=1;while not Eof do
    begin
      sg.Cells[0,cRow]:=FieldByName('IDKABIN').AsString;
      sg.Cells[1,cRow]:='Кабина № '+I2S(FieldByName('IDKABIN').AsInteger-100)+' - '+
        FieldByName('SUMM').AsString;
      sg.Cells[2,cRow]:=FieldByName('BUYURT').AsString;
      sg.Cells[3,cRow]:=FieldByName('TEL').AsString;
      sg.Cells[4,cRow]:=FieldByName('FORTIME').AsString;
      sg.Cells[5,cRow]:=FieldByName('ZAKAZ').AsString;
      sg.Cells[6,cRow]:=FieldByName('ZAKOLAT').AsString;
      sg.Cells[7,cRow]:=FieldByName('GOST').AsString;
      if(FieldByName('ISREZERV').AsInteger=0)
        then sg.Cells[8,cRow]:='Нет' else sg.Cells[8,cRow]:='Да';
      if(FieldByName('BAND').AsInteger=0)
        then sg.Cells[9,cRow]:='Да' else sg.Cells[9,cRow]:='Нет';
      sg.Cells[10,cRow]:=FieldByName('MESTIMOST').AsString;
      cRow:=cRow+1; sg.RowCount:=cRow; sg.Rows[cRow].Clear;
      Next;
    end;
  end;
end;

procedure TreservForm.Checking;
var band,stol,cRow:Integer;
    s:string;
    dt:TDateTime;
begin
  with dm.qtemp do
  begin
    Active:=False;
    SQL.Text:='SELECT distinct(stol) FROM TORDERS WHERE STOL>100 AND STOL<132 AND CLOSED<>'+QS(DT2S(0));
    Active:=True; First;
    while not Eof do
    begin
      stol:=FieldByName('STOL').AsInteger;
      ExecQ('UPDATE TKABINS SET BAND=0 where IDKABIN='+I2S(STOL));
      Next;
    end;
  end;
  with dm.qtemp do
  begin
    Active:=False;
    SQL.Text:='SELECT STOL FROM TORDERS WHERE STOL>100 AND STOL<132 AND CLOSED='+QS(DT2S(0));
    Active:=True; First;
    while not Eof do
    begin
      stol:=FieldByName('STOL').AsInteger;
      ExecQ('UPDATE TKABINS SET BAND=1 where IDKABIN='+I2S(STOL));
      Next;
    end;
  end;
end;

procedure TreservForm.sgDblClick(Sender: TObject);
var cRow:Integer;
  sReserv:string;
begin
  cRow:=sg.Row;
  if(cRow<1) then Exit;
  with cudaReservForm do
  begin
    Panel1.Caption:=sg.Cells[1,cRow];
    buyurt.Text:=sg.Cells[2,cRow];
    tel.Text:=sg.Cells[3,cRow];
    fortime.Text:=sg.Cells[4,cRow];
    zakaz.Text:=sg.Cells[5,cRow];
    zakolat.Text:=sg.Cells[6,cRow];
    Gost.Text:=sg.Cells[7,cRow];
    if(sg.Cells[8,cRow]='Да') then rezerv.Checked:=True else rezerv.Checked:=False;
    if(ShowModal=mrOk) then
    begin
      if rezerv.Checked then sReserv:='1' else sReserv:='0';
      ExecQ('UPDATE TKABINS SET BUYURT='+Qs(buyurt.Text)+',TEL='+Qs(tel.Text)+
        ',FORTIME='+Qs(fortime.Text)+',ZAKAZ='+Qs(zakaz.Text)+',ZAKOLAT='+zakolat.Text+
        ',ISREZERV='+sReserv+',Gost='+Gost.Text+' WHERE IDKABIN='+sg.Cells[0,cRow]);
      RedrawTable;
    end;
  end;
end;

procedure TreservForm.sgGetCellColor(Sender: TObject; ARow, ACol: Integer;
  AState: TGridDrawState; ABrush: TBrush; AFont: TFont);
begin
  if(ARow>0) and (sg.Cells[9,ARow]<>'Да') then
  begin
    ABrush.Color:=clLime;
    AFont.Style:=[fsbold];
    AFont.Color:=clBlack;
  end;
  if ((ARow>0) and (sg.Cells[8,ARow]='Да')) then
  begin
    ABrush.Color:=clWebRed;
    AFont.Style:=[fsbold];
    AFont.Color:=clWhite;
  end;
end;

end.
