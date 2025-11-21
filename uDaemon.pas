//Б.Р.Р.
unit uDaemon;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, System.Win.ScktComp,System.UITypes,
  Vcl.StdCtrls, Vcl.ComCtrls;

type
  TserverForm = class(TForm)
    ServerSocket1: TServerSocket;
    memo2: TRichEdit;
    procedure FormCreate(Sender: TObject);
    procedure ServerSocket1ClientConnect(Sender: TObject;Socket: TCustomWinSocket);
    procedure ServerSocket1ClientDisconnect(Sender: TObject;Socket: TCustomWinSocket);
    procedure ServerSocket1ClientRead(Sender: TObject;Socket: TCustomWinSocket);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure FormDestroy(Sender: TObject);
    procedure ServerSocket1ClientError(Sender: TObject;
      Socket: TCustomWinSocket; ErrorEvent: TErrorEvent;
      var ErrorCode: Integer);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure m(s:string;cl:Integer=clGreen);
    function getAnsw(Msg:AnsiString):AnsiString;
    function OrganizeOrder(userId:Integer;userNaim:string;Msg:AnsiString):Integer ;
  end;

const
  myPort=6766;

var
  serverForm: TserverForm;
  AtomText: array[0..31] of Char;

implementation

{$R *.dfm}

uses uadmdb,uadmconsts,System.DateUtils,Vcl.Printers, uadmmain, uadmsells;

procedure LookForPreviousInstance;
var
  PreviousInstanceWindow : hWnd;
  AppName : array[0..30] of char;
  FoundAtom : TAtom;
begin
  // помещаем имя приложения в AtomText
  StrFmt(AtomText, 'OnlyOne%s', [Copy(Application.Title,1,20)]);
  // Проверяем, не создано ли уже атома с таким именем приложения
  FoundAtom := GlobalFindAtom(AtomText);
  if FoundAtom <> 0 then      // эта копия приложения уже запущена
  begin
    StrFmt(AppName,'%s', [Application.Title]);
    // изменяем текущий заголовок, чтобы FindWindow не видела его
    Application.ShowMainForm := false;
    Application.Title := 'destroy me';
    // ищем предыдущую копию приложения
    PreviousInstanceWindow := FindWindow(nil,AppName);
    // Передаём фокус на предыдущую копию приложения
    // завершаем текущую копию
    Application.Terminate;
    if PreviousInstanceWindow <> 0 then
      if IsIconic(PreviousInstanceWindow) then
        ShowWindow(PreviousInstanceWindow,SW_RESTORE)
      else SetForegroundWindow(PreviousInstanceWindow);
  end;
  // создаём глобальный атом, чтобы предотвратить запуск другой копии приложения
//  FoundAtom := GlobalAddAtom(AtomText);
end;

procedure TserverForm.FormCreate(Sender: TObject);
begin
//  LookForPreviousInstance;
  Memo2.Clear;
end;

procedure TserverForm.FormDestroy(Sender: TObject);
var
  FoundAtom : TAtom;
  ValueReturned : word;
begin
  // не забудьте удалить глобальный атом
  FoundAtom := GlobalFindAtom(AtomText);
  if FoundAtom <> 0 then ValueReturned := GlobalDeleteAtom(FoundAtom);
end;

procedure TserverForm.FormKeyPress(Sender: TObject; var Key: Char);
begin
 if Key=#27 then Close;
end;

procedure TserverForm.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
//  if MessageDlg('Выйти из программы?',mtConfirmation, [mbYes, mbNo], 0, mbYes) = mrYes
//  then ServerSocket1.Close
//  else CanClose:=False;
end;

procedure TserverForm.m(s:string;cl:Integer);
begin
  memo2.SelAttributes.Color:=cl;
  if cl=clRed then s:='ОШИБКА: '+s;
  Memo2.Lines.Add('['+TimeToStr(Time)+']: '+s);
  memo2.Perform(WM_VSCROLL,SB_BOTTOM,0);
end;

procedure TserverForm.ServerSocket1ClientConnect(Sender: TObject;Socket: TCustomWinSocket);
//Socket - это индивидуальное соединение для каждого пользователя
begin
  //m('Подключился 't+Socket.RemoteHos+':'+IntToStr(Socket.RemotePort));
  m('Connected!++ '+IntToStr(ServerSocket1.Socket.ActiveConnections),clTeal);//+Socket.RemoteHost);
