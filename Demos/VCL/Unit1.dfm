object Form1: TForm1
  Left = 312
  Top = 113
  BiDiMode = bdRightToLeft
  Caption = 'Form1'
  ClientHeight = 185
  ClientWidth = 532
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  ParentBiDiMode = False
  TextHeight = 13
  object Label1: TLabel
    Left = 40
    Top = 80
    Width = 433
    Height = 41
    AutoSize = False
    WordWrap = True
  end
  object Edit1: TEdit
    Left = 352
    Top = 40
    Width = 121
    Height = 21
    TabOrder = 0
    OnChange = Edit1Change
  end
  object TULIPTafkit1: TTULIPTafkit
    Pound.PoundName = #1604#1610#1585#1577
    Pound.OnePound = #1604#1610#1585#1577
    Pound.TwoPounds = #1604#1610#1585#1578#1575#1606
    Pound.From3To9Pounds = #1604#1610#1585#1575#1578
    Pound.OnePound_tanwin = #1604#1610#1585#1577#1611
    Pound.Sex = s_Female
    Cent.PoundName = #1602#1585#1588
    Cent.OnePound = #1602#1585#1588
    Cent.TwoPounds = #1602#1585#1588#1575#1606
    Cent.From3To9Pounds = #1602#1585#1608#1588
    Cent.OnePound_tanwin = #1602#1585#1588#1575#1611
    Cent.Sex = s_Male
    Left = 72
    Top = 32
  end
end
