unit unfrmMain;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, InvokeRegistry, Rio, SOAPHTTPClient, StdCtrls, SOAPHTTPTrans, DB,
  DBClient, SOAPConn;

type
  TForm1 = class(TForm)
    Button1: TButton;
    HTTPRIO1: THTTPRIO;
    SoapConnection1: TSoapConnection;
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

uses GashOcenService, unfrmExportImport;

{$R *.dfm}

procedure TForm1.Button1Click(Sender: TObject);
begin
  Analyze;
end;

{var
  ansFile: AnswerFile;
  tests: Array_Of_Test;
begin
  ansFile := AnswerFile.Create;
  try
    ansFile.id_vpt := 701;
    ansFile.arm_sign := 2;
    ansFile.file_num := 1;

    SetLength(tests, 2);

    ansFile.tests := tests;
    ansFile.tests[0] := Test.Create;
    ansFile.tests[0].gid_uchzav := 1001;
    ansFile.tests[0].id_test := 1;
    ansFile.tests[0].scan_date := trunc(now);
    ansFile.tests[0].id_test_type := 1;

    ansFile.tests[1] := Test.Create;
    ansFile.tests[1].gid_uchzav := 1002;
    ansFile.tests[1].id_test := 2;
    ansFile.tests[1].scan_date := trunc(now);
    ansFile.tests[1].id_test_type := 2;

    showmessage((HTTPRIO1 as GashOcen).Ocen(ansFile));
  finally
    FreeAndNil(ansFile);
  end;
end;}

end.
