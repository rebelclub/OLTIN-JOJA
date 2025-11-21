unit unlockform;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls;

type
  TAdminPassForm = class(TForm)
    Edit1: TEdit;
    Unlock: TButton;
    procedure UnlockClick(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure FormActivate(Sender: TObject);
  private
    { Private declarations }
  public
  pass,pass2,pass3:string;
    { Public declarations }
  end;

var
  AdminPassForm: TAdminPassForm;

implementation

{$R *.dfm}

uses uadmprnt, uadmdb, uadmmain;

procedure TAdminPassForm.FormActivate(Sender: TObject);
var cRow:Integer;
begin
  pass:=FirstS('select passw from tusers where role=0');

  formMain.GetPass;
  pass2:=formMain.apass;

  pass3:=FirstS('select passw from tusers where role=3');

  FocusControl(Edit1);
  Edit1.Text:='';
end;

procedure TAdminPassForm.FormKeyPress(Sender: TObject; var Key: Char);
begin
 if Key=#27 then Close;
 if Key=#13 then Unlock.Click;
end;

procedure TAdminPassForm.UnlockClick(Sender: TObject);
begin
  if AdminPassForm.Edit1.Text=pass then ModalResult:=mrOk else
  if AdminPassForm.Edit1.Text=pass2 then ModalResult:=mrRetry else
  if AdminPassForm.Edit1.Text=pass3 then ModalResult:=mrYes else ModalResult:=mrCancel;
end;

end.

