unit unfrmExportImport;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Mask, rxToolEdit, ExtCtrls, Buttons, unDM, DB, Types,
  uADStanIntf, uADStanOption, uADStanParam, uADStanError, uADDatSManager,
  uADPhysIntf, uADDAptIntf, uADStanAsync, uADDAptManager, uADCompDataSet,
  uADCompClient, unPath, InvokeRegistry, Rio, SOAPHTTPClient, SOAPHTTPTrans;

type
  TOcenFileHeader = packed record
    FileSign: string[FileSignLength];
    IDVPT: Word;
    ARMSign: Integer;
    Num: Integer;
    DateTimeCreate: TDateTime;
  end;

  TfrmExportImport = class(TForm)
    edFilePath: TFilenameEdit;
    pnlBottom: TPanel;
    pnlButtons: TPanel;
    btnImport: TBitBtn;
    btnClose: TBitBtn;
    lblFilePath: TLabel;
    gbFileParams: TGroupBox;
    lblVPT: TLabel;
    lblDateTimeCreate: TLabel;
    stVPT: TStaticText;
    stDateTimeCreate: TStaticText;
    fdQry: TADQuery;
    lblInfo: TLabel;
    stInfo: TStaticText;
    HTTPRIO: THTTPRIO;
    HTTPReqResp: THTTPReqResp;
    procedure btnImportClick(Sender: TObject);
    procedure edFilePathAfterDialog(Sender: TObject; var Name: string;
      var Action: Boolean);
  private
    FIsDataImported: Boolean;

    procedure Prepare;
    function CheckFile(const AStream: TStream;
      var AFileHeader: TOcenFileHeader; out ACheckResult: string): Boolean;
  public
    { Public declarations }
  end;

  function OnlineAnalyze: Integer;

  function CreateFileForAnalyze: Boolean;
  function ImportFileWithBall: Boolean;

implementation

uses unPack, unSQLiteDSUtils_FD, unGashOcenService, XSBuiltIns, unProxyParams;

function ImportFileWithBall: Boolean;
var
  f: TfrmExportImport;
begin
  Application.CreateForm(TfrmExportImport, f);
  try
    with f do
    begin
      Prepare;
      ShowModal;
      Result := FIsDataImported;
    end;
  finally
    FreeAndNil(f);
  end;
end;

{$R *.dfm}

const
  OcenFileSign = 'OCENFILE_GASH_2015_2';
  OcenFileName = 'Ocen_GASH_';
  OcenFileExt = '.ocn';

  VariantLength = 4;

  sFamLength = 18;
  FamLength = 30;

  InitLength = 2;

  Class4BlankLength = 69;
  Class9BlankLength = 99;
  Class11BlankLength = 119;
  MaxBlankLength = 119;

type
  TUchZav = packed record
    GIDUchZav: Integer;
    UchZavKaz: array [0..UchZavNameLength-1] of Char;
    UchZavRus: array [0..UchZavNameLength-1] of Char;
  end;

  TTest = packed record
    IDTest: Integer;
    ScanDate: Integer;
    IDTestType: Byte;
    GIDUchZav: Integer;
  end;

  // Файл с баллами
  TOcen = packed record
    ClassNo: Byte;
    IDListOtv: Integer;
    KPOIDSeason: Byte;
    Variant: Word;
    Ord: array[0..MaxPredmetCount-1] of Byte;
    Ball: array[0..MaxPredmetCount-1] of Byte;
    ItogOcen: Byte;
    Ocen: array[0..MaxPredmetCount-1] of Byte;
    IsOcen: Byte;
  end;

  // Файл для оценки
  TAnswersFileHeader = packed record
    FileSign: string[FileSignLength];
    IDVPT: Word;
    ARMSign: Integer;
    Num: Integer;
    CreateDateTime: TDateTime;
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
    Ord: array[0..MaxPredmetCount-1] of Byte;
    IDPredmet: array[0..MaxPredmetCount-1] of Byte;
    sAnswers: array[0..MaxPredmetCount-1] of string[MaxPredmetQuestionCount];
    LOFileName: string[255];
    DateTimeScan: TDateTime;
    Blank: array [0..MaxBlankLength-1] of Char;
  end;

var
  arTest: array of TTest;
  arUchZav: array of TUchZav;
  arListOtv: array of TListOtv;
  AnswersFileHeader: TAnswersFileHeader;

function DataForSendExists: Boolean;
begin
  Result :=
    GetInt(DM.udCon, 'select count(*) as cnt from Tests where DoSend=1', []) +
    GetInt(DM.udCon, 'select count(*) as cnt from SpravUchZav where DoSend=1', []) +
    GetInt(DM.udCon,
      'select count(lo.IDListOtv) as cnt '+
      'from ListOtv4 lo '+
      ' inner join Tests t on (t.IDTest=lo.IDTest) '+
      'where lo.DoSend=1 and t.Class4Status='+IntToStr(stResult)+' ', []) +
    GetInt(DM.udCon,
      'select count(lo.IDListOtv) as cnt '+
      'from ListOtv9 lo '+
      ' inner join Tests t on (t.IDTest=lo.IDTest) '+
      'where lo.DoSend=1 and t.Class9Status='+IntToStr(stResult)+' ', []) +
    GetInt(DM.udCon,
      'select count(lo.IDListOtv) as cnt '+
      'from ListOtv11 lo '+
      ' inner join Tests t on (t.IDTest=lo.IDTest) '+
      'where lo.DoSend=1 and t.Class11Status='+IntToStr(stResult)+' ', []) > 0;
end;

function LoadData: Boolean;
var
  DS: TDataSet;
  RecIndex, PredmetIndex, RecCount, RecCount4, RecCount9, RecCount11: Integer;
