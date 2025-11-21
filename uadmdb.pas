//Á.Ð.Ð.
unit uadmdb;

interface

uses
  System.SysUtils, System.Classes, UniProvider, InterBaseUniProvider, Data.DB,
  DBAccess, Uni, MemDS;

type
  Tdm = class(TDataModule)
    con1: TUniConnection;
    intrbsnprvdr1: TInterBaseUniProvider;
    qwork: TUniQuery;
    qtemp: TUniQuery;
    usersTbl: TUniTable;
    usersDS: TUniDataSource;
    qMainGrid: TUniQuery;
    qMainGridALLORDERID: TIntegerField;
    qMainGridORDERID: TIntegerField;
    qMainGridUSERID: TIntegerField;
    qMainGridSTOL: TStringField;
    qMainGridOPENED: TDateTimeField;
    qMainGridCLOSED: TDateTimeField;
    qMainGridPLASTIK: TIntegerField;
    qMainGridWSUMM: TIntegerField;
    qMainGridUSERNAIM: TStringField;
    qMainGridFOIZ: TIntegerField;
    mainDS: TUniDataSource;
    qMainGridALLSUMM: TIntegerField;
    qtemp2: TUniQuery;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

procedure RefreshQ(q:TUniQuery;ID:Integer=-1);
procedure ExecQ(s:string);
function GetGen(AGen:string):string;
function FirstS(s:string):string;
function FirstI(s:string):Integer;
function FirstDT(s:string):TDateTime;

function explodeStr(var aStr:AnsiString):AnsiString;
function explodeInt(var aStr:AnsiString):Integer;

function getUserID(passw:string):Integer;
function getUserNaim(userId:integer):string;

var
  dm: Tdm;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

procedure RefreshQ(q:TUniQuery;ID:Integer=-1);
var fieldName:string;
begin
  with q do
  begin
    if ID>=0 then fieldName:=Fields[0].FieldName;
    Active:=False;Active:=True;
    if ID>=0 then Locate(fieldName,ID,[]) else First;
  end;
end;

function explodeStr(var aStr:AnsiString):AnsiString; inline;
begin Result:=Copy(aStr,1,Pos(';',aStr)-1);Delete(aStr,1,Pos(';',aStr));end;

function explodeInt(var aStr:AnsiString):Integer;
var s:AnsiString;
  rs:Integer;
begin
  s:=Copy(aStr,1,Pos(';',aStr)-1);Delete(aStr,1,Pos(';',aStr));
  if TryStrToInt(s,rs) then Result:=rs else Result:=-1;
end;

function FirstI(s:string):Integer;
begin
  with dm.qwork do
  begin
    Active:=False;SQL.Text:=s+' ROWS 1';Active:=True;
    if IsEmpty then Result:=0 else Result:=Fields[0].AsInteger;
  end;
end;

function FirstS(s:string):string;
begin
  with dm.qwork do
  begin
    Active:=False;SQL.Text:=s+' ROWS 1';Active:=True;
    if IsEmpty then Result:='' else Result:=Fields[0].AsString;
  end;
end;

function FirstDT(s:string):TDateTime;
begin
  with dm.qwork do
  begin
    Active:=False;SQL.Text:=s+' ROWS 1';Active:=True;
    if IsEmpty then Result:=0 else Result:=Fields[0].AsDateTime;
  end;
end;

function getUserId(passw:string):Integer;
begin Result:=FirstI('SELECT USERID FROM TUSERS WHERE PASSW='+QuotedStr(passw));end;

function getUserNaim(userId:integer):string;
begin Result:=FirstS('SELECT USERNAIM FROM TUSERS WHERE USERID='+IntToStr(userId));end;

procedure ExecQ(s:string); begin with dm.qwork do begin Close;SQL.Text:=s;ExecSQL;end;end;

function GetGen(AGen:string):string;
  begin Result:=FirstS('SELECT GEN_ID('+AGen+', 1) FROM RDB$DATABASE');end;


end.
