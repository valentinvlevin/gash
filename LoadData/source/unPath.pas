unit unPath;

interface
  uses
    Windows, SysUtils, Classes, Forms;

  const
    OutDir = 'out';
    DataFileName = 'data.db';

  procedure Prepare;

  function GetAppPath: string;

implementation
var
  FAppPath: string;

procedure Prepare;
begin
  FAppPath := ExtractFilePath(Application.ExeName);
end;

function GetAppPath: string;
begin
  Result := FAppPath;
end;

end.
