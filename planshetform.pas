//Á.Ð.Ð.
unit planshetform;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, AdvGlowButton, sComboBox,
  Vcl.Mask, sMaskEdit, sCustomComboEdit;

type
  TForm2 = class(TForm)
    Label1: TLabel;
    Edit1: TEdit;
    lbl1: TLabel;
    BtnOk: TButton;
    workersBox: TsComboBox;
    procedure FormCreate(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure BtnOkClick(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }
  public
    { Public declarations }
    stol:Integer;
    ui:Integer;
    uid:TStringList;
  end;

var
  Form2: TForm2;

implementation

uses
  uadmconsts, uadmdb;

var
  users:array[0..50] of Integer;
{$R *.dfm}

procedure TForm2.FormCreate(Sender: TObject);
begin
  stol:=0;
  Edit1.Text:=i2s(Stol);
  uid:=TStringList.Create;
end;

procedure TForm2.FormActivate(Sender: TObject);
var i,k:Integer; sOrder:string;
begin
//  edit1.Text:=I2S(stol);
  if currUser=Admin
  then sOrder:='TORDERSARCH'
  else sOrder:='TORDERS';
  Edit1.SelectAll;
  FocusControl(edit1);
  workersBox.Items.Clear; uid.Clear;
  with dm.qwork do
  begin
    SQL.Text:='SELECT USERID,USERNAIM FROM TUSERS where role=2 and isactive=1 ORDER BY USERID';
//    SQL.Text:='select distinct u.userid,u.usernaim from tusers '+
//      'u join '+sOrder+' o on o.userid=u.userid where o.userid>1 order by userid';
    Active:=False; Active:=True; First;
    while not EoF do
    begin
      workersBox.Items.Add(FieldByName('usernaim').AsString);
      i:=FieldByName('userid').AsInteger;
      if i=ui then k:=workersBox.Items.Count-1;
      uid.Add(I2S(i));
      Next;
    end;
  end;
  if Edit1.Text<>'' then workersBox.ItemIndex:=k else workersBox.ItemIndex:=0;
end;

procedure TForm2.BtnOkClick(Sender: TObject);
var tmp:Integer;
begin
  if not TryStrToInt(Edit1.Text,tmp) then
  begin
    Edit1.SelectAll;
    FocusControl(edit1);
    Exit;
  end;
  if (tmp<0) or (tmp>450) then
  begin
    ModalResult:=mrCancel; Exit;
  end;
  stol:=tmp;
  ui:=StrToInt(uid[workersBox.ItemIndex]);
  ModalResult:=mrOk;
end;


procedure TForm2.FormKeyPress(Sender: TObject; var Key: Char);
begin
 if Key=#27 then Close;
end;

end.


