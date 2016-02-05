// ************************************************************************ //
// The types declared in this file were generated from data read from the
// WSDL File described below:
// WSDL     : http://localhost:8080/gash_ocen/GashOcen?wsdl
//  >Import : http://localhost:8080/gash_ocen/GashOcen?wsdl>0
// Version  : 1.0
// (18.09.2015 14:43:42 - - $Rev: 34800 $)
// ************************************************************************ //

unit GashOcenService;

interface

uses InvokeRegistry, SOAPHTTPClient, Types, XSBuiltIns;

const
  IS_OPTN = $0001;
  IS_UNBD = $0002;
  IS_UNQL = $0008;


type

  // ************************************************************************ //
  // The following types, referred to in the WSDL document are not being represented
  // in this file. They are either aliases[@] of other types represented or were referred
  // to but never[!] declared in the document. The types from the latter category
  // typically map to predefined/known XML or Embarcadero types; however, they could also 
  // indicate incorrect WSDL documents that failed to declare or import a schema type.
  // ************************************************************************ //
  // !:int             - "http://www.w3.org/2001/XMLSchema"[Gbl]
  // !:dateTime        - "http://www.w3.org/2001/XMLSchema"[Gbl]
  // !:short           - "http://www.w3.org/2001/XMLSchema"[Gbl]
  // !:boolean         - "http://www.w3.org/2001/XMLSchema"[Gbl]
  // !:byte            - "http://www.w3.org/2001/XMLSchema"[Gbl]
  // !:base64Binary    - "http://www.w3.org/2001/XMLSchema"[Gbl]
  // !:string          - "http://www.w3.org/2001/XMLSchema"[Gbl]

  dtAnswerFile         = class;                 { "http://webservices.gash.testcenter.kz/"[GblCplx] }
  dtTest               = class;                 { "http://webservices.gash.testcenter.kz/"[GblCplx] }
  dtOcen               = class;                 { "http://webservices.gash.testcenter.kz/"[GblCplx] }
  OcenResponse         = class;                 { "http://webservices.gash.testcenter.kz/"[GblCplx] }
  dtSchool             = class;                 { "http://webservices.gash.testcenter.kz/"[GblCplx] }
  dtListOtv            = class;                 { "http://webservices.gash.testcenter.kz/"[GblCplx] }

  Array_Of_dtOcen = array of dtOcen;            { "http://webservices.gash.testcenter.kz/"[GblUbnd] }
  Array_Of_dtListOtv = array of dtListOtv;      { "http://webservices.gash.testcenter.kz/"[GblUbnd] }
  Array_Of_dtTest = array of dtTest;            { "http://webservices.gash.testcenter.kz/"[GblUbnd] }
  Array_Of_dtSchool = array of dtSchool;        { "http://webservices.gash.testcenter.kz/"[GblUbnd] }


  // ************************************************************************ //
  // XML       : dtAnswerFile, global, <complexType>
  // Namespace : http://webservices.gash.testcenter.kz/
  // ************************************************************************ //
  dtAnswerFile = class(TRemotable)
  private
    Fid_vpt: SmallInt;
    Farm_sign: Integer;
    Ffile_num: SmallInt;
    Fcreate_date_time: TXSDateTime;
    Fcreate_date_time_Specified: boolean;
    Ftests: Array_Of_dtTest;
    Ftests_Specified: boolean;
    Fschools: Array_Of_dtSchool;
    Fschools_Specified: boolean;
    Flistotv: Array_Of_dtListOtv;
    Flistotv_Specified: boolean;
    procedure Setcreate_date_time(Index: Integer; const ATXSDateTime: TXSDateTime);
    function  create_date_time_Specified(Index: Integer): boolean;
    procedure Settests(Index: Integer; const AArray_Of_dtTest: Array_Of_dtTest);
    function  tests_Specified(Index: Integer): boolean;
    procedure Setschools(Index: Integer; const AArray_Of_dtSchool: Array_Of_dtSchool);
    function  schools_Specified(Index: Integer): boolean;
    procedure Setlistotv(Index: Integer; const AArray_Of_dtListOtv: Array_Of_dtListOtv);
    function  listotv_Specified(Index: Integer): boolean;
  public
    destructor Destroy; override;
  published
    property id_vpt:           SmallInt            Index (IS_UNQL) read Fid_vpt write Fid_vpt;
    property arm_sign:         Integer             Index (IS_UNQL) read Farm_sign write Farm_sign;
    property file_num:         SmallInt            Index (IS_UNQL) read Ffile_num write Ffile_num;
    property create_date_time: TXSDateTime         Index (IS_OPTN or IS_UNQL) read Fcreate_date_time write Setcreate_date_time stored create_date_time_Specified;
    property tests:            Array_Of_dtTest     Index (IS_OPTN or IS_UNBD or IS_UNQL) read Ftests write Settests stored tests_Specified;
    property schools:          Array_Of_dtSchool   Index (IS_OPTN or IS_UNBD or IS_UNQL) read Fschools write Setschools stored schools_Specified;
    property listotv:          Array_Of_dtListOtv  Index (IS_OPTN or IS_UNBD or IS_UNQL) read Flistotv write Setlistotv stored listotv_Specified;
  end;



  // ************************************************************************ //
  // XML       : dtTest, global, <complexType>
  // Namespace : http://webservices.gash.testcenter.kz/
  // ************************************************************************ //
  dtTest = class(TRemotable)
  private
    Fid_test: Integer;
    Fgid_uchzav: Integer;
    Fscan_date: Integer;
    Fid_test_type: SmallInt;
  published
    property id_test:      Integer   Index (IS_UNQL) read Fid_test write Fid_test;
    property gid_uchzav:   Integer   Index (IS_UNQL) read Fgid_uchzav write Fgid_uchzav;
    property scan_date:    Integer   Index (IS_UNQL) read Fscan_date write Fscan_date;
    property id_test_type: SmallInt  Index (IS_UNQL) read Fid_test_type write Fid_test_type;
  end;



  // ************************************************************************ //
  // XML       : dtOcen, global, <complexType>
  // Namespace : http://webservices.gash.testcenter.kz/
  // ************************************************************************ //
  dtOcen = class(TRemotable)
  private
    Fclass_no: ShortInt;
    Fid_listotv: Integer;
    Fitog_ocen: ShortInt;
    Fballs: TByteDynArray;
    Focen: TByteDynArray;
  published
    property class_no:   ShortInt       Index (IS_UNQL) read Fclass_no write Fclass_no;
    property id_listotv: Integer        Index (IS_UNQL) read Fid_listotv write Fid_listotv;
    property itog_ocen:  ShortInt       Index (IS_UNQL) read Fitog_ocen write Fitog_ocen;
    property balls:      TByteDynArray  Index (IS_UNQL) read Fballs write Fballs;
    property ocen:       TByteDynArray  Index (IS_UNQL) read Focen write Focen;
  end;

  Array_Of_string = array of string;            { "http://www.w3.org/2001/XMLSchema"[GblUbnd] }


  // ************************************************************************ //
  // XML       : OcenResponse, global, <complexType>
  // Namespace : http://webservices.gash.testcenter.kz/
  // ************************************************************************ //
  OcenResponse = class(TRemotable)
  private
    Ferror_message: string;
    Ferror_message_Specified: boolean;
    Focen_list: Array_Of_dtOcen;
    Focen_list_Specified: boolean;
    Fresult_code: Integer;
    procedure Seterror_message(Index: Integer; const Astring: string);
    function  error_message_Specified(Index: Integer): boolean;
    procedure Setocen_list(Index: Integer; const AArray_Of_dtOcen: Array_Of_dtOcen);
    function  ocen_list_Specified(Index: Integer): boolean;
  public
    destructor Destroy; override;
  published
    property error_message: string           Index (IS_OPTN or IS_UNQL) read Ferror_message write Seterror_message stored error_message_Specified;
    property ocen_list:     Array_Of_dtOcen  Index (IS_OPTN or IS_UNBD or IS_UNQL) read Focen_list write Setocen_list stored ocen_list_Specified;
    property result_code:   Integer          Index (IS_UNQL) read Fresult_code write Fresult_code;
  end;



  // ************************************************************************ //
  // XML       : dtSchool, global, <complexType>
  // Namespace : http://webservices.gash.testcenter.kz/
  // ************************************************************************ //
  dtSchool = class(TRemotable)
  private
    Fid: Integer;
    Fschool_kaz: string;
    Fschool_rus: string;
  published
    property id:         Integer  Index (IS_UNQL) read Fid write Fid;
    property school_kaz: string   Index (IS_UNQL) read Fschool_kaz write Fschool_kaz;
    property school_rus: string   Index (IS_UNQL) read Fschool_rus write Fschool_rus;
  end;



  // ************************************************************************ //
  // XML       : dtListOtv, global, <complexType>
  // Namespace : http://webservices.gash.testcenter.kz/
  // ************************************************************************ //
  dtListOtv = class(TRemotable)
  private
    Fclass_no: SmallInt;
    Fid_test: Integer;
    Fid_listotv: Integer;
    Fliter_class: string;
    Fs_fam: string;
    Ffam: string;
    Fs_init: string;
    Finit: string;
    Fkpo_id_season: ShortInt;
    Fs_variant: string;
    Fvariant: SmallInt;
    Fid_predmets: TByteDynArray;
    Fanswers: Array_Of_string;
    Fis_iden: ShortInt;
    Fis_edit: ShortInt;
    Fedit_result: ShortInt;
    Flang: ShortInt;
    Fblank: string;
    Flo_filename: string;
    Fdate_time_scan: TXSDateTime;
  public
    destructor Destroy; override;
  published
    property class_no:       SmallInt         Index (IS_UNQL) read Fclass_no write Fclass_no;
    property id_test:        Integer          Index (IS_UNQL) read Fid_test write Fid_test;
    property id_listotv:     Integer          Index (IS_UNQL) read Fid_listotv write Fid_listotv;
    property liter_class:    string           Index (IS_UNQL) read Fliter_class write Fliter_class;
    property s_fam:          string           Index (IS_UNQL) read Fs_fam write Fs_fam;
    property fam:            string           Index (IS_UNQL) read Ffam write Ffam;
    property s_init:         string           Index (IS_UNQL) read Fs_init write Fs_init;
    property init:           string           Index (IS_UNQL) read Finit write Finit;
    property kpo_id_season:  ShortInt         Index (IS_UNQL) read Fkpo_id_season write Fkpo_id_season;
    property s_variant:      string           Index (IS_UNQL) read Fs_variant write Fs_variant;
    property variant:        SmallInt         Index (IS_UNQL) read Fvariant write Fvariant;
    property id_predmets:    TByteDynArray    Index (IS_UNQL) read Fid_predmets write Fid_predmets;
    property answers:        Array_Of_string  Index (IS_UNBD or IS_UNQL) read Fanswers write Fanswers;
    property is_iden:        ShortInt         Index (IS_UNQL) read Fis_iden write Fis_iden;
    property is_edit:        ShortInt         Index (IS_UNQL) read Fis_edit write Fis_edit;
    property edit_result:    ShortInt         Index (IS_UNQL) read Fedit_result write Fedit_result;
    property lang:           ShortInt         Index (IS_UNQL) read Flang write Flang;
    property blank:          string           Index (IS_UNQL) read Fblank write Fblank;
    property lo_filename:    string           Index (IS_UNQL) read Flo_filename write Flo_filename;
    property date_time_scan: TXSDateTime      Index (IS_UNQL) read Fdate_time_scan write Fdate_time_scan;
  end;


  // ************************************************************************ //
  // Namespace : http://webservices.gash.testcenter.kz/
  // transport : http://schemas.xmlsoap.org/soap/http
  // style     : document
  // use       : literal
  // binding   : GashOcenServiceSoapBinding
  // service   : GashOcenService
  // port      : GashOcenPort
  // URL       : http://localhost:8080/gash_ocen/GashOcen
  // ************************************************************************ //
  GashOcen = interface(IInvokable)
  ['{87764F18-1A76-D3FB-E6CC-10559080C23A}']
    function  isAlive: Boolean; stdcall;
    function  DoAnalyze(const AnswerFile: dtAnswerFile): OcenResponse; stdcall;
  end;

