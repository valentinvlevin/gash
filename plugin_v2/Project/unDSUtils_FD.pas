unit unDSUtils_FD;

interface

uses
  Classes, SysUtils, DB, uADCompClient, uADStanOption, uADStanParam;

  function GetInt(AConnection: TADConnection; const ASQL: string;
    const AParams: array of Variant): Integer;

  function GetFloat(AConnection: TADConnection; const ASQL: string;
    const AParams: array of Variant): Real;

  function GetDateTime(AConnection: TADConnection; const ASQL: string;
    const AParams: array of Variant): TDateTime;

  function GetStr(AConnection: TADConnection; const ASQL: string;
    AParams: array of Variant): string;

  function GetBool(AConnection: TADConnection; const ASQL: string;
    const AParams: array of Variant): Boolean;

  procedure StartTransaction(AConnection: TADConnection);

  function ExecuteSQL(AConnection: TADConnection; const ASQL: string;
    const AParamValues: array of Variant;
    const UseTransaction: Boolean = True): Boolean;

  procedure CommitTransaction(AConnection: TADConnection);
  procedure RollbackTransaction(AConnection: TADConnection);

  function GetDataSet(AConnection: TADConnection; const ASQL: string;
    const AParams: array of Variant): TDataSet;

  procedure FillDataSet(AQry: TADQuery; const ASQL: string;
    const AParams: array of Variant);

  function GetEmptyID(const ATableName, AIDFieldName: string;
    UDConnection: TADConnection;
    const MinID: Integer = 1; const MaxID: Integer = 999): Integer;


implementation

var
  LocalQry: TADQuery;

function ExecuteSQL(AConnection: TADConnection; const ASQL: string;
  const AParamValues: array of Variant;
  const UseTransaction: Boolean = True): Boolean; overload;
var
  i: Integer;
begin
  if LocalQry.Active then
    LocalQry.Close;
  if UseTransaction then
  begin
    if AConnection.InTransaction
      then AConnection.Commit;
    AConnection.StartTransaction;
  end;

  LocalQry.Connection:=AConnection;
  LocalQry.FetchOptions.Mode := fmAll;
  LocalQry.FetchOptions.RecordCountMode := cmTotal;

  with LocalQry do
  begin
    SQL.Text:=ASQL;

    if Params.Count<>Length(AParamValues)
      then raise Exception.Create('Количество параметров в запросе не соответствует количеству передаваемых значений');

    for i:=0 to Params.Count-1 do
      Params[i].Value:=AParamValues[i];

    try
      ExecSQL;
      if UseTransaction
        then AConnection.Commit;
      Result:=True;
    except
      if UseTransaction
        then AConnection.Rollback;
      raise;
    end;
  end;
end;

function GetInt(AConnection: TADConnection; const ASQL: string;
  const AParams: array of Variant): Integer;
var
  i: Integer;
begin
  Result:=0;
  if LocalQry.Active then
    LocalQry.Close;
  LocalQry.Connection:=AConnection;
  LocalQry.FetchOptions.Mode := fmAll;
  LocalQry.FetchOptions.RecordCountMode := cmTotal;

  with LocalQry do
  begin
    SQL.Text := ASQL;

    if Params.Count<>Length(AParams)
      then raise Exception.Create('Количество параметров в запросе не соответствует количеству передаваемых значений');

    for i:=0 to Params.Count-1 do
      Params[i].Value:=AParams[i];
    try
      Open;
      if not IsEmpty
        and not Fields[0].IsNull then
        Result:=Fields[0].AsInteger;
    finally
      Close;
    end;
  end;
end;

function GetFloat(AConnection: TADConnection; const ASQL: string;
  const AParams: array of Variant): Real;
var
  i: Integer;
begin
  Result:=0;
  if LocalQry.Active then
    LocalQry.Close;
  LocalQry.Connection:=AConnection;
  LocalQry.FetchOptions.Mode := fmAll;
  LocalQry.FetchOptions.RecordCountMode := cmTotal;

  with LocalQry do
  begin
    SQL.Text := ASQL;

    if Params.Count<>Length(AParams)
      then raise Exception.Create('Количество параметров в запросе не соответствует '+
                                  'количеству передаваемых значений');

    for i:=0 to Params.Count-1 do
      Params[i].Value:=AParams[i];
    try
      Open;
      if not IsEmpty then
        Result:=Fields[0].AsFloat;
    finally
      Close;
    end;
  end;
end;

function GetDateTime(AConnection: TADConnection; const ASQL: string;
  const AParams: array of Variant): TDateTime;
var
  i: Integer;
begin
  Result:=0;
  if LocalQry.Active then
    LocalQry.Close;
  LocalQry.Connection:=AConnection;
  LocalQry.FetchOptions.Mode := fmAll;
  LocalQry.FetchOptions.RecordCountMode := cmTotal;

  with LocalQry do
  begin
    SQL.Text := ASQL;

    if Params.Count<>Length(AParams)
      then raise Exception.Create('Количество параметров в запросе не соответствует '+
                                  'количеству передаваемых значений');

    for i:=0 to Params.Count-1 do
      Params[i].Value:=AParams[i];
    try
      Open;
      if not IsEmpty then
        Result:=Fields[0].AsDateTime;
    finally
      Close;
    end;
  end;
end;

function GetStr(AConnection: TADConnection; const ASQL: string;
  AParams: array of Variant): string;