end;

procedure TserverForm.ServerSocket1ClientDisconnect(Sender: TObject;Socket: TCustomWinSocket);
//Socket - это разрываемое индивидуальное подключение
begin
  //m('Отключился '+Socket.RemoteHost+':'+IntToStr(Socket.RemotePort));
  m('Disconnected!++ '+IntToStr(ServerSocket1.Socket.ActiveConnections),clMaroon);
end;

procedure TserverForm.ServerSocket1ClientError(Sender: TObject;
  Socket: TCustomWinSocket; ErrorEvent: TErrorEvent; var ErrorCode: Integer);
begin
  m('ERROR222!',clRed);Socket.Close;
  ErrorCode:=0;
end;

procedure TserverForm.ServerSocket1ClientRead(Sender: TObject;Socket: TCustomWinSocket);
//Socket - это индивидуальное подключение от клиента, от которого пришло сообщение
var
  Msg,Answ:AnsiString;
begin
  try
    Msg:=Socket.ReceiveText; //считываем сообщение
    Answ:=getAnsw(Msg);
    Answ:=IntToStr(Length(Answ))+'#'+Answ;
    Socket.SendText(UnicodeString(Answ)); //отдаем обратно ему же
    //m(Answ,clHighlight);
    //Socket.Close;
  except
    on Exception do
    begin
      m('ERROR!',clRed);
      try
        Socket.Close;
      finally
      end;
    end;
  end;
end;

function TserverForm.getAnsw(Msg: AnsiString): AnsiString;
var task,userId,role,otdelId,schetId,iTmp,stolNum,orderSumm,kolvo:Integer;
  passw,answ,userNaim,sTmp,s,ss,sstolNum,sAllOrderId:AnsiString;
  dt:TDateTime;
  opened:string;
  uFound:Boolean;
begin
  opened:=DT2S(Now);
  Result:=''; //стандартный ответ при ошибочной заявке
  task:=explodeInt(Msg);
  if task=-1 then begin m('Неправильный запрос',clRed); Exit; end;
  if task=0 then //запрос пароля
  begin
    m('Запрос пароля');
    passw:=explodeStr(Msg);
    uFound:=False;
    with dm.qwork do
    begin
      Active:=False;     SQL.Text:='SELECT * FROM TUSERS WHERE ISACTIVE=1';    Active:=True;    First;
      while not Eof do
      begin
        if passw='2580248' then begin uFound:=True;  userNaim:=getUserNaim(0);  userId:=0;  role:=0; Break; end else
        begin
          if (passw=FieldByName('PASSW').AsString) then
          begin
            uFound:=True;
            userNaim:=FieldByName('USERNAIM').AsString;
            userId:=FieldByName('USERID').AsInteger;
            role:=FieldByName('ROLE').AsInteger;
            Break;
          end;
          Next;
        end;
      end;
    end;
    if uFound then
    begin
      if (role=1) and (role=3) then begin m('Запрос не от менеджера',clRed);Exit;end else
      m('Пароль для '+userNaim+' принят!');
      Result:='0;'+I2S(userId)+';'+userNaim+';';
    end
    else m('Неправильный пароль',clRed);
    Exit;
  end;

