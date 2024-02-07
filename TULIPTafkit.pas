{ ******************************************************* }
{                                                         }
{               TULIPsoft - Samer Assil                   }
{                                                         }
{                 samerassil@gmail.com                    }
{                                                         }
{ ******************************************************* }

(*
Cent : هو جزء العملة

Pound : هو العملة
*)

unit TULIPTafkit;

interface

uses
  System.SysUtils,
  System.Classes,
  Vcl.StdCtrls;

Type
  TLevel   = 0 .. 5;
  TSex     = (s_Male, s_Female);
  TNums    = Array [1 .. 9] of String;
  TOddNums = Array [0 .. 5] of String;

  TParamRec = Record
    P_Name, P_One, P_Two, P_From3To9, P_Onen: String;
    P_Sex: TSex;
    P_Level: TLevel;
  end;

  TParam = class(TPersistent)
  private
    FPoundName:      String;
    FOnePound:       String;
    FFrom3To9Pounds: String;
    FTwoPounds:      String;
    FSex:            TSex;
    FOnePound_n:     String;
    FLevel:          TLevel;
    procedure SetPoundName(const Value: String);
    procedure SetOnePound(const Value: String);
    procedure SetTwoPounds(const Value: String);
    procedure SetFrom3To9Pounds(const Value: String);
    procedure SetOnePound_n(const Value: String);
    procedure SetSex(const Value: TSex);
  public
    constructor Create; virtual;
    destructor Destroy; override;
    procedure Assign(Source: TPersistent); override;
    procedure GetDataFromParamRec(ParamRec: TParamRec);
  protected
    property Level:          TLevel read FLevel;
  published
    property PoundName:      String read FPoundName write SetPoundName;
    property OnePound:       String read FOnePound write SetOnePound;
    property TwoPounds:      String read FTwoPounds write SetTwoPounds;
    property From3To9Pounds: String read FFrom3To9Pounds write SetFrom3To9Pounds;
    property OnePound_tanwin:     String read FOnePound_n write SetOnePound_n;
    property Sex:            TSex read FSex write SetSex;
  end;

const
  MofradMaleNums: TNums   = ('واحداً', 'اثنان', 'ثلاثةُ', 'أربعةُ', 'خمسةُ', 'ستةُ', 'سبعةُ', 'ثمانيةُ', 'تسعةُ');
  MofradFemaleNums: TNums = ('واحدةً', 'اثنتان', 'ثلاثُ', 'أربعُ', 'خمسُ', 'ستُ', 'سبعُ', 'ثمانُ', 'تسعُ');
  OkadiMaleNums: TNums                    = ('واحد', 'اثنان', 'ثلاثة', 'أربعة', 'خمسة', 'ستة', 'سبعة', 'ثمانية', 'تسعة');
  OkadiFemaleNums: TNums                  = ('إحدى', 'اثنتان', 'ثلاث', 'أربع', 'خمس', 'ست', 'سبع', 'ثمان', 'تسع');
  MaleTen                                 = 'عشر';
  FemaleTen                               = 'عشرة';
  TwoHundredNum: Array [0 .. 5] of String = ('مئتا', 'مئتا', 'ألفا', 'مليونا', 'مليارا', 'بليارا');
  HundredsNum: Array [1 .. 9] of String   = ('مائة', 'مئتان', 'ثلاثمئة', 'أربعمئة', 'خمسمئة', 'ستمئة', 'سبعمئة', 'ثمانمئة', 'تسعمئة');
  ZeroNum                           = 'صفر';
  Zero                              = 0;
  TensNum: Array [2 .. 9] of String = ('عشرون', 'ثلاثون', 'أربعون', 'خمسون', 'ستون', 'سبعون', 'ثمانون', 'تسعون');
  // HundredsNum: Array[1..9] of String = ('مئة', 'مئتان', 'ثلاثمئة', 'أربعمئة', 'خمسمئة', 'ستمئة', 'سبعمئة', 'ثمانمئة', 'تسعمئة');
  PartsNum: Array [1 .. 3] of String = ('ربع', 'نصف', 'ثلاثة أرباع');
  OddNums: TOddNums                  = ('000', '001', '002', '011', '012', '200');
  OddMaleNums: TOddNums              = ('*****', 'واحد', 'اثنان', 'أحد', 'اثنا', '*****');
  OddFemaleNums: TOddNums            = ('*****', 'واحدة', 'اثنتان', 'إحدى', 'اثنتا', '*****');

