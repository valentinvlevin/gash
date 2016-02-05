unit unfrmMain;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Gauges, StdCtrls, unDM, uADStanIntf, uADStanOption, uADStanParam,
  uADStanError, uADDatSManager, uADPhysIntf, uADDAptIntf, uADStanAsync,
  uADDAptManager, DB, uADCompDataSet, uADCompClient;

type
  TfrmMain = class(TForm)
    Button1: TButton;
    Button2: TButton;
    gProgress: TGauge;
    fdQry_lite: TADQuery;
    fdQry_PG: TADQuery;
    procedure Button2Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
  private
    procedure StartProgress(const AMaxValue: Integer);
    procedure AddProgress(const AAddValue: Integer);
    procedure StopProgress;
  public
    { Public declarations }
  end;

var
  frmMain: TfrmMain;

implementation

uses unPath, unDSUtils_FD;

{$R *.dfm}

procedure TfrmMain.AddProgress(const AAddValue: Integer);
begin
  gProgress.AddProgress(AAddValue);
end;

procedure TfrmMain.Button1Click(Sender: TObject);
var
  FilePath, FileName: string;
  ParamIndex: Integer;

begin
  if not FileExists(GetAppPath + DataFileName) then
  begin
    Application.MessageBox('Не найден фйл шаблона', 'Ошибка',
      MB_TASKMODAL or MB_ICONWARNING);
    Exit;
  end;

  FilePath := GetAppPath + OutDir + '\';
  if not DirectoryExists(FilePath) then
    ForceDirectories(FilePath);

  FileName := FormatDateTime('yyyy_mm_dd_hh_mm_ss', Now) + '_' + DataFileName;
  if not CopyFile(PChar(GetAppPath + DataFileName), PChar(FilePath + FileName), true) then
  begin
    Application.MessageBox('Не удалось создать экземпляр БД', 'Ошибка',
      MB_TASKMODAL or MB_ICONWARNING);
    Exit;
  end;

  DM.fdCon_lite.Params.Values['Database']:=FilePath + FileName;

  try
    DM.fdCon_lite.Open;
  except
    on e: Exception do
    begin
      Application.MessageBox(PChar('Ошибка при соединении с БД: ' + e.Message),
        'Ошибка', MB_TASKMODAL or MB_ICONWARNING);
      Exit;
    end;
  end;

  StartTransaction(DM.fdCon_lite);
  try
    // Школы

    FillDataSet(fdQry_PG, 'select * from public.vw_uchzav', []);
    try
      fdQry_lite.SQL.Text :=
        'insert into UchZav(IDVPT, GIDUchZav, UchZavKaz, UchZavRus) '+
        'values(:IDVPT, :GIDUchZav, :UchZavKaz, :UchZavRus) ';
      fdQry_lite.Params.ArraySize := 100;
      ParamIndex := 0;

      StartProgress(fdQry_PG.RecordCount);

      while not fdQry_PG.Eof do
      begin
        fdQry_lite.ParamByName('IDVPT').AsIntegers[ParamIndex] := fdQry_PG.FieldByName('id_vpt').AsInteger;
        fdQry_lite.ParamByName('GIDUchZav').AsIntegers[ParamIndex] := fdQry_PG.FieldByName('gid_uchzav').AsInteger;
        fdQry_lite.ParamByName('UchZavKaz').AsWideStrings[ParamIndex] := fdQry_PG.FieldByName('uchzav_kaz').AsWideString;
        fdQry_lite.ParamByName('UchZavRus').AsWideStrings[ParamIndex] := fdQry_PG.FieldByName('uchzav_rus').AsWideString;
        fdQry_PG.Next;

        inc(ParamIndex);

        if (ParamIndex>0)
          and ((ParamIndex = fdQry_lite.Params.ArraySize) or fdQry_PG.Eof) then
        begin
          fdQry_lite.Execute(ParamIndex, 0);
          ParamIndex := 0;
        end;

        AddProgress(1);
      end;
    finally
      fdQry_PG.Close;
      StopProgress;
    end;

    // 4-е классы

    FillDataSet(fdQry_PG, 'select * from vw_listotv_4', []);
    try
      fdQry_lite.SQL.Text :=
        'insert into ListOtv4(IDVPT, ARMSign, IDListOtv, GIDUchZav, IDTestType, LiterClass, '+
        ' sFam, Fam, sInit, Init, KPOIDSeason, sVariant, Variant, '+
        ' IDPredmet1, IDPredmet2, iAnswers1, iAnswers2, '+
        ' sAnswers1, sAnswers2, IsEdit, EditResult, IsIden, '+
        ' Ball1, Ball2, ItogOcen, Ocen1, Ocen2, '+
        ' IsOcen, DateTimeScan, Blank, Lang, LOFileName) '+
        'values(:IDVPT, :ARMSign, :IDListOtv, :GIDUchZav, :IDTestType, :LiterClass, '+
        ' :sFam, :Fam, :sInit, :Init, :KPOIDSeason, :sVariant, :Variant, '+
        ' :IDPredmet1, :IDPredmet2, :iAnswers1, :iAnswers2, '+
        ' :sAnswers1, :sAnswers2, :IsEdit, :EditResult, :IsIden, '+
        ' :Ball1, :Ball2, :ItogOcen, :Ocen1, :Ocen2, '+
        ' :IsOcen, :DateTimeScan, :Blank, :Lang, :LOFileName) ';
      fdQry_lite.Params.ArraySize := 100;
      ParamIndex := 0;

      StartProgress(fdQry_PG.RecordCount);

      while not fdQry_PG.Eof do
      begin
        fdQry_lite.ParamByName('IDVPT').AsIntegers[ParamIndex] := fdQry_PG.FieldByName('id_vpt').AsInteger;
        fdQry_lite.ParamByName('ARMSign').AsIntegers[ParamIndex] := fdQry_PG.FieldByName('arm_sign').AsInteger;
        fdQry_lite.ParamByName('IDListOtv').AsIntegers[ParamIndex] := fdQry_PG.FieldByName('id_listotv').AsInteger;
        fdQry_lite.ParamByName('GIDUchZav').AsIntegers[ParamIndex] := fdQry_PG.FieldByName('gid_uchzav').AsInteger;
        fdQry_lite.ParamByName('IDTestType').AsIntegers[ParamIndex] := fdQry_PG.FieldByName('id_testtype').AsInteger;
        fdQry_lite.ParamByName('LiterClass').AsWideStrings[ParamIndex] := fdQry_PG.FieldByName('liter_class').AsWideString;
        fdQry_lite.ParamByName('sFam').AsWideStrings[ParamIndex] := fdQry_PG.FieldByName('s_fam').AsWideString;
        fdQry_lite.ParamByName('Fam').AsWideStrings[ParamIndex] := fdQry_PG.FieldByName('fam').AsWideString;
        fdQry_lite.ParamByName('sInit').AsWideStrings[ParamIndex] := fdQry_PG.FieldByName('s_init').AsWideString;
        fdQry_lite.ParamByName('Init').AsWideStrings[ParamIndex] := fdQry_PG.FieldByName('init').AsWideString;
        fdQry_lite.ParamByName('KPOIDSeason').AsIntegers[ParamIndex] := fdQry_PG.FieldByName('kpo_id_season').AsInteger;
        fdQry_lite.ParamByName('sVariant').AsWideStrings[ParamIndex] := fdQry_PG.FieldByName('s_variant').AsWideString;
        fdQry_lite.ParamByName('Variant').AsIntegers[ParamIndex] := fdQry_PG.FieldByName('variant').AsInteger;
        fdQry_lite.ParamByName('IDPredmet1').AsIntegers[ParamIndex] := fdQry_PG.FieldByName('id_predmet1').AsInteger;
        fdQry_lite.ParamByName('IDPredmet2').AsIntegers[ParamIndex] := fdQry_PG.FieldByName('id_predmet2').AsInteger;
        fdQry_lite.ParamByName('iAnswers1').AsWideStrings[ParamIndex] := fdQry_PG.FieldByName('i_answers1').AsWideString;
        fdQry_lite.ParamByName('iAnswers2').AsWideStrings[ParamIndex] := fdQry_PG.FieldByName('i_answers2').AsWideString;
        fdQry_lite.ParamByName('sAnswers1').AsWideStrings[ParamIndex] := fdQry_PG.FieldByName('s_answers1').AsWideString;
        fdQry_lite.ParamByName('sAnswers2').AsWideStrings[ParamIndex] := fdQry_PG.FieldByName('s_answers2').AsWideString;

        fdQry_lite.ParamByName('IsEdit').AsIntegers[ParamIndex] := fdQry_PG.FieldByName('is_edit').AsInteger;
        fdQry_lite.ParamByName('EditResult').AsIntegers[ParamIndex] := fdQry_PG.FieldByName('edit_result').AsInteger;
        fdQry_lite.ParamByName('IsIden').AsIntegers[ParamIndex] := fdQry_PG.FieldByName('is_iden').AsInteger;
        fdQry_lite.ParamByName('Ball1').AsIntegers[ParamIndex] := fdQry_PG.FieldByName('ball1').AsInteger;
        fdQry_lite.ParamByName('Ball2').AsIntegers[ParamIndex] := fdQry_PG.FieldByName('ball2').AsInteger;

        fdQry_lite.ParamByName('ItogOcen').AsIntegers[ParamIndex] := fdQry_PG.FieldByName('itog_ocen').AsInteger;
        fdQry_lite.ParamByName('Ocen1').AsIntegers[ParamIndex] := fdQry_PG.FieldByName('ocen1').AsInteger;
        fdQry_lite.ParamByName('Ocen2').AsIntegers[ParamIndex] := fdQry_PG.FieldByName('ocen2').AsInteger;

        fdQry_lite.ParamByName('IsOcen').AsIntegers[ParamIndex] := fdQry_PG.FieldByName('is_ocen').AsInteger;

        fdQry_lite.ParamByName('DateTimeScan').AsDateTimes[ParamIndex] := fdQry_PG.FieldByName('date_time_scan').AsDateTime;
        fdQry_lite.ParamByName('Blank').AsWideStrings[ParamIndex] := fdQry_PG.FieldByName('blank').AsWideString;
        fdQry_lite.ParamByName('Lang').AsIntegers[ParamIndex] := fdQry_PG.FieldByName('lang').AsInteger;
        fdQry_lite.ParamByName('LOFileName').AsStrings[ParamIndex] := fdQry_PG.FieldByName('lo_file_name').AsString;

        fdQry_PG.Next;

        inc(ParamIndex);

        if (ParamIndex>0)
          and ((ParamIndex = fdQry_lite.Params.ArraySize) or fdQry_PG.Eof) then
        begin
          fdQry_lite.Execute(ParamIndex, 0);
          ParamIndex := 0;
        end;

        AddProgress(1);
      end;
    finally
      fdQry_PG.Close;
      StopProgress;
    end;

    // 9-е классы

    FillDataSet(fdQry_PG, 'select * from vw_listotv_9', []);
    try
      fdQry_lite.SQL.Text :=
        'insert into ListOtv9(IDVPT, ARMSign, IDListOtv, GIDUchZav, IDTestType, LiterClass, '+
        ' sFam, Fam, sInit, Init, KPOIDSeason, sVariant, Variant, '+
        ' IDPredmet1, IDPredmet2, IDPredmet3, iAnswers1, iAnswers2, iAnswers3, '+
        ' sAnswers1, sAnswers2, sAnswers3, IsEdit, EditResult, IsIden, '+
        ' Ball1, Ball2, Ball3, ItogOcen, Ocen1, Ocen2, Ocen3, '+
        ' IsOcen, DateTimeScan, Blank, Lang, LOFileName) '+
        'values(:IDVPT, :ARMSign, :IDListOtv, :GIDUchZav, :IDTestType, :LiterClass, '+
        ' :sFam, :Fam, :sInit, :Init, :KPOIDSeason, :sVariant, :Variant, '+
        ' :IDPredmet1, :IDPredmet2, :IDPredmet3, :iAnswers1, :iAnswers2, :iAnswers3, '+
        ' :sAnswers1, :sAnswers2, :sAnswers3, :IsEdit, :EditResult, :IsIden, '+
        ' :Ball1, :Ball2, :Ball3, :ItogOcen, :Ocen1, :Ocen2, :Ocen3, '+
        ' :IsOcen, :DateTimeScan, :Blank, :Lang, :LOFileName) ';
      fdQry_lite.Params.ArraySize := 100;
      ParamIndex := 0;

      StartProgress(fdQry_PG.RecordCount);

      while not fdQry_PG.Eof do
      begin
        fdQry_lite.ParamByName('IDVPT').AsIntegers[ParamIndex] := fdQry_PG.FieldByName('id_vpt').AsInteger;
        fdQry_lite.ParamByName('ARMSign').AsIntegers[ParamIndex] := fdQry_PG.FieldByName('arm_sign').AsInteger;
        fdQry_lite.ParamByName('IDListOtv').AsIntegers[ParamIndex] := fdQry_PG.FieldByName('id_listotv').AsInteger;
        fdQry_lite.ParamByName('GIDUchZav').AsIntegers[ParamIndex] := fdQry_PG.FieldByName('gid_uchzav').AsInteger;
        fdQry_lite.ParamByName('IDTestType').AsIntegers[ParamIndex] := fdQry_PG.FieldByName('id_testtype').AsInteger;
        fdQry_lite.ParamByName('LiterClass').AsWideStrings[ParamIndex] := fdQry_PG.FieldByName('liter_class').AsWideString;
        fdQry_lite.ParamByName('sFam').AsWideStrings[ParamIndex] := fdQry_PG.FieldByName('s_fam').AsWideString;
        fdQry_lite.ParamByName('Fam').AsWideStrings[ParamIndex] := fdQry_PG.FieldByName('fam').AsWideString;
        fdQry_lite.ParamByName('sInit').AsWideStrings[ParamIndex] := fdQry_PG.FieldByName('s_init').AsWideString;
        fdQry_lite.ParamByName('Init').AsWideStrings[ParamIndex] := fdQry_PG.FieldByName('init').AsWideString;
        fdQry_lite.ParamByName('KPOIDSeason').AsIntegers[ParamIndex] := fdQry_PG.FieldByName('kpo_id_season').AsInteger;
        fdQry_lite.ParamByName('sVariant').AsWideStrings[ParamIndex] := fdQry_PG.FieldByName('s_variant').AsWideString;
        fdQry_lite.ParamByName('Variant').AsIntegers[ParamIndex] := fdQry_PG.FieldByName('variant').AsInteger;

        fdQry_lite.ParamByName('IDPredmet1').AsIntegers[ParamIndex] := fdQry_PG.FieldByName('id_predmet1').AsInteger;
        fdQry_lite.ParamByName('IDPredmet2').AsIntegers[ParamIndex] := fdQry_PG.FieldByName('id_predmet2').AsInteger;
        fdQry_lite.ParamByName('IDPredmet3').AsIntegers[ParamIndex] := fdQry_PG.FieldByName('id_predmet3').AsInteger;

        fdQry_lite.ParamByName('iAnswers1').AsWideStrings[ParamIndex] := fdQry_PG.FieldByName('i_answers1').AsWideString;
        fdQry_lite.ParamByName('iAnswers2').AsWideStrings[ParamIndex] := fdQry_PG.FieldByName('i_answers2').AsWideString;
        fdQry_lite.ParamByName('iAnswers3').AsWideStrings[ParamIndex] := fdQry_PG.FieldByName('i_answers3').AsWideString;

        fdQry_lite.ParamByName('sAnswers1').AsWideStrings[ParamIndex] := fdQry_PG.FieldByName('s_answers1').AsWideString;
        fdQry_lite.ParamByName('sAnswers2').AsWideStrings[ParamIndex] := fdQry_PG.FieldByName('s_answers2').AsWideString;
        fdQry_lite.ParamByName('sAnswers3').AsWideStrings[ParamIndex] := fdQry_PG.FieldByName('s_answers3').AsWideString;

        fdQry_lite.ParamByName('IsEdit').AsIntegers[ParamIndex] := fdQry_PG.FieldByName('is_edit').AsInteger;
        fdQry_lite.ParamByName('EditResult').AsIntegers[ParamIndex] := fdQry_PG.FieldByName('edit_result').AsInteger;
        fdQry_lite.ParamByName('IsIden').AsIntegers[ParamIndex] := fdQry_PG.FieldByName('is_iden').AsInteger;

        fdQry_lite.ParamByName('Ball1').AsIntegers[ParamIndex] := fdQry_PG.FieldByName('ball1').AsInteger;
        fdQry_lite.ParamByName('Ball2').AsIntegers[ParamIndex] := fdQry_PG.FieldByName('ball2').AsInteger;
        fdQry_lite.ParamByName('Ball3').AsIntegers[ParamIndex] := fdQry_PG.FieldByName('ball3').AsInteger;

        fdQry_lite.ParamByName('ItogOcen').AsIntegers[ParamIndex] := fdQry_PG.FieldByName('itog_ocen').AsInteger;
        fdQry_lite.ParamByName('Ocen1').AsIntegers[ParamIndex] := fdQry_PG.FieldByName('ocen1').AsInteger;
        fdQry_lite.ParamByName('Ocen2').AsIntegers[ParamIndex] := fdQry_PG.FieldByName('ocen2').AsInteger;
        fdQry_lite.ParamByName('Ocen3').AsIntegers[ParamIndex] := fdQry_PG.FieldByName('ocen3').AsInteger;

        fdQry_lite.ParamByName('IsOcen').AsIntegers[ParamIndex] := fdQry_PG.FieldByName('is_ocen').AsInteger;

        fdQry_lite.ParamByName('DateTimeScan').AsDateTimes[ParamIndex] := fdQry_PG.FieldByName('date_time_scan').AsDateTime;
        fdQry_lite.ParamByName('Blank').AsWideStrings[ParamIndex] := fdQry_PG.FieldByName('blank').AsWideString;
        fdQry_lite.ParamByName('Lang').AsIntegers[ParamIndex] := fdQry_PG.FieldByName('lang').AsInteger;
        fdQry_lite.ParamByName('LOFileName').AsStrings[ParamIndex] := fdQry_PG.FieldByName('lo_file_name').AsString;

        fdQry_PG.Next;

        inc(ParamIndex);

        if (ParamIndex>0)
          and ((ParamIndex = fdQry_lite.Params.ArraySize) or fdQry_PG.Eof) then
        begin
          fdQry_lite.Execute(ParamIndex, 0);
          ParamIndex := 0;
        end;

        AddProgress(1);
      end;
    finally
      fdQry_PG.Close;
      StopProgress;
    end;

    // 11-е классы

    FillDataSet(fdQry_PG, 'select * from vw_listotv_11', []);
    try
      fdQry_lite.SQL.Text :=
        'insert into ListOtv11(IDVPT, ARMSign, IDListOtv, GIDUchZav, IDTestType, LiterClass, '+
        ' sFam, Fam, sInit, Init, KPOIDSeason, sVariant, Variant, '+
        ' IDPredmet1, IDPredmet2, IDPredmet3, IDPredmet4, '+
        ' iAnswers1, iAnswers2, iAnswers3, iAnswers4, '+
        ' sAnswers1, sAnswers2, sAnswers3, sAnswers4, IsEdit, EditResult, IsIden, '+
        ' Ball1, Ball2, Ball3, Ball4, ItogOcen, Ocen1, Ocen2, Ocen3, Ocen4, '+
        ' IsOcen, DateTimeScan, Blank, Lang, LOFileName) '+
        'values(:IDVPT, :ARMSign, :IDListOtv, :GIDUchZav, :IDTestType, :LiterClass, '+
        ' :sFam, :Fam, :sInit, :Init, :KPOIDSeason, :sVariant, :Variant, '+
        ' :IDPredmet1, :IDPredmet2, :IDPredmet3, :IDPredmet4, '+
        ' :iAnswers1, :iAnswers2, :iAnswers3, :iAnswers4, '+
        ' :sAnswers1, :sAnswers2, :sAnswers3, :sAnswers4, :IsEdit, :EditResult, :IsIden, '+
        ' :Ball1, :Ball2, :Ball3, :Ball4, :ItogOcen, :Ocen1, :Ocen2, :Ocen3, :Ocen4, '+
        ' :IsOcen, :DateTimeScan, :Blank, :Lang, :LOFileName) ';
      fdQry_lite.Params.ArraySize := 100;
      ParamIndex := 0;

      StartProgress(fdQry_PG.RecordCount);

      while not fdQry_PG.Eof do
      begin
        fdQry_lite.ParamByName('IDVPT').AsIntegers[ParamIndex] := fdQry_PG.FieldByName('id_vpt').AsInteger;
        fdQry_lite.ParamByName('ARMSign').AsIntegers[ParamIndex] := fdQry_PG.FieldByName('arm_sign').AsInteger;
        fdQry_lite.ParamByName('IDListOtv').AsIntegers[ParamIndex] := fdQry_PG.FieldByName('id_listotv').AsInteger;
        fdQry_lite.ParamByName('GIDUchZav').AsIntegers[ParamIndex] := fdQry_PG.FieldByName('gid_uchzav').AsInteger;
        fdQry_lite.ParamByName('IDTestType').AsIntegers[ParamIndex] := fdQry_PG.FieldByName('id_testtype').AsInteger;
        fdQry_lite.ParamByName('LiterClass').AsWideStrings[ParamIndex] := fdQry_PG.FieldByName('liter_class').AsWideString;
        fdQry_lite.ParamByName('sFam').AsWideStrings[ParamIndex] := fdQry_PG.FieldByName('s_fam').AsWideString;
        fdQry_lite.ParamByName('Fam').AsWideStrings[ParamIndex] := fdQry_PG.FieldByName('fam').AsWideString;
        fdQry_lite.ParamByName('sInit').AsWideStrings[ParamIndex] := fdQry_PG.FieldByName('s_init').AsWideString;
        fdQry_lite.ParamByName('Init').AsWideStrings[ParamIndex] := fdQry_PG.FieldByName('init').AsWideString;
        fdQry_lite.ParamByName('KPOIDSeason').AsIntegers[ParamIndex] := fdQry_PG.FieldByName('kpo_id_season').AsInteger;
        fdQry_lite.ParamByName('sVariant').AsWideStrings[ParamIndex] := fdQry_PG.FieldByName('s_variant').AsWideString;
        fdQry_lite.ParamByName('Variant').AsIntegers[ParamIndex] := fdQry_PG.FieldByName('variant').AsInteger;

        fdQry_lite.ParamByName('IDPredmet1').AsIntegers[ParamIndex] := fdQry_PG.FieldByName('id_predmet1').AsInteger;
        fdQry_lite.ParamByName('IDPredmet2').AsIntegers[ParamIndex] := fdQry_PG.FieldByName('id_predmet2').AsInteger;
        fdQry_lite.ParamByName('IDPredmet3').AsIntegers[ParamIndex] := fdQry_PG.FieldByName('id_predmet3').AsInteger;
        fdQry_lite.ParamByName('IDPredmet4').AsIntegers[ParamIndex] := fdQry_PG.FieldByName('id_predmet4').AsInteger;

        fdQry_lite.ParamByName('iAnswers1').AsWideStrings[ParamIndex] := fdQry_PG.FieldByName('i_answers1').AsWideString;
        fdQry_lite.ParamByName('iAnswers2').AsWideStrings[ParamIndex] := fdQry_PG.FieldByName('i_answers2').AsWideString;
        fdQry_lite.ParamByName('iAnswers3').AsWideStrings[ParamIndex] := fdQry_PG.FieldByName('i_answers3').AsWideString;
        fdQry_lite.ParamByName('iAnswers4').AsWideStrings[ParamIndex] := fdQry_PG.FieldByName('i_answers4').AsWideString;

        fdQry_lite.ParamByName('sAnswers1').AsWideStrings[ParamIndex] := fdQry_PG.FieldByName('s_answers1').AsWideString;
        fdQry_lite.ParamByName('sAnswers2').AsWideStrings[ParamIndex] := fdQry_PG.FieldByName('s_answers2').AsWideString;
        fdQry_lite.ParamByName('sAnswers3').AsWideStrings[ParamIndex] := fdQry_PG.FieldByName('s_answers3').AsWideString;
        fdQry_lite.ParamByName('sAnswers4').AsWideStrings[ParamIndex] := fdQry_PG.FieldByName('s_answers4').AsWideString;

        fdQry_lite.ParamByName('IsEdit').AsIntegers[ParamIndex] := fdQry_PG.FieldByName('is_edit').AsInteger;
        fdQry_lite.ParamByName('EditResult').AsIntegers[ParamIndex] := fdQry_PG.FieldByName('edit_result').AsInteger;
        fdQry_lite.ParamByName('IsIden').AsIntegers[ParamIndex] := fdQry_PG.FieldByName('is_iden').AsInteger;

        fdQry_lite.ParamByName('Ball1').AsIntegers[ParamIndex] := fdQry_PG.FieldByName('ball1').AsInteger;
        fdQry_lite.ParamByName('Ball2').AsIntegers[ParamIndex] := fdQry_PG.FieldByName('ball2').AsInteger;
        fdQry_lite.ParamByName('Ball3').AsIntegers[ParamIndex] := fdQry_PG.FieldByName('ball3').AsInteger;
        fdQry_lite.ParamByName('Ball4').AsIntegers[ParamIndex] := fdQry_PG.FieldByName('ball4').AsInteger;

        fdQry_lite.ParamByName('ItogOcen').AsIntegers[ParamIndex] := fdQry_PG.FieldByName('itog_ocen').AsInteger;
        fdQry_lite.ParamByName('Ocen1').AsIntegers[ParamIndex] := fdQry_PG.FieldByName('ocen1').AsInteger;
        fdQry_lite.ParamByName('Ocen2').AsIntegers[ParamIndex] := fdQry_PG.FieldByName('ocen2').AsInteger;
        fdQry_lite.ParamByName('Ocen3').AsIntegers[ParamIndex] := fdQry_PG.FieldByName('ocen3').AsInteger;
        fdQry_lite.ParamByName('Ocen4').AsIntegers[ParamIndex] := fdQry_PG.FieldByName('ocen4').AsInteger;

        fdQry_lite.ParamByName('IsOcen').AsIntegers[ParamIndex] := fdQry_PG.FieldByName('is_ocen').AsInteger;

        fdQry_lite.ParamByName('DateTimeScan').AsDateTimes[ParamIndex] := fdQry_PG.FieldByName('date_time_scan').AsDateTime;
        fdQry_lite.ParamByName('Blank').AsWideStrings[ParamIndex] := fdQry_PG.FieldByName('blank').AsWideString;
        fdQry_lite.ParamByName('Lang').AsIntegers[ParamIndex] := fdQry_PG.FieldByName('lang').AsInteger;
        fdQry_lite.ParamByName('LOFileName').AsStrings[ParamIndex] := fdQry_PG.FieldByName('lo_file_name').AsString;

        fdQry_PG.Next;

        inc(ParamIndex);

        if (ParamIndex>0)
          and ((ParamIndex = fdQry_lite.Params.ArraySize) or fdQry_PG.Eof) then
        begin
          fdQry_lite.Execute(ParamIndex, 0);
          ParamIndex := 0;
        end;

        AddProgress(1);
      end;
    finally
      fdQry_PG.Close;
      StopProgress;
    end;

    CommitTransaction(DM.fdCon_lite);
    Application.MessageBox('Завершено', 'Внимание', mb_taskmodal or mb_iconasterisk);
  except
    on e: Exception do
    begin
      RollBackTransaction(DM.fdCon_lite);
      Application.MessageBox(PChar('Ошибка при работе с БД: '+e.Message),
        'Ошибка', mb_taskmodal or mb_iconwarning);
    end;
  end;

  DM.fdCon_lite.Close;
end;

procedure TfrmMain.Button2Click(Sender: TObject);
begin
  Close;
end;

procedure TfrmMain.StartProgress(const AMaxValue: Integer);
begin
  gProgress.Progress := 0;
  gProgress.MaxValue := AMaxValue;
end;

procedure TfrmMain.StopProgress;
begin
  gProgress.Progress := 0;
end;

end.
