//Á.Ð.Ð.
unit uadmcudareserv;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls;

type
  TcudaReservForm = class(TForm)
    buyurt: TLabeledEdit;
    Panel1: TPanel;
    tel: TLabeledEdit;
    fortime: TLabeledEdit;
    zakaz: TLabeledEdit;
    zakolat: TLabeledEdit;
    rezerv: TCheckBox;
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    Gost: TLabeledEdit;
    procedure Button1Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  cudaReservForm: TcudaReservForm;

implementation

{$R *.dfm}

procedure TcudaReservForm.Button1Click(Sender: TObject);
begin
  buyurt.Text:='';
  tel.Text:='';
  fortime.Text:='1200';
  zakaz.Text:='';
  zakolat.Text:='0';
  Gost.Text:='0';
  rezerv.Checked:=False;
  FocusControl(buyurt);
end;

procedure TcudaReservForm.Button3Click(Sender: TObject);
var iTmp:Integer;
begin
  if not TryStrToInt(fortime.Text,iTmp) or (iTmp>2400) or (iTmp<0)
  then begin FocusControl(fortime);fortime.SelectAll;Exit;end;
  ModalResult:=mrOk;
end;

procedure TcudaReservForm.FormKeyPress(Sender: TObject; var Key: Char);
begin
  if Key=#27 then Close;
  if Key=#13 then Button3.Click;
end;

end.
