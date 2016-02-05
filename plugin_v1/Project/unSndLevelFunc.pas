unit unSndLevelFunc;

interface

uses
  Windows, Classes, SysUtils, DB, Variants;

type
  TplMsgFile = record
    FileName: WideString;
    Stream: TMemoryStream;
    ImportResult: Byte;
  end;

  TplMsgInfo = record
    AccountName: WideString;
    FromEMail: WideString;
    ToEmail: WideString;
    Subject: WideString;
    DateCreate: TDateTime;

    ImportResult: Byte;

    FileCount: Integer;
    Files: array of TplMsgFile;
  end;

  TplAnswer = record
    AccountName: WideString;
    ToEmail: WideString;
    Subject: WideString;
    LetterText: WideString;
    FileCount: Integer;
    Files: array of TplMsgFile;
  end;

  PplAnswer = ^TplAnswer;

  function GetName: string; stdcall;
  function GetInfo: string; stdcall;

  function CheckMessage(var MsgInfo: TplMsgInfo;
    var DoSendAnswer: Boolean; var Answer: TplAnswer): Boolean; stdcall;

  procedure SaveToLogFile(const Value: string);

implementation

uses unPath, MD5, unDM, unDSUtils_FD, unPack, StrUtils;

function GetName: string; stdcall;
begin
  Result := 'Обработка файлов ответов ГАШ';
end;

function GetInfo: string; stdcall;
begin
  Result := 'Обработка файлов ответов ГАШ';
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

function CheckFile(const AFile: TplMsgFile; out AOutFileName: string;
  out AImportResult: string): Boolean;
const
  FileSignLength = 30;

  VariantLength = 4;

  sFamLength = 18;
  FamLength = 30;

  InitLength = 2;

  UchZavNameLength = 200;

  Class4BlankLength = 69;
  Class9BlankLength = 99;
  Class11BlankLength = 119;
  MaxBlankLength = 119;

  OutFileDir = 'Out';

  AnswerFileSign = 'ANSWERFILE_GASH_2015';
  OcenFileSign = 'OCENFILE_GASH_2015';

  AnswersFileName = 'Ans_GASH_';
  AnswersFileExt = '.ans';

  OcenFileName = 'Ocen_GASH_';
  OcenFileExt = '.ocn';

type
  // Файл для оценки
  TAnswersFileHeader = packed record
    FileSign: string[FileSignLength];
    IDVPT: Word;
    ARMSign: Integer;
    Num: Integer;
    CreateDateTime: TDateTime;
  end;

  TTest = packed record
    IDTest: Integer;
    ScanDate: Integer;
    IDTestType: Byte;
    GIDUchZav: Integer;
  end;

  TChangedUchZav = packed record
    GIDUchZav: Integer;
    UchZavKaz: array [0..UchZavNameLength-1] of Char;
    UchZavRus: array [0..UchZavNameLength-1] of Char;
  end;

  TListOtv = packed record
    ClassNo: Byte;
    IDListOtv: Integer;
    IDTest: Integer;
    LiterClass: Char;
    sFam: array[0..sFamLength-1] of Char;
    Fam: array[0..FamLength-1] of Char;
    sInit: array[0..InitLength-1] of Char;
    Init: array[0..InitLength-1] of Char;
    KPOIDSeason: Byte;
    sVariant: string[VariantLength];
    Variant: Word;
    IsEdit: Byte;
    EditResult: Byte;
    IsIden: Byte;
    Lang: Byte;
    IDPredmet: array[0..MaxPredmetCount-1] of Byte;
    sAnswers: array[0..MaxPredmetCount-1] of string[MaxPredmetQuestionCount];
    LOFileName: string[255];
    DateTimeScan: TDateTime;
    Blank: array [0..MaxBlankLength-1] of Char;
  end;

  // Файл с баллами
  TOcenFileHeader = packed record
    FileSign: string[FileSignLength];
    IDVPT: Word;
    ARMSign: Integer;
    Num: Integer;
    DateTimeCreate: TDateTime;
  end;

  // Файл с баллами
  TOcen = packed record
    ClassNo: Byte;
    IDListOtv: Integer;
    KPOIDSeason: Byte;
    Variant: Word;
    Ball: array[0..MaxPredmetCount-1] of Byte;
    ItogOcen: Byte;
    Ocen: array[0..MaxPredmetCount-1] of Byte;
    IsOcen: Byte;
  end;