var
  i: Integer;
begin
  Result:='';
  if LocalQry.Active then
    LocalQry.Close;
  LocalQry.Connection:=AConnection;
  LocalQry.FetchOptions.Mode := fmAll;
  LocalQry.FetchOptions.RecordCountMode := cmTotal;

  with LocalQry do
  begin
    SQL.Text := ASQL;

    if Params.Count<>Length(AParams)
      then raise Exception.Create('Количество параметров в запросе не соответствует '+
                                  'количеству передаваемых значений');

    for i:=0 to Params.Count-1 do
      Params[i].Value:=AParams[i];
    try
      Open;
      if not IsEmpty then
        Result:=Fields[0].AsString;
    finally
      Close;
    end;
  end;
end;

function GetBool(AConnection: TADConnection; const ASQL: string;
  const AParams: array of Variant): Boolean;
var
  i: Integer;
begin
  Result:=False;
  if LocalQry.Active then
    LocalQry.Close;
  LocalQry.Connection:=AConnection;
  LocalQry.FetchOptions.Mode := fmAll;
  LocalQry.FetchOptions.RecordCountMode := cmTotal;

  with LocalQry do
  begin
    SQL.Text := ASQL;

    if Params.Count<>Length(AParams)
      then raise Exception.Create('Количество параметров в запросе не соответствует' +
                                  'количеству передаваемых значений');

    for i:=0 to Params.Count-1 do
      Params[i].Value:=AParams[i];
    try
      Open;
      if not IsEmpty then
        Result:=Fields[0].AsBoolean;
    finally
      Close;
    end;
  end;
end;

function GetDataSet(AConnection: TADConnection; const ASQL: string;
  const AParams: array of Variant): TDataSet;
var
  i: Integer;
begin
  Result:=TADQuery.Create(nil);
  with TADQuery(Result) do
  begin
    Connection:=AConnection;
    TADQuery(Result).FetchOptions.Mode := fmAll;
    TADQuery(Result).FetchOptions.RecordCountMode := cmTotal;
    SQL.Text:=ASQL;

    if Params.Count<>Length(AParams)
      then raise Exception.Create('Количество параметров в запросе не соответствует '+
                                  'количеству передаваемых значений');

    for i:=0 to Params.Count-1 do
      Params[i].Value:=AParams[i];
    try
      Open;
    except
      Free;
      raise;
    end;
  end;
end;

procedure FillDataSet(AQry: TADQuery; const ASQL: string;
  const AParams: array of Variant);
var
  i: Integer;
begin
  with AQry do
  begin
    if Active
      then Close;

    AQry.FetchOptions.Mode := fmAll;
    AQry.FetchOptions.RecordCountMode := cmTotal;

    SQL.Text:=ASQL;

    if Params.Count<>Length(AParams)
      then raise Exception.Create('Количество параметров в запросе не соответствует '+
                                  'количеству передаваемых значений');

    for i:=0 to Params.Count-1 do
      Params[i].Value:=AParams[i];
    try
      Open;
    except
      Close;
      raise;
    end;
  end;
end;

procedure StartTransaction(AConnection: TADConnection);
begin
  CommitTransaction(AConnection);
  AConnection.StartTransaction;
end;

function GetEmptyID(const ATableName, AIDFieldName: string;
  UDConnection: TADConnection;
  const MinID: Integer = 1; const MaxID: Integer = 999): Integer;
begin
  if LocalQry.Active
    then LocalQry.Close;
  LocalQry.Connection := UDConnection;
  LocalQry.FetchOptions.Mode := fmAll;
  LocalQry.FetchOptions.RecordCountMode := cmTotal;

  LocalQry.SQL.Text :=
    'select ' + AIDFieldName + ' ' +
    'from ' + ATableName + ' ' +
    'where ' + AIDFieldName + '>=' + IntToStr(MinID) + ' ' +
    'order by 1';
  try
    LocalQry.Open;
    case LocalQry.RecordCount of
      0: Result := MinID;
      1: if LocalQry.FieldByName(AIDFieldName).AsInteger > MinID
          then Result := MinID
          else Result := LocalQry.FieldByName(AIDFieldName).AsInteger + 1;
      else
      if LocalQry.FieldByName(AIDFieldName).AsInteger=MinID then
      begin
        Result := LocalQry.FieldByName(AIDFieldName).AsInteger + 1;
        LocalQry.Next;
        while not LocalQry.Eof do
          if LocalQry.FieldByName(AIDFieldName).AsInteger = Result then
          begin
            if LocalQry.FieldByName(AIDFieldName).AsInteger < MaxID
              then Result := LocalQry.FieldByName(AIDFieldName).AsInteger + 1
              else raise Exception.Create(AIDFieldName+' - не осталось свободных значений');
            LocalQry.Next;
          end
          else Break;
      end
      else Result := MinID;
    end;
  finally
    LocalQry.Close;
  end;
end;

procedure CommitTransaction(AConnection: TADConnection);
begin
  if AConnection.InTransaction then
    AConnection.Commit;
end;

procedure RollbackTransaction(AConnection: TADConnection);
begin
  if AConnection.InTransaction then
    AConnection.Rollback;
end;

initialization
  LocalQry := TADQuery.Create(nil);

finalization
  if LocalQry.Active
    then LocalQry.Close;
  LocalQry.Free;

end.
