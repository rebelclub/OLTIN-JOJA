//Á.Ð.Ð.
unit uadmcudabluds;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls;

type
  TcudaBludForm = class(TForm)
    edtNaim: TLabeledEdit;
    edtKod: TLabeledEdit;
    edtPrice: TLabeledEdit;
    chkAvail: TCheckBox;
    btnOk: TButton;
    btnCancel: TButton;
    chkIssale: TCheckBox;
    edtNavbat: TLabeledEdit;
    procedure FormActivate(Sender: TObject);
    procedure btnOkClick(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }
  public
    { Public declarations }
    kod,naim:string;
    navbat,issale,avail,price:Integer;
  end;

var
  cudaBludForm: TcudaBludForm;

implementation

{$R *.dfm}

procedure TcudaBludForm.FormActivate(Sender: TObject);
begin
  edtNaim.Text:=naim;
  edtKod.Text:=kod;
  edtNavbat.Text:=IntToStr(navbat);
  edtPrice.Text:=IntToStr(price);
  if avail=1  then chkAvail.Checked:=True  else chkAvail.Checked:=False;
  if issale=1 then chkIssale.Checked:=True else chkIssale.Checked:=False;
  FocusControl(edtNaim);edtNaim.SelectAll;
end;

procedure TcudaBludForm.FormKeyPress(Sender: TObject; var Key: Char);
begin
  if Key=#27 then Close;
end;

procedure TcudaBludForm.btnOkClick(Sender: TObject);
var cNaim:string;
begin
  cNaim:=edtNaim.Text;
  if((Pos(',',cNaim)>0) or (Pos(';',cNaim)>0) or (Pos('|',cNaim)>0) or (Pos(':',cNaim)>0))
  then begin FocusControl(edtNaim);edtNaim.SelectAll;Exit;end;
  naim:=cNaim;  kod:=edtKod.Text; navbat:=StrToInt(edtNavbat.Text);  price:=StrToInt(edtPrice.Text);
  if chkAvail.Checked  then avail:=1  else avail:=0;
  if chkIssale.Checked then issale:=1 else issale:=0;
  ModalResult:=mrOk;
end;

end.