function GetGashOcen(UseWSDL: Boolean=System.False; Addr: string=''; HTTPRIO: THTTPRIO = nil): GashOcen;


implementation
  uses SysUtils;

function GetGashOcen(UseWSDL: Boolean; Addr: string; HTTPRIO: THTTPRIO): GashOcen;
const
  defWSDL = 'http://localhost:8080/gash_ocen/GashOcen?wsdl';
  defURL  = 'http://localhost:8080/gash_ocen/GashOcen';
  defSvc  = 'GashOcenService';
  defPrt  = 'GashOcenPort';
var
  RIO: THTTPRIO;
begin
  Result := nil;
  if (Addr = '') then
  begin
    if UseWSDL then
      Addr := defWSDL
    else
      Addr := defURL;
  end;
  if HTTPRIO = nil then
    RIO := THTTPRIO.Create(nil)
  else
    RIO := HTTPRIO;
  try
    Result := (RIO as GashOcen);
    if UseWSDL then
    begin
      RIO.WSDLLocation := Addr;
      RIO.Service := defSvc;
      RIO.Port := defPrt;
    end else
      RIO.URL := Addr;
  finally
    if (Result = nil) and (HTTPRIO = nil) then
      RIO.Free;
  end;
end;


destructor dtAnswerFile.Destroy;
var
  I: Integer;
