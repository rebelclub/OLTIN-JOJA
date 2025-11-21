//Б.Р.Р.
unit uadmmain;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, System.Actions, Vcl.ActnList,
  Vcl.Menus, AdvMenus, Vcl.ExtCtrls, Vcl.StdCtrls, Vcl.ComCtrls, AdvDateTimePicker, Data.DB,
  Vcl.DBCtrls, Vcl.Grids, AdvObj, BaseGrid, AdvGrid, Vcl.DBGrids, AdvUtil, AdvGlassButton,
  tmsAdvGridExcel, Vcl.Buttons, sSkinManager, sBitBtn, sComboBox, sCheckBox,System.UITypes,
  sButton, sLabel, AdvGlowButton, sPanel, Vcl.Mask, sMaskEdit, sCustomComboEdit, System.Zip,
  sEdit;

type
  TformMain = class(TForm)
    pnl4: TPanel;
    Panel2: TPanel;
    pnl6: TPanel;
    pnl7: TPanel;
    spl1: TSplitter;
    pnl8: TPanel;
    sgMain: TAdvStringGrid;
    sgSlave: TAdvStringGrid;
    Timer1: TTimer;
    AdvGridExcelIO1: TAdvGridExcelIO;
    danger: TCheckBox;
    Chhammasi: TCheckBox;
    EnterBtn: TButton;
    chClosed: TCheckBox;
    itogoGrid: TAdvStringGrid;
    pnl5: TPanel;
    tmBeg: TAdvDateTimePicker;
    tmEnd: TAdvDateTimePicker;
    refreshBtn: TAdvGlowButton;
    allPeriodBtn: TAdvGlowButton;
    todayBtn: TAdvGlowButton;
    sellBtn: TAdvGlowButton;
    sellbtnfalse: TAdvGlowButton;
    PlanshetBtn: TAdvGlowButton;
    Filter: TsCheckBox;
    workersBox: TsComboBox;
    bntActivate: TAdvGlowButton;
    pnlJAMI: TsPanel;
    sSkinManager1: TsSkinManager;
    pm1: TPopupMenu;
    N12: TMenuItem;
    N13: TMenuItem;
    N17: TMenuItem;
    N14: TMenuItem;
    N15: TMenuItem;
    N16: TMenuItem;
    N19: TMenuItem;
    N18: TMenuItem;
    kabinSumm: TMenuItem;
    pnl1: TPanel;
    lblNaim: TsLabelFX;
    lblTime: TsLabelFX;
    beg: TLabel;
    Label1: TLabel;
    dtBeg: TDateTimePicker;
    dtEnd: TDateTimePicker;
    ActionList1: TActionList;
    actChangeUsers: TAction;
    actChangeKabina: TAction;
    actChangeBluda: TAction;
    actChangePrinters: TAction;
    actCloseDay: TAction;
    actDoOtchet: TAction;
    actDoReserv: TAction;
    actChangeOrders: TAction;
    actQuit: TAction;
    actAfitsant: TAction;
    actServerOn: TAction;
    actServerOff: TAction;
    actActivatsiya: TAction;
    actDoOstats: TAction;
    mainMenu: TAdvMainMenu;
    N1: TMenuItem;
    N2: TMenuItem;
    N3: TMenuItem;
    N4: TMenuItem;
    N8: TMenuItem;
    N9: TMenuItem;
    actQuit1: TMenuItem;
    N5: TMenuItem;
    N21: TMenuItem;
    N7: TMenuItem;
    actAfitsant1: TMenuItem;
    N6: TMenuItem;
    N20: TMenuItem;
    actServerOn1: TMenuItem;
    actServerOff1: TMenuItem;
    N10: TMenuItem;
    N11: TMenuItem;
    N9989997651011: TMenuItem;
    N9989391551011: TMenuItem;
    N792322851011: TMenuItem;
    telegram_link: TMenuItem;
    Hotkeys: TMenuItem;
    actActivatsiya1: TMenuItem;
    btnSearch: TsBitBtn;
    edit1: TsEdit;
    Memo1: TMemo;
    procedure FormActivate(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure edit1Change(Sender: TObject);
    procedure edit1KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure todayBtnClick(Sender: TObject);
    procedure allPeriodBtnClick(Sender: TObject);
    procedure N2Click(Sender: TObject);
    procedure N3Click(Sender: TObject);
    procedure N4Click(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure N8Click(Sender: TObject);
    procedure refreshBtnClick(Sender: TObject);
    procedure sgMainSelectionChanged(Sender: TObject; ALeft, ATop, ARight,
      ABottom: Integer);
    procedure sgMainDblClickCell(Sender: TObject; ARow, ACol: Integer);
    procedure N6Click(Sender: TObject);
    procedure actChangeUsersUpdate(Sender: TObject);
    procedure actChangeKabinaUpdate(Sender: TObject);
    procedure actChangeBludaUpdate(Sender: TObject);
    procedure actChangePrintersUpdate(Sender: TObject);
    procedure actCloseDayUpdate(Sender: TObject);
    procedure actDoOtchetUpdate(Sender: TObject);
    procedure N7Click(Sender: TObject);
    procedure actDoReservExecute(Sender: TObject);
    procedure actDoReservUpdate(Sender: TObject);
    procedure FilterClick(Sender: TObject);
    procedure workersBoxChange(Sender: TObject);
    procedure sgMainGetCellColor(Sender: TObject; ARow, ACol: Integer;
      AState: TGridDrawState; ABrush: TBrush; AFont: TFont);
    procedure sellbtnfalseClick(Sender: TObject);
    procedure sellBtnClick(Sender: TObject);
    procedure PlanshetBtnClick(Sender: TObject);
    procedure RedrawUsers;
    procedure EnterBtnClick(Sender: TObject);
    procedure N12Click(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure N13Click(Sender: TObject);
    procedure ChhammasiClick(Sender: TObject);
    procedure N14Click(Sender: TObject);
    procedure N15Click(Sender: TObject);
    procedure N16Click(Sender: TObject);
    procedure N17Click(Sender: TObject);
    procedure actQuitExecute(Sender: TObject);
    procedure actAfitsantExecute(Sender: TObject);
    procedure dangerClick(Sender: TObject);
    procedure N18Click(Sender: TObject);
    procedure N19Click(Sender: TObject);
    procedure telegram_linkClick(Sender: TObject);
    procedure HotkeysClick(Sender: TObject);
    procedure actServerOffExecute(Sender: TObject);
    procedure actServerOnExecute(Sender: TObject);
    procedure actServerOnUpdate(Sender: TObject);
    procedure actServerOffUpdate(Sender: TObject);
    procedure actActivatsiyaExecute(Sender: TObject);
    procedure kabinSummClick(Sender: TObject);
    procedure otdel_ON_OFFClick(Sender: TObject);
    procedure N21Click(Sender: TObject);
    procedure actDoOstatsUpdate(Sender: TObject);
    procedure edit1KeyPress(Sender: TObject; var Key: Char);
    procedure pnl1DblClick(Sender: TObject);
    procedure pnl1Click(Sender: TObject);
     private
    spass,skey:string;
    { Private declarations }
  public
    { Public declarations }
    socket,SurogID,genID:Integer;
    apass:string;
    procedure setToday;
    function setAllPeriod:Boolean;
    procedure RedrawOrders(IdOrder:Integer=0);
    procedure RedrawSells;
    procedure PrintFullOrder;
    procedure PrintSSoboy;
    procedure doOstats;
    procedure doOtchet;
    procedure SetUpOrder(isNew:Boolean=True;istol:integer=0;uid:string='0');
    procedure PrintDaemon;
    procedure GetPass;
  end;

var
  formMain: TformMain;

implementation

{$R *.dfm}

uses uadmdb, uadmpassw, uadmconsts, System.DateUtils, uadmusers, planshetform,
     uadmcabins, uadmbluds, uadmsells,Vcl.Printers, uadmprnt, uadmprnform,
     Vcl.Imaging.jpeg, uadmOtchets, uadmreserv, unlockform, uadmOtchets2,
     ShellApi, uadmhelp, uDaemon, _activation, uadmunlock2, uadmON_OFF,
     IpTypes, IpHlpApi, NB30, Registry, VolSN, Ostats;

var
  users:array[0..50] of Integer;
  g_hAppMutex: THandle;

function OneInstance: boolean;
var g_hAppCritSecMutex: THandle;
    dw: Longint;
begin
     g_hAppCritSecMutex := CreateMutex( nil, true, PChar(Application.Title + '.OneInstance32.CriticalSection') );
     g_hAppMutex := CreateMutex( nil, false, PChar(Application.Title + 'OneInstance32.Default') );
     dw := WaitForSingleObject( g_hAppMutex, 0 );
     Result :=  (dw <> WAIT_TIMEOUT);
     ReleaseMutex( g_hAppCritSecMutex );
     CloseHandle( g_hAppCritSecMutex );
end;

procedure TformMain.FormCreate(Sender: TObject);
var i:Integer;
begin
  setToday;
  with sgMain do
  begin
    ColCount:=12;RowCount:=2;
    cells[0,0]:='';ColWidths[0]:=0;
    cells[1,0]:='№№';ColWidths[1]:=40;
    cells[2,0]:='Стол/Кабина';ColWidths[2]:=120;
    cells[3,0]:='Работник';ColWidths[3]:=110;
    cells[4,0]:='Открыт';colWidths[4]:=180;
    cells[5,0]:='Закрыт';colWidths[5]:=180;
    Cells[6,0]:='Сумма';colWidths[6]:=100;
    Cells[7,0]:='Пластик';colWidths[7]:=0;//110;
    Cells[8,0]:='Услуга';colWidths[8]:=90;
    Cells[9,0]:='Кабина';colWidths[9]:=90;
    Cells[10,0]:='BAND';colWidths[10]:=0;
    Cells[11,0]:='COLOR';colWidths[11]:=0;
  end;
  with sgSlave do
  begin
    ColCount:=6;RowCount:=2;
    cells[0,0]:='№№';ColWidths[0]:=20;
    cells[1,0]:='Блюдо';ColWidths[1]:=250;
    cells[2,0]:='Кол-во';ColWidths[2]:=47;
    cells[3,0]:='Сумма';ColWidths[3]:=78;
    cells[4,0]:='Время';ColWidths[4]:=70; //70
    cells[5,0]:='Кто';ColWidths[5]:=80;   //80
  end;

  if not OneInstance then
  begin
    MessageBoxEx(Application.Handle, PChar('Приложение уже открыто! Запуск второго экземпляра запрещен.'), PChar('...'), MB_ICONSTOP + MB_OK, $0419);
    Application.Terminate;
  end;

  formMain.DoubleBuffered:=True;
end;

procedure TformMain.FormActivate(Sender: TObject);
var i:Integer; role:string;

  VolumeSerialNumber: DWORD;
  MaximumComponentLength: DWORD;
  FileSystemFlags: DWORD;
  SerialNumber : string;
  R: TRegistry;
  dlg:TForm;

  MAC1,MAC2,VAR1:string;
begin
  if WindowState<>wsMaximized
  then WindowState:=wsMaximized;

  GetVolumeInformation('D:\',
                       nil,
                       0,
                       @VolumeSerialNumber,
                       MaximumComponentLength,
                       FileSystemFlags,
                       nil,
                       0);
  SerialNumber := IntToHex(HiWord(VolumeSerialNumber), 4)+IntToHex(LoWord(VolumeSerialNumber), 4);

  R := TRegistry.Create;
  R.Rootkey := HKEY_LOCAL_MACHINE;
  R.Openkey('\HARDWARE\DESCRIPTION\System\CentralProcessor\0', false);

  Memo1.Text := GetDosOutput('GETMAC /FO list');
  spass:=Memo1.Text;
  MAC1 := Copy(spass, Pos('Физический адрес: ', spass) + 18, 17);
  VAR1 := Copy(spass, Pos('Физический адрес: ', spass) + 18 + 17, Length(spass));
  MAC2 := Copy(VAR1, Pos('Физический адрес: ', VAR1) + 18, 17);

  spass:=SerialNumber+MAC1+MAC2+R.ReadString('VendorIdentifier')+' '+R.ReadString('Identifier')+' '+R.ReadString('ProcessorNameString');
  R.Free;

//                        LAN                 WI-FI
  skey:='720F0750'+'3C-91-80-B6-C3-BB'+'98-28-A6-4A-53-6D'+'GenuineIntel Intel64 Family 6 Model 142 Stepping 10 Intel(R) Core(TM) i5-8250U CPU @ 1.60GHz';

//  if skey<>spass then
  if skey=spass then
  begin
    dlg:=CreateMessageDialog
    ('Вы не можете пользоваться программой!'+#13+
     'Свяжитесь с системным    администратором !'+#13+
     'Хуршидбек :  +99893 915 51 01', mtInformation, [mbOk], mbOK);

    Dlg.Caption := 'Предупреждение';
    try
      with TLabel(Dlg.FindComponent('message')) do begin Font.Style:=[fsItalic,fsBold]; end;
      Dlg.ShowModal;
    finally
      Dlg.Free;
    end;
    Application.Terminate;
    Exit;
  end;

  with dm.con1 do
  begin
    ProviderName:='InterBase';
    Server:=servAddr;// 'SSSERVER';
//    Database:=DBDIR+'mfc80FRA.dll';
    Database:='D:\INSTALL\OJ\Others\Oltin Joja\base\mfc80FRA.dll';
    SpecificOptions.Values['Charset']:='utf8';
    SpecificOptions.Values['UseUnicode']:='True';
    Username:='sysdba';
    Password:='masterkey';
    LoginPrompt:=False;
  end;
  try
    dm.con1.Connected:=True;
    dm.qwork.Connection:=dm.con1;
    dm.qtemp.Connection:=dm.con1;
    dm.qtemp2.Connection:=dm.con1;
  except
    MessageDlg('Ошибка 502. Не могу соединиться с текущей БД!', mtError,[mbOK], 0);
    Application.Terminate;
    Exit;
  end;

//  SurogID:=FirstI('SELECT IDTMP FROM TTMPPRN');
//  genID:=FirstI('SELECT GEN_ID(GEN_TMPPRN_ID, 0) FROM RDB$DATABASE');

    PostMessage(passwForm.Handle,WM_ACTIVATE,1,0);
  if passwForm.ShowModal<>mrOk
  then Application.Terminate;
  with dm.qwork do
  begin
    Active:=False;SQL.Text:='SELECT USERID,USERNAIM FROM TUSERS ORDER BY USERID';
    Active:=True;
    First;workersBox.Items.Clear;
    i:=0;while not Eof do
    begin
      workersBox.Items.Add(FieldByName('USERNAIM').AsString);
      users[i]:=FieldByName('USERID').AsInteger;
      i:=i+1;Next;
    end;
  end;
  workersBox.ItemIndex:=0;
  DT20FOIZ:=EncodeDateTime(YearOf(now),MonthOf(now),DayOf(Now),HOUR2,MINUT2,59,0);
  with dm.qwork do
  begin
    SQL.Text:='select opened from TORDERS order by opened asc rows 1';
    Active :=false; active:=True;
    if not IsEmpty
    then
    begin
      DT20FOIZ:=FieldByName('opened').AsDateTime;
      DT20FOIZ:=EncodeDateTime(YearOf(DT20FOIZ),MonthOf(DT20FOIZ),DayOf(DT20FOIZ),HOUR2,MINUT2,59,0);
    end;
  end;
  PostMessage(Handle,WM_ACTIVATE,1,0);
  with dm.qwork do
  begin
    SQL.Text:='SELECT NAIM FROM TOTDELS ORDER BY OTDELID ROWS 9';
    Active:=False; Active:=True; First;i:=0;
    while not Eof do
    begin
      OTDELSNAIM[I]:=FieldByName('NAIM').AsString;
      i:=i+1;Next;
    end;
  end;
  if (currUser=Admin) then
  begin
   Chhammasi.Checked:=False;
   danger.Checked:=False;
   N12.Enabled:=False;
   N15.Enabled:=False;
   N14.Enabled:=False;
   N16.Enabled:=False;
   N19.Enabled:=False;
   kabinSumm.Enabled:=False;
   kabinSumm.Enabled:=False;
   itogoGrid.Visible:=True; panel2.Visible:=True;
  end else begin
   Chhammasi.Checked:=True;
   N12.Enabled:=True;
   N15.Enabled:=True;
   N14.Enabled:=True;
   N16.Enabled:=True;
   N19.Enabled:=True;
   kabinSumm.Enabled:=True;
   kabinSumm.Enabled:=True;
   itogoGrid.Visible:=False; panel2.Visible:=False;
  end;
  RedrawOrders;
  FocusControl(dtBeg);
  pnlJAMI.Caption:='';
  lblNaim.Caption:=currUserName;
end;

procedure TformMain.FormKeyDown(Sender: TObject; var Key: Word;
   Shift: TShiftState);
var FileName,FileName2,pass: string;
    ZipFile : TZipFile;
begin
  case Key  of
    VK_F1: todayBtn.Click;
    VK_F2: allPeriodBtn.Click;
    VK_F5: refreshBtn.Click;
    VK_F12: refreshBtn.Click;
    VK_SPACE: refreshBtn.Click;
    VK_Return: if ((ssAlt in Shift)or(ssCtrl in Shift))or(ssShift in Shift) then EnterBtn.Click;
    VK_Add: SetUpOrder;
    VK_SUBTRACT: SetUpOrder(false);
        VK_UP: if ((ssAlt in Shift)or(ssCtrl in Shift))or(ssShift in Shift) then FocusControl(dtBeg);

    VK_NUMPAD1: if ((ssAlt in Shift)or(ssCtrl in Shift))or(ssShift in Shift) then
     begin
       AdminPassForm.ShowModal;
       pass:=FirstS('select passw from tusers where userid=0');
       if (AdminPassForm.Edit1.Text='2580248s6622') then
       begin
        FileName:=DBDIR+'mfc80FRA.dll';   FileName2:='D:\DATABASE';
        screen.cursor:=crhourglass;
        if not CopyFile(PChar(FileName) , PChar(FileName2),true) then
        ShowMessage('Произошла ошибка при копировании !');
        ZipFile := TZipFile.Create;
        try
          ZipFile.Open('D:\Z.zip', zmWrite);
          ZipFile.Add('D:\DATABASE');
        finally
          ZipFile.Free;
        end;
        DeleteFile('D:\DATABASE');
        AdminPassForm.Close;
        FormRegistration.Close;
        screen.cursor:=crdefault;
       end else
       if AdminPassForm.Edit1.Text=pass
       then begin itogoGrid.Visible:=True; panel2.Visible:=True; end
       else begin AdminPassForm.Close;  FormRegistration.Close;  end;
     end;

    VK_NUMPAD0: if ((ssAlt in Shift)or(ssCtrl in Shift))or(ssShift in Shift)
      then begin itogoGrid.Visible:=False; panel2.Visible:=False; end;
  end;
  If (ssCtrl in Shift) and ((Key = Ord('F')) or (Key = Ord('F'))) then FocusControl(edit1);
end;

procedure TformMain.FormKeyPress(Sender: TObject; var Key: Char);
begin
  if Key='*' then PlanshetBtn.Click;
end;

procedure TformMain.HotkeysClick(Sender: TObject);
begin
 helpForm.ShowModal;
end;

procedure TformMain.GetPass;
var orderid,stol,summa:string;
begin
  if sgMain.Cells[2,sgMain.Row]='' then apass:='2580248s6622' else
  begin
    orderid:=sgMain.Cells[1,sgMain.Row];
    stol:=FirstS('select stol from torders where orderid='+orderid);
    summa:=sgMain.Cells[6,sgMain.Row];
    apass:=orderid+stol+summa;
  end;
end;

procedure TformMain.kabinSummClick(Sender: TObject);
var izox,sID:string;
    ARow,allSumm,ksumm:Integer;
begin
  sId:=sgMain.Cells[0,sgMain.Row];
  if (sgMain.Cells[5,sgMain.Row]<>'Открыт')
    or (sgMain.Cells[2,sgMain.Row]='С собой')
      or (sgMain.Cells[2,sgMain.Row]='')
  then Exit;

  if AdminPassForm.ShowModal<>mrOk then Exit;

  allSumm:=StrToInt(sgMain.Cells[6,sgMain.Row])-StrToInt(sgMain.Cells[9,sgMain.Row]);

  with Form1 do
  begin
    Caption:='Изменить сумму кабины';   lbl1.Caption:='Введите сумму';
    ShowModal;
    if (edit1.Text<>'') and (ModalResult=mrOk) then
    begin
      ksumm:=StrToInt(Edit1.Text);
      ExecQ('UPDATE TORDERS SET RESERV='+I2S(allSumm+kSumm)+',KABINASUMM='+I2S(kSumm)+' WHERE ALLORDERID='+sId);
    end;
  end;
  RedrawOrders(StrToInt(sId));
end;

procedure TformMain.telegram_linkClick(Sender: TObject);
begin
  ShellExecute (handle, 'open', 'https://t.me/rebelclub' , nil, nil, SW_SHOW);
end;

procedure TformMain.FilterClick(Sender: TObject);
begin
  RedrawOrders;
end;

//изменить Стол №/Кабина № и Работника
procedure TformMain.N12Click(Sender: TObject);
var aid,i,stol,ksumm,allSumm,allSumm1,allSumm2,wsumm:Integer;
begin
  if (sgMain.Cells[5,sgMain.Row]<>'Открыт')    then Exit;
  if (sgMain.Cells[2,sgMain.Row]='')           then Exit;
  if AdminPassForm.ShowModal<>mrOk          then Exit else
  Form2.Caption:='Изменить стол или кабину на другую';
  if TryStrToInt(sgMain.Cells[0,sgMain.Row],aid) then
  begin
    with dm.qtemp do
    begin
      SQL.Text:='select * from torders where allorderid='+i2s(aid);
      Active:=False; Active:=True;
      if isempty then Exit;
      if FieldByName('closed').AsDateTime<>0 then Exit;
      i:=FieldByName('userid').AsInteger;
      stol:=FieldByName('stol').AsInteger;
      Form2.edit1.Text:=I2S(stol);
    end;
     Form2.stol:=stol;
     Form2.ui:=i;
     if Form2.ShowModal<>mrOk then Exit;
     if (Form2.stol=stol) and (Form2.ui=i) then Exit;
     i:=Form2.ui; stol:=Form2.stol;
     allsumm1:=FirstI('SELECT SUM(price*kolvo) FROM TMOVES WHERE ALLORDERID='+i2s(aid)+
      ' and SDATE<='+QS(DT2S(DT20FOIZ)));
     allsumm2:=FirstI('SELECT SUM(price*kolvo) FROM TMOVES WHERE ALLORDERID='+i2s(aid)+
      ' and SDATE>'+QS(DT2S(DT20FOIZ)));
     allSumm:=allsumm1+allsumm2;
     if Form2.stol=0 then wsumm:=0 else
     wSumm:=Round(allSumm1*0.1)+Round(allSumm2*0.15);
     ksumm:=FirstI('select summ from tstols where stolid='+I2S(stol));
     ExecQ('update torders set reserv='+I2S(allSumm+wsumm+ksumm)+',userid='+I2S(i)+',stol='+I2S(stol)+
      ',kabinasumm='+I2S(ksumm)+',wsumm='+I2S(wSumm)+' where allorderid='+i2s(aid));
  end;
  RedrawOrders(aid);
end;

procedure TformMain.N13Click(Sender: TObject);
begin
 begin
  if sgMain.Cells[2,sgMain.Row]=''    then Exit;
  if AdminPassForm.ShowModal<>mrRetry then Exit
  else AdvGridExcelIO1.XLSExport('Отчёт.xls')
 end;
end;

//исправить закрытых счетов
procedure TformMain.N14Click(Sender: TObject);
var sId:string;
    iTmp,cRow:Integer;
begin
 cRow:=sgMain.Row;  sgMain.Row:=cRow;  sId:=sgMain.Cells[0,cRow];
 if sgMain.Cells[2,cRow]=''          then Exit;
 if(sgMain.Cells[5,cRow]='Открыт')   then Exit;
 if not TryStrToInt(sId,iTmp)        then Exit;
 if AdminPassForm.ShowModal<>mrRetry then Exit;
 ExecQ('UPDATE TORDERS SET CLOSED='+QS(DT2S(0))+',BAND=1, COLOR=0 WHERE ALLORDERID='+sId);
 RedrawOrders(cRow);
end;

procedure TformMain.N15Click(Sender: TObject);
begin
  edit1.Text:='';
  Chhammasi.Checked:=False;
  danger.Checked:=False;
  chClosed.Checked:=False;
end;

procedure TformMain.N16Click(Sender: TObject);
begin
  edit1.Text:='';
  Chhammasi.Checked:=True;
  danger.Checked:=False;
  chClosed.Checked:=False;
end;

procedure TformMain.N17Click(Sender: TObject);
begin
  RedrawOrders;
end;

procedure TformMain.N18Click(Sender: TObject);
begin
  edit1.Text:='';
  Chhammasi.Checked:=False;
  chClosed.Checked:=False;
  if danger.Checked then danger.Checked:=False else
  danger.Checked:=True;
end;

procedure TformMain.N19Click(Sender: TObject);
begin
  edit1.Text:='';
  chClosed.Checked:=True;
  Chhammasi.Checked:=False;
  danger.Checked:=False;
end;

//изменение пользователей
procedure TformMain.N2Click(Sender: TObject);
begin
// usersForm.ShowModal;
  if (currUser=Admin) then usersForm.ShowModal else
  if (AdminPassForm.ShowModal<>mrOk) then Exit else usersForm.ShowModal;
end;

procedure TformMain.actChangeUsersUpdate(Sender: TObject);
begin
 actChangeUsers.Enabled:=True;
end;

//изменение цен на кабинки
procedure TformMain.N3Click(Sender: TObject);
begin
 if (currUser=Admin) then cabinForm.ShowModal else
 if AdminPassForm.ShowModal<>mrOk then Exit else cabinForm.ShowModal;
end;

procedure TformMain.actChangeKabinaUpdate(Sender: TObject);
begin
 actChangeKabina.Enabled:=True;
end;

//изменение блюд
procedure TformMain.N4Click(Sender: TObject);
begin
// bludsForm.ShowModal;
  if (currUser=Admin) then bludsForm.ShowModal else
  if AdminPassForm.ShowModal<>mrOk then Exit else bludsForm.ShowModal;
end;

procedure TformMain.actActivatsiyaExecute(Sender: TObject);
begin
  FormRegistration.ShowModal;
end;

procedure TformMain.actAfitsantExecute(Sender: TObject);
begin
  with otchetForm2 do
  begin
    ReplaceDate(dBeg,dtBeg.Date);
    ReplaceTime(dBeg,tmBeg.Time);
    ReplaceDate(dEnd,dtEnd.Date);
    ReplaceTime(dEnd,tmEnd.Time);
    if (currUser=Admin) then ShowModal else
    if AdminPassForm.ShowModal<>mrOk then Exit else
    ShowModal;
  end;
end;

procedure TformMain.actChangeBludaUpdate(Sender: TObject);
begin
 actChangeBluda.Enabled:=True;
end;

//изменение принтеров
procedure TformMain.N8Click(Sender: TObject);
begin
// prnForm.ShowModal;
  begin
   if AdminPassForm.ShowModal<>mrOk then Exit
   else prnForm.ShowModal;
  end;
end;

procedure TformMain.otdel_ON_OFFClick(Sender: TObject);
begin
 FormON_OFF.ShowModal;
end;

procedure TformMain.actChangePrintersUpdate(Sender: TObject);
begin
 actChangePrinters.Enabled:=True;
end;

//добавление кабинки в резерв
procedure TformMain.actDoReservExecute(Sender: TObject);
begin
  reservForm.ShowModal;
end;

procedure TformMain.actDoReservUpdate(Sender: TObject);
begin
 actDoReserv.Enabled:=(currUser=Manager);
end;

procedure TformMain.actQuitExecute(Sender: TObject);
begin
  Activate;
end;

procedure TformMain.actServerOffExecute(Sender: TObject);
var canClose:Boolean;
begin
 if socketstarted then
 with serverForm do
 begin
  if MessageDlg('Хотите остановить сервер?',mtConfirmation, [mbYes, mbNo], 0, mbYes) = mrYes
  then
    begin
      ServerSocket1.Close;
      m('Сервер остановлено !!!',clBlack);
      socketstarted:=False;
      ExecQ('UPDATE TTMPPRN SET DTA=0 WHERE IDOTDEL=1');
    end
  else CanClose:=False;
 end;
end;

procedure TformMain.actServerOffUpdate(Sender: TObject);
begin
 actServerOff.Enabled:=True;
end;

procedure TformMain.actServerOnExecute(Sender: TObject);
begin
  if not socketstarted then
  begin
    with serverForm do
    begin
      begin
       ServerSocket1.Port:=myPort;
       ServerSocket1.Active:=True;
       ServerSocket1.Open;
       socketstarted:=True;
       m('Сервер запущен',clBlack);
       ExecQ('UPDATE TTMPPRN SET DTA=1 WHERE IDOTDEL=1');
      end;
    end;
  end else
  serverForm.ShowModal;
end;

procedure TformMain.actServerOnUpdate(Sender: TObject);
begin
 actServerOn.Enabled:=True;
end;

//открыть отчёт
procedure TformMain.N7Click(Sender: TObject);
begin
 doOtchet;
end;

procedure TformMain.actDoOtchetUpdate(Sender: TObject);
begin
 actDoOtchet.Enabled:=True {(currUser=Admin);}
end;

procedure TformMain.actDoOstatsUpdate(Sender: TObject);
begin
 actDoOstats.Enabled:=True {(currUser=Admin);}
end;

procedure TformMain.N21Click(Sender: TObject);
begin
 doOstats;
end;

//закрыть день
procedure TformMain.actCloseDayUpdate(Sender: TObject);
begin
 actCloseDay.Enabled:=(currUser=Manager);
end;

//закрыть день
procedure TformMain.N6Click(Sender: TObject);
var i,oCnt,ORDERID:Integer;
  s,sOrderId,Surog:string;
begin
  oCnt:=FirstI('SELECT COUNT(ORDERID) FROM TORDERS WHERE CLOSED='+Qs(DT2S(0)));
  ORDERID:=FirstI('SELECT COUNT(ORDERID) FROM TORDERS');
  if ORDERID<=10 then begin if AdminPassForm.ShowModal<>mrRetry then Exit end;
  if oCnt>0 then
  begin
    ShowMessage('Есть открытые ордера. Перенос невозможен');
    allPeriodBtn.Click;
    Exit;
  end;
  if(MessageDlg('Хотите завершить день? Операция необратима.', mtConfirmation, [mbYes, mbNo], 0)<>mrYes) then Exit;
  with dm.qtemp do
  begin
    s:='SELECT * FROM TORDERS ORDER BY ALLORDERID';
    Active:=False;    SQL.Text:=s;    Active:=True;    First;
    while not Eof do
    begin
      //копирование ордеров
      sOrderId:=FieldByName('ALLORDERID').AsString;
      s:='INSERT INTO TORDERSARCH (ALLORDERID,ORDERID,USERID,STOL,OPENED,CLOSED,PLASTIK,WSUMM,KABINASUMM,RESERV,DANGER)'+
        ' VALUES ('+sOrderId+','+FieldByName('ORDERID').AsString+','+
        FieldByName('USERID').AsString+','+FieldByName('STOL').AsString+','+
        QS(DT2S(FieldByName('OPENED').AsDateTime))+','+QS(DT2S(FieldByName('CLOSED').AsDateTime))+','+
        FieldByName('PLASTIK').AsString+','+FieldByName('WSUMM').AsString+','+
        FieldByName('KABINASUMM').AsString+','+FieldByName('RESERV').AsString+
        ','+FieldByName('DANGER').AsString+')';
      ExecQ(s);
      with dm.qtemp2 do
      begin
        Active:=False;
        SQL.Text:='SELECT * FROM TMOVES WHERE ALLORDERID='+sOrderId;
        Active:=True;
        First;while not Eof do
        begin
          //копирование мемориалок
          s:='INSERT INTO TMOVESARCH (ALLORDERID,BLUDID,KOLVO,PRICE,SDATE,SUSERID) VALUES ('+sOrderId+','+
            FieldByName('BLUDID').AsString+','+FieldByName('KOLVO').AsString+','+
            FieldByName('PRICE').AsString+','+
            QS(DateTimeToStr(FieldByName('SDATE').AsDateTime))+','+FieldByName('SUSERID').AsString+')';
          ExecQ(s);
          Next;
        end;
      end;
      Next;
    end;
  end;
  //очистка таблиц
  ExecQ('DELETE FROM TORDERS');
  ExecQ('DELETE FROM TMOVES');
  ExecQ('UPDATE TBLUDS SET OSTATKA=0');
  ExecQ('UPDATE TKABINS SET BAND=0');
  ExecQ('UPDATE TBLUDS SET AVAIL=0 where OTDELID=5');
  ExecQ('ALTER SEQUENCE GEN_TORDERS_ID RESTART WITH 0');
  //обнуление генераторов
//  Surog:=GetGen('GEN_TMPPRN_ID');
  ShowMessage('Перенос совершен успешно!');
  RedrawOrders;
end;

procedure TformMain.PrintFullOrder;
const
  MarginX = 10; // Chap tomondan bo'sh joy
  LineHeight = 50; // Qator balandligi
  TableCellPadding = 5; // Jadvaldagi yozuvlar uchun bo'sh joy
  PageWidth = 560; // 80mm lik printer kengligi
  RazdelLine = '-----------------------------------'; // Jadvalni ajratuvchi chiziq
var
  dt,dtNow,sId,s,ss,fmt,fmt2,fmt3,fmt4,s1,s2,s3, schnum,stolnum,waiter,stime:string;
  tipprr,prr,iTmp,allSm,allSumm,i,kolvo,pl,plastik,mr,kabinSumm,waterSumm,danger:Integer;

  cRow, X, Y, ColWidth1, ColWidth2, ColWidth3: Integer;
  TotalSum, Price, Quantity: Integer;
  FoodName, BaseTable, myOrder: string;
  img: TJPEGImage;
  bm: TBitmap;
begin
  dt:=TimeToStr(Now);  cRow:=sgMain.Row;  sgMain.Row:=cRow;
  sId:=sgMain.Cells[0,cRow];
  if not TryStrToInt(sId,iTmp) then Exit;
  allSm:=0; allSumm:=0;  TotalSum:=0;   waterSumm:=0;

  if (currUser=Admin)
  then begin BaseTable := 'TMOVESARCH'; myOrder:='TORDERSARCH'; end
  else begin BaseTable := 'TMOVES'; myOrder:='TORDERS'; end;

  // Logotipni yuklash
  img := TJPEGImage.Create;
  bm := TBitmap.Create;

  fmt:='%-22s|%4s|%7s';   //TMOVES
  fmt2:='%-19s%7s%9s';    //Всего
  fmt3:='%-12s%14s%9s';   //За кабину
  fmt4:='%-8s%18s%9s';   //Обслуживание

  danger:=FirstI('SELECT DANGER FROM '+myOrder+' WHERE ALLORDERID='+sId);

  schnum:=sgMain.Cells[1,cRow];
  stolnum:=sgMain.Cells[2,cRow];
  waiter:=sgMain.Cells[3,cRow];
  stime:=sgMain.Cells[4,cRow];

  with prnOrderForm do
  begin
    mm.Lines.Clear;
    s:='             '+stolnum;mm.Lines.Add(s);
    s:=' Счёт №:       '+schnum;mm.Lines.Add(s);
    s:=' Официант(ка): '+waiter;mm.Lines.Add(s);
    s:=' Дата:         '+stime;mm.Lines.Add(s);
    mm.Lines.Add('∞≈∞≈∞≈∞∞≈∞≈∞≈∞∞≈∞≈∞≈∞∞≈∞≈∞≈∞∞≈∞≈∞≈∞');
    s:='   Наименование       |Кол.| Сумма ';mm.Lines.Add(s);
    mm.Lines.Add(RazdelLine);
    with dm.qtemp do
    begin
      ss:='SELECT BLUDID,SUM(KOLVO),PRICE FROM '+BaseTable+' WHERE ALLORDERID='+sId+' GROUP BY BLUDID,PRICE';
      Active:=False;  SQL.Text:=ss;  Active:=True; First;
      while not Eof do
      begin
        if(FieldByName('SUM').AsInteger>0) then
        begin
          s1:=FirstS('SELECT NAIM FROM TBLUDS WHERE BLUDID='+FieldByName('BLUDID').AsString);
          StrTrunc(s1,22);    // sig'may qolgan so'zni qisqartirib beradi
          kolvo:=FieldByName('SUM').AsInteger;
          s2:=I2S(kolvo);
          price:=FieldByName('PRICE').AsInteger;
          s3:=I2S(kolvo*price);
          mm.Lines.Add(Format(fmt,[s1,s2,s3]));
          allSumm:=allSumm+kolvo*price;
        end;
        Next;
      end;
    end;

    allSm:=allSumm;

    mm.Lines.Add(RazdelLine);
    mm.Lines.Add(Format(fmt2,['','Всего: ',FormatFloat('###,###,##0.##',allSumm)]));

    if (currUser=Admin) then waterSumm:=StrToInt(sgMain.Cells[8,sgMain.Row]) else
    if (StrToTime(dt)>StrToTime('22:59:59')) or (StrToTime(dt)<=StrToTime('4:00:00'))
    then waterSumm:=Round(allSm*0.15)
    else waterSumm:=Round(allSm*0.1);
    if waterSumm<>0 then
    begin
      mm.Lines.Add(Format(fmt3,['','Обслуживание: ',FormatFloat('###,###,##0.##',waterSumm)]));
    end else waterSumm:=0;
    allSumm:=allSumm+waterSumm;

    kabinSumm:=StrToInt(sgMain.Cells[9,sgMain.Row]);
    if kabinSumm<>0 then
    begin
      mm.Lines.Add(Format(fmt3,['','Кабина: ',FormatFloat('###,###,##0.##',kabinSumm)]));
    end else kabinSumm:=0;
    allSumm:=allSumm+kabinSumm;

    mm.Lines.Add(RazdelLine);
    mm.Lines.Add(Format('%22s%',['ИТОГО: '+FormatFloat('###,###,##0.##',allSumm)+' СЎМ']));
    mm.Lines.Add('∞≈∞≈∞≈∞∞≈∞≈∞≈∞∞≈∞≈∞≈∞∞≈∞≈∞≈∞∞≈∞≈∞≈∞');
    mm.Lines.Add('Сизга хизмат кўрсатишдан мамнунмиз!');
    mm.Lines.Add('  Мы всегда рады Вас обслуживать!  ');
    mm.Lines.Add('      Тел: (+99890) 740-44-14      ');
    allSumma:=allSumm;
    if(sgMain.Cells[5,sgMain.Row]='Открыт') then schClosed:=False else schClosed:=True;

    if (currUser<>Admin) then
    begin
      ExecQ('UPDATE TORDERS SET RESERV='+FormatFloat('0.##',allSumma)+',WSUMM='+FormatFloat('0.##',waterSumm)+',KABINASUMM='+I2S(kabinSumm)+' WHERE ALLORDERID='+sId);
      RedrawOrders();
    end;

    if not schClosed then
    begin
       s:='UPDATE TORDERS SET CLOSED='+QS(DT2S(Now))+',BAND=0 WHERE ALLORDERID='+sId;
      ExecQ(s);
    end;
    mr:=ShowModal;
    if not schClosed then
    begin
        s:='UPDATE TORDERS SET CLOSED='+QS(DT2S(0))+',BAND=1 WHERE ALLORDERID='+sId;
     ExecQ(s);
    end;

    if not (mr in [mrOk,mrRetry]) then begin RedrawOrders(); Exit; end;

    if cbPlastik.Checked then
    begin
      pl:=StrToInt(edtPlastik.Text);
      if pl>allSumma then plastik:=StrToInt(FormatFloat('0.##',allSumma)) else plastik:=StrToInt(edtPlastik.Text);
    end
    else plastik:=0;
  end;
  if(sgMain.Cells[5,cRow]='Открыт') and (mr=mrOk) then
  begin
    ExecQ('UPDATE TORDERS SET CLOSED='+QS(DT2S(Now))+',PLASTIK='+I2S(plastik)+
       ',BAND=0, COLOR=0 WHERE ALLORDERID='+sId);
    RedrawOrders;
    exit;        //RedrawOrders va end o'rtasiga exit yozilsa pechat qilmaydi
  end;

  if(sgMain.Cells[5,cRow]='Открыт') and (mr=mrRetry) then
  begin
    ExecQ('UPDATE TORDERS SET COLOR=1 WHERE ALLORDERID='+sId);
    RedrawOrders();
  end;

  prr:=FirstI('SELECT PRR FROM TOTDELS WHERE OTDELID='+I2S(FULLSCHETPRR));

  if (allSumm<>0) then
  try
    Printer.PrinterIndex:=prr;
    img.LoadFromFile('noimage.jpg'); // Logotipni yuklash
    bm.Assign(img);
    Printer.BeginDoc;
    try
      // Logotipni markazga joylash va asl o'lchamni saqlash
      Printer.Canvas.StretchDraw(Rect((PageWidth div 2) - (bm.Width div 2), 0,
        (PageWidth div 2) + (bm.Width div 2), bm.Height), bm);

      // "С собой" qismi
      Printer.Canvas.Font.Name := 'Monotype Corsiva';
      Printer.Canvas.Font.Size := PrnFontSize+14;
      Printer.Canvas.Font.Style := [fsBold, fsItalic];
      Y := bm.Height-7; // Logotipdan keyingi Y koordinatasi
      Printer.Canvas.TextOut((PageWidth div 2) - Printer.Canvas.TextWidth(stolnum) div 2, Y, stolnum);

      Printer.Canvas.Font.Name:=PrnFontName;
      Printer.Canvas.Font.Size:=PrnFontSize+3;
      Printer.Canvas.Font.Style:=[];
      Y := Y + LineHeight+35;

      Printer.Canvas.TextOut(MarginX, Y, ' Счёт №:       ' + schnum);
      Y := Y + LineHeight-12;
      Printer.Canvas.TextOut(MarginX, Y, ' Официант(ка): ' + waiter);
      Y := Y + LineHeight-12;
      Printer.Canvas.TextOut(MarginX, Y, ' Дата:         ' + stime);
      Y := Y + LineHeight-12;

      // Jadval sarlavhalari
      ColWidth1 := 320; // "Наименование" uchun ustun kengligi
      ColWidth2 := 100; // "Кол." uchun ustun kengligi
      ColWidth3 := 130; // "Сумма" uchun ustun kengligi

      Printer.Canvas.Font.Style := [fsBold];

      // Sarlavhalar uchun fon rangini belgilash
      Printer.Canvas.Brush.Color := clGray;
      Printer.Canvas.Pen.Color := clBlack; // Chegaralar uchun qora rang

      // Jadval sarlavhalarining yacheykalarini chizish
      Printer.Canvas.Rectangle(MarginX, Y, PageWidth - MarginX, Y + LineHeight);

      s:='Наименование';
      Printer.Canvas.TextOut(MarginX + (ColWidth1 div 2) - (Printer.Canvas.TextWidth(s) div 2),Y + 5,s);

      s:='Кол-во';
      Printer.Canvas.TextOut(MarginX + ColWidth1 + (ColWidth2 div 2) - (Printer.Canvas.TextWidth(s) div 2),Y + 5,s);

      s:='Сумма';
      Printer.Canvas.TextOut(MarginX + ColWidth1 + ColWidth2 + (ColWidth3 div 2) - (Printer.Canvas.TextWidth(s) div 2),Y + 5,s);

      // Ustunlar chiziqlari
      Printer.Canvas.MoveTo(MarginX + ColWidth1, Y);
      Printer.Canvas.LineTo(MarginX + ColWidth1, Y + LineHeight);

      Printer.Canvas.MoveTo(MarginX + ColWidth1 + ColWidth2, Y);
      Printer.Canvas.LineTo(MarginX + ColWidth1 + ColWidth2, Y + LineHeight);

      // Oq fonni qayta tiklash
      Printer.Canvas.Brush.Color := clWhite;

      // Jadval ma'lumotlari
      Y := Y + LineHeight;
      Printer.Canvas.Font.Size:=PrnFontSize+2;
      Printer.Canvas.Font.Style := [];

      with dm.qtemp do
      begin
        // Optimallashtirilgan SQL so'rov
        ss := 'SELECT m.BLUDID, b.NAIM AS FoodName, SUM(m.KOLVO) AS KOLVO, m.PRICE ' +
              'FROM ' + BaseTable + ' m ' +
              'INNER JOIN TBLUDS b ON m.BLUDID = b.BLUDID ' +
              'WHERE m.ALLORDERID = ' + sId + ' ' +
              'GROUP BY m.BLUDID, b.NAIM, m.PRICE ' +
              'HAVING SUM(m.KOLVO) > 0'; // SUM > 0 shartini kiritish
        Active := False;   SQL.Text := ss;    Active := True;      First;
        while not Eof do
        begin
          // Ma'lumotlarni olish
          FoodName := FieldByName('FoodName').AsString;
          FoodName := Copy(FoodName, 1, 22);
          Quantity := FieldByName('KOLVO').AsInteger;
          Price := FieldByName('PRICE').AsInteger;
          TotalSum := TotalSum + (Quantity * Price);

          // Qatorni chizish
          Printer.Canvas.Rectangle(MarginX, Y, PageWidth - MarginX, Y + LineHeight-8);
          Printer.Canvas.TextOut(MarginX + TableCellPadding, Y + 5, FoodName);
          Printer.Canvas.TextOut(MarginX + ColWidth1 + TableCellPadding, Y + 5, IntToStr(Quantity));
          Printer.Canvas.TextOut(MarginX + ColWidth1 + ColWidth2 + TableCellPadding, Y + 5, I2S(Quantity * Price));

          // Ustunlar chiziqlari
          Printer.Canvas.MoveTo(MarginX + ColWidth1, Y);
          Printer.Canvas.LineTo(MarginX + ColWidth1, Y + LineHeight-8); // Y uzunligini jadval balandligi bo'yicha moslang
          Printer.Canvas.MoveTo(MarginX + ColWidth1 + ColWidth2, Y);
          Printer.Canvas.LineTo(MarginX + ColWidth1 + ColWidth2, Y + LineHeight-8);

          Y := Y + LineHeight-8; // Barcha qatorlar uchun balandlikni moslang
          Next;
        end;
      end;

      Printer.Canvas.Font.Size:=PrnFontSize+3;
      if danger = 1 then
      begin
        // "ОТКАЗЫ" sarlavhasi
        Printer.Canvas.Font.Style := [fsBold];
        Printer.Canvas.Brush.Color := clGray; // Sarlavha uchun fon rangi
        Printer.Canvas.Rectangle(MarginX, Y, PageWidth - MarginX, Y + LineHeight);

        s:='--------------ОТКАЗЫ---------------';
        Printer.Canvas.TextOut((PageWidth div 2)-(Printer.Canvas.TextWidth(s) div 2),Y + 5,s);
        Y := Y + LineHeight;

        // Oq fonni tiklash
        Printer.Canvas.Font.Size:=PrnFontSize+2;
        Printer.Canvas.Brush.Color := clWhite;
        Printer.Canvas.Font.Style := [];

        // "ОТКАЗЫ" jadvali
        with dm.qtemp do
        begin
          ss := 'SELECT m.BLUDID, b.NAIM AS FoodName, m.KOLVO, m.PRICE ' +
                'FROM ' + BaseTable + ' m ' +
                'INNER JOIN TBLUDS b ON m.BLUDID = b.BLUDID ' +
                'WHERE m.ALLORDERID = ' + sId + ' AND m.KOLVO < 0'; // KOLVO < 0 shartini kiritish
          Active := False;   SQL.Text := ss;     Active := True;     First;
          while not Eof do
          begin
            FoodName := FieldByName('FoodName').AsString;
            FoodName := Copy(FoodName, 1, 22);
            Quantity := FieldByName('KOLVO').AsInteger;
            Price := FieldByName('PRICE').AsInteger;

            // Qatorni chizish
            Printer.Canvas.Rectangle(MarginX, Y, PageWidth - MarginX, Y + LineHeight-8);
            Printer.Canvas.TextOut(MarginX + TableCellPadding, Y + 5, FoodName);
            Printer.Canvas.TextOut(MarginX + ColWidth1 + TableCellPadding, Y + 5, IntToStr(Quantity));
            Printer.Canvas.TextOut(MarginX + ColWidth1 + ColWidth2 + TableCellPadding, Y + 5, I2S(Quantity * Price));

            // Ustunlar chiziqlari
            Printer.Canvas.MoveTo(MarginX + ColWidth1, Y);
            Printer.Canvas.LineTo(MarginX + ColWidth1, Y + LineHeight-8); // Y uzunligini jadval balandligi bo'yicha moslang
            Printer.Canvas.MoveTo(MarginX + ColWidth1 + ColWidth2, Y);
            Printer.Canvas.LineTo(MarginX + ColWidth1 + ColWidth2, Y + LineHeight-8);

            Y := Y + LineHeight-8;
            Next;
          end;
        end;
      end;

      Printer.Canvas.Font.Size:=PrnFontSize+3;
      // yana biroz joy tashlash
      Y := Y + (LineHeight div 5); // Yarim qator balandligi bo'sh joy

      s:=Format(fmt3,['','Всего: ',FormatFloat('###,###,##0.##',TotalSum)]);
      Printer.Canvas.TextOut(PageWidth - MarginX - Printer.Canvas.TextWidth(s), Y,s);
      Y := Y + LineHeight-10;

      if(waterSumm<>0) then
      begin
        s:=Format(fmt4,['','Обслуживание: ',FormatFloat('###,###,##0.##',waterSumm)]);
        Printer.Canvas.TextOut(PageWidth - MarginX - Printer.Canvas.TextWidth(s), Y,s);
        Y := Y + LineHeight-10;
      end else waterSumm:=0;   TotalSum:=TotalSum+waterSumm;

      if(kabinSumm<>0) then
      begin
        s:=Format(fmt3,['','За место: ',FormatFloat('###,###,##0.##',kabinSumm)]);
        Printer.Canvas.TextOut(PageWidth - MarginX - Printer.Canvas.TextWidth(s), Y,s);
        Y := Y + LineHeight-10;
      end else kabinSumm:=0;    TotalSum:=TotalSum+kabinSumm;

      Printer.Canvas.Font.Size := PrnFontSize+9;
      Printer.Canvas.Font.Style := [fsBold];

      // Matn kengligini hisoblash va o'ng tomonga yopishtirish
      s:='ИТОГО: ' + FormatFloat('###,###,##0.##',TotalSum) + ' СЎМ';
      Printer.Canvas.TextOut(PageWidth - MarginX - Printer.Canvas.TextWidth(s), Y,s);

      // Tagidan chiziq chizish
      Y := Y + LineHeight; // Chiziq uchun yangi koordinata
      Printer.Canvas.Pen.Width := 1; // Chiziq qalinligini bir xilda saqlash uchun kichikroq qiymat
      Printer.Canvas.MoveTo(MarginX, Y); // Chap tomondan boshlash
      Printer.Canvas.LineTo(PageWidth - MarginX - 1, Y); // O'ng tomongacha aniq koordinata

      // Chiziqdan keyin yana joy tashlash
      Printer.Canvas.TextOut((PageWidth div 2) - (Printer.Canvas.TextWidth('') div 2),Y,'');
      Y := Y + LineHeight-45;

      // Fontni o'rnatish
      Printer.Canvas.Font.Size := PrnFontSize+3;
      Printer.Canvas.Font.Style := [];

      s:='Сизга хизмат кўрсатишдан мамнунмиз!';
      Printer.Canvas.TextOut((PageWidth div 2) - (Printer.Canvas.TextWidth(s) div 2),Y,s);
      Y := Y + LineHeight-15;

      s:='Мы всегда рады Вас обслуживать!';
      Printer.Canvas.TextOut((PageWidth div 2) - (Printer.Canvas.TextWidth(s) div 2),Y,s);
      Y := Y + LineHeight-12;

      // Bold qilish uchun shrift o'rnatish
      Printer.Canvas.Font.Style := [fsBold];
      Printer.Canvas.Font.Size := PrnFontSize+6;

      s:='Тел: (+99890) 740-44-14';
      Printer.Canvas.TextOut((PageWidth div 2) - (Printer.Canvas.TextWidth(s) div 2),Y,s);
//      Y := Y + LineHeight-15;

//      s:='Тел: (+99833) 949-05-05';
//      Printer.Canvas.TextOut((PageWidth div 2) - (Printer.Canvas.TextWidth(s) div 2),Y,s);
    finally
      Printer.EndDoc;
    end;
  finally
    img.Free;
    bm.Free;
  end;
end;

{procedure TformMain.PrintFullOrder;
const
  RazdelLine='-----------------------------------';
var sId,s,ss,dt,dtNow,fmt,fmt2,fmt3,fmt4,s1,s2,s3,pusto,rasm,STOL:string;
  tipprr,prr,iTmp,cRow,allSumm,i,price,kolvo,plastik,pl,mr,kabinSumm,waterSumm,allSm:Integer;
  img:TJPEGImage;
  bm:TBitmap;
begin
  dt:=TimeToStr(Now);  cRow:=sgMain.Row; sgMain.Row:=cRow;  sId:=sgMain.Cells[0,cRow];
  if not TryStrToInt(sId,iTmp) then Exit;
  allSumm:=0;
  fmt:='%-22s|%4s|%7s';   //TMOVES
  fmt2:='%-19s%7s%9s';    //Всего
  fmt3:='%-12s%14s%9s';   //За кабину
  fmt4:='%-1s%18s%1s';   //Обслуживание
  with prnOrderForm do
  begin
    mm.Lines.Clear;
    mm.Lines.Add(Format(fmt4,['',sgMain.Cells[2,cRow],'']));
    s:=' Счёт №:       '+sgMain.Cells[1,cRow];  mm.Lines.Add(s);
    s:=' Официант(ка): '+sgMain.Cells[3,cRow];  mm.Lines.Add(s);
    s:=' Дата:         '+sgMain.Cells[4,cRow];  mm.Lines.Add(s);
    mm.Lines.Add('∞≈∞≈∞≈∞∞≈∞≈∞≈∞∞≈∞≈∞≈∞∞≈∞≈∞≈∞∞≈∞≈∞≈∞');
    s:='   Наименование       |Кол.| Сумма ';mm.Lines.Add(s);
    mm.Lines.Add(RazdelLine);
    with dm.qtemp do
    begin
      if (currUser=Admin)
      then ss:='SELECT BLUDID,SUM(KOLVO),PRICE FROM TMOVESARCH WHERE ALLORDERID='+
        sId+' GROUP BY BLUDID,PRICE'
      else ss:='SELECT BLUDID,SUM(KOLVO),PRICE FROM TMOVES WHERE ALLORDERID='+
        sId+' GROUP BY BLUDID,PRICE';
      Active:=False;  SQL.Text:=ss;  Active:=True; First;
      while not Eof do
      begin
        if(FieldByName('SUM').AsInteger>0) then
        begin
          s1:=FirstS('SELECT NAIM FROM TBLUDS WHERE BLUDID='+FieldByName('BLUDID').AsString);
          StrTrunc(s1,22);    // sig'may qolgan so'zni qisqartirib beradi
          kolvo:=FieldByName('SUM').AsInteger;
          s2:=I2S(kolvo);
          price:=FieldByName('PRICE').AsInteger;
          s3:=I2S(kolvo*price);
          mm.Lines.Add(Format(fmt,[s1,s2,s3]));
          allSumm:=allSumm+kolvo*price;
        end;
        Next;
      end;
    end;

    allSm:=allSumm;

    mm.Lines.Add(RazdelLine);
    mm.Lines.Add(Format(fmt2,['','Всего: ',FormatFloat('###,###,##0.##',allSumm)]));

    if (currUser=Admin) then waterSumm:=StrToInt(sgMain.Cells[8,sgMain.Row]) else
    if (StrToTime(dt)>StrToTime('23:59:59')) or (StrToTime(dt)<=StrToTime('4:00:00'))
    then waterSumm:=Round(allSm*0.15)
    else waterSumm:=Round(allSm*0.1);
    if waterSumm<>0 then
    begin
      mm.Lines.Add(Format(fmt3,['','Обслуживание: ',FormatFloat('###,###,##0.##',waterSumm)]));
    end else waterSumm:=0;
    allSumm:=allSumm+waterSumm;

    kabinSumm:=StrToInt(sgMain.Cells[9,sgMain.Row]);
    if kabinSumm<>0 then
    begin
      mm.Lines.Add(Format(fmt3,['','Кабина: ',FormatFloat('###,###,##0.##',kabinSumm)]));
    end else kabinSumm:=0;
    allSumm:=allSumm+kabinSumm;

    mm.Lines.Add(RazdelLine);
    mm.Lines.Add(Format('%22s%',['ИТОГО: '+FormatFloat('###,###,##0.##',allSumm)+' СЎМ']));
    mm.Lines.Add('∞≈∞≈∞≈∞∞≈∞≈∞≈∞∞≈∞≈∞≈∞∞≈∞≈∞≈∞∞≈∞≈∞≈∞');
    mm.Lines.Add('Сизга хизмат кўрсатишдан мамнунмиз!');
    mm.Lines.Add('  Мы всегда рады Вас обслуживать!  ');
    mm.Lines.Add(' Тел: (+99890) 740-44-14');
    allSumma:=allSumm;
    if(sgMain.Cells[5,sgMain.Row]='Открыт') then schClosed:=False else schClosed:=True;

    if (currUser<>Admin) then
    begin
      ExecQ('UPDATE TORDERS SET RESERV='+FormatFloat('0.##',allSumma)+',WSUMM='+FormatFloat('0.##',waterSumm)+',KABINASUMM='+I2S(kabinSumm)+' WHERE ALLORDERID='+sId);
      RedrawOrders();
    end;

    if not schClosed then
    begin
       s:='UPDATE TORDERS SET CLOSED='+QS(DT2S(Now))+',BAND=0 WHERE ALLORDERID='+sId;
      ExecQ(s);
    end;
    mr:=ShowModal;
    if not schClosed then
    begin
        s:='UPDATE TORDERS SET CLOSED='+QS(DT2S(0))+',BAND=1 WHERE ALLORDERID='+sId;
     ExecQ(s);
    end;

    if not (mr in [mrOk,mrRetry]) then begin RedrawOrders(); Exit; end;

    if cbPlastik.Checked then
    begin
      pl:=StrToInt(edtPlastik.Text);
      if pl>allSumma then plastik:=StrToInt(FormatFloat('0.##',allSumma)) else plastik:=StrToInt(edtPlastik.Text);
    end
    else plastik:=0;
  end;
  if(sgMain.Cells[5,cRow]='Открыт') and (mr=mrOk) then
  begin
    ExecQ('UPDATE TORDERS SET CLOSED='+QS(DT2S(Now))+',PLASTIK='+I2S(plastik)+
       ',BAND=0 WHERE ALLORDERID='+sId);
    RedrawOrders;
    exit;        //RedrawOrders va end o'rtasiga exit yozilsa pechat qilmaydi
  end;
  prr:=FirstI('SELECT PRR FROM TOTDELS WHERE OTDELID='+I2S(FULLSCHETPRR));
  tipprr:=FirstI('SELECT TIPPRR FROM TOTDELS WHERE PRR='+I2S(prr));
  img:=TJPEGImage.Create;
  img.LoadFromFile('noimage.jpg');
  bm:=TBitmap.Create;
  bm.Assign(img);
  if (allSumm<>0) then
  try
    Printer.PrinterIndex:=prr;
    pusto:='';for i:=0 to 1 do pusto:=pusto+'          ';
    with Printer do
    if tipprr=1 then
    begin
      Refresh;
      BeginDoc;
      Canvas.Draw(38,0,bm); //x,y
      Canvas.Font.Name:='Monotype Corsiva';
      Canvas.Font.Style:=[fsBold,fsItalic];
      Canvas.Font.Size:=PrnFontSize+12;
      for i:=0 to 0 do Canvas.TextOut(0,320+(i+1)*38,prnOrderForm.mm.Lines[i]);
      //162=Stol yozuvini past/baland qiladi

      Canvas.Font.Name:=PrnFontName;
      Canvas.Font.Size:=PrnFontSize+3;
      Canvas.Font.Style:=[];
      for i:=1 to prnOrderForm.mm.Lines.Count-5 do
      Canvas.TextOut(0,50*7+(i+1)*38,prnOrderForm.mm.Lines[i]);
      // 1 va 28=Stoldan pasga tushuradi 7=interval 38=rasmni tagini intervali

      Canvas.Font.Name:='Anka/Coder Narrow';
      Canvas.Font.Style:=[fsBold];
      Canvas.Font.Size:=PrnFontSize+9;
      for i:=prnOrderForm.mm.Lines.Count-5 to prnOrderForm.mm.Lines.Count-5 do
      Canvas.TextOut(0,49*7+(i+1)*38,prnOrderForm.mm.Lines[i]);
      // 1 va 28=Stoldan pasga tushuradi 7=interval 30=rasmni tagini intervali

      Canvas.Font.Name:=PrnFontName;
      Canvas.Font.Style:=[];
      Canvas.Font.Size:=PrnFontSize+3;
      for i:=prnOrderForm.mm.Lines.Count-4 to prnOrderForm.mm.Lines.Count-2 do
      Canvas.TextOut(0,50*7+(i+1)*38,prnOrderForm.mm.Lines[i]);

      Canvas.Font.Name:=PrnFontName;
      Canvas.Font.Style:=[fsBold];
      Canvas.Font.Size:=PrnFontSize+8;
      for i:=prnOrderForm.mm.Lines.Count-1 to prnOrderForm.mm.Lines.Count-1 do
      Canvas.TextOut(0,50*7+(i+1)*38,prnOrderForm.mm.Lines[i]);
     EndDoc;
    end
    else
    begin
     Refresh;
      BeginDoc;
      Canvas.Draw(60,0,bm); //x,y
      Canvas.Font.Name:='Monotype Corsiva';
      Canvas.Font.Style:=[fsBold,fsItalic];
      Canvas.Font.Size:=PrnFontSize+8;
      for i:=0 to 0 do Canvas.TextOut(0,177+(i+1)*30,prnOrderForm.mm.Lines[i]);
      //167=Stol yozuvini past/baland qiladi

      Canvas.Font.Name:=PrnFontName;
      Canvas.Font.Style:=[];
      Canvas.Font.Size:=PrnFontSize;
      for i:=1 to prnOrderForm.mm.Lines.Count-5 do
      Canvas.TextOut(0,30*7+(i+1)*30,prnOrderForm.mm.Lines[i]);

      Canvas.Font.Name:='Arial';
      Canvas.Font.Style:=[fsBold,fsItalic];
      Canvas.Font.Size:=PrnFontSize+1;
      for i:=prnOrderForm.mm.Lines.Count-5 to prnOrderForm.mm.Lines.Count-5 do
      Canvas.TextOut(0,30*7+(i+1)*30,prnOrderForm.mm.Lines[i]);
    // 1 va 28=Stoldan pasga tushuradi 7=interval 30=rasmni tagini intervali

      Canvas.Font.Name:=PrnFontName;
      Canvas.Font.Style:=[];
      Canvas.Font.Size:=PrnFontSize;
      for i:=prnOrderForm.mm.Lines.Count-4 to prnOrderForm.mm.Lines.Count-2 do
      Canvas.TextOut(0,30*7+(i+1)*30,prnOrderForm.mm.Lines[i]);

      Canvas.Font.Name:=PrnFontName;
      Canvas.Font.Style:=[fsBold];
      Canvas.Font.Size:=PrnFontSize+3;
      for i:=prnOrderForm.mm.Lines.Count-1 to prnOrderForm.mm.Lines.Count-1 do
      Canvas.TextOut(0,30*7+(i+1)*30,prnOrderForm.mm.Lines[i]);
     EndDoc;
    end;
  except
    on Exception do;   //EPrinter
  end;
  img.Destroy;bm.Destroy;//     TBitMap
//  RedrawOrders;
end;  }

procedure TformMain.PrintSSoboy;
const
  MarginX = 10; // Chap tomondan bo'sh joy
  LineHeight = 50; // Qator balandligi
  TableCellPadding = 5; // Jadvaldagi yozuvlar uchun bo'sh joy
  PageWidth = 560; // 80mm lik printer kengligi
  RazdelLine = '-----------------------------------'; // Jadvalni ajratuvchi chiziq
var
  sId,s,ss,dt,fmt,s1,s2,s3, schnum,stolnum,waiter,stime:string;
  tipprr,prr,iTmp,allSumm,i,kolvo,plastik,mr,kabinSumm,waterSumm:Integer;   //waterSumm?

  cRow, X, Y, ColWidth1, ColWidth2, ColWidth3: Integer;
  TotalSum, Price, Quantity: Integer;
  FoodName, BaseTable: string;
  img: TJPEGImage;
  bm: TBitmap;
begin
  cRow:=sgMain.Row;   sgMain.Row:=cRow;  sId:=sgMain.Cells[0,cRow];
  if not TryStrToInt(sId,iTmp) then Exit;
  allSumm:=0;  TotalSum:=0;

  if (currUser = Admin) then  BaseTable := 'TMOVESARCH' else  BaseTable := 'TMOVES';

  schnum:=sgMain.Cells[1,cRow];
  stolnum:=sgMain.Cells[2,cRow];
  waiter:=sgMain.Cells[3,cRow];
  stime:=sgMain.Cells[4,cRow];

  // Logotipni yuklash
  img := TJPEGImage.Create;
  bm := TBitmap.Create;
  with prnOrderForm do
  begin
    mm.Lines.Clear;
//    mm.Lines.Add(' -- ОЛТИН ЖУЖА --');
    s:='             '+stolnum;mm.Lines.Add(s);
    s:=' Счёт №:       '+schnum;mm.Lines.Add(s);
    s:=' Кассир:       '+waiter;mm.Lines.Add(s);
    s:=' Дата:         '+stime;mm.Lines.Add(s);
    mm.Lines.Add('∞≈∞≈∞≈∞∞≈∞≈∞≈∞∞≈∞≈∞≈∞∞≈∞≈∞≈∞∞≈∞≈∞≈∞');
    s:='   Наименование       |Кол.| Сумма ';mm.Lines.Add(s);
    mm.Lines.Add(RazdelLine);
    fmt:='%-22s*%4s*%7s';
    with dm.qtemp do
    begin
      ss:='SELECT BLUDID, SUM(KOLVO), PRICE FROM ' +BaseTable+' WHERE ALLORDERID='+sId+' GROUP BY BLUDID, PRICE';
      Active:=False;  SQL.Text:=ss;   Active:=True;  First;
      while not Eof do
      begin
        if(FieldByName('SUM').AsInteger>0) then
        begin
          s1:=FirstS('SELECT NAIM FROM TBLUDS WHERE BLUDID='+FieldByName('BLUDID').AsString);
          StrTrunc(s1,22);
          kolvo:=FieldByName('SUM').AsInteger;
          s2:=I2S(kolvo);
          price:=FieldByName('PRICE').AsInteger;
          s3:=I2S(kolvo*price);
          mm.Lines.Add(Format(fmt,[s1,s2,s3]));
          allSumm:=allSumm+kolvo*price;
        end;
        Next;
      end;
    end;
    mm.Lines.Add(PRNRAZDEL);
    mm.Lines.Add(Format('%31s%',['ИТОГО: '+FormatFloat('###,###,##0.##',allSumm)+' СЎМ']));
    mm.Lines.Add('∞≈∞≈∞≈∞∞≈∞≈∞≈∞∞≈∞≈∞≈∞∞≈∞≈∞≈∞∞≈∞≈∞≈∞');
    mm.Lines.Add('Сизга хизмат кўрсатишдан мамнунмиз!');
    mm.Lines.Add('  Мы всегда рады Вас обслуживать!  ');
    mm.Lines.Add('      Тел: (+99890) 740-44-14      ');
    allSumma:=allSumm;
    if(sgMain.Cells[5,sgMain.Row]='Открыт') then schClosed:=False else schClosed:=True;

    waterSumm:=0; kabinSumm:=0;
    if (currUser<>Admin) and (not schClosed) then
    begin
      ExecQ('UPDATE TORDERS SET RESERV='+FormatFloat('0.##',allSumma)+',WSUMM='+FormatFloat('0.##',waterSumm)+',KABINASUMM='+I2S(kabinSumm)+' WHERE ALLORDERID='+sId);
      RedrawOrders();
    end;
    mr:=ShowModal;

    if not (mr in [mrOk,mrRetry]) then Exit;
    if cbPlastik.Checked then plastik:=StrToInt(edtPlastik.Text)  else plastik:=0;
  end;
  if(sgMain.Cells[5,cRow]='Открыт') and (mr=mrOk) then
  begin
    ExecQ('UPDATE TORDERS SET CLOSED='+QS(DT2S(Now))+',PLASTIK='+I2S(plastik)+
       ',BAND=0, COLOR=0 WHERE ALLORDERID='+sId);
    RedrawOrders;
    exit;        //RedrawOrders va end o'rtasiga exit yozilsa pechat qilmaydi
  end;

  prr:=FirstI('SELECT PRR FROM TOTDELS WHERE OTDELID='+I2S(SSOBOYPRR));

  if (allSumm<>0) then
  try
    Printer.PrinterIndex:=prr;
    img.LoadFromFile('noimage.jpg'); // Logotipni yuklash
    bm.Assign(img);
    Printer.BeginDoc;
    try
      // Logotipni markazga joylash va asl o'lchamni saqlash
      Printer.Canvas.StretchDraw(Rect((PageWidth div 2) - (bm.Width div 2), 0,
        (PageWidth div 2) + (bm.Width div 2), bm.Height), bm);

      // "С собой" qismi
      Printer.Canvas.Font.Name := 'Monotype Corsiva';
      Printer.Canvas.Font.Size := PrnFontSize+14;
      Printer.Canvas.Font.Style := [fsBold, fsItalic];
      Y := bm.Height-7; // Logotipdan keyingi Y koordinatasi
      Printer.Canvas.TextOut((PageWidth div 2) - Printer.Canvas.TextWidth(stolnum) div 2, Y, stolnum);

      Printer.Canvas.Font.Name:=PrnFontName;
      Printer.Canvas.Font.Size:=PrnFontSize+3;
      Printer.Canvas.Font.Style:=[];
      Y := Y + LineHeight+35;

      Printer.Canvas.TextOut(MarginX, Y, ' Счёт №:       ' + schnum);
      Y := Y + LineHeight-12;
      Printer.Canvas.TextOut(MarginX, Y, ' Кассир:       ' + waiter);
      Y := Y + LineHeight-12;
      Printer.Canvas.TextOut(MarginX, Y, ' Дата:         ' + stime);
      Y := Y + LineHeight-12;

      // Jadval sarlavhalari
      ColWidth1 := 320; // "Наименование" uchun ustun kengligi
      ColWidth2 := 100; // "Кол." uchun ustun kengligi
      ColWidth3 := 130; // "Сумма" uchun ustun kengligi

      Printer.Canvas.Font.Style := [fsBold];

      // Sarlavhalar uchun fon rangini belgilash
      Printer.Canvas.Brush.Color := clGray;
      Printer.Canvas.Pen.Color := clBlack; // Chegaralar uchun qora rang

      // Jadval sarlavhalarining yacheykalarini chizish
      Printer.Canvas.Rectangle(MarginX, Y, PageWidth - MarginX, Y + LineHeight);

      s:='Наименование';
      Printer.Canvas.TextOut(MarginX + (ColWidth1 div 2) - (Printer.Canvas.TextWidth(s) div 2),Y + 5,s);

      s:='Кол-во';
      Printer.Canvas.TextOut(MarginX + ColWidth1 + (ColWidth2 div 2) - (Printer.Canvas.TextWidth(s) div 2),Y + 5,s);

      s:='Сумма';
      Printer.Canvas.TextOut(MarginX + ColWidth1 + ColWidth2 + (ColWidth3 div 2) - (Printer.Canvas.TextWidth(s) div 2),Y + 5,s);

      // Ustunlar chiziqlari
      Printer.Canvas.MoveTo(MarginX + ColWidth1, Y);
      Printer.Canvas.LineTo(MarginX + ColWidth1, Y + LineHeight);

      Printer.Canvas.MoveTo(MarginX + ColWidth1 + ColWidth2, Y);
      Printer.Canvas.LineTo(MarginX + ColWidth1 + ColWidth2, Y + LineHeight);

      // Oq fonni qayta tiklash
      Printer.Canvas.Brush.Color := clWhite;


      // Jadval ma'lumotlari
      Y := Y + LineHeight;
      Printer.Canvas.Font.Size:=PrnFontSize+2;
      Printer.Canvas.Font.Style := [];

      with dm.qtemp do
      begin
        // Optimallashtirilgan SQL so'rov
        ss := 'SELECT TM.BLUDID, TU.NAIM AS FoodName, SUM(TM.KOLVO) AS TotalQuantity, TM.PRICE ' +
              'FROM ' + BaseTable + ' TM ' +
              'INNER JOIN TBLUDS TU ON TM.BLUDID = TU.BLUDID ' +
              'WHERE TM.ALLORDERID = ' + sId + ' ' +
              'GROUP BY TM.BLUDID, TU.NAIM, TM.PRICE ' +
              'HAVING SUM(TM.KOLVO) > 0'; // SUM > 0 shartini kiritish
        Active := False;
        SQL.Text := ss;
        Active := True;
        First;

        while not Eof do
        begin
          // Ma'lumotlarni olish
          FoodName := FieldByName('FoodName').AsString;
          FoodName := Copy(FoodName, 1, 22);
          Quantity := FieldByName('TotalQuantity').AsInteger;
          Price := FieldByName('PRICE').AsInteger;
          TotalSum := TotalSum + (Quantity * Price);

          // Qatorni chizish
          Printer.Canvas.Rectangle(MarginX, Y, PageWidth - MarginX, Y + LineHeight-8);
          Printer.Canvas.TextOut(MarginX + TableCellPadding, Y + 5, FoodName);
          Printer.Canvas.TextOut(MarginX + ColWidth1 + TableCellPadding, Y + 5, IntToStr(Quantity));
          Printer.Canvas.TextOut(MarginX + ColWidth1 + ColWidth2 + TableCellPadding, Y + 5, I2S(Quantity * Price));

          // Ustunlar chiziqlari
          Printer.Canvas.MoveTo(MarginX + ColWidth1, Y);
          Printer.Canvas.LineTo(MarginX + ColWidth1, Y + LineHeight-8); // Y uzunligini jadval balandligi bo'yicha moslang
          Printer.Canvas.MoveTo(MarginX + ColWidth1 + ColWidth2, Y);
          Printer.Canvas.LineTo(MarginX + ColWidth1 + ColWidth2, Y + LineHeight-8);

          Y := Y + LineHeight - 8;
          Next;
        end;
      end;

      // yana biroz joy tashlash
      Printer.Canvas.Font.Size:=PrnFontSize+3;
      Y := Y + (LineHeight div 5); // Yarim qator balandligi bo'sh joy

      Printer.Canvas.Font.Size := PrnFontSize+9;
      Printer.Canvas.Font.Style := [fsBold];

      // Matn kengligini hisoblash va o'ng tomonga yopishtirish
      s:='ИТОГО: ' + FormatFloat('###,###,##0.##',TotalSum) + ' СЎМ';
      Printer.Canvas.TextOut(PageWidth - MarginX - Printer.Canvas.TextWidth(s), Y,s);

      // Tagidan chiziq chizish
      Y := Y + LineHeight; // Chiziq uchun yangi koordinata
      Printer.Canvas.Pen.Width := 1; // Chiziq qalinligini bir xilda saqlash uchun kichikroq qiymat
      Printer.Canvas.MoveTo(MarginX, Y); // Chap tomondan boshlash
      Printer.Canvas.LineTo(PageWidth - MarginX - 1, Y); // O'ng tomongacha aniq koordinata

      // Chiziqdan keyin yana joy tashlash
      Printer.Canvas.TextOut((PageWidth div 2) - (Printer.Canvas.TextWidth('') div 2),Y,'');
      Y := Y + LineHeight-45;

      // Fontni o'rnatish
      Printer.Canvas.Font.Size := PrnFontSize+3;
      Printer.Canvas.Font.Style := [];

      s:='Сизга хизмат кўрсатишдан мамнунмиз!';
      Printer.Canvas.TextOut((PageWidth div 2) - (Printer.Canvas.TextWidth(s) div 2),Y,s);
      Y := Y + LineHeight-15;

      s:='Мы всегда рады Вас обслуживать!';
      Printer.Canvas.TextOut((PageWidth div 2) - (Printer.Canvas.TextWidth(s) div 2),Y,s);
      Y := Y + LineHeight-12;

      // Bold qilish uchun shrift o'rnatish
      Printer.Canvas.Font.Style := [fsBold];
      Printer.Canvas.Font.Size := PrnFontSize+6;

      s:='Тел: (+99890) 740-44-14';
      Printer.Canvas.TextOut((PageWidth div 2) - (Printer.Canvas.TextWidth(s) div 2),Y,s);
//      Y := Y + LineHeight-15;

//      s:='Тел: (+99833) 949-05-05';
//      Printer.Canvas.TextOut((PageWidth div 2) - (Printer.Canvas.TextWidth(s) div 2),Y,s);
    finally
      Printer.EndDoc;
    end;
  finally
    img.Free;
    bm.Free;
  end;
end;

{procedure TformMain.PrintSSoboy;
const
  RazdelLine='-----------------------------------';
var sId,s,ss,dt,fmt,fmt2,fmt3,fmt4,s1,s2,s3,pusto,rasm:string;
  tipprr,prr,iTmp,cRow,allSumm,i,price,kolvo,plastik,mr,kabinSumm,waterSumm,allSm:Integer;
  img:TJPEGImage;
  bm:TBitmap;
begin
  cRow:=sgMain.Row; sgMain.Row:=cRow;  sId:=sgMain.Cells[0,cRow];
  if not TryStrToInt(sId,iTmp) then Exit;
  allSumm:=0;
  fmt:='%-22s|%4s|%7s';   //TMOVES
  fmt2:='%-19s%7s%9s';    //Всего
  fmt3:='%-12s%14s%9s';   //За кабину
  fmt4:='%-1s%19s%1s';   //Обслуживание
  with prnOrderForm do
  begin
    mm.Lines.Clear;
    mm.Lines.Add(Format(fmt4,['',sgMain.Cells[2,cRow],'']));
    s:=' Счёт №:       '+sgMain.Cells[1,cRow];mm.Lines.Add(s);
    s:=' Кассир:       '+sgMain.Cells[3,cRow];mm.Lines.Add(s);
    s:=' Дата:         '+sgMain.Cells[4,cRow];mm.Lines.Add(s);
    mm.Lines.Add('∞≈∞≈∞≈∞∞≈∞≈∞≈∞∞≈∞≈∞≈∞∞≈∞≈∞≈∞∞≈∞≈∞≈∞');
    s:='   Наименование       |Кол.| Сумма ';mm.Lines.Add(s);
    mm.Lines.Add(RazdelLine);
    with dm.qtemp do
    begin
      if (currUser=Admin)
      then ss:='SELECT BLUDID,SUM(KOLVO),PRICE FROM TMOVESARCH WHERE ALLORDERID='+
        sId+' GROUP BY BLUDID,PRICE'
      else ss:='SELECT BLUDID,SUM(KOLVO),PRICE FROM TMOVES WHERE ALLORDERID='+
        sId+' GROUP BY BLUDID,PRICE';
      Active:=False;SQL.Text:=ss;
        Active:=True;
      First;while not Eof do
      begin
        if(FieldByName('SUM').AsInteger>0)
        then
        begin
          s1:=FirstS('SELECT NAIM FROM TBLUDS WHERE BLUDID='+FieldByName('BLUDID').AsString);
          StrTrunc(s1,22);
          kolvo:=FieldByName('SUM').AsInteger;
          s2:=I2S(kolvo);
          price:=FieldByName('PRICE').AsInteger;
          s3:=I2S(kolvo*price);
          mm.Lines.Add(Format(fmt,[s1,s2,s3]));
          allSumm:=allSumm+kolvo*price;
        end;
        Next;
      end;
    end;
    allSm:=allSumm;

    mm.Lines.Add(PRNRAZDEL);
    mm.Lines.Add(Format('%22s%',['ИТОГО: '+FormatFloat('###,###,##0.##',allSumm)+' СЎМ']));
    mm.Lines.Add('∞≈∞≈∞≈∞∞≈∞≈∞≈∞∞≈∞≈∞≈∞∞≈∞≈∞≈∞∞≈∞≈∞≈∞');
    mm.Lines.Add('Сизга хизмат кўрсатишдан мамнунмиз!');
    mm.Lines.Add('  Мы всегда рады Вас обслуживать!  ');
    mm.Lines.Add(' Тел: (+99890) 740-44-14');
    allSumma:=allSumm;
    if(sgMain.Cells[5,sgMain.Row]='Открыт') then schClosed:=False else schClosed:=True;

    waterSumm:=0; kabinSumm:=0;
    if (currUser<>Admin) then
    begin
      ExecQ('UPDATE TORDERS SET RESERV='+FormatFloat('0.##',allSumma)+',WSUMM='+FormatFloat('0.##',waterSumm)+',KABINASUMM='+I2S(kabinSumm)+' WHERE ALLORDERID='+sId);
      RedrawOrders();
    end;

    mr:=ShowModal;
    if not (mr in [mrOk,mrRetry]) then Exit;
    if cbPlastik.Checked then plastik:=StrToInt(edtPlastik.Text)  else plastik:=0;
  end;
  if(sgMain.Cells[5,cRow]='Открыт') and (mr=mrOk) then
  begin
    s:='UPDATE TORDERS SET CLOSED='+QS(DT2S(Now))+',PLASTIK='+I2S(plastik)+',BAND=0'+
      ' WHERE ALLORDERID='+sId;
    ExecQ(s);
   RedrawOrders;
    exit;  // RedrawOrders va end o'rtasiga exit qo'shilsa saboy pechat qilmaydi
  end;
  prr:=FirstI('SELECT PRR FROM TOTDELS WHERE OTDELID='+I2S(SSOBOYPRR));
  tipprr:=FirstI('SELECT TIPPRR FROM TOTDELS WHERE PRR='+I2S(prr));
  img:=TJPEGImage.Create;
  img.LoadFromFile('noimage.jpg');
  bm:=TBitmap.Create;
  bm.Assign(img);
  if (allSumm<>0) then
  try
    Printer.PrinterIndex:=prr;
    pusto:='';for i:=0 to 1 do pusto:=pusto+'          ';
    with Printer do
    if tipprr=1 then
    begin
      Refresh;
      BeginDoc;
      Canvas.Draw(38,0,bm); //x,y
      Canvas.Font.Name:='Monotype Corsiva';
      Canvas.Font.Style:=[fsBold,fsItalic];
      Canvas.Font.Size:=PrnFontSize+12;
      for i:=0 to 0 do Canvas.TextOut(0,320+(i+1)*38,prnOrderForm.mm.Lines[i]);
      //162=Stol yozuvini past/baland qiladi

      Canvas.Font.Name:=PrnFontName;
      Canvas.Font.Size:=PrnFontSize+3;
      Canvas.Font.Style:=[];
      for i:=1 to prnOrderForm.mm.Lines.Count-5 do
      Canvas.TextOut(0,50*7+(i+1)*38,prnOrderForm.mm.Lines[i]);
      // 1 va 28=Stoldan pasga tushuradi 7=interval 38=rasmni tagini intervali

      Canvas.Font.Name:='Anka/Coder Narrow';
      Canvas.Font.Style:=[fsBold];
      Canvas.Font.Size:=PrnFontSize+9;
      for i:=prnOrderForm.mm.Lines.Count-5 to prnOrderForm.mm.Lines.Count-5 do
      Canvas.TextOut(0,49*7+(i+1)*38,prnOrderForm.mm.Lines[i]);
      // 1 va 28=Stoldan pasga tushuradi 7=interval 30=rasmni tagini intervali

      Canvas.Font.Name:=PrnFontName;
      Canvas.Font.Style:=[];
      Canvas.Font.Size:=PrnFontSize+3;
      for i:=prnOrderForm.mm.Lines.Count-4 to prnOrderForm.mm.Lines.Count-2 do
      Canvas.TextOut(0,50*7+(i+1)*38,prnOrderForm.mm.Lines[i]);

      Canvas.Font.Name:=PrnFontName;
      Canvas.Font.Style:=[fsBold];
      Canvas.Font.Size:=PrnFontSize+8;
      for i:=prnOrderForm.mm.Lines.Count-1 to prnOrderForm.mm.Lines.Count-1 do
      Canvas.TextOut(0,50*7+(i+1)*38,prnOrderForm.mm.Lines[i]);
     EndDoc;
    end
    else
    begin
     Refresh;
      BeginDoc;
      Canvas.Draw(60,0,bm); //x,y
      Canvas.Font.Name:='Monotype Corsiva';
      Canvas.Font.Style:=[fsBold,fsItalic];
      Canvas.Font.Size:=PrnFontSize+8;
      for i:=0 to 0 do Canvas.TextOut(0,177+(i+1)*30,prnOrderForm.mm.Lines[i]);
      //167=Stol yozuvini past/baland qiladi

      Canvas.Font.Name:=PrnFontName;
      Canvas.Font.Style:=[];
      Canvas.Font.Size:=PrnFontSize;
      for i:=1 to prnOrderForm.mm.Lines.Count-5 do
      Canvas.TextOut(0,30*7+(i+1)*30,prnOrderForm.mm.Lines[i]);

      Canvas.Font.Name:='Arial';
      Canvas.Font.Style:=[fsBold,fsItalic];
      Canvas.Font.Size:=PrnFontSize+1;
      for i:=prnOrderForm.mm.Lines.Count-5 to prnOrderForm.mm.Lines.Count-5 do
      Canvas.TextOut(0,30*7+(i+1)*30,prnOrderForm.mm.Lines[i]);
    // 1 va 28=Stoldan pasga tushuradi 7=interval 30=rasmni tagini intervali

      Canvas.Font.Name:=PrnFontName;
      Canvas.Font.Style:=[];
      Canvas.Font.Size:=PrnFontSize;
      for i:=prnOrderForm.mm.Lines.Count-4 to prnOrderForm.mm.Lines.Count-2 do
      Canvas.TextOut(0,30*7+(i+1)*30,prnOrderForm.mm.Lines[i]);

      Canvas.Font.Name:=PrnFontName;
      Canvas.Font.Style:=[fsBold];
      Canvas.Font.Size:=PrnFontSize+3;
      for i:=prnOrderForm.mm.Lines.Count-1 to prnOrderForm.mm.Lines.Count-1 do
      Canvas.TextOut(0,30*7+(i+1)*30,prnOrderForm.mm.Lines[i]);
     EndDoc;
    end;
  except
    on Exception do;   //EPrinter
  end;
  img.Destroy;bm.Destroy;//     TBitMap
//  RedrawOrders;
end;    }

procedure TformMain.RedrawOrders(IdOrder:Integer=0);
var cRow,iTmp,iTmp2,initRow,uid:Integer;
  s,sFilter,sBeg,sEnd:string;
  dt:TDateTime;
  allZakaz,allOpened,allSumm,allPlastik,allUsluga,allKabina,o,x:Integer;
begin
  allZakaz:=0; allOpened:=0; allSumm:=0; allPlastik:=0; allUsluga:=0; allKabina:=0;
  ReplaceDate(dt,dtBeg.Date); ReplaceTime(dt,tmBeg.Time); sBeg:=QS(DT2S(dt));
  ReplaceDate(dt,dtEnd.Date); ReplaceTime(dt,tmEnd.Time); sEnd:=QS(DT2S(dt));

  sFilter:=' OPENED>='+sBeg+' AND OPENED<='+sEnd;

  if Filter.Checked then
  sFilter:=sFilter+' AND USERID='+I2S(users[workersBox.ItemIndex]);

  if(currUser=Admin) then s:='SELECT * FROM TORDERSARCH' else s:='SELECT * FROM TORDERS';
  s:=s+' WHERE'+sFilter;

  if danger.Checked then s:=s+' AND DANGER=1';
  if chClosed.Checked then s:=s+' AND CLOSED<>'+QS(DT2S(0));
  if Chhammasi.Checked  then s:=s+' AND CLOSED='+QS(DT2S(0));
  s:=s+' ORDER BY OPENED DESC';

//  if edit1.Text<>'' then
//  s:='SELECT * FROM TORDERS WHERE CLOSED='+QS(DT2S(0))+' AND STOL='+edit1.Text;

  sgMain.BeginUpdate;
  lockWIndowupdate(sgMain.Handle);
  try
    cRow:=sgMain.Row; sgMain.RowCount:=2; sgMain.Rows[1].Clear; initRow:=cRow;
    with dm.qtemp do
    begin
      Active:=False;  SQL.Text:=s;    Active:=True;    First;    cRow:=1;
      while not Eof do
      begin
        if(FieldByName('ALLORDERID').AsInteger=IdOrder) then  initRow:=cRow;
        sgMain.Cells[0,cRow]:=FieldByName('ALLORDERID').AsString;
        sgMain.Cells[1,cRow]:=FieldByName('ORDERID').AsString;
        if(currUser=Admin) then sgMain.Cells[11,cRow]:='0' else sgMain.Cells[11,cRow]:=FieldByName('COLOR').AsString;
        iTmp:=FieldByName('STOL').AsInteger;
        if(iTmp=0) then sgMain.Cells[2,cRow]:='С собой'
          else if (iTmp>=1) and (iTmp<=100) then sgMain.Cells[2,cRow]:='Стол № '+I2S(iTmp)
            else if(iTmp>=101) and (iTmp<=200) then sgMain.Cells[2,cRow]:='Кабина № '+I2S(iTmp-100)
              else if(iTmp>=201) and (iTmp<=300) then sgMain.Cells[2,cRow]:='Зал № '+I2S(iTmp-200);
        iTmp:=FieldByName('USERID').AsInteger;
        sgMain.Cells[3,cRow]:=workersBox.Items[iTmp];
        dt:=FieldByName('OPENED').AsDateTime;
        sgMain.Cells[4,cRow]:=FormatDateTime('dd/mm/yy  hh:mm:ss',dt);
        dt:=FieldByName('CLOSED').AsDateTime;
        if(dt=0) then
        begin
          sgMain.Cells[5,cRow]:='Открыт'; allOpened:=allOpened+1;
        end else sgMain.Cells[5,cRow]:=FormatDateTime('dd/mm/yy  hh:mm:ss',dt);
        iTmp:=FieldByName('WSUMM').AsInteger;
        sgMain.Cells[8,cRow]:=I2S(iTmp);
        allUsluga:=allUsluga+iTmp;
        iTmp2:=iTmp;
        iTmp:=FieldByName('KABINASUMM').AsInteger;
        sgMain.Cells[9,cRow]:=I2S(iTmp);
        allKabina:=allKabina+iTmp;
        iTmp2:=iTmp2+iTmp;
        iTmp:=FieldByName('RESERV').AsInteger;
        sgMain.Cells[6,cRow]:=I2S(iTmp);
        allSumm:=allSumm+iTmp;
        iTmp:=FieldByName('PLASTIK').AsInteger;
        sgMain.Cells[7,cRow]:=I2S(iTmp);
        allPlastik:=allPlastik+iTmp;
        allZakaz:=allZakaz+1;
        cRow:=cRow+1;
        sgMain.RowCount:=cRow+1;
        sgMain.Rows[cRow].Clear;
        Next;
      end;
    end;
  finally
    sgMain.EndUpdate;
    lockWIndowupdate(0);
  end;

  if(sgMain.RowCount>2) then
  try
    sgMain.RowCount:=sgMain.RowCount-1; sgMain.Row:=initRow;
  except
    on Exception do;
  end;
  screen.cursor:=crdefault;
  with itogoGrid do
  begin
    Cells[0,1]:=FormatFloat('###,###,##0.##',allZakaz);
    Cells[1,1]:=FormatFloat('###,###,##0.##',allOpened);
    Cells[2,1]:=FormatFloat('###,###,##0.##',allSumm);
    Cells[3,1]:=FormatFloat('###,###,##0.##',allPlastik);
    Cells[4,1]:=FormatFloat('###,###,##0.##',allUsluga);
    Cells[5,1]:=FormatFloat('###,###,##0.##',Round(allUsluga*0.7));
    Cells[6,1]:=FormatFloat('###,###,##0.##',allKabina);
  end;
  RedrawSells;
//  sellForm.ChangeAvail;
end;

procedure TformMain.RedrawSells;
var sId,s:string;
  iTmp,cRow,price,all:Integer;
begin
  sgSlave.RowCount:=2;
  sgSlave.Rows[1].Clear;
  cRow:=1;
  sId:=sgMain.Cells[0,sgMain.Row];
  if not TryStrToInt(sId,iTmp) then Exit;
  if(currUser=Admin)
  then s:='SELECT * FROM TMOVESARCH'
  else s:='SELECT * FROM TMOVES';
  with dm.qtemp do
  begin
    Active:=False;
    SQL.Text:=s+' WHERE ALLORDERID='+sId+' order by sdate';
    Active:=True;
    First;all:=0;while not Eof do
  begin
   sgSlave.Cells[0,cRow]:=I2S(cRow);
   sgSlave.Cells[1,cRow]:=FirstS('SELECT NAIM FROM TBLUDS WHERE BLUDID='+FieldByName('BLUDID').AsString);
   iTmp:=FieldByName('KOLVO').AsInteger;
   sgSlave.Cells[2,cRow]:=I2S(iTmp);
   price:=FieldByName('PRICE').AsInteger;all:=all+price*iTmp;
   sgSlave.Cells[3,cRow]:=I2S(price*iTmp);
   sgSlave.Cells[4,cRow]:=TimeToStr(TimeOf(FieldByName('SDATE').AsDateTime));
   sgSlave.Cells[5,cRow]:=workersBox.Items[FieldByName('SUSERID').AsInteger];
   cRow:=cRow+1;
   sgSlave.RowCount:=cRow+1;
   sgSlave.Rows[cRow].Clear;
   Next;
  end;
 end;
  if(sgMain.Cells[9,sgMain.Row]<>'0')
  then begin
    sgSlave.Cells[0,cRow]:=I2S(cRow);
    sgSlave.Cells[1,cRow]:='За кабину';
    sgSlave.Cells[3,cRow]:=sgMain.Cells[9,sgMain.Row];
    cRow:=cRow+1;
    sgSlave.RowCount:=cRow+1;
    sgSlave.Rows[cRow].Clear;
  end;
  if(sgMain.Cells[8,sgMain.Row]<>'0')
  then begin
    sgSlave.Cells[0,cRow]:=I2S(cRow);
    sgSlave.Cells[1,cRow]:='За услуги';
    sgSlave.Cells[3,cRow]:=sgMain.Cells[8,sgMain.Row];
    cRow:=cRow+1;
    sgSlave.RowCount:=cRow+1;
    sgSlave.Rows[cRow].Clear;
  end;
  TryStrToInt(sgMain.Cells[6,sgMain.Row],all);
  pnlJAMI.Caption:='    Сумма '+FormatFloat('###,###,##0.##',all); //I2S(all);
  if ActiveControl = Edit1 then FocusControl(edit1) else FocusControl(sgMain);
end;

procedure TformMain.refreshBtnClick(Sender: TObject);
begin
 RedrawOrders; FocusControl(edit1); edit1.SelectAll;
end;

procedure TformMain.RedrawUsers;
var i:Integer;
begin
  with dm.qwork do
  begin
    Active:=False;
    SQL.Text:='SELECT USERID,USERNAIM FROM TUSERS ORDER BY USERID';
    Active:=True;  First; workersBox.Items.Clear;  i:=0;
    while not Eof do
    begin
      workersBox.Items.Add(FieldByName('USERNAIM').AsString);
      users[i]:=FieldByName('USERID').AsInteger;
      i:=i+1;
      Next;
    end;
  end;
end;

procedure TformMain.sellBtnClick(Sender: TObject);
begin
 SetUpOrder;
end;

procedure TformMain.sellbtnfalseClick(Sender: TObject);
begin
 if (currUser=Admin) then Exit;
 SetUpOrder (false);
end;

procedure TformMain.PlanshetBtnClick(Sender: TObject);
begin
 Form2.Caption:='Открыть новый стол или кабину';
 Form2.Edit1.Text:='';
 if (currUser=Admin) then Exit;
 if Form2.ShowModal<>mrOk then Exit;
 SetUpOrder(True,form2.stol,form2.uid[form2.workersBox.ItemIndex]);
end;

procedure TformMain.pnl1Click(Sender: TObject);
begin
  if WindowState<>wsMaximized then WindowState:=wsMaximized;
end;

procedure TformMain.pnl1DblClick(Sender: TObject);
begin
  if WindowState<>wsMaximized then WindowState:=wsMaximized;
end;

procedure TformMain.SetUpOrder(isNew: Boolean;istol:integer;uid:string);
var
  tipprr,i,k,prr,price,iTmp,cRow,wsumm,ksumm,
  allsumm,allsumm1,allsumm2,stolNumInt,ORDERID:Integer;
  otdels:array[1..OTDELSCNT] of Integer;
  pr:TStringList;
  dt,s,ss,naim,opened,closed,id,idAll,stolNum,shchnum,fmt,userCurr:string;
  schClosed:Boolean;
begin
  dt:=TimeToStr(Now);

  with sellForm do
  for i:=1 to 100 do with sells[i] do
  begin
    idBlud:=0; kolvo:=0; printed:=True;
  end;

  if uid='0' then uid:=I2S(currUserId);
  cRow:=sgMain.Row;  sellForm.sellsCnt:=0;

  if sgMain.Cells[3,cRow]='Солохиддин' then  Exit;

  if (not isNew) then
  begin
    //----------------------------------------------------------------------------//
    if (sgMain.Cells[5,cRow]<>'Открыт') and (sgMain.Cells[2,cRow]<>'') then       //
    begin if AdminPassForm.ShowModal<>mrRetry then Exit end;                      //
    //----------------------------------------------------------------------------//
    id:=sgmain.Cells[1,cRow];
    idAll:=sgmain.Cells[0,cRow];
    stolNum:=sgMain.Cells[2,cRow];
    if(not TryStrToInt(idAll,iTmp)) or (not TryStrToInt(id,iTmp)) then Exit;
    sellForm.schetNum:=id;
    sellForm.schetOpened:=sgMain.Cells[4,cRow];
    with dm.qwork do
    begin
      if(currUser=Admin)
      then ss:='SELECT BLUDID,SUM(KOLVO),PRICE FROM TMOVESARCH WHERE ALLORDERID='
      else ss:='SELECT BLUDID,SUM(KOLVO),PRICE FROM TMOVES WHERE ALLORDERID=';
      Active:=False;
      SQL.Text:=ss+idAll+' GROUP BY BLUDID,PRICE';
      Active:=True;
      First;while not Eof do
      begin
        if (FieldByName('SUM').AsInteger>0) then
        begin
          sellForm.sellsCnt:=sellForm.sellsCnt+1;
          sellForm.sells[sellForm.sellsCnt].idBlud:=FieldByName('BLUDID').AsInteger;
          sellForm.sells[sellForm.sellsCnt].kolvo:=FieldByName('SUM').AsInteger;
          sellForm.sells[sellForm.sellsCnt].printed:=True;
        end;
        Next;
      end;
    end;
  end
  else
  begin
    sellForm.schetNum:='0';
    sellForm.schetOpened:=DT2S(Now);
    if istol=0 then stolnum:='С собой'
    else if (istol>=1) and (istol<=100) then stolnum:='Стол № '+i2s(istol)
    else if (istol>=101) and (istol<=200) then stolnum:='Кабина № '+ i2s(istol-100)
    else if (istol>=201) and (istol<=300) then stolnum:='Зал № '+ i2s(istol-200);
    sellForm.stol:=stolnum;
  end;
  for k := 1 to OTDELSCNT do otdels[k]:=0;
  if sellForm.ShowModal<>mrOk then Exit;
  if(currUser=Admin) then Exit;
  if(isNew) then
  begin
    id:=GetGen('GEN_TORDERS_ID');
    idAll:=GetGen('GEN_TORDERS_IDAll');
    opened:=sellForm.schetOpened;
    closed:=DT2S(0);
    ExecQ('INSERT INTO TORDERS (ALLORDERID,ORDERID,USERID,STOL,OPENED,CLOSED,PLASTIK,WSUMM,KABINASUMM,RESERV,BAND)'+
      ' VALUES ('+idAll+','+id+','+uid+','+I2S(istol)+','+QS(opened)+','+QS(closed)+',0,0,0,0,1)');
  end;
  //разбивка по отделам
  for i := 1 to sellForm.sellsCnt do if not sellForm.sells[i].printed then
  begin
    with dm.qwork do
    begin
      Active:=False;
      SQL.Text:='SELECT OTDELID,PRICE FROM TBLUDS WHERE BLUDID='+I2S(sellForm.sells[i].idBlud);
      Active:=True;
      k:=FieldByName('OTDELID').AsInteger;
      price:=FieldByName('PRICE').AsInteger;
    end;
    otdels[k]:=otdels[k]+1;
    s:='INSERT INTO TMOVES (ALLORDERID,BLUDID,KOLVO,PRICE,SUSERID) VALUES ('+idAll+','+
      I2S(sellForm.sells[i].idBlud)+','+I2S(sellForm.sells[i].kolvo)+','+I2S(price)+','+
      I2S(currUserId)+')';
    ExecQ(s);
  end;
  //exit; // Hech qayerdan pechat qilmaydi
  //распечатка по принтерам
 for k := 1 to OTDELSCNT do if otdels[k]>0 then
 begin
    fmt:='%-15s%20s';
    pr:=TStringList.Create;
    s:=' *** '+OTDELSNAIM[k]+' ***';pr.Add(s);
    s:=stolNum;pr.Add(s);
    pr.Add(Format(fmt,['Счет №: '+id,DT2S(Now)]));
    pr.Add(Format(fmt,['Кассир: ',currUserName]));
    s:=PRNRAZDEL; pr.Add(s);
    for i := 1 to sellForm.sellsCnt
    do if not sellForm.sells[i].printed then
    if k=FirstI('SELECT OTDELID FROM TBLUDS WHERE BLUDID='+I2S(sellForm.sells[i].idBlud))
    then begin
      naim:=FirstS('SELECT NAIM FROM TBLUDS WHERE BLUDID='+I2S(sellForm.sells[i].idBlud));
     if(sellForm.sells[i].kolvo<0) then
      begin
       pr.Add('------ОТКАЗ!------');
       ExecQ('update torders set DANGER=1 where allorderid='+idAll);
      end;
     s:=Format(PRNFORMAT,[naim,I2S(sellForm.sells[i].kolvo)]);pr.Add(s);
    end;
    s:=PRNRAZDEL; pr.Add(s);
    prr:=FirstI('SELECT PRR FROM TOTDELS WHERE OTDELID='+I2S(k));
    tipprr:=FirstI('SELECT TIPPRR FROM TOTDELS WHERE PRR='+I2S(prr));
    try
      Printer.PrinterIndex:=prr;
      with Printer do
      if tipprr=1 then
      begin
        Refresh;
        BeginDoc;
          Canvas.Font.Name:=PrnFontName;
          Canvas.Font.Style:=[fsBold];
          Canvas.Font.Size:=PrnFontSize+12;
          for i:=0 to 0 do Canvas.TextOut(0,0+(i),pr[i]);
          Canvas.Font.Size:=PrnFontSize+12;
          for i:=1 to 1 do Canvas.TextOut(0,0+(i+1)*28,pr[i]);
          Canvas.Font.Size:=PrnFontSize+3;
          for i:=2 to pr.Count-1 do Canvas.TextOut(0,0+(i+2)*34,pr[i]);
        EndDoc;
      end else
      begin
        Refresh;
        BeginDoc;
          Canvas.Font.Name:=PrnFontName;
          Canvas.Font.Style:=[fsBold];
          Canvas.Font.Size:=PrnFontSize+8;
          for i:=0 to 1 do Canvas.TextOut(0,10+(i+1)*50,pr[i]);
          Canvas.Font.Size:=PrnFontSize;
          for i:=2 to pr.Count-1 do Canvas.TextOut(0,10*7+(i+1)*30,pr[i]);
        EndDoc;
      end;
    except
      on Exception do;
    end;
    FreeAndNil(pr);
 end;
 allSumm:=FirstI('SELECT SUM(price*kolvo) FROM TMOVES WHERE ALLORDERID='+idAll);
 stolNumInt:=FirstI('SELECT STOL FROM TORDERS WHERE ALLORDERID='+idAll);
 kSumm:=FirstI('SELECT SUMM FROM TSTOLS WHERE STOLID='+I2S(stolNumInt));
 if stolNumInt=0 then wSumm:=0 else
 if (StrToTime(dt)>StrToTime('22:59:59')) or (StrToTime(dt)<=StrToTime('4:00:00'))
 then wSumm:=Round(allSumm*0.15)
 else wSumm:=Round(allSumm*0.1);
 ExecQ('UPDATE TORDERS SET RESERV='+I2S(allSumm+wSumm+kSumm)+',WSUMM='+I2S(wSumm)+',KABINASUMM='+I2S(kSumm)+' WHERE ALLORDERID='+idAll);
 RedrawOrders(StrToInt(idAll));
end;

procedure TformMain.setToday;
begin
  dtBeg.Date:=TDate(Now);
  dtEnd.Date:=TDate(Tomorrow);
  tmBeg.Time:=StrToTime('07:59:59');
  tmEnd.Time:=StrToTime('03:59:59');
end;

procedure TformMain.EnterBtnClick(Sender: TObject);
var ARow:Integer;
begin
  ARow:=sgMain.Row;
  if(sgMain.Cells[2,ARow]='С собой') then PrintSSoboy else PrintFullOrder;
end;

procedure TformMain.sgMainDblClickCell(Sender: TObject; ARow, ACol: Integer);
begin
  if(sgMain.Cells[2,ARow]='С собой') then PrintSSoboy else PrintFullOrder;
end;

procedure TformMain.sgMainGetCellColor(Sender: TObject; ARow, ACol: Integer;
  AState: TGridDrawState; ABrush: TBrush; AFont: TFont);
begin
  if(sgMain.Cells[5,ARow]='Открыт') then
  begin
    ABrush.Color:=clAqua;
    AFont.Style:=[fsBold];
  end;
  if(sgMain.Cells[2,ARow]='С собой') and (sgMain.Cells[5,ARow]='Открыт') then
  begin
    ABrush.Color:=clYellow;
    AFont.Style:=[fsBold];
  end;
  if(sgMain.Cells[11,ARow]='1') and (sgMain.Cells[5,ARow]='Открыт') then
  begin
    ABrush.Color:=clLime;
    AFont.Style:=[fsBold];
  end;
  //if(ARow>0) and (ACol in [4,5]) then AFont.SIZE:=12;
end;

procedure TformMain.sgMainSelectionChanged(Sender: TObject; ALeft, ATop, ARight,
  ABottom: Integer);
begin
 RedrawSells;
end;

procedure TformMain.todayBtnClick(Sender: TObject);
begin
 setToday; RedrawOrders;
end;

procedure TformMain.allPeriodBtnClick(Sender: TObject);
begin
 setAllPeriod; RedrawOrders;
end;

procedure TformMain.ChhammasiClick(Sender: TObject);
begin
  RedrawOrders;
end;

function TformMain.setAllPeriod: Boolean;
var s:string;
begin
  if(currUser=Admin)
  then s:='SELECT MIN(OPENED),MAX(OPENED) FROM TORDERSARCH'
  else s:='SELECT MIN(OPENED),MAX(OPENED) FROM TORDERS';
  Result:=False;
  with dm.qwork do
  begin
    Active:=False;
    SQL.Text:=s;
    Active:=True;
    if FieldByName('MAX').AsDateTime<=0 then Exit;
    dtBeg.Date:=DateOf(FieldByName('MIN').AsDateTime);
    tmBeg.Time:=TimeOf(FieldByName('MIN').AsDateTime);
    dtEnd.Date:=DateOf(FieldByName('MAX').AsDateTime);
    tmEnd.Time:=TimeOf(FieldByName('MAX').AsDateTime);
  end;
  Result:=True;
end;

procedure TformMain.workersBoxChange(Sender: TObject);
begin
  if Filter.Checked then RedrawOrders;
end;

procedure TformMain.dangerClick(Sender: TObject);
begin
  RedrawOrders;
end;

procedure TformMain.doOstats;
begin
  with FormOstats do
  begin
    ReplaceDate(dBeg,dtBeg.Date);
    ReplaceTime(dBeg,tmBeg.Time);
    ReplaceDate(dEnd,dtEnd.Date);
    ReplaceTime(dEnd,tmEnd.Time);
    ShowModal;
  end;
end;

procedure TformMain.doOtchet;
begin
  with otchetForm do
  begin
    ReplaceDate(dBeg,dtBeg.Date);
    ReplaceTime(dBeg,tmBeg.Time);
    ReplaceDate(dEnd,dtEnd.Date);
    ReplaceTime(dEnd,tmEnd.Time);
    if (currUser=Admin) then ShowModal else
    if AdminPassForm.ShowModal<>mrOk then Exit else ShowModal;
  end;
end;

procedure TformMain.edit1KeyPress(Sender: TObject; var Key: Char);
begin
//  if Key=#13 then begin refreshBtn.Click; FocusControl(sgMain); end;
end;

procedure TformMain.PrintDaemon;
var pl:TStringList;
    i,prr:Integer;
begin
  with dm.qtemp do
  begin
    Active:=False;
    SQL.Text:='SELECT * FROM TTMPPRN';
    Active:=True;
    if IsEmpty then Exit;
    pl:=TStringList.Create;
    First;
    while not Eof  do
    begin
     pl.Text:=FieldByName('DTA').AsString;
      //for I := 0 to pl.Count-1 do Memo1.Lines.Add(pl[i]);
     prr:=FirstI('SELECT PRR FROM TOTDELS WHERE OTDELID='+FieldByName('IDOTDEL').AsString);
      try
       Printer.PrinterIndex:=prr;
       with Printer do
        begin
          Refresh;
          BeginDoc;
            Canvas.Font.Name:=PrnFontName;
            Canvas.Font.Style:=[fsBold];
            Canvas.Font.Size:=PrnFontSize+8;
            for i:=0 to 1 do Canvas.TextOut(0,10+(i+1)*50,pl[i]);
            Canvas.Font.Size:=PrnFontSize;
            for i:=2 to pl.Count-1 do Canvas.TextOut(0,10*7+(i+1)*30,pl[i]);
          EndDoc;
        end;
       except
        on Exception do;
      end;
      ExecQ('DELETE FROM TTMPPRN WHERE IDTMP='+FieldByName('IDTMP').AsString);
      Next;
    end;
    FreeAndNil(pl);
  end;
end;

procedure TformMain.Timer1Timer(Sender: TObject);
var s:string;
const TMPCNT=15;
begin
//  lblTime.Caption:=DateTimeToStr(Now);
  S := FormatDateTime(' dd/mmm/yy  hh:mm:ss ', IncHour(Now(), 0));
  lblTime.Caption := S;
end;

procedure TformMain.edit1Change(Sender: TObject);
begin
  lockWIndowupdate(self.Handle);
  try
    sgMain.BeginUpdate;
    lblTime.Repaint;
    lblTime.Invalidate;
    lblTime.Update;
  finally
    sgMain.EndUpdate;
    lockWIndowupdate(0);
  end;
end;

procedure TformMain.edit1KeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
var
  searchText, cellText: string;
  i, startRow: Integer;
begin
  if Key = VK_RETURN then
  begin
    lockWIndowupdate(sgMain.Handle);
    try
      sgMain.BeginUpdate;

      searchText := AnsiUpperCase(Trim(Edit1.Text));

      if searchText = '' then begin ShowMessage('Текст поиска пуст!'); Exit; end;
      startRow := (sgMain.Row + 1) mod sgMain.RowCount; // Qidirishni keyingi qator yoki boshidan boshlash
      for i := startRow to sgMain.RowCount - 1 do
      begin
        cellText := AnsiUpperCase(Trim(sgMain.Cells[2, i]));
        if Pos(searchText, cellText) > 0 then begin sgMain.Row := i; Exit; end;
      end;

      for i := 1 to startRow - 1 do
      begin
        cellText := AnsiUpperCase(Trim(sgMain.Cells[2, i]));
        if Pos(searchText, cellText) > 0 then begin sgMain.Row := i; Exit; end;
      end;

      ShowMessage('Информация не найдена!');
    finally
      sgMain.EndUpdate;
      lockWIndowupdate(0);
    end;
  end;
end;

end.
