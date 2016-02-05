program GASHOcenClient;

uses
  Forms,
  unfrmMain in 'unfrmMain.pas' {Form1},
  unDM in 'unDM.pas' {DM: TDataModule},
  unfrmExportImport in 'unfrmExportImport.pas' {frmExportImport},
  unPath in 'unPath.pas',
  MD5 in 'MD5.pas',
  unPack in 'unPack.pas',
  GashOcenService in 'GashOcenService.pas',
  unProxyParams in 'unProxyParams.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  if ConnectToDB then
  begin
    LoadParamsFromDB;
    Application.CreateForm(TForm1, Form1);
  end;
  Application.Run;
end.