begin
  for I := 0 to System.Length(Ftests)-1 do
    SysUtils.FreeAndNil(Ftests[I]);
  System.SetLength(Ftests, 0);
  for I := 0 to System.Length(Fschools)-1 do
    SysUtils.FreeAndNil(Fschools[I]);
  System.SetLength(Fschools, 0);
  for I := 0 to System.Length(Flistotv)-1 do
    SysUtils.FreeAndNil(Flistotv[I]);
  System.SetLength(Flistotv, 0);
  SysUtils.FreeAndNil(Fcreate_date_time);
  inherited Destroy;
end;

procedure dtAnswerFile.Setcreate_date_time(Index: Integer; const ATXSDateTime: TXSDateTime);
begin
  Fcreate_date_time := ATXSDateTime;
  Fcreate_date_time_Specified := True;
end;

function dtAnswerFile.create_date_time_Specified(Index: Integer): boolean;
begin
  Result := Fcreate_date_time_Specified;
end;

procedure dtAnswerFile.Settests(Index: Integer; const AArray_Of_dtTest: Array_Of_dtTest);
begin
  Ftests := AArray_Of_dtTest;
  Ftests_Specified := True;
end;

function dtAnswerFile.tests_Specified(Index: Integer): boolean;
begin
  Result := Ftests_Specified;