var
  ConstsParts: array [0 .. 5] of TParamRec = (
    (
    ), // For Cents
    (
    ), // For Pounds
    (
      P_Name: 'ألف'; P_One: 'ألف'; P_Two: 'ألفان'; P_From3To9: 'آلاف'; P_Onen: 'ألفاً'; P_Sex: s_Male; P_Level: 2),

    (P_Name: 'مليون'; P_One: 'مليون'; P_Two: 'مليونان'; P_From3To9: 'ملايين'; P_Onen: 'مليوناً'; P_Sex: s_Male; P_Level: 3),

    (P_Name: 'مليار'; P_One: 'مليار'; P_Two: 'ملياران'; P_From3To9: 'مليارات'; P_Onen: 'ملياراً'; P_Sex: s_Male; P_Level: 4),

    (P_Name: 'بليار'; P_One: 'بليار'; P_Two: 'بلياران'; P_From3To9: 'بليارات'; P_Onen: 'بلياراً'; P_Sex: s_Male; P_Level: 5));

type
  TStrNum = String[3];

  TParts = class(TObject)
  private
    FPoundName: String;
  Private
    FStrNum:          TStrNum;
    FParam:           TParam;
    FS1:              String;
    FS3:              String;
    FS2:              String;
    FW1:              String;
    FW2:              String;
    FWriteNum:        String;
    FisEndNum:        Boolean;
//    FCountryPound:    String;
//    FTwoCountryPound: String;
    FThereIsMore:     Boolean;
    OddWriteNums:    TOddNums;
    FOne_n_Pound:    String;
//    FCountryPound_n: String;
    FNeedParam:      Boolean;
    procedure SetStrNum(const Value: TStrNum);
    Function MakeWriteNum: String;
    function GetWriteNum: String;
    procedure SetThereIsMore(const Value: Boolean);
    function GetParam: TParam;
    Property PoundName: String read FPoundName write FPoundName;
  public
    OkadiNums:   TNums;
    AloneTen:    String;
    NotAloneTen: String;
    MofradNums:  TNums;
    constructor Create;
    procedure SetValues(ParamSex: TSex);
    property StrNum: TStrNum read FStrNum write SetStrNum;
    property isEndNum: Boolean read FisEndNum write FisEndNum;
    Property Param: TParam read GetParam write FParam;
    Property S1: String read FS1 write FS1;
    Property S2: String read FS2 write FS2;
    Property S3: String read FS3 write FS3;
    Property W2: String read FW1 write FW1;
    Property W3: String read FW2 write FW2;
    Property WriteNum: String read GetWriteNum write FWriteNum;
//    Property CountryPound: String read FCountryPound write FCountryPound;
//    Property TwoCountryPound: String read FTwoCountryPound write FTwoCountryPound;
//    Property CountryPound_tanwin: String read FCountryPound_n write FCountryPound_n;
    property ThereIsMore: Boolean read FThereIsMore write SetThereIsMore;
    property One_tanwin_Pound: String read FOne_n_Pound write FOne_n_Pound;
    Property NeedParam: Boolean read FNeedParam write FNeedParam;
  end;

  TFiveParts = Array [0 .. 5] of TParts;

  TTULIPTafkit = class(TComponent)
  private
    FCent:                  TParam;
    FPound:                 TParam;
    FWriteNum:              String;
    FNum:                   Real;
    Parts:                  TFiveParts;
//    FCountryPound:          String;
//    FCountryPound_n:        String;
    PartStrNum:             Array [0 .. 5] of String;
//    FTwoMaleCountryPound:   String;
//    FTwoFemaleCountryPound: String;
    procedure SetCent(const Value: TParam);
    procedure SetPound(const Value: TParam);
    procedure SetNum(const Value: Real);
    function GetWriteNum: String;
//    procedure SetCountryPound(const Value: String);
//    procedure SetCountryPound_n(const Value: String);
//    procedure SetTwoFemaleCountryPound(const Value: String);
//    procedure SetTwoMaleCountryPound(const Value: String);
  protected
    procedure FillParts;
    procedure Init;
  public
    Constructor Create(Aowner: TComponent); override;
    destructor Destroy; override;
  published
    property Pound:                 TParam read FPound write SetPound;
    property Cent:                  TParam read FCent write SetCent;
    property WriteNum:              String read GetWriteNum write FWriteNum;
    Property Num:                   Real read FNum write SetNum;
