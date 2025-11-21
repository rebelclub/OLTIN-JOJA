//Á.Ð.Ð.
unit uadmprnt;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Grids, AdvObj, BaseGrid, AdvGrid,
  AdvUtil;

type
  TprnForm = class(TForm)
    sg: TAdvStringGrid;
    procedure FormActivate(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure sgDblClickCell(Sender: TObject; ARow, ACol: Integer);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }
  public
    { Public declarations }
   procedure RedrawPrinters(IdOtdel:Integer=0);
  end;

var
  prnForm: TprnForm;

implementation

{$R *.dfm}

uses uadmconsts, uadmdb,Vcl.Printers, uadmcudaprn;

procedure TprnForm.FormCreate(Sender: TObject);
begin
  with sg do
  begin
    ColCount:=4;ColWidths[2]:=0;ColWidths[3]:=0;
  end;
end;

procedure TprnForm.FormKeyPress(Sender: TObject; var Key: Char);
begin
 if Key=#27 then Close;
end;

procedure TprnForm.FormActivate(Sender: TObject);
begin
  RedrawPrinters;
end;

procedure TprnForm.RedrawPrinters(IdOtdel:Integer);
var cRow,prCnt,prr,initRow:Integer;
begin
  sg.RowCount:=2;sg.Rows[1].Clear;initRow:=1;
  prCnt:=Printer.Printers.Count;
  with dm.qwork do
  begin
    Active:=False;SQL.Text:='SELECT OTDELID,NAIM,PRR FROM TOTDELS WHERE OTDELID>0 ORDER BY OTDELID';Active:=True;
    First;cRow:=1;while not Eof do
    begin
      sg.cells[0,cRow]:=FieldByName('NAIM').AsString;
      prr:=FieldByName('PRR').AsInteger;
      if(prr>=prCnt) then prr:=0;
      sg.Cells[1,cRow]:=Printer.Printers[prr];
      if(FieldByName('OTDELID').AsInteger=IdOtdel) then initRow:=cRow;
      sg.cells[2,cRow]:=FieldByName('OTDELID').AsString;
      sg.cells[3,cRow]:=FieldByName('PRR').AsString;
      cRow:=cRow+1;sg.RowCount:=sg.RowCount+1;sg.Rows[cRow].Clear;
      Next;
    end;
  end;
  if(sg.RowCount>2) then sg.RowCount:=sg.RowCount-1;
  sg.Row:=initRow;sg.Refresh;
end;

procedure TprnForm.sgDblClickCell(Sender: TObject; ARow, ACol: Integer);
var idOtdel,prr,tipprr:Integer;
begin
  if((ARow<sg.RowCount) and (ARow>0)) then
  begin
    idOtdel:=StrToInt(sg.Cells[2,ARow]);
    prr:=StrToInt(sg.Cells[3,ARow]);
    prnCUDAForm.curr:=prr;
    if(prnCUDAForm.ShowModal=mrOk) then
    begin
      prr:=prnCUDAForm.cbPrns.ItemIndex;
      tipprr:=prnCUDAForm.rg.ItemIndex;
      if prr>=0 then
      begin
        ExecQ('UPDATE TOTDELS SET PRR='+I2S(prr)+' WHERE OTDELID='+I2S(idOtdel));
        ExecQ('UPDATE TOTDELS SET TIPPRR='+I2S(tipprr)+' WHERE PRR='+I2S(prr));
//        ExecQ('UPDATE TGROUPS SET TIPPRR='+I2S(tipprr)+' WHERE PRR='+I2S(PRR));
        RedrawPrinters(idOtdel);
      end;
    end;
  end;
end;

end.