end;

procedure dtAnswerFile.Setschools(Index: Integer; const AArray_Of_dtSchool: Array_Of_dtSchool);
begin
  Fschools := AArray_Of_dtSchool;
  Fschools_Specified := True;
end;

function dtAnswerFile.schools_Specified(Index: Integer): boolean;
begin
  Result := Fschools_Specified;
end;

procedure dtAnswerFile.Setlistotv(Index: Integer; const AArray_Of_dtListOtv: Array_Of_dtListOtv);
begin
  Flistotv := AArray_Of_dtListOtv;
  Flistotv_Specified := True;
end;

function dtAnswerFile.listotv_Specified(Index: Integer): boolean;
begin
  Result := Flistotv_Specified;
end;

destructor OcenResponse.Destroy;
var
  I: Integer;
begin
  for I := 0 to System.Length(Focen_list)-1 do
    SysUtils.FreeAndNil(Focen_list[I]);
  System.SetLength(Focen_list, 0);
  inherited Destroy;
end;

procedure OcenResponse.Seterror_message(Index: Integer; const Astring: string);
begin
  Ferror_message := Astring;
  Ferror_message_Specified := True;
end;

function OcenResponse.error_message_Specified(Index: Integer): boolean;
begin
  Result := Ferror_message_Specified;
