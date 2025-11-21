unit _activation;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, sLabel, sEdit, sButton,
  Vcl.ExtCtrls, sPanel, sSkinManager;

type
  TFormRegistration = class(TForm)
    sPanel1: TsPanel;
    btnOk: TsButton;
    edt1: TsEdit;
    lbl1: TLabel;
    procedure btnOkClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FormRegistration: TFormRegistration;

implementation

uses
  uadmmain, unlockform, uadmconsts, uadmdb;

{$R *.dfm}

procedure TFormRegistration.FormActivate(Sender: TObject);
var dlg:TForm;
  s:string;
 ostatok: Integer;
begin
  formMain.SurogID:=FirstI('SELECT IDTMP FROM TTMPPRN');
  formMain.genID:=FirstI('SELECT GEN_ID(GEN_TMPPRN_ID, 0) FROM RDB$DATABASE');
  ostatok:=formMain.SurogID-formMain.genID;
  edt1.Text:=FirstS('SELECT IDTMP FROM TTMPPRN');
  FocusControl(edt1);
  edt1.SelectAll;
  if edt1.Text='' then
  dlg:=CreateMessageDialog('PLEASE WRITE'+#13+'  000!', mtInformation, [mbOk], mbOK) else
  dlg:=CreateMessageDialog('У  вас  осталось  '+I2S(ostatok)+'  дней  '+#13+
      'Пожалуйста активируйте программу!', mtInformation, [mbOk], mbOK);
  Dlg.Caption := 'Предупреждение';
  try
    with TLabel(Dlg.FindComponent('message')) do begin Font.Style:=[fsBold]; end;
    Dlg.ShowModal;
  finally
    Dlg.Free;
  end
end;

procedure TFormRegistration.FormKeyPress(Sender: TObject; var Key: Char);
begin
  if Key=#13 then btnOk.Click;
  if Key=#27 then Close;
end;

procedure TFormRegistration.btnOkClick(Sender: TObject);
var s,date:string;
begin
  date:=edt1.Text;
  AdminPassForm.ShowModal;
  if AdminPassForm.Edit1.Text<>'2580248s6622' then
  begin
    AdminPassForm.Close;  FormRegistration.Close;
  end
  else
  begin
    ExecQ('ALTER SEQUENCE GEN_TMPPRN_ID RESTART WITH 0');
    if date='000' then s:='INSERT INTO TTMPPRN (IDTMP,IDOTDEl,DTA) VALUES ('+date+',1,1)' else
    s:='UPDATE TTMPPRN SET IDTMP='+date+' WHERE IDOTDEL=1';
    ExecQ(s);
    Close;
  end;
end;

end.
