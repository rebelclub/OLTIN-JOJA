//Б.Р.Р.
unit uadmcabins;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls, sComboBox,
  Vcl.Mask, sMaskEdit, sCustomComboEdit;

type
  TcabinForm = class(TForm)
    setBtn: TButton;
    mestimost: TLabeledEdit;
    cSummEdit: TLabeledEdit;
    cbCabin: TsComboBox;
    procedure FormActivate(Sender: TObject);
    procedure setBtnClick(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure cbCabinCloseUp(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  cabinForm: TcabinForm;

implementation

{$R *.dfm}

uses uadmdb, uadmconsts;

procedure TcabinForm.cbCabinCloseUp(Sender: TObject);
var i:Integer;
begin
  i:=cbCabin.ItemIndex;
  cSummEdit.Text:=FirstS('select SUMM FROM TSTOLS WHERE STOLID='+I2S(101+i));
  mestimost.Text:=FirstS('select mestimost from tkabins where idkabin='+I2S(101+i));
end;

procedure TcabinForm.FormActivate(Sender: TObject);
var i:Integer;
begin
  i:=cbCabin.ItemIndex;  cbCabin.Items.Clear;
  with dm.qtemp do
  begin
    SQL.Text:='SELECT SUMM,STOLID FROM TSTOLS WHERE STOLID>100 and STOLID<132 ORDER BY STOLID';
    Active:=False; Active:=True; First;
    while not Eof do
    begin
      cbCabin.Items.Add('Кабина № '+I2S(FieldByName('STOLID').AsInteger-100)+' - '+
        FieldByName('SUMM').AsString+' сум');
     Next;
    end;
  end;
  cbCabin.ItemIndex:=0;
  cSummEdit.Text:=FirstS('select SUMM FROM TSTOLS WHERE STOLID=101');
  mestimost.Text:=FirstS('select mestimost from tkabins where idkabin=101');
  FocusControl(cbCabin);
end;

procedure TcabinForm.FormKeyPress(Sender: TObject; var Key: Char);
begin
 if Key=#27 then Close;
end;

procedure TcabinForm.setBtnClick(Sender: TObject);
var i,val:Integer;
begin
  if not TryStrToInt(cSummEdit.Text,val) then
    begin
      FocusControl(cSummEdit);
      cSummEdit.SelectAll;
    end;
  i:=cbCabin.ItemIndex;
  ExecQ('UPDATE TSTOLS SET SUMM='+I2S(val)+' WHERE STOLID='+I2S(101+i));
  ExecQ('UPDATE TKABINS SET MESTIMOST='+mestimost.Text+' WHERE IDKABIN='+I2S(101+i));
  cbCabin.Items[i]:='Кабина № '+I2S(i+1)+' - '+I2S(val)+' сум';
  cbCabin.ItemIndex:=i;cbCabin.Refresh;
  FocusControl(cbCabin);
end;

end.