end;

procedure OcenResponse.Setocen_list(Index: Integer; const AArray_Of_dtOcen: Array_Of_dtOcen);
begin
  Focen_list := AArray_Of_dtOcen;
  Focen_list_Specified := True;
end;

function OcenResponse.ocen_list_Specified(Index: Integer): boolean;
begin
  Result := Focen_list_Specified;
end;

destructor dtListOtv.Destroy;
begin
  SysUtils.FreeAndNil(Fdate_time_scan);
  inherited Destroy;
end;

initialization
  { GashOcen }
  InvRegistry.RegisterInterface(TypeInfo(GashOcen), 'http://webservices.gash.testcenter.kz/', '');
  InvRegistry.RegisterDefaultSOAPAction(TypeInfo(GashOcen), '');
  InvRegistry.RegisterInvokeOptions(TypeInfo(GashOcen), ioDocument);
  { GashOcen.isAlive }
  InvRegistry.RegisterMethodInfo(TypeInfo(GashOcen), 'isAlive', '',
                                 '[ReturnName="return"]', IS_UNQL);
  InvRegistry.RegisterParamInfo(TypeInfo(GashOcen), 'isAlive', 'return', '',
                                '', IS_UNQL);
  { GashOcen.DoAnalyze }
  InvRegistry.RegisterMethodInfo(TypeInfo(GashOcen), 'DoAnalyze', '',
                                 '[ReturnName="return"]', IS_OPTN or IS_UNQL);
  InvRegistry.RegisterParamInfo(TypeInfo(GashOcen), 'DoAnalyze', 'AnswerFile', '',
                                '', IS_UNQL);
  InvRegistry.RegisterParamInfo(TypeInfo(GashOcen), 'DoAnalyze', 'return', '',
                                '', IS_UNQL);
  RemClassRegistry.RegisterXSInfo(TypeInfo(Array_Of_dtOcen), 'http://webservices.gash.testcenter.kz/', 'Array_Of_dtOcen');
  RemClassRegistry.RegisterXSInfo(TypeInfo(Array_Of_dtListOtv), 'http://webservices.gash.testcenter.kz/', 'Array_Of_dtListOtv');
  RemClassRegistry.RegisterXSInfo(TypeInfo(Array_Of_dtTest), 'http://webservices.gash.testcenter.kz/', 'Array_Of_dtTest');
  RemClassRegistry.RegisterXSInfo(TypeInfo(Array_Of_dtSchool), 'http://webservices.gash.testcenter.kz/', 'Array_Of_dtSchool');
  RemClassRegistry.RegisterXSClass(dtAnswerFile, 'http://webservices.gash.testcenter.kz/', 'dtAnswerFile');
  RemClassRegistry.RegisterXSClass(dtTest, 'http://webservices.gash.testcenter.kz/', 'dtTest');
  RemClassRegistry.RegisterXSClass(dtOcen, 'http://webservices.gash.testcenter.kz/', 'dtOcen');
  RemClassRegistry.RegisterXSInfo(TypeInfo(Array_Of_string), 'http://www.w3.org/2001/XMLSchema', 'Array_Of_string');
  RemClassRegistry.RegisterXSClass(OcenResponse, 'http://webservices.gash.testcenter.kz/', 'OcenResponse');
  RemClassRegistry.RegisterXSClass(dtSchool, 'http://webservices.gash.testcenter.kz/', 'dtSchool');
  RemClassRegistry.RegisterXSClass(dtListOtv, 'http://webservices.gash.testcenter.kz/', 'dtListOtv');

end.