﻿unit unDM;

interface

uses
  Windows, SysUtils, Forms, Classes, DB, uADStanIntf, uADStanOption,
  uADStanError, uADGUIxIntf, uADPhysIntf, uADStanDef, uADStanPool, uADStanAsync,
  uADPhysManager, uADStanParam, uADDatSManager, uADDAptIntf, uADDAptManager,
  uADGUIxFormsWait, uADStanExprFuncs, uADPhysSQLite, uADCompGUIx,
  uADCompDataSet, uADCompClient;

type
  TDM = class(TDataModule)
    udCon: TADConnection;
    udtbl: TADTable;
    FDGUIxWaitCursor: TADGUIxWaitCursor;
    FDPhysSQLiteDriverLink: TADPhysSQLiteDriverLink;
    adTblTrans: TADTable;
    procedure DataModuleDestroy(Sender: TObject);
  private

  public

  end;

  function ConnectToDB: Boolean;

var
  DM: TDM;

implementation

uses
  unSQLiteDSUtils_FD, DateUtils;

{$R *.dfm}

function ConnectToDB: Boolean;
begin
  Result:=False;
  DM := TDM.Create(Application);
  with DM do
  begin
    if udCon.Connected then
      udCon.Close;

    udCon.Params.Values['Database']:=ExtractFilePath(Application.ExeName) + 'Data.stg';

    try
      udCon.Open;
    except
      Application.MessageBox('Не удалось подключиться к базе данных.'#13+
        'Попробуйте восстановить БД из резервной копии', 'Ошибка',
        MB_ICONWARNING or MB_TASKMODAL);
    end;

    Result := udCon.Connected;
  end;
end;

procedure TDM.DataModuleDestroy(Sender: TObject);
begin
  if adTblTrans.Active then
    adTblTrans.Close;
  if udCon.Connected then
    udCon.Close;
end;

end.
