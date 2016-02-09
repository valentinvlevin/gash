object frmExportImport: TfrmExportImport
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu, biMinimize]
  Caption = #1055#1088#1080#1077#1084' '#1092#1072#1081#1083#1072' '#1089' '#1088#1077#1079#1091#1083#1100#1090#1072#1090#1072#1084#1080
  ClientHeight = 245
  ClientWidth = 480
  Color = clBtnFace
  Constraints.MaxHeight = 284
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poDesktopCenter
  DesignSize = (
    480
    245)
  PixelsPerInch = 96
  TextHeight = 13
  object lblFilePath: TLabel
    Left = 10
    Top = 8
    Width = 112
    Height = 13
    Caption = #1060#1072#1081#1083' '#1089' '#1088#1077#1079#1091#1083#1100#1090#1072#1090#1072#1084#1080':'
  end
  object edFilePath: TFilenameEdit
    Left = 10
    Top = 24
    Width = 462
    Height = 21
    OnAfterDialog = edFilePathAfterDialog
    DefaultExt = 'ocn'
    FileEditStyle = fsComboBox
    Filter = #1060#1072#1081#1083' '#1088#1077#1079#1091#1083#1100#1090#1072#1090#1086#1074' (*.ocn)|*.ocn|'#1042#1089#1077' '#1092#1072#1081#1083#1099' (*.*)|*.*'
    DialogOptions = [ofHideReadOnly, ofPathMustExist, ofFileMustExist]
    DirectInput = False
    Anchors = [akLeft, akTop, akRight]
    NumGlyphs = 1
    TabOrder = 0
  end
  object pnlBottom: TPanel
    Left = 0
    Top = 209
    Width = 480
    Height = 36
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 2
    object pnlButtons: TPanel
      Left = 255
      Top = 0
      Width = 225
      Height = 36
      Align = alRight
      BevelOuter = bvNone
      TabOrder = 0
      object btnImport: TBitBtn
        Left = 3
        Top = 6
        Width = 97
        Height = 25
        Caption = #1055#1088#1080#1085#1103#1090#1100
        DoubleBuffered = True
        ParentDoubleBuffered = False
        TabOrder = 0
        OnClick = btnImportClick
      end
      object btnClose: TBitBtn
        Left = 118
        Top = 6
        Width = 97
        Height = 25
        Cancel = True
        Caption = #1047#1072#1082#1088#1099#1090#1100
        DoubleBuffered = True
        Glyph.Data = {
          36030000424D3603000000000000360000002800000010000000100000000100
          1800000000000003000000000000000000000000000000000000FFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFEFFFFFFFFE5CBEF7D40F3A37BFAD1BCFEF6F2FFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF9F7F7F2F2F4F5C998EB
          5200E84C00E9560BEC6927F19060F6BA9AFAE3D8F4F5F7FEFEFEFFFFFFFFFFFF
          FAFBFCFFFFFF8E9FBC0D1032845624F96817E6540CE9560BE85206E74C00EC4F
          00D85010394E74F0F7FCFFFFFFFEFEFFF9FAFCFFFFFF889BBC0001267C4D1AF9
          6615E55007E9570DE9580EE85911EE5B11D94D0C2E456EEFF7FBFFFFFFFFFFFF
          FFFFFEFFFFFF8FA6C101072D7F501EFC7F38E55D1AE9560CE9560DE95710ED5A
          0FDB5111334E76EFF7FBF7F7FDE2E2F7EAEAF7938FE83F56B900152B7B4E1EFF
          9150F1793FEC7031EA5B14E9570FEE5A11DB521235527BEFF6FB9494E66060E2
          5758E84B4AE6595DF1091A627F4D18D9976DAA6C4AF68046EC763CE95D17ED59
          10DB5515365781EEF6FA8484E29B9BF39596FB797AF98986FF1A21937C4D1AE0
          A57CC38A6DF5844CEE8450ED753CED5B13DC5518395C89EEF5FAC2C2F18A8AE3
          9898E55F5BDA576ADD001A3B794E1CFFA56EF49061EF8E5EF08855EE8653F06C
          2CDD55173B638FEEF5FAFFFFFFFFFFFFFFFFFFD8D4F6779ED500193A7D4F1EFE
          AD7CED9871F29569F19061EF8C5DF28048DE5B1F3F6895EEF5F9FDFDFEFBFBFE
          F7F8FCFFFFFF9FC6E600133C7E501EFFB586EFA07BF29D74F1986DF09266F48E
          5CE06730406D99EDF5F9FFFFFFFFFFFFFBFCFEFDFDFF9BC5EA00183F7D4F1EFB
          B98FEDA685F3A47EF29F77F19A70F5976AE1724042719EEDF5F9FFFFFFFFFFFF
          FBFDFEFFFFFF9ECBF0001942815220FFD2A4FDB99AF8B090F3A784ED9E79F49F
          77E37C4D4475A1EDF5F9FFFFFFFFFFFFFBFDFEFFFFFF9DCDF40125482718097D
          5F40BA8965E9A97EFFB68DFFB78DFFAE86E77C4E4779A7EDF4F9FFFFFFFFFFFF
          FBFDFEFFFFFF9CCEF6002C4F00000400000000020212100C503F2C846346C590
          69DC87564479A8EDF3F8FFFFFFFFFFFFFBFDFEFFFFFF9CCCF11C74BA2F7BB52F
          7CB82A78B62675B31C6DAE176BAB2E7BB53984BB3D89C4F3F7FB}
        ModalResult = 2
        ParentDoubleBuffered = False
        TabOrder = 1
      end
    end
  end
  object gbFileParams: TGroupBox
    Left = 12
    Top = 57
    Width = 462
    Height = 150
    Anchors = [akLeft, akTop, akRight]
    Caption = #1055#1072#1088#1072#1084#1077#1090#1088#1099' '#1092#1072#1081#1083#1072' '#1089' '#1088#1077#1079#1091#1083#1100#1090#1072#1090#1072#1084#1080':'
    TabOrder = 1
    DesignSize = (
      462
      150)
    object lblVPT: TLabel
      Left = 12
      Top = 86
      Width = 135
      Height = 13
      Caption = #1055#1088#1077#1076#1085#1072#1079#1085#1072#1095#1077#1085' '#1076#1083#1103' '#1055#1055#1045#1053#1058':'
    end
    object lblDateTimeCreate: TLabel
      Left = 12
      Top = 25
      Width = 141
      Height = 13
      Caption = #1044#1072#1090#1072'/'#1074#1088#1077#1084#1103' '#1092#1086#1088#1084#1080#1088#1086#1074#1072#1085#1080#1103':'
    end
    object lblInfo: TLabel
      Left = 12
      Top = 46
      Width = 88
      Height = 13
      Caption = #1054#1096#1080#1073#1082#1080' '#1074' '#1092#1072#1081#1083#1077':'
    end
    object stVPT: TStaticText
      Left = 12
      Top = 105
      Width = 438
      Height = 30
      Anchors = [akLeft, akTop, akRight]
      AutoSize = False
      BorderStyle = sbsSunken
      Color = clWhite
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentColor = False
      ParentFont = False
      TabOrder = 0
    end
    object stDateTimeCreate: TStaticText
      Left = 159
      Top = 24
      Width = 146
      Height = 17
      Alignment = taCenter
      AutoSize = False
      BorderStyle = sbsSunken
      Color = clWhite
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentColor = False
      ParentFont = False
      TabOrder = 1
    end
    object stInfo: TStaticText
      Left = 106
      Top = 47
      Width = 344
      Height = 33
      Anchors = [akLeft, akTop, akRight]
      AutoSize = False
      BorderStyle = sbsSunken
      Color = clWhite
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentColor = False
      ParentFont = False
      TabOrder = 2
    end
  end
  object fdQry: TADQuery
    Connection = DM.udCon
    FetchOptions.AssignedValues = [evRecordCountMode]
    FetchOptions.RecordCountMode = cmTotal
    Left = 248
  end
  object HTTPRIO: THTTPRIO
    HTTPWebNode = HTTPReqResp
    Converter.Options = [soSendMultiRefObj, soTryAllSchema, soRootRefNodesToBody, soCacheMimeResponse, soUTF8EncodeXML]
    Left = 176
  end
  object HTTPReqResp: THTTPReqResp
    UserName = '701'
    Password = 'password'
    UseUTF8InHeader = True
    InvokeOptions = [soIgnoreInvalidCerts, soAutoCheckAccessPointViaUDDI]
    WebNodeOptions = []
    Left = 176
    Top = 72
  end
end