begin
  {$REGION Загрузка данных}
  if
    GetInt(DM.udCon, 'select count(*) as cnt from Tests where DoSend=1', []) +
    GetInt(DM.udCon, 'select count(*) as cnt from SpravUchZav where DoSend=1', []) +
    GetInt(DM.udCon,
      'select count(lo.IDListOtv) as cnt '+
      'from ListOtv4 lo '+
      ' inner join Tests t on (t.IDTest=lo.IDTest) '+
      'where lo.DoSend=1 and t.Class4Status='+IntToStr(stResult)+' ', []) +
    GetInt(DM.udCon,
      'select count(lo.IDListOtv) as cnt '+
      'from ListOtv9 lo '+
      ' inner join Tests t on (t.IDTest=lo.IDTest) '+
      'where lo.DoSend=1 and t.Class9Status='+IntToStr(stResult)+' ', []) +
    GetInt(DM.udCon,
      'select count(lo.IDListOtv) as cnt '+
      'from ListOtv11 lo '+
      ' inner join Tests t on (t.IDTest=lo.IDTest) '+
      'where lo.DoSend=1 and t.Class11Status='+IntToStr(stResult)+' ', []) = 0 then
  begin
    Result := False;
    Exit;
  end
  else
    Result := True;

  AnswersFileHeader.IDVPT := GetIDVPTInt;
  AnswersFileHeader.ARMSign := GetInt(DM.udCon, 'select ARMSign from InfoSelf', []);
  AnswersFileHeader.Num := GetInt(DM.udCon, 'select LastNumExpData + 1 from InfoSelf', []);
  AnswersFileHeader.CreateDateTime := Now;

  // Данные тестирований
  DS := GetDataSet(DM.udCon,
    'select IDTest, ScanDate, GIDUchZav, IDTestType '+
    'from Tests '+
    'where DoSend=1 '+
    'order by IDTest', []);
  try
    RecCount := DS.RecordCount;
    if RecCount>0 then
    begin
      SetLength(arTest, RecCount);
      while not DS.Eof do
      begin
        arTest[DS.RecNo-1].IDTest := DS.FieldByName('IDTest').AsInteger;
        arTest[DS.RecNo-1].ScanDate := DS.FieldByName('ScanDate').AsInteger;
        arTest[DS.RecNo-1].GIDUchZav := DS.FieldByName('GIDUchZav').AsInteger;
        arTest[DS.RecNo-1].IDTestType := DS.FieldByName('IDTestType').AsInteger;

        DS.Next;
      end;
    end;
  finally
    DS.Close;
    FreeAndNil(DS);
  end;

  // Школы с измененными наименованиями
  DS := GetDataSet(DM.udCon,
    'select GIDUchZav, UchZavKaz, UchZavRus '+
    'from SpravUchZav '+
    'where DoSend=1 '+
    'order by GIDUchZav', []);
  try
    RecCount := DS.RecordCount;
    if RecCount>0 then
    begin
      SetLength(arUchZav, RecCount);
      while not DS.Eof do
      begin
        arUchZav[DS.RecNo-1].GIDUchZav := DS.FieldByName('GIDUchZav').AsInteger;
        StrToArray(DS.FieldByName('UchZavKaz').AsString, arUchZav[DS.RecNo-1].UchZavKaz);
        StrToArray(DS.FieldByName('UchZavRus').AsString, arUchZav[DS.RecNo-1].UchZavRus);

        DS.Next;
      end;
    end;
  finally
    DS.Close;
    FreeAndNil(DS);
  end;

  RecCount4 :=
    GetInt(DM.udCon,
      'select count(lo.IDListOtv) as cnt '+
      'from ListOtv4 lo '+
      ' inner join Tests t on (t.IDTest=lo.IDTest) '+
      'where lo.DoSend=1 and t.Class4Status='+IntToStr(stResult)+' ', []);

  RecCount9 :=
    GetInt(DM.udCon,
      'select count(lo.IDListOtv) as cnt '+
      'from ListOtv9 lo '+
      ' inner join Tests t on (t.IDTest=lo.IDTest) '+
      'where lo.DoSend=1 and t.Class9Status='+IntToStr(stResult)+' ', []);

  RecCount11 :=
    GetInt(DM.udCon,
      'select count(lo.IDListOtv) as cnt '+
      'from ListOtv11 lo '+
      ' inner join Tests t on (t.IDTest=lo.IDTest) '+
      'where lo.DoSend=1 and t.Class11Status='+IntToStr(stResult)+' ', []);

  RecCount := RecCount4 + RecCount9 + RecCount11;

  if RecCount>0 then
  begin
    RecIndex := -1;
    SetLength(arListOtv, RecCount);
    // Данные листов ответов 4-го класса
    if RecCount4>0 then
    begin
      DS := GetDataSet(DM.udCon,
        'select lo.IDListOtv, lo.IDTest, lo.sFam, lo.Fam, lo.sInit, lo.Init, '+
        ' lo.KPOIDSeason, lo.sVariant, lo.Variant, lo.DateTimeScan, lo.LiterClass, '+
        ' lo.sAnswers1, lo.sAnswers2, lo.IDPredmet1, lo.IDPredmet2, lo.Ord1, lo.Ord2, '+
        ' lo.IsEdit, lo.EditResult, lo.IsIden, lo.Blank, lo.Lang, lo.LOFileName '+
        'from ListOtv4 lo '+
        ' inner join Tests t on (t.IDTest=lo.IDTest) '+
        'where lo.DoSend=1 and t.Class4Status='+IntToStr(stResult)+' '+
        'order by lo.IDListOtv', []);
      try
        while not DS.Eof do
        begin
          ZeroMemory(@arListOtv[DS.RecNo-1], SizeOf(TListOtv));
          arListOtv[DS.RecNo-1].ClassNo := 4;
          arListOtv[DS.RecNo-1].IDListOtv := DS.FieldByName('IDListOtv').AsInteger;
          arListOtv[DS.RecNo-1].IDTest := DS.FieldByName('IDTest').AsInteger;
          arListOtv[DS.RecNo-1].LiterClass := DS.FieldByName('LiterClass').AsString[1];
          StrToArray(DS.FieldByName('sFam').AsString, arListOtv[DS.RecNo-1].sFam);
          StrToArray(DS.FieldByName('Fam').AsString, arListOtv[DS.RecNo-1].Fam);
          StrToArray(DS.FieldByName('sInit').AsString, arListOtv[DS.RecNo-1].sInit);
          StrToArray(DS.FieldByName('Init').AsString, arListOtv[DS.RecNo-1].Init);
          arListOtv[DS.RecNo-1].KPOIDSeason := DS.FieldByName('KPOIDSeason').AsInteger;
          arListOtv[DS.RecNo-1].sVariant := DS.FieldByName('sVariant').AsAnsiString;
          arListOtv[DS.RecNo-1].Variant := DS.FieldByName('Variant').AsInteger;

          arListOtv[DS.RecNo-1].IsEdit := DS.FieldByName('IsEdit').AsInteger;
          arListOtv[DS.RecNo-1].EditResult := DS.FieldByName('EditResult').AsInteger;
          arListOtv[DS.RecNo-1].IsIden := DS.FieldByName('IsIden').AsInteger;
          arListOtv[DS.RecNo-1].Lang := DS.FieldByName('Lang').AsInteger;

          for PredmetIndex := 1 to Class4PredmetCount do
          begin
            arListOtv[DS.RecNo-1].Ord[PredmetIndex-1] :=
              DS.FieldByName('Ord'+IntToStr(PredmetIndex)).AsInteger;

            arListOtv[DS.RecNo-1].IDPredmet[PredmetIndex-1] :=
              DS.FieldByName('IDPredmet'+IntToStr(PredmetIndex)).AsInteger;

            arListOtv[DS.RecNo-1].sAnswers[PredmetIndex-1] :=
              DS.FieldByName('sAnswers'+DS.FieldByName('Ord'+IntToStr(PredmetIndex)).AsString).AsAnsiString;
          end;
          arListOtv[DS.RecNo-1].LOFileName:=DS.FieldByName('LOFileName').AsAnsiString;
          arListOtv[DS.RecNo-1].DateTimeScan:=DS.FieldByName('DateTimeScan').AsDateTime;
          StrToArray(DS.FieldByName('Blank').AsString, arListOtv[DS.RecNo-1].Blank);

          DS.Next;
        end;
        RecIndex := RecIndex + DS.RecordCount;
      finally
        DS.Close;
        FreeAndNil(DS);
      end;
    end;

    if RecCount9>0 then
    begin
      // Данные листов ответов 9-го класса
      DS := GetDataSet(DM.udCon,
        'select lo.IDListOtv, lo.IDTest, lo.sFam, lo.Fam, lo.sInit, lo.Init, '+
        ' lo.KPOIDSeason, lo.sVariant, lo.Variant, lo.DateTimeScan, lo.LiterClass, '+
        ' lo.IsEdit, lo.EditResult, lo.IsIden, lo.Blank, lo.Lang, lo.LOFileName, '+
        ' lo.sAnswers1, lo.sAnswers2, lo.sAnswers3, '+
        ' lo.Ord1, lo.Ord2, lo.Ord3, '+
        ' lo.IDPredmet1, lo.IDPredmet2, lo.IDPredmet3 '+
        'from ListOtv9 lo '+
        ' inner join Tests t on (t.IDTest=lo.IDTest) '+
        'where lo.DoSend=1 and t.Class9Status='+IntToStr(stResult)+' '+
        'order by lo.IDListOtv', []);
      try
        while not DS.Eof do
        begin
          ZeroMemory(@arListOtv[RecIndex + DS.RecNo], SizeOf(TListOtv));
          arListOtv[RecIndex + DS.RecNo].ClassNo := 9;
          arListOtv[RecIndex + DS.RecNo].IDListOtv := DS.FieldByName('IDListOtv').AsInteger;
          arListOtv[RecIndex + DS.RecNo].IDTest := DS.FieldByName('IDTest').AsInteger;
          arListOtv[RecIndex + DS.RecNo].LiterClass := DS.FieldByName('LiterClass').AsString[1];
          StrToArray(DS.FieldByName('sFam').AsString, arListOtv[RecIndex + DS.RecNo].sFam);
          StrToArray(DS.FieldByName('Fam').AsString, arListOtv[RecIndex + DS.RecNo].Fam);
          StrToArray(DS.FieldByName('sInit').AsString, arListOtv[RecIndex + DS.RecNo].sInit);
          StrToArray(DS.FieldByName('Init').AsString, arListOtv[RecIndex + DS.RecNo].Init);
          arListOtv[RecIndex + DS.RecNo].KPOIDSeason := DS.FieldByName('KPOIDSeason').AsInteger;
          arListOtv[RecIndex + DS.RecNo].sVariant := DS.FieldByName('sVariant').AsAnsiString;
          arListOtv[RecIndex + DS.RecNo].Variant := DS.FieldByName('Variant').AsInteger;

          arListOtv[RecIndex + DS.RecNo].IsEdit := DS.FieldByName('IsEdit').AsInteger;
          arListOtv[RecIndex + DS.RecNo].EditResult := DS.FieldByName('EditResult').AsInteger;
          arListOtv[RecIndex + DS.RecNo].IsIden := DS.FieldByName('IsIden').AsInteger;
          arListOtv[RecIndex + DS.RecNo].Lang := DS.FieldByName('Lang').AsInteger;

          for PredmetIndex := 1 to Class9PredmetCount do
          begin
            arListOtv[RecIndex + DS.RecNo].Ord[PredmetIndex-1] :=
              DS.FieldByName('Ord'+IntToStr(PredmetIndex)).AsInteger;
            arListOtv[RecIndex + DS.RecNo].IDPredmet[PredmetIndex-1] :=
              DS.FieldByName('IDPredmet'+IntToStr(PredmetIndex)).AsInteger;
            arListOtv[RecIndex + DS.RecNo].sAnswers[PredmetIndex-1] :=
              DS.FieldByName('sAnswers'+DS.FieldByName('Ord'+IntToStr(PredmetIndex)).AsString).AsAnsiString;
          end;
          arListOtv[RecIndex + DS.RecNo].LOFileName:=DS.FieldByName('LOFileName').AsAnsiString;
          arListOtv[RecIndex + DS.RecNo].DateTimeScan:=DS.FieldByName('DateTimeScan').AsDateTime;
          StrToArray(DS.FieldByName('Blank').AsString, arListOtv[RecIndex + DS.RecNo].Blank);

          DS.Next;
        end;

        RecIndex := RecIndex + DS.RecordCount;
      finally
        DS.Close;
        FreeAndNil(DS);
      end;
    end;

    if RecCount11>0 then
    begin
      // Данные листов ответов 11-го класса
      DS := GetDataSet(DM.udCon,
        'select lo.IDListOtv, lo.IDTest, lo.sFam, lo.Fam, lo.sInit, lo.Init, '+
        ' lo.KPOIDSeason, lo.sVariant, lo.Variant, lo.DateTimeScan, lo.LiterClass, '+
        ' lo.IsEdit, lo.EditResult, lo.IsIden, lo.Blank, lo.Lang, lo.LOFileName, '+
        ' lo.sAnswers1, lo.sAnswers2, lo.sAnswers3, lo.sAnswers4, '+
        ' lo.Ord1, lo.Ord2, lo.Ord3, lo.Ord4, '+
        ' lo.IDPredmet1, lo.IDPredmet2, lo.IDPredmet3, lo.IDPredmet4 '+
        'from ListOtv11 lo '+
        ' inner join Tests t on (t.IDTest=lo.IDTest) '+
        'where lo.DoSend=1 and t.Class11Status='+IntToStr(stResult)+' '+
        'order by lo.IDListOtv', []);
      try
        while not DS.Eof do
        begin
          ZeroMemory(@arListOtv[RecIndex + DS.RecNo], SizeOf(TListOtv));
          arListOtv[RecIndex + DS.RecNo].ClassNo := 11;
          arListOtv[RecIndex + DS.RecNo].IDListOtv := DS.FieldByName('IDListOtv').AsInteger;
          arListOtv[RecIndex + DS.RecNo].IDTest := DS.FieldByName('IDTest').AsInteger;
          arListOtv[RecIndex + DS.RecNo].LiterClass := DS.FieldByName('LiterClass').AsString[1];
          StrToArray(DS.FieldByName('sFam').AsString, arListOtv[RecIndex + DS.RecNo].sFam);
          StrToArray(DS.FieldByName('Fam').AsString, arListOtv[RecIndex + DS.RecNo].Fam);
          StrToArray(DS.FieldByName('sInit').AsString, arListOtv[RecIndex + DS.RecNo].sInit);
          StrToArray(DS.FieldByName('Init').AsString, arListOtv[RecIndex + DS.RecNo].Init);
          arListOtv[RecIndex + DS.RecNo].KPOIDSeason := DS.FieldByName('KPOIDSeason').AsInteger;
          arListOtv[RecIndex + DS.RecNo].sVariant := DS.FieldByName('sVariant').AsAnsiString;
          arListOtv[RecIndex + DS.RecNo].Variant := DS.FieldByName('Variant').AsInteger;

          arListOtv[RecIndex + DS.RecNo].IsEdit := DS.FieldByName('IsEdit').AsInteger;
          arListOtv[RecIndex + DS.RecNo].EditResult := DS.FieldByName('EditResult').AsInteger;
          arListOtv[RecIndex + DS.RecNo].IsIden := DS.FieldByName('IsIden').AsInteger;
          arListOtv[RecIndex + DS.RecNo].Lang := DS.FieldByName('Lang').AsInteger;

          for PredmetIndex := 1 to Class11PredmetCount do
          begin
            arListOtv[RecIndex + DS.RecNo].Ord[PredmetIndex-1] :=
              DS.FieldByName('Ord'+IntToStr(PredmetIndex)).AsInteger;
            arListOtv[RecIndex + DS.RecNo].IDPredmet[PredmetIndex-1] :=
              DS.FieldByName('IDPredmet'+IntToStr(PredmetIndex)).AsInteger;
            arListOtv[RecIndex + DS.RecNo].sAnswers[PredmetIndex-1] :=
              DS.FieldByName('sAnswers'+DS.FieldByName('Ord'+IntToStr(PredmetIndex)).AsString).AsAnsiString;
          end;
          arListOtv[RecIndex + DS.RecNo].LOFileName:=DS.FieldByName('LOFileName').AsAnsiString;
          arListOtv[RecIndex + DS.RecNo].DateTimeScan:=DS.FieldByName('DateTimeScan').AsDateTime;
          StrToArray(DS.FieldByName('Blank').AsString, arListOtv[RecIndex + DS.RecNo].Blank);

          DS.Next;
        end;
      finally
        DS.Close;
        FreeAndNil(DS);
      end;
    end;
  end;

  {$ENDREGION}
