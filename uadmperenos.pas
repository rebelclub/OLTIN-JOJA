unit uadmperenos;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Grids, AdvObj, BaseGrid, AdvGrid,
  Vcl.ExtCtrls, AdvUtil;

type
  TperenosForm = class(TForm)
    sg: TAdvStringGrid;
    Panel1: TPanel;
    procedure FormCreate(Sender: TObject);
    procedure sgDblClick(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure FormActivate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  perenosForm: TperenosForm;

implementation

{$R *.dfm}

uses uadmconsts;

procedure TperenosForm.FormActivate(Sender: TObject);
var i:Integer;
begin
  with sg do
  begin
    ColCount:=1;RowCount:=OTDELSCNT+1;
    cells[0,0]:='信桥新';ColWidths[0]:=150;
    for I := 1 to OTDELSCNT do
      Cells[0,i]:=OTDELSNAIM[i];
  end;
end;

procedure TperenosForm.FormCreate(Sender: TObject);
var i:Integer;
begin
//  with sg do
//  begin
//    ColCount:=1;RowCount:=OTDELSCNT+1;
//    cells[0,0]:='信桥新';ColWidths[0]:=150;
//    for I := 1 to OTDELSCNT do
//      Cells[0,i]:=OTDELSNAIM[i];
//  end;
end;

procedure TperenosForm.FormKeyPress(Sender: TObject; var Key: Char);
begin
 if Key=#27 then Close;
 if Key=#13 then  ModalResult:=mrOk;
end;

procedure TperenosForm.sgDblClick(Sender: TObject);
begin
  ModalResult:=mrOk;
end;

end.
