unit unfrmMain;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, unDM;

type
  TfrmMain = class(TForm)
    Button1: TButton;
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmMain: TfrmMain;

implementation

uses unfrmExportImport;


{$R *.dfm}

procedure TfrmMain.Button1Click(Sender: TObject);
begin
  case OnlineAnalyze of
    0:
      Application.MessageBox('������ ����� � �������� ������.'#13+
        '�� ��������� ��������� ���� ������ ������� ����������� ���� � ��������� �� �����',
        '��������', MB_TASKMODAL or MB_ICONWARNING);
    1:
      Application.MessageBox('��� ������ ��� ��������', '��������',
        MB_TASKMODAL or MB_ICONASTERISK);

    2:
      begin
        Application.MessageBox('���������', '��������', MB_TASKMODAL or MB_ICONASTERISK);
      end;
  end;
end;

end.