end;

function OnlineAnalyze: Integer;
var
  serv: GashOcenService;
  ansFile: dtAnswerFile;
  tests: Array_Of_dtTest;
  schools: Array_Of_dtSchool;
  ListOtvs: Array_Of_dtListOtv;

  lo_ords, lo_idPredmets: TByteDynArray;
  lo_Answers: Array_Of_string;

  AnalyzeResult: OcenResponse;

  PredmetIndex, ParamIndex, RecIndex, RecCount: Integer;

  ProxyHost: string;
  ProxyPort: Integer;

  f: TfrmExportImport;

  function FindAliveService: Boolean;
  var
    tmpDS: TDataSet;
  begin
    Result := False;
    tmpDS := GetDataSet(DM.udCon, 'select link from OcenServers order by id', []);
    try
      while not tmpDS.Eof do
      begin
        if ProxyHost<>'' then
          f.HTTPReqResp.Proxy := ProxyHost+':'+IntToStr(ProxyPort);
        f.httprio.Service := 'GashOcenService';
        f.httprio.Port := 'GashOcenPort';

        serv := GetGashOcenService(False, tmpDS.FieldByName('link').AsString, f.httprio);

        try
          if serv.isAlive then
          begin
            Result := True;
            Break;
          end;
        except

        end;

        tmpDS.Next;
      end;
    finally
      tmpDS.Close;
      FreeAndNil(tmpDS);
    end;
  end;