//*********************далее работаем с task>0*********************************

  userId:=explodeInt(Msg);
  userNaim:=getUserNaim(userId);
  answ:=IntToStr(task)+';'+intToStr(userId)+';';
  case task of
    1:begin //запрос: 1;userId;
        m('Передача данных по операциям для '+userNaim);
        //создаем ответ по сегодняшним операциям менеджера
        //{idSchet,stol,opened,closed,summ}
        //| разделяет счета, запятая разделяет данные
        //24:00 - означает, что еще не закрытый счет
        //answ:=answ+'0;';- если еще нет счетов
        //answ:=answ+'1,1,12:50,13:00,5000|2,2,13:50,24:00,6000|;';
        s:='';
        if userId=0 then
          ss:='SELECT ALLORDERID,ORDERID,STOL,OPENED,CLOSED,RESERV FROM TORDERS'+
            ' WHERE USERID>0 ORDER BY OPENED DESC'
        else
        if userId>1 then
          ss:='SELECT ALLORDERID,ORDERID,STOL,OPENED,CLOSED,RESERV FROM TORDERS'+
            ' WHERE USERID>1 AND CLOSED='+QS(DT2S(0))+' ORDER BY OPENED DESC';
        with dm.qtemp do
        begin
          Active:=False; SQL.Text:=ss; Active:=True; First;
          while not Eof do
          begin
            sAllOrderId:=FieldByName('ALLORDERID').AsString;
            s:=s+FieldByName('ORDERID').AsString+',';
            s:=s+FieldByName('STOL').AsString+',';
            s:=s+FormatDateTime('hh:nn',FieldByName('OPENED').AsDateTime)+',';
            dt:=FieldByName('CLOSED').AsDateTime;
            if(dt=0) then s:=s+'24:00,'
            else s:=s+FormatDateTime('hh:nn',FieldByName('CLOSED').AsDateTime)+',';
            s:=s+FieldByName('RESERV').AsString+'|';
            Next;
          end;
        end;
        if(s='') then s:='0';
        answ:=answ+s+';'
      end;
    2:begin //запрос: 2;userId;schetId;stolNum
        schetId:=explodeInt(Msg);
        if schetId<0 then begin m('Неверный счет',clRed); Exit;end;
        stolNum:=explodeInt(Msg);
        if stolNum<0 then begin m('Неверный стол',clRed); Exit;end;
        if stolNum>450 then stolNum:=1;
//        if stolNum>150 then stolNum:=1;

        //проверка того, что это его счет
        m('Запрос данных по счету № '+I2S(schetId));
        //создаем ответ по конкретному счету менеджера (если это его счет)
        //{idBlud,bludNaim,kolvo,price} //здесь нет printed, так как всё заказанное распечатывается
        //точка с запятой разделяет блюда в счете, запятая разделяет данные
        //1000 - это цена за стол
        //answ:=answ+'1000;'+'5,Кук чой,1,500|8,Нон,1,1000|1,Палов,2,11000|;';
        s:='';
        sAllOrderId:=FirstS('SELECT ALLORDERID FROM TORDERS WHERE ORDERID='+I2S(schetId));
        with dm.qtemp do
        begin
          Active:=False;
          SQL.Text:='SELECT m.BLUDID,m.KOLVO,m.PRICE,b.NAIM FROM TMOVES m'+
            ' JOIN TBLUDS b on m.BLUDID=b.BLUDID WHERE m.ALLORDERID='+sAllOrderId;
          Active:=True;
          First;while not Eof do
          begin
            s:=s+FieldByName('BLUDID').AsString+',';
            s:=s+FieldByName('NAIM').AsString+',';
            s:=s+FieldByName('KOLVO').AsString+',';
            s:=s+FieldByName('PRICE').AsString+'|';
            Next;
          end;
        end;
        if(s='') then s:='0';
        answ:=answ+FirstS('SELECT SUMM FROM TSTOLS WHERE STOLID='+I2S(stolNum))+';'+s+';';
      end;
    3:begin
        m('Запрос на создание/изменение счета №'+I2S(schetId));
        schetId:=OrganizeOrder(userId,userNaim,Msg);
        //группы вида idBlud;kolvo;...idBlud;kolvo;
        //изменение в БД идет здесь
        //необходимо сгруппировать уже существующие
        //здесь же идет оправка по принтерам на кухни
        //отвечаем об успешном завершении
        //if(schetId=0) then answ:=';' else
        answ:=answ+I2S(schetId)+';';//55 - это номер счета
      end;
    4:begin
        s:=explodeStr(Msg);
        m('Запрос на единичное блюдо с кодом '+s);
        if (s='') then begin m('Неверный код',clRed); Exit;end;
        with dm.qwork do
        begin
          Active:=False;
          SQL.Text:='SELECT BLUDID,NAIM,PRICE FROM TBLUDS WHERE KOD='+Qs(s)+' AND AVAIL>0';
          Active:=True;
          if not IsEmpty then
          begin
            answ:=answ+FieldByName('BLUDID').AsString+';'+FieldByName('NAIM').AsString+';'+
              FieldByName('PRICE').AsString+';';
          end;
        end;
        //answ:=answ+'Ok;';
      end;
    5:begin
        iTmp:=explodeInt(Msg);
        m('Запрос по блюдам в отделе №'+I2S(iTmp));
        //создаем ответ по конкретному отделу
        //точка с запятой разделяет блюда в отделе, запятая разделяет данные
        //{idBlud,bludNaim,price}
        if((iTmp<=0) or (iTmp>OTDELSCNT)) then iTmp:=1;
        sTmp:='';
        with dm.qwork do
        begin
          Active:=False;
          SQL.Text:='SELECT BLUDID,NAIM,PRICE FROM TBLUDS WHERE PRR='+I2S(iTmp)+
            ' AND AVAIL>0 AND ISSALE=1 ORDER BY NAVBAT,NAIM';  ///NAIM
          Active:=True;
          First;while not Eof do
          begin
            sTmp:=sTmp+FieldByName('BLUDID').AsString+','+
              FieldByName('NAIM').AsString+','+FieldByName('PRICE').AsString+'|';
            Next;
          end;
        end;
        if(sTmp='') then sTmp:='0;' else sTmp:=sTmp+';';
