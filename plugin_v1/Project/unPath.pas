unit unPath;

interface

uses
  Windows, SysUtils, Classes;

const
  // Результат обработки письма плагином
  ilrNone = 0;
  ilrSuccess = 1;
  ilrHaveErrors = 2;

  // Результат обработки файла плагином
  ifrNone = 0;
  ifrSuccess = 1;
  ifrFileCorrupted = 2;

  InDir = 'In';
  OutDir = 'Out';

  FormatIDVPT = '000';

  FileSignLength = 30;

  Class4PredmetCount = 2;
  Class9PredmetCount = 3;
  Class11PredmetCount = 4;
  MaxPredmetCount = 4;

  Class4PredmetQuestionCount = 15;
  Class9PredmetQuestionCount = 20;
  Class11PredmetQuestionCount = 20;
  MaxPredmetQuestionCount = 20;

  procedure Prepare;
  function GetAppPath: string;

  function GetLogFilePath: string;

  function GetInDirPath: string;
  function GetOutDirPath: string;

  procedure SaveToLogFile(const Value: string);

  procedure StrToArray(const strValue: string; var CharArray: array of Char);
  function ArrayToWideStr(const arChar: array of char): string;

  function GetPredmetCount(const AClassNo: Integer): Integer;
  function GetPredmetQuestionCount(const AClassNo: Integer): Integer;

  function GetOcen(const AClassNo, ABall: Integer): Integer;
  function GetItogOcen(const AClassNo, ABall: Integer): Integer;

implementation

uses
  IniFiles;

var
  FAppPath: string;
  FLogFilePath: string;

function GetAppPath: string;
begin
  Result := FAppPath;
end;

procedure Prepare;
var
  Buffer: array[0..MAX_PATH-1] of Char;
  Ini: TIniFile;
begin
  GetModuleFileName(HInstance, Buffer, MAX_PATH);
  FAppPath := ExtractFilePath(Buffer);

  Ini := TIniFile.Create(FAppPath + 'config.ini');
  try
    FLogFilePath := FAppPath + Ini.ReadString('Path', 'LogFile', 'Log.txt');
  finally
    FreeAndNil(Ini);
  end;
end;

function GetLogFilePath: string;
begin
  Result := FLogFilePath;
end;

procedure SaveToLogFile(const Value: string);
var
  f: TextFile;
  FilePath: string;
begin
  FilePath := GetLogFilePath;
  AssignFile(f, FilePath);
  if FileExists(FilePath) then
    Append(f)
  else
    Rewrite(f);

  WriteLn(f, FormatDateTime('yyy.mm.dd, HH:mm:ss', Now) + ': '+Value);
  CloseFile(f);
end;

function GetInDirPath: string;
begin
  Result := FAppPath + InDir + '\';
end;

function GetOutDirPath: string;
begin
  Result := FAppPath + OutDir + '\';
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
  FPassword = 'pR0вnOЕNe$t1RoVаnie';

var
  Index, ValueLen: Integer;
begin
  ValueLen:=Length(FPassword);
  for Index:=1 to ValueLen do
    Result:=Result+DEC2HEX(Ord(FPassWord[Index]));
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

end.