begin
  Result := 0;

  Application.CreateForm(TfrmExportImport, f);
  try
    if not DataForSendExists then
    begin
      Result := 1;
      Exit;
    end;

    GetProxyServerParams('http', ProxyHost, ProxyPort);
    if not FindAliveService then
      Exit;

    LoadData;

    ansFile := nil;
    try
      ansFile := dtAnswerFile.Create;
      ansFile.id_vpt := AnswersFileHeader.IDVPT;
      ansFile.arm_sign := AnswersFileHeader.ARMSign;
      ansFile.file_num := AnswersFileHeader.Num;
      ansFile.create_date_time := TXSDateTime.Create;
      ansFile.create_date_time.AsDateTime := AnswersFileHeader.CreateDateTime;

      RecCount := Length(arTest);
      SetLength(tests, RecCount);
      ansFile.tests := tests;
      tests := nil;
      for RecIndex := 0 to RecCount-1 do
      begin
        ansFile.tests[RecIndex] := dtTest.Create;
        ansFile.tests[RecIndex].id_test := arTest[RecIndex].IDTest;
        ansFile.tests[RecIndex].gid_uchzav := arTest[RecIndex].GIDUchZav;
        ansFile.tests[RecIndex].scan_date := arTest[RecIndex].ScanDate;
        ansFile.tests[RecIndex].id_test_type := arTest[RecIndex].IDTestType;
      end;

      RecCount := Length(arUchZav);
      SetLength(schools, RecCount);
      ansFile.schools := schools;
      schools := nil;
      for RecIndex := 0 to RecCount-1 do
      begin
        ansFile.schools[RecIndex] := dtSchool.Create;
        ansFile.schools[RecIndex].id := arUchZav[RecIndex].GIDUchZav;
        ansFile.schools[RecIndex].school_kaz := arUchZav[RecIndex].UchZavKaz;
        ansFile.schools[RecIndex].school_rus := arUchZav[RecIndex].UchZavRus;
      end;

      RecCount := Length(arListOtv);
      SetLength(ListOtvs, RecCount);
      ansFile.listotv := ListOtvs;
      ListOtvs := nil;
      for RecIndex := 0 to RecCount-1 do
      begin
        ansFile.listotv[RecIndex] := dtListOtv.Create;
        ansFile.listotv[RecIndex].class_no := arListOtv[RecIndex].ClassNo;
        ansFile.listotv[RecIndex].id_test := arListOtv[RecIndex].IDTest;
        ansFile.listotv[RecIndex].id_listotv := arListOtv[RecIndex].IDListOtv;
        ansFile.listotv[RecIndex].liter_class := arListOtv[RecIndex].LiterClass;
        ansFile.listotv[RecIndex].s_fam := arListOtv[RecIndex].sFam;
        ansFile.listotv[RecIndex].fam := arListOtv[RecIndex].Fam;
        ansFile.listotv[RecIndex].s_init := arListOtv[RecIndex].sInit;
        ansFile.listotv[RecIndex].init := arListOtv[RecIndex].Init;
        ansFile.listotv[RecIndex].kpo_id_season := arListOtv[RecIndex].KPOIDSeason;
        ansFile.listotv[RecIndex].s_variant := string(arListOtv[RecIndex].sVariant);
        ansFile.listotv[RecIndex].variant := arListOtv[RecIndex].Variant;

        SetLength(lo_idPredmets, MaxPredmetCount);
        SetLength(lo_ords, MaxPredmetCount);
        SetLength(lo_Answers, MaxPredmetCount);

        ansFile.listotv[RecIndex].id_predmets := lo_idPredmets;
        ansFile.listotv[RecIndex].ords := lo_ords;
        ansFile.listotv[RecIndex].answers := lo_Answers;

        lo_idPredmets := nil;
        lo_ords := nil;
        lo_Answers := nil;

        for PredmetIndex := 0 to MaxPredmetCount-1 do
        begin
          ansFile.listotv[RecIndex].id_predmets[PredmetIndex] := arListOtv[RecIndex].IDPredmet[PredmetIndex];
          ansFile.listotv[RecIndex].ords[PredmetIndex] := arListOtv[RecIndex].Ord[PredmetIndex];
          ansFile.listotv[RecIndex].answers[PredmetIndex] := string(arListOtv[RecIndex].sAnswers[PredmetIndex]);
        end;

        ansFile.listotv[RecIndex].is_iden := arListOtv[RecIndex].IsIden;
        ansFile.listotv[RecIndex].is_edit := arListOtv[RecIndex].IsEdit;
        ansFile.listotv[RecIndex].edit_result := arListOtv[RecIndex].EditResult;
        ansFile.listotv[RecIndex].lang := arListOtv[RecIndex].Lang;
        ansFile.listotv[RecIndex].blank := arListOtv[RecIndex].Blank;
        ansFile.listotv[RecIndex].lo_filename := string(arListOtv[RecIndex].LOFileName);
        ansFile.listotv[RecIndex].date_time_scan := TXSDateTime.Create;
        ansFile.listotv[RecIndex].date_time_scan.AsDateTime := arListOtv[RecIndex].DateTimeScan;
      end;

      AnalyzeResult := serv.DoAnalyze(ansFile);
      if (AnalyzeResult<>nil)
        and (AnalyzeResult.result_code = 0) then
      begin
        StartTransaction(DM.udCon);
        try
          ExecuteSQL(DM.udCon, 'update Tests set DoSend=0', [], [], False);
          ExecuteSQL(DM.udCon, 'update SpravUchZav set DoSend=0', [], [], False);

          f.fdQry.Params.ArraySize := 100;

          f.fdQry.SQL.Text := 'update ListOtv4 set DoSend=0 where IDListOtv=:IDListOtv';
          ParamIndex := 0;
          RecCount := Length(arListOtv);
          for RecIndex := 0 to RecCount-1 do
          begin
            if arListOtv[RecIndex].ClassNo = 4 then
            begin
              f.fdQry.ParamByName('IDListOtv').AsIntegers[ParamIndex] := arListOtv[RecIndex].IDListOtv;
              inc(ParamIndex);
            end;

            if (ParamIndex>0)
              and ((ParamIndex = f.fdQry.Params.ArraySize) or (RecIndex = RecCount-1)) then
            begin
              f.fdQry.Execute(ParamIndex, 0);
              ParamIndex := 0;
            end;
          end;

          f.fdQry.SQL.Text := 'update ListOtv9 set DoSend=0 where IDListOtv=:IDListOtv';
          ParamIndex := 0;
          RecCount := Length(arListOtv);
          for RecIndex := 0 to RecCount-1 do
          begin
            if arListOtv[RecIndex].ClassNo = 9 then
            begin
              f.fdQry.ParamByName('IDListOtv').AsIntegers[ParamIndex] := arListOtv[RecIndex].IDListOtv;
              inc(ParamIndex);
            end;

            if (ParamIndex>0)
              and ((ParamIndex = f.fdQry.Params.ArraySize) or (RecIndex = RecCount-1)) then
            begin
              f.fdQry.Execute(ParamIndex, 0);
              ParamIndex := 0;
            end;
          end;

          f.fdQry.SQL.Text := 'update ListOtv11 set DoSend=0 where IDListOtv=:IDListOtv';
          ParamIndex := 0;
          RecCount := Length(arListOtv);
          for RecIndex := 0 to RecCount-1 do
          begin
            if arListOtv[RecIndex].ClassNo = 11 then
            begin
              f.fdQry.ParamByName('IDListOtv').AsIntegers[ParamIndex] := arListOtv[RecIndex].IDListOtv;
              inc(ParamIndex);
            end;

            if (ParamIndex>0)
              and ((ParamIndex = f.fdQry.Params.ArraySize) or (RecIndex = RecCount-1)) then
            begin
              f.fdQry.Execute(ParamIndex, 0);
              ParamIndex := 0;
            end;
          end;

          ExecuteSQL(DM.udCon, 'update InfoSelf set LastNumExpData=LastNumExpData+1', [], [], False);

          RecCount := Length(AnalyzeResult.ocen_list);
          if RecCount>0 then
          begin
            // Загрузка данных 4-го класса
            f.fdQry.SQL.Text :=
              'update ListOtv4 '+
              'set '+
              ' ItogOcen=:ItogOcen, '+
              ' Ocen1=:Ocen1, Ocen2=:Ocen2, '+
              ' Ball1=:Ball1, Ball2=:Ball2, '+
              ' IsOcen=1 '+
              'where IDListOtv=:IDListOtv ';
            f.fdQry.Params.ArraySize := 100;
            ParamIndex := 0;

            for RecIndex := 0 to RecCount-1 do
            begin
              if AnalyzeResult.ocen_list[RecIndex].class_no = 4 then
              begin
                f.fdQry.ParamByName('ItogOcen').AsIntegers[ParamIndex] := AnalyzeResult.ocen_list[RecIndex].itog_ocen;
                f.fdQry.ParamByName('Ocen1').AsIntegers[ParamIndex] := AnalyzeResult.ocen_list[RecIndex].ocen[0];
                f.fdQry.ParamByName('Ocen2').AsIntegers[ParamIndex] := AnalyzeResult.ocen_list[RecIndex].ocen[1];

                f.fdQry.ParamByName('Ball1').AsIntegers[ParamIndex] := AnalyzeResult.ocen_list[RecIndex].balls[0];
                f.fdQry.ParamByName('Ball2').AsIntegers[ParamIndex] := AnalyzeResult.ocen_list[RecIndex].balls[1];

                f.fdQry.ParamByName('IDListOtv').AsIntegers[ParamIndex] := AnalyzeResult.ocen_list[RecIndex].id_listotv;

                inc(ParamIndex);
              end;

              if (ParamIndex>0)
                and ((ParamIndex = f.fdQry.Params.ArraySize) or (RecIndex = RecCount-1)) then
              begin
                f.fdQry.Execute(ParamIndex, 0);
                ParamIndex := 0;
              end;
            end;

            // Загрузка данных 9-го класса
            f.fdQry.SQL.Text :=
              'update ListOtv9 '+
              'set '+
              ' ItogOcen=:ItogOcen, '+
              ' Ocen1=:Ocen1, Ocen2=:Ocen2, Ocen3=:Ocen3, '+
              ' Ball1=:Ball1, Ball2=:Ball2, Ball3=:Ball3, '+
              ' IsOcen=1 '+
              'where IDListOtv=:IDListOtv ';
            f.fdQry.Params.ArraySize := 100;
            ParamIndex := 0;

            for RecIndex := 0 to RecCount-1 do
            begin
              if AnalyzeResult.ocen_list[RecIndex].class_no = 9 then
              begin
                f.fdQry.ParamByName('ItogOcen').AsIntegers[ParamIndex] := AnalyzeResult.ocen_list[RecIndex].itog_ocen;

                f.fdQry.ParamByName('Ocen1').AsIntegers[ParamIndex] := AnalyzeResult.ocen_list[RecIndex].ocen[0];
                f.fdQry.ParamByName('Ocen2').AsIntegers[ParamIndex] := AnalyzeResult.ocen_list[RecIndex].ocen[1];
                f.fdQry.ParamByName('Ocen3').AsIntegers[ParamIndex] := AnalyzeResult.ocen_list[RecIndex].ocen[2];

                f.fdQry.ParamByName('Ball1').AsIntegers[ParamIndex] := AnalyzeResult.ocen_list[RecIndex].balls[0];
                f.fdQry.ParamByName('Ball2').AsIntegers[ParamIndex] := AnalyzeResult.ocen_list[RecIndex].balls[1];
                f.fdQry.ParamByName('Ball3').AsIntegers[ParamIndex] := AnalyzeResult.ocen_list[RecIndex].balls[2];

                f.fdQry.ParamByName('IDListOtv').AsIntegers[ParamIndex] := AnalyzeResult.ocen_list[RecIndex].id_listotv;

                inc(ParamIndex);
              end;

              if (ParamIndex>0)
                and ((ParamIndex = f.fdQry.Params.ArraySize) or (RecIndex = RecCount-1)) then
              begin
                f.fdQry.Execute(ParamIndex, 0);
                ParamIndex := 0;
              end;
            end;

            // Загрузка данных 11-го класса
            f.fdQry.SQL.Text :=
              'update ListOtv11 '+
              'set '+
              ' ItogOcen=:ItogOcen, '+
              ' Ocen1=:Ocen1, Ocen2=:Ocen2, Ocen3=:Ocen3, Ocen4=:Ocen4, '+
              ' Ball1=:Ball1, Ball2=:Ball2, Ball3=:Ball3, Ball4=:Ball4, '+
              ' IsOcen=1 '+
              'where IDListOtv=:IDListOtv ';
            f.fdQry.Params.ArraySize := 100;
            ParamIndex := 0;

            for RecIndex := 0 to RecCount-1 do
            begin
              if AnalyzeResult.ocen_list[RecIndex].class_no = 11 then
              begin
                f.fdQry.ParamByName('ItogOcen').AsIntegers[ParamIndex] := AnalyzeResult.ocen_list[RecIndex].itog_ocen;
                f.fdQry.ParamByName('Ocen1').AsIntegers[ParamIndex] := AnalyzeResult.ocen_list[RecIndex].Ocen[0];
                f.fdQry.ParamByName('Ocen2').AsIntegers[ParamIndex] := AnalyzeResult.ocen_list[RecIndex].Ocen[1];
                f.fdQry.ParamByName('Ocen3').AsIntegers[ParamIndex] := AnalyzeResult.ocen_list[RecIndex].Ocen[2];
                f.fdQry.ParamByName('Ocen4').AsIntegers[ParamIndex] := AnalyzeResult.ocen_list[RecIndex].Ocen[3];

                f.fdQry.ParamByName('Ball1').AsIntegers[ParamIndex] := AnalyzeResult.ocen_list[RecIndex].balls[0];
                f.fdQry.ParamByName('Ball2').AsIntegers[ParamIndex] := AnalyzeResult.ocen_list[RecIndex].balls[1];
                f.fdQry.ParamByName('Ball3').AsIntegers[ParamIndex] := AnalyzeResult.ocen_list[RecIndex].balls[2];
                f.fdQry.ParamByName('Ball4').AsIntegers[ParamIndex] := AnalyzeResult.ocen_list[RecIndex].balls[3];

                f.fdQry.ParamByName('IDListOtv').AsIntegers[ParamIndex] := AnalyzeResult.ocen_list[RecIndex].id_listotv;

                inc(ParamIndex);
              end;

              if (ParamIndex>0)
                and ((ParamIndex = f.fdQry.Params.ArraySize) or (RecIndex = RecCount-1)) then
              begin
                f.fdQry.Execute(ParamIndex, 0);
                ParamIndex := 0;
              end;
            end;
          end;

          CommitTransaction(DM.udCon);
          Result := 2;
        except
          on e: Exception do
            RollbackTransaction(DM.udCon);
        end;
      end
    finally
      if Assigned(ansFile) then
      begin
        if Assigned(ansFile.tests) then
        begin
          RecCount := Length(ansFile.tests);
          for RecIndex := 0 to RecCount-1 do
            FreeAndNil(ansFile.tests[RecIndex]);
          ansFile.tests := nil;
        end;

        if Assigned(ansFile.schools) then
        begin
          RecCount := Length(ansFile.schools);
          for RecIndex := 0 to RecCount-1 do
            FreeAndNil(ansFile.schools[RecIndex]);
          ansFile.schools := nil;
        end;

        if Assigned(ansFile.listotv) then
        begin
          RecCount := Length(ansFile.listotv);
          for RecIndex := 0 to RecCount-1 do
          begin
            ansFile.listotv[RecIndex].date_time_scan.Free;
            ansFile.listotv[RecIndex].date_time_scan := nil;

            ansFile.listotv[RecIndex].id_predmets := nil;
            ansFile.listotv[RecIndex].ords := nil;
            ansFile.listotv[RecIndex].answers := nil;

            FreeAndNil(ansFile.listotv[RecIndex]);
          end;
          ansFile.listotv := nil;
        end;

        ansFile.create_date_time.Free;
        ansFile.create_date_time := nil;
        FreeAndNil(ansFile);
      end;
    end;
  finally
    arTest := nil;
    arUchZav := nil;
    arListOtv := nil;

    serv := nil;

    FreeAndNil(f);
  end;