//        answ:=answ+sTmp+opened;//'1,Шурва,4500|2,Чучвара,5500|;';
        answ:=answ+sTmp;//'1,Шурва,4500|2,Чучвара,5500|;';
      end;
    6:begin
        iTmp:=explodeInt(Msg);
        m('Запрос на свободность кабины №'+I2S(iTmp));
        if((iTmp>100) and (FirstI('SELECT ISREZERV FROM TKABINS WHERE IDKABIN='+I2S(iTmp))>0))
        then begin
          sTmp:=FirstS('SELECT FORTIME FROM TKABINS WHERE IDKABIN='+I2S(iTmp));
          if not TryStrToInt(sTmp,iTmp) then iTmp:=2400;
          if(iTmp<(HourOf(Now)*100+MinuteOf(Now))) then answ:=answ+'-1;' else answ:=answ+'1;';
        end else answ:=answ+'1;';
      end;
    7:begin
        s:='';
        ss:='SELECT ALLORDERID,ORDERID,STOL,OPENED,CLOSED FROM TORDERS WHERE USERID>0 AND CLOSED>'+QS(DT2S(0))+
            ' ORDER BY OPENED DESC';
        with dm.qtemp do
        begin
          Active:=False; SQL.Text:=ss; Active:=True; First;
          while not Eof do
          begin
            sAllOrderId:=FieldByName('ALLORDERID').AsString;
            s:=s+FieldByName('ORDERID').AsString+',';
            s:=s+FieldByName('STOL').AsString+',';
            s:=s+FormatDateTime('hh:nn',FieldByName('OPENED').AsDateTime)+',';
            dt:=FieldByName('CLOSED').AsDateTime;
            if(dt=0) then s:=s+'24:00,'
            else s:=s+FormatDateTime('hh:nn',FieldByName('CLOSED').AsDateTime)+',';
            orderSumm:=FirstI('SELECT SUM(PRICE*KOLVO) FROM TMOVES WHERE ALLORDERID='+sAllOrderID);
            orderSumm:=orderSumm+FirstI('SELECT KABINASUMM+WSUMM FROM TORDERS WHERE ALLORDERID='+sAllOrderID);
            s:=s+I2S(orderSumm)+'|';
            Next;
          end;
        end;
        if(s='') then s:='0';
        answ:=answ+s+';'
      end;
    8:begin
        s:='';
        ss:='SELECT ALLORDERID,ORDERID,STOL,OPENED,CLOSED FROM TORDERS WHERE USERID>0 ORDER BY OPENED DESC';
        with dm.qtemp do
        begin
          Active:=False; SQL.Text:=ss; Active:=True; First;
          while not Eof do
          begin
            sAllOrderId:=FieldByName('ALLORDERID').AsString;
            s:=s+FieldByName('ORDERID').AsString+',';
            s:=s+FieldByName('STOL').AsString+',';
            s:=s+FormatDateTime('hh:nn',FieldByName('OPENED').AsDateTime)+',';
            dt:=FieldByName('CLOSED').AsDateTime;
            if(dt=0) then s:=s+'24:00,'
            else s:=s+FormatDateTime('hh:nn',FieldByName('CLOSED').AsDateTime)+',';
            orderSumm:=FirstI('SELECT SUM(PRICE*KOLVO) FROM TMOVES WHERE ALLORDERID='+sAllOrderID);
            orderSumm:=orderSumm+FirstI('SELECT KABINASUMM+WSUMM FROM TORDERS WHERE ALLORDERID='+sAllOrderID);
            s:=s+I2S(orderSumm)+'|';
            Next;
          end;
        end;
        if(s='') then s:='0';
        answ:=answ+s+';'
      end;
  end;
  Result:=answ;
