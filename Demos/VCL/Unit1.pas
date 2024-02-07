unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, TULIPTafkit;

type
  TForm1 = class(TForm)
    Edit1: TEdit;
    Label1: TLabel;
    TULIPTafkit1: TTULIPTafkit;
    procedure Edit1Change(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.DFM}

procedure TForm1.Edit1Change(Sender: TObject);
var
  v: double;
begin
  label1.caption := '';
  if TryStrToFloat(Edit1.Text, v) then
  begin
    TULIPTafkit1.Num := v;
    Label1.caption := TULIPTafkit1.WriteNum;
  end;
end;

end.
