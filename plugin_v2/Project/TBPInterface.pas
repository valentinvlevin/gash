(**
  Plug-in API interfaces
  Provides access to accounts, folders, messages, etc.

  http://www.ritlabs.com
  Copyright (c) 2005-2011 Ritlabs SRL. All rights reserved.
*)

unit TBPInterface;

{$DEFINE ALLOW_VCL}

//{$I ..\SRC\Defines.INC}



interface

uses
  Classes, ActiveX;

const
  errCannotOpenFolder    = -1;
  errCannotWriteFolder   = -2;
  errWriteFolder         = -3;
  errCannotCopy          = -4;
  errCannotReadMsg       = -5;

  {tbeSettings            = $00000001;
  tbeAccountSettings     = $00000002;
  tbeAccountActivity     = $00000004;
  tbeFolderSettings      = $00000008;
  tbeFolderActivity      = $00000010;
  tbeViewerCreate        = $00000020;
  tbeViewerClose         = $00000040;
  tbeEditorCreate        = $00000080;
  tbeEditorClose         = $00000100;}

  SIID_TBPMacroDataProvider           = '{9DD91B89-A551-4180-8A81-2CCF584CD4BF}';
  SIID_TBPEventNotificator            = '{4F831F85-47C6-4C5C-8B1E-4FED8E3F2D1E}';
  SIID_TBPCursor                      = '{972B42D3-0481-4926-A2F2-3EF79A61B859}';
  SIID_TBPMessage                     = '{87F58F3A-C4CC-4B9B-9B98-CBEC5404DB29}';
  SIID_TBPMessageTags                 = '{D82EBD58-EF4F-47F7-8265-CBD6455C6E16}';
  SIID_TBPMessageFilter               = '{1D904026-DD2F-4C3C-9F7F-AAB6F4F318D3}';
  SIID_TBPMessageList                 = '{A18F7033-9AF3-4E58-A0EB-5A40B0246BE4}';
  SIID_TBPFolder                      = '{67D0A3E1-A1EB-4C1D-99DF-FEAEB93F1AF7}';
  SIID_TBPCoreBridge                  = '{91CF943F-ABC2-422B-AFA1-50DE9D743759}';
  SIID_TBPAccount                     = '{C97577E4-98DB-4DBC-A85A-EE04A64FD876}';
  SIID_TBPMenu                        = '{B99B79E3-AB6F-4AF1-B485-892EDE954433}';
  SIID_TBPViewer                      = '{7FE16B6C-49AD-441A-8726-E106D7735407}';
  SIID_TBPMessageStructure            = '{D6936721-6F65-4CF7-B659-2BF1B31183AE}';
  SIID_TBPMessagePart                 = '{2C70DD26-7FE9-410A-911C-C3D7E1605D08}';
  SIID_TBPCrypto                      = '{3FEEBCB3-1DDC-45C0-8137-6969FC19BCDE}';
  SIID_TBPMessageFrame                = '{1ADC3661-8B30-445F-ACAC-A49616314E01}';
  SIID_VerifyResult                   = '{3D39EA7E-01BD-4B9C-9565-EBE1AC5047EC}';


  IID_TBPMacroDataProvider: TGUID     = SIID_TBPMacroDataProvider ;
  IID_TBPEventNotificator: TGUID      = SIID_TBPEventNotificator  ;
  IID_TBPCursor: TGUID                = SIID_TBPCursor            ;
  IID_TBPMessage: TGUID               = SIID_TBPMessage           ;
  IID_TBPMessageTags: TGUID           = SIID_TBPMessageTags       ;
  IID_TBPMessageFilter: TGUID         = SIID_TBPMessageFilter     ;
  IID_TBPMessageList: TGUID           = SIID_TBPMessageList       ;
  IID_TBPFolder: TGUID                = SIID_TBPFolder            ;
  IID_TBPCoreBridge: TGUID            = SIID_TBPCoreBridge        ;
  IID_TBPAccount: TGUID               = SIID_TBPAccount           ;
  IID_TBPMenu: TGUID                  = SIID_TBPMenu              ;
  IID_TBPViewer: TGUID                = SIID_TBPViewer            ;
  IID_TBPMessageStructure: TGUID      = SIID_TBPMessageStructure  ;
  IID_TBPMessagePart: TGUID           = SIID_TBPMessagePart       ;
  IID_TBPCrypto: TGUID                = SIID_TBPCrypto            ;
  IID_ITBPMessageFrame: TGUID         = SIID_TBPMessageFrame      ;
  IID_VerifyResult: TGUID             = SIID_VerifyResult         ;

  (**
    MenuIDs to use with ITBPCoreBridge.GetMenuInterface
  *)
  TBP_MNID_MailerForm    = $53BE0285; //* Main form
  TBP_MNID_AddressBook   = $C580F6C7; //* Address book
  TBP_MNID_MsgListViewer = $D25C813A; //* Message list viewer
  TBP_MNID_MsgEditor     = $0F5A78A8; //* Message editor

  (**
    Menu types (containers)
  *)
  TBP_MNTY_Invalid    = -1; //* Invalid menu type
  TBP_MNTY_Collection = 0;  //* Collection of menus, toolbars, popups and shortcuts
  TBP_MNTY_Menubar    = 1;  //* Main menu
  TBP_MNTY_Toolbar    = 2;  //* Toolbar
  TBP_MNTY_PopupMenu  = 3;  //* Popup menu
  TBP_MNTY_Statusbar  = 4;  //* Statusbar
  TBP_MNTY_Shortcuts  = 5;  //* Shortcuts collection

  (**
    Menu types (items)
  *)
  TBP_MNTY_Unknown    = 6;  //* Unknown type (used as error indication)
  TBP_MNTY_Null       = 7;
  TBP_MNTY_Boolean    = 8;  //* Check box
  TBP_MNTY_Integer    = 9;  //* Integer input
  TBP_MNTY_String     = 10; //* String input
  TBP_MNTY_Select     = 11;
  TBP_MNTY_SelectMultiple = 12;
  TBP_MNTY_Trigger    = 13; // Menu item or toolbar button
  TBP_MNTY_Font       = 14;
  TBP_MNTY_Color      = 15;
  TBP_MNTY_Separator  = 16; // Separator of menu items

  (**
    EventIDs ised with RegisterNotification and UnregisterNotification methods.
  *)
  TBP_EVT_MainFormAfterCreate  = 1; //* Triggered after main form was created
  TBP_EVT_MainFormBeforeShow   = 2; //* Triggered before showing main form
  TBP_EVT_MainFormAfterShow    = 3; //* Triggered after main form was shown
  TBP_EVT_MainFormBeforeClose  = 4; //* Triggered before closing main form.
  TBP_EVT_CurAccountChanged    = 5; //* Triggered when current account selection was changed
  TBP_EVT_CurFolderChanged     = 6; //* Triggered when current folder selection was changed
  TBP_EVT_CurMessageChanged    = 7; //* Triggered when current message selection was changed
  TBP_EVT_MessageBeforeFilters = 8; //* Triggered before message filters
  TBP_EVT_MessageAfterFilters  = 9; //* Triggered after message filters
  TBP_EVT_MenuPropValChanged   = 10; //* Triggered when menu item was changed (clicked)

  (**
    Indexes for InData parameter (all events)
  *)
  TBP_AllEvtIn_Parameters      = 1; //* ITBPDataProvider interface used when notification was registered

  (**
    Indexes for InData parameter
    (TBP_EVT_MessageBeforeFilters and TBP_EVT_MessageAfterFilters events)
  *)
  TBP_FltEvtIn_Message         = 2; //* (ITBPMessage) Interface of message being processed be filters
  TBP_FltEvtIn_TypeIncoming    = 3; //* (Boolean) Incoming message
  TBP_FltEvtIn_TypeOutgoing    = 4; //* (Boolean) Outgoing message
  TBP_FltEvtIn_TypeRead        = 5; //* (Boolean) Read messages
  TBP_FltEvtIn_TypeReplied     = 6; //* (Boolean) Replied messages
  TBP_FltEvtIn_WasProcessedByPlugin = 7; //* (Boolean) Processed by plugin
  TBP_FltEvtIn_WasProcessedByFilter = 8; //* (Boolean) Processed by filter
  TBP_FltEvtIn_WasDeleted      =  9; //* (Boolean) Deleted by filter
  TBP_FltEvtIn_InvokedManual   = 10; //* (Boolean) Filter was manually invoked
  TBP_FltEvtIn_HotkeyStarted   = 11; //* (Boolean) Filter was ivoked by hot-key
  TBP_FltEvtIn_ManualOnly      = 12; //* (Boolean) Run only manual filters
  TBP_FltEvtIn_TestOnly        = 13; //* (Boolean) Don't do actual filtering (only test conditions)

  (**
    Indexes for InData parameter
    (TBP_EVT_MenuPropValChanged event)
  *)
  TBP_MnuEvtIn_Item           = 2; //* (ITBPMenu) Interface of menu element whose properties was changed
  TBP_MnuEvtIn_PropId         = 3; //* (Integer) Property identifier
  TBP_MnuEvtIn_SubPropId      = 4; //* (Integer) Sub-property identifier



