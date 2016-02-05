unit unDM;

interface

uses
  Windows, SysUtils, Classes, DB, Forms, uADStanIntf, uADStanOption,
  uADStanError, uADGUIxIntf, uADPhysIntf, uADStanDef, uADStanPool, uADStanAsync,
  uADPhysManager, uADStanParam, uADDatSManager, uADDAptIntf, uADDAptManager,
  uADStanExprFuncs, uADCompGUIx, uADPhysSQLite, uADCompClient, uADCompDataSet,
  uADGUIxConsoleWait, uADPhysPG;

type
  TDM = class(TDataModule)
    fdCon: TADConnection;
    fdTblKPO: TADTable;
    fdQry: TADQuery;
    FDGUIxWaitCursor: TADGUIxWaitCursor;
    ADPhysPgDriverLink: TADPhysPgDriverLink;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

  function ConnectDB: Boolean;

var
  DM: TDM;
  IDSeason: Integer;

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
    if fdCon.Connected then
      fdCon.Close;

    Ini := TIniFile.Create(GetAppPath + 'config.ini');
    try
      ServerName := Ini.ReadString('ConnectionParams', 'server', '192.168.57.129');
      UserName := Ini.ReadString('ConnectionParams', 'username', 'postgres');
      DatabaseName := Ini.ReadString('ConnectionParams', 'database', 'gash_ocen');
    finally
      FreeAndNil(Ini);
    end;

    try
      fdCon.Params.Values['Server'] := ServerName;
      fdCon.Params.Values['Database'] := DatabaseName;
      fdCon.Params.Values['User_Name'] := UserName;
      fdCon.Params.Values['Password'] := 'ramgdov03q';

      fdCon.Open;
      fdTblKPO.Open;

      IDSeason := GetInt(fdCon, 'select cur_id_season from info_self', []);
    except
      on E: Exception do
        SaveToLogFile('Не удалось подключиться к базе данных'#13+e.Message);
    end;

    Result := fdCon.Connected;
  end;
end;

end.