var
  AnswersFileHeader: TAnswersFileHeader;

  arTest: array of TTest;
  arUchZav: array of TChangedUchZav;
  arListOtv: array of TListOtv;

  arOcen: array of TOcen;

  OcenFileHeader: TOcenFileHeader;
  LOCount, OcenRecCount, UchZavRecCount, TestRecCount: Word;
  Index, IDOcenFile, PredmetIndex, QuestionIndex, RandID, ParamIndex: Integer;
  iAnswers: array[0..MaxPredmetCount-1] of String;
  SumBall: Integer;

  Kods: AnsiString;
  HashFromFile: array[0..HashSize-1] of Byte;
  sHashFromFile: array[0..HashSize*2-1] of AnsiChar;
  ms: TMemoryStream;
  fs: TFileStream;
begin
  Result := False;
  AImportResult := '';

  if AFile.Stream.Size<=SizeOf(TAnswersFileHeader)+HashSize then
    Exit;

  try
    if AFile.Stream.Position>0 then
      AFile.Stream.Seek(0, soFromBeginning);
    AFile.Stream.ReadBuffer(AnswersFileHeader, SizeOf(TAnswersFileHeader));

    if AnswersFileHeader.FileSign<>AnswerFileSign then
      Exit;

    AFile.Stream.ReadBuffer(HashFromFile[0], HashSize);
    BinToHex(HashFromFile, sHashFromFile, HashSize);
    // Проверка - принимался ли этот файл ответов ранее
    // (случай когда файл отправляется на несколько оценивающих почтовых ящиков)
    FillDataSet(DM.fdQry,
      'select id_file, data_hash, result_file_name '+
      'from answer_files '+
      'where id_vpt=:id_vpt and arm_sign=:arm_sign and num=:num ',
      [AnswersFileHeader.IDVPT, AnswersFileHeader.ARMSign, AnswersFileHeader.Num]);

    IDOcenFile := 0;
    AOutFileName := '';

    try
      if (DM.fdQry.RecordCount>0)
        and (sHashFromFile = DM.fdQry.FieldByName('data_hash').AsAnsiString) then
      begin
        IDOcenFile := DM.fdQry.FieldByName('id_file').AsInteger;
        AOutFileName := DM.fdQry.FieldbyName('result_file_name').AsString;
        if FileExists(GetOutDirPath + AOutFileName) then
        begin
          Result := True;
          Exit;
        end;
      end
      else
        AOutFileName := OcenFileName + FormatDateTime('yyyy-mm-dd_HH-mm', Now) + '_' +
          FormatCurr(FormatIDVPT, AnswersFileHeader.IDVPT) + '_' +
          IntToStr(AnswersFileHeader.Num) + OcenFileExt;
    finally
      DM.fdQry.Close;
    end;


    ms := TMemoryStream.Create;
    try
      if IDOcenFile<>0 then
    {$REGION 'Выборка ранее оцененных результатов из БД'}
      begin
        // Результаты тестирования
        FillDataSet(DM.fdQry,
          'select class_no, id_listotv, kpo_id_season, variant, is_ocen, '+
          ' ball1, ball2, ball3, ball4, ocen1, ocen2, ocen3, ocen4, itog_ocen '+
          'from listotv '+
          'where id_file=:id_file', [IDOcenFile]);

        OcenRecCount := DM.fdQry.RecordCount;
        SetLength(arOcen, OcenRecCount);

        while not DM.fdQry.Eof do
        begin
          arOcen[DM.fdQry.RecNo-1].ClassNo := DM.fdQry.FieldByName('class_no').AsInteger;
          arOcen[DM.fdQry.RecNo-1].IDListOtv := DM.fdQry.FieldByName('id_listotv').AsInteger;
          arOcen[DM.fdQry.RecNo-1].KPOIDSeason := DM.fdQry.FieldByName('kpo_id_season').AsInteger;
          arOcen[DM.fdQry.RecNo-1].Variant := DM.fdQry.FieldByName('variant').AsInteger;
          arOcen[DM.fdQry.RecNo-1].ItogOcen := DM.fdQry.FieldByName('itog_ocen').AsInteger;
          arOcen[DM.fdQry.RecNo-1].IsOcen := DM.fdQry.FieldByName('is_ocen').AsInteger;
          for PredmetIndex := 1 to MaxPredmetCount do
          begin
            arOcen[DM.fdQry.RecNo-1].Ball[PredmetIndex-1] :=
              DM.fdQry.FieldByName('ball'+IntToStr(PredmetIndex)).AsInteger;
            arOcen[DM.fdQry.RecNo-1].Ocen[PredmetIndex-1] :=
              DM.fdQry.FieldByName('ocen'+IntToStr(PredmetIndex)).AsInteger;
          end;

          DM.fdQry.Next;
        end;
        DM.fdQry.Close;
        // Принятые изменения школ
        FillDataSet(DM.fdQry,
          'select gid_uchzav, uchzav_kaz, uchzav_rus '+
          'from uchzav '+
          'where id_file=:id_file', [IDOcenFile]);

        UchZavRecCount := DM.fdQry.RecordCount;
        if UchZavRecCount>0 then
        begin
          SetLength(arUchZav, UchZavRecCount);

          while not DM.fdQry.Eof do
          begin
            arUchZav[DM.fdQry.RecNo-1].GIDUchZav := DM.fdQry.FieldByName('gid_uchzav').AsInteger;
            StrToArray(DM.fdQry.FieldByName('uchzav_kaz').AsString, arUchZav[DM.fdQry.RecNo-1].UchZavKaz);
            StrToArray(DM.fdQry.FieldByName('uchzav_rus').AsString, arUchZav[DM.fdQry.RecNo-1].UchZavRus);

            DM.fdQry.Next;
          end;
        end;
        DM.fdQry.Close;

        // Принятые параметры тестирований
        FillDataSet(DM.fdQry,
          'select id_test, scan_date, id_testtype, gid_uchzav '+
          'from tests '+
          'where id_file=:id_file', [IDOcenFile]);

        TestRecCount := DM.fdQry.RecordCount;
        if TestRecCount>0 then
        begin
          SetLength(arTest, TestRecCount);

          while not DM.fdQry.Eof do
          begin
            arTest[DM.fdQry.RecNo-1].IDTest := DM.fdQry.FieldByName('id_test').AsInteger;
            arTest[DM.fdQry.RecNo-1].GIDUchZav := DM.fdQry.FieldByName('gid_uchzav').AsInteger;
            arTest[DM.fdQry.RecNo-1].ScanDate := DM.fdQry.FieldByName('scan_date').AsInteger;
            arTest[DM.fdQry.RecNo-1].IDTestType := DM.fdQry.FieldByName('id_testtype').AsInteger;

            DM.fdQry.Next;
          end;
        end;
        DM.fdQry.Close;
      end
    {$ENDREGION}
      else
    {$REGION 'Прием и оценка результатов'}
      begin
        AFile.Stream.Seek(0, soFromBeginning);

        if UnpackFile(AFile.Stream, @AnswersFileHeader, SizeOf(TAnswersFileHeader), ms)=RES_OK then
        begin
          if not FileExists(GetInDirPath + AFile.FileName) then
          begin
            if not DirectoryExists(GetInDirPath) then
              ForceDirectories(GetInDirPath);
            AFile.Stream.Seek(0, soFromBeginning);
            AFile.Stream.SaveToFile(GetInDirPath+AFile.FileName);
          end;

          if not DirectoryExists(GetOutDirPath) then
            ForceDirectories(GetOutDirPath);

          StartTransaction(DM.fdCon);
          try
            Randomize;
            RandID := Random(MaxInt);
            ExecuteSQL(DM.fdCon,
              'insert into answer_files(id_vpt, arm_sign, num, create_date_time, id_season, '+
                'import_date_time, answer_file_name, result_file_name, data_hash, rand_id) '+
              'values(:id_vpt, :arm_sign, :num, :create_date_time, :id_season, '+
                ':import_date_time, :answer_file_name, :result_file_name, :data_hash, :rand_id) ',
              [AnswersFileHeader.IDVPT, AnswersFileHeader.ARMSign, AnswersFileHeader.Num,
               AnswersFileHeader.CreateDateTime, IDSeason, Now, AFile.FileName, AOutFileName,
               AnsiString(sHashFromFile), RandID], False);

            IDOcenFile :=
              GetInt(DM.fdCon,
                'select id_file '+
                'from answer_files '+
                'where id_vpt=:id_vpt and arm_sign=:arm_sign and num=:num and rand_id=:rand_id',
                [AnswersFileHeader.IDVPT, AnswersFileHeader.ARMSign, AnswersFileHeader.Num, RandID]);

            ExecuteSQL(DM.fdCon, 'update answer_files set rand_id=0 where id_file=:id_file', [IDOcenFile], False);

            ms.Seek(0, soFromBeginning);
            ms.ReadBuffer(TestRecCount, SizeOf(TestRecCount));
            if TestRecCount>0 then
            begin
              SetLength(arTest, TestRecCount);
              ms.ReadBuffer(arTest[0], TestRecCount*SizeOf(TTest));

              if DM.fdQry.Active then
                DM.fdQry.Close;
              DM.fdQry.SQL.Text :=
                'insert into tests(id_file, id_test, scan_date, gid_uchzav, id_testtype) '+
                'values(:id_file, :id_test, :scan_date, :gid_uchzav, :id_testtype)';
              DM.fdQry.Params.ArraySize := 100;

              ParamIndex := 0;
              for Index := 0 to TestRecCount-1 do
              begin
                DM.fdQry.ParamByName('id_file').AsIntegers[ParamIndex] := IDOcenFile;
                DM.fdQry.ParamByName('id_test').AsIntegers[ParamIndex] := arTest[Index].IDTest;
                DM.fdQry.ParamByName('scan_date').AsIntegers[ParamIndex] := arTest[Index].ScanDate;
                DM.fdQry.ParamByName('gid_uchzav').AsIntegers[ParamIndex] := arTest[Index].GIDUchZav;
                DM.fdQry.ParamByName('id_testtype').AsIntegers[ParamIndex] := arTest[Index].IDTestType;

                inc(ParamIndex);

                if (ParamIndex = DM.fdQry.Params.ArraySize)
                  or (Index = TestRecCount-1) then
                begin
                  DM.fdQry.Execute(ParamIndex, 0);
                  ParamIndex := 0;
                end;
              end;
            end;

            ms.ReadBuffer(UchZavRecCount, SizeOf(UchZavRecCount));
            if UchZavRecCount>0 then
            begin
              SetLength(arUchZav, UchZavRecCount);
              ms.ReadBuffer(arUchZav[0], UchZavRecCount*SizeOf(TChangedUchZav));

              if DM.fdQry.Active then
                DM.fdQry.Close;
              DM.fdQry.SQL.Text :=
                'insert into uchzav(id_file, gid_uchzav, uchzav_kaz, uchzav_rus) '+
                'values(:id_file, :gid_uchzav, :uchzav_kaz, :uchzav_rus)';
              DM.fdQry.Params.ArraySize := 100;

              ParamIndex := 0;
              for Index := 0 to UchZavRecCount-1 do
              begin
                DM.fdQry.ParamByName('id_file').AsIntegers[ParamIndex] := IDOcenFile;
                DM.fdQry.ParamByName('gid_uchzav').AsIntegers[ParamIndex] := arUchZav[Index].GIDUchZav;
                DM.fdQry.ParamByName('uchzav_kaz').AsWideStrings[ParamIndex] := arUchZav[Index].UchZavKaz;
                DM.fdQry.ParamByName('uchzav_rus').AsWideStrings[ParamIndex] := arUchZav[Index].UchZavRus;

                inc(ParamIndex);

                if (ParamIndex = DM.fdQry.Params.ArraySize)
                  or (Index = UchZavRecCount-1) then
                begin
                  DM.fdQry.Execute(ParamIndex, 0);
                  ParamIndex := 0;
                end;
              end;
            end;

            ms.ReadBuffer(LOCount, SizeOf(LOCount));
            if LOCount>0 then
            begin
              SetLength(arListOtv, LOCount);
              SetLength(arOcen, LOCount);
              OcenRecCount := 0;

              ms.ReadBuffer(arListOtv[0], LOCount*SizeOf(TListOtv));

              if DM.fdQry.Active then
                DM.fdQry.Close;
              DM.fdQry.SQL.Text :=
                'insert into listotv(id_file, class_no, id_listotv, id_test, liter_class, '+
                ' s_fam, fam, s_init, init, kpo_id_season, s_variant, variant, '+
                ' id_predmet1, id_predmet2, id_predmet3, id_predmet4, '+
                ' i_answers1, i_answers2, i_answers3, i_answers4, '+
                ' s_answers1, s_answers2, s_answers3, s_answers4, '+
                ' is_edit, edit_result, is_iden, '+
                ' ball1, ball2, ball3, ball4, '+
                ' itog_ocen, ocen1, ocen2, ocen3, ocen4, '+
                ' is_ocen, date_time_scan, blank, lang, lo_file_name) '+
                'values(:id_file, :class_no, :id_listotv, :id_test, :liter_class, '+
                ' :s_fam, :fam, :s_init, :init, :kpo_id_season, :s_variant, :variant, '+
                ' :id_predmet1, :id_predmet2, :id_predmet3, :id_predmet4, '+
                ' :i_answers1, :i_answers2, :i_answers3, :i_answers4, '+
                ' :s_answers1, :s_answers2, :s_answers3, :s_answers4, '+
                ' :is_edit, :edit_result, :is_iden, '+
                ' :ball1, :ball2, :ball3, :ball4, '+
                ' :itog_ocen, :ocen1, :ocen2, :ocen3, :ocen4, '+
                ' :is_ocen, :date_time_scan, :blank, :lang, :lo_file_name)';

              DM.fdQry.Params.ArraySize := 100;

              ParamIndex := 0;
              for Index :=0 to LOCount-1 do
              begin
                if arListOtv[Index].ClassNo<>0 then
                begin
                  DM.fdQry.ParamByName('id_file').AsIntegers[ParamIndex] := IDOcenFile;
                  DM.fdQry.ParamByName('class_no').AsIntegers[ParamIndex] := arListOtv[Index].ClassNo;
                  DM.fdQry.ParamByName('id_listotv').AsIntegers[ParamIndex] := arListOtv[Index].IDListOtv;
                  DM.fdQry.ParamByName('id_test').AsIntegers[ParamIndex] := arListOtv[Index].IDTest;
                  DM.fdQry.ParamByName('liter_class').AsWideStrings[ParamIndex] := arListOtv[Index].LiterClass;
                  DM.fdQry.ParamByName('s_fam').AsWideStrings[ParamIndex] := ArrayToWideStr(arListOtv[Index].sFam);
                  DM.fdQry.ParamByName('fam').AsWideStrings[ParamIndex] := ArrayToWideStr(arListOtv[Index].Fam);
                  DM.fdQry.ParamByName('s_init').AsWideStrings[ParamIndex] := ArrayToWideStr(arListOtv[Index].sInit);
                  DM.fdQry.ParamByName('init').AsWideStrings[ParamIndex] := ArrayToWideStr(arListOtv[Index].Init);
                  DM.fdQry.ParamByName('kpo_id_season').AsIntegers[ParamIndex] := arListOtv[Index].KPOIDSeason;
                  DM.fdQry.ParamByName('s_variant').AsAnsiStrings[ParamIndex] := arListOtv[Index].sVariant;
                  DM.fdQry.ParamByName('Variant').AsIntegers[ParamIndex] := arListOtv[Index].Variant;

                  DM.fdQry.ParamByName('is_edit').AsIntegers[ParamIndex] := arListOtv[Index].IsEdit;
                  DM.fdQry.ParamByName('edit_result').AsIntegers[ParamIndex] := arListOtv[Index].EditResult;
                  DM.fdQry.ParamByName('is_iden').AsIntegers[ParamIndex] := arListOtv[Index].IsIden;

                  DM.fdQry.ParamByName('date_time_scan').AsDateTimes[ParamIndex] := arListOtv[Index].DateTimeScan;
                  DM.fdQry.ParamByName('blank').AsWideStrings[ParamIndex] := arListOtv[Index].Blank;
                  DM.fdQry.ParamByName('lang').AsIntegers[ParamIndex] := arListOtv[Index].Lang;
                  DM.fdQry.ParamByName('lo_file_name').AsAnsiStrings[ParamIndex] := arListOtv[Index].LOFileName;

                  arOcen[Index].ClassNo := arListOtv[Index].ClassNo;
                  arOcen[Index].IDListOtv := arListOtv[Index].IDListOtv;
                  arOcen[Index].KPOIDSeason := arListOtv[Index].KPOIDSeason;
                  arOcen[Index].Variant := arListOtv[Index].Variant;

                  SumBall := 0;
                  for PredmetIndex := 0 to MaxPredmetCount-1 do
                  begin
                    arOcen[Index].Ball[PredmetIndex] := 0;
                    arOcen[Index].Ocen[PredmetIndex] := 0;
                    iAnswers[PredmetIndex] := DupeString('0', GetPredmetQuestionCount(arListOtv[Index].ClassNo));

                    if (arListOtv[Index].IsIden=1)
                      and (arListOtv[Index].IDPredmet[PredmetIndex]>0) then
                    begin
                      if not DM.fdTblKPO.Locate('id_season;variant;id_predmet',
                        VarArrayOf([arListOtv[Index].KPOIDSeason, arListOtv[Index].Variant, arListOtv[Index].IDPredmet[PredmetIndex]]), []) then
                        raise Exception.Create('Нет КПО для варианта: '#13+
                          'Сезон: '+IntToStr(arListOtv[Index].KPOIDSeason)+', '#13+
                          'Вариант: '+IntToStr(arListOtv[Index].Variant)+', '#13+
                          '№ предмета: '+IntToStr(arListOtv[Index].IDPredmet[PredmetIndex]));

                      Kods := DM.fdTblKPO.FieldByName('Kods').AsAnsiString;
                      for QuestionIndex:=1 to GetPredmetQuestionCount(arListOtv[Index].ClassNo) do
                        if Kods[QuestionIndex] = arListOtv[Index].sAnswers[PredmetIndex][QuestionIndex] then
                        begin
                          inc(arOcen[Index].Ball[PredmetIndex]);
                          iAnswers[PredmetIndex][QuestionIndex] := '1';
                        end;
                      arOcen[Index].Ocen[PredmetIndex] := GetOcen(arListOtv[Index].ClassNo, arOcen[Index].Ball[PredmetIndex]);
                      SumBall := SumBall + arOcen[Index].Ball[PredmetIndex];
                    end;

                    DM.fdQry.ParamByName('id_predmet'+IntToStr(PredmetIndex+1)).AsIntegers[ParamIndex] :=
                      arListOtv[Index].IDPredmet[PredmetIndex];

                    DM.fdQry.ParamByName('s_answers'+IntToStr(PredmetIndex+1)).AsAnsiStrings[ParamIndex] :=
                      arListOtv[Index].sAnswers[PredmetIndex];

                    DM.fdQry.ParamByName('i_answers'+IntToStr(PredmetIndex+1)).AsStrings[ParamIndex] :=
                      iAnswers[PredmetIndex];

                    DM.fdQry.ParamByName('ball'+IntToStr(PredmetIndex+1)).AsIntegers[ParamIndex] :=
                      arOcen[Index].Ball[PredmetIndex];

                    DM.fdQry.ParamByName('ocen'+IntToStr(PredmetIndex+1)).AsIntegers[ParamIndex] :=
                      arOcen[Index].Ocen[PredmetIndex];
                  end;

                  if arListOtv[Index].IsIden=1 then
                  begin
                    arOcen[Index].ItogOcen := GetItogOcen(arListOtv[Index].ClassNo, SumBall);
                    arOcen[Index].IsOcen := 1;
                  end;
                  DM.fdQry.ParamByName('itog_ocen').AsIntegers[ParamIndex] := arOcen[Index].ItogOcen;
                  DM.fdQry.ParamByName('is_ocen').AsIntegers[ParamIndex] := arOcen[Index].IsOcen;

                  inc(ParamIndex);
                  inc(OcenRecCount);
                end;
                if (ParamIndex>0) and
                  ((ParamIndex = DM.fdQry.Params.ArraySize) or (Index = LOCount-1)) then
                begin
                  DM.fdQry.Execute(ParamIndex, 0);
                  ParamIndex := 0;
                end;
              end;
            end;

            CommitTransaction(DM.fdCon);

          except
            on E: Exception do
            begin
              RollbackTransaction(DM.fdCon);
              raise
            end;
          end;
        end
        else
        begin
          AImportResult := 'Ошибка при открытии файла.';
          Exit;
        end;
        ms.Clear;
      end;
    {$ENDREGION}

    {$REGION 'Формирование файла с результатами'}
      ms.WriteBuffer(TestRecCount, SizeOf(TestRecCount));
      if TestRecCount>0 then
        ms.WriteBuffer(arTest[0], TestRecCount*SizeOf(TTest));

      ms.WriteBuffer(UchZavRecCount, SizeOf(UchZavRecCount));
      if UchZavRecCount>0 then
        ms.WriteBuffer(arUchZav[0], UchZavRecCount*SizeOf(TChangedUchZav));

      ms.WriteBuffer(OcenRecCount, SizeOf(OcenRecCount));
      if OcenRecCount>0 then
        ms.WriteBuffer(arOcen[0], OcenRecCount*SizeOf(TOcen));

      ms.Seek(0, soFromBeginning);

      OcenFileHeader.FileSign := OcenFileSign;
      OcenFileHeader.IDVPT := AnswersFileHeader.IDVPT;
      OcenFileHeader.ARMSign := AnswersFileHeader.ARMSign;
      OcenFileHeader.Num := AnswersFileHeader.Num;
      OcenFileHeader.DateTimeCreate := Now;

      fs := TFileStream.Create(GetOutDirPath + AOutFileName, fmCreate);
      try
        Result := unPack.CreatePackFile(ms, @OcenFileHeader, SizeOf(OcenFileHeader), fs) = RES_OK;
      finally
        FreeAndNil(fs);
      end;
    {$ENDREGION}
    finally
      FreeAndNil(ms);

      arOcen := nil;

      arListOtv := nil;
      arUchZav := nil;
      arTest := nil;
    end;
  except
    on E: Exception do
    begin
      SaveToLogFile('Ошибка при обработке файла: '+e.Message);
      AImportResult := 'Ошибка при обработке файла';
    end;
  end;

