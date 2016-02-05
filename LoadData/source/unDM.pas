unit unDM;

interface

uses
  SysUtils, Classes, uADStanIntf, uADStanOption, uADStanError, uADGUIxIntf,
  uADPhysIntf, uADStanDef, uADStanPool, uADStanAsync, uADPhysManager,
  uADStanExprFuncs, uADPhysSQLite, uADPhysPG, DB, uADCompClient,
  uADDAptManager, Forms, Windows, uADGUIxFormsWait, uADCompGUIx;

type
  TDM = class(TDataModule)
    fdCon_PG: TADConnection;
    ADPhysPgDriverLink: TADPhysPgDriverLink;
    ADPhysSQLiteDriverLink: TADPhysSQLiteDriverLink;
    fdCon_lite: TADConnection;
    ADGUIxWaitCursor: TADGUIxWaitCursor;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

  function ConnectDB: Boolean;

var
  DM: TDM;

implementation

uses unPath, unDSUtils_FD, IniFiles;

{$R *.dfm}

function ConnectDB: Boolean;
var
  Ini: TIniFile;
  ServerName, UserName, DatabaseName: string;
begin
  DM := TDM.Create(Application);
  with DM do
  begin
    if fdCon_PG.Connected then
      fdCon_PG.Close;

    Ini := TIniFile.Create(GetAppPath + 'config.ini');
    try
      ServerName := Ini.ReadString('ConnectionParams', 'server', '192.168.57.129');
      UserName := Ini.ReadString('ConnectionParams', 'username', 'postgres');
      DatabaseName := Ini.ReadString('ConnectionParams', 'database', 'gash_ocen');
    finally
      FreeAndNil(Ini);
    end;

    try
      fdCon_PG.Params.Values['Server'] := ServerName;
      fdCon_PG.Params.Values['Database'] := DatabaseName;
      fdCon_PG.Params.Values['User_Name'] := UserName;
      fdCon_PG.Params.Values['Password'] := 'ramgdov03q';

      fdCon_PG.Open;
    except
      on e: Exception do
        Application.MessageBox(PChar('Ошибка при соединении с БД:'+e.Message),
          'Ошибка', MB_TASKMODAL or MB_ICONWARNING);
    end;

    Result := fdCon_PG.Connected;
  end;
end;

end.