end;

function CreateFileForAnalyze: Boolean;
const
  AnswerFileSign = 'ANSWERFILE_GASH_2015_2';
  AnswersFileName = 'Ans_GASH_';
  AnswersFileExt = '.ans';

  procedure DeletePrevStatFile(const Num: Integer);
  var
    sr: TSearchRec;
  begin
    if FindFirst(GetAppPath + OutFileDir+'\'+AnswersFileName+'*'+GetIDVPTStr + '_' +
        IntToStr(Num)+AnswersFileExt, faAnyFile, sr)=0 then
    begin
      if not DirectoryExists(GetAppPath + OldStatFileDir) then
        ForceDirectories(GetAppPath + OldStatFileDir);

      if not FileExists(GetAppPath + OldStatFileDir+'\'+sr.Name)
        or DeleteFile(GetAppPath + OldStatFileDir+'\'+sr.Name) then
        CopyFile(PChar(GetAppPath + OutFileDir+'\'+sr.Name), PChar(GetAppPath + OldStatFileDir+'\'+sr.Name), False);
      DeleteFile(GetAppPath + OutFileDir+'\'+sr.Name);

      FindClose(sr);
    end;
  end;

var
  OutFileName, OutFilePath: string;

  ms: TMemoryStream;
  fs: TFileStream;
  RecCount: Word;
begin
  Result := False;

  try
    if not LoadData then
    begin
      Application.MessageBox('Нет данных для отправки', 'Внимание',
        MB_TASKMODAL or MB_ICONASTERISK);
      Exit;
    end;

    AnswersFileHeader.FileSign := AnswerFileSign;
    OutFilePath:=GetAppPath + OutFileDir + '\';

    DeletePrevStatFile(GetInt(DM.udCon, 'select LastNumExpData from InfoSelf', []));

    OutFileName := AnswersFileName + FormatDateTime('yyyy-mm-dd_HH-mm', Now) + '_' +
      GetIDVPTStr + '_' + IntToStr(GetInt(DM.udCon, 'select LastNumExpData + 1 from InfoSelf', []))+
      AnswersFileExt;

    if FileExists(OutFilePath+OutFileName)
      and not DeleteFile(OutFilePath+OutFileName) then
    begin
      Application.MessageBox('Не получилось удалить ранее созданный файл.'#13+
        'Перезапустите программу и повторите попытку.', 'Внимание',
        MB_TASKMODAL or MB_ICONWARNING);
      Exit;
    end;

    ms:=TMemoryStream.Create;
    fs:=nil;
    try
      try
        RecCount := Length(arTest);
        ms.WriteBuffer(RecCount, SizeOf(RecCount));
        if RecCount>0 then
          ms.WriteBuffer(arTest[0], SizeOf(TTest)*RecCount);

        RecCount := Length(arUchZav);
        ms.WriteBuffer(RecCount, SizeOf(RecCount));
        if RecCount>0 then
          ms.WriteBuffer(arUchZav[0], SizeOf(TUchZav)*RecCount);

        RecCount := Length(arListOtv);
        ms.WriteBuffer(RecCount, SizeOf(RecCount));
        if RecCount>0 then
          ms.WriteBuffer(arListOtv[0], SizeOf(TListOtv)*RecCount);

        if not DirectoryExists(OutFilePath) then
          ForceDirectories(OutFilePath);

        // Формирование файла
        fs:=TFileStream.Create(OutFilePath+OutFileName, fmCreate);
        ms.Seek(0, soFromBeginning);
        CreatePackFile(ms, @AnswersFileHeader, SizeOf(AnswersFileHeader), fs);

        FreeAndNil(ms);
        FreeAndNil(fs);

        ExecuteSQL(DM.udCon, 'update InfoSelf set LastNumExpData=LastNumExpData+1', [], []);

        Result := True;

        Application.MessageBox(PChar('Формирование файла завершено.'#13+
          'Файл называется '+OutFileName+'.'#13+
          'Файл располагается в папке '+OutFilePath+'.'#13),
          'Внимание', MB_ICONASTERISK or MB_TASKMODAL);

        try
          WinExec(PAnsiChar('explorer.exe /e,/select,"'+AnsiString(OutFilePath+OutFileName)+'"'),
            SW_SHOWNORMAL);
        except

        end;
      except
        Application.MessageBox('При формировании файла произошла ошибка', 'Ошибка',
          MB_TASKMODAL or MB_ICONWARNING);
      end;
    finally
      if Assigned(fs) then
        FreeAndNil(fs);
      if Assigned(ms) then
        FreeAndNil(ms);
    end;
  finally
    arTest := nil;
    arUchZav := nil;
    arListOtv := nil;
  end;
end;

procedure TfrmExportImport.btnImportClick(Sender: TObject);
var
  FileHeader: TOcenFileHeader;

  arImportedTest: array of TTest;
  arImportedUchZav: array of TUchZav;

  arOcen: array of TOcen;

  fs: TFileStream;
  ms: TMemoryStream;
  RecCount: Word;
  PredmetIndex, Index, ParamIndex: Integer;
  CheckFileResult: string;
begin
  if not FileExists(edFilePath.FileName) then
  begin
    Application.MessageBox('Файл не найден', 'Ошибка',
      MB_TASKMODAL or MB_ICONWARNING);
    Exit;
  end;

  ms := nil;
  fs := TFileStream.Create(edFilePath.FileName, fmOpenRead);
  try
    if not CheckFile(fs, FileHeader, CheckFileResult) then
    begin
      Application.MessageBox(PChar(CheckFileResult), 'Ошибка',
        MB_TASKMODAL or MB_ICONWARNING);
      Exit;
    end;

    if fs.Position>0 then
      fs.Seek(0, soFromBeginning);
    ms := TMemoryStream.Create;
    if UnpackFile(fs, @FileHeader, SizeOf(FileHeader), ms)<>RES_OK then
    begin
      Application.MessageBox('Файл результатов поврежден. Сохраните файл из письма на диск повторно.'#13+
        'Если не поможет, то повторно сформируйте файл ответов и вышлите для оценки.',
        'Внимание', MB_TASKMODAL or MB_ICONWARNING);
      Exit;
    end;

    ms.Seek(0, soFromBeginning);

    StartTransaction(DM.udCon);
    try
      // Данные тестирований
      ms.ReadBuffer(RecCount, SizeOf(RecCount));
      if RecCount>0 then
      begin
        SetLength(arImportedTest, RecCount);
        try
          ms.ReadBuffer(arImportedTest[0], RecCount*SizeOf(TTest));
          for Index := 0 to RecCount-1 do
            ExecuteSQL(DM.udCon,
              'update Tests '+
              'set DoSend=0 '+
              'where IDTest=:IDTest and GIDUchZav=:GIDUchZav and IDTestType=:IDTestType and ScanDate=:ScanDate ',
               [ftInteger, ftInteger, ftSmallInt, ftInteger],
               [arImportedTest[Index].IDTest, arImportedTest[Index].GIDUchZav,
                arImportedTest[Index].IDTestType, arImportedTest[Index].ScanDate], False);
        finally
          arImportedTest := nil;
        end;
      end;

      // Данные школ
      ms.ReadBuffer(RecCount, SizeOf(RecCount));
      if RecCount>0 then
      begin
        SetLength(arImportedUchZav, RecCount);
        try
          ms.ReadBuffer(arImportedUchZav[0], RecCount*SizeOf(TUchZav));
          for Index := 0 to RecCount-1 do
            ExecuteSQL(DM.udCon,
              'update SpravUchZav '+
              'set DoSend=0 '+
              'where GIDUchZav=:GIDUchZav and UchZavKaz=:UchZavKaz and UchZavRus=:UchZavRus ',
               [ftInteger, ftWideString, ftWideString],
               [arImportedUchZav[Index].GIDUchZav, ArrayToWideStr(arImportedUchZav[Index].UchZavKaz),
                ArrayToWideStr(arImportedUchZav[Index].UchZavRus)], False);
        finally
          arImporteduchZav := nil;
        end;
      end;

      ms.ReadBuffer(RecCount, SizeOf(RecCount));
      if RecCount>0 then
      begin
        SetLength(arOcen, RecCount);
        try
          ms.ReadBuffer(arOcen[0], RecCount*SizeOf(TOcen));

          // Загрузка данных 4-го класса
          fdQry.SQL.Text :=
            'update ListOtv4 '+
            'set '+
            ' ItogOcen=:ItogOcen, '+
            ' Ocen1=:Ocen1, Ocen2=:Ocen2, '+
            ' Ball1=:Ball1, Ball2=:Ball2, '+
            ' IsOcen=:IsOcen, DoSend=0 '+
            'where IDListOtv=:IDListOtv and KPOIDSeason=:KPOIDSeason '+
            ' and Variant=:Variant and Ord1=:Ord1 and Ord2=:Ord2 ';

          fdQry.Params.ArraySize := 100;
          ParamIndex := 0;

          for Index := 0 to RecCount-1 do
          begin
            if arOcen[Index].ClassNo = 4 then
            begin
              for PredmetIndex := 1 to Class4PredmetCount do
              begin
                fdQry.ParamByName('Ocen'+IntToStr(PredmetIndex)).AsIntegers[ParamIndex] := arOcen[Index].Ocen[PredmetIndex-1];
                fdQry.ParamByName('Ball'+IntToStr(PredmetIndex)).AsIntegers[ParamIndex] := arOcen[Index].Ball[PredmetIndex-1];
                fdQry.ParamByName('Ord'+IntToStr(PredmetIndex)).AsIntegers[ParamIndex] := arOcen[Index].Ord[PredmetIndex-1];
              end;

              fdQry.ParamByName('ItogOcen').AsIntegers[ParamIndex] := arOcen[Index].ItogOcen;
              fdQry.ParamByName('IsOcen').AsIntegers[ParamIndex] := arOcen[Index].IsOcen;

              fdQry.ParamByName('IDListOtv').AsIntegers[ParamIndex] := arOcen[Index].IDListOtv;
              fdQry.ParamByName('KPOIDSeason').AsIntegers[ParamIndex] := arOcen[Index].KPOIDSeason;
              fdQry.ParamByName('Variant').AsIntegers[ParamIndex] := arOcen[Index].Variant;

              inc(ParamIndex);
            end;

            if (ParamIndex>0)
              and ((ParamIndex = fdQry.Params.ArraySize) or (Index = RecCount-1)) then
            begin
              fdQry.Execute(ParamIndex, 0);
              ParamIndex := 0;
            end;
          end;

          // Загрузка данных 9-го класса
          fdQry.SQL.Text :=
            'update ListOtv9 '+
            'set '+
            ' ItogOcen=:ItogOcen, '+
            ' Ocen1=:Ocen1, Ocen2=:Ocen2, Ocen3=:Ocen3, '+
            ' Ball1=:Ball1, Ball2=:Ball2, Ball3=:Ball3, '+
            ' IsOcen=:IsOcen, DoSend=0 '+
            'where IDListOtv=:IDListOtv and KPOIDSeason=:KPOIDSeason '+
            ' and Variant=:Variant and Ord1=:Ord1 and Ord2=:Ord2 and Ord3=:Ord3 ';
          fdQry.Params.ArraySize := 100;
          ParamIndex := 0;

          for Index := 0 to RecCount-1 do
          begin
            if arOcen[Index].ClassNo = 9 then
            begin
              fdQry.ParamByName('ItogOcen').AsIntegers[ParamIndex] := arOcen[Index].ItogOcen;

              for PredmetIndex := 1 to Class9PredmetCount do
              begin
                fdQry.ParamByName('Ocen'+IntToStr(PredmetIndex)).AsIntegers[ParamIndex] := arOcen[Index].Ocen[PredmetIndex-1];
                fdQry.ParamByName('Ball'+IntToStr(PredmetIndex)).AsIntegers[ParamIndex] := arOcen[Index].Ball[PredmetIndex-1];
                fdQry.ParamByName('Ord'+IntToStr(PredmetIndex)).AsIntegers[ParamIndex] := arOcen[Index].Ord[PredmetIndex-1];
              end;

              fdQry.ParamByName('IsOcen').AsIntegers[ParamIndex] := arOcen[Index].IsOcen;

              fdQry.ParamByName('IDListOtv').AsIntegers[ParamIndex] := arOcen[Index].IDListOtv;
              fdQry.ParamByName('KPOIDSeason').AsIntegers[ParamIndex] := arOcen[Index].KPOIDSeason;
              fdQry.ParamByName('Variant').AsIntegers[ParamIndex] := arOcen[Index].Variant;

              inc(ParamIndex);
            end;

            if (ParamIndex>0)
              and ((ParamIndex = fdQry.Params.ArraySize) or (Index = RecCount-1)) then
            begin
              fdQry.Execute(ParamIndex, 0);
              ParamIndex := 0;
            end;
          end;

          // Загрузка данных 11-го класса
          fdQry.SQL.Text :=
            'update ListOtv11 '+
            'set '+
            ' ItogOcen=:ItogOcen, '+
            ' Ocen1=:Ocen1, Ocen2=:Ocen2, Ocen3=:Ocen3, Ocen4=:Ocen4, '+
            ' Ball1=:Ball1, Ball2=:Ball2, Ball3=:Ball3, Ball4=:Ball4, '+
            ' IsOcen=:IsOcen, DoSend=0 '+
            'where IDListOtv=:IDListOtv and KPOIDSeason=:KPOIDSeason and Variant=:Variant '+
            ' and Ord1=:Ord1 and Ord2=:Ord2 and Ord3=:Ord3 and Ord4=:Ord4 ';
          fdQry.Params.ArraySize := 100;
          ParamIndex := 0;

          for Index := 0 to RecCount-1 do
          begin
            if arOcen[Index].ClassNo = 11 then
            begin
              fdQry.ParamByName('ItogOcen').AsIntegers[ParamIndex] := arOcen[Index].ItogOcen;

              for PredmetIndex := 1 to Class11PredmetCount do
              begin
                fdQry.ParamByName('Ocen'+IntToStr(PredmetIndex)).AsIntegers[ParamIndex] := arOcen[Index].Ocen[PredmetIndex-1];
                fdQry.ParamByName('Ball'+IntToStr(PredmetIndex)).AsIntegers[ParamIndex] := arOcen[Index].Ball[PredmetIndex-1];
                fdQry.ParamByName('Ord'+IntToStr(PredmetIndex)).AsIntegers[ParamIndex] := arOcen[Index].Ord[PredmetIndex-1];
              end;

              fdQry.ParamByName('IsOcen').AsIntegers[ParamIndex] := arOcen[Index].IsOcen;

              fdQry.ParamByName('IDListOtv').AsIntegers[ParamIndex] := arOcen[Index].IDListOtv;
              fdQry.ParamByName('KPOIDSeason').AsIntegers[ParamIndex] := arOcen[Index].KPOIDSeason;
              fdQry.ParamByName('Variant').AsIntegers[ParamIndex] := arOcen[Index].Variant;

              inc(ParamIndex);
            end;

            if (ParamIndex>0)
              and ((ParamIndex = fdQry.Params.ArraySize) or (Index = RecCount-1)) then
            begin
              fdQry.Execute(ParamIndex, 0);
              ParamIndex := 0;
            end;
          end;
        finally
          arOcen := nil;
        end;
      end;

      CommitTransaction(DM.udCon);
    except
      on E: Exception do
      begin
        RollbackTransaction(DM.udCon);
        Application.MessageBox(PChar('Ошибка при приеме файла оценки: '#13+E.Message),
          'Внимание', MB_TASKMODAL or MB_ICONWARNING);
        Exit;
      end;
    end;
  finally
    FreeAndNil(fs);
    if Assigned(ms) then
      FreeAndNil(ms);
  end;

  FIsDataImported := True;
  Application.MessageBox('Прием файла завершен', 'Внимание',
    MB_TASKMODAL or MB_ICONASTERISK);
end;

function TfrmExportImport.CheckFile(const AStream: TStream;
  var AFileHeader: TOcenFileHeader; out ACheckResult: string): Boolean;
begin
  Result := False;

  ACheckResult := '';
  try
    if AStream.Size<SizeOf(AFileHeader) then
    begin
      ACheckResult := 'Файл поврежден или это не файл результатов';
      Exit;
    end;

    AStream.ReadBuffer(AFileHeader, SizeOf(AFileHeader));
    if AFileHeader.FileSign<>OcenFileSign then
    begin
      ACheckResult := 'Выбранный файл не является файлом результатов';
      Exit;
    end;

    stVPT.Caption := FormatCurr(FormatIDVPT, AFileHeader.IDVPT) + ' - '+
      GetStr(DM.udCon,
        'select VPTRus '+
        'from SpravVPT '+
        'where IDVPT=:IDVPT', [AFileHeader.IDVPT]);
    stDateTimeCreate.Caption := FormatDateTime('dd.mm.yyyy, hh:mm',
      AFileHeader.DateTimeCreate);

    FillDataSet(fdQry, 'select IDVPT, ARMSign, LastNumExpData from InfoSelf', []);
    try
      if AFileHeader.IDVPT<>fdQry.FieldByName('IDVPT').AsInteger then
      begin
        ACheckResult := 'Файл предназначен для другого АРМ ('+
          FormatCurr(FormatIDVPT, AFileHeader.IDVPT)+')';
        Exit;
      end;

      if AFileHeader.ARMSign<>fdQry.FieldByName('ARMSign').AsInteger then
      begin
        ACheckResult := 'Данный файл от другой версии вашего АРМ';
        Exit;
      end;
    finally
      fdQry.Close;
    end;
    Result := True;
  finally
    if ACheckResult<>'' then
      stInfo.Caption := ACheckResult;

    if Result then
      stInfo.Font.Color := clGreen
    else
      stInfo.Font.Color := clRed;
  end;
end;

procedure TfrmExportImport.edFilePathAfterDialog(Sender: TObject;
  var Name: string; var Action: Boolean);
var
  FileHeader: TOcenFileHeader;
  fs: TFileStream;
  sTmp: string;
begin
  if Action then
  begin
    stVPT.Caption := '';
    stDateTimeCreate.Caption := '';
    stInfo.Caption := '';

    if not FileExists(Name) then
    begin
      Application.MessageBox('Файл не найден', 'Ошибка',
        MB_TASKMODAL or MB_ICONWARNING);
      Exit;
    end;

    fs := TFileStream.Create(Name, fmOpenRead);
    try
      CheckFile(fs, FileHeader, sTmp);
    finally
      FreeAndNil(fs);
    end;
  end;
end;

procedure TfrmExportImport.Prepare;
begin
  edFilePath.Clear;
end;

end.