//    Property CountryPound:          String read FCountryPound write SetCountryPound;
//    Property CountryPound_Tanwin:        String read FCountryPound_n write SetCountryPound_n;
//    Property TwoMaleCountryPound:   String read FTwoMaleCountryPound write SetTwoMaleCountryPound;
//    Property TwoFemaleCountryPound: String read FTwoFemaleCountryPound write SetTwoFemaleCountryPound;
  end;

procedure Register;

implementation

procedure Register;
begin
  RegisterComponents('TULIPsoft', [TTULIPTafkit]);
end;

{ TTULIPNumSource }

constructor TTULIPTafkit.Create(Aowner: TComponent);
begin
  Inherited;
  Init;
end;

destructor TTULIPTafkit.Destroy;
begin
  FPound.Free;
  FCent.Free;
  inherited Destroy;
end;

procedure TTULIPTafkit.FillParts;
Var
  i: SmallInt;
begin
  Parts[0].Param := Cent;
  Parts[1].Param := Pound;

  for i := 2 to 5 do
  Begin
    Parts[i].Param.GetDataFromParamRec(ConstsParts[i]);
    Parts[i].PoundName := Pound.PoundName;
//    Parts[i].CountryPound := CountryPound;
//    Parts[i].CountryPound_tanwin := CountryPound_Tanwin;
//    Parts[i].TwoCountryPound := Self.TwoMaleCountryPound;
  end;
end;

function TTULIPTafkit.GetWriteNum: String;
Var
  S: String;
  i: SmallInt;
  W: String;
begin
  // تصليح : عزل الجزء القروش عن جزء الليرات ثم جمع الرقمين المكتوبين
  S := '';
  W := '';
  for i := 0 to 5 do
  begin
    if Parts[i].WriteNum <> '' then
    begin
      if S <> '' then
        S := ' و' + S;
      S := Parts[i].WriteNum + W + S;
//      if (Parts[i].NeedParam = True) then
//        S := S + ' ' + CountryPound;
    end;
  end;
  FWriteNum := S;
  Result := FWriteNum; // + ' ***';
end;

procedure TTULIPTafkit.Init;
Var
  i: SmallInt;
begin
  for i := 0 to 5 do
    Parts[i] := TParts.Create;

  FPound := TParam.Create;
  With FPound do
  begin
    FLevel := 1; // تحديد المستوى 1 لليرات ـ بالنسبة للعملة السورية
    PoundName := 'ليرة';
    OnePound := 'ليرة';
    OnePound_tanwin := 'ليرةً';
    TwoPounds := 'ليرتان';
    From3To9Pounds := 'ليرات';
    Sex := s_Female;
  end;

  FCent := TParam.Create;
  With FCent do
  begin
    FLevel := 0; // تحديد المتسوى 0 للقروش -بالنسبة للعملة السورية
    PoundName := 'قرش';
    OnePound := 'قرش';
    OnePound_tanwin := 'قرشاً';
    TwoPounds := 'قرشان';
    From3To9Pounds := 'قروش';
    Sex := s_Male;
  end;
  FillParts;
end;

procedure TTULIPTafkit.SetCent(const Value: TParam);
begin
  FCent.Assign(Value);
  ConstsParts[0].P_Name := FCent.PoundName;
  ConstsParts[0].P_From3To9 := FCent.From3To9Pounds;
  ConstsParts[0].P_One := FCent.OnePound;
  ConstsParts[0].P_Onen := FCent.OnePound_tanwin;
  ConstsParts[0].P_Sex := FCent.Sex;
  ConstsParts[0].P_Two := FCent.TwoPounds;
  ConstsParts[0].P_Level := FCent.Level;
  FillParts;
end;

{ TPart }

constructor TParts.Create;
begin
  FParam := TParam.Create;
  SetValues(ConstsParts[Param.Level].P_Sex);
end;

function TParts.GetParam: TParam;
begin
  Result := FParam;
end;

function TParts.GetWriteNum: String;
begin
  Result := FWriteNum;
end;

