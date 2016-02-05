library OcenGASH;

uses
  SysUtils,
  Classes,
  unSndLevelFunc in 'unSndLevelFunc.pas',
  unPath in 'unPath.pas',
  unDM in 'unDM.pas' {DM: TDataModule};

{$R *.res}

function Initialize: Boolean; stdcall;
begin
  try
    Prepare;
    Result := ConnectDB;
  except
    on E: Exception do
    begin
      Result := False;
      SaveToLogFile('Ошибка при подключении к БД: '+E.Message);
    end;
  end;
end;

procedure Finalize; stdcall;
begin
  if Assigned(DM) then
    FreeAndNil(DM);
end;

exports
  GetName,
  GetInfo,

  Initialize,
  Finalize,

  CheckMessage;

begin

end.
