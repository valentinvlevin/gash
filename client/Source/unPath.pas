unit unPath;

interface

uses
  Messages, Windows, Classes, Forms;

type
  TUpdateClassScanCount = procedure(const AAddValue: Integer) of object;
  TChangeProcessStatusCount = procedure(const ANewStatus: Integer) of object;
  TDoReloadTestParams = procedure of object;

const
  FileSignLength = 30;

  LOFileNameLength = 50;

  OutFileDir = 'Out';
  OldStatFileDir = 'Out\OldStatFiles';

  MainDir = '..';
  BinDir = 'Bin';

  DataFileName = 'Data.stg';

  BatchDir = BinDir + '\Batch';
  BatchFileName = 'GASH.frs ';

  ReportsDir = 'ReportTemplates';
  ImagesDir = BinDir + '\Images';

  KZ = 1;
  RU = 2;

  erNone = 0;
  erDoCorrect = 1;
  erDoDelete = 2;

  stScan = 0;
  stIden = 1;
  stResult = 2;

  FormatIDObl = '00';
  FormatIDRaion = '00';
  FormatIDUchZav = '000';
  FormatVariant = '0000';
  FormatIDVPT = '000';

  Class4PredmetCount = 2;
  Class9PredmetCount = 3;
  Class11PredmetCount = 4;
  MaxPredmetCount = 4;

  Class4PredmetQuestionCount = 15;
  Class9PredmetQuestionCount = 20;
  Class11PredmetQuestionCount = 20;

  MaxPredmetQuestionCount = 20;

  LiterClassCharCount = 38;
  LiterClassChars: array [0..LiterClassCharCount-1] of Char =
    ('А','Ә','Б','В','Г','Ғ','Д','Е','Ж','З','И','Й','К','Қ','Л','М',
     'Н','О','Ө','П','Р','С','Т','У','Ұ','Ү','Ф','Х','Һ','Ц','Ч','Ш',
     'Щ','Ы','І','Э','Ю','Я');

  UchZavNameLength = 200;

  // Путь к каталогу АРМ
  function GetAppPath: string;

  procedure LoadParamsFromDB;

  function GetIDSeason: Integer;
  function GetIDVPTInt: Integer;
  function GetIDVPTStr: String;
  function GetVPTName(const ALang: Integer = RU): String;

  function GetExcelColChar(const ColIndex: Integer): string;
  // Инициалы через точку
  function InitWithDots(const AInit: string): string;

  function GetDBPassword: AnsiString;

  function CreateGUIDStr: string;

  function GetPredmetCount(const AClassNo: Integer): Integer;
  function GetPredmetQuestionCount(const AClassNo: Integer): Integer;

  function GetOcen(const AClassNo, ABall: Integer): Integer;
  function GetItogOcen(const AClassNo, ABall: Integer): Integer;

  procedure StrToArray(const strValue: string; var CharArray: array of Char);
  function ArrayToWideStr(const arChar: array of char): string;
  function GetByLang(const ALang: Integer;
    const AKazText, ARusText: string): string;

implementation

uses
  SysUtils, StrUtils, unDM, unSQLiteDSUtils_FD, ActiveX;

var
  FAppPath: string;
  FVPTNameKaz, FVPTNameRus: string;
  FIDVPT, FIDSeason: Integer;

function GetAppPath: string;
begin
  Result := ExtractFilePath(Application.ExeName);
end;

procedure LoadParamsFromDB;
begin
  FIDSeason := GetInt(DM.udCon, 'select IDSeason from InfoSelf', []);
  FIDVPT := GetInt(DM.udCon, 'select IDVPT from InfoSelf', []);
  FVPTNameKaz := GetStr(DM.udCon, 'select VPTKaz from SpravVPT where IDVPT=:IDVPT', [FIDVPT]);
  FVPTNameRus := GetStr(DM.udCon, 'select VPTRus from SpravVPT where IDVPT=:IDVPT', [FIDVPT]);
end;

function GetIDVPTInt: Integer;
begin
  Result := FIDVPT;
end;

function GetIDSeason: Integer;
begin
  Result := FIDSeason;
end;

function GetIDVPTStr: String;
begin
  Result := FormatCurr(FormatIDVPT, FIDVPT);
end;

function GetVPTName(const ALang: Integer = RU): String;
begin
  if ALang=KZ then
    Result := FVPTNameKaz
  else
    Result := FVPTNameRus;
end;

function GetExcelColChar(const ColIndex: Integer): string;
const
  StartCharCode = ord(AnsiChar('A'));
var
  iTmp: Integer;
begin
  Result := '';
  iTmp := ColIndex;
  while iTmp>26 do
  begin
    Result := chr(StartCharCode + (iTmp mod 26)-1) + Result;
    iTmp := iTmp div 26;
  end;

  Result := Chr(StartCharCode + iTmp-1) + Result;
end;

function InitWithDots(const AInit: string): string;
begin
  Result := '';
  case Length(AInit) of
    1: Result := AInit+'.';
    2:
      begin
        if AInit[1]<>' '
          then Result:=AInit[1] + '.';
        if AInit[2]<>' '
          then Result := Result + AInit[2]+'.';
      end;
    else Result := '';
  end;