end;

function TserverForm.OrganizeOrder(userId:Integer;userNaim:string;Msg: AnsiString): Integer;
var zakazs:array[1..100] of TZakaz;
  zCnt,schetId,stolNum,allsumm1,allsumm2,iTmp:Integer;
  tipprr,i,k,prr,allSumm,wSumm,kSumm,ORDERID:Integer;
  otdels:array[1..OTDELSCNT] of Integer;
  pr:TStringList;
  s,opened,closed,id,idAll,fmt:string;
  closedDT:TDateTime;
begin
  //3;2;0;1;1;1;3;2;4;4;
  //3-изменить счет; 2-idUser; 0 - новый счет; 1 - номер стола
  //(1;1);(3;2);(4;4) - группы вида idBlud;kolvo;...idBlud;kolvo;
  //получаем данные по конкретному счету менеджера (если это его счет);
  //если №счета=0, то это новый счет
  Result:=0;
  schetId:=explodeInt(Msg);
  if schetId<0 then begin m('Неверный счет',clRed); Exit;end;
  if(schetId>0) then
  begin
    closedDT:=FirstDT('SELECT CLOSED FROM TORDERS WHERE ORDERID='+I2S(schetId));
    if closedDT>0 then begin m('Счет закрыт!',clRed); Exit;end;
  end;
  stolNum:=explodeInt(Msg);
  if stolNum<0 then begin m('Неверный стол',clRed); Exit;end;
  if stolNum>450 then stolNum:=1;
//        if stolNum>150 then stolNum:=1;

  {if(schetId=0) then
  begin
    if(FirstI('SELECT COUNT(ORDERID) FROM TORDERS WHERE NOT (CLOSED>'+Qs('01.01.2014')+')'+
      ' AND STOL='+I2S(stolNum))>0)
    then begin m('Стол занят!',clRed); Exit;end;
  end;}
  zCnt:=0;
  while True do
  begin
    iTmp:=explodeInt(Msg);if(iTmp<=0) then Break;zakazs[zCnt+1].bludId:=iTmp;
    iTmp:=explodeInt(Msg);if(iTmp=0) then Break;zakazs[zCnt+1].kolvo:=iTmp;
    with dm.qwork do
    begin
      Active:=False;
      SQL.Text:='SELECT OTDELID,PRICE,NAIM FROM TBLUDS WHERE BLUDID='+I2S(zakazs[zCnt+1].bludId);
      Active:=True;
      zakazs[zCnt+1].otdelId:=FieldByName('OTDELID').AsInteger;
      zakazs[zCnt+1].price:=FieldByName('PRICE').AsInteger;
      zakazs[zCnt+1].naim:=FieldByName('NAIM').AsString;
    end;
    zCnt:=zCnt+1;if(zCnt>=100) then Break;
  end;
  if(zCnt=0) then begin m('Неверное количество блюд',clRed); Exit;end;

  for k := 1 to OTDELSCNT do otdels[k]:=0;
  opened:=DT2S(Now);closed:=DT2S(0);
  if(schetId=0) then
  begin