type
  // IInterface type was introduced starting from Delphi 6
  // so we must declare it for earlier versions of Delphi.
  {$IFDEF VER100} // Delphi 3
  IInterface = IUnknown;
  {$ENDIF}
  {$IFDEF VER120} // Delphi 4
  IInterface = IUnknown;
  {$ENDIF}
  {$IFDEF VER130} // Delphi 5
  IInterface = IUnknown;
  {$ENDIF}

  // Forward declarations
  ITBPMessageStructure = interface;
  ITBPFolder = interface;
  ITBPAccount = interface;
  ITBPAddressList = interface;
  ITBPAddrBookContact = interface;
  ITBPAddrBookGroup = interface;
    
  (**
    Interface that provides access to signature verification results.
  *)
  IVerifyResult = interface [SIID_VerifyResult]

    (**
      Gets signature verification result in VerifyResult.
      SIGN_* constants are used as verification results.
      @param VerifyResult [out] Buffer in which verification result will be
                                stored.
      @return S_OK if successful
              E_FAIL in case of failure
    *)
    function GetVerifyResult(var VerifyResult: Cardinal): HRESULT; stdcall;

    (**
      Returns the number of persons which sign the message.
      @param Count [out] Buffer in which number of persons will be stored.
      @return S_OK if successful
              E_FAIL in case of failure      
    *)
    function GetSignatureCount(var Count: Cardinal): HRESULT; stdcall;

    (**
      Returns in output stream information about person which sign message.
      @param Index Index of person which sign message, where 0 is the index of
                   the first person, 1 is the index of the second and
                   so on.
      @param AType Data type which must be stored in output stream. Use vrc*
                   constants for this parameter.
      @param Output Interface of stream for resulting information.
      @return S_OK if successful
              E_INVALIDARG if provided arguments are invalid
              E_FAIL in case of failure
    *)
    function GetSignatureInfo(const Index: Cardinal; const AType: Cardinal;
      const Output: ISequentialStream): HRESULT; stdcall;

    (**
      Returns properties of certificate of person which sign message.
      @param ACertificateIndex Index of certificate, where 0 is the index of
                               the first certificate, 1 is the index of the
                               second and so on.
      @param APropertyType Type of resulting value. Use cp* constants for this
                           parameter.
      @param APropertyIndex Index of property (reserved for future use)
      @param AAttributeOID Object identifier of element (reserved for future use)
      @param Output Interface of stream for resulting information.
      @return S_OK if successful
              E_INVALIDARG if provided arguments are invalid
              E_FAIL in case of failure
    *)  
    function GetCertificateProperty(const ACertificateIndex: Cardinal;
      const APropertyType: Cardinal; const APropertyIndex: Cardinal;
      const AAttributeOID: PChar; const Output: ISequentialStream): HRESULT; stdcall;
  end;

  (**
    Interface that provides access to cryptographic services of host application.
  *)
  ITBPCrypto = interface [SIID_TBPCrypto]

    (**
      Creates digital signature for given data.
      @param Senders Null terminated string with the list of senders which sign
                     data. Addresses in the list must be separated with CR/LF
                     pair.
      @param Data Interface of stream with data that must be signed.
      @param Flags Flags combination which determine signature parameters.
                   (reserved for futere use)
      @param OutStream Interface of stream for resulting signature in PKCS#7
                       format (SignedData package with empty eContent).
      @param Account Interface of account which must be uses as sorce of
                     certificates. Pass nil to use default account.
      @return S_OK if successful
              E_INVALIDARG if provided arguments are invalid
              E_FAIL in case of failure
    *)
    function SignData(const Senders: PChar; const Data: IStream;
      const Flags: Cardinal; const OutStream: ISequentialStream;
      const Account: ITBPAccount): HRESULT; stdcall;

    (**
      Check digital signature for given data.
      Verify results will be returned as IVerifyResult interface.
      @param Data Interface of stream with data which was signed.
      @param Signature Interface of stream with digital signature.
      @param VerifyResult [out] Buffer in which interface pointer will be
                                stored. In case of failure it is set to nil.
      @param Account Interface of account which must be uses as sorce of
                     certificates. Pass nil to use default account.
      @return S_OK if successful
              E_INVALIDARG if provided arguments are invalid
              E_FAIL in case of failure
    *)
    function VerifyData(const Data: IStream; const Signature: IStream;
      out VerifyResult: IVerifyResult;
      const Account: ITBPAccount): HRESULT; stdcall;

    (**
      Encrypts given data with specified parameters.
      @param Senders Null terminated string with the list of senders. Addresses
                     in the list must be separated with CR/LF pair.
                     This parameter is mandatory for algorithms which require
                     sender's private key (Diffie-Hellmann for example).
                     This parameter is optional for all other algorithms
                     (RSA or ElGamal for example) and can contain nil.
      @param Recipients Null terminated string with the list of recipients
                        which can decrypt data. Addresses in the list must be
                        separated with CR/LF pair.
      @param Flags Flags combination which determine encryption parameters.
                   (reserved for futere use)
      @param Data Interface of stream with input data to be encrypted.
      @param OutStream Interface of stream for encrypted data.
      @param Account Interface of account which must be uses as sorce of
                     certificates. Pass nil to use default account.
      @return S_OK if successful
              E_INVALIDARG if provided arguments are invalid
              E_FAIL in case of failure
    *)
    function EncryptData(const Senders, Recipients: PChar; const Flags: Cardinal;
      const Data: IStream; const OutStream: ISequentialStream;
      const Account: ITBPAccount): HRESULT; stdcall;

    (**
      Decrypts given data.
      Private key is required to properly decript data.
      @param Data Interface of stream with encrypted data.
      @param OutStream Interface of stream for decrypted data.
      @param Account Interface of account which must be uses as sorce of
                     certificates. Pass nil to use default account.      
      @return S_OK if successful
              E_INVALIDARG if provided arguments are invalid
              E_FAIL in case of failure
    *)
    function DecryptData(const Data: IStream;
      const OutStream: ISequentialStream;
      const Account: ITBPAccount): HRESULT; stdcall;

  end;

  ITBPMacroDataProvider = interface [SIID_TBPMacroDataProvider]
    function GetDataByID(ID: Integer; B: Pointer; BSize: Integer): Integer; stdcall;
    function SetDataByID(ID: Integer; B: Pointer; BSize: Integer): Integer; stdcall;
    function GetIntValue(ID: Integer): Integer; stdcall;
    function SetIntValue(ID, Value: Integer): Integer; stdcall;
    function GetIDType(ID: Integer): Integer; stdcall;
    function ItemCount: Integer; stdcall;
    function ExecuteMacro(AMacro: Pointer; MaxLen: Integer;
      const InData, OutData: ITBPMacroDataProvider): HRESULT; stdcall;
  end;

  (**
    Interface that provides access to the container of ANSI and Unicode
    strings.
  *)
  ITBPStringProvider = interface ['{038E3490-9ACB-4E81-9DFF-03A594E541F3}']

    (**
      Gets value of String with given ID into buffer
      TBPHelpers unit contains TBPGetStr, TBPGetStrEx, TBPGetStrDef functions
      to get this value as string.
      @param ID Identifier of the String
      @param P Pointer to buffer for the resulting String
      @param MaxStringLenChars Maximum String length in characters which can
                               be stored in buffer
      @param StringLenChars [out] A buffer in which to return actual size of
                                  the String in characters. Set to 0 if
                                  String with such ID doesn't exist.
      @return S_OK if successful
              E_INVALIDARG if ID is invalid or String with such ID
                           doesn't exist
              TYPE_E_BUFFERTOOSMALL if supplied buffer is too small to get
                                    whole string
              E_FAIL in case of failure
    *)
    function GetString(const ID: Integer; const P: PChar;
      const MaxStringLenChars: Cardinal;
      out StringLenChars: Cardinal): HRESULT; stdcall;

    (**
      Sets value of String with given ID
      @param ID  Identifier of the String
      @param Value Pointer to NULL terminated buffer with value of the String
      @return S_OK if successful
              E_INVALIDARG if ID is invalid or String with such ID
                           doesn't exist
              E_ACCESSDENIED if string container is read-only
              E_FAIL in case of failure
    *)
    function SetString(const ID: Integer; const Value: PChar): HRESULT; stdcall;

    (**
      Gets value of Unicode String with given ID into buffer
      TBPHelpers unit contains TBPGetWStr, TBPGetWStrEx, TBPWGetStrDef
      functions to get this value as string.
      @param ID Identifier of the String
      @param P Pointer to buffer for the resulting String
      @param MaxStringLenChars Maximum String length in characters which can
                               be stored in buffer
      @param StringLenChars [out] A buffer in which to return actual size of
                                  the String in characters. Set to 0 if
                                  String with such ID doesn't exist.
      @return S_OK if successful
              E_INVALIDARG if ID is invalid or String with such ID
                           doesn't exist
              TYPE_E_BUFFERTOOSMALL if supplied buffer is too small to get
                                    whole string
              E_FAIL in case of failure
    *)
    function GetWidestring(const ID: Integer; const P: PWideChar;
      const MaxStringLenChars: Cardinal;
      out StringLenChars: Cardinal): HRESULT; stdcall;

    (**
      Sets value of Unicode String with given ID
      @param ID  Identifier of the String
      @param Value Pointer to NULL terminated buffer with value of the String
      @return S_OK if successful
              E_INVALIDARG if ID is invalid or String with such ID
                           doesn't exist
              E_ACCESSDENIED if string container is read-only
              E_FAIL in case of failure
    *)
    function SetWidestring(const ID: Integer; const Value: PWideChar): HRESULT; stdcall;

    (**
      Copies the contents of another, similar interface.
      Call Assign to copy the properties or other attributes of one
      interface from another.
      @param Source Source interface from which data will be copied
      @return S_OK if successful
              E_INVALIDARG if Source is invalid
              E_ACCESSDENIED if string container is read-only
              E_FAIL in case of failure
    *)
    function Assign(const Source: IInterface): HRESULT; stdcall;

    (**
      Loads the contents from stream.
      Call LoadFromStream to load the properties or other attributes from
      stream specified by Stream.
      @param Stream Stream interface to load data from
      @return S_OK if successful
              E_INVALIDARG if Stream is invalid
              E_ACCESSDENIED if string container is read-only
              E_FAIL in case of failure
    *)
    function LoadFromStream(const Stream: IStream): HRESULT; stdcall;

    (**
      Saves the contents to stream.
      Call SaveToStream to save the properties or other attributes to
      stream specified by Stream.
      @param Stream Stream interface to save data to
      @return S_OK if successful
              E_INVALIDARG if Stream is invalid
              E_FAIL in case of failure
    *)
    function SaveToStream(const Stream: IStream): HRESULT; stdcall;

  end;

  (**
    Interface that provides access to the container of values of different
    types. This interface is inherited from ITBPStringProvider and as such
    also provides access to ANSI and Unicode strings.
  *)
  ITBPDataProvider = interface(ITBPStringProvider) ['{AF195BAD-D158-4C0E-B962-784158A3AE32}']

    (**
      Gets value of Integer type with given ID into buffer
      @param ID Identifier of the Integer
      @param Value [out] A buffer in which to return value of the Integer
      @return S_OK if successful
              E_INVALIDARG if ID is invalid or Integer with such ID
                           doesn't exist
              E_FAIL in case of failure
    *)
    function GetInteger(const ID: Integer; out Value: Integer): HRESULT; stdcall;

    (**
      Sets value of Integer type with given ID
      @param ID  Identifier of the Integer
      @param Value Value of the Integer to be set
      @return S_OK if successful
              E_INVALIDARG if ID is invalid or Integer with such ID
                           doesn't exist
              E_ACCESSDENIED if data container is read-only
              E_FAIL in case of failure
    *)
    function SetInteger(const ID: Integer; const Value: Integer): HRESULT; stdcall;

    (**
      Gets value of 64 bit Integer type with given ID into buffer
      @param ID Identifier of the 64 bit Integer
      @param Value [out] A buffer in which to return value of the 64 bit Integer
      @return S_OK if successful
              E_INVALIDARG if ID is invalid or 64 bit Integer with such ID
                           doesn't exist
              E_FAIL in case of failure
    *)
    function GetInt64(const ID: Integer; out Value: Int64): HRESULT; stdcall;

    (**
      Sets value of 64 bit Integer type with given ID
      @param ID  Identifier of the 64 bit Integer
      @param Value Value of the 64 bit Integer to be set
      @return S_OK if successful
              E_INVALIDARG if ID is invalid or 64 bit Integer with such ID
                           doesn't exist
              E_ACCESSDENIED if data container is read-only
              E_FAIL in case of failure
    *)
    function SetInt64(const ID: Integer; const Value: Int64): HRESULT; stdcall;

    (**
      Gets value of Boolean type with given ID into buffer
      @param ID Identifier of the Boolean
      @param Value [out] A buffer in which to return value of the Boolean
      @return S_OK if successful
              E_INVALIDARG if ID is invalid or Boolean with such ID
                           doesn't exist
              E_FAIL in case of failure
    *)
    function GetBoolean(const ID: Integer; out Value: LongBool): HRESULT; stdcall;

    (**
      Sets value of Boolean type with given ID
      @param ID  Identifier of the Boolean
      @param Value Value of the Boolean to be set
      @return S_OK if successful
              E_INVALIDARG if ID is invalid or Boolean with such ID
                           doesn't exist
              E_ACCESSDENIED if data container is read-only
              E_FAIL in case of failure
    *)
    function SetBoolean(const ID: Integer; const Value: LongBool): HRESULT; stdcall;

    (**
      Gets value of Float type with given ID into buffer
      @param ID Identifier of the Float
      @param Value [out] A buffer in which to return value of the Float
      @return S_OK if successful
              E_INVALIDARG if ID is invalid or Float with such ID
                           doesn't exist
              E_FAIL in case of failure
    *)
    function GetFloat(const ID: Integer; out Value: Double): HRESULT; stdcall;

    (**
      Sets value of Float type with given ID
      @param ID  Identifier of the Float
      @param Value Value of the Float to be set
      @return S_OK if successful
              E_INVALIDARG if ID is invalid or Float with such ID
                           doesn't exist
              E_ACCESSDENIED if data container is read-only
              E_FAIL in case of failure
    *)
    function SetFloat(const ID: Integer; const Value: Double): HRESULT; stdcall;

    (**
      Gets value of Pointer type with given ID into buffer
      @param ID Identifier of the Pointer
      @param Value [out] A buffer in which to return value of the Pointer
      @return S_OK if successful
              E_INVALIDARG if ID is invalid or Pointer with such ID
                           doesn't exist
              E_FAIL in case of failure
    *)
    function GetPointer(const ID: Integer; out Value: Pointer): HRESULT; stdcall;

    (**
      Sets value of Pointer type with given ID
      @param ID  Identifier of the Pointer
      @param Value Value of the Pointer to be set
      @return S_OK if successful
              E_INVALIDARG if ID is invalid or Pointer with such ID
                           doesn't exist
              E_ACCESSDENIED if data container is read-only
              E_FAIL in case of failure
    *)
    function SetPointer(const ID: Integer; const Value: Pointer): HRESULT; stdcall;

    (**
      Gets value of Interface type with given ID into buffer
      @param ID Identifier of the Interface
      @param Value [out] A buffer in which to return value of the Interface
      @return S_OK if successful
              E_INVALIDARG if ID is invalid or Interface with such ID
                           doesn't exist
              E_FAIL in case of failure
    *)
    function GetInterface(const ID: Integer; out Value: IInterface): HRESULT; stdcall;

    (**
      Sets value of Interface type with given ID
      @param ID  Identifier of the Interface
      @param Value Value of the Interface to be set
      @return S_OK if successful
              E_INVALIDARG if ID is invalid or Interface with such ID
                           doesn't exist
              E_ACCESSDENIED if data container is read-only
              E_FAIL in case of failure
    *)
    function SetInterface(const ID: Integer; const Value: IInterface): HRESULT; stdcall;

  end;

  (**
    Interface provided by plugin to receive notifications.
    This interface is used with ITBPCoreBridge.RegisterNotification and
    ITBPCoreBridge.UnregisterNotification methods.
  *)
  ITBPEventNotificator = interface [SIID_TBPEventNotificator]

    (**
      This method is invoked when event for which plugin was registered
      occure. Wrap method implementation in try/except (try/catch)
      statement to prevent exceptions from leaving plugin bounds.
      @param EventID Identifier of event (TBP_EVT_* constants)
      @param InData Container to pass input data for this event.
                    This parameter can be nil.
      @param OutData Container to pass output data for this event.
                     This parameter can be nil.
      @return S_OK if event was successfully handled
              E_FAIL in case of failure
    *)
    function Notify(const EventID: Integer;
      const InData, OutData: ITBPDataProvider): HRESULT; stdcall;

  end;

  (* OBSOLETE Probably will be removed *)
  {ITBPCursor = interface [SIID_TBPCursor]
    function Next: HRESULT; stdcall;
    function GetDataProvider(out Item: ITBPDataProvider): HRESULT; stdcall;
  end;}

  (**
    Interface that allows to access and manipulate message tags.
    Use GetWidestring to get list of all tags.
    Use SetWidestring to replace all tags with the new list.
    Tags in list are separated with semicolon (";").
  *)
  ITBPMessageTags = interface(ITBPStringProvider) [SIID_TBPMessageTags]

    (**
      Adds list of tags to existing tags.
      Tags in list are separated with semicolon (";").
    *)
    function AddTags(const Tags: PWideChar): HRESULT; stdcall;

    (**
      Deletes list of tags from existing tags.
      Tags in list are separated with semicolon (";").
    *)
    function DeleteTags(const Tags: PWideChar): HRESULT; stdcall;

  end;

  (**
    UNDER CONSTRUCTION There are methods to be added
    Interface that provides access to main properties of the message.
    This properties are stored in message base index and can be quickly
    accessed. It is recommended to use this interface to get info about
    message when possible because ITBPMessageStructure is much more slowly.
    mmx* constants are used with this interface.

    This interface also provides methods to perform common operations with
    message such as reply, redirect, copy to folder, etc.
  *)
  ITBPMessage = interface(ITBPStringProvider) [SIID_TBPMessage]

    (**
      Gets interface which allow to get more extensive information about the
      message.
      This interface is useful to detrmine structure of the message and
      the parameters of it's parts.
      @param MessageStructure [out] Buffer in which interface pointer will be
                                    stored. In case of unsuccess this pointer
                                    is set to nil.
      @return S_OK if successful
              E_FAIL in case of failure
    *)
    function GetStructure(
      out MessageStructure: ITBPMessageStructure): HRESULT; stdcall;

    (**
      Makes reply to that message using specified template.
      @param Template Template to be used when creating reply message.
      @param SendImmediately If True resulting message will be immediately
                             sent, if False it will be stored in Outbox.
      @return S_OK if successful
              E_FAIL in case of failure
    *)
    function MakeReply(const Template: PWideChar;
      const SendImmediately: LongBool): HRESULT; stdcall;

    (**
      Makes forward of that message using specified template.
      @param Template Template to be used when creating forward message.
      @param Recipient Recipient to which message will be forwarded.
                       Additinal recipients can be specified using
                       %TO, %CC, %BCC macros in template.
      @param SendImmediately If True resulting message will be immediately
                             sent, if False it will be stored in Outbox.
      @return S_OK if successful
              E_FAIL in case of failure
    *)
    function MakeForward(const Template: PWideChar; const Recipient: PWideChar;
      const SendImmediately: LongBool): HRESULT; stdcall;

    (**
      Makes redirect of that message to specified recipient.
      @param Recipient Recipient to which message will be redirected.
      @param SendImmediately If True resulting message will be immediately
                             sent, if False it will be stored in Outbox.
      @return S_OK if successful
              E_FAIL in case of failure
    *)
    function MakeRedirect(const Recipient: PWideChar;
      const SendImmediately: LongBool): HRESULT; stdcall;

    (**
      Makes new message based on the current one using specified template.
      @param Template Template to be used when creating new message.
      @param Recipient Recipient to which new message will be sent.
                       Additinal recipients can be specified using
                       %TO, %CC, %BCC macros in template.
      @param SendImmediately If True resulting message will be immediately
                             sent, if False it will be stored in Outbox.
      @return S_OK if successful
              E_FAIL in case of failure
    *)
    function MakeNewMessage(const Template: PWideChar;
      const Recipient: PWideChar;
      const SendImmediately: LongBool): HRESULT; stdcall;

    (**
      Gets interface of folder which contains this message.
      @param Folder [out] Buffer in which interface pointer will be stored.
                          In case of failure it is set to nil.
      @return S_OK if successful
              E_FAIL in case of failure
    *)
    function GetParentFolder(out Folder: ITBPFolder): HRESULT; stdcall;

    (**
      Copies message to folder specified by interface.
      @param Folder Interface of folder to which message must be copied.
      @return S_OK if successful
              E_INVALIDARG if specified folder is invalid
              E_FAIL in case of failure
    *)
    function CopyToFolder(const Folder: ITBPFolder): HRESULT; stdcall;

    (**
      Copies message to folder specified by full name.
      @param FolderFullName Full name (with path) of folder to which message
                            must be copied.
                            For example: \\Account\Folder\SubFolder
      @return S_OK if successful
              E_INVALIDARG if specified folder name is invalid
              E_FAIL in case of failure
    *)
    function CopyToFolderByName(const FolderFullName: PWideChar): HRESULT; stdcall;

    (**
      Moves message to folder specified by interface. After move
      this interface must be discarded as it actualy doesn't desribe any
      message.
      @param Folder Interface of folder to which message must be moved.
      @return S_OK if successful
              E_INVALIDARG if specified folder is invalid
              E_FAIL in case of failure
    *)
    function MoveToFolder(const Folder: ITBPFolder): HRESULT; stdcall;

    (**
      Moves message to folder specified by full name. After move
      this interface must be discarded as it actualy doesn't desribe any
      message.
      @param FolderFullName Full name (with path) of folder to which message
                            must be moved.
                            For example: \\Account\Folder\SubFolder
      @return S_OK if successful
              E_INVALIDARG if specified folder name is invalid
              E_FAIL in case of failure
    *)
    function MoveToFolderByName(const FolderFullName: PWideChar): HRESULT; stdcall;

    (**
      Deletes message using settings of the host application. This is the
      same as delete message using user interface.
      @param AlternativeSettings If True alternative settings will be used
                                 (Shift + Delete key/toolbar button)
                                 if False standard settings will be used
                                 (Delete key/toolbar button)
      @return S_OK if successful
              E_FAIL in case of failure
    *)
    function DeleteMessage(const AlternativeSettings: LongBool): HRESULT; stdcall;

    (**
      Saves message content into stream without decoding.
      @param Stream Interface of stream in which message content must be
                    stored.
      @param Offset Offset from message start.
      @param Count Number of bytes to be stored.
      @return S_OK if successful
              E_INVALIDARG if specified Offset or Count are invalid
              E_FAIL in case of failure
    *)
    function SaveContentToStream(const Stream: IStream;
      const Offset, Count: Integer): HRESULT; stdcall;

    (**
      Gets message flags (msf* constants)
      @param Flags [out] Buffer in which message flags will be stored.
      @return S_OK if successful
              E_FAIL in case of failure
    *)
    function GetFlags(out Flags: Cardinal): HRESULT; stdcall;

    (**
      Sets message flags.
      Use msf* constants as flags (combime with OR).
      @param FlagsOn Flags to be set.
      @param FlagsOff Flags to be reset.
      @return S_OK if successful
              E_FAIL in case of failure
    *)
    function SetFlags(const FlagsOn, FlagsOff: Cardinal): HRESULT; stdcall;

    (**
      Gets date/time from "Date" field of message header.
      @param Date [out] Buffer in which date/time will be stored.
                        Date/time is converted to local time of current
                        system. Contains a 64-bit value representing the
                        number of 100-nanosecond intervals since
                        January 1, 1601 (UTC).
      @return S_OK if successful
              E_FAIL in case of failure
    *)
    function GetDate(out Date: Int64): HRESULT; stdcall;

    (**
      Gets date/time and time zone offset from "Date" field of message header.
      @param Date [out] Buffer in which date/time will be stored.
                        Date/time is the same as as present in message header.
                        Contains a 64-bit value representing the
                        number of 100-nanosecond intervals since
                        January 1, 1601 (UTC).
      @param TimeZoneOffset [out] Buffer in which Time Zone Offset will be
                                  stored. It's an offset from UTC in minutes.
      @return S_OK if successful
              E_FAIL in case of failure
    *)
    function GetDateEx(out Date: Int64;
      out TimeZoneOffset: Integer): HRESULT; stdcall;

    (**
      Gets date and time when message was received by mail client.
      @param Date [out] Buffer in which date/time will be stored.
                        Date/time is converted to local time of current
                        system. Contains a 64-bit value representing the
                        number of 100-nanosecond intervals since
                        January 1, 1601 (UTC).
      @return S_OK if successful
              E_FAIL in case of failure
    *)
    function GetReceiveDate(out Date: Int64): HRESULT; stdcall;

    (**
      Gets message priority.
      If Priority = 0 then message has normal priority,
      if Priority < 0 then message has low priority,
      if Priority > 0 then message has high priority.
      @param Priority [out] Buffer in which message priority will be stored.
      @return S_OK if successful
              E_FAIL in case of failure
    *)
    function GetPriority(out Priority: Integer): HRESULT; stdcall;

    (**
      Gets message size in bytes.
      @param Size [out] Buffer in which message size will be stored.
      @return S_OK if successful
              E_FAIL in case of failure
    *)
    function GetSize(out Size: Integer): HRESULT; stdcall;

    (**
    *)
    function GetTags(out Tags: ITBPMessageTags): HRESULT; stdcall;

  end;

  (**
    Interface provided by plugin to filter messages.
    This interface is used when creating filtered message list.
  *)
  ITBPMessageFilter = interface [SIID_TBPMessageFilter]

    (**
      This method is invoked for each message need to be filtered.
      If message match filter conditions this method must return True and
      if doesn't match - False.
      @param M Interface of message to be filtered.
      @return True if message match filter conditions
              False if doesn't match
    *)
    function IsMessageOK(const M: ITBPMessage): LongBool; stdcall;

  end;

  (**
    Interface provided by plugin to compare two messages.
    This interface is used when sorting list of messages.
  *)
  ITBPMessageComparator = interface ['{448950C6-F549-40EF-85F3-0F38EE3A38A1}']

    (**
      This method is invoked when sorting function need to compare two messages.
      If M1 < M2 this method must return negative value,
      if M1 > M2 this method must return positive value,
      if M1 = M2 this method must return 0 (zero).
      @param M1 Interface of first message to be compared
      @param M2 Interface of second message to be compared
      @return Negative value if M1 < M2
              positive value if M1 > M2
              0 (zero) if M1 = M2
    *)
    function CompareMessages(const M1, M2: ITBPMessage): Integer; stdcall;

  end;

  (**
    UNDER CONSTRUCTION There are methods to be added
    Interface that represents list of messages.
    There are methods to perform common list operations such as add,
    delete, sort, etc.

    Message list can have parent folder and filter assigned. This allow to
    call Update method to refresh list contents.

    There are also methods to copy/move/delete all message in the list.
  *)
  ITBPMessageList = interface [SIID_TBPMessageList]

    (**
      Indicates the number of messages in the list.
      @return Number of messages in the list.
              E_FAIL in case of failure
    *)
    function Count: Integer; stdcall;

    (**
      Gets interface of Message with given Index from the list.
      @param Index Index of Message to be returned, where 0 is the index of
                   the first Message, 1 is the index of the second and so on.
      @param Message [out] Buffer in which interface pointer will be stored.
                           In case of failure it is set to nil.
      @return S_OK if successful
              E_INVALIDARG if specified Index is invalid
              E_FAIL in case of failure
    *)
    function GetItem(const Index: Integer;
      out Message: ITBPMessage): HRESULT; stdcall;

    (**
      Sets interface of Message with given index to specified value.
      @param Index Index of Message to be set, where 0 is the index of
                   the first Message, 1 is the index of the second and so on.
      @param Message Interface of Message to be set.
      @return S_OK if successful
              E_INVALIDARG if specified Index or Message are invalid
              E_FAIL in case of failure
    *)
    function SetItem(const Index: Integer;
      const Message: ITBPMessage): HRESULT; stdcall;

    (**
      Removes all messages from list.
      This method doesn't actually delete messages, use DeleteMessages
      instead.
      @return S_OK if successful
              E_FAIL in case of failure
    *)
    function Clear: HRESULT; stdcall;

    (**
      Inserts specified Message at the end of the list.
      @param Message Interface of Message to be added.
      @return S_OK if successful
              E_INVALIDARG if specified Message is invalid
              E_FAIL in case of failure
    *)
    function Add(const Message: ITBPMessage): HRESULT; stdcall;

    (**
      Adds specified Message to the list at the position specified by Index.
      Insert adds the Message at the indicated position, shifting the Message
      that previously occupied that position, and all subsequent Messages, up.
      @param Index Position in list where message must be inseted. This
                   parameter is zero-based.
      @param Message Interface of Message to be inserted.
      @return S_OK if successful
              E_INVALIDARG if specified Index or Message are invalid
              E_FAIL in case of failure
    *)
    function Insert(const Index: Integer;
      const Message: ITBPMessage): HRESULT; stdcall;

    (**
      Removes the message at the position given by the Index parameter.
      This method doesn't actually delete messages, it only removes them from
      list.
      @param Index Index of Message to be deleted, where 0 is the index of
                   the first Message, 1 is the index of the second and so on.
      @return S_OK if successful
              E_INVALIDARG if specified Index is invalid
              E_FAIL in case of failure
    *)
    function Delete(const Index: Integer): HRESULT; stdcall;

    (**
      Swaps the position of two messages in the list.
      @param Index1 Index of the first Message to be swaped. This
                    parameter is zero-based.
      @param Index2 Index of the second Message to be swaped. This
                    parameter is zero-based.
      @return S_OK if successful
              E_INVALIDARG if specified Index1 or Index2 are invalid
              E_FAIL in case of failure
    *)
    function Exchange(const Index1, Index2: Integer): HRESULT; stdcall;

    (**
      Changes the position of message in the list.
      Call Move to move the message at the position CurIndex so that it
      occupies the position NewIndex.
      @param CurIndex Current position of the message in list. This
                      parameter is zero-based.
      @param NewIndex New desired position of the message in list. This
                      parameter is zero-based.
      @return S_OK if successful
              E_INVALIDARG if specified CurIndex or NewIndex are invalid
              E_FAIL in case of failure
    *)
    function Move(const CurIndex, NewIndex: Integer): HRESULT; stdcall;

    (**
      Performs a QuickSort on the messages in the list.
      Sorting order is defined by Comparator interface.
      @param Comparator Interface which privide method to compare two
                        messages and thus giving sorting order.
      @return S_OK if successful
              E_FAIL in case of failure
    *)
    function Sort(const Comparator: ITBPMessageComparator): HRESULT; stdcall;

    (**
      Gets interface of folder to which list is linked to.
      When message list is linked to folder it is possible to call Update
      to refresh contents of the list.
      @param Folder [out] Buffer in which interface pointer will be stored.
                          If message list is not linked to folder it is set
                          to nil. In case of failure it is also set to nil.
      @return S_OK if successful
              E_FAIL in case of failure
    *)
    function GetParentFolder(out Folder: ITBPFolder): HRESULT; stdcall;

    (**
      Links/unlinks message list to folder.
      When message list is linked to folder it is possible to call Update
      to refresh contents of the list.
      @param Folder Interface of folder to which list must be linked.
                    If this parameter is nil then list will not be linked
                    to any folder.
      @return S_OK if successful
              E_INVALIDARG if specified Folder is invalid
              E_FAIL in case of failure
    *)
    function SetParentFolder(const Folder: ITBPFolder): HRESULT; stdcall;

    (**
      Gets interface of filter to which list is linked to.
      When message list is linked to filter the result of Update call
      will depend on this filter.
      @param Filter [out] Buffer in which interface pointer will be stored.
                          If message list is not linked to filter it is set
                          to nil. In case of failure it is also set to nil.
      @return S_OK if successful
              E_FAIL in case of failure
    *)
    function GetFilter(out Filter: ITBPMessageFilter): HRESULT; stdcall;

    (**
      Links/unlinks message list to filter.
      When message list is linked to filter the result of Update call
      will depend on this filter.
      @param Filter Interface of filter to which list must be linked.
                    If this parameter is nil then list will not be linked
                    to any filter.
      @return S_OK if successful
              E_INVALIDARG if specified Filter is invalid
              E_FAIL in case of failure
    *)
    function SetFilter(const Filter: ITBPMessageFilter): HRESULT; stdcall;

    (**
      Refreshes contents of the list.
      This method use information about folder and filter to which
      message list is linked. If list is not linked to folder then empty
      list will be returned. If list is not linked to filter then unfiltered
      list will be returned.
      @return S_OK if successful
              S_FALSE if message list is not linked to folder
              E_FAIL in case of failure
    *)
    function Update: HRESULT; stdcall;

    (**
      Creates subset of current message list.
      When current list already has a filter assigned then new list will have
      compound filter. This new filter is the AND combination of current
      filter and Filter parameter.
      @param Filter Interface of filter for creating subset of current list.
      @param MessageList [out] Buffer in which interface pointer if new list
                               will be stored. In case of failure it is set
                               to nil.
      @return S_OK if successful
              E_FAIL in case of failure
    *)
    function GetSubset(const Filter: ITBPMessageFilter;
      out MessageList: ITBPMessageList): HRESULT; stdcall;

    (**
      Copies all messages in list to folder specified by interface.
      @param Folder Interface of folder to which messages must be copied.
      @return S_OK if successful
              E_INVALIDARG if specified folder is invalid
              E_FAIL in case of failure
    *)
    function CopyToFolder(const Folder: ITBPFolder): HRESULT; stdcall;

    (**
      Copies all messages in list to folder specified by full name.
      @param FolderFullName Full name (with path) of folder to which messages
                            must be copied.
                            For example: \\Account\Folder\SubFolder
      @return S_OK if successful
              E_INVALIDARG if specified folder name is invalid
              E_FAIL in case of failure
    *)
    function CopyToFolderByName(const FolderFullName: PWideChar): HRESULT; stdcall;

    (**
      Moves all messages in list to folder specified by interface. After
      successful move message list will be empty. If some messages cannot be
      moved for some reason they will remain in list.
      @param Folder Interface of folder to which messages must be moved.
      @return S_OK if successful
              E_INVALIDARG if specified folder is invalid
              E_FAIL in case of failure
    *)
    function MoveToFolder(const Folder: ITBPFolder): HRESULT; stdcall;

    (**
      Moves all messages in list to folder specified by full name. After
      successful move message list will be empty. If some messages cannot be
      moved for some reason they will remain in list.
      @param FolderFullName Full name (with path) of folder to which messages
                            must be moved.
                            For example: \\Account\Folder\SubFolder
      @return S_OK if successful
              E_INVALIDARG if specified folder name is invalid
              E_FAIL in case of failure
    *)
    function MoveToFolderByName(const FolderFullName: PWideChar): HRESULT; stdcall;

    (**
      Deletes all messages in list using settings of the host application.
      This is the same as delete messages using user interface. After
      successful delete message list will be empty. If some messages cannot
      be deleted for some reason they will remain in list.
      @param AlternativeSettings If True alternative settings will be used
                                 (Shift + Delete key/toolbar button)
                                 if False standard settings will be used
                                 (Delete key/toolbar button)
      @param DeleteParked If True messages with Parked flag set will be
                          deleted, if False messages with Parked flag set
                          will not be deleted and remain in list.
      @return S_OK if successful
              E_FAIL in case of failure
    *)
    function DeleteMessages(const AlternativeSettings, DeleteParked: LongBool): HRESULT; stdcall;

    (**
      Sets flags for all messages in the list
      Use msf* constants as flags (combime with OR).
      @param FlagsOn Flags to be set.
      @param FlagsOff Flags to be reset.
      @return S_OK if successful
              E_FAIL in case of failure
    *)
    function SetFlags(const FlagsOn, FlagsOff: Cardinal): HRESULT; stdcall;

  end;

  (**
    UNDER CONSTRUCTION There are methods to be added
    Interface that provides access to properties of the folder.

    This interface also provides methods to access and create subfolders.
  *)
  ITBPFolder = interface(ITBPDataProvider) [SIID_TBPFolder]

    (**
      Indicates the number of subfolders in this folder.
      @return Number of subfolders.
              E_FAIL in case of failure
    *)
    function SubFolderCount: Integer; stdcall;

    (**
      Gets interface of subfolder with given Index.
      @param Index Index of subfolder to be returned, where 0 is the index of
                   the first subfolder, 1 is the index of the second and
                   so on.
      @param Folder [out] Buffer in which interface pointer will be stored.
                          In case of failure it is set to nil.
      @return S_OK if successful
              E_INVALIDARG if specified Index is invalid
              E_FAIL in case of failure
    *)
    function GetSubFolder(const Index: Integer;
      out Folder: ITBPFolder): HRESULT; stdcall;

    (**
      Gets interface of subfolder with given Name.
      @param Name Name of subfolder to be returned.
      @param Folder [out] Buffer in which interface pointer will be stored.
                          In case of failure it is set to nil.
      @return S_OK if successful
              E_INVALIDARG if specified Name is invalid
              E_FAIL in case of failure
    *)
    function GetSubFolderByName(const Name: PWideChar;
      out Folder: ITBPFolder): HRESULT; stdcall;

    (**
      Creates interface of message list with messages from this folder.
      This list is linked to folder and only a snapshot of folder contents.
      It can be updated using Update method.
      If Filter parameter specified then resulting list will be linked to
      it and only message that match filter conditions will be added to list.
      @param Filter Interface of filter conditions.
                    If this parameter is nil then all messages fom this
                    folder will be added to list.
      @param MessageList [out] Buffer in which interface pointer will be stored.
                               In case of failure it is set to nil.
      @return S_OK if successful
              E_FAIL in case of failure
    *)
    function GetMessageList(const Filter: ITBPMessageFilter;
      out MessageList: ITBPMessageList): HRESULT; stdcall;

    (**
      Returns folder in which this folder is a subfolder.
      @param Folder [out] Buffer in which interface pointer will be stored.
                          In case when this folder is root level it is set
                          to nil. In case of failure it is also set to nil.
      @return S_OK if successful
              S_FALSE if this folder is root level
              E_FAIL in case of failure
    *)
    function GetParentFolder(out Folder: ITBPFolder): HRESULT; stdcall;

    (**
      Returns account in which this folder is in.
      @param Account [out] Buffer in which interface pointer will be stored.
                           In case when there is no parent account it is set
                           to nil. In case of failure it is also set to nil.
      @return S_OK if successful
              S_FALSE if there is no parent account
              E_FAIL in case of failure
    *)
    function GetParentAccount(out Account: ITBPAccount): HRESULT; stdcall;

    (**
      Returns total number of messages in this folder.
      @return Total number of messages.
    *)
    function TotalMsgs: Integer; stdcall;

    (**
      Returns number of unread messages in this folder.
      @return Number of unread messages.
    *)
    function UnreadMsgs: Integer; stdcall;

    (**
      Returns sum of number of message in all subfolders including nested.
      @return Sum of number of messages in all subfolders.
    *)
    function SubTotalMsgs: Integer; stdcall;

    (**
      Returns sum of number of unread message in all subfolders including
      nested.
      @return Sum of number of unread messages in all subfolders.
    *)
    function SubUnreadMsgs: Integer; stdcall;

    (**
      Creates subfolder with given Name in this folder.
      This name can include several hierarchy levels separated by backslash.
      Example: NewFolder\NewSubFolder
      @param Name Name of subfolder to be created.
      @param FocusOn If True new subfolder will get focus.
      @param Folder [out] Buffer in which interface pointer will be stored.
                          In case of failure it is set to nil.
      @return S_OK if successful
              E_FAIL in case of failure
    *)
    function CreateSubFolder(const Name: PWideChar; const FocusOn: LongBool;
      out Folder: ITBPFolder): HRESULT; stdcall;

  end;

  (**
    UNDER CONSTRUCTION There are methods to be added
    Interface that provides access to properties of the account.

    This interface also provides methods to access and create folders and
    messages.
  *)
  ITBPAccount = interface(ITBPDataProvider) [SIID_TBPAccount]

    (**
      Indicates the number of folders in this account.
      Only first level folders are counted.
      @return Number of folders.
              E_FAIL in case of failure
    *)
    function FolderCount: Integer; stdcall;

    (**
      Gets interface of folder with given Index.
      @param Index Index of folder to be returned, where 0 is the index of
                   the first folder, 1 is the index of the second and
                   so on.
      @param Folder [out] Buffer in which interface pointer will be stored.
                          In case of failure it is set to nil.
      @return S_OK if successful
              E_INVALIDARG if specified Index is invalid
              E_FAIL in case of failure
    *)
    function GetFolder(const Index: Integer;
      out Folder: ITBPFolder): HRESULT; stdcall;

    (**
      Gets interface of folder with given Name.
      @param Name Name of folder to be returned.
      @param Folder [out] Buffer in which interface pointer will be stored.
                          In case of failure it is set to nil.
      @return S_OK if successful
              E_INVALIDARG if specified Name is invalid
              E_FAIL in case of failure
    *)
    function GetFolderByName(const Name: PWideChar;
      out Folder: ITBPFolder): HRESULT; stdcall;

    (**
      Returns total number of messages in this account.
      This is the sum of message numbers in all folders including nested.
      @return Total number of messages.
    *)
    function TotalMsgs: Integer; stdcall;

    (**
      Returns number of unread messages in this account.
      This is the sum of unread message numbers in all folders including
      nested.
      @return Total number of messages.
    *)
    function UnreadMsgs: Integer; stdcall;

    (**
      Creates folder with given Name in this account.
      This name can include several hierarchy levels separated by backslash.
      Example: NewFolder\NewSubFolder
      @param Name Name of folder to be created.
      @param FocusOn If True new subfolder will get focus.
      @param Folder [out] Buffer in which interface pointer will be stored.
                          In case of failure it is set to nil.
      @return S_OK if successful
              E_INVALIDARG if specified Name is invalid
              E_FAIL in case of failure
    *)
    function CreateFolder(const Name: PWideChar; const FocusOn: LongBool;
      out Folder: ITBPFolder): HRESULT; stdcall;

    (**
      Makes new message using specified template.
      @param Template Template to be used when creating new message.
      @param Recipient Recipient to which new message will be sent.
                       Additinal recipients can be specified using
                       %TO, %CC, %BCC macros in template.
      @param SendImmediately If True resulting message will be immediately
                             sent, if False it will be stored in Outbox.
      @return S_OK if successful
              E_FAIL in case of failure
    *)
    function MakeNewMessage(const Template: PWideChar;
      const Recipient: PWideChar;
      const SendImmediately: LongBool): HRESULT; stdcall;

    (**
      Gets personal vCard for this account.
      @param vCard [out] Buffer in which interface pointer will be stored.
                         In case of failure it is set to nil.
      @return S_OK if successful
              E_FAIL in case of failure
    *)
    function GetPersonalVCard(out vCard: ITBPAddrBookContact): HRESULT; stdcall;

    //function RegisterNotification(): HRESULT; stdcall;
    //function UnregisterNotification(): HRESULT; stdcall;
  end;

  {ITBPViewer = interface [SIID_TBPViewer]
    //function GetMessageList(List: ITBPMessageList): HResult; stdcall;
    //function GetSelectedMessages(List: ITBPMessageList): HResult; stdcall;
    //function GetCurrentMessage(out Content: ITBPPropertyDataProvider): HResult; stdcall;
    //function GetFormMenus(out Handler: ITBPMenu): HResult; stdcall;
    //function GetFrameMenus(out Handler: ITBPMenu): HResult; stdcall;
    //function GetSelCount: Integer; stdcall;
  end;}

  (*ITBPEditor = interface ['{D394E24B-CAC6-4493-8FE7-7E2401BE77EA}']
  end;*)

  (**
    Interface that represents e-mail address.
    There are methods to get address parts
    (inherited from ITBPStringProvider).

    Use rfcadx* constants to access address parts.

    If parent address list is linked to the message it is in read-only mode
    and thus modification methods will return E_ACCESSDENIED result.
  *)
  ITBPAddress = interface(ITBPStringProvider) ['{97AFED9D-01FE-45D7-8AFE-6E6E547CC482}']

    (**
      Gets interface of address list in which address is an item.
      @param AddressList [out] Buffer in which interface pointer will be
                               stored. If there is no parent address list
                               it is set to nil. In case of failure it is
                               also set to nil.
      @return S_OK if successful
              E_FAIL in case of failure
    *)
    function GetParentAddressList(
      out AddressList: ITBPAddressList): HRESULT; stdcall;

    (**
      Gets interface of contact with which this address is associated.
      @param Contact [out] Buffer in which interface pointer will be
                           stored. If there is no contact associated with
                           this address it is set to nil. In case of failure
                           it is also set to nil.
      @return S_OK if successful
              E_FAIL in case of failure
    *)
    function GetContact(out Contact: ITBPAddrBookContact): HRESULT; stdcall;

    (**
      Sets interface of contact with which this address is associated.
      @param Contact Interaface of contact to associate this address with.
      @return S_OK if successful
              E_FAIL in case of failure
    *)
    function SetContact(const Contact: ITBPAddrBookContact): HRESULT; stdcall;

  end;

  (**
    Interface provided by plugin to compare two addresses.
    This interface is used when sorting list of addresses.
  *)
  ITBPAddressComparator = interface ['{509F4087-9E5F-496F-BE58-98222C48AFE0}']

    (**
      This method is invoked when sorting function need to compare two addresses.
      If A1 < A2 this method must return negative value,
      if A1 > A2 this method must return positive value,
      if A1 = A2 this method must return 0 (zero).
      @param A1 Interface of first address to be compared
      @param A2 Interface of second address to be compared
      @return Negative value if A1 < A2
              positive value if A1 > A2
              0 (zero) if A1 = A2
    *)
    function CompareAddresses(const A1, A2: ITBPAddress): Integer; stdcall;

  end;

  (**
    Interface that represents list of e-mail addresses.
    There are methods to perform common list operations such as add,
    delete, sort, etc.

    Use rfcadx* constants to access address parts.

    If address list is linked to message it is in read-only mode and thus
    modification methods will return E_ACCESSDENIED result.

    Single address format:
      Name Path:Mailbox@Domain Comment

    Example:
      John Smith <@batpost.com:john@example.com> (Comment)
      ---
      rfcadxName             - John Smith
      rfcadxPath             - @batpost.com
      rfcadxMailbox          - john
      rfcadxDomain           - example.com
      rfcadxComment          - (Comment)
      rfcadxTbp_DecodedName  - John Smith
        (name can be encoded like this =?windows-1251?Q?=D0=EE=EC=E0=ED?=)
      rfcadxTbp_Address      - @batpost.com:john@example.com
      rfcadxTbp_NameWithAddr -
        John Smith <@batpost.com:john@example.com> (Comment)
  *)
  ITBPAddressList = interface(ITBPStringProvider) ['{6A3B8DE5-62EE-4C16-9423-6BF20AC288CA}']

    (**
      Indicates the number of addresses in the list.
      @return Number of addresses in the list.
              E_FAIL in case of failure
    *)
    function Count: Integer; stdcall;

    (**
      Gets interface of Address with given Index from the list.
      @param Index Index of Address to be returned, where 0 is the index of
                   the first Address, 1 is the index of the second and so on.
      @param Address [out] Buffer in which interface pointer will be stored.
                           In case of failure it is set to nil.
      @return S_OK if successful
              E_INVALIDARG if specified Index is invalid
              E_FAIL in case of failure
    *)
    function GetItem(const Index: Integer;
      out Address: ITBPAddress): HRESULT; stdcall;

    (**
      Sets value of Address with given Index from specified interface.
      @param Index Index of Address to be set, where 0 is the index of
                   the first Address, 1 is the index of the second and so on.
      @param Address Interface of Address to be set.
      @return S_OK if successful
              E_INVALIDARG if specified Index or Address are invalid
              E_FAIL in case of failure
    *)
    function SetItem(const Index: Integer;
      const Address: ITBPAddress): HRESULT; stdcall;

    (**
      Removes all addresses from list.
      @return S_OK if successful
              E_ACCESSDENIED if address list is linked to message and thus in
                             read-only mode
              E_FAIL in case of failure
    *)
    function Clear: HRESULT; stdcall;

    (**
      Inserts specified Address at the end of the list.
      @param Address Interface of Address to be added.
      @return S_OK if successful
              E_INVALIDARG if specified Address is invalid
              E_FAIL in case of failure
    *)
    function Add(const Address: ITBPAddress): HRESULT; stdcall;

    (**
      Inserts specified Addresses at the end of the list.
      Addresses are in ANSI string and separated by comma or semicolon.
      @param Addresses Addresses to be added.
      @return S_OK if successful
              E_INVALIDARG if specified Addresses is invalid
              E_ACCESSDENIED if address list is linked to message and thus in
                             read-only mode
              E_FAIL in case of failure
    *)
    function AddFromStr(const Addresses: PChar): HRESULT; stdcall;

    (**
      Inserts specified Addresses at the end of the list.
      Addresses are in Unicode string and separated by comma or semicolon.
      @param Addresses Addresses to be added.
      @return S_OK if successful
              E_INVALIDARG if specified Addresses is invalid
              E_ACCESSDENIED if address list is linked to message and thus in
                             read-only mode
              E_FAIL in case of failure
    *)
    function AddFromWStr(const Addresses: PWideChar): HRESULT; stdcall;

    (**
      Adds specified Address to the list at the position specified by Index.
      Insert adds the Address at the indicated position, shifting the Address
      that previously occupied that position, and all subsequent Address, up.
      @param Index Position in list where address must be inseted. This
                   parameter is zero-based.
      @param Address Interface of Address to be inserted.
      @return S_OK if successful
              E_INVALIDARG if specified Index or Address are invalid
              E_FAIL in case of failure
    *)
    function Insert(const Index: Integer;
      const Address: ITBPAddress): HRESULT; stdcall;

    (**
      Adds specified Addresses to the list at the position specified by Index.
      Insert adds the Addresses at the indicated position, shifting the
      Address that previously occupied that position, and all subsequent
      Addresses, up.
      Addresses are in ANSI string and separated by comma or semicolon.
      @param Index Position in list where Addresses must be inseted. This
                   parameter is zero-based.
      @param Addresses Addresses to be inserted.
      @return S_OK if successful
              E_INVALIDARG if specified Index or Addresses are invalid
              E_ACCESSDENIED if address list is linked to message and thus in
                             read-only mode
              E_FAIL in case of failure
    *)
    function InsertFromStr(const Index: Integer;
      const Addresses: PChar): HRESULT; stdcall;

    (**
      Adds specified Addresses to the list at the position specified by Index.
      Insert adds the Addresses at the indicated position, shifting the
      Address that previously occupied that position, and all subsequent
      Addresses, up.
      Addresses are in Unicode string and separated by comma or semicolon.
      @param Index Position in list where Addresses must be inseted. This
                   parameter is zero-based.
      @param Addresses Addresses to be inserted.
      @return S_OK if successful
              E_INVALIDARG if specified Index or Addresses are invalid
              E_ACCESSDENIED if address list is linked to message and thus in
                             read-only mode
              E_FAIL in case of failure
    *)
    function InsertFromWStr(const Index: Integer;
      const Addresses: PWideChar): HRESULT; stdcall;

    (**
      Removes the address at the position given by the Index parameter.
      @param Index Index of address to be deleted, where 0 is the index of
                   the first address, 1 is the index of the second and so on.
      @return S_OK if successful
              E_INVALIDARG if specified Index is invalid
              E_ACCESSDENIED if address list is linked to message and thus in
                             read-only mode
              E_FAIL in case of failure
    *)
    function Delete(const Index: Integer): HRESULT; stdcall;

    (**
      Swaps the position of two addresses in the list.
      @param Index1 Index of the first address to be swaped. This
                    parameter is zero-based.
      @param Index2 Index of the second address to be swaped. This
                    parameter is zero-based.
      @return S_OK if successful
              E_INVALIDARG if specified Index1 or Index2 are invalid
              E_ACCESSDENIED if address list is linked to message and thus in
                             read-only mode
              E_FAIL in case of failure
    *)
    function Exchange(const Index1, Index2: Integer): HRESULT; stdcall;

    (**
      Changes the position of address in the list.
      Call Move to move the address at the position CurIndex so that it
      occupies the position NewIndex.
      @param CurIndex Current position of the address in list. This
                      parameter is zero-based.
      @param NewIndex New desired position of the address in list. This
                      parameter is zero-based.
      @return S_OK if successful
              E_INVALIDARG if specified CurIndex or NewIndex are invalid
              E_ACCESSDENIED if address list is linked to message and thus in
                             read-only mode
              E_FAIL in case of failure
    *)
    function Move(const CurIndex, NewIndex: Integer): HRESULT; stdcall;

    (**
      Performs a QuickSort on the addresses in the list.
      Sorting order is defined by Comparator interface.
      @param Comparator Interface which privide method to compare two
                        addresses and thus giving sorting order.
      @return S_OK if successful
              E_FAIL in case of failure
    *)
    function Sort(const Comparator: ITBPAddressComparator): HRESULT; stdcall;

    (**
      Calculates ID to get/set address parts.
      Use rfcadx* constants for PartID. Resulting ID is used with methods
      of inherited ITBPStringProvider to access desired part of desired
      address.
      @param Index Index of address we are interersted in.
      @param PartID Part ID of address we are interersted in.
      @return Identifier to be used with methods of inherited
              ITBPStringProvider.
        *)
    function CalcID(const Index, PartID: Integer): Integer; stdcall;

    (**
      Removes duplicated addresses from the list.
      Addresses are compared by Path, Mailbox and Domain. If this fields
      match for several items then only one remain in list. This will be
      the item with most data filled.
      @return S_OK if successful
              E_ACCESSDENIED if address list is linked to message and thus in
                             read-only mode
              E_FAIL in case of failure
    *)
    function RemoveDuplicates: HRESULT; stdcall;

    (**
      Gets interface of message to which list is linked to.
      When address list is linked to folder it is in read-only mode.
      @param MessageStructure [out] Buffer in which interface pointer will be
                                    stored. If address list is not linked to
                                    message it is set to nil. In case of
                                    failure it is also set to nil.
      @return S_OK if successful
              E_FAIL in case of failure
    *)
    function GetParentMessageStructure(
      out MessageStructure: ITBPMessageStructure): HRESULT; stdcall;

  end;

  (**
    UNDER CONSTRUCTION Interface that represents address book.
  *)
  ITBPAddressBook = interface(ITBPStringProvider) ['{CA1CECFD-3A45-4A82-AD35-DE5820026C9C}']

    (**
      Indicates the number of groups in address book.
      Groups are treated as plain list, to discover group nesting use
      ITBPAddrBookGroup.GetParentGroup method.
      @return Number of groups.
              E_FAIL in case of failure
    *)
    function GroupCount: Integer; stdcall;

    (**
      Gets interface of group with given Index.
      Groups are treated as plain list, to discover group nesting use
      ITBPAddrBookGroup.GetParentGroup method.
      @param Index Index of group to be returned, where 0 is the index of
                   the first group, 1 is the index of the second and
                   so on.
      @param Group [out] Buffer in which interface pointer will be stored.
                         In case of failure it is set to nil.
      @return S_OK if successful
              E_INVALIDARG if specified Index is invalid
              E_FAIL in case of failure
    *)
    function GetGroup(const Index: Integer;
      out Group: ITBPAddrBookGroup): HRESULT; stdcall;

    (**
      Indicates the number of contacts in address book.
      Contacts are treated as plain list, to discover links with groups use
      HasLink method.
      @return Number of contacts.
              E_FAIL in case of failure
    *)
    function ContactCount: Integer; stdcall;

    (**
      Gets interface of contact with given Index.
      Contacts are treated as plain list, to discover links with groups use
      HasLink method.
      @param Index Index of contact to be returned, where 0 is the index of
                   the first contact, 1 is the index of the second and
                   so on.
      @param Contact [out] Buffer in which interface pointer will be stored.
                           In case of failure it is set to nil.
      @return S_OK if successful
              E_INVALIDARG if specified Index is invalid
              E_FAIL in case of failure
    *)
    function GetContact(const Index: Integer;
      out Contact: ITBPAddrBookContact): HRESULT; stdcall;

    (**
      Indicates whether specified group and contact has link.
      That is specified contact is in specified group.
      @param Group Interface of group to check. This parameter can be nil to
                   check whether specified contact is in the root of address
                   book.
      @param Contact Interface of contact to check
      @return S_OK if contact is in group
              S_FALSE if constact is NOT in group
              E_INVALIDARG if specified Group or Contact are invalid
              E_FAIL in case of failure
    *)
    function HasLink(const Group: ITBPAddrBookGroup;
      const Contact: ITBPAddrBookContact): HRESULT; stdcall;

    (**
      Links specified group and contact.
      After successfull call contact will be in group.
      @param Group Interface of group to add contact to. This parameter can
                   be nil to add specified contact is in the root of address
                   book.
      @param Contact Interface of contact to add to group
      @return S_OK if contact was successfully added in group
              S_FALSE if constact is already in group
              E_INVALIDARG if specified Group or Contact are invalid
              E_FAIL in case of failure
    *)
    function AddLink(const Group: ITBPAddrBookGroup;
      const Contact: ITBPAddrBookContact): HRESULT; stdcall;

    (**
      Unlinks specified group and contact.
      After successfull call contact will be removed from group.
      @param Group Interface of group to remove contact from. This parameter
                   can be nil to remove specified contact from the root of
                   address book.
      @param Contact Interface of contact to remove from group
      @return S_OK if contact was successfully removed from group
              S_FALSE if constact is already NOT in group
              E_INVALIDARG if specified Group or Contact are invalid
              E_FAIL in case of failure
    *)
    function RemoveLink(const Group: ITBPAddrBookGroup;
      const Contact: ITBPAddrBookContact): HRESULT; stdcall;

    (**
      Creates group with specified Name and Handle.
      @param Name Name of group to be created
      @param Handle Handle of group to be created. This string must be unique.
                    If empty string is specified then handle will be
                    auto-generated based on group name.
      @param Group [out] Buffer in which interface pointer will be stored.
                         In case of failure it is set to nil.
      @return S_OK if successful
              E_INVALIDARG if specified Name or Handle are invalid
              E_FAIL in case of failure
    *)
    function CreateGroup(const Name, Handle: PWideChar;
      out Group: ITBPAddrBookGroup): HRESULT; stdcall;

    (**
      Creates empty contact.
      @param Contact [out] Buffer in which interface pointer will be stored.
                           In case of failure it is set to nil.
      @return S_OK if successful
              E_FAIL in case of failure
    *)
    function CreateContact(out Contact: ITBPAddrBookContact): HRESULT; stdcall;

    (**
      Deletes address book from list.
      Note: int's not safe to access properties of deleted address book.
      @param DelStorage If True then storage file(s) will also be deleted.
      @return S_OK if successful
              E_FAIL in case of failure
    *)
    function Delete(DelStorage: LongBool): HRESULT; stdcall;

    (**
      Saves changes made by SetString, SetWidestring methods.
      @return S_OK if successful
              E_FAIL in case of failure
    *)
    function SaveChanges: HRESULT; stdcall;

    (**
      Suspends repainting of address book until EndUpdate is called.
      Use this method to speed processing when major changes are made.
    *)
    procedure BeginUpdate; stdcall;

    (**
      Re-enables repainting of address book.
      Use this method to ee-enable repainting which was suspended by
      BeginUpdate method.
    *)
    procedure EndUpdate; stdcall;

  end;

  (**
    UNDER CONSTRUCTION Interface that represents address book group.
  *)
  ITBPAddrBookGroup = interface(ITBPStringProvider) ['{3316BCF3-874E-4DB9-B968-F049EA133C26}']

    (**
      Indicates the number of contacts in this group.
      @return Number of contacts.
              E_FAIL in case of failure
    *)
    function ContactCount: Integer; stdcall;

    (**
      Gets interface of contact with given Index in this group.
      @param Index Index of contact to be returned, where 0 is the index of
                   the first contact, 1 is the index of the second and
                   so on.
      @param Contact [out] Buffer in which interface pointer will be stored.
                           In case of failure it is set to nil.
      @return S_OK if successful
              E_INVALIDARG if specified Index is invalid
              E_FAIL in case of failure
    *)
    function GetContact(const Index: Integer;
      out Contact: ITBPAddrBookContact): HRESULT; stdcall;

    (**
      Gets interface of address book which contains this group.
      @param AddressBook [out] Buffer in which interface pointer will be
                               stored. In case of failure it is set to nil.
      @return S_OK if successful
              E_FAIL in case of failure
    *)
    function GetParentAddressBook(out AddressBook: ITBPAddressBook): HRESULT; stdcall;

    (**
      Gets interface of group in which this group is a child.
      @param Group [out] Buffer in which interface pointer will be stored.
                         In case of failure it is set to nil.
      @return S_OK if successful
              E_FAIL in case of failure
    *)
    function GetParentGroup(out Group: ITBPAddrBookGroup): HRESULT; stdcall;

    (**
      Makes specified group the parent of this group.
      @param Group Interface of group to make parent of this group.
      @return S_OK if successful
              E_INVALIDARG if specified Group is invalid
              E_FAIL in case of failure
    *)
    function SetParentGroup(const Group: ITBPAddrBookGroup): HRESULT; stdcall;

    (**
      Saves changes made by SetString, SetWidestring methods.
      @return S_OK if successful
              E_FAIL in case of failure
    *)
    function SaveChanges: HRESULT; stdcall;

    (**
      Deletes group.
      Note: int's not safe to access properties of deleted group.
      @return S_OK if successful
              E_FAIL in case of failure
    *)
    function Delete: HRESULT; stdcall;

    (**
      Indicates if group has sub-groups inside.
      @return True if has sub-groups
              False if hasn't sub-groups
    *)
    function HasNestedGroups: Boolean; stdcall;

  end;

  (**
    UNDER CONSTRUCTION Interface that represents address book contact.
  *)
  ITBPAddrBookContact = interface(ITBPStringProvider) ['{34E8BBAB-699E-4E42-AA09-807E6F0B91D2}']

    (**
      Gets interface of address book which contains this contact.
      @param AddressBook [out] Buffer in which interface pointer will be
                               stored. In case of failure it is set to nil.
      @return S_OK if successful
              E_FAIL in case of failure
    *)
    function GetParentAddressBook(out AddressBook: ITBPAddressBook): HRESULT; stdcall;

    (**
      Saves changes made by SetString, SetWidestring methods.
      @return S_OK if successful
              E_FAIL in case of failure
    *)
    function SaveChanges: HRESULT; stdcall;

    (**
      Indicates if contact has assigned photo.
      @return True if has photo
              False if hasn't photo
    *)
    function HasPhoto: LongBool; stdcall;


    (**
      Gets interface of stream with contact's photo.
      @param Stream [out] Buffer in which interface pointer will be
                          stored. In case of failure it is set to nil.
      @return S_OK if successful
              E_FAIL in case of failure
    *)
    function GetPhoto(out Stream: IStream): HRESULT; stdcall;

    (**
      Sets photo from stream.
      @param Stream Interface of stream from which photo must be loaded.
      @return S_OK if successful
              E_FAIL in case of failure
    *)
    function SetPhoto(const Stream: IStream): HRESULT; stdcall;

    (**
      Indicates if contact has assigned certificate.
      @return True if has photo
              False if hasn't photo
    *)
    function HasCertificate: LongBool; stdcall;

    (**
      Gets interface of stream with contact's certificate in DER format.
      @param Stream [out] Buffer in which interface pointer will be
                          stored. In case of failure it is set to nil.
      @return S_OK if successful
              E_FAIL in case of failure
    *)
    function GetCertificate(out Stream: IStream): HRESULT; stdcall;

    (**
      Sets certificate from stream in DER format.
      @param Stream Interface of stream from which certificate must be loaded.
      @return S_OK if successful
              E_FAIL in case of failure
    *)
    function SetCertificate(const Stream: IStream): HRESULT; stdcall;

    (**
      Deletes contact.
      Note: int's not safe to access properties of deleted contact.
      @return S_OK if successful
              E_FAIL in case of failure
    *)
    function Delete: HRESULT; stdcall;

  end;

  (**
    UNDER CONSTRUCTION Interface that represents element of menu/toolbar subsystem.
  *)
  ITBPMenu = interface(ITBPDataProvider) [SIID_TBPMenu]

    (**
      Indicates the number of subitems in this menu element.
      @return Number of subparts.
              E_FAIL in case of failure
    *)
    function ItemCount: Integer; stdcall;

    (**
      Gets interface of subitem with given Index.
      @param Index Index of subitem to be returned, where 0 is the index of
                   the first subitem, 1 is the index of the second and
                   so on.
      @param Item [out] Buffer in which interface pointer will be stored.
                        In case of failure it is set to nil.
      @return S_OK if successful
              E_INVALIDARG if specified Index is invalid
              E_FAIL in case of failure
    *)
    function GetItem(const Index: Integer; out Item: ITBPMenu): HRESULT; stdcall;

    (**
      Updates visual representation of this menu element.
      Most of times there is no need to call this method.
    *)
    procedure Update; stdcall;

    (**
      Inserts new subitem at the end of the list.
      @param Template Interface of subitem template. This template must be
                      filled with subitem parameters.
      @param Item [out] Buffer in which interface pointer of new subitem
                        will be stored. In case of failure it is set to nil.
      @return S_OK if successful
              E_INVALIDARG if specified Template is invalid
              E_FAIL in case of failure
    *)
    function Add(const Template: ITBPDataProvider;
      out Item: ITBPMenu): HRESULT; stdcall;

    (**
      Adds new subitem to the list at the position specified by Index.
      Insert adds subitem at the indicated position, shifting subitem
      that previously occupied that position, and all subsequent subitems, up.
      @param Index Position in list where subitem must be inseted. This
                   parameter is zero-based.
      @param Template Interface of subitem template. This template must be
                      filled with subitem parameters.
      @param Item [out] Buffer in which interface pointer of new subitem
                        will be stored. In case of failure it is set to nil.
      @return S_OK if successful
              E_INVALIDARG if specified Index or Template are invalid
              E_FAIL in case of failure
    *)
    function Insert(const Index: Integer; const Template: ITBPDataProvider;
      out Item: ITBPMenu): HRESULT; stdcall;

    (**
      Removes subitem at the position given by the Index parameter.
      @param Index Index of subitem to be deleted, where 0 is the index of
                   the first subitem, 1 is the index of the second and so on.
      @return S_OK if successful
              E_INVALIDARG if specified Index is invalid
              E_FAIL in case of failure
    *)
    function Delete(const Index: Integer): HRESULT; stdcall;

    (**
      Registers plugin handler to receive notifications about events related
      to this menu item.
      Currently only TBP_EVT_MenuPropValChanged can be used as EventID.
      @param EventID Identifier of the event to get notifications about
      @param Parameters Parameters of registered handler. Can be nil if there
                        are no parameters needed.
      @param EventNotificator Interface if plugin handler which will receive
                              notifications.
      @return S_OK if successful
              E_INVALIDARG if specified EventID or Parameters are invalid
              E_FAIL in case of failure
    *)
    function RegisterNotification(const EventID: Integer;
      const Parameters: ITBPDataProvider;
      const EventNotificator: ITBPEventNotificator): HRESULT; stdcall;

    (**
      Unregisters plugin handler to receive notifications about events with
      specified EventID.
      Arguments for this method must be exacly the same as was used with
      RegisterNotification.
      Currently only TBP_EVT_MenuPropValChanged can be used as EventID.
      @param EventID Identifier of the event to get notifications about
      @param Parameters Parameters of registered handler. Can be nil if there
                        are no parameters needed.
      @param EventNotificator Interface if plugin handler which was used to
                              receive notifications.
      @return S_OK if successful
              E_INVALIDARG if specified EventID or Parameters are invalid
              E_FAIL in case of failure
    *)
    function UnregisterNotification(const EventID: Integer;
      const Parameters: ITBPDataProvider;
      const EventNotificator: ITBPEventNotificator): HRESULT; stdcall;