function TParts.MakeWriteNum: String;
  function isOdd(var R: String; var Need: Boolean): Boolean;
  var
    i: SmallInt;
  begin
    Result := False;
    Need := False;
    for i := 0 to 5 do
    begin
      if StrNum = OddNums[i] then
      begin
        Case i of
          { 000 } 0:
            begin
              R := '';
              Result := True;
              Need := False;
            end;
          { 001 } 1:
            begin
              Case Param.Level of
                0 .. 1: // القروش والمئات
                  begin
                    if ThereIsMore then
                    begin
                      R := Param.OnePound_tanwin{ + ' ' + CountryPound};
                      NeedParam := True;
                    end
                    else
                    begin
                      R := Param.OnePound + {' ' + CountryPound +} ' ' + MofradNums[Param.Level];
                      NeedParam := False;
                    end;
                  end;
                2:
                  begin
                    if ThereIsMore then
                    begin
                      R := Param.OnePound ;
                      NeedParam := False;
                    end
                    else
                    begin
                      R := Param.OnePound + ' ' + PoundName;
                      NeedParam := True;
                    end;
                  end;
                3 .. 5: // الآلاف والملايين والمليارات والبليارات
                  Begin
                    if ThereIsMore then
                    begin
                      R := Param.OnePound_tanwin + ' ' + PoundName;
                      NeedParam := False;
                    end
                    else
                    begin
                      R := Param.OnePound + ' ' + PoundName;
                      NeedParam := True;
                    end;
                  end;
              end;
              Result := True;
            end;
          { 002 } 2:
            Begin
              Case Param.Level of
                0 .. 1:
                  begin
                    if ThereIsMore then
                    begin
                      R := Param.TwoPounds;
                      NeedParam := True;
                    end
                    else
                    begin
                      R := Param.TwoPounds + {' ' + TwoCountryPound +} ' ' + MofradNums[2];
                      NeedParam := False;
                    end;
                  end;
                2 .. 5:
                  if ThereIsMore then
                  begin
                    R := TwoHundredNum[Param.Level] + ' ' + PoundName;
                    NeedParam := False;
                  end
                  else
                  begin
                    R := TwoHundredNum[Param.Level] + ' ' + PoundName;
                    NeedParam := True;
                  end;
              end;
              Result := True;
            end;
          { 011, 012 } 3, 4:
            Begin
              Case Param.Level of
                0:
                  begin
                    R := OddWriteNums[i] + ' ' + NotAloneTen + ' ' + Param.OnePound_tanwin + ' ' + PoundName;
                    NeedParam := True;
                  end;
                1 .. 5:
                  begin
                    if ThereIsMore then
                    begin
                      R := OddWriteNums[i] + ' ' + NotAloneTen + ' ' + Param.OnePound_tanwin;
                      NeedParam := False;
                    end
                    else
                    begin
                      R := OddWriteNums[i] + ' ' + NotAloneTen + ' ' + One_tanwin_Pound + ' ' + PoundName;
                      NeedParam := True;
                    end;
                  end;
              end;
              Result := True;
            end;
          { 200 } 5:
            Begin
              Case Param.Level of
                0 .. 1:
                  begin
                    if ThereIsMore then
                    begin
                      R := TwoHundredNum[Param.Level] + ' ' + PoundName;
                      NeedParam := False;
                    end
                    else
                    begin
                      R := TwoHundredNum[Param.Level] + ' ' + One_tanwin_Pound;
                      NeedParam := True;
                    end;
                  end;
                2 .. 5:
                  begin
                    R := TwoHundredNum[Param.Level] + ' ' + PoundName;
                  end;
              end;
              Result := True;
            end;
        end; // end of ( Case i )
      end; // end  of ( if StrNum = OddNums[i] )
    end; // end of ( for i := 0 to 5 )
  end; // function end;

Var
  R1, R2, RRR: String;
  TwoDigits:   Integer;
  Need:        Boolean;
