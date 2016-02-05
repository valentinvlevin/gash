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
      Application.MessageBox('Ошибка связи с сервером оценки.'#13+
        'По окончании обработки всех листов ответов сформируйте файл и отправьте по почте',
        'Внимание', MB_TASKMODAL or MB_ICONWARNING);
    1:
      Application.MessageBox('Нет данных для отправки', 'Внимание',
        MB_TASKMODAL or MB_ICONASTERISK);

    2:
      begin
        Application.MessageBox('Завершено', 'Внимание', MB_TASKMODAL or MB_ICONASTERISK);
      end;
  end;
end;

end.
