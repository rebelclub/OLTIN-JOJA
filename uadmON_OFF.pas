unit uadmON_OFF;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Buttons, sBitBtn,
  sComboBox;

type
  TFormON_OFF = class(TForm)
    cbOtdels: TsComboBox;
    btnOn: TsBitBtn;
    btnOff: TsBitBtn;
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure FormActivate(Sender: TObject);
    procedure btnOnClick(Sender: TObject);
    procedure btnOffClick(Sender: TObject);
    procedure CheckStatus;
    procedure cbOtdelsChange(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FormON_OFF: TFormON_OFF;

implementation

uses
  uadmconsts, uadmdb;

{$R *.dfm}

procedure TFormON_OFF.FormActivate(Sender: TObject);
var i:Integer;
begin
  cbOtdels.Items.Clear;
  for I := 1 to OTDELSCNT do cbOtdels.Items.Add(otdelsnaim[i]);
  cbOtdels.ItemIndex:=0;
  FocusControl(cbOtdels);
  CheckStatus;
end;

procedure TFormON_OFF.btnOnClick(Sender: TObject);
var idotdel:Integer;
begin
  idotdel:=cbOtdels.ItemIndex+1;
  ExecQ('update tbluds set isactive=0 where otdelid='+I2S(idotdel));
  CheckStatus;
  FocusControl(cbOtdels);
end;

procedure TFormON_OFF.cbOtdelsChange(Sender: TObject);
begin
  CheckStatus;
end;

procedure TFormON_OFF.btnOffClick(Sender: TObject);
var idotdel:Integer;
begin
  idotdel:=cbOtdels.ItemIndex+1;
  ExecQ('update tbluds set isactive=1 where otdelid='+I2S(idotdel));
  CheckStatus;
  FocusControl(cbOtdels);
end;

procedure TFormON_OFF.CheckStatus;
var idotdel,status:Integer;
begin
  idotdel:=cbOtdels.ItemIndex+1;
  status:=FirstI('SELECT ISACTIVE FROM TBLUDS WHERE OTDELID='+I2S(idotdel));
  if status=1 then begin btnOn.Enabled:=True;   btnOff.Enabled:=False; end else
  if status=0 then begin btnOff.Enabled:=True;  btnOn.Enabled:=False; end;
end;

procedure TFormON_OFF.FormKeyPress(Sender: TObject; var Key: Char);
begin
  if Key=#27 then Close;
  if Key=#13 then btnOn.Click;
end;

end.