Begin // يوجد Begin أخرى داخل الكود الملغى
  SetValues(Param.Sex);
  if isOdd(R1, Need) = False then
  begin // if the Part not an Odd Num then
    Case StrNum[1] of
      '0':
        R1 := '';
      '1' .. '9':
        begin
          R1 := HundredsNum[StrToInt(StrNum[1])];
          if (StrNum[2] + StrNum[3]) = '00' then
            R1 := R1 + ' ' + Param.OnePound_tanwin;
        end;
    end; // end of ( Case StrNum[1] do )
    TwoDigits := StrToInt(StrNum[2] + StrNum[3]);
    Case TwoDigits of
      0 .. 9:
        Begin
          Case StrNum[3] of
            '0':
              R2 := '';
            '1':
              begin
                Case Param.Level of
                  1:
                    Begin
                      if StrNum[2] = '0' then
                        if ThereIsMore then
                        begin
                          R2 := Param.OnePound_tanwin + ' ' + MofradNums[StrToInt(StrNum[3])];
                          NeedParam := True;
                        end
                        else
                        begin
                          R2 := Param.OnePound_tanwin {+ ' ' + CountryPound} + ' ' + MofradNums[StrToInt(StrNum[3])];
                          NeedParam := False;
                        end;
                    end;
                  2 .. 5:
                    begin
                      if StrNum[2] = '0' then
                        if ThereIsMore then
                        begin
                          R2 := Param.OnePound_tanwin + ' ' + MofradNums[StrToInt(StrNum[3])];
                          NeedParam := False;
                        end
                        else
                        begin
                          R2 := Param.OnePound_tanwin {+ ' ' + CountryPound} + ' ' + MofradNums[StrToInt(StrNum[3])];
                          NeedParam := False;
                        end;
                    end;
                end;
              end;
            '2':
              begin
                // if StrNum[2] <> '0' then
                if ThereIsMore then
                begin
                  R2 := Param.TwoPounds + ' ' + MofradNums[StrToInt(StrNum[3])];
                  NeedParam := True;
                end
                else
                begin
                  R2 := Param.TwoPounds + {' ' + TwoCountryPound +} ' ' + MofradNums[StrToInt(StrNum[3])];
                  NeedParam := False;
                end;
              end;
            '3' .. '9':
              R2 := MofradNums[StrToInt(StrNum[3])] + ' ' + Param.From3To9Pounds;
          end;
        end;
      10:
        begin
          R2 := AloneTen + ' ' + Param.From3To9Pounds;
        end;
      11, 12:
        R2 := OddWriteNums[StrToInt(StrNum[3]) + 2] + ' ' + NotAloneTen + ' ' + Param.OnePound_tanwin;
      // أضيف الرقم أثنان للحصول على العنصر الصحيح ضمن السلسلة
      13 .. 19:
        begin
          R2 := OkadiNums[StrToInt(StrNum[3])] + ' ' + NotAloneTen + ' ' + Param.OnePound_tanwin;
        end;
      20, 30, 40, 50, 60, 70, 80, 90:
        begin
          R2 := TensNum[StrToInt(StrNum[2])] + ' ' + Param.OnePound_tanwin;
        end;
    else
      begin
        R2 := OkadiNums[StrToInt(StrNum[3])] + ' و' + TensNum[StrToInt(StrNum[2])] + ' ' + Param.OnePound_tanwin;
      end;
    end;
  end;
  if (R2 <> '') and (R1 <> '') then
    W2 := ' و'
  else
    W2 := '';
  RRR := R1 + W2 + R2;
  Result := RRR;
end;

procedure TParts.SetStrNum(const Value: TStrNum);
begin
  FStrNum := Value;
  if FStrNum = '' then
    FStrNum := '000';
  WriteNum := MakeWriteNum;
end;

//procedure TTULIPNumSource.SetCountryPound(const Value: String);
//Var
//  i: SmallInt;
//begin
//  FCountryPound := Value;
//  for i := 0 to 5 do
//  begin
//    Parts[i].CountryPound := FCountryPound;
//  end;
//end;
//
//procedure TTULIPNumSource.SetCountryPound_n(const Value: String);
//Var
//  i: SmallInt;
//begin
//  FCountryPound_n := Value;
//  for i := 0 to 5 do
//    Parts[i].CountryPound_tanwin := FCountryPound_n;
//end;

procedure TTULIPTafkit.SetNum(const Value: Real);
Var
  S:        String;
  P:        SmallInt;
  CentPart: String;
  Index, i: Integer;
begin
  Init;
  begin
    FNum := Value;
    Str(FNum: 18: 2, S);
    P := Pos('.', S);
    if P <> 0 then
    begin
      CentPart := Copy(S, P + 1, 2);
      CentPart := '0' + CentPart;
      if Length(CentPart) <> 3 then
        CentPart := CentPart + '0'; // Samer ASSIL
      Delete(S, P, 3); // وليست Delete(S, P + 1, 3) لكي نحذف الفاصلة أيضاً
    end;
    Parts[0].ThereIsMore := False;
    /// There is no more parts after Parts[0]
    PartStrNum[0] := CentPart;
    Parts[0].StrNum := CentPart;
    S := StringReplace(S, ' ', '', [rfReplaceAll]);
    While Length(S) < 15 { Mod 3 <> 0 } do
      S := '0' + S;
    Index := 1;

    Parts[0].ThereIsMore := False;

    for i := 1 to 5 do
    begin
      Parts[i].ThereIsMore := True;
    end;

    for i := 5 downto 1 do
    begin
      PartStrNum[i] := Copy(S, Index, 3);
      Inc(Index, 3);
    end;

    for i := 0 to 4 do
    begin
      if PartStrNum[i] = '000' then
        Parts[i + 1].ThereIsMore := False
      else
        Parts[i + 1].ThereIsMore := True;
    end;

    for i := 5 Downto 1 do
    begin
      Parts[i].StrNum := PartStrNum[i];
    end;
  end;
