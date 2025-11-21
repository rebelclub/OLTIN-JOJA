//Б.Р.Р.
unit uadmprnform;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Buttons, Vcl.ExtCtrls,
  AdvGlassButton;

type
  TprnOrderForm = class(TForm)
    Panel1: TPanel;
    mm: TMemo;
    edtPlastik: TEdit;
    cbPlastik: TCheckBox;
    BtnOK: TAdvGlassButton;
    Label1: TLabel;
    BtnClose: TAdvGlassButton;
    Label2: TLabel;
    btncalc: TButton;
    CalcLabel: TLabel;
    btnPrint: TAdvGlassButton;
    procedure FormActivate(Sender: TObject);
    procedure cbPlastikClick(Sender: TObject);
    procedure BtnOKClick(Sender: TObject);
    procedure BtnCloseClick(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure btncalcClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure btnPrintClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    allSumma:Integer;
    schClosed:Boolean;
  end;

var
  prnOrderForm: TprnOrderForm;

implementation

{$R *.dfm}

uses uadmconsts, uadmmain, unlockform;

procedure TprnOrderForm.cbPlastikClick(Sender: TObject);
begin
  if not cbPlastik.Checked
  then begin edtPlastik.Enabled:=True;FocusControl(cbPlastik);end
  else begin edtPlastik.Enabled:=True;FocusControl(edtPlastik);end;
end;

procedure TprnOrderForm.FormActivate(Sender: TObject);
begin
  panel1.Height:=68;  calclabel.Visible:=False;
  if schClosed then BtnOK.Visible:=False else BtnOK.Visible:=True;
  if schClosed then Label1.Visible:=False else Label1.Visible:=True;
  edtPlastik.Text:=I2S(allSumma);
  if not cbPlastik.Checked
  then begin edtPlastik.Enabled:=True;FocusControl(cbPlastik);end
  else begin edtPlastik.Enabled:=True;FocusControl(edtPlastik);end;
end;

procedure TprnOrderForm.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  case key of
    VK_Shift:   if (ssShift in Shift) then btncalc.Click;
    VK_Control: if (ssCtrl in Shift) then begin panel1.Height:=68; calclabel.Visible:=False; end;
    VK_Return:  if ((ssAlt in Shift)or(ssCtrl in Shift))or(ssShift in Shift) then btnPrint.Click;
  end;
end;

procedure TprnOrderForm.FormKeyPress(Sender: TObject; var Key: Char);
var s:string;
begin
  if Key='+' then FocusControl(edtPlastik);
  if Key=#13 then BtnOK.click;
  if Key=#27 then BtnClose.Click;
end;

procedure TprnOrderForm.BtnOKClick(Sender: TObject);
var iTmp:Integer;
begin
 if AdminPassForm.ShowModal<>mrYes then Exit;
 if(cbPlastik.Checked and not TryStrToInt(edtPlastik.Text,iTmp)) then
 begin edtPlastik.SelectAll;FocusControl(edtPlastik); Exit; end;
 formMain.edit1.Text:='';  ModalResult:=mrOk;
end;

procedure TprnOrderForm.btnPrintClick(Sender: TObject);
begin
  formMain.edit1.Text:='';  ModalResult:=mrRetry;
end;

procedure TprnOrderForm.btncalcClick(Sender: TObject);
var i:integer;
    s:string;
begin
  s:=edtPlastik.text;
  i:=StrToInt(s)-allsumma;
  if i>0 then
  begin
    panel1.Height:=80;  calclabel.Visible:=True;
    CalcLabel.Caption:='Cдача'+'  '+FormatFloat('###,###,##0.##',i);
  end;
  if i<0 then
  begin
   panel1.Height:=80;  calclabel.Visible:=True;
   CalcLabel.Caption:='Осталось'+'  '+FormatFloat('###,###,##0.##',i);
  end;
end;

procedure TprnOrderForm.BtnCloseClick(Sender: TObject);
begin
  formMain.edit1.Text:='';  Close;
end;

end.
