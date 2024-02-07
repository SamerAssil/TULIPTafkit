unit Unit2;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants, system.StrUtils,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.StdCtrls, FMX.Controls.Presentation, FMX.Edit,
  TULIPTafkit;

type
  TForm2 = class(TForm)
    Edit1: TEdit;
    Label1: TLabel;
    TULIPTafkit1: TTULIPTafkit;
    procedure Edit1ChangeTracking(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form2: TForm2;

implementation

{$R *.fmx}


procedure TForm2.Edit1ChangeTracking(Sender: TObject);
var
  v: double;
begin
  label1.Text := '';
  if TryStrToFloat(Edit1.Text, v) then
  begin
    TULIPTafkit1.Num := v;
    Label1.Text := TULIPTafkit1.WriteNum;
  end;
end;

end.