end;

function GetDBPassword: AnsiString;
  function DEC2HEX(DEC: LONGINT): AnsiString;
  const
    HEXDigitCount = 16;
    HEXDigts: array [0..HEXDigitCount-1] of AnsiChar =
      ('0','1','2','3','4','5','6','7','8','9','A','B','C','D','E','F');
  var
    HEX: AnsiString;
    I, J: LONGINT;
  begin
    if DEC = 0
      then HEX := '0'
    else
    begin
      HEX := '';
      I := 0;
      while (1 shl ((I + 1) * 4)) <= DEC do
        I := I + 1;
      for J := 0 to I do
      begin
        HEX := HEX + HEXDigts[(DEC shr ((I - J) * 4))];
        DEC := DEC and ((1 shl ((I - J) * 4)) - 1);
      end;
    end;
    DEC2HEX := HEX;
  end;

const
  FPassword: AnsiString = 'Gа$h_qAsН2o14_UFI';

var
  Index, ValueLen: Integer;
begin
  ValueLen:=Length(FPassword);
  for Index:=1 to ValueLen do
    Result:=Result+DEC2HEX(Ord(FPassWord[Index]));
end;

function CreateGUIDStr: string;
var
  ID: TGUID;
begin
  Result := '';
  if CoCreateGuid(ID) = S_OK then
    Result := GUIDToString(ID);
end;

function GetPredmetCount(const AClassNo: Integer): Integer;
begin
  Result := 0;
  case AClassNo of
    4: Result := Class4PredmetCount;
    9: Result := Class9PredmetCount;
    11: Result := Class11PredmetCount;
  end;
end;

function GetPredmetQuestionCount(const AClassNo: Integer): Integer;
begin
  Result := 0;
  case AClassNo of
    4: Result := Class4PredmetQuestionCount;
    9: Result := Class9PredmetQuestionCount;
    11: Result := Class11PredmetQuestionCount;
  end;
end;

function GetOcen(const AClassNo, ABall: Integer): Integer;
const
  Class4OcenCount = 3;
  Class4BallOcen: array [0..Class4OcenCount-1, 0..1] of Integer =
    ((8,3),(12,4),(14,5));

  Class9OcenCount = 3;
  Class9BallOcen: array [0..Class9OcenCount-1, 0..1] of Integer =
    ((10,3),(15,4),(18,5));
var
  Index: Integer;
begin
  Result := 2;
  case AClassNo of
    4:
      for Index := 0 to Class4OcenCount-1 do
        if ABall>=Class4BallOcen[Index, 0] then
          Result := Class4BallOcen[Index, 1]
        else
          Break;
    9,11:
      for Index := 0 to Class9OcenCount-1 do
        if ABall>=Class9BallOcen[Index, 0] then
          Result := Class9BallOcen[Index, 1]
        else
          Break;
  end;
end;

function GetItogOcen(const AClassNo, ABall: Integer): Integer;
const
  Class4OcenCount = 3;
  Class4BallOcen: array [0..Class4OcenCount-1, 0..1] of Integer =
    ((15,3),(23,4),(27,5));

  Class9OcenCount = 3;
  Class9BallOcen: array [0..Class9OcenCount-1, 0..1] of Integer =
    ((30,3),(45,4),(54,5));

  Class11OcenCount = 3;
  Class11BallOcen: array [0..Class9OcenCount-1, 0..1] of Integer =
    ((40,3),(60,4),(72,5));
var
  Index: Integer;
begin
  Result := 2;
  case AClassNo of
    4:
      for Index := 0 to Class4OcenCount-1 do
        if ABall>=Class4BallOcen[Index, 0] then
          Result := Class4BallOcen[Index, 1]
        else
          Break;
    9:
      for Index := 0 to Class9OcenCount-1 do
        if ABall>=Class9BallOcen[Index, 0] then
          Result := Class9BallOcen[Index, 1]
        else
          Break;
    11:
      for Index := 0 to Class11OcenCount-1 do
        if ABall>=Class11BallOcen[Index, 0] then
          Result := Class11BallOcen[Index, 1]
        else
          Break;
  end;
end;

procedure StrToArray(const strValue: string; var CharArray: array of Char);
var
  Index, strLen: Integer;
begin
  strLen := Length(strValue);
  for Index:=1 to strLen do
    CharArray[Index-1] := strValue[Index];
  CharArray[strLen]:=#0;
end;

function ArrayToWideStr(const arChar: array of char): string;
var
  CharIndex, Len: Integer;
begin
  Len := Length(arChar);
  CharIndex := 0;
  Result := '';
  while (CharIndex<Len) and (arChar[CharIndex]<>#0) do
  begin
    Result := Result + arChar[CharIndex];
    inc(CharIndex);
  end;
end;

function GetByLang(const ALang: Integer;
  const AKazText, ARusText: string): string;
begin
  if ALang=KZ then
    Result := AKazText
  else
    Result := ARusText;
end;

end.
