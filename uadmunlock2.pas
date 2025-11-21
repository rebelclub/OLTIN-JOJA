unit uadmunlock2;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls;

type
  TForm1 = class(TForm)
    BtnOk: TButton;
    Edit1: TEdit;
    lbl1: TLabel;
    procedure BtnOkClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.FormActivate(Sender: TObject);
begin
  FocusControl(Edit1);
  Edit1.Text:='';
end;

procedure TForm1.FormKeyPress(Sender: TObject; var Key: Char);
begin
 if Key=#27 then Close;
 if Key=#13 then BtnOk.Click;
end;

procedure TForm1.BtnOkClick(Sender: TObject);
begin
  ModalResult:=mrOk;
end;

end.