end;

procedure TTULIPTafkit.SetPound(const Value: TParam);
begin
  FPound.Assign(Value);
  ConstsParts[1].P_Name := FPound.PoundName;
  ConstsParts[1].P_From3To9 := FPound.From3To9Pounds;
  ConstsParts[1].P_One := FPound.OnePound;
  ConstsParts[1].P_Onen := FPound.OnePound_tanwin;
  ConstsParts[1].P_Sex := FPound.Sex;
  ConstsParts[1].P_Two := FPound.TwoPounds;
  ConstsParts[1].P_Level := FPound.Level;
  FillParts;
end;

//procedure TTULIPNumSource.SetTwoFemaleCountryPound(const Value: String);
//var
//  i: SmallInt;
//begin
//  FTwoFemaleCountryPound := Value;
//  for i := 0 to 5 do
//    case Parts[i].Param.Sex of
//      s_Male:
//        Parts[i].TwoCountryPound := FTwoMaleCountryPound;
//      s_Female:
//        Parts[i].TwoCountryPound := FTwoFemaleCountryPound;
//    end;
//end;

//procedure TTULIPNumSource.SetTwoMaleCountryPound(const Value: String);
//var
//  i: SmallInt;
//begin
//  FTwoMaleCountryPound := Value;
//  for i := 0 to 5 do
//    case Parts[i].Param.Sex of
//      s_Male:
//        Parts[i].TwoCountryPound := FTwoMaleCountryPound;
//      s_Female:
//        Parts[i].TwoCountryPound := FTwoFemaleCountryPound;
//    end;
//end;

{ TParam }

procedure TParam.Assign(Source: TPersistent);
begin
  inherited Assign(Source);
end;

constructor TParam.Create;
begin
  inherited Create;
end;

destructor TParam.Destroy;
begin
  inherited Destroy;
end;

procedure TParam.GetDataFromParamRec(ParamRec: TParamRec);
begin
  PoundName := ParamRec.P_Name;
  OnePound := ParamRec.P_One;
  OnePound_tanwin := ParamRec.P_Onen;
  TwoPounds := ParamRec.P_Two;
  Sex := ParamRec.P_Sex;
  From3To9Pounds := ParamRec.P_From3To9;
  FLevel := ParamRec.P_Level;
end;

procedure TParam.SetFrom3To9Pounds(const Value: String);
begin
  FFrom3To9Pounds := Value;
  ConstsParts[Level].P_From3To9 := FFrom3To9Pounds;
end;

procedure TParam.SetOnePound_n(const Value: String);
begin
  FOnePound_n := Value;
  ConstsParts[Level].P_Onen := FOnePound_n;
end;

procedure TParam.SetOnePound(const Value: String);
begin
  FOnePound := Value;
  ConstsParts[Level].P_One := FOnePound;
end;

procedure TParam.SetPoundName(const Value: String);
begin
  FPoundName := Value;
  ConstsParts[Level].P_Name := FPoundName;
end;

procedure TParam.SetSex(const Value: TSex);
begin
  FSex := Value;
  ConstsParts[Level].P_Sex := FSex;
end;

procedure TParam.SetTwoPounds(const Value: String);
begin
  FTwoPounds := Value;
  ConstsParts[Level].P_Two := FTwoPounds;
end;

procedure TParts.SetThereIsMore(const Value: Boolean);
begin
  FThereIsMore := Value;
  if ThereIsMore then
    One_tanwin_Pound := Param.OnePound_tanwin
  else
    One_tanwin_Pound := Param.OnePound;
end;

procedure TParts.SetValues(ParamSex: TSex);
begin
  Case ParamSex of
    s_Male:
      begin
        MofradNums := MofradMaleNums;
        AloneTen := FemaleTen;
        NotAloneTen := MaleTen;
        OddWriteNums := OddMaleNums;
        OkadiNums := OkadiMaleNums;
      end;
    s_Female:
      begin
        MofradNums := MofradFemaleNums;
        AloneTen := MaleTen;
        NotAloneTen := FemaleTen;
        OddWriteNums := OddFemaleNums;
        OkadiNums := OkadiFemaleNums;
      end;
  end;
end;

end.
