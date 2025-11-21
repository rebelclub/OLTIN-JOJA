//Б.Р.Р.
unit uadmusers;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls, Vcl.Grids,
  AdvObj, BaseGrid, AdvGrid, AdvUtil;

type
  TusersForm = class(TForm)
    Panel1: TPanel;
    addBtn: TButton;
    changeBtn: TButton;
    sg: TAdvStringGrid;
    procedure FormCreate(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure addBtnClick(Sender: TObject);
    procedure changeBtnClick(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure sgDblClickCell(Sender: TObject; ARow, ACol: Integer);
    procedure sgGetCellColor(Sender: TObject; ARow, ACol: Integer;
      AState: TGridDrawState; ABrush: TBrush; AFont: TFont);
    procedure CheckUsernaimExists;
    function CheckUserPassExists(const pass: string; excludeId: Integer): Boolean;
  private
    { Private declarations }
  public
    { Public declarations }
    cIdUser:Integer;
    uFound:Boolean;
    procedure drawGrid;
  end;

var
  usersForm: TusersForm;

implementation

{$R *.dfm}

uses uadmcudausers, uadmdb, uadmconsts, uadmmain;

procedure TusersForm.FormCreate(Sender: TObject);
begin
  with sg do
  begin
    ColCount:=5;RowCount:=2;
    cells[0,0]:='';ColWidths[0]:=0;//id
    cells[1,0]:='Имя';ColWidths[1]:=190;
    cells[2,0]:='Актив';ColWidths[2]:=55;
    cells[3,0]:='';ColWidths[3]:=0;//passw
    cells[4,0]:='';ColWidths[4]:=0;//otkaz
  end;
end;

procedure TusersForm.FormActivate(Sender: TObject);
begin
  cIdUser:=1;
  drawGrid;
  FocusControl(sg);
end;

procedure TusersForm.FormKeyPress(Sender: TObject; var Key: Char);
begin
 if Key=#27 then Close;
 if Key='+' then addBtn.Click;
 if Key='-' then changeBtn.Click;
end;

procedure TusersForm.sgDblClickCell(Sender: TObject; ARow, ACol: Integer);
begin
  changeBtn.Click;
end;

procedure TusersForm.sgGetCellColor(Sender: TObject; ARow, ACol: Integer;
  AState: TGridDrawState; ABrush: TBrush; AFont: TFont);
begin
  if(ARow>0) and (sg.Cells[2,ARow]<>'Да')
  then begin
    AFont.Color:=clRed;
  end;
end;

procedure TusersForm.drawGrid;
var cRow,fRow:Integer;
begin
  fRow:=1;sg.RowCount:=2;sg.Rows[1].Clear;
  with dm.qwork do
  begin
    SQL.Text:='SELECT * FROM TUSERS WHERE ROLE>=0 ORDER BY USERID';
    Active:=False;  Active:=True;  First;  cRow:=1;
    while not Eof do
    begin
      sg.Cells[0,cRow]:=FieldByName('USERID').AsString;
      sg.Cells[1,cRow]:=FieldByName('USERNAIM').AsString;
      if (FieldByName('ISACTIVE').AsInteger=1)
      then sg.Cells[2,cRow]:='Да'
      else sg.Cells[2,cRow]:='Нет';
      sg.Cells[3,cRow]:=FieldByName('PASSW').AsString;
      if (FieldByName('WORKERID').AsInteger=1)
      then sg.Cells[4,cRow]:='Да'
      else sg.Cells[4,cRow]:='Нет';
      if(FieldByName('USERID').AsInteger=cIdUser) then fRow:=cRow;
      sg.RowCount:=sg.RowCount+1;cRow:=cRow+1;Next;
    end;
  end;
  sg.RowCount:=sg.RowCount-1;sg.Row:=fRow;
end;

procedure TusersForm.CheckUsernaimExists;
var
  usernaim: string;
begin
  usernaim := userCUDAForm.naim;
  if usernaim = '' then Exit;

  uFound := False;
  with dm.qwork do
  begin
    Active := False;
    SQL.Text := 'SELECT * FROM TUSERS';
    Active := True;
    First;
    while not Eof do
    begin
      if (usernaim = FieldByName('USERNAIM').AsString) then
      begin
        uFound := True;
        Break;
      end;
      Next;
    end;
  end;
end;

function TusersForm.CheckUserPassExists(const pass: string; excludeId: Integer): Boolean;
begin
  with dm.qwork do
  begin
    Close;
    SQL.Text := 'SELECT COUNT(*) AS CNT FROM TUSERS WHERE PASSW = ' + QS(pass);
    if excludeId > 0 then
      SQL.Text := SQL.Text + ' AND USERID <> ' + IntToStr(excludeId);
    Open;
    Result := FieldByName('CNT').AsInteger > 0;
  end;
end;

procedure TusersForm.addBtnClick(Sender: TObject);
var newId,s:string;
begin
  with userCUDAForm do
  begin
    naim:='Новый';passw:='12345';role:='2';isActive:=1; isOtkaz:=1;
  end;
  if userCUDAForm.ShowModal = mrOk then
  begin
    if (Trim(userCUDAForm.naim) = '') or (Trim(userCUDAForm.passw) = '') then
    begin
      ShowMessage('Пожалуйста, введите логин и пароль!');
      Exit;
    end;

    CheckUsernaimExists;
    if uFound=True then
    begin
      ShowMessage('Такой пользователь уже существует!');
      Exit;
    end;

    if CheckUserPassExists(userCUDAForm.passw, 0) then
    begin
      ShowMessage('Такой пароль уже существует!');
      Exit;
    end;

    newId := GetGen('GEN_TUSERS_ID');
    s := 'INSERT INTO TUSERS (USERID, USERNAIM, ROLE, PASSW, WORKERID, ISACTIVE, FOIZ) VALUES (' +
      newId + ',' + QS(userCUDAForm.naim) + ',' + userCUDAForm.role + ',' + QS(userCUDAForm.passw) +
      ',' + IntToStr(userCUDAForm.isOtkaz) + ',' + IntToStr(userCUDAForm.isActive) + ',10)';
    ExecQ(s);
    cIdUser := StrToInt(newId);
    drawGrid;
  end;
  formMain.RedrawUsers;
end;

procedure TusersForm.changeBtnClick(Sender: TObject);
var s:string;
begin
  cIdUser:=StrToInt(sg.Cells[0,sg.Row]);
  if cIdUser=12 then Exit;

  with userCUDAForm do
  begin
    naim:=sg.Cells[1,sg.Row];
    passw:=sg.Cells[3,sg.Row];
    if(sg.Cells[2,sg.Row]='Да') then isActive:=1 else isActive:=0;
    if(sg.Cells[4,sg.Row]='Да') then isOtkaz:=1 else isOtkaz:=0;
  end;
  if userCUDAForm.ShowModal = mrOk then
  begin
    CheckUsernaimExists;
    if uFound and (userCUDAForm.naim <> sg.Cells[1, sg.Row]) then
    begin
      ShowMessage('Пользователь с таким именем уже существует!');
      Exit;
    end;

    if CheckUserPassExists(userCUDAForm.passw, cIdUser) then
    begin
      ShowMessage('Такой пароль уже существует!');
      Exit;
    end;

    if sg.Cells[1,sg.Row]='Даставка' then userCUDAForm.naim:='Даставка';

    s := 'UPDATE TUSERS SET USERNAIM=' + QS(userCUDAForm.naim) + ', PASSW=' + QS(userCUDAForm.passw) +
      ',ISACTIVE=' + IntToStr(userCUDAForm.isActive) + ',WORKERID=' + IntToStr(userCUDAForm.isOtkaz) +
      ' WHERE USERID=' + sg.Cells[0, sg.Row];
    ExecQ(s);
    drawGrid;
  end;
  formMain.RedrawUsers;
end;

end.