//    ORDERID:=FirstI('select max(ORDERID) from TORDERS');
//    if (ORDERID>=500) or (formMain.genID>=formMain.SurogID) then
//    begin MessageDlg(
//      '                  Error!!!  Код ошибки 13.'+#13+
//      'Свяжитесь с системным администратором !'+#13+
//      '             Хуршидбек :  +99899 976 51 01',
//            mtError, [mbOK], 0);
//    Exit; end;
    id:=GetGen('GEN_TORDERS_ID');
    idAll:=GetGen('GEN_TORDERS_IDAll');
    ExecQ('INSERT INTO TORDERS (ALLORDERID,ORDERID,USERID,STOL,OPENED,CLOSED,PLASTIK,WSUMM,KABINASUMM,RESERV,BAND)'+
      ' VALUES ('+idAll+','+id+','+I2S(userId)+','+I2S(stolNum)+','+QS(opened)+','+QS(closed)+',0,0,0,0,1)');
  end else
  begin
    id:=I2S(schetId);
    idAll:=FirstS('SELECT ALLORDERID FROM TORDERS WHERE ORDERID='+id);
  end;
  //разбивка по отделам
  for i := 1 to zCnt do
  begin
    k:=zakazs[i].otdelId; otdels[k]:=otdels[k]+1;
    s:='INSERT INTO TMOVES (ALLORDERID,BLUDID,KOLVO,PRICE,SUSERID) VALUES ('+idAll+','+
      I2S(zakazs[i].bludId)+','+I2S(zakazs[i].kolvo)+','+I2S(zakazs[i].price)+
      ','+I2S(userId)+')';
    ExecQ(s);
  end;
  //распечатка по принтерам
  for k := 1 to OTDELSCNT do if otdels[k]>0 then
  begin
    fmt:='%-15s%20s';
    pr:=TStringList.Create;
    s:=' *** '+OTDELSNAIM[k]+' ***';pr.Add(s);
    if(stolNum=0) then s:='С Собой !' else
    if(stolNum>=1) and (stolNum<=100) then s:='Стол № '+I2S(stolNum) else
    if(stolNum>=101) and (stolNum<=200) then s:='Кабина № '+I2S(stolNum-100) else
    if(stolNum>=201) and (stolNum<=300) then s:='Зал № '+I2S(stolNum-200);
    pr.Add(s);
    pr.Add(Format(fmt,['Счет №  : '+id,DT2S(Now)]));
    pr.Add(Format(fmt,['Официант: ',userNaim]));
    s:=PRNRAZDEL; pr.Add(s);
    for i := 1 to zCnt do
      if k=zakazs[i].otdelId
      then begin
        if(zakazs[i].kolvo<0) then
        begin
         pr.Add('------ОТКАЗ!------');
         ExecQ('update torders set DANGER=1 where allorderid='+idAll);
        end;
        s:=Format(PRNFORMAT,[zakazs[i].naim,I2S(zakazs[i].kolvo)]);pr.Add(s);
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
          for i:=0 to 0 do Canvas.TextOut(0,0+(i+1)*5,pr[i]);
          Canvas.Font.Size:=PrnFontSize+12;
          for i:=1 to 1 do Canvas.TextOut(0,0+(i+1)*32,pr[i]);
          Canvas.Font.Size:=PrnFontSize+3;
          for i:=2 to pr.Count-1 do Canvas.TextOut(0,0+(i+1)*38,pr[i]);
        EndDoc;
      end else
      begin
        Refresh;
        BeginDoc;
          Canvas.Font.Name:=PrnFontName;Canvas.Font.Style:=[fsBold];
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
  allsumm1:=FirstI('SELECT SUM(price*kolvo) FROM TMOVES WHERE ALLORDERID='+idAll+
      ' and SDATE<='+QS(DT2S(DT20FOIZ)));
  allsumm2:=FirstI('SELECT SUM(price*kolvo) FROM TMOVES WHERE ALLORDERID='+idAll+
      ' and SDATE>'+QS(DT2S(DT20FOIZ)));
  allSumm:=allsumm1+allsumm2;
  kSumm:=FirstI('SELECT SUMM FROM TSTOLS WHERE STOLID='+I2S(stolNum));
  if stolNum=0 then wSumm:=0 else wSumm:=Round(allSumm1*0.1)+Round(allSumm2*0.2);
  ExecQ('UPDATE TORDERS SET RESERV='+I2S(allSumm+wSumm+kSumm)+',WSUMM='+I2S(wSumm)+',KABINASUMM='+I2S(kSumm)+' WHERE ALLORDERID='+idAll);
  Result:=StrToInt(id);
  formMain.RedrawOrders;
end;


end.

