program GASH;

uses
  Forms,
  unPath in 'unPath.pas',
  unDM in 'unDM.pas' {DM: TDataModule},
  unProxyParams in 'Ocen\unProxyParams.pas',
  unfrmMain in 'unfrmMain.pas' {frmMain},
  unfrmExportImport in 'Ocen\unfrmExportImport.pas' {frmExportImport},
  unGashOcenService in 'Ocen\unGashOcenService.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.Title := 'Государственная аттестация школ';
  PrepareAppPath;
  Application.Run;
  if ConnectToDB then
  begin
    Application.CreateForm(TfrmMain, frmMain);
    Application.Run;
  end;
end.
