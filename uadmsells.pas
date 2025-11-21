//Б.Р.Р.
unit uadmsells;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, AdvGroupBox,
  AdvOfficeButtons, Vcl.Grids, AdvObj, BaseGrid, AdvGrid, Vcl.ExtCtrls,
  Vcl.Buttons, AdvGlowButton, GradientLabel, AdvUtil, sButton, sBitBtn, sEdit,
  sCheckBox, Vcl.Menus;

type
  TSell=record
    idBlud:Integer;
    kolvo:Integer;
    printed:Boolean;
  end;

type
  TsellForm = class(TForm)
    Panel1: TPanel;
    rgOtdels: TAdvOfficeRadioGroup;
    Panel2: TPanel;
    Panel3: TPanel;
    Panel4: TPanel;
    Panel5: TPanel;
    sg: TAdvStringGrid;
    lblTime: TStaticText;
    lblSchet: TStaticText;
    StaticText2: TStaticText;
    summLbl: TGradientLabel;
    sgOrder: TAdvStringGrid;
    Panel6: TPanel;
    Panel7: TPanel;
    edit1: TsEdit;
    btnSearch: TsBitBtn;
    btnSMS: TsBitBtn;
    addBtn2: TsButton;
    decBtn2: TsButton;
    BtnCancel: TsButton;
    okBtn: TsButton;
    addBtn: TsButton;
    decBtn: TsButton;
    chkAvail: TsCheckBox;
    pm1: TPopupMenu;
    N1: TMenuItem;
    lblSumm2: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure rgOtdelsClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure okBtnClick(Sender: TObject);
    procedure addBtnClick(Sender: TObject);
    procedure decBtnClick(Sender: TObject);
    procedure sgDblClickCell(Sender: TObject; ARow, ACol: Integer);
    procedure sgGetCellColor(Sender: TObject; ARow, ACol: Integer;
      AState: TGridDrawState; ABrush: TBrush; AFont: TFont);
    procedure sgOrderGetCellColor(Sender: TObject; ARow, ACol: Integer;
      AState: TGridDrawState; ABrush: TBrush; AFont: TFont);
    procedure addBtn2Click(Sender: TObject);
    procedure decBtn2Click(Sender: TObject);
    procedure btnSearchClick(Sender: TObject);
    procedure btnSMSClick(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure chkAvailClick(Sender: TObject);
    procedure N1Click(Sender: TObject);
    procedure edit1Change(Sender: TObject);
    procedure edit1Click(Sender: TObject);
    procedure sgOrderKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
    { Private declarations }
  public
    { Public declarations }
    currOtdel:Integer;
    schetNum:string;
    schetOpened:string;
    sellsCnt:Integer;
    stol:string;
    sells:array[1..100] of TSell;
    SidAll:string;
    procedure RedrawBluds(idOtdel:Integer=0);
    procedure RedrawOrder;
    procedure AddBludo(cnt:Integer=1);
    procedure AddBludo2(cnt:Integer=1);
    procedure ChangeAvail;
    procedure RedrawSumm;
  end;

var
  sellForm: TsellForm;
  all:Integer;
  stolnumber:string;

implementation

{$R *.dfm}

uses uadmdb, uadmconsts,Vcl.Printers, uadmmain, uadmunlock2;

procedure TsellForm.FormCreate(Sender: TObject);
var i:Integer;
begin
  for i:=1 to 100 do with sells[i] do begin idBlud:=0;kolvo:=0;printed:=True;end;
  with sg do
  begin
    ColCount:=6;RowCount:=2;
    cells[0,0]:='Id';ColWidths[0]:=0;
    cells[1,0]:='Номер';ColWidths[1]:=80;
    cells[2,0]:='Наименование';ColWidths[2]:=280;
    cells[3,0]:='Цена';ColWidths[3]:=80;
    cells[4,0]:='Доступно';colWidths[4]:=80;
    cells[5,0]:='Приход';colWidths[5]:=80;
  end;
  with sgOrder do
  begin
    ColCount:=4;RowCount:=2;
    cells[0,0]:='№№';ColWidths[0]:=30;
    cells[1,0]:='Блюдо';ColWidths[1]:=250;
    cells[2,0]:='Кол-во';ColWidths[2]:=50;
    cells[3,0]:='Сумма';ColWidths[3]:=70;
  end;
  //currOtdel:=1;rgOtdels.ItemIndex:=0;
  tf.DecimalSeparator:='.';
end;

procedure TsellForm.FormActivate(Sender: TObject);
var i:Integer;
begin
  edit1.Text:='';
  lblTime.Caption:=schetOpened;
  SidAll:=formMain.sgmain.Cells[0,formMain.sgmain.Row];
  stolnumber:=formMain.sgmain.Cells[2,formMain.sgmain.Row];
  TryStrToInt(formMain.sgmain.Cells[6,formMain.sgmain.Row],all);
  if(schetNum='0') then lblSchet.Caption:=stol else lblSchet.Caption:='(№ '+schetNum+')   '+stolnumber;
  rgOtdels.Items.Clear;
  for I := 1 to 8 do
  begin
    rgOtdels.Items.Add(OTDELSNAIM[I]+' (Ctrl+'+I2S(i)+')');
  end;
  rgOtdels.ItemIndex:=0;  RedrawBluds;  RedrawOrder;
  lblSumm2.Caption:='';
end;

procedure TsellForm.AddBludo2(cnt: Integer);
var i,j,id,cRow,realcnt:Integer;
  fnd:Boolean;
begin
  if(currUser=Admin) then Exit;  cRow:=sgOrder.Row;
  if(sgOrder.Cells[2,1]='') then Exit;
//  if(summLbl.Caption='0') then Exit;

//  if(not sells[cRow].printed) then Exit;    ///*********************
  id:=sells[cRow].idBlud;   realCnt:=0;
  for i := 1 to 100 do
  if sells[i].idBlud=id then realCnt:=realCnt+sells[i].kolvo;
//  if((realCnt+cnt)<0) then Exit;           ///*********************
  fnd:=False;
  for i:=1 to sellsCnt do
    if ((sells[i].idBlud=id) and (not sells[i].printed))
      then begin fnd:=True;Break;end;
  if fnd then

  begin
    if(((sells[i].kolvo+cnt)<0) and (Abs(sells[i].kolvo+cnt)>sells[cRow].kolvo)) then Exit;
    sells[i].kolvo:=sells[i].kolvo+cnt;
    if sells[i].kolvo=0 then
    begin //удаление
      for j:=i+1 to sellsCnt do
      begin
        sells[j-1].idBlud:=sells[j].idBlud;
        sells[j-1].kolvo:=sells[j].kolvo;
        sells[j-1].printed:=sells[j].printed;
      end;
      sellsCnt:=sellsCnt-1;
    end;
  end else {if cnt>0 then} begin
    sellsCnt:=sellsCnt+1;
    sells[sellsCnt].idBlud:=id;
    sells[sellsCnt].kolvo:=cnt;
    sells[sellsCnt].printed:=False;
  end;
  RedrawOrder;
end;

procedure TsellForm.AddBludo(cnt: Integer);
var i,j,id:Integer;
  fnd:Boolean;
begin
  if(currUser=Admin) then Exit;
  if(sg.Cells[4,sg.Row]<>'Да') then
  begin
    ShowMessage('В настоящее время это блюдо не осталось !');
    Exit;
  end;
  id:=StrToInt(sg.Cells[0,sg.Row]);  fnd:=False;
  for i:=1 to sellsCnt do
    if ((sells[i].idBlud=id) and (not sells[i].printed))
      then begin fnd:=True;Break;end;
  if fnd then
  begin
    sells[i].kolvo:=sells[i].kolvo+cnt;
    if sells[i].kolvo=0 then
    begin //удаление
      for j:=i+1 to sellsCnt do
      begin
        sells[j-1].idBlud:=sells[j].idBlud;
        sells[j-1].kolvo:=sells[j].kolvo;
        sells[j-1].printed:=sells[j].printed;
      end;
      sellsCnt:=sellsCnt-1;
    end;
  end else if cnt>0 then begin
    sellsCnt:=sellsCnt+1;
    sells[sellsCnt].idBlud:=id;
    sells[sellsCnt].kolvo:=cnt;
    sells[sellsCnt].printed:=False;
  end;
  RedrawOrder;
  sgOrder.Row:=sgOrder.RowCount-1;
end;

procedure TsellForm.addBtn2Click(Sender: TObject);
begin
 AddBludo2;
 FocusControl(sgOrder);
 sgOrder.Row:=sgOrder.RowCount-1;
end;

procedure TsellForm.addBtnClick(Sender: TObject);
begin
 AddBludo;
 FocusControl(sg);
end;

procedure TsellForm.btnSearchClick(Sender: TObject);
begin
 RedrawBluds;
end;

procedure TsellForm.btnSMSClick(Sender: TObject);
const
  PageWidth = 250;     // 80mm printer kengligi (px)
  MarginX = 10;        // Chapdan bo'sh joy
  LineHeight = 60;     // Qator balandligi
var
  MsgText, Line, WordStr, TempStr: string;
  Lines: TStringList;
  Words: TArray<string>;
  i, j, y, idOtdel, prr: Integer;
begin
  MsgText := Trim(Edit1.Text);
  if MsgText = '' then Exit;

  idOtdel := rgOtdels.ItemIndex + 1;
  prr := FirstI('SELECT PRR FROM TOTDELS WHERE OTDELID=' + IntToStr(idOtdel));

  Lines := TStringList.Create;
  try
    Words := MsgText.Split([' ']);
    Line := '';
    y := 30;

    for i := 0 to High(Words) do
    begin
      WordStr := Words[i];

      // Agar so‘z juda uzun bo‘lsa, uni harflab ajratamiz
      if Printer.Canvas.TextWidth(WordStr) > (PageWidth - 2 * MarginX) then
      begin
        if Line <> '' then
        begin
          Lines.Add(Line);
          Line := '';
        end;

        TempStr := '';
        for j := 1 to Length(WordStr) do
        begin
          TempStr := TempStr + WordStr[j];
          if Printer.Canvas.TextWidth(TempStr) > (PageWidth - 2 * MarginX) then
          begin
            Lines.Add(Copy(TempStr, 1, Length(TempStr) - 1));
            TempStr := WordStr[j];
          end;
        end;
        if TempStr <> '' then Lines.Add(TempStr);
      end
      else
      begin
        if Printer.Canvas.TextWidth(Line + ' ' + WordStr) > (PageWidth - 2 * MarginX) then
        begin
          Lines.Add(Line);
          Line := WordStr;
        end
        else
          if Line = '' then Line := WordStr
          else Line := Line + ' ' + WordStr;
      end;
    end;

    if Line <> '' then Lines.Add(Line);

    // Printga jo‘natish
    try
      Printer.PrinterIndex := prr;
      with Printer do
      begin
        BeginDoc;
        Canvas.Font.Name := 'Arial Narrow';
        Canvas.Font.Size := 21;
        Canvas.Font.Style := [];

        for i := 0 to Lines.Count - 1 do
        begin
          Canvas.TextOut(MarginX, y, Lines[i]);
          y := y + LineHeight;
        end;

        EndDoc;
      end;
    except
      on E: Exception do
        ShowMessage('Printerda xatolik: ' + E.Message);
    end;
  finally
    Lines.Free;
  end;
end;

procedure TsellForm.chkAvailClick(Sender: TObject);
begin
  RedrawBluds;
end;

procedure TsellForm.decBtn2Click(Sender: TObject);
begin
 AddBludo2(-1);
 FocusControl(sgOrder);
end;

procedure TsellForm.decBtnClick(Sender: TObject);
begin
 AddBludo(-1);
 FocusControl(sg);
end;

procedure TsellForm.edit1Change(Sender: TObject);
begin
//  RedrawBluds;;
end;

procedure TsellForm.edit1Click(Sender: TObject);
begin
//  edit1.SelectAll;
end;

procedure TsellForm.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
   If (ssCtrl in Shift) and ((Key = Ord('F')) or (Key = Ord('F'))) then
 FocusControl(edit1);
    case Key  of
    VK_F1: RedrawBluds(1);
    VK_F2: RedrawBluds(2);
    VK_F3: RedrawBluds(3);
    VK_F4: RedrawBluds(4);
    VK_F5: RedrawBluds(5);
    VK_F6: RedrawBluds(6);
    VK_F7: RedrawBluds(7);
    VK_F8: RedrawBluds(8);
    VK_SUBTRACT:AddBludo(-1);
    VK_Add:AddBludo;
//    VK_NUMPAD1: RedrawBluds(1);
//    VK_NUMPAD2: RedrawBluds(2);
//    VK_NUMPAD3: RedrawBluds(3);
//    VK_NUMPAD4: RedrawBluds(4);
//    VK_NUMPAD5: RedrawBluds(5);
//    VK_NUMPAD6: RedrawBluds(6);
//    VK_NUMPAD7: RedrawBluds(7);
//    VK_NUMPAD8: RedrawBluds(8);
    VK_NUMPAD1: if(ssCtrl in Shift)or(ssAlt in Shift)or(ssShift in Shift)
        then RedrawBluds(1);
    VK_NUMPAD2: if(ssCtrl in Shift)or(ssAlt in Shift)or(ssShift in Shift)
        then RedrawBluds(2);
    VK_NUMPAD3: if(ssCtrl in Shift)or(ssAlt in Shift)or(ssShift in Shift)
        then RedrawBluds(3);
    VK_NUMPAD4: if(ssCtrl in Shift)or(ssAlt in Shift)or(ssShift in Shift)
        then RedrawBluds(4);
    VK_NUMPAD5: if(ssCtrl in Shift)or(ssAlt in Shift)or(ssShift in Shift)
        then RedrawBluds(5);
    VK_NUMPAD6: if(ssCtrl in Shift)or(ssAlt in Shift)or(ssShift in Shift)
        then RedrawBluds(6);
    VK_NUMPAD7: if(ssCtrl in Shift)or(ssAlt in Shift)or(ssShift in Shift)
        then RedrawBluds(7);
    VK_NUMPAD8: if(ssCtrl in Shift)or(ssAlt in Shift)or(ssShift in Shift)
        then RedrawBluds(8);
//    VK_SHIFT: FocusControl(sg);
//    VK_CONTROL: FocusControl(sg);
  end;
end;

procedure TsellForm.FormKeyPress(Sender: TObject; var Key: Char);
begin
 if Key='*' then FocusControl(edit1);
end;

procedure TsellForm.N1Click(Sender: TObject);
var sID:string;
    ost,prixod:Integer;
begin
  if (currOtdel=5) then
  begin
    sId:=sg.Cells[0,sg.Row];
    with Form1 do
    begin
      Caption:='Склад';   lbl1.Caption:='Введите количество'; ShowModal;
      begin
        if (edit1.Text<>'') and (ModalResult=mrOk) then
        begin
          ost:=FirstI('SELECT OSTATKA FROM TBLUDS WHERE BLUDID='+sId);
          prixod:=StrToInt(Edit1.Text)+ost;
          ExecQ('UPDATE TBLUDS SET OSTATKA='+I2S(prixod)+' WHERE BLUDID='+sId);
          if prixod>ost then ExecQ('UPDATE TBLUDS SET AVAIL=1 WHERE BLUDID='+sId)
                        else ExecQ('UPDATE TBLUDS SET AVAIL=0 WHERE BLUDID='+sId);
          ChangeAvail;
        end;
      end;
    end;
  end else Exit;
  Redrawbluds;
end;

procedure TsellForm.ChangeAvail;
var i,bludid,prixod,rasxod,ostatka,cRow:Integer;
    avail,s:string;
begin
  with dm.qtemp do
  begin
    Active:=False;
    SQL.Text:='SELECT b.BLUDID,b.NAIM,b.OSTATKA-sum(m.kolvo) as OSTATKA'+
      ' FROM TBLUDS B JOIN TMOVES m ON b.BLUDID=m.BLUDID AND b.OTDELID=5'+
      ' and b.OSTATKA>0 group BY b.BLUDID,b.NAIM,b.OSTATKA';
    Active:=True; First;
    while not Eof do
    begin
      if(FieldByName('OSTATKA').AsInteger<=3)
      then
        ExecQ('UPDATE TBLUDS SET AVAIL=0 where bludid='+FieldByName('BLUDID').AsString)
      else
        ExecQ('UPDATE TBLUDS SET AVAIL=1 where bludid='+FieldByName('BLUDID').AsString);
      Next;
    end;
  end;
end;

procedure TsellForm.okBtnClick(Sender: TObject);
var i:Integer;
  fnd:Boolean;
begin
  if(currUser=Admin) then Exit;
  fnd:=False;
  for i := 1 to sellsCnt do
  if not sells[i].printed then
  begin fnd:=True; Break;end;
  if not fnd then
  begin ModalResult:=mrNo;Exit; end;
  case MessageDlg('Распечатать чеки?', mtConfirmation, [mbYes, mbNo], 0) of
    mrYes: ModalResult:=mrOk;
  end;
end;

procedure TsellForm.sgDblClickCell(Sender: TObject; ARow, ACol: Integer);
var avail:string;
begin
  if(currUser=Admin) then Exit;
  if((ARow>=1) and (ARow<sg.RowCount)) then
  begin
    if(sg.Cells[4,ARow]='Да')
    then begin avail:='0';sg.Cells[4,ARow]:='Нет';end
    else begin avail:='1';sg.Cells[4,ARow]:='Да';end;
    ExecQ('UPDATE TBLUDS SET AVAIL='+avail+' WHERE BLUDID='+sg.Cells[0,ARow]);
  end;
end;

procedure TsellForm.RedrawOrder;
var i,id,allSumm,allSumm2,price,summ,oldRow:Integer;
  s:string;
begin
  s:='SELECT NAIM,PRICE FROM TBLUDS WHERE BLUDID=';
  allSumm:=0;oldRow:=sgOrder.Row;
  sgOrder.RowCount:=2;sgOrder.Rows[1].Clear;
  for I := 1 to sellsCnt do
  begin
    sgOrder.Cells[0,i]:=I2S(i);  id:=sells[i].idBlud;
    with dm.qwork do
    begin
     Active:=False;
     SQL.Text:=s+I2S(id);
     Active:=True;
     sgOrder.Cells[1,i]:=FieldByName('NAIM').AsString;
     price:=FieldByName('PRICE').AsInteger;
    end;
     sgOrder.Cells[2,i]:=I2S(sells[i].kolvo);
     summ:=price*sells[i].kolvo;
     allSumm:=allSumm+summ;
     sgOrder.Cells[3,i]:=I2S(summ);
     sgOrder.RowCount:=i+1;sgOrder.Rows[i+1].Clear;
  end;
  if(sgOrder.RowCount>oldRow) then sgOrder.Row:=oldRow else sgOrder.Row:=sgOrder.RowCount-1;
  summLbl.Caption:=FormatFloat('###,###,##0.##',allSumm);
  if (stolnumber='С собой') and (schetNum<>'0') then lblSumm2.Caption:=FormatFloat('###,###,##0.##',(allSumm-all));
end;

procedure TsellForm.RedrawSumm;
var i:Integer;
  summ,dTmp:Double;
begin
  summ:=0;
  if (stolnumber='С собой') and (schetNum<>'0') then
  begin
    for i:=1 to sgOrder.RowCount-1 do
    if TryStrToFloat(sgOrder.Cells[3,i],dTmp)
    then summ:=summ+dTmp;
    lblSumm2.Caption:=FormatFloat('###,###,##0.##',summ-all);
  end;
  sgOrder.Row:=sgOrder.RowCount-1;
end;

procedure TsellForm.RedrawBluds(idOtdel:Integer=0);
var i,cRow,prixod:Integer;
    q:string;
begin
  edit1.Text:= StringReplace(edit1.Text, '+' , '', [rfReplaceAll, rfIgnoreCase] );
  edit1.Text:= StringReplace(edit1.Text, '-' , '', [rfReplaceAll, rfIgnoreCase] );

  if idOtdel>0 then rgOtdels.ItemIndex:=idOtdel-1;
  currOtdel:=rgOtdels.ItemIndex+1;
//  summLbl.Caption:=IntToStr(currOtdel);
  sg.RowCount:=2;sg.Rows[1].Clear;
  if (edit1.Text='') and (not chkAvail.Checked)
  then q:='SELECT * FROM TBLUDS WHERE ISSALE>0 AND ISACTIVE=0 AND PRR='+
          I2S(currOtdel)+' ORDER BY NAVBAT,NAIM'
  else
  if (edit1.Text='') and (chkAvail.Checked)
  then q:='SELECT * FROM TBLUDS WHERE ISSALE>0 AND AVAIL>0 AND ISACTIVE=0 AND'+
          ' PRR='+I2S(currOtdel)+' ORDER BY NAVBAT,NAIM'
  else
    q:='select * from TBLUDS where issale>0 AND isactive=0 and '+
       'upper (NAIM) like upper ('+qs('%'+edit1.Text+'%')+')';
  with dm.qwork do
  begin
    Active:=False; SQL.Text:=q; Active:=True; First; cRow:=1;
    while not Eof do
    begin
      sg.Cells[0,cRow]:=FieldByName('BLUDID').AsString;
      sg.Cells[1,cRow]:=FieldByName('NAVBAT').AsString;
      sg.Cells[2,cRow]:=FieldByName('NAIM').AsString;
      sg.Cells[3,cRow]:=FieldByName('PRICE').AsString;
      if(FieldByName('AVAIL').AsInteger=1) then
      sg.Cells[4,cRow]:='Да' else sg.Cells[4,cRow]:='Нет';
      if currOtdel=5 then
      begin
        prixod:=FieldByName('OSTATKA').AsInteger;
        sg.Cells[5,cRow]:=I2S(prixod);
      end;
      cRow:=cRow+1;sg.RowCount:=sg.RowCount+1;sg.Rows[cRow].Clear;
      Next;
    end;
  end;
  if(sg.RowCount>2) then sg.RowCount:=sg.RowCount-1;  sg.Refresh;
  if ActiveControl = Edit1 then FocusControl(edit1) else FocusControl(sg);
//  ChangeAvail;
end;

procedure TsellForm.rgOtdelsClick(Sender: TObject);
begin
 RedrawBluds;
end;

procedure TsellForm.sgGetCellColor(Sender: TObject; ARow, ACol: Integer;
  AState: TGridDrawState; ABrush: TBrush; AFont: TFont);
begin
  if ((ARow>0) and (sg.Cells[4,ARow]<>'Да')) then AFont.Color:=clRed;
end;

procedure TsellForm.sgOrderGetCellColor(Sender: TObject; ARow, ACol: Integer;
  AState: TGridDrawState; ABrush: TBrush; AFont: TFont);
begin
  if(ARow>0) then if(sells[ARow].printed) then ABrush.Color:=clYellow;
end;

procedure TsellForm.sgOrderKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  with TAdvStringGrid(Sender) do
  if (Key=VK_RETURN) then okBtn.Click;
end;

end.

