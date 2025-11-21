//Б.Р.Р.
unit uadmcudausers;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls;

type
  TuserCUDAForm = class(TForm)
    edtNaim: TLabeledEdit;
    chkIsActive: TCheckBox;
    edtPassw: TLabeledEdit;
    okButton: TButton;
    cancelBtn: TButton;
    ChkOtkaz: TCheckBox;
    procedure FormActivate(Sender: TObject);
    procedure okButtonClick(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }
  public
    naim,passw,role:string;
    isActive,isOtkaz:Integer;
    { Public declarations }
  end;

var
  userCUDAForm: TuserCUDAForm;

implementation

{$R *.dfm}

uses uadmdb, uadmconsts, uadmusers;

procedure TuserCUDAForm.FormActivate(Sender: TObject);
var userid:string;
begin
  userid:=usersForm.sg.Cells[0,usersForm.sg.Row];
  edtNaim.Text:=naim; edtPassw.Text:=passw;
  if isActive=1           then chkIsActive.Checked:=True  else chkIsActive.Checked:=False;
  if isOtkaz=1            then ChkOtkaz.Checked:=True     else ChkOtkaz.Checked:=False;
  if StrToInt(userid)<2
  then begin chkIsActive.Enabled:=False; ChkOtkaz.Enabled:=False; end
  else begin chkIsActive.Enabled:=True; ChkOtkaz.Enabled:=True; end;
  FocusControl(edtNaim);
  edtNaim.SelectAll;
end;

procedure TuserCUDAForm.FormKeyPress(Sender: TObject; var Key: Char);
begin
  if Key=#13 then OkButton.Click;
  if Key=#27 then CancelBtn.Click;
end;

procedure TuserCUDAForm.okButtonClick(Sender: TObject);
var cNaim:string;
begin
  cNaim := Trim(edtNaim.Text);
  if cNaim = '' then
  begin
    ShowMessage('Введите имя пользователя!');
    FocusControl(edtNaim); Exit;
  end;

  if (Pos(',', cNaim) > 0) or (Pos(';', cNaim) > 0) or (Pos('|', cNaim) > 0) or (Pos(':', cNaim) > 0) then
  begin
    ShowMessage('Имя пользователя не должно содержать символов , ; | :');
    FocusControl(edtNaim); edtNaim.SelectAll; Exit;
  end;
  naim := cNaim;
  passw := Trim(edtPassw.Text);
  if chkIsActive.Checked then isActive:=1 else isActive:=0;
  if ChkOtkaz.Checked    then isOtkaz:=1  else isOtkaz:=0;
  ModalResult:=mrOk;
end;

end.
