program LoadData;

uses
  Forms,
  unfrmMain in 'unfrmMain.pas' {frmMain},
  unDM in 'unDM.pas' {DM: TDataModule},
  unPath in 'unPath.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;

  if ConnectDB then
  begin
    Prepare;
    Application.CreateForm(TfrmMain, frmMain);
    Application.Run;
  end;
end.
