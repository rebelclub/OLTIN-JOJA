//Á.Ð.Ð.
unit uadmcudaprn;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Buttons, Vcl.ExtCtrls,
  sComboBox, sBitBtn;

type
  TprnCUDAForm = class(TForm)
    rg: TRadioGroup;
    cbPrns: TsComboBox;
    sBitBtn1: TsBitBtn;
    sBitBtn2: TsBitBtn;
    procedure FormActivate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    curr:Integer;
  end;

var
  prnCUDAForm: TprnCUDAForm;

implementation
uses Vcl.Printers, uadmdb, uadmconsts;

{$R *.dfm}

procedure TprnCUDAForm.FormActivate(Sender: TObject);
var tipprr,i:Integer;
begin
  cbPrns.Items.Clear;
  for i := 0 to Printer.Printers.Count-1 do
  cbPrns.Items.Add(Printer.Printers[i]);
  cbPrns.ItemIndex:=curr;

  with dm.qwork do
  begin
    SQL.Text:='SELECT TIPPRR FROM TOTDELS WHERE PRR='+I2S(curr);
    Active:=False; Active:=True;
    tipprr:=FieldByName('TIPPRR').AsInteger;
    rg.ItemIndex:=tipprr;
  end;
end;


end.