{    function SubItemCount: Integer; stdcall;
    function GetItemName(Index: Integer; Buf: PChar; BufSize: Integer): Integer; stdcall;
    function GetItemAt(Index: Integer): ITBPMenu; stdcall;
    function GetItem(ItemName: PChar): ITBPMenu; stdcall;
    function IsEnabled(Index: Integer): Integer; stdcall;
    function IsVisible(Index: Integer): Integer; stdcall;
    function AddItem(Tag: Integer; Commander: ITBPMenuCommander): HResult; stdcall;
    function InsertAt(Index: Integer; Tag: Integer; ACommander: ITBPMenuCommander): HResult; stdcall;
    function InsertBefore(ItemName: PChar; Tag: Integer; Commander: ITBPMenuCommander): HResult; stdcall;
    function InsertAfter(ItemName: PChar; Tag: Integer; Commander: ITBPMenuCommander): HResult; stdcall;
    function DeleteItemAt(Index: Integer): HResult; stdcall;
    function DeleteItem(ItemName: PChar): HResult; stdcall;
    function ParentMenu: ITBPMenu; stdcall;

    function TopMenuCount: Integer; stdcall;
    function GetTopMenuName(Index: Integer; Buf: PChar; BufSize: Integer): Integer; stdcall;
    function GetTopMenuAt(Index: Integer): ITBPMenu; stdcall;
    function GetTopMenu(MenuName: PChar): ITBPMenu; stdcall;}
  end;

  (**
    Interface that represents part of RFC822 message.
    There are methods to get part's parameters and to get subparts.
    Message contents also can be saved in encoded/decoded forms.
  *)
  ITBPMessagePart = interface(ITBPStringProvider) [SIID_TBPMessagePart]

    (**
      Indicates the number of subparts in this part.
      @return Number of subparts.
              E_FAIL in case of failure
    *)
    function PartCount: Integer; stdcall;

    (**
      Gets interface of subpart with given Index.
      @param Index Index of subpart to be returned, where 0 is the index of
                   the first subpart, 1 is the index of the second and
                   so on.
      @param Part [out] Buffer in which interface pointer will be stored.
                        In case of failure it is set to nil.
      @return S_OK if successful
              E_INVALIDARG if specified Index is invalid
              E_FAIL in case of failure
    *)
    function GetPart(const Index: Integer;
      out Part: ITBPMessagePart): HRESULT; stdcall;

    (**
      Gets interface of embedded message.
      @param MessageStructure [out] Buffer in which interface pointer will be
                                    stored. In case when part Content-Type is
                                    not "message" is is set to nil. In case of
                                    failure it is also set to nil.
      @return S_OK if successful
              S_FALSE if part Content-Type is not "message"
              E_FAIL in case of failure
    *)
    function GetNestedMessage(
      out MessageStructure: ITBPMessageStructure): HRESULT; stdcall;

    (**
      Returns offset of this part from the beginning of message.
      @return Offset of this part
    *)
    function Start: Integer; stdcall;

    (**
      Returns size of the header of this part.
      @return Size of the header
    *)
    function HeaderSize: Integer; stdcall;

    (**
      Returns size of this part including header.
      @return Size of this part
    *)
    function Size: Integer; stdcall;

    (**
      Returns number of lines in the header of this part.
      @return Number of lines in the header
    *)
    function HeaderLines: Integer; stdcall;

    (**
      Returns number of lines in this part including header.
      @return Number of lines in this part
    *)
    function Lines: Integer; stdcall;

    (**
      Returns CRC32 of content type value string.
      Use midxContentType index to get string representation.
      @return CRC32 of content type
    *)
    function ContentTypeID: Cardinal; stdcall;

    (**
      Returns CRC32 of content sub-type value string.
      Use midxContentSubType index to get string representation.
      @return CRC32 of content sub-type
    *)
    function ContentSubTypeID: Cardinal; stdcall;

    (**
      Returns CRC32 of encoding value string.
      Use midxEncoding index to get string representation.
      @return CRC32 of encoding
    *)
    function EncodingID: Cardinal; stdcall;

    (**
      Returns CRC32 of content disposition value string.
      Use midxContentDisposition index to get string representation.
      @return CRC32 of content disposition
    *)
    function DispositionID: Cardinal; stdcall;

    (**
      Returns CRC32 of charset value string.
      Use midxCharset index to get string representation.
      @return CRC32 of charset
    *)
    function CharsetID: Cardinal; stdcall;

    (**
      Saves part content into stream without decoding.
      @param Stream Interface of stream in which part content must be
                    stored.
      @param Offset Offset from part start.
      @param Count Number of bytes to be stored.
      @return S_OK if successful
              E_INVALIDARG if specified Offset or Count are invalid
              E_FAIL in case of failure
    *)
    function SaveContentToStream(const Stream: IStream;
      const Offset, Count: Integer): HRESULT; stdcall;

    (**
      Saves part content into stream in decoded form.
      @param Stream Interface of stream in which part content must be
                    stored.
      @return S_OK if successful
              E_FAIL in case of failure
    *)
    function SaveDecodedToStream(const Stream: IStream): HRESULT; stdcall;

    (**
      Indicates the number of unparsed fields in part's header.
      Most of useful fields are parsed and accessible via indexes. All other
      parts remain unparsed and can be accesses as strings.
      @return Number of unparsed fields.
              E_FAIL in case of failure
    *)
    function UnparsedCount: Integer; stdcall;

    (**
      Gets string representation of unparsed field name with given Index.
      @param Index Index of unparsed field to be returned, where 0 is the
                   index of the first field, 1 is the index of the second and
                   so on.
      @param P Pointer to buffer for the resulting string
      @param MaxStringLenChars Maximum string length in characters which can
                               be stored in buffer
      @param StringLenChars [out] A buffer in which to return actual size of
                                  the string in characters. Set to 0 if
                                  string with such Index doesn't exist.
      @return S_OK if successful
              E_INVALIDARG if specified Index is invalid
              TYPE_E_BUFFERTOOSMALL if supplied buffer is too small to get
                                    whole string
              E_FAIL in case of failure
    *)
    function GetUnparsedField(const Index: Integer; const P: PChar;
      const MaxStringLenChars: Cardinal;
      out StringLenChars: Cardinal): HRESULT; stdcall;

    (**
      Gets string representation of unparsed field value with given Index.
      @param Index Index of unparsed field to be returned, where 0 is the
                   index of the first field, 1 is the index of the second and
                   so on.
      @param P Pointer to buffer for the resulting string
      @param MaxStringLenChars Maximum string length in characters which can
                               be stored in buffer
      @param StringLenChars [out] A buffer in which to return actual size of
                                  the string in characters. Set to 0 if
                                  string with such Index doesn't exist.
      @return S_OK if successful
              E_INVALIDARG if specified Index is invalid
              TYPE_E_BUFFERTOOSMALL if supplied buffer is too small to get
                                    whole string
              E_FAIL in case of failure
    *)
    function GetUnparsedValue(const Index: Integer; const P: PChar;
      const MaxStringLenChars: Cardinal;
      out StringLenChars: Cardinal): HRESULT; stdcall;

    (**
      Returns part in which this part is a subpart.
      @param Part [out] Buffer in which interface pointer will be stored.
                        In case when this part is root level it is set
                        to nil. In case of failure it is also set to nil.
      @return S_OK if successful
              S_FALSE if this part is root level
              E_FAIL in case of failure
    *)
    function GetParentPart(out Part: ITBPMessagePart): HRESULT; stdcall;

    (**
      Returns message structure to which this part belong.
      @param MessageStructure [out] Buffer in which interface pointer will be
                                    stored. In case when there is no parent
                                    message structure it is set to nil. In case
                                    of failure it is also set to nil.
      @return S_OK if successful
              S_FALSE if there is no parent message structure
              E_FAIL in case of failure
    *)
    function GetParentMessageStructure(
      out MessageStructure: ITBPMessageStructure): HRESULT; stdcall;

    (**
      Returns interface of message to which message structure is linked.
      In order to get encoded/decoded part contents it is needed to be linked
      either to message or to stream.
      @param Message [out] Buffer in which interface pointer will be stored.
                           In case when part in not linked to message it is
                           set to nil. In case of failure it is also set to
                           nil.
      @return S_OK if successful
              S_FALSE if part is not linked to message
              E_FAIL in case of failure
    *)
    function GetParentMessage(out Message: ITBPMessage): HRESULT; stdcall;

    (**
      Links/unlinks message structure to the Message.
      In order to get encoded/decoded part contents it is needed to be linked
      either to message or to stream.
      @param Message Interface of message to which structure must be linked.
                     If this parameter is nil then structure will not be
                     linked to any message.
      @return S_OK if successful
              E_INVALIDARG if specified Message is invalid
              E_FAIL in case of failure
    *)
    function SetParentMessage(const Message: ITBPMessage): HRESULT; stdcall;

    (**
      Returns interface of stream to which message structure is linked.
      In order to get encoded/decoded part contents it is needed to be linked
      either to message or to stream.
      @param Stream [out] Buffer in which interface pointer will be stored.
                          In case when part in not linked to stream it is
                          set to nil. In case of failure it is also set to
                          nil.
      @return S_OK if successful
              S_FALSE if part is not linked to stream
              E_FAIL in case of failure
    *)
    function GetParentStream(out Stream: IStream): HRESULT; stdcall;

    (**
      Links/unlinks message structure to the stream.
      In order to get encoded/decoded part contents it is needed to be linked
      either to message or to stream.
      @param Stream Interface of stream to which structure must be linked.
                    If this parameter is nil then structure will not be
                    linked to any stream.
      @return S_OK if successful
              E_INVALIDARG if specified Stream is invalid
              E_FAIL in case of failure
    *)
    function SetParentStream(const Stream: IStream): HRESULT; stdcall;

  end;

  (**
    Interface that represents structure of RFC822 message.
    This interface inherits methods from ITBPMessagePart and in addition
    provode method to access address lists of message (From, To, CC, etc.)
  *)
  ITBPMessageStructure = interface(ITBPMessagePart) [SIID_TBPMessageStructure]

    (**
      Gets interface of address list with given Index.
      Use medx* constants as Index.
      @param Index Index of address list to be returned.
      @param AddressList [out] Buffer in which interface pointer will be
                               stored. In case when there is no such list
                               in message header it is set to nil. In case of
                               failure it is also set to nil.
      @return S_OK if successful
              S_FALSE if requested list is not present in message header
                      (there is no such field)
              E_INVALIDARG if specified Index is invalid
              E_FAIL in case of failure
    *)
    function GetAddressList(const Index: Integer;
      out AddressList: ITBPAddressList): HRESULT; stdcall;

    (**
      Gets date/time from "Date" field of message header.
      @param Date [out] Buffer in which date/time will be stored.
                        Date/time is converted to local time of current
                        system. Contains a 64-bit value representing the
                        number of 100-nanosecond intervals since
                        January 1, 1601 (UTC).
      @return S_OK if successful
              E_FAIL in case of failure
    *)
    function GetDate(out Date: Int64): HRESULT; stdcall;

    (**
      Gets date/time and time zone offset from "Date" field of message header.
      @param Date [out] Buffer in which date/time will be stored.
                        Date/time is the same as as present in message header.
                        Contains a 64-bit value representing the
                        number of 100-nanosecond intervals since
                        January 1, 1601 (UTC).
      @param TimeZoneOffset [out] Buffer in which Time Zone Offset will be
                                  stored. It's an offset from UTC in minutes.
      @return S_OK if successful
              S_FALSE if "Date" field is not present in message header
              E_FAIL in case of failure
    *)
    function GetDateEx(out Date: Int64;
      out TimeZoneOffset: Integer): HRESULT; stdcall;

  end;

  {ITBPMessageFrame = interface [SIID_TBPMessageFrame]
    function RegisterHook(EventID: Integer; Hook: ITBPDataHook): Integer; stdcall;
    function UnregisterHook(HookID: Integer): HResult; stdcall;
    function GetCurrentPart(out Viewer: ITBPMessagePart): HResult; stdcall;
    function EnumTabbedParts(out Cursor: ITBPCursor): HRESULT; stdcall;
    function AddTabbedPart(APart: ITBPMessagePart): HResult; stdcall;
    function HideTabbedPart(APartID: PChar): HResult; stdcall;
  end;}

  (**
    UNDER CONSTRUCTION
    Main interface to provide access to all other functionality
  *)
  ITBPCoreBridge = interface [SIID_TBPCoreBridge]

    (**
      Gets string with version info about host application with given ID into
      buffer.
      TBPHelpers unit contains TBPGetVerInfo function to get this value as
      string.
      Use vinf* constants as IDs for this function.
      @param ID Identifier of version string
      @param P Pointer to buffer for the resulting string
      @param MaxStringLenChars Maximum string length in characters which can
                               be stored in buffer
      @param StringLenChars [out] A buffer in which to return actual size of
                                  the string in characters. Set to 0 if
                                  string with such ID doesn't exist.
      @return S_OK if successful
              E_INVALIDARG if specified ID is invalid
              TYPE_E_BUFFERTOOSMALL if supplied buffer is too small to get
                                    whole string
              E_FAIL in case of failure
    *)
    function GetVersionInfo(const ID: Integer; const P: PWideChar;
      const MaxStringLenChars: Cardinal;
      out StringLenChars: Cardinal): HRESULT; stdcall;

    (**
      Gets string with registration info about host application with given ID
      into buffer.
      TBPHelpers unit contains TBPGetRegInfo function to get this value as
      string.
      Use rinf* constants as IDs for this function.
      @param ID Identifier of registration string
      @param P Pointer to buffer for the resulting string
      @param MaxStringLenChars Maximum string length in characters which can
                               be stored in buffer
      @param StringLenChars [out] A buffer in which to return actual size of
                                  the string in characters. Set to 0 if
                                  string with such ID doesn't exist.
      @return S_OK if successful
              E_INVALIDARG if specified ID is invalid
              TYPE_E_BUFFERTOOSMALL if supplied buffer is too small to get
                                    whole string
              E_FAIL in case of failure
    *)
    function GetRegistrationInfo(const ID: Integer; const P: PWideChar;
      const MaxStringLenChars: Cardinal;
      out StringLenChars: Cardinal): HRESULT; stdcall;

    (**
      Indicates the number of accounts.
      @return Number of accounts.
              E_FAIL in case of failure
    *)
    function AccountCount: Integer; stdcall;

    (**
      Gets interface of account with given Index.
      @param Index Index of account to be returned, where 0 is the index of
                   the first account, 1 is the index of the second and
                   so on.
      @param Account [out] Buffer in which interface pointer will be stored.
                           In case of failure it is set to nil.
      @return S_OK if successful
              E_INVALIDARG if specified Index is invalid
              E_FAIL in case of failure
    *)
    function GetAccount(const Index: Integer;
      out Account: ITBPAccount): HRESULT; stdcall;

    (**
      Gets interface of account with given Name.
      @param Name Name of account to be returned.
      @param Account [out] Buffer in which interface pointer will be stored.
                           In case of failure it is set to nil.
      @return S_OK if successful
              E_INVALIDARG if specified Name is invalid
              E_FAIL in case of failure
    *)
    function GetAccountByName(const Name: PWideChar;
      out Account: ITBPAccount): HRESULT; stdcall;

    (**
      Gets interface of folder with given full name.
      @param FullName Full name (with path) of folder to be returned.
                      For example: \\Account\Folder\SubFolder
      @param Folder [out] Buffer in which interface pointer will be stored.
                           In case of failure it is set to nil.
      @return S_OK if successful
              E_INVALIDARG if specified FullName is invalid
              E_FAIL in case of failure
    *)
    function GetFolderByFullName(const FullName: PWideChar;
      out Folder: ITBPFolder): HRESULT; stdcall;

    (**
      Gets interface of currently selected account.
      @param Account [out] Buffer in which interface pointer will be stored.
                           I case when there is no account selected it is
                           set to nil. In case of failure it is also set to
                           nil.
      @return S_OK if successful
              E_FAIL in case of failure
    *)
    function GetCurAccount(out Account: ITBPAccount): HRESULT; stdcall;

    (**
      Gets interface of currently selected folder.
      @param Folder [out] Buffer in which interface pointer will be stored.
                          I case when there is no folder selected it is
                          set to nil. In case of failure it is also set to
                          nil.
      @return S_OK if successful
              E_FAIL in case of failure
    *)
    function GetCurFolder(out Folder: ITBPFolder): HRESULT; stdcall;

    (**
      Gets interface of currently selected message.
      @param Message [out] Buffer in which interface pointer will be stored.
                           I case when there is no message selected it is
                           set to nil. In case of failure it is also set to
                           nil.
      @return S_OK if successful
              E_FAIL in case of failure
    *)
    function GetCurMessage(out Message: ITBPMessage): HRESULT; stdcall;

    (**
      Gets interface of list of selected messages.
      @param MessageList [out] Buffer in which interface pointer will be
                               stored. In case of failure it is set to nil.
      @return S_OK if successful
              E_FAIL in case of failure
    *)
    function GetSelectedMessages(
      out MessageList: ITBPMessageList): HRESULT; stdcall;

    (**
      UNDER CONSTRUCTION
    *)
    function CreateAccount(): HRESULT; stdcall;

    (**
      Creates folder with given full name.
      @param FullName Full name (with path) of folder to be created.
                      For example: \\Account\Folder\SubFolder
      @param FocusOn If True new folder will get focus.
      @param Folder [out] Buffer in which interface pointer will be stored.
                          In case of failure it is set to nil.
      @return S_OK if successful
              E_INVALIDARG if specified FullName is invalid
              E_FAIL in case of failure
    *)
    function CreateFolder(const FullName: PWideChar; const FocusOn: LongBool;
      out Folder: ITBPFolder): HRESULT; stdcall;

    (**
      Gets interface to sign, verify signature, encrypt, decrypt data.
      @param CryptoInterface [out] Buffer in which interface pointer will be
                                   stored. In case of failure it is set to nil.
      @return S_OK if successful
              E_FAIL in case of failure
    *)
    function GetCryptoInterface(out CryptoInterface: ITBPCrypto): HRESULT; stdcall;

    (**
      Registers plugin handler to receive notifications about events with
      specified EventID.
      Use TBP_EVT_* constants as EventID.
      @param EventID Identifier of the event to get notifications about
      @param Parameters Parameters of registered handler. Can be nil if there
                        are no parameters needed.
      @param EventNotificator Interface if plugin handler which will receive
                              notifications.
      @return S_OK if successful
              E_INVALIDARG if specified EventID or Parameters are invalid
              E_FAIL in case of failure
    *)
    function RegisterNotification(const EventID: Integer;
      const Parameters: ITBPDataProvider;
      const EventNotificator: ITBPEventNotificator): HRESULT; stdcall;

    (**
      Unregisters plugin handler to receive notifications about events with
      specified EventID.
      Arguments for this method must be exacly the same as was used with
      RegisterNotification.
      Use TBP_EVT_* constants as EventID.
      @param EventID Identifier of the event to get notifications about
      @param Parameters Parameters of registered handler. Can be nil if there
                        are no parameters needed.
      @param EventNotificator Interface if plugin handler which was used to
                              receive notifications.
      @return S_OK if successful
              E_INVALIDARG if specified EventID or Parameters are invalid
              E_FAIL in case of failure
    *)
    function UnregisterNotification(const EventID: Integer;
      const Parameters: ITBPDataProvider;
      const EventNotificator: ITBPEventNotificator): HRESULT; stdcall;

    (**
      Creates interface to store ANSI and Unicode strings.
      @param StringProvider [out] Buffer in which interface pointer will be
                                  stored. In case of failure it is set to nil.
      @return S_OK if successful
              E_FAIL in case of failure
    *)
    function CreateStringProvider(
      out StringProvider: ITBPStringProvider): HRESULT; stdcall;

    (**
      Creates interface to store data of various types.
      @param DataProvider [out] Buffer in which interface pointer will be
                                stored. In case of failure it is set to nil.
      @return S_OK if successful
              E_FAIL in case of failure
    *)
    function CreateDataProvider(
      out DataProvider: ITBPDataProvider): HRESULT; stdcall;

    (**
      Creates interface to store list of messages.
      @param MessageList [out] Buffer in which interface pointer will be
                               stored. In case of failure it is set to nil.
      @return S_OK if successful
              E_FAIL in case of failure
    *)
    function CreateMessageList(
      out MessageList: ITBPMessageList): HRESULT; stdcall;

    (**
      Creates interface to store list of e-mail addresses.
      @param AddressList [out] Buffer in which interface pointer will be
                               stored. In case of failure it is set to nil.
      @return S_OK if successful
              E_FAIL in case of failure
    *)
    function CreateAddressList(
      out AddressList: ITBPAddressList): HRESULT; stdcall;

    (**
      Creates interface representing empty structure of message.
      Structure can be loaded using LoadFromStream method.
      @param MessageStructure [out] Buffer in which interface pointer will be
                                    stored. In case of failure it is set to
                                    nil.
      @return S_OK if successful
              E_FAIL in case of failure
    *)
    function CreateMessageStructure(
      out MessageStructure: ITBPMessageStructure): HRESULT; stdcall;

    (**
      Gets interface representing structure of message from stream.
      @param Stream Interface of stream to get data from
      @param MessageStructure [out] Buffer in which interface pointer will
                                    be stored. In case of failure it is set
                                    to nil.
      @return S_OK if successful
              E_FAIL in case of failure
    *)
    function GetMessageStructureFromStream(const Stream: IStream;
      out MessageStructure: ITBPMessageStructure): HRESULT; stdcall;

    (**
      Indicates the number of address books.
      @return Number of address books.
              E_FAIL in case of failure
    *)
    function AddressBookCount: Integer; stdcall;

    (**
      Gets interface of address book with given Index.
      @param Index Index of address book to be returned, where 0 is the index
                   of the first address book, 1 is the index of the second and
                   so on.
      @param AddressBook [out] Buffer in which interface pointer will be
                               stored. In case of failure it is set to nil.
      @return S_OK if successful
              E_INVALIDARG if specified Index is invalid
              E_FAIL in case of failure
    *)
    function GetAddressBook(const Index: Integer;
      out AddressBook: ITBPAddressBook): HRESULT; stdcall;

    (**
      Shows editor of the list of e-mail addresses.
      This editor allow to move address between address list and address
      book.
      @param Account Account which is used to store position in address book
      @param AddressList Address list to be edited
      @return S_OK if list was successfuly edited
              S_FALSE if list editing was canceled by user
              E_INVALIDARG if specified AddressList is invalid
              E_FAIL in case of failure
    *)
    function EditAddressList(const Account: ITBPAccount;
      const AddressList: ITBPAddressList): HRESULT; stdcall;

    (**
      Shows editor of the lists of e-mail addresses.
      This editor allow to move address between address lists and address
      book.
      @param Account Account which is used to store position in address book
      @param TabIndex Index of selected tab in editor
      @param ToList List of "To" addresses to be edited
      @param CCList List of "CC" addresses to be edited
      @param BCCList List of "BCC" addresses to be edited
      @return S_OK if list was successfuly edited
              S_FALSE if list editing was canceled by user
              E_INVALIDARG if specified ToList, CCList or BCCList are invalid
              E_FAIL in case of failure
    *)
    function EditAddressLists(const Account: ITBPAccount;
      const TabIndex: Integer;
      const ToList, CCList, BCCList: ITBPAddressList): HRESULT; stdcall;

    (**
      Loads icons definitions from xml-file.
      This file has batskin format.
      See "Specification for writing custom interface skins for The Bat!"
      @param XmlFileName Name of xml-file to load definitions from
      @return S_OK if successful
              E_FAIL in case of failure
    *)
    function LoadGlyphs(const XmlFileName: PWideChar): HRESULT; stdcall;

    (**
      Gets interface of form menu collection with given MenuID.
      @param MenuID Identifier of form menu collection. Use TBP_MNID_*
                    constants.
      @param MenuInterface [out] Buffer in which interface pointer will be
                                 stored. In case of failure it is set to nil.
      @return S_OK if successful
              E_INVALIDARG if specified MenuID is invalid
              E_FAIL in case of failure
    *)
    function GetMenuInterface(const MenuID: Cardinal;
      out MenuInterface: ITBPMenu): HRESULT; stdcall;

    (**
      Add X509 certificate to "Trusted Root CA".
      Certificate must be DER encoded. If certificate doesn't have CA = True
      in Basic Constraints then it will be added to currently selected address
      book.
      @param CertBuf Pointer to buffer with certificate to be added
      @param CertBufSize Size of buffer with certificate
      @return S_OK if successful
              S_FALSE if certificate already exists
              E_INVALIDARG if specified certificate is invalid
              E_FAIL in case of failure
    *)
    function AddCertificateToTrusted(const CertBuf: Pointer;
      const CertBufSize: Integer): HRESULT; stdcall;

    (**
      Gets interface of container object with program preferences.
      @param Prefs [out] Buffer in which interface pointer will be
                         stored. In case of failure it is set to nil.
      @return S_OK if successful
              E_FAIL in case of failure
    *)
    function GetPreferences(out Prefs: ITBPDataProvider): HRESULT; stdcall;

    (**
      Creates empty address book.
      @param Name Name of address book to be created
      @param FileName File name to store resulted address book in.
                      If empty string is specified then file name will be
                      automatically generated.
      @param AddrBook [out] Buffer in which interface pointer will be stored.
                            In case of failure it is set to nil.
      @return S_OK if successful
              E_FAIL in case of failure
    *)
    function CreateAddressBook(const Name, FileName: PWideChar;
      out AddrBook: ITBPAddressBook): HRESULT; stdcall;

      
    (* Methods to be added *)
    //function SetCurAccount(): HRESULT; stdcall;
    //function SetCurFolder(): HRESULT; stdcall;
    //function SetCurMessage(): HRESULT; stdcall;
    //function SetSelectedMessages(): HRESULT; stdcall;
    // function DrawGlyph(): HRESULT; stdcall;

    (* Methods that must be reviewed *)
    {function EnumViewers(out Cursor: ITBPCursor): HRESULT; stdcall;
    function GetViewerInterface(const ViewerName: PWideChar; out ViewerInterface: ITBPViewer): HRESULT; stdcall;
    function EnumEditors(out Cursor: ITBPCursor): HRESULT; stdcall;
    function GetEditorInterface(const EditorName: PWideChar; out EditorInterface: ITBPEditor): HRESULT; stdcall;
    function GetStatus(out Status: Integer): HRESULT; stdcall;}
  end;

implementation

end.
