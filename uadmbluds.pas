//Б.Р.Р.
unit uadmbluds;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls, Vcl.Grids,
  AdvObj, BaseGrid, AdvGrid, Vcl.Buttons, AdvUtil, sBitBtn, sComboBox, sCheckBox,
  Vcl.Mask, sMaskEdit, sCustomComboEdit;

type
  TbludsForm = class(TForm)
    Panel1: TPanel;
    sg: TAdvStringGrid;
    newBtn: TsBitBtn;
    changeBtn: TsBitBtn;
    btnDel: TsBitBtn;
    Panel2: TPanel;
    edit1: TEdit;
    btnSearch: TsBitBtn;
    cbOtdels: TsComboBox;
    chAll: TsCheckBox;
    perenosBtn: TsBitBtn;
    Label1: TLabel;
    Label2: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure cbOtdelsChange(Sender: TObject);
    procedure newBtnClick(Sender: TObject);
    procedure changeBtnClick(Sender: TObject);
    procedure perenosBtnClick(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure btnDelClick(Sender: TObject);
    procedure btnSearchClick(Sender: TObject);
    procedure chAllClick(Sender: TObject);
    procedure edit1Change(Sender: TObject);
    procedure sgGetCellColor(Sender: TObject; ARow, ACol: Integer;
      AState: TGridDrawState; ABrush: TBrush; AFont: TFont);
  private
    { Private declarations }
  public
    { Public declarations }
    //cOtdelId:Integer;
    procedure RedrawBluds(idBlud:Integer=0);
  end;

var
  bludsForm: TbludsForm;

implementation

{$R *.dfm}

uses uadmdb, uadmconsts, uadmcudabluds, uadmperenos;

procedure TbludsForm.FormCreate(Sender: TObject);
var i:Integer;
begin
  with sg do
  begin
    ColCount:=8;                RowCount:=2;
    cells[0,0]:='Id';           ColWidths[0]:=0;
    cells[1,0]:='№';            ColWidths[1]:=40;
    cells[2,0]:='№№';           ColWidths[2]:=40;
    cells[3,0]:='Код';          ColWidths[3]:=0;
    cells[4,0]:='Наименование'; ColWidths[4]:=280;
    cells[5,0]:='Цена';         ColWidths[5]:=80;
    cells[6,0]:='В наличии';    ColWidths[6]:=90;
    cells[7,0]:='В продаже';    ColWidths[7]:=90;
  end;
end;

procedure TbludsForm.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
   If (ssCtrl in Shift) and ((Key = Ord('X')) or (Key = Ord('X')))
  then perenosBtn.Click;
   If (ssCtrl in Shift) and ((Key = Ord('F')) or (Key = Ord('F')))
  then FocusControl(edit1);
  case Key  of
    VK_DELETE: btnDel.Click;
    VK_SPACE: RedrawBluds;
  end;
end;

procedure TbludsForm.FormKeyPress(Sender: TObject; var Key: Char);
begin
 if Key=#13 then changeBtn.Click;
 if Key='+' then newBtn.Click;
 if Key='-' then changeBtn.Click;
 if Key=#27 then Close;
end;

procedure TbludsForm.btnDelClick(Sender: TObject);
var i,idBlud:Integer;
  sIdBlud:string;
begin
  sIdBlud:=sg.Cells[0,sg.Row];
  if(FirstI('SELECT COUNT(BLUDID) FROM TMOVES WHERE BLUDID='+sIdBlud)>0) or
    (FirstI('SELECT COUNT(BLUDID) FROM TMOVESARCH WHERE BLUDID='+sIdBlud)>0)
  then begin ShowMessage('Блюдо участвует в продажах!');Exit;end;
  if(FirstI('SELECT COUNT(IDBLUD) FROM TTK WHERE IDBLUD='+sIdBlud)>0) or
    (FirstI('SELECT COUNT(IDBLUD) FROM TTK WHERE TIPTB=1 AND IDTB='+sIdBlud)>0)
  then begin ShowMessage('Блюдо участвует в тех.картах!');Exit;end;
  if MessageDlg('Удалить блюдо "'+sg.Cells[4,sg.Row]+'" ?',mtConfirmation,[mbYes,mbNo],0,mbYes)<>mrYes
  then Exit;
  ExecQ('DELETE FROM TBLUDS WHERE BLUDID='+sIdBlud);
  idBlud:=StrToInt(sIdBlud);
  if(sg.Row>2) then idBlud:=StrToInt(sg.Cells[0,sg.Row-1]) else idBlud:=0;
  RedrawBluds(idBlud);
end;

procedure TbludsForm.btnSearchClick(Sender: TObject);
begin
  RedrawBluds;
end;

procedure TbludsForm.cbOtdelsChange(Sender: TObject);
var j:string;
begin
  chAll.Checked:=False;
  RedrawBluds;
  FocusControl(sg);
end;

procedure TbludsForm.FormActivate(Sender: TObject);
var i,j:Integer;
begin
  cbOtdels.Items.Clear;cbOtdels.Items.Add('РЕЗЕРВ');
  for I := 1 to OTDELSCNT do cbOtdels.Items.Add(otdelsnaim[i]);
  cbOtdels.ItemIndex:=1;
  edit1.Text:='';
  RedrawBluds();
  FocusControl(sg);
end;

procedure TbludsForm.RedrawBluds(idBlud:Integer);
var cRow,initRow:Integer;
    q:string;
begin
  sg.RowCount:=2;sg.Rows[1].Clear;initRow:=1;
  if edit1.Text<>'' then
    q:='select * from TBLUDS where upper (NAIM) like upper ('+qs('%'+edit1.Text+'%')+') order by naim'
  else
  if (edit1.Text='') and (chAll.Checked ) then
    q:='SELECT * FROM TBLUDS ORDER BY NAVBAT,NAIM'
  else
    q:='SELECT * FROM TBLUDS WHERE PRR='+I2S(cbOtdels.ItemIndex)+' ORDER BY NAVBAT,NAIM';
  with dm.qwork do
  begin
    Active:=False;    SQL.Text:=q;    Active:=True;   First;    cRow:=1;
    while not Eof do
    begin
      if(FieldByName('BLUDID').AsInteger=idBlud) then initRow:=cRow;
      sg.Cells[0,cRow]:=FieldByName('BLUDID').AsString;
      sg.Cells[1,cRow]:=I2S(cRow);
      sg.Cells[2,cRow]:=FieldByName('NAVBAT').AsString;
      sg.Cells[3,cRow]:=FieldByName('KOD').AsString;
      sg.Cells[4,cRow]:=FieldByName('NAIM').AsString;
      sg.Cells[5,cRow]:=FieldByName('PRICE').AsString;
      if(FieldByName('AVAIL').AsInteger=1) then
      sg.Cells[6,cRow]:='Да' else sg.Cells[6,cRow]:='Нет';
      if(FieldByName('ISSALE').AsInteger=1) then
      sg.Cells[7,cRow]:='Да' else sg.Cells[7,cRow]:='Нет';
      cRow:=cRow+1;sg.RowCount:=sg.RowCount+1;sg.Rows[cRow].Clear;
      Next;
    end;
  end;
  if(sg.RowCount>2) then sg.RowCount:=sg.RowCount-1; sg.Row:=initRow;sg.Refresh;
end;

procedure TbludsForm.sgGetCellColor(Sender: TObject; ARow, ACol: Integer;
  AState: TGridDrawState; ABrush: TBrush; AFont: TFont);
begin
  if (ARow>0) and ((sg.Cells[6,ARow]<>'Да') or (sg.Cells[7,ARow]<>'Да')) then AFont.Color:=clRed;
end;

procedure TbludsForm.chAllClick(Sender: TObject);
begin
  RedrawBluds();
end;

procedure TbludsForm.edit1Change(Sender: TObject);
begin
  chAll.Checked:=False;
  RedrawBluds();
end;

procedure TbludsForm.newBtnClick(Sender: TObject);
var nnaim,nkod,s,newId:string;
    nnavbat,nprice,navail,nissale,otdelId:Integer;
begin
  if(cbOtdels.ItemIndex=0) then Exit;
  nnaim:='NEW'; nkod:='000';  nnavbat:=999; nprice:=1; navail:=1; nissale:=1;
  with cudaBludForm do
  begin
    naim:=nnaim;  kod:=nkod;  navbat:=nnavbat;  price:=nprice;  avail:=navail; issale:=nissale;
    if ShowModal<>mrOk then Exit;
    nnaim:=naim;  nkod:=kod;  nnavbat:=navbat;  nprice:=price;  navail:=avail; nissale:=issale;
  end;
  newId:=GetGen('GEN_TBLUDS_ID');
  if cbOtdels.ItemIndex=8 then otdelId:=cbOtdels.ItemIndex-2 else otdelId:=cbOtdels.ItemIndex;
  s:='INSERT INTO TBLUDS (BLUDID,OTDELID,PRR,NAIM,KOD,PRICE,AVAIL,NAVBAT,ISSALE) VALUES ('+newId+','
  +I2S(otdelId)+','+I2S(cbOtdels.ItemIndex)+','+QS(nnaim)+','+QS(nkod)+','+I2S(nprice)+','+I2S(navail)+','+I2S(nnavbat)+','+I2S(nissale)+')';
  ExecQ(s);
  RedrawBluds(StrToInt(newId));
end;

procedure TbludsForm.perenosBtnClick(Sender: TObject);
var otdelId:Integer;
begin
  if perenosForm.sg.Row=8 then otdelId:=perenosForm.sg.Row-2 else otdelId:=perenosForm.sg.Row;
  if perenosForm.ShowModal<>mrOk then Exit;
  ExecQ('UPDATE TBLUDS SET OTDELID='+I2S(otdelId)+',PRR='+I2S(perenosForm.sg.Row)+' WHERE BLUDID='+sg.Cells[0,sg.Row]);
  if(perenosForm.sg.Row=0) then
  ExecQ('UPDATE TBLUDS SET AVAIL=0 WHERE BLUDID='+sg.Cells[0,sg.Row]);
  RedrawBluds;
end;

procedure TbludsForm.changeBtnClick(Sender: TObject);
var nnaim,nkod,s:string;
    nnavbat,nprice,navail,nissale,cRow,currId:Integer;
begin
  cRow:=sg.Row;
  if(cbOtdels.ItemIndex=0) then Exit;
  if not TryStrToInt(sg.Cells[0,cRow],currId) then Exit;
  nnavbat:=StrToInt(sg.Cells[2,cRow]);
  nkod:=sg.Cells[3,cRow];
  nnaim:=sg.Cells[4,cRow];
  nprice:=StrToInt(sg.Cells[5,cRow]);
  if(sg.cells[6,cRow]='Да') then navail:=1 else navail:=0;
  if(sg.cells[7,cRow]='Да') then nissale:=1 else nissale:=0;
  with cudaBludForm do
  begin
    naim:=nnaim;  kod:=nkod;  navbat:=nnavbat;  price:=nprice;  avail:=navail; issale:=nissale;
    if ShowModal<>mrOk then Exit;
    nnaim:=naim;  nkod:=kod;  nnavbat:=navbat;  nprice:=price;  navail:=avail; nissale:=issale;
  end;
  s:='UPDATE TBLUDS SET NAIM='+QS(nnaim)+',KOD='+QS(nkod)+',PRICE='+I2S(nprice)+',AVAIL='+
    I2S(navail)+',ISSALE='+I2S(nissale)+',NAVBAT='+I2S(nnavbat)+' WHERE BLUDID='+I2S(currId);
  ExecQ(s);
  sg.Cells[2,cRow]:=I2S(nnavbat);
  sg.Cells[3,cRow]:=nkod;
  sg.Cells[4,cRow]:=nnaim;
  sg.Cells[5,cRow]:=I2S(nprice);
  if(navail=1) then sg.cells[6,cRow]:='Да' else sg.cells[6,cRow]:='Нет';
  if(nissale=1) then sg.cells[7,cRow]:='Да' else sg.cells[7,cRow]:='Нет';
  RedrawBluds(currId);
end;

end.