end;

function CheckMessage(var MsgInfo: TplMsgInfo;
  var DoSendAnswer: Boolean; var Answer: TplAnswer): Boolean; stdcall;
var
  FileIndex, CorruptedFileCount: Integer;
  ImportResult, OutFileName, LetterText: string;
begin
  DoSendAnswer := False;

  CorruptedFileCount := 0;

  MsgInfo.ImportResult := ilrNone;
  Answer.FileCount := 0;
  Answer.Files := nil;

  LetterText := '';

  for FileIndex := 0 to MsgInfo.FileCount-1 do
    if CheckFile(MsgInfo.Files[FileIndex], OutFileName, ImportResult) then
    begin
      if ImportResult<>'' then
      begin
        MsgInfo.Files[FileIndex].ImportResult := ifrFileCorrupted;

        inc(CorruptedFileCount);
        LetterText :=
          '  '+ MsgInfo.Files[FileIndex].FileName+#13+
          '     '+ImportResult;
      end
      else
      begin
        MsgInfo.Files[FileIndex].ImportResult := ifrSuccess;

        inc(Answer.FileCount);
        SetLength(Answer.Files, Answer.FileCount);
        Answer.Files[Answer.FileCount-1].FileName := OutFileName;
        Answer.Files[Answer.FileCount-1].Stream := TMemoryStream.Create;
        Answer.Files[Answer.FileCount-1].Stream.LoadFromFile(GetOutDirPath + OutFileName);
        Answer.Files[Answer.FileCount-1].Stream.Seek(0, soFromBeginning);

        LetterText := '  ' + MsgInfo.Files[FileIndex].FileName + ' - Успешно принят';
      end;
    end
    else
      MsgInfo.Files[FileIndex].ImportResult := ifrNone;


  Result := (Answer.FileCount + CorruptedFileCount)>0;
  DoSendAnswer := Result;

  if Result then
  begin
    if CorruptedFileCount>0 then
    begin
      Answer.Subject := 'Ошибки файлах ответов ('+FormatDateTime('dd.mm.yyyy, hh:mm', Now)+')';
      Answer.LetterText :=
        'Здравствуйте. '#13#13+
        'От вас получено письмо "'+MsgInfo.Subject+'", '+
        'созданное '+FormatDateTime('dd.mm.yyyy, HH:MM', MsgInfo.DateCreate)+'.'#13#13+
        'Некоторые файлы ответов повреждены или содержат некорректные данные: '#13;

      Answer.LetterText := Answer.LetterText + LetterText;

      Answer.LetterText := Answer.LetterText +
        #13'Сформируйте указанные файлы повторно и отправьте.'#13#13+
        'Данное письмо создано автоматически.';

      MsgInfo.ImportResult := ilrHaveErrors;
    end
    else
    begin
      Answer.Subject := 'Файл оценки ГАШ ('+FormatDateTime('dd.mm.yyyy, hh:mm', Now)+')';
      Answer.LetterText :=
        'Здравствуйте. '#13#13+
        'Полученное от вас письмо "'+MsgInfo.Subject+'", '+
        'созданное '+FormatDateTime('dd.mm.yyyy, HH:MM', MsgInfo.DateCreate)+'.'#13+
        'с файлами ответов принято.'#13+
        'Файл(ы) с оценками сформирован(ы) и прикреплен(ы) к данному письму.'#13#13+
        'Данное письмо создано автоматически, отвечать на него не надо.';

      MsgInfo.ImportResult := ilrSuccess;
    end;
  end;
end;

end.
