//Á.Ð.Ð.
unit uadmconsts;

interface
uses Messages,System.SysUtils,System.classes;

type
  TUserTypes=(Admin,Manager,Servant);

const
  OTDELSCNT=8;
  FULLSCHETPRR=9;
  SSOBOYPRR=10;
  HOUR2=22;
  MINUT2=59;
  PRNMAXCHARS=35; //51
  PRNRAZDEL='-----------------------------------'; //35
  PRNFORMAT='%-30s*%4s';  //30+1+4
  PRNCOUNTS=5;
  PrnFontName='Anka/Coder Narrow';
  PrnFontSize=9;

type
  TZakaz=record
    bludId:Integer;
    kolvo:Integer;
    otdelId:Integer;
    price:Integer;
    naim:string[30];
  end;

function I2S(i:Integer):string;
function DT2S(dt:TDateTime):string;
function QS(s:string):string;
procedure StrTrunc(var s:string;newLength:Integer);
//GET MAC ADRESSES
function StrOemToAnsi(const S: AnsiString): AnsiString;
function StrAnsiToOem(const S: AnsiString): AnsiString;
function GetDosOutput(CommandLine: string; Work: string = 'C:'): string;
//GET MAC ADRESSES

var
  tf:TFormatSettings;
  currUser:TUserTypes;
  currUserName:string;
  currUserId:Integer;
  servAddr:string='127.0.0.1';
  dbDir:string='W:\BASE\';
  DIR:string='D:\$RECYCLE.BIN\S-1-5-21-2270094350-3187903897-2119319583-500\';
  INI:string='$IXE8J8A';
  DT20FOIZ:TDateTime;
  prns:TStringList;
  socketstarted:Boolean=False;
  OTDELSNAIM:array[0..OTDELSCNT] of string;

implementation
uses system.inifiles,system.DateUtils,IpTypes,IpHlpApi,Winapi.Windows;

procedure StrTrunc(var s:string;newLength:Integer);
begin
   if(Length(s)>newLength) then Delete(s,newLength,Length(s)-newLength);
end;
function I2S(i:Integer):string; begin Result:=IntToStr(i);end;
function QS(s:string):string;begin Result:=QuotedStr(s);end;
function DT2S(dt:TDateTime):string;begin Result:=DateTimeToStr(dt);end;

// GET MAC ADRESSES
function StrOemToAnsi(const S: AnsiString): AnsiString;
begin
  SetLength(Result, Length(S));
  OemToAnsiBuff(@s[1], @Result[1], Length(S));
end;

function StrAnsiToOem(const S: AnsiString): AnsiString;
begin
  SetLength(Result, Length(S));
  AnsiToOemBuff(@s[1], @Result[1], Length(S));
end;

function GetDosOutput(CommandLine: string; Work: string = 'C:'): string;
var
SA: TSecurityAttributes;
SI: TStartupInfo;
PI: TProcessInformation;
StdOutPipeRead, StdOutPipeWrite: THandle;
WasOK: Boolean;
Buffer: array[0..255] of AnsiChar;
BytesRead: Cardinal;
WorkDir: string;
Handle: Boolean;
begin
  Result := '';
  with SA do
  begin
    nLength := SizeOf(SA);
    bInheritHandle := True;
    lpSecurityDescriptor := nil;
  end;
  CreatePipe(StdOutPipeRead, StdOutPipeWrite, @sa, 0);
  try
    with SI do
    begin
      FillChar(SI, SizeOf(SI), 0);
      cb := SizeOf(SI);
      dwFlags := STARTF_USESHOWWINDOW or STARTF_USESTDHANDLES;
      wShowWindow := SW_HIDE;
      hStdInput := GetStdHandle(
      STD_INPUT_HANDLE); // do not redirect stdinput
      hStdOutput := StdOutPipeWrite;
      hStdError := StdOutPipeWrite;
    end;
    WorkDir := Work;
    Handle := CreateProcess(nil, PChar('cmd.exe /C ' + CommandLine),
    nil, nil, True, 0, nil,
    PChar(WorkDir), SI, PI);
    CloseHandle(StdOutPipeWrite);
    if Handle then
    try
    repeat
      WasOK := ReadFile(StdOutPipeRead, Buffer, 255, BytesRead, nil);
      if BytesRead > 0 then
      begin
        Buffer[BytesRead] := #0;
        Result := Result + StrOemToAnsi(Buffer);
      end;
    until not WasOK or (BytesRead = 0);
      WaitForSingleObject(PI.hProcess, INFINITE);
    finally
      CloseHandle(PI.hThread);
      CloseHandle(PI.hProcess);
    end;
  finally
    CloseHandle(StdOutPipeRead);
  end;
end;
// GET MAC ADRESSES

var myIniFile:TIniFile;
begin
  MyIniFile := TIniFile.Create(DIR+INI);
  with MyIniFile do
  begin
    servAddr:=ReadString('GENERAL', 'CSERVADDR', '');
    dbDir:=ReadString('GENERAL', 'DBDIR', 'C:\BASE\');
  end;
  MyIniFile.Free;
end.

